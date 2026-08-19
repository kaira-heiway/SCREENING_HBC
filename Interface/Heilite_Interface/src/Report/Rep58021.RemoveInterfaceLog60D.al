report 58021 "Remove Interface Log >60D"
{
    // version HEI.01

    // HEI.01 HB1388 CHG2061482 IBM.NANDIS01 29.04.2020- Data exchange Table Clean Up
    //    # Created a new Report to clean the data exchange table, previously it was hard coded used for Rwanda opco
    // HEI.02 CHG2090511 IBM SAMANR01 31-12-2020
    //    # Include the interface log header, line & component line table for clean-up
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID - 50239.
    // 2. Add ApplicationArea and UsageCategory property in Report.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            MaxIteration = 1;

            trigger OnPreDataItem();
            begin
                //HEI.01>>
                StorelastDataExchngNo := 0;
                LogHeaderEntryNo := 0; // >>HEI.02
                LogHeaderEntryNoVIP := 0;// >>HEI.02
                grec_IntrfcLogHdr.RESET;
                grec_IntrfcLogHdr.SETCURRENTKEY("Entry No.");
                grec_IntrfcLogHdr.SETFILTER(grec_IntrfcLogHdr."Data Exch. Entry No.", '<>%1', 0);
                grec_IntrfcLogHdr.SETFILTER("Archive Date", '..%1', CREATEDATETIME(CALCDATE('<-60D>', WORKDATE), 000000T));
                if grec_IntrfcLogHdr.FINDLAST then begin
                    StorelastDataExchngNo := grec_IntrfcLogHdr."Data Exch. Entry No.";
                    LogHeaderEntryNo := grec_IntrfcLogHdr."Entry No."; // >>HEI.02
                end;

                grec_DataExch.RESET;
                grec_DataExch.SETFILTER("Entry No.", '<=%1', StorelastDataExchngNo);
                grec_DataExch.DELETEALL;

                // >>HEI.02
                InterfaceLogCompDetail.RESET;
                InterfaceLogCompDetail.SETFILTER("Header Entry No.", '<=%1', LogHeaderEntryNo);
                InterfaceLogCompDetail.DELETEALL;

                InterfaceLogComponent.RESET;
                InterfaceLogComponent.SETFILTER("Header Entry No.", '<=%1', LogHeaderEntryNo);
                InterfaceLogComponent.DELETEALL;

                InterfaceLogLine.RESET;
                InterfaceLogLine.SETFILTER("Header Entry No.", '<=%1', LogHeaderEntryNo);
                InterfaceLogLine.DELETEALL;

                InterfaceLogHeader.RESET;
                InterfaceLogHeader.SETFILTER("Entry No.", '<=%1', LogHeaderEntryNo);
                InterfaceLogHeader.DELETEALL;

                grec_IntrfcLogHdrVIP.RESET;
                grec_IntrfcLogHdrVIP.SETCURRENTKEY("Entry No.");
                grec_IntrfcLogHdrVIP.SETFILTER("Archive Date", '..%1', CREATEDATETIME(CALCDATE('<-60D>', WORKDATE), 000000T));
                if grec_IntrfcLogHdrVIP.FINDLAST then
                    LogHeaderEntryNoVIP := grec_IntrfcLogHdrVIP."Entry No.";

                InterfaceLogLineVIP.RESET;
                InterfaceLogLineVIP.SETFILTER("Header Entry No.", '<=%1', LogHeaderEntryNoVIP);
                InterfaceLogLineVIP.DELETEALL;

                InterfaceLogHeaderVIP.RESET;
                InterfaceLogHeaderVIP.SETFILTER("Entry No.", '<=%1', LogHeaderEntryNoVIP);
                InterfaceLogHeaderVIP.DELETEALL;

                // <<HEI.02
                if GUIALLOWED then
                    MESSAGE('Proces completed successfully');
                //HEI.01<<
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        //HEI.02>>


        if not GUIALLOWED then begin
            JobDay := DATE2DMY(WORKDATE, 1);
            if (JobDay <> 15) then
                CurrReport.QUIT;
        end;

        //HEI.02<<
    end;

    var
        grec_IntrfcLogHdr: Record "Interface Log Header INT";
        Duration: BigInteger;
        NoofDays: Integer;
        grec_DataExch: Record "Data Exch.";
        StorelastDataExchngNo: Integer;
        JobDay: Integer;
        InterfaceLogHeader: Record "Interface Log Header INT";
        InterfaceLogLine: Record "Interface Log Line INT";
        InterfaceLogComponent: Record "Interface Log Component INT";
        Txt001: Label 'Please select the Delete To DateTime';
        InterfaceLogCompDetail: Record "Interface Log Comp. Detail INT";
        grec_IntrfcLogHdrVIP: Record "Interface Log Header VIP INT";
        InterfaceLogHeaderVIP: Record "Interface Log Header VIP INT";
        InterfaceLogLineVIP: Record "Interface Log Line VIP INT";
        LogHeaderEntryNo: Integer;
        LogHeaderEntryNoVIP: Integer;
}

