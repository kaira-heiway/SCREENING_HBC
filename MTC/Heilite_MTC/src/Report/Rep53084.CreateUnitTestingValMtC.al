report 53084 "Create Unit Testing Val MtC"
{
    // version TS,HEI.44

    // HEI.01 RITM2743316 IBM NASTAA02 24.11.2021 # Automation MTC Test Scripts
    //   # New Report created to setup Unit Testing Values automatically
    // HEI.02 RITM2743316 IBM NASTAA02 24.12.2021 # Automation MTC Test Scripts
    //   # Functions created for Part 2
    // HEI.03 RITM2743316 IBM GHOSHS05 28.12.2021 # Automation MTC Test Scripts
    //   # Functions created for Part 2
    // HEI.04 RITM2901715 IBM NASTAA02 04.01.2022 # Automation MTC Test Scripts
    //   # Functions created for Part 3
    // HEI.05 RITM2901715 IBM GHOSHS05 05.01.2022 # Automation MTC Test Scripts
    //   # Functions created for Part 3
    // HEI.06 RITM2901715 IBM NASTAA02 26.01.2022 # Automation MTC Test Scripts
    //   # Create data for new Scripts
    // HEI.07 RITM2901715 IBM NASTAA02 07.02.2022 # Automation MTC Test Scripts
    //   # New option added to create automatically Warehouse Employees for UserID
    // HEI.08 RITM2901715 IBM NASTAA02 08.02.2022 # Automation MTC Test Scripts
    //   # Create data for new Scripts
    // HEI.09 RITM2901715 IBM NASTAA02 10.02.2022 # Automation MTC Test Scripts
    //   # Create data for new Scripts
    // HEI.10 RITM2941384 IBM NASTAA02 17.02.2022 # Automation MtC Test Scripts
    //   # Create data for new Scripts
    // HEI.11 RITM2941384 IBM GHOSHS05 21.02.2022 # Automation MtC Test Scripts
    //   # Create data for new Scripts
    // HEI.12 RITM2941384 IBM NASTAA02 23.02.2022 # Automation MtC Test Scripts
    //   # Create data for new Scripts
    // HEI.13 RITM2941384 IBM NASTAA02 24.02.2022 # Automation MtC Test Scripts
    //   # 'In-Transit' Zones should be excluded while searching Item with stock
    //   # New option added to create automatically User General Journal for UserID
    // HEI.14 RITM2941384 IBM NASTAA02 25.02.2022 # Automation MtC Test Scripts
    //   # Create data for new Scripts
    // HEI.15 RITM2901715 IBM GAVANM01 01.03.2022 # Automation MtC Test Scripts
    //   # Create data for new Scripts
    // HEI.16 RITM2941384 IBM NASTAA02 03.03.2022 # Automation MtC Test Scripts
    //   # Removed Request Option 'DeleteExistingValues' as it is used as TRUE always
    //   # New function created 'SetupDefaultValues' to setup Request Option before running the report
    // HEI.17 RITM2901715 IBM GAVANM01 04.03.2022 # Automation MtC Test Scripts
    //   # Create data for new Scripts
    // HEI.18 RITM2901715 IBM GAVANM01 07.03.2022 # Automation MtC Test  Scripts
    //   # bug fix
    // HEI.19 RITM2941384 IBM NASTAA02 08.03.2022 # Automation MtC Test Scripts
    //   # Bugfixing
    // HEI.20 RITM2901715 IBM GAVANM01 11.03.2022 # Automation MtC Test  Scripts
    //   # bug fix
    // HEI.21 RITM2901715 IBM SAXENA03 28.03.2022 # Automation MtC Test  Scripts
    //   # Added Setparameter function to set Request Page Input values as TRUE
    //   # Added code to HideDialogs
    // HEI.22 RITM2941384 IBM NASTAA02 01.04.2022 # Automation MtC Test Scripts
    //   # Create data for new Scripts
    // HEI.23 RITM2901715 IBM SAXENA03 08.04.2022 # Automation MtC Test  Scripts
    //   # Added code to setup User Setup
    // HEI.24 RITM2941384 IBM NASTAA02 11.04.2022 # Automation MtC Test Scripts
    //   # Bugfixing
    // HEI.25 RITM2941384 IBM NASTAA02 14.04.2022 # Automation MtC Test Scripts
    //   # Changes made for Boukin
    // HEI.26 RITM2941384 IBM GHOSHS05 14.06.2022 # Automation MtC Test Scripts
    //   # Bugfixing
    // HEI.27 RITM2941384 IBM GHOSHS05 17.06.2022 # Automation MtC Test Scripts
    //   # Added code to add email address in user setup
    // HEI.28 RITM2941384 IBM BHANDS01 12.07.2022 # Automation MtC Test Scripts
    //   # Added code on CreateUnitTestingValues
    // HEI.29 RITM2941384 IBM BHANDS01 29.07.2022 # Automation MtC Test Scripts
    //   # Added code for Algeria
    // HEI.30 RITM2941384 IBM GHOSHS05 03.08.2022 # Automation MtC Test Scripts
    //   # Added code for Suriname
    // HEI.31 RITM2941384 IBM GHOSHS05 04.08.2022 # Automation MtC Test Scripts
    //   # Added code for Rwanda
    // HEI.32 RITM2941384 IBM GHOSHS05 10.08.2022 # Automation MtC Test Scripts
    //   # Added code for SierraLeone
    // HEI.33 RITM2941384 IBM GHOSHS05 11.08.2022 # Automation MtC Test Scripts
    //   # Added code for Shipping Agent Issue
    // HEI.34 RITM2941384 IBM GHOSHS05 17.08.2022 # Automation MtC Test Scripts
    //   # Added code for RT script errors in Congo and Suriname
    // HEI.35 RITM2941384 IBM GHOSHS05 24.08.2022 # Automation MtC Test Scripts
    //   # Added code for RT script errors in Bukavu
    // HEI.36 RITM3323086  IBM SAXENA03 20-03-2023
    //   # Added code to disable Change Log Setup
    // HEI.37 RITM3187964 IBM BHANDS01 13.04.2023 # Automation MtC Test Scripts
    //   # Added code for RT script errors in Mozambique SellCo
    // HEI.38 CHG2185291 IBM SAXENA03 10.05.2023 # Automation MtC Test Scripts
    //   # Added code for Consolidation of Test Script objects
    // HEI.39 CHG2206767 IBM BHANDS01 01.06.2023 # Automation MtC Test Scripts
    //   # Code modified for RT Script Error in Congo Brasco OTC022, OTC018, OTC029
    // HEI.40 CHG2217887 IBM COSTES04 29.08.2023 Fix Blocked Return Reason Code
    //   # Fix Blocked Return Reason Code
    // HEI.41 CHG2243439 IBM PRASAA03 13.03.2024 HeiLite BASE Test Script Adjustment and Optimizations
    //   # G/L account dimension issue resolved.
    // HEI.42 CHG2275168 IBM ADHIKG01 04.12.2024 WEEK 44 - 45 -46 -47 2024 | HeiLite BASE Test Script Adjustment and Optimizations
    //   # Added filters in FindSellToCustomer to skip the wrong customer.
    // HEI.43 CHG2281808 IBM ADHIKG01 12.12.2024 WEEK 50 2024 | HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code modified in FindVendor for haiti errors
    // HEI.44 CHG2282692 IBM ADHIKG01 17.12.2024 WEEK 51 2024 | HeiLite BASE Test Script Adjustment and Optimizations
    //   # Added code in FindShippingAgService to select a shipping agent whose vendor is not blocked
    // HEI.45 CHG2330454 IBM ADHIKG01 11.11.2025 WEEK 46 2025 | HeiLite BASE Test Script Adjustment and Optimizations
    //   # Filter for WHT Bus. Posting Group added to FindVendor function
    // HEI.46 CHG2336097 IBM ADHIKG01 10.02.2026 WEEK 51 2025 | HeiLite BASE Test Script Adjustment and Optimizations
    //   # Modified the customer selection logic in the function FindSelltoCustomer_ForReminders.
    //   # Created new function FindSelltoCustomer_ForBillTo_Reminders

    //BC Upgrade KAPOOV01 >>
    // 1. Commented code related to DRINK-IT Field-"Sundry Customer" of Customer table.
    // 2.Commented DRINK-IT Table-Route
    // 3.Commented code dependent on DRINK-IT Table-Route
    // 4.Commented DRINK-IT Table-"Whse. Shipping Driver"
    // 5.Commented code dependent on DRINK-IT Table-"Free Reason Code"
    // 6.Commented code dependent on DRINK-IT Table-"Document Subtype Code"
    // 7.Commented code dependent on DRINK-IT Table-"Whse. Shipping Truck"
    // 8.Commented code dependent on DRINK-IT Table- "Delivery Type"
    // 9.Commented code dependent on DRINK-IT Table- "Tax Office"
    // 10.Commented code dependent on DRINK-IT Table- "Drink Deposit Group"
    // 11.Commented code dependent on DRINK-IT Table-"Free Reason Code"
    // 12.Commented code dependent on DRINK-IT Table- "Delivery Type"
    // 13.Commented code dependent on DRINK-IT fields defined in Customer Table for-"Credit Limit","Deposit Limit","Sundry Customer","Deposit Limit (LCY)","Invoice Method","Gen. Bus. Posting Free Group"
    // 14.Commented code dependent on DRINK-IT fields defined in Cust. Ledger Entry Table for-"Item Charge Type"
    // 15.Commented code dependent on DRINK-IT fields defined in table Customer for "Invoice Method"
    // 16.Commented code dependent on DRINK-IT fields defined in Lot No. Information Table for-"Expiration Date"
    // 17.Commented code dependent on DRINK-IT fields defined in Item Table for-"Empty Good"
    // 18.Commented-procedure FindRoute dependent on DRINK-IT Table-Route
    // 19.Commented procedure FindRouteDetails taking DRINK-IT Table-Route as Paramter
    // 20.Commented Code as Procedure-FindItemCharge depends on Drink-IT field-Item Charge Type of table -Item Charge 
    // 21.Procedure-FindItemCharge depends on field-Item Charge Type of table -Item Charge
    // 22.Commented procedure FindDriver based on DRINK-IT Table-"Whse. Shipping Driver"
    // 23.Commented procedure FindTruck() based on DRINK-IT Table-"Whse. Shipping Truck" 
    // 24.Commented code related to-DRINK-IT field-"Shipping Charge No." of Table-"Shipping Agent Services" 
    // 25.Commented code related to-DRINK-IT field-"Vendor No." of Table-"Shipping Agent" 
    // 26.Commented Code Block dependent on DRINK-IT field-"Vendor No." of Table-"Shipping Agent"
    // 27.Commented procedure FindFreeReasonCode() dependent on DRINK-IT Table- "Free Reason Code"
    // 28.Commneted procedure FindDepositGroup() dependent on DRINK-IT Table- "Drink Deposit Group"
    // 29.Commented procedure FindDrinkDepositGroup() dependent on DRINK-IT Table "Drink Deposit Group"
    // 30.Commented procedure FindDeliveryType() dependent on DRINK-IT Table "Delivery Type"
    // 31.Commented procedure FindTaxOffice DRINK-IT Table-Tax Office 
    // 32.Commented procedure FindLoyaltyFreeReasonCode() DRINK-IT table-"Free Reason Code"
    // 33.Added ApplicationArea Property of Report.
    // 34.Old Report ID-50466.
    //BC Upgrade KAPOOV01 <<

    // BC UPGRADE PATELS08 >>
    // # Added UsageCategory property at report level.
    // # Code Change in procedure CreateWarehouseEmployeesForUser() to remove Zone code from Warehouse Employee GET function as number of fields in primary key is 2.
    // BC UPGRADE PATELS08 <<

    //BC Upgrade VAMSIU01 >>
    // # Uncommented all Drinkit related Tables and added replaced new Aptean tables
    // # Uncommented Drinkit fields and replaced with new Aptean fields.
    //BC Upgrade VAMSIU01 <<

    Caption = 'Create Unit Testing Values - MtC';
    ProcessingOnly = true;
    ApplicationArea = All; //BC Upgrade KAPOOV01 

    // BC UPGRADE PATELS08 >> # Added UsageCategory property at report level.
    UsageCategory = Tasks;
    // BC UPGRADE PATELS08 <<

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
                    Visible = false;
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
        //HEI.38>>
        // UnitTestingValue.SkipTestScriptExecutionPROD(); // BC UPGRADE PATELS08 >> # Temporarily Blocked to run in PROD env. To be ublocked later.
        //HEI.38<<
    end;

    trigger OnPostReport();
    var
        UnitTestingValue: Record "Unit Testing Value FND";
    begin
        //IF DeleteExistingValues THEN BEGIN //HEI.16
        //MtC Phase 1

        //HEI.24>>
        //Update Allow Posting Date
        //HEI.36>>
        ChangeLogSetup.RESET();
        if ChangeLogSetup.GET() then begin
            ChangeLogSetup."Change Log Activated" := false;
            ChangeLogSetup.MODIFY(true);
        end;
        //HEI.36<<

        GeneralLedgerSetup.GET();
        if (GeneralLedgerSetup."Allow Posting To" < TODAY) then begin
            GeneralLedgerSetup."Allow Posting To" := CALCDATE('<CY>', TODAY);
            GeneralLedgerSetup.MODIFY();
        end;
        //HEI.24<<
        //HEI.26>>
        if GeneralLedgerSetup."Allow Posting From" > CALCDATE('-1M', TODAY) then begin
            GeneralLedgerSetup."Allow Posting From" := CALCDATE('-1M', TODAY);
            GeneralLedgerSetup.MODIFY();
        end;
        //HEI.26<<
        //HEI.23>>
        //Create User Setup for Current User
        if not UserSetup.GET(USERID) then begin
            UserSetup.INIT();
            UserSetup."User ID" := USERID;
            UserSetup.INSERT();
            //HEI.27>>
            UserSetup."E-Mail" := 'notification@heineken.com';
            UserSetup.MODIFY();
        end else
            if UserSetup."E-Mail" = '' then begin
                UserSetup."E-Mail" := 'notification@heineken.com';
                UserSetup.MODIFY();
            end;
        //HEI.27<<
        //HEI.23<<

        UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6',
                                    'LOG001', 'LOG004', 'LOG016', 'LOG017', 'LOG019', 'LOG023');
        if UnitTestingValue.FINDSET() then
            UnitTestingValue.DELETEALL();

        UnitTestingValue.RESET();
        UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6|%7|%8|%9',
                                    'OTC001', 'OTC011', 'OTC017', 'OTC018', 'OTC022', 'OTC023', 'OTC119', 'OTC122', 'OTC130');
        if UnitTestingValue.FINDSET() then
            UnitTestingValue.DELETEALL();

        UnitTestingValue.RESET();
        UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3',
                                    'SLS009', 'SLS018', 'SLS021');
        if UnitTestingValue.FINDSET() then
            UnitTestingValue.DELETEALL();

        //HEI.02>>
        //MtC Phase 1 - Part 2
        UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6|%7|%8',
                                    'LOG041', 'LOG042', 'LOG014', 'LOG015', 'LOG021', 'LOGNEW1', 'LOG035', 'LOG020');
        if UnitTestingValue.FINDSET() then
            UnitTestingValue.DELETEALL();

        UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10',
                                    'OTC053', 'OTC025', 'OTC028', 'OTC029', 'OTC002', 'OTC005', 'OTC006', 'OTC007', 'OTC008', 'OTC014');
        if UnitTestingValue.FINDSET() then
            UnitTestingValue.DELETEALL();
        //HEI.02<<

        //HEI.04>>
        //MtC Phase 1 - Part 3
        UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6|%7|%8',
                                    'OTC152', 'OTC153', 'OTC154', 'OTC159', 'OTC161', 'OTC176', 'LOG025', 'LOG025_2');
        if UnitTestingValue.FINDSET() then
            UnitTestingValue.DELETEALL();

        UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6|%7',
                                    'OTC095', 'OTC096', 'OTC097', 'OTC098', 'OTC104', 'OTC106', 'OTC107');
        if UnitTestingValue.FINDSET() then
            UnitTestingValue.DELETEALL();
        //HEI.04<<

        //HEI.05>>
        UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3',
                                    'OTC1841', 'OTC1842', 'OTC184');
        if UnitTestingValue.FINDSET() then
            UnitTestingValue.DELETEALL();
        //HEI.05<<

        //HEI.06>>
        UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6|%7|%8|%9',
                                    'LOGNEW11', 'OTC179', 'LOG076', 'LOG077', 'LOG078', 'LOG079', 'LOG080', 'LOG081', 'LOG082');
        if UnitTestingValue.FINDSET() then
            UnitTestingValue.DELETEALL();
        //HEI.06<<

        //HEI.08>>
        UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6',
                                    'SLS010', 'SLS011', 'SLS012', 'SLS013', 'SLS014', 'SLS015');
        if UnitTestingValue.FINDSET() then
            UnitTestingValue.DELETEALL();
        //HEI.08<<

        //HEI.09>>
        UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6|%7|%8',
                                    'OTC079', 'OTC080', 'OTC081', 'OTC082', 'OTC083', 'OTC084', 'OTC085', 'OTC089');
        if UnitTestingValue.FINDSET() then
            UnitTestingValue.DELETEALL();

        UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4',
                                    'OTC1XX', 'OTC1XXX', 'OTC059', 'OTC060');
        if UnitTestingValue.FINDSET() then
            UnitTestingValue.DELETEALL();
        //HEI.09<<

        //HEI.10>>
        UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6|%7',
                                    'LOG022_1', 'LOG022_2', 'LOG022_3', 'LOG022_4', 'LOG022_5', 'LOG022_6', 'LOG022_7');
        if UnitTestingValue.FINDSET() then
            UnitTestingValue.DELETEALL();
        //HEI.10<<

        //HEI.11>>
        UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6',
                                    'SLS001', 'SLS002', 'SLS003', 'SLS004', 'SLS005', 'SLS008');
        if UnitTestingValue.FINDSET() then
            UnitTestingValue.DELETEALL();
        //HEI.11<<

        //HEI.12>>
        UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3',
                                    'LOGNEW22', 'OTC212', 'OTC21xxx');
        if UnitTestingValue.FINDSET() then
            UnitTestingValue.DELETEALL();
        //HEI.12<<

        //HEI.14>>
        UnitTestingValue.SETFILTER("Test Script Code", '%1|%2',
                                    'OTCDD', 'OTCDD1');
        if UnitTestingValue.FINDSET() then
            UnitTestingValue.DELETEALL();
        //HEI.14<<
        //HEI.15>>
        UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6|%7',
                                    'SLS_NEW1', 'SLS_NEW2', 'SLS_NEW3', 'OTC2XXX', 'OTC063', 'OTC090', 'OTC091');
        if UnitTestingValue.FINDSET() then
            UnitTestingValue.DELETEALL();
        //HEI.15<<

        //HEI.22>>
        UnitTestingValue.SETFILTER("Test Script Code", '%1',
                                   'LOG_IC_001');
        if UnitTestingValue.FINDSET() then
            UnitTestingValue.DELETEALL();
        //HEI.22<<

        //END; //HEI.16

        CreateUnitTestingValues('LOG001', 'Create Domestic Sales Order');
        CreateUnitTestingValues('LOG004', 'Create Free Product Sales Order');
        CreateUnitTestingValues('LOG016', 'Return RPM Order (Route Planning)');
        CreateUnitTestingValues('LOG017', 'Create Transport Planning');
        CreateUnitTestingValues('LOG019', 'Create Picking');
        CreateUnitTestingValues('LOG023', 'Review Difference Settlement of Customer');
        CreateUnitTestingValues('OTC001', 'Create Customer Invoice Manual Creation Single Order Invoicing');
        CreateUnitTestingValues('OTC011', 'Generate Copy of the Invoice from the System');
        CreateUnitTestingValues('OTC017', 'Create Customer Credit Memo - Quantity Correction, Goods Lost, Goods Damaged, Quality Issues');
        CreateUnitTestingValues('OTC018', 'Create Customer Debit Or Credit Memo - PricingCorrectionOrRecharge IncorrectPrice IncorrectDiscounts');
        CreateUnitTestingValues('OTC022', 'IssueCustomerBonusCreditMemo_3rdPartyBonusCalculation');
        CreateUnitTestingValues('OTC023', 'Check Billing Posting Flows - Corrections Debit Or Credit');
        CreateUnitTestingValues('OTC119', 'Input dispute flag and reason code on the line item level');
        CreateUnitTestingValues('OTC122', 'Input dispute resolution code on the line item level');
        CreateUnitTestingValues('OTC130', 'Apply Payment Against Invoice');
        CreateUnitTestingValues('SLS009', 'Change Customer');
        CreateUnitTestingValues('SLS018', 'Define Deposits');
        CreateUnitTestingValues('SLS021', 'Setup Discounts');

        //HEI.02>>
        CreateUnitTestingValues('LOG041', 'Sales Order Billing');
        CreateUnitTestingValues('LOG042', 'Sales Return Order Billing');
        CreateUnitTestingValues('LOG014', 'Create Return Order (Ad-hoc)');
        CreateUnitTestingValues('LOG015', 'Return RPM Order (Up-front)');
        CreateUnitTestingValues('LOG021', 'Create Unloading at Warehouse');
        CreateUnitTestingValues('LOG035', 'TransferOrderProcess');
        CreateUnitTestingValues('OTC053', 'Create Pro-forma Invoice - manually from the Order');
        CreateUnitTestingValues('OTC025', 'Create Sundry Order and Sundry Invoice');
        CreateUnitTestingValues('OTC028', 'Check if the Line Item Discount can be entered on the Order during the Order creation');
        CreateUnitTestingValues('OTC029', 'Create Sundry Credit Memo and Sundry Credit Note');
        CreateUnitTestingValues('OTC002', 'Create Customer Invoice - manual creation, combined invoice (period, manual selection)');
        CreateUnitTestingValues('OTC005', 'Create Customer Invoice - automated batch job, combined invoice (period)');
        CreateUnitTestingValues('OTC006', 'Create Customer Credit Note - manual-goods return or empties (route settlement)');
        CreateUnitTestingValues('OTC007', 'Create Customer Credit Note - automatic-goods return or empties (route settlement)');
        CreateUnitTestingValues('OTC008', 'Create Customer Invoice with Credit Note lines automatic');
        CreateUnitTestingValues('OTC014', 'Monitor Billing Batch Job');
        //HEI.02<<

        //HEI.03>>
        CreateUnitTestingValues('LOGNEW1', 'Create and Post Shipment');
        CreateUnitTestingValues('LOG020', 'Create Loading');
        //HEI.03<<

        //HEI.04>>
        CreateUnitTestingValues('OTC152', 'Create Cheque Journal in HeiLite Navison for processing');
        CreateUnitTestingValues('OTC153', 'Post Customer Cheques on Customer Account based on the reference data');
        CreateUnitTestingValues('OTC154', 'Check Cheque posting flow');
        CreateUnitTestingValues('OTC159', 'Create Cash Journal-add or adjust or remove Cash Payment lines');
        CreateUnitTestingValues('OTC161', 'Check posting flow for Cash Journal posting process');
        CreateUnitTestingValues('OTC176', 'Check posting flow for the Refund proposal posting');
        CreateUnitTestingValues('OTC095', 'Block Order automatically due to Credit Limit exceeded');
        CreateUnitTestingValues('OTC096', 'Block Order automatically due to overdue');
        CreateUnitTestingValues('OTC097', 'Block Order automatically due to packing credit value exceeded');
        CreateUnitTestingValues('OTC098', 'Create blocked Orders report');
        CreateUnitTestingValues('OTC104', 'Reject blocked Order');
        CreateUnitTestingValues('OTC106', 'Release automatically order due to auto credit control re-check');
        CreateUnitTestingValues('OTC107', 'Access Orders released in the past (archive)');
        CreateUnitTestingValues('LOG025', 'Transport Cost Calculation-Create Shipping Agent');
        CreateUnitTestingValues('LOG025_2', 'Transport Cost Calculation');
        //HEI.04<<

        //HEI.05>>
        CreateUnitTestingValues('OTC1841', 'Update Price via Sales price wrksht');
        CreateUnitTestingValues('OTC1842', 'Update Price via Item List');
        CreateUnitTestingValues('OTC184', 'Adjust upload File Data');
        //HEI.05<<

        //HEI.06>>
        CreateUnitTestingValues('LOGNEW11', 'ActualDeliveryDateForCaseFillRate');
        CreateUnitTestingValues('OTC179', 'Reverse Cheque Postings');
        CreateUnitTestingValues('LOG076', 'Automatic Registry for Inbound Gate Entry');
        CreateUnitTestingValues('LOG077', 'Outbound Process for Sales Order');
        CreateUnitTestingValues('LOG078', 'Outbound Process for Transfer Order');
        CreateUnitTestingValues('LOG079', 'Inbound Process for Transfer Order');
        CreateUnitTestingValues('LOG080', 'Outbound Process for Purchase Return Order');
        CreateUnitTestingValues('LOG081', 'Inbound Process for Purchase Order');
        CreateUnitTestingValues('LOG082', 'Inbound Process for Sales Return Order');
        //HEI.06<<

        //HEI.08>>
        CreateUnitTestingValues('SLS010', 'Incomplete Data Customer');
        CreateUnitTestingValues('SLS011', 'Inactivate a Customer - Temporary');
        CreateUnitTestingValues('SLS012', 'Inactivate a Customer - Permanently');
        CreateUnitTestingValues('SLS013', 'Approval Customer Financial & Sales Data (Customer Equal to Sold To)');
        CreateUnitTestingValues('SLS014', 'Approval Customer Financial & Sales Data (Customer Different from Sold To)');
        CreateUnitTestingValues('SLS015', 'Create And Release Contract Conditions - Individual Sales conditions)');
        //HEI.08<<

        //HEI.09>>
        CreateUnitTestingValues('OTC079', 'Generate reminders list');
        CreateUnitTestingValues('OTC080', 'Exclude reminder from the reminder list');
        CreateUnitTestingValues('OTC081', 'Exclude reminder line in the reminder');
        CreateUnitTestingValues('OTC082', 'Check if the disputed items are marked on the reminder letters as disputed');
        CreateUnitTestingValues('OTC083', 'Send reminder letter to customer via e-mail');
        CreateUnitTestingValues('OTC084', 'Print reminder letter from the proposal');
        CreateUnitTestingValues('OTC085', 'Access reminders already issued in the archive');
        CreateUnitTestingValues('OTC089', 'Generate aging report');
        CreateUnitTestingValues('OTC1XX', 'Create new Discount / Bonus conditions : Temporary or Permanent');
        CreateUnitTestingValues('OTC1XXX', 'Remove Discount');
        CreateUnitTestingValues('OTC059', 'Update Customer Risk Score');
        CreateUnitTestingValues('OTC060', 'Update Customer Credit Limit');
        //HEI.09<<

        //HEI.10>>
        CreateUnitTestingValues('LOG022_1', 'Telesales - Call Update');
        CreateUnitTestingValues('LOG022_2', 'Telesales - Overview');
        CreateUnitTestingValues('LOG022_3', 'Telesales - New Sales Order by Sales Item History');
        CreateUnitTestingValues('LOG022_4', 'Telesales - New Sales Order by Unplanned Order');
        CreateUnitTestingValues('LOG022_5', 'Telesales - Link to Existing Sales Order');
        CreateUnitTestingValues('LOG022_6', 'Telesales - Create New Unplanned Call');
        CreateUnitTestingValues('LOG022_7', 'Telesales - Refresh Telesales Contact');
        //HEI.10<<

        //HEI.11>>
        CreateUnitTestingValues('SLS001', 'Create Customer - Sold To/Payer');
        CreateUnitTestingValues('SLS002', 'Create Customer - Ship To / outlet');
        CreateUnitTestingValues('SLS003', 'Create Customer - Outlet');
        CreateUnitTestingValues('SLS004', 'Create Customer - Employee');
        CreateUnitTestingValues('SLS005', 'Create Customer - Intercompany');
        CreateUnitTestingValues('SLS008', 'Create Duplicate Customer - Sold To');
        //HEI.11<<

        //HEI.12>>
        CreateUnitTestingValues('LOGNEW22', 'CTS');
        CreateUnitTestingValues('OTC212', 'Check posting flow for early payment discount');
        CreateUnitTestingValues('OTC21xxx', 'Remove promotions');
        //HEI.12<<

        //HEI.14>>
        CreateUnitTestingValues('OTCDD', 'Creation of a Direct Debit Payment Slip ');
        CreateUnitTestingValues('OTCDD1', 'Posting of a Direct Debit Payment Slip ');
        //HEI.14<<

        //HEI.15>>
        CreateUnitTestingValues('SLS_NEW1', 'Create Sales Order with Loyalty');
        CreateUnitTestingValues('SLS_NEW2', 'Loyalty Journal');
        CreateUnitTestingValues('SLS_NEW3', 'Recurring Loyalty Journal');
        CreateUnitTestingValues('OTC2XXX', 'Create/Adjust promotions');
        CreateUnitTestingValues('OTC063', 'Check date of the last credit risk assessment for customer');
        CreateUnitTestingValues('OTC090', 'Create Cash collection order and check that it does not create fiscal document on customer account');
        CreateUnitTestingValues('OTC091', 'Print cash collection order');
        //HEI.15<<

        //HEI.22>>
        CreateUnitTestingValues('LOG_IC_001', 'Inter Company Sales');
        //HEI.22<<

        //HEI.07>>
        //^^ Add code for Unit Testing Values above ^^
        if CreateWarehouseEmployees then
            CreateWarehouseEmployeesForUser(USERID, '', '');
        //HEI.07<<

        //HEI.13>>
        //For each Journal Type (0 = General, 1 = Item) and Gen. Journal Type (0 = General, 1 = Sales, 2 = Purchases, 3 = Cash Receipts,
        //4 = Payments, 5 = Assets, 6 = Intercompany, 7 = Jobs) call function CreateUserGeneralJournalForUser
        if CreateGenJournalUsers then begin
            CreateUserGeneralJournalForUser(USERID, 0, 3);
            CreateUserGeneralJournalForUser(USERID, 0, 5);
        end;
        //HEI.13<<

        //HEI.21>>
        if not HideDialogs then
            //HEI.21<<
            MESSAGE(UnitTestValuesCreatedMsg);
    end;

    var
        UnitTestValuesCreatedMsg: Label 'Unit Testing Values created.';
        DeleteExistingValues: Boolean;
        FirstItemNo: Code[20];
        LocationFrom: Code[10];
        LocationTo: Code[10];
        FirstCustomerNo: Code[20];
        CreateWarehouseEmployees: Boolean;
        CreateGenJournalUsers: Boolean;
        HideDialogs: Boolean;
        GeneralLedgerSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        ChangeLogSetup: Record "Change Log Setup";
        UnitTestingValue: Record "Unit Testing Value FND";

    procedure CreateUnitTestingValues(TestCode: Code[20]; TestDescription: Text[100]);
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        UnitTestingValue: Record "Unit Testing Value FND";
        UnitTestingValue2: Record "Unit Testing Value FND";
        UnitTestingValue3: Record "Unit Testing Value FND";
        //Route: Record Route; //BC Upgrade KAPOOV01 Commented DRINK-IT Table-Route
        Route: Record Route107FDW;//BC UPGRADE VAMSIU01 Added Route replacement table from Aptean.
        ShippingAgentServices: Record "Shipping Agent Services";
        Customer: Record Customer;
        PostCode: Record "Post Code";
        LocationCode: Code[10];
        RouteCode: Code[20];
        LotNo: Code[20];
        DisputeCategoryCode: Code[20];
        JournalTemplateName: Code[10];
        ItemNo: Code[20];
        ZoneCode: Code[10];
        BinCode: Code[20];
        CustomerNo: Code[20];
        ShippAgentCode: Code[20];
        InventoryPostingSetup: Record "Inventory Posting Setup";
        InventoryPostingSetup2: Record "Inventory Posting Setup";
        Item: Record Item;
        BillToCustomer: Record Customer;
        ResourceNo: Code[20];
        ItemChargeNo: Code[20];
        Vendor: Record Vendor;
        AccountGroupCode: Code[20];
        CustomerSubType: Code[20];
        RiskScoreCode: Code[10];
        ShippingAgent: Record "Shipping Agent";
    begin
        GeneralLedgerSetup.GET();
        //HEI.04>>
        FirstCustomerNo := '';
        FirstItemNo := '';
        LocationFrom := '';
        LocationTo := '';
        //HEI.04<<

        case TestCode of
            'LOG001',
            'OTC017',
            'OTC023',
            'LOG004',
            'LOG019',
            'LOG016',
            'OTC001',
            'OTC011',
            //HEI.03>>
            'LOGNEW1',
            'LOG020',
            //HEI.03<<
            //HEI.05>>
            'OTC1841',
            'OTC1842',
            'OTC184',
            //HEI.05<<
            //HEI.06>>
            'LOGNEW11',
            //HEI.06<<
            //HEI.09>>
            'OTC079',
            'OTC080',
            'OTC081',
            'OTC082',
            'OTC083',
            'OTC084',
            'OTC085',
            'OTC089',
            //HEI.09<<
            //HEI.10>>
            'LOG022_1',
            'LOG022_2',
            'LOG022_3',
            'LOG022_4',
            'LOG022_5',
            'LOG022_6',
            'LOG022_7',
            //HEI.10<<
            //HEI.14>>
            'OTCDD',
            'OTCDD1',
            //HEI.14<<
            //HEI.02>>
            'OTC053',
            'OTC025',
            'OTC028',
            'OTC002',
            'OTC005',
            'OTC006',
            'OTC007',
            'OTC008',
            'LOG014',
            'LOG015',
            'LOG021':
                //HEI.02<<
                begin
                    //Customer
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Customer, UnitTestingValue);
                    if TestCode = 'LOG004' then
                        UnitTestingValue.VALIDATE(Value, FindFreeCustomer())
                    else
                        //HEI.24>>
                        if TestCode in ['OTC079', 'OTC080', 'OTC081', 'OTC082', 'OTC083', 'OTC084', 'OTC085'] then begin //HEI.28>>
                            UnitTestingValue.VALIDATE(Value, FindSelltoCustomer_ForReminders());
                            //HEI.28>>
                            if UnitTestingValue.Value = '' then
                                UnitTestingValue.VALIDATE(Value, FindCustomer());
                        end else //HEI.28<<
                                 //HEI.24<<
                            UnitTestingValue.VALIDATE(Value, FindCustomer());
                    UnitTestingValue.MODIFY(true);
                    CustomerNo := UnitTestingValue.Value;

                    //HEI.14>>
                    //Bank Account
                    if (TestCode = 'OTCDD') or (TestCode = 'OTCDD1') then begin
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Bank Account", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindBankAccount());
                        UnitTestingValue.MODIFY(true);
                    end;
                    //HEI.14<<

                    //Item
                    //InitUnitTestingValues(TestCode,TestDescription,DATABASE::Item,UnitTestingValue); //HEI.10
                    if (TestCode = 'LOG001') or (TestCode = 'LOG004') or (TestCode = 'LOG019') or (TestCode = 'LOG016') or
                       (TestCode = 'OTC001') or (TestCode = 'OTC011') or
                       //HEI.02<<
                       (TestCode = 'LOG014') or (TestCode = 'LOG021') or (TestCode = 'OTC053') or (TestCode = 'OTC025') or
                       (TestCode = 'OTC028') or (TestCode = 'OTC002') or (TestCode = 'OTC005') or (TestCode = 'OTC006') or
                       (TestCode = 'OTC007') or (TestCode = 'OTC008') or
                       //HEI.05>>
                       (TestCode = 'OTC1841') or (TestCode = 'OTC1842') or (TestCode = 'OTC184') or
                       //HEI.05<<
                       //HEI.06>>
                       (TestCode = 'LOGNEW11') or
                       //HEI.06<<
                       //HEI.09>>
                       (TestCode = 'OTC079') or (TestCode = 'OTC080') or (TestCode = 'OTC081') or (TestCode = 'OTC082') or
                       (TestCode = 'OTC083') or (TestCode = 'OTC084') or (TestCode = 'OTC085') or
                       //HEI.09<<
                       //HEI.10>>
                       (TestCode = 'LOG022_1') or (TestCode = 'LOG022_3') or (TestCode = 'LOG022_4') or (TestCode = 'LOG022_5') or
                       //HEI.10<<
                       //HEI.14>>
                       (TestCode = 'OTCDD') or (TestCode = 'OTCDD1') or
                       //HEI.14<<
                       //HEI.02<<
                       (TestCode = 'LOGNEW1') or (TestCode = 'LOG020') //HEI.03
                    then begin //HEI.10
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue); //HEI.10
                        UnitTestingValue.VALIDATE(Value, FindItemWithLotAndInventory('01', LocationCode, LotNo, ZoneCode, BinCode, 'LOTALLEXP'));
                    end else //HEI.10
                        if (TestCode = 'OTC017') or (TestCode = 'OTC023') or (TestCode = 'LOG015') //HEI.02
                        then begin //HEI.10
                            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue); //HEI.10
                            UnitTestingValue.VALIDATE(Value, FindRPMItem('05', LocationCode, ZoneCode, BinCode));
                        end;
                    ItemNo := UnitTestingValue.Value; //HEI.02
                    UnitTestingValue.MODIFY(true);

                    //Location
                    //HEI.10>>
                    if (TestCode <> 'LOG022_2') and (TestCode <> 'LOG022_3') and (TestCode <> 'LOG022_4') and (TestCode <> 'LOG022_6') and
                       (TestCode <> 'LOG022_7') and
                       //HEI.10<<
                       (TestCode <> 'OTC089')
                    then begin //HEI.09
                        if LocationCode = '' then
                            LocationCode := FindLocation(false);

                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, LocationCode);
                        UnitTestingValue.MODIFY(true);
                    end; //HEI.09

                    //Zone
                    if (TestCode = 'OTC017') or (TestCode = 'OTC023') or
                       //HEI.06>>
                       (TestCode = 'LOGNEW11') or
                       //HEI.06<<
                       //HEI.02<<
                       (TestCode = 'LOG014') or (TestCode = 'LOG015') or (TestCode = 'LOG021') or (TestCode = 'LOGNEW1') or
                       (TestCode = 'LOG020') or (TestCode = 'OTC025') or (TestCode = 'OTC002') or (TestCode = 'OTC005') or
                       (TestCode = 'OTC006') or (TestCode = 'OTC007')
                    //HEI.02<<
                    then begin
                        if ZoneCode = '' then
                            ZoneCode := FindZone(LocationCode);

                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Zone, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, ZoneCode);
                        UnitTestingValue.MODIFY(true);
                    end;

                    //Bin
                    //HEI.10>>
                    if (TestCode <> 'LOG022_2') and (TestCode <> 'LOG022_3') and (TestCode <> 'LOG022_4') and (TestCode <> 'LOG022_5') and
                       (TestCode <> 'LOG022_6') and (TestCode <> 'LOG022_7') and
                       //HEI.10<<
                       (TestCode <> 'OTC089')
                    then begin //HEI.09
                        if BinCode = '' then
                            BinCode := FindBin(LocationCode, ItemNo, ZoneCode);
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Bin, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, BinCode);
                        UnitTestingValue.MODIFY(true);
                    end; //HEI.09

                    if (TestCode = 'OTC017') or (TestCode = 'LOG014') or (TestCode = 'LOG015') or
                       //HEI.02>>
                       (TestCode = 'LOG021') or (TestCode = 'OTC006') or (TestCode = 'OTC007')
                    //HEI.02<<
                    then begin
                        //Return Reason Code
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Return Reason", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindReturnReason());
                        UnitTestingValue.MODIFY(true);
                    end;

                    //Route
                    if (TestCode = 'LOG001') or (TestCode = 'OTC017') or (TestCode = 'LOG004') or (TestCode = 'LOG019') or
                       (TestCode = 'LOG016') or (TestCode = 'OTC001') or (TestCode = 'OTC011') or
                       //HEI.02>>
                       (TestCode = 'LOG014') or (TestCode = 'LOG015') or (TestCode = 'LOG021') or (TestCode = 'OTC053') or
                       (TestCode = 'OTC025') or (TestCode = 'OTC028') or (TestCode = 'OTC002') or (TestCode = 'OTC005') or
                       (TestCode = 'OTC006') or (TestCode = 'OTC007') or (TestCode = 'OTC008') or
                       //HEI.02<<
                       //HEI.06>>
                       (TestCode = 'LOGNEW11') or
                       //HEI.06<<
                       //HEI.09>>
                       (TestCode = 'OTC079') or (TestCode = 'OTC080') or (TestCode = 'OTC081') or (TestCode = 'OTC082') or
                       (TestCode = 'OTC083') or (TestCode = 'OTC084') or (TestCode = 'OTC085') or
                       //HEI.09<<
                       //HEI.10>>
                       (TestCode = 'LOG022_1') or (TestCode = 'LOG022_5') or
                       //HEI.10<<
                       //HEI.14>>
                       (TestCode = 'OTCDD') or (TestCode = 'OTCDD1') or
                       //HEI.14<<
                       (TestCode = 'LOGNEW1') or (TestCode = 'LOG020') //HEI.03
                    then begin
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-Route >>
                        //BC UPGRADE VAMSIU01 Added Route replacement table from Aptean >>
                        //InitUnitTestingValues(TestCode, TestDescription, DATABASE::Route, UnitTestingValue);
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Route107FDW, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindRoute(LocationCode));
                        UnitTestingValue.MODIFY(true);
                        //BC UPGRADE VAMSIU01 Added Route replacement table from Aptean <<
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-Route <<
                    end;

                    if (TestCode = 'LOG019') or (TestCode = 'OTC001') or (TestCode = 'OTC011') or (TestCode = 'OTC017') or
                       //HEI.06>>
                       (TestCode = 'LOGNEW11') or
                       //HEI.06<<
                       //HEI.09>>
                       (TestCode = 'OTC079') or (TestCode = 'OTC080') or (TestCode = 'OTC081') or (TestCode = 'OTC082') or
                       (TestCode = 'OTC083') or (TestCode = 'OTC084') or (TestCode = 'OTC085') or
                       //HEI.09<<
                       //HEI.10>>
                       (TestCode = 'LOG022_1') or
                       //HEI.10<<
                       //HEI.14>>
                       (TestCode = 'OTCDD') or (TestCode = 'OTCDD1') or
                       //HEI.14<<
                       //HEI.02>>
                       (TestCode = 'LOG021') or (TestCode = 'OTC025') or (TestCode = 'LOGNEW1') or (TestCode = 'LOG020') or
                       (TestCode = 'OTC002') or (TestCode = 'OTC005') or (TestCode = 'OTC006') or (TestCode = 'OTC007') or
                       (TestCode = 'OTC008')
                    //HEI.02<<
                    then begin
                        //Shipping Agent Service
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipping Agent Services", UnitTestingValue);
                        //BC Upgrade KAPOOV01 Commented Code block based on DRINK-IT Table-Route >>
                        //BC UPGRADE VAMSIU01 Added Route replacement table from Aptean. >>
                        if Route."Shipping Agent Service Code" <> '' then begin
                            ShippingAgentServices.SETRANGE(Code, Route."Shipping Agent Service Code");
                            ShippingAgentServices.SETRANGE("Shipping Agent Code", '<>%1', '');
                            if ShippingAgentServices.FINDFIRST() then begin
                                UnitTestingValue.VALIDATE(Value, Route."Shipping Agent Service Code");
                                ShippAgentCode := ShippingAgentServices."Shipping Agent Code";
                            end;
                        end else
                        //BC UPGRADE VAMSIU01 Added Route replacement table from Aptean. <<
                        //BC Upgrade KAPOOV01 Commented Code block based on DRINK-IT Table-Route <<
                        begin
                            ShippingAgentServices.SETRANGE(Code, FindShippingAgService(ShippAgentCode));
                            if ShippingAgentServices.FINDFIRST() then
                                UnitTestingValue.VALIDATE(Value, ShippingAgentServices.Code);
                        end;

                        UnitTestingValue.MODIFY(true);

                        //Shipping Agent
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipping Agent", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, ShippingAgentServices."Shipping Agent Code");
                        UnitTestingValue.MODIFY(true);

                        //Driver
                        // InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Whse. Shipping Driver", UnitTestingValue); //BC Upgrade KAPOOV01 Commented DRINK-IT Table-"Whse. Shipping Driver"
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Driver107FDW, UnitTestingValue);
                        //BC Upgrade KAPOOV01 Commented Code block based on DRINK-IT Table-Route >>
                        // if Route."Driver Code" <> '' then
                        //     UnitTestingValue.VALIDATE(Value, Route."Driver Code")
                        // else
                        //     UnitTestingValue.VALIDATE(Value, FindDriver());
                        // UnitTestingValue.MODIFY(true);
                        //BC Upgrade KAPOOV01 Commented Code block based on DRINK-IT Table-Route <<
                        //BC Upgrade VAMSIU01 Added Route replacement table from Aptean >> 
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Driver107FDW, UnitTestingValue);
                        if Route.Driver <> '' then
                            UnitTestingValue.VALIDATE(Value, Route.Driver)
                        else
                            UnitTestingValue.VALIDATE(Value, FindDriver());
                        UnitTestingValue.MODIFY(true);
                        //BC Upgrade VAMSIU01 Added Route replacement table from Aptean <<

                        //Truck
                        //InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Whse. Shipping Truck", UnitTestingValue); //BC Upgrade KAPOOV01 Commented DRINK-IT Table-"Whse. Shipping Driver"
                        //BC Upgrade KAPOOV01 Commented Code block based on DRINK-IT Table-Route >>
                        // if Route."Truck Code" <> '' then
                        //     UnitTestingValue.VALIDATE(Value, Route."Truck Code")
                        // else
                        //     UnitTestingValue.VALIDATE(Value, FindTruck());
                        // UnitTestingValue.MODIFY(true);
                        //BC Upgrade KAPOOV01 Commented Code block based on DRINK-IT Table-Route <<

                        //BC Upgrade VAMSIU01 Added Route replacement table from Aptean >>
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vehicle101FDW, UnitTestingValue);
                        if Route.Vehicle <> '' then
                            UnitTestingValue.VALIDATE(Value, Route.Vehicle)
                        else
                            UnitTestingValue.VALIDATE(Value, FindTruck());
                        UnitTestingValue.MODIFY(true);
                        //BC Upgrade VAMSIU01 Added Route replacement table from Aptean <<

                    end;

                    //Free Reason Code
                    if TestCode = 'LOG004' then begin
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Free Reason Code" >>
                        //BC Upgrade VAMSIU01 Added Base Reason Code table >>
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Reason Code", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindFreeReasonCode());
                        UnitTestingValue.MODIFY(true);
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Free Reason Code" <<
                    end;

                    //HEI.02>>
                    //Lot No. Information
                    if (TestCode = 'LOG021') or (TestCode = 'OTC006') or (TestCode = 'OTC007')
                    then begin
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Lot No. Information", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindLotNoInformation(ItemNo));
                        UnitTestingValue.MODIFY(true);
                    end;

                    //Document Subtype Code
                    //HEI.09>>
                    if (TestCode = 'OTC079') or (TestCode = 'OTC080') or (TestCode = 'OTC081') or (TestCode = 'OTC082') or
                       (TestCode = 'OTC083') or (TestCode = 'OTC084') or (TestCode = 'OTC085') or
                       //HEI.09<<
                       //HEI.10>>
                       (TestCode = 'LOG022_1') or (TestCode = 'LOG022_5') or
                      //HEI.10<<
                      (TestCode = 'OTC008')
                    then begin
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Document Subtype Code" >>
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Document Subtype Code FND", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, 'SALES_DEF');
                        UnitTestingValue.MODIFY(true);
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Document Subtype Code" <<
                    end;
                    //HEI.02<<

                    //HEI.09>>
                    //Payment Terms
                    if (TestCode = 'OTC079') or (TestCode = 'OTC080') or (TestCode = 'OTC081') or (TestCode = 'OTC082') or
                       (TestCode = 'OTC083') or (TestCode = 'OTC084') or (TestCode = 'OTC085')
                    then begin
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Payment Terms", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindPaymentTerms());
                        UnitTestingValue.MODIFY(true);
                    end;

                    if TestCode = 'OTC082' then begin
                        //Dispute Category
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dispute Category FND", UnitTestingValue);
                        DisputeCategoryCode := FindDisputeCategory();
                        UnitTestingValue.VALIDATE(Value, DisputeCategoryCode);
                        UnitTestingValue.MODIFY(true);

                        //Dispute Reason
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dispute Reason FND", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindDisputeReason(FindDisputeCategory()));
                        UnitTestingValue.MODIFY(true);
                    end;
                    //HEI.09<<
                end;

            'OTC018',
            //HEI.02>>
            'OTC029',
            //HEI.02<<
            'OTC022':
                begin
                    //Customer
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Customer, UnitTestingValue);
                    //HEI.30>>
                    if COMPANYNAME in ['10_SURIN_BROUWERIJ', 'Brasco'] then //HEI.34>>
                        UnitTestingValue.VALIDATE(Value, FindSellToCustomerShipment())
                    else
                        UnitTestingValue.VALIDATE(Value, FindCustomer());
                    //HEI.30<<
                    UnitTestingValue.MODIFY(true);
                    CustomerNo := UnitTestingValue.Value;

                    //Location
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                    LocationCode := FindLocation(false);
                    UnitTestingValue.VALIDATE(Value, LocationCode);
                    UnitTestingValue.MODIFY(true);

                    //Document Subtype
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Document Subtype Code" >>
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Document Subtype Code FND", UnitTestingValue);
                    if TestCode = 'OTC018' then
                        UnitTestingValue.VALIDATE(Value, 'PC1')
                    else
                        if TestCode = 'OTC022' then
                            UnitTestingValue.VALIDATE(Value, 'BC1')
                        //HEI.02>>
                        else
                            if TestCode = 'OTC029' then
                                UnitTestingValue.VALIDATE(Value, 'SO2');
                    //HEI.02<<
                    UnitTestingValue.MODIFY(true);
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Document Subtype Code" <<

                    //HEI.02>>
                    if TestCode = 'OTC029' then begin
                        //Resource
                        if Customer.GET(CustomerNo) then;//HEI.26
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Resource, UnitTestingValue);
                        if BillToCustomer.GET(Customer."Bill-to Customer No.") then
                            ResourceNo := FindResource(BillToCustomer."Gen. Bus. Posting Group", BillToCustomer."VAT Bus. Posting Group")
                        else
                            ResourceNo := FindResource(Customer."Gen. Bus. Posting Group", Customer."VAT Bus. Posting Group");
                        UnitTestingValue.VALIDATE(Value, ResourceNo);
                        UnitTestingValue.MODIFY(true);

                        //Dimension
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
                        if BillToCustomer."Gen. Bus. Posting Group" <> '' then
                            UnitTestingValue.VALIDATE(Value, FindCCCDimensionValue(BillToCustomer."Gen. Bus. Posting Group", ResourceNo))
                        else
                            UnitTestingValue.VALIDATE(Value, FindCCCDimensionValue(Customer."Gen. Bus. Posting Group", ResourceNo));
                        UnitTestingValue.VALIDATE("Value 2", FindDimensionValue(GeneralLedgerSetup."Brand Dimension Code FND"));
                        UnitTestingValue.VALIDATE("Value 3", FindDimensionValue(GeneralLedgerSetup."SKU Dimension Code FND"));
                        UnitTestingValue.MODIFY(true);
                    end else begin
                        //HEI.02<<
                        //Item Charge
                        //Commented below Code as Procedure-FindItemCharge depends on Drink-IT field-Item Charge Type of table -Item Charge >>
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Item Charge", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindItemCharge(0));
                        UnitTestingValue.MODIFY(true);
                        //Commented below Code as Procedure-FindItemCharge depends on Drink-IT field-Item Charge Type of table -Item Charge <<

                        //Dimension Values:
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindDimensionValue(GeneralLedgerSetup."Shortcut Dimension 7 Code")); //TRD_Part
                        UnitTestingValue.VALIDATE("Value 2", FindDimensionValue(GeneralLedgerSetup."SKU Dimension Code FND")); //SKU
                        UnitTestingValue.VALIDATE("Value 3", FindDimensionValue(GeneralLedgerSetup."Cost Center Dimension Code FND")); //CCC
                        UnitTestingValue.MODIFY(true);
                    end; //HEI.02
                end;

            'LOG017':
                begin
                    //Route
                    RouteCode := FindRoute(FindLocation(false)); //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-Route, Procedure-FindRoute dependent on Route table

                    //Route.GET(RouteCode);         //HEI.20
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-Route >>
                    //BC Upgrade VAMSIU01 Added Route replacement table from Aptean >>
                    if Route.GET(RouteCode) then;   //HEI.20
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Route107FDW, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, RouteCode);
                    UnitTestingValue.MODIFY(true);
                    //BC Upgrade VAMSIU01 Added Route replacement table from Aptean <<
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-Route <<
                    //Shipping Agent Service
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipping Agent Services", UnitTestingValue);
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-Route >>
                    if Route."Shipping Agent Service Code" <> '' then begin
                        ShippingAgentServices.SETRANGE(Code, Route."Shipping Agent Service Code");
                        ShippingAgentServices.SETFILTER("Shipping Agent Code", '<>%1', '');
                        if ShippingAgentServices.FINDFIRST() then begin
                            UnitTestingValue.VALIDATE(Value, Route."Shipping Agent Service Code");
                            ShippAgentCode := ShippingAgentServices."Shipping Agent Code";
                        end;
                    end else
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-Route <<
                    begin
                        ShippingAgentServices.SETRANGE(Code, FindShippingAgService(ShippAgentCode));
                        if ShippingAgentServices.FINDFIRST() then
                            UnitTestingValue.VALIDATE(Value, ShippingAgentServices.Code);
                    end;
                    UnitTestingValue.MODIFY(true);


                    //Shipping Agent
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipping Agent", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, ShippAgentCode);
                    UnitTestingValue.MODIFY(true);

                    //Driver
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-Whse. Shipping Driver,Route >>
                    //BC Upgrade VAMSIU01 Added Driver table, Route.driver >>
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Driver107FDW, UnitTestingValue);
                    if Route.Driver <> '' then
                        UnitTestingValue.VALIDATE(Value, Route.Driver)
                    else
                        UnitTestingValue.VALIDATE(Value, FindDriver());
                    UnitTestingValue.MODIFY(true);
                    //BC Upgrade VAMSIU01 Added Driver table, Route.driver <<
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-Whse. Shipping Driver,Route <<

                    //Truck
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Whse. Shipping Truck",Route >>
                    //BC Upgrade VAMSIU01 Added Vehicle table, Route.Vehicle >>
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vehicle101FDW, UnitTestingValue);
                    if Route.Vehicle <> '' then
                        UnitTestingValue.VALIDATE(Value, Route.Vehicle)
                    else
                        UnitTestingValue.VALIDATE(Value, FindTruck());
                    UnitTestingValue.MODIFY(true);
                    //BC Upgrade VAMSIU01 Added Vehicle table, Route.Vehicle <<
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Whse. Shipping Truck",Route <<
                end;

            'OTC119',
            'OTC122',
            'LOG023':
                begin
                    //Customer
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Customer, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindCustomer());
                    UnitTestingValue.MODIFY(true);
                    CustomerNo := UnitTestingValue.Value;

                    //Item
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
                    ItemNo := FindItemWithLotAndInventory('01', LocationCode, LotNo, ZoneCode, BinCode, 'LOTALLEXP');
                    UnitTestingValue.VALIDATE(Value, ItemNo);
                    UnitTestingValue.MODIFY(true);

                    //Location
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                    if LocationCode = '' then
                        LocationCode := FindLocation(false);
                    UnitTestingValue.VALIDATE(Value, LocationCode);
                    UnitTestingValue.MODIFY(true);

                    //Route
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- Route >>
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Route107FDW, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindRoute(LocationCode));
                    UnitTestingValue.MODIFY(true);
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- Route <<

                    //Lot No.
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Lot No. Information", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, LotNo);
                    UnitTestingValue.MODIFY(true);

                    if TestCode <> 'LOG023' then begin
                        //Dispute Category
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dispute Category FND", UnitTestingValue);
                        DisputeCategoryCode := FindDisputeCategory();
                        UnitTestingValue.VALIDATE(Value, DisputeCategoryCode);
                        UnitTestingValue.MODIFY(true);

                        //Dispute Reason
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dispute Reason FND", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindDisputeReason(FindDisputeCategory()));
                        UnitTestingValue.MODIFY(true);

                        //Dispute Resolution
                        if TestCode = 'OTC122' then begin
                            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dispute Resolution FND", UnitTestingValue);
                            UnitTestingValue.VALIDATE(Value, FindDisputeResolution());
                            UnitTestingValue.MODIFY(true);
                        end;
                    end;

                    //Return Reason
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Return Reason", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindReturnReason());
                    UnitTestingValue.MODIFY(true);

                    if TestCode = 'LOG023' then begin
                        //Zone
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Zone, UnitTestingValue);
                        if ZoneCode = '' then
                            ZoneCode := FindZone(LocationCode);
                        UnitTestingValue.VALIDATE(Value, ZoneCode);
                        UnitTestingValue.MODIFY(true);

                        //Bin
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Bin, UnitTestingValue);
                        if BinCode = '' then
                            BinCode := FindBin(LocationCode, ItemNo, ZoneCode);
                        UnitTestingValue.VALIDATE(Value, BinCode);
                        UnitTestingValue.MODIFY(true);
                    end;

                    if (TestCode = 'OTC119') or (TestCode = 'OTC122') then begin
                        //Bin
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Bin, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, BinCode);
                        UnitTestingValue.MODIFY(true);
                    end;

                    //Shipping Agent Service
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipping Agent Services", UnitTestingValue);
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- Route >>
                    if Route."Shipping Agent Service Code" <> '' then begin
                        ShippingAgentServices.SETRANGE(Code, Route."Shipping Agent Service Code");
                        ShippingAgentServices.SETRANGE("Shipping Agent Code", '<>%1', '');
                        if ShippingAgentServices.FINDFIRST() then begin
                            UnitTestingValue.VALIDATE(Value, Route."Shipping Agent Service Code");
                            ShippAgentCode := ShippingAgentServices."Shipping Agent Code";
                        end;
                    end else
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- Route <<
                    begin
                        ShippingAgentServices.SETRANGE(Code, FindShippingAgService(ShippAgentCode));
                        if ShippingAgentServices.FINDFIRST() then
                            UnitTestingValue.VALIDATE(Value, ShippingAgentServices.Code);
                    end;
                    UnitTestingValue.MODIFY(true);

                    //Shipping Agent
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipping Agent", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, ShippingAgentServices."Shipping Agent Code");
                    UnitTestingValue.MODIFY(true);

                    //Driver
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Whse. Shipping Driver",Route >>
                    //BC Upgrade VAMSIU01 Added Driver table, Route.driver >>
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Driver107FDW, UnitTestingValue);
                    if Route.Driver <> '' then
                        UnitTestingValue.VALIDATE(Value, Route.Driver)
                    else
                        UnitTestingValue.VALIDATE(Value, FindDriver());
                    UnitTestingValue.MODIFY(true);
                    //BC Upgrade VAMSIU01 Added Driver table, Route.driver <<
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Whse. Shipping Driver",Route <<

                    //Truck
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Whse. Shipping Truck",Route >>
                    //BC Upgrade VAMSIU01 Added Vehicle table, Route.Vehicle >>
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vehicle101FDW, UnitTestingValue);
                    if Route.Vehicle <> '' then
                        UnitTestingValue.VALIDATE(Value, Route.Vehicle)
                    else
                        UnitTestingValue.VALIDATE(Value, FindTruck());
                    UnitTestingValue.MODIFY(true);
                    //BC Upgrade VAMSIU01 Added Vehicle table, Route.Vehicle >>
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Whse. Shipping Truck",Route <<
                end;

            'OTC130':
                begin
                    //Customers
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Customer, UnitTestingValue);
                    if Customer.GET(FindCustomer()) then;
                    UnitTestingValue.VALIDATE(Value, Customer."No.");
                    if Customer."Bill-to Customer No." <> '' then
                        UnitTestingValue.VALIDATE("Value 2", Customer."Bill-to Customer No.")
                    else
                        UnitTestingValue.VALIDATE("Value 2", Customer."No.");
                    UnitTestingValue.MODIFY(true);
                    CustomerNo := UnitTestingValue.Value;

                    //Item
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindItemWithLotAndInventory('01', LocationCode, LotNo, ZoneCode, BinCode, 'LOTALLEXP'));
                    UnitTestingValue.MODIFY(true);

                    //Location
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                    if LocationCode = '' then
                        LocationCode := FindLocation(false);
                    UnitTestingValue.VALIDATE(Value, LocationCode);
                    UnitTestingValue.MODIFY(true);

                    //Bin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Bin, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, BinCode);
                    UnitTestingValue.MODIFY(true);

                    //Route
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-Route >>
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Route107FDW, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindRoute(LocationCode));
                    UnitTestingValue.MODIFY(true);
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-Route <<

                    //Shipping Agent Service
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipping Agent Services", UnitTestingValue);
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-Route >>
                    if Route."Shipping Agent Service Code" <> '' then begin
                        ShippingAgentServices.SETRANGE(Code, Route."Shipping Agent Service Code");
                        ShippingAgentServices.SETRANGE("Shipping Agent Code", '<>%1', '');
                        if ShippingAgentServices.FINDFIRST() then begin
                            UnitTestingValue.VALIDATE(Value, Route."Shipping Agent Service Code");
                            ShippAgentCode := ShippingAgentServices."Shipping Agent Code";
                        end;
                    end else
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-Route <<
                    begin
                        ShippingAgentServices.SETRANGE(Code, FindShippingAgService(ShippAgentCode));
                        if ShippingAgentServices.FINDFIRST() then
                            UnitTestingValue.VALIDATE(Value, ShippingAgentServices.Code);
                    end;
                    UnitTestingValue.MODIFY(true);

                    //Shipping Agent
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipping Agent", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, ShippingAgentServices."Shipping Agent Code");
                    UnitTestingValue.MODIFY(true);

                    //Driver
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Whse. Shipping Driver",Route >>
                    //BC Upgrade VAMSIU01 Added Driver table, Route.driver >>
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Driver107FDW, UnitTestingValue);
                    if Route.Driver <> '' then
                        UnitTestingValue.VALIDATE(Value, Route.Driver)
                    else
                        UnitTestingValue.VALIDATE(Value, FindDriver());
                    UnitTestingValue.MODIFY(true);
                    //BC Upgrade VAMSIU01 Added Driver table, Route.driver <<
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Whse. Shipping Driver",Route <<

                    //Truck
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Whse. Shipping Truck",Route >>
                    //BC Upgrade VAMSIU01 Added Vehicle table, Route.Vehicle >>
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vehicle101FDW, UnitTestingValue);
                    if Route.Vehicle <> '' then
                        UnitTestingValue.VALIDATE(Value, Route.Vehicle)
                    else
                        UnitTestingValue.VALIDATE(Value, FindTruck());
                    UnitTestingValue.MODIFY(true);
                    //BC Upgrade VAMSIU01 Added Vehicle table, Route.Vehicle >>
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Whse. Shipping Truck",Route <<

                    //GL Account
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindGLAccount());
                    UnitTestingValue.MODIFY(true);

                    //Payment Method
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Payment Method", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindPaymentMethod());
                    UnitTestingValue.MODIFY(true);

                    //Cash Receipt Journal
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Journal Template", UnitTestingValue);
                    JournalTemplateName := FindCashRcptJournal();
                    UnitTestingValue.VALIDATE(Value, JournalTemplateName);
                    UnitTestingValue.MODIFY(true);

                    //Journal Batch
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Journal Batch", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindCashRcptBatch(JournalTemplateName));
                    UnitTestingValue.MODIFY(true);
                end;

            //HEI.09>>
            'OTC059',
            'OTC060',
            //HEI.09<<
            'SLS009':
                begin
                    //Customers
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Customer, UnitTestingValue);
                    if Customer.GET(FindCustomer()) then;
                    UnitTestingValue.VALIDATE(Value, Customer."No.");
                    if Customer."Bill-to Customer No." <> '' then
                        UnitTestingValue.VALIDATE("Value 2", Customer."Bill-to Customer No.")
                    else
                        UnitTestingValue.VALIDATE("Value 2", Customer."No.");
                    UnitTestingValue.MODIFY(true);
                    CustomerNo := UnitTestingValue.Value;

                    if TestCode = 'SLS009' then begin //HEI.09
                                                      //Account Group
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Account Group FND", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, 'Y002');
                        UnitTestingValue.MODIFY(true);
                    end; //HEI.09

                    //HEI.09>>
                    if TestCode = 'OTC059' then begin
                        //Risk Score
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Risk Score FND", UnitTestingValue);
                        RiskScoreCode := FORMAT(FindRiskScore());
                        UnitTestingValue.VALIDATE(Value, RiskScoreCode);
                        UnitTestingValue.VALIDATE("Value 2", RiskScoreCode);
                        UnitTestingValue.MODIFY(true);
                    end;
                    //HEI.09<<
                end;

            //HEI.08>>
            'SLS010',
            'SLS011',
            'SLS012',
            'SLS013',
            'SLS014',
            'SLS015',
            //HEI.08<<
            //HEI.09>>
            'OTC1XX',
            'OTC1XXX',
            //HEI.09<<
            'OTC21XXX', //HEI.12
            'SLS018',
            'SLS021':
                begin
                    //HEI.08>>
                    if TestCode = 'SLS010' then begin
                        //Account Group
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Account Group FND", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, 'Y010');
                        UnitTestingValue.MODIFY(true);
                        AccountGroupCode := UnitTestingValue.Value;

                        //Service Zone
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Service Zone", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindServiceZone());
                        UnitTestingValue.MODIFY(true);

                        //Permission Set
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Permission Set", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindPermissionSet());
                        UnitTestingValue.MODIFY(true);

                        //Shipment Method
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipment Method", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindShipmentMethod());
                        UnitTestingValue.MODIFY(true);

                        //Shipping Agent Service
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipping Agent Services", UnitTestingValue);
                        if Route."Shipping Agent Service Code" <> '' then begin
                            ShippingAgentServices.SETRANGE(Code, Route."Shipping Agent Service Code");
                            ShippingAgentServices.SETRANGE("Shipping Agent Code", '<>%1', '');
                            if ShippingAgentServices.FINDFIRST() then begin
                                UnitTestingValue.VALIDATE(Value, Route."Shipping Agent Service Code");
                                ShippAgentCode := ShippingAgentServices."Shipping Agent Code";
                            end;
                        end else begin
                            ShippingAgentServices.SETRANGE(Code, FindShippingAgService(ShippAgentCode));
                            if ShippingAgentServices.FINDFIRST() then
                                UnitTestingValue.VALIDATE(Value, ShippingAgentServices.Code);
                        end;
                        UnitTestingValue.MODIFY(true);

                        //Shipping Agent
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipping Agent", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, ShippingAgentServices."Shipping Agent Code");
                        UnitTestingValue.MODIFY(true);

                        //Delivery Type
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- "Delivery Type" >>
                        //BC Upgrade VAMSIU01 Replaced table Delivery Type with DeliveryType107FDW >>
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::DeliveryType107FDW, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindDeliveryType());
                        UnitTestingValue.MODIFY(true);
                        //BC Upgrade VAMSIU01 Replaced table Delivery Type with DeliveryType107FDW <<
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- "Delivery Type" <<

                        //Location
                        if LocationCode = '' then
                            LocationCode := FindLocation(false);

                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, LocationCode);
                        UnitTestingValue.MODIFY(true);

                        //Route
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- Route >>
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Route107FDW, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindRoute(LocationCode));
                        UnitTestingValue.MODIFY(true);
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- Route <<

                        //Language
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Language, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindLanguage());
                        UnitTestingValue.MODIFY(true);

                        //Tax Office
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- "Tax Office" >>
                        //BC Upgrade VAMSIU01 Replaced table Taxoffice >>
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::TaxOffice102FDW, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindTaxOffice());
                        UnitTestingValue.MODIFY(true);
                        //BC Upgrade VAMSIU01 Replaced table Taxoffice >>
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- "Tax Office" <<

                        //License Type
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"License Type FND", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindLicenseType());
                        UnitTestingValue.MODIFY(true);

                        //Business Segment
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Business Segment FND", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindBusinessSegment());
                        UnitTestingValue.MODIFY(true);

                        //Business OrganizationalSegment
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Business Org Segment FND", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindBusinessOrganizationalSegment());
                        UnitTestingValue.MODIFY(true);

                        //Customer Type
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Customer Type FND", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindCustomerType());
                        UnitTestingValue.MODIFY(true);

                        //Customer Sub-Type
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Customer Sub-Type FND", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindCustomerSubType(AccountGroupCode));
                        UnitTestingValue.MODIFY(true);
                        CustomerSubType := UnitTestingValue.Value;

                        //Local Customer Sub-Type
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Local Customer Sub-Type FND", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindLocalCustomerSubType(CustomerSubType, AccountGroupCode));
                        UnitTestingValue.MODIFY(true);

                        //Dimension Values
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindDimensionValue(GeneralLedgerSetup."Global Dimension 1 Code"));
                        UnitTestingValue.VALIDATE("Value 2", FindDimensionValue(GeneralLedgerSetup."Shortcut Dimension 3 Code"));
                        UnitTestingValue.VALIDATE("Value 3", FindDimensionValue(GeneralLedgerSetup."Shortcut Dimension 5 Code"));
                        UnitTestingValue.MODIFY(true);
                    end;
                    //HEI.08<<

                    //Customer
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Customer, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindCustomer());
                    UnitTestingValue.MODIFY(true);
                    CustomerNo := UnitTestingValue.Value;
                    //HEI.08>>
                    if (TestCode = 'SLS010') or (TestCode = 'SLS013') or (TestCode = 'SLS015') or
                       (TestCode = 'OTC21XXX') or //HEI.12
                       (TestCode = 'OTC1XX') or (TestCode = 'OTC1XXX') //HEI.09
                    then begin
                        if Customer.GET(CustomerNo) then; //HEI.26
                        if BillToCustomer.GET(Customer."Bill-to Customer No.") then begin
                            UnitTestingValue.VALIDATE(Value, BillToCustomer."No.");
                            UnitTestingValue.MODIFY(true);
                        end;
                    end;
                    //HEI.08<<

                    if (TestCode = 'SLS018') or (TestCode = 'SLS021') or //HEI.08
                       (TestCode = 'OTC21XXX') or //HEI.12
                       (TestCode = 'OTC1XX') or (TestCode = 'OTC1XXX') //HEI.09
                    then begin //HEI.08
                               //Item
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindItemWithLotAndInventory('01', LocationCode, LotNo, ZoneCode, BinCode, 'LOTALLEXP'));
                        if (TestCode = 'SLS018') or (TestCode = 'SLS021') then
                            UnitTestingValue.VALIDATE("Value 2", FindEmptyItem());
                        UnitTestingValue.MODIFY(true);
                        ItemNo := UnitTestingValue.Value;

                        //Location
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                        if LocationCode = '' then
                            LocationCode := FindLocation(false);
                        UnitTestingValue.VALIDATE(Value, LocationCode);
                        UnitTestingValue.MODIFY(true);

                        //Item Charge
                        if (TestCode <> 'OTC21XXX') then begin //HEI.12

                            //Commented below Code as Procedure-FindItemCharge depends on Drink-IT field-Item Charge Type of table -Item Charge >>
                            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Item Charge", UnitTestingValue);
                            if TestCode = 'SLS018' then
                                UnitTestingValue.VALIDATE(Value, FindItemCharge(2));
                            if (TestCode = 'SLS021') or
                               (TestCode = 'OTC1XX') or (TestCode = 'OTC1XXX') //HEI.09
                            then
                                UnitTestingValue.VALIDATE(Value, FindItemCharge(3));
                            UnitTestingValue.MODIFY(true);
                            //Commented below Code as Procedure-FindItemCharge depends on Drink-IT field-Item Charge Type of table -Item Charge <<
                        end; //HEI.12

                        //Deposit Group
                        if (TestCode = 'SLS018') or (TestCode = 'SLS021') then begin //HEI.09

                            //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- "Drink Deposit Group" >>
                            //BC Upgrade VAMSIU01 Replaced Drink Deposit Group table with BusinessGroup104FDW >>
                            InitUnitTestingValues(TestCode, TestDescription, DATABASE::BusinessGroup104FDW, UnitTestingValue);
                            UnitTestingValue.VALIDATE(Value, FindDepositGroup());
                            UnitTestingValue.MODIFY(true);
                            //BC Upgrade VAMSIU01 Replaced Drink Deposit Group table with BusinessGroup104FDW >>
                            //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- "Drink Deposit Group" <<
                        end; //HEI.09
                    end; //HEI.08

                    //HEI.08>>
                    if (TestCode = 'SLS011') or (TestCode = 'SLS012') then begin
                        //Blocked Reason Code
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Blocked Reason FND", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindBlockedReason());
                        UnitTestingValue.MODIFY(true);
                    end;

                    if TestCode = 'SLS013' then begin
                        //Payment Terms
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Payment Terms", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindPaymentTerms());
                        UnitTestingValue.MODIFY(true);

                        //Payment Method
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Payment Method", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindPaymentMethod());
                        UnitTestingValue.MODIFY(true);
                    end;

                    if TestCode = 'SLS015' then begin
                        //Customer Price Group
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Customer Price Group", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindCustomerPriceGroup());
                        UnitTestingValue.MODIFY(true);

                        //Customer Discount Group
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Customer Discount Group", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindCustomerDiscountGroup());
                        UnitTestingValue.MODIFY(true);

                        //Customer DDeposit Group
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- "Drink Deposit Group" >>
                        //BC Upgrade VAMSIU01 Replaced Drink Deposit Group table with BusinessGroup104FDW >>
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::BusinessGroup104FDW, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindDepositGroup());
                        UnitTestingValue.MODIFY(true);
                        //BC Upgrade VAMSIU01 Replaced Drink Deposit Group table with BusinessGroup104FDW >>
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- "Drink Deposit Group" <<
                    end;
                    //HEI.08<<

                    //HEI.09>>
                    if (TestCode = 'OTC1XX') or (TestCode = 'OTC1XXX') or
                       (TestCode = 'OTC21XXX') //HEI.12
                    then begin
                        //Item Unit of Measure
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Item Unit of Measure", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindItemUnitOfMeasure(ItemNo));
                        UnitTestingValue.MODIFY(true);

                        //Shipment Method
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipment Method", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindShipmentMethod());
                        UnitTestingValue.MODIFY(true);
                    end;
                    //HEI.09<<
                end;

            //HEI.02>>
            'LOG041',
            'LOG042':
                begin
                    //Location
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindLocation(false));
                    UnitTestingValue.MODIFY(true);
                end;

            'LOG035':
                begin
                    //Item
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
                    ItemNo := FindItemWithLotAndInventory('01', LocationCode, LotNo, ZoneCode, BinCode, 'LOTALLEXP');
                    UnitTestingValue.VALIDATE(Value, ItemNo);
                    UnitTestingValue.MODIFY(true);

                    //Location
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                    if LocationCode = '' then
                        LocationCode := FindLocation(false);
                    UnitTestingValue.VALIDATE(Value, LocationCode);
                    LocationFrom := LocationCode;
                    UnitTestingValue.VALIDATE("Value 2", FindLocation(false));
                    LocationTo := UnitTestingValue."Value 2";
                    UnitTestingValue.VALIDATE("Value 3", FindInTransitLocation(false));
                    UnitTestingValue.MODIFY(true);

                    Item.GET(ItemNo);
                    if not InventoryPostingSetup.GET(LocationTo, Item."Inventory Posting Group") then begin
                        //Update Location To
                        UnitTestingValue3.SETRANGE("Company Name", COMPANYNAME);
                        UnitTestingValue3.SETRANGE("Test Script Code", TestCode);
                        UnitTestingValue3.SETRANGE("Table ID", DATABASE::Location);
                        UnitTestingValue3.FINDFIRST();
                        LocationTo := FindLocation(false);
                        if (LocationTo <> '') and InventoryPostingSetup2.GET(LocationTo, Item."Inventory Posting Group") then begin
                            UnitTestingValue3.VALIDATE("Value 2", LocationTo);
                            UnitTestingValue3.MODIFY(true);
                        end else begin
                            //Update Item
                            UnitTestingValue2.SETRANGE("Company Name", COMPANYNAME);
                            UnitTestingValue2.SETRANGE("Test Script Code", TestCode);
                            UnitTestingValue2.SETRANGE("Table ID", DATABASE::Item);
                            UnitTestingValue2.FINDFIRST();
                            ItemNo := FindItemWithLotAndInventory('04', LocationCode, LotNo, ZoneCode, BinCode, 'LOTALL');
                            UnitTestingValue2.VALIDATE(Value, ItemNo);
                            UnitTestingValue2.MODIFY(true);
                        end;
                    end;

                    //Zone
                    if ZoneCode = '' then
                        ZoneCode := FindZone(LocationCode);

                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Zone, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, ZoneCode);
                    UnitTestingValue.MODIFY(true);

                    //Bin
                    if BinCode = '' then
                        BinCode := FindBin(LocationCode, ItemNo, ZoneCode);
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Bin, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, BinCode);
                    UnitTestingValue.MODIFY(true);

                    //Shipping Agent Service
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipping Agent Services", UnitTestingValue);
                    ShippingAgentServices.SETRANGE(Code, FindShippingAgService(ShippAgentCode));
                    if ShippingAgentServices.FINDFIRST() then
                        UnitTestingValue.VALIDATE(Value, ShippingAgentServices.Code);
                    UnitTestingValue.MODIFY(true);

                    //Shipping Agent
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipping Agent", UnitTestingValue);
                    if ShippingAgentServices."Shipping Agent Code" <> '' then
                        UnitTestingValue.VALIDATE(Value, ShippingAgentServices."Shipping Agent Code")
                    else
                        UnitTestingValue.VALIDATE(Value, FindShippingAgent());
                    UnitTestingValue.MODIFY(true);

                    //Driver
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- "Whse. Shipping Driver",Route >>
                    //BC Upgrade VAMSIU01 Added Driver table, Route.driver >>
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Driver107FDW, UnitTestingValue);
                    if Route.Driver <> '' then
                        UnitTestingValue.VALIDATE(Value, Route.Driver)
                    else
                        UnitTestingValue.VALIDATE(Value, FindDriver());
                    UnitTestingValue.MODIFY(true);
                    //BC Upgrade VAMSIU01 Added Driver table, Route.driver >>
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- "Whse. Shipping Driver",Route <<

                    //Truck
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- "Whse. Shipping Truck",Route >>
                    //BC Upgrade VAMSIU01 Added Vehicle table, Route.Vehicle >>
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vehicle101FDW, UnitTestingValue);
                    if Route.Vehicle <> '' then
                        UnitTestingValue.VALIDATE(Value, Route.Vehicle)
                    else
                        UnitTestingValue.VALIDATE(Value, FindTruck());
                    UnitTestingValue.MODIFY(true);
                    //BC Upgrade VAMSIU01 Added Vehicle table, Route.Vehicle >>
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- "Whse. Shipping Truck",Route <<
                end;

            'OTC014':
                begin
                    //Job Queue Entry
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Job Queue Entry", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, '88');
                    UnitTestingValue.MODIFY(true);
                end;
            //HEI.02<<

            //HEI.04>>
            'OTC152',
            'OTC153',
            'OTC154',
            'OTC159',
            'OTC161',
            //HEI.06>>
            'OTC179',
            //HEI.06<<
            'OTC176':
                begin
                    //Customer
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Customer, UnitTestingValue);
                    CustomerNo := FindCustomer();
                    if Customer.GET(CustomerNo) then; //HEI.26
                    if (TestCode = 'OTC159') or (TestCode = 'OTC176') then
                        UnitTestingValue.VALIDATE(Value, CustomerNo)
                    else
                        if BillToCustomer.GET(Customer."Bill-to Customer No.") then
                            UnitTestingValue.VALIDATE(Value, BillToCustomer."No.")
                        else
                            UnitTestingValue.VALIDATE(Value, CustomerNo);

                    if TestCode = 'OTC153' then begin
                        FirstCustomerNo := CustomerNo;
                        CustomerNo := FindCustomer();
                        if CustomerNo <> '' then   //HEI.20
                            Customer.GET(CustomerNo);
                        if BillToCustomer.GET(Customer."Bill-to Customer No.") then
                            UnitTestingValue.VALIDATE("Value 2", BillToCustomer."No.")
                        else
                            UnitTestingValue.VALIDATE("Value 2", CustomerNo);
                    end;

                    UnitTestingValue.MODIFY(true);

                    //Cash Receipt Journal
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Journal Template", UnitTestingValue);
                    JournalTemplateName := FindCashRcptJournal();
                    UnitTestingValue.VALIDATE(Value, JournalTemplateName);
                    UnitTestingValue.MODIFY(true);

                    //Journal Batch
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Journal Batch", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindCashRcptBatch(JournalTemplateName));
                    UnitTestingValue.MODIFY(true);

                    //Payment Method
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Payment Method", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindPaymentMethod());
                    UnitTestingValue.MODIFY(true);

                    if TestCode <> 'OTC179' then begin//HEI.20
                                                      //Dimension Value
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindDimensionValue(GeneralLedgerSetup."Shortcut Dimension 3 Code"));
                        UnitTestingValue.MODIFY(true);
                    end; //HEI.20

                    //GL Account
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindGLAccount());
                    UnitTestingValue.MODIFY(true);

                    if (TestCode = 'OTC159') or (TestCode = 'OTC176') then begin
                        //Item
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
                        ItemNo := FindItemWithLotAndInventory('01', LocationCode, LotNo, ZoneCode, BinCode, 'LOTALLEXP');
                        UnitTestingValue.VALIDATE(Value, ItemNo);
                        UnitTestingValue.MODIFY(true);

                        //Location
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                        if LocationCode = '' then
                            LocationCode := FindLocation(false);
                        UnitTestingValue.VALIDATE(Value, LocationCode);
                        UnitTestingValue.MODIFY(true);

                        //Zone
                        if ZoneCode = '' then
                            ZoneCode := FindZone(LocationCode);
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Zone, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, ZoneCode);
                        UnitTestingValue.MODIFY(true);

                        //Bin
                        if BinCode = '' then
                            BinCode := FindBin(LocationCode, ItemNo, ZoneCode);
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Bin, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, BinCode);
                        UnitTestingValue.MODIFY(true);

                        //Route
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- Route >>
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Route107FDW, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindRoute(LocationCode));
                        UnitTestingValue.MODIFY(true);
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- Route <<

                        //Shipping Agent Service
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipping Agent Services", UnitTestingValue);
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- Route >>
                        if Route."Shipping Agent Service Code" <> '' then begin
                            ShippingAgentServices.SETRANGE(Code, Route."Shipping Agent Service Code");
                            ShippingAgentServices.SETRANGE("Shipping Agent Code", '<>%1', '');
                            if ShippingAgentServices.FINDFIRST() then begin
                                UnitTestingValue.VALIDATE(Value, Route."Shipping Agent Service Code");
                                ShippAgentCode := ShippingAgentServices."Shipping Agent Code";
                            end;
                        end else
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- Route <<
                        begin
                            ShippingAgentServices.SETRANGE(Code, FindShippingAgService(ShippAgentCode));
                            if ShippingAgentServices.FINDFIRST() then
                                UnitTestingValue.VALIDATE(Value, ShippingAgentServices.Code);
                        end;
                        UnitTestingValue.MODIFY(true);

                        //Shipping Agent
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipping Agent", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, ShippingAgentServices."Shipping Agent Code");
                        UnitTestingValue.MODIFY(true);

                        //Driver
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- "Whse. Shipping Driver", Route >>
                        //BC Upgrade VAMSIU01 Added Driver table, Route.driver >>
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Driver107FDW, UnitTestingValue);
                        if Route.Driver <> '' then
                            UnitTestingValue.VALIDATE(Value, Route.Driver)
                        else
                            UnitTestingValue.VALIDATE(Value, FindDriver());
                        UnitTestingValue.MODIFY(true);
                        //BC Upgrade VAMSIU01 Added Driver table, Route.driver <<
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- "Whse. Shipping Driver", Route <<

                        //Truck
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- "Whse. Shipping Truck", Route >>
                        // //BC Upgrade VAMSIU01 Added Vehicle table, Route.Vehicle >>
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vehicle101FDW, UnitTestingValue);
                        if Route.Vehicle <> '' then
                            UnitTestingValue.VALIDATE(Value, Route.Vehicle)
                        else
                            UnitTestingValue.VALIDATE(Value, FindTruck());
                        UnitTestingValue.MODIFY(true);
                        //BC Upgrade VAMSIU01 Added Vehicle table, Route.Vehicle >>
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- "Whse. Shipping Truck", Route <<

                        //Document Subtype Code
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- "Document Subtype Code" >>
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Document Subtype Code FND", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, 'SALES_DEF');
                        UnitTestingValue.MODIFY(true);
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- "Document Subtype Code" <<
                    end;
                end;

            'OTC095',
            'OTC096',
            'OTC097',
            'OTC098',
            'OTC104',
            'OTC106',
            'OTC107',
            'LOG025',
            'LOG025_2':
                begin
                    if TestCode <> 'LOG025' then begin
                        //Customer
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Customer, UnitTestingValue);
                        FirstCustomerNo := FindCustomer();
                        UnitTestingValue.VALIDATE(Value, FirstCustomerNo);
                        if TestCode = 'OTC098' then
                            UnitTestingValue.VALIDATE("Value 2", FindCustomer());
                        UnitTestingValue.MODIFY(true);

                        //Item
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindItemWithLotAndInventory('01', LocationCode, LotNo, ZoneCode, BinCode, 'LOTALLEXP'));
                        UnitTestingValue.MODIFY(true);

                        //Location
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                        if LocationCode = '' then
                            LocationCode := FindLocation(false);
                        UnitTestingValue.VALIDATE(Value, LocationCode);
                        UnitTestingValue.MODIFY(true);

                        //Route
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- Route >>
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Route107FDW, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindRoute(LocationCode));
                        UnitTestingValue.MODIFY(true);
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- Route <<

                        if (TestCode = 'OTC096') or (TestCode = 'LOG025_2') then begin
                            if TestCode = 'OTC096' then begin
                                //Document Subtype Code
                                //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- "Document Subtype Code" >>
                                InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Document Subtype Code FND", UnitTestingValue);
                                UnitTestingValue.VALIDATE(Value, 'SALES_DEF');
                                UnitTestingValue.MODIFY(true);
                                //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- "Document Subtype Code" <<
                            end;

                            //Zone
                            if ZoneCode = '' then
                                ZoneCode := FindZone(LocationCode);
                            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Zone, UnitTestingValue);
                            UnitTestingValue.VALIDATE(Value, ZoneCode);
                            UnitTestingValue.MODIFY(true);

                            //Bin
                            if BinCode = '' then
                                BinCode := FindBin(LocationCode, ItemNo, ZoneCode);
                            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Bin, UnitTestingValue);
                            UnitTestingValue.VALIDATE(Value, BinCode);
                            UnitTestingValue.MODIFY(true);

                            //Shipping Agent Service
                            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipping Agent Services", UnitTestingValue);
                            //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- Route >>
                            if Route."Shipping Agent Service Code" <> '' then begin
                                ShippingAgentServices.SETRANGE(Code, Route."Shipping Agent Service Code");
                                ShippingAgentServices.SETRANGE("Shipping Agent Code", '<>%1', '');
                                if ShippingAgentServices.FINDFIRST() then begin
                                    UnitTestingValue.VALIDATE(Value, Route."Shipping Agent Service Code");
                                    ShippAgentCode := ShippingAgentServices."Shipping Agent Code";
                                end;
                            end else
                            //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- Route <<
                            begin
                                ShippingAgentServices.SETRANGE(Code, FindShippingAgService(ShippAgentCode));
                                if ShippingAgentServices.FINDFIRST() then
                                    UnitTestingValue.VALIDATE(Value, ShippingAgentServices.Code);
                            end;
                            UnitTestingValue.MODIFY(true);

                            //Shipping Agent
                            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipping Agent", UnitTestingValue);
                            UnitTestingValue.VALIDATE(Value, ShippingAgentServices."Shipping Agent Code");
                            UnitTestingValue.MODIFY(true);

                            //Driver
                            //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- Route, "Whse. Shipping Driver" >>
                            //BC Upgrade VAMSIU01 Added Driver table, Route.driver >>
                            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Driver107FDW, UnitTestingValue);
                            if Route.Driver <> '' then
                                UnitTestingValue.VALIDATE(Value, Route.Driver)
                            else
                                UnitTestingValue.VALIDATE(Value, FindDriver());
                            UnitTestingValue.MODIFY(true);
                            //BC Upgrade VAMSIU01 Added Driver table, Route.driver <<
                            //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- Route, "Whse. Shipping Driver" <<

                            //Truck
                            //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- Route, "Whse. Shipping Truck" >>
                            // //BC Upgrade VAMSIU01 Added Vehicle table, Route.Vehicle >>
                            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vehicle101FDW, UnitTestingValue);
                            if Route.Vehicle <> '' then
                                UnitTestingValue.VALIDATE(Value, Route.Vehicle)
                            else
                                UnitTestingValue.VALIDATE(Value, FindTruck());
                            UnitTestingValue.MODIFY(true);
                            //BC Upgrade VAMSIU01 Added Vehicle table, Route.Vehicle >>
                            //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- Route, "Whse. Shipping Truck" <<

                            if TestCode = 'LOG025_2' then begin
                                //Dimension Value
                                InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
                                UnitTestingValue.VALIDATE(Value, FindDimensionValue(GeneralLedgerSetup."Shortcut Dimension 3 Code"));
                                UnitTestingValue.MODIFY(true);
                            end;
                        end;

                        if TestCode = 'OTC106' then begin
                            //Cash Receipt Journal
                            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Journal Template", UnitTestingValue);
                            JournalTemplateName := FindCashRcptJournal();
                            UnitTestingValue.VALIDATE(Value, JournalTemplateName);
                            UnitTestingValue.MODIFY(true);

                            //Journal Batch
                            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Journal Batch", UnitTestingValue);
                            UnitTestingValue.VALIDATE(Value, FindCashRcptBatch(JournalTemplateName));
                            UnitTestingValue.MODIFY(true);

                            //Payment Method
                            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Payment Method", UnitTestingValue);
                            UnitTestingValue.VALIDATE(Value, FindPaymentMethod());
                            UnitTestingValue.MODIFY(true);

                            //GL Account
                            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
                            UnitTestingValue.VALIDATE(Value, FindGLAccount());
                            UnitTestingValue.MODIFY(true);
                        end;

                    end else begin
                        //Vendor
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindVendor('3PV-TRADE')); //HEI.06
                        UnitTestingValue.MODIFY(true);

                        //Item Charge
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Item Charge", UnitTestingValue);
                        //Commented below Code as Procedure-FindItemCharge depends on Drink-IT field-Item Charge Type of table -Item Charge >>
                        ItemChargeNo := FindItemCharge(6);
                        if ItemChargeNo <> '' then
                            UnitTestingValue.VALIDATE(Value, ItemChargeNo)
                        else
                        //Commented below Code as Procedure-FindItemCharge depends on Drink-IT field-Item Charge Type of table -Item Charge >>
                        begin
                            //GL Account
                            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
                            UnitTestingValue.VALIDATE(Value, FindGLAccount());
                        end;
                        UnitTestingValue.MODIFY(true);
                    end;
                end;
            //HEI.04<<

            //HEI.06>>
            'LOG076',
            'LOG077',
            'LOG078',
            'LOG079',
            'LOG080',
            'LOG081',
            //HEI.12>>
            'LOGNEW22',
            //HEI.12<<
            //HEI.22>>
            'LOG_IC_001',
            //HEI.22<<
            'LOG082':
                begin
                    //HEI.22>>
                    if (TestCode = 'LOG_IC_001') then begin
                        //Vendor
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindVendor_ICPartner());
                        UnitTestingValue.MODIFY(true);
                        if Vendor.GET(UnitTestingValue.Value) then; //HEI.24
                    end else
                        //HEI.22<<
                        if (TestCode = 'LOG076') or (TestCode = 'LOG080') or (TestCode = 'LOG081') or
                           (TestCode = 'LOGNEW22') //HEI.12
                        then begin
                            //Vendor
                            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vendor, UnitTestingValue);
                            UnitTestingValue.VALIDATE(Value, FindVendor('3PV-TRADE'));
                            UnitTestingValue.MODIFY(true);
                            if Vendor.GET(UnitTestingValue.Value) then;
                        end else if (TestCode = 'LOG077') or (TestCode = 'LOG082') then begin
                            //Customer
                            InitUnitTestingValues(TestCode, TestDescription, DATABASE::Customer, UnitTestingValue);
                            UnitTestingValue.VALIDATE(Value, FindCustomer());
                            UnitTestingValue.MODIFY(true);
                        end;

                    //Item
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
                    if (TestCode = 'LOG076') or (TestCode = 'LOG080') or (TestCode = 'LOG081') or
                       (TestCode = 'LOG_IC_001') or //HEI.22
                       (TestCode = 'LOGNEW22') //HEI.12
                    then begin
                        ItemNo := FindItemWithLotAndInventory('09', LocationCode, LotNo, ZoneCode, BinCode, 'LOTALLEXP');

                        if ItemNo = '' then
                            ItemNo := FindItemWithLotAndInventory('09', LocationCode, LotNo, ZoneCode, BinCode, 'LOTALL');
                    end else
                        if (TestCode = 'LOG079') then
                            ItemNo := FindItemWithLotAndInventory('02', LocationCode, LotNo, ZoneCode, BinCode, 'LOTALLEXP');

                    if ItemNo = '' then
                        ItemNo := FindItemWithLotAndInventory('01', LocationCode, LotNo, ZoneCode, BinCode, 'LOTALLEXP');
                    UnitTestingValue.VALIDATE(Value, ItemNo);
                    UnitTestingValue.MODIFY(true);
                    Item.GET(UnitTestingValue.Value);

                    //Location
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                    if LocationCode = '' then
                        LocationCode := FindLocation(false);
                    UnitTestingValue.VALIDATE(Value, LocationCode);

                    if (TestCode = 'LOG078') or (TestCode = 'LOG079') then begin
                        LocationFrom := LocationCode;
                        UnitTestingValue.VALIDATE("Value 2", FindLocation(false));
                        LocationTo := UnitTestingValue."Value 2";
                        UnitTestingValue.VALIDATE("Value 3", FindInTransitLocation(false));
                    end;
                    UnitTestingValue.MODIFY(true);

                    if (TestCode = 'LOG078') or (TestCode = 'LOG079') then begin
                        Item.GET(ItemNo);
                        if not InventoryPostingSetup.GET(LocationTo, Item."Inventory Posting Group") then begin
                            //Update Location To
                            UnitTestingValue3.SETRANGE("Company Name", COMPANYNAME);
                            UnitTestingValue3.SETRANGE("Test Script Code", TestCode);
                            UnitTestingValue3.SETRANGE("Table ID", DATABASE::Location);
                            UnitTestingValue3.FINDFIRST();
                            LocationTo := FindLocation(false);
                            if (LocationTo <> '') and InventoryPostingSetup2.GET(LocationTo, Item."Inventory Posting Group") then begin
                                UnitTestingValue3.VALIDATE("Value 2", LocationTo);
                                UnitTestingValue3.MODIFY(true);
                            end else begin
                                //Update Item
                                UnitTestingValue2.SETRANGE("Company Name", COMPANYNAME);
                                UnitTestingValue2.SETRANGE("Test Script Code", TestCode);
                                UnitTestingValue2.SETRANGE("Table ID", DATABASE::Item);
                                UnitTestingValue2.FINDFIRST();
                                ItemNo := FindItemWithLotAndInventory('04', LocationCode, LotNo, ZoneCode, BinCode, 'LOTALL');
                                UnitTestingValue2.VALIDATE(Value, ItemNo);
                                UnitTestingValue2.MODIFY(true);
                            end;
                        end;
                    end;

                    //Route
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- Route >>
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Route107FDW, UnitTestingValue);
                    RouteCode := FindRoute(LocationCode);
                    if RouteCode <> '' then
                        Route.GET(RouteCode);
                    UnitTestingValue.VALIDATE(Value, RouteCode);
                    UnitTestingValue.MODIFY(true);
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table- Route <<

                    //Zone
                    if ZoneCode = '' then
                        ZoneCode := FindZone(LocationCode);
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Zone, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, ZoneCode);
                    UnitTestingValue.MODIFY(true);

                    //Bin
                    if BinCode = '' then
                        BinCode := FindBin(LocationCode, ItemNo, ZoneCode);
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Bin, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, BinCode);
                    UnitTestingValue.MODIFY(true);

                    if (TestCode = 'LOG076') or (TestCode = 'LOG080') or (TestCode = 'LOG081') or (TestCode = 'LOG082') or
                       (TestCode = 'LOG_IC_001') or //HEI.22
                       (TestCode = 'LOGNEW22') //HEI.12
                    then begin
                        //Lot No. Information
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Lot No. Information", UnitTestingValue);
                        if LotNo <> '' then
                            UnitTestingValue.VALIDATE(Value, LotNo)
                        else
                            UnitTestingValue.VALIDATE(Value, FindLotNoInformation(ItemNo));
                        UnitTestingValue.MODIFY(true);

                        //CCC Dimension
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindCCCDimValue_Item_Purch_Acc(Vendor."Gen. Bus. Posting Group", Item."Gen. Prod. Posting Group"));
                        //HEI.12>>
                        if TestCode = 'LOGNEW22' then begin //HEI.19
                            UnitTestingValue.VALIDATE("Value 2", FindDimensionValue(GeneralLedgerSetup."Shortcut Dimension 3 Code"));
                            //HEI.19>>
                            if UnitTestingValue.Value = '' then
                                UnitTestingValue.VALIDATE(Value, FindDimensionValue(GeneralLedgerSetup."Cost Center Dimension Code FND"));
                        end;
                        //HEI.19<<
                        //HEI.12<<
                        UnitTestingValue.MODIFY(true);
                    end;

                    //Shipping Agent Service
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipping Agent Services", UnitTestingValue);
                    if Route."Shipping Agent Service Code" <> '' then begin
                        ShippingAgentServices.SETRANGE(Code, Route."Shipping Agent Service Code");
                        ShippingAgentServices.SETRANGE("Shipping Agent Code", '<>%1', '');
                        if ShippingAgentServices.FINDFIRST() then begin
                            UnitTestingValue.VALIDATE(Value, Route."Shipping Agent Service Code");
                            ShippAgentCode := ShippingAgentServices."Shipping Agent Code";
                        end;
                    end else begin
                        ShippingAgentServices.SETRANGE(Code, FindShippingAgService(ShippAgentCode));
                        ShippingAgentServices.SETFILTER("Shipping Agent Code", '<>%1', '');
                        if ShippingAgentServices.FINDFIRST() then
                            UnitTestingValue.VALIDATE(Value, ShippingAgentServices.Code);
                    end;
                    UnitTestingValue.MODIFY(true);

                    //Shipping Agent
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipping Agent", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, ShippingAgentServices."Shipping Agent Code");
                    UnitTestingValue.MODIFY(true);

                    //Driver
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Whse. Shipping Driver",Route >>
                    //BC Upgrade VAMSIU01 Added Driver table, Route.driver >>
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Driver107FDW, UnitTestingValue);
                    if Route.Driver <> '' then
                        UnitTestingValue.VALIDATE(Value, Route.Driver)
                    else
                        UnitTestingValue.VALIDATE(Value, FindDriver());
                    UnitTestingValue.MODIFY(true);
                    //BC Upgrade VAMSIU01 Added Driver table, Route.driver >>
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Whse. Shipping Driver",Route <<

                    //Truck
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Whse. Shipping Truck",Route >>
                    // //BC Upgrade VAMSIU01 Added Vehicle table, Route.Vehicle >>
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vehicle101FDW, UnitTestingValue);
                    if Route.Vehicle <> '' then
                        UnitTestingValue.VALIDATE(Value, Route.Vehicle)
                    else
                        UnitTestingValue.VALIDATE(Value, FindTruck());
                    UnitTestingValue.MODIFY(true);
                    //BC Upgrade VAMSIU01 Added Vehicle table, Route.Vehicle >>
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Whse. Shipping Truck",Route <<

                    if (TestCode <> 'LOG_IC_001') then //HEI.22
                        if TestCode <> 'LOGNEW22' then begin //HEI.12
                                                             //No. Series
                            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"No. Series", UnitTestingValue);
                            UnitTestingValue.VALIDATE(Value, FindNoSeries());
                            UnitTestingValue.MODIFY(true);

                            if (TestCode = 'LOG080') or (TestCode = 'LOG082') then begin
                                //Return Reason Code
                                InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Return Reason", UnitTestingValue);
                                UnitTestingValue.VALIDATE(Value, FindReturnReason());
                                UnitTestingValue.MODIFY(true);
                            end;
                            //HEI.12>>
                        end else begin
                            //GL Account
                            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
                            UnitTestingValue.VALIDATE(Value, FindGLAccount());
                            UnitTestingValue.MODIFY(true);

                            //FA GL Journal
                            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Journal Template", UnitTestingValue);
                            JournalTemplateName := FindFAGLJournal();
                            UnitTestingValue.VALIDATE(Value, JournalTemplateName);
                            UnitTestingValue.MODIFY(true);

                            //Journal Batch
                            InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Journal Batch", UnitTestingValue);
                            UnitTestingValue.VALIDATE(Value, FindCashRcptBatch(JournalTemplateName));
                            UnitTestingValue.MODIFY(true);
                        end;
                    //HEI.12<<
                end;
            //HEI.06<<

            //HEI.11>>
            'SLS001',
            'SLS002',
            'SLS003',
            'SLS004',
            'SLS005',
            'SLS008':
                begin

                    //Customer Price Group
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Customer Price Group", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindCustomerPriceGroup());
                    UnitTestingValue.MODIFY(true);

                    //Language
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Language, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindLanguage());
                    UnitTestingValue.MODIFY(true);

                    //Customer posting group
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Customer Posting Group", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindCustomerPostingGroup());
                    UnitTestingValue.MODIFY(true);

                    //Post code
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Post Code", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindPostCode());
                    PostCode.SETRANGE(Code, FindPostCode());
                    if PostCode.FINDFIRST() then
                        UnitTestingValue.VALIDATE("Value 2", PostCode.City);
                    UnitTestingValue.MODIFY(true);

                    //General Business Posting group
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Business Posting Group", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindGenBusPostingGroup());
                    UnitTestingValue.MODIFY(true);

                    //Business Segment
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Business Segment FND", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindBusinessSegment());
                    UnitTestingValue.MODIFY(true);

                    //VAT Business Posting group
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"VAT Business Posting Group", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindVATBusPostingGroup());
                    UnitTestingValue.MODIFY(true);

                    //Business OrganizationalSegment
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Business Org Segment FND", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindBusinessOrganizationalSegment());
                    UnitTestingValue.MODIFY(true);

                    //Customer Type
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Customer Type FND", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindCustomerType());
                    UnitTestingValue.MODIFY(true);

                    //Customer Sub-Type
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Customer Sub-Type FND", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindCustomerSubType('Y001'));
                    UnitTestingValue.MODIFY(true);
                    CustomerSubType := UnitTestingValue.Value;



                    //Account Group
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Account Group FND", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, 'Y001');
                    UnitTestingValue.MODIFY(true);

                    //Customer DDeposit Group
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Drink Deposit Group" >>
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::BusinessGroup104FDW, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindDrinkDepositGroup());
                    UnitTestingValue.MODIFY(true);
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Drink Deposit Group" <<

                    //Blocked Reason Code
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Blocked Reason FND", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindBlockedReason());
                    UnitTestingValue.MODIFY(true);

                    //Free Reason Code
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Free Reason Code" >>
                    //BC Upgrade VAMSIU01 Added Base Reason Code table >>
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Reason Code", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindFreeReasonCode());
                    UnitTestingValue.MODIFY(true);
                    //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Free Reason Code" <<

                    //Legal Form
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Legal Form FND", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindLegalEntity());
                    UnitTestingValue.MODIFY(true);

                    //Market type
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Market Type FND", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindMarketType());
                    UnitTestingValue.MODIFY(true);

                    //WHT Posting Group
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"WHT Business Posting Group FND", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindWHTBusPostingGroup());
                    UnitTestingValue.MODIFY(true);


                end;

            //HEI.15<<
            'SLS_NEW1',
            'SLS_NEW2',
            'SLS_NEW3',
            'OTC2XXX',
            'OTC063',
            'OTC090',
            'OTC091':
                begin
                    //Customer
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Customer, UnitTestingValue);
                    if TestCode = 'SLS_NEW1' then
                        UnitTestingValue.VALIDATE(Value, FindEmployee())
                    else
                        UnitTestingValue.VALIDATE(Value, FindCustomer());
                    UnitTestingValue.MODIFY(true);
                    CustomerNo := UnitTestingValue.Value;

                    //Item
                    if not (TestCode in ['SLS_NEW3', 'OTC063']) then begin
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindItemWithLotAndInventory('01', LocationCode, LotNo, ZoneCode, BinCode, 'LOTALLEXP'));
                        UnitTestingValue.MODIFY(true);
                        ItemNo := UnitTestingValue.Value;
                    end;

                    //Location
                    if TestCode in ['SLS_NEW1', 'OTC2XXX', 'OTC090', 'OTC091'] then begin
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                        if LocationCode = '' then
                            LocationCode := FindLocation(false);
                        UnitTestingValue.VALIDATE(Value, LocationCode);
                        UnitTestingValue.MODIFY(true);
                    end;

                    //Route
                    if TestCode in ['SLS_NEW1', 'OTC090', 'OTC091'] then begin
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-Route >>
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Route107FDW, UnitTestingValue);
                        //UnitTestingValue.VALIDATE(Value,FindRoute(LocationCode));  //HEI.18
                        //HEI.18>>
                        RouteCode := FindRoute(LocationCode);
                        if RouteCode <> '' then
                            Route.GET(RouteCode);
                        UnitTestingValue.VALIDATE(Value, RouteCode);
                        //HEI.18<<
                        UnitTestingValue.MODIFY(true);
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-Route <<
                    end;

                    //Free Reason Code
                    //IF TestCode IN ['SLS_NEW1','SLS_NEW2','SLS_NEW3','OTC2XXX'] THEN BEGIN  //HEI.17
                    if TestCode in ['SLS_NEW1', 'OTC2XXX'] then begin  //HEI.17

                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Free Reason Code" >>
                        //BC Upgrade VAMSIU01 Added Base Reason Code table >>
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Reason Code", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindFreeReasonCode());
                        UnitTestingValue.MODIFY(true);
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Free Reason Code" <<
                    end;
                    //HEI.17>>
                    if TestCode in ['SLS_NEW2', 'SLS_NEW3'] then begin
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Free Reason Code" >>
                        //BC Upgrade VAMSIU01 Added Base Reason Code table >>
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Reason Code", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindLoyaltyFreeReasonCode());
                        UnitTestingValue.MODIFY(true);
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Free Reason Code" <<
                    end;
                    //HEI.17<<

                    if TestCode = 'OTC2XXX' then begin
                        //Item Unit of Measure
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Item Unit of Measure", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindItemUnitOfMeasure(ItemNo));
                        UnitTestingValue.MODIFY(true);

                        //Shipment Method
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipment Method", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindShipmentMethod());
                        UnitTestingValue.MODIFY(true);
                    end;

                    if TestCode in ['OTC090', 'OTC091'] then begin
                        //Bin
                        if BinCode = '' then
                            BinCode := FindBin(LocationCode, ItemNo, ZoneCode);
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Bin, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, BinCode);
                        UnitTestingValue.MODIFY(true);

                        //Shipping Agent Service
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipping Agent Services", UnitTestingValue);
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-Route >>
                        if Route."Shipping Agent Service Code" <> '' then begin
                            ShippingAgentServices.SETRANGE(Code, Route."Shipping Agent Service Code");
                            ShippingAgentServices.SETRANGE("Shipping Agent Code", '<>%1', '');
                            if ShippingAgentServices.FINDFIRST() then begin
                                UnitTestingValue.VALIDATE(Value, Route."Shipping Agent Service Code");
                                ShippAgentCode := ShippingAgentServices."Shipping Agent Code";
                            end;
                        end else
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-Route <<
                        begin
                            ShippingAgentServices.SETRANGE(Code, FindShippingAgService(ShippAgentCode));
                            ShippingAgentServices.SETFILTER("Shipping Agent Code", '<>%1', '');
                            if ShippingAgentServices.FINDFIRST() then
                                UnitTestingValue.VALIDATE(Value, ShippingAgentServices.Code);
                        end;
                        UnitTestingValue.MODIFY(true);

                        //Shipping Agent
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Shipping Agent", UnitTestingValue);
                        //HEI.20<<
                        if ShippAgentCode = '' then
                            UnitTestingValue.VALIDATE(Value, FindShippingAgent())
                        else
                            //HEI.20>>
                            UnitTestingValue.VALIDATE(Value, ShippingAgentServices."Shipping Agent Code");
                        UnitTestingValue.MODIFY(true);

                        //Driver
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Whse. Shipping Driver" >>
                        //BC Upgrade VAMSIU01 Added Driver table, Route.driver >>
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Driver107FDW, UnitTestingValue);
                        if Route.Driver <> '' then
                            UnitTestingValue.VALIDATE(Value, Route.Driver)
                        else
                            UnitTestingValue.VALIDATE(Value, FindDriver());
                        UnitTestingValue.MODIFY(true);
                        //BC Upgrade VAMSIU01 Added Driver table, Route.driver <<
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Whse. Shipping Driver" <<

                        //Truck
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Whse. Shipping Truck" >>
                        // //BC Upgrade VAMSIU01 Added Vehicle table, Route.Vehicle >>
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Vehicle101FDW, UnitTestingValue);
                        if Route.Vehicle <> '' then
                            UnitTestingValue.VALIDATE(Value, Route.Vehicle)
                        else
                            UnitTestingValue.VALIDATE(Value, FindTruck());
                        UnitTestingValue.MODIFY(true);
                        //BC Upgrade VAMSIU01 Added Vehicle table, Route.Vehicle >>
                        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT Table-"Whse. Shipping Truck" <<
                    end;
                end;
        //HEI.15>>

        //To be continued...

        end;
        //HEI.32>>
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Table ID", DATABASE::"Shipping Agent");
        UnitTestingValue.SETRANGE(Value, '');
        ShippingAgent.RESET();
        if ShippingAgent.FINDFIRST() then//HEI.33
            UnitTestingValue.MODIFYALL(Value, ShippingAgent.Code);//HEI.33
        UnitTestingValue.RESET();
        UnitTestingValue.SETRANGE("Table ID", DATABASE::"Shipping Agent Services");
        UnitTestingValue.SETRANGE(Value, '');
        ShippingAgentServices.RESET();
        if ShippingAgentServices.FINDFIRST() then//HEI.33
            UnitTestingValue.MODIFYALL(Value, ShippingAgentServices.Code);//HEI.33
                                                                          //HEI.32<<
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

    local procedure FindCustomer(): Code[20];
    var
        Customer: Record Customer;
        BillToCustomer: Record Customer;
        BillToCustFound: Boolean;
    begin
        BillToCustFound := false;
        BillToCustomer.CALCFIELDS("Flag for Deletion FND");
        BillToCustomer.SETRANGE("Flag for Deletion FND", false);
        BillToCustomer.SETRANGE("Account Group FND", 'Y001');
        //HEI.29>>
        if COMPANYNAME in ['Tango', '10_BUKAVU'] then //HEI.35>>
            BillToCustomer.SETRANGE("Customer Posting Group", '3PC-TRADE');
        //HEI.29<<
        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Customer Table for-"Credit Limit","Deposit Limit","Sundry Customer" >>
        // BillToCustomer.SETRANGE("Credit Limit", false);
        // BillToCustomer.SETRANGE("Deposit Limit", false);
        BillToCustomer.SETRANGE("CM Credit Limit (Yes/No) APS", false);//BC Upgrade VAMSIU01 added
        BillToCustomer.SETRANGE("CM EG Limit (Yes/No) APS", false);//BC Upgrade VAMSIU01 added
        // BillToCustomer.SETRANGE("Sundry Customer", false);
        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Customer Table for-"Credit Limit","Deposit Limit","Sundry Customer" <<
        BillToCustomer.SETRANGE("Additional RPM Return FND", true);
        BillToCustomer.SETFILTER(Blocked, '<>%1&<>%2', BillToCustomer.Blocked::All, BillToCustomer.Blocked::Invoice);
        if BillToCustomer.FINDSET() then
            repeat
                BillToCustFound := FindSellToCustomer(BillToCustomer."No.", Customer);
            until (BillToCustomer.NEXT() = 0) or BillToCustFound;

        if Customer."No." = '' then begin
            //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Customer Table for-"Deposit Limit" >>
            // BillToCustomer.SETRANGE("Deposit Limit");
            BillToCustomer.SETRANGE("CM EG Limit (Yes/No) APS");
            if BillToCustomer.FINDSET() then
                repeat
                    BillToCustFound := FindSellToCustomer(BillToCustomer."No.", Customer);
                until (BillToCustomer.NEXT() = 0) or BillToCustFound;
            //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Customer Table for-"Deposit Limit" <<
        end;

        if Customer."No." = '' then begin
            BillToCustomer.SETRANGE("Additional RPM Return FND");
            if BillToCustomer.FINDSET() then
                repeat
                    BillToCustFound := FindSellToCustomer(BillToCustomer."No.", Customer);
                until (BillToCustomer.NEXT() = 0) or BillToCustFound;
        end;

        if Customer."No." = '' then begin
            //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Customer Table for-"Credit Limit", "Deposit Limit (LCY)" >>
            //BillToCustomer.SETRANGE("Credit Limit");
            BillToCustomer.SETRANGE("CM Credit Limit (Yes/No) APS");//BC Upgrade VAMSIU01 added
            BillToCustomer.SETFILTER("Credit Limit (LCY)", '>%1', 1000);
            //BillToCustomer.SETFILTER("Deposit Limit (LCY)", '>%1', 1000);
            BillToCustomer.SETFILTER("CM Empty Good Limit (LCY) APS", '>%1', 1000);//BC Upgrade VAMSIU01 added
            if BillToCustomer.FINDSET() then
                repeat
                    BillToCustFound := FindSellToCustomer(BillToCustomer."No.", Customer);
                until (BillToCustomer.NEXT() = 0) or BillToCustFound;
            //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Customer Table for-"Credit Limit", "Deposit Limit (LCY)" <<
        end;

        if Customer."No." = '' then begin
            //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Customer Table for-"Deposit Limit (LCY)" >>
            // BillToCustomer.SETRANGE("Deposit Limit (LCY)");
            BillToCustomer.SETRANGE("CM Empty Good Limit (LCY) APS");//BC Upgrade VAMSIU01 added
            if BillToCustomer.FINDSET() then
                repeat
                    BillToCustFound := FindSellToCustomer(BillToCustomer."No.", Customer);
                until (BillToCustomer.NEXT() = 0) or BillToCustFound;
            //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Customer Table for-"Deposit Limit (LCY)" <<
        end;

        if Customer."No." = '' then begin
            //BillToCustomer.SETRANGE("Credit Limit", true); //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Customer Table for-"Credit Limit"
            BillToCustomer.SETRANGE("CM Credit Limit (Yes/No) APS", true); //BC Upgrade VAMSIU01 added
            BillToCustomer.SETFILTER("Credit Limit (LCY)", '%1|%2', 0, 0.01);
            if BillToCustomer.FINDSET() then
                repeat
                    BillToCustFound := FindSellToCustomer(BillToCustomer."No.", Customer);
                until (BillToCustomer.NEXT() = 0) or BillToCustFound;
        end;

        if Customer."No." = '' then
            BillToCustFound := FindSellToCustomer('', Customer);

        exit(Customer."No.");
    end;

    local procedure FindSellToCustomer(BillToCustNo: Code[20]; var Customer: Record Customer): Boolean;
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        BillToCustFound: Boolean;
        SalesShipmentLine: Record "Sales Shipment Line";
    begin
        Customer.RESET();
        CustLedgerEntry.RESET();
        CustLedgerEntry.SETRANGE("Customer No.", BillToCustNo);
        //CustLedgerEntry.SETFILTER("Item Charge Type", '<>%1', CustLedgerEntry."Item Charge Type"::Deposit);   //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Cust. Ledger Entry Table for-"Item Charge Type"
        // CustLedgerEntry.SETFILTER("Item Charge Type", '<>%1', CustLedgerEntry."Item Charge Type"::Deposit);  
        CustLedgerEntry.SETFILTER("Due Date", '<%1', TODAY);
        CustLedgerEntry.SETFILTER("Remaining Amount", '>%1', 0);
        if not CustLedgerEntry.FINDFIRST() then begin
            Customer.SETRANGE("Bill-to Customer No.", BillToCustNo);
            Customer.CALCFIELDS("Flag for Deletion FND");
            Customer.SETRANGE("Flag for Deletion FND", false);
            Customer.SETFILTER("Account Group FND", '%1|%2', 'Y002', 'Y010');
            Customer.SETFILTER(Blocked, '<>%1&<>%2', Customer.Blocked::Ship, Customer.Blocked::All);
            Customer.SETRANGE("Min. Order Value Limit FND", 0);
            //Customer.SETRANGE("Sundry Customer", false);  //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in table Customer for "Sundry Customer"
            //HEI.42>>
            //Customer.SETFILTER("Invoice Method", '<>%1&<>%2', Customer."Invoice Method"::"Combine Shipments", Customer."Invoice Method"::"Combine Shipments Per Sell-to");  //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in table Customer for "Invoice Method"
            Customer.SETFILTER("Contract Type FND", '<>%1&<>%2', Customer."Contract Type FND"::"CTS Only", Customer."Contract Type FND"::"Full Contract");
            //HEI.42<<
            //HEI.18>>
            if FirstCustomerNo <> '' then
                Customer.SETFILTER("No.", '<>%1', FirstCustomerNo);
            //HEI.18<<
            if Customer.FINDFIRST() then begin
                SalesShipmentLine.SETRANGE("Sell-to Customer No.", Customer."No.");
                SalesShipmentLine.SETRANGE(Type, 2);
                SalesShipmentLine.SETRANGE(Correction, false);
                SalesShipmentLine.SETRANGE("Job No.", '');
                SalesShipmentLine.SETFILTER(Quantity, '<>%1', 0);
                if SalesShipmentLine.FINDFIRST() then
                    //HEI.34>>
                    BillToCustFound := true
                else if COMPANYNAME = 'Brasco' then
                    BillToCustFound := true;
                //HEI.34<<
            end;
        end;

        if not BillToCustFound then
            CLEAR(Customer);

        if BillToCustNo = '' then begin
            Customer.CALCFIELDS("Flag for Deletion FND");
            Customer.SETRANGE("Flag for Deletion FND", false);
            Customer.SETRANGE("Account Group FND", 'Y006');
            Customer.SETFILTER(Blocked, '<>%1&<>%2', Customer.Blocked::Ship, Customer.Blocked::All);
            Customer.SETRANGE("Min. Order Value Limit FND", 0);
            //Customer.SETRANGE("Sundry Customer", false);  //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in table Customer for "Sundry Customer"
            //HEI.42>>
            //Customer.SETFILTER("Invoice Method", '<>%1&<>%2', Customer."Invoice Method"::"Combine Shipments", Customer."Invoice Method"::"Combine Shipments Per Sell-to");  //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in table Customer for "Invoice Method"
            Customer.SETFILTER("Contract Type FND", '<>%1&<>%2', Customer."Contract Type FND"::"CTS Only", Customer."Contract Type FND"::"Full Contract");
            //HEI.42<<
            if Customer.FINDFIRST() then begin
                SalesShipmentLine.SETRANGE("Sell-to Customer No.", Customer."No.");
                SalesShipmentLine.SETRANGE(Type, 2);
                SalesShipmentLine.SETRANGE(Correction, false);
                SalesShipmentLine.SETRANGE("Job No.", '');
                SalesShipmentLine.SETFILTER(Quantity, '<>%1', 0);
                if SalesShipmentLine.FINDFIRST() then
                    BillToCustFound := true;
            end;
        end;

        exit(BillToCustFound);
    end;

    local procedure FindFreeCustomer(): Code[20];
    var
        Customer: Record Customer;
        BillToCustomer: Record Customer;
        BillToCustFound: Boolean;
    begin
        BillToCustFound := false;
        BillToCustomer.CALCFIELDS("Flag for Deletion FND");
        BillToCustomer.SETRANGE("Flag for Deletion FND", false);
        BillToCustomer.SETRANGE("Account Group FND", 'Y001');
        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Customer Table for-"Credit Limit","Deposit Limit","Sundry Customer" >>
        //BC Upgrade VAMSIU01 Replaced field >>
        // BillToCustomer.SETRANGE("Credit Limit", false);
        // BillToCustomer.SETRANGE("Deposit Limit", false);
        // BillToCustomer.SETRANGE("Sundry Customer", false);
        BillToCustomer.SetRange("CM Credit Limit (Yes/No) APS", false);
        BillToCustomer.SetRange("CM EG Limit (Yes/No) APS", false);
        //BC Upgrade VAMSIU01 Replaced field <<
        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Customer Table for-"Credit Limit","Deposit Limit","Sundry Customer" <<
        BillToCustomer.SETRANGE("Additional RPM Return FND", true);
        //BillToCustomer.SETFILTER("Gen. Bus. Posting Free Group", '<>%1', ''); //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Customer Table for-"Gen. Bus. Posting Free Group"
        //BillToCustomer.SETFILTER("Deposit Item Balance (LCY)",'>%1',100);
        BillToCustomer.SETFILTER(Blocked, '<>%1&<>%2', BillToCustomer.Blocked::All, BillToCustomer.Blocked::Invoice);
        if BillToCustomer.FINDSET() then
            repeat
                BillToCustFound := FindSellToCustomer(BillToCustomer."No.", Customer);
            until (BillToCustomer.NEXT() = 0) or BillToCustFound;

        if Customer."No." = '' then begin
            //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Customer Table for-"Deposit Limit" >>
            //BC Upgrade VAMSIU01 Replaced field
            BillToCustomer.SETRANGE("CM EG Limit (Yes/No) APS");
            if BillToCustomer.FINDSET() then
                repeat
                    BillToCustFound := FindSellToCustomer(BillToCustomer."No.", Customer);
                until (BillToCustomer.NEXT() = 0) or BillToCustFound;
            //BC Upgrade VAMSIU01 Replaced field
            //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Customer Table for-"Deposit Limit" <<
        end;

        if Customer."No." = '' then begin
            BillToCustomer.SETRANGE("Additional RPM Return FND");
            if BillToCustomer.FINDSET() then
                repeat
                    BillToCustFound := FindSellToCustomer(BillToCustomer."No.", Customer);
                until (BillToCustomer.NEXT() = 0) or BillToCustFound;
        end;

        if Customer."No." = '' then begin
            //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Customer Table for-"Credit Limit","Deposit Limit (LCY)" >>
            //BC Upgrade VAMSIU01 Replaced fields >>
            //BillToCustomer.SETRANGE("Credit Limit");
            BillToCustomer.SETRANGE("CM Credit Limit (Yes/No) APS");
            BillToCustomer.SETFILTER("Credit Limit (LCY)", '>%1', 1000);
            //BillToCustomer.SETFILTER("Deposit Limit (LCY)", '>%1', 1000);
            BillToCustomer.SETFILTER("CM Empty Good Limit (LCY) APS", '>%1', 1000);
            //BC Upgrade VAMSIU01 Replaced fields <<
            //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Customer Table for-"Credit Limit","Deposit Limit (LCY)" <<
            if BillToCustomer.FINDSET() then
                repeat
                    BillToCustFound := FindSellToCustomer(BillToCustomer."No.", Customer);
                until (BillToCustomer.NEXT() = 0) or BillToCustFound;
        end;

        if Customer."No." = '' then begin
            //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Customer Table for-"Deposit Limit (LCY)" >>
            //BC Upgrade VAMSIU01 Replaced fields >>
            BillToCustomer.SETRANGE("Additional RPM Return FND", true);
            //BillToCustomer.SETRANGE("Additional RPM Return");
            if BillToCustomer.FINDSET() then
                repeat
                    BillToCustFound := FindSellToCustomer(BillToCustomer."No.", Customer);
                until (BillToCustomer.NEXT() = 0) or BillToCustFound;
            //BC Upgrade VAMSIU01 Replaced fields <<
            //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Customer Table for-"Deposit Limit (LCY)" <<
        end;

        if Customer."No." = '' then begin
            BillToCustomer.SETRANGE("CM Credit Limit (Yes/No) APS", true); //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Customer Table for-"Credit Limit" >>
            BillToCustomer.SETFILTER("Credit Limit (LCY)", '%1|%2', 0, 0.01);
            if BillToCustomer.FINDSET() then
                repeat
                    BillToCustFound := FindSellToCustomer(BillToCustomer."No.", Customer);
                until (BillToCustomer.NEXT() = 0) or BillToCustFound;
        end;

        if Customer."No." = '' then
            BillToCustFound := FindSellToCustomer('', Customer);

        exit(Customer."No.");
    end;

    local procedure FindItemWithLotAndInventory(ItemCategoryCode: Code[10]; var LocationCode: Code[10]; var LotNo: Code[20]; var ZoneCode: Code[10]; var BinCode: Code[10]; ItemTrackCode: Code[10]) ItemNo: Code[20];
    begin
        ItemNo := '';
        ItemNo := FindItem(ItemCategoryCode, LocationCode, LotNo, ZoneCode, BinCode, true, ItemTrackCode);
        if ItemNo = '' then
            ItemNo := FindItem(ItemCategoryCode, LocationCode, LotNo, ZoneCode, BinCode, false, ItemTrackCode);

        //HEI.25>>
        if (ItemNo = '') and
           (ItemCategoryCode <> '07') and
           (ItemTrackCode <> 'LOTTALL')
        then
            ItemNo := FindItem('07', LocationCode, LotNo, ZoneCode, BinCode, false, 'LOTALL');
        //HEI.25<<

        exit(ItemNo);
    end;

    local procedure FindItem(ItemCategoryCode: Code[10]; var LocationCode: Code[10]; var LotNo: Code[20]; var ZoneCode: Code[10]; var BinCode: Code[20]; WithExpirationDate: Boolean; ItemTrackCode: Code[10]) ItemNo: Code[20];
    var
        Item: Record Item;
        AvailabletoPromise: Codeunit "Available to Promise";
        BinContent: Record "Bin Content";
        Zone: Record Zone;
    begin
        if FirstItemNo <> '' then
            Item.SETFILTER("No.", '<>%1', FirstItemNo);
        Item.SETRANGE(Type, Item.Type::Inventory);
        Item.SETRANGE("Item Category Code", ItemCategoryCode);
        Item.SETFILTER(Inventory, '>%1', 100);
        Item.SETRANGE("Item Tracking Code", ItemTrackCode);
        Item.SETRANGE(Blocked, false); //HEI.37
        if Item.FINDSET() then
            repeat
                //Check inventory
                if (AvailabletoPromise.CalcAvailableInventory(Item) +
                   (AvailabletoPromise.CalcScheduledReceipt(Item) - AvailabletoPromise.CalcReservedReceipt(Item)) -
                   (AvailabletoPromise.CalcGrossRequirement(Item) - AvailabletoPromise.CalcReservedRequirement(Item))) > 100
                then begin
                    //Check Bin Content
                    BinContent.RESET();
                    BinContent.SETAUTOCALCFIELDS(Quantity);
                    BinContent.SETRANGE("Item No.", Item."No.");
                    BinContent.SETFILTER(Quantity, '>%1', 100);
                    if BinContent.FINDSET() then
                        repeat
                            //HEI.13>>
                            if Zone.GET(BinContent."Location Code", BinContent."Zone Code") then begin
                                if not Zone."Use As In-Transit FND" then begin
                                    //HEI.13<<
                                    ItemNo := FindLotNo(Item, BinContent, LotNo, WithExpirationDate);
                                    if ItemNo <> '' then begin
                                        LocationCode := BinContent."Location Code";
                                        ZoneCode := BinContent."Zone Code";
                                        BinCode := BinContent."Bin Code";
                                    end;
                                end;
                            end; //HEI.13
                        until (BinContent.NEXT() = 0) or (ItemNo <> '');
                end;
            until (Item.NEXT() = 0) or (ItemNo <> '');

        exit(ItemNo);
    end;

    local procedure FindLotNo(Item: Record Item; BinContent: Record "Bin Content"; var LotNo: Code[20]; WithExpirationDate: Boolean) ItemNo: Code[20];
    var
        LotNoInformation: Record "Lot No. Information";
        ItemFound: Boolean;
        BinContent2: Record "Bin Content";
    begin
        //Check Lot No
        LotNoInformation.RESET();
        LotNoInformation.SETAUTOCALCFIELDS(Inventory);
        LotNoInformation.SETRANGE("Item No.", Item."No.");
        LotNoInformation.SETRANGE(Blocked, false);
        LotNoInformation.SETFILTER(Inventory, '>%1', 100);
        if WithExpirationDate then
            //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Lot No. Information Table for-"Expiration Date" >>
            //BC Upgrade VAMSIU01 Replaced Expiration Date >>
            LotNoInformation.SETFILTER("Expiration Date 101FDW", '>%1', WORKDATE())
        else
            LotNoInformation.SETRANGE("Expiration Date 101FDW", 0D);
        //BC Upgrade VAMSIU01 Replaced Expiration Date >>
        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Lot No. Information Table for-"Expiration Date" <<
        if LotNoInformation.FINDFIRST() then begin
            BinContent2.RESET();
            BinContent2.SETRANGE("Item No.", LotNoInformation."Item No.");
            BinContent2.SETRANGE("Location Code", BinContent."Location Code");
            BinContent2.SETRANGE("Bin Code", BinContent."Bin Code");
            BinContent2.SETRANGE("Lot No. Filter", LotNoInformation."Lot No."); //HEI.06
            if BinContent2.FINDSET() then
                repeat
                    BinContent2.CALCFIELDS(Quantity);
                    if BinContent2.Quantity > 100 then begin
                        ItemFound := true;
                        ItemNo := LotNoInformation."Item No.";
                        LotNo := LotNoInformation."Lot No.";
                    end;
                until (BinContent2.NEXT() = 0) or ItemFound;
        end;
    end;

    local procedure FindRPMItem(ItemCategoryCode: Code[10]; var LocationCode: Code[10]; var ZoneCode: Code[20]; var BinCode: Code[20]) ItemNo: Code[20];
    var
        Item: Record Item;
        ItemFound: Boolean;
        BinContent: Record "Bin Content";
        Zone: Record Zone;
    begin
        ItemFound := false;
        Item.SETAUTOCALCFIELDS(Inventory, "Qty. on Sales Order");
        Item.SETRANGE(Type, Item.Type::Inventory);
        Item.SETRANGE("Item Category Code", ItemCategoryCode);
        Item.SETFILTER(Inventory, '>%1', 100);
        Item.SETRANGE("Item Tracking Code", '');
        Item.SETRANGE(Blocked, false); //HEI.37
        if Item.FINDSET() then
            repeat
                if Item.Inventory - Item."Qty. on Sales Order" > 100 then begin
                    //Check Bin Content
                    BinContent.RESET();
                    BinContent.SETAUTOCALCFIELDS(Quantity);
                    BinContent.SETRANGE("Item No.", Item."No.");
                    BinContent.SETFILTER(Quantity, '>%1', 100);
                    if BinContent.FINDSET() then
                        repeat
                            if Zone.GET(BinContent."Location Code", BinContent."Zone Code") then
                                if Zone."Use As In-Transit FND" then
                                    ItemFound := false
                                else begin
                                    ItemFound := true;
                                    ItemNo := Item."No.";
                                    LocationCode := BinContent."Location Code";
                                    ZoneCode := BinContent."Zone Code";
                                    BinCode := BinContent."Bin Code";
                                end;
                        until (BinContent.NEXT() = 0) or ItemFound;
                end;
            until (Item.NEXT() = 0) or ItemFound;

        exit(ItemNo);
    end;

    local procedure FindEmptyItem() ItemNo: Code[20];
    var
        Item: Record Item;
        ItemFound: Boolean;
    begin
        ItemFound := false;
        Item.SETAUTOCALCFIELDS(Inventory, "Qty. on Sales Order");
        Item.SETRANGE(Type, Item.Type::Inventory);
        //Item.SETRANGE("Empty Good", true);  //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Item Table for-"Empty Good"
        Item.SETFILTER(Inventory, '>%1', 100);
        Item.SETRANGE("Item Tracking Code", '');
        Item.SETRANGE(Blocked, false); //HEI.37
        if Item.FINDSET() then
            repeat
                if Item.Inventory - Item."Qty. on Sales Order" > 100 then begin
                    ItemFound := true;
                    ItemNo := Item."No.";
                end;
            until (Item.NEXT() = 0) or ItemFound;

        exit(ItemNo);
    end;

    local procedure FindLocation(GateControl: Boolean): Code[10];
    var
        Location: Record Location;
    begin
        Location.SETRANGE("Require Shipment", true);
        Location.SETRANGE("Require Receive", true);
        Location.SETRANGE("Bin Mandatory", true);
        //HEI.02>>
        if (LocationFrom <> '') or (LocationTo <> '') then
            Location.SETFILTER(Code, '<>%1&<>%2', LocationFrom, LocationTo);
        //HEI.02<<

        if GateControl then begin
            //If not all below values are mandatory create parameter for them to be checked
            Location.SETRANGE("Purchase Gate Entry Mandat FND", true);
            Location.SETRANGE("Sales Gate Entry Mandatory FND", true);
            Location.SETRANGE("Transfer Gate Entry Mandat FND", true);
            Location.SETRANGE("Gate Weighing Mandatory FND", true);
            Location.SETRANGE("InBound Auto Registration FND", true);
            Location.SETRANGE("Enable Inbound Validation FND", true);
        end;

        if Location.FINDFIRST() then
            exit(Location.Code);
    end;

    local procedure FindInTransitLocation(GateControl: Boolean): Code[10];
    var
        Location: Record Location;
    begin
        //HEI.02>>
        Location.SETRANGE("Use As In-Transit", true);
        if Location.FINDFIRST() then
            exit(Location.Code);
        //HEI.02<<
    end;

    //BC Upgrade KAPOOV01 Commented-procedure FindRoute dependent on DRINK-IT Table-Route >>
    //BC Upgrade VAMSIU01 Replaced tables >>
    //# Route->Route107FDW

    local procedure FindRoute(LocationCode: Code[10]): Code[20];
    var
        //Route: Record Route;
        Route: Record Route107FDW;//BC UPGRADE VAMSIU01 Added Route table.
        RouteFound: Boolean;
    begin
        // Route.SETRANGE("Location Code", LocationCode);
        // Route.SETRANGE("Return Control Route", Route."Return Control Route"::None);
        Route.SetRange("Shipping Location", LocationCode);//BC UPGRADE VAMSIU01 Added

        if Route.FINDSET then
            repeat
                RouteFound := FindRouteDetails(Route);
            until (Route.NEXT = 0) or RouteFound;

        if Route.Code = '' then begin
            //HEI.08>>
            //Route.SETRANGE("Location Code");
            //Route.SETRANGE("Location Code", '');//BC Upgrade VAMSIU01
            Route.SETRANGE("Shipping Location", '');//BC Upgrade VAMSIU01
            //HEI.08<<
            if Route.FINDSET then
                repeat
                    RouteFound := FindRouteDetails(Route);
                until (Route.NEXT = 0) or RouteFound;
        end;

        //HEI.19>>
        if Route.Code = '' then begin
            Route.RESET;
            if Route.FINDSET then
                repeat
                    RouteFound := FindRouteDetails(Route);
                until (Route.NEXT = 0) or RouteFound;
        end;
        //HEI.19<<

        exit(Route.Code);
    end;
    //BC Upgrade KAPOOV01 Commented-procedure FindRoute dependent on DRINK-IT Table-Route <<

    //BC Upgrade KAPOOV01 Commented procedure FindRouteDetails taking DRINK-IT Table-Route as Paramter >>
    //BC Upgrade VAMSIU01 Replaced tables >>
    //# Route->Route107FDW
    //# Whse. Shipping Truck->Vehicle101FDW
    //# Whse. Shipping Driver->Driver107FDW
    //# fields Driver Code to Driver and Truck code to Vehicle>>
    local procedure FindRouteDetails(Route: Record Route107FDW): Boolean;
    var
        // Truck: Record "Whse. Shipping Truck";
        // Driver: Record "Whse. Shipping Driver";
        Truck: Record Vehicle101FDW;
        Driver: Record Driver107FDW;
        TruckFound: Boolean;
        DriverFound: Boolean;
        RouteFound: Boolean;
    begin
        if Route.Vehicle <> '' then begin
            if Truck.GET(Route.Vehicle) then
                TruckFound := true;
        end else
            TruckFound := true;

        if Route.Driver <> '' then begin
            if Driver.GET(Route.Driver) then
                DriverFound := true;
        end else
            DriverFound := true;

        if TruckFound and DriverFound then
            RouteFound := true;

        exit(RouteFound);
    end;
    //BC Upgrade KAPOOV01 Commented procedure FindRouteDetails taking DRINK-IT Table-Route as Paramter <<

    //BC Upgrade KAPOOV01 Commented procedure FindItemCharge as it depends on DRINK-IT field-Item Charge Type of table -Item Charge >>
    local procedure FindItemCharge(ItemChargeType: Integer): Code[20];
    var
        ItemCharge: Record "Item Charge";
    begin
        // ItemCharge.SETRANGE("Item Charge Type", ItemChargeType);
        if ItemCharge.FINDFIRST() then
            exit(ItemCharge."No.");
    end;
    //BC Upgrade KAPOOV01 Commented procedure FindItemCharge as it depends on DRINK-IT field-Item Charge Type of table -Item Charge >>

    local procedure FindDimensionValue(DimensionCode: Code[20]): Code[20];
    var
        DimensionValue: Record "Dimension Value";
    begin
        DimensionValue.RESET();
        DimensionValue.SETRANGE("Dimension Code", DimensionCode);
        DimensionValue.SETRANGE(Blocked, false);
        if DimensionValue.FINDFIRST() then
            exit(DimensionValue.Code);
    end;

    local procedure FindReturnReason(): Code[20];
    var
        ReturnReason: Record "Return Reason";
    begin
        ReturnReason.SETRANGE("Blocked FND", false);//HEI.40
        if ReturnReason.FINDFIRST() then
            exit(ReturnReason.Code);
    end;
    //BC Upgrade KAPOOV01 Commented procedure FindDriver based on DRINK-IT Table-"Whse. Shipping Driver" >> 
    local procedure FindDriver(): Code[20];
    var
        //Driver: Record "Whse. Shipping Driver";
        Driver: Record Driver107FDW;
    begin
        if Driver.FINDFIRST then
            exit(Driver.Code);
    end;
    //BC Upgrade KAPOOV01 Commented procedure FindDriver based on DRINK-IT Table-"Whse. Shipping Driver" <<

    //BC Upgrade KAPOOV01 Commented procedure FindTruck() based on DRINK-IT Table-"Whse. Shipping Truck" >>
    local procedure FindTruck(): Code[20];
    var
        //Truck: Record "Whse. Shipping Truck";
        Truck: Record Vehicle101FDW;
    begin
        if Truck.FINDFIRST then
            exit(Truck.Code);
    end;
    //BC Upgrade KAPOOV01 Commented procedure FindTruck() based on DRINK-IT Table-"Whse. Shipping Truck" <<

    local procedure FindShippingAgent(): Code[20];
    var
        ShippingAgent: Record "Shipping Agent";
    begin
        //HEI.02>>
        if ShippingAgent.FINDFIRST() then
            exit(ShippingAgent.Code);
        //HEI.02<<
    end;

    local procedure FindShippingAgService(var ShippAgentCode: Code[20]): Code[20];
    var
        ShippingAgentServices: Record "Shipping Agent Services";
        ShippingAgent: Record "Shipping Agent";
        Vendor: Record Vendor;
    begin
        //ShippingAgentServices.SETFILTER("Shipping Charge No.", '<>%1', ''); //BC Upgrade KAPOOV01 DRINK-IT field-"Shipping Charge No." of Table-"Shipping Agent Services" 
        ShippingAgentServices.SETFILTER("Shipping Agent Code", '<>%1', '');
        //HEI.44>>
        //ShippingAgent.SETFILTER("Vendor No.", '<>%1', ''); //BC Upgrade KAPOOV01 DRINK-IT field-"Vendor No." of Table-"Shipping Agent" 
        if not ShippingAgent.FINDFIRST() then begin     //Executes when the vendor is blank for all records of ShippingAgent
                                                        //HEI.44<<
            if ShippingAgentServices.FINDFIRST() then
                ShippAgentCode := ShippingAgentServices."Shipping Agent Code";

            exit(ShippingAgentServices.Code);
            //HEI.44>>
        end;
        //BC Upgrade KAPOOV01 Code Block dependent on DRINK-IT field-"Vendor No." of Table-"Shipping Agent"  >>
        // if ShippingAgentServices.FINDSET(false, false) then
        //     repeat
        //         ShippingAgent.GET(ShippingAgentServices."Shipping Agent Code");
        //         if Vendor.GET(ShippingAgent."Vendor No.") then begin
        //             if Vendor.Blocked = Vendor.Blocked::" " then begin
        //                 ShippAgentCode := ShippingAgentServices."Shipping Agent Code";
        //                 exit(ShippingAgentServices.Code);
        //             end;
        //         end;
        //     until ShippingAgentServices.NEXT() = 0;
        //BC Upgrade KAPOOV01 Code Block dependent on DRINK-IT field-"Vendor No." of Table-"Shipping Agent"  <<
        //HEI.44<<
    end;
    //BC Upgrade KAPOOV01 DRINK-IT procedure FindFreeReasonCode() dependent on DRINK-IT Table- "Free Reason Code" >>
    local procedure FindFreeReasonCode(): Code[10];
    var
        //FreeReasonCode: Record "Free Reason Code";
        FreeReasonCode: Record "Reason Code";//BC Upgrade VAMSIU01 Added Base Reason Code table.
    begin
        if FreeReasonCode.FINDFIRST then
            exit(FreeReasonCode.Code);
    end;
    //BC Upgrade KAPOOV01 DRINK-IT procedure FindFreeReasonCode() dependent on DRINK-IT Table- "Free Reason Code" <<

    local procedure FindDisputeCategory(): Code[20];
    var
        DisputeCategory: Record "Dispute Category FND";
    begin
        if DisputeCategory.FINDFIRST() then
            exit(DisputeCategory.Code);
    end;

    local procedure FindDisputeReason(DisputeCategoryCode: Code[20]): Code[20];
    var
        DisputeReason: Record "Dispute Reason FND";
    begin
        DisputeReason.SETRANGE("Dispute Category Code", DisputeCategoryCode);
        if DisputeReason.FINDFIRST() then
            exit(DisputeReason.Code);
    end;

    local procedure FindDisputeResolution(): Code[20];
    var
        DisputeResolution: Record "Dispute Resolution FND";
    begin
        if DisputeResolution.FINDFIRST() then
            exit(DisputeResolution.Code);
    end;

    local procedure FindGLAccount() GLAccNo: Code[20];
    var
        GLAccount: Record "G/L Account";
        DefaultDimension: Record "Default Dimension";
        GLAccFound: Boolean;
        DefaultDim: Record "Default Dimension";
    begin
        GLAccount.SETRANGE(Blocked, false);
        GLAccount.SETRANGE("Direct Posting", true);
        GLAccount.SETRANGE("Account Type", GLAccount."Account Type"::Posting);
        GLAccount.SETRANGE("Income/Balance", GLAccount."Income/Balance"::"Balance Sheet");
        GLAccount.SETRANGE("Account Category", GLAccount."Account Category"::Assets);
        GLAccount.SETRANGE("Gen. Prod. Posting Group", '');
        GLAccount.SETRANGE("VAT Prod. Posting Group", '');
        if GLAccount.FINDFIRST() then
            repeat
                //HEI.41>>
                DefaultDim.RESET();
                DefaultDim.SETCURRENTKEY("Table ID", "No.");
                DefaultDim.SETRANGE("Table ID", 15);
                DefaultDim.SETRANGE("No.", GLAccount."No.");
                DefaultDim.SETRANGE("Value Posting", DefaultDim."Value Posting"::"Code Mandatory");
                if DefaultDim.FINDFIRST() then begin
                    DefaultDim."Value Posting" := DefaultDim."Value Posting"::" ";
                    DefaultDim.MODIFY();
                end;
                //HEI.41<<
                DefaultDimension.RESET();
                DefaultDimension.SETRANGE("Table ID", 15);
                DefaultDimension.SETRANGE("No.", GLAccount."No.");
                DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
                if not DefaultDimension.FINDFIRST() then begin
                    GLAccFound := true;
                    GLAccNo := GLAccount."No.";
                end;
            until (GLAccount.NEXT() = 0) or GLAccFound;

        exit(GLAccNo);
    end;

    local procedure FindCashRcptJournal(): Code[10];
    var
        GenJournalTemplate: Record "Gen. Journal Template";
    begin
        GenJournalTemplate.SETRANGE(Type, GenJournalTemplate.Type::"Cash Receipts");
        //GenJournalTemplate.SETRANGE("SO Cash Application",FALSE);
        if GenJournalTemplate.FINDFIRST() then
            exit(GenJournalTemplate.Name);
    end;

    local procedure FindCashRcptBatch(JournalTemplateName: Code[10]): Code[10];
    var
        GenJournalBatch: Record "Gen. Journal Batch";
    begin
        GenJournalBatch.SETRANGE("Journal Template Name", JournalTemplateName);
        if GenJournalBatch.FINDFIRST() then
            exit(GenJournalBatch.Name);
    end;

    local procedure FindPaymentMethod(): Code[10];
    var
        PaymentMethod: Record "Payment Method";
    begin
        if PaymentMethod.FINDFIRST() then
            exit(PaymentMethod.Code);
    end;

    local procedure FindZone(LocationCode: Code[10]): Code[10];
    var
        Zone: Record Zone;
    begin
        Zone.SETRANGE("Location Code", LocationCode);
        Zone.SETRANGE("Use As In-Transit FND", false);
        if Zone.FINDFIRST() then
            exit(Zone.Code);
    end;

    local procedure FindBin(LocationCode: Code[10]; ItemNo: Code[20]; ZoneCode: Code[10]): Code[20];
    var
        BinContent: Record "Bin Content";
    begin
        BinContent.SETAUTOCALCFIELDS(Quantity);
        BinContent.SETRANGE("Location Code", LocationCode);
        BinContent.SETRANGE("Item No.", ItemNo);
        BinContent.SETRANGE("Zone Code", ZoneCode);
        BinContent.SETFILTER(Quantity, '>%1', 1000);
        if BinContent.FINDFIRST() then
            exit(BinContent."Bin Code");
    end;

    //BC Upgrade KAPOOV01 DRINK-IT procedure FindDepositGroup() dependent on DRINK-IT Table- "Drink Deposit Group" >>
    local procedure FindDepositGroup(): Code[10];
    var
        //DrinkDepositGroup: Record "Drink Deposit Group";
        DrinkDepositGroup: Record BusinessGroup104FDW;
    begin
        // DrinkDepositGroup.SETRANGE("Source Type", DrinkDepositGroup."Source Type"::Item);
        if DrinkDepositGroup.FINDFIRST then
            exit(DrinkDepositGroup.Code);
    end;
    //BC Upgrade KAPOOV01 DRINK-IT procedure FindDepositGroup() dependent on DRINK-IT Table- "Drink Deposit Group" <<
    local procedure FindLotNoInformation(ItemNo: Code[20]): Code[20];
    var
        LotNoInformation: Record "Lot No. Information";
    begin
        //HEI.02>>
        LotNoInformation.SETRANGE("Item No.", ItemNo);
        LotNoInformation.SETRANGE(Blocked, false);
        LotNoInformation.SETFILTER("Lot No.", '<>%1', '');
        // LotNoInformation.SETFILTER("Expiration Date", '>%1', WORKDATE()); //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Lot No. Information Table for-"Expiration Date" >>	
        LotNoInformation.SETFILTER("Expiration Date 101FDW", '>%1', WORKDATE());//BC Upgrade VAMSIU01 Replaced Exipration Date field
        if LotNoInformation.FINDFIRST() then
            exit(LotNoInformation."Lot No.")
        else begin
            //LotNoInformation.SETRANGE("Expiration Date"); //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields defined in Lot No. Information Table for-"Expiration Date" >>	
            LotNoInformation.SETRANGE("Expiration Date 101FDW");//BC Upgrade VAMSIU01 Replaced Exipration Date field
            if LotNoInformation.FINDFIRST() then
                exit(LotNoInformation."Lot No.")
            else
                exit('DUMMY');
        end;
        //HEI.02<<
    end;

    local procedure FindResource(GenBusPostGroup: Code[10]; VATBusPostGroup: Code[10]) ResourceNo: Code[20];
    var
        Resource: Record Resource;
        GeneralPostingSetup: Record "General Posting Setup";
        ResourceFound: Boolean;
        ResourceUnitofMeasure: Record "Resource Unit of Measure";
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        //HEI.02>>
        Resource.SETRANGE(Blocked, false);
        if Resource.FINDSET() then
            repeat
                if GeneralPostingSetup.GET(GenBusPostGroup, Resource."Gen. Prod. Posting Group") and
                   (GeneralPostingSetup."Sales Credit Memo Account" <> '') and
                   VATPostingSetup.GET(VATBusPostGroup, Resource."VAT Prod. Posting Group")
                then begin
                    if ResourceUnitofMeasure.GET(Resource."No.", Resource."Base Unit of Measure") then begin
                        ResourceFound := true;
                        ResourceNo := Resource."No.";
                    end;
                end;
            until (Resource.NEXT() = 0) or ResourceFound;
        //HEI.02<<
    end;

    local procedure FindCCCDimensionValue(GenBusPostGroup: Code[10]; ResourceNo: Code[20]) CCCDimValue: Code[20];
    var
        GeneralPostingSetup: Record "General Posting Setup";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Resource: Record Resource;
        DimensionValue: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        CCCFound: Boolean;
        DefaultDimension: Record "Default Dimension";
    begin
        //HEI.02>>
        GeneralLedgerSetup.GET();
        Resource.GET(ResourceNo);
        GeneralPostingSetup.GET(GenBusPostGroup, Resource."Gen. Prod. Posting Group");
        DefaultDimension.SETRANGE("Table ID", 15);
        DefaultDimension.SETRANGE("No.", GeneralPostingSetup."Sales Credit Memo Account");
        DefaultDimension.SETRANGE("Dimension Code", GeneralLedgerSetup."Cost Center Dimension Code FND");
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Same Code");
        if DefaultDimension.FINDFIRST() then begin
            CCCFound := true;
            CCCDimValue := DimensionValue.Code;
        end else begin
            DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
            if DefaultDimension.FINDFIRST() then begin
                DimensionValue.SETRANGE("Dimension Code", GeneralLedgerSetup."Cost Center Dimension Code FND");
                DimensionValue.SETFILTER(Code, '<>%1', '');
                DimensionValue.SETRANGE(Blocked, false);
                if DimensionValue.FINDSET() then
                    repeat
                        EbfCombination.SETRANGE("GL Account No.", GeneralPostingSetup."Sales Credit Memo Account");
                        EbfCombination.SETRANGE("Dimension Code", GeneralLedgerSetup."Cost Center Dimension Code FND");
                        EbfCombination.SETRANGE("Dimension Value Code", DimensionValue.Code);
                        if not EbfCombination.FINDFIRST() then begin
                            CCCFound := true;
                            CCCDimValue := DimensionValue.Code;
                        end;
                    until (DimensionValue.NEXT() = 0) or CCCFound;
            end;
        end;
        //HEI.02<<
    end;

    local procedure FindVendor(GenBusPostGr: Code[10]): Code[20];
    var
        Vendor: Record Vendor;
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        //HEI.04>>
        Vendor.SETRANGE(Blocked, Vendor.Blocked::" ");
        Vendor.SETRANGE("Gen. Bus. Posting Group", GenBusPostGr); //HEI.06
        //HEI.43>>
        PurchSetup.GET();
        Vendor.SETFILTER("Shipment Method Code", PurchSetup."Excluded Incoterms FND");
        //HEI.43<<
        Vendor.SETFILTER("WHT Business Posting Group FND", '<>%1', ''); //HEI.45
        if Vendor.FINDFIRST() then
            exit(Vendor."No.");
        //HEI.04<<
    end;

    local procedure FindNoSeries(): Code[10];
    var
        NoSeries: Record "No. Series";
    begin
        //HEI.06>>
        if NoSeries.FINDFIRST() then
            exit(NoSeries.Code);
        //HEI.06<<
    end;

    local procedure FindCCCDimValue_Item_Purch_Acc(GenBusPostGroup: Code[10]; GenProdPostGroup: Code[10]) CCCDimValue: Code[20];
    var
        GeneralPostingSetup: Record "General Posting Setup";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        CCCFound: Boolean;
        DefaultDimension: Record "Default Dimension";
    begin
        //CCC for Item
        //HEI.06>>
        GeneralLedgerSetup.GET();
        GeneralPostingSetup.GET(GenBusPostGroup, GenProdPostGroup);
        DefaultDimension.SETRANGE("Table ID", 15);
        DefaultDimension.SETRANGE("No.", GeneralPostingSetup."Purch. Account");
        DefaultDimension.SETRANGE("Dimension Code", GeneralLedgerSetup."Cost Center Dimension Code FND");
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Same Code");
        if DefaultDimension.FINDFIRST() then begin
            CCCFound := true;
            CCCDimValue := DimensionValue.Code;
        end else begin
            DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
            if DefaultDimension.FINDFIRST() then begin
                DimensionValue.SETRANGE("Dimension Code", GeneralLedgerSetup."Cost Center Dimension Code FND");
                DimensionValue.SETFILTER(Code, '<>%1', '');
                DimensionValue.SETRANGE(Blocked, false);
                if DimensionValue.FINDSET() then
                    repeat
                        EbfCombination.SETRANGE("GL Account No.", GeneralPostingSetup."Sales Credit Memo Account");
                        EbfCombination.SETRANGE("Dimension Code", GeneralLedgerSetup."Cost Center Dimension Code FND");
                        EbfCombination.SETRANGE("Dimension Value Code", DimensionValue.Code);
                        if not EbfCombination.FINDFIRST() then begin
                            CCCFound := true;
                            CCCDimValue := DimensionValue.Code;
                        end;
                    until (DimensionValue.NEXT() = 0) or CCCFound;
            end;
        end;
        //HEI.06<<
    end;

    local procedure CreateWarehouseEmployeesForUser(UserName: Code[50]; LocationCode: Code[10]; ZoneCode: Code[10]);
    var
        WarehouseEmployee: Record "Warehouse Employee";
        Location: Record Location;
        Zone: Record Zone;
    begin
        //HEI.07>>
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
                                // BC UPGRADE PATELS08 >>
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
        //HEI.07<<
        //HEI.31>>
        //IF COMPANYNAME = 'Bralirwa' THEN BEGIN //HEI.32
        WarehouseEmployee.RESET();
        WarehouseEmployee.SETRANGE("User ID", USERID);
        if WarehouseEmployee.FINDFIRST() then begin
            WarehouseEmployee.Default := true;
            WarehouseEmployee.MODIFY();
        end;
        //END; //HEI.32
        //HEI.31<<
    end;

    local procedure InsertWarehouseEmployee(UserName: Code[50]; LocationCode: Code[10]; ZoneCode: Code[10]);
    var
        WarehouseEmployee: Record "Warehouse Employee";
    begin
        //HEI.07>>
        WarehouseEmployee.INIT();
        WarehouseEmployee.VALIDATE("User ID", UserName);
        WarehouseEmployee.VALIDATE("Location Code", LocationCode);
        WarehouseEmployee.VALIDATE("Zone Code FND", ZoneCode);
        WarehouseEmployee.INSERT(true);
        //HEI.07<<
    end;

    local procedure FindBlockedReason(): Code[20];
    var
        BlockedReason: Record "Blocked Reason FND";
    begin
        //HEI.08>>
        if BlockedReason.FINDFIRST() then
            exit(BlockedReason.Code);
        //HEI.08<<
    end;

    local procedure FindPaymentTerms(): Code[10];
    var
        PaymentTerms: Record "Payment Terms";
    begin
        //HEI.08>>
        if PaymentTerms.FINDFIRST() then
            exit(PaymentTerms.Code);
        //HEI.08<<
    end;

    local procedure FindCustomerPriceGroup(): Code[10];
    var
        CustomerPriceGroup: Record "Customer Price Group";
    begin
        //HEI.08>>
        if CustomerPriceGroup.FINDFIRST() then
            exit(CustomerPriceGroup.Code);
        //HEI.08<<
    end;

    local procedure FindCustomerDiscountGroup(): Code[20];
    var
        CustomerDiscountGroup: Record "Customer Discount Group";
    begin
        //HEI.08>>
        if CustomerDiscountGroup.FINDFIRST() then
            exit(CustomerDiscountGroup.Code);
        //HEI.08<<
    end;

    //BC Upgrade KAPOOV01 Commented procedure FindDrinkDepositGroup() dependent on DRINK-IT Table "Drink Deposit Group" >>
    local procedure FindDrinkDepositGroup(): Code[10];
    var
        //DrinkDepositGroup: Record "Drink Deposit Group";
        DrinkDepositGroup: Record BusinessGroup104FDW;
    begin
        //HEI.08>>
        //DrinkDepositGroup.SETRANGE("Source Type", DrinkDepositGroup."Source Type"::Customer);
        if DrinkDepositGroup.FINDFIRST then
            exit(DrinkDepositGroup.Code);
        //HEI.08<<
    end;
    //BC Upgrade KAPOOV01 Commented procedure FindDrinkDepositGroup() dependent on DRINK-IT Table "Drink Deposit Group" <<

    local procedure FindServiceZone(): Code[10];
    var
        ServiceZone: Record "Service Zone";
    begin
        //HEI.08>>
        if ServiceZone.FINDFIRST() then
            exit(ServiceZone.Code);
        //HEI.08<<
    end;

    local procedure FindPermissionSet(): Code[20];
    var
        PermissionSet: Record "Permission Set";
    begin
        //HEI.08>>
        PermissionSet.SETFILTER("Role ID", '<>%1', '');
        if PermissionSet.FINDFIRST() then
            exit(PermissionSet."Role ID");
        //HEI.08<<
    end;

    local procedure FindShipmentMethod(): Code[10];
    var
        ShipmentMethod: Record "Shipment Method";
    begin
        //HEI.08>>
        if ShipmentMethod.FINDFIRST() then
            exit(ShipmentMethod.Code);
        //HEI.08<<
    end;

    //BC Upgrade KAPOOV01 Commented procedure FindDeliveryType() dependent on DRINK-IT Table "Delivery Type" >>
    local procedure FindDeliveryType(): Code[10];
    var
        //DeliveryType: Record "Delivery Type";
        DeliveryType: Record DeliveryType107FDW;

    begin
        //HEI.08>>
        // DeliveryType.SETRANGE(Type, DeliveryType.Type::Customer);
        if DeliveryType.FINDFIRST then
            exit(DeliveryType.Code);
        //HEI.08<<
    end;
    //BC Upgrade KAPOOV01 Commented procedure FindDeliveryType() dependent on DRINK-IT Table "Delivery Type" <<
    local procedure FindLanguage(): Code[10];
    var
        Language: Record Language;
    begin
        //HEI.08>>
        if Language.FINDFIRST() then
            exit(Language.Code);
        //HEI.08<<
    end;

    //BC Upgrade KAPOOV01 Commented procedure FindTaxOffice DRINK-IT Table-Tax Office >>
    //Bc Upgrade VAMSIU01 Replaced the table Tax office with TaxOffice102FDW,field code with No. >>
    local procedure FindTaxOffice(): Code[10];
    var
        TaxOffice: Record TaxOffice102FDW;
    begin
        //HEI.08>>
        if TaxOffice.FINDFIRST then
            exit(TaxOffice."No.");
        //HEI.08<<
    end;
    //Bc Upgrade VAMSIU01 Replaced the table Tax office with TaxOffice102FDW,field code with No. >>
    //BC Upgrade KAPOOV01 Commented procedure FindTaxOffice DRINK-IT Table-Tax Office <<

    local procedure FindLicenseType(): Code[20];
    var
        LicenseType: Record "License Type FND";
    begin
        //HEI.08>>
        if LicenseType.FINDFIRST() then
            exit(LicenseType.Code);
        //HEI.08<<
    end;

    local procedure FindBusinessSegment(): Code[20];
    var
        BusinessSegment: Record "Business Segment FND";
    begin
        //HEI.08>>
        if BusinessSegment.FINDFIRST() then
            exit(BusinessSegment.Code);
        //HEI.08<<
    end;

    local procedure FindBusinessOrganizationalSegment(): Code[20];
    var
        BusinessOrganizationalSegment: Record "Business Org Segment FND";
    begin
        //HEI.08>>
        if BusinessOrganizationalSegment.FINDFIRST() then
            exit(BusinessOrganizationalSegment.Code);
        //HEI.08<<
    end;

    local procedure FindCustomerType(): Code[20];
    var
        CustomerType: Record "Customer Type FND";
    begin
        //HEI.08>>
        if CustomerType.FINDFIRST() then
            exit(CustomerType.Code);
        //HEI.08<<
    end;

    local procedure FindCustomerSubType(AccountGroupCode: Code[20]): Code[20];
    var
        CustomerSubType: Record "Customer Sub-Type FND";
    begin
        //HEI.08>>
        CustomerSubType.SETRANGE("Account Group", AccountGroupCode);
        if CustomerSubType.FINDFIRST() then
            exit(CustomerSubType.Code);
        //HEI.08<<
    end;

    local procedure FindLocalCustomerSubType(CustSubtypeCode: Code[20]; AccountGroupCode: Code[20]): Code[20];
    var
        LocalCustomerSubType: Record "Local Customer Sub-Type FND";
    begin
        //HEI.08>>
        LocalCustomerSubType.SETRANGE("Global Cust. Sub-Type", CustSubtypeCode);
        LocalCustomerSubType.SETRANGE("Account Group", AccountGroupCode);
        if LocalCustomerSubType.FINDFIRST() then
            exit(LocalCustomerSubType.Code);
        //HEI.08<<
    end;

    local procedure FindItemUnitOfMeasure(ItemNo: Code[20]): Code[10];
    var
        ItemUnitofMeasure: Record "Item Unit of Measure";
    begin
        //HEI.09>>
        ItemUnitofMeasure.SETRANGE("Item No.", ItemNo);
        if ItemUnitofMeasure.FINDFIRST() then
            exit(ItemUnitofMeasure.Code);
        //HEI.09<<
    end;

    local procedure FindRiskScore(): Integer;
    var
        RiskScore: Record "Risk Score FND";
    begin
        //HEI.09>>
        RiskScore.SETFILTER(Code, '<>%1', 0);
        if RiskScore.FINDFIRST() then
            exit(RiskScore.Code);
        //HEI.09<<
    end;

    local procedure FindCustomerPostingGroup(): Code[10];
    var
        CustomerPostingGroup: Record "Customer Posting Group";
    begin
        //HEI.11>>
        if CustomerPostingGroup.FINDFIRST() then
            exit(CustomerPostingGroup.Code);
        //HEI.11<<
    end;

    local procedure FindPostCode(): Code[20];
    var
        PostCode: Record "Post Code";
    begin
        //HEI.11>>
        if PostCode.FINDFIRST() then
            exit(PostCode.Code);
        //HEI.11<<
    end;

    local procedure FindMarketType(): Code[20];
    var
        MarketType: Record "Market Type FND";
    begin
        //HEI.11>>
        if MarketType.FINDFIRST() then
            exit(MarketType.Code);
        //HEI.11<<
    end;

    local procedure FindLegalEntity(): Code[20];
    var
        LegalForm: Record "Legal Form FND";
    begin
        //HEI.11>>
        if LegalForm.FINDFIRST() then
            exit(LegalForm.Code);
        //HEI.11<<
    end;

    local procedure FindGenBusPostingGroup(): Code[10];
    var
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
    begin
        //HEI.11>>
        if GenBusinessPostingGroup.FINDFIRST() then
            exit(GenBusinessPostingGroup.Code);
        //HEI.11<<
    end;

    local procedure FindVATBusPostingGroup(): Code[10];
    var
        VATBusinessPostingGroup: Record "VAT Business Posting Group";
    begin
        //HEI.11>>
        if VATBusinessPostingGroup.FINDFIRST() then
            exit(VATBusinessPostingGroup.Code);
        //HEI.11<<
    end;

    local procedure FindWHTBusPostingGroup(): Code[10];
    var
        WHTBusinessPostingGroup: Record "WHT Business Posting Group FND";
    begin
        //HEI.11>>
        if WHTBusinessPostingGroup.FINDFIRST() then
            exit(WHTBusinessPostingGroup.Code);
        //HEI.11<<
    end;

    local procedure FindFAGLJournal(): Code[10];
    var
        GenJournalTemplate: Record "Gen. Journal Template";
    begin
        //HEI.12>>
        GenJournalTemplate.SETRANGE(Type, GenJournalTemplate.Type::Assets);
        if GenJournalTemplate.FINDFIRST() then
            exit(GenJournalTemplate.Name);
        //HEI.12<<
    end;

    local procedure CreateUserGeneralJournalForUser(UserName: Code[50]; JournalType: Option General,Item; GenJournalType: Option General,Sales,Purchases,"Cash Receipts",Payments,Assets,Intercompany,Jobs);
    var
        UserGenJournalSetup: Record "User Gen. Journal Setup FND";
        GenJournalTemplate: Record "Gen. Journal Template";
    begin
        //HEI.13>>
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
        //HEI.13<<
    end;

    local procedure FindBankAccount(): Code[20];
    var
        BankAccount: Record "Bank Account";
    begin
        //HEI.14>>
        if BankAccount.FINDFIRST() then
            exit(BankAccount."No.");
        //HEI.14<<
    end;

    local procedure FindEmployee(): Code[20];
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        BillToCustFound: Boolean;
        SalesShipmentLine: Record "Sales Shipment Line";
        Customer: Record Customer;
    begin
        //HEI.15<<
        Customer.RESET();
        Customer.CALCFIELDS("Flag for Deletion FND");
        Customer.SETRANGE("Flag for Deletion FND", false);
        Customer.SETRANGE("Account Group FND", 'Y008');
        Customer.SETFILTER(Blocked, '<>%1&<>%2', Customer.Blocked::Ship, Customer.Blocked::All);
        Customer.SETRANGE("Min. Order Value Limit FND", 0);
        //Customer.SETRANGE("Sundry Customer", false); //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT field-"Sundry Customer" of Customer Table 
        if Customer.FINDFIRST() then;

        exit(Customer."No.");
        //HEI.15>>
    end;

    //BC Upgrade KAPOOV01 Commented procedure FindLoyaltyFreeReasonCode() DRINK-IT table-"Free Reason Code" >>
    local procedure FindLoyaltyFreeReasonCode(): Code[10];
    var
        //FreeReasonCode: Record "Free Reason Code";
        FreeReasonCode: Record "Reason Code";
    begin
        //HEI.17<<
        //FreeReasonCode.SETRANGE(Type, FreeReasonCode.Type::Loyalty);
        if FreeReasonCode.FINDFIRST then
            exit(FreeReasonCode.Code);
        //HEI.17>>
    end;
    //BC Upgrade KAPOOV01 Commented procedure FindLoyaltyFreeReasonCode() DRINK-IT table-"Free Reason Code" <<    

    procedure SetParameters(pCreateGenJournalUsers: Boolean; pCreateWarehouseEmployees: Boolean; pDeleteExistingValues: Boolean; pHideDialogs: Boolean);
    begin
        //HEI.21>>
        CreateGenJournalUsers := pCreateGenJournalUsers;
        CreateWarehouseEmployees := pCreateWarehouseEmployees;
        DeleteExistingValues := pDeleteExistingValues;
        CurrReport.USEREQUESTPAGE(false);
        HideDialogs := pHideDialogs;
        //HEI.21<<
    end;

    local procedure FindVendor_ICPartner(): Code[20];
    var
        Vendor: Record Vendor;
    begin
        //HEI.22>>
        Vendor.SETRANGE(Blocked, Vendor.Blocked::" ");
        Vendor.SETFILTER("IC Partner Code", '<>%1', '');
        if Vendor.FINDFIRST() then
            exit(Vendor."No.");
        //HEI.22<<
    end;

    local procedure FindSelltoCustomer_ForReminders(): Code[20];
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        BillToCustomer: Record Customer;
        Customer: Record Customer;
        BillToCustFound: Boolean;
        BillToCustNo: Code[20];
    begin
        //HEI.24>>
        BillToCustFound := false;
        BillToCustomer.CALCFIELDS("Flag for Deletion FND");
        BillToCustomer.SETRANGE("Flag for Deletion FND", false);
        BillToCustomer.SETRANGE("Account Group FND", 'Y001');
        //HEI.29>>
        if COMPANYNAME in ['Tango', '10_BUKAVU'] then //HEI.35>>
            BillToCustomer.SETRANGE("Customer Posting Group", '3PC-TRADE');
        //HEI.29<<
        //BillToCustomer.SETRANGE("Sundry Customer", false); //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT field-"Sundry Customer" of Customer Table 
        BillToCustomer.SETFILTER(Blocked, '<>%1&<>%2', BillToCustomer.Blocked::All, BillToCustomer.Blocked::Invoice);
        if BillToCustomer.FINDSET(false, false) then
            repeat
                CustLedgerEntry.RESET();
                CustLedgerEntry.SETRANGE("Customer No.", BillToCustomer."No.");
                CustLedgerEntry.SETRANGE(Open, true);
                if CustLedgerEntry.ISEMPTY then begin
                    //BillToCustFound := true;
                    BillToCustFound := FindSelltoCustomer_ForBillTo_Reminders(BillToCustomer."No.", Customer); //HEI.46
                    BillToCustNo := BillToCustomer."No.";
                end;
            until (BillToCustomer.NEXT() = 0) or BillToCustFound;

        //HEI.46>>
        //IF BillToCustFound THEN BEGIN
        //Customer.SETRANGE("Bill-to Customer No.",BillToCustNo);
        //Customer.CALCFIELDS("Flag for Deletion");
        //Customer.SETRANGE("Flag for Deletion",FALSE);
        //Customer.SETFILTER("Account Group",'%1|%2|%3','Y002','Y006','Y010');
        //Customer.SETFILTER(Blocked,'<>%1&<>%2',Customer.Blocked::Ship,Customer.Blocked::All);
        //Customer.SETRANGE("Min. Order Value Limit",0);
        //Customer.SETRANGE("Sundry Customer",FALSE);
        //IF Customer.FINDFIRST THEN
        //END;
        //HEI.46<<
        exit(Customer."No.");
        //HEI.24<<
    end;

    local procedure FindSellToCustomerShipment(): Code[20];
    var
        SalesShipmentLine: Record "Sales Shipment Line";
    begin
        //HEI.30>>
        SalesShipmentLine.SETRANGE(Type, 2);
        SalesShipmentLine.SETRANGE(Correction, false);
        SalesShipmentLine.SETRANGE("Job No.", '');
        SalesShipmentLine.SETFILTER(Quantity, '<>%1', 0);
        if SalesShipmentLine.FINDLAST() then //HEI.39
            exit(SalesShipmentLine."Sell-to Customer No.");
        //HEI.30<<
    end;

    local procedure FindSelltoCustomer_ForBillTo_Reminders(BillToCustNo: Code[20]; VAR Customer: Record Customer): Boolean
    var
    begin
        //HEI.46>>
        Customer.RESET();
        Customer.SETRANGE("Bill-to Customer No.", BillToCustNo);
        Customer.CALCFIELDS("Flag for Deletion FND");
        Customer.SETRANGE("Flag for Deletion FND", FALSE);
        Customer.SETFILTER("Account Group FND", '%1|%2|%3', 'Y002', 'Y006', 'Y010');
        Customer.SETFILTER(Blocked, '<>%1&<>%2', Customer.Blocked::Ship, Customer.Blocked::All);
        Customer.SETRANGE("Min. Order Value Limit FND", 0);
        //Customer.SETRANGE("Sundry Customer", FALSE);  //BC Upgrade KAPOOV01 DRINK-IT
        Customer.SETFILTER("Trading End Date FND", '%1|>%2', 0D, WORKDATE());
        EXIT(Customer.FINDFIRST());
        //HEI.46<<
    end;
}

