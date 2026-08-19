codeunit 51022 "CAL Test RT DynamicQ CBN"
{
    // version TS,HEI.02

    // HEI.01 RITM2923302 IBM SAXENA03 05/04/2022
    //   # CodeUnit is developed to RUN All Test Scripts for Dynamic Q system.
    // HEI.02 CHG2185291 IBM SAXENA03 15.05.2023
    //   # Added code for Consolidation of Test Script objects

    // BC UPGRADE PATELS08 >>
    // # Changed the Global variables type from Custom to inbuilt Test Scripts.
    // # Replaced Variable-CALTestMgtHNK with TestScriptsBCUpgrade as HNK custom functions- AddTestLineHNK,SkipTestLineHNK sre now defined in CU-TestScriptsBCUpgrade.
    // BC UPGRADE PATELS08 <<

    trigger OnRun();
    begin
    end;

    var
        DocRefNo: Text[50];
        // BC UPGRADE PATELS08 >> Changed the Global variables type from Custom to inbuilt Test Scripts.
        // CALTestMgtHNK : Codeunit "CAL Test Management HNK";
        // CALTestSuite : Record "CAL Test Suite HNK";
        // CALTestLineHNK : Record "CAL Test Line HNK";
        CALTestMgt: Codeunit "CAL Test Management";
        CALTestSuite: Record "CAL Test Suite";
        CALTestLine: Record "CAL Test Line";
        TestScriptsBCUpgradeCBN: Codeunit "TestScriptsBCUpgradeCBN";
    // BC UPGRADE PATELS08 <<

    local procedure DtWTestScripts();
    begin
        // BC UPGRADE KAPOOV01 Replaced Variable-CALTestMgtHNK with TestScriptsBCUpgrade as HNK custom function- AddTestLineHNK is now defined in CU-TestScriptsBCUpgrade >>
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD001_CreateFPPOforWort_Brew_1',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD004_CheckDefaultRouting_Brew_2',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD005_AdjustRouting_Brew_3',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD013_AdjustBOM_Brew_4',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD006_ChangeStatustoRPO_Brew_5',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD011_EnterConsumQtywithLotSelection_Brew_6',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD010_ConsumeComponent&Produce Product_Brew_7',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD008_CorrectConsumedorProducedQuantities_Brew_8',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD083_FinishRPO_Brew_9',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD071_CreateFPPO_Packaging_1',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD074_CheckDefaultRouting_Packaging_2',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD075_AdjustRouting_Packaging_3',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD077_FPPOAdjustBOM_Packaging_4',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD076_FPPO-ChangeStatustoRPO_Packaging_5',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD081_EnterConsumQtywithLotSelection_Packaging_6',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD078_ConsumeComponentProduce Product_Packaging_7',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD070_CorrectConsumedorProducedQuantities_Packaging_8',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD083_FinishRPO_Packaging_9',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD080_MoveFPstoLogistics_Packaging_10',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD042-CreateRPO_FilterCapacity_1',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD040_CheckDefaultRouting_FilterCapacity_2',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD041_AdjustRouting_FilterCapacity_3',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD022_AdjustBOM_FilterCapacity_4',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD051_EnterConsumQtyToLotSelectionRPO_FilterCapacity_5',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD047_ConsumeComponentsProduceProducts_FilterCapacity_6',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD046_CorrectConsumedorProducedQuantities_FilterCapacity_7',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD052_FinsihRPO_FilterCapacity_8',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD055_CreateRPO_FilterationMixing_1',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD053_CheckDefaultRouting_FilterationMixing_2',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD054_AdjustRouting_FilterationMixing_3',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD066_AdjustBOM_FilterationMixing_4',true,DocRefNo);

        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD001_CreateFPPOforWort_Brew_1', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD004_CheckDefaultRouting_Brew_2', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD005_AdjustRouting_Brew_3', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD013_AdjustBOM_Brew_4', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD006_ChangeStatustoRPO_Brew_5', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD011_EnterConsumQtywithLotSelection_Brew_6', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD010_ConsumeComponent&Produce Product_Brew_7', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD008_CorrectConsumedorProducedQuantities_Brew_8', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD083_FinishRPO_Brew_9', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD071_CreateFPPO_Packaging_1', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD074_CheckDefaultRouting_Packaging_2', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD075_AdjustRouting_Packaging_3', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD077_FPPOAdjustBOM_Packaging_4', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD076_FPPO-ChangeStatustoRPO_Packaging_5', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD081_EnterConsumQtywithLotSelection_Packaging_6', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD078_ConsumeComponentProduce Product_Packaging_7', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD070_CorrectConsumedorProducedQuantities_Packaging_8', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD083_FinishRPO_Packaging_9', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD080_MoveFPstoLogistics_Packaging_10', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD042-CreateRPO_FilterCapacity_1', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD040_CheckDefaultRouting_FilterCapacity_2', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD041_AdjustRouting_FilterCapacity_3', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD022_AdjustBOM_FilterCapacity_4', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD051_EnterConsumQtyToLotSelectionRPO_FilterCapacity_5', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD047_ConsumeComponentsProduceProducts_FilterCapacity_6', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD046_CorrectConsumedorProducedQuantities_FilterCapacity_7', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD052_FinsihRPO_FilterCapacity_8', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD055_CreateRPO_FilterationMixing_1', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD053_CheckDefaultRouting_FilterationMixing_2', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD054_AdjustRouting_FilterationMixing_3', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD066_AdjustBOM_FilterationMixing_4', true, DocRefNo);
        // BC UPGRADE KAPOOV01 Replaced Variable-CALTestMgtHNK with TestScriptsBCUpgrade as HNK custom function- AddTestLineHNK is now defined in CU-TestScriptsBCUpgrade <<

        /*
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD059_ResourceSelectionOfAvailableTanks_FilterationMixing_5',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD067_EnterConsumptionQuantitiesBatchBin_FilterationMixing_6',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD061_ConsumeComponentsProduceProducts_FilterationMixing_7',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD069_FinishRPO_FilterationMixing_8',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD062_ReceiveProductstoQualityHoldstatus_FilterationMixing_9',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD064_ReleaseBrightBeertoPackaging_FilterationMixing_10',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD028_CreateRPO_Cellar_1',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD031_CheckDefaultRouting_Cellar_2',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD032_AdjustRouting_Cellar_3',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD037_AdjustBOM_Cellar_4',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD034_ResourceSelectionofAvailableTanks_Cellar_5',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD035_EnterNegativeConsumptionQuantities_Cellar_6',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD027_EnterConsumptionQuantitiesBatchBin_Cellar_7',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD084_ConsumeComponentsProduceProducts_Cellar_8',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD036_CorrectConsumedorProducedQuantities_Cellar_9',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD015_CreateRPO_Yeast_1',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD018_CheckDefaultRouting_Yeast_2',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD019_AdjustRoutingYeast_Yeast_3',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD022_AdjustBOM_Yeast_4',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD024_EnterConsumptionQty_Yeast_5',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD023_ConsumeComponentsProduceProducts_Yeast_6',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD021_CorrectConsumedorProducedQuantities_Yeast_7',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50172,'RT_PRD026_FinishRPO_Yeast_8',TRUE,DocRefNo);
        */

    end;

    local procedure MtCTestScripts();
    begin
        // BC UPGRADE KAPOOV01 Replaced Variable-CALTestMgtHNK with TestScriptsBCUpgrade as HNK custom function- AddTestLineHNK is now defined in CU-TestScriptsBCUpgrade >>
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50200,'RT_LOG001_CreateDomesticSalesOrder',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50200,'RT_LOG016_ReturnRPMOrder_RoutePlanning',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50200,'RT_LOG017_CreateTransportPlanning',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50200,'RT_LOG023_ReviewDifferenceSettlementOfCustomer',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50200,'RT_LOG004_CreateFreeProductSalesOrder',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50200,'RT_OTC001_CreateCustomerInvoice_ManualCreation_SingleOrderInvoicing',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50200,'RT_OTC011_GenerateCopyOfTheInvoiceFromTheSystem',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50200,'RT_OTC022_IssueCustomerBonusCreditMemo_3rdPartyBonusCalculation',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50200,'RT_OTC017_CreateCustomerCreditMemo_QuantityCorrection_GoodsLost_GoodsDamaged_QualityIssues',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50200,'RT_OTC018_CreateCustomerDebitOrCreditMemo_PricingCorrectionOrRecharge_IncorrectPrice_IncorrectDiscounts_Recharges',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50200,'RT_OTC023_CheckBillingPostingFlows_Corrections_DebitOrCredit',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50200,'RT_SLS009_ChangeCustomer',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50200,'RT_OTC119_InputDisputeFlagandReasonCode',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50200,'RT_OTC122_InputDisputeResolutionCode',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50200,'RT_SLS018_DefineDeposits',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50200,'RT_SLS021_SetupDiscount',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50200,'RT_OTC130_ApplyPaymentAgainstInvoice',true,DocRefNo);

        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG001_CreateDomesticSalesOrder', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG016_ReturnRPMOrder_RoutePlanning', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG017_CreateTransportPlanning', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG023_ReviewDifferenceSettlementOfCustomer', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG004_CreateFreeProductSalesOrder', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC001_CreateCustomerInvoice_ManualCreation_SingleOrderInvoicing', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC011_GenerateCopyOfTheInvoiceFromTheSystem', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC022_IssueCustomerBonusCreditMemo_3rdPartyBonusCalculation', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC017_CreateCustomerCreditMemo_QuantityCorrection_GoodsLost_GoodsDamaged_QualityIssues', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC018_CreateCustomerDebitOrCreditMemo_PricingCorrectionOrRecharge_IncorrectPrice_IncorrectDiscounts_Recharges', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC023_CheckBillingPostingFlows_Corrections_DebitOrCredit', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_SLS009_ChangeCustomer', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC119_InputDisputeFlagandReasonCode', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC122_InputDisputeResolutionCode', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_SLS018_DefineDeposits', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_SLS021_SetupDiscount', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC130_ApplyPaymentAgainstInvoice', true, DocRefNo);
        // BC UPGRADE KAPOOV01 Replaced Variable-CALTestMgtHNK with TestScriptsBCUpgrade as HNK custom function- AddTestLineHNK is now defined in CU-TestScriptsBCUpgrade <<

        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50200,'RT_LOG019_CreatePicking',TRUE,DocRefNo);
    end;

    local procedure StPTestScripts();
    begin
        // BC UPGRADE KAPOOV01 Replaced Variable-CALTestMgtHNK with TestScriptsBCUpgrade as HNK custom function- AddTestLineHNK is now defined in CU-TestScriptsBCUpgrade >>
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PTP010_ProcessPOInvoice',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PTP012_ProcessNPOInvoice',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PTP011_ProcessPOCreditMemo',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_LOG026_Create&ReleaseWarehouseReceipt',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PCN024_ReleasePO',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PTP061-CreatePaymentProposal',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PTP067_Review&SendPaymentProposal',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PTP069_ApprovePaymentProposalL1',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PTP084_ProcessManualPayment',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PCN023_CreatePurchaseOrder',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PTP015_CreateNPOCreditNote',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PTP087_CreateNPOPrepayment',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PTP018_CreatePOInvoice',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PTP073_ExecutePaymentBankConnectivity',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PCN003_CreateCallOffFromBlanketOrder',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PCN027_CreateCalloff',true,DocRefNo);

        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP010_ProcessPOInvoice', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP012_ProcessNPOInvoice', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP011_ProcessPOCreditMemo', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_LOG026_Create&ReleaseWarehouseReceipt', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN024_ReleasePO', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP061-CreatePaymentProposal', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP067_Review&SendPaymentProposal', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP069_ApprovePaymentProposalL1', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP084_ProcessManualPayment', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN023_CreatePurchaseOrder', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP015_CreateNPOCreditNote', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP087_CreateNPOPrepayment', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP018_CreatePOInvoice', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP073_ExecutePaymentBankConnectivity', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN003_CreateCallOffFromBlanketOrder', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN027_CreateCalloff', true, DocRefNo);
        // BC UPGRADE KAPOOV01 Replaced Variable-CALTestMgtHNK with TestScriptsBCUpgrade as HNK custom function- AddTestLineHNK is now defined in CU-TestScriptsBCUpgrade <<
    end;

    local procedure RtRTestScripts();
    begin
        // BC UPGRADE KAPOOV01 Replaced Variable-CALTestMgtHNK with TestScriptsBCUpgrade as HNK custom function- AddTestLineHNK is now defined in CU-TestScriptsBCUpgrade >>

        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RT_RTR001-ManualGLPosting',true,DocRefNo);

        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RT_RTR003-Manual GLPosting2Approvers',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RT_RTR005-ManualGLPostingMissingCCC',true,DocRefNo);

        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR001-ManualGLPosting', true, DocRefNo);

        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR003-Manual GLPosting2Approvers', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR005-ManualGLPostingMissingCCC', true, DocRefNo);
        // BC UPGRADE KAPOOV01 Replaced Variable-CALTestMgtHNK with TestScriptsBCUpgrade as HNK custom function- AddTestLineHNK is now defined in CU-TestScriptsBCUpgrade <<
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RT_RTR008-ManualGLPostingWithUpload',TRUE,DocRefNo);

        // BC UPGRADE KAPOOV01 Replaced Variable-CALTestMgtHNK with TestScriptsBCUpgrade as HNK custom function- AddTestLineHNK is now defined in CU-TestScriptsBCUpgrade >>
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RT_RTR124-InventoryReconciliation',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RT_RTR135-ManualBankStatementProcessing',true,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RT_BPM001-CalculateStandardCost',true,DocRefNo);

        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR124-InventoryReconciliation', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR135-ManualBankStatementProcessing', true, DocRefNo);
        TestScriptsBCUpgradeCBN.AddTestLineHNK(CALTestSuite.Name, 50209, 'RT_BPM001-CalculateStandardCost', true, DocRefNo);
        // BC UPGRADE KAPOOV01 Replaced Variable-CALTestMgtHNK with TestScriptsBCUpgrade as HNK custom function- AddTestLineHNK is now defined in CU-TestScriptsBCUpgrade <<
    end;

    local procedure HtSTestScripts();
    begin
    end;

    procedure Test(p_InputText: Text);
    var
        AllObjectList: Record AllObjWithCaption;

        // BC UPGRADE PATELS08 >> Changed the Global variables type from Custom to inbuilt Test Scripts.
        // CALTestSuite : Record "CAL Test Suite HNK";
        // CALTestMgtHNK : Codeunit "CAL Test Management HNK";
        // CALTestLine : Record "CAL Test Line HNK";

        CALTestSuite: Record "CAL Test Suite";
        CALTestMgt: Codeunit "CAL Test Management";
        CALTestLine: Record "CAL Test Line";
    // BC UPGRADE PATELS08 <<
    begin
        //Get Test Cases in CodeUnit
        // CALTestSuite.GET('DEFAULT');
        // AllObjectList.RESET;
        // AllObjectList.SETCURRENTKEY("Object ID","Object Type");
        // AllObjectList.SETFILTER("Object ID",'%1|%2',50172,50209);
        // AllObjectList.SETRANGE("Object Type",AllObjectList."Object Type"::Codeunit);
        // IF AllObjectList.FINDSET (FALSE,FALSE) THEN REPEAT
        //  //CALTestMgtHNK.AddTestCodeunits2(CALTestSuite,AllObjectList,p_InputText);
        // UNTIL AllObjectList.NEXT = 0;
        //Get Test Cases in CodeUnit
    end;

    procedure SetDocRef(InputDocRef: Text[50]);
    begin
        DocRefNo := InputDocRef;
    end;

    procedure TestScripts(SuiteName: Code[10]);
    begin

        CALTestSuite.RESET();
        CALTestSuite.DELETEALL();

        // BC UPGRADE PATELS08 >> # Varaibles Renamed as per the base codeunit.
        // CALTestLineHNK.RESET;
        // CALTestLineHNK.DELETEALL;
        CALTestLine.RESET();
        CALTestLine.DELETEALL();
        // BC UPGRADE PATELS08 <<




        CALTestSuite.INIT();
        CALTestSuite.Name := SuiteName;
        CALTestSuite.INSERT(true);

        CALTestSuite.GET(SuiteName);

        //DtWTestScripts;
        MtCTestScripts();
        //StPTestScripts;
        //RtRTestScripts;
        //HtSTestScripts;
        ExcludeCALTestScriptsFromRT();
    end;

    local procedure ExcludeCALTestScriptsFromRT();
    begin
        DtWSkipTestScripts();
        MtCSkipTestScripts();
        StPSkipTestScripts();
        RtRSkipTestScripts();
        HTSSkipTestScripts();
    end;

    local procedure DtWSkipTestScripts();
    begin
        // BC UPGRADE KAPOOV01 Replaced Variable-CALTestMgtHNK with TestScriptsBCUpgrade as HNK custom function- SkipTestLineHNK is now defined in CU-TestScriptsBCUpgrade >>
        if COMPANYNAME = 'SellCo' then begin
            //   CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD004_CheckDefaultRouting_Brew_2',true,DocRefNo);
            //   CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD004_CheckDefaultRouting_Brew_2',true,DocRefNo);

            TestScriptsBCUpgradeCBN.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD004_CheckDefaultRouting_Brew_2', true, DocRefNo);
            TestScriptsBCUpgradeCBN.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD004_CheckDefaultRouting_Brew_2', true, DocRefNo);
        end;
        // BC UPGRADE KAPOOV01 Replaced Variable-CALTestMgtHNK with TestScriptsBCUpgrade as HNK custom function- SkipTestLineHNK is now defined in CU-TestScriptsBCUpgrade <<
    end;

    local procedure MtCSkipTestScripts();
    begin
        // BC UPGRADE KAPOOV01 Replaced Variable-CALTestMgtHNK with TestScriptsBCUpgrade as HNK custom function- SkipTestLineHNK is now defined in CU-TestScriptsBCUpgrade >>
        if COMPANYNAME = 'SellCo' then begin
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG016_ReturnRPMOrder_RoutePlanning', true, DocRefNo);
            TestScriptsBCUpgradeCBN.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG016_ReturnRPMOrder_RoutePlanning', true, DocRefNo);
        end;
        // BC UPGRADE KAPOOV01 Replaced Variable-CALTestMgtHNK with TestScriptsBCUpgrade as HNK custom function- SkipTestLineHNK is now defined in CU-TestScriptsBCUpgrade <<
    end;

    local procedure StPSkipTestScripts();
    begin
        // BC UPGRADE KAPOOV01 Replaced Variable-CALTestMgtHNK with TestScriptsBCUpgrade as HNK custom function- SkipTestLineHNK is now defined in CU-TestScriptsBCUpgrade >>
        if COMPANYNAME = 'SellCo' then begin
            //   CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'RT_PTP012_ProcessNPOInvoice',true,DocRefNo);
            TestScriptsBCUpgradeCBN.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP012_ProcessNPOInvoice', true, DocRefNo);
        end;
        // BC UPGRADE KAPOOV01 Replaced Variable-CALTestMgtHNK with TestScriptsBCUpgrade as HNK custom function- SkipTestLineHNK is now defined in CU-TestScriptsBCUpgrade <<
    end;

    local procedure RtRSkipTestScripts();
    begin
        // BC UPGRADE KAPOOV01 Replaced Variable-CALTestMgtHNK with TestScriptsBCUpgrade as HNK custom function- SkipTestLineHNK is now defined in CU-TestScriptsBCUpgrade >>
        if COMPANYNAME = 'SellCo' then begin
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR001-ManualGLPosting', true, DocRefNo);
            TestScriptsBCUpgradeCBN.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR001-ManualGLPosting', true, DocRefNo);
        end;
        // BC UPGRADE KAPOOV01 Replaced Variable-CALTestMgtHNK with TestScriptsBCUpgrade as HNK custom function- SkipTestLineHNK is now defined in CU-TestScriptsBCUpgrade <<
    end;

    local procedure HTSSkipTestScripts();
    begin
        /*
        IF COMPANYNAME = 'DryRun_BRARUDI_3' THEN BEGIN
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR017-RejectGLPosting',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD005_AdjustRouting_Brew_3',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD001_CreateFPPOforWort_Brew_1',TRUE,DocRefNo);
        END;
        IF COMPANYNAME = '10_BRARUDI' THEN BEGIN
          //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR017-RejectGLPosting',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD005_AdjustRouting_Brew_3',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD001_CreateFPPOforWort_Brew_1',TRUE,DocRefNo);
        END;
        IF COMPANYNAME = '20_BPISD' THEN BEGIN
          //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR017-RejectGLPosting',TRUE,DocRefNo);
         // CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD005_AdjustRouting_Brew_3',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD001_CreateFPPOforWort_Brew_1',TRUE,DocRefNo);
        END;
        IF COMPANYNAME = 'DryRun_BPISD_2' THEN BEGIN
          //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR017-RejectGLPosting',TRUE,DocRefNo);
          //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD005_AdjustRouting_Brew_3',TRUE,DocRefNo);
          //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD001_CreateFPPOforWort_Brew_1',TRUE,DocRefNo);
        END;
        */

    end;
}

