report 54021 "Allocate by SKU V.2"
{
    // version HEI.01

    // HEI.01 CHG2061485 IBM BULIMC01 16/05/2020 #new report created for CA Module
    // HEI.02 CHG2068359 IBM BULIMC01 07/10/2020 #new allocation rule added for Shipping Cost
    // HEI.03 CHG2085522 IBM BULIMC01 25/10/2020 #code adjustment to make the report run via job queue
    // HEI.04 FDD-BPMGAP BRD HB398 IBM NASTAA02 04.06.2019 # Actual Product Costing
    //   # Code adeed to insert new Cost Accounting Journal Lines
    // HEI.05 CHG2112997 IBM BULIMC01 11/06/2021 # Replace Source No from ILE with the value from Value entries
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID- 50415.
    // 2. Add ApplicationArea property in Report and Requestpage fields.
    // 3. REmove Drink-IT Fields and related code ("Quantity in HL", "Invoiced Quantity in HL", "Item Charge Type", "Item Ledger Entry Source Type", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code")
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

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
                ValueEntry: Record "Value Entry";
                DefaultDim: Record "Default Dimension";
            begin
                Counter2 += 1;
                if Counter2 >= NoOfRecProgress2
                then begin
                    NoOfProgresed2 := NoOfProgresed2 + Counter2;
                    Window.UPDATE(5, ROUND(NoOfProgresed2 / NoOfRecords2 * 10000, 1));
                    Counter2 := 0;
                    TimeProgress2 := TIME;
                end;


                //HEI.05<<
                ValueEntry.SETCURRENTKEY("Item Ledger Entry No.");
                ValueEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
                if ValueEntry.FINDFIRST then begin
                    DefaultDim.RESET;
                    if not DefaultDim.GET(DATABASE::Customer, ValueEntry."Source No.", GLSetup."Customer Dimension Code FND") then
                        CurrReport.SKIP;
                    //HEI.05>>
                    BrandDimHierarchy.RESET;
                    BrandDimHierarchy.SETCURRENTKEY("Item No.");
                    BrandDimHierarchy.SETRANGE("Item No.", "Item No.");
                    if not BrandDimHierarchy.FINDFIRST then
                        CurrReport.SKIP;
                    if ("Source Type" = "Source Type"::Customer) and ("Source No." <> '') then begin
                        SalesBuffer.SETCURRENTKEY("Item No.", "Customer No.");
                        SalesBuffer.SETRANGE("Item No.", "Item No.");
                        // SalesBuffer.SETRANGE("Customer No.","Source No."); //HEI.05
                        SalesBuffer.SETRANGE("Customer No.", DefaultDim."Dimension Value Code"); //HEI.05
                        if not SalesBuffer.FINDFIRST then begin
                            SalesBuffer."Item No." := "Item No.";
                            //  SalesBuffer."Customer No." := "Source No."; //HEI.05
                            SalesBuffer."Customer No." := DefaultDim."Dimension Value Code"; //HEI.05
                            // SalesBuffer."Sold Amt" := -"Item Ledger Entry"."Quantity in HL"; // BC Upgrade BHARDA11 ----Drink-IT Field("Quantity in HL")

                            SalesBuffer."Dimension Level 1 Code" := BrandDimHierarchy."Dimension Level 1 Code";
                            SalesBuffer."Dimension Level 1 Value Code" := BrandDimHierarchy."Dimension Level 1 Value Code";
                            SalesBuffer."Dimension Level 2 Code" := BrandDimHierarchy."Dimension Level 2 Code";
                            SalesBuffer."Dimension Level 2 Value Code" := BrandDimHierarchy."Dimension Level 2 Value Code";
                            SalesBuffer."Dimension Level 3 Code" := BrandDimHierarchy."Dimension Level 3 Code";
                            SalesBuffer."Dimension Level 3 Value Code" := BrandDimHierarchy."Dimension Level 3 Value Code";

                            CustomerHierarchy.SETCURRENTKEY("Customer No.");
                            CustomerHierarchy.SETRANGE("Customer No.", SalesBuffer."Customer No.");
                            if not CustomerHierarchy.FINDFIRST then
                                CurrReport.SKIP;
                            SalesBuffer."Dimension Level 4 Code" := CustomerHierarchy."Dimension Level 1 Code";
                            SalesBuffer."Dimension Level 4 Value Code" := CustomerHierarchy."Dimension Level 1 Value Code";
                            SalesBuffer."Dimension Level 5 Code" := CustomerHierarchy."Dimension Level 2 Code";
                            SalesBuffer."Dimension Level 5 Value Code" := CustomerHierarchy."Dimension Level 2 Value Code";
                            SalesBuffer."Dimension Level 6 Code" := CustomerHierarchy."Dimension Level 3 Code";
                            SalesBuffer."Dimension Level 6 Value Code" := CustomerHierarchy."Dimension Level 3 Value Code";

                            SalesBuffer.INSERT;
                        end else begin
                            // BC Upgrade BHARDA11 >> ----Drink-IT Field("Quantity in HL")
                            // SalesBuffer."Sold Amt" += -"Quantity in HL";
                            // SalesBuffer.MODIFY;
                            // BC Upgrade BHARDA11 << ----Drink-IT Field("Quantity in HL")

                        end;
                    end;
                end; //HEI.05
            end;

            trigger OnPostDataItem();
            var
                CostAllocationTarget: Record "Cost Allocation Target";
                LineNo: Integer;
            begin
            end;

            trigger OnPreDataItem();
            begin
                Window.OPEN(Text004 + Text003 + Text006 + Text002 + Text005);
                Window.UPDATE(1, CostJournalLine."Journal Template Name");
                Window.UPDATE(2, CostJournalLine."Journal Batch Name");

                InventorySetup.GET; //HEI.04
                CostAccSetup.GET; //HEI.02
                GLSetup.GET;
                GLSetup.TESTFIELD("SKU Dimension Code FND");
                GLSetup.TESTFIELD("Brand Dimension Code FND");
                GLSetup.TESTFIELD("Customer Dimension Code FND");
                GLSetup.TESTFIELD("Line ext Dimension Code FND");
                SETRANGE("Posting Date", StartingDate, EndingDate);

                NoOfRecords2 := COUNT;
                NoOfRecProgress2 := NoOfRecords2 div 100;
                Counter2 := 0;
                NoOfProgresed2 := 0;
                TimeProgress2 := TIME;
            end;
        }
        dataitem("Cost Type"; "Cost Type")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("Cost Allocation Key FND" = CONST("Quantity(HL)"));
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
                NewJnlLine: Record "Cost Journal Line";
                LastLineNo: BigInteger;
                SkipGL: Boolean;
                CostC: Record "Cost Center";
                CostObject: Record "Cost Object";
                Item: Record Item;
                BrandDimHierarchy: Record "Brand Dim Hierarchy FND";
                // CustomerHierarchy: Record "Customer Hierarchy";
                // BrandDimHierarchy: Record "Brand Dim Hierarchy";
                CustomerHierarchy: Record "Customer Hierarchy FND";
                ActualProductCostStructure: Record "Actual Product Cost Struct DTW";
                ActualProductCostStructure2: Record "Actual Product Cost Struct DTW";
                ValueEntry: Record "Value Entry";
                ValueEntry2: Record "Value Entry";
                CustomerNo: Code[20];
                VolumSoldHL: Decimal;
                ActualCostHL: Decimal;
                CostJournalLine2: Record "Cost Journal Line";
                CostJournalLine3: Record "Cost Journal Line";
                LineNo: Integer;
                DimensionSetID: Integer;
                DimensionSetEntry: Record "Dimension Set Entry";
            begin
                Window.UPDATE(3, "Cost Type"."No.");
                SLEEP(100);
                Counter += 1;
                if Counter >= NoOfRecProgress
                then begin
                    NoOfProgresed := NoOfProgresed + Counter;
                    Window.UPDATE(4, ROUND(NoOfProgresed / NoOfRecords * 10000, 1));
                    Counter := 0;
                    TimeProgress := TIME;
                end;

                if "COGS Var Item Cat Code FND" = '' then //HEI.04
                    if "G/L Account Range" = '' then
                        CurrReport.SKIP;

                if "Dim Filter 1 Value Code FND" <> '' then
                    TESTFIELD("Dimension Filter 1 Code FND");

                if "Dim Filter 2 Value Code FND" <> '' then
                    TESTFIELD("Dimension Filter 2 Code FND");

                if "COGS Var Item Cat Code FND" = '' then begin //HEI.04
                    CLEAR(SalesBuffer);
                    SalesBuffer.MODIFYALL(Expenses, 0);
                    CLEAR(SalesBuffer2);
                    SalesBuffer2.MODIFYALL(Expenses, 0);
                    //HEI.02<<
                    CLEAR(SalesBufferShippCost);
                    SalesBufferShippCost.MODIFYALL(Expenses, 0);
                    //HEI.02>>

                    GLAcc.RESET;//Test
                    GLAcc.SETCURRENTKEY("No.", "Acc Type FND"); //test
                    GLAcc.SETFILTER("No.", "G/L Account Range");
                    GLAcc.SETRANGE("Acc Type FND", GLAcc."Acc Type FND"::Expense);
                    if GLAcc.FINDSET then
                        repeat
                            GLEntry.SETCURRENTKEY("G/L Account No.", "Posting Date");
                            GLEntry.SETRANGE("G/L Account No.", GLAcc."No.");
                            GLEntry.SETRANGE("Posting Date", StartingDate, EndingDate);
                            if GLEntry.FINDFIRST then
                                repeat
                                    SkipGL := false;
                                    if "Dimension Filter 1 Code FND" <> '' then begin
                                        DimSetEntry.RESET;
                                        DimSetEntry.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                                        DimSetEntry.SETRANGE("Dimension Code", "Dimension Filter 1 Code FND");
                                        DimSetEntry.SETFILTER("Dimension Value Code", "Dim Filter 1 Value Code FND");
                                        if not DimSetEntry.FINDFIRST then
                                            SkipGL := true;
                                    end;
                                    if "Dimension Filter 2 Code FND" <> '' then begin
                                        DimSetEntry.RESET; //test
                                        DimSetEntry.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                                        DimSetEntry.SETRANGE("Dimension Code", "Dimension Filter 2 Code FND");
                                        DimSetEntry.SETFILTER("Dimension Value Code", "Dimension Filter 2 Code FND");
                                        if not DimSetEntry.FINDFIRST then
                                            SkipGL := true;
                                    end;

                                    if not SkipGL then begin
                                        Allocated := false;
                                        //HEI.02<<
                                        if "Source Shipping Cost FND" then
                                            AllocateAndInsertShippingCost(GLEntry, "No.");
                                        //HEI.02>>

                                        if not Allocated then
                                            AllocateByDim(GLEntry, GLEntry.Amount);
                                    end;
                                until GLEntry.NEXT = 0;
                        until GLAcc.NEXT = 0;

                    //HEI.04>>
                end else begin
                    if (Type = Type::"Cost Type") and
                       ("G/L Account Range" = '') and
                       ("Cost Allocation Key FND" = "Cost Allocation Key FND"::"Quantity(HL)") and
                       ("Cost Classification" = "Cost Classification"::Variable) and
                       ("COGS Var Item Cat Code FND" <> '')
                    then begin
                        //finished goods in the period
                        ActualProductCostStructure.SETRANGE("Ending Date", StartingDate, EndingDate);
                        ActualProductCostStructure.SETFILTER("Item Category Code", InventorySetup."Finished Goods ItemCatCode FND");
                        if ActualProductCostStructure.FINDSET then
                            repeat
                                ActualCostHL := 0;
                                ActualProductCostStructure2.SETRANGE("Parent Line No.", ActualProductCostStructure."Line No.");
                                ActualProductCostStructure2.SETRANGE("Variable Cost Line", true);
                                if ActualProductCostStructure2.FINDFIRST then
                                    ActualCostHL := ActualProductCostStructure2."Actual Cost HL";

                                ValueEntry.SETRANGE("Posting Date", StartingDate, EndingDate);
                                ValueEntry.SETRANGE("Posting Date", ActualProductCostStructure."Starting Date", ActualProductCostStructure."Ending Date");
                                ValueEntry.SETRANGE("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Sale);
                                ValueEntry.SETFILTER("Document Type", '%1|%2', ValueEntry."Document Type"::"Sales Invoice", ValueEntry."Document Type"::"Sales Credit Memo");
                                ValueEntry.SETRANGE("Item No.", ActualProductCostStructure."Item No.");
                                ValueEntry.SETRANGE("Location Code", ActualProductCostStructure."Location Code");
                                ValueEntry.SETRANGE("Variant Code", ActualProductCostStructure."Variant Code");
                                ValueEntry.SETRANGE("Source Type", ValueEntry."Source Type"::Customer);
                                if ValueEntry.FINDSET then
                                    repeat
                                        //Insert Cost Journal Line per Item, per Customer
                                        CostJournalLine3.RESET;
                                        CostJournalLine3.SETRANGE("Journal Template Name", CostJournalLine."Journal Template Name");
                                        CostJournalLine3.SETRANGE("Journal Batch Name", CostJournalLine."Journal Batch Name");
                                        CostJournalLine3.SETRANGE("Cost Center Code", ValueEntry."Source No.");
                                        CostJournalLine3.SETRANGE("Cost Object Code", ActualProductCostStructure."Item No.");
                                        // CostJournalLine3.SETRANGE("Starting Date",ActualProductCostStructure."Starting Date");
                                        // CostJournalLine3.SETRANGE("Ending Date",ActualProductCostStructure."Ending Date");
                                        if not CostJournalLine3.FINDFIRST then begin
                                            CustomerNo := ValueEntry."Source No.";
                                            VolumSoldHL := 0;
                                            ValueEntry2.COPYFILTERS(ValueEntry);
                                            ValueEntry2.SETRANGE("Source No.", CustomerNo);
                                            // ValueEntry2.SETFILTER("Invoiced Quantity in HL", '<>%1', 0); // BC Upgrade BHARDA11 --Drink-IT Field("Invoiced Quantity in HL")
                                            if ValueEntry2.FINDSET then
                                                repeat
                                                    // VolumSoldHL += ValueEntry2."Invoiced Quantity in HL";  // BC Upgrade BHARDA11 --Drink-IT Field("Invoiced Quantity in HL")
                                                    DimensionSetID := ValueEntry2."Dimension Set ID";
                                                until ValueEntry2.NEXT = 0;

                                            //insert cost journal line
                                            if ABS(VolumSoldHL * ActualCostHL) > 0 then begin
                                                CLEAR(CostJournalLine2);
                                                CostJournalLine2.SETRANGE("Journal Template Name", CostJournalLine."Journal Template Name");
                                                CostJournalLine2.SETRANGE("Journal Batch Name", CostJournalLine."Journal Batch Name");
                                                if CostJournalLine2.FINDLAST then
                                                    LineNo := CostJournalLine2."Line No." + 10000
                                                else
                                                    LineNo := 10000;
                                                CLEAR(CostJournalLine2);
                                                CostJournalLine2.INIT;
                                                CostJournalLine2."Journal Template Name" := CostJournalLine."Journal Template Name";
                                                CostJournalLine2."Journal Batch Name" := CostJournalLine."Journal Batch Name";
                                                CostJournalLine2."Line No." := LineNo;
                                                CostJournalLine2.INSERT(true);
                                                CostJournalLine2.VALIDATE("Posting Date", PostingDate);
                                                //  CostJournalLine2.VALIDATE("Starting Date",ActualProductCostStructure."Starting Date");
                                                //  CostJournalLine2.VALIDATE("Ending Date",ActualProductCostStructure."Ending Date");
                                                CostJournalLine2.VALIDATE("Document No.", DocumentNo);
                                                CostJournalLine2.VALIDATE("Cost Type No.", "No.");
                                                CostJournalLine2.VALIDATE("Cost Center Code", CustomerNo);
                                                CostJournalLine2.VALIDATE("Cost Object Code", ActualProductCostStructure."Item No.");
                                                CostJournalLine2.VALIDATE(Amount, ABS(VolumSoldHL * ActualCostHL));
                                                CostJournalLine2.VALIDATE("Dimension Set ID FND", DimensionSetID);
                                                DimensionSetEntry.SETRANGE("Dimension Set ID", DimensionSetID);
                                                // DimensionSetEntry.SETRANGE("Dimension Code", CostAccSetup."Shortcut Dimension 1 Code"); // BC Upgrade BHARDA11 --Drink-IT Field("Shortcut Dimension 1 Code")
                                                if DimensionSetEntry.FINDFIRST then
                                                    CostJournalLine2.VALIDATE("Brand FND", DimensionSetEntry."Dimension Value Code");
                                                DimensionSetEntry.SETRANGE("Dimension Code");
                                                // DimensionSetEntry.SETRANGE("Dimension Code", CostAccSetup."Shortcut Dimension 2 Code"); // BC Upgrade BHARDA11 --Drink-IT Field("Shortcut Dimension 2 Code")
                                                if DimensionSetEntry.FINDFIRST then
                                                    CostJournalLine2.VALIDATE("Line FND", DimensionSetEntry."Dimension Value Code");
                                                CostJournalLine2.MODIFY(true);
                                            end;
                                        end;
                                    until ValueEntry.NEXT = 0;
                            until ActualProductCostStructure.NEXT = 0;
                    end;
                end;
                //HEI.04<<

                InsertCostJournalEntries(SalesBufferShippCost, "Cost Type"."No."); //HEI.02
                InsertCostJournalEntries(SalesBuffer2, "Cost Type"."No.");
                InsertCostJournalEntries(SalesBuffer, "Cost Type"."No.");
            end;

            trigger OnPostDataItem();
            begin
                Window.CLOSE;
            end;

            trigger OnPreDataItem();
            begin
                NoOfRecords := COUNT;
                NoOfRecProgress := NoOfRecords div 100;
                Counter := 0;
                NoOfProgresed := 0;
                TimeProgress := TIME;
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

    trigger OnPreReport();
    var
        Cust: Record Customer;
        CostCenter: Record "Cost Center";
    begin
        //HEI.03<<
        if StartingDate = 0D then
            StartingDate := CALCDATE('<-CM-1M>', WORKDATE);
        if EndingDate = 0D then
            EndingDate := CALCDATE('<-CM-1D>', WORKDATE);
        if PostingDate = 0D then
            PostingDate := CALCDATE('<-CM-1D>', WORKDATE);
        if DocumentNo = '' then begin
            TextPostingDate := FORMAT(PostingDate);
            DocumentNo := 'CA' + TextPostingDate;
        end;
        //HEI.03>>
    end;

    var
        SalesBuffer: Record "Brand Dim Hierarchy FND" temporary;
        GLSetup: Record "General Ledger Setup";
        TotalHL: Decimal;
        DimSetEntry: Record "Dimension Set Entry";
        CostJournalLine: Record "Cost Journal Line";
        StartingDate: Date;
        EndingDate: Date;
        DocumentNo: Code[20];
        PostingDate: Date;
        Customer: Record Customer;
        Text001: Label 'Cost allocation Key for Cost Type %1 must not be blank!';
        CostType: Record "Cost Type";
        SkipGL: Boolean;
        Allocated: Boolean;
        CostTypeNo: Code[20];
        GlAmount: Decimal;
        GLAccount: Record "G/L Account";
        SkuNo: Code[20];
        CustNo: Code[20];
        LineExtNo: Code[20];
        BrandNo: Code[20];
        Text002: TextConst ENU = 'Checking Cost Type            #3########## \', FRA = 'Traitement des fournisseurs             #1##########';
        Window: Dialog;
        Text003: TextConst ENU = 'Journal Batch Name             #2########## \\', FRA = 'Traitement des fournisseurs             #1##########';
        Text004: TextConst ENU = 'Journal Template Name           #1########## \\', FRA = 'Traitement des fournisseurs             #1##########';
        Text005: Label 'Inserting Cost Journal lines          @4@@@@@@@@@@@ \';
        NoOfRecords: Integer;
        NoOfRecProgress: Integer;
        NoOfProgresed: Integer;
        Counter: Integer;
        TimeProgress: Time;
        NoOfRecords2: Integer;
        NoOfRecProgress2: Integer;
        NoOfProgresed2: Integer;
        Counter2: Integer;
        TimeProgress2: Time;
        Text006: Label 'Checking Item Ledger Entries          @5@@@@@@@@@@@ \';
        NoOfRecords3: Integer;
        NoOfRecProgress3: Integer;
        NoOfProgresed3: Integer;
        Counter3: Integer;
        TimeProgress3: Time;
        ValueEntry: Record "Value Entry";
        GLItemLedgerRelation: Record "G/L - Item Ledger Relation";
        ShippingCost: Boolean;
        CostAccSetup: Record "Cost Accounting Setup";
        SalesBufferShippCost: Record "Brand Dim Hierarchy FND" temporary;
        SalesBuffer2: Record "Brand Dim Hierarchy FND" temporary;
        Text007: Label 'Shipping';
        TextPostingDate: Text;
        PackType: Code[20];
        BusinessSegment: Code[20];
        ServiceZone: Code[20];
        Channel: Code[20];
        ItemNo: Code[20];
        InventorySetup: Record "Inventory Setup";

    procedure SetDocNo(ToCostJournalLine: Record "Cost Journal Line");
    begin
        CostJournalLine := ToCostJournalLine;
    end;

    local procedure InsertCostJournalEntries(var TempSalesBuffer: Record "Brand Dim Hierarchy FND" temporary; CostTypeNo: Code[10]);
    var
        NewJnlLine: Record "Cost Journal Line";
        LastLineNo: BigInteger;
        CostC: Record "Cost Center";
        CostObject: Record "Cost Object";
        Item: Record Item;
        CostJournalBatch: Record "Cost Journal Batch";
        CostJournalTemplate: Record "Cost Journal Template";
    begin
        CLEAR(TempSalesBuffer);
        TempSalesBuffer.SETFILTER(Expenses, '<>%1', 0);
        if TempSalesBuffer.FINDFIRST then
            repeat
                if not CostC.GET(TempSalesBuffer."Customer No.") then begin
                    if Customer.GET(TempSalesBuffer."Customer No.") then begin
                        CostC.VALIDATE(Code, Customer."No.");
                        CostC.VALIDATE(Name, Customer.Name);
                        if CostC.INSERT then;
                    end;
                end;

                if not CostObject.GET(TempSalesBuffer."Item No.") then begin
                    if Item.GET(TempSalesBuffer."Item No.") then begin
                        CostObject.VALIDATE(Code, Item."No.");
                        CostObject.VALIDATE(Name, Item.Description);
                        if CostObject.INSERT then;
                    end;
                end;
                CLEAR(NewJnlLine);

                //HEI.03<<
                if not CostJournalTemplate.GET(CostJournalLine."Journal Template Name") then begin
                    CostJournalTemplate.INIT;
                    CostJournalTemplate.Name := 'CA Module';
                    CostJournalTemplate.Description := 'Cost Accounting Module';
                    if CostJournalTemplate.INSERT then;
                end;

                if not CostJournalBatch.GET(CostJournalLine."Journal Template Name", CostJournalLine."Journal Batch Name") then begin
                    CostJournalBatch."Journal Template Name" := CostJournalTemplate.Name;
                    CostJournalBatch.Name := DocumentNo;
                    CostJournalBatch.Description := 'Allocate by SKU for ' + TextPostingDate;
                    if CostJournalBatch.INSERT then;
                end;
                //HEI.03>>

                //NewJnlLine.SETRANGE("Journal Template Name",CostJournalLine."Journal Template Name"); //HEI.03 commented
                //NewJnlLine.SETRANGE("Journal Batch Name",CostJournalLine."Journal Batch Name");       //HEI.03 commented
                NewJnlLine.SETCURRENTKEY("Journal Template Name", "Journal Batch Name");
                NewJnlLine.SETRANGE("Journal Template Name", CostJournalBatch."Journal Template Name");  //HEI.03
                NewJnlLine.SETRANGE("Journal Batch Name", CostJournalBatch.Name);                        //HEI.03
                LastLineNo := 1;
                if NewJnlLine.FINDLAST then
                    LastLineNo := NewJnlLine."Line No." + 1;
                CLEAR(NewJnlLine);
                NewJnlLine.INIT;
                //NewJnlLine."Journal Template Name" := CostJournalLine."Journal Template Name";    //HEI.03 commented
                //NewJnlLine."Journal Batch Name" := CostJournalLine."Journal Batch Name";          //HEI.03 commented
                NewJnlLine."Journal Batch Name" := CostJournalBatch.Name;                           //HEI.03
                NewJnlLine."Journal Template Name" := CostJournalBatch."Journal Template Name";     //HEI.03
                NewJnlLine."Line No." := LastLineNo;
                // NewJnlLine.INSERT(TRUE);
                NewJnlLine.VALIDATE("Posting Date", PostingDate);
                NewJnlLine.VALIDATE("Document No.", DocumentNo);
                NewJnlLine.VALIDATE("Cost Type No.", CostTypeNo);
                NewJnlLine.VALIDATE("Cost Center Code", TempSalesBuffer."Customer No.");
                NewJnlLine.VALIDATE("Cost Object Code", TempSalesBuffer."Item No.");
                NewJnlLine.VALIDATE(Amount, TempSalesBuffer.Expenses);
                NewJnlLine."Brand FND" := TempSalesBuffer."Dimension Level 1 Value Code";
                NewJnlLine."Line FND" := TempSalesBuffer."Dimension Level 2 Value Code";
                if TempSalesBuffer."New Customer No." = UPPERCASE(Text007) then
                    NewJnlLine."Shipping Cost FND" := true
                else
                    NewJnlLine."Shipping Cost FND" := false;
                NewJnlLine.INSERT(true); //test
            until TempSalesBuffer.NEXT = 0;
    end;

    local procedure AllocateByDim(var GLEntry: Record "G/L Entry"; Amount: Decimal);
    var
        TotalBrand: Decimal;
        NewJnlLine: Record "Cost Journal Line";
        LastLineNo: BigInteger;
        SkipGL: Boolean;
        CostC: Record "Cost Center";
        CostObject: Record "Cost Object";
        Item: Record Item;

        BrandDimHierarchy: Record "Brand Dim Hierarchy FND";
        CustomerHierarchy: Record "Customer Hierarchy FND";

    begin
        SkuNo := '';
        CustNo := '';
        LineExtNo := '';
        BrandNo := '';
        PackType := '';
        BusinessSegment := '';
        ServiceZone := '';
        Channel := '';
        ItemNo := '';

        DimSetEntry.RESET;
        if DimSetEntry.GET(GLEntry."Dimension Set ID", GLSetup."SKU Dimension Code FND") then
            SkuNo := DimSetEntry."Dimension Value Code";

        DimSetEntry.RESET;
        if DimSetEntry.GET(GLEntry."Dimension Set ID", GLSetup."Customer Dimension Code FND") then
            CustNo := DimSetEntry."Dimension Value Code";

        DimSetEntry.RESET;
        if DimSetEntry.GET(GLEntry."Dimension Set ID", GLSetup."Line ext Dimension Code FND") then
            LineExtNo := DimSetEntry."Dimension Value Code";

        DimSetEntry.RESET;
        if DimSetEntry.GET(GLEntry."Dimension Set ID", GLSetup."Brand Dimension Code FND") then
            BrandNo := DimSetEntry."Dimension Value Code";

        DimSetEntry.RESET;
        if DimSetEntry.GET(GLEntry."Dimension Set ID", GLSetup."Primary Pack Type Dim FND") then
            PackType := DimSetEntry."Dimension Value Code";

        DimSetEntry.RESET;
        if DimSetEntry.GET(GLEntry."Dimension Set ID", GLSetup."Business Type Dim Code FND") then
            BusinessSegment := DimSetEntry."Dimension Value Code";

        DimSetEntry.RESET;
        if DimSetEntry.GET(GLEntry."Dimension Set ID", 'SERVICE ZONE') then
            ServiceZone := DimSetEntry."Dimension Value Code";

        DimSetEntry.RESET;
        if DimSetEntry.GET(GLEntry."Dimension Set ID", GLSetup."Shortcut Dimension 4 Code") then
            Channel := DimSetEntry."Dimension Value Code";

        Allocated := false;

        if (SkuNo <> '') and (CustNo <> '') and not Allocated then begin
            SalesBuffer2.SETCURRENTKEY("Item No.", "Customer No.", "Dimension Level 1 Value Code", "Dimension Level 2 Value Code");//Test
            SalesBuffer2.SETRANGE("Item No.", SkuNo);
            SalesBuffer2.SETRANGE("Customer No.", CustNo);
            SalesBuffer2.SETRANGE("Dimension Level 1 Value Code", BrandNo);
            SalesBuffer2.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
            if not SalesBuffer2.FINDFIRST then begin
                CLEAR(SalesBuffer2);
                SalesBuffer2."Item No." := SkuNo;
                SalesBuffer2."Customer No." := CustNo;
                SalesBuffer2."Dimension Level 1 Value Code" := BrandNo;
                SalesBuffer2."Dimension Level 2 Value Code" := LineExtNo;
                SalesBuffer2.Expenses := Amount;
                SalesBuffer2.INSERT;
            end else begin
                SalesBuffer2.Expenses += Amount;
                SalesBuffer2.MODIFY;
            end;
            Allocated := true;
        end;

        if (BrandNo <> '') and (PackType <> '') and (BusinessSegment <> '') and not Allocated then begin
            TotalBrand := 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 1 Value Code", "Dimension Level 3 Value Code", "Dimension Level 4 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
            SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
            SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
            if SalesBuffer.FINDSET then
                repeat
                    TotalBrand += SalesBuffer."Sold Amt";
                until SalesBuffer.NEXT = 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 1 Value Code", "Dimension Level 3 Value Code", "Dimension Level 4 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
            SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
            SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
            if SalesBuffer.FINDSET then
                repeat
                    if TotalBrand <> 0 then begin
                        SalesBuffer.Expenses += Amount * SalesBuffer."Sold Amt" / TotalBrand;
                        ;
                    end;
                until SalesBuffer.NEXT = 0;
            Allocated := true;
        end;

        if (BrandNo <> '') and (PackType <> '') and (CustNo <> '') and not Allocated then begin
            TotalBrand := 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 1 Value Code", "Dimension Level 3 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
            SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
            SalesBuffer.SETRANGE("Customer No.", CustNo);
            if SalesBuffer.FINDSET then
                repeat
                    TotalBrand += SalesBuffer."Sold Amt"
                until SalesBuffer.NEXT = 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 1 Value Code", "Dimension Level 3 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
            SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
            SalesBuffer.SETRANGE("Customer No.", CustNo);
            if SalesBuffer.FINDSET then
                repeat
                    if TotalBrand <> 0 then begin
                        SalesBuffer.Expenses += Amount * SalesBuffer."Sold Amt" / TotalBrand;
                        SalesBuffer.MODIFY;
                    end;
                until SalesBuffer.NEXT = 0;
            Allocated := true;
        end;

        if (BrandNo <> '') and (PackType <> '') and not Allocated then begin
            TotalBrand := 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 1 Value Code", "Dimension Level 3 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
            SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
            if SalesBuffer.FINDSET then
                repeat
                    TotalBrand += SalesBuffer."Sold Amt"
                until SalesBuffer.NEXT = 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 1 Value Code", "Dimension Level 3 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
            SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
            if SalesBuffer.FINDSET then
                repeat
                    if TotalBrand <> 0 then begin
                        SalesBuffer.Expenses += Amount * SalesBuffer."Sold Amt" / TotalBrand;
                        SalesBuffer.MODIFY;
                    end;
                until SalesBuffer.NEXT = 0;
            Allocated := true;
        end;

        if (BrandNo <> '') and (BusinessSegment <> '') and not Allocated then begin
            TotalBrand := 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 1 Value Code", "Dimension Level 4 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
            SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
            if SalesBuffer.FINDSET then
                repeat
                    TotalBrand += SalesBuffer."Sold Amt";
                until SalesBuffer.NEXT = 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 1 Value Code", "Dimension Level 4 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
            SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
            if SalesBuffer.FINDSET then
                repeat
                    if TotalBrand <> 0 then begin
                        SalesBuffer.Expenses += Amount * SalesBuffer."Sold Amt" / TotalBrand;
                        SalesBuffer.MODIFY;
                    end;
                until SalesBuffer.NEXT = 0;
            Allocated := true;
        end;

        if (BrandNo <> '') and (CustNo <> '') and not Allocated then begin
            CLEAR(SalesBuffer);
            TotalBrand := 0;
            SalesBuffer.SETCURRENTKEY("Dimension Level 1 Value Code", "Customer No.");//Test
            SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
            SalesBuffer.SETRANGE("Customer No.", CustNo);
            if SalesBuffer.FINDFIRST then
                repeat
                    TotalBrand += SalesBuffer."Sold Amt";
                until SalesBuffer.NEXT = 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 1 Value Code", "Customer No.");//Test
            SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
            SalesBuffer.SETRANGE("Customer No.", CustNo);
            if SalesBuffer.FINDFIRST then
                repeat
                    if TotalBrand <> 0 then begin
                        SalesBuffer.Expenses += Amount * SalesBuffer."Sold Amt" / TotalBrand;
                        SalesBuffer.MODIFY;
                    end;
                until SalesBuffer.NEXT = 0;
            Allocated := true;
        end;

        if (LineExtNo <> '') and (PackType <> '') and (BusinessSegment <> '') and not Allocated then begin
            CLEAR(SalesBuffer);
            TotalBrand := 0;
            SalesBuffer.SETCURRENTKEY("Dimension Level 2 Value Code", "Dimension Level 3 Value Code", "Dimension Level 4 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
            SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
            SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
            if SalesBuffer.FINDFIRST then
                repeat
                    TotalBrand += SalesBuffer."Sold Amt";
                until SalesBuffer.NEXT = 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 2 Value Code", "Dimension Level 3 Value Code", "Dimension Level 4 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
            SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
            SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
            if SalesBuffer.FINDFIRST then
                repeat
                    if TotalBrand <> 0 then begin
                        SalesBuffer.Expenses += Amount * SalesBuffer."Sold Amt" / TotalBrand;
                        SalesBuffer.MODIFY;
                    end;
                until SalesBuffer.NEXT = 0;
            Allocated := true;
        end;

        if (LineExtNo <> '') and (PackType <> '') and (CustNo <> '') and not Allocated then begin
            CLEAR(SalesBuffer);
            TotalBrand := 0;
            SalesBuffer.SETCURRENTKEY("Dimension Level 2 Value Code", "Dimension Level 3 Value Code", "Customer No.");//Test
            SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
            SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
            SalesBuffer.SETRANGE("Customer No.", CustNo);
            if SalesBuffer.FINDFIRST then
                repeat
                    TotalBrand += SalesBuffer."Sold Amt";
                until SalesBuffer.NEXT = 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 2 Value Code", "Dimension Level 3 Value Code", "Customer No.");//Test
            SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
            SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
            SalesBuffer.SETRANGE("Customer No.", CustNo);
            if SalesBuffer.FINDFIRST then
                repeat
                    if TotalBrand <> 0 then begin
                        SalesBuffer.Expenses += Amount * SalesBuffer."Sold Amt" / TotalBrand;
                        SalesBuffer.MODIFY;
                    end;
                until SalesBuffer.NEXT = 0;
            Allocated := true;
        end;

        if (LineExtNo <> '') and (PackType <> '') and not Allocated then begin
            CLEAR(SalesBuffer);
            TotalBrand := 0;
            SalesBuffer.SETCURRENTKEY("Dimension Level 2 Value Code", "Dimension Level 3 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
            SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
            if SalesBuffer.FINDFIRST then
                repeat
                    TotalBrand += SalesBuffer."Sold Amt";
                until SalesBuffer.NEXT = 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 2 Value Code", "Dimension Level 3 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
            SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
            if SalesBuffer.FINDFIRST then
                repeat
                    if TotalBrand <> 0 then begin
                        SalesBuffer.Expenses += Amount * SalesBuffer."Sold Amt" / TotalBrand;
                        SalesBuffer.MODIFY;
                    end;
                until SalesBuffer.NEXT = 0;
            Allocated := true;
        end;

        if (LineExtNo <> '') and (BusinessSegment <> '') and not Allocated then begin
            CLEAR(SalesBuffer);
            TotalBrand := 0;
            SalesBuffer.SETCURRENTKEY("Dimension Level 2 Value Code", "Dimension Level 4 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
            SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
            if SalesBuffer.FINDFIRST then
                repeat
                    TotalBrand += SalesBuffer."Sold Amt";
                until SalesBuffer.NEXT = 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 2 Value Code", "Dimension Level 4 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
            SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
            if SalesBuffer.FINDFIRST then
                repeat
                    if TotalBrand <> 0 then begin
                        SalesBuffer.Expenses += Amount * SalesBuffer."Sold Amt" / TotalBrand;
                        SalesBuffer.MODIFY;
                    end;
                until SalesBuffer.NEXT = 0;
            Allocated := true;
        end;

        if (LineExtNo <> '') and (CustNo <> '') and not Allocated then begin
            CLEAR(SalesBuffer);
            TotalBrand := 0;
            SalesBuffer.SETCURRENTKEY("Dimension Level 2 Value Code", "Customer No.");//Test
            SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
            SalesBuffer.SETRANGE("Customer No.", CustNo);
            if SalesBuffer.FINDFIRST then
                repeat
                    TotalBrand += SalesBuffer."Sold Amt";
                until SalesBuffer.NEXT = 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 2 Value Code", "Customer No.");//Test
            SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
            SalesBuffer.SETRANGE("Customer No.", CustNo);
            if SalesBuffer.FINDFIRST then
                repeat
                    if TotalBrand <> 0 then begin
                        SalesBuffer.Expenses += Amount * SalesBuffer."Sold Amt" / TotalBrand;
                        SalesBuffer.MODIFY;
                    end;
                until SalesBuffer.NEXT = 0;
            Allocated := true;
        end;

        if (PackType <> '') and (BusinessSegment <> '') and not Allocated then begin
            CLEAR(SalesBuffer);
            TotalBrand := 0;
            SalesBuffer.SETCURRENTKEY("Dimension Level 3 Value Code", "Dimension Level 4 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
            SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
            if SalesBuffer.FINDFIRST then
                repeat
                    TotalBrand += SalesBuffer."Sold Amt"
                until SalesBuffer.NEXT = 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 3 Value Code", "Dimension Level 4 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
            SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
            if SalesBuffer.FINDFIRST then
                repeat
                    if TotalBrand <> 0 then begin
                        SalesBuffer.Expenses += Amount * SalesBuffer."Sold Amt" / TotalBrand;
                        SalesBuffer.MODIFY;
                    end;
                until SalesBuffer.NEXT = 0;
            Allocated := true;
        end;

        if (PackType <> '') and (CustNo <> '') and not Allocated then begin
            TotalBrand := 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 3 Value Code", "Customer No.");//Test
            SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
            SalesBuffer.SETRANGE("Customer No.", CustNo);
            if SalesBuffer.FINDSET then
                repeat
                    TotalBrand += SalesBuffer."Sold Amt";
                until SalesBuffer.NEXT = 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 3 Value Code", "Customer No.");//Test
            SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
            SalesBuffer.SETRANGE("Customer No.", CustNo);
            if SalesBuffer.FINDSET then
                repeat
                    if TotalBrand <> 0 then begin
                        SalesBuffer.Expenses += Amount * SalesBuffer."Sold Amt" / TotalBrand;
                        SalesBuffer.MODIFY;
                    end;
                until SalesBuffer.NEXT = 0;
            Allocated := true;
        end;

        if (CustNo <> '') and not Allocated then begin
            TotalBrand := 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Customer No.");//Test
            SalesBuffer.SETRANGE("Customer No.", CustNo);
            if SalesBuffer.FINDSET then
                repeat
                    TotalBrand += SalesBuffer."Sold Amt";
                until SalesBuffer.NEXT = 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Customer No.");//Test
            SalesBuffer.SETRANGE("Customer No.", CustNo);
            if SalesBuffer.FINDSET then
                repeat
                    if TotalBrand <> 0 then begin
                        SalesBuffer.Expenses += Amount * SalesBuffer."Sold Amt" / TotalBrand;
                        SalesBuffer.MODIFY;
                    end;
                until SalesBuffer.NEXT = 0;
            Allocated := true;
        end;

        if (BrandNo <> '') and not Allocated then begin
            TotalBrand := 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 1 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
            if SalesBuffer.FINDSET then
                repeat
                    TotalBrand += SalesBuffer."Sold Amt";
                until SalesBuffer.NEXT = 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 1 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 1 Value Code", BrandNo);
            if SalesBuffer.FINDSET then
                repeat
                    if TotalBrand <> 0 then begin
                        SalesBuffer.Expenses += Amount * SalesBuffer."Sold Amt" / TotalBrand;
                        SalesBuffer.MODIFY;
                    end;
                until SalesBuffer.NEXT = 0;
            Allocated := true;
        end;

        if (LineExtNo <> '') and not Allocated then begin
            TotalBrand := 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 2 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
            if SalesBuffer.FINDSET then
                repeat
                    TotalBrand += SalesBuffer."Sold Amt";
                until SalesBuffer.NEXT = 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 2 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
            if SalesBuffer.FINDSET then
                repeat
                    if TotalBrand <> 0 then begin
                        SalesBuffer.Expenses += Amount * SalesBuffer."Sold Amt" / TotalBrand;
                        SalesBuffer.MODIFY;
                    end;
                until SalesBuffer.NEXT = 0;
            Allocated := true;
        end;

        if (PackType <> '') and not Allocated then begin
            TotalBrand := 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 3 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
            if SalesBuffer.FINDSET then
                repeat
                    TotalBrand += SalesBuffer."Sold Amt";
                until SalesBuffer.NEXT = 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 3 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 3 Value Code", PackType);
            if SalesBuffer.FINDSET then
                repeat
                    if TotalBrand <> 0 then begin
                        SalesBuffer.Expenses += Amount * SalesBuffer."Sold Amt" / TotalBrand;
                        SalesBuffer.MODIFY;
                    end;
                until SalesBuffer.NEXT = 0;
            Allocated := true;
        end;

        if (BusinessSegment <> '') and not Allocated then begin
            TotalBrand := 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 4 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
            if SalesBuffer.FINDSET then
                repeat
                    TotalBrand += SalesBuffer."Sold Amt";
                until SalesBuffer.NEXT = 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 4 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 4 Value Code", BusinessSegment);
            if SalesBuffer.FINDSET then
                repeat
                    if TotalBrand <> 0 then begin
                        SalesBuffer.Expenses += Amount * SalesBuffer."Sold Amt" / TotalBrand;
                        SalesBuffer.MODIFY;
                    end;
                until SalesBuffer.NEXT = 0;
            Allocated := true;
        end;

        if (ServiceZone <> '') and not Allocated then begin
            TotalBrand := 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 5 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 5 Value Code", ServiceZone);
            if SalesBuffer.FINDSET then
                repeat
                    TotalBrand += SalesBuffer."Sold Amt";
                until SalesBuffer.NEXT = 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 5 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 5 Value Code", ServiceZone);
            if SalesBuffer.FINDSET then
                repeat
                    if TotalBrand <> 0 then begin
                        SalesBuffer.Expenses += Amount * SalesBuffer."Sold Amt" / TotalBrand;
                        SalesBuffer.MODIFY;
                    end;
                until SalesBuffer.NEXT = 0;
            Allocated := true;
        end;

        if (Channel <> '') and not Allocated then begin
            TotalBrand := 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 6 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 6 Value Code", Channel);
            if SalesBuffer.FINDSET then
                repeat
                    TotalBrand += SalesBuffer."Sold Amt";
                until SalesBuffer.NEXT = 0;
            CLEAR(SalesBuffer);
            SalesBuffer.SETCURRENTKEY("Dimension Level 6 Value Code");//Test
            SalesBuffer.SETRANGE("Dimension Level 6 Value Code", Channel);
            if SalesBuffer.FINDSET then
                repeat
                    if TotalBrand <> 0 then begin
                        SalesBuffer.Expenses += Amount * SalesBuffer."Sold Amt" / TotalBrand;
                        SalesBuffer.MODIFY;
                    end;
                until SalesBuffer.NEXT = 0;
            Allocated := true;
        end;

        if not Allocated then begin
            TotalBrand := 0;
            CLEAR(SalesBuffer);
            if SalesBuffer.FINDSET then
                repeat
                    TotalBrand += SalesBuffer."Sold Amt";
                until SalesBuffer.NEXT = 0;
            CLEAR(SalesBuffer);
            if SalesBuffer.FINDSET then
                repeat
                    if TotalBrand <> 0 then begin
                        SalesBuffer.Expenses += Amount * SalesBuffer."Sold Amt" / TotalBrand;
                        SalesBuffer.MODIFY;
                    end;
                until SalesBuffer.NEXT = 0;
            Allocated := true;
        end;
    end;

    local procedure AllocateAndInsertShippingCost(var GLEntry: Record "G/L Entry"; CostTypeNo: Code[10]);
    var
        BrandDimHierarchy: Record "Brand Dim Hierarchy FND";
        // CustomerHierarchy: Record "Customer Hierarchy";
        // BrandDimHierarchy: Record "Brand Dim Hierarchy";
        CustomerHierarchy: Record "Customer Hierarchy FND";
        ShippAmt: Decimal;
    begin
        //HEI.02<<
        ShippAmt := 0;
        GLItemLedgerRelation.RESET;
        GLItemLedgerRelation.SETCURRENTKEY("G/L Entry No.");
        GLItemLedgerRelation.SETRANGE("G/L Entry No.", GLEntry."Entry No.");
        if GLItemLedgerRelation.FINDSET then
            repeat
                Allocated := false;
                ValueEntry.RESET;
                // ValueEntry.SETCURRENTKEY("Entry No.", "Item Charge Type", "Item Ledger Entry Source Type"); // BC Upgrade BHARDA11 --Drink-IT Fields("Item Charge Type", "Item Ledger Entry Source Type")
                ValueEntry.SETCURRENTKEY("Entry No.");
                ValueEntry.SETRANGE("Entry No.", GLItemLedgerRelation."Value Entry No.");
                // BC Upgrade BHARDA11 >>--Drink-IT Fields("Item Charge Type", "Item Ledger Entry Source Type")
                // ValueEntry.SETRANGE("Item Charge Type", ValueEntry."Item Charge Type"::ShippingCost);
                // ValueEntry.SETRANGE("Item Ledger Entry Source Type", ValueEntry."Item Ledger Entry Source Type"::Customer);
                // BC Upgrade BHARDA11 <<--Drink-IT Fields("Item Charge Type", "Item Ledger Entry Source Type")
                if ValueEntry.FINDFIRST then begin
                    SkuNo := '';
                    CustNo := '';
                    LineExtNo := '';
                    BrandNo := '';

                    DimSetEntry.RESET;
                    if DimSetEntry.GET(ValueEntry."Dimension Set ID", CostAccSetup."Cost Object Dimension") then
                        SkuNo := DimSetEntry."Dimension Value Code";

                    DimSetEntry.RESET;
                    if DimSetEntry.GET(ValueEntry."Dimension Set ID", CostAccSetup."Cost Center Dimension") then
                        CustNo := DimSetEntry."Dimension Value Code";

                    DimSetEntry.RESET;
                    if DimSetEntry.GET(ValueEntry."Dimension Set ID", GLSetup."Line ext Dimension Code FND") then
                        LineExtNo := DimSetEntry."Dimension Value Code";

                    DimSetEntry.RESET;
                    if DimSetEntry.GET(ValueEntry."Dimension Set ID", GLSetup."Brand Dimension Code FND") then
                        BrandNo := DimSetEntry."Dimension Value Code";

                    BrandDimHierarchy.RESET;
                    BrandDimHierarchy.SETCURRENTKEY("Item No.");
                    BrandDimHierarchy.SETRANGE("Item No.", SkuNo);
                    if BrandDimHierarchy.FINDFIRST then begin
                        CustomerHierarchy.RESET;
                        CustomerHierarchy.SETCURRENTKEY("Customer No.");
                        CustomerHierarchy.SETRANGE("Customer No.", CustNo);
                        if CustomerHierarchy.FINDFIRST then begin
                            SalesBufferShippCost.SETCURRENTKEY("Item No.", "Customer No.", "Dimension Level 1 Value Code", "Dimension Level 2 Value Code");//TEST
                            SalesBufferShippCost.SETRANGE("Item No.", SkuNo);
                            SalesBufferShippCost.SETRANGE("Customer No.", CustNo);
                            SalesBufferShippCost.SETRANGE("Dimension Level 1 Value Code", BrandNo);
                            SalesBufferShippCost.SETRANGE("Dimension Level 2 Value Code", LineExtNo);
                            if not SalesBufferShippCost.FINDFIRST then begin
                                CLEAR(SalesBufferShippCost);
                                SalesBufferShippCost."Item No." := SkuNo;
                                SalesBufferShippCost."Customer No." := CustNo;
                                SalesBufferShippCost."Dimension Level 1 Value Code" := BrandNo;
                                SalesBufferShippCost."Dimension Level 2 Value Code" := LineExtNo;
                                SalesBufferShippCost.Expenses := -ValueEntry."Purchase Amount (Actual)";
                                SalesBufferShippCost."New Customer No." := UPPERCASE(Text007);
                                SalesBufferShippCost.INSERT;
                            end else begin
                                SalesBufferShippCost.Expenses += -ValueEntry."Purchase Amount (Actual)";
                                SalesBufferShippCost.MODIFY;
                            end;
                            Allocated := true;
                            ShippAmt += -ValueEntry."Purchase Amount (Actual)";
                        end;
                    end;

                end;
            until GLItemLedgerRelation.NEXT = 0;

        if ShippAmt <> 0 then
            AllocateByDim(GLEntry, (GLEntry.Amount - ShippAmt));

        //HEI.02>>
    end;
}

