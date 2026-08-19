codeunit 58003 "Inbound Interface Mapping"
{
    // Heilite Navision Old Id - 50008
    // version HEI.01

    // HEI.03 FDD-SLSGAP020 IBM HORTOC01 24.10.2018 # customer mendix interface
    // HEI.04 INC3036514 IBM NASTAA02 07/09/2020 # Heilite Interface FuturMaster Discount not being proccessed fully
    //   # Code added on function 'CreateInboundInterfaceEntryOnLevel'
    // HEI.05 CHG2073953 IBM.GAVANM01 22.09.2020 Customer Interface fields geo coordinates and delivery windows
    //   # code added for Delivery Times table
    // HEI.06 CHG2095187 IBM SAXENA03 18.02.2021
    //   # Code written for Paraller Request
    //   # Peace of code commented and replaced with new code to process data with Entry no. in ImportXML().
    //   # Created a new function CopyToTempInterfaceInboundEntry() and calling from CreateInboundInterfaceEntryOnLevel().
    //   # Created a new function GetCopyToTempInterfaceInboundEntry().
    // HEI.07 CHG2132219 HB2607 IBM GAVANM01 25.01.2022 #Customer Creation Integration with Mendix (SEPA)
    //   # code changes
    // HEI.08 CHG2132219 HB2607 IBM GAVANM01 25.01.2022 #Customer Creation Integration with Mendix (SEPA)
    //   # code changes
    // HEI.09 INC4209581 20.07.2022
    //   #Code changes on function CopyIntermediateToTemp due to memory leak for empty calcfield


    // BC Upgrade MISHRS14 >>
    // Changed Table name from "Master Data Validate Priority" to "Master Data Val Priority FND" as its moved from Interface to Foundation Layer
    // BC Upgrade MISHRS14 <<


    // BC UPGRADE PATELS08 >>
    // # Table name changed from "Interf. Incoming Data Mapping" to "Interf. IncomingDataMappingFND"
    // BC UPGRADE PATELS08 <<


    Permissions = TableData "Data Exch." = imd;
    TableNo = "Incoming Document Attachment";

    trigger OnRun();
    begin
        if Rec.Type <> Rec.Type::XML then
            ERROR(InvalidTypeErr);

        CheckContentHasValue(Rec);

        ImportXML(Rec);
    end;

    var
        InvalidTypeErr: Label 'The attachment is not an XML document.';
        AttachmentEmptyErr: Label 'The attachment does not contain any data.';
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        SimulateMode: Boolean;
        SimulateModeErr: Label 'Simulate Mode';
        ReturnValue: Text;
        LastExistingEntry: Integer;
        TempInboundEntryHeader: Record "Interface Entry Header INT" temporary;

    local procedure ImportXML(IncomingDocumentAttachment: Record "Incoming Document Attachment"): Code[20];
    var
        DataExch: Record "Data Exch.";
        DataExchField: Record "Data Exch. Field";
        DataExchangeType: Record "Data Exchange Type";
        DataExchDef: Record "Data Exch. Def";
        IntermediateDataImport: Record "Intermediate Data Import";
        TempIntermediateDataImport: Record "Intermediate Data Import" temporary;
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InboundInterfaceProcessing: Codeunit "Inbound Interface Processing";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        SRMInterfaceWebServices: Codeunit "SRM Interface Web Services";
    begin
        InterfaceSetup.GET(IncomingDocumentAttachment."Document No.");
        InterfaceSetup.TESTFIELD("Data Exch. Def Code");
        InterfaceSetup.TESTFIELD("Data Exch. Line Def Code");
        DataExchDef.GET(InterfaceSetup."Data Exch. Def Code");

        CreateDataExch(DataExch, DataExchDef, IncomingDocumentAttachment);
        if TryCreateIntermediate(DataExch, DataExchDef) then begin
            COMMIT();
            CopyIntermediateToTemp(IntermediateDataImport, TempIntermediateDataImport, DataExch."Entry No.");
            IntermediateDataImport.RESET();
            IntermediateDataImport.SETRANGE("Data Exch. No.", DataExch."Entry No.");
            IntermediateDataImport.DELETEALL(true);
            DataExchField.SETRANGE("Data Exch. No.", DataExch."Entry No.");
            DataExchField.DELETEALL(true);
            COMMIT();
            if InterfaceSetup."Use Component Detail" then begin
                if SimulateMode then begin
                    CreateInboundInterfaceEntryWithDetails(InterfaceEntryHeader, TempIntermediateDataImport, InterfaceSetup.Code);
                    InboundInterfaceProcessing.SetSimulateMode(SimulateMode);
                    InboundInterfaceProcessing.RUN(InterfaceEntryHeader);
                end else begin
                    InterfaceEntryHeader.LOCKTABLE();
                    CreateInboundInterfaceEntryWithDetails(InterfaceEntryHeader, TempIntermediateDataImport, InterfaceSetup.Code);
                    if InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Synchronous then begin
                        InboundInterfaceProcessing.SetSimulateMode(false);
                        InboundInterfaceProcessing.RUN(InterfaceEntryHeader);
                        ReturnValue := InboundInterfaceProcessing.GetReturnValue();
                        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
                        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
                        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
                    end;
                end;
            end else begin
                if InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Synchronous then begin
                    //<<HEI.06

                    /*
                    InterfaceEntryHeader.SETCURRENTKEY("Interface Code",Status);
                    InterfaceEntryHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
                    InterfaceEntryHeader.SETRANGE(Status,InterfaceEntryHeader.Status::Pending);
                    IF InterfaceEntryHeader.FINDLAST THEN
                      LastExistingEntry := InterfaceEntryHeader."Entry No."
                    ELSE
                      LastExistingEntry := 0;

                    CreateInboundInterfaceEntry(TempIntermediateDataImport,InterfaceSetup.Code);

                    COMMIT;
                    InterfaceEntryHeader.SETFILTER("Entry No.",'>%1',LastExistingEntry);
                    InterfaceEntryHeader.SETRANGE(Direction,InterfaceEntryHeader.Direction::Inbound);
                    IF InterfaceEntryHeader.FINDSET THEN
                      REPEAT
                        InboundInterfaceProcessing.SetSimulateMode(SimulateMode);
                        InboundInterfaceProcessing.RUN(InterfaceEntryHeader);
                      UNTIL InterfaceEntryHeader.NEXT = 0;
                    */

                    CreateInboundInterfaceEntry(TempIntermediateDataImport, InterfaceSetup.Code);

                    if TempInboundEntryHeader.findset() then
                        repeat
                            if InterfaceEntryHeader.GET(TempInboundEntryHeader."Entry No.") then begin
                                InboundInterfaceProcessing.SetSimulateMode(SimulateMode);
                                InboundInterfaceProcessing.RUN(InterfaceEntryHeader);
                            end;
                        until TempInboundEntryHeader.NEXT() = 0;
                    //>>HEI.06
                end else
                    CreateInboundInterfaceEntry(TempIntermediateDataImport, InterfaceSetup.Code);
            end;
        end else
            DataExch.DELETE(true);

    end;

    local procedure CreateDataExch(var DataExch: Record "Data Exch."; DataExchDef: Record "Data Exch. Def"; IncomingDocumentAttachment: Record "Incoming Document Attachment");
    var
        Stream: InStream;
    begin
        IncomingDocumentAttachment.Content.CREATEINSTREAM(Stream);

        DataExch.INIT();
        DataExch.InsertRec(IncomingDocumentAttachment.Name, Stream, DataExchDef.Code);
        GeneralInterfaceSetup.GET();
        DataExch."File Encoding FND" := GeneralInterfaceSetup."XML Encoding";
        DataExch.MODIFY(true);
    end;

    local procedure TryCreateIntermediate(DataExch: Record "Data Exch."; DataExchDef: Record "Data Exch. Def"): Boolean;
    begin
        COMMIT();
        if DataExchDef."Reading/Writing Codeunit" <> 0 then begin
            CODEUNIT.RUN(DataExchDef."Reading/Writing Codeunit", DataExch);
            //IF NOT CODEUNIT.RUN(DataExchDef."Reading/Writing Codeunit",DataExch) THEN
            //  EXIT(FALSE);

            if DataExchDef."Data Handling Codeunit" <> 0 then
                CODEUNIT.RUN(DataExchDef."Data Handling Codeunit", DataExch);
            //IF NOT CODEUNIT.RUN(DataExchDef."Data Handling Codeunit",DataExch) THEN
            //EXIT(FALSE);
            exit(true);
        end;
        exit(false);
    end;

    local procedure CheckContentHasValue(var IncomingDocumentAttachment: Record "Incoming Document Attachment");
    var
        LiveIncomingDocumentAttachment: Record "Incoming Document Attachment";
    begin
        // Is the data already loaded or is it in the db?
        LiveIncomingDocumentAttachment := IncomingDocumentAttachment;
        LiveIncomingDocumentAttachment.CALCFIELDS(Content);
        if LiveIncomingDocumentAttachment.Content.HASVALUE then
            IncomingDocumentAttachment.CALCFIELDS(Content);

        if not IncomingDocumentAttachment.Content.HASVALUE then
            ERROR(AttachmentEmptyErr);
    end;

    local procedure CreateInboundInterfaceEntry(var IntermediateDataImport: Record "Intermediate Data Import"; InterfaceCode: Code[20]);
    var
        IntermediateDataImport2: Record "Intermediate Data Import" temporary;
        "Field": Record "Field";
        EntryNos: array[3] of Integer;
    begin
        CreateInboundInterfaceEntryOnLevel(IntermediateDataImport, EntryNos, 1, '0|1', InterfaceCode);
    end;

    local procedure CreateInboundInterfaceEntryOnLevel(var IntermediateDataImport: Record "Intermediate Data Import"; var EntryNos: array[3] of Integer; LevelNo: Integer; ParentRecordNoFilter: Text; InterfaceCode: Code[20]);
    var
        IntermediateDataImport2: Record "Intermediate Data Import" temporary;
        "Field": Record "Field";
        //TempBlob: Record TempBlob temporary;  // BC Upgrade NANDIS03 - Blocked as TempBlb Record type is obsolete
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03 - Opened
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        RecRef: RecordRef;
        FldRef: FieldRef;
        OutStr: OutStream;
        PreviousTableID: Integer;
        PreviousRecordNo: Integer;
        EntryNo: Integer;
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceSetup: Record "Interface Setup INT";
        variable: Integer;
    begin
        CopyIntermediateToTemp(IntermediateDataImport, IntermediateDataImport2, IntermediateDataImport."Data Exch. No.");

        IntermediateDataImport.RESET();
        IntermediateDataImport.SETCURRENTKEY("Data Exch. No.", "Table ID", "Record No.", "Field ID");
        case LevelNo of
            1:
                IntermediateDataImport.SETRANGE("Table ID", DATABASE::"Interface Entry Header INT");
            2:
                IntermediateDataImport.SETRANGE("Table ID", DATABASE::"Interface Entry Line INT");
            3:
                IntermediateDataImport.SETRANGE("Table ID", DATABASE::"Interface Entry Component INT");
        end;
        IntermediateDataImport.SETFILTER("Parent Record No.", ParentRecordNoFilter);
        IntermediateDataImport.SETFILTER("Field ID", '<>%1', 0);
        IntermediateDataImport.SETFILTER(Value, '<>%1', '');
        if IntermediateDataImport.findset() then begin
            repeat
                if IntermediateDataImport."Record No." <> PreviousRecordNo then begin
                    if PreviousRecordNo <> 0 then begin
                        RecRef.INSERT(true);
                        if IntermediateDataImport."Table ID" = DATABASE::"Interface Entry Header INT" then begin
                            CLEAR(EntryNos);
                            FldRef := RecRef.FIELD(1);
                            EntryNos[1] := FldRef.VALUE;
                        end;
                        if LevelNo < 3 then
                            CreateInboundInterfaceEntryOnLevel(IntermediateDataImport2, EntryNos, LevelNo + 1, FORMAT(PreviousRecordNo), InterfaceCode);
                    end;
                    CLEAR(RecRef);
                    RecRef.OPEN(IntermediateDataImport."Table ID");
                    case LevelNo of
                        1:
                            begin
                                FldRef := RecRef.FIELD(2);
                                InterfaceFrameworkMgt.SetFieldValue(FldRef, InterfaceCode);
                                FldRef := RecRef.FIELD(500);
                                InterfaceFrameworkMgt.SetFieldValue(FldRef, FORMAT(IntermediateDataImport."Data Exch. No."));
                            end;
                        2:
                            begin
                                FldRef := RecRef.FIELD(1);
                                InterfaceFrameworkMgt.SetFieldValue(FldRef, FORMAT(EntryNos[1]));
                                EntryNo := EntryNo + 1;
                                EntryNos[2] := EntryNo;
                                FldRef := RecRef.FIELD(2);
                                InterfaceFrameworkMgt.SetFieldValue(FldRef, FORMAT(EntryNo));
                                FldRef := RecRef.FIELD(500);
                                InterfaceFrameworkMgt.SetFieldValue(FldRef, FORMAT(IntermediateDataImport."Data Exch. No."));
                            end;
                        3:
                            begin
                                FldRef := RecRef.FIELD(1);
                                InterfaceFrameworkMgt.SetFieldValue(FldRef, FORMAT(EntryNos[1]));
                                FldRef := RecRef.FIELD(2);
                                InterfaceFrameworkMgt.SetFieldValue(FldRef, FORMAT(EntryNos[2]));
                                EntryNo := EntryNo + 1;
                                EntryNos[3] := EntryNo;
                                FldRef := RecRef.FIELD(4);
                                InterfaceFrameworkMgt.SetFieldValue(FldRef, FORMAT(EntryNo));
                                FldRef := RecRef.FIELD(500);
                                InterfaceFrameworkMgt.SetFieldValue(FldRef, FORMAT(IntermediateDataImport."Data Exch. No."));
                            end;
                    end;
                end;
                FldRef := RecRef.FIELD(IntermediateDataImport."Field ID");
                EVALUATE(Field.Type, FORMAT(FldRef.TYPE));
                if Field.Type <> Field.Type::BLOB then
                    InterfaceFrameworkMgt.SetFieldValue(FldRef, IntermediateDataImport.Value)
                else
                    if IntermediateDataImport."Big Value FND".HASVALUE then begin
                        IntermediateDataImport.CALCFIELDS("Big Value FND");
                        FldRef.VALUE := IntermediateDataImport."Big Value FND";
                    end else begin
                        CLEAR(OutStr);
                        CLEAR(TempBlob);
                        //TempBlob.Blob.CREATEOUTSTREAM(OutStr);  // BC Upgrade NANDIS03 - Blocked as Tempblob is record is obsolete
                        TempBlob.CREATEOUTSTREAM(OutStr);  // BC Upgrade NANDIS03 - Added
                        OutStr.WRITETEXT(IntermediateDataImport.Value);
                        //FldRef.VALUE := TempBlob.Blob;  // BC Upgrade NANDIS03 - Blocked as Tempblob is record is obsolete
                        //FldRef.VALUE := TempBlob;  // BC Upgrade NANDIS03 - Added // BC Upgrade VAMSIU01 - Blocked
                    end;
                PreviousRecordNo := IntermediateDataImport."Record No.";
            until IntermediateDataImport.NEXT() = 0;

            //HEI.04>>
            if LevelNo = 2 then begin
                InterfaceSetup.GET(InterfaceCode);
                if InterfaceSetup."Enable Processing Flag" then begin
                    InterfaceEntryHeader.RESET();
                    variable := RecRef.FIELD(1).Value;
                    InterfaceEntryHeader.GET(variable);
                    InterfaceEntryHeader."Processing Flag" := true;
                    InterfaceEntryHeader.MODIFY(true);
                end;
            end;
            //HEI.04<<

            RecRef.INSERT(true);

            if IntermediateDataImport."Table ID" = DATABASE::"Interface Entry Header INT" then begin
                CLEAR(EntryNos);
                FldRef := RecRef.FIELD(1);
                EntryNos[1] := FldRef.VALUE;
                //<<HEI.06
                CopyToTempInterfaceInboundEntry(EntryNos[1]);
                //>>HEI.06
            end;
            if LevelNo < 3 then
                CreateInboundInterfaceEntryOnLevel(IntermediateDataImport2, EntryNos, LevelNo + 1, FORMAT(IntermediateDataImport."Record No."), InterfaceCode);
        end;
    end;

    local procedure CreateInboundInterfaceEntryWithDetails(var InterfaceEntryHeader: Record "Interface Entry Header INT"; var IntermediateDataImport: Record "Intermediate Data Import"; InterfaceCode: Code[20]);
    var
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        InterfaceEntryCompDetail: Record "Interface Entry Comp.DetailINT";
        TempKeyFldId: Record "Integer" temporary;
        RecRef: RecordRef;
        FldRef: FieldRef;
        "Key": KeyRef;
        PreviousTableID: Integer;
        PreviousRecordNo: Integer;
        i: Integer;
        EntryNo: Integer;
    begin
        InterfaceEntryLine.LOCKTABLE();
        InterfaceEntryComponent.LOCKTABLE();
        IntermediateDataImport.RESET();
        IntermediateDataImport.SETCURRENTKEY("Data Exch. No.", "Table ID", "Record No.", "Field ID");
        IntermediateDataImport.SETFILTER("Table ID", '<>%1', 0);
        IntermediateDataImport.SETFILTER("Field ID", '<>%1', 0);
        if IntermediateDataImport.findset() then begin
            CLEAR(InterfaceEntryHeader);
            InterfaceEntryHeader."Interface Code" := InterfaceCode;
            InterfaceEntryHeader.Direction := InterfaceEntryHeader.Direction::Inbound;
            InterfaceEntryHeader."Sync. Date" := CURRENTDATETIME;
            InterfaceEntryHeader.Status := InterfaceEntryHeader.Status::Pending;
            InterfaceEntryHeader."Source Type" := IntermediateDataImport."Table ID";
            InterfaceEntryHeader.INSERT();

            CLEAR(InterfaceEntryLine);
            InterfaceEntryLine."Header Entry No." := InterfaceEntryHeader."Entry No.";
            EntryNo := EntryNo + 1;
            InterfaceEntryLine."Entry No." := EntryNo;
            InterfaceEntryLine.INSERT();

            PreviousTableID := 0;
            PreviousRecordNo := 0;
            repeat
                if (IntermediateDataImport."Table ID" <> PreviousTableID) or
                   ((IntermediateDataImport."Table ID" = PreviousTableID) and (IntermediateDataImport."Record No." <> PreviousRecordNo))
                then begin
                    CLEAR(RecRef);
                    CLEAR(FldRef);
                    CLEAR(Key);
                    TempKeyFldId.RESET();
                    TempKeyFldId.DELETEALL();
                    RecRef.OPEN(IntermediateDataImport."Table ID");
                    //Key := RecRef.KEYINDEX(1);  //commented by HEI.07
                    //HEI.07<<
                    if IntermediateDataImport."Table ID" = 1230 then
                        //Key := RecRef.KEYINDEX(3)  //commented by HEI.08
                        Key := RecRef.KEYINDEX(2)  //HEI.08
                    else
                        Key := RecRef.KEYINDEX(1);
                    //HEI.07>>
                    for i := 1 to Key.FIELDCOUNT do begin
                        FldRef := Key.FIELDINDEX(i);
                        CLEAR(TempKeyFldId);
                        TempKeyFldId.Number := FldRef.NUMBER;
                        TempKeyFldId.INSERT();
                    end;
                    RecRef.CLOSE();

                    CLEAR(InterfaceEntryComponent);
                    InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
                    InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
                    InterfaceEntryComponent."Table ID" := IntermediateDataImport."Table ID";
                    InterfaceEntryComponent.Code := FORMAT(IntermediateDataImport."Record No.");
                    InterfaceEntryComponent."Table Is Master Data" := TableIsMasterData(InterfaceEntryComponent."Table ID");
                    //InterfaceEntryComponent."Value Code" := IntermediateDataImport.Value;
                    InterfaceEntryComponent.INSERT();
                end;

                CLEAR(InterfaceEntryCompDetail);
                InterfaceEntryCompDetail."Header Entry No." := InterfaceEntryComponent."Header Entry No.";
                InterfaceEntryCompDetail."Line Entry No." := InterfaceEntryComponent."Line Entry No.";
                InterfaceEntryCompDetail."Table ID" := InterfaceEntryComponent."Table ID";
                InterfaceEntryCompDetail.Code := InterfaceEntryComponent.Code;
                InterfaceEntryCompDetail."Field ID" := IntermediateDataImport."Field ID";
                InterfaceEntryCompDetail."Data Exch. No." := IntermediateDataImport."Data Exch. No.";
                InterfaceEntryCompDetail."Record No." := IntermediateDataImport."Record No.";
                InterfaceEntryCompDetail."Incoming Value" := IntermediateDataImport.Value;
                InterfaceEntryCompDetail.Value := GetIncomingDataMappingValue(IntermediateDataImport."Table ID", IntermediateDataImport."Field ID", IntermediateDataImport.Value);
                InterfaceEntryCompDetail."Validate Only" := IntermediateDataImport."Validate Only";
                InterfaceEntryCompDetail."Parent Record No." := IntermediateDataImport."Parent Record No.";
                InterfaceEntryCompDetail."Validate Priority" := GetMasterDataFieldValidationPriority(IntermediateDataImport."Table ID", IntermediateDataImport."Field ID");
                if TempKeyFldId.GET(InterfaceEntryCompDetail."Field ID") then begin
                    InterfaceEntryCompDetail."Is Primary Key" := true;
                    InterfaceEntryCompDetail."Is Master Table Related" := FieldIsMasterTableRelation(InterfaceEntryCompDetail."Table ID", InterfaceEntryCompDetail."Field ID");
                    if InterfaceEntryHeader."Source Type" = IntermediateDataImport."Table ID" then
                        InterfaceEntryHeader."Source No." := IntermediateDataImport.Value;
                    InterfaceEntryHeader.MODIFY();
                end;
                InterfaceEntryCompDetail.INSERT();

                PreviousTableID := IntermediateDataImport."Table ID";
                PreviousRecordNo := IntermediateDataImport."Record No.";
            until IntermediateDataImport.NEXT() = 0;
        end;
    end;

    local procedure CopyIntermediateToTemp(var IntermediateDataImport: Record "Intermediate Data Import"; var TempIntermediateDataImport: Record "Intermediate Data Import"; DataExchEntryNo: Integer);
    begin
        IntermediateDataImport.RESET();
        IntermediateDataImport.SETRANGE("Data Exch. No.", DataExchEntryNo);
        if IntermediateDataImport.findset() then
            repeat
                CLEAR(TempIntermediateDataImport);
                if IntermediateDataImport."Big Value FND".HASVALUE then begin //HEI.09
                    IntermediateDataImport.CALCFIELDS("Big Value FND");
                end;  //HEI.09
                      //IntermediateDataImport.CALCFIELDS("Big Value"); //HEI.09
                TempIntermediateDataImport := IntermediateDataImport;
                TempIntermediateDataImport.INSERT();
            until IntermediateDataImport.NEXT() = 0;
        IntermediateDataImport.RESET();
        TempIntermediateDataImport.RESET();
    end;

    local procedure TableIsMasterData(TableID: Integer): Boolean;
    begin
        //EXIT(TableID IN [DATABASE::Item,DATABASE::Vendor]);//HEI.03
        exit(TableID in [DATABASE::Item, DATABASE::Vendor, DATABASE::Customer]);//HEI.03
    end;

    local procedure FieldIsMasterTableRelation(TableID: Integer; FieldID: Integer): Boolean;
    begin
        case TableID of
            DATABASE::"Item Translation",
          DATABASE::"Item Unit of Measure",
          //DATABASE::"Item Cross Reference",  // BC Upgrade NANDIS03 - Blocked as Item Cross Reference table is obsolete
          DATABASE::"Stockkeeping Unit",
          DATABASE::"Vendor Bank Account":
                exit(FieldID = 1);
            DATABASE::"Item Attribute Value Mapping":
                exit(FieldID = 2);
            DATABASE::"Default Dimension":
                exit(FieldID = 2);
            //HEI.03>>
            DATABASE::"Customer Attributes FND":
                exit(FieldID = 1);
            DATABASE::"Customer Bank Account":
                exit(FieldID = 1);
            //HEI.03<<
            //HEI.05>>
            // DATABASE::"Delivery Times":  
            //     exit(FieldID = 1);  // BC Upgrade NANDIS03 - Blocked as Delivery Times table is DIT table
            //HEI.05<<
            //HEI.07<<
            DATABASE::"SEPA Direct Debit Mandate":
                exit(FieldID = 2);
            //BC UPGRADE KUMARR78 18-06-2026++
            DATABASE::MultiDeliveryTimes107FDW:
                exit(FieldID = 3);
        //BC UPGRADE KUMARR78 18-06-2026++
        //HEI.07>>
        end;
    end;

    procedure SetSimulateMode(NewSimulateMode: Boolean);
    begin
        SimulateMode := NewSimulateMode;
    end;

    procedure GetReturnValue(): Text;
    begin
        exit(ReturnValue);
    end;

    procedure GetLastExistingEntry(): Integer;
    begin
        exit(LastExistingEntry);
    end;

    local procedure GetIncomingDataMappingValue(TableID: Integer; FieldID: Integer; IncomingValue: Text): Text;
    var
        InterfIncomingDataMapping: Record "Interf. IncomingDataMappingFND";
        RecRef: RecordRef;
        FldRef: FieldRef;
        FldRef2: FieldRef;
    begin
        if IncomingValue = '' then
            exit(GetDefaultValueByType(TableID, FieldID));

        if not InterfIncomingDataMapping.GET(TableID, FieldID) then
            exit(IncomingValue);

        if (InterfIncomingDataMapping."Incoming Table ID" = 0) or
           (InterfIncomingDataMapping."Incoming Field ID" = 0)
        then
            exit(IncomingValue);

        RecRef.OPEN(InterfIncomingDataMapping."Incoming Table ID");
        FldRef := RecRef.FIELD(InterfIncomingDataMapping."Incoming Field ID");
        FldRef.SETRANGE(IncomingValue);
        if RecRef.FINDFIRST() then begin
            if InterfIncomingDataMapping."Mapping Field ID" <> 0 then begin
                FldRef2 := RecRef.FIELD(InterfIncomingDataMapping."Mapping Field ID");
                if FORMAT(FldRef2.VALUE) <> '' then
                    exit(FldRef2.VALUE)
                else
                    exit(IncomingValue);
            end else
                if InterfIncomingDataMapping."Use Mapping Constant" then
                    exit(InterfIncomingDataMapping."Mapping Constant")
                else
                    exit(IncomingValue);
        end else
            exit(IncomingValue);
    end;

    local procedure GetMasterDataFieldValidationPriority(TableID: Integer; FieldID: Integer): Integer;
    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        MasterDataValidatPriority: Record "Master Data Val Priority FND";
    begin
        if MasterDataValidatPriority.GET(TableID, FieldID) then
            exit(MasterDataValidatPriority."Validate Priority");

        GeneralInterfaceSetup.GET();
        exit(GeneralInterfaceSetup."MD Default Field Priority");
    end;

    local procedure GetDefaultValueByType(TableID: Integer; FieldID: Integer): Text[250];
    var
        "Field": Record "Field";
        RecRef: RecordRef;
        FldRef: FieldRef;
    begin
        RecRef.OPEN(TableID);
        FldRef := RecRef.FIELD(FieldID);
        EVALUATE(Field.Type, FORMAT(FldRef.TYPE));

        case Field.Type of
            Field.Type::Text:
                exit('');
            Field.Type::Code:
                exit('');
            Field.Type::Option:
                exit('0');
            Field.Type::Date:
                exit('');
            Field.Type::DateFormula:
                exit('');
            Field.Type::DateTime:
                exit('');
            Field.Type::Time:
                exit('');
            Field.Type::Duration:
                exit('0');
            Field.Type::Integer:
                exit('0');
            Field.Type::BigInteger:
                exit('0');
            Field.Type::Decimal:
                exit('0');
            Field.Type::Boolean:
                exit('No');
        end;
    end;

    local procedure CopyToTempInterfaceInboundEntry(EntryNo: Integer);
    begin
        //<<HEI.06
        if not TempInboundEntryHeader.GET(EntryNo) then begin
            TempInboundEntryHeader.INIT();
            TempInboundEntryHeader."Entry No." := EntryNo;
            TempInboundEntryHeader.INSERT();
        end;
        //>>HEI.06
    end;

    procedure GetCopyToTempInterfaceInboundEntry(var TempInboundHdrOut: Record "Interface Entry Header INT" temporary);
    begin
        //<<HEI.06
        if TempInboundEntryHeader.findset() then
            repeat
                TempInboundHdrOut.INIT();
                TempInboundHdrOut."Entry No." := TempInboundEntryHeader."Entry No.";
                TempInboundHdrOut.INSERT();
            until TempInboundEntryHeader.NEXT() = 0;
        //>>HEI.06
    end;
}

