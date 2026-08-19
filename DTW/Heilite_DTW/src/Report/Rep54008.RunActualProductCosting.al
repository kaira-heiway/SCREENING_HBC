report 54008 "Run Actual Product Costing"
{
    // version HEI.01

    // HEI.01 FDD-BPMGAP BRD HB398 IBM NASTAA02 19.04.2019 # Actual Product Costing
    //   # New Report created to insert Actual Product Costs
    // HEI.02 FDD-BPMGAP BRD HB398 IBM BULIMC01 22.01.2020 # Actual Product Costing
    //   # adjustments for fields 'Type' and 'Description'
    // BC Upgrade BHARDA11 >>
    // 1. Remove Drink-IT Fields and Related code("Production BOM No.","Production BOM Version Code","Unit Volume HL")
    // 2. Add ApplicationArea property in Report and Actions fields.
    // 3. Old Report ID is 50250
    // BC Upgrade BHARAD11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Run Actual Product Costing';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Stockkeeping Unit"; "Stockkeeping Unit")
        {
            DataItemTableView = SORTING("Item No.", "Location Code", "Variant Code")
                                ORDER(Ascending);
            RequestFilterFields = "Item No.", "Location Code";

            trigger OnAfterGetRecord();
            var
                Item: Record 27;
                Item2: Record 27;
                ItemLedgerEntry: Record 32;
                ActualProductCost: Record "Actual Product Cost DTW";
                ProductType: Option "Raw and Packaging Material Cost","Semi-Finished Goods Cost","Finished Goods Cost";
            begin
                //If Cost Account doesn't exist search all ILE's
                ActualProductCost.RESET();
                ItemLedgerEntry.RESET();
                FirstCalculation := FALSE;
                AccPeriodStartDate := StartingDate;

                ActualProductCost.SETRANGE("Item No.", "Item No.");
                ActualProductCost.SETRANGE("Location Code", "Location Code");
                IF NOT ActualProductCost.FINDFIRST() THEN BEGIN
                    FirstCalculation := TRUE;
                    ItemLedgerEntry.SETCURRENTKEY("Item No.", "Posting Date");
                    ItemLedgerEntry.SETRANGE("Item No.", "Item No.");
                    ItemLedgerEntry.SETRANGE("Location Code", "Location Code");
                    //ItemLedgerEntry.SETRANGE("Posting Date",AccPeriodStartDate,AccPeriodEndDate);
                    IF ItemLedgerEntry.FINDFIRST THEN
                        IF ItemLedgerEntry."Posting Date" <= StartingDate THEN
                            AccPeriodStartDate := ItemLedgerEntry."Posting Date"
                        ELSE
                            AccPeriodStartDate := AccPeriodEndDate;
                END;

                Item.SETRANGE("No.", "Item No.");
                Item.SETRANGE("Costing Method", InventorySetup."Costing Method FND");
                IF Item.FINDFIRST THEN BEGIN
                    //Insert Raw and Packing Materials Cost
                    Item2.SETRANGE("No.", Item."No.");
                    Item2.SETFILTER("Item Category Code", InventorySetup."Raw Pack Mat Item Cat Code FND");
                    IF Item2.FINDFIRST THEN
                        InsertActualProductCost(Item2, ProductType::"Raw and Packaging Material Cost");

                    //Insert semi-finished Goods Cost
                    Item2.SETRANGE("Item Category Code");
                    Item2.SETFILTER("Item Category Code", InventorySetup."SemiFinish ProdItemCatCode FND");
                    IF Item2.FINDFIRST THEN
                        InsertActualProductCost(Item2, ProductType::"Semi-Finished Goods Cost");

                    //Insert Finished Goods cost
                    Item2.SETRANGE("Item Category Code");
                    Item2.SETFILTER("Item Category Code", InventorySetup."Finished Goods ItemCatCode FND");
                    IF Item2.FINDFIRST THEN
                        InsertActualProductCost(Item2, ProductType::"Finished Goods Cost");
                END;

                //Progress dialog bar
                Counter += 1;
                IF (Counter >= NoOfRecProgress) //OR
                                                //(TIME - TimeProgress > 1000)
                THEN BEGIN
                    NoOfProgresed := NoOfProgresed + Counter;
                    DialogProgress.UPDATE(1, ROUND(NoOfProgresed / NoOfRecords * 10000, 1));
                    DialogProgress.UPDATE(2, ROUND(NoOfProgresed2 / NoOfRecords2 * 10000, 1));
                    DialogProgress.UPDATE(3, ROUND(NoOfProgresed3 / NoOfRecords3 * 10000, 1));
                    Counter := 0;
                    TimeProgress := TIME;
                END;
            end;

            trigger OnPreDataItem();
            var
                ActualProductCost: Record "Actual Product Cost DTW";
                ActualProductCost2: Record "Actual Product Cost DTW";
                ValueEntry: Record 5802;
            begin
                InventorySetup.GET;
                InventorySetup.TESTFIELD("Raw Pack Mat Item Cat Code FND");
                InventorySetup.TESTFIELD("SemiFinish ProdItemCatCode FND");
                InventorySetup.TESTFIELD("Finished Goods ItemCatCode FND");
                InventorySetup.TESTFIELD("Costing Method FND");
                InventorySetup.TESTFIELD("Planning Unit of Measure FND");

                StartingDate := AccPeriodStartDate;

                NoOfRecords := COUNT;
                NoOfRecProgress := NoOfRecords DIV 100;
                Counter := 0;
                NoOfProgresed := 0;
                TimeProgress := TIME;
                NoOfRecords2 := COUNT;
                NoOfRecProgress2 := NoOfRecords2 DIV 100;
                Counter2 := 0;
                NoOfProgresed2 := 0;
                TimeProgress2 := TIME;
                NoOfRecords3 := COUNT;
                NoOfRecProgress3 := NoOfRecords2 DIV 100;
                Counter3 := 0;
                NoOfProgresed3 := 0;
                TimeProgress3 := TIME;

                DialogProgress.OPEN(ProgressLine1Msg + ProgressLine2Msg + ProgressLine3Msg);

                ActualProductCost.SETFILTER("Ending Date", '>=%1', AccPeriodEndDate);
                IF ActualProductCost.FINDFIRST THEN
                    ERROR(ActualCostCalculatedErr);

                FirstRun := NOT ActualProductCost2.FINDFIRST;
                //HEI.02<<
                ValueEntry.SETFILTER("Posting Date", '<=%1', WorkDate());
                ValueEntry.SETFILTER("Cost Amount (Purchase) FND", '<>%1', 0);
                IF NOT ValueEntry.FINDFIRST AND FirstRun THEN
                    REPORT.RUN(50321, FALSE, FALSE);
                //HEI.02>>
            end;
        }
        dataitem("Actual Product Cost DTW"; "Actual Product Cost DTW")
        {
            DataItemTableView = SORTING("Item No.", "Location Code", "Starting Date", "Ending Date")
                                ORDER(Ascending)
                                WHERE(Archived = FILTER(false),
                                      "Product Type" = FILTER("Semi-Finished Goods Cost" | "Finished Goods Cost"),
                                      "Is on Tree" = FILTER(false));

            trigger OnAfterGetRecord();
            begin
                GenerateTree("Actual Product Cost DTW");
                "Is on Tree" := TRUE;
                MODIFY;

                //Progress dialog bar
                Counter2 += 1;
                IF (Counter2 >= NoOfRecProgress2) //OR
                                                  //(TIME - TimeProgress > 1000)
                THEN BEGIN
                    NoOfProgresed2 := NoOfProgresed2 + Counter2;
                    DialogProgress.UPDATE(1, ROUND(NoOfProgresed / NoOfRecords * 10000, 1));
                    DialogProgress.UPDATE(2, ROUND(NoOfProgresed2 / NoOfRecords2 * 10000, 1));
                    DialogProgress.UPDATE(3, ROUND(NoOfProgresed3 / NoOfRecords2 * 10000, 1));
                    Counter2 := 0;
                    TimeProgress2 := TIME;
                END;
            end;
        }
        dataitem("Actual Product Cost Struct DTW"; "Actual Product Cost Struct DTW")
        {
            DataItemTableView = SORTING("Line No.")
                                ORDER(Ascending)
                                WHERE("Is Parent" = FILTER(true),
                                      "Variable Cost Line" = FILTER(false),
                                      "Capacity Cost Line" = FILTER(false));

            trigger OnAfterGetRecord();
            var
                ActualProductCostStructure: Record "Actual Product Cost Struct DTW";
                ActualProductCostStructure2: Record "Actual Product Cost Struct DTW";
            begin
                ActualProductCostStructure.SETRANGE("Parent Line No.", "Actual Product Cost Struct DTW"."Line No.");
                ActualProductCostStructure.SETRANGE("Variable Cost Line", FALSE);
                ActualProductCostStructure.SETRANGE("Capacity Cost Line", FALSE);
                IF ActualProductCostStructure.FINDSET THEN BEGIN
                    REPEAT
                        CalculateTotalVariableCost2(ActualProductCostStructure);
                    UNTIL ActualProductCostStructure.NEXT = 0;

                    ActualProductCostStructure2.SETRANGE("Parent Line No.", "Actual Product Cost Struct DTW"."Line No.");
                    ActualProductCostStructure2.SETRANGE("Variable Cost Line", TRUE);
                    IF ActualProductCostStructure2.FINDFIRST THEN
                        ModifyTotalVariableCost(ActualProductCostStructure2."Line No.");
                    ClearValues;
                END;
            end;
        }
        dataitem(ActualProductCost2; "Actual Product Cost DTW")
        {
            DataItemTableView = SORTING("Item No.", "Location Code", "Starting Date", "Ending Date")
                                ORDER(Ascending)
                                WHERE(Archived = FILTER(false),
                                      "Product Type" = FILTER("Semi-Finished Goods Cost" | "Finished Goods Cost"));

            trigger OnAfterGetRecord();
            var
                ActualProductCostStructure: Record "Actual Product Cost Struct DTW";
                ActualProductCostStructure2: Record "Actual Product Cost Struct DTW";
                OperationSign: Option "*","/","+","-";
            begin
                ActualProductCostStructure.SETRANGE("Item No.", "Item No.");
                ActualProductCostStructure.SETRANGE("Location Code", "Location Code");
                ActualProductCostStructure.SETRANGE("Starting Date", "Starting Date");
                ActualProductCostStructure.SETRANGE("Ending Date", "Ending Date");
                ActualProductCostStructure.SETRANGE("Is Parent", TRUE);
                IF ActualProductCostStructure.FINDFIRST THEN BEGIN
                    ActualProductCostStructure2.GET(ActualProductCostStructure."Line No.");
                    IF ActualProductCost2."Standard Consumption" <> 0 THEN
                        "Total Expected Cost" := ActualProductCostStructure."Total Expected Cost";

                    IF "Product Type" <> "Product Type"::"Raw and Packaging Material Cost" THEN BEGIN
                        "Consumption Variance" := CheckMinMaxAllowedValue("Total Expected Cost", "Total Actual Cost", OperationSign::"-");
                        "Price Variance" := CheckMinMaxAllowedValue("Total Std Cost", "Total Expected Cost", OperationSign::"-");
                        ActualProductCostStructure2."Consumption Variance" := "Consumption Variance";
                        ActualProductCostStructure2."Price Variance" := "Price Variance";

                        IF "Total Actual Quantity" <> 0 THEN
                            "Exp Cost BUoM" := CheckMinMaxAllowedValue("Total Expected Cost", "Total Actual Quantity", OperationSign::"/");
                        IF "Total Actual Qty in HL" <> 0 THEN
                            "Exp Cost HL" := CheckMinMaxAllowedValue("Total Expected Cost", "Total Actual Qty in HL", OperationSign::"/");
                        ActualProductCostStructure2."Exp Cost BUoM" := "Exp Cost BUoM";
                        ActualProductCostStructure2."Exp Cost HL" := "Exp Cost HL";
                    END;

                    IF "Product Type" = "Product Type"::"Finished Goods Cost" THEN
                        IF "Total Actual Qty in PUM" <> 0 THEN
                            "Exp Cost PUM" := CheckMinMaxAllowedValue("Total Expected Cost", "Total Actual Qty in PUM", OperationSign::"/");
                    ActualProductCostStructure2."Exp Cost PUM" := "Exp Cost PUM";
                    ActualProductCostStructure2.MODIFY;
                    MODIFY;
                END;

                //Progress dialog bar
                Counter3 += 1;
                IF (Counter3 >= NoOfRecProgress3) //OR
                                                  //(TIME - TimeProgress3 > 1000)
                THEN BEGIN
                    NoOfProgresed3 := NoOfProgresed3 + Counter3;
                    DialogProgress.UPDATE(1, ROUND(NoOfProgresed / NoOfRecords * 10000, 1));
                    DialogProgress.UPDATE(2, ROUND(NoOfProgresed2 / NoOfRecords2 * 10000, 1));
                    DialogProgress.UPDATE(3, ROUND(NoOfProgresed3 / NoOfRecords2 * 10000, 1));
                    Counter3 := 0;
                    TimeProgress3 := TIME;
                END;
            end;

            trigger OnPostDataItem();
            begin
                DialogProgress.CLOSE;
            end;
        }
    }

    requestpage
    {
        Caption = 'Run Actual Product Costing';
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(PostingDate; PostingDate)
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date';

                    trigger OnValidate();
                    begin
                        IF PostingDate <> 0D THEN BEGIN
                            AccountingPeriod.SETRANGE("Starting Date", CALCDATE('<-CM>', PostingDate));
                            IF AccountingPeriod.FINDFIRST THEN BEGIN
                                AccPeriodStartDate := AccountingPeriod."Starting Date";
                                AccPeriodEndDate := CALCDATE('<CM>', PostingDate);
                            END;
                        END;
                    end;
                }
                field(AccountingPeriodStartDate; AccPeriodStartDate)
                {
                    ApplicationArea = All;
                    Caption = 'Accounting Period Starting Date';
                    Editable = false;
                }
                field(AccountingPeriodEndDate; AccPeriodEndDate)
                {
                    ApplicationArea = All;
                    Caption = 'Accounting Period Ending Date';
                    Editable = false;
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            PostingDate := TODAY;
            AccountingPeriod.SETRANGE("Starting Date", CALCDATE('<-CM>', PostingDate));
            IF AccountingPeriod.FINDFIRST THEN BEGIN
                AccPeriodStartDate := AccountingPeriod."Starting Date";
                AccPeriodEndDate := CALCDATE('<CM>', PostingDate);
            END;
        end;
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        MESSAGE(ActualCostCalculatedMsg, InsertedLines);
    end;

    var
        InventorySetup: Record 313;
        AccountingPeriod: Record 50;
        PostingDate: Date;
        AccPeriodStartDate: Date;
        AccPeriodEndDate: Date;
        ActualCostCalculatedMsg: Label 'Actual Cost has been calculated. %1 lines have been inserted.';
        FirstCalculation: Boolean;
        InsertedLines: Integer;
        NoOfRecords: Integer;
        NoOfRecProgress: Integer;
        NoOfProgresed: Integer;
        Counter: Integer;
        TimeProgress: Time;
        StartingDate: Date;
        PrevPeriod_TotalActCost: Decimal;
        PrevPeriod_ActCostBUoM: Decimal;
        TotalActCost: Decimal;
        TotalExpCost: Decimal;
        TotalStdCost: Decimal;
        TotalVariance: Decimal;
        PriceVariance: Decimal;
        ConsumptVariance: Decimal;
        ActCostBUoM: Decimal;
        ActCostPUM: Decimal;
        ActCostHL: Decimal;
        ExpCostBUoM: Decimal;
        ExpCostPUM: Decimal;
        ExpCostHL: Decimal;
        StdCostBUoM: Decimal;
        StdCostPUM: Decimal;
        StdCostHL: Decimal;
        PeriodActCost: Decimal;
        ParentExpectedCost: Decimal;
        IsParentLine: Boolean;
        DialogProgress: Dialog;
        ProgressLine1Msg: Label 'Calculating Actual Product Cost Lines: @1@@@@@@@@@@@ \';
        ProgressLine2Msg: Label 'Calculating Actual Product Cost Structure Lines: @2@@@@@@@@@@@ \';
        ProgressLine3Msg: Label 'Calculating Total Variable Cost Lines: @3@@@@@@@@@@@';
        NoOfRecords2: Integer;
        NoOfRecProgress2: Integer;
        NoOfProgresed2: Integer;
        Counter2: Integer;
        TimeProgress2: Time;
        NoOfRecords3: Integer;
        NoOfRecProgress3: Integer;
        NoOfProgresed3: Integer;
        Counter3: Integer;
        TimeProgress3: Time;
        ActualCostCalculatedErr: Label 'Actual Cost has been calculated for this period!';
        FirstRun: Boolean;
        Calc_PostingDate: Date;
        Calc_EntryType: Option Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        Calc_DocType: Option " ","Sales Shipment","Sales Invoice","Sales Return Receipt","Sales Credit Memo","Purchase Receipt","Purchase Invoice","Purchase Return Shipment","Purchase Credit Memo","Transfer Shipment","Transfer Receipt","Service Shipment","Service Invoice","Service Credit Memo","Posted Assembly",,,,,"Service Receipt","Service P.Invoice","Service P.Credit Memo";
        Calc_DocNo: Code[20];
        Calc_ItemNo: Code[20];
        Calc_Description: Text;
        Calc_NewDescription: Text;
        Calc_Type: Option " ",Item,"Source Item";
        Calc_LocationCode: Code[10];
        Calc_Quantity: Decimal;
        Calc_ItemCategoryCode: Code[10];
        Calc_ILENo: Integer;
        Calc_OrderType: Option " ",Production,Transfer,Service,Assembly;
        Calc_OrderType_VE: Option " ",Production,Transfer,Service,Assembly;
        Calc_ILEType_VE: Option Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        Calc_EntryType_VE: Option "Direct Cost",Revaluation,Rounding,"Indirect Cost",Variance;
        Calc_SourceType_VE: Option " ",Customer,Vendor,Item;
        Calc_SourceNo_VE: Code[20];
        Calc_CostAmtActual_VE: Decimal;
        Calc_CostAmtPurchase_VE: Decimal;
        Calc_RelatedValueEntryNo_VE: Integer;
        Calc_StdCost: Decimal;
        Calc_PrevActualCost: Decimal;
        Calc_ValuedQuantity_VE: Decimal;
        Calc_CapacityLedgEntryNo_VE: Integer;
        Calc_ILEQuantity: Decimal;
        Sum_Negatives: Decimal;
        Sum_Transfers: Decimal;
        Sum_Positives: Decimal;
        Sum_Purchases: Decimal;
        Sum_PONonCosumpt: Decimal;
        Sum_POConsumpt: Decimal;
        Sum_ILE_Quantity: Decimal;
        PeriodActualQuantity: Decimal;
        TotalActualQuantity: Decimal;
        Sum_ActualCostAmt: Decimal;
        Calc_ItemSourceNo: Code[20];

    local procedure InsertActualProductCost(Item2: Record 27; ProductType: Option "Raw and Packaging Material Cost","Semi-Finished Goods Cost","Finished Goods Cost");
    var
        ActualProductCost: Record "Actual Product Cost DTW";
        SKU: Record 5700;
        Item: Record 27;
    begin
        ActualProductCost.INIT;
        ActualProductCost."Item No." := "Stockkeeping Unit"."Item No.";
        ActualProductCost."Location Code" := "Stockkeeping Unit"."Location Code";
        ActualProductCost."Starting Date" := AccPeriodStartDate;
        ActualProductCost."Ending Date" := AccPeriodEndDate;
        ActualProductCost.INSERT(TRUE);
        InsertedLines += 1;

        ActualProductCost."Item Category Code" := Item2."Item Category Code";
        ActualProductCost."Product Type" := ProductType;
        ActualProductCost."Variant Code" := "Stockkeeping Unit"."Variant Code";
        ActualProductCost."Base Unit of Measure" := Item2."Base Unit of Measure";
        IF "Stockkeeping Unit"."Standard Cost" <> 0 THEN
            ActualProductCost."Std Cost BUoM" := "Stockkeeping Unit"."Standard Cost"
        ELSE
            IF Item.GET("Stockkeeping Unit"."Item No.") THEN
                ActualProductCost."Std Cost BUoM" := Item."Standard Cost";

        ActualProductCost.MODIFY(TRUE);
        CalculateActualProductCost(ActualProductCost."Item No.", ActualProductCost."Location Code", ActualProductCost."Starting Date", ActualProductCost."Ending Date", FALSE, 0);
    end;

    local procedure FilterItemLedgerEntries(var ItemLedgerEntry: Record 32; StartDate: Date): Boolean;
    var
        Item2: Record 27;
    begin
        Item2.GET("Stockkeeping Unit"."Item No.");
        ItemLedgerEntry.SETRANGE("Item No.", Item2."No.");
        ItemLedgerEntry.SETRANGE("Location Code", "Stockkeeping Unit"."Location Code");
        ItemLedgerEntry.SETRANGE("Posting Date", StartDate, AccPeriodEndDate);
        EXIT(ItemLedgerEntry.FINDFIRST);
    end;

    local procedure FindPreviousPeriod(ItemNo: Code[20]; LocationCode: Code[10]);
    var
        ActualProductCost: Record "Actual Product Cost DTW";
    begin
        ActualProductCost.SETRANGE("Item No.", ItemNo);
        ActualProductCost.SETRANGE("Location Code", LocationCode);
        ActualProductCost.SETFILTER("Ending Date", '<%1', StartingDate);
        IF ActualProductCost.FINDLAST THEN BEGIN
            PrevPeriod_TotalActCost := ActualProductCost."Total Actual Cost";
            PrevPeriod_ActCostBUoM := ActualProductCost."Actual Cost BUoM";
        END;
    end;

    local procedure FindStructPreviousPeriod(ItemNo: Code[20]; LocationCode: Code[10]; ParentLineNo: Integer; var PrevTotalActQty: Decimal; var PrevPeriodActQty: Decimal; var PrevTotalActCost: Decimal; var PrevPeriodActCost: Decimal): Boolean;
    var
        ActualProductCostStructure: Record "Actual Product Cost Struct DTW";
        ActualProductCostStructure2: Record "Actual Product Cost Struct DTW";
        ActualProductCostStructure3: Record "Actual Product Cost Struct DTW";
    begin
        ActualProductCostStructure2.GET(ParentLineNo);

        ActualProductCostStructure.SETRANGE("Item No.", ItemNo);
        ActualProductCostStructure.SETRANGE("Location Code", LocationCode);
        ActualProductCostStructure.SETRANGE("Parent Item No.", ActualProductCostStructure2."Item No.");
        ActualProductCostStructure.SETFILTER("Ending Date", '<%1', StartingDate);
        IF ActualProductCostStructure.FINDLAST THEN BEGIN
            PrevTotalActQty := ActualProductCostStructure."Total Actual Quantity";
            PrevPeriodActQty := ActualProductCostStructure."Period Actual Quantity";
            PrevTotalActCost := ActualProductCostStructure."Total Actual Cost";
            PrevPeriodActCost := ActualProductCostStructure."Period Actual Cost";
            EXIT(TRUE);
        END;
    end;

    local procedure GetPUQtyPerUoM(ItemNo: Code[20]): Decimal;
    var
        ItemUnitOfMeasure: Record 5404;
    begin
        ItemUnitOfMeasure.SETRANGE("Item No.", ItemNo);
        ItemUnitOfMeasure.SETRANGE(Code, InventorySetup."Planning Unit of Measure FND");
        IF ItemUnitOfMeasure.FINDFIRST THEN
            EXIT(ItemUnitOfMeasure."Qty. per Unit of Measure")
        ELSE
            EXIT(0);
    end;

    local procedure GetQuantityPerUoM(ItemNo: Code[20]; UoM: Code[10]): Decimal;
    var
        ItemUnitOfMeasure: Record 5404;
    begin
        ItemUnitOfMeasure.SETRANGE("Item No.", ItemNo);
        ItemUnitOfMeasure.SETRANGE(Code, UoM);
        IF ItemUnitOfMeasure.FINDFIRST THEN
            EXIT(ItemUnitOfMeasure."Qty. per Unit of Measure")
        ELSE
            EXIT(0);
    end;

    local procedure CalculateActQuantity(StartDate: Date): Decimal;
    var
        ItemLedgerEntry: Record 32;
    begin
        FilterItemLedgerEntries(ItemLedgerEntry, StartDate);
        ItemLedgerEntry.CALCSUMS(Quantity);
        EXIT(ItemLedgerEntry.Quantity);
    end;

    local procedure CalculateActualCost(ProductType: Option "Raw and Packaging Material Cost","Semi-Finished Goods Cost","Finished Goods Cost"; TotalActCostPreviousPeriod: Decimal; ActualCostPreviousPeriod: Decimal; ProdOrderFilter: Text; ParentItemNo: Code[20]; ItemNo: Code[20]; LocationCode: Code[10]; IsNotChild: Boolean; var TotalActualCost: Decimal; var PeriodActualCost: Decimal; StandardCostSKU: Decimal);
    var
        TotalActCostPositiveEntries: Decimal;
        TotalActCostNegativeEntries: Decimal;
        OperationSign: Option "*","/","+","-";
        CalculationType: Option " ","Negatives ILE","Transfers ILE","Positives VE","Purchases VE","Production Orders Not Consumption VE","Production Orders Conspumtion VE";
    begin
        //Total Actual Cost := Total Actual Cost Previous Period + Total Actual Cost for Positive Entries - Total Actual Cost for Negative Entries
        TotalActCostNegativeEntries := 0;
        TotalActCostPositiveEntries := 0;

        TotalActCostNegativeEntries := CheckMinMaxAllowedValue(ActualCostPreviousPeriod, ABS(CalcNegativeEntries_ILE(ProdOrderFilter, ItemNo, LocationCode, StandardCostSKU, ActualCostPreviousPeriod)), OperationSign::"*");

        IF (ProductType = ProductType::"Raw and Packaging Material Cost") AND IsNotChild THEN
            TotalActCostPositiveEntries := CheckMinMaxAllowedValue( //++
                                           CheckMinMaxAllowedValue(
                                           CheckMinMaxAllowedValue(ActualCostPreviousPeriod, CalcPositiveTransfers_ILE(ProdOrderFilter, ItemNo, LocationCode, TRUE, StandardCostSKU, ActualCostPreviousPeriod), OperationSign::"*"),
                                           CheckMinMaxAllowedValue(CalcCostAmtActOtherPositives_VE(ItemNo, LocationCode, StandardCostSKU, ActualCostPreviousPeriod),
                                                                   CalcCostAmtPurchase_VE(ItemNo, LocationCode, StandardCostSKU, ActualCostPreviousPeriod), OperationSign::"+"), OperationSign::"+"),
                                           CheckMinMaxAllowedValue(CalcProdOrdersExclConsumption_VE(ParentItemNo, LocationCode, StandardCostSKU, ActualCostPreviousPeriod, ProductType),
                                                                   CalcProdOrdersConsumption_VE(ParentItemNo, ItemNo, LocationCode, StandardCostSKU, ActualCostPreviousPeriod, ProductType), OperationSign::"+"), OperationSign::"+")
        ELSE
            TotalActCostPositiveEntries := CheckMinMaxAllowedValue(
                                           CheckMinMaxAllowedValue(ActualCostPreviousPeriod, CalcPositiveTransfers_ILE(ProdOrderFilter, ItemNo, LocationCode, FALSE, StandardCostSKU, ActualCostPreviousPeriod), OperationSign::"*"),
                                           CheckMinMaxAllowedValue(CalcProdOrdersExclConsumption_VE(ParentItemNo, LocationCode, StandardCostSKU, ActualCostPreviousPeriod, ProductType),
                                                                   CalcProdOrdersConsumption_VE(ParentItemNo, ItemNo, LocationCode, StandardCostSKU, ActualCostPreviousPeriod, ProductType), OperationSign::"+"), OperationSign::"+");

        TotalActualCost := CheckMinMaxAllowedValue(CheckMinMaxAllowedValue(TotalActCostPreviousPeriod, TotalActCostPositiveEntries, OperationSign::"+"), ABS(TotalActCostNegativeEntries), OperationSign::"-");
        PeriodActualCost := CheckMinMaxAllowedValue(TotalActCostPositiveEntries, ABS(TotalActCostNegativeEntries), OperationSign::"-");

        InsertCalculatedActualProductCost(ItemNo, LocationCode, CalculationType::" ", PeriodActualCost, TRUE, FALSE, FALSE);
        InsertCalculatedActualProductCost(ItemNo, LocationCode, CalculationType::" ", TotalActualCost, FALSE, TRUE, FALSE);
    end;

    local procedure CalcNegativeEntries_ILE(ProdOrderFilter: Text; ItemNo: Code[20]; LocationCode: Code[10]; StandardCostSKU: Decimal; PrevActualCost: Decimal): Decimal;
    var
        Item: Record 27;
        ItemLedgerEntry: Record 32;
        CapacityLedgerEntry: Record 5832;
        TotalAccCostNegatives: Decimal;
        CalculationType: Option " ","Negatives ILE","Transfers ILE","Positives VE","Purchases VE","Production Orders Not Consumption VE","Production Orders Conspumtion VE";
        OperationSign: Option "*","/","+","-";
    begin
        TotalAccCostNegatives := 0;
        Sum_Negatives := 0;
        Sum_ILE_Quantity := 0;

        IF ProdOrderFilter = '' THEN BEGIN
            ItemLedgerEntry.SETRANGE("Item No.", ItemNo);
            ItemLedgerEntry.SETRANGE("Location Code", LocationCode);
            IF FirstRun THEN
                ItemLedgerEntry.SETRANGE("Posting Date", 0D, AccPeriodEndDate)
            ELSE
                ItemLedgerEntry.SETRANGE("Posting Date", AccPeriodStartDate, AccPeriodEndDate);
            ItemLedgerEntry.SETFILTER(Quantity, '<%1', 0);
            IF ItemLedgerEntry.FINDSET THEN
                REPEAT
                    TotalAccCostNegatives += ItemLedgerEntry.Quantity;
                    Sum_ILE_Quantity += ItemLedgerEntry.Quantity;

                    //insert Actual Product Cost Calculation
                    ClearValues2;
                    Item.GET(ItemNo);
                    Calc_PostingDate := ItemLedgerEntry."Posting Date";
                    Calc_EntryType := ItemLedgerEntry."Entry Type".AsInteger();
                    Calc_DocType := ItemLedgerEntry."Document Type".AsInteger();
                    Calc_DocNo := ItemLedgerEntry."Document No.";
                    Calc_Description := ItemLedgerEntry.Description;
                    //HEI.02<<
                    Calc_NewDescription := Item.Description;
                    Calc_Type := Calc_Type::Item;
                    //Calc_ItemSourceNo := ItemLedgerEntry."Source No.";
                    //HEI.02>>

                    Calc_Quantity := ItemLedgerEntry.Quantity;
                    Calc_ILENo := ItemLedgerEntry."Entry No.";
                    Calc_OrderType := ItemLedgerEntry."Order Type".AsInteger();
                    Calc_ItemNo := ItemNo;
                    Calc_LocationCode := LocationCode;
                    Calc_StdCost := StandardCostSKU;
                    Calc_PrevActualCost := PrevActualCost;
                    Calc_ItemCategoryCode := Item."Item Category Code";

                    InsertActualProductCostCalculation(CalculationType::"Negatives ILE");
                UNTIL ItemLedgerEntry.NEXT = 0;
        END ELSE BEGIN
            CapacityLedgerEntry.SETRANGE(Type, CapacityLedgerEntry.Type::"Work Center");
            CapacityLedgerEntry.SETRANGE("Posting Date", AccPeriodStartDate, AccPeriodEndDate);
            CapacityLedgerEntry.SETRANGE("Order Type", CapacityLedgerEntry."Order Type");
            CapacityLedgerEntry.SETFILTER("Order No.", ProdOrderFilter);
            CapacityLedgerEntry.SETFILTER(Quantity, '<%1', 0);
            IF CapacityLedgerEntry.FINDSET THEN
                REPEAT
                    TotalAccCostNegatives += CapacityLedgerEntry.Quantity;
                UNTIL CapacityLedgerEntry.NEXT = 0;
        END;

        //IF TotalAccCostNegatives <> 0 THEN
        InsertCalculatedActualProductCost(ItemNo, LocationCode, CalculationType::"Negatives ILE",
          -ABS(CheckMinMaxAllowedValue(PrevActualCost, TotalAccCostNegatives, OperationSign::"*")), TRUE, FALSE, FALSE);

        Sum_Negatives := TotalAccCostNegatives;

        EXIT(TotalAccCostNegatives);
    end;

    local procedure CalcPositiveTransfers_ILE(ProdOrderFilter: Text; ItemNo: Code[20]; LocationCode: Code[10]; IsRawMaterial: Boolean; StandardCostSKU: Decimal; PrevActualCost: Decimal): Decimal;
    var
        Item: Record 27;
        ItemLedgerEntry: Record 32;
        CapacityLedgerEntry: Record 5832;
        TotalAccCostPositives: Decimal;
        CalculationType: Option " ","Negatives ILE","Transfers ILE","Positives VE","Purchases VE","Production Orders Not Consumption VE","Production Orders Conspumtion VE";
        OperationSign: Option "*","/","+","-";
    begin
        TotalAccCostPositives := 0;
        Sum_Transfers := 0;
        Sum_ILE_Quantity := 0;

        IF ProdOrderFilter = '' THEN BEGIN
            ItemLedgerEntry.SETRANGE("Item No.", ItemNo);
            ItemLedgerEntry.SETRANGE("Location Code", LocationCode);
            IF FirstRun THEN
                ItemLedgerEntry.SETRANGE("Posting Date", 0D, AccPeriodEndDate)
            ELSE
                ItemLedgerEntry.SETRANGE("Posting Date", AccPeriodStartDate, AccPeriodEndDate);
            IF IsRawMaterial THEN
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Transfer)
            ELSE
                ItemLedgerEntry.SETFILTER("Order Type", '<>%1', ItemLedgerEntry."Order Type"::Production);
            ItemLedgerEntry.SETFILTER(Quantity, '>%1', 0);
            IF ItemLedgerEntry.FINDSET THEN
                REPEAT
                    TotalAccCostPositives += ItemLedgerEntry.Quantity;
                    Sum_ILE_Quantity += ItemLedgerEntry.Quantity;

                    //insert Actual Product Cost Calculation
                    ClearValues2;
                    Item.GET(ItemNo);
                    Calc_PostingDate := ItemLedgerEntry."Posting Date";
                    Calc_EntryType := ItemLedgerEntry."Entry Type".AsInteger();
                    Calc_DocType := ItemLedgerEntry."Document Type".AsInteger();
                    Calc_DocNo := ItemLedgerEntry."Document No.";
                    Calc_Description := ItemLedgerEntry.Description;
                    //HEI.02<<
                    Calc_NewDescription := Item.Description;
                    Calc_Type := Calc_Type::Item;
                    //Calc_ItemSourceNo := ItemLedgerEntry."Source No.";
                    //HEI.02>>
                    Calc_Quantity := ItemLedgerEntry.Quantity;
                    Calc_ILENo := ItemLedgerEntry."Entry No.";
                    Calc_OrderType := ItemLedgerEntry."Order Type".AsInteger();
                    Calc_ItemNo := ItemNo;
                    Calc_LocationCode := LocationCode;
                    Calc_StdCost := StandardCostSKU;
                    Calc_PrevActualCost := PrevActualCost;
                    Calc_ItemCategoryCode := Item."Item Category Code";

                    InsertActualProductCostCalculation(CalculationType::"Transfers ILE");
                UNTIL ItemLedgerEntry.NEXT = 0;
        END ELSE BEGIN
            CapacityLedgerEntry.SETRANGE(Type, CapacityLedgerEntry.Type::"Work Center");
            CapacityLedgerEntry.SETRANGE("Posting Date", AccPeriodStartDate, AccPeriodEndDate);
            CapacityLedgerEntry.SETRANGE("Order Type", CapacityLedgerEntry."Order Type");
            CapacityLedgerEntry.SETFILTER("Order No.", ProdOrderFilter);
            CapacityLedgerEntry.SETFILTER(Quantity, '>%1', 0);
            IF CapacityLedgerEntry.FINDSET THEN
                REPEAT
                    TotalAccCostPositives += CapacityLedgerEntry.Quantity;
                UNTIL CapacityLedgerEntry.NEXT = 0;
        END;

        //IF TotalAccCostPositives <> 0 THEN
        IF IsRawMaterial THEN
            InsertCalculatedActualProductCost(ItemNo, LocationCode, CalculationType::"Transfers ILE",
              CheckMinMaxAllowedValue(PrevActualCost, TotalAccCostPositives, OperationSign::"*"), TRUE, FALSE, FALSE)
        ELSE
            InsertCalculatedActualProductCost(ItemNo, LocationCode, CalculationType::"Transfers ILE",
              CheckMinMaxAllowedValue(PrevActualCost, TotalAccCostPositives, OperationSign::"*"), TRUE, FALSE, TRUE);

        Sum_Transfers := TotalAccCostPositives;

        EXIT(TotalAccCostPositives);
    end;

    local procedure CalcCostAmtActOtherPositives_VE(ItemNo: Code[20]; LocationCode: Code[10]; StandardCostSKU: Decimal; PrevActualCost: Decimal): Decimal;
    var
        Item: Record 27;
        ItemLedgerEntry: Record 32;
        ValueEntry: Record 5802;
        TotalAccCostPositives: Decimal;
        CalculationType: Option " ","Negatives ILE","Transfers ILE","Positives VE","Purchases VE","Production Orders Not Consumption VE","Production Orders Conspumtion VE";
    begin
        TotalAccCostPositives := 0;
        Sum_Positives := 0;
        Sum_ILE_Quantity := 0;

        ValueEntry.SETRANGE("Item No.", ItemNo);
        ValueEntry.SETRANGE("Location Code", LocationCode);
        IF FirstRun THEN
            ValueEntry.SETRANGE("Posting Date", 0D, AccPeriodEndDate)
        ELSE
            ValueEntry.SETRANGE("Posting Date", AccPeriodStartDate, AccPeriodEndDate);
        ValueEntry.SETFILTER("Entry Type", '<>%1&<>%2', ValueEntry."Entry Type"::Revaluation, ValueEntry."Entry Type"::Variance);
        //ValueEntry.SETFILTER("Item Ledger Entry Type",'<>%1',ValueEntry."Item Ledger Entry Type"::Transfer);
        ValueEntry.SETFILTER("Order Type", '<>%1&<>%2', ValueEntry."Order Type"::Transfer, ValueEntry."Order Type"::Production);
        ValueEntry.SETFILTER("Item Ledger Entry Type", '<>%1', ValueEntry."Item Ledger Entry Type"::Transfer);
        ValueEntry.SETFILTER("Valued Quantity", '>%1', 0);
        IF ValueEntry.FINDSET THEN
            REPEAT
                TotalAccCostPositives += ValueEntry."Cost Amount (Actual)";
                //Sum_ILE_Quantity += ValueEntry."Valued Quantity";
                Sum_ILE_Quantity += ValueEntry."Item Ledger Entry Quantity";

                //insert Actual Product Cost Calculation
                ClearValues2;
                Item.GET(ItemNo);
                IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN BEGIN
                    Calc_PostingDate := ItemLedgerEntry."Posting Date";
                    Calc_EntryType := ItemLedgerEntry."Entry Type".AsInteger();
                    Calc_DocType := ItemLedgerEntry."Document Type".AsInteger();
                    Calc_DocNo := ItemLedgerEntry."Document No.";
                    Calc_Description := ItemLedgerEntry.Description;
                    //HEI.02<<
                    Calc_NewDescription := Item.Description;
                    Calc_Type := Calc_Type::Item;
                    // Calc_ItemSourceNo := ValueEntry."Item No.";
                    //HEI.02>>
                    Calc_ILENo := ItemLedgerEntry."Entry No.";
                    Calc_OrderType := ItemLedgerEntry."Order Type".AsInteger();
                END;
                Calc_ItemNo := ItemNo;
                Calc_LocationCode := LocationCode;
                Calc_StdCost := StandardCostSKU;
                Calc_PrevActualCost := PrevActualCost;
                Calc_ItemCategoryCode := Item."Item Category Code";
                Calc_OrderType_VE := ValueEntry."Order Type".AsInteger();
                Calc_ILEType_VE := ValueEntry."Item Ledger Entry Type".AsInteger();
                Calc_EntryType_VE := ValueEntry."Entry Type".AsInteger();
                Calc_SourceType_VE := ValueEntry."Source Type".AsInteger();
                Calc_SourceNo_VE := ValueEntry."Source No.";
                Calc_Quantity := ValueEntry."Item Ledger Entry Quantity";
                Calc_CostAmtActual_VE := ValueEntry."Cost Amount (Actual)";
                Calc_CostAmtPurchase_VE := ValueEntry."Cost Amount (Purchase) FND";
                Calc_RelatedValueEntryNo_VE := ValueEntry."Entry No.";
                Calc_ValuedQuantity_VE := ValueEntry."Valued Quantity";
                Calc_CapacityLedgEntryNo_VE := ValueEntry."Capacity Ledger Entry No.";
                Calc_ILEQuantity := ValueEntry."Valued Quantity";

                InsertActualProductCostCalculation(CalculationType::"Positives VE");
            UNTIL ValueEntry.NEXT = 0;

        //IF TotalAccCostPositives <> 0 THEN
        InsertCalculatedActualProductCost(ItemNo, LocationCode, CalculationType::"Positives VE", TotalAccCostPositives, FALSE, FALSE, FALSE);

        Sum_Positives := TotalAccCostPositives;

        EXIT(TotalAccCostPositives);
    end;

    local procedure CalcCostAmtPurchase_VE(ItemNo: Code[20]; LocationCode: Code[10]; StandardCostSKU: Decimal; PrevActualCost: Decimal): Decimal;
    var
        Item: Record 27;
        ItemLedgerEntry: Record 32;
        ValueEntry: Record 5802;
        TotalAccCostPurchase: Decimal;
        CalculationType: Option " ","Negatives ILE","Transfers ILE","Positives VE","Purchases VE","Production Orders Not Consumption VE","Production Orders Conspumtion VE";
    begin
        TotalAccCostPurchase := 0;
        Sum_Purchases := 0;
        Sum_ILE_Quantity := 0;

        ValueEntry.SETRANGE("Item No.", ItemNo);
        ValueEntry.SETRANGE("Location Code", LocationCode);
        IF FirstRun THEN
            ValueEntry.SETRANGE("Posting Date", 0D, AccPeriodEndDate)
        ELSE
            ValueEntry.SETRANGE("Posting Date", AccPeriodStartDate, AccPeriodEndDate);
        ValueEntry.SETFILTER("Entry Type", '<>%1&<>%2', ValueEntry."Entry Type"::Revaluation, ValueEntry."Entry Type"::Variance);
        //ValueEntry.SETFILTER("Item Ledger Entry Type",'<>%1',ValueEntry."Item Ledger Entry Type"::Transfer);
        ValueEntry.SETFILTER("Order Type", '<>%1&<>%2', ValueEntry."Order Type"::Transfer, ValueEntry."Order Type"::Production);
        ValueEntry.SETFILTER("Item Ledger Entry Type", '<>%1', ValueEntry."Item Ledger Entry Type"::Transfer); //060120
        ValueEntry.SETFILTER("Valued Quantity", '>%1', 0);
        IF ValueEntry.FINDSET THEN
            REPEAT
                TotalAccCostPurchase += ValueEntry."Cost Amount (Purchase) FND";
            //Sum_ILE_Quantity += ValueEntry."Valued Quantity";
            UNTIL ValueEntry.NEXT = 0;

        //IF TotalAccCostPurchase <> 0 THEN
        InsertCalculatedActualProductCost(ItemNo, LocationCode, CalculationType::"Purchases VE", TotalAccCostPurchase, FALSE, FALSE, FALSE);

        Sum_Purchases := TotalAccCostPurchase;

        EXIT(TotalAccCostPurchase);
    end;

    local procedure CalcProdOrdersExclConsumption_VE(ParentItemNo: Code[20]; LocationCode: Code[10]; StandardCostSKU: Decimal; PrevActualCost: Decimal; ProductType: Option "Raw and Packaging Material Cost","Semi-Finished Goods Cost","Finished Goods Cost"): Decimal;
    var
        Item: Record 27;
        ItemLedgerEntry: Record 32;
        ItemLedgerEntry2: Record 32;
        ItemLedgerEntry3: Record 32;
        ValueEntry: Record 5802;
        ValueEntry2: Record 5802;
        ProductionOrder: Record 5405;
        CalculationType: Option " ","Negatives ILE","Transfers ILE","Positives VE","Purchases VE","Production Orders Not Consumption VE","Production Orders Conspumtion VE";
        TotalAccCostPositives: Decimal;
        SameLocationCode: Boolean;
    begin
        TotalAccCostPositives := 0;
        Sum_PONonCosumpt := 0;
        Sum_ILE_Quantity := 0;

        IF FirstRun THEN
            ValueEntry.SETRANGE("Posting Date", 0D, AccPeriodEndDate)
        ELSE
            ValueEntry.SETRANGE("Posting Date", AccPeriodStartDate, AccPeriodEndDate);
        ValueEntry.SETRANGE("Order Type", ValueEntry."Order Type"::Production);
        ValueEntry.SETRANGE("Source Type", ValueEntry."Source Type"::Item);
        ValueEntry.SETRANGE("Source No.", ParentItemNo);
        ValueEntry.SETFILTER("Item Ledger Entry Type", '<>%1', ValueEntry."Item Ledger Entry Type"::Consumption);
        IF ProductType <> ProductType::"Raw and Packaging Material Cost" THEN
            ValueEntry.SETFILTER("Capacity Ledger Entry No.", '<>%1', 0);
        IF ProductType = ProductType::"Raw and Packaging Material Cost" THEN
            ValueEntry.SETFILTER("Valued Quantity", '>%1', 0); // 07/01/20 check just for R&P

        IF ValueEntry.FINDSET THEN
            REPEAT
                SameLocationCode := FALSE;
                ProductionOrder.RESET;
                ProductionOrder.SETRANGE("No.", ValueEntry."Document No.");
                IF ProductionOrder.FINDFIRST THEN
                    IF LocationCode = ProductionOrder."Location Code" THEN
                        SameLocationCode := TRUE;
                IF NOT SameLocationCode THEN BEGIN
                    ItemLedgerEntry2.RESET;
                    ItemLedgerEntry2.SETRANGE("Document No.", ValueEntry."Document No.");
                    ItemLedgerEntry2.SETRANGE("Posting Date", ValueEntry."Posting Date");
                    IF ItemLedgerEntry2.FINDFIRST THEN
                        IF LocationCode = ItemLedgerEntry2."Location Code" THEN
                            SameLocationCode := TRUE;
                END;

                IF SameLocationCode THEN BEGIN
                    TotalAccCostPositives += ValueEntry."Cost Amount (Actual)";

                    //insert Actual Product Cost Calculation
                    ClearValues2;
                    Item.GET(ParentItemNo);
                    IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN BEGIN
                        Calc_PostingDate := ItemLedgerEntry."Posting Date";
                        Calc_EntryType := ItemLedgerEntry."Entry Type".AsInteger();
                        Calc_DocType := ItemLedgerEntry."Document Type".AsInteger();
                        Calc_DocNo := ItemLedgerEntry."Document No.";
                        Calc_Description := ItemLedgerEntry.Description;
                        Calc_ILENo := ItemLedgerEntry."Entry No.";
                        Calc_OrderType := ItemLedgerEntry."Order Type".AsInteger();
                    END ELSE BEGIN
                        ItemLedgerEntry2.RESET;
                        ItemLedgerEntry2.SETRANGE("Document No.", ValueEntry."Document No.");
                        ItemLedgerEntry2.SETRANGE("Posting Date", ValueEntry."Posting Date");
                        IF ItemLedgerEntry2.FINDFIRST THEN BEGIN
                            Calc_PostingDate := ItemLedgerEntry2."Posting Date";
                            Calc_EntryType := ItemLedgerEntry2."Entry Type".AsInteger();
                            Calc_DocType := ItemLedgerEntry2."Document Type".AsInteger();
                            Calc_DocNo := ItemLedgerEntry2."Document No.";
                            Calc_Description := ItemLedgerEntry2.Description;
                            Calc_ILENo := ItemLedgerEntry2."Entry No.";
                            Calc_OrderType := ItemLedgerEntry2."Order Type".AsInteger();
                        END;
                    END;

                    Calc_ItemNo := ParentItemNo;
                    Calc_LocationCode := LocationCode;
                    Calc_StdCost := StandardCostSKU;
                    Calc_PrevActualCost := PrevActualCost;
                    Calc_ItemCategoryCode := Item."Item Category Code";
                    Calc_OrderType_VE := ValueEntry."Order Type".AsInteger();
                    Calc_ILEType_VE := ValueEntry."Item Ledger Entry Type".AsInteger();
                    Calc_EntryType_VE := ValueEntry."Entry Type".AsInteger();
                    Calc_SourceType_VE := ValueEntry."Source Type".AsInteger();
                    Calc_SourceNo_VE := ValueEntry."Source No.";
                    Calc_CostAmtActual_VE := ValueEntry."Cost Amount (Actual)";
                    Calc_CostAmtPurchase_VE := ValueEntry."Cost Amount (Purchase) FND";
                    Calc_RelatedValueEntryNo_VE := ValueEntry."Entry No.";
                    Calc_ValuedQuantity_VE := ValueEntry."Valued Quantity";
                    Calc_CapacityLedgEntryNo_VE := ValueEntry."Capacity Ledger Entry No.";
                    Calc_ILEQuantity := ValueEntry."Valued Quantity";
                    //HEI.02<<
                    Calc_NewDescription := Item.Description;
                    Calc_Type := Calc_Type::"Source Item";
                    Calc_ItemSourceNo := ValueEntry."Item No.";
                    //HEI.02>>

                    InsertActualProductCostCalculation(CalculationType::"Production Orders Not Consumption VE");
                END;
            UNTIL ValueEntry.NEXT = 0;

        ItemLedgerEntry3.RESET;
        ItemLedgerEntry3.SETRANGE("Location Code", LocationCode);
        IF FirstRun THEN
            ItemLedgerEntry3.SETRANGE("Posting Date", 0D, AccPeriodEndDate)
        ELSE
            ItemLedgerEntry3.SETRANGE("Posting Date", AccPeriodStartDate, AccPeriodEndDate);
        ItemLedgerEntry3.SETRANGE("Order Type", ItemLedgerEntry3."Order Type"::Production);
        ItemLedgerEntry3.SETFILTER("Entry Type", '<>%1', ItemLedgerEntry3."Entry Type"::Consumption);
        //ItemLedgerEntry3.SETRANGE("Source Type",ItemLedgerEntry3."Source Type"::Item);
        //ItemLedgerEntry3.SETRANGE("Source No.",ParentItemNo);
        ItemLedgerEntry3.SETRANGE("Item No.", ParentItemNo);
        ItemLedgerEntry3.SETFILTER(Quantity, '>%1', 0);
        IF ItemLedgerEntry3.FINDSET THEN
            REPEAT
                ClearValues2;
                Item.GET(ParentItemNo);

                Sum_ILE_Quantity += ItemLedgerEntry3.Quantity;
                Calc_Quantity := ItemLedgerEntry3.Quantity;

                Calc_PostingDate := ItemLedgerEntry3."Posting Date";
                Calc_EntryType := ItemLedgerEntry3."Entry Type".AsInteger();
                Calc_DocType := ItemLedgerEntry3."Document Type".AsInteger();
                Calc_DocNo := ItemLedgerEntry3."Document No.";
                Calc_Description := ItemLedgerEntry3.Description;
                //HEI.02<<
                Calc_NewDescription := Item.Description;
                Calc_Type := Calc_Type::Item;
                // Calc_ItemSourceNo := ItemLedgerEntry."Source No.";
                //HEI.02>>
                Calc_ILENo := ItemLedgerEntry3."Entry No.";
                Calc_OrderType := ItemLedgerEntry3."Order Type".AsInteger();
                Calc_ItemNo := ParentItemNo;
                Calc_LocationCode := LocationCode;
                Calc_StdCost := StandardCostSKU;
                Calc_PrevActualCost := PrevActualCost;
                Calc_ItemCategoryCode := Item."Item Category Code";

                ValueEntry2.RESET;
                ValueEntry2.SETRANGE("Item Ledger Entry No.", ItemLedgerEntry3."Entry No.");
                IF ValueEntry2.FINDFIRST THEN BEGIN
                    Calc_OrderType_VE := ValueEntry2."Order Type".AsInteger();
                    Calc_ILEType_VE := ValueEntry2."Item Ledger Entry Type".AsInteger();
                    Calc_EntryType_VE := ValueEntry2."Entry Type".AsInteger();
                    Calc_SourceType_VE := ValueEntry2."Source Type".AsInteger();
                    Calc_SourceNo_VE := ValueEntry2."Source No.";
                    //Calc_CostAmtActual_VE := ValueEntry2."Cost Amount (Actual)";
                    //Calc_CostAmtPurchase_VE := ValueEntry2."Cost Amount (Purchase)";
                    Calc_RelatedValueEntryNo_VE := ValueEntry2."Entry No.";
                    Calc_ValuedQuantity_VE := ValueEntry2."Valued Quantity";
                    Calc_CapacityLedgEntryNo_VE := ValueEntry2."Capacity Ledger Entry No.";
                    Calc_ILEQuantity := ValueEntry2."Valued Quantity";
                END;

                InsertActualProductCostCalculation(CalculationType::"Production Orders Not Consumption VE");
            UNTIL ItemLedgerEntry3.NEXT = 0;

        //IF TotalAccCostPositives <> 0 THEN
        InsertCalculatedActualProductCost(ParentItemNo, LocationCode, CalculationType::"Production Orders Not Consumption VE", TotalAccCostPositives, FALSE, FALSE, FALSE);

        Sum_PONonCosumpt := TotalAccCostPositives;

        EXIT(TotalAccCostPositives);
    end;

    local procedure CalcProdOrdersConsumption_VE(ParentItemNo: Code[20]; ItemNo: Code[20]; LocationCode: Code[10]; StandardCostSKU: Decimal; PrevActualCost: Decimal; ProductType: Option "Raw and Packaging Material Cost","Semi-Finished Goods Cost","Finished Goods Cost"): Decimal;
    var
        Item: Record 27;
        ItemLedgerEntry: Record 32;
        ItemLedgerEntry2: Record 32;
        ValueEntry: Record 5802;
        ValueEntry2: Record 5802;
        TotalAccCostPositives: Decimal;
        CalculationType: Option " ","Negatives ILE","Transfers ILE","Positives VE","Purchases VE","Production Orders Not Consumption VE","Production Orders Conspumtion VE";
    begin
        TotalAccCostPositives := 0;
        Sum_POConsumpt := 0;
        Sum_ILE_Quantity := 0;
        Sum_ActualCostAmt := 0;

        ValueEntry.SETRANGE("Location Code", LocationCode);
        IF FirstRun THEN
            ValueEntry.SETRANGE("Posting Date", 0D, AccPeriodEndDate)
        ELSE
            ValueEntry.SETRANGE("Posting Date", AccPeriodStartDate, AccPeriodEndDate);
        ValueEntry.SETRANGE("Order Type", ValueEntry."Order Type"::Production);
        ValueEntry.SETRANGE("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Consumption);
        ValueEntry.SETRANGE("Source Type", ValueEntry."Source Type"::Item);
        ValueEntry.SETRANGE("Source No.", ParentItemNo);
        IF ParentItemNo <> ItemNo THEN
            ValueEntry.SETRANGE("Item No.", ItemNo);

        IF ValueEntry.FINDSET THEN
            REPEAT
                TotalAccCostPositives += ABS(ValueEntry."Cost Amount (Actual)");
                Sum_ActualCostAmt += ValueEntry."Cost Amount (Actual)";

                //insert Actual Product Cost Calculation
                ClearValues2;
                Item.GET(ItemNo);
                IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN BEGIN
                    Calc_PostingDate := ItemLedgerEntry."Posting Date";
                    Calc_EntryType := ItemLedgerEntry."Entry Type".AsInteger();
                    Calc_DocType := ItemLedgerEntry."Document Type".AsInteger();
                    Calc_DocNo := ItemLedgerEntry."Document No.";
                    Calc_Description := ItemLedgerEntry.Description;
                    Calc_ILENo := ItemLedgerEntry."Entry No.";
                    Calc_OrderType := ItemLedgerEntry."Order Type".AsInteger();
                END;
                Calc_ItemNo := ItemNo;
                Calc_LocationCode := LocationCode;
                Calc_StdCost := StandardCostSKU;
                Calc_PrevActualCost := PrevActualCost;
                Calc_ItemCategoryCode := Item."Item Category Code";
                Calc_OrderType_VE := ValueEntry."Order Type".AsInteger();
                Calc_ILEType_VE := ValueEntry."Item Ledger Entry Type".AsInteger();
                Calc_EntryType_VE := ValueEntry."Entry Type".AsInteger();
                Calc_SourceType_VE := ValueEntry."Source Type".AsInteger();
                Calc_SourceNo_VE := ValueEntry."Source No.";
                Calc_CostAmtActual_VE := ValueEntry."Cost Amount (Actual)";
                Calc_CostAmtPurchase_VE := ValueEntry."Cost Amount (Purchase) FND";
                Calc_RelatedValueEntryNo_VE := ValueEntry."Entry No.";
                Calc_ValuedQuantity_VE := ValueEntry."Valued Quantity";
                Calc_CapacityLedgEntryNo_VE := ValueEntry."Capacity Ledger Entry No.";
                Calc_ILEQuantity := ValueEntry."Valued Quantity";
                //HEI.02<<
                Calc_NewDescription := Item.Description;
                Calc_Type := Calc_Type::"Source Item";
                Calc_ItemSourceNo := ValueEntry."Item No.";
                //HEI.02>>

                InsertActualProductCostCalculation(CalculationType::"Production Orders Conspumtion VE");
            UNTIL ValueEntry.NEXT = 0;

        ItemLedgerEntry2.RESET;
        ItemLedgerEntry2.SETRANGE("Location Code", LocationCode);
        IF FirstRun THEN
            ItemLedgerEntry2.SETRANGE("Posting Date", 0D, AccPeriodEndDate)
        ELSE
            ItemLedgerEntry2.SETRANGE("Posting Date", AccPeriodStartDate, AccPeriodEndDate);
        ItemLedgerEntry2.SETRANGE("Order Type", ItemLedgerEntry2."Order Type"::Production);
        ItemLedgerEntry2.SETRANGE("Entry Type", ItemLedgerEntry2."Entry Type"::Consumption);
        //ItemLedgerEntry2.SETRANGE("Source Type",ItemLedgerEntry2."Source Type"::Item);
        //ItemLedgerEntry2.SETRANGE("Source No.",ParentItemNo);
        ItemLedgerEntry2.SETRANGE("Item No.", ParentItemNo);
        ItemLedgerEntry2.SETFILTER(Quantity, '>%1', 0);
        IF ItemLedgerEntry2.FINDSET THEN
            REPEAT
                ClearValues2;
                Item.GET(ItemNo);

                Sum_ILE_Quantity += ItemLedgerEntry2.Quantity;
                Calc_Quantity := ItemLedgerEntry2.Quantity;

                Calc_PostingDate := ItemLedgerEntry2."Posting Date";
                Calc_EntryType := ItemLedgerEntry2."Entry Type".AsInteger();
                Calc_DocType := ItemLedgerEntry2."Document Type".AsInteger();
                Calc_DocNo := ItemLedgerEntry2."Document No.";
                Calc_Description := ItemLedgerEntry2.Description;
                //HEI.02<<
                Calc_NewDescription := Item.Description;
                Calc_Type := Calc_Type::Item;
                // Calc_ItemSourceNo := ItemLedgerEntry."Source No.";
                //HEI.02>>
                Calc_ILENo := ItemLedgerEntry2."Entry No.";
                Calc_OrderType := ItemLedgerEntry2."Order Type".AsInteger();
                Calc_ItemNo := ItemNo;
                Calc_LocationCode := LocationCode;
                Calc_StdCost := StandardCostSKU;
                Calc_PrevActualCost := PrevActualCost;
                Calc_ItemCategoryCode := Item."Item Category Code";

                ValueEntry2.RESET;
                ValueEntry2.SETRANGE("Item Ledger Entry No.", ItemLedgerEntry2."Entry No.");
                IF ValueEntry2.FINDFIRST THEN BEGIN
                    Calc_OrderType_VE := ValueEntry2."Order Type".AsInteger();
                    Calc_ILEType_VE := ValueEntry2."Item Ledger Entry Type".AsInteger();
                    Calc_EntryType_VE := ValueEntry2."Entry Type".AsInteger();
                    Calc_SourceType_VE := ValueEntry2."Source Type".AsInteger();
                    Calc_SourceNo_VE := ValueEntry2."Source No.";
                    //Calc_CostAmtActual_VE := ValueEntry2."Cost Amount (Actual)";
                    //Calc_CostAmtPurchase_VE := ValueEntry2."Cost Amount (Purchase)";
                    Calc_RelatedValueEntryNo_VE := ValueEntry2."Entry No.";
                    Calc_ValuedQuantity_VE := ValueEntry2."Valued Quantity";
                    Calc_CapacityLedgEntryNo_VE := ValueEntry2."Capacity Ledger Entry No.";
                    Calc_ILEQuantity := ValueEntry2."Valued Quantity";
                END;

                InsertActualProductCostCalculation(CalculationType::"Production Orders Conspumtion VE");
            UNTIL ItemLedgerEntry2.NEXT = 0;

        //IF TotalAccCostPositives <> 0 THEN
        InsertCalculatedActualProductCost(ParentItemNo, LocationCode, CalculationType::"Production Orders Conspumtion VE", TotalAccCostPositives, FALSE, FALSE, FALSE);

        Sum_POConsumpt := TotalAccCostPositives;

        EXIT(TotalAccCostPositives);
    end;

    local procedure CalcTotalActCostCapacityCost(ParentItemNo: Code[20]; LocationCode: Code[10]; TotalCapacityCost: Boolean): Decimal;
    var
        ValueEntry: Record 5802;
        TotalAccCostCapacity: Decimal;
        ProductionOrder: Record 5405;
    begin
        TotalAccCostCapacity := 0;

        IF TotalCapacityCost OR FirstRun THEN
            ValueEntry.SETRANGE("Posting Date", 0D, AccPeriodEndDate)
        ELSE
            ValueEntry.SETRANGE("Posting Date", AccPeriodStartDate, AccPeriodEndDate);
        ValueEntry.SETRANGE("Order Type", ValueEntry."Order Type"::Production);
        ValueEntry.SETRANGE("Source Type", ValueEntry."Source Type"::Item);
        ValueEntry.SETRANGE("Source No.", ParentItemNo);
        ValueEntry.SETFILTER("Item Ledger Entry Type", '<>%1', ValueEntry."Item Ledger Entry Type"::Consumption);
        ValueEntry.SETFILTER("Capacity Ledger Entry No.", '<>%1', 0);

        IF ValueEntry.FINDSET THEN
            REPEAT
                ProductionOrder.SETRANGE("No.", ValueEntry."Document No.");
                IF ProductionOrder.FINDFIRST THEN
                    IF LocationCode = ProductionOrder."Location Code" THEN
                        TotalAccCostCapacity += ValueEntry."Cost Amount (Actual)";
            UNTIL ValueEntry.NEXT = 0;

        EXIT(TotalAccCostCapacity);
    end;

    local procedure CalculateStandardConsumption(ItemNo: Code[20]; LocationCode: Code[20]) StandardConsumption: Decimal;
    var
        ItemLedgerEntry: Record 32;
    begin
        ItemLedgerEntry.SETRANGE("Posting Date", AccPeriodStartDate, AccPeriodEndDate);
        //ItemLedgerEntry.SETRANGE("Entry Type",ItemLedgerEntry."Entry Type"::Output);
        ItemLedgerEntry.SETRANGE("Item No.", ItemNo);
        ItemLedgerEntry.SETRANGE("Location Code", LocationCode);
        IF ItemLedgerEntry.FINDSET THEN
            REPEAT
                StandardConsumption += ItemLedgerEntry.Quantity;
            UNTIL ItemLedgerEntry.NEXT = 0;
    end;

    local procedure CalculateExpectedQuantity(ProdOrderNoFilter: Text; QuantityPer: Decimal; UoM: Code[10]; BaseUoM: Code[10]; ItemNo: Code[20]) ExpectedQuantity: Decimal;
    var
        ProdOrderLine: Record 5406;
        QuantityPerUoM: Decimal;
    begin
        IF ProdOrderNoFilter <> '' THEN BEGIN
            ProdOrderLine.SETFILTER("Prod. Order No.", ProdOrderNoFilter);
            IF ProdOrderLine.FINDSET THEN
                REPEAT
                    IF QuantityPer <> 0 THEN BEGIN
                        IF UoM <> BaseUoM THEN
                            ExpectedQuantity += ProdOrderLine."Finished Quantity" * QuantityPer * GetQuantityPerUoM(ItemNo, UoM)
                        ELSE
                            ExpectedQuantity += ProdOrderLine."Finished Quantity" * QuantityPer;
                    END ELSE
                        ExpectedQuantity += ProdOrderLine."Finished Quantity";
                UNTIL ProdOrderLine.NEXT = 0;
        END;
    end;

    local procedure GenerateTree(ActualProductCost: Record "Actual Product Cost DTW");
    var
        SKU: Record 5700;
        ProductionBOMVersion: Record 99000779;
        ProductionBOMHeader: Record 99000771;
        ProductionBOMLine: Record 99000772;
        ProductionOrder: Record 5405;
        ActualProductCostStructure: Record "Actual Product Cost Struct DTW";
        ActualProductCostStructure2: Record "Actual Product Cost Struct DTW";
        ActualQty2: Decimal;
        ProdOrderNoFilter: Text;
        LineNo: Integer;
        Item2: Record 27;
        Item3: Record 27;
        IsRawMaterial: Boolean;
        IsSemiFinishedProd: Boolean;
    begin
        SKU.GET(ActualProductCost."Location Code", ActualProductCost."Item No.", ActualProductCost."Variant Code");
        IF SKU."Production BOM No." <> '' THEN BEGIN
            ProdOrderNoFilter := '';
            ProductionBOMVersion.SETRANGE("Production BOM No.", SKU."Production BOM No.");
            ProductionBOMVersion.SETRANGE("Active FND", TRUE);
            IF ProductionBOMVersion.FINDFIRST THEN BEGIN
                ProductionBOMHeader.SETRANGE("No.", ProductionBOMVersion."Production BOM No.");
                IF ProductionBOMHeader.FINDFIRST THEN BEGIN
                    //insert parent
                    ProductionOrder.SETRANGE("Location Code", ActualProductCost."Location Code");
                    ProductionOrder.SETRANGE("Source No.", ActualProductCost."Item No.");
                    // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Production BOM No.","Production BOM Version Code")
                    // ProductionOrder.SETRANGE("Production BOM No.", ProductionBOMHeader."No."); 
                    // ProductionOrder.SETRANGE("Production BOM Version Code", ProductionBOMVersion."Version Code");
                    // BC Upgrade BHARDA11 << ----Drink-IT Fields("Production BOM No.","Production BOM Version Code")
                    //ProductionOrder.SETRANGE("Ending Date",0D,AccPeriodEndDate);
                    IF NOT FirstRun THEN
                        ProductionOrder.SETFILTER("Starting Date", '>=%1', AccPeriodStartDate);
                    ProductionOrder.SETFILTER("Ending Date", '<=%1', AccPeriodEndDate);
                    IF ProductionOrder.FINDSET THEN BEGIN
                        REPEAT
                            ProdOrderNoFilter += ProductionOrder."No." + '|';
                        UNTIL ProductionOrder.NEXT = 0;
                        ProdOrderNoFilter := DELSTR(ProdOrderNoFilter, STRLEN(ProdOrderNoFilter));

                        InsertTree(ActualProductCost, LineNo, CalculateExpectedQuantity(ProdOrderNoFilter, 0, '', '', ActualProductCost."Item No."));

                        ProductionBOMLine.SETRANGE("Production BOM No.", ProductionBOMHeader."No.");
                        ProductionBOMLine.SETRANGE("Version Code", ProductionBOMVersion."Version Code");
                        IF ProductionBOMLine.FINDSET THEN BEGIN
                            REPEAT
                                IsRawMaterial := FALSE;
                                IsSemiFinishedProd := FALSE;
                                Item2.SETRANGE("No.", ProductionBOMLine."No.");
                                Item2.SETFILTER("Item Category Code", InventorySetup."Raw Pack Mat Item Cat Code FND");
                                IF Item2.FINDFIRST THEN
                                    IsRawMaterial := TRUE
                                ELSE BEGIN
                                    Item2.SETRANGE("Item Category Code");
                                    Item2.SETFILTER("Item Category Code", InventorySetup."SemiFinish ProdItemCatCode FND");
                                    IF Item2.FINDFIRST THEN
                                        IsSemiFinishedProd := TRUE;
                                END;
                                IF (IsRawMaterial OR IsSemiFinishedProd) AND (Item2."Costing Method".AsInteger() = InventorySetup."Costing Method FND") THEN BEGIN
                                    ActualQty2 := 0;
                                    CalculateStructActQty(ActualProductCost."Ending Date", ProductionBOMHeader."Linked SKU FND", ActualProductCost."Item No.", ProductionBOMLine."No.", ActualQty2);

                                    //insert child
                                    Item3.GET(ProductionBOMLine."No.");
                                    InsertSubTree(ActualProductCost."Item No.", ProductionBOMLine."No.", ProductionBOMHeader."Linked SKU FND", ProductionBOMLine."Variant Code", ActualProductCost."Starting Date", ActualProductCost."Ending Date",
                                      ActualQty2, 0, LineNo, ActualProductCostStructure,
                                      CalculateExpectedQuantity(ProdOrderNoFilter, ProductionBOMLine."Quantity per", ProductionBOMLine."Unit of Measure Code", Item3."Base Unit of Measure", ProductionBOMLine."No."));
                                    IF IsParentLine AND NOT ActualProductCost."Is Parent" THEN BEGIN
                                        ActualProductCost."Is Parent" := TRUE;
                                        ActualProductCost.MODIFY;
                                    END;
                                END;
                            UNTIL ProductionBOMLine.NEXT = 0;

                            InsertTotalVariableCost(LineNo, 0, ActualProductCost."Starting Date", "Actual Product Cost DTW"."Ending Date");
                            InsertCapacityCost(LineNo, 0, ActualProductCost."Item No.", ActualProductCost."Location Code", ActualProductCost."Variant Code",
                              ActualProductCost."Starting Date", ActualProductCost."Ending Date", ActualProductCost."Product Type", ProdOrderNoFilter);
                            ClearValues;
                            //Calculate Total Expected Cost
                            ActualProductCostStructure2.SETRANGE("Item No.", ActualProductCost."Item No.");
                            ActualProductCostStructure.SETRANGE("Location Code", ActualProductCost."Location Code");
                            ActualProductCostStructure2.SETRANGE("Starting Date", ActualProductCost."Starting Date");
                            ActualProductCostStructure2.SETRANGE("Ending Date", ActualProductCost."Ending Date");
                            ActualProductCostStructure2.SETRANGE("Is Parent", TRUE);
                            IF ActualProductCostStructure2.FINDFIRST THEN BEGIN
                                ActualProductCostStructure2."Total Expected Cost" := CalculateParentExpectedCost(LineNo);
                                ActualProductCostStructure2.MODIFY;
                            END;
                        END;
                    END ELSE
                        InsertTree(ActualProductCost, LineNo, 0);
                END ELSE
                    InsertTree(ActualProductCost, LineNo, 0);
            END ELSE
                InsertTree(ActualProductCost, LineNo, 0);
        END ELSE
            InsertTree(ActualProductCost, LineNo, 0);

        IF NOT ActualProductCost."Is Parent" THEN BEGIN
            CalculateTotalVariableCost(ActualProductCost);
            InsertTotalVariableCost(LineNo, 0, ActualProductCost."Starting Date", ActualProductCost."Ending Date");
            InsertCapacityCost(LineNo, 0, ActualProductCost."Item No.", ActualProductCost."Location Code", ActualProductCost."Variant Code",
              ActualProductCost."Starting Date", ActualProductCost."Ending Date", ActualProductCost."Product Type", ProdOrderNoFilter);
            ClearValues;
        END;
    end;

    local procedure GenerateSubTree(ParentItemNo: Code[20]; ItemNo: Code[20]; LocationCode: Code[20]; VariantCode: Code[20]; TreeLevel: Integer; LineNo: Integer);
    var
        SKU: Record 5700;
        ProductionBOMVersion: Record 99000779;
        ProductionBOMHeader: Record 99000771;
        ProductionBOMLine: Record 99000772;
        ProductionOrder: Record 5405;
        ActualQty: Decimal;
        ActualProductCostStructure: Record "Actual Product Cost Struct DTW";
        ProdOrderNoFilter: Text;
        Item2: Record 27;
        Item3: Record 27;
        IsSemiFinishedProd: Boolean;
        IsRawMaterial: Boolean;
    begin
        SKU.GET(LocationCode, ItemNo, VariantCode);
        IF SKU."Production BOM No." <> '' THEN BEGIN
            ProductionBOMVersion.SETRANGE("Production BOM No.", SKU."Production BOM No.");
            ProductionBOMVersion.SETRANGE("Active FND", TRUE);
            IF ProductionBOMVersion.FINDFIRST THEN BEGIN
                ProductionBOMHeader.SETRANGE("No.", ProductionBOMVersion."Production BOM No.");
                IF ProductionBOMHeader.FINDFIRST THEN BEGIN
                    ProductionOrder.SETRANGE("Location Code", LocationCode);
                    ProductionOrder.SETRANGE("Source No.", ItemNo);
                    // BC Upgrade BHARAD11 >> ----Drink-IT Fields("Production BOM No.","Production BOM Version Code")
                    // ProductionOrder.SETRANGE("Production BOM No.", ProductionBOMHeader."No.");
                    // ProductionOrder.SETRANGE("Production BOM Version Code", ProductionBOMVersion."Version Code");
                    // BC Upgrade BHARAD11 << ----Drink-IT Fields("Production BOM No.","Production BOM Version Code")

                    ProductionOrder.SETRANGE("Ending Date", 0D, AccPeriodEndDate);
                    IF ProductionOrder.FINDSET THEN BEGIN
                        ProdOrderNoFilter := '';
                        REPEAT
                            ProdOrderNoFilter += ProductionOrder."No." + '|';
                        UNTIL ProductionOrder.NEXT = 0;
                        ProdOrderNoFilter := DELSTR(ProdOrderNoFilter, STRLEN(ProdOrderNoFilter));

                        ProductionBOMLine.SETRANGE("Production BOM No.", ProductionBOMHeader."No.");
                        ProductionBOMLine.SETRANGE("Version Code", ProductionBOMVersion."Version Code");
                        IF ProductionBOMLine.FINDSET THEN BEGIN
                            REPEAT
                                IsRawMaterial := FALSE;
                                IsSemiFinishedProd := FALSE;
                                Item2.SETRANGE("No.", ProductionBOMLine."No.");
                                Item2.SETFILTER("Item Category Code", InventorySetup."Raw Pack Mat Item Cat Code FND");
                                IF Item2.FINDFIRST THEN
                                    IsRawMaterial := TRUE
                                ELSE BEGIN
                                    Item2.SETRANGE("Item Category Code");
                                    Item2.SETFILTER("Item Category Code", InventorySetup."SemiFinish ProdItemCatCode FND");
                                    IF Item2.FINDFIRST THEN
                                        IsSemiFinishedProd := TRUE;
                                END;
                                IF (IsRawMaterial OR IsSemiFinishedProd) AND (Item2."Costing Method".AsInteger() = InventorySetup."Costing Method FND") THEN BEGIN
                                    ActualQty := 0;
                                    CalculateStructActQty(AccPeriodEndDate, ProductionBOMHeader."Linked SKU FND", ItemNo, ProductionBOMLine."No.", ActualQty);
                                    //insert child
                                    Item3.GET(ProductionBOMLine."No.");
                                    InsertSubTree(ParentItemNo, ProductionBOMLine."No.", ProductionBOMHeader."Linked SKU FND", ProductionBOMLine."Variant Code", AccPeriodStartDate, AccPeriodEndDate,
                                      ActualQty, TreeLevel, LineNo, ActualProductCostStructure,
                                      CalculateExpectedQuantity(ProdOrderNoFilter, ProductionBOMLine."Quantity per", ProductionBOMLine."Unit of Measure Code", Item3."Base Unit of Measure", ProductionBOMLine."No."));
                                END;
                            UNTIL ProductionBOMLine.NEXT = 0;
                        END;
                    END;
                END;
            END;
        END;
    end;

    local procedure InsertTree(ActualProductCost: Record "Actual Product Cost DTW"; var LineNo2: Integer; ExpectedQty: Decimal);
    var
        ActualProductCostStructure: Record "Actual Product Cost Struct DTW";
        ActualProductCostStructure2: Record "Actual Product Cost Struct DTW";
        LineNo: Integer;
    begin
        ActualProductCostStructure.INIT;
        IF ActualProductCostStructure2.FINDLAST THEN
            LineNo := ActualProductCostStructure2."Line No." + 1
        ELSE
            LineNo := 1;
        ActualProductCostStructure."Line No." := LineNo;
        ActualProductCostStructure.INSERT;
        LineNo2 := LineNo;
        ActualProductCostStructure.TRANSFERFIELDS(ActualProductCost);
        ActualProductCostStructure."Period Expected Quantity" := ExpectedQty;
        ActualProductCostStructure."Parent Item No." := ActualProductCostStructure."Item No.";
        ActualProductCostStructure.MODIFY;
    end;

    local procedure InsertSubTree(ParentItemNo: Code[20]; ItemNo: Code[20]; LocationCode: Code[20]; VariantCode: Code[20]; StartDate: Date; EndDate: Date; ActQty: Decimal; TreeLevel: Integer; ParentLineNo: Integer; var ActualProductCostStructure: Record "Actual Product Cost Struct DTW"; ExpectedQty: Decimal);
    var
        ActualProductCostStructure2: Record "Actual Product Cost Struct DTW";
        ActualProductCostStructure3: Record "Actual Product Cost Struct DTW";
        LineNo: Integer;
        SKU: Record 5700;
        ProductionBOMVersion: Record 99000779;
        ProductionBOMHeader: Record 99000771;
        ProductionOrder: Record 5405;
        Item2: Record 27;
        Item3: Record 27;
        ProdOrderNoFilter: Text;
        PrevTotActQty: Decimal;
        PrevPeriodActQty: Decimal;
        PrevTotalActCost: Decimal;
        PrevPeriodActCost: Decimal;
        PerPlantUoM: Decimal;
        ActualProductCost: Record "Actual Product Cost DTW";
        StandardCost: Decimal;
        OperationSign: Option "*","/","+","-";
        CalculationType: Option " ","Negatives ILE","Transfers ILE","Positives VE","Purchases VE","Production Orders Not Consumption VE","Production Orders Conspumtion VE";
        CalculatedActualCost2: Decimal;
        ActualCostCalculation3: Record "Actual Cost Calculation DTW";
        CalculatedActualCost: Decimal;
        TotalQuantity: Decimal;
    begin
        ActualProductCostStructure.INIT;
        IF ActualProductCostStructure2.FINDLAST THEN
            LineNo := ActualProductCostStructure2."Line No." + 1
        ELSE
            LineNo := 1;
        ActualProductCostStructure."Line No." := LineNo;
        ActualProductCostStructure.INSERT;
        Item3.GET(ItemNo);
        IF SKU.GET(LocationCode, ItemNo, VariantCode) THEN
            StandardCost := SKU."Standard Cost"
        ELSE
            StandardCost := Item3."Standard Cost";

        FindStructPreviousPeriod(ItemNo, LocationCode, ParentLineNo, PrevTotActQty, PrevPeriodActQty, PrevTotalActCost, PrevPeriodActCost);
        ActualProductCostStructure."Period Actual Quantity" := ActQty;
        ActualProductCostStructure."Total Actual Quantity" := CheckMinMaxAllowedValue(PrevTotActQty, ActQty, OperationSign::"+");
        ActualProductCostStructure."Period Actual Cost" := CalculateStructTotalActCost(ParentItemNo, ItemNo, LocationCode);
        //++
        ActualProductCostStructure."Total Actual Cost" := CheckMinMaxAllowedValue(ActualProductCostStructure."Period Actual Cost", PrevTotalActCost, OperationSign::"+");

        ActualProductCostStructure."Period Expected Quantity" := ExpectedQty;
        ActualProductCostStructure."Is Child" := TRUE;
        ActualProductCostStructure."Tree Level" := TreeLevel + 1;

        ActualProductCostStructure."Parent Line No." := ParentLineNo;
        ActualProductCostStructure."Parent Item No." := ParentItemNo;

        IsParentLine := FALSE;
        ActualProductCostStructure3.GET(ParentLineNo);
        IF NOT ActualProductCostStructure3."Is Parent" THEN BEGIN
            ActualProductCostStructure3."Is Parent" := TRUE;
            ActualProductCostStructure3.MODIFY;
        END;
        IsParentLine := ActualProductCostStructure3."Is Parent";

        ActualProductCostStructure."Item No." := ItemNo;
        ActualProductCostStructure."Location Code" := LocationCode;
        ActualProductCostStructure."Variant Code" := VariantCode;
        ActualProductCostStructure."Starting Date" := StartDate;
        ActualProductCostStructure."Ending Date" := EndDate;
        ActualProductCostStructure."Item Category Code" := Item3."Item Category Code";
        ActualProductCostStructure."Base Unit of Measure" := Item3."Base Unit of Measure";
        ActualProductCostStructure."Std Cost BUoM" := StandardCost;

        IF ActualProductCostStructure."Product Type" = ActualProductCostStructure."Product Type"::"Finished Goods Cost" THEN BEGIN
            PerPlantUoM := GetPUQtyPerUoM(ActualProductCostStructure."Item No.");
            ActualProductCostStructure."Total Actual Qty in PUM" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Actual Quantity", PerPlantUoM, OperationSign::"*");
            ActualProductCostStructure."Std Cost PUM" := CheckMinMaxAllowedValue(ActualProductCostStructure."Std Cost BUoM", PerPlantUoM, OperationSign::"*");
        END;

        IF ActualProductCostStructure."Product Type" <> ActualProductCostStructure."Product Type"::"Raw and Packaging Material Cost" THEN BEGIN
            // "Total Actual Qty in HL" := CheckMinMaxAllowedValue("Total Actual Quantity", Item2."Unit Volume HL", OperationSign::"*"); // BC Upgrade BHARAD11 ----Drink-IT Field("Unit Volume HL")
            ActualProductCostStructure."Standard Consumption" := CalculateStandardConsumption(ActualProductCostStructure."Item No.", ActualProductCostStructure."Location Code");
            //++
            // "Std Cost HL" := CheckMinMaxAllowedValue("Std Cost BUoM", Item2."Unit Volume HL", OperationSign::"*"); // BC Upgrade BHARAD11 ----Drink-IT Field("Unit Volume HL")
            //"Total Std Cost" := CheckMinMaxAllowedValue(StandardCost,"Standard Consumption",OperationSign::"*");
        END;
        ActualProductCostStructure."Total Std Cost" := CheckMinMaxAllowedValue(StandardCost, ActualProductCostStructure."Total Actual Quantity", OperationSign::"*");

        IF ActualProductCostStructure."Total Actual Quantity" <> 0 THEN
            ActualProductCostStructure."Actual Cost BUoM" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Actual Cost", ActualProductCostStructure."Total Actual Quantity", OperationSign::"/")
        ELSE
            ActualProductCostStructure."Actual Cost BUoM" := 0;

        ActualProductCostStructure."Total Variance" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Std Cost", ActualProductCostStructure."Total Actual Cost", OperationSign::"-");
        ActualProductCostStructure."Total Expected Cost" := CheckMinMaxAllowedValue(ActualProductCostStructure."Period Expected Quantity", ActualProductCostStructure."Actual Cost BUoM", OperationSign::"*");
        ParentExpectedCost += ActualProductCostStructure."Total Expected Cost";
        //++
        IF ActualProductCostStructure."Product Type" <> ActualProductCostStructure."Product Type"::"Raw and Packaging Material Cost" THEN BEGIN
            ActualProductCostStructure."Consumption Variance" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Expected Cost", ActualProductCostStructure."Total Actual Cost", OperationSign::"-");
            ActualProductCostStructure."Price Variance" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Std Cost", ActualProductCostStructure."Total Expected Cost", OperationSign::"-");
        END ELSE
            ActualProductCostStructure."Price Variance" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Std Cost", ActualProductCostStructure."Total Actual Cost", OperationSign::"-");

        IF (ActualProductCostStructure."Total Actual Quantity" <> 0) AND (ActualProductCostStructure."Product Type" <> ActualProductCostStructure."Product Type"::"Raw and Packaging Material Cost") THEN
            ActualProductCostStructure."Exp Cost BUoM" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Expected Cost", ActualProductCostStructure."Total Actual Quantity", OperationSign::"/")
        ELSE
            ActualProductCostStructure."Exp Cost BUoM" := 0;

        IF ActualProductCostStructure."Total Std Cost" <> 0 THEN BEGIN
            ActualProductCostStructure."As % of Std Cost" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Variance", ActualProductCostStructure."Total Std Cost", OperationSign::"/") * 100;
            ActualProductCostStructure."As % of Price" := CheckMinMaxAllowedValue(ActualProductCostStructure."Price Variance", ActualProductCostStructure."Total Std Cost", OperationSign::"/") * 100;
            IF ActualProductCostStructure."Product Type" <> ActualProductCostStructure."Product Type"::"Raw and Packaging Material Cost" THEN
                ActualProductCostStructure."As % of Std Consumption" := CheckMinMaxAllowedValue(ActualProductCostStructure."Consumption Variance", ActualProductCostStructure."Total Std Cost", OperationSign::"/") * 100;
        END ELSE BEGIN
            ActualProductCostStructure."As % of Std Cost" := 0;
            ActualProductCostStructure."As % of Price" := 0;
            IF ActualProductCostStructure."Product Type" <> ActualProductCostStructure."Product Type"::"Raw and Packaging Material Cost" THEN
                ActualProductCostStructure."As % of Std Consumption" := 0;
        END;

        IF ActualProductCostStructure."Product Type" <> ActualProductCostStructure."Product Type"::"Raw and Packaging Material Cost" THEN
            IF ActualProductCostStructure."Total Actual Qty in HL" <> 0 THEN BEGIN
                ActualProductCostStructure."Actual Cost HL" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Actual Cost", ActualProductCostStructure."Total Actual Qty in HL", OperationSign::"/");
                ActualProductCostStructure."Exp Cost HL" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Expected Cost", ActualProductCostStructure."Total Actual Qty in HL", OperationSign::"/");
            END ELSE BEGIN
                ActualProductCostStructure."Actual Cost HL" := 0;
                ActualProductCostStructure."Exp Cost HL" := 0;
            END;

        IF ActualProductCostStructure."Product Type" = ActualProductCostStructure."Product Type"::"Finished Goods Cost" THEN
            IF ActualProductCostStructure."Total Actual Qty in PUM" <> 0 THEN BEGIN
                ActualProductCostStructure."Actual Cost PUM" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Actual Cost", ActualProductCostStructure."Total Actual Qty in PUM", OperationSign::"/");
                ActualProductCostStructure."Exp Cost PUM" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Expected Cost", ActualProductCostStructure."Total Actual Qty in PUM", OperationSign::"/");
            END ELSE BEGIN
                ActualProductCostStructure."Actual Cost PUM" := 0;
                ActualProductCostStructure."Exp Cost PUM" := 0;
            END;

        ActualProductCostStructure.MODIFY(TRUE);
        //search sub-tree
        Item2.SETRANGE("No.", ItemNo);
        Item2.SETRANGE("Costing Method", InventorySetup."Costing Method FND");
        Item2.SETFILTER("Item Category Code", InventorySetup."SemiFinish ProdItemCatCode FND");
        IF Item2.FINDFIRST THEN BEGIN
            ActualProductCostStructure."Is Parent" := TRUE;
            ActualProductCostStructure."Standard Consumption" := ActQty;
            ActualProductCostStructure."Product Type" := ActualProductCostStructure."Product Type"::"Semi-Finished Goods Cost";

            GenerateSubTree(ParentItemNo, ItemNo, LocationCode, VariantCode, ActualProductCostStructure."Tree Level", ActualProductCostStructure."Line No.");
            //InsertTotalVariableCost("Line No.","Tree Level",StartDate,EndDate);
            //find Prod. Order
            IF SKU."Production BOM No." <> '' THEN BEGIN
                ProductionBOMVersion.SETRANGE("Production BOM No.", SKU."Production BOM No.");
                ProductionBOMVersion.SETRANGE("Active FND", TRUE);
                IF ProductionBOMVersion.FINDFIRST THEN BEGIN
                    ProductionBOMHeader.SETRANGE("No.", ProductionBOMVersion."Production BOM No.");
                    IF ProductionBOMHeader.FINDFIRST THEN BEGIN
                        ProductionOrder.SETRANGE("Location Code", LocationCode);
                        ProductionOrder.SETRANGE("Source No.", ItemNo);
                        // BC Upgrade BHARAD11 >> ----Drink-IT Fields("Production BOM No.","Production BOM Version Code")
                        // ProductionOrder.SETRANGE("Production BOM No.", ProductionBOMHeader."No.");
                        // ProductionOrder.SETRANGE("Production BOM Version Code", ProductionBOMVersion."Version Code");
                        // BC Upgrade BHARAD11 << ----Drink-IT Fields("Production BOM No.","Production BOM Version Code")
                        ProductionOrder.SETRANGE("Ending Date", 0D, AccPeriodEndDate);
                        IF ProductionOrder.FINDSET THEN BEGIN
                            ProdOrderNoFilter := '';
                            REPEAT
                                ProdOrderNoFilter += ProductionOrder."No." + '|';
                            UNTIL ProductionOrder.NEXT = 0;
                            ProdOrderNoFilter := DELSTR(ProdOrderNoFilter, STRLEN(ProdOrderNoFilter));
                        END;
                    END;
                END;
            END;
            //InsertCapacityCost("Line No.","Tree Level",ItemNo,LocationCode,VariantCode,StartDate,EndDate,ActualProductCostStructure."Product Type"::"Semi-Finished Goods Cost",ProdOrderNoFilter);
            ClearValues;
            //Calculate Total Expected Cost
            ActualProductCostStructure."Total Expected Cost" := CalculateParentExpectedCost(ActualProductCostStructure."Line No.");
            IF ActualProductCost.GET(ItemNo, LocationCode, StartDate, EndDate) THEN BEGIN
                ActualProductCost."Total Expected Cost" := ActualProductCostStructure."Total Expected Cost";
                ActualProductCost.MODIFY;
            END;
        END;
        ActualProductCostStructure.MODIFY;
        //hei.02c
        InsertCalculatedActualProductCostSubTree(ParentItemNo, ItemNo, LocationCode);
        InsertPeriodActualCostSubTree(ParentItemNo, ItemNo, LocationCode);
        InsertTotalActualCostSubTree(ParentItemNo, ItemNo, LocationCode);
    end;

    local procedure CalculateActualProductCost(ItemNo: Code[20]; LocationCode: Code[10]; StartDate: Date; EndDate: Date; InsertTreeLine: Boolean; TreeLineNo: Integer);
    var
        Item2: Record 27;
        SKU: Record 5700;
        ActualProductCost: Record "Actual Product Cost DTW";
        ActualProductCostStructure: Record "Actual Product Cost Struct DTW";
        PerPlantUoM: Decimal;
        TotalActualCost: Decimal;
        PeriodActualCost: Decimal;
        OperationSign: Option "*","/","+","-";
        StandardCost: Decimal;
    begin
        IF NOT InsertTreeLine THEN BEGIN
            ActualProductCost.GET(ItemNo, LocationCode, StartDate, EndDate);
            PeriodActualQuantity := 0;
            TotalActualQuantity := 0;
            Item2.GET(ActualProductCost."Item No.");
            SKU.GET(ActualProductCost."Location Code", ActualProductCost."Item No.", ActualProductCost."Variant Code");
            IF SKU."Standard Cost" <> 0 THEN
                StandardCost := SKU."Standard Cost"
            ELSE
                StandardCost := Item2."Standard Cost";

            ActualProductCost."Total Actual Quantity" := CalculateActQuantity(0D);
            //++
            IF FirstRun THEN
                ActualProductCost."Period Actual Quantity" := ActualProductCost."Total Actual Quantity"
            ELSE
                ActualProductCost."Period Actual Quantity" := CalculateActQuantity(StartingDate);
                //++
            PeriodActualQuantity := ActualProductCost."Period Actual Quantity";
            TotalActualQuantity := ActualProductCost."Total Actual Quantity";

            IF ActualProductCost."Product Type" = ActualProductCost."Product Type"::"Finished Goods Cost" THEN BEGIN
                PerPlantUoM := GetPUQtyPerUoM(ActualProductCost."Item No.");
                ActualProductCost."Total Actual Qty in PUM" := CheckMinMaxAllowedValue(ActualProductCost."Total Actual Quantity", PerPlantUoM, OperationSign::"*");
                ActualProductCost."Std Cost PUM" := CheckMinMaxAllowedValue(ActualProductCost."Std Cost BUoM", PerPlantUoM, OperationSign::"*");
            END;

            IF ActualProductCost."Product Type" <> ActualProductCost."Product Type"::"Raw and Packaging Material Cost" THEN BEGIN
                // "Total Actual Qty in HL" := CheckMinMaxAllowedValue("Total Actual Quantity", Item2."Unit Volume HL", OperationSign::"*"); // BC Upgrade BHARAD11 ----Drink-IT Field("Unit Volume HL")
                ActualProductCost."Standard Consumption" := CalculateStandardConsumption(ActualProductCost."Item No.", ActualProductCost."Location Code");
                //++
                // "Std Cost HL" := CheckMinMaxAllowedValue("Std Cost BUoM", Item2."Unit Volume HL", OperationSign::"*"); // BC Upgrade BHARAD11 ----Drink-IT Field("Unit Volume HL")
            END;
            ActualProductCost."Total Std Cost" := CheckMinMaxAllowedValue(StandardCost, ActualProductCost."Total Actual Quantity", OperationSign::"*");

            PrevPeriod_TotalActCost := 0;
            PrevPeriod_ActCostBUoM := 0;

            FindPreviousPeriod(ItemNo, LocationCode);
            IF PrevPeriod_ActCostBUoM <> 0 THEN
                CalculateActualCost(ActualProductCost."Product Type", PrevPeriod_TotalActCost, PrevPeriod_ActCostBUoM, '', ItemNo, ItemNo, LocationCode, TRUE, TotalActualCost, PeriodActualCost, StandardCost)
            ELSE
                CalculateActualCost(ActualProductCost."Product Type", 0, StandardCost, '', ItemNo, ItemNo, LocationCode, TRUE, TotalActualCost, PeriodActualCost, StandardCost);
            ActualProductCost."Period Actual Cost" := PeriodActualCost;
            ActualProductCost."Total Actual Cost" := TotalActualCost;
            ActualProductCost.Negatives := Sum_Negatives;
            ActualProductCost.Transfers := Sum_Transfers;
            ActualProductCost.Positives := Sum_Positives;
            ActualProductCost.Purchases := Sum_Purchases;
            ActualProductCost."Prod. Orders Non Consumpt" := Sum_PONonCosumpt;
            ActualProductCost."Prod. Orders Consumption" := Sum_POConsumpt;

            IF ActualProductCost."Total Actual Quantity" <> 0 THEN
                ActualProductCost."Actual Cost BUoM" := CheckMinMaxAllowedValue(ActualProductCost."Total Actual Cost", ActualProductCost."Total Actual Quantity", OperationSign::"/")
            ELSE
                ActualProductCost."Actual Cost BUoM" := 0;

            ActualProductCost."Total Variance" := CheckMinMaxAllowedValue(ActualProductCost."Total Std Cost", ActualProductCost."Total Actual Cost", OperationSign::"-");
            IF ActualProductCost."Product Type" <> ActualProductCost."Product Type"::"Raw and Packaging Material Cost" THEN BEGIN
                ActualProductCost."Total Expected Cost" := CheckMinMaxAllowedValue(ActualProductCost."Standard Consumption", ActualProductCost."Actual Cost BUoM", OperationSign::"*");
                ActualProductCost."Consumption Variance" := CheckMinMaxAllowedValue(ActualProductCost."Total Expected Cost", ActualProductCost."Total Actual Cost", OperationSign::"-");
                ActualProductCost."Price Variance" := CheckMinMaxAllowedValue(ActualProductCost."Total Std Cost", ActualProductCost."Total Expected Cost", OperationSign::"-");
            END ELSE
                ActualProductCost."Price Variance" := CheckMinMaxAllowedValue(ActualProductCost."Total Std Cost", ActualProductCost."Total Actual Cost", OperationSign::"-");

            IF (ActualProductCost."Total Actual Quantity" <> 0) AND (ActualProductCost."Product Type" <> ActualProductCost."Product Type"::"Raw and Packaging Material Cost") THEN
                ActualProductCost."Exp Cost BUoM" := CheckMinMaxAllowedValue(ActualProductCost."Total Expected Cost", ActualProductCost."Total Actual Quantity", OperationSign::"/")
            ELSE
                ActualProductCost."Exp Cost BUoM" := 0;

            IF ActualProductCost."Total Std Cost" <> 0 THEN BEGIN
                ActualProductCost."As % of Std Cost" := CheckMinMaxAllowedValue(ActualProductCost."Total Variance", ActualProductCost."Total Std Cost", OperationSign::"/") * 100;
                ActualProductCost."As % of Price" := CheckMinMaxAllowedValue(ActualProductCost."Price Variance", ActualProductCost."Total Std Cost", OperationSign::"/") * 100;
                IF ActualProductCost."Product Type" <> ActualProductCost."Product Type"::"Raw and Packaging Material Cost" THEN
                    ActualProductCost."As % of Std Consumption" := CheckMinMaxAllowedValue(ActualProductCost."Consumption Variance", ActualProductCost."Total Std Cost", OperationSign::"/") * 100;
            END ELSE BEGIN
                ActualProductCost."As % of Std Cost" := 0;
                ActualProductCost."As % of Price" := 0;
                IF ActualProductCost."Product Type" <> ActualProductCost."Product Type"::"Raw and Packaging Material Cost" THEN
                    ActualProductCost."As % of Std Consumption" := 0;
            END;

            IF ActualProductCost."Product Type" <> ActualProductCost."Product Type"::"Raw and Packaging Material Cost" THEN
                IF ActualProductCost."Total Actual Qty in HL" <> 0 THEN BEGIN
                    ActualProductCost."Actual Cost HL" := CheckMinMaxAllowedValue(ActualProductCost."Total Actual Cost", ActualProductCost."Total Actual Qty in HL", OperationSign::"/");
                    ActualProductCost."Exp Cost HL" := CheckMinMaxAllowedValue(ActualProductCost."Total Expected Cost", ActualProductCost."Total Actual Qty in HL", OperationSign::"/");
                END ELSE BEGIN
                    ActualProductCost."Actual Cost HL" := 0;
                    ActualProductCost."Exp Cost HL" := 0;
                END;

            IF ActualProductCost."Product Type" = ActualProductCost."Product Type"::"Finished Goods Cost" THEN
                IF ActualProductCost."Total Actual Qty in PUM" <> 0 THEN BEGIN
                    ActualProductCost."Actual Cost PUM" := CheckMinMaxAllowedValue(ActualProductCost."Total Actual Cost", ActualProductCost."Total Actual Qty in PUM", OperationSign::"/");
                    ActualProductCost."Exp Cost PUM" := CheckMinMaxAllowedValue(ActualProductCost."Total Expected Cost", ActualProductCost."Total Actual Qty in PUM", OperationSign::"/");
                END ELSE BEGIN
                    ActualProductCost."Actual Cost PUM" := 0;
                    ActualProductCost."Exp Cost PUM" := 0;
                END;

            ActualProductCost.MODIFY(TRUE);
        END ELSE BEGIN //Capacity Cost Line
            ActualProductCostStructure.GET(TreeLineNo);
            IF NOT Item2.GET(ActualProductCostStructure."Item No.") THEN BEGIN
                ActualProductCostStructure."Period Actual Cost" := CalcTotalActCostCapacityCost(ActualProductCostStructure."Parent Item No.", ActualProductCostStructure."Location Code", FALSE);
                //++
                ActualProductCostStructure."Total Actual Cost" := CalcTotalActCostCapacityCost(ActualProductCostStructure."Parent Item No.", ActualProductCostStructure."Location Code", TRUE);
                //++
                IF ActualProductCostStructure."Product Type" <> ActualProductCostStructure."Product Type"::"Raw and Packaging Material Cost" THEN BEGIN
                    // "Total Actual Qty in HL" := CheckMinMaxAllowedValue("Total Actual Quantity", Item2."Unit Volume HL", OperationSign::"*"); // BC Upgrade BHARAD11 ----Drink-IT Field("Unit Volume HL")
                    // "Std Cost HL" := CheckMinMaxAllowedValue("Std Cost BUoM", Item2."Unit Volume HL", OperationSign::"*"); // BC Upgrade BHARAD11 ----Drink-IT Field("Unit Volume HL")
                    IF ActualProductCostStructure."Total Actual Qty in HL" <> 0 THEN BEGIN
                        ActualProductCostStructure."Actual Cost HL" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Actual Cost", ActualProductCostStructure."Total Actual Qty in HL", OperationSign::"/");
                        ActualProductCostStructure."Exp Cost HL" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Expected Cost", ActualProductCostStructure."Total Actual Qty in HL", OperationSign::"/");
                    END ELSE BEGIN
                        ActualProductCostStructure."Actual Cost HL" := 0;
                        ActualProductCostStructure."Exp Cost HL" := 0;
                    END;

                    ActualProductCostStructure."Consumption Variance" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Expected Cost", ActualProductCostStructure."Total Actual Cost", OperationSign::"-");
                    ActualProductCostStructure."Price Variance" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Std Cost", ActualProductCostStructure."Total Expected Cost", OperationSign::"-");
                    IF ActualProductCostStructure."Total Actual Quantity" <> 0 THEN
                        ActualProductCostStructure."Exp Cost BUoM" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Expected Cost", ActualProductCostStructure."Total Actual Quantity", OperationSign::"/")
                    ELSE
                        ActualProductCostStructure."Exp Cost BUoM" := 0;
                END ELSE
                    ActualProductCostStructure."Total Std Cost" := CheckMinMaxAllowedValue(ActualProductCostStructure."Std Cost BUoM", ActualProductCostStructure."Total Actual Quantity", OperationSign::"*");

                IF ActualProductCostStructure."Product Type" = ActualProductCostStructure."Product Type"::"Finished Goods Cost" THEN BEGIN
                    PerPlantUoM := GetPUQtyPerUoM(ItemNo);
                    ActualProductCostStructure."Total Actual Qty in PUM" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Actual Quantity", PerPlantUoM, OperationSign::"*");
                    ActualProductCostStructure."Std Cost PUM" := CheckMinMaxAllowedValue(ActualProductCostStructure."Std Cost BUoM", PerPlantUoM, OperationSign::"*");
                END;

                IF ActualProductCostStructure."Total Std Cost" <> 0 THEN BEGIN
                    ActualProductCostStructure."As % of Std Cost" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Variance", ActualProductCostStructure."Total Std Cost", OperationSign::"/") * 100;
                    ActualProductCostStructure."As % of Price" := CheckMinMaxAllowedValue(ActualProductCostStructure."Price Variance", ActualProductCostStructure."Total Std Cost", OperationSign::"/") * 100;
                    IF ActualProductCostStructure."Product Type" <> ActualProductCostStructure."Product Type"::"Raw and Packaging Material Cost" THEN
                        ActualProductCostStructure."As % of Std Consumption" := CheckMinMaxAllowedValue(ActualProductCostStructure."Consumption Variance", ActualProductCostStructure."Total Std Cost", OperationSign::"/") * 100;
                END ELSE BEGIN
                    ActualProductCostStructure."As % of Std Cost" := 0;
                    ActualProductCostStructure."As % of Price" := 0;
                    ActualProductCostStructure."As % of Std Consumption" := 0;
                END;

                ActualProductCostStructure."Total Variance" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Std Cost", ActualProductCostStructure."Total Actual Cost", OperationSign::"-");
                ActualProductCostStructure.MODIFY;
            END;
        END;
    end;

    local procedure CalculateTotalVariableCost(ActualProductCost: Record "Actual Product Cost DTW");
    begin
        IF ActualProductCost."Product Type" = ActualProductCost."Product Type"::"Raw and Packaging Material Cost" THEN BEGIN
            PeriodActCost += ActualProductCost."Period Actual Cost";
            TotalActCost += ActualProductCost."Total Actual Cost";
            TotalExpCost += ActualProductCost."Total Expected Cost";
            TotalStdCost += ActualProductCost."Total Std Cost";
            TotalVariance += ActualProductCost."Total Variance";
            PriceVariance += ActualProductCost."Price Variance";
            ConsumptVariance += ActualProductCost."Consumption Variance";
            ActCostBUoM += ActualProductCost."Actual Cost BUoM";
            ActCostPUM += ActualProductCost."Actual Cost PUM";
            ActCostHL += ActualProductCost."Actual Cost HL";
            ExpCostBUoM += ActualProductCost."Exp Cost BUoM";
            ExpCostPUM += ActualProductCost."Exp Cost PUM";
            ExpCostHL += ActualProductCost."Exp Cost HL";
            StdCostBUoM += ActualProductCost."Std Cost BUoM";
            StdCostPUM += ActualProductCost."Std Cost PUM";
            StdCostHL += ActualProductCost."Std Cost HL";
        END ELSE BEGIN
            PeriodActCost := ActualProductCost."Period Actual Cost";
            TotalActCost := ActualProductCost."Total Actual Cost";
            TotalExpCost := ActualProductCost."Total Expected Cost";
            TotalStdCost := ActualProductCost."Total Std Cost";
            TotalVariance := ActualProductCost."Total Variance";
            PriceVariance := ActualProductCost."Price Variance";
            ConsumptVariance := ActualProductCost."Consumption Variance";
            ActCostBUoM := ActualProductCost."Actual Cost BUoM";
            ActCostPUM := ActualProductCost."Actual Cost PUM";
            ActCostHL := ActualProductCost."Actual Cost HL";
            ExpCostBUoM := ActualProductCost."Exp Cost BUoM";
            ExpCostPUM := ActualProductCost."Exp Cost PUM";
            ExpCostHL := ActualProductCost."Exp Cost HL";
            StdCostBUoM := ActualProductCost."Std Cost BUoM";
            StdCostPUM := ActualProductCost."Std Cost PUM";
            StdCostHL := ActualProductCost."Std Cost HL";
        END;
    end;

    local procedure InsertTotalVariableCost(ParentLineNo: Integer; TreeLevel: Integer; StartDate: Date; EndDate: Date);
    var
        ActualProductCostStructure: Record "Actual Product Cost Struct DTW";
        ActualProductCostStructure2: Record "Actual Product Cost Struct DTW";
        ActualProductCostStructure3: Record "Actual Product Cost Struct DTW";
        LineNo: Integer;
    begin
        ActualProductCostStructure.INIT;
        IF ActualProductCostStructure2.FINDLAST THEN
            LineNo := ActualProductCostStructure2."Line No." + 1
        ELSE
            LineNo := 1;
        ActualProductCostStructure."Line No." := LineNo;
        ActualProductCostStructure.INSERT;
        ActualProductCostStructure."Variable Cost Line" := TRUE;
        ActualProductCostStructure."Parent Line No." := ParentLineNo;
        ActualProductCostStructure3.GET(ParentLineNo);
        ActualProductCostStructure."Parent Item No." := ActualProductCostStructure3."Item No.";
        ActualProductCostStructure."Location Code" := ActualProductCostStructure3."Location Code";
        ActualProductCostStructure."Starting Date" := StartDate;
        ActualProductCostStructure."Ending Date" := EndDate;
        ActualProductCostStructure."Tree Level" := TreeLevel;
        ActualProductCostStructure."Period Actual Cost" := PeriodActCost;
        ActualProductCostStructure."Total Actual Cost" := TotalActCost;
        ActualProductCostStructure."Total Expected Cost" := TotalExpCost;
        ActualProductCostStructure."Total Std Cost" := TotalStdCost;
        ActualProductCostStructure."Total Variance" := TotalVariance;
        ActualProductCostStructure."Price Variance" := PriceVariance;
        ActualProductCostStructure."Consumption Variance" := ConsumptVariance;
        ActualProductCostStructure."Actual Cost BUoM" := ActCostBUoM;
        ActualProductCostStructure."Actual Cost PUM" := ActCostPUM;
        ActualProductCostStructure."Actual Cost HL" := ActCostHL;
        ActualProductCostStructure."Exp Cost BUoM" := ExpCostBUoM;
        ActualProductCostStructure."Exp Cost PUM" := ExpCostPUM;
        ActualProductCostStructure."Exp Cost HL" := ExpCostHL;
        ActualProductCostStructure."Std Cost BUoM" := StdCostBUoM;
        ActualProductCostStructure."Std Cost PUM" := StdCostPUM;
        ActualProductCostStructure."Std Cost HL" := StdCostHL;
        ActualProductCostStructure.MODIFY;
    end;

    local procedure CalculateTotalVariableCost2(ActualProductCostStructure: Record "Actual Product Cost Struct DTW");
    begin
        PeriodActCost += ActualProductCostStructure."Period Actual Cost";
        TotalActCost += ActualProductCostStructure."Total Actual Cost";
        TotalExpCost += ActualProductCostStructure."Total Expected Cost";
        TotalStdCost += ActualProductCostStructure."Total Std Cost";
        TotalVariance += ActualProductCostStructure."Total Variance";
        PriceVariance += ActualProductCostStructure."Price Variance";
        ConsumptVariance += ActualProductCostStructure."Consumption Variance";
        ActCostBUoM += ActualProductCostStructure."Actual Cost BUoM";
        ActCostPUM += ActualProductCostStructure."Actual Cost PUM";
        ActCostHL += ActualProductCostStructure."Actual Cost HL";
        ExpCostBUoM += ActualProductCostStructure."Exp Cost BUoM";
        ExpCostPUM += ActualProductCostStructure."Exp Cost PUM";
        ExpCostHL += ActualProductCostStructure."Exp Cost HL";
        StdCostBUoM += ActualProductCostStructure."Std Cost BUoM";
        StdCostPUM += ActualProductCostStructure."Std Cost PUM";
        StdCostHL += ActualProductCostStructure."Std Cost HL";
    end;

    local procedure ModifyTotalVariableCost(ParentLineNo: Integer);
    var
        ActualProductCostStructure2: Record "Actual Product Cost Struct DTW";
    begin
        ActualProductCostStructure2.GET(ParentLineNo);
        ActualProductCostStructure2."Period Actual Cost" := PeriodActCost;
        ActualProductCostStructure2."Total Actual Cost" := TotalActCost;
        ActualProductCostStructure2."Total Expected Cost" := TotalExpCost;
        ActualProductCostStructure2."Total Std Cost" := TotalStdCost;
        ActualProductCostStructure2."Total Variance" := TotalVariance;
        ActualProductCostStructure2."Price Variance" := PriceVariance;
        ActualProductCostStructure2."Consumption Variance" := ConsumptVariance;
        ActualProductCostStructure2."Actual Cost BUoM" := ActCostBUoM;
        ActualProductCostStructure2."Actual Cost PUM" := ActCostPUM;
        ActualProductCostStructure2."Actual Cost HL" := ActCostHL;
        ActualProductCostStructure2."Exp Cost BUoM" := ExpCostBUoM;
        ActualProductCostStructure2."Exp Cost PUM" := ExpCostPUM;
        ActualProductCostStructure2."Exp Cost HL" := ExpCostBUoM;
        ActualProductCostStructure2."Std Cost BUoM" := StdCostBUoM;
        ActualProductCostStructure2."Std Cost PUM" := StdCostPUM;
        ActualProductCostStructure2."Std Cost HL" := StdCostHL;
        ActualProductCostStructure2.MODIFY;
    end;

    local procedure InsertCapacityCost(ParentLineNo: Integer; TreeLevel: Integer; ItemNo: Code[20]; LocationCode: Code[10]; VariantCode: Code[20]; StartDate: Date; EndDate: Date; ProductType: Option "Raw and Packaging Material Cost","Semi-Finished Goods Cost","Finished Goods Cost"; ProdOrderNoFilter: Text);
    var
        ActualProductCostStructure: Record "Actual Product Cost Struct DTW";
        ActualProductCostStructure2: Record "Actual Product Cost Struct DTW";
        ActualProductCostStructure4: Record "Actual Product Cost Struct DTW";
        LineNo: Integer;
        CapacityLedgerQty: Decimal;
        WorkCenter: Record 99000754;
        SKU: Record 5700;
        ValueEntry: Record 5802;
        ProdOrderRoutingLine: Record 5409;
        CapacityExpectedCost: Decimal;
        CapacityLedgerEntry: Record 5832;
        CapacityStandardCost: Decimal;
    begin
        ActualProductCostStructure.INIT;
        IF ActualProductCostStructure2.FINDLAST THEN
            LineNo := ActualProductCostStructure2."Line No." + 1
        ELSE
            LineNo := 1;
        ActualProductCostStructure."Line No." := LineNo;
        ActualProductCostStructure.INSERT;

        SKU.GET(LocationCode, ItemNo, VariantCode);
        ActualProductCostStructure."Capacity Cost Line" := TRUE;
        ActualProductCostStructure."Tree Level" := TreeLevel;
        ActualProductCostStructure."Parent Line No." := ParentLineNo;
        ActualProductCostStructure4.GET(ParentLineNo);
        ActualProductCostStructure."Parent Item No." := ActualProductCostStructure4."Item No.";
        ActualProductCostStructure."Product Type" := ProductType;
        ActualProductCostStructure."Starting Date" := StartDate;
        ActualProductCostStructure."Ending Date" := EndDate;

        ActualProductCostStructure."Location Code" := LocationCode;
        ActualProductCostStructure."Variant Code" := VariantCode;
        ActualProductCostStructure."Std Cost BUoM" := SKU."Standard Cost";

        CapacityExpectedCost := 0;
        CapacityStandardCost := 0;
        IF ProdOrderNoFilter <> '' THEN BEGIN
            CapacityLedgerEntry.SETRANGE("Order Type", CapacityLedgerEntry."Order Type"::Production);
            CapacityLedgerEntry.SETFILTER("Order No.", ProdOrderNoFilter);
            IF CapacityLedgerEntry.FINDSET THEN
                REPEAT
                    ProdOrderRoutingLine.SETRANGE("Prod. Order No.", CapacityLedgerEntry."Order No.");
                    IF ProdOrderRoutingLine.FINDSET THEN
                        REPEAT
                            WorkCenter.GET(ProdOrderRoutingLine."Work Center No.");
                            IF (ProdOrderRoutingLine."Setup Time" > 0) AND (ProdOrderRoutingLine."Run Time" = 0) THEN
                                CapacityExpectedCost += ProdOrderRoutingLine."Setup Time" * WorkCenter."Unit Cost"
                            ELSE IF (ProdOrderRoutingLine."Setup Time" = 0) AND (ProdOrderRoutingLine."Run Time" > 0) THEN
                                CapacityExpectedCost += ProdOrderRoutingLine."Run Time" * WorkCenter."Unit Cost" * CapacityLedgerEntry."Output Quantity"
                            ELSE IF (ProdOrderRoutingLine."Setup Time" > 0) AND (ProdOrderRoutingLine."Run Time" > 0) THEN
                                CapacityExpectedCost += ProdOrderRoutingLine."Setup Time" * ProdOrderRoutingLine."Run Time" * WorkCenter."Unit Cost" * CapacityLedgerEntry."Output Quantity";

                            CapacityStandardCost += WorkCenter."Unit Cost" * (ProdOrderRoutingLine."Setup Time" +
                                                    (ProdOrderRoutingLine."Run Time" * CapacityLedgerEntry."Output Quantity"));
                        UNTIL ProdOrderRoutingLine.NEXT = 0;
                UNTIL CapacityLedgerEntry.NEXT = 0;

            ActualProductCostStructure."Total Expected Cost" := CapacityExpectedCost;
            ActualProductCostStructure."Total Std Cost" := CapacityStandardCost;
            ActualProductCostStructure."Base Unit of Measure" := WorkCenter."Unit of Measure Code";
        END;

        ActualProductCostStructure.MODIFY;

        CalculateActualProductCost(ItemNo, LocationCode, StartDate, EndDate, TRUE, ActualProductCostStructure."Line No.");
    end;

    local procedure ClearValues();
    begin
        PeriodActCost := 0;
        TotalActCost := 0;
        TotalExpCost := 0;
        TotalStdCost := 0;
        TotalVariance := 0;
        PriceVariance := 0;
        ConsumptVariance := 0;
        ActCostBUoM := 0;
        ActCostPUM := 0;
        ActCostHL := 0;
        ExpCostBUoM := 0;
        ExpCostPUM := 0;
        ExpCostHL := 0;
        StdCostBUoM := 0;
        StdCostPUM := 0;
        StdCostHL := 0;
    end;

    local procedure CalculateStructActQty(EndDate: Date; LocationCode: Code[10]; ParentItemNo: Code[20]; ItemNo: Code[20]; var PeriodActualQty: Decimal);
    var
        ValueEntry: Record 5802;
    begin
        PeriodActualQty := 0;

        IF FirstRun THEN
            ValueEntry.SETFILTER("Posting Date", '<=%1', EndDate)
        ELSE
            ValueEntry.SETRANGE("Posting Date", AccPeriodStartDate, AccPeriodEndDate);
        ValueEntry.SETRANGE("Order Type", ValueEntry."Order Type"::Production);
        ValueEntry.SETRANGE("Location Code", LocationCode);
        ValueEntry.SETRANGE("Source Type", ValueEntry."Source Type"::Item);
        ValueEntry.SETRANGE("Source No.", ParentItemNo);
        ValueEntry.SETRANGE("Item No.", ItemNo);
        IF ParentItemNo = ItemNo THEN
            ValueEntry.SETRANGE("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Output)
        ELSE
            ValueEntry.SETRANGE("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Consumption);

        IF ValueEntry.FINDSET THEN
            REPEAT
                PeriodActualQty += ABS(ValueEntry."Valued Quantity");
            UNTIL ValueEntry.NEXT = 0;
    end;

    local procedure CalculateStructTotalActCost(ParentItemNo: Code[20]; ItemNo: Code[20]; LocationCode: Code[10]): Decimal;
    var
        ValueEntry: Record 5802;
        TotalAccCostPositives: Decimal;
    begin
        TotalAccCostPositives := 0;

        ValueEntry.RESET;
        ValueEntry.SETRANGE("Location Code", LocationCode);
        IF FirstRun THEN
            ValueEntry.SETRANGE("Posting Date", 0D, AccPeriodEndDate)
        ELSE
            ValueEntry.SETRANGE("Posting Date", AccPeriodStartDate, AccPeriodEndDate);
        ValueEntry.SETRANGE("Order Type", ValueEntry."Order Type"::Production);
        ValueEntry.SETRANGE("Source Type", ValueEntry."Source Type"::Item);
        ValueEntry.SETRANGE("Source No.", ParentItemNo);
        ValueEntry.SETRANGE("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Consumption);
        ValueEntry.SETRANGE("Item No.", ItemNo);

        IF ValueEntry.FINDSET THEN
            REPEAT
                TotalAccCostPositives += ValueEntry."Cost Amount (Actual)";
            UNTIL ValueEntry.NEXT = 0;

        EXIT(ABS(TotalAccCostPositives));
    end;

    local procedure CalculateParentExpectedCost(ParentLineNo: Integer) ParentTotalExpCost: Decimal;
    var
        ActualProductCostStructure: Record "Actual Product Cost Struct DTW";
        OperationSign: Option "*","/","+","-";
    begin
        ActualProductCostStructure.SETRANGE("Parent Line No.", ParentLineNo);
        ActualProductCostStructure.SETRANGE("Capacity Cost Line", TRUE);
        IF ActualProductCostStructure.FINDFIRST THEN BEGIN
            ParentTotalExpCost := CheckMinMaxAllowedValue(ParentExpectedCost, ActualProductCostStructure."Total Expected Cost", OperationSign::"+");
            ParentExpectedCost := 0;
        END;
    end;

    local procedure CheckMinMaxAllowedValue(Param: Decimal; Param2: Decimal; OperationSign: Option "*","/","+","-") ReturnValue: Decimal;
    begin
        IF (OperationSign = OperationSign::"*") AND (Param <> 0) AND (Param2 <> 0) THEN
            IF Param * Param2 < -999999999999999.99 THEN
                ReturnValue := -999999999999999.99
            ELSE
                IF Param * Param2 > 999999999999999.99 THEN
                    ReturnValue := 999999999999999.99
                ELSE
                    ReturnValue := Param * Param2
        ELSE
            IF (OperationSign = OperationSign::"/") AND (Param <> 0) AND (Param2 <> 0) THEN
                IF Param / Param2 < -999999999999999.99 THEN
                    ReturnValue := -999999999999999.99
                ELSE
                    IF Param / Param2 > 999999999999999.99 THEN
                        ReturnValue := 999999999999999.99
                    ELSE
                        ReturnValue := Param / Param2
            ELSE
                IF OperationSign = OperationSign::"+" THEN
                    IF Param + Param2 < -999999999999999.99 THEN
                        ReturnValue := -999999999999999.99
                    ELSE
                        IF Param + Param2 > 999999999999999.99 THEN
                            ReturnValue := 999999999999999.99
                        ELSE
                            ReturnValue := Param + Param2
                ELSE
                    IF OperationSign = OperationSign::"-" THEN
                        IF Param - Param2 < -999999999999999.99 THEN
                            ReturnValue := -999999999999999.99
                        ELSE
                            IF Param - Param2 > 999999999999999.99 THEN
                                ReturnValue := 999999999999999.99
                            ELSE
                                ReturnValue := Param - Param2;
    end;

    local procedure InsertActualProductCostCalculation(CalculationType: Option " ","Negatives ILE","Transfers ILE","Positives VE","Purchases VE","Production Orders Not Consumption VE","Production Orders Conspumtion VE");
    var
        ActualCostCalculation: Record "Actual Cost Calculation DTW";
        ActualCostCalculation2: Record "Actual Cost Calculation DTW";
        OperationSign: Option "*","/","+","-";
    begin
        ActualCostCalculation.INIT;
        IF ActualCostCalculation2.FINDLAST THEN
            ActualCostCalculation."Entry No." := ActualCostCalculation2."Entry No." + 1
        ELSE
            ActualCostCalculation."Entry No." := 1;
        ActualCostCalculation.INSERT;
        ActualCostCalculation."Calculation Type" := CalculationType;
        ActualCostCalculation."Posting Date" := Calc_PostingDate;
        ActualCostCalculation."Entry Type" := Calc_EntryType;
        ActualCostCalculation."Document Type" := Calc_DocType;
        ActualCostCalculation."Document No." := Calc_DocNo;
        ActualCostCalculation."Item No." := Calc_ItemNo;
        ActualCostCalculation."Item Category Code" := Calc_ItemCategoryCode;
        ActualCostCalculation."Description ILE" := Calc_Description;
        //HEI.02<<
        ActualCostCalculation.Description := Calc_NewDescription;
        ActualCostCalculation.Type := Calc_Type;
        ActualCostCalculation."Item No. of Source No." := Calc_ItemSourceNo;
        //HEI.02>>
        ActualCostCalculation."Location Code" := Calc_LocationCode;
        ActualCostCalculation.Quantity := Calc_Quantity;
        ActualCostCalculation."Item Ledger Entry No." := Calc_ILENo;
        ActualCostCalculation."Order Type" := Calc_OrderType;
        ActualCostCalculation."Order Type Value Entry" := Calc_OrderType_VE;
        ActualCostCalculation."Item Ledger Entry Type" := Calc_ILEType_VE;
        ActualCostCalculation."Entry Type Value Entry" := Calc_EntryType_VE;
        ActualCostCalculation."Source Type Value Entry" := Calc_SourceType_VE;
        ActualCostCalculation."Source No. Value Entry" := Calc_SourceNo_VE;
        ActualCostCalculation."Cost Amount (Actual) VE" := Calc_CostAmtActual_VE;
        ActualCostCalculation."Cost Amount (Purchase) VE" := Calc_CostAmtPurchase_VE;
        ActualCostCalculation."Related Value Entry No." := Calc_RelatedValueEntryNo_VE;
        ActualCostCalculation."Std. Cost (BUoM)" := Calc_StdCost;
        ActualCostCalculation."Previous Actual Cost BUoM" := Calc_PrevActualCost;
        ActualCostCalculation."Valued Quantity VE" := Calc_ValuedQuantity_VE;
        ActualCostCalculation."Capacity Ledg Entry No. VE" := Calc_CapacityLedgEntryNo_VE;
        ActualCostCalculation."Starting Date" := AccPeriodStartDate;
        ActualCostCalculation."Ending Date" := AccPeriodEndDate;
        IF CalculationType = CalculationType::"Negatives ILE" THEN
            ActualCostCalculation."Calculated Actual Cost" := -ABS(CheckMinMaxAllowedValue(Calc_Quantity, Calc_PrevActualCost, OperationSign::"*"))
        ELSE
            IF CalculationType = CalculationType::"Transfers ILE" THEN
                ActualCostCalculation."Calculated Actual Cost" := CheckMinMaxAllowedValue(Calc_Quantity, Calc_PrevActualCost, OperationSign::"*")
            ELSE
                IF (CalculationType = CalculationType::"Positives VE") OR
                   (CalculationType = CalculationType::"Production Orders Not Consumption VE")
                THEN
                    ActualCostCalculation."Calculated Actual Cost" := Calc_CostAmtActual_VE
                ELSE
                    IF CalculationType = CalculationType::"Purchases VE" THEN
                        ActualCostCalculation."Calculated Actual Cost" := Calc_CostAmtPurchase_VE
                    ELSE
                        IF CalculationType = CalculationType::"Production Orders Conspumtion VE" THEN
                            ActualCostCalculation."Calculated Actual Cost" := ABS(Calc_CostAmtActual_VE);
        ActualCostCalculation.MODIFY;
    end;

    local procedure InsertCalculatedActualProductCost(ItemNo: Code[20]; LocationCode: Code[10]; CalculationType: Option " ","Negatives ILE","Transfers ILE","Positives VE","Purchases VE","Production Orders Not Consumption VE","Production Orders Conspumtion VE"; CalculatedActualCost: Decimal; Subtotal: Boolean; GrandTotal: Boolean; NotRawMaterial: Boolean);
    var
        ActualCostCalculation: Record "Actual Cost Calculation DTW";
        ActualCostCalculation2: Record "Actual Cost Calculation DTW";
    begin
        ActualCostCalculation.INIT;
        IF ActualCostCalculation2.FINDLAST THEN
            ActualCostCalculation."Entry No." := ActualCostCalculation2."Entry No." + 1
        ELSE
            ActualCostCalculation."Entry No." := 1;
        ActualCostCalculation.INSERT;
        ActualCostCalculation."Calculation Type" := CalculationType;
        IF CalculationType = CalculationType::"Negatives ILE" THEN BEGIN
            ActualCostCalculation."Description ILE" := 'Total Negative Entries';
            ActualCostCalculation.Description := 'Total Negative Entries';
        END ELSE
            IF CalculationType = CalculationType::"Transfers ILE" THEN BEGIN
                IF NOT NotRawMaterial THEN BEGIN
                    ActualCostCalculation."Description ILE" := 'Total Positive Transfers';
                    ActualCostCalculation.Description := 'Total Positive Transfers';
                END ELSE BEGIN
                    ActualCostCalculation."Description ILE" := 'Positives other than Production';
                    ActualCostCalculation.Description := 'Positives other than Production';
                END;
            END ELSE
                IF CalculationType = CalculationType::"Positives VE" THEN BEGIN
                    ActualCostCalculation."Description ILE" := 'Cost Amount (Actual) Other Positives';
                    ActualCostCalculation.Description := 'Cost Amount (Actual) Other Positives';
                END
                ELSE
                    IF CalculationType = CalculationType::"Purchases VE" THEN BEGIN
                        ActualCostCalculation."Description ILE" := 'Cost Amount (Purchase) Positives';
                        ActualCostCalculation.Description := 'Cost Amount (Purchase) Positives';
                    END
                    ELSE
                        IF CalculationType = CalculationType::"Production Orders Not Consumption VE" THEN BEGIN
                            ActualCostCalculation."Description ILE" := 'Positive Production Orders <> Consumption';
                            ActualCostCalculation.Description := 'Positive Production Orders <> Consumption';
                        END
                        ELSE
                            IF CalculationType = CalculationType::"Production Orders Conspumtion VE" THEN BEGIN
                                ActualCostCalculation."Description ILE" := 'Positive Production Orders Consumption';
                                ActualCostCalculation.Description := 'Positive Production Orders Consumption';
                            END
                            ELSE
                                IF CalculationType = CalculationType::" " THEN
                                    IF Subtotal THEN BEGIN
                                        ActualCostCalculation."Description ILE" := 'Period Actual Product Cost';
                                        ActualCostCalculation.Quantity := PeriodActualQuantity;
                                        ActualCostCalculation.Description := 'Period Actual Product Cost';
                                    END ELSE IF GrandTotal THEN BEGIN
                                        ActualCostCalculation."Description ILE" := 'Total Actual Product Cost';
                                        ActualCostCalculation.Quantity := TotalActualQuantity;
                                        ActualCostCalculation.Description := 'Total Actual Product Cost';
                                    END;

        ActualCostCalculation."Item No." := ItemNo;
        ActualCostCalculation."Location Code" := LocationCode;
        ActualCostCalculation."Starting Date" := AccPeriodStartDate;
        ActualCostCalculation."Ending Date" := AccPeriodEndDate;
        ActualCostCalculation."Total Actual Product Cost Line" := TRUE;
        ActualCostCalculation."Calculated Actual Cost" := CalculatedActualCost;
        ActualCostCalculation."Document Type" := ActualCostCalculation."Document Type"::" ";
        ActualCostCalculation."Entry Type" := ActualCostCalculation."Entry Type"::" ";
        ActualCostCalculation."Item Ledger Entry Type" := ActualCostCalculation."Item Ledger Entry Type"::" ";
        ActualCostCalculation."Order Type" := ActualCostCalculation."Order Type"::" ";
        ActualCostCalculation."Order Type Value Entry" := ActualCostCalculation."Order Type Value Entry"::" ";
        ActualCostCalculation."Source Type Value Entry" := ActualCostCalculation."Source Type Value Entry"::" ";
        ActualCostCalculation."Entry Type Value Entry" := ActualCostCalculation."Entry Type Value Entry"::" ";

        IF (CalculationType = CalculationType::"Negatives ILE") OR
           (CalculationType = CalculationType::"Transfers ILE")
        THEN
            ActualCostCalculation.Quantity := Sum_ILE_Quantity;

        IF (CalculationType = CalculationType::"Positives VE") OR
           (CalculationType = CalculationType::"Production Orders Not Consumption VE")
        THEN BEGIN
            ActualCostCalculation."Cost Amount (Actual) VE" := CalculatedActualCost;
            ActualCostCalculation.Quantity := Sum_ILE_Quantity;
        END;

        IF CalculationType = CalculationType::"Purchases VE" THEN BEGIN
            ActualCostCalculation."Cost Amount (Purchase) VE" := CalculatedActualCost;
            ActualCostCalculation.Quantity := Sum_ILE_Quantity;
        END;

        IF CalculationType = CalculationType::"Production Orders Conspumtion VE" THEN BEGIN
            ActualCostCalculation."Cost Amount (Actual) VE" := Sum_ActualCostAmt;
            //ABS(CalculatedActualCost);
            //IF "Cost Amount (Purchase) VE" <> 0 THEN
            ActualCostCalculation.Quantity := Sum_ILE_Quantity;
        END;

        ActualCostCalculation.MODIFY;
    end;

    local procedure ClearValues2();
    begin
        Calc_PostingDate := 0D;
        Calc_EntryType := Calc_EntryType::" ";
        Calc_DocType := Calc_DocType::" ";
        Calc_DocNo := '';
        Calc_ItemNo := '';
        Calc_Description := '';
        //HEI.02<<
        Calc_NewDescription := '';
        Calc_Type := Calc_Type::" ";
        Calc_ItemSourceNo := '';
        //HEI.02>>
        Calc_LocationCode := '';
        Calc_Quantity := 0;
        Calc_ItemCategoryCode := '';
        Calc_ILENo := 0;
        Calc_OrderType := Calc_OrderType::" ";
        Calc_OrderType_VE := Calc_OrderType_VE::" ";
        Calc_ILEType_VE := Calc_ILEType_VE::" ";

        Calc_EntryType_VE := Calc_EntryType_VE::"Direct Cost";
        Calc_SourceType_VE := Calc_SourceType_VE::" ";
        Calc_SourceNo_VE := '';
        Calc_CostAmtActual_VE := 0;
        Calc_CostAmtPurchase_VE := 0;
        Calc_RelatedValueEntryNo_VE := 0;
        Calc_StdCost := 0;
        Calc_PrevActualCost := 0;
        Calc_ValuedQuantity_VE := 0;
        Calc_CapacityLedgEntryNo_VE := 0;
        Calc_ILEQuantity := 0;
    end;

    local procedure InsertCalculatedActualProductCostSubTree(ParentItemNo: Code[20]; ItemNo: Code[20]; LocationCode: Code[10]);
    var
        ActualCostCalculation: Record "Actual Cost Calculation DTW";
        ActualCostCalculation2: Record "Actual Cost Calculation DTW";
        ActualCostCalculation3: Record "Actual Cost Calculation DTW";
        CalculatedActualCost: Decimal;
        TotalQuantity: Decimal;
        PreviousItem: Code[20];
    begin
        ActualCostCalculation.INIT;
        IF ActualCostCalculation2.FINDLAST THEN
            ActualCostCalculation."Entry No." := ActualCostCalculation2."Entry No." + 1
        ELSE
            ActualCostCalculation."Entry No." := 1;
        ActualCostCalculation.INSERT;

        ActualCostCalculation."Description ILE" := 'Positive Production Orders Consumption';
        ActualCostCalculation.Description := 'Positive Production Orders Consumption';

        ActualCostCalculation."Item No." := ParentItemNo;
        ActualCostCalculation."Item No. of Source No." := ItemNo;
        ActualCostCalculation."Location Code" := LocationCode;
        ActualCostCalculation."Starting Date" := AccPeriodStartDate;
        ActualCostCalculation."Ending Date" := AccPeriodEndDate;
        ActualCostCalculation."Total Actual Product Cost Line" := TRUE;
        ActualCostCalculation."Calculated Actual Cost" := CalculatedActualCost;
        ActualCostCalculation."Document Type" := ActualCostCalculation."Document Type"::" ";
        ActualCostCalculation."Entry Type" := ActualCostCalculation."Entry Type"::" ";
        ActualCostCalculation."Item Ledger Entry Type" := ActualCostCalculation."Item Ledger Entry Type"::" ";
        ActualCostCalculation."Order Type" := ActualCostCalculation."Order Type"::" ";
        ActualCostCalculation."Order Type Value Entry" := ActualCostCalculation."Order Type Value Entry"::" ";
        ActualCostCalculation."Source Type Value Entry" := ActualCostCalculation."Source Type Value Entry"::" ";
        ActualCostCalculation."Entry Type Value Entry" := ActualCostCalculation."Entry Type Value Entry"::" ";
        ActualCostCalculation."Subtotal Consumption" := TRUE;

        ActualCostCalculation3.SETRANGE("Item No.", ParentItemNo);
        ActualCostCalculation3.SETRANGE("Item No. of Source No.", ItemNo);
        ActualCostCalculation3.SETRANGE("Location Code", LocationCode);
        ActualCostCalculation3.SETRANGE("Total Actual Product Cost Line", FALSE);
        IF FirstRun THEN
            ActualCostCalculation3.SETRANGE("Ending Date", 0D, AccPeriodEndDate)
        ELSE BEGIN
            ActualCostCalculation3.SETRANGE("Starting Date", AccPeriodStartDate);
            ActualCostCalculation3.SETRANGE("Ending Date", AccPeriodEndDate);
        END;
        IF ActualCostCalculation3.FINDSET THEN BEGIN
            REPEAT
                CalculatedActualCost += (ActualCostCalculation3."Calculated Actual Cost");
                TotalQuantity += ActualCostCalculation3.Quantity;
            UNTIL ActualCostCalculation3.NEXT = 0;

        END;

        ActualCostCalculation."Calculated Actual Cost" := CalculatedActualCost;
        ActualCostCalculation.Quantity := TotalQuantity;
        ActualCostCalculation.MODIFY;
    end;

    local procedure InsertPeriodActualCostSubTree(ParentItemNo: Code[20]; ItemNo: Code[20]; LocationCode: Code[10]);
    var
        ActualCostCalculation: Record "Actual Cost Calculation DTW";
        ActualCostCalculation2: Record "Actual Cost Calculation DTW";
        ActualCostCalculation3: Record "Actual Cost Calculation DTW";
        PeriodActualCost: Decimal;
        TotalQuantity: Decimal;
    begin
        ActualCostCalculation.INIT;
        IF ActualCostCalculation2.FINDLAST THEN
            ActualCostCalculation."Entry No." := ActualCostCalculation2."Entry No." + 1
        ELSE
            ActualCostCalculation."Entry No." := 1;
        ActualCostCalculation.INSERT;
        ActualCostCalculation."Description ILE" := 'Period Actual Product Cost';
        ActualCostCalculation.Description := 'Period Actual Product Cost';

        ActualCostCalculation."Item No." := ParentItemNo;
        ActualCostCalculation."Item No. of Source No." := ItemNo;
        ActualCostCalculation."Location Code" := LocationCode;
        ActualCostCalculation."Starting Date" := AccPeriodStartDate;
        ActualCostCalculation."Ending Date" := AccPeriodEndDate;
        ActualCostCalculation."Total Actual Product Cost Line" := TRUE;
        ActualCostCalculation."Document Type" := ActualCostCalculation."Document Type"::" ";
        ActualCostCalculation."Entry Type" := ActualCostCalculation."Entry Type"::" ";
        ActualCostCalculation."Item Ledger Entry Type" := ActualCostCalculation."Item Ledger Entry Type"::" ";
        ActualCostCalculation."Order Type" := ActualCostCalculation."Order Type"::" ";
        ActualCostCalculation."Order Type Value Entry" := ActualCostCalculation."Order Type Value Entry"::" ";
        ActualCostCalculation."Source Type Value Entry" := ActualCostCalculation."Source Type Value Entry"::" ";
        ActualCostCalculation."Entry Type Value Entry" := ActualCostCalculation."Entry Type Value Entry"::" ";
        ActualCostCalculation."Subtotal Consumption" := TRUE;

        ActualCostCalculation3.SETRANGE("Item No.", ParentItemNo);
        ActualCostCalculation3.SETRANGE("Item No. of Source No.", ItemNo);
        ActualCostCalculation3.SETRANGE("Location Code", LocationCode);
        ActualCostCalculation3.SETRANGE("Total Actual Product Cost Line", FALSE);
        IF FirstRun THEN
            ActualCostCalculation3.SETRANGE("Ending Date", 0D, AccPeriodEndDate)
        ELSE BEGIN
            ActualCostCalculation3.SETRANGE("Starting Date", AccPeriodStartDate);
            ActualCostCalculation3.SETRANGE("Ending Date", AccPeriodEndDate);
        END;
        IF ActualCostCalculation3.FINDSET THEN
            REPEAT
                PeriodActualCost += (ActualCostCalculation3."Calculated Actual Cost");
                TotalQuantity += ActualCostCalculation3.Quantity;
            UNTIL ActualCostCalculation3.NEXT = 0;

        ActualCostCalculation."Calculated Actual Cost" := PeriodActualCost;
        ActualCostCalculation.Quantity := TotalQuantity;
        ActualCostCalculation.MODIFY;
    end;

    local procedure InsertTotalActualCostSubTree(ParentItemNo: Code[20]; ItemNo: Code[20]; LocationCode: Code[10]);
    var
        ActualCostCalculation: Record "Actual Cost Calculation DTW";
        ActualCostCalculation2: Record "Actual Cost Calculation DTW";
        ActualCostCalculation3: Record "Actual Cost Calculation DTW";
        TotalActualCost: Decimal;
        TotalQuantity: Decimal;
    begin
        ActualCostCalculation.INIT;
        IF ActualCostCalculation2.FINDLAST THEN
            ActualCostCalculation."Entry No." := ActualCostCalculation2."Entry No." + 1
        ELSE
            ActualCostCalculation."Entry No." := 1;
        ActualCostCalculation.INSERT;
        ActualCostCalculation."Description ILE" := 'Total Actual Product Cost';
        ActualCostCalculation.Description := 'Total Actual Product Cost';

        ActualCostCalculation."Item No." := ParentItemNo;
        ActualCostCalculation."Item No. of Source No." := ItemNo;
        ActualCostCalculation."Location Code" := LocationCode;
        ActualCostCalculation."Starting Date" := AccPeriodStartDate;
        ActualCostCalculation."Ending Date" := AccPeriodEndDate;
        ActualCostCalculation."Total Actual Product Cost Line" := TRUE;
        ActualCostCalculation."Document Type" := ActualCostCalculation."Document Type"::" ";
        ActualCostCalculation."Entry Type" := ActualCostCalculation."Entry Type"::" ";
        ActualCostCalculation."Item Ledger Entry Type" := ActualCostCalculation."Item Ledger Entry Type"::" ";
        ActualCostCalculation."Order Type" := ActualCostCalculation."Order Type"::" ";
        ActualCostCalculation."Order Type Value Entry" := ActualCostCalculation."Order Type Value Entry"::" ";
        ActualCostCalculation."Source Type Value Entry" := ActualCostCalculation."Source Type Value Entry"::" ";
        ActualCostCalculation."Entry Type Value Entry" := ActualCostCalculation."Entry Type Value Entry"::" ";
        ActualCostCalculation."Subtotal Consumption" := TRUE;

        ActualCostCalculation3.SETRANGE("Item No.", ParentItemNo);
        ActualCostCalculation3.SETRANGE("Item No. of Source No.", ItemNo);
        ActualCostCalculation3.SETRANGE("Location Code", LocationCode);
        ActualCostCalculation3.SETRANGE("Total Actual Product Cost Line", FALSE);
        IF FirstRun THEN
            ActualCostCalculation3.SETRANGE("Ending Date", 0D, AccPeriodEndDate)
        ELSE BEGIN
            ActualCostCalculation3.SETRANGE("Starting Date", AccPeriodStartDate);
            ActualCostCalculation3.SETRANGE("Ending Date", AccPeriodEndDate);
        END;
        IF ActualCostCalculation3.FINDSET THEN
            REPEAT
                TotalActualCost += (ActualCostCalculation3."Calculated Actual Cost");
                TotalQuantity += ActualCostCalculation3.Quantity;
            UNTIL ActualCostCalculation3.NEXT = 0;

        ActualCostCalculation."Calculated Actual Cost" := TotalActualCost;
        ActualCostCalculation.Quantity := TotalQuantity;
        ActualCostCalculation.MODIFY;
    end;
}

