codeunit 58028 "Outbound Interface Mapping"
{
    // Heilite Navision Old Id - 50003

    // version HEI.05

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New codeunit for Interface Common Framework
    // HEI.02 CHG2095189 IBM SAXENA03 27.01.2021
    //   # Code written for Sales Order optimizaiton
    //   # Added RESET, SetCurrentKey & FINDSET(FALSE,FALSE)function in Function OnRun(), InsertDataExchLineForXML(), ProcessColumnMapping & PrepopulateColumns().
    //   # Created a new function NoDataExchLineDefCheck() and added into  OnRUN().
    //   # Added and calling function InsertRec2 from PrepopulateColumns.
    // HEI.03 CC CHG2236214 IBM BHANDS01 23.01.2024 Outbound interfaces are impacted by date format changes when Job Queues are restarted
    //   # Issue with LSR Interfaces in Bahamas
    //   # Added code in function DateTimeFormatting()
    // HEI.04 CC CHG2236214 IBM BHANDS01 30.01.2024 Outbound interfaces are impacted by date format changes when Job Queues are restarted
    //   # Updated code in function DateTimeFormatting()
    // HEI.05 CC CHG2249162 IBM BHANDS01 25.04.2024 Outbound interfaces are impacted by date format changes when Job Queues are restarted
    //   # Issue with ASTRO-SO in Ethiopia
    //   # Added code in function DateTimeFormatting()

    // BC Upgrade MISHRS14 >>
    // Changed table extension name to "DataExchColumnDefExtFND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    TableNo = "Data Exch.";

    trigger OnRun();
    var
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        DataExch: Record "Data Exch.";
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
        InterfaceEntryHeader.RESET;
        InterfaceEntryHeader.SETCURRENTKEY("Data Exch. Entry No.");
        //>>HEI.02
        InterfaceEntryHeader.SETRANGE("Data Exch. Entry No.", Rec."Entry No.");
        //<<HEI.02
        //IF InterfaceEntryHeader.FINDSET THEN
        if InterfaceEntryHeader.FINDSET(false) then
            //>>HEI.02
            repeat
                if GUIALLOWED then
                    Window.UPDATE(1, LineNo);
                //<<HEI.02
                DataExch.SETRANGE("Entry No.", Rec."Entry No.");
                if DataExch.FINDFIRST then begin
                    //IF DataExch.GET("Entry No.") THEN BEGIN
                    //>>HEI.02
                    RecordRef.GETTABLE(InterfaceEntryHeader);
                    InsertDataExchLineForXML(
                      DataExch,
                      LineNo,
                      RecordRef);
                    LineNo := LineNo + 1;
                end;
            until InterfaceEntryHeader.NEXT = 0;
        //<<HEI.02
        InterfaceEntryLine.RESET;
        InterfaceEntryLine.SETCURRENTKEY("Data Exch. Entry No.");
        //>>HEI.02
        InterfaceEntryLine.SETRANGE("Data Exch. Entry No.", Rec."Entry No.");
        //<<HEI.02
        //IF InterfaceEntryLine.FINDSET THEN
        if InterfaceEntryLine.FINDSET(false) then
            //>>HEI.02
            repeat
                if GUIALLOWED then
                    Window.UPDATE(1, LineNo);
                //<<HEI.02
                DataExch.SETRANGE("Entry No.", Rec."Entry No.");
                if DataExch.FINDFIRST then begin
                    //IF DataExch.GET("Entry No.") THEN BEGIN
                    //>>HEI.02
                    RecordRef.GETTABLE(InterfaceEntryLine);
                    InsertDataExchLineForXML(
                      DataExch,
                      LineNo,
                      RecordRef);
                    LineNo := LineNo + 1;
                end;
            until InterfaceEntryLine.NEXT = 0;

        //<<HEI.02
        InterfaceEntryComponent.RESET;
        InterfaceEntryComponent.SETCURRENTKEY("Data Exch. Entry No.");
        //>>HEI.02
        InterfaceEntryComponent.SETRANGE("Data Exch. Entry No.", Rec."Entry No.");
        //<<HEI.02
        //IF InterfaceEntryComponent.FINDSET THEN
        if InterfaceEntryComponent.FINDSET(false) then
            //>>HEI.02
            repeat
                if GUIALLOWED then
                    Window.UPDATE(1, LineNo);
                //<<HEI.02
                DataExch.SETRANGE("Entry No.", Rec."Entry No.");
                if DataExch.FINDFIRST then begin
                    //IF DataExch.GET("Entry No.") THEN BEGIN
                    //>>HEI.02
                    RecordRef.GETTABLE(InterfaceEntryComponent);
                    InsertDataExchLineForXML(
                      DataExch,
                      LineNo,
                      RecordRef);
                    LineNo := LineNo + 1;
                end;
            until InterfaceEntryComponent.NEXT = 0;

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

    procedure InsertDataExchLineForXML(var DataExch: Record "Data Exch."; LineNo: Integer; RecRef: RecordRef);
    var
        DataExchMapping: Record "Data Exch. Mapping";
        TableID: Integer;
    begin
        //<<HEI.02
        //DataExchMapping.INIT;
        DataExchMapping.RESET;
        DataExchMapping.SETCURRENTKEY("Data Exch. Def Code", "Data Exch. Line Def Code");
        //>>HEI.02
        DataExchMapping.SETRANGE("Data Exch. Def Code", DataExch."Data Exch. Def Code");
        DataExchMapping.SETRANGE("Data Exch. Line Def Code", DataExch."Data Exch. Line Def Code");
        if DataExchMapping.FINDFIRST then begin
            TableID := DataExchMapping."Table ID";
            ProcessColumnMapping(DataExch, RecRef, LineNo, TableID);
        end;
    end;

    local procedure ProcessColumnMapping(var DataExch: Record "Data Exch."; RecRef: RecordRef; LineNo: Integer; TableID: Integer);
    var
        DataExchDef: Record "Data Exch. Def";
        DataExchColumnDef: Record "Data Exch. Column Def";
        DataExchField: Record "Data Exch. Field";
        DataExchFieldMapping: Record "Data Exch. Field Mapping";
        TransformationRule: Record "Transformation Rule";
        StringConversionManagement: Codeunit StringConversionManagement;
        ValueAsDestType: Variant;
        FieldRef: FieldRef;
        ValueAsString: Text[250];
    begin
        if not DataExchDef.GET(DataExch."Data Exch. Def Code") then
            ERROR(FormatNotDefinedErr, DataExch."Data Exch. Def Code");

        PrepopulateColumns(DataExchDef, DataExch."Data Exch. Line Def Code", DataExch."Entry No.", LineNo);
        //<<HEI.02
        DataExchFieldMapping.RESET;
        DataExchFieldMapping.SETCURRENTKEY("Data Exch. Def Code", "Data Exch. Line Def Code", "Table ID");
        //>>HEI.02
        DataExchFieldMapping.SETRANGE("Data Exch. Def Code", DataExchDef.Code);
        DataExchFieldMapping.SETRANGE("Data Exch. Line Def Code", DataExch."Data Exch. Line Def Code");
        DataExchFieldMapping.SETRANGE("Table ID", TableID);
        if DataExchFieldMapping.FINDSET then
            repeat
                DataExchColumnDef.GET(DataExchDef.Code, DataExch."Data Exch. Line Def Code", DataExchFieldMapping."Column No.");
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
                          //StringConversionManagement.GetPaddedString(ValueAsString,DataExchColumnDef.Length,DataExchColumnDef."Pad Character");  //BC Upgrade
                          StringConversionManagement.GetPaddedString(ValueAsString, DataExchColumnDef.Length, DataExchColumnDef."Pad Character", 1);  //BC Upgrade

                end;
                if DataExchDef."File Type" = DataExchDef."File Type"::"Fixed Text" then
                    ValueAsString := FORMAT(ValueAsString, 0, STRSUBSTNO('<Text,%1>', DataExchColumnDef.Length));
                CheckLength(ValueAsString, RecRef.FIELD(DataExchFieldMapping."Field ID"), DataExchDef, DataExchColumnDef);

                DataExchField.GET(DataExch."Entry No.", LineNo, DataExchFieldMapping."Column No.");
                DataExchField.Value := ValueAsString;
                DataExchField.MODIFY;
            until DataExchFieldMapping.NEXT = 0;
    end;

    local procedure PrepopulateColumns(DataExchDef: Record "Data Exch. Def"; DataExchLineDefCode: Code[20]; DataExchEntryNo: Integer; DataExchLineNo: Integer);
    var
        DataExchField: Record "Data Exch. Field";
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
                        //>>HEI.02
                        exit;
                    repeat
                        //<<HEI.02

                        DataExchField.InsertRec2(
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
                        DataExchField.InsertRec(
                          DataExchEntryNo, DataExchLineNo, DataExchColumnDef."Column No.",
                          PADSTR(DataExchColumnDef.Constant, DataExchColumnDef.Length), DataExchLineDefCode)
                    until DataExchColumnDef.NEXT = 0;
                end;
            else begin
                if not DataExchLineDef.GET(DataExchDef.Code, DataExchLineDefCode) then
                    ERROR(DataExchLineDefNotFoundErr, DataExchDef.Name, DataExchLineDefCode);
                for ColumnIndex := 1 to DataExchLineDef."Column Count" do
                    if DataExchColumnDef.GET(DataExchDef.Code, DataExchLineDef.Code, ColumnIndex) then
                        DataExchField.InsertRec(
                          DataExchEntryNo, DataExchLineNo, ColumnIndex, DataExchColumnDef.Constant, DataExchLineDefCode)
                    else
                        DataExchField.InsertRec(DataExchEntryNo, DataExchLineNo, ColumnIndex, '', DataExchLineDefCode);
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
    //BC Upgrade GUNREM01 -Rewritten the DateTimeFormatting procedure >>
    // local procedure DateTimeFormatting(DataExchColumnDef: Record "Data Exch. Column Def"; OldValue: Text): Text;
    // var
    //     //  DotNetDateTime: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.DateTime";
    //     //DotNetDateTime: DotNet SystemDateTime;  // BC Upgrade NANDIS03
    //     //CultureInfo: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Globalization.CultureInfo";
    //     //CultureInfo: DotNet SystemGlobalizationCultureInfo;  // BC Upgrade NANDIS03
    //     //DotNetDateTimeStyles: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Globalization.DateTimeStyles";
    //     //DotNetDateTimeStyles: DotNet SystemGlobalizationDateTimeStyles;  // BC Upgrade NANDIS03
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
    // if not DataExchColumnDef."Ignore User Format Culture" then begin  //HEI.03
    //     if (DataExchColumnDef."Data Format" = '') and (DataExchColumnDef."Data Formatting Culture" = '') then
    //         exit(FORMAT(OldValue, 0, 9));

    //     NewValue := OldValue;

    //     DotNetDateTime := DotNetDateTime.DateTime(1);
    //     if DataExchColumnDef."Data Formatting Culture" = '' then begin
    //         CultureInfo := CultureInfo.InvariantCulture;
    //         if not DotNetDateTime.TryParseExact(
    //              OldValue,
    //              DataExchColumnDef."Data Format",
    //              CultureInfo,
    //              DotNetDateTimeStyles.None,
    //              DotNetDateTime)
    //         then
    //             exit(NewValue);
    //     end else begin
    //         CultureInfo := CultureInfo.GetCultureInfo(DataExchColumnDef."Data Formatting Culture");
    //         if not DotNetDateTime.TryParse(
    //              OldValue,
    //              CultureInfo,
    //              DotNetDateTimeStyles.None,
    //              DotNetDateTime)
    //         then
    //             exit(NewValue);
    //     end;

    //     NewValue := DotNetDateTime.ToString(DataExchColumnDef."Data Format", CultureInfo);
    //     exit(NewValue);
    //     //HEI.03>>
    // end else begin
    //     if (DataExchColumnDef."Data Exch. Def Code" = 'LSR-TS-OUT')
    //                     or (DataExchColumnDef."Data Exch. Def Code" = 'LSR-TR-OUT')
    //                     or (DataExchColumnDef."Data Exch. Def Code" = 'LSR-PO-UPDATE')
    //                     or (DataExchColumnDef."Data Exch. Def Code" = 'ASTROWMS-SO')  //HEI.05>>
    //                     or (DataExchColumnDef."Data Exch. Def Code" = 'ASTROWMS-SRO')
    //                     or (DataExchColumnDef."Data Exch. Def Code" = 'ASTROWMS-TOR')
    //                     or (DataExchColumnDef."Data Exch. Def Code" = 'ASTROWMS-TOS')
    //                     or (DataExchColumnDef."Data Exch. Def Code" = 'ASTROWMS-PRO') then begin   //HEI.05<<

    //         if (DataExchColumnDef."Data Format" = '') and (DataExchColumnDef."Data Formatting Culture" = '') then
    //             exit(FORMAT(OldValue, 0, 9));

    //         if (OldValue = '') then exit(OldValue); //HEI.04

    //         NewValue := OldValue;

    //         EVALUATE(TempDateTime, OldValue);

    //         DotNetDateTime := DotNetDateTime.DateTime(0); //HEI.04

    //         TempDate := DT2DATE(TempDateTime);
    //         TempTime := DT2TIME(TempDateTime);

    //         TYear := DATE2DMY(TempDate, 3);
    //         TMonth := DATE2DMY(TempDate, 2);
    //         TDay := DATE2DMY(TempDate, 1);

    //         TempTotalTime := TempTime - 000000T;

    //         //HEI.05>>
    //         THour := TempTotalTime div 1000 div 60 div 60;
    //         TempTotalTime -= (THour * 1000 * 60 * 60);
    //         TMin := TempTotalTime div 1000 div 60;

    //         TempTotalTime -= (TMin * 1000 * 60);
    //         TSec := TempTotalTime div 1000;
    //         //HEI.05<<

    //         //HEI.04>>
    //         DotNetDateTime := DotNetDateTime.AddYears(TYear - 1);
    //         DotNetDateTime := DotNetDateTime.AddMonths(TMonth - 1);
    //         DotNetDateTime := DotNetDateTime.AddDays(TDay - 1);
    //         DotNetDateTime := DotNetDateTime.AddHours(THour);
    //         DotNetDateTime := DotNetDateTime.AddMinutes(TMin);
    //         DotNetDateTime := DotNetDateTime.AddSeconds(TSec);
    //         //HEI.04<<

    //         CultureInfo := CultureInfo.GetCultureInfo(DataExchColumnDef."Data Formatting Culture");

    //         NewValue := DotNetDateTime.ToString(DataExchColumnDef."Data Format", CultureInfo);

    //         exit(NewValue);
    //     end;
    // end;
    // //HEI.03<<  // BC Upgrade NANDIS03
    // end;
    local procedure DateTimeFormatting(DataExchColumnDef: Record "Data Exch. Column Def"; OldValue: Text): Text
    var
        TempDateTime: DateTime;
        NewValue: Text;
        TYear: Integer;
        TMonth: Integer;
        TDay: Integer;
        THour: Integer;
        TMin: Integer;
        TSec: Integer;
        TempDate: Date;
        TempTime: Time;
        TempTotalTime: Integer;
        DateTime2Time: DateTime;
        TempDuration: Duration;
    begin
        if not DataExchColumnDef."Ignore User Format Culture FND" then begin
            if (DataExchColumnDef."Data Format" = '') and
               (DataExchColumnDef."Data Formatting Culture" = '') then
                exit(FORMAT(OldValue, 0, 9));

            NewValue := OldValue;

            if not Evaluate(TempDateTime, OldValue) then
                exit(NewValue);

            // Apply formatting if defined
            if DataExchColumnDef."Data Format" <> '' then
                NewValue := Format(TempDateTime, 0, DataExchColumnDef."Data Format")
            else
                NewValue := Format(TempDateTime);
            exit(NewValue);
        end else begin
            if (DataExchColumnDef."Data Exch. Def Code" in
                ['LSR-TS-OUT', 'LSR-TR-OUT', 'LSR-PO-UPDATE',
                 'ASTROWMS-SO', 'ASTROWMS-SRO', 'ASTROWMS-TOR',
                 'ASTROWMS-TOS', 'ASTROWMS-PRO']) then begin

                if (DataExchColumnDef."Data Format" = '') and (DataExchColumnDef."Data Formatting Culture" = '') then
                    exit(FORMAT(OldValue, 0, 9));

                if (OldValue = '') then exit(OldValue); //HEI.04

                NewValue := OldValue;

                EVALUATE(TempDateTime, OldValue);

                TempDate := DT2Date(TempDateTime);
                TempTime := DT2Time(TempDateTime);

                TYear := Date2DMY(TempDate, 3);
                TMonth := Date2DMY(TempDate, 2);
                TDay := Date2DMY(TempDate, 1);

                TempTotalTime := TempTime - 000000T;

                //HEI.05>>
                THour := TempTotalTime div 1000 div 60 div 60;
                TempTotalTime -= (THour * 1000 * 60 * 60);
                TMin := TempTotalTime div 1000 div 60;

                TempTotalTime -= (TMin * 1000 * 60);
                TSec := TempTotalTime div 1000;
                //HEI.05<<
                TempDate := DMY2Date(TDay, TMonth, TYear);
                TempDuration := (THour * 3600000) +
                                (TMin * 60000) +
                                (TSec * 1000);
                TempTime := 000000T + TempDuration;
                TempDateTime := CreateDateTime(TempDate, TempTime);
                NewValue := Format(TempDateTime, 0, DataExchColumnDef."Data Format");

                exit(NewValue);
            end;
        end;
    end;
    //BC Upgrade GUNREM01 -Rewritten the DateTimeFormatting procedure <<


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

