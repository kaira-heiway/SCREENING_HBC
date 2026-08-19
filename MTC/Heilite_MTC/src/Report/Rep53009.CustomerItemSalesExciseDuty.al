report 53009 "Customer/Item Sales-ExciseDuty"
{
    // version HEI.02

    // #HEI.01 IBM PATHAA02 #Excise Duty Report
    // #HEI.02 IBM POSTOI01 07.07.2018
    //   Correct the calculation of "Sales Deposit Amount (Actual)" and "Sales Tax Amount (Actual)" amounts
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID is - 50048.
    // 2. Add layout path and Change extension RDLC to RDL.
    // 3. Remove Drink-IT Fields and related code("Sales Deposit Amount (Actual)", "Sales Tax Amount (Actual)", "Invoiced Quantity in HL")
    // 4. Add a custom function GetRecordFiltersWithCaptions because because the CaptionManagement codeunit is not available in Business Central. So, the same work that the function inside that codeunit was doing will now be handled by this function.
    // 5. Add ApplicationArea property in Report and requestpage fields.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\CustomerItem Sales-ExciseDuty.rdl'; // BC Upgrade BHARDA11 ---Add layout path and Change extension RDLC to RDL.

    Caption = 'Customer/Item Sales-ExciseDuty';

    dataset
    {
        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group";
            column(STRSUBSTNO_Text000_PeriodText_; STRSUBSTNO(Text000, PeriodText))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
            {
            }
            column(Customer_TABLECAPTION__________CustFilter; TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(Value_Entry__TABLECAPTION__________ItemLedgEntryFilter; "Value Entry".TABLECAPTION + ': ' + ValueEntryFilter)
            {
            }
            column(ItemLedgEntryFilter; ValueEntryFilter)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer__Phone_No__; "Phone No.")
            {
            }
            column(ValueEntryBuffer__Sales_Amount__Actual__; ValueEntryBuffer."Sales Amount (Actual)")
            {
            }
            column(ValueEntryBuffer__Discount_Amount_; -ValueEntryBuffer."Discount Amount")
            {
            }
            column(Profit; Profit)
            {
                AutoFormatType = 1;
            }
            column(ProfitPct; ProfitPct)
            {
                DecimalPlaces = 1 : 1;
            }
            column(Customer_Item_SalesCaption; Customer_Item_SalesCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(ValueEntryBuffer__Item_No__Caption; ValueEntryBuffer__Item_No__CaptionLbl)
            {
            }
            column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
            {
            }
            column(ValueEntryBuffer__Invoiced_Quantity_Caption; ValueEntryBuffer__Invoiced_Quantity_CaptionLbl)
            {
            }
            column(Item__Base_Unit_of_Measure_Caption; Item__Base_Unit_of_Measure_CaptionLbl)
            {
            }
            column(ValueEntryBuffer__Sales_Amount__Actual___Control44Caption; ValueEntryBuffer__Sales_Amount__Actual___Control44CaptionLbl)
            {
            }
            column(ValueEntryBuffer__Discount_Amount__Control45Caption; ValueEntryBuffer__Discount_Amount__Control45CaptionLbl)
            {
            }
            column(Profit_Control46Caption; Profit_Control46CaptionLbl)
            {
            }
            column(ProfitPct_Control47Caption; ProfitPct_Control47CaptionLbl)
            {
            }
            column(Customer__Phone_No__Caption; FIELDCAPTION("Phone No."))
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            dataitem("Value Entry"; "Value Entry")
            {
                DataItemLink = "Source No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter"),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Source Type", "Source No.", "Item No.", "Variant Code", "Posting Date")
                                    WHERE("Source Type" = CONST(Customer),
                                          "Item Charge No." = CONST(),
                                          "Expected Cost" = CONST(false));
                RequestFilterFields = "Item No.", "Posting Date";

                trigger OnAfterGetRecord();
                var
                    // BC UPGRADE KAPOOV01 PID-515 -Handled Aptean Gap >>
                    ItemLedgerEntryRec: Record "Item Ledger Entry";
                    TaxLedgerEntryRec: Record TaxLedgerEntry102FDW;
                    EmptyGoodsLedgerEntryRec: Record LedgerEntry104FDW;
                    // BC UPGRADE KAPOOV01 PID-515 -Handled Aptean Gap <<
                    EntryInBufferExists: Boolean;
                begin
                    //PATHAA02>>
                    //DimSetEntry.RESET;
                    IF SalesHeaderInvoice.GET("Value Entry"."Document No.") THEN
                        ShipmentCode := SalesHeaderInvoice."Shipment Method Code"
                    ELSE
                        ShipmentCode := '';

                    IF DimSetEntry.GET("Value Entry"."Dimension Set ID", Dimension) THEN BEGIN
                        DimensionCode := DimSetEntry."Dimension Value Code";
                        IF DimensionValue.GET(Dimension, DimSetEntry."Dimension Value Code") THEN
                            DimensionDescription := DimensionValue.Name
                    END;
                    //PATHAA02<<

                    ValueEntryBuffer.INIT;
                    ValueEntryBuffer.SETRANGE("Item No.", "Item No.");
                    EntryInBufferExists := ValueEntryBuffer.FINDFIRST;

                    IF NOT EntryInBufferExists THEN
                        ValueEntryBuffer."Entry No." := "Item Ledger Entry No.";
                    ValueEntryBuffer."Item No." := "Item No.";
                    ValueEntryBuffer."Invoiced Quantity" += "Invoiced Quantity";
                    ValueEntryBuffer."Sales Amount (Actual)" += "Sales Amount (Actual)";
                    ValueEntryBuffer."Cost Amount (Actual)" += "Cost Amount (Actual)";
                    ValueEntryBuffer."Cost Amount (Non-Invtbl.)" += "Cost Amount (Non-Invtbl.)";
                    ValueEntryBuffer."Discount Amount" += "Discount Amount";
                    //PATHAA02>>
                    //ValueEntryBuffer."Cost Amount (Actual)"+= "Cost Amount (Actual)";  NAIKH01 DEFECT 1593
                    // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Sales Deposit Amount (Actual)","Sales Tax Amount (Actual)","Invoiced Quantity in HL")
                    // ValueEntryBuffer."Sales Deposit Amount (Actual)" += "Sales Deposit Amount (Actual)";
                    // ValueEntryBuffer."Sales Tax Amount (Actual)" += "Sales Tax Amount (Actual)";
                    // ValueEntryBuffer."Invoiced Quantity in HL" += "Invoiced Quantity in HL";
                    // BC Upgrade BHARDA11 << ----Drink-IT Fields("Sales Deposit Amount (Actual)","Sales Tax Amount (Actual)","Invoiced Quantity in HL")
                    // BC UPGRADE KAPOOV01 PID-515 -Handled Aptean Gap >>
                    if PrintToExcel then begin
                        // Using AdjSalesCostAmntByWeight58FDW in "Value Entry" Buffer to store and calculate "Sales Deposit Amount (Actual)" on Runtime.
                        EmptyGoodsLedgerEntryRec.Reset();
                        EmptyGoodsLedgerEntryRec.SetRange("Item Ledger Entry No.", "Value Entry"."Item Ledger Entry No.");
                        EmptyGoodsLedgerEntryRec.SetRange("Document Type", EmptyGoodsLedgerEntryRec."Document Type"::"Posted Sales Invoice");
                        EmptyGoodsLedgerEntryRec.SetFilter("Deposit Amount", '<>%1', 0);
                        if EmptyGoodsLedgerEntryRec.FindSet() then
                            repeat
                                ValueEntryBuffer."Sales Dep Amt (Actual) FND" += EmptyGoodsLedgerEntryRec."Deposit Amount";
                            // ValueEntryBuffer.AdjSalesCostAmntByWeight58FDW += EmptyGoodsLedgerEntryRec."Deposit Amount"; //#BCUP0-30 Fix -BC Upgrade KAIRAR01
                            until EmptyGoodsLedgerEntryRec.Next() = 0;

                        // Using SalesCostAmountWghtAct58FDW in "Value Entry" Buffer to store and calculate "Sales Tax Amount (Actual)" on Runtime.
                        TaxLedgerEntryRec.Reset();
                        TaxLedgerEntryRec.SetRange("Item Ledger Entry No.", "Value Entry"."Item Ledger Entry No.");
                        TaxLedgerEntryRec.SetFilter(Amount, '<>%1', 0);
                        if TaxLedgerEntryRec.FindFirst() then
                            ValueEntryBuffer."Sales Tax Amount (Actual) FND" += TaxLedgerEntryRec.Amount;
                        // ValueEntryBuffer.SalesCostAmountWghtAct58FDW += TaxLedgerEntryRec.Amount; //#BCUP0-30 Fix -BC Upgrade KAIRAR01

                        // Using ValuedWeightQuantity58FDW in "Value Entry" Buffer to store and calculate "Invoiced Quantity in HL" on Runtime.
                        if ItemLedgerEntryRec.Get("Value Entry"."Item Ledger Entry No.") then
                            if (ItemLedgerEntryRec."Volume 2 101FDW" <> 0) and (ItemLedgerEntryRec."Invoiced Quantity" <> 0) and (ItemLedgerEntryRec.Quantity <> 0) then
                                ValueEntryBuffer."Invoiced Qty. in HL FND" += ItemLedgerEntryRec."Volume 2 101FDW" * ItemLedgerEntryRec."Invoiced Quantity" / ItemLedgerEntryRec.Quantity;
                        // ValueEntryBuffer.ValuedWeightQuantity58FDW += ItemLedgerEntryRec."Volume 2 101FDW" * ItemLedgerEntryRec."Invoiced Quantity" / ItemLedgerEntryRec.Quantity; //#BCUP0-30 Fix -BC Upgrade KAIRAR01
                    end;
                    // BC UPGRADE KAPOOV01 PID-515 -Handled Aptean Gap <<
                    ValueEntryBuffer."Location Code" := "Location Code";
                    //PATHAA02<<
                    IF EntryInBufferExists THEN
                        ValueEntryBuffer.MODIFY
                    ELSE
                        ValueEntryBuffer.INSERT;
                end;

                trigger OnPreDataItem();
                begin
                    ValueEntryBuffer.RESET;
                    ValueEntryBuffer.DELETEALL;
                end;
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number);
                column(ValueEntryBuffer__Item_No__; ValueEntryBuffer."Item No.")
                {
                }
                column(Item_Description; Item.Description)
                {
                }
                column(ValueEntryBuffer__Invoiced_Quantity_; -ValueEntryBuffer."Invoiced Quantity")
                {
                    DecimalPlaces = 0 : 5;
                }
                column(ValueEntryBuffer__Sales_Amount__Actual___Control44; ValueEntryBuffer."Sales Amount (Actual)")
                {
                    AutoFormatType = 1;
                }
                column(ValueEntryBuffer__Discount_Amount__Control45; -ValueEntryBuffer."Discount Amount")
                {
                    AutoFormatType = 1;
                }
                column(Profit_Control46; Profit)
                {
                    AutoFormatType = 1;
                }
                column(ProfitPct_Control47; ProfitPct)
                {
                    DecimalPlaces = 1 : 1;
                }
                column(Item__Base_Unit_of_Measure_; Item."Base Unit of Measure")
                {
                }

                trigger OnAfterGetRecord();
                var
                    ValueEntry: Record "Value Entry";
                    // BC UPGRADE KAPOOV01 PID-515 -Handled Aptean Gap >>
                    ItemLedgerEntryRec: Record "Item Ledger Entry";
                    TaxLedgerEntryRec: Record TaxLedgerEntry102FDW;
                    EmptyGoodsLedgerEntryRec: Record LedgerEntry104FDW;
                // BC UPGRADE KAPOOV01 PID-515 -Handled Aptean Gap <<
                begin
                    IF Number = 1 THEN
                        ValueEntryBuffer.FIND('-')
                    ELSE
                        ValueEntryBuffer.NEXT;

                    "Value Entry".COPYFILTER("Posting Date", ValueEntry."Posting Date");
                    //HEI.02 ValueEntry.SETRANGE("Item Ledger Entry No.",ValueEntryBuffer."Entry No.");
                    //HEI.02+
                    ValueEntry.SETFILTER("Source Type", '=%1', ValueEntry."Source Type"::Customer);
                    ValueEntry.SETFILTER("Source No.", '=%1', Customer."No.");
                    //HEI.02-
                    ValueEntry.SETFILTER("Item Charge No.", '<>%1', '');


                    //ValueEntry.CALCSUMS("Sales Amount (Actual)","Cost Amount (Actual)","Cost Amount (Non-Invtbl.)","Discount Amount");
                    ValueEntry.CALCSUMS("Sales Amount (Actual)", "Cost Amount (Actual)", "Cost Amount (Non-Invtbl.)", "Discount Amount", "Cost Amount (Actual)");
                    // "Cost Amount (Actual)", "Sales Deposit Amount (Actual)", "Sales Tax Amount (Actual)"); // BC Upgrade BHARDA11 ----drink-IT Fields("Sales Deposit Amount (Actual)", "Sales Tax Amount (Actual)")



                    ValueEntryBuffer."Sales Amount (Actual)" += ValueEntry."Sales Amount (Actual)";
                    ValueEntryBuffer."Cost Amount (Actual)" += ValueEntry."Cost Amount (Actual)";
                    ValueEntryBuffer."Cost Amount (Non-Invtbl.)" += ValueEntry."Cost Amount (Non-Invtbl.)";
                    ValueEntryBuffer."Discount Amount" += ValueEntry."Discount Amount";

                    //PATHAA02>>
                    //ValueEntryBuffer."Cost Amount (Actual)"+= ValueEntry."Cost Amount (Actual)";  NAIKH01 DEFECT 1593
                    // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Sales Deposit Amount (Actual)","Sales Tax Amount (Actual)","Sales Deposit Amount (Actual)")
                    // ValueEntryBuffer."Sales Deposit Amount (Actual)" += ValueEntry."Sales Deposit Amount (Actual)";
                    // ValueEntryBuffer."Sales Tax Amount (Actual)" += ValueEntry."Sales Tax Amount (Actual)";
                    //PATHAA02<<
                    Profit :=
                      ValueEntryBuffer."Sales Amount (Actual)" +
                      ValueEntryBuffer."Cost Amount (Actual)" +
                      ValueEntryBuffer."Cost Amount (Non-Invtbl.)";

                    IF Item.GET(ValueEntryBuffer."Item No.") THEN;

                    // BC UPGRADE KAPOOV01 PID-515 -Handled Aptean Gap >>
                    if PrintToExcel then begin
                        // Using AdjSalesCostAmntByWeight58FDW in "Value Entry" Buffer to store and calculate "Sales Deposit Amount (Actual)" on Runtime.
                        EmptyGoodsLedgerEntryRec.Reset();
                        EmptyGoodsLedgerEntryRec.SetRange("Item Ledger Entry No.", ValueEntry."Item Ledger Entry No.");
                        EmptyGoodsLedgerEntryRec.SetRange("Document Type", EmptyGoodsLedgerEntryRec."Document Type"::"Posted Sales Invoice");
                        EmptyGoodsLedgerEntryRec.SetFilter("Deposit Amount", '<>%1', 0);
                        if EmptyGoodsLedgerEntryRec.FindSet() then
                            repeat
                                ValueEntryBuffer."Sales Dep Amt (Actual) FND" += EmptyGoodsLedgerEntryRec."Deposit Amount";
                            // ValueEntryBuffer.AdjSalesCostAmntByWeight58FDW += EmptyGoodsLedgerEntryRec."Deposit Amount"; //#BCUP0-30 Fix -BC Upgrade KAIRAR01
                            until EmptyGoodsLedgerEntryRec.Next() = 0;

                        // Using SalesCostAmountWghtAct58FDW in "Value Entry" Buffer to store and calculate "Sales Tax Amount (Actual)" on Runtime.
                        TaxLedgerEntryRec.Reset();
                        TaxLedgerEntryRec.SetRange("Item Ledger Entry No.", ValueEntry."Item Ledger Entry No.");
                        TaxLedgerEntryRec.SetFilter(Amount, '<>%1', 0);
                        if TaxLedgerEntryRec.FindFirst() then
                            ValueEntryBuffer."Sales Tax Amount (Actual) FND" += TaxLedgerEntryRec.Amount;
                        // ValueEntryBuffer.SalesCostAmountWghtAct58FDW += TaxLedgerEntryRec.Amount; //#BCUP0-30 Fix -BC Upgrade KAIRAR01

                        // Using ValuedWeightQuantity58FDW in "Value Entry" Buffer to store and calculate "Invoiced Quantity in HL" on Runtime.
                        if ItemLedgerEntryRec.Get(ValueEntry."Item Ledger Entry No.") then
                            if (ItemLedgerEntryRec."Volume 2 101FDW" <> 0) and (ItemLedgerEntryRec."Invoiced Quantity" <> 0) and (ItemLedgerEntryRec.Quantity <> 0) then
                                ValueEntryBuffer."Invoiced Qty. in HL FND" += ItemLedgerEntryRec."Volume 2 101FDW" * ItemLedgerEntryRec."Invoiced Quantity" / ItemLedgerEntryRec.Quantity;
                        // ValueEntryBuffer.ValuedWeightQuantity58FDW += ItemLedgerEntryRec."Volume 2 101FDW" * ItemLedgerEntryRec."Invoiced Quantity" / ItemLedgerEntryRec.Quantity; //#BCUP0-30 Fix -BC Upgrade KAIRAR01
                    end;
                    // BC UPGRADE KAPOOV01 PID-515 -Handled Aptean Gap <<

                    //PATHAA02>>
                    IF PrintToExcel THEN
                        MakeExcelDataBody;
                    //PATHAA02<<
                end;

                trigger OnPreDataItem();
                begin
                    /*CurrReport.CREATETOTALS(
                      ValueEntryBuffer."Sales Amount (Actual)",
                      ValueEntryBuffer."Discount Amount",
                      Profit);
                    *///PATHAA02-commented
                    //PATHAA02>>
                    CurrReport.CREATETOTALS(
                      ValueEntryBuffer."Sales Amount (Actual)",
                      ValueEntryBuffer."Discount Amount",
                      Profit,
                      ValueEntryBuffer."Cost Amount (Actual)");
                    // BC Upgrade BHARDA11 >> ----drink-IT Fields("Sales Deposit Amount (Actual)","Sales Tax Amount (Actual)","Invoiced Quantity in HL")
                    //   ValueEntryBuffer."Sales Deposit Amount (Actual)",
                    //   ValueEntryBuffer."Sales Tax Amount (Actual)",
                    //   ValueEntryBuffer."Invoiced Quantity in HL"
                    //   );
                    // BC Upgrade BHARDA11 >> ----drink-IT Fields("Sales Deposit Amount (Actual)","Sales Tax Amount (Actual)","Invoiced Quantity in HL")

                    //PATHAA02<<
                    ValueEntryBuffer.RESET;
                    SETRANGE(Number, 1, ValueEntryBuffer.COUNT);

                end;
            }

            trigger OnPreDataItem();
            begin
                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
                /*
                CurrReport.CREATETOTALS(
                  ValueEntryBuffer."Sales Amount (Actual)",
                  ValueEntryBuffer."Discount Amount",
                  Profit);
                *///PATHAA02

                // CurrReport.CREATETOTALS(ValueEntryBuffer."Cost Amount (Actual)", ValueEntryBuffer."Sales Deposit Amount (Actual)", ValueEntryBuffer."Sales Tax Amount (Actual)", ValueEntryBuffer."Sales Amount (Actual)", ValueEntryBuffer."Discount Amount", Profit); // BC Upgrade BHARDA11 ----Drink-IT Fields(Sales Deposit Amount (Actual)","Sales Tax Amount (Actual)")
                CurrReport.CREATETOTALS(ValueEntryBuffer."Cost Amount (Actual)", ValueEntryBuffer."Sales Amount (Actual)", ValueEntryBuffer."Discount Amount", Profit);

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
                    field(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Page per Customer';
                        ToolTip = 'Specifies if each customer''s information is printed on a new page if you have chosen two or more customers to be included in the report.';
                    }
                    field(PrintToExcel; PrintToExcel)
                    {
                        ApplicationArea = All;
                        Caption = 'Print to Excel';
                    }
                    field(DimToExport; Dimension)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Dimension to Export',
                                    FRA = 'Dimension à exporter';
                        TableRelation = Dimension.Code;
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
        IF PrintToExcel THEN
            CreateExcelbook;
    end;

    trigger OnPreReport();
    var
    // CaptionManagement: Codeunit "CaptionManagement"; // BC Upgrade BHARDA11 ---CaptionManagement missing in BC
    begin
        // CustFilter := CaptionManagement.GetRecordFiltersWithCaptions(Customer); // BC Upgrade BHARDA11 :: Blocked
        CustFilter := GetRecordFiltersWithCaptions(Customer); // BC Upgrade BHARDA11 ::Added
        ValueEntryFilter := "Value Entry".GETFILTERS;
        PeriodText := "Value Entry".GETFILTER("Posting Date");
        IF PrintToExcel THEN
            MakeExcelInfo;
    end;
    // BC Upgrade BHARDA11 >> ---This function was created because the CaptionManagement codeunit is not available in Business Central. So, the same work that the function inside that codeunit was doing will now be handled by this function.
    local procedure GetRecordFiltersWithCaptions(RecVariant: Variant): Text
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
        Filters: Text;
        FieldFilter: Text;
        Name: Text;
        Cap: Text;
        Pos: Integer;
        i: Integer;
    begin
        RecRef.GETTABLE(RecVariant);
        Filters := RecRef.GETFILTERS;
        if Filters = '' then
            exit;

        for i := 1 to RecRef.FIELDCOUNT do begin
            FieldRef := RecRef.FIELDINDEX(i);
            FieldFilter := FieldRef.GETFILTER;
            if FieldFilter <> '' then begin
                Name := STRSUBSTNO('%1: ', FieldRef.NAME);
                Cap := STRSUBSTNO('%1: ', FieldRef.CAPTION);
                Pos := STRPOS(Filters, Name);
                if Pos <> 0 then
                    Filters := INSSTR(DELSTR(Filters, Pos, STRLEN(Name)), Cap, Pos);
            end;
        end;

        exit(Filters);
    end;
    // BC Upgrade BHARDA11 << ----This function was created because the CaptionManagement codeunit is not available in Business Central. So, the same work that the function inside that codeunit was doing will now be handled by this function.


    var
        Text000: Label 'Period: %1';
        Item: Record Item;
        ValueEntryBuffer: Record "Value Entry" temporary;
        CustFilter: Text;
        ValueEntryFilter: Text;
        PeriodText: Text;
        PrintOnlyOnePerPage: Boolean;
        Profit: Decimal;
        ProfitPct: Decimal;
        Text001: Label 'Data';
        Text002: Label 'Customer/Item Sales';
        Text003: Label 'Company Name';
        Text004: Label 'Report No.';
        Text005: Label 'Report Name';
        Text006: Label 'User ID';
        Text007: Label 'Date';
        Text008: Label 'Customer Filters';
        Text009: Label 'Value Entry Filters';
        Text010: Label 'Profit';
        Text011: Label 'Profit %';
        Text012: Label 'Invoiced Quantity in HL';
        Text013: Label 'Sale Type';
        Text014: Label 'Dimension Code';
        Text015: Label 'Dimension Name';
        // BC UPGRADE KAPOOV01 PID-515 -Handled Aptean Gap >>
        Text016: Label 'Sales Deposit Amount (Actual)';
        Text017: Label 'Sales Tax Amount (Actual)';
        // BC UPGRADE KAPOOV01 PID-515 -Handled Aptean Gap <<
        Customer_Item_SalesCaptionLbl: Label 'Customer/Item Sales';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY';
        ValueEntryBuffer__Item_No__CaptionLbl: Label 'Item No.';
        Item_DescriptionCaptionLbl: Label 'Description';
        ValueEntryBuffer__Invoiced_Quantity_CaptionLbl: Label 'Invoiced Quantity';
        Item__Base_Unit_of_Measure_CaptionLbl: Label 'Unit of Measure';
        ValueEntryBuffer__Sales_Amount__Actual___Control44CaptionLbl: Label 'Amount';
        ValueEntryBuffer__Discount_Amount__Control45CaptionLbl: Label 'Discount Amount';
        Profit_Control46CaptionLbl: Label 'Profit';
        ProfitPct_Control47CaptionLbl: Label 'Profit %';
        TotalCaptionLbl: Label 'Total';
        PrintToExcel: Boolean;
        DimensionCode: Code[20];
        DimensionDescription: Text[50];
        DimensionValue: Record "Dimension Value";
        SalesHeaderInvoice: Record "Sales Invoice Header";
        DimSetEntry: Record "Dimension Set Entry";
        ShipmentCode: Code[20];
        Dimension: Code[20];
        DimSetid: Integer;
        ValueentryInvoiceQty: Integer;
        ExcelBuf: Record "Excel Buffer" temporary;

    procedure InitializeRequest(NewPagePerCustomer: Boolean);
    begin
        PrintOnlyOnePerPage := NewPagePerCustomer;
    end;

    local procedure CalcProfitPct();
    begin
        IF ValueEntryBuffer."Sales Amount (Actual)" <> 0 THEN
            ProfitPct := ROUND(100 * Profit / ValueEntryBuffer."Sales Amount (Actual)", 0.1)
        ELSE
            ProfitPct := 0;
    end;

    procedure MakeExcelInfo();
    begin
        /*ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text003),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
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
        ExcelBuf.AddInfoColumn("Value Entry".GETFILTERS,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        */
        MakeExcelDataHeader;

    end;

    local procedure MakeExcelDataHeader();
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer.FIELDCAPTION("No."), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);//1
        ExcelBuf.AddColumn(Customer.FIELDCAPTION(Name), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);//2
        ExcelBuf.AddColumn(ValueEntryBuffer.FIELDCAPTION("Location Code"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);//3
        ExcelBuf.AddColumn(FORMAT(Text013), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);//4
        ExcelBuf.AddColumn(FORMAT(Text014), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);//5
        ExcelBuf.AddColumn(FORMAT(Text015), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);//6
        ExcelBuf.AddColumn(ValueEntryBuffer.FIELDCAPTION("Item No."), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);//7
        ExcelBuf.AddColumn(Item.FIELDCAPTION(Description), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);//8
        ExcelBuf.AddColumn(ValueEntryBuffer.FIELDCAPTION("Invoiced Quantity"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);//9
        ExcelBuf.AddColumn(Item.FIELDCAPTION("Base Unit of Measure"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);//10
        // ExcelBuf.AddColumn(FORMAT(Text012), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);//11 // BC Upgrade BHARDA11 ---Drink-IT Field("Invoiced Quantity in HL")
        ExcelBuf.AddColumn(FORMAT(Text012), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text); //11 // BC UPGRADE KAPOOV01 PID-515 -Handled Aptean Gap 
        ExcelBuf.AddColumn(ValueEntryBuffer.FIELDCAPTION("Cost Amount (Actual)"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);//12
        // ExcelBuf.AddColumn(ValueEntryBuffer.FIELDCAPTION("Sales Deposit Amount (Actual)"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);//13 // BC Upgrade BHARDA11 ----Drink-IT Field("Sales Deposit Amount (Actual)")
        // ExcelBuf.AddColumn(ValueEntryBuffer.FIELDCAPTION("Sales Tax Amount (Actual)"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);//14   // BC Upgrade BHARDA11 ----Drink-IT Field("Sales Tax Amount (Actual)")
        // BC UPGRADE KAPOOV01 PID-515 -Handled Aptean Gap >>
        ExcelBuf.AddColumn(FORMAT(Text016), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text); //13
        ExcelBuf.AddColumn(FORMAT(Text017), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text); //14
        // BC UPGRADE KAPOOV01 PID-515 -Handled Aptean Gap <<
        ExcelBuf.AddColumn(ValueEntryBuffer.FIELDCAPTION("Sales Amount (Actual)"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);//15 
        ExcelBuf.AddColumn(ValueEntryBuffer.FIELDCAPTION("Discount Amount"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text); //16
    end;

    procedure MakeExcelDataBody();
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //1
        ExcelBuf.AddColumn(Customer.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //2
        ExcelBuf.AddColumn(ValueEntryBuffer."Location Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //3
        //ExcelBuf.AddColumn(FORMAT(ShipmentCode),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(''), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//4
        ExcelBuf.AddColumn(FORMAT(DimensionCode), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//5
        ExcelBuf.AddColumn(FORMAT(DimensionDescription), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//6
        ExcelBuf.AddColumn(ValueEntryBuffer."Item No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//7
        ExcelBuf.AddColumn(Item.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//8
        ExcelBuf.AddColumn(-ValueEntryBuffer."Invoiced Quantity", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);//9
        ExcelBuf.AddColumn(Item."Base Unit of Measure", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//10
        // ExcelBuf.AddColumn(-ValueEntryBuffer."Invoiced Quantity in HL", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);//11 // BC Upgrade BHARDA11 ----Drink-IT Field("Invoiced Quantity in HL")
        ExcelBuf.AddColumn(ValueEntryBuffer."Invoiced Qty. in HL FND", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);//11 // BC UPGRADE KAPOOV01 PID-515 -Handled Aptean Gap //#BCUP0-30 Fix -BC Upgrade KAIRAR01
        ExcelBuf.AddColumn(ValueEntryBuffer."Cost Amount (Actual)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);//12

        // BC UPGRADE KAPOOV01 PID-515 -Handled Aptean Gap >>
        ExcelBuf.AddColumn(ValueEntryBuffer."Sales Dep Amt (Actual) FND", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);//13 //#BCUP0-30 Fix -BC Upgrade KAIRAR01
        ExcelBuf.AddColumn(ValueEntryBuffer."Sales Tax Amount (Actual) FND", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);//14 //#BCUP0-30 Fix -BC Upgrade KAIRAR01
        // BC UPGRADE KAPOOV01 PID-515 -Handled Aptean Gap <<                                                                                                                                           

        // ExcelBuf.AddColumn(ValueEntryBuffer."Sales Deposit Amount (Actual)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);//13 // BC Upgrade BHARDA11 ----Drink-IT Field("Sales Deposit Amount (Actual)")
        // ExcelBuf.AddColumn(ValueEntryBuffer."Sales Tax Amount (Actual)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);//14  // BC Upgrade BHARDA11 ----Drink-IT Field("Sales Tax Amount (Actual)")
        ExcelBuf.AddColumn(ValueEntryBuffer."Sales Amount (Actual)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);//15
        ExcelBuf.AddColumn(-ValueEntryBuffer."Discount Amount", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);//16
    end;

    procedure CreateExcelbook();
    begin

        // ExcelBuf.CreateBookAndOpenExcel('', 'Excise Duty Report', '', COMPANYNAME, USERID); // BC Upgrade BHARAD11 :: Blocked
        // BC Upgrade BHARDA11 >>
        ExcelBuf.CreateNewBook('Excise Duty Report');
        ExcelBuf.WriteSheet('Excise Duty Report', CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename('ExciseDutyReport');
        ExcelBuf.OpenExcel();
        // BC Upgrade BHARAD11 <<
        // ERROR('');  // BC UPGRADE KAPOOV01 PID-515
    end;
}

