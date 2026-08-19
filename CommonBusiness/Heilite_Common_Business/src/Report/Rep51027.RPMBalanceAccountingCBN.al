report 51027 "RPM Balance Accounting CBN"
{
    // version HEI.04

    // HEI.01 FDD-KDD0TC005 IBM NASTAA02 9.11.2017 # RPM Billing and Reporting
    //   # New Report created to locate all RPM materials that were sent to customer but not yet returned
    // HEI.02 Defect #1402 IBM NASTAA02 19.01.2018 # Report for RPM balancing includes items also, not only RPM items
    //   # Extra filters added on "Value Entry" DataItem:
    //       "Item Charge No." <> ''
    //       "Empty Goods Item No." <> ''
    //   # Replaced "Item No." with "Empty Goods Item No."
    // HEI.03 FDD-ET-HT695 IBM NASTAA02 05.07.2019 # RPM Payment Reconciliation and Offset
    //   # New columns added: "Paid Quantity" and "Paid Value"
    // HEI.04 FDD-HB1221 IBM NASTAA02 16.06.2020 # ET RPM Balance - CHG2064239
    //   # New Columns added: "Posting Date", "Document No." and "Order No."
    //   # Code added on "Value Entry - OnAfterGetRecord" trigger
    //   # Re-arranged columns
    //   # Small layout changes
    //   # Added new Required Filter on "Posting Date" and new Option Field on Request Page
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea Property in Report and Fields.
    // 2. Add UsageCategory Property in Report.
    // 3. Add Layout Path
    // 4. Remove Drink-It Fields
    // BC Upgrade BHARDA11 <<

    // BC Upgrade SHUKLP03 >> OTC223 testscript changes.

    DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = '.\src\ReportsLayout\RPM Balance Accounting.rdl';

    Caption = 'RPM Balance Accounting';
    PreviewMode = PrintLayout;
    Permissions = TableData LedgerEntry104FDW = RIM;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.")
                                ORDER(Ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(Today; TODAY)
            {
            }
            column(CustomerNo; "No.")
            {
            }
            column(CustomerName; Name)
            {
            }
            dataitem("Empty Ledger Entry"; LedgerEntry104FDW)
            {
                DataItemLink = "Source No." = FIELD("No.");
                DataItemTableView = sorting("Entry No.")
                                    ORDER(Ascending)
                                    where("Order No." = FILTER(<> ''),
                                          "Document Type" = FILTER("Posted Sales Invoice" | "Posted Sales Credit Memo"), "Empty Goods Item No." = FILTER(<> '')); // BC Upgrade BHARDA11 ----Drink-IT Field ("Empty Goods Item No.")
                RequestFilterFields = "Posting Date";

                column(DetailedView; DetailedView)
                {
                }
                column(RPMTypeNotBlank; RPMTypeNotBlank)
                {
                }
                column(RPMSolutionNotBlank; RPMSolutionNotBlank)
                {
                }
                column(ItemNo; Item."No.")
                {
                }
                column(ItemDescription; Item.Description)
                {
                }
                column(RPMSolution; Item."RPM Solution FND")
                {
                }
                column(RPMType; Item."RPM Type FND")
                {
                }
                column(QtyShipped; QtyShipped)
                {
                }
                column(ValueShipped; ValueShipped)
                {
                }
                column(QtyReturn; QtyReturn)
                {
                }
                column(ValueReturn; ValueReturn)
                {
                }
                column(PaidQuantity; PaidQty)
                {
                }
                column(PaidValue; PaidValue)
                {
                }
                column(PostingDate; "Posting Date")
                {
                }
                column(DocumentNo; "Document No.")
                {
                }
                column(OrderNo; "Order No.")
                {
                }

                trigger OnAfterGetRecord();
                var
                    CustLedgerEntry: Record "Cust. Ledger Entry";
                    SalesCrMemoHeader: Record "Sales Cr.Memo Header";
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                // LedgerEntry: Record LedgerEntry104FDW;
                begin
                    RPMSolutionNotBlank := FALSE;
                    RPMTypeNotBlank := FALSE;

                    // BC Upgrade SHUKLP03 ----Drink-IT Field("Empty Goods Item No.")
                    // LedgerEntry.SetRange("Document No.", "Document No.");
                    // LedgerEntry.SetRange("Document Type", "Document Type");
                    // LedgerEntry.SetRange("Item Ledger Entry No.", "Item Ledger Entry No.");
                    // LedgerEntry.SetRange("Posting Date", "Posting Date");
                    // IF LedgerEntry.FINDFIRST() THEN BEGIN
                    //HEI.02>>
                    Item.GET("Empty Goods Item No.");
                    //HEI.02<<
                    // BC Upgrade SHUKLP03 ----Drink-IT Field("Empty Goods Item No.")

                    IF "Document Type" = "Document Type"::"Posted Sales Invoice" THEN BEGIN
                        QtyShipped := ABS("Invoiced Quantity");
                        ValueShipped := ABS("Deposit Amount");  // BC Upgrade SHUKLP03 ----Drink-IT Field ("Sales Deposit Amount (Actual)")
                        QtyReturn := 0;
                        ValueReturn := 0;
                    end else IF "Document Type" = "Document Type"::"Posted Sales Credit Memo" THEN BEGIN
                        QtyShipped := 0;
                        ValueShipped := 0;
                        QtyReturn := ABS("Invoiced Quantity");
                        ValueReturn := ABS("Deposit Amount"); // BC Upgrade SHUKLP03 ----Drink-IT Field ("Sales Deposit Amount (Actual)")
                    end;
                    // END;


                    IF ShowBlankRPMSolution THEN
                        RPMSolutionNotBlank := TRUE
                    else
                        IF Item."RPM Solution FND" <> Item."RPM Solution FND"::" " THEN
                            RPMSolutionNotBlank := TRUE;

                    IF DisplayPerRPMType THEN
                        IF ShowBlankRPMType THEN
                            RPMTypeNotBlank := TRUE
                        else
                            IF Item."RPM Type FND" <> '' THEN
                                RPMTypeNotBlank := TRUE;

                    //HEI.03>>
                    PaidQty := 0;
                    PaidValue := 0;
                    EntryNo += 1;

                    ValueEntryBuffer.SETRANGE("Empty Goods Item No.", "Empty Goods Item No."); // BC Upgrade BHARDA11 ----Drink-IT Field ("Empty Goods Item No.")
                    IF NOT ValueEntryBuffer.FINDFIRST() THEN BEGIN
                        CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Payment);
                        CustLedgerEntry.SETRANGE("CM Incl. EG. Lim. Warn APS", CustLedgerEntry."CM Incl. EG. Lim. Warn APS"::Deposit); // BC Upgrade BHARDA11 ----Drink-IT Field ("Item Charge Type")
                        CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                        CustLedgerEntry.SETRANGE("Empties Item No. FND", "Empty Goods Item No."); // BC Upgrade BHARDA11 ----Drink-IT Field ("Item Charge Type")
                        IF CustLedgerEntry.findset() THEN BEGIN
                            REPEAT
                                CustLedgerEntry.CALCFIELDS("Original Amt. (LCY)");
                                PaidQty += CustLedgerEntry."Deposit Quantity FND";
                                PaidValue += -CustLedgerEntry."Original Amt. (LCY)";
                            UNTIL CustLedgerEntry.NEXT() = 0;

                            ValueEntryBuffer.INIT();
                            ValueEntryBuffer."Entry No." := EntryNo;
                            // ValueEntryBuffer."Empty Goods Item No." := "Empty Goods Item No."; // BC Upgrade BHARDA11 ----Drink-IT Fields ("Empty Goods Item No.")
                            ValueEntryBuffer.INSERT();
                        end;
                    end;
                    //HEI.03<<

                    //HEI.04>>
                    // OrderNo := '';
                    // IF "Document Type" = "Document Type"::"Posted Sales Invoice" THEN
                    //     IF SalesInvoiceHeader.GET("Document No.") THEN
                    //         OrderNo := SalesInvoiceHeader."Order No.";

                    // IF "Document Type" = "Document Type"::"Posted Sales Credit Memo" THEN
                    //     IF SalesCrMemoHeader.GET("Document No.") THEN
                    //         OrderNo := SalesCrMemoHeader."Return Order No.";
                    //HEI.04<<
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                // Caption = 'Options';
                field("Display per RPM Type"; DisplayPerRPMType)
                {
                    ApplicationArea = All;
                    Caption = 'Display per RPM Type';
                    ToolTip = 'Specifies the value of the Display per RPM Type field.';

                    trigger OnValidate();
                    begin
                        IF NOT DisplayPerRPMType AND ShowBlankRPMType THEN
                            ShowBlankRPMType := FALSE;
                    end;
                }
                field(ShowBlankRPMType; ShowBlankRPMType)
                {
                    ApplicationArea = All;

                    Caption = 'Show Blank RPM Type';
                    ToolTip = 'Specifies the value of the Show Blank RPM Type field.';

                    trigger OnValidate();
                    begin
                        IF ShowBlankRPMType AND NOT DisplayPerRPMType THEN
                            DisplayPerRPMType := TRUE;
                    end;
                }
                field(ShowBlankRPMSolution; ShowBlankRPMSolution)
                {
                    ApplicationArea = All;

                    Caption = 'Show Blank RPM Solution';
                    ToolTip = 'Specifies the value of the Show Blank RPM Solution field.';
                }
                field(DetailedView; DetailedView)
                {
                    ApplicationArea = All;
                    Caption = 'Detailed RPM';
                    ToolTip = 'Specifies the value of the Detailed RPM field.';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        ReportTitleLbl = 'RPM Accounting Balance'; RPMSolutionLbl = 'RPM Solution:'; RPMTypeLbl = 'RPM Type:'; ItemNoLbl = 'Item No.'; DescriptionLbl = 'Description'; QuantityShippedLbl = 'Quantity Shipped'; ValueShippedLbl = 'Value Shipped'; QuantityReturnedLbl = 'Quantity Returned'; ValueReturnedLbl = 'Value Returned'; DifferenceQuantityLbl = 'Difference Quantity'; DifferenceValueLbl = 'Difference Value'; TotalLbl = 'Total'; PaidQuantityLbl = 'Paid Quantity'; PaidValueLbl = 'Paid Value'; PostingDateLbl = 'Posting Date'; DocumentNoLbl = 'Document No.'; OrderNoLbl = 'Order No.';
    }

    var
        Item: Record Item;
        ValueEntryBuffer: Record LedgerEntry104FDW temporary;
        DetailedView: Boolean;
        DisplayPerRPMType: Boolean;
        RPMSolutionNotBlank: Boolean;
        RPMTypeNotBlank: Boolean;
        ShowBlankRPMSolution: Boolean;
        ShowBlankRPMType: Boolean;
        // OrderNo: Code[20];
        PaidQty: Decimal;
        PaidValue: Decimal;
        QtyReturn: Decimal;
        QtyShipped: Decimal;
        ValueReturn: Decimal;
        ValueShipped: Decimal;
        EntryNo: Integer;
        CustomerNoFilter: Text;
}