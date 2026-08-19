report 51107 "Cust/Item Sales_Dim_BRU_ET CBN"
{
    // BC Upgrade MISHRS14 >>
    // Created new report NAV ID - 50627
    // HEI.01 CHG2347969-HB4584 IBM ADHIKG01 25.03.2026 Ethiopia-BRD to Create a separate Column for disaster risk response fund in BRU (Customer Sales Data Report)
    // # New report created by referring to the report: 50394 Customer/Item Sales_Dim_BRU
    // # Added New Fied "Disaster Risk Fund" on the report layout.
    // # Added the report in the Menusuite
    // BC Upgrade MISHRS14 <<

    Caption = 'Customer/Item Sales_Dim_BRU_ET';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\CustItemSales_Dim_BRU_ET.rdl';


    dataset
    {
        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = true;

            column(ReportTitle; ReportTitle)
            {
            }

            column(CustomerNo; "No.")
            {
            }

            column(CustomerName; Name)
            {
            }

            column(SalesTypeCustomerAttr; CustomerAttributes."Local Customer Sub-Type")
            {
            }

            dataitem("Value Entry"; "Value Entry")
            {
                DataItemLinkReference = Customer;

                DataItemTableView = sorting(
                    "Item No.",
                    "Posting Date",
                    "Item Ledger Entry Type",
                    "Entry Type",
                    "Variance Type",
                    "Item Charge No.",
                    "Location Code",
                    "Variant Code",
                    "Global Dimension 1 Code",
                    "Global Dimension 2 Code",
                    "Source Type",
                    "Source No.");

                RequestFilterFields = "Item No.", "Posting Date", "Entry Type";

                column(LocationCode_ValueEntry; "Location Code")
                {
                }

                column(DimensionCode; DimensionCode)
                {
                }

                column(DocumentNo_ValueEntry; "Document No.")
                {
                }

                column(DimensionDescription; DimensionDescription)
                {
                }

                column(ItemNo_ValueEntry; "Item No.")
                {
                }

                column(ItemDescription; ItemDescription)
                {
                }

                column(BaseUom; DocumentUoM)
                {
                }

                column(InvoicedQuantity_ValueEntry; DocumentQuantity)
                {
                }

                column(InvoicedQuantityinHL_ValueEntry; "Invoiced Quantity HL FND")
                {
                }

                column(CostAmountActual_ValueEntry; "Cost Amount (Actual)")
                {
                }
                // Blocked as DIT field in Item Charge Table extension - 50108
                // column(SalesDepositAmountActual_ValueEntry; "Sales Deposit Amount (Actual)")
                // {
                // }

                // column(SalesTaxAmountActual_ValueEntry; "Sales Tax Amount (Actual)")
                // {
                // }

                column(SalesAmountActual_ValueEntry; "Sales Amount (Actual)")
                {
                }

                column(DiscountAmount_ValueEntry; "Discount Amount")
                {
                }

                column(PostingDate_ValueEntry; Format("Posting Date"))
                {
                }

                column(ItemLedgerEntryNo_ValueEntry; "Item Ledger Entry No.")
                {
                }

                column(RemainingAmount; RemainingAmount)
                {
                }

                column(EntryType; "Item Ledger Entry Type")
                {
                }

                column(DocumentType; "Document Type")
                {
                }

                column(Userid; "User ID")
                {
                }

                column(ShipmentCode; ShipmentCode)
                {
                }

                column(DiscountAmount; DiscountAmount)
                {
                }

                column(DRRFAmount; DRRFAmount)
                {
                }

                trigger OnPreDataItem()
                begin
                    SetRange("Item Ledger Entry Type", "Item Ledger Entry Type"::Sale);
                    SetRange("Source Type", "Source Type"::Customer);
                    SetRange("Source No.", Customer."No.");

                    SetFilter(
                        "Document Type",
                        '%1|%2',
                        "Document Type"::"Sales Invoice",
                        "Document Type"::"Sales Credit Memo");
                end;

                trigger OnAfterGetRecord()
                begin
                    ItemLedgEntry.Reset();
                    ItemLedgEntry.SetRange("Entry No.", "Item Ledger Entry No.");

                    if ItemCategoryCode <> '' then
                        ItemLedgEntry.SetFilter("Item Category Code", ItemCategoryCode);

                    if not ItemLedgEntry.FindFirst() then
                        CurrReport.Skip()
                    else begin
                        BaseUom := '';
                        ShipmentCode := '';
                        DimensionCode := '';
                        ItemDescription := '';
                        DimensionDescription := '';

                        ValueEntryRec.Reset();
                        ValueEntryRec.Get("Entry No.");

                        Item.Get(ValueEntryRec."Item No.");
                        ItemDescription := Item.Description;
                        BaseUom := Item."Base Unit of Measure";

                        if DimSetEntry.Get(ItemLedgEntry."Dimension Set ID", Dimension) then begin
                            DimensionCode := DimSetEntry."Dimension Value Code";

                            if DimensionValue.Get(Dimension, DimSetEntry."Dimension Value Code") then
                                DimensionDescription := DimensionValue.Name;
                        end;

                        if SalesInvoiceHeader.Get(ValueEntryRec."Document No.") then
                            ShipmentCode := SalesInvoiceHeader."Shipment Method Code";
                    end;

                    Clear(SalesInvoiceLine);
                    Clear(SalesCrMemoLine);
                    Clear(DocumentUoM);
                    Clear(DocumentQuantity);
                    Clear(DocumentQuantityHL);

                    if "Document Type" = "Document Type"::"Sales Invoice" then begin
                        SalesInvoiceLine.SetRange("Document No.", "Document No.");
                        SalesInvoiceLine.SetRange("Line No.", "Document Line No.");
                        SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);

                        if SalesInvoiceLine.FindFirst() then begin
                            DocumentUoM := SalesInvoiceLine."Unit of Measure Code";
                            DocumentQuantityHL := SalesInvoiceLine.Quantity * "Unit Volume HL FND";
                        end;
                    end else
                        if "Document Type" = "Document Type"::"Sales Credit Memo" then begin
                            SalesCrMemoLine.SetRange("Document No.", "Document No.");
                            SalesCrMemoLine.SetRange("Line No.", "Document Line No.");
                            SalesCrMemoLine.SetRange(Type, SalesCrMemoLine.Type::Item);

                            if SalesCrMemoLine.FindFirst() then begin
                                DocumentUoM := SalesCrMemoLine."Unit of Measure Code";
                                DocumentQuantityHL := -SalesCrMemoLine.Quantity * "Unit Volume HL FND";
                            end;
                        end;

                    //DocumentQuantity := -("Invoiced Quantity" / "Qty. per Unit of Measure");

                    RemainingAmount := 0;

                    ItemLedgEntry.Reset();
                    ItemLedgEntry.SetRange("Entry No.", "Item Ledger Entry No.");
                    ItemLedgEntry.CalcSums("Remaining Quantity");

                    RemainingAmount := ItemLedgEntry."Remaining Quantity";

                    // Disaster Risk Fund
                    Clear(DiscountAmount);
                    Clear(DRRFAmount);
                    
                    // Blocked temporarily to be unblocked when Table - Item Charge(5800) HEI Tags are updated so that field - "Excld. Item Charge on Subtotal" is added
                    // if ("Item Charge No." <> '') and ItemCharge.Get("Item Charge No.") then
                    //     if ItemCharge."Excld. Item Charge on Subtotal" then
                    //         DRRFAmount := "Discount Amount"
                    //     else
                    //         DiscountAmount := "Discount Amount";

                    if PrintToExcel then
                        MakeExcelDataBody();
                end;
            }
            trigger OnAfterGetRecord()
            begin
                ReportTitle := 'Customer/Item Sales_Dim ' + "Value Entry".GETFILTERS;

                IF Dimension <> '' THEN
                ReportTitle :=  ReportTitle + ', Dimension: ' + Dimension;
                IF ItemCategoryCode <> '' THEN
                ReportTitle :=  ReportTitle + ', Item Category Code: ' + ItemCategoryCode;

                CustomerAttributes.RESET;
                IF CustomerAttributes.GET(Customer."No.") THEN;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(DimToExport; Dimension)
                    {
                        ApplicationArea = All;
                        Caption = 'Dimension to Export';
                        TableRelation = Dimension.Code;
                    }

                    field(ItemCategoryCodeFld; ItemCategoryCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Item Category Code';
                        TableRelation = "Item Category".Code;
                    }

                    field(PrintToExcelFld; PrintToExcel)
                    {
                        ApplicationArea = All;
                        Caption = 'Print to Excel';
                    }
                }
            }
        }

        actions
        {
            area(Processing)
            {
            }
        }
    }

    trigger OnPreReport()
    begin
        if PrintToExcel then
            MakeExcelInfo();
    end;

    trigger OnPostReport()
    begin
        if PrintToExcel then
            CreateExcelbook();
    end;


    var
    CompanyInfo: Record "Company Information";
    CustomerAttributes: Record "Customer Attributes FND";
    ValueEntryRec: Record "Value Entry";
    ItemLedgEntry: Record "Item Ledger Entry";
    Item: Record Item;
    SalesInvoiceHeader: Record "Sales Invoice Header";
    SalesInvoiceLine: Record "Sales Invoice Line";
    SalesCrMemoLine: Record "Sales Cr.Memo Line";
    DimSetEntry: Record "Dimension Set Entry";
    DimensionValue: Record "Dimension Value";
    ItemCharge: Record "Item Charge";
    ExcelBuf: Record "Excel Buffer" temporary;
    Dimension: Code[20];
    DimensionCode: Code[20];
    ItemCategoryCode: Code[20];
    DimensionDescription: Text[50];
    CustomerName: Text[50];
    ItemDescription: Text[50];
    ReportTitle: Text;
    BaseUom: Code[20];
    ShipmentCode: Code[20];
    DocumentUoM: Code[10];
    RemainingAmount: Decimal;
    DocumentQuantity: Decimal;
    DocumentQuantityHL: Decimal;
    DiscountAmount: Decimal;
    DRRFAmount: Decimal;
    PrintToExcel: Boolean;
    PrintOnlyOnePerPage: Boolean;
    Text001Lbl: Label 'Data';
    Text002Lbl: Label 'Customer/Item Sales';
    Text003Lbl: Label 'Company Name';
    Text004Lbl: Label 'Report No.';
    Text005Lbl: Label 'Report Name';
    Text006Lbl: Label 'User ID';
    Text007Lbl: Label 'Date';
    Text012Lbl: Label 'Invoiced Quantity in HL';
    Text013Lbl: Label 'Sale Type';
    Text014Lbl: Label 'Dimension Code';
    Text015Lbl: Label 'Dimension Name';

    local procedure MakeExcelInfo()
    begin
        MakeExcelDataHeader();
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow();

        ExcelBuf.AddColumn(Customer.FieldCaption("No."), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.FieldCaption(Name), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(ValueEntryRec.FieldCaption("Document No."), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ValueEntryRec.FieldCaption("Location Code"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(Text013Lbl, false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        if Dimension <> '' then
            ExcelBuf.AddColumn(Text014Lbl, false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        if Dimension <> '' then
            ExcelBuf.AddColumn(Text015Lbl, false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(ValueEntryRec.FieldCaption("Item No."), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('Item Description', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(ValueEntryRec.FieldCaption("Invoiced Quantity"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('Base Unit of Measure', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(Text012Lbl, false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(ValueEntryRec.FieldCaption("Cost Amount (Actual)"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        //ExcelBuf.AddColumn(ValueEntryRec.FieldCaption("Sales Deposit Amount (Actual)"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        //ExcelBuf.AddColumn(ValueEntryRec.FieldCaption("Sales Tax Amount (Actual)FND"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(ValueEntryRec.FieldCaption("Sales Amount (Actual)"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(ValueEntryRec.FieldCaption("Discount Amount"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('Disaster Risk Fund', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('Posting Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('Remaining Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('User ID', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('Entry Type', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('Document Type', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('Sales Type-Customer Attr', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
    end;

    local procedure MakeExcelDataBody()
    begin
        ExcelBuf.NewRow();

        ExcelBuf.AddColumn(Customer."No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.Name, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(ValueEntryRec."Document No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(ValueEntryRec."Location Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(Format(ShipmentCode), false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        if Dimension <> '' then
            ExcelBuf.AddColumn(Format(DimensionCode), false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        if Dimension <> '' then
            ExcelBuf.AddColumn(Format(DimensionDescription), false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(ValueEntryRec."Item No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(ItemDescription, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(-ValueEntryRec."Invoiced Quantity", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);

        ExcelBuf.AddColumn(BaseUom, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(-ValueEntryRec."Invoiced Quantity HL FND", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);

        ExcelBuf.AddColumn(ValueEntryRec."Cost Amount (Actual)", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);

        //ExcelBuf.AddColumn(ValueEntryRec."Sales Deposit Amount (Actual)", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);

        //ExcelBuf.AddColumn(ValueEntryRec."Sales Tax Amount (Actual)", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);

        ExcelBuf.AddColumn(ValueEntryRec."Sales Amount (Actual)", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);

        ExcelBuf.AddColumn(DiscountAmount, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);

        ExcelBuf.AddColumn(DRRFAmount, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);

        ExcelBuf.AddColumn(ValueEntryRec."Posting Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(RemainingAmount, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(ValueEntryRec."User ID", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(ValueEntryRec."Item Ledger Entry Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(ValueEntryRec."Document Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(CustomerAttributes."Local Customer Sub-Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
    end;

    local procedure CreateExcelbook()
    begin
        ExcelBuf.CreateNewBook(Text002Lbl);
        ExcelBuf.WriteSheet(Text002Lbl, CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(Text002Lbl);
        ExcelBuf.OpenExcel();
    end;

    procedure InitializeRequest(NewPagePerCustomer: Boolean; PrintToExcelFile: Boolean)
    begin
        PrintOnlyOnePerPage := NewPagePerCustomer;
        PrintToExcel := PrintToExcelFile;
    end;


}