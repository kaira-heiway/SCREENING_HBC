codeunit 51005 "Implement Standard Cost CBN"
{
    // version HEI.02

    // HEI.01 FDD-BPMGAP001_BPMGAP002 IBM HORTOC01 08.09.2017
    //   New codeunit
    // HEI.02 FDD-BPMGAP001_BPMGAP002 IBM HORTOC01 21.12.2017
    //   # setup the budget name


    trigger OnRun();
    var
        Item: Record Item;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        UnitCostPerHL: Decimal;
        UnitCostPerUOM: Decimal;
    begin
        /*
        //test>>
        LocFilter := 'BLUE_REGUL';
        ProdForecastName := 'YEAR';
        DateTxt := '010118..123118';
        IF ApplicationManagement.MakeDateFilter(DateTxt) = 0 THEN;
        EVALUATE(DateFilter,DateTxt);
        //test<<
        
        
        InventorySetup.GET;
        Item.RESET;
        Item.SETRANGE("Production Forecast Name",ProdForecastName);
        Item.SETRANGE("Location Filter",LocFilter);
        Item.SETRANGE("Date Filter",DateFilter);
        IF Item.findset THEN
          REPEAT
            CLEAR(TotalPrice);
        
            Item.CALCFIELDS("Prod. Forecast Quantity HL");
            IF Item."Prod. Forecast Quantity HL" <> 0 THEN BEGIN
              StockkeepingUnit.GET(LocFilter,Item."No.",'');
        
              InitBomBufferSKU(Item."No.");
              GetTotalPriceForItems(Item."No.");
              GetTotalPriceForWorkCenters(Item."No.",Item."Prod. Forecast Quantity HL");
              UnitCostPerHL := (TotalPrice / Item."Prod. Forecast Quantity HL");
              ItemUnitofMeasure.GET(Item."No.",InventorySetup."Volume Unit of Measure Code");
              UnitCostPerUOM := (UnitCostPerHL * (1/ItemUnitofMeasure."Qty. per Unit of Measure"));
              InitStandartCostWorksheet(Item."No.",UnitCostPerUOM,LocFilter);
            end;
          UNTIL Item.NEXT = 0;
        
        MESSAGE(Text001,'DEFAULT');
        */

    end;

    var
        BOMBuffer: Record "BOM Buffer" temporary;
        InventorySetup: Record "Inventory Setup";
        StockkeepingUnit: Record "Stockkeeping Unit";
        //ApplicationManagement : Codeunit ApplicationManagement; //Manisha BC Upgrade
        ApplicationManagement: Codeunit "UI Helper Triggers";//Manisha BC Upgrade
        LocFilter: Code[20];
        ProdForecastName: Code[20];
        DateFilter: Date;
        TotalPrice: Decimal;
        Text000: Label 'Could not find items with BOM levels.';
        Text001: Label 'The new standard cost has been implemented.Check Standard Cost Worksheet %1!';
        Text002: Label '%1 must have a value!';
        Text003: Label 'There are already some entries into Standard Code Worksheet Batch %1.Do you want to delete them?';
        DateTxt: Text;

    local procedure InitBomBufferSKU(ItemFilter: Code[20]);
    var
        Item: Record Item;
        CalcBOMTree: Codeunit "Calculate BOM Tree";
        HeinkiBCCustomFunctionCU: Codeunit "Heineken BC Custom Functions";//BC Manisha Upgrade
        HeinkinBCUpgradeCU: Codeunit "Heineken BC Upgrade";//BC Manisha Upgrade
    begin
        //HEI.01>>
        BOMBuffer.DELETEALL();
        Item.SETFILTER("No.", ItemFilter);
        Item.FINDFIRST();
        CalcBOMTree.SetItemFilter(Item);
        if (not StockkeepingUnit.HasBOM()) and (StockkeepingUnit."Routing No." = '') then
            ERROR(Text000);
        //CalcBOMTree.SetRunParam(true);//BC Manisha Upgrade
        HeinkinBCUpgradeCU.SetRunParam(true);//BC Manisha Upgrade
        //CalcBOMTree.GenerateTreeForItemsSKU(Item, BOMBuffer, 0, StockkeepingUnit."Location Code", StockkeepingUnit."Variant Code");//BC Manisha Upgrade
        HeinkiBCCustomFunctionCU.GenerateTreeForItemsSKU(Item, BOMBuffer, 0, StockkeepingUnit."Location Code", StockkeepingUnit."Variant Code");//BC Manisha Upgrade
        //HEI.01<<
    end;

    local procedure GetTotalPriceForItems(ParentItem: Code[20]);
    var
        NecessaryQty: Decimal;
        PurchPrice: Decimal;
    begin
        BOMBuffer.RESET();
        //BOMBuffer.SETFILTER("Replenishment System",'<>%1',BOMBuffer."Replenishment System"::"Prod. Order");
        BOMBuffer.SETRANGE(Type, BOMBuffer.Type::Item);
        if BOMBuffer.findset() then
            repeat
                NecessaryQty := GetNecessaryQtyPerHL(BOMBuffer, ParentItem);
                PurchPrice := GetPurchPrice(BOMBuffer);
                TotalPrice += NecessaryQty * PurchPrice;
            until BOMBuffer.NEXT() = 0;
    end;

    local procedure GetTotalPriceForWorkCenters(ParentItem: Code[20]; ProdForecastHL: Decimal);
    var
        FixCost: Decimal;
        NecessaryQty: Decimal;
        VariableCost: Decimal;
    begin
        BOMBuffer.RESET();
        //BOMBuffer.SETFILTER("Replenishment System",'<>%1',BOMBuffer."Replenishment System"::"Prod. Order");
        BOMBuffer.SETRANGE(Type, BOMBuffer.Type::"Work Center");
        if BOMBuffer.findset() then
            repeat
                NecessaryQty := GetNecessaryQtyPerHL(BOMBuffer, ParentItem);
                FixCost := GetFixCostWC(BOMBuffer, ProdForecastHL);
                //VariableCost := GetVariableCostForWC(BOMBuffer,ProdForecastHL);

                //TotalPrice += NecessaryQty * (FixCost + VariableCost);
                TotalPrice += NecessaryQty * FixCost;
            until BOMBuffer.NEXT() = 0;
    end;

    local procedure GetNecessaryQtyPerHL(BOMBuffer: Record "BOM Buffer"; ParentItem: Code[20]): Decimal;
    var
        Item: Record Item;
        ItemHL: Record Item;
        ItemUnitofMeasure: Record "Item Unit of Measure";
    begin
        Item.GET(ParentItem);
        //ItemUnitofMeasure.GET(ParentItem, InventorySetup."Volume Unit of Measure Code");Manisha BC Upgrade Drink it Field Error

        exit(BOMBuffer."Qty. per Top Item" * ItemUnitofMeasure."Qty. per Unit of Measure");
    end;

    local procedure GetPurchPrice(BOMBuffer: Record "BOM Buffer"): Decimal;
    var
        ItemUnitofMeasure: Record "Item Unit of Measure";
        PurchasePrice: Record "Purchase Price";
    begin
        PurchasePrice.RESET();
        PurchasePrice.SETRANGE("Item No.", BOMBuffer."No.");
        PurchasePrice.SETFILTER("Unit of Measure Code", '%1|%2', BOMBuffer."Unit of Measure Code", '');
        PurchasePrice.SETRANGE("Starting Date", DateFilter);
        if PurchasePrice.FINDFIRST() then
            exit(PurchasePrice."Direct Unit Cost");
    end;

    local procedure GetFixCostWC(BOMBuffer: Record "BOM Buffer"; ProdForecastQtyHL: Decimal): Decimal;
    var
        DefaultDimension: Record "Default Dimension";
        GLBudgetEntry: Record "G/L Budget Entry";
        GeneralLedgerSetup: Record "General Ledger Setup";
        WorkCenter: Record "Work Center";
    begin
        /*
        GeneralLedgerSetup.GET;
        GeneralLedgerSetup.TESTFIELD("Cost Center Dimension Code");
        GeneralLedgerSetup.TESTFIELD("Gl Budget Standard Cost");
        DefaultDimension.GET(DATABASE::"Work Center",BOMBuffer."No.",GeneralLedgerSetup."Cost Center Dimension Code");
        
        GLBudgetEntry.RESET;
        GLBudgetEntry.SETRANGE(GLBudgetEntry.Date,DateFilter);
        GLBudgetEntry.SETRANGE("Budget Dimension 1 Code",DefaultDimension."Dimension Code");
        GLBudgetEntry.SETRANGE("Budget Name",GeneralLedgerSetup."Gl Budget Standard Cost");//HEI.02
        GLBudgetEntry.CALCSUMS(Amount);
        
        WorkCenter.GET(BOMBuffer."No.");
        
        EXIT(GLBudgetEntry.Amount/((ProdForecastQtyHL/WorkCenter.Capacity) * BOMBuffer."Qty. per Top Item"))
        */
        //CH15.01
        WorkCenter.GET(BOMBuffer."No.");
        //WorkCenter.TESTFIELD("Unit Cost");
        exit(WorkCenter."Unit Cost");

    end;

    local procedure GetVariableCostForWC(BOMBuffer: Record "BOM Buffer"; ProdForecastQtyHL: Decimal): Decimal;
    var
        GLBudgetEntry: Record "G/L Budget Entry";
        GeneralLedgerSetup: Record "General Ledger Setup";
        WorkCenter: Record "Work Center";
        EnergyAmount: Decimal;
        MaintenanceAmount: Decimal;
        QtyPerMaintenance: Decimal;
        QtyPerWasteWater: Decimal;
        QtyPerWaterConsumption: Decimal;
        QtyPerWc: Decimal;
        WasteWaterAmount: Decimal;
        WaterConsumptionAmount: Decimal;
    begin
        GeneralLedgerSetup.GET();
        GeneralLedgerSetup.TESTFIELD("Energy Dim. Code FND");
        GeneralLedgerSetup.TESTFIELD("Maintenance Dim. Code FND");
        GeneralLedgerSetup.TESTFIELD("Waste Water Dim. Code FND");
        GeneralLedgerSetup.TESTFIELD("Water Consump Dim. Code FND");

        GeneralLedgerSetup.TESTFIELD("Gl Budget Standard Cost FND");

        WorkCenter.RESET();
        if WorkCenter.findset() then
            repeat
                QtyPerWc += (((ProdForecastQtyHL / WorkCenter.Capacity) * BOMBuffer."Qty. per Top Item") * WorkCenter."Estimated Energy FND");
                QtyPerWasteWater += (((ProdForecastQtyHL / WorkCenter.Capacity) * BOMBuffer."Qty. per Top Item") * WorkCenter."Other Variable Expenses FND");
                QtyPerWaterConsumption += (((ProdForecastQtyHL / WorkCenter.Capacity) * BOMBuffer."Qty. per Top Item") * WorkCenter."Estimated Water Consmp. FND");
                QtyPerMaintenance += (((ProdForecastQtyHL / WorkCenter.Capacity) * BOMBuffer."Qty. per Top Item") * WorkCenter."Production Fix Expenses FND");
            until WorkCenter.NEXT() = 0;

        GLBudgetEntry.RESET();
        GLBudgetEntry.SETRANGE(Date, DateFilter);
        GLBudgetEntry.SETRANGE("Budget Dimension 1 Code", GeneralLedgerSetup."Energy Dim. Code FND");
        GLBudgetEntry.SETRANGE("Budget Name", GeneralLedgerSetup."Gl Budget Standard Cost FND");//HEI.02
        GLBudgetEntry.CALCSUMS(Amount);
        EnergyAmount := GLBudgetEntry.Amount / QtyPerWc;

        GLBudgetEntry.SETRANGE("Budget Dimension 1 Code", GeneralLedgerSetup."Maintenance Dim. Code FND");
        GLBudgetEntry.CALCSUMS(Amount);
        MaintenanceAmount := GLBudgetEntry.Amount / QtyPerMaintenance;

        GLBudgetEntry.SETRANGE("Budget Dimension 1 Code", GeneralLedgerSetup."Waste Water Dim. Code FND");
        GLBudgetEntry.CALCSUMS(Amount);
        WasteWaterAmount := GLBudgetEntry.Amount / QtyPerWasteWater;

        GLBudgetEntry.SETRANGE("Budget Dimension 1 Code", GeneralLedgerSetup."Water Consump Dim. Code FND");
        GLBudgetEntry.CALCSUMS(Amount);
        WaterConsumptionAmount := GLBudgetEntry.Amount / QtyPerWaterConsumption;


        //EXIT(GLBudgetEntry.Amount/QtyPerWc);
        exit(EnergyAmount + MaintenanceAmount + WaterConsumptionAmount + WasteWaterAmount);
    end;

    local procedure InitStandartCostWorksheet(ItemNo: Code[20]; NewStardardCost: Decimal; LocationCode: Code[20]);
    var
        StandardCostWorksheet: Record "Standard Cost Worksheet";
    begin
        /*
        StandardCostWorksheet.RESET;
        StandardCostWorksheet.SETRANGE("Standard Cost Worksheet Name",'DEFAULT');
        IF StandardCostWorksheet.FINDFIRST THEN
          IF CONFIRM(Text003) THEN
            StandardCostWorksheet.DELETEALL;
        */
        StandardCostWorksheet.RESET();
        StandardCostWorksheet.INIT();
        StandardCostWorksheet.VALIDATE("Standard Cost Worksheet Name", 'DEFAULT');
        StandardCostWorksheet.VALIDATE(Type, StandardCostWorksheet.Type::Item);
        StandardCostWorksheet.VALIDATE("No.", ItemNo);
        //StandardCostWorksheet.VALIDATE("Location Code", LocationCode);//BC Upgrade Manisha Drink it code commented
        StandardCostWorksheet.VALIDATE("New Standard Cost", NewStardardCost);
        StandardCostWorksheet.INSERT();

    end;

    procedure SetParam(ProductionForecastName: Code[20]; LocationFIlter: Code[20]; DateFilterTxt: Text);
    var
        FilterTokenCU: Codeunit "Filter Tokens";//Manisha BC Upgrade New Variable added to replace Application Management
    begin
        if ProductionForecastName = '' then
            ERROR(Text002, ProductionForecastName);
        if LocationFIlter = '' then
            ERROR(Text002, LocationFIlter);
        if DateFilterTxt = '' then
            ERROR(Text002, DateFilterTxt);

        ProdForecastName := ProductionForecastName;
        LocFilter := LocationFIlter;

        //if ApplicationManagement.MakeDateFilter(DateFilterTxt) = 0 then; //Manisha BC Upgrade function CU changed.
        FilterTokenCU.MakeDateFilter(DateFilterTxt); //Manisha BC Upgrade
        if DateFilterTxt = '' then;//Manisha BC Upgrade
        EVALUATE(DateFilter, DateFilterTxt);
    end;

}

