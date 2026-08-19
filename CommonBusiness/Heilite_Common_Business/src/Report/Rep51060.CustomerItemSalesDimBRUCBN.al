report 51060 "Cust/ItemSalesDim BRU CBN"
{
    // version HEI.01

    // HEI.01 CHG2039137 IBM.LS 02.12.2019
    //   # Report Imported from HeiLite-2.0 (Report ID - 52524, Report Name - Customer/Item Sales_Dim ETH)
    //   # Changed Report ID - 50394 in BASE.
    //   # Code added to apply the filter on "Item Category Code".
    // HEI.02 Defect #5036 IBM NASTAA02 28.02.2020 # RTR161 Report Customer_Item Sale Dim is missing 2 columns and layout is to be changed
    //   # Quantity and Base Unit of Measure should come from the posted Document
    // HEI.03 FDD-HT1224 IBM SURYAS01 20/04/2020
    //   #Added "Print-To-Excel" option in Request Page.
    //   #Added 4 New Columns in the DataItem and Report layout -"RemainingQuantity","UserID","EntryType","DocumentType","SalesTypeCustomerAttr"
    //   #Added code in Trigger "Value Entry - OnAfterGetRecord()"
    //   #Added Code in Trigger "Customer - OnAfterGetRecord()"
    //   #Created New Functions.
    // HEI.04 CHG2066666 IBM SAMANR01 04/06/2020
    //   # Correct the calculation of Invoice Quantity

    // BC Upgrade SHUKLP03 >>
    // Blocked some part of code because dependency on DIT fields "Invoiced Quantity in HL", "Sales Deposit Amount (Actual)", "Sales Tax Amount (Actual)", "Unit Volume HL", "Qty. per Unit of Measure"
    // Modified procedure CreateExcelbook() code.
    // BC Upgrade SHUKLP03 <<

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\CustomerItem Sales_Dim_BRU.rdlc';

    Caption = 'Customer/Item Sales_Dim';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis; // BC Upgrade SHUKLP03 <<


    dataset
    {
        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = true;
            column(ReportTitle; ReportTitle)
            {
            }
            column(CustomerNo; Customer."No.")
            {
            }
            column(CustomerName; Customer.Name)
            {
            }
            column(SalesTypeCustomerAttr; CustomerAttributes."Local Customer Sub-Type")
            {
            }
            dataitem("Value Entry"; "Value Entry")
            {
                DataItemTableView = SORTING("Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Variance Type", "Item Charge No.", "Location Code", "Variant Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Source Type", "Source No.");
                RequestFilterFields = "Item No.", "Posting Date", "Entry Type";
                column(LocationCode_ValueEntry; ValueEntry."Location Code")
                {
                }
                column(DimensionCode; DimensionCode)
                {
                }
                column(DocumentNo_ValueEntry; ValueEntry."Document No.")
                {
                }
                column(DimensionDescription; DimensionDescription)
                {
                }
                column(ItemNo_ValueEntry; ValueEntry."Item No.")
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
                // column(InvoicedQuantityinHL_ValueEntry;-ValueEntry."Invoiced Quantity in HL") // BC Upgrade SHUKLP03 << DIT "Invoiced Quantity in HL". 
                // {
                // }
                column(InvoicedQuantityinHL_ValueEntry; '') // BC Upgrade SHUKLP03 << Removed expression.
                {
                }
                column(CostAmountActual_ValueEntry; ValueEntry."Cost Amount (Actual)")
                {
                }
                // column(SalesDepositAmountActual_ValueEntry;ValueEntry."Sales Deposit Amount (Actual)") // BC Upgrade SHUKLP03 << DIT "Sales Deposit Amount (Actual)".
                // {
                // }
                // column(SalesTaxAmountActual_ValueEntry;ValueEntry."Sales Tax Amount (Actual)") // BC Upgrade SHUKLP03 << DIT "Sales Tax Amount (Actual)".
                // {
                // }
                column(SalesDepositAmountActual_ValueEntry; '') // BC Upgrade SHUKLP03 << Removed expression.
                {
                }
                column(SalesTaxAmountActual_ValueEntry; '') // BC Upgrade SHUKLP03 << Removed expression.
                {
                }
                column(SalesAmountActual_ValueEntry; ValueEntry."Sales Amount (Actual)")
                {
                }
                column(DiscountAmount_ValueEntry; ValueEntry."Discount Amount")
                {
                }
                column(PostingDate_ValueEntry; FORMAT(ValueEntry."Posting Date"))
                {
                }
                column(ItemLedgerEntryNo_ValueEntry; ValueEntry."Item Ledger Entry No.")
                {
                }
                column(RemainingAmount; RemainingAmount)
                {
                }
                column(EntryType; ValueEntry."Item Ledger Entry Type")
                {
                }
                column(DocumentType; ValueEntry."Document Type")
                {
                }
                column(Userid; ValueEntry."User ID")
                {
                }
                column(ShipmentCode; ShipmentCode)
                {
                }

                trigger OnAfterGetRecord();
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    DimSetEntry: Record "Dimension Set Entry";
                    DimensionValue: Record "Dimension Value";
                    Item: Record Item;
                begin
                    ItemLedgEntry.RESET();
                    ItemLedgEntry.SETRANGE("Entry No.", "Item Ledger Entry No.");
                    if ItemCategoryCode <> '' then
                        ItemLedgEntry.SETFILTER("Item Category Code", ItemCategoryCode);
                    if not ItemLedgEntry.FINDFIRST() then
                        CurrReport.SKIP()
                    else begin
                        BaseUom := '';
                        ShipmentCode := '';
                        DimensionCode := '';
                        ItemDescription := '';
                        DimensionDescription := '';
                        ValueEntry.RESET();
                        ValueEntry.GET("Entry No.");
                        Item.GET(ValueEntry."Item No.");
                        ItemDescription := Item.Description;
                        BaseUom := Item."Base Unit of Measure";
                        if DimSetEntry.GET(ItemLedgEntry."Dimension Set ID", Dimension) then begin
                            DimensionCode := DimSetEntry."Dimension Value Code";
                            if DimensionValue.GET(Dimension, DimSetEntry."Dimension Value Code") then
                                DimensionDescription := DimensionValue.Name;
                        end;
                        if SalesInvoiceHeader.GET(ValueEntry."Document No.") then
                            ShipmentCode := SalesInvoiceHeader."Shipment Method Code";
                    end;

                    //HEI.02>>
                    CLEAR(SalesInvoiceLine);
                    CLEAR(SalesCrMemoLine);
                    CLEAR(DocumentUoM);
                    CLEAR(DocumentQuantity);
                    CLEAR(DocumentQuantityHL);

                    if "Document Type" = "Document Type"::"Sales Invoice" then begin
                        SalesInvoiceLine.SETRANGE("Document No.", "Document No.");
                        SalesInvoiceLine.SETRANGE("Line No.", "Document Line No.");
                        SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::Item);
                        if SalesInvoiceLine.FINDFIRST() then begin
                            DocumentUoM := SalesInvoiceLine."Unit of Measure Code";
                            //DocumentQuantity := SalesInvoiceLine.Quantity;  // HEI.04>>
                            // DocumentQuantityHL := SalesInvoiceLine.Quantity * "Unit Volume HL"; // BC Upgrade SHUKLP03 << "Unit Volume HL".
                        end;
                    end else if "Document Type" = "Document Type"::"Sales Credit Memo" then begin
                        SalesCrMemoLine.SETRANGE("Document No.", "Document No.");
                        SalesCrMemoLine.SETRANGE("Line No.", "Document Line No.");
                        SalesCrMemoLine.SETRANGE(Type, SalesCrMemoLine.Type::Item);
                        if SalesCrMemoLine.FINDFIRST() then begin
                            DocumentUoM := SalesCrMemoLine."Unit of Measure Code";
                            //DocumentQuantity := -SalesCrMemoLine.Quantity;  // HEI.04>>
                            // DocumentQuantityHL := -SalesCrMemoLine.Quantity * "Unit Volume HL"; // BC Upgrade SHUKLP03 << "Unit Volume HL".
                        end;
                    end;
                    //HEI.02<<
                    // HEI.04>>
                    // DocumentQuantity := -("Invoiced Quantity"/"Qty. per Unit of Measure"); // BC Upgrade SHUKLP03 << "Qty. per Unit of Measure".
                    // HEI.04<<
                    /*
                    Var_Userid := '';
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETRANGE("No.","Document No.");
                    SalesInvoiceHeader.SETRANGE("Posting Date","Posting Date");
                    IF SalesInvoiceHeader.FINDSET THEN BEGIN
                      Var_Userid := SalesInvoiceHeader."User ID";
                    END;
                    */

                    //HEi.03<<
                    RemainingAmount := 0;
                    ItemLedgEntry.RESET();
                    ItemLedgEntry.SETRANGE("Entry No.", "Item Ledger Entry No.");
                    if ItemLedgEntry.FINDSET() then
                        repeat
                            RemainingAmount += ItemLedgEntry."Remaining Quantity";
                        until ItemLedgEntry.NEXT() = 0;


                    if PrintToExcel then
                        MakeExcelDataBody();
                    //HEi.03>>

                end;

                trigger OnPreDataItem();
                begin
                    SETRANGE("Item Ledger Entry Type", "Item Ledger Entry Type"::Sale);
                    SETRANGE("Source Type", "Source Type"::Customer);
                    SETRANGE("Source No.", Customer."No.");
                    SETFILTER("Document Type", '%1|%2', "Document Type"::"Sales Invoice", "Document Type"::"Sales Credit Memo");
                end;
            }

            trigger OnAfterGetRecord();
            begin
                ReportTitle := 'Customer/Item Sales_Dim ' + "Value Entry".GETFILTERS;

                if Dimension <> '' then
                    ReportTitle := ReportTitle + ', Dimension: ' + Dimension;
                if ItemCategoryCode <> '' then
                    ReportTitle := ReportTitle + ', Item Category Code: ' + ItemCategoryCode;

                CustomerAttributes.RESET();
                if CustomerAttributes.GET(Customer."No.") then;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(DimToExport; Dimension)
                    {
                        CaptionML = ENU = 'Dimension to Export',
                                    FRA = 'Dimension à exporter';
                        TableRelation = Dimension.Code;
                        ApplicationArea = All;
                    }
                    field(ItemCategoryCode; ItemCategoryCode)
                    {
                        Caption = 'Item Category Code';
                        TableRelation = "Item Category";
                        ApplicationArea = All;
                    }
                    field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print to Excel';
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

    trigger OnPostReport();
    begin
        //HEi.03<<
        if PrintToExcel then
            CreateExcelbook();
        //HEi.03>>
    end;

    trigger OnPreReport();
    begin
        //HEi.03<<
        if PrintToExcel then
            MakeExcelInfo();
        //HEi.03>>
    end;

    var
        CompanyInfo: Record "Company Information";
        Dimension: Code[20];
        DimensionCode: Code[20];
        DimensionDescription: Text[50];
        CustomerName: Text[50];
        ItemDescription: Text[50];
        BaseUom: Code[20];
        ShipmentCode: Code[20];
        ReportTitle: Text;
        ItemCategoryCode: Code[20];
        ValueEntry: Record "Value Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
        RemainingAmount: Decimal;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Var_Userid: Code[20];
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        Text002: Label 'Customer/Item Sales';
        Text003: Label 'Company Name';
        Text004: Label 'Report No.';
        Text005: Label 'Report Name';
        Text006: Label 'User ID';
        Text007: Label 'Date';
        Text013: TextConst ENU = 'Sale Type', FRA = 'Type de vente';
        Text014: TextConst ENU = 'Dimension Code', FRA = 'Code Dimension';
        Text015: TextConst ENU = 'Dimension Name', FRA = 'Nom Dimension';
        Customer_Item_SalesCaptionLbl: Label 'Customer/Item Sales';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY';
        ValueEntryBuffer__Item_No__CaptionLbl: Label 'Item No.';
        Item_DescriptionCaptionLbl: Label 'Item Description';
        ValueEntryBuffer__Invoiced_Quantity_CaptionLbl: Label 'Invoiced Quantity';
        Item__Base_Unit_of_Measure_CaptionLbl: Label 'Base Unit of Measure';
        ValueEntryBuffer__Sales_Amount__Actual___Control44CaptionLbl: Label 'Amount';
        ValueEntryBuffer__Discount_Amount__Control45CaptionLbl: Label 'Discount Amount';
        Profit_Control46CaptionLbl: Label 'Profit';
        ProfitPct_Control47CaptionLbl: Label 'Profit %';
        TotalCaptionLbl: Label 'Total';
        Text012: TextConst ENU = 'Invoiced Quantity in HL', FRA = 'Quantite facturee en HL';
        Text001: Label 'Data';
        PrintOnlyOnePerPage: Boolean;
        CustomerAttributes: Record "Customer Attributes FND";
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        DocumentUoM: Code[10];
        DocumentQuantity: Decimal;
        DocumentQuantityHL: Decimal;

    procedure MakeExcelInfo();
    begin
        //HEi.03<<
        /*ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text003),FALSE,TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text005),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text002),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text004),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Customer/Item Sales",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text008),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(Customer.GETFILTERS,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text009),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn("Item Ledger Entry".GETFILTERS,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;*/

        MakeExcelDataHeader();
        //HEi.03>>

    end;

    local procedure MakeExcelDataHeader();
    begin
        //HEi.03<<
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(Customer.FIELDCAPTION("No."), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.FIELDCAPTION(Name), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(ValueEntry.FIELDCAPTION("Document No."), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);  //SIR
        ExcelBuf.AddColumn("Value Entry".FIELDCAPTION("Location Code"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text); //SIR
        ExcelBuf.AddColumn(FORMAT(Text013), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        if Dimension <> '' then ExcelBuf.AddColumn(FORMAT(Text014), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text); //SIR
        if Dimension <> '' then ExcelBuf.AddColumn(FORMAT(Text015), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text); //SIR

        ExcelBuf.AddColumn(ValueEntry.FIELDCAPTION("Item No."), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Item Description', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ValueEntry.FIELDCAPTION("Invoiced Quantity"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Base Unit of Measure', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        //SIR
        ExcelBuf.AddColumn(FORMAT(Text012), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ValueEntry.FIELDCAPTION("Cost Amount (Actual)"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        // ExcelBuf.AddColumn(ValueEntry.FIELDCAPTION("Sales Deposit Amount (Actual)"),false,'',true,false,true,'',ExcelBuf."Cell Type"::Text); // BC Upgrade SHUKLP03 << "Sales Deposit Amount (Actual)".
        // ExcelBuf.AddColumn(ValueEntry.FIELDCAPTION("Sales Tax Amount (Actual)"),false,'',true,false,true,'',ExcelBuf."Cell Type"::Text); // BC Upgrade SHUKLP03 << "Sales Tax Amount (Actual)".
        //SIR END

        ExcelBuf.AddColumn(ValueEntry.FIELDCAPTION("Sales Amount (Actual)"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ValueEntry.FIELDCAPTION("Discount Amount"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Posting Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Remaining Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('User ID', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Entry Type', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Document Type', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Sales Type-Customer Attr', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        //HEi.03>>
    end;

    procedure MakeExcelDataBody();
    begin
        //HEi.03<<
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(Customer."No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.Name, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ValueEntry."Document No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ValueEntry."Location Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); //SIR
        ExcelBuf.AddColumn(FORMAT(ShipmentCode), false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); //SIR
        if Dimension <> '' then ExcelBuf.AddColumn(FORMAT(DimensionCode), false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); //SIR
        if Dimension <> '' then ExcelBuf.AddColumn(FORMAT(DimensionDescription), false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); //SIR

        ExcelBuf.AddColumn(ValueEntry."Item No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ItemDescription, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(-ValueEntry."Invoiced Quantity", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(BaseUom, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        //SIR
        // ExcelBuf.AddColumn(-ValueEntry."Invoiced Quantity in HL",false,'',false,false,false,'',ExcelBuf."Cell Type"::Number); // BC Upgrade SHUKLP03 << "Invoiced Quantity in HL".
        ExcelBuf.AddColumn(ValueEntry."Cost Amount (Actual)", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        // ExcelBuf.AddColumn(ValueEntry."Sales Deposit Amount (Actual)",false,'',false,false,false,'',ExcelBuf."Cell Type"::Number); // BC Upgrade SHUKLP03 << "Sales Deposit Amount (Actual)".
        // ExcelBuf.AddColumn(ValueEntry."Sales Tax Amount (Actual)",false,'',false,false,false,'',ExcelBuf."Cell Type"::Number); // BC Upgrade SHUKLP03 << "Sales Tax Amount (Actual)".
        //SIR END

        ExcelBuf.AddColumn(ValueEntry."Sales Amount (Actual)", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ValueEntry."Discount Amount", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ValueEntry."Posting Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(RemainingAmount, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ValueEntry."User ID", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ValueEntry."Item Ledger Entry Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ValueEntry."Document Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(CustomerAttributes."Local Customer Sub-Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        //HEi.03>>
    end;

    procedure CreateExcelbook();
    begin
        //HEi.03<<
        // ExcelBuf.CreateBookAndOpenExcel('',Text002,'',COMPANYNAME,USERID); // BC Upgrade SHUKLP03 << Blocked code because only for On-prem.
        // BC Upgrade SHUKLP03 >> Modified code as per Saas
        ExcelBuf.CreateNewBook(Text002);
        ExcelBuf.WriteSheet('', CompanyName, UserId);
        ExcelBuf.SetFriendlyFilename('EXCELFile');
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
        // BC Upgrade SHUKLP03 << Modified code as per Saas
        ERROR('');
        //HEi.03>>
    end;

    procedure InitializeRequest(NewPagePerCustomer: Boolean; PrintToExcelFile: Boolean);
    begin
        //HEi.03<<
        PrintOnlyOnePerPage := NewPagePerCustomer;
        PrintToExcel := PrintToExcelFile;
        //HEi.03>>
    end;
}

