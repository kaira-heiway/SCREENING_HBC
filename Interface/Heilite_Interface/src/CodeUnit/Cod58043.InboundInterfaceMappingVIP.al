codeunit 58043 "Inbound Interface Mapping VIP"
{
    // version HEI.02
    //BC Upgrade GUNREM01 - Old ID 50098

    // HEI.01 HT1010 IBM NASTAA02 28.11.2019 # Maraki dedicated Job Queue - CHG2039961
    //   # New Codeunit created
    // HEI.02 CHG2043663 FDD-HT604 IBM GAVANM01 09.12.2019 # WMS fix
    // HEI.03 CHG2095187 IBM SAXENA03 08.02.2021
    //   # Code written for Paraller Request
    //   # Replaced DataExch. record table with DataExch.VIP In ImportXML()
    //   # Replaced DataExch. record table with DataExch.VIP In  CreateDataExch()
    //   # Replaced DataExch. record table with DataExch.VIP In TryCreateIntermediate()
    //   # Replaced DataExch. record table with DataExch.VIP In  CopyIntermediateToTemp()
    //   # Repleaced DataExchField with DataExchFieldVIP in ImportXML()
    //   # Repleaced Intermediate Data Import with Intermediate Data Import VIP table of ImportXML()
    //   # Repleaced Intermediate Data Import with Intermediate Data Import VIP table of CopyIntermediateToTemp()
    //   # Repleaced Intermediate Data Import with Intermediate Data Import VIP table of CreateInboundInterfaceEntry()
    //   # Repleaced Intermediate Data Import with Intermediate Data Import VIP table of CreateInboundInterfaceEntryOnLevel()
    //   # Repleaced Intermediate Data Import with Intermediate Data Import VIP table of CopyIntermediateToTemp()
    //   # Repleaced Intermediate Data Import with Intermediate Data Import VIP table of CreateInboundInterfaceEntryWithDetails()

    //BC Upgrade VAMSIU01 - Start >>
    // # Changed the Variables and parameters from Data Exch. VIP to Data Exch.
    // # Changed the Variables and parameters from Data Exch. Field VIP to Data Exch. Field.
    // # Changed the Variables and parameters from Intermediate Data Import VIP to Intermediate Data Import
    //BC Upgrdae VAMSIU01 - End <<


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

    local procedure ImportXML(IncomingDocumentAttachment: Record "Incoming Document Attachment"): Code[20];
    var
        //BC Upgrade VAMSIU01 >>
        // DataExchVIP: Record "Data Exch. VIP";
        // DataExchFieldVIP: Record "Data Exch. Field VIP";
        DataExchVIP: Record "Data Exch.";
        DataExchFieldVIP: Record "Data Exch. Field";
        //BC Upgrade VAMSIU01 <<
        DataExchangeType: Record "Data Exchange Type";
        DataExchDef: Record "Data Exch. Def";
        //BC Upgrade VAMSIU01 >>
        // IntermediateDataImportVIP: Record "Intermediate Data Import VIP INT";
        IntermediateDataImportVIP: Record "Intermediate Data Import";

        // TempIntermediateDataImportVIP: Record "Intermediate Data Import VIP INT" temporary;
        TempIntermediateDataImportVIP: Record "Intermediate Data Import" temporary;
        //BC Upgrade VAMSIU01 <<
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        InboundInterfaceProcessVIP: Codeunit "Inbound Interface Process VIP";
        InterfaceFrameworkMgtVIP: Codeunit "Interface Framework Mgt. VIP";
    begin
        InterfaceSetup.GET(IncomingDocumentAttachment."Document No.");
        InterfaceSetup.TESTFIELD("Data Exch. Def Code");
        InterfaceSetup.TESTFIELD("Data Exch. Line Def Code");
        DataExchDef.GET(InterfaceSetup."Data Exch. Def Code");
        //<<HEI.03
        /*
        CreateDataExch(DataExch,DataExchDef,IncomingDocumentAttachment);
        IF TryCreateIntermediate(DataExch,DataExchDef) THEN BEGIN
        */
        CreateDataExch(DataExchVIP, DataExchDef, IncomingDocumentAttachment);
        if TryCreateIntermediate(DataExchVIP, DataExchDef) then begin
            //>>HEI.03
            COMMIT;
            //<<HEI.03
            //CopyIntermediateToTemp(IntermediateDataImport,TempIntermediateDataImport,DataExch."Entry No.");
            CopyIntermediateToTemp(IntermediateDataImportVIP, TempIntermediateDataImportVIP, DataExchVIP."Entry No.");
            //>>HEI.03
            //IntermediateDataImport.RESET;
            IntermediateDataImportVIP.RESET;
            //<<HEI.03
            //IntermediateDataImport.SETRANGE("Data Exch. No.",DataExch."Entry No.");
            IntermediateDataImportVIP.SETRANGE("Data Exch. No.", DataExchVIP."Entry No.");
            //>>HEI.03
            //<<HEI.03
            //IntermediateDataImport.DELETEALL(TRUE);
            IntermediateDataImportVIP.DELETEALL(true);
            //>>HEI.03
            //<<HEI.03
            //DataExchField.SETRANGE("Data Exch. No.",DataExch."Entry No.");
            DataExchFieldVIP.SETRANGE("Data Exch. No.", DataExchVIP."Entry No.");
            //>>HEI.03
            DataExchFieldVIP.DELETEALL(true);
            COMMIT;

            /*IF InterfaceSetup."Use Component Detail" THEN BEGIN
              IF SimulateMode THEN BEGIN
                CreateInboundInterfaceEntryWithDetails(InterfaceEntryHeaderVIP,TempIntermediateDataImport,InterfaceSetup.Code);
                InboundInterfaceProcessVIP.SetSimulateMode(SimulateMode);
                InboundInterfaceProcessVIP.RUN(InterfaceEntryHeaderVIP);
              END ELSE BEGIN
                InterfaceEntryHeaderVIP.LOCKTABLE;
                CreateInboundInterfaceEntryWithDetails(InterfaceEntryHeaderVIP,TempIntermediateDataImport,InterfaceSetup.Code);
                IF InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Synchronous THEN BEGIN
                  InboundInterfaceProcessVIP.SetSimulateMode(FALSE);
                  InboundInterfaceProcessVIP.RUN(InterfaceEntryHeaderVIP);
                  ReturnValue := InboundInterfaceProcessVIP.GetReturnValue;
                  InterfaceFrameworkMgtVIP.SetInterfaceProcessed(InterfaceEntryHeaderVIP);
                  InterfaceFrameworkMgtVIP.LogInterfaceEntries(InterfaceEntryHeaderVIP);
                  InterfaceFrameworkMgtVIP.DeleteInterfaceEntries(InterfaceEntryHeaderVIP);
                END;
              END;
            END ELSE BEGIN
              IF InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Synchronous THEN BEGIN
                InterfaceEntryHeaderVIP.LOCKTABLE;
                InterfaceEntryHeaderVIP.SETCURRENTKEY("Interface Code",Status);
                InterfaceEntryHeaderVIP.SETRANGE("Interface Code",InterfaceSetup.Code);
                InterfaceEntryHeaderVIP.SETRANGE(Status,InterfaceEntryHeaderVIP.Status::Pending);
                IF InterfaceEntryHeaderVIP.FINDLAST THEN
                  LastExistingEntry := InterfaceEntryHeaderVIP."Entry No."
                ELSE
                  LastExistingEntry := 0;
                CreateInboundInterfaceEntry(TempIntermediateDataImport,InterfaceSetup.Code);
                IF NOT InterfaceSetup."Skip Processing" THEN BEGIN
                  COMMIT;
                  InterfaceEntryHeaderVIP.SETFILTER("Entry No.",'>%1',LastExistingEntry);
                  InterfaceEntryHeaderVIP.SETRANGE(Direction,InterfaceEntryHeaderVIP.Direction::Inbound);
                  IF InterfaceEntryHeaderVIP.FINDSET THEN
                    REPEAT
                      InboundInterfaceProcessVIP.SetSimulateMode(SimulateMode);
                      InboundInterfaceProcessVIP.RUN(InterfaceEntryHeaderVIP);
                      ReturnValue := InboundInterfaceProcessVIP.GetReturnValue;
                    UNTIL InterfaceEntryHeaderVIP.NEXT = 0;
                END;
              END ELSE*/
            CreateInboundInterfaceEntry(TempIntermediateDataImportVIP, InterfaceSetup.Code);
            //END;
        end else
            //<<HEI.03
            //DataExch.DELETE(TRUE);
            DataExchVIP.DELETE(true);
        //>>HEI.03

    end;

    // BC Upgrade VAMSIU01 - Replaced Var Data Exch. VIP with Data Exch. in CreateDataExch Procedure >>
    local procedure CreateDataExch(var DataExchVIP: Record "Data Exch."; DataExchDef: Record "Data Exch. Def"; IncomingDocumentAttachment: Record "Incoming Document Attachment");
    var
        Stream: InStream;
    begin
        IncomingDocumentAttachment.Content.CREATEINSTREAM(Stream);
        /*
        DataExch.INIT;
        DataExch.InsertRec(IncomingDocumentAttachment.Name,Stream,DataExchDef.Code);
        GeneralInterfaceSetup.GET;
        DataExch."File Encoding" := GeneralInterfaceSetup."XML Encoding";
        DataExch.MODIFY(TRUE);
        */
        DataExchVIP.INIT;
        DataExchVIP.InsertRec(IncomingDocumentAttachment.Name, Stream, DataExchDef.Code);
        GeneralInterfaceSetup.GET;
        DataExchVIP."File Encoding FND" := GeneralInterfaceSetup."XML Encoding";
        DataExchVIP.MODIFY(true);

    end;

    // BC Upgrade VAMSIU01 - Replaced Var Data Exch. VIP with Data Exch. in TryCreateIntermediate Procedure
    local procedure TryCreateIntermediate(DataExchVIP: Record "Data Exch."; DataExchDef: Record "Data Exch. Def"): Boolean;
    begin
        COMMIT;
        if DataExchDef."Reading/Writing Codeunit" <> 0 then begin
            //<<HEI.03
            //CODEUNIT.RUN(DataExchDef."Reading/Writing Codeunit",DataExch);
            CODEUNIT.RUN(DataExchDef."Reading/Writing Codeunit", DataExchVIP);
            //>>HEI.03

            if DataExchDef."Data Handling Codeunit" <> 0 then
                //<<HEI.03
                //CODEUNIT.RUN(DataExchDef."Data Handling Codeunit",DataExch);
                CODEUNIT.RUN(DataExchDef."Data Handling Codeunit", DataExchVIP);
            //>>HEI.03
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

    // BC Upgrade VAMSIU01 - Replaced Var Intermediate Data Import VIP with Intermediate Data Import in CreateInboundInterfaceEntry Procedure
    local procedure CreateInboundInterfaceEntry(var IntermediateDataImportVIP: Record "Intermediate Data Import"; InterfaceCode: Code[20]);
    var
        IntermediateDataImport2VIP: Record "Interm. Data Import VIP INT" temporary;
        "Field": Record "Field";
        EntryNos: array[3] of Integer;
    begin
        //<<HEI.03
        //CreateInboundInterfaceEntryOnLevel(IntermediateDataImport,EntryNos,1,'0|1',InterfaceCode);
        CreateInboundInterfaceEntryOnLevel(IntermediateDataImportVIP, EntryNos, 1, '0|1', InterfaceCode);
        //>>HEI.03
    end;

    // BC Upgrade VAMSIU01 - Replaced Var Intermediate Data Import VIP with Intermediate Data Import in CreateInboundInterfaceEntryOnLevel Procedure
    local procedure CreateInboundInterfaceEntryOnLevel(var IntermediateDataImportVIP: Record "Intermediate Data Import"; var EntryNos: array[3] of Integer; LevelNo: Integer; ParentRecordNoFilter: Text; InterfaceCode: Code[20]);
    var
        IntermediateDataImport2VIP: Record "Intermediate Data Import" temporary;
        "Field": Record "Field";
        //TempBlob: Record TempBlob temporary; //BC Upgrade GUNREM01 
        TempBlob: Codeunit "Temp Blob"; //BC Upgrade GUNREM01
        InterfaceFrameworkMgtVIP: Codeunit "Interface Framework Mgt. VIP";
        RecRef: RecordRef;
        FldRef: FieldRef;
        OutStr: OutStream;
        PreviousTableID: Integer;
        PreviousRecordNo: Integer;
        EntryNo: Integer;
    begin
        //<<HEI.03
        /*
        CopyIntermediateToTemp(IntermediateDataImport,IntermediateDataImport2,IntermediateDataImport."Data Exch. No.");
        
        IntermediateDataImport.RESET;
        IntermediateDataImport.SETCURRENTKEY("Data Exch. No.","Table ID","Record No.","Field ID");
        CASE LevelNo OF
          1: IntermediateDataImport.SETRANGE("Table ID",DATABASE::"Interface Entry Header VIP INT");
          2: IntermediateDataImport.SETRANGE("Table ID",DATABASE::"Interface Entry Line VIP INT");
        END;
        IntermediateDataImport.SETFILTER("Parent Record No.",ParentRecordNoFilter);
        IntermediateDataImport.SETFILTER("Field ID",'<>%1',0);
        IntermediateDataImport.SETFILTER(Value,'<>%1','');
        IF IntermediateDataImport.FINDSET THEN BEGIN
        */

        CopyIntermediateToTemp(IntermediateDataImportVIP, IntermediateDataImport2VIP, IntermediateDataImportVIP."Data Exch. No.");

        IntermediateDataImportVIP.RESET;
        IntermediateDataImportVIP.SETCURRENTKEY("Data Exch. No.", "Table ID", "Record No.", "Field ID");
        case LevelNo of
            1:
                IntermediateDataImportVIP.SETRANGE("Table ID", DATABASE::"Interface Entry Header VIP INT");
            2:
                IntermediateDataImportVIP.SETRANGE("Table ID", DATABASE::"Interface Entry Line VIP INT");
        end;
        IntermediateDataImportVIP.SETFILTER("Parent Record No.", ParentRecordNoFilter);
        IntermediateDataImportVIP.SETFILTER("Field ID", '<>%1', 0);
        IntermediateDataImportVIP.SETFILTER(Value, '<>%1', '');
        if IntermediateDataImportVIP.FINDSET then begin
            //>>HEI.03
            repeat
                //<<HEI.03
                //IF IntermediateDataImport."Record No." <> PreviousRecordNo THEN BEGIN
                if IntermediateDataImportVIP."Record No." <> PreviousRecordNo then begin
                    //>>HEI.03
                    if PreviousRecordNo <> 0 then begin
                        RecRef.INSERT(true);
                        //<<HEI.03
                        //IF IntermediateDataImport."Table ID" = DATABASE::"Interface Entry Header VIP INT" THEN BEGIN
                        if IntermediateDataImportVIP."Table ID" = DATABASE::"Interface Entry Header VIP INT" then begin
                            //>>HEI.03
                            CLEAR(EntryNos);
                            FldRef := RecRef.FIELD(1);
                            EntryNos[1] := FldRef.VALUE;
                        end;
                        //IF LevelNo < 3 THEN   //commented by HEI.02
                        if LevelNo < 2 then   //HEI.02
                                              //<<HEI.03
                                              //CreateInboundInterfaceEntryOnLevel(IntermediateDataImport2,EntryNos,LevelNo + 1,FORMAT(PreviousRecordNo),InterfaceCode);
                            CreateInboundInterfaceEntryOnLevel(IntermediateDataImport2VIP, EntryNos, LevelNo + 1, FORMAT(PreviousRecordNo), InterfaceCode);
                        //>>HEI.03
                    end;
                    CLEAR(RecRef);
                    //<<HEI.03
                    //RecRef.OPEN(IntermediateDataImport."Table ID");
                    RecRef.OPEN(IntermediateDataImportVIP."Table ID");
                    //>>HEI.03
                    case LevelNo of
                        1:
                            begin
                                FldRef := RecRef.FIELD(2);
                                InterfaceFrameworkMgtVIP.SetFieldValue(FldRef, InterfaceCode);
                                FldRef := RecRef.FIELD(500);
                                //<<HEI.03
                                //InterfaceFrameworkMgt.SetFieldValue(FldRef,FORMAT(IntermediateDataImport."Data Exch. No."));
                                InterfaceFrameworkMgtVIP.SetFieldValue(FldRef, FORMAT(IntermediateDataImportVIP."Data Exch. No."));
                                //>>HEI.03
                            end;
                        2:
                            begin
                                FldRef := RecRef.FIELD(1);
                                InterfaceFrameworkMgtVIP.SetFieldValue(FldRef, FORMAT(EntryNos[1]));
                                EntryNo := EntryNo + 1;
                                EntryNos[2] := EntryNo;
                                FldRef := RecRef.FIELD(2);
                                InterfaceFrameworkMgtVIP.SetFieldValue(FldRef, FORMAT(EntryNo));
                                FldRef := RecRef.FIELD(500);
                                //<<HEI.03
                                //InterfaceFrameworkMgt.SetFieldValue(FldRef,FORMAT(IntermediateDataImport."Data Exch. No."));
                                InterfaceFrameworkMgtVIP.SetFieldValue(FldRef, FORMAT(IntermediateDataImportVIP."Data Exch. No."));
                                //>>HEI.03
                            end;
                        3:
                            begin
                                FldRef := RecRef.FIELD(1);
                                InterfaceFrameworkMgtVIP.SetFieldValue(FldRef, FORMAT(EntryNos[1]));
                                FldRef := RecRef.FIELD(2);
                                InterfaceFrameworkMgtVIP.SetFieldValue(FldRef, FORMAT(EntryNos[2]));
                                EntryNo := EntryNo + 1;
                                EntryNos[3] := EntryNo;
                                FldRef := RecRef.FIELD(4);
                                InterfaceFrameworkMgtVIP.SetFieldValue(FldRef, FORMAT(EntryNo));
                                FldRef := RecRef.FIELD(500);
                                //<<HEI.03
                                //InterfaceFrameworkMgt.SetFieldValue(FldRef,FORMAT(IntermediateDataImport."Data Exch. No."));
                                InterfaceFrameworkMgtVIP.SetFieldValue(FldRef, FORMAT(IntermediateDataImportVIP."Data Exch. No."));
                                //>>HEI.03
                            end;
                    end;
                end;
                //<<HEI.03
                //FldRef := RecRef.FIELD(IntermediateDataImport."Field ID");
                FldRef := RecRef.FIELD(IntermediateDataImportVIP."Field ID");
                //>>HEI.03
                EVALUATE(Field.Type, FORMAT(FldRef.TYPE));
                if Field.Type <> Field.Type::BLOB then
                    //<<HEI.03
                    //InterfaceFrameworkMgt.SetFieldValue(FldRef,IntermediateDataImport.Value)
                    InterfaceFrameworkMgtVIP.SetFieldValue(FldRef, IntermediateDataImportVIP.Value)
                //>>HEI.03
                else
                    //<<HEI.03
                    /*
                      IF IntermediateDataImport."Big Value".HASVALUE THEN BEGIN
                        IntermediateDataImport.CALCFIELDS("Big Value");
                        FldRef.VALUE := IntermediateDataImport."Big Value";
                    */
                    if IntermediateDataImportVIP."Big Value FND".HASVALUE then begin
                        IntermediateDataImportVIP.CALCFIELDS("Big Value FND");
                        FldRef.VALUE := IntermediateDataImportVIP."Big Value FND";
                        //>>HEI.03
                    end else begin
                        CLEAR(OutStr);
                        CLEAR(TempBlob);
                        //  TempBlob.Blob.CREATEOUTSTREAM(OutStr); //BC Upgrade GUNREM01 Tempblob is record is obsolete
                        TempBlob.CreateOutStream(OutStr);//BC Upgrade GUNREM01 added
                        //<<HEI.03 
                        //OutStr.WRITETEXT(IntermediateDataImport.Value);
                        OutStr.WRITETEXT(IntermediateDataImportVIP.Value);
                        //>>HEI.03
                        //   FldRef.VALUE := TempBlob.Blob; // BC Upgrade GUNREM01 - Blocked as Tempblob is record is obsolete
                        FldRef.VALUE := TempBlob; // BC Upgrade GUNREM01 - Added
                    end;
                //<<HEI.03
                //PreviousRecordNo :=  IntermediateDataImport."Record No.";
                PreviousRecordNo := IntermediateDataImportVIP."Record No.";
            //>>HEI.03
            //<<HEI.03
            //UNTIL IntermediateDataImport.NEXT = 0;
            until IntermediateDataImportVIP.NEXT = 0;
            //>>HEI.03
            RecRef.INSERT(true);
            //<<HEI.03
            //IF IntermediateDataImport."Table ID" = DATABASE::"Interface Entry Header VIP INT" THEN BEGIN
            if IntermediateDataImportVIP."Table ID" = DATABASE::"Interface Entry Header VIP INT" then begin
                //>>HEI.03
                CLEAR(EntryNos);
                FldRef := RecRef.FIELD(1);
                EntryNos[1] := FldRef.VALUE;
            end;
            //IF LevelNo < 3 THEN   //commented by HEI.02
            if LevelNo < 2 then   //HEI.02
                                  //<<HEI.03
                                  //CreateInboundInterfaceEntryOnLevel(IntermediateDataImport2,EntryNos,LevelNo + 1,FORMAT(IntermediateDataImport."Record No."),InterfaceCode);
                CreateInboundInterfaceEntryOnLevel(IntermediateDataImport2VIP, EntryNos, LevelNo + 1, FORMAT(IntermediateDataImportVIP."Record No."), InterfaceCode);
            //>>HEI.03
        end;

    end;

    // BC Upgrade VAMSIU01 - Replaced Var Intermediate Data Import VIP with Intermediate Data Import in CreateInboundInterfaceEntryWithDetails Procedure
    local procedure CreateInboundInterfaceEntryWithDetails(var InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT"; var IntermediateDataImportVIP: Record "Intermediate Data Import"; InterfaceCode: Code[20]);
    var
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        TempKeyFldId: Record "Integer" temporary;
        RecRef: RecordRef;
        FldRef: FieldRef;
        "Key": KeyRef;
        PreviousTableID: Integer;
        PreviousRecordNo: Integer;
        i: Integer;
        EntryNo: Integer;
    begin
        InterfaceEntryLineVIP.LOCKTABLE;
        //<<HEI.03
        /*
        IntermediateDataImport.RESET;
        IntermediateDataImport.SETCURRENTKEY("Data Exch. No.","Table ID","Record No.","Field ID");
        IntermediateDataImport.SETFILTER("Table ID",'<>%1',0);
        IntermediateDataImport.SETFILTER("Field ID",'<>%1',0);
        IF IntermediateDataImport.FINDSET THEN BEGIN
        */
        IntermediateDataImportVIP.RESET;
        IntermediateDataImportVIP.SETCURRENTKEY("Data Exch. No.", "Table ID", "Record No.", "Field ID");
        IntermediateDataImportVIP.SETFILTER("Table ID", '<>%1', 0);
        IntermediateDataImportVIP.SETFILTER("Field ID", '<>%1', 0);
        if IntermediateDataImportVIP.FINDSET then begin
            //>>HEI.03
            CLEAR(InterfaceEntryHeaderVIP);
            InterfaceEntryHeaderVIP."Interface Code" := InterfaceCode;
            InterfaceEntryHeaderVIP.Direction := InterfaceEntryHeaderVIP.Direction::Inbound;
            InterfaceEntryHeaderVIP."Sync. Date" := CURRENTDATETIME;
            InterfaceEntryHeaderVIP.Status := InterfaceEntryHeaderVIP.Status::Pending;
            //<<HEI.03
            //InterfaceEntryHeaderVIP."Source Type" := IntermediateDataImport."Table ID";
            InterfaceEntryHeaderVIP."Source Type" := IntermediateDataImportVIP."Table ID";
            //>>HEI.03
            InterfaceEntryHeaderVIP.INSERT;

            CLEAR(InterfaceEntryLineVIP);
            InterfaceEntryLineVIP."Header Entry No." := InterfaceEntryHeaderVIP."Entry No.";
            EntryNo := EntryNo + 1;
            InterfaceEntryLineVIP."Entry No." := EntryNo;
            InterfaceEntryLineVIP.INSERT;

            PreviousTableID := 0;
            PreviousRecordNo := 0;
            repeat
                //<<HEI.03
                /*
                IF (IntermediateDataImport."Table ID" <> PreviousTableID) OR
                   ((IntermediateDataImport."Table ID" = PreviousTableID) AND (IntermediateDataImport."Record No." <> PreviousRecordNo))
                */
                if (IntermediateDataImportVIP."Table ID" <> PreviousTableID) or
                   ((IntermediateDataImportVIP."Table ID" = PreviousTableID) and (IntermediateDataImportVIP."Record No." <> PreviousRecordNo))
                //>>HEI.03
                then begin
                    CLEAR(RecRef);
                    CLEAR(FldRef);
                    CLEAR(Key);
                    TempKeyFldId.RESET;
                    TempKeyFldId.DELETEALL;
                    //<<HEI.03
                    //RecRef.OPEN(IntermediateDataImport."Table ID");
                    RecRef.OPEN(IntermediateDataImportVIP."Table ID");
                    //>>HEI.03
                    Key := RecRef.KEYINDEX(1);
                    for i := 1 to Key.FIELDCOUNT do begin
                        FldRef := Key.FIELDINDEX(i);
                        CLEAR(TempKeyFldId);
                        TempKeyFldId.Number := FldRef.NUMBER;
                        TempKeyFldId.INSERT;
                    end;
                    RecRef.CLOSE;
                end;
                //<<HEI.03
                /*
                PreviousTableID := IntermediateDataImport."Table ID";
                PreviousRecordNo := IntermediateDataImport."Record No.";
              UNTIL IntermediateDataImport.NEXT = 0;
                */
                PreviousTableID := IntermediateDataImportVIP."Table ID";
                PreviousRecordNo := IntermediateDataImportVIP."Record No.";
            until IntermediateDataImportVIP.NEXT = 0;
            //>>HEI.03
        end;

    end;

    // BC Upgrade VAMSIU01 - Replaced Var Intermediate Data Import VIP with Intermediate Data Import in CopyIntermediateToTemp Procedure
    local procedure CopyIntermediateToTemp(var IntermediateDataImportVIP: Record "Intermediate Data Import"; var TempIntermediateDataImportVIP: Record "Intermediate Data Import"; DataExchEntryNo: Integer);
    begin
        //<<HEI.03
        /*
        IntermediateDataImport.RESET;
        IntermediateDataImport.SETRANGE("Data Exch. No.",DataExchEntryNo);
        IF IntermediateDataImport.FINDSET THEN
          REPEAT
            CLEAR(TempIntermediateDataImport);
            IntermediateDataImport.CALCFIELDS("Big Value");
            TempIntermediateDataImport := IntermediateDataImport;
            TempIntermediateDataImport.INSERT;
          UNTIL IntermediateDataImport.NEXT = 0;
        IntermediateDataImport.RESET;
        TempIntermediateDataImport.RESET;
        */

        IntermediateDataImportVIP.RESET;
        IntermediateDataImportVIP.SETRANGE("Data Exch. No.", DataExchEntryNo);
        if IntermediateDataImportVIP.FINDSET then
            repeat
                CLEAR(TempIntermediateDataImportVIP);
                IntermediateDataImportVIP.CALCFIELDS("Big Value FND");
                TempIntermediateDataImportVIP := IntermediateDataImportVIP;
                TempIntermediateDataImportVIP.INSERT;
            until IntermediateDataImportVIP.NEXT = 0;
        IntermediateDataImportVIP.RESET;
        TempIntermediateDataImportVIP.RESET;
        //>>HEI.03

    end;

    local procedure TableIsMasterData(TableID: Integer): Boolean;
    begin
        exit(TableID in [DATABASE::Item, DATABASE::Vendor, DATABASE::Customer]);
    end;

    local procedure FieldIsMasterTableRelation(TableID: Integer; FieldID: Integer): Boolean;
    begin
        case TableID of
            DATABASE::"Item Translation",
          DATABASE::"Item Unit of Measure",
        //   DATABASE::"Item Cross Reference",  // BC Upgrade GUNREM01 - Blocked as Item Cross Reference table is obsolete
        DATABASE::"Item Reference", //BC Upgrade GUNREM01 - Replaced Item Cross Reference with Item Reference table
          DATABASE::"Stockkeeping Unit",
          DATABASE::"Vendor Bank Account":
                exit(FieldID = 1);
            DATABASE::"Item Attribute Value Mapping":
                exit(FieldID = 2);
            DATABASE::"Default Dimension":
                exit(FieldID = 2);
            DATABASE::"Customer Attributes FND":
                exit(FieldID = 1);
            DATABASE::"Customer Bank Account":
                exit(FieldID = 1);
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
        if RecRef.FINDFIRST then begin
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

        GeneralInterfaceSetup.GET;
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
}

