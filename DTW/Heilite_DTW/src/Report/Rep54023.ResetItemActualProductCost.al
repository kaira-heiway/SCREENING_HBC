report 54023 "Reset Item Actual Product Cost"
{
    // version HEI.01

    // HEI.01 FDD-BPMGAP BRD HB398 IBM NASTAA02 22.11.2019 # Actual Product Costing
    //   # New Report created to insert Actual Product Costs
    // HEI.02 FDD-BPMGAP BRD HB398 IBM BULIMC01 06.02.2020 # Actual Product Costing
    //   # new fields recalculated
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID - 50301
    // 2. Add ApplicationArea and UsageCategory property in Report.
    // 3. Remove Drink-IT Field("Unit Volume HL") and Replace "Unit Volume HL" with 0 Because of Drink-IT Field
    // BC Upgrade BHARDA11 <<
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Reset Item Actual Product Cost';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Actual Product Cost DTW"; "Actual Product Cost DTW")
        {
            DataItemTableView = SORTING("Item No.", "Location Code", "Starting Date", "Ending Date") ORDER(Ascending) WHERE(Archived = FILTER(false));
            RequestFilterFields = "Item No.", "Location Code", "Ending Date";

            trigger OnAfterGetRecord();
            var
                TotalNegatives: Decimal;
                TotalTransfers: Decimal;
                Prev_TotActCost: Decimal;
                Old_PeriodActualCost: Decimal;
                Old_StdCost: Decimal;
                SKU: Record "Stockkeeping Unit";
                Item: Record Item;
                StandardCost: Decimal;
            begin
                if "Use Std Cost SKU" then begin
                    StandardCost := 0;
                    Item.RESET;
                    SKU.RESET;
                    Old_PeriodActualCost := 0;
                    Old_StdCost := 0;

                    FindPreviousPeriod("Item No.", "Location Code", "Starting Date", Prev_TotActCost);
                    Old_PeriodActualCost := "Period Actual Cost";
                    Old_StdCost := "Std Cost BUoM";
                    Item.GET("Item No.");

                    SKU.SETRANGE("Item No.", "Item No.");
                    SKU.SETRANGE("Location Code", "Location Code");
                    if SKU.FINDFIRST then
                        StandardCost := SKU."Standard Cost"
                    else
                        StandardCost := Item."Standard Cost";

                    TotalNegatives := ABS(Negatives) * StandardCost;
                    TotalTransfers := Transfers * StandardCost;

                    if "Product Type" = "Product Type"::"Raw and Packaging Material Cost" then begin
                        "Period Actual Cost" := Positives + Purchases + "Prod. Orders Non Consumpt" + "Prod. Orders Consumption" + TotalTransfers - TotalNegatives
                    end else
                        "Period Actual Cost" := "Prod. Orders Non Consumpt" + "Prod. Orders Consumption" + TotalTransfers - TotalNegatives;
                    "Total Actual Cost" := "Period Actual Cost" + Prev_TotActCost;
                    if Old_PeriodActualCost <> "Period Actual Cost" then begin
                        "Calculation Corrected" := true;
                        InsertedLines += 1;
                        "Std Cost BUoM" := StandardCost;
                        //HEI.02>>
                        if "Total Actual Quantity" <> 0 then
                            "Actual Cost BUoM" := CheckMinMaxAllowedValue("Total Actual Cost", "Total Actual Quantity", OperationSign::"/")
                        else
                            "Actual Cost BUoM" := 0;

                        if "Product Type" = "Product Type"::"Finished Goods Cost" then begin
                            PerPlantUoM := GetPUQtyPerUoM("Item No.");
                            "Std Cost PUM" := CheckMinMaxAllowedValue(StandardCost, PerPlantUoM, OperationSign::"*");
                        end;

                        if "Product Type" <> "Product Type"::"Raw and Packaging Material Cost" then
                            // "Std Cost HL" := CheckMinMaxAllowedValue(StandardCost, Item."Unit Volume HL", OperationSign::"*"); // BC Upgrade BHARAD11 ----Drink-IT Field("Unit Volume HL")
                            "Std Cost HL" := CheckMinMaxAllowedValue(StandardCost, 0, OperationSign::"*"); // BC Upgrade BHARDA11 ---Replace "Unit Volume HL" with 0 Because of Drink-IT Field

                        "Total Std Cost" := CheckMinMaxAllowedValue(StandardCost, "Total Actual Quantity", OperationSign::"*");

                        "Total Variance" := CheckMinMaxAllowedValue("Total Std Cost", "Total Actual Cost", OperationSign::"-");
                        if "Product Type" <> "Product Type"::"Raw and Packaging Material Cost" then begin
                            "Total Expected Cost" := CheckMinMaxAllowedValue("Standard Consumption", "Actual Cost BUoM", OperationSign::"*");
                            "Consumption Variance" := CheckMinMaxAllowedValue("Total Expected Cost", "Total Actual Cost", OperationSign::"-");
                            "Price Variance" := CheckMinMaxAllowedValue("Total Std Cost", "Total Expected Cost", OperationSign::"-");
                        end else
                            "Price Variance" := CheckMinMaxAllowedValue("Total Std Cost", "Total Actual Cost", OperationSign::"-");

                        if ("Total Actual Quantity" <> 0) and ("Product Type" <> "Product Type"::"Raw and Packaging Material Cost") then
                            "Exp Cost BUoM" := CheckMinMaxAllowedValue("Total Expected Cost", "Total Actual Quantity", OperationSign::"/")
                        else
                            "Exp Cost BUoM" := 0;

                        if "Total Std Cost" <> 0 then begin
                            "As % of Std Cost" := CheckMinMaxAllowedValue("Total Variance", "Total Std Cost", OperationSign::"/") * 100;
                            "As % of Price" := CheckMinMaxAllowedValue("Price Variance", "Total Std Cost", OperationSign::"/") * 100;
                            if "Product Type" <> "Product Type"::"Raw and Packaging Material Cost" then
                                "As % of Std Consumption" := CheckMinMaxAllowedValue("Consumption Variance", "Total Std Cost", OperationSign::"/") * 100;
                        end else begin
                            "As % of Std Cost" := 0;
                            "As % of Price" := 0;
                            if "Product Type" <> "Product Type"::"Raw and Packaging Material Cost" then
                                "As % of Std Consumption" := 0;
                        end;


                        if "Product Type" <> "Product Type"::"Raw and Packaging Material Cost" then
                            if "Total Actual Qty in HL" <> 0 then begin
                                "Actual Cost HL" := CheckMinMaxAllowedValue("Total Actual Cost", "Total Actual Qty in HL", OperationSign::"/");
                                "Exp Cost HL" := CheckMinMaxAllowedValue("Total Expected Cost", "Total Actual Qty in HL", OperationSign::"/");
                            end else begin
                                "Actual Cost HL" := 0;
                                "Exp Cost HL" := 0;
                            end;

                        if "Product Type" = "Product Type"::"Finished Goods Cost" then
                            if "Total Actual Qty in PUM" <> 0 then begin
                                "Actual Cost PUM" := CheckMinMaxAllowedValue("Total Actual Cost", "Total Actual Qty in PUM", OperationSign::"/");
                                "Exp Cost PUM" := CheckMinMaxAllowedValue("Total Expected Cost", "Total Actual Qty in PUM", OperationSign::"/");
                            end else begin
                                "Actual Cost PUM" := 0;
                                "Exp Cost PUM" := 0;
                            end;
                        //HEI.02<<
                        MODIFY;
                        ModifyActualProdCost_Structure("Item No.", "Location Code", "Starting Date", "Ending Date", "Period Actual Cost", "Total Actual Cost", StandardCost);
                        ModifyActualProdCost_Calculation("Item No.", "Location Code", "Starting Date", "Ending Date", "Period Actual Cost", StandardCost);
                        //HEI.02<<
                        ModifyActualProdCostTotVarCost_Calculation("Item No.", "Location Code", "Starting Date", "Ending Date", "Actual Product Cost DTW");
                        ModifyActualProdCostCapacityCost_Calculation("Item No.", "Location Code", "Starting Date", "Ending Date");
                        //HEI.02>>
                    end;
                end else
                    CurrReport.SKIP;

                //Progress dialog bar
                Counter += 1;
                if (Counter >= NoOfRecProgress) //OR
                                                //(TIME - TimeProgress > 1000)
                then begin
                    NoOfProgresed := NoOfProgresed + Counter;
                    DialogProgress.UPDATE(1, ROUND(NoOfProgresed / NoOfRecords * 10000, 1));
                    Counter := 0;
                    TimeProgress := TIME;
                end;
            end;

            trigger OnPostDataItem();
            begin
                DialogProgress.CLOSE;
            end;

            trigger OnPreDataItem();
            begin
                DialogProgress.OPEN(ProgressLine1Msg);

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
        Caption = 'Reset Item Actual Product Cost';
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            /*AccountingPeriod.SETRANGE("Starting Date",CALCDATE('<-CM>',PostingDate));
            IF AccountingPeriod.FINDFIRST THEN BEGIN
              AccPeriodStartDate := AccountingPeriod."Starting Date";
              AccPeriodEndDate := CALCDATE('<CM>',PostingDate);
            END;
            */

        end;
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        if InsertedLines > 0 then
            MESSAGE(ActualCostCalculatedMsg, InsertedLines)
        else
            MESSAGE(ActualCostCalculated2Msg);
    end;

    var
        AccountingPeriod: Record "Accounting Period";
        AccPeriodStartDate: Date;
        AccPeriodEndDate: Date;
        ActualCostCalculatedMsg: Label 'Actual Cost has been recalculated. %1 lines have been modified.';
        InsertedLines: Integer;
        NoOfRecords: Integer;
        NoOfRecProgress: Integer;
        NoOfProgresed: Integer;
        Counter: Integer;
        TimeProgress: Time;
        DialogProgress: Dialog;
        ActualCostCalculated2Msg: Label 'Actual Cost has been recalculated. No lines were modified.';
        ProgressLine1Msg: Label 'Recalculating Actual Product Cost: @1@@@@@@@@@@@ \';
        OperationSign: Option "*","/","+","-";
        Item2: Record Item;
        SKU: Record "Stockkeeping Unit";
        PerPlantUoM: Decimal;
        TotalActualCost: Decimal;
        StandardCost: Decimal;
        PeriodActualCost: Decimal;

    local procedure FindPreviousPeriod(ItemNo: Code[20]; LocationCode: Code[10]; StartingDate: Date; var Prev_TotActCost: Decimal);
    var
        ActualProductCost: Record "Actual Product Cost DTW";
    begin
        ActualProductCost.SETRANGE("Item No.", ItemNo);
        ActualProductCost.SETRANGE("Location Code", LocationCode);
        ActualProductCost.SETFILTER("Ending Date", '<%1', StartingDate);
        if ActualProductCost.FINDLAST then
            Prev_TotActCost := ActualProductCost."Total Actual Cost";
    end;

    local procedure ModifyActualProdCost_Structure(ItemNo: Code[20]; LocationCode: Code[10]; StartingDate: Date; EndingDate: Date; PeriodActualProductCost: Decimal; TotalActualProductCost: Decimal; StandardCost: Decimal);
    var
        ActualProductCostStructure: Record "Actual Product Cost Struct DTW";
    begin
        ActualProductCostStructure.SETRANGE("Item No.", ItemNo);
        ActualProductCostStructure.SETRANGE("Location Code", LocationCode);
        ActualProductCostStructure.SETRANGE("Starting Date", StartingDate);
        ActualProductCostStructure.SETRANGE("Ending Date", EndingDate);
        //SETFRANGE("Variable Cost Line",FALSE);
        //SETRANGE("Capacity Cost Line",FALSE);
        if ActualProductCostStructure.FINDFIRST then begin
            ActualProductCostStructure."Period Actual Cost" := PeriodActualProductCost;
            ActualProductCostStructure."Total Actual Cost" := TotalActualProductCost;
            ActualProductCostStructure."Std Cost BUoM" := StandardCost;
            ActualProductCostStructure."Use Std Cost SKU" := true;
            ActualProductCostStructure."Calculation Corrected" := true;
            //HEI.02<<
            Item2.GET(ItemNo);

            if ActualProductCostStructure."Product Type" = ActualProductCostStructure."Product Type"::"Finished Goods Cost" then begin
                PerPlantUoM := GetPUQtyPerUoM(ItemNo);
                ActualProductCostStructure."Std Cost PUM" := CheckMinMaxAllowedValue(StandardCost, PerPlantUoM, OperationSign::"*");
            end;

            if ActualProductCostStructure."Product Type" <> ActualProductCostStructure."Product Type"::"Raw and Packaging Material Cost" then begin
                // "Std Cost HL" := CheckMinMaxAllowedValue(StandardCost, Item2."Unit Volume HL", OperationSign::"*"); // BC Upgrade BHARDA11 ----Drink-IT Field
                ActualProductCostStructure."Std Cost HL" := CheckMinMaxAllowedValue(StandardCost, 0, OperationSign::"*");
                // BC Upgrade BHARDA11 --------Replace "Unit Volume HL" with 0 Because of Drink-IT Field
            end;
            ActualProductCostStructure."Total Std Cost" := CheckMinMaxAllowedValue(StandardCost, ActualProductCostStructure."Total Actual Quantity", OperationSign::"*");

            if ActualProductCostStructure."Total Actual Quantity" <> 0 then
                ActualProductCostStructure."Actual Cost BUoM" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Actual Cost", ActualProductCostStructure."Total Actual Quantity", OperationSign::"/")
            else
                ActualProductCostStructure."Actual Cost BUoM" := 0;

            ActualProductCostStructure."Total Variance" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Std Cost", ActualProductCostStructure."Total Actual Cost", OperationSign::"-");
            ActualProductCostStructure."Total Expected Cost" := CheckMinMaxAllowedValue(ActualProductCostStructure."Period Expected Quantity", ActualProductCostStructure."Actual Cost BUoM", OperationSign::"*");

            if ActualProductCostStructure."Product Type" <> ActualProductCostStructure."Product Type"::"Raw and Packaging Material Cost" then begin
                ActualProductCostStructure."Consumption Variance" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Expected Cost", ActualProductCostStructure."Total Actual Cost", OperationSign::"-");
                ActualProductCostStructure."Price Variance" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Std Cost", ActualProductCostStructure."Total Expected Cost", OperationSign::"-");
            end else
                ActualProductCostStructure."Price Variance" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Std Cost", ActualProductCostStructure."Total Actual Cost", OperationSign::"-");

            if (ActualProductCostStructure."Total Actual Quantity" <> 0) and (ActualProductCostStructure."Product Type" <> ActualProductCostStructure."Product Type"::"Raw and Packaging Material Cost") then
                ActualProductCostStructure."Exp Cost BUoM" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Expected Cost", ActualProductCostStructure."Total Actual Quantity", OperationSign::"/")
            else
                ActualProductCostStructure."Exp Cost BUoM" := 0;

            if ActualProductCostStructure."Total Std Cost" <> 0 then begin
                ActualProductCostStructure."As % of Std Cost" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Variance", ActualProductCostStructure."Total Std Cost", OperationSign::"/") * 100;
                ActualProductCostStructure."As % of Price" := CheckMinMaxAllowedValue(ActualProductCostStructure."Price Variance", ActualProductCostStructure."Total Std Cost", OperationSign::"/") * 100;
                if ActualProductCostStructure."Product Type" <> ActualProductCostStructure."Product Type"::"Raw and Packaging Material Cost" then
                    ActualProductCostStructure."As % of Std Consumption" := CheckMinMaxAllowedValue(ActualProductCostStructure."Consumption Variance", ActualProductCostStructure."Total Std Cost", OperationSign::"/") * 100;
            end else begin
                ActualProductCostStructure."As % of Std Cost" := 0;
                ActualProductCostStructure."As % of Price" := 0;
                if ActualProductCostStructure."Product Type" <> ActualProductCostStructure."Product Type"::"Raw and Packaging Material Cost" then
                    ActualProductCostStructure."As % of Std Consumption" := 0;
            end;

            if ActualProductCostStructure."Product Type" <> ActualProductCostStructure."Product Type"::"Raw and Packaging Material Cost" then
                if ActualProductCostStructure."Total Actual Qty in HL" <> 0 then begin
                    ActualProductCostStructure."Actual Cost HL" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Actual Cost", ActualProductCostStructure."Total Actual Qty in HL", OperationSign::"/");
                    ActualProductCostStructure."Exp Cost HL" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Expected Cost", ActualProductCostStructure."Total Actual Qty in HL", OperationSign::"/");
                end else begin
                    ActualProductCostStructure."Actual Cost HL" := 0;
                    ActualProductCostStructure."Exp Cost HL" := 0;
                end;

            if ActualProductCostStructure."Product Type" = ActualProductCostStructure."Product Type"::"Finished Goods Cost" then
                if ActualProductCostStructure."Total Actual Qty in PUM" <> 0 then begin
                    ActualProductCostStructure."Actual Cost PUM" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Actual Cost", ActualProductCostStructure."Total Actual Qty in PUM", OperationSign::"/");
                    ActualProductCostStructure."Exp Cost PUM" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Expected Cost", ActualProductCostStructure."Total Actual Qty in PUM", OperationSign::"/");
                end else begin
                    ActualProductCostStructure."Actual Cost PUM" := 0;
                    ActualProductCostStructure."Exp Cost PUM" := 0;
                end;
            //HEI.02>>
            ActualProductCostStructure.MODIFY;
        end;
    end;

    local procedure ModifyActualProdCost_Calculation(ItemNo: Code[20]; LocationCode: Code[10]; StartingDate: Date; EndingDate: Date; PeriodActualProductCost: Decimal; StandardCost: Decimal);
    var
        ActualCostCalculation: Record "Actual Cost Calculation DTW";
    begin
        ActualCostCalculation.SETRANGE("Item No.", ItemNo);
        ActualCostCalculation.SETRANGE("Location Code", LocationCode);
        ActualCostCalculation.SETRANGE("Starting Date", StartingDate);
        ActualCostCalculation.SETRANGE("Ending Date", EndingDate);
        ActualCostCalculation.SETRANGE("Total Actual Product Cost Line", true);
        ActualCostCalculation.SETRANGE("Calculation Type", ActualCostCalculation."Calculation Type"::" ");
        if ActualCostCalculation.FINDFIRST then begin
            ActualCostCalculation."Calculated Actual Cost" := PeriodActualProductCost;
            ActualCostCalculation."Std. Cost (BUoM)" := StandardCost;
            ActualCostCalculation."Use Std Cost SKU" := true;
            ActualCostCalculation."Calculation Corrected" := true;
            ActualCostCalculation.MODIFY;
        end;

        //Update Negative and Transfer lines
        ActualCostCalculation.RESET;
        ActualCostCalculation.SETRANGE("Item No.", ItemNo);
        ActualCostCalculation.SETRANGE("Location Code", LocationCode);
        ActualCostCalculation.SETRANGE("Starting Date", StartingDate);
        ActualCostCalculation.SETRANGE("Ending Date", EndingDate);
        //SETRANGE("Total Actual Product Cost Line",FALSE);
        ActualCostCalculation.SETFILTER("Calculation Type", '%1|%2', ActualCostCalculation."Calculation Type"::"Negatives ILE", ActualCostCalculation."Calculation Type"::"Transfers ILE");
        if ActualCostCalculation.FINDSET then
            repeat
                ActualCostCalculation."Std. Cost (BUoM)" := StandardCost;
                ActualCostCalculation."Calculated Actual Cost" := ActualCostCalculation.Quantity * StandardCost;
                ActualCostCalculation."Use Std Cost SKU" := true;
                ActualCostCalculation."Calculation Corrected" := true;
                ActualCostCalculation.MODIFY;
            until ActualCostCalculation.NEXT = 0;
    end;

    local procedure ModifyActualProdCostTotVarCost_Calculation(ItemNo: Code[20]; LocationCode: Code[10]; StartingDate: Date; EndingDate: Date; ActualProductCost: Record "Actual Product Cost DTW");
    var
        ActualProductCostStructure: Record "Actual Product Cost Struct DTW";
        ActualProductCostStructure2: Record "Actual Product Cost Struct DTW";
        ActualProductCostStructure3: Record "Actual Product Cost Struct DTW";
        ParentLineNo: Integer;
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
    begin
        //HEI.02>>
        FindParentItem(ItemNo, LocationCode, StartingDate, EndingDate, ParentLineNo);
        //Find line to be updated - Total Variable Cos
        ActualProductCostStructure.SETRANGE("Parent Item No.", ItemNo);
        ActualProductCostStructure.SETRANGE("Location Code", LocationCode);
        ActualProductCostStructure.SETRANGE("Starting Date", StartingDate);
        ActualProductCostStructure.SETRANGE("Ending Date", EndingDate);
        ActualProductCostStructure.SETRANGE("Variable Cost Line", true);
        if ActualProductCostStructure.FINDFIRST then begin
            //Find child lines
            ActualProductCostStructure2.RESET;
            ActualProductCostStructure2.SETRANGE("Parent Item No.", ItemNo);
            ActualProductCostStructure2.SETRANGE("Location Code", LocationCode);
            ActualProductCostStructure2.SETRANGE("Starting Date", StartingDate);
            ActualProductCostStructure2.SETRANGE("Ending Date", EndingDate);
            ActualProductCostStructure2.SETRANGE("Parent Line No.", ParentLineNo);
            ActualProductCostStructure2.SETRANGE("Variable Cost Line", false);
            ActualProductCostStructure2.SETRANGE("Capacity Cost Line", false);
            if ActualProductCostStructure2.FINDSET then begin
                ActualProductCostStructure."Period Actual Cost" := ActualProductCost."Period Actual Cost";
                ActualProductCostStructure."Total Actual Cost" := ActualProductCost."Total Actual Cost";
                repeat
                    TotalExpCost += ActualProductCostStructure2."Total Expected Cost";
                    TotalStdCost += ActualProductCostStructure2."Total Std Cost";
                    TotalVariance += ActualProductCostStructure2."Total Variance";
                    PriceVariance += ActualProductCostStructure2."Price Variance";
                    ConsumptVariance += ActualProductCostStructure2."Consumption Variance";
                    ActCostBUoM += ActualProductCostStructure2."Actual Cost BUoM";
                    ActCostPUM += ActualProductCostStructure2."Actual Cost PUM";
                    ActCostHL += ActualProductCostStructure2."Actual Cost HL";
                    ExpCostBUoM += ActualProductCostStructure2."Exp Cost BUoM";
                    ExpCostPUM += ActualProductCostStructure2."Exp Cost PUM";
                    ExpCostHL += ActualProductCostStructure2."Exp Cost HL";
                    StdCostBUoM += ActualProductCostStructure2."Std Cost BUoM";
                    StdCostPUM += ActualProductCostStructure2."Std Cost PUM";
                    StdCostHL += ActualProductCostStructure2."Std Cost HL";
                until ActualProductCostStructure2.NEXT = 0;

                ActualProductCostStructure."Total Expected Cost" := TotalExpCost;
                ActualProductCostStructure."Total Std Cost" := TotalStdCost;
                ActualProductCostStructure."Total Variance" := TotalVariance;
                ActualProductCostStructure."Price Variance" := PriceVariance;
                ActualProductCostStructure."Consumption Variance" := ConsumptVariance;
                ActualProductCostStructure."Actual Cost BUoM" := ActCostBUoM;
                ActualProductCostStructure."Actual Cost PUM" := ActCostHL;
                ActualProductCostStructure."Actual Cost HL" := ActCostHL;
                ActualProductCostStructure."Exp Cost BUoM" := ExpCostBUoM;
                ActualProductCostStructure."Exp Cost PUM" := ExpCostPUM;
                ActualProductCostStructure."Exp Cost HL" := ExpCostHL;
                ActualProductCostStructure."Std Cost BUoM" := StdCostBUoM;
                ActualProductCostStructure."Std Cost PUM" := StdCostPUM;
                ActualProductCostStructure."Std Cost HL" := StdCostHL;
                ActualProductCostStructure.MODIFY;
            end else if ActualProductCostStructure3.GET(ParentLineNo) then begin
                //Add from parent item
                ActualProductCostStructure."Period Actual Cost" := ActualProductCostStructure3."Period Actual Cost";
                ActualProductCostStructure."Total Actual Cost" := ActualProductCostStructure3."Total Actual Cost";
                ActualProductCostStructure."Total Std Cost" := ActualProductCostStructure3."Total Std Cost";
                ActualProductCostStructure."Total Expected Cost" := ActualProductCostStructure3."Total Expected Cost";
                ActualProductCostStructure."Total Variance" := ActualProductCostStructure3."Total Variance";
                ActualProductCostStructure."Price Variance" := ActualProductCostStructure3."Price Variance";
                ActualProductCostStructure."Consumption Variance" := ActualProductCostStructure3."Consumption Variance";
                ActualProductCostStructure."Actual Cost BUoM" := ActualProductCostStructure3."Actual Cost BUoM";
                ActualProductCostStructure."Actual Cost PUM" := ActualProductCostStructure3."Actual Cost PUM";
                ActualProductCostStructure."Actual Cost HL" := ActualProductCostStructure3."Actual Cost HL";
                ActualProductCostStructure."Exp Cost BUoM" := ActualProductCostStructure3."Exp Cost BUoM";
                ActualProductCostStructure."Exp Cost PUM" := ActualProductCostStructure3."Exp Cost PUM";
                ActualProductCostStructure."Exp Cost HL" := ActualProductCostStructure3."Exp Cost HL";
                ActualProductCostStructure."Std Cost BUoM" := ActualProductCostStructure3."Std Cost BUoM";
                ActualProductCostStructure."Std Cost PUM" := ActualProductCostStructure3."Std Cost PUM";
                ActualProductCostStructure."Std Cost HL" := ActualProductCostStructure3."Std Cost HL";
                ActualProductCostStructure.MODIFY;
            end;
        end;
        //HEI.02<<
    end;

    local procedure ModifyActualProdCostCapacityCost_Calculation(ItemNo: Code[20]; LocationCode: Code[10]; StartingDate: Date; EndingDate: Date);
    var
        ActualProductCostStructure: Record "Actual Product Cost Struct DTW";
        ParentLineNo: Integer;
    begin
        //HEI.02>>
        FindParentItem(ItemNo, LocationCode, StartingDate, EndingDate, ParentLineNo);
        //Find line to be updated - Total Capacity Cost
        ActualProductCostStructure.SETRANGE("Parent Item No.", ItemNo);
        ActualProductCostStructure.SETRANGE("Location Code", LocationCode);
        ActualProductCostStructure.SETRANGE("Starting Date", StartingDate);
        ActualProductCostStructure.SETRANGE("Ending Date", EndingDate);
        ActualProductCostStructure.SETRANGE("Capacity Cost Line", true);
        if ActualProductCostStructure.FINDFIRST then
            if not Item2.GET(ActualProductCostStructure."Item No.") then begin
                if ActualProductCostStructure."Product Type" <> ActualProductCostStructure."Product Type"::"Raw and Packaging Material Cost" then begin
                    // "Std Cost HL" := CheckMinMaxAllowedValue(StandardCost, Item2."Unit Volume HL", OperationSign::"*"); // BC Upgrade BHARDA11 ----Drink-IT Field("Unit Volume HL")
                    ActualProductCostStructure."Std Cost HL" := CheckMinMaxAllowedValue(StandardCost, 0, OperationSign::"*");
                    // BC Upgrade BHARDA11 ----Replace "Unit Volume HL" with 0 Because of Drink-IT Field
                    if ActualProductCostStructure."Total Actual Qty in HL" <> 0 then begin
                        ActualProductCostStructure."Actual Cost HL" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Actual Cost", ActualProductCostStructure."Total Actual Qty in HL", OperationSign::"/");
                        ActualProductCostStructure."Exp Cost HL" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Expected Cost", ActualProductCostStructure."Total Actual Qty in HL", OperationSign::"/");
                    end else begin
                        ActualProductCostStructure."Actual Cost HL" := 0;
                        ActualProductCostStructure."Exp Cost HL" := 0;
                    end;

                    ActualProductCostStructure."Consumption Variance" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Expected Cost", ActualProductCostStructure."Total Actual Cost", OperationSign::"-");
                    ActualProductCostStructure."Price Variance" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Std Cost", ActualProductCostStructure."Total Expected Cost", OperationSign::"-");
                    if ActualProductCostStructure."Total Actual Quantity" <> 0 then
                        ActualProductCostStructure."Exp Cost BUoM" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Expected Cost", ActualProductCostStructure."Total Actual Quantity", OperationSign::"/")
                    else
                        ActualProductCostStructure."Exp Cost BUoM" := 0;
                end else
                    ActualProductCostStructure."Total Std Cost" := CheckMinMaxAllowedValue(StandardCost, ActualProductCostStructure."Total Actual Quantity", OperationSign::"*");

                if ActualProductCostStructure."Product Type" = ActualProductCostStructure."Product Type"::"Finished Goods Cost" then begin
                    PerPlantUoM := GetPUQtyPerUoM(ItemNo);
                    ActualProductCostStructure."Total Actual Qty in PUM" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Actual Quantity", PerPlantUoM, OperationSign::"*");
                    ActualProductCostStructure."Std Cost PUM" := CheckMinMaxAllowedValue(StandardCost, PerPlantUoM, OperationSign::"*");
                end;

                if ActualProductCostStructure."Total Std Cost" <> 0 then begin
                    ActualProductCostStructure."As % of Std Cost" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Variance", ActualProductCostStructure."Total Std Cost", OperationSign::"/") * 100;
                    ActualProductCostStructure."As % of Price" := CheckMinMaxAllowedValue(ActualProductCostStructure."Price Variance", ActualProductCostStructure."Total Std Cost", OperationSign::"/") * 100;
                    if ActualProductCostStructure."Product Type" <> ActualProductCostStructure."Product Type"::"Raw and Packaging Material Cost" then
                        ActualProductCostStructure."As % of Std Consumption" := CheckMinMaxAllowedValue(ActualProductCostStructure."Consumption Variance", ActualProductCostStructure."Total Std Cost", OperationSign::"/") * 100;
                end else begin
                    ActualProductCostStructure."As % of Std Cost" := 0;
                    ActualProductCostStructure."As % of Price" := 0;
                    ActualProductCostStructure."As % of Std Consumption" := 0;
                end;

                ActualProductCostStructure."Total Variance" := CheckMinMaxAllowedValue(ActualProductCostStructure."Total Std Cost", ActualProductCostStructure."Total Actual Cost", OperationSign::"-");
            end;
        //HEI.02<<
    end;

    local procedure CheckMinMaxAllowedValue(Param: Decimal; Param2: Decimal; OperationSign2: Option "*","/","+","-") ReturnValue: Decimal;
    begin
        //HEI.02<<
        if (OperationSign2 = OperationSign2::"*") and (Param <> 0) and (Param2 <> 0) then
            if Param * Param2 < -999999999999999.99 then
                ReturnValue := -999999999999999.99
            else
                if Param * Param2 > 999999999999999.99 then
                    ReturnValue := 999999999999999.99
                else
                    ReturnValue := Param * Param2
        else
            if (OperationSign2 = OperationSign2::"/") and (Param <> 0) and (Param2 <> 0) then
                if Param / Param2 < -999999999999999.99 then
                    ReturnValue := -999999999999999.99
                else
                    if Param / Param2 > 999999999999999.99 then
                        ReturnValue := 999999999999999.99
                    else
                        ReturnValue := Param / Param2
            else
                if OperationSign2 = OperationSign2::"+" then
                    if Param + Param2 < -999999999999999.99 then
                        ReturnValue := -999999999999999.99
                    else
                        if Param + Param2 > 999999999999999.99 then
                            ReturnValue := 999999999999999.99
                        else
                            ReturnValue := Param + Param2
                else
                    if OperationSign2 = OperationSign2::"-" then
                        if Param - Param2 < -999999999999999.99 then
                            ReturnValue := -999999999999999.99
                        else
                            if Param - Param2 > 999999999999999.99 then
                                ReturnValue := 999999999999999.99
                            else
                                ReturnValue := Param - Param2;
        //HEI.02>>
    end;

    local procedure GetPUQtyPerUoM(ItemNo: Code[20]): Decimal;
    var
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        InventorySetup: Record "Inventory Setup";
    begin
        //HEI.02<<
        ItemUnitOfMeasure.SETRANGE("Item No.", ItemNo);
        ItemUnitOfMeasure.SETRANGE(Code, InventorySetup."Planning Unit of Measure FND");
        if ItemUnitOfMeasure.FINDFIRST then
            exit(ItemUnitOfMeasure."Qty. per Unit of Measure")
        else
            exit(0);
        //HEI.02>>
    end;

    local procedure FindParentItem(ItemNo: Code[20]; LocationCode: Code[10]; StartingDate: Date; EndingDate: Date; var ParentLineNo: Integer);
    var
        ActualProductCostStructure: Record "Actual Product Cost Struct DTW";
    begin
        //HEI.02>>
        ActualProductCostStructure.SETRANGE("Parent Item No.", ItemNo);
        ActualProductCostStructure.SETRANGE("Location Code", LocationCode);
        ActualProductCostStructure.SETRANGE("Starting Date", StartingDate);
        ActualProductCostStructure.SETRANGE("Ending Date", EndingDate);
        ActualProductCostStructure.SETRANGE("Parent Line No.", 0);
        if ActualProductCostStructure.FINDFIRST then
            ParentLineNo := ActualProductCostStructure."Line No.";
        //HEI.02<<
    end;
}

