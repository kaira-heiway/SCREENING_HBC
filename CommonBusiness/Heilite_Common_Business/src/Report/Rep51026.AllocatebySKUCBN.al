report 51026 "Allocate by SKU CBN"
{
    // version HEI.01

    // HEI.01 #defect1323 POSTOI01 17.01.2018
    //     Modify SETRANGE ->SETFILTER
    // BC Upgrade BHARAD11 >>
    // 1. Add ApplicationArea Property in Report and Fields.
    // 2. Remove Drink-IT Fields (Customer.Distance,"Item Ledger Entry"."Quantity in HL")
    // BC Upgrade BHARDA11 <<

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Entry Type", Nonstock, "Item No.", "Posting Date") WHERE("Entry Type" = FILTER(Sale), "Invoiced Quantity" = FILTER(<> 0));

            trigger OnAfterGetRecord();
            var
                DimSetEntry: Record "Dimension Set Entry";
                BrandDimHierarchy: Record "Brand Dim Hierarchy FND";
                ErrNoFound: Label 'Item No. %1 is not setup in Brand Dim Hierarchy';
                CustomerHierarchy: Record "Customer Hierarchy FND";
                ErrCustNotFound: Label 'Customer No. %1 is not setup in Customer Hierarchy';
                a426codeunit: Codeunit 426;
            begin
                BrandDimHierarchy.SETRANGE("Item No.", "Item No.");
                if not BrandDimHierarchy.FINDFIRST then
                    CurrReport.SKIP;
                if ("Source Type" = "Source Type"::Customer) and ("Source No." <> '') then begin
                    //12.01>>
                    NoOfKms := 0;
                    Customer.GET("Item Ledger Entry"."Source No.");
                    // BC Upgrade BHARDA11 >> ----Drink-IT Field(Customer.Distance)
                    // if SalesShipmentDocNo <> "Item Ledger Entry"."Document No." then
                    //   NoOfKms := Customer.Distance;
                    // BC Upgrade BHARDA11 << ----Drink-IT Field(Customer.Distance)
                    SalesShipmentDocNo := "Item Ledger Entry"."Document No.";


                    //Customer.TESTFIELD(Distance);
                    //12.01<<
                    SalesBuffer.SETRANGE("Item No.", "Item No.");
                    SalesBuffer.SETRANGE("Customer No.", "Source No.");
                    if not SalesBuffer.FINDFIRST then begin
                        SalesBuffer."Item No." := "Item No.";
                        SalesBuffer."Customer No." := "Source No.";
                        // SalesBuffer."Sold Amt" := -"Item Ledger Entry"."Quantity in HL"; // BC Upgrade BHARDA11 ----Drink-IT Field("Item Ledger Entry"."Quantity in HL")
                        //12.01>>
                        SalesBuffer.KMs := NoOfKms;
                        //12.01<<
                        BrandDimHierarchy.SETRANGE("Item No.", "Item No.");
                        if not BrandDimHierarchy.FINDFIRST then
                            //ERROR(ErrNoFound,"Item No.");12.02
                            CurrReport.SKIP;
                        SalesBuffer."Dimension Level 1 Code" := BrandDimHierarchy."Dimension Level 1 Code";
                        SalesBuffer."Dimension Level 1 Value Code" := BrandDimHierarchy."Dimension Level 1 Value Code";
                        SalesBuffer."Dimension Level 2 Code" := BrandDimHierarchy."Dimension Level 2 Code";
                        SalesBuffer."Dimension Level 2 Value Code" := BrandDimHierarchy."Dimension Level 2 Value Code";
                        //CH>>
                        SalesBuffer."Dimension Level 3 Code" := BrandDimHierarchy."Dimension Level 3 Code";
                        SalesBuffer."Dimension Level 3 Value Code" := BrandDimHierarchy."Dimension Level 3 Value Code";

                        CustomerHierarchy.SETRANGE("Customer No.", SalesBuffer."Customer No.");
                        if not CustomerHierarchy.FINDFIRST then
                            //ERROR(ErrCustNotFound,SalesBuffer."Customer No.");12.02
                            CurrReport.SKIP;
                        SalesBuffer."Dimension Level 4 Code" := CustomerHierarchy."Dimension Level 1 Code";
                        SalesBuffer."Dimension Level 4 Value Code" := CustomerHierarchy."Dimension Level 1 Value Code";
                        SalesBuffer."Dimension Level 5 Code" := CustomerHierarchy."Dimension Level 2 Code";
                        SalesBuffer."Dimension Level 5 Value Code" := CustomerHierarchy."Dimension Level 2 Value Code";
                        SalesBuffer."Dimension Level 6 Code" := CustomerHierarchy."Dimension Level 3 Code";
                        SalesBuffer."Dimension Level 6 Value Code" := CustomerHierarchy."Dimension Level 3 Value Code";
                        //CH<<

                        SalesBuffer.INSERT;
                    end else begin
                        // SalesBuffer."Sold Amt" += -"Quantity in HL"; // BC Upgrade BHARAD11 ----Drink-IT Field("Quantity in HL")
                        SalesBuffer.KMs += NoOfKms;
                        SalesBuffer.MODIFY;
                    end;
                    // TotalAmount += -"Quantity in HL"; // BC Upgrade BHARAD11 ----Drink-IT Field("Quantity in HL")
                end;
            end;

            trigger OnPostDataItem();
            var
                CostAllocationTarget: Record "Cost Allocation Target";
                LineNo: Integer;
            begin
            end;

            trigger OnPreDataItem();
            begin
                GLSetup.GET;
                GLSetup.TESTFIELD("SKU Dimension Code FND");
                GLSetup.TESTFIELD("Brand Dimension Code FND");
                GLSetup.TESTFIELD("Customer Dimension Code FND");
                GLSetup.TESTFIELD("Line ext Dimension Code FND");

                SETRANGE("Posting Date", StartingDate, EndingDate);//CH
            end;
        }
        dataitem("Cost Type"; "Cost Type")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord();
            var
                GLAcc: Record "G/L Account";
                GLEntry: Record "G/L Entry";
                SkuNo: Code[20];
                CustNo: Code[20];
                LineExtNo: Code[20];
                BrandNo: Code[20];
                GeneralAlloc: Boolean;
                TotalBrand: Decimal;
                Allocated: Boolean;
                NewJnlLine: Record "Cost Journal Line";
                LastLineNo: Integer;
                SkipGL: Boolean;
                CostC: Record "Cost Center";
                PackType: Code[20];
                BusinessSegment: Code[20];
                ServiceZone: Code[20];
                Channel: Code[20];
                ItemNo: Code[20];
            begin
                if "Cost Type"."G/L Account Range" = '' then
                    CurrReport.SKIP;
                if "Dim Filter 1 Value Code FND" <> '' then
                    TESTFIELD("Dimension Filter 1 Code FND");

                if "Dim Filter 2 Value Code FND" <> '' then
                    TESTFIELD("Dimension Filter 2 Code FND");
                //12.01>>
                if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::" " then
                    ERROR(Text001, "Cost Type"."No.");
                //12.01<<

                CLEAR(SalesBuffer);
                SalesBuffer.MODIFYALL(Expenses, 0);
                GLAcc.SETFILTER("No.", "G/L Account Range");
                GLAcc.SETRANGE("Acc Type FND", GLAcc."Acc Type FND"::Expense);
                //GLAcc.SETRANGE("No.",'38701001');
                if GLAcc.FINDSET then
                    repeat
                        GLEntry.SETCURRENTKEY("G/L Account No.", "Posting Date");
                        GLEntry.SETRANGE("G/L Account No.", GLAcc."No.");
                        GLEntry.SETRANGE("Posting Date", StartingDate, EndingDate);
                        if GLEntry.FINDFIRST then
                            repeat

                                SkipGL := false;
                                if "Dimension Filter 1 Code FND" <> '' then begin
                                    CLEAR(DimSetEntry);
                                    DimSetEntry.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                                    DimSetEntry.SETRANGE("Dimension Code", "Dimension Filter 1 Code FND");
                                    //HEI.01  DimSetEntry.SETRANGE("Dimension Value Code","Dimension Filter 1 Value Code FND");
                                    DimSetEntry.SETFILTER("Dimension Value Code", "Dim Filter 1 Value Code FND"); //HEI.01
                                    if not DimSetEntry.FINDFIRST then
                                        SkipGL := true;
                                end;
                                if "Dimension Filter 2 Code FND" <> '' then begin
                                    CLEAR(DimSetEntry);
                                    DimSetEntry.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                                    DimSetEntry.SETRANGE("Dimension Code", "Dimension Filter 2 Code FND");
                                    //HEI.01 DimSetEntry.SETRANGE("Dimension Value Code","Dimension Filter 2 Value Code FND");
                                    DimSetEntry.SETFILTER("Dimension Value Code", "Dim Filter 2 Value Code FND"); //HEI.01
                                    if not DimSetEntry.FINDFIRST then
                                        SkipGL := true;
                                end;
                                if not SkipGL then begin
                                    //MESSAGE(FORMAT(GLEntry."Entry No."));
                                    SkuNo := '';
                                    CustNo := '';
                                    LineExtNo := '';
                                    BrandNo := '';
                                    PackType := '';//CH
                                    BusinessSegment := '';
                                    ServiceZone := '';
                                    Channel := '';
                                    ItemNo := '';

                                    CLEAR(DimSetEntry);
                                    DimSetEntry.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                                    DimSetEntry.SETRANGE("Dimension Code", GLSetup."SKU Dimension Code FND");
                                    if DimSetEntry.FINDFIRST then
                                        SkuNo := DimSetEntry."Dimension Value Code";

                                    CLEAR(DimSetEntry);
                                    DimSetEntry.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                                    DimSetEntry.SETRANGE("Dimension Code", GLSetup."Customer Dimension Code FND");
                                    if DimSetEntry.FINDFIRST then
                                        CustNo := DimSetEntry."Dimension Value Code";

                                    CLEAR(DimSetEntry);
                                    DimSetEntry.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                                    DimSetEntry.SETRANGE("Dimension Code", GLSetup."Line ext Dimension Code FND");
                                    if DimSetEntry.FINDFIRST then
                                        LineExtNo := DimSetEntry."Dimension Value Code";

                                    CLEAR(DimSetEntry);
                                    DimSetEntry.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                                    DimSetEntry.SETRANGE("Dimension Code", GLSetup."Brand Dimension Code FND");
                                    if DimSetEntry.FINDFIRST then
                                        BrandNo := DimSetEntry."Dimension Value Code";

                                    //CH>>
                                    CLEAR(DimSetEntry);
                                    DimSetEntry.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                                    DimSetEntry.SETRANGE("Dimension Code", GLSetup."Primary Pack Type Dim FND");
                                    if DimSetEntry.FINDFIRST then
                                        PackType := DimSetEntry."Dimension Value Code";
                                    CLEAR(DimSetEntry);
                                    DimSetEntry.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                                    DimSetEntry.SETRANGE("Dimension Code", GLSetup."Business Type Dim Code FND");
                                    if DimSetEntry.FINDFIRST then
                                        BusinessSegment := DimSetEntry."Dimension Value Code";
                                    CLEAR(DimSetEntry);
                                    DimSetEntry.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                                    DimSetEntry.SETRANGE("Dimension Code", 'SERVICE ZONE');
                                    if DimSetEntry.FINDFIRST then
                                        ServiceZone := DimSetEntry."Dimension Value Code";
                                    CLEAR(DimSetEntry);
                                    DimSetEntry.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                                    DimSetEntry.SETRANGE("Dimension Code", GLSetup."Shortcut Dimension 4 Code");
                                    if DimSetEntry.FINDFIRST then
                                        Channel := DimSetEntry."Dimension Value Code";
                                    //CH<<

                                    GeneralAlloc := (SkuNo = '') and (LineExtNo = '') and (BrandNo = '');
                                    Allocated := false;
                                    //Brand+Packtype+bussinss>>
                                    if (BrandNo <> '') and (PackType <> '') and (BusinessSegment <> '') and not Allocated then begin
                                        TotalBrand := 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
                                        SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
                                        SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                    TotalBrand += SalesBuffer."Sold Amt"
                                                else
                                                    TotalBrand += SalesBuffer.KMs;
                                            until SalesBuffer.NEXT = 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
                                        SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
                                        SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if TotalBrand <> 0 then begin
                                                    if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer."Sold Amt" / TotalBrand
                                                    else
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer.KMs / TotalBrand;
                                                    SalesBuffer.MODIFY;
                                                end;
                                            until SalesBuffer.NEXT = 0;
                                        Allocated := true;
                                    end;
                                    //Brand+Packtype+bussinss<<
                                    //Brand+Packtype+Cust>>
                                    if (BrandNo <> '') and (PackType <> '') and (CustNo <> '') and not Allocated then begin
                                        TotalBrand := 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
                                        SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
                                        SalesBuffer.SETRANGE("Customer No.", CustNo);
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                    TotalBrand += SalesBuffer."Sold Amt"
                                                else
                                                    TotalBrand += SalesBuffer.KMs;
                                            until SalesBuffer.NEXT = 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
                                        SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
                                        SalesBuffer.SETRANGE("Customer No.", CustNo);
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if TotalBrand <> 0 then begin
                                                    if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer."Sold Amt" / TotalBrand
                                                    else
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer.KMs / TotalBrand;
                                                    SalesBuffer.MODIFY;
                                                end;
                                            until SalesBuffer.NEXT = 0;
                                        Allocated := true;
                                    end;
                                    //Brand+Packtype+Cust<<
                                    //Brand+Packtype>>
                                    if (BrandNo <> '') and (PackType <> '') and not Allocated then begin
                                        TotalBrand := 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
                                        SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
                                        //SalesBuffer.SETFILTER("Customer No.",'');
                                        //SalesBuffer.SETFILTER("Dimension Level 4 Value Code",'');
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                    TotalBrand += SalesBuffer."Sold Amt"
                                                else
                                                    TotalBrand += SalesBuffer.KMs;
                                            until SalesBuffer.NEXT = 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
                                        SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
                                        //SalesBuffer.SETFILTER("Customer No.",'');
                                        //SalesBuffer.SETFILTER("Dimension Level 4 Value Code",'');
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if TotalBrand <> 0 then begin
                                                    if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer."Sold Amt" / TotalBrand
                                                    else
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer.KMs / TotalBrand;
                                                    SalesBuffer.MODIFY;
                                                end;
                                            until SalesBuffer.NEXT = 0;
                                        Allocated := true;
                                    end;
                                    //Brand+Packtype<<
                                    //Brand+Bussines>>
                                    if (BrandNo <> '') and (BusinessSegment <> '') and not Allocated then begin
                                        TotalBrand := 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
                                        SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
                                        //SalesBuffer.SETFILTER("Dimension Level 3 Value Code",'');
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                    TotalBrand += SalesBuffer."Sold Amt"
                                                else
                                                    TotalBrand += SalesBuffer.KMs;
                                            until SalesBuffer.NEXT = 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
                                        SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
                                        // SalesBuffer.SETFILTER("Dimension Level 3 Value Code",'');
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if TotalBrand <> 0 then begin
                                                    if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer."Sold Amt" / TotalBrand
                                                    else
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer.KMs / TotalBrand;
                                                    SalesBuffer.MODIFY;
                                                end;
                                            until SalesBuffer.NEXT = 0;
                                        Allocated := true;
                                    end;
                                    //Brand+Bussines<<
                                    //Brand+Cust>>
                                    if (BrandNo <> '') and (CustNo <> '') and not Allocated then begin
                                        CLEAR(SalesBuffer);
                                        TotalBrand := 0;
                                        SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
                                        SalesBuffer.SETRANGE("Customer No.", CustNo);
                                        //SalesBuffer.SETFILTER("Dimension Level 3 Value Code",'');
                                        if SalesBuffer.FINDFIRST then
                                            repeat
                                                if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                    TotalBrand += SalesBuffer."Sold Amt"
                                                else
                                                    TotalBrand += SalesBuffer.KMs;
                                            until SalesBuffer.NEXT = 0;

                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
                                        SalesBuffer.SETRANGE("Customer No.", CustNo);
                                        //SalesBuffer.SETFILTER("Dimension Level 3 Value Code",'');
                                        if SalesBuffer.FINDFIRST then
                                            repeat
                                                if TotalBrand <> 0 then begin
                                                    if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer."Sold Amt" / TotalBrand
                                                    else
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer.KMs / TotalBrand;
                                                    SalesBuffer.MODIFY;
                                                end;
                                            until SalesBuffer.NEXT = 0;
                                        Allocated := true;
                                    end;
                                    //Brand+Cust<<
                                    //LineExt+Packtype+Bussiness>>
                                    if (LineExtNo <> '') and (PackType <> '') and (BusinessSegment <> '') and not Allocated then begin
                                        CLEAR(SalesBuffer);
                                        TotalBrand := 0;
                                        SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
                                        SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
                                        SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
                                        if SalesBuffer.FINDFIRST then
                                            repeat
                                                if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                    TotalBrand += SalesBuffer."Sold Amt"
                                                else
                                                    TotalBrand += SalesBuffer.KMs;
                                            until SalesBuffer.NEXT = 0;

                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
                                        SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
                                        SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
                                        if SalesBuffer.FINDFIRST then
                                            repeat
                                                if TotalBrand <> 0 then begin
                                                    if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer."Sold Amt" / TotalBrand
                                                    else
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer.KMs / TotalBrand;
                                                    SalesBuffer.MODIFY;
                                                end;
                                            until SalesBuffer.NEXT = 0;
                                        Allocated := true;
                                    end;
                                    //LineExt+Packtype+Bussiness<<
                                    //LineExt+PackType+Cust>>
                                    if (LineExtNo <> '') and (PackType <> '') and (CustNo <> '') and not Allocated then begin
                                        CLEAR(SalesBuffer);
                                        TotalBrand := 0;
                                        SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
                                        SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
                                        SalesBuffer.SETRANGE("Customer No.", CustNo);
                                        if SalesBuffer.FINDFIRST then
                                            repeat
                                                if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                    TotalBrand += SalesBuffer."Sold Amt"
                                                else
                                                    TotalBrand += SalesBuffer.KMs;
                                            until SalesBuffer.NEXT = 0;

                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
                                        SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
                                        SalesBuffer.SETRANGE("Customer No.", CustNo);
                                        if SalesBuffer.FINDFIRST then
                                            repeat
                                                if TotalBrand <> 0 then begin
                                                    if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer."Sold Amt" / TotalBrand
                                                    else
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer.KMs / TotalBrand;
                                                    SalesBuffer.MODIFY;
                                                end;
                                            until SalesBuffer.NEXT = 0;
                                        Allocated := true;
                                    end;
                                    //LineExt+PackType+Cust<<
                                    //LineExt+PackType>>
                                    if (LineExtNo <> '') and (PackType <> '') and not Allocated then begin
                                        CLEAR(SalesBuffer);
                                        TotalBrand := 0;
                                        SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
                                        SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
                                        //SalesBuffer.SETFILTER("Customer No.",'');
                                        // SalesBuffer.SETFILTER("Dimension Level 4 Value Code",'');
                                        if SalesBuffer.FINDFIRST then
                                            repeat
                                                if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                    TotalBrand += SalesBuffer."Sold Amt"
                                                else
                                                    TotalBrand += SalesBuffer.KMs;
                                            until SalesBuffer.NEXT = 0;

                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
                                        SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
                                        //  SalesBuffer.SETFILTER("Customer No.",'');
                                        //  SalesBuffer.SETFILTER("Dimension Level 4 Value Code",'');
                                        if SalesBuffer.FINDFIRST then
                                            repeat
                                                if TotalBrand <> 0 then begin
                                                    if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer."Sold Amt" / TotalBrand
                                                    else
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer.KMs / TotalBrand;
                                                    SalesBuffer.MODIFY;
                                                end;
                                            until SalesBuffer.NEXT = 0;
                                        Allocated := true;
                                    end;
                                    //LineExt+PackType<<
                                    //LineExt+Bussiness>>
                                    if (LineExtNo <> '') and (BusinessSegment <> '') and not Allocated then begin
                                        CLEAR(SalesBuffer);
                                        TotalBrand := 0;
                                        SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
                                        SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
                                        //   SalesBuffer.SETFILTER("Dimension Level 3 Value Code",'');
                                        if SalesBuffer.FINDFIRST then
                                            repeat
                                                if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                    TotalBrand += SalesBuffer."Sold Amt"
                                                else
                                                    TotalBrand += SalesBuffer.KMs;
                                            until SalesBuffer.NEXT = 0;

                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
                                        SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
                                        //   SalesBuffer.SETFILTER("Dimension Level 3 Value Code",'');
                                        if SalesBuffer.FINDFIRST then
                                            repeat
                                                if TotalBrand <> 0 then begin
                                                    if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer."Sold Amt" / TotalBrand
                                                    else
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer.KMs / TotalBrand;
                                                    SalesBuffer.MODIFY;
                                                end;
                                            until SalesBuffer.NEXT = 0;
                                        Allocated := true;
                                    end;
                                    //LineExt+Bussiness<<
                                    //LineExt+Cust>>
                                    if (LineExtNo <> '') and (CustNo <> '') and not Allocated then begin
                                        CLEAR(SalesBuffer);
                                        TotalBrand := 0;
                                        SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
                                        SalesBuffer.SETRANGE("Customer No.", CustNo);
                                        //  SalesBuffer.SETFILTER("Dimension Level 3 Value Code",'');
                                        if SalesBuffer.FINDFIRST then
                                            repeat
                                                if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                    TotalBrand += SalesBuffer."Sold Amt"
                                                else
                                                    TotalBrand += SalesBuffer.KMs;
                                            until SalesBuffer.NEXT = 0;

                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
                                        SalesBuffer.SETRANGE("Customer No.", CustNo);
                                        //  SalesBuffer.SETFILTER("Dimension Level 3 Value Code",'');
                                        if SalesBuffer.FINDFIRST then
                                            repeat
                                                if TotalBrand <> 0 then begin
                                                    if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer."Sold Amt" / TotalBrand
                                                    else
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer.KMs / TotalBrand;
                                                    SalesBuffer.MODIFY;
                                                end;
                                            until SalesBuffer.NEXT = 0;
                                        Allocated := true;
                                    end;
                                    //LineExt+Cust<<
                                    //PackType+Bussiness>>
                                    if (PackType <> '') and (BusinessSegment <> '') and not Allocated then begin
                                        CLEAR(SalesBuffer);
                                        TotalBrand := 0;
                                        SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
                                        SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
                                        //   SalesBuffer.SETFILTER("Dimension Level 2 Value Code",'');
                                        if SalesBuffer.FINDFIRST then
                                            repeat
                                                if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                    TotalBrand += SalesBuffer."Sold Amt"
                                                else
                                                    TotalBrand += SalesBuffer.KMs;
                                            until SalesBuffer.NEXT = 0;

                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
                                        SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
                                        //  SalesBuffer.SETFILTER("Dimension Level 2 Value Code",'');
                                        if SalesBuffer.FINDFIRST then
                                            repeat
                                                if TotalBrand <> 0 then begin
                                                    if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer."Sold Amt" / TotalBrand
                                                    else
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer.KMs / TotalBrand;
                                                    SalesBuffer.MODIFY;
                                                end;
                                            until SalesBuffer.NEXT = 0;
                                        Allocated := true;
                                    end;
                                    //PackType+Bussiness<<
                                    //PackType+Cust>>
                                    if (PackType <> '') and (CustNo <> '') and not Allocated then begin
                                        TotalBrand := 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
                                        SalesBuffer.SETRANGE("Customer No.", CustNo);
                                        // SalesBuffer.SETFILTER("Dimension Level 2 Value Code",'');
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                    TotalBrand += SalesBuffer."Sold Amt"
                                                else
                                                    TotalBrand += SalesBuffer.KMs;
                                            until SalesBuffer.NEXT = 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
                                        SalesBuffer.SETRANGE("Customer No.", CustNo);
                                        //  SalesBuffer.SETFILTER("Dimension Level 2 Value Code",'');
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if TotalBrand <> 0 then begin
                                                    if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer."Sold Amt" / TotalBrand
                                                    else
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer.KMs / TotalBrand;
                                                    SalesBuffer.MODIFY;
                                                end;
                                            until SalesBuffer.NEXT = 0;
                                        Allocated := true;
                                    end;
                                    //PackType+Cust<<
                                    //SKU+Cust>>
                                    if (SkuNo <> '') and (CustNo <> '') then begin
                                        TotalBrand := 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Item No.", SkuNo);
                                        SalesBuffer.SETRANGE("Customer No.", CustNo);
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                    TotalBrand += SalesBuffer."Sold Amt"
                                                else
                                                    TotalBrand += SalesBuffer.KMs;
                                            until SalesBuffer.NEXT = 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Item No.", SkuNo);
                                        SalesBuffer.SETRANGE("Customer No.", CustNo);
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if TotalBrand <> 0 then begin
                                                    if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer."Sold Amt" / TotalBrand
                                                    else
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer.KMs / TotalBrand;
                                                    SalesBuffer.MODIFY;
                                                end;
                                            until SalesBuffer.NEXT = 0;
                                        Allocated := true;
                                    end;
                                    //SKU+Cust<<
                                    if SkuNo <> '' then begin
                                        CLEAR(SalesBuffer);
                                    end;

                                    if (CustNo <> '') and not Allocated then begin
                                        TotalBrand := 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Customer No.", CustNo);
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                    TotalBrand += SalesBuffer."Sold Amt"
                                                else
                                                    TotalBrand += SalesBuffer.KMs;
                                            until SalesBuffer.NEXT = 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Customer No.", CustNo);
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if TotalBrand <> 0 then begin
                                                    if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer."Sold Amt" / TotalBrand
                                                    else
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer.KMs / TotalBrand;
                                                    SalesBuffer.MODIFY;
                                                end;
                                            until SalesBuffer.NEXT = 0;
                                        Allocated := true;
                                    end;

                                    if (BrandNo <> '') and not Allocated then begin
                                        TotalBrand := 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                    TotalBrand += SalesBuffer."Sold Amt"
                                                else
                                                    TotalBrand += SalesBuffer.KMs;
                                            until SalesBuffer.NEXT = 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if TotalBrand <> 0 then begin
                                                    if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer."Sold Amt" / TotalBrand
                                                    else
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer.KMs / TotalBrand;
                                                    SalesBuffer.MODIFY;
                                                end;
                                            until SalesBuffer.NEXT = 0;
                                        Allocated := true;
                                    end;

                                    if (LineExtNo <> '') and not Allocated then begin
                                        TotalBrand := 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                    TotalBrand += SalesBuffer."Sold Amt"
                                                else
                                                    TotalBrand += SalesBuffer.KMs;
                                            until SalesBuffer.NEXT = 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if TotalBrand <> 0 then begin
                                                    if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer."Sold Amt" / TotalBrand
                                                    else
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer.KMs / TotalBrand;
                                                    SalesBuffer.MODIFY;
                                                end;
                                            until SalesBuffer.NEXT = 0;
                                        Allocated := true;
                                    end;


                                    //CH>>
                                    if (PackType <> '') and not Allocated then begin
                                        TotalBrand := 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                    TotalBrand += SalesBuffer."Sold Amt"
                                                else
                                                    TotalBrand += SalesBuffer.KMs;
                                            until SalesBuffer.NEXT = 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if TotalBrand <> 0 then begin
                                                    if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer."Sold Amt" / TotalBrand
                                                    else
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer.KMs / TotalBrand;
                                                    SalesBuffer.MODIFY;
                                                end;
                                            until SalesBuffer.NEXT = 0;
                                        Allocated := true;
                                    end;



                                    if (BusinessSegment <> '') and not Allocated then begin
                                        TotalBrand := 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                    TotalBrand += SalesBuffer."Sold Amt"
                                                else
                                                    TotalBrand += SalesBuffer.KMs;
                                            until SalesBuffer.NEXT = 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if TotalBrand <> 0 then begin
                                                    if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer."Sold Amt" / TotalBrand
                                                    else
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer.KMs / TotalBrand;
                                                    SalesBuffer.MODIFY;
                                                end;
                                            until SalesBuffer.NEXT = 0;
                                        Allocated := true;
                                    end;

                                    if (ServiceZone <> '') and not Allocated then begin
                                        TotalBrand := 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 5 Value Code", ServiceZone);
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                    TotalBrand += SalesBuffer."Sold Amt"
                                                else
                                                    TotalBrand += SalesBuffer.KMs;
                                            until SalesBuffer.NEXT = 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 5 Value Code", ServiceZone);
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if TotalBrand <> 0 then begin
                                                    if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer."Sold Amt" / TotalBrand
                                                    else
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer.KMs / TotalBrand;
                                                    SalesBuffer.MODIFY;
                                                end;
                                            until SalesBuffer.NEXT = 0;
                                        Allocated := true;
                                    end;

                                    if (Channel <> '') and not Allocated then begin
                                        TotalBrand := 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 6 Value Code", Channel);
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                    TotalBrand += SalesBuffer."Sold Amt"
                                                else
                                                    TotalBrand += SalesBuffer.KMs;
                                            until SalesBuffer.NEXT = 0;
                                        CLEAR(SalesBuffer);
                                        SalesBuffer.SETRANGE("Dimension Level 6 Value Code", Channel);
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if TotalBrand <> 0 then begin
                                                    if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer."Sold Amt" / TotalBrand
                                                    else
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer.KMs / TotalBrand;
                                                    SalesBuffer.MODIFY;
                                                end;
                                            until SalesBuffer.NEXT = 0;
                                        Allocated := true;
                                    end;
                                    //CH<<




                                    if not Allocated then begin
                                        TotalBrand := 0;
                                        CLEAR(SalesBuffer);
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                    TotalBrand += SalesBuffer."Sold Amt"
                                                else
                                                    TotalBrand += SalesBuffer.KMs;
                                            until SalesBuffer.NEXT = 0;
                                        CLEAR(SalesBuffer);
                                        if SalesBuffer.FINDSET then
                                            repeat
                                                if TotalBrand <> 0 then begin
                                                    if "Cost Type"."Cost Allocation Key FND" = "Cost Type"."Cost Allocation Key FND"::"Quantity(HL)" then
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer."Sold Amt" / TotalBrand
                                                    else
                                                        SalesBuffer.Expenses += GLEntry.Amount * SalesBuffer.KMs / TotalBrand;
                                                    SalesBuffer.MODIFY;
                                                end;
                                            until SalesBuffer.NEXT = 0;
                                        Allocated := true;
                                    end;
                                end;
                            until GLEntry.NEXT = 0;
                    until GLAcc.NEXT = 0;
                CLEAR(SalesBuffer);
                SalesBuffer.SETFILTER(Expenses, '<>%1', 0);
                if SalesBuffer.FINDFIRST then
                    repeat
                        if CostC.GET(SalesBuffer."Customer No.") then begin

                            CLEAR(NewJnlLine);
                            NewJnlLine.SETRANGE("Journal Template Name", CostJournalLine."Journal Template Name");
                            NewJnlLine.SETRANGE("Journal Batch Name", CostJournalLine."Journal Batch Name");
                            LastLineNo := 10000;
                            if NewJnlLine.FINDLAST then
                                LastLineNo := NewJnlLine."Line No." + 10000;
                            CLEAR(NewJnlLine);
                            NewJnlLine.INIT;
                            NewJnlLine."Journal Batch Name" := CostJournalLine."Journal Batch Name";
                            NewJnlLine."Journal Template Name" := CostJournalLine."Journal Template Name";
                            NewJnlLine."Line No." := LastLineNo;
                            NewJnlLine.INSERT(true);
                            NewJnlLine.VALIDATE("Posting Date", PostingDate);
                            NewJnlLine.VALIDATE("Document No.", DocumentNo);
                            NewJnlLine.VALIDATE("Cost Type No.", "No.");
                            NewJnlLine.VALIDATE("Cost Center Code", SalesBuffer."Customer No.");
                            NewJnlLine.VALIDATE("Cost Object Code", SalesBuffer."Item No.");
                            NewJnlLine.VALIDATE(Amount, SalesBuffer.Expenses);
                            NewJnlLine."Brand FND" := SalesBuffer."Dimension Level 1 Value Code";
                            NewJnlLine."Line FND" := SalesBuffer."Dimension Level 2 Value Code";
                            NewJnlLine.MODIFY(true);
                        end;
                    until SalesBuffer.NEXT = 0;
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
                    Caption = 'Options';
                    field(StartingDate; StartingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Starting Date';
                    }
                    field(EndingDate; EndingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Ending Date';
                    }
                    field(DocumentNo; DocumentNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Document No.';
                    }
                    field(PostingDate; PostingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Posting Date';
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

    var
        SalesBuffer: Record "Brand Dim Hierarchy FND" temporary;
        SalesBufferKm: Record "Brand Dim Hierarchy FND" temporary;
        GLSetup: Record "General Ledger Setup";
        TotalHL: Decimal;
        DocNo: Code[20];
        TotalAmount: Decimal;
        DimSetEntry: Record "Dimension Set Entry";
        CostJournalLine: Record "Cost Journal Line";
        StartingDate: Date;
        EndingDate: Date;
        DocumentNo: Code[20];
        PostingDate: Date;
        Customer: Record Customer;
        Text001: Label 'Cost allocation Key for Cost Type %1 must not be blank!';
        NoOfKms: Decimal;
        SalesShipmentDocNo: Code[20];

    procedure SetDocNo(ToCostJournalLine: Record "Cost Journal Line");
    begin
        CostJournalLine := ToCostJournalLine;
    end;
}

