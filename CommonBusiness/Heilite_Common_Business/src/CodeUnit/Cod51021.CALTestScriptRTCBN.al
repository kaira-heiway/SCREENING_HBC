codeunit 51021 "CAL Test Script RT CBN"
{
    // version TS,HEI.132

    // HEI.01 RITM2923302 IBM SAXENA03 30/03/2022
    //   # CodeUnit is developed to RUN All Test Scripts.
    //   # Developer will add all funtions in this Codeunit to be RUN during RT
    //   # Comment/Uncomment some code
    // HEI.02 RITM2923302 IBM SHIVAS05 07/04/2022
    //   # Adding p1 Script to StPTestScripts function
    // HEI.03 RITM2986520 IBM GHOSHS05 04/05/2022
    //   # Adding and skipping testscripts for MTC
    // HEI.04 RITM2987058 IBM SHIVAS05 04/05/2022
    //   # Add script on StPTestScripts and StPSkipTestScripts function
    // HEI.05 RITM2964345 IBM SAXENA03 31/05/2022
    //   # Commented not required code.
    // HEI.06 RITM2987058 IBM SHIVAS05 03/06/2022
    //   # Adding p2 script on StPTestScripts and StPSkipTestScripts function
    // HEI.07 RITM2822071 IBM BHATTA09 08/06/2022
    //   # Adding and skipping Testscripts while Automated Run
    // HEI.08 RITM2822071 IBM SAXENA03 13/06/2022
    //   # Disable test Script with FAILED staturs, Needs to FIXED by concern team
    // HEI.09 RITM2986520 IBM GHOSHS05 14/06/2022
    //   # Adding and skipping testscripts for MTC and uncommenting scripts
    // HEI.10 RITM3073179 IBM SAXENA03 06/07/2022
    //   # Added new function TestScriptsNeedsTobeFIXED() to SKIP Test Script from execution in Dynamic Q system and needs to be fixed by Developers.
    // HEI.11 RITM2987058 IBM SHIVAS05 04.07.2022 # StP Automation Test Script
    //   # Adding and skipping "CHG2123487_CMGMandatoryonHeiliteBaseSPOTPOforLandedCosts" testscript
    // HEI.12 RITM2987058 IBM NANDIS01 05.07.2022 # StP Automation Test Script
    //   # Adding and skipping of PCN009
    // HEI.13 RITM2986520 IBM GHOSHS05 06/07/2022
    //   # commenting Lareunion scripts
    // HEI.14 RITM3073179 IBM SAXENA03 07/07/2022
    //   # # Added Test Script FOR HAITI OpCo to SKIP from execution in Dynamic Q system and needs to be fixed by Developers.
    // HEI.15 RITM2986520 IBM GHOSHS05 08/07/2022
    //   # commenting Ethiopia
    // HEI.16 RITM2986520 IBM BHANDS01 12/07/2022
    //   # Added code on MtCSkipTestScripts
    //   # Commented code for StLucia and Haiti
    // HEI.17 RITM2986520 IBM GHOSHS05 26/07/2022
    //   # Commented code for Panama and Haiti
    // HEI.18 RITM2986520 IBM BHANDS01 26/07/2022
    //   # Added code on MtCSkipTestScripts
    //   # Commented code for Lebanon
    // HEI.19 RITM2986520 IBM GHOSHS05 02/08/2022
    //   # Added code on MtCSkipTestScripts
    //   # Commented code for Algeria
    // HEI.21 RITM2986520 IBM GHOSHS05 03/08/2022
    //   # Commented code for Suriname RT scripts
    // HEI.22 RITM2822071 IBM BHATTA09 04.08.2022
    //   # Code added for skipping RTR001, RTR003 and RTR005 if General Journal Batch data is not available
    // HEI.23 RITM3121918 HNK VORGIM01 09/08/2022
    //   # Add Dynamic ACCEPTANCE Scripts in different Function
    // HEI.24 RITM2822071 IBM BHATTA09 10.08.2022
    //   # Code added for skipping RTR008 if General Journal Batch data is not available
    // HEI.25 RITM3121918 IBM SAXENA03 11.08.2022
    //   # Code added to enable Phase 1 test scripts
    //   # Code added to disable Phase 2 test scripts
    //   # Code added to execute funtion ExcludeCALTestScriptsFromRT() while running test scripts.
    // HEI.26 RITM2986520 IBM GHOSHS05 11.08.2022
    //   # Code added to skip MTC Test Script for Boukin Tenant
    // HEI.27 RITM2987058 IBM SHIVAS05 11.08.2022
    //   # Code added to skip STP Test Script for SellCo Tenant
    // HEI.28 RITM2822071 IBM BHATTA09 11.08.2022
    //   # Code added for skipping RTR Test Scripts for SellCo
    // HEI.29 RITM3007822 IBM GOKULS01 11.08.2022
    // # Adding and skipping testscripts for DTW Scripts
    // HEI.30 RITM2987058 IBM SHIVAS05 11.08.2022
    //   # Commented code for Haiti RT scripts
    // HEI.31 RITM2987058 IBM SHIVAS05 16.08.2022
    //   # Commented code for Lareunion RT scripts
    // HEI.32 RITM2822071 IBM BHATTA09 16.08.2022
    //   # Code added for skipping RTR Test Scripts
    // HEI.33 RITM3007822 IBM GOKULS01 16.08.2022
    // # changes in skipping testscripts for DTW Scripts
    // HEI.34 RITM3121918 IBM SAXENA03 17.08.2022
    //   # Disable failed test Scripts based on OpCo or Companies
    // HEI.35 RITM3121918 HNK VORIGM01 17.08.2022
    //   # Fix the Code Position for ACC DTW Scripts and Enable MTC fixed sciprts
    // HEI.36 RITM2987058 IBM SHIVAS05 18.08.2022
    //   # Skiping Script for Lebanon
    // HEI.37 RITM3007822 IBM GOKULS01 18.08.2022
    //   # to enable for burundi and skip for Lumbshi
    // HEI.38 RITM3121918 HNK VORIGM01 17.08.2022
    //   # Run all ACC Scripts for P1 and P2
    // HEI.39 RITM3121918 IBM SAXENA03 22.08.2022
    //   # Createed new function ExcludeCALTestScriptsFromRTACC() for ACC
    //   # Calling ExcludeCALTestScriptsFromRTACC() funtion from TestScriptsACC()
    // HEI.40 RITM3121918 IBM SAXENA03 23.08.2022
    //   # Adding Phase1 & Phase 2 scripts in function ALLTestScriptsACC()
    //   # Commented unwanted code
    // HEI.41 RITM3121918 IBM SAXENA03 23.08.2022
    //   # Added new function ExcludeLongRuuningTestScriptsACC()
    //   # Function ExcludeLongRuuningTestScriptsACC() Calling from ExcludeCALTestScriptsFromRTACC()
    // HEI.42 RITM3121918 IBM GHOSHS05 24.08.2022
    //   # Added code to skip unwanted scripts for bukavu
    // HEI.43 RITM2822071 IBM BHATTA09 25.08.2022
    //   # Code added for skipping RTR Test Scripts
    // HEI.44 RITM3121918 IBM GHOSHS05 25.08.2022
    //   # Code added for P2 scripts
    // HEI.45 RITM3007822 IBM GOKULS01 25.08.2022
    //   # Code added for P2 scripts
    // HEI.46 RITM3121918 IBM SAXENA03 26.08.2022
    //   # Skip failed Test Script for Panama
    //   # RTR SPOC should fix these scripts
    // HEI.47 RITM2822071 IBM BHATTA09 26.08.2022
    //   # Code added for skipping RTR Test Scripts
    // 
    // HEI.48 RITM3007822 IBM GOKULS01 26.08.2022
    //   # Code added for addeding for P2 DTW Test Scripts
    // HEI.49 RITM3121918 IBM SAXENA03 29.08.2022
    //   # Skip long runing Test Script for BRASCO & CBL company
    //   # RTR SPOC should fix these scripts
    // HEI.50 RITM2822071 IBM BHATTA09 29.08.2022
    //   # Code added for skipping RTR Test Scripts
    // 
    // HEI.51 RITM3007822 IBM GOKULS01 30.08.2022
    //   # Code added for Skipping for P2 DTW Test Scripts for SELLCO
    // HEI.52 RITM3121918 IBM GHOSHS05 30.08.2022
    //   # Code added for P2 scripts
    // HEI.53 RITM2822071 IBM BHATTA09 30.08.2022
    //   # Code added for skipping RTR Test Scripts
    // HEI.54 RITM3121918 IBM GHOSHS05 31.08.2022
    //   # Code added for P2 scripts
    // HEI.55 RITM2822071 IBM BHATTA09 31.08.2022
    //   # Code added for skipping RTR Test Scripts
    // HEI.56 RITM3007822 IBM GOKULS01 01.09.2022
    //   # Code added for Skipping for P2 DTW Test
    // HEI.57 RITM3121918 IBM GHOSHS05 05.09.2022
    //   # Code removed for long scripts
    // HEI.58 RITM2822071 IBM BHATTA09 05.09.2022
    //   # Code added for skipping RTR Test Scripts
    // HEI.59 RITM3121918 IBM GHOSHS05 06.09.2022
    //   # Code added for skipping mtc scripts
    // HEI.60 RITM2822071 IBM BHATTA09 06.09.2022
    //   # Code added for skipping RTR scripts
    // HEI.62 RITM2822071 IBM BHATTA09 07.09.2022
    //   # Code added for skipping RTR scripts for Phase 2
    // HEI.63 RITM2986520 IBM GHOSHS05 08.09.2022
    //   # Code added for skipping MTC and STP email scripts for Phase 2
    // HEI.64 RITM2822071 IBM BHATTA09 14.09.2022
    //   # Code added for skipping RTR scripts for Phase 2
    // HEI.65 RITM2822071 IBM BHATTA09 15.09.2022
    //   # Code added for skipping RTR scripts for Phase 2
    // HEI.66 RITM2822071 IBM BHATTA09 16.09.2022
    //   # Code added for skipping RTR scripts for Phase 2
    // HEI.67 RITM2987058 IBM NANDIS01 19.09.2022 # Automation StP Test Scripts
    //   # Code added for skipping RTR scripts for PTP028 and PTP102
    // HEI.68 RITM2822071 IBM BHATTA09 19.09.2022
    //   # Code added for skipping RTR scripts for Phase 2
    // HEI.69 RITM2822071 IBM BHATTA09 20.09.2022
    //   # Code added for skipping RTR scripts for Phase 2
    // HEI.70 RITM2822071 IBM BHATTA09 21.09.2022
    //   # Code added for skipping RTR scripts for Phase 2
    // HEI.71 RITM2822071 IBM BHATTA09 22.09.2022
    //   # Code added for skipping RTR scripts for Phase 2
    // HEI.72 RITM2822071 IBM BHATTA09 27.09.2022
    //   # Code added for skipping RTR scripts for Phase 2
    // HEI.73 RITM2822071 IBM BHATTA09 29.09.2022
    //   # Code added for skipping RTR scripts for Phase 2
    // HEI.74 RITM2822071 IBM BHATTA09 10.10.2022
    //         # Code added for skipping RTR scripts for Phase 2
    // HEI.75 RITM2987058 IBM NANDIS01 10.10.2022 # Automation StP Test Scripts
    //   # Code added for skipping StP scripts for PTP011 and PTP058
    // HEI.76 RITM2987058 IBM NANDIS01 11.10.2022 # Automation StP Test Scripts
    //   # Code updated for skipping StP scripts for PTP011 and PTP058
    // HEI.77 RITM2822071 IBM YADAVM05 12.10.2022 # Automate test scripts for RTR/BPM
    //   # Code updated for skipping RTR scripts for RTR035
    // HEI.78 RITM2822071 IBM YADAVM05 20.10.2022 # Automate test scripts for RTR/BPM
    //   # Code updated for skipping RTR scripts for RTR035
    // HEI.79 RITM2987058 IBM SRIVAS07 20.10.2022 # Automation StP Test Scripts
    //   # Code added for skipping StP scripts for PTP010, PTP011, PTP012, PTP015, PTP018, PTP040, PTP041, PTP042, PTP055, PTP056, PTP057, PTP058 and PTP087
    // HEI.80 RITM2987058 IBM SAMANR01 27.10.2022 # Automation StP Test Scripts
    //   # Code added for skipping StP scripts that are WIP or failed to run
    // HEI.81 RITM3007822 IBM PRASAA03 31.10.2022 # Automation DTW Test Scripts
    //   # Code added for un-skipping DTW scripts
    // HEI.82 RITM2822071 IBM YADAVM05 02.11.2022 # Automate test scripts for RTR/BPM
    //   # Code blocked in function ALLTestScriptACCWIP
    // HEI.83 RITM2987058 IBM SRIVAS07 03.11.2022 # Automation StP Test Scripts
    //   # Code blocked in function ALLTestScriptACCWIP
    // HEI.84 RITM3007822 IBM PRASAA03 04.11.2022 # Automation DTW Test Scripts
    //   # Code added for un-skipping DTW scripts
    // HEI.85 RITM2822071 IBM YADAVM05 07.11.2022 # Automation RTR Test Scripts
    //   # Code added for un-skipping RTR scripts
    // HEI.86 RITM3207666 IBM SAXENA03 08.11.2022
    //   # Commented failed Test Scripts in function ALLTestScriptACCWIP()
    // HEI.87 RITM3207666 IBM SAXENA03 09.11.2022
    //   # Commented failed Test Scripts in function ALLTestScriptACCWIP()
    // HEI.88 RITM2822071 IBM Yadavm05 30.12.2022
    //   # Add code to skip Test Script for RTR115
    // HEI.89 RITM2822071 IBM Yadavm05 10.01.2023
    //   # Add code to skip Test Script for RTR115
    // HEI.90 RITM2822071 IBM YADAVM05 12.01.2023 # Automate test scripts for RTR/BPM
    //   # Code updated for Unskipping RTR scripts for RTR115
    // HEI.91 RITM2987058 IBM SRIVAS07 30.01.2023 # Automation StP Test Scripts
    //   # Code added to StPSkipTestScripts()rtr
    // HEI.92 RITM2822071 IBM Yadavm05 13.03.2023 # Automation RtR Test Scripts
    //   # Code Blocked to StPSkipTestScripts RTR_134()
    // HEI.93 RITM2987058 IBM SRIVAS07 17.03.2023 # Automation StP Test Scripts
    //   # Code added to StPTestScripts()
    //   # Code Added to ALLTestScriptsACC()
    // HEI.94 RITM2987058 IBM SRIVAS07 28.03.2023 # Automation StP Test Scripts
    //   # Code added to StPSkipTestScripts()
    // HEI.95 RITM2987058 IBM SRIVAS07 28.03.2023 # Automation StP Test Scripts
    //   # Code added to StPSkipTestScripts()
    // HEI.96 RITM2987058 IBM SRIVAS07 28.03.2023 # Automation StP Test Scripts
    //   # Code added to StPSkipTestScripts()
    // HEI.97 RITM2987058 IBM SRIVAS07 29.03.2023 # Automation StP Test Scripts
    //   # Code added to StPSkipTestScripts()
    // HEI.98 RITM2987058 IBM SRIVAS07 05.04.2023 # Automation StP Test Scripts
    //   # Code added to StPSkipTestScripts()
    // HEI.99 RITM2987058 IBM SRIVAS07 14.04.2023 # Automation StP Test Scripts
    //   # Code added to StPSkipTestScripts()
    // HEI.100 RITM3007822 IBM PRASAA03 19.04.2023 # Automation DTW Test Scripts
    //   # Code added for skipping DTW scripts in ALMAZA
    // HEI.101 RITM2987058 IBM SRIVAS07 26.04.2023 # Automation StP Test Scripts
    //   # Code added to StPSkipTestScripts()
    // HEI.102 RITM2987058 IBM SRIVAS07 03.05.2023 # Automation StP Test Scripts
    //   # Code added to StPSkipTestScripts()
    // HEI.103 CHG2185291 IBM SAXENA03 15.05.2023
    //   # Added code for Consolidation of Test Script objects
    // HEI.107 CHG2206767 IBM YADAVM09 31.05.2023 # Automation RtR Test Scripts
    //   # Code added to fix data error in Panama
    // HEI.108 CHG2206767 IBM SRIVAS07 31.05.2023 # HeiLite BASE Test Script Adjustment and Optimazation
    //   # Code added to StPSkipTestScripts()
    // HEI.109 CHG2207595 IBM PRASAA03 07.06.2023 # HeiLite BASE Test Script Adjustment and Optimazation
    //   # Code added to DTWSkipTestScripts()
    // HEI.110 CHG2207595 IBM YADAVM09 07.06.2023 # Automation RtR Test Scripts
    //   # Code added to fix data error in Panama
    // HEI.111 CHG2207595 IBM SRIVAS07 08.06.2023 # HeiLite BASE Test Script Adjustment and Optimazation
    //   # Code added to StPSkipTestScripts()
    // HEI.112 CHG2207595 IBM SRIVAS07 08.06.2023 # HeiLite BASE Test Script Adjustment and Optimazation
    //   # Code added to StPSkipTestScripts()
    // HEI.113 CHG2208369 IBM SRIVAS07 14.06.2023 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code added to StPSkipTestScripts()
    // HEI.114 CHG2208369 IBM SRIVAS07 14.06.2023 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code added to StPSkipTestScripts()
    // HEI.115 CHG2212000 IBM SRIVAS07 13.07.2023 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code added to StPSkipTestScripts()
    // HEI.116 CHG2212000 IBM SRIVAS07 13.07.2023 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code added to StPSkipTestScripts()
    // HEI.117 CHG2212895 IBM SRIVAS07 19-07-2023 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code added to StPSkipTestScripts()
    // HEI.118 CHG2213758 IBM SRIVAS07 27-07-2023 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code added to StPSkipTestScripts()
    // HEI.119 CHG2214608 IBM Yadavm09 02-08-2023 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code added to RtRSkipTestScripts()
    // HEI.121 CHG2215529 IBM Yadavm09 17-08-2023 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code added to skip Lebanon Test SCript
    // HEI.122 CHG2217104 IBM Yadavm09 24-08-2023 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Documentation part changing for weekly release
    // HEI.123 CHG2227098 IBM SRIVAS07 07-11-23 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code added to StPSkipTestScripts()
    // HEI.124 CHG2240328 IBM Yadavm09 20-02-2024 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code added to rollback changes in Default Dimension
    // HEI.125 CHG2243439 IBM Yadavm09 13-03-2024 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code added to Block changes in Default Dimension
    // HEI.126 CHG2253044 IBM Yadavm09 27-05-2024 # WEEK22_2024 HeiLite BASE Test Script Adjustment and Optimizations
    //   # Skip RTR121 due to long execution
    // HEI.127 CHG2253044 IBM SRIVAS07 29-05-24 # WEEK22_2024 | HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code added to StPSkipTestScripts()
    // HEI.128 CHG2253925 IBM SRIVAS07 03-05-24 # WEEK 23 2024 | Test Script FIX Release ACC/QAULITY
    //   # Code added to StPSkipTestScripts()
    // HEI.129 CHG2264796 IBM Yadavm09 20-08-2024 # WEEK 342024 | HeiLite BASE Test Script Adjustment and Optimizations
    //   # Remove Skip RTR121 due to long execution
    // HEI.131 CHG2313389 IBM ADHIKG01 17.07.2025 WEEK 29 2025 | HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code added in MtCSkipTestScripts to skip the test script SLS_NEW1_CreateSalesOrderLoyalty for Lareunion
    // HEI.130 CHG2307923 SAHAL01 10.07.2025 Test Script - Block Payment for Invoices with Price Difference higher than the tolerance
    //   # Added Code for New Test Scripts - RT_PCN029_ProcessPO-PI_GlobalUpperToleranceLimitPercentage
    //                                     - RT_PCN030_ProcessPO-PI_GlobalUpperToleranceLimitAmount
    // HEI.132 CHG2315088 IBM ADHIKG01 28.07.2025 WEEK 31 2025 | HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code added in MtCSkipTestScripts to skip the IvoryCost test scripts:
    //     - RT_OTC022_IssueCustomerBonusCreditMemo_3rdPartyBonusCalculation
    //     - RT_OTC018_CreateCustomerDebitOrCreditMemo_PricingCorrectionOrRecharge_IncorrectPrice_IncorrectDiscounts_Recharges
    // HEI.133 CHG2328093 IBM KAPOOV01 28.10.2025 WEEK 43 2025 | HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code added in RtRSkipTestScripts to skip the test scripts- RTR115-RevaluationofAR_AP_Treasury,RTR113-RevaluationofAP,RTR114-RevaluationofTreasury for Company-10_WIND_LEE_BR
    // HEI.134 CHG2345634 IBM KAPOOV01 25.03.2026 WEEK 09 2026 | HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code added in RtRSkipTestScripts to skip the test scripts- RTR115-RevaluationofAR_AP_Treasury,RTR113-RevaluationofAP,RTR114-RevaluationofTreasury for Company-10_WIND_LEE_BR


    //BC UPGRADE KAPOOV01 >>
    // # Replaced Custom Test Script Object with Standard Test Script Object >>
    // # Replaced CU-"CAL Test Management HNK" with HeinekenBCCustomFunctions as HNK custom functions- AddTestLineHNK,SkipTestLineHNK sre now defined in CU-HeinekenBCCustomFunctions.
    //BC UPGRADE KAPOOV01 >>

    // BC Upgrade MISHRS14 >>
    // Removed false from FINDSET as its being depreceted in Procedure - RtRSkipTestScripts multiple times.
    // BC Upgrade MISHRS14 <<

    // BC Upgrade MISHRS14 >>
    // # Added Tag HEI.133 and HEI.134 to the documentation.
    // BC Upgrade MISHRS14 <<


    trigger OnRun();
    begin
    end;

    var
        DocRefNo: Text[50];
        //BC UPGRADE KAPOOV01 Replaced Custom Test Script Object with Standard Test Script Object >>
        // CALTestMgtHNK: Codeunit "50192";
        // CALTestSuite: Record "50225";
        // CALTestLineHNK: Record "50226";
        CALTestSuite: Record "CAL Test Suite";
        CALTestLineHNK: Record "CAL Test Line";
        CALTestMgtHNK: Codeunit "TestScriptsBCUpgradeCBN"; //Replaced CU-"CAL Test Management HNK" with TestScriptsBCUpgrade as HNK custom functions- AddTestLineHNK,SkipTestLineHNK sre now defined in CU-TestScriptsBCUpgrade.
        //BC UPGRADE KAPOOV01 Replaced Custom Test Script Object with Standard Test Script Object <<
        PnpSetup: Record "Purchases & Payables Setup";

    local procedure DtWTestScripts();
    begin
        //HEI.08>>
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD001_CreateFPPOforWort_Brew_1', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD004_CheckDefaultRouting_Brew_2', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD005_AdjustRouting_Brew_3', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD013_AdjustBOM_Brew_4', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD006_ChangeStatustoRPO_Brew_5', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD011_EnterConsumQtywithLotSelection_Brew_6', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD010_ConsumeComponent&Produce Product_Brew_7', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD008_CorrectConsumedorProducedQuantities_Brew_8', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD083_FinishRPO_Brew_9', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD071_CreateFPPO_Packaging_1', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD074_CheckDefaultRouting_Packaging_2', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD075_AdjustRouting_Packaging_3', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD077_FPPOAdjustBOM_Packaging_4', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD076_FPPO-ChangeStatustoRPO_Packaging_5', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD081_EnterConsumQtywithLotSelection_Packaging_6', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD078_ConsumeComponentProduce Product_Packaging_7', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD070_CorrectConsumedorProducedQuantities_Packaging_8', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD083_FinishRPO_Packaging_9', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD080_MoveFPstoLogistics_Packaging_10', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD042-CreateRPO_FilterCapacity_1', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD040_CheckDefaultRouting_FilterCapacity_2', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD041_AdjustRouting_FilterCapacity_3', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD022_AdjustBOM_FilterCapacity_4', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD051_EnterConsumQtyToLotSelectionRPO_FilterCapacity_5', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD047_ConsumeComponentsProduceProducts_FilterCapacity_6', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD046_CorrectConsumedorProducedQuantities_FilterCapacity_7', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD052_FinsihRPO_FilterCapacity_8', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD055_CreateRPO_FilterationMixing_1', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD053_CheckDefaultRouting_FilterationMixing_2', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD054_AdjustRouting_FilterationMixing_3', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD066_AdjustBOM_FilterationMixing_4', TRUE, DocRefNo);
        //HEI.08<<

        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD059_ResourceSelectionOfAvailableTanks_FilterationMixing_5', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD067_EnterConsumptionQuantitiesBatchBin_FilterationMixing_6', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD061_ConsumeComponentsProduceProducts_FilterationMixing_7', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD069_FinishRPO_FilterationMixing_8', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD062_ReceiveProductstoQualityHoldstatus_FilterationMixing_9', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD064_ReleaseBrightBeertoPackaging_FilterationMixing_10', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD028_CreateRPO_Cellar_1', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD031_CheckDefaultRouting_Cellar_2', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD032_AdjustRouting_Cellar_3', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD037_AdjustBOM_Cellar_4', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD034_ResourceSelectionofAvailableTanks_Cellar_5', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD035_EnterNegativeConsumptionQuantities_Cellar_6', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD027_EnterConsumptionQuantitiesBatchBin_Cellar_7', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD084_ConsumeComponentsProduceProducts_Cellar_8', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD036_CorrectConsumedorProducedQuantities_Cellar_9', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD015_CreateRPO_Yeast_1', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD018_CheckDefaultRouting_Yeast_2', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD019_AdjustRoutingYeast_Yeast_3', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD022_AdjustBOM_Yeast_4', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD024_EnterConsumptionQty_Yeast_5', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD023_ConsumeComponentsProduceProducts_Yeast_6', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD021_CorrectConsumedorProducedQuantities_Yeast_7', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD026_FinishRPO_Yeast_8', TRUE, DocRefNo);

        //>>HEI.23
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'PRD038_FinishRPO_Cellar_10', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'PRD085_BookingStockforRecoveredBeer', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'PRD086_PassResultQuarantainLotTest', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'PRD087_CheckStatusLotNo', TRUE, DocRefNo);
        //HEI.45>>
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'DTW003_GoodsposttoCCC', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'PRD090_ProductionBOM', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'PRDE14_CreateBOMversions', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'PRDE15_ChangeBoM', TRUE, DocRefNo);
        //HEI.45<<
        //HEI.48>>
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'PRDE15_RoutingHeader', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'PRDE16_CreateRoutinversions', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'PRDE17_ChangeRouting', TRUE, DocRefNo);
        //HEI.48<<
        //HEI.56>>
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'PRDE18_LinkedSKU', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'PRDE19_LinkingSKUtoItem', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'PRDM06_MultipleUoMandConversion', TRUE, DocRefNo);
        //HEI.56<<
        //HEI.23
    end;

    local procedure MtCTestScripts();
    begin
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG001_CreateDomesticSalesOrder', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG016_ReturnRPMOrder_RoutePlanning', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG017_CreateTransportPlanning', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG023_ReviewDifferenceSettlementOfCustomer', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG004_CreateFreeProductSalesOrder', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC001_CreateCustomerInvoice_ManualCreation_SingleOrderInvoicing', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC011_GenerateCopyOfTheInvoiceFromTheSystem', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC022_IssueCustomerBonusCreditMemo_3rdPartyBonusCalculation', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC017_CreateCustomerCreditMemo_QuantityCorrection_GoodsLost_GoodsDamaged_QualityIssues', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC018_CreateCustomerDebitOrCreditMemo_PricingCorrectionOrRecharge_IncorrectPrice_IncorrectDiscounts_Recharges', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC023_CheckBillingPostingFlows_Corrections_DebitOrCredit', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_SLS009_ChangeCustomer', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC119_InputDisputeFlagandReasonCode', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC122_InputDisputeResolutionCode', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_SLS018_DefineDeposits', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_SLS021_SetupDiscount', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC130_ApplyPaymentAgainstInvoice', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);

        //HEI.03>>
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG014_CreateReturnOrder_Adhoc', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG015_ReturnRPMOrder_Upfront', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG021_CreateUnloadingAtWarehouse', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG035_TransferOrderProcess', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG041_SalesOrderBilling', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG042_SalesReturnOrderBilling', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOGNEW1_CreateShipment', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOGNEW1_PostShipment', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG020_CreateLoading', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC053_CreateProformaInvoice_ManuallyFromTheOrder', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC025_CreateSundryOrderAnd_SundryInvoice', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC028_CheckITheLineItemDiscountCanBeEnteredOnTheOrderDuringTheOrderCreation', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC029_CreateSundryCreditMemoAndSundryCreditNote', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC152_CreateChequeJournalInHeiLiteNavisonForProcessing', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC153_PostCustomerChequesOnCustomerAccountBasedOnTheReferenceData', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC154_CheckChequePosting_PostingFlow', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC159_CreateCashJournal_AddOrAdjustOrRemoveCashPaymentLines', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC161_CheckPostingFlowForCashJournalPostingProcess', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC176_CheckPostingFlowForTheRefundProposalPosting', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC002_CreateCustomerInvoice', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC006_CreateCustomerCreditNote', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC005_CreateCustomerCombinedInvoice', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC007_CreateCustomerCreditNote', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC008_CreateCustomerCrNotewithInvoice', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC014_MonitorBilling', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation_CreateShippingAgent', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC095_BlockOrderAutomaticallyDueToCreditLimitExceeded', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC096_BlockOrderAutomaticallyDueToOverdue', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC097_BlockOrderAutomaticallyDueToPackingCreditValueExceeded', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC098_CreateBlockedOrdersReport', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC104_RejectBlockedOrder', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC106_ReleaseAutomaticallyOrderDueToAutoCreditControlRecheck', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC107_AccessOrdersReleasedInThePast_Archive', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC1842_UnitPriceviaItemList', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC1841_UpdatePriceviaSalesPriceWrksht', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC184_AdjustuploadFileData', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOGNEW11_ActualDeliveryDateForCaseFillRate', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC179_ReverseChequePostings', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG076_AutomaticRegistryInboundGateEntry', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG077_OutboundProcessSalesOrder', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG078_OutboundProcessTransferOrder', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG079_InboundProcessTransferOrder', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG080_OutboundProcessPurchaseReturnOrder', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG081_InboundProcessPurchaseOrder', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG082_InboundProcessSalesReturnOrder', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS010_IncompleteDataCustomer', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS011_InactivateACustomer_Temporary', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS012_InactivateACustomer_Permanently', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS013_ApprovalCustomerFinancialAndSalesData_CustomerEqualToSoldTo', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS014_ApprovalCustomerFinancialAndSalesData_CustomerDifferentFromSoldTo', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS015_CreateAndReleaseContractConditions_IndividualSalesConditions', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS001_CreateCustomerSoldToPayer', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS002_CreateCustomerShiptoOutlet', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS004_CreateCustomerEmployee', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS003_CreateCustomerOutlet', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS005_CreateCustomerIntercompany', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS008_DuplicateCustomerSoldTo', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC079_GenerateRemindersList', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC080_ExcludeReminderFromTheReminderList', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC081_ExcludeReminderLineInTheReminder', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC082_CheckIfTheDisputedItemsAreMarkedOnTheReminderLettersAsDisputed', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC083_SendReminderLetterToCustomerViaEmail', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC084_PrintReminderLetterFromTheProposal', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC085_AccessRemindersAlreadyIssuedInTheArchive', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC087_GenerateDunningBlockList', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC089_GenerateAgingReport', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC199_ApplyCustomerEarlyPaymentDiscountBasedOnTheIncomingPayment', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC1xx_CreateNewDiscountOrBonusConditionsTemporaryOrPermanent', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC1xxx_RemoveDiscount', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC059-UpdateCustomerRiskScore', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC060-UpdateCustomerCreditLimit', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG_IC_001_InterCompanySales', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOGNEW22_CTS', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC212_CheckPostingFlowForEarlyPaymentDiscount', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC21xxxRemovePromotions', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC2xxx_CreateAdjustPromotions', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC063_CheckDateOfTheLast_CreditRiskAssessmentFor_Customer', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC090_CreateCashCollection_NoFiscalDocumentOnCustomerAccount', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC091_PrintCashCollectionOrder', TRUE, DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC198_GenerateReportWithDocumentsRequiringCorrectionsDueToPriceError', TRUE, DocRefNo);
        //HEI.03>>
    end;

    local procedure StPTestScripts();
    begin
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PTP010_ProcessPOInvoice',TRUE,DocRefNo);//HEI.08
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PTP011_ProcessPOCreditMemo',TRUE,DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP012_ProcessNPOInvoice', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_LOG026_Create&ReleaseWarehouseReceipt', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN024_ReleasePO', TRUE, DocRefNo);
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PTP061-CreatePaymentProposal',TRUE,DocRefNo);//HEI.08
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PTP067_Review&SendPaymentProposal',TRUE,DocRefNo);//HEI.08
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PTP069_ApprovePaymentProposalL1',TRUE,DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP084_ProcessManualPayment', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN023_CreatePurchaseOrder', TRUE, DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PTP015_CreateNPOCreditNote',TRUE,DocRefNo);//HEI.08
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PTP087_CreateNPOPrepayment',TRUE,DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP018_CreatePOInvoice', TRUE, DocRefNo);
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PTP073_ExecutePaymentBankConnectivity',TRUE,DocRefNo);//HEI.08
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PCN003_CreateCallOffFromBlanketOrder',TRUE,DocRefNo);//HEI.08
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'RT_PCN027_CreateCalloff',TRUE,DocRefNo);//HEI.08
        //HEI.02>>
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PCN001_ValidateContractHeader', TRUE, DocRefNo);
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PCN002_ValidateContractItems',TRUE,DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PCN004-PurchaseOrder_SendtoSupplier', TRUE, DocRefNo);
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PCN014 Display Purchase Order',TRUE,DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PCN017-Create Purchase Quote', TRUE, DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PCN018-Approve Purchase Quote',TRUE,DocRefNo);//HEI.08
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PCN019-Create Purchase Order from Purchase Quote',TRUE,DocRefNo);//HEI.08
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PCN020-Update Purchase Quote',TRUE,DocRefNo);//HEI.08
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PCN021 Reject Purchase Quote',TRUE,DocRefNo);//HEI.08
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PCN026 Sent PO to Approval',TRUE,DocRefNo);//HEI.08
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PCN028 Approve Purchase Order',TRUE,DocRefNo);//HEI.08
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PRD107-GoodsReceipt',TRUE,DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP040 Obsolete invoice', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP055 Negativetesting NPO Invoice', TRUE, DocRefNo);
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PTP058_Negative_PO_CN',TRUE,DocRefNo);//HEI.08
        //HEI.04>>
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PTP091-Automatic clearing on GR or IR Account',TRUE,DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PTP092-Review Consolidated GR or IR report',TRUE,DocRefNo);
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PTP091_Automatic_clearing_on_GR_or_IR_Account',TRUE,DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP092_Review_Consolidated_GR_or_IR_report', TRUE, DocRefNo);
        //HEI.04<<
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PTP102-Clearing_of_open_items_on_vendor_accounts',TRUE,DocRefNo);//HEI.08
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PTP133_Reverse_Rejected_CN',TRUE,DocRefNo);//HEI.08
        //HEI.04>>
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PTP136-Reverse Manual Payment',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP136_Reverse_Manual_Payment', TRUE, DocRefNo);
        //HEI.04<<
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP154-ApproveInvoice_noworkflow', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP157-RejectCreditNote_noworkflow', TRUE, DocRefNo);
        //HEI.02<<
        //HEI.04
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PTP062-CreatePaymentProposal',TRUE,DocRefNo);//HEI.08
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PTP074 Execute Payment Cheques',TRUE,DocRefNo);//HEI.08
        //HEI.04
        //HEI.06>>
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PCN006_UpdateSpotPOorVLcalloff',TRUE,DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PCN008_CancelPurchaseOrder', TRUE, DocRefNo);
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PCN025_UpdatePxQreturncalloff',TRUE,DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP024_NPO_InvoiceReversal_Correction', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP027_ProcessLargeInvoice', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP028_AttachDocAfterPosting', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP041_ObsoleteCN', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP042_CheckOnInvoiceNumberAllocatedTwice', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP053_ProcessNPOInvoice_paymentmethod_otherthanBank', TRUE, DocRefNo);
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PTP056_Negativetesting_PO_Invoice_DocDateError',TRUE,DocRefNo);//HEI.08
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PTP056_Negativetesting_PO_Invoice_VendorInvError',TRUE,DocRefNo);//HEI.08
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PTP056_Negativetesting_PO_Invoice_VATAmtError',TRUE,DocRefNo);//HEI.08
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PTP057_Negative_NPO_CN_DocDateERROR',TRUE,DocRefNo);//HEI.08
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PTP057_Negative_NPO_CN_VendCrNoError',TRUE,DocRefNo);//HEI.08
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PTP057_Negative_NPO_CN_VATAmtError',TRUE,DocRefNo);//HEI.08
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PTP057_Negative_NPO_CN_LinesError',TRUE,DocRefNo);//HEI.08
        // CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PTP068_Review_and_Undo_Payment_Proposal',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP078_Reverse_payment_Rejected_payment', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP079_Block_invoice_for_payment', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP080_Unblock_invoice_for_payment', TRUE, DocRefNo);
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PTP081_Create_Emergency_Payment_Proposal',TRUE,DocRefNo);//HEI.08
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP082_Process_PtP_Netting', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP083_Reverse PtP Netting', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP086_Reverse_Refund', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP103_Unapplying_of_cleared_items', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP132-ReverseRejectedInvoice', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP155-RejectInvoice_noworkflow', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP156-ApproveCreditNote_noworkflow', TRUE, DocRefNo);
        //HEI.06<<
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'CHG2123487_CMGMandatoryonHeiliteBaseSPOTPOforLandedCosts', TRUE, DocRefNo);//HEI.11
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PCN009_CreateReturnorderfromBlanketOrder', TRUE, DocRefNo);//HEI.12
        //HEI.93>>
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP103_PaymentAlongWithAppliedAndUnappliedEntry', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'CHG2098629_AutomaticCreationofTransferOrderforImportPO', TRUE, DocRefNo);//STP3
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC1', TRUE, DocRefNo);//STP3
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC2', TRUE, DocRefNo);//STP3
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC3', TRUE, DocRefNo);//STP3
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC4', TRUE, DocRefNo);//STP3
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'CHG2065545_FA_PurchaseOrder', TRUE, DocRefNo);//STP3
        //HEI.93<<
        //HEI.130>>
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN029_ProcessPO-PI_GlobalUpperToleranceLimitPercentage', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN030_ProcessPO-PI_GlobalUpperToleranceLimitAmount', TRUE, DocRefNo);
        //HEI.130<<
    end;

    local procedure RtRTestScripts();
    begin

        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR001-ManualGLPosting', TRUE, DocRefNo);

        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR003-Manual GLPosting2Approvers', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR005-ManualGLPostingMissingCCC', TRUE, DocRefNo);
        //HEI.08>>
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RT_RTR008-ManualGLPostingWithUpload',TRUE,DocRefNo);//HEI.07
        //HEI.08<<
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR008-ManualGLPostingWithUpload', TRUE, DocRefNo);//HEI.28
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR124-InventoryReconciliation', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR135-ManualBankStatementProcessing', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RT_BPM001-CalculateStandardCost', TRUE, DocRefNo);
        //HEI.07>>
        /*
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR025-PrintGLRegisters',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR026-GLRegisterDimensions',TRUE,DocRefNo);
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RT_RTR124-InventoryReconciliation',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR041-MonthEndSalesCutOff',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR073-CreateFixedAssetWrongCCC',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR074-FixedAssetModification',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR075-RPMAssetMasteDataCreation',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR077-ReviewFixedAsset',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR081-FixedAssetCorrectioOfSubclass',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR082-FixedAssetChangeLocationOrCCC',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR085-RunFixedAssetNetBookValue',TRUE,DocRefNo);
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR102-CreationOfHeiMatchFlatFile',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR104-CreationOfCashFlowPerLE',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR111-ReclassificationDepositsForPackaging',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR116-ManualReconciliationARTrade',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR117-ManualReconciliationAPTrade',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR118-ReconciliationOfPettyCash',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR121-ManualReconciliation',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR123-CheckFilterCustomerOrVendorsWithDebitOrCreditBalance',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR091-RPM_ReconcQuantitiesCheck',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR096-ChangeLog_AssetAccountingChecks',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR109-ManualCurrencyExchangeRateUpdate',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR141-CreationofVATreport',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR145-Preparationwitholdingtaxdeclaration',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR147-Preparationexcisedutydeclaration',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR050-BlockexistingSCOA',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR043-DisplayaccounttypeofSCOAAccount',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR068-DisplaySCOAAccountwithfilterbytimeframes',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR044-DisplaylinktoCILofSCOAAccount',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR053-ChangeLogReviewofSCOAMasterDataChanges',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR067-DisplaySCOAAccountwithOpenCloseditems',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR042-DisplaySCOAChartofAccounts',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR071-ReviewPayrollPostings',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'BPM046-CreateEbfMatrixRestriction',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'SettingTheHeimatchSignToNochange',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'SettingTheHeimatchSignToReverse',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR038-ChangeLogReviewofGLPostings',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR039-GLRegisterReviewofGLPostings',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR040-GeneralLedgerEntriesReviewGLPostings',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'BPM016-AllocatedimensionLogisticsexpenseCostdrivers',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'BPM051-CreateCAPEXbudget',TRUE,DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'AssigningdefaultCCforInventoryAdjustment',TRUE,DocRefNo);
        */
        //HEI.07<<

    end;

    local procedure HtSTestScripts();
    begin
    end;

    procedure Test(p_InputText: Text);
    var
        AllObjectList: Record AllObjWithCaption;
        //BC UPGRADE KAPOOV01 Replaced Custom Test Script Object with Standard Test Script Object >>
        //CALTestSuite: Record "50225";
        // CALTestMgtHNK: Codeunit "50192";
        // CALTestLine: Record "50226";
        CALTestSuite: Record "CAL Test Suite";
        CALTestMgtHNK: Codeunit "CAL Test Management";
        CALTestLine: Record "CAL Test Line";
    //BC UPGRADE KAPOOV01 Replaced Custom Test Script Object with Standard Test Script Object <<
    begin
        //HEI.05>>
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
        //HEI.05<<
    end;

    procedure SetDocRef(InputDocRef: Text[50]);
    begin
        DocRefNo := InputDocRef;
    end;

    procedure TestScripts(SuiteName: Code[10]);
    begin

        CALTestSuite.RESET();
        CALTestSuite.DELETEALL();

        CALTestLineHNK.RESET();
        CALTestLineHNK.DELETEALL();


        CALTestSuite.INIT();
        CALTestSuite.Name := SuiteName;
        CALTestSuite.INSERT(TRUE);

        CALTestSuite.GET(SuiteName);

        DtWTestScripts();
        MtCTestScripts();
        StPTestScripts();
        RtRTestScripts();
        HtSTestScripts();
        ExcludeCALTestScriptsFromRT();
    end;

    local procedure ExcludeCALTestScriptsFromRT();
    begin
        DtWSkipTestScripts();
        MtCSkipTestScripts();
        StPSkipTestScripts();
        RtRSkipTestScripts();
        HTSSkipTestScripts();
        //HEI.10>>
        TestScriptsNeedsTobeFIXED();
        //HEI.10<<
    end;

    local procedure DtWSkipTestScripts();
    var
        UnitTestingValue: Record "Unit Testing Value FND";
    begin
        //HEI.29>>
        //IF COMPANYNAME = 'BrewCo' THEN BEGIN //HEI.33
        IF UPPERCASE(COMPANYNAME) = 'BREWCO' THEN BEGIN //HEI.33
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD042-CreateRPO_FilterCapacity_1', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD040_CheckDefaultRouting_FilterCapacity_2', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD041_AdjustRouting_FilterCapacity_3', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD022_AdjustBOM_FilterCapacity_4', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD051_EnterConsumQtyToLotSelectionRPO_FilterCapacity_5', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD047_ConsumeComponentsProduceProducts_FilterCapacity_6', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD046_CorrectConsumedorProducedQuantities_FilterCapacity_7', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD052_FinsihRPO_FilterCapacity_8', TRUE, DocRefNo);
        END;
        IF UPPERCASE(COMPANYNAME) = '10_BRASSIVOIRE' THEN BEGIN //HEI.33
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD042-CreateRPO_FilterCapacity_1', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD040_CheckDefaultRouting_FilterCapacity_2', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD041_AdjustRouting_FilterCapacity_3', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD022_AdjustBOM_FilterCapacity_4', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD051_EnterConsumQtyToLotSelectionRPO_FilterCapacity_5', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD047_ConsumeComponentsProduceProducts_FilterCapacity_6', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD046_CorrectConsumedorProducedQuantities_FilterCapacity_7', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD052_FinsihRPO_FilterCapacity_8', TRUE, DocRefNo);
        END;
        IF UPPERCASE(COMPANYNAME) = '10_HBSC' THEN BEGIN //HEI.33
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD042-CreateRPO_FilterCapacity_1', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD040_CheckDefaultRouting_FilterCapacity_2', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD041_AdjustRouting_FilterCapacity_3', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD022_AdjustBOM_FilterCapacity_4', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD051_EnterConsumQtyToLotSelectionRPO_FilterCapacity_5', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD047_ConsumeComponentsProduceProducts_FilterCapacity_6', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD046_CorrectConsumedorProducedQuantities_FilterCapacity_7', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD052_FinsihRPO_FilterCapacity_8', TRUE, DocRefNo);
        END;
        IF UPPERCASE(COMPANYNAME) = '10_KINSHASA' THEN BEGIN //HEI.33
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD042-CreateRPO_FilterCapacity_1', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD040_CheckDefaultRouting_FilterCapacity_2', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD041_AdjustRouting_FilterCapacity_3', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD022_AdjustBOM_FilterCapacity_4', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD051_EnterConsumQtyToLotSelectionRPO_FilterCapacity_5', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD047_ConsumeComponentsProduceProducts_FilterCapacity_6', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD046_CorrectConsumedorProducedQuantities_FilterCapacity_7', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD052_FinsihRPO_FilterCapacity_8', TRUE, DocRefNo);
        END;
        IF UPPERCASE(COMPANYNAME) = '10_BUKAVU' THEN BEGIN //HEI.33
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD042-CreateRPO_FilterCapacity_1', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD040_CheckDefaultRouting_FilterCapacity_2', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD041_AdjustRouting_FilterCapacity_3', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD022_AdjustBOM_FilterCapacity_4', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD051_EnterConsumQtyToLotSelectionRPO_FilterCapacity_5', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD047_ConsumeComponentsProduceProducts_FilterCapacity_6', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD046_CorrectConsumedorProducedQuantities_FilterCapacity_7', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD052_FinsihRPO_FilterCapacity_8', TRUE, DocRefNo);
        END;
        IF UPPERCASE(COMPANYNAME) = '10_HAITI' THEN BEGIN //HEI.33
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD042-CreateRPO_FilterCapacity_1', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD040_CheckDefaultRouting_FilterCapacity_2', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD041_AdjustRouting_FilterCapacity_3', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD022_AdjustBOM_FilterCapacity_4', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD051_EnterConsumQtyToLotSelectionRPO_FilterCapacity_5', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD047_ConsumeComponentsProduceProducts_FilterCapacity_6', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD046_CorrectConsumedorProducedQuantities_FilterCapacity_7', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD052_FinsihRPO_FilterCapacity_8', TRUE, DocRefNo);
        END;

        //IF UPPERCASE(COMPANYNAME) = '10_LUBMBASHI' THEN BEGIN //HEI.33 //HEI.37
        IF UPPERCASE(COMPANYNAME) = '10_LUBUMBASHI' THEN BEGIN //HEI.37
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD015_CreateRPO_Yeast_1', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD018_CheckDefaultRouting_Yeast_2', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD019_AdjustRoutingYeast_Yeast_3', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD022_AdjustBOM_Yeast_4', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD024_EnterConsumptionQty_Yeast_5', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD023_ConsumeComponentsProduceProducts_Yeast_6', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD021_CorrectConsumedorProducedQuantities_Yeast_7', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD026_FinishRPO_Yeast_8', TRUE, DocRefNo);
        END;

        IF UPPERCASE(COMPANYNAME) = '10_BOUKIN' THEN BEGIN //HEI.33
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD001_CreateFPPOforWort_Brew_1', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD004_CheckDefaultRouting_Brew_2', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD005_AdjustRouting_Brew_3', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD013_AdjustBOM_Brew_4', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD006_ChangeStatustoRPO_Brew_5', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD011_EnterConsumQtywithLotSelection_Brew_6', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD010_ConsumeComponent&Produce Product_Brew_7', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD008_CorrectConsumedorProducedQuantities_Brew_8', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD083_FinishRPO_Brew_9', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD071_CreateFPPO_Packaging_1', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD074_CheckDefaultRouting_Packaging_2', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD075_AdjustRouting_Packaging_3', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD077_FPPOAdjustBOM_Packaging_4', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD076_FPPO-ChangeStatustoRPO_Packaging_5', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD081_EnterConsumQtywithLotSelection_Packaging_6', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD078_ConsumeComponentProduce Product_Packaging_7', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD070_CorrectConsumedorProducedQuantities_Packaging_8', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD083_FinishRPO_Packaging_9', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD080_MoveFPstoLogistics_Packaging_10', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD042-CreateRPO_FilterCapacity_1', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD040_CheckDefaultRouting_FilterCapacity_2', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD041_AdjustRouting_FilterCapacity_3', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD022_AdjustBOM_FilterCapacity_4', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD051_EnterConsumQtyToLotSelectionRPO_FilterCapacity_5', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD047_ConsumeComponentsProduceProducts_FilterCapacity_6', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD046_CorrectConsumedorProducedQuantities_FilterCapacity_7', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD052_FinsihRPO_FilterCapacity_8', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD055_CreateRPO_FilterationMixing_1', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD053_CheckDefaultRouting_FilterationMixing_2', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD054_AdjustRouting_FilterationMixing_3', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD066_AdjustBOM_FilterationMixing_4', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD059_ResourceSelectionOfAvailableTanks_FilterationMixing_5', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD067_EnterConsumptionQuantitiesBatchBin_FilterationMixing_6', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD061_ConsumeComponentsProduceProducts_FilterationMixing_7', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD069_FinishRPO_FilterationMixing_8', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD062_ReceiveProductstoQualityHoldstatus_FilterationMixing_9', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD064_ReleaseBrightBeertoPackaging_FilterationMixing_10', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD028_CreateRPO_Cellar_1', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD031_CheckDefaultRouting_Cellar_2', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD032_AdjustRouting_Cellar_3', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD037_AdjustBOM_Cellar_4', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD034_ResourceSelectionofAvailableTanks_Cellar_5', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD035_EnterNegativeConsumptionQuantities_Cellar_6', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD027_EnterConsumptionQuantitiesBatchBin_Cellar_7', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD084_ConsumeComponentsProduceProducts_Cellar_8', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD036_CorrectConsumedorProducedQuantities_Cellar_9', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD015_CreateRPO_Yeast_1', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD018_CheckDefaultRouting_Yeast_2', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD019_AdjustRoutingYeast_Yeast_3', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD022_AdjustBOM_Yeast_4', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD024_EnterConsumptionQty_Yeast_5', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD023_ConsumeComponentsProduceProducts_Yeast_6', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD021_CorrectConsumedorProducedQuantities_Yeast_7', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD026_FinishRPO_Yeast_8', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRD038_FinishRPO_Cellar_10', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRD085_BookingStockforRecoveredBeer', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRD086_PassResultQuarantainLotTest', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRD087_CheckStatusLotNo', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'DTW003_GoodsposttoCCC', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRD090_ProductionBOM', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRDE14_CreateBOMversions', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRDE15_ChangeBoM', TRUE, DocRefNo);
            //HEI.45<<
            //HEI.48>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRDE15_RoutingHeader', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRDE16_CreateRoutinversions', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRDE17_ChangeRouting', TRUE, DocRefNo);
            //HEI.48<<
            //HEI.56>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRDE18_LinkedSKU', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRDE19_LinkingSKUtoItem', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRDM06_MultipleUoMandConversion', TRUE, DocRefNo);
            //HEI.56<<

        END;
        //HEI.33>>
        IF UPPERCASE(COMPANYNAME) = 'SELLCO' THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD001_CreateFPPOforWort_Brew_1', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD004_CheckDefaultRouting_Brew_2', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD005_AdjustRouting_Brew_3', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD013_AdjustBOM_Brew_4', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD006_ChangeStatustoRPO_Brew_5', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD011_EnterConsumQtywithLotSelection_Brew_6', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD010_ConsumeComponent&Produce Product_Brew_7', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD008_CorrectConsumedorProducedQuantities_Brew_8', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD083_FinishRPO_Brew_9', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD071_CreateFPPO_Packaging_1', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD074_CheckDefaultRouting_Packaging_2', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD075_AdjustRouting_Packaging_3', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD077_FPPOAdjustBOM_Packaging_4', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD076_FPPO-ChangeStatustoRPO_Packaging_5', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD081_EnterConsumQtywithLotSelection_Packaging_6', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD078_ConsumeComponentProduce Product_Packaging_7', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD070_CorrectConsumedorProducedQuantities_Packaging_8', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD083_FinishRPO_Packaging_9', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD080_MoveFPstoLogistics_Packaging_10', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD042-CreateRPO_FilterCapacity_1', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD040_CheckDefaultRouting_FilterCapacity_2', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD041_AdjustRouting_FilterCapacity_3', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD022_AdjustBOM_FilterCapacity_4', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD051_EnterConsumQtyToLotSelectionRPO_FilterCapacity_5', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD047_ConsumeComponentsProduceProducts_FilterCapacity_6', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD046_CorrectConsumedorProducedQuantities_FilterCapacity_7', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD052_FinsihRPO_FilterCapacity_8', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD055_CreateRPO_FilterationMixing_1', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD053_CheckDefaultRouting_FilterationMixing_2', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD054_AdjustRouting_FilterationMixing_3', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD066_AdjustBOM_FilterationMixing_4', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD059_ResourceSelectionOfAvailableTanks_FilterationMixing_5', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD067_EnterConsumptionQuantitiesBatchBin_FilterationMixing_6', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD061_ConsumeComponentsProduceProducts_FilterationMixing_7', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD069_FinishRPO_FilterationMixing_8', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD062_ReceiveProductstoQualityHoldstatus_FilterationMixing_9', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD064_ReleaseBrightBeertoPackaging_FilterationMixing_10', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD028_CreateRPO_Cellar_1', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD031_CheckDefaultRouting_Cellar_2', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD032_AdjustRouting_Cellar_3', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD037_AdjustBOM_Cellar_4', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD034_ResourceSelectionofAvailableTanks_Cellar_5', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD035_EnterNegativeConsumptionQuantities_Cellar_6', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD027_EnterConsumptionQuantitiesBatchBin_Cellar_7', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD084_ConsumeComponentsProduceProducts_Cellar_8', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD036_CorrectConsumedorProducedQuantities_Cellar_9', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD015_CreateRPO_Yeast_1', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD018_CheckDefaultRouting_Yeast_2', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD019_AdjustRoutingYeast_Yeast_3', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD022_AdjustBOM_Yeast_4', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD024_EnterConsumptionQty_Yeast_5', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD023_ConsumeComponentsProduceProducts_Yeast_6', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD021_CorrectConsumedorProducedQuantities_Yeast_7', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD026_FinishRPO_Yeast_8', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRD038_FinishRPO_Cellar_10', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRD085_BookingStockforRecoveredBeer', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRD086_PassResultQuarantainLotTest', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRD087_CheckStatusLotNo', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'DTW003_GoodsposttoCCC', TRUE, DocRefNo);
            //HEI.51>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRD090_ProductionBOM', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRDE14_CreateBOMversions', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRDE15_ChangeBoM', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRDE15_RoutingHeader', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRDE16_CreateRoutinversions', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRDE17_ChangeRouting', TRUE, DocRefNo);
            //HEI.56>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRDE18_LinkedSKU', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRDE19_LinkingSKUtoItem', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'PRDM06_MultipleUoMandConversion', TRUE, DocRefNo);
            //HEI.56<<
            //HEI.51<<
        END;
        //HEI.33<<
        //HEI.37>>
        /*
        IF UPPERCASE(COMPANYNAME) = '10_BRARUDI' THEN BEGIN
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD001_CreateFPPOforWort_Brew_1',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD004_CheckDefaultRouting_Brew_2',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD005_AdjustRouting_Brew_3',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD013_AdjustBOM_Brew_4',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD006_ChangeStatustoRPO_Brew_5',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD011_EnterConsumQtywithLotSelection_Brew_6',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD010_ConsumeComponent&Produce Product_Brew_7',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD008_CorrectConsumedorProducedQuantities_Brew_8',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD083_FinishRPO_Brew_9',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD071_CreateFPPO_Packaging_1',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD074_CheckDefaultRouting_Packaging_2',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD075_AdjustRouting_Packaging_3',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD077_FPPOAdjustBOM_Packaging_4',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD076_FPPO-ChangeStatustoRPO_Packaging_5',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD081_EnterConsumQtywithLotSelection_Packaging_6',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD078_ConsumeComponentProduce Product_Packaging_7',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD070_CorrectConsumedorProducedQuantities_Packaging_8',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD083_FinishRPO_Packaging_9',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD080_MoveFPstoLogistics_Packaging_10',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD042-CreateRPO_FilterCapacity_1',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD040_CheckDefaultRouting_FilterCapacity_2',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD041_AdjustRouting_FilterCapacity_3',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD022_AdjustBOM_FilterCapacity_4',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD051_EnterConsumQtyToLotSelectionRPO_FilterCapacity_5',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD047_ConsumeComponentsProduceProducts_FilterCapacity_6',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD046_CorrectConsumedorProducedQuantities_FilterCapacity_7',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD052_FinsihRPO_FilterCapacity_8',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD055_CreateRPO_FilterationMixing_1',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD053_CheckDefaultRouting_FilterationMixing_2',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD054_AdjustRouting_FilterationMixing_3',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD066_AdjustBOM_FilterationMixing_4',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD059_ResourceSelectionOfAvailableTanks_FilterationMixing_5',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD067_EnterConsumptionQuantitiesBatchBin_FilterationMixing_6',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD061_ConsumeComponentsProduceProducts_FilterationMixing_7',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD069_FinishRPO_FilterationMixing_8',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD062_ReceiveProductstoQualityHoldstatus_FilterationMixing_9',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD064_ReleaseBrightBeertoPackaging_FilterationMixing_10',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD028_CreateRPO_Cellar_1',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD031_CheckDefaultRouting_Cellar_2',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD032_AdjustRouting_Cellar_3',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD037_AdjustBOM_Cellar_4',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD034_ResourceSelectionofAvailableTanks_Cellar_5',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD035_EnterNegativeConsumptionQuantities_Cellar_6',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD027_EnterConsumptionQuantitiesBatchBin_Cellar_7',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD084_ConsumeComponentsProduceProducts_Cellar_8',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD036_CorrectConsumedorProducedQuantities_Cellar_9',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD015_CreateRPO_Yeast_1',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD018_CheckDefaultRouting_Yeast_2',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD019_AdjustRoutingYeast_Yeast_3',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD022_AdjustBOM_Yeast_4',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD024_EnterConsumptionQty_Yeast_5',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD023_ConsumeComponentsProduceProducts_Yeast_6',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD021_CorrectConsumedorProducedQuantities_Yeast_7',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD026_FinishRPO_Yeast_8',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'PRD038_FinishRPO_Cellar_10',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'PRD085_BookingStockforRecoveredBeer',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'PRD086_PassResultQuarantainLotTest',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'PRD087_CheckStatusLotNo',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'DTW003_GoodsposttoCCC',TRUE,DocRefNo);
        END;
        */
        //HEI.37<<
        //HEI.29<<
        //HEI.109>>
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PRD015');
        UnitTestingValue.SETRANGE("Table ID", 27);
        IF NOT UnitTestingValue.FINDFIRST() THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD015_CreateRPO_Yeast_1', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD018_CheckDefaultRouting_Yeast_2', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD019_AdjustRoutingYeast_Yeast_3', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD022_AdjustBOM_Yeast_4', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD024_EnterConsumptionQty_Yeast_5', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD023_ConsumeComponentsProduceProducts_Yeast_6', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD021_CorrectConsumedorProducedQuantities_Yeast_7', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD026_FinishRPO_Yeast_8', TRUE, DocRefNo);
        END;
        //HEI.109<<

    end;

    local procedure MtCSkipTestScripts();
    begin
        //HEI.03>>
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG_IC_001_InterCompanySales', TRUE, DocRefNo); //HEI.09
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('Brewco') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG016_ReturnRPMOrder_RoutePlanning', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC063_CheckDateOfTheLast_CreditRiskAssessmentFor_Customer', TRUE, DocRefNo);

        END;
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('SellCo') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC063_CheckDateOfTheLast_CreditRiskAssessmentFor_Customer', TRUE, DocRefNo);
        END;

        IF UPPERCASE(COMPANYNAME) = UPPERCASE('Tango') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC014_MonitorBilling', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS013_ApprovalCustomerFinancialAndSalesData_CustomerEqualToSoldTo', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS015_CreateAndReleaseContractConditions_IndividualSalesConditions', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC063_CheckDateOfTheLast_CreditRiskAssessmentFor_Customer', TRUE, DocRefNo);

        END;

        IF UPPERCASE(COMPANYNAME) = UPPERCASE('Baru') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC014_MonitorBilling', TRUE, DocRefNo);
            //HEI.52>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC083_SendReminderLetterToCustomerViaEmail', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC085_AccessRemindersAlreadyIssuedInTheArchive', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC084_PrintReminderLetterFromTheProposal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC079_GenerateRemindersList', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC082_CheckIfTheDisputedItemsAreMarkedOnTheReminderLettersAsDisputed', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC081_ExcludeReminderLineInTheReminder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC080_ExcludeReminderFromTheReminderList', TRUE, DocRefNo);
            //HEI.52<<
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC063_CheckDateOfTheLast_CreditRiskAssessmentFor_Customer', TRUE, DocRefNo);
        END;

        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC083_SendReminderLetterToCustomerViaEmail', TRUE, DocRefNo);//HEI.52>>
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('Bralirwa') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG035_TransferOrderProcess', TRUE, DocRefNo);//HEI.44>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC063_CheckDateOfTheLast_CreditRiskAssessmentFor_Customer', TRUE, DocRefNo);

        END;

        IF UPPERCASE(COMPANYNAME) = UPPERCASE('250_Stores_Ltd') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG017_CreateTransportPlanning', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC014_MonitorBilling', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC063_CheckDateOfTheLast_CreditRiskAssessmentFor_Customer', TRUE, DocRefNo);

        END;

        IF UPPERCASE(COMPANYNAME) = UPPERCASE('Almaza') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG017_CreateTransportPlanning', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC083_SendReminderLetterToCustomerViaEmail', TRUE, DocRefNo);//HEI.52>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC014_MonitorBilling', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            //HEI.18>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC063_CheckDateOfTheLast_CreditRiskAssessmentFor_Customer', TRUE, DocRefNo);
            //HEI.18<<
        END;
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('CBL') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);

        END;
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_BRASSIVOIRE') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG017_CreateTransportPlanning', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC096_BlockOrderAutomaticallyDueToOverdue', TRUE, DocRefNo); //HEI.52>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC063_CheckDateOfTheLast_CreditRiskAssessmentFor_Customer', TRUE, DocRefNo);
            //HEI.132>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC018_CreateCustomerDebitOrCreditMemo_PricingCorrectionOrRecharge_IncorrectPrice_IncorrectDiscounts_Recharges', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC022_IssueCustomerBonusCreditMemo_3rdPartyBonusCalculation', TRUE, DocRefNo);
            //HEI.132<<

        END;

        IF UPPERCASE(COMPANYNAME) = UPPERCASE('20_IVOIREBOISSON') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC063_CheckDateOfTheLast_CreditRiskAssessmentFor_Customer', TRUE, DocRefNo);

        END;

        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_SURIN_BROUWERIJ') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG017_CreateTransportPlanning', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC014_MonitorBilling', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS014_ApprovalCustomerFinancialAndSalesData_CustomerDifferentFromSoldTo', TRUE, DocRefNo);


        END;
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('20_PARBO_CENTRAL') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC014_MonitorBilling', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);

        END;
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_WIND_LEE_BR') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC014_MonitorBilling', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS015_CreateAndReleaseContractConditions_IndividualSalesConditions', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);

        END;
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_BRARUDI') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG076_AutomaticRegistryInboundGateEntry', TRUE, DocRefNo);//HEI.59>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC083_SendReminderLetterToCustomerViaEmail', TRUE, DocRefNo);//HEI.63>>
                                                                                                                                   //HEI.52>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG081_InboundProcessPurchaseOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG082_InboundProcessSalesReturnOrder', TRUE, DocRefNo);
            //HEI.52<<
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation', TRUE, DocRefNo);//HEI.44>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC063_CheckDateOfTheLast_CreditRiskAssessmentFor_Customer', TRUE, DocRefNo);

        END;
        IF (UPPERCASE(COMPANYNAME) = UPPERCASE('10_HBSC')) OR (UPPERCASE(COMPANYNAME) = UPPERCASE('13_HBSC')) THEN BEGIN  //HEI.16
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC106_ReleaseAutomaticallyOrderDueToAutoCreditControlRecheck', TRUE, DocRefNo); //HEI.59>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC014_MonitorBilling', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC063_CheckDateOfTheLast_CreditRiskAssessmentFor_Customer', TRUE, DocRefNo);

        END;
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('12_HARAR_SC') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC014_MonitorBilling', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC063_CheckDateOfTheLast_CreditRiskAssessmentFor_Customer', TRUE, DocRefNo);

        END;
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_BDB') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC063_CheckDateOfTheLast_CreditRiskAssessmentFor_Customer', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation', TRUE, DocRefNo);//HEI.44>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);  //HEI.131
        END;
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_KINSHASA') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation', TRUE, DocRefNo);//HEI.44>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC063_CheckDateOfTheLast_CreditRiskAssessmentFor_Customer', TRUE, DocRefNo);

        END;
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_BUKAVU') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC063_CheckDateOfTheLast_CreditRiskAssessmentFor_Customer', TRUE, DocRefNo);
            //HEI.42>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC079_GenerateRemindersList', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC080_ExcludeReminderFromTheReminderList', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC081_ExcludeReminderLineInTheReminder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC082_CheckIfTheDisputedItemsAreMarkedOnTheReminderLettersAsDisputed', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC083_SendReminderLetterToCustomerViaEmail', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC084_PrintReminderLetterFromTheProposal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC085_AccessRemindersAlreadyIssuedInTheArchive', TRUE, DocRefNo);
            //HEI.42<<
        END;
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_LUBUMBASHI') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation', TRUE, DocRefNo);//HEI.54>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC083_SendReminderLetterToCustomerViaEmail', TRUE, DocRefNo);//HEI.52>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC063_CheckDateOfTheLast_CreditRiskAssessmentFor_Customer', TRUE, DocRefNo);

        END;
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_KISANGANI') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation', TRUE, DocRefNo);//HEI.63>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC063_CheckDateOfTheLast_CreditRiskAssessmentFor_Customer', TRUE, DocRefNo);

        END;
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_SIERRALEONE') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation', TRUE, DocRefNo);
            //HEI.52>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC083_SendReminderLetterToCustomerViaEmail', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG081_InboundProcessPurchaseOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG080_OutboundProcessPurchaseReturnOrder', TRUE, DocRefNo);
            //HEI.52<<
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
        END;
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_Haiti') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);


        END;
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_Haiti') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC014_MonitorBilling', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
        END;
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('BRASCO') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC014_MonitorBilling', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
        END;
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_BOUKIN') THEN BEGIN
            //HEI.26>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG001_CreateDomesticSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG016_ReturnRPMOrder_RoutePlanning', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG017_CreateTransportPlanning', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG023_ReviewDifferenceSettlementOfCustomer', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG004_CreateFreeProductSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC001_CreateCustomerInvoice_ManualCreation_SingleOrderInvoicing', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC011_GenerateCopyOfTheInvoiceFromTheSystem', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC022_IssueCustomerBonusCreditMemo_3rdPartyBonusCalculation', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC017_CreateCustomerCreditMemo_QuantityCorrection_GoodsLost_GoodsDamaged_QualityIssues', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC018_CreateCustomerDebitOrCreditMemo_PricingCorrectionOrRecharge_IncorrectPrice_IncorrectDiscounts_Recharges', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC023_CheckBillingPostingFlows_Corrections_DebitOrCredit', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_SLS009_ChangeCustomer', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC119_InputDisputeFlagandReasonCode', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC122_InputDisputeResolutionCode', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_SLS018_DefineDeposits', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_SLS021_SetupDiscount', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC130_ApplyPaymentAgainstInvoice', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG014_CreateReturnOrder_Adhoc', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG015_ReturnRPMOrder_Upfront', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG021_CreateUnloadingAtWarehouse', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG035_TransferOrderProcess', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG041_SalesOrderBilling', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG042_SalesReturnOrderBilling', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOGNEW1_CreateShipment', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOGNEW1_PostShipment', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG020_CreateLoading', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC053_CreateProformaInvoice_ManuallyFromTheOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC025_CreateSundryOrderAnd_SundryInvoice', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC028_CheckITheLineItemDiscountCanBeEnteredOnTheOrderDuringTheOrderCreation', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC029_CreateSundryCreditMemoAndSundryCreditNote', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC152_CreateChequeJournalInHeiLiteNavisonForProcessing', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC153_PostCustomerChequesOnCustomerAccountBasedOnTheReferenceData', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC154_CheckChequePosting_PostingFlow', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC159_CreateCashJournal_AddOrAdjustOrRemoveCashPaymentLines', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC161_CheckPostingFlowForCashJournalPostingProcess', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC176_CheckPostingFlowForTheRefundProposalPosting', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC002_CreateCustomerInvoice', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC006_CreateCustomerCreditNote', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC005_CreateCustomerCombinedInvoice', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC007_CreateCustomerCreditNote', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC008_CreateCustomerCrNotewithInvoice', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC014_MonitorBilling', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation_CreateShippingAgent', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC095_BlockOrderAutomaticallyDueToCreditLimitExceeded', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC096_BlockOrderAutomaticallyDueToOverdue', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC097_BlockOrderAutomaticallyDueToPackingCreditValueExceeded', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC098_CreateBlockedOrdersReport', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC104_RejectBlockedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC106_ReleaseAutomaticallyOrderDueToAutoCreditControlRecheck', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC107_AccessOrdersReleasedInThePast_Archive', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC1842_UnitPriceviaItemList', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC1841_UpdatePriceviaSalesPriceWrksht', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC184_AdjustuploadFileData', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOGNEW11_ActualDeliveryDateForCaseFillRate', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC179_ReverseChequePostings', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG076_AutomaticRegistryInboundGateEntry', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG077_OutboundProcessSalesOrder', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG078_OutboundProcessTransferOrder', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG079_InboundProcessTransferOrder', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG080_OutboundProcessPurchaseReturnOrder', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG081_InboundProcessPurchaseOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG082_InboundProcessSalesReturnOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS010_IncompleteDataCustomer', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS011_InactivateACustomer_Temporary', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS012_InactivateACustomer_Permanently', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS013_ApprovalCustomerFinancialAndSalesData_CustomerEqualToSoldTo', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS014_ApprovalCustomerFinancialAndSalesData_CustomerDifferentFromSoldTo', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS015_CreateAndReleaseContractConditions_IndividualSalesConditions', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS001_CreateCustomerSoldToPayer', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS002_CreateCustomerShiptoOutlet', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS004_CreateCustomerEmployee', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS003_CreateCustomerOutlet', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS005_CreateCustomerIntercompany', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS008_DuplicateCustomerSoldTo', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC079_GenerateRemindersList', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC080_ExcludeReminderFromTheReminderList', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC081_ExcludeReminderLineInTheReminder', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC082_CheckIfTheDisputedItemsAreMarkedOnTheReminderLettersAsDisputed', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC083_SendReminderLetterToCustomerViaEmail', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC084_PrintReminderLetterFromTheProposal', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC085_AccessRemindersAlreadyIssuedInTheArchive', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC087_GenerateDunningBlockList', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC089_GenerateAgingReport', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC199_ApplyCustomerEarlyPaymentDiscountBasedOnTheIncomingPayment', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC1xx_CreateNewDiscountOrBonusConditionsTemporaryOrPermanent', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC1xxx_RemoveDiscount', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC059-UpdateCustomerRiskScore', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC060-UpdateCustomerCreditLimit', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG_IC_001_InterCompanySales', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOGNEW22_CTS', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC212_CheckPostingFlowForEarlyPaymentDiscount', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC21xxxRemovePromotions', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC2xxx_CreateAdjustPromotions', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC063_CheckDateOfTheLast_CreditRiskAssessmentFor_Customer', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC090_CreateCashCollection_NoFiscalDocumentOnCustomerAccount', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC091_PrintCashCollectionOrder', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC198_GenerateReportWithDocumentsRequiringCorrectionsDueToPriceError', TRUE, DocRefNo);
            //HEI.26<<
        END;
        //HEI.03<<
        //HEI.16>>
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('20_DUBOLAY_BC') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG001_CreateDomesticSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG016_ReturnRPMOrder_RoutePlanning', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG017_CreateTransportPlanning', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG023_ReviewDifferenceSettlementOfCustomer', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG004_CreateFreeProductSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC001_CreateCustomerInvoice_ManualCreation_SingleOrderInvoicing', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC011_GenerateCopyOfTheInvoiceFromTheSystem', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC022_IssueCustomerBonusCreditMemo_3rdPartyBonusCalculation', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC017_CreateCustomerCreditMemo_QuantityCorrection_GoodsLost_GoodsDamaged_QualityIssues', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC018_CreateCustomerDebitOrCreditMemo_PricingCorrectionOrRecharge_IncorrectPrice_IncorrectDiscounts_Recharges', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC023_CheckBillingPostingFlows_Corrections_DebitOrCredit', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_SLS009_ChangeCustomer', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC119_InputDisputeFlagandReasonCode', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC122_InputDisputeResolutionCode', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_SLS018_DefineDeposits', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_SLS021_SetupDiscount', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC130_ApplyPaymentAgainstInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG014_CreateReturnOrder_Adhoc', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG015_ReturnRPMOrder_Upfront', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG021_CreateUnloadingAtWarehouse', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG035_TransferOrderProcess', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG041_SalesOrderBilling', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG042_SalesReturnOrderBilling', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOGNEW1_CreateShipment', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOGNEW1_PostShipment', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG020_CreateLoading', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC053_CreateProformaInvoice_ManuallyFromTheOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC025_CreateSundryOrderAnd_SundryInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC028_CheckITheLineItemDiscountCanBeEnteredOnTheOrderDuringTheOrderCreation', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC029_CreateSundryCreditMemoAndSundryCreditNote', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC152_CreateChequeJournalInHeiLiteNavisonForProcessing', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC153_PostCustomerChequesOnCustomerAccountBasedOnTheReferenceData', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC154_CheckChequePosting_PostingFlow', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC159_CreateCashJournal_AddOrAdjustOrRemoveCashPaymentLines', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC161_CheckPostingFlowForCashJournalPostingProcess', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC176_CheckPostingFlowForTheRefundProposalPosting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC002_CreateCustomerInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC006_CreateCustomerCreditNote', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC005_CreateCustomerCombinedInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC007_CreateCustomerCreditNote', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC008_CreateCustomerCrNotewithInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC014_MonitorBilling', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation_CreateShippingAgent', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC095_BlockOrderAutomaticallyDueToCreditLimitExceeded', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC096_BlockOrderAutomaticallyDueToOverdue', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC097_BlockOrderAutomaticallyDueToPackingCreditValueExceeded', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC098_CreateBlockedOrdersReport', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC104_RejectBlockedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC106_ReleaseAutomaticallyOrderDueToAutoCreditControlRecheck', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC107_AccessOrdersReleasedInThePast_Archive', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC1842_UnitPriceviaItemList', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC1841_UpdatePriceviaSalesPriceWrksht', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC184_AdjustuploadFileData', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOGNEW11_ActualDeliveryDateForCaseFillRate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC179_ReverseChequePostings', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG076_AutomaticRegistryInboundGateEntry', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG077_OutboundProcessSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG078_OutboundProcessTransferOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG079_InboundProcessTransferOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG080_OutboundProcessPurchaseReturnOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG081_InboundProcessPurchaseOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG082_InboundProcessSalesReturnOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS010_IncompleteDataCustomer', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS011_InactivateACustomer_Temporary', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS012_InactivateACustomer_Permanently', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS013_ApprovalCustomerFinancialAndSalesData_CustomerEqualToSoldTo', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS014_ApprovalCustomerFinancialAndSalesData_CustomerDifferentFromSoldTo', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS015_CreateAndReleaseContractConditions_IndividualSalesConditions', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS001_CreateCustomerSoldToPayer', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS002_CreateCustomerShiptoOutlet', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS004_CreateCustomerEmployee', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS003_CreateCustomerOutlet', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS005_CreateCustomerIntercompany', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS008_DuplicateCustomerSoldTo', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC079_GenerateRemindersList', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC080_ExcludeReminderFromTheReminderList', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC081_ExcludeReminderLineInTheReminder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC082_CheckIfTheDisputedItemsAreMarkedOnTheReminderLettersAsDisputed', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC083_SendReminderLetterToCustomerViaEmail', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC084_PrintReminderLetterFromTheProposal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC085_AccessRemindersAlreadyIssuedInTheArchive', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC087_GenerateDunningBlockList', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC089_GenerateAgingReport', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC199_ApplyCustomerEarlyPaymentDiscountBasedOnTheIncomingPayment', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC1xx_CreateNewDiscountOrBonusConditionsTemporaryOrPermanent', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC1xxx_RemoveDiscount', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC059-UpdateCustomerRiskScore', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC060-UpdateCustomerCreditLimit', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG_IC_001_InterCompanySales', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOGNEW22_CTS', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC212_CheckPostingFlowForEarlyPaymentDiscount', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC21xxxRemovePromotions', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC2xxx_CreateAdjustPromotions', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC063_CheckDateOfTheLast_CreditRiskAssessmentFor_Customer', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC090_CreateCashCollection_NoFiscalDocumentOnCustomerAccount', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC091_PrintCashCollectionOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC198_GenerateReportWithDocumentsRequiringCorrectionsDueToPriceError', TRUE, DocRefNo);
        END;
        //HEI.16<<
    end;

    local procedure StPSkipTestScripts();
    var
        UnitTestingValue: Record "Unit Testing Value FND";
        SourceCodeSetup: Record "Source Code Setup";
        GeneralLedgerSetup1: Record "General Ledger Setup";
    begin
        IF COMPANYNAME = 'SellCo' THEN BEGIN
            //HEI.27
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP010_ProcessPOInvoice', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP011_ProcessPOCreditMemo', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP012_ProcessNPOInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_LOG026_Create&ReleaseWarehouseReceipt', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN024_ReleasePO', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP061-CreatePaymentProposal', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP067_Review&SendPaymentProposal', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP069_ApprovePaymentProposalL1', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP084_ProcessManualPayment', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN023_CreatePurchaseOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP015_CreateNPOCreditNote', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP087_CreateNPOPrepayment', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP018_CreatePOInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP073_ExecutePaymentBankConnectivity', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN003_CreateCallOffFromBlanketOrder', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN027_CreateCalloff', TRUE, DocRefNo);//HEI.08
                                                                                                               //HEI.02>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN001_ValidateContractHeader', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN002_ValidateContractItems', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN004-PurchaseOrder_SendtoSupplier', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN014 Display Purchase Order', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN017-Create Purchase Quote', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN018-Approve Purchase Quote', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN019-Create Purchase Order from Purchase Quote', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN020-Update Purchase Quote', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN021 Reject Purchase Quote', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN026 Sent PO to Approval', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN028 Approve Purchase Order', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PRD107-GoodsReceipt', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP040 Obsolete invoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP055 Negativetesting NPO Invoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP058_Negative_PO_CN', TRUE, DocRefNo);//HEI.08
                                                                                                             //HEI.04>>
                                                                                                             //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PTP091-Automatic clearing on GR or IR Account',TRUE,DocRefNo);//HEI.93
                                                                                                             //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PTP092-Review Consolidated GR or IR report',TRUE,DocRefNo);//HEI.93
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP091_Automatic_clearing_on_GR_or_IR_Account', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP092_Review_Consolidated_GR_or_IR_report', TRUE, DocRefNo);
            //HEI.04<<
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP102-Clearing_of_open_items_on_vendor_accounts', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP133_Reverse_Rejected_CN', TRUE, DocRefNo);//HEI.08
                                                                                                                  //HEI.04>>
                                                                                                                  //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PTP136-Reverse Manual Payment',TRUE,DocRefNo);//HEI.93
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP136_Reverse_Manual_Payment', TRUE, DocRefNo);
            //HEI.04<<
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP154-ApproveInvoice_noworkflow', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP157-RejectCreditNote_noworkflow', TRUE, DocRefNo);
            //HEI.02<<
            //HEI.04
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP062-CreatePaymentProposal', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP074 Execute Payment Cheques', TRUE, DocRefNo);//HEI.08
                                                                                                                      //HEI.04
                                                                                                                      //HEI.06>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN006_UpdateSpotPOorVLcalloff', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN008_CancelPurchaseOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN025_UpdatePxQreturncalloff', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP024_NPO_InvoiceReversal_Correction', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP027_ProcessLargeInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP028_AttachDocAfterPosting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP041_ObsoleteCN', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP042_CheckOnInvoiceNumberAllocatedTwice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP053_ProcessNPOInvoice_paymentmethod_otherthanBank', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP056_Negativetesting_PO_Invoice_DocDateError', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP056_Negativetesting_PO_Invoice_VendorInvError', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP056_Negativetesting_PO_Invoice_VATAmtError', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP057_Negative_NPO_CN_DocDateERROR', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP057_Negative_NPO_CN_VendCrNoError', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP057_Negative_NPO_CN_VATAmtError', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP057_Negative_NPO_CN_LinesError', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP068_Review_and_Undo_Payment_Proposal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP078_Reverse_payment_Rejected_payment', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP079_Block_invoice_for_payment', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP080_Unblock_invoice_for_payment', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP081_Create_Emergency_Payment_Proposal', TRUE, DocRefNo);//HEI.08
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP082_Process_PtP_Netting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP083_Reverse PtP Netting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP086_Reverse_Refund', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP103_Unapplying_of_cleared_items', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP132-ReverseRejectedInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP155-RejectInvoice_noworkflow', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP156-ApproveCreditNote_noworkflow', TRUE, DocRefNo);
            //HEI.06<<
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'CHG2123487_CMGMandatoryonHeiliteBaseSPOTPOforLandedCosts', TRUE, DocRefNo);//HEI.11
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN009_CreateReturnorderfromBlanketOrder', TRUE, DocRefNo);//HEI.12
                                                                                                                                //HEI.27
        END;
        //HEI.04
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PCN001');
        UnitTestingValue.SETRANGE("Table ID", 38);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN001_ValidateContractHeader', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PCN002');
        UnitTestingValue.SETRANGE("Table ID", 38);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN002_ValidateContractItems', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'STP_PCN003');
        UnitTestingValue.SETRANGE("Table ID", 38);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN003_CreateCallOffFromBlanketOrder', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PCN014');
        UnitTestingValue.SETRANGE("Table ID", 38);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN014 Display Purchase Order', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PCN027');
        UnitTestingValue.SETRANGE("Table ID", 38);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN027_CreateCalloff', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP091');
        UnitTestingValue.SETRANGE("Table ID", 15);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP091_Automatic_clearing_on_GR_or_IR_Account', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PRD107');
        UnitTestingValue.SETRANGE("Table ID", 14);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PRD107-GoodsReceipt', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PRD107');
        UnitTestingValue.SETRANGE("Table ID", 27);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PRD107-GoodsReceipt', TRUE, DocRefNo);
        END;
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP061-CreatePaymentProposal', TRUE, DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP067_Review&SendPaymentProposal', TRUE, DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP069_ApprovePaymentProposalL1', TRUE, DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP073_ExecutePaymentBankConnectivity', TRUE, DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP062-CreatePaymentProposal', TRUE, DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP074 Execute Payment Cheques', TRUE, DocRefNo);
        //HEI.04
        //HEI.06>>
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PCN025');
        UnitTestingValue.SETRANGE("Table ID", 38);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN025_UpdatePxQreturncalloff', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP053');
        UnitTestingValue.SETRANGE("Table ID", 23);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP053_ProcessNPOInvoice_paymentmethod_otherthanBank', TRUE, DocRefNo);
        END;

        //HEI.67>>
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP028');
        UnitTestingValue.SETRANGE("Table ID", 23);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP028_AttachDocAfterPosting', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP102');
        UnitTestingValue.SETRANGE("Table ID", 23);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP102-Clearing_of_open_items_on_vendor_accounts', TRUE, DocRefNo);
        END;
        //HEI.67<<

        //HEI.75>>
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP011');
        UnitTestingValue.SETRANGE("Table ID", 6505);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP011_ProcessPOCreditMemo', TRUE, DocRefNo);//HEI.76
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PTP058_Negative_PO_CN',TRUE,DocRefNo);//HEI.76
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP058');
        UnitTestingValue.SETRANGE("Table ID", 6505);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP058_Negative_PO_CN', TRUE, DocRefNo);//HEI.76
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'RT_PTP011_ProcessPOCreditMemo',TRUE,DocRefNo);//HEI.76
        END;
        //HEI.75<<

        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP068_Review_and_Undo_Payment_Proposal', TRUE, DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP081_Create_Emergency_Payment_Proposal', TRUE, DocRefNo);
        //HEI.06<<
        //HEI.11>>
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'CHG2123487');
        UnitTestingValue.SETRANGE("Table ID", 5790);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'CHG2123487_CMGMandatoryonHeiliteBaseSPOTPOforLandedCosts', TRUE, DocRefNo);
        END;
        //HEI.11<<
        //HEI.12>>
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PCN009');
        UnitTestingValue.SETRANGE("Table ID", 38);
        IF UnitTestingValue.FINDFIRST() THEN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN009_CreateReturnorderfromBlanketOrder', TRUE, DocRefNo);
        //HEI.12<<
        //HEI.36>>
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('Almaza') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP087_CreateNPOPrepayment', TRUE, DocRefNo);
        END;
        //HEI.36<<

        //HEI.49>>
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP082');
        UnitTestingValue.SETRANGE("Table ID", 232);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue."Value 2" = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP082_Process_PtP_Netting', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP083');
        UnitTestingValue.SETRANGE("Table ID", 232);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue."Value 2" = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP083_Reverse PtP Netting', TRUE, DocRefNo);
        END;
        //HEI.49<<
        //HEI.63>>
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_BRARUDI') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN004-PurchaseOrder_SendtoSupplier', TRUE, DocRefNo);
        END;
        //HEI.63<<
        //HEI.79<<
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP010');
        UnitTestingValue.SETRANGE("Table ID", 23);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP010_ProcessPOInvoice', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP011');
        UnitTestingValue.SETRANGE("Table ID", 23);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP011_ProcessPOCreditMemo', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP012');
        UnitTestingValue.SETRANGE("Table ID", 23);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP012_ProcessNPOInvoice', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP015');
        UnitTestingValue.SETRANGE("Table ID", 23);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP015_CreateNPOCreditNote', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP018');
        UnitTestingValue.SETRANGE("Table ID", 23);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP018_CreatePOInvoice', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP040');
        UnitTestingValue.SETRANGE("Table ID", 23);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP040 Obsolete invoice', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP041');
        UnitTestingValue.SETRANGE("Table ID", 23);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP041_ObsoleteCN', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP042');
        UnitTestingValue.SETRANGE("Table ID", 23);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP042_CheckOnInvoiceNumberAllocatedTwice', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP055');
        UnitTestingValue.SETRANGE("Table ID", 23);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'Negativetesting NPO Invoice', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP056');
        UnitTestingValue.SETRANGE("Table ID", 23);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP056_Negativetesting_PO_Invoice_DocDateError', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP057');
        UnitTestingValue.SETRANGE("Table ID", 23);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP057_Negative_NPO_CN_DocDateERROR', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP058');
        UnitTestingValue.SETRANGE("Table ID", 23);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP058_Negative_PO_CN', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP087');
        UnitTestingValue.SETRANGE("Table ID", 23);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP087_CreateNPOPrepayment', TRUE, DocRefNo);
        END;


        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP010');
        UnitTestingValue.SETRANGE("Table ID", 288);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP010_ProcessPOInvoice', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP056');
        UnitTestingValue.SETRANGE("Table ID", 288);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP056_Negativetesting_PO_Invoice_DocDateError', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP058');
        UnitTestingValue.SETRANGE("Table ID", 288);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP058_Negative_PO_CN', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP087');
        UnitTestingValue.SETRANGE("Table ID", 288);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP087_CreateNPOPrepayment', TRUE, DocRefNo);
        END;
        //HEI.79>>
        //HEI.91>>
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'CHG2098629');
        UnitTestingValue.SETRANGE("Table ID", 23);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'CHG2098629_AutomaticCreationofTransferOrderforImportPO', TRUE, DocRefNo);
        END;
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'CHG2095531');
        UnitTestingValue.SETRANGE("Table ID", 23);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN BEGIN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC1', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC2', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC3', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC4', TRUE, DocRefNo);
            END;
        END;

        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'CHG2065545');
        UnitTestingValue.SETRANGE("Table ID", 23);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'CHG2065545_FA_PurchaseOrder', TRUE, DocRefNo);
        END;
        //HEI.91<<
        //HEI.94>>
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'CHG2095531');
        UnitTestingValue.SETRANGE("Table ID", 38);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN BEGIN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC4', TRUE, DocRefNo);
            END;
        END;
        //HEI.94<<
        //HEI.95>>
        PnpSetup.GET();
        IF (PnpSetup."Location Code Imp Proc. FND" = '') OR (UPPERCASE(COMPANYNAME) = UPPERCASE('Tango')) THEN //HEI.102
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'CHG2098629_AutomaticCreationofTransferOrderforImportPO', TRUE, DocRefNo);
        //HEI.95<<
        //HEI.96>>
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PCN023');
        UnitTestingValue.SETRANGE("Table ID", 232);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN BEGIN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP103_PaymentAlongWithAppliedAndUnappliedEntry', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP078_Reverse_payment_Rejected_payment', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP103_Unapplying_of_cleared_items', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP102-Clearing_of_open_items_on_vendor_accounts', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP136_Reverse_Manual_Payment', TRUE, DocRefNo); //HEI.104//HEI.113
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP086_Reverse_Refund', TRUE, DocRefNo);//HEI.105//HEI.113
            END;
        END;
        //HEI.96<<
        //HEI.97>>
        SourceCodeSetup.GET();
        //HEI.112>>
        GeneralLedgerSetup1.GET();//HEI.106>>
        IF (SourceCodeSetup."Payment Journal Tree FND" = '') OR (NOT GeneralLedgerSetup1."Enable WHT FND") THEN //HEI.111
                                                                                                        //IF SourceCodeSetup."Payment Journal Tree" = '' THEN //HEI.111
                                                                                                        //HEI.106<
                                                                                                        //HEI.112<<
          BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP103_PaymentAlongWithAppliedAndUnappliedEntry', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP078_Reverse_payment_Rejected_payment', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP103_Unapplying_of_cleared_items', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP102-Clearing_of_open_items_on_vendor_accounts', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP136_Reverse_Manual_Payment', TRUE, DocRefNo); //HEI.104//HEI.113
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP086_Reverse_Refund', TRUE, DocRefNo);//HEI.105 //HEI.113
        END;
        //HEI.97<<
        //HEI.98>>
        //HEI.99>>
        // IF COMPANYNAME  = UPPERCASE('10_BDB') THEN
        //  BEGIN
        //HEI.99<<
        //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PTP103_PaymentAlongWithAppliedAndUnappliedEntry',TRUE,DocRefNo);//HEI.113
        //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PTP078_Reverse_payment_Rejected_payment',TRUE,DocRefNo);//HEI.113
        //HEI.104>>
        //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PTP103_Unapplying_of_cleared_items',TRUE,DocRefNo); //HEI.113
        //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PTP102-Clearing_of_open_items_on_vendor_accounts',TRUE,DocRefNo);//HEI.113
        //HEI.104<<
        //HEI.99>>
        //HEI.101>>
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP084');
        UnitTestingValue.SETRANGE("Table ID", 232);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF (UnitTestingValue.Value = '') OR (UnitTestingValue."Value 2" = '') THEN BEGIN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP084_ProcessManualPayment', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP136_Reverse_Manual_Payment', TRUE, DocRefNo); //HEI.102
                                                                                                                          //HEI.104>>
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP103_Unapplying_of_cleared_items', TRUE, DocRefNo);//HEI.113
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP102-Clearing_of_open_items_on_vendor_accounts', TRUE, DocRefNo);//HEI.113
                                                                                                                                            //HEI.104<<
            END;
        END;
        //HEI.101<<
        //HEI.114>>
        IF NOT (UPPERCASE(COMPANYNAME) IN ['10_SierraLeone', 'BrewCo', 'SellCo', 'CBL', '10_BDB', 'Baru', '10_Haiti']) THEN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP091_Automatic_clearing_on_GR_or_IR_Account', TRUE, DocRefNo);//HEI.113

        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP091');
        UnitTestingValue.SETRANGE("Table ID", 232);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF (UnitTestingValue."Value 2" = '') OR (UnitTestingValue.Value = '') THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP091_Automatic_clearing_on_GR_or_IR_Account', TRUE, DocRefNo);
        END;
        //HEI.114<<
        //HEI.106>>
        //HEI.123>>
        //IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_LUBUMBASHI') THEN BEGIN //HEI.108 //HEI.112
        IF (UPPERCASE(COMPANYNAME) IN ['10_LUBUMBASHI', '10_BDB', '10_BRASSIVOIRE', '10_Haiti']) THEN BEGIN
            //HEI.123<<
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN026 Sent PO to Approval', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN028 Approve Purchase Order', TRUE, DocRefNo);
        END;//HEI.112
            //HEI.106<<
            //    END;
            //HEI.99<<
            //HEI.98<<
            //HEI.113>>
            //HEI.105>>
            /*UnitTestingValue.RESET;
            UnitTestingValue.SETRANGE("Test Script Code",'PCN023');
            UnitTestingValue.SETRANGE("Table ID",23);
            IF UnitTestingValue.FINDFIRST THEN BEGIN
            IF UnitTestingValue.Value='' THEN
              BEGIN
                 CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PTP103_PaymentAlongWithAppliedAndUnappliedEntry',TRUE,DocRefNo);
                 CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PTP078_Reverse_payment_Rejected_payment',TRUE,DocRefNo);
                 CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PTP103_Unapplying_of_cleared_items',TRUE,DocRefNo);
                 CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PTP102-Clearing_of_open_items_on_vendor_accounts',TRUE,DocRefNo);
                 CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PTP136_Reverse_Manual_Payment',TRUE,DocRefNo);
                 CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PTP086_Reverse_Refund',TRUE,DocRefNo);
              END;
            END;*/
            //HEI.105<<
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PCN023');
        UnitTestingValue.SETRANGE("Table ID", 23);
        IF UnitTestingValue.FINDFIRST() THEN BEGIN
            IF UnitTestingValue.Value = '' THEN BEGIN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP103_PaymentAlongWithAppliedAndUnappliedEntry', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP078_Reverse_payment_Rejected_payment', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP103_Unapplying_of_cleared_items', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP102-Clearing_of_open_items_on_vendor_accounts', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP136_Reverse_Manual_Payment', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP086_Reverse_Refund', TRUE, DocRefNo);
            END;
        END;
        //HEI.113<<
        //HEI.108>>
        IF (UPPERCASE(COMPANYNAME) = UPPERCASE('10_WIND_LEE_BR')) OR (UPPERCASE(COMPANYNAME) = UPPERCASE('ALMAZA')) THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP086_Reverse_Refund', TRUE, DocRefNo);
        END;
        //HEI.108<<
        //HEI.115>>
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP102-Clearing_of_open_items_on_vendor_accounts', TRUE, DocRefNo);
        //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PTP086_Reverse_Refund',TRUE,DocRefNo); //HEI.118
        //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PTP136_Reverse_Manual_Payment',TRUE,DocRefNo);//HEI.116 //HEI.118
        //HEI.115<<
        //HEI.117>>
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Test Script Code", 'PTP136');
        UnitTestingValue.SETRANGE("Table ID", 232);
        IF UnitTestingValue.FINDFIRST() THEN
            IF (UnitTestingValue.Value = '') OR (UnitTestingValue."Value 2" = '') THEN BEGIN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP084_ProcessManualPayment', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP136_Reverse_Manual_Payment', TRUE, DocRefNo);
            END;
        //HEI.117<<
        //HEI.127>>
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('Brasco') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP082_Process_PtP_Netting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP083_Reverse PtP Netting', TRUE, DocRefNo);
        END;
        //HEI.127<<
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN003_CreateCallOffFromBlanketOrder', TRUE, DocRefNo); //HEI.128
        //HEI.130>>
        PnpSetup.GET();
        UnitTestingValue.RESET();
        UnitTestingValue.SETCURRENTKEY(Value, "Test Script Code");
        UnitTestingValue.SETRANGE(Value, '');
        UnitTestingValue.SETRANGE("Test Script Code", 'PCN029');
        IF NOT UnitTestingValue.ISEMPTY THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN029_ProcessPO-PI_GlobalUpperToleranceLimitPercentage', TRUE, DocRefNo);
        END ELSE BEGIN
            IF NOT PnpSetup."Check Tolerance Approval FND" OR (PnpSetup."Upper % Tolerance FND" = 0) THEN BEGIN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN029_ProcessPO-PI_GlobalUpperToleranceLimitPercentage', TRUE, DocRefNo);
            END;
        END;
        UnitTestingValue.SETRANGE("Test Script Code", 'PCN030');
        IF NOT UnitTestingValue.ISEMPTY THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN030_ProcessPO-PI_GlobalUpperToleranceLimitAmount', TRUE, DocRefNo);
        END ELSE BEGIN
            IF NOT PnpSetup."Check Tolerance Approval FND" OR (PnpSetup."Upper Amount Tolerance FND" = 0) THEN BEGIN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN030_ProcessPO-PI_GlobalUpperToleranceLimitAmount', TRUE, DocRefNo);
            END;
        END;
        //HEI.130<<

    end;

    local procedure RtRSkipTestScripts();
    var
        lUnitTestingVal: Record "Unit Testing Value FND";
        lPurchSetUp: Record "Purchases & Payables Setup";
        lGenJnlBatches: Record "Gen. Journal Batch";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalTemplate: Record "Gen. Journal Template";
        GLRegister: Record "G/L Register";
        lGenLedgSetup: Record "General Ledger Setup";
        lAnalysisView: Record "Analysis View";
        lGlAcc: Record "G/L Account";
        WIPAccFound: Boolean;
        BalWIPAccFound: Boolean;
        lGLBudget: Record "G/L Budget Name";
        LPurchRcptLine: Record "Purch. Rcpt. Line";
        lPurchLine: Record "Purchase Line";
        ItemChargeAssignmentPurch: Record "Item Charge Assignment (Purch)";
        lGLRegister: Record "G/L Register";
        RegisterFound: Boolean;
        GLEntry: Record "G/L Entry";
        ClosedEntry: Integer;
        RegisterNo: Integer;
        lDimVal: Record "Dimension Value";
        SpCh: Label '*''*';
        GenJournalLine: Record "Gen. Journal Line";
        lCustLedgEntry: Record "Cust. Ledger Entry";
        AppliedEntryExists: Boolean;
        lFALedgEntry: Record "FA Ledger Entry";
        lVendLedgEntry: Record "Vendor Ledger Entry";
        AppliedEntryExistsVend: Boolean;
        GLEntryApplicationBuffer: Record "G/L Entry Application Bffr FND";
        AppliedGl: Boolean;
        OPCOSetup: Record "General OpCo Setup FND";
        VLEClosed: Integer;
        CLEClosed: Integer;
        VendorLedgerEntry : Record "Vendor Ledger Entry";
        CustLedgerEntry : Record "Cust. Ledger Entry";
    begin
        //HEI.32>>
        lPurchSetUp.GET();
        IF lPurchSetUp."Posted Exp. Cost Doc. Nos. FND" = '' THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'AccrualPostingofItemCharges', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'AccrualPostingofServiceAndItemCharges', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'ServiceAccrualPosting', TRUE, DocRefNo);
        END;
        //HEI.53>>
        /*
        IF NOT ((lGenJnlBatches.GET('GENERAL','CLOSING')) OR (lGenJnlBatches.GET('RTR','CLOSING'))) THEN//HEI.47,HEI.50
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR129-BalanceCarryForward',TRUE,DocRefNo);
        */
        lUnitTestingVal.RESET();
        lUnitTestingVal.GET('ACPICHARGES', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(lUnitTestingVal.Value);
        IF NOT GenJournalBatch.GET(GenJournalTemplate.Name, 'CLOSING') THEN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR129-BalanceCarryForward', TRUE, DocRefNo);
        //HEI.53<<
        //HEI.32<<
        //HEI.66>>
        lUnitTestingVal.RESET();
        lUnitTestingVal.GET('RTR112', COMPANYNAME, DATABASE::"G/L Register");
        RegisterFound := FALSE;
        lGLRegister.RESET();
        lGLRegister.SETRANGE("Source Code", lUnitTestingVal.Value);
        lGLRegister.SETRANGE("Journal Batch Name", lUnitTestingVal."Value 2");
        lGLRegister.SETRANGE(Reversed, FALSE);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET as its being depreceted
        //IF lGLRegister.FINDSET(FALSE, FALSE) THEN BEGIN
        IF lGLRegister.FINDSET(FALSE) THEN BEGIN
        // BC Upgrade MISHRS14 <<

            REPEAT
                ClosedEntry := 0;
                RegisterNo := 0;

                // BC Upgrade MISHRS14 >>
                VLEClosed := 0;  //HEI.133
                // BC Upgrade MISHRS14 <<

                // BC Upgrade MISHRS14 >>
                CLEClosed := 0;  //HEI.134
                // BC Upgrade MISHRS14 <<

                GLEntry.RESET();
                GLEntry.SETRANGE("Entry No.", lGLRegister."From Entry No.", lGLRegister."To Entry No.");

                // BC Upgrade MISHRS14 >>
                // Removed false from FINDSET as its being depreceted
                //IF GLEntry.FINDSET(FALSE, FALSE) THEN BEGIN
                IF GLEntry.FINDSET(FALSE) THEN BEGIN
                    // BC Upgrade MISHRS14 <<

                    REPEAT
                        IF NOT GLEntry."Open FND" THEN
                            ClosedEntry += 1;
                    UNTIL GLEntry.NEXT() = 0;

                    // BC Upgrade MISHRS14 >>
                    //HEI.133>>
                    IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_WIND_LEE_BR') THEN BEGIN
                        VendorLedgerEntry.RESET;
                        VendorLedgerEntry.SETCURRENTKEY("Transaction No.");
                        VendorLedgerEntry.SETRANGE("Transaction No.",GLEntry."Transaction No.");
                        IF VendorLedgerEntry.FINDSET(FALSE) THEN REPEAT
                        IF ((VendorLedgerEntry."Remaining Amount" <> 0) AND (VendorLedgerEntry."Remaining Amount" <> VendorLedgerEntry.Amount)) OR ((VendorLedgerEntry."Remaining Amount" = 0) AND (NOT VendorLedgerEntry.Open)) THEN
                            VLEClosed +=1;
                        UNTIL VendorLedgerEntry.NEXT = 0;
                    END;
                    //HEI.133<<
                    // BC Upgrade MISHRS14 <<
                    
                    // BC Upgrade MISHRS14 >>
                    //HEI.134>>
                    IF UPPERCASE(COMPANYNAME) = UPPERCASE('13_HBSC') THEN BEGIN
                        CustLedgerEntry.RESET;
                        CustLedgerEntry.SETCURRENTKEY("Transaction No.");
                        CustLedgerEntry.SETRANGE("Transaction No.",GLEntry."Transaction No.");
                        IF CustLedgerEntry.FINDSET(FALSE) THEN REPEAT
                        IF ((CustLedgerEntry."Remaining Amount" <> 0) AND (CustLedgerEntry."Remaining Amount" <> CustLedgerEntry.Amount)) OR ((CustLedgerEntry."Remaining Amount" = 0) AND (NOT CustLedgerEntry.Open)) THEN
                            CLEClosed +=1;
                        UNTIL CustLedgerEntry.NEXT = 0;
                    END;
                    //HEI.134<<
                    // BC Upgrade MISHRS14 <<

                    IF ClosedEntry = 0 THEN BEGIN
                        RegisterFound := TRUE;
                        RegisterNo := lGLRegister."No.";
                    END;
                END;
            UNTIL (lGLRegister.NEXT() = 0) OR RegisterFound;
        END;
        // BC Upgrade MISHRS14 >>
        //HEI.133>>
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_WIND_LEE_BR') THEN BEGIN
        IF (NOT(VLEClosed = 0) OR (RegisterNo = 0)) THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR113-RevaluationofAP',TRUE,DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR114-RevaluationofTreasury',TRUE,DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR115-RevaluationofAR_AP_Treasury',TRUE,DocRefNo);
        END;
        END;
        //HEI.133<<
        // BC Upgrade MISHRS14 <<
        
        // BC Upgrade MISHRS14 >>
        //HEI.134>>
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('13_HBSC') THEN BEGIN
        IF (NOT(CLEClosed = 0) OR (RegisterNo = 0)) THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR113-RevaluationofAP',TRUE,DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR114-RevaluationofTreasury',TRUE,DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR115-RevaluationofAR_AP_Treasury',TRUE,DocRefNo);
        END;
        END;
        //HEI.134<<
        // BC Upgrade MISHRS14 <<

        IF RegisterNo = 0 THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR112-ManualRevaluationAR', TRUE, DocRefNo);//HEI.69
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR113-RevaluationofAP', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR114-RevaluationofTreasury', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR115-RevaluationofAR_AP_Treasury', TRUE, DocRefNo);
        END;

        //HEI.66<<
        //HEI.65>>
        LPurchRcptLine.RESET();
        LPurchRcptLine.SETRANGE("Posting Date", DMY2DATE(1, 1, 2022), TODAY);
        LPurchRcptLine.SETFILTER(Type, '%1|%2', LPurchRcptLine.Type::"G/L Account", LPurchRcptLine.Type::"Charge (Item)");
        IF LPurchRcptLine.FINDLAST() THEN BEGIN
            lPurchLine.RESET();
            lPurchLine.SETRANGE(lPurchLine."Document Type", lPurchLine."Document Type"::Order);
            lPurchLine.SETRANGE("Document No.", LPurchRcptLine."Order No.");
            lPurchLine.SETRANGE("Line No.", LPurchRcptLine."Order Line No.");
            IF lPurchLine.FINDFIRST() THEN BEGIN
                ItemChargeAssignmentPurch.RESET();
                ItemChargeAssignmentPurch.SETRANGE("Document Type", ItemChargeAssignmentPurch."Document Type"::Order);
                ItemChargeAssignmentPurch.SETRANGE("Document No.", lPurchLine."Document No.");
                IF NOT ItemChargeAssignmentPurch.FINDFIRST() THEN BEGIN
                    CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'AccrualPostingofItemCharges', TRUE, DocRefNo);
                    CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'AccrualPostingofServiceAndItemCharges', TRUE, DocRefNo);
                    CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'ServiceAccrualPosting', TRUE, DocRefNo);
                END;
            END;
        END;
        //HEI.65<<
        //HEI.58>>
        lGenLedgSetup.GET();
        IF (lGenLedgSetup."WIP Account FND" = '') OR (lGenLedgSetup."Bal. Wip Account FND" = '') THEN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'BPM013-CalculateandpostWiP', TRUE, DocRefNo);
        //HEI.58<<
        //HEI.64>>
        WIPAccFound := FALSE;
        BalWIPAccFound := FALSE;
        lGenLedgSetup.GET();
        lGlAcc.RESET();
        IF lGlAcc.GET(lGenLedgSetup."WIP Account FND") THEN
            WIPAccFound := TRUE;
        IF lGlAcc.GET(lGenLedgSetup."Bal. Wip Account FND") THEN
            BalWIPAccFound := TRUE;
        IF (WIPAccFound = FALSE) OR (BalWIPAccFound = FALSE) THEN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'BPM013-CalculateandpostWiP', TRUE, DocRefNo);

        lGLBudget.RESET();
        lGLBudget.SETRANGE(Name, 'CAPEX');
        IF NOT lGLBudget.FINDFIRST() THEN BEGIN//HEI.65
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'BPM040-RetrieveIncomeStatement', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'BPM041-RetrieveBalancesheet', TRUE, DocRefNo);//HEI.65
        END;//HEI.65
            //HEI.64<<

        //HEI.60>>
        IF lUnitTestingVal.GET('BPM013', COMPANYNAME, 232) THEN BEGIN
            IF lUnitTestingVal.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'BPM013-CalculateandpostWiP', TRUE, DocRefNo);
        END;
        //HEI.60<<
        //HEI.68>>
        IF lUnitTestingVal.GET('RTR119', COMPANYNAME, 5600) THEN BEGIN
            IF lUnitTestingVal.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR119-CalculateDepreciation', TRUE, DocRefNo);
        END;

        lDimVal.RESET();
        lDimVal.SETRANGE("Dimension Code", 'CAPEX');
        lDimVal.SETFILTER(Code, '%1', SpCh);
        IF lDimVal.FINDFIRST() THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'BPM040-RetrieveIncomeStatement', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'BPM041-RetrieveBalancesheet', TRUE, DocRefNo);
        END;
        //HEI.68<<
        //HEI.69>>
        IF lUnitTestingVal.GET('BPM013', COMPANYNAME, 232) THEN BEGIN
            IF lUnitTestingVal.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'BPM016-AllocatedimensionLogisticsexpenseCostdrivers', TRUE, DocRefNo);
        END;
        //HEI.69<<
        //HEI.62>>
        IF lUnitTestingVal.GET('RTR088', COMPANYNAME, 18) THEN BEGIN
            IF lUnitTestingVal.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR088-AssetDisposalSale', TRUE, DocRefNo);
        END;
        IF lUnitTestingVal.GET('RTR088', COMPANYNAME, 18) THEN BEGIN
            IF lUnitTestingVal.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR136-ManualMatching_SuspenseAccounts', TRUE, DocRefNo);
        END;

        IF lUnitTestingVal.GET('BPM042', COMPANYNAME, 363) THEN BEGIN
            IF NOT lAnalysisView.GET(lUnitTestingVal.Value) THEN BEGIN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'BPM042-Prepare_flatfile_for_CIL_reporting_EbF', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'BPM043-Prepare_flatfile_for_CIL_reporting_MSV', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'BPM044-Prepare_flatfile_for_CIL_reporting_WIS', TRUE, DocRefNo);
            END;
        END;
        //HEI.62<<


        //HEI.55>>
        IF lUnitTestingVal.GET('RTR136', COMPANYNAME, 15) THEN BEGIN
            IF lUnitTestingVal.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR136-ManualMatching_SuspenseAccounts', TRUE, DocRefNo);
        END;
        //HEI.55<<
        //HEI.43>>
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'BPM045-PlanVersionuploadandmaintenance', TRUE, DocRefNo);

        lUnitTestingVal.RESET();
        IF lUnitTestingVal.GET('RTR027', COMPANYNAME, DATABASE::"Gen. Journal Template") THEN;//HEI.107
        IF lUnitTestingVal.Value <> '' THEN//HEI.110
            GenJournalTemplate.GET(lUnitTestingVal.Value);

        lUnitTestingVal.RESET();
        IF lUnitTestingVal.GET('RTR027', COMPANYNAME, DATABASE::"Gen. Journal Batch") THEN;//HEI.107
        IF lUnitTestingVal.Value <> '' THEN//HEI.110
            GenJournalBatch.GET(GenJournalTemplate.Name, lUnitTestingVal.Value);

        IF NOT ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR033-ChangeRecurringPosting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR029-ApproveRecurringPosting', TRUE, DocRefNo);//HEI.53
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR032-RejectRecurringPosting', TRUE, DocRefNo);//HEI.53
        END;
        //HEI.50>>
        lUnitTestingVal.RESET();
        lUnitTestingVal.GET('RTR112', COMPANYNAME, DATABASE::"G/L Register");
        GLRegister.SETRANGE("Source Code", lUnitTestingVal.Value);
        GLRegister.SETRANGE("Journal Batch Name", lUnitTestingVal."Value 2");
        GLRegister.SETRANGE(Reversed, FALSE);
        IF NOT GLRegister.FINDFIRST() THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR113-RevaluationofAP', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR114-RevaluationofTreasury', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR115-RevaluationofAR_AP_Treasury', TRUE, DocRefNo);
        END;
        //HEI.50

        //HEI.43<<
        IF COMPANYNAME = 'SellCo' THEN BEGIN
            //HEI.28>>
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR001-ManualGLPosting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR003-Manual GLPosting2Approvers', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR005-ManualGLPostingMissingCCC', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR008-ManualGLPostingWithUpload', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR124-InventoryReconciliation', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR135-ManualBankStatementProcessing', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_BPM001-CalculateStandardCost', TRUE, DocRefNo);
            //HEI.28
        END;

        //HEI.22>>
        IF lUnitTestingVal.GET('RT_RTR001', COMPANYNAME, 232) THEN BEGIN
            IF lUnitTestingVal.Value = '' THEN BEGIN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR001-ManualGLPosting', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR003-Manual GLPosting2Approvers', TRUE, DocRefNo);//RTR003 use the same Unit Testing Values created for RTR001
                                                                                                                                //HEI.50>>
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR070-ImportPayrollFileWrongData', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR069-ImportPayrollFile', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR036-ManualGLReversalOpenPeriod', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR024-DeleteBatch', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR023-ChangeValuePosting', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR022-DisplayApprovalEntries', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR021-PostGenJournal', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR019-DeleteMultipleJournalLines', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR017-RejectGLPosting', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR016-ApproveRejectGLPosting2Approvers', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR015-ApproveGLPosting2Approvers', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR014-ApproveGLPosting', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR012-ManualGLPostingForeignCurrency', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR011-ManualGLPostingClosedPeriod', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR009-AccrualPostingReversal', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR007-GLMassUploadWithReversal', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR006-GLMassUploadWithoutReversal', TRUE, DocRefNo);
                //HEI.50<<
            END;
        END;
        IF lUnitTestingVal.GET('RT_RTR005', COMPANYNAME, 232) THEN BEGIN
            IF lUnitTestingVal.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR005-ManualGLPostingMissingCCC', TRUE, DocRefNo);
        END;
        //HEI.22<<
        //HEI.24>>
        IF lUnitTestingVal.GET('RT_RTR008', COMPANYNAME, 232) THEN BEGIN
            IF lUnitTestingVal.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR008-ManualGLPostingWithUpload', TRUE, DocRefNo);
        END;
        //HEI.24<<
        //HEI.50>>
        IF lUnitTestingVal.GET('ACPICHARGES', COMPANYNAME, 232) THEN BEGIN
            IF lUnitTestingVal.Value = '' THEN BEGIN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'ServiceAccrualPosting', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'AccrualPostingofServiceAndItemCharges', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'AccrualPostingofItemCharges', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR151-ManuallyPostRecurringEntries', TRUE, DocRefNo);
            END;
        END;
        IF lUnitTestingVal.GET('BPM013', COMPANYNAME, 232) THEN BEGIN
            IF lUnitTestingVal.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'BPM013-CalculateandpostWiP', TRUE, DocRefNo);
        END;


        IF lUnitTestingVal.GET('RTR136', COMPANYNAME, 232) THEN BEGIN
            IF lUnitTestingVal.Value = '' THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR136-ManualMatching_SuspenseAccounts', TRUE, DocRefNo);
        END;
        //HEI.50<<

        //HEI.70>>
        IF (UPPERCASE(COMPANYNAME) = UPPERCASE('13_HBSC')) OR (UPPERCASE(COMPANYNAME) = UPPERCASE('10_SierraLeone')) THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR102-CreationOfHeiMatchFlatFile', TRUE, DocRefNo);
        END;

        IF UPPERCASE(COMPANYNAME) = UPPERCASE('Brasco') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR113-RevaluationofAP', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR114-RevaluationofTreasury', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR115-RevaluationofAR_AP_Treasury', TRUE, DocRefNo);
        END;

        lGlAcc.RESET();
        lGlAcc.SETFILTER("No.", '%1', '*14221*');
        lGlAcc.SETRANGE("Direct Posting", TRUE);
        lGlAcc.SETRANGE(Blocked, FALSE);
        IF NOT lGlAcc.FINDFIRST() THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR122-CheckFilterSCOA', TRUE, DocRefNo);
        END;


        lUnitTestingVal.RESET();
        lUnitTestingVal.GET('RT_RTR008', COMPANYNAME, DATABASE::"Gen. Journal Template");
        IF lUnitTestingVal.Value <> '' THEN//HEI.71
            GenJournalTemplate.GET(lUnitTestingVal.Value);

        //Check default value for Journal Batch
        lUnitTestingVal.RESET();
        lUnitTestingVal.GET('RT_RTR008', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        IF lUnitTestingVal.Value <> '' THEN//HEI.71
            GenJournalBatch.GET(GenJournalTemplate.Name, lUnitTestingVal.Value);


        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.SETRANGE("Account Type", GenJournalLine."Account Type"::"G/L Account");

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET as its being depreceted
        // IF NOT GenJournalLine.FINDSET(FALSE, FALSE) THEN BEGIN
        IF NOT GenJournalLine.FINDSET(FALSE) THEN BEGIN
            // BC Upgrade MISHRS14 <<

            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR008-ManualGLPostingWithUpload', TRUE, DocRefNo);
        END;
        //HEI.70<<

        //HEI.71>>
        GLRegister.SETRANGE(Reversed, FALSE);
        GLRegister.SETFILTER("Journal Batch Name", '<>%1', '');
        GLRegister.SETFILTER("Source Code", '=%1', 'GENJNL');
        IF GLRegister.FINDLAST() THEN BEGIN
            lCustLedgEntry.RESET();
            lCustLedgEntry.SETRANGE("Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");


            // BC Upgrade MISHRS14 >>
            // Removed false from FINDSET as its being depreceted
            //IF lCustLedgEntry.FINDSET(FALSE, FALSE) THEN BEGIN
            IF lCustLedgEntry.FINDSET(FALSE) THEN BEGIN
                // BC Upgrade MISHRS14 <<

                AppliedEntryExists := FALSE;
                REPEAT
                    lCustLedgEntry.CALCFIELDS("Amount (LCY)");//HEI.78
                    IF lCustLedgEntry."Amount (LCY)" <> lCustLedgEntry."Remaining Amt. (LCY)" THEN
                        AppliedEntryExists := TRUE;
                UNTIL (lCustLedgEntry.NEXT() = 0) OR (AppliedEntryExists = TRUE);
            END;
            //HEI.77>>
            lVendLedgEntry.RESET();
            lVendLedgEntry.SETRANGE("Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");


            // BC Upgrade MISHRS14 >>
            // Removed false from FINDSET as its being depreceted
            //IF lVendLedgEntry.FINDSET(FALSE, FALSE) THEN BEGIN
            IF lVendLedgEntry.FINDSET(FALSE) THEN BEGIN
                // BC Upgrade MISHRS14 <<

                AppliedEntryExistsVend := FALSE;
                REPEAT
                    lVendLedgEntry.CALCFIELDS("Amount (LCY)");//HEI.78
                    IF lVendLedgEntry."Amount (LCY)" <> lVendLedgEntry."Remaining Amt. (LCY)" THEN
                        AppliedEntryExistsVend := TRUE;
                UNTIL (lVendLedgEntry.NEXT() = 0) OR (AppliedEntryExistsVend = TRUE);
            END;
            //HEI.77<<
            IF AppliedEntryExists OR AppliedEntryExistsVend THEN BEGIN //HEI.77
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR035-AutomaticReversalofGLposting', TRUE, DocRefNo);
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR115-AutomaticReversalofGLposting', TRUE, DocRefNo)//HEI.88
            END;
        END;
        //HEI.89>>
        /*//HEI.90
        GLRegister.SETRANGE(Reversed,FALSE);
        GLRegister.SETFILTER("Source Code",'=%1','GENJNL');
        IF GLRegister.FINDLAST THEN BEGIN
          GLEntryApplicationBuffer.RESET;
          GLEntryApplicationBuffer.SETRANGE("Entry No.",GLRegister."From Entry No.",GLRegister."To Entry No.");
          IF GLEntryApplicationBuffer.FINDSET(FALSE,FALSE) THEN BEGIN
            AppliedEntryExists := FALSE;
            REPEAT
               IF GLEntryApplicationBuffer.Amount <> GLEntryApplicationBuffer."Remaining Amount" THEN
                  AppliedEntryExistsVend := TRUE;
            UNTIL GLEntryApplicationBuffer.NEXT=0;
            IF AppliedGl THEN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR115-AutomaticReversalofGLposting',TRUE,DocRefNo)
            END;
        END;
        *///HEI.90
          //HEI.89<<

        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR038-ChangeLogReviewofGLPostings', TRUE, DocRefNo);
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_WIND_LEE_BR') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR087-AssetSplit', TRUE, DocRefNo);
        END;
        //HEI.71


        //HEI.74>>
        lUnitTestingVal.RESET();
        lUnitTestingVal.GET('RTR088', COMPANYNAME, DATABASE::"Fixed Asset");
        IF lUnitTestingVal.Value <> '' THEN BEGIN
            lFALedgEntry.RESET();
            lFALedgEntry.SETRANGE("FA No.", lUnitTestingVal.Value);
            lFALedgEntry.SETRANGE("Posting Date", CALCDATE('<-CY-1Y>', TODAY), CALCDATE('<CY>', TODAY));
            IF NOT lFALedgEntry.FINDFIRST() THEN
                CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR088-AssetDisposalSale', TRUE, DocRefNo);
        END;
        //HEI.74<<
        //HEI.119>>
        OPCOSetup.GET();
        IF OPCOSetup."Enable New EBF Matrix Version" THEN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'BPM046-CreateEbfMatrixRestriction', TRUE, DocRefNo);

        OPCOSetup.GET();
        IF NOT OPCOSetup."Enable New EBF Matrix Version" THEN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'BPM047-CreateNewEbfMatrixRestriction', TRUE, DocRefNo);
        //HEI.119<<
        //HEI.121>>
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('ALMAZA') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR001-ManualGLPosting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR003-Manual GLPosting2Approvers', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR006-GLMassUploadWithoutReversal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR007-GLMassUploadWithReversal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR009-AccrualPostingReversal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR012-ManualGLPostingForeignCurrency', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR014-ApproveGLPosting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR015-ApproveGLPosting2Approvers', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR016-ApproveRejectGLPosting2Approvers', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR017-RejectGLPosting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR022-DisplayApprovalEntries', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR023-ChangeValuePosting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR024-DeleteBatch', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR036-ManualGLReversalOpenPeriod', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR069-ImportPayrollFile', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR070-ImportPayrollFileWrongData', TRUE, DocRefNo);
        END;
        //HEI.121<<
        //HEI.126>>
        // lUnitTestingVal.RESET;//HEI.129
        // lUnitTestingVal.GET('RTR121',COMPANYNAME,DATABASE::"Fixed Asset");//HEI.129
        // CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR121-ManualReconciliation',TRUE,DocRefNo);//HEI.129

        //HEI.126<<

        //HEI.07>>
        /*
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RT_RTR001-ManualGLPosting',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RT_RTR003-Manual GLPosting2Approvers',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RT_RTR005-ManualGLPostingMissingCCC',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR006-GLMassUploadWithoutReversal',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR007-GLMassUploadWithReversal',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RT_RTR008-ManualGLPostingWithUpload',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR009-AccrualPostingReversal',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR011-ManualGLPostingClosedPeriod',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR012-ManualGLPostingForeignCurrency',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR014-ApproveGLPosting',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR015-ApproveGLPosting2Approvers',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR016-ApproveRejectGLPosting2Approvers',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR017-RejectGLPosting',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR019-DeleteMultipleJournalLines',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR021-PostGenJournal',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR022-DisplayApprovalEntries',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR023-ChangeValuePosting',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR024-DeleteBatch',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR027-EnterRecurringEntries',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR028-EnterRecurringEntriesBlankExpirationDate',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR029-ApproveRecurringPosting',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR032-RejectRecurringPosting',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR033-ChangeRecurringPosting',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR035-AutomaticReversalofGLposting',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR036-ManualGLReversalOpenPeriod',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RT_RTR135-ManualBankStatementProcessing',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RT_BPM001-CalculateStandardCost',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR069-ImportPayrollFile',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR070-ImportPayrollFileWrongData',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR087-AssetSplit',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR088-AssetDisposalSale',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR089-AssetDisposalScrapping',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR105-CreationOfTrialBalancePerLE',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR106-RunVariousStandardReports',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR122-CheckFilterSCOA',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR112-ManualRevaluationAR',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR114-RevaluationofTreasury',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR113-RevaluationofAP',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR115-RevaluationofAR_AP_Treasury',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR125-IntracompanyEliminationConsolidation',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'BPM042-Prepare_flatfile_for_CIL_reporting_EbF',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR130-PrepareFlatFileCIL_Intercompany',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR131-PrepareFlatFileCIL_FC&R',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR132-PrepareFlatFileCIL_FC&R-IS',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR134-BankStatementProcessing_AutomatedUpload',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR136-ManualMatching_SuspenseAccounts',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR138-ManualReconciliation_BankAccount',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR140-CashForecast_Preparation',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'BPM043-Prepare_flatfile_for_CIL_reporting_MSV',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'BPM044-Prepare_flatfile_for_CIL_reporting_WIS',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR144-PreparationVATdeclaration',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'BPM013-CalculateandpostWiP',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR120-Checkbalancingof7seriesSCOAAccounts',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR119-CalculateDepreciation',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR054-ClearingofGLAccountSelectionCriteria-Amount',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR055-ClearingGLAccSelectioncriteria-Remaining Amount',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR056-ClearingGLAccselectioncriteriaExternalDocumentNo',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR057-ClearingGLAccselectioncriteriaDocumentNo',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR058-ClearingGLAccselectioncriteriaAmountorDocumentNo',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR059-ClearingGLAccselectioncriteriaAmountOrExternalDocumentNo',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR060-ClearingGLAccselectioncriteriaAmtExternalDocOrDocumentNo',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR151-ManuallyPostRecurringEntries',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR129-BalanceCarryForward',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'BPM058-CheckPlandatauploadinAnalysisbydimensions',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'BPM040-RetrieveIncomeStatement',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'BPM041-RetrieveBalancesheet',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'BPM045-PlanVersionuploadandmaintenance',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'AccrualPostingofItemCharges',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'AccrualPostingofServiceAndItemCharges',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'ServiceAccrualPosting',TRUE,DocRefNo);
        */
        //HEI.07<<

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

    local procedure TestScriptsNeedsTobeFIXED();
    begin
        //HEI.10>>
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_BRARUDI') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG079_InboundProcessTransferOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC079_GenerateRemindersList', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC080_ExcludeReminderFromTheReminderList', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC081_ExcludeReminderLineInTheReminder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC082_CheckIfTheDisputedItemsAreMarkedOnTheReminderLettersAsDisputed', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC083_SendReminderLetterToCustomerViaEmail', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC084_PrintReminderLetterFromTheProposal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC085_AccessRemindersAlreadyIssuedInTheArchive', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC106_ReleaseAutomaticallyOrderDueToAutoCreditControlRecheck', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP082_Process_PtP_Netting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP083_Reverse PtP Netting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP136_Reverse_Manual_Payment', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP084_ProcessManualPayment', TRUE, DocRefNo);
        END;

        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_HBSC') THEN BEGIN
            //HEI.15>>
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOG015_ReturnRPMOrder_Upfront',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC005_CreateCustomerCombinedInvoice',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC090_CreateCashCollection_NoFiscalDocumentOnCustomerAccount',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC091_PrintCashCollectionOrder',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC098_CreateBlockedOrdersReport',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC104_RejectBlockedOrder',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC107_AccessOrdersReleasedInThePast_Archive',TRUE,DocRefNo);
            //HEI.15<<
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_LOG026_Create&ReleaseWarehouseReceipt', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN023_CreatePurchaseOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP018_CreatePOInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR001-ManualGLPosting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR003-Manual GLPosting2Approvers', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR135-ManualBankStatementProcessing', TRUE, DocRefNo);
        END;

        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_Haiti') THEN BEGIN
            //HEI.16>>
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOG079_InboundProcessTransferOrder',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOGNEW22_CTS',TRUE,DocRefNo);//HEI.17
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC002_CreateCustomerInvoice',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC079_GenerateRemindersList',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC080_ExcludeReminderFromTheReminderList',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC081_ExcludeReminderLineInTheReminder',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC082_CheckIfTheDisputedItemsAreMarkedOnTheReminderLettersAsDisputed',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC083_SendReminderLetterToCustomerViaEmail',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC084_PrintReminderLetterFromTheProposal',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC085_AccessRemindersAlreadyIssuedInTheArchive',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC090_CreateCashCollection_NoFiscalDocumentOnCustomerAccount',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC091_PrintCashCollectionOrder',TRUE,DocRefNo);
            //HEI.16<<
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP024_NPO_InvoiceReversal_Correction', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP027_ProcessLargeInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP055 Negativetesting NPO Invoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP082_Process_PtP_Netting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP083_Reverse PtP Netting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP132-ReverseRejectedInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP132-RT_PTP018_CreatePOInvoice', TRUE, DocRefNo);
            //HEI.14>>
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'RT_PTP018_CreatePOInvoice',TRUE,DocRefNo);//HEI.30
            //HEI.14<<
        END;

        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_BDB') THEN BEGIN
            //HEI.13>>
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOG022_1_Telesales_CallUpdate',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOG025_TransportCostCalculation',TRUE,DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOGNEW22_CTS', TRUE, DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC079_GenerateRemindersList',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC080_ExcludeReminderFromTheReminderList',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC081_ExcludeReminderLineInTheReminder',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC082_CheckIfTheDisputedItemsAreMarkedOnTheReminderLettersAsDisputed',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC083_SendReminderLetterToCustomerViaEmail',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC084_PrintReminderLetterFromTheProposal',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC085_AccessRemindersAlreadyIssuedInTheArchive',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC090_CreateCashCollection_NoFiscalDocumentOnCustomerAccount',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC091_PrintCashCollectionOrder',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC106_ReleaseAutomaticallyOrderDueToAutoCreditControlRecheck',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTCDD_CreationOfADirectDebitPaymentSlip',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTCDD1_PostingOfADirectDebitPaymentSlip',TRUE,DocRefNo);
            //HEI.13<<
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'RT_PCN024_ReleasePO',TRUE,DocRefNo);//HEI.31
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'RT_PTP018_CreatePOInvoice',TRUE,DocRefNo);//HEI.31
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR001-ManualGLPosting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR003-Manual GLPosting2Approvers', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR005-ManualGLPostingMissingCCC', TRUE, DocRefNo);
        END;

        IF UPPERCASE(COMPANYNAME) = UPPERCASE('ALMAZA') THEN BEGIN
            //HEI.18>>
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC063_CheckDateOfTheLast_CreditRiskAssessmentFor_Customer',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC079_GenerateRemindersList',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC080_ExcludeReminderFromTheReminderList',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC081_ExcludeReminderLineInTheReminder',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC082_CheckIfTheDisputedItemsAreMarkedOnTheReminderLettersAsDisputed',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC083_SendReminderLetterToCustomerViaEmail',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC084_PrintReminderLetterFromTheProposal',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC085_AccessRemindersAlreadyIssuedInTheArchive',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC090_CreateCashCollection_NoFiscalDocumentOnCustomerAccount',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC091_PrintCashCollectionOrder',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC176_CheckPostingFlowForTheRefundProposalPosting',TRUE,DocRefNo);
            //HEI.18<<
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP024_NPO_InvoiceReversal_Correction', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP027_ProcessLargeInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP053_ProcessNPOInvoice_paymentmethod_otherthanBank', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP055 Negativetesting NPO Invoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP082_Process_PtP_Netting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP083_Reverse PtP Netting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP132-ReverseRejectedInvoice', TRUE, DocRefNo);
            //HEI.18>>
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_OTC017_CreateCustomerCreditMemo_QuantityCorrection_GoodsLost_GoodsDamaged_QualityIssues',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_OTC023_CheckBillingPostingFlows_Corrections_DebitOrCredit',TRUE,DocRefNo);
            //HEI.18<<
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP012_ProcessNPOInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP018_CreatePOInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR005-ManualGLPostingMissingCCC', TRUE, DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'SLS_NEW3_RecurringLoyaltyJournal',TRUE,DocRefNo);  //HEI.18
        END;

        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_WIND_LEE_BR') THEN BEGIN
            //HEI.16>>
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOG079_InboundProcessTransferOrder',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOGNEW22_CTS',TRUE,DocRefNo); //HEI.17
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC079_GenerateRemindersList',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC080_ExcludeReminderFromTheReminderList',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC081_ExcludeReminderLineInTheReminder',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC082_CheckIfTheDisputedItemsAreMarkedOnTheReminderLettersAsDisputed',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC083_SendReminderLetterToCustomerViaEmail',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC084_PrintReminderLetterFromTheProposal',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC085_AccessRemindersAlreadyIssuedInTheArchive',TRUE,DocRefNo);
            //HEI.16<<
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP024_NPO_InvoiceReversal_Correction', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP055 Negativetesting NPO Invoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP018_CreatePOInvoice', TRUE, DocRefNo);
        END;

        IF UPPERCASE(COMPANYNAME) = UPPERCASE('20_DUBOLAY_BC') THEN BEGIN
            //HEI.16>>
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOG022_1_Telesales_CallUpdate',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOG022_2_Telesales_Overview',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOG022_5_Telesales_LinkToExistingSalesOrder',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOG022_6_Telesales_CreateNewUnplannedCall',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOG022_7_Telesales_RefreshTelesalesContact',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOGNEW22_CTS',TRUE,DocRefNo);//HEI.17
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC014_MonitorBilling',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTCDD_CreationOfADirectDebitPaymentSlip',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTCDD1_PostingOfADirectDebitPaymentSlip',TRUE,DocRefNo);
            //HEI.16<<
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN004-PurchaseOrder_SendtoSupplier', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'PCN008_CancelPurchaseOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN017-Create Purchase Quote', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP024_NPO_InvoiceReversal_Correction', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP027_ProcessLargeInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP079_Block_invoice_for_payment', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP080_Unblock_invoice_for_payment', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP132-ReverseRejectedInvoice', TRUE, DocRefNo);
            //HEI.16>>
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_LOG004_CreateFreeProductSalesOrder',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_LOG019_CreatePicking',TRUE,DocRefNo);
            //HEI.16<<
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_LOG026_Create&ReleaseWarehouseReceipt', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN023_CreatePurchaseOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN024_ReleasePO', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP018_CreatePOInvoice', TRUE, DocRefNo);
            //HEI.16>>
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'SLS_NEW1_CreateSalesOrderLoyalty',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'SLS_NEW2_LoyaltyJournal',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'SLS_NEW3_RecurringLoyaltyJournal',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'SLS015_CreateAndReleaseContractConditions_IndividualSalesConditions',TRUE,DocRefNo);
            //HEI.16<<
        END;

        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_SURIN_BROUWERIJ') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG035_TransferOrderProcess', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOG079_InboundProcessTransferOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'LOGNEW22_CTS', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC106_ReleaseAutomaticallyOrderDueToAutoCreditControlRecheck', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP024_NPO_InvoiceReversal_Correction', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP027_ProcessLargeInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP082_Process_PtP_Netting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP083_Reverse PtP Netting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP132-ReverseRejectedInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP136_Reverse_Manual_Payment', TRUE, DocRefNo);
            //HEI.21>>
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_OTC018_CreateCustomerDebitOrCreditMemo_PricingCorrectionOrRecharge_IncorrectPrice_IncorrectDiscounts_Recharges',TRUE,DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_OTC022_IssueCustomerBonusCreditMemo_3rdPartyBonusCalculation',TRUE,DocRefNo);
            //HEI.21<<
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP018_CreatePOInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP084_ProcessManualPayment', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS013_ApprovalCustomerFinancialAndSalesData_CustomerEqualToSoldTo', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS014_ApprovalCustomerFinancialAndSalesData_CustomerDifferentFromSoldTo', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'SLS015_CreateAndReleaseContractConditions_IndividualSalesConditions', TRUE, DocRefNo);
        END;

        IF UPPERCASE(COMPANYNAME) = UPPERCASE('20_PARBO_CENTRAL') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC029_CreateSundryCreditMemoAndSundryCreditNote', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC079_GenerateRemindersList', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC080_ExcludeReminderFromTheReminderList', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC081_ExcludeReminderLineInTheReminder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC082_CheckIfTheDisputedItemsAreMarkedOnTheReminderLettersAsDisputed', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC083_SendReminderLetterToCustomerViaEmail', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC084_PrintReminderLetterFromTheProposal', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC085_AccessRemindersAlreadyIssuedInTheArchive', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'OTC106_ReleaseAutomaticallyOrderDueToAutoCreditControlRecheck', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN004-PurchaseOrder_SendtoSupplier', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN008_CancelPurchaseOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN017-Create Purchase Quote', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP024_NPO_InvoiceReversal_Correction', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP027_ProcessLargeInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP082_Process_PtP_Netting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP083_Reverse PtP Netting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN008_CancelPurchaseOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_LOG026_Create&ReleaseWarehouseReceipt', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN023_CreatePurchaseOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN024_ReleasePO', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP018_CreatePOInvoice', TRUE, DocRefNo);
        END;

        IF UPPERCASE(COMPANYNAME) = UPPERCASE('Tango') THEN BEGIN
            //HEI.19>>
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOG014_CreateReturnOrder_Adhoc',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOG015_ReturnRPMOrder_Upfront',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOG020_CreateLoading',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOG021_CreateUnloadingAtWarehouse',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOG025_TransportCostCalculation',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOG035_TransferOrderProcess',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOG077_OutboundProcessSalesOrder',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOG079_InboundProcessTransferOrder',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOG082_InboundProcessSalesReturnOrder',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOGNEW1_CreateShipment',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOGNEW1_PostShipment',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOGNEW11_ActualDeliveryDateForCaseFillRate',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC002_CreateCustomerInvoice',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC005_CreateCustomerCombinedInvoice',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC006_CreateCustomerCreditNote',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC007_CreateCustomerCreditNote',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC008_CreateCustomerCrNotewithInvoice',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC025_CreateSundryOrderAnd_SundryInvoice',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC028_CheckITheLineItemDiscountCanBeEnteredOnTheOrderDuringTheOrderCreation',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC029_CreateSundryCreditMemoAndSundryCreditNote',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC053_CreateProformaInvoice_ManuallyFromTheOrder',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC059-UpdateCustomerRiskScore',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC060-UpdateCustomerCreditLimit',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC079_GenerateRemindersList',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC080_ExcludeReminderFromTheReminderList',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC081_ExcludeReminderLineInTheReminder',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC082_CheckIfTheDisputedItemsAreMarkedOnTheReminderLettersAsDisputed',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC083_SendReminderLetterToCustomerViaEmail',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC084_PrintReminderLetterFromTheProposal',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC085_AccessRemindersAlreadyIssuedInTheArchive',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC089_GenerateAgingReport',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC090_CreateCashCollection_NoFiscalDocumentOnCustomerAccount',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC091_PrintCashCollectionOrder',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC095_BlockOrderAutomaticallyDueToCreditLimitExceeded',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC096_BlockOrderAutomaticallyDueToOverdue',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC097_BlockOrderAutomaticallyDueToPackingCreditValueExceeded',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC098_CreateBlockedOrdersReport',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC104_RejectBlockedOrder',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC106_ReleaseAutomaticallyOrderDueToAutoCreditControlRecheck',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC107_AccessOrdersReleasedInThePast_Archive',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC152_CreateChequeJournalInHeiLiteNavisonForProcessing',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC153_PostCustomerChequesOnCustomerAccountBasedOnTheReferenceData',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC154_CheckChequePosting_PostingFlow',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC159_CreateCashJournal_AddOrAdjustOrRemoveCashPaymentLines',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC161_CheckPostingFlowForCashJournalPostingProcess',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC176_CheckPostingFlowForTheRefundProposalPosting',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC179_ReverseChequePostings',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC184_AdjustuploadFileData',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC1841_UpdatePriceviaSalesPriceWrksht',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC1842_UnitPriceviaItemList',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC1xx_CreateNewDiscountOrBonusConditionsTemporaryOrPermanent',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC1xxx_RemoveDiscount',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC21xxxRemovePromotions',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'OTC2xxx_CreateAdjustPromotions',TRUE,DocRefNo);
            //HEI.19<<
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP024_NPO_InvoiceReversal_Correction', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP027_ProcessLargeInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP053_ProcessNPOInvoice_paymentmethod_otherthanBank', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP055 Negativetesting NPO Invoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP082_Process_PtP_Netting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP083_Reverse PtP Netting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP132-ReverseRejectedInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP136_Reverse_Manual_Payment', TRUE, DocRefNo);
            //HEI.19>>
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_LOG001_CreateDomesticSalesOrder',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_LOG004_CreateFreeProductSalesOrder',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_LOG016_ReturnRPMOrder_RoutePlanning',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_LOG023_ReviewDifferenceSettlementOfCustomer',TRUE,DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_LOG026_Create&ReleaseWarehouseReceipt', TRUE, DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_OTC001_CreateCustomerInvoice_ManualCreation_SingleOrderInvoicing',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_OTC011_GenerateCopyOfTheInvoiceFromTheSystem',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_OTC017_CreateCustomerCreditMemo_QuantityCorrection_GoodsLost_GoodsDamaged_QualityIssues',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_OTC018_CreateCustomerDebitOrCreditMemo_PricingCorrectionOrRecharge_IncorrectPrice_IncorrectDiscounts_Recharges',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_OTC022_IssueCustomerBonusCreditMemo_3rdPartyBonusCalculation',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_OTC023_CheckBillingPostingFlows_Corrections_DebitOrCredit',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_OTC119_InputDisputeFlagandReasonCode',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_OTC122_InputDisputeResolutionCode',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_OTC130_ApplyPaymentAgainstInvoice',TRUE,DocRefNo);
            //HEI.19<<
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN023_CreatePurchaseOrder', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP012_ProcessNPOInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP018_CreatePOInvoice', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP084_ProcessManualPayment', TRUE, DocRefNo);
            //HEI.19>>
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_SLS009_ChangeCustomer',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_SLS018_DefineDeposits',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_SLS021_SetupDiscount',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'SLS010_IncompleteDataCustomer',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'SLS011_InactivateACustomer_Temporary',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'SLS012_InactivateACustomer_Permanently',TRUE,DocRefNo);
            //  CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'SLS014_ApprovalCustomerFinancialAndSalesData_CustomerDifferentFromSoldTo',TRUE,DocRefNo);
            //HEI.19<<
        END;

        IF UPPERCASE(COMPANYNAME) = UPPERCASE('Baru') THEN BEGIN
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_LOG019_CreatePicking',TRUE,DocRefNo);//HEI.17
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOGNEW22_CTS',TRUE,DocRefNo);//HEI.17
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN004-PurchaseOrder_SendtoSupplier', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP082_Process_PtP_Netting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP083_Reverse PtP Netting', TRUE, DocRefNo);
        END;

        //HEI.10<<
    end;

    procedure TestScriptsACC(SuiteName: Code[10]);
    begin
        //HEI.23>>

        CALTestSuite.RESET();
        CALTestSuite.DELETEALL();

        CALTestLineHNK.RESET();
        CALTestLineHNK.DELETEALL();


        CALTestSuite.INIT();
        CALTestSuite.Name := SuiteName;
        CALTestSuite.INSERT(TRUE);

        CALTestSuite.GET(SuiteName);

        ALLTestScriptsACC();
        //HEI.25>>
        //HEI.39>>
        //ExcludeCALTestScriptsFromRT();
        ExcludeCALTestScriptsFromRTACC();
        //HEI.39<<
        //HEI.25<<

        //HEI.23<<
    end;

    local procedure ExcludeCALTestScriptsFromRTACC();
    begin
        //>>HEI.39>>
        DtWSkipTestScripts();
        MtCSkipTestScripts();
        StPSkipTestScripts();
        RtRSkipTestScripts();
        HTSSkipTestScripts();
        //HEI.10>>
        //TestScriptsNeedsTobeFIXED;
        //HEI.10<<
        //>>HEI.39<<
        //>>HEI.41>>
        ExcludeLongRuuningTestScriptsACC();
        //>>HEI.41<<
    end;

    local procedure ALLTestScriptsACC();
    var
        GLAccount: Record "G/L Account";
        DefaultDim: Record "Default Dimension";
    begin
        //HEI.40>>
        //Phase 1 MTC>>
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG001_CreateDomesticSalesOrder', TRUE, DocRefNo);  //MTC1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG016_ReturnRPMOrder_RoutePlanning', TRUE, DocRefNo);  //MTC1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG017_CreateTransportPlanning', TRUE, DocRefNo);  //MTC1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG023_ReviewDifferenceSettlementOfCustomer', TRUE, DocRefNo);  //MTC1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG004_CreateFreeProductSalesOrder', TRUE, DocRefNo);  //MTC1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC001_CreateCustomerInvoice_ManualCreation_SingleOrderInvoicing', TRUE, DocRefNo);  //MTC1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC011_GenerateCopyOfTheInvoiceFromTheSystem', TRUE, DocRefNo);  //MTC1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC022_IssueCustomerBonusCreditMemo_3rdPartyBonusCalculation', TRUE, DocRefNo);  //MTC1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC017_CreateCustomerCreditMemo_QuantityCorrection_GoodsLost_GoodsDamaged_QualityIssues', TRUE, DocRefNo);  //MTC1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC018_CreateCustomerDebitOrCreditMemo_PricingCorrectionOrRecharge_IncorrectPrice_IncorrectDiscounts_Recharges', TRUE, DocRefNo);  //MTC1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC023_CheckBillingPostingFlows_Corrections_DebitOrCredit', TRUE, DocRefNo);  //MTC1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_SLS009_ChangeCustomer', TRUE, DocRefNo);  //MTC1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC119_InputDisputeFlagandReasonCode', TRUE, DocRefNo);  //MTC1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC122_InputDisputeResolutionCode', TRUE, DocRefNo);  //MTC1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_SLS018_DefineDeposits', TRUE, DocRefNo);  //MTC1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_SLS021_SetupDiscount', TRUE, DocRefNo);  //MTC1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_OTC130_ApplyPaymentAgainstInvoice', TRUE, DocRefNo);  //MTC1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG019_CreatePicking', TRUE, DocRefNo);  //MTC1
                                                                                                            //Phase 1 MTC<<

        //Phase2 MTC<<
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG014_CreateReturnOrder_Adhoc', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG015_ReturnRPMOrder_Upfront', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG021_CreateUnloadingAtWarehouse', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG035_TransferOrderProcess', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG041_SalesOrderBilling', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG042_SalesReturnOrderBilling', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOGNEW1_CreateShipment', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOGNEW1_PostShipment', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG020_CreateLoading', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC053_CreateProformaInvoice_ManuallyFromTheOrder', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC025_CreateSundryOrderAnd_SundryInvoice', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC028_CheckITheLineItemDiscountCanBeEnteredOnTheOrderDuringTheOrderCreation', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC029_CreateSundryCreditMemoAndSundryCreditNote', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC152_CreateChequeJournalInHeiLiteNavisonForProcessing', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC153_PostCustomerChequesOnCustomerAccountBasedOnTheReferenceData', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC154_CheckChequePosting_PostingFlow', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC159_CreateCashJournal_AddOrAdjustOrRemoveCashPaymentLines', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC161_CheckPostingFlowForCashJournalPostingProcess', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC176_CheckPostingFlowForTheRefundProposalPosting', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC002_CreateCustomerInvoice', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC006_CreateCustomerCreditNote', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC005_CreateCustomerCombinedInvoice', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC007_CreateCustomerCreditNote', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC008_CreateCustomerCrNotewithInvoice', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC014_MonitorBilling', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation_CreateShippingAgent', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG025_TransportCostCalculation', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC095_BlockOrderAutomaticallyDueToCreditLimitExceeded', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC096_BlockOrderAutomaticallyDueToOverdue', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC097_BlockOrderAutomaticallyDueToPackingCreditValueExceeded', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC098_CreateBlockedOrdersReport', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC104_RejectBlockedOrder', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC106_ReleaseAutomaticallyOrderDueToAutoCreditControlRecheck', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC107_AccessOrdersReleasedInThePast_Archive', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC1842_UnitPriceviaItemList', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC1841_UpdatePriceviaSalesPriceWrksht', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC184_AdjustuploadFileData', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOGNEW11_ActualDeliveryDateForCaseFillRate', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC179_ReverseChequePostings', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG076_AutomaticRegistryInboundGateEntry', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG077_OutboundProcessSalesOrder', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG078_OutboundProcessTransferOrder', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG079_InboundProcessTransferOrder', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG080_OutboundProcessPurchaseReturnOrder', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG081_InboundProcessPurchaseOrder', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG082_InboundProcessSalesReturnOrder', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS010_IncompleteDataCustomer', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS011_InactivateACustomer_Temporary', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS012_InactivateACustomer_Permanently', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS013_ApprovalCustomerFinancialAndSalesData_CustomerEqualToSoldTo', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS014_ApprovalCustomerFinancialAndSalesData_CustomerDifferentFromSoldTo', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS015_CreateAndReleaseContractConditions_IndividualSalesConditions', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS001_CreateCustomerSoldToPayer', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS002_CreateCustomerShiptoOutlet', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS004_CreateCustomerEmployee', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS003_CreateCustomerOutlet', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS005_CreateCustomerIntercompany', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS008_DuplicateCustomerSoldTo', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC079_GenerateRemindersList', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC080_ExcludeReminderFromTheReminderList', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC081_ExcludeReminderLineInTheReminder', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC082_CheckIfTheDisputedItemsAreMarkedOnTheReminderLettersAsDisputed', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC083_SendReminderLetterToCustomerViaEmail', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC084_PrintReminderLetterFromTheProposal', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC085_AccessRemindersAlreadyIssuedInTheArchive', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC087_GenerateDunningBlockList', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC089_GenerateAgingReport', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC199_ApplyCustomerEarlyPaymentDiscountBasedOnTheIncomingPayment', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC1xx_CreateNewDiscountOrBonusConditionsTemporaryOrPermanent', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC1xxx_RemoveDiscount', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC059-UpdateCustomerRiskScore', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC060-UpdateCustomerCreditLimit', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_1_Telesales_CallUpdate', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_2_Telesales_Overview', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_3_Telesales_NewSalesOrderBySalesItemHistory', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_4_Telesales_NewSalesOrderByUnplannedOrder', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_5_Telesales_LinkToExistingSalesOrder', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_6_Telesales_CreateNewUnplannedCall', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOG022_7_Telesales_RefreshTelesalesContact', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'LOGNEW22_CTS', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC212_CheckPostingFlowForEarlyPaymentDiscount', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC21xxxRemovePromotions', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD_CreationOfADirectDebitPaymentSlip', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTCDD1_PostingOfADirectDebitPaymentSlip', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW1_CreateSalesOrderLoyalty', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW2_LoyaltyJournal', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'SLS_NEW3_RecurringLoyaltyJournal', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC2xxx_CreateAdjustPromotions', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC063_CheckDateOfTheLast_CreditRiskAssessmentFor_Customer', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC090_CreateCashCollection_NoFiscalDocumentOnCustomerAccount', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC091_PrintCashCollectionOrder', TRUE, DocRefNo);  //MTC2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'OTC198_GenerateReportWithDocumentsRequiringCorrectionsDueToPriceError', TRUE, DocRefNo);  //MTC2
                                                                                                                                                          //Phase2 MTC<<


        //Phase 1 STP>>
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP010_ProcessPOInvoice', TRUE, DocRefNo);  //STP1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP012_ProcessNPOInvoice', TRUE, DocRefNo);  //STP1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP011_ProcessPOCreditMemo', TRUE, DocRefNo);  //STP1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_LOG026_Create&ReleaseWarehouseReceipt', TRUE, DocRefNo);  //STP1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN024_ReleasePO', TRUE, DocRefNo);  //STP1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP061-CreatePaymentProposal', TRUE, DocRefNo);  //STP1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP067_Review&SendPaymentProposal', TRUE, DocRefNo);  //STP1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP069_ApprovePaymentProposalL1', TRUE, DocRefNo);  //STP1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP084_ProcessManualPayment', TRUE, DocRefNo);  //STP1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN023_CreatePurchaseOrder', TRUE, DocRefNo);  //STP1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP015_CreateNPOCreditNote', TRUE, DocRefNo);  //STP1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP087_CreateNPOPrepayment', TRUE, DocRefNo);  //STP1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP018_CreatePOInvoice', TRUE, DocRefNo);  //STP1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PTP073_ExecutePaymentBankConnectivity', TRUE, DocRefNo);  //STP1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN003_CreateCallOffFromBlanketOrder', TRUE, DocRefNo);  //STP1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN027_CreateCalloff', TRUE, DocRefNo);  //STP1
        //Phase 1 STP<<
        //Phase2 STP>>
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PCN017-Create Purchase Quote', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PCN018-Approve Purchase Quote', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PCN019-Create Purchase Order from Purchase Quote', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PCN020-Update Purchase Quote', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PCN021 Reject Purchase Quote', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PCN026 Sent PO to Approval', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PCN028 Approve Purchase Order', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PCN001_ValidateContractHeader', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PCN002_ValidateContractItems', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP062-CreatePaymentProposal', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PCN004-PurchaseOrder_SendtoSupplier', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP154-ApproveInvoice_noworkflow', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP157-RejectCreditNote_noworkflow', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PRD107-GoodsReceipt', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP102-Clearing_of_open_items_on_vendor_accounts', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP133_Reverse_Rejected_CN', TRUE, DocRefNo);  //STP2
        //HEI.93>>
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PTP092-Review Consolidated GR or IR report',TRUE,DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP092_Review_Consolidated_GR_or_IR_report', TRUE, DocRefNo);  //STP2
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PTP136-Reverse Manual Payment',TRUE,DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP136_Reverse_Manual_Payment', TRUE, DocRefNo);  //STP2
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50205,'PTP091-Automatic clearing on GR or IR Account',TRUE,DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP091_Automatic_clearing_on_GR_or_IR_Account', TRUE, DocRefNo);  //STP2
        //HEI.93<<
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP055 Negativetesting NPO Invoice', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PCN014 Display Purchase Order', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP040 Obsolete invoice', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP074 Execute Payment Cheques', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PCN008_CancelPurchaseOrder', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PCN009_CreateReturnorderfromBlanketOrder', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PCN006_UpdateSpotPOorVLcalloff', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PCN025_UpdatePxQreturncalloff', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP024_NPO_InvoiceReversal_Correction', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP155-RejectInvoice_noworkflow', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP156-ApproveCreditNote_noworkflow', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP132-ReverseRejectedInvoice', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP027_ProcessLargeInvoice', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP028_AttachDocAfterPosting', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP041_ObsoleteCN', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP042_CheckOnInvoiceNumberAllocatedTwice', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP058_Negative_PO_CN', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP053_ProcessNPOInvoice_paymentmethod_otherthanBank', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP056_Negativetesting_PO_Invoice_DocDateError', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP056_Negativetesting_PO_Invoice_VendorInvError', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP056_Negativetesting_PO_Invoice_VATAmtError', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP057_Negative_NPO_CN_DocDateERROR', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP057_Negative_NPO_CN_VendCrNoError', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP057_Negative_NPO_CN_VATAmtError', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP057_Negative_NPO_CN_LinesError', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP082_Process_PtP_Netting', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP083_Reverse PtP Netting', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP086_Reverse_Refund', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP103_Unapplying_of_cleared_items', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP081_Create_Emergency_Payment_Proposal', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP080_Unblock_invoice_for_payment', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP079_Block_invoice_for_payment', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP078_Reverse_payment_Rejected_payment', TRUE, DocRefNo);  //STP2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50205, 'PTP068_Review_and_Undo_Payment_Proposal', TRUE, DocRefNo);  //STP2
                                                                                                                            //Phase2 STP<<

        //Phase 1 RTR>>
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR001-ManualGLPosting', TRUE, DocRefNo);  //RTR1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR003-Manual GLPosting2Approvers', TRUE, DocRefNo);  //RTR1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR008-ManualGLPostingWithUpload', TRUE, DocRefNo);  //RTR1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR124-InventoryReconciliation', TRUE, DocRefNo);  //RTR1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR135-ManualBankStatementProcessing', TRUE, DocRefNo);  //RTR1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RT_BPM001-CalculateStandardCost', TRUE, DocRefNo);  //RTR1
        //Phase 1 RTR<<
        //Phase2 RTR>>
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RT_RTR005-ManualGLPostingMissingCCC', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR006-GLMassUploadWithoutReversal', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR007-GLMassUploadWithReversal', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR009-AccrualPostingReversal', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR011-ManualGLPostingClosedPeriod', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR012-ManualGLPostingForeignCurrency', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR014-ApproveGLPosting', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR015-ApproveGLPosting2Approvers', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR016-ApproveRejectGLPosting2Approvers', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR017-RejectGLPosting', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR019-DeleteMultipleJournalLines', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR021-PostGenJournal', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR022-DisplayApprovalEntries', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR023-ChangeValuePosting', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR024-DeleteBatch', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR025-PrintGLRegisters', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR026-GLRegisterDimensions', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR027-EnterRecurringEntries', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR028-EnterRecurringEntriesBlankExpirationDate', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR029-ApproveRecurringPosting', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR032-RejectRecurringPosting', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR033-ChangeRecurringPosting', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR035-AutomaticReversalofGLposting', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR036-ManualGLReversalOpenPeriod', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR041-MonthEndSalesCutOff', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR069-ImportPayrollFile', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR070-ImportPayrollFileWrongData', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR073-CreateFixedAssetWrongCCC', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR074-FixedAssetModification', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR075-RPMAssetMasteDataCreation', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR077-ReviewFixedAsset', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR081-FixedAssetCorrectioOfSubclass', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR082-FixedAssetChangeLocationOrCCC', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR085-RunFixedAssetNetBookValue', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR087-AssetSplit', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR088-AssetDisposalSale', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR089-AssetDisposalScrapping', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR102-CreationOfHeiMatchFlatFile', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR104-CreationOfCashFlowPerLE', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR105-CreationOfTrialBalancePerLE', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR106-RunVariousStandardReports', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR111-ReclassificationDepositsForPackaging', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR116-ManualReconciliationARTrade', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR117-ManualReconciliationAPTrade', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR118-ReconciliationOfPettyCash', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR121-ManualReconciliation', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR122-CheckFilterSCOA', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR123-CheckFilterCustomerOrVendorsWithDebitOrCreditBalance', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR091-RPM_ReconcQuantitiesCheck', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR096-ChangeLog_AssetAccountingChecks', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR109-ManualCurrencyExchangeRateUpdate', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR112-ManualRevaluationAR', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR114-RevaluationofTreasury', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR113-RevaluationofAP', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR115-RevaluationofAR_AP_Treasury', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR125-IntracompanyEliminationConsolidation', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'BPM042-Prepare_flatfile_for_CIL_reporting_EbF', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR130-PrepareFlatFileCIL_Intercompany', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR131-PrepareFlatFileCIL_FC&R', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR132-PrepareFlatFileCIL_FC&R-IS', TRUE, DocRefNo);  //RTR2
        //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR134-BankStatementProcessing_AutomatedUpload',TRUE,DocRefNo);  //RTR2//HEI.92
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR136-ManualMatching_SuspenseAccounts', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR138-ManualReconciliation_BankAccount', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR140-CashForecast_Preparation', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR141-CreationofVATreport', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR145-Preparationwitholdingtaxdeclaration', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR147-Preparationexcisedutydeclaration', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'BPM043-Prepare_flatfile_for_CIL_reporting_MSV', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'BPM044-Prepare_flatfile_for_CIL_reporting_WIS', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR144-PreparationVATdeclaration', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR050-BlockexistingSCOA', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR043-DisplayaccounttypeofSCOAAccount', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR068-DisplaySCOAAccountwithfilterbytimeframes', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR044-DisplaylinktoCILofSCOAAccount', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR053-ChangeLogReviewofSCOAMasterDataChanges', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR067-DisplaySCOAAccountwithOpenCloseditems', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR042-DisplaySCOAChartofAccounts', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'BPM013-CalculateandpostWiP', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR071-ReviewPayrollPostings', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR120-Checkbalancingof7seriesSCOAAccounts', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR119-CalculateDepreciation', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR054-ClearingofGLAccountSelectionCriteria-Amount', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR055-ClearingGLAccSelectioncriteria-Remaining Amount', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR056-ClearingGLAccselectioncriteriaExternalDocumentNo', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR057-ClearingGLAccselectioncriteriaDocumentNo', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR058-ClearingGLAccselectioncriteriaAmountorDocumentNo', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR059-ClearingGLAccselectioncriteriaAmountOrExternalDocumentNo', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR060-ClearingGLAccselectioncriteriaAmtExternalDocOrDocumentNo', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR151-ManuallyPostRecurringEntries', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'BPM046-CreateEbfMatrixRestriction', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'SettingTheHeimatchSignToNochange', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'SettingTheHeimatchSignToReverse', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR038-ChangeLogReviewofGLPostings', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR039-GLRegisterReviewofGLPostings', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR040-GeneralLedgerEntriesReviewGLPostings', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'RTR129-BalanceCarryForward', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'BPM016-AllocatedimensionLogisticsexpenseCostdrivers', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'BPM058-CheckPlandatauploadinAnalysisbydimensions', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'BPM040-RetrieveIncomeStatement', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'BPM041-RetrieveBalancesheet', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'BPM045-PlanVersionuploadandmaintenance', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'BPM051-CreateCAPEXbudget', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'AssigningdefaultCCforInventoryAdjustment', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'AccrualPostingofItemCharges', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'AccrualPostingofServiceAndItemCharges', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'ServiceAccrualPosting', TRUE, DocRefNo);  //RTR2
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50209, 'BPM047-CreateNewEbfMatrixRestriction', TRUE, DocRefNo);//HEI.122
                                                                                                                       //HEI.124>>
                                                                                                                       //HEI.125
                                                                                                                       /*GLAccount.RESET;
                                                                                                                       GLAccount.SETRANGE(Blocked,FALSE);
                                                                                                                       GLAccount.SETRANGE("Direct Posting",TRUE);
                                                                                                                       GLAccount.SETRANGE("Account Type",GLAccount."Account Type"::Posting);
                                                                                                                       GLAccount.SETRANGE("Income/Balance",GLAccount."Income/Balance"::"Balance Sheet");
                                                                                                                       GLAccount.SETRANGE("Gen. Prod. Posting Group",'');
                                                                                                                       GLAccount.SETRANGE("VAT Prod. Posting Group",'');
                                                                                                                       IF GLAccount.FINDSET THEN REPEAT
                                                                                                                         DefaultDim.RESET;
                                                                                                                         DefaultDim.SETCURRENTKEY("Table ID","No.");
                                                                                                                         DefaultDim.SETRANGE("Table ID",15);
                                                                                                                         DefaultDim.SETRANGE("No.",GLAccount."No.");
                                                                                                                         DefaultDim.SETRANGE("Value Posting",DefaultDim."Value Posting"::" ");
                                                                                                                         IF DefaultDim.FINDFIRST THEN BEGIN
                                                                                                                            DefaultDim."Value Posting" :=DefaultDim."Value Posting"::"Code Mandatory";
                                                                                                                            DefaultDim.MODIFY;
                                                                                                                         END;
                                                                                                                       UNTIL GLAccount.NEXT = 0;*///HEI.125
                                                                                                                                                  //HEI.124<<

        //Phase2 RTR<<

        //Phase 1 DTW>>
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD001_CreateFPPOforWort_Brew_1', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD004_CheckDefaultRouting_Brew_2', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD005_AdjustRouting_Brew_3', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD013_AdjustBOM_Brew_4', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD006_ChangeStatustoRPO_Brew_5', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD011_EnterConsumQtywithLotSelection_Brew_6', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD010_ConsumeComponent&Produce Product_Brew_7', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD008_CorrectConsumedorProducedQuantities_Brew_8', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD083_FinishRPO_Brew_9', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD071_CreateFPPO_Packaging_1', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD074_CheckDefaultRouting_Packaging_2', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD075_AdjustRouting_Packaging_3', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD077_FPPOAdjustBOM_Packaging_4', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD076_FPPO-ChangeStatustoRPO_Packaging_5', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD081_EnterConsumQtywithLotSelection_Packaging_6', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD078_ConsumeComponentProduce Product_Packaging_7', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD070_CorrectConsumedorProducedQuantities_Packaging_8', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD083_FinishRPO_Packaging_9', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD080_MoveFPstoLogistics_Packaging_10', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD042-CreateRPO_FilterCapacity_1', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD040_CheckDefaultRouting_FilterCapacity_2', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD041_AdjustRouting_FilterCapacity_3', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD022_AdjustBOM_FilterCapacity_4', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD051_EnterConsumQtyToLotSelectionRPO_FilterCapacity_5', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD047_ConsumeComponentsProduceProducts_FilterCapacity_6', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD046_CorrectConsumedorProducedQuantities_FilterCapacity_7', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD052_FinsihRPO_FilterCapacity_8', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD055_CreateRPO_FilterationMixing_1', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD053_CheckDefaultRouting_FilterationMixing_2', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD054_AdjustRouting_FilterationMixing_3', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD066_AdjustBOM_FilterationMixing_4', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD059_ResourceSelectionOfAvailableTanks_FilterationMixing_5', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD067_EnterConsumptionQuantitiesBatchBin_FilterationMixing_6', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD061_ConsumeComponentsProduceProducts_FilterationMixing_7', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD069_FinishRPO_FilterationMixing_8', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD062_ReceiveProductstoQualityHoldstatus_FilterationMixing_9', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD064_ReleaseBrightBeertoPackaging_FilterationMixing_10', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD028_CreateRPO_Cellar_1', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD031_CheckDefaultRouting_Cellar_2', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD032_AdjustRouting_Cellar_3', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD037_AdjustBOM_Cellar_4', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD034_ResourceSelectionofAvailableTanks_Cellar_5', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD035_EnterNegativeConsumptionQuantities_Cellar_6', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD027_EnterConsumptionQuantitiesBatchBin_Cellar_7', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD084_ConsumeComponentsProduceProducts_Cellar_8', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD036_CorrectConsumedorProducedQuantities_Cellar_9', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD015_CreateRPO_Yeast_1', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD018_CheckDefaultRouting_Yeast_2', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD019_AdjustRoutingYeast_Yeast_3', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD022_AdjustBOM_Yeast_4', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD024_EnterConsumptionQty_Yeast_5', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD023_ConsumeComponentsProduceProducts_Yeast_6', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD021_CorrectConsumedorProducedQuantities_Yeast_7', TRUE, DocRefNo);  //DTW1
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD026_FinishRPO_Yeast_8', TRUE, DocRefNo);  //DTW1
                                                                                                                //Phase 1 DTW<<

        //Phase 2 DTW>>
        //HEI.48>>
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'DTW003_GoodsposttoCCC', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'PRD090_ProductionBOM', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'PRDE14_CreateBOMversions', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'PRDE15_ChangeBoM', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'PRDE15_RoutingHeader', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'PRDE16_CreateRoutinversions', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'PRDE17_ChangeRouting', TRUE, DocRefNo);
        //HEI.56>>
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'PRDE18_LinkedSKU', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'PRDE19_LinkingSKUtoItem', TRUE, DocRefNo);
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50172, 'PRDM06_MultipleUoMandConversion', TRUE, DocRefNo);
        //HEI.56<<

        //HEI.80>>
        ALLTestScriptACCWIP();
        //HEI.80<<

    end;

    local procedure ExcludeLongRuuningTestScriptsACC();
    begin
        //HEI.41>>
        //HEI.57>>
        // CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_OTC017_CreateCustomerCreditMemo_QuantityCorrection_GoodsLost_GoodsDamaged_QualityIssues',TRUE,DocRefNo);
        // CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_OTC023_CheckBillingPostingFlows_Corrections_DebitOrCredit',TRUE,DocRefNo);
        // CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOGNEW22_CTS',TRUE,DocRefNo);
        // CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'RT_LOG001_CreateDomesticSalesOrder',TRUE,DocRefNo);
        // CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50200,'LOG076_AutomaticRegistryInboundGateEntry',TRUE,DocRefNo);
        //HEI.57<<
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR140-CashForecast_Preparation', TRUE, DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR038-ChangeLogReviewofGLPostings', TRUE, DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR144-PreparationVATdeclaration', TRUE, DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'BPM016-AllocatedimensionLogisticsexpenseCostdrivers', TRUE, DocRefNo);
        //HEI.49>>
        //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR105-CreationOfTrialBalancePerLE',TRUE,DocRefNo);//HEI.72
        //HEI.49<<
        //HEI.73>>
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR105-CreationOfTrialBalancePerLE', TRUE, DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR141-CreationofVATreport', TRUE, DocRefNo);
        //HEI.73<<
        //HEI.41<<

        //HEI.46>>
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('Baru') THEN BEGIN
            //HEI.49>>
            //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR136-ManualMatching_SuspenseAccounts',TRUE,DocRefNo);  //RTR2
            //CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50209,'RTR140-CashForecast_Preparation',TRUE,DocRefNo);  //RTR2
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR136-ManualMatching_SuspenseAccounts',TRUE,DocRefNo);  //RTR2//HEI.72
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR136-ManualMatching_SuspenseAccounts', TRUE, DocRefNo);//HEI.73
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR140-CashForecast_Preparation', TRUE, DocRefNo);  //RTR2
                                                                                                                         //HEI.49<<
        END;

        //HEI.49>>
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('CBL') THEN BEGIN
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR136-ManualMatching_SuspenseAccounts',TRUE,DocRefNo);  //RTR2//HEI.72
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR136-ManualMatching_SuspenseAccounts', TRUE, DocRefNo);//HEI.73
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR071-ReviewPayrollPostings', TRUE, DocRefNo);  //RTR2
        END;

        IF UPPERCASE(COMPANYNAME) = UPPERCASE('Brasco') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR106-RunVariousStandardReports', TRUE, DocRefNo);  //RTR2
        END;

        //HEI.49<<

        //HEI.46<<
        //HEI.62>>
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('Tango') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR136-ManualMatching_SuspenseAccounts', TRUE, DocRefNo);  //RTR2
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR088-AssetDisposalSale', TRUE, DocRefNo);  //RTR2
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR089-AssetDisposalScrapping', TRUE, DocRefNo);  //RTR2
        END;
        //HEI.62<<
        //HEI.64>>
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50209, 'RTR106-RunVariousStandardReports', TRUE, DocRefNo);
        //HEI.64<<
    end;

    local procedure ALLTestScriptACCWIP();
    begin
        //HEI.80>>
        /*IF UPPERCASE(COMPANYNAME) = UPPERCASE('Tango') THEN BEGIN
           CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR014-ApproveGLPosting',TRUE,DocRefNo);
        END;
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('CBL') THEN BEGIN
           CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR014-ApproveGLPosting',TRUE,DocRefNo);
        END;*///HEI.82

        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_BRARUDI') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG023_ReviewDifferenceSettlementOfCustomer', TRUE, DocRefNo);
            //HEI.83
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'RT_LOG026_Create&ReleaseWarehouseReceipt',TRUE,DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'RT_PCN024_ReleasePO',TRUE,DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'RT_PCN023_CreatePurchaseOrder',TRUE,DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'RT_PCN027_CreateCalloff',TRUE,DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PCN017-Create Purchase Quote',TRUE,DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PCN018-Approve Purchase Quote',TRUE,DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PCN019-Create Purchase Order from Purchase Quote',TRUE,DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PCN020-Update Purchase Quote',TRUE,DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PCN021 Reject Purchase Quote',TRUE,DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PCN026 Sent PO to Approval',TRUE,DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PCN028 Approve Purchase Order',TRUE,DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PTP055 Negativetesting NPO Invoice',TRUE,DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PCN014 Display Purchase Order',TRUE,DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PCN008_CancelPurchaseOrder',TRUE,DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PCN006_UpdateSpotPOorVLcalloff',TRUE,DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PCN025_UpdatePxQreturncalloff',TRUE,DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PTP056_Negativetesting_PO_Invoice_VendorInvError',TRUE,DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PTP056_Negativetesting_PO_Invoice_VATAmtError',TRUE,DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PTP057_Negative_NPO_CN_VendCrNoError',TRUE,DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PTP057_Negative_NPO_CN_VATAmtError',TRUE,DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'PTP057_Negative_NPO_CN_LinesError',TRUE,DocRefNo);
            //HEI.83
            // CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR014-ApproveGLPosting',TRUE,DocRefNo);//HEI.85
            // CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR136-ManualMatching_SuspenseAccounts',TRUE,DocRefNo);//HEI.85
            //HEI.84>>
            /*
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD010_ConsumeComponent&Produce Product_Brew_7',TRUE,DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD008_CorrectConsumedorProducedQuantities_Brew_8',TRUE,DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD083_FinishRPO_Brew_9',TRUE,DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD023_ConsumeComponentsProduceProducts_Yeast_6',TRUE,DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD021_CorrectConsumedorProducedQuantities_Yeast_7',TRUE,DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD026_FinishRPO_Yeast_8',TRUE,DocRefNo);
            */
            //HEI.84<<
        END;
        //HEI.85
        /*
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('Brasco') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR014-ApproveGLPosting',TRUE,DocRefNo);
        END;
        
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_Haiti') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR014-ApproveGLPosting',TRUE,DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR136-ManualMatching_SuspenseAccounts',TRUE,DocRefNo);
        END;
        
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_BRASSIVOIRE') THEN BEGIN
           CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR014-ApproveGLPosting',TRUE,DocRefNo);
           CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR136-ManualMatching_SuspenseAccounts',TRUE,DocRefNo);
        END;
        *///HEI.85
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_BDB') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP082_Process_PtP_Netting', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PTP083_Reverse PtP Netting', TRUE, DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR014-ApproveGLPosting',TRUE,DocRefNo);//HEI.85
        END;

        //HEI.100>>
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('ALMAZA') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD047_ConsumeComponentsProduceProducts_FilterCapacity_6', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD023_ConsumeComponentsProduceProducts_Yeast_6', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD021_CorrectConsumedorProducedQuantities_Yeast_7', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50172, 'RT_PRD026_FinishRPO_Yeast_8', TRUE, DocRefNo);
        END;
        //HEI.100<<

        //IF UPPERCASE(COMPANYNAME) = UPPERCASE('ALMAZA') THEN BEGIN//HEI.85
        // CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR014-ApproveGLPosting',TRUE,DocRefNo);//HEI.85
        //HEI.81>>
        /*
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD071_CreateFPPO_Packaging_1',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD074_CheckDefaultRouting_Packaging_2',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD075_AdjustRouting_Packaging_3',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD077_FPPOAdjustBOM_Packaging_4',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD076_FPPO-ChangeStatustoRPO_Packaging_5',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD081_EnterConsumQtywithLotSelection_Packaging_6',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD078_ConsumeComponentProduce Product_Packaging_7',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD070_CorrectConsumedorProducedQuantities_Packaging_8',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD083_FinishRPO_Packaging_9',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD080_MoveFPstoLogistics_Packaging_10',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD023_ConsumeComponentsProduceProducts_Yeast_6',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD021_CorrectConsumedorProducedQuantities_Yeast_7',TRUE,DocRefNo);
        CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50172,'RT_PRD026_FinishRPO_Yeast_8',TRUE,DocRefNo);
        */
        //HEI.81<<
        //END;//HEI.85

        IF UPPERCASE(COMPANYNAME) = UPPERCASE('BrewCo') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'RT_PCN023_CreatePurchaseOrder', TRUE, DocRefNo);
            //HEI.85
            /*
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR014-ApproveGLPosting',TRUE,DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR136-ManualMatching_SuspenseAccounts',TRUE,DocRefNo);
            */
            //HEI.85
        END;

        //HEI.85>>
        /*
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('SellCo') THEN BEGIN
           CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR014-ApproveGLPosting',TRUE,DocRefNo);
           CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR136-ManualMatching_SuspenseAccounts',TRUE,DocRefNo);
        END;
        
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('Baru') THEN BEGIN
           CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR014-ApproveGLPosting',TRUE,DocRefNo);
        END;
        
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('Bralirwa') THEN BEGIN
           CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR014-ApproveGLPosting',TRUE,DocRefNo);
           CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR136-ManualMatching_SuspenseAccounts',TRUE,DocRefNo);
        END;
        *///HEI.85<<
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_SierraLeone') THEN BEGIN
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN019-Create Purchase Order from Purchase Quote', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN020-Update Purchase Quote', TRUE, DocRefNo);
            CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name, 50205, 'PCN021 Reject Purchase Quote', TRUE, DocRefNo);
            //HEI.85
            /*
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR014-ApproveGLPosting',TRUE,DocRefNo);
            //CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR136-ManualMatching_SuspenseAccounts',TRUE,DocRefNo);
            *///HEI.85
        END;
        //HEI.85>>
        /*
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_WIND_LEE_BR') THEN BEGIN
           CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR014-ApproveGLPosting',TRUE,DocRefNo);
           CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR136-ManualMatching_SuspenseAccounts',TRUE,DocRefNo);
        END;
        
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_SURIN_BROUWERIJ') THEN BEGIN
           CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR014-ApproveGLPosting',TRUE,DocRefNo);
           CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RTR136-ManualMatching_SuspenseAccounts',TRUE,DocRefNo);
        END;*///HEI.85<<

        //HEI.80<<
        //HEI.87>>
        /*
        //HEI.86>>
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('ALMAZA') THEN BEGIN
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RT_PRD023_ConsumeComponentsProduceProducts_Yeast_6',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RT_PRD021_CorrectConsumedorProducedQuantities_Yeast_7',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50209,'RT_PRD026_FinishRPO_Yeast_8',TRUE,DocRefNo);
          CALTestMgtHNK.SkipTestLineHNK(CALTestSuite.Name,50205,'RT_PTP018_CreatePOInvoice',TRUE,DocRefNo);
        END;
        
        CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name,50200,'RT_LOG023_ReviewDifferenceSettlementOfCustomer',TRUE,DocRefNo);
        //HEI.86<<
        */
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_BRARUDI') THEN BEGIN
            CALTestMgtHNK.AddTestLineHNK(CALTestSuite.Name, 50200, 'RT_LOG023_ReviewDifferenceSettlementOfCustomer', TRUE, DocRefNo);
        END;
        //HEI.87<<

    end;
}

