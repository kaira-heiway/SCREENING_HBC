report 54028 "Stock transfer Order"
{
    // version HEI.06

    // HEI.01 IBM.AK HB2346 CHG2117336
    // # new Report-Stock Transfer Order
    // 
    // HEI.02 IBM.PRASAA03 CHG2182480- 15/12/2022 - Fix bug in "ship not received" report
    // # Rounding applied for shipment and receipt and quantity shipped for completely received issue resolved and layout changed accordingly
    // 
    // HEI.03 IBM.PRASAA03 CHG2182480- 15/12/2022 - Fix bug in "ship not received" report
    // # Rounding Precision Changed to 5 from 2 Decimal value
    // 
    // HEI.04 IBM.PRASAA03 CHG2192380- 10/02/2023 -  ship not received report with open very small quantity
    // # Condition is added for the received quantity based on Base quantity field
    // 
    // HEI.05 IBM.PRASAA03 CHG2192380- 14/02/2023 -  ship not received report with open very small quantity
    // # Condition is added to eliminate negative shipped quantity.
    // 
    // HEI.06 IBM.PRASAA03 CHG2192380- 27/02/2023 -  ship not received report with open very small quantity
    // # Condition is added to eliminate Wrong data Lines due to Reverseal Shipment.

    //-------------------------------------------------------------------------------------------------------------

    //BC Upgrade KAPOOV01 >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    // 2. Updated RDLCLayout Property. 
    // 3. Old Report Id-50558
    //BC Upgrade KAPOOV01 <<


    DefaultLayout = RDLC;
    //RDLCLayout = './Stock transfer Order.rdlc'; //BC Upgrade KAPOOV01 Commented
    RDLCLayout = '.\src\ReportsLayout\Stock transfer Order.rdl'; //BC Upgrade KAPOOV01-> Add layout path and change layout extension rdlc to rdl
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Posting Date", "Transfer-from Code", "Transfer-to Code";
            column(Sending_Location; "Transfer Shipment Header"."Transfer-from Code")
            {
            }
            column(TransferOrder_No; "Transfer Shipment Header"."Transfer Order No.")
            {
            }
            column(Shipment_No; "Transfer Shipment Header"."No.")
            {
            }
            column(Shipment_Date; "Transfer Shipment Header"."Posting Date")
            {
            }
            column(Receiving_Location; "Transfer Shipment Header"."Transfer-to Code")
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(RepCaptionLbl; RepCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("Filter"; Filter)
            {
            }
            column(Shippednotreceived; "Ship not Received")
            {
            }
            column(FullyReceived; "Fully Received")
            {
            }
            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(Item_No; "Transfer Shipment Line"."Item No.")
                {
                }
                column(UoM; TransferShipmentLine."Unit of Measure Code")
                {
                }
                column(Item_Description; "Transfer Shipment Line".Description)
                {
                }
                column(Qty_Shipped; QtyShipped)
                {
                }
                column(Qty_Received; Qtyreceived)
                {
                }
                column(Date_Received; DateReceived)
                {
                }
                column(Lead_Time_Value; LeadTimeValue)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    CLEAR(QtyShipped);
                    CLEAR(Qtyreceived);
                    CLEAR(RecpBaseQty);//HEI.04
                    DateReceived := 0D;
                    LeadTimeValue := '';


                    TransferShipmentLine.RESET;
                    TransferShipmentLine.SETRANGE("Document No.", "Transfer Shipment Header"."No.");
                    TransferShipmentLine.SETRANGE("Item No.", "Transfer Shipment Line"."Item No.");
                    if TransferShipmentLine.FINDSET then
                        repeat
                            QtyShipped += TransferShipmentLine.Quantity;
                        until TransferShipmentLine.NEXT = 0;

                    //IF QtyShipped =0  THEN //HEI.05
                    if QtyShipped <= 0 then //HEI.05
                        CurrReport.SKIP;

                    QtyShipped := ROUND(QtyShipped, 0.00001);//HEI.02//HEI.03
                    //whse shipment no.
                    PostedWhseShipmentLine.RESET;
                    PostedWhseShipmentLine.SETRANGE("Source No.", "Transfer Shipment Header"."Transfer Order No.");
                    PostedWhseShipmentLine.SETRANGE("Posted Source No.", "Transfer Shipment Header"."No.");
                    PostedWhseShipmentLine.SETRANGE("Item No.", "Transfer Shipment Line"."Item No.");
                    if PostedWhseShipmentLine.FINDFIRST then
                        whseshipNo := PostedWhseShipmentLine."Whse. Shipment No.";
                    //whse shipment no.


                    RecILE.RESET;
                    RecILE.SETRANGE("Document No.", "Transfer Shipment Line"."Document No.");
                    RecILE.SETRANGE("Item No.", "Transfer Shipment Line"."Item No.");
                    RecILE.SETFILTER(Quantity, '>%1', 0);
                    if RecILE.FINDSET then begin
                        repeat
                            ItemApplnEntry.RESET;
                            ItemApplnEntry.SETCURRENTKEY("Inbound Item Entry No.", "Outbound Item Entry No.", "Cost Application");
                            ItemApplnEntry.SETRANGE("Inbound Item Entry No.", RecILE."Entry No.");
                            ItemApplnEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
                            ItemApplnEntry.SETRANGE("Cost Application", true);
                            ItemApplnEntry.SETFILTER(Quantity, '<%1', 0);
                            if ItemApplnEntry.FINDSET then begin
                                repeat
                                    RecpBaseQty += ABS(ItemApplnEntry.Quantity);//HEI.04
                                                                                //Qtyreceived += ABS(ItemApplnEntry.Quantity);
                                    Qtyreceived += ABS(ItemApplnEntry.Quantity / RecILE."Qty. per Unit of Measure");
                                    //whseReceiptNo := ItemApplnEntry."Document No.";//IF 1 TS had many TR then last date and last warehouse receipt should be printed
                                    DateReceived := ItemApplnEntry."Posting Date";
                                until ItemApplnEntry.NEXT = 0;
                            end;
                        until RecILE.NEXT = 0;
                    end;
                    Qtyreceived := ROUND(Qtyreceived, 0.00001);//HEI.02//HEI.03

                    //HEI.06>>
                    //HEI.04>>
                    if RecpBaseQty >= "Transfer Shipment Line"."Quantity (Base)" then
                        Qtyreceived := QtyShipped
                    else begin
                        ItemLedgerEntry.RESET;
                        ItemLedgerEntry.SETCURRENTKEY("Document Type", "Document No.", "Document Line No.");
                        ItemLedgerEntry.SETRANGE("Document Type", ItemLedgerEntry."Document Type"::"Transfer Shipment");
                        ItemLedgerEntry.SETRANGE("Document No.", "Transfer Shipment Line"."Document No.");
                        ItemLedgerEntry.SETRANGE("Document Line No.", "Transfer Shipment Line"."Line No.");
                        if ItemLedgerEntry.FINDFIRST then
                            if not TransferLine.GET(ItemLedgerEntry."Order No.", ItemLedgerEntry."Order Line No.") then
                                Qtyreceived := QtyShipped;
                    end;
                    //HEI.04<<
                    //HEI.06<<
                    if DateReceived <> 0D then begin
                        LeadTime := DateReceived - "Transfer Shipment Header"."Posting Date";
                        LeadTimeValue := FORMAT(LeadTime);
                    end;
                end;
            }

            trigger OnPreDataItem();
            begin
                if ("Ship not Received" = false) and ("Fully Received" = false) then
                    ERROR(Text001);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    CaptionML = ENU = 'Options',
                                FRA = 'Options';
                    field("Ship not Received"; "Ship not Received")
                    {
                        Caption = 'Ship not Received';
                        ToolTip = 'Specifies the value of the Ship not Received field.';
                        ApplicationArea = All;
                    }
                    field("Fully Recieved"; "Fully Received")
                    {
                        Caption = 'Fully Received';
                        ToolTip = 'Specifies the value of the Fully Received field.';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        Filter := "Transfer Shipment Header".GETFILTERS;
    end;

    var
        whseshipNo: Code[20];
        "Ship not Received": Boolean;
        "Fully Received": Boolean;
        QtyShipped: Decimal;
        Qtyreceived: Decimal;
        DateReceived: Date;
        LeadTime: Integer;
        LeadTimeValue: Text[10];
        RecILE: Record "Item Ledger Entry";
        ItemApplnEntry: Record "Item Application Entry";
        RecILE2: Record "Item Ledger Entry";
        RepCaptionLbl: TextConst ENU = 'Stock Transfer Order', FRA = 'Évaluation du stock';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        "Filter": Text;
        Text001: Label 'Both values - "Shipped not Received" and "Fully Received" cannot be blank, atleast one value has to be selected';
        PostedWhseShipmentLine: Record "Posted Whse. Shipment Line";
        TransferShipmentLine: Record "Transfer Shipment Line";
        RecpBaseQty: Decimal;
        ItemLedgerEntry: Record "Item Ledger Entry";
        TransferLine: Record "Transfer Line";
}

