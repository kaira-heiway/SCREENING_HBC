codeunit 58010 "Outbound Interface Process VIP"
{
    // Heilite Navision Old Id - 50094
    // version HEI.01

    // HEI.01 HT1010 IBM NASTAA02 28.11.2019 # Maraki dedicated Job Queue - CHG2039961
    //   # New Codeunit created
    // HEI.02 CHG2095187 IBM SAXENA03 08.02.2021
    //   # Code written for Paraller Request
    //   # Added RESET, SetCurrentKey function in CreateInterfaceXML()
    //   # Created and added a new Funciton "CreateDataExchFull" to remove modify and insert together in function CreateInterfaceXML()
    //   # Replace RePEAT..UNTIL with MODIFYALL.
    //   # Replaced DataExch. record table with DataExch.VIP In CreateInterfaceXML()
    //   # Replaced DataExch. record table with DataExch.VIP In  CreateDataExch()
    //   # Replaced DataExch. record table with DataExch.VIP In CODEUNIT.RUN()
    //   # Replaced DataExch. record table with DataExch.VIP In CreateDataExchFull()
    //   # Add COMMIT after CreateDataExchFull function
    //   # Add COMMIT after InterfaceEntryHeaderVIP.MODIFY; function
    // HEI.03 CHG2112261 IBM SAXENA03 20.05.2021
    //   # Iterface Logging processing Execution Time and Webservices Response Times
    //   # Added new Parameter in Function CreateDataExchFull()
    //   # Added new application code to Update Start execution and End execution date
    //     of Table 50161 in Function RUN();

    TableNo = "Interface Entry Header VIP INT";

    trigger OnRun();
    var
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
    begin
        //<<HEI.03
        CLEAR(StartExecutionTime);
        CLEAR(EndExecutionTime);
        StartExecutionTime := CURRENTDATETIME;
        //>>HEI.03

        CreateInterfaceXML(Rec);

        //<<HEI.03
        EndExecutionTime := CURRENTDATETIME;
        if InterfaceEntryHeaderVIP.GET(Rec."Entry No.") then begin
            InterfaceEntryHeaderVIP."Start Execution" := StartExecutionTime;
            InterfaceEntryHeaderVIP."End Execution" := EndExecutionTime;
            InterfaceEntryHeaderVIP.MODIFY(false);
        end;
        //>>HEI.03
    end;

    var
        InterfaceNotEnabledErr: Label 'Interface %1 is not enabled.';
        StartExecutionTime: DateTime;
        EndExecutionTime: DateTime;

    local procedure CreateInterfaceXML(var InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        //BC Upgrade VAMSIU01 >>
        //DataExchVIP: Record "Data Exch. VIP";
        DataExchVIP: Record "Data Exch.";
        //BC Upgrade VAMSIU01 <<
        DataExchDef: Record "Data Exch. Def";
        DataExchLineDef: Record "Data Exch. Line Def";
        DataExchMapping: Record "Data Exch. Mapping";
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceFrameworkMgtVIP: Codeunit "Interface Framework Mgt. VIP";
        ParentDataExchNo: Integer;
    begin
        InterfaceSetup.GET(InterfaceEntryHeaderVIP."Interface Code");

        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        InterfaceSetup.TESTFIELD("Data Exch. Def Code");
        InterfaceSetup.TESTFIELD("Data Exch. Line Def Code");
        if InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Asynchronous then begin
            InterfaceFrameworkMgtVIP.GetOutboundInterface(InterfaceSetup, OutboundInterface);
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
                //<<HEI.03
                /*
                ParentDataExchNo:=CreateDataExchFull(DataExchVIP,DataExchLineDef."Data Exch. Def Code",
                                                       DataExchLineDef.Code,
                                                       InterfaceSetup.RECORDID,
                                                       InterfaceSetup."Data Exch. Line Def Code",
                                                       ParentDataExchNo);
                          */
                ParentDataExchNo := CreateDataExchFull(DataExchVIP, DataExchLineDef."Data Exch. Def Code",
                                                     DataExchLineDef.Code,
                                                     InterfaceSetup.RECORDID,
                                                     InterfaceSetup."Data Exch. Line Def Code",
                                                     ParentDataExchNo,
                                                     InterfaceEntryHeaderVIP."Entry No.");
                //>>HEI.03
                COMMIT();//HEI.02
                         /*
                          CreateDataExch(DataExch,DataExchLineDef."Data Exch. Def Code",DataExchLineDef.Code,InterfaceSetup.RECORDID);
                          IF DataExchLineDef.Code = InterfaceSetup."Data Exch. Line Def Code" THEN
                            ParentDataExchNo := DataExch."Entry No.";
                          DataExch."Parent Data Exch. No." := ParentDataExchNo;
                          DataExch.MODIFY;
                         */
                DataExchMapping.RESET();
                DataExchMapping.SETCURRENTKEY("Data Exch. Def Code", "Data Exch. Line Def Code");
                //<<HEI.02
                DataExchMapping.SETRANGE("Data Exch. Def Code", DataExchLineDef."Data Exch. Def Code");
                DataExchMapping.SETRANGE("Data Exch. Line Def Code", DataExchLineDef.Code);
                DataExchMapping.FINDFIRST();
                DataExchMapping.TESTFIELD("Mapping Codeunit");
                case DataExchMapping."Table ID" of
                    DATABASE::"Interface Entry Header VIP INT":
                        begin
                            //<<HEI.02
                            //InterfaceEntryHeaderVIP."Data Exch. Entry No." := DataExch."Entry No.";
                            InterfaceEntryHeaderVIP."Data Exch. Entry No." := DataExchVIP."Entry No.";
                            //>>HEI.02
                            InterfaceEntryHeaderVIP.MODIFY();
                            COMMIT();//HEI.02
                        end;
                    DATABASE::"Interface Entry Line VIP INT":
                        begin
                            //<<HEI.02
                            InterfaceEntryLineVIP.RESET();
                            InterfaceEntryLineVIP.SETCURRENTKEY("Entry No.");
                            //>>HEI.02
                            InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
                            if InterfaceEntryLineVIP.findset() then
                                //<<HEI.02
                                /*
                                  REPEAT
                                    InterfaceEntryLineVIP."Data Exch. Entry No." := DataExch."Entry No.";
                                    InterfaceEntryLineVIP.MODIFY;
                                  UNTIL InterfaceEntryLineVIP.NEXT = 0;
                                */
                   InterfaceEntryLineVIP.MODIFYALL("Data Exch. Entry No.", DataExchVIP."Entry No.");
                            //>>HEI.02

                        end;
                /*
                  DATABASE::Record "Interface Entry Component INT":
                  BEGIN
                    InterfaceEntryComponent.SETRANGE("Header Entry No.",InterfaceEntryHeaderVIP."Entry No.");
                    IF InterfaceEntryComponent.FINDSET THEN
                      REPEAT
                        InterfaceEntryComponent."Data Exch. Entry No." := DataExch."Entry No.";
                        InterfaceEntryComponent.MODIFY;
                      UNTIL InterfaceEntryComponent.NEXT = 0;
                  END;
                  */
                end;
                //<<HEI.02
                //CODEUNIT.RUN(DataExchMapping."Mapping Codeunit",DataExch);
                CODEUNIT.RUN(DataExchMapping."Mapping Codeunit", DataExchVIP);
            //>>HEI.02
            until DataExchLineDef.NEXT() = 0;

        //<<HEI.02
        /*
        IF DataExch.GET(ParentDataExchNo) THEN BEGIN
          CODEUNIT.RUN(DataExchDef."Reading/Writing Codeunit",DataExch);
          IF InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Asynchronous THEN
            CODEUNIT.RUN(DataExchDef."Ext. Data Handling Codeunit",DataExch);
        END;
        */
        if DataExchVIP.GET(ParentDataExchNo) then begin
            CODEUNIT.RUN(DataExchDef."Reading/Writing Codeunit", DataExchVIP);
            if InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Asynchronous then
                CODEUNIT.RUN(DataExchDef."Ext. Data Handling Codeunit", DataExchVIP);
        end;

        //>>HEI.02

    end;

    procedure CreateDataExch(var DataExch: Record "Data Exch."; DataExchDefCode: Code[20]; DataExchDefLineCode: Code[20]; InterfaceRecID: RecordID);
    begin
        CLEAR(DataExch);
        DataExch."Data Exch. Def Code" := DataExchDefCode;
        DataExch."Data Exch. Line Def Code" := DataExchDefLineCode;
        DataExch."Related Record" := InterfaceRecID;
        DataExch.INSERT(true);
    end;

    //BC Upgrade VAMSIU01 Changed from Data Exch VIP to Data Exch.>>
    procedure CreateDataExchFull(var DataExchVIP: Record "Data Exch."; DataExchDefCode: Code[20]; DataExchDefLineCode: Code[20]; InterfaceRecID: RecordID; InterFaceCode: Code[20]; MParentEntryNo: Integer; InterfaceEntryHdrNo: Integer) ParentLineNo: Integer;
    begin
        //<<HEI.02
        CLEAR(DataExchVIP);
        DataExchVIP."Data Exch. Def Code" := DataExchDefCode;
        DataExchVIP."Data Exch. Line Def Code" := DataExchDefLineCode;
        DataExchVIP."Related Record" := InterfaceRecID;
        DataExchVIP."Parent Data Exch. No. FND" := MParentEntryNo;
        //<<HEI.03
        DataExchVIP."Interface Entry Header No. FND" := InterfaceEntryHdrNo;
        //>>HEI.03
        DataExchVIP.INSERT(true);
        if DataExchDefLineCode = InterFaceCode then begin
            MParentEntryNo := DataExchVIP."Entry No.";
            DataExchVIP."Parent Data Exch. No. FND" := MParentEntryNo;
            DataExchVIP.MODIFY(false);
        end;
        exit(MParentEntryNo);
        //>>HEI.02
    end;
}

