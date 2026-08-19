codeunit 58001 "Outbound Interface Processing"
{
    // Heilite Navision Old Id - 50002

    // version HEI.02

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New codeunit for Interface Common Framework
    // HEI.02 CHG2095189 IBM SAXENA03 27.01.2021
    //   # # Code written for Sales Order optimizaiton
    //   # Added RESET, SetCurrentKey function in CreateInterfaceXML()
    //   # Created and added a new Funciton "CreateDataExchFull" to remove modify and insert together in function CreateInterfaceXML()
    //   # Replace RePEAT..UNTIL with MODIFYALL.
    // HEI.03 CHG2095187 IBM SAXENA03 27.01.2021
    //   # Code written for Parallel Request
    //   # COMMIT added after function CreateDataExchFull() in CreateInterfaceXML().
    //   # COMMIT added after InterfaceEntryHeader.MODIFY; in CreateInterfaceXML().
    //   # COMMIT added after InterfaceEntryLine.MODIFYALL; in CreateInterfaceXML().
    //   # COMMIT added after InterfaceEntryComponent.MODIFYAll; in CreateInterfaceXML().
    // HEI.04 CHG2112261 IBM SAXENA03 20.05.2021
    //   # Interface Logging processing Execution Time and Webservices Response Times
    //   # Added new Parameter in Function CreateDataExchFull()
    //   # Added new application code to to Update Start execution and End execution date
    //     of Table 50001 in Function RUN();

    TableNo = "Interface Entry Header INT";

    trigger OnRun();
    var
        InterfaceEntryHeader: Record "Interface Entry Header INT";
    begin
        //<<HEI.04
        CLEAR(StartExecutionTime);
        CLEAR(EndExecutionTime);
        StartExecutionTime := CURRENTDATETIME;
        //>>HEI.04

        CreateInterfaceXML(Rec);

        //<<HEI.04
        EndExecutionTime := CURRENTDATETIME;
        if InterfaceEntryHeader.GET(Rec."Entry No.") then begin
            InterfaceEntryHeader."Start Execution" := StartExecutionTime;
            InterfaceEntryHeader."End Execution" := EndExecutionTime;
            InterfaceEntryHeader.MODIFY(false);
        end;
        //>>HEI.04
    end;

    var
        InterfaceNotEnabledErr: Label 'Interface %1 is not enabled.';
        StartExecutionTime: DateTime;
        EndExecutionTime: DateTime;

    local procedure CreateInterfaceXML(var InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        DataExch: Record "Data Exch.";
        DataExchDef: Record "Data Exch. Def";
        DataExchLineDef: Record "Data Exch. Line Def";
        DataExchMapping: Record "Data Exch. Mapping";
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        ParentDataExchNo: Integer;
    begin
        InterfaceSetup.GET(InterfaceEntryHeader."Interface Code");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        InterfaceSetup.TESTFIELD("Data Exch. Def Code");
        InterfaceSetup.TESTFIELD("Data Exch. Line Def Code");
        if InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Asynchronous then begin
            InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            OutboundInterface.TESTFIELD(Endpoint);
        end;
        DataExchDef.GET(InterfaceSetup."Data Exch. Def Code");

        DataExchDef.TESTFIELD("Reading/Writing Codeunit");
        DataExchDef.TESTFIELD("Ext. Data Handling Codeunit");


        //<<HEI.02
        DataExchLineDef.RESET();
        DataExchLineDef.SETCURRENTKEY("Data Exch. Def Code");
        //>>HEI.02
        DataExchLineDef.SETRANGE("Data Exch. Def Code", DataExchDef.Code);
        //<<HEI.02
        //IF DataExchLineDef.FINDSET THEN
        if DataExchLineDef.findset(false) then
            //>>HEI.02
            repeat
                DataExchLineDef.TESTFIELD("Data Line Tag");
                //<<HEI.02
                /*
                CreateDataExch(DataExch,DataExchLineDef."Data Exch. Def Code",DataExchLineDef.Code,InterfaceSetup.RECORDID);
                IF DataExchLineDef.Code = InterfaceSetup."Data Exch. Line Def Code" THEN
                  ParentDataExchNo := DataExch."Entry No.";
                DataExch."Parent Data Exch. No." := ParentDataExchNo;
                DataExch.MODIFY;
                */
                //<<HEI.04
                /*
                ParentDataExchNo:=CreateDataExchFull(DataExch,DataExchLineDef."Data Exch. Def Code",
                                                     DataExchLineDef.Code,
                                                     InterfaceSetup.RECORDID,
                                                     InterfaceSetup."Data Exch. Line Def Code",
                                                     ParentDataExchNo);
                  */
                ParentDataExchNo := CreateDataExchFull(DataExch, DataExchLineDef."Data Exch. Def Code",
                                                     DataExchLineDef.Code,
                                                     InterfaceSetup.RECORDID,
                                                     InterfaceSetup."Data Exch. Line Def Code",
                                                     ParentDataExchNo,
                                                     InterfaceEntryHeader."Entry No.");
                //>>HEI.04
                //>>HEI.02

                //<<HEI.03
                COMMIT();
                //>>HEI.03

                DataExchMapping.RESET();
                DataExchMapping.SETCURRENTKEY("Data Exch. Def Code", "Data Exch. Line Def Code");
                //>>HEI.02
                DataExchMapping.SETRANGE("Data Exch. Def Code", DataExchLineDef."Data Exch. Def Code");
                DataExchMapping.SETRANGE("Data Exch. Line Def Code", DataExchLineDef.Code);
                DataExchMapping.FINDFIRST();
                DataExchMapping.TESTFIELD("Mapping Codeunit");
                case DataExchMapping."Table ID" of
                    DATABASE::"Interface Entry Header INT":
                        begin
                            InterfaceEntryHeader."Data Exch. Entry No." := DataExch."Entry No.";
                            InterfaceEntryHeader.MODIFY();
                            //<<HEI.03
                            COMMIT();
                            //>>HEI.03
                        end;
                    DATABASE::"Interface Entry Line INT":
                        begin
                            //<<HEI.02
                            InterfaceEntryLine.RESET();
                            InterfaceEntryLine.SETCURRENTKEY("Entry No.");
                            //>>HEI.02
                            InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                            if InterfaceEntryLine.findset(false) then
                                //<<HEI.02
                                /*
                                  REPEAT
                                    InterfaceEntryLine."Data Exch. Entry No." := DataExch."Entry No.";
                                    InterfaceEntryLine.MODIFY;
                                  UNTIL InterfaceEntryLine.NEXT = 0;
                                 */
                   InterfaceEntryLine.MODIFYALL("Data Exch. Entry No.", DataExch."Entry No.");
                            //>>HEI.02

                            //<<HEI.03
                            COMMIT();
                            //>>HEI.03
                        end;
                    DATABASE::"Interface Entry Component INT":
                        begin
                            //<<HEI.02
                            InterfaceEntryComponent.RESET();
                            InterfaceEntryComponent.SETCURRENTKEY("Header Entry No.");
                            //>>HEI.02
                            InterfaceEntryComponent.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                            if InterfaceEntryComponent.findset(false) then
                                //<<HEI.02
                                /*
                                  REPEAT
                                    InterfaceEntryComponent."Data Exch. Entry No." := DataExch."Entry No.";
                                    InterfaceEntryComponent.MODIFY;
                                  UNTIL InterfaceEntryComponent.NEXT = 0;
                                */
                  InterfaceEntryComponent.MODIFYALL("Data Exch. Entry No.", DataExch."Entry No.");
                            //>>HEI.02

                            //<<HEI.03
                            COMMIT();
                            //>>HEI.03
                        end;
                end;

                CODEUNIT.RUN(DataExchMapping."Mapping Codeunit", DataExch);
            until DataExchLineDef.NEXT() = 0;

        if DataExch.GET(ParentDataExchNo) then begin
            CODEUNIT.RUN(DataExchDef."Reading/Writing Codeunit", DataExch);
            if InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Asynchronous then
                CODEUNIT.RUN(DataExchDef."Ext. Data Handling Codeunit", DataExch);
        end;

    end;

    procedure CreateDataExch(var DataExch: Record "Data Exch."; DataExchDefCode: Code[20]; DataExchDefLineCode: Code[20]; InterfaceRecID: RecordID);
    begin
        CLEAR(DataExch);
        DataExch."Data Exch. Def Code" := DataExchDefCode;
        DataExch."Data Exch. Line Def Code" := DataExchDefLineCode;
        DataExch."Related Record" := InterfaceRecID;
        DataExch.INSERT(true);
    end;

    procedure CreateDataExchFull(var DataExch: Record "Data Exch."; DataExchDefCode: Code[20]; DataExchDefLineCode: Code[20]; InterfaceRecID: RecordID; InterFaceCode: Code[20]; MParentEntryNo: Integer; InterfaceEntryHdrNo: Integer) ParentLineNo: Integer;
    begin
        //<<HEI.02
        CLEAR(DataExch);
        DataExch."Data Exch. Def Code" := DataExchDefCode;
        DataExch."Data Exch. Line Def Code" := DataExchDefLineCode;
        DataExch."Related Record" := InterfaceRecID;
        DataExch."Parent Data Exch. No. FND" := MParentEntryNo;
        //<<HEI.04
        DataExch."Interface Entry Header No. FND" := InterfaceEntryHdrNo;
        //>>HEI.04
        DataExch.INSERT(true);
        if DataExchDefLineCode = InterFaceCode then begin
            MParentEntryNo := DataExch."Entry No.";
            DataExch."Parent Data Exch. No. FND" := MParentEntryNo;
            DataExch.MODIFY(false);
        end;
        exit(MParentEntryNo);
        //>>HEI.02
    end;
}

