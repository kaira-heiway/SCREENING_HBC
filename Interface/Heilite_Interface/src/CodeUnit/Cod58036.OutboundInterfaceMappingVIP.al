codeunit 58036 "Outbound Interface Mapping VIP"
{
    // Heilite Navision Old Id - 50079
    // version HEI.04

    // HEI.01 HT1010 IBM NASTAA02 28.11.2019 # Maraki dedicated Job Queue - CHG2039961
    //   # New Codeunit created
    // HEI.02 CHG2095187 IBM SAXENA03 08.02.2021
    //   # Code written for Paraller Request
    //   # Added RESET, SetCurrentKey & FINDSET(FALSE,FALSE)function in Function OnRun(), InsertDataExchLineForXML(), ProcessColumnMapping & PrepopulateColumns().
    //   # Created a new function NoDataExchLineDefCheck() and added into  OnRUN().
    //   # Added and calling function InsertRec2 from PrepopulateColumns.
    //   # Replaced DataExch. record table with DataExch.VIP In CodeUnit Property TableNo
    //   # Replaced DataExch. record table with DataExch.VIP In OnRun()
    //   # Replaced DataExch. record table with DataExch.VIP In InsertDataExchLineForXML()
    //   # Replaced DataExch. record table with DataExch.VIP In ProcessColumnMapping()
    //   # Replaced DataExch. record table with DataExch.VIP In PrepopulateColumns()
    // HEI.03 CC CHG2236214 IBM BHANDS01 30.01.2024 Outbound interfaces are impacted by date format changes when Job Queues are restarted
    //   # Issue with LSR Interfaces in Bahamas
    //   # Added code in function DateTimeFormatting()
    // HEI.04 CC CHG2249162 IBM BHANDS01 25.04.2024 Outbound interfaces are impacted by date format changes when Job Queues are restarted
    //   # Issue with ASTRO-SO in Ethiopia
    //   # Added code in function DateTimeFormatting()

    //BC Upgrade VAMSIU01 >>
    // TableNo = "Data Exch. VIP";
    TableNo = "Data Exch.";
    //BC Upgrade VAMSIU01 <<

    trigger OnRun();
    var
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        //BC Upgrade VAMSIU01 >>
        //DataExchVIP: Record "Data Exch. VIP";
        DataExchVIP: Record "Data Exch.";
        //BC Upgrade VAMSIU01 <<
        RecordRef: RecordRef;
        Window: Dialog;
        LineNo: Integer;
    begin
        //<<HEI.02
        /*
        IF NoDataExchLineDef("Data Exch. Def Code") THEN
          EXIT;
        */
        if NoDataExchLineDefCheck(Rec."Data Exch. Def Code") then
            exit;
        //>>HEI.02

        if GUIALLOWED then
            Window.OPEN(ProgressMsg);

        // Range through the line types, Look at details...
        LineNo := 1;

        //<<HEI.02
        InterfaceEntryHeaderVIP.RESET;
        InterfaceEntryHeaderVIP.SETCURRENTKEY("Data Exch. Entry No.");
        //>>HEI.02
        InterfaceEntryHeaderVIP.SETRANGE("Data Exch. Entry No.", Rec."Entry No.");
        //<<HEI.02
        //IF InterfaceEntryHeaderVIP.FINDSET THEN
        if InterfaceEntryHeaderVIP.FINDSET(false) then
            //>>HEI.02
            repeat
                if GUIALLOWED then
                    Window.UPDATE(1, LineNo);
                //<<HEI.02
                //DataExch.SETRANGE("Entry No.","Entry No.");
                //IF DataExch.FINDFIRST THEN BEGIN
                DataExchVIP.SETRANGE("Entry No.", Rec."Entry No.");
                if DataExchVIP.FINDFIRST then begin
                    //>>HEI.02
                    RecordRef.GETTABLE(InterfaceEntryHeaderVIP);
                    //>>HEI.02
                    InsertDataExchLineForXML(
                      DataExchVIP,
                      LineNo,
                      RecordRef);
                    LineNo := LineNo + 1;
                    //<<HEI.02
                end;
            until InterfaceEntryHeaderVIP.NEXT = 0;

        //<<HEI.02
        InterfaceEntryLineVIP.RESET;
        InterfaceEntryLineVIP.SETCURRENTKEY("Data Exch. Entry No.");
        //>>HEI.02
        InterfaceEntryLineVIP.SETRANGE("Data Exch. Entry No.", Rec."Entry No.");
        //<<HEI.02
        //IF InterfaceEntryLineVIP.FINDSET THEN
        if InterfaceEntryLineVIP.FINDSET(false) then
            //>>HEI.02
            repeat
                if GUIALLOWED then
                    Window.UPDATE(1, LineNo);
                //<<HEI.02
                /*
                DataExch.SETRANGE("Entry No.","Entry No.");
                IF DataExch.FINDFIRST THEN BEGIN
                */
                DataExchVIP.SETRANGE("Entry No.", Rec."Entry No.");
                if DataExchVIP.FINDFIRST then begin
                    //>>HEI.02
                    RecordRef.GETTABLE(InterfaceEntryLineVIP);
                    //<<HEI.02

                    InsertDataExchLineForXML(
                    DataExchVIP,
                    LineNo,
                    RecordRef);

                    //>>HEI.02
                    LineNo := LineNo + 1;
                end;
            until InterfaceEntryLineVIP.NEXT = 0;

        if GUIALLOWED then
            Window.CLOSE;

    end;

    var
        ProgressMsg: Label 'Processing line no. #1######.';
        FormatNotDefinedErr: TextConst Comment = '%1 = Data Exch. Def. Code', ENU = 'You must choose a valid export format for the bank account. Format %1 is not correctly defined.';
        DataExchLineDefNotFoundErr: TextConst Comment = '%1=Data Exch. Def. Name;%2=Data Exch. Line Def. Code', ENU = 'The %1 export format does not support the Payment Method Code %2.';
        IncorrectLengthOfValuesErr: TextConst Comment = '%1=Data Exch.Def Type;%2=Data Exch. Def Code;%3=Field;%4=Expected length;%5=Actual length;%6=Actual Value', ENU = 'The payment that you are trying to export is different from the specified %1, %2.\\The value in the %3 field does not have the length that is required by the export format. \Expected: %4 \Actual: %5 \Field Value: %6.';

    local procedure NoDataExchLineDef(DataExchDefCode: Code[20]): Boolean;
    var
        DataExchLineDef: Record "Data Exch. Line Def";
    begin
        DataExchLineDef.INIT;
        DataExchLineDef.SETRANGE("Data Exch. Def Code", DataExchDefCode);
        DataExchLineDef.SETRANGE("Line Type", DataExchLineDef."Line Type"::Detail);
        exit(DataExchLineDef.ISEMPTY);
    end;

    //BC Upgrade VAMSIU01 Changed from Data Exch VIP to Data Exch. in InsertDataExchLineForXML>>
    procedure InsertDataExchLineForXML(var DataExchVIP: Record "Data Exch."; LineNo: Integer; RecRef: RecordRef);
    var
        DataExchMapping: Record "Data Exch. Mapping";
        TableID: Integer;
    begin
        //<<HEI.02
        //DataExchMapping.INIT;
        DataExchMapping.RESET;
        DataExchMapping.SETCURRENTKEY("Data Exch. Def Code", "Data Exch. Line Def Code");
        //DataExchMapping.SETRANGE("Data Exch. Def Code",DataExch."Data Exch. Def Code");
        DataExchMapping.SETRANGE("Data Exch. Def Code", DataExchVIP."Data Exch. Def Code");
        //DataExchMapping.SETRANGE("Data Exch. Line Def Code",DataExch."Data Exch. Line Def Code");
        DataExchMapping.SETRANGE("Data Exch. Line Def Code", DataExchVIP."Data Exch. Line Def Code");
        //>>HEI.02
        if DataExchMapping.FINDFIRST then begin
            TableID := DataExchMapping."Table ID";
            //<<HEI.02
            //ProcessColumnMapping(DataExch,RecRef,LineNo,TableID);
            ProcessColumnMapping(DataExchVIP, RecRef, LineNo, TableID);
            //>>HEI.02
        end;
    end;

    //BC Upgrade VAMSIU01 Changed from Data Exch VIP to Data Exch. in ProcessColumnMapping>>
    local procedure ProcessColumnMapping(var DataExchVIP: Record "Data Exch."; RecRef: RecordRef; LineNo: Integer; TableID: Integer);
    var
        DataExchDef: Record "Data Exch. Def";
        DataExchColumnDef: Record "Data Exch. Column Def";
        //BC Upgrade VAMSIU01 >>
        // DataExchFieldVIP: Record "Data Exch. Field VIP";
        DataExchFieldVIP: Record "Data Exch. Field";
        //BC Upgrade VAMSIU01 <<
        DataExchFieldMapping: Record "Data Exch. Field Mapping";
        TransformationRule: Record "Transformation Rule";
        StringConversionManagement: Codeunit StringConversionManagement;
        ValueAsDestType: Variant;
        FieldRef: FieldRef;
        ValueAsString: Text[250];
    begin
        //<<HEI.02
        /*
        IF NOT DataExchDef.GET(DataExch."Data Exch. Def Code") THEN
          ERROR(FormatNotDefinedErr,DataExch."Data Exch. Def Code");
        PrepopulateColumns(DataExchDef,DataExch."Data Exch. Line Def Code",DataExch."Entry No.",LineNo);
        */
        if not DataExchDef.GET(DataExchVIP."Data Exch. Def Code") then
            ERROR(FormatNotDefinedErr, DataExchVIP."Data Exch. Def Code");
        PrepopulateColumns(DataExchDef, DataExchVIP."Data Exch. Line Def Code", DataExchVIP."Entry No.", LineNo);

        DataExchFieldMapping.RESET;
        DataExchFieldMapping.SETCURRENTKEY("Data Exch. Def Code", "Data Exch. Line Def Code", "Table ID");
        //>>HEI.02
        DataExchFieldMapping.SETRANGE("Data Exch. Def Code", DataExchDef.Code);
        //<<HEI.02
        //DataExchFieldMapping.SETRANGE("Data Exch. Line Def Code",DataExch."Data Exch. Line Def Code");
        DataExchFieldMapping.SETRANGE("Data Exch. Line Def Code", DataExchVIP."Data Exch. Line Def Code");
        //>>HEI.02
        DataExchFieldMapping.SETRANGE("Table ID", TableID);
        if DataExchFieldMapping.FINDSET then
            repeat
                //<<HEI.02
                //DataExchColumnDef.GET(DataExchDef.Code,DataExch."Data Exch. Line Def Code",DataExchFieldMapping."Column No.");
                DataExchColumnDef.GET(DataExchDef.Code, DataExchVIP."Data Exch. Line Def Code", DataExchFieldMapping."Column No.");
                //>>HEI.02
                if DataExchFieldMapping."Use Default Value" then
                    ValueAsString := DataExchFieldMapping."Default Value"
                else begin
                    FieldRef := RecRef.FIELD(DataExchFieldMapping."Field ID");

                    if FORMAT(FieldRef.CLASS) = 'FlowField' then
                        FieldRef.CALCFIELD;
                    CheckOptional(DataExchFieldMapping.Optional, FieldRef);
                    CastToDestinationType(ValueAsDestType, FieldRef.VALUE, DataExchColumnDef, DataExchFieldMapping.Multiplier);
                    ValueAsString := FormatToText(ValueAsDestType, DataExchDef, DataExchColumnDef);

                    if TransformationRule.GET(DataExchFieldMapping."Transformation Rule") then
                        ValueAsString := TransformationRule.TransformText(ValueAsString);

                    if DataExchColumnDef."Text Padding Required" and (DataExchColumnDef."Pad Character" <> '') then
                        ValueAsString :=
                          //StringConversionManagement.GetPaddedString(ValueAsString,DataExchColumnDef.Length,DataExchColumnDef."Pad Character");//BC Upgrade VAMSIU01
                          StringConversionManagement.GetPaddedString(ValueAsString, DataExchColumnDef.Length, DataExchColumnDef."Pad Character", 1);//BC Upgrade VAMSIU01
                end;
                if DataExchDef."File Type" = DataExchDef."File Type"::"Fixed Text" then
                    ValueAsString := FORMAT(ValueAsString, 0, STRSUBSTNO('<Text,%1>', DataExchColumnDef.Length));
                CheckLength(ValueAsString, RecRef.FIELD(DataExchFieldMapping."Field ID"), DataExchDef, DataExchColumnDef);
                //<<HEI.02
                /*
                DataExchField.GET(DataExch."Entry No.",LineNo,DataExchFieldMapping."Column No.");
                DataExchField.Value := ValueAsString;
                DataExchField.MODIFY;
                */

                DataExchFieldVIP.GET(DataExchVIP."Entry No.", LineNo, DataExchFieldMapping."Column No.");
                DataExchFieldVIP.Value := ValueAsString;
                DataExchFieldVIP.MODIFY;
            //>>HEI.02
            until DataExchFieldMapping.NEXT = 0;

    end;

    local procedure PrepopulateColumns(DataExchDef: Record "Data Exch. Def"; DataExchLineDefCode: Code[20]; DataExchEntryNo: Integer; DataExchLineNo: Integer);
    var
        //BC Upgrade VAMSIU01 >>
        // DataExchFieldVIP: Record "Data Exch. Field VIP";
        DataExchFieldVIP: Record "Data Exch. Field";
        //BC Upgrade VAMSIU01 <<
        DataExchLineDef: Record "Data Exch. Line Def";
        DataExchColumnDef: Record "Data Exch. Column Def";
        ColumnIndex: Integer;
    begin
        case DataExchDef."File Type" of
            DataExchDef."File Type"::Xml:
                begin
                    //<<HEI.02
                    DataExchColumnDef.RESET;
                    DataExchColumnDef.SETCURRENTKEY("Data Exch. Def Code", "Data Exch. Line Def Code");
                    //>>HEI.02
                    DataExchColumnDef.SETRANGE("Data Exch. Def Code", DataExchDef.Code);
                    DataExchColumnDef.SETRANGE("Data Exch. Line Def Code", DataExchLineDefCode);
                    //<<HEI.02
                    //IF NOT DataExchColumnDef.FINDSET THEN
                    if not DataExchColumnDef.FINDSET(false) then
                        //<<HEI.02
                        exit;
                    repeat
                        //<<HEI.02

                        DataExchFieldVIP.InsertRec2(
                        DataExchEntryNo, DataExchLineNo, DataExchColumnDef."Column No.",
                        PADSTR(DataExchColumnDef.Constant, DataExchColumnDef.Length), DataExchLineDefCode,
                        DataExchColumnDef.Name, DataExchColumnDef.Path);
                    //>>HEI.02
                    until DataExchColumnDef.NEXT = 0;
                end;
            DataExchDef."File Type"::"Fixed Text":
                begin
                    DataExchColumnDef.SETRANGE("Data Exch. Def Code", DataExchDef.Code);
                    DataExchColumnDef.SETRANGE("Data Exch. Line Def Code", DataExchLineDefCode);
                    if not DataExchColumnDef.FINDSET then
                        ERROR(DataExchLineDefNotFoundErr, DataExchDef.Name, DataExchLineDefCode);
                    repeat
                        //<<HEI.02
                        DataExchFieldVIP.InsertRec(
                         DataExchEntryNo, DataExchLineNo, DataExchColumnDef."Column No.",
                         PADSTR(DataExchColumnDef.Constant, DataExchColumnDef.Length), DataExchLineDefCode)
                    //>>HEI.02
                    until DataExchColumnDef.NEXT = 0;
                end;
            else begin
                if not DataExchLineDef.GET(DataExchDef.Code, DataExchLineDefCode) then
                    ERROR(DataExchLineDefNotFoundErr, DataExchDef.Name, DataExchLineDefCode);
                for ColumnIndex := 1 to DataExchLineDef."Column Count" do
                    if DataExchColumnDef.GET(DataExchDef.Code, DataExchLineDef.Code, ColumnIndex) then
                        //<<HEI.02
                        /*
                        DataExchField.InsertRec(
                          DataExchEntryNo,DataExchLineNo,ColumnIndex,DataExchColumnDef.Constant,DataExchLineDefCode)
                      ELSE
                        DataExchField.InsertRec(DataExchEntryNo,DataExchLineNo,ColumnIndex,'',DataExchLineDefCode);
                        */
                  DataExchFieldVIP.InsertRec(
                    DataExchEntryNo, DataExchLineNo, ColumnIndex, DataExchColumnDef.Constant, DataExchLineDefCode)
                    else
                        DataExchFieldVIP.InsertRec(DataExchEntryNo, DataExchLineNo, ColumnIndex, '', DataExchLineDefCode);

                //>>HEI.02
            end;
        end;

    end;

    local procedure CheckOptional(Optional: Boolean; FieldRef: FieldRef);
    var
        Value: Variant;
        StringValue: Text;
    begin
        if Optional then
            exit;

        Value := FieldRef.VALUE;
        StringValue := FORMAT(Value);

        if ((Value.ISDECIMAL or Value.ISINTEGER or Value.ISBIGINTEGER) and (StringValue = '0')) or
           (StringValue = '')
        then
            FieldRef.TESTFIELD
    end;

    local procedure CastToDestinationType(var DestinationValue: Variant; SourceValue: Variant; DataExchColumnDef: Record "Data Exch. Column Def"; Multiplier: Decimal);
    var
        ValueAsDecimal: Decimal;
        ValueAsDate: Date;
        ValueAsDateTime: DateTime;
    begin
        case DataExchColumnDef."Data Type" of
            DataExchColumnDef."Data Type"::Decimal:
                begin
                    if FORMAT(SourceValue) = '' then
                        ValueAsDecimal := 0
                    else
                        EVALUATE(ValueAsDecimal, FORMAT(SourceValue));
                    DestinationValue := Multiplier * ValueAsDecimal;
                end;
            DataExchColumnDef."Data Type"::Text:
                DestinationValue := FORMAT(SourceValue);
            DataExchColumnDef."Data Type"::Date:
                begin
                    EVALUATE(ValueAsDate, FORMAT(SourceValue));
                    DestinationValue := ValueAsDate;
                end;
            DataExchColumnDef."Data Type"::DateTime:
                begin
                    EVALUATE(ValueAsDateTime, FORMAT(SourceValue, 0, 9), 9);
                    DestinationValue := ValueAsDateTime;
                end;
        end;
    end;

    local procedure FormatToText(ValueToFormat: Variant; DataExchDef: Record "Data Exch. Def"; DataExchColumnDef: Record "Data Exch. Column Def"): Text[250];
    begin
        case true of
            DataExchColumnDef."Data Type" = DataExchColumnDef."Data Type"::Decimal:
                exit(DecimalFormatting(DataExchColumnDef, ValueToFormat));
            DataExchColumnDef."Data Type" in [DataExchColumnDef."Data Type"::Date, DataExchColumnDef."Data Type"::DateTime]:
                exit(DateTimeFormatting(DataExchColumnDef, FORMAT(ValueToFormat)));
            DataExchDef."File Type" = DataExchDef."File Type"::Xml:
                exit(FORMAT(ValueToFormat, 0, 9));
            DataExchColumnDef."Data Format" <> '':
                exit(FORMAT(ValueToFormat, 0, DataExchColumnDef."Data Format"));
            else
                exit(FORMAT(ValueToFormat));
        end;
    end;

    local procedure CheckLength(Value: Text; FieldRef: FieldRef; DataExchDef: Record "Data Exch. Def"; DataExchColumnDef: Record "Data Exch. Column Def");
    var
        DataExchDefCode: Code[20];
    begin
        DataExchDefCode := DataExchColumnDef."Data Exch. Def Code";

        if (DataExchColumnDef.Length > 0) and (STRLEN(Value) > DataExchColumnDef.Length) then
            ERROR(IncorrectLengthOfValuesErr, GetType(DataExchDefCode), DataExchDefCode,
              FieldRef.CAPTION, DataExchColumnDef.Length, STRLEN(Value), Value);

        if (DataExchDef."File Type" = DataExchDef."File Type"::"Fixed Text") and
           (STRLEN(Value) <> DataExchColumnDef.Length)
        then
            ERROR(IncorrectLengthOfValuesErr, GetType(DataExchDefCode), DataExchDefCode, FieldRef.CAPTION,
              DataExchColumnDef.Length, STRLEN(Value), Value);
    end;

    local procedure GetType(DataExchDefCode: Code[20]): Text;
    var
        DataExchDef: Record "Data Exch. Def";
    begin
        DataExchDef.GET(DataExchDefCode);
        exit(FORMAT(DataExchDef.Type));
    end;

    // local procedure DateTimeFormatting(DataExchColumnDef: Record "Data Exch. Column Def"; OldValue: Text): Text;
    // var
    //     // DotNetDateTime: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.DateTime";//BC Upgrade VAMSIU01
    //     // CultureInfo: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Globalization.CultureInfo";//BC Upgrade VAMSIU01
    //     // DotNetDateTimeStyles: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Globalization.DateTimeStyles";//BC Upgrade VAMSIU01
    //     NewValue: Text;
    //     TempDateTime: DateTime;
    //     TYear: Integer;
    //     TMonth: Integer;
    //     TDay: Integer;
    //     THour: Integer;
    //     TMin: Integer;
    //     TSec: Integer;
    //     TempDate: Date;
    //     TempTime: Time;
    //     TempTotalTime: Integer;
    // begin
    //     if not DataExchColumnDef."Ignore User Format Culture" then begin  //HEI.03
    //         if (DataExchColumnDef."Data Format" = '') and (DataExchColumnDef."Data Formatting Culture" = '') then
    //             exit(FORMAT(OldValue, 0, 9));

    //         NewValue := OldValue;

    //         DotNetDateTime := DotNetDateTime.DateTime(1);
    //         if DataExchColumnDef."Data Formatting Culture" = '' then begin
    //             CultureInfo := CultureInfo.InvariantCulture;
    //             if not DotNetDateTime.TryParseExact(
    //                  OldValue,
    //                  DataExchColumnDef."Data Format",
    //                  CultureInfo,
    //                  DotNetDateTimeStyles.None,
    //                  DotNetDateTime)
    //             then
    //                 exit(NewValue);
    //         end else begin
    //             CultureInfo := CultureInfo.GetCultureInfo(DataExchColumnDef."Data Formatting Culture");
    //             if not DotNetDateTime.TryParse(
    //                  OldValue,
    //                  CultureInfo,
    //                  DotNetDateTimeStyles.None,
    //                  DotNetDateTime)
    //             then
    //                 exit(NewValue);
    //         end;

    //         NewValue := DotNetDateTime.ToString(DataExchColumnDef."Data Format", CultureInfo);
    //         exit(NewValue);
    //         //HEI.03>>
    //     end else begin
    //         if (DataExchColumnDef."Data Exch. Def Code" = 'LSR-TS-OUT')
    //                         or (DataExchColumnDef."Data Exch. Def Code" = 'LSR-TR-OUT')
    //                         or (DataExchColumnDef."Data Exch. Def Code" = 'LSR-PO-UPDATE')
    //                         or (DataExchColumnDef."Data Exch. Def Code" = 'ASTROWMS-SO')    //HEI.04>>
    //                         or (DataExchColumnDef."Data Exch. Def Code" = 'ASTROWMS-SRO')
    //                         or (DataExchColumnDef."Data Exch. Def Code" = 'ASTROWMS-TOR')
    //                         or (DataExchColumnDef."Data Exch. Def Code" = 'ASTROWMS-TOS')
    //                         or (DataExchColumnDef."Data Exch. Def Code" = 'ASTROWMS-PRO') then begin   //HEI.04<<

    //             if (DataExchColumnDef."Data Format" = '') and (DataExchColumnDef."Data Formatting Culture" = '') then
    //                 exit(FORMAT(OldValue, 0, 9));

    //             if (OldValue = '') then exit(OldValue);

    //             NewValue := OldValue;

    //             EVALUATE(TempDateTime, OldValue);

    //             DotNetDateTime := DotNetDateTime.DateTime(0);

    //             TempDate := DT2DATE(TempDateTime);
    //             TempTime := DT2TIME(TempDateTime);

    //             TYear := DATE2DMY(TempDate, 3);
    //             TMonth := DATE2DMY(TempDate, 2);
    //             TDay := DATE2DMY(TempDate, 1);

    //             TempTotalTime := TempTime - 000000T;

    //             //HEI.04>>
    //             THour := TempTotalTime div 1000 div 60 div 60;
    //             TempTotalTime -= (THour * 1000 * 60 * 60);
    //             TMin := TempTotalTime div 1000 div 60;

    //             TempTotalTime -= (TMin * 1000 * 60);
    //             TSec := TempTotalTime div 1000;
    //             //HEI.04<<

    //             DotNetDateTime := DotNetDateTime.AddYears(TYear - 1);
    //             DotNetDateTime := DotNetDateTime.AddMonths(TMonth - 1);
    //             DotNetDateTime := DotNetDateTime.AddDays(TDay - 1);
    //             DotNetDateTime := DotNetDateTime.AddHours(THour);
    //             DotNetDateTime := DotNetDateTime.AddMinutes(TMin);
    //             DotNetDateTime := DotNetDateTime.AddSeconds(TSec);

    //             CultureInfo := CultureInfo.GetCultureInfo(DataExchColumnDef."Data Formatting Culture");

    //             NewValue := DotNetDateTime.ToString(DataExchColumnDef."Data Format", CultureInfo);

    //             exit(NewValue);
    //         end;
    //     end;
    //     //     //HEI.03<< //BC Upgrade VAMSIU01
    // end;

    // BC Upgrade SHUKLP03 >>
    local procedure DateTimeFormatting(DataExchColumnDef: Record "Data Exch. Column Def"; OldValue: Text): Text
    var
        NewValue: Text;
        TempDateTime: DateTime;
        TempDate: Date;
        TempTime: Time;
        TempTotalTime: Integer;
        TYear: Integer;
        TMonth: Integer;
        TDay: Integer;
        THour: Integer;
        TMin: Integer;
        TSec: Integer;
    begin
        if not DataExchColumnDef."Ignore User Format Culture FND" then begin
            if (DataExchColumnDef."Data Format" = '') and
               (DataExchColumnDef."Data Formatting Culture" = '')
            then
                exit(Format(OldValue, 0, 9));

            if OldValue = '' then
                exit(OldValue);

            NewValue := OldValue;

            // Try Date first
            if Evaluate(TempDate, OldValue) then begin
                case UpperCase(DataExchColumnDef."Data Format") of
                    'YYYY-MM-DD':
                        exit(Format(TempDate, 0, '<Year4>-<Month,2>-<Day,2>'));

                    'DD/MM/YYYY':
                        exit(Format(TempDate, 0, '<Day,2>/<Month,2>/<Year4>'));

                    'MM/DD/YYYY':
                        exit(Format(TempDate, 0, '<Month,2>/<Day,2>/<Year4>'));

                    'DD/MM/YY':
                        exit(Format(TempDate, 0, '<Day,2>/<Month,2>/<Year2>'));

                    'MM/DD/YY':
                        exit(Format(TempDate, 0, '<Month,2>/<Day,2>/<Year2>'));

                    else
                        exit(Format(TempDate));
                end;
            end;

            // Then try DATETIME
            if Evaluate(TempDateTime, OldValue) then begin
                TempDate := DT2Date(TempDateTime);
                TempTime := DT2Time(TempDateTime);

                case UpperCase(DataExchColumnDef."Data Format") of
                    'YYYY-MM-DD':
                        NewValue :=
                            Format(TempDate, 0, '<Year4>-<Month,2>-<Day,2>');

                    'DD/MM/YYYY':
                        NewValue :=
                            Format(TempDate, 0, '<Day,2>/<Month,2>/<Year4>');

                    'MM/DD/YYYY':
                        NewValue :=
                            Format(TempDate, 0, '<Month,2>/<Day,2>/<Year4>');

                    'YYYY-MM-DDTHH:MM:SS':
                        begin
                            // Do not append time if it is 00:00:00
                            if TempTime = 0T then
                                NewValue :=
                                    Format(TempDate, 0, '<Year4>-<Month,2>-<Day,2>')
                            else
                                NewValue :=
                                    Format(TempDate, 0, '<Year4>-<Month,2>-<Day,2>') + 'T' +
                                    Format(TempTime, 0, '<Hours24,2>:<Minutes,2>:<Seconds,2>');
                        end;

                    else
                        NewValue := Format(TempDateTime);
                end;

                exit(NewValue);
            end;
        end else begin
            if (DataExchColumnDef."Data Exch. Def Code" = 'LSR-TS-OUT')
            or (DataExchColumnDef."Data Exch. Def Code" = 'LSR-TR-OUT')
            or (DataExchColumnDef."Data Exch. Def Code" = 'LSR-PO-UPDATE')
            or (DataExchColumnDef."Data Exch. Def Code" = 'ASTROWMS-SO')
            or (DataExchColumnDef."Data Exch. Def Code" = 'ASTROWMS-SRO')
            or (DataExchColumnDef."Data Exch. Def Code" = 'ASTROWMS-TOR')
            or (DataExchColumnDef."Data Exch. Def Code" = 'ASTROWMS-TOS')
            or (DataExchColumnDef."Data Exch. Def Code" = 'ASTROWMS-PRO')
            then begin

                if (DataExchColumnDef."Data Format" = '') and
                   (DataExchColumnDef."Data Formatting Culture" = '')
                then
                    exit(Format(OldValue, 0, 9));

                if OldValue = '' then
                    exit(OldValue);

                if not Evaluate(TempDateTime, OldValue) then
                    exit(OldValue);

                TempDate := DT2Date(TempDateTime);
                TempTime := DT2Time(TempDateTime);

                TYear := Date2DMY(TempDate, 3);
                TMonth := Date2DMY(TempDate, 2);
                TDay := Date2DMY(TempDate, 1);

                TempTotalTime := TempTime - 000000T;

                THour := TempTotalTime div 1000 div 60 div 60;
                TempTotalTime -= (THour * 1000 * 60 * 60);

                TMin := TempTotalTime div 1000 div 60;
                TempTotalTime -= (TMin * 1000 * 60);

                TSec := TempTotalTime div 1000;

                // Format output
                case UpperCase(DataExchColumnDef."Data Format") of
                    'YYYY-MM-DD':
                        NewValue := StrSubstNo(
                            '%1-%2-%3',
                            TYear,
                            PadStr(Format(TMonth), 2, '0'),
                            PadStr(Format(TDay), 2, '0'));

                    'YYYY-MM-DDTHH:MM:SS':
                        NewValue :=
                            Format(TempDate, 0, '<Year4>-<Month,2>-<Day,2>') + 'T' +
                            Format(TempTime, 0, '<Hours24,2>:<Minutes,2>:<Seconds,2>');

                    else
                        NewValue := Format(TempDateTime);
                end;

                exit(NewValue);
            end;
        end;
    end;

    local procedure DecimalFormatting(DataExchColumnDef: Record "Data Exch. Column Def"; OldValue: Variant): Text;
    var
        TypeHelper: Codeunit "Type Helper";
        NewDecimalVariant: Variant;
        NewValue: Text;
        DummyDecimal: Decimal;
    begin
        if (DataExchColumnDef."Data Format" = '') and (DataExchColumnDef."Data Formatting Culture" = '') then
            exit(FORMAT(OldValue, 0, '<Precision,0:2><Standard Format,2>')); // Format 2 always uses a period (.) as the decimal separator, regardless of the Regional setting.

        if DataExchColumnDef."Data Format" <> '' then
            exit(FORMAT(OldValue, 0, DataExchColumnDef."Data Format"));

        NewValue := OldValue;
        NewDecimalVariant := DummyDecimal;
        TypeHelper.Evaluate(NewDecimalVariant, OldValue, '', DataExchColumnDef."Data Formatting Culture");

        NewValue := FORMAT(NewDecimalVariant, 0, 9);
        exit(NewValue);
    end;

    local procedure NoDataExchLineDefCheck(DataExchDefCode: Code[20]): Boolean;
    var
        DataExchLineDef: Record "Data Exch. Line Def";
    begin
        //<<HEI.02
        DataExchLineDef.RESET;
        DataExchLineDef.SETCURRENTKEY("Data Exch. Def Code", "Line Type");
        DataExchLineDef.SETRANGE("Data Exch. Def Code", DataExchDefCode);
        DataExchLineDef.SETRANGE("Line Type", DataExchLineDef."Line Type"::Detail);
        exit(DataExchLineDef.ISEMPTY);
        //>>HEI.02
    end;
}

