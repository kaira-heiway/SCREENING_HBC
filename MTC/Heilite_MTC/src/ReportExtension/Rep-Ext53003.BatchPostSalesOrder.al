reportextension 53003 BatchPostSalesOrderExt extends "Batch Post Sales Orders"
{

    dataset
    {
        modify("Sales Header")
        {
            trigger OnAfterAfterGetRecord()
            begin
                //BC UPGRADE KUMARR78++
                // <<DITW15.00.00.01 DDR 27/02/2008
                IF blnPrintReq THEN
                    cduSalesPostPrint.GetReport("Sales Header");
                // >>DITW15.00.00.01 DDR
                //BC UPGRADE KUMARR78++
            end;
        }

    }

    requestpage
    {
        layout
        {
            addafter(CalcInvDisc)
            {
                field(blnPrintReq; blnPrintReq)
                {
                    ApplicationArea = All;
                    Caption = 'Print';
                }
                // field(FilterText; FilterText)
                // {
                //     ApplicationArea = all;
                //     Caption = 'Logistic Status';
                // }
            }
        }

        trigger OnOpenPage()
        var
            FromStatus: text;
            EnumShippingBatchPost: Enum "Batch PO Shipment Statusfilter";
            listtext: List of [text];

            ListItem: text;
            TestInt: Integer;
            i: Integer;
        begin
            SalesSetup.Get();

            if not blnReportInit then begin
                CalcInvDisc := SalesSetup."Calc. Inv. Discount";
                ReplacePostingDate := false;
                ReplaceDocumentDate := false;
            end;
            blnPrintReq := SalesSetup."Batch PostOrders Print FND";
            IF "Sales Header".GETFILTER(Status) = '' THEN BEGIN
                IF SalesSetup."Batch PostOrd.StatusFilter FND" = SalesSetup."Batch PostOrd.StatusFilter FND" ::Released THEN
                    "Sales Header".SETRANGE(Status, "Sales Header".Status::Released);
            end;

            //BC UPGRADE KUMARR78>> Adding
            if "Sales Header".GetFilter("Logistic Status HNK FND") = '' then begin
                FromStatus := Format(SalesSetup."Batch POShip. Statusfilter FND", 0, 9);
                FilterText := GetLogisticStatusFilter(FromStatus);
                ShipmentDesc := GetLogisticStatusFilter1(FromStatus);
                "Sales Header".SetFilter("Logistic Status HNK FND", FilterText);
                // "Sales Header".SetRange("Logistic Status 107FDW", ShipmentDesc, 'Invoice');
            end;
            //BC UPGRADE KUMARR78<< Adding
        end;
    }

    var
        SalesSetup: Record "Sales & Receivables Setup";
        ShipmentDesc: Text[100];
        cduSalesPostPrint: Codeunit "Sales-Post + Print";
        SalesHeader: Record "Sales Header";
        blnPrintReq: Boolean;
        FilterText: Text;
        ShipmentStatus: Text[100];
        blnReportInit: Boolean;

    trigger OnPreReport()
    var
        PrintMgt: Codeunit BatchPostPrintMgt;
    begin
        // PrintMgt.SetPrint(blnPrintReq);
    end;


    trigger OnPostReport()
    var
    // ZipDownload: Codeunit BatchPostZipDownload;
    begin
        //ZipDownload.DownloadInvoices();
    end;

    procedure GetPrint(): Boolean
    begin
        exit(blnPrintReq);
    end;

    procedure GetLogisticStatusFilter(FromStatus: Text): Text
    var
        FilterText: Text;
    begin

        if FromStatus = '0' then
            FilterText := 'OPEN|PICKLIST|PRINTED|ASSIGNED|PICKED|SHIPPED|RETURN COMPLETED|INVOICE';

        if FromStatus = '1' then
            FilterText := 'PICKLIST|PRINTED|ASSIGNED|PICKED|SHIPPED|RETURN COMPLETED|INVOICE';

        if FromStatus = '2' then
            FilterText := 'PRINTED|ASSIGNED|PICKED|SHIPPED|RETURN COMPLETED|INVOICE';

        if FromStatus = '3' then
            FilterText := 'ASSIGNED|PICKED|SHIPPED|RETURN COMPLETED|INVOICE';

        if FromStatus = '4' then
            FilterText := 'PICKED|SHIPPED|RETURN COMPLETED|INVOICE';

        if FromStatus = '5' then
            FilterText := 'SHIPPED|RETURN COMPLETED|INVOICE';

        if FromStatus = '6' then
            FilterText := 'RETURN COMPLETED|INVOICE';

        if FromStatus = '7' then
            FilterText := 'INVOICE';

        exit(FilterText);
    end;

    procedure GetLogisticStatusFilter1(FromStatus: Text): Text
    var
        FilterText: Text;
    begin

        if FromStatus = '0' then
            FilterText := 'OPEN';

        if FromStatus = '1' then
            FilterText := 'PICKLIST';

        if FromStatus = '2' then
            FilterText := 'PRINTED';

        if FromStatus = '3' then
            FilterText := 'ASSIGNED';

        if FromStatus = '4' then
            FilterText := 'PICKED';

        if FromStatus = '5' then
            FilterText := 'SHIPPED';

        if FromStatus = '6' then
            FilterText := 'RETURN COMPLETED';

        if FromStatus = '7' then
            FilterText := 'INVOICE';

        exit(FilterText);
    end;


}