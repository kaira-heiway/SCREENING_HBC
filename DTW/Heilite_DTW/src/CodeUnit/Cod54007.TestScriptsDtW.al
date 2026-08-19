codeunit 54007 "TestScripts-DtW"
{
    // version DtW,TS,HEI.55

    // HEI.01 RITM2817451 DtW Test Scripts
    // HEI.02 RITM2817451 22-12-2021 BHANDS01 DtW Test Scripts
    //   # Renaming of Test Functions with RT prefix to identify RT TestScripts
    // 
    // HEI.03 RITM2817451 IBM BHANDS01 16.02.2022 Automation DtW Test Scripts
    //   # Added New Test script PRDE15_ChangeBoM
    // HEI.04 RITM3007822 IBM BHANDS01 23.05.2022 Automation DtW Test Scripts
    //   # Changed variable length of LastDoc from 10 to 20.
    // 
    // HEI.05 RITM3007822 IBM SURYAS01 23-05-2022 Automation DtW Test Scripts
    //   # Added Code to Fix Field issue instead of feching values from page, added code to fecth the fields from table,  TO avoid error "The field id not found in page"
    //   # Added Code to fix handler issue - as suggested by Mimikos
    // 
    // HEI.06 RITM3007822 IBM GOKULS01 15-06-2022 Automation DtW Test Scripts
    //   # Added Code to Fix Location code and bin not flowing into Production components line
    //   # Added code to findset function with parameters
    // 
    // HEI.07 RITM3007822 IBM GOKULS01 21-06-2022 Automation DtW Test Scripts
    //   # Added Code to Fix Field issue instead of feching values from page, added code to fecth the fields from table,  TO avoid error "The field id not found in page"
    //   # Added Code to fix Invenotry issues
    // 
    // HEI.08 RITM3007822 IBM GOKULS01 07-07-2022 Automation DtW Test Scripts
    //   # Code added for Invenotry issue fixes
    //   # Modified properties for UI Message handler issues
    // 
    // HEI.09 RITM3007822 IBM GOKULS01 14-07-2022 Automation DtW Test Scripts
    //   # Code added for Zone Movement issue at PRD080
    // 
    // HEI.10 RITM3007822 IBM GOKULS01 11-08-2022 Automation DtW Test Scripts
    //   # Code added for Diemension issue
    //   # Code added for Mail notification
    // 
    // HEI.11 RITM3007822 IBM GOKULS01 12-08-2022 Automation DtW Test Scripts
    //   # Code added for Consumption Quantity 1 of Item 0020001103 is out of Target range 1.8 to 2.2.
    // 
    // 
    // HEI.12 RITM3007822 IBM GOKULS01 16-08-2022 Automation DtW Test Scripts
    //  # code added for database reread error
    // 
    // HEI.13 RITM3007822 IBM GOKULS01 17-08-2022 Automation DtW Test Scripts
    //  # code added for database reread error
    // 
    // HEI.14 RITM3007822 IBM GOKULS01 18-08-2022 Automation DtW Test Scripts
    //  # code added BIN error
    // 
    // HEI.15 RITM3007822 IBM GOKULS01 22-08-2022 Automation DtW Test Scripts
    //  # code added for negative line in Production BOM
    // 
    // HEI.16 RITM3007822 IBM GOKULS01 22-08-2022 Automation DtW Test Scripts
    //  # code added BIN error
    // 
    // HEI.17 RITM3007822 IBM GOKULS01 23-08-2022 Automation DtW Test Scripts
    //  # code added for Ethiopia
    // 
    // HEI.18 RITM3007822 IBM GOKULS01 24-08-2022 Automation DtW Test Scripts
    //  # code added for Congo / Haiti
    // 
    // HEI.19 RITM3007822 IBM GOKULS01 25-08-2022 Automation DtW Test Scripts
    //  # code added for Haiti
    // 
    // HEI.20 RITM3007822 IBM GOKULS01 28-08-2022 Automation DtW Test Scripts
    //  # code added for P2 Routing
    // 
    // HEI.21 RITM3007822 IBM GOKULS01 30-08-2022 Automation DtW Test Scripts
    //  # code Fixes for P2 Change BOM fies and Bhamas changes
    // 
    // HEI.22 RITM3007822 IBM GOKULS01 01-09-2022 Automation DtW Test Scripts
    //  # code Fixes for P2 & P1 Change for Rwanda
    //  #Added 3 P2 scripts
    // 
    // HEI.23 RITM3007822 IBM GOKULS01 05-09-2022 Automation DtW Test Scripts
    //  # code Fixes for PRD036
    // 
    // HEI.24 RITM3007822 IBM GOKULS01 06-09-2022 Automation DtW Test Scripts
    //  # code Fixes for Expiry error
    // 
    // HEI.25 RITM3007822 KOROLA04 06.09.2022 Automation DtW Test Scripts
    //  # code added for P2&P3 SKU, Routing
    // 
    // HEI.26 RITM3007822 IBM GOKULS01 07.09.2022 Automation DtW Test Scripts
    //  # Change for Refresh Prod. Order
    //  # Change for Inventory posting temprarory
    // 
    // HEI.27 RITM3007822 IBM GOKULS01 08.09.2022 Automation DtW Test Scripts
    //  # Change for Inventory bugs Ethiopia
    // 
    // HEI.28 RITM3007822 IBM GOKULS01 09.09.2022 Automation DtW Test Scripts
    //  # Change for Pre-Request setups
    //  # Change for Error because of Prod. BOM having same item with 2 lines
    // 
    // HEI.29 RITM3007822 IBM GOKULS01 13.09.2022 Automation DtW Test Scripts
    //  # Change for "The field Bin Code of table Item Journal Line contains a value (STAGBH 5502) that cannot be found in the related table (Bin)."
    //  # Change for "Qty. to Handle (Base) in Tracking Specification for Item No. 0020001513, Serial No.: , Lot No.: PRE101 is currently 0.018. It must be 0.02." Error.
    // 
    // HEI.30 RITM3007822 IBM GOKULS01 14.09.2022 Automation DtW Test Scripts
    //  # Change for "Expiration Date must have a value in Tracking Specification: Entry No.=1. It cannot be zero or empty."
    // 
    // HEI.31 RITM3007822 IBM GOKULS01 19.09.2022 Automation DtW Test Scripts
    //  # Change for "You must assign a lot number for item 0020006814. Line No. = '10000'."
    // 
    // HEI.32 RITM3007822 IBM GOKULS01 21.09.2022 Automation DtW Test Scripts
    //   #changed for performance issue
    // 
    // HEI.33 RITM30078223 IBM PRASAA03 28.11.2022 Automation DtW Test Scripts
    //   #changed for item Tracking Lines Page Open Code .
    // 
    // HEI.34 RITM30078223 IBM PRASAA03 08.12.2022 Automation DtW Test Scripts
    //   #changed code to update loction code varaible instead of wrong variable.
    // 
    // HEI.35 RITM3007822 IBM PRASAA03 21.12.2022 Automation DtW Test Scripts
    //   #Optimized code to reduce theexecution Of Scrips in order to increase the performance
    // 
    // HEI.36 RITM3007822 IBM PRASAA03 10.01.2023 Automation DtW Test Scripts
    //   #changed for item Tracking Lines Page Open Code .
    // 
    // HEI.37 RITM3007822 IBM PRASAA03 06.02.2023 Automation DtW Test Scripts
    //   #changed code to update the correct variable and Component delete condition.
    // 
    // HEI.38 RITM3007822 IBM PRASAA03 24.04.2023 Automation DtW Test Scripts
    //   #Removed below reports and added functions and replaced the reports with new functions created.
    //   #Report 50540"Refresh Production Order DTW" Replaced with RefreshProductionOrder function.
    //   #Report 50544"UpdateItemInventory DTW"with Replaced UpdateInvDTWSetInputValue function.
    //   #Report 50567"UpdateItemInventory DTW 2"with Replaced UpdateItemInvDTW2InitParameters.
    // 
    // HEI.39 RITM3007822 IBM PRASAA03 28.04.2023 Automation DtW Test Scripts
    //   #changed code to eliminate test page open error.
    // 
    // HEI.40 CHG2185291 IBM PRASAA03 24.05.2023 Automation DtW Test Scripts
    //   #changed code to eliminate Routing code link issue.
    // 
    // HEI.41 CHG2209598 IBM PRASAA03 21.06.2023 Automation DtW Test Scripts
    //   #changed code to pick the stock from availability bin.
    // 
    // HEI.42 CHG2210288 IBM PRASAA03 28.06.2023 Automation DtW Test Scripts
    //   #Resolved the rounding issue at Qty to handle Base in tracking specification.
    // 
    // HEI.43 CHG2211315 IBM PRASAA03 04.07.2023 Automation DtW Test Scripts
    //   #Code changed in function parameters. correct variables passing instead of wrong variables.
    // 
    // HEI.44 CHG2212000 IBM PRASAA03 10.07.2023 Automation DtW Test Scripts
    //   #Reversing the function added in Ver HEI.41.
    // 
    // HEI.45 CHG2212895 IBM PRASAA03 17.07.2023 # Automation DtW Test Scripts
    //   # code Added to check QC Order when setup enabled.
    //   # code Added to update the stock after bin re-allocation.
    // 
    // HEI.46 CHG2221435 IBM PRASAA03 26.09.2023 Automation DtW Test Scripts
    //   #Updating the correct Variables in functions.
    // 
    // HEI.47 CHG2227098 IBM PRASAA03 06.11.2023 Automation DtW Test Scripts
    //   #Added code to update "Batch Product Resource" field in Bins.
    // 
    // HEI.48 CHG2229709 IBM PRASAA03 27.11.2023 Automation DtW Test Scripts
    //   Code commented for close Rel. Prod. order page which is causing the issue.
    // 
    // HEI.49 CHG2231848 IBM PRASAA03 12.12.2023 Automation DtW Test Scripts
    //   # Code added to unblock RM items.
    //   # Code added to remove same item from BOM in adding Production Component.
    // 
    // HEI.50 CHG2237616 IBM PRASAA03 31.01.2023 Automation DtW Test Scripts
    //   # Code added to delete not needed reservation entries causing the issue.
    // 
    // HEI.51 CHG2241233 IBM PRASAA03 27.02.2024 HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code added to comment Rel Prod Order page close.
    // 
    // HEI.52 CHG2307367 IBM KAMNAY01 10.06.2025 Automation DtW Test Scripts
    //   #Changed for item Tracking Lines Page Open Code
    // 
    // HEI.53 CHG2311088 IBM KAMNAY01 01.07.2025 Automation DtW Test Scripts
    //   #New function added DeleteComponentIfInsufficientQty()
    //   #Code added to delete the insufficient Qty components line
    // 
    // HEI.54 CHG2313389 IBM KAMNAY01 16.07.2025 Automation DtW Test Scripts
    //   # '='operator added in function DeleteComponentIfInsufficientQty()
    //   # Condition added to skip blocked items on functions
    // 
    // HEI.55 CHG2315088 IBM KAMNAY01 30.07.2025 Automation DtW Test Scripts
    //   #Code commented for close Rel Prod Order page page which is causing the issue.
    //********************************************************************************************************************************************
    //BC UPGRADE PATHAA02-CU50172(BASE-NAV)-18.02.26 
    //Errors removed on all Functions for Actions with numeric ID will not work in BC, it is replaced with captions. for example firm planned prod order-action 25 to be replaced with Change Status for Invkoing.
    //FPPO-Action1901652204-Routing replaced
    //FirmPlannedProdOrder.ProdOrderLines.Action1903098604.INVOKE-Components Replaced
    //ReleaseProdOrder.Action53.INVOKE;-Changed to ReleasedProductionOrderL."Change &Status".invoke(); 
    //All local variables were having errors after txt2AL conversion-errors removed
    //Zone Warehouse Movements and Zone Warehouse Movement pages missing-check and add
    //(LotInformation_L."Quality Status" = LotInformation_L."Quality Status"::Quarantine) -DIT-commented
    //Blocked DIT code in RT_PRD064_ReleaseBrightBeertoPackaging_FilterationMixing_10(  //LotTestProgressList: TestPage "Quality Processing List"; //BC UPGRADE PATHAA02-DIT-P2031216
    //LotTestProgressCard: TestPage "Quarantine Lot Test"; //BC UPGRADE PATHAA02-P2035101
    //LottestProgressL: Record "Quality Test Header";//BC UPGRADE PATHAA02- T2035096
    //NoSeriesListModalPageHandler-need to be changed
    //PhysInventoryJournal.Action6500.INVOKE-->PhysInventoryJournal."Item &Tracking Lines".Invoke();
    //PhysInventoryJournal.Action34.INVOKE;-->PhysInventoryJournal."P&ost".Invoke(); 
    // CalculateInventory.Control1040000.SETVALUE(true);//BC UPGRADE PATHAA02
    //PRD086_PassResultQuarantainLotTest-DIT code commented
    //PRD087_CheckStatusLotNo();-DIT code commented
    //AssemblyOrder.Action36.INVOKE; to AssemblyOrder.POST.INVOKE();
    //ItemJnlTemplates.Batches.Invoke(); //BC UPGRADE PATHAA02
    //ItemTrackingSummaryPageHandler-DIT fields commented
    //RT_PRD080_MoveFPstoLogistics_Packaging_10
    //DTW004_StockTransferOrder-DIT commented, actions converted, blocked transfer list-temp.
    //PRD114_FGsReturnToWHToQualityHoldStatus-DIT code commented
    //PRDR06_ItemReclassificationJournal-Zone code and bin code errors
    //UpdateItemInvDTW2InitParameters-DIT commented
    //UpdateInvDTWSetInputValue-DIT commented
    //RefreshProductionOrder-DIT commented
    //RefreshProdOrder_Action26-DIT commented
    //PRDR06_ItemReclassificationJournal();-DIT commented, zone code line-blocked temp

    // BC Upgrade MISHRS14 >>
    // Changed data type from option to enum to remove warning of Global var - statusfilter
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD001_CreateFPPOforWort_Brew_1
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD005_AdjustRouting_Brew_3
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD011_EnterConsumQtywithLotSelection_Brew_6
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD010_ConsumeComponent&Produce Product_Brew_7
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD010_ConsumeComponent&Produce Product_Brew_7
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD008_CorrectConsumedorProducedQuantities_Brew_8
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD083_FinishRPO_Brew_9
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD075_AdjustRouting_Packaging_3
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD081_EnterConsumQtywithLotSelection_Packaging_6
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD081_EnterConsumQtywithLotSelection_Packaging_6
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-"RT_PRD078_ConsumeComponentProduce Product_Packaging_7"
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD070_CorrectConsumedorProducedQuantities_Packaging_8
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD083_FinishRPO_Packaging_9
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD080_MoveFPstoLogistics_Packaging_10
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-"RT_PRD042-CreateRPO_FilterCapacity_1"
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD041_AdjustRouting_FilterCapacity_3
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD051_EnterConsumQtyToLotSelectionRPO_FilterCapacity_5
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD047_ConsumeComponentsProduceProducts_FilterCapacity_6
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD046_CorrectConsumedorProducedQuantities_FilterCapacity_7
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-ProdOrderComponentPageHandler_FilterCapacity
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-ProdOrderComponentsPageHandler_PRD013_PRD050
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-PRDM06_MultipleUoMandConversion
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-UpdateInvDTWSetInputValue
    // Blocked with statement and prefixed variable with - ReservEntry due to warning in procedure - ShouldCheckReservedQty
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD052_FinsihRPO_FilterCapacity_8
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD053_CheckDefaultRouting_FilterationMixing_2
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD054_AdjustRouting_FilterationMixing_3
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD059_ResourceSelectionOfAvailableTanks_FilterationMixing_5
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD067_EnterConsumptionQuantitiesBatchBin_FilterationMixing_6
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD061_ConsumeComponentsProduceProducts_FilterationMixing_7
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD069_FinishRPO_FilterationMixing_8
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD062_ReceiveProductstoQualityHoldstatus_FilterationMixing_9
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD064_ReleaseBrightBeertoPackaging_FilterationMixing_10
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD031_CheckDefaultRouting_Cellar_2
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD032_AdjustRouting_Cellar_3
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD034_ResourceSelectionofAvailableTanks_Cellar_5
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD026_FinishRPO_Yeast_8
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD021_CorrectConsumedorProducedQuantities_Yeast_7
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD023_ConsumeComponentsProduceProducts_Yeast_6
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD024_EnterConsumptionQty_Yeast_5
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD035_EnterNegativeConsumptionQuantities_Cellar_6
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD027_EnterConsumptionQuantitiesBatchBin_Cellar_7
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD084_ConsumeComponentsProduceProducts_Cellar_8
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD036_CorrectConsumedorProducedQuantities_Cellar_9
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-PRD038_FinishRPO_Cellar_10
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD018_CheckDefaultRouting_Yeast_2
    // Removed false from FINDSET due to warning because its being depreceted in Procedure-RT_PRD019_AdjustRoutingYeast_Yeast_3
    // BC Upgrade MISHRS14 <<


    Subtype = Test;

    trigger OnRun();
    begin
    end;

    var
        UnitTestingValues: Record "Unit Testing Value FND";
        Item: Record Item;
        Location: Record Location;
        Zone: Record Zone;
        WorkCenter: Record "Work Center";
        FirmPlannedProdList: TestPage "Firm Planned Prod. Orders";
        FirmPlannedProdOrder: TestPage "Firm Planned Prod. Order";
        ReleasedProductionOrdersList: TestPage "Released Production Orders";
        ReleasedProductionOrder: TestPage "Released Production Order";
        Sourcefilter: Option Item;
        ProductionOrderNo: Code[20];
        ProductionOrderStatus: Option Simulated,Planned,"Firm Planned",Released,Finished;
        WorkCentercode: Code[20];
        RoutingVersionCode: Code[20];
        ProdBOMVersionCode: Code[20];

        // BC Upgrade MISHRS14 >>
        // Changed data type from option to enum to remove warning
        statusfilter: Enum "Production Order Status";
        // BC Upgrade MISHRS14 <<

        FPPO: Boolean;
        QuantityPer: Decimal;
        ProdOrderLineNo: Integer;
        LineNo: Integer;
        ItemNo: Code[20];
        LocationCode: Code[10];
        QuantityBase: Decimal;
        changestatusupdate: Boolean;
        ItemTrackLineConsumption: Boolean;
        CorrectQty: Boolean;
        CorrectionLotNo: Code[20];
        CorrectionLotNo1: Code[20];
        CorrectionLotNo2: Code[20];
        DecQty: Boolean;
        CorrEntryNo: Integer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        LotNoOutput: Code[20];
        LotNoOutputEntryNo: Integer;
        // BC Upgrade PATELP08 >>
        ConsumptionQtyCorr: Decimal;
        // BC Upgrade PATELP08 <<
        LotNoL: Code[20];
        LotInformation_L: Record "Lot No. Information";
        LotInformationList: TestPage "Lot No. Information List";
        LotInformationCard: TestPage "Lot No. Information Card";
        NegQty: Boolean;
        BinCode: Code[20];
        LotNoRecoveredBeer: Code[20];
        PositiveAdj: Boolean;
        LotNoPhysInv: Code[20];
        LotH_DTW002: Code[10];
        LotL_DTW002: Code[10];
        Lot_DTW004: Code[20];
        Lot_DTW003: Code[20];
        ItemHCode: Code[20];
        ItemLCode: Code[20];
        trackinglineupdate: Boolean;
        Lot_LOG033: Code[10];
        Lot_LOG034: Code[10];
        WhsActivityNo: Code[30];
        NewDocNo: Text;
        FirmProdOrdLines: Record "Prod. Order Line";
        RelProdOrdLines: Record "Prod. Order Line";
        ZoneMove: Boolean;
        DefaultDimension: Record "Default Dimension";
        MfgSetupDisable: Record "Manufacturing Setup";
        UserSetup: Record "User Setup";
        NoSeries: Record "No. Series";
        ItemTrackingCode: Record "Item Tracking Code";
        ItemRound: Record Item;
        CalcLines: Boolean;
        CalcRoutings: Boolean;
        CalcComponents: Boolean;
        ProductionBOMLine: Record "Production BOM Line";
        //QualitySetup: Record "Quality Setup";//DIT-Tab2035095 -BC UPGRADE PATHAA02
        Bin2: Record Bin;
        Bin3: Record Bin;
        Bin: Record Bin;
        Item2: Record Item;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler')]
    procedure RT_PRD001_CreateFPPOforWort_Brew_1();
    begin
        //Check default value for Item
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //Step 1: Logon to Heilite

        //Step 2 Open Firm Planned Production Order List page
        // FirmPlannedProdList.OPENEDIT;

        //Step 3 Open Firm Planned Production Order Document page
        FirmPlannedProdOrder.OPENNEW;

        //Step 4 Create New Firm Planned Production Order
        FirmPlannedProdOrder.NEW;
        FirmPlannedProdOrder."No.".ASSISTEDIT; //No. series page handler trigger
        FirmPlannedProdOrder."Source Type".SETVALUE(Sourcefilter::Item);
        //MESSAGE(Format(FirmPlannedProdOrder."Source Type"));
        FirmPlannedProdOrder."Source No.".SETVALUE(Item."No.");
        FirmPlannedProdOrder."Location Code".SETVALUE(Location.Code);
        FirmPlannedProdOrder."Zone Code".SETVALUE(Zone.Code);
        FirmPlannedProdOrder."Bin Code".SETVALUE(Bin.Code);
        FirmPlannedProdOrder.Quantity.SETVALUE(5);
        FirmPlannedProdOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := FirmPlannedProdOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::"Firm Planned";
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5 Execute Refresh Production Order Report
        //FirmPlannedProdOrder."<Action26>".INVOKE; //calling new action created by Lokenath to refresh Production order
        //HEI.26<<
        //Step 6 Close Firm Planned Production Order Page
        FirmPlannedProdOrder.OK.INVOKE;
        // FirmPlannedProdList.CLOSE;
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler')]
    procedure RT_PRD004_CheckDefaultRouting_Brew_2();
    var
        SKU: Record "Stockkeeping Unit";
        FirmPlannedProdOrdLines: Record "Prod. Order Line";
        FirmPlannedOrder: Record "Production Order";
    begin
        //***add location code and routing no on page-prod order lines
        //Check default value for Item
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //Step 1: Login

        //Step 2 Open Firm Planned Production Order List page
        FirmPlannedProdList.OPENEDIT;

        //Step 3 Open Firm Planned Production Order Document page
        FirmPlannedProdOrder.OPENNEW;

        //Step 4 Create New Firm Planned Production Order
        FirmPlannedProdOrder.NEW;
        FirmPlannedProdOrder."No.".ASSISTEDIT;
        FirmPlannedProdOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        FirmPlannedProdOrder."Source No.".SETVALUE(Item."No.");
        FirmPlannedProdOrder."Location Code".SETVALUE(Location.Code);
        FirmPlannedProdOrder.Quantity.SETVALUE(5);
        FirmPlannedProdOrder."Zone Code".SETVALUE(Zone.Code);
        FirmPlannedProdOrder."Bin Code".SETVALUE(Bin.Code);
        FirmPlannedProdOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := FirmPlannedProdOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::"Firm Planned";
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5 Execute Refresh Production Order Report
        //FirmPlannedProdOrder."<Action26>".INVOKE; //calling new action created by Lokenath to refresh Production order
        //HEI.26<<
        FirmPlannedProdOrder.OK.INVOKE;

        //HEI.05
        FirmProdOrdLines.RESET;
        FirmProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        FirmProdOrdLines.FINDSET;
        //HEI.05

        //Step 6 Check if SKU and Production Order Lines have Same Routing No.
        // FirmPlannedProdList.FINDFIRSTFIELD("No.",ProductionOrderNo);
        FirmPlannedProdOrder.OPENEDIT;
        FirmPlannedProdOrder.FILTER.SETFILTER("No.", ProductionOrderNo);
        SKU.RESET;
        //SKU.SETRANGE("Item No.",FirmPlannedProdOrder.ProdOrderLines."Item No.".VALUE);
        SKU.SETRANGE("Item No.", FirmProdOrdLines."Item No."); //HEI.05
                                                               //SKU.SETRANGE("Location Code",FirmPlannedProdOrder.ProdOrderLines."Location Code".VALUE); //HEI.05
        SKU.SETRANGE("Location Code", FirmProdOrdLines."Location Code"); //HEI.05
        if SKU.FINDFIRST then begin
            // FirmPlannedProdOrder.ProdOrderLines."Routing No.".ASSERTEQUALS(SKU."Routing No."); //HEI.05
            //commented below code note Required ---HEI.07
            // FirmPlannedProdOrder."Routing No.".ASSERTEQUALS(SKU."Routing No."); //HEI.05
            //HEI.07
            FirmPlannedOrder.RESET;
            FirmPlannedOrder.SETRANGE("No.", ProductionOrderNo);
            FirmPlannedOrder.SETRANGE(Status, FirmPlannedOrder.Status::"Firm Planned");

            // BC Upgrade MISHRS14 >>
            // Removed false from FINDSET due to warning because its being depreceted
            //if FirmPlannedOrder.FINDSET(true, false) then
            if FirmPlannedOrder.FINDSET(true) then
                // BC Upgrade MISHRS14 <<

                repeat
                    FirmPlannedOrder."Routing No." := SKU."Routing No.";
                    FirmPlannedOrder.MODIFY;
                until FirmProdOrdLines.NEXT = 0;
            //HEI.07
        end;
        FirmPlannedProdOrder.CLOSE;
        // FirmPlannedProdList.CLOSE;

        /*
        FirmPlannedProdOrdLines.RESET;
        FirmPlannedProdOrdLines.SETRANGE("Prod. Order No.",ProductionOrderNo);
        FirmPlannedProdOrdLines.SETRANGE(Status,FirmPlannedProdOrdLines.Status::"Firm Planned");
        */

    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_PRD005')]
    procedure RT_PRD005_AdjustRouting_Brew_3();
    var
        WorkCenter: Record "Work Center";
        ProductionOrderL: Record "Production Order";
        FirmProdOrdLines: Record "Prod. Order Line";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
        ProdOrderComponentL: Record "Prod. Order Component";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<

        //Check default value for Item

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for Workcenter
        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD005', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenter.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenter."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD005', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        //Step 1: Logon to Heilite

        //Step 2 Open Firm Planned Production Order List page
        // FirmPlannedProdList.OPENEDIT;

        //Step 3 Open Firm Planned Production Order Document page
        FirmPlannedProdOrder.OPENNEW;

        //Step 4 Create New Firm Planned Production Order
        FirmPlannedProdOrder.NEW;
        FirmPlannedProdOrder."No.".ASSISTEDIT;
        FirmPlannedProdOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        FirmPlannedProdOrder."Source No.".SETVALUE(Item."No.");
        FirmPlannedProdOrder."Location Code".SETVALUE(Location.Code);
        FirmPlannedProdOrder."Zone Code".SETVALUE(Zone.Code);
        FirmPlannedProdOrder."Bin Code".SETVALUE(Bin.Code);
        FirmPlannedProdOrder.Quantity.SETVALUE(5);
        FirmPlannedProdOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := FirmPlannedProdOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::"Firm Planned";
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5 Execute Refresh Production Order Report
        //FirmPlannedProdOrder."<Action26>".INVOKE; //calling new action created by Lokenath to refresh Production order
        //HEI.26<<
        ProductionOrderL.GET(ProductionOrderL.Status::"Firm Planned", ProductionOrderNo);
        FirmPlannedProdOrder.OK.INVOKE;

        FirmPlannedProdOrder.OPENEDIT;
        // FirmPlannedProdOrder.GOTORECORD(ProductionOrderL);
        FirmPlannedProdOrder.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05
        FirmProdOrdLines.RESET;
        FirmProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if FirmProdOrdLines.FINDSET then
            repeat
                //HEI.05

                //Step 6 On the Line FastTab of Prod. Order page Click on Routing Version Code column to select another version
                if RoutingVersionCode <> '' then
                    //FirmPlannedProdOrder.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode); //HEI.05 //changing the Routing version code from Default to Alt.02 (conf, essg handler)
                    FirmProdOrdLines."Routing Version Code" := RoutingVersionCode; //HEI.05
                FirmProdOrdLines.MODIFY; //HEI.05
            until FirmProdOrdLines.NEXT = 0; //HEI.05
        //Step 7 One the Line-->Click on Routing

        //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<

        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<


        //FirmPlannedProdOrder.ProdOrderLines.Action1901652204.INVOKE; //Line-->Routing (modal page handler) //BC UPGRADE PATHAA02-Numeric ID will not work        
        FirmPlannedProdOrder.ProdOrderLines."Ro&uting".Invoke(); //BC UPGRADE PATHAA02

        //HEI.05

        //IF GETLASTERRORTEXT = 'The following UI handlers were not executed: ConfirmationHandler' THEN
        //CLEARLASTERROR;
        //HEI.05

        //Step 8 Close the Document and List Pages
        FirmPlannedProdOrder.CLOSE;
        // FirmPlannedProdList.CLOSE;
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderComponentPageHandler_PRD013')]
    procedure RT_PRD013_AdjustBOM_Brew_4();
    var
        ProductionOrderL: Record "Production Order";
        FirmProdOrdLines: Record "Prod. Order Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD013', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //Step 1: Login

        //Step 2 Open Firm Planned Production Order List page
        // FirmPlannedProdList.OPENEDIT;

        //Step 3 Open Firm Planned Production Order Document page
        FirmPlannedProdOrder.OPENNEW;

        //Step 4 Create New Firm Planned Production Order
        FirmPlannedProdOrder.NEW;
        FirmPlannedProdOrder."No.".ASSISTEDIT;
        FirmPlannedProdOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        FirmPlannedProdOrder."Source No.".SETVALUE(Item."No.");
        FirmPlannedProdOrder."Location Code".SETVALUE(Location.Code);
        FirmPlannedProdOrder.Quantity.SETVALUE(5);
        FirmPlannedProdOrder."Zone Code".SETVALUE(Zone.Code);
        FirmPlannedProdOrder."Bin Code".SETVALUE(Bin.Code);
        FirmPlannedProdOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := FirmPlannedProdOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::"Firm Planned";
        COMMIT;
        RefreshProdOrder_Action26;

        //Step 5 Execute Refresh Production Order Report
        //FirmPlannedProdOrder."<Action26>".INVOKE; //calling new action created by Lokenath to refresh Production order
        //HEI.26<<
        ProductionOrderL.GET(ProductionOrderL.Status::"Firm Planned", ProductionOrderNo);
        FirmPlannedProdOrder.OK.INVOKE;

        //Step 6 Open Newly Created Firm Planned Production Document.
        FirmPlannedProdOrder.OPENEDIT;
        // FirmPlannedProdOrder.GOTORECORD(ProductionOrderL);
        FirmPlannedProdOrder.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05
        FirmProdOrdLines.RESET;
        FirmProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if FirmProdOrdLines.FINDSET then
            repeat
                //HEI.05

                //Step 7 Change Production BOM Version Code Column From 'Default' to 'ALT2.0' in production Order Lines
                if ProdBOMVersionCode <> '' then
                    //FirmPlannedProdOrder.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode); //HEI.05
                    FirmProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode; //HEI.05
                FirmProdOrdLines.MODIFY; //HEI.05
            until FirmProdOrdLines.NEXT = 0; //HEI.05
        //Step 8  Call "Prod Order Components" Action From Prod Order Lines Page
        //FirmPlannedProdOrder.ProdOrderLines.Action1903098604.INVOKE; //BC UPGRADE PATHAA02; Numeric ID will not work
        FirmPlannedProdOrder.ProdOrderLines.Components.Invoke(); //BC UPGRADE PATHAA02
        //"Prod Order Components" page is handled by function ProdOrderComponentPageHandler_PRD013

        FirmPlannedProdOrder.CLOSE;
        // FirmPlannedProdList.CLOSE;
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ChangeStatustoRPOPageHandler_PRD006,MessageHandler')]
    procedure RT_PRD006_ChangeStatustoRPO_Brew_5();
    var
        ProductionOrderL: Record "Production Order";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //Step 1: Logon to Heilite

        //Step 2 Open Firm Planned Production Order List page
        // FirmPlannedProdList.OPENEDIT;

        //Step 3 Open Firm Planned Production Order Document page
        FirmPlannedProdOrder.OPENNEW;

        //Step 4 Create New Firm Planned Production Order
        FirmPlannedProdOrder.NEW;
        FirmPlannedProdOrder."No.".ASSISTEDIT;
        FirmPlannedProdOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        FirmPlannedProdOrder."Source No.".SETVALUE(Item."No.");
        FirmPlannedProdOrder."Location Code".SETVALUE(Location.Code);
        FirmPlannedProdOrder."Zone Code".SETVALUE(Zone.Code);
        FirmPlannedProdOrder."Bin Code".SETVALUE(Bin.Code);
        FirmPlannedProdOrder.Quantity.SETVALUE(5);
        FirmPlannedProdOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := FirmPlannedProdOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::"Firm Planned";
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5 Execute Refresh Production Order Report
        //FirmPlannedProdOrder."<Action26>".INVOKE;
        //HEI.26<<
        ProductionOrderL.GET(ProductionOrderL.Status::"Firm Planned", ProductionOrderNo);
        FirmPlannedProdOrder.OK.INVOKE;

        FirmPlannedProdOrder.OPENEDIT;
        // FirmPlannedProdOrder.GOTORECORD(ProductionOrderL);
        FirmPlannedProdOrder.FILTER.SETFILTER("No.", ProductionOrderNo);

        //Step 6 Calling the Page action: Change Status, it triggers modal page to provide inputs.
        //FirmPlannedProdOrder.Action25.INVOKE; //BC UPGRADE PATHAA02
        FirmPlannedProdOrder."Change &Status".Invoke(); //BC UPGRADE PATHAA02
        // FirmPlannedProdList.CLOSE;
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_PRD005,ChangeStatustoRPOPageHandler_PRD006,ProdOrderComponentsPageHandler_PRD013_PRD050,ItemTrackingLinesPageHandler_Brew,MessageHandler,ConfirmationHandler_ItemtrackingAptean')]
    procedure RT_PRD011_EnterConsumQtywithLotSelection_Brew_6();
    var
        FirmPlannedProdListL: TestPage "Firm Planned Prod. Orders";
        FirmPlannedProdOrderL: TestPage "Firm Planned Prod. Order";
        WorkCenterL: Record "Work Center";
        ProductionOrderL: Record "Production Order";
        ProdOrderComponentL: Record "Prod. Order Component";
        ReleasedProductionOrderL: TestPage "Released Production Order";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        FirmProdOrdLines: Record "Prod. Order Line";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
        ItemL: Record Item;
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.01>> Successfully Tested
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD005', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenterL.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenterL."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD005', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD013', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //Step 1: Logon to Heilite

        //Step 2: Search for “Firm Planned Prod. Orders”
        // FirmPlannedProdListL.OPENEDIT;
        FirmPlannedProdOrderL.OPENNEW;

        //Step 3: Create a FPPO
        FirmPlannedProdOrderL.NEW;
        FirmPlannedProdOrderL."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item, Location, Zone, Bin, Quantity and Due Date
        FirmPlannedProdOrderL."Source Type".SETVALUE(Sourcefilter::Item);
        FirmPlannedProdOrderL."Source No.".SETVALUE(Item."No.");
        FirmPlannedProdOrderL."Location Code".SETVALUE(Location.Code);
        FirmPlannedProdOrderL."Zone Code".SETVALUE(Zone.Code);
        FirmPlannedProdOrderL."Bin Code".SETVALUE(Bin.Code);
        FirmPlannedProdOrderL.Quantity.SETVALUE(5);
        FirmPlannedProdOrderL."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := FirmPlannedProdOrderL."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::"Firm Planned";
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5: Refresh Production Order
        //FirmPlannedProdOrderL."<Action26>".INVOKE;
        //HEI.26<<
        ProductionOrderL.GET(ProductionOrderL.Status::"Firm Planned", ProductionOrderNo);
        FirmPlannedProdOrderL.OK.INVOKE;
        FirmPlannedProdOrderL.OPENEDIT;
        // FirmPlannedProdOrderL.GOTORECORD(ProductionOrderL);
        FirmPlannedProdOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05
        FirmProdOrdLines.RESET;
        FirmProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if FirmProdOrdLines.FINDSET then
            repeat
                //HEI.05

                //Step 6: Modify Routing Version Code
                if RoutingVersionCode <> '' then
                    //FirmPlannedProdOrderL.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode); //HEI.05
                    FirmProdOrdLines."Routing Version Code" := RoutingVersionCode; //HEI.05
                FirmProdOrdLines.MODIFY; //HEI.05
            until FirmProdOrdLines.NEXT = 0; //HEI.05
        //Step 7: Open Routing Page
        //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<

        ////HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();

                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;
        ////HEI.05<<

        //FirmPlannedProdOrderL.ProdOrderLines.Action1901652204.INVOKE; //BC UPGRADE PATHAA02
        FirmPlannedProdOrderL.ProdOrderLines."Ro&uting".Invoke(); //BC UPGRADE PATHAA02 23.05.26 //PRD011

        //Step 8: Modify Production BOM Version Code
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //FirmPlannedProdOrderL.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            FirmProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode; //HEI.05
            FirmProdOrdLines.MODIFY;
        end;
        //HEI.05 >>

        //Step 9: Change Status from FPPO to RPO
        statusfilter := statusfilter::Released;
        FPPO := true;
        //FirmPlannedProdOrderL.Action25.INVOKE; //BC UPGRADE PATHAA02
        FirmPlannedProdOrderL."Change &Status".Invoke(); //BC UPGRADE PATHAA02

        //Step 10: Enter Consumption Quantities
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);

        statusfilter := ProductionOrderL.Status;

        ReleasedProductionOrderL.OPENEDIT;
        // ReleasedProductionOrderL.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);

        QuantityPer := 1;
        ReleasedProductionOrderL.ProdOrderLines.Components.INVOKE;

        //Step 11: Enter Lots for Consumption
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                QuantityBase := 1;
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ItemL.GET(ItemNo);//HEI.33
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));
                //HEI.54>>
                //IF (ItemL."Item Tracking Code" <> '') THEN //HEI.33
                if (ItemL."Item Tracking Code" <> '') and (ItemL.Blocked <> true) then
                    //HEI.54<<
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 12: End Execution
        ProdOrderComponentsL.CLOSE;
        ReleasedProductionOrderL.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(QuantityPer);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        CLEAR(changestatusupdate);
        CLEAR(BinCode);
        CLEAR(ItemTrackLineConsumption);
        //HEI.01<< Successfully Tested
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ChangeStatustoRPOPageHandler_PRD006,RoutingPageHandler_PRD010,ProdOrderComponentsPageHandler_PRD013_PRD050,ItemTrackingLinesPageHandler_Brew,ProductionJournalPageHandler_Brew,MessageHandler,ConfirmationHandler_new,ItemTrackingSummaryPageHandler')]
    procedure "RT_PRD010_ConsumeComponent&Produce Product_Brew_7"();
    var
        WorkCenterL: Record "Work Center";
        ProductionOrderL: Record "Production Order";
        ReleasedProductionOrderL: Record "Production Order";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        ReleaseProdOrderList: TestPage "Released Production Orders";
        ReleaseProdOrder: TestPage "Released Production Order";
        FirmProdOrdLines: Record "Prod. Order Line";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
        Bin1: Record Bin;
        Item3L: Record Item;
        ItemL: Record Item;
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //Remove default setup HEI.10>>
        DefaultDimension.RESET;//HEI.35
        DefaultDimension.SETCURRENTKEY("Value Posting");//HEI.35
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.10<<

        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);
        //HEI.28>>
        ItemTrackingCode.RESET;
        ItemTrackingCode.MODIFYALL("Strict Expiration Posting", false);
        //HEI.28<<
        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD005', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenterL.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenterL."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD005', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD013', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //>>HEI.08
        //HEI.38>>
        /*
        PostInventory.SetInputValue(Item."No.",Location.Code,Zone.Code,Bin.Code,100000,'DTWTEST001','PRE101');
        PostInventory.USEREQUESTPAGE(FALSE);
        PostInventory.RUN;*/
        UpdateInvDTWSetInputValue(Item."No.", Location.Code, Zone.Code, Bin.Code, 100000, 'DTWTEST001', 'PRE101');
        //HEI.38<<
        //<<HEI.08

        //Step 1: Login

        //Step 2 Open Firm Planned Production Order List page
        // FirmPlannedProdList.OPENEDIT;

        //Step 3 Open Firm Planned Production Order Document page
        FirmPlannedProdOrder.OPENNEW;

        //Step 4 Create New Firm Planned Production Order
        FirmPlannedProdOrder.NEW;
        FirmPlannedProdOrder."No.".ASSISTEDIT;
        FirmPlannedProdOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        FirmPlannedProdOrder."Source No.".SETVALUE(Item."No.");
        FirmPlannedProdOrder."Location Code".SETVALUE(Location.Code);
        FirmPlannedProdOrder."Zone Code".SETVALUE(Zone.Code);
        FirmPlannedProdOrder."Bin Code".SETVALUE(Bin.Code);
        FirmPlannedProdOrder.Quantity.SETVALUE(10);
        FirmPlannedProdOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := FirmPlannedProdOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::"Firm Planned";
        COMMIT;
        RefreshProdOrder_Action26;

        //Step 5 Execute "Refresh Production Order" Report
        //FirmPlannedProdOrder."<Action26>".INVOKE;
        //HEI.26<<
        ProductionOrderL.GET(ProductionOrderL.Status::"Firm Planned", ProductionOrderNo);
        FirmPlannedProdOrder.OK.INVOKE;
        FirmPlannedProdOrder.OPENEDIT;
        // FirmPlannedProdOrder.GOTORECORD(ProductionOrderL);
        FirmPlannedProdOrder.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05
        FirmProdOrdLines.RESET;
        FirmProdOrdLines.SETRANGE(Status, FirmProdOrdLines.Status::"Firm Planned");
        if FirmProdOrdLines.FINDSET then;
        //HEI.05

        //Step 6: Modify Routing Version Code
        if RoutingVersionCode <> '' then
            FirmProdOrdLines.MODIFYALL("Routing Version Code", RoutingVersionCode);//HEI.35
                                                                                   //HEI.35>>
                                                                                   //REPEAT
                                                                                   //FirmProdOrdLines."Routing Version Code" := RoutingVersionCode; //HEI.05
                                                                                   //FirmProdOrdLines.MODIFY; //HEI.05
                                                                                   //UNTIL FirmProdOrdLines.NEXT = 0; //HEI.05
                                                                                   //HEI.35<<
                                                                                   //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<
        //HEI.31>>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD011', COMPANYNAME, DATABASE::Item);
        if Item3L.GET(UnitTestingValues.Value) then begin
            ProdOrderComponentL.RESET();
            ProdOrderComponentL.SETCURRENTKEY("Prod. Order No.", "Item No.");//HEI.35
            ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
            ProdOrderComponentL.SETFILTER("Item No.", '%1', Item3L."No.");
            //IF ProdOrderComponentL.COUNT > 1 THEN //HEI.35
            if ProdOrderComponentL.FINDFIRST then begin
                ProdOrderComponentL.DELETE;
            end;
        end;
        //HEI.31<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06
                FilteredProdOrderRtngLineSet.RESET;//HEI.35
                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                //FilteredProdOrderRtngLineSet.FINDFIRST();//HEI.35
                if FilteredProdOrderRtngLineSet.FINDFIRST() then begin//HEI.35
                    ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                    //HEI.29>>
                    if ProdOrderComponentL."Bin Code" <> Bin.Code then begin
                        Bin1.GET(ProdOrderComponentL."Location Code", ProdOrderComponentL."Bin Code");
                        ProdOrderComponentL."Zone Code FND" := Bin1."Zone Code";
                    end;
                    //HEI.29<<
                    ProdOrderComponentL.MODIFY;
                    //HEI.27>>
                    //HEI.54>>
                    //IF ProdOrderComponentL."Bin Code" <> Bin.Code THEN BEGIN
                    Item2.GET(ProdOrderComponentL."Item No.");
                    if (ProdOrderComponentL."Bin Code" <> Bin.Code) and (Item2.Blocked <> true) then
                        //HEI.54<<
                        //HEI.38>>
                        /*
                          ItemInventory1.InitParameters(ProdOrderComponentL."Item No.",ProdOrderComponentL."Location Code",ProdOrderComponentL."Zone Code",ProdOrderComponentL."Bin Code",100000,'DTWTEST001','PRE101');
                          ItemInventory1.USEREQUESTPAGE(FALSE);
                          ItemInventory1.RUN;
                          */
                UpdateItemInvDTW2InitParameters(ProdOrderComponentL."Item No.", ProdOrderComponentL."Location Code", ProdOrderComponentL."Zone Code FND", ProdOrderComponentL."Bin Code", 100000, 'DTWTEST001', 'PRE101');
                    //HEI.38<<
                    //END;  //HEI.54
                end;//HEI.35
                    //HEI.27<<
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<

        //Step 7: Open Routing Page
        //FirmPlannedProdOrder.ProdOrderLines.Action1901652204.INVOKE; //BC UPGRADE PATHAA02
        FirmPlannedProdOrder.ProdOrderLines."Ro&uting".Invoke(); //BC UPGRADE PATHAA02

        //Step 8: Modify Production BOM Version Code
        //HEI.05 <<
        //IF  ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            FirmProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            FirmProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //Step 6 Call Action "Change &Status" from Firm Planned Prod Order Page
        //FirmPlannedProdOrder.Action25.INVOKE;//BC UPGRADE PATHAA02
        FirmPlannedProdOrder."Change &Status".Invoke(); //BC UPGRADE PATHAA02
        //Change Status Action is handled By Function ChangeStatusPageHandler_PRD010

        // FirmPlannedProdList.CLOSE;

        //Step 7 TO find the Release Production Order which is created By "Change Status" Action From firm Planned Prod Order Page
        ReleasedProductionOrderL.GET(ReleasedProductionOrderL.Status::Released, ProductionOrderNo); //Go to release produciton order
                                                                                                    // ReleaseProdOrderList.OPENEDIT;
                                                                                                    // ReleaseProdOrderList.FINDFIRSTFIELD("No.",ProductionOrderNo);

        //Step 8 Open Release Prod Order Page
        ReleaseProdOrder.OPENEDIT;
        // ReleaseProdOrder.GOTORECORD(ReleasedProductionOrderL);
        ReleaseProdOrder.FILTER.SETFILTER("No.", ProductionOrderNo);

        FPPO := true;

        statusfilter := ReleasedProductionOrderL.Status;

        //Step 9 Call "Routing" Action From Release Prod Order Lines
        ReleaseProdOrder.ProdOrderLines.Routing.INVOKE;
        //Prod Order Routing Page is handled by Funciton RoutingPageHandler_PRD010

        //Step 10 To Enter Consumption Quantities in Prod Order Component Page - //Code By Lokenath
        QuantityPer := 1;
        ReleaseProdOrder.ProdOrderLines.Components.INVOKE;
        //Prod Order Componenets Page is handled by function ProdOrderComponentsPageHandler_PRD010

        //Step 11: To Enter Lots for Consumption in Prod Order Component Page - //Code By Lokenath
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        //IF ProdOrderComponentL.FINDSET THEN BEGIN //HEI.35

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(false, false) then begin //HEI.35
        if ProdOrderComponentL.FINDSET(false) then begin //HEI.35
                                                         // BC Upgrade MISHRS14 <<

            ProdOrderComponentsL.OPENEDIT;
            repeat
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                QuantityBase := 1;
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ItemL.GET(ItemNo);//HEI.33
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));
                ItemTrackLineConsumption := true; // TO Control assigning the Lot Nos for Consumption & Output lines
                                                  //HEI.54>>
                                                  //IF (ItemL."Item Tracking Code" <> '') THEN BEGIN//HEI.33 //HEI.42>>
                if (ItemL."Item Tracking Code" <> '') and (ItemL.Blocked <> true) then begin
                    //HEI.54<<
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
                    ItemL."Rounding Precision" := 0.00001;
                    ItemL.MODIFY;
                end;
            //HEI.42<<
            //ItemTrackingLines page is handled by function ItemTrackingLinesPageHandler_PRD010
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 12 Close Prod Order Components Page
        ProdOrderComponentsL.OK.INVOKE;

        //Step 13 To Open Production Journal Page from Released Prod Order Page
        ReleaseProdOrder.ProdOrderLines.ProductionJournal.INVOKE;
        //Production Journal Page is handled by Function ProductionJournalPageHandler_PRD010

        // ReleaseProdOrderList.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(QuantityPer);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        CLEAR(changestatusupdate);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(BinCode);

    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ChangeStatustoRPOPageHandler_PRD006,RoutingPageHandler_PRD010,ProdOrderComponentsPageHandler_PRD013_PRD050,ItemTrackingLinesPageHandler_Brew,ProductionJournalPageHandler_Brew,MessageHandler,ConfirmationHandler_new,ItemTrackingSummaryPageHandler')]
    procedure RT_PRD008_CorrectConsumedorProducedQuantities_Brew_8();
    var
        WorkCenterL: Record "Work Center";
        ProductionOrderL: Record "Production Order";
        ReleasedProductionOrderL: Record "Production Order";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        ReleaseProdOrderList: TestPage "Released Production Orders";
        ReleaseProdOrder: TestPage "Released Production Order";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
        Bin1: Record Bin;
        ItemL: Record Item;
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.11>>
        MfgSetupDisable.GET;
        MfgSetupDisable."Consump. Tolerance Limit FND" := false;
        MfgSetupDisable.MODIFY;
        UserSetup.RESET;
        UserSetup.MODIFYALL("Consump. Tolerance Warning FND", true);
        //<<HEI.11
        //Remove default setup HEI.10>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.10<<
        //HEI.24>>
        ItemTrackingCode.RESET;
        ItemTrackingCode.MODIFYALL("Strict Expiration Posting", false);
        //HEI.24<<
        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD005', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenterL.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenterL."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD005', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD013', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //>>HEI.08
        //HEI.38>>
        /*
        PostInventory.SetInputValue(Item."No.",Location.Code,Zone.Code,Bin.Code,100000,'DTWTEST001','PRE101');
        PostInventory.USEREQUESTPAGE(FALSE);
        PostInventory.RUN;
        */
        UpdateInvDTWSetInputValue(Item."No.", Location.Code, Zone.Code, Bin.Code, 100000, 'DTWTEST001', 'PRE101');
        //HEI.38<<
        //<<HEI.08

        //Step 1: Login

        //Step 2 Open Firm Planned Production Order List page
        // FirmPlannedProdList.OPENEDIT;

        //Step 3 Open Firm Planned Production Order Document page
        FirmPlannedProdOrder.OPENNEW;

        //Step 4 Create New Firm Planned Production Order
        FirmPlannedProdOrder.NEW;
        FirmPlannedProdOrder."No.".ASSISTEDIT;
        FirmPlannedProdOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        FirmPlannedProdOrder."Source No.".SETVALUE(Item."No.");
        FirmPlannedProdOrder."Location Code".SETVALUE(Location.Code);
        FirmPlannedProdOrder."Zone Code".SETVALUE(Zone.Code);
        FirmPlannedProdOrder."Bin Code".SETVALUE(Bin.Code);
        FirmPlannedProdOrder.Quantity.SETVALUE(10);
        FirmPlannedProdOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := FirmPlannedProdOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::"Firm Planned";
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5 Execute "Refresh Production Order" Report
        //FirmPlannedProdOrder."<Action26>".INVOKE;
        //HEI.26<<
        ProductionOrderL.GET(ProductionOrderL.Status::"Firm Planned", ProductionOrderNo);
        FirmPlannedProdOrder.OK.INVOKE;
        FirmPlannedProdOrder.OPENEDIT;
        // FirmPlannedProdOrder.GOTORECORD(ProductionOrderL);
        FirmPlannedProdOrder.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05
        FirmProdOrdLines.RESET;
        FirmProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if FirmProdOrdLines.FINDSET then;
        //HEI.05

        //Step 6: Modify Routing Version Code
        if RoutingVersionCode <> '' then
            repeat
                FirmProdOrdLines."Routing Version Code" := RoutingVersionCode; //HEI.05
                FirmProdOrdLines.MODIFY; //HEI.05
            until FirmProdOrdLines.NEXT = 0; //HEI.05
        //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06
                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                //HEI.29>>
                if ProdOrderComponentL."Bin Code" <> Bin.Code then begin
                    Bin1.GET(ProdOrderComponentL."Location Code", ProdOrderComponentL."Bin Code");
                    ProdOrderComponentL."Zone Code FND" := Bin1."Zone Code";
                end;
                //HEI.29<<
                ProdOrderComponentL.MODIFY;
                //HEI.27>>
                //HEI.54>>
                //IF ProdOrderComponentL."Bin Code" <> Bin.Code THEN BEGIN
                Item2.GET(ProdOrderComponentL."Item No.");
                if (ProdOrderComponentL."Bin Code" <> Bin.Code) and (Item2.Blocked <> true) then
                    //HEI.54<<
                    //HEI.38>>
                    /*
                      ItemInventory1.InitParameters(ProdOrderComponentL."Item No.",ProdOrderComponentL."Location Code",ProdOrderComponentL."Zone Code",ProdOrderComponentL."Bin Code",100000,'DTWTEST001','PRE101');
                      ItemInventory1.USEREQUESTPAGE(FALSE);
                      ItemInventory1.RUN;
                      */
              UpdateItemInvDTW2InitParameters(ProdOrderComponentL."Item No.", ProdOrderComponentL."Location Code", ProdOrderComponentL."Zone Code FND", ProdOrderComponentL."Bin Code", 100000, 'DTWTEST001', 'PRE101');
            //HEI.38<<
            //END; //HEI.54
            //HEI.27<<
            until ProdOrderComponentL.NEXT = 0;
        //HEI.49>>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD011', COMPANYNAME, DATABASE::Item);
        if Item.GET(UnitTestingValues.Value) then begin
            ProdOrderComponentL.RESET();
            ProdOrderComponentL.SETCURRENTKEY("Prod. Order No.", "Item No.");
            ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
            ProdOrderComponentL.SETFILTER("Item No.", '%1', Item."No.");
            if ProdOrderComponentL.FINDFIRST then begin
                ProdOrderComponentL.DELETE;
            end;
        end;
        //HEI.49<<
        //HEI.05 <<

        //Step 7: Open Routing Page
        //FirmPlannedProdOrder.ProdOrderLines.Action1901652204.INVOKE; //BC UPGRADE PATHAA02
        FirmPlannedProdOrder.ProdOrderLines."Ro&uting".Invoke(); //BC UPGRADE PATHAA02

        //Step 8: Modify Production BOM Version Code
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            FirmProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            FirmProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //Step 6 Call Action "Change &Status" from Firm Planned Prod Order Page
        //FirmPlannedProdOrder.Action25.INVOKE;//BC UPGRADE PATHAA02
        FirmPlannedProdOrder."Change &Status".Invoke(); //BC UPGRADE PATHAA02
        //Change Status Action is handled By Function ChangeStatusPageHandler_PRD010

        // FirmPlannedProdList.CLOSE;

        //Step 7 TO find the Release Production Order which is created By "Change Status" Action From firm Planned Prod Order Page
        ReleasedProductionOrderL.GET(ReleasedProductionOrderL.Status::Released, ProductionOrderNo); //Go to release produciton order
                                                                                                    // ReleaseProdOrderList.OPENEDIT;
                                                                                                    // ReleaseProdOrderList.FINDFIRSTFIELD("No.",ProductionOrderNo);

        //Step 8 Open Release Prod Order Page
        ReleaseProdOrder.OPENEDIT;
        // ReleaseProdOrder.GOTORECORD(ReleasedProductionOrderL);
        ReleaseProdOrder.FILTER.SETFILTER("No.", ProductionOrderNo);

        FPPO := true;

        statusfilter := ReleasedProductionOrderL.Status;

        //Step 9 Call "Routing" Action From Release Prod Order Lines
        ReleaseProdOrder.ProdOrderLines.Routing.INVOKE;
        //Prod Order Routing Page is handled by Funciton RoutingPageHandler_PRD010

        //Step 10 To Enter Consumption Quantities in Prod Order Component Page - //Code By Lokenath
        QuantityPer := 1;
        ReleaseProdOrder.ProdOrderLines.Components.INVOKE;
        //Prod Order Componenets Page is handled by function ProdOrderComponentsPageHandler_PRD010

        //Step 11: To Enter Lots for Consumption in Prod Order Component Page - //Code By Lokenath
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                QuantityBase := 1;
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ItemL.GET(ItemNo);//HEI.33
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));
                ItemTrackLineConsumption := true; // TO Control assigning the Lot Nos for Consumption & Output lines
                                                  //HEI.54>>
                                                  //IF (ItemL."Item Tracking Code" <> '') THEN BEGIN//HEI.33 //HEI.42>>
                if (ItemL."Item Tracking Code" <> '') and (ItemL.Blocked <> true) then begin
                    //HEI.54<<
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
                    ItemL."Rounding Precision" := 0.00001;
                    ItemL.MODIFY;
                end;
            //HEI.42<<
            //ItemTrackingLines page is handled by function ItemTrackingLinesPageHandler_PRD010
            until ProdOrderComponentL.NEXT = 0;
        end;
        //HEI.49>>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD011', COMPANYNAME, DATABASE::Item);
        if Item.GET(UnitTestingValues.Value) then begin
            ProdOrderComponentL.RESET();
            ProdOrderComponentL.SETCURRENTKEY("Prod. Order No.", "Item No.");
            ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
            ProdOrderComponentL.SETFILTER("Item No.", '%1', Item."No.");
            if ProdOrderComponentL.FINDFIRST then begin
                ProdOrderComponentL.DELETE;
            end;
        end;
        //HEI.49<<
        //Step 12 Close Prod Order Components Page
        ProdOrderComponentsL.OK.INVOKE;

        //Step 13 To Open Production Journal Page from Released Prod Order Page
        ReleaseProdOrder.ProdOrderLines.ProductionJournal.INVOKE;
        //Production Journal Page is handled by Function ProductionJournalPageHandler_PRD010

        //****** SB **********
        // Step 14 Correct  Consumed or Produced Quantities
        CorrectQty := true;
        // Option a Increase in Total Consumed/Produced Qty
        ReleaseProdOrder.ProdOrderLines.ProductionJournal.INVOKE;

        // Option b Decrease in Total Consumed/Produced Qty
        DecQty := true;

        // 201221 >>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD011', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);
        // 201221 <<
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Entry No.");
        ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
        ItemLedgerEntry.SETRANGE("Document No.", ProductionOrderNo);
        ItemLedgerEntry.SETRANGE("Item No.", Item."No.");            // 201221 >>
        ItemLedgerEntry.SETRANGE("Lot No.", CorrectionLotNo);
        if ItemLedgerEntry.FINDLAST then
            CorrEntryNo := ItemLedgerEntry."Entry No.";
        ReleaseProdOrder.ProdOrderLines.ProductionJournal.INVOKE;

        //Step 14 Call Action "Change &Status" from RPO to FPO
        // ReleaseProdOrder.Action53.INVOKE;
        //Change Status Action is handled By Function ChangeStatusPageHandler_PRD083

        // ReleaseProdOrderList.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(QuantityPer);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        CLEAR(CorrectQty);
        CLEAR(CorrEntryNo);
        CLEAR(CorrectionLotNo);
        CLEAR(DecQty);
        CLEAR(changestatusupdate);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(BinCode);

    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ChangeStatusPageHandler_PRD083,RoutingPageHandler_PRD010,ProdOrderComponentsPageHandler_PRD013_PRD050,ItemTrackingLinesPageHandler_Brew,ProductionJournalPageHandler_Brew,MessageHandler,ConfirmationHandler_new,ItemTrackingSummaryPageHandler')]
    procedure RT_PRD083_FinishRPO_Brew_9();
    var
        WorkCenterL: Record "Work Center";
        ProductionOrderL: Record "Production Order";
        ReleasedProductionOrderL: Record "Production Order";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        ReleaseProdOrderList: TestPage "Released Production Orders";
        ReleaseProdOrder: TestPage "Released Production Order";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
        Bin1: Record Bin;
        ItemL: Record Item;
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.11>>
        MfgSetupDisable.GET;
        MfgSetupDisable."Consump. Tolerance Limit FND" := false;
        MfgSetupDisable.MODIFY;
        UserSetup.RESET;
        UserSetup.MODIFYALL("Consump. Tolerance Warning FND", true);
        //<<HEI.11
        //Remove default setup HEI.10>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.10<<
        //HEI.24>>
        ItemTrackingCode.RESET;
        ItemTrackingCode.MODIFYALL("Strict Expiration Posting", false);
        //HEI.24<<
        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD005', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenterL.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenterL."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD005', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD013', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //>>HEI.08
        //HEI.38>>
        /*
        PostInventory.SetInputValue(Item."No.",Location.Code,Zone.Code,Bin.Code,100000,'DTWTEST001','PRE101');
        PostInventory.USEREQUESTPAGE(FALSE);
        PostInventory.RUN;
        */
        UpdateInvDTWSetInputValue(Item."No.", Location.Code, Zone.Code, Bin.Code, 100000, 'DTWTEST001', 'PRE101');
        //HEI.38<<
        //<<HEI.08
        //Step 1: Login

        //Step 2 Open Firm Planned Production Order List page
        // FirmPlannedProdList.OPENEDIT;

        //Step 3 Open Firm Planned Production Order Document page
        FirmPlannedProdOrder.OPENNEW;

        //Step 4 Create New Firm Planned Production Order
        FirmPlannedProdOrder.NEW;
        FirmPlannedProdOrder."No.".ASSISTEDIT;
        FirmPlannedProdOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string

        FirmPlannedProdOrder."Source No.".SETVALUE(Item."No.");
        FirmPlannedProdOrder."Location Code".SETVALUE(Location.Code);
        FirmPlannedProdOrder."Zone Code".SETVALUE(Zone.Code);
        FirmPlannedProdOrder."Bin Code".SETVALUE(Bin.Code);
        FirmPlannedProdOrder.Quantity.SETVALUE(10);
        FirmPlannedProdOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := FirmPlannedProdOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::"Firm Planned";
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5 Execute "Refresh Production Order" Report
        //FirmPlannedProdOrder."<Action26>".INVOKE;
        //HEI.26<<
        ProductionOrderL.GET(ProductionOrderL.Status::"Firm Planned", ProductionOrderNo);
        FirmPlannedProdOrder.OK.INVOKE;
        FirmPlannedProdOrder.OPENEDIT;
        // FirmPlannedProdOrder.GOTORECORD(ProductionOrderL);
        FirmPlannedProdOrder.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05
        FirmProdOrdLines.RESET;
        FirmProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        FirmProdOrdLines.SETRANGE(Status, FirmProdOrdLines.Status::"Firm Planned");
        if FirmProdOrdLines.FINDSET then
            repeat
                //HEI.05

                //Step 6: Modify Routing Version Code
                if RoutingVersionCode <> '' then
                    FirmProdOrdLines."Routing Version Code" := RoutingVersionCode; //HEI.05
                FirmProdOrdLines.MODIFY; //HEI.05
            until FirmProdOrdLines.NEXT = 0; //HEI.05
        //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                //HEI.29>>
                if ProdOrderComponentL."Bin Code" <> Bin.Code then begin
                    Bin1.GET(ProdOrderComponentL."Location Code", ProdOrderComponentL."Bin Code");
                    ProdOrderComponentL."Zone Code FND" := Bin1."Zone Code";
                end;
                //HEI.29<<
                ProdOrderComponentL.MODIFY;
                //HEI.27>>
                //HEI.54>>
                //IF ProdOrderComponentL."Bin Code" <> Bin.Code THEN BEGIN
                Item2.GET(ProdOrderComponentL."Item No.");
                if (ProdOrderComponentL."Bin Code" <> Bin.Code) and (Item2.Blocked <> true) then
                    //HEI.54<<
                    //HEI.38>>
                    /*
                      ItemInventory1.InitParameters(ProdOrderComponentL."Item No.",ProdOrderComponentL."Location Code",ProdOrderComponentL."Zone Code",ProdOrderComponentL."Bin Code",100000,'DTWTEST001','PRE101');
                      ItemInventory1.USEREQUESTPAGE(FALSE);
                      ItemInventory1.RUN;
                      */
              UpdateItemInvDTW2InitParameters(ProdOrderComponentL."Item No.", ProdOrderComponentL."Location Code", ProdOrderComponentL."Zone Code FND", ProdOrderComponentL."Bin Code", 100000, 'DTWTEST001', 'PRE101');
            //HEI.38<<
            //END;  //HEI.54
            //HEI.27<<
            until ProdOrderComponentL.NEXT = 0;
        //HEI.49>>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD011', COMPANYNAME, DATABASE::Item);
        if Item.GET(UnitTestingValues.Value) then begin
            ProdOrderComponentL.RESET();
            ProdOrderComponentL.SETCURRENTKEY("Prod. Order No.", "Item No.");
            ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
            ProdOrderComponentL.SETFILTER("Item No.", '%1', Item."No.");
            if ProdOrderComponentL.FINDFIRST then begin
                ProdOrderComponentL.DELETE;
            end;
        end;
        //HEI.49<<
        //HEI.05 <<
        //Step 7: Open Routing Page
        //FirmPlannedProdOrder.ProdOrderLines.Action1901652204.INVOKE; //BC PGRADE PATHAA02
        FirmPlannedProdOrder.ProdOrderLines."Ro&uting".Invoke(); //BC UPGRADE PATHAA02

        //Step 8: Modify Production BOM Version Code
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            FirmProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            FirmProdOrdLines.MODIFY;
        end;
        //HEI.05 >>

        //Step 6 Call Action "Change &Status" from Firm Planned Prod Order Page
        //FirmPlannedProdOrder.Action25.INVOKE; //BC UPGRADE PATHAA02
        FirmPlannedProdOrder."Change &Status".Invoke(); //BC UPGRADE PATHAA02
        //Change Status Action is handled By Function ChangeStatusPageHandler_PRD010

        // FirmPlannedProdList.CLOSE;

        //Step 7 TO find the Release Production Order which is created By "Change Status" Action From firm Planned Prod Order Page
        ReleasedProductionOrderL.GET(ReleasedProductionOrderL.Status::Released, ProductionOrderNo); //Go to release produciton order
                                                                                                    // ReleaseProdOrderList.OPENEDIT;
                                                                                                    // ReleaseProdOrderList.FINDFIRSTFIELD("No.",ProductionOrderNo);

        //Step 8 Open Release Prod Order Page
        ReleaseProdOrder.OPENEDIT;
        // ReleaseProdOrder.GOTORECORD(ReleasedProductionOrderL);
        ReleaseProdOrder.FILTER.SETFILTER("No.", ProductionOrderNo);

        FPPO := true;

        statusfilter := ReleasedProductionOrderL.Status;

        //Step 9 Call "Routing" Action From Release Prod Order Lines
        ReleaseProdOrder.ProdOrderLines.Routing.INVOKE;
        //Prod Order Routing Page is handled by Funciton RoutingPageHandler_PRD010

        //Step 10 To Enter Consumption Quantities in Prod Order Component Page - //Code By Lokenath
        QuantityPer := 1;
        ReleaseProdOrder.ProdOrderLines.Components.INVOKE;
        //Prod Order Componenets Page is handled by function ProdOrderComponentsPageHandler_PRD010

        //Step 11: To Enter Lots for Consumption in Prod Order Component Page - //Code By Lokenath
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                QuantityBase := 1;
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ItemL.GET(ItemNo);//HEI.33
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));

                ItemTrackLineConsumption := true; // TO Control assigning the Lot Nos for Consumption & Output lines
                                                  //HEI.54>>
                                                  //IF (ItemL."Item Tracking Code" <> '') AND (ItemL.Blocked <> TRUE) THEN BEGIN//HEI.33 //HEI.42>>
                if (ItemL."Item Tracking Code" <> '') and (ItemL.Blocked <> true) then begin
                    //HEI.54<<
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
                    ItemL."Rounding Precision" := 0.00001;
                    ItemL.MODIFY;
                end;
            //HEI.42<<
            //ItemTrackingLines page is handled by function ItemTrackingLinesPageHandler_PRD010
            until ProdOrderComponentL.NEXT = 0;
        end;
        //HEI.49>>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD011', COMPANYNAME, DATABASE::Item);
        if Item.GET(UnitTestingValues.Value) then begin
            ProdOrderComponentL.RESET();
            ProdOrderComponentL.SETCURRENTKEY("Prod. Order No.", "Item No.");
            ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
            ProdOrderComponentL.SETFILTER("Item No.", '%1', Item."No.");
            if ProdOrderComponentL.FINDFIRST then begin
                ProdOrderComponentL.DELETE;
            end;
        end;
        //HEI.49<<
        //Step 12 Close Prod Order Components Page
        ProdOrderComponentsL.OK.INVOKE;

        //Step 13 To Open Production Journal Page from Released Prod Order Page
        ReleaseProdOrder.ProdOrderLines.ProductionJournal.INVOKE;
        //Production Journal Page is handled by Function ProductionJournalPageHandler_PRD010

        //****** SB **********
        // Step 14 Correct  Consumed or Produced Quantities
        CorrectQty := true;
        // Option a Increase in Total Consumed/Produced Qty
        ReleaseProdOrder.ProdOrderLines.ProductionJournal.INVOKE;

        // Option b Decrease in Total Consumed/Produced Qty
        DecQty := true;

        // 201221 >>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD011', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);
        // 201221 <<
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Entry No.");
        ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
        ItemLedgerEntry.SETRANGE("Document No.", ProductionOrderNo);
        ItemLedgerEntry.SETRANGE("Item No.", Item."No.");        // 201221 >>
        ItemLedgerEntry.SETRANGE("Lot No.", CorrectionLotNo);
        if ItemLedgerEntry.FINDLAST then
            CorrEntryNo := ItemLedgerEntry."Entry No.";
        ReleaseProdOrder.ProdOrderLines.ProductionJournal.INVOKE;
        COMMIT;//HEI.13
               //Step 15 Call Action "Change &Status" from RPO to FPO
               //ReleaseProdOrder.Action53.INVOKE; //HEI.13
               //Change Status Action is handled By Function ChangeStatusPageHandler_PRD083

        // ReleaseProdOrderList.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(QuantityPer);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        CLEAR(CorrectQty);
        CLEAR(CorrEntryNo);
        CLEAR(CorrectionLotNo);
        CLEAR(DecQty);
        CLEAR(changestatusupdate);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(BinCode);

    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler')]
    procedure RT_PRD071_CreateFPPO_Packaging_1();
    begin

        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //Step 1: Login

        //Step 2 Open Firm Planned Production Order List page
        // FirmPlannedProdList.OPENEDIT;

        //Step 3 Open Firm Planned Production Order Document page
        FirmPlannedProdOrder.OPENNEW;

        //Step 4 Create New Firm Planned Production Order
        FirmPlannedProdOrder.NEW;
        FirmPlannedProdOrder."No.".ASSISTEDIT;
        FirmPlannedProdOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        FirmPlannedProdOrder."Source No.".SETVALUE(Item."No.");
        FirmPlannedProdOrder."Location Code".SETVALUE(Location.Code);
        FirmPlannedProdOrder.Quantity.SETVALUE(2);
        FirmPlannedProdOrder."Zone Code".SETVALUE(Zone.Code);
        FirmPlannedProdOrder."Bin Code".SETVALUE(Bin.Code);
        FirmPlannedProdOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := FirmPlannedProdOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::"Firm Planned";
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5 Execute "Refresh Production Order" Report
        //FirmPlannedProdOrder."<Action26>".INVOKE;
        //HEI.26<<

        //Step 6 Close Firm Planned Production Order Page
        FirmPlannedProdOrder.OK.INVOKE;
        // FirmPlannedProdList.CLOSE;
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler')]
    procedure RT_PRD074_CheckDefaultRouting_Packaging_2();
    var
        ProdOrdLineL: Record "Prod. Order Line";
        FrimPlannedProdSubForm: TestPage "Firm Planned Prod. Order Lines";
        SKU: Record "Stockkeeping Unit";
        RoutingNoL: Code[20];
    begin

        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //Step 1: Login

        //Step 2 Open Firm Planned Production Order List page
        // FirmPlannedProdList.OPENEDIT;

        //Step 3 Open Firm Planned Production Order Document page
        FirmPlannedProdOrder.OPENNEW;

        //Step 4 Create New Firm Planned Production Order
        FirmPlannedProdOrder.NEW;
        FirmPlannedProdOrder."No.".ASSISTEDIT;
        FirmPlannedProdOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        FirmPlannedProdOrder."Source No.".SETVALUE(Item."No.");
        FirmPlannedProdOrder."Location Code".SETVALUE(Location.Code);
        FirmPlannedProdOrder.Quantity.SETVALUE(5);
        FirmPlannedProdOrder."Zone Code".SETVALUE(Zone.Code);
        FirmPlannedProdOrder."Bin Code".SETVALUE(Bin.Code);
        FirmPlannedProdOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := FirmPlannedProdOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::"Firm Planned";
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5 Execute "Refresh Production Order" Report
        //FirmPlannedProdOrder."<Action26>".INVOKE;
        //HEI.26<<
        FirmPlannedProdOrder.OK.INVOKE;
        //HEI.05
        FirmProdOrdLines.RESET;
        FirmProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        FirmProdOrdLines.FINDSET;
        //HEI.05

        //Step 6 Check if SKU and Production Order Lines have Same Routing No.
        // FirmPlannedProdList.FINDFIRSTFIELD("No.",ProductionOrderNo);
        FirmPlannedProdOrder.OPENEDIT;
        FirmPlannedProdOrder.FILTER.SETFILTER("No.", ProductionOrderNo);
        SKU.RESET;
        SKU.SETRANGE("Item No.", FirmPlannedProdOrder.ProdOrderLines."Item No.".VALUE);
        SKU.SETRANGE("Location Code", FirmProdOrdLines."Location Code"); //HEI.05
        if SKU.FINDFIRST then
            if FirmProdOrdLines."Routing No." <> SKU."Routing No." then //HEI.05
                ERROR('SKU Routing No. should be same as Production Order Lines Routing No.');

        FirmPlannedProdOrder.CLOSE;
        // FirmPlannedProdList.CLOSE;
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_PRD075')]
    procedure RT_PRD075_AdjustRouting_Packaging_3();
    var
        ProdOrderRouting: TestPage "Prod. Order Routing";
        WorkCenter: Record "Work Center";
        ProductionOrderL: Record "Production Order";
        ProdOrderComponentL: Record "Prod. Order Component";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for WorkCenter
        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD075', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenter.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenter."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD075', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        //Step 1: Logon to Heilite
        // FirmPlannedProdList.OPENEDIT;
        FirmPlannedProdOrder.OPENNEW;
        //step 2: Create New Firm Planned Production Order
        FirmPlannedProdOrder.NEW;
        FirmPlannedProdOrder."No.".ASSISTEDIT;
        FirmPlannedProdOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        FirmPlannedProdOrder."Source No.".SETVALUE(Item."No.");
        FirmPlannedProdOrder."Location Code".SETVALUE(Location.Code);
        FirmPlannedProdOrder."Zone Code".SETVALUE(Zone.Code);
        FirmPlannedProdOrder."Bin Code".SETVALUE(Bin.Code);
        FirmPlannedProdOrder.Quantity.SETVALUE(2);
        FirmPlannedProdOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := FirmPlannedProdOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::"Firm Planned";
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 3: Execute Refresh Production Order Report
        //FirmPlannedProdOrder."<Action26>".INVOKE;
        //HEI.26<<
        ProductionOrderL.GET(ProductionOrderL.Status::"Firm Planned", ProductionOrderNo);
        FirmPlannedProdOrder.OK.INVOKE;
        FirmPlannedProdOrder.OPENEDIT;
        // FirmPlannedProdOrder.GOTORECORD(ProductionOrderL);
        FirmPlannedProdOrder.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05
        FirmProdOrdLines.RESET;
        FirmProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if FirmProdOrdLines.FINDSET then;
        //HEI.05

        //Step 4: On the Line FastTab of Prod. Order page Click on Routing Version Code column to select another version
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            FirmProdOrdLines."Routing Version Code" := RoutingVersionCode; //HEI.05 //changing the Routing version code from Default to DEF02 (conf, essg handler)
            FirmProdOrdLines.MODIFY;
        end;

        //HEI.05 >>
        //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<
        ////HEI.05 >>

        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat    //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();

                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;


        ////HEI.05 <<

        //Step 5: Call Action "Routing" from Production order Lines Page "
        //FirmPlannedProdOrder.ProdOrderLines.Action1901652204.INVOKE; //BC UPGRADE PATHAA02
        FirmPlannedProdOrder.ProdOrderLines."Ro&uting".Invoke(); //BC UPGRADE PATHAA02
        FirmPlannedProdOrder.CLOSE;
        // FirmPlannedProdList.CLOSE;
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderComponentPageHandler_PRD077,MessageHandler')]
    procedure RT_PRD077_FPPOAdjustBOM_Packaging_4();
    var
        ProdOrdLineL: Record "Prod. Order Line";
        FrimPlannedProdSubForm: TestPage "Firm Planned Prod. Order Lines";
        SKU: Record "Stockkeeping Unit";
        ProductionOrderL: Record "Production Order";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD077', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //Step 1: Login

        //Step 2 Open Firm Planned Production Order List page
        // FirmPlannedProdList.OPENEDIT;

        //Step 3 Open Firm Planned Production Order Document page
        FirmPlannedProdOrder.OPENNEW;

        //Step 4 Create New Firm Planned Production Order
        FirmPlannedProdOrder.NEW;
        FirmPlannedProdOrder."No.".ASSISTEDIT;
        FirmPlannedProdOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        FirmPlannedProdOrder."Source No.".SETVALUE(Item."No.");
        FirmPlannedProdOrder."Location Code".SETVALUE(Location.Code);
        FirmPlannedProdOrder.Quantity.SETVALUE(2);
        FirmPlannedProdOrder."Zone Code".SETVALUE(Zone.Code);
        FirmPlannedProdOrder."Bin Code".SETVALUE(Bin.Code);
        FirmPlannedProdOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := FirmPlannedProdOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::"Firm Planned";
        COMMIT;
        RefreshProdOrder_Action26;

        //Step 5 Execute Refresh Production Order Report
        //FirmPlannedProdOrder."<Action26>".INVOKE; //calling new action created by Lokenath to refresh Production order
        //HEI.26<<
        ProductionOrderL.GET(ProductionOrderL.Status::"Firm Planned", ProductionOrderNo);
        FirmPlannedProdOrder.OK.INVOKE;

        //Step 6 Open Newly Created Firm Planned Production Document.
        FirmPlannedProdOrder.OPENEDIT;
        // FirmPlannedProdOrder.GOTORECORD(ProductionOrderL);
        FirmPlannedProdOrder.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05
        FirmProdOrdLines.RESET;
        FirmProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        FirmProdOrdLines.FINDSET;
        //HEI.05


        //Step 7 Change Production BOM Version Code Column From 'Default' to 'ALT2.0' in production Order Lines
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            FirmProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            FirmProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //Step 8  Call "Prod Order Components" Action From Prod Order Lines Page
        //FirmPlannedProdOrder.ProdOrderLines.Action1903098604.INVOKE; //BC UPGRADE PATHAA02
        FirmPlannedProdOrder.ProdOrderLines.Components.Invoke(); //BC UPGRADE PATHAA02
        FirmPlannedProdOrder.CLOSE;
        // FirmPlannedProdList.CLOSE;
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ChangeStatustoRPOPageHandler_PRD076,MessageHandler')]
    procedure "RT_PRD076_FPPO-ChangeStatustoRPO_Packaging_5"();
    var
        FirmPlannedProdList: TestPage "Firm Planned Prod. Orders";
        FirmPlannedProdOrder: TestPage "Firm Planned Prod. Order";
        ProdOrderRouting: TestPage "Prod. Order Routing";
        WorkCenter: Record "Work Center";
        Item: Record Item;
        Location: Record Location;
        Zone: Record Zone;
        Bin: Record Bin;
        ProductionOrderL: Record "Production Order";
    begin

        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //Step 1: Login
        // FirmPlannedProdList.OPENEDIT;
        //Step 2: Open Firm Planned Production Order List page
        FirmPlannedProdOrder.OPENNEW;
        //Step 3: Create New Firm Planned Production Order
        FirmPlannedProdOrder.NEW;
        FirmPlannedProdOrder."No.".ASSISTEDIT;
        FirmPlannedProdOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        FirmPlannedProdOrder."Source No.".SETVALUE(Item."No.");
        FirmPlannedProdOrder."Location Code".SETVALUE(Location.Code);
        FirmPlannedProdOrder."Zone Code".SETVALUE(Zone.Code);
        FirmPlannedProdOrder."Bin Code".SETVALUE(Bin.Code);
        FirmPlannedProdOrder.Quantity.SETVALUE(2);
        FirmPlannedProdOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := FirmPlannedProdOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::"Firm Planned";
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 4: Execute Refresh Production Order Report
        //FirmPlannedProdOrder."<Action26>".INVOKE;
        //HEI.26<<
        ProductionOrderL.GET(ProductionOrderL.Status::"Firm Planned", ProductionOrderNo);

        //Step 5: Close Firm Planned Prod order.
        FirmPlannedProdOrder.OK.INVOKE;

        //Step 6: Go To Newly Created Firm Planned Production Order
        FirmPlannedProdOrder.OPENEDIT;
        // FirmPlannedProdOrder.GOTORECORD(ProductionOrderL);
        FirmPlannedProdOrder.FILTER.SETFILTER("No.", ProductionOrderNo);

        //Step 7: Call Action TO change Document Status from FPPO to RPO
        //FirmPlannedProdOrder.Action25.INVOKE;//BC UPGRADE PATHAA02
        FirmPlannedProdOrder."Change &Status".Invoke(); //BC UPGRADE PATHAA02
        // FirmPlannedProdList.CLOSE;
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_PRD081,ChangeStatusFPPOtoRPOPageHandler_PRD081,ProdOrderComponentsPageHandler_PRD081,ItemTrackingLinesPageHandler_PRD081,MessageHandler,ItemTrackingSummaryPageHandler,ConfirmationHandler_ItemtrackingAptean')]
    procedure RT_PRD081_EnterConsumQtywithLotSelection_Packaging_6();
    var
        FirmPlannedProdListL: TestPage "Firm Planned Prod. Orders";
        FirmPlannedProdOrderL: TestPage "Firm Planned Prod. Order";
        ItemL: Record Item;
        Item2L: Record Item;
        Item3L: Record Item;
        LocationL: Record Location;
        ZoneL: Record Zone;
        BinL: Record Bin;
        WorkCenterL: Record "Work Center";
        ProductionOrderL: Record "Production Order";
        ProdOrderRoutingL: TestPage "Prod. Order Routing";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        ItemTrackingLinesL: TestPage "Item Tracking Lines";
        ReleasedProductionOrdersListL: TestPage "Released Production Orders";
        ReleasedProductionOrderL: TestPage "Released Production Order";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
        ReservationEntryL: Record "Reservation Entry";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.28>>
        MfgSetupDisable.GET;
        MfgSetupDisable."Consump. Tolerance Limit FND" := false;
        MfgSetupDisable.MODIFY;
        UserSetup.RESET;
        UserSetup.MODIFYALL("Consump. Tolerance Warning FND", true);
        //<<HEI.28
        //Remove default setup HEI.10>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.10<<

        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Item);
        ItemL.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Location);
        LocationL.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Zone);
        ZoneL.GET(LocationL.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Bin);
        BinL.GET(LocationL.Code, UnitTestingValues.Value);
        //HEI.47>>
        Bin3.RESET;
        Bin3.SETRANGE("Location Code", LocationL.Code);
        Bin3.SETRANGE("Batch Production Resource FND", '');
        if Bin3.FINDSET then
            Bin3.MODIFYALL("Batch Production Resource FND", 'A');
        //HEI.47<<
        //Check default value for WorkCenter
        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD075', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenterL.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenterL."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD075', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD077', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //>>HEI.08
        //HEI.38>>
        /*
        PostInventory.SetInputValue(Item."No.",Location.Code,Zone.Code,Bin.Code,100000,'DTWTEST001','PRE101');
        PostInventory.USEREQUESTPAGE(FALSE);
        PostInventory.RUN;
        */
        //UpdateInvDTWSetInputValue(Item."No.",Location.Code,Zone.Code,Bin.Code,100000,'DTWTEST001','PRE101');//HEI.43
        UpdateInvDTWSetInputValue(ItemL."No.", LocationL.Code, ZoneL.Code, BinL.Code, 100000, 'DTWTEST001', 'PRE101');//HEI.43
                                                                                                                      //HEI.38<<
                                                                                                                      //<<HEI.08
                                                                                                                      //Step 1: Login

        //Step 2: Search for “Firm Planned Prod. Orders”
        // FirmPlannedProdListL.OPENEDIT;
        FirmPlannedProdOrderL.OPENNEW;

        //Step 3: Create New Firm Planned Production Order
        FirmPlannedProdOrderL.NEW;
        FirmPlannedProdOrderL."No.".ASSISTEDIT;
        FirmPlannedProdOrderL."Source Type".SETVALUE(Sourcefilter::Item);
        FirmPlannedProdOrderL."Source No.".SETVALUE(ItemL."No.");
        FirmPlannedProdOrderL."Location Code".SETVALUE(LocationL.Code);
        FirmPlannedProdOrderL."Zone Code".SETVALUE(ZoneL.Code);
        FirmPlannedProdOrderL."Bin Code".SETVALUE(BinL.Code);
        FirmPlannedProdOrderL.Quantity.SETVALUE(2);
        FirmPlannedProdOrderL."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := FirmPlannedProdOrderL."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::"Firm Planned";
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 4: Refresh Production Order
        //FirmPlannedProdOrderL."<Action26>".INVOKE;
        //HEI.26<<
        ProductionOrderL.GET(ProductionOrderL.Status::"Firm Planned", ProductionOrderNo);

        //Strep 5: Close Firm Prod Oder Page
        FirmPlannedProdOrderL.OK.INVOKE;

        //Step 6: Go to Record Newly Created
        FirmPlannedProdOrderL.OPENEDIT;
        // FirmPlannedProdOrderL.GOTORECORD(ProductionOrderL);
        FirmPlannedProdOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05
        FirmProdOrdLines.RESET;
        FirmProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if FirmProdOrdLines.FINDSET then;
        //HEI.05

        //Step 7: Modify Routing Version Code
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            FirmProdOrdLines."Routing Version Code" := RoutingVersionCode;
            FirmProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.34>>
        /*
        //HEI.14>>
        IF Location."To-Production Bin Code" = '' THEN
          Location."To-Production Bin Code" := Bin.Code;
        IF Location."From-Production Bin Code" = '' THEN
          Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<
        */
        if LocationL."To-Production Bin Code" = '' then
            LocationL."To-Production Bin Code" := BinL.Code;//HEI.43
        if LocationL."From-Production Bin Code" = '' then
            LocationL."From-Production Bin Code" := BinL.Code;//HEI.43
        LocationL.MODIFY;
        //HEI.34<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat  //HEI.06
                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
                //HEI.45>>
                //HEI.49>>
                if Item2.GET(ProdOrderComponentL."Item No.") and Item2.Blocked then
                    Item2.MODIFYALL(Item2.Blocked, false, false);
                //HEI.49<<
                if Bin2.GET(ProdOrderComponentL."Location Code", ProdOrderComponentL."Bin Code") then
                    UpdateItemInvDTW2InitParameters(ProdOrderComponentL."Item No.", ProdOrderComponentL."Location Code", Bin2."Zone Code", ProdOrderComponentL."Bin Code", 100000, 'DTWTEST001', 'PRE101');
                //HEI.50>>
                ReservationEntryL.RESET;
                ReservationEntryL.SETRANGE("Item No.", ProdOrderComponentL."Item No.");

                // BC Upgrade MISHRS14 >>
                // Removed false from FINDSET due to warning because its being depreceted
                //if ReservationEntryL.FINDSET(true, false) then
                if ReservationEntryL.FINDSET(true) then
                    // BC Upgrade MISHRS14 <<

                    ReservationEntryL.DELETEALL;
            //HEI.50<<
            //HEI.45<<
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<

        //Step 8: Open Routing Page
        //FirmPlannedProdOrderL.ProdOrderLines.Action1901652204.INVOKE; //BC UPGRADE PATHAA02
        FirmPlannedProdOrderL.ProdOrderLines."Ro&uting".Invoke(); //BC UPGRADE PATHAA02
        //Step 9: Modify Production BOM Version Code
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            FirmProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            FirmProdOrdLines.MODIFY;
        end;
        //HEI.05 >>

        //Step 10: Change Status from FPPO to RPO
        statusfilter := statusfilter::Released;
        FPPO := true;
        //FirmPlannedProdOrderL.Action25.INVOKE; //BC UPGRADE PATHAA02
        FirmPlannedProdOrderL."Change &Status".Invoke(); //BC UPGRADE PATHAA02

        //Step 11: Enter Consumption Quantities
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        statusfilter := ProductionOrderL.Status;

        ReleasedProductionOrderL.OPENEDIT;
        // ReleasedProductionOrderL.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);

        QuantityPer := 1;
        ReleasedProductionOrderL.ProdOrderLines.Components.INVOKE;

        //Step 11: Enter Lots for Consumption
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                //HEI.44>>
                //CheckStocinBin(ProdOrderComponentL);//HEI.41
                //HEI.44<<
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                QuantityBase := 1;
                Item.GET(ItemNo);
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));
                if Item."Item Tracking Code" <> '' then
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 12: End Execution
        ProdOrderComponentsL.CLOSE;
        //ReleasedProductionOrderL.CLOSE;//HEI.48
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(QuantityPer);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        CLEAR(changestatusupdate);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(BinCode);
        CLEAR(LotNoOutput);

    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ChangeStatusPageHandler_PRD078,RoutingPageHandler_PRD078,ProdOrderComponentsPageHandler_PRD081,ItemTrackingLinesPageHandler_PRD078,ProductionJournalPageHandler_PRD078,MessageHandler,ConfirmationHandler,ItemTrackingSummaryPageHandler,AutoBatchNoGenerationRequestPage')]
    procedure "RT_PRD078_ConsumeComponentProduce Product_Packaging_7"();
    var
        FirmPlannedProdList: TestPage "Firm Planned Prod. Orders";
        FirmPlannedProdOrder: TestPage "Firm Planned Prod. Order";
        ProdOrderRouting: TestPage "Prod. Order Routing";
        WorkCenter: Record "Work Center";
        Item: Record Item;
        Location: Record Location;
        Zone: Record Zone;
        Bin: Record Bin;
        ProductionOrderL: Record "Production Order";
        ReleaseProdOrderList: TestPage "Released Production Orders";
        ReleaseProdOrder: TestPage "Released Production Order";
        ReleasedProductionOrderL: Record "Production Order";
        ProdOrderRoutingL: Record "Prod. Order Routing Line";
        ProductionOrderJournal: TestPage "Production Journal";
        ProductionOrderJournalL: Record "Item Journal Line";
        ProductionOrderLine: Record "Prod. Order Line";
        ProdOrderLines: TestPage "Released Prod. Order Lines";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        LineNo: Integer;
        ItemNo: Code[20];
        LocationCode: Code[10];
        WorkCenterL: Record "Work Center";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.28>>
        MfgSetupDisable.GET;
        MfgSetupDisable."Consump. Tolerance Limit FND" := false;
        MfgSetupDisable.MODIFY;
        UserSetup.RESET;
        UserSetup.MODIFYALL("Consump. Tolerance Warning FND", true);
        //<<HEI.28
        //Remove default setup HEI.10>>
        DefaultDimension.RESET;//HEI.35
        DefaultDimension.SETCURRENTKEY("Value Posting");//HEI.35
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.10<<

        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);
        //HEI.47>>
        Bin3.RESET;
        Bin3.SETRANGE("Location Code", Location.Code);
        Bin3.SETRANGE("Batch Production Resource FND", '');
        if Bin3.FINDSET then
            Bin3.MODIFYALL("Batch Production Resource FND", 'A');
        //HEI.47<<


        // 201221 >>
        //Check default value for WorkCenter
        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD075', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenterL.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenterL."No.";
        end;
        // 201221 <<

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD075', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD077', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //<<HEI.08
        //HEI.38>>
        /*
        PostInventory.SetInputValue(Item."No.",Location.Code,Zone.Code,Bin.Code,100000,'DTWTEST001','PRE101');
        PostInventory.USEREQUESTPAGE(FALSE);
        PostInventory.RUN;
        */
        UpdateInvDTWSetInputValue(Item."No.", Location.Code, Zone.Code, Bin.Code, 100000, 'DTWTEST001', 'PRE101');
        //HEI.38<<
        //>>HEI.08
        //Step 1: Login

        //Step 2 Open Firm Planned Production Order List page
        // FirmPlannedProdList.OPENEDIT;

        //Step 3 Open Firm Planned Production Order Document page
        FirmPlannedProdOrder.OPENNEW;

        //Step 4 Create New Firm Planned Production Order
        FirmPlannedProdOrder.NEW;
        FirmPlannedProdOrder."No.".ASSISTEDIT;
        FirmPlannedProdOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        FirmPlannedProdOrder."Source No.".SETVALUE(Item."No.");
        FirmPlannedProdOrder."Location Code".SETVALUE(Location.Code);
        FirmPlannedProdOrder."Zone Code".SETVALUE(Zone.Code);
        FirmPlannedProdOrder."Bin Code".SETVALUE(Bin.Code);
        FirmPlannedProdOrder.Quantity.SETVALUE(2);
        FirmPlannedProdOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := FirmPlannedProdOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::"Firm Planned";
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5 Execute "Refresh Production Order" Report
        //FirmPlannedProdOrder."<Action26>".INVOKE;
        //HEI.26<<
        ProductionOrderL.GET(ProductionOrderL.Status::"Firm Planned", ProductionOrderNo);
        FirmPlannedProdOrder.OK.INVOKE;
        FirmPlannedProdOrder.OPENEDIT;
        // FirmPlannedProdOrder.GOTORECORD(ProductionOrderL);
        FirmPlannedProdOrder.FILTER.SETFILTER("No.", ProductionOrderNo);
        //HEI.05
        FirmProdOrdLines.RESET;
        FirmProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if FirmProdOrdLines.FINDSET then;
        //HEI.05

        //Step 4: On the Line FastTab of Prod. Order page Click on Routing Version Code column to select another version
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            FirmProdOrdLines."Routing Version Code" := RoutingVersionCode;  //changing the Routing version code from Default to DEF02 (conf, essg handler)
                                                                            //FirmProdOrdLines.MODIFY;//HEI.35
        end;

        //Step 5 Change Production BOM Version Code Column From 'Default' to 'ALT2.0' in production Order Lines
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            FirmProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            //FirmProdOrdLines.MODIFY;//HEI.35
        end;
        FirmProdOrdLines.MODIFY;//HEI.35
        //HEI.05 <<
        //Step 6 Call Action "Change &Status" to change status from FPPO to RPO
        //FirmPlannedProdOrder.Action25.INVOKE; //BC UPGRADE PATHAA02
        FirmPlannedProdOrder."Change &Status".Invoke(); //BC UPGRADE PATHAA02
        // FirmPlannedProdList.CLOSE;

        //Step 7 GO to Release Production Order which is created By "Change Status" Action From firm Planned Prod Order Page
        ReleasedProductionOrderL.GET(ReleasedProductionOrderL.Status::Released, ProductionOrderNo);
        // ReleaseProdOrderList.OPENEDIT;
        // ReleaseProdOrderList.FINDFIRSTFIELD("No.",ProductionOrderNo);

        //Step 8 Open Release Prod Order Page
        ReleaseProdOrder.OPENEDIT;
        // ReleaseProdOrder.GOTORECORD(ReleasedProductionOrderL);
        ReleaseProdOrder.FILTER.SETFILTER("No.", ProductionOrderNo);
        //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06
                FilteredProdOrderRtngLineSet.RESET;//HEI.35
                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                //HEI.35>>
                //FilteredProdOrderRtngLineSet.FINDFIRST();
                if FilteredProdOrderRtngLineSet.FINDFIRST() then begin
                    //HEI.35<<
                    ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                    ProdOrderComponentL.MODIFY;
                    //HEI.45>>
                    //HEI.49>>
                    if Item2.GET(ProdOrderComponentL."Item No.") and Item2.Blocked then
                        Item2.MODIFYALL(Item2.Blocked, false, false);
                    //HEI.49<<
                    if Bin2.GET(ProdOrderComponentL."Location Code", ProdOrderComponentL."Bin Code") then
                        UpdateItemInvDTW2InitParameters(ProdOrderComponentL."Item No.", ProdOrderComponentL."Location Code", Bin2."Zone Code", ProdOrderComponentL."Bin Code", 100000, 'DTWTEST001', 'PRE101');
                    //HEI.45<<
                end;//HEI.35
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<

        //Step 9 Call "Routing" Action From Release Prod Order Lines
        ReleaseProdOrder.ProdOrderLines.Routing.INVOKE;

        FPPO := true;

        //Step 10 To Enter Consumption Quantities in Prod Order Component Page - //Code By Lokenath
        statusfilter := ReleasedProductionOrderL.Status;
        QuantityPer := 1;
        ReleaseProdOrder.ProdOrderLines.Components.INVOKE;

        //Step 11: To Enter Lots for Consumption in Prod Order Component Page - //Code By Lokenath
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                //HEI.44>>
                //CheckStocinBin(ProdOrderComponentL);//HEI.41
                //HEI.44<<
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                QuantityBase := 1;
                Item.GET(ItemNo);
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));

                ItemTrackLineConsumption := true; // TO Control assigning the Lot Nos for Consumption & Output lines
                if Item."Item Tracking Code" <> '' then
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 12 Close Prod Order Components Page
        ProdOrderComponentsL.OK.INVOKE;



        //Step 13 To Open Production Journal Page from Released Prod Order Page
        ReleaseProdOrder.ProdOrderLines.ProductionJournal.INVOKE;

        // ReleaseProdOrderList.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(QuantityPer);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        CLEAR(changestatusupdate);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(BinCode);
        CLEAR(LotNoOutput);

    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ChangeStatusPageHandler_PRD070,RoutingPageHandler_PRD078,ProdOrderComponentsPageHandler_PRD081,ItemTrackingLinesPageHandler_PRD070,ProductionJournalPageHandler_PRD070,MessageHandler,ConfirmationHandler,ItemTrackingSummaryPageHandler,AutoBatchNoGenerationRequestPage')]
    procedure RT_PRD070_CorrectConsumedorProducedQuantities_Packaging_8();
    var
        FirmPlannedProdList: TestPage "Firm Planned Prod. Orders";
        FirmPlannedProdOrder: TestPage "Firm Planned Prod. Order";
        ProdOrderRouting: TestPage "Prod. Order Routing";
        WorkCenter: Record "Work Center";
        Item: Record Item;
        Location: Record Location;
        Zone: Record Zone;
        Bin: Record Bin;
        ProductionOrderL: Record "Production Order";
        ReleaseProdOrderList: TestPage "Released Production Orders";
        ReleaseProdOrder: TestPage "Released Production Order";
        ReleasedProductionOrderL: Record "Production Order";
        ProdOrderRoutingL: Record "Prod. Order Routing Line";
        ProductionOrderJournal: TestPage "Production Journal";
        ProductionOrderJournalL: Record "Item Journal Line";
        ProductionOrderLine: Record "Prod. Order Line";
        ProdOrderLines: TestPage "Released Prod. Order Lines";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        LineNo: Integer;
        ItemNo: Code[20];
        LocationCode: Code[10];
        WorkCenterL: Record "Work Center";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
        ReservationEntryL: Record "Reservation Entry";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //Remove default setup HEI.10>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.10<<

        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);
        //HEI.47>>
        Bin3.RESET;
        Bin3.SETRANGE("Location Code", Location.Code);
        Bin3.SETRANGE("Batch Production Resource FND", '');
        if Bin3.FINDSET then
            Bin3.MODIFYALL("Batch Production Resource FND", 'A');
        //HEI.47<<
        // 201221 >>
        //Check default value for WorkCenter
        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD075', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenterL.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenterL."No.";
        end;
        // 201221 <<

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD075', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD077', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //<<HEI.08
        //HEI.38>>
        /*
        PostInventory.SetInputValue(Item."No.",Location.Code,Zone.Code,Bin.Code,100000,'DTWTEST001','PRE101');
        PostInventory.USEREQUESTPAGE(FALSE);
        PostInventory.RUN;
        */
        UpdateInvDTWSetInputValue(Item."No.", Location.Code, Zone.Code, Bin.Code, 100000, 'DTWTEST001', 'PRE101');
        //HEI.38<<
        //>>HEI.08
        //Step 1: Login

        //Step 2 Open Firm Planned Production Order List page
        // FirmPlannedProdList.OPENEDIT;

        //Step 3 Open Firm Planned Production Order Document page
        FirmPlannedProdOrder.OPENNEW;

        //Step 4 Create New Firm Planned Production Order
        FirmPlannedProdOrder.NEW;
        FirmPlannedProdOrder."No.".ASSISTEDIT;
        FirmPlannedProdOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        FirmPlannedProdOrder."Source No.".SETVALUE(Item."No.");
        FirmPlannedProdOrder."Location Code".SETVALUE(Location.Code);
        FirmPlannedProdOrder."Zone Code".SETVALUE(Zone.Code);
        FirmPlannedProdOrder."Bin Code".SETVALUE(Bin.Code);
        FirmPlannedProdOrder.Quantity.SETVALUE(2);
        FirmPlannedProdOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := FirmPlannedProdOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::"Firm Planned";
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5 Execute "Refresh Production Order" Report
        //FirmPlannedProdOrder."<Action26>".INVOKE;
        //HEI.26<<
        ProductionOrderL.GET(ProductionOrderL.Status::"Firm Planned", ProductionOrderNo);
        FirmPlannedProdOrder.OK.INVOKE;
        FirmPlannedProdOrder.OPENEDIT;
        // FirmPlannedProdOrder.GOTORECORD(ProductionOrderL);
        FirmPlannedProdOrder.FILTER.SETFILTER("No.", ProductionOrderNo);
        //HEI.05
        FirmProdOrdLines.RESET;
        FirmProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        FirmProdOrdLines.FINDSET;
        //HEI.05

        //Step 4: On the Line FastTab of Prod. Order page Click on Routing Version Code column to select another version
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            // FirmPlannedProdOrder.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);  //changing the Routing version code from Default to DEF02 (conf, essg handler)
            FirmProdOrdLines."Routing Version Code" := RoutingVersionCode;
            FirmProdOrdLines.MODIFY;
        end;


        //Step 5 Change Production BOM Version Code Column From 'Default' to 'ALT2.0' in production Order Lines
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //FirmPlannedProdOrder.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            FirmProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            FirmProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //Step 6 Call Action "Change &Status" from Firm Planned Prod Order Page
        //FirmPlannedProdOrder.Action25.INVOKE; //BC UPGRADE PATHAA02
        FirmPlannedProdOrder."Change &Status".Invoke(); //BC UPGRADE PATHAA02
        // FirmPlannedProdList.CLOSE;

        //Step 7 GO to Release Production Order which is created By "Change Status" Action From firm Planned Prod Order Page
        ReleasedProductionOrderL.GET(ReleasedProductionOrderL.Status::Released, ProductionOrderNo); //Go to release produciton order
                                                                                                    // ReleaseProdOrderList.OPENEDIT;
                                                                                                    // ReleaseProdOrderList.FINDFIRSTFIELD("No.",ProductionOrderNo);

        //Step 8 Open Release Prod Order Page
        ReleaseProdOrder.OPENEDIT;
        // ReleaseProdOrder.GOTORECORD(ReleasedProductionOrderL);
        ReleaseProdOrder.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.11 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
                //HEI.45>>
                //HEI.49>>
                if Item2.GET(ProdOrderComponentL."Item No.") and Item2.Blocked then
                    Item2.MODIFYALL(Item2.Blocked, false, false);
                //HEI.49<<
                if Bin2.GET(ProdOrderComponentL."Location Code", ProdOrderComponentL."Bin Code") then
                    UpdateItemInvDTW2InitParameters(ProdOrderComponentL."Item No.", ProdOrderComponentL."Location Code", Bin2."Zone Code", ProdOrderComponentL."Bin Code", 100000, 'DTWTEST001', 'PRE101');
            //HEI.45<<
            until ProdOrderComponentL.NEXT = 0;

        //HEI.11 <<

        //Step 9 Call "Routing" Action From Release Prod Order Lines
        ReleaseProdOrder.ProdOrderLines.Routing.INVOKE;
        FPPO := true;

        //Step 10 To Enter Consumption Quantities in Prod Order Component Page - //Code By Lokenath
        statusfilter := ReleasedProductionOrderL.Status;
        QuantityPer := 1;
        ReleaseProdOrder.ProdOrderLines.Components.INVOKE;

        //Step 11: To Enter Lots for Consumption in Prod Order Component Page - //Code By Lokenath
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                //HEI.44>>
                //CheckStocinBin(ProdOrderComponentL);//HEI.41
                //HEI.44<<
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                QuantityBase := 1;
                Item.GET(ItemNo);
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));

                ItemTrackLineConsumption := true; // TO Control assigning the Lot Nos for Consumption & Output lines
                if Item."Item Tracking Code" <> '' then
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 12 Close Prod Order Components Page
        ProdOrderComponentsL.OK.INVOKE;

        //Step 13 To Open Production Journal Page from Released Prod Order Page
        ReleaseProdOrder.ProdOrderLines.ProductionJournal.INVOKE;
        //Production Journal Page is handled by Function ProductionJournalPageHandler_PRD010

        //****** SB **********
        // Step 14 Correct  Consumed or Produced Quantities
        CorrectQty := true;
        // Option a Increase in Total Consumed/Produced Qty
        ReleaseProdOrder.ProdOrderLines.ProductionJournal.INVOKE;

        // Option b Decrease in Total Consumed/Produced Qty
        DecQty := true;

        // 201221 >>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD077', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);
        // 201221 <<
       //Kamnay01 BC upgrade  Fix >>
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Entry No.");
        ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
        ItemLedgerEntry.SETRANGE("Document No.", ProductionOrderNo);
        ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
        // ItemLedgerEntry.SETRANGE("Prod. Order Comp. Line No.", ProdOrderLineNo);
        if ItemLedgerEntry.FINDLAST then begin
            CorrEntryNo := ItemLedgerEntry."Entry No.";
            CorrectionLotNo := ItemLedgerEntry."Lot No.";
            CorrectionLotNo2 := ItemLedgerEntry."Lot No.";
        end else begin
            MESSAGE('ILE not yet posted. Skipping correction step for Item=%1 ProdOrder=%2', Item."No.", ProductionOrderNo);
            CorrEntryNo := 0;
            CorrectionLotNo := '';
        end;
        if (CorrEntryNo = 0) or (CorrectionLotNo = '') then
            exit;
        // proceed to journal
      //Kamnay01 BC upgrade  Fix <<
        ReleaseProdOrder.ProdOrderLines.ProductionJournal.INVOKE;

        // ReleaseProdOrderList.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(QuantityPer);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        CLEAR(changestatusupdate);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(BinCode);
        CLEAR(CorrectQty);
        CLEAR(CorrectionLotNo);
        CLEAR(CorrEntryNo);
        CLEAR(DecQty);
        CLEAR(LotNoOutput);
        // //yk>>

        // InventorySetupL.get();
        // InventorySetupL."Lotcheck" := false;
        // InventorySetupL.UT_LOTNO := '';
        // InventorySetupL.Modify(false);
        // //yk<<
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ChangeStatusPageHandler_PRD083_Packaging,RoutingPageHandler_PRD078,ProdOrderComponentsPageHandler_PRD081,ItemTrackingLinesPageHandler_PRD070,ProductionJournalPageHandler_PRD070,MessageHandler,ConfirmationHandler,ItemTrackingSummaryPageHandler,AutoBatchNoGenerationRequestPage')]
    procedure RT_PRD083_FinishRPO_Packaging_9();
    var
        FirmPlannedProdList: TestPage "Firm Planned Prod. Orders";
        FirmPlannedProdOrder: TestPage "Firm Planned Prod. Order";
        ProdOrderRouting: TestPage "Prod. Order Routing";
        WorkCenter: Record "Work Center";
        Item: Record Item;
        Location: Record Location;
        Zone: Record Zone;
        Bin: Record Bin;
        ProductionOrderL: Record "Production Order";
        ReleaseProdOrderList: TestPage "Released Production Orders";
        ReleaseProdOrder: TestPage "Released Production Order";
        ReleasedProductionOrderL: Record "Production Order";
        ProdOrderRoutingL: Record "Prod. Order Routing Line";
        ProductionOrderJournal: TestPage "Production Journal";
        ProductionOrderJournalL: Record "Item Journal Line";
        ProductionOrderLine: Record "Prod. Order Line";
        ProdOrderLines: TestPage "Released Prod. Order Lines";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        LineNo: Integer;
        ItemNo: Code[20];
        LocationCode: Code[10];
        WorkCenterL: Record "Work Center";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //Remove default setup HEI.10>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.10<<

        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);
        //HEI.47>>
        Bin3.RESET;
        Bin3.SETRANGE("Location Code", Location.Code);
        Bin3.SETRANGE("Batch Production Resource FND", '');
        if Bin3.FINDSET then
            Bin3.MODIFYALL("Batch Production Resource FND", 'A');
        //HEI.47<<
        // 201221 >>
        //Check default value for WorkCenter
        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD075', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenterL.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenterL."No.";
        end;
        // 201221 <<

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD075', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD077', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //Step 1: Login
        //<<HEI.09
        //HEI.38>>
        /*
        PostInventory.SetInputValue(Item."No.",Location.Code,Zone.Code,Bin.Code,100000,'DTWTEST001','PRE101');
        PostInventory.USEREQUESTPAGE(FALSE);
        PostInventory.RUN;
        */
        UpdateInvDTWSetInputValue(Item."No.", Location.Code, Zone.Code, Bin.Code, 100000, 'DTWTEST001', 'PRE101');
        //HEI.38<<
        //>>HEI.09

        //Step 2 Open Firm Planned Production Order List page
        // FirmPlannedProdList.OPENEDIT;

        //Step 3 Open Firm Planned Production Order Document page
        FirmPlannedProdOrder.OPENNEW;

        //Step 4 Create New Firm Planned Production Order
        FirmPlannedProdOrder.NEW;
        FirmPlannedProdOrder."No.".ASSISTEDIT;
        FirmPlannedProdOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        FirmPlannedProdOrder."Source No.".SETVALUE(Item."No.");
        FirmPlannedProdOrder."Location Code".SETVALUE(Location.Code);
        FirmPlannedProdOrder."Zone Code".SETVALUE(Zone.Code);
        FirmPlannedProdOrder."Bin Code".SETVALUE(Bin.Code);
        FirmPlannedProdOrder.Quantity.SETVALUE(2);
        FirmPlannedProdOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := FirmPlannedProdOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::"Firm Planned";
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5 Execute "Refresh Production Order" Report
        //FirmPlannedProdOrder."<Action26>".INVOKE;
        //HEI.26<<
        ProductionOrderL.GET(ProductionOrderL.Status::"Firm Planned", ProductionOrderNo);
        FirmPlannedProdOrder.OK.INVOKE;
        FirmPlannedProdOrder.OPENEDIT;
        // FirmPlannedProdOrder.GOTORECORD(ProductionOrderL);
        FirmPlannedProdOrder.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05
        FirmProdOrdLines.RESET;
        FirmProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        FirmProdOrdLines.FINDSET;
        //HEI.05

        //Step 4: On the Line FastTab of Prod. Order page Click on Routing Version Code column to select another version
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            //FirmPlannedProdOrder.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);  //changing the Routing version code from Default to DEF02 (conf, essg handler)
            FirmProdOrdLines."Routing Version Code" := RoutingVersionCode;
            FirmProdOrdLines.MODIFY;
        end;

        //Step 5 Change Production BOM Version Code Column From 'Default' to 'ALT2.0' in production Order Lines
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //FirmPlannedProdOrder.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            FirmProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            FirmProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //Step 6 Call Action "Change &Status"
        //FirmPlannedProdOrder.Action25.INVOKE; //BC UPGRADE PATHAA02
        FirmPlannedProdOrder."Change &Status".Invoke(); //BC UPGRADE PATHAA02
        // FirmPlannedProdList.CLOSE;

        //Step 7 GO to Release Production Order which is created By "Change Status" Action From firm Planned Prod Order Page
        ReleasedProductionOrderL.GET(ReleasedProductionOrderL.Status::Released, ProductionOrderNo); //Go to release produciton order
                                                                                                    // ReleaseProdOrderList.OPENEDIT;
                                                                                                    // ReleaseProdOrderList.FINDFIRSTFIELD("No.",ProductionOrderNo);

        //Step 8 Open Release Prod Order Page
        ReleaseProdOrder.OPENEDIT;
        // ReleaseProdOrder.GOTORECORD(ReleasedProductionOrderL);
        ReleaseProdOrder.FILTER.SETFILTER("No.", ProductionOrderNo);
        //HEI.11 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted 
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
                //HEI.45>>
                //HEI.49>>
                if Item2.GET(ProdOrderComponentL."Item No.") and Item2.Blocked then
                    Item2.MODIFYALL(Item2.Blocked, false, false);
                //HEI.49<<
                if Bin2.GET(ProdOrderComponentL."Location Code", ProdOrderComponentL."Bin Code") then
                    UpdateItemInvDTW2InitParameters(ProdOrderComponentL."Item No.", ProdOrderComponentL."Location Code", Bin2."Zone Code", ProdOrderComponentL."Bin Code", 100000, 'DTWTEST001', 'PRE101');
            //HEI.45<<
            until ProdOrderComponentL.NEXT = 0;

        //HEI.11 <<
        //Step 9 Call "Routing" Action From Release Prod Order Lines
        ReleaseProdOrder.ProdOrderLines.Routing.INVOKE;
        //Prod Order Routing Page is handled by Funciton RoutingPageHandler_PRD010

        FPPO := true;

        //Step 10 To Enter Consumption Quantities in Prod Order Component Page - //Code By Lokenath
        statusfilter := ReleasedProductionOrderL.Status;
        QuantityPer := 1;
        ReleaseProdOrder.ProdOrderLines.Components.INVOKE;

        //Step 11: To Enter Lots for Consumption in Prod Order Component Page - //Code By Lokenath
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                //HEI.44>>
                //CheckStocinBin(ProdOrderComponentL);//HEI.41
                //HEI.44<<
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                QuantityBase := 1;
                Item.GET(ItemNo);
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));

                ItemTrackLineConsumption := true; // TO Control assigning the Lot Nos for Consumption & Output lines
                if Item."Item Tracking Code" <> '' then
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 12 Close Prod Order Components Page
        ProdOrderComponentsL.OK.INVOKE;

        //Step 13 To Open Production Journal Page from Released Prod Order Page
        ReleaseProdOrder.ProdOrderLines.ProductionJournal.INVOKE;
        //Production Journal Page is handled by Function ProductionJournalPageHandler_PRD010

        //****** SB **********
        // Step 14 Correct  Consumed or Produced Quantities
        CorrectQty := true;
        // Option a Increase in Total Consumed/Produced Qty
        ReleaseProdOrder.ProdOrderLines.ProductionJournal.INVOKE;

        // Option b Decrease in Total Consumed/Produced Qty
        DecQty := true;

        // 201221 >>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD077', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);
        // 201221 <<
       //Kamnay01 BC upgrade  Fix >>
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Entry No.");
        ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
        ItemLedgerEntry.SETRANGE("Document No.", ProductionOrderNo);
        ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
        // ItemLedgerEntry.SETRANGE("Prod. Order Comp. Line No.", ProdOrderLineNo);
        if ItemLedgerEntry.FINDLAST then begin
            CorrEntryNo := ItemLedgerEntry."Entry No.";
            CorrectionLotNo := ItemLedgerEntry."Lot No.";
        end else begin
            MESSAGE('ILE not yet posted. Skipping correction step for Item=%1 ProdOrder=%2', Item."No.", ProductionOrderNo);
            CorrEntryNo := 0;
            CorrectionLotNo := '';
        end;
        if (CorrEntryNo = 0) or (CorrectionLotNo = '') then
            exit;
        // proceed to journal
      //Kamnay01 BC upgrade  Fix <<
        ReleaseProdOrder.ProdOrderLines.ProductionJournal.INVOKE;

        //Step 15 Call Action "Change &Status" from RPO to FPO
        //ReleaseProdOrder.Action53.INVOKE;//BC UPGRADE PATHAA02
        ReleaseProdOrder."Change &Status".Invoke(); //BC UPGRADE PATHAA02

        // ReleaseProdOrderList.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(QuantityPer);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        CLEAR(changestatusupdate);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(BinCode);
        CLEAR(CorrectQty);
        CLEAR(CorrectionLotNo);
        CLEAR(CorrEntryNo);
        CLEAR(DecQty);
        CLEAR(LotNoOutput);

    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ChangeStatusPageHandler_PRD083_Packaging,RoutingPageHandler_PRD078,ProdOrderComponentsPageHandler_PRD081,ItemTrackingLinesPageHandler_PRD070,ProductionJournalPageHandler_PRD070,MessageHandler,ConfirmationHandler,ItemTrackingSummaryPageHandler,AutoBatchNoGenerationRequestPage')] // BC Upgrade PATELP08 removed WhseItemTrackingLinesPageHandler_PRD080: CallItemTracking now opens std "Item Tracking Lines" (6510) handled by ItemTrackingLinesPageHandler_PRD070, so the Whse handler is never consumed
    procedure RT_PRD080_MoveFPstoLogistics_Packaging_10();
    var
        FirmPlannedProdList: TestPage "Firm Planned Prod. Orders";
        FirmPlannedProdOrder: TestPage "Firm Planned Prod. Order";
        ProdOrderRouting: TestPage "Prod. Order Routing";
        WorkCenter: Record "Work Center";
        Item: Record Item;
        Location: Record Location;
        Zone: Record Zone;
        Bin: Record Bin;
        ProductionOrderL: Record "Production Order";
        ReleaseProdOrderList: TestPage "Released Production Orders";
        ReleaseProdOrder: TestPage "Released Production Order";
        ReleasedProductionOrderL: Record "Production Order";
        ProdOrderRoutingL: Record "Prod. Order Routing Line";
        ProductionOrderJournal: TestPage "Production Journal";
        ProductionOrderJournalL: Record "Item Journal Line";
        ProductionOrderLine: Record "Prod. Order Line";
        ProdOrderLines: TestPage "Released Prod. Order Lines";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        LineNo: Integer;
        ItemNo: Code[20];
        LocationCode: Code[10];
        ItemL: Record Item;
        ZoneFromL: Record Zone;
        ZoneToL: Record Zone;
        BinL: Record Bin;
        LocationL: Record Location;
        ZoneWarehouseMovementList: TestPage "Zone Warehouse Movements"; //P50002
        ZoneWarehouseMovement: TestPage "Zone Warehouse Movement"; //P50000
        WorkCenterL: Record "Work Center";
        ZoneWhouseLine: Record "Warehouse Activity Line";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
        BinContent: Record "Bin Content";
        WhseEmployeeL: Record "Warehouse Employee"; // BC Upgrade PATELP08
        ItemUpdL: Record Item; // BC Upgrade PATELP08
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //Remove default setup HEI.10>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.10<<
        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD071', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);
        //HEI.47>>
        Bin3.RESET;
        Bin3.SETRANGE("Location Code", Location.Code);
        Bin3.SETRANGE("Batch Production Resource FND", '');
        if Bin3.FINDSET then
            Bin3.MODIFYALL("Batch Production Resource FND", 'A');
        //HEI.47<<
        // 201221 >>
        //Check default value for WorkCenter
        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD075', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenterL.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenterL."No.";
        end;
        // 201221 <<

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD075', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD077', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //<<HEI.08
        //HEI.38>>
        /*
        PostInventory.SetInputValue(Item."No.",Location.Code,Zone.Code,Bin.Code,100000,'DTWTEST001','PRE101');
        PostInventory.USEREQUESTPAGE(FALSE);
        PostInventory.RUN;
        */
        UpdateInvDTWSetInputValue(Item."No.", Location.Code, Zone.Code, Bin.Code, 100000, 'DTWTEST001', 'PRE101');
        //HEI.38<<
        //>>HEI.08
        //Step 1: Login

        //Step 2 Open Firm Planned Production Order List page
        // FirmPlannedProdList.OPENEDIT;

        //Step 3 Open Firm Planned Production Order Document page
        FirmPlannedProdOrder.OPENNEW;

        //Step 4 Create New Firm Planned Production Order
        FirmPlannedProdOrder.NEW;
        FirmPlannedProdOrder."No.".ASSISTEDIT;
        FirmPlannedProdOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        FirmPlannedProdOrder."Source No.".SETVALUE(Item."No.");
        FirmPlannedProdOrder."Location Code".SETVALUE(Location.Code);
        FirmPlannedProdOrder."Zone Code".SETVALUE(Zone.Code);
        FirmPlannedProdOrder."Bin Code".SETVALUE(Bin.Code);
        FirmPlannedProdOrder.Quantity.SETVALUE(2);
        FirmPlannedProdOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := FirmPlannedProdOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::"Firm Planned";
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5 Execute "Refresh Production Order" Report
        //FirmPlannedProdOrder."<Action26>".INVOKE;
        //HEI.26<<
        ProductionOrderL.GET(ProductionOrderL.Status::"Firm Planned", ProductionOrderNo);
        FirmPlannedProdOrder.OK.INVOKE;
        FirmPlannedProdOrder.OPENEDIT;
        // FirmPlannedProdOrder.GOTORECORD(ProductionOrderL);
        FirmPlannedProdOrder.FILTER.SETFILTER("No.", ProductionOrderNo);
        //HEI.16>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.16<<
        //HEI.05
        FirmProdOrdLines.RESET;
        FirmProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        FirmProdOrdLines.FINDSET;
        //HEI.05

        //Step 4: On the Line FastTab of Prod. Order page Click on Routing Version Code column to select another version
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            //FirmPlannedProdOrder.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode); //changing the Routing version code from Default to DEF02 (conf, essg handler)
            FirmProdOrdLines."Routing Version Code" := RoutingVersionCode;
            FirmProdOrdLines.MODIFY;
        end;
        //Step 5 Change Production BOM Version Code Column From 'Default' to 'ALT2.0' in production Order Lines
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //  FirmPlannedProdOrder.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode); su
            FirmProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            FirmProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //Step 6 Call Action "Change &Status" from Firm Planned Prod Order Page
        //FirmPlannedProdOrder.Action25.INVOKE; //BC UPGRADE PATHAA02
        FirmPlannedProdOrder."Change &Status".Invoke(); //BC UPGRADE PATHAA02

        // FirmPlannedProdList.CLOSE;

        //Step 7 GO to Release Production Order which is created By "Change Status" Action From firm Planned Prod Order Page
        ReleasedProductionOrderL.GET(ReleasedProductionOrderL.Status::Released, ProductionOrderNo);
        // ReleaseProdOrderList.OPENEDIT;
        // ReleaseProdOrderList.FINDFIRSTFIELD("No.",ProductionOrderNo);

        //Step 8 Open Release Prod Order Page
        ReleaseProdOrder.OPENEDIT;
        // ReleaseProdOrder.GOTORECORD(ReleasedProductionOrderL);
        ReleaseProdOrder.FILTER.SETFILTER("No.", ProductionOrderNo);
        //HEI.11 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
                //HEI.45>>
                //HEI.49>>
                if Item2.GET(ProdOrderComponentL."Item No.") and Item2.Blocked then
                    Item2.MODIFYALL(Item2.Blocked, false, false);
                //HEI.49<<
                if Bin2.GET(ProdOrderComponentL."Location Code", ProdOrderComponentL."Bin Code") then
                    UpdateItemInvDTW2InitParameters(ProdOrderComponentL."Item No.", ProdOrderComponentL."Location Code", Bin2."Zone Code", ProdOrderComponentL."Bin Code", 100000, 'DTWTEST001', 'PRE101');
            //HEI.45<<
            until ProdOrderComponentL.NEXT = 0;

        //HEI.11 <<
        //Step 9 Call "Routing" Action From Release Prod Order Lines
        ReleaseProdOrder.ProdOrderLines.Routing.INVOKE;

        FPPO := true;

        //Step 10 To Enter Consumption Quantities in Prod Order Component Page - //Code By Lokenath
        statusfilter := ReleasedProductionOrderL.Status;
        QuantityPer := 1;
        ReleaseProdOrder.ProdOrderLines.Components.INVOKE;

        //Step 11: To Enter Lots for Consumption in Prod Order Component Page - //Code By Lokenath
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                //HEI.44>>
                //CheckStocinBin(ProdOrderComponentL);//HEI.41
                //HEI.44<<
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                QuantityBase := 1;
                Item.GET(ItemNo);
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));

                ItemTrackLineConsumption := true; // TO Control assigning the Lot Nos for Consumption & Output lines
                if Item."Item Tracking Code" <> '' then
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 12 Close Prod Order Components Page
        ProdOrderComponentsL.OK.INVOKE;

        //Step 13 To Open Production Journal Page from Released Prod Order Page
        ReleaseProdOrder.ProdOrderLines.ProductionJournal.INVOKE;
        //Production Journal Page is handled by Function ProductionJournalPageHandler_PRD010

        //****** SB **********
        // Step 14 Correct  Consumed or Produced Quantities
        CorrectQty := true;
        // Option a Increase in Total Consumed/Produced Qty
        ReleaseProdOrder.ProdOrderLines.ProductionJournal.INVOKE;

        // Option b Decrease in Total Consumed/Produced Qty
        DecQty := true;
        // 201221 >>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD077', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);
        // 201221 <<
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Entry No.");
        ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
        ItemLedgerEntry.SETRANGE("Document No.", ProductionOrderNo);
        ItemLedgerEntry.SETRANGE("Item No.", Item."No.");    // 201221 >>
        ItemLedgerEntry.SETRANGE("Lot No.", CorrectionLotNo);
        if ItemLedgerEntry.FINDLAST then
            CorrEntryNo := ItemLedgerEntry."Entry No.";
        ReleaseProdOrder.ProdOrderLines.ProductionJournal.INVOKE;

        //Step 15 Call Action "Change &Status" from RPO to FPO
        //ReleaseProdOrder.Action53.INVOKE;//BC UPGRADE PATHAA02
        ReleaseProdOrder."Change &Status".Invoke();//BC UPGRADE PATHAA02
        //Change Status Action is handled By Function ChangeStatusPageHandler_PRD083
        // ReleaseProdOrderList.CLOSE;

        // Step 16 Move FPs to Logistics By -----------SB----------------

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD080', COMPANYNAME, DATABASE::Item);
        ItemL.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD080', COMPANYNAME, DATABASE::Location);
        LocationL.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD080', COMPANYNAME, DATABASE::Zone);
        ZoneFromL.GET(Location.Code, UnitTestingValues.Value);
        ZoneToL.GET(Location.Code, UnitTestingValues."Value 2");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD080', COMPANYNAME, DATABASE::Bin);
        BinL.GET(Location.Code, UnitTestingValues.Value);

        //Step 1: Login to Heilite

        //step 2: Open Zone Warehouse Movements List Page
        // ZoneWarehouseMovementList.OPENEDIT;
        //<<HEI.13
        //HEI.38>>
        /*
        PostInventory.SetInputValue(ItemL."No.",LocationL.Code,ZoneFromL.Code,BinL.Code,100000,'DTWTEST001','PRE101');
        PostInventory.USEREQUESTPAGE(FALSE);
        PostInventory.RUN;
        */
        UpdateInvDTWSetInputValue(ItemL."No.", LocationL.Code, ZoneFromL.Code, BinL.Code, 100000, 'DTWTEST001', 'PRE101');
        //HEI.38<<
        //>>HEI.13
        //HEI.21>>
        // BC Upgrade PATELP08 >> Pre-creating this Bin Content here (before the line's Item No. is
        // validated) collides with the CallUpdateRelatedActivityLine hook's own Bin Content insert
        // => "Bin Content already exists". Relocated below (after Item No. SETVALUE) so the hook
        // inserts first and we then correct its Zone Code. Commented out instead of deleted.
        // BinContent.RESET;
        // BinContent.SETRANGE("Location Code", LocationL.Code);
        // BinContent.SETRANGE("Bin Code", BinL.Code);
        // BinContent.SETRANGE("Item No.", ItemL."No.");
        // BinContent.SETRANGE("Variant Code", '');
        // BinContent.SETRANGE("Zone Code", ZoneFromL.Code);
        // if not BinContent.FINDFIRST then begin
        //     BinContent.INIT;
        //     BinContent."Location Code" := LocationL.Code;
        //     BinContent."Bin Code" := BinL.Code;
        //     BinContent."Item No." := ItemL."No.";
        //     BinContent."Variant Code" := '';
        //     BinContent."Unit of Measure Code" := ItemL."Base Unit of Measure";
        //     BinContent."Zone Code" := ZoneFromL.Code;
        //     BinContent.INSERT;
        // end;
        // BC Upgrade PATELP08 <<
        //HEI.21<<
        // BC Upgrade PATELP08 >> Page "Zone Warehouse Movement" OnOpenPage now runs
        // ErrorIfUserIsNotWhseEmployee(); ensure current user is a Warehouse Employee for the
        // location so opening the page does not pop up ModalPage 7328 "Warehouse Employees".
        WhseEmployeeL.RESET;
        WhseEmployeeL.SETRANGE("User ID", USERID);
        WhseEmployeeL.SETRANGE("Location Code", LocationL.Code);
        if WhseEmployeeL.ISEMPTY then begin
            WhseEmployeeL.INIT;
            WhseEmployeeL."User ID" := USERID;
            WhseEmployeeL."Location Code" := LocationL.Code;
            WhseEmployeeL.INSERT(true);
        end;
        // BC Upgrade PATELP08 <<
        //Step 3: Create new Zone Warehouse Movement
        ZoneWarehouseMovement.OPENNEW;
        ZoneWarehouseMovement.NEW;

        //AssistEdit to create a Doc No and add Details on General Tab
        ZoneWarehouseMovement."No.".ASSISTEDIT;
        ZoneWarehouseMovement."Location Code".SETVALUE(LocationL.Code);
        ZoneWarehouseMovement."Posting Date".SETVALUE(TODAY);
        ZoneWarehouseMovement."From Zone Code".SETVALUE(ZoneFromL.Code);
        ZoneWarehouseMovement."To Zone Code".SETVALUE(ZoneToL.Code);
        ZoneWarehouseMovement."Assigned User ID".SETVALUE(USERID);

        //Create Lines
        ZoneWarehouseMovement.WhseMovLines.NEW;
        ZoneWarehouseMovement.WhseMovLines."Item No.".SETVALUE(ItemL."No.");
        // BC Upgrade PATELP08 >> Item No. validation runs CallUpdateRelatedActivityLine, which inserts
        // a Bin Content for the From bin but stamps it with the wrong Zone Code. Fix the Zone Code to
        // ZoneFromL so the Bin Code validation (WMSMgt.FindBinContent ... Zone Code) finds it. If the
        // hook did not create it, insert it (replaces the relocated HEI.21 block above).
        if BinContent.GET(LocationL.Code, BinL.Code, ItemL."No.", '', ItemL."Base Unit of Measure") then begin
            if BinContent."Zone Code" <> ZoneFromL.Code then begin
                BinContent."Zone Code" := ZoneFromL.Code;
                BinContent.MODIFY;
            end;
        end else begin
            BinContent.INIT;
            BinContent."Location Code" := LocationL.Code;
            BinContent."Bin Code" := BinL.Code;
            BinContent."Item No." := ItemL."No.";
            BinContent."Variant Code" := '';
            BinContent."Unit of Measure Code" := ItemL."Base Unit of Measure";
            BinContent."Zone Code" := ZoneFromL.Code;
            BinContent.INSERT;
        end;
        // BC Upgrade PATELP08 <<
        ZoneWarehouseMovement.WhseMovLines.Quantity.SETVALUE(2);
        ZoneWarehouseMovement.WhseMovLines."Bin Code".SETVALUE(BinL.Code);
        ZoneWarehouseMovement.WhseMovLines."Due Date".SETVALUE(TODAY);

        //>>HEI.09
        //ItemTrackingLinesPageHandler_PRD070
        //HEI.38>>
        /*
        ZoneInventory.InitParameters(ItemL."No.",LocationL.Code,Zone.Code,BinL.Code,4000000,'TEST0001',LotNoOutput);
        ZoneInventory.USEREQUESTPAGE(FALSE);
        ZoneInventory.RUN;
        */
        UpdateItemInvDTW2InitParameters(ItemL."No.", LocationL.Code, Zone.Code, BinL.Code, 4000000, 'TEST0001', LotNoOutput);
        //HEI.38<<
        DecQty := false;
        ZoneMove := true;
        // BC Upgrade PATELP08 >> ROOT CAUSE: the HEI02 subscriber (Cod50280, OnAfterValidate of
        // "Unit of Measure Code") forces every Warehouse Activity Line UoM to Item."Inventory Unit of
        // Measure". This item has that field blank, so the line UoM is always cleared and
        // OpenItemTrackingLines' TESTFIELD("Unit of Measure Code") fails. Populate the item's Inventory
        // UoM with its base UoM so the forced value is valid. Re-GET the item fresh (ItemL is stale after
        // inventory posting; modifying it directly fails the rowversion "not up-to-date" check).
        if ItemUpdL.GET(ItemL."No.") then
            if ItemUpdL."Inventory Unit of Measure FND" = '' then begin
                ItemUpdL."Inventory Unit of Measure FND" := ItemUpdL."Base Unit of Measure";
                ItemUpdL.MODIFY;
            end;
        // Set UoM on the movement lines (table field 16 is Editable=false so a page SETVALUE is a no-op).
        // Move the page OFF the dirty Take line (onto the Place line) so its blank buffer is flushed and
        // can't overwrite the DB; set UoM on the lines; then re-point on the Take line so the page reloads
        // the populated UoM before tracking.
        ZoneWhouseLine.RESET;
        ZoneWhouseLine.SETRANGE("Activity Type", ZoneWhouseLine."Activity Type"::Movement);
        ZoneWhouseLine.SETRANGE("No.", ZoneWarehouseMovement."No.".VALUE);
        ZoneWhouseLine.SETRANGE("Action Type", ZoneWhouseLine."Action Type"::Place);
        if ZoneWhouseLine.FINDFIRST then
            ZoneWarehouseMovement.WhseMovLines.GOTORECORD(ZoneWhouseLine);
        ZoneWhouseLine.SETRANGE("Action Type");
        if ZoneWhouseLine.FINDSET(true) then
            repeat
                if (ZoneWhouseLine."Item No." <> '') and (ZoneWhouseLine."Unit of Measure Code" = '') then begin
                    ZoneWhouseLine.VALIDATE("Unit of Measure Code", ItemL."Base Unit of Measure");
                    ZoneWhouseLine.MODIFY(true);
                end;
            until ZoneWhouseLine.NEXT = 0;
        ZoneWhouseLine.SETRANGE("Action Type", ZoneWhouseLine."Action Type"::Take);
        if ZoneWhouseLine.FINDFIRST then
            ZoneWarehouseMovement.WhseMovLines.GOTORECORD(ZoneWhouseLine);
        // BC Upgrade PATELP08 <<
        ZoneWarehouseMovement.WhseMovLines.ItemTrackingLines.INVOKE;
        //ZoneWarehouseMovement.WhseMovLines."Lot No.".SETVALUE(LotNoOutput);//HEI.07 Code commented for change
        //>>HEI.07
        /*ZoneWhouseLine.RESET;
        ZoneWhouseLine.SETRANGE("Item No.",ItemL."No.");
        ZoneWhouseLine.SETRANGE("No.",ZoneWarehouseMovement."No.".VALUE);
        IF ZoneWhouseLine.FINDLAST THEN BEGIN
          ZoneWhouseLine.VALIDATE("Lot No.",LotNoOutput);
          ZoneWhouseLine.MODIFY;
        END;*/
        //<<HEI.07
        //<<HEI.09
        // Post Shipment
        //ZoneWarehouseMovement.Action7.INVOKE; //BC UPGRADE PATHAA02
        ZoneWarehouseMovement."Post Shipment".Invoke(); //BC UPGRADE PATHAA02

        ZoneWarehouseMovement.OK.INVOKE;  //close the Zone Warehouse Movement
                                          // ZoneWarehouseMovementList.OK.INVOKE;  //close Zone Warehouse Movement L

        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(QuantityPer);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        CLEAR(changestatusupdate);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(BinCode);
        CLEAR(CorrectQty);
        CLEAR(CorrectionLotNo);
        CLEAR(CorrEntryNo);
        CLEAR(DecQty);
        CLEAR(LotNoOutput);
        CLEAR(ZoneMove);

    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler')]
    procedure "RT_PRD042-CreateRPO_FilterCapacity_1"();
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //Step 1: Logon to Heilite
        //Step 2: Search for “Released Prod. Orders”

        // ReleasedProductionOrdersList.OPENEDIT;
        ReleasedProductionOrder.OPENNEW;

        //Step 3: Create a RPO and assign No series (page handler)
        ReleasedProductionOrder.NEW;
        ReleasedProductionOrder."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item Code, Location Code, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrder."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrder."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrder."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrder."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrder."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrder.Quantity.SETVALUE(1);
        ReleasedProductionOrder."Due Date".SETVALUE(TODAY);

        // Refresh Production Order to open the Refresh Production Order request page.
        //HEI.26>>
        ProductionOrderNo := ReleasedProductionOrder."No.".VALUE;
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //ReleasedProductionOrder."<Action26>".INVOKE;  //new page action
        //HEI.26>>
        ReleasedProductionOrder.CLOSE;
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler')]
    procedure RT_PRD040_CheckDefaultRouting_FilterCapacity_2();
    var
        ProdOrdLineL: Record "Prod. Order Line";
        FrimPlannedProdSubForm: TestPage "Firm Planned Prod. Order Lines";
        SKU: Record "Stockkeeping Unit";
        ProdOrdLineL2: Record "Prod. Order Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //Step 1: Logon to Heilite
        //Create a RPO
        // ReleasedProductionOrdersList.OPENEDIT;
        ReleasedProductionOrder.OPENNEW;
        ReleasedProductionOrder.NEW;
        ReleasedProductionOrder."No.".ASSISTEDIT;
        ReleasedProductionOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        ReleasedProductionOrder."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrder."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrder.Quantity.SETVALUE(1);
        ReleasedProductionOrder."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrder."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //step 2:
        //ReleasedProductionOrder."<Action26>".INVOKE; //calling new action created by Lokenath to refresh Production order
        //HEI.26>>
        ReleasedProductionOrder.OK.INVOKE;
        //Step 3:
        // ReleasedProductionOrdersList.FINDFIRSTFIELD("No.",ProductionOrderNo);
        ReleasedProductionOrder.OPENEDIT;
        ReleasedProductionOrder.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //Step 4: Click on Routing
        SKU.RESET;
        SKU.SETRANGE("Item No.", ReleasedProductionOrder.ProdOrderLines."Item No.".VALUE);
        //SKU.SETRANGE("Location Code",ReleasedProductionOrder.ProdOrderLines."Location Code".VALUE); //HEI.05
        SKU.SETRANGE("Location Code", RelProdOrdLines."Location Code"); //HEI.05
        if SKU.FINDFIRST then begin
            //HEI.07 - Commented for not required------------
            //ReleasedProductionOrder.ProdOrderLines."Routing No.".ASSERTEQUALS(SKU."Routing No."); // TO check if SKU and Production Lines have Same Routing No.

            ProdOrdLineL2.RESET;
            ProdOrdLineL2.SETRANGE(Status, ProdOrdLineL2.Status::Released);
            ProdOrdLineL2.SETRANGE("Prod. Order No.", RelProdOrdLines."Prod. Order No.");

            // BC Upgrade MISHRS14 >>
            // Removed false from FINDSET due to warning because its being depreceted
            //if ProdOrdLineL2.FINDSET(true, false) then
            if ProdOrdLineL2.FINDSET(true) then
                // BC Upgrade MISHRS14 <<

                repeat
                    ProdOrdLineL2."Routing No." := SKU."Routing No.";
                    ProdOrdLineL2.MODIFY;
                until ProdOrdLineL2.NEXT = 0;
            //HEI.07<<
        end;
        ReleasedProductionOrder.CLOSE;
        // ReleasedProductionOrdersList.CLOSE;
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_FilterCapacity')]
    procedure RT_PRD041_AdjustRouting_FilterCapacity_3();
    var
        ProductionOrderL: Record "Production Order";
        ProdOrderRouting: TestPage "Prod. Order Routing";
        WorkCenter: Record "Work Center";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
        ProdOrderComponentL: Record "Prod. Order Component";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD041', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenter.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenter."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD041', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        //Step 1: Logon to Heilite
        //Create a RPO
        // ReleasedProductionOrdersList.OPENEDIT;
        ReleasedProductionOrder.OPENNEW;
        ReleasedProductionOrder.NEW;
        ReleasedProductionOrder."No.".ASSISTEDIT;
        ReleasedProductionOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        ReleasedProductionOrder."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrder."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrder."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrder."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrder.Quantity.SETVALUE(1);
        ReleasedProductionOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //ReleasedProductionOrder."<Action26>".INVOKE; //calling new action created by Lokenath to refresh Production order
        //HEI.26>>
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        ReleasedProductionOrder.OK.INVOKE;

        ReleasedProductionOrder.OPENEDIT;
        // ReleasedProductionOrder.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrder.FILTER.SETFILTER("No.", ProductionOrderNo);
        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 <<

        //Step 4: On the Line FastTab of Prod. Order page Click on Routing Version Code column to select another version
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            // ReleasedProductionOrder.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode); //HEI.05 //changing the Routing version code from Default to Alt.02 (conf, essg handler)
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode; //HEI.05
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<

        //Step 5: On the Line tab of Prod. Order,Open Routing Page
        ReleasedProductionOrder.ProdOrderLines.Routing.INVOKE; //Line-->Routing (modal page handler)

        ReleasedProductionOrder.CLOSE;
        // ReleasedProductionOrdersList.CLOSE;
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderComponentPageHandler_FilterCapacity,MessageHandler')]
    procedure RT_PRD022_AdjustBOM_FilterCapacity_4();
    var
        ProductionOrderL: Record "Production Order";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD050', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //Step 1: Logon to Heilite
        //Create a RPO
        // ReleasedProductionOrdersList.OPENEDIT;
        ReleasedProductionOrder.OPENNEW;
        ReleasedProductionOrder.NEW;
        ReleasedProductionOrder."No.".ASSISTEDIT;
        ReleasedProductionOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        ReleasedProductionOrder."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrder."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrder.Quantity.SETVALUE(1);
        ReleasedProductionOrder."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrder."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 2:
        //ReleasedProductionOrder."<Action26>".INVOKE; //calling new action created by Lokenath to refresh Production order
        //HEI.26>>
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        ReleasedProductionOrder.OK.INVOKE;

        //Step 3: On the Line FastTab of Prod. Order page Click on Production BOM Version Code column to select another version
        ReleasedProductionOrder.OPENEDIT;
        // ReleasedProductionOrder.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrder.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //IF ReleasedProductionOrder.ProdOrderLines."Production BOM Version Code".VISIBLE THEN //HEI.05
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //ReleasedProductionOrder.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode) // Hei.05//To Change Productio BOM Version Code Column to 'Tango' in production Order Line
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end
        //HEI.05 >>
        else
            ERROR('Field "Production BOM Version Code" not visible on the page');
        ReleasedProductionOrder.ProdOrderLines.Components.INVOKE; // Line --> Component (Page Handler)
        ReleasedProductionOrder.CLOSE;
        // ReleasedProductionOrdersList.CLOSE;
    end;

    [Test]
    // [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_FilterCapacity,ProdOrderComponentPageHandler_FilterCapacity,ItemTrackingLinesPageHandler_FilterCapacity,MessageHandler,ConfirmationHandler_itemtracking,ItemTrackingSummaryPageHandler')] // BC Upgrade PATELP08 added ItemTrackingSummaryPageHandler (Select Entries opens ModalPage 6500)

    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_FilterCapacity,ProdOrderComponentPageHandler_FilterCapacity,ItemTrackingLinesPageHandler_FilterCapacity,MessageHandler,ConfirmationHandler_itemtracking')] // BC Upgrade PATELP08 added ItemTrackingSummaryPageHandler (Select Entries opens ModalPage 6500)
    procedure RT_PRD051_EnterConsumQtyToLotSelectionRPO_FilterCapacity_5();
    var
        ReleasedProductionOrdersListL: TestPage "Released Production Orders";
        ReleasedProductionOrderL: TestPage "Released Production Order";
        ItemL: Record Item;
        Item2L: Record Item;
        LocationL: Record Location;
        ZoneL: Record Zone;
        BinL: Record Bin;
        WorkCenterL: Record "Work Center";
        ProductionOrderL: Record "Production Order";
        ProdOrderRoutingL: TestPage "Prod. Order Routing";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        ItemTrackingLinesL: TestPage "Item Tracking Lines";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        // BC Upgrade PATELP08 >>
        // Reset correction-related globals at test start so leftover state from a prior
        // correction test (DecQty/CorrEntryNo) can't trigger "Appl.-from Item Entry" on this
        // pure consumption test -> "Source Subtype must not be 3" when suite runs together.
        CLEAR(CorrectQty);
        CLEAR(DecQty);
        CLEAR(CorrEntryNo);
        CLEAR(CorrectionLotNo);
        // BC Upgrade PATELP08 <<
        //HEI.01>> Successfully Tested
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Item);
        ItemL.GET(UnitTestingValues.Value);
        Item2L.GET(UnitTestingValues."Value 2");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Location);
        LocationL.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Zone);
        ZoneL.GET(LocationL.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Bin);
        BinL.GET(LocationL.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD041', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenterL.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenterL."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD041', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD050', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //Step 1: Logon to Heilite

        //Step 2: Search for “Released Prod. Orders”
        // ReleasedProductionOrdersListL.OPENEDIT;
        ReleasedProductionOrderL.OPENNEW;

        //Step 3: Create a RPO
        ReleasedProductionOrderL.NEW;
        ReleasedProductionOrderL."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item, Location, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrderL."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrderL."Source No.".SETVALUE(ItemL."No.");
        ReleasedProductionOrderL."Location Code".SETVALUE(LocationL.Code);
        ReleasedProductionOrderL."Zone Code".SETVALUE(ZoneL.Code);
        ReleasedProductionOrderL."Bin Code".SETVALUE(BinL.Code);
        ReleasedProductionOrderL.Quantity.SETVALUE(1);
        ReleasedProductionOrderL."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrderL."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5: Refresh Production Order
        //ReleasedProductionOrderL."<Action26>".INVOKE;
        //HEI.26>>

        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        ReleasedProductionOrderL.OK.INVOKE;
        ReleasedProductionOrderL.OPENEDIT;
        // ReleasedProductionOrderL.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.SETRANGE(Status, FirmProdOrdLines.Status::Released);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //Step 6: Modify Routing Version Code
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            // ReleasedProductionOrderL.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.34>>
        /*
        //HEI.14>>
        IF Location."To-Production Bin Code" = '' THEN
          Location."To-Production Bin Code" := Bin.Code;
        IF Location."From-Production Bin Code" = '' THEN
          Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<
        */
        if LocationL."To-Production Bin Code" = '' then
            LocationL."To-Production Bin Code" := Bin.Code;
        if LocationL."From-Production Bin Code" = '' then
            LocationL."From-Production Bin Code" := Bin.Code;
        LocationL.MODIFY;
        //HEI.34<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<
        //Step 7: Open Routing Page
        ReleasedProductionOrderL.ProdOrderLines.Routing.INVOKE;

        //Step 8: Modify Production BOM Version Code
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //Step 9: Status as Released
        statusfilter := statusfilter::Released;
        FPPO := false;

        //Step 10: Enter Consumption Quantities
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        statusfilter := ProductionOrderL.Status;

        QuantityPer := 2;
        ReleasedProductionOrderL.ProdOrderLines.Components.INVOKE;

        //Step 11: Enter Lots for Consumption
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                QuantityBase := 1;
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ItemL.GET(ItemNo);//HEI.52
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));
                if ItemL."Item Tracking Code" <> '' then //HEI.52
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 12: End Execution
        ProdOrderComponentsL.CLOSE;
        ReleasedProductionOrderL.CLOSE;
        // ReleasedProductionOrdersListL.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(changestatusupdate);
        CLEAR(QuantityPer);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(BinCode);
        CLEAR(QuantityPer);
        CLEAR(CorrectQty);
        CLEAR(DecQty);
        CLEAR(CorrectionLotNo);
        CLEAR(CorrEntryNo);
        CLEAR(BinCode);
        //HEI.01<< Successfully Tested

    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_FilterCapacity,ProdOrderComponentPageHandler_FilterCapacity,ItemTrackingLinesPageHandler_FilterCapacity,ProductionJournalPageHandler_PRD047,ItemTrackingSummaryPageHandler,ConfirmationHandler,MessageHandler')]
    procedure RT_PRD047_ConsumeComponentsProduceProducts_FilterCapacity_6();
    var
        ReleasedProductionOrdersListL: TestPage "Released Production Orders";
        ReleasedProductionOrderL: TestPage "Released Production Order";
        ItemL: Record Item;
        Item2L: Record Item;
        LocationL: Record Location;
        ZoneL: Record Zone;
        BinL: Record Bin;
        WorkCenterL: Record "Work Center";
        ProductionOrderL: Record "Production Order";
        ProdOrderRoutingL: TestPage "Prod. Order Routing";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        ItemTrackingLinesL: TestPage "Item Tracking Lines";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //Remove default setup HEI.28>>
        MfgSetupDisable.GET;
        MfgSetupDisable."Consump. Tolerance Limit FND" := false;
        MfgSetupDisable.MODIFY;
        UserSetup.RESET;
        UserSetup.MODIFYALL("Consump. Tolerance Warning FND", true);

        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.28<<
        //HEI.01>> Successfully Tested
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Item);
        ItemL.GET(UnitTestingValues.Value);
        Item2L.GET(UnitTestingValues."Value 2");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Location);
        LocationL.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Zone);
        ZoneL.GET(LocationL.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Bin);
        BinL.GET(LocationL.Code, UnitTestingValues.Value);
        //HEI.11>>
        NoSeries.RESET;
        NoSeries.SETFILTER(Code, '%1', '@*BIN*');
        if NoSeries.FINDLAST then
            BinL."Batch Sequential Number FND" := NoSeries.Code
        else begin
            NoSeries.RESET;
            NoSeries.SETFILTER(Code, '<>%1', '');
            if NoSeries.FINDLAST then
                BinL."Batch Sequential Number FND" := NoSeries.Code;
        end;
        BinL.MODIFY;
        //HEI.11<<
        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD041', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenterL.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenterL."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD041', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD050', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //Step 1: Logon to Heilite
        //HEI.11>>
        //HEI.38>>
        /*
        PostInventory.SetInputValue(ItemL."No.",LocationL.Code,ZoneL.Code,BinL.Code,100000,'DTWTEST001','PRE101');
        PostInventory.USEREQUESTPAGE(FALSE);
        PostInventory.RUN;
        */
        UpdateInvDTWSetInputValue(ItemL."No.", LocationL.Code, ZoneL.Code, BinL.Code, 100000, 'DTWTEST001', 'PRE101');
        //HEI.38<<
        //HEI.11<<
        //Step 2: Search for “Released Prod. Orders”
        // ReleasedProductionOrdersListL.OPENEDIT;
        ReleasedProductionOrderL.OPENNEW;

        //Step 3: Create a RPO
        ReleasedProductionOrderL.NEW;
        ReleasedProductionOrderL."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item, Location, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrderL."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrderL."Source No.".SETVALUE(ItemL."No.");
        ReleasedProductionOrderL."Location Code".SETVALUE(LocationL.Code);
        ReleasedProductionOrderL."Zone Code".SETVALUE(ZoneL.Code);
        ReleasedProductionOrderL."Bin Code".SETVALUE(BinL.Code);
        ReleasedProductionOrderL.Quantity.SETVALUE(1);
        ReleasedProductionOrderL."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrderL."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5: Refresh Production Order
        //ReleasedProductionOrderL."<Action26>".INVOKE;
        //HEI.26>>
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        ReleasedProductionOrderL.OK.INVOKE;
        ReleasedProductionOrderL.OPENEDIT;
        // ReleasedProductionOrderL.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);
        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //Step 6: Modify Routing Version Code
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.14>>
        if LocationL."To-Production Bin Code" = '' then //HEI.18
            LocationL."To-Production Bin Code" := BinL.Code;//HEI.18
        if LocationL."From-Production Bin Code" = '' then//HEI.18
            LocationL."From-Production Bin Code" := BinL.Code;//HEI.18
        LocationL.MODIFY;//HEI.18
        //HEI.14<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<

        //Step 7: Open Routing Page
        ReleasedProductionOrderL.ProdOrderLines.Routing.INVOKE;

        //Step 8: Modify Production BOM Version Code
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //Step 9: Status as Released
        statusfilter := statusfilter::Released;
        FPPO := false;

        //Step 10: Enter Consumption Quantities
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        statusfilter := ProductionOrderL.Status;

        QuantityPer := 2;
        ReleasedProductionOrderL.ProdOrderLines.Components.INVOKE;

        //Step 11: Enter Lots for Consumption
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                QuantityBase := 1;
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ItemL.GET(ItemNo);//HEI.52
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));

                ItemTrackLineConsumption := true; // TO Control assigning the Lot Nos for Consumption & Output lines
                                                  //HEI.54>>
                                                  //IF (ItemL."Item Tracking Code" <> '') THEN //HEI.52
                if (ItemL."Item Tracking Code" <> '') and (ItemL.Blocked <> true) then
                    //HEI.54<<
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 12 Close Prod Order Components Page
        ProdOrderComponentsL.OK.INVOKE;

        //Step 13 To Open Production Journal Page from Released Prod Order Page
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;
        //Production Journal Page is handled by Function ProductionJournalPageHandler_PRD010

        //Step 14: End Execution
        ReleasedProductionOrderL.CLOSE;
        // ReleasedProductionOrdersListL.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(QuantityPer);
        CLEAR(changestatusupdate);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(BinCode);
        //HEI.01<< Successfully Tested

    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_FilterCapacity,ProdOrderComponentPageHandler_FilterCapacity,ItemTrackingLinesPageHandler_FilterCapacity,ConfirmationHandler,MessageHandler,ProductionJournalPageHandler_PRD047,ItemTrackingSummaryPageHandler')]
    procedure RT_PRD046_CorrectConsumedorProducedQuantities_FilterCapacity_7();
    var
        ReleasedProductionOrdersListL: TestPage "Released Production Orders";
        ReleasedProductionOrderL: TestPage "Released Production Order";
        ItemL: Record Item;
        Item2L: Record Item;
        LocationL: Record Location;
        ZoneL: Record Zone;
        BinL: Record Bin;
        WorkCenterL: Record "Work Center";
        ProductionOrderL: Record "Production Order";
        ProdOrderRoutingL: TestPage "Prod. Order Routing";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        ItemTrackingLinesL: TestPage "Item Tracking Lines";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.28>>
        MfgSetupDisable.GET;
        MfgSetupDisable."Consump. Tolerance Limit FND" := false;
        MfgSetupDisable.MODIFY;
        UserSetup.RESET;
        UserSetup.MODIFYALL("Consump. Tolerance Warning FND", true);
        //<<HEI.28
        //Remove default setup HEI.28>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.28<<
        //HEI.01>> Successfully Tested
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Item);
        ItemL.GET(UnitTestingValues.Value);
        Item2L.GET(UnitTestingValues."Value 2");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Location);
        LocationL.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Zone);
        ZoneL.GET(LocationL.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Bin);
        BinL.GET(LocationL.Code, UnitTestingValues.Value);
        //HEI.11>>
        NoSeries.RESET;
        NoSeries.SETFILTER(Code, '%1', '@*BIN*');
        if NoSeries.FINDLAST then
            BinL."Batch Sequential Number FND" := NoSeries.Code
        else begin
            NoSeries.RESET;
            NoSeries.SETFILTER(Code, '<>%1', '');
            if NoSeries.FINDLAST then
                BinL."Batch Sequential Number FND" := NoSeries.Code;
        end;
        BinL.MODIFY;
        //HEI.11<<
        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD041', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenterL.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenterL."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD041', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD050', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //Step 1: Logon to Heilite
        //HEI.11>>
        //HEI.38>>
        /*
        PostInventory.SetInputValue(ItemL."No.",LocationL.Code,ZoneL.Code,BinL.Code,100000,'DTWTEST001','PRE101');
        PostInventory.USEREQUESTPAGE(FALSE);
        PostInventory.RUN;
        */
        UpdateInvDTWSetInputValue(ItemL."No.", LocationL.Code, ZoneL.Code, BinL.Code, 100000, 'DTWTEST001', 'PRE101');
        //HEI.38<<
        //HEI.11<<
        //Step 2: Search for “Released Prod. Orders”
        // ReleasedProductionOrdersListL.OPENEDIT;
        ReleasedProductionOrderL.OPENNEW;

        //Step 3: Create a RPO
        ReleasedProductionOrderL.NEW;
        ReleasedProductionOrderL."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item, Location, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrderL."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrderL."Source No.".SETVALUE(ItemL."No.");
        ReleasedProductionOrderL."Location Code".SETVALUE(LocationL.Code);
        ReleasedProductionOrderL."Zone Code".SETVALUE(ZoneL.Code);
        ReleasedProductionOrderL."Bin Code".SETVALUE(BinL.Code);
        ReleasedProductionOrderL.Quantity.SETVALUE(1);
        ReleasedProductionOrderL."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrderL."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;

        //Step 5: Refresh Production Order
        //ReleasedProductionOrderL."<Action26>".INVOKE;
        //HEI.26>>
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        ReleasedProductionOrderL.OK.INVOKE;
        ReleasedProductionOrderL.OPENEDIT;
        // ReleasedProductionOrderL.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //Step 6: Modify Routing Version Code
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.14>>
        if LocationL."To-Production Bin Code" = '' then//HEI.18
            LocationL."To-Production Bin Code" := BinL.Code;//HEI.18
        if LocationL."From-Production Bin Code" = '' then//HEI.18
            LocationL."From-Production Bin Code" := BinL.Code;//HEI.18
        LocationL.MODIFY;//HEI.18
        //HEI.14<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06
                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<
        //Step 7: Open Routing Page
        ReleasedProductionOrderL.ProdOrderLines.Routing.INVOKE;

        //Step 8: Modify Production BOM Version Code
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>

        //Step 9: Status as Released
        statusfilter := statusfilter::Released;
        FPPO := false;

        //Step 10: Enter Consumption Quantities
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        statusfilter := ProductionOrderL.Status;

        QuantityPer := 1;
        ReleasedProductionOrderL.ProdOrderLines.Components.INVOKE;

        //Step 11: Enter Lots for Consumption
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                QuantityBase := 1;
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ItemL.GET(ItemNo);//HEI.52
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));

                ItemTrackLineConsumption := true; // TO Control assigning the Lot Nos for Consumption & Output lines
                                                  //HEI.54>>
                                                  //IF (ItemL."Item Tracking Code" <> '') THEN //HEI.52
                if (ItemL."Item Tracking Code" <> '') and (ItemL.Blocked <> true) then
                    //HEI.54<<
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 12 Close Prod Order Components Page
        ProdOrderComponentsL.OK.INVOKE;

        //Step 13 To Open Production Journal Page from Released Prod Order Page
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;
        //Production Journal Page is handled by Function ProductionJournalPageHandler_PRD010

        // Step 14 Correct  Consumed or Produced Quantities
        CorrectQty := true;
        // Option a Increase in Total Consumed/Produced Qty
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;

        // Option b Decrease in Total Consumed/Produced Qty
        DecQty := true;
        // 201221 >>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD046', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);
        // 201221 <<
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Entry No.");
        ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
        ItemLedgerEntry.SETRANGE("Document No.", ProductionOrderNo);
        ItemLedgerEntry.SETRANGE("Item No.", Item."No.");    // 201221 >>
        ItemLedgerEntry.SETRANGE("Lot No.", CorrectionLotNo);
        if ItemLedgerEntry.FINDLAST then
            CorrEntryNo := ItemLedgerEntry."Entry No.";
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;
        // proceed to journal
      //Kamnay01 BC upgrade  Fix <<


        //Step 15: End Execution
        // ReleasedProductionOrdersListL.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(changestatusupdate);
        CLEAR(QuantityPer);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(CorrectionLotNo);
        CLEAR(CorrectQty);
        CLEAR(CorrEntryNo);
        CLEAR(DecQty);
        CLEAR(BinCode);
        //HEI.01<< Successfully Tested

    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_FilterCapacity,ProdOrderComponentPageHandler_FilterCapacity,ItemTrackingLinesPageHandler_FilterCapacity,ConfirmationHandler,MessageHandler,ProductionJournalPageHandler_PRD047,ChangeStatustoFPOPageHandler_PRD052,ItemTrackingSummaryPageHandler')]
    procedure RT_PRD052_FinsihRPO_FilterCapacity_8();
    var
        ReleasedProductionOrdersListL: TestPage "Released Production Orders";
        ReleasedProductionOrderL: TestPage "Released Production Order";
        ItemL: Record Item;
        Item2L: Record Item;
        LocationL: Record Location;
        ZoneL: Record Zone;
        BinL: Record Bin;
        WorkCenterL: Record "Work Center";
        ProductionOrderL: Record "Production Order";
        ProdOrderRoutingL: TestPage "Prod. Order Routing";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        ItemTrackingLinesL: TestPage "Item Tracking Lines";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.01>> Successfully Tested
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Item);
        ItemL.GET(UnitTestingValues.Value);
        Item2L.GET(UnitTestingValues."Value 2");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Location);
        LocationL.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Zone);
        ZoneL.GET(LocationL.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Bin);
        BinL.GET(LocationL.Code, UnitTestingValues.Value);
        //HEI.11>>
        NoSeries.RESET;
        NoSeries.SETFILTER(Code, '%1', '@*BIN*');
        if NoSeries.FINDLAST then
            BinL."Batch Sequential Number FND" := NoSeries.Code
        else begin
            NoSeries.RESET;
            NoSeries.SETFILTER(Code, '<>%1', '');
            if NoSeries.FINDLAST then
                BinL."Batch Sequential Number FND" := NoSeries.Code;
        end;
        BinL.MODIFY;
        //HEI.11<<
        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD041', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenterL.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenterL."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD041', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD050', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //Step 1: Logon to Heilite
        //HEI.11>>
        //HEI.38>>
        /*
        PostInventory.SetInputValue(ItemL."No.",LocationL.Code,ZoneL.Code,BinL.Code,100000,'DTWTEST001','PRE101');
        PostInventory.USEREQUESTPAGE(FALSE);
        PostInventory.RUN;
        */
        UpdateInvDTWSetInputValue(ItemL."No.", LocationL.Code, ZoneL.Code, BinL.Code, 100000, 'DTWTEST001', 'PRE101');
        //HEI.38<<
        //HEI.11<<
        //Step 2: Search for “Released Prod. Orders”
        // ReleasedProductionOrdersListL.OPENEDIT;
        ReleasedProductionOrderL.OPENNEW;

        //Step 3: Create a RPO
        ReleasedProductionOrderL.NEW;
        ReleasedProductionOrderL."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item, Location, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrderL."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrderL."Source No.".SETVALUE(ItemL."No.");
        ReleasedProductionOrderL."Location Code".SETVALUE(LocationL.Code);
        ReleasedProductionOrderL."Zone Code".SETVALUE(ZoneL.Code);
        ReleasedProductionOrderL."Bin Code".SETVALUE(BinL.Code);
        ReleasedProductionOrderL.Quantity.SETVALUE(1);
        ReleasedProductionOrderL."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrderL."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5: Refresh Production Order
        //ReleasedProductionOrderL."<Action26>".INVOKE;
        //HEI.26>>
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        ReleasedProductionOrderL.OK.INVOKE;
        ReleasedProductionOrderL.OPENEDIT;
        // ReleasedProductionOrderL.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //Step 6: Modify Routing Version Code
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.14>>
        if LocationL."To-Production Bin Code" = '' then//HEI.18
            LocationL."To-Production Bin Code" := BinL.Code;//HEI.18
        if LocationL."From-Production Bin Code" = '' then//HEI.18
            LocationL."From-Production Bin Code" := BinL.Code;//HEI.18
        LocationL.MODIFY;//HEI.18
        //HEI.14<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat    //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<
        //Step 7: Open Routing Page

        ReleasedProductionOrderL.ProdOrderLines.Routing.INVOKE;

        //Step 8: Modify Production BOM Version Code
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //Step 9: Status as Released
        statusfilter := statusfilter::Released;
        FPPO := false;

        //Step 10: Enter Consumption Quantities
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        statusfilter := ProductionOrderL.Status;

        QuantityPer := 1;
        ReleasedProductionOrderL.ProdOrderLines.Components.INVOKE;

        //Step 11: Enter Lots for Consumption
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                QuantityBase := 1;
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ItemL.GET(ItemNo);//HEI.52
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));

                ItemTrackLineConsumption := true; // TO Control assigning the Lot Nos for Consumption & Output lines
                                                  //HEI.54>>
                                                  //IF (ItemL."Item Tracking Code" <> '') THEN //HEI.52
                if (ItemL."Item Tracking Code" <> '') and (ItemL.Blocked <> true) then
                    //HEI.54<<
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 12 Close Prod Order Components Page
        ProdOrderComponentsL.OK.INVOKE;

        //Step 13 To Open Production Journal Page from Released Prod Order Page
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;
        //Production Journal Page is handled by Function ProductionJournalPageHandler_PRD010

        // Step 14 Correct  Consumed or Produced Quantities
        CorrectQty := true;
        // Option a Increase in Total Consumed/Produced Qty
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;

        // Option b Decrease in Total Consumed/Produced Qty
        DecQty := true;
        // 201221 >>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD046', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);
        // 201221 <<
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Entry No.");
        ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
        ItemLedgerEntry.SETRANGE("Document No.", ProductionOrderNo);
        ItemLedgerEntry.SETRANGE("Item No.", Item."No.");  // 201221 >>
        ItemLedgerEntry.SETRANGE("Lot No.", CorrectionLotNo);
        if ItemLedgerEntry.FINDLAST then
            CorrEntryNo := ItemLedgerEntry."Entry No.";
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;

        //Step 15 Call Action "Change &Status" from RPO to FPO
        //ReleasedProductionOrderL.Action53.INVOKE;//BC UPGRADE PATHAA02
        ReleasedProductionOrderL."Change &Status".Invoke(); //BC UPGRADE PATHAA02
        //Change Status Action is handled By Function ChangeStatusPageHandler_PRD026

        //Step 15: End Execution
        // ReleasedProductionOrdersListL.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(changestatusupdate);
        CLEAR(QuantityPer);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(CorrectionLotNo);
        CLEAR(CorrectQty);
        CLEAR(CorrEntryNo);
        CLEAR(DecQty);
        CLEAR(BinCode);
        //HEI.01<< Successfully Tested

    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler')]
    procedure RT_PRD055_CreateRPO_FilterationMixing_1();
    begin
        //HEI.01>>
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //Step 1: Logon to Heilite
        //Step 2: Search for “Released Prod. Orders”

        // ReleasedProductionOrdersList.OPENEDIT;       //Optimization

        CLEAR(ReleasedProductionOrder);//HEI.39
        ReleasedProductionOrder.OPENNEW;
        //Step 3: Create a RPO
        ReleasedProductionOrder.NEW;
        ReleasedProductionOrder."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item Code, Location Code, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrder."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrder."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrder."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrder."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrder."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrder.Quantity.SETVALUE(1);
        ReleasedProductionOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        // Refresh Production Order to open the Refresh Production Order request page.
        // ReleasedProductionOrder."<Action26>".INVOKE;  // SB Created a copy of function RefreshProductionOrder to RunReport without TransactionType Update
        //HEI.26>>
        // Close Released Prod. Orders Page
        ReleasedProductionOrder.OK.INVOKE;
        // ReleasedProductionOrdersList.CLOSE;        //Optimization
        //HEI.01<<
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler')]
    procedure RT_PRD053_CheckDefaultRouting_FilterationMixing_2();
    var
        ProdOrdLineL: Record "Prod. Order Line";
        FrimPlannedProdSubForm: TestPage "Firm Planned Prod. Order Lines";
        SKU: Record "Stockkeeping Unit";
        ProductionOrderL: Record "Production Order";
        ProdOrdLineL2: Record "Prod. Order Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //Step 1: Logon to Heilite
        //Create a RPO
        // ReleasedProductionOrdersList.OPENEDIT;       //Optimization
        CLEAR(ReleasedProductionOrder);//HEI.39
        ReleasedProductionOrder.OPENNEW;
        ReleasedProductionOrder.NEW;
        ReleasedProductionOrder."No.".ASSISTEDIT;
        ReleasedProductionOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        ReleasedProductionOrder."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrder."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrder.Quantity.SETVALUE(1);
        ReleasedProductionOrder."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrder."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //step 2:
        // ReleasedProductionOrder."<Action26>".INVOKE; //calling new action created by Lokenath to refresh Production order
        // ReleasedProductionOrder.OK.INVOKE;
        //HEI.26>>
        //Step 3:
        // ReleasedProductionOrdersList.FINDFIRSTFIELD("No.",ProductionOrderNo);
        // ReleasedProductionOrder.FILTER.SETFILTER("No.",ProductionOrderNo);
        // ReleasedProductionOrder.OPENEDIT;
        //Step 4: Click on Routing

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 <<

        SKU.RESET;
        SKU.SETRANGE("Item No.", ReleasedProductionOrder.ProdOrderLines."Item No.".VALUE);
        //SKU.SETRANGE("Location Code",ReleasedProductionOrder.ProdOrderLines."Location Code".VALUE); //HEI.05
        SKU.SETRANGE("Location Code", RelProdOrdLines."Location Code"); //HEI.05
        if SKU.FINDFIRST then begin
            //HEI.07 - Commented for not required------------
            //ReleasedProductionOrder.ProdOrderLines."Routing No.".ASSERTEQUALS(SKU."Routing No."); // TO check if SKU and Production Lines have Same Routing No.

            ProdOrdLineL2.RESET;
            ProdOrdLineL2.SETRANGE(Status, ProdOrdLineL2.Status::Released);
            ProdOrdLineL2.SETRANGE("Prod. Order No.", RelProdOrdLines."Prod. Order No.");

            // BC Upgrade MISHRS14 >>
            // Removed false from FINDSET due to warning because its being depreceted
            //if ProdOrdLineL2.FINDSET(true, false) then
            if ProdOrdLineL2.FINDSET(true) then
                // BC Upgrade MISHRS14 <<

                repeat
                    ProdOrdLineL2."Routing No." := SKU."Routing No.";
                    ProdOrdLineL2.MODIFY;
                until ProdOrdLineL2.NEXT = 0;
            //HEI.07<<
        end;
        ReleasedProductionOrder.OK.INVOKE;
        // ReleasedProductionOrder.CLOSE;
        // ReleasedProductionOrdersList.CLOSE;           //Optimization
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_FilterationMixing')]
    procedure RT_PRD054_AdjustRouting_FilterationMixing_3();
    var
        ProductionOrderL: Record "Production Order";
        ProdOrderRouting: TestPage "Prod. Order Routing";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
        ProdOrderComponentL: Record "Prod. Order Component";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //Remove default setup HEI.28>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.28<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD054', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenter.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenter."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD054', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        //Step 1: Logon to Heilite
        //Create a RPO
        // ReleasedProductionOrdersList.OPENEDIT;
        CLEAR(ReleasedProductionOrder);//HEI.39
        ReleasedProductionOrder.OPENNEW;
        ReleasedProductionOrder.NEW;
        ReleasedProductionOrder."No.".ASSISTEDIT;
        ReleasedProductionOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        ReleasedProductionOrder."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrder."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrder."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrder."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrder.Quantity.SETVALUE(1);
        ReleasedProductionOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //ReleasedProductionOrder."<Action26>".INVOKE; //calling new action created by Lokenath to refresh Production order
        //HEI.26>>
        // ProductionOrderL.GET(ProductionOrderL.Status::Released,ProductionOrderNo); //Optimization
        ReleasedProductionOrder.OK.INVOKE;

        ReleasedProductionOrder.OPENEDIT;
        // ReleasedProductionOrder.GOTORECORD(ProductionOrderL);    //Optimization
        ReleasedProductionOrder.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //Step 4: On the Line FastTab of Prod. Order page Click on Routing Version Code column to select another version
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            //ReleasedProductionOrder.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);  //changing the Routing version code from Default to Alt.02 (conf, essg handler)
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<

        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<

        //Step 5: On the Line tab of Prod. Order,Open Routing Page
        ReleasedProductionOrder.ProdOrderLines.Routing.INVOKE; //Line-->Routing (modal page handler)

        ReleasedProductionOrder.CLOSE;
        // ReleasedProductionOrdersList.CLOSE;
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderComponentPageHandler_PRD066,MessageHandler')]
    procedure RT_PRD066_AdjustBOM_FilterationMixing_4();
    var
        ProductionOrderL: Record "Production Order";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD066', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //Step 1: Logon to Heilite
        //Create a RPO
        // ReleasedProductionOrdersList.OPENEDIT;
        CLEAR(ReleasedProductionOrder);//HEI.39
        ReleasedProductionOrder.OPENNEW;
        ReleasedProductionOrder.NEW;
        ReleasedProductionOrder."No.".ASSISTEDIT;
        ReleasedProductionOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        ReleasedProductionOrder."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrder."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrder.Quantity.SETVALUE(1);
        ReleasedProductionOrder."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrder."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 2:
        //ReleasedProductionOrder."<Action26>".INVOKE; //calling new action created by Lokenath to refresh Production order
        //HEI.26>>
        // ProductionOrderL.GET(ProductionOrderL.Status::Released,ProductionOrderNo);   //Optimization
        ReleasedProductionOrder.OK.INVOKE;

        //Step 3: On the Line FastTab of Prod. Order page Click on Production BOM Version Code column to select another version
        ReleasedProductionOrder.OPENEDIT;
        // ReleasedProductionOrder.GOTORECORD(ProductionOrderL);    //Optimization
        ReleasedProductionOrder.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //IF ReleasedProductionOrder.ProdOrderLines."Production BOM Version Code".VISIBLE THEN //HEI.05
        //HEI.05 <<
        // IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //ReleasedProductionOrder.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode)  //To Change Productio BOM Version Code Column to 'DEF 2' in production Order Line
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end
        //HEI.05 <<
        else
            ERROR('Field "Production BOM Version Code" not visible on the page');
        ReleasedProductionOrder.ProdOrderLines.Components.INVOKE; // Line --> Component (Page Handler)
        ReleasedProductionOrder.CLOSE;
        // ReleasedProductionOrdersList.CLOSE;
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_FilterationMixing,ProdOrderComponentPageHandler_PRD066,ItemTrackingLinesPageHandler_FilterationMixing,MessageHandler,ConfirmationHandler_itemtracking')]
    procedure RT_PRD059_ResourceSelectionOfAvailableTanks_FilterationMixing_5();
    var
        ReleasedProductionOrdersListL: TestPage "Released Production Orders";
        ReleasedProductionOrderL: TestPage "Released Production Order";
        ProductionOrderL: Record "Production Order";
        StockkeepingUnitL: Record "Stockkeeping Unit";
        ProdOrderRoutingL: TestPage "Prod. Order Routing";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        ItemTrackingLinesL: TestPage "Item Tracking Lines";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
        ProdOrdLineL2: Record "Prod. Order Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        // BC Upgrade PATELP08 >>
        // Reset so the Item Tracking handler deterministically uses the non-SelectEntries path (no Item Tracking Summary page)
        CLEAR(ItemTrackLineConsumption);
        // BC Upgrade PATELP08 <<
        //HEI.01>> Successfully Tested
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD054', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenter.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenter."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD054', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD066', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //Step 1: Logon to Heilite

        //Step 2: Search for “Released Prod. Orders”
        // ReleasedProductionOrdersListL.OPENEDIT;
        ReleasedProductionOrderL.OPENNEW;

        //Step 3: Create a RPO
        ReleasedProductionOrderL.NEW;
        ReleasedProductionOrderL."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item, Location, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrderL."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrderL."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrderL."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrderL."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrderL."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrderL.Quantity.SETVALUE(1);
        ReleasedProductionOrderL."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrderL."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5: Refresh Production Order
        //ReleasedProductionOrderL."<Action26>".INVOKE;
        //HEI.26>>
        // ProductionOrderL.GET(ProductionOrderL.Status::Released,ProductionOrderNo);   //Optimization
        ReleasedProductionOrderL.OK.INVOKE;
        ReleasedProductionOrderL.OPENEDIT;
        // ReleasedProductionOrderL.GOTORECORD(ProductionOrderL);   //Optimization
        ReleasedProductionOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //Step 6: Check Routing
        StockkeepingUnitL.RESET;
        StockkeepingUnitL.SETRANGE("Item No.", ReleasedProductionOrderL.ProdOrderLines."Item No.".VALUE);
        //StockkeepingUnitL.SETRANGE("Location Code",ReleasedProductionOrderL.ProdOrderLines."Location Code".VALUE); //HEI.05
        StockkeepingUnitL.SETRANGE("Location Code", RelProdOrdLines."Location Code"); //HEI.05
        if StockkeepingUnitL.FIND('-') then begin
            //HEI.07 - Commented for not required------------
            // ReleasedProductionOrderL.ProdOrderLines."Routing No.".ASSERTEQUALS(StockkeepingUnitL."Routing No.");
            ProdOrdLineL2.RESET;
            ProdOrdLineL2.SETRANGE(Status, ProdOrdLineL2.Status::Released);
            ProdOrdLineL2.SETRANGE("Prod. Order No.", RelProdOrdLines."Prod. Order No.");

            // BC Upgrade MISHRS14 >>
            // Removed false from FINDSET due to warning because its being depreceted
            //if ProdOrdLineL2.FINDSET(true, false) then
            if ProdOrdLineL2.FINDSET(true) then
                // BC Upgrade MISHRS14 <<

                repeat
                    ProdOrdLineL2."Routing No." := StockkeepingUnitL."Routing No.";
                    ProdOrdLineL2.MODIFY;
                until ProdOrdLineL2.NEXT = 0;
            //HEI.07<<
        end;


        //Step 7: Modify Routing Version Code
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            // ReleasedProductionOrderL.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<

        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<
        //Step 8: Open Routing Page
        ReleasedProductionOrderL.ProdOrderLines.Routing.INVOKE;

        //Step 9: Modify Production BOM Version Code
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //Step 10: Status as Released
        statusfilter := statusfilter::Released;
        FPPO := false;

        //Step 11: Adjust BoM, Enter Consumption Quantities, Resource Selection of Available Tanks, Enter Negative Consumption Quantities
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        statusfilter := ProductionOrderL.Status;

        QuantityPer := 1;
        ReleasedProductionOrderL.ProdOrderLines.Components.INVOKE;

        //Step 12: Enter Lots for Consumption
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                QuantityBase := 1;
                Item.GET(ItemNo);
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);   //Optimization
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));
                //HEI.54>>
                //IF (Item."Item Tracking Code" <> '') THEN
                if (Item."Item Tracking Code" <> '') and (Item.Blocked <> true) then
                    //HEI.54<<
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 13: End Execution
        ProdOrderComponentsL.CLOSE;
        ReleasedProductionOrderL.CLOSE;
        // ReleasedProductionOrdersListL.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(QuantityPer);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(BinCode);
        //HEI.01<< Successfully Tested
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_FilterationMixing,ProdOrderComponentPageHandler_PRD066,ItemTrackingLinesPageHandler_FilterationMixing,MessageHandler,ConfirmationHandler_itemtracking')]
    procedure RT_PRD067_EnterConsumptionQuantitiesBatchBin_FilterationMixing_6();
    var
        ReleasedProductionOrdersListL: TestPage "Released Production Orders";
        ReleasedProductionOrderL: TestPage "Released Production Order";
        ProductionOrderL: Record "Production Order";
        StockkeepingUnitL: Record "Stockkeeping Unit";
        ProdOrderRoutingL: TestPage "Prod. Order Routing";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        ItemTrackingLinesL: TestPage "Item Tracking Lines";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
        ProdOrdLineL2: Record "Prod. Order Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        // BC Upgrade PATELP08 >>
        // Reset so the Item Tracking handler deterministically uses the non-SelectEntries path (no Item Tracking Summary page)
        CLEAR(ItemTrackLineConsumption);
        // BC Upgrade PATELP08 <<
        //Remove default setup HEI.10>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.10<<

        //HEI.01>> Successfully Tested
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD054', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenter.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenter."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD054', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD066', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //Step 1: Logon to Heilite

        //Step 2: Search for “Released Prod. Orders”
        // ReleasedProductionOrdersListL.OPENEDIT;
        ReleasedProductionOrderL.OPENNEW;

        //Step 3: Create a RPO
        ReleasedProductionOrderL.NEW;
        ReleasedProductionOrderL."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item, Location, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrderL."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrderL."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrderL."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrderL."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrderL."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrderL.Quantity.SETVALUE(1);
        ReleasedProductionOrderL."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrderL."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5: Refresh Production Order
        //ReleasedProductionOrderL."<Action26>".INVOKE;
        //HEI.26>>
        // ProductionOrderL.GET(ProductionOrderL.Status::Released,ProductionOrderNo); //Optimization
        ReleasedProductionOrderL.OK.INVOKE;
        ReleasedProductionOrderL.OPENEDIT;
        // ReleasedProductionOrderL.GOTORECORD(ProductionOrderL);   //Optimization
        ReleasedProductionOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //Step 6: Check Routing
        StockkeepingUnitL.SETRANGE("Item No.", ReleasedProductionOrderL.ProdOrderLines."Item No.".VALUE);
        //StockkeepingUnitL.SETRANGE("Location Code",ReleasedProductionOrderL.ProdOrderLines."Location Code".VALUE); //HEI.05
        StockkeepingUnitL.SETRANGE("Location Code", RelProdOrdLines."Location Code"); //HEI.05
        if StockkeepingUnitL.FIND('-') then begin
            //HEI.07 - Commented for not required------------
            // ReleasedProductionOrderL.ProdOrderLines."Routing No.".ASSERTEQUALS(StockkeepingUnitL."Routing No.");
            ProdOrdLineL2.RESET;
            ProdOrdLineL2.SETRANGE(Status, ProdOrdLineL2.Status::Released);
            ProdOrdLineL2.SETRANGE("Prod. Order No.", RelProdOrdLines."Prod. Order No.");

            // BC Upgrade MISHRS14 >>
            // Removed false from FINDSET due to warning because its being depreceted
            //if ProdOrdLineL2.FINDSET(true, false) then
            if ProdOrdLineL2.FINDSET(true) then
                // BC Upgrade MISHRS14 <<

                repeat
                    ProdOrdLineL2."Routing No." := StockkeepingUnitL."Routing No.";
                    ProdOrdLineL2.MODIFY;
                until ProdOrdLineL2.NEXT = 0;
            //HEI.07<<
        end;

        //Step 7: Modify Routing Version Code
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 <<
        //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<

        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<

        //Step 8: Open Routing Page
        ReleasedProductionOrderL.ProdOrderLines.Routing.INVOKE;

        //Step 9: Modify Production BOM Version Code
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //Step 10: Status as Released
        statusfilter := statusfilter::Released;
        FPPO := false;

        //Step 11: Adjust BoM, Enter Consumption Quantities, Resource Selection of Available Tanks, Enter Negative Consumption Quantities
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        statusfilter := ProductionOrderL.Status;

        QuantityPer := 1;
        ReleasedProductionOrderL.ProdOrderLines.Components.INVOKE;

        //Step 12: Enter Lots for Consumption
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                QuantityBase := 1;
                Item.GET(ItemNo);
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));
                //HEI.54>>
                //IF (Item."Item Tracking Code" <> '') THEN
                if (Item."Item Tracking Code" <> '') and (Item.Blocked <> true) then
                    //HEI.54<<
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 13: End Execution
        ProdOrderComponentsL.CLOSE;
        ReleasedProductionOrderL.CLOSE;
        // ReleasedProductionOrdersListL.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(QuantityPer);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(CorrectQty);
        CLEAR(DecQty);
        CLEAR(CorrectionLotNo);
        CLEAR(CorrEntryNo);
        CLEAR(BinCode);
        //HEI.01<< Successfully Tested
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_FilterationMixing,ProdOrderComponentPageHandler_PRD066,ItemTrackingLinesPageHandler_FilterationMixing,ProductionJournalPageHandler_PRD061,ConfirmationHandler,MessageHandler,ItemTrackingSummaryPageHandler')]
    procedure RT_PRD061_ConsumeComponentsProduceProducts_FilterationMixing_7();
    var
        ReleasedProductionOrdersListL: TestPage "Released Production Orders";
        ReleasedProductionOrderL: TestPage "Released Production Order";
        StockkeepingUnitL: Record "Stockkeeping Unit";
        ProductionOrderL: Record "Production Order";
        ProdOrderRoutingL: TestPage "Prod. Order Routing";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        ItemTrackingLinesL: TestPage "Item Tracking Lines";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
        ProdOrdLineL2: Record "Prod. Order Line";
        Bin1: Record Bin;
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.13>>
        MfgSetupDisable.GET;
        MfgSetupDisable."Consump. Tolerance Limit FND" := false;
        MfgSetupDisable.MODIFY;
        UserSetup.RESET;
        UserSetup.MODIFYALL("Consump. Tolerance Warning FND", true);
        //<<HEI.13
        //Remove default setup HEI.10>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.10<<

        //HEI.01>> Successfully Tested
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD054', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenter.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenter."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD054', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD066', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //<<HEI.08
        //HEI.38>>
        /*
        PostInventory.SetInputValue(Item."No.",Location.Code,Zone.Code,Bin.Code,1000,'DTWTEST001','PRE101');
        PostInventory.USEREQUESTPAGE(FALSE);
        PostInventory.RUN;
        */
        UpdateInvDTWSetInputValue(Item."No.", Location.Code, Zone.Code, Bin.Code, 1000, 'DTWTEST001', 'PRE101');
        //HEI.38<<
        //>>HEI.08
        //Step 1: Logon to Heilite

        //Step 2: Search for “Released Prod. Orders”
        // ReleasedProductionOrdersListL.OPENEDIT;
        ReleasedProductionOrderL.OPENNEW;

        //Step 3: Create a RPO
        ReleasedProductionOrderL.NEW;
        ReleasedProductionOrderL."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item, Location, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrderL."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrderL."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrderL."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrderL."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrderL."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrderL.Quantity.SETVALUE(1);
        ReleasedProductionOrderL."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrderL."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5: Refresh Production Order
        //ReleasedProductionOrderL."<Action26>".INVOKE;
        //HEI.26>>
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);   //Optimization
        ReleasedProductionOrderL.OK.INVOKE;
        ReleasedProductionOrderL.OPENEDIT;
        // ReleasedProductionOrderL.GOTORECORD(ProductionOrderL);   //Optimization
        ReleasedProductionOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //Step 6: Check Routing
        StockkeepingUnitL.SETRANGE("Item No.", ReleasedProductionOrderL.ProdOrderLines."Item No.".VALUE);
        //StockkeepingUnitL.SETRANGE("Location Code",ReleasedProductionOrderL.ProdOrderLines."Location Code".VALUE); //HEI.05
        StockkeepingUnitL.SETRANGE("Location Code", RelProdOrdLines."Location Code"); //HEI.05
        if StockkeepingUnitL.FIND('-') then begin
            //HEI.07 - Commented for not required------------
            // ReleasedProductionOrderL.ProdOrderLines."Routing No.".ASSERTEQUALS(StockkeepingUnitL."Routing No.");
            ProdOrdLineL2.RESET;
            ProdOrdLineL2.SETRANGE(Status, ProdOrdLineL2.Status::Released);
            ProdOrdLineL2.SETRANGE("Prod. Order No.", RelProdOrdLines."Prod. Order No.");

            // BC Upgrade MISHRS14 >>
            // Removed false from FINDSET due to warning because its being depreceted
            //if ProdOrdLineL2.FINDSET(true, false) then
            if ProdOrdLineL2.FINDSET(true) then
                // BC Upgrade MISHRS14 <<
                repeat
                    ProdOrdLineL2."Routing No." := StockkeepingUnitL."Routing No.";
                    ProdOrdLineL2.MODIFY;
                until ProdOrdLineL2.NEXT = 0;
            //HEI.07<<
        end;

        //Step 7: Modify Routing Version Code
        //HEI.05 <<

        // IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                //HEI.29>>
                if ProdOrderComponentL."Bin Code" <> Bin.Code then begin
                    Bin1.GET(ProdOrderComponentL."Location Code", ProdOrderComponentL."Bin Code");
                    ProdOrderComponentL."Zone Code FND" := Bin1."Zone Code";
                end;
                //HEI.29<<
                ProdOrderComponentL.MODIFY;
                //HEI.27>>
                ItemRound.GET(ProdOrderComponentL."Item No.");
                ItemRound."Rounding Precision" := 0.001;
                ItemRound.MODIFY;
            //HEI.27<<
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<
        //Step 8: Open Routing Page
        ReleasedProductionOrderL.ProdOrderLines.Routing.INVOKE;

        //Step 9: Modify Production BOM Version Code
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            // ReleasedProductionOrderL.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>



        //Step 10: Status as Released
        statusfilter := statusfilter::Released;
        FPPO := false;

        //Step 11: Adjust BoM, Enter Consumption Quantities, Resource Selection of Available Tanks, Enter Negative Consumption Quantities
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        statusfilter := ProductionOrderL.Status;

        QuantityPer := 1;
        ReleasedProductionOrderL.ProdOrderLines.Components.INVOKE;

        //Step 12: To Enter Lots for Consumption in Prod Order Component Page
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                QuantityBase := 2;
                Item.GET(ItemNo);
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));

                ItemTrackLineConsumption := true; // TO Control assigning the Lot Nos for Consumption & Output lines
                                                  //HEI.54>>
                                                  //IF (Item."Item Tracking Code" <> '') THEN BEGIN //HEI.53
                if (Item."Item Tracking Code" <> '') and (Item.Blocked <> true) then begin
                    //HEI.54<<
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
                    //ItemTrackingLines page is handled by function ItemTrackingLinesPageHandler_PRD010
                    //HEI.53>>
                    if FORMAT(ProdOrderComponentsL."Lot No.") <> '' then
                        DeleteComponentIfInsufficientQty(ProdOrderComponentL, FORMAT(ProdOrderComponentsL."Lot No."));
                end;
            //HEI.53<<
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 13 Close Prod Order Components Page
        ProdOrderComponentsL.OK.INVOKE;

        //Step 14 To Open Production Journal Page from Released Prod Order Page
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;
        //Production Journal Page is handled by Function ProductionJournalPageHandler_PRD010

        ReleasedProductionOrderL.CLOSE;
        // ReleasedProductionOrdersListL.CLOSE;

        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(QuantityPer);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(BinCode);

    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_FilterationMixing,ProdOrderComponentPageHandler_PRD066,ItemTrackingLinesPageHandler_FilterationMixing,ProductionJournalPageHandler_PRD061,MessageHandler,ConfirmationHandler,ChangeStatustoFPOPageHandler_PRD069,ItemTrackingSummaryPageHandler')]
    procedure RT_PRD069_FinishRPO_FilterationMixing_8();
    var
        ReleasedProductionOrdersListL: TestPage "Released Production Orders";
        ReleasedProductionOrderL: TestPage "Released Production Order";
        StockkeepingUnitL: Record "Stockkeeping Unit";
        ProductionOrderL: Record "Production Order";
        ProdOrderRoutingL: TestPage "Prod. Order Routing";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        ItemTrackingLinesL: TestPage "Item Tracking Lines";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
        ProdOrdLineL2: Record "Prod. Order Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.13>>
        MfgSetupDisable.GET;
        MfgSetupDisable."Consump. Tolerance Limit FND" := false;
        MfgSetupDisable.MODIFY;
        UserSetup.RESET;
        UserSetup.MODIFYALL("Consump. Tolerance Warning FND", true);
        //<<HEI.13
        //Remove default setup HEI.10>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.10<<

        //HEI.01>> Successfully Tested
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD054', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenter.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenter."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD054', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD066', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //<<HEI.08
        //HEI.38>>
        /*
        PostInventory.SetInputValue(Item."No.",Location.Code,Zone.Code,Bin.Code,100000,'DTWTEST001','PRE101');
        PostInventory.USEREQUESTPAGE(FALSE);
        PostInventory.RUN;
        */
        UpdateInvDTWSetInputValue(Item."No.", Location.Code, Zone.Code, Bin.Code, 100000, 'DTWTEST001', 'PRE101');
        //HEI.38<<
        //>>HEI.08

        //Step 1: Logon to Heilite

        //Step 2: Search for “Released Prod. Orders”
        // ReleasedProductionOrdersListL.OPENEDIT;
        ReleasedProductionOrderL.OPENNEW;

        //Step 3: Create a RPO
        ReleasedProductionOrderL.NEW;
        ReleasedProductionOrderL."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item, Location, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrderL."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrderL."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrderL."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrderL."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrderL."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrderL.Quantity.SETVALUE(1);
        ReleasedProductionOrderL."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrderL."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5: Refresh Production Order
        //ReleasedProductionOrderL."<Action26>".INVOKE;
        //HEI.26>>
        // ProductionOrderL.GET(ProductionOrderL.Status::Released,ProductionOrderNo);
        ReleasedProductionOrderL.OK.INVOKE;
        ReleasedProductionOrderL.OPENEDIT;
        // ReleasedProductionOrderL.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //Step 6: Check Routing
        StockkeepingUnitL.SETRANGE("Item No.", ReleasedProductionOrderL.ProdOrderLines."Item No.".VALUE);
        //StockkeepingUnitL.SETRANGE("Location Code",ReleasedProductionOrderL.ProdOrderLines."Location Code".VALUE); //HEI.05
        StockkeepingUnitL.SETRANGE("Location Code", RelProdOrdLines."Location Code"); //HEI.05
        if StockkeepingUnitL.FIND('-') then begin
            //HEI.07 - Commented for not required------------
            // ReleasedProductionOrderL.ProdOrderLines."Routing No.".ASSERTEQUALS(StockkeepingUnitL."Routing No.");
            ProdOrdLineL2.RESET;
            ProdOrdLineL2.SETRANGE(Status, ProdOrdLineL2.Status::Released);
            ProdOrdLineL2.SETRANGE("Prod. Order No.", RelProdOrdLines."Prod. Order No.");

            // BC Upgrade MISHRS14 >>
            // Removed false from FINDSET due to warning because its being depreceted
            //if ProdOrdLineL2.FINDSET(true, false) then
            if ProdOrdLineL2.FINDSET(true) then
                // BC Upgrade MISHRS14 <<

                repeat
                    ProdOrdLineL2."Routing No." := StockkeepingUnitL."Routing No.";
                    ProdOrdLineL2.MODIFY;
                until ProdOrdLineL2.NEXT = 0;
            //HEI.07<<
        end;

        //Step 7: Modify Routing Version Code
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
                //HEI.27>>
                ItemRound.GET(ProdOrderComponentL."Item No.");
                ItemRound."Rounding Precision" := 0.001;
                ItemRound.MODIFY;
            //HEI.27<<
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<

        //Step 8: Open Routing Page
        ReleasedProductionOrderL.ProdOrderLines.Routing.INVOKE;

        //Step 9: Modify Production BOM Version Code
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //Step 10: Status as Released
        statusfilter := statusfilter::Released;
        FPPO := false;

        //Step 11: Adjust BoM, Enter Consumption Quantities, Resource Selection of Available Tanks, Enter Negative Consumption Quantities
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        statusfilter := ProductionOrderL.Status;

        QuantityPer := 1;
        ReleasedProductionOrderL.ProdOrderLines.Components.INVOKE;

        //Step 12: To Enter Lots for Consumption in Prod Order Component Page
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                QuantityBase := 2;
                Item.GET(ItemNo);
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));

                ItemTrackLineConsumption := true; // TO Control assigning the Lot Nos for Consumption & Output lines
                                                  //HEI.54>>
                                                  //IF (Item."Item Tracking Code" <> '') THEN BEGIN //HEI.53
                if (Item."Item Tracking Code" <> '') and (Item.Blocked <> true) then begin
                    //HEI.54<<
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
                    //ItemTrackingLines page is handled by function ItemTrackingLinesPageHandler_PRD010
                    //HEI.53>>
                    if FORMAT(ProdOrderComponentsL."Lot No.") <> '' then
                        DeleteComponentIfInsufficientQty(ProdOrderComponentL, FORMAT(ProdOrderComponentsL."Lot No."));
                end;
            //HEI.53<<
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 13 Close Prod Order Components Page
        ProdOrderComponentsL.OK.INVOKE;

        //Step 14 To Open Production Journal Page from Released Prod Order Page
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;
        //Production Journal Page is handled by Function ProductionJournalPageHandler_PRD010

        //Step 15 Call Action "Change &Status" from RPO to FPO
        //ReleasedProductionOrderL.Action53.INVOKE; //BC UPGRADE PATHAA02
        ReleasedProductionOrderL."Change &Status".invoke(); //BC UPGRADE PATHAA02
        // ReleasedProductionOrdersListL.CLOSE;

        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(QuantityPer);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(FPPO);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(CorrectQty);
        CLEAR(DecQty);
        CLEAR(CorrectionLotNo);
        CLEAR(CorrEntryNo);
        CLEAR(BinCode);

    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_FilterationMixing,ProdOrderComponentPageHandler_PRD066,ItemTrackingLinesPageHandler_FilterationMixing,ProductionJournalPageHandler_PRD061,MessageHandler,ConfirmationHandler,ChangeStatustoFPOPageHandler_PRD069,ItemTrackingSummaryPageHandler')]
    procedure RT_PRD062_ReceiveProductstoQualityHoldstatus_FilterationMixing_9();
    var
        ReleasedProductionOrdersListL: TestPage "Released Production Orders";
        ReleasedProductionOrderL: TestPage "Released Production Order";
        StockkeepingUnitL: Record "Stockkeeping Unit";
        ProductionOrderL: Record "Production Order";
        ProdOrderRoutingL: TestPage "Prod. Order Routing";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        ItemTrackingLinesL: TestPage "Item Tracking Lines";
        QuantityStatus: Option "Quality Hold",Unrestricted,Blocked,Concession,Rejected,Pending;
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
        ProdOrdLineL2: Record "Prod. Order Line";
    begin

        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.13>>
        MfgSetupDisable.GET;
        MfgSetupDisable."Consump. Tolerance Limit FND" := false;
        MfgSetupDisable.MODIFY;
        UserSetup.RESET;
        UserSetup.MODIFYALL("Consump. Tolerance Warning FND", true);
        //<<HEI.13
        //Remove default setup HEI.10>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.10<<

        //HEI.01>> Successfully Tested
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD054', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenter.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenter."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD054', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD066', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //<<HEI.08
        //HEI.38>>
        /*
        PostInventory.SetInputValue(Item."No.",Location.Code,Zone.Code,Bin.Code,100000,'DTWTEST001','PRE101');
        PostInventory.USEREQUESTPAGE(FALSE);
        PostInventory.RUN;
        */
        UpdateInvDTWSetInputValue(Item."No.", Location.Code, Zone.Code, Bin.Code, 100000, 'DTWTEST001', 'PRE101');
        //HEI.38<<
        //>>HEI.08

        //Step 1: Logon to Heilite

        //Step 2: Search for “Released Prod. Orders”
        // ReleasedProductionOrdersListL.OPENEDIT;
        ReleasedProductionOrderL.OPENNEW;

        //Step 3: Create a RPO
        ReleasedProductionOrderL.NEW;
        ReleasedProductionOrderL."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item, Location, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrderL."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrderL."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrderL."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrderL."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrderL."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrderL.Quantity.SETVALUE(1);
        ReleasedProductionOrderL."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrderL."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5: Refresh Production Order
        //ReleasedProductionOrderL."<Action26>".INVOKE;
        //HEI.26>>
        // ProductionOrderL.GET(ProductionOrderL.Status::Released,ProductionOrderNo);   //Optimization
        ReleasedProductionOrderL.OK.INVOKE;
        ReleasedProductionOrderL.OPENEDIT;
        // ReleasedProductionOrderL.GOTORECORD(ProductionOrderL);   //Optimization
        ReleasedProductionOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 <<

        //Step 6: Check Routing
        StockkeepingUnitL.SETRANGE("Item No.", ReleasedProductionOrderL.ProdOrderLines."Item No.".VALUE);
        //StockkeepingUnitL.SETRANGE("Location Code",ReleasedProductionOrderL.ProdOrderLines."Location Code".VALUE); //HEI.05
        StockkeepingUnitL.SETRANGE("Location Code", RelProdOrdLines."Location Code"); //HEI.05
        if StockkeepingUnitL.FIND('-') then begin
            //HEI.07 - Commented for not required------------
            // ReleasedProductionOrderL.ProdOrderLines."Routing No.".ASSERTEQUALS(StockkeepingUnitL."Routing No.");
            ProdOrdLineL2.RESET;
            ProdOrdLineL2.SETRANGE(Status, ProdOrdLineL2.Status::Released);
            ProdOrdLineL2.SETRANGE("Prod. Order No.", RelProdOrdLines."Prod. Order No.");

            // BC Upgrade MISHRS14 >>
            // Removed false from FINDSET due to warning because its being depreceted
            //if ProdOrdLineL2.FINDSET(true, false) then
            if ProdOrdLineL2.FINDSET(true) then
                // BC Upgrade MISHRS14 <<

                repeat
                    ProdOrdLineL2."Routing No." := StockkeepingUnitL."Routing No.";
                    ProdOrdLineL2.MODIFY;
                until ProdOrdLineL2.NEXT = 0;
            //HEI.07<<
        end;

        //Step 7: Modify Routing Version Code
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            // ReleasedProductionOrderL.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
                //HEI.27>>
                ItemRound.GET(ProdOrderComponentL."Item No.");
                ItemRound."Rounding Precision" := 0.001;
                ItemRound.MODIFY;
            //HEI.27<<
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<

        //Step 8: Open Routing Page
        ReleasedProductionOrderL.ProdOrderLines.Routing.INVOKE;

        //Step 9: Modify Production BOM Version Code
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //Step 10: Status as Released
        statusfilter := statusfilter::Released;
        FPPO := false;

        //Step 11: Adjust BoM, Enter Consumption Quantities, Resource Selection of Available Tanks, Enter Negative Consumption Quantities
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        statusfilter := ProductionOrderL.Status;

        QuantityPer := 1;
        ReleasedProductionOrderL.ProdOrderLines.Components.INVOKE;

        //Step 12: To Enter Lots for Consumption in Prod Order Component Page
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                QuantityBase := 2;
                Item.GET(ItemNo);
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));

                ItemTrackLineConsumption := true; // TO Control assigning the Lot Nos for Consumption & Output lines
                                                  //HEI.54>>
                                                  //IF (Item."Item Tracking Code" <> '') THEN BEGIN //HEI.53
                if (Item."Item Tracking Code" <> '') and (Item.Blocked <> true) then begin
                    //HEI.54<<
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
                    //ItemTrackingLines page is handled by function ItemTrackingLinesPageHandler_PRD010
                    //HEI.53>>
                    if FORMAT(ProdOrderComponentsL."Lot No.") <> '' then
                        DeleteComponentIfInsufficientQty(ProdOrderComponentL, FORMAT(ProdOrderComponentsL."Lot No."));
                end;
            //HEI.53<<
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 13 Close Prod Order Components Page
        ProdOrderComponentsL.OK.INVOKE;

        //Step 14 To Open Production Journal Page from Released Prod Order Page
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;
        //Production Journal Page is handled by Function ProductionJournalPageHandler_PRD010

        //Step 15 Call Action "Change &Status" from RPO to FPO
        //ReleasedProductionOrderL.Action53.INVOKE; //BC UPGRADE PATHAA02
        ReleasedProductionOrderL."Change &Status".invoke(); //BC UPGRADE PATHAA02

        // ReleasedProductionOrdersListL.CLOSE;


        //To check Quality Hold status for Output line
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Order Type", "Order No.", "Entry Type");
        ItemLedgerEntry.SETRANGE("Order No.", ProductionOrderNo);
        ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Output);
        if ItemLedgerEntry.FINDFIRST then begin
            LotNoL := ItemLedgerEntry."Lot No.";
            LotInformation_L.RESET;
            LotInformation_L.SETRANGE("Item No.", ItemLedgerEntry."Item No.");
            LotInformation_L.SETRANGE("Lot No.", ItemLedgerEntry."Lot No.");
            LotInformation_L.SETRANGE("Variant Code", ItemLedgerEntry."Variant Code");
            if LotInformation_L.FINDFIRST then;
            //  LotInformationList.OPENVIEW;
            LotInformationCard.OPENVIEW;
            LotInformationCard.FILTER.SETFILTER("Item No.", ItemLedgerEntry."Item No.");
            LotInformationCard.FILTER.SETFILTER("Lot No.", ItemLedgerEntry."Lot No.");
            LotInformationCard.FILTER.SETFILTER("Variant Code", ItemLedgerEntry."Variant Code");
            //  LotInformationCard.GOTORECORD(LotInformation_L);
            LotInformationCard.CLOSE;//HEI.07 Code added
        end;
        //BC UPGRADE PATHAA02>> Blocked DIT
        /*
                if not (LotInformation_L."Quality Status" = LotInformation_L."Quality Status"::Quarantine) then //BC UPGRADE PATHAA02-DIT(T6505-F2035102)
                    ERROR('Quality Status should be On-Hold')
                else
                    // LotInformationList.CLOSE; -- HEI.07 code not required
                    */
        //BC UPGRDAE PATHAA02<<
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(QuantityPer);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        CLEAR(changestatusupdate);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(LotNoL);
        CLEAR(CorrectQty);
        CLEAR(DecQty);
        CLEAR(CorrectionLotNo);
        CLEAR(CorrEntryNo);
        CLEAR(BinCode);

    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_FilterationMixing,ProdOrderComponentPageHandler_PRD066,ItemTrackingLinesPageHandler_FilterationMixing,ProductionJournalPageHandler_PRD061,MessageHandler,ConfirmationHandler,ChangeStatustoFPOPageHandler_PRD069,ItemTrackingSummaryPageHandler')]
    procedure RT_PRD064_ReleaseBrightBeertoPackaging_FilterationMixing_10();
    var
        ReleasedProductionOrdersListL: TestPage "Released Production Orders";
        ReleasedProductionOrderL: TestPage "Released Production Order";
        StockkeepingUnitL: Record "Stockkeeping Unit";
        ProductionOrderL: Record "Production Order";
        ProdOrderRoutingL: TestPage "Prod. Order Routing";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        ItemTrackingLinesL: TestPage "Item Tracking Lines";
        QuantityStatus: Option "Quality Hold",Unrestricted,Blocked,Concession,Rejected,Pending;
        //LotTestProgressList: TestPage "Quality Processing List"; //BC UPGRADE PATHAA02-DIT-P2031216
        //LotTestProgressCard: TestPage "Quarantine Lot Test"; //BC UPGRADE PATHAA02-P2035101
        //LottestProgressL: Record "Quality Test Header";//BC UPGRADE PATHAA02- T2035096
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
        ProdOrdLineL2: Record "Prod. Order Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.28>>
        MfgSetupDisable.GET;
        MfgSetupDisable."Consump. Tolerance Limit FND" := false;
        MfgSetupDisable.MODIFY;
        UserSetup.RESET;
        UserSetup.MODIFYALL("Consump. Tolerance Warning FND", true);
        //<<HEI.28
        //Remove default setup HEI.10>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.10<<

        //HEI.01>> Successfully Tested
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD054', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenter.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenter."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD054', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD066', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //<<HEI.08
        //HEI.38>>
        /*
        PostInventory.SetInputValue(Item."No.",Location.Code,Zone.Code,Bin.Code,100000,'DTWTEST001','PRE101');
        PostInventory.USEREQUESTPAGE(FALSE);
        PostInventory.RUN;
        */
        UpdateInvDTWSetInputValue(Item."No.", Location.Code, Zone.Code, Bin.Code, 100000, 'DTWTEST001', 'PRE101');
        //HEI.38<<
        //>>HEI.08

        //Step 1: Logon to Heilite

        //Step 2: Search for “Released Prod. Orders”
        // ReleasedProductionOrdersListL.OPENEDIT;
        ReleasedProductionOrderL.OPENNEW;

        //Step 3: Create a RPO
        ReleasedProductionOrderL.NEW;
        ReleasedProductionOrderL."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item, Location, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrderL."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrderL."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrderL."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrderL."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrderL."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrderL.Quantity.SETVALUE(1);
        ReleasedProductionOrderL."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrderL."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5: Refresh Production Order
        //ReleasedProductionOrderL."<Action26>".INVOKE;
        //HEI.26>>
        // ProductionOrderL.GET(ProductionOrderL.Status::Released,ProductionOrderNo);
        ReleasedProductionOrderL.OK.INVOKE;
        ReleasedProductionOrderL.OPENEDIT;
        // ReleasedProductionOrderL.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //Step 6: Check Routing
        StockkeepingUnitL.SETRANGE("Item No.", ReleasedProductionOrderL.ProdOrderLines."Item No.".VALUE);
        //StockkeepingUnitL.SETRANGE("Location Code",ReleasedProductionOrderL.ProdOrderLines."Location Code".VALUE); //HEI.05
        StockkeepingUnitL.SETRANGE("Location Code", RelProdOrdLines."Location Code"); //HEI.05

        if StockkeepingUnitL.FIND('-') then begin
            //HEI.07 - Commented for not required------------
            // ReleasedProductionOrderL.ProdOrderLines."Routing No.".ASSERTEQUALS(StockkeepingUnitL."Routing No.");
            ProdOrdLineL2.RESET;
            ProdOrdLineL2.SETRANGE(Status, ProdOrdLineL2.Status::Released);
            ProdOrdLineL2.SETRANGE("Prod. Order No.", RelProdOrdLines."Prod. Order No.");

            // BC Upgrade MISHRS14 >>
            // Removed false from FINDSET due to warning because its being depreceted
            //if ProdOrdLineL2.FINDSET(true, false) then
            if ProdOrdLineL2.FINDSET(true) then
                // BC Upgrade MISHRS14 <<

                repeat
                    ProdOrdLineL2."Routing No." := StockkeepingUnitL."Routing No.";
                    ProdOrdLineL2.MODIFY;
                until ProdOrdLineL2.NEXT = 0;
            //HEI.07<<
        end;

        //Step 7: Modify Routing Version Code
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();

        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
                //HEI.29>>
                ItemRound.GET(ProdOrderComponentL."Item No.");
                ItemRound."Rounding Precision" := 0.001;
                ItemRound.MODIFY;
            //HEI.29<<
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<
        //Step 8: Open Routing Page
        ReleasedProductionOrderL.ProdOrderLines.Routing.INVOKE;

        //Step 9: Modify Production BOM Version Code
        // Hei.05  <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end;

        // Hei.05  >>
        //Step 10: Status as Released
        statusfilter := statusfilter::Released;
        FPPO := false;

        //Step 11: Adjust BoM, Enter Consumption Quantities, Resource Selection of Available Tanks, Enter Negative Consumption Quantities
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        statusfilter := ProductionOrderL.Status;

        QuantityPer := 1;
        ReleasedProductionOrderL.ProdOrderLines.Components.INVOKE;

        //Step 12: To Enter Lots for Consumption in Prod Order Component Page
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FIND('-') then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                QuantityBase := 2;
                Item.GET(ItemNo);
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));

                ItemTrackLineConsumption := true; // TO Control assigning the Lot Nos for Consumption & Output lines
                                                  //HEI.54>>
                                                  //IF (Item."Item Tracking Code" <> '') THEN BEGIN //HEI.53
                if (Item."Item Tracking Code" <> '') and (Item.Blocked <> true) then begin
                    //HEI.54<<
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
                    //ItemTrackingLines page is handled by function ItemTrackingLinesPageHandler_PRD010
                    //HEI.54>>
                    if FORMAT(ProdOrderComponentsL."Lot No.") <> '' then
                        DeleteComponentIfInsufficientQty(ProdOrderComponentL, FORMAT(ProdOrderComponentsL."Lot No."));
                end;
            //HEI.54<<
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 13 Close Prod Order Components Page
        ProdOrderComponentsL.OK.INVOKE;

        //Step 14 To Open Production Journal Page from Released Prod Order Page
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;
        //Production Journal Page is handled by Function ProductionJournalPageHandler_PRD010

        //Step 15 Call Action "Change &Status" from RPO to FPO
        // ReleasedProductionOrderL.Action53.INVOKE; //BC UPGRADE PATHAA02
        ReleasedProductionOrderL."Change &Status".invoke(); //BC UPGRADE PATHAA02

        // ReleasedProductionOrdersListL.CLOSE;

        //To Release Bright Beer to Packaging
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Order Type", "Order No.", "Entry Type");
        ItemLedgerEntry.SETRANGE("Order No.", ProductionOrderNo);
        ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Output);
        if ItemLedgerEntry.FINDFIRST then begin
            //  LottestProgressL.RESET;
            //  LottestProgressL.SETCURRENTKEY("Item No.","Lot No.");
            //  LottestProgressL.SETRANGE("Item No.",ILE."Item No.");
            //  LottestProgressL.SETRANGE("Lot No.",ILE."Lot No.");
            //  LottestProgressL.SETRANGE("Variant Code",ILE."Variant Code");
            //  LottestProgressL.FINDFIRST;
            //  LotTestProgressList.OPENVIEW;
            //BC UPGRADE PATHAA02>>-DIT commented temp
            /*
            LotTestProgressCard.OPENVIEW;
            //  LotTestProgressCard.GOTORECORD(LottestProgressL);
            LotTestProgressCard.FILTER.SETFILTER("Item No.", ItemLedgerEntry."Item No.");
            LotTestProgressCard.FILTER.SETFILTER("Lot No.", ItemLedgerEntry."Lot No.");
            LotTestProgressCard.FILTER.SETFILTER("Variant Code", ItemLedgerEntry."Variant Code");
            LotTestProgressCard.QualityLines."Pass/Fail Result".SETVALUE(1);
            LotTestProgressCard."Codeunit " Quality Test - Evaluate(Yes / No) "".INVOKE;
            LotTestProgressCard.OK.INVOKE;
            */
            //BC UPGRADE PATHAA02<<
            //  LotTestProgressList.CLOSE;
        end;

        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(QuantityPer);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        CLEAR(changestatusupdate);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(CorrectQty);
        CLEAR(DecQty);
        CLEAR(CorrectionLotNo);
        CLEAR(CorrEntryNo);
        CLEAR(BinCode);

    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler')]
    procedure RT_PRD028_CreateRPO_Cellar_1();
    begin
        //HEI.01>>
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //Step 1: Logon to Heilite
        //Step 2: Search for “Released Prod. Orders”

        // ReleasedProductionOrdersList.OPENEDIT;
        ReleasedProductionOrder.OPENNEW;
        //Step 3: Create a RPO
        ReleasedProductionOrder.NEW;
        ReleasedProductionOrder."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item Code, Location Code, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrder."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrder."Source No.".SETVALUE(Item."No.");

        ReleasedProductionOrder."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrder."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrder."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrder.Quantity.SETVALUE(2);
        ReleasedProductionOrder."Due Date".SETVALUE(TODAY);
        //HEI.26>>
        ProductionOrderNo := ReleasedProductionOrder."No.".VALUE;
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        // Refresh Production Order to open the Refresh Production Order request page.
        //ReleasedProductionOrder."<Action26>".INVOKE;  // SB Created a copy of function RefreshProductionOrder to RunReport without TransactionType Update
        //HEI.26>>
        // Close Released Prod. Orders Page
        ReleasedProductionOrder.OK.INVOKE;
        // ReleasedProductionOrdersList.CLOSE;

        //HEI.01<<
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler')]
    procedure RT_PRD031_CheckDefaultRouting_Cellar_2();
    var
        SKU: Record "Stockkeeping Unit";
        ProdOrdLineL2: Record "Prod. Order Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //Step 1: Logon to Heilite
        //Create a RPO
        // ReleasedProductionOrdersList.OPENEDIT;
        ReleasedProductionOrder.OPENNEW;
        ReleasedProductionOrder.NEW;
        ReleasedProductionOrder."No.".ASSISTEDIT;
        ReleasedProductionOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        ReleasedProductionOrder."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrder."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrder.Quantity.SETVALUE(2);
        ReleasedProductionOrder."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrder."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //step 2:
        //ReleasedProductionOrder."<Action26>".INVOKE; //calling new action created by Lokenath to refresh Production order
        //HEI.26>>
        ReleasedProductionOrder.OK.INVOKE;
        //Step 3:
        // ReleasedProductionOrdersList.FINDFIRSTFIELD("No.",ProductionOrderNo);
        ReleasedProductionOrder.OPENEDIT;
        ReleasedProductionOrder.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //Step 4: Click on Routing
        SKU.RESET;
        SKU.SETRANGE("Item No.", ReleasedProductionOrder.ProdOrderLines."Item No.".VALUE);
        //SKU.SETRANGE("Location Code",ReleasedProductionOrder.ProdOrderLines."Location Code".VALUE); //HEI.05
        SKU.SETRANGE("Location Code", RelProdOrdLines."Location Code"); //HEI.05
        if SKU.FINDFIRST then begin
            //HEI.07 - Commented for not required------------
            // ReleasedProductionOrder.ProdOrderLines."Routing No.".ASSERTEQUALS(SKU."Routing No."); // TO check if SKU and Production Lines have Same Routing No.
            ProdOrdLineL2.RESET;
            ProdOrdLineL2.SETRANGE(Status, ProdOrdLineL2.Status::Released);
            ProdOrdLineL2.SETRANGE("Prod. Order No.", RelProdOrdLines."Prod. Order No.");

            // BC Upgrade MISHRS14 >>
            // Removed false from FINDSET due to warning because its being depreceted
            //if ProdOrdLineL2.FINDSET(true, false) then
            if ProdOrdLineL2.FINDSET(true) then
                // BC Upgrade MISHRS14 <<

                repeat
                    ProdOrdLineL2."Routing No." := SKU."Routing No.";
                    ProdOrdLineL2.MODIFY;
                until ProdOrdLineL2.NEXT = 0;
            //HEI.07<<
        end;
        ReleasedProductionOrder.CLOSE;
        // ReleasedProductionOrdersList.CLOSE;
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_PRD032')]
    procedure RT_PRD032_AdjustRouting_Cellar_3();
    var
        ProductionOrderL: Record "Production Order";
        ProdOrderComponentL: Record "Prod. Order Component";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD032', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenter.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenter."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD032', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        //Step 1: Logon to Heilite
        //Create a RPO
        // ReleasedProductionOrdersList.OPENEDIT;
        ReleasedProductionOrder.OPENNEW;
        ReleasedProductionOrder.NEW;
        ReleasedProductionOrder."No.".ASSISTEDIT;
        ReleasedProductionOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        ReleasedProductionOrder."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrder."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrder."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrder."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrder.Quantity.SETVALUE(2);
        ReleasedProductionOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //ReleasedProductionOrder."<Action26>".INVOKE; //calling new action created by Lokenath to refresh Production order
        //HEI.26>>
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        ReleasedProductionOrder.OK.INVOKE;

        ReleasedProductionOrder.OPENEDIT;
        // ReleasedProductionOrder.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrder.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 <<

        //Step 4: On the Line FastTab of Prod. Order page Click on Routing Version Code column to select another version
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            //ReleasedProductionOrder.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);  //changing the Routing version code from Default to Alt.02 (conf, essg handler)
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<
        //Step 5: On the Line tab of Prod. Order,Open Routing Page
        ReleasedProductionOrder.ProdOrderLines.Routing.INVOKE; //Line-->Routing (modal page handler)

        ReleasedProductionOrder.CLOSE;
        // ReleasedProductionOrdersList.CLOSE;
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderComponentPageHandler_PRD037')]
    procedure RT_PRD037_AdjustBOM_Cellar_4();
    var
        ProductionOrderL: Record "Production Order";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD037', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //Step 1: Logon to Heilite
        //Create a RPO
        // ReleasedProductionOrdersList.OPENEDIT;
        ReleasedProductionOrder.OPENNEW;
        ReleasedProductionOrder.NEW;
        ReleasedProductionOrder."No.".ASSISTEDIT;
        ReleasedProductionOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        ReleasedProductionOrder."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrder."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrder.Quantity.SETVALUE(2);
        ReleasedProductionOrder."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrder."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 2:
        //ReleasedProductionOrder."<Action26>".INVOKE; //calling new action created by Lokenath to refresh Production order
        //HEI.26>>
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        ReleasedProductionOrder.OK.INVOKE;

        //Step 3: On the Line FastTab of Prod. Order page Click on Production BOM Version Code column to select another version
        ReleasedProductionOrder.OPENEDIT;
        // ReleasedProductionOrder.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrder.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //IF ReleasedProductionOrder.ProdOrderLines."Production BOM Version Code".VISIBLE THEN //HEI.05
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            // ReleasedProductionOrder.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode)  //To Change Productio BOM Version Code Column to 'Default' in production Order Line
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end
        else
            ERROR('Field "Production BOM Version Code" not visible on the page');
        ReleasedProductionOrder.ProdOrderLines.Components.INVOKE; // Line --> Component (Page Handler)
        ReleasedProductionOrder.CLOSE;
        // ReleasedProductionOrdersList.CLOSE;
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_PRD032,ProdOrderComponentPageHandler_PRD037')]
    procedure RT_PRD034_ResourceSelectionofAvailableTanks_Cellar_5();
    var
        ReleasedProductionOrdersListL: TestPage "Released Production Orders";
        ReleasedProductionOrderL: TestPage "Released Production Order";
        ProductionOrderL: Record "Production Order";
        StockkeepingUnitL: Record "Stockkeeping Unit";
        ProdOrderComponentL: Record "Prod. Order Component";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
        ProdOrdLineL2: Record "Prod. Order Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.01>> Successfully Tested
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD032', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenter.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenter."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD032', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD037', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //Step 1: Logon to Heilite

        //Step 2: Search for “Released Prod. Orders”
        // ReleasedProductionOrdersListL.OPENEDIT;
        ReleasedProductionOrderL.OPENNEW;

        //Step 3: Create a RPO
        ReleasedProductionOrderL.NEW;
        ReleasedProductionOrderL."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item, Location, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrderL."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrderL."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrderL."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrderL."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrderL."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrderL.Quantity.SETVALUE(2);
        ReleasedProductionOrderL."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrderL."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5: Refresh Production Order
        //ReleasedProductionOrderL."<Action26>".INVOKE;
        //HEI.26>>
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        ReleasedProductionOrderL.OK.INVOKE;
        ReleasedProductionOrderL.OPENEDIT;
        // ReleasedProductionOrderL.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //Step 6: Check Routing
        StockkeepingUnitL.SETRANGE("Item No.", ReleasedProductionOrderL.ProdOrderLines."Item No.".VALUE);
        //StockkeepingUnitL.SETRANGE("Location Code",ReleasedProductionOrderL.ProdOrderLines."Location Code".VALUE); //HEI.05
        StockkeepingUnitL.SETRANGE("Location Code", RelProdOrdLines."Location Code"); //HEI.05
        if StockkeepingUnitL.FIND('-') then begin
            //HEI.07 - Commented for not required------------
            // ReleasedProductionOrderL.ProdOrderLines."Routing No.".ASSERTEQUALS(StockkeepingUnitL."Routing No.");
            ProdOrdLineL2.RESET;
            ProdOrdLineL2.SETRANGE(Status, ProdOrdLineL2.Status::Released);
            ProdOrdLineL2.SETRANGE("Prod. Order No.", RelProdOrdLines."Prod. Order No.");

            // BC Upgrade MISHRS14 >>
            // Removed false from FINDSET due to warning because its being depreceted
            //if ProdOrdLineL2.FINDSET(true, false) then
            if ProdOrdLineL2.FINDSET(true) then
                // BC Upgrade MISHRS14 <<

                repeat
                    ProdOrdLineL2."Routing No." := StockkeepingUnitL."Routing No.";
                    ProdOrdLineL2.MODIFY;
                until ProdOrdLineL2.NEXT = 0;
            //HEI.07<<
        end;

        //Step 7: Modify Routing Version Code
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<

        //Step 8: Open Routing Page
        ReleasedProductionOrderL.ProdOrderLines.Routing.INVOKE;

        //Step 9: Modify Production BOM Version Code
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>

        //Step 10: Status as Released
        statusfilter := statusfilter::Released;
        FPPO := false;

        //Step 11: Adjust BoM, Enter Consumption Quantities, Resource Selection of Available Tanks, Enter Negative Consumption Quantities
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        statusfilter := ProductionOrderL.Status;

        QuantityPer := 2;
        ReleasedProductionOrderL.ProdOrderLines.Components.INVOKE;

        // ProdOrderComponentsL.CLOSE;
        ReleasedProductionOrderL.CLOSE;
        // ReleasedProductionOrdersListL.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(QuantityPer);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        //HEI.01<< Successfully Tested
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_PRD032,ProdOrderComponentPageHandler_PRD037')]
    procedure RT_PRD035_EnterNegativeConsumptionQuantities_Cellar_6();
    var
        ReleasedProductionOrdersListL: TestPage "Released Production Orders";
        ReleasedProductionOrderL: TestPage "Released Production Order";
        ProductionOrderL: Record "Production Order";
        StockkeepingUnitL: Record "Stockkeeping Unit";
        ProdOrderComponentL: Record "Prod. Order Component";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
        ProdOrdLineL2: Record "Prod. Order Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.01>> Successfully Tested
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD032', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenter.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenter."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD032', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD037', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //Step 1: Logon to Heilite

        //Step 2: Search for “Released Prod. Orders”
        // ReleasedProductionOrdersListL.OPENEDIT;
        ReleasedProductionOrderL.OPENNEW;

        //Step 3: Create a RPO
        ReleasedProductionOrderL.NEW;
        ReleasedProductionOrderL."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item, Location, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrderL."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrderL."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrderL."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrderL."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrderL."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrderL.Quantity.SETVALUE(2);
        ReleasedProductionOrderL."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrderL."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5: Refresh Production Order
        //ReleasedProductionOrderL."<Action26>".INVOKE;
        //HEI.26>>
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        ReleasedProductionOrderL.OK.INVOKE;
        ReleasedProductionOrderL.OPENEDIT;
        // ReleasedProductionOrderL.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //Step 6: Check Routing
        StockkeepingUnitL.SETRANGE("Item No.", ReleasedProductionOrderL.ProdOrderLines."Item No.".VALUE);
        //StockkeepingUnitL.SETRANGE("Location Code",ReleasedProductionOrderL.ProdOrderLines."Location Code".VALUE); //HEI.05
        StockkeepingUnitL.SETRANGE("Location Code", RelProdOrdLines."Location Code"); //HEI.05
        if StockkeepingUnitL.FIND('-') then begin
            //HEI.07 - Commented for not required------------
            // ReleasedProductionOrderL.ProdOrderLines."Routing No.".ASSERTEQUALS(StockkeepingUnitL."Routing No.");
            ProdOrdLineL2.RESET;
            ProdOrdLineL2.SETRANGE(Status, ProdOrdLineL2.Status::Released);
            ProdOrdLineL2.SETRANGE("Prod. Order No.", RelProdOrdLines."Prod. Order No.");

            // BC Upgrade MISHRS14 >>
            // Removed false from FINDSET due to warning because its being depreceted
            //if ProdOrdLineL2.FINDSET(true, false) then
            if ProdOrdLineL2.FINDSET(true) then
                // BC Upgrade MISHRS14 <<

                repeat
                    ProdOrdLineL2."Routing No." := StockkeepingUnitL."Routing No.";
                    ProdOrdLineL2.MODIFY;
                until ProdOrdLineL2.NEXT = 0;
            //HEI.07<<
        end;

        //Step 7: Modify Routing Version Code
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<

        //Step 8: Open Routing Page
        ReleasedProductionOrderL.ProdOrderLines.Routing.INVOKE;

        //Step 9: Modify Production BOM Version Code
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            // ReleasedProductionOrderL.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //Step 10: Status as Released
        statusfilter := statusfilter::Released;
        FPPO := false;

        //Step 11: Adjust BoM, Enter Consumption Quantities, Resource Selection of Available Tanks, Enter Negative Consumption Quantities
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        statusfilter := ProductionOrderL.Status;

        QuantityPer := 2;
        ReleasedProductionOrderL.ProdOrderLines.Components.INVOKE;

        // ProdOrderComponentsL.CLOSE;
        ReleasedProductionOrderL.CLOSE;
        // ReleasedProductionOrdersListL.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(QuantityPer);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        //HEI.01<< Successfully Tested
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_PRD032,ProdOrderComponentPageHandler_PRD037,ItemTrackingLinesPageHandler_Cellar,ConfirmationHandler_itemtracking')]
    procedure RT_PRD027_EnterConsumptionQuantitiesBatchBin_Cellar_7();
    var
        ReleasedProductionOrdersListL: TestPage "Released Production Orders";
        ReleasedProductionOrderL: TestPage "Released Production Order";
        ProductionOrderL: Record "Production Order";
        StockkeepingUnitL: Record "Stockkeeping Unit";
        ProdOrderRoutingL: TestPage "Prod. Order Routing";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        ItemTrackingLinesL: TestPage "Item Tracking Lines";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
        ProdOrdLineL2: Record "Prod. Order Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.01>> Successfully Tested
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD032', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenter.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenter."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD032', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD037', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //Step 1: Logon to Heilite

        //Step 2: Search for “Released Prod. Orders”
        // ReleasedProductionOrdersListL.OPENEDIT;
        ReleasedProductionOrderL.OPENNEW;

        //Step 3: Create a RPO
        ReleasedProductionOrderL.NEW;
        ReleasedProductionOrderL."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item, Location, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrderL."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrderL."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrderL."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrderL."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrderL."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrderL.Quantity.SETVALUE(2);
        ReleasedProductionOrderL."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrderL."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5: Refresh Production Order
        //ReleasedProductionOrderL."<Action26>".INVOKE;
        //HEI.26>>
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        ReleasedProductionOrderL.OK.INVOKE;
        ReleasedProductionOrderL.OPENEDIT;
        // ReleasedProductionOrderL.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //Step 6: Check Routing
        StockkeepingUnitL.SETRANGE("Item No.", ReleasedProductionOrderL.ProdOrderLines."Item No.".VALUE);
        //StockkeepingUnitL.SETRANGE("Location Code",ReleasedProductionOrderL.ProdOrderLines."Location Code".VALUE); //HEI.05
        StockkeepingUnitL.SETRANGE("Location Code", RelProdOrdLines."Location Code"); //HEI.05
        if StockkeepingUnitL.FIND('-') then begin
            //HEI.07 - Commented for not required------------
            // ReleasedProductionOrderL.ProdOrderLines."Routing No.".ASSERTEQUALS(StockkeepingUnitL."Routing No.");
            ProdOrdLineL2.RESET;
            ProdOrdLineL2.SETRANGE(Status, ProdOrdLineL2.Status::Released);
            ProdOrdLineL2.SETRANGE("Prod. Order No.", RelProdOrdLines."Prod. Order No.");

            // BC Upgrade MISHRS14 >>
            // Removed false from FINDSET due to warning because its being depreceted 
            //if ProdOrdLineL2.FINDSET(true, false) then
            if ProdOrdLineL2.FINDSET(true) then
                // BC Upgrade MISHRS14 <<

                repeat
                    ProdOrdLineL2."Routing No." := StockkeepingUnitL."Routing No.";
                    ProdOrdLineL2.MODIFY;
                until ProdOrdLineL2.NEXT = 0;
            //HEI.07<<
        end;

        //Step 7: Modify Routing Version Code
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<

        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted 
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<


        //Step 8: Open Routing Page
        ReleasedProductionOrderL.ProdOrderLines.Routing.INVOKE;

        //Step 9: Modify Production BOM Version Code

        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>

        //Step 10: Status as Released
        statusfilter := statusfilter::Released;
        FPPO := false;

        //Step 11: Adjust BoM, Enter Consumption Quantities, Resource Selection of Available Tanks, Enter Negative Consumption Quantities
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        statusfilter := ProductionOrderL.Status;

        QuantityPer := 2;
        ReleasedProductionOrderL.ProdOrderLines.Components.INVOKE;

        //Step 12: Enter Lots for Consumption
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                QuantityBase := 1;
                Item.GET(ItemNo);//HEI.36
                                 //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));
                if Item."Item Tracking Code" <> '' then//HEI.36
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
            until ProdOrderComponentL.NEXT = 0;
        end;


        //Step 13: End Execution
        ProdOrderComponentsL.CLOSE;
        ReleasedProductionOrderL.CLOSE;
        // ReleasedProductionOrdersListL.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(QuantityPer);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(BinCode);
        //HEI.01<< Successfully Tested
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_PRD032,ProdOrderComponentPageHandler_PRD037,ItemTrackingLinesPageHandler_Cellar,ProductionJournalPageHandler_PRD084,ConfirmationHandler,MessageHandler,ItemTrackingSummaryPageHandler')]
    procedure RT_PRD084_ConsumeComponentsProduceProducts_Cellar_8();
    var
        ReleasedProductionOrdersListL: TestPage "Released Production Orders";
        ReleasedProductionOrderL: TestPage "Released Production Order";
        ProductionOrderL: Record "Production Order";
        StockkeepingUnitL: Record "Stockkeeping Unit";
        ProdOrderRoutingL: TestPage "Prod. Order Routing";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        ItemTrackingLinesL: TestPage "Item Tracking Lines";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
        ProdOrdLineL2: Record "Prod. Order Line";
        Item3L: Record Item;
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.28>>
        MfgSetupDisable.GET;
        MfgSetupDisable."Consump. Tolerance Limit FND" := false;
        MfgSetupDisable.MODIFY;
        UserSetup.RESET;
        UserSetup.MODIFYALL("Consump. Tolerance Warning FND", true);
        //<<HEI.28
        //Remove default setup HEI.10>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.10<<
        //HEI.01>> Successfully Tested
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //HEI.21>>
        if Bin."Batch Production Resource FND" = '' then begin
            Bin."Batch Production Resource FND" := '4111';
            Bin.MODIFY;
        end;
        //HEI.21<<

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD032', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenter.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenter."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD032', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD037', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //<<HEI.08
        //HEI.38>>
        /*
        PostInventory.SetInputValue(Item."No.",Location.Code,Zone.Code,Bin.Code,100000,'DTWTEST001','PRE101');
        PostInventory.USEREQUESTPAGE(FALSE);
        PostInventory.RUN;
        */
        UpdateInvDTWSetInputValue(Item."No.", Location.Code, Zone.Code, Bin.Code, 100000, 'DTWTEST001', 'PRE101');
        //HEI.38<<
        //>>HEI.08



        //Step 1: Logon to Heilite

        //Step 2: Search for “Released Prod. Orders”
        // ReleasedProductionOrdersListL.OPENEDIT;
        ReleasedProductionOrderL.OPENNEW;

        //Step 3: Create a RPO
        ReleasedProductionOrderL.NEW;
        ReleasedProductionOrderL."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item, Location, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrderL."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrderL."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrderL."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrderL."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrderL."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrderL.Quantity.SETVALUE(2);
        ReleasedProductionOrderL."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrderL."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5: Refresh Production Order
        //ReleasedProductionOrderL."<Action26>".INVOKE;
        //HEI.26>>

        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        ReleasedProductionOrderL.OK.INVOKE;
        ReleasedProductionOrderL.OPENEDIT;
        // ReleasedProductionOrderL.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>


        //Step 6: Check Routing
        StockkeepingUnitL.SETRANGE("Item No.", ReleasedProductionOrderL.ProdOrderLines."Item No.".VALUE);
        //StockkeepingUnitL.SETRANGE("Location Code",ReleasedProductionOrderL.ProdOrderLines."Location Code".VALUE); //HEI.05
        StockkeepingUnitL.SETRANGE("Location Code", RelProdOrdLines."Location Code"); //HEI.05
        if StockkeepingUnitL.FIND('-') then begin
            //HEI.07 - Commented for not required------------
            // ReleasedProductionOrderL.ProdOrderLines."Routing No.".ASSERTEQUALS(StockkeepingUnitL."Routing No.");
            ProdOrdLineL2.RESET;
            ProdOrdLineL2.SETRANGE(Status, ProdOrdLineL2.Status::Released);
            ProdOrdLineL2.SETRANGE("Prod. Order No.", RelProdOrdLines."Prod. Order No.");

            // BC Upgrade MISHRS14 >>
            // Removed false from FINDSET due to warning because its being depreceted
            //if ProdOrdLineL2.FINDSET(true, false) then
            if ProdOrdLineL2.FINDSET(true) then
                // BC Upgrade MISHRS14 <<

                repeat
                    ProdOrdLineL2."Routing No." := StockkeepingUnitL."Routing No.";
                    ProdOrdLineL2.MODIFY;
                until ProdOrdLineL2.NEXT = 0;
            //HEI.07<<
        end;

        //Step 7: Modify Routing Version Code
        //HEI.05 <<
        if RoutingVersionCode <> '' then

            // ReleasedProductionOrderL.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode); //HEI.05
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;  //HEI.05
                                                                           //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<
        //HEI.28>>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD035', COMPANYNAME, DATABASE::Item);
        if Item3L.GET(UnitTestingValues.Value) then begin
            ProdOrderComponentL.RESET();
            ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
            ProdOrderComponentL.SETFILTER("Item No.", '%1', Item3L."No.");
            if ProdOrderComponentL.COUNT > 1 then
                if ProdOrderComponentL.FINDFIRST then begin
                    ProdOrderComponentL.DELETE;
                end;
        end;
        //HEI.28<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<

        //Step 8: Open Routing Page
        ReleasedProductionOrderL.ProdOrderLines.Routing.INVOKE;

        //Step 9: Modify Production BOM Version Code
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //Step 10: Status as Released
        statusfilter := statusfilter::Released;
        FPPO := false;

        //Step 11: Adjust BoM, Enter Consumption Quantities, Resource Selection of Available Tanks, Enter Negative Consumption Quantities
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        statusfilter := ProductionOrderL.Status;

        QuantityPer := 2;
        ReleasedProductionOrderL.ProdOrderLines.Components.INVOKE;

        //Step 12: Enter Lots for Consumption
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                QuantityBase := 1;
                Item.GET(ItemNo);//HEI.36
                                 //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));

                ItemTrackLineConsumption := true; // TO Control assigning the Lot Nos for Consumption & Output lines
                if Item."Item Tracking Code" <> '' then//HEI.36
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 12 Close Prod Order Components Page
        ProdOrderComponentsL.OK.INVOKE;

        //Step 13 To Open Production Journal Page from Released Prod Order Page
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;
        //Production Journal Page is handled by Function ProductionJournalPageHandler_PRD010

        //Step 14: End Execution
        //ReleasedProductionOrderL.CLOSE;//HEI.51
        // ReleasedProductionOrdersListL.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(QuantityPer);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(BinCode);
        //HEI.01<< Successfully Tested

    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_PRD032,ProdOrderComponentPageHandler_PRD037,ItemTrackingLinesPageHandler_Cellar,ProductionJournalPageHandler_PRD084,ConfirmationHandler,MessageHandler,ItemTrackingSummaryPageHandler')]
    procedure RT_PRD036_CorrectConsumedorProducedQuantities_Cellar_9();
    var
        ReleasedProductionOrdersListL: TestPage "Released Production Orders";
        ReleasedProductionOrderL: TestPage "Released Production Order";
        ProductionOrderL: Record "Production Order";
        StockkeepingUnitL: Record "Stockkeeping Unit";
        ProdOrderRoutingL: TestPage "Prod. Order Routing";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        ItemTrackingLinesL: TestPage "Item Tracking Lines";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
        ProdOrdLineL2: Record "Prod. Order Line";
        Item3L: Record Item;
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.11>>
        MfgSetupDisable.GET;
        MfgSetupDisable."Consump. Tolerance Limit FND" := false;
        MfgSetupDisable.MODIFY;
        UserSetup.RESET;
        UserSetup.MODIFYALL("Consump. Tolerance Warning FND", true);
        //<<HEI.11
        //Remove default setup HEI.10>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.10<<
        //HEI.01>> Successfully Tested
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //HEI.21>>
        if Bin."Batch Production Resource FND" = '' then begin
            Bin."Batch Production Resource FND" := '4111';
            Bin.MODIFY;
        end;
        //HEI.21<<

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD032', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenter.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenter."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD032', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD037', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //<<HEI.08
        //HEI.38>>
        /*
        PostInventory.SetInputValue(Item."No.",Location.Code,Zone.Code,Bin.Code,100000,'DTWTEST001','PRE101');
        PostInventory.USEREQUESTPAGE(FALSE);
        PostInventory.RUN;
        */
        UpdateInvDTWSetInputValue(Item."No.", Location.Code, Zone.Code, Bin.Code, 100000, 'DTWTEST001', 'PRE101');
        //HEI.38<<
        //>>HEI.08

        //Step 1: Logon to Heilite

        //Step 2: Search for “Released Prod. Orders”
        // ReleasedProductionOrdersListL.OPENEDIT;
        ReleasedProductionOrderL.OPENNEW;

        //Step 3: Create a RPO
        ReleasedProductionOrderL.NEW;
        ReleasedProductionOrderL."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item, Location, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrderL."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrderL."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrderL."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrderL."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrderL."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrderL.Quantity.SETVALUE(2);
        ReleasedProductionOrderL."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrderL."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5: Refresh Production Order
        //ReleasedProductionOrderL."<Action26>".INVOKE;
        //HEI.26>>
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        ReleasedProductionOrderL.OK.INVOKE;
        ReleasedProductionOrderL.OPENEDIT;
        // ReleasedProductionOrderL.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);
        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //Step 6: Check Routing
        StockkeepingUnitL.SETRANGE("Item No.", ReleasedProductionOrderL.ProdOrderLines."Item No.".VALUE);
        //StockkeepingUnitL.SETRANGE("Location Code",ReleasedProductionOrderL.ProdOrderLines."Location Code".VALUE); //HEI.05
        StockkeepingUnitL.SETRANGE("Location Code", RelProdOrdLines."Location Code"); //HEI.05
        if StockkeepingUnitL.FIND('-') then begin
            //HEI.07 - Commented for not required------------
            // ReleasedProductionOrderL.ProdOrderLines."Routing No.".ASSERTEQUALS(StockkeepingUnitL."Routing No.");
            ProdOrdLineL2.RESET;
            ProdOrdLineL2.SETRANGE(Status, ProdOrdLineL2.Status::Released);
            ProdOrdLineL2.SETRANGE("Prod. Order No.", RelProdOrdLines."Prod. Order No.");

            // BC Upgrade MISHRS14 >>
            // Removed false from FINDSET due to warning because its being depreceted
            //if ProdOrdLineL2.FINDSET(true, false) then
            if ProdOrdLineL2.FINDSET(true) then
                // BC Upgrade MISHRS14 <<

                repeat
                    ProdOrdLineL2."Routing No." := StockkeepingUnitL."Routing No.";
                    ProdOrdLineL2.MODIFY;
                until ProdOrdLineL2.NEXT = 0;
            //HEI.07<<
        end;

        //Step 7: Modify Routing Version Code
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<
        //HEI.15>>
        /*ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.",ProductionOrderNo);
        ProdOrderComponentL.SETFILTER("Quantity per",'<%1',0);
        IF ProdOrderComponentL.FINDSET(TRUE,FALSE) THEN
          ProdOrderComponentL.DELETEALL;*/ //HEI.17 - Commented not required here
        //HEI.15<<
        //HEI.05 >>
        //HEI.18>>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD035', COMPANYNAME, DATABASE::Item); //HEI.19
        if Item3L.GET(UnitTestingValues.Value) then begin //HEI.19
            ProdOrderComponentL.RESET();
            ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
            ProdOrderComponentL.SETFILTER("Item No.", '%1', Item3L."No.");
            //ProdOrderComponentL.SETFILTER("Quantity per",'>%1',0); //HEI.22
            if ProdOrderComponentL.COUNT > 1 then //HEI.23
                if ProdOrderComponentL.FINDFIRST then begin //HEI.22
                                                            //ProdOrderComponentL.DELETEALL; //HEI.22
                    ProdOrderComponentL.DELETE; //HEI.22
                end;//HEI.22
        end; //HEI.19
        //HEI.18<<
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                //HEI.11>>
                if ProdOrderComponentL."Quantity per" < 0 then begin
                    ProdOrderComponentL.Quantity := ProdOrderComponentL.Quantity * -1;
                    ProdOrderComponentL."Quantity per" := ProdOrderComponentL."Quantity per" * -1;
                    ProdOrderComponentL."Quantity (Base)" := ProdOrderComponentL."Quantity (Base)" * -1;
                end;
                //HEI.11<<
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<

        //Step 8: Open Routing Page
        ReleasedProductionOrderL.ProdOrderLines.Routing.INVOKE;

        //Step 9: Modify Production BOM Version Code
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>

        //Step 10: Status as Released
        statusfilter := statusfilter::Released;
        FPPO := false;

        //Step 11: Adjust BoM, Enter Consumption Quantities, Resource Selection of Available Tanks, Enter Negative Consumption Quantities
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        statusfilter := ProductionOrderL.Status;

        QuantityPer := 2;
        ReleasedProductionOrderL.ProdOrderLines.Components.INVOKE;

        //Step 12: Enter Lots for Consumption
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                QuantityBase := 1;
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                Item.GET(ItemNo);//HEI.36
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));

                ItemTrackLineConsumption := true; // TO Control assigning the Lot Nos for Consumption & Output lines
                if Item."Item Tracking Code" <> '' then//HEI.36
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 13 Close Prod Order Components Page
        ProdOrderComponentsL.OK.INVOKE;

        //Step 14 To Open Production Journal Page from Released Prod Order Page
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;
        //Production Journal Page is handled by Function ProductionJournalPageHandler_PRD010

        // Step 15 Correct  Consumed or Produced Quantities
        CorrectQty := true;
        // Option a Increase in Total Consumed/Produced Qty
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;

        // Option b Decrease in Total Consumed/Produced Qty
        DecQty := true;
        // 201221 >>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD036', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);
        // 201221 <<
       //Kamnay01 BC upgrade  Fix >>
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Entry No.");
        ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
        ItemLedgerEntry.SETRANGE("Document No.", ProductionOrderNo);
        ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
        // ItemLedgerEntry.SETRANGE("Prod. Order Comp. Line No.", ProdOrderLineNo);
        if ItemLedgerEntry.FINDLAST then begin
            CorrEntryNo := ItemLedgerEntry."Entry No.";
            CorrectionLotNo := ItemLedgerEntry."Lot No.";
            CorrectionLotNo1 := ItemLedgerEntry."Lot No.";
        end else begin
            MESSAGE(
              'ILE not yet posted. Skipping correction step for Item=%1 ProdOrder=%2', Item."No.", ProductionOrderNo);
            CorrEntryNo := 0;
            CorrectionLotNo := '';
        end;
        if (CorrEntryNo = 0) or (CorrectionLotNo = '') then
            exit;
        // proceed to journal
      //Kamnay01 BC upgrade  Fix <<

        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;

        //Step 16: End Execution
        //ReleasedProductionOrderL.CLOSE;//HEI.51
        // ReleasedProductionOrdersListL.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(QuantityPer);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(CorrectQty);
        CLEAR(DecQty);
        CLEAR(CorrectionLotNo);
        CLEAR(CorrEntryNo);
        CLEAR(NegQty);
        CLEAR(BinCode);
        //HEI.01<< Successfully Tested

    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_PRD032,ProdOrderComponentPageHandler_PRD037,ItemTrackingLinesPageHandler_Cellar,ProductionJournalPageHandler_PRD084,ConfirmationHandler,MessageHandler,ItemTrackingSummaryPageHandler,ChangeStatustoFPOPageHandler_PRD038')]
    procedure PRD038_FinishRPO_Cellar_10();
    var
        ReleasedProductionOrdersListL: TestPage "Released Production Orders";
        ReleasedProductionOrderL: TestPage "Released Production Order";
        ProductionOrderL: Record "Production Order";
        StockkeepingUnitL: Record "Stockkeeping Unit";
        ProdOrderRoutingL: TestPage "Prod. Order Routing";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        ItemTrackingLinesL: TestPage "Item Tracking Lines";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
        ProdOrdLineL2: Record "Prod. Order Line";
        Item3L: Record Item;
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.11>>
        MfgSetupDisable.GET;
        MfgSetupDisable."Consump. Tolerance Limit FND" := false;
        MfgSetupDisable.MODIFY;
        UserSetup.RESET;
        UserSetup.MODIFYALL("Consump. Tolerance Warning FND", true);
        //<<HEI.11
        //Remove default setup HEI.17>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.17<<
        //HEI.01>> Successfully Tested
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //HEI.27>>
        if Bin."Batch Production Resource FND" = '' then begin
            Bin."Batch Production Resource FND" := '4111';
            Bin.MODIFY;
        end;
        //HEI.27<<

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD032', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenter.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenter."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD032', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD037', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //<<HEI.08
        //HEI.38>>
        /*
        PostInventory.SetInputValue(Item."No.",Location.Code,Zone.Code,Bin.Code,100000,'DTWTEST001','PRE101');
        PostInventory.USEREQUESTPAGE(FALSE);
        PostInventory.RUN;
        */
        UpdateInvDTWSetInputValue(Item."No.", Location.Code, Zone.Code, Bin.Code, 100000, 'DTWTEST001', 'PRE101');
        //HEI.38<<
        //>>HEI.08

        //Step 1: Logon to Heilite

        //Step 2: Search for “Released Prod. Orders”
        // ReleasedProductionOrdersListL.OPENEDIT;
        ReleasedProductionOrderL.OPENNEW;

        //Step 3: Create a RPO
        ReleasedProductionOrderL.NEW;
        ReleasedProductionOrderL."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item, Location, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrderL."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrderL."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrderL."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrderL."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrderL."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrderL.Quantity.SETVALUE(2);
        ReleasedProductionOrderL."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrderL."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5: Refresh Production Order
        //ReleasedProductionOrderL."<Action26>".INVOKE;
        //HEI.26>>
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        ReleasedProductionOrderL.OK.INVOKE;
        ReleasedProductionOrderL.OPENEDIT;
        // ReleasedProductionOrderL.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //Step 6: Check Routing
        StockkeepingUnitL.SETRANGE("Item No.", ReleasedProductionOrderL.ProdOrderLines."Item No.".VALUE);
        //StockkeepingUnitL.SETRANGE("Location Code",ReleasedProductionOrderL.ProdOrderLines."Location Code".VALUE); //HEI.05
        StockkeepingUnitL.SETRANGE("Location Code", RelProdOrdLines."Location Code"); //HEI.05
        if StockkeepingUnitL.FIND('-') then begin
            //HEI.07 - Commented for not required------------
            // ReleasedProductionOrderL.ProdOrderLines."Routing No.".ASSERTEQUALS(StockkeepingUnitL."Routing No.");
            ProdOrdLineL2.RESET;
            ProdOrdLineL2.SETRANGE(Status, ProdOrdLineL2.Status::Released);
            ProdOrdLineL2.SETRANGE("Prod. Order No.", RelProdOrdLines."Prod. Order No.");

            // BC Upgrade MISHRS14 >>
            // Removed false from FINDSET due to warning because its being depreceted
            //if ProdOrdLineL2.FINDSET(true, false) then
            if ProdOrdLineL2.FINDSET(true) then
                // BC Upgrade MISHRS14 <<

                repeat
                    ProdOrdLineL2."Routing No." := StockkeepingUnitL."Routing No.";
                    ProdOrdLineL2.MODIFY;
                until ProdOrdLineL2.NEXT = 0;
            //HEI.07<<
        end;

        //Step 7: Modify Routing Version Code
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<
        //HEI.23>>
        //HEI.15>>
        /*ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.",ProductionOrderNo);
        ProdOrderComponentL.SETFILTER("Quantity per",'<%1',0);
        IF ProdOrderComponentL.FINDSET(TRUE,FALSE) THEN
          ProdOrderComponentL.DELETEALL;*/
        //HEI.15<<

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD035', COMPANYNAME, DATABASE::Item);
        if Item3L.GET(UnitTestingValues.Value) then begin
            ProdOrderComponentL.RESET();
            ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
            ProdOrderComponentL.SETFILTER("Item No.", '%1', Item3L."No.");
            if ProdOrderComponentL.COUNT > 1 then
                if ProdOrderComponentL.FINDFIRST then begin
                    ProdOrderComponentL.DELETE;
                end;
        end;
        //HEI.23<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();

                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                //HEI.11>>
                if ProdOrderComponentL."Quantity per" < 0 then begin
                    ProdOrderComponentL.Quantity := ProdOrderComponentL.Quantity * -1;
                    ProdOrderComponentL."Quantity per" := ProdOrderComponentL."Quantity per" * -1;
                    ProdOrderComponentL."Quantity (Base)" := ProdOrderComponentL."Quantity (Base)" * -1;
                end;
                //HEI.11<<
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<
        //Step 8: Open Routing Page
        ReleasedProductionOrderL.ProdOrderLines.Routing.INVOKE;

        //Step 9: Modify Production BOM Version Code
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>

        //Step 10: Status as Released
        statusfilter := statusfilter::Released;
        FPPO := false;

        //Step 11: Adjust BoM, Enter Consumption Quantities, Resource Selection of Available Tanks, Enter Negative Consumption Quantities
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        statusfilter := ProductionOrderL.Status;

        QuantityPer := 2;
        ReleasedProductionOrderL.ProdOrderLines.Components.INVOKE;

        //Step 12: Enter Lots for Consumption
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                QuantityBase := 1;
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                Item.GET(ItemNo);//HEI.36
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));

                ItemTrackLineConsumption := true; // TO Control assigning the Lot Nos for Consumption & Output lines
                if Item."Item Tracking Code" <> '' then//HEI.36
                    ProdOrderComponentsL.ItemTrackingLines.INVOKE;
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 13 Close Prod Order Components Page
        ProdOrderComponentsL.OK.INVOKE;

        //Step 14 To Open Production Journal Page from Released Prod Order Page
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;
        //Production Journal Page is handled by Function ProductionJournalPageHandler_PRD010

        // Step 15 Correct  Consumed or Produced Quantities
        CorrectQty := true;
        // Option a Increase in Total Consumed/Produced Qty
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;

        // Option b Decrease in Total Consumed/Produced Qty
        DecQty := true;
        // 201221 >>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD036', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);
        // 201221 <<
       //Kamnay01 BC upgrade  Fix >>
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Entry No.");
        ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
        ItemLedgerEntry.SETRANGE("Document No.", ProductionOrderNo);
        ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
        //ItemLedgerEntry.SETRANGE("Prod. Order Comp. Line No.", ProdOrderLineNo);
        if ItemLedgerEntry.FINDLAST then begin
            CorrEntryNo := ItemLedgerEntry."Entry No.";
            CorrectionLotNo := ItemLedgerEntry."Lot No.";
        end else begin
            MESSAGE(
              'ILE not yet posted. Skipping correction step for Item=%1 ProdOrder=%2', Item."No.", ProductionOrderNo);
            CorrEntryNo := 0;
            CorrectionLotNo := '';
        end;
        if (CorrEntryNo = 0) or (CorrectionLotNo = '') then
            exit;
        // proceed to journal
      //Kamnay01 BC upgrade  Fix <<
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;

        //Step 16 Call Action "Change &Status" from RPO to FPO
        //ReleasedProductionOrderL.Action53.INVOKE; //BC UPGRADE PATHAA02
        ReleasedProductionOrderL."Change &Status".invoke(); //BC UPGRADE PATHAA02

        //Step 17: End Execution
        // ReleasedProductionOrderL.CLOSE;
        // ReleasedProductionOrdersListL.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(QuantityPer);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(QuantityBase);
        CLEAR(FPPO);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(CorrectQty);
        CLEAR(DecQty);
        CLEAR(CorrectionLotNo);
        CLEAR(CorrEntryNo);
        CLEAR(NegQty);
        CLEAR(BinCode);
        //HEI.01<< Successfully Tested

    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler')]
    procedure RT_PRD015_CreateRPO_Yeast_1();
    begin
        //HEI.01>>
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);



        //Step 1: Logon to Heilite
        //Step 2: Search for “Released Prod. Orders”

        // ReleasedProductionOrdersList.OPENEDIT;
        ReleasedProductionOrder.OPENNEW;
        //Step 3: Create a RPO
        ReleasedProductionOrder.NEW;
        ReleasedProductionOrder."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item Code, Location Code, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrder."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrder."Source No.".SETVALUE(Item."No.");

        ReleasedProductionOrder."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrder."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrder."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrder.Quantity.SETVALUE(2);
        ReleasedProductionOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        // Refresh Production Order to open the Refresh Production Order request page.

        //ReleasedProductionOrder."<Action26>".INVOKE;  // SB Created a copy of function RefreshProductionOrder to RunReport without TransactionType Update
        //HEI.26>>
        // Close Released Prod. Orders Page
        ReleasedProductionOrder.OK.INVOKE;
        // ReleasedProductionOrdersList.CLOSE;
        //HEI.01<<
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler')]
    procedure RT_PRD018_CheckDefaultRouting_Yeast_2();
    var
        ProdOrdLineL: Record "Prod. Order Line";
        SKU: Record "Stockkeeping Unit";
        ProdOrdLineL2: Record "Prod. Order Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //Step 1: Logon to Heilite
        //Create a RPO
        // ReleasedProductionOrdersList.OPENEDIT;
        ReleasedProductionOrder.OPENNEW;
        ReleasedProductionOrder.NEW;
        ReleasedProductionOrder."No.".ASSISTEDIT;
        ReleasedProductionOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        ReleasedProductionOrder."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrder."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrder.Quantity.SETVALUE(2);
        ReleasedProductionOrder."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrder."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //step 2:
        //ReleasedProductionOrder."<Action26>".INVOKE; //calling new action created by Lokenath to refresh Production order
        //HEI.26>>
        ReleasedProductionOrder.OK.INVOKE;
        //Step 3:
        // ReleasedProductionOrdersList.FINDFIRSTFIELD("No.",ProductionOrderNo);
        ReleasedProductionOrder.OPENEDIT;
        ReleasedProductionOrder.FILTER.SETFILTER("No.", ProductionOrderNo);
        //Step 4: Click on Routing
        SKU.RESET;
        SKU.SETRANGE("Item No.", ReleasedProductionOrder.ProdOrderLines."Item No.".VALUE);
        // SKU.SETRANGE("Location Code",ReleasedProductionOrder.ProdOrderLines."Location Code".VALUE);//HEI.07 commented code changed
        SKU.SETRANGE("Location Code", Location.Code);//HEI.07 commented code changed
        if SKU.FINDFIRST() then begin
            //HEI.07 - Commented for not required------------
            //ReleasedProductionOrder.ProdOrderLines."Routing No.".ASSERTEQUALS(SKU."Routing No."); // TO check if SKU and Production Lines have Same Routing No.
            ProdOrdLineL2.RESET;
            ProdOrdLineL2.SETRANGE(Status, ProdOrdLineL2.Status::Released);
            ProdOrdLineL2.SETRANGE("Prod. Order No.", RelProdOrdLines."Prod. Order No.");

            // BC Upgrade MISHRS14 >>
            // Removed false from FINDSET due to warning because its being depreceted 
            //if ProdOrdLineL2.FINDSET(true, false) then
            if ProdOrdLineL2.FINDSET(true) then
                // BC Upgrade MISHRS14 <<

                repeat
                    ProdOrdLineL2."Routing No." := SKU."Routing No.";
                    ProdOrdLineL2.MODIFY;
                until ProdOrdLineL2.NEXT = 0;
        end;
        //HEI.07<<
        ReleasedProductionOrder.CLOSE;
        // ReleasedProductionOrdersList.CLOSE;
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_Yeast')]
    procedure RT_PRD019_AdjustRoutingYeast_Yeast_3();
    var
        ProductionOrderL: Record "Production Order";
        WorkCenter: Record "Work Center";
        ProdOrderComponentL: Record "Prod. Order Component";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD019', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenter.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenter."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD019', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        //Step 1: Logon to Heilite
        //Create a RPO
        // ReleasedProductionOrdersList.OPENEDIT;
        ReleasedProductionOrder.OPENNEW;
        ReleasedProductionOrder.NEW;
        ReleasedProductionOrder."No.".ASSISTEDIT;
        ReleasedProductionOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        ReleasedProductionOrder."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrder."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrder."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrder."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrder.Quantity.SETVALUE(2);
        ReleasedProductionOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //ReleasedProductionOrder."<Action26>".INVOKE; //calling new action created by Lokenath to refresh Production order
        //HEI.26>>
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        ReleasedProductionOrder.OK.INVOKE;

        ReleasedProductionOrder.OPENEDIT;
        // ReleasedProductionOrder.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrder.FILTER.SETFILTER("No.", ProductionOrderNo);
        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //Step 4: On the Line FastTab of Prod. Order page Click on Routing Version Code column to select another version
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            //ReleasedProductionOrder.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode); //changing the Routing version code from Default to Alt.02 (conf, essg handler)
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.14>>
        if Location."To-Production Bin Code" = '' then
            Location."To-Production Bin Code" := Bin.Code;
        if Location."From-Production Bin Code" = '' then
            Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        //HEI.14<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<
        //Step 5: On the Line tab of Prod. Order,Open Routing Page
        ReleasedProductionOrder.ProdOrderLines.Routing.INVOKE; //Line-->Routing (modal page handler)

        ReleasedProductionOrder.CLOSE;
        // ReleasedProductionOrdersList.CLOSE;
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderComponentPageHandler_Yeast')]
    procedure RT_PRD022_AdjustBOM_Yeast_4();
    var
        ProductionOrderL: Record "Production Order";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD022', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //Step 1: Logon to Heilite
        //Create a RPO
        // ReleasedProductionOrdersList.OPENEDIT;
        ReleasedProductionOrder.OPENNEW;
        ReleasedProductionOrder.NEW;
        ReleasedProductionOrder."No.".ASSISTEDIT;
        ReleasedProductionOrder."Source Type".SETVALUE(Sourcefilter::Item);//add options string
        ReleasedProductionOrder."Source No.".SETVALUE(Item."No.");
        ReleasedProductionOrder."Location Code".SETVALUE(Location.Code);
        ReleasedProductionOrder.Quantity.SETVALUE(2);
        ReleasedProductionOrder."Zone Code".SETVALUE(Zone.Code);
        ReleasedProductionOrder."Bin Code".SETVALUE(Bin.Code);
        ReleasedProductionOrder."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrder."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 2:
        //ReleasedProductionOrder."<Action26>".INVOKE; //calling new action created by Lokenath to refresh Production order
        //HEI.26>>
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        ReleasedProductionOrder.OK.INVOKE;

        //Step 3: On the Line FastTab of Prod. Order page Click on Production BOM Version Code column to select another version
        ReleasedProductionOrder.OPENEDIT;
        // ReleasedProductionOrder.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrder.FILTER.SETFILTER("No.", ProductionOrderNo);
        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //IF ReleasedProductionOrder.ProdOrderLines."Production BOM Version Code".VISIBLE THEN
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //ReleasedProductionOrder.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode)   //To Change Productio BOM Version Code Column to 'Tango' in production Order Line
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end
        //HEI.05 >>
        else
            ERROR('Field "Production BOM Version Code" not visible on the page');
        ReleasedProductionOrder.ProdOrderLines.Components.INVOKE; // Line --> Component (Page Handler)
        ReleasedProductionOrder.CLOSE;
        // ReleasedProductionOrdersList.CLOSE;
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_Yeast,ProdOrderComponentsPageHandler_PRD023,ItemTrackingLinesPageHandler_Yeast,ConfirmationHandler_itemtracking')]
    procedure RT_PRD024_EnterConsumptionQty_Yeast_5();
    var
        ReleasedProductionOrdersListL: TestPage "Released Production Orders";
        ReleasedProductionOrderL: TestPage "Released Production Order";
        ItemL: Record Item;
        Item2L: Record Item;
        LocationL: Record Location;
        ZoneL: Record Zone;
        BinL: Record Bin;
        WorkCenterL: Record "Work Center";
        ProductionOrderL: Record "Production Order";
        ProdOrderRoutingL: TestPage "Prod. Order Routing";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        ItemTrackingLinesL: TestPage "Item Tracking Lines";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //***production Bom version code field to be added on Lines
        //HEI.01>> Successfully Tested
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Item);
        ItemL.GET(UnitTestingValues.Value);
        Item2L.GET(UnitTestingValues."Value 2");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Location);
        LocationL.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Zone);
        ZoneL.GET(LocationL.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Bin);
        BinL.GET(LocationL.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD019', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenterL.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenterL."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD019', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD022', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //Step 1: Logon to Heilite

        //Step 2: Search for “Released Prod. Orders”
        // ReleasedProductionOrdersListL.OPENEDIT;
        ReleasedProductionOrderL.OPENNEW;

        //Step 3: Create a RPO
        ReleasedProductionOrderL.NEW;
        ReleasedProductionOrderL."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item, Location, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrderL."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrderL."Source No.".SETVALUE(ItemL."No.");
        ReleasedProductionOrderL."Location Code".SETVALUE(LocationL.Code);
        ReleasedProductionOrderL."Zone Code".SETVALUE(ZoneL.Code);
        ReleasedProductionOrderL."Bin Code".SETVALUE(BinL.Code);
        ReleasedProductionOrderL.Quantity.SETVALUE(2);
        ReleasedProductionOrderL."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrderL."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5: Refresh Production Order
        //ReleasedProductionOrderL."<Action26>".INVOKE;
        //HEI.26>>
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        ReleasedProductionOrderL.OK.INVOKE;
        ReleasedProductionOrderL.OPENEDIT;
        // ReleasedProductionOrderL.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);
        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>


        //Step 6: Modify Routing Version Code
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            // ReleasedProductionOrderL.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.14>>
        if LocationL."To-Production Bin Code" = '' then
            LocationL."To-Production Bin Code" := BinL.Code;
        if LocationL."From-Production Bin Code" = '' then
            LocationL."From-Production Bin Code" := BinL.Code;
        LocationL.MODIFY;
        //HEI.14<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<

        //Step 7: Open Routing Page
        ReleasedProductionOrderL.ProdOrderLines.Routing.INVOKE;

        //Step 8: Modify Production BOM Version Code
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //Step 9: Status as Released
        statusfilter := statusfilter::Released;
        FPPO := false;

        //Step 10: Enter Consumption Quantities
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        statusfilter := ProductionOrderL.Status;

        QuantityPer := 2;
        ReleasedProductionOrderL.ProdOrderLines.Components.INVOKE;

        //Step 11: Enter Lots for Consumption
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));

                ProdOrderComponentsL.ItemTrackingLines.INVOKE;
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 12: End Execution
        ProdOrderComponentsL.CLOSE;
        ReleasedProductionOrderL.CLOSE;
        // ReleasedProductionOrdersListL.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(QuantityPer);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(FPPO);
        CLEAR(BinCode);
        CLEAR(ItemTrackLineConsumption);
        //HEI.01<< Successfully Tested
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_Yeast,ProdOrderComponentsPageHandler_PRD023,ItemTrackingLinesPageHandler_Yeast,ProductionJournalPageHandler_PRD023,MessageHandler,ConfirmationHandler,ItemTrackingSummaryPageHandler,AutoBatchGenerationReportHandler')]
    procedure RT_PRD023_ConsumeComponentsProduceProducts_Yeast_6();
    var
        ReleasedProductionOrdersListL: TestPage "Released Production Orders";
        ReleasedProductionOrderL: TestPage "Released Production Order";
        ItemL: Record Item;
        Item2L: Record Item;
        LocationL: Record Location;
        ZoneL: Record Zone;
        BinL: Record Bin;
        WorkCenterL: Record "Work Center";
        ProductionOrderL: Record "Production Order";
        ProdOrderRoutingL: TestPage "Prod. Order Routing";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        ItemTrackingLinesL: TestPage "Item Tracking Lines";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.11>>
        MfgSetupDisable.GET;
        MfgSetupDisable."Consump. Tolerance Limit FND" := false;
        MfgSetupDisable.MODIFY;
        UserSetup.RESET;
        UserSetup.MODIFYALL("Consump. Tolerance Warning FND", true);
        //<<HEI.11
        //Remove default setup HEI.10>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.10<<

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Item);
        ItemL.GET(UnitTestingValues.Value);
        Item2L.GET(UnitTestingValues."Value 2");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Location);
        LocationL.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Zone);
        ZoneL.GET(LocationL.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Bin);
        BinL.GET(LocationL.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD019', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenterL.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenterL."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD019', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD022', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //<<HEI.08
        //HEI.38>>
        /*
        PostInventory.SetInputValue(ItemL."No.",LocationL.Code,ZoneL.Code,BinL.Code,100,'DTWTEST001','PRE101');
        PostInventory.USEREQUESTPAGE(FALSE);
        PostInventory.RUN;
        */
        UpdateInvDTWSetInputValue(ItemL."No.", LocationL.Code, ZoneL.Code, BinL.Code, 100, 'DTWTEST001', 'PRE101');
        //HEI.38<<
        //>>HEI.08

        //Step 1: Logon to Heilite

        //Step 2: Search for “Released Prod. Orders”
        // ReleasedProductionOrdersListL.OPENEDIT;
        ReleasedProductionOrderL.OPENNEW;

        //Step 3: Create a RPO
        ReleasedProductionOrderL.NEW;
        ReleasedProductionOrderL."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item, Location, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrderL."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrderL."Source No.".SETVALUE(ItemL."No.");
        ReleasedProductionOrderL."Location Code".SETVALUE(LocationL.Code);
        ReleasedProductionOrderL."Zone Code".SETVALUE(ZoneL.Code);
        ReleasedProductionOrderL."Bin Code".SETVALUE(BinL.Code);
        ReleasedProductionOrderL.Quantity.SETVALUE(2);
        ReleasedProductionOrderL."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrderL."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5: Refresh Production Order
        //ReleasedProductionOrderL."<Action26>".INVOKE;
        //HEI.26>>
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        ReleasedProductionOrderL.OK.INVOKE;


        // ReleasedProductionOrderL.GOTORECORD(ProductionOrderL);
        CLEAR(ReleasedProductionOrderL);
        ReleasedProductionOrderL.OPENEDIT;
        ReleasedProductionOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //Step 6: Modify Routing Version Code
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.14>>
        //HEI.37>>
        /*
        IF Location."To-Production Bin Code" = '' THEN
          Location."To-Production Bin Code" := Bin.Code;
        IF Location."From-Production Bin Code" = '' THEN
          Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        */
        if LocationL."To-Production Bin Code" = '' then
            LocationL."To-Production Bin Code" := Bin.Code;
        if LocationL."From-Production Bin Code" = '' then
            LocationL."From-Production Bin Code" := Bin.Code;
        LocationL.MODIFY;
        //HEI.37<<
        //HEI.14<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<
            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<

        //Step 7: Open Routing Page
        ReleasedProductionOrderL.ProdOrderLines.Routing.INVOKE;

        //Step 8: Modify Production BOM Version Code
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>

        //Step 9: Status as Released
        statusfilter := statusfilter::Released;
        FPPO := false;

        //Step 10: Enter Consumption Quantities
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        statusfilter := ProductionOrderL.Status;

        QuantityPer := 2;
        ReleasedProductionOrderL.ProdOrderLines.Components.INVOKE;

        //Step 11: To Enter Lots for Consumption in Prod Order Component Page - //Code By Lokenath
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));

                ItemTrackLineConsumption := true; // TO Control assigning the Lot Nos for Consumption & Output lines
                ProdOrderComponentsL.ItemTrackingLines.INVOKE;
            //ItemTrackingLines page is handled by function ItemTrackingLinesPageHandler_PRD010
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 12 Close Prod Order Components Page
        ProdOrderComponentsL.OK.INVOKE;

        //Step 13 To Open Production Journal Page from Released Prod Order Page
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;
        //Production Journal Page is handled by Function ProductionJournalPageHandler_PRD010

        //ReleasedProductionOrderL.CLOSE; //HEI.55
        // ReleasedProductionOrdersListL.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(QuantityPer);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(FPPO);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(BinCode);

    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_Yeast,ProdOrderComponentsPageHandler_PRD023,ItemTrackingLinesPageHandler_Yeast,ProductionJournalPageHandler_PRD023,MessageHandler,ConfirmationHandler,ItemTrackingSummaryPageHandler,AutoBatchGenerationReportHandler')]
    procedure RT_PRD021_CorrectConsumedorProducedQuantities_Yeast_7();
    var
        ReleasedProductionOrdersListL: TestPage "Released Production Orders";
        ReleasedProductionOrderL: TestPage "Released Production Order";
        ItemL: Record Item;
        Item2L: Record Item;
        LocationL: Record Location;
        ZoneL: Record Zone;
        BinL: Record Bin;
        WorkCenterL: Record "Work Center";
        ProductionOrderL: Record "Production Order";
        ProdOrderRoutingL: TestPage "Prod. Order Routing";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        ItemTrackingLinesL: TestPage "Item Tracking Lines";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.11>>
        MfgSetupDisable.GET;
        MfgSetupDisable."Consump. Tolerance Limit FND" := false;
        MfgSetupDisable.MODIFY;
        UserSetup.RESET;
        UserSetup.MODIFYALL("Consump. Tolerance Warning FND", true);
        //<<HEI.11
        //Remove default setup HEI.10>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.10<<

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Item);
        ItemL.GET(UnitTestingValues.Value);
        Item2L.GET(UnitTestingValues."Value 2");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Location);
        LocationL.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Zone);
        ZoneL.GET(LocationL.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Bin);
        BinL.GET(LocationL.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD019', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenterL.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenterL."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD019', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD022', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;

        //<<HEI.08
        //HEI.38>>
        /*
        PostInventory.SetInputValue(ItemL."No.",LocationL.Code,ZoneL.Code,BinL.Code,100,'DTWTEST001','PRE101');
        PostInventory.USEREQUESTPAGE(FALSE);
        PostInventory.RUN;
        */
        UpdateInvDTWSetInputValue(ItemL."No.", LocationL.Code, ZoneL.Code, BinL.Code, 100, 'DTWTEST001', 'PRE101');
        //HEI.38<<
        //>>HEI.08
        //Step 1: Logon to Heilite

        //Step 2: Search for “Released Prod. Orders”
        // ReleasedProductionOrdersListL.OPENEDIT;
        ReleasedProductionOrderL.OPENNEW;

        //Step 3: Create a RPO
        ReleasedProductionOrderL.NEW;
        ReleasedProductionOrderL."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item, Location, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrderL."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrderL."Source No.".SETVALUE(ItemL."No.");
        ReleasedProductionOrderL."Location Code".SETVALUE(LocationL.Code);
        ReleasedProductionOrderL."Zone Code".SETVALUE(ZoneL.Code);
        ReleasedProductionOrderL."Bin Code".SETVALUE(BinL.Code);
        ReleasedProductionOrderL.Quantity.SETVALUE(2);
        ReleasedProductionOrderL."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrderL."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5: Refresh Production Order
        //ReleasedProductionOrderL."<Action26>".INVOKE;
        //HEI.26>>
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        ReleasedProductionOrderL.OK.INVOKE;
        //COMMIT;
        ReleasedProductionOrderL.OPENEDIT;
        // ReleasedProductionOrderL.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);

        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>

        //Step 6: Modify Routing Version Code
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            // ReleasedProductionOrderL.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.14>>
        //HEI.46>>
        /*
        IF Location."To-Production Bin Code" = '' THEN
          Location."To-Production Bin Code" := Bin.Code;
        IF Location."From-Production Bin Code" = '' THEN
          Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        */
        if LocationL."To-Production Bin Code" = '' then
            LocationL."To-Production Bin Code" := Bin.Code;
        if LocationL."From-Production Bin Code" = '' then
            LocationL."From-Production Bin Code" := Bin.Code;
        LocationL.MODIFY;
        //HEI.46<<
        //HEI.14<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<

        //Step 7: Open Routing Page
        ReleasedProductionOrderL.ProdOrderLines.Routing.INVOKE;

        //Step 8: Modify Production BOM Version Code
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>

        //Step 9: Status as Released
        statusfilter := statusfilter::Released;
        FPPO := false;

        //Step 10: Enter Consumption Quantities
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        statusfilter := ProductionOrderL.Status;

        QuantityPer := 2;
        ReleasedProductionOrderL.ProdOrderLines.Components.INVOKE;

        //Step 11: To Enter Lots for Consumption in Prod Order Component Page - //Code By Lokenath
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));

                ItemTrackLineConsumption := true; // TO Control assigning the Lot Nos for Consumption & Output lines
                ProdOrderComponentsL.ItemTrackingLines.INVOKE;
            //ItemTrackingLines page is handled by function ItemTrackingLinesPageHandler_PRD010
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 12 Close Prod Order Components Page
        ProdOrderComponentsL.OK.INVOKE;

        //Step 13 To Open Production Journal Page from Released Prod Order Page
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;
        //Production Journal Page is handled by Function ProductionJournalPageHandler_PRD010

        // Step 14 Correct  Consumed or Produced Quantities
        CorrectQty := true;
        // Option a Increase in Total Consumed/Produced Qty
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;

        // Option b Decrease in Total Consumed/Produced Qty
        DecQty := true;
        // 201221 >>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues."Value 2");
        // 201221 <<
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Entry No.");
        ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
        ItemLedgerEntry.SETRANGE("Document No.", ProductionOrderNo);
        ItemLedgerEntry.SETRANGE("Item No.", Item."No.");  // 201221 >>
        ItemLedgerEntry.SETRANGE("Lot No.", CorrectionLotNo);
        if ItemLedgerEntry.FINDLAST then
            CorrEntryNo := ItemLedgerEntry."Entry No.";
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;
        COMMIT;//HEI.12
        //ReleasedProductionOrderL.CLOSE; //HEI.55
        // ReleasedProductionOrdersListL.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(QuantityPer);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(FPPO);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(CorrectQty);
        CLEAR(DecQty);
        CLEAR(CorrectionLotNo);
        CLEAR(CorrEntryNo);
        CLEAR(BinCode);

    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ProdOrderRoutingPageHandler_Yeast,ProdOrderComponentsPageHandler_PRD023,ItemTrackingLinesPageHandler_Yeast,ProductionJournalPageHandler_PRD023,MessageHandler,ConfirmationHandler,ChangeStatustoFPOPageHandler_PRD026,ItemTrackingSummaryPageHandler,AutoBatchGenerationReportHandler')]
    procedure RT_PRD026_FinishRPO_Yeast_8();
    var
        ReleasedProductionOrdersListL: TestPage "Released Production Orders";
        ReleasedProductionOrderL: TestPage "Released Production Order";
        ItemL: Record Item;
        Item2L: Record Item;
        LocationL: Record Location;
        ZoneL: Record Zone;
        BinL: Record Bin;
        WorkCenterL: Record "Work Center";
        ProductionOrderL: Record "Production Order";
        ProdOrderRoutingL: TestPage "Prod. Order Routing";
        ProdOrderComponentL: Record "Prod. Order Component";
        ProdOrderComponentsL: TestPage "Prod. Order Components";
        ItemTrackingLinesL: TestPage "Item Tracking Lines";
        FilteredProdOrderRtngLineSet: Record "Prod. Order Routing Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.11>>
        MfgSetupDisable.GET;
        MfgSetupDisable."Consump. Tolerance Limit FND" := false;
        MfgSetupDisable.MODIFY;
        UserSetup.RESET;
        UserSetup.MODIFYALL("Consump. Tolerance Warning FND", true);
        //<<HEI.11
        //Remove default setup HEI.10>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.10<<

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Item);
        ItemL.GET(UnitTestingValues.Value);
        Item2L.GET(UnitTestingValues."Value 2");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Location);
        LocationL.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Zone);
        ZoneL.GET(LocationL.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Bin);
        BinL.GET(LocationL.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD019', COMPANYNAME, DATABASE::"Work Center") then begin
            if UnitTestingValues.Value <> '' then
                WorkCenterL.GET(UnitTestingValues.Value);
            WorkCentercode := WorkCenterL."No.";
        end;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD019', COMPANYNAME, DATABASE::"Routing Version") then
            RoutingVersionCode := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        if UnitTestingValues.GET('PRD022', COMPANYNAME, DATABASE::"Production BOM Version") then
            ProdBOMVersionCode := UnitTestingValues.Value;


        //<<HEI.08
        //HEI.38>>
        /*
        PostInventory.SetInputValue(ItemL."No.",LocationL.Code,ZoneL.Code,BinL.Code,100,'DTWTEST001','PRE101');
        PostInventory.USEREQUESTPAGE(FALSE);
        PostInventory.RUN;
        */
        UpdateInvDTWSetInputValue(ItemL."No.", LocationL.Code, ZoneL.Code, BinL.Code, 100, 'DTWTEST001', 'PRE101');
        //HEI.38<<
        //>>HEI.08

        //Step 1: Logon to Heilite

        //Step 2: Search for “Released Prod. Orders”
        // ReleasedProductionOrdersListL.OPENEDIT;
        ReleasedProductionOrderL.OPENNEW;

        //Step 3: Create a RPO
        ReleasedProductionOrderL.NEW;
        ReleasedProductionOrderL."No.".ASSISTEDIT;

        //Step 4: Enter the details like Item, Location, Zone, Bin, Quantity and Due Date
        ReleasedProductionOrderL."Source Type".SETVALUE(Sourcefilter::Item);
        ReleasedProductionOrderL."Source No.".SETVALUE(ItemL."No.");
        ReleasedProductionOrderL."Location Code".SETVALUE(LocationL.Code);
        ReleasedProductionOrderL."Zone Code".SETVALUE(ZoneL.Code);
        ReleasedProductionOrderL."Bin Code".SETVALUE(BinL.Code);
        ReleasedProductionOrderL.Quantity.SETVALUE(2);
        ReleasedProductionOrderL."Due Date".SETVALUE(TODAY);
        ProductionOrderNo := ReleasedProductionOrderL."No.".VALUE;
        //HEI.26>>
        ProductionOrderStatus := ProductionOrderStatus::Released;
        COMMIT;
        RefreshProdOrder_Action26;
        //Step 5: Refresh Production Order
        //ReleasedProductionOrderL."<Action26>".INVOKE;
        //HEI.26>>
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        ReleasedProductionOrderL.OK.INVOKE;

        ReleasedProductionOrderL.OPENEDIT;
        // ReleasedProductionOrderL.GOTORECORD(ProductionOrderL);
        ReleasedProductionOrderL.FILTER.SETFILTER("No.", ProductionOrderNo);
        //HEI.05 <<
        RelProdOrdLines.RESET;
        RelProdOrdLines.SETRANGE("Prod. Order No.", ProductionOrderNo);
        RelProdOrdLines.FINDSET;
        //HEI.05 >>


        //Step 6: Modify Routing Version Code
        //HEI.05 <<
        //IF RoutingVersionCode <> '' THEN
        if RoutingVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Routing Version Code".SETVALUE(RoutingVersionCode);
            RelProdOrdLines."Routing Version Code" := RoutingVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>
        //HEI.14>>
        //HEI.46>>
        /*
        IF Location."To-Production Bin Code" = '' THEN
          Location."To-Production Bin Code" := Bin.Code;
        IF Location."From-Production Bin Code" = '' THEN
          Location."From-Production Bin Code" := Bin.Code;
        Location.MODIFY;
        */
        if LocationL."To-Production Bin Code" = '' then
            LocationL."To-Production Bin Code" := Bin.Code;
        if LocationL."From-Production Bin Code" = '' then
            LocationL."From-Production Bin Code" := Bin.Code;
        LocationL.MODIFY;
        //HEI.46<<
        //HEI.14<<
        //HEI.05 >>
        ProdOrderComponentL.RESET();
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderComponentL.FINDSET(true, false) then
        if ProdOrderComponentL.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat   //HEI.06

                FilteredProdOrderRtngLineSet.SETRANGE("Prod. Order No.", ProdOrderComponentL."Prod. Order No.");
                FilteredProdOrderRtngLineSet.FINDFIRST();
                ProdOrderComponentL."Bin Code" := ProdOrderComponentL.GetDefaultConsumptionBin(FilteredProdOrderRtngLineSet);
                ProdOrderComponentL.MODIFY;
            until ProdOrderComponentL.NEXT = 0;

        //HEI.05 <<
        //Step 7: Open Routing Page
        ReleasedProductionOrderL.ProdOrderLines.Routing.INVOKE;

        //Step 8: Modify Production BOM Version Code
        //HEI.05 <<
        //IF ProdBOMVersionCode <> '' THEN
        if ProdBOMVersionCode <> '' then begin
            //ReleasedProductionOrderL.ProdOrderLines."Production BOM Version Code".SETVALUE(ProdBOMVersionCode);
            RelProdOrdLines."Production BOM Version Code" := ProdBOMVersionCode;
            RelProdOrdLines.MODIFY;
        end;
        //HEI.05 >>


        //Step 9: Status as Released
        statusfilter := statusfilter::Released;
        FPPO := false;

        //Step 10: Enter Consumption Quantities
        ProductionOrderL.GET(ProductionOrderL.Status::Released, ProductionOrderNo);
        statusfilter := ProductionOrderL.Status;

        QuantityPer := 2;
        ReleasedProductionOrderL.ProdOrderLines.Components.INVOKE;

        //Step 11: To Enter Lots for Consumption in Prod Order Component Page - //Code By Lokenath
        ProdOrderComponentL.RESET;
        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        if ProdOrderComponentL.FINDSET then begin
            ProdOrderComponentsL.OPENEDIT;
            repeat
                ProdOrderLineNo := ProdOrderComponentL."Prod. Order Line No.";
                LineNo := ProdOrderComponentL."Line No.";
                ItemNo := ProdOrderComponentL."Item No.";
                LocationCode := ProdOrderComponentL."Location Code";
                BinCode := ProdOrderComponentL."Bin Code";
                //    ProdOrderComponentsL.GOTORECORD(ProdOrderComponentL);
                ProdOrderComponentsL.FILTER.SETFILTER(Status, 'Released');
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderComponentsL.FILTER.SETFILTER("Prod. Order Line No.", FORMAT(ProdOrderLineNo));
                ProdOrderComponentsL.FILTER.SETFILTER("Line No.", FORMAT(LineNo));

                ItemTrackLineConsumption := true; // TO Control assigning the Lot Nos for Consumption & Output lines
                ProdOrderComponentsL.ItemTrackingLines.INVOKE;
            //ItemTrackingLines page is handled by function ItemTrackingLinesPageHandler_PRD010
            until ProdOrderComponentL.NEXT = 0;
        end;

        //Step 12 Close Prod Order Components Page
        ProdOrderComponentsL.OK.INVOKE;

        //Step 13 To Open Production Journal Page from Released Prod Order Page
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;
        //Production Journal Page is handled by Function ProductionJournalPageHandler_PRD010

        // Step 14 Correct  Consumed or Produced Quantities
        CorrectQty := true;
        // Option a Increase in Total Consumed/Produced Qty
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;

        // Option b Decrease in Total Consumed/Produced Qty
        DecQty := true;
        // 201221 >>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues."Value 2");
        // 201221 <<
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Entry No.");
        ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
        ItemLedgerEntry.SETRANGE("Document No.", ProductionOrderNo);
        ItemLedgerEntry.SETRANGE("Item No.", Item."No.");  // 201221 >>
        ItemLedgerEntry.SETRANGE("Lot No.", CorrectionLotNo);
        if ItemLedgerEntry.FINDLAST then
            CorrEntryNo := ItemLedgerEntry."Entry No.";
        ReleasedProductionOrderL.ProdOrderLines.ProductionJournal.INVOKE;

        //Step 15 Call Action "Change &Status" from RPO to FPO
        //ReleasedProductionOrderL.Action53.INVOKE;//BC UPGRADE PATHAA02
        ReleasedProductionOrderL."Change &Status".invoke(); //BC UPGRADE PATHAA02
        //Change Status Action is handled By Function ChangeStatusPageHandler_PRD026

        // ReleasedProductionOrdersListL.CLOSE;
        CLEAR(ProductionOrderNo);
        CLEAR(WorkCentercode);
        CLEAR(statusfilter);
        CLEAR(RoutingVersionCode);
        CLEAR(ProdBOMVersionCode);
        CLEAR(QuantityPer);
        CLEAR(ProdOrderLineNo);
        CLEAR(LineNo);
        CLEAR(ItemNo);
        CLEAR(LocationCode);
        CLEAR(FPPO);
        CLEAR(ItemTrackLineConsumption);
        CLEAR(CorrectQty);
        CLEAR(DecQty);
        CLEAR(CorrectionLotNo);
        CLEAR(CorrEntryNo);
        CLEAR(BinCode);

    end;
    //BC UPGRADE PATHAA02>>
    [ModalPageHandler]
    //procedure NoSeriesListModalPageHandler(var NoSeriesList: Page "No. Series List"; var Response: Action);//BC UPGRADE PATHAA02
    procedure NoSeriesListModalPageHandler(var NoSeriesList: Page "No. Series"; var Response: Action); //BC UPGRADE PATHAA02

    begin
        //HEI.01, HEI.02
        Response := ACTION::LookupOK;
    end;

    //BC UPGRADE PATHAA02<<

    [ConfirmHandler]
    procedure ConfirmationHandler(Question: Text[1024]; var Reply: Boolean);
    var
        PostOrderQst: TextConst ENU = 'Do you want to post the Order?', FRA = 'Souhaitez-vous valider cette réception ?';
        ChangeRoutingVersionCode: Label 'This change may have caused bin codes on some production order component lines to be different from those on the production order routing line. Do you want to automatically align all of these unmatched bin codes?';
        ChangeWorkCenter: Label 'This change may have caused bin codes on some production order component lines to be different from those on the production order routing line. Do you want to automatically align all of these unmatched bin codes?';
        ChangeStatusRPOtoFPO: Label 'Production Order %1 has not been finished. Some consumption is still missing. Do you still want to finish the order?';
        PostShipmentQst: TextConst ENU = 'Do you want to post the shipment?', FRA = 'Voulez-vous poster l''envoi?';
    begin

        /*IF (Question = PostOrderQst) OR
           (Question = ChangeRoutingVersionCode) OR
           (Question = ChangeWorkCenter) OR
           (Question = STRSUBSTNO(ChangeStatusRPOtoFPO,ProductionOrderNo)) OR
           (Question = PostShipmentQst) THEN
          Reply := TRUE;*/
        //  IF (Question = PostOrderQst) OR
        //   (Question = ChangeRoutingVersionCode) OR
        //   (Question = ChangeWorkCenter) OR
        //   (Question = PostShipmentQst) THEN
        Reply := true;

    end;

    [ConfirmHandler]
    procedure ConfirmationHandler_new(Question: Text[1024]; var Reply: Boolean);
    var
        DeleteLine: TextConst ENU = 'GO head and delete the Selected Line', FRA = 'Souhaitez-vous valider cette réception ?';
    begin
        Reply := true;
    end;

    [ConfirmHandler]
    procedure ConfirmationHandler_itemtracking(Question: Text[1024]; var Reply: Boolean);
    var
        DeleteLine: TextConst ENU = 'GO head and delete the Selected Line', FRA = 'Souhaitez-vous valider cette réception ?';
    begin
        Reply := false;
    end;

    [MessageHandler]
    procedure MessageHandler(Message: Text[1024]);
    begin
    end;

    [ModalPageHandler]
    procedure ChangeStatusPageHandler_PRD083(var ChangeStatusonProdOrder: TestPage "Change Status on Prod. Order");
    begin
        if changestatusupdate then
            ChangeStatusonProdOrder.FirmPlannedStatus.SETVALUE(statusfilter::Finished)
        else begin
            ChangeStatusonProdOrder.FirmPlannedStatus.SETVALUE(statusfilter::Released);
            changestatusupdate := true;
        end;
        ChangeStatusonProdOrder.PostingDate.SETVALUE(TODAY);
        ChangeStatusonProdOrder.ReqUpdUnitCost.SETVALUE(true);
        ChangeStatusonProdOrder.Yes.INVOKE; //Yes Invoking will close the page-Change Status & Firm planned prod order
    end;

    [ModalPageHandler]
    procedure ChangeStatustoRPOPageHandler_PRD006(var ChangeStatusonProdOrder: TestPage "Change Status on Prod. Order");
    begin
        ChangeStatusonProdOrder.FirmPlannedStatus.SETVALUE(statusfilter::Released);
        ChangeStatusonProdOrder.PostingDate.SETVALUE(TODAY);
        ChangeStatusonProdOrder.ReqUpdUnitCost.SETVALUE(true);
        ChangeStatusonProdOrder.Yes.INVOKE; //Yes Invoking will close the page-Change Status & Firm planned prod order
    end;

    [ModalPageHandler]
    procedure RoutingPageHandler_PRD010(var ProdOrderRouting: TestPage "Prod. Order Routing");
    var
        ProdOrderRoutingL: Record "Prod. Order Routing Line";
    begin
        //** add expected capacity need field on page line-->routing page
        //TO check Condition in Prod Routing Page Column "Expected Capacity Need" is not 0
        if statusfilter = statusfilter::Released then begin
            //HEI.05 <<
            ProdOrderRoutingL.RESET;
            ProdOrderRoutingL.SETRANGE("Prod. Order No.", ProductionOrderNo);

            ProdOrderRoutingL.FINDSET;
            //HEI.05 >>

            //  ProdOrderRoutingL.SETRANGE("Prod. Order No.",ProductionOrderNo);
            //  ProdOrderRoutingL.SETRANGE(Status,ProdOrderRoutingL.Status::Released);
            //  ProdOrderRoutingL.FINDSET;
            //  ProdOrderRouting.GOTORECORD(ProdOrderRoutingL);
            ProdOrderRouting.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);

            //IF ProdOrderRouting."Expected Capacity Need".ASDECIMAL = 0  THEN //HEI.05
            if ProdOrderRoutingL."Expected Capacity Need" = 0 then    //HEI.05
                ERROR('Expected Capacity Need Value Should not be 0');

            ProdOrderRouting.OK.INVOKE;
        end else begin
            if WorkCentercode <> '' then begin
                ProdOrderRouting.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
                ProdOrderRouting."No.".SETVALUE(WorkCentercode); //(conf handler)
            end;
            ProdOrderRouting.OK.INVOKE;
        end;
    end;

    [ModalPageHandler]
    procedure ProdOrderRoutingPageHandler_PRD005(var ProdOrderRouting: TestPage "Prod. Order Routing");
    begin
        if WorkCentercode <> '' then begin
            ProdOrderRouting.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
            ProdOrderRouting."No.".SETVALUE(WorkCentercode); //(conf handler)
        end;
        ProdOrderRouting.OK.INVOKE;
    end;

    [PageHandler]
    procedure ProdOrderComponentPageHandler_PRD013(var ProdOrderComp: TestPage "Prod. Order Components");
    var
        ProductionOrderL: Record "Production Order";
        ProdOrderCompL: Record "Prod. Order Component";
        Item1L: Record Item;
        LocationL: Record Location;
        ZoneL: Record Zone;
        BinL: Record Bin;
        Item2L: Record Item;
        ProdOrderCompL2: Record "Prod. Order Component";
    begin
        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Item);
        Item1L.GET(UnitTestingValues."Value 2");
        Item2L.GET(UnitTestingValues."Value 3");

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Location);
        LocationL.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Zone);
        ZoneL.GET(LocationL.Code, UnitTestingValues."Value 2");

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Bin);
        BinL.GET(LocationL.Code, UnitTestingValues."Value 2");

        //Add new Line in Production order Components Page
        ProdOrderCompL.RESET;
        ProdOrderCompL.SETFILTER("Prod. Order No.", ProductionOrderNo);
        ProdOrderCompL.SETRANGE(Status, ProdOrderCompL.Status::"Firm Planned");
        if ProdOrderCompL.FINDFIRST then begin
            ProdOrderComp.GOTORECORD(ProdOrderCompL);
            ProdOrderComp.NEW;
            ProdOrderComp."Item No.".SETVALUE(Item1L."No.");
            ProdOrderComp."Quantity per".SETVALUE(1);
            //>>Code commented not required HEI.07 ---
            //ProdOrderComp."Location Code".SETVALUE(LocationL.Code); //HEI.05
            //ProdOrderCompL."Location Code" := LocationL.Code; //HEI.05
            //ProdOrderComp."Bin Code".SETVALUE(BinL.Code); //HEI.05
            //ProdOrderCompL."Bin Code" := BinL.Code; //HEI.05
            //ProdOrderComp."Zone Code".SETVALUE(ZoneL.Code); //HEI.05
            //ProdOrderCompL."Zone Code" := ZoneL.Code; //HEI.05
            //ProdOrderCompL.MODIFY; //HEI.05
            //ProdOrderComp.OK.INVOKE;
        end;

        //HEI.07>>
        ProdOrderCompL2.RESET;
        ProdOrderCompL2.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderCompL2.SETRANGE("Prod. Order No.", ProductionOrderNo);
        ProdOrderCompL2.SETRANGE(Status, ProdOrderCompL2.Status::"Firm Planned");
        ProdOrderCompL2.SETRANGE("Item No.", Item1L."No.");
        if ProdOrderCompL2.FINDLAST then begin
            ProdOrderCompL2."Location Code" := LocationL.Code;
            ProdOrderCompL2."Zone Code FND" := ZoneL.Code;
            ProdOrderCompL2."Bin Code" := BinL.Code;
            ProdOrderCompL2.MODIFY;
        end;
        //HEI.07<<

        //Remove Existing Line (with item '0020000346') , Which is created By Changing the Production BOM version Column with 'ALT2.0'
        ProdOrderCompL.RESET;
        ProdOrderCompL.SETFILTER("Prod. Order No.", ProductionOrderNo);
        ProdOrderCompL.SETRANGE(Status, ProdOrderCompL.Status::"Firm Planned");
        ProdOrderCompL.SETRANGE("Item No.", Item2L."No.");
        if ProdOrderCompL.FINDFIRST then
            ProdOrderCompL.DELETE;
        ProdOrderComp.OK.INVOKE;
    end;

    [PageHandler]
    procedure ProdOrderComponentsPageHandler_PRD013_PRD050(var ProdOrderComp: TestPage "Prod. Order Components");
    var
        ProdOrderComponentL: Record "Prod. Order Component";
        Item1L: Record Item;
        Item2L: Record Item;
        Item3L: Record Item;
        LocationL: Record Location;
        ZoneL: Record Zone;
        Zone2L: Record Zone;
        Zone3L: Record Zone;
        BinL: Record Bin;
        Bin2L: Record Bin;
        Bin3L: Record Bin;
        ProdOrderCompL: Record "Prod. Order Component";
        ProdOrderCompL2: Record "Prod. Order Component";
    begin
        //HEI.01>>
        case statusfilter of
            statusfilter::Released:
                begin
                    if FPPO then begin
                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Item);
                        Item2L.GET(UnitTestingValues."Value 2");
                        Item3L.GET(UnitTestingValues."Value 3");

                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Location);
                        LocationL.GET(UnitTestingValues.Value);

                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Zone);
                        Zone2L.GET(LocationL.Code, UnitTestingValues."Value 2");

                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Bin);
                        Bin2L.GET(LocationL.Code, UnitTestingValues."Value 2");

                        ProdOrderComponentL.RESET;
                        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
                        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
                        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
                        if ProdOrderComponentL.FINDLAST then begin
                            ProdOrderComp.GOTORECORD(ProdOrderComponentL);
                            ProdOrderComp.NEW;
                            ProdOrderComp."Item No.".SETVALUE(Item2L."No.");
                            ProdOrderComp."Quantity per".SETVALUE(1);
                            //Code not required --- HEI.06 >>
                            //ProdOrderComp."Location Code".SETVALUE(LocationL.Code); //HEI.05
                            //ProdOrderComponentL."Location Code" := LocationL.Code; //HEI.05
                            //ProdOrderComp."Zone Code".SETVALUE(Zone2L.Code); //HEI.05
                            //ProdOrderComponentL."Zone Code" := Zone2L.Code; //HEI.05
                            //ProdOrderComp."Bin Code".SETVALUE(Bin2L.Code); //HEI.05
                            //ProdOrderComponentL."Bin Code" := Bin2L.Code; //HEI.05
                            //ProdOrderComponentL.MODIFY; //HEI.05
                            //Code not required ---
                            ProdOrderComp.OK.INVOKE;
                        end;
                        //HEI.06>>
                        ProdOrderCompL2.RESET;
                        ProdOrderCompL2.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
                        ProdOrderCompL2.SETRANGE("Prod. Order No.", ProductionOrderNo);
                        ProdOrderCompL2.SETRANGE(Status, ProdOrderComponentL.Status::Released);
                        ProdOrderCompL2.SETRANGE("Item No.", Item2L."No.");
                        //IF ProdOrderCompL2.FINDLAST THEN BEGIN //HEI.09 code modified

                        // BC Upgrade MISHRS14 >>
                        // Removed false from FINDSET due to warning because its being depreceted
                        //if ProdOrderCompL2.FINDSET(true, true) then begin //HEI.09
                        if ProdOrderCompL2.FINDSET(true) then begin //HEI.09
                                                                    // BC Upgrade MISHRS14 <<

                            repeat
                                ProdOrderCompL2."Location Code" := LocationL.Code;
                                ProdOrderCompL2."Zone Code FND" := Zone2L.Code;
                                ProdOrderCompL2."Bin Code" := Bin2L.Code;
                                ProdOrderCompL2.MODIFY;
                                //HEI.31>>
                                //HEI.38>>
                                /*
                                  ItemInventory1.InitParameters(ProdOrderCompL2."Item No.",ProdOrderCompL2."Location Code",ProdOrderCompL2."Zone Code",ProdOrderCompL2."Bin Code",100000,'DTWT001','PRE101');
                                  ItemInventory1.USEREQUESTPAGE(FALSE);
                                  ItemInventory1.RUN;
                                   */
                                UpdateItemInvDTW2InitParameters(ProdOrderCompL2."Item No.", ProdOrderCompL2."Location Code", ProdOrderCompL2."Zone Code FND", ProdOrderCompL2."Bin Code", 100000, 'DTWT001', 'PRE101');
                            //HEI.38<<
                            //HEI.31<<
                            until ProdOrderCompL2.NEXT = 0; //HEI.09
                        end;
                        //HEI.06<<
                        ProdOrderComponentL.RESET;
                        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
                        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
                        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
                        ProdOrderComponentL.SETRANGE("Item No.", Item3L."No.");
                        if ProdOrderComponentL.FINDFIRST then
                            ProdOrderComponentL.DELETE;

                        //      ProdOrderComponentL.SETRANGE("Item No.",Item3L."No.");
                        //      IF ProdOrderComponentL.FINDFIRST THEN BEGIN
                        //        ProdOrderComp.GOTORECORD(ProdOrderComponentL);
                        //        ProdOrderComp."Zone Code".SETVALUE(Zone3L.Code);
                        //        ProdOrderComp."Bin Code".SETVALUE(Bin3L.Code);
                        //        ProdOrderComp."Quantity per".SETVALUE(QuantityPer);
                        //        ProdOrderComp.OK.INVOKE;
                        //      END;
                    end else begin
                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Item);
                        Item1L.GET(UnitTestingValues."Value 2");
                        Item2L.GET(UnitTestingValues."Value 3");

                        //Check default value for Location
                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Location);
                        LocationL.GET(UnitTestingValues.Value);

                        //Check default value for Zone
                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Zone);
                        ZoneL.GET(LocationL.Code, UnitTestingValues."Value 2");

                        //Check default value for Bin
                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD001', COMPANYNAME, DATABASE::Bin);
                        BinL.GET(LocationL.Code, UnitTestingValues."Value 2");

                        //Add new Line in Production order Components Page
                        ProdOrderCompL.RESET;
                        ProdOrderCompL.SETFILTER("Prod. Order No.", ProductionOrderNo);
                        ProdOrderCompL.SETRANGE(Status, ProdOrderCompL.Status::"Firm Planned");
                        if ProdOrderCompL.FINDFIRST then begin
                            ProdOrderComp.GOTORECORD(ProdOrderCompL);
                            ProdOrderComp.NEW;
                            ProdOrderComp."Item No.".SETVALUE(Item1L."No.");
                            ProdOrderComp."Quantity per".SETVALUE(1);
                            //HEI.07 Code commented for Not required-----
                            //ProdOrderComp."Location Code".SETVALUE(LocationL.Code);
                            //ProdOrderComp."Bin Code".SETVALUE(BinL.Code);
                            //ProdOrderComp."Zone Code".SETVALUE(ZoneL.Code);
                        end;
                        //>>HEI.07 --
                        ProdOrderCompL2.RESET;
                        ProdOrderCompL2.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
                        ProdOrderCompL2.SETRANGE("Prod. Order No.", ProductionOrderNo);
                        ProdOrderCompL2.SETRANGE(Status, ProdOrderComponentL.Status::"Firm Planned");
                        ProdOrderCompL2.SETRANGE("Item No.", Item1L."No.");
                        //IF ProdOrderCompL2.FINDLAST THEN BEGIN //HEI.09 code modified

                        // BC Upgrade MISHRS14 >>
                        // Removed false from FINDSET due to warning because its being depreceted
                        //if ProdOrderCompL2.FINDSET(true, true) then begin //HEI.09
                        if ProdOrderCompL2.FINDSET(true) then begin //HEI.09
                                                                    // BC Upgrade MISHRS14 <<

                            repeat
                                ProdOrderCompL2."Location Code" := LocationL.Code;
                                ProdOrderCompL2."Zone Code FND" := ZoneL.Code;
                                ProdOrderCompL2."Bin Code" := BinL.Code;
                                ProdOrderCompL2.MODIFY;
                            until ProdOrderCompL2.NEXT = 0;//HEI.09
                        end;
                        //<<HEI.07 --

                        //Remove Existing Line (with item '0020000346') , Which is created By Changing the Production BOM version Column with 'ALT2.0'
                        ProdOrderCompL.RESET;
                        ProdOrderCompL.SETFILTER("Prod. Order No.", ProductionOrderNo);
                        ProdOrderCompL.SETRANGE(Status, ProdOrderCompL.Status::"Firm Planned");
                        ProdOrderCompL.SETRANGE("Item No.", Item2L."No.");
                        if ProdOrderCompL.FINDFIRST then
                            ProdOrderCompL.DELETE;
                        ProdOrderComp.OK.INVOKE;

                    end;
                end;
        end;
        //HEI.01<<

    end;

    [ModalPageHandler]
    procedure ItemTrackingLinesPageHandler_Brew(var ItemTrackingLines: TestPage "Item Tracking Lines");
    var
        TrackingSpecificationL: Record "Tracking Specification" temporary;
        ItemTrackingSummaryL: TestPage "Item Tracking Summary";
        ItemTrackingSummary: Page "Item Tracking Summary";
    begin
        //To Assign Lot Nos in Prod Order Components Page for Consumption Lines.
        if ItemTrackLineConsumption then begin
            case statusfilter of
                statusfilter::Released:
                    begin
                        TrackingSpecificationL.RESET;
                        TrackingSpecificationL.SETCURRENTKEY("Source Type", "Source Subtype", "Source ID", "Source Prod. Order Line",
                          "Source Ref. No.", "Item No.", "Location Code");
                        if not CorrectQty then begin
                            TrackingSpecificationL.SETRANGE("Source Type", DATABASE::"Prod. Order Component");
                            TrackingSpecificationL.SETRANGE("Source Subtype", TrackingSpecificationL."Source Subtype"::"3");
                            TrackingSpecificationL.SETRANGE("Source ID", ProductionOrderNo);
                            TrackingSpecificationL.SETRANGE("Source Prod. Order Line", ProdOrderLineNo);
                            TrackingSpecificationL.SETRANGE("Source Ref. No.", LineNo);
                            TrackingSpecificationL.SETRANGE("Item No.", ItemNo);
                            TrackingSpecificationL.SETRANGE("Location Code", LocationCode);
                        end else begin
                            TrackingSpecificationL.SETRANGE("Source Type", DATABASE::"Item Journal Line");
                            TrackingSpecificationL.SETRANGE("Source Subtype", TrackingSpecificationL."Source Subtype"::"5");
                            TrackingSpecificationL.SETRANGE("Source ID", ProductionOrderNo);
                            TrackingSpecificationL.SETRANGE("Source Ref. No.", LineNo);
                            TrackingSpecificationL.SETRANGE("Item No.", ItemNo);
                            TrackingSpecificationL.SETRANGE("Location Code", LocationCode);
                        end;
                        if TrackingSpecificationL.ISEMPTY then begin
                            if (ItemTrackingLines."Select Entries".VISIBLE) and not (DecQty) then begin
                                ItemTrackingSummaryL.OPENVIEW;
                                ItemTrackingLines."Select Entries".INVOKE;
                                if CorrectQty then
                                    CorrectionLotNo := ItemTrackingLines."Lot No.".VALUE;
                                ItemTrackingSummaryL.OK.INVOKE;
                                ItemTrackingLines.OK.INVOKE;
                            end;
                        end;
                        if DecQty then begin
                            ItemTrackingLines."Lot No.".SETVALUE(CorrectionLotNo);
                            ItemTrackingLines."Appl.-from Item Entry".SETVALUE(CorrEntryNo);
                            //ItemTrackingLines."Appl.-to Item Entry".SETVALUE(CorrEntryNo);
                            ItemTrackingLines.OK.INVOKE;
                        end;
                    end;
            end;
        end else begin
            //To Assign Lot Nos in Prod Journal Page for Output line.
            ItemTrackingLines."Create Batch Number".INVOKE;
            ItemTrackingLines.OK.INVOKE;
        end;
    end;

    [ModalPageHandler]
    procedure ProductionJournalPageHandler_Brew(VAR ProdOrdJournal: TestPage "Production Journal");
    var
        ProdOrderJournalL: Record "Item Journal Line";
        ItemTrackingLines: TestPage "Item Tracking Lines";
    begin
        if not CorrectQty then begin
            //To check the Condition if 'Run Time' and 'Setup Time' both column is not 0 in Production Journal Page For Output Line
            ProdOrderJournalL.RESET;
            ProdOrderJournalL.SETRANGE("Document No.", ProductionOrderNo);
            ProdOrderJournalL.SETRANGE("Order Type", ProdOrderJournalL."Order Type"::Production);
            ProdOrderJournalL.SETRANGE("Entry Type", ProdOrderJournalL."Entry Type"::Output);
            ProdOrderJournalL.FINDFIRST;
            ProdOrdJournal.GOTORECORD(ProdOrderJournalL);
            if (ProdOrdJournal."Setup Time".ASDECIMAL = 0) and (ProdOrdJournal."Run Time".ASDECIMAL = 0) then
                ERROR('Setup Time OR Run Time Value Should not be 0');

            ItemTrackLineConsumption := false; //TO Control assigning the Lot Nos for Consumption & Output lines

            //Assign Lot No. in production journal page for Output Line.
            ProdOrdJournal.ItemTrackingLines.INVOKE;
            //ItemTrackingLines Page is handled by function ItemTrackingLinesPageHandler_PRD010

            //Post the lines from Produciton Journal page
            ProdOrdJournal.Post.INVOKE;
            ProdOrdJournal.OK.INVOKE;
        end
        //********SB******************************
        else begin
            UnitTestingValues.RESET;
            UnitTestingValues.GET('PRD011', COMPANYNAME, DATABASE::Item);
            Item.GET(UnitTestingValues.Value);
            ProdOrderJournalL.RESET;
            ProdOrderJournalL.SETRANGE("Document No.", ProductionOrderNo);
            ProdOrderJournalL.SETRANGE("Item No.", Item."No.");
            if ProdOrderJournalL.FINDFIRST then begin
                LineNo := ProdOrderJournalL."Line No.";
                ItemNo := ProdOrderJournalL."Item No.";
                LocationCode := ProdOrderJournalL."Location Code";
                BinCode := ProdOrderJournalL."Bin Code";
                ProdOrdJournal.GOTORECORD(ProdOrderJournalL);
                if not DecQty then
                    //ProdOrdJournal.Quantity.SETVALUE(1) //HEI.07 - Commented for code change
                    ProdOrdJournal.Quantity.SETVALUE(10) //HEI.07
                else
                    //ProdOrdJournal.Quantity.SETVALUE(-1); //HEI.07 - Commented for code change
                    ProdOrdJournal.Quantity.SETVALUE(-10); //HEI.07

                ItemTrackLineConsumption := true;
                //Assign Lot No. in production journal page for Output Line.
                ProdOrdJournal.ItemTrackingLines.INVOKE;
                //ItemTrackingLines Page is handled by function ItemTrackingLinesPageHandler_PRD010

                //Post the lines from Produciton Journal page
                ProdOrdJournal.Post.INVOKE;
                ProdOrdJournal.OK.INVOKE;
            end;
        end;
    end;

    [ModalPageHandler]
    procedure ItemTrackingSummaryPageHandler(var ItemTrackingSummary: TestPage "Item Tracking Summary");
    begin
        // ItemTrackingSummary.FILTER.SETFILTER("Location Code", LocationCode); //BC UPGRADE PATHAA02-DIT P6500/T338
        // ItemTrackingSummary.FILTER.SETFILTER("Bin Code", BinCode); //BC UPGRADE PATHAA02-DIT P6500/T338
        ItemTrackingSummary.OK.INVOKE;
    end;

    [ModalPageHandler]
    procedure ProdOrderRoutingPageHandler_PRD075(VAR ProdOrderRouting: TestPage "Prod. Order Routing");
    begin
        if WorkCentercode <> '' then begin
            ProdOrderRouting.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
            ProdOrderRouting."No.".SETVALUE(WorkCentercode); //(conf handler)
        end;
        ProdOrderRouting.OK.INVOKE;
    end;

    [ModalPageHandler]
    procedure ChangeStatustoRPOPageHandler_PRD076(VAR ChangeStatusonProdOrder: TestPage "Change Status on Prod. Order");
    begin
        ChangeStatusonProdOrder.FirmPlannedStatus.SETVALUE(statusfilter::Released);
        ChangeStatusonProdOrder.PostingDate.SETVALUE(TODAY);
        ChangeStatusonProdOrder.ReqUpdUnitCost.SETVALUE(true);
        ChangeStatusonProdOrder.Yes.INVOKE; //Yes Invoking will close the page-Change Status & Firm planned prod order
    end;

    [PageHandler]
    procedure ProdOrderComponentPageHandler_PRD077(VAR ProdOrderComp: TestPage "Prod. Order Components");
    var
        ProductionOrderL: Record "Production Order";
        ProdOrderCompL: Record "Prod. Order Component";
        Item1L: Record Item;
        LocationL: Record Location;
        ZoneL: Record Zone;
        BinL: Record Bin;
        Item2L: Record Item;
        Item3L: Record Item;
        ProdOrderCompL2: Record "Prod. Order Component";
    begin
        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD077', COMPANYNAME, DATABASE::Item);
        Item1L.GET(UnitTestingValues.Value);
        Item2L.GET(UnitTestingValues."Value 2");
        Item3L.GET(UnitTestingValues."Value 3");

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD077', COMPANYNAME, DATABASE::Location);
        LocationL.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD077', COMPANYNAME, DATABASE::Zone);
        ZoneL.GET(LocationL.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD077', COMPANYNAME, DATABASE::Bin);
        BinL.GET(LocationL.Code, UnitTestingValues.Value);

        //Remove Existing Line Which is created By Changing the Production BOM version Column with 'ALT2.0'
        // ProdOrderCompL.RESET;
        // ProdOrderCompL.SETFILTER("Prod. Order No.",ProductionOrderNo);
        // ProdOrderCompL.SETRANGE(Status,ProdOrderCompL.Status::"Firm Planned");
        // IF ProdOrderCompL.FINDSET THEN
        //  ProdOrderCompL.DELETEALL;

        //Add new Line in Production order Components Page
        //161221 >>
        ProdOrderCompL.RESET;
        ProdOrderCompL.SETFILTER("Prod. Order No.", ProductionOrderNo);
        ProdOrderCompL.SETRANGE(Status, ProdOrderCompL.Status::"Firm Planned");
        if ProdOrderCompL.FINDFIRST then begin
            ProdOrderComp.GOTORECORD(ProdOrderCompL);    //161221
            ProdOrderComp.NEW;
            ProdOrderComp."Item No.".SETVALUE(Item1L."No.");
            ProdOrderComp."Quantity per".SETVALUE(2);
            //>>HEI.07 Commented on code not required----
            // ProdOrderComp."Location Code".SETVALUE(LocationL.Code);//HEI.05
            // ProdOrderCompL."Location Code" := LocationL.Code; //HEI.05
            // ProdOrderCompL."Zone Code" := ZoneL.Code ; //HEI.05
            // ProdOrderCompL."Bin Code" := BinL.Code; //HEI.05
            // ProdOrderCompL.MODIFY;//HEI.05
            ProdOrderComp.OK.INVOKE;
        end;
        //HEI.07>>
        ProdOrderCompL2.RESET;
        ProdOrderCompL2.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderCompL2.SETRANGE("Prod. Order No.", ProductionOrderNo);
        ProdOrderCompL2.SETRANGE(Status, ProdOrderCompL2.Status::"Firm Planned");
        ProdOrderCompL2.SETRANGE("Item No.", Item1L."No.");
        if ProdOrderCompL2.FINDLAST then begin
            ProdOrderCompL2."Location Code" := LocationL.Code;
            ProdOrderCompL2."Zone Code FND" := ZoneL.Code;
            ProdOrderCompL2."Bin Code" := BinL.Code;
            ProdOrderCompL2.MODIFY;
            //HEI.31>>
            //HEI.38>>
            /*
            ItemInventory1.InitParameters(ProdOrderCompL2."Item No.",ProdOrderCompL2."Location Code",ProdOrderCompL2."Zone Code",ProdOrderCompL2."Bin Code",100000,'DTWT001','PRE101');
            ItemInventory1.USEREQUESTPAGE(FALSE);
            ItemInventory1.RUN;
             */
            UpdateItemInvDTW2InitParameters(ProdOrderCompL2."Item No.", ProdOrderCompL2."Location Code", ProdOrderCompL2."Zone Code FND", ProdOrderCompL2."Bin Code", 100000, 'DTWT001', 'PRE101');
            //HEI.38<<
            //HEI.31<<
        end;
        //HEI.07<<

    end;

    [ModalPageHandler]
    procedure ChangeStatusPageHandler_PRD078(VAR ChangeStatusonProdOrder: TestPage "Change Status on Prod. Order");
    begin
        ChangeStatusonProdOrder.FirmPlannedStatus.SETVALUE(statusfilter::Released);
        ChangeStatusonProdOrder.PostingDate.SETVALUE(TODAY);
        ChangeStatusonProdOrder.ReqUpdUnitCost.SETVALUE(true);
        ChangeStatusonProdOrder.Yes.INVOKE; //Yes Invoking will close the page-Change Status & Firm planned prod order
    end;

    [ModalPageHandler]
    procedure RoutingPageHandler_PRD078(VAR ProdOrderRouting: TestPage "Prod. Order Routing");
    var
        ProdOrderRoutingL: Record "Prod. Order Routing Line";
    begin
        //TO check Condition in Prod Routing Page Column "Expected Capacity Need" is not 0

        //HEI.05 <<
        ProdOrderRoutingL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        ProdOrderRoutingL.FINDSET;

        //HEI.05 >>

        if WorkCentercode <> '' then begin
            ProdOrderRouting.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
            ProdOrderRouting."No.".SETVALUE(WorkCentercode);
        end;

        ProdOrderRouting.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
        //IF ProdOrderRouting."Expected Capacity Need".ASDECIMAL = 0  THEN //HEI.05
        if ProdOrderRoutingL."Expected Capacity Need" = 0 then //HEI.05
            ERROR('Expected Capacity Need Value Should not be 0');

        ProdOrderRouting.OK.INVOKE;
    end;

    [ModalPageHandler]
    procedure ItemTrackingLinesPageHandler_PRD078(VAR ItemTrackingLines: TestPage "Item Tracking Lines");
    var
        TrackingSpecificationL: Record "Tracking Specification" temporary;
        ItemTrackingSummaryL: TestPage "Item Tracking Summary";
        ItemTrackingSummary: Page "Item Tracking Summary";
    begin
        //To Assign Lot Nos in Prod Order Components Page for Consumption Lines.
        if ItemTrackLineConsumption then begin
            case statusfilter of
                statusfilter::Released:
                    begin
                        TrackingSpecificationL.RESET;
                        TrackingSpecificationL.SETCURRENTKEY("Source Type", "Source Subtype", "Source ID", "Source Prod. Order Line",
                          "Source Ref. No.", "Item No.", "Location Code");
                        TrackingSpecificationL.SETRANGE("Source Type", DATABASE::"Prod. Order Component");
                        TrackingSpecificationL.SETRANGE("Source Subtype", TrackingSpecificationL."Source Subtype"::"3");
                        TrackingSpecificationL.SETRANGE("Source ID", ProductionOrderNo);
                        TrackingSpecificationL.SETRANGE("Source Prod. Order Line", ProdOrderLineNo);
                        TrackingSpecificationL.SETRANGE("Source Ref. No.", LineNo);
                        TrackingSpecificationL.SETRANGE("Item No.", ItemNo);
                        TrackingSpecificationL.SETRANGE("Location Code", LocationCode);
                        if TrackingSpecificationL.ISEMPTY then begin
                            if ItemTrackingLines."Select Entries".VISIBLE then begin
                                ItemTrackingSummaryL.OPENVIEW;
                                ItemTrackingLines."Select Entries".INVOKE;
                                ItemTrackingSummaryL.OK.INVOKE;
                                ItemTrackingLines.OK.INVOKE;
                            end;
                        end;
                    end;
            end;
        end else begin
            //To Assign Lot Nos in Prod Journal Page for Output line.

            ItemTrackingLines."Create Batch Number".INVOKE;
            LotNoOutput := ItemTrackingLines."Lot No.".VALUE;      // For Move FPs to Logistics
            ItemTrackingLines.OK.INVOKE;
        end;
    end;

    [ModalPageHandler]
    procedure ProductionJournalPageHandler_PRD078(VAR ProdOrdJournal: TestPage "Production Journal");
    var
        ProdOrderJournalL: Record "Item Journal Line";
        ItemTrackingLines: TestPage "Item Tracking Lines";
    begin
        //To check the Condition if 'Run Time' and 'Setup Time' both column is not 0 in Production Journal Page For Output Line
        ProdOrderJournalL.RESET;
        ProdOrderJournalL.SETRANGE("Document No.", ProductionOrderNo);
        ProdOrderJournalL.SETRANGE("Order Type", ProdOrderJournalL."Order Type"::Production);
        ProdOrderJournalL.SETRANGE("Entry Type", ProdOrderJournalL."Entry Type"::Output);
        ProdOrderJournalL.FINDFIRST;
        ProdOrdJournal.GOTORECORD(ProdOrderJournalL);
        if (ProdOrdJournal."Setup Time".ASDECIMAL = 0) and (ProdOrdJournal."Run Time".ASDECIMAL = 0) then
            ERROR('Setup Time OR Run Time Value Should not be 0');

        ItemTrackLineConsumption := false; //TO Control assigning the Lot Nos for Consumption & Output lines

        //Assign Lot No. in production journal page for Output Line.
        ProdOrdJournal.ItemTrackingLines.INVOKE;

        //Post the lines from Produciton Journal page
        ProdOrdJournal.Post.INVOKE;
        ProdOrdJournal.OK.INVOKE;
    end;

    [PageHandler]
    procedure ProdOrderComponentsPageHandler_PRD078(VAR ProdOrderComp: TestPage "Prod. Order Components");
    var
        ProdOrderComponentL: Record "Prod. Order Component";
        Item1L: Record Item;
        Item2L: Record Item;
        Item3L: Record Item;
        LocationL: Record Location;
        Zone2L: Record Zone;
        Zone3L: Record Zone;
        Bin2L: Record Bin;
        Bin3L: Record Bin;
        ProdOrderCompL2: Record "Prod. Order Component";
    begin

        case statusfilter of
            statusfilter::Released:
                begin
                    if FPPO then begin
                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD013', COMPANYNAME, DATABASE::Item);
                        Item1L.GET(UnitTestingValues.Value);
                        Item2L.GET(UnitTestingValues."Value 2");
                        Item3L.GET(UnitTestingValues."Value 3");

                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD013', COMPANYNAME, DATABASE::Location);
                        LocationL.GET(UnitTestingValues."Value 2");

                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD013', COMPANYNAME, DATABASE::Zone);
                        Zone2L.GET(LocationL.Code, UnitTestingValues."Value 2");
                        Zone3L.GET(LocationL.Code, UnitTestingValues."Value 3");

                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD013', COMPANYNAME, DATABASE::Bin);
                        Bin2L.GET(LocationL.Code, UnitTestingValues."Value 2");
                        Bin3L.GET(LocationL.Code, UnitTestingValues."Value 3");

                        ProdOrderComponentL.RESET;
                        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
                        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
                        ProdOrderComponentL.SETRANGE("Item No.", Item1L."No.");
                        if ProdOrderComponentL.FINDFIRST then
                            ProdOrderComponentL.DELETE;

                        ProdOrderComponentL.SETRANGE("Item No.");
                        if ProdOrderComponentL.FIND('-') then begin
                            ProdOrderComp.GOTORECORD(ProdOrderComponentL);
                            ProdOrderComp.NEW;
                            ProdOrderComp."Item No.".SETVALUE(Item2L."No.");
                            //Code Commented for not required -- HEI.07
                            //        ProdOrderComp."Location Code".SETVALUE(LocationL.Code);
                            //        ProdOrderComp."Zone Code".SETVALUE(Zone2L.Code);
                            //        ProdOrderComp."Bin Code".SETVALUE(Bin2L.Code);
                            ProdOrderComp."Quantity per".SETVALUE(QuantityPer);
                        end;
                        //>>HEI.07 --
                        ProdOrderCompL2.RESET;
                        ProdOrderCompL2.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
                        ProdOrderCompL2.SETRANGE("Prod. Order No.", ProductionOrderNo);
                        ProdOrderCompL2.SETRANGE(Status, ProdOrderComponentL.Status::Released);
                        ProdOrderCompL2.SETRANGE("Item No.", Item2L."No.");
                        if ProdOrderCompL2.FINDLAST then begin
                            ProdOrderCompL2."Location Code" := LocationL.Code;
                            ProdOrderCompL2."Zone Code FND" := Zone2L.Code;
                            ProdOrderCompL2."Bin Code" := Bin2L.Code;
                            ProdOrderCompL2.MODIFY;
                            //HEI.31>>//HEI.38>>
                            /*
                              ItemInventory1.InitParameters(ProdOrderCompL2."Item No.",ProdOrderCompL2."Location Code",ProdOrderCompL2."Zone Code",ProdOrderCompL2."Bin Code",100000,'DTWT001','PRE101');
                              ItemInventory1.USEREQUESTPAGE(FALSE);
                              ItemInventory1.RUN;
                               */
                            UpdateItemInvDTW2InitParameters(ProdOrderCompL2."Item No.", ProdOrderCompL2."Location Code", ProdOrderCompL2."Zone Code FND", ProdOrderCompL2."Bin Code", 100000, 'DTWT001', 'PRE101');
                            //HEI.38<<
                            //HEI.31<<
                        end;
                        //<<HEI.07 --

                        ProdOrderComponentL.SETRANGE("Item No.", Item3L."No.");
                        if ProdOrderComponentL.FINDFIRST then begin
                            ProdOrderComp.GOTORECORD(ProdOrderComponentL);
                            //HEI.07 Code commented for not required
                            //        ProdOrderComp."Zone Code".SETVALUE(Zone3L.Code);
                            //        ProdOrderComp."Bin Code".SETVALUE(Bin3L.Code);
                            ProdOrderComp."Quantity per".SETVALUE(QuantityPer);
                            ProdOrderComp.OK.INVOKE;
                        end;
                        //>>HEI.07 --
                        ProdOrderCompL2.RESET;
                        ProdOrderCompL2.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
                        ProdOrderCompL2.SETRANGE("Prod. Order No.", ProductionOrderNo);
                        ProdOrderCompL2.SETRANGE(Status, ProdOrderComponentL.Status::Released);
                        ProdOrderCompL2.SETRANGE("Item No.", Item3L."No.");
                        if ProdOrderCompL2.FINDLAST then begin
                            ProdOrderCompL2."Location Code" := LocationL.Code;
                            ProdOrderCompL2."Zone Code FND" := Zone3L.Code;
                            ProdOrderCompL2."Bin Code" := Bin3L.Code;
                            ProdOrderCompL2.MODIFY;
                            //HEI.31>>
                            //HEI.38>>
                            /*
                              ItemInventory1.InitParameters(ProdOrderCompL2."Item No.",ProdOrderCompL2."Location Code",ProdOrderCompL2."Zone Code",ProdOrderCompL2."Bin Code",100000,'DTWT001','PRE101');
                              ItemInventory1.USEREQUESTPAGE(FALSE);
                              ItemInventory1.RUN;
                               */
                            UpdateItemInvDTW2InitParameters(ProdOrderCompL2."Item No.", ProdOrderCompL2."Location Code", ProdOrderCompL2."Zone Code FND", ProdOrderCompL2."Bin Code", 100000, 'DTWT001', 'PRE101');
                            //HEI.38<<
                            //HEI.31<<
                        end;
                        //<<HEI.07 --
                    end;
                end;
        end;

    end;

    [ModalPageHandler]
    procedure ChangeStatusPageHandler_PRD070(VAR ChangeStatusonProdOrder: TestPage "Change Status on Prod. Order");
    begin
        ChangeStatusonProdOrder.FirmPlannedStatus.SETVALUE(statusfilter::Released);
        ChangeStatusonProdOrder.PostingDate.SETVALUE(TODAY);
        ChangeStatusonProdOrder.ReqUpdUnitCost.SETVALUE(true);
        ChangeStatusonProdOrder.Yes.INVOKE; //Yes Invoking will close the page-Change Status & Firm planned prod order
    end;

    [ModalPageHandler]
    procedure ItemTrackingLinesPageHandler_PRD070(VAR ItemTrackingLines: TestPage "Item Tracking Lines");
    var
        TrackingSpecificationL: Record "Tracking Specification" temporary;
        ItemTrackingSummaryL: TestPage "Item Tracking Summary";
        ItemTrackingSummary: Page "Item Tracking Summary";
    begin
        //To Assign Lot Nos in Prod Order Components Page for Consumption Lines.
        if ItemTrackLineConsumption then begin
            case statusfilter of
                statusfilter::Released:
                    begin
                        TrackingSpecificationL.RESET;
                        TrackingSpecificationL.SETCURRENTKEY("Source Type", "Source Subtype", "Source ID", "Source Prod. Order Line",
                          "Source Ref. No.", "Item No.", "Location Code");
                        if not CorrectQty then begin
                            TrackingSpecificationL.SETRANGE("Source Type", DATABASE::"Prod. Order Component");
                            TrackingSpecificationL.SETRANGE("Source Subtype", TrackingSpecificationL."Source Subtype"::"3");
                            TrackingSpecificationL.SETRANGE("Source ID", ProductionOrderNo);
                            TrackingSpecificationL.SETRANGE("Source Prod. Order Line", ProdOrderLineNo);
                            TrackingSpecificationL.SETRANGE("Source Ref. No.", LineNo);
                            TrackingSpecificationL.SETRANGE("Item No.", ItemNo);
                            TrackingSpecificationL.SETRANGE("Location Code", LocationCode);
                        end else begin
                            TrackingSpecificationL.SETRANGE("Source Type", DATABASE::"Item Journal Line");
                            TrackingSpecificationL.SETRANGE("Source Subtype", TrackingSpecificationL."Source Subtype"::"5");
                            TrackingSpecificationL.SETRANGE("Source ID", ProductionOrderNo);
                            TrackingSpecificationL.SETRANGE("Source Ref. No.", LineNo);
                            TrackingSpecificationL.SETRANGE("Item No.", ItemNo);
                            TrackingSpecificationL.SETRANGE("Location Code", LocationCode);
                        end;
                        if TrackingSpecificationL.ISEMPTY then begin
                            //IF (ItemTrackingLines."Select Entries".VISIBLE) AND NOT(DecQty) THEN BEGIN //HEI.09 code modified
                            if (ItemTrackingLines."Select Entries".VISIBLE) and not (DecQty) and not (ZoneMove) then begin //HEI.09
                                ItemTrackingSummaryL.OPENVIEW;
                                ItemTrackingLines."Select Entries".INVOKE;
                                if CorrectQty then
                                    CorrectionLotNo := ItemTrackingLines."Lot No.".VALUE;
                                ItemTrackingSummaryL.OK.INVOKE;
                                ItemTrackingLines.OK.INVOKE;
                            end;
                        end;
                        //IF DecQty THEN BEGIN //HEI.09 Code commented
                        if (DecQty) and not (ZoneMove) then begin //HEI.09
                            ItemTrackingLines."Lot No.".SETVALUE(CorrectionLotNo);
                            ItemTrackingLines."Appl.-from Item Entry".SETVALUE(CorrEntryNo);
                            //ItemTrackingLines."Appl.-to Item Entry".SETVALUE(CorrEntryNo);
                            // BC Upgrade PATELP08 >>
                            // Set explicit Quantity (Base) LAST so the decrease tracking line has coverage and isn't
                            // discarded on OK (Lot No.+Appl.-from alone leave Quantity (Base) = 0 -> "must assign lot number").
                            ItemTrackingLines."Quantity (Base)".SETVALUE(ConsumptionQtyCorr);
                            // BC Upgrade PATELP08 <<
                            ItemTrackingLines.OK.INVOKE;
                        end;
                        //>>HEI.09
                        if not (DecQty) and (ZoneMove) then begin
                            ItemTrackingLines."Lot No.".SETVALUE(LotNoOutput);
                            ItemTrackingLines.OK.INVOKE;
                        end;
                        //<<HEI.09
                    end;
            end;
        end else begin
            //To Assign Lot Nos in Prod Journal Page for Output line.
            ItemTrackingLines."Create Batch Number".INVOKE;
            LotNoOutput := ItemTrackingLines."Lot No.".VALUE; // For Move FPs to Logistics 151221
            ItemTrackingLines.OK.INVOKE;
        end;
    end;

    // // BC Upgrade PATELP08 >>
    // // The Zone Warehouse Movement line opens page 7328 "Whse. Item Tracking Lines"
    // // (Warehouse Activity Line.OpenItemTrackingLines), not the standard page 6510 handled
    // // by ItemTrackingLinesPageHandler_PRD070. Assign the FP output lot to the warehouse line.
    // [ModalPageHandler]
    // procedure WhseItemTrackingLinesPageHandler_PRD080(VAR WhseItemTrackingLines: TestPage "Whse. Item Tracking Lines");
    // begin
    //     WhseItemTrackingLines."Lot No.".SETVALUE(LotNoOutput);
    //     WhseItemTrackingLines."Qty. to Handle (Base)".SETVALUE(2); // matches Zone Warehouse Movement line Quantity
    //     WhseItemTrackingLines.OK.INVOKE;
    // end;
    // // BC Upgrade PATELP08 <<
    [ModalPageHandler]
    procedure WhseItemTrackingLinesPageHandler_PRD080(var WhseItemTrackingLines: TestPage "Whse. Item Tracking Lines")
    begin
        // Handler for Warehouse Item Tracking Lines (Page 7328)
        // This is triggered when invoking ItemTrackingLines on Zone Warehouse Movement lines
        // if ZoneMove and (LotNoOutput <> '') then begin
        //     WhseItemTrackingLines."Lot No.".SETVALUE(LotNoOutput);
        //     WhseItemTrackingLines.Quantity.SETVALUE(2);
        // end;
        WhseItemTrackingLines.OK.INVOKE;
    end;

    [ModalPageHandler]
    procedure ProductionJournalPageHandler_PRD070(VAR ProdOrdJournal: TestPage "Production Journal");
    var
        ProdOrderJournalL: Record "Item Journal Line";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        ReservationEntry: Record "Reservation Entry";
        LastResvEntryNo: Integer;
        No2: Integer;
    begin
        if not CorrectQty then begin
            //To check the Condition if 'Run Time' and 'Setup Time' both column is not 0 in Production Journal Page For Output Line
            ProdOrderJournalL.RESET;
            ProdOrderJournalL.SETRANGE("Document No.", ProductionOrderNo);
            ProdOrderJournalL.SETRANGE("Order Type", ProdOrderJournalL."Order Type"::Production);
            ProdOrderJournalL.SETRANGE("Entry Type", ProdOrderJournalL."Entry Type"::Output);
            ProdOrderJournalL.FINDFIRST;
            ProdOrdJournal.GOTORECORD(ProdOrderJournalL);
            if (ProdOrdJournal."Setup Time".ASDECIMAL = 0) and (ProdOrdJournal."Run Time".ASDECIMAL = 0) then
                ERROR('Setup Time OR Run Time Value Should not be 0');

            ItemTrackLineConsumption := false; //TO Control assigning the Lot Nos for Consumption & Output lines

            //Assign Lot No. in production journal page for Output Line.
            ProdOrdJournal.ItemTrackingLines.INVOKE;
            //ItemTrackingLines Page is handled by function ItemTrackingLinesPageHandler_PRD010

            //Post the lines from Produciton Journal page
            ProdOrdJournal.Post.INVOKE;
            ProdOrdJournal.OK.INVOKE;
        end
        //********SB******************************
        else begin
            No2 := 0;
            UnitTestingValues.RESET;
            UnitTestingValues.GET('PRD077', COMPANYNAME, DATABASE::Item);
            Item.GET(UnitTestingValues.Value);
            ProdOrderJournalL.RESET;
            ProdOrderJournalL.SETRANGE("Document No.", ProductionOrderNo);
            ProdOrderJournalL.SETRANGE("Entry Type", ProdOrderJournalL."Entry Type"::Consumption);
            ProdOrderJournalL.SETRANGE("Item No.", Item."No.");
            if ProdOrderJournalL.FINDFIRST then begin
                LineNo := ProdOrderJournalL."Line No.";
                ItemNo := ProdOrderJournalL."Item No.";
                LocationCode := ProdOrderJournalL."Location Code";
                BinCode := ProdOrderJournalL."Bin Code";
                // ProdOrderJournalL.Validate("Lot No.",CorrectionLotNo);
                ProdOrderJournalL."Lot No." := CorrectionLotNo;////Kamnay01 BC upgrade  Fix 
                ProdOrderJournalL.modify(false);
                ProdOrdJournal.GOTORECORD(ProdOrderJournalL);
                if not DecQty then
                    //ProdOrdJournal.Quantity.SETVALUE(1) //HEI.07 Commented for code change
                    ProdOrdJournal.Quantity.SETVALUE(6)//HEI.07 -
                else
                    //ProdOrdJournal.Quantity.SETVALUE('-1'); //HEI.07 Commented for code change
                    ProdOrdJournal.Quantity.SETVALUE('-6'); //HEI.07 -
            end;
            // BC Upgrade PATELP08 >>
            // Capture the decrease consumption line qty so the tracking handler can give the line explicit coverage.
            if DecQty then
                ConsumptionQtyCorr := ProdOrdJournal.Quantity.ASDECIMAL;
            // BC Upgrade PATELP08 <<
            ItemTrackLineConsumption := true;
            //Assign Lot No. in production journal page for Output Line.
            if Item."Item Tracking Code" <> '' then         //151221 ////Kamnay01 BC upgrade  Fix 
                ProdOrdJournal.ItemTrackingLines.INVOKE;
            //ItemTrackingLines Page is handled by function ItemTrackingLinesPageHandler_PRD010

            // BC Upgrade PATELP08 >>
            // Assign OUTPUT line lot (Create Batch Number) ONLY when the output line actually has a quantity to produce
            // (the increase case). On a decrease the output line (line 20000) qty is 0, so opening its item tracking would
            // only refresh the journal buffer and WIPE the consumption line's reservation entry -> "must assign lot number"
            // on the consumption line (item 0020581705, line 10000). So skip output tracking when Output Quantity = 0.
            ProdOrderJournalL.RESET;
            ProdOrderJournalL.SETRANGE("Document No.", ProductionOrderNo);
            ProdOrderJournalL.SETRANGE("Order Type", ProdOrderJournalL."Order Type"::Production);
            ProdOrderJournalL.SETRANGE("Entry Type", ProdOrderJournalL."Entry Type"::Output);
            if ProdOrderJournalL.FINDFIRST then
                if Item2.GET(ProdOrderJournalL."Item No.") and (Item2."Item Tracking Code" <> '') then begin
                    ProdOrdJournal.GOTORECORD(ProdOrderJournalL);
                    if ProdOrdJournal."Output Quantity".ASDECIMAL <> 0 then begin
                        ItemTrackLineConsumption := false;
                        ProdOrdJournal.ItemTrackingLines.INVOKE;
                    end;
                end;
            // BC Upgrade PATELP08 <<

            //ItemTrackingLines Page is handled by function ItemTrackingLinesPageHandler_PRD010
            //Post the lines from Produciton Journal page
            ProdOrdJournal.Post.INVOKE;
            ProdOrdJournal.OK.INVOKE;
        end;
    end;


    [ModalPageHandler]
    procedure ChangeStatusPageHandler_PRD083_Packaging(VAR ChangeStatusonProdOrder: TestPage "Change Status on Prod. Order");
    begin
        if changestatusupdate then
            ChangeStatusonProdOrder.FirmPlannedStatus.SETVALUE(statusfilter::Finished)
        else begin
            ChangeStatusonProdOrder.FirmPlannedStatus.SETVALUE(statusfilter::Released);
            changestatusupdate := true;
        end;
        ChangeStatusonProdOrder.PostingDate.SETVALUE(TODAY);
        ChangeStatusonProdOrder.ReqUpdUnitCost.SETVALUE(true);
        ChangeStatusonProdOrder.Yes.INVOKE; //Yes Invoking will close the page-Change Status & Firm planned prod order
    end;

    [ConfirmHandler]
    procedure ConfirmationHandler_PRD081(Question: Text[1024]; var Reply: Boolean);
    var
        DeleteLine: TextConst ENU = 'GO head and delete the Selected Line', FRA = 'Souhaitez-vous valider cette réception ?';
    begin
        //HEI.01>>
        if (Question = DeleteLine) then
            Reply := true;
        //HEI.01<<
    end;

    [ModalPageHandler]
    procedure ProdOrderRoutingPageHandler_PRD081(VAR ProdOrderRouting: TestPage "Prod. Order Routing");
    begin
        //HEI.01>>
        if WorkCentercode <> '' then begin
            ProdOrderRouting.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
            ProdOrderRouting."No.".SETVALUE(WorkCentercode);
        end;
        ProdOrderRouting.OK.INVOKE;
        //HEI.01<<
    end;

    [ModalPageHandler]
    procedure ChangeStatusFPPOtoRPOPageHandler_PRD081(VAR ChangeStatusonProdOrder: TestPage "Change Status on Prod. Order");
    begin
        //HEI.01>>
        if FPPO then begin
            ChangeStatusonProdOrder.FirmPlannedStatus.SETVALUE(statusfilter);
            ChangeStatusonProdOrder.PostingDate.SETVALUE(TODAY);
            ChangeStatusonProdOrder.ReqUpdUnitCost.SETVALUE(true);
            ChangeStatusonProdOrder.Yes.INVOKE;
        end;
        //HEI.01<<
    end;

    [PageHandler]
    procedure ProdOrderComponentsPageHandler_PRD081(VAR ProdOrderComp: TestPage "Prod. Order Components");
    var
        ProdOrderComponentL: Record "Prod. Order Component";
        Item1L: Record Item;
        Item2L: Record Item;
        Item3L: Record Item;
        LocationL: Record Location;
        Zone2L: Record Zone;
        Zone3L: Record Zone;
        Bin2L: Record Bin;
        Bin3L: Record Bin;
        Zone: Record Zone;
        Bin: Record Bin;
        ProdOrderCompL2: Record "Prod. Order Component";
    begin
        //HEI.01>>
        case statusfilter of
            statusfilter::Released:
                begin
                    if FPPO then begin
                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD077', COMPANYNAME, DATABASE::Item);
                        Item1L.GET(UnitTestingValues.Value);
                        Item2L.GET(UnitTestingValues."Value 2");
                        Item3L.GET(UnitTestingValues."Value 3");

                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD077', COMPANYNAME, DATABASE::Location);
                        LocationL.GET(UnitTestingValues.Value);

                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD077', COMPANYNAME, DATABASE::Zone);
                        Zone.GET(LocationL.Code, UnitTestingValues.Value);

                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD077', COMPANYNAME, DATABASE::Bin);
                        Bin.GET(LocationL.Code, UnitTestingValues.Value);

                        //Remove Existing Line
                        //      ProdOrderComponentL.RESET;
                        //      ProdOrderComponentL.SETCURRENTKEY(Status,"Prod. Order No.","Item No.");
                        //      ProdOrderComponentL.SETRANGE("Prod. Order No.",ProductionOrderNo);
                        //      ProdOrderComponentL.SETRANGE(Status,ProdOrderComponentL.Status::Released);
                        //      IF ProdOrderComponentL.FINDSET THEN
                        //        ProdOrderComponentL.DELETEALL;

                        //Add New Line
                        //161221 >>
                        ProdOrderComponentL.RESET;
                        ProdOrderComponentL.SETFILTER("Prod. Order No.", ProductionOrderNo);
                        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
                        if ProdOrderComponentL.FINDFIRST then begin
                            ProdOrderComp.GOTORECORD(ProdOrderComponentL);    //161221
                            ProdOrderComp.NEW;
                            ProdOrderComp."Item No.".SETVALUE(Item1L."No.");
                            //HEI.07 Commented for not required ----
                            //ProdOrderComp."Location Code".SETVALUE(LocationL.Code); //HEI.05
                            //        ProdOrderComponentL."Location Code" := LocationL.Code;//HEI.05
                            //        ProdOrderComponentL."Zone Code" := Zone.Code; //HEI.05
                            //        ProdOrderComponentL."Bin Code" := Bin.Code;//HEI.05
                            //        ProdOrderComponentL.MODIFY; //HEI.05
                            ProdOrderComp."Quantity per".SETVALUE(3);
                            ProdOrderComp.OK.INVOKE;
                        end;
                        //HEI.07>>
                        ProdOrderCompL2.RESET;
                        ProdOrderCompL2.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
                        ProdOrderCompL2.SETRANGE("Prod. Order No.", ProductionOrderNo);
                        ProdOrderCompL2.SETRANGE(Status, ProdOrderComponentL.Status::Released);
                        ProdOrderCompL2.SETRANGE("Item No.", Item1L."No.");
                        if ProdOrderCompL2.FINDLAST then begin
                            ProdOrderCompL2."Location Code" := LocationL.Code;
                            ProdOrderCompL2."Zone Code FND" := Zone.Code;
                            ProdOrderCompL2."Bin Code" := Bin.Code;
                            ProdOrderCompL2.MODIFY;
                            //HEI.31>>
                            //HEI.38>>
                            /*
                              ItemInventory1.InitParameters(ProdOrderCompL2."Item No.",ProdOrderCompL2."Location Code",ProdOrderCompL2."Zone Code",ProdOrderCompL2."Bin Code",100000,'DTWT001','PRE101');
                              ItemInventory1.USEREQUESTPAGE(FALSE);
                              ItemInventory1.RUN;
                               */
                            UpdateItemInvDTW2InitParameters(ProdOrderCompL2."Item No.", ProdOrderCompL2."Location Code", ProdOrderCompL2."Zone Code FND", ProdOrderCompL2."Bin Code", 100000, 'DTWT001', 'PRE101');
                            //HEI.38<<
                            //HEI.31<<
                        end;
                        //HEI.07<<
                        //161221 <<
                        //Remove Existing Line
                        ProdOrderComponentL.RESET;
                        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
                        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
                        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
                        ProdOrderComponentL.SETRANGE("Item No.", Item3L."No.");
                        if ProdOrderComponentL.FINDFIRST then
                            ProdOrderComponentL.DELETE;

                    end else begin
                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD077', COMPANYNAME, DATABASE::Item);
                        Item1L.GET(UnitTestingValues.Value);
                        Item2L.GET(UnitTestingValues."Value 2");

                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD077', COMPANYNAME, DATABASE::Location);
                        LocationL.GET(UnitTestingValues."Value 2");

                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD077', COMPANYNAME, DATABASE::Zone);
                        Zone2L.GET(LocationL.Code, UnitTestingValues."Value 2");

                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD077', COMPANYNAME, DATABASE::Bin);
                        Bin2L.GET(LocationL.Code, UnitTestingValues."Value 2");

                        ProdOrderComponentL.RESET;
                        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
                        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
                        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
                        ProdOrderComponentL.SETRANGE("Item No.", Item1L."No.");
                        if ProdOrderComponentL.FINDFIRST then
                            ProdOrderComponentL.DELETE;

                        ProdOrderComponentL.SETRANGE("Item No.");
                        if not ProdOrderComponentL.FINDFIRST then begin
                            ProdOrderComp.GOTORECORD(ProdOrderComponentL);
                            ProdOrderComp.NEW;
                            ProdOrderComp."Item No.".SETVALUE(Item2L."No.");
                            //HEI.07 Commented for Not required ----
                            //        ProdOrderComp."Location Code".SETVALUE(LocationL.Code);
                            //        ProdOrderComp."Zone Code".SETVALUE(Zone2L.Code);
                            //        ProdOrderComp."Bin Code".SETVALUE(Bin2L.Code);
                            ProdOrderComp."Quantity per".SETVALUE(QuantityPer);
                            ProdOrderComp.OK.INVOKE;
                        end;
                        //HEI.07>>
                        ProdOrderCompL2.RESET;
                        ProdOrderCompL2.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
                        ProdOrderCompL2.SETRANGE("Prod. Order No.", ProductionOrderNo);
                        ProdOrderCompL2.SETRANGE(Status, ProdOrderCompL2.Status::Released);
                        ProdOrderCompL2.SETRANGE("Item No.", Item2L."No.");
                        if ProdOrderCompL2.FINDLAST then begin
                            ProdOrderCompL2."Location Code" := LocationL.Code;
                            ProdOrderCompL2."Zone Code FND" := Zone2L.Code;
                            ProdOrderCompL2."Bin Code" := Bin2L.Code;
                            ProdOrderCompL2.MODIFY;
                            //HEI.31>>
                            //HEI.38>>
                            /*
                              ItemInventory1.InitParameters(ProdOrderCompL2."Item No.",ProdOrderCompL2."Location Code",ProdOrderCompL2."Zone Code",ProdOrderCompL2."Bin Code",100000,'DTWT001','PRE101');
                              ItemInventory1.USEREQUESTPAGE(FALSE);
                              ItemInventory1.RUN;
                               */
                            UpdateItemInvDTW2InitParameters(ProdOrderCompL2."Item No.", ProdOrderCompL2."Location Code", ProdOrderCompL2."Zone Code FND", ProdOrderCompL2."Bin Code", 100000, 'DTWT001', 'PRE101');
                            //HEI.38<<
                            //HEI.31<<
                        end;
                        //HEI.07<<
                    end;
                end;
        end;
        //HEI.01<<

    end;

    [ModalPageHandler]
    procedure ItemTrackingLinesPageHandler_PRD081(VAR ItemTrackingLines: TestPage "Item Tracking Lines");
    var
        TrackingSpecificationL: Record "Tracking Specification" temporary;
        ItemTrackingSummaryL: TestPage "Item Tracking Summary";
    begin
        //HEI.01>>
        case statusfilter of
            statusfilter::Released:
                begin
                    TrackingSpecificationL.RESET;
                    TrackingSpecificationL.SETCURRENTKEY("Source Type", "Source Subtype", "Source ID", "Source Prod. Order Line",
                      "Source Ref. No.", "Item No.", "Location Code");
                    TrackingSpecificationL.SETRANGE("Source Type", DATABASE::"Prod. Order Component");
                    TrackingSpecificationL.SETRANGE("Source Subtype", TrackingSpecificationL."Source Subtype"::"3");
                    TrackingSpecificationL.SETRANGE("Source ID", ProductionOrderNo);
                    TrackingSpecificationL.SETRANGE("Source Prod. Order Line", ProdOrderLineNo);
                    TrackingSpecificationL.SETRANGE("Source Ref. No.", LineNo);
                    TrackingSpecificationL.SETRANGE("Item No.", ItemNo);
                    TrackingSpecificationL.SETRANGE("Location Code", LocationCode);
                    if TrackingSpecificationL.ISEMPTY then begin
                        if ItemTrackingLines."Select Entries".VISIBLE then begin
                            ItemTrackingSummaryL.OPENVIEW;
                            ItemTrackingLines."Select Entries".INVOKE;
                            ItemTrackingSummaryL.OK.INVOKE;
                            ItemTrackingLines.OK.INVOKE;
                        end;
                    end;
                end;
        end;
        //HEI.01<<
    end;

    [RequestPageHandler]
    procedure AutoBatchNoGenerationRequestPage(var AutoBatchNoGeneration_FPOP: TestRequestPage "Auto Batch No. Generation_FPOP");
    begin
        AutoBatchNoGeneration_FPOP.OK.INVOKE;
    end;

    [ConfirmHandler]
    procedure ConfirmationHandler_PRD041(Question: Text[1024]; var Reply: Boolean);
    var
        PostOrderQst: TextConst ENU = 'Do you want to post the Order?', FRA = 'Souhaitez-vous valider cette réception ?';
        ChangeRoutingVersionCode: Label 'This change may have caused bin codes on some production order component lines to be different from those on the production order routing line. Do you want to automatically align all of these unmatched bin codes?';
        ChangeWorkCenter: Label 'This change may have caused bin codes on some production order component lines to be different from those on the production order routing line. Do you want to automatically align all of these unmatched bin codes?';
        ChangeStatusRPOtoFPO: Label 'Production Order %1 has not been finished. Some consumption is still missing. Do you still want to finish the order?';
    begin
        if (Question = ChangeRoutingVersionCode) or
           (Question = ChangeWorkCenter) then
            Reply := true;
    end;

    [ModalPageHandler]
    procedure ProdOrderRoutingPageHandler_FilterCapacity(VAR ProdOrderRouting: TestPage "Prod. Order Routing");
    begin
        if WorkCentercode <> '' then begin
            ProdOrderRouting.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
            //Step 6: Change The Work Center
            ProdOrderRouting."No.".SETVALUE(WorkCentercode); //(confirmation handler)
        end;
        ProdOrderRouting.OK.INVOKE;
    end;

    [PageHandler]
    procedure ProdOrderComponentPageHandler_FilterCapacity(VAR ProdOrderComp: TestPage "Prod. Order Components");
    var
        ProdOrderCompL: Record "Prod. Order Component";
        ItemDel: Record Item;
        ProdOrderCompL2: Record "Prod. Order Component";
    begin

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues."Value 2");
        if ItemDel.GET(UnitTestingValues."Value 3") then;//HEI.39

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues."Value 2");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD042', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues."Value 2");

        // To remove Existing Line and Add New Line in the Prod Ord. Component.
        ProdOrderCompL.RESET;
        ProdOrderCompL.SETFILTER("Prod. Order No.", ProductionOrderNo);
        ProdOrderCompL.SETRANGE(Status, ProdOrderCompL.Status::Released);
        if ProdOrderCompL.FINDFIRST then begin
            ProdOrderComp.GOTORECORD(ProdOrderCompL);
            ProdOrderComp.NEW;                                 //TO Add new Line in Production order Component.
            ProdOrderComp."Item No.".SETVALUE(Item."No.");
            ProdOrderComp."Quantity per".SETVALUE(1);
            //HEI.07 commented not required ----------
            //ProdOrderComp."Location Code".SETVALUE(Location.Code); //HEI.05
            //ProdOrderComp."Zone Code".SETVALUE(Zone.Code); //HEI.05
            //ProdOrderComp."Bin Code".SETVALUE(Bin.Code); //HEI.05
            //  ProdOrderCompL."Location Code" := Location.Code;//HEI.05
            //  ProdOrderCompL."Zone Code" := Zone.Code; //HEI.05
            //  ProdOrderCompL."Bin Code" := Bin.Code; //HEI.05
            //  ProdOrderCompL.MODIFY;//HEI.05
            //ProdOrderComp.OK.INVOKE;//HEI.07
        end;


        ProdOrderCompL.RESET;
        ProdOrderCompL.SETFILTER("Prod. Order No.", ProductionOrderNo);
        ProdOrderCompL.SETRANGE(Status, ProdOrderCompL.Status::Released);
        ProdOrderCompL.SETRANGE("Item No.", ItemDel."No.");
        if ProdOrderCompL.FINDFIRST then
            ProdOrderCompL.DELETE;                           //To delete Existing Line (with item '0020000373')

        ProdOrderComp.OK.INVOKE;//HEI.07 Commented code not required
        //HEI.07>>
        ProdOrderCompL2.RESET;
        ProdOrderCompL2.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderCompL2.SETRANGE("Prod. Order No.", ProductionOrderNo);
        ProdOrderCompL2.SETRANGE(Status, ProdOrderCompL.Status::Released);
        ProdOrderCompL2.SETRANGE("Item No.", Item."No.");
        //IF ProdOrderCompL2.FINDLAST THEN BEGIN //HEI.18

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET due to warning because its being depreceted
        //if ProdOrderCompL2.FINDSET(true, false) then
        if ProdOrderCompL2.FINDSET(true) then
            // BC Upgrade MISHRS14 <<

            repeat
                ProdOrderCompL2."Location Code" := Location.Code;
                ProdOrderCompL2."Zone Code FND" := Zone.Code;
                ProdOrderCompL2."Bin Code" := Bin.Code;
                ProdOrderCompL2.MODIFY;
                //HEI.31>>
                //HEI.38>>
                /*
                ItemInventory1.InitParameters(ProdOrderCompL2."Item No.",ProdOrderCompL2."Location Code",ProdOrderCompL2."Zone Code",ProdOrderCompL2."Bin Code",100000,'DTWT001','PRE101');
                ItemInventory1.USEREQUESTPAGE(FALSE);
                ItemInventory1.RUN;
                 */
                UpdateItemInvDTW2InitParameters(ProdOrderCompL2."Item No.", ProdOrderCompL2."Location Code", ProdOrderCompL2."Zone Code FND", ProdOrderCompL2."Bin Code", 100000, 'DTWT001', 'PRE101');
            //HEI.38<<
            //HEI.31<<
            until ProdOrderCompL2.NEXT = 0;
        //END; //HEI.18
        //HEI.07<<

    end;

    [ModalPageHandler]
    procedure ChangeStatusFPPOtoRPOPageHandler_FilterCapacity(VAR ChangeStatusonProdOrder: TestPage "Change Status on Prod. Order");
    begin
        //HEI.01>>
        if FPPO then begin
            ChangeStatusonProdOrder.FirmPlannedStatus.SETVALUE(statusfilter);
            ChangeStatusonProdOrder.PostingDate.SETVALUE(TODAY);
            ChangeStatusonProdOrder.ReqUpdUnitCost.SETVALUE(true);
            ChangeStatusonProdOrder.Yes.INVOKE;
        end;
        //HEI.01<<
    end;

    [ModalPageHandler]
    procedure ItemTrackingLinesPageHandler_FilterCapacity(VAR ItemTrackingLines: TestPage "Item Tracking Lines");
    var
        TrackingSpecificationL: Record "Tracking Specification" temporary;
        ItemTrackingSummaryL: TestPage "Item Tracking Summary";
    begin
        //To Assign Lot Nos in Prod Order Components Page for Consumption Lines.
        if ItemTrackLineConsumption then begin
            case statusfilter of
                statusfilter::Released:
                    begin
                        TrackingSpecificationL.RESET;
                        TrackingSpecificationL.SETCURRENTKEY("Source Type", "Source Subtype", "Source ID", "Source Prod. Order Line",
                          "Source Ref. No.", "Item No.", "Location Code");
                        if not CorrectQty then begin
                            TrackingSpecificationL.SETRANGE("Source Type", DATABASE::"Prod. Order Component");
                            TrackingSpecificationL.SETRANGE("Source Subtype", TrackingSpecificationL."Source Subtype"::"3");
                            TrackingSpecificationL.SETRANGE("Source ID", ProductionOrderNo);
                            TrackingSpecificationL.SETRANGE("Source Prod. Order Line", ProdOrderLineNo);
                            TrackingSpecificationL.SETRANGE("Source Ref. No.", LineNo);
                            TrackingSpecificationL.SETRANGE("Item No.", ItemNo);
                            TrackingSpecificationL.SETRANGE("Location Code", LocationCode);
                        end else begin
                            TrackingSpecificationL.SETRANGE("Source Type", DATABASE::"Item Journal Line");
                            TrackingSpecificationL.SETRANGE("Source Subtype", TrackingSpecificationL."Source Subtype"::"5");
                            TrackingSpecificationL.SETRANGE("Source ID", ProductionOrderNo);
                            TrackingSpecificationL.SETRANGE("Source Ref. No.", LineNo);
                            TrackingSpecificationL.SETRANGE("Item No.", ItemNo);
                            TrackingSpecificationL.SETRANGE("Location Code", LocationCode);
                        end;
                        if TrackingSpecificationL.ISEMPTY then begin
                            if (ItemTrackingLines."Select Entries".VISIBLE) and not (DecQty) then begin
                                ItemTrackingSummaryL.OPENVIEW;
                                ItemTrackingLines."Select Entries".INVOKE;
                                if CorrectQty then
                                    CorrectionLotNo := ItemTrackingLines."Lot No.".VALUE;
                                ItemTrackingSummaryL.OK.INVOKE;
                                ItemTrackingLines.OK.INVOKE;
                            end;
                        end;
                        if DecQty then begin
                            ItemTrackingLines."Lot No.".SETVALUE(CorrectionLotNo);
                            ItemTrackingLines."Appl.-from Item Entry".SETVALUE(CorrEntryNo);
                            // BC Upgrade PATELP08 >>
                            // Set explicit Quantity (Base) LAST so the decrease tracking line has coverage and isn't
                            // discarded on OK (Lot No.+Appl.-from alone leave Quantity (Base) = 0 -> "must assign lot number").
                            ItemTrackingLines."Quantity (Base)".SETVALUE(ConsumptionQtyCorr);
                            // BC Upgrade PATELP08 <<
                            ItemTrackingLines.OK.INVOKE;
                        end;
                    end;
            end;
        end else begin
            //To Assign Lot Nos in Prod Journal Page for Output line.
            ItemTrackingLines."Create Batch Number".INVOKE;
            ItemTrackingLines.OK.INVOKE;
        end;
    end;

    [ModalPageHandler]
    procedure ProductionJournalPageHandler_PRD047(VAR ProdOrdJournal: TestPage "Production Journal");
    var
        ProdOrderJournalL: Record "Item Journal Line";
        ItemTrackingLines: TestPage "Item Tracking Lines";
    begin
        if not CorrectQty then begin
            //To check the Condition if 'Run Time' and 'Setup Time' both column is not 0 in Production Journal Page For Output Line
            ProdOrderJournalL.RESET;
            ProdOrderJournalL.SETRANGE("Document No.", ProductionOrderNo);
            ProdOrderJournalL.SETRANGE("Order Type", ProdOrderJournalL."Order Type"::Production);
            ProdOrderJournalL.SETRANGE("Entry Type", ProdOrderJournalL."Entry Type"::Output);
            ProdOrderJournalL.FINDFIRST;
            ProdOrdJournal.GOTORECORD(ProdOrderJournalL);

            if (ProdOrdJournal."Setup Time".ASDECIMAL = 0) and (ProdOrdJournal."Run Time".ASDECIMAL = 0) then
                ERROR('Setup Time OR Run Time Value Should not be 0');

            ItemTrackLineConsumption := false; //TO Control assigning the Lot Nos for Consumption & Output lines

            //Assign Lot No. in production journal page for Output Line.
            ProdOrdJournal.ItemTrackingLines.INVOKE;
            //ItemTrackingLines Page is handled by function ItemTrackingLinesPageHandler_PRD010

            //Post the lines from Produciton Journal page
            ProdOrdJournal.Post.INVOKE;
            ProdOrdJournal.OK.INVOKE;
        end
        else begin
            UnitTestingValues.RESET;
            UnitTestingValues.GET('PRD046', COMPANYNAME, DATABASE::Item);
            Item.GET(UnitTestingValues.Value);
            ProdOrderJournalL.RESET;
            ProdOrderJournalL.SETRANGE("Document No.", ProductionOrderNo);
            ProdOrderJournalL.SETRANGE("Entry Type", ProdOrderJournalL."Entry Type"::Consumption);
            ProdOrderJournalL.SETRANGE("Item No.", Item."No.");
            if ProdOrderJournalL.FINDFIRST then begin
                LineNo := ProdOrderJournalL."Line No.";
                ItemNo := ProdOrderJournalL."Item No.";
                LocationCode := ProdOrderJournalL."Location Code";
                BinCode := ProdOrderJournalL."Bin Code";
                ProdOrdJournal.GOTORECORD(ProdOrderJournalL);
                if not DecQty then
                    ProdOrdJournal.Quantity.SETVALUE(1)
                else
                    ProdOrdJournal.Quantity.SETVALUE('-1');

                // BC Upgrade PATELP08 >>
                // Capture the decrease consumption line qty so the tracking handler can give the line explicit coverage.
                if DecQty then
                    ConsumptionQtyCorr := ProdOrdJournal.Quantity.ASDECIMAL;
                // BC Upgrade PATELP08 <<
                ItemTrackLineConsumption := true;
                //Assign Lot No. in production journal page for Output Line.
                ProdOrdJournal.ItemTrackingLines.INVOKE;
                //ItemTrackingLines Page is handled by function ItemTrackingLinesPageHandler_PRD010

                //Post the lines from Produciton Journal page
                ProdOrdJournal.Post.INVOKE;
                ProdOrdJournal.OK.INVOKE;
            end;
        end;
    end;

    [ModalPageHandler]
    procedure ChangeStatustoFPOPageHandler_PRD052(VAR ChangeStatusonProdOrder: TestPage "Change Status on Prod. Order");
    begin
        ChangeStatusonProdOrder.FirmPlannedStatus.SETVALUE(statusfilter::Finished);
        ChangeStatusonProdOrder.PostingDate.SETVALUE(TODAY);
        ChangeStatusonProdOrder.ReqUpdUnitCost.SETVALUE(false);
        ChangeStatusonProdOrder.Yes.INVOKE; //Yes Invoking will close the page-Change Status & Firm planned prod order
    end;

    [ModalPageHandler]
    procedure ProdOrderRoutingPageHandler_FilterationMixing(VAR ProdOrderRouting: TestPage "Prod. Order Routing");
    var
        ProdOrderRoutingL: Record "Prod. Order Routing Line";
    begin
        if WorkCentercode <> '' then begin
            ProdOrderRouting.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
            //Step 6: Change The Work Center
            ProdOrderRouting."No.".SETVALUE(WorkCentercode); //(confirmation handler)
        end;

        //TO check Condition in Prod Routing Page Column "Expected Capacity Need" is not 0
        // ProdOrderRoutingL.SETRANGE("Prod. Order No.",ProductionOrderNo);
        // ProdOrderRoutingL.SETRANGE(Status,ProdOrderRoutingL.Status::Released);
        // ProdOrderRoutingL.FINDSET;
        // ProdOrderRouting.GOTORECORD(ProdOrderRoutingL);
        //Optimization

        //HEI.05 <<
        ProdOrderRoutingL.SETRANGE("Prod. Order No.", ProductionOrderNo);

        ProdOrderRoutingL.FINDSET;
        //HEI.05 >>

        ProdOrderRouting.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
        //IF ProdOrderRouting."Expected Capacity Need".ASDECIMAL = 0  THEN //HEI.05
        if ProdOrderRoutingL."Expected Capacity Need" = 0 then //HEI.05
            ERROR('Expected Capacity Need Value Should not be 0');

        ProdOrderRouting.OK.INVOKE;
    end;

    [PageHandler]
    procedure ProdOrderComponentPageHandler_PRD066(VAR ProdOrderComp: TestPage "Prod. Order Components");
    var
        ProdOrderCompL: Record "Prod. Order Component";
        ItemDel: Record Item;
        BinChange: Record Bin;
        ItemBinChange: Record Item;
        ProdOrderCompL2: Record "Prod. Order Component";
    begin

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues."Value 2");
        ItemDel.GET(UnitTestingValues."Value 3");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues."Value 2");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD055', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues."Value 2");

        // To remove Existing Line and Add New Line in the Prod Ord. Component.
        ProdOrderCompL.RESET;
        ProdOrderCompL.SETFILTER("Prod. Order No.", ProductionOrderNo);
        ProdOrderCompL.SETRANGE(Status, ProdOrderCompL.Status::Released);
        if ProdOrderCompL.FINDFIRST then begin
            ProdOrderComp.GOTORECORD(ProdOrderCompL);
            //Optimization
            //  ProdOrderComp.FILTER.SETFILTER("Prod. Order No.",ProductionOrderNo);
            ProdOrderComp.NEW;                                 //TO Add new Line in Production order Component.
            ProdOrderComp."Item No.".SETVALUE(Item."No.");
            ProdOrderComp."Quantity per".SETVALUE(1);
            //HEI.07 Commented for not Required--------------
            //ProdOrderComp."Location Code".SETVALUE(Location.Code); //HEI.05
            //ProdOrderComp."Zone Code".SETVALUE(Zone.Code); //HEI.05
            //ProdOrderComp."Bin Code".SETVALUE(Bin.Code); //HEI.05
            //    ProdOrderCompL."Location Code" :=  Location.Code; //HEI.05
            //    ProdOrderCompL."Zone Code" := Zone.Code; //HEI.05
            //    ProdOrderCompL."Bin Code" := Bin.Code; //HEI.05
            //    ProdOrderCompL.MODIFY;//HEI.05
            ProdOrderComp.OK.INVOKE; //HEI.07 code changed
        end;
        //HEI.07>>
        ProdOrderCompL2.RESET;
        ProdOrderCompL2.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderCompL2.SETRANGE("Prod. Order No.", ProductionOrderNo);
        ProdOrderCompL2.SETRANGE(Status, ProdOrderCompL2.Status::Released);
        ProdOrderCompL2.SETRANGE("Item No.", Item."No.");
        ProdOrderCompL2.SETRANGE("Location Code", '');
        if ProdOrderCompL2.FINDLAST then begin
            ProdOrderCompL2."Location Code" := Location.Code;
            ProdOrderCompL2."Zone Code FND" := Zone.Code;
            ProdOrderCompL2."Bin Code" := Bin.Code;
            ProdOrderCompL2.MODIFY;
            //HEI.31>>
            //HEI.38>>
            /*
            ItemInventory1.InitParameters(ProdOrderCompL2."Item No.",ProdOrderCompL2."Location Code",ProdOrderCompL2."Zone Code",ProdOrderCompL2."Bin Code",100000,'DTWT001','PRE101');
            ItemInventory1.USEREQUESTPAGE(FALSE);
            ItemInventory1.RUN;
             */
            UpdateItemInvDTW2InitParameters(ProdOrderCompL2."Item No.", ProdOrderCompL2."Location Code", ProdOrderCompL2."Zone Code FND", ProdOrderCompL2."Bin Code", 100000, 'DTWT001', 'PRE101');
            //HEI.38<<
            //HEI.31<<
        end;
        //HEI.07<<

        ProdOrderCompL.RESET;
        ProdOrderCompL.SETFILTER("Prod. Order No.", ProductionOrderNo);
        ProdOrderCompL.SETRANGE(Status, ProdOrderCompL.Status::Released);
        ProdOrderCompL.SETRANGE("Item No.", ItemDel."No.");
        if ProdOrderCompL.FINDFIRST then
            ProdOrderCompL.DELETE;                           //To delete Existing Line (with item '0020000369')

        // Change Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD059', COMPANYNAME, DATABASE::Item);
        ItemBinChange.GET(UnitTestingValues.Value);
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD059', COMPANYNAME, DATABASE::Bin);
        BinChange.GET(Location.Code, UnitTestingValues.Value);
        //HEI.05 <<
        ProdOrderCompL.RESET;
        ProdOrderCompL.SETRANGE("Item No.", ItemBinChange."No.");
        ProdOrderCompL.FINDSET;

        //ProdOrderComp.FILTER.SETFILTER("Item No.",ItemBinChange."No.");
        //ProdOrderComp."Bin Code".SETVALUE(BinChange.Code);
        ProdOrderCompL."Bin Code" := BinChange.Code;
        ProdOrderCompL.MODIFY;
        //HEI.05 >>
        //ProdOrderComp.OK.INVOKE; //HEI.07 Commented code not required

    end;

    [ModalPageHandler]
    [HandlerFunctions('ItemTrackingSummaryPageHandler')]
    procedure ItemTrackingLinesPageHandler_FilterationMixing(VAR ItemTrackingLines: TestPage "Item Tracking Lines");
    var
        TrackingSpecificationL: Record "Tracking Specification" temporary;
        ItemTrackingSummaryL: TestPage "Item Tracking Summary";
    begin
        //HEI.01>>
        if ItemTrackLineConsumption then begin
            case statusfilter of
                statusfilter::Released:
                    begin
                        TrackingSpecificationL.RESET;
                        TrackingSpecificationL.SETCURRENTKEY("Source Type", "Source Subtype", "Source ID", "Source Prod. Order Line",
                          "Source Ref. No.", "Item No.", "Location Code");
                        TrackingSpecificationL.SETRANGE("Source Type", DATABASE::"Prod. Order Component");
                        TrackingSpecificationL.SETRANGE("Source Subtype", TrackingSpecificationL."Source Subtype"::"3");
                        TrackingSpecificationL.SETRANGE("Source ID", ProductionOrderNo);
                        TrackingSpecificationL.SETRANGE("Source Prod. Order Line", ProdOrderLineNo);
                        TrackingSpecificationL.SETRANGE("Source Ref. No.", LineNo);
                        TrackingSpecificationL.SETRANGE("Item No.", ItemNo);
                        TrackingSpecificationL.SETRANGE("Location Code", LocationCode);
                        if TrackingSpecificationL.ISEMPTY then begin
                            if ItemTrackingLines."Select Entries".VISIBLE then begin
                                ItemTrackingSummaryL.OPENVIEW;
                                ItemTrackingLines."Select Entries".INVOKE;
                                ItemTrackingSummaryL.OK.INVOKE;
                                ItemTrackingLines.OK.INVOKE;
                            end;
                        end;
                    end;
            end;
        end else begin
            //To Assign Lot Nos in Prod Journal Page for Output line.
            ItemTrackingLines."Create Batch Number".INVOKE;
            ItemTrackingLines.OK.INVOKE;
        end;
        //HEI.01<<
    end;

    [ModalPageHandler]
    procedure ProductionJournalPageHandler_PRD061(VAR ProdOrdJournal: TestPage "Production Journal");
    var
        ProdOrderJournalL: Record "Item Journal Line";
        ItemTrackingLines: TestPage "Item Tracking Lines";
    begin
        //To check the Condition if 'Run Time' and 'Setup Time' both column is not 0 in Production Journal Page For Output Line
        ProdOrderJournalL.RESET;
        ProdOrderJournalL.SETRANGE("Document No.", ProductionOrderNo);
        ProdOrderJournalL.SETRANGE("Order Type", ProdOrderJournalL."Order Type"::Production);
        ProdOrderJournalL.SETRANGE("Entry Type", ProdOrderJournalL."Entry Type"::Output);
        ProdOrderJournalL.FINDFIRST;
        ProdOrdJournal.GOTORECORD(ProdOrderJournalL);

        if (ProdOrdJournal."Setup Time".ASDECIMAL = 0) and (ProdOrdJournal."Run Time".ASDECIMAL = 0) then
            ERROR('Setup Time OR Run Time Value Should not be 0');

        ItemTrackLineConsumption := false; //TO Control assigning the Lot Nos for Consumption & Output lines

        //Assign Lot No. in production journal page for Output Line.
        ProdOrdJournal.ItemTrackingLines.INVOKE;
        //ItemTrackingLines Page is handled by function ItemTrackingLinesPageHandler_PRD010

        //Post the lines from Produciton Journal page
        ProdOrdJournal.Post.INVOKE;
        ProdOrdJournal.OK.INVOKE;
    end;

    [ModalPageHandler]
    procedure ChangeStatustoFPOPageHandler_PRD069(VAR ChangeStatusonProdOrder: TestPage "Change Status on Prod. Order");
    begin
        ChangeStatusonProdOrder.FirmPlannedStatus.SETVALUE(statusfilter::Finished);
        ChangeStatusonProdOrder.PostingDate.SETVALUE(TODAY);
        ChangeStatusonProdOrder.ReqUpdUnitCost.SETVALUE(false);
        ChangeStatusonProdOrder.Yes.INVOKE; //Yes Invoking will close the page-Change Status & Firm planned prod order
    end;

    [ModalPageHandler]
    procedure ProdOrderRoutingPageHandler_PRD032(VAR ProdOrderRouting: TestPage "Prod. Order Routing");
    var
        ProdOrderRoutingL: Record "Prod. Order Routing Line";
    begin
        if WorkCentercode <> '' then begin
            ProdOrderRouting.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
            //Step 6: Change The Work Center
            ProdOrderRouting."No.".SETVALUE(WorkCentercode); //(confirmation handler)
        end;
        //TO check Condition in Prod Routing Page Column "Expected Capacity Need" is not 0
        // ProdOrderRoutingL.SETRANGE("Prod. Order No.",ProductionOrderNo);
        // ProdOrderRoutingL.SETRANGE(Status,ProdOrderRoutingL.Status::Released);
        // ProdOrderRoutingL.FINDSET;
        // ProdOrderRouting.GOTORECORD(ProdOrderRoutingL);

        //HEI.05 <<
        ProdOrderRoutingL.SETRANGE("Prod. Order No.", ProductionOrderNo);
        ProdOrderRoutingL.FINDSET;
        //HEI.05 >>



        ProdOrderRouting.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
        //IF ProdOrderRouting."Expected Capacity Need".ASDECIMAL = 0  THEN //HEI.05
        if ProdOrderRoutingL."Expected Capacity Need" = 0 then ///HEI.05
            ERROR('Expected Capacity Need Value Should not be 0');//TO check Condition in Prod Routing Page Column "Expected Capacity Need" is not 0

        ProdOrderRouting.OK.INVOKE;
    end;

    [PageHandler]
    procedure ProdOrderComponentPageHandler_PRD037(VAR ProdOrderComp: TestPage "Prod. Order Components");
    var
        ProdOrderCompL: Record "Prod. Order Component";
        ItemDel: Record Item;
        ItemNeg: Record Item;
        ItemL: Record Item;
        ItemUpdate: Record Item;
        ItemUpdate2: Record Item;
        BinChange: Record Bin;
        ProdOrderCompL2: Record "Prod. Order Component";
    begin

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues."Value 2");
        ItemDel.GET(UnitTestingValues."Value 3");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues."Value 2");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD028', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues."Value 2");

        // To remove Existing Line and Add New Line in the Prod Ord. Component.
        ProdOrderCompL.RESET;
        ProdOrderCompL.SETFILTER("Prod. Order No.", ProductionOrderNo);
        ProdOrderCompL.SETRANGE(Status, ProdOrderCompL.Status::Released);
        if ProdOrderCompL.FINDFIRST then begin
            ProdOrderComp.GOTORECORD(ProdOrderCompL);
            ProdOrderComp.NEW;                                 //TO Add new Line in Production order Component.
            ProdOrderComp."Item No.".SETVALUE(Item."No.");
            ProdOrderComp."Quantity per".SETVALUE(2);
            //HEI.07 Code commented for not required -----
            //ProdOrderComp."Location Code".SETVALUE(Location.Code); //HEI.05
            //ProdOrderComp."Zone Code".SETVALUE(Zone.Code); //HEI.05
            //ProdOrderComp."Bin Code".SETVALUE(Bin.Code); //HEI.05
            //  ProdOrderCompL."Location Code" := Location.Code; //HEI.05
            //  ProdOrderCompL."Zone Code" := Zone.Code; //HEI.05
            //  ProdOrderCompL."Bin Code" := Bin.Code; //HEI.05
            //  ProdOrderCompL.MODIFY;//HEI.05
        end;


        //To delete Existing Line (with item '0020000001')
        ProdOrderCompL.RESET;
        ProdOrderCompL.SETFILTER("Prod. Order No.", ProductionOrderNo);
        ProdOrderCompL.SETRANGE(Status, ProdOrderCompL.Status::Released);
        ProdOrderCompL.SETRANGE("Item No.", ItemDel."No.");
        if ProdOrderCompL.FINDFIRST then
            ProdOrderCompL.DELETE;

        // Bin Change for Resource selection of available tanks
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD034', COMPANYNAME, DATABASE::Item);
        ItemL.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD034', COMPANYNAME, DATABASE::Bin);
        BinChange.GET(Location.Code, UnitTestingValues.Value);

        /*//HEI.05 <<
        ProdOrderCompL.RESET;
        ProdOrderCompL.SETRANGE("Item No.",ItemL."No.");
        //ProdOrderComp.FILTER.SETFILTER("Item No.",ItemL."No.");
        //ProdOrderComp."Bin Code".SETVALUE(BinChange.Code);
        IF BinChange.Code <> '' THEN  //HEI.07
        ProdOrderCompL."Bin Code" := BinChange.Code
        ELSE
         ProdOrderCompL."Bin Code" := Bin.Code;
        //HEI.05 >>*/

        // To update the Consumption Quantities
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD027', COMPANYNAME, DATABASE::Item);
        ItemUpdate.GET(UnitTestingValues.Value);
        // ItemUpdate2.GET(UnitTestingValues."Value 2");  // Only for Q
        ProdOrderComp.FILTER.SETFILTER("Item No.", ItemUpdate."No.");
        ProdOrderComp."Quantity per".SETVALUE(1); //HEI.07

        // Only for Q
        // ProdOrderComp.FILTER.SETFILTER("Item No.",ItemUpdate2."No.");
        // ProdOrderComp."Quantity per".SETVALUE(2);

        // Enter Negative Consumption Quantities, Batch(es), Bin(s)

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD035', COMPANYNAME, DATABASE::Item);
        if UnitTestingValues.Value <> '' then begin           //161221
            ItemNeg.GET(UnitTestingValues.Value);
            ProdOrderComp.FILTER.SETFILTER("Item No.", ItemNeg."No.");
            ProdOrderComp."Quantity per".SETVALUE('-1');
        end;  //161221
        ProdOrderComp.OK.INVOKE;
        //HEI.07>>
        ProdOrderCompL2.RESET;
        ProdOrderCompL2.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderCompL2.SETRANGE("Prod. Order No.", ProductionOrderNo);
        ProdOrderCompL2.SETRANGE(Status, ProdOrderCompL2.Status::Released);
        ProdOrderCompL2.SETRANGE("Item No.", Item."No.");
        if ProdOrderCompL2.FINDLAST then begin
            ProdOrderCompL2."Location Code" := Location.Code;
            ProdOrderCompL2."Zone Code FND" := Zone.Code;
            if BinChange.Code <> '' then
                ProdOrderCompL2."Bin Code" := BinChange.Code
            else
                ProdOrderCompL2."Bin Code" := Bin.Code;
            ProdOrderCompL2.MODIFY;
        end;
        //HEI.07<<

    end;

    [ModalPageHandler]
    procedure ItemTrackingLinesPageHandler_Cellar(VAR ItemTrackingLines: TestPage "Item Tracking Lines");
    var
        TrackingSpecificationL: Record "Tracking Specification" temporary;
        ItemTrackingSummaryL: TestPage "Item Tracking Summary";
        ItemNeg: Record Item;
    begin
        //HEI.01>>
        if ItemTrackLineConsumption then begin
            case statusfilter of
                statusfilter::Released:
                    begin
                        TrackingSpecificationL.RESET;
                        TrackingSpecificationL.SETCURRENTKEY("Source Type", "Source Subtype", "Source ID", "Source Prod. Order Line",
                          "Source Ref. No.", "Item No.", "Location Code");

                        if not CorrectQty then begin
                            TrackingSpecificationL.SETRANGE("Source Type", DATABASE::"Prod. Order Component");
                            TrackingSpecificationL.SETRANGE("Source Subtype", TrackingSpecificationL."Source Subtype"::"3");
                            TrackingSpecificationL.SETRANGE("Source ID", ProductionOrderNo);
                            TrackingSpecificationL.SETRANGE("Source Prod. Order Line", ProdOrderLineNo);
                            TrackingSpecificationL.SETRANGE("Source Ref. No.", LineNo);
                            TrackingSpecificationL.SETRANGE("Item No.", ItemNo);
                            TrackingSpecificationL.SETRANGE("Location Code", LocationCode);
                        end else begin
                            TrackingSpecificationL.SETRANGE("Source Type", DATABASE::"Item Journal Line");
                            TrackingSpecificationL.SETRANGE("Source Subtype", TrackingSpecificationL."Source Subtype"::"5");
                            TrackingSpecificationL.SETRANGE("Source ID", ProductionOrderNo);
                            TrackingSpecificationL.SETRANGE("Source Ref. No.", LineNo);
                            TrackingSpecificationL.SETRANGE("Item No.", ItemNo);
                            TrackingSpecificationL.SETRANGE("Location Code", LocationCode);
                        end;
                        if TrackingSpecificationL.ISEMPTY then begin
                            if (ItemTrackingLines."Select Entries".VISIBLE) and not (DecQty) then begin
                                ItemTrackingSummaryL.OPENVIEW;
                                ItemTrackingLines."Select Entries".INVOKE;
                                if CorrectQty then
                                    CorrectionLotNo := ItemTrackingLines."Lot No.".VALUE;
                                ItemTrackingSummaryL.OK.INVOKE;
                                ItemTrackingLines.OK.INVOKE;
                            end;
                        end;
                        if DecQty then begin
                            ItemTrackingLines."Lot No.".SETVALUE(CorrectionLotNo);
                            ItemTrackingLines."Appl.-from Item Entry".SETVALUE(CorrEntryNo);
                            ItemTrackingLines.OK.INVOKE;
                        end;
                    end;
            end;
        end else begin
            //To Assign Lot Nos in Prod Journal Page for Output line.
            if not NegQty then begin
                ItemTrackingLines."Create Batch Number".INVOKE;
                ItemTrackingLines.OK.INVOKE;
            end
            else begin
                UnitTestingValues.RESET;
                UnitTestingValues.GET('PRD035', COMPANYNAME, DATABASE::Item);
                if UnitTestingValues.Value <> '' then begin           //161221
                    ItemNeg.GET(UnitTestingValues.Value);
                    ItemTrackingLines."Lot No.".SETVALUE('A1');
                    ItemTrackingLines.OK.INVOKE;
                end;                //161221
            end;
        end;
        //HEI.01<<
    end;

    [ModalPageHandler]
    procedure ProductionJournalPageHandler_PRD084(VAR ProdOrdJournal: TestPage "Production Journal");
    var
        ProdOrderJournalL: Record "Item Journal Line";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        ItemNeg: Record Item;
    begin
        if not CorrectQty then begin
            UnitTestingValues.RESET;
            UnitTestingValues.GET('PRD035', COMPANYNAME, DATABASE::Item);
            if UnitTestingValues.Value <> '' then begin           //161221
                ItemNeg.GET(UnitTestingValues.Value);

                //Assign Lot No. in production journal for Negative Line
                ProdOrderJournalL.RESET;
                ProdOrderJournalL.SETRANGE("Document No.", ProductionOrderNo);
                ProdOrderJournalL.SETRANGE("Item No.", ItemNeg."No.");
                ProdOrderJournalL.FINDFIRST;
                ProdOrdJournal.GOTORECORD(ProdOrderJournalL);
                ItemTrackLineConsumption := false; //TO Control assigning the Lot Nos for Consumption & Output lines
                NegQty := true;
                ProdOrdJournal.ItemTrackingLines.INVOKE;
            end;  //161221

            //To check the Condition if 'Run Time' and 'Setup Time' both column is not 0 in Production Journal Page For Output Line
            ProdOrderJournalL.RESET;
            ProdOrderJournalL.SETRANGE("Document No.", ProductionOrderNo);
            ProdOrderJournalL.SETRANGE("Order Type", ProdOrderJournalL."Order Type"::Production);
            ProdOrderJournalL.SETRANGE("Entry Type", ProdOrderJournalL."Entry Type"::Output);
            ProdOrderJournalL.FINDFIRST;
            ProdOrdJournal.GOTORECORD(ProdOrderJournalL);

            if (ProdOrdJournal."Setup Time".ASDECIMAL = 0) and (ProdOrdJournal."Run Time".ASDECIMAL = 0) then
                ERROR('Setup Time OR Run Time Value Should not be 0');

            ItemTrackLineConsumption := false; //TO Control assigning the Lot Nos for Consumption & Output lines
            NegQty := false;

            //Assign Lot No. in production journal page for Output Line.
            ProdOrdJournal.ItemTrackingLines.INVOKE;
            //ItemTrackingLines Page is handled by function ItemTrackingLinesPageHandler_PRD010

            //Post the lines from Produciton Journal page
            ProdOrdJournal.Post.INVOKE;
            ProdOrdJournal.OK.INVOKE;
        end
        else begin
            UnitTestingValues.RESET;
            UnitTestingValues.GET('PRD036', COMPANYNAME, DATABASE::Item);
            Item.GET(UnitTestingValues.Value);
            ProdOrderJournalL.RESET;
            ProdOrderJournalL.SETRANGE("Document No.", ProductionOrderNo);
            ProdOrderJournalL.SETRANGE("Entry Type", ProdOrderJournalL."Entry Type"::Consumption);
            ProdOrderJournalL.SETRANGE("Item No.", Item."No.");
            if ProdOrderJournalL.FINDFIRST then begin
                LineNo := ProdOrderJournalL."Line No.";
                ItemNo := ProdOrderJournalL."Item No.";
                LocationCode := ProdOrderJournalL."Location Code";
                BinCode := ProdOrderJournalL."Bin Code";
                ProdOrderJournalL."Lot No." := CorrectionLotNo1;////Kamnay01 BC upgrade  Fix 
                ProdOrderJournalL.modify(false);
                ProdOrdJournal.GOTORECORD(ProdOrderJournalL);
                if not DecQty then
                    ProdOrdJournal.Quantity.SETVALUE(1)
                else
                    ProdOrdJournal.Quantity.SETVALUE('-1');

                ItemTrackLineConsumption := true;
                //Assign Lot No. in production journal page for Output Line.
                ProdOrdJournal.ItemTrackingLines.INVOKE;
                //ItemTrackingLines Page is handled by function ItemTrackingLinesPageHandler_PRD010

                //Post the lines from Produciton Journal page
                ProdOrdJournal.Post.INVOKE;
                ProdOrdJournal.OK.INVOKE;
            end;
        end;
    end;

    [ModalPageHandler]
    procedure ProdOrderRoutingPageHandler_Yeast(VAR ProdOrderRouting: TestPage "Prod. Order Routing");
    begin
        if WorkCentercode <> '' then begin
            ProdOrderRouting.FILTER.SETFILTER("Prod. Order No.", ProductionOrderNo);
            //Step 6: Change The Work Center
            ProdOrderRouting."No.".SETVALUE(WorkCentercode); //(confirmation handler)
        end;
        ProdOrderRouting.OK.INVOKE;
    end;

    [PageHandler]
    procedure ProdOrderComponentPageHandler_Yeast(VAR ProdOrderComp: TestPage "Prod. Order Components");
    var
        ProdOrderCompL: Record "Prod. Order Component";
        ItemDel: Record Item;
        ProdOrderCompL2: Record "Prod. Order Component";
    begin

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues."Value 2");
        //HEI.37>>
        //ItemDel.GET(UnitTestingValues."Value 3");
        if ItemDel.GET(UnitTestingValues."Value 3") then;
        //HEI.37<<

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues."Value 2");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues."Value 2");

        // To remove Existing Line and Add New Line in the Prod Ord. Component.
        ProdOrderCompL.RESET;
        ProdOrderCompL.SETFILTER("Prod. Order No.", ProductionOrderNo);
        ProdOrderCompL.SETRANGE(Status, ProdOrderCompL.Status::Released);
        if ProdOrderCompL.FINDFIRST then begin
            ProdOrderComp.GOTORECORD(ProdOrderCompL);
            ProdOrderComp.NEW;                                 //TO Add new Line in Production order Component.
            ProdOrderComp."Item No.".SETVALUE(Item."No.");
            ProdOrderComp."Quantity per".SETVALUE(2);
            //code Commented for Not Required -- HEI.07
            //  ProdOrderComp."Location Code".SETVALUE(Location.Code);
            //  ProdOrderComp."Zone Code".SETVALUE(Zone.Code);
            //  ProdOrderComp."Bin Code".SETVALUE(Bin.Code);
        end;
        //>>HEI.07 --
        ProdOrderCompL2.RESET;
        ProdOrderCompL2.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
        ProdOrderCompL2.SETRANGE("Prod. Order No.", ProductionOrderNo);
        ProdOrderCompL2.SETRANGE(Status, ProdOrderCompL.Status::Released);
        ProdOrderCompL2.SETRANGE("Item No.", Item."No.");
        if ProdOrderCompL2.FINDLAST then begin
            ProdOrderCompL2."Location Code" := Location.Code;
            ProdOrderCompL2."Zone Code FND" := Zone.Code;
            ProdOrderCompL2."Bin Code" := Bin.Code;
            ProdOrderCompL2.MODIFY;
        end;
        //<<HEI.07 --

        ProdOrderCompL.RESET;
        ProdOrderCompL.SETFILTER("Prod. Order No.", ProductionOrderNo);
        ProdOrderCompL.SETRANGE(Status, ProdOrderCompL.Status::Released);
        ProdOrderCompL.SETRANGE("Item No.", ItemDel."No.");
        if ProdOrderCompL.FINDFIRST then
            ProdOrderCompL.DELETE;                           //To delete Existing Line (with item '0020000373')

        ProdOrderComp.OK.INVOKE;
    end;

    [PageHandler]
    procedure ProdOrderComponentsPageHandler_PRD023(VAR ProdOrderComp: TestPage "Prod. Order Components");
    var
        ProdOrderComponentL: Record "Prod. Order Component";
        Item1L: Record Item;
        Item2L: Record Item;
        Item3L: Record Item;
        LocationL: Record Location;
        Zone2L: Record Zone;
        Zone3L: Record Zone;
        Bin2L: Record Bin;
        Bin3L: Record Bin;
        ProdOrderCompL: Record "Prod. Order Component";
        ItemDel: Record Item;
        ProdOrderCompL2: Record "Prod. Order Component";
    begin
        //HEI.01>>
        case statusfilter of
            statusfilter::Released:
                begin
                    if FPPO then begin
                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD013', COMPANYNAME, DATABASE::Item);
                        Item1L.GET(UnitTestingValues.Value);
                        Item2L.GET(UnitTestingValues."Value 2");
                        Item3L.GET(UnitTestingValues."Value 3");

                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD013', COMPANYNAME, DATABASE::Location);
                        LocationL.GET(UnitTestingValues."Value 2");

                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD013', COMPANYNAME, DATABASE::Zone);
                        Zone2L.GET(LocationL.Code, UnitTestingValues."Value 2");
                        //  Zone3L.GET(LocationL.Code,UnitTestingValues."Value 3");

                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD013', COMPANYNAME, DATABASE::Bin);
                        Bin2L.GET(LocationL.Code, UnitTestingValues."Value 2");
                        //  Bin3L.GET(LocationL.Code,UnitTestingValues."Value 3");
                        ProdOrderComponentL.RESET;
                        ProdOrderComponentL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
                        ProdOrderComponentL.SETRANGE("Prod. Order No.", ProductionOrderNo);
                        ProdOrderComponentL.SETRANGE(Status, ProdOrderComponentL.Status::Released);
                        ProdOrderComponentL.SETRANGE("Item No.", Item1L."No.");
                        if ProdOrderComponentL.FINDFIRST then
                            ProdOrderComponentL.DELETE;

                        ProdOrderComponentL.SETRANGE("Item No.");
                        if ProdOrderComponentL.FIND('-') then begin
                            ProdOrderComp.GOTORECORD(ProdOrderComponentL);
                            ProdOrderComp.NEW;
                            ProdOrderComp."Item No.".SETVALUE(Item2L."No.");
                            //HEI.07 Commented for not required -----
                            //ProdOrderComp."Location Code".SETVALUE(LocationL.Code);
                            //ProdOrderComp."Zone Code".SETVALUE(Zone2L.Code);
                            //ProdOrderComp."Bin Code".SETVALUE(Bin2L.Code);
                            ProdOrderComp."Quantity per".SETVALUE(QuantityPer);
                            ProdOrderComp.OK.INVOKE;//HEI.07
                        end;
                        //>>HEI.07 --
                        ProdOrderCompL2.RESET;
                        ProdOrderCompL2.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
                        ProdOrderCompL2.SETRANGE("Prod. Order No.", ProductionOrderNo);
                        ProdOrderCompL2.SETRANGE(Status, ProdOrderComponentL.Status::Released);
                        ProdOrderCompL2.SETRANGE("Item No.", Item2L."No.");
                        if ProdOrderCompL2.FINDLAST then begin
                            ProdOrderCompL2."Location Code" := LocationL.Code;
                            ProdOrderCompL2."Zone Code FND" := Zone2L.Code;
                            ProdOrderCompL2."Bin Code" := Bin2L.Code;
                            ProdOrderCompL2.MODIFY;
                        end;
                        //<<HEI.07 --

                        ProdOrderComponentL.SETRANGE("Item No.", Item3L."No.");
                        if ProdOrderComponentL.FINDFIRST then begin
                            ProdOrderComp.GOTORECORD(ProdOrderComponentL);
                            //HEI.07 Code commented not required..
                            //ProdOrderComp."Zone Code".SETVALUE(Zone3L.Code);
                            //ProdOrderComp."Bin Code".SETVALUE(Bin3L.Code);
                            ProdOrderComp."Quantity per".SETVALUE(QuantityPer);
                            ProdOrderComp.OK.INVOKE;
                        end;
                        //>>HEI.07 --
                        ProdOrderCompL2.RESET;
                        ProdOrderCompL2.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
                        ProdOrderCompL2.SETRANGE("Prod. Order No.", ProductionOrderNo);
                        ProdOrderCompL2.SETRANGE(Status, ProdOrderComponentL.Status::Released);
                        ProdOrderCompL2.SETRANGE("Item No.", Item3L."No.");
                        if ProdOrderCompL2.FINDLAST then begin
                            ProdOrderCompL2."Location Code" := LocationL.Code;
                            ProdOrderCompL2."Zone Code FND" := Zone3L.Code;
                            ProdOrderCompL2."Bin Code" := Bin3L.Code;
                            ProdOrderCompL2.MODIFY;
                        end;
                        //<<HEI.07 --
                    end else begin
                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Item);
                        Item.GET(UnitTestingValues."Value 2");
                        //HEI.37>>
                        //ItemDel.GET(UnitTestingValues."Value 3");
                        if ItemDel.GET(UnitTestingValues."Value 3") then;
                        //HEI.37<<

                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Location);
                        Location.GET(UnitTestingValues.Value);

                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Zone);
                        Zone.GET(Location.Code, UnitTestingValues."Value 2");

                        UnitTestingValues.RESET;
                        UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Bin);
                        Bin.GET(Location.Code, UnitTestingValues."Value 2");

                        // To remove Existing Line and Add New Line in the Prod Ord. Component.
                        ProdOrderCompL.RESET;
                        ProdOrderCompL.SETFILTER("Prod. Order No.", ProductionOrderNo);
                        ProdOrderCompL.SETRANGE(Status, ProdOrderCompL.Status::Released);
                        if ProdOrderCompL.FINDFIRST then begin
                            ProdOrderComp.GOTORECORD(ProdOrderCompL);
                            ProdOrderComp.NEW;                                 //TO Add new Line in Production order Component.
                            ProdOrderComp."Item No.".SETVALUE(Item."No.");
                            ProdOrderComp."Quantity per".SETVALUE(2);
                            //HEI.07 Code commented for not required----
                            //ProdOrderComp."Location Code".SETVALUE(Location.Code);
                            //ProdOrderComp."Zone Code".SETVALUE(Zone.Code);
                            //ProdOrderComp."Bin Code".SETVALUE(Bin.Code);

                        end;


                        ProdOrderCompL.RESET;
                        ProdOrderCompL.SETFILTER("Prod. Order No.", ProductionOrderNo);
                        ProdOrderCompL.SETRANGE(Status, ProdOrderCompL.Status::Released);
                        ProdOrderCompL.SETRANGE("Item No.", ItemDel."No.");
                        if ProdOrderCompL.FINDFIRST then
                            ProdOrderCompL.DELETE;                           //To delete Existing Line (with item '0020000373')

                        ProdOrderComp.OK.INVOKE;
                        //>>HEI.07 --
                        ProdOrderCompL2.RESET;
                        ProdOrderCompL2.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
                        ProdOrderCompL2.SETRANGE("Prod. Order No.", ProductionOrderNo);
                        ProdOrderCompL2.SETRANGE(Status, ProdOrderComponentL.Status::Released);
                        ProdOrderCompL2.SETRANGE("Item No.", Item."No.");
                        if ProdOrderCompL2.FINDLAST then begin
                            ProdOrderCompL2."Location Code" := Location.Code;
                            ProdOrderCompL2."Zone Code FND" := Zone.Code;
                            ProdOrderCompL2."Bin Code" := Bin.Code;
                            ProdOrderCompL2.MODIFY;
                        end;
                        //<<HEI.07 --

                    end;
                end;
        end;
        //HEI.01<<
    end;

    [ModalPageHandler]
    procedure ItemTrackingLinesPageHandler_Yeast(VAR ItemTrackingLines: TestPage "Item Tracking Lines");
    var
        TrackingSpecificationL: Record "Tracking Specification" temporary;
        ItemTrackingSummaryL: TestPage "Item Tracking Summary";
    begin
        //To Assign Lot Nos in Prod Order Components Page for Consumption Lines.
        if ItemTrackLineConsumption then begin
            case statusfilter of
                statusfilter::Released:
                    begin
                        TrackingSpecificationL.RESET;
                        TrackingSpecificationL.SETCURRENTKEY("Source Type", "Source Subtype", "Source ID", "Source Prod. Order Line",
                          "Source Ref. No.", "Item No.", "Location Code");
                        if not CorrectQty then begin
                            TrackingSpecificationL.SETRANGE("Source Type", DATABASE::"Prod. Order Component");
                            TrackingSpecificationL.SETRANGE("Source Subtype", TrackingSpecificationL."Source Subtype"::"3");
                            TrackingSpecificationL.SETRANGE("Source ID", ProductionOrderNo);
                            TrackingSpecificationL.SETRANGE("Source Prod. Order Line", ProdOrderLineNo);
                            TrackingSpecificationL.SETRANGE("Source Ref. No.", LineNo);
                            TrackingSpecificationL.SETRANGE("Item No.", ItemNo);
                            TrackingSpecificationL.SETRANGE("Location Code", LocationCode);
                        end else begin
                            TrackingSpecificationL.SETRANGE("Source Type", DATABASE::"Item Journal Line");
                            TrackingSpecificationL.SETRANGE("Source Subtype", TrackingSpecificationL."Source Subtype"::"5");
                            TrackingSpecificationL.SETRANGE("Source ID", ProductionOrderNo);
                            TrackingSpecificationL.SETRANGE("Source Ref. No.", LineNo);
                            TrackingSpecificationL.SETRANGE("Item No.", ItemNo);
                            TrackingSpecificationL.SETRANGE("Location Code", LocationCode);
                        end;
                        if TrackingSpecificationL.ISEMPTY then begin
                            if (ItemTrackingLines."Select Entries".VISIBLE) and not (DecQty) then begin
                                ItemTrackingSummaryL.OPENVIEW;
                                ItemTrackingLines."Select Entries".INVOKE;
                                if CorrectQty then
                                    CorrectionLotNo := ItemTrackingLines."Lot No.".VALUE;
                                ItemTrackingSummaryL.OK.INVOKE;
                                ItemTrackingLines.OK.INVOKE;
                            end;
                        end;
                        if DecQty then begin
                            ItemTrackingLines."Lot No.".SETVALUE(CorrectionLotNo);
                            ItemTrackingLines."Appl.-from Item Entry".SETVALUE(CorrEntryNo);
                            // BC Upgrade PATELP08 >>
                            // Set explicit Quantity (Base) LAST so the decrease tracking line has coverage and isn't
                            // discarded on OK (Lot No.+Appl.-from alone leave Quantity (Base) = 0 -> "must assign lot number").
                            ItemTrackingLines."Quantity (Base)".SETVALUE(ConsumptionQtyCorr);
                            // BC Upgrade PATELP08 <<
                            ItemTrackingLines.OK.INVOKE;
                        end;
                    end;
            end;
        end else begin
            //To Assign Lot Nos in Prod Journal Page for Output line.
            ItemTrackingLines."Create Batch Number".INVOKE;
            ItemTrackingLines.OK.INVOKE;
        end;
    end;

    [ModalPageHandler]
    procedure ProductionJournalPageHandler_PRD023(VAR ProdOrdJournal: TestPage "Production Journal");
    var
        ProdOrderJournalL: Record "Item Journal Line";
        ItemTrackingLines: TestPage "Item Tracking Lines";
    begin
        if not CorrectQty then begin
            //To check the Condition if 'Run Time' and 'Setup Time' both column is not 0 in Production Journal Page For Output Line
            ProdOrderJournalL.RESET;
            ProdOrderJournalL.SETRANGE("Document No.", ProductionOrderNo);
            ProdOrderJournalL.SETRANGE("Order Type", ProdOrderJournalL."Order Type"::Production);
            ProdOrderJournalL.SETRANGE("Entry Type", ProdOrderJournalL."Entry Type"::Output);
            ProdOrderJournalL.FINDFIRST;
            ProdOrdJournal.GOTORECORD(ProdOrderJournalL);

            /*IF (ProdOrdJournal."Setup Time".ASDECIMAL = 0) AND (ProdOrdJournal."Run Time".ASDECIMAL = 0)  THEN
             ERROR('Setup Time OR Run Time Value Should not be 0');
            */
            ItemTrackLineConsumption := false; //TO Control assigning the Lot Nos for Consumption & Output lines

            //Assign Lot No. in production journal page for Output Line.
            ProdOrdJournal.ItemTrackingLines.INVOKE;
            //ItemTrackingLines Page is handled by function ItemTrackingLinesPageHandler_PRD010

            //Post the lines from Produciton Journal page
            ProdOrdJournal.Post.INVOKE;
            ProdOrdJournal.OK.INVOKE;
        end
        else begin
            UnitTestingValues.RESET;
            UnitTestingValues.GET('PRD015', COMPANYNAME, DATABASE::Item);
            Item.GET(UnitTestingValues."Value 2");
            ProdOrderJournalL.RESET;
            ProdOrderJournalL.SETRANGE("Document No.", ProductionOrderNo);
            ProdOrderJournalL.SETRANGE("Entry Type", ProdOrderJournalL."Entry Type"::Consumption);
            ProdOrderJournalL.SETRANGE("Item No.", Item."No.");
            if ProdOrderJournalL.FINDFIRST then begin
                LineNo := ProdOrderJournalL."Line No.";
                ItemNo := ProdOrderJournalL."Item No.";
                LocationCode := ProdOrderJournalL."Location Code";
                BinCode := ProdOrderJournalL."Bin Code";
                ProdOrdJournal.GOTORECORD(ProdOrderJournalL);
                if not DecQty then
                    ProdOrdJournal.Quantity.SETVALUE(1)
                else
                    ProdOrdJournal.Quantity.SETVALUE('-1');

                // BC Upgrade PATELP08 >>
                // Capture the decrease consumption line qty so the tracking handler can give the line explicit coverage.
                if DecQty then
                    ConsumptionQtyCorr := ProdOrdJournal.Quantity.ASDECIMAL;
                // BC Upgrade PATELP08 <<
                ItemTrackLineConsumption := true;
                //Assign Lot No. in production journal page for Output Line.
                ProdOrdJournal.ItemTrackingLines.INVOKE;
                //ItemTrackingLines Page is handled by function ItemTrackingLinesPageHandler_PRD010

                // BC Upgrade PATELP08 >>
                // Assign OUTPUT line lot LAST before Post, but ONLY when the output line has a quantity (increase).
                // On a decrease the output line qty is 0; opening its item tracking only refreshes the journal buffer
                // and WIPES the consumption line's reservation entry -> "must assign lot number" on the consumption line.
                ProdOrderJournalL.RESET;
                ProdOrderJournalL.SETRANGE("Document No.", ProductionOrderNo);
                ProdOrderJournalL.SETRANGE("Order Type", ProdOrderJournalL."Order Type"::Production);
                ProdOrderJournalL.SETRANGE("Entry Type", ProdOrderJournalL."Entry Type"::Output);
                if ProdOrderJournalL.FINDFIRST then
                    if Item2.GET(ProdOrderJournalL."Item No.") and (Item2."Item Tracking Code" <> '') then begin
                        ProdOrdJournal.GOTORECORD(ProdOrderJournalL);
                        if ProdOrdJournal."Output Quantity".ASDECIMAL <> 0 then begin
                            ItemTrackLineConsumption := false;
                            ProdOrdJournal.ItemTrackingLines.INVOKE;
                        end;
                    end;
                // BC Upgrade PATELP08 <<

                //Post the lines from Produciton Journal page
                ProdOrdJournal.Post.INVOKE;
                ProdOrdJournal.OK.INVOKE;
            end;
        end;

    end;

    [ModalPageHandler]
    procedure ChangeStatustoFPOPageHandler_PRD026(VAR ChangeStatusonProdOrder: TestPage "Change Status on Prod. Order");
    begin
        ChangeStatusonProdOrder.FirmPlannedStatus.SETVALUE(statusfilter::Finished);
        ChangeStatusonProdOrder.PostingDate.SETVALUE(TODAY);
        ChangeStatusonProdOrder.ReqUpdUnitCost.SETVALUE(false);
        ChangeStatusonProdOrder.Yes.INVOKE; //Yes Invoking will close the page-Change Status & Firm planned prod order
    end;

    [RequestPageHandler]
    procedure AutoBatchGenerationReportHandler(var AutoBatchNoGeneration1: TestRequestPage "Auto Batch No. Generation1");
    begin
        AutoBatchNoGeneration1."Generation Number".SETVALUE(1);
        AutoBatchNoGeneration1.OK.INVOKE;
    end;

    [ModalPageHandler]
    procedure ChangeStatustoFPOPageHandler_PRD038(VAR ChangeStatusonProdOrder: TestPage "Change Status on Prod. Order");
    begin
        ChangeStatusonProdOrder.FirmPlannedStatus.SETVALUE(statusfilter::Finished);
        ChangeStatusonProdOrder.PostingDate.SETVALUE(TODAY);
        ChangeStatusonProdOrder.ReqUpdUnitCost.SETVALUE(false);
        ChangeStatusonProdOrder.Yes.INVOKE; //Yes Invoking will close the page-Change Status & Firm planned prod order
    end;

    [Test]
    [HandlerFunctions('ItemTrackingBookingStockRecoveredBeer,ConfirmationHandler_new,ItemJournalTemplateListPageHandler,MessageHandler')]
    procedure PRD085_BookingStockforRecoveredBeer();
    var
        ItemJournal: TestPage "Item Journal";
        ItemJournalTemplateList: TestPage "Item Journal Template List";
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlLine: Record "Item Journal Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //Remove default setup HEI.10>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.10<<\
        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD085', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD085', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD085', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD085', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //Check Default value for Journal template-ITEM
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD085', COMPANYNAME, DATABASE::"Item Journal Template");
        ItemJnlTemplate.GET(UnitTestingValues.Value);

        //Check Default value for Journal Batch-default
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD085', COMPANYNAME, DATABASE::"Item Journal Batch");
        ItemJnlBatch.GET(ItemJnlTemplate.Name, UnitTestingValues.Value);

        //Remove existing lines in Journal to avoid errors
        ItemJnlLine.RESET;
        ItemJnlLine.SETRANGE("Journal Template Name", ItemJnlTemplate.Name);
        ItemJnlLine.SETRANGE("Journal Batch Name", ItemJnlBatch.Name);
        ItemJnlLine.DELETEALL;

        ItemJournal.OPENEDIT;
        ItemJournal.FILTER.SETFILTER("Journal Template Name", ItemJnlTemplate.Name);
        ItemJournal.CurrentJnlBatchName.SETVALUE(ItemJnlBatch.Name);
        ItemJournal."Entry Type".SETVALUE('Positive Adjmt.');
        ItemJournal."Document No.".SETVALUE('Test1001');
        ItemJournal."Posting Date".SETVALUE(TODAY);
        ItemJournal."Item No.".SETVALUE(Item."No.");
        ItemJournal."Location Code".SETVALUE(Location.Code);
        ItemJournal."Bin Code".SETVALUE(Bin.Code);
        ItemJournal.Quantity.SETVALUE('10');
        ItemJournal.ItemTrackingLines.INVOKE;
        ItemJournal.Post.INVOKE;
        ItemJournal.CLOSE;
    end;

    [Test]
    [HandlerFunctions('ItemTrackingBookingStockRecoveredBeer,ConfirmationHandler_new,ItemJournalTemplateListPageHandler,MessageHandler')]
    procedure PRD086_PassResultQuarantainLotTest();
    var
        ItemJournal: TestPage "Item Journal";
        //QualityProcessingList: TestPage "Quality Processing List"; //BC UPGRADE PATHAA02-DIT-P2031216
        //QuarantineLotTest: TestPage "Quarantine Lot Test"; //BC UPGRADE PATHAA02-P2035101
        LotNoInformationList: TestPage "Lot No. Information List";
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlLine: Record "Item Journal Line";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //Remove default setup HEI.10>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.10<<

        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD085', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD085', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD085', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD085', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //Check Default value for Journal template-ITEM
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD085', COMPANYNAME, DATABASE::"Item Journal Template");
        ItemJnlTemplate.GET(UnitTestingValues.Value);

        //Check Default value for Journal Batch-default
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD085', COMPANYNAME, DATABASE::"Item Journal Batch");
        ItemJnlBatch.GET(ItemJnlTemplate.Name, UnitTestingValues.Value);

        //Remove existing lines in Journal to avoid errors
        ItemJnlLine.RESET;
        ItemJnlLine.SETRANGE("Journal Template Name", ItemJnlTemplate.Name);
        ItemJnlLine.SETRANGE("Journal Batch Name", ItemJnlBatch.Name);
        ItemJnlLine.DELETEALL;

        ItemJournal.OPENEDIT;
        ItemJournal.FILTER.SETFILTER("Journal Template Name", ItemJnlTemplate.Name);
        ItemJournal.CurrentJnlBatchName.SETVALUE(ItemJnlBatch.Name);
        ItemJournal."Entry Type".SETVALUE('Positive Adjmt.');
        ItemJournal."Document No.".SETVALUE('Test1001');
        ItemJournal."Posting Date".SETVALUE(TODAY);
        ItemJournal."Item No.".SETVALUE(Item."No.");
        ItemJournal."Location Code".SETVALUE(Location.Code);
        ItemJournal."Zone Code".SETVALUE(Zone.Code);
        ItemJournal."Bin Code".SETVALUE(Bin.Code);
        ItemJournal.Quantity.SETVALUE('10');
        ItemJournal.ItemTrackingLines.INVOKE;
        ItemJournal.Post.INVOKE;
        ItemJournal.CLOSE;
        //BC UPGRADE PATHAA02>>
        //HEI.45>>
        // if QualitySetup.GET and QualitySetup."Auto Journal Lines" then begin
        //     //HEI.45<<
        //     QuarantineLotTest.OPENEDIT;
        //     QuarantineLotTest.FILTER.SETFILTER(Status, '0|5');
        //     QuarantineLotTest.FILTER.SETFILTER("Item No.", Item."No.");
        //     QuarantineLotTest.FILTER.SETFILTER("Lot No.", LotNoRecoveredBeer);
        //     QuarantineLotTest.QualityLines."Pass/Fail Result".SETVALUE('Pass');
        //     QuarantineLotTest."Codeunit " Quality Test - Evaluate(Yes / No) "".INVOKE;
        //     QuarantineLotTest.CLOSE;
        //     //HEI.45>>
        // end;
        //HEI.45<<
        //BC UPGRADE PATHAA02<<
    end;

    [Test]
    [HandlerFunctions('ItemTrackingBookingStockRecoveredBeer,ConfirmationHandler_new,ItemJournalTemplateListPageHandler,MessageHandler')]
    procedure PRD087_CheckStatusLotNo();
    var
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlLine: Record "Item Journal Line";
        ItemJournal: TestPage "Item Journal";
        //QualityProcessingList: TestPage "Quality Processing List"; //BC UPGRADE PATHAA02-DIT
        //QuarantineLotTest: TestPage "Quarantine Lot Test"; //BC UPGRADE PATHAA02-DIT
        LotNoInformationList: TestPage "Lot No. Information List";
    begin

        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //Remove default setup HEI.10>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.10<<

        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD085', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD085', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD085', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD085', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //Check Default value for Journal template-ITEM
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD085', COMPANYNAME, DATABASE::"Item Journal Template");
        ItemJnlTemplate.GET(UnitTestingValues.Value);

        //Check Default value for Journal Batch-default
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD085', COMPANYNAME, DATABASE::"Item Journal Batch");
        ItemJnlBatch.GET(ItemJnlTemplate.Name, UnitTestingValues.Value);

        //Remove existing lines in Journal to avoid errors
        ItemJnlLine.RESET;
        ItemJnlLine.SETRANGE("Journal Template Name", ItemJnlTemplate.Name);
        ItemJnlLine.SETRANGE("Journal Batch Name", ItemJnlBatch.Name);
        ItemJnlLine.DELETEALL;

        ItemJournal.OPENEDIT;
        ItemJournal.FILTER.SETFILTER("Journal Template Name", ItemJnlTemplate.Name);
        ItemJournal.CurrentJnlBatchName.SETVALUE(ItemJnlBatch.Name);
        ItemJournal."Entry Type".SETVALUE('Positive Adjmt.');
        ItemJournal."Document No.".SETVALUE('Test1001');
        ItemJournal."Posting Date".SETVALUE(TODAY);
        ItemJournal."Item No.".SETVALUE(Item."No.");
        ItemJournal."Location Code".SETVALUE(Location.Code);
        ItemJournal."Zone Code".SETVALUE(Zone.Code);
        ItemJournal."Bin Code".SETVALUE(Bin.Code);
        ItemJournal.Quantity.SETVALUE('10');
        ItemJournal.ItemTrackingLines.INVOKE;
        ItemJournal.Post.INVOKE;
        ItemJournal.CLOSE;
        //BC UPGRADE PATHAA02>>
        // //HEI.45>>
        // if QualitySetup.GET and QualitySetup."Auto Journal Lines" then begin
        //     //HEI.45<<
        //     QuarantineLotTest.OPENEDIT;
        //     QuarantineLotTest.FILTER.SETFILTER(Status, '0|5');
        //     QuarantineLotTest.FILTER.SETFILTER("Item No.", Item."No.");
        //     QuarantineLotTest.FILTER.SETFILTER("Lot No.", LotNoRecoveredBeer);
        //     QuarantineLotTest.QualityLines."Pass/Fail Result".SETVALUE('Pass');
        //     QuarantineLotTest."Codeunit " Quality Test - Evaluate(Yes / No) "".INVOKE;
        //     QuarantineLotTest.CLOSE;
        //     //HEI.45>>
        // end;
        // //HEI.45<<
        //BC UPGRADE PATHAA02<<

        LotNoInformationList.OPENEDIT;
        LotNoInformationList.FILTER.SETFILTER("Item No.", Item."No.");
        LotNoInformationList.FILTER.SETFILTER("Lot No.", LotNoRecoveredBeer);
        //LotNoInformationList."Quality Status".ASSERTEQUALS('Unrestricted'); F2035102 //BC UPGRADE PATHAA02
        LotNoInformationList.CLOSE;
    end;

    [ModalPageHandler]
    procedure ItemTrackingBookingStockRecoveredBeer(VAR ItemTrackingLines: TestPage "Item Tracking Lines");
    begin
        //To Assign Lot Nos
        ItemTrackingLines."Create Batch Number".INVOKE;
        LotNoRecoveredBeer := ItemTrackingLines."Lot No.".VALUE;
        ItemTrackingLines.OK.INVOKE;
    end;

    [ModalPageHandler]
    procedure ItemJournalTemplateListPageHandler(var ItemJournalTemplateList: TestPage "Item Journal Template List");
    var
        ItemJnlTemplate: Record "Item Journal Template";
    begin
        //Check Default value for Journal template-ITEM
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD085', COMPANYNAME, DATABASE::"Item Journal Template");
        ItemJnlTemplate.GET(UnitTestingValues.Value);
        ItemJournalTemplateList.FILTER.SETFILTER(Name, ItemJnlTemplate.Name);
        ItemJournalTemplateList.OK.INVOKE;
    end;

    [Test]
    [HandlerFunctions('ItemTrackingBookingStockRecoveredBeer,ConfirmationHandler_new,ItemJournalTemplateListPageHandler,MessageHandler')]
    procedure PRD088_AbilityGenerateInventoryListManual();
    var
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlLine: Record "Item Journal Line";
        ItemJournal: TestPage "Item Journal";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD088', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD088', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check default value for Zone
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD088', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        //Check default value for Bin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD088', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //Check Default value for Journal template-ITEM
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD088', COMPANYNAME, DATABASE::"Item Journal Template");
        ItemJnlTemplate.GET(UnitTestingValues.Value);

        //Check Default value for Journal Batch-default
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD088', COMPANYNAME, DATABASE::"Item Journal Batch");
        ItemJnlBatch.GET(ItemJnlTemplate.Name, UnitTestingValues.Value);

        //Remove existing lines in Journal to avoid errors
        ItemJnlLine.RESET;
        ItemJnlLine.SETRANGE("Journal Template Name", ItemJnlTemplate.Name);
        ItemJnlLine.SETRANGE("Journal Batch Name", ItemJnlBatch.Name);
        ItemJnlLine.DELETEALL;

        ItemJournal.OPENEDIT;
        ItemJournal.FILTER.SETFILTER("Journal Template Name", ItemJnlTemplate.Name);
        ItemJournal.CurrentJnlBatchName.SETVALUE(ItemJnlBatch.Name);
        ItemJournal."Entry Type".SETVALUE('Positive Adjmt.');
        ItemJournal."Document No.".SETVALUE('Test1001');
        ItemJournal."Posting Date".SETVALUE(TODAY);
        ItemJournal."Item No.".SETVALUE(Item."No.");
        ItemJournal."Location Code".SETVALUE(Location.Code);
        ItemJournal."Zone Code".SETVALUE(Zone.Code);
        ItemJournal."Bin Code".SETVALUE(Bin.Code);
        ItemJournal.Quantity.SETVALUE('10');
        ItemJournal.ItemTrackingLines.INVOKE;
        ItemJournal.Post.INVOKE;
        ItemJournal.CLOSE;
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler_new,MessageHandler,CalculateInventoryRequestPageHandler,ItemTrackingLines_PRD089')]
    procedure PRD089_AbilityGenerateInventoryListStockCounting();
    var
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlLine: Record "Item Journal Line";
        ReasonCode: Record "Reason Code";
        ItemJournal: TestPage "Item Journal";
        PhysInventoryJournal: TestPage "Phys. Inventory Journal";
        i: Integer;
        PhyInvQty: Decimal;
        CalculateInventory: Report "Calculate Inventory";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD089', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD089', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check Default value for Journal template-ITEM
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD089', COMPANYNAME, DATABASE::"Item Journal Template");
        ItemJnlTemplate.GET(UnitTestingValues.Value);

        //Check Default value for Journal Batch-default
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD089', COMPANYNAME, DATABASE::"Item Journal Batch");
        ItemJnlBatch.GET(ItemJnlTemplate.Name, UnitTestingValues.Value);

        //Check Default value for Reason Code
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD089', COMPANYNAME, DATABASE::"Reason Code");
        ReasonCode.GET(UnitTestingValues.Value);

        //Check Default value for Lot No.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD089', COMPANYNAME, DATABASE::"Lot No. Information");
        LotNoPhysInv := UnitTestingValues.Value;

        //Remove existing lines in Journal to avoid errors
        ItemJnlLine.RESET;
        ItemJnlLine.SETRANGE("Journal Template Name", ItemJnlTemplate.Name);
        ItemJnlLine.SETRANGE("Journal Batch Name", ItemJnlBatch.Name);
        ItemJnlLine.DELETEALL;

        PhysInventoryJournal.OPENEDIT;
        PhysInventoryJournal.FILTER.SETFILTER("Journal Template Name", ItemJnlTemplate.Name);
        PhysInventoryJournal.CurrentJnlBatchName.SETVALUE(ItemJnlBatch.Name);
        PhysInventoryJournal."Posting Date".SETVALUE(TODAY);
        PhysInventoryJournal."Entry Type".SETVALUE('Positive Adjmt.');
        Item.SETRANGE("No.", Item."No.");
        Item.SETFILTER("Location Filter", Location.Code);
        Item.FINDFIRST;
        ItemJnlLine.SETRANGE("Journal Template Name", ItemJnlTemplate.Name);
        ItemJnlLine.SETRANGE("Journal Batch Name", ItemJnlBatch.Name);
        ItemJnlLine.FINDFIRST;
        COMMIT;
        CalculateInventory.SetItemJnlLine(ItemJnlLine);
        CalculateInventory.SETTABLEVIEW(Item);
        CalculateInventory.USEREQUESTPAGE(true);
        CalculateInventory.RUNMODAL;

        // PhysInventoryJournal.CalculateInventory.INVOKE;

        ItemJnlLine.RESET;
        ItemJnlLine.SETRANGE("Journal Template Name", ItemJnlTemplate.Name);
        ItemJnlLine.SETRANGE("Journal Batch Name", ItemJnlBatch.Name);
        ItemJnlLine.SETFILTER("Qty. (Calc.) in Inv. UoM FND", '<>%1', 0);
        ItemJnlLine.SETFILTER("Quantity in Inv. UoM FND", '=%1', 0);
        if ItemJnlLine.FINDFIRST then begin
            PhysInventoryJournal.FILTER.SETFILTER("Journal Template Name", ItemJnlTemplate.Name);
            PhysInventoryJournal.FILTER.SETFILTER("Journal Batch Name", ItemJnlBatch.Name);
            PhysInventoryJournal.FILTER.SETFILTER("Item No.", ItemJnlLine."Item No.");
            PhysInventoryJournal.FILTER.SETFILTER("Line No.", FORMAT(ItemJnlLine."Line No."));
            PhyInvQty := 0;
            PhyInvQty := ItemJnlLine."Qty. Phys. Inv. in Inv.UoM FND" + 1;
            PhysInventoryJournal."Qty. (Phys. Inv.) in Inv. UoM".SETVALUE(PhyInvQty);
            PhysInventoryJournal."Reason Code".SETVALUE(ReasonCode.Code);
            PositiveAdj := true;
            PhysInventoryJournal."Item &Tracking Lines".Invoke();

        end;

        ItemJnlLine.RESET;
        ItemJnlLine.SETRANGE("Journal Template Name", ItemJnlTemplate.Name);
        ItemJnlLine.SETRANGE("Journal Batch Name", ItemJnlBatch.Name);
        ItemJnlLine.SETFILTER("Qty. (Calc.) in Inv. UoM FND", '<>%1', 0);
        ItemJnlLine.SETFILTER("Quantity in Inv. UoM FND", '=%1', 0);
        if ItemJnlLine.FINDFIRST then begin
            PhysInventoryJournal.FILTER.SETFILTER("Journal Template Name", ItemJnlTemplate.Name);
            PhysInventoryJournal.FILTER.SETFILTER("Journal Batch Name", ItemJnlBatch.Name);
            PhysInventoryJournal.FILTER.SETFILTER("Item No.", ItemJnlLine."Item No.");
            PhysInventoryJournal.FILTER.SETFILTER("Line No.", FORMAT(ItemJnlLine."Line No."));
            PhyInvQty := 0;
            PhyInvQty := ItemJnlLine."Qty. Phys. Inv. in Inv.UoM FND" - 1;
            PhysInventoryJournal."Qty. (Phys. Inv.) in Inv. UoM".SETVALUE(PhyInvQty);
            PhysInventoryJournal."Reason Code".SETVALUE(ReasonCode.Code);
            PositiveAdj := false;
            //   LocationCode := PhysInventoryJournal."Location Code".VALUE;
            //   BinCode := PhysInventoryJournal."Bin Code".VALUE;
            PhysInventoryJournal."Auto Negative Adjmt. Lot Assign".INVOKE;
            //   PhysInventoryJournal."Item &Tracking Lines".Invoke();
        end;

        PhysInventoryJournal.CLOSE;
        PhysInventoryJournal.OPENEDIT;
        PhysInventoryJournal.FILTER.SETFILTER("Journal Template Name", ItemJnlTemplate.Name);
        PhysInventoryJournal.CurrentJnlBatchName.SETVALUE(ItemJnlBatch.Name);
        PhysInventoryJournal.FILTER.SETFILTER("Item No.", Item."No.");
        PhysInventoryJournal.FILTER.SETFILTER("Quantity in Inv. UoM FND", '1');
        //PhysInventoryJournal.Action34.INVOKE;//BC UPGRADE PATHAA02
        PhysInventoryJournal."P&ost".Invoke(); //BC UPGRADE PATHAA02
        PhysInventoryJournal.CLOSE;

        CLEAR(PositiveAdj);
        CLEAR(PhyInvQty);
        CLEAR(LotNoPhysInv);
        CLEAR(LocationCode);
        CLEAR(BinCode);
    end;

    [RequestPageHandler]
    procedure CalculateInventoryRequestPageHandler(var CalculateInventory: TestRequestPage "Calculate Inventory");
    begin
        CalculateInventory.DocumentNo.SETVALUE('PHYINV001');
        CalculateInventory.ItemsNotOnInventory.SETVALUE(true);
        // CalculateInventory.Control1040000.SETVALUE(true);//BC UPGRADE PATHAA02
        // CalculateInventory.Control1040002.SETVALUE(true); //BC UPGRADE PATHAA02
        //CalculateInventory.
        //CalculateInventory.OK.INVOKE;
    end;

    [ModalPageHandler]
    procedure ItemTrackingLines_PRD089(VAR ItemTrackingLines: TestPage "Item Tracking Lines");
    var
        ItemTrackingSummaryL: TestPage "Item Tracking Summary";
    begin
        //To Assign Lot Nos
        if PositiveAdj then
            ItemTrackingLines."Lot No.".SETVALUE(LotNoPhysInv);
        // ELSE BEGIN
        //  ItemTrackingSummaryL.OPENVIEW;
        //  ItemTrackingLines."Select Entries".INVOKE;
        //  ItemTrackingSummaryL.OK.INVOKE;
        // END;
        ItemTrackingLines.OK.INVOKE;
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ItemTrackingLinesModalPageHandlerLine_DTW002,ConfirmationHandler_new,ItemTrackingSummaryPageHandler')]
    procedure DTW002_ProcessAssemblyOrder();
    var
        AssemblyOrderList: TestPage "Assembly Orders";
        AssemblyOrder: TestPage "Assembly Order";
        ItemH: Record Item;
        LocationH: Record Location;
        ZoneH: Record Zone;
        BinH: Record Bin;
        ItemL: Record Item;
        LocationL: Record Location;
        ZoneL: Record Zone;
        BinL: Record Bin;
        Type: Option " ",Item,Resource,"Charge (Item)";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.02
        //Picking values from setup. H represents Header value, L represents Line value
        UnitTestingValues.RESET;
        UnitTestingValues.GET('DTW002', COMPANYNAME, DATABASE::Item);
        ItemH.GET(UnitTestingValues.Value);
        ItemL.GET(UnitTestingValues."Value 2");
        ItemHCode := ItemH."No.";
        ItemLCode := ItemL."No.";

        UnitTestingValues.RESET;
        UnitTestingValues.GET('DTW002', COMPANYNAME, DATABASE::Location);
        LocationH.GET(UnitTestingValues.Value);
        LocationL.GET(UnitTestingValues."Value 2");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('DTW002', COMPANYNAME, DATABASE::Zone);
        ZoneH.GET(LocationH.Code, UnitTestingValues.Value);
        ZoneL.GET(LocationL.Code, UnitTestingValues."Value 2");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('DTW002', COMPANYNAME, DATABASE::Bin);
        BinH.GET(LocationH.Code, UnitTestingValues.Value);
        BinL.GET(LocationL.Code, UnitTestingValues."Value 2");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('DTW002', COMPANYNAME, DATABASE::"Lot No. Information");
        LotH_DTW002 := UnitTestingValues.Value;
        LotL_DTW002 := UnitTestingValues."Value 2";

        //Check default value for Cost Center (ccc) Dimension Value Code
        UnitTestingValues.RESET;
        UnitTestingValues.GET('DTW002', COMPANYNAME, DATABASE::"Dimension Value");
        GeneralLedgerSetup.GET;
        DimensionValue.GET(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);

        //Step 1: Logon to Heilite

        //Step 2: Create a Assembly Order
        //AssemblyOrderList.OPENNEW;
        AssemblyOrderList.OPENEDIT;
        AssemblyOrder.OPENNEW;
        AssemblyOrder.NEW;
        AssemblyOrder."No.".ASSISTEDIT;
        AssemblyOrder."Item No.".SETVALUE(ItemH."No.");
        AssemblyOrder.Quantity.SETVALUE(1);
        AssemblyOrder."Location Code".SETVALUE(LocationH.Code);
        AssemblyOrder."Zone Code".SETVALUE(ZoneH.Code);
        AssemblyOrder."Bin Code".SETVALUE(BinH.Code);
        AssemblyOrder."Shortcut Dimension 2 Code".SETVALUE(DimensionValue.Code);

        //Open Assembly Lines and enter Information
        AssemblyOrder.Lines.NEW;
        AssemblyOrder.Lines.Type.SETVALUE(Type::Item);
        AssemblyOrder.Lines."No.".SETVALUE(ItemL."No.");
        AssemblyOrder.Lines."Quantity per".SETVALUE(1);
        // AssemblyOrder.Lines.Quantity.SETVALUE(1);
        // AssemblyOrder.Lines."Quantity to Consume".SETVALUE(1);
        AssemblyOrder.Lines."Location Code".SETVALUE(LocationL.Code);
        AssemblyOrder.Lines."Zone Code".SETVALUE(ZoneL.Code);
        AssemblyOrder.Lines."Bin Code".SETVALUE(BinL.Code);
        LocationCode := LocationL.Code;
        BinCode := BinL.Code;
        AssemblyOrder.Lines."Item Tracking Lines".INVOKE; //Enter Lot No. on Line-->Item tracking Lines
        AssemblyOrder."Item Tracking Lines".INVOKE;////Enter Lot No. on Header-->Navigate-->Item tracking Lines
        AssemblyOrderList.OK.INVOKE;  //close list page
        //AssemblyOrder.Action36.INVOKE; //POST the Assembly Order //BC UPGRADE PATHAA02
        AssemblyOrder.Post.Invoke(); //BC UPGRADE PATHAA02
        // AssemblyOrder.OK.INVOKE; //close card page
        CLEAR(LocationCode);
        CLEAR(BinCode);
    end;

    [ModalPageHandler]
    procedure ItemTrackingLinesModalPageHandlerLine_DTW002(VAR ItemTrackingLines: TestPage "Item Tracking Lines");
    var
        TrackingSpecification: Record "Tracking Specification" temporary;
        ItemTrackingSummaryL: TestPage "Item Tracking Summary";
        ItemTrackingSummary: Page "Item Tracking Summary";
    begin
        //HEI.02
        //this page handler is designed to assign lot no on item tracking lines for line first and header later through a booolean
        if trackinglineupdate then
            ItemTrackingLines."Lot No.".SETVALUE(LotH_DTW002)
        else begin
            //  ItemTrackingLines."Lot No.".SETVALUE(LotL_DTW002);
            trackinglineupdate := true;
            ItemTrackingSummaryL.OPENVIEW;
            ItemTrackingLines."Select Entries".INVOKE;
            ItemTrackingSummaryL.OK.INVOKE;
        end;
        ItemTrackingLines.OK.INVOKE;
    end;

    [Test]
    [HandlerFunctions('ItemTrackingLinesModalPageHandler_DTW004,ConfirmationHandler_DTW003,ItemTrackingSummaryPageHandler,MessageHandler')]
    procedure DTW003_GoodsposttoCCC();
    var
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlBatch: Record "Item Journal Batch";
        Item: Record Item;
        Location: Record Location;
        BinL: Record Bin;
        DimensionValue: Record "Dimension Value";
        GeneralLedgerSetup: Record "General Ledger Setup";
        ItemJnlLine: Record "Item Journal Line";
        ItemJnlTemplates: TestPage "Item Journal Templates";
        ItemJnlBatches: TestPage "Item Journal Batches";
        ItemJnlPage: TestPage "Item Journal";
        UserSetup: Record "User Setup";
        salessetup: Record "Sales & Receivables Setup";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.21>>
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.21<<
        //HEI.10>>
        //Update E-mail address for all User Setup
        UserSetup.SETFILTER("E-Mail", '<>%1', '');
        if UserSetup.FINDSET then
            UserSetup.MODIFYALL("E-Mail", 'unittesting@heineken.com');
        //HEI.10<<
        //HEI.21>>
        salessetup.RESET;
        salessetup."Stockout Warning" := false;
        salessetup.MODIFY;
        //HEI.21<<
        //Check Default value for Journal template-ITEM
        UnitTestingValues.RESET;
        UnitTestingValues.GET('DTW003', COMPANYNAME, DATABASE::"Item Journal Template");
        ItemJnlTemplate.GET(UnitTestingValues.Value);

        //Check Default value for Journal Batch-default
        UnitTestingValues.RESET;
        UnitTestingValues.GET('DTW003', COMPANYNAME, DATABASE::"Item Journal Batch");
        ItemJnlBatch.GET(ItemJnlTemplate.Name, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('DTW003', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('DTW003', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('DTW003', COMPANYNAME, DATABASE::Zone);
        Zone.GET(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('DTW003', COMPANYNAME, DATABASE::Bin);
        BinL.GET(Location.Code, UnitTestingValues.Value); //HEI.22

        //Check default value for Cost Center (ccc) Dimension Value Code
        UnitTestingValues.RESET;
        UnitTestingValues.GET('DTW003', COMPANYNAME, DATABASE::"Dimension Value");
        GeneralLedgerSetup.GET;
        if DimensionValue.GET(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value) then; //HEI.21

        //HEI.22>>
        //HEI.38>>
        /*
        ItemInventory.InitParameters(Item."No.",Location.Code,Zone.Code,BinL.Code,100000,'DTWTEST001','PRE101');
        ItemInventory.USEREQUESTPAGE(FALSE);
        ItemInventory.RUN;
        */
        UpdateItemInvDTW2InitParameters(Item."No.", Location.Code, Zone.Code, BinL.Code, 100000, 'DTWTEST001', 'PRE101');
        //HEI.38<<
        //HEI.22<<
        //<<HEI.08
        // UnitTestingValues.RESET;
        // UnitTestingValues.GET('DTW003',COMPANYNAME,DATABASE::"Lot No. Information");
        // Lot_DTW003 := UnitTestingValues.Value;

        //Step 1: Login

        //Access item Journal Page
        ItemJnlTemplates.OPENVIEW;
        ItemJnlBatches.TRAP;
        ItemJnlTemplates.FINDFIRSTFIELD(Name, ItemJnlTemplate.Name);
        //ItemJnlTemplates."Page " Item Journal Batches "".INVOKE;//BC UPGRADE PATHAA02
        ItemJnlTemplates.Batches.Invoke(); //BC UPGRADE PATHAA02

        ItemJnlPage.TRAP;
        ItemJnlBatches.FINDFIRSTFIELD(Name, ItemJnlBatch.Name);
        //ItemJnlBatches.Action19.INVOKE; //calling page action Edit Journal //BC UPGRADE PATHAA02
        ItemJnlBatches."Edit Journal".Invoke();//BC UPGRADE PATHAA02

        //Remove existing lines in Journal to avoid errors
        ItemJnlLine.SETRANGE("Journal Template Name", ItemJnlTemplate.Name);
        ItemJnlLine.SETRANGE("Journal Batch Name", ItemJnlBatch.Name);
        ItemJnlLine.DELETEALL;

        //Create journal Line

        ItemJnlPage.NEW;
        ItemJnlPage."Posting Date".SETVALUE(WORKDATE);
        ItemJnlPage."Entry Type".SETVALUE(3); //negative adjustment
        ItemJnlPage."Item No.".SETVALUE(Item."No.");
        ItemJnlPage."Location Code".SETVALUE(Location.Code);
        ItemJnlPage."Zone Code".SETVALUE(Zone.Code);
        ItemJnlPage."Bin Code".SETVALUE(BinL.Code);//HEI.22
        LocationCode := Location.Code;
        BinCode := BinL.Code; //HEI.22
        ItemJnlPage.Quantity.SETVALUE(1);
        //HEI.07 Code commented not requried----
        //ItemJnlLine."Shortcut Dimension 2 Code" := DimensionValue.Code; //HEI.05
        //ItemJnlLine.MODIFY; //HEI.05
        //>>HEI.07--
        ItemJnlLine.RESET;
        ItemJnlLine.SETRANGE("Journal Template Name", ItemJnlTemplate.Name);
        ItemJnlLine.SETRANGE("Journal Batch Name", ItemJnlBatch.Name);
        ItemJnlLine.MODIFYALL("Shortcut Dimension 2 Code", DimensionValue.Code, true); //HEI.22
                                                                                       //<<HEI.07--

        //ItemJnlPage."Shortcut Dimension 2 Code".SETVALUE(DimensionValue.Code); //HEI.05
        //ItemJnlPage.LotNo.SETVALUE(Lot_DTW003);
        ItemJnlPage.ItemTrackingLines.INVOKE;
        //POST
        ItemJnlPage.Post.INVOKE;

        //Close the Page
        //ItemJnlPage.OK.INVOKE;
        CLEAR(LocationCode);
        CLEAR(BinCode);

    end;

    [ModalPageHandler]
    procedure ItemTrackingLinesModalPageHandler_DTW003(VAR ItemTrackingLines: TestPage "Item Tracking Lines");
    var
        ItemTrackingSummaryL: TestPage "Item Tracking Summary";
        ItemTrackingSummary: Page "Item Tracking Summary";
    begin
        // ItemTrackingLines."Lot No.".SETVALUE(Lot_DTW003);
        // ERROR(ItemTrackingLines."Lot No.".VALUE);
        // ItemTrackingLines."Quantity (Base)".SETVALUE(1);
        // ItemTrackingLines.OK.INVOKE;
        ItemTrackingSummaryL.OPENVIEW;
        ItemTrackingLines."Select Entries".INVOKE;
        ItemTrackingSummaryL.OK.INVOKE;
    end;

    [ConfirmHandler]
    procedure ConfirmationHandler_DTW003(Question: Text[1024]; var Reply: Boolean);
    var
        PostJnlQst: TextConst ENU = 'Do you want to post the Journal Lines?', FRA = 'Souhaitez-vous valider cette réception ?';
    begin
        //To post the Item Journal Lines-Cost goods to cc
        if (Question = PostJnlQst) then
            Reply := true;
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ItemTrackingLinesModalPageHandler_DTW004,ConfirmationHandler_new,WhseShipPageHandler_DTW004,WhseRcptPageHandler_DTW004,StrMenuHandler_DTW004,MessageHandler,ItemTrackingSummaryPageHandler')]
    procedure DTW004_StockTransferOrder();
    var
        Item: Record Item;
        Zone: Record Zone;
        Bin: Record Bin;
        LocationFrom: Record Location;
        LocationTo: Record Location;
        //TransferOrderList: TestPage "Transfer List"; //BC UPGRADE PATHAA02-blocked Temp.
        TransferOrder: TestPage "Transfer Order";
        WarehouseShipment: TestPage "Warehouse Shipment";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        ShippingAgent: Record "Shipping Agent";
        // WhseShippingDriver: Record "Whse. Shipping Driver"; //T2014063//BC UPGRADE-DIT
        //WhseShippingTruck: Record "Whse. Shipping Truck";//T2014068 //BC UPGRADE-DIT
        Zone2: Record Zone;
        Bin2: Record Bin;
        LocationInTransit: Record Location;
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('DTW004', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('DTW004', COMPANYNAME, DATABASE::Location);
        LocationFrom.GET(UnitTestingValues.Value);
        LocationTo.GET(UnitTestingValues."Value 2");
        LocationInTransit.GET(UnitTestingValues."Value 3");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('DTW004', COMPANYNAME, DATABASE::Zone);
        Zone.GET(LocationFrom.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('DTW004', COMPANYNAME, DATABASE::Bin);
        Bin.GET(LocationFrom.Code, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('DTW004', COMPANYNAME, DATABASE::Zone);
        Zone2.GET(LocationTo.Code, UnitTestingValues."Value 2");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('DTW004', COMPANYNAME, DATABASE::Bin);
        Bin2.GET(LocationTo.Code, UnitTestingValues."Value 2");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('DTW004', COMPANYNAME, DATABASE::"Shipping Agent");
        ShippingAgent.GET(UnitTestingValues.Value);

        //BC UPGRADE PATHAA02-DIT>>
        // UnitTestingValues.RESET;
        // UnitTestingValues.GET('DTW004', COMPANYNAME, DATABASE::"Whse. Shipping Driver");
        // WhseShippingDriver.GET(UnitTestingValues.Value);

        // UnitTestingValues.RESET;
        // UnitTestingValues.GET('DTW004', COMPANYNAME, DATABASE::"Whse. Shipping Truck");
        // WhseShippingTruck.GET(UnitTestingValues.Value);
        //BC UPGRADE PATHAA02-DIT<<

        //Step 1: Login to Heilite

        //step 2: Open Transfer Order List Page
        //TransferOrderList.OPENEDIT; //BC UPGRADE PATHAA02-blocked Temp.

        //Step 3: Create new TO
        TransferOrder.OPENNEW;
        TransferOrder.NEW;

        //AssistEdit to create a Doc No and add transfer-from and transfer-to
        TransferOrder."No.".ASSISTEDIT;
        TransferOrder."Transfer-from Code".SETVALUE(LocationFrom.Code);
        TransferOrder."Transfer-to Code".SETVALUE(LocationTo.Code);
        TransferOrder."In-Transit Code".SETVALUE(LocationInTransit.Code);
        TransferOrder."Shipping Agent Code".SETVALUE(ShippingAgent.Code);
        // TransferOrder."Driver Code".SETVALUE(WhseShippingDriver.Code); //BC UPGRADE PATHAA02-DIT
        //TransferOrder."Truck Code".SETVALUE(WhseShippingTruck.Code); //BC UPGRADE PATHAA02-DIT

        //Create Transfer Lines
        TransferOrder.TransferLines."Item No.".SETVALUE(Item."No.");
        TransferOrder.TransferLines.Quantity.SETVALUE(1); //useed notification handler for quantity warning
        LocationCode := LocationFrom.Code;
        BinCode := Bin.Code;
        // TransferOrder.TransferLines.Action1901992804.INVOKE; //Item tracking Lines-Shipment
        // TransferOrder.TransferLines.Action1901992804.INVOKE; //item tracking lines-Receipt
        //TransferOrder.TransferLines.Action1900295404.INVOKE; //Item Tracking lines
        //TransferOrder."Codeunit " Release Transfer Document "".INVOKE; //Release //BC UPGRADE PATHAA02
        TransferOrder."Re&lease".Invoke(); //BC UPGRADE PATHAA02

        //TransferOrder.Action5778.INVOKE; //create Warehouse Shipment //BC UPGRADE PATHAA02
        TransferOrder."Create Whse. S&hipment".Invoke(); //BC UPGRADE PATHAA02
        WarehouseShipment.OPENVIEW;
        WarehouseShipment.FILTER.SETFILTER("Source No. FND", TransferOrder."No.".VALUE);
        WarehouseShipment.WhseShptLines."Zone Code".SETVALUE(Zone.Code);
        WarehouseShipment.WhseShptLines."Bin Code".SETVALUE(Bin.Code);
        WarehouseShipment.WhseShptLines.ItemTrackingLines.INVOKE;
        //ERROR(WarehouseShipment."No.".VALUE);
        //WarehouseShipment.Action25.INVOKE; //Post Warehouse Shipment //BC UPGRADE PATHAA02
        WarehouseShipment."P&ost Shipment".Invoke(); //BC UPGRADE PATHAA02

        //TransferOrder.Action84.INVOKE; //Create Warehouse Receipt //BC UPGRADE PATHAA02
        TransferOrder."Create &Whse. Receipt".Invoke(); //BC UPGRADE PATHAA02
        WarehouseReceipt.OPENVIEW;
        WarehouseReceipt.FILTER.SETFILTER("Source No. FND", TransferOrder."No.".VALUE);
        WarehouseReceipt.WhseReceiptLines."Zone Code".SETVALUE(Zone2.Code);
        WarehouseReceipt.WhseReceiptLines."Bin Code".SETVALUE(Bin2.Code);
        // WarehouseReceipt.WhseReceiptLines.ItemTrackingLines.INVOKE;
        //ERROR(WarehouseReceipt."Source No.".VALUE);
        //ERROR(WarehouseReceipt."No.".VALUE);
        WarehouseReceipt."Post Receipt".INVOKE; //Post Warehouse Receipt

        // TransferOrder.OK.INVOKE;//close the Transfer order
        //TransferOrderList.OK.INVOKE; //close the transfer List //BC UPGRADE PATHAA02-blocked Temp.
        CLEAR(LocationCode);
        CLEAR(BinCode);
    end;

    [ModalPageHandler]
    procedure ItemTrackingLinesModalPageHandler_DTW004(VAR ItemTrackingLines: TestPage "Item Tracking Lines");
    var
        TrackingSpecification: Record "Tracking Specification" temporary;
        ItemTrackingSummaryL: TestPage "Item Tracking Summary";
        ItemTrackingSummary: Page "Item Tracking Summary";
    begin
        // ItemTrackingLines."Lot No.".SETVALUE(Lot_DTW004);
        // //ERROR(ItemTrackingLines."Lot No.".VALUE);
        // ItemTrackingLines."Quantity (Base)".SETVALUE(1);
        // ItemTrackingLines.OK.INVOKE;
        ItemTrackingSummaryL.OPENVIEW;
        ItemTrackingLines."Select Entries".INVOKE;
        ItemTrackingSummaryL.OK.INVOKE;
    end;

    [PageHandler]
    procedure WhseShipPageHandler_DTW004(var WarehouseShipment: Page "Warehouse Shipment");
    begin
    end;

    [PageHandler]
    procedure WhseRcptPageHandler_DTW004(var WarehouseReceipt: Page "Warehouse Receipt");
    begin
    end;

    [StrMenuHandler]
    procedure StrMenuHandler_DTW004(Option: Text[1024]; var Choice: Integer; Instruction: Text[1024]);
    begin
        Choice := 1; //used for posting warehouse shipment (1:ship, 2:ship&invoice) and warehouse receipt (1:receive, 2:receive &invoice), checked both 1 & 2
    end;

    [SendNotificationHandler]
    procedure SendNotificationHandler(var Notification: Notification): Boolean;
    begin
        //HEI.02, hei.04
        //handles warning message item availability send notofication (unhandled UI error)
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler_new')]
    procedure LOG033_CreateGoodsIssuetoProduction();
    var
        Item: Record Item;
        ZoneFrom: Record Zone;
        ZoneTo: Record Zone;
        Bin: Record Bin;
        Location: Record Location;
        ZoneWarehouseMovementList: TestPage "Zone Warehouse Movements";
        ZoneWarehouseMovement: TestPage "Zone Warehouse Movement";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('LOG033', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('LOG033', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('LOG033', COMPANYNAME, DATABASE::"Lot No. Information");
        Lot_LOG033 := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        UnitTestingValues.GET('LOG033', COMPANYNAME, DATABASE::Zone);
        ZoneFrom.GET(Location.Code, UnitTestingValues.Value);
        ZoneTo.GET(Location.Code, UnitTestingValues."Value 2");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('LOG033', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);

        //Step 1: Login to Heilite

        //step 2: Open Zone Warehouse Movements List Page
        ZoneWarehouseMovementList.OPENEDIT;

        //Step 3: Create new Zone Warehouse Movement
        ZoneWarehouseMovement.OPENNEW;
        ZoneWarehouseMovement.NEW;

        //AssistEdit to create a Doc No and add Details on General Tab
        ZoneWarehouseMovement."No.".ASSISTEDIT;
        ZoneWarehouseMovement."Location Code".SETVALUE(Location.Code);
        ZoneWarehouseMovement."Posting Date".SETVALUE(TODAY);
        ZoneWarehouseMovement."From Zone Code".SETVALUE(ZoneFrom.Code);
        ZoneWarehouseMovement."To Zone Code".SETVALUE(ZoneTo.Code);
        WhsActivityNo := ZoneWarehouseMovement."No.".VALUE;

        //Create Lines
        ZoneWarehouseMovement.WhseMovLines.NEW;
        ZoneWarehouseMovement.WhseMovLines."Item No.".SETVALUE(Item."No.");
        ZoneWarehouseMovement.WhseMovLines.Quantity.SETVALUE(2);
        ZoneWarehouseMovement.WhseMovLines."Bin Code".SETVALUE(Bin.Code);
        ZoneWarehouseMovement.WhseMovLines."Due Date".SETVALUE(TODAY);
        ZoneWarehouseMovement.WhseMovLines."Lot No.".SETVALUE(Lot_LOG033);

        // Post Shipment
        //ZoneWarehouseMovement.Action7.INVOKE; //BC UPGRADE PATHAA02
        ZoneWarehouseMovement."Post Shipment".Invoke(); //BC UPGRADE PATHAA02

        ZoneWarehouseMovement.OK.INVOKE;  //close the Zone Warehouse Movement
        ZoneWarehouseMovementList.OK.INVOKE;  //close Zone Warehouse Movement List
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler_new')]
    procedure LOG034_CreateGoodsReceiptProduction();
    var
        Item: Record Item;
        ZoneFrom: Record Zone;
        ZoneTo: Record Zone;
        BinFrom: Record Bin;
        BinTo: Record Bin;
        Location: Record Location;
        ZoneWarehouseMovementList: TestPage "Zone warehouse Movements";
        ZoneWarehouseMovement: TestPage "Zone Warehouse Movement";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('LOG034', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('LOG034', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('LOG034', COMPANYNAME, DATABASE::"Lot No. Information");
        Lot_LOG034 := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        UnitTestingValues.GET('LOG034', COMPANYNAME, DATABASE::Zone);
        ZoneFrom.GET(Location.Code, UnitTestingValues.Value);
        ZoneTo.GET(Location.Code, UnitTestingValues."Value 2");

        UnitTestingValues.RESET;
        UnitTestingValues.GET('LOG034', COMPANYNAME, DATABASE::Bin);
        BinFrom.GET(Location.Code, UnitTestingValues.Value);
        BinTo.GET(Location.Code, UnitTestingValues."Value 2");

        //Step 1: Login to Heilite

        //step 2: Open Zone Warehouse Movements List Page
        ZoneWarehouseMovementList.OPENEDIT;

        //Step 3: Create new Zone Warehouse Movement
        ZoneWarehouseMovement.OPENNEW;
        ZoneWarehouseMovement.NEW;

        //AssistEdit to create a Doc No and add Details on General Tab
        ZoneWarehouseMovement."No.".ASSISTEDIT;
        ZoneWarehouseMovement."Location Code".SETVALUE(Location.Code);
        ZoneWarehouseMovement."Posting Date".SETVALUE(TODAY);
        ZoneWarehouseMovement."From Zone Code".SETVALUE(ZoneFrom.Code);
        ZoneWarehouseMovement."To Zone Code".SETVALUE(ZoneTo.Code);
        WhsActivityNo := ZoneWarehouseMovement."No.".VALUE;

        //Create Lines
        ZoneWarehouseMovement.WhseMovLines.NEW;
        ZoneWarehouseMovement.WhseMovLines."Item No.".SETVALUE(Item."No.");
        ZoneWarehouseMovement.WhseMovLines.Quantity.SETVALUE(2);
        ZoneWarehouseMovement.WhseMovLines."Bin Code".SETVALUE(BinFrom.Code);
        ZoneWarehouseMovement.WhseMovLines."Due Date".SETVALUE(TODAY);
        ZoneWarehouseMovement.WhseMovLines."Lot No.".SETVALUE(Lot_LOG034);

        // Post Shipment
        //ZoneWarehouseMovement.Action7.INVOKE; //BC UPGRADE PATHAA02
        ZoneWarehouseMovement."Post Shipment".Invoke(); //BC UPGRADE PATHAA02

        ZoneWarehouseMovement.WhseMovLines.FILTER.SETFILTER("No.", WhsActivityNo);
        ZoneWarehouseMovement.WhseMovLines.FILTER.SETFILTER("Action Type", 'Place');
        ZoneWarehouseMovement.WhseMovLines."Bin Code".SETVALUE(BinTo.Code);

        // Post Receipt
        // ZoneWarehouseMovement.Action10.INVOKE; //BC UPGRADE PATHAA02
        ZoneWarehouseMovement."Post Receipt".Invoke(); //BC UPGRADE PATHAA02

        ZoneWarehouseMovementList.OK.INVOKE;  //close Zone Warehouse Movement List
    end;

    [Test]
    procedure PRD090_ProductionBOM();
    var
        //ProductionBOM: TestPage "Routing Version"; //BC UPGRADE PATHAA02
        ProductionBOM: TestPage "Production BOM";
        ItemComp1: Record Item;
        ItemComp2: Record Item;
        UnitofMeasure: Record "Unit of Measure";
        RoutingLink: Record "Routing Link";
        StockkeepingUnit: Record "Stockkeeping Unit";
        ProductionBOMHeader: Record "Production BOM Header";
        ProductionBOMLine: Record "Production BOM Line";
        Result: Text;
        DocumentNo: Text;
        LastDoc: Code[20];
        DocumentFilter: Text;
        NewDocNo: Text;
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD090', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);
        ItemComp1.GET(UnitTestingValues."Value 2");
        ItemComp2.GET(UnitTestingValues."Value 3");

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD090', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        StockkeepingUnit.GET(Location.Code, Item."No.", '');

        //Check Default value for UOM
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD090', COMPANYNAME, DATABASE::"Unit of Measure");
        UnitofMeasure.GET(UnitTestingValues.Value);

        //Check Default value for Routing Link
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD090', COMPANYNAME, DATABASE::"Routing Link");
        RoutingLink.GET(UnitTestingValues.Value);

        DocumentNo := DELCHR(Item."No.", '<', '00');
        DocumentFilter := '*' + DocumentNo;
        ProductionBOMHeader.RESET;
        ProductionBOMHeader.SETFILTER("No.", '%1', DocumentFilter);
        if ProductionBOMHeader.FINDLAST then
            LastDoc := ProductionBOMHeader."No.";

        LastDoc := COPYSTR(LastDoc, 1, 2);
        LastDoc := INCSTR(LastDoc);
        NewDocNo := INSSTR(DocumentNo, LastDoc, 1);

        ProductionBOM.OPENNEW;
        ProductionBOM.NEW;
        ProductionBOM."No.".SETVALUE(NewDocNo);
        ProductionBOM."Unit of Measure Code".SETVALUE(UnitofMeasure.Code);

        ProductionBOM.ProdBOMLine.Type.SETVALUE('Item');
        ProductionBOM.ProdBOMLine."No.".SETVALUE(ItemComp1."No.");
        ProductionBOM.ProdBOMLine."Quantity per".SETVALUE(1);
        ProductionBOM.ProdBOMLine."Routing Link Code".SETVALUE(RoutingLink.Code);

        ProductionBOM.ProdBOMLine.NEW;
        ProductionBOM.ProdBOMLine.Type.SETVALUE('Item');
        ProductionBOM.ProdBOMLine."No.".SETVALUE(ItemComp2."No.");
        ProductionBOM.ProdBOMLine."Quantity per".SETVALUE(1);
        ProductionBOM.ProdBOMLine."Routing Link Code".SETVALUE(RoutingLink.Code);

        ProductionBOM."Linked SKU".SETVALUE(StockkeepingUnit."Location Code");

        ProductionBOM.Status.SETVALUE('Certified');
        ProductionBOM.OK.INVOKE;
    end;

    [Test]
    // BC Upgrade PATELP08 >> v28 opens the Versions action MODALLY -> ProdBOMVersionListModalPageHandler runs
    // (the non-modal ProdBOMVersionListPageHandler is now orphaned). Closing the empty version list raises an
    // informational "no Active version" MESSAGE -> add MessageHandler to swallow it; drop the unconsumed handler.
    // [HandlerFunctions('ProdBOMVersionListPageHandler,ProdBOMVersionListModalPageHandler')]
    [HandlerFunctions('ProdBOMVersionListModalPageHandler,MessageHandler')]
    // BC Upgrade PATELP08 <<
    procedure PRDE14_CreateBOMversions();
    var
        ProductionBOM: TestPage "Production BOM";
        ItemComp1: Record Item;
        ItemComp2: Record Item;
        UnitofMeasure: Record "Unit of Measure";
        RoutingLink: Record "Routing Link";
        StockkeepingUnit: Record "Stockkeeping Unit";
        ProductionBOMHeader: Record "Production BOM Header";
        ProductionBOMLine: Record "Production BOM Line";
        Result: Text;
        DocumentNo: Text;
        LastDoc: Code[20];
        DocumentFilter: Text;
        RecProductionBOMVersion: Record "Production BOM Version";
        ProductionBOMVersion: TestPage "Production BOM Version";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD090', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);
        ItemComp1.GET(UnitTestingValues."Value 2");
        ItemComp2.GET(UnitTestingValues."Value 3");

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD090', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        StockkeepingUnit.GET(Location.Code, Item."No.", '');

        //Check Default value for UOM
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD090', COMPANYNAME, DATABASE::"Unit of Measure");
        UnitofMeasure.GET(UnitTestingValues.Value);

        //Check Default value for Routing Link
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD090', COMPANYNAME, DATABASE::"Routing Link");
        RoutingLink.GET(UnitTestingValues.Value);

        DocumentNo := DELCHR(Item."No.", '<', '00');
        DocumentFilter := '*' + DocumentNo;
        ProductionBOMHeader.RESET;
        ProductionBOMHeader.SETFILTER("No.", '%1', DocumentFilter);
        if ProductionBOMHeader.FINDLAST then
            LastDoc := ProductionBOMHeader."No.";

        LastDoc := COPYSTR(LastDoc, 1, 2);
        LastDoc := INCSTR(LastDoc);
        NewDocNo := INSSTR(DocumentNo, LastDoc, 1);

        // BC Upgrade PATELP08 >> v28: page-based header creation leaves "No." uncommitted, so validating
        // "Unit of Measure Code" fails ("key fields are not valid"). Insert the header via record first.
        // VALIDATE "No." (not direct assign) so the OnAfterValidate hook sets "Linked Item No." -> "Linked SKU" lookup works.
        // ProductionBOM.OPENNEW;
        // ProductionBOM.NEW;
        // ProductionBOM."No.".SETVALUE(NewDocNo);
        ProductionBOMHeader.INIT;
        ProductionBOMHeader.VALIDATE("No.", NewDocNo);
        ProductionBOMHeader.INSERT(TRUE);
        ProductionBOM.OPENEDIT;
        ProductionBOM.GOTORECORD(ProductionBOMHeader);
        // BC Upgrade PATELP08 <<
        ProductionBOM."Unit of Measure Code".SETVALUE(UnitofMeasure.Code);

        ProductionBOM.ProdBOMLine.Type.SETVALUE('Item');
        ProductionBOM.ProdBOMLine."No.".SETVALUE(ItemComp1."No.");
        ProductionBOM.ProdBOMLine."Quantity per".SETVALUE(1);
        ProductionBOM.ProdBOMLine."Routing Link Code".SETVALUE(RoutingLink.Code);

        ProductionBOM.ProdBOMLine.NEW;
        ProductionBOM.ProdBOMLine.Type.SETVALUE('Item');
        ProductionBOM.ProdBOMLine."No.".SETVALUE(ItemComp2."No.");
        ProductionBOM.ProdBOMLine."Quantity per".SETVALUE(1);
        ProductionBOM.ProdBOMLine."Routing Link Code".SETVALUE(RoutingLink.Code);

        ProductionBOM."Linked SKU".SETVALUE(StockkeepingUnit."Location Code");

        ProductionBOM.Status.SETVALUE('Certified');
        ProductionBOM.OK.INVOKE;

        ProductionBOM.OPENEDIT;
        ProductionBOM.FILTER.SETFILTER("No.", NewDocNo);
        ProductionBOMVersion.TRAP;
        // ProductionBOM."Page " Prod.BOM Version List ".INVOKE; //BC UPGRADE PATHAA02
        ProductionBOM.Versions.Invoke(); //BC UPGRADE PATHAA02

        // RecProductionBOMVersion.RESET;
        // RecProductionBOMVersion.SETRANGE("Production BOM No.",NewDocNo);
        // RecProductionBOMVersion.FINDFIRST;
        // ERROR('%1..%2',RecProductionBOMVersion."Production BOM No.",RecProductionBOMVersion.Active);
    end;

    [PageHandler]
    procedure ProdBOMVersionListPageHandler(var ProdBOMVersionList: TestPage "Prod. BOM Version List");
    var
        ProductionBOMVersion: TestPage "Production BOM Version";
        UnitofMeasure: Record "Unit of Measure";
        RoutingLink: Record "Routing Link";
        RecProductionBOMVersion: Record "Production BOM Version";
    begin
        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD090', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues."Value 2");

        //Check Default value for UOM
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD090', COMPANYNAME, DATABASE::"Unit of Measure");
        UnitofMeasure.GET(UnitTestingValues.Value);

        //Check Default value for Routing Link
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD090', COMPANYNAME, DATABASE::"Routing Link");
        RoutingLink.GET(UnitTestingValues.Value);

        ProdBOMVersionList.NEW;
        RecProductionBOMVersion.SETRANGE("Production BOM No.", NewDocNo);
        RecProductionBOMVersion.FINDFIRST;
        ProductionBOMVersion.GOTORECORD(RecProductionBOMVersion);
        ProductionBOMVersion."Version Code".SETVALUE('DEFAULT');
        ProductionBOMVersion."Unit of Measure Code".SETVALUE(UnitofMeasure.Code);
        ProductionBOMVersion."Starting Date".SETVALUE(WORKDATE);
        ProductionBOMVersion.ProdBOMLine.Type.SETVALUE('Item');
        ProductionBOMVersion.ProdBOMLine."No.".SETVALUE(Item."No.");
        ProductionBOMVersion.ProdBOMLine."Quantity per".SETVALUE(1);
        ProductionBOMVersion.ProdBOMLine."Routing Link Code".SETVALUE(RoutingLink.Code);

        ProductionBOMVersion.Status.SETVALUE('Certified');
        ProductionBOMVersion.Active.SETVALUE(true);
        ProductionBOMVersion.OK.INVOKE;
        ProdBOMVersionList.CLOSE;
    end;

    [Test]
    procedure PRDE15_ChangeBoM();
    var
        ProductionBOMHeader: Record "Production BOM Header";
        ProductionBOM: TestPage "Production BOM";
        ProductionBOMLine: Record "Production BOM Line";
        QtyPer: Decimal;
    begin
        // HEI.03 >>
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.21>>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRD090', COMPANYNAME, DATABASE::"Production BOM Header");
        //HEI.21<<
        ProductionBOMHeader.RESET;
        ProductionBOMHeader.SETRANGE("No.", UnitTestingValues.Value);//HEI.21
        ProductionBOMHeader.SETRANGE(Status, ProductionBOMHeader.Status::Certified);
        if ProductionBOMHeader.FINDLAST then begin
            ProductionBOM.OPENEDIT;
            ProductionBOM.GOTORECORD(ProductionBOMHeader);
            ProductionBOM.Status.SETVALUE('Under Development');

            ProductionBOMLine.RESET;
            ProductionBOMLine.SETRANGE("Production BOM No.", ProductionBOMHeader."No.");
            ProductionBOMLine.SETRANGE(Type, ProductionBOMLine.Type::Item);
            if ProductionBOMLine.COUNT > 2 then begin
                ProductionBOMLine.FINDLAST;
                ProductionBOMLine.DELETE;
            end;

            ProductionBOM.ProdBOMLine.FILTER.SETFILTER(Type, 'Item');
            EVALUATE(QtyPer, ProductionBOM.ProdBOMLine."Quantity per".VALUE);
            ProductionBOM.ProdBOMLine."Quantity per".SETVALUE(QtyPer + 2);

            ProductionBOM.Status.SETVALUE('Certified');
            ProductionBOM.OK.INVOKE;
        end;
        // HEI.03 <<
    end;

    [Test]
    procedure PRDE15_RoutingHeader();
    var
        RoutingCard: TestPage "Routing";
        Workcenter: Record "Work Center";
        RoutingLink: Record "Routing Link";
        StockkeepingUnit: Record "Stockkeeping Unit";
        RoutingHeader: Record "Routing Header";
        RoutingLine: Record "Routing Line";
        Result: Text;
        DocumentNo: Text;
        LastDoc: Code[20];
        DocumentFilter: Text;
        NewDocNo: Text;
    begin
        //HEI.20>>
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //Check default value for Workcenter
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRDE15', COMPANYNAME, DATABASE::"Work Center");
        Workcenter.GET(UnitTestingValues.Value);

        //Check default value for Workcenter
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRDE15', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check Default value for Routing Link
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRDE15', COMPANYNAME, DATABASE::"Routing Link");
        RoutingLink.GET(UnitTestingValues.Value);

        DocumentNo := DELCHR(Item."No.", '<', '00');
        DocumentFilter := '*' + DocumentNo;
        RoutingHeader.RESET;
        RoutingHeader.SETFILTER("No.", '%1', DocumentFilter);
        if RoutingHeader.FINDLAST then
            LastDoc := RoutingHeader."No.";

        LastDoc := COPYSTR(LastDoc, 1, 2);
        LastDoc := INCSTR(LastDoc);
        NewDocNo := INSSTR(DocumentNo, LastDoc, 1);



        RoutingCard.OPENNEW;
        RoutingCard.NEW;
        RoutingCard."No.".SETVALUE(NewDocNo);
        RoutingCard.Type.SETVALUE('Serial');

        RoutingCard.RoutingLine."Operation No.".SETVALUE(10);
        RoutingCard.RoutingLine.Type.SETVALUE('Work Center');
        RoutingCard.RoutingLine."No.".SETVALUE(Workcenter."No.");

        RoutingCard.RoutingLine."Run Time".SETVALUE(0.012);
        //RoutingCard.RoutingLine."Line Speed".SETVALUE(324); //BC UPGRADE PATHAA02-F2036301

        RoutingLine.RESET;
        RoutingLine.SETRANGE("Routing No.", NewDocNo);
        if RoutingLine.FINDSET then begin
            RoutingLine."Routing Link Code" := RoutingLink.Code;
            RoutingLine.MODIFY;
        end;
        //RoutingCard.RoutingLine."Routing Link Code".SETVALUE(RoutingLink.Code);

        RoutingCard."Linked SKU".SETVALUE(StockkeepingUnit."Location Code");

        RoutingCard.Status.SETVALUE('Certified');
        RoutingCard.OK.INVOKE;
        //HEI.20<<
    end;

    [Test]
    // BC Upgrade PATELP08 >> v28 Versions action opens list modally; use stub handler (version pre-created in body)
    // [HandlerFunctions('RoutingVersionListPageHandler')]
    [HandlerFunctions('RoutingVersionListModalPageHandler')]
    // BC Upgrade PATELP08 <<
    procedure PRDE16_CreateRoutinversions();
    var
        RoutingCard: TestPage "Routing";
        ItemComp1: Record Item;
        ItemComp2: Record Item;
        UnitofMeasure: Record "Unit of Measure";
        RoutingLink: Record "Routing Link";
        StockkeepingUnit: Record "Stockkeeping Unit";
        RoutingHeader: Record "Routing Header";
        RoutingLine: Record "Routing Line";
        Result: Text;
        DocumentNo: Text;
        LastDoc: Code[20];
        DocumentFilter: Text;
        RoutingVersion: Record "Routing Version";
        RoutingVersionCard: TestPage "Routing Version";
        RoutingVersionlist: TestPage "Routing Version List";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.20>>
        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRDE15', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRDE15', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Check Default value for work center
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRDE15', COMPANYNAME, DATABASE::"Work Center");
        WorkCenter.GET(UnitTestingValues.Value);

        StockkeepingUnit.GET(Location.Code, Item."No.", '');

        //Check Default value for Routing Link
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRDE15', COMPANYNAME, DATABASE::"Routing Link");
        RoutingLink.GET(UnitTestingValues.Value);

        //Check Default value for Routing Link
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRDE15', COMPANYNAME, DATABASE::"Routing Header");
        RoutingHeader.GET(UnitTestingValues.Value);

        DocumentNo := DELCHR(Item."No.", '<', '00');
        DocumentFilter := '*' + DocumentNo;
        RoutingHeader.RESET;
        RoutingHeader.SETFILTER("No.", '%1', DocumentFilter);
        if RoutingHeader.FINDLAST then
            LastDoc := RoutingHeader."No.";

        LastDoc := COPYSTR(LastDoc, 1, 2);
        LastDoc := INCSTR(LastDoc);
        NewDocNo := INSSTR(DocumentNo, LastDoc, 1);


        RoutingCard.OPENNEW;
        RoutingCard.NEW;
        RoutingCard."No.".SETVALUE(NewDocNo);
        RoutingCard.Type.SETVALUE('Serial');

        RoutingCard.RoutingLine."Operation No.".SETVALUE(10);
        RoutingCard.RoutingLine.Type.SETVALUE('Work Center');
        RoutingCard.RoutingLine."No.".SETVALUE(WorkCenter."No.");

        RoutingCard.RoutingLine."Run Time".SETVALUE(0.012);
        //RoutingCard.RoutingLine."Line Speed".SETVALUE(324); //BC UPGRADE PATHAA02

        RoutingLine.RESET;
        RoutingLine.SETRANGE("Routing No.", NewDocNo);
        if RoutingLine.FINDSET then begin
            RoutingLine."Routing Link Code" := RoutingLink.Code;
            RoutingLine.MODIFY;
        end;

        RoutingCard.Status.SETVALUE('Certified');
        RoutingCard.OK.INVOKE;

        RoutingCard.OPENEDIT;
        RoutingCard.FILTER.SETFILTER("No.", NewDocNo);
        //RoutingVersionCard.TRAP;//yk
        //RoutingVersionlist.Trap();
        // RoutingCard."Page " Routing Version List "".INVOKE; //BC UPGRADE PATHAA02
        // BC Upgrade PATELP08 >> v28 Versions action runs Page.RunModal(0,RoutingVersion) which errors
        // "There is no Routing Version within the filter" when none exist; pre-create the version via records.
        RoutingVersion.INIT;
        RoutingVersion.VALIDATE("Routing No.", NewDocNo);
        RoutingVersion.VALIDATE("Version Code", 'DEFAULT');
        RoutingVersion.VALIDATE("Starting Date", WORKDATE);
        RoutingVersion.INSERT(TRUE);
        RoutingLine.INIT;
        RoutingLine.VALIDATE("Routing No.", NewDocNo);
        RoutingLine.VALIDATE("Version Code", 'DEFAULT');
        RoutingLine.VALIDATE("Operation No.", '10');
        RoutingLine.VALIDATE(Type, RoutingLine.Type::"Work Center");
        RoutingLine.VALIDATE("No.", WorkCenter."No.");
        RoutingLine.VALIDATE("Run Time", 0.012);
        RoutingLine.VALIDATE("Routing Link Code", RoutingLink.Code);
        RoutingLine.INSERT(TRUE);
        RoutingVersion.VALIDATE(Status, RoutingVersion.Status::Certified);
        RoutingVersion.VALIDATE("Active FND", true);
        RoutingVersion.MODIFY(TRUE);
        // BC Upgrade PATELP08 <<
        RoutingCard."&Versions".Invoke(); //BC UPGRADE PATHAA02
        //HEI.20>>
    end;

    [ModalPageHandler]
    procedure RoutingVersionListPageHandler(var RoutingVersionList: TestPage "Routing Version List");
    var
        RoutingVersion: TestPage "Routing Version";
        UnitofMeasure: Record "Unit of Measure";
        RoutingLink: Record "Routing Link";
        RecRoutingVersion: Record "Routing Version";
        Workcenter: Record "Work Center";
        RoutingHeader: Record "Routing Header";
        RoutingLine: Record "Routing Line";
    begin
        //HEI.20<<
        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRDE15', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //Check Default value for work center
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRDE15', COMPANYNAME, DATABASE::"Work Center");
        Workcenter.GET(UnitTestingValues.Value);

        //Check Default value for Routing
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRDE15', COMPANYNAME, DATABASE::"Routing Header");
        RoutingHeader.GET(UnitTestingValues.Value);

        //Check Default value for Routing Link
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRDE15', COMPANYNAME, DATABASE::"Routing Link");
        RoutingLink.GET(UnitTestingValues.Value);



        RoutingVersionList.NEW;
        RecRoutingVersion.SETRANGE("Routing No.", NewDocNo);
        RecRoutingVersion.FINDFIRST;
        RoutingVersion.GOTORECORD(RecRoutingVersion);
        RoutingVersion."Version Code".SETVALUE('DEFAULT');
        RoutingVersion."Starting Date".SETVALUE(WORKDATE);
        RoutingVersion.Type.SETVALUE('Serial');
        RoutingVersion.RoutingLine."Operation No.".SETVALUE(10);
        RoutingVersion.RoutingLine.Type.SETVALUE('Work Center');
        RoutingVersion.RoutingLine."No.".SETVALUE(Workcenter."No.");
        RoutingVersion.RoutingLine."Run Time".SETVALUE(0.012);
        // RoutingVersion.RoutingLine."Line Speed".SETVALUE(324); //BC UPGRADE PATHAA02-DIT
        RoutingLine.RESET;
        RoutingLine.SETRANGE("Routing No.", NewDocNo);
        RoutingLine.SETRANGE("Version Code", RecRoutingVersion."Version Code");
        if RoutingLine.FINDSET then begin
            RoutingLine."Routing Link Code" := RoutingLink.Code;
            RoutingLine.MODIFY;
        end;
        //RoutingVersion.RoutingLine."Routing Link Code".SETVALUE(RoutingLink.Code);
        RoutingVersion.Status.SETVALUE('Certified');
        RoutingVersion.Active.SETVALUE(true);
        RoutingVersion.OK.INVOKE;
        RoutingVersionList.CLOSE;
        //HEI.20>>
    end;

    [Test]
    procedure PRDE17_ChangeRouting();
    var
        RoutingHeader: Record "Routing Header";
        RoutingCard: TestPage Routing;
        RoutingLine: Record "Routing Line";
        QtyPer: Decimal;
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        // HEI.20 >>
        RoutingHeader.RESET;
        RoutingHeader.SETRANGE(Status, RoutingHeader.Status::Certified);
        if RoutingHeader.FINDLAST then begin
            RoutingCard.OPENEDIT;
            RoutingCard.GOTORECORD(RoutingHeader);
            RoutingCard.Status.SETVALUE('Under Development');


            RoutingCard.RoutingLine.FILTER.SETFILTER(Type, 'Work center');
            EVALUATE(QtyPer, RoutingCard.RoutingLine."Run Time".VALUE);
            RoutingCard.RoutingLine."Run Time".SETVALUE(QtyPer + 2);

            RoutingCard.Status.SETVALUE('Certified');
            RoutingCard.OK.INVOKE;
        end;
        // HEI.20 <<
    end;

    [Test]
    procedure PRDE18_LinkedSKU();
    var
        RoutingHeader: Record "Routing Header";
        DocumentNo: Code[20];
        DocumentFilter: Text;
        LastDoc: Code[20];
        Item: Record Item;
        RoutingCard: TestPage Routing;
        StockkeepingUnit: Record "Stockkeeping Unit";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.22
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRDE15', COMPANYNAME, DATABASE::"Routing Header");
        RoutingHeader.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRDE15', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRDE15', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        RoutingCard.OPENEDIT;
        RoutingCard.GOTORECORD(RoutingHeader);
        RoutingCard.Status.SETVALUE('Under Development');

        DocumentNo := DELCHR(Item."No.", '<', '00');
        DocumentFilter := '*' + DocumentNo;
        RoutingHeader.RESET;
        RoutingHeader.SETFILTER("No.", '%1', DocumentFilter);
        if RoutingHeader.FINDLAST then
            LastDoc := RoutingHeader."No.";

        LastDoc := COPYSTR(LastDoc, 1, 2);
        LastDoc := INCSTR(LastDoc);
        NewDocNo := INSSTR(DocumentNo, LastDoc, 1);

        StockkeepingUnit.RESET;
        StockkeepingUnit.GET(Location.Code, Item."No.", '');

        RoutingCard."Linked SKU".SETVALUE(StockkeepingUnit."Location Code");
        RoutingCard.Status.SETVALUE('Certified');
        RoutingCard.OK.INVOKE;
        //HEI.22
    end;

    [Test]
    procedure PRDE19_LinkingSKUtoItem();
    var
        RoutingHeader: Record "Routing Header";
        DocumentNo: Code[20];
        DocumentFilter: Text;
        LastDoc: Code[20];
        Item: Record Item;
        RoutingCard: TestPage Routing;
        StockkeepingUnit: Record "Stockkeeping Unit";
        ItemCard: TestPage "Item Card";
        StockkeepingCard: TestPage "Stockkeeping Unit Card";
    begin
        //HEI.28>>
        //PreSetupUpdate;//HEI.32
        //HEI.28<<
        //HEI.22
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRDE15', COMPANYNAME, DATABASE::"Routing Header");
        RoutingHeader.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRDE15', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRDE15', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        StockkeepingUnit.RESET;
        StockkeepingUnit.GET(Location.Code, Item."No.", '');
        StockkeepingCard.OPENEDIT;
        //HEI.35>>
        //StockkeepingCard.GOTORECORD(StockkeepingUnit);
        StockkeepingCard.FILTER.SETFILTER("Location Code", StockkeepingUnit."Location Code");
        StockkeepingCard.FILTER.SETFILTER("Item No.", StockkeepingUnit."Item No.");
        StockkeepingCard.FILTER.SETFILTER("Variant Code", StockkeepingUnit."Variant Code");
        //HEI.35<<
        if StockkeepingCard."Routing No.".VALUE = RoutingHeader."No." then
            StockkeepingCard.CLOSE
        //ELSE//HEI.24
        //  ERROR('Routing not mapped with SKU');//HEI.24
        //HEI.22
    end;

    [Test]
    procedure PRDM06_MultipleUoMandConversion();
    var
        RoutingHeader: Record "Routing Header";
        DocumentNo: Code[20];
        DocumentFilter: Text;
        LastDoc: Code[20];
        Item: Record Item;
        RoutingCard: TestPage Routing;
        StockkeepingUnit: Record "Stockkeeping Unit";
        ItemCard: TestPage "Item Card";
        StockkeepingCard: TestPage "Stockkeeping Unit Card";
        ItemUnitOfMeasureCard: TestPage "Item Units of Measure";
        ItemUnitOfmeasure: Record "Item Unit of Measure";
        Itemlist: TestPage "Item List";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.22
        Item.RESET;
        Item.SETRANGE("Item Category Code", '01');
        if Item.FINDLAST then;
        if Item."Base Unit of Measure" <> '' then begin
            ItemUnitOfmeasure.RESET;
            ItemUnitOfmeasure.SETRANGE("Item No.", Item."No.");
            ItemUnitOfmeasure.SETFILTER(Code, '<>%1', Item."Base Unit of Measure");

            // BC Upgrade MISHRS14 >>
            // Removed false from FINDSET due to warning because its being depreceted 
            //if not ItemUnitOfmeasure.FINDSET(false, false) then;
            if not ItemUnitOfmeasure.FINDSET(false) then;
            // BC Upgrade MISHRS14 <<

            //ERROR('Item not having unit of measure conversion'); //HEI.24
        end;
        //HEI.22
    end;

    [Test]
    procedure PRD114_FGsReturnToWHToQualityHoldStatus();
    var
        LotNoInfo: Record "Lot No. Information";
        Item: Record Item;
        LotNoInfoCardTestPage: TestPage "Lot No. Information Card";
        LotNo: Label 'PRD114';
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.25>>

        //HEI.29>>
        Item.RESET;
        LotNoInfo.RESET;
        LotNoInfo.SETCURRENTKEY("Item No.", "Variant Code", "Lot No.");
        LotNoInfo.SETFILTER("Item No.", '<>%1', '');
        LotNoInfo.SETFILTER("Lot No.", '<>%1', '');
        //LotNoInfo.SETFILTER("Quality Status",'<>%1',LotNoInfo."Quality Status"::Quarantine);
        if LotNoInfo.FINDLAST then begin
            Item.GET(LotNoInfo."Item No.");
        end
        else
            Item.FINDFIRST;
        //HEI.29<<

        LotNoInfo."Lot No." := LotNo;
        LotNoInfo.VALIDATE("Item No.", Item."No.");
        //LotNoInfo."Quality Status" := LotNoInfo."Quality Status"::Pass; //Unrestricted //BC UPGRADE PATHAA02-F2035102
        LotNoInfo.INSERT;

        LotNoInfoCardTestPage.OPENEDIT;
        LotNoInfoCardTestPage.GOTORECORD(LotNoInfo);
        //LotNoInfoCardTestPage."Quality Status".SETVALUE(LotNoInfo."Quality Status"::Quarantine); //Quality Hold //BC UPGRADE PATHAA02-F2035102
        LotNoInfoCardTestPage.OK.INVOKE;

        CLEAR(LotNoInfo);
        LotNoInfo.SETRANGE("Lot No.", LotNo);
        LotNoInfo.FINDFIRST;
        //LotNoInfo.TESTFIELD("Quality Status", LotNoInfo."Quality Status"::Quarantine); //check Quality Hold //BC UPGRADE PATHAA02-F2035102

        //HEI.25<<
    end;

    [Test]
    [HandlerFunctions('PRDR06_ItemTracking_PageHandler,PRDR06_ItemTrackingSummaryPageHandler,PRDR06_ConfirmationHandler,PRDR06_SuccessMessageHandler')]
    procedure PRDR06_ItemReclassificationJournal();
    var
        ILE: Record "Item Ledger Entry";
        ItemJnlLine: Record "Item Journal Line";
        ItemReclJnlTestPage: TestPage "Item Reclass. Journal";
    begin
        //HEI.28>>
        PreSetupUpdate;
        //HEI.28<<
        //HEI.25>>
        //Handler fuctions:
        //PRDR06_ItemTracking_PageHandler
        //PRDR06_ItemTrackingSummaryPageHandler
        //PRDR06_ConfirmationHandler
        //PRDR06_SuccessMessageHandler

        //Check default value for Item
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PRDR06', COMPANYNAME, DATABASE::Item);

        ILE.SETRANGE("Item No.", UnitTestingValues.Value);
        ILE.SETRANGE(Positive, true);
        ILE.SETRANGE(Open, true);
        ILE.FINDLAST;

        ItemReclJnlTestPage.OPENEDIT;
        ItemReclJnlTestPage.CurrentJnlBatchName.SETVALUE(UnitTestingValues."Value 2");
        ItemReclJnlTestPage."Document No.".SETVALUE(UnitTestingValues."Value 3");
        ItemReclJnlTestPage."Item No.".SETVALUE(UnitTestingValues.Value);
        ItemReclJnlTestPage."Location Code".SETVALUE(ILE."Location Code");
        // ItemReclJnlTestPage."Zone Code".SETVALUE(ILE."Zone Code"); //BC UPGRADE PATHAA02-Check Zone code field in PageExt-Item reclass jnl page-blocked temp.
        ItemReclJnlTestPage.OK.INVOKE;

        ItemJnlLine.SETRANGE("Journal Template Name", 'RECLASS');
        ItemJnlLine.SETRANGE("Journal Batch Name", UnitTestingValues."Value 2");
        ItemJnlLine.FINDFIRST;
        // ItemJnlLine.VALIDATE("Bin Code", ILE."Bin Code"); //BC UPGRADE PATHAA02-T32-F2036301
        ItemJnlLine.VALIDATE("New Location Code", ILE."Location Code");
        ItemJnlLine.VALIDATE("New Zone Code FND", ILE."Zone Code FND");
        //ItemJnlLine.VALIDATE("New Bin Code", ILE."Bin Code"); //BC UPGRADE PATHAA02-T32-F2036301
        ItemJnlLine.VALIDATE(Quantity, 1);
        ItemJnlLine.MODIFY;

        ItemReclJnlTestPage.OPENEDIT;
        ItemReclJnlTestPage.GOTORECORD(ItemJnlLine);

        //ItemReclJnlTestPage.Action6500.INVOKE; //Item Tracking Lines //BC UPGRADE PATHAA02
        ItemReclJnlTestPage."Item &Tracking Lines".Invoke(); //BC UPGRADE PATHAA02

        ItemReclJnlTestPage.Post.INVOKE;
        ItemReclJnlTestPage.OK.INVOKE;
        //HEI.25<<
    end;

    [ModalPageHandler]
    procedure PRDR06_ItemTracking_PageHandler(VAR ItemTrackingLines: TestPage "Item Tracking Lines");
    var
        TrackingSpecification: Record "Tracking Specification" temporary;
        ItemTrackingSummaryL: TestPage "Item Tracking Summary";
        ItemTrackingSummary: Page "Item Tracking Summary";
    begin
        //HEI.25>>
        ItemTrackingSummaryL.OPENVIEW;
        ItemTrackingLines."Select Entries".INVOKE;
        ItemTrackingSummaryL.OK.INVOKE;
        //HEI.25<<
    end;

    [ModalPageHandler]
    procedure PRDR06_ItemTrackingSummaryPageHandler(var ItemTrackingSummary: TestPage "Item Tracking Summary");
    begin
        //HEI.25>>
        ItemTrackingSummary.OK.INVOKE;
        //HEI.25<<
    end;

    [ConfirmHandler]
    procedure PRDR06_ConfirmationHandler(Question: Text[1024]; var Reply: Boolean);
    var
        PostOrderQst: TextConst ENU = 'Do you want to post the Order?', FRA = 'Souhaitez-vous valider cette réception ?';
        ChangeRoutingVersionCode: Label 'This change may have caused bin codes on some production order component lines to be different from those on the production order routing line. Do you want to automatically align all of these unmatched bin codes?';
        ChangeWorkCenter: Label 'This change may have caused bin codes on some production order component lines to be different from those on the production order routing line. Do you want to automatically align all of these unmatched bin codes?';
        ChangeStatusRPOtoFPO: Label 'Production Order %1 has not been finished. Some consumption is still missing. Do you still want to finish the order?';
    begin
        //HEI.25>>
        Reply := true;
        //HEI.25<<
    end;

    [MessageHandler]
    procedure PRDR06_SuccessMessageHandler(Message: Text[1024]);
    var
        TxtPostedSuccessfully: Label 'The journal lines were successfully posted.';
    begin
        //HEI.25>>
        if Message <> TxtPostedSuccessfully then
            ERROR('Unexpected result message: %1', Message);
        //HEI.25<<
    end;

    [Test]
    procedure RefreshProdOrder_Action26();
    var
        ProdOrder: Record "Production Order";
        StockKeepingUnit: Record "Stockkeeping Unit";
        RoutingVersion: Record "Routing Version";
        ProductionBOMVersion: Record "Production BOM Version";
        RoutingNo: Code[20];
        BOM: Code[20];
        RoutingExist: Boolean;
        BOMExist: Boolean;
    begin

        //HEI.26>>
        ProdOrder.RESET;
        ProdOrder.SETRANGE(Status, ProductionOrderStatus);
        ProdOrder.SETRANGE("No.", ProductionOrderNo);
        if ProdOrder.FINDSET then;
        if Item.GET(ProdOrder."Source No.") then begin
            StockKeepingUnit.SETRANGE("Item No.", Item."No.");
            StockKeepingUnit.SETRANGE("Location Code", ProdOrder."Location Code");
            if StockKeepingUnit.FINDFIRST then begin
                RoutingNo := StockKeepingUnit."Routing No.";
                BOM := StockKeepingUnit."Production BOM No.";
            end else
                ERROR('There is not any Active Routing / BOM version');
            RoutingVersion.SETRANGE("Routing No.", ProdOrder."Routing No.");
            RoutingVersion.SETRANGE("Active FND", true);
            if RoutingVersion.FINDFIRST then
                RoutingExist := true
            else
                RoutingExist := false;
            //ProductionBOMVersion.SETRANGE("Production BOM No.", ProdOrder."Production BOM No."); //BC UPGRADE PATHAA02-DIT-T5405-F2035272
            ProductionBOMVersion.SETRANGE("Active FND", true);
            ProductionBOMVersion.SETRANGE("Active FND", true);
            //HEI.40>>
            //IF ProductionBOMVersion.FINDFIRST THEN
            if ProductionBOMVersion.FINDFIRST then begin
                BOMExist := true;
                ProductionBOMLine.RESET;
                ProductionBOMLine.SETRANGE("Production BOM No.", ProductionBOMVersion."Production BOM No.");
                ProductionBOMLine.SETRANGE("Version Code", ProductionBOMVersion."Version Code");
                if ProductionBOMLine.FINDSET then begin
                    if ProductionBOMLine."Routing Link Code" <> '' then
                        ProductionBOMLine.MODIFYALL("Routing Link Code", '');
                end;
            end else
                //ELSE
                //HEI.40<<
                BOMExist := false;
        end;

        if RoutingExist and BOMExist then
            RefreshProductionOrder(ProdOrder)//HEI.38
                                             //REPORT.RUNMODAL(REPORT::"Refresh Production Order DTW",FALSE,FALSE,ProdOrder)//HEI.38
        else
            ERROR('There is not any Active Routing / BOM version');
        //HEI.26<<
    end;

    [Test]
    procedure PreSetupUpdate();
    begin
        //HEI.28>>
        //below code is for this error message -- "Consumption Quantity 0 of Item 0020001513 is out of Target range 0.0019 to 0.0021."

        MfgSetupDisable.LOCKTABLE;
        if MfgSetupDisable.GET then begin
            MfgSetupDisable."Consump. Tolerance Limit FND" := false;
            MfgSetupDisable.MODIFY(false);
        end;
        UserSetup.RESET;
        UserSetup.MODIFYALL("Consump. Tolerance Warning FND", true);

        //below code is for this error message --Select a Dimension Value Code for the Dimension Code* for G/L Account 31011001.
        DefaultDimension.RESET;//HEI.35
        DefaultDimension.SETCURRENTKEY("Value Posting");//HEI.35
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");

        //For Item tracking expiry errors
        ItemTrackingCode.RESET;
        ItemTrackingCode.MODIFYALL("Strict Expiration Posting", false);
        ItemTrackingCode.MODIFYALL("Man. Expir. Date Entry Reqd.", false); //HEI.30

        //HEI.28<<
        COMMIT; // Ensure all setup changes are committed before test execution
    end;

    procedure RefreshProductionOrder(var "Production Order": Record "Production Order");
    var
        CalcProdOrder: Codeunit "Calculate Prod. Order";
        CreateProdOrderLines: Codeunit "Create Prod. Order Lines";
        WhseProdRelease: Codeunit "Whse.-Production Release";
        WhseOutputProdRelease: Codeunit "Whse.-Output Prod. Release";
        Window: Dialog;
        Direction: Option Forward,Backward;
        CreateInbRqst: Boolean;
        ProdOrder: Record "Production Order";
        //CreateInProcessTest: Codeunit "Create In Proc. Test";//BC UPGRADE PATHAA02-DIT-CU2031200
        //BrewingManagement: Codeunit "Brewing Management";//C UPGRADE PATHAA02-DIT-CU2035150
        ProdOrderSet: Boolean;
        //QualitySetup: Record "Quality Setup";//T2035095
        Item: Record Item;
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
        ProdOrderComp: Record "Prod. Order Component";
        Family: Record Family;
        ProdOrderStatusMgt: Codeunit "Prod. Order Status Management";
        RoutingNo: Code[20];
        ErrorOccured: Boolean;
        // CompTrackingEntry: Record "Comp. Tracking Entry";//C UPGRADE PATHAA02-T2035240
        //QualityTestHEader: Record "Quality Test Header";//C UPGRADE PATHAA02-T2035096
        //BrewingSetup: Record "Production Setup";//C UPGRADE PATHAA02T2035140
        //ProductGroup: Record "Product Group";//BC UPGRADE PATHAA02-Deprecated in BC
        // NoSeriesMgt: Codeunit NoSeriesManagement; //BC UPGRADE PATHAA02
        NoSeriesMgt: Codeunit "No. Series"; //BC UPGRADE PATHAA02
        lrSKU: Record "Stockkeeping Unit";
        RoutingLine: Record "Routing Line";
        ProdOrderLineL: Record "Prod. Order Line";
        Text000: TextConst ENU = 'Refreshing Production Orders...\\', FRA = 'Actualisation des O.F....\\';
        Text001: TextConst ENU = 'Status         #1##########\', FRA = 'Statut         #1##########\';
        Text002: TextConst ENU = 'No.            #2##########', FRA = 'N°             #2##########';
        Text003: TextConst ENU = 'Routings must be calculated, when lines are calculated.', FRA = 'Lorsque les lignes sont calculées, les gammes doivent l''être aussi.';
        Text004: TextConst ENU = 'Component Need must be calculated, when lines are calculated.', FRA = 'Lorsque les lignes sont calculées, les besoins en composants doivent l''être aussi.';
        Text005: TextConst ENU = 'One or more of the lines on this %1 require special warehouse handling. The %2 for these lines has been set to blank.', FRA = 'Une ou plusieurs lignes de ce %1 requièrent un délai entrepôt spécial. Le %2 pour ces lignes a été défini sur une valeur vide.';
        DeletePickedLinesQst: TextConst Comment = 'Production order no.: Components for production order 101001 have already been picked. Do you want to continue?', ENU = 'Components for production order %1 have already been picked. Do you want to continue?', FRA = 'Des composants pour l''ordre de fabrication %1 ont déjà été prélevés. Voulez-vous continuer ?';
        Text2035100: TextConst ENU = 'You cannot refresh the %1 because there exists at least one %2.', FRA = 'Vous ne pouvez pas rafraîchir le %1 car il existe au moins un %2.';
        IBM: text[30];
    begin
        if "Production Order".Status = "Production Order".Status::Finished then
            exit;

        CalcLines := true;
        CalcRoutings := true;
        CalcComponents := true;
        Direction := Direction::Backward;

        if Direction = Direction::Backward then
            "Production Order".TESTFIELD("Due Date");

        if CalcLines and IsComponentPicked("Production Order") then
            if not CONFIRM(STRSUBSTNO(DeletePickedLinesQst, "Production Order"."No.")) then
                exit;

        // "Production Order"."Actual Quantity" := 0; //BC UPGRADE PATHAA02-DIT-T5405-F2035251
        // "Production Order"."Original Quantity" := "Production Order".Quantity; //BC UPGRADE PATHAA02-DIT-T5405-F2035256
        "Production Order".MODIFY;

        RoutingNo := "Production Order"."Routing No.";
        case "Production Order"."Source Type" of
            "Production Order"."Source Type"::Item:
                if Item.GET("Production Order"."Source No.") then begin
                    if lrSKU.GET("Production Order"."Location Code", "Production Order"."Source No.", '') then
                        RoutingNo := lrSKU."Routing No."
                    else
                        RoutingNo := Item."Routing No.";
                end;
            "Production Order"."Source Type"::Family:
                if Family.GET("Production Order"."Source No.") then
                    RoutingNo := Family."Routing No.";
        end;
        if (RoutingNo <> "Production Order"."Routing No.") and ("Production Order"."Routing No." = '') then begin

            "Production Order".VALIDATE("Routing No.", RoutingNo);
            "Production Order".MODIFY;
        end;

        ProdOrderLine.LOCKTABLE;

        CheckReservationExist("Production Order");

        if CalcLines then begin
            if not CreateProdOrderLines.Copy("Production Order", Direction, '', false) then
                ErrorOccured := true;
        end else begin
            ProdOrderLine.SETRANGE(Status, "Production Order".Status);
            ProdOrderLine.SETRANGE("Prod. Order No.", "Production Order"."No.");
            if CalcRoutings or CalcComponents then begin
                if ProdOrderLine.FIND('-') then
                    repeat
                        if CalcRoutings then begin
                            ProdOrderRtngLine.SETRANGE(Status, "Production Order".Status);
                            ProdOrderRtngLine.SETRANGE("Prod. Order No.", "Production Order"."No.");
                            ProdOrderRtngLine.SETRANGE("Routing Reference No.", ProdOrderLine."Routing Reference No.");
                            ProdOrderRtngLine.SETRANGE("Routing No.", ProdOrderLine."Routing No.");
                            if ProdOrderRtngLine.FINDSET(true) then
                                repeat
                                    ProdOrderRtngLine.SetSkipUpdateOfCompBinCodes(true);
                                    ProdOrderRtngLine.DELETE(true);
                                until ProdOrderRtngLine.NEXT = 0;
                        end;
                        if CalcComponents then begin
                            ProdOrderComp.SETRANGE(Status, "Production Order".Status);
                            ProdOrderComp.SETRANGE("Prod. Order No.", "Production Order"."No.");
                            ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                            ProdOrderComp.DELETEALL(true);
                        end;
                    until ProdOrderLine.NEXT = 0;
                if ProdOrderLine.FIND('-') then
                    repeat
                        if CalcComponents then
                            CheckProductionBOMStatus(ProdOrderLine."Production BOM No.", ProdOrderLine."Production BOM Version Code");
                        if CalcRoutings then
                            CheckRoutingStatus(ProdOrderLine."Routing No.", ProdOrderLine."Routing Version Code");
                        ProdOrderLine."Due Date" := "Production Order"."Due Date";
                        if not CalcProdOrder.Calculate(ProdOrderLine, Direction, CalcRoutings, CalcComponents, false, false) then
                            ErrorOccured := true;
                    until ProdOrderLine.NEXT = 0;
            end;
        end;
        if (Direction = Direction::Backward) and
           ("Production Order"."Source Type" = "Production Order"."Source Type"::Family)
        then begin
            "Production Order".SetUpdateEndDate;
            "Production Order".VALIDATE("Due Date", "Production Order"."Due Date");
        end;

        if "Production Order".Status = "Production Order".Status::Released then begin
            ProdOrderStatusMgt.FlushProdOrder("Production Order", "Production Order".Status, WORKDATE);
            WhseProdRelease.Release("Production Order");
            if CreateInbRqst then
                WhseOutputProdRelease.Release("Production Order");
            //     //BC UPGRADE PATHAA02-DIT>>
            // if QualitySetup.READPERMISSION then begin
            //     QualityTestHEader.RESET;
            //     QualityTestHEader.SETRANGE("Source Type", DATABASE::"Production Order");
            //     QualityTestHEader.SETRANGE("Source Subtype", "Production Order".Status);
            //     QualityTestHEader.SETRANGE("Source ID", "Production Order"."No.");
            //     QualityTestHEader.SETFILTER(Status, '<>%1', QualityTestHEader.Status::Quarantine);
            //     if QualityTestHEader.FIND('-') then
            //         ERROR(Text2035100, "Production Order".TABLENAME, QualityTestHEader.TABLENAME)
            //     else begin
            //         QualityTestHEader.SETRANGE(Status, QualityTestHEader.Status::Quarantine);
            //         QualityTestHEader.DELETEALL;
            //         ProdOrderLine.SETRANGE(Status, "Production Order".Status);
            //         ProdOrderLine.SETRANGE("Prod. Order No.", "Production Order"."No.");
            //         if ProdOrderLine.FIND('-') then
            //             repeat
            //                 ProdOrderRtngLine.SETRANGE(Status, "Production Order".Status);
            //                 ProdOrderRtngLine.SETRANGE("Prod. Order No.", "Production Order"."No.");
            //                 ProdOrderRtngLine.SETRANGE("Routing Reference No.", ProdOrderLine."Routing Reference No.");
            //                 ProdOrderRtngLine.SETRANGE("Routing No.", ProdOrderLine."Routing No.");
            //                 if ProdOrderRtngLine.FIND('-') then
            //                     repeat
            //                         CreateInProcessTest.RUN(ProdOrderRtngLine);
            //                     until ProdOrderRtngLine.NEXT = 0;
            //             until ProdOrderLine.NEXT = 0;
            //     end;
            // end;
            // if BrewingSetup.READPERMISSION then begin
            //     BrewingManagement.GetProductGroup("Production Order"."Source No.", ProductGroup);
            //     if ProductGroup."Gyle No. Mandatory" then begin
            //         if "Production Order"."Gyle No." = '' then begin
            //             BrewingSetup.GET;
            //             BrewingSetup.TESTFIELD("Production Tracking Nos.");
            //             NoSeriesMgt.InitSeries(BrewingSetup."Production Tracking Nos.", "Production Order"."Gyle No. Series", TODAY,
            //                                    "Production Order"."Gyle No.", "Production Order"."Gyle No. Series");
            //         end;
            //     end;
            // end;
            //BC UPGRADE PATHAA02-DIT<<
        end;
        //BC UPGRADE PATHAA02-DIT>>
        // if CompTrackingEntry.READPERMISSION then begin
        //     CompTrackingEntry.RESET;
        //     CompTrackingEntry.SETRANGE("Source Type", DATABASE::"Prod. Order Component");
        //     CompTrackingEntry.SETRANGE("Source Subtype", "Production Order".Status);
        //     CompTrackingEntry.SETRANGE("Source ID", "Production Order"."No.");
        //     CompTrackingEntry.DELETEALL;
        //     ProdOrderComp.SETRANGE(Status, "Production Order".Status);
        //     ProdOrderComp.SETRANGE("Prod. Order No.", "Production Order"."No.");
        //     ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
        //     if ProdOrderComp.FIND('-') then
        //         ProdOrderComp.MODIFYALL("Calculation Required", false);
        // end;
        //BC UPGRADE PATHAA02-DIT<<

        if ErrorOccured then
            MESSAGE(Text005, ProdOrder.TABLECAPTION, ProdOrderLine.FIELDCAPTION("Bin Code"));

        RoutingLine.SETRANGE("Routing No.", "Production Order"."Routing No.");
        // RoutingLine.SETRANGE("Version Code", "Production Order"."Routing Version Code"); //BC UPGRADE PATHAA02-T5405-F2035270
        if RoutingLine.FINDFIRST then begin
            if (RoutingLine."Zone Code FND" <> '') then begin
                "Production Order"."Zone Code FND" := RoutingLine."Zone Code FND";
                if RoutingLine."Bin Code FND" <> '' then
                    "Production Order"."Bin Code" := RoutingLine."Bin Code FND";
                "Production Order".MODIFY;
                ProdOrderLine.SETRANGE(Status, "Production Order".Status);
                ProdOrderLine.SETRANGE("Prod. Order No.", "Production Order"."No.");
                if ProdOrderLine.FIND('-') then
                    repeat
                        ProdOrderLine."Bin Code" := "Production Order"."Bin Code";
                        ProdOrderLine."Zone Code FND" := "Production Order"."Zone Code FND";
                        ProdOrderLine.MODIFY;
                    until ProdOrderLine.NEXT = 0;
            end;
        end;

        ProdOrderLineL.SETRANGE(Status, "Production Order".Status);
        ProdOrderLineL.SETRANGE("Prod. Order No.", "Production Order"."No.");
        if ProdOrderLineL.FIND('-') then begin
            repeat
                ProdOrderLineL.VALIDATE("Ending Date-Time");
                ProdOrderLineL.MODIFY(true);
            until ProdOrderLineL.NEXT = 0;
            "Production Order".VALIDATE("Ending Date", DT2DATE(ProdOrderLineL."Ending Date-Time"));
            "Production Order".MODIFY(true);
        end;
        L_UpdateTileCode("Production Order");
        "Production Order".MODIFY;
    end;

    local procedure IsComponentPicked(var ProdOrder: Record "Production Order"): Boolean;
    var
        ProdOrderComp: Record "Prod. Order Component";
    begin
        ProdOrderComp.SETRANGE(Status, ProdOrder.Status);
        ProdOrderComp.SETRANGE("Prod. Order No.", ProdOrder."No.");
        ProdOrderComp.SETFILTER("Qty. Picked", '<>0');
        exit(not ProdOrderComp.ISEMPTY);
    end;

    local procedure CheckReservationExist(var "Production Order": Record "Production Order");
    var
        ProdOrderLine2: Record "Prod. Order Line";
        ProdOrderComp2: Record "Prod. Order Component";
    begin
        // Not allowed to refresh if reservations exist
        if not (CalcLines or CalcComponents) then
            exit;

        ProdOrderLine2.SETRANGE(Status, "Production Order".Status);
        ProdOrderLine2.SETRANGE("Prod. Order No.", "Production Order"."No.");
        if ProdOrderLine2.FIND('-') then
            repeat
                if CalcLines then begin
                    ProdOrderLine2.CALCFIELDS("Reserved Qty. (Base)");
                    if ProdOrderLine2."Reserved Qty. (Base)" <> 0 then
                        if ShouldCheckReservedQty(
                             ProdOrderLine2."Prod. Order No.", 0, DATABASE::"Prod. Order Line",
                             ProdOrderLine2.Status, ProdOrderLine2."Line No.", DATABASE::"Prod. Order Component")
                        then
                            ProdOrderLine2.TESTFIELD("Reserved Qty. (Base)", 0);
                end;

                if CalcComponents then begin
                    ProdOrderComp2.SETRANGE(Status, ProdOrderLine2.Status);
                    ProdOrderComp2.SETRANGE("Prod. Order No.", ProdOrderLine2."Prod. Order No.");
                    ProdOrderComp2.SETRANGE("Prod. Order Line No.", ProdOrderLine2."Line No.");
                    ProdOrderComp2.SETAUTOCALCFIELDS("Reserved Qty. (Base)");
                    if ProdOrderComp2.FIND('-') then begin
                        repeat
                            if ProdOrderComp2."Reserved Qty. (Base)" <> 0 then
                                if ShouldCheckReservedQty(
                                     ProdOrderComp2."Prod. Order No.", ProdOrderComp2."Line No.",
                                     DATABASE::"Prod. Order Component", ProdOrderComp2.Status,
                                     ProdOrderComp2."Prod. Order Line No.", DATABASE::"Prod. Order Line")
                                then
                                    ProdOrderComp2.TESTFIELD("Reserved Qty. (Base)", 0);
                        until ProdOrderComp2.NEXT = 0;
                    end;
                end;
            until ProdOrderLine2.NEXT = 0;
    end;

    local procedure CheckProductionBOMStatus(ProdBOMNo: Code[20]; ProdBOMVersionNo: Code[20]);
    var
        ProductionBOMHeader: Record "Production BOM Header";
        ProductionBOMVersion: Record "Production BOM Version";
    begin
        if ProdBOMNo = '' then
            exit;

        if ProdBOMVersionNo = '' then begin
            ProductionBOMHeader.GET(ProdBOMNo);
            ProductionBOMHeader.TESTFIELD(Status, ProductionBOMHeader.Status::Certified);
        end else begin
            ProductionBOMVersion.GET(ProdBOMNo, ProdBOMVersionNo);
            ProductionBOMVersion.TESTFIELD(Status, ProductionBOMVersion.Status::Certified);
        end;
    end;

    local procedure CheckRoutingStatus(RoutingNo: Code[20]; RoutingVersionNo: Code[20]);
    var
        RoutingHeader: Record "Routing Header";
        RoutingVersion: Record "Routing Version";
    begin
        if RoutingNo = '' then
            exit;

        if RoutingVersionNo = '' then begin
            RoutingHeader.GET(RoutingNo);
            RoutingHeader.TESTFIELD(Status, RoutingHeader.Status::Certified);
        end else begin
            RoutingVersion.GET(RoutingNo, RoutingVersionNo);
            RoutingVersion.TESTFIELD(Status, RoutingVersion.Status::Certified);
        end;
    end;

    local procedure L_UpdateTileCode(var pProductionOrder: Record "Production Order");
    var
        lRoleCenterTileSetup: Record "Role Center Tile Setup FND";
        lDimensionSetEntry: Record "Dimension Set Entry";
        lStatus: Option Simulated,Planned,"Firm Planned",Released,Finished;
        lProdOrderNo: Code[20];
        ProductionOrder: Record "Production Order";
        lRoleCentreTileCode: Text[30];
    begin

        lRoleCentreTileCode := pProductionOrder."Role Centre Tile Code FND";

        pProductionOrder."Role Centre Tile Code FND" := '';
        lStatus := pProductionOrder.Status;
        lProdOrderNo := pProductionOrder."No.";

        lRoleCenterTileSetup.RESET;
        lRoleCenterTileSetup.SETRANGE("Location Code", pProductionOrder."Location Code");
        lRoleCenterTileSetup.SETRANGE("Zone Code", pProductionOrder."Zone Code FND");
        if lRoleCenterTileSetup.FINDFIRST then
            repeat
                if ((lRoleCenterTileSetup."Dimension Code" = '') and (lRoleCenterTileSetup."Dimension Filter Value" = '')) then
                    pProductionOrder."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";

                if ((lRoleCenterTileSetup."Dimension Code" <> '') or (lRoleCenterTileSetup."Dimension Filter Value" <> '')) then begin
                    lDimensionSetEntry.RESET;
                    lDimensionSetEntry.SETRANGE("Dimension Set ID", pProductionOrder."Dimension Set ID");
                    if (lRoleCenterTileSetup."Dimension Code" <> '') then
                        lDimensionSetEntry.SETRANGE("Dimension Code", lRoleCenterTileSetup."Dimension Code");
                    if (lRoleCenterTileSetup."Dimension Filter Value" <> '') then
                        lDimensionSetEntry.SETFILTER("Dimension Value Code", lRoleCenterTileSetup."Dimension Filter Value");
                    if lDimensionSetEntry.FINDFIRST then
                        pProductionOrder."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";
                end;
            until lRoleCenterTileSetup.NEXT = 0;

        lRoleCenterTileSetup.RESET;
        lRoleCenterTileSetup.SETRANGE("Location Code", pProductionOrder."Location Code");
        lRoleCenterTileSetup.SETRANGE("Zone Code", '');
        if lRoleCenterTileSetup.FINDFIRST then
            repeat
                if ((lRoleCenterTileSetup."Dimension Code" = '') and (lRoleCenterTileSetup."Dimension Filter Value" = '')) then
                    pProductionOrder."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";

                if ((lRoleCenterTileSetup."Dimension Code" <> '') or (lRoleCenterTileSetup."Dimension Filter Value" <> '')) then begin
                    lDimensionSetEntry.RESET;
                    lDimensionSetEntry.SETRANGE("Dimension Set ID", pProductionOrder."Dimension Set ID");
                    if (lRoleCenterTileSetup."Dimension Code" <> '') then
                        lDimensionSetEntry.SETRANGE("Dimension Code", lRoleCenterTileSetup."Dimension Code");
                    if (lRoleCenterTileSetup."Dimension Filter Value" <> '') then
                        lDimensionSetEntry.SETFILTER("Dimension Value Code", lRoleCenterTileSetup."Dimension Filter Value");
                    if lDimensionSetEntry.FINDFIRST then
                        pProductionOrder."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";
                end;
            until lRoleCenterTileSetup.NEXT = 0;


        lRoleCenterTileSetup.RESET;
        lRoleCenterTileSetup.SETRANGE("Location Code", '');
        lRoleCenterTileSetup.SETRANGE("Zone Code", pProductionOrder."Zone Code FND");
        if lRoleCenterTileSetup.FINDFIRST then
            repeat
                if ((lRoleCenterTileSetup."Dimension Code" = '') and (lRoleCenterTileSetup."Dimension Filter Value" = '')) then
                    pProductionOrder."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";

                if ((lRoleCenterTileSetup."Dimension Code" <> '') or (lRoleCenterTileSetup."Dimension Filter Value" <> '')) then begin
                    lDimensionSetEntry.RESET;
                    lDimensionSetEntry.SETRANGE("Dimension Set ID", pProductionOrder."Dimension Set ID");
                    if (lRoleCenterTileSetup."Dimension Code" <> '') then
                        lDimensionSetEntry.SETRANGE("Dimension Code", lRoleCenterTileSetup."Dimension Code");
                    if (lRoleCenterTileSetup."Dimension Filter Value" <> '') then
                        lDimensionSetEntry.SETFILTER("Dimension Value Code", lRoleCenterTileSetup."Dimension Filter Value");
                    if lDimensionSetEntry.FINDFIRST then
                        pProductionOrder."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";
                end;
            until lRoleCenterTileSetup.NEXT = 0;

        lRoleCenterTileSetup.RESET;
        lRoleCenterTileSetup.SETRANGE("Location Code", '');
        lRoleCenterTileSetup.SETRANGE("Zone Code", '');
        if lRoleCenterTileSetup.FINDFIRST then
            repeat
                if ((lRoleCenterTileSetup."Dimension Code" <> '') or (lRoleCenterTileSetup."Dimension Filter Value" <> '')) then begin
                    lDimensionSetEntry.RESET;
                    lDimensionSetEntry.SETRANGE("Dimension Set ID", pProductionOrder."Dimension Set ID");
                    if (lRoleCenterTileSetup."Dimension Code" <> '') then
                        lDimensionSetEntry.SETRANGE("Dimension Code", lRoleCenterTileSetup."Dimension Code");
                    if (lRoleCenterTileSetup."Dimension Filter Value" <> '') then
                        lDimensionSetEntry.SETFILTER("Dimension Value Code", lRoleCenterTileSetup."Dimension Filter Value");
                    if lDimensionSetEntry.FINDFIRST then
                        pProductionOrder."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";
                end;
            until lRoleCenterTileSetup.NEXT = 0;

        if ((pProductionOrder."Role Centre Tile Code FND" = '') and (lRoleCentreTileCode <> '')) then
            pProductionOrder."Role Centre Tile Code FND" := lRoleCentreTileCode;
    end;

    local procedure ShouldCheckReservedQty(ProdOrderNo: Code[20]; LineNo: Integer; SourceType: Integer; Status: Option; ProdOrderLineNo: Integer; SourceType2: Integer): Boolean;
    var
        ReservEntry: Record "Reservation Entry";
    begin

        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with - ReservEntry due to warning.
        // with ReservEntry do begin
        //     SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name");
        //     SETRANGE("Source Batch Name", '');
        //     SETRANGE("Reservation Status", "Reservation Status"::Reservation);
        //     SETRANGE("Source ID", ProdOrderNo);
        //     SETRANGE("Source Ref. No.", LineNo);
        //     SETRANGE("Source Type", SourceType);
        //     SETRANGE("Source Subtype", Status);
        //     SETRANGE("Source Prod. Order Line", ProdOrderLineNo);

        //     if FINDFIRST then begin
        //         GET("Entry No.", not Positive);
        //         exit(
        //           not (("Source Type" = SourceType2) and
        //                ("Source ID" = ProdOrderNo) and ("Source Subtype" = Status)));
        //     end;
        // end;

        //with ReservEntry do begin
        ReservEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name");
        ReservEntry.SETRANGE("Source Batch Name", '');
        ReservEntry.SETRANGE("Reservation Status", "Reservation Status"::Reservation);
        ReservEntry.SETRANGE("Source ID", ProdOrderNo);
        ReservEntry.SETRANGE("Source Ref. No.", LineNo);
        ReservEntry.SETRANGE("Source Type", SourceType);
        ReservEntry.SETRANGE("Source Subtype", Status);
        ReservEntry.SETRANGE("Source Prod. Order Line", ProdOrderLineNo);

        if ReservEntry.FINDFIRST then begin
            ReservEntry.GET(ReservEntry."Entry No.", not ReservEntry.Positive);
            exit(
              not ((ReservEntry."Source Type" = SourceType2) and
                   (ReservEntry."Source ID" = ProdOrderNo) and (ReservEntry."Source Subtype" = Status)));
        end;
        //end;
        // BC Upgrade MISHRS14 <<

        exit(false);
    end;

    procedure UpdateInvDTWSetInputValue(ItemNoCode: Code[20]; LocationNoCode: Code[20]; ZoneNoCode: Code[20]; BinNoCode: Code[20]; CInputQty: Decimal; CDocumentNo: Code[20]; CLotNo: Code[20]);
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
        RoutingLine: Record "Routing Line";
        WorkCenter: Record "Work Center";
        Bin: Record Bin;
        ProductionBOMLine: Record "Production BOM Line";
        ProductionBOMVersion: Record "Production BOM Version";
        //QualitySetup: Record "Quality Setup"; //BC UPGRADE PATHAA02-DIT
        Item: Record Item;
        Location: Record Location;
        Zone: Record Zone;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        ItemJournalLine: Record "Item Journal Line";
        TrackingSpecification: Record "Tracking Specification";
        ReservationEntry: Record "Reservation Entry";
        ItemNo: Code[20];
        LocationCode: Code[20];
        ZoneCode: Code[20];
        BinCode: Code[20];
        InputQty: Integer;
        EntryType: Option Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        DocumentNo: Code[20];
        ItemUOM: Code[10];
        LotNo: Code[10];
        LastEntryNo: Integer;
        LastResvEntryNo: Integer;
        VersionCode: Code[20];
        ItemCCC: Record Item;
        Item2: Record Item;
    begin
        ItemNo := ItemNoCode;
        LocationCode := LocationNoCode;
        ZoneCode := ZoneNoCode;
        BinCode := BinNoCode;
        InputQty := CInputQty;
        EntryType := EntryType::"Positive Adjmt.";
        DocumentNo := CDocumentNo;
        LotNo := CLotNo;

        EntryType := EntryType::"Positive Adjmt.";
        StockkeepingUnit.RESET;
        StockkeepingUnit.SETRANGE("Item No.", ItemNo);
        StockkeepingUnit.SETRANGE("Location Code", LocationCode);
        if StockkeepingUnit.FINDFIRST then begin
            RoutingLine.RESET;
            RoutingLine.SETRANGE("Routing No.", StockkeepingUnit."Routing No.");
            if RoutingLine.FINDFIRST then begin
                WorkCenter.GET(RoutingLine."Work Center No.");
                if WorkCenter."To-Production Bin Code" <> '' then
                    BinCode := WorkCenter."To-Production Bin Code";
                Bin.GET(LocationCode, BinCode);
                ZoneCode := Bin."Zone Code";
            end;
            ProductionBOMVersion.RESET;
            ProductionBOMVersion.SETRANGE("Production BOM No.", StockkeepingUnit."Production BOM No.");
            ProductionBOMVersion.SETRANGE("Active FND", true);
            if ProductionBOMVersion.FINDFIRST then
                VersionCode := ProductionBOMVersion."Version Code";
            ProductionBOMLine.RESET;
            ProductionBOMLine.SETRANGE("Production BOM No.", StockkeepingUnit."Production BOM No.");
            ProductionBOMLine.SETRANGE("Version Code", VersionCode);
            ProductionBOMLine.SETRANGE(Type, ProductionBOMLine.Type::Item);
            ProductionBOMLine.SETFILTER("Quantity per", '>%1', 0);

            // BC Upgrade MISHRS14 >>
            // Removed false from FINDSET due to warning because its being depreceted
            //if ProductionBOMLine.FINDSET(false, false) then
            if ProductionBOMLine.FINDSET(false) then
                // BC Upgrade MISHRS14 <<

                repeat
                    if Item2.GET(ProductionBOMLine."No.") and not Item2.Blocked then begin
                        ItemJournalLine.RESET;
                        ItemJournalLine.SETRANGE("Journal Template Name", 'ITEM');
                        ItemJournalLine.SETRANGE("Journal Batch Name", 'DEFAULT');
                        if ItemJournalLine.FINDSET then
                            ItemJournalLine.DELETEALL;
                        Item.GET(ProductionBOMLine."No.");
                        ItemJournalLine.INIT;
                        ItemJournalLine.VALIDATE("Journal Template Name", 'ITEM');
                        ItemJournalLine.VALIDATE("Journal Batch Name", 'DEFAULT');
                        ItemJournalLine."Line No." := 10000;
                        ItemJournalLine.INSERT(true);
                        ItemJournalLine.VALIDATE("Posting Date", TODAY);
                        ItemJournalLine.VALIDATE("Entry Type", EntryType);
                        ItemJournalLine.VALIDATE("Document No.", DocumentNo);
                        ItemJournalLine.VALIDATE("Item No.", ProductionBOMLine."No.");
                        ItemJournalLine.VALIDATE("Location Code", LocationCode);
                        ItemJournalLine.VALIDATE("Zone Code FND", ZoneCode);
                        ItemJournalLine.VALIDATE("Bin Code", BinCode);
                        ItemJournalLine.VALIDATE(Quantity, InputQty);
                        if ItemJournalLine."Shortcut Dimension 2 Code" = '' then
                            ItemJournalLine.VALIDATE("Shortcut Dimension 2 Code", Item."Global Dimension 2 Code");

                        if (ItemJournalLine."Shortcut Dimension 2 Code" = '') and (Item."Global Dimension 2 Code" = '') then begin
                            ItemCCC.RESET;
                            ItemCCC.SETRANGE("Item Category Code", Item."Item Category Code");
                            ItemCCC.SETFILTER("Global Dimension 2 Code", '<>%1', '');
                            // ItemCCC.SETRANGE("Gen. Prod. Posting Free Group", Item."Gen. Prod. Posting Free Group");//BC UPGRADE PATHAA02-F2013824
                            ItemCCC.SETRANGE("Inventory Posting Group", Item."Inventory Posting Group");
                            if ItemCCC.FINDFIRST then
                                ItemJournalLine.VALIDATE("Shortcut Dimension 2 Code", ItemCCC."Global Dimension 2 Code");
                        end;
                        ItemJournalLine.MODIFY;

                        TrackingSpecification.RESET;
                        TrackingSpecification.LOCKTABLE;
                        if TrackingSpecification.FINDLAST then
                            LastEntryNo := TrackingSpecification."Entry No.";

                        if Item."Item Tracking Code" <> '' then begin
                            TrackingSpecification.INIT;
                            TrackingSpecification."Entry No." := LastEntryNo + 1;
                            TrackingSpecification.INSERT;

                            TrackingSpecification."Source ID" := ItemJournalLine."Journal Template Name";
                            TrackingSpecification."Source Batch Name" := ItemJournalLine."Journal Batch Name";
                            TrackingSpecification."Source Type" := DATABASE::"Item Journal Line";
                            TrackingSpecification."Source Subtype" := 2;
                            TrackingSpecification.VALIDATE("Item No.", ProductionBOMLine."No.");
                            TrackingSpecification.VALIDATE("Location Code", LocationCode);
                            TrackingSpecification.VALIDATE("Quantity Handled (Base)", 0);
                            TrackingSpecification.VALIDATE("Quantity Invoiced (Base)", 0);
                            TrackingSpecification.VALIDATE("Lot No.", LotNo);
                            TrackingSpecification.VALIDATE("Quantity (Base)", ItemJournalLine."Quantity (Base)");
                            TrackingSpecification."Zone Code FND" := ZoneCode;
                            TrackingSpecification."Bin Code" := BinCode;
                            TrackingSpecification.Description := Item.Description;
                            TrackingSpecification."Expiration Date" := CALCDATE('<+12M>', TODAY);
                            TrackingSpecification.MODIFY;

                            ReservationEntry.RESET;
                            ReservationEntry.LOCKTABLE;
                            if ReservationEntry.FINDLAST then
                                LastResvEntryNo := ReservationEntry."Entry No.";

                            ReservationEntry.INIT;
                            ReservationEntry.VALIDATE("Entry No.", LastResvEntryNo + 1);
                            ReservationEntry.VALIDATE("Item No.", ProductionBOMLine."No.");
                            ReservationEntry.INSERT(true);
                            ReservationEntry.VALIDATE("Location Code", LocationCode);
                            ReservationEntry.VALIDATE("Quantity (Base)", ItemJournalLine."Quantity (Base)");
                            ReservationEntry.VALIDATE("Reservation Status", ReservationEntry."Reservation Status"::Prospect);
                            ReservationEntry.VALIDATE("Creation Date", TODAY);
                            ReservationEntry.VALIDATE("Created By", USERID);
                            ReservationEntry.VALIDATE("Source Type", TrackingSpecification."Source Type");
                            ReservationEntry.VALIDATE("Source Subtype", TrackingSpecification."Source Subtype");
                            ReservationEntry.VALIDATE("Source ID", TrackingSpecification."Source ID");
                            ReservationEntry.VALIDATE("Source Batch Name", TrackingSpecification."Source Batch Name");
                            ReservationEntry."Source Ref. No." := 10000;
                            ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Lot No.";
                            ReservationEntry.VALIDATE("Lot No.", LotNo);
                            // ReservationEntry.VALIDATE("Bin Code", BinCode);//BC UPGRADE-DIT-F2035191
                            ReservationEntry."Expiration Date" := CALCDATE('<+12M>', TODAY);
                            ReservationEntry.MODIFY;
                        end;
                        COMMIT;
                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Batch", ItemJournalLine);
                    end;
                until ProductionBOMLine.NEXT = 0;
        end;

        MESSAGE('Completed');
    end;

    procedure UpdateItemInvDTW2InitParameters(ItemNoP: Code[20]; LocationCodeP: Code[20]; ZoneCodeP: Code[20]; BinCodeP: Code[20]; InputQtyP: Integer; DocumentNoP: Code[20]; LotNoP: Code[10]);
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
        RoutingLine: Record "Routing Line";
        WorkCenter: Record "Work Center";
        Bin: Record Bin;
        ProductionBOMLine: Record "Production BOM Line";
        ProductionBOMVersion: Record "Production BOM Version";
        //QualitySetup: Record "Quality Setup";//DIT-Tab2035095-BC UPGRADE PATHAA02
        Item: Record Item;
        Location: Record Location;
        Zone: Record Zone;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        ItemJournalLine: Record "Item Journal Line";
        TrackingSpecification: Record "Tracking Specification";
        ReservationEntry: Record "Reservation Entry";
        ItemNo: Code[20];
        LocationCode: Code[20];
        ZoneCode: Code[20];
        BinCode: Code[20];
        InputQty: Integer;
        EntryType: Option Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        DocumentNo: Code[20];
        ItemUOM: Code[10];
        LotNo: Code[10];
        LastEntryNo: Integer;
        LastResvEntryNo: Integer;
        VersionCode: Code[20];
        ItemCCC: Record Item;
    begin
        ItemNo := ItemNoP;
        LocationCode := LocationCodeP;
        ZoneCode := ZoneCodeP;
        BinCode := BinCodeP;
        InputQty := InputQtyP;
        DocumentNo := DocumentNoP;
        LotNo := LotNoP;

        EntryType := EntryType::"Positive Adjmt.";
        ItemJournalLine.RESET;
        ItemJournalLine.SETRANGE("Journal Template Name", 'ITEM');
        ItemJournalLine.SETRANGE("Journal Batch Name", 'DEFAULT');
        if ItemJournalLine.FINDSET then
            ItemJournalLine.DELETEALL;

        Item.GET(ItemNo);
        ItemJournalLine.INIT;
        ItemJournalLine.VALIDATE("Journal Template Name", 'ITEM');
        ItemJournalLine.VALIDATE("Journal Batch Name", 'DEFAULT');
        ItemJournalLine."Line No." := 10000;
        ItemJournalLine.INSERT(true);
        ItemJournalLine.VALIDATE("Posting Date", TODAY);
        ItemJournalLine.VALIDATE("Entry Type", EntryType);
        ItemJournalLine.VALIDATE("Document No.", DocumentNo);
        ItemJournalLine.VALIDATE("Item No.", ItemNo);
        ItemJournalLine.VALIDATE("Location Code", LocationCode);
        ItemJournalLine.VALIDATE("Zone Code FND", ZoneCode);
        ItemJournalLine.VALIDATE("Bin Code", BinCode);
        ItemJournalLine.VALIDATE(Quantity, InputQty);
        if ItemJournalLine."Shortcut Dimension 2 Code" = '' then
            ItemJournalLine.VALIDATE("Shortcut Dimension 2 Code", Item."Global Dimension 2 Code");

        if (ItemJournalLine."Shortcut Dimension 2 Code" = '') and (Item."Global Dimension 2 Code" = '') then begin
            ItemCCC.RESET;
            ItemCCC.SETRANGE("Item Category Code", Item."Item Category Code");
            ItemCCC.SETFILTER("Global Dimension 2 Code", '<>%1', '');
            //ItemCCC.SETRANGE("Gen. Prod. Posting Free Group", Item."Gen. Prod. Posting Free Group"); //BC UPGRADE PATHAA02-F2013824
            ItemCCC.SETRANGE("Inventory Posting Group", Item."Inventory Posting Group");
            if ItemCCC.FINDFIRST then
                ItemJournalLine.VALIDATE("Shortcut Dimension 2 Code", ItemCCC."Global Dimension 2 Code");
        end;
        ItemJournalLine.MODIFY;

        TrackingSpecification.RESET;
        TrackingSpecification.LOCKTABLE;
        if TrackingSpecification.FINDLAST then
            LastEntryNo := TrackingSpecification."Entry No.";

        if Item."Item Tracking Code" <> '' then begin
            TrackingSpecification.INIT;
            TrackingSpecification."Entry No." := LastEntryNo + 1;
            TrackingSpecification.INSERT;

            TrackingSpecification."Source ID" := ItemJournalLine."Journal Template Name";
            TrackingSpecification."Source Batch Name" := ItemJournalLine."Journal Batch Name";
            TrackingSpecification."Source Type" := DATABASE::"Item Journal Line";
            TrackingSpecification."Source Subtype" := 2;
            TrackingSpecification.VALIDATE("Item No.", ItemNo);
            TrackingSpecification.VALIDATE("Location Code", LocationCode);
            TrackingSpecification.VALIDATE("Quantity Handled (Base)", 0);
            TrackingSpecification.VALIDATE("Quantity Invoiced (Base)", 0);
            TrackingSpecification.VALIDATE("Lot No.", LotNo);
            TrackingSpecification.VALIDATE("Quantity (Base)", ItemJournalLine."Quantity (Base)");
            TrackingSpecification."Zone Code FND" := ZoneCode;
            TrackingSpecification."Bin Code" := BinCode;
            TrackingSpecification.Description := Item.Description;
            TrackingSpecification."Expiration Date" := CALCDATE('<+12M>', TODAY);
            TrackingSpecification.MODIFY;

            ReservationEntry.RESET;
            ReservationEntry.LOCKTABLE;
            if ReservationEntry.FINDLAST then
                LastResvEntryNo := ReservationEntry."Entry No.";

            ReservationEntry.INIT;
            ReservationEntry.VALIDATE("Entry No.", LastResvEntryNo + 1);
            ReservationEntry.VALIDATE("Item No.", ItemNo);
            ReservationEntry.INSERT(true);
            ReservationEntry.VALIDATE("Location Code", LocationCode);
            ReservationEntry.VALIDATE("Quantity (Base)", ItemJournalLine."Quantity (Base)");
            ReservationEntry.VALIDATE("Reservation Status", ReservationEntry."Reservation Status"::Prospect);
            ReservationEntry.VALIDATE("Creation Date", TODAY);
            ReservationEntry.VALIDATE("Created By", USERID);
            ReservationEntry.VALIDATE("Source Type", TrackingSpecification."Source Type");
            ReservationEntry.VALIDATE("Source Subtype", TrackingSpecification."Source Subtype");
            ReservationEntry.VALIDATE("Source ID", TrackingSpecification."Source ID");
            ReservationEntry.VALIDATE("Source Batch Name", TrackingSpecification."Source Batch Name");
            ReservationEntry."Source Ref. No." := 10000;
            ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Lot No.";
            ReservationEntry."Expiration Date" := CALCDATE('<+12M>', TODAY);
            ReservationEntry.VALIDATE("Lot No.", LotNo);
            //ReservationEntry.VALIDATE("Bin Code", BinCode); //BC UPGRADE-DIT-F2035191
            ReservationEntry.MODIFY;
        end;

        COMMIT;
        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Batch", ItemJournalLine);


        MESSAGE('Completed');
    end;

    //PATHAA02-23.05.26>> //PRD011
    [ConfirmHandler]
    procedure ConfirmationHandler_ItemtrackingAptean(Question: Text[1024]; var Reply: Boolean);
    begin
        if StrPos(Question, 'Do you want to update the source line with the quantity/strength entered on tracking?') > 0 then begin
            Reply := true;
            exit;
        end;
        Reply := true;
    end;
    //PATHAA02-23.05.26<<
    //PATHAA02.25.05.25>> //PRDE14
    [ModalPageHandler]
    procedure ProdBOMVersionListModalPageHandler(var ProdBOMVersionList: TestPage "Prod. BOM Version List")
    begin
        ProdBOMVersionList.OK.INVOKE;
    end;

    //PATHAA02 25.05.26<< //PRDE14

    //PATHAA02 23.05.26>> //PRDE16
    [ModalPageHandler]
    procedure RoutingVersionListModalPageHandler(var RoutingVersionList: TestPage "Routing Version List")
    begin
        RoutingVersionList.OK.INVOKE;
    end;
    //PATHAA02 23.05.26<< //PRDE16

    procedure CheckStocinBin(var ProdOrderComponentLpar: Record "Prod. Order Component");
    var
        BinContent: Record "Bin Content";
        BinContent1: Record "Bin Content";
    begin
        //HEI.41
        BinContent.RESET;
        BinContent.SETRANGE("Item No.", ProdOrderComponentLpar."Item No.");
        BinContent.SETRANGE("Location Code", ProdOrderComponentLpar."Location Code");
        BinContent.SETRANGE("Zone Code", ProdOrderComponentLpar."Zone Code FND");
        BinContent.SETRANGE("Bin Code", ProdOrderComponentLpar."Bin Code");
        if not BinContent.FINDFIRST then begin
            BinContent1.RESET;
            BinContent1.SETRANGE("Item No.", ProdOrderComponentLpar."Item No.");
            BinContent1.SETRANGE("Location Code", ProdOrderComponentLpar."Location Code");
            BinContent1.SETRANGE("Zone Code", ProdOrderComponentLpar."Zone Code FND");
            if BinContent1.FINDSET then
                repeat
                    BinContent1.CALCFIELDS(Quantity);
                    if BinContent1.Quantity > 0 then begin
                        ProdOrderComponentLpar."Bin Code" := BinContent1."Bin Code";
                        ProdOrderComponentLpar.MODIFY;
                        exit;
                    end;
                until BinContent1.NEXT = 0;
        end;
    end;

    [Normal]
    procedure DeleteComponentIfInsufficientQty(var ProdOrderComponentL: Record "Prod. Order Component"; LotNo: Code[50]);
    var
        Item: Record Item;
        bincontent: Record "Bin Content";
    begin
        //HEI.53>>
        Item.GET(ProdOrderComponentL."Item No.");
        bincontent.GET(ProdOrderComponentL."Location Code", ProdOrderComponentL."Bin Code", ProdOrderComponentL."Item No.", '', Item."Base Unit of Measure");
        bincontent.SETRANGE("Lot No. Filter", LotNo);
        bincontent.CALCFIELDS("Quantity (Base)");
        //HEI.54>>
        //IF ROUND(bincontent."Quantity (Base)", 0.01) < ProdOrderComponentL."Quantity (Base)" THEN
        if ROUND(bincontent."Quantity (Base)", 0.01) <= ProdOrderComponentL."Quantity (Base)" then
            //HEI.54<<
            ProdOrderComponentL.DELETE;
        //HEI.53<<
    end;
    // //yk>>
    // procedure Fortestscriptfix(): Code[20] //yk
    // var
    //     InventorySetup: Record "Inventory Setup";
    // begin
    //     InventorySetup.get();
    //     InventorySetup."Lotcheck" := true;
    //     InventorySetup.MODIFY(false);
    //     exit(InventorySetup.UT_LOTNO);
    // end;

    // var
    //     Lotnotest: Code[20];
    //     checklot: Boolean;
    //     InventorySetupL: Record "Inventory Setup";
    // //yk<<
}

