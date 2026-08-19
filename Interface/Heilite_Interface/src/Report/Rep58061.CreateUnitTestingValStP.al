report 58061 "Create Unit Testing Val StP"
{
    // version TS,HEI.69

    // HEI.01 RITM2738652 IBM SHIVAS05 14.12.2021 # Automation StP Test Scripts
    //   # New Report created to setup Unit Testing Values automatically
    // HEI.02 RITM2738652 IBM NANDIS01 23.12.2021 #Automation StP Test Scripts
    //   # New function - PCN008,Cancel Purchase Order
    //   # New function - PCN009_CreateReturnorderfromBlanketOrder
    //   # New function - PCN006_UpdateSpotPOorVLcalloff
    //   # New function - PCN025_UpdatePxQreturncalloff
    // HEI.03 RITM2738652 IBM SHIVAS05 30.12.2021 # Automation StP Test Scripts
    //   # Adding some filter to find the unit testing values
    // HEI.04 RITM2738652 IBM NANDIS01 04.01.2022 #Automation StP Test Scripts
    //   # Added Code for PTP024
    // HEI.05 RITM2738652 IBM SHIVAS05 25.01.2022 # Automation StP Test Scripts
    //   # Adjusting the unit testing value and adding and Removing some more filter to find the unit testing values
    //   # Creating FindGLPTP084 And FindVendorPTP084 for PTP084 Test script
    // HEI.06 RITM2738652 IBM SHIVAS05 15.02.2022 # Automation StP Test Scripts
    //   # Create dynamic Data for P1 Script
    //   # New option added to create automatically Warehouse Employees for UserID
    // HEI.07 RITM2964345 IBM SAXENA03 28.03.2022 # Automation StP Test Scripts
    //   # Added Setparameters function to SET request Page values as TRUE
    //   # Code added to Hide messages.
    // HEI.08 RITM2738652 IBM SHIVAS05 31.03.2022 # Automation StP Test Scripts
    //   # New option added to create automatically User General Journal for UserID
    //   # Adding CCC Dimesion for PTP012
    // HEI.09 RITM2738652 IBM MAJUMS03 04.03.2022 #Automation StP Test Scripts
    //   # Added Code for PTP058
    // HEI.10 RITM2738652 IBM SHIVAS05 05.04.2022 # Automation StP Test Scripts
    //   # Create dynamic Data for P2 Script
    // HEI.12 RITM2987058 IBM SHIVAS05 28.04.2022 # Automation StP Test Scripts
    //   # Add MVMT Dimension on PTP136
    //   # Add CCC Dimension on PRD107
    //   # Add one more filter for FindVendorPTP102
    //   # Add MVMT Dimension on PTP091
    //   # Find CCC dimension on the basis of Item for PTP018
    // HEI.13 RITM2987058 IBM SHIVAS05 05.05.2022 # Automation StP Test Scripts
    //   # Put CreateUnitTestingValues('PTP058','Negative PO CN') And EnableWorkflows before HideDialogs Functionality
    // HEI.14 RITM2987058 IBM NANDIS01 20.05.2022 # Automation StP Test Scripts
    //   # create new function FindVendorPTP053
    //   # Change the unit testing value for PTP053
    //   # Add one more filter on FindVendorForPayment function
    //   # Remove one filter in FindVendorForPTP079 function
    //   # Remove one filter in FindVendorForInvoice function
    //   # Replace one filter in FindGenJournalBatchNetting and FindVendorForInvoice function
    //   # Filtertaion fixed for TS - PTP024, PCN009, PCN025, PTP027, PTP028, PTP041, PTP042
    // HEI.15 RITM2987058 IBM SHIVAS05 03.06.2022 # Automation StP Test Scripts
    //   # Adjusting FindDimension filter
    //   # adding one validation on FindLocation
    // HEI.16 RITM2987058 IBM SHIVAS05 14.06.2022 # StP Automation Test Script
    //   # Fix After Dynamic Q testing
    // HEI.17 RITM2987058 IBM SHIVAS05 04.07.2022 # StP Automation Test Script for Phase III
    //   # create dynamic data for "CHG2123487_CMGMandatoryonHeiliteBaseSPOTPOforLandedCosts"
    // HEI.18 RITM2987058 IBM NANDIS01 05.07.2022 # StP Automation Test Script for Phase II - PCN009
    //   # DAta generation for PCN009
    // HEI.19 RITM2987058 IBM SHIVAS05 03.08.2022 # Automation StP Test Scripts
    //   # Added code for Algeria
    // HEI.20 RITM2987058 IBM SHIVAS05 04.08.2022 # Automation StP Test Scripts
    //   # Added code for Boukin
    // HEI.21 RITM2987058 IBM SHIVAS05 11.08.2022 # Automation StP Test Scripts
    //   # Added code for rwanda
    // HEI.22 RITM2987058 IBM SHIVAS05 16.08.2022 # Automation StP Test Scripts
    //   # Added code for Congo
    // HEI.23 RITM2987058 IBM SHIVAS05 17.08.2022 # Automation StP Test Scripts
    //   # Added code for Mozambique
    // HEI.24 RITM2987058 IBM SHIVAS05 17.08.2022 # Automation StP Test Scripts
    //   # Added code for Congo
    // HEI.25 RITM2987058 IBM SHIVAS05 22.08.2022 # Automation StP Test Scripts
    //   # Added code for P2 Algeria
    // HEI.26 RITM2987058 IBM SHIVAS05 23.08.2022 # Automation StP Test Scripts
    //   # Added code for P2 Suriname
    // HEI.27 RITM2987058 IBM SHIVAS05 24.08.2022 # Automation StP Test Scripts
    //   # Added code for P2 Congo
    // HEI.28 RITM2987058 IBM SHIVAS05 25.08.2022 # Automation StP Test Scripts
    //   # Added code for P2 Lebanon
    // HEI.29 RITM2987058 IBM SHIVAS05 25.08.2022 # Automation StP Test Scripts
    //   # Added code for P1 Burundi
    // HEI.30 RITM2987058 IBM SHIVAS05 26.08.2022 # Automation StP Test Scripts
    //   # Added code for P2 Rwanda
    // HEI.31 RITM2987058 IBM SHIVAS05 29.08.2022 # Automation StP Test Scripts
    //   # Added code for P2 LaReunion
    // HEI.32 RITM2987058 IBM SHIVAS05 30.08.2022 # Automation StP Test Scripts
    //   # Added code for PRD107 LaReunion
    // HEI.33 RITM2987058 IBM SHIVAS05 06.09.2022 # Automation StP Test Scripts
    //   # Added code for P2 Lebanon
    // HEI.34 RITM2987058 IBM NANDIS01 27.09.2022 # Automation StP Test Scripts
    //   # Fix on PCN027 to find a contract with unblocked Vendor
    // HEI.35 RITM2987058 IBM NANDIS01 10.10.2022 # Automation StP Test Scripts
    //   # Fix on function - FindVendorPTP102 and PTP011 and PTP058
    // HEI.36 RITM2987058 IBM NANDIS01 11.10.2022 # Automation StP Test Scripts
    //   # Fix on function - PTP011 and PTP058
    // HEI.37 RITM2987058 IBM SRIVAS07 21.10.2022 # Automation StP Test Scripts
    //   # Fix on function - FindVendor()
    // HEI.38 RITM2987058 IBM SRIVAS07 25.10.2022 # Automation StP Test Scripts
    //   # Fix on function - FindVendor()
    // HEI.39 RITM2987058 IBM SRIVAS07 25.11.2022 # Automation StP Test Scripts
    //   # Fix on function - FindVendor()
    // HEI.40 RITM2987058 IBM SRIVAS07 02.01.2023 # Automation StP Test Scripts
    //   # Fix on function - FindPLForItem()
    // HEI.41 RITM2987058 IBM SRIVAS07 09.01.2023 # Automation StP Test Scripts
    //   # Fix on function - FindPLForItem()
    //   # Fix on function - FindPLForItem_PCN009()
    // HEI.42 RITM2987058 IBM SRIVAS07 17.01.2023 # Automation StP Test Scripts
    //   # Fix on function - FindVendorPTP102()
    // HEI.43 RITM2987058 IBM SRIVAS07 30.01.2023 # Automation StP Test Scripts
    //   # code added in function - CreateUnitTestingValues()
    //   # code added in function - OnPostReport()
    // HEI.44 RITM2987058 IBM SRIVAS07 09.03.2023 # Automation StP Test Scripts
    //   # code added in function - FindDimension2()
    //   # code added in function - FindDimensionforItemCharge()
    //   # code added in function - FindDimensionforItem()
    //   # code added in function - FindCCCDimensionforItemCharge()
    // HEI.45 RITM2987058 IBM SRIVAS07 17.03.2023 # Automation StP Test Scripts
    //   # CreateGenJournalUsers function added to Create User Line for Payments
    // HEI.46 RITM3323086  IBM SAXENA03 20-03-2023
    //   # Added code to disable Change Log Setup
    // HEI.47 RITM2987058 IBM SRIVAS07 28.03.2023 # Automation StP Test Scripts
    //   # GetGenJournalBatch New Function created
    // HEI.48 RITM2987058 IBM SRIVAS07 29.03.2023 # Automation StP Test Scripts
    //   # code added in function - FindDimension2()
    //   # code added in function - FindDimensionforItemCharge()
    //   # code added in function - FindDimensionforItem()
    //   # code added in function - FindCCCDimensionforItemCharge()
    // HEI.49 RITM2987058 IBM SRIVAS07 05.04.2023 # Automation StP Test Scripts
    //   # New Function for GetGenJournalTemplate
    //   # Added Code GetGenJournalBatch
    // HEI.50 RITM2987058 IBM SRIVAS07 26.04.2023 # Automation StP Test Scripts
    //   # Added filter in FindGenJournalBatch
    // HEI.51 RITM2987058 IBM SRIVAS07 03.05.2023 # Automation StP Test Scripts
    //   # Added New Dimension Value in CreateUnitTestingValues()
    // HEI.52 CHG2185291 IBM SAXENA03 10.05.2023 # Automation Test Scripts
    //   # Added code for Consolidation of Test Script objects
    // HEI.53 RITM2987058 IBM SRIVAS07 16.05.2023 # Automation StP Test Scripts
    //   # Code added to the Function GetGenJournalTemplate()
    //   # Code added to FindVendor()
    // HEI.54 RITM2987058 IBM SRIVAS07 17.05.2023 # Automation StP Test Scripts
    //   # Code added to FindVendor()
    // HEI.55 CHG2208369 IBM SRIVAS07 14.06.2023 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code added to the Function GetGenJournalTemplate()
    //   # Code added to FindVendor()
    // HEI.56 CHG2211315 IBM SRIVAS07 05-07-2023 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code added to FindVendor()
    // HEI.57 CHG2223804 IBM SRIVAS07 12-10-2023 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code added to FindItemPRD107()
    // HEI.58 CHG2237616 IBM SRIVAS07 01-02-2024 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code added in OnPostReport Trigger.
    // HEI.59 CHG2259302 IBM SRIVAS07 05-08-2024 # Heilite BASE Test Script Adjustment and Optimizations | WEEK32 2024
    //   # Code added in OnPostReport()
    // HEI.60 CHG2264796 SHARMP16 03-09-2024 # Heilite BASE Test Script Adjustment and Optimizations | WEEK36 2024
    //   # Code added in FindVendor()
    // HEI.61 CHG2267867 SHARMP16 06-09-2024 # Heilite BASE Test Script Adjustment and Optimizations | WEEK36 2024
    //   # Code added in FindVendor()
    // HEI.63 CHG2288704 CHOUDS08 11-02-2025 # HeiLite BASE Test Script Adjustment and Optimizations | WEEK06 2025
    //   # Code added in FindSRMBlanketOrderPCN002()
    // HEI.64 CHG2298037 CHOUDS08 07-04-2025 WEEK 15 2025 Test Script Optimsation and BUg fix
    //   # Modified Code in FindPLForItem() to remove earlier change made where Purchase Header was being selected based on which Items are unblocked.
    //   # Added code in FindSRMBlanketOrderPCN002() to ensure Purchase Line Price records linked to the Blanket Purchase Order align with its expiry dates and are currently available.
    // HEI.65 CHG2299696 CHOUDS08 16-04-2025 WEEK 16 2025 Test Script OptimIsation
    //   # Added code in FindPLForItem_PCN009 to ensure Purchase Line Price records linked to the Blanket Purchase Order align with its expiry dates and are currently available without looping through the value.
    // HEI.66 CHG2302557 SAHAL01 16.05.2025 WEEK 19 2025 Test Script Optimisation
    //   # Created New Function - ValidatePOBlanketOrder
    //   # Added Code in function RT_PCN027_CreateCalloff
    // HEI.67 CHG2307367 SAHAL01 04.06.2025 WEEK 23-24 2025 Test Script Optimisation
    //   # Added Code in function RT_PCN027_CreateCalloff
    // HEI.68 CHG2307923 SAHAL01 10.07.2025 Test Script - Block Payment for Invoices with Price Difference higher than the tolerance
    //   # Created New Test Scripts processes.
    // HEI.69 CHG2316128 SAHAL01 05.08.2025 Test Script - HeiLite BASE Test Script Adjustment and Optimizations
    //   # Added Code in function - FindPLForChargeItem

    //BC Upgrade KAPOOV01 >>
    //1. Commented Drink-IT Table- Route
    //2. Commented Drink-IT field-"Item Charge Type" of table-"Item Charge"
    //3. Commented procedure FindShippingAgent as it is dependent on Drink-IT Table-Shipping Agent Purch. Price"
    //4. Commented code dependent on DRINK-IT Field-"Payment Journal Tree" of Source Code Setup Table
    //5. Added ApplicationArea Property of Report.
    //6. Old Report ID-50568.
    //BC Upgrade KAPOOV01<< 

    // BC Upgrade PATELS08 >>
    // # Added UsageCategory Property at Report level.
    // # Code Change in procedure CreateWarehouseEmployeesForUser() to remove Zone code from Warehouse Employee GET function as number of fields in primary key is 2.
    // BC Upgrade PATELS08 <<

    Caption = 'Create Unit Testing Values - StP';
    ProcessingOnly = true;
    ApplicationArea = All;

    // BC Upgrade PATELS08 >>
    UsageCategory = Tasks;
    // BC Upgrade PATELS08 <<

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Delete Unit Testing Values"; DeleteExistingValues)
                {
                    Caption = 'Delete Existing Unit Testing Values';
                    ApplicationArea = All;
                }
                field("Create Warehouse Employees"; CreateWarehouseEmployees)
                {
                    Caption = 'Create Warehouse Employees for Current User';
                    ApplicationArea = All;
                }
                field(CreateGenJournalUsers; CreateGenJournalUsers)
                {
                    Caption = 'Create General Journal Users for Current User';
                    ApplicationArea = All;
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

    trigger OnInitReport();
    begin
        //HEI.52>>
        UnitTestingValue.SkipTestScriptExecutionPROD();
        //HEI.52<<
    end;

    trigger OnPostReport();
    var
        UnitTestingValue: Record "Unit Testing Value FND";
        PurchasesPayableSetup: Record "Purchases & Payables Setup";
        Location: Record Location;
    begin
        //HEI.46>>
        ChangeLogSetup.RESET();
        if ChangeLogSetup.GET() then begin
            ChangeLogSetup."Change Log Activated" := false;
            ChangeLogSetup.MODIFY(true);
        end;
        //HEI.46<<
        //HEI.59>>
        Location.RESET();
        if Location.FINDSET(true) then
            Location.MODIFYALL("Sales Gate Entry Mandatory FND", false);
        //HEI.59<<

        //HEI.58<<
        PurchasesPayableSetup.GET();
        PurchasesPayableSetup."Enable PQ to PO check FND" := false;
        PurchasesPayableSetup.MODIFY();
        //HEI.58<<

        //HEI.01 >>
        if DeleteExistingValues then begin
            UnitTestingValue.RESET();
            UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10',
            'PTP010', 'PTP012', 'PTP011', 'LOG026', 'PCN024', 'PTP084', 'PCN023', 'PTP015', 'PTP087', 'PTP018');
            if UnitTestingValue.FINDSET() then
                UnitTestingValue.DELETEALL();
            UnitTestingValue.RESET();
            UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6|%7',
            'STP_PCN003', 'PCN027', 'PCN008', 'PCN009', 'PCN006', 'PCN025', 'PTP024');          //HEI.02
            if UnitTestingValue.FINDSET() then
                UnitTestingValue.DELETEALL();
            //HEI.06>>
            UnitTestingValue.RESET();
            UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10',
            'PCN001', 'PCN002', 'PCN004', 'PCN014', 'PCN017', 'PCN018', 'PCN019', 'PCN020', 'PCN021', 'PCN026');
            if UnitTestingValue.FINDSET() then
                UnitTestingValue.DELETEALL();
            UnitTestingValue.RESET();
            UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10',
            'PCN028', 'PTP040', 'PTP055', 'PTP062', 'PTP074', 'PTP091', 'PTP102', 'PTP133', 'PTP136', 'PRD107');
            if UnitTestingValue.FINDSET() then
                UnitTestingValue.DELETEALL();
            //HEI.06<<
            //HEI.10>>
            UnitTestingValue.RESET();
            UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10',
            'PTP053', 'PTP056', 'PTP057', 'PTP068', 'PTP078', 'PTP079', 'PTP080', 'PTP081', 'PTP082', 'PTP083');
            if UnitTestingValue.FINDSET() then
                UnitTestingValue.DELETEALL();
            UnitTestingValue.RESET();
            UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6|%7',
            'PTP086', 'PTP103', 'PTP132', 'PTP027', 'PTP028', 'PTP041', 'PTP042');
            if UnitTestingValue.FINDSET() then
                UnitTestingValue.DELETEALL();
            //HEI.10<<
            //>>HEI.09
            UnitTestingValue.RESET();
            UnitTestingValue.SETFILTER("Test Script Code", '%1', 'PTP058');
            if UnitTestingValue.FINDSET() then
                UnitTestingValue.DELETEALL();
            //<<HEI.09
            //HEI.17>>
            UnitTestingValue.RESET();
            UnitTestingValue.SETFILTER("Test Script Code", '%1', 'CHG2123487');
            if UnitTestingValue.FINDSET() then
                UnitTestingValue.DELETEALL();
            //HEI.17<<
            //HEI.43>>
            UnitTestingValue.RESET();
            UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3', 'CHG2098629', 'CHG2095531', 'CHG2065545');
            if UnitTestingValue.FINDSET() then
                UnitTestingValue.DELETEALL();
            //HEI.43<<
            //HEI.68>>
            UnitTestingValue.RESET();
            UnitTestingValue.SETFILTER("Test Script Code", '%1|%2', 'PCN029', 'PCN030');
            UnitTestingValue.DELETEALL(false);
            //HEI.68<<
        end;

        CreateUnitTestingValues('PTP010', 'ProcessPOInvoice');
        CreateUnitTestingValues('PTP012', 'ProcessNPOInvoice');
        CreateUnitTestingValues('PTP011', 'ProcessPOCreditMemo');
        CreateUnitTestingValues('LOG026', 'Create Goods Receipt at Warehouse (Purchase Order)');
        CreateUnitTestingValues('PCN024', 'ReleasePO');
        CreateUnitTestingValues('PTP084', 'Process Manual Payment');
        CreateUnitTestingValues('PCN023', 'Create Purchase Order');
        CreateUnitTestingValues('PTP015', 'Create NPO Credit Note');
        CreateUnitTestingValues('PTP087', 'Create NPO Prepayment');
        CreateUnitTestingValues('PTP018', 'Create POInvoice');
        CreateUnitTestingValues('STP_PCN003', 'Create Call-Off From Blanket Order');
        CreateUnitTestingValues('PCN027', 'Create Call-off for Charge Item');
        //HEI.02>>
        CreateUnitTestingValues('PCN008', 'Cancel Purchase Order');
        CreateUnitTestingValues('PCN009', 'Create Return Order from Blanket Order');
        CreateUnitTestingValues('PCN006', 'Update SpotPO or VL call off');
        CreateUnitTestingValues('PCN025', 'Update PxQ return call off');
        //HEI.02<<
        //HEI.06>>
        CreateUnitTestingValues('PCN001', 'Validate Contract Header');
        CreateUnitTestingValues('PCN002', 'Validate Contract Items');
        CreateUnitTestingValues('PCN004', 'Purchase Order Send to Supplier');
        CreateUnitTestingValues('PCN014', 'Display Purchase Order');
        CreateUnitTestingValues('PCN017', 'Create Purchase Quote');
        CreateUnitTestingValues('PCN018', 'Approve Purchase Quote');
        CreateUnitTestingValues('PCN019', 'Create Purchase Order from Purchase Quote');
        CreateUnitTestingValues('PCN020', 'Update Purchase Quote');
        CreateUnitTestingValues('PCN021', 'Reject Purchase Quote');
        CreateUnitTestingValues('PCN026', 'Sent PO to Approval');
        CreateUnitTestingValues('PCN028', 'Approve Purchase Order');
        CreateUnitTestingValues('PTP040', 'Obsolete invoice');
        CreateUnitTestingValues('PTP055', 'Negative testing-NPO Invoice');
        CreateUnitTestingValues('PTP062', 'Create Pay Proposals with same parameters');
        CreateUnitTestingValues('PTP074', 'Execute Payment - Cheques');
        CreateUnitTestingValues('PTP091', 'Automatic clearing on GR or IR Account');
        CreateUnitTestingValues('PTP102', 'Clearing of open items on vendor accounts');
        CreateUnitTestingValues('PTP133', 'Reverse Rejected CN');
        CreateUnitTestingValues('PTP136', 'Reverse Manual Payment');
        CreateUnitTestingValues('PRD107', 'Goods Receipt');
        //HEI.10>>
        CreateUnitTestingValues('PTP053', 'Process NPO Invoice payment method other than Bank');
        CreateUnitTestingValues('PTP056', 'Negative testing PO Invoice');
        CreateUnitTestingValues('PTP057', 'Negative Testing NPO CN');
        CreateUnitTestingValues('PTP068', 'Review and Undo Payment Proposal');
        CreateUnitTestingValues('PTP078', 'Reverse payment Rejected payment');
        CreateUnitTestingValues('PTP079', 'Block Invoice For Payment');
        CreateUnitTestingValues('PTP080', 'Unblock Invoice for payment');
        CreateUnitTestingValues('PTP081', 'Unblock Invoice for payment');
        CreateUnitTestingValues('PTP082', 'Process PtP Netting');
        CreateUnitTestingValues('PTP083', 'Reverse PtP Netting');
        CreateUnitTestingValues('PTP086', 'Reverse Refund');
        CreateUnitTestingValues('PTP103', 'Unapplying of cleared items');
        CreateUnitTestingValues('PTP132', 'Reverse Rejected Invoice');
        CreateUnitTestingValues('PTP027', 'Process Large Invoice');
        CreateUnitTestingValues('PTP028', 'Attach Doc After Posting');
        CreateUnitTestingValues('PTP041', 'Obsolete Credit Note');
        CreateUnitTestingValues('PTP042', 'Check On Invoice Number Allocated Twice');
        CreateUnitTestingValues('CHG2123487', 'CMG mandatory on Heilite Base SPOT PO for Landed Costs');//HEI.17
        //HEI.10<<
        //HEI.68>>
        if PurchasesPayableSetup."Check Tolerance Approval FND" then begin
            if PurchasesPayableSetup."Upper % Tolerance FND" <> 0 then
                CreateUnitTestingValues('PCN029', 'PI_GlobalUpperToleranceLimitPercentage');
            if PurchasesPayableSetup."Upper Amount Tolerance FND" <> 0 then
                CreateUnitTestingValues('PCN030', 'PI_GlobalUpperToleranceLimitAmount');
        end;
        //HEI.68<<
        //HEI.43>>
        CreateUnitTestingValues('CHG2095531', 'Correctly Calculate Payment Terms On Vendor Invoices');
        CreateUnitTestingValues('CHG2098629', 'AutomaticCreationofTransferOrderforImportPO');
        CreateUnitTestingValues('CHG2065545', 'FA_PurchaseOrder');

        CreateUserGeneralJournalForUser(USERID, 0, 4); //HEI.45
        //HEI.43<<
        if CreateWarehouseEmployees then
            CreateWarehouseEmployeesForUser(USERID, '', '');
        //HEI.06<<
        //HEI.08>>
        //For each Journal Type (0 = General, 1 = Item) and Gen. Journal Type (0 = General, 1 = Sales, 2 = Purchases, 3 = Cash Receipts,
        //4 = Payments, 5 = Assets, 6 = Intercompany, 7 = Jobs) call function CreateUserGeneralJournalForUser
        if CreateGenJournalUsers then
            CreateUserGeneralJournalForUser(USERID, 0, 0);
        CreateUnitTestingValues('PTP024', 'NPO Invoice Reversal and Correction'); //HEI.04
        //HEI.08<<
        //HEI.13>>
        CreateUnitTestingValues('PTP058', 'Negative PO CN');
        EnableWorkflows();
        //HEI.13<<
        //>>HEI.07>>
        if not HideDialogs then
            //HEI.07<<
            //HEI.13>>
            //>>HEI.09
            // CreateUnitTestingValues('PTP058','Negative PO CN');
            // //<<HEI.09
            // EnableWorkflows;//HEI.12
            //HEI.13<<
            MESSAGE(UnitTestValuesCreatedMsg);

        // HEI.01 <<
    end;

    var
        UnitTestValuesCreatedMsg: Label 'Unit Testing Values created.';
        DeleteExistingValues: Boolean;
        FirstItemNo: Code[20];
        VendorNo: Code[20];
        RecBinCode: Text;
        TemplateName: Text;
        BlankOrderNoforItem: Code[20];
        BlankOrderNoforChargeItem: Code[20];
        VATProPGr: Text;
        BinContent: Record "Bin Content";
        CreateWarehouseEmployees: Boolean;
        HideDialogs: Boolean;
        CreateGenJournalUsers: Boolean;
        ShippingAgentServicesCode: Text;
        BlankOrderNoforItem_PCN009: Code[20];
        StartPosNoDigits: array[4] of Integer;
        FilterOperator: Text;
        STPTestScript: Codeunit "Unit Testing - Procurement";
        ChangeLogSetup: Record "Change Log Setup";
        UnitTestingValue: Record "Unit Testing Value FND";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        pline: Integer;

    procedure CreateUnitTestingValues(TestCode: Code[20]; TestDescription: Text[100]);
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        UnitTestingValue: Record "Unit Testing Value FND";
        //Route : Record Route; //BC Upgrade KAPOOV01 Commented Drink-IT Table- Route
        ShippingAgentServices: Record "Shipping Agent Services";
        Customer: Record Customer;
        LocationCode: Code[10];
        RouteCode: Code[20];
        LotNo: Code[20];
        DisputeCategoryCode: Code[20];
        JournalTemplateName: Code[10];
        ItemNo: Code[20];
        ZoneCode: Code[10];
        BinCode: Code[10];
        CustomerNo: Code[20];
        PurchasesPayablesSetupL: Record "Purchases & Payables Setup";
        PurchRcptHeaderL: Record "Purch. Rcpt. Header";
        PurchRcptLineL: Record "Purch. Rcpt. Line";
        VendorL: Record Vendor;
        GLAccountL: Record "G/L Account";
        DefaultDimensionL: Record "Default Dimension";
        VendorNoL: Code[20];
        GLAccountNoL: Code[20];
        LocationCodeL: Code[10];
        FoundL: Boolean;
    begin
        //HEI.01 >>
        //>>HEI.09
        //IF TestCode='PTP010' THEN BEGIN
        case TestCode of
            //HEI.36>>
            //'PTP010','PTP058':
            'PTP058':
                //HEI.36<<
                begin
                    //<<HEI.09
                    //Vendor
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindVendor());
                    UnitTestingValue.MODIFY(true);
                    VendorNo := UnitTestingValue.Value;
                    //Location
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindLocation());
                    UnitTestingValue.MODIFY(true);
                    //Item
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindItem());
                    UnitTestingValue.MODIFY(true);
                    //Vendor Bank Account
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Vendor Bank Account", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindBankAccount());
                    UnitTestingValue.MODIFY(true);
                    //Lot No. Information
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Lot No. Information", UnitTestingValue);
                    //UnitTestingValue.VALIDATE(Value,FindLotNo);//HEI.35
                    UnitTestingValue.VALIDATE(Value, FindItemWithLotAndInventory('01', LocationCode, LotNo, ZoneCode, BinCode, 'LOTALL'));//HEI.35
                    UnitTestingValue.MODIFY(true);
                    //Dimension
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindDimension3());
                    UnitTestingValue.VALIDATE("Value 2", FindDimension2());//HEI.21
                    UnitTestingValue.MODIFY(true);
                    //HEI.33>>
                    //Bin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Bin, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindBin());
                    UnitTestingValue.MODIFY(true);
                    //HEI.33<<
                end;
        //>>HEI.09
        end;
        //<<HEI.09
        //HEI.36>>
        case TestCode of
            'PTP010':
                begin
                    //Vendor
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindVendor());
                    UnitTestingValue.MODIFY(true);
                    VendorNo := UnitTestingValue.Value;
                    //Location
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindLocation());
                    UnitTestingValue.MODIFY(true);
                    //Item
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindItem());
                    UnitTestingValue.MODIFY(true);
                    //Vendor Bank Account
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Vendor Bank Account", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindBankAccount());
                    UnitTestingValue.MODIFY(true);
                    //Lot No. Information
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Lot No. Information", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindLotNo());
                    UnitTestingValue.MODIFY(true);
                    //Dimension
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindDimension3());
                    UnitTestingValue.VALIDATE("Value 2", FindDimension2());//HEI.21
                    UnitTestingValue.MODIFY(true);
                    //Bin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Bin, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindBin());
                    UnitTestingValue.MODIFY(true);
                end;
            //HEI.43>>
            'CHG2065545':
                begin
                    //Vendor
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindVendor());
                    UnitTestingValue.MODIFY(true);
                    //Location
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindLocation());
                    UnitTestingValue.MODIFY(true);

                end;
            'CHG2095531':
                begin
                    //Vendor
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindVendor());
                    UnitTestingValue.MODIFY(true);
                    //GL
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindGL());
                    UnitTestingValue.MODIFY(true);
                    //Dimension Value
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindDimension2());
                    UnitTestingValue.VALIDATE("Value 2", FindBrandDimension());
                    UnitTestingValue.VALIDATE("Value 3", FindDimension3());//HEI.51
                    UnitTestingValue.MODIFY(true);
                    //Location
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindLocation());
                    UnitTestingValue.MODIFY(true);
                    //Item
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindItem());
                    UnitTestingValue.MODIFY(true);
                    //Vendor Bank Account
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Vendor Bank Account", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindBankAccount());
                    UnitTestingValue.MODIFY(true);
                    //Lot No. Information
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Lot No. Information", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindLotNo());
                    UnitTestingValue.MODIFY(true);
                    //Bin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Bin, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindBin());
                    UnitTestingValue.MODIFY(true);
                    //Blanket Line
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Purchase Line", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, '1');
                    UnitTestingValue.VALIDATE("Value 3", FindPLForItem());
                    UnitTestingValue.MODIFY(true);
                    //Blanket Header
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Purchase Header", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, BlankOrderNoforItem);
                    UnitTestingValue.MODIFY(true);
                end;
            'CHG2098629':
                begin
                    //Vendor
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindVendor());
                    UnitTestingValue.MODIFY(true);
                    //Location
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindLocation());
                    UnitTestingValue.MODIFY(true);
                    //Item
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindItem());
                    UnitTestingValue.MODIFY(true);
                    //Vendor Bank Account
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Vendor Bank Account", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindBankAccount());
                    UnitTestingValue.MODIFY(true);
                    //Lot No. Information
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Lot No. Information", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindLotNo());
                    UnitTestingValue.MODIFY(true);
                    //Bin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Bin, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindBin());
                    UnitTestingValue.MODIFY(true);
                end;
        //HEI.43<<
        end;
        //HEI.36<<
        //HEI.04>>
        //IF TestCode='PTP012' THEN BEGIN
        case TestCode of
            //HEI.14>>
            //'PTP012','PTP024':
            'PTP012':
                //HEI.14<<
                begin
                    //HE.04<<
                    //Vendor
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindVendor());
                    UnitTestingValue.MODIFY(true);
                    //GL
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindGL());
                    UnitTestingValue.MODIFY(true);
                    //HEI.08>>
                    //Dimension Value
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindDimension2());
                    UnitTestingValue.VALIDATE("Value 2", FindBrandDimension());//HEi.21
                    UnitTestingValue.MODIFY(true);
                    //HEI.08<<
                end;//HEI.04
        end;
        //HEI.14>>
        case TestCode of
            'PTP024':
                begin
                    //Vendor
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindVendorVATPosting());
                    UnitTestingValue.MODIFY(true);
                    //GL
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindGL());
                    UnitTestingValue.MODIFY(true);
                    //Dimension Value
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindDimension2());
                    UnitTestingValue.VALIDATE("Value 2", FindDimension3());//HEI.25
                    UnitTestingValue.MODIFY(true);
                    //HEI.27>>
                    //Location
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindLocation());
                    UnitTestingValue.MODIFY(true);
                    //HEI.27<<
                end;
        end;
        //HEI.14<<
        case TestCode of
            //HEI.36>>
            //'PTP011',
            //'LOG026':
            'PTP011':
                //HEI.36<<
                begin
                    //Vendor
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindVendor());
                    UnitTestingValue.MODIFY(true);
                    VendorNo := UnitTestingValue.Value;
                    //Location
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindLocation());
                    UnitTestingValue.MODIFY(true);
                    //Item
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindItem());
                    UnitTestingValue.MODIFY(true);
                    //Lot No. Information
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Lot No. Information", UnitTestingValue);
                    //UnitTestingValue.VALIDATE(Value,FindLotNo);//HEI.35
                    UnitTestingValue.VALIDATE(Value, FindItemWithLotAndInventory('01', LocationCode, LotNo, ZoneCode, BinCode, 'LOTALL'));//HEI.35
                    UnitTestingValue.MODIFY(true);
                    //HEI.33>>
                    //Bin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Bin, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindBin());
                    UnitTestingValue.MODIFY(true);
                    //HEI.33<<
                end;
        end;
        //HEI.36>>
        case TestCode of
            'LOG026':
                begin
                    //Vendor
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindVendor());
                    UnitTestingValue.MODIFY(true);
                    VendorNo := UnitTestingValue.Value;
                    //Location
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindLocation());
                    UnitTestingValue.MODIFY(true);
                    //Item
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindItem());
                    UnitTestingValue.MODIFY(true);
                    //Lot No. Information
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Lot No. Information", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindLotNo());
                    UnitTestingValue.MODIFY(true);
                    //Bin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Bin, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindBin());
                    UnitTestingValue.MODIFY(true);
                end;
        end;
        //HEI.36<<
        if TestCode = 'PCN024' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendor());
            UnitTestingValue.MODIFY(true);
            //Item
            //InitUnitTestingValues(TestCode,TestDescription,DATABASE::"G/L Account",UnitTestingValue);//HEI.05
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);//HEI.05
            UnitTestingValue.VALIDATE(Value, FindItem());
            UnitTestingValue.MODIFY(true);
        end;
        if TestCode = 'PTP084' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            //UnitTestingValue.VALIDATE(Value,FindVendor);//HEI.05
            UnitTestingValue.VALIDATE(Value, FindVendorPTP084());//HEI.05
            UnitTestingValue.MODIFY(true);
            //GL
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
            //UnitTestingValue.VALIDATE(Value,FindGL);//HEI.05
            UnitTestingValue.VALIDATE(Value, FindGLPTP084());//HEI.05
            UnitTestingValue.MODIFY(true);
            //JournalTemplate&JournalBatch
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Journal Batch", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindGenJournalTemplate());
            UnitTestingValue.VALIDATE("Value 2", FindGenJournalBatch());
            UnitTestingValue.MODIFY(true);
            //HEI.12>>
            //Dimension
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindDimension3());
            UnitTestingValue.MODIFY(true);
            //HEI.12<<
        end;
        if TestCode = 'PCN023' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendor());
            UnitTestingValue.MODIFY(true);
            VendorNo := UnitTestingValue.Value;
            //Location
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindLocation());
            UnitTestingValue.MODIFY(true);
            //Item
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindItem());
            UnitTestingValue.MODIFY(true);
            //Lot No. Information
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Lot No. Information", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindLotNo());
            UnitTestingValue.VALIDATE("Value 2", FindLocation());
            UnitTestingValue.MODIFY(true);
            //UserID
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"User Setup", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, USERID);
            UnitTestingValue.MODIFY(true);
            //Item Charge
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Item Charge", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindItemCharge());
            UnitTestingValue.MODIFY(true);
            //Bin
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Bin, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindBin());
            UnitTestingValue.VALIDATE("Value 2", FindLocation());
            UnitTestingValue.MODIFY(true);
            //HEI.21>>
            //Dimension
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindDimensionforItemCharge());
            UnitTestingValue.MODIFY(true);
            //HEI.21<<
            //HEI.47>>
            InitUnitTestingValues(TestCode, TestDescription, 232, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, GetGenJournalBatch());
            UnitTestingValue.MODIFY(true);
            //HEI.47<<
            //HEI.49>>
            InitUnitTestingValues(TestCode, TestDescription, 80, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, GetGenJournalTemplate());
            UnitTestingValue.MODIFY(true);
            //HEI.49<<
        end;
        if TestCode = 'PTP015' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendor());
            UnitTestingValue.MODIFY(true);
            //GL
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindGL());
            UnitTestingValue.MODIFY(true);
            //VAT Product Posting Group
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"VAT Product Posting Group", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, VATProPGr);//HEI.03
            UnitTestingValue.MODIFY(true);
            //WHT Business Posting Group
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"WHT Business Posting Group FND", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindWHTBusinessPostingGroup());
            UnitTestingValue.MODIFY(true);
        end;
        if TestCode = 'PTP087' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendor());
            UnitTestingValue.MODIFY(true);
            VendorNo := UnitTestingValue.Value;
            //Vendor Bank Account
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Vendor Bank Account", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindBankAccount());
            UnitTestingValue.VALIDATE("Value 2", VendorNo);
            UnitTestingValue.MODIFY(true);
            //HEi.19>>
            //Dimension
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindDimension3());
            UnitTestingValue.MODIFY(true);
            //HEi.19<<
        end;
        if TestCode = 'PTP018' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendor());
            UnitTestingValue.MODIFY(true);
            //WHT Business Posting Group
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"WHT Business Posting Group FND", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindWHTBusinessPostingGroup());
            UnitTestingValue.MODIFY(true);
            //Dimension Value
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
            //UnitTestingValue.VALIDATE(Value,FindDimension2);//HEI.12
            UnitTestingValue.VALIDATE(Value, FindDimensionforItemCharge());//HEI.12
            UnitTestingValue.VALIDATE("Value 2", FindDimension3());//HEi.19
            UnitTestingValue.MODIFY(true);
        end;

        if TestCode = 'STP_PCN003' then begin
            //Blanket Line
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Purchase Line", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, '1');
            //UnitTestingValue.VALIDATE("Value 2",FindLocation);//HEI.05
            UnitTestingValue.VALIDATE("Value 3", FindPLForItem());
            UnitTestingValue.MODIFY(true);
            //Blanket Header
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Purchase Header", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, BlankOrderNoforItem);
            UnitTestingValue.MODIFY(true);
        end;

        if TestCode = 'PCN027' then begin
            //Location
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindLocation());
            UnitTestingValue.MODIFY(true);
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendor());
            UnitTestingValue.MODIFY(true);
            //Blanket Line
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Item Charge", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindPLForChargeItem());
            UnitTestingValue.MODIFY();
            //Blanket Header
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Purchase Header", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, BlankOrderNoforChargeItem);
            UnitTestingValue.MODIFY(true);
            //Dimension Value
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindDimension2());
            UnitTestingValue.MODIFY(true);
        end;
        // HEI.01 <<
        //HEI.02>>
        if TestCode = 'PCN008' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendor());
            UnitTestingValue.MODIFY(true);
            VendorNo := UnitTestingValue.Value;
            //Location
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindLocation());
            UnitTestingValue.MODIFY(true);
            //Item
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindItem());
            UnitTestingValue.MODIFY(true);
            //Purchase Reason code
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Reason Code_Purchase FND", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindPurchReasonCode());
            UnitTestingValue.MODIFY(true);
        end;
        if TestCode = 'PCN009' then begin
            //Purchase Reason code
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Reason Code_Purchase FND", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindPurchReasonCode());
            UnitTestingValue.MODIFY(true);
            //HEI.14>>
            //Lot No. Information
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Lot No. Information", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindLotNo());
            UnitTestingValue.MODIFY(true);
            //HEI.14<<
            //HEI.18>>
            //Blanket Line
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Purchase Line", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, '1');
            UnitTestingValue.VALIDATE("Value 3", FindPLForItem_PCN009());
            //HEI.65>>
            //HEI.64>>
            UnitTestingValue.VALIDATE("Value 2", FORMAT(pline));
            //HEI.64<<
            //HEI.65<<
            UnitTestingValue.MODIFY(true);
            //Blanket Header
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Purchase Header", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, BlankOrderNoforItem_PCN009);
            UnitTestingValue.MODIFY(true);
            //HEI.18<<
        end;
        if TestCode = 'PCN006' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendor());
            UnitTestingValue.MODIFY(true);
            VendorNo := UnitTestingValue.Value;
            //Item Charge
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Item Charge", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindItemCharge());
            UnitTestingValue.MODIFY(true);
            //Location
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindLocation());
            UnitTestingValue.MODIFY(true);
            //Purchase Reason code
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Reason Code_Purchase FND", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindPurchReasonCode());
            UnitTestingValue.MODIFY(true);
        end;
        if TestCode = 'PCN025' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendor());
            UnitTestingValue.MODIFY(true);
            VendorNo := UnitTestingValue.Value;
            //Location
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindLocation());
            UnitTestingValue.MODIFY(true);
            //Blanket Header
            //HEI.14>>
            //InitUnitTestingValues(TestCode,TestDescription,DATABASE::"Purchase Header",UnitTestingValue);
            //UnitTestingValue.VALIDATE(Value,FindPLForItem);
            //UnitTestingValue.MODIFY(TRUE);
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Purchase Header", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, BlankOrderNoforItem);
            UnitTestingValue.MODIFY(true);
            //HEI.14<<
            //Purchase Reason code
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Reason Code_Purchase FND", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindPurchReasonCode());
            UnitTestingValue.MODIFY(true);
        end;
        //HEI.02<<
        //HEI.06>>
        if TestCode = 'PCN001' then begin
            //"Purchase Header"
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Purchase Header", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindSRMBlanketOrder());
            UnitTestingValue.MODIFY(true);
        end;
        if TestCode = 'PCN002' then begin
            //"Purchase Header"
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Purchase Header", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindSRMBlanketOrderPCN002());
            UnitTestingValue.MODIFY(true);
        end;
        if TestCode = 'PCN004' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendor());
            UnitTestingValue.MODIFY(true);
            //Item
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindItem());
            UnitTestingValue.MODIFY(true);
            //Location
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindLocation());
            UnitTestingValue.MODIFY(true);
        end;
        if TestCode = 'PCN014' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendor());
            UnitTestingValue.MODIFY(true);
            //Item
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindItem());
            UnitTestingValue.MODIFY(true);
            //Location
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindLocation());
            UnitTestingValue.MODIFY(true);
            //"Purchase Header"
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Purchase Header", UnitTestingValue);
            FindPLForItem();
            UnitTestingValue.VALIDATE(Value, BlankOrderNoforItem);
            UnitTestingValue.MODIFY(true);
        end;
        if TestCode = 'PCN017' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendor());
            UnitTestingValue.MODIFY(true);
            //Item
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindItem());
            UnitTestingValue.MODIFY(true);
            //Location
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindLocation());
            UnitTestingValue.MODIFY(true);
            //UserID
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"User Setup", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, USERID);
            UnitTestingValue.MODIFY(true);
            //Item Charge
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Item Charge", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindItemCharge());
            UnitTestingValue.MODIFY(true);
        end;
        if TestCode = 'PCN018' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendor());
            UnitTestingValue.MODIFY(true);
            //Item
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindItem());
            UnitTestingValue.MODIFY(true);
            //Location
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindLocation());
            UnitTestingValue.MODIFY(true);
            //UserID
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"User Setup", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, USERID);
            UnitTestingValue.MODIFY(true);
        end;
        case TestCode of
            'PCN019', 'PCN020', 'PCN021', 'PCN026', 'PCN028':
                begin
                    //Vendor
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindVendor());
                    UnitTestingValue.MODIFY(true);
                    //Item
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindItem());
                    UnitTestingValue.MODIFY(true);
                    //Location
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindLocation());
                    UnitTestingValue.MODIFY(true);
                    //UserID
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"User Setup", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, USERID);
                    UnitTestingValue.MODIFY(true);
                    //Payment Terms
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Payment Terms", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindPaymentTerm());
                    UnitTestingValue.MODIFY(true);
                end;
        end;
        case TestCode of
            'PTP040', 'PTP055':
                begin
                    //Vendor
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindVendor());
                    UnitTestingValue.MODIFY(true);
                    //GL
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindGL());
                    UnitTestingValue.MODIFY(true);
                    //Dimension Value
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindDimension2());
                    UnitTestingValue.MODIFY(true);
                    //HEI.27>>
                    //Location
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindLocation());
                    UnitTestingValue.MODIFY(true);
                    //HEI.27<<
                end;
        end;
        if TestCode = 'PTP074' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendorPTP084());
            UnitTestingValue.MODIFY(true);
            //GL
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindGLPTP084());
            UnitTestingValue.MODIFY(true);
            //JournalTemplate
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Journal Template", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindGenJournalTemplatePTP074());
            UnitTestingValue.MODIFY(true);
            //JournalTemplate&JournalBatch
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Journal Batch", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindGenJournalTemplatePTP074());
            UnitTestingValue.VALIDATE("Value 2", FindGenJournalBatchValue2PTP074());
            UnitTestingValue.MODIFY(true);
        end;
        if TestCode = 'PTP091' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendorPTP084());
            UnitTestingValue.MODIFY(true);
            //GL
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindGLForGRIR());
            UnitTestingValue.MODIFY(true);
            //JournalTemplate&JournalBatch
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Journal Batch", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindGenJournalTemplate());
            UnitTestingValue.VALIDATE("Value 2", FindGenJournalBatch());
            UnitTestingValue.MODIFY(true);
            //HEI.12>
            //Dimension Value
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindDimension3());
            UnitTestingValue.MODIFY(true);
            //HEI.12<<
        end;
        if TestCode = 'PTP102' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendorPTP102());
            UnitTestingValue.MODIFY(true);
        end;
        if TestCode = 'PTP133' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            //HEI.16>>
            UnitTestingValue.VALIDATE(Value, FindVendorPTP133());
            //UnitTestingValue.VALIDATE(Value,FindVendor);
            //HEI.16<<
            UnitTestingValue.MODIFY(true);
            //GL
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindGL());
            UnitTestingValue.MODIFY(true);
            //VAT Product Posting Group
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"VAT Product Posting Group", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, VATProPGr);//HEI.03
            UnitTestingValue.MODIFY(true);
            //WHT Business Posting Group
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"WHT Business Posting Group FND", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindWHTBusinessPostingGroup());
            UnitTestingValue.MODIFY(true);
            //Dimension Value
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindDimension2());
            UnitTestingValue.VALIDATE("Value 2", FindDimension3());
            UnitTestingValue.MODIFY(true);
            //HEI.27>>
            //Location
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindLocation());
            UnitTestingValue.MODIFY(true);
            //HEI.27<<
        end;
        if TestCode = 'PTP136' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendorPTP084());
            UnitTestingValue.MODIFY(true);
            //GL
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindGLPTP084());
            UnitTestingValue.MODIFY(true);
            //JournalTemplate&JournalBatch
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Journal Batch", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindGenJournalTemplate());
            UnitTestingValue.VALIDATE("Value 2", FindGenJournalBatch());
            UnitTestingValue.MODIFY(true);
            //HEI.12>
            //Dimension Value
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindDimension3());
            UnitTestingValue.MODIFY(true);
            //HEI.12<<
        end;
        if TestCode = 'PRD107' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendor());
            UnitTestingValue.MODIFY(true);
            //Location
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindLocationPRD107());
            UnitTestingValue.MODIFY(true);
            //Item
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindItemPRD107());
            UnitTestingValue.MODIFY(true);
            //Lot No. Information
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Lot No. Information", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindLotNo());
            UnitTestingValue.MODIFY(true);
            //HEI.12>>
            //Dimension Value
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindDimensionforItem());
            UnitTestingValue.MODIFY(true);
            //HEI.12<<
            //HEI.33>>
            //Bin
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Bin, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindBinPRD107());
            UnitTestingValue.MODIFY(true);
            //HEI.33<<
        end;
        //HEI.06<<
        //HEI.10>>
        case TestCode of
            //'PTP053','PTP132','PTP027','PTP041','PTP042'://HEI.14
            //HEI.14>>
            'PTP041', 'PTP042':
                //HEI.14<<
                begin
                    //Vendor
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindVendor());
                    UnitTestingValue.MODIFY(true);
                    //GL
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindGL());
                    UnitTestingValue.MODIFY(true);
                    //Dimension Value
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindDimension2());
                    UnitTestingValue.MODIFY(true);
                end;
        end;
        //HEI.14>>
        case TestCode of
            'PTP027', 'PTP132':
                begin
                    //Vendor
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindVendorVATPosting());
                    UnitTestingValue.MODIFY(true);
                    //GL
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindGL());
                    UnitTestingValue.MODIFY(true);
                    //Dimension Value
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindDimension2());
                    UnitTestingValue.VALIDATE("Value 2", FindDimension3());//HEI.25
                    UnitTestingValue.MODIFY(true);
                    //HEI.27>>
                    //Location
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindLocation());
                    UnitTestingValue.MODIFY(true);
                    //HEI.27<<
                end;
        end;
        //HEI.14<<
        //HEI.14>>
        if TestCode = 'PTP053' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendorPTP053());
            UnitTestingValue.MODIFY(true);
            //GL
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindGL());
            UnitTestingValue.MODIFY(true);
            //Dimension Value
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindDimension2());
            UnitTestingValue.MODIFY(true);
            //HEI.27>>
            //Location
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindLocation());
            UnitTestingValue.MODIFY(true);
            //HEI.27<<
        end;
        //HEI.14<<
        if TestCode = 'PTP056' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendor());
            UnitTestingValue.MODIFY(true);
            CLEAR(VendorNo);
            VendorNo := UnitTestingValue.Value;
            //Location
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindLocation());
            UnitTestingValue.MODIFY(true);
            //Item
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindItem());
            UnitTestingValue.MODIFY(true);
            //Vendor Bank Account
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Vendor Bank Account", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindBankAccount());
            UnitTestingValue.MODIFY(true);
            //Lot No. Information
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Lot No. Information", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindLotNo());
            UnitTestingValue.MODIFY(true);
            //Dimension
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindDimension3());
            UnitTestingValue.VALIDATE("Value 2", FindDimension2());//HEI.31
            UnitTestingValue.MODIFY(true);
            //HEI.33>>
            //Bin
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Bin, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindBin());
            UnitTestingValue.MODIFY(true);
            //HEI.33<<
        end;
        if TestCode = 'PTP057' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendor());
            UnitTestingValue.MODIFY(true);
            //GL
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindGL());
            UnitTestingValue.MODIFY(true);
            //VAT Product Posting Group
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"VAT Product Posting Group", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, VATProPGr);
            UnitTestingValue.MODIFY(true);
            //WHT Business Posting Group
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"WHT Business Posting Group FND", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindWHTBusinessPostingGroup());
            UnitTestingValue.MODIFY(true);
            //Dimension Value
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindDimension2());
            UnitTestingValue.MODIFY(true);
            //HEI.27>>
            //Location
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindLocation());
            UnitTestingValue.MODIFY(true);
            //HEI.27<<
        end;
        case TestCode of
            'PTP068', 'PTP081':
                begin
                    //JournalTemplate&JournalBatch
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Journal Batch", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindGenJournalTemplate());
                    UnitTestingValue.VALIDATE("Value 2", FindGenJournalBatch());
                    UnitTestingValue.MODIFY(true);
                end;
        end;
        case TestCode of
            //'PTP078','PTP086','PTP103'://HEI.14
            'PTP078', 'PTP103'://HEI.14
                begin
                    //Vendor
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindVendorForPayment());
                    UnitTestingValue.MODIFY(true);
                end;
        end;
        //HEI.14>>
        if TestCode = 'PTP086' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendorForPTP086());
            UnitTestingValue.MODIFY(true);
        end;
        //HEI.14<<
        case TestCode of
            'PTP079', 'PTP080':
                begin
                    //Vendor
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindVendorForPTP079());
                    UnitTestingValue.MODIFY(true);
                end;
        end;
        case TestCode of
            'PTP082', 'PTP083':
                begin
                    //Vendor
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindVendorForInvoice());
                    UnitTestingValue.MODIFY(true);
                    //JournalTemplate&JournalBatch
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Journal Batch", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindGenJournalTemplate());
                    UnitTestingValue.VALIDATE("Value 2", FindGenJournalBatchNetting());
                    UnitTestingValue.MODIFY(true);
                    //Dimension
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindDimension3());
                    UnitTestingValue.MODIFY(true);
                end;
        end;
        if TestCode = 'PTP028' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            //HEI.14>>
            //UnitTestingValue.VALIDATE(Value,FindVendor);
            UnitTestingValue.VALIDATE(Value, FindVendorPTP102());
            //HEI.14<<
            UnitTestingValue.MODIFY(true);
        end;
        //HEI.10<<
        //HEI.17>>
        if TestCode = 'CHG2123487' then begin
            //Vendor
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindVendor());
            UnitTestingValue.MODIFY(true);
            //Location
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindLocation());
            UnitTestingValue.MODIFY(true);
            //UserID
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"User Setup", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, USERID);
            UnitTestingValue.MODIFY(true);
            //Item Charge
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Item Charge", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindShippingCostItemCharge());
            UnitTestingValue.MODIFY(true);
            //Dimension Value
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
            UnitTestingValue.VALIDATE(Value, FindCCCDimensionforItemCharge());
            UnitTestingValue.VALIDATE("Value 2", FindCMGDimension());
            UnitTestingValue.MODIFY(true);
            //Shipping Cost Agent
            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipping Agent Services", UnitTestingValue);
            //UnitTestingValue.VALIDATE(Value, FindShippingAgent); ////BC Upgrade KAPOOV01 Commented procedure FindShippingAgent as it is dependent on Drink-IT Table-Shipping Agent Purch. Price"
            UnitTestingValue.VALIDATE("Value 2", ShippingAgentServicesCode);
            UnitTestingValue.MODIFY(true);
        end;
        //HEI.17<<
        //HEI.68>>
        if TestCode = 'PCN029' then begin
            PurchasesPayablesSetupL.GET();
            PurchRcptHeaderL.SETCURRENTKEY("Gen. Bus. Posting Group", "VAT Bus. Posting Group", "Shipment Method Code", "Payment Method Code");
            PurchRcptHeaderL.SETRANGE("Gen. Bus. Posting Group", '3PV-TRADE');
            PurchRcptHeaderL.SETRANGE("VAT Bus. Posting Group", '3PV-TRADE');
            PurchRcptHeaderL.SETFILTER("Shipment Method Code", PurchasesPayablesSetupL."Excluded Incoterms FND");
            PurchRcptHeaderL.SETFILTER("Payment Method Code", '%1', 'BANK CON');
            PurchRcptHeaderL.SETCURRENTKEY("Posting Date");
            PurchRcptHeaderL.ASCENDING(false);
            if PurchRcptHeaderL.FINDSET(false) then begin
                repeat
                    VendorL.RESET();
                    VendorL.SETCURRENTKEY("No.", Blocked, "Sensitive Payment Block FND", "Sensitive Workflow Block FND", "Preferred Bank Account Code");
                    VendorL.SETRANGE("No.", PurchRcptHeaderL."Buy-from Vendor No.");
                    VendorL.SETRANGE(Blocked, VendorL.Blocked::" ");
                    VendorL.SETRANGE("Sensitive Payment Block FND", false);
                    VendorL.SETRANGE("Sensitive Workflow Block FND", false);
                    VendorL.SETFILTER("Preferred Bank Account Code", '<>%1', '');
                    if VendorL.FINDFIRST() then begin
                        PurchRcptLineL.RESET();
                        PurchRcptLineL.SETCURRENTKEY("Document No.", Type, "Buy-from Vendor No.", Quantity, "Location Code", "Dimension Set ID");
                        PurchRcptLineL.SETRANGE("Document No.", PurchRcptHeaderL."No.");
                        PurchRcptLineL.SETRANGE(Type, PurchRcptLineL.Type::"G/L Account");
                        PurchRcptLineL.SETRANGE("Buy-from Vendor No.", PurchRcptHeaderL."Buy-from Vendor No.");
                        PurchRcptLineL.SETFILTER(Quantity, '<>0');
                        PurchRcptLineL.SETFILTER("Location Code", '<>%1', '');
                        PurchRcptLineL.SETFILTER("Dimension Set ID", '<>0');
                        PurchRcptLineL.SETCURRENTKEY("Posting Date");
                        PurchRcptLineL.ASCENDING(false);
                        if PurchRcptLineL.FINDSET(false) then begin
                            VendorNoL := PurchRcptHeaderL."Buy-from Vendor No.";
                            repeat
                                GLAccountL.RESET();
                                GLAccountL.SETCURRENTKEY("No.", "Direct Posting", "Account Type", "Acc Type FND", "Gen. Posting Type",
                                  Blocked, "Account Category", "Gen. Prod. Posting Group", "VAT Prod. Posting Group");
                                GLAccountL.SETRANGE("No.", PurchRcptLineL."No.");
                                GLAccountL.SETRANGE("Direct Posting", true);
                                GLAccountL.SETRANGE("Account Type", GLAccountL."Account Type"::Posting);
                                GLAccountL.SETRANGE("Acc Type FND", GLAccountL."Acc Type FND"::Expense);
                                GLAccountL.SETRANGE("Gen. Posting Type", GLAccountL."Gen. Posting Type"::Purchase);
                                GLAccountL.SETRANGE(Blocked, false);
                                GLAccountL.SETFILTER("Account Category", '<>%1', GLAccountL."Account Category"::Income);
                                GLAccountL.SETFILTER("Gen. Prod. Posting Group", '%1|%2', 'DOPA', 'SERVICES');
                                GLAccountL.SETFILTER("VAT Prod. Posting Group", '<>%1', '');
                                if GLAccountL.FINDFIRST() then begin
                                    DefaultDimensionL.RESET();
                                    DefaultDimensionL.SETCURRENTKEY("Table ID", "No.", "Value Posting");
                                    DefaultDimensionL.SETRANGE("Table ID", DATABASE::"G/L Account");
                                    DefaultDimensionL.SETRANGE("No.", GLAccountL."No.");
                                    DefaultDimensionL.SETFILTER("Value Posting", '<>%1', DefaultDimensionL."Value Posting"::" ");
                                    if not DefaultDimensionL.FINDFIRST() then begin
                                        GLAccountNoL := PurchRcptLineL."No.";
                                        LocationCodeL := PurchRcptLineL."Location Code";
                                        FoundL := true;
                                    end;
                                end;
                            until (PurchRcptLineL.NEXT() = 0) or FoundL;
                        end;
                    end;
                until (PurchRcptHeaderL.NEXT() = 0) or FoundL;
            end else begin
                VendorNoL := FindVendor();
                GLAccountNoL := FindGL();
                LocationCodeL := FindLocation();
            end;
            if (VendorNoL <> '') and (GLAccountNoL <> '') and (LocationCodeL <> '') then begin
                InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
                UnitTestingValue.VALIDATE(Value, VendorNoL);
                UnitTestingValue.MODIFY(true);

                InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
                UnitTestingValue.VALIDATE(Value, GLAccountNoL);
                UnitTestingValue.MODIFY(true);

                InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                UnitTestingValue.VALIDATE(Value, LocationCodeL);
                UnitTestingValue.MODIFY(true);
            end;
        end;

        if TestCode = 'PCN030' then begin
            CLEAR(FoundL);
            CLEAR(VendorNoL);
            CLEAR(GLAccountNoL);
            CLEAR(LocationCodeL);
            PurchasesPayablesSetupL.GET();
            PurchRcptHeaderL.SETCURRENTKEY("Gen. Bus. Posting Group", "VAT Bus. Posting Group", "Shipment Method Code", "Payment Method Code");
            PurchRcptHeaderL.SETRANGE("Gen. Bus. Posting Group", '3PV-TRADE');
            PurchRcptHeaderL.SETRANGE("VAT Bus. Posting Group", '3PV-TRADE');
            PurchRcptHeaderL.SETFILTER("Shipment Method Code", PurchasesPayablesSetupL."Excluded Incoterms FND");
            PurchRcptHeaderL.SETFILTER("Payment Method Code", '%1', 'BANK CON');
            PurchRcptHeaderL.SETCURRENTKEY("Posting Date");
            PurchRcptHeaderL.ASCENDING(false);
            if PurchRcptHeaderL.FINDSET(false) then begin
                repeat
                    VendorL.RESET();
                    VendorL.SETCURRENTKEY("No.", Blocked, "Sensitive Payment Block FND", "Sensitive Workflow Block FND", "Preferred Bank Account Code");
                    VendorL.SETRANGE("No.", PurchRcptHeaderL."Buy-from Vendor No.");
                    VendorL.SETRANGE(Blocked, VendorL.Blocked::" ");
                    VendorL.SETRANGE("Sensitive Payment Block FND", false);
                    VendorL.SETRANGE("Sensitive Workflow Block FND", false);
                    VendorL.SETFILTER("Preferred Bank Account Code", '<>%1', '');
                    if VendorL.FINDFIRST() then begin
                        PurchRcptLineL.RESET();
                        PurchRcptLineL.SETCURRENTKEY("Document No.", Type, "Buy-from Vendor No.", Quantity, "Location Code", "Dimension Set ID");
                        PurchRcptLineL.SETRANGE("Document No.", PurchRcptHeaderL."No.");
                        PurchRcptLineL.SETRANGE(Type, PurchRcptLineL.Type::"G/L Account");
                        PurchRcptLineL.SETRANGE("Buy-from Vendor No.", PurchRcptHeaderL."Buy-from Vendor No.");
                        PurchRcptLineL.SETFILTER(Quantity, '<>0');
                        PurchRcptLineL.SETFILTER("Location Code", '<>%1', '');
                        PurchRcptLineL.SETFILTER("Dimension Set ID", '<>0');
                        PurchRcptLineL.SETCURRENTKEY("Posting Date");
                        PurchRcptLineL.ASCENDING(false);
                        if PurchRcptLineL.FINDSET(false) then begin
                            VendorNoL := PurchRcptHeaderL."Buy-from Vendor No.";
                            repeat
                                GLAccountL.RESET();
                                GLAccountL.SETCURRENTKEY("No.", "Direct Posting", "Account Type", "Acc Type FND", "Gen. Posting Type",
                                  Blocked, "Account Category", "Gen. Prod. Posting Group", "VAT Prod. Posting Group");
                                GLAccountL.SETRANGE("No.", PurchRcptLineL."No.");
                                GLAccountL.SETRANGE("Direct Posting", true);
                                GLAccountL.SETRANGE("Account Type", GLAccountL."Account Type"::Posting);
                                GLAccountL.SETRANGE("Acc Type FND", GLAccountL."Acc Type FND"::Expense);
                                GLAccountL.SETRANGE("Gen. Posting Type", GLAccountL."Gen. Posting Type"::Purchase);
                                GLAccountL.SETRANGE(Blocked, false);
                                GLAccountL.SETFILTER("Account Category", '<>%1', GLAccountL."Account Category"::Income);
                                GLAccountL.SETFILTER("Gen. Prod. Posting Group", '%1|%2', 'DOPA', 'SERVICES');
                                GLAccountL.SETFILTER("VAT Prod. Posting Group", '<>%1', '');
                                if GLAccountL.FINDFIRST() then begin
                                    DefaultDimensionL.RESET();
                                    DefaultDimensionL.SETCURRENTKEY("Table ID", "No.", "Value Posting");
                                    DefaultDimensionL.SETRANGE("Table ID", DATABASE::"G/L Account");
                                    DefaultDimensionL.SETRANGE("No.", GLAccountL."No.");
                                    DefaultDimensionL.SETFILTER("Value Posting", '<>%1', DefaultDimensionL."Value Posting"::" ");
                                    if not DefaultDimensionL.FINDFIRST() then begin
                                        GLAccountNoL := PurchRcptLineL."No.";
                                        LocationCodeL := PurchRcptLineL."Location Code";
                                        FoundL := true;
                                    end;
                                end;
                            until (PurchRcptLineL.NEXT() = 0) or FoundL;
                        end;
                    end;
                until (PurchRcptHeaderL.NEXT() = 0) or FoundL;
            end else begin
                VendorNoL := FindVendor();
                GLAccountNoL := FindGL();
                LocationCodeL := FindLocation();
            end;
            if (VendorNoL <> '') and (GLAccountNoL <> '') and (LocationCodeL <> '') then begin
                InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
                UnitTestingValue.VALIDATE(Value, VendorNoL);
                UnitTestingValue.MODIFY(true);

                InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
                UnitTestingValue.VALIDATE(Value, GLAccountNoL);
                UnitTestingValue.MODIFY(true);

                InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                UnitTestingValue.VALIDATE(Value, LocationCodeL);
                UnitTestingValue.MODIFY(true);
            end;
        end;
        //HEI.68<<
    end;

    local procedure InitUnitTestingValues(TestCode: Code[20]; TestDescription: Text[100]; TableID: Integer; var UnitTestingValue: Record "Unit Testing Value FND");
    begin
        UnitTestingValue.INIT();
        UnitTestingValue.VALIDATE("Test Script Code", TestCode);
        UnitTestingValue.VALIDATE("Table ID", TableID);
        UnitTestingValue.VALIDATE("Company Name", COMPANYNAME);
        UnitTestingValue.VALIDATE("Test Script Description", TestDescription);
        UnitTestingValue.INSERT(true);
    end;

    local procedure FindVendor(): Code[20];
    var
        RecVendor1: Record Vendor;
        VendorBankAccount1: Record "Vendor Bank Account";
        VendorFound1: Boolean;
        VendorLedgerEntry1: Record "Vendor Ledger Entry";
    begin
        //HEI.55>>
        //VendorFound := FALSE;//HEI.38//HEI.39
        /*RecVendor.RESET;
        RecVendor.SETFILTER(Blocked,'%1',RecVendor.Blocked::" ");
        RecVendor.SETRANGE("Sensitive Payment Block FND",FALSE);
        RecVendor.SETFILTER("Preferred Bank Account Code",'<>%1','');
        //RecVendor.SETFILTER("VAT Registration No.",'<>%1','');//HEI.03 //HEI.05
        RecVendor.SETRANGE("Gen. Bus. Posting Group",'3PV-TRADE'); //HEI.05
        //>>HEI.37
              //IF RecVendor.FINDFIRST THEN
              IF RecVendor.FINDSET THEN REPEAT
                VendorBankAccount.RESET;
                VendorBankAccount.SETRANGE("Vendor No.",RecVendor."No.");
                VendorBankAccount.SETRANGE(Code,RecVendor."Preferred Bank Account Code");
                VendorBankAccount.SETFILTER(Address,'<>%1','');
                VendorBankAccount.SETFILTER(IBAN,'<>%1','');
                VendorBankAccount.SETFILTER("SWIFT Code",'<>%1','');
                VendorBankAccount.SETFILTER(Name,'<>%1','');
                VendorBankAccount.SETFILTER("Country/Region Code",'<>%1','');
                VendorBankAccount.SETFILTER("Bank Account No.",'<>%1','');
                VendorBankAccount.SETFILTER("Bank Branch No.",'<>%1','');
                IF VendorBankAccount.FINDFIRST THEN
              //<<HEI.37
                 //>>HEI.38
                 //>>HEI.39
                  //VendorFound := TRUE;
                EXIT(RecVendor."No.");
                UNTIL RecVendor.NEXT=0;//HEI.37
           //UNTIL (RecVendor.NEXT=0) OR (VendorFound=TRUE);
            //<<HEI.38
        //>>HEI.38
        {IF VendorFound THEN
           EXIT(RecVendor."No.")
        ELSE
        BEGIN}
        //<<HEI.39
            RecVendor.RESET;
            RecVendor.SETFILTER(Blocked,'%1',RecVendor.Blocked::" ");
            RecVendor.SETRANGE("Sensitive Payment Block FND",FALSE);
            RecVendor.SETFILTER("Preferred Bank Account Code",'<>%1','');
            RecVendor.SETRANGE("Gen. Bus. Posting Group",'3PV-TRADE');
            IF RecVendor.FINDFIRST THEN
               EXIT(RecVendor."No.");
        //END; //HEI.39
        
        EXIT('');
        //<<HEI.38
        */
        RecVendor1.RESET();
        RecVendor1.SETCURRENTKEY("No.");//HEI.56
        RecVendor1.SETFILTER(Blocked, '%1', RecVendor1.Blocked::" ");
        RecVendor1.SETRANGE("Sensitive Payment Block FND", false);
        RecVendor1.SETFILTER("Preferred Bank Account Code", '<>%1', '');
        RecVendor1.SETRANGE("Gen. Bus. Posting Group", '3PV-TRADE');
        //HEI.60>>
        PurchasesPayablesSetup.GET();
        //HEI.61>>
        //RecVendor1.SETFILTER("Shipment Method Code",'%1',PurchasesPayablesSetup."Excluded Incoterms FND");
        RecVendor1.SETFILTER("Shipment Method Code", PurchasesPayablesSetup."Excluded Incoterms FND");
        //HEI.61<<
        //HEI.60<<
        //HEI.56>>
        //RecVendor1.SETFILTER("Payment Method Code",'<>%1','');
        RecVendor1.SETFILTER("Payment Method Code", '%1', 'BANK CON');
        //HEI.56<<
        if RecVendor1.FINDSET(false) then
            repeat
                VendorBankAccount1.RESET();
                VendorBankAccount1.SETCURRENTKEY("Vendor No.", Code);//HEI.56
                VendorBankAccount1.SETRANGE("Vendor No.", RecVendor1."No.");
                VendorBankAccount1.SETRANGE(Code, RecVendor1."Preferred Bank Account Code");
                VendorBankAccount1.SETFILTER(Address, '<>%1', '');
                VendorBankAccount1.SETFILTER(IBAN, '<>%1', '');
                VendorBankAccount1.SETFILTER("SWIFT Code", '<>%1', '');
                VendorBankAccount1.SETFILTER(Name, '<>%1', '');
                VendorBankAccount1.SETFILTER("Country/Region Code", '<>%1', '');
                VendorBankAccount1.SETFILTER("Bank Account No.", '<>%1', '');
                VendorBankAccount1.SETFILTER("Bank Branch No.", '<>%1', '');
                if VendorBankAccount1.FINDFIRST() then begin
                    VendorLedgerEntry1.RESET();
                    VendorLedgerEntry1.SETCURRENTKEY("Vendor No.", "Document No.", "Posting Date");//HEI.56
                    VendorLedgerEntry1.SETRANGE("Vendor No.", RecVendor1."No.");
                    VendorLedgerEntry1.SETRANGE("Document Type", VendorLedgerEntry1."Document Type"::Payment);
                    VendorLedgerEntry1.SETRANGE(Open, false);
                    VendorLedgerEntry1.SETFILTER("Journal Batch Name", '<>%1', '');
                    if UPPERCASE(COMPANYNAME) = '10_LUBUMBASHI' then
                        VendorLedgerEntry1.SETRANGE("Closed at Date", 0D);
                    if VendorLedgerEntry1.FINDFIRST() then
                        exit(RecVendor1."No.");
                end;
            until RecVendor1.NEXT() = 0;

        RecVendor1.RESET();
        RecVendor1.SETCURRENTKEY("No."); //HEI.56
        RecVendor1.SETFILTER(Blocked, '%1', RecVendor1.Blocked::" ");
        RecVendor1.SETRANGE("Sensitive Payment Block FND", false);
        RecVendor1.SETFILTER("Preferred Bank Account Code", '<>%1', '');
        RecVendor1.SETRANGE("Gen. Bus. Posting Group", '3PV-TRADE');
        //HEI.56>>
        //RecVendor1.SETRANGE("Payment Method Code",'<>%1','');
        RecVendor1.SETFILTER("Payment Method Code", '%1', 'BANK CON');
        //HEI.56<<
        if RecVendor1.FINDFIRST() then
            exit(RecVendor1."No.");

        exit('');
        //HEI.55<<

    end;

    local procedure FindItem(): Code[20];
    var
        RecItem: Record Item;
    begin
        RecItem.RESET();
        RecItem.SETRANGE(Blocked, false);
        RecItem.SETRANGE("Item Tracking Code", 'LOTALL');
        RecItem.SETFILTER("Gen. Prod. Posting Group", '<>%1', 'FGPO');//HEI.20
        //HEI.03 >>
        //IF RecItem.FINDFIRST THEN
        if RecItem.FINDSET() then begin
            repeat
                if RecItem."Base Unit of Measure" = RecItem."Purch. Unit of Measure" then begin
                    BinContent.RESET();
                    BinContent.SETRANGE("Location Code", FindLocation());
                    BinContent.SETRANGE("Item No.", RecItem."No.");
                    if BinContent.FINDFIRST() then
                        exit(RecItem."No.");
                end;
            until RecItem.NEXT() = 0;
        end;
        //HEI.03 <<
    end;

    local procedure FindLocation(): Code[20];
    var
        Location: Record Location;
    begin
        Location.RESET();
        Location.SETFILTER("Warning Threshold Days FND", '<>%1', 0);
        Location.SETFILTER(Name, 'Brewery*');//HEI.15
        if Location.FINDFIRST() then begin
            //RecBinCode:=Location."Receipt Bin Code"; HEI.03
            exit(Location.Code);
            //HEI.03 >>
        end else begin
            Location.RESET();
            if Location.FINDFIRST() then
                exit(Location.Code);
        end;
        //HEI.03 <<
    end;

    local procedure FindBankAccount(): Code[20];
    var
        VendorBankAccount: Record "Vendor Bank Account";
    begin
        VendorBankAccount.RESET();
        VendorBankAccount.SETRANGE("Vendor No.", VendorNo);
        if VendorBankAccount.FINDFIRST() then
            exit(VendorBankAccount.Code);
    end;

    local procedure FindLotNo(): Code[20];
    var
        LotNoInformation: Record "Lot No. Information";
    begin
        exit('STPTS');
    end;

    local procedure FindDimension3(): Code[20];
    var
        DimensionValue: Record "Dimension Value";
    begin
        exit('811');
    end;

    local procedure FindGL(): Code[20];
    var
        GLAccount: Record "G/L Account";
    begin
        GLAccount.RESET();
        GLAccount.SETRANGE("Direct Posting", true);
        GLAccount.SETRANGE("Account Type", GLAccount."Account Type"::Posting);
        GLAccount.SETRANGE("Acc Type FND", GLAccount."Acc Type FND"::Expense);
        GLAccount.SETRANGE(Blocked, false);
        GLAccount.SETFILTER("Gen. Prod. Posting Group", '%1|%2', 'DOPA', 'SERVICES');
        GLAccount.SETFILTER("VAT Prod. Posting Group", '<>%1', '');//HEI.03
        GLAccount.SETRANGE("Gen. Posting Type", GLAccount."Gen. Posting Type"::Purchase);//HEI.03
        GLAccount.SETFILTER("VAT Bus. Posting Group", '<>%1', '');//HEI.03
        GLAccount.SETFILTER("Account Category", '<>%1', GLAccount."Account Category"::Income);//HEI.05
        if GLAccount.FINDFIRST() then begin //HEI.03
            VATProPGr := GLAccount."VAT Prod. Posting Group";//HEI.03
            exit(GLAccount."No.");
            //HEI.03 >>
        end
        else begin
            GLAccount.RESET();
            GLAccount.SETRANGE("Direct Posting", true);
            GLAccount.SETRANGE("Account Type", GLAccount."Account Type"::Posting);
            GLAccount.SETRANGE("Acc Type FND", GLAccount."Acc Type FND"::Expense);
            GLAccount.SETRANGE(Blocked, false);
            //GLAccount.SETFILTER("Gen. Prod. Posting Group",'%1|%2','DOPA','SERVICES');//HEI.22
            GLAccount.SETRANGE("Gen. Prod. Posting Group", 'DOPA');//HEI.22
            GLAccount.SETFILTER("VAT Prod. Posting Group", '<>%1', '');//HEI.03
            GLAccount.SETFILTER("Account Category", '<>%1', GLAccount."Account Category"::Income);//HEI.05
            if GLAccount.FINDFIRST() then begin
                VATProPGr := GLAccount."VAT Prod. Posting Group";
                exit(GLAccount."No.");
            end;
        end;
        //HEI.03 <<
        //HEI.23>>
        GLAccount.RESET();
        GLAccount.SETRANGE("Direct Posting", true);
        GLAccount.SETRANGE("Account Type", GLAccount."Account Type"::Posting);
        GLAccount.SETRANGE("Acc Type FND", GLAccount."Acc Type FND"::Expense);
        GLAccount.SETRANGE(Blocked, false);
        GLAccount.SETFILTER("Gen. Prod. Posting Group", '%1|%2', 'DOPA', 'SERVICES');
        GLAccount.SETFILTER("VAT Prod. Posting Group", '<>%1', '');
        GLAccount.SETFILTER("Account Category", '<>%1', GLAccount."Account Category"::Income);
        if GLAccount.FINDFIRST() then begin
            VATProPGr := GLAccount."VAT Prod. Posting Group";
            exit(GLAccount."No.");
        end;
        //HEI.23<<
    end;

    local procedure FindGenJournalTemplate(): Code[20];
    var
        GenJournalTemplate: Record "Gen. Journal Template";
    begin
        GenJournalTemplate.RESET();
        GenJournalTemplate.SETRANGE("Page ID", 39);
        GenJournalTemplate.SETRANGE(Recurring, false);
        GenJournalTemplate.SETRANGE(Type, GenJournalTemplate.Type::General);
        GenJournalTemplate.SETRANGE(Name, 'PTP');
        if GenJournalTemplate.FINDFIRST() then begin
            TemplateName := GenJournalTemplate.Name;
            exit(GenJournalTemplate.Name);
        end;
        //HEI.29>>
        GenJournalTemplate.RESET();
        GenJournalTemplate.SETRANGE("Page ID", 39);
        GenJournalTemplate.SETRANGE(Recurring, false);
        GenJournalTemplate.SETRANGE(Type, GenJournalTemplate.Type::General);
        if GenJournalTemplate.FINDFIRST() then begin
            TemplateName := GenJournalTemplate.Name;
            exit(GenJournalTemplate.Name);
        end;
        //HEi.29<<
    end;

    local procedure FindGenJournalBatch(): Code[20];
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
    begin
        GenJournalBatch.RESET();
        GenJournalBatch.SETRANGE("Journal Template Name", TemplateName);
        GenJournalBatch.SETFILTER("Bal. Account No.", '<>%1', '');//HEI.05//HEI.50
        GenJournalBatch.SETFILTER("No. Series", '<>%1', '');//HEI.05
        if GenJournalBatch.FINDSET() then begin
            repeat
                //HEI.05>>//HEI.50>>
                GLAccount.RESET();
                GLAccount.SETRANGE("No.", GenJournalBatch."Bal. Account No.");
                GLAccount.SETRANGE(Blocked, false);
                if GLAccount.FINDFIRST() then
                    //HEI.50<<//HEI.05<<
                    exit(GenJournalBatch.Name);
            until GenJournalBatch.NEXT() = 0;
        end;
    end;

    local procedure FindItemCharge(): Code[20];
    var
        ItemCharge: Record "Item Charge";
    begin
        ItemCharge.RESET();
        //ItemCharge.SETRANGE("Item Charge Type", ItemCharge."Item Charge Type"::" ");  //BC Upgrade KAPOOV01 Commented Drink-IT field-"Item Charge Type" of table-"Item Charge"
        //ItemCharge.SETRANGE("Gen. Prod. Posting Group",'FGBB');//HEI.03
        ItemCharge.SETFILTER("Gen. Prod. Posting Group", '%1|%2', 'FGBB', 'N078');//HEI.03
        if ItemCharge.FINDFIRST() then
            exit(ItemCharge."No.");
    end;

    local procedure FindBin(): Code[20];
    var
        Bin: Record Bin;
    begin
        Bin.RESET();
        Bin.SETRANGE("Location Code", FindLocation());//HEI.05
        if Bin.FINDFIRST() then
            exit(Bin.Code);
    end;

    local procedure FindVATProductPostingGroup(): Code[20];
    var
        VATProductPostingGroup: Record "VAT Product Posting Group";
    begin
        VATProductPostingGroup.RESET();
        VATProductPostingGroup.SETRANGE(Code, 'NO_VAT');//HEI.03
        if VATProductPostingGroup.FINDFIRST() then
            exit(VATProductPostingGroup.Code)
        //HEI.03 >>
        else begin
            VATProductPostingGroup.RESET();
            if VATProductPostingGroup.FINDFIRST() then
                exit(VATProductPostingGroup.Code)
        end;
        //HEI.03 <<
    end;

    local procedure FindWHTBusinessPostingGroup(): Code[20];
    var
        WHTBusinessPostingGroup: Record "WHT Business Posting Group FND";
    begin
        WHTBusinessPostingGroup.RESET();
        if WHTBusinessPostingGroup.FINDFIRST() then
            exit(WHTBusinessPostingGroup.Code);
    end;

    local procedure FindDimension2(): Code[20];
    var
        DimensionValue: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
    begin
        DimensionValue.RESET();
        DimensionValue.SETRANGE(Blocked, false);
        DimensionValue.SETRANGE("Dimension Code", 'CCC');
        //HEI.05>>
        if DimensionValue.FINDSET() then begin
            repeat
                EbfCombination.SETRANGE("GL Account No.", FindGL());
                EbfCombination.SETRANGE("Dimension Code", DimensionValue."Dimension Code");
                //HEI.44>>
                //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue.Code);
                //HEI.48>>
                // STPTestScript.GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
                //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
                //HEI.48<<
                //HEI.44<<
                EbfCombination.SETFILTER("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::"Not Allowed");
                if EbfCombination.FINDFIRST() then
                    exit(DimensionValue.Code)
                //HEI.19>>
                else begin
                    EbfCombination.RESET();
                    EbfCombination.SETFILTER("Dimension Value Code", '<>%1', DimensionValue.Code);
                    if EbfCombination.FINDFIRST() then
                        exit(DimensionValue.Code);
                end;
            //HEI.19<<
            until DimensionValue.NEXT() = 0;
        end;
        //HEI.05<<
    end;

    local procedure FindPLForItem(): Code[20];
    var
        PurchaseLine: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLinePrice: Record "Purchase Line Price FND";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        LocationCode: Code[20];
        blocked: Boolean;
        PurchaseLine1: Record "Purchase Line";
        Item: Record Item;
    begin
        PurchaseLine.RESET();
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::"Blanket Order");
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        PurchaseLine.SETFILTER("Valid To FND", '>=%1', TODAY);
        //PurchaseLine.SETFILTER(Quantity,'<>%1',PurchaseLine."Quantity Received");//HEI.03
        PurchaseLine.SETFILTER("Outstanding Quantity", '<>%1', 0);//HEI.03
        PurchaseLine.SETRANGE("Qty. Rcd. Not Invoiced", 0); //HEI.03
        //PurchaseLine.SETFILTER("Direct Unit Cost",'<>%1',0);//HEI.03 HEI.05
        PurchaseLine.SETRANGE("Block Line Ordering FND", PurchaseLine."Block Line Ordering FND"::" ");
        //HEI.14>>
        PurchaseLine.SETRANGE("Tolerance Received Over % FND", 0);
        PurchaseLine.SETRANGE("Tolerance Received Under % FND", 0);
        //HEI.14<<
        //HEI.05>>
        // IF PurchaseLine.FINDFIRST THEN BEGIN
        //   BlankOrderNoforItem:=PurchaseLine."Document No.";
        //   EXIT(PurchaseLine."No.");
        // END;
        PurchaseLine.SETRANGE("Delivery Finalized FND", false);
        PurchaseLine.SETFILTER("Consumption Location Code FND", '<>%1', '');
        //HEI.64>>
        //IF PurchaseLine.FINDSET THEN BEGIN
        if PurchaseLine.FINDSET(false) then begin
            //HEI.64<<
            repeat
                //HEI.64>>
                /*blocked := FALSE;
                Item.RESET;
                PurchaseLine1.RESET;
                PurchaseLine1.SETCURRENTKEY("Document Type","Document No.","Line No.",Type,"No.","Consumption Location Code");
                PurchaseLine1.SETRANGE("Document Type",PurchaseLine."Document Type");
                PurchaseLine1.SETRANGE("Document No.",PurchaseLine."Document No.");
                PurchaseLine1.SETRANGE("Line No.",PurchaseLine."Line No.");
                PurchaseLine1.SETRANGE(Type,PurchaseLine1.Type::Item);
                PurchaseLine1.SETRANGE("No.",PurchaseLine."No.");
                PurchaseLine1.SETRANGE("Consumption Location Code",PurchaseLine."Consumption Location Code");
                IF PurchaseLine1.FINDFIRST THEN BEGIN
                  IF Item.GET(PurchaseLine1."No.") THEN BEGIN
                    IF Item.Blocked THEN
                      blocked := TRUE;
                  END;
                END;
                IF NOT blocked THEN BEGIN*/
                //HEI.64<<
                if PurchaseHeader.GET(PurchaseHeader."Document Type"::"Blanket Order", PurchaseLine."Document No.") then begin
                    CLEAR(BlankOrderNoforItem);
                    CLEAR(LocationCode);
                    if PurchaseHeader."Channel FND" = 'A' then begin
                        PurchasesPayablesSetup.GET();
                        //HEI.40>>
                        //IF (PurchasesPayablesSetup."Excluded Incoterms FND"='DAP|DDP') AND (PurchasesPayablesSetup."Location Code for Import Proc."<>'') THEN BEGIN
                        //HEI.41>>
                        //IF (PurchasesPayablesSetup."Excluded Incoterms FND" IN['DDP','DAP']) AND (PurchasesPayablesSetup."Location Code for Import Proc."<>'') THEN BEGIN
                        if (PurchasesPayablesSetup."Excluded Incoterms FND" in ['DAP|DDP', 'DDP|DAP']) and (PurchasesPayablesSetup."Location Code Imp Proc. FND" <> '') then begin
                            //HEI.41<<
                            //HEI.40<<
                            if not (PurchaseHeader."Shipment Method Code" in ['DAP', 'DDP']) then
                                LocationCode := PurchasesPayablesSetup."Location Code Imp Proc. FND"
                            else
                                LocationCode := PurchaseLine."Consumption Location Code FND";
                        end else
                            LocationCode := PurchaseLine."Consumption Location Code FND";
                        PurchaseLinePrice.RESET();
                        PurchaseLinePrice.SETRANGE("Document Type", PurchaseLine."Document Type");
                        PurchaseLinePrice.SETRANGE("Document No.", PurchaseLine."Document No.");
                        PurchaseLinePrice.SETRANGE("Document Line No.", PurchaseLine."Line No.");
                        PurchaseLinePrice.SETRANGE("Item No.", PurchaseLine."No.");
                        PurchaseLinePrice.SETFILTER("Ending Date", '>=%1', TODAY);
                        PurchaseLinePrice.SETFILTER("Direct Unit Cost", '<>%1', 0);
                        PurchaseLinePrice.SETFILTER("Location Code", '%1|%2', LocationCode, '');
                        if PurchaseLinePrice.FINDSET() then begin
                            repeat
                                BlankOrderNoforItem := PurchaseHeader."No.";
                                exit(PurchaseLine."No.");
                            until PurchaseLinePrice.NEXT() = 0;
                        end;
                    end;
                end;
            //HEI.64>>
            //END;
            //HEI.64<<
            until PurchaseLine.NEXT() = 0;
        end;
        //HEI.05<<

    end;

    local procedure FindPLForChargeItem(): Code[20];
    var
        PurchaseLine: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
        Vendor: Record Vendor;
        BPONoL: Code[20];
        ChrgItemL: Code[20];
        PurchaseLineL: Record "Purchase Line";
    begin
        PurchaseLine.RESET();
        //HEI.66>>
        //HEI.69>>
        //PurchaseLine.SETCURRENTKEY("Document Type",Type,"Valid To","Outstanding Quantity","Block Line Ordering","Delivery Finalized","SRM Contract No.");
        PurchaseLine.SETCURRENTKEY("Document Type", Type, "Valid To FND", "Outstanding Quantity", "Block Line Ordering FND", "Delivery Finalized FND", "SRM Contract No. FND", "Consumption Location Code FND");
        //HEI.69<<
        //HEI.66<<
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::"Blanket Order");
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::"Charge (Item)");
        PurchaseLine.SETFILTER("Valid To FND", '>=%1', TODAY);
        //PurchaseLine.SETFILTER(Quantity,'<>%1',PurchaseLine."Quantity Received"); //HEI.03
        PurchaseLine.SETFILTER("Outstanding Quantity", '<>%1', 0); //HEI.03
        //PurchaseLine.SETFILTER("Consumption Location Code",'<>%1','');//HEI.03 //HEI.05
        PurchaseLine.SETRANGE("Block Line Ordering FND", PurchaseLine."Block Line Ordering FND"::" ");
        //HEI.05>>
        // IF PurchaseLine.FINDFIRST THEN BEGIN
        //   BlankOrderNoforChargeItem:=PurchaseLine."Document No.";
        //   EXIT(PurchaseLine."No.");
        // END;
        PurchaseLine.SETRANGE("Delivery Finalized FND", false);
        PurchaseLine.SETFILTER("SRM Contract No. FND", '<>%1', '');
        //HEI.69>>
        PurchaseLine.SETFILTER("Consumption Location Code FND", '<>%1', '');
        //HEI.69<<
        if PurchaseLine.FINDSET() then begin
            repeat
                //HEI.69>>
                PurchaseLineL.RESET();
                PurchaseLineL.SETCURRENTKEY("Document Type", "Document No.", Type, "Valid To FND", "Outstanding Quantity",
                  "Block Line Ordering FND", "Delivery Finalized FND", "SRM Contract No. FND", "Consumption Location Code FND");
                PurchaseLineL.SETRANGE("Document Type", PurchaseLine."Document Type");
                PurchaseLineL.SETRANGE("Document No.", PurchaseLine."Document No.");
                PurchaseLineL.SETRANGE(Type, PurchaseLineL.Type::"Charge (Item)");
                PurchaseLineL.SETFILTER("Valid To FND", '>=%1', TODAY);
                PurchaseLineL.SETFILTER("Outstanding Quantity", '<>0');
                PurchaseLineL.SETRANGE("Block Line Ordering FND", PurchaseLineL."Block Line Ordering FND"::" ");
                PurchaseLineL.SETRANGE("Delivery Finalized FND", false);
                PurchaseLineL.SETFILTER("SRM Contract No. FND", '<>%1', '');
                PurchaseLineL.SETRANGE("Consumption Location Code FND", '');
                if PurchaseLineL.ISEMPTY then begin
                    //HEI.69<<
                    if Vendor.GET(PurchaseLine."Buy-from Vendor No.") then begin  //HEI.34
                        if (Vendor.Blocked = Vendor.Blocked::" ") then begin   //HEI.34
                                                                               //HEI.66>>
                            PurchaseHeader.RESET();
                            //HEI.66<<
                            if PurchaseHeader.GET(PurchaseHeader."Document Type"::"Blanket Order", PurchaseLine."Document No.") then begin
                                CLEAR(BlankOrderNoforChargeItem);
                                if PurchaseHeader."Channel FND" = 'D' then begin
                                    //HEI.66>>
                                    if (BPONoL = '') and (ChrgItemL = '') and (PurchaseHeader."No." <> '') and (PurchaseLine."No." <> '') then begin
                                        BPONoL := PurchaseHeader."No.";
                                        ChrgItemL := PurchaseLine."No.";
                                    end;
                                    if ValidatePOBlanketOrder(PurchaseLine) and (PurchaseHeader."No." <> '') and (PurchaseLine."No." <> '') then begin
                                        //HEI.66<<
                                        BlankOrderNoforChargeItem := PurchaseHeader."No.";
                                        exit(PurchaseLine."No.");
                                        //HEI.66>>
                                    end else begin
                                        //HEI.67>>
                                        if (BPONoL <> '') and (ChrgItemL <> '') and (PurchaseHeader."No." <> BPONoL) then begin
                                            //HEI.67<<
                                            BlankOrderNoforChargeItem := BPONoL;
                                            exit(ChrgItemL);
                                            //HEI.67>>
                                        end;
                                        //HEI.67<<
                                    end;
                                    //HEI.66<<
                                end;
                            end;
                        end;  //HEI.34
                    end;  //HEI.34
                          //HEI.69>>
                end;
            //HEI.69<<
            until PurchaseLine.NEXT() = 0;
        end;

        //HEI.05<<
    end;

    local procedure FindPurchReasonCode(): Code[10];
    var
        PurchReasonCode: Record "Reason Code_Purchase FND";
    begin
        //HEI.02>>
        PurchReasonCode.RESET();
        if PurchReasonCode.FINDFIRST() then
            exit(PurchReasonCode.Code);
        //HEI.02<<
    end;

    local procedure FindGLPTP084(): Code[20];
    var
        GLAccount: Record "G/L Account";
    begin
        //HEI.05>>
        GLAccount.RESET();
        GLAccount.SETRANGE("Direct Posting", true);
        GLAccount.SETRANGE("Account Type", GLAccount."Account Type"::Posting);
        GLAccount.SETRANGE("Acc Type FND", GLAccount."Acc Type FND"::" ");
        GLAccount.SETRANGE(Blocked, false);
        GLAccount.SETRANGE("Gen. Prod. Posting Group", '');
        GLAccount.SETRANGE("VAT Prod. Posting Group", '');
        GLAccount.SETRANGE("Gen. Posting Type", GLAccount."Gen. Posting Type"::" ");
        GLAccount.SETRANGE("VAT Bus. Posting Group", '');
        GLAccount.SETFILTER("Account Category", '<>%1', GLAccount."Account Category"::Liabilities);
        GLAccount.SETRANGE("Gen. Posting Type", GLAccount."Gen. Posting Type"::" ");
        GLAccount.SETFILTER("No.", '<>%1', '');//HEI.21
        if GLAccount.FINDFIRST() then begin
            exit(GLAccount."No.");
        end;
        //HEI.05 <<
    end;

    local procedure FindVendorPTP084(): Code[20];
    var
        RecVendor: Record Vendor;
    begin
        //HEI.05>>
        RecVendor.RESET();
        RecVendor.SETFILTER(Blocked, '%1', RecVendor.Blocked::" ");
        RecVendor.SETRANGE("Sensitive Payment Block FND", false);
        RecVendor.SETFILTER("Preferred Bank Account Code", '<>%1', '');
        RecVendor.SETRANGE("Gen. Bus. Posting Group", '3PV-TRADE');
        RecVendor.SETRANGE("IC Partner Code", '');
        if RecVendor.FINDFIRST() then
            exit(RecVendor."No.");
        //HEI.05<<
    end;

    local procedure "----------------------------P1-------------------------------------"();
    begin
    end;

    local procedure FindSRMBlanketOrder(): Code[20];
    var
        PurchaseHeader: Record "Purchase Header";
        InterfaceLogHeader: Record "Interface Log Header INT";
    begin
        //HEI.06>>
        PurchaseHeader.RESET();
        PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::"Blanket Order");
        PurchaseHeader.SETFILTER("Valid To FND", '>=%1', TODAY);
        if PurchaseHeader.FINDSET() then begin
            repeat
                InterfaceLogHeader.RESET();
                InterfaceLogHeader.SETRANGE("Source No.", PurchaseHeader."No.");
                InterfaceLogHeader.SETRANGE("Action Code", '02');
                InterfaceLogHeader.SETRANGE(Direction, InterfaceLogHeader.Direction::Inbound);
                if InterfaceLogHeader.FINDLAST() then
                    exit(PurchaseHeader."No.");
            until PurchaseHeader.NEXT() = 0;
        end;
        //HEI.06<<
    end;

    local procedure FindSRMBlanketOrderPCN002(): Code[20];
    var
        PurchaseHeader: Record "Purchase Header";
        InterfaceLogHeader: Record "Interface Log Header INT";
        PurchaseLinePrice: Record "Purchase Line Price FND";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        IsValid: Boolean;
        InterfaceLogLine: Record "Interface Log Line INT";
        Item: Record Item;
        PurchaseLine: Record "Purchase Line";
    begin
        //HEI.06>>
        //HEI.63>>
        PurchasesPayablesSetup.GET();
        //HEI.63<<
        PurchaseHeader.RESET();
        PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::"Blanket Order");
        PurchaseHeader.SETFILTER("Valid To FND", '>=%1', TODAY);
        //HEI.63>>
        PurchaseHeader.SETFILTER("Shipment Method Code", PurchasesPayablesSetup."Excluded Incoterms FND");
        //HEI.63<<
        PurchaseHeader.SETRANGE("Channel FND", 'A');
        if PurchaseHeader.FINDSET() then begin
            repeat
                InterfaceLogHeader.RESET();
                InterfaceLogHeader.SETRANGE("Source No.", PurchaseHeader."No.");
                InterfaceLogHeader.SETRANGE("Action Code", '02');
                InterfaceLogHeader.SETRANGE(Direction, InterfaceLogHeader.Direction::Inbound);
                //HEI.63>>
                if InterfaceLogHeader.FINDLAST() then begin
                    //HEI.64>>
                    //PurchaseLinePrice.RESET;
                    //PurchaseLinePrice.SETRANGE("Document No.", PurchaseHeader."No.");
                    IsValid := false;
                    InterfaceLogLine.RESET();
                    InterfaceLogLine.SETRANGE("Header Entry No.", InterfaceLogHeader."Entry No.");
                    if InterfaceLogLine.FINDSET(false) then begin
                        repeat
                            Item.RESET();
                            if Item.GET(InterfaceLogLine."No.") then begin
                                PurchaseLinePrice.RESET();
                                PurchaseLinePrice.SETCURRENTKEY("SRM Contract No.", "SRM Contract Line No.");
                                PurchaseLinePrice.SETRANGE("SRM Contract No.", InterfaceLogLine."External Contract No.");
                                PurchaseLinePrice.SETRANGE("SRM Contract Line No.", InterfaceLogLine."External Contract Line No.");
                                //IF PurchaseLinePrice.FINDFIRST THEN
                                //HEI.63<<
                                if PurchaseLinePrice.FINDLAST() then begin
                                    if ((PurchaseLinePrice."Starting Date" < TODAY) and (PurchaseLinePrice."Ending Date" < TODAY)) or
                                        (PurchaseLinePrice."Starting Date" > PurchaseHeader."Valid To FND") then
                                        IsValid := false
                                    else
                                        IsValid := true;
                                    if not PurchaseLine.GET(PurchaseLine."Document Type"::"Blanket Order", PurchaseHeader."No.", PurchaseLinePrice."Document Line No.") then
                                        IsValid := false
                                    else
                                        if (PurchaseLine."Block Line Ordering FND" <> PurchaseLine."Block Line Ordering FND"::" ") then
                                            IsValid := false;
                                end;
                            end;
                        until (InterfaceLogLine.NEXT() = 0) or (IsValid = false);
                    end;
                    if IsValid = true then
                        //HEI.64<<
                        exit(PurchaseHeader."No.");
                    //HEI.63>>
                end;
            //HEI.63<<
            until PurchaseHeader.NEXT() = 0;
        end;
        //HEI.06<<
    end;

    local procedure FindPaymentTerm(): Code[20];
    var
        PaymentTerms: Record "Payment Terms";
    begin
        //HEI.06>>
        if PaymentTerms.FINDFIRST() then
            exit(PaymentTerms.Code);
        //HEI.06<<
    end;

    local procedure FindGenJournalTemplatePTP074(): Code[20];
    var
        GenJournalTemplate: Record "Gen. Journal Template";
    begin
        //HEI.06>>
        if GenJournalTemplate.GET('PAY-TREE') then
            exit(GenJournalTemplate.Name);
        //HEI.06<<
    end;

    local procedure FindGenJournalBatchValue2PTP074(): Code[20];
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
    begin
        //HEI.06>>
        GenJournalBatch.RESET();
        GenJournalBatch.SETRANGE("Journal Template Name", FindGenJournalTemplatePTP074());
        GenJournalBatch.SETRANGE("Payment Method Code FND", 'CHEQUE');
        if GenJournalBatch.FINDSET() then begin
            repeat
                exit(GenJournalBatch.Name);
            until GenJournalBatch.NEXT() = 0;
        end;
        //HEI.06<<
    end;

    local procedure FindGLForGRIR(): Code[20];
    var
        GLAccount: Record "G/L Account";
    begin
        //HEI.06>>
        GLAccount.RESET();
        GLAccount.SETRANGE("Direct Posting", true);
        GLAccount.SETRANGE(Blocked, false);
        GLAccount.SETRANGE("Automatic application mode FND", GLAccount."Automatic application mode FND"::"GR/IR Accounts Payable");
        if GLAccount.FINDFIRST() then
            exit(GLAccount."No.");
        //HEI.06 <<
    end;

    local procedure FindVendorPTP102(): Code[20];
    var
        RecVendor: Record Vendor;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        VendorLedgerEntry1: Record "Vendor Ledger Entry";
        VendorApplicable: Boolean;
    begin
        //HEI.06>>
        if UPPERCASE(COMPANYNAME) <> UPPERCASE('10_BDB') then begin//HEI.31
            RecVendor.RESET();
            RecVendor.SETRANGE(Blocked, RecVendor.Blocked::" ");
            RecVendor.SETRANGE("Sensitive Payment Block FND", false);
            if RecVendor.FINDSET() then begin
                repeat
                    VendorApplicable := false;
                    VendorLedgerEntry1.RESET();
                    VendorLedgerEntry1.SETRANGE("Vendor No.", RecVendor."No.");
                    VendorLedgerEntry1.SETFILTER("Remaining Amount", '>%1', 1);
                    VendorLedgerEntry1.SETRANGE("Batch payment name FND", '');//HEI.12
                    VendorLedgerEntry1.SETRANGE(Open, true);
                    VendorLedgerEntry1.SETRANGE("Currency Code", RecVendor."Currency Code");//HEI.42
                    if VendorLedgerEntry1.FINDFIRST() then
                        VendorApplicable := true;
                    VendorLedgerEntry.RESET();
                    VendorLedgerEntry.SETRANGE("Vendor No.", RecVendor."No.");
                    VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Invoice);
                    VendorLedgerEntry.SETRANGE(Open, true);
                    VendorLedgerEntry.SETFILTER("Remaining Amount", '<%1', 0);//HEI.35
                    VendorLedgerEntry.SETRANGE("Currency Code", RecVendor."Currency Code");//HEI.42
                    if (VendorLedgerEntry.FINDFIRST()) and (VendorApplicable = true) then
                        exit(RecVendor."No.");
                until RecVendor.NEXT() = 0;
            end;
            //HEI.06<<
            //HEI.31>>
        end else begin
            RecVendor.RESET();
            RecVendor.SETRANGE(Blocked, RecVendor.Blocked::" ");
            RecVendor.SETRANGE("Sensitive Payment Block FND", false);
            if RecVendor.FINDSET() then begin
                repeat
                    VendorApplicable := false;
                    VendorLedgerEntry1.RESET();
                    VendorLedgerEntry1.SETRANGE("Vendor No.", RecVendor."No.");
                    VendorLedgerEntry1.SETFILTER("Remaining Amount", '>%1', 1);
                    VendorLedgerEntry1.SETRANGE("Batch payment name FND", '');//HEI.12
                    VendorLedgerEntry1.SETRANGE("Buy-from Vendor No.", RecVendor."No.");//HEI.XX
                    VendorLedgerEntry1.SETRANGE(Open, true);
                    if VendorLedgerEntry1.FINDFIRST() then
                        VendorApplicable := true;
                    VendorLedgerEntry.RESET();
                    VendorLedgerEntry.SETRANGE("Vendor No.", RecVendor."No.");
                    VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Invoice);
                    VendorLedgerEntry.SETRANGE(Open, true);
                    VendorLedgerEntry.SETFILTER("Remaining Amount", '<%1', 0);//HEI.35
                    if (VendorLedgerEntry.FINDFIRST()) and (VendorApplicable = true) then
                        exit(RecVendor."No.");
                until RecVendor.NEXT() = 0;
            end;
        end;
        //HEI.31<<
    end;

    local procedure FindLocationPRD107(): Code[20];
    var
        Location: Record Location;
    begin
        //HEI.06>>
        Location.RESET();
        Location.SETFILTER("Warning Threshold Days FND", '<>%1', 0);
        Location.SETFILTER("Batch sequential number FND", '<>%1', '');
        if Location.FINDFIRST() then begin
            exit(Location.Code);
        end else begin
            Location.RESET();
            Location.SETFILTER("Batch sequential number FND", '<>%1', '');
            if Location.FINDFIRST() then
                exit(Location.Code);
        end;
        //HEI.06 <<
    end;

    local procedure CreateWarehouseEmployeesForUser(UserName: Code[50]; LocationCode: Code[10]; ZoneCode: Code[10]);
    var
        WarehouseEmployee: Record "Warehouse Employee";
        Location: Record Location;
        Zone: Record Zone;
    begin
        //HEI.06>>
        if UserName = '' then
            exit;

        if (LocationCode = '') and (ZoneCode = '') then begin
            //Mass creation
            if Location.FINDSET() then
                repeat
                    Zone.SETRANGE("Location Code", Location.Code);
                    if Zone.FINDSET() then
                        repeat
                            WarehouseEmployee.RESET();
                            // BC UPGRADE PATELS08 >> # Too many key fields were specified, so "Warehouse Employee" could not be retrieved. The number of fields in the primary key is 2.
                            // if not WarehouseEmployee.GET(UserName, Location.Code, '', Zone.Code) then
                            if not WarehouseEmployee.GET(UserName, Location.Code) then
                                // BC UPGRADE PATELS08 <<
                                InsertWarehouseEmployee(UserName, Location.Code, Zone.Code);
                        until Zone.NEXT() = 0;
                until Location.NEXT() = 0;
        end else
            //Creation for specific Location
            if LocationCode <> '' then begin
                if not Location.GET(LocationCode) then
                    exit;
                //A specific Zone
                if ZoneCode <> '' then begin
                    if not Zone.GET(LocationCode, ZoneCode) then
                        exit;
                    // BC UPGRADE PATELS08 >> # Too many key fields were specified, so "Warehouse Employee" could not be retrieved. The number of fields in the primary key is 2.
                    // if not WarehouseEmployee.GET(UserName, LocationCode, '', ZoneCode) then
                    if not WarehouseEmployee.GET(UserName, LocationCode) then
                        // BC UPGRADE PATELS08 <<
                        InsertWarehouseEmployee(UserName, LocationCode, ZoneCode);
                end else begin
                    //All Zones
                    Zone.SETRANGE("Location Code", LocationCode);
                    if Zone.FINDSET() then
                        repeat
                            WarehouseEmployee.RESET();
                            // BC UPGRADE PATELS08 >> # Too many key fields were specified, so "Warehouse Employee" could not be retrieved. The number of fields in the primary key is 2.
                            // if not WarehouseEmployee.GET(UserName, LocationCode, '', Zone.Code) then
                            if not WarehouseEmployee.GET(UserName, LocationCode) then
                                // BC UPGRADE PATELS08 <<
                                InsertWarehouseEmployee(UserName, LocationCode, Zone.Code);
                        until Zone.NEXT() = 0;
                end;
            end;
        //No creation for other cases
        //HEI.06<<
    end;

    local procedure InsertWarehouseEmployee(UserName: Code[50]; LocationCode: Code[10]; ZoneCode: Code[10]);
    var
        WarehouseEmployee: Record "Warehouse Employee";
    begin
        //HEI.06>>
        WarehouseEmployee.INIT();
        WarehouseEmployee.VALIDATE("User ID", UserName);
        WarehouseEmployee.VALIDATE("Location Code", LocationCode);
        WarehouseEmployee.VALIDATE("Zone Code FND", ZoneCode);
        WarehouseEmployee.INSERT(true);
        //HEI.06<<
    end;

    local procedure FindItemPRD107(): Code[20];
    var
        RecItem: Record Item;
        Bin: Record Bin;
    begin
        //HEI.06>>
        if UPPERCASE(COMPANYNAME) <> UPPERCASE('10_BDB') then begin//HEI.32
            RecItem.RESET();
            RecItem.SETRANGE(Blocked, false);
            RecItem.SETRANGE("Item Tracking Code", 'LOTALL');
            RecItem.SETFILTER("Gen. Prod. Posting Group", '<>%1', 'FGPO');//HEI.28
            if RecItem.FINDSET() then begin
                repeat
                    if RecItem."Base Unit of Measure" = RecItem."Purch. Unit of Measure" then begin
                        BinContent.RESET();
                        BinContent.SETRANGE("Location Code", FindLocationPRD107());
                        BinContent.SETRANGE("Item No.", RecItem."No.");
                        BinContent.SETRANGE(Default, true);
                        if BinContent.FINDFIRST() then begin //HEI.57
                            Bin.RESET();
                            Bin.SETRANGE("Location Code", BinContent."Location Code");
                            Bin.SETRANGE(Code, BinContent."Bin Code");
                            Bin.SETFILTER("Batch Production Resource FND", '<>%1', '');
                            if Bin.FINDFIRST() then
                                exit(RecItem."No.");
                        end; //HEI.57
                    end;
                until RecItem.NEXT() = 0;
            end;
        end;//HEI.32
        //HEI.06 <<
    end;

    procedure SetParameters(pCreateGenJournalUsers: Boolean; pCreateWarehouseEmployees: Boolean; pDeleteExistingValues: Boolean; pHideDialogs: Boolean);
    begin
        //HEI.07>>
        CreateGenJournalUsers := pCreateGenJournalUsers;//HEI.08
        CreateWarehouseEmployees := pCreateWarehouseEmployees;
        DeleteExistingValues := pDeleteExistingValues;
        CurrReport.USEREQUESTPAGE(false);
        HideDialogs := pHideDialogs;
        //HEI.07<<
    end;

    local procedure CreateUserGeneralJournalForUser(UserName: Code[50]; JournalType: Option General,Item; GenJournalType: Option General,Sales,Purchases,"Cash Receipts",Payments,Assets,Intercompany,Jobs);
    var
        UserGenJournalSetup: Record "User Gen. Journal Setup FND";
        GenJournalTemplate: Record "Gen. Journal Template";
    begin
        //HEI.08>>
        if UserName = '' then
            exit;

        UserGenJournalSetup.RESET();
        GenJournalTemplate.RESET();
        GenJournalTemplate.SETRANGE(Type, GenJournalType);
        if GenJournalTemplate.FINDSET() then
            repeat
                UserGenJournalSetup.SETRANGE("Journal Type", JournalType);
                UserGenJournalSetup.SETRANGE("Gen. Journal Template Name", GenJournalTemplate.Name);
                UserGenJournalSetup.SETRANGE("User ID", UserName);
                if not UserGenJournalSetup.FINDFIRST() then begin
                    UserGenJournalSetup.INIT();
                    UserGenJournalSetup.VALIDATE("Journal Type", JournalType);
                    UserGenJournalSetup.VALIDATE("Gen. Journal Template Name", GenJournalTemplate.Name);
                    UserGenJournalSetup.VALIDATE("User ID", UserName);
                    UserGenJournalSetup.INSERT();
                end;
            until GenJournalTemplate.NEXT() = 0;
        //HEI.08<<
    end;

    local procedure FindVendorForPayment(): Code[20];
    var
        RecVendor: Record Vendor;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        //HEI.10>>
        RecVendor.RESET();
        RecVendor.SETFILTER(Blocked, '%1', RecVendor.Blocked::" ");
        RecVendor.SETRANGE("Sensitive Payment Block FND", false);
        if RecVendor.FINDSET() then begin
            repeat
                VendorLedgerEntry.CALCFIELDS("Remaining Amount");//HEI.14
                VendorLedgerEntry.RESET();
                VendorLedgerEntry.SETRANGE("Vendor No.", RecVendor."No.");
                VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Payment);
                VendorLedgerEntry.SETRANGE(Open, false);
                VendorLedgerEntry.SETRANGE("Remaining Amount", 0);//HEI.14
                if VendorLedgerEntry.FINDFIRST() then
                    exit(RecVendor."No.");
            until RecVendor.NEXT() = 0
        end;
        //HEI.10<<
    end;

    local procedure FindVendorForPTP079(): Code[20];
    var
        RecVendor: Record Vendor;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        //HEI.10>>
        RecVendor.RESET();
        RecVendor.SETFILTER(Blocked, '%1', RecVendor.Blocked::" ");
        RecVendor.SETRANGE("Sensitive Payment Block FND", false);
        RecVendor.SETFILTER("Preferred Bank Account Code", '<>%1', '');
        if RecVendor.FINDSET() then begin
            repeat
                VendorLedgerEntry.RESET();
                VendorLedgerEntry.SETRANGE("Vendor No.", RecVendor."No.");
                VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Invoice);
                //VendorLedgerEntry.SETRANGE(Open,FALSE);//HEI.14
                if VendorLedgerEntry.FINDFIRST() then
                    exit(RecVendor."No.");
            until RecVendor.NEXT() = 0
        end;
        //HEI.10<<
    end;

    local procedure FindVendorForInvoice(): Code[20];
    var
        RecVendor: Record Vendor;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        //HEI.10>>
        RecVendor.RESET();
        RecVendor.SETFILTER(Blocked, '%1', RecVendor.Blocked::" ");
        RecVendor.SETRANGE("Sensitive Payment Block FND", false);
        //RecVendor.SETFILTER("Preferred Bank Account Code",'<>%1','');
        if RecVendor.FINDSET() then begin
            repeat
                VendorLedgerEntry.RESET();
                VendorLedgerEntry.SETRANGE("Vendor No.", RecVendor."No.");
                VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Invoice);
                //VendorLedgerEntry.SETFILTER("Remaining Amount",'>%1',1);//HEI.14
                VendorLedgerEntry.SETFILTER("Remaining Amount", '<%1', -1);//HEI.14
                VendorLedgerEntry.SETRANGE(Open, true);
                if VendorLedgerEntry.FINDFIRST() then
                    exit(RecVendor."No.");
            until RecVendor.NEXT() = 0
        end;
        //HEI.10<<
    end;

    local procedure FindGenJournalBatchNetting(): Code[20];
    var
        GenJournalBatch: Record "Gen. Journal Batch";
    begin
        //HEI.10>>
        GenJournalBatch.RESET();
        GenJournalBatch.SETRANGE("Journal Template Name", FindGenJournalTemplate());
        //GenJournalBatch.SETRANGE("Payment Method Code",'NETTING');//HEI.14
        GenJournalBatch.SETRANGE(Name, 'NETTING');//HEI.14
        if GenJournalBatch.FINDSET() then begin
            repeat
                exit(GenJournalBatch.Name);
            until GenJournalBatch.NEXT() = 0;
        end;
        //HEI.10<<
    end;

    local procedure FindDimensionforItemCharge(): Code[20];
    var
        DimensionValue: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        Vendor: Record Vendor;
        ItemCharge: Record "Item Charge";
        GeneralPostingSetup: Record "General Posting Setup";
    begin
        //HEI.12>>
        if Vendor.GET(FindVendor()) then; //HEI.15
        ItemCharge.GET(FindItemCharge());
        if GeneralPostingSetup.GET(Vendor."Gen. Bus. Posting Group", ItemCharge."Gen. Prod. Posting Group") then;//HEI.15
        DimensionValue.RESET();
        DimensionValue.SETRANGE(Blocked, false);
        DimensionValue.SETRANGE("Dimension Code", 'CCC');
        if DimensionValue.FINDSET() then begin
            repeat
                EbfCombination.SETRANGE("GL Account No.", GeneralPostingSetup."Purch. Account");
                EbfCombination.SETRANGE("Dimension Code", DimensionValue."Dimension Code");
                //HEI.44>>
                //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue.Code);
                //HEI.48>>
                //STPTestScript.GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
                //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
                //HEI.48<<
                //HEI.44<<
                EbfCombination.SETFILTER("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::"Not Allowed");
                if EbfCombination.FINDFIRST() then
                    exit(DimensionValue.Code);
            until DimensionValue.NEXT() = 0;
        end;
        //HEI.24>>
        DimensionValue.RESET();
        DimensionValue.SETRANGE(Blocked, false);
        DimensionValue.SETRANGE("Dimension Code", 'CCC');
        if DimensionValue.FINDSET() then begin
            repeat
                EbfCombination.RESET();
                EbfCombination.SETRANGE("Dimension Code", DimensionValue."Dimension Code");
                //HEI.44>>
                //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue.Code);
                //HEI.48>>
                //STPTestScript.GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
                //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
                //HEI.48<<
                //HEI.44<<
                EbfCombination.SETFILTER("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::"Not Allowed");
                if EbfCombination.FINDFIRST() then
                    exit(DimensionValue.Code);
            until DimensionValue.NEXT() = 0;
        end;
        //HEI.24<<
        //HEI.12<<
    end;

    local procedure FindDimensionforItem(): Code[20];
    var
        DimensionValue: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        Vendor: Record Vendor;
        Item: Record Item;
        GeneralPostingSetup: Record "General Posting Setup";
    begin
        //HEI.12>>
        if Vendor.GET(FindVendor()) then; //HEI.15
        if Item.GET(FindItemPRD107()) then
            if GeneralPostingSetup.GET(Vendor."Gen. Bus. Posting Group", Item."Gen. Prod. Posting Group") then;//HEI.15
        DimensionValue.RESET();
        DimensionValue.SETRANGE(Blocked, false);
        DimensionValue.SETRANGE("Dimension Code", 'CCC');
        if DimensionValue.FINDSET() then begin
            repeat
                EbfCombination.SETRANGE("GL Account No.", GeneralPostingSetup."Purch. Account");
                EbfCombination.SETRANGE("Dimension Code", DimensionValue."Dimension Code");
                //HEI.44>>
                //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue.Code);
                //HEI.48>>
                //STPTestScript.GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
                //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
                //HEI.48<<
                //HEI.44<<
                EbfCombination.SETFILTER("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::"Not Allowed");
                if EbfCombination.FINDFIRST() then
                    exit(DimensionValue.Code);
            until DimensionValue.NEXT() = 0;
        end;
        //HEI.12<<
        //HEI.26>>
        DimensionValue.RESET();
        DimensionValue.SETRANGE(Blocked, false);
        DimensionValue.SETRANGE("Dimension Code", 'CCC');
        if DimensionValue.FINDFIRST() then
            exit(DimensionValue.Code);
        //HEi.26<<
    end;

    local procedure EnableWorkflows();
    var
        Workflow: Record Workflow;
        WorkflowStepArgument: Record "Workflow Step Argument";
        UserSetup: Record "User Setup";
        ApprovalUserSetup: Record "User Setup";
        ApprovalUserSetup1: Record "User Setup";
    begin
        //HEI.12>>
        Workflow.RESET();
        Workflow.SETRANGE(Category, 'PURCHDOC');
        Workflow.SETFILTER(Code, '%1|%2|%3|%4|%5|%6|%7|%8',
                          'MS-POAPW', 'MS-POAPW-01', 'MS-POAPW-02', 'MS-POAPW-04', 'MS-POAPW-05', 'MS-PQAPW', 'MS-PQAPW-01', 'MS-PQAPW-02');
        Workflow.SETRANGE(Enabled, false);
        Workflow.SETRANGE(Template, false);
        if Workflow.FINDSET() then begin
            repeat
                Workflow.VALIDATE(Enabled, true);
                Workflow.MODIFY();
            until Workflow.NEXT() = 0;
        end;
        UserSetup.RESET();
        UserSetup.SETFILTER("User ID", '<>%1', USERID);
        UserSetup.SETRANGE("Unlimited Request Approval", true);
        if UserSetup.FINDFIRST() then begin
            WorkflowStepArgument.RESET();
            WorkflowStepArgument.SETRANGE("Approver User ID", USERID);
            if WorkflowStepArgument.FINDSET() then begin
                repeat
                    WorkflowStepArgument."Approver User ID" := UserSetup."User ID";
                    WorkflowStepArgument.MODIFY();
                until WorkflowStepArgument.NEXT() = 0;
            end;
            ApprovalUserSetup.RESET();
            ApprovalUserSetup.SETRANGE("User ID", USERID);
            ApprovalUserSetup.SETFILTER("Approver ID", '<>%1', '');
            if ApprovalUserSetup.FINDFIRST() then begin
                ApprovalUserSetup1.RESET();
                ApprovalUserSetup1.SETRANGE("User ID", ApprovalUserSetup."Approver ID");
                ApprovalUserSetup1.SETRANGE("Unlimited Request Approval", false);
                if ApprovalUserSetup1.FINDFIRST() then begin
                    ApprovalUserSetup.VALIDATE("Approver ID", UserSetup."User ID");
                    ApprovalUserSetup.MODIFY();
                end;
            end;
            ApprovalUserSetup.RESET();
            ApprovalUserSetup.SETRANGE("User ID", USERID);
            ApprovalUserSetup.SETRANGE("Approver ID", '');
            if ApprovalUserSetup.FINDFIRST() then begin
                ApprovalUserSetup.VALIDATE("Approver ID", UserSetup."User ID");
                ApprovalUserSetup.MODIFY();
            end;
        end;
        //HEI.12<<
    end;

    local procedure FindVendorPTP053(): Code[20];
    var
        RecVendor: Record Vendor;
    begin
        //HEI.14>>
        RecVendor.RESET();
        RecVendor.SETRANGE(Blocked, RecVendor.Blocked::" ");
        RecVendor.SETRANGE("Sensitive Payment Block FND", false);
        RecVendor.SETRANGE("Gen. Bus. Posting Group", '3PV-TRADE');
        RecVendor.SETFILTER("Payment Method Code", '<>%1', 'BANK CON');
        if RecVendor.FINDFIRST() then
            exit(RecVendor."No.");
        //HEI.14<<
        //HEI.26>>
        RecVendor.RESET();
        RecVendor.SETRANGE(Blocked, RecVendor.Blocked::" ");
        RecVendor.SETRANGE("Sensitive Payment Block FND", false);
        RecVendor.SETRANGE("Gen. Bus. Posting Group", '3PV-TRADE');
        if RecVendor.FINDFIRST() then
            exit(RecVendor."No.");
        //HEI.26<<
    end;

    local procedure FindVendorVATPosting(): Code[20];
    var
        RecVendor: Record Vendor;
    begin
        //HEI.14>>
        RecVendor.RESET();
        RecVendor.SETFILTER(Blocked, '%1', RecVendor.Blocked::" ");
        RecVendor.SETRANGE("Sensitive Payment Block FND", false);
        RecVendor.SETFILTER("Preferred Bank Account Code", '<>%1', '');
        RecVendor.SETRANGE("Gen. Bus. Posting Group", '3PV-TRADE');
        RecVendor.SETRANGE("VAT Bus. Posting Group", '3PV-TRADE');
        if RecVendor.FINDFIRST() then
            exit(RecVendor."No.");
        //HEI.14<<
    end;

    local procedure FindVendorForPTP086(): Code[20];
    var
        RecVendor: Record Vendor;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        //HEI.14>>
        RecVendor.RESET();
        RecVendor.SETFILTER(Blocked, '%1', RecVendor.Blocked::" ");
        RecVendor.SETRANGE("Sensitive Payment Block FND", false);
        if RecVendor.FINDSET() then begin
            repeat
                VendorLedgerEntry.CALCFIELDS("Remaining Amount");
                VendorLedgerEntry.RESET();
                VendorLedgerEntry.SETRANGE("Vendor No.", RecVendor."No.");
                VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Payment);
                VendorLedgerEntry.SETRANGE(Open, false);
                VendorLedgerEntry.SETRANGE("Remaining Amount", 0);
                VendorLedgerEntry.SETFILTER("Journal Batch Name", '<>%1', '');
                if VendorLedgerEntry.FINDFIRST() then
                    exit(RecVendor."No.");
            until RecVendor.NEXT() = 0
        end;
        //HEI.14<<
    end;

    local procedure FindVendorPTP133(): Code[20];
    var
        RecVendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
    begin
        //HEI.16>>
        RecVendor.RESET();
        RecVendor.SETFILTER(Blocked, '%1', RecVendor.Blocked::" ");
        RecVendor.SETRANGE("Sensitive Payment Block FND", false);
        RecVendor.SETFILTER("Preferred Bank Account Code", '<>%1', '');
        RecVendor.SETRANGE("Gen. Bus. Posting Group", '3PV-TRADE');
        if RecVendor.FINDSET() then begin
            repeat
                VendorBankAccount.RESET();
                VendorBankAccount.SETRANGE("Vendor No.", RecVendor."No.");
                VendorBankAccount.SETRANGE(Code, RecVendor."Preferred Bank Account Code");
                VendorBankAccount.SETFILTER(Address, '<>%1', '');
                VendorBankAccount.SETFILTER("Bank Branch No.", '<>%1', '');
                VendorBankAccount.SETFILTER("Bank Account No.", '<>%1', '');
                VendorBankAccount.SETFILTER("SWIFT Code", '<>%1', '');
                VendorBankAccount.SETFILTER(IBAN, '<>%1', '');
                if VendorBankAccount.FINDFIRST() then
                    exit(RecVendor."No.");
            until RecVendor.NEXT() = 0;
        end;
        //HEI.16<<
        //HEI.30>>
        RecVendor.RESET();
        RecVendor.SETFILTER(Blocked, '%1', RecVendor.Blocked::" ");
        RecVendor.SETRANGE("Sensitive Payment Block FND", false);
        RecVendor.SETFILTER("Preferred Bank Account Code", '<>%1', '');
        RecVendor.SETRANGE("Gen. Bus. Posting Group", '3PV-TRADE');
        RecVendor.SETRANGE("VAT Bus. Posting Group", '3PV-TRADE');
        if RecVendor.FINDFIRST() then
            exit(RecVendor."No.");
        //HEI.30<<
    end;

    local procedure FindShippingCostItemCharge(): Code[20];
    var
        ItemCharge: Record "Item Charge";
    begin
        //HEI.17>>
        ItemCharge.RESET();
        //ItemCharge.SETRANGE("Item Charge Type", ItemCharge."Item Charge Type"::ShippingCost);  //BC Upgrade KAPOOV01 Commented Drink-IT field-"Item Charge Type" of table-"Item Charge"
        ItemCharge.SetRange("Shipping Cost BPM FND", true);  //#BCUP0-RTR-BPM Item Charges BC Upgrade KAIRAR01
        if ItemCharge.FINDFIRST() then
            exit(ItemCharge."No.");
        //HEI.17<<
    end;

    local procedure FindCCCDimensionforItemCharge(): Code[20];
    var
        DimensionValue: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        Vendor: Record Vendor;
        ItemCharge: Record "Item Charge";
        GeneralPostingSetup: Record "General Posting Setup";
    begin
        //HEI.17>>
        if Vendor.GET(FindVendor()) then;
        if ItemCharge.GET(FindShippingCostItemCharge()) then;
        if GeneralPostingSetup.GET(Vendor."Gen. Bus. Posting Group", ItemCharge."Gen. Prod. Posting Group") then;
        DimensionValue.RESET();
        DimensionValue.SETRANGE(Blocked, false);
        DimensionValue.SETRANGE("Dimension Code", 'CCC');
        if DimensionValue.FINDSET(false) then begin
            repeat
                EbfCombination.SETRANGE("GL Account No.", GeneralPostingSetup."Purch. Account");
                EbfCombination.SETRANGE("Dimension Code", DimensionValue."Dimension Code");
                //HEI.44>>
                //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue.Code);
                //HEI.48>>
                //STPTestScript.GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
                //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
                //HEI.48<<
                //HEI.44<<
                EbfCombination.SETFILTER("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::"Not Allowed");
                if EbfCombination.FINDFIRST() then
                    exit(DimensionValue.Code);
            until DimensionValue.NEXT() = 0;
        end;
        DimensionValue.RESET();
        DimensionValue.SETRANGE(Blocked, false);
        DimensionValue.SETRANGE("Dimension Code", 'CCC');
        if DimensionValue.FINDFIRST() then
            exit(DimensionValue.Code);
        //HEI.17<<
    end;

    local procedure FindCMGDimension(): Code[20];
    var
        DimensionValue: Record "Dimension Value";
    begin
        //HEI.17>>
        DimensionValue.RESET();
        DimensionValue.SETRANGE(Blocked, false);
        DimensionValue.SETRANGE("Dimension Code", 'CMG');
        if DimensionValue.FINDFIRST() then
            exit(DimensionValue.Code);
        //HEI.17<<
    end;

    //BC Upgrade KAPOOV01 Commented procedure FindShippingAgent as it is dependent on Drink-IT Table-Shipping Agent Purch. Price" >>
    // local procedure FindShippingAgent(): Code[20];
    // var
    //     ShippingAgentServices: Record "Shipping Agent Services";
    //     ShippingAgentPurchPrice: Record "Shipping Agent Purch. Price";
    // begin
    //     //HEI.17>>
    //     ShippingAgentServices.RESET;
    //     ShippingAgentServices.SETRANGE("Allow Shipping Cost Per", ShippingAgentServices."Allow Shipping Cost Per"::Document);
    //     ShippingAgentServices.SETFILTER(Code, '<>%1', 'BLOCKED');
    //     if ShippingAgentServices.FINDSET(false, false) then begin
    //         repeat
    //             ShippingAgentPurchPrice.RESET;
    //             ShippingAgentPurchPrice.SETRANGE("Shipping Agent Code", ShippingAgentServices."Shipping Agent Code");
    //             ShippingAgentPurchPrice.SETRANGE("Shipping Agent Service Code", ShippingAgentServices.Code);
    //             ShippingAgentPurchPrice.SETFILTER("Unit Cost", '<>%1', 0);
    //             if ShippingAgentPurchPrice.FINDFIRST then begin
    //                 CLEAR(ShippingAgentServicesCode);
    //                 ShippingAgentServicesCode := ShippingAgentPurchPrice."Shipping Agent Service Code";
    //                 exit(ShippingAgentPurchPrice."Shipping Agent Code");
    //             end;
    //         until ShippingAgentServices.NEXT = 0;
    //     end;
    //     //HEI.17<<
    // end;
    //BC Upgrade KAPOOV01 Commented procedure FindShippingAgent as it is dependent on Drink-IT Table-Shipping Agent Purch. Price" <<

    local procedure FindPLForItem_PCN009(): Code[20];
    var
        PurchaseLine: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLinePrice: Record "Purchase Line Price FND";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        LocationCode: Code[20];
    begin
        //HEI.18>>
        PurchaseLine.RESET();
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::"Blanket Order");
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        PurchaseLine.SETFILTER("Valid To FND", '>=%1', TODAY);
        PurchaseLine.SETFILTER("Outstanding Quantity", '<>%1', 0);
        PurchaseLine.SETFILTER("Qty. Rcd. Not Invoiced", '>%1', 1);
        PurchaseLine.SETRANGE("Block Line Ordering FND", PurchaseLine."Block Line Ordering FND"::" ");
        PurchaseLine.SETRANGE("Tolerance Received Over % FND", 0);
        PurchaseLine.SETRANGE("Tolerance Received Under % FND", 0);
        PurchaseLine.SETRANGE("Delivery Finalized FND", false);
        PurchaseLine.SETFILTER("Consumption Location Code FND", '<>%1', '');
        //HEI.65>>
        //PurchaseLine.SETFILTER("Quantity Received" , '<>%1',0);
        //HEI.65<<
        if PurchaseLine.FINDSET(false) then
            repeat
                //HEI.65>>
                pline := PurchaseLine."Line No.";
                //HEI.65<<
                //HEI.64>>
                //received := FALSE;
                //IF PurchaseHeader1.GET(PurchaseHeader1."Document Type"::"Blanket Order",PurchaseLine."Document No.") THEN BEGIN
                //PurchaseLine1.RESET;
                //PurchaseLine1.COPYFILTERS(PurchaseLine);
                //PurchaseLine1.SETRANGE("Document No.",PurchaseLine."Document No.");
                //IF PurchaseLine1.FINDSET(FALSE,FALSE) THEN BEGIN
                //REPEAT
                //IF PurchaseLine1."Quantity Received" <> 0 THEN BEGIN
                //received := TRUE;
                //pline := PurchaseLine1."Line No.";
                //END;
                //UNTIL PurchaseLine1.NEXT = 0;
                //END;
                //END;
                //IF received THEN BEGIN
                //HEI.64<<
                if PurchaseHeader.GET(PurchaseHeader."Document Type"::"Blanket Order", PurchaseLine."Document No.") then begin
                    CLEAR(BlankOrderNoforItem_PCN009);
                    CLEAR(LocationCode);
                    if PurchaseHeader."Channel FND" = 'A' then begin
                        PurchasesPayablesSetup.GET();
                        //HEI.41>>
                        //IF (PurchasesPayablesSetup."Excluded Incoterms FND"='DAP|DDP') AND (PurchasesPayablesSetup."Location Code for Import Proc."<>'') THEN BEGIN
                        if (PurchasesPayablesSetup."Excluded Incoterms FND" in ['DAP|DDP', 'DDP|DAP']) and (PurchasesPayablesSetup."Location Code Imp Proc. FND" <> '') then begin
                            //HEI.41<<
                            if not (PurchaseHeader."Shipment Method Code" in ['DAP', 'DDP']) then
                                LocationCode := PurchasesPayablesSetup."Location Code Imp Proc. FND"
                            else
                                LocationCode := PurchaseLine."Consumption Location Code FND";
                        end else
                            LocationCode := PurchaseLine."Consumption Location Code FND";
                        PurchaseLinePrice.RESET();
                        PurchaseLinePrice.SETRANGE("Document Type", PurchaseLine."Document Type");
                        PurchaseLinePrice.SETRANGE("Document No.", PurchaseLine."Document No.");
                        PurchaseLinePrice.SETRANGE("Document Line No.", PurchaseLine."Line No.");
                        PurchaseLinePrice.SETRANGE("Item No.", PurchaseLine."No.");
                        PurchaseLinePrice.SETFILTER("Ending Date", '>=%1', TODAY);
                        PurchaseLinePrice.SETFILTER("Direct Unit Cost", '<>%1', 0);
                        PurchaseLinePrice.SETFILTER("Location Code", '%1|%2', LocationCode, '');
                        if PurchaseLinePrice.FINDSET(false) then
                            repeat
                                BlankOrderNoforItem_PCN009 := PurchaseHeader."No.";
                                exit(PurchaseLine."No.");
                            until PurchaseLinePrice.NEXT() = 0;
                    end;
                end;
            //HEI.64>>
            //END;
            //HEI.64<<
            until PurchaseLine.NEXT() = 0;
        //HEI.18<<
    end;

    local procedure FindBrandDimension(): Code[20];
    var
        DimensionValue: Record "Dimension Value";
    begin
        //HEI.21>>
        DimensionValue.RESET();
        DimensionValue.SETRANGE(Blocked, false);
        DimensionValue.SETRANGE("Dimension Code", 'BRAND');
        if DimensionValue.FINDFIRST() then
            exit(DimensionValue.Code);
        //HEI.21<<
    end;

    local procedure FindBinPRD107(): Code[20];
    var
        Bin: Record Bin;
    begin
        //HEI.33>>
        Bin.RESET();
        Bin.SETRANGE("Location Code", FindLocationPRD107());
        if Bin.FINDFIRST() then
            exit(Bin.Code);
        //HEI.33<<
    end;

    local procedure FindItemWithLotAndInventory(ItemCategoryCode: Code[10]; var LocationCode: Code[10]; var LotNo: Code[20]; var ZoneCode: Code[10]; var BinCode: Code[10]; ItemTrackCode: Code[10]) ItemNoAWLot: Code[20];
    begin
        ItemNoAWLot := '';
        //ItemNoAWLot := FindItemAvailableLot(ItemCategoryCode,LocationCode,LotNo,ZoneCode,BinCode,TRUE,ItemTrackCode);
        exit(ItemNoAWLot);
    end;

    local procedure GetGenJournalBatch(): Code[20];
    var
        gGenJnlBatches: Record "Gen. Journal Batch";
    begin
        //HEI.47>>
        gGenJnlBatches.RESET();
        gGenJnlBatches.SETRANGE("Journal Template Name", GetGenJournalTemplate()); //HEI.49
        if gGenJnlBatches.FINDFIRST() then
            exit(gGenJnlBatches.Name);

        exit('');
        //HEI.47<<
    end;

    local procedure GetGenJournalTemplate(): Text[20];
    var
        SourceCodeSetup1: Record "Source Code Setup";
        GenJournalTemplate1: Record "Gen. Journal Template";
        Vendor1: Record Vendor;
        gGenJnlBatches1: Record "Gen. Journal Batch";
    begin
        //HEI.55>>
        /*SourceCodeSetup.GET;
        
        IF SourceCodeSetup."Payment Journal Tree" <> '' THEN
          BEGIN
            GenJournalTemplate.RESET;
            GenJournalTemplate.SETRANGE(Type,GenJournalTemplate.Type::Payments);
            GenJournalTemplate.SETRANGE("Source Code",SourceCodeSetup."Payment Journal Tree");
            IF GenJournalTemplate.FINDFIRST THEN
              EXIT(GenJournalTemplate.Name)
            ELSE
              BEGIN
                GenJournalTemplate.SETRANGE("Source Code");
                IF GenJournalTemplate.FINDLAST THEN
                  EXIT(GenJournalTemplate.Name);
               END;
          END;
         EXIT('');
        //HEI.49<<
        */
        SourceCodeSetup1.GET();

        VendorNo := FindVendor();
        if VendorNo <> '' then
            Vendor1.GET(VendorNo);
        //BC Upgrade KAPOOV01 Commented below code dependent on DRINK-IT Field-"Payment Journal Tree" of Source Code Setup Table >>
        if SourceCodeSetup1."Payment Journal Tree FND" <> '' then begin
            GenJournalTemplate1.RESET;
            GenJournalTemplate1.SETRANGE(Type, GenJournalTemplate1.Type::Payments);
            if GenJournalTemplate1.FINDFIRST then
                repeat
                    gGenJnlBatches1.RESET;
                    gGenJnlBatches1.SETRANGE("Journal Template Name", GenJournalTemplate1.Name);
                    gGenJnlBatches1.SETRANGE("Payment Method Code FND", Vendor1."Payment Method Code");
                    if gGenJnlBatches1.FINDFIRST then
                        exit(GenJournalTemplate1.Name);
                until GenJournalTemplate1.NEXT = 0;
        end;
        exit('');
        //HEI.55<<

    end;

    local procedure ValidatePOBlanketOrder(var PurchBlanketOrderLine: Record "Purchase Line") IsValid: Boolean;
    var
        PurchLineL: Record "Purchase Line";
        QuantityOnOrdersL: Decimal;
    begin
        //HEI.66>>
        PurchLineL.RESET();
        PurchLineL.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        PurchLineL.SETRANGE("Document Type", PurchLineL."Document Type"::Order);
        PurchLineL.SETRANGE("Blanket Order No.", PurchBlanketOrderLine."Document No.");
        PurchLineL.SETRANGE("Blanket Order Line No.", PurchBlanketOrderLine."Line No.");
        QuantityOnOrdersL := 0;
        if PurchLineL.FINDSET(false) then begin
            repeat
                if (PurchLineL."Document Type" = PurchLineL."Document Type"::"Return Order") or
                  ((PurchLineL."Document Type" = PurchLineL."Document Type"::"Credit Memo") and
                    (PurchLineL."Return Shipment No." = ''))
                then
                    QuantityOnOrdersL := QuantityOnOrdersL - PurchLineL."Outstanding Qty. (Base)"
                else
                    if (PurchLineL."Document Type" = PurchLineL."Document Type"::Order) or
                      ((PurchLineL."Document Type" = PurchLineL."Document Type"::Invoice) and
                        (PurchLineL."Receipt No." = ''))
                    then
                        QuantityOnOrdersL := QuantityOnOrdersL + PurchLineL."Outstanding Qty. (Base)";
            until PurchLineL.NEXT() = 0;
        end;
        if (ABS(PurchBlanketOrderLine."Qty. to Receive (Base)" + QuantityOnOrdersL +
          PurchBlanketOrderLine."Qty. Received (Base)") >
            ABS(PurchBlanketOrderLine."Quantity (Base)")) or
              (PurchBlanketOrderLine."Quantity (Base)" * PurchBlanketOrderLine."Outstanding Qty. (Base)" < 0)
        then
            IsValid := false
        else
            IsValid := true;
        //HEI.66<<
    end;
}

