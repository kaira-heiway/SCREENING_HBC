codeunit 58126 "Unit Testing - RTR"
{
    // version TS,HEI.82

    // HEI.01 RITM2822071 BULIMC01 IBM 30/07/2021 # new codeunit created for RTR automated test scripts
    //     #new functions created for RTRPrio1 + RTRPrio2: "RT_RTR001-ManualGLPosting","RT_RTR003-Manual GLPosting2Approvers()", "RT_RTR124-InventoryReconciliation()","RT_RTR135-ManualBankStatementProcessing()"
    // HEI.02 RITM2822071 BULIMC01 IBM 02/08/2021
    //     #new functions created for RTRPrio3: "RT_RTR005-ManualGLPostingMissingCCC()","RTR006-GLMassUploadWithoutReversal()", "RTR007-GLMassUploadWithReversal()", "RTR009-AccrualPostingReversal()","RTR041-MonthEndSalesCutOff()"
    // HEI.03 RITM2822071 BULIMC01 IBM 03/08/2021
    //     #new functions created for RTRPrio4: "RTR011-ManualGLPostingClosedPeriod()","RTR012-ManualGLPostingForeignCurrency()","RTR014-ApproveGLPosting()","RTR015-ApproveGLPosting2Approvers()"
    //                                          "RTR016-ApproveRejectGLPosting2Approvers()","RTR017-RejectGLPosting()","RTR019-DeleteMultipleJournalLines()","RTR021-PostGenJournal()","RTR022-DisplayApprovalEntries()"
    // HEI.04 RITM2822071 BULIMC01 IBM 06/08/2021
    //     #new functions created for RTRPrio5: "RTR023-ChangeValuePosting","RTR024-DeleteBatch","RTR025-PrintGLRegisters()","RTR026-GLRegisterDimensions()","RTR027-EnterRecurringEntries()",
    //                                           "RTR028-EnterRecurringEntriesBlankExpirationDate()","RTR029-ApproveRecurringPosting()", "RTR032-RejectRecurringPosting()", "RTR033-ChangeRecurringPosting()"
    // HEI.05 SURYS01 IBM ???
    //     #new function created for RTR Prio6: "RTR035-AutomaticReversalofGLposting()", "RTR008-ManualGLPostingWithUpload()"
    // HEI.06 RITM2822071 BULIMC01 IBM 19/10/2021
    //     #new functions created for BPMPrio1: "RT_BPM001-CalculateStandardCost()"
    // HEI.07 RITM2822071 BULIMC01 IBM 18/10/2021
    //     #new functions created for RTRPrio7
    // HEI.08 RITM2822071 BULIMC01 IBM 11/10/2021 #new functions created "RTR116-ManualReconciliationARTrade","RTR121-ManualReconciliation","RTR122-CheckFilterSCOA","RTR123-CheckFilterCustomerOrVendorsWithDebitOrCreditBalance"
    // HEI.09 RITM2822071 BULIMC01 IBM 24/11/2021 #new function created: "RTR106-RunVariousStandardReports"
    // HEI.10 RITM2822071 BULIMC01 IBM 25/01/2022 #new functions created: "RTR091-RPM_ReconcQuantitiesCheck" and "RTR096-ChangeLog_AssetAccountingChecks"
    // HEI.11 RITM2822071 POENAB02 IBM 14/02/2022 Automation RTR Test Scripts
    //   #new functions created: RTR102-CreationOfHeiMatchFlatFile, RTR104-CreationOfCashFlowPerLE, RTR105-CreationOfTrialBalancePerLE,
    //     RTR111-ReclassificationDepositsForPackaging, RTR117-ManualReconciliationAPTrade, RTR118-ReconciliationOfPettyCash,
    //     VendorTrialBalanceReportHandler, HeimatchReportHandler, CustomerCardPageHandler, BankAccDetailTrialBalanceReportHandler,
    //     DetailTrialBalanceReportHandler, GLBalanceCardPageHandler, SuggestWorksheetLinesReportHandler, DialogRegisterCashFlowWorksheetPageHandler, ChartOfCashFlowAccountsPageHandler
    // HEI.12 RITM2822071 BULIMC01 IBM 05/04/2022 #new functions created: "RTR069-ImportPayrollFile", "RTR070-ImportPayrollFileWrongData","RTR036-ManualGLReversalOpenPeriod",
    //            "RTR130-PrepareFlatFileCILIntercompany","RTR131-PrepareFlatFileCIL_FC&R","RTR132-PrepareFlatFileCIL_FC&R-IS", "RTR125-IntracompanyEliminationConsolidation",
    //            "RTR134-BankStatementProcessing_AutomatedUpload","RTR136-ManualMatching_SuspenseAccounts","RTR138-ManualReconciliation_BankAccount","RTR140-CashForecast_Preparation"
    // HEI.13 RITM2822071 YADAVP04 IBM 16/02/2022 #new functions created "RTR109-ManualCurrencyExchangeRateUpdate","RTR112-ManualRevaluationAR","RTR114-RevaluationofTreasury","RTR113-RevaluationofAP","RTR115-RevaluationofAR_AP_Treasury" and many more
    // HEI.14 RITM2822071 POENAB02 IBM 09/03/2022 Automation RTR Test Scripts
    //   #modified functions RTR104-CreationOfCashFlowPerLE, SuggestWorksheetLinesReportHandler
    // HEI.15 RITM2822071 BULIMC01 IBM 14/04/2022 #update the functions which upload excel file to take the path from Temp folder
    // HEI.16 RITM2822071 IBM NASTAA02 26.05.2022 # Automation RTR Test Scripts
    //   # Fixes applied for existing Test Functions
    //   # New functions created
    // HEI.17 RITM2822071 IBM BHATTA09 02.08.2022 # Automation RTR Test Scripts- Bug fix for RTR005
    // HEI.18 RITM2822071 IBM BHATTA09 11.08.2022 # Automation RTR Test Scripts- Bug fix for file path for upload
    // HEI.19 RITM2822071 IBM BHATTA09 11.08.2022 # Automation RTR Test Scripts- Bug fix for RTR135
    // HEI.20 RITM2822071 IBM BHATTA09 16.08.2022 # Automation RTR Test Scripts- Bug fix for RTR135
    // HEI.21 RITM2822071 IBM BHATTA09 16.08.2022 # Automation RTR Test Scripts
    //   # Bug fix for Apply Entry in RTR054,RTR055,RTR056,RTR057,RTR058,RTR059,RTR060
    //   # Bufg Fix for FA No creation in RTR073, RTR075, RTR087, RTR089
    //   # Bug Fix for RTR136 for MVMT Dimension
    //   # Bug Fix for RTR144 for correct GL Account
    //   # Bug fix for VATDeclarationReportPageHandler, DimensionSetEntriesModalPageHandler
    // HEI.22 RITM2822071 IBM BHATTA09 24.08.2022 # Automation RTR Test Scripts
    //   # Bug fix for RTR102, Handlers added
    // HEI.23 RITM2822071 IBM BHATTA09 25.08.2022 # Automation RTR Test Scripts
    //   # Bug fix for RTR119- removing unused handler- ConfirmationHandler,CalculateDepreciationPageHandler
    // HEI.24 RITM2822071 IBM BHATTA09 29.08.2022 # Automation RTR Test Scripts
    //   # Bug fix for Date Filter
    //   # Bug Fix for FA Posting Group
    // HEI.25 RITM2822071 IBM BHATTA09 31.08.2022 # Automation RTR Test Scripts
    //   # Bug fix for Date Handler in RTR151
    //   # Bug fix for ServiceAccrualPosting,AccrualPostingofItemCharges,AccrualPostingofServiceAndItemCharges
    //   # Bug fix for RTR087,RTR088,RTR089
    // HEI.26 RITM2822071 IBM BHATTA09 01.09.2022 # Automation RTR Test Scripts
    //   # Bug fix for RTR087, RTR089 for Document No. and FA Posting Group Accounts
    // HEI.27 RITM2822071 IBM BHATTA09 05.09.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.28 RITM2822071 IBM BHATTA09 06.09.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.30 RITM2822071 IBM BHATTA09 07.09.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.31 RITM2822071 IBM BHATTA09 07.09.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.32 RITM2822071 IBM BHATTA09 08.09.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.33 RITM2822071 IBM BHATTA09 14.09.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.34 RITM2822071 IBM BHATTA09 15.09.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.35 RITM2822071 IBM BHATTA09 16.09.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.36 RITM2822071 IBM BHATTA09 19.09.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.37 RITM2822071 IBM BHATTA09 20.09.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.38 RITM2822071 IBM BHATTA09 21.09.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.39 RITM2822071 IBM BHATTA09 22.09.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.40 RITM2822071 IBM BHATTA09 27.09.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.41 RITM2822071 IBM BHATTA09 30.09.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.42 RITM2822071 IBM YADAVM05 17.10.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.43 RITM2822071 IBM YADAVM05 20.10.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.44 RITM2822071 IBM YADAVM05 21.10.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.45 RITM2822071 IBM YADAVM05 25.10.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.46 RITM2822071 IBM YADAVM05 02.11.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.47 RITM2822071 IBM YADAVM05 30.11.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.48 RITM2822071 IBM YADAVM05 05.12.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.49 RITM2822071 IBM YADAVM05 09.12.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.50 RITM2822071 IBM YADAVM05 20.12.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.51 RITM2822071 IBM YADAVM05 21.12.2022 # Automation RTR Test Scripts
    //   # Bug fix and optimization
    // HEI.52 RITM2822071 IBM YADAVM05 30.12.2022 # Automation RTR Test Scripts
    //   # Bug fix
    // HEI.53 RITM2822071 IBM YADAVM05 03.1.2023 # Automation RTR Test Scripts
    //   # Optimization
    // HEI.54 RITM2822071 IBM YADAVM05 12.01.2023 # Automation RTR Test Scripts
    //   # Bug Fix
    // HEI.55 RITM2822071 IBM YADAVM05 13.01.2023 # Automation RTR Test Scripts
    //   # Bug Fix
    // HEI.56 RITM2822071 IBM YADAVM05 17.01.2023 # Automation RTR Test Scripts
    //   # Bug Fix Message Handler RTR115
    // HEI.57 RITM2822071 IBM YADAVM05 20.01.2023 # Automation RTR Test Scripts
    //   # Bug Fix Message Handler RTR147
    // HEI.58 RITM2822071 IBM YADAVM05 24.01.2023 # Automation RTR Test Scripts
    //   # Bug Fix Message Handler RTR088
    // HEI.59 RITM2822071 IBM YADAVM05 30.01.2023 # Automation RTR Test Scripts
    //   # Remove Page Handler from RTR147,RTR136
    // HEI.60 RITM2822071 IBM YADAVM05 07.02.2023 # Automation RTR Test Scripts
    //   # Remove Page Handler from RTR147
    // HEI.61 RITM2822071 IBM YADAVM05 14.02.2023 # Automation RTR Test Scripts
    //   # Remove message Handler from RTR136
    // HEI.62 RITM2822071 IBM YADAVM05 01.03.2023 # Automation RTR Test Scripts
    //   # Bug Fix in RTR088,RTR089
    // HEI.63 RITM2822071 IBM YADAVM05 12.04.2023 # Automation RTR Test Scripts
    //   # Bug Fix in RTR119 to skip the test Script in case Setup does not exist
    // 
    // HEI.64 RITM2822071 IBM YADAVM05 18.04.2023 # Automation RTR Test Scripts
    //   # Bug Fix in RTR119 to skip the test Script in case of LOCAL Depriciation Book
    // 
    // HEI.65 RITM2822071 IBM YADAVM05 19.04.2023 # Automation RTR Test Scripts
    //   # Bug Fix in RTR087 to skip the test Script in case of negative Acquisition cost
    // 
    // HEI.66 RITM2822071 IBM YADAVM05 17.05.2023 # Automation RTR Test Scripts
    //   # Bug Fix in RTR056 RTR057  to skip the Post application when the transactions are not balanced
    // HEI.67 CHG2185291 IBM YADAVM09 25.05.2023 # Automation RTR Test Scripts
    //   # Bug Fix in RTR056 RTR057  to skip the Post application when the transactions are not balanced
    // HEI.69 CHG2214608 IBM YADAVM09 02.08.2023 # Automation RTR Test Scripts
    //   # Create new test script to BPM047 and solve BPM046 handler error
    // HEI.70 CHG2215529 IBM YADAVM09 09.08.2023 # Automation RTR Test Scripts
    //   # Create new test script to Fix bug inBPM046 handler error
    // HEI.71 CHG2217104 IBM YADAVM09 24.08.2023 # Automation RTR Test Scripts
    //   # Changing the documentation part for weekly release
    // HEI.72 CHG2217887 IBM YADAVM09 29.08.2023 # Automation RTR Test Scripts
    //   # Code added to skip action when G/L Account not avaliable
    // HEI.73 CHG2218697 IBM YADAVM09 05.09.2023 # Automation RTR Test Scripts
    //   # Code added to add confirmation handler in RTR138
    // HEI.74 CHG2229002 IBM SAMANR01 05.12.2023 - Remove dynamic and FlowFields from the Change Log Entry Page/Table
    //   # Correction the filter
    // HEI.75 CHG2235089  IBM YADAVM09 12.01.2024 - block code in Test script RTR112,RTR113,RtR115
    //   #failing due to new fields added in currency table
    // HEI.76 IBM YADAVM09 07.08.2024 - CHG2259302_Optimize Test Script BPM013-CalculateandpostWiP | RTR
    //   # Optimisation of test Script RtR121,BPM013 - Remove code block for RTR112,RTR113,RtR115
    // HEI.77 CHG2264796 IBM Yadavm09 20-08-2024 # WEEK 342024 | HeiLite BASE Test Script Adjustment and Optimizations
    //   # Remove Skip RTR121 due to long execution
    // HEI.78 CHG2284163 IBM Kapoov01 08-01-2025 # WEEK 02 2025 | HeiLite BASE Test Script Adjustment and Optimizations
    //   # Added code to unblock blocked templates that are casuing test scripts failure.
    // HEI.79 CHG2287617 IBM Kapoov01 30-01-2025 # WEEK 05 2025 | HeiLite BASE Test Script Adjustment and Optimizations
    //   # Added code to find Last GL Register having letter field blank on related GL Entries.
    // HEI.80 CHG2298037 IBM Kapoov01 02-04-2025 # WEEK 15 2025 Test Script Optimsation and BUg fix
    //   # Added code to skip EBMS interface related codeunits errors.
    // HEI.81 CHG2306110 IBM KAPOOV01 28.05.2025 # WEEK 22 2025 TEST SCRIPT OPTIMISATION
    //   # Added code to ensure General Journal Templates that are not blocked are used.
    // HEI.82 CHG2317486 IBM KAPOOV01 10.09.2025 # WEEK 33 2025 | HeiLite BASE Test Script Adjustment and Optimizations
    //   # Added code to remove messagehandler errors.
    //BC Upgrade KAPOOV01 >>
    // # Old Object ID-50209.
    // # Report-595-"Adjust Exchange Rates" replaced with Report-596-"Exch. Rate Adjustment" 
    // # Blocked code related to French Localization.
    // # Blocked FileMgt.UploadFileSilent function not available in BC.
    // # Blocked OpenBook & replaced OpenBook with OpenBookStream.
    // # DRINK-IT-Commented DRINK-IT table dependent function-FATemplateListModalPageHandler
    // # Commented DRINK-IT related code.
    // # FixedAssetCard."Location Code".SETVALUE(Location.Code); // # DRINK-IT
    // # Action- Overview not available in Page-AccountScheduleNames
    // # Blocked below code as field- "G/L Bank Account No." removed from Table-Bank Account Posting Group in BC 
    // # Blocked below code as field- Type removed from Table-"Bank Acc. Reconciliation Line" in BC 
    // # Blocked code related to Table-Object has ONPREM Scope,Replaced Table-Object with Record AllObjWithCaption
    // # Page- "Reverse Entries" not available in BC
    // # Blocked SAVEASWORD,SAVEASEXCEL as its scope is OnPrem
    // # Page "No. Series List" replaced with "No. Series" in BC 
    // # FATrialBalanceReportHandler function not found in Test Script CU-50209
    // # Commented ReverseEntriesModalPageHandler function - Page- "Reverse Entries" not available in BC
    // # Commented procedure ReverseEntryPageHandler-Page "Reversal Entry" removed in BC 
    // # Moved Test Script CU to INT Extension.
    // # Added MESSAGE('%1', GETLASTERRORTEXT) in functions-RT_RTR001-ManualGLPosting,RT_RTR003-Manual GLPosting2Approvers.
    // # For old Report with ID-50013 new report ID is 51005,for function-RTR121-ManualReconciliation replaced report ID-50013 with new ID- 51005.
    // # For old Report with ID-5692 new report ID is 55048,for function-RTR119-CalculateDepreciation replaced report ID-5692 with new ID- 55048 
    // # For old Report with ID-5605 new report ID is 55041, replaced report ID-5605 with new ID- 55041
    // # For FASubclassesModalPageHandler- corrected TestPage.
    // # For RequestPageHandlerprocedure CalculateDepreciationHeinekenReportPageHandler Request Page name changed from "Calculate Depreciation" to "Calculate Depreciation-RtR"
    // # Replaced old Report ID-50048 with new report ID is 53009
    // # Defined ModalPageHandler- PostPmtsAndRecBankAccHandler and added it as Handler function in function-RT_RTR135-ManualBankStatementProcessing
    // # Removed Drink-IT dependent handler-LocationsModalPageHandler from procedure "RTR077-ReviewFixedAsset"
    // # For handler function-SuggestWorksheetLinesReportHandler Report- Suggest Worksheet Lines name changed to SuggestWorksheetLinesHeiLite
    // # For procedure "RTR075-RPMAssetMasteDataCreation" replaced "FA Template Code" with "FA Template APS".
    // # Modified function-RTR006-GLMassUploadWithoutReversal , RTR007-GLMassUploadWithReversal to replace FileMgt.UploadFileSilent functionality as this functionality is obsolete in BC.
    // # Modified Handler function-GLMassUploadRequestPageHandler to replace FileMgt.UploadFileSilent functionality as this functionality is obsolete in BC.
    // # Created new function- CreateExcelInTempBlob to replace FileMgt.UploadFileSilent functionality as this functionality is obsolete in BC.
    // # Modified Handler function- FATemplateListModalPageHandler replaced old table with new DRINK-IT table- FA Template List APS.
    // # Modified Handler function-SuggestWorksheetLinesReportHandler Report- Suggest Worksheet Lines name changed to SuggestWorksheetLinesHeiLite.
    // # Removed TestReportReportHandler from test scripts-RTR014,RTR029,RTR032,RTR032
    // # Removed Handler- ConfirmationHandler from tests script-RTR075
    // # Modified Test Script-RTR007 to replace FileMgt.UploadFileSilent functionality as this functionality is obsolete in BC.
    // # Removed handler functions-GLMassUploadReversalRequestPageHandler,ConfirmationHandler from Test Script-RTR007 to handle the excel report import functionality from local path as FileMgt.UploadFileSilent functionality is obsolete in BC.
    //BC Upgrade KAPOOV01 <<
    //Bc Upgrade YADAVM09,28.04.26 PID-475, PID-503, PID-504, PID-505, PID-535, PID-536, PID-537, PID-758GAP ID: IBM GAP RTR 09.
    //BC upgrade YADAVM09 PostingPageHandler handler created and added in test script RT_RTR005.
    //BC Upgrade YADAVM09 code added in test script RTR069 and RTR070 to handle the excel report import functionality from local path.
    //BC upgrade YADAVM09 PostingPageHandler handler added in test script RTR011,RTR089.
    //BC upgrade YADAVM09 Code Blocked in RTR111 due to dependency on drink it field.
    //Bc upgrade YADAVM09 Added Handler in testscript RTR089.
    Permissions = TableData "Approval Entry" = rimd;
    Subtype = Test;

    trigger OnRun();
    begin
    end;

    var
        UnitTestingValues: Record "Unit Testing Value FND";
        BankAccount: Record "Bank Account";
        PaymentReconciliationJnl: TestPage "Payment Reconciliation Journal";
        ItemJournalTemplate: Record "Item Journal Template";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        FAPostingType: Option " ","Acquisition Cost",Depreciation,"Write-Down",Appreciation,"Custom 1","Custom 2",Disposal,Maintenance,,,,,Derogatory;
        GlAcc: Record "G/L Account";
        GLRegisterNo: Integer;
        GLRegister: Record "G/L Register";
        ReversalEntry_G: Record "Reversal Entry";
        WorkflowResponse: Record "Workflow Response";
        GLUploadFileNameTxt: Label 'C:\scripts\heilite-ops\TestScripts\RtR\RTR GL Mass Upload.xlsm';
        GLUploadSheetNameTxt: Label 'GL';
        GLSetup: Record "General Ledger Setup";
        FileMgt: Codeunit "File Management";
        ExcelFileExtensionTok: Label '.xls*';
        Text001: Label 'Import Excel File';
        FileName: Text;
        FixedAsset: Record "Fixed Asset";
        AgingByOption: Option "Due Date","Posting Date","Document Date";
        HeadingTypeOption: Option "Date Interval","Number of Days";
        Text002: Label 'Export to:';
        //BC Upgrade KAPOOV01 Report-595-"Adjust Exchange Rates" replaced with Report-596-"Exch. Rate Adjustment" >>
        // AdjustExchangeRates2: Report "Adjust Exchange Rates";
        // AdjustExchangeRates3: Report "Adjust Exchange Rates";
        // AdjustExchangeRates4: Report "Adjust Exchange Rates";
        // AdjustExchangeRates5: Report "Adjust Exchange Rates";
        // AdjustExchangeRates6: Report "Adjust Exchange Rates";
        // AdjustExchangeRates: Report "Adjust Exchange Rates";

        AdjustExchangeRates2: Report "Exch. Rate Adjustment";
        AdjustExchangeRates3: Report "Exch. Rate Adjustment";
        AdjustExchangeRates4: Report "Exch. Rate Adjustment";
        AdjustExchangeRates5: Report "Exch. Rate Adjustment";
        AdjustExchangeRates6: Report "Exch. Rate Adjustment";
        AdjustExchangeRates: Report "Exch. Rate Adjustment";
        //BC Upgrade KAPOOV01 Report-595-"Adjust Exchange Rates" replaced with Report-596-"Exch. Rate Adjustment" <<
        Workflow: Record Workflow;
        PostExpcostforItemCharge: Report "Post Exp. cost for Item Charge";
        CashFlowForecastCard: TestPage "Cash Flow Forecast Card";
        PayrollFileNameTxt: Label 'C:\scripts\heilite-ops\TestScripts\RtR\Payroll format.xlsx';
        PayrollSheetNameTxt: Label 'Payroll';
        PayrollCCCFileNameTxt: Label 'C:\scripts\heilite-ops\TestScripts\RtR\Payroll format Wrong CCC.xlsx';
        PayrollCCCSheetNameTxt: Label 'Payroll';
        SaveCIL3File: Label 'C:\scripts\heilite-ops\TestScripts\RtR\CIl3.txt';
        SaveCILFile: Label 'C:\scripts\heilite-ops\TestScripts\RtR\CIl1.txt';
        SaveCIL2File: Label 'C:\scripts\heilite-ops\TestScripts\RtR\CIl2.txt';
        SaveCILEBFFile: Label 'C:\scripts\heilite-ops\TestScripts\RtR\CIlEBF.txt';
        SaveCILMSVFile: Label 'C:\scripts\heilite-ops\TestScripts\RtR\CILMSV.txt';
        SaveCILWISFile: Label 'C:\scripts\heilite-ops\TestScripts\RtR\CILWIS.txt';
        SaveCIL3ICFile: Label 'C:\scripts\heilite-ops\TestScripts\RtR\CIl3IC.txt';
        ExportConsolidationXML: Label 'C:\scripts\heilite-ops\TestScripts\RtR\ExpConsolidationXML.xml';
        ExportConsolidationTxt: Label 'C:\scripts\heilite-ops\TestScripts\RtR\ExpConsolidation.txt';
        HeiMatchFileTxt: Label 'C:\scripts\heilite-ops\TestScripts\RtR\HeiMatchFile.csv';
        ApprovalNotSentMsg: Label 'No approval request had been sent.';
        MissingDimErr: Label 'A dimension used in %1 %2, %3, %4 has caused an error. %5';
        SelectDimErr: Label 'Select a %1 for the %2 %3 for %4 %5.';
        CCCDimensionValue: Record "Dimension Value";
        NotAllowedDateErr: TextConst ENU = '%1 is not within your range of allowed posting dates in %2 %3=''%4'',%5=''%6'',%7=''%8''.';
        BrandDimensionValue: Record "Dimension Value";
        gFASetUp: Record "FA Setup";
        gNoSeries: Record "No. Series";
        GLAccRTR144: Record "G/L Account";
        MVMTDimensionValue: Record "Dimension Value";
        MVMTDimension: Code[20];
        ExcelBuf: Record "Excel Buffer" temporary;
        ApprovalDisabled: Label 'The Approval Process is Disabled for the current batch';
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        EBMSInterfaceSetup: Record "EBMS Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        //BC Upgrade KAPOOV01 >>
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
    //BC Upgrade KAPOOV01 <<
    [Test]
    [HandlerFunctions('MessageHandler')]
    procedure "RT_RTR001-ManualGLPosting"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        Balance: Decimal;
        Amt: Decimal;
        DefaultDim: Record "Default Dimension";
        DimSetEntry: Record "Dimension Set Entry";
    begin
        ClearVariables('RT_RTR001'); //HEI.16
        //HEI.01
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        //Check default value for Account No.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"G/L Account");
        GLAccount.GET(UnitTestingValues.Value);

        //Step 1: Login

        //Step 4 Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE; //BC Upgrade KAPOOV01 added to resolved compilation error

        //Step5 - Open Gen. Journal Batch page
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //HEI.16<<

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Step 6- Create Journal Line
        GenJournalPage.NEW;

        GenJournalPage."Source Code".SETVALUE(GenJournalTemplate."Source Code");
        GenJournalPage."Posting Date".SETVALUE(WORKDATE);
        GenJournalPage."Account Type".SETVALUE(AccType::"G/L Account");
        GenJournalPage."Account No.".SETVALUE(GLAccount."No.");
        GenJournalPage.Description.SETVALUE('Unit Test RT_RTR001');
        GenJournalPage.Amount.SETVALUE(1000);
        DocumentNo := GenJournalPage."Document No.".VALUE;

        if GenJournalBatch."Bal. Account No." <> '' then begin
            //Bal Account Type (auto - template)
            GenJournalPage."Bal. Account Type".ASSERTEQUALS(GenJournalBatch."Bal. Account Type");
            //Bal Account No (auto - template)
            GenJournalPage."Bal. Account No.".ASSERTEQUALS(GenJournalBatch."Bal. Account No.");
        end else begin
            GenJournalPage."Bal. Account Type".SETVALUE(AccType::"G/L Account");
            GenJournalPage."Bal. Account No.".SETVALUE(GLAccount."No.");
        end;

        //Step 7 - Preview Posting
        //GenJournalPage.Preview.INVOKE;
        //Replace Preview posting done for a final check with manual checks because the Preview action is not found

        //Check the doc. No.
        if DocumentNo = '' then
            ERROR('Document No. is blank.');

        //Check the balance
        EVALUATE(Balance, GenJournalPage.Balance.VALUE);
        if Balance <> 0 then
            ERROR('Document %1 is out of balance.', DocumentNo);

        //Check the Amount
        EVALUATE(Amt, GenJournalPage.Amount.VALUE);
        if Amt = 0 then
            ERROR('The amount of Document %1 is blank.', DocumentNo);

        //Check mandatory dimenions
        DefaultDim.RESET;
        DefaultDim.SETRANGE("Table ID", 15);
        DefaultDim.SETRANGE("No.", GLAccount."No.");
        DefaultDim.SETRANGE("Value Posting", DefaultDim."Value Posting"::"Code Mandatory");
        if DefaultDim.FINDSET then
            repeat
                DimSetEntry.RESET;
                if not DimSetEntry.GET(GenJournalPage."Dimension Set ID".VALUE, DefaultDim."Dimension Code") then
                    ERROR('Dimension code %1 is missing for Document No. %2', DefaultDim."Dimension Code", DocumentNo);
            until DefaultDim.NEXT = 0;

        //STep 8 + 9- Attach a supporting document to MJE by navigating to "Incoming document" and selecting "Create incoming document from file" - SKIP this step because of error compilation
        //GenJournalPage.IncomingDocAttachFile.INVOKE;

        //Step 10 - Send for approval
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then//HEI.16
                                                                                            //HEI.16>>
                                                                                            //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
                                                                                            //WorkflowResponse.DELETE;
            if GenJournalPage.SendApprovalRequestJournalBatch.ENABLED then begin
                //HEI.16<<
                GenJournalPage.SendApprovalRequestJournalBatch.INVOKE;
                //HEI.16>>
                //END ELSE
                //ERROR('No approval workflow is enabled.');
                //HEI.16<<

                //Step 11 - Check if the posting batch was created and submitted for approval - Open the page to see the requests
                ApprovalEntries.TRAP;
                GenJournalPage.Approvals.INVOKE;

                //HEI.16>>
                ApprovalEntries.FILTER.SETFILTER("Sender ID", USERID);
                ApprovalEntries.Status.ASSERTEQUALS(1);
            end else
                MESSAGE(ApprovalNotSentMsg);
        //HEI.16<<

        //HEI.01
        MESSAGE('%1', GETLASTERRORTEXT); //BC Upgrade KAPOOV01
    end;

    [Test]
    [HandlerFunctions('MessageHandler')]
    procedure "RT_RTR003-Manual GLPosting2Approvers"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        Customer: Record Customer;
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        RequeststoApprove: TestPage "Requests to Approve";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        Balance: Decimal;
        Amt: Decimal;
        DefaultDim: Record "Default Dimension";
        DimSetEntry: Record "Dimension Set Entry";
        WorkflowCount: Integer;
        WorkflowUserGroup: Record "Workflow User Group";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
    begin
        ClearVariables('RT_RTR001'); //HEI.16
        //HEI.01
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        //Check default value for Account No.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"G/L Account");
        GLAccount.GET(UnitTestingValues.Value);

        //Step 1: Login

        //Step 4 Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE;  //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE; //BC Upgrade KAPOOV01 added to resolved compilation error

        //Step5 - Open Gen. Journal Batch page
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Step 6- Create Journal Line
        GenJournalPage.NEW;

        GenJournalPage."Source Code".SETVALUE(GenJournalTemplate."Source Code");
        GenJournalPage."Posting Date".SETVALUE(WORKDATE);
        GenJournalPage."Account Type".SETVALUE(AccType::"G/L Account");
        GenJournalPage."Account No.".SETVALUE(GLAccount."No.");
        GenJournalPage.Description.SETVALUE('Unit Test RT_RTR003');

        //Set the amount bigger than 10000 to be handled by the right workflow
        //HEI.16>>
        //Workflows are setup for Amount = ..100,000,000
        //GenJournalPage.Amount.SETVALUE(100000);
        GenJournalPage.Amount.SETVALUE(500000);
        //HEI.16<<
        DocumentNo := GenJournalPage."Document No.".VALUE;

        //Bal Account Type and Bal. Account No. (auto fill in from Batch)
        if GenJournalBatch."Bal. Account No." <> '' then begin
            GenJournalPage."Bal. Account Type".ASSERTEQUALS(GenJournalBatch."Bal. Account Type");
            GenJournalPage."Bal. Account No.".ASSERTEQUALS(GenJournalBatch."Bal. Account No.");
        end else begin
            GenJournalPage."Bal. Account Type".SETVALUE(AccType::"G/L Account");
            GenJournalPage."Bal. Account No.".SETVALUE(GLAccount."No.");
        end;

        //Step 7 - Preview posting
        //GenJournalPage.Preview.INVOKE;
        // Replace Preview posting done for a final check with manual checks because the Preview action is not found

        //Check the doc. No.
        if DocumentNo = '' then
            ERROR('Document No. is blank.');

        //Check the balance
        EVALUATE(Balance, GenJournalPage.Balance.VALUE);
        if Balance <> 0 then
            ERROR('Document %1 is out of balance.', DocumentNo);

        //Check the Amount
        EVALUATE(Amt, GenJournalPage.Amount.VALUE);
        if Amt = 0 then
            ERROR('The amount of Document %1 is blank.', DocumentNo);

        //Check mandatory dimenions
        DefaultDim.RESET;
        DefaultDim.SETRANGE("Table ID", 15);
        DefaultDim.SETRANGE("No.", GLAccount."No.");
        DefaultDim.SETRANGE("Value Posting", DefaultDim."Value Posting"::"Code Mandatory");
        if DefaultDim.FINDSET then
            repeat
                DimSetEntry.RESET;
                if not DimSetEntry.GET(GenJournalPage."Dimension Set ID".VALUE, DefaultDim."Dimension Code") then
                    ERROR('Dimension code %1 is missing for Document No. %2', DefaultDim."Dimension Code", DocumentNo);
            until DefaultDim.NEXT = 0;

        //STep 8 + 9- Attach a supporting document to MJE by navigating to "Incoming document" and selecting "Create incoming document from file" - SKIP this step because of error compilation
        //GenJournalPage.IncomingDocAttachFile.INVOKE;

        //HEI.16>>
        Workflow.RESET;
        Workflow.SETFILTER(Category, '*RTR');
        Workflow.SETRANGE(Enabled, true);
        WorkflowCount := Workflow.COUNT; // will be used for second approval

        //Update Workflow User Groups
        UserSetup.SETFILTER("User ID", '<>%1', '');
        UserSetup.FINDFIRST;

        if WorkflowUserGroup.FINDSET(false) then
            repeat
                WorkflowUserGroupMember.SETRANGE("Workflow User Group Code", WorkflowUserGroup.Code);
                WorkflowUserGroupMember.SETRANGE("User Name", UserSetup."User ID");
                WorkflowUserGroupMember.SETRANGE("Sequence No.", 2);
                if not WorkflowUserGroupMember.FINDFIRST then begin
                    WorkflowUserGroupMember.INIT;
                    WorkflowUserGroupMember."Workflow User Group Code" := WorkflowUserGroup.Code;
                    WorkflowUserGroupMember."User Name" := UserSetup."User ID";
                    WorkflowUserGroupMember.INSERT;
                end;
            until WorkflowUserGroup.NEXT = 0;
        //HEI.16<<

        //Step 10 - Send for approval
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then
            //HEI.16>>
            //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
            //WorkflowResponse.DELETE;
            if GenJournalPage.SendApprovalRequestJournalBatch.ENABLED then begin
                //HEI.16<<
                GenJournalPage.SendApprovalRequestJournalBatch.INVOKE;
                //HEI.16>>
                //END ELSE
                //ERROR('No approval workflow is enabled.');
                //HEI.16<<

                //Step 11 - Check if the posting batch was created and submitted for approval - Open the page to see the requests
                ApprovalEntries.TRAP;
                GenJournalPage.Approvals.INVOKE;

                //HEI.16>>
                ApprovalEntries.FILTER.SETFILTER("Sender ID", USERID);
                //Check Status = Open
                ApprovalEntries.FILTER.SETFILTER(Status, '1');
                ApprovalEntries.Status.ASSERTEQUALS(1);

                //Check Status = Created
                if WorkflowCount > 1 then begin
                    ApprovalEntries.FILTER.SETFILTER(Status, '0');
                    ApprovalEntries.Status.ASSERTEQUALS(0);
                end;
            end else
                MESSAGE(ApprovalNotSentMsg);
        //HEI.16<<
        //HEI.01<<
        MESSAGE('%1', GETLASTERRORTEXT); //BC Upgrade KAPOOV01
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,PostingPageHandler')]//Bc Upgrade YADAVM09
    procedure "RT_RTR005-ManualGLPostingMissingCCC"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GenJournalLine: Record "Gen. Journal Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        DefaultDim: Record "Default Dimension";
        DimSetEntry: Record "Dimension Set Entry";
        RestrictedRecord: Record "Restricted Record";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalEntries: TestPage "Approval Entries";
        Balance: Decimal;
        Amt: Decimal;

    begin
        ClearVariables('RT_RTR005'); //HEI.16
        //HEI.02
        //Check default value for Journal Template
        UnitTestingValues.RESET();
        UnitTestingValues.GET('RT_RTR005', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET();
        UnitTestingValues.GET('RT_RTR005', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        //Check default value for Account No.
        UnitTestingValues.RESET();
        UnitTestingValues.GET('RT_RTR005', COMPANYNAME, DATABASE::"G/L Account");
        GLAccount.GET(UnitTestingValues.Value);

        //Step 1: Login

        //Step 4 Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW();
        GeneralJournalBatches.TRAP();
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE;  //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE; //BC Upgrade KAPOOV01 added to resolved compilation error

        //Step5 - Open Gen. Journal Batch page
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Step 6- Create Journal Line
        GenJournalPage.NEW;

        GenJournalPage."Source Code".SETVALUE(GenJournalTemplate."Source Code");
        GenJournalPage."Posting Date".SETVALUE(WORKDATE);
        GenJournalPage."Account Type".SETVALUE(AccType::"G/L Account");
        GenJournalPage."Account No.".SETVALUE(GLAccount."No.");
        GenJournalPage.Description.SETVALUE('Unit Test RTR005');
        GenJournalPage."Gen. Prod. Posting Group".SETVALUE('');//HEI.17
        GenJournalPage.Amount.SETVALUE(1000);
        DocumentNo := GenJournalPage."Document No.".VALUE;

        if GenJournalTemplate."Bal. Account No." <> '' then begin
            //Bal Account Type (auto - template)
            GenJournalPage."Bal. Account Type".ASSERTEQUALS(GenJournalBatch."Bal. Account Type");
            //Bal Account No (auto - template)
            GenJournalPage."Bal. Account No.".ASSERTEQUALS(GenJournalBatch."Bal. Account No.");
        end else begin
            GenJournalPage."Bal. Account Type".SETVALUE(AccType::"G/L Account");
            GenJournalPage."Bal. Account No.".SETVALUE(GLAccount."No.");
            GenJournalPage."Bal. Gen. Prod. Posting Group".SETVALUE('');//HEI.17
        end;

        //Step 7 - Replace Preview posting done for a final check with manual checks because the Preview action is not found
        //GenJournalPage.Preview.INVOKE;

        //Check the doc. No.
        if DocumentNo = '' then
            ERROR('Document No. is blank.');

        //Check the balance
        EVALUATE(Balance, GenJournalPage.Balance.VALUE);
        if Balance <> 0 then
            ERROR('Document %1 is out of balance.', DocumentNo);

        //Check the Amount
        EVALUATE(Amt, GenJournalPage.Amount.VALUE);
        if Amt = 0 then
            ERROR('The amount of Document %1 is blank.', DocumentNo);

        //Check mandatory dimenions
        //HEI.16>>
        GeneralLedgerSetup.GET;
        DefaultDim.RESET;
        DefaultDim.SETRANGE("Table ID", 15);
        DefaultDim.SETRANGE("No.", GLAccount."No.");
        DefaultDim.SETRANGE("Value Posting", DefaultDim."Value Posting"::"Code Mandatory");
        DefaultDim.SETFILTER("Dimension Code", '<>%1', GeneralLedgerSetup."Cost Center Dimension Code FND");
        DefaultDim.DELETEALL;

        GenJournalPage.OK.INVOKE;

        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        if GenJournalLine.FINDFIRST() then
            if GenJournalLine."Dimension Set ID" > 0 then begin
                GenJournalLine."Dimension Set ID" := 0;
                GenJournalLine.MODIFY();
            end;
        COMMIT;

        //Disable Workflows before Release
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            Workflow.SETRANGE(Enabled, true);
            if Workflow.FINDSET() then
                //REPEAT//HEI.53
                Workflow.MODIFYALL(Workflow.Enabled, false);//HEI.53
                                                            // UNTIL Workflow.NEXT = 0;//HEI.53
        end;

        //Delete the record restrictions
        RestrictedRecord.RESET();
        if RestrictedRecord.FINDSET() then
            RestrictedRecord.DELETEALL();
        //HEI.16<<

        DefaultDim.RESET();
        DefaultDim.SETRANGE("Table ID", 15);
        DefaultDim.SETRANGE("No.", GLAccount."No.");
        DefaultDim.SETRANGE("Value Posting", DefaultDim."Value Posting"::"Code Mandatory");
        //HEI.16>>
        //IF DefaultDim.FINDSET THEN REPEAT
        //DimSetEntry.RESET;
        //IF NOT DimSetEntry.GET(GenJournalPage."Dimension Set ID".VALUE,DefaultDim."Dimension Code") THEN
        //ERROR('Dimension code %1 is missing for Document No. %2',DefaultDim."Dimension Code",DocumentNo);
        //UNTIL DefaultDim.NEXT = 0;

        DefaultDim.SETRANGE("Dimension Code", GeneralLedgerSetup."Cost Center Dimension Code FND");
        if DefaultDim.FINDFIRST() then begin
            GenJournalPage.TRAP();
            GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
            GeneralJournalBatches.EditJournal.INVOKE();

            GenJournalPage.Post.INVOKE();
            //Bc Upgrade YADAVM09>>
            // if GETLASTERRORTEXT <> STRSUBSTNO(MissingDimErr, GenJournalLine.TABLECAPTION, GenJournalTemplate.Name, GenJournalBatch.Name, 10000,
            //                                   STRSUBSTNO(SelectDimErr, DefaultDim.FIELDCAPTION("Dimension Value Code"),
            //                                              DefaultDim.FIELDCAPTION("Dimension Code"), GeneralLedgerSetup."Global Dimension 2 Code",
            //                                              GLAccount.TABLECAPTION, GLAccount."No."))
            // then
            //     ERROR('Unexpected Error: %1', GETLASTERRORTEXT);
            //Bc Upgrade YADAVM09<<
        end;
        //HEI.16<<
        //HEI.02
    end;
    //Bc Upgrade YADAVM09>>
    [PageHandler]
    procedure PostingPageHandler(var GenJournalPage: TestPage "Error Messages")
    begin
        // Do nothing – this prevents the UI error
    end;
    //Manisha2505<<
    //Bc Upgrade YADAVM09<<

    [Test]
    [HandlerFunctions('GLMassUploadRequestPageHandler,ConfirmationHandler,MessageHandler,GLPreviewEntriesPageHandler,DimensionSetEntriesModalPageHandler')]
    procedure "RT_RTR008-ManualGLPostingWithUpload"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        Balance: Decimal;
        Amt: Decimal;
        DefaultDim: Record "Default Dimension";
        DimSetEntryL: TestPage "Edit Dimension Set Entries";
        GLMassUpload: Report "Import Gen.Jrnl From Excel CBN";
        Parameters: Text;
        DefaultDimension: Record "Default Dimension";
    begin
        ClearVariables('RT_RTR008'); //HEI.16
        //HEI.05

        //Step 1: Login
        GLMassUpload.RUNMODAL;
        //REPORT.RUNMODAL(50011,true,FALSE,GenJournalLine);

        //request page is handled by function GLMassUploadRequestPageHandler

        //after uploading the report, a dialog message is displaying the next question: Are you sure you want to replace entries for Journal Template Name RTR.
        //this is handled by function ConfirmationHandler, which automatically replies "YES"

        //after this, if the lines are successfully imported, another message is displayed showing the number of entries inserted.
        //this is handled by function MessageHandler

        //Go to General Journal to check the entries
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR008', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR008', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        //HEI.16>>
        //UnitTestingValues.RESET;
        //UnitTestingValues.GET('RT_RTR008',COMPANYNAME,DATABASE::"G/L Account");
        //GLAccount.GET(UnitTestingValues.Value);

        GeneralLedgerSetup.GET;
        CCCDimensionValue.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        CCCDimensionValue.SETRANGE(Blocked, false);
        CCCDimensionValue.FINDFIRST;

        BrandDimensionValue.SETRANGE("Dimension Code", GeneralLedgerSetup."Brand Dimension Code FND");
        BrandDimensionValue.SETRANGE(Blocked, false);
        BrandDimensionValue.FINDFIRST;
        //HEI.16<<

        //Gen. Journal Template
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE;  //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error

        //Gen. Journal Batch
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //HEI.16>>
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.SETRANGE("Account Type", GenJournalLine."Account Type"::"G/L Account");
        if GenJournalLine.FINDSET(true) then
            repeat
                GenJournalPage.FILTER.SETFILTER("Line No.", FORMAT(GenJournalLine."Line No."));
                GenJournalPage.Dimensions.INVOKE;
            until GenJournalLine.NEXT = 0;

        COMMIT;
        GenJournalPage.OK.INVOKE;

        GenJournalPage.TRAP;
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        GeneralJournalBatches.EditJournal.INVOKE;
        COMMIT;
        //HEI.16<<

        //Step 9 -Check preview posting option for verification
        GenJournalPage.Preview.INVOKE;
        //Preview GL Entries page is handled by function GLPreviewEntriesPageHandler
        //HEI.05
    end;

    [Test]
    [HandlerFunctions('InventoryValReportHandler,TrialBalancelReportHandler')]
    procedure "RT_RTR124-InventoryReconciliation"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        Customer: Record Customer;
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        RequeststoApprove: TestPage "Requests to Approve";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        InventoryPostingSetup: Record "Inventory Posting Setup";
        InventoryPostingGroup: Record "Inventory Posting Group";
        Location: Record Location;
        InventoryValuation: Report "Inventory Valuation";
        TrialBalance: Report "Trial Balance";
        Item: Record Item;
    begin
        ClearVariables('RT_RTR124'); //HEI.16
        //HEI.01
        //Check default value for Inventory Posting Group
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR124', COMPANYNAME, DATABASE::"Inventory Posting Group");
        InventoryPostingGroup.GET(UnitTestingValues.Value);

        //Check default value for Location
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR124', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        InventoryPostingSetup.RESET;
        InventoryPostingSetup.GET(Location.Code, InventoryPostingGroup.Code);
        //UnitTestingValues.RESET; //HEI.16

        //Step 1: Login

        //Run the rport Inventory Valuation
        CLEAR(InventoryValuation);

        //set filter on the Inventory Posting group
        Item.RESET;
        Item.SETFILTER("Inventory Posting Group", InventoryPostingGroup.Code);
        InventoryValuation.SETTABLEVIEW(Item);

        //set filter on startig and ending date
        //HEI.16>>
        //InventoryValuation.SetStartDate(090119D);
        //InventoryValuation.SetEndDate(093019D);
        InventoryValuation.SetStartDate(DMY2DATE(1, 9, 2019));
        InventoryValuation.SetEndDate(DMY2DATE(30, 9, 2019));
        //HEI.16<<

        InventoryValuation.RUNMODAL;

        //run the report Trial Balace
        CLEAR(TrialBalance);

        //set filters on GL Account
        GLAccount.RESET;
        GLAccount.SETFILTER("No.", InventoryPostingSetup."Inventory Account");
        GLAccount.SETFILTER("Date Filter", 'P9');

        TrialBalance.SETTABLEVIEW(GLAccount);
        TrialBalance.RUNMODAL;
        //HEI.01
    end;

    [Test]
    [HandlerFunctions('PaymentBankAccountModalPageHandler,TransfDiffToAccModalPageHandler,ConfirmationHandler,DimSetEntriesInsertMVMTHandler,DimValueListMVMTHandler,PostPmtsAndRecBankAccHandler')]
    procedure "RT_RTR135-ManualBankStatementProcessing"();
    var
        PmtReconciliationJournals: TestPage "Pmt. Reconciliation Journals";
        PaymentBankAccountList: TestPage "Payment Bank Account List";
        BankAccountList: TestPage "Bank Account List";
        PaymentReconciliationJournal: TestPage "Payment Reconciliation Journal";
        lBankAccPostingGr: Record "Bank Account Posting Group";
        lChartofAcc: Record "G/L Account";
        lEbfComb: Record "Ebf Combination FND";
        lGenLedgSetUp: Record "General Ledger Setup";
    begin
        ClearVariables('RT_RTR135'); //HEI.16

        //HEI.20>>
        //Update EBF Combination
        lGenLedgSetUp.GET;
        //HEI.40>>
        //HEI.41>>
        //Uncommented again
        lEbfComb.RESET;
        lEbfComb.SETCURRENTKEY("GL Account No.", "Dimension Code", "Dimension Value Code");
        lEbfComb.SETRANGE("Dimension Code", lGenLedgSetUp."Shortcut Dimension 3 Code");
        lEbfComb.SETFILTER("Combination Restriction", '%1|%2', lEbfComb."Combination Restriction"::"Allowed with Warn", lEbfComb."Combination Restriction"::"Not Allowed");
        lEbfComb.DELETEALL;
        //HEI.41<<
        //HEI.40<<
        //HEI.20<<

        //HEI.01
        //Default value for Bank Acc. NO.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR135', COMPANYNAME, DATABASE::"Bank Account");
        BankAccount.GET(UnitTestingValues.Value);

        //HEI.19>>
        if lBankAccPostingGr.GET(BankAccount."Bank Acc. Posting Group") then begin
            // if lChartofAcc.GET(lBankAccPostingGr."G/L Bank Account No.") then begin //BC Upgrade KAPOOV01 Field- "G/L Bank Account No." removed.
            //     if lChartofAcc.Blocked then begin
            //         lChartofAcc.Blocked := false;
            //         lChartofAcc.MODIFY;
            //     end;
            // end;
        end;
        //HEI.19<<

        //HEI.16>>
        GLSetup.GET;
        GLSetup."Allow Posting From" := DMY2DATE(1, 1, 2020);
        GLSetup."Allow Posting To" := DMY2DATE(31, 12, 9999);
        GLSetup.MODIFY;
        COMMIT;
        //HEI.16<<

        //Step 1: Login

        //Step 2 - Go to Search Bar and search for "Payment Reconciliation Journals"
        PmtReconciliationJournals.OPENVIEW;

        //Step 3 - Click on "New Journal" button.
        PmtReconciliationJournals.NewJournal.INVOKE;

        //Step 4 - Select the required bank account no. in the payment bank account list and click OK
        // This is done using the ModalPageHandler PaymentBankAccountModalPageHandler

        //Step 5 -Create Payment Journal Rec. line
        PaymentReconciliationJnl.NEW;

        //HEI.16>>
        //PaymentReconciliationJnl."Transaction Date".SETVALUE(040821D);
        PaymentReconciliationJnl."Transaction Date".SETVALUE(DMY2DATE(8, 4, 2021));
        //HEI.16<<
        PaymentReconciliationJnl."Transaction Text".SETVALUE('Text Test Script RT_RTR135');
        PaymentReconciliationJnl."Statement Amount".SETVALUE(1000);

        //Step 6 - Click on "Transfer Difference to Account" from the home tab of the ribbon.
        PaymentReconciliationJnl.TransferDiffToAccount.INVOKE;

        PaymentReconciliationJnl.Dimensions.INVOKE;

        //Step 7 - Click on "Accept Applications", in the Home Toolbar, to accept the application
        PaymentReconciliationJnl.Accept.INVOKE;

        //Step 8 - Click on "Post payment and reconcile bank account"
        PaymentReconciliationJnl.Post.INVOKE;

        //Step 9 - Go to Search Bar and search for "Bank Account"
        BankAccountList.OPENVIEW;

        //Step 10 - Search for the bank account to be reviewed and click on "Ledger Entries" from the Navigate ribbon
        //HEI.16>>
        //BankAccountList.FINDFIRSTFIELD("No.",BankAccount."No.");
        BankAccountList.FILTER.SETFILTER("No.", BankAccount."No.");
        //HEI.16<<
        //BankAccountList."Page Bank Account Ledger Entries".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        BankAccountList."Ledger E&ntries".INVOKE; //BC Upgrade KAPOOV01 added to resolved compilation error
        //HEI.01
    end;

    [Test]
    [HandlerFunctions('SuggestItemStandCostPageHandler,ImpelementItemStandCostPageHandler,ConfirmationHandler,MessageHandler')]
    procedure "RT_BPM001-CalculateStandardCost"();
    var
        Item: Record Item;
        StandardCostWorksheet: TestPage "Standard Cost Worksheet";
        StandardCostWshtNames: TestPage "Standard Cost Worksheet Names";
        NewStandardCost: Decimal;
        StdCostTxt: Text;
        ImplStdCostChg: Report "Implement Standard Cost Change";
        WhkName: Text;
        Rec: Record "Standard Cost Worksheet";
        RevalJournal: TestPage "Revaluation Journal";
        ItemJournalBatches: TestPage "Item Journal Batches";
        ItemJournalTemplates: TestPage "Item Journal Templates";
        ItemList: TestPage "Item List";
        ItemCard: TestPage "Item Card";
        ItemJournalTemplate: Record "Item Journal Template";
        ItemJournalBatch: Record "Item Journal Batch";
        ItemJournalLine: Record "Item Journal Line";
    begin
        ClearVariables('RT_BPM001'); //HEI.16
        //HEI.06
        //get the Item Journal template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_BPM001', COMPANYNAME, DATABASE::"Item Journal Template");
        ItemJournalTemplate.GET(UnitTestingValues.Value);

        //get the Item Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_BPM001', COMPANYNAME, DATABASE::"Item Journal Batch");
        ItemJournalBatch.GET(ItemJournalTemplate.Name, UnitTestingValues.Value);

        //get the Item No.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_BPM001', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        //HEI.16>>
        //delete the existing entries
        ItemJournalLine.RESET;
        ItemJournalLine.SETRANGE("Journal Template Name", ItemJournalTemplate.Name);
        ItemJournalLine.SETRANGE("Journal Batch Name", ItemJournalBatch.Name);
        ItemJournalLine.DELETEALL;
        COMMIT;
        //HEI.16<<

        //Step 1 - Search for Standard Costs Worksheet and Open
        StandardCostWshtNames.OPENVIEW;

        //Step 2 - Select  " Standard Worksheet  Name as "Default" Press  Ok
        StandardCostWorksheet.TRAP;
        //HEI.16>>
        //StandardCostWshtNames.FINDFIRSTFIELD(Name,'DEFAULT');
        StandardCostWshtNames.FILTER.SETFILTER(Name, 'DEFAULT');
        //HEI.16<<
        StandardCostWshtNames.EditWorksheet.INVOKE;

        //Step 3 - In Home Tab, Select " Suggest Item  Standard Cost" Function
        //StandardCostWorksheet.Action77.INVOKE; //BC Upgrade KAPOOV01
        StandardCostWorksheet."Suggest I&tem Standard Cost".INVOKE; //BC Upgrade KAPOOV01

        //Step 4 - In Item Tab, Select Item in No field or it will run for all ( done with function SuggestItemStandCostPageHandler)

        //Step 5 - Fill the  " New Standard Cost " field with value ( the old cost unit +1);
        EVALUATE(NewStandardCost, StandardCostWorksheet."Standard Cost".VALUE);
        StandardCostWorksheet."New Standard Cost".SETVALUE(NewStandardCost + 1);

        //Step 6 - Click on implement standard cost
        CLEAR(ImplStdCostChg);
        ImplStdCostChg.SetStdCostWksh(StandardCostWorksheet.CurrWkshName.VALUE);
        ImplStdCostChg.RUNMODAL;

        //Step 7 + 8: Apply filters and click OK are done with function ImpelementItemStandCostPageHandler

        //STep 9: Go to Revaluation journal
        StandardCostWorksheet.CLOSE;

        //Open Item Journal Templates

        //find the revaluation journal template
        ItemJournalTemplate.RESET;
        ItemJournalTemplate.SETRANGE(Type, ItemJournalTemplate.Type::Revaluation);
        if ItemJournalTemplate.FINDFIRST then begin
            ItemJournalTemplates.OPENVIEW;
            ItemJournalBatches.TRAP;
            //HEI.16>>
            //ItemJournalTemplates.FINDFIRSTFIELD(Name,ItemJournalTemplate.Name);
            ItemJournalTemplates.FILTER.SETFILTER(Name, ItemJournalTemplate.Name);
            //HEI.16<<
            //ItemJournalTemplates."Page Item Journal Batches".INVOKE;  //BC Upgrade KAPOOV01 Commented to resolved compilation error
            ItemJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error
        end;

        //Open the Batch
        RevalJournal.TRAP;
        //HEI.16>>
        //ItemJournalBatches.FINDFIRSTFIELD(Name,ItemJournalBatch.Name);
        ItemJournalBatches.FILTER.SETFILTER(Name, ItemJournalBatch.Name);
        //HEI.16<<
        //ItemJournalBatches.Action19.INVOKE; //BC Upgrade KAPOOV01
        ItemJournalBatches."Edit Journal".INVOKE; //BC Upgrade KAPOOV01

        //delete the existing entries
        //HEI.16>>
        //ItemJournalLine.RESET;
        //ItemJournalLine.SETRANGE("Journal Template Name",ItemJournalTemplate.Name);
        //ItemJournalLine.SETRANGE("Journal Batch Name",ItemJournalBatch.Name);
        //IF ItemJournalLine.FINDSET THEN
        //ItemJournalLine.DELETEALL;
        //HEI.16<<

        //Step 11 - Click on Post and confirm with yes ( functions COnfirmationHandler and MessageHandler added)
        //RevalJournal.Action34.INVOKE;  //BC Upgrade KAPOOV01
        RevalJournal."P&ost".INVOKE;  //BC Upgrade KAPOOV01

        //Step 12-Search for item
        ItemList.OPENVIEW;
        ItemCard.TRAP;
        //HEI.16>>
        //ItemList.FINDFIRSTFIELD("No.",Item."No.");
        ItemList.FILTER.SETFILTER("No.", Item."No.");
        //HEI.16<<
        ItemList.VIEW.INVOKE;

        //HEI.06
    end;

    [Test]
    [HandlerFunctions('GLMassUploadRequestPageHandler,MessageHandler,ConfirmationHandler')]
    procedure "RTR006-GLMassUploadWithoutReversal"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        Balance: Decimal;
        Amt: Decimal;
        DefaultDim: Record "Default Dimension";
        DimSetEntry: Record "Dimension Set Entry";
        GLMassUpload: Report "Import Gen.Jrnl From Excel CBN";
        Parameters: Text;
        UserSetup: Record "User Setup";
        WorkflowUserGroup: Record "Workflow User Group";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
    begin
        ClearVariables('RT_RTR001'); //HEI.16
                                     //HEI.02
                                     //Step 1: Login

        //BC Upgrade KAPOOV01 >>
        CreateExcelInTempBlob();
        GLMassUpload.SetInStream(InStr);
        //BC Upgrade KAPOOV01 <<
        GLMassUpload.RUNMODAL;

        //request page is handled by function GLMassUploadRequestPageHandler

        //after uploading the report, a dialog message is displaying the next question: Are you sure you want to replace entries for Journal Template Name RTR.
        //this is handled by function ConfirmationHandler, which automatically replies "YES"

        //after this, if the lines are successfully imported, another message is displayed showing the number of entries inserted.
        //this is handled by function MessageHandler

        //Go to General Journal to check the entries
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        //Gen. Journal Template
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error

        //Gen. Journal Batch
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Step 9 -Check preview posting option for verification
        //GenJournalPage.Preview.INVOKE;
        //Preview GL Entries page is handled by function GLPreviewEntriesPageHandler

        //HEI.16>>
        //Update Workflow User Groups
        UserSetup.FINDFIRST;

        if WorkflowUserGroup.FINDSET(false) then
            repeat
                WorkflowUserGroupMember.SETRANGE("Workflow User Group Code", WorkflowUserGroup.Code);
                WorkflowUserGroupMember.SETRANGE("Sequence No.", 2);
                if not WorkflowUserGroupMember.FINDFIRST then begin
                    WorkflowUserGroupMember.INIT;
                    WorkflowUserGroupMember."Workflow User Group Code" := WorkflowUserGroup.Code;
                    WorkflowUserGroupMember."User Name" := UserSetup."User ID";
                    WorkflowUserGroupMember.INSERT;
                end;
            until WorkflowUserGroup.NEXT = 0;
        //HEI.16<<

        //Step 10 - Send for approval
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            //HEI.16>>
            //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
            //WorkflowResponse.DELETE;
            //HEI.16<<
            GenJournalPage.SendApprovalRequestJournalBatch.INVOKE;
        end else
            //HEI.16>>
            //ERROR('No approval workflow is enabled.');
            MESSAGE(ApprovalNotSentMsg);
        //HEI.16<<
        //HEI.02
    end;

    [Test]
    //[HandlerFunctions('GLMassUploadReversalRequestPageHandler,ConfirmationHandler,MessageHandler,GLPreviewEntriesPageHandler,DimensionSetEntriesModalPageHandler,PostingPageHandler')]  //BC Upgrade KAPOOV01 Removed handler functions-GLMassUploadReversalRequestPageHandler,ConfirmationHandler from Test Script-RTR007 to handle the excel report import functionality from local path. 
    [HandlerFunctions('MessageHandler,GLPreviewEntriesPageHandler,DimensionSetEntriesModalPageHandler')]
    procedure "RTR007-GLMassUploadWithReversal"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        Balance: Decimal;
        Amt: Decimal;
        DefaultDim: Record "Default Dimension";
        DimSetEntry: Record "Dimension Set Entry";
        GLMassUpload: Report "Import Gen.Jrnl From Excel CBN";
        Parameters: Text;
        WorkflowUserGroup: Record "Workflow User Group";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
        UserSetup: Record "User Setup";
        DefaultDimension: Record "Default Dimension";
    begin
        ClearVariables('RT_RTR001'); //HEI.16
                                     //HEI.02

        //Step 1: Login

        //GLMassUpload.RUNMODAL; //BC Upgrade KAPOOV01 commented to handle the excel report import functionality from local path.

        //request page is handled by function GLMassUploadRequestPageHandler

        //after uploading the report, a dialog message is displaying the next question: Are you sure you want to replace entries for Journal Template Name RTR.
        //this is handled by function ConfirmationHandler, which automatically replies "YES"

        //after this, if the lines are successfully imported, another message is displayed showing the number of entries inserted.
        //this is handled by function MessageHandler

        //Go to General Journal to check the entries
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        //HEI.39>>
        GeneralLedgerSetup.GET;
        DefaultDimension.RESET;
        DefaultDimension.SETRANGE("Table ID", 15);
        DefaultDimension.SETFILTER("Dimension Code", '%1', GeneralLedgerSetup."Shortcut Dimension 1 Code");
        DefaultDimension.SETFILTER("Value Posting", '<>%1', DefaultDimension."Value Posting"::" ");
        if DefaultDimension.FINDSET then begin
            repeat
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.MODIFY;
            until DefaultDimension.NEXT = 0;
        end;
        //HEI.39<<


        //HEI.16>>
        GeneralLedgerSetup.GET;
        CCCDimensionValue.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        CCCDimensionValue.SETRANGE(Blocked, false);
        CCCDimensionValue.FINDFIRST;
        //HEI.16<<

        //Gen. Journal Template
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error

        //Gen. Journal Batch
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //BC Upgrade KAPOOV01 Added to replace FileMgt.UploadFileSilent functionality as this functionality is obsolete in BC. >>
        // LINE 1 - NORMAL ENTRY
        GenJournalPage.NEW;
        GenJournalPage."Posting Date".SETVALUE(WORKDATE);
        GenJournalPage."Document No.".SetValue('DOC001');
        GenJournalPage."Account No.".SETVALUE('11001001');
        GenJournalPage.Description.SETVALUE('Normal Entry');
        GenJournalPage.Amount.SETVALUE(1000);
        GenJournalPage."Shortcut Dimension 1 Code".SETVALUE('B0001');
        GenJournalPage."Shortcut Dimension 2 Code".SETVALUE(10100000);

        // LINE 2 - REVERSE ENTRY
        GenJournalPage.NEW;
        GenJournalPage."Posting Date".SETVALUE(WORKDATE);
        GenJournalPage."Document No.".SetValue('DOC001');
        GenJournalPage."Account No.".SETVALUE('11001001');
        GenJournalPage.Description.SETVALUE('REVERSAL');
        GenJournalPage.Amount.SETVALUE(-1000);
        GenJournalPage."Shortcut Dimension 1 Code".SETVALUE('B0001');
        GenJournalPage."Shortcut Dimension 2 Code".SETVALUE(10100000);

        //BC Upgrade KAPOOV01 Added to replace FileMgt.UploadFileSilent functionality as this functionality is obsolete in BC.<<

        //HEI.16>>
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.SETRANGE("Account Type", GenJournalLine."Account Type"::"G/L Account");
        if GenJournalLine.FINDSET(true) then
            repeat
                GenJournalPage.FILTER.SETFILTER("Line No.", FORMAT(GenJournalLine."Line No."));
                GenJournalPage.Dimensions.INVOKE;
            until GenJournalLine.NEXT = 0;

        COMMIT;
        GenJournalPage.OK.INVOKE;

        GenJournalPage.TRAP;
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        GeneralJournalBatches.EditJournal.INVOKE;
        COMMIT;
        //HEI.16<<

        //Step 9 -Check preview posting option for verification
        GenJournalPage.Preview.INVOKE;
        //Preview GL Entries page is handled by function GLPreviewEntriesPageHandler

        //HEI.16>>
        //Update Workflow User Groups
        UserSetup.FINDFIRST;

        if WorkflowUserGroup.FINDSET(false) then
            repeat
                WorkflowUserGroupMember.SETRANGE("Workflow User Group Code", WorkflowUserGroup.Code);
                WorkflowUserGroupMember.SETRANGE("Sequence No.", 2);
                if not WorkflowUserGroupMember.FINDFIRST then begin
                    WorkflowUserGroupMember.INIT;
                    WorkflowUserGroupMember."Workflow User Group Code" := WorkflowUserGroup.Code;
                    WorkflowUserGroupMember."User Name" := UserSetup."User ID";
                    WorkflowUserGroupMember.INSERT;
                end;
            until WorkflowUserGroup.NEXT = 0;
        //HEI.16<<

        //Step 10 - Send for approval
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            //HEI.16>>
            //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
            //WorkflowResponse.DELETE;
            //HEI.16<<
            GenJournalPage.SendApprovalRequestJournalBatch.INVOKE;
            //HEI.16>>
            //END;
        end else
            MESSAGE(ApprovalNotSentMsg);
        //HEI.16<<
        //HEI.02
    end;

    [Test]
    [HandlerFunctions('MessageHandler,DimensionSetEntriesModalPageHandler')]
    procedure "RTR009-AccrualPostingReversal"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        Balance: Decimal;
        Amt: Decimal;
        DefaultDim: Record "Default Dimension";
        DimSetEntry: Record "Dimension Set Entry";
        UserSetup: Record "User Setup";
        WorkflowUserGroup: Record "Workflow User Group";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
    begin
        ClearVariables('RT_RTR001'); //HEI.16
        //HEI.02
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);


        MESSAGE(ApprovalDisabled);//HEI.40
        //Check default value for Account No.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"G/L Account");
        GLAccount.GET(UnitTestingValues.Value);

        //HEI.16>>
        GeneralLedgerSetup.GET;
        CCCDimensionValue.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        CCCDimensionValue.SETRANGE(Blocked, false);
        CCCDimensionValue.FINDFIRST;
        //HEI.16<<

        //Step 1: Login

        //Step 4 Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error

        //Step5 - Open Gen. Journal Batch page
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Step 6- Create Journal Line
        GenJournalPage.NEW;

        GenJournalPage."Source Code".SETVALUE(GenJournalTemplate."Source Code");
        GenJournalPage."Posting Date".SETVALUE(WORKDATE);
        GenJournalPage."Account Type".SETVALUE(AccType::"G/L Account");
        GenJournalPage."Account No.".SETVALUE(GLAccount."No.");
        GenJournalPage.Description.SETVALUE('Unit Test RTR009');
        GenJournalPage.Amount.SETVALUE(1000);
        DocumentNo := GenJournalPage."Document No.".VALUE;

        if GenJournalBatch."Bal. Account No." <> '' then begin
            //Bal Account Type (auto - template)
            GenJournalPage."Bal. Account Type".ASSERTEQUALS(GenJournalBatch."Bal. Account Type");
            //Bal Account No (auto - template)
            GenJournalPage."Bal. Account No.".ASSERTEQUALS(GenJournalBatch."Bal. Account No.");
        end else begin
            GenJournalPage."Bal. Account Type".SETVALUE(AccType::"G/L Account");
            GenJournalPage."Bal. Account No.".SETVALUE(GLAccount."No.");
        end;

        //Step 7 - Preview Posting
        //GenJournalPage.Preview.INVOKE;
        //Replace Preview posting done for a final check with manual checks because the Preview action is not found

        //Check the doc. No.
        if DocumentNo = '' then
            ERROR('Document No. is blank.');

        //Check the balance
        EVALUATE(Balance, GenJournalPage.Balance.VALUE);
        if Balance <> 0 then
            ERROR('Document %1 is out of balance.', DocumentNo);

        //Check the Amount
        EVALUATE(Amt, GenJournalPage.Amount.VALUE);
        if Amt = 0 then
            ERROR('The amount of Document %1 is blank.', DocumentNo);

        //Check mandatory dimenions
        DefaultDim.RESET;
        DefaultDim.SETRANGE("Table ID", 15);
        DefaultDim.SETRANGE("No.", GLAccount."No.");
        DefaultDim.SETRANGE("Value Posting", DefaultDim."Value Posting"::"Code Mandatory");
        if DefaultDim.FINDSET then
            repeat
                DimSetEntry.RESET;
                if not DimSetEntry.GET(GenJournalPage."Dimension Set ID".VALUE, DefaultDim."Dimension Code") then
                    ERROR('Dimension code %1 is missing for Document No. %2', DefaultDim."Dimension Code", DocumentNo);
            until DefaultDim.NEXT = 0;

        //STep 8 + 9- Attach a supporting document to MJE by navigating to "Incoming document" and selecting "Create incoming document from file" - SKIP this step because of error compilation
        //GenJournalPage.IncomingDocAttachFile.INVOKE;

        //HEI.16>>
        //Dimensions
        GenJournalPage.Dimensions.INVOKE;

        //Update Workflow User Groups
        UserSetup.FINDFIRST;

        if WorkflowUserGroup.FINDSET(false) then
            repeat
                WorkflowUserGroupMember.SETRANGE("Workflow User Group Code", WorkflowUserGroup.Code);
                WorkflowUserGroupMember.SETRANGE("Sequence No.", 2);
                if not WorkflowUserGroupMember.FINDFIRST then begin
                    WorkflowUserGroupMember.INIT;
                    WorkflowUserGroupMember."Workflow User Group Code" := WorkflowUserGroup.Code;
                    WorkflowUserGroupMember."User Name" := UserSetup."User ID";
                    WorkflowUserGroupMember.INSERT;
                end;
            until WorkflowUserGroup.NEXT = 0;
        //HEI.16<<

        //Step 10 - Send for approval
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            //HEI.16>>
            //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
            //WorkflowResponse.DELETE;
            //HEI.16<<
            GenJournalPage.SendApprovalRequestJournalBatch.INVOKE;

            //Step 11 - Check if the posting batch was created and submitted for approval - Open the page to see the requests
            ApprovalEntries.TRAP;
            GenJournalPage.Approvals.INVOKE;

            //Step 12 - Approve the request
            //Update Substitute for Approver ID = USERID
            if UserSetup.GET(ApprovalEntries."Approver ID".VALUE) then begin
                UserSetup.Substitute := USERID;
                UserSetup.MODIFY;
            end;

            //Delegate Approval Request
            ApprovalEntries.FILTER.SETFILTER(Status, 'Open');
            // ApprovalEntries.Action35.INVOKE;

            //Approve Approval Entry
            GenJournalPage.Approve.INVOKE;

        end else
            //HEI.16>>
            //ERROR('No approval workflow is enabled.');
            MESSAGE(ApprovalNotSentMsg);
        //HEI.16<<

        //Step 12 - Post
        //GenJournalPage.Preview.INVOKE;

        //Step 13 - Fill in the same data as in step 06 but with opposite signs.
        GenJournalPage.NEW;

        GenJournalPage."Source Code".SETVALUE(GenJournalTemplate."Source Code");
        GenJournalPage."Posting Date".SETVALUE(WORKDATE);
        GenJournalPage."Account Type".SETVALUE(AccType::"G/L Account");
        GenJournalPage."Account No.".SETVALUE(GLAccount."No.");
        GenJournalPage.Description.SETVALUE('Unit Test RT_RTR001');
        GenJournalPage.Amount.SETVALUE(-1000);
        DocumentNo := GenJournalPage."Document No.".VALUE;

        if GenJournalBatch."Bal. Account No." <> '' then begin
            //Bal Account Type (auto - template)
            GenJournalPage."Bal. Account Type".ASSERTEQUALS(GenJournalBatch."Bal. Account Type");
            //Bal Account No (auto - template)
            GenJournalPage."Bal. Account No.".ASSERTEQUALS(GenJournalBatch."Bal. Account No.");
        end else begin
            GenJournalPage."Bal. Account Type".SETVALUE(AccType::"G/L Account");
            GenJournalPage."Bal. Account No.".SETVALUE(GLAccount."No.");
        end;


        //Step 14 - Preview Posting
        //GenJournalPage.Preview.INVOKE;
        //Replace Preview posting done for a final check with manual checks because the Preview action is not found

        //Check the doc. No.
        if DocumentNo = '' then
            ERROR('Document No. is blank.');

        //Check the balance
        EVALUATE(Balance, GenJournalPage.Balance.VALUE);
        if Balance <> 0 then
            ERROR('Document %1 is out of balance.', DocumentNo);

        //Check the Amount
        EVALUATE(Amt, GenJournalPage.Amount.VALUE);
        if Amt = 0 then
            ERROR('The amount of Document %1 is blank.', DocumentNo);

        //Check mandatory dimenions
        DefaultDim.RESET;
        DefaultDim.SETRANGE("Table ID", 15);
        DefaultDim.SETRANGE("No.", GLAccount."No.");
        DefaultDim.SETRANGE("Value Posting", DefaultDim."Value Posting"::"Code Mandatory");
        if DefaultDim.FINDSET then
            repeat
                DimSetEntry.RESET;
                if not DimSetEntry.GET(GenJournalPage."Dimension Set ID".VALUE, DefaultDim."Dimension Code") then
                    ERROR('Dimension code %1 is missing for Document No. %2', DefaultDim."Dimension Code", DocumentNo);
            until DefaultDim.NEXT = 0;

        //STep 15 + 16- Attach a supporting document to MJE by navigating to "Incoming document" and selecting "Create incoming document from file" - SKIP this step because of error compilation
        //GenJournalPage.IncomingDocAttachFile.INVOKE;

        //Step 17 - Send for approval
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            //HEI.16>>
            //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
            //WorkflowResponse.DELETE;
            //HEI.16<<
            GenJournalPage.SendApprovalRequestJournalBatch.INVOKE
        end else
            //HEI.16>>
            //ERROR('No approval workflow is enabled.');
            MESSAGE(ApprovalNotSentMsg);
        //HEI.16<<

        //HEI.02
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,DimensionSetEntriesModalPageHandler,PostingPageHandler')]//BC Upgrade YADAVM09<<
    procedure "RTR011-ManualGLPostingClosedPeriod"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        Balance: Decimal;
        Amt: Decimal;
        DefaultDim: Record "Default Dimension";
        DimSetEntry: Record "Dimension Set Entry";
        Workflow: Record Workflow;
        RestrictedRecord: Record "Restricted Record";
        error2: Text;
    begin
        ClearVariables('RT_RTR001'); //HEI.16
        //HEI.03

        //Check default value for Journal Template
        UnitTestingValues.RESET();
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET();
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        //Check default value for Account No.
        UnitTestingValues.RESET();
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"G/L Account");
        GLAccount.GET(UnitTestingValues.Value);

        //HEI.16>>
        GeneralLedgerSetup.GET();
        CCCDimensionValue.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        CCCDimensionValue.SETRANGE(Blocked, false);
        CCCDimensionValue.FINDFIRST;
        //HEI.16<<

        //Step 1: Login

        //Step 4 Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error

        //Step5 - Open Gen. Journal Batch page
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Step 6- Create Journal Line
        GenJournalPage.NEW;

        GenJournalPage."Source Code".SETVALUE(GenJournalTemplate."Source Code");
        GenJournalPage."Account Type".SETVALUE(AccType::"G/L Account");
        GenJournalPage."Account No.".SETVALUE(GLAccount."No.");
        GenJournalPage.Description.SETVALUE('Unit Test RTR011');
        GenJournalPage.Amount.SETVALUE(1000);
        DocumentNo := GenJournalPage."Document No.".VALUE;
        if GenJournalBatch."Bal. Account No." <> '' then begin
            //Bal Account Type (auto - template)
            GenJournalPage."Bal. Account Type".ASSERTEQUALS(GenJournalBatch."Bal. Account Type");
            //Bal Account No (auto - template)
            GenJournalPage."Bal. Account No.".ASSERTEQUALS(GenJournalBatch."Bal. Account No.");
        end else begin
            GenJournalPage."Bal. Account Type".SETVALUE(AccType::"G/L Account");
            GenJournalPage."Bal. Account No.".SETVALUE(GLAccount."No.");
        end;

        //set the posting date to be out of allowed posting range
        //HEI.16>>
        //GenJournalPage."Posting Date".SETVALUE(01012040D);
        GenJournalPage."Posting Date".SETVALUE(DMY2DATE(1, 1, 2040));

        //Dimensions
        GenJournalPage.Dimensions.INVOKE;
        //HEI.16<<

        //Disable Workflows before Release
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            Workflow.SETRANGE(Enabled, true);
            if Workflow.FINDSET then
                repeat
                    Workflow.Enabled := false;
                    Workflow.MODIFY;
                until Workflow.NEXT = 0;
        end;

        //delete the record restrictions
        RestrictedRecord.RESET;
        if RestrictedRecord.FINDSET then
            RestrictedRecord.DELETEALL;

        //HEI.16>>
        //GenJournalPage.Post.INVOKE;
        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.FINDFIRST();

        GenJournalPage.Post.INVOKE();

        //Bc upgrade YADAVM09>>
        // if GETLASTERRORTEXT <> STRSUBSTNO(NotAllowedDateErr, GenJournalLine.FIELDCAPTION("Posting Date"), GenJournalLine.TABLECAPTION,
        //                                   GenJournalLine.FIELDCAPTION("Journal Template Name"), GenJournalLine."Journal Template Name",
        //                                   GenJournalLine.FIELDCAPTION("Journal Batch Name"), GenJournalLine."Journal Batch Name",
        //                                   GenJournalLine.FIELDCAPTION("Line No."), GenJournalLine."Line No.")
        // then
        //     ERROR('Unexpected Error: %1', GETLASTERRORTEXT);
        //Bc upgrade YADAVM09<<
        //HEI.16<<

        //HEI.03
    end;

    [Test]
    [HandlerFunctions('MessageHandler,DimensionSetEntriesModalPageHandler')]
    procedure "RTR012-ManualGLPostingForeignCurrency"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        Balance: Decimal;
        Amt: Decimal;
        DefaultDim: Record "Default Dimension";
        DimSetEntry: Record "Dimension Set Entry";
        UserSetup: Record "User Setup";
        WorkflowUserGroup: Record "Workflow User Group";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
    begin
        ClearVariables('RT_RTR001'); //HEI.16
        //HEI.03
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        MESSAGE(ApprovalDisabled);//HEI.40
        //Check default value for Account No.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"G/L Account");
        GLAccount.GET(UnitTestingValues.Value);

        //HEI.16>>
        GeneralLedgerSetup.GET;
        CCCDimensionValue.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        CCCDimensionValue.SETRANGE(Blocked, false);
        CCCDimensionValue.FINDFIRST;
        //HEI.16<<

        //Step 1: Login

        //Step 4 Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error

        //Step5 - Open Gen. Journal Batch page
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Step 6- Create Journal Line
        GenJournalPage.NEW;

        GenJournalPage."Source Code".SETVALUE(GenJournalTemplate."Source Code");
        GenJournalPage."Posting Date".SETVALUE(WORKDATE);
        GenJournalPage."Account Type".SETVALUE(AccType::"G/L Account");
        GenJournalPage."Account No.".SETVALUE(GLAccount."No.");
        GenJournalPage.Description.SETVALUE('Unit Test RT_RTR0012');
        GenJournalPage.Amount.SETVALUE(1000);
        DocumentNo := GenJournalPage."Document No.".VALUE;
        //GenJournalPage."Currency Code".SETVALUE('USD');

        if GenJournalBatch."Bal. Account No." <> '' then begin
            //Bal Account Type (auto - template)
            GenJournalPage."Bal. Account Type".ASSERTEQUALS(GenJournalBatch."Bal. Account Type");
            //Bal Account No (auto - template)
            GenJournalPage."Bal. Account No.".ASSERTEQUALS(GenJournalBatch."Bal. Account No.");
        end else begin
            GenJournalPage."Bal. Account Type".SETVALUE(AccType::"G/L Account");
            GenJournalPage."Bal. Account No.".SETVALUE(GLAccount."No.");
        end;

        //HEI.16>>
        //Dimensions
        GenJournalPage.Dimensions.INVOKE;

        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.SETRANGE("Account Type", GenJournalLine."Account Type"::"G/L Account");
        GenJournalLine.SETRANGE("Account No.", GLAccount."No.");
        GenJournalLine.FINDFIRST;
        GenJournalLine."Currency Code" := 'USD';
        GenJournalLine.MODIFY;

        COMMIT;
        GenJournalPage.OK.INVOKE;

        GenJournalPage.TRAP;
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        GeneralJournalBatches.EditJournal.INVOKE;
        COMMIT;

        //Update Workflow User Groups
        UserSetup.FINDFIRST;

        if WorkflowUserGroup.FINDSET(false) then
            repeat
                WorkflowUserGroupMember.SETRANGE("Workflow User Group Code", WorkflowUserGroup.Code);
                WorkflowUserGroupMember.SETRANGE("Sequence No.", 2);
                if not WorkflowUserGroupMember.FINDFIRST then begin
                    WorkflowUserGroupMember.INIT;
                    WorkflowUserGroupMember."Workflow User Group Code" := WorkflowUserGroup.Code;
                    WorkflowUserGroupMember."User Name" := UserSetup."User ID";
                    WorkflowUserGroupMember.INSERT;
                end;
            until WorkflowUserGroup.NEXT = 0;
        //HEI.16<<

        //Step 8 - Send for approval
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            //HEI.16>>
            //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
            //WorkflowResponse.DELETE;
            //HEI.016<<
            GenJournalPage.SendApprovalRequestJournalBatch.INVOKE
        end else
            //HEI.16>>
            MESSAGE(ApprovalNotSentMsg);
        //ERROR('No approval workflow is enabled.');
        //HEI.16<<

        //HEI.03
    end;

    [Test]
    //[HandlerFunctions('MessageHandler,TestReportReportHandler,DimensionSetEntriesModalPageHandler')]
    [HandlerFunctions('MessageHandler,DimensionSetEntriesModalPageHandler')] //BC Upgrade KAPOOV01 Removed ReportHandler- TestReportReportHandler
    procedure "RTR014-ApproveGLPosting"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        TestReport: Report "General Journal - Test";
        GenJnlLine: Record "Gen. Journal Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
        WorkflowUserGroup: Record "Workflow User Group";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
        UserGenJournalSetup: TestPage "User Gen. Journal Setup CBN";
        RecUserGenJournalSetup: Record "User Gen. Journal Setup FND";
    begin
        ClearVariables('RT_RTR001'); //HEI.16
        //HEI.03
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        MESSAGE(ApprovalDisabled);//HEI.40
        //Check default value for Account No.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"G/L Account");
        GLAccount.GET(UnitTestingValues.Value);

        //HEI.16>>
        GeneralLedgerSetup.GET;
        CCCDimensionValue.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        CCCDimensionValue.SETRANGE(Blocked, false);
        CCCDimensionValue.FINDFIRST;
        //HEI.16<<

        //Step 1: Login

        // Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error

        // Open Gen. Journal Batch page

        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        //GeneralJournalBatches.OPENVIEW;//HEI.42

        //Step Create Journal Line
        //HEI.43>>
        UserGenJournalSetup.OPENNEW;
        //HEI.46>>
        RecUserGenJournalSetup.RESET;
        RecUserGenJournalSetup.SETCURRENTKEY("Journal Type", "User ID", "Gen. Journal Template Name");
        RecUserGenJournalSetup.SETFILTER("Journal Type", 'General');
        RecUserGenJournalSetup.SETFILTER("Gen. Journal Template Name", GenJournalTemplate.Name);
        if not RecUserGenJournalSetup.FINDFIRST then begin
            //HEI.46<<
            UserGenJournalSetup."Journal Type".VALUE := 'General';
            UserGenJournalSetup."User ID".VALUE := USERID;
            UserGenJournalSetup."Gen. Journal Template Name".VALUE := GenJournalTemplate.Name;//HEI.46
            UserGenJournalSetup.OK.INVOKE;
        end;//HEI.46>>
        GeneralJournalBatches.EditJournal.INVOKE;
        //HEI.43<<

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Step Create Journal Line
        GenJournalPage.NEW;

        GenJournalPage."Source Code".SETVALUE(GenJournalTemplate."Source Code");
        GenJournalPage."Posting Date".SETVALUE(WORKDATE);
        GenJournalPage."Account Type".SETVALUE(AccType::"G/L Account");
        GenJournalPage."Account No.".SETVALUE(GLAccount."No.");
        GenJournalPage.Description.SETVALUE('Unit Test RTR014');
        GenJournalPage.Amount.SETVALUE(1000);
        DocumentNo := GenJournalPage."Document No.".VALUE;
        if GenJournalBatch."Bal. Account No." <> '' then begin
            GenJournalPage."Bal. Account Type".ASSERTEQUALS(GenJournalBatch."Bal. Account Type");
            GenJournalPage."Bal. Account No.".ASSERTEQUALS(GenJournalBatch."Bal. Account No.");
        end else begin
            GenJournalPage."Bal. Account Type".SETVALUE(AccType::"G/L Account");
            GenJournalPage."Bal. Account No.".SETVALUE(GLAccount."No.");
        end;

        //HEI.16>>
        //Dimensions
        //GenJournalPage.OPENVIEW;//HEI.42
        GenJournalPage.Dimensions.INVOKE;

        //Update Workflow User Groups
        UserSetup.FINDFIRST;

        if WorkflowUserGroup.FINDSET(false) then
            repeat
                WorkflowUserGroupMember.SETRANGE("Workflow User Group Code", WorkflowUserGroup.Code);
                WorkflowUserGroupMember.SETRANGE("Sequence No.", 2);
                if not WorkflowUserGroupMember.FINDFIRST then begin
                    WorkflowUserGroupMember.INIT;
                    WorkflowUserGroupMember."Workflow User Group Code" := WorkflowUserGroup.Code;
                    WorkflowUserGroupMember."User Name" := UserSetup."User ID";
                    WorkflowUserGroupMember.INSERT;
                end;
            until WorkflowUserGroup.NEXT = 0;
        //HEI.16<<

        //Send for approval
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            //HEI.16>>
            //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
            //WorkflowResponse.DELETE;
            //HEI.16<<
            GenJournalPage.SendApprovalRequestJournalBatch.INVOKE;

            //Check if the posting batch was created and submitted for approval - Open the page to see the requests

            ApprovalEntries.TRAP;
            //ApprovalEntries.OPENVIEW;//HEI.42
            GenJournalPage.Approvals.INVOKE;

            //Update Substitute for Approver ID = USERID
            ApprovalEntries.FILTER.SETFILTER(Status, 'Open');
            if UserSetup.GET(ApprovalEntries."Approver ID".VALUE) then begin
                UserSetup.Substitute := USERID;
                UserSetup.MODIFY;
            end;

            //Step 4 - Go to record - this will open the Page Gen. Journal

            GenJournalPage.TRAP; //HEI.16
                                 // GenJournalPage.OPENVIEW;//HEI.42
                                 // ApprovalEntries.Action38.INVOKE;//HEI.44
                                 //HEI.44>>
            ApprovalEntries.TRAP;
            GeneralJournalBatches.EditJournal.INVOKE;
            GenJournalPage.Approvals.INVOKE;
            //HEI.44<<
            //step 5 - Generate the "Test Report" (handled by function TestReportRequestTestPage)
            GenJnlLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
            GenJnlLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
            GenJournalTemplate.TESTFIELD("Test Report ID");
            REPORT.RUN(GenJournalTemplate."Test Report ID", false, false, GenJnlLine);

            //Step 6 - Approve Approval Entry
            if GenJournalPage.Approve.ENABLED then //BEGIN //HEI.42
                                                   //GenJournalPage.OPENVIEW;//HEI.42
                GenJournalPage.Approve.INVOKE;
            // END;

            //Step 7 - Send an email to initiator of transaction (RtR Administrator) with approval of the posting
            //this is automatically sent using the workflow

        end else
            //HEI.16>>
            //ERROR('No approval workflow is enabled.');
            MESSAGE(ApprovalNotSentMsg);
        //HEI.16<<
        //HEI.03
    end;

    [Test]
    [HandlerFunctions('MessageHandler,DimensionSetEntriesModalPageHandler')]
    procedure "RTR015-ApproveGLPosting2Approvers"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        TestReport: Report "General Journal - Test";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        LineNo: Integer;
        Status: Option Created,Open,Canceled,Rejected,Approved;
        GeneralLedgerSetup: Record "General Ledger Setup";
        WorkflowUserGroup: Record "Workflow User Group";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
    begin
        ClearVariables('RT_RTR001'); //HEI.16
        //HEI.03
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        MESSAGE(ApprovalDisabled);//HEI.40
        //Check default value for Account No.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"G/L Account");
        GLAccount.GET(UnitTestingValues.Value);

        //HEI.16>>
        GeneralLedgerSetup.GET;
        CCCDimensionValue.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        CCCDimensionValue.SETRANGE(Blocked, false);
        CCCDimensionValue.FINDFIRST;
        //HEI.16<<

        //Step 1: Login

        // Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error

        // Open Gen. Journal Batch page
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Step Create Journal Line
        GenJournalPage.NEW;

        GenJournalPage."Source Code".SETVALUE(GenJournalTemplate."Source Code");
        GenJournalPage."Posting Date".SETVALUE(WORKDATE);
        GenJournalPage."Account Type".SETVALUE(AccType::"G/L Account");
        GenJournalPage."Account No.".SETVALUE(GLAccount."No.");
        GenJournalPage.Description.SETVALUE('Unit Test RTR015');

        //setting the amount to be bigger than 10000
        GenJournalPage.Amount.SETVALUE(100000);
        DocumentNo := GenJournalPage."Document No.".VALUE;
        if GenJournalBatch."Bal. Account No." <> '' then begin
            GenJournalPage."Bal. Account Type".ASSERTEQUALS(GenJournalBatch."Bal. Account Type");
            GenJournalPage."Bal. Account No.".ASSERTEQUALS(GenJournalBatch."Bal. Account No.");
        end else begin
            GenJournalPage."Bal. Account Type".SETVALUE(AccType::"G/L Account");
            GenJournalPage."Bal. Account No.".SETVALUE(GLAccount."No.");
        end;

        //HEI.16>>
        //Dimensions
        GenJournalPage.Dimensions.INVOKE;

        //Update Workflow User Groups
        UserSetup.FINDFIRST;

        if WorkflowUserGroup.FINDSET(false) then
            repeat
                WorkflowUserGroupMember.SETRANGE("Workflow User Group Code", WorkflowUserGroup.Code);
                WorkflowUserGroupMember.SETRANGE("Sequence No.", 2);
                if not WorkflowUserGroupMember.FINDFIRST then begin
                    WorkflowUserGroupMember.INIT;
                    WorkflowUserGroupMember."Workflow User Group Code" := WorkflowUserGroup.Code;
                    WorkflowUserGroupMember."User Name" := UserSetup."User ID";
                    WorkflowUserGroupMember.INSERT;
                end;
            until WorkflowUserGroup.NEXT = 0;
        //HEI.16<<

        //Send for approval
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            //HEI.16>>
            //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
            //WorkflowResponse.DELETE;
            //HEI.16<<
            GenJournalPage.SendApprovalRequestJournalBatch.INVOKE;

            //Approve for the first approver
            ApprovalEntries.TRAP;
            GenJournalPage.Approvals.INVOKE;

            //Update Substitute for Approver ID = USERID
            ApprovalEntries.FILTER.SETFILTER(Status, 'Open');
            if UserSetup.GET(ApprovalEntries."Approver ID".VALUE) then begin
                UserSetup.Substitute := USERID;
                UserSetup.MODIFY;
            end;

            //Close the Approval entries page
            ApprovalEntries.CLOSE;

            // Approve Approval Entry
            if GenJournalPage.Approve.ENABLED then
                GenJournalPage.Approve.INVOKE;

            //Approve the second approver
            ApprovalEntries.TRAP;
            GenJournalPage.Approvals.INVOKE;

            //Update Substitute for Approver ID = USERID
            ApprovalEntries.FILTER.SETFILTER(Status, 'Open');
            if UserSetup.GET(ApprovalEntries."Approver ID".VALUE) then begin
                UserSetup.Substitute := USERID;
                UserSetup.MODIFY;
            end;

            //Reject Approval Entry
            if GenJournalPage.Approve.ENABLED then
                GenJournalPage.Approve.INVOKE;

            //Step 7 - Send an email to initiator of transaction (RtR Administrator) with approval of the posting
            //this is automatically sent using the workflow

        end else
            //HEI.16>>
            //ERROR('No approval workflow is enabled.');
            MESSAGE(ApprovalNotSentMsg);
        //HEI.16<<
        //HEI.03
    end;

    [Test]
    [HandlerFunctions('MessageHandler,DimensionSetEntriesModalPageHandler')]
    procedure "RTR016-ApproveRejectGLPosting2Approvers"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        TestReport: Report "General Journal - Test";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        LineNo: Integer;
        Status: Option Created,Open,Canceled,Rejected,Approved;
        GeneralLedgerSetup: Record "General Ledger Setup";
        WorkflowUserGroup: Record "Workflow User Group";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
    begin
        ClearVariables('RT_RTR001'); //HEI.16
        //HEI.03
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        MESSAGE(ApprovalDisabled);//HEI.40
        //Check default value for Account No.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"G/L Account");
        GLAccount.GET(UnitTestingValues.Value);

        //HEI.16>>
        GeneralLedgerSetup.GET;
        CCCDimensionValue.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        CCCDimensionValue.SETRANGE(Blocked, false);
        CCCDimensionValue.FINDFIRST;
        //HEI.16<<

        //Step 1: Login

        // Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error

        // Open Gen. Journal Batch page
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Step Create Journal Line
        GenJournalPage.NEW;

        GenJournalPage."Source Code".SETVALUE(GenJournalTemplate."Source Code");
        GenJournalPage."Posting Date".SETVALUE(WORKDATE);
        GenJournalPage."Account Type".SETVALUE(AccType::"G/L Account");
        GenJournalPage."Account No.".SETVALUE(GLAccount."No.");
        GenJournalPage.Description.SETVALUE('Unit Test RTR015');

        //setting the amount to be bigger than 10000
        GenJournalPage.Amount.SETVALUE(100000);
        DocumentNo := GenJournalPage."Document No.".VALUE;
        if GenJournalBatch."Bal. Account No." <> '' then begin
            GenJournalPage."Bal. Account Type".ASSERTEQUALS(GenJournalBatch."Bal. Account Type");
            GenJournalPage."Bal. Account No.".ASSERTEQUALS(GenJournalBatch."Bal. Account No.");
        end else begin
            GenJournalPage."Bal. Account Type".SETVALUE(AccType::"G/L Account");
            GenJournalPage."Bal. Account No.".SETVALUE(GLAccount."No.");
        end;

        //HEI.16>>
        //Dimensions
        GenJournalPage.Dimensions.INVOKE;

        //Update Workflow User Groups
        UserSetup.FINDFIRST;

        if WorkflowUserGroup.FINDSET(false) then
            repeat
                WorkflowUserGroupMember.SETRANGE("Workflow User Group Code", WorkflowUserGroup.Code);
                WorkflowUserGroupMember.SETRANGE("Sequence No.", 2);
                if not WorkflowUserGroupMember.FINDFIRST then begin
                    WorkflowUserGroupMember.INIT;
                    WorkflowUserGroupMember."Workflow User Group Code" := WorkflowUserGroup.Code;
                    WorkflowUserGroupMember."User Name" := UserSetup."User ID";
                    WorkflowUserGroupMember.INSERT;
                end;
            until WorkflowUserGroup.NEXT = 0;
        //HEI.16<<

        //Send for approval
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            //HEI.16>>
            //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
            //WorkflowResponse.DELETE;
            //HEI.16<<
            GenJournalPage.SendApprovalRequestJournalBatch.INVOKE;

            //Approve for the first approver
            ApprovalEntries.TRAP;
            GenJournalPage.Approvals.INVOKE;

            //Update Substitute for Approver ID = USERID
            ApprovalEntries.FILTER.SETFILTER(Status, 'Open');
            if UserSetup.GET(ApprovalEntries."Approver ID".VALUE) then begin
                UserSetup.Substitute := USERID;
                UserSetup.MODIFY;
            end;

            //Close the Approval entries page
            ApprovalEntries.CLOSE;

            // Approve Approval Entry
            if GenJournalPage.Approve.ENABLED then
                GenJournalPage.Approve.INVOKE;

            //Reject second approver
            ApprovalEntries.TRAP;
            GenJournalPage.Approvals.INVOKE;

            //Update Substitute for Approver ID = USERID
            ApprovalEntries.FILTER.SETFILTER(Status, 'Open');
            if UserSetup.GET(ApprovalEntries."Approver ID".VALUE) then begin
                UserSetup.Substitute := USERID;
                UserSetup.MODIFY;
            end;

            //Reject Approval Entry
            GenJournalPage.Reject.INVOKE;

            //Step 7 - Send an email to initiator of transaction (RtR Administrator) with approval of the posting
            //this is automatically sent using the workflow

        end else
            //HEI.16>>
            //ERROR('No approval workflow is enabled.');
            MESSAGE(ApprovalNotSentMsg);
        //HEI.16<<
        //HEI.03
    end;

    [Test]
    [HandlerFunctions('MessageHandler,DimensionSetEntriesModalPageHandler')]
    procedure "RTR017-RejectGLPosting"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        TestReport: Report "General Journal - Test";
        GenJnlLine: Record "Gen. Journal Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
        WorkflowUserGroup: Record "Workflow User Group";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
    begin
        ClearVariables('RT_RTR001'); //HEI.16
        //HEI.03
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        //Check default value for Account No.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"G/L Account");
        GLAccount.GET(UnitTestingValues.Value);

        MESSAGE(ApprovalDisabled);//HEI.40
        //HEI.16>>
        GeneralLedgerSetup.GET;
        CCCDimensionValue.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        CCCDimensionValue.SETRANGE(Blocked, false);
        CCCDimensionValue.FINDFIRST;
        //HEI.16<<

        //Step 1: Login

        // Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error

        // Open Gen. Journal Batch page
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Step Create Journal Line
        GenJournalPage.NEW;

        GenJournalPage."Source Code".SETVALUE(GenJournalTemplate."Source Code");
        GenJournalPage."Posting Date".SETVALUE(WORKDATE);
        GenJournalPage."Account Type".SETVALUE(AccType::"G/L Account");
        GenJournalPage."Account No.".SETVALUE(GLAccount."No.");
        GenJournalPage.Description.SETVALUE('Unit Test RTR017');
        GenJournalPage.Amount.SETVALUE(1000);
        DocumentNo := GenJournalPage."Document No.".VALUE;
        if GenJournalBatch."Bal. Account No." <> '' then begin
            GenJournalPage."Bal. Account Type".ASSERTEQUALS(GenJournalBatch."Bal. Account Type");
            GenJournalPage."Bal. Account No.".ASSERTEQUALS(GenJournalBatch."Bal. Account No.");
        end else begin
            GenJournalPage."Bal. Account Type".SETVALUE(AccType::"G/L Account");
            GenJournalPage."Bal. Account No.".SETVALUE(GLAccount."No.");
        end;

        //HEI.16>>
        //Dimensions
        GenJournalPage.Dimensions.INVOKE;

        //Update Workflow User Groups
        UserSetup.FINDFIRST;

        if WorkflowUserGroup.FINDSET(false) then
            repeat
                WorkflowUserGroupMember.SETRANGE("Workflow User Group Code", WorkflowUserGroup.Code);
                WorkflowUserGroupMember.SETRANGE("Sequence No.", 2);
                if not WorkflowUserGroupMember.FINDFIRST then begin
                    WorkflowUserGroupMember.INIT;
                    WorkflowUserGroupMember."Workflow User Group Code" := WorkflowUserGroup.Code;
                    WorkflowUserGroupMember."User Name" := UserSetup."User ID";
                    WorkflowUserGroupMember.INSERT;
                end;
            until WorkflowUserGroup.NEXT = 0;
        //HEI.16<<

        //Send for approval
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            //HEI.16>>
            //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
            //WorkflowResponse.DELETE;
            //HEI.16<<
            GenJournalPage.SendApprovalRequestJournalBatch.INVOKE;

            //Check if the posting batch was created and submitted for approval - Open the page to see the requests
            ApprovalEntries.TRAP;
            GenJournalPage.Approvals.INVOKE;

            //Update Substitute for Approver ID = USERID
            ApprovalEntries.FILTER.SETFILTER(Status, 'Open');
            if UserSetup.GET(ApprovalEntries."Approver ID".VALUE) then begin
                UserSetup.Substitute := USERID;
                UserSetup.MODIFY;
            end;

            //Delegate Approval Request
            // ApprovalEntries.Action35.INVOKE;

            //Step 6 - Reject Approval Entry
            GenJournalPage.Reject.INVOKE;

            //Step 7 - Send an email to initiator of transaction (RtR Administrator) with approval of the posting
            //this is automatically sent using the workflow

        end else
            //HEI.16>>
            //ERROR('No approval workflow is enabled.');
            MESSAGE(ApprovalNotSentMsg);
        //HEI.16<<
        //HEI.03
    end;

    [Test]
    procedure "RTR019-DeleteMultipleJournalLines"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        TestReport: Report "General Journal - Test";
        GenJnlLine: Record "Gen. Journal Line";
    begin
        ClearVariables('RT_RTR001'); //HEI.16
        //HEI.03
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        //Check default value for Account No.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"G/L Account");
        GLAccount.GET(UnitTestingValues.Value);

        //Step 1: Login

        // Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error

        // Open Gen. Journal Batch page
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Create the first Journal Line
        GenJournalPage.NEW;
        GenJournalPage."Source Code".SETVALUE(GenJournalTemplate."Source Code");
        GenJournalPage."Posting Date".SETVALUE(WORKDATE);
        GenJournalPage."Account Type".SETVALUE(AccType::"G/L Account");
        GenJournalPage."Account No.".SETVALUE(GLAccount."No.");
        GenJournalPage.Description.SETVALUE('Unit Test RTR019 Line 1');
        GenJournalPage.Amount.SETVALUE(1000);
        DocumentNo := GenJournalPage."Document No.".VALUE;
        if GenJournalBatch."Bal. Account No." <> '' then begin
            GenJournalPage."Bal. Account Type".ASSERTEQUALS(GenJournalBatch."Bal. Account Type");
            GenJournalPage."Bal. Account No.".ASSERTEQUALS(GenJournalBatch."Bal. Account No.");
        end else begin
            GenJournalPage."Bal. Account Type".SETVALUE(AccType::"G/L Account");
            GenJournalPage."Bal. Account No.".SETVALUE(GLAccount."No.");
        end;

        //Create the second Journal Line
        GenJournalPage.NEW;
        GenJournalPage."Source Code".SETVALUE(GenJournalTemplate."Source Code");
        GenJournalPage."Posting Date".SETVALUE(WORKDATE);
        GenJournalPage."Account Type".SETVALUE(AccType::"G/L Account");
        GenJournalPage."Account No.".SETVALUE(GLAccount."No.");
        GenJournalPage.Description.SETVALUE('Unit Test RTR019 Line 2');
        GenJournalPage.Amount.SETVALUE(1000);
        DocumentNo := GenJournalPage."Document No.".VALUE;
        if GenJournalBatch."Bal. Account No." <> '' then begin
            GenJournalPage."Bal. Account Type".ASSERTEQUALS(GenJournalBatch."Bal. Account Type");
            GenJournalPage."Bal. Account No.".ASSERTEQUALS(GenJournalBatch."Bal. Account No.");
        end else begin
            GenJournalPage."Bal. Account Type".SETVALUE(AccType::"G/L Account");
            GenJournalPage."Bal. Account No.".SETVALUE(GLAccount."No.");
        end;

        //Remove the lines
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        GenJournalPage.OK.INVOKE;
        //HEI.03
    end;

    [Test]
    [HandlerFunctions('MessageHandler,ConfirmationHandler')]
    procedure "RTR021-PostGenJournal"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        TestReport: Report "General Journal - Test";
        GenJnlLine: Record "Gen. Journal Line";
        Workflow: Record Workflow;
        RestrictedRecord: Record "Restricted Record";
    begin
        ClearVariables('RT_RTR001'); //HEI.16
        //HEI.03
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        //Check default value for Account No.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"G/L Account");
        GLAccount.GET(UnitTestingValues.Value);

        //Step 1: Login

        // Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error

        // Open Gen. Journal Batch page
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Step Create Journal Line
        GenJournalPage.NEW;

        GenJournalPage."Source Code".SETVALUE(GenJournalTemplate."Source Code");
        GenJournalPage."Posting Date".SETVALUE(WORKDATE);
        GenJournalPage."Account Type".SETVALUE(AccType::"G/L Account");
        GenJournalPage."Account No.".SETVALUE(GLAccount."No.");
        GenJournalPage.Description.SETVALUE('Unit Test RTR021');
        GenJournalPage.Amount.SETVALUE(1000);
        DocumentNo := GenJournalPage."Document No.".VALUE;
        if GenJournalBatch."Bal. Account No." <> '' then begin
            GenJournalPage."Bal. Account Type".ASSERTEQUALS(GenJournalBatch."Bal. Account Type");
            GenJournalPage."Bal. Account No.".ASSERTEQUALS(GenJournalBatch."Bal. Account No.");
        end else begin
            GenJournalPage."Bal. Account Type".SETVALUE(AccType::"G/L Account");
            GenJournalPage."Bal. Account No.".SETVALUE(GLAccount."No.");
        end;

        //Disable Workflows before Release
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            Workflow.SETRANGE(Enabled, true);
            if Workflow.FINDSET then
                repeat
                    Workflow.Enabled := false;
                    Workflow.MODIFY;
                until Workflow.NEXT = 0;
        end;

        //delete the record restrictions
        RestrictedRecord.RESET;
        if RestrictedRecord.FINDSET then
            RestrictedRecord.DELETEALL;

        GenJournalPage.Post.INVOKE;
        //HEI.03
    end;

    [Test]
    [HandlerFunctions('MessageHandler,DimensionSetEntriesModalPageHandler')]
    procedure "RTR022-DisplayApprovalEntries"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        TestReport: Report "General Journal - Test";
        GenJnlLine: Record "Gen. Journal Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
        WorkflowUserGroup: Record "Workflow User Group";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
    begin
        ClearVariables('RT_RTR001'); //HEI.16
        //HEI.03
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        MESSAGE(ApprovalDisabled);//HEI.40
        //Check default value for Account No.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"G/L Account");
        GLAccount.GET(UnitTestingValues.Value);

        //HEI.16>>
        GeneralLedgerSetup.GET;
        CCCDimensionValue.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        CCCDimensionValue.SETRANGE(Blocked, false);
        CCCDimensionValue.FINDFIRST;
        //HEI.16<<

        //Step 1: Login

        // Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error

        // Open Gen. Journal Batch page
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Step Create Journal Line
        GenJournalPage.NEW;

        GenJournalPage."Source Code".SETVALUE(GenJournalTemplate."Source Code");
        GenJournalPage."Posting Date".SETVALUE(WORKDATE);
        GenJournalPage."Account Type".SETVALUE(AccType::"G/L Account");
        GenJournalPage."Account No.".SETVALUE(GLAccount."No.");
        GenJournalPage.Description.SETVALUE('Unit Test RTR017');
        GenJournalPage.Amount.SETVALUE(1000);
        DocumentNo := GenJournalPage."Document No.".VALUE;
        if GenJournalBatch."Bal. Account No." <> '' then begin
            GenJournalPage."Bal. Account Type".ASSERTEQUALS(GenJournalBatch."Bal. Account Type");
            GenJournalPage."Bal. Account No.".ASSERTEQUALS(GenJournalBatch."Bal. Account No.");
        end else begin
            GenJournalPage."Bal. Account Type".SETVALUE(AccType::"G/L Account");
            GenJournalPage."Bal. Account No.".SETVALUE(GLAccount."No.");
        end;

        //HEI.16>>
        //Dimensions
        GenJournalPage.Dimensions.INVOKE;

        //Update Workflow User Groups
        UserSetup.FINDFIRST;

        if WorkflowUserGroup.FINDSET(false) then
            repeat
                WorkflowUserGroupMember.SETRANGE("Workflow User Group Code", WorkflowUserGroup.Code);
                WorkflowUserGroupMember.SETRANGE("Sequence No.", 2);
                if not WorkflowUserGroupMember.FINDFIRST then begin
                    WorkflowUserGroupMember.INIT;
                    WorkflowUserGroupMember."Workflow User Group Code" := WorkflowUserGroup.Code;
                    WorkflowUserGroupMember."User Name" := UserSetup."User ID";
                    WorkflowUserGroupMember.INSERT;
                end;
            until WorkflowUserGroup.NEXT = 0;
        //HEI.16<<

        //Send for approval
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            //HEI.16>>
            //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
            //WorkflowResponse.DELETE;
            //HEI.16<<
            GenJournalPage.SendApprovalRequestJournalBatch.INVOKE;

            // Open the page to see the requests
            ApprovalEntries.TRAP;
            GenJournalPage.Approvals.INVOKE;

        end else
            //HEI.16>>
            //ERROR('No approval workflow is enabled.');
            MESSAGE(ApprovalNotSentMsg);
        //HEI.16<<
        //HEI.03
    end;

    [Test]
    [HandlerFunctions('MessageHandler,DimensionSetEntriesModalPageHandler')]
    procedure "RTR023-ChangeValuePosting"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        TestReport: Report "General Journal - Test";
        GenJnlLine: Record "Gen. Journal Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
        WorkflowUserGroup: Record "Workflow User Group";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
    begin
        ClearVariables('RT_RTR001'); //HEI.16
        //HEI.04
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        MESSAGE(ApprovalDisabled);//HEI.40
        //Check default value for Account No.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"G/L Account");
        GLAccount.GET(UnitTestingValues.Value);

        //HEI.16>>
        GeneralLedgerSetup.GET;
        CCCDimensionValue.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        CCCDimensionValue.SETRANGE(Blocked, false);
        CCCDimensionValue.FINDFIRST;
        //HEI.16<<

        //Step 1: Login

        // Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error

        // Open Gen. Journal Batch page
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Step Create Journal Line
        GenJournalPage.NEW;

        GenJournalPage."Source Code".SETVALUE(GenJournalTemplate."Source Code");
        GenJournalPage."Posting Date".SETVALUE(WORKDATE);
        GenJournalPage."Account Type".SETVALUE(AccType::"G/L Account");
        GenJournalPage."Account No.".SETVALUE(GLAccount."No.");
        GenJournalPage.Description.SETVALUE('Unit Test RTR023 Updated');
        GenJournalPage.Amount.SETVALUE(1000);
        DocumentNo := GenJournalPage."Document No.".VALUE;
        if GenJournalBatch."Bal. Account No." <> '' then begin
            GenJournalPage."Bal. Account Type".ASSERTEQUALS(GenJournalBatch."Bal. Account Type");
            GenJournalPage."Bal. Account No.".ASSERTEQUALS(GenJournalBatch."Bal. Account No.");
        end else begin
            GenJournalPage."Bal. Account Type".SETVALUE(AccType::"G/L Account");
            GenJournalPage."Bal. Account No.".SETVALUE(GLAccount."No.");
        end;

        //HEI.16>>
        //Dimensions
        GenJournalPage.Dimensions.INVOKE;

        //Update Workflow User Groups
        UserSetup.FINDFIRST;

        if WorkflowUserGroup.FINDSET(false) then
            repeat
                WorkflowUserGroupMember.SETRANGE("Workflow User Group Code", WorkflowUserGroup.Code);
                WorkflowUserGroupMember.SETRANGE("Sequence No.", 2);
                if not WorkflowUserGroupMember.FINDFIRST then begin
                    WorkflowUserGroupMember.INIT;
                    WorkflowUserGroupMember."Workflow User Group Code" := WorkflowUserGroup.Code;
                    WorkflowUserGroupMember."User Name" := UserSetup."User ID";
                    WorkflowUserGroupMember.INSERT;
                end;
            until WorkflowUserGroup.NEXT = 0;
        //HEI.16<<

        //Send for approval
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            //HEI.16>>
            //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
            //WorkflowResponse.DELETE;
            //HEI.16<<
            GenJournalPage.SendApprovalRequestJournalBatch.INVOKE;

            // Open the page to see the requests
            ApprovalEntries.TRAP;
            GenJournalPage.Approvals.INVOKE;

        end else
            //HEI.16>>
            //ERROR('No approval workflow is enabled.');
            MESSAGE(ApprovalNotSentMsg);
        //HEI.16<<

        GenJournalPage.CLOSE;
        //HEI.04
    end;

    [Test]
    [HandlerFunctions('MessageHandler,DimensionSetEntriesModalPageHandler')]
    procedure "RTR024-DeleteBatch"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        TestReport: Report "General Journal - Test";
        GenJnlLine: Record "Gen. Journal Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
        WorkflowUserGroup: Record "Workflow User Group";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
    begin
        ClearVariables('RT_RTR001'); //HEI.16
        //HEI.04
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        MESSAGE(ApprovalDisabled);//HEI.40
        //Check default value for Account No.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"G/L Account");
        GLAccount.GET(UnitTestingValues.Value);

        //HEI.16>>
        GeneralLedgerSetup.GET;
        CCCDimensionValue.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        CCCDimensionValue.SETRANGE(Blocked, false);
        CCCDimensionValue.FINDFIRST;
        //HEI.16<<

        //Step 1: Login

        // Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error

        // Open Gen. Journal Batch page
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Step Create Journal Line
        GenJournalPage.NEW;

        GenJournalPage."Source Code".SETVALUE(GenJournalTemplate."Source Code");
        GenJournalPage."Posting Date".SETVALUE(WORKDATE);
        GenJournalPage."Account Type".SETVALUE(AccType::"G/L Account");
        GenJournalPage."Account No.".SETVALUE(GLAccount."No.");
        GenJournalPage.Description.SETVALUE('Unit Test RTR024');
        GenJournalPage.Amount.SETVALUE(1000);
        DocumentNo := GenJournalPage."Document No.".VALUE;
        if GenJournalBatch."Bal. Account No." <> '' then begin
            GenJournalPage."Bal. Account Type".ASSERTEQUALS(GenJournalBatch."Bal. Account Type");
            GenJournalPage."Bal. Account No.".ASSERTEQUALS(GenJournalBatch."Bal. Account No.");
        end else begin
            GenJournalPage."Bal. Account Type".SETVALUE(AccType::"G/L Account");
            GenJournalPage."Bal. Account No.".SETVALUE(GLAccount."No.");
        end;

        //HEI.16>>
        //Dimensions
        GenJournalPage.Dimensions.INVOKE;

        //Update Workflow User Groups
        UserSetup.FINDFIRST;

        if WorkflowUserGroup.FINDSET(false) then
            repeat
                WorkflowUserGroupMember.SETRANGE("Workflow User Group Code", WorkflowUserGroup.Code);
                WorkflowUserGroupMember.SETRANGE("Sequence No.", 2);
                if not WorkflowUserGroupMember.FINDFIRST then begin
                    WorkflowUserGroupMember.INIT;
                    WorkflowUserGroupMember."Workflow User Group Code" := WorkflowUserGroup.Code;
                    WorkflowUserGroupMember."User Name" := UserSetup."User ID";
                    WorkflowUserGroupMember.INSERT;
                end;
            until WorkflowUserGroup.NEXT = 0;
        //HEI.16<<

        //Send for approval
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            //HEI.16>>
            //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
            //WorkflowResponse.DELETE;
            //HEI.6<<

            GenJournalPage.SendApprovalRequestJournalBatch.INVOKE;

            //Cancel the approval request
            GenJournalPage.CancelApprovalRequestJournalBatch.INVOKE;
        end else
            //HEI.16>>
            //ERROR('No approval workflow is enabled.');
            MESSAGE(ApprovalNotSentMsg);
        //HEI.16<<

        //Delete the lines
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //confirm with OK is done using the ConfirmationHandler function

        GenJournalPage.CLOSE;
        //HEI.04
    end;

    [Test]
    [HandlerFunctions('GLRegistersRequestPage')]
    procedure "RTR025-PrintGLRegisters"();
    var
        GLRegisters: TestPage "G/L Registers";
        GLRegisterReport: Report "G/L Register";
        GLRegister: Record "G/L Register";
        GLRegister2: Record "G/L Register";
    begin
        //HEI.04
        //Display G/L Registers list
        GLRegisters.OPENVIEW;

        GLRegisterReport.RUN;
        //HEI.04
    end;

    [Test]
    [HandlerFunctions('DimSetEntriesModalPageHandler')]
    procedure "RTR026-GLRegisterDimensions"();
    var
        GLRegisters: TestPage "G/L Registers";
        GenLedgerEntries: TestPage "General Ledger Entries";
        DimSetEntries: TestPage "Dimension Set Entries";
    begin
        //HEI.04
        //Display G/L Registers list
        GLRegisters.OPENVIEW;

        //Open General ledger
        if GLRegisters.FIRST then begin
            GenLedgerEntries.TRAP;
            //GLRegisters."Codeunit G / L Reg.- Gen.Ledger".INVOKE;  //BC Upgrade KAPOOV01 Commented to resolved compilation error
            GLRegisters."General Ledger".INVOKE; //BC Upgrade KAPOOV01 added to resolved compilation error

            //Select dimenions - Page is handled by function DimSetEntriesModalPageHandler
            //GenLedgerEntries.Action49.INVOKE; //BC Upgrade KAPOOV01
            GenLedgerEntries.Dimensions.INVOKE; //BC Upgrade KAPOOV01
        end;
        //HEI.04
    end;

    [Test]
    [HandlerFunctions('MessageHandler')]
    procedure "RTR027-EnterRecurringEntries"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        RecurringGenJournal: TestPage "Recurring General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        TestReport: Report "General Journal - Test";
        GenJnlLine: Record "Gen. Journal Line";
        ExpDate: Text;
        WorkflowUserGroup: Record "Workflow User Group";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
    begin
        ClearVariables('RT_RTR001'); //HEI.16
        //HEI.04
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR027', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR027', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        //Check default value for Account No.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR027', COMPANYNAME, DATABASE::"G/L Account");
        GLAccount.GET(UnitTestingValues.Value);

        //Step 1: Login

        // Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        GeneralJournalTemplates.Blocked.SETVALUE(0);//HEI.78
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error

        // Open Gen. Journal Batch page
        RecurringGenJournal.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Step Create Journal Line
        RecurringGenJournal.NEW;

        RecurringGenJournal."Recurring Method".SETVALUE(1);
        RecurringGenJournal."Recurring Frequency".SETVALUE('1M');
        RecurringGenJournal."Posting Date".SETVALUE(WORKDATE);
        RecurringGenJournal."Account Type".SETVALUE(AccType::"G/L Account");
        RecurringGenJournal."Account No.".SETVALUE(GLAccount."No.");
        RecurringGenJournal.Description.SETVALUE('Unit Test RTR027');
        RecurringGenJournal.Amount.SETVALUE(1000);
        RecurringGenJournal."Expiration Date".SETVALUE(WORKDATE);
        DocumentNo := RecurringGenJournal."Document No.".VALUE;
        if DocumentNo = '' then
            RecurringGenJournal."Document No.".SETVALUE('Test 1');
        ExpDate := RecurringGenJournal."Expiration Date".VALUE;
        //HEI.16>>
        //IF ExpDate = '' THEN
        //ERROR('Expiration Date cannot be empty.');
        //HEI.16<<

        //Select "Allocations" from "Home" menu for selecting second posting line - handled by function "AllocationsModalPageHandler"
        //RecurringGenJournal."Page Allocations".INVOKE; //BC Upgrade KAPOOV01
        RecurringGenJournal.Allocations.INVOKE; //BC Upgrade KAPOOV01

        //Preview the posting
        //RecurringGenJournal.Preview.INVOKE;

        //HEI.16>>
        //Update Workflow User Groups
        UserSetup.FINDFIRST;

        if WorkflowUserGroup.FINDSET(false) then
            repeat
                WorkflowUserGroupMember.SETRANGE("Workflow User Group Code", WorkflowUserGroup.Code);
                WorkflowUserGroupMember.SETRANGE("Sequence No.", 2);
                if not WorkflowUserGroupMember.FINDFIRST then begin
                    WorkflowUserGroupMember.INIT;
                    WorkflowUserGroupMember."Workflow User Group Code" := WorkflowUserGroup.Code;
                    WorkflowUserGroupMember."User Name" := UserSetup."User ID";
                    WorkflowUserGroupMember.INSERT;
                end;
            until WorkflowUserGroup.NEXT = 0;
        //HEI.16<<

        //Send for approval
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            //HEI.16>>
            //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
            //WorkflowResponse.DELETE;
            //HEI.16<<
            RecurringGenJournal.SendApprovalRequestJournalBatch.INVOKE;
        end else
            //HEI.16>>
            //ERROR('No approval workflow is enabled.');
            MESSAGE(ApprovalNotSentMsg);
        //HEI.16<<

        MESSAGE('%1', GETLASTERRORTEXT);//HEI.82

        RecurringGenJournal.CLOSE;
        //HEI.04
    end;

    [Test]
    procedure "RTR028-EnterRecurringEntriesBlankExpirationDate"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        RecurringGenJournal: TestPage "Recurring General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        TestReport: Report "General Journal - Test";
        GenJnlLine: Record "Gen. Journal Line";
        ExpDate: Text;
        Error01: Label 'The expiration date cannot be zero or empty.';
        Allocations: TestPage "Allocations";
        GenJnlAllocation: Record "Gen. Jnl. Allocation";
    begin
        ClearVariables('RRTR027'); //HEI.16
        //HEI.04
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR027', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR027', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        //Check default value for Account No.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR027', COMPANYNAME, DATABASE::"G/L Account");
        GLAccount.GET(UnitTestingValues.Value);

        //Step 1: Login

        // Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error

        // Open Gen. Journal Batch page
        RecurringGenJournal.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Step Create Journal Line
        RecurringGenJournal.NEW;

        RecurringGenJournal."Recurring Method".SETVALUE(1);
        RecurringGenJournal."Recurring Frequency".SETVALUE('1M');
        RecurringGenJournal."Posting Date".SETVALUE(WORKDATE);
        RecurringGenJournal."Account Type".SETVALUE(AccType::"G/L Account");
        RecurringGenJournal."Account No.".SETVALUE(GLAccount."No.");
        RecurringGenJournal.Description.SETVALUE('Unit Test RTR027');
        RecurringGenJournal.Amount.SETVALUE(1000);
        DocumentNo := RecurringGenJournal."Document No.".VALUE;
        if DocumentNo = '' then
            RecurringGenJournal."Document No.".SETVALUE('Test 1');
        RecurringGenJournal."Expiration Date".SETVALUE('');

        //Select "Allocations" from "Home" menu for selecting second posting line - handled by function "AllocationsModalPageHandler"
        //RecurringGenJournal."Page Allocations".INVOKE; //BC Upgrade KAPOOV01
        RecurringGenJournal.Allocations.INVOKE; //BC Upgrade KAPOOV01

        //Preview the posting
        //HEI.16>>
        //IF RecurringGenJournal."Expiration Date".VALUE = '' THEN
        //ERROR('Expiration date cannot be blank.');

        //Commented as gives error 'C/AL functions are limited..'
        //RecurringGenJournal.Preview.INVOKE;

        RecurringGenJournal."Expiration Date".ASSERTEQUALS('');
        //HEI.16<<

        RecurringGenJournal.CLOSE;
        //HEI.04
    end;

    [Test]
    //[HandlerFunctions('MessageHandler,TestReportReportHandler')]
    [HandlerFunctions('MessageHandler')] //BC Upgrade KAPOOV01 Removed ReportHandler- TestReportReportHandler
    procedure "RTR029-ApproveRecurringPosting"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        TestReport: Report "General Journal - Test";
        GenJnlLine: Record "Gen. Journal Line";
        RecurringGenJournal: TestPage "Recurring General Journal";
        ExpDate: Text;
        WorkflowUserGroup: Record "Workflow User Group";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
    begin
        ClearVariables('RRTR027'); //HEI.16
        //HEI.04
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR027', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR027', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        //Check default value for Account No.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR027', COMPANYNAME, DATABASE::"G/L Account");
        GLAccount.GET(UnitTestingValues.Value);

        //Step 1: Login

        // Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        GeneralJournalTemplates.Blocked.SETVALUE(0);//HEI.78
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE;  //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE; //BC Upgrade KAPOOV01 added to resolved compilation error

        // Open Gen. Journal Batch page
        RecurringGenJournal.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Step Create Journal Line
        RecurringGenJournal.NEW;

        RecurringGenJournal."Recurring Method".SETVALUE(1);
        RecurringGenJournal."Recurring Frequency".SETVALUE('1M');
        RecurringGenJournal."Posting Date".SETVALUE(WORKDATE);
        RecurringGenJournal."Account Type".SETVALUE(AccType::"G/L Account");
        RecurringGenJournal."Account No.".SETVALUE(GLAccount."No.");
        RecurringGenJournal.Description.SETVALUE('Unit Test RTR027');
        RecurringGenJournal.Amount.SETVALUE(1000);
        DocumentNo := RecurringGenJournal."Document No.".VALUE;
        RecurringGenJournal."Expiration Date".SETVALUE(WORKDATE);
        if DocumentNo = '' then
            RecurringGenJournal."Document No.".SETVALUE('Test 1');
        ExpDate := RecurringGenJournal."Expiration Date".VALUE;
        //HEI.16>>
        //IF ExpDate = '' THEN
        //ERROR('Expiration Date cannot be empty.');

        //Update Workflow User Groups
        UserSetup.FINDFIRST;

        if WorkflowUserGroup.FINDSET(false) then
            repeat
                WorkflowUserGroupMember.SETRANGE("Workflow User Group Code", WorkflowUserGroup.Code);
                WorkflowUserGroupMember.SETRANGE("Sequence No.", 2);
                if not WorkflowUserGroupMember.FINDFIRST then begin
                    WorkflowUserGroupMember.INIT;
                    WorkflowUserGroupMember."Workflow User Group Code" := WorkflowUserGroup.Code;
                    WorkflowUserGroupMember."User Name" := UserSetup."User ID";
                    WorkflowUserGroupMember.INSERT;
                end;
            until WorkflowUserGroup.NEXT = 0;
        //HEI.16<<

        //Send for approval
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            //HEI.16>>
            //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
            //WorkflowResponse.DELETE;
            //HEI.16<<
            RecurringGenJournal.SendApprovalRequestJournalBatch.INVOKE;

            //Check if the posting batch was created and submitted for approval - Open the page to see the requests
            ApprovalEntries.TRAP;
            RecurringGenJournal.Approvals.INVOKE;

            //Update Substitute for Approver ID = USERID
            ApprovalEntries.FILTER.SETFILTER(Status, 'Open');
            if UserSetup.GET(ApprovalEntries."Approver ID".VALUE) then begin
                UserSetup.Substitute := USERID;
                UserSetup.MODIFY;
            end;

            //Delegate Approval Request
            //ApprovalEntries.Action35.INVOKE;

            //Go to record - this will open the Page Gen. Journal(handled by function GenJnlPageHandler)
            //ApprovalEntries.Action38.INVOKE; //BC Upgrade KAPOOV01
            ApprovalEntries.Record.INVOKE; //BC Upgrade KAPOOV01

            // Generate the "Test Report" (handled by function TestReportRequestTestPage)
            GenJnlLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
            GenJnlLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
            GenJournalTemplate.TESTFIELD("Test Report ID");
            REPORT.RUN(GenJournalTemplate."Test Report ID", false, false, GenJnlLine);

            //Approve Approval Entry
            if RecurringGenJournal.Approve.ENABLED then
                RecurringGenJournal.Approve.INVOKE;

            //Step 7 - Send an email to initiator of transaction (RtR Administrator) with approval of the posting
            //this is automatically sent using the workflow

        end else
            //HEI.16>>
            //ERROR('No approval workflow is enabled.');
            MESSAGE(ApprovalNotSentMsg);
        //HEI.16<<
        //HEI.04
        MESSAGE('%1', GETLASTERRORTEXT);//HEI.82
    end;

    [Test]
    //[HandlerFunctions('MessageHandler,TestReportReportHandler')]
    [HandlerFunctions('MessageHandler')] //BC Upgrade KAPOOV01 Removed ReportHandler- TestReportReportHandler
    procedure "RTR032-RejectRecurringPosting"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        TestReport: Report "General Journal - Test";
        GenJnlLine: Record "Gen. Journal Line";
        RecurringGenJournal: TestPage "Recurring General Journal";
        ExpDate: Text;
        WorkflowUserGroup: Record "Workflow User Group";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
    begin
        ClearVariables('RRTR027'); //HEI.16
        //HEI.04
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR027', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR027', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        //Check default value for Account No.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR027', COMPANYNAME, DATABASE::"G/L Account");
        GLAccount.GET(UnitTestingValues.Value);

        //Step 1: Login

        // Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        GeneralJournalTemplates.Blocked.SETVALUE(0);//HEI.78
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error

        // Open Gen. Journal Batch page
        RecurringGenJournal.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Step Create Journal Line
        RecurringGenJournal.NEW;

        RecurringGenJournal."Recurring Method".SETVALUE(1);
        RecurringGenJournal."Recurring Frequency".SETVALUE('1M');
        RecurringGenJournal."Posting Date".SETVALUE(WORKDATE);
        RecurringGenJournal."Account Type".SETVALUE(AccType::"G/L Account");
        RecurringGenJournal."Account No.".SETVALUE(GLAccount."No.");
        RecurringGenJournal.Description.SETVALUE('Unit Test RTR027');
        RecurringGenJournal.Amount.SETVALUE(1000);
        DocumentNo := RecurringGenJournal."Document No.".VALUE;
        RecurringGenJournal."Expiration Date".SETVALUE(WORKDATE);
        if DocumentNo = '' then
            RecurringGenJournal."Document No.".SETVALUE('Test 1');
        ExpDate := RecurringGenJournal."Expiration Date".VALUE;
        //HEI.16>>
        //IF ExpDate = '' THEN
        //ERROR('Expiration Date cannot be empty.');

        //Update Workflow User Groups
        UserSetup.FINDFIRST;

        if WorkflowUserGroup.FINDSET(false) then
            repeat
                WorkflowUserGroupMember.SETRANGE("Workflow User Group Code", WorkflowUserGroup.Code);
                WorkflowUserGroupMember.SETRANGE("Sequence No.", 2);
                if not WorkflowUserGroupMember.FINDFIRST then begin
                    WorkflowUserGroupMember.INIT;
                    WorkflowUserGroupMember."Workflow User Group Code" := WorkflowUserGroup.Code;
                    WorkflowUserGroupMember."User Name" := UserSetup."User ID";
                    WorkflowUserGroupMember.INSERT;
                end;
            until WorkflowUserGroup.NEXT = 0;
        //HEI.16<<

        //Send for approval
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            //HEI.16>>
            //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
            //WorkflowResponse.DELETE;
            //HEI.16<<
            RecurringGenJournal.SendApprovalRequestJournalBatch.INVOKE;

            //Check if the posting batch was created and submitted for approval - Open the page to see the requests
            ApprovalEntries.TRAP;
            RecurringGenJournal.Approvals.INVOKE;

            //Update Substitute for Approver ID = USERID
            ApprovalEntries.FILTER.SETFILTER(Status, 'Open');
            if UserSetup.GET(ApprovalEntries."Approver ID".VALUE) then begin
                UserSetup.Substitute := USERID;
                UserSetup.MODIFY;
            end;

            //Delegate Approval Request
            //ApprovalEntries.Action35.INVOKE;

            //Go to record - this will open the Page Gen. Journal(handled by function GenJnlPageHandler)
            //ApprovalEntries.Action38.INVOKE; //BC Upgrade KAPOOV01
            ApprovalEntries.Record.INVOKE; //BC Upgrade KAPOOV01

            // Generate the "Test Report" (handled by function TestReportRequestTestPage)
            GenJnlLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
            GenJnlLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
            GenJournalTemplate.TESTFIELD("Test Report ID");
            REPORT.RUN(GenJournalTemplate."Test Report ID", false, false, GenJnlLine);

            //Reject Approval Entry
            if RecurringGenJournal.Reject.ENABLED then
                RecurringGenJournal.Reject.INVOKE;

            //Step 7 - Send an email to initiator of transaction (RtR Administrator) with approval of the posting
            //this is automatically sent using the workflow

        end else
            //HEI.16>>
            //ERROR('No approval workflow is enabled.');
            MESSAGE(ApprovalNotSentMsg);
        //HEI.16<<
        //HEI.04
        MESSAGE('%1', GETLASTERRORTEXT);//HEI.82
    end;

    [Test]
    //[HandlerFunctions('MessageHandler,TestReportReportHandler')]
    [HandlerFunctions('MessageHandler')] //BC Upgrade KAPOOV01 Removed ReportHandler- TestReportReportHandler
    procedure "RTR033-ChangeRecurringPosting"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        TestReport: Report "General Journal - Test";
        GenJnlLine: Record "Gen. Journal Line";
        RecurringGenJournal: TestPage "Recurring General Journal";
        ExpDate: Text;
        WorkflowUserGroup: Record "Workflow User Group";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
    begin
        ClearVariables('RTR027'); //HEI.16
        //HEI.04
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR027', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR027', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        //Check default value for Account No.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR027', COMPANYNAME, DATABASE::"G/L Account");
        GLAccount.GET(UnitTestingValues.Value);

        //Step 1: Login

        // Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        GeneralJournalTemplates.Blocked.SETVALUE(0);//HEI.78
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error

        // Open Gen. Journal Batch page
        RecurringGenJournal.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Step Create Journal Line
        RecurringGenJournal.NEW;

        RecurringGenJournal."Recurring Method".SETVALUE(1);
        RecurringGenJournal."Recurring Frequency".SETVALUE('1M');
        RecurringGenJournal."Posting Date".SETVALUE(WORKDATE);
        RecurringGenJournal."Account Type".SETVALUE(AccType::"G/L Account");
        RecurringGenJournal."Account No.".SETVALUE(GLAccount."No.");
        RecurringGenJournal.Description.SETVALUE('Unit Test RTR033 Updated');
        RecurringGenJournal.Amount.SETVALUE(1000);
        DocumentNo := RecurringGenJournal."Document No.".VALUE;
        RecurringGenJournal."Expiration Date".SETVALUE(WORKDATE);
        if DocumentNo = '' then
            RecurringGenJournal."Document No.".SETVALUE('Test 1');
        ExpDate := RecurringGenJournal."Expiration Date".VALUE;
        //HEI.16>>
        //IF ExpDate = '' THEN
        //ERROR('Expiration Date cannot be empty.');

        //Update Workflow User Groups
        UserSetup.FINDFIRST;

        if WorkflowUserGroup.FINDSET(false) then
            repeat
                WorkflowUserGroupMember.SETRANGE("Workflow User Group Code", WorkflowUserGroup.Code);
                WorkflowUserGroupMember.SETRANGE("Sequence No.", 2);
                if not WorkflowUserGroupMember.FINDFIRST then begin
                    WorkflowUserGroupMember.INIT;
                    WorkflowUserGroupMember."Workflow User Group Code" := WorkflowUserGroup.Code;
                    WorkflowUserGroupMember."User Name" := UserSetup."User ID";
                    WorkflowUserGroupMember.INSERT;
                end;
            until WorkflowUserGroup.NEXT = 0;
        //HEI.16<<

        //Send for approval
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            //HEI.16>>
            //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
            //WorkflowResponse.DELETE;
            //HEI.16<<
            RecurringGenJournal.SendApprovalRequestJournalBatch.INVOKE;

            //Check if the posting batch was created and submitted for approval - Open the page to see the requests
            ApprovalEntries.TRAP;
            RecurringGenJournal.Approvals.INVOKE;

            //Update Substitute for Approver ID = USERID
            ApprovalEntries.FILTER.SETFILTER(Status, 'Open');
            if UserSetup.GET(ApprovalEntries."Approver ID".VALUE) then begin
                UserSetup.Substitute := USERID;
                UserSetup.MODIFY;
            end;

            //Go to record - this will open the Page Gen. Journal(handled by function GenJnlPageHandler)
            //ApprovalEntries.Action38.INVOKE; //BC Upgrade KAPOOV01
            ApprovalEntries.Record.INVOKE; //BC Upgrade KAPOOV01

            // Generate the "Test Report" (handled by function TestReportRequestTestPage)
            GenJnlLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
            GenJnlLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
            GenJournalTemplate.TESTFIELD("Test Report ID");
            REPORT.RUN(GenJournalTemplate."Test Report ID", false, false, GenJnlLine);

            //Reject Approval Entry
            if RecurringGenJournal.Reject.ENABLED then
                RecurringGenJournal.Reject.INVOKE;

            //Step 7 - Send an email to initiator of transaction (RtR Administrator) with approval of the posting
            //this is automatically sent using the workflow
            //HEI.16>>
            //END;
        end else
            MESSAGE(ApprovalNotSentMsg);
        //HEI.16<<
        //HEI.04
        MESSAGE('%1', GETLASTERRORTEXT);//HEI.82
    end;

    [Test]
    //[HandlerFunctions('ReverseEntryPageHandler')] //BC Upgrade KAPOOV01 commented procedure ReverseEntryPageHandler-Page "Reversal Entry" removed in BC 
    procedure "RTR035-AutomaticReversalofGLposting"();
    var
        GLRegisters: TestPage "G/L Registers";
        GLRegisterReport: Report "G/L Register";
        GlAcc: Record "G/L Account";
        GLRegisterNo: Integer;
        GLRegister: Record "G/L Register";
        ReversalEntry_G: Record "Reversal Entry";
        lGLEntry: Record "G/L Entry";
    begin
        //HEI.05
        //Display G/L Registers list
        GLRegisters.OPENVIEW;
        GLRegister.SETASCENDING("No.", false);//HEI.79
        GLRegister.SETRANGE(Reversed, false);
        GLRegister.SETFILTER("Journal Batch Name", '<>%1', '');
        GLRegister.SETFILTER("Source Code", '=%1', 'GENJNL');
        //GLRegister.FINDLAST;//HEI.79 Commented
        //HEI.79>>
        if GLRegister.FINDSET(false) then
            repeat
                lGLEntry.SETRANGE("Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");
                //lGLEntry.SETFILTER(Letter, '<>%1', ''); //BC Upgrade KAPOOV01 French Localization
                if not lGLEntry.FINDFIRST then begin
                    GLRegisterNo := GLRegister."No.";
                    break;
                end;
            until GLRegister.NEXT = 0;
        //HEI.79<<
        //GLRegisterNo := GLRegister."No.";//HEI.79 Commented
        GLRegisters.GOTORECORD(GLRegister);
        GLRegisters.ReverseRegister.INVOKE;
        //HEI.05
    end;

    [Test]
    [HandlerFunctions('MessageHandler,DimensionSetEntriesModalPageHandler')]
    procedure "RTR036-ManualGLReversalOpenPeriod"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        Balance: Decimal;
        Amt: Decimal;
        DefaultDim: Record "Default Dimension";
        DimSetEntry: Record "Dimension Set Entry";
        WorkflowUserGroup: Record "Workflow User Group";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
        UserSetup: Record "User Setup";
    begin
        ClearVariables('RT_RTR001'); //HEI.16
        //HEI.12
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        MESSAGE(ApprovalDisabled);//HEI.40
        //Check default value for Account No.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"G/L Account");
        GLAccount.GET(UnitTestingValues.Value);

        //HEI.16>>
        GeneralLedgerSetup.GET;
        CCCDimensionValue.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        CCCDimensionValue.SETRANGE(Blocked, false);
        CCCDimensionValue.FINDFIRST;
        //HEI.16<<

        //Step 1: Login

        // Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error

        // Open Gen. Journal Batch page
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Step 6- Create Journal Line
        GenJournalPage.NEW;

        GenJournalPage."Source Code".SETVALUE(GenJournalTemplate."Source Code");
        GenJournalPage."Posting Date".SETVALUE(WORKDATE);
        GenJournalPage."Account Type".SETVALUE(AccType::"G/L Account");
        GenJournalPage."Account No.".SETVALUE(GLAccount."No.");
        GenJournalPage.Description.SETVALUE('Unit Test RTR036');
        GenJournalPage.Amount.SETVALUE(-1000);
        DocumentNo := GenJournalPage."Document No.".VALUE;

        if GenJournalBatch."Bal. Account No." <> '' then begin
            //Bal Account Type (auto - template)
            GenJournalPage."Bal. Account Type".ASSERTEQUALS(GenJournalBatch."Bal. Account Type");
            //Bal Account No (auto - template)
            GenJournalPage."Bal. Account No.".ASSERTEQUALS(GenJournalBatch."Bal. Account No.");
        end else begin
            GenJournalPage."Bal. Account Type".SETVALUE(AccType::"G/L Account");
            GenJournalPage."Bal. Account No.".SETVALUE(GLAccount."No.");
        end;

        //HEI.16>>
        //Dimensions
        GenJournalPage.Dimensions.INVOKE;

        //Update Workflow User Groups
        UserSetup.FINDFIRST;

        if WorkflowUserGroup.FINDSET(false) then
            repeat
                WorkflowUserGroupMember.SETRANGE("Workflow User Group Code", WorkflowUserGroup.Code);
                WorkflowUserGroupMember.SETRANGE("Sequence No.", 2);
                if not WorkflowUserGroupMember.FINDFIRST then begin
                    WorkflowUserGroupMember.INIT;
                    WorkflowUserGroupMember."Workflow User Group Code" := WorkflowUserGroup.Code;
                    WorkflowUserGroupMember."User Name" := UserSetup."User ID";
                    WorkflowUserGroupMember.INSERT;
                end;
            until WorkflowUserGroup.NEXT = 0;
        //HEI.16<<

        //Step 7 - Preview Posting
        //GenJournalPage.Preview.INVOKE;
        //Replace Preview posting done for a final check with manual checks because the Preview action is not found

        //Check the doc. No.
        if DocumentNo = '' then
            ERROR('Document No. is blank.');

        //Check the balance
        EVALUATE(Balance, GenJournalPage.Balance.VALUE);
        if Balance <> 0 then
            ERROR('Document %1 is out of balance.', DocumentNo);

        //Check the Amount
        EVALUATE(Amt, GenJournalPage.Amount.VALUE);
        if Amt = 0 then
            ERROR('The amount of Document %1 is blank.', DocumentNo);

        //Check mandatory dimenions
        DefaultDim.RESET;
        DefaultDim.SETRANGE("Table ID", 15);
        DefaultDim.SETRANGE("No.", GLAccount."No.");
        DefaultDim.SETRANGE("Value Posting", DefaultDim."Value Posting"::"Code Mandatory");
        if DefaultDim.FINDSET then
            repeat
                DimSetEntry.RESET;
                if not DimSetEntry.GET(GenJournalPage."Dimension Set ID".VALUE, DefaultDim."Dimension Code") then
                    ERROR('Dimension code %1 is missing for Document No. %2', DefaultDim."Dimension Code", DocumentNo);
            until DefaultDim.NEXT = 0;

        //STep 8 + 9- Attach a supporting document to MJE by navigating to "Incoming document" and selecting "Create incoming document from file" - SKIP this step because of error compilation
        //GenJournalPage.IncomingDocAttachFile.INVOKE;

        //Step 10 - Send for approval
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            //HEI.16>>
            //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
            //WorkflowResponse.DELETE;
            //HEI.16<<
            GenJournalPage.SendApprovalRequestJournalBatch.INVOKE;
        end else
            //HEI.16>>
            //ERROR('No approval workflow is enabled.');
            MESSAGE(ApprovalNotSentMsg);
        //HEI.16<<

        //Step 11 - Check if the posting batch was created and submitted for approval - Open the page to see the requests
        ApprovalEntries.TRAP;
        GenJournalPage.Approvals.INVOKE;

        //HEI.01
    end;

    [Test]
    [HandlerFunctions('MonthEndSalesCutOffRequestPageHandler')]
    procedure "RTR041-MonthEndSalesCutOff"();
    var
        MonthEndSalesCutoff: Report "Month End Sales Cut off CBN";
    begin
        //HEI.02
        //Open request page using function ReportHandler
        MonthEndSalesCutoff.RUN;
        //HEI.02
    end;

    [Test]
    [HandlerFunctions('MessageHandler,DimensionSetEntriesModalPageHandler')]
    procedure "RTR069-ImportPayrollFile"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        ImportPayroll: Report "Import Payroll";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        GeneralLedgerSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        WorkflowUserGroup: Record "Workflow User Group";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
        InStr: InStream; //BC Upgrade KAPOOV01
    begin
        ClearVariables('RT_RTR001'); //HEI.16
        //HEI.12
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);
        //HEI.31>>

        MESSAGE(ApprovalDisabled);//HEI.40
        //Remove existing lines in Journal to avoid errors
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //HEI.31<<


        //HEI.16>>
        GeneralLedgerSetup.GET;
        CCCDimensionValue.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        CCCDimensionValue.SETRANGE(Blocked, false);
        CCCDimensionValue.FINDFIRST;
        //HEI.16<<

        // Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error

        // Open Gen. Journal Batch page
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Import Payroll
        //GenJournalPage.ImportPayroll.INVOKE;

        //FileName := FileMgt.UploadFile(Text001,ExcelFileExtensionTok); HEI.15 commented
        //FileName := FileMgt.UploadFileSilent(PayrollFileNameTxt); //HEI.15  //BC Upgrade KAPOOV01 Blocked FileMgt functionality  

        //ImportPayroll.GetExcelSheet(FileName,'Payroll'); //HEI.15 commmented
        //HEI.31>>
        //ImportPayroll.GetExcelSheet(FileName,PayrollSheetNameTxt); //HEI.15
        //ExcelBuf.OpenBook(FileName, PayrollSheetNameTxt); //BC Upgrade KAPOOV01 Blocked OpenBook 
        //ExcelBuf.OpenBookStream(InStr, PayrollSheetNameTxt); //BC Upgrade KAPOOV01 replaced OpenBook with OpenBookStream.//Bc upgrade YADAVM09<<
        //ExcelBuf.ReadSheet;//Bc upgrade YADAVM09<<
        //ImportPayroll.ReadExcelSheet;
        //HEI.31<<
        //ImportPayroll.AnalyzeData;//Bc upgrade YADAVM09<<
        //Bc upgrade YADAVM09>>
        GenJournalPage.NEW;
        GenJournalPage."Posting Date".SETVALUE(WORKDATE);
        GenJournalPage."Document No.".SetValue('PAIE 6/2020');
        GenJournalPage."Account No.".SETVALUE('11103001');
        GenJournalPage.Description.SETVALUE('OD PAIE');
        GenJournalPage.Amount.SETVALUE(1000);
        //Bc Upgrade YADAVM09<<
        //HEI.16>>
        //Dimensions

        GenJournalPage.Dimensions.INVOKE;

        //Update Workflow User Groups
        UserSetup.FINDFIRST;

        if WorkflowUserGroup.FINDSET() then
            repeat
                WorkflowUserGroupMember.SETRANGE("Workflow User Group Code", WorkflowUserGroup.Code);
                WorkflowUserGroupMember.SETRANGE("Sequence No.", 2);
                if not WorkflowUserGroupMember.FINDFIRST then begin
                    WorkflowUserGroupMember.INIT;
                    WorkflowUserGroupMember."Workflow User Group Code" := WorkflowUserGroup.Code;
                    WorkflowUserGroupMember."User Name" := UserSetup."User ID";
                    WorkflowUserGroupMember.INSERT;
                end;
            until WorkflowUserGroup.NEXT = 0;
        //HEI.16<<

        //Send for approval
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            //HEI.16>>
            //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
            //WorkflowResponse.DELETE;
            //HEI.16<<
            GenJournalPage.SendApprovalRequestJournalBatch.INVOKE;
            //HEI.16>>
            //END;
        end else
            MESSAGE(ApprovalNotSentMsg);
        //HEI.16<<

        //Check if the posting batch was created and submitted for approval - Open the page to see the requests
        ApprovalEntries.TRAP;
        GenJournalPage.Approvals.INVOKE;

        //HEI.12<<
    end;

    [Test]
    [HandlerFunctions('MessageHandler')]
    procedure "RTR070-ImportPayrollFileWrongData"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        ImportPayroll: Report "Import Payroll";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        GeneralLedgerSetup: Record "General Ledger Setup";
        WorkflowUserGroup: Record "Workflow User Group";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
        WrongCCCValueErr: Label 'The field Ccc Code of table Gen. Journal Line contains a value (10001) that cannot be found in the related table (Dimension Value).';
        InStr: InStream; //BC Upgrade KAPOOV01
    begin
        ClearVariables('RT_RTR001'); //HEI.16
        //HEI.12
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        MESSAGE(ApprovalDisabled);//HEI.40
        // Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01 Commented to resolved compilation error
        GeneralJournalTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01 added to resolved compilation error

        // Open Gen. Journal Batch page
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Import Payroll
        //GenJournalPage.ImportPayroll.INVOKE;

        //FileName := FileMgt.UploadFile(Text001,ExcelFileExtensionTok); HEI.15 commented
        //FileName := FileMgt.UploadFileSilent(PayrollCCCFileNameTxt); //HEI.15 //BC Upgrade KAPOOV01 Blocked FileMgt functionality  

        //ImportPayroll.GetExcelSheet(FileName,'Payroll'); //HEI.15 commented
        //HEI.31>>
        //ImportPayroll.GetExcelSheet(FileName,PayrollSheetNameTxt); //HEI.15
        //ExcelBuf.OpenBook(FileName, PayrollSheetNameTxt); //BC Upgrade KAPOOV01 Blocked OpenBook due to its OnPrem scope.
        // ExcelBuf.OpenBookStream(InStr, PayrollSheetNameTxt); //BC Upgrade KAPOOV01 replaced OpenBook with OpenBookStream.//Bc Upgrade YADAVM09<<
        // ExcelBuf.ReadSheet;//Bc Upgrade YADAVM09<<
        //ImportPayroll.ReadExcelSheet;
        //HEI.31<<
        //HEI.16>>
        //ImportPayroll.AnalyzeData;
        //HEI.32>>
        //ImportPayroll.AnalyzeData;//Bc Upgrade YADAVM09<<

        //BC Upgrade KAPOOV01 Updated Comment Syntax >>
        //{
        // ASSERTERROR ImportPayroll.AnalyzeData;

        // IF GETLASTERRORTEXT <> WrongCCCValueErr THEN
        //     ERROR('Unexpected Error: %1', GETLASTERRORTEXT);
        //}
        //BC Upgrade KAPOOV01 Updated Comment Syntax <<
        //BC Upgrade YADAVM09>>
        GenJournalPage.NEW;
        GenJournalPage."Posting Date".SETVALUE(WORKDATE);
        GenJournalPage."Document No.".SetValue('PAIE 6/2020');
        GenJournalPage."Account No.".SETVALUE('11103001');
        GenJournalPage.Description.SETVALUE('OD PAIE');
        GenJournalPage.Amount.SETVALUE(1000);
        GenJournalPage."Shortcut Dimension 2 Code".SETVALUE(10001);
        //Bc Upgrade YADAVM09<<
        //HEI.32<<
        //HEI.16>>
        //Update Workflow User Groups
        UserSetup.FINDFIRST;

        if WorkflowUserGroup.FINDSET() then
            repeat
                WorkflowUserGroupMember.SETRANGE("Workflow User Group Code", WorkflowUserGroup.Code);
                WorkflowUserGroupMember.SETRANGE("Sequence No.", 2);
                if not WorkflowUserGroupMember.FINDFIRST then begin
                    WorkflowUserGroupMember.INIT;
                    WorkflowUserGroupMember."Workflow User Group Code" := WorkflowUserGroup.Code;
                    WorkflowUserGroupMember."User Name" := UserSetup."User ID";
                    WorkflowUserGroupMember.INSERT;
                end;
            until WorkflowUserGroup.NEXT = 0;
        //HEI.16<<

        //Send for approval
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then //HEI.16
                                                                                             //HEI.16>>
                                                                                             //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
                                                                                             //WorkflowResponse.DELETE;
                                                                                             //HEI.16<<
            GenJournalPage.SendApprovalRequestJournalBatch.INVOKE
        //HEI.16>>
        //END;
        else
            MESSAGE(ApprovalNotSentMsg);
        //HEI.16<<

        //Check if the posting batch was created and submitted for approval - Open the page to see the requests
        ApprovalEntries.TRAP;
        GenJournalPage.Approvals.INVOKE;

        //HEI.12<<
    end;

    [Test]
    [HandlerFunctions('FAClassesModalPageHandler,FASubclassesModalPageHandler,EmployeeListModalPageHandler,FAPostingGroupsModalPageHandler')]
    procedure "RTR073-CreateFixedAssetWrongCCC"();
    var
        FixedAssetList: TestPage "Fixed Asset List";
        FixedAssetCard: TestPage "Fixed Asset Card";
        FADepreciationBooksSubform: TestPage "FA Depreciation Books Subform";
        FADepreciationBooks: TestPage "FA Depreciation Books";
        DepreciationBook: Record "Depreciation Book";
    begin
        //HEI.07
        FixedAssetList.OPENVIEW;
        FixedAssetList.NEW;

        FixedAssetCard.OPENNEW;
        //HEI.21>>
        gFASetUp.GET;
        gNoSeries.GET(gFASetUp."Fixed Asset Nos.");
        if gNoSeries."Manual Nos." then
            FixedAssetCard."No.".SETVALUE('TS_RTR073')
        else begin
            gNoSeries."Manual Nos." := true;
            gNoSeries.MODIFY;
            FixedAssetCard."No.".SETVALUE('TS_RTR073');
        end;

        //FixedAssetCard."No.".ASSISTEDIT;
        //No. series page will open so this is handled by function "NoSerisPageHandler"
        //HEI.21<<
        FixedAssetCard.Description.SETVALUE('TestScript RTR073');
        FixedAssetCard."Description 2".SETVALUE('TestScript RTR073');
        FixedAssetCard."FA Class Code".LOOKUP;
        FixedAssetCard."FA Subclass Code".LOOKUP;
        FixedAssetCard."Responsible Employee".LOOKUP;
        FixedAssetCard.Quantity.SETVALUE(100);
        FixedAssetCard."Tag No".SETVALUE('TestScript RTR073');

        //Add depreciation books
        FixedAssetCard.AddMoreDeprBooks.DRILLDOWN;

        //Edit Local depr. Book
        FADepreciationBooks.OPENEDIT;
        //HEI.16>>
        //FADepreciationBooks.FINDFIRSTFIELD("FA No.",FixedAssetCard."No.".VALUE);
        FADepreciationBooks.FILTER.SETFILTER("FA No.", FixedAssetCard."No.".VALUE);
        //HEI.16<<
        FADepreciationBooks."FA Posting Group".LOOKUP;
        FADepreciationBooks."Depreciation Method".LOOKUP; //already filled in
        //FADepreciationBooks."No. of Depreciation Years".SETVALUE(5); //BC Upgrade KAPOOV01

        //add HNK Depr. Book
        FADepreciationBooks.NEW;
        FADepreciationBooks."FA No.".SETVALUE(FixedAssetCard."No.".VALUE);
        if DepreciationBook.GET('HEINEKEN') then
            FADepreciationBooks."Depreciation Book Code".SETVALUE('HEINEKEN')
        else if DepreciationBook.GET('HNK') then
            FADepreciationBooks."Depreciation Book Code".SETVALUE('HNK');
        FADepreciationBooks."FA Posting Group".LOOKUP;
        FADepreciationBooks."Depreciation Method".LOOKUP;
        FADepreciationBooks."Depreciation Starting Date".SETVALUE(WORKDATE);
        FADepreciationBooks."No. of Depreciation Years".SETVALUE(5);

        FADepreciationBooks.CLOSE;
        FixedAssetCard.CLOSE;
        //HEI.07
    end;

    [Test]
    procedure "RTR074-FixedAssetModification"();
    var
        FixedAssetList: TestPage "Fixed Asset List";
        FixedAssetCard: TestPage "Fixed Asset Card";
        FixedAsset: Record "Fixed Asset";
    begin
        ClearVariables('RTR074'); //HEI.16
        //HEI.07
        //take the item needed to be modifiied
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR074', COMPANYNAME, DATABASE::"Fixed Asset");
        FixedAsset.GET(UnitTestingValues.Value);

        //Open Fixed Asset List
        FixedAssetList.OPENVIEW;

        //Open the FA No.
        FixedAssetCard.OPENEDIT;
        FixedAssetCard.FILTER.SETFILTER("No.", FixedAsset."No.");

        FixedAssetCard.Description.SETVALUE('TestScript RTR074 Updated');
        FixedAssetCard."Description 2".SETVALUE('TestScript RTR074 Updated');

        FixedAssetCard.CLOSE;
        //HEI.07
    end;

    [Test]
    //[HandlerFunctions('FAClassesModalPageHandler,FASubclassesModalPageHandler,EmployeeListModalPageHandler,FAPostingGroupsModalPageHandler,FATemplateListModalPageHandler,ConfirmationHandler')] //BC Upgrade KAPOOV01 Removed Handler- ConfirmationHandler
    [HandlerFunctions('FAClassesModalPageHandler,FASubclassesModalPageHandler,EmployeeListModalPageHandler,FAPostingGroupsModalPageHandler,FATemplateListModalPageHandler')]
    procedure "RTR075-RPMAssetMasteDataCreation"();
    var
        FixedAssetList: TestPage "Fixed Asset List";
        FixedAssetCard: TestPage "Fixed Asset Card";
        FADepreciationBooksSubform: TestPage "FA Depreciation Books Subform";
        FADepreciationBooks: TestPage "FA Depreciation Books";
        DepreciationBook: Record "Depreciation Book";
    begin
        //HEI.07
        FixedAssetList.OPENVIEW;
        FixedAssetList.NEW;

        FixedAssetCard.OPENNEW;

        //HEI.21>>
        gFASetUp.GET;
        gNoSeries.GET(gFASetUp."Fixed Asset Nos.");
        if gNoSeries."Manual Nos." then
            FixedAssetCard."No.".SETVALUE('TS_RTR075')
        else begin
            gNoSeries."Manual Nos." := true;
            gNoSeries.MODIFY;
            FixedAssetCard."No.".SETVALUE('TS_RTR075');
        end;

        //FixedAssetCard."No.".ASSISTEDIT;
        //No. series page will open so this is handled by function "NoSerisPageHandler"
        //HEI.21<<

        FixedAssetCard.Description.SETVALUE('TestScript RTR075');
        FixedAssetCard."Description 2".SETVALUE('TestScript RTR075');
        FixedAssetCard."FA Class Code".LOOKUP;
        FixedAssetCard."FA Subclass Code".LOOKUP;
        FixedAssetCard."Responsible Employee".LOOKUP;
        FixedAssetCard.Quantity.SETVALUE(100);
        FixedAssetCard."Tag No".SETVALUE('TestScript RTR075');

        //Edit Local depr. Book
        FADepreciationBooks.OPENEDIT;
        //HEI.16>>
        //FADepreciationBooks.FINDFIRSTFIELD("FA No.",FixedAssetCard."No.".VALUE);
        FADepreciationBooks.FILTER.SETFILTER("FA No.", FixedAssetCard."No.".VALUE);
        //HEI.16<<
        FADepreciationBooks."FA Posting Group".LOOKUP;
        FADepreciationBooks."Depreciation Method".LOOKUP; //already filled in
        //FADepreciationBooks."No. of Depreciation Years".SETVALUE(5);  //BC Upgrade KAPOOV01

        //add HNK Depr. Book
        FADepreciationBooks.NEW;
        FADepreciationBooks."FA No.".SETVALUE(FixedAssetCard."No.".VALUE);
        if DepreciationBook.GET('HEINEKEN') then
            FADepreciationBooks."Depreciation Book Code".SETVALUE('HEINEKEN')
        else if DepreciationBook.GET('HNK') then
            FADepreciationBooks."Depreciation Book Code".SETVALUE('HNK');
        FADepreciationBooks."FA Posting Group".LOOKUP;
        FADepreciationBooks."Depreciation Method".LOOKUP;
        FADepreciationBooks."Depreciation Starting Date".SETVALUE(WORKDATE);
        FADepreciationBooks."No. of Depreciation Years".SETVALUE(5);
        //FADepreciationBooks.CLOSE;

        //Add dimensions - will be automatically inserted when filling in the FA Template Code
        //FixedAssetCard."FA Template Code".LOOKUP; //BC Upgrade KAPOOV01 DRINK-IT
        FixedAssetCard."FA Template APS".LOOKUP; //BC Upgrade KAPOOV01 DRINK-IT replaced "FA Template Code" with "FA Template APS"

        //FixedAssetCard.CLOSE;
        //HEI.07
    end;

    [Test]
    //[HandlerFunctions('EmployeeListModalPageHandler,VendorModalPageHandler,FAPostingGroupsModalPageHandler,FAClassesModalPageHandler,LocationsModalPageHandler')] //BC Upgrade KAPOOV01 Removed Drink-IT dependent handler-LocationsModalPageHandler
    [HandlerFunctions('EmployeeListModalPageHandler,VendorModalPageHandler,FAPostingGroupsModalPageHandler,FAClassesModalPageHandler')]//BC Upgrade KAPOOV01 Removed Drink-IT dependent handler-LocationsModalPageHandler
    procedure "RTR077-ReviewFixedAsset"();
    var
        FixedAssetIndicatorList: TestPage "Fixed Asset List 1 CBN";
        FixedAssetCard: TestPage "Fixed Asset Card";
        FixedAsset: Record "Fixed Asset";
    begin
        //HEI.07
        //Open Fixed Asset Indicator List
        FixedAssetIndicatorList.OPENVIEW;

        //Filter on Asset Indicator 2
        FixedAssetIndicatorList.FILTER.SETFILTER("Asset Indicator FND", '02');

        //Open the FA No. card
        FixedAssetCard.OPENEDIT;
        FixedAssetCard.FILTER.SETFILTER("No.", FixedAssetIndicatorList."No.".VALUE);

        //Perform the check of missing mandatory fields and fill in the missing ones
        if FixedAssetCard.Description.VALUE = '' then
            FixedAssetCard.Description.SETVALUE('Test Script RTR077');
        if FixedAssetCard."Description 2".VALUE = '' then
            FixedAssetCard."Description 2".SETVALUE('Test Script RTR077');
        FixedAssetCard."FA Class Code".LOOKUP;
        //FixedAssetCard."Location Code".LOOKUP; //BC Upgrade KAPOOV01 DRINK-IT
        FixedAssetCard."Responsible Employee".LOOKUP;
        FixedAssetCard."FA Posting Group".LOOKUP;
        FixedAssetCard."Vendor No.".LOOKUP;
        if FixedAssetCard."Serial No.".VALUE = '' then
            FixedAssetCard."Serial No.".SETVALUE('RT077');

        //close FA Card
        FixedAssetCard.CLOSE;
        //HEI.07
    end;

    [Test]
    procedure "RTR081-FixedAssetCorrectioOfSubclass"();
    var
        FixedAssetList: TestPage "Fixed Asset List";
        FixedAssetCard: TestPage "Fixed Asset Card";
        FixedAsset: Record "Fixed Asset";
        FASubclass: Record "FA Subclass";
    begin
        ClearVariables('RTR081'); //HEI.16
        //HEI.07
        //take the item needed to be modifiied
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR081', COMPANYNAME, DATABASE::"Fixed Asset");
        FixedAsset.GET(UnitTestingValues.Value);

        //take the new Subclass code
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR081', COMPANYNAME, DATABASE::"FA Subclass");
        FASubclass.GET(UnitTestingValues.Value);

        //Open Fixed Asset List
        FixedAssetList.OPENVIEW;

        //Open the FA No.
        FixedAssetCard.OPENEDIT;
        FixedAssetCard.FILTER.SETFILTER("No.", FixedAsset."No.");

        //Perform change in Fixed Asset Subclass Code.
        FixedAssetCard."FA Subclass Code".SETVALUE(FASubclass.Code);

        //Click on "X" to update the Asset Master Data entry.
        FixedAssetCard.CLOSE;
        //HEI.07
    end;

    [Test]
    procedure "RTR082-FixedAssetChangeLocationOrCCC"();
    var
        FixedAssetList: TestPage "Fixed Asset List";
        FixedAssetCard: TestPage "Fixed Asset Card";
        FixedAsset: Record "Fixed Asset";
        Location: Record Location;
        DimensionValue: Record "Dimension Value";
    begin
        ClearVariables('RTR082'); //HEI.16
        //HEI.07
        //take the item needed to be modifiied
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR082', COMPANYNAME, DATABASE::"Fixed Asset");
        FixedAsset.GET(UnitTestingValues.Value);

        //take the new Subclass code
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR082', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        //Open Fixed Asset List
        FixedAssetList.OPENVIEW;

        //Open the FA No.
        FixedAssetCard.OPENEDIT;
        FixedAssetCard.FILTER.SETFILTER("No.", FixedAsset."No.");

        //Perform change in Location Code
        //FixedAssetCard."Location Code".SETVALUE(Location.Code); //BC Upgrade KAPOOV01 DRINK-IT

        //Perform change in "Cost Center" Dimension - handled using "DefaultDimensionsModalPageHandler" function
        //FixedAssetCard."Page Default Dimensions".INVOKE; //BC Upgrade KAPOOV01
        FixedAssetCard.Dimensions.INVOKE; //BC Upgrade KAPOOV01

        //Click on "X" to update the Asset Master Data entry.
        FixedAssetCard.CLOSE;
        //HEI.07
    end;

    [Test]
    [HandlerFunctions('FixedAssetRequestPageHandler')]
    procedure "RTR085-RunFixedAssetNetBookValue"();
    var
        FixedAssetBookValue01: Report "Fixed Asset - Book Value 01";
    begin
        //HEI.51>>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR121', COMPANYNAME, DATABASE::"Fixed Asset");
        FixedAsset.GET(UnitTestingValues.Value);
        //REPORT.RUNMODAL(5605, true, false, FixedAsset); //BC Upgrade KAPOOV01 For old Report with ID-5605 new report ID is 55041, replaced report ID-5605 with new ID- 55041.
        REPORT.RUNMODAL(55041, true, false, FixedAsset); //BC Upgrade KAPOOV01 For old Report with ID-5605 new report ID is 55041, replaced report ID-5605 with new ID- 55041 
        //HEI.51<<
        //FixedAssetBookValue01.RUNMODAL; //HEI.07
    end;

    [Test]
    [HandlerFunctions('FAClassesModalPageHandler,FASubclassesModalPageHandler,EmployeeListModalPageHandler,FAPostingGroupsModalPageHandler,ConfirmationHandler,MessageHandler')]
    procedure "RTR087-AssetSplit"();
    var
        FixedAssetList: TestPage "Fixed Asset List";
        FixedAssetCard: TestPage "Fixed Asset Card";
        FADepreciationBooksSubform: TestPage "FA Depreciation Books Subform";
        FADepreciationBooks: TestPage "FA Depreciation Books";
        DepreciationBook: Record "Depreciation Book";
        FAReclassJournalBatches: TestPage "FA Reclass. Journal Batches";
        FAReclassJournalBatch: Record "FA Reclass. Journal Batch";
        FAReclassJournalTemplates: TestPage "FA Reclass. Journal Templates";
        FAReclassJournalTemplate: Record "FA Reclass. Journal Template";
        FAReclassJournal: TestPage "FA Reclass. Journal";
        FixedAsset: Record "Fixed Asset";
        FA1: Code[15];
        FA2: Code[15];
        FAJournalSetup: Record "FA Journal Setup";
        GenJnlTemplates: TestPage "General Journal Templates";
        GenJournalBatches: TestPage "General Journal Batches";
        FixedAssetGLJournal: TestPage "Fixed Asset G/L Journal";
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        lFAPostingGroup: Record "FA Posting Group";
        lGLAcc: Record "G/L Account";
        DimensionValue: Record "Dimension Value";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DefaultDimension: Record "Default Dimension";
        GLAccount: Record "G/L Account";
        lFAReclassJournalLine: Record "FA Reclass. Journal Line";
        FALedgerEntry: Record "FA Ledger Entry";
        Totalamount: Decimal;
        Totalamount1: Decimal;
    begin
        //HEI.33>>
        GeneralLedgerSetup.GET;
        DefaultDimension.RESET;
        DefaultDimension.SETRANGE("Table ID", 15);
        DefaultDimension.SETFILTER("Dimension Code", '%1|%2|%3', 'MVMT', 'CONCAT', GeneralLedgerSetup."Shortcut Dimension 2 Code");
        DefaultDimension.SETFILTER("Value Posting", '<>%1', DefaultDimension."Value Posting"::" ");
        if DefaultDimension.FINDSET then begin
            repeat
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.MODIFY;
            until DefaultDimension.NEXT = 0;
        end;
        //HEI.27>>
        /*DefaultDimension.RESET;
        DefaultDimension.SETRANGE("Table ID",15);
        DefaultDimension.SETRANGE("Dimension Code",'MVMT');
        DefaultDimension.SETFILTER("Value Posting",'<>%1',DefaultDimension."Value Posting"::" ");
        IF DefaultDimension.FINDSET THEN BEGIN
         REPEAT
          DefaultDimension."Value Posting":=DefaultDimension."Value Posting"::" ";
          DefaultDimension.MODIFY;
         UNTIL DefaultDimension.NEXT = 0;
        END;
        */
        //HEI.27<<
        //HEI.30>>
        /*DefaultDimension.RESET;
        DefaultDimension.SETRANGE("Table ID",15);
        DefaultDimension.SETRANGE("Dimension Code",'CONCAT');
        DefaultDimension.SETFILTER("Value Posting",'<>%1',DefaultDimension."Value Posting"::" ");
        IF DefaultDimension.FINDSET THEN BEGIN
         REPEAT
          DefaultDimension."Value Posting":=DefaultDimension."Value Posting"::" ";
          DefaultDimension.MODIFY;
         UNTIL DefaultDimension.NEXT = 0;
        END;
        */
        //HEI.30<<
        //HEI.33<<
        ClearVariables('RTR087'); //HEI.16
        //HEI.07
        FixedAssetList.OPENVIEW;
        //FixedAssetList.NEW; //HEI.16

        //Create First FA
        FixedAssetCard.OPENNEW;
        //HEI.21>>
        gFASetUp.GET;
        gNoSeries.GET(gFASetUp."Fixed Asset Nos.");
        if gNoSeries."Manual Nos." then
            FixedAssetCard."No.".SETVALUE('TS_RTR087_FA1')
        else begin
            gNoSeries."Manual Nos." := true;
            gNoSeries.MODIFY;
            FixedAssetCard."No.".SETVALUE('TS_RTR087_FA1');
        end;

        //FixedAssetCard."No.".ASSISTEDIT;
        //HEI.21<<
        FA1 := FixedAssetCard."No.".VALUE;
        //No. series page will open so this is handled by function "NoSerisPageHandler"

        FixedAssetCard.Description.SETVALUE('TestScript RTR087');
        FixedAssetCard."Description 2".SETVALUE('TestScript RTR087');
        FixedAssetCard."FA Class Code".LOOKUP;
        FixedAssetCard."FA Subclass Code".LOOKUP;
        FixedAssetCard."Responsible Employee".LOOKUP;
        FixedAssetCard.Quantity.SETVALUE(100);
        FixedAssetCard."Tag No".SETVALUE('TestScript RTR073');

        //Add depreciation books
        FixedAssetCard.AddMoreDeprBooks.DRILLDOWN;

        //Edit Local depr. Book
        FADepreciationBooks.OPENEDIT;
        //HEI.16>>
        //FADepreciationBooks.FINDFIRSTFIELD("FA No.",FixedAssetCard."No.".VALUE);
        FADepreciationBooks.FILTER.SETFILTER("FA No.", FixedAssetCard."No.".VALUE);
        //HEI.16<<
        FADepreciationBooks."FA Posting Group".LOOKUP;
        FADepreciationBooks."Depreciation Method".LOOKUP; //already filled in
        FADepreciationBooks."No. of Depreciation Years".SETVALUE(5);
        //FADepreciationBooks."Projected Disposal Date".SETVALUE(0D);

        //add HNK Depr. Book
        FADepreciationBooks.NEW;
        FADepreciationBooks."FA No.".SETVALUE(FixedAssetCard."No.".VALUE);
        if DepreciationBook.GET('HEINEKEN') then
            FADepreciationBooks."Depreciation Book Code".SETVALUE('HEINEKEN')
        else if DepreciationBook.GET('HNK') then
            FADepreciationBooks."Depreciation Book Code".SETVALUE('HNK');
        FADepreciationBooks."FA Posting Group".LOOKUP;
        FADepreciationBooks."Depreciation Method".LOOKUP;
        FADepreciationBooks."Depreciation Starting Date".SETVALUE(WORKDATE);
        FADepreciationBooks."No. of Depreciation Years".SETVALUE(5);

        FADepreciationBooks.CLOSE;
        FixedAssetCard.CLOSE;

        //Create Second FA
        FixedAssetCard.OPENNEW;

        //HEI.21>>
        gFASetUp.GET;
        gNoSeries.GET(gFASetUp."Fixed Asset Nos.");
        if gNoSeries."Manual Nos." then
            FixedAssetCard."No.".SETVALUE('TS_RTR087_FA2')
        else begin
            gNoSeries."Manual Nos." := true;
            gNoSeries.MODIFY;
            FixedAssetCard."No.".SETVALUE('TS_RTR087_FA2');
        end;
        //FixedAssetCard."No.".ASSISTEDIT;
        //HEI.21<<
        FA2 := FixedAssetCard."No.".VALUE;
        //No. series page will open so this is handled by function "NoSerisPageHandler"

        FixedAssetCard.Description.SETVALUE('TestScript RTR087');
        FixedAssetCard."Description 2".SETVALUE('TestScript RTR087');
        FixedAssetCard."FA Class Code".LOOKUP;
        FixedAssetCard."FA Subclass Code".LOOKUP;
        FixedAssetCard."Responsible Employee".LOOKUP;
        FixedAssetCard.Quantity.SETVALUE(100);
        FixedAssetCard."Tag No".SETVALUE('TestScript RTR087');
        //Add depreciation books
        FixedAssetCard.AddMoreDeprBooks.DRILLDOWN;

        //Edit Local depr. Book
        FADepreciationBooks.OPENEDIT;
        //HEI.16>>
        //FADepreciationBooks.FINDFIRSTFIELD("FA No.",FixedAssetCard."No.".VALUE);
        FADepreciationBooks.FILTER.SETFILTER("FA No.", FixedAssetCard."No.".VALUE);
        //HEI.16<<
        FADepreciationBooks."FA Posting Group".LOOKUP;
        FADepreciationBooks."Depreciation Method".LOOKUP; //already filled in
        FADepreciationBooks."No. of Depreciation Years".SETVALUE(5);

        //add HNK Depr. Book
        FADepreciationBooks.NEW;
        FADepreciationBooks."FA No.".SETVALUE(FixedAssetCard."No.".VALUE);
        if DepreciationBook.GET('HEINEKEN') then
            FADepreciationBooks."Depreciation Book Code".SETVALUE('HEINEKEN')
        else if DepreciationBook.GET('HNK') then
            FADepreciationBooks."Depreciation Book Code".SETVALUE('HNK');
        FADepreciationBooks."FA Posting Group".LOOKUP;
        FADepreciationBooks."Depreciation Method".LOOKUP;
        FADepreciationBooks."Depreciation Starting Date".SETVALUE(WORKDATE);
        FADepreciationBooks."No. of Depreciation Years".SETVALUE(5);

        FADepreciationBooks.CLOSE;
        FixedAssetCard.CLOSE;

        //Get the FA Journal template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR087', COMPANYNAME, DATABASE::"FA Reclass. Journal Template");
        FAReclassJournalTemplate.GET(UnitTestingValues.Value);

        //Get the FA Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR087', COMPANYNAME, DATABASE::"FA Reclass. Journal Batch");
        FAReclassJournalBatch.GET(FAReclassJournalTemplate.Name, UnitTestingValues.Value);

        //Get the old FA
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR087', COMPANYNAME, DATABASE::"Fixed Asset");
        FixedAsset.GET(UnitTestingValues.Value);

        //HEI.16>>
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR087', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR087', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);
        //HEI.16<<
        //HEI.37>>
        if GenJournalBatch."Bal. Account No." <> '' then begin
            GenJournalBatch."Bal. Account No." := '';
            GenJournalBatch.MODIFY;
        end;
        //HEI.37<<
        //HEI.36>>
        lFAReclassJournalLine.RESET;
        lFAReclassJournalLine.SETRANGE("Journal Template Name", FAReclassJournalTemplate.Name);
        lFAReclassJournalLine.SETRANGE("Journal Batch Name", FAReclassJournalBatch.Name);
        if lFAReclassJournalLine.FINDSET then
            lFAReclassJournalLine.DELETEALL;
        //HEI.36<<
        //HEI.31>>
        GeneralLedgerSetup.GET;
        DefaultDimension.RESET;
        DefaultDimension.SETRANGE("Table ID", 5600);
        DefaultDimension.SETRANGE("No.", FixedAsset."No.");
        DefaultDimension.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        if DefaultDimension.FINDFIRST then begin
            DimensionValue.RESET;
            DimensionValue.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
            DimensionValue.SETRANGE(Code, DefaultDimension."Dimension Value Code");
            if DimensionValue.FINDFIRST then begin
                if DimensionValue.Blocked then begin
                    DimensionValue.Blocked := false;
                    DimensionValue.MODIFY;
                end;
            end;
        end;
        //HEI.31<<

        //HEI.26>>
        lFAPostingGroup.RESET;
        lFAPostingGroup.SETFILTER("Acquisition Cost Account", '<>%1', '');
        if lFAPostingGroup.FINDSET(false) then begin
            repeat
                lGLAcc.GET(lFAPostingGroup."Acquisition Cost Account");
                if lGLAcc.Blocked then begin
                    lGLAcc.Blocked := false;
                    lGLAcc.MODIFY;
                end
            until lFAPostingGroup.NEXT = 0;
        end;
        lFAPostingGroup.RESET;
        lFAPostingGroup.SETFILTER("Accum. Depreciation Account", '<>%1', '');
        if lFAPostingGroup.FINDSET(false) then begin
            repeat
                lGLAcc.GET(lFAPostingGroup."Accum. Depreciation Account");
                if lGLAcc.Blocked then begin
                    lGLAcc.Blocked := false;
                    lGLAcc.MODIFY;
                end
            until lFAPostingGroup.NEXT = 0;
        end;

        //HEI.26<<
        //HEI.25>>
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            Workflow.SETRANGE(Enabled, true);
            if Workflow.FINDSET then
                repeat
                    Workflow.Enabled := false;
                    Workflow.MODIFY;
                until Workflow.NEXT = 0;
        end;
        //HEI.25<<
        //Before pressing on "Reclassify", we need to make sure that the FA G/L journal where the lines are going to be posted is empty
        //HEI.16>>
        //FAJournalSetup.GET('LOCAL',USERID);
        if not FAJournalSetup.GET('LOCAL', USERID) then begin
            FAJournalSetup."Depreciation Book Code" := 'LOCAL';
            FAJournalSetup."User ID" := USERID;
            FAJournalSetup."FA Jnl. Template Name" := FAReclassJournalTemplate.Name;
            FAJournalSetup."FA Jnl. Batch Name" := FAReclassJournalBatch.Name;
            FAJournalSetup."Gen. Jnl. Template Name" := GenJournalTemplate.Name;
            FAJournalSetup."Gen. Jnl. Batch Name" := GenJournalBatch.Name;
            FAJournalSetup.INSERT;
        end;

        if not FAJournalSetup.GET('HEINEKEN', USERID) then begin
            FAJournalSetup."Depreciation Book Code" := 'HEINEKEN';
            FAJournalSetup."User ID" := USERID;
            FAJournalSetup."FA Jnl. Template Name" := FAReclassJournalTemplate.Name;
            FAJournalSetup."FA Jnl. Batch Name" := FAReclassJournalBatch.Name;
            FAJournalSetup."Gen. Jnl. Template Name" := GenJournalTemplate.Name;
            FAJournalSetup."Gen. Jnl. Batch Name" := GenJournalBatch.Name;
            FAJournalSetup.INSERT;
        end;

        if not FAJournalSetup.GET('HNK', USERID) then begin
            FAJournalSetup."Depreciation Book Code" := 'HNK';
            FAJournalSetup."User ID" := USERID;
            FAJournalSetup."FA Jnl. Template Name" := FAReclassJournalTemplate.Name;
            FAJournalSetup."FA Jnl. Batch Name" := FAReclassJournalBatch.Name;
            FAJournalSetup."Gen. Jnl. Template Name" := GenJournalTemplate.Name;
            FAJournalSetup."Gen. Jnl. Batch Name" := GenJournalBatch.Name;
            FAJournalSetup.INSERT;
        end;
        //HEI.16<<

        //Open the Template
        //HEI.16>>
        GenJnlTemplates.OPENVIEW;
        GenJournalBatches.TRAP;
        //HEI.16>>
        //GenJnlTemplates.FINDFIRSTFIELD(Name,FAJournalSetup."FA Jnl. Template Name");
        GenJnlTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GenJnlTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01
        GenJnlTemplates.Batches.INVOKE; //BC Upgrade KAPOOV01

        //Open the Batch
        FixedAssetGLJournal.TRAP;
        //HEI.16>>
        //GenJournalBatches.FINDFIRSTFIELD(Name,FAJournalSetup."FA Jnl. Batch Name");
        GenJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GenJournalBatches.EditJournal.INVOKE;
        //HEI.16<<

        //remove lines to be sure that only the lines we are going to post are inserted
        //HEI.16>>
        //GenJournalLine.SETRANGE("Journal Template Name",FAJournalSetup."FA Jnl. Template Name");
        //GenJournalLine.SETRANGE("Journal Batch Name",FAJournalSetup."FA Jnl. Batch Name");
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        //HEI.16<<
        GenJournalLine.DELETEALL;

        //Open FA Reclassification Template
        FAReclassJournalTemplates.OPENVIEW;
        FAReclassJournalBatches.TRAP;
        //HEI.16>>
        //FAReclassJournalTemplates.FINDFIRSTFIELD(Name,FAReclassJournalTemplate.Name);
        FAReclassJournalTemplates.FILTER.SETFILTER(Name, FAReclassJournalTemplate.Name);
        //HEI.16<<
        //HEI.78>>
        GenJournalTemplate."Blocked FND" := false;
        GenJournalTemplate.MODIFY;
        //HEI.78<<
        //FAReclassJournalTemplates."Page FA Reclass. Journal Batches".INVOKE; //BC Upgrade KAPOOV01
        FAReclassJournalTemplates.Batches.INVOKE; //BC Upgrade KAPOOV01

        //Open FA Reclassification Batch
        FAReclassJournal.TRAP;
        //HEI.16>>
        //FAReclassJournalBatches.FINDFIRSTFIELD(Name,FAReclassJournalBatch.Name);
        FAReclassJournalBatches.FILTER.SETFILTER(Name, FAReclassJournalBatch.Name);
        //HEI.16<<
        //FAReclassJournalBatches.Action9.INVOKE; //BC Upgrade KAPOOV01
        FAReclassJournalBatches."Edit Journal".INVOKE; //BC Upgrade KAPOOV01

        //add the first line
        FAReclassJournal.NEW;
        FAReclassJournal."FA Posting Date".SETVALUE(WORKDATE);
        //HEI.16>>
        FAReclassJournal."Document No.".SETVALUE(FixedAssetGLJournal."Document No.".VALUE);//HEI.26
        //FAReclassJournal."Document No.".SETVALUE('RTR087');//HEI.26
        //HEI.28>>
        if FAReclassJournal."Document No.".VALUE = '' then
            FAReclassJournal."Document No.".SETVALUE('RTR087');
        //HEI.28<<
        //HEI.16<<
        FAReclassJournal."FA No.".SETVALUE(FixedAsset."No.");
        FAReclassJournal."New FA No.".SETVALUE(FA1);
        FAReclassJournal."Depreciation Book Code".SETVALUE('LOCAL');
        FAReclassJournal.Description.SETVALUE('Test Script RTR087');
        FAReclassJournal."Reclassify Acq. Cost %".SETVALUE(60);
        FAReclassJournal."Reclassify Acquisition Cost".SETVALUE(true);
        FAReclassJournal."Reclassify Depreciation".SETVALUE(true);

        //Press "Reclassify" from "Home" menu and choose "Yes".
        FAReclassJournal.Reclassify.INVOKE;

        //add the second line
        FAReclassJournal.NEW;
        FAReclassJournal."FA Posting Date".SETVALUE(WORKDATE);
        //HEI.16>>
        FAReclassJournal."Document No.".SETVALUE(FixedAssetGLJournal."Document No.".VALUE);//HEI.26
        //FAReclassJournal."Document No.".SETVALUE('RTR087');//HEI.26
        //HEI.16<<
        FAReclassJournal."FA No.".SETVALUE(FixedAsset."No.");
        FAReclassJournal."New FA No.".SETVALUE(FA2);
        FAReclassJournal."Depreciation Book Code".SETVALUE('LOCAL');
        FAReclassJournal.Description.SETVALUE('Test Script RTR087');
        FAReclassJournal."Reclassify Acq. Cost %".SETVALUE(40);
        FAReclassJournal."Reclassify Acquisition Cost".SETVALUE(true);
        FAReclassJournal."Reclassify Depreciation".SETVALUE(true);

        //Press "Reclassify" from "Home" menu and choose "Yes"
        FAReclassJournal.Reclassify.INVOKE;

        //Post
        //HEI.65>>

        FALedgerEntry.RESET;
        FALedgerEntry.SETCURRENTKEY("FA No.", "Depreciation Book Code");
        FALedgerEntry.SETRANGE("FA No.", FixedAsset."No.");
        FALedgerEntry.SETRANGE("Depreciation Book Code", 'LOCAL');
        FALedgerEntry.SETFILTER("FA Posting Type", '%1', FALedgerEntry."FA Posting Type"::Depreciation);
        if FALedgerEntry.FINDSET(false) then
            FALedgerEntry.CALCSUMS(Amount);
        Totalamount := FALedgerEntry.Amount;

        FALedgerEntry.RESET;
        FALedgerEntry.SETCURRENTKEY("FA No.", "Depreciation Book Code");
        FALedgerEntry.SETRANGE("FA No.", FixedAsset."No.");
        FALedgerEntry.SETRANGE("Depreciation Book Code", 'LOCAL');
        FALedgerEntry.SETFILTER("FA Posting Type", '%1', FALedgerEntry."FA Posting Type"::"Acquisition Cost");
        if FALedgerEntry.FINDSET(false) then
            FALedgerEntry.CALCSUMS(Amount);
        Totalamount1 := FALedgerEntry.Amount;
        if (Totalamount * 60 / 100 = 0) or (Totalamount1 * 60 / 100 = 0) then
            exit;
        if (Totalamount * 60 / 100 > 0) or (Totalamount1 * 60 / 100 > 0) then
            exit;
        //HEI.65<<
        FixedAssetGLJournal."Posting Date".SETVALUE(WORKDATE);
        //FixedAssetGLJournal.Action50.INVOKE; //BC Upgrade KAPOOV01
        FixedAssetGLJournal."P&ost".INVOKE; //BC Upgrade KAPOOV01

        //HEI.07

    end;

    [Test]
    [HandlerFunctions('NoSeriesPageHandler,ConfirmationHandler,PostedSalesInvModalPageHandler')]
    procedure "RTR088-AssetDisposalSale"();
    var
        SalesInvoiceList: TestPage "Sales Invoice List";
        SalesInvoice: TestPage "Sales Invoice";
        SalesInvoiceSubform: TestPage "Sales Invoice Subform";
        Customer: Record Customer;
        FixedAsset: Record "Fixed Asset";
        FixedAssetList: TestPage "Fixed Asset List";
        FixedAssetCard: TestPage "Fixed Asset Card";
        lPayTerms: Record "Payment Terms";
        lFAPostingGroup: Record "FA Posting Group";
        lGLAcc: Record "G/L Account";
        lFAPostingGroup2: Record "FA Posting Group";
        AcqCostAccOnDisAcc: Code[20];
        AcqCostAccOnDisAccFound: Boolean;
        RTR088_GLAcc: Record "G/L Account";
        SalesBalAcc: Code[20];
        SalesBalAccFound: Boolean;
        lGenLedgSetUp: Record "General Ledger Setup";
        lEbfComb: Record "Ebf Combination FND";
        DefaultDimension: Record "Default Dimension";
        lCustPostGr: Record "Customer Posting Group";
        lFALedgEntry: Record "FA Ledger Entry";
        PostDate: Date;
        SalesInvoiceLine: Record "Sales Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Dimensionvalue: Record "Dimension Value";
    begin
        //HEI.27>>
        DefaultDimension.RESET;
        DefaultDimension.SETCURRENTKEY("Table ID", "No.", "Dimension Code");//HEI.51
        DefaultDimension.SETRANGE("Table ID", 15);
        DefaultDimension.SETRANGE("Dimension Code", 'MVMT');
        DefaultDimension.SETFILTER("Value Posting", '<>%1', DefaultDimension."Value Posting"::" ");
        if DefaultDimension.FINDSET then begin
            // REPEAT//HEI.51
            //DefaultDimension."Value Posting":=DefaultDimension."Value Posting"::" ";//HEI.51
            DefaultDimension.MODIFYALL(DefaultDimension."Value Posting", DefaultDimension."Value Posting"::" ");//HEI.51
                                                                                                                //UNTIL DefaultDimension.NEXT = 0;//HEI.51
        end;

        DefaultDimension.RESET;
        DefaultDimension.SETCURRENTKEY("Table ID", "No.", "Dimension Code");//HEI.51
        DefaultDimension.SETRANGE("Table ID", 15);
        DefaultDimension.SETRANGE("Dimension Code", 'TRD_PART');
        DefaultDimension.SETFILTER("Value Posting", '<>%1', DefaultDimension."Value Posting"::" ");
        if DefaultDimension.FINDSET then begin
            ///REPEAT//HEI.51
            //DefaultDimension."Value Posting":=DefaultDimension."Value Posting"::" ";//HEI.51
            DefaultDimension.MODIFYALL(DefaultDimension."Value Posting", DefaultDimension."Value Posting"::" ");//HEI.51
                                                                                                                //UNTIL DefaultDimension.NEXT = 0;//HEI.51
        end;
        //Update Dim Combination
        lGenLedgSetUp.GET;
        //HEI.40>>
        //HEI.41>>
        //Uncommented again
        lEbfComb.RESET;
        lEbfComb.SETCURRENTKEY("GL Account No.", "Dimension Code", "Dimension Value Code");
        lEbfComb.SETRANGE("Dimension Code", lGenLedgSetUp."Shortcut Dimension 2 Code");
        lEbfComb.SETFILTER("Combination Restriction", '%1|%2', lEbfComb."Combination Restriction"::"Allowed with Warn", lEbfComb."Combination Restriction"::"Not Allowed");
        lEbfComb.DELETEALL;
        //HEI.41<<
        //HEI.40<<
        //HEI.27
        //HEI.28>>
        DefaultDimension.RESET;
        DefaultDimension.SETCURRENTKEY("Table ID", "No.", "Dimension Code");//HEI.51
        DefaultDimension.SETRANGE("Table ID", 15);
        DefaultDimension.SETRANGE("Dimension Code", 'CONCAT');
        DefaultDimension.SETFILTER("Value Posting", '<>%1', DefaultDimension."Value Posting"::" ");
        if DefaultDimension.FINDSET then begin
            //REPEAT//HEI.51
            //DefaultDimension."Value Posting":=DefaultDimension."Value Posting"::" ";//HEI.51
            DefaultDimension.MODIFYALL(DefaultDimension."Value Posting", DefaultDimension."Value Posting"::" ");//HEI.51
                                                                                                                //UNTIL DefaultDimension.NEXT = 0;//HEI.51
        end;
        //HEI.28
        ClearVariables('RTR088'); //HEI.16
        //HEI.07
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR088', COMPANYNAME, DATABASE::"Fixed Asset");
        FixedAsset.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR088', COMPANYNAME, DATABASE::Customer);
        Customer.GET(UnitTestingValues.Value);

        //HEI.34>>
        //Customer."Ext. Doc. No. Mandatory" := Customer."Ext. Doc. No. Mandatory"::No; //BC Upgrade KAPOOV01 DRINK-IT
        Customer.MODIFY;
        //HEI.34<<

        //HEI.27>>
        if lCustPostGr.GET(Customer."Customer Posting Group") then begin
            if lGLAcc.GET(lCustPostGr."Receivables Account") then begin
                if lGLAcc.Blocked then begin
                    lGLAcc.Blocked := false;
                    lGLAcc.MODIFY;
                end;
            end;
        end;


        if lFAPostingGroup.GET(FixedAsset."FA Posting Group") then begin
            if lGLAcc.GET(lFAPostingGroup."Acq. Cost Acc. on Disposal") then begin
                if lGLAcc.Blocked then begin
                    lGLAcc.Blocked := false;
                    lGLAcc.MODIFY;
                end;
            end
            else begin
                if lFAPostingGroup."Acq. Cost Acc. on Disposal" = '' then begin
                    lFAPostingGroup2.RESET;
                    lFAPostingGroup2.SETFILTER("Acq. Cost Acc. on Disposal", '<>%1', '');
                    if lFAPostingGroup2.FINDSET then begin
                        repeat
                            AcqCostAccOnDisAcc := '';
                            AcqCostAccOnDisAccFound := false;
                            RTR088_GLAcc.GET(lFAPostingGroup2."Acq. Cost Acc. on Disposal");
                            if not RTR088_GLAcc.Blocked then begin
                                AcqCostAccOnDisAcc := RTR088_GLAcc."No.";
                                AcqCostAccOnDisAccFound := true;
                            end;
                        until (lFAPostingGroup2.NEXT = 0) or (AcqCostAccOnDisAccFound = true);
                        lFAPostingGroup."Acq. Cost Acc. on Disposal" := AcqCostAccOnDisAcc;
                        lFAPostingGroup.MODIFY;
                    end;
                end
            end;
        end;

        if lFAPostingGroup.GET(FixedAsset."FA Posting Group") then begin
            if lGLAcc.GET(lFAPostingGroup."Sales Bal. Acc.") then begin
                if (lGLAcc.Blocked) or (lGLAcc."Direct Posting" = false) then begin//HEI.34
                    lGLAcc.Blocked := false;
                    lGLAcc."Direct Posting" := true;//HEI.34
                    lGLAcc.MODIFY;
                end;
            end
            else begin
                if lFAPostingGroup."Sales Bal. Acc." = '' then begin
                    lFAPostingGroup2.RESET;
                    lFAPostingGroup2.SETFILTER("Sales Bal. Acc.", '<>%1', '');
                    if lFAPostingGroup2.FINDSET(false) then begin
                        repeat
                            SalesBalAcc := '';
                            SalesBalAccFound := false;
                            RTR088_GLAcc.GET(lFAPostingGroup2."Sales Bal. Acc.");
                            if not RTR088_GLAcc.Blocked then begin
                                RTR088_GLAcc."Direct Posting" := true;//HEI.34
                                RTR088_GLAcc.MODIFY;//HEI.34
                                SalesBalAcc := RTR088_GLAcc."No.";
                                SalesBalAccFound := true;
                            end
                            //HEI.34>>
                            else begin
                                RTR088_GLAcc.Blocked := false;
                                RTR088_GLAcc."Direct Posting" := true;
                                RTR088_GLAcc.MODIFY;
                                SalesBalAcc := RTR088_GLAcc."No.";
                                SalesBalAccFound := true;
                            end;
                        //HEI.34<<
                        until (lFAPostingGroup2.NEXT = 0) or (SalesBalAccFound = true);
                        lFAPostingGroup."Sales Bal. Acc." := SalesBalAcc;
                        lFAPostingGroup.MODIFY;
                    end;
                end
            end;
        end;

        lFAPostingGroup.RESET;
        lFAPostingGroup.SETRANGE("Sales Bal. Acc.", '');
        if lFAPostingGroup.FINDSET then begin
            //REPEAT//HEI.51
            //lFAPostingGroup."Sales Bal. Acc." := SalesBalAcc;//HEI.51
            lFAPostingGroup.MODIFYALL(lFAPostingGroup."Sales Bal. Acc.", SalesBalAcc);//HEI.51
                                                                                      // UNTIL lFAPostingGroup.NEXT = 0;//HEI.51
        end;

        lFAPostingGroup.RESET;
        lFAPostingGroup.SETRANGE("Book Val. Acc. on Disp. (Gain)", '');
        if lFAPostingGroup.FINDSET then begin
            //REPEAT//HEI.51
            //lFAPostingGroup."Book Val. Acc. on Disp. (Gain)" := SalesBalAcc;//HEI.51
            lFAPostingGroup.MODIFYALL(lFAPostingGroup."Book Val. Acc. on Disp. (Gain)", SalesBalAcc)//HEI.51
                                                                                                    //UNTIL lFAPostingGroup.NEXT = 0;//HEI.51
        end;

        lFAPostingGroup.RESET;
        lFAPostingGroup.SETRANGE("Sales Acc. on Disp. (Gain)", '');
        if lFAPostingGroup.FINDSET then begin
            // REPEAT//HEI.51
            //lFAPostingGroup."Sales Acc. on Disp. (Gain)" := SalesBalAcc;//HEI.51
            lFAPostingGroup.MODIFYALL(lFAPostingGroup."Sales Acc. on Disp. (Gain)", SalesBalAcc);//HEI.51
                                                                                                 // UNTIL lFAPostingGroup.NEXT = 0;//HEI.51
        end;
        //HEI.27<<

        //HEI.25
        //if lPayTerms.GET(Customer."Payment Terms Code") then begin//Bc upgrade YADAVM09<<
        //BC Upgrade KAPOOV01 Drink-IT >>
        // if not lPayTerms."Skip Document Warnings" then begin
        //     lPayTerms."Skip Document Warnings" := true;
        //     lPayTerms.MODIFY;
        // end;
        //BC Upgrade KAPOOV01 Drink-IT <<
        // end;//Bc upgrade YADAVM09<<
        //HEI.25

        //HEI.39>>
        lFALedgEntry.RESET;
        lFALedgEntry.SETRANGE("FA No.", FixedAsset."No.");
        if lFALedgEntry.FINDLAST then begin
            PostDate := CALCDATE('+1D', lFALedgEntry."Posting Date");
        end;
        //HEI.39<<

        //Open Sales Invoice List
        SalesInvoiceList.OPENVIEW;
        //SalesInvoiceList.NEW; //HEI.16

        //Open Sales invoice
        SalesInvoice.OPENNEW;
        SalesInvoice.NEW;

        SalesInvoice."No.".ASSISTEDIT;
        SalesInvoice."Sell-to Customer Name".SETVALUE(Customer."No.");
        SalesInvoice."Posting Description".SETVALUE('Test Script RTR088');
        //SalesInvoice."Tax Date".SETVALUE(PostDate);//HEI.39  //BC Upgrade KAPOOV01 DRINK-IT
        //SalesInvoice."Posting Date".SETVALUE(PostDate);//HEI.39
        SalesInvoice."Posting Date".SETVALUE(TODAY);//HEI.49
        SalesInvoice."Due Date".SETVALUE(PostDate);//HEI.39

        //HEI.62>>
        GeneralLedgerSetup.GET;
        DefaultDimension.RESET;
        DefaultDimension.SETRANGE("Table ID", 5600);
        DefaultDimension.SETRANGE("No.", FixedAsset."No.");
        DefaultDimension.SETRANGE("Dimension Code", 'CAPEX');
        if DefaultDimension.FINDFIRST then begin
            Dimensionvalue.RESET;
            Dimensionvalue.SETRANGE("Dimension Code", 'CAPEX');
            Dimensionvalue.SETRANGE(Code, DefaultDimension."Dimension Value Code");
            if Dimensionvalue.FINDFIRST then begin
                if Dimensionvalue.Blocked then begin
                    Dimensionvalue.Blocked := false;
                    Dimensionvalue.MODIFY;
                end;
            end;
        end;
        //HEI.62<<
        // Lines
        SalesInvoice.SalesLines.NEW;
        SalesInvoice.SalesLines.Type.SETVALUE(Type::"Fixed Asset");
        SalesInvoice.SalesLines."No.".SETVALUE(FixedAsset."No.");
        SalesInvoice.SalesLines.Quantity.SETVALUE(5);
        SalesInvoice.SalesLines."Unit Price".SETVALUE(1000);
        //HEI.55>>
        SalesInvoiceLine.RESET;
        SalesInvoiceLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");//HEI.58
        SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::"Fixed Asset");//HEI.58
        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoice."No.".VALUE);
        if SalesInvoiceLine.FINDSET then begin
            SalesInvoiceLine."Depreciation Book Code" := 'Local';
            SalesInvoiceLine."Duplicate in Depreciation Book" := 'HEINEKEN';
            SalesInvoiceLine.MODIFY;
        end;
        //HEi.55<<
        //SalesInvoice.SalesLines."Depreciation Book Code".SETVALUE('Local');//HEI.55
        //SalesInvoice.SalesLines."Duplicate in Depreciation Book".SETVALUE('HEINEKEN');//HEI.55
        // Sales Invoice post

        //HEI.80>>
        if SalesSetup.GET then begin
            if SalesSetup."Enable EBMS Interface FND" then begin
                SalesSetup."Enable EBMS Interface FND" := false;
                SalesSetup.MODIFY;
            end;
        end;

        if EBMSInterfaceSetup.GET then;
        if InterfaceSetup.GET(EBMSInterfaceSetup."Send Invoice Interface") then begin
            if InterfaceSetup.Enabled then begin
                InterfaceSetup.Enabled := false;
                InterfaceSetup.MODIFY;
            end;
        end;
        //HEI.80<<
        SalesInvoice.Post.INVOKE;

        SalesInvoice.CLOSE;

        //Go to search bar and select Fixed Assets
        FixedAssetList.OPENVIEW;
        FixedAssetCard.TRAP;
        FixedAssetList.FILTER.SETFILTER("No.", FixedAsset."No.");
        FixedAssetCard.OPENVIEW;
        FixedAssetCard.DepreciationBook.FILTER.SETFILTER("Depreciation Book Code", 'LOCAL');

        //HEI.07
    end;

    [Test]
    //[HandlerFunctions('ConfirmationHandler,MessageHandler,FALedgerEntriesPageHandler,PostingPageHandler')]//Bc Upgrade YADAVM09<<
    [HandlerFunctions('ConfirmationHandler,PostingPageHandler,FALedgerHandler')]//Bc Upgrade YADAVM09<<
    procedure "RTR089-AssetDisposalScrapping"();
    var
        GenJnlTemplates: TestPage "General Journal Templates";
        GenJournalBatches: TestPage "General Journal Batches";
        FixedAssetGLJournal: TestPage "Fixed Asset G/L Journal";
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        FixedAsset: Record "Fixed Asset";
        FixedAssetList: TestPage "Fixed Asset List";
        FixedAssetCard: TestPage "Fixed Asset Card";
        lFAPostingGroup: Record "FA Posting Group";
        lGLAcc: Record "G/L Account";
        lFAPostingGroup2: Record "FA Posting Group";
        RTR089_GLAcc: Record "G/L Account";
        WriteDownAcc: Code[20];
        WriteDownAccFound: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        DefaultDimension: Record "Default Dimension";
        lGenLedgSetUp: Record "General Ledger Setup";
        lEbfComb: Record "Ebf Combination FND";
        Dimensionvalue: Record "Dimension Value";
    begin
        //HEI.27>>
        //Update Dim Combination
        lGenLedgSetUp.GET;
        //HEI.40>>
        //HEI.41>>
        //Uncommented again
        lEbfComb.RESET;
        lEbfComb.SETCURRENTKEY("GL Account No.", "Dimension Code", "Dimension Value Code");
        lEbfComb.SETRANGE("Dimension Code", lGenLedgSetUp."Shortcut Dimension 2 Code");
        lEbfComb.SETFILTER("Combination Restriction", '%1|%2', lEbfComb."Combination Restriction"::"Allowed with Warn", lEbfComb."Combination Restriction"::"Not Allowed");
        lEbfComb.DELETEALL;
        //HEI.28>>
        //Update EBF Combination for Shortcut Dim 3
        lGenLedgSetUp.GET;
        lEbfComb.RESET;
        lEbfComb.SETCURRENTKEY("GL Account No.", "Dimension Code", "Dimension Value Code");
        lEbfComb.SETRANGE("Dimension Code", lGenLedgSetUp."Shortcut Dimension 3 Code");
        lEbfComb.SETFILTER("Combination Restriction", '%1|%2', lEbfComb."Combination Restriction"::"Allowed with Warn", lEbfComb."Combination Restriction"::"Not Allowed");
        lEbfComb.DELETEALL;
        //HEI.41<<
        //HEI.40<<
        //HEI.28<<

        DefaultDimension.RESET;
        DefaultDimension.SETRANGE("Table ID", 15);
        DefaultDimension.SETRANGE("Dimension Code", 'MVMT');
        DefaultDimension.SETFILTER("Value Posting", '<>%1', DefaultDimension."Value Posting"::" ");
        if DefaultDimension.FINDSET then begin
            //REPEAT//HEI.51
            //DefaultDimension."Value Posting":=DefaultDimension."Value Posting"::" ";//HEI.51
            DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::" ");//HEI.51
                                                                                               //UNTIL DefaultDimension.NEXT = 0;//HEI.51
        end;
        //HEI.27<<
        ClearVariables('RTR089'); //HEI.16
        //HEI.07
        //Get the FA Journal template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR089', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Get the FA Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR089', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        //Get the old FA
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR089', COMPANYNAME, DATABASE::"Fixed Asset");
        FixedAsset.GET(UnitTestingValues.Value);

        //HEI.21>>
        if lFAPostingGroup.GET(FixedAsset."FA Posting Group") then begin
            if lGLAcc.GET(lFAPostingGroup."Write-Down Account") then begin
                if lGLAcc.Blocked then begin
                    lGLAcc.Blocked := false;
                    lGLAcc.MODIFY;
                end;
            end
            //HEI.24>>
            else begin
                if lFAPostingGroup."Write-Down Account" = '' then begin
                    lFAPostingGroup2.RESET;
                    lFAPostingGroup2.SETFILTER("Write-Down Account", '<>%1', '');
                    if lFAPostingGroup2.FINDSET then begin
                        repeat
                            WriteDownAcc := '';
                            WriteDownAccFound := false;
                            RTR089_GLAcc.GET(lFAPostingGroup2."Write-Down Account");
                            if not RTR089_GLAcc.Blocked then begin
                                WriteDownAcc := RTR089_GLAcc."No.";
                                WriteDownAccFound := true;
                            end;
                        until (lFAPostingGroup2.NEXT = 0) or (WriteDownAccFound = true);
                        lFAPostingGroup."Write-Down Account" := WriteDownAcc;
                        lFAPostingGroup.MODIFY;
                    end;
                end
            end;
            //HEI.24<<
        end;
        //HEI.21<<


        //HEI.26>>
        lFAPostingGroup.RESET;
        lFAPostingGroup.SETFILTER("Acquisition Cost Account", '<>%1', '');
        if lFAPostingGroup.FINDSET(false) then begin
            repeat
                lGLAcc.GET(lFAPostingGroup."Acquisition Cost Account");
                if lGLAcc.Blocked then begin
                    lGLAcc.Blocked := false;
                    lGLAcc.MODIFY;
                end
            until lFAPostingGroup.NEXT = 0;
        end;
        lFAPostingGroup.RESET;
        lFAPostingGroup.SETFILTER("Accum. Depreciation Account", '<>%1', '');
        if lFAPostingGroup.FINDSET(false) then begin
            repeat
                lGLAcc.GET(lFAPostingGroup."Accum. Depreciation Account");
                if lGLAcc.Blocked then begin
                    lGLAcc.Blocked := false;
                    lGLAcc.MODIFY;
                end
            until lFAPostingGroup.NEXT = 0;
        end;

        //HEI.26<<

        //HEI.62>>
        GeneralLedgerSetup.GET;
        DefaultDimension.RESET;
        DefaultDimension.SETRANGE("Table ID", 5600);
        DefaultDimension.SETRANGE("No.", FixedAsset."No.");
        DefaultDimension.SETRANGE("Dimension Code", 'CAPEX');
        if DefaultDimension.FINDFIRST then begin
            Dimensionvalue.RESET;
            Dimensionvalue.SETRANGE("Dimension Code", 'CAPEX');
            Dimensionvalue.SETRANGE(Code, DefaultDimension."Dimension Value Code");
            if Dimensionvalue.FINDFIRST then begin
                if Dimensionvalue.Blocked then begin
                    Dimensionvalue.Blocked := false;
                    Dimensionvalue.MODIFY;
                end;
            end;
        end;
        //HEI.62<<
        //Open the Template
        GenJnlTemplates.OPENVIEW;
        GenJournalBatches.TRAP;
        //HEI.16>>
        //GenJnlTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GenJnlTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        GenJnlTemplates.Blocked.SETVALUE(0);//HEI.78
        //HEI.16<<
        //GenJnlTemplates."Page General Journal Batches".INVOKE;  //BC Upgrade KAPOOV01
        GenJnlTemplates.Batches.INVOKE;  //BC Upgrade KAPOOV01

        //Open the Batch
        FixedAssetGLJournal.TRAP;
        //HEI.16>>
        //GenJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GenJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<

        GenJournalBatches.EditJournal.INVOKE;

        //remove lines to be sure that only the lines we are going to post are inserted
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;


        //HEI.25>>
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            Workflow.SETRANGE(Enabled, true);
            if Workflow.FINDSET then
                //REPEAT//HEI.51
                //Workflow.Enabled := FALSE;//HEI.51
                Workflow.MODIFYALL(Workflow.Enabled, false);//HEI.51
                                                            // UNTIL Workflow.NEXT = 0;//HEI.51
        end;
        //HEI.25<<


        //insert new record
        FixedAssetGLJournal.NEW;
        FixedAssetGLJournal."Posting Date".SETVALUE(WORKDATE);
        if FixedAssetGLJournal."Document No.".VALUE = '' then//HEI.26
            FixedAssetGLJournal."Document No.".SETVALUE('Doc_RTR089');//HEI.24
        FixedAssetGLJournal."Account Type".SETVALUE(Type::"Fixed Asset");
        FixedAssetGLJournal."Account No.".SETVALUE(FixedAsset."No.");
        FixedAssetGLJournal."Depreciation Book Code".SETVALUE('LOCAL');
        FixedAssetGLJournal."FA Posting Type".SETVALUE(FAPostingType::"Write-Down");
        FixedAssetGLJournal.Description.SETVALUE('Test Script RTR089');
        FixedAssetGLJournal.Amount.SETVALUE(0);

        //Choose "Insert FA Bal. Account from "Home" menu.
        //FixedAssetGLJournal.Action107.INVOKE;

        //Select "Post" from "Home" menu
        //FixedAssetGLJournal.Action50.INVOKE; //BC Upgrade KAPOOV01
        FixedAssetGLJournal."P&ost".INVOKE; //BC Upgrade KAPOOV01

        //Go to Fixed Assets, search and display selected Fixed Asset
        FixedAssetList.OPENVIEW;
        FixedAssetCard.TRAP;
        FixedAssetCard.OPENVIEW;
        FixedAssetList.FILTER.SETFILTER("No.", FixedAsset."No.");

        //Go to Depreciation Books section and doube click on Book Value in Local Depreciation Book
        FixedAssetCard.DepreciationBook.FILTER.SETFILTER("Depreciation Book Code", 'LOCAL');
        //BC Upgrade KAPOOV01 replaced "Book Value" with BookValue >>
        //FixedAssetCard.DepreciationBook."Book Value".DRILLDOWN;
        FixedAssetCard.DepreciationBook.BookValue.DRILLDOWN;
        //BC Upgrade KAPOOV01 replaced "Book Value" with BookValue <<

        //HEI.07
    end;
    //Bc Upgrade YADAVM09>>
    [PageHandler]
    procedure FALedgerHandler(var FaLedger: TestPage "FA Ledger Entries")
    begin
        // Do nothing – this prevents the UI error
    end;
    //Bc Upgrade YADAVM09<<
    [Test]
    [HandlerFunctions('HeimatchReportHandler,ConfirmationHandler,MessageHandler')]
    procedure "RTR102-CreationOfHeiMatchFlatFile"();
    var
        HeiMatchExportInvBalance: Report "HeiMatch Export Inv. & Balance";
        RTR102_TXT001: Label 'Heimatch Flatfile Generation';
        RTR102_TXT002: Label 'Do you want to continue';
    begin
        //HEI.11>>
        CLEAR(HeiMatchExportInvBalance);
        //HEI.38>>
        MESSAGE(RTR102_TXT001);
        if CONFIRM(RTR102_TXT002, true) then;
        //HEI.38<<
        HeiMatchExportInvBalance.RUNMODAL;
        //HEI.11<<
    end;

    [Test]
    //[HandlerFunctions('SuggestWorksheetLinesReportHandler,ConfirmationHandler,MessageHandler')]//bc Upgrade YADAVM09<<
    [HandlerFunctions('ConfirmationHandler,MessageHandler,SuggestWorksheetRequestPagetHandler')]
    procedure "RTR104-CreationOfCashFlowPerLE"();
    var
        BankAccountPostingGroup: Record "Bank Account Posting Group";
        BankAccDetailTrialBal: Report "Bank Acc. - Detail Trial Bal.";
        lBankAccount: Record "Bank Account";
        lAccScheduleOverview: TestPage "Acc. Schedule Overview";
        AccScheduleName: Record "Acc. Schedule Name";
        lPageRun: Boolean;
        GLBalance: TestPage "G/L Balance";
        CashFlowWorksheet: TestPage "Cash Flow Worksheet";
        SuggestWorksheetLines: Report "Suggest Worksheet Lines";
        CashFlowForecast: Record "Cash Flow Forecast";
        OK: Boolean;
        ChartofCashFlowAccounts: TestPage "Chart of Cash Flow Accounts";
        CashFlowAccount: Record "Cash Flow Account";
        lAmtError: Label 'In Chart Of Cash Flow Accounts there are no records with Amount different that zero!';
    begin
        ClearVariables('RTR104'); //HEI.16
        //HEI.11>>
        CashFlowWorksheet.OPENEDIT;
        CashFlowWorksheet.SuggestWorksheetLines.INVOKE;

        UnitTestingValues.GET('RTR104', COMPANYNAME, DATABASE::"Cash Flow Forecast");
        CashFlowForecast.GET(UnitTestingValues.Value);
        //HEI.14>>
        //REPORT.RUNMODAL(REPORT::"Suggest Worksheet Lines",FALSE,FALSE,CashFlowForecast);
        REPORT.RUNMODAL(REPORT::"Suggest Worksheet Lines", true, false, CashFlowForecast);
        //HEI.14<<

        //OK := DIALOG.CONFIRM(CashFlowWorksheet.Register.INVOKE);
        CashFlowWorksheet.Register.INVOKE;

        //HEI.14>>
        /*
        CashFlowAccount.RESET;
        CashFlowAccount.CALCFIELDS(Amount);
        CashFlowAccount.SETFILTER(Amount,'<>%1',0);
        IF NOT CashFlowAccount.FINDFIRST THEN
          ERROR(lAmtError);
        */
        //HEI.14<<

        ChartofCashFlowAccounts.OPENVIEW;
        //HEI.14>>
        ChartofCashFlowAccounts.FILTER.SETFILTER(Amount, '<>0');
        //HEI.14<<
        //export to excel
        //commented because "Cannot create an instance of the following .NET Framework object"
        //HEI.11<<

    end;
    //Bc upgrade YADAVM09>>
    [RequestPageHandler]
    procedure SuggestWorksheetRequestPagetHandler(var Suggestworksheet: TestRequestPage SuggestWorksheetLinesHeiLite);
    begin

    end;

    //Bc Upgrade YADAVM09<<

    [Test]
    [HandlerFunctions('DetailTrialBalanceReportHandler,TrialBalanceReportHandler')]
    procedure "RTR105-CreationOfTrialBalancePerLE"();
    var
        BankAccountPostingGroup: Record "Bank Account Posting Group";
        BankAccDetailTrialBal: Report "Bank Acc. - Detail Trial Bal.";
        lBankAccount: Record "Bank Account";
        lAccScheduleOverview: TestPage "Acc. Schedule Overview";
        AccScheduleName: Record "Acc. Schedule Name";
        lPageRun: Boolean;
        GLBalance: TestPage "G/L Balance";
    begin
        ClearVariables('RTR105'); //HEI.16
        //HEI.11>>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR105', COMPANYNAME, DATABASE::"G/L Account");

        //run Detail Trial Balance
        GlAcc.RESET;
        GlAcc.SETFILTER("No.", UnitTestingValues.Value);
        GlAcc.SETFILTER("Date Filter", UnitTestingValues."Value 2");
        REPORT.RUNMODAL(REPORT::"Detail Trial Balance", false, false, GlAcc);

        //run Trial Balance
        GlAcc.RESET;
        GlAcc.SETFILTER("No.", UnitTestingValues.Value);
        GlAcc.SETFILTER("Date Filter", UnitTestingValues."Value 2");
        REPORT.RUNMODAL(REPORT::"Trial Balance", false, false, GlAcc);

        //get the Account schedule Name
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR105', COMPANYNAME, DATABASE::"Acc. Schedule Name");
        AccScheduleName.GET(UnitTestingValues.Value);

        /*lAccScheduleOverview.OPENVIEW;
        lAccScheduleOverview.CurrentSchedName.SETVALUE(AccScheduleName.Name);
        //export to excel
        //commented because "Cannot create an instance of the following .NET Framework object"
        //removed AccScheduleOverviewPageHandlerPageHandler from HandlerFunctions, from current function
        //if tested with Excel installed, the code below needs to be uncommented and AccScheduleOverviewPageHandlerPageHandler needs to be added to HandlerFunctions
        //lAccScheduleOverview.Action292.invoke;
        
        //run G/L Balance page
        GLBalance.OPENEDIT;
        GLBalance.ClosingEntryFilter.SETVALUE(1);
        GLBalance.PeriodType.SETVALUE(2);
        GLBalance.AmountType.SETVALUE(1);*/
        //HEI.11<<

    end;

    [Test]
    [HandlerFunctions('CustDetailTrialBalRequestPagetHandler,VendDetailTrialBalRequestPagetHandler,AgedAccountsReceivablesRequestPagetHandler,BankAccDetailTrialBalRequestPagetHandler,AgedAccountsPayableRequestPagetHandler,TrialBalanceByPeriodRequestPagetHandler,AccScheduleOverviewPageHandlerPageHandler')]
    procedure "RTR106-RunVariousStandardReports"();
    var
        AgedAccountsReceivable: Report "Aged Accounts Receivable";
        AgedAccountsPayable: Report "Aged Accounts Payable";
        BankAccDetailTrialBal: Report "Bank Acc. - Detail Trial Bal.";
        Customer: Record Customer;
        Vendor: Record Vendor;
        BankAccount: Record "Bank Account";
        BankAccountPostingGroup: Record "Bank Account Posting Group";
        TrialBalancebyPeriod: Report "Trial Balance by Period";
        AccountScheduleNames: TestPage "Account Schedule Names";
        AccScheduleName: Record "Acc. Schedule Name";
    begin
        ClearVariables('RTR106'); //HEI.16
        //HEI.09>>
        //get the Bank Acc. posting group
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR106', COMPANYNAME, DATABASE::"Bank Account Posting Group");
        BankAccountPostingGroup.GET(UnitTestingValues.Value);

        //get the Account schedule Name
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR106', COMPANYNAME, DATABASE::"Acc. Schedule Name");
        AccScheduleName.GET(UnitTestingValues.Value);

        //run report "Customer - Detail Trial Bal." - handled by function "CustDetailTrialBalRequestPageHandler"
        Customer.RESET;
        Customer.SETFILTER("Date Filter", 'P10');
        REPORT.RUNMODAL(REPORT::"Customer - Detail Trial Bal.", true, false, Customer);

        //run report "Aged Accounts Receivables" - handled by function "AgedAccountsReceivableslRequestPagetHandler"
        AgedAccountsReceivable.RUNMODAL;

        //run report "Vendor - Detail Trial Bal." - handled by function "VendDetailTrialBalRequestPagetHandler"
        Vendor.RESET;
        Vendor.SETFILTER("Date Filter", 'P10');
        REPORT.RUNMODAL(REPORT::"Vendor - Detail Trial Balance", true, false, Vendor);

        //run report "Aged Accounts Payable" - handled by function "AgedAccountsPayableRequestPagetHandler"
        AgedAccountsPayable.RUNMODAL;

        //Go to Search Bar and search for "Bank Acc. - Detail Trial Bal."
        BankAccount.RESET;
        BankAccount.SETFILTER("Bank Acc. Posting Group", BankAccountPostingGroup.Code);
        BankAccount.SETFILTER("Date Filter", 'P10');
        REPORT.RUNMODAL(REPORT::"Bank Acc. - Detail Trial Bal.", true, false, BankAccount);

        //Select "Trial Balance by Period" report
        GlAcc.RESET;
        GlAcc.SETFILTER("Date Filter", 'P10');
        REPORT.RUNMODAL(REPORT::"Trial Balance by Period", true, false, GlAcc);

        //Go to Search Bar and search for "Account Schedules"
        AccountScheduleNames.OPENVIEW;
        //HEI.16>>
        //AccountScheduleNames.FINDFIRSTFIELD(Name,AccScheduleName.Name);
        AccountScheduleNames.FILTER.SETFILTER(Name, AccScheduleName.Name);
        //HEI.16<<

        //Highlight "M-INCOME"and select "Overview" from "Home" menu.
        //AccountScheduleNames.Overview.INVOKE;  //BC Upgrade KAPOOV01 Action- Overview not available in Page-AccountScheduleNames

        //HEI.09<<
    end;

    [Test]
    procedure "RTR111-ReclassificationDepositsForPackaging"();
    var
        CustomerCard: TestPage "Customer Card";
        BalanceDisplayed: Boolean;
        FieldDisplayed: Boolean;
        Customer: Record Customer;
        DepositBalanceDisplayed: Boolean;
        lBalanceNotDisplayed: Label 'Balance (LCY) is not displayed on page';
        lDepositBalanceNotDisplayed: Label 'Deposit Balance (LCY) is not displayed on page';
        CustPostGrDisplayed: Boolean;
        lCustPostGrNotDisplayed: Label 'Customer Posting Group is not displayed on page';
        DepositCustPostGrDisplayed: Boolean;
        lDepositCustPostGrNotDisplayed: Label 'Deposit Customer Posting Group is not displayed on page';
    begin
        //HEI.11>>

        CustomerCard.OPENVIEW;
        BalanceDisplayed := CustomerCard."Balance (LCY)".VISIBLE;
        //DepositBalanceDisplayed := CustomerCard."Deposit Cust. Balance (LCY)".VISIBLE; //BC Upgrade KAPOOV01 DRINK-IT
        CustPostGrDisplayed := CustomerCard."Customer Posting Group".VISIBLE;
        //DepositCustPostGrDisplayed := CustomerCard."Deposit Cust. Posting Group".VISIBLE;  //BC Upgrade KAPOOV01 DRINK-IT

        if BalanceDisplayed = false then
            ERROR(lBalanceNotDisplayed);
        // if DepositBalanceDisplayed = false then//Bc Upgrade YADAVM09 Dependency on Drink it field<<
        //     ERROR(lDepositBalanceNotDisplayed);/Bc Upgrade YADAVM09 Dependency on Drink it field<<
        if CustPostGrDisplayed = false then
            ERROR(lCustPostGrNotDisplayed);
        // if DepositCustPostGrDisplayed = false then/Bc Upgrade YADAVM09 Dependency on Drink it field<<
        //     ERROR(lDepositCustPostGrNotDisplayed);/Bc Upgrade YADAVM09 Dependency on Drink it field<<
        //HEI.11<<
    end;

    [Test]
    [HandlerFunctions('CustomerTrialBalanceReportHandler,TrialBalanceReportHandler')]
    procedure "RTR116-ManualReconciliationARTrade"();
    var
        CustomerTrialBalance: Report "Customer - Trial Balance";
        CustPostingGroup: Record "Customer Posting Group";
        Customer: Record Customer;
    begin
        //HEI.08>>
        //Get the Customer Posting group
        CustPostingGroup.GET('3PC-TRADE');

        //run Customer - Trial Balance report - handled by function "CustomerTrialBalanceReportHandler"
        Customer.RESET;
        Customer.SETFILTER("Date Filter", 'P9');
        //Customer.SETFILTER("Customer Posting Group Filter", CustPostingGroup.Code); //BC Upgrade KAPOOV01 DRINK-IT
        REPORT.RUNMODAL(REPORT::"Customer - Trial Balance", false, false, Customer);

        //run Trial Balance
        CustPostingGroup.TESTFIELD("Receivables Account"); //this field is mandatory to be filled in to run the report
        GlAcc.RESET;
        GlAcc.SETFILTER("No.", CustPostingGroup."Receivables Account");
        GlAcc.SETFILTER("Date Filter", 'P9');
        REPORT.RUNMODAL(REPORT::"Trial Balance", false, false, GlAcc);

        //HEI.08<<
    end;

    [Test]
    [HandlerFunctions('vendorTrialBalanceReportHandler,TrialBalanceReportHandler')]
    procedure "RTR117-ManualReconciliationAPTrade"();
    var
        CustomerTrialBalance: Report "Customer - Trial Balance";
        CustPostingGroup: Record "Customer Posting Group";
        Customer: Record Customer;
        VendorPostingGroup: Record "Vendor Posting Group";
        Vendor: Record Vendor;
    begin
        //HEI.11>>
        //Get the Customer Posting group
        VendorPostingGroup.GET('3PV-TRADE');

        //run Vendor - Trial Balance report - handled by function "VendorTrialBalanceReportHandler"
        Vendor.RESET;
        Vendor.SETFILTER("Date Filter", 'P9');
        //Vendor.SETFILTER("Vendor Posting Group Filter", VendorPostingGroup.Code); //BC Upgrade KAPOOV01 DRINK-IT
        REPORT.RUNMODAL(REPORT::"Vendor - Trial Balance", false, false, Vendor);

        //run Trial Balance
        VendorPostingGroup.TESTFIELD("Payables Account"); //this field is mandatory to be filled in to run the report
        GlAcc.RESET;
        GlAcc.SETFILTER("No.", VendorPostingGroup."Payables Account");
        GlAcc.SETFILTER("Date Filter", 'P9');
        REPORT.RUNMODAL(REPORT::"Trial Balance", false, false, GlAcc);
        //HEI.11<<
    end;

    [Test]
    [HandlerFunctions('BankAccDetailTrialBalanceReportHandler,TrialBalanceReportHandler')]
    procedure "RTR118-ReconciliationOfPettyCash"();
    var
        BankAccountPostingGroup: Record "Bank Account Posting Group";
        BankAccDetailTrialBal: Report "Bank Acc. - Detail Trial Bal.";
        lBankAccount: Record "Bank Account";
        lText001: Label 'The Bank Account Posting Group was not found!';
    begin
        ClearVariables('RTR118'); //HEI.16
        //HEI.11>>
        BankAccountPostingGroup.RESET;
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR118', COMPANYNAME, DATABASE::"Bank Account Posting Group");
        //BankAccountPostingGroup.SETFILTER("G/L Bank Account No.", UnitTestingValues.Value); //BC Upgrade KAPOOV01 Blocked below code as field- "G/L Bank Account No." removed from Table-Bank Account Posting Group in BC 
        if not BankAccountPostingGroup.FINDFIRST then
            ERROR(lText001);

        lBankAccount.RESET;
        lBankAccount.SETFILTER("Bank Acc. Posting Group", BankAccountPostingGroup.Code);
        //lBankAccount.SETFILTER("Date Filter",'P9');//HEI.48
        lBankAccount.SETFILTER("Date Filter", FORMAT(TODAY - 1));//HEI.53
        REPORT.RUNMODAL(REPORT::"Bank Acc. - Detail Trial Bal.", false, false, lBankAccount);

        //run Trial Balance
        //BankAccountPostingGroup.TESTFIELD("G/L Bank Account No.");  //BC Upgrade KAPOOV01 Blocked below code as field- "G/L Bank Account No." removed from Table-Bank Account Posting Group in BC 
        GlAcc.RESET;
        //GlAcc.SETFILTER("No.", BankAccountPostingGroup."G/L Bank Account No."); //BC Upgrade KAPOOV01 Blocked below code as field- "G/L Bank Account No." removed from Table-Bank Account Posting Group in BC 
        GlAcc.SETFILTER("Date Filter", FORMAT(TODAY - 1));//HEI.53
        REPORT.RUNMODAL(REPORT::"Trial Balance", false, false, GlAcc);
        //HEI.11<<
    end;

    [Test]
    [HandlerFunctions('FATrialBalanceRequestPageHandler')]
    procedure "RTR121-ManualReconciliation"();
    var
        FAPostingGroup: Record "FA Posting Group";
        FixedAssetList: TestPage "Fixed Asset List";
        FixedAssetTrialBalance: Report "Fixed Asset-Trial Balance CBN";
    begin
        //HEI.08<<
        //Get the FA No.
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR121', COMPANYNAME, DATABASE::"Fixed Asset");
        FixedAsset.GET(UnitTestingValues.Value);

        //FixedAssetList.OPENVIEW;//HEI.51
        //FixedAssetList.FILTER.SETFILTER("No.",FixedAsset."No.");//HEI.51

        //run the report
        //REPORT.RUNMODAL(50013, true, false, FixedAsset); //BC Upgrade KAPOOV01 for old Report with ID-50013 new report ID is 51005
        REPORT.RUNMODAL(51005, true, false, FixedAsset); //BC Upgrade KAPOOV01 for old Report with ID-50013 new report ID is 51005

        //HEI.08>>
    end;

    [Test]
    [HandlerFunctions('GenLedgerEntriesPageHandler')]
    procedure "RTR122-CheckFilterSCOA"();
    var
        ChartofAccounts: TestPage "Chart of Accounts";
        GLAccountCard: TestPage "G/L Account Card";
    begin
        //HEI.08
        //Open Chart of Accounts

        ChartofAccounts.OPENVIEW;
        GLAccountCard.TRAP;
        ChartofAccounts.FILTER.SETFILTER("No.", '*14221*');

        //Open GL Account Card
        GLAccountCard.OPENVIEW;

        //Click on "Balance" of the G/L Account handled by function GenLedgerEntriesPageHandler
        GLAccountCard.Balance.DRILLDOWN;
        //HEI.08
    end;

    [Test]
    [HandlerFunctions('MessageHandler')]//Bc Upgrade YADAVM09<<   
    procedure "RTR123-CheckFilterCustomerOrVendorsWithDebitOrCreditBalance"();
    var
        CustomerList: TestPage "Customer List";
        VendorList: TestPage "Vendor List";
    begin
        //HEI.08>>
        //Open Customers page
        CustomerList.OPENVIEW;
        CustomerList.FILTER.SETFILTER(Balance, '<0');
        CustomerList.CLOSE;

        //Open Vendors page
        VendorList.OPENVIEW;
        VendorList.FILTER.SETFILTER(Balance, '>0');
        VendorList.CLOSE;

        //HEI.08<<
    end;

    [Test]
    [HandlerFunctions('RPMBalanceAccountinReportHandler')]
    procedure "RTR091-RPM_ReconcQuantitiesCheck"();
    var
        SalesSetup: Record "Sales & Receivables Setup";
        InventorySetup: Record "Inventory Setup";
        ItemList: TestPage "Item List";
        PostedSalesShipLines: TestPage "Posted Sales Shipment Lines";
        RPMBalanceAcc: Report "RPM Balance Accounting CBN";
        Customer: Record Customer;
        //ItemDepositGroup: Record "Drink Deposit Group";   //BC Upgrade KAPOOV01 Drink-IT Table-Drink Deposit Group
        AccountGroup: Record "Account Group FND";
        FAPostingGroup: Record "FA Posting Group";
        FAList: TestPage "Fixed Asset List";
    begin
        //HEI.10<<
        SalesSetup.GET;
        InventorySetup.GET;

        //1) get RPM report
        ItemList.OPENVIEW;
        ItemList.FILTER.SETFILTER("Item Category Code", SalesSetup."RPMRelatedItemCategoryCode FND");
        ItemList.CLOSE;

        //2)get finishded goods
        ItemList.OPENVIEW;
        ItemList.FILTER.SETFILTER("Item Category Code", InventorySetup."Finished Goods ItemCatCode FND");
        //ItemList.FILTER.SETFILTER("Item DDeposit Group Code", '04'); //BC Upgrade KAPOOV01 DRINK-IT
        ItemList.CLOSE;

        //3)Get a report of finished products delivered but not yet billed
        PostedSalesShipLines.OPENVIEW;
        PostedSalesShipLines.FILTER.SETFILTER("Item Category Code", InventorySetup."Finished Goods ItemCatCode FND");
        //PostedSalesShipLines.FILTER.SETFILTER("Item DDeposit Group Code", '04'); //BC Upgrade KAPOOV01 DRINK-IT
        PostedSalesShipLines.CLOSE;

        //3) Get a report of Sales/OTC report for RPM in the Market - handled by function "RPMBalanceAccountinReportHandler"
        Customer.RESET;
        Customer.SETRANGE("Account Group FND", 'Y001');
        REPORT.RUNMODAL(REPORT::"RPM Balance Accounting CBN", false, false, Customer);

        //4) How to get a report of RPM quanity as fixed assets
        FAList.OPENVIEW;
        FAList.FILTER.SETFILTER("FA Posting Group", 'PACK ITEMS');
        FAList.CLOSE;
        //HEI.10>>
    end;

    [Test]
    procedure "RTR096-ChangeLog_AssetAccountingChecks"();
    var
        ChangeLogEntries: TestPage "Change Log Entries";
        FixedAsset: Record "Fixed Asset";
    begin
        ClearVariables('RTR096'); //HEI.16
        //HEI.10<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR096', COMPANYNAME, DATABASE::"Fixed Asset");
        FixedAsset.GET(UnitTestingValues.Value);

        //Go to Search Bar and search for "Change Log Entries"
        ChangeLogEntries.OPENVIEW;

        //Put a filter on FA table "5600".
        ChangeLogEntries.FILTER.SETFILTER("Table No.", FORMAT(DATABASE::"Fixed Asset"));

        //Put a filter on specific FA number in column "Primary Key Field 1 Value ".
        ChangeLogEntries.FILTER.SETFILTER("Primary Key Field 1 Value", FixedAsset."No.");

        //HEI.10>>
    end;

    [Test]
    [HandlerFunctions('CurrencyPageHandler')]
    procedure "RTR109-ManualCurrencyExchangeRateUpdate"();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        Balance: Decimal;
        Amt: Decimal;
        DefaultDim: Record "Default Dimension";
        DimSetEntry: Record "Dimension Set Entry";
        Currency: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        //Currencies: TestPage "Finance Charge Terms"; //BC Upgrade KAPOOV01 Commented
        Currencies: TestPage Currencies; //BC Upgrade KAPOOV01 Added
        PageCurrency: TestPage "Currency Card";
        CurrencyExchangeRates: TestPage "Currency Exchange Rates";
    begin
        ClearVariables('RTR109'); //HEI.16
        //HEI.13>>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR109', COMPANYNAME, DATABASE::Currency);
        Currency.GET(UnitTestingValues.Value);

        Currencies.OPENVIEW;
        //HEI.16>>
        //Currencies.FINDFIRSTFIELD(Code,Currency.Code);
        Currencies.FILTER.SETFILTER(Code, Currency.Code);
        //HEI.16<<
        //Currencies."Page Currency Exchange Rates".INVOKE;//BC Upgrade KAPOOV01
        Currencies."Exch. &Rates".INVOKE;  //BC Upgrade KAPOOV01

        CurrencyExchangeRates.OPENNEW;
        CurrencyExchangeRates."Starting Date".SETVALUE(WORKDATE);
        CurrencyExchangeRates."Exchange Rate Amount".SETVALUE(1);
        CurrencyExchangeRates."Relational Exch. Rate Amount".SETVALUE(130);
        CurrencyExchangeRates."Adjustment Exch. Rate Amount".SETVALUE(1);
        CurrencyExchangeRates."Relational Adjmt Exch Rate Amt".SETVALUE(130);
        CurrencyExchangeRates.OK.INVOKE;
        //PageCurrency.OK.INVOKE;
        //HEI.13<<
    end;

    [PageHandler]
    procedure CurrencyPageHandler(var CurrencyExchangeRates: TestPage "Currency Exchange Rates");
    begin
    end;

    [Test]
    [HandlerFunctions('ExchangeRateReportHandlerManualRevaluationAR,GLEntriesPageHandler,MessageHandler')] //Bc Upgrade YADAVM09
    procedure "RTR112-ManualRevaluationAR"();
    var
        GLRegister: Record "G/L Register";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        GLRegisters: TestPage "G/L Registers";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
        CurrencyExchangeRates: TestPage "Currency Exchange Rates";
    begin
        //{HEI.76
        ClearVariables('RTR112'); //HEI.16
        //HEI.13>>
        AdjustExchangeRates4.RUN;
        AdjustExchangeRates5.RUN;

        //open GL Register page
        GLRegisters.OPENVIEW;

        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR112', COMPANYNAME, DATABASE::"G/L Register");
        //GLRegister.GET(UnitTestingValues.Value);
        //Filter by EXCHRATADJ in "Source code" column
        //GLRegisters.FILTER.SETFILTER("Creation Date",FORMAT(TODAY-1));//HEI.49
        GLRegisters.FILTER.SETFILTER("Source Code", UnitTestingValues.Value);
        GLRegisters.FILTER.SETFILTER("Journal Batch Name", UnitTestingValues."Value 2");
        //GLRegisters.FILTER.SETFILTER(Reversed,FORMAT(FALSE));

        //Mark the posted revaluation entry and choose "General Ledger Entries" from "Home" menu - will be handled by function "GLEntriesModalPageHandler"
        //GLRegisters."Codeunit G / L Reg.- Gen.Ledger".INVOKE; //BC Upgrade KAPOOV01
        GLRegisters."General Ledger".INVOKE; //BC Upgrade KAPOOV01

        //Mark the posted revaluation entry and choose "Reverse Register..." from "Home" menu. - will be handled by function
        //GLRegisters.ReverseRegister.INVOKE;

        //Confirm with "Yes" - done using Confirmationhandler

        //provide Reversal Date - done using ReversalDateModalPageHandler

        //confirmation done using MessageHandler
        //HEI.13<<
        //}//HEI.76
    end;

    [Test]
    // BC Upgrade KAPOOV01 removed ReverseEntriesModalPageHandler function as Page- "Reverse Entries" not available in BC >>
    //[HandlerFunctions('ExchangeRateReportHandler,GLEntriesPageHandler,ReverseEntriesModalPageHandler,ConfirmationHandler,ReversalDateModalPageHandler,MessageHandler,ExchangeRateReportHandlers')]
    [HandlerFunctions('ExchangeRateReportHandler,GLEntriesPageHandler,ConfirmationHandler,ReversalDateModalPageHandler,MessageHandler,ExchangeRateReportHandlers')]
    // BC Upgrade KAPOOV01 removed ReverseEntriesModalPageHandler function as Page- "Reverse Entries" not available in BC <<
    procedure "RTR114-RevaluationofTreasury"();
    var
        Currency: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        Currencies: TestPage "Finance Charge Terms";
        PageCurrency: TestPage "Currency Card";
        CurrencyExchangeRates: TestPage "Currency Exchange Rates";
        GLRegister: Record "G/L Register";
        GLRegisters: TestPage "G/L Registers";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
        //ReverseEntries: TestPage "Reverse Entries";  //BC Upgrade KAPOOV01 Page- "Reverse Entries" not available in BC
        RegisterFound: Boolean;
        GLEntry: Record "G/L Entry";
        ClosedEntry: Integer;
        RegisterNo: Integer;
        DimensionValue: Record "Dimension Value";
        DimensionSetEntry: Record "Dimension Set Entry";
        DefaultDimension: Record "Default Dimension";
    begin
        //HEI.28>>
        //{HEI.76
        DefaultDimension.RESET;
        DefaultDimension.SETRANGE("Table ID", 15);
        //DefaultDimension.SETRANGE("Dimension Code",'CHANNEL');//HEI.77
        DefaultDimension.SETFILTER("Dimension Code", '%1|%2', 'CHANNEL', 'MVMT');//HEI.77
        DefaultDimension.SETFILTER("Value Posting", '<>%1', DefaultDimension."Value Posting"::" ");
        if DefaultDimension.FINDSET then begin
            repeat
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.MODIFY;
            until DefaultDimension.NEXT = 0;
        end;
        //HEI.28<<
        ClearVariables('RTR112'); //HEI.16
        //HEI.13>>
        AdjustExchangeRates.RUN;
        AdjustExchangeRates3.RUN;

        //open GL Register page
        GLRegisters.OPENVIEW;
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR112', COMPANYNAME, DATABASE::"G/L Register");
        //GLRegister.GET(UnitTestingValues.Value);
        //Filter by EXCHRATADJ in "Source code" column.
        //HEI.16>>
        //GLRegisters.FILTER.SETFILTER("Source Code",UnitTestingValues.Value);
        //GLRegisters.FILTER.SETFILTER("Journal Batch Name",UnitTestingValues."Value 2");
        //GLRegisters.FILTER.SETFILTER(Reversed,FORMAT(FALSE));

        RegisterFound := false;
        GLRegister.SETRANGE("Source Code", UnitTestingValues.Value);
        GLRegister.SETRANGE("Journal Batch Name", UnitTestingValues."Value 2");
        GLRegister.SETRANGE(Reversed, false);
        if GLRegister.FINDSET then
            repeat
                ClosedEntry := 0;
                RegisterNo := 0;
                GLEntry.RESET;
                GLEntry.SETRANGE("Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");
                if GLEntry.FINDSET then begin
                    repeat
                        if not GLEntry."Open FND" then
                            ClosedEntry += 1;
                    until GLEntry.NEXT = 0;

                    if ClosedEntry = 0 then begin
                        RegisterFound := true;
                        RegisterNo := GLRegister."No.";
                    end;
                end;
            until (GLRegister.NEXT = 0) or RegisterFound;

        GLRegisters.FILTER.SETFILTER("No.", FORMAT(RegisterNo));

        //Unblock Dimension Values
        GLRegister.RESET;
        GLRegister.GET(RegisterNo);
        GLEntry.RESET;
        GLEntry.SETRANGE("Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");
        if GLEntry.FINDSET then
            repeat
                DimensionSetEntry.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                if DimensionSetEntry.FINDSET then
                    repeat
                        DimensionValue.GET(DimensionSetEntry."Dimension Code", DimensionSetEntry."Dimension Value Code");
                        if DimensionValue.Blocked then begin
                            DimensionValue.Blocked := false;
                            DimensionValue.MODIFY(true);
                        end;
                    until DimensionSetEntry.NEXT = 0;
            until GLEntry.NEXT = 0;
        //HEI.16<<

        //Mark the posted revaluation entry and choose "General Ledger Entries" from "Home" menu - will be handled by function "GLEntriesModalPageHandler"
        //GLRegisters."Codeunit G / L Reg.- Gen.Ledger".INVOKE; //BC Upgrade KAPOOV01
        GLRegisters."General Ledger".INVOKE;

        //Mark the posted revaluation entry and choose "Reverse Register..." from "Home" menu. - will be handled by function
        GLRegisters.ReverseRegister.INVOKE;

        //Confirm with "Yes" - done using Confirmationhandler

        //provide Reversal Date - done using ReversalDateModalPageHandler

        //confirmation done using MessageHandler
        //HEI.13<<
        //}//HEI.76
    end;

    [Test]
    // BC Upgrade KAPOOV01 removed ReverseEntriesModalPageHandler function as Page- "Reverse Entries" not available in BC >>
    //[HandlerFunctions('ExchangeRateReportHandlerManualRevaluationAR,GLEntriesPageHandler,ReverseEntriesModalPageHandler,ConfirmationHandler,ReversalDateModalPageHandler,MessageHandler,ExchangeRateReportHandlerManualRevaluationARs')]
    [HandlerFunctions('ExchangeRateReportHandlerManualRevaluationAR,GLEntriesPageHandler,ConfirmationHandler,ReversalDateModalPageHandler,MessageHandler,ExchangeRateReportHandlerManualRevaluationARs')]
    // BC Upgrade KAPOOV01 removed ReverseEntriesModalPageHandler function as Page- "Reverse Entries" not available in BC <<
    procedure "RTR113-RevaluationofAP"();
    var
        Currency: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        Currencies: TestPage "Finance Charge Terms";
        PageCurrency: TestPage "Currency Card";
        CurrencyExchangeRates: TestPage "Currency Exchange Rates";
        GLRegister: Record "G/L Register";
        GLRegisters: TestPage "G/L Registers";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
        //ReverseEntries: TestPage "Reverse Entries"; // // BC Upgrade KAPOOV01  Page- "Reverse Entries" not available in BC
        RegisterFound: Boolean;
        GLEntry: Record "G/L Entry";
        ClosedEntry: Integer;
        RegisterNo: Integer;
        DimensionValue: Record "Dimension Value";
        DimensionSetEntry: Record "Dimension Set Entry";
        DefaultDimension: Record "Default Dimension";
    begin
        //HEI.28>>
        //{//HEI.76
        DefaultDimension.RESET;
        DefaultDimension.SETRANGE("Table ID", 15);
        //DefaultDimension.SETRANGE("Dimension Code",'CHANNEL');//HEI.77
        DefaultDimension.SETFILTER("Dimension Code", '%1|%2', 'CHANNEL', 'MVMT');//HEI.77
        DefaultDimension.SETFILTER("Value Posting", '<>%1', DefaultDimension."Value Posting"::" ");
        if DefaultDimension.FINDSET then begin
            repeat
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.MODIFY;
            until DefaultDimension.NEXT = 0;
        end;
        //HEI.28<<
        ClearVariables('RTR112'); //HEI.16
        //HEI.13>>
        AdjustExchangeRates.RUN;
        AdjustExchangeRates5.RUN;

        //AdjustExchangeRates6.RUN;
        //AdjustExchangeRates2.RUN;

        //open GL Register page
        GLRegisters.OPENVIEW;

        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR112', COMPANYNAME, DATABASE::"G/L Register");
        //GLRegister.GET(UnitTestingValues.Value);
        //Filter by EXCHRATADJ in "Source code" column.
        //HEI.16>>
        //GLRegisters.FILTER.SETFILTER("Source Code",UnitTestingValues.Value);
        //GLRegisters.FILTER.SETFILTER("Journal Batch Name",UnitTestingValues."Value 2");
        //GLRegisters.FILTER.SETFILTER(Reversed,FORMAT(FALSE));

        RegisterFound := false;
        GLRegister.SETRANGE("Source Code", UnitTestingValues.Value);
        GLRegister.SETRANGE("Journal Batch Name", UnitTestingValues."Value 2");
        GLRegister.SETRANGE(Reversed, false);
        if GLRegister.FINDSET then
            repeat
                ClosedEntry := 0;
                RegisterNo := 0;
                GLEntry.RESET;
                GLEntry.SETRANGE("Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");
                if GLEntry.FINDSET then begin
                    repeat
                        if not GLEntry."Open FND" then
                            ClosedEntry += 1;
                    until GLEntry.NEXT = 0;

                    if ClosedEntry = 0 then begin
                        RegisterFound := true;
                        RegisterNo := GLRegister."No.";
                    end;
                end;
            until (GLRegister.NEXT = 0) or RegisterFound;

        GLRegisters.FILTER.SETFILTER("No.", FORMAT(RegisterNo));

        //Unblock Dimension Values
        GLRegister.RESET;
        GLRegister.GET(RegisterNo);
        GLEntry.RESET;
        GLEntry.SETRANGE("Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");
        if GLEntry.FINDSET then
            repeat
                DimensionSetEntry.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                if DimensionSetEntry.FINDSET then
                    repeat
                        DimensionValue.GET(DimensionSetEntry."Dimension Code", DimensionSetEntry."Dimension Value Code");
                        if DimensionValue.Blocked then begin
                            DimensionValue.Blocked := false;
                            DimensionValue.MODIFY(true);
                        end;
                    until DimensionSetEntry.NEXT = 0;
            until GLEntry.NEXT = 0;
        //HEI.16<<

        //Mark the posted revaluation entry and choose "General Ledger Entries" from "Home" menu - will be handled by function "GLEntriesModalPageHandler"
        //GLRegisters."Codeunit G / L Reg.- Gen.Ledger".INVOKE; //BC Upgrade KAPOOV01
        GLRegisters."General Ledger".INVOKE;

        //Mark the posted revaluation entry and choose "Reverse Register..." from "Home" menu. - will be handled by function
        GLRegisters.ReverseRegister.INVOKE;

        //Confirm with "Yes" - done using Confirmationhandler

        //provide Reversal Date - done using ReversalDateModalPageHandler

        //confirmation done using MessageHandler
        //HEI.13<<
        //}//HEI.76
    end;

    [Test]
    // BC Upgrade KAPOOV01 removed ReverseEntriesModalPageHandler function as Page- "Reverse Entries" not available in BC >>
    //[HandlerFunctions('ExchangeRateReportHandlerRevalAR_AP_Treasury,GLEntriesPageHandler,ReverseEntriesModalPageHandler,ConfirmationHandler,ReversalDateModalPageHandler,MessageHandler,ExchangeRateReportHandlerRevalAR_AP_Treasury2')]
    [HandlerFunctions('ExchangeRateReportHandlerRevalAR_AP_Treasury,GLEntriesPageHandler,ConfirmationHandler,ReversalDateModalPageHandler,MessageHandler,ExchangeRateReportHandlerRevalAR_AP_Treasury2')]
    // BC Upgrade KAPOOV01 removed ReverseEntriesModalPageHandler function as Page- "Reverse Entries" not available in BC <<
    procedure "RTR115-RevaluationofAR_AP_Treasury"();
    var
        Currency: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        Currencies: TestPage "Finance Charge Terms";
        PageCurrency: TestPage "Currency Card";
        CurrencyExchangeRates: TestPage "Currency Exchange Rates";
        GLRegister: Record "G/L Register";
        GLRegisters: TestPage "G/L Registers";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
        //ReverseEntries: TestPage "Reverse Entries"; // # Page- "Reverse Entries" not available in BC
        RegisterFound: Boolean;
        GLEntry: Record "G/L Entry";
        ClosedEntry: Integer;
        RegisterNo: Integer;
        DimensionValue: Record "Dimension Value";
        DimensionSetEntry: Record "Dimension Set Entry";
        DefaultDimension: Record "Default Dimension";
    begin
        //HEI.28>>
        //{//HEI.76
        DefaultDimension.RESET;
        DefaultDimension.SETCURRENTKEY("Table ID", "No.", "Dimension Code");//HEI.51
        DefaultDimension.SETRANGE("Table ID", 15);
        //DefaultDimension.SETRANGE("Dimension Code",'CHANNEL');//HEI.77
        DefaultDimension.SETFILTER("Dimension Code", '%1|%2', 'CHANNEL', 'MVMT');//HEI.77
        DefaultDimension.SETFILTER("Value Posting", '<>%1', DefaultDimension."Value Posting"::" ");
        if DefaultDimension.FINDSET then begin
            //REPEAT//HEI.51
            //DefaultDimension."Value Posting":=DefaultDimension."Value Posting"::" ";//HEI.51
            DefaultDimension.MODIFYALL(DefaultDimension."Value Posting", DefaultDimension."Value Posting"::" ");
            // UNTIL DefaultDimension.NEXT = 0;//HEI.51
        end;
        //HEI.28<<
        ClearVariables('RTR112'); //HEI.16
        //HEI.13>>
        AdjustExchangeRates6.RUN;
        AdjustExchangeRates2.RUN;

        GLRegisters.OPENVIEW;
        //open GL Register page
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR112', COMPANYNAME, DATABASE::"G/L Register");
        //GLRegister.GET(UnitTestingValues.Value);
        //Filter by EXCHRATADJ in "Source code" column.
        //HEI.16>>
        //GLRegisters.FILTER.SETFILTER("Source Code",UnitTestingValues.Value);
        //GLRegisters.FILTER.SETFILTER("Journal Batch Name",UnitTestingValues."Value 2");
        //GLRegisters.FILTER.SETFILTER(Reversed,FORMAT(FALSE));

        RegisterFound := false;
        GLRegister.RESET;//HEI.51
        GLRegister.SETCURRENTKEY("No.");//HEI.51
        GLRegister.SETRANGE("Source Code", UnitTestingValues.Value);
        GLRegister.SETRANGE("Journal Batch Name", UnitTestingValues."Value 2");
        //GLRegister.SETRANGE("Creation Date",TODAY-1);HEI.49
        GLRegister.SETRANGE(Reversed, false);
        if GLRegister.FINDSET then
            repeat
                ClosedEntry := 0;
                RegisterNo := 0;
                GLEntry.RESET;
                GLEntry.SETRANGE("Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");
                if GLEntry.FINDSET then begin
                    repeat//HEI.54
                        if not GLEntry."Open FND" then
                            //ClosedEntry := GLEntry.COUNT;//HEI.54
                            ClosedEntry += 1;//HEI.54
                    until GLEntry.NEXT = 0;//HEI.54

                    if ClosedEntry = 0 then begin
                        RegisterFound := true;
                        RegisterNo := GLRegister."No.";
                    end;
                end;
            until (GLRegister.NEXT = 0) or RegisterFound;

        GLRegisters.FILTER.SETFILTER("No.", FORMAT(RegisterNo));

        //Unblock Dimension Values
        GLRegister.RESET;
        GLRegister.GET(RegisterNo);
        GLEntry.RESET;
        GLEntry.SETCURRENTKEY("Entry No.");//HEI.51
        GLEntry.SETRANGE("Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");
        if GLEntry.FINDSET then
            repeat
                DimensionSetEntry.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                if DimensionSetEntry.FINDSET then
                    repeat
                        DimensionValue.GET(DimensionSetEntry."Dimension Code", DimensionSetEntry."Dimension Value Code");
                        if DimensionValue.Blocked then begin
                            DimensionValue.Blocked := false;
                            DimensionValue.MODIFY(true);
                        end;
                    until DimensionSetEntry.NEXT = 0;
            until GLEntry.NEXT = 0;
        //HEI.16<<

        //Mark the posted revaluation entry and choose "General Ledger Entries" from "Home" menu - will be handled by function "GLEntriesModalPageHandler"
        //GLRegisters."Codeunit G / L Reg.- Gen.Ledger".INVOKE; //BC Upgrade KAPOOV01
        GLRegisters."General Ledger".INVOKE;

        //Mark the posted revaluation entry and choose "Reverse Register..." from "Home" menu. - will be handled by function
        GLRegisters.ReverseRegister.INVOKE;

        //Confirm with "Yes" - done using Confirmationhandler

        //provide Reversal Date - done using ReversalDateModalPageHandler

        //confirmation done using MessageHandler
        //HEI.13<<
        //}//HEI.76
    end;

    [Test]
    [HandlerFunctions('ExportConsolidationRequestPageHandler,DimensionSelectionModalPageHandler')]
    procedure "RTR125-IntracompanyEliminationConsolidation"();
    var
        ExportConsolidation: Report "Export Consolidation";
    begin
        //HEI.12<<
        ExportConsolidation.RUNMODAL;
        //HEI.12>>
    end;

    [Test]
    [HandlerFunctions('CILReportHandler,AnalysisDimensionModalPageHandler,MessageHandler')]
    procedure "BPM042-Prepare_flatfile_for_CIL_reporting_EbF"();
    var
        AnalysisViewList: TestPage "Analysis View List";
        AnalysisbyDimensions: TestPage "Analysis by Dimensions";
        AnalysisbyDimensionsMatrix: TestPage "Analysis by Dimensions Matrix";
        CIL3ExportEBF: Report "CIL3 Export - EBF RTR";//Bc Upgrade YADAVM09,28.04.26<<
        AnalysisView: Record "Analysis View";
    begin
        ClearVariables('BPM042'); //HEI.16
        //HEI.13>>
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('BPM042', COMPANYNAME, DATABASE::"Analysis View");
        AnalysisView.GET(UnitTestingValues.Value);

        AnalysisViewList.OPENVIEW;
        //HEI.16>>
        //AnalysisViewList.FINDFIRSTFIELD(Code,AnalysisView.Code);
        AnalysisViewList.FILTER.SETFILTER(Code, AnalysisView.Code);
        //HEI.16>>
        AnalysisbyDimensions.TRAP;
        AnalysisViewList.EditAnalysis.INVOKE;
        //HEI.16>>
        //AnalysisbyDimensions.DateFilter.SETVALUE('010122D..022822D');
        AnalysisbyDimensions.DateFilter.SETVALUE(FORMAT(DMY2DATE(1, 1, 2022)) + '..' + FORMAT(DMY2DATE(28, 2, 2022)));
        //HEI.16<<
        AnalysisbyDimensions.ShowActualBudg.SETVALUE('Actual Amounts');

        AnalysisbyDimensionsMatrix.TRAP;
        AnalysisbyDimensionsMatrix.OPENVIEW;
        AnalysisbyDimensions.ShowMatrix.INVOKE;
        //AnalysisbyDimensionsMatrix.Action1000000000.INVOKE; //BC Upgrade KAPOOV01
        AnalysisbyDimensionsMatrix."Export to CIL3 EBF".INVOKE; //BC Upgrade KAPOOV01
        //SCIL3ExportEBF.SAVEASPDF('test123');
        //HEI.13<<
    end;

    [Test]
    [HandlerFunctions('AnalysisByDimPageHandler,AnalysisByDimMatrixModalPageHandler,FlatFileCIL3ICRequestPageHandler,MessageHandler')]
    procedure "RTR130-PrepareFlatFileCIL_Intercompany"();
    var
        AnalysisViewList: TestPage "Analysis View List";
    begin
        //HEI.12<<
        //Go to Search Bar and search for "Analysis by Dimensions"
        AnalysisViewList.OPENVIEW;

        //Mark dedicated Code (CIL IC) from Analysis List and choose "Edit Analysis View" from "Home" menu
        AnalysisViewList.FILTER.SETFILTER(Code, 'CIL IC');
        AnalysisViewList.EditAnalysis.INVOKE;

        //Click on "Show Matrix" in "Home" menu - done using handler "AnalysisByDimPageHandler"

        //Click on icon "Export to CIL 3" from the Navigate ribbon - done using handler "AnalysisByDimMatrixModalPageHandler"

        //HEI.12>>
    end;

    [Test]
    [HandlerFunctions('AnalysisByDimPageHandler,AnalysisByDimMatrixModalPageHandler,FlatFileCIL3ICRequestPageHandler,MessageHandler')]
    procedure "RTR131-PrepareFlatFileCIL_FC&R"();
    var
        AnalysisViewList: TestPage "Analysis View List";
    begin
        //HEI.12<<
        //Go to Search Bar and search for "Analysis by Dimensions"
        AnalysisViewList.OPENVIEW;

        //Mark dedicated Code (CIL IC) from Analysis List and choose "Edit Analysis View" from "Home" menu
        AnalysisViewList.FILTER.SETFILTER(Code, 'CIL3');
        AnalysisViewList.EditAnalysis.INVOKE;

        //Click on "Show Matrix" in "Home" menu - done using handler "AnalysisByDimPageHandler"

        //Click on icon "Export to CIL 3" from the Navigate ribbon - done using handler "AnalysisByDimMatrixModalPageHandler"
        //HEI.12<<
    end;

    [Test]
    [HandlerFunctions('AnalysisByDimPageHandler,AnalysisByDimMatrixModalPageHandler,FlatFileCIL3ICRequestPageHandler,MessageHandler')]
    procedure "RTR132-PrepareFlatFileCIL_FC&R-IS"();
    var
        AnalysisViewList: TestPage "Analysis View List";
    begin
        //HEI.12<<
        //Go to Search Bar and search for "Analysis by Dimensions"
        AnalysisViewList.OPENVIEW;

        //Mark dedicated Code (CIL IC) from Analysis List and choose "Edit Analysis View" from "Home" menu
        AnalysisViewList.FILTER.SETFILTER(Code, 'CIL3SM');
        AnalysisViewList.EditAnalysis.INVOKE;

        //Click on "Show Matrix" in "Home" menu - done using handler "AnalysisByDimPageHandler"

        //Click on icon "Export to CIL 3" from the Navigate ribbon - done using handler "AnalysisByDimMatrixModalPageHandler"
        //HEI.12<<
    end;

    [Test]
    [HandlerFunctions('PaymentBankAccountModalPageHandler,ConfirmationHandler,ApplyGeneralLedgerEntriesModalPageHandler')]
    procedure "RTR136-ManualMatching_SuspenseAccounts"();
    var
        PmtReconciliationJournals: TestPage "Pmt. Reconciliation Journals";
        PaymentBankAccountList: TestPage "Payment Bank Account List";
        BankAccountList: TestPage "Bank Account List";
        PaymentReconciliationJournal: TestPage "Payment Reconciliation Journal";
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalPage: TestPage "General Journal";
        Customer: Record Customer;
        DocumentNo: Code[30];
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        ChartofAccounts: TestPage "Chart of Accounts";
        GLAccountCard: TestPage "G/L Account Card";
        GeneralLedgerEntriesPage: TestPage "General Ledger Entries";
        WorkflowUserGroup: Record "Workflow User Group";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
        lGenLedgSetUp: Record "General Ledger Setup";
        lEbfComb: Record "Ebf Combination FND";
        DefaultDimension: Record "Default Dimension";
        UserGenJournalSetup: TestPage "User Gen. Journal Setup CBN";
        RecUserGenJournalSetup: Record "User Gen. Journal Setup FND";
    begin
        ClearVariables('RTR136'); //HEI.16
        //HEI.12>>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR136', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR136', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR136', COMPANYNAME, DATABASE::"G/L Account");
        GlAcc.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR136', COMPANYNAME, DATABASE::"Bank Account");
        BankAccount.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR136', COMPANYNAME, DATABASE::Customer);
        Customer.GET(UnitTestingValues.Value);

        //HEI.21>>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR136', COMPANYNAME, DATABASE::"Dimension Value");
        MVMTDimensionValue.GET(UnitTestingValues.Value, UnitTestingValues."Value 2");
        //HEI.21<<

        //HEI.28>>
        //Update EBF Combination for Shortcut Dim 2
        lGenLedgSetUp.GET;
        //HEI.40>>
        //HEI.41>>
        //Uncommented again
        lEbfComb.RESET;
        lEbfComb.SETCURRENTKEY("GL Account No.", "Dimension Code", "Dimension Value Code");
        lEbfComb.SETRANGE("Dimension Code", lGenLedgSetUp."Shortcut Dimension 2 Code");
        lEbfComb.SETFILTER("Combination Restriction", '%1|%2', lEbfComb."Combination Restriction"::"Allowed with Warn", lEbfComb."Combination Restriction"::"Not Allowed");
        lEbfComb.DELETEALL;
        //Update EBF Combination for Shortcut Dim 3
        lGenLedgSetUp.GET;
        lEbfComb.RESET;
        lEbfComb.SETCURRENTKEY("GL Account No.", "Dimension Code", "Dimension Value Code");
        lEbfComb.SETRANGE("Dimension Code", lGenLedgSetUp."Shortcut Dimension 3 Code");
        lEbfComb.SETFILTER("Combination Restriction", '%1|%2', lEbfComb."Combination Restriction"::"Allowed with Warn", lEbfComb."Combination Restriction"::"Not Allowed");
        lEbfComb.DELETEALL;
        //HEI.41<<
        //HEI.40<<
        DefaultDimension.RESET;
        DefaultDimension.SETRANGE("Table ID", 15);
        DefaultDimension.SETRANGE("Dimension Code", 'MVMT');
        DefaultDimension.SETFILTER("Value Posting", '<>%1', DefaultDimension."Value Posting"::" ");
        if DefaultDimension.FINDSET then begin
            //REPEAT//HEI.53
            DefaultDimension.MODIFYALL(DefaultDimension."Value Posting", DefaultDimension."Value Posting"::" ");//HEI.53
                                                                                                                //UNTIL DefaultDimension.NEXT = 0;//HEI.53
        end;
        //HEI.28<<

        //Step 1: Login

        //Step 2 - Go to Search Bar and search for "Payment Reconciliation Journals"
        PmtReconciliationJournals.OPENVIEW;

        //Step 3 - Click on "New Journal" button.
        PmtReconciliationJournals.NewJournal.INVOKE;

        //Step 4 - Select the required bank account no. in the payment bank account list and click OK
        // This is done using the ModalPageHandler PaymentBankAccountModalPageHandler

        //Step 5 -Create Payment Journal Rec. line
        PaymentReconciliationJnl.NEW;

        PaymentReconciliationJnl."Transaction Date".SETVALUE(WORKDATE);
        PaymentReconciliationJnl."Transaction Text".SETVALUE('Text Test Script RTR136');
        PaymentReconciliationJnl."Statement Amount".SETVALUE(1000);

        //Step 6 Enter account type = G/L account and Account No. = AP/AR suspense account
        PaymentReconciliationJnl."Account Type".SETVALUE('G/L Account');
        PaymentReconciliationJnl."Account No.".SETVALUE(GlAcc."No.");

        //Step 7 - Click on "Post payment and reconcile bank account"
        PaymentReconciliationJnl.Post.INVOKE;

        //Step 8 - Go to Search Bar and search for "Bank Account"
        BankAccountList.OPENVIEW;

        //Step 9 - Search for the previous bank account no. And click on Statements from the navigate ribbon
        //HEI.16>>
        //BankAccountList.FINDFIRSTFIELD("No.",BankAccount."No.");
        BankAccountList.FILTER.SETFILTER("No.", BankAccount."No.");
        //HEI.16<<
        BankAccountList.Statements.INVOKE;

        //Step 11 Go to Search Bar and search for "General Journal"
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE;   //BC Upgrade KAPOOV01
        GeneralJournalTemplates.Batches.INVOKE;

        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        //HEI.43>>
        UserGenJournalSetup.OPENNEW;
        //HEI.46>>
        RecUserGenJournalSetup.RESET;
        RecUserGenJournalSetup.SETCURRENTKEY("Journal Type", "User ID", "Gen. Journal Template Name");
        RecUserGenJournalSetup.SETFILTER("Journal Type", 'General');
        RecUserGenJournalSetup.SETFILTER("Gen. Journal Template Name", GenJournalTemplate.Name);
        if not RecUserGenJournalSetup.FINDFIRST then begin
            //HEI.46<<
            UserGenJournalSetup."Journal Type".VALUE := 'General';
            UserGenJournalSetup."User ID".VALUE := USERID;
            UserGenJournalSetup."Gen. Journal Template Name".VALUE := GenJournalTemplate.Name;//HEI.46
            UserGenJournalSetup.OK.INVOKE;
        end;//HEI.46
        //HEI.43<<
        GeneralJournalBatches.EditJournal.INVOKE;

        //Remove existing lines in Journal to avoid errors
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.DELETEALL;

        //Create Journal Line
        GenJournalPage.NEW;

        GenJournalPage."Source Code".SETVALUE(GenJournalTemplate."Source Code");
        GenJournalPage."Posting Date".SETVALUE(WORKDATE);
        GenJournalPage."Account Type".SETVALUE('Customer');
        GenJournalPage."Account No.".SETVALUE(Customer."No.");
        GenJournalPage.Description.SETVALUE('Unit Test RTR136');
        GenJournalPage.Amount.SETVALUE(1000);
        DocumentNo := GenJournalPage."Document No.".VALUE;
        GenJournalPage."Bal. Account Type".SETVALUE('G/L Account');
        GenJournalPage."Bal. Account No.".SETVALUE(GlAcc."No.");

        //HEI.16>>
        //Update Workflow User Groups
        UserSetup.FINDFIRST;

        if WorkflowUserGroup.FINDSET(false) then
            repeat
                WorkflowUserGroupMember.SETRANGE("Workflow User Group Code", WorkflowUserGroup.Code);
                WorkflowUserGroupMember.SETRANGE("Sequence No.", 2);
                if not WorkflowUserGroupMember.FINDFIRST then begin
                    WorkflowUserGroupMember.INIT;
                    WorkflowUserGroupMember."Workflow User Group Code" := WorkflowUserGroup.Code;
                    WorkflowUserGroupMember."User Name" := UserSetup."User ID";
                    WorkflowUserGroupMember.INSERT;
                end;
            until WorkflowUserGroup.NEXT = 0;
        //HEI.16<<

        //Step 10 - Send for approval
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            //HEI.16>>
            //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
            //WorkflowResponse.DELETE;
            //HEI.16<<
            //GenJournalPage.SendApprovalRequestJournalBatch.INVOKE;//HEI.60


            //Step 11 - Check if the posting batch was created and submitted for approval - Open the page to see the requests
            ApprovalEntries.TRAP;
            GenJournalPage.Approvals.INVOKE;

            //Step 12 - Approve the request
            //Update Substitute for Approver ID = USERID
            if UserSetup.GET(ApprovalEntries."Approver ID".VALUE) then begin
                UserSetup.Substitute := USERID;
                UserSetup.MODIFY;
            end;

            //Delegate Approval Request
            ApprovalEntries.FILTER.SETFILTER(Status, 'Open');
            // ApprovalEntries.Action35.INVOKE;

            //Approve Approval Entry
            GenJournalPage.Approve.INVOKE;

            //END ELSE//HEI.47
        end;
        //HEI.16>>
        //ERROR('No approval workflow is enabled.');
        //MESSAGE(ApprovalNotSentMsg);//HEI.47
        //HEI.16<<

        //GenJournalPage.Post.INVOKE;

        //Go to Search Bar and search for "Chart of Accounts"
        ChartofAccounts.OPENVIEW;

        //Go to the G/L card of the AP/AR Suspense account
        GLAccountCard.TRAP;
        ChartofAccounts.FILTER.SETFILTER("No.", GlAcc."No.");
        GLAccountCard.OPENEDIT;

        //Assign the proper application mode to the account in the Automatic Application section.
        GLAccountCard."Automatic application mode".SETVALUE('Selection Criteria');
        GLAccountCard."Same Amount".SETVALUE(true);

        //Click "Ledger entries" from the home tab of the ribbon of card
        //GLAccountCard."Page General Ledger Entries".INVOKE;
        GeneralLedgerEntriesPage.OPENVIEW;
        GeneralLedgerEntriesPage.FILTER.SETFILTER("G/L Account No.", GlAcc."No.");

        //Click on "Apply Entry" from the Actions tab of the card
        //GeneralLedgerEntriesPage.Action1000000000.INVOKE; //BC Upgrade KAPOOV01
        GeneralLedgerEntriesPage."Apply Entries".INVOKE; //BC Upgrade KAPOOV01


        //HEI.12<<
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandlerRTR119')]
    procedure "RTR138-ManualReconciliation_BankAccount"();
    var
        BankAccReconciliationList: TestPage "Bank Acc. Reconciliation List";
        BankAccReconciliation: TestPage "Bank Acc. Reconciliation";
        BankAccReconciliationLinesPage: TestPage "Bank Acc. Reconciliation Lines";
        BankAccountLedgerEntries: Record "Bank Account Ledger Entry";
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
        TempBankAccountLedgerEntries: Record "Bank Account Ledger Entry" temporary;
        MatchBankRecLines: Codeunit "Match Bank Rec. Lines";
        TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary;
        TotalAmt: Decimal;
        StatementEndBalanace: Decimal;
        lBankAccRecon: Record "Bank Acc. Reconciliation";
    begin
        ClearVariables('RTR138'); //HEI.16
        //HEI.12<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR138', COMPANYNAME, DATABASE::"Bank Account");
        BankAccount.GET(UnitTestingValues.Value);

        //Go to Search Bar and search for "Bank Account Reconciliation"
        BankAccReconciliationList.OPENVIEW;

        //Click on "New" button
        //BankAccReconciliationList.NEW; //HEI.16
        BankAccReconciliation.OPENNEW;

        //On the header
        BankAccReconciliation.BankAccountNo.SETVALUE(BankAccount."No.");
        BankAccReconciliation.StatementDate.SETVALUE(WORKDATE);

        //select all bank acc. ledger entries
        BankAccountLedgerEntries.RESET;
        BankAccountLedgerEntries.SETRANGE("Bank Account No.", BankAccount."No.");
        BankAccountLedgerEntries.SETRANGE(Open, true);
        BankAccountLedgerEntries.SETFILTER("Statement Status", '<>%1', BankAccountLedgerEntries."Statement Status"::Closed);
        if BankAccountLedgerEntries.FINDSET then
            repeat
                //HEI.16>>
                //IF NOT TempBankAccountLedgerEntries.GET(BankAccountLedgerEntries."Entry No.") THEN BEGIN
                //TempBankAccountLedgerEntries.INIT;
                //TempBankAccountLedgerEntries.TRANSFERFIELDS(BankAccountLedgerEntries);
                //TempBankAccountLedgerEntries.INSERT;
                //TotalAmt += TempBankAccountLedgerEntries.Amount;
                //END;
                TotalAmt += BankAccountLedgerEntries.Amount;
            //HEI.16<<
            until BankAccountLedgerEntries.NEXT = 0;

        //On the lines
        BankAccReconciliationLine.RESET;
        BankAccReconciliationLine.SETRANGE("Bank Account No.", BankAccount."No.");
        BankAccReconciliationLine.SETRANGE("Statement No.", BankAccReconciliation.StatementNo.VALUE);
        if not BankAccReconciliationLine.FINDFIRST then begin//HEI.50
                                                             //IF BankAccReconciliationLine.FINDFIRST THEN BEGIN//HEI.49
            BankAccReconciliationLine.INIT;
            BankAccReconciliationLine."Bank Account No." := BankAccount."No.";
            BankAccReconciliationLine."Statement No." := BankAccReconciliation.StatementNo.VALUE;
            BankAccReconciliationLine."Statement Type" := TempBankAccReconciliationLine."Statement Type"::"Bank Reconciliation";
            BankAccReconciliationLine."Transaction Date" := WORKDATE;
            //BankAccReconciliationLine.Type := TempBankAccReconciliationLine.Type::"Bank Account Ledger Entry"; //BC Upgrade KAPOOV01 Blocked below code as field- Type removed from Table-"Bank Acc. Reconciliation Line" in BC 
            BankAccReconciliationLine.Description := 'Test script RTR138';
            BankAccReconciliationLine."Statement Amount" := TotalAmt;
            BankAccReconciliationLine.INSERT;
        end;
        //HEI.27>>
        //BankAccReconciliation.StatementEndingBalance.SETVALUE(TotalAmt);
        lBankAccRecon.GET(lBankAccRecon."Statement Type"::"Bank Reconciliation", BankAccount."No.", BankAccReconciliation.StatementNo.VALUE);
        StatementEndBalanace := TotalAmt + lBankAccRecon."Balance Last Statement";
        BankAccReconciliation.StatementEndingBalance.SETVALUE(StatementEndBalanace);
        //HEI.27<<

        //Highlight on both sides lines that can be reconciled and click on "Match Manually" in the home Menu
        MatchBankRecLines.MatchManually(BankAccReconciliationLine, TempBankAccountLedgerEntries);

        //Click "Post" to post the bank account reconciliation.
        BankAccReconciliation.Post.INVOKE;
        //HEI.12<<
    end;

    [Test]
    [HandlerFunctions('NoSeriesPageHandler,SuggestWorksheetLinesRequestPageHandler')]
    procedure "RTR140-CashForecast_Preparation"();
    var
        CashFlowForecastList: TestPage "Cash Flow Forecast List";
        CashFlowWorksheet: TestPage "Cash Flow Worksheet";
    begin
        //HEI.12<<
        //Go to Search Bar and search for "Cash Flow Forecast"
        CashFlowForecastList.OPENVIEW;

        //Click on New
        CashFlowForecastList.NEW;

        //Fill in info
        CashFlowForecastCard.OPENNEW;
        CashFlowForecastCard."No.".ASSISTEDIT; //done using handler "NoSeriesPageHandler"
        CashFlowForecastCard.Description.SETVALUE('Cash Flow RTR140');
        //the fields Manual Payments from and G/L Budget from will be automatically filled in

        //Click on "Cash Flow Worksheet" from the home tab of the ribbon
        CashFlowWorksheet.TRAP;
        CashFlowForecastCard.CashFlowWorksheet.INVOKE;

        //Click on "Suggest Worksheet Lines" from the Home tab of the ribbon
        CashFlowWorksheet.SuggestWorksheetLines.INVOKE;

        //In the Options, enter the "Cash Flow Forecast" code created previously and click ok - using "SuggestWorksheetLinesRequestPageHandler"

        //HEI.12>>
    end;

    [Test]
    [HandlerFunctions('VATReportPageHandler')]
    procedure "RTR141-CreationofVATreport"();
    var
        VATStatement: Report "VAT Statement";
        VATStatementName: Record "VAT Statement Name";
    begin

        //HEI.13++
        VATStatementName.RESET;
        VATStatementName.SETRANGE("Statement Template Name", 'VAT');
        REPORT.RUN(12, true, false, VATStatementName);
        //HEI.13--
    end;

    [Test]
    [HandlerFunctions('VATReportPageHandler')]
    procedure "RTR145-Preparationwitholdingtaxdeclaration"();
    var
        VATStatement: Report "VAT Statement";
        VATStatementName: Record "VAT Statement Name";
    begin
        //HEI.13++
        VATStatementName.RESET;
        VATStatementName.SETRANGE("Statement Template Name", 'WHT');
        REPORT.RUN(12, true, false, VATStatementName);
        //HEI.13--
    end;

    [Test]
    [HandlerFunctions('PrepExcisedutyDeclarationReportPageHandler')]
    procedure "RTR147-Preparationexcisedutydeclaration"();
    var
        CustomerItemSalesExciseDuty: Report "Customer/Item Sales-ExciseDuty";
        ValueEntry: Record "Value Entry";
        Customer: Record Customer;
    begin
        //HEI.13++
        //Customer.RESET;//HEI.53
        //Customer.SETRANGE("Date Filter",CALCDATE('-CM',WORKDATE),CALCDATE('CM',WORKDATE));
        //Customer.SETRANGE("Date Filter",TODAY-1);//HEI.43//HEI.53

        //HEI.53>>
        ClearVariables('RTR088');
        //UnitTestingValues.RESET;//HEI.60
        //UnitTestingValues.GET('RTR088',COMPANYNAME,DATABASE::Customer);//HEI.60
        //Customer.GET(UnitTestingValues.Value);//HEI.55
        Customer.RESET;//HEI.55
        //Customer.SETRANGE("No.",UnitTestingValues.Value);//HEI.60
        Customer.SETRANGE("Date Filter", TODAY - 1);//HEI.53
        if Customer.FINDSET then//HEI.55
                                //HEI.53<<
                                //REPORT.RUN(50048, true, false, Customer);  //BC Upgrade KAPOOV01 For old Report with ID-50048 new report ID is 53009
            REPORT.RUN(53009, true, false, Customer); //BC Upgrade KAPOOV01 For old Report with ID-50048 new report ID is 53009

    end;

    [Test]
    [HandlerFunctions('AnalysisDimensionModalPageHandler,CILReportHandlerMSV,MessageHandler')]
    procedure "BPM043-Prepare_flatfile_for_CIL_reporting_MSV"();
    var
        AnalysisViewList: TestPage "Analysis View List";
        AnalysisbyDimensions: TestPage "Analysis by Dimensions";
        AnalysisbyDimensionsMatrix: TestPage "Analysis by Dimensions Matrix";
        CIL3ExportEBF: Report "CIL3 Export - EBF RTR";//Bc Upgrade YADAVM09,28.04.26<<
        AnalysisView: Record "Analysis View";
    begin
        ClearVariables('BPM042'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('BPM042', COMPANYNAME, DATABASE::"Analysis View");
        AnalysisView.GET(UnitTestingValues.Value);

        AnalysisViewList.OPENVIEW;
        //HEI..16>>
        //AnalysisViewList.FINDFIRSTFIELD(Code,AnalysisView.Code);
        AnalysisViewList.FILTER.SETFILTER(Code, AnalysisView.Code);
        //HEI.16<<
        AnalysisbyDimensions.TRAP;
        AnalysisViewList.EditAnalysis.INVOKE;
        AnalysisbyDimensions.DateFilter.SETVALUE(UnitTestingValues."Value 2");
        AnalysisbyDimensions.ShowActualBudg.SETVALUE('Actual Amounts');
        AnalysisbyDimensionsMatrix.TRAP;
        AnalysisbyDimensionsMatrix.OPENVIEW;
        AnalysisbyDimensions.ShowMatrix.INVOKE;
        //AnalysisbyDimensionsMatrix."Action1000000001".INVOKE; //BC Upgrade KAPOOV01 
        AnalysisbyDimensionsMatrix."Export to CIL3".INVOKE; //BC Upgrade KAPOOV01 
        //SCIL3ExportEBF.SAVEASPDF('test123');
        //HEI.13--
    end;

    [Test]
    [HandlerFunctions('AnalysisDimensionModalPageHandler,CILReportHandlerWIS,MessageHandler')]
    procedure "BPM044-Prepare_flatfile_for_CIL_reporting_WIS"();
    var
        AnalysisViewList: TestPage "Analysis View List";
        AnalysisbyDimensions: TestPage "Analysis by Dimensions";
        AnalysisbyDimensionsMatrix: TestPage "Analysis by Dimensions Matrix";
        CIL3ExportEBF: Report "CIL3 Export - EBF RTR";//Bc Upgrade YADAVM09,28.04.26<<
        AnalysisView: Record "Analysis View";
    begin
        ClearVariables('BPM042'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('BPM042', COMPANYNAME, DATABASE::"Analysis View");
        AnalysisView.GET(UnitTestingValues.Value);

        AnalysisViewList.OPENVIEW;
        //HEI.16>>
        //AnalysisViewList.FINDFIRSTFIELD(Code,AnalysisView.Code);
        AnalysisViewList.FILTER.SETFILTER(Code, AnalysisView.Code);
        //HEI.16<<
        AnalysisbyDimensions.TRAP;
        AnalysisViewList.EditAnalysis.INVOKE;
        AnalysisbyDimensions.DateFilter.SETVALUE(UnitTestingValues."Value 2");
        AnalysisbyDimensions.ShowActualBudg.SETVALUE('Actual Amounts');
        AnalysisbyDimensionsMatrix.TRAP;
        AnalysisbyDimensionsMatrix.OPENVIEW;
        AnalysisbyDimensions.ShowMatrix.INVOKE;
        //AnalysisbyDimensionsMatrix.Action1000000001.INVOKE; //BC Upgrade KAPOOV01 
        AnalysisbyDimensionsMatrix."Export to CIL3".INVOKE; //BC Upgrade KAPOOV01 
        //SCIL3ExportEBF.SAVEASPDF('test123');
        //HEI.13--
    end;

    [Test]
    [HandlerFunctions('VATDeclarationReportPageHandler,ConfirmationHandler')]
    procedure "RTR144-PreparationVATdeclaration"();
    var
        VATStatement: Report "VAT Statement";
        VATStatementName: Record "VAT Statement Name";
        VATStatementLine: Record "VAT Statement Line";
        VATStatementPage: TestPage "VAT Statement";
        CalcandPostVATSettlement: Report "Calc. and Post VAT Settlement";
        VATEntries: TestPage "Jobs Setup";
        VATStatementTemplateList: TestPage "Tax Area Line";
    begin
        //HEI.21>>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR144', COMPANYNAME, DATABASE::"G/L Account");
        GLAccRTR144.GET(UnitTestingValues.Value);
        //HEI.21<<
        //HEI.13

        CalcandPostVATSettlement.RUNMODAL;
        //REPORT.RUN(20,TRUE,FALSE);
        VATEntries.OPENVIEW;
        VATEntries.OK.INVOKE;
        //HEI.13--
    end;

    [Test]
    procedure "RTR050-BlockexistingSCOA"();
    var
        ChartofAccounts: TestPage "Chart of Accounts";
        GLAccountCard: TestPage "G/L Account Card";
    begin
        ClearVariables('RTR050'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('RTR050', COMPANYNAME, DATABASE::"G/L Account");

        ChartofAccounts.OPENEDIT;
        GLAccountCard.OPENEDIT;
        GLAccountCard.FILTER.SETFILTER("No.", UnitTestingValues.Value);
        GLAccountCard.Blocked.SETVALUE(false);
        GLAccountCard.OK.INVOKE;
        //HEI.13--
    end;

    [Test]
    procedure "RTR043-DisplayaccounttypeofSCOAAccount"();
    var
        ChartofAccounts: TestPage "Chart of Accounts";
        GLAccountCard: TestPage "G/L Account Card";
    begin
        ClearVariables('RTR050'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('RTR050', COMPANYNAME, DATABASE::"G/L Account");

        ChartofAccounts.OPENEDIT;
        GLAccountCard.OPENEDIT;
        GLAccountCard.FILTER.SETFILTER("No.", UnitTestingValues.Value);
        GLAccountCard."Financial Statement version".SETVALUE(GLAccountCard."Financial Statement version".GETOPTION(2));
        GLAccountCard.OK.INVOKE;
        //HEI.13--
    end;

    [Test]
    procedure "RTR068-DisplaySCOAAccountwithfilterbytimeframes"();
    var
        ChartofAccounts: TestPage "Chart of Accounts";
        GLAccountCard: TestPage "G/L Account Card";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
    begin
        ClearVariables('RTR050'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('RTR050', COMPANYNAME, DATABASE::"G/L Account");
        ChartofAccounts.OPENEDIT;
        GLAccountCard.OPENEDIT;
        GLAccountCard.FILTER.SETFILTER("No.", UnitTestingValues.Value);
        GeneralLedgerEntries.TRAP;
        GLAccountCard.Balance.DRILLDOWN;
        GeneralLedgerEntries.FILTER.SETFILTER("Posting Date", UnitTestingValues."Value 2");
        GLAccountCard.OK.INVOKE;
        //HEI.13--
    end;

    [Test]
    procedure "RTR044-DisplaylinktoCILofSCOAAccount"();
    var
        ChartofAccounts: TestPage "Chart of Accounts";
        GLAccountCard: TestPage "G/L Account Card";
    begin
        ClearVariables('RTR050'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('RTR050', COMPANYNAME, DATABASE::"G/L Account");

        ChartofAccounts.OPENEDIT;
        GLAccountCard.OPENEDIT;
        GLAccountCard.FILTER.SETFILTER("No.", UnitTestingValues.Value);
        GLAccountCard."CIL account".SETVALUE('1162000000');
        GLAccountCard.OK.INVOKE;
        //HEI.13--
    end;

    [Test]
    [HandlerFunctions('ChangeLogReviewofSCOAReportPageHandler')]
    procedure "RTR053-ChangeLogReviewofSCOAMasterDataChanges"();
    var
        ChartofAccounts: TestPage "Chart of Accounts";
        GLAccountCard: TestPage "G/L Account Card";
        ChangeLogEntriesPage: TestPage "Change Log Entries";
        ChangeLogEntries: Report "Change Log Entries";
        ChangeLogEntry: Record "Change Log Entry";
    begin
        ClearVariables('RTR050'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('RTR050', COMPANYNAME, DATABASE::"G/L Account");

        //ChangeLogEntriesPage.OPENEDIT;//HEI.51
        ChangeLogEntry.RESET;
        ChangeLogEntry.SETCURRENTKEY("Date and Time", "Table No.");//HEI.51
        ChangeLogEntry.SETFILTER("Date and Time", FORMAT(TODAY));//HEI.51
        ChangeLogEntry.SETRANGE("Table No.", 15);//HEI.51
        ChangeLogEntry.SETRANGE("Primary Key Field 1 Value", UnitTestingValues.Value);//HEI.51
        REPORT.RUN(509, true, false, ChangeLogEntry);
        //HEI.13--
    end;

    [Test]
    procedure "RTR067-DisplaySCOAAccountwithOpenCloseditems"();
    var
        ChartofAccounts: TestPage "Chart of Accounts";
        GLAccountCard: TestPage "G/L Account Card";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
    begin
        ClearVariables('RTR050'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('RTR050', COMPANYNAME, DATABASE::"G/L Account");

        ChartofAccounts.OPENEDIT;
        GLAccountCard.OPENEDIT;
        GLAccountCard.FILTER.SETFILTER("No.", UnitTestingValues.Value);
        GeneralLedgerEntries.TRAP;
        GLAccountCard.Balance.DRILLDOWN;
        GeneralLedgerEntries.FILTER.SETFILTER("Open FND", 'TRUE');
        GLAccountCard.OK.INVOKE;
        //HEI.13--
    end;

    [Test]
    [HandlerFunctions('DisplaySCOAChartofAccountsReportPageHandler')]
    procedure "RTR042-DisplaySCOAChartofAccounts"();
    var
        ChartofAccounts: TestPage "Chart of Accounts";
        GLAccountCard: TestPage "G/L Account Card";
        ChartofAccountsReport: Report "Chart of Accounts";
    begin
        //HEI.13++
        ChartofAccounts.OPENEDIT;
        ChartofAccountsReport.RUNMODAL;
        //HEI.13--
    end;

    [Test]
    [HandlerFunctions('CalculateandpostWiPReportPageHandler')]
    procedure "BPM013-CalculateandpostWiP"();
    var
        PostWIPtoGL: Report "Post WIP to GL CBN";
        lGenLedgSetUp: Record "General Ledger Setup";
        lGlAcc: Record "G/L Account";
        ProdOrderLine: Record "Prod. Order Line";
    begin
        //HEI.13++
        //PostWIPtoGL.RUNMODAL;//HEI.76
        //HEI.13--
        //HEI.76>>
        ProdOrderLine.RESET;
        ProdOrderLine.SETRANGE("Starting Date", CALCDATE('-60D', TODAY), TODAY);
        REPORT.RUNMODAL(50047, true, false, ProdOrderLine);
        //HEI.76<<
    end;

    [Test]
    procedure "RTR071-ReviewPayrollPostings"();
    var
        GeneralLedgerEntries: TestPage "General Ledger Entries";
    begin
        ClearVariables('RTR071'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('RTR071', COMPANYNAME, DATABASE::"G/L Entry");

        GeneralLedgerEntries.OPENEDIT;
        //GeneralLedgerEntries.FILTER.SETFILTER("User ID",'HEIWAY\ABOUAL01');
        GeneralLedgerEntries.FILTER.SETFILTER("Posting Date", FORMAT(TODAY - 1));//HEI.43
        GeneralLedgerEntries.FILTER.SETFILTER("User ID", UnitTestingValues.Value);
        //GeneralLedgerEntries.FILTER.SETFILTER("Posting Date",'P9');//HEI.43
        //GeneralLedgerEntries.FILTER.SETFILTER("Document No.",'RN00019522');
        GeneralLedgerEntries.FILTER.SETFILTER("Document No.", UnitTestingValues."Value 2");
        GeneralLedgerEntries.OK.INVOKE;
        //HEI.13--
    end;

    [Test]
    [HandlerFunctions('Checkbalancing7SeriesSCOAAccountsReportPageHandler')]
    procedure "RTR120-Checkbalancingof7seriesSCOAAccounts"();
    var
        TrialBalance: Report "Trial Balance";
        GLAccount: Record "G/L Account";
    begin
        ClearVariables('RTR105'); //HEI.16
        //HEI.13++
        //HEI.16>>
        UnitTestingValues.RESET;
        //UnitTestingValues.GET('RTR105',COMPANYNAME,DATABASE::"G/L Entry");
        UnitTestingValues.GET('RTR105', COMPANYNAME, DATABASE::"G/L Account");
        //HEI.16<<
        GLAccount.RESET;
        GLAccount.SETFILTER("No.", '7*');
        //GLAccount.SETFILTER("Date Filter",UnitTestingValues."Value 2");//HEI.42
        GLAccount.SETRANGE("Date Filter", TODAY - 30, TODAY);//HEI.42
        REPORT.RUN(6, true, false, GLAccount);
        //HEI.13--
    end;

    [Test]
    [HandlerFunctions('CalculateDepreciationHeinekenReportPageHandler,ConfirmationHandlerRTR119')]
    procedure "RTR119-CalculateDepreciation"();
    var
        CalculateDepreciation: Report "Calculate Depreciation";
        FixedAsset: Record "Fixed Asset";
        GenJournalLine: Record "Gen. Journal Line";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        FixedAssetGLJournal: TestPage "Fixed Asset G/L Journal";
        FAJnlSetup: Record "FA Journal Setup";
        FAJnlTemplate: Record "FA Journal Template";
        FAJnlBatch: Record "FA Journal Batch";
        FAGetJnl: Codeunit "FA Get Journal";
        TemplateName: Code[10];
        BatchName: Code[10];
    begin
        ClearVariables('RTR119'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('RTR119', COMPANYNAME, DATABASE::"Fixed Asset");
        //HEI.63>>
        if not FAJnlSetup.GET('HEINEKEN', USERID) then begin
            if FAJnlSetup.GET('HEINEKEN', '') then;//HEI.64
                                                   //FAJnlSetup.TESTFIELD("FA Jnl. Template Name");//HEI.64
                                                   //FAJnlSetup.TESTFIELD("FA Jnl. Batch Name");//HEI.64
            TemplateName := FAJnlSetup."FA Jnl. Template Name";
            BatchName := FAJnlSetup."FA Jnl. Batch Name";
            if not FAJnlTemplate.GET(TemplateName) then
                exit;
            if not FAJnlBatch.GET(TemplateName, BatchName) then
                exit;
        end;

        if not FAJnlSetup.GET('LOCAL', USERID) then begin
            if FAJnlSetup.GET('LOCAL', '') then;//HEI.64
                                                //FAJnlSetup.TESTFIELD("FA Jnl. Template Name");//HEI.64
                                                //FAJnlSetup.TESTFIELD("FA Jnl. Batch Name");//HEI.64
            TemplateName := FAJnlSetup."FA Jnl. Template Name";
            BatchName := FAJnlSetup."FA Jnl. Batch Name";
            if not FAJnlTemplate.GET(TemplateName) then
                exit;
            if not FAJnlBatch.GET(TemplateName, BatchName) then
                exit;
        end;

        //HEI.63<<
        FixedAsset.RESET;
        FixedAsset.SETRANGE("No.", UnitTestingValues.Value);
        //REPORT.RUN(5692, true, false, FixedAsset);  //Bc Upgrade YADAVM09
        REPORT.RUN(55048, true, false, FixedAsset);   //Bc Upgrade YADAVM09
        //HEI.13--
    end;

    [Test]
    procedure "RTR054-ClearingofGLAccountSelectionCriteria-Amount"();
    var
        ChartofAccounts: TestPage "Chart of Accounts";
        GLAccountCard: TestPage "G/L Account Card";
        ChartofAccountsReport: Report "Chart of Accounts";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
        ApplyGeneralLedgerEntries: TestPage "Apply Gen Ledger Entries CBN";
    begin
        ClearVariables('RTR054'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('RTR054', COMPANYNAME, DATABASE::"G/L Account");

        ChartofAccounts.OPENEDIT;
        GLAccountCard.OPENEDIT;
        GLAccountCard.FILTER.SETFILTER("No.", UnitTestingValues.Value);

        //GLAccountCard.FILTER.SETFILTER("No.",'14131001');
        GLAccountCard."Authorize other App. Modes".SETVALUE(true);//HEI.21
        GLAccountCard."Automatic application mode".SETVALUE('Selection Criteria');
        GLAccountCard."Same Amount".SETVALUE(true);

        GeneralLedgerEntries.TRAP;
        //GLAccountCard."Page General Ledger Entries".INVOKE; //BC Upgrade KAPOOV01
        GLAccountCard."Ledger E&ntries".INVOKE; //BC Upgrade KAPOOV01

        ApplyGeneralLedgerEntries.TRAP;
        if UnitTestingValues.Value <> '' then begin//HEI.72
            //GeneralLedgerEntries.Action1000000000.INVOKE; //BC Upgrade KAPOOV01
            GeneralLedgerEntries."Apply Entries".INVOKE; //BC Upgrade KAPOOV01
            //ApplyGeneralLedgerEntries."<Option>".SETVALUE('Sales Prepayment');//HEI.21;Commented under HEI.27
            //HEI.30>>
            //ApplyGeneralLedgerEntries."<Option>".SETVALUE('Selection Criteria');//HEI.27
            //HEI.32>>
            if UPPERCASE(COMPANYNAME) = UPPERCASE('BrewCo') then
                ApplyGeneralLedgerEntries."<Option>".SETVALUE('Selection Criteria')
            else
                ApplyGeneralLedgerEntries."<Option>".SETVALUE('Sales Prepayment');
            //HEI.32<<
            //HEI.30<<
            //ApplyGeneralLedgerEntries.Action1100710008.INVOKE; //BC Upgrade KAPOOV01
            ApplyGeneralLedgerEntries."&Automatic application".INVOKE; //BC Upgrade KAPOOV01
            if ApplyGeneralLedgerEntries."Applies-to ID".VALUE <> '' then//HEI.27
                //ApplyGeneralLedgerEntries.Action1010010.INVOKE; //BC Upgrade KAPOOV01
                ApplyGeneralLedgerEntries."Post Application".INVOKE; //BC Upgrade KAPOOV01
            ApplyGeneralLedgerEntries.IncludeEntryFilter.SETVALUE('Closed');
        end;//HEI.72
        //HEI.13--
    end;

    [Test]
    procedure "RTR055-ClearingGLAccSelectioncriteria-Remaining Amount"();
    var
        ChartofAccounts: TestPage "Chart of Accounts";
        GLAccountCard: TestPage "G/L Account Card";
        ChartofAccountsReport: Report "Chart of Accounts";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
        ApplyGeneralLedgerEntries: TestPage "Apply Gen Ledger Entries CBN";
    begin
        ClearVariables('RTR054'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('RTR054', COMPANYNAME, DATABASE::"G/L Account");

        ChartofAccounts.OPENEDIT;
        GLAccountCard.OPENEDIT;
        GLAccountCard.FILTER.SETFILTER("No.", UnitTestingValues.Value);

        //GLAccountCard.FILTER.SETFILTER("No.",'14131001');
        GLAccountCard."Authorize other App. Modes".SETVALUE(true);//HEI.21
        GLAccountCard."Automatic application mode".SETVALUE('Selection Criteria');
        GLAccountCard."Same Remaining Amount".SETVALUE(true);

        GeneralLedgerEntries.TRAP;
        //GLAccountCard."Page General Ledger Entries".INVOKE;  //BC Upgrade KAPOOV01
        GLAccountCard."Ledger E&ntries".INVOKE;  //BC Upgrade KAPOOV01

        ApplyGeneralLedgerEntries.TRAP;
        if UnitTestingValues.Value <> '' then begin//HEI.72
            //GeneralLedgerEntries.Action1000000000.INVOKE; //BC Upgrade KAPOOV01
            GeneralLedgerEntries."Apply Entries".INVOKE; //BC Upgrade KAPOOV01
            //ApplyGeneralLedgerEntries."<Option>".SETVALUE('Sales Prepayment');//HEI.21;Commented under HEI.27
            //HEI.30>>
            //ApplyGeneralLedgerEntries."<Option>".SETVALUE('Selection Criteria');//HEI.27
            //HEI.32>>
            if UPPERCASE(COMPANYNAME) = UPPERCASE('BrewCo') then
                ApplyGeneralLedgerEntries."<Option>".SETVALUE('Selection Criteria')
            else
                ApplyGeneralLedgerEntries."<Option>".SETVALUE('Sales Prepayment');
            //HEI.32<<
            //HEI.30<<
            //ApplyGeneralLedgerEntries.Action1100710008.INVOKE; //BC Upgrade KAPOOV01
            ApplyGeneralLedgerEntries."&Automatic application".INVOKE; //BC Upgrade KAPOOV01
            if ApplyGeneralLedgerEntries."Applies-to ID".VALUE <> '' then//HEI.27
                //ApplyGeneralLedgerEntries.Action1010010.INVOKE; //BC Upgrade KAPOOV01
                ApplyGeneralLedgerEntries."Post Application".INVOKE; //BC Upgrade KAPOOV01
            ApplyGeneralLedgerEntries.IncludeEntryFilter.SETVALUE('Closed');
        end;//HEI.72
        //HEI.13--
    end;

    [Test]
    procedure "RTR056-ClearingGLAccselectioncriteriaExternalDocumentNo"();
    var
        ChartofAccounts: TestPage "Chart of Accounts";
        GLAccountCard: TestPage "G/L Account Card";
        ChartofAccountsReport: Report "Chart of Accounts";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
        ApplyGeneralLedgerEntries: TestPage "Apply Gen Ledger Entries CBN";
        TotalBalanced: Text;
    begin
        ClearVariables('RTR054'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('RTR054', COMPANYNAME, DATABASE::"G/L Account");

        ChartofAccounts.OPENEDIT;
        GLAccountCard.OPENEDIT;
        GLAccountCard.FILTER.SETFILTER("No.", UnitTestingValues.Value);

        //GLAccountCard.FILTER.SETFILTER("No.",'14131001');
        GLAccountCard."Authorize other App. Modes".SETVALUE(true);//HEI.21
        GLAccountCard."Automatic application mode".SETVALUE('Selection Criteria');
        GLAccountCard."Same External Document No.".SETVALUE(true);

        GeneralLedgerEntries.TRAP;
        //GLAccountCard."Page General Ledger Entries".INVOKE; //BC Upgrade KAPOOV01
        GLAccountCard."Ledger E&ntries".INVOKE; //BC Upgrade KAPOOV01

        ApplyGeneralLedgerEntries.TRAP;
        if UnitTestingValues.Value <> '' then begin//HEI.72
            //GeneralLedgerEntries.Action1000000000.INVOKE; //BC Upgrade KAPOOV01
            GeneralLedgerEntries."Apply Entries".INVOKE; //BC Upgrade KAPOOV01
            //ApplyGeneralLedgerEntries."<Option>".SETVALUE('Sales Prepayment');//HEI.21;Commented under HEI.27
            //HEI.30>>
            //ApplyGeneralLedgerEntries."<Option>".SETVALUE('Selection Criteria');//HEI.27
            //HEI.32>>
            if UPPERCASE(COMPANYNAME) = UPPERCASE('BrewCo') then
                ApplyGeneralLedgerEntries."<Option>".SETVALUE('Selection Criteria')
            else
                ApplyGeneralLedgerEntries."<Option>".SETVALUE('Sales Prepayment');
            //HEI.32<<
            //HEI.30<<
            //ApplyGeneralLedgerEntries.Action1100710008.INVOKE; //BC Upgrade KAPOOV01
            ApplyGeneralLedgerEntries."&Automatic application".INVOKE; //BC Upgrade KAPOOV01
            if ApplyGeneralLedgerEntries."Applies-to ID".VALUE <> '' then begin//HEI.66
                                                                               //IF ApplyGeneralLedgerEntries.Amount.VALUE <> ApplyGeneralLedgerEntries."Remaining Amount".VALUE THEN//HEI.66
                                                                               // EXIT;//HEI.66
                                                                               //HEI.67>>
                TotalBalanced += FORMAT(ApplyGeneralLedgerEntries."Remaining Amount".VALUE);
                if TotalBalanced <> FORMAT(0) then
                    exit;
                //HEI.67<<
                //ApplyGeneralLedgerEntries.Action1010010.INVOKE; //BC Upgrade KAPOOV01
                ApplyGeneralLedgerEntries."Post Application".INVOKE; //BC Upgrade KAPOOV01
            end;//HEI.66
            ApplyGeneralLedgerEntries.IncludeEntryFilter.SETVALUE('Closed');
        end;//HEI.72
        //HEI.13--
    end;

    [Test]
    procedure "RTR057-ClearingGLAccselectioncriteriaDocumentNo"();
    var
        ChartofAccounts: TestPage "Chart of Accounts";
        GLAccountCard: TestPage "G/L Account Card";
        ChartofAccountsReport: Report "Chart of Accounts";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
        ApplyGeneralLedgerEntries: TestPage "Apply Gen Ledger Entries CBN";
        TotalBalanced: Text;
    begin
        ClearVariables('RTR054'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('RTR054', COMPANYNAME, DATABASE::"G/L Account");
        ChartofAccounts.OPENEDIT;
        GLAccountCard.OPENEDIT;
        GLAccountCard.FILTER.SETFILTER("No.", UnitTestingValues.Value);

        //GLAccountCard.FILTER.SETFILTER("No.",'14131001');
        GLAccountCard."Authorize other App. Modes".SETVALUE(true);//HEI.21
        GLAccountCard."Automatic application mode".SETVALUE('Selection Criteria');
        GLAccountCard."Same Document No.".SETVALUE(true);

        GeneralLedgerEntries.TRAP;
        //GLAccountCard."Page General Ledger Entries".INVOKE; //BC Upgrade KAPOOV01
        GLAccountCard."Ledger E&ntries".INVOKE; //BC Upgrade KAPOOV01

        ApplyGeneralLedgerEntries.TRAP;
        if UnitTestingValues.Value <> '' then begin//HEI.72
            //GeneralLedgerEntries.Action1000000000.INVOKE; //BC Upgrade KAPOOV01
            GeneralLedgerEntries."Apply Entries".INVOKE; //BC Upgrade KAPOOV01
            //ApplyGeneralLedgerEntries."<Option>".SETVALUE('Sales Prepayment');//HEI.21;Commented under HEI.27
            //HEI.30>>
            //ApplyGeneralLedgerEntries."<Option>".SETVALUE('Selection Criteria');//HEI.27
            //HEI.32>>
            if UPPERCASE(COMPANYNAME) = UPPERCASE('BrewCo') then
                ApplyGeneralLedgerEntries."<Option>".SETVALUE('Selection Criteria')
            else
                ApplyGeneralLedgerEntries."<Option>".SETVALUE('Sales Prepayment');
            //HEI.32<<
            //HEI.30<<
            //ApplyGeneralLedgerEntries.Action1100710008.INVOKE; //BC Upgrade KAPOOV01
            ApplyGeneralLedgerEntries."&Automatic application".INVOKE; //BC Upgrade KAPOOV01
            if ApplyGeneralLedgerEntries."Applies-to ID".VALUE <> '' then begin//HEI.66
                                                                               //  IF ApplyGeneralLedgerEntries.Amount.VALUE <> ApplyGeneralLedgerEntries."Remaining Amount".VALUE THEN//HEI.66
                                                                               // EXIT;//HEI.66
                                                                               //HEI.67>>
                TotalBalanced += FORMAT(ApplyGeneralLedgerEntries."Remaining Amount".VALUE);
                if TotalBalanced <> FORMAT(0) then
                    exit;
                //HEI.67<<
                //ApplyGeneralLedgerEntries.Action1010010.INVOKE; //BC Upgrade KAPOOV01
                ApplyGeneralLedgerEntries."Post Application".INVOKE; //BC Upgrade KAPOOV01
            end;//HEI.66
            ApplyGeneralLedgerEntries.IncludeEntryFilter.SETVALUE('Closed');
        end;//HEI.72
        //HEI.13--
    end;

    [Test]
    procedure "RTR058-ClearingGLAccselectioncriteriaAmountorDocumentNo"();
    var
        ChartofAccounts: TestPage "Chart of Accounts";
        GLAccountCard: TestPage "G/L Account Card";
        ChartofAccountsReport: Report "Chart of Accounts";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
        ApplyGeneralLedgerEntries: TestPage "Apply Gen Ledger Entries CBN";
    begin
        ClearVariables('RTR054'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('RTR054', COMPANYNAME, DATABASE::"G/L Account");

        ChartofAccounts.OPENEDIT;
        GLAccountCard.OPENEDIT;
        GLAccountCard.FILTER.SETFILTER("No.", UnitTestingValues.Value);

        //GLAccountCard.FILTER.SETFILTER("No.",'14131001');
        GLAccountCard."Authorize other App. Modes".SETVALUE(true);//HEI.21
        GLAccountCard."Automatic application mode".SETVALUE('Selection Criteria');
        GLAccountCard."Same Amount".SETVALUE(true);
        GLAccountCard."Same Document No.".SETVALUE(true);

        GeneralLedgerEntries.TRAP;
        if UnitTestingValues.Value <> '' then begin//HEI.72
            //GLAccountCard."Page General Ledger Entries".INVOKE; //BC Upgrade KAPOOV01
            GLAccountCard."Ledger E&ntries".INVOKE; //BC Upgrade KAPOOV01

            ApplyGeneralLedgerEntries.TRAP;
            //GeneralLedgerEntries.Action1000000000.INVOKE; //BC Upgrade KAPOOV01
            GeneralLedgerEntries."Apply Entries".INVOKE; //BC Upgrade KAPOOV01
            //ApplyGeneralLedgerEntries."<Option>".SETVALUE('Sales Prepayment');//HEI.21;Commented under HEI.27
            //HEI.30>>
            //ApplyGeneralLedgerEntries."<Option>".SETVALUE('Selection Criteria');//HEI.27
            //HEI.32>>
            if UPPERCASE(COMPANYNAME) = UPPERCASE('BrewCo') then
                ApplyGeneralLedgerEntries."<Option>".SETVALUE('Selection Criteria')
            else
                ApplyGeneralLedgerEntries."<Option>".SETVALUE('Sales Prepayment');
            //HEI.32<<
            //HEI.30<<
            //ApplyGeneralLedgerEntries.Action1100710008.INVOKE; //BC Upgrade KAPOOV01
            ApplyGeneralLedgerEntries."&Automatic application".INVOKE; //BC Upgrade KAPOOV01
            if ApplyGeneralLedgerEntries."Applies-to ID".VALUE <> '' then//HEI.27
                //ApplyGeneralLedgerEntries.Action1010010.INVOKE; //BC Upgrade KAPOOV01
                ApplyGeneralLedgerEntries."Post Application".INVOKE; //BC Upgrade KAPOOV01
            ApplyGeneralLedgerEntries.IncludeEntryFilter.SETVALUE('Closed');
        end;//HEI.72
        //HEI.13--
    end;

    [Test]
    procedure "RTR059-ClearingGLAccselectioncriteriaAmountOrExternalDocumentNo"();
    var
        ChartofAccounts: TestPage "Chart of Accounts";
        GLAccountCard: TestPage "G/L Account Card";
        ChartofAccountsReport: Report "Chart of Accounts";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
        ApplyGeneralLedgerEntries: TestPage "Apply Gen Ledger Entries CBN";
    begin
        ClearVariables('RTR054'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('RTR054', COMPANYNAME, DATABASE::"G/L Account");

        ChartofAccounts.OPENEDIT;
        GLAccountCard.OPENEDIT;
        GLAccountCard.FILTER.SETFILTER("No.", UnitTestingValues.Value);

        //GLAccountCard.FILTER.SETFILTER("No.",'14131001');
        GLAccountCard."Authorize other App. Modes".SETVALUE(true);//HEI.21
        GLAccountCard."Automatic application mode".SETVALUE('Selection Criteria');
        GLAccountCard."Same Amount".SETVALUE(true);
        GLAccountCard."Same External Document No.".SETVALUE(true);

        GeneralLedgerEntries.TRAP;
        //GLAccountCard."Page General Ledger Entries".INVOKE; //BC Upgrade KAPOOV01
        GLAccountCard."Ledger E&ntries".INVOKE; //BC Upgrade KAPOOV01

        ApplyGeneralLedgerEntries.TRAP;
        if UnitTestingValues.Value <> '' then begin//HEI.72
            //GeneralLedgerEntries.Action1000000000.INVOKE; //BC Upgrade KAPOOV01
            GeneralLedgerEntries."Apply Entries".INVOKE; //BC Upgrade KAPOOV01
            //ApplyGeneralLedgerEntries."<Option>".SETVALUE('Sales Prepayment');//HEI.21;Commented under HEI.27
            //HEI.30>>
            //ApplyGeneralLedgerEntries."<Option>".SETVALUE('Selection Criteria');//HEI.27
            //HEI.32>>
            if UPPERCASE(COMPANYNAME) = UPPERCASE('BrewCo') then
                ApplyGeneralLedgerEntries."<Option>".SETVALUE('Selection Criteria')
            else
                ApplyGeneralLedgerEntries."<Option>".SETVALUE('Sales Prepayment');
            //HEI.32<<
            //HEI.30<<
            //ApplyGeneralLedgerEntries.Action1100710008.INVOKE; //BC Upgrade KAPOOV01
            ApplyGeneralLedgerEntries."&Automatic application".INVOKE; //BC Upgrade KAPOOV01
            if ApplyGeneralLedgerEntries."Applies-to ID".VALUE <> '' then//HEI.27
                //ApplyGeneralLedgerEntries.Action1010010.INVOKE; //BC Upgrade KAPOOV01
                ApplyGeneralLedgerEntries."Post Application".INVOKE; //BC Upgrade KAPOOV01
            ApplyGeneralLedgerEntries.IncludeEntryFilter.SETVALUE('Closed');
        end;//HEI.72
        //HEI.13--
    end;

    [Test]
    procedure "RTR060-ClearingGLAccselectioncriteriaAmtExternalDocOrDocumentNo"();
    var
        ChartofAccounts: TestPage "Chart of Accounts";
        GLAccountCard: TestPage "G/L Account Card";
        ChartofAccountsReport: Report "Chart of Accounts";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
        ApplyGeneralLedgerEntries: TestPage "Apply Gen Ledger Entries CBN";
    begin
        ClearVariables('RTR054'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('RTR054', COMPANYNAME, DATABASE::"G/L Account");

        ChartofAccounts.OPENEDIT;
        GLAccountCard.OPENEDIT;
        GLAccountCard.FILTER.SETFILTER("No.", UnitTestingValues.Value);

        //GLAccountCard.FILTER.SETFILTER("No.",'14131001');
        GLAccountCard."Authorize other App. Modes".SETVALUE(true);//HEI.21
        GLAccountCard."Automatic application mode".SETVALUE('Selection Criteria');
        GLAccountCard."Same Amount".SETVALUE(true);
        GLAccountCard."Same External Document No.".SETVALUE(true);
        GLAccountCard."Same Document No.".SETVALUE(true);

        GeneralLedgerEntries.TRAP;
        //GLAccountCard."Page General Ledger Entries".INVOKE; //BC Upgrade KAPOOV01
        GLAccountCard."Ledger E&ntries".INVOKE; //BC Upgrade KAPOOV01

        ApplyGeneralLedgerEntries.TRAP;
        if UnitTestingValues.Value <> '' then begin//HEI.72
            //GeneralLedgerEntries.Action1000000000.INVOKE; //BC Upgrade KAPOOV01
            GeneralLedgerEntries."Apply Entries".INVOKE; //BC Upgrade KAPOOV01
            //ApplyGeneralLedgerEntries."<Option>".SETVALUE('Sales Prepayment');//HEI.21;Commented under HEI.27
            //HEI.30>>
            //ApplyGeneralLedgerEntries."<Option>".SETVALUE('Selection Criteria');//HEI.27
            //HEI.32>>
            if UPPERCASE(COMPANYNAME) = UPPERCASE('BrewCo') then
                ApplyGeneralLedgerEntries."<Option>".SETVALUE('Selection Criteria')
            else
                ApplyGeneralLedgerEntries."<Option>".SETVALUE('Sales Prepayment');
            //HEI.32<<
            //HEI.30<<
            //ApplyGeneralLedgerEntries.Action1100710008.INVOKE; //BC Upgrade KAPOOV01
            ApplyGeneralLedgerEntries."&Automatic application".INVOKE; //BC Upgrade KAPOOV01
            if ApplyGeneralLedgerEntries."Applies-to ID".VALUE <> '' then//HEI.27
                //ApplyGeneralLedgerEntries.Action1010010.INVOKE; //BC Upgrade KAPOOV01
                ApplyGeneralLedgerEntries."Post Application".INVOKE; //BC Upgrade KAPOOV01
            ApplyGeneralLedgerEntries.IncludeEntryFilter.SETVALUE('Closed');
        end;//HEI.72
        //HEI.13--
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,MessageHandler,RTR151GenJnlPageHandler')]
    procedure "RTR151-ManuallyPostRecurringEntries"();
    var
        RecurringGeneralJournal: TestPage "Recurring General Journal";
        Workflow: Record Workflow;
        UnitTestingValue: Record "Unit Testing Value FND";
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalLine: Record "Gen. Journal Line";
    begin
        ClearVariables('ACPICHARGES'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET;
        UnitTestingValues.GET('ACPICHARGES', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('ACPICHARGES', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        //GenJournalBatch.GET(GenJournalTemplate.Name,'DEFAULT');
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);
        //HEI.25
        GenJournalLine.RESET;
        GenJournalLine.SETFILTER("Journal Template Name", '%1', GenJournalTemplate.Name);
        if GenJournalLine.FINDSET(false) then
            GenJournalLine.DELETEALL;
        //HEI.25

        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            Workflow.RESET;
            Workflow.SETRANGE(Enabled, true);
            // Workflow.SETRANGE(Code,'MS-GJBAPW-04');
            if Workflow.FINDSET then
                repeat
                    // Workflow.Enabled := FALSE;
                    Workflow.VALIDATE(Enabled, false);
                    Workflow.MODIFY;
                until Workflow.NEXT = 0;
            //Test:= Workflow.Enabled;
        end;

        COMMIT;
        //HEI.16>>
        // Open Gen. Journal Template page
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE;   //BC Upgrade KAPOOV01
        GeneralJournalTemplates.Batches.INVOKE; //BC Upgrade KAPOOV01

        // Open Gen. Journal Batch page
        RecurringGeneralJournal.TRAP;
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        GeneralJournalBatches.EditJournal.INVOKE;
        //HEI.16<<

        //RecurringGeneralJournal.Post.INVOKE;//HEI.25
        //HEI.13--
    end;

    [Test]
    [HandlerFunctions('CreateEbfMatrixRestrictionModalPageHandler')]
    procedure "BPM046-CreateEbfMatrixRestriction"();
    var
        Dimensions: TestPage Dimensions;
        OPcoSetup: Record "General OpCo Setup FND";
    begin
        //HEI.13++
        OPcoSetup.GET;//HEI.69
        if not OPcoSetup."Enable New EBF Matrix Version" then begin//HEI.71
            Dimensions.OPENEDIT;
            Dimensions.FILTER.SETFILTER(Code, 'CCC');
            Dimensions.SetupEbf.INVOKE;
            Dimensions.OK.INVOKE;
        end;//HEI.69
        //HEI.13--
    end;

    [Test]
    procedure SettingTheHeimatchSignToNochange();
    var
        ChartofAccounts: TestPage "Chart of Accounts";
        GLAccountCard: TestPage "G/L Account Card";
        ChartofAccountsReport: Report "Chart of Accounts";
    begin
        ClearVariables('RTR050'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('RTR050', COMPANYNAME, DATABASE::"G/L Account");

        ChartofAccounts.OPENEDIT;
        GLAccountCard.OPENEDIT;
        GLAccountCard.FILTER.SETFILTER("No.", UnitTestingValues.Value);
        GLAccountCard."Heimatch Sign".SETVALUE('No Change');
        GLAccountCard.OK.INVOKE;

        //GLAccountCard.FILTER.SETFILTER("No.",'14131001');
        //HEI.13--
    end;

    [Test]
    procedure SettingTheHeimatchSignToReverse();
    var
        ChartofAccounts: TestPage "Chart of Accounts";
        GLAccountCard: TestPage "G/L Account Card";
        ChartofAccountsReport: Report "Chart of Accounts";
    begin
        ClearVariables('RTR050'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('RTR050', COMPANYNAME, DATABASE::"G/L Account");

        ChartofAccounts.OPENEDIT;
        GLAccountCard.OPENEDIT;
        GLAccountCard.FILTER.SETFILTER("No.", UnitTestingValues.Value);
        GLAccountCard."Heimatch Sign".SETVALUE('Reverse');
        GLAccountCard.OK.INVOKE;
        //GLAccountCard.FILTER.SETFILTER("No.",'14131001');
        //HEI.13--
    end;

    [Test]
    procedure "RTR038-ChangeLogReviewofGLPostings"();
    var
        ChartofAccounts: TestPage "Chart of Accounts";
        GLAccountCard: TestPage "G/L Account Card";
        ChangeLogEntriesPage: TestPage "Change Log Entries";
        ChangeLogEntries: Report "Change Log Entries";
        ChangeLogEntry: Record "Change Log Entry";
        // recObjects: Record Object;  //BC Upgrade KAPOOV01 Table-Object has ONPREM Scope
        recObjects: Record AllObjWithCaption; //BC Upgrade KAPOOV01 Replace Table-Object with Record AllObjWithCaption
    begin
        ClearVariables('RTR038'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('RTR038', COMPANYNAME, DATABASE::"Change Log Entry");

        //HEI.74>>
        //BC Upgrade KAPOOV01 Blocked code as Table-Object has ONPREM Scope >>
        // recObjects.RESET();
        // recObjects.SETRANGE(Name, UnitTestingValues.Value);
        // recObjects.SETRANGE(Type, recObjects.Type::Table);
        // if recObjects.FINDFIRST() then begin
        //     //HEI.74<<
        //     ChangeLogEntriesPage.OPENEDIT;
        //     //HEI.74>>
        //     //ChangeLogEntriesPage.FILTER.SETFILTER("Table Caption",UnitTestingValues.Value);
        //     ChangeLogEntriesPage.FILTER.SETFILTER("Table No.", FORMAT(recObjects.ID));
        //     //HEI.74<<
        //     ChangeLogEntriesPage.FILTER.SETFILTER("Primary Key Field 1 Value", UnitTestingValues."Value 2");
        //BC Upgrade KAPOOV01 Blocked code as Table-Object has ONPREM Scope <<

        //BC Upgrade KAPOOV01 Replace Table-Object with Record AllObjWithCaption >>
        recObjects.RESET();
        recObjects.SETRANGE("Object Caption", UnitTestingValues.Value);
        recObjects.SETRANGE("Object Type", recObjects."Object Type"::Table);
        if recObjects.FINDFIRST() then begin
            //HEI.74<<
            ChangeLogEntriesPage.OPENEDIT;
            //HEI.74>>
            //ChangeLogEntriesPage.FILTER.SETFILTER("Table Caption",UnitTestingValues.Value);
            ChangeLogEntriesPage.FILTER.SETFILTER("Table No.", FORMAT(recObjects."Object ID"));
            //HEI.74<<
            ChangeLogEntriesPage.FILTER.SETFILTER("Primary Key Field 1 Value", UnitTestingValues."Value 2");
            //BC Upgrade KAPOOV01 Replace Table-Object with Record AllObjWithCaption <<
        end;
        //HEI.13--
    end;

    [Test]
    procedure "RTR039-GLRegisterReviewofGLPostings"();
    var
        GLRegisters: TestPage "G/L Registers";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
    begin
        ClearVariables('RTR071'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('RTR071', COMPANYNAME, DATABASE::"G/L Entry");

        GLRegisters.OPENEDIT;
        GeneralLedgerEntries.TRAP;
        //GLRegisters."Codeunit G / L Reg.- Gen.Ledger".INVOKE; //BC Upgrade KAPOOV01 COMMENTED to resolved compilation error
        GLRegisters."General Ledger".INVOKE; //BC Upgrade KAPOOV01 added to resolved compilation error
        GeneralLedgerEntries.FILTER.SETFILTER("Posting Date", 'P9');
        GeneralLedgerEntries.FILTER.SETFILTER("User ID", UnitTestingValues.Value);


        //HEI.13--
    end;

    [Test]
    procedure "RTR040-GeneralLedgerEntriesReviewGLPostings"();
    var
        GeneralLedgerEntries: TestPage "General Ledger Entries";
    begin
        ClearVariables('RTR071'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('RTR071', COMPANYNAME, DATABASE::"G/L Entry");

        GeneralLedgerEntries.OPENEDIT;
        GeneralLedgerEntries.FILTER.SETFILTER("Posting Date", FORMAT(TODAY - 1));//HEI.43
        GeneralLedgerEntries.FILTER.SETFILTER("User ID", UnitTestingValues.Value);
        //GeneralLedgerEntries.FILTER.SETFILTER("Posting Date",'P9');//HEI.43
        GeneralLedgerEntries.OK.INVOKE;
        //HEI.13--
    end;

    [Test]
    [HandlerFunctions('BalanceCarryForwardReportPageHandler')]
    procedure "RTR129-BalanceCarryForward"();
    var
        CloseMonthIncomeStatement: Report "Close Month Income Statement";
    begin
        //HEI.13++
        CloseMonthIncomeStatement.RUNMODAL;
        //HEI.13--
    end;

    [RequestPageHandler]
    procedure Checkbalancing7SeriesSCOAAccountsReportPageHandler(var TrialBalance: TestRequestPage "Trial Balance");
    begin
        //HEI.13++

        //HEI.13+--
    end;

    [RequestPageHandler]
    procedure BalanceCarryForwardReportPageHandler(var CloseMonthIncomeStatement: TestRequestPage "Close Month Income Statement");
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
    begin
        //HEI.13++
        UnitTestingValues.RESET;
        UnitTestingValues.GET('ACPICHARGES', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR050', COMPANYNAME, DATABASE::"G/L Account");
        //GenJournalBatch.GET(GenJournalTemplate.Name,UnitTestingValues.Value);
        GenJournalBatch.GET(GenJournalTemplate.Name, 'CLOSING');

        CloseMonthIncomeStatement.FiscalMonthEndingDate.SETVALUE(UnitTestingValues."Value 3");
        CloseMonthIncomeStatement.GenJournalTemplate.SETVALUE(GenJournalTemplate.Name);
        CloseMonthIncomeStatement.GenJournalBatch.SETVALUE(GenJournalBatch.Name);
        CloseMonthIncomeStatement.DocumentNo.SETVALUE('BalanceCarry');
        CloseMonthIncomeStatement.RetainedEarningsAcc.SETVALUE('16202001');
        CloseMonthIncomeStatement.PostingDescription.SETVALUE('TEST2');


        //HEI.13+--
    end;

    [ModalPageHandler]
    procedure CreateEbfMatrixRestrictionModalPageHandler(var EbfCombinations: TestPage "Ebf Combinations CBN");
    var
        ReversalDate: Date;
    begin
        //HEI.13++
        EbfCombinations.OK.INVOKE;
        //HEI.13--
    end;

    [RequestPageHandler]
    procedure CalculateDepreciationLocalReportPageHandler(var CalculateDepreciation: TestRequestPage "Calculate Depreciation");
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
    begin
        //HEI.13++
        CalculateDepreciation.DepreciationBook.SETVALUE('LOCAL');
        CalculateDepreciation.PostingDate.SETVALUE(TODAY);
        CalculateDepreciation.DocumentNo.SETVALUE('Test11');
        //CalculateDepreciation.Control13.SETVALUE('FA');  //BC Upgrade KAPOOV01
        CalculateDepreciation.PostingDescription.SETVALUE('FA');  //BC Upgrade KAPOOV01
        CalculateDepreciation.OK.INVOKE;
        //HEI.13+--
    end;

    [RequestPageHandler]
    //procedure CalculateDepreciationHeinekenReportPageHandler(var CalculateDepreciation: TestRequestPage "Calculate Depreciation"); //BC Upgrade KAPOOV01 Report name changed from "Calculate Depreciation" to "Calculate Depreciation-RtR"
    procedure CalculateDepreciationHeinekenReportPageHandler(var CalculateDepreciation: TestRequestPage "Calculate Depreciation-RtR"); //BC Upgrade KAPOOV01 Report name changed from "Calculate Depreciation" to "Calculate Depreciation-RtR"
    var
        FixedAssetJournal: TestPage "Fixed Asset Journal";
        FAJournalTemplates: TestPage "General Journal Template List";
        FAJournalBatches: TestPage "General Journal Batches";
        FixedAssetGLJournal: TestPage "Fixed Asset G/L Journal";
        PostingDate: Date;
    begin
        //HEI.13++
        PostingDate := CALCDATE('+1M', DMY2DATE(1, DATE2DMY(TODAY, 2), DATE2DMY(TODAY, 3)));//HEI.38
        CalculateDepreciation.DepreciationBook.SETVALUE('HEINEKEN');
        CalculateDepreciation.PostingDate.SETVALUE(PostingDate);//HEI.38
        CalculateDepreciation.DocumentNo.SETVALUE('Test11');
        //CalculateDepreciation.Control13.SETVALUE('FA');  //BC Upgrade KAPOOV01
        CalculateDepreciation.PostingDescription.SETVALUE('FA');  //BC Upgrade KAPOOV01
        CalculateDepreciation.OK.INVOKE;
    end;

    [RequestPageHandler]
    procedure CalculateandpostWiPReportPageHandler(var PostWIPtoGL: TestRequestPage "Post WIP to GL CBN");
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        lGenLedgSetUp: Record "General Ledger Setup";
        lGlAcc: Record "G/L Account";
    begin
        //HEI.13++
        UnitTestingValues.RESET;
        UnitTestingValues.GET('BPM013', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);
        UnitTestingValues.RESET;
        UnitTestingValues.GET('BPM013', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);


        //HEI.27>>
        lGenLedgSetUp.GET;
        lGlAcc.RESET;
        lGlAcc.SETFILTER("No.", '%1|%2', lGenLedgSetUp."WIP Account FND", lGenLedgSetUp."Bal. Wip Account FND");
        lGlAcc.SETRANGE(Blocked, true);//HEI.76
        if lGlAcc.FINDSET(false) then
            lGlAcc.MODIFYALL(Blocked, false);//HEI.76
                                             /*//HEI.76
                                             REPEAT
                                               IF lGlAcc.Blocked THEN BEGIN
                                                 lGlAcc.Blocked := FALSE;
                                                 lGlAcc.MODIFY;
                                               END;
                                             UNTIL lGlAcc.NEXT = 0;*///HEI.76
                                                                     //HEI.27<<
        PostWIPtoGL.PostingDate.SETVALUE(TODAY);
        PostWIPtoGL.ReversalPostingDate.SETVALUE(TODAY);
        PostWIPtoGL.GenJournalTemplate.SETVALUE(GenJournalTemplate.Name);
        PostWIPtoGL.GenJournalBatch.SETVALUE(GenJournalBatch.Name);
        PostWIPtoGL.OK.INVOKE;
        //HEI.13+--

    end;

    [Test]
    [HandlerFunctions('AllocatedimensionLogisticsexpenseReportPageHandler')]
    procedure "BPM016-AllocatedimensionLogisticsexpenseCostdrivers"();
    var
        CostJournal: TestPage "Cost Journal";
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
    begin
        ClearVariables('BPM016'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET;
        UnitTestingValues.GET('BPM016', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('BPM016', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);
        CostJournal.OPENEDIT;
        //CostJournal.FILTER.SETFILTER("Journal Template Name",'STANDARD');
        //CostJournal.FILTER.SETFILTER("Journal Batch Name",'DEFAULT');
        CostJournal.FILTER.SETFILTER("Journal Template Name", GenJournalTemplate.Name);
        CostJournal.FILTER.SETFILTER("Journal Batch Name", GenJournalBatch.Name);
        CostJournal."Allocate expenses".INVOKE;
        //HEI.13--
    end;

    [RequestPageHandler]
    procedure AllocatedimensionLogisticsexpenseReportPageHandler(var AllocatebySKUV2: TestRequestPage "Allocate by SKU V.2");
    begin
        //HEI.13++
        //BC Upgrade KAPOOV01 >>
        //  AllocatebySKUV2.Control55002.SETVALUE(CALCDATE('-CM',TODAY));
        // AllocatebySKUV2.Control55003.SETVALUE(TODAY);
        // AllocatebySKUV2.Control55004.SETVALUE('Test1');
        // AllocatebySKUV2.Control55005.SETVALUE(TODAY);
        AllocatebySKUV2.StartingDate.SETVALUE(CALCDATE('-CM', TODAY));
        AllocatebySKUV2.EndingDate.SETVALUE(TODAY);
        AllocatebySKUV2.DocumentNo.SETVALUE('Test1');
        AllocatebySKUV2.PostingDate.SETVALUE(TODAY);
        //BC Upgrade KAPOOV01 <<
        AllocatebySKUV2.OK.INVOKE;
        //HEI.13--
    end;

    [Test]
    [HandlerFunctions('AnalysisByDimPageHandler1,AnalysisByDimMatrixModalPageHandler1,FlatFileCIL3ICRequestPageHandler1,MessageHandler')]
    procedure "BPM058-CheckPlandatauploadinAnalysisbydimensions"();
    var
        AnalysisViewList: TestPage "Analysis View List";
    begin
        ClearVariables('BPM058'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('BPM058', COMPANYNAME, DATABASE::"Analysis View");

        AnalysisViewList.OPENVIEW;
        //AnalysisViewList.FILTER.SETFILTER(Code,'CIL3');
        AnalysisViewList.FILTER.SETFILTER(Code, UnitTestingValues.Value);
        AnalysisViewList.EditAnalysis.INVOKE;
        //HEI.13--
    end;

    [PageHandler]
    procedure AnalysisByDimPageHandler1(var AnalysisbyDimensions: TestPage "Analysis by Dimensions");
    begin
        //HEI.13++
        AnalysisbyDimensions.PeriodType.SETVALUE('Month');
        AnalysisbyDimensions.BudgetFilter.SETVALUE('CAPEX');
        AnalysisbyDimensions.ShowMatrix.INVOKE;
        //HEI.13--
    end;

    [ModalPageHandler]
    procedure AnalysisByDimMatrixModalPageHandler1(var AnalysisbyDimensionsMatrix: TestPage "Analysis by Dimensions Matrix");
    begin
        //HEI.13++
        //AnalysisbyDimensionsMatrix.Action1000000001.INVOKE; //BC Upgrade KAPOOV01 
        AnalysisbyDimensionsMatrix."Export to CIL3".INVOKE; //BC Upgrade KAPOOV01 
        //HEI.13--
    end;

    [RequestPageHandler]
    procedure FlatFileCIL3ICRequestPageHandler1(var ExportCIL3: TestRequestPage "Export CIL3 RTR");//Bc Upgrade YADAVM09,28.04.26<<
    begin
        //HEI.13++
        //BC Upgrade KAPOOV01 >>
        // ExportCIL3.Control1100710006.SETVALUE('2021');
        // ExportCIL3.Control1100710007.SETVALUE('Month');
        // ExportCIL3.Control1100710008.SETVALUE('1');
        // //Mark "Only Balance Sheet"
        // ExportCIL3.Control1100710017.SETVALUE(true);

        ExportCIL3.YearFilter.SETVALUE('2021');
        ExportCIL3.PeriodTypeFilter.SETVALUE('Month');
        ExportCIL3.PeriodFilter.SETVALUE('1');
        ExportCIL3.OnlyBalSheet.SETVALUE(true);
        //BC Upgrade KAPOOV01 <<

        //FileName := FileMgt.SaveFileDialog('Export to',FileName,FileMgt.GetToFilterText('','.txt')); //HEI.15 commented
        //ExportCIL3.Control1100710011.SETVALUE(FileName);//HEI.15 commented
        //ExportCIL3.Control1100710011.SETVALUE(SaveCIL3File); //HEI.15 //BC Upgrade KAPOOV01
        ExportCIL3.ClientFileName.SETVALUE(SaveCIL3File); //HEI.15 //BC Upgrade KAPOOV01

        ExportCIL3.OK.INVOKE;
        //HEI.13--
    end;

    [Test]
    [HandlerFunctions('RetrieveIncomeStatementReportPageHandler')]
    procedure "BPM040-RetrieveIncomeStatement"();
    var
        AccountSchedule: Report "Account Schedule";
    begin
        //HEI.13++
        AccountSchedule.RUNMODAL;
        //HEI.13--
    end;

    [RequestPageHandler]
    procedure RetrieveIncomeStatementReportPageHandler(var AccountSchedule: TestRequestPage "Account Schedule");
    begin
        //HEI.13++
        AccountSchedule.StartDate.SETVALUE(TODAY);
        AccountSchedule.EndDate.SETVALUE(TODAY);
        AccountSchedule.GLBudgetFilter.SETVALUE('CAPEX');
        AccountSchedule.SAVEASPDF('AccountSchedule.pdf');
        //HEI.13--
    end;

    [Test]
    [HandlerFunctions('RetrieveBalancesheetReportPageHandler')]
    procedure "BPM041-RetrieveBalancesheet"();
    var
        AccountSchedule: Report "Account Schedule";
    begin
        //HEI.13++
        AccountSchedule.RUNMODAL;
        //HEI.13--
    end;

    [RequestPageHandler]
    procedure RetrieveBalancesheetReportPageHandler(var AccountSchedule: TestRequestPage "Account Schedule");
    begin
        //HEI.13++
        AccountSchedule.StartDate.SETVALUE(TODAY);
        AccountSchedule.EndDate.SETVALUE(TODAY);
        AccountSchedule.GLBudgetFilter.SETVALUE('CAPEX');
        AccountSchedule.SAVEASPDF('Balance.pdf');
        //HEI.13--
    end;

    [Test]
    [HandlerFunctions('PlanVersionuploadandmaintenanceReportPageHandler')]
    procedure "BPM045-PlanVersionuploadandmaintenance"();
    var
        GLBudgetNames: TestPage "G/L Budget Names";
        ExportBudgettoExcel: Report "Export Budget to Excel";
        GLBudgetEntry: Record "G/L Budget Entry";
        Budget: TestPage Budget;
    begin
        //HEI.13++
        GLBudgetNames.OPENNEW;
        GLBudgetNames.Name.SETVALUE('NewBudget1');
        GLBudgetNames.Description.SETVALUE('Annual Budget Test1');
        GLBudgetNames."Budget Dimension 1 Code".SETVALUE('CAPEX');
        GLBudgetNames."Budget Dimension 2 Code".SETVALUE('SKU');
        Budget.TRAP;
        GLBudgetNames.EditBudget.INVOKE;
        COMMIT;
        //Budget.Action1102601005.INVOKE;

        GLBudgetEntry.RESET;
        GLBudgetEntry.SETRANGE("Budget Name", 'NewBudget1');
        GLBudgetEntry.SETRANGE("Budget Dimension 1 Code", 'CAPEX');
        GLBudgetEntry.SETRANGE("Budget Dimension 2 Code", 'SKU');
        REPORT.RUN(82, true, false, GLBudgetEntry);
        //HEI.13--
    end;

    [RequestPageHandler]
    procedure PlanVersionuploadandmaintenanceReportPageHandler(var ExportBudgettoExcel: TestRequestPage "Export Budget to Excel");
    begin
        //HEI.13++
        //BC Upgrade KAPOOV01 >>
        // ExportBudgettoExcel.Control1.SETVALUE(TODAY);
        // ExportBudgettoExcel.Control5.SETVALUE('12');
        // ExportBudgettoExcel.Control3.SETVALUE('1M');
        ExportBudgettoExcel.StartDate.SETVALUE(TODAY);
        ExportBudgettoExcel.NoOfPeriods.SETVALUE('12');
        ExportBudgettoExcel.PeriodLength.SETVALUE('1M');
        //BC Upgrade KAPOOV01 <<
        ExportBudgettoExcel.OK.INVOKE;
        //HEI.13--
    end;

    [Test]
    procedure "BPM051-CreateCAPEXbudget"();
    var
        GLBudgetNames: TestPage "G/L Budget Names";
        ExportBudgettoExcel: Report "Export Budget to Excel";
        GLBudgetEntry: Record "G/L Budget Entry";
        Budget: TestPage Budget;
        BudgetMatrix: TestPage "Budget Matrix";
    begin
        ClearVariables('BPM051'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('BPM051', COMPANYNAME, DATABASE::"Dimension Code Buffer");

        GLBudgetNames.OPENNEW;
        GLBudgetNames.Name.SETVALUE('CAP Budget');
        GLBudgetNames.Description.SETVALUE('Annual Budget Test');
        GLBudgetNames."Budget Dimension 1 Code".SETVALUE('CAPEX');

        Budget.TRAP;
        GLBudgetNames.EditBudget.INVOKE;
        Budget.PeriodType.SETVALUE('Year');

        BudgetMatrix.OPENEDIT;
        //BudgetMatrix.Code.SETVALUE('11001000');
        BudgetMatrix.Code.SETVALUE(UnitTestingValues.Value);
        Budget.OK.INVOKE;
        //HEI.13--
    end;

    [Test]
    procedure AssigningdefaultCCforInventoryAdjustment();
    var
        LocationList: TestPage "Location List";
        Bins: TestPage "Bin Content";
    begin
        ClearVariables('ADCCIA'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET; //HEI.16
        UnitTestingValues.GET('ADCCIA', COMPANYNAME, DATABASE::Location);

        LocationList.OPENVIEW;
        //LocationList.FILTER.SETFILTER(Code,'DZ01');
        LocationList.FILTER.SETFILTER(Code, UnitTestingValues.Value);
        Bins.TRAP;
        //BC Upgrade KAPOOV01 >>
        //LocationList."Page Bins".INVOKE;
        LocationList."&Bins".INVOKE;
        //BC Upgrade KAPOOV01 <<
        //HEI.13--
    end;

    [PageHandler]
    procedure CalculateDepreciationPageHandler(var FixedAssetGLJournal: TestPage "Fixed Asset G/L Journal");
    begin
        //FixedAssetGLJournal.Action50.INVOKE; //BC Upgrade KAPOOV01
        FixedAssetGLJournal."P&ost".INVOKE; //BC Upgrade KAPOOV01
    end;

    [RequestPageHandler]
    procedure DisplaySCOAChartofAccountsReportPageHandler(var ChartofAccounts: TestRequestPage "Chart of Accounts");
    begin
        ChartofAccounts.SAVEASPDF('COA.pdf');//HEI.13++
    end;

    [RequestPageHandler]
    procedure ChangeLogReviewofSCOAReportPageHandler(var ChangeLogEntries: TestRequestPage "Change Log Entries");
    begin
        ChangeLogEntries.SAVEASPDF('ChangeLog.pdf');//HEI.13++
    end;

    [Test]
    [HandlerFunctions('ReportHandlerAccrualPostingItemCharges,MessageHandler,ConfirmationHandler')]
    procedure AccrualPostingofItemCharges();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        Balance: Decimal;
        Amt: Decimal;
        DefaultDim: Record "Default Dimension";
        DimSetEntryL: TestPage "Edit Dimension Set Entries";
        GLMassUpload: Report "Import Gen.Jrnl From Excel CBN";
        Parameters: Text;
    begin
        ClearVariables('ACPICHARGES'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET;
        UnitTestingValues.GET('ACPICHARGES', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('ACPICHARGES', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            Workflow.RESET;
            Workflow.SETRANGE(Enabled, true);
            // Workflow.SETRANGE(Code,'MS-GJBAPW-04');
            if Workflow.FINDSET then
                repeat
                    // Workflow.Enabled := FALSE;
                    Workflow.VALIDATE(Enabled, false);
                    Workflow.MODIFY;
                until Workflow.NEXT = 0;
            //Test:= Workflow.Enabled;
        end;
        COMMIT;

        PostExpcostforItemCharge.RUNMODAL;

        //Gen. Journal Template
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE;   //BC Upgrade KAPOOV01
        GeneralJournalTemplates.Batches.INVOKE; //BC Upgrade KAPOOV01

        //Gen. Journal Batch
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches."No. Series".SETVALUE('');
        GeneralJournalBatches.EditJournal.INVOKE;
        //BC Upgrade KAPOOV01 Updated comment syntax >>
        //{
        // GenJournalLine.RESET;
        // GenJournalLine.SETRANGE("Journal Template Name", GeneralJournalTemplates.Name.VALUE);
        // GenJournalLine.SETRANGE("Journal Batch Name", GeneralJournalBatches.Name.VALUE);
        // IF GenJournalLine.FINDSET THEN BEGIN
        //     REPEAT
        //     }
        //BC Upgrade KAPOOV01 Updated comment syntax <<
        //  IF ApprovalsMgmt.IsGeneralJournalLineApprovalsWorkflowEnabled(GenJournalLine) THEN BEGIN
        //BC Upgrade KAPOOV01 Updated comment syntax >>
        //    {
        //       IF ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) THEN BEGIN
        //     Workflow.RESET;
        //     Workflow.SETRANGE(Enabled, TRUE);
        //     Workflow.SETRANGE(Code, 'MS-GJBAPW-04');
        //     IF Workflow.FINDSET THEN
        //         REPEAT
        //             // Workflow.Enabled := FALSE;
        //             Workflow.VALIDATE(Enabled, FALSE);
        //             Workflow.MODIFY;
        //         UNTIL Workflow.NEXT = 0;
        //     Test := Workflow.Enabled;
        // END;
        // }
        //BC Upgrade KAPOOV01 Updated comment syntax <<

        // UNTIL GenJournalLine.NEXT=0;
        //  END;


        //IF ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) THEN BEGIN
        //IF WorkflowResponse.GET('SENDAPPROVALREQUESTFORAPPROVAL') THEN
        //  WorkflowResponse.DELETE;
        //GenJournalPage.SendApprovalRequestJournalBatch.INVOKE
        //END ELSE
        // ERROR('No approval workflow is enabled.');

        //BC Upgrade KAPOOV01 Updated comment syntax >>
        // {

        //   UserSetup3.SETRANGE("Unlimited Cr. Limit Customer", TRUE);
        // IF UserSetup3.FINDFIRST THEN BEGIN
        //     UserSetup4.GET(USERID);
        //     UserSetup4."Credit Limit Approver ID" := UserSetup3."User ID";
        //     UserSetup4."Approver ID" := UserSetup3."User ID";
        //     UserSetup4.MODIFY;
        // END;
        // //HEI.19<<
        // GenJournalPage.SendApprovalRequestJournalBatch.INVOKE;
        // // SalesOrder.SendApprovalRequest.INVOKE;
        // ApprovalEntries.TRAP;
        // // SalesOrder.Approvals.INVOKE;
        // GenJournalPage.Approvals.INVOKE;
        // //HEI.19>>
        // ApprovalEntries.FILTER.SETFILTER(Status, '1');
        // IF (ApprovalEntries."Approver ID".VALUE <> '') AND
        //    (ApprovalEntries."Approver ID".VALUE <> USERID)
        // THEN BEGIN
        //     //HEI.19<<

        //     //Update Substitute for Approver ID = USERID
        //     UserSetup.GET(ApprovalEntries."Approver ID".VALUE);
        //     UserSetup.Substitute := USERID;
        //     UserSetup.MODIFY;

        //     //Update Approval Limit for USERID
        //     UserSetup2.GET(USERID);
        //     IF NOT UserSetup2."Unlimited Sales Approval" OR NOT UserSetup2."Unlimited Cr. Limit Customer" OR
        //        NOT UserSetup2."Unlimited Deposit Limit Cust." OR NOT UserSetup2."Unlimited Overdue Approval"
        //     THEN BEGIN
        //         UserSetup2."Unlimited Sales Approval" := TRUE;
        //         UserSetup2."Unlimited Cr. Limit Customer" := TRUE;
        //         UserSetup2."Unlimited Deposit Limit Cust." := TRUE;
        //         UserSetup2."Unlimited Overdue Approval" := TRUE;
        //         UserSetup2.MODIFY;
        //     END;

        //     //Delegate Approval Request
        //     ApprovalEntries.Action35.INVOKE;

        //     //Approve Approval Entry
        //     // SalesOrder.Approve.INVOKE;
        //     GenJournalPage.Approve.INVOKE
        // END; //

        //   }
        //BC Upgrade KAPOOV01 Updated comment syntax <<

        //Step 9 -Check preview posting option for verification
        //GenJournalPage.Preview.INVOKE;
        //Preview GL Entries page is handled by function GLPreviewEntriesPageHandler
        //HEI.01--

        GenJournalPage.Post.INVOKE;
        //HEI.13--
    end;

    [RequestPageHandler]
    procedure ReportHandlerAccrualPostingItemCharges(var PostExpcostforItemCharge: TestRequestPage "Post Exp. cost for Item Charge");
    var
        GLRegister: Record "G/L Register";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        GLRegisters: TestPage "G/L Registers";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
        CurrencyExchangeRates: TestPage "Currency Exchange Rates";
        //ReverseEntries: TestPage "Reverse Entries"; //BC Upgrade KAPOOV01 Page- "Reverse Entries" not available in BC
        PurchReceiptDocNo: Code[20];
        LPurchRcptLine: Record "Purch. Rcpt. Line";
        lGenJournalTemplate: Record "Gen. Journal Template";
    begin
        //HEI.13++
        //HEI.16>>
        //PostExpcostforItemCharge.Control1100066001.SETVALUE(010122D);
        //PostExpcostforItemCharge.Control1100066001.SETVALUE(DMY2DATE(1, 1, 2022)); //BC Upgrade KAPOOV01 Commented to resolve compilation errors
        PostExpcostforItemCharge.StartingDate.SETVALUE(DMY2DATE(1, 1, 2022)); //BC Upgrade KAPOOV01 Added
        //HEI.16<<
        //PostExpcostforItemCharge.Control1100066002.SETVALUE(TODAY); //BC Upgrade KAPOOV01 Commented to resolve compilation errors
        PostExpcostforItemCharge.EndingDate.SETVALUE(TODAY); //BC Upgrade KAPOOV01 Added
        //PostExpcostforItemCharge.Control1100066003.SETVALUE(TODAY); //BC Upgrade KAPOOV01 Commented to resolve compilation errors
        PostExpcostforItemCharge.ReversalDate.SETVALUE(TODAY); //BC Upgrade KAPOOV01 Added
        PostExpcostforItemCharge."Create Gen Jnl Lines".SETVALUE(true);
        //HEI.81>>
        if lGenJournalTemplate.GET('GENERAL') then
            if not lGenJournalTemplate."Blocked FND" then
                PostExpcostforItemCharge.GenTempName.SETVALUE('GENERAL')
            else
                PostExpcostforItemCharge.GenTempName.SETVALUE('RTR-MJE');
        //HEI.81<<
        //PostExpcostforItemCharge.GenTempName.SETVALUE('GENERAL');//HEI.81 Commented
        PostExpcostforItemCharge.GenBatchName.SETVALUE('DEFAULT');
        //HEI.25>>
        LPurchRcptLine.RESET;
        LPurchRcptLine.SETRANGE("Posting Date", DMY2DATE(1, 1, 2022), TODAY);
        LPurchRcptLine.SETFILTER(Type, '%1|%2', Type::"G/L Account", Type::"Charge (Item)");
        if LPurchRcptLine.FINDLAST then begin
            PurchReceiptDocNo := LPurchRcptLine."Document No.";
        end;
        PostExpcostforItemCharge."Purch. Rcpt. Header".SETFILTER(PostExpcostforItemCharge."Purch. Rcpt. Header"."No.", PurchReceiptDocNo);
        //HEI.25<<
        PostExpcostforItemCharge.OK.INVOKE;
        //HEI.13--
    end;

    [Test]
    [HandlerFunctions('ReportHandlerAccrualPostingItemCharges,MessageHandler,ConfirmationHandler')]
    procedure AccrualPostingofServiceAndItemCharges();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        Balance: Decimal;
        Amt: Decimal;
        DefaultDim: Record "Default Dimension";
        DimSetEntryL: TestPage "Edit Dimension Set Entries";
        GLMassUpload: Report "Import Gen.Jrnl From Excel CBN";
        Parameters: Text;
    begin
        ClearVariables('ACPICHARGES'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET;
        UnitTestingValues.GET('ACPICHARGES', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('ACPICHARGES', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            Workflow.RESET;
            Workflow.SETRANGE(Enabled, true);
            // Workflow.SETRANGE(Code,'MS-GJBAPW-04');
            if Workflow.FINDSET then
                repeat
                    // Workflow.Enabled := FALSE;
                    Workflow.VALIDATE(Enabled, false);
                    Workflow.MODIFY;
                until Workflow.NEXT = 0;
            //Test:= Workflow.Enabled;
        end;
        COMMIT;

        PostExpcostforItemCharge.RUNMODAL;

        //Gen. Journal Template
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01
        GeneralJournalTemplates.Batches.INVOKE; //BC Upgrade KAPOOV01

        //Gen. Journal Batch
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches."No. Series".SETVALUE('');
        GeneralJournalBatches.EditJournal.INVOKE;

        GenJournalPage.Post.INVOKE;
        //HEI.13--
    end;

    [Test]
    [HandlerFunctions('ReportHandlerAccrualPostingItemCharges,MessageHandler,ConfirmationHandler')]
    procedure ServiceAccrualPosting();
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GenJournalPage: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        Balance: Decimal;
        Amt: Decimal;
        DefaultDim: Record "Default Dimension";
        DimSetEntryL: TestPage "Edit Dimension Set Entries";
        GLMassUpload: Report "Import Gen.Jrnl From Excel CBN";
        Parameters: Text;
    begin
        ClearVariables('ACPICHARGES'); //HEI.16
        //HEI.13++
        UnitTestingValues.RESET;
        UnitTestingValues.GET('ACPICHARGES', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('ACPICHARGES', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        //HEI.25
        GenJournalLine.RESET;
        GenJournalLine.SETFILTER("Journal Template Name", '%1', GenJournalTemplate.Name);
        if GenJournalLine.FINDSET(false) then
            GenJournalLine.DELETEALL;
        //HEI.25

        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            Workflow.RESET;
            Workflow.SETRANGE(Enabled, true);
            // Workflow.SETRANGE(Code,'MS-GJBAPW-04');
            if Workflow.FINDSET then
                repeat
                    // Workflow.Enabled := FALSE;
                    Workflow.VALIDATE(Enabled, false);
                    Workflow.MODIFY;
                until Workflow.NEXT = 0;
            //Test:= Workflow.Enabled;
        end;
        COMMIT;

        PostExpcostforItemCharge.RUNMODAL;

        //Gen. Journal Template
        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        //HEI.16>>
        //GeneralJournalTemplates.FINDFIRSTFIELD(Name,GenJournalTemplate.Name);
        GeneralJournalTemplates.FILTER.SETFILTER(Name, GenJournalTemplate.Name);
        //HEI.16<<
        //GeneralJournalTemplates."Page General Journal Batches".INVOKE; //BC Upgrade KAPOOV01
        GeneralJournalTemplates.Batches.INVOKE; //BC Upgrade KAPOOV01

        //Gen. Journal Batch
        GenJournalPage.TRAP;
        //HEI.16>>
        //GeneralJournalBatches.FINDFIRSTFIELD(Name,GenJournalBatch.Name);
        GeneralJournalBatches.FILTER.SETFILTER(Name, GenJournalBatch.Name);
        //HEI.16<<
        GeneralJournalBatches."No. Series".SETVALUE('');
        GeneralJournalBatches.EditJournal.INVOKE;

        GenJournalPage.Post.INVOKE;
        //HEI.13--
    end;

    [RequestPageHandler]
    //BC Upgrade KAPOOV01 Report-595-"Adjust Exchange Rates" replaced with Report-596-"Exch. Rate Adjustment" >>
    //procedure ExchangeRateReportHandlerRevalAP(var AdjustExchangeRates: TestRequestPage "Adjust Exchange Rates");
    procedure ExchangeRateReportHandlerRevalAP(var AdjustExchangeRates: TestRequestPage "Exch. Rate Adjustment");
    //BC Upgrade KAPOOV01 Report-595-"Adjust Exchange Rates" replaced with Report-596-"Exch. Rate Adjustment" <<
    var
        GLRegister: Record "G/L Register";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        GLRegisters: TestPage "G/L Registers";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
        CurrencyExchangeRates: TestPage "Currency Exchange Rates";
    //ReverseEntries: TestPage "Reverse Entries"; //BC Upgrade KAPOOV01 Page- "Reverse Entries" not available in BC
    begin
        //HEI.13++
        //HEI.16>>
        //AdjustExchangeRates.StartingDate.SETVALUE(111017D);
        AdjustExchangeRates.StartingDate.SETVALUE(DMY2DATE(10, 11, 2017));
        //HEI.16<<
        AdjustExchangeRates.EndingDate.SETVALUE(WORKDATE);
        //BC Upgrade KAPOOV01 >>
        //AdjustExchangeRates.Control4.SETVALUE(WORKDATE);
        AdjustExchangeRates.PostingDateReq.SETVALUE(WORKDATE);
        //BC Upgrade KAPOOV01 <<
        AdjustExchangeRates.DocumentNo.SETVALUE('Test');

        //BC Upgrade KAPOOV01 >>
        // AdjustExchangeRates.Control7.SETVALUE(false);
        // AdjustExchangeRates.Control6.SETVALUE(false);
        // AdjustExchangeRates.Control8.SETVALUE(true);
        // AdjustExchangeRates.Control1000000001.SETVALUE(true);
        // AdjustExchangeRates.Currency.SETFILTER(AdjustExchangeRates.Currency.Code, 'EUR');

        AdjustExchangeRates.AdjBankAcc.SETVALUE(false);
        AdjustExchangeRates.AdjCustAcc.SETVALUE(false);
        AdjustExchangeRates.CurrencyFilter.SETFILTER(AdjustExchangeRates.CurrencyFilter.Code, 'EUR');
        //BC Upgrade KAPOOV01 <<
        //AdjustExchangeRates.Preview.INVOKE;
        AdjustExchangeRates.SAVEASPDF('Test');
        //HEI.13--
    end;

    [RequestPageHandler]
    //BC Upgrade KAPOOV01 Report-595-"Adjust Exchange Rates" replaced with Report-596-"Exch. Rate Adjustment" >>
    // procedure ExchangeRateReportHandlerRevalAR_AP_Treasury(var AdjustExchangeRates6: TestRequestPage "Adjust Exchange Rates");
    procedure ExchangeRateReportHandlerRevalAR_AP_Treasury(var AdjustExchangeRates6: TestRequestPage "Exch. Rate Adjustment");
    //BC Upgrade KAPOOV01 Report-595-"Adjust Exchange Rates" replaced with Report-596-"Exch. Rate Adjustment" <<
    var
        GLRegister: Record "G/L Register";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        GLRegisters: TestPage "G/L Registers";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
        CurrencyExchangeRates: TestPage "Currency Exchange Rates";
    //ReverseEntries: TestPage "Reverse Entries"; //BC Upgrade KAPOOV01 Page- "Reverse Entries" not available in BC
    begin
        //HEI.13++
        AdjustExchangeRates6.StartingDate.SETVALUE(WORKDATE);
        AdjustExchangeRates6.EndingDate.SETVALUE(WORKDATE);
        //BC Upgrade KAPOOV01 >>
        //AdjustExchangeRates6.Control4.SETVALUE(WORKDATE);
        AdjustExchangeRates6.PostingDateReq.SETVALUE(WORKDATE);
        //BC Upgrade KAPOOV01 <<

        AdjustExchangeRates6.DocumentNo.SETVALUE('Test');
        //BC Upgrade KAPOOV01 >>
        // AdjustExchangeRates6.Control7.SETVALUE(true);
        // AdjustExchangeRates6.Control6.SETVALUE(true);
        // AdjustExchangeRates6.Control8.SETVALUE(true);
        // AdjustExchangeRates6.Control1000000001.SETVALUE(true);
        // AdjustExchangeRates6.Currency.SETFILTER(AdjustExchangeRates6.Currency.Code, 'EUR');

        AdjustExchangeRates6.AdjBankAcc.SETVALUE(false);
        AdjustExchangeRates6.AdjCustAcc.SETVALUE(false);
        AdjustExchangeRates6.CurrencyFilter.SETFILTER(AdjustExchangeRates6.CurrencyFilter.Code, 'EUR');
        //BC Upgrade KAPOOV01 <<
        //AdjustExchangeRates.Preview.INVOKE;
        AdjustExchangeRates6.SAVEASPDF('TestAR_AP_Treasury');
        //HEI.13--
    end;

    [RequestPageHandler]
    //BC Upgrade KAPOOV01 Report-595-"Adjust Exchange Rates" replaced with Report-596-"Exch. Rate Adjustment" >>
    //procedure ExchangeRateReportHandlerRevalAR_AP_Treasury2(var AdjustExchangeRates2: TestRequestPage "Adjust Exchange Rates");
    procedure ExchangeRateReportHandlerRevalAR_AP_Treasury2(var AdjustExchangeRates2: TestRequestPage "Exch. Rate Adjustment");
    //BC Upgrade KAPOOV01 Report-595-"Adjust Exchange Rates" replaced with Report-596-"Exch. Rate Adjustment" <<
    var
        GLRegister: Record "G/L Register";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        GLRegisters: TestPage "G/L Registers";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
        CurrencyExchangeRates: TestPage "Currency Exchange Rates";
    //ReverseEntries: TestPage "Reverse Entries"; //BC Upgrade KAPOOV01 Page- "Reverse Entries" not available in BC
    begin
        //HEI.13++
        AdjustExchangeRates2.StartingDate.SETVALUE(WORKDATE);

        AdjustExchangeRates2.EndingDate.SETVALUE(WORKDATE);
        //BC Upgrade KAPOOV01 >>
        //AdjustExchangeRates2.Control4.SETVALUE(WORKDATE);
        AdjustExchangeRates2.PostingDateReq.SETVALUE(WORKDATE);
        //BC Upgrade KAPOOV01 <<
        AdjustExchangeRates2.DocumentNo.SETVALUE('Test');
        //BC Upgrade KAPOOV01 >>
        // AdjustExchangeRates2.Control7.SETVALUE(true);
        // AdjustExchangeRates2.Control6.SETVALUE(true);
        // AdjustExchangeRates2.Control8.SETVALUE(true);
        // AdjustExchangeRates2.Control1000000001.SETVALUE(false);
        // AdjustExchangeRates2.Currency.SETFILTER(AdjustExchangeRates2.Currency.Code, 'EUR');

        AdjustExchangeRates2.AdjBankAcc.SETVALUE(false);
        AdjustExchangeRates2.AdjCustAcc.SETVALUE(false);
        AdjustExchangeRates2.CurrencyFilter.SETFILTER(AdjustExchangeRates2.CurrencyFilter.Code, 'EUR');
        //BC Upgrade KAPOOV01 <<
        //AdjustExchangeRates.Preview.INVOKE;
        AdjustExchangeRates2.SAVEASPDF('TestAR_AP_Treasury2');
        //HEI.13--
    end;

    [RequestPageHandler]
    //BC Upgrade KAPOOV01 Report-595-"Adjust Exchange Rates" replaced with Report-596-"Exch. Rate Adjustment" >>
    // procedure ExchangeRateReportHandlerManualRevaluationAR(var AdjustExchangeRates4: TestRequestPage "Adjust Exchange Rates");
    procedure ExchangeRateReportHandlerManualRevaluationAR(var AdjustExchangeRates4: TestRequestPage "Exch. Rate Adjustment");
    //BC Upgrade KAPOOV01 Report-595-"Adjust Exchange Rates" replaced with Report-596-"Exch. Rate Adjustment" <<
    var
        GLRegister: Record "G/L Register";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        GLRegisters: TestPage "G/L Registers";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
        CurrencyExchangeRates: TestPage "Currency Exchange Rates";
    //ReverseEntries: TestPage "Reverse Entries";  //BC Upgrade KAPOOV01 Page- "Reverse Entries" not available in BC
    begin
        //HEI.13++
        AdjustExchangeRates4.StartingDate.SETVALUE(0D);
        AdjustExchangeRates4.EndingDate.SETVALUE(WORKDATE);
        //BC Upgrade KAPOOV01 >>
        //AdjustExchangeRates4.Control4.SETVALUE(WORKDATE);
        AdjustExchangeRates4.PostingDateReq.SETVALUE(WORKDATE);
        //BC Upgrade KAPOOV01 <<
        AdjustExchangeRates4.DocumentNo.SETVALUE('Test');
        //BC Upgrade KAPOOV01 >>
        // AdjustExchangeRates4.Control7.SETVALUE(false);
        // AdjustExchangeRates4.Control6.SETVALUE(true);
        // AdjustExchangeRates4.Control8.SETVALUE(false);
        // AdjustExchangeRates4.Control1000000001.SETVALUE(true);
        // AdjustExchangeRates4.Currency.SETFILTER(AdjustExchangeRates4.Currency.Code, 'EUR');

        AdjustExchangeRates4.AdjBankAcc.SETVALUE(false);
        AdjustExchangeRates4.AdjCustAcc.SETVALUE(false);
        AdjustExchangeRates4.CurrencyFilter.SETFILTER(AdjustExchangeRates4.CurrencyFilter.Code, 'EUR');
        //BC Upgrade KAPOOV01 <<
        //AdjustExchangeRates.Preview.INVOKE;
        //AdjustExchangeRates4.SAVEASPDF('Test');  //Bc Upgrade YADAVM09
        AdjustExchangeRates4.OK().Invoke();//Bc Upgrade YADAVM09<<
        //HEI.13--
    end;

    [RequestPageHandler]
    //BC Upgrade KAPOOV01 Report-595-"Adjust Exchange Rates" replaced with Report-596-"Exch. Rate Adjustment" >
    //procedure ExchangeRateReportHandlerManualRevaluationARs(var AdjustExchangeRates5: TestRequestPage "Adjust Exchange Rates");
    procedure ExchangeRateReportHandlerManualRevaluationARs(var AdjustExchangeRates5: TestRequestPage "Exch. Rate Adjustment");
    //BC Upgrade KAPOOV01 Report-595-"Adjust Exchange Rates" replaced with Report-596-"Exch. Rate Adjustment" <<

    var
        GLRegister: Record "G/L Register";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        GLRegisters: TestPage "G/L Registers";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
        CurrencyExchangeRates: TestPage "Currency Exchange Rates";
    //ReverseEntries: TestPage "Reverse Entries"; //BC Upgrade KAPOOV01 Page- "Reverse Entries" not available in BC
    begin
        //HEI.13++
        AdjustExchangeRates5.StartingDate.SETVALUE(0D);
        AdjustExchangeRates5.EndingDate.SETVALUE(WORKDATE);
        //BC Upgrade KAPOOV01 >>
        //AdjustExchangeRates5.Control4.SETVALUE(WORKDATE);
        AdjustExchangeRates5.PostingDateReq.SETVALUE(WORKDATE);
        //BC Upgrade KAPOOV01 <<
        AdjustExchangeRates5.DocumentNo.SETVALUE('Test');
        //BC Upgrade KAPOOV01 >>
        // AdjustExchangeRates5.Control7.SETVALUE(false);
        // AdjustExchangeRates5.Control6.SETVALUE(true);
        // AdjustExchangeRates5.Control8.SETVALUE(false);
        // AdjustExchangeRates5.Control1000000001.SETVALUE(false);
        // AdjustExchangeRates5.Currency.SETFILTER(AdjustExchangeRates5.Currency.Code, 'EUR');

        AdjustExchangeRates5.AdjBankAcc.SETVALUE(false);
        AdjustExchangeRates5.AdjCustAcc.SETVALUE(false);
        AdjustExchangeRates5.CurrencyFilter.SETFILTER(AdjustExchangeRates5.CurrencyFilter.Code, 'EUR');
        //BC Upgrade KAPOOV01 <<
        //AdjustExchangeRates.Preview.INVOKE;
        //AdjustExchangeRates5.SAVEASPDF('Test'); //Bc Upgrade YADAVM09<<
        AdjustExchangeRates5.OK().Invoke();//Bc Upgrade YADAVM09<<
        //HEI.13--
    end;
    //BC Upgrade KAPOOV01 Page- "Reverse Entries" not available in BC >>
    // [ModalPageHandler]
    // procedure ReverseEntriesModalPageHandler(var ReverseEntries: TestPage "Reversal Entry");
    // begin
    //     //Choose "Reverse" from "Home" menu.
    //     ReverseEntries.Reverse.INVOKE; //HEI.13
    // end;
    //BC Upgrade KAPOOV01 Page- "Reverse Entries" not available in BC <<

    [RequestPageHandler]
    //BC Upgrade KAPOOV01 Report-595-"Adjust Exchange Rates" replaced with Report-596-"Exch. Rate Adjustment" >>

    // procedure ExchangeRateReportHandler(var AdjustExchangeRates: TestRequestPage "Adjust Exchange Rates");
    procedure ExchangeRateReportHandler(var AdjustExchangeRates: TestRequestPage "Exch. Rate Adjustment");
    //BC Upgrade KAPOOV01 Report-595-"Adjust Exchange Rates" replaced with Report-596-"Exch. Rate Adjustment" <<
    var
        GLRegister: Record "G/L Register";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        GLRegisters: TestPage "G/L Registers";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
        CurrencyExchangeRates: TestPage "Currency Exchange Rates";
    //ReverseEntries: TestPage "Reverse Entries";  //BC Upgrade KAPOOV01 Page- "Reverse Entries" not available in BC
    begin
        //HEI.13++
        //HEI.16>>
        //AdjustExchangeRates.StartingDate.SETVALUE(111017D);
        AdjustExchangeRates.StartingDate.SETVALUE(DMY2DATE(10, 11, 2017));
        //HEI.16<<
        AdjustExchangeRates.EndingDate.SETVALUE(WORKDATE);
        //BC Upgrade KAPOOV01 >>
        //AdjustExchangeRates.Control4.SETVALUE(WORKDATE);
        AdjustExchangeRates.PostingDateReq.SETVALUE(WORKDATE);
        //BC Upgrade KAPOOV01 <<
        AdjustExchangeRates.DocumentNo.SETVALUE('Test');
        //BC Upgrade KAPOOV01 >>
        // AdjustExchangeRates.Control7.SETVALUE(true);
        // AdjustExchangeRates.Control6.SETVALUE(false);
        // AdjustExchangeRates.Control8.SETVALUE(false);
        // AdjustExchangeRates.Control1000000001.SETVALUE(true);
        // AdjustExchangeRates.Currency.SETFILTER(AdjustExchangeRates.Currency.Code, 'EUR');
        AdjustExchangeRates.AdjBankAcc.SETVALUE(false);
        AdjustExchangeRates.AdjCustAcc.SETVALUE(false);
        AdjustExchangeRates.CurrencyFilter.SETFILTER(AdjustExchangeRates.CurrencyFilter.Code, 'EUR');
        //BC Upgrade KAPOOV01 <<
        //AdjustExchangeRates.Preview.INVOKE;
        AdjustExchangeRates.SAVEASPDF('Test');
        //HEI.13--
    end;

    [ModalPageHandler]
    procedure ReversalDateModalPageHandler(var ConfirmDialog: TestPage "ConfirmDialog CBN");
    var
        ReversalDate: Date;
        UserSetup: Record "User Setup";
    begin
        //HEI.13++
        //The revaluation entires are reversed with first day of following month. (01.MM.YYY.).
        //HEI.16>>
        //Update Allow Posting Date for curent user
        UserSetup.GET(USERID);
        if (UserSetup."Allow Posting To" < CALCDATE('<CM+1D>', WORKDATE)) or
           (UserSetup."Allow Posting To" = 0D)
        then begin
            UserSetup."Allow Posting To" := CALCDATE('<CM+1M>', WORKDATE);
            UserSetup.MODIFY;
        end;
        //HEI.16<<
        ReversalDate := CALCDATE('<CM+1D>', WORKDATE);
        ConfirmDialog.ReversalPostingDate.SETVALUE(ReversalDate);

        ConfirmDialog.Yes.INVOKE;
        //HEI.13--
    end;
    //BC Upgrade KAPOOV01 Report-595-"Adjust Exchange Rates" replaced with Report-596-"Exch. Rate Adjustment" >>
    [RequestPageHandler]
    //procedure ExchangeRateReportHandlers(var AdjustExchangeRates3: TestRequestPage "Adjust Exchange Rates");
    procedure ExchangeRateReportHandlers(var AdjustExchangeRates3: TestRequestPage "Exch. Rate Adjustment");
    //BC Upgrade KAPOOV01 Report-595-"Adjust Exchange Rates" replaced with Report-596-"Exch. Rate Adjustment" <<
    var
        GLRegister: Record "G/L Register";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        GLRegisters: TestPage "G/L Registers";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
        CurrencyExchangeRates: TestPage "Currency Exchange Rates";
    //ReverseEntries: TestPage "Reverse Entries"; //BC Upgrade KAPOOV01 Page- "Reverse Entries" not available in BC
    begin
        //HEI.13++
        //HEI.16>>
        //AdjustExchangeRates3.StartingDate.SETVALUE(111017D);
        AdjustExchangeRates3.StartingDate.SETVALUE(DMY2DATE(10, 11, 2017));
        //HEI.16<<
        AdjustExchangeRates3.EndingDate.SETVALUE(WORKDATE);
        //BC Upgrade KAPOOV01 >>
        //AdjustExchangeRates3.Control4.SETVALUE(WORKDATE);
        AdjustExchangeRates3.PostingDateReq.SETVALUE(WORKDATE);
        //BC Upgrade KAPOOV01 <<
        AdjustExchangeRates3.DocumentNo.SETVALUE('Test');
        //BC Upgrade KAPOOV01 <<
        // AdjustExchangeRates3.Control7.SETVALUE(false);
        // AdjustExchangeRates3.Control6.SETVALUE(false);
        // AdjustExchangeRates3.Control8.SETVALUE(true);
        // AdjustExchangeRates3.Control1000000001.SETVALUE(true);
        // AdjustExchangeRates3.Currency.SETFILTER(AdjustExchangeRates3.Currency.Code, 'EUR');

        AdjustExchangeRates3.AdjBankAcc.SETVALUE(false);
        AdjustExchangeRates3.AdjCustAcc.SETVALUE(false);
        AdjustExchangeRates3.CurrencyFilter.SETFILTER(AdjustExchangeRates3.CurrencyFilter.Code, 'EUR');
        //BC Upgrade KAPOOV01 <<
        //AdjustExchangeRates.Preview.INVOKE;
        AdjustExchangeRates3.SAVEASPDF('Test');
        //HEI.13--
    end;

    [PageHandler]
    procedure GLEntriesPageHandler(var GeneralLedgerEntries: TestPage "General Ledger Entries");
    begin
        GeneralLedgerEntries.CLOSE; //HEI.13
    end;

    [ModalPageHandler]
    procedure AnalysisDimensionModalPageHandler(var AnalysisbyDimensionsMatrix: TestPage "Analysis by Dimensions Matrix");
    var
        ReversalDate: Date;
    begin
        //HEI.13++
        AnalysisbyDimensionsMatrix.OK.INVOKE;
        //HEI.13--
    end;

    [RequestPageHandler]
    procedure CILReportHandler(var CIL3ExportEBF: TestRequestPage "CIL3 Export - EBF RTR");//Bc Upgrade YADAVM09,28.04.26<<
    var
        GLRegister: Record "G/L Register";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        GLRegisters: TestPage "G/L Registers";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
        CurrencyExchangeRates: TestPage "Currency Exchange Rates";
    //ReverseEntries: TestPage "Reverse Entries"; //BC Upgrade KAPOOV01 Page- "Reverse Entries" not available in BC
    begin
        //HEI.13++
        //BC Upgrade KAPOOV01 >>
        // CIL3ExportEBF.Control1100710006.SETVALUE(2021);
        // CIL3ExportEBF.Control1100710008.SETVALUE(1);
        // CIL3ExportEBF.Control1100710015.SETVALUE(1);
        CIL3ExportEBF.YearFilter.SETVALUE(2021);
        CIL3ExportEBF.PeriodFilter.SETVALUE(1);
        CIL3ExportEBF.RoundingFactor.SETVALUE(1);
        //BC Upgrade KAPOOV01 <<
        //FileName := FileMgt.SaveFileDialog(Text002,FileName,FileMgt.GetToFilterText('','.txt')); //HEI.15 commented
        //CIL3ExportEBF.Control1100710011.SETVALUE(FileName); //HEI.15 commented
        //BC Upgrade KAPOOV01 >>
        //CIL3ExportEBF.Control1100710011.SETVALUE(SaveCILEBFFile); //HEI.15
        CIL3ExportEBF.ClientFileName.SETVALUE(SaveCILEBFFile); //HEI.15
        //BC Upgrade KAPOOV01 <<
        CIL3ExportEBF.OK.INVOKE;
        //HEI.13--
    end;

    [RequestPageHandler]
    procedure CILReportHandlerMSV(var ExportCIL3: TestRequestPage "Export CIL3 RTR");//Bc Upgrade YADAVM09,28.04.26<<
    var
        GLRegister: Record "G/L Register";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        GLRegisters: TestPage "G/L Registers";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
        CurrencyExchangeRates: TestPage "Currency Exchange Rates";
    //ReverseEntries: TestPage "Reverse Entries"; //BC Upgrade KAPOOV01 Page- "Reverse Entries" not available in BC
    begin
        //HEI.13++
        //BC Upgrade KAPOOV01 >>
        // ExportCIL3.Control1100710006.SETVALUE(2021);
        // ExportCIL3.Control1100710008.SETVALUE(1);
        // ExportCIL3.Control1100710015.SETVALUE(1);
        // ExportCIL3.Control1100710007.SETVALUE(ExportCIL3.Control1100710007.GETOPTION(2));
        ExportCIL3.YearFilter.SETVALUE(2021);
        ExportCIL3.PeriodFilter.SETVALUE(1);
        ExportCIL3.RoundingFactor.SETVALUE(1);
        ExportCIL3.PeriodTypeFilter.SETVALUE(ExportCIL3.PeriodTypeFilter.GETOPTION(2));
        //BC Upgrade KAPOOV01 <<
        //FileName := FileMgt.SaveFileDialog(Text002,FileName,FileMgt.GetToFilterText('','.txt')); //HEI.15 commented
        //ExportCIL3.Control1100710011.SETVALUE(FileName); //HEI.15 commented
        //BC Upgrade KAPOOV01 >>
        //ExportCIL3.Control1100710011.SETVALUE(SaveCILMSVFile); //HEI.15
        ExportCIL3.ClientFileName.SETVALUE(SaveCILMSVFile); //HEI.15
        //BC Upgrade KAPOOV01 <<
        ExportCIL3.OK.INVOKE;
        //HEI.13--
    end;

    [RequestPageHandler]
    procedure CILReportHandlerWIS(var ExportCIL3: TestRequestPage "Export CIL3 RTR");//Bc Upgrade YADAVM09,28.04.26<<
    var
        GLRegister: Record "G/L Register";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        GLRegisters: TestPage "G/L Registers";
        GeneralLedgerEntries: TestPage "General Ledger Entries";
        CurrencyExchangeRates: TestPage "Currency Exchange Rates";
    //ReverseEntries: TestPage "Reverse Entries"; //BC Upgrade KAPOOV01 Page- "Reverse Entries" not available in BC
    begin
        //HEI.13++
        //BC Upgrade KAPOOV01 >>
        // ExportCIL3.Control1100710006.SETVALUE(2021);
        // ExportCIL3.Control1100710008.SETVALUE(1);
        // ExportCIL3.Control1100710015.SETVALUE(1);
        // ExportCIL3.Control1100710007.SETVALUE(ExportCIL3.Control1100710007.GETOPTION(1));
        ExportCIL3.YearFilter.SETVALUE(2021);
        ExportCIL3.PeriodFilter.SETVALUE(1);
        ExportCIL3.RoundingFactor.SETVALUE(1);
        ExportCIL3.PeriodTypeFilter.SETVALUE(ExportCIL3.PeriodTypeFilter.GETOPTION(1));
        //BC Upgrade KAPOOV01 <<
        //FileName := FileMgt.SaveFileDialog(Text002,FileName,FileMgt.GetToFilterText('','.txt')); //HEI.15 commented
        //ExportCIL3.Control1100710011.SETVALUE(FileName); //HEI.15 commented
        //ExportCIL3.Control1100710011.SETVALUE(SaveCILWISFile); //HEI.15 //BC Upgrade KAPOOV01
        ExportCIL3.ClientFileName.SETVALUE(SaveCILWISFile); //HEI.15 //BC Upgrade KAPOOV01
        ExportCIL3.OK.INVOKE;
        //HEI.13--
    end;

    [RequestPageHandler]
    procedure VATReportPageHandler(var VATStatement: TestRequestPage "VAT Statement");
    begin
        //HEI.13++
        VATStatement.StartingDate.SETVALUE(WORKDATE);
        VATStatement.EndingDate.SETVALUE(WORKDATE);
        //HEI.13--
    end;

    [ReportHandler]
    procedure VatReportReportHandler(var VATStatement: Report "VAT Statement");
    begin
        //HEI.13++
    end;

    [RequestPageHandler]
    procedure PrepExcisedutyDeclarationReportPageHandler(var CustomerItemSalesExciseDuty: TestRequestPage "Customer/Item Sales-ExciseDuty");
    begin
        //HEI.13++
        CustomerItemSalesExciseDuty.DimToExport.SETVALUE('SKU|BRAND');
        CustomerItemSalesExciseDuty.PrintToExcel.SETVALUE(false);
        CustomerItemSalesExciseDuty.SAVEASPDF('test');
        //HEI.13--
    end;

    [ReportHandler]
    procedure PrepExcisedutyDeclarationReportHandler(var CustomerItemSalesExciseDuty: Report "Customer/Item Sales-ExciseDuty");
    begin
        //HEI.13++
    end;

    [RequestPageHandler]
    procedure VATDeclarationReportPageHandler(var CalcandPostVATSettlement: TestRequestPage "Calc. and Post VAT Settlement");
    begin
        //HEI.13++
        //HEI.16>>
        //CalcandPostVATSettlement.StartingDate.SETVALUE(010122D);
        CalcandPostVATSettlement.StartingDate.SETVALUE(DMY2DATE(1, 1, 2022));
        //HEI.16<<
        //CalcandPostVATSettlement.Control2.SETVALUE(WORKDATE); //BC Upgrade KAPOOV01
        CalcandPostVATSettlement.EndDateReq.SETVALUE(WORKDATE); //BC Upgrade KAPOOV01
        CalcandPostVATSettlement.PostingDt.SETVALUE(WORKDATE);
        CalcandPostVATSettlement.DocumentNo.SETVALUE('Test1');
        //CalcandPostVATSettlement.SettlementAcc.SETVALUE('11102901');//HEI.21
        CalcandPostVATSettlement.SettlementAcc.SETVALUE(GLAccRTR144."No.");//HEI.21
        CalcandPostVATSettlement.ShowVATEntries.SETVALUE(true);
        CalcandPostVATSettlement.Post.SETVALUE(true);
        CalcandPostVATSettlement.SAVEASPDF('test');
        //HEI.13--
    end;

    [ConfirmHandler]
    procedure ConfirmationHandler(Question: Text[1024]; var Reply: Boolean);
    var
        DocumentNotPostedClosePageQst: TextConst ENU = 'The document has not been posted.\Are you sure you want to exit?', FRA = 'Le document n''a pas été validé.\Voulez-vous vraiment quitter ?';
        PostReceiptQst: TextConst ENU = 'Do you want to post the receipt?', FRA = 'Souhaitez-vous valider cette réception ?';
        PostDocumentQst: TextConst ENU = 'Do you want to post the %1?', FRA = 'Souhaitez-vous valider le document %1 ?';
        PostJnlLineQst: TextConst ENU = 'Do you want to post the journal lines?', FRA = 'Souhaitez-vous valider les lignes de la feuille ?';
        CreateOrderQst: TextConst ENU = 'Do you want to create an order from the blanket order?', FRA = 'Souhaitez-vous transformer la commande ouverte en commande ?';
        ReceiveQst: TextConst ENU = 'Do you want to receive the %1 ?', FRA = 'Voulez-vous réceptionner le %1 ?';
        PostPaymReconJnlQst: Label 'The statement ending balance differs from the bank account after posting. Continue to post ?';
        ReplaceEntriesMassUploadrQst: Label 'Are you sure you want to replace entries for Journal Template Name RTR.';
    begin
        Reply := true;
    end;

    [MessageHandler]
    procedure MessageHandler(Message: Text[1024]);
    begin
    end;

    [SendNotificationHandler]
    procedure SendNotificationHandler(var Notification: Notification): Boolean;
    begin
    end;

    [ReportHandler]
    procedure InventoryValReportHandler(var InventoryValuation: Report "Inventory Valuation");
    begin
    end;

    [ReportHandler]
    procedure TrialBalancelReportHandler(var TrialBalance: Report "Trial Balance");
    begin
    end;

    [ModalPageHandler]
    procedure PaymentBankAccountModalPageHandler(var PaymentBankAccountList: TestPage "Payment Bank Account List");
    begin
        //HEI.16>>
        //PaymentBankAccountList.FINDFIRSTFIELD("No.",BankAccount."No.");
        PaymentBankAccountList.FILTER.SETFILTER("No.", BankAccount."No.");
        //HEI.16<<
        PaymentReconciliationJnl.TRAP;
        PaymentBankAccountList.OK.INVOKE;
    end;

    [ModalPageHandler]
    procedure TransfDiffToAccModalPageHandler(var TransferDifferencetoAccount: TestPage "Transfer Difference to Account");
    begin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR135', COMPANYNAME, DATABASE::"G/L Account");
        GlAcc.GET(UnitTestingValues.Value);

        TransferDifferencetoAccount."Account No.".SETVALUE(GlAcc."No.");
        TransferDifferencetoAccount.OK.INVOKE;
    end;

    [RequestPageHandler]
    procedure GLMassUploadRequestPageHandler(var GLMassUpload: TestRequestPage "Import Gen.Jrnl From Excel CBN");
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
    begin
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        //FileName := FileMgt.UploadFile(Text001,ExcelFileExtensionTok); //HEI.15 commented
        //FileName := FileMgt.UploadFileSilent(GLUploadFileNameTxt); //HEI.15 //BC Upgrade KAPOOV01 Blocked FileMgt functionality 

        //BC Upgrade KAPOOV01 >>
        GLMassUpload."WorkBook File Name".SETVALUE('GLUpload.xlsx');
        GLMassUpload."Worksheet Name".SETVALUE('Sheet1');
        //GLMassUpload."WorkBook File Name".SETVALUE(FileName);  //BC Upgrade KAPOOV01 Commented
        //GLMassUpload."Worksheet Name".SETVALUE(GLUploadSheetNameTxt); //HEI.15 //BC Upgrade KAPOOV01 Commented
        //BC Upgrade KAPOOV01 <<

        GLMassUpload.Option.SETVALUE(0);
        GLMassUpload."Gen. Journal Batch Name".SETVALUE(GenJournalBatch.Name);
        GLMassUpload."Gen. Journal Template Name".SETVALUE(GenJournalTemplate.Name);
        //GLMassUpload.Control50000.SETVALUE(0); //BC Upgrade KAPOOV01
        GLMassUpload.ReversalOfAmounts.SETVALUE(0); //BC Upgrade KAPOOV01

        GLMassUpload.OK.INVOKE;
    end;

    [PageHandler]
    procedure GLPreviewEntriesPageHandler(var GLPostingPreview: TestPage "G/L Posting Preview");
    begin
    end;

    [RequestPageHandler]
    procedure GLMassUploadReversalRequestPageHandler(var GLMassUpload: TestRequestPage "Import Gen.Jrnl From Excel CBN");
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
    begin
        //Check default value for Journal Template
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Template");
        GenJournalTemplate.GET(UnitTestingValues.Value);

        //Check default value for Journal Batch
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_RTR001', COMPANYNAME, DATABASE::"Gen. Journal Batch");
        GenJournalBatch.GET(GenJournalTemplate.Name, UnitTestingValues.Value);

        //FileName := FileMgt.UploadFile(Text001,ExcelFileExtensionTok); //HEI.15 commented
        //FileName := FileMgt.UploadFileSilent(GLUploadFileNameTxt); //HEI.15 //BC Upgrade KAPOOV01 Blocked FileMgt functionality  
        GLMassUpload."WorkBook File Name".SETVALUE(FileName);
        //GLMassUpload."Worksheet Name".SETVALUE(WorkSheetNameTxt); //HEI.15 commented
        GLMassUpload."Worksheet Name".SETVALUE(GLUploadSheetNameTxt); //HEI.15 commented  
        GLMassUpload.Option.SETVALUE(0);
        GLMassUpload."Gen. Journal Batch Name".SETVALUE(GenJournalBatch.Name);
        GLMassUpload."Gen. Journal Template Name".SETVALUE(GenJournalTemplate.Name);
        //BC Upgrade KAPOOV01 >>
        // GLMassUpload.Control50000.SETVALUE(1);
        // GLMassUpload.Control50001.SETVALUE('1D');
        GLMassUpload.ReversalOfAmounts.SETVALUE(1);
        GLMassUpload.ChangePostingDate.SETVALUE('1D');
        //BC Upgrade KAPOOV01 <<

        GLMassUpload.OK.INVOKE;
    end;

    [RequestPageHandler]
    procedure MonthEndSalesCutOffRequestPageHandler(var MonthEndSalesCutoff: TestRequestPage "Month End Sales Cut off CBN");
    begin
        MonthEndSalesCutoff.SAVEASEXCEL('Report50023.xlsx');
    end;

    [ModalPageHandler]
    procedure GenJnlTemplateModalPageHandler(var GeneralJournalTemplateList: TestPage "General Journal Template List");
    begin
    end;

    [ModalPageHandler]
    procedure GenJnlBatchModalPageHandler(var GeneralJournalBatches: TestPage "General Journal Batches");
    begin
    end;

    [PageHandler]
    procedure GenJnlPageHandler(var GeneralJournal: TestPage "General Journal");
    begin
    end;

    [ReportHandler]
    procedure TestReportReportHandler(var GenJnlTest: Report "General Journal - Test");
    begin
    end;

    [ReportHandler]
    procedure GLRegisterReportHandler(var GLRegister: Report "G/L Register");
    begin
        //GLRegister.SAVEASWORD('GLRegister');  //BC Upgrade KAPOOV01 Blocked SAVEASWORD as its scope is OnPrem
    end;

    [PageHandler]
    procedure GeneralLedgerEntriesPageHandler(var GeneralLedgerEntries: TestPage "General Ledger Entries");
    begin
    end;

    [ModalPageHandler]
    procedure DimSetEntriesModalPageHandler(var DimensionSetEntries: TestPage "Dimension Set Entries");
    begin
    end;

    [ModalPageHandler]
    procedure AllocationsModalPageHandler(var Allocations: TestPage Allocations);
    begin
    end;

    [RequestPageHandler]
    procedure SuggestItemStandCostPageHandler(var SuggestItemStandardCost: TestRequestPage "Suggest Item Standard Cost");
    var
        Item: Record Item;
    begin
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_BPM001', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        SuggestItemStandardCost.Item.SETFILTER("No.", UnitTestingValues.Value);

        SuggestItemStandardCost.OK.INVOKE;
    end;

    [RequestPageHandler]
    procedure ImpelementItemStandCostPageHandler(var ImplementStandardCostChange: TestRequestPage "Implement Standard Cost Change");
    var
        ItemJournalBatch: Record "Item Journal Batch";
    begin
        //find the revaluation journal template
        ItemJournalTemplate.RESET;
        ItemJournalTemplate.SETRANGE(Type, ItemJournalTemplate.Type::Revaluation);
        if ItemJournalTemplate.FINDFIRST then
            ImplementStandardCostChange.ItemJournalTemplate.SETVALUE(ItemJournalTemplate.Name)
        else
            ERROR('The Journal Template with Type = Revaluation does not exist');

        //take the batch name
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RT_BPM001', COMPANYNAME, DATABASE::"Item Journal Batch");
        ItemJournalBatch.GET(ItemJournalTemplate.Name, UnitTestingValues.Value);

        //fill in the other filters
        ImplementStandardCostChange.DocumentNo.SETVALUE('TestScript BPM001');
        ImplementStandardCostChange.PostingDate.SETVALUE(WORKDATE);
        ImplementStandardCostChange.ItemJournalBatchName.SETVALUE(ItemJournalBatch.Name);

        //ImplementStandardCostChange.OK.INVOKE;
    end;

    //BC Upgrade KAPOOV01 Page "No. Series List" replaced with "No. Series" in BC >>
    [ModalPageHandler]
    //procedure NoSeriesPageHandler(var NoSeriesList: TestPage "No. Series List");
    procedure NoSeriesPageHandler(var NoSeriesList: TestPage "No. Series");
    //BC Upgrade KAPOOV01 Page "No. Series List" replaced with "No. Series" in BC 
    begin

        NoSeriesList.OK.INVOKE;
    end;
    //BC Upgrade KAPOOV01 Page "No. Series List" Removed in BC  <<

    [ModalPageHandler]
    procedure FASubclassesModalPageHandler(var FASubclasses: TestPage "FA Subclasses"); //BC Upgrade KAPOOV01
    begin
        FASubclasses.OK.INVOKE;
    end;

    [ModalPageHandler]
    procedure FAClassesModalPageHandler(var FAClasses: TestPage "FA Classes");
    begin
        FAClasses.OK.INVOKE;
    end;

    [ModalPageHandler]
    procedure EmployeeListModalPageHandler(var EmployeeList: TestPage "Employee List");
    begin
        EmployeeList.CLOSE;
    end;

    [ModalPageHandler]
    procedure FAPostingGroupsModalPageHandler(var FAPostingGroups: TestPage "FA Posting Groups");
    begin
        FAPostingGroups.OK.INVOKE;
    end;

    [ModalPageHandler]
    procedure DefaultDimensionsModalPageHandler(var DefaultDimensions: TestPage "Default Dimensions");
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        //FATemplate: Record "FA Template";  //BC Upgrade KAPOOV01 DRINK-IT
        FixedAsset: Record "Fixed Asset";
        DefaultDimension: Record "Default Dimension";
        DimensionValue: Record "Dimension Value";
    begin
        GeneralLedgerSetup.GET;

        //take the new Subclass code
        UnitTestingValues.RESET;
        UnitTestingValues.GET('RTR082', COMPANYNAME, DATABASE::"Dimension Value");
        DimensionValue.GET(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);

        DefaultDimensions.FILTER.SETFILTER("Dimension Code", DimensionValue."Dimension Code");
        DefaultDimensions."Dimension Value Code".SETVALUE(DimensionValue.Code);

        DefaultDimensions.OK.INVOKE;
    end;


    [ModalPageHandler]
    //procedure FATemplateListModalPageHandler(var FATemplateList: TestPage TableData2034873); //BC Upgrade KAPOOV01 DRINK-IT Commented <<
    procedure FATemplateListModalPageHandler(var FATemplateList: TestPage "FA Template List APS");     //BC Upgrade KAPOOV01 Used new DRINK-IT table- FA Template List APS
    begin
        FATemplateList.OK.INVOKE;
    end;


    [RequestPageHandler]
    [HandlerFunctions('FixedAssetRequestHandler')]
    procedure FixedAssetRequestPageHandler(var FixedAssetBookValue01: TestRequestPage "Fixed Asset - Book Value 01New"); //Bc Upgrade YADAVM09
    var
        GroupTotals: Option " ","FA Class","FA Subclass","FA Location","Main Asset","Global Dimension 1","Global Dimension 2","FA Posting Group";
    begin
        //FixedAssetBookValue01.Control3.SETVALUE('LOCAL'); //BC Upgrade KAPOOV01
        FixedAssetBookValue01.DeprBookCode.SETVALUE('LOCAL'); //BC Upgrade KAPOOV01
        //HEI.16>>
        //FixedAssetBookValue01.StartingDate.SETVALUE(010117D);
        //FixedAssetBookValue01.EndingDate.SETVALUE(093017D);
        FixedAssetBookValue01.StartingDate.SETVALUE(DMY2DATE(1, 1, 2017));
        FixedAssetBookValue01.EndingDate.SETVALUE(DMY2DATE(3, 9, 2017));
        //HEI.16<<
        //BC Upgrade KAPOOV01 >>
        // FixedAssetBookValue01.Control2.SETVALUE(GroupTotals::"FA Posting Group"); 
        // FixedAssetBookValue01.Control21.SETVALUE(true);
        FixedAssetBookValue01.GroupTotals.SETVALUE(GroupTotals::"FA Posting Group");
        FixedAssetBookValue01.PrintDetails.SETVALUE(true);
        //BC Upgrade KAPOOV01 <<

        FixedAssetBookValue01.SAVEASPDF('RTR085');
    end;

    [ReportHandler]
    procedure FixedAssetRequestHandler(var FixedAssetBookValue01: Report "Fixed Asset - Book Value 01");
    var
        GroupTotals: Option " ","FA Class","FA Subclass","FA Location","Main Asset","Global Dimension 1","Global Dimension 2","FA Posting Group";
    begin
    end;
    //BC Upgrade KAPOOV01 commented procedure ReverseEntryPageHandler-Page "Reversal Entry" removed in BC >>

    // [ModalPageHandler]
    // [HandlerFunctions('ConfirmationHandler,DialogPageHandler')]
    // procedure ReverseEntryPageHandler(var ReverseEntries: TestPage "Reversal Entry");
    // var
    //     ReverseEntry: Record "Reversal Entry";
    // begin
    //     //HEI.05<<
    //     ReverseEntry.SETRANGE("G/L Register No.", GLRegisterNo);
    //     ReverseEntry.SETRANGE("Reversal Type", ReverseEntry."Reversal Type"::Register);
    //     if ReverseEntry.FINDSET then
    //         repeat
    //             ReverseEntries.GOTORECORD(ReverseEntry);
    //             ReverseEntries.Reverse.INVOKE;
    //             ReverseEntries.OK.INVOKE;
    //         until ReverseEntry.NEXT = 0;
    //     //HEI.05
    // end;
    //BC Upgrade KAPOOV01 commented procedure ReverseEntryPageHandler-Page "Reversal Entry" removed in BC >>

    [ModalPageHandler]
    procedure DialogPageHandler(var ConfirmDialog: TestPage "ConfirmDialog CBN");
    begin
        ConfirmDialog.ReversalPostingDate.SETVALUE(TODAY); //HEI.05
    end;

    [ModalPageHandler]
    procedure DimSetEntriesInsertMVMTHandler(var EditDimensionSetEntries: TestPage "Edit Dimension Set Entries");
    begin
        GLSetup.GET;

        EditDimensionSetEntries."Dimension Code".SETVALUE(GLSetup."Shortcut Dimension 3 Code");
        EditDimensionSetEntries.DimensionValueCode.LOOKUP;

        EditDimensionSetEntries.OK.INVOKE;
    end;

    [ModalPageHandler]
    procedure DimValueListMVMTHandler(var DimensionValueList: TestPage "Dimension Value List");
    begin
        DimensionValueList.OK.INVOKE;
    end;

    [RequestPageHandler]
    //[HandlerFunctions('FATrialBalanceReportHandler')]  //BC Upgrade KAPOOV01 FATrialBalanceReportHandler function not found in Test Script CU-50209
    procedure FATrialBalanceRequestPageHandler(var FixedAssetTrialBalance: TestRequestPage "Fixed Asset-Trial Balance CBN");
    begin
        //HEI.08<<
        //HEI.16>>
        //FixedAssetTrialBalance.StartingDate.SETVALUE(090117D);
        //FixedAssetTrialBalance.EndingDate.SETVALUE(093017D);
        FixedAssetTrialBalance.StartingDate.SETVALUE(DMY2DATE(1, 9, 2017));
        FixedAssetTrialBalance.EndingDate.SETVALUE(DMY2DATE(30, 9, 2017));
        //HEI.16<<

        FixedAssetTrialBalance.SAVEASPDF('test');
        //HEI.08>>
    end;

    [ReportHandler]
    procedure CustomerTrialBalanceReportHandler(var CustomerTrialBalance: Report "Customer - Trial Balance");
    begin
        //HEI.08 created
    end;

    [ReportHandler]
    procedure TrialBalanceReportHandler(var TrialBalance: Report "Trial Balance");
    begin
        //HEI.08 created
    end;

    [PageHandler]
    procedure GenLedgerEntriesPageHandler(var GeneralLedgerEntries: TestPage "General Ledger Entries");
    begin
        //HEI.08 created
    end;

    [RequestPageHandler]
    procedure CustDetailTrialBalRequestPagetHandler(var CustomerDetailTrialBal: TestRequestPage "Customer - Detail Trial Bal.");
    begin
        //HEI.09
        CustomerDetailTrialBal.SAVEASEXCEL('RTR106 Cust. - Detail Trial Bal.');
    end;

    [RequestPageHandler]
    procedure VendDetailTrialBalRequestPagetHandler(var VendorDetailTrialBalance: TestRequestPage "Vendor - Detail Trial Balance");
    begin
        //HEI.09
        VendorDetailTrialBalance.SAVEASEXCEL('RTR106 Vendor - Detail Trial Bal.');
    end;

    [RequestPageHandler]
    procedure AgedAccountsReceivablesRequestPagetHandler(var AgedAccountsReceivable: TestRequestPage "Aged Accounts Receivable");
    var
        AgingBy: Integer;
    begin
        //HEI.09
        AgedAccountsReceivable.AgedAsOf.SETVALUE(WORKDATE);
        AgedAccountsReceivable.Agingby.SETVALUE(AgingByOption::"Due Date");
        AgedAccountsReceivable.PeriodLength.SETVALUE('15D');
        AgedAccountsReceivable.PrintDetails.SETVALUE(true);
        AgedAccountsReceivable.HeadingType.SETVALUE(HeadingTypeOption::"Number of Days");

        AgedAccountsReceivable.SAVEASEXCEL('RTR106 AgedAccountsReceivable');
        //HEI.09
    end;

    [RequestPageHandler]
    procedure BankAccDetailTrialBalRequestPagetHandler(var BankAccDetailTrialBal: TestRequestPage "Bank Acc. - Detail Trial Bal.");
    begin
        //HEI.09
        BankAccDetailTrialBal.SAVEASEXCEL('RTR106 Bank Acc. - Detail Trial Bal');
    end;

    [RequestPageHandler]
    procedure AgedAccountsPayableRequestPagetHandler(var AgedAccountsPayable: TestRequestPage "Aged Accounts Payable");
    var
        AgingBy: Integer;
    begin
        //HEI.09
        AgedAccountsPayable.AgedAsOf.SETVALUE(WORKDATE);
        //BC Upgrade KAPOOV01 >>
        //AgedAccountsPayable.Control3.SETVALUE(AgingByOption::"Due Date");
        AgedAccountsPayable.AgingBy.SETVALUE(AgingByOption::"Due Date");
        //BC Upgrade KAPOOV01 <<
        AgedAccountsPayable.PeriodLength.SETVALUE('20D');
        //BC Upgrade KAPOOV01 >>
        // AgedAccountsPayable.Control11.SETVALUE(false);
        // AgedAccountsPayable.Control15.SETVALUE(HeadingTypeOption::"Number of Days");
        AgedAccountsPayable.PrintDetails.SETVALUE(false);
        AgedAccountsPayable.HeadingType.SETVALUE(HeadingTypeOption::"Number of Days");
        //BC Upgrade KAPOOV01 <<

        AgedAccountsPayable.SAVEASEXCEL('RTR106 AgedAccountsPayable');
        //HEI.09
    end;

    [RequestPageHandler]
    procedure TrialBalanceByPeriodRequestPagetHandler(var TrialBalancebyPeriod: TestRequestPage "Trial Balance by Period");
    var
        AgingBy: Integer;
    begin
        //HEI.09
        //HEI.16>>
        //TrialBalancebyPeriod.StartingDate.SETVALUE(010117D);
        //TrialBalancebyPeriod.StartingDate.SETVALUE(DMY2DATE(1,1,2017));
        TrialBalancebyPeriod.StartingDate.SETVALUE(DMY2DATE(1, 1, 2020));//HEI.24
        //HEI.16<<

        TrialBalancebyPeriod.SAVEASEXCEL('RTR106 TrialBalanceByPeriod');
        //HEI.09
    end;

    [PageHandler]
    procedure AccScheduleOverviewPageHandlerPageHandler(var AccScheduleOverview: TestPage "Acc. Schedule Overview");
    var
        ViewBy: Option Day,Week,Month,Quarter,Year,"Accounting Period";
    begin
        AccScheduleOverview.PeriodType.SETVALUE(ViewBy::Year);

        //export to excel - commented because of the DLL mising
        //AccScheduleOverview.Action292.INVOKE;
        //HEI.09 created
    end;

    [ReportHandler]
    procedure RPMBalanceAccountinReportHandler(var RPMBalanceAccounting: Report "RPM Balance Accounting CBN");
    begin
    end;

    [ModalPageHandler]
    //procedure VendorModalPageHandler(var VendorList: TestPage "Vendor List"); //BC Upgrade KAPOOV01
    procedure VendorModalPageHandler(var VendorList: TestPage "Vendor Lookup"); //BC Upgrade KAPOOV01 Page name-> Vendor List changed to Vendor Lookup 
    begin
    end;

    [PageHandler]
    procedure PostedSalesInvModalPageHandler(var PostedSalesInvoice: TestPage "Posted Sales Invoice");
    begin
    end;

    [PageHandler]
    procedure FALedgerEntriesPageHandler(var FALedgerEntries: TestPage "FA Posting Type Setup");
    begin
    end;

    [ReportHandler]
    procedure VendorTrialBalanceReportHandler(var VendorTrialBalance: Report "Vendor - Trial Balance");
    begin
        //HEI.11
    end;

    [RequestPageHandler]
    procedure HeimatchReportHandler(var HeiMatchExportInvBalance: TestRequestPage "HeiMatch Export Inv. & Balance");
    var
        Text600: TextConst ENU = 'CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|All Files (*.*)|*.*', FRA = 'CSV Files (*.csv)|*.csv|Fichier Texte (*.txt)|*.txt|Tous Fichiers (*.*)|*.*';
        Filename: Text;
        Text001: Label 'Save Heimatch file';
        Text002: Label 'heimatch.csv';
        lUnitTestingValue: Record "Unit Testing Value FND";
        lLastDayOfTheMonth: Date;
        lMonth: Integer;
        lYear: Integer;
    begin
        //HEI.11
        HeiMatchExportInvBalance.ExportDataType.SETVALUE(0);

        lUnitTestingValue.RESET;
        lUnitTestingValue.GET('RTR102', COMPANYNAME, DATABASE::"G/L Entry");
        HeiMatchExportInvBalance.YearFilter.SETVALUE(lUnitTestingValue."Value 2");

        HeiMatchExportInvBalance.PeriodTypeFilter.SETVALUE(1);
        HeiMatchExportInvBalance.PeriodFilter.SETVALUE(lUnitTestingValue.Value);

        EVALUATE(lMonth, lUnitTestingValue.Value);
        EVALUATE(lYear, lUnitTestingValue."Value 2");
        lLastDayOfTheMonth := CALCDATE('CM', DMY2DATE(1, lMonth, lYear));
        HeiMatchExportInvBalance.NewEndingDate.SETVALUE(lLastDayOfTheMonth);

        HeiMatchExportInvBalance.Calcfilter.SETVALUE(0);
        HeiMatchExportInvBalance.RoundingFactor.SETVALUE(0);

        HeiMatchExportInvBalance.PrevInvPeriodFormula.SETVALUE('-3M');
        HeiMatchExportInvBalance.IncludeOnlyOpen.SETVALUE(true);

        //Filename := FileMgt.SaveFileDialog(Text001,Text002,Text600); //HEI.15 commented
        //HeiMatchExportInvBalance.Control1100710009.SETVALUE(Filename); //HEI.15 commented
        HeiMatchExportInvBalance.Filename.SETVALUE(HeiMatchFileTxt); //HEI.15

        HeiMatchExportInvBalance.OK.INVOKE; //HEI.15 uncommented
        //HEI.11<<
    end;

    [PageHandler]
    procedure CustomerCardPageHandler(var CustomerCard: TestPage "Customer Card");
    begin
        //HEI.11
    end;

    [ReportHandler]
    procedure BankAccDetailTrialBalanceReportHandler(var BankAccDetailTrialBal: Report "Bank Acc. - Detail Trial Bal.");
    var
        BankAccountPostingGroup: Record "Bank Account Posting Group";
        lBankAccount: Record "Bank Account";
    begin
        //HEI.11
        //BankAccDetailTrialBal.SAVEASEXCEL('RTR118-Reconciliation of petty cash'); //BC Upgrade KAPOOV01 blocked-SAVEASEXCEL function as it Scope is ONPREM
    end;

    [ReportHandler]
    procedure DetailTrialBalanceReportHandler(var DetailTrialBalance: Report "Detail Trial Balance");
    var
        BankAccountPostingGroup: Record "Bank Account Posting Group";
        lBankAccount: Record "Bank Account";
    begin
        //HEI.11
        //DetailTrialBalance.SAVEASEXCEL('RTR105-Detail Trial Balance'); //BC Upgrade KAPOOV01 blocked-SAVEASEXCEL function as it Scope is ONPREM
    end;

    [PageHandler]
    procedure GLBalanceCardPageHandler(var GLBalance: TestPage "G/L Balance");
    begin
        //HEI.11
    end;

    [RequestPageHandler]
    //procedure SuggestWorksheetLinesReportHandler(var SuggestWorksheetLines: TestRequestPage "Suggest Worksheet Lines");  //BC Upgrade KAPOOV01 Report- Suggest Worksheet Lines name changed to SuggestWorksheetLinesHeiLite
    procedure SuggestWorksheetLinesReportHandler(var SuggestWorksheetLines: TestRequestPage "SuggestWorksheetLinesHeiLite"); //BC Upgrade KAPOOV01 Report- Suggest Worksheet Lines name changed to SuggestWorksheetLinesHeiLite
    var
        BankAccountPostingGroup: Record "Bank Account Posting Group";
        lBankAccount: Record "Bank Account";
    begin
        //HEI.11
        //HEI.14>>
        UnitTestingValues.GET('RTR104', COMPANYNAME, DATABASE::"Cash Flow Forecast");
        //SuggestWorksheetLines.Control1.SETVALUE(UnitTestingValues.Value); //BC Upgrade KAPOOV01
        SuggestWorksheetLines."ConsiderSource[SourceType::Job]".SETVALUE(UnitTestingValues.Value); //BC Upgrade KAPOOV01
        //HEI.14<<
    end;

    [ModalPageHandler]
    procedure DialogRegisterCashFlowWorksheetPageHandler(var ConfirmDialog: TestPage "ConfirmDialog CBN");
    begin
        //HEI.11
    end;

    [PageHandler]
    procedure ChartOfCashFlowAccountsPageHandler(var ChartofCashFlowAccounts: TestPage "Chart of Cash Flow Accounts");
    begin
        //HEI.11
        //export to excel - commented because of the DLL mising
        //ChartofCashFlowAccounts.Action292.INVOKE;
    end;

    [PageHandler]
    procedure AnalysisByDimPageHandler(var AnalysisbyDimensions: TestPage "Analysis by Dimensions");
    begin
        //HEI.12>>
        AnalysisbyDimensions.ShowMatrix.INVOKE;
        //HEI.12<<
    end;

    [ModalPageHandler]
    procedure AnalysisByDimMatrixModalPageHandler(var AnalysisbyDimensionsMatrix: TestPage "Analysis by Dimensions Matrix");
    begin
        //HEI.12>>
        //AnalysisbyDimensionsMatrix.Action1000000001.INVOKE; //BC Upgrade KAPOOV01 
        AnalysisbyDimensionsMatrix."Export to CIL3".INVOKE; //BC Upgrade KAPOOV01 
        //HEI.12<<
    end;

    [RequestPageHandler]
    procedure FlatFileCIL3ICRequestPageHandler(var ExportCIL3: TestRequestPage "Export CIL3 RTR");//Bc Upgrade YADAVM09,28.04.26<<
    begin
        //HEI.12>>
        //BC Upgrade KAPOOV01  >>
        // ExportCIL3.Control1100710006.SETVALUE('2021');
        // ExportCIL3.Control1100710007.SETVALUE('Quarter');
        // ExportCIL3.Control1100710008.SETVALUE('1');
        ExportCIL3.YearFilter.SETVALUE('2021');
        ExportCIL3.PeriodTypeFilter.SETVALUE('Quarter');
        ExportCIL3.PeriodFilter.SETVALUE('1');
        //BC Upgrade KAPOOV01  <<
        //Mark "Only Balance Sheet"
        //BC Upgrade KAPOOV01  >>
        //ExportCIL3.Control1100710017.SETVALUE(true);
        ExportCIL3.OnlyBalSheet.SETVALUE(true);
        //BC Upgrade KAPOOV01  <<

        //FileName := FileMgt.SaveFileDialog(Text002,FileName,FileMgt.GetToFilterText('','.txt')); //HEI.15 commented
        //ExportCIL3.Control1100710011.SETVALUE(FileName); //HEI.15 commented
        //BC Upgrade KAPOOV01  >>
        //ExportCIL3.Control1100710011.SETVALUE(SaveCIL3ICFile); //HEI.15
        ExportCIL3.ClientFileName.SETVALUE(SaveCIL3ICFile); //HEI.15
        //BC Upgrade KAPOOV01  <<

        ExportCIL3.OK.INVOKE;
        //HEI.12<<
    end;

    [RequestPageHandler]
    procedure ExportConsolidationRequestPageHandler(var ExportConsolidation: TestRequestPage "Export Consolidation");
    var
        AllDim: Text[1024];
    begin
        //HEI.12<<
        if ExportConsolidation.FileFormat.VALUE = 'Version 4.00 or Later (.xml)' then
            //FileName := FileMgt.SaveFileDialog(Text002,FileName,FileMgt.GetToFilterText('','.xml')) //HEI.15 commented
            FileName := ExportConsolidationXML //HEI.15
        else
            //FileName := FileMgt.SaveFileDialog(Text002,FileName,FileMgt.GetToFilterText('','.txt')); //HEI.15 commented
            FileName := ExportConsolidationTxt; //HEI.15
        ExportConsolidation.StartDate.SETVALUE('010121D');
        ExportConsolidation.EndDate.SETVALUE('010121D');
        ExportConsolidation.ClientFileNameControl.SETVALUE(FileName);
        //BC Upgrade KAPOOV01 >>
        //ExportConsolidation.Control5.ASSISTEDIT;
        ExportConsolidation.ColumnDim.ASSISTEDIT;
        //BC Upgrade KAPOOV01 <<
        //HEI.33>>
        //BC Upgrade KAPOOV01 >>
        //AllDim := ExportConsolidation.Control5.VALUE;
        AllDim := ExportConsolidation.ColumnDim.VALUE;
        //BC Upgrade KAPOOV01 <<
        if STRLEN(AllDim) <= 250 then
            ExportConsolidation.OK.INVOKE
        else
            ExportConsolidation.Cancel.INVOKE;
        //HEI.33<<
        //HEI.12>>
    end;

    [ModalPageHandler]
    procedure DimensionSelectionModalPageHandler(var DimensionSelectionMultiple: TestPage "Dimension Selection-Multiple");
    begin
        //HEI.12<<
        //HEI.33>>
        //DimensionSelectionMultiple.SelectAll.SETVALUE(TRUE);
        DimensionSelectionMultiple.Selected.SETVALUE(true);
        //HEI.33<<
        DimensionSelectionMultiple.OK.INVOKE;
        //HEI.12>>
    end;

    [ModalPageHandler]
    procedure BankAccountCardModalPageHandler(var PaymentBankAccountCard: TestPage "Payment Bank Account Card");
    begin
        PaymentBankAccountCard.OK.INVOKE; //HEI.12
    end;

    [PageHandler]
    procedure ApplyGeneralLedgerEntriesModalPageHandler(var ApplyGenlLedgerEntries: TestPage "Apply Gen Ledger Entries CBN");
    begin
        //HEI.12<<
        //Click on "Automatic Application" from the Navigate tab to apply the opened transactions
        //BC Upgrade KAPOOV01 >>
        //ApplyGenlLedgerEntries.Action1100710008.INVOKE;
        ApplyGenlLedgerEntries."&Automatic application".INVOKE;
        //BC Upgrade KAPOOV01 <<

        //Click on "Post Application" from the Navigate tab
        if ApplyGenlLedgerEntries."Applies-to ID".VALUE <> '' then//HEI.33
                                                                  //BC Upgrade KAPOOV01 >>
                                                                  //ApplyGenlLedgerEntries.Action1010010.INVOKE;
            ApplyGenlLedgerEntries."Post Application".INVOKE;
        //BC Upgrade KAPOOV01 <<

        //Select "Closed" in the field Include Entries in the options tab of the displayed window
        ApplyGenlLedgerEntries.IncludeEntryFilter.SETVALUE('Closed');

        ApplyGenlLedgerEntries.CLOSE;
        //HEI.12>>
    end;

    [ModalPageHandler]
    procedure BankReconcilationCardModalPageHandler(var BankAccReconciliation: TestPage "Bank Acc. Reconciliation");
    begin
        //HEI.12>>
    end;

    [RequestPageHandler]
    procedure SuggestWorksheetLinesRequestPageHandler(var SuggestWorksheetLines: TestRequestPage "Suggest Worksheet Lines");
    begin
        //HEI.12<<
        //BC Upgrade KAPOOV01 >>
        //SuggestWorksheetLines.Control1.SETVALUE(CashFlowForecastCard."No.");
        SuggestWorksheetLines.CashFlowNo.SETVALUE(CashFlowForecastCard."No.");
        //BC Upgrade KAPOOV01 <<
        SuggestWorksheetLines.OK.INVOKE;
        //HEI.12>>
    end;

    [ModalPageHandler]
    procedure LocationsModalPageHandler(var LocationList: TestPage "Location List");
    begin
        //HEI.12
        LocationList.OK.INVOKE;
    end;

    [RequestPageHandler]
    procedure GLRegistersRequestPage(var GLRegister: TestRequestPage "G/L Register");
    var
        GLRegisterRec: Record "G/L Register";
    begin
        GLRegister."G/L Register".SETFILTER("No.", FORMAT(GLRegisterRec."No."));
    end;

    [ModalPageHandler]
    procedure DimensionSetEntriesModalPageHandler(var EditDimensionSetEntries: TestPage "Edit Dimension Set Entries");
    begin
        //HEI.16>>
        if not EditDimensionSetEntries.FINDFIRSTFIELD("Dimension Code", CCCDimensionValue."Dimension Code") then begin
            EditDimensionSetEntries.NEW;
            EditDimensionSetEntries."Dimension Code".SETVALUE(CCCDimensionValue."Dimension Code");
            EditDimensionSetEntries.DimensionValueCode.SETVALUE(CCCDimensionValue.Code);
        end;

        if not EditDimensionSetEntries.FINDFIRSTFIELD("Dimension Code", BrandDimensionValue."Dimension Code") then begin
            EditDimensionSetEntries.NEW;
            EditDimensionSetEntries."Dimension Code".SETVALUE(BrandDimensionValue."Dimension Code");
            EditDimensionSetEntries.DimensionValueCode.SETVALUE(BrandDimensionValue.Code);
        end;
        //HEI.16<<
        //HEI.21>>
        if not EditDimensionSetEntries.FINDFIRSTFIELD("Dimension Code", MVMTDimensionValue."Dimension Code") then begin
            EditDimensionSetEntries.NEW;
            EditDimensionSetEntries."Dimension Code".SETVALUE(MVMTDimensionValue."Dimension Code");
            EditDimensionSetEntries.DimensionValueCode.SETVALUE(MVMTDimensionValue.Code);
        end;
        //HEI.21<<
    end;

    local procedure ClearVariables(TestScriptCode: Code[20]);
    begin
        //HEI.16>>
        CLEAR(PaymentReconciliationJnl);
        CLEAR(GLRegisterNo);
        CLEAR(FileName);
        CLEAR(AdjustExchangeRates2);
        CLEAR(AdjustExchangeRates3);
        CLEAR(AdjustExchangeRates4);
        CLEAR(AdjustExchangeRates5);
        CLEAR(AdjustExchangeRates6);
        CLEAR(AdjustExchangeRates);
        CLEAR(PostExpcostforItemCharge);
        CLEAR(CashFlowForecastCard);

        InitSetupData(TestScriptCode);
        //HEI.16<<
    end;

    local procedure InitSetupData(TestScriptCode: Code[20]);
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        UserSetup: Record "User Setup";
        ApprovalUserSetup: Record "User Setup";
        JobQueueEntry: Record "Job Queue Entry";
        CompanyInformation: Record "Company Information";
        SalesPrice: Record "Sales Price";
        SalesPrice2: Record "Sales Price";
        RestrictedRecord: Record "Restricted Record";
        ApprovalEntry: Record "Approval Entry";
    begin
        //HEI.16>>
        //Setup current user for Interface Job Queue User ID
        GeneralInterfaceSetup.GET;
        if GeneralInterfaceSetup."Interface Job Queue User ID" <> USERID then begin
            GeneralInterfaceSetup."Interface Job Queue User ID" := USERID;
            GeneralInterfaceSetup.MODIFY;
        end;

        //Start Job Queue Entry with category NOTIFYNOW
        JobQueueEntry.SETRANGE("Job Queue Category Code", 'NOTIFYNOW');
        JobQueueEntry.MODIFYALL(Status, JobQueueEntry.Status::Ready);

        //Update E-mail address for all User Setup
        UserSetup.SETFILTER("E-Mail", '<>%1', '');
        if UserSetup.FINDSET then
            UserSetup.MODIFYALL("E-Mail", 'unittesting@heineken.com');

        ApprovalUserSetup.GET(USERID);
        UserSetup.RESET;
        UserSetup.SETRANGE("Unlimited Sales Approval", true);
        if UserSetup.FINDFIRST then
            ApprovalUserSetup."Approver ID" := UserSetup."User ID"
        else begin
            UserSetup.SETRANGE("Unlimited Sales Approval");
            UserSetup.SETRANGE("Unlimited Purchase Approval", true);
            if UserSetup.FINDFIRST then
                ApprovalUserSetup."Approver ID" := UserSetup."User ID";
        end;

        UserSetup.RESET;
        //UserSetup.SETRANGE("Unlimited Cr. Limit Customer", true); //BC Upgrade KAPOOV01 DRINK-IT
        if UserSetup.FINDFIRST then
            //ApprovalUserSetup."Credit Limit Approver ID" := UserSetup."User ID"; //BC Upgrade KAPOOV01 DRINK-IT

        UserSetup.RESET;
        //UserSetup.SETRANGE("Unlimited Deposit Limit Cust.", true); //BC Upgrade KAPOOV01 DRINK-IT
        if UserSetup.FINDFIRST then
            //ApprovalUserSetup."Deposit Limit Approver ID" := UserSetup."User ID"; //BC Upgrade KAPOOV01 DRINK-IT

        UserSetup.RESET;
        //UserSetup.SETRANGE("Unlimited Overdue Approval", true); //BC Upgrade KAPOOV01 DRINK-IT
        if UserSetup.FINDFIRST then
            //ApprovalUserSetup."Overdue Approver ID" := UserSetup."User ID"; //BC Upgrade KAPOOV01 DRINK-IT

        ApprovalUserSetup.MODIFY;

        CompanyInformation.GET;
        if CompanyInformation."E-Mail" = '' then begin
            CompanyInformation."E-Mail" := 'companyemail@heineken.com';
            CompanyInformation.MODIFY;
        end;

        //Remove Restricted Records
        if not RestrictedRecord.ISEMPTY then
            RestrictedRecord.DELETEALL;

        //Remove existing Approval Entries for current User ID
        ApprovalEntry.SETRANGE("Table ID", 232);
        ApprovalEntry.SETRANGE("Sender ID", USERID);
        ApprovalEntry.DELETEALL;

        COMMIT;
        //HEI.16<<
    end;

    [PageHandler]
    procedure RTR151GenJnlPageHandler(var GeneralJournal: TestPage "General Journal");
    begin
        //HEI.25>>
        GeneralJournal.Post.INVOKE;
        //HEI.25<<
    end;

    [ConfirmHandler]
    procedure ConfirmationHandlerRTR119(Question: Text[1024]; var Reply: Boolean);
    var
        DocumentNotPostedClosePageQst: TextConst ENU = 'The document has not been posted.\Are you sure you want to exit?', FRA = 'Le document n''a pas été validé.\Voulez-vous vraiment quitter ?';
        PostReceiptQst: TextConst ENU = 'Do you want to post the receipt?', FRA = 'Souhaitez-vous valider cette réception ?';
        PostDocumentQst: TextConst ENU = 'Do you want to post the %1?', FRA = 'Souhaitez-vous valider le document %1 ?';
        PostJnlLineQst: TextConst ENU = 'Do you want to post the journal lines?', FRA = 'Souhaitez-vous valider les lignes de la feuille ?';
        CreateOrderQst: TextConst ENU = 'Do you want to create an order from the blanket order?', FRA = 'Souhaitez-vous transformer la commande ouverte en commande ?';
        ReceiveQst: TextConst ENU = 'Do you want to receive the %1 ?', FRA = 'Voulez-vous réceptionner le %1 ?';
        PostPaymReconJnlQst: Label 'The statement ending balance differs from the bank account after posting. Continue to post ?';
        ReplaceEntriesMassUploadrQst: Label 'Are you sure you want to replace entries for Journal Template Name RTR.';
    begin
        //HEI.35>>
        Reply := false;
        //HEI.35<<
    end;

    [Test]
    [HandlerFunctions('CreateNewEbfMatrixRestrictionModalPageHandler')]
    procedure "BPM047-CreateNewEbfMatrixRestriction"();
    var
        Dimensions: TestPage Dimensions;
        OPCOSetup: Record "General OpCo Setup FND";
    begin
        //HEI.69>>
        OPCOSetup.GET;
        if OPCOSetup."Enable New EBF Matrix Version" then begin
            Dimensions.OPENEDIT;
            Dimensions.FILTER.SETFILTER(Code, 'CCC');
            Dimensions.SetupEbf.INVOKE;
            Dimensions.OK.INVOKE;
        end;
        //HEI.69<<
    end;

    [ModalPageHandler]
    procedure CreateNewEbfMatrixRestrictionModalPageHandler(var EbfCombinations: TestPage "EBF Matrix CBN");
    var
        ReversalDate: Date;
    begin
        //HEI.69
        EbfCombinations.OK.INVOKE;
        //HEI.69
    end;

    //BC Upgrade KAPOOV01 Defined ModalPageHandler >>
    [ModalPageHandler]
    procedure PostPmtsAndRecBankAccHandler(var PostPmtsAndRecBankAcc: TestPage "Post Pmts and Rec. Bank Acc.")
    begin
        // Optional:
        // PostPmtsAndRecBankAcc.StatementDate.SETVALUE(Today);

        PostPmtsAndRecBankAcc.OK().Invoke();
    end;
    //BC Upgrade KAPOOV01 Defined ModalPageHandler <<


    //BC Upgrade KAPOOV01 Added procedure CreateExcelInTempBlob >>
    local procedure CreateExcelInTempBlob()
    var
        ExcelBuf: Record "Excel Buffer" temporary;
    begin
        // HEADER ROW
        ExcelBuf.EnterCell(ExcelBuf, 1, 1, 'Posting Date', false, false, false);
        ExcelBuf.EnterCell(ExcelBuf, 1, 2, 'Document No.', false, false, false);
        ExcelBuf.EnterCell(ExcelBuf, 1, 3, 'Account No.', false, false, false);
        ExcelBuf.EnterCell(ExcelBuf, 1, 4, 'Amount', false, false, false);
        // DATA ROW
        ExcelBuf.EnterCell(ExcelBuf, 2, 1, Format(Today()), false, false, false);
        ExcelBuf.EnterCell(ExcelBuf, 2, 2, 'DOC001', false, false, false);
        ExcelBuf.EnterCell(ExcelBuf, 2, 3, '11001001', false, false, false);
        ExcelBuf.EnterCell(ExcelBuf, 2, 4, '1000', false, false, false);

        // WRITE TO STREAM
        TempBlob.CreateOutStream(OutStr);

        ExcelBuf.CreateNewBook('Sheet1');
        ExcelBuf.WriteSheet('Sheet1', CompanyName(), UserId());
        ExcelBuf.CloseBook();

        ExcelBuf.SaveToStream(OutStr, true);

        TempBlob.CreateInStream(InStr);
    end;
    //BC Upgrade KAPOOV01 Added procedure CreateExcelInTempBlob <<
}



