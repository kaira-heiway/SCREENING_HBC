report 58038 "Run Legacy FM Interface Req"
{
    //BC Upgrade GUNREM01 Old ID-50402
    // version HEI.01

    // HEI.01 FDD-HT610 IBM NASTAA02 25.03.2020 # La Reunion Futur Master
    //   # New Report created to manually run Legacy Futur Master Interface Requests

    Caption = 'Run Legacy FM Interface Request';
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(SendFMActualSalesDailyExport; SendFMActualSalesDailyExport)
                {
                    Caption = 'Send FM Actual Sales Daily Export';
                    ApplicationArea = All;
                }
                field(SendFMActualSalesWeeklyExport; SendFMActualSalesWeeklyExport)
                {
                    Caption = 'Send FM Actual Sales Weekly Export';
                    ApplicationArea = All;
                }
                field(SendFMActualSalesMonthlyExport; SendFMActualSalesMonthlyExport)
                {
                    Caption = 'Send FM Actual Sales Monthly Export';
                    ApplicationArea = All;
                }
                field(SendFMCustomerMaster; SendFMCustomerMaster)
                {
                    Caption = 'Send FM Customer Master';
                    ApplicationArea = All;
                }
                field(SendFMDRPStockExport; SendFMDRPStockExport)
                {
                    Caption = 'Send FM DRP Stock Export';
                    ApplicationArea = All;
                }
                field(SendFMMPSStockExport; SendFMMPSStockExport)
                {
                    Caption = 'Send FM MPS Stock Export';
                    ApplicationArea = All;
                }
                field(SendFMMRPStockExport; SendFMMRPStockExport)
                {
                    Caption = 'Send FM MRP Stock Export';
                    ApplicationArea = All;
                }
                field(SendFMPurchaseOrder; SendFMPurchaseOrder)
                {
                    Caption = 'Send FM Purchase Order';
                    ApplicationArea = All;
                }
                field(SendFMProductGlobal; SendFMProductGlobal)
                {
                    Caption = 'Send FM Product Global';
                    ApplicationArea = All;
                }
                field(FilterDate; FilterDate)
                {
                    Caption = 'Filter Date';
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            FilterDate := TODAY;
        end;
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        if InsertedLines = 1 then
            MESSAGE(InsertedLines2Message, InsertedLines)
        else if InsertedLines > 1 then
            MESSAGE(InsertedLinesMessage, InsertedLines);
    end;

    trigger OnPreReport();
    var
        LegacyFuturMasterIntSetup: Record "Legacy Futur Mster Int Stp INT";
    begin
        if not LegacyFuturMasterIntSetup.GET then
            CurrReport.SKIP;

        InsertedLines := 0;

        if SendFMActualSalesDailyExport then
            InsertFMInboundInterfaceEntry(LegacyFuturMasterIntSetup."Actual Sales Daily Exp BB Req");
        if SendFMActualSalesWeeklyExport then
            InsertFMInboundInterfaceEntry(LegacyFuturMasterIntSetup."Actual Sales Weekly Exp BB Req");
        if SendFMActualSalesMonthlyExport then
            InsertFMInboundInterfaceEntry(LegacyFuturMasterIntSetup."Actual Sales Monthly Exp BB R");
        if SendFMCustomerMaster then
            InsertFMInboundInterfaceEntry(LegacyFuturMasterIntSetup."Client Master Interface Req");
        if SendFMDRPStockExport then
            InsertFMInboundInterfaceEntry(LegacyFuturMasterIntSetup."DRP Stock Export Req");
        if SendFMMPSStockExport then
            InsertFMInboundInterfaceEntry(LegacyFuturMasterIntSetup."MPS Stock Export Req");
        if SendFMMRPStockExport then
            InsertFMInboundInterfaceEntry(LegacyFuturMasterIntSetup."MRP Stock Export BB Request");
        if SendFMPurchaseOrder then
            InsertFMInboundInterfaceEntry(LegacyFuturMasterIntSetup."Purchase Order Export Req");
        if SendFMProductGlobal then
            InsertFMInboundInterfaceEntry(LegacyFuturMasterIntSetup."Product FM Global Req");
    end;

    var
        SendFMActualSalesDailyExport: Boolean;
        SendFMActualSalesWeeklyExport: Boolean;
        SendFMActualSalesMonthlyExport: Boolean;
        SendFMCustomerMaster: Boolean;
        SendFMDRPStockExport: Boolean;
        SendFMMPSStockExport: Boolean;
        SendFMMRPStockExport: Boolean;
        SendFMPurchaseOrder: Boolean;
        SendFMProductGlobal: Boolean;
        FilterDate: Date;
        InsertedLines: Integer;
        InsertedLinesMessage: Label '%1 Inbound Interfaces were inserted.';
        InsertedLines2Message: Label '%1 Inbound Interface was inserted.';

    local procedure InsertFMInboundInterfaceEntry(InterfaceCode: Code[20]);
    var
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceEntryHeader2: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceLogHeader: Record "Interface Log Header INT";
        InterfaceLogLine: Record "Interface Log Line INT";
    begin
        InterfaceEntryHeader2.RESET;
        InterfaceEntryHeader2.FINDLAST;

        //search last request from Interface Log to copy the data
        InterfaceLogHeader.RESET;
        InterfaceLogHeader.SETRANGE("Interface Code", InterfaceCode);
        InterfaceLogHeader.SETRANGE(Description, '');
        InterfaceLogHeader.SETRANGE("Posting Date", 0D);
        if InterfaceLogHeader.FINDLAST then begin
            InterfaceLogLine.RESET;
            InterfaceLogLine.SETRANGE("Header Entry No.", InterfaceLogHeader."Entry No.");
            if InterfaceLogLine.FINDFIRST then;

            InsertedLines += 1;
            //Insert header
            InterfaceEntryHeader.RESET;
            InterfaceEntryHeader.INIT;
            InterfaceEntryHeader."Entry No." := InterfaceEntryHeader2."Entry No." + 1;
            InterfaceEntryHeader.INSERT(true);
            InterfaceEntryHeader."Interface Code" := InterfaceCode;
            InterfaceEntryHeader.Direction := InterfaceEntryHeader.Direction::Inbound;
            InterfaceEntryHeader."Data Exch. Entry No." := InterfaceLogHeader."Data Exch. Entry No.";
            if (FilterDate <> TODAY) and (FilterDate <> 0D) then
                InterfaceEntryHeader."Posting Date" := FilterDate;
            InterfaceEntryHeader.Description := 'Manually created Entry';
            InterfaceEntryHeader.Name := USERID;
            InterfaceEntryHeader.MODIFY(true);

            //insert line
            InterfaceEntryLine.RESET;
            InterfaceEntryLine.INIT;
            InterfaceEntryLine."Header Entry No." := InterfaceEntryHeader."Entry No.";
            InterfaceEntryLine."Entry No." := 1;
            InterfaceEntryLine.INSERT(true);
            InterfaceEntryLine."No." := '*';
            InterfaceEntryLine."Data Exch. Entry No." := InterfaceLogHeader."Data Exch. Entry No.";
            InterfaceEntryLine.MODIFY(true);

        end;
    end;
}

