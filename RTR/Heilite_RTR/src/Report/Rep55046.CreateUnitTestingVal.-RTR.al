report 55046 "Create Unit Testing Val. - RTR"
{
    // version TS,HEI.35

    // HEI.01 RITM2822071 IBM BULIMC01 15.12.2021 # Automation RTR Test Scripts
    //   # New Report created to setup Unit Testing Values automatically
    // HEI.02 RITM2822071 IBM BULIMC01 26.01.2021 # Automation RTR Test Scripts
    //   #new test scrips added
    // HEI.03 RITM2822071 POENAB02 IBM 14.02.2022 Automation RTR Test Scripts
    //   #new test scrips added
    // 
    // HEI.04 YADAVP04 IBM 05.04.2022 Automation RTR Test Scripts
    //   #new test scripts added
    // HEI.05 RITM2822071 IBM BULIMC01 28.02.2021 # Automation RTR Test Scripts
    //   #new test scrips added
    // HEI.06 RITM2822071 POENAB02 IBM 09.03.2022 Automation RTR Test Scripts
    //   #modified function CreateUnitTestingValues
    // HEI.07 RITM2964345 SAXENA03 IBM 28.03.2022 Automation RTR Test Scripts
    //   # Added Setparameters function to SET request Page values as TRUE
    //   # Code added to Hide messages.
    // HEI.08 RITM2822071 IBM BULIMC01 29.03.2022 # Automation RTR Test Scripts
    //   #new functions added to automatically create the setup for the users
    //   #initialize the default values for the fields on the request page as TRUE
    // HEI.09 RITM2822071 IBM BULIMC01 14.04.2022 # Automation RTR Test Scripts
    //   #new updates
    // HEI.10 RITM2822071 IBM NASTAA02 26.05.2022 # Automation RTR Test Scripts
    //   # Bugfixing
    // HEI.11 RITM2822071 IBM BHATTA09 12.08.2022 # Automation RTR Test Scripts
    //   # Bugfixing for garbage character in Gen. Journal Batch
    //   # Path change for Dynamic environment
    // HEI.12 RITM2822071 IBM BHATTA09 16.08.2022 # Automation RTR Test Scripts
    //   # Bugfixing for User Setup for field "Allowed Change App. Mode"
    //   # Fix for RTR144
    //   # Fix for MVMT Dimension for RTR136
    //   # Fix for CCC Dim Value
    //   # Fix for FindCustomer, FindBillToCustomer FindSellToCustomer and MVMT Dimension Value
    // HEI.13 RITM2822071 IBM BHATTA09 17.08.2022 # Automation RTR Test Scripts
    //   # Bugfixing for Date Filter in BPM042, BPM043 and BPM044
    // HEI.14 RITM2822071 IBM BHATTA09 24.08.2022 # Automation RTR Test Scripts
    //   # Bugfixing for Date Filter in RTR068, RTR105, RTR120
    // HEI.15 RITM2822071 IBM BHATTA09 29.08.2022 # Automation RTR Test Scripts
    //   # Bugfixing for Date Filter
    // HEI.16 RITM2822071 IBM BHATTA09 30.08.2022 # Automation RTR Test Scripts
    //   # Bugfixing for Date Filter
    // HEI.17 RITM2822071 IBM BHATTA09 01.09.2022 # Automation RTR Test Scripts
    //   # Bugfixing for Workflow User Group empty lines
    // HEI.18 RITM2822071 IBM BHATTA09 05.09.2022 # Automation RTR Test Scripts
    //   # Bugfixing
    // HEI.20 RITM2822071 IBM BHATTA09 07.09.2022 # Automation RTR Test Scripts
    //   # Bugfixing
    // HEI.21 RITM2822071 IBM BHATTA09 14.09.2022 # Automation RTR Test Scripts
    //   # Bugfixing
    // HEI.22 RITM2822071 IBM BHATTA09 15.09.2022 # Automation RTR Test Scripts
    //   # Bugfixing
    // HEI.23 RITM2822071 IBM BHATTA09 16.09.2022 # Automation RTR Test Scripts
    //   # Bugfixing
    // HEI.24 RITM2822071 IBM BHATTA09 19.09.2022 # Automation RTR Test Scripts
    //   # Bugfixing
    // HEI.25 RITM2822071 IBM BHATTA09 21.09.2022 # Automation RTR Test Scripts
    //   # Bugfixing
    // HEI.26 RITM2822071 IBM BHATTA09 22.09.2022 # Automation RTR Test Scripts
    //   # Bugfixing
    // HEI.27 RITM2822071 IBM BHATTA09 27.09.2022 # Automation RTR Test Scripts
    //   # Bugfixing
    // HEI.28 RITM2822071 IBM BHATTA09 30.09.2022 # Automation RTR Test Scripts
    //   # Bugfixing
    // HEI.29 RITM2822071 IBM YADAVM05 17.01.2023 # Automation RTR Test Scripts
    //   # Optimisation
    // HEI.30 RITM3323086  IBM SAXENA03 20-03-2023
    //   # Added code to disable Change Log Setup
    // HEI.31 CHG2185291 IBM SAXENA03 10.05.2023 # Automation RTR Test Scripts
    //   # Added code for Consolidation of Test Script objects
    // 
    // HEI.32 CHG2185291 IBM YADAVM09 25.05.2023 # Automation RTR Test Scripts
    //   # Added code data creation error
    // HEI.33 CHG2240328 IBM YADAVM09 20.02.2024 # Automation RTR Test Scripts
    //   # Code Added to skip MVMT Mandatory
    // HEI.34 CHG2306110 IBM KAPOOV01 28.05.2025 # WEEK 22 2025 TEST SCRIPT OPTIMISATION
    //   # Code Added to ensure unblocked General Journal Template is used.
    // HEI.35 CHG2314075 IBM KAPOOV01 21.07.2025 # WEEK 30 2025 | HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code Added to ensure unblocked General Journal Template is used.

    //BC Upgrade KAPOOV01 >>
    //1. Commented Drink-IT Table- Route
    //2. Replaced field- "G/L Bank Account No." by field- "G/L Account No." as field "G/L Bank Account No." removed from Table-Bank Account Posting Group in BC.
    //3. Commented code dependent on DRINK-IT fields-"Credit Limit","Deposit Limit","Sundry Customer","Deposit Limit (LCY)","Gen. Bus. Posting Free Group", of Customer Table
    //4. Commented code dependent on DRINK-IT field-"Item Charge Type" of "Cust. Ledger Entry" Table
    //5. Added ApplicationArea Property of Report.
    //6. Old Report ID-50509.
    //7. Fixed date format for-RTR050,BPM042.
    //BC Upgrade KAPOOV01 <<

    // BC UPGRADE PATELS08 >>
    // # Added UsageCategory property at Report level.
    // # Code Change in procedure CreateWarehouseEmployeesForUser() to remove Zone code from Warehouse Employee GET function as number of fields in primary key is 2.
    // BC UPGRADE PATELS08 <<

    Caption = 'Create Unit Testing Values - RTR';
    ProcessingOnly = true;
    ApplicationArea = All;
    // BC UPGRADE PATELS08 >> # Added UsageCategory property at Report level.
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

        trigger OnInit();
        begin
            //HEI.08<<
            DeleteExistingValues := true;
            CreateGenJournalUsers := true;
            CreateWarehouseEmployees := true;
            //HEI.08>>
        end;
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        //HEI.31>>
        UnitTestingValue.SkipTestScriptExecutionPROD();
        //HEI.31<<
    end;

    trigger OnPostReport();
    var
        UnitTestingValue: Record "Unit Testing Value FND";
    begin
        CreateUnitTestingValues('RT_BPM001', 'Calculate Standard Cost Price');
        CreateUnitTestingValues('RT_RTR001', 'Manual GL posting (without upload)');
        CreateUnitTestingValues('RT_RTR005', 'Manual GL posting(missing cost center on cost account)');
        CreateUnitTestingValues('RT_RTR008', 'Upload GL posting(missing cost center on cost account)');
        CreateUnitTestingValues('RTR027', 'Enter recurring entry template');
        CreateUnitTestingValues('RT_RTR124', 'Inventory reconciliation with general ledger');
        CreateUnitTestingValues('RT_RTR135', 'Manual Bank Statement processing');

        //HEI.02<<
        CreateUnitTestingValues('RTR074', 'Asset master data modification');
        CreateUnitTestingValues('RTR081', 'Correction of FA - Subclass');
        CreateUnitTestingValues('RTR082', 'Fixed Asset - change Location or Cost center');
        CreateUnitTestingValues('RTR087', 'Asset split');
        CreateUnitTestingValues('RTR088', 'Asset disposal with asset sale');
        CreateUnitTestingValues('RTR089', 'Asset disposal with scrapping');
        CreateUnitTestingValues('RTR091', 'RPM reconciliation - Quantities check');
        CreateUnitTestingValues('RTR096', 'Change log - Asset accounting checks');
        CreateUnitTestingValues('RTR106', 'Run various standard HeiLite financial reports');
        CreateUnitTestingValues('RTR116', 'Manual reconciliation - AR trade');
        CreateUnitTestingValues('RTR121', 'Manual reconciliation - FA or GL');
        //HEI.02>>

        //HEI.03>>
        CreateUnitTestingValues('RTR117', 'Manual reconciliation - AP trade');
        CreateUnitTestingValues('RTR102', 'Creation of HeiMatch flat file');
        CreateUnitTestingValues('RTR111', 'Reclassification - deposits for packaging');
        CreateUnitTestingValues('RTR118', 'Reconciliation of petty cash');
        CreateUnitTestingValues('RTR105', 'Creation of Trial Balance per LE');
        CreateUnitTestingValues('RTR104', 'Creation of Cash Flow per LE');
        //HEI.03<<

        //HEI.04>>
        CreateUnitTestingValues('RTR109', 'Manual Currency Exchange Rate Update');
        CreateUnitTestingValues('RTR112', 'Manual Revaluation AR');
        CreateUnitTestingValues('RTR114', 'Revaluation of Treasury');
        CreateUnitTestingValues('RTR113', 'Revaluation of AP');
        CreateUnitTestingValues('RTR115', 'Revaluation of AR/AP Treasury');
        CreateUnitTestingValues('ACPICHARGES', 'Accrual Posting of Item Charges');
        //CreateUnitTestingValues('ACPICHARGES','Accrual Posting of Service And Item Charges');
        //CreateUnitTestingValues('ACPICHARGES','Service Accrual Posting');
        CreateUnitTestingValues('BPM042', 'Prepare flatfile for CIL reporting EbF');
        CreateUnitTestingValues('BPM043', 'Prepare flatfile for CIL reporting MSV');
        CreateUnitTestingValues('BPM044', 'Prepare flatfile for CIL reporting WIS');
        CreateUnitTestingValues('RTR050', 'Block Existing SCOA');
        CreateUnitTestingValues('BPM013', 'Calculate and post WiP');
        CreateUnitTestingValues('BPM016', 'Allocate dimension Logistics expense Cost drivers');
        CreateUnitTestingValues('BPM058', 'Check Plan data upload in Analysis by dimensions');
        CreateUnitTestingValues('BPM051', 'Create CAPEX budget');
        CreateUnitTestingValues('ADCCIA', 'Assigning default CC for Inventory Adjustment');
        CreateUnitTestingValues('RTR054', 'Clearing of GLAccount Selection Criteria-Amount');
        CreateUnitTestingValues('RTR071', 'Review Payroll Postings');
        CreateUnitTestingValues('RTR119', 'Calculate Depreciation');
        CreateUnitTestingValues('RTR038', 'ChangeLogReviewofGLPostings');





        //HEI.04<<

        //HEI.05>>
        CreateUnitTestingValues('RTR134', 'Bank Statement Processing - Automated Upload');
        CreateUnitTestingValues('RTR136', 'Manual Matching - Suspense Accounts');
        CreateUnitTestingValues('RTR138', 'Manual Reconciliation - Bank Account');
        //HEI.05<<
        CreateUnitTestingValues('RTR144', 'PreparationVATdeclaration');//HEI.12
        //HEI.08<<
        if CreateWarehouseEmployees then
            CreateWarehouseEmployeesForUser(USERID, '', '');

        //For each Journal Type (0 = General, 1 = Item) and Gen. Journal Type (0 = General, 1 = Sales, 2 = Purchases, 3 = Cash Receipts,
        //4 = Payments, 5 = Assets, 6 = Intercompany, 7 = Jobs) call function CreateUserGeneralJournalForUser
        if CreateGenJournalUsers then begin
            CreateUserGeneralJournalForUser(USERID, 0, 0, 0);
            CreateUserGeneralJournalForUser(USERID, 0, 4, 0);
            CreateUserGeneralJournalForUser(USERID, 0, 5, 0);
            CreateUserGeneralJournalForUser(USERID, 1, 0, 0);
            CreateUserGeneralJournalForUser(USERID, 1, 0, 3);
        end;
        //HEI.08

        //HEI.07>>
        if not HideDialogs then
            //HEI.07<<

            MESSAGE(UnitTestValuesCreatedMsg);
    end;

    trigger OnPreReport();
    var
        UnitTestingValue: Record "Unit Testing Value FND";
        GeneralLedgerSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        lFAJournalSetUp: Record "FA Journal Setup";
        lFAJournalSetUp2: Record "FA Journal Setup";
        lDimVal: Record "Dimension Value";
        lGLAccounts: Record "G/L Account";
        lSalesSetup: Record "Sales & Receivables Setup";
        lGenJnlLine: Record "Gen. Journal Line";
        lFAPostingGr: Record "FA Posting Group";
        lFAPostingGr2: Record "FA Posting Group";
        SpCh: Label '*''*';
        lEbfComb: Record "Ebf Combination FND";
    begin
        //HEI.30>>
        ChangeLogSetup.RESET();
        if ChangeLogSetup.GET() then begin
            ChangeLogSetup."Change Log Activated" := false;
            ChangeLogSetup.MODIFY(true);
        end;
        //HEI.30<<


        //HEI.10>>
        //Update Allow Posting Date
        GeneralLedgerSetup.GET();
        GeneralLedgerSetup."Allow Posting From" := CALCDATE('<-CY-1Y>', TODAY);//HEI.27
        if (GeneralLedgerSetup."Allow Posting To" < TODAY) then begin
            GeneralLedgerSetup."Allow Posting To" := CALCDATE('<CY>', TODAY);
            //GeneralLedgerSetup.MODIFY;//HEI.27
        end;
        GeneralLedgerSetup.MODIFY();//HEI.27
        //Create User Setup for Current User
        if not UserSetup.GET(USERID) then begin
            UserSetup.INIT();
            UserSetup."User ID" := USERID;
            UserSetup.INSERT();
        end;
        //HEI.10<<
        //HEI.12>>
        if UserSetup.GET(USERID) then begin
            UserSetup."Allowed Change App. Mode FND" := true;
            UserSetup.MODIFY();
        end;
        //HEI.12<<
        //HEI.22>>
        lGLAccounts.RESET();
        lGLAccounts.SETRANGE("Account Type", lGLAccounts."Account Type"::Posting);
        lGLAccounts.SETRANGE("Direct Posting", false);
        if lGLAccounts.FINDSET() then begin
            //REPEAT//HEI.29
            //lGLAccounts."Direct Posting" := TRUE;//HEI.29
            lGLAccounts.MODIFYALL(lGLAccounts."Direct Posting", true);
            //UNTIL lGLAccounts.NEXT = 0;//HEI.29
        end;
        //HEI.22<<
        //HEI.24>>
        lFAPostingGr.RESET();
        lFAPostingGr.SETFILTER("Write-Down Account", '<>%1', '');
        if lFAPostingGr.FINDFIRST() then begin
            lFAPostingGr2.RESET();
            lFAPostingGr.SETFILTER("Write-Down Account", '%1', '');
            if lFAPostingGr2.FINDSET() then
                //REPEAT//HEI.29
                //lFAPostingGr2."Write-Down Account" := lFAPostingGr."Write-Down Account";//HEI.29
                lFAPostingGr2.MODIFYALL(lFAPostingGr2."Write-Down Account", lFAPostingGr."Write-Down Account");//HEI.29
                                                                                                               // UNTIL lFAPostingGr2.NEXT = 0;//HEI.29
        end;



        //HEI.24<<
        //HEI.21>>
        lFAJournalSetUp.RESET();
        lFAJournalSetUp.SETFILTER("User ID", '%1|%2', USERID, '');
        if not lFAJournalSetUp.FINDFIRST() then begin
            lFAJournalSetUp2.RESET();
            lFAJournalSetUp2.SETFILTER("User ID", '<>%1', '');
            if lFAJournalSetUp2.FINDFIRST() then begin
                lFAJournalSetUp2."User ID" := USERID;
                lFAJournalSetUp2.INSERT();
            end;
        end;

        GeneralLedgerSetup.GET();
        lDimVal.RESET();
        lDimVal.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        lDimVal.SETRANGE(Blocked, true);
        if lDimVal.FINDSET() then
            //REPEAT//HEI.29
            //lDimVal.Blocked := FALSE;//HEI.29
            lDimVal.MODIFYALL(lDimVal.Blocked, false);
        //UNTIL lDimVal.NEXT = 0;//HEI.29

        lGLAccounts.RESET();
        lGLAccounts.SETRANGE(Blocked, true);
        if lGLAccounts.FINDSET() then
            //REPEAT//HEI.29
            // lGLAccounts.Blocked := FALSE;//HEI.29
            lGLAccounts.MODIFYALL(lGLAccounts.Blocked, false);//HEI.29
                                                              //UNTIL lGLAccounts.NEXT = 0;//HEI.29


        lSalesSetup.GET();
        lSalesSetup."Activate CIS System FND" := false;//HEI.22
        lSalesSetup."Ext. Doc. No. Mandatory" := false;//HEI.22
        if lSalesSetup."Credit Warnings" <> lSalesSetup."Credit Warnings"::"No Warning" then begin
            lSalesSetup."Credit Warnings" := lSalesSetup."Credit Warnings"::"No Warning";
            //lSalesSetup.MODIFY;//HEI.22
        end;
        lSalesSetup.MODIFY();//HEI.22



        //HEI.27>>
        //HEI.28>>
        /*
        GeneralLedgerSetup.GET;
        lEbfComb.RESET;
        lEbfComb.SETCURRENTKEY("GL Account No.","Dimension Code","Dimension Value Code");
        lEbfComb.SETFILTER("Dimension Code",'%1|%2',GeneralLedgerSetup."Shortcut Dimension 2 Code",GeneralLedgerSetup."Shortcut Dimension 3 Code");
        lEbfComb.SETFILTER("Combination Restriction",'%1|%2',lEbfComb."Combination Restriction"::"Allowed with Warn",lEbfComb."Combination Restriction"::"Not Allowed");
        lEbfComb.DELETEALL;
        */
        //HEI.28<<
        //HEI.27<<

        lGenJnlLine.RESET();
        lGenJnlLine.SETFILTER("Line No.", '<>%1', 0);
        if lGenJnlLine.FINDSET() then
            lGenJnlLine.DELETEALL();
        //HEI.21<<
        if DeleteExistingValues then begin
            UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6|%7',
                                       'RT_RTR001', 'RT_RTR005', 'RT_RTR008', 'RTR027', 'RT_RTR124', 'RT_RTR135', 'RT_BPM001');
            if UnitTestingValue.FINDSET then
                UnitTestingValue.DELETEALL;

            //HEI.02<<
            UnitTestingValue.RESET;
            UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6|%7|%8',
                                      'RTR074', 'RTR081', 'RTR082', 'RTR087', 'RTR088', 'RTR089', 'RTR091', 'RTR096');
            if UnitTestingValue.FINDSET then
                UnitTestingValue.DELETEALL;

            UnitTestingValue.RESET;
            UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3',
                                      'RTR106', 'RTR116', 'RTR121');

            //HEI.02>>
            if UnitTestingValue.FINDSET then
                UnitTestingValue.DELETEALL;

            //HEI.03>>
            UnitTestingValue.RESET;
            UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6',
                                      'RTR117', 'RTR102', 'RTR111', 'RTR118', 'RTR105', 'RTR104');
            if UnitTestingValue.FINDSET then
                UnitTestingValue.DELETEALL;
            //HEI.03<<

            //HEI.04>>
            UnitTestingValue.RESET;
            UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10',
                                      'RTR109', 'RTR112', 'RTR114', 'RTR113', 'RTR115', 'ACPICHARGES', 'BPM042', 'BPM043', 'BPM044', 'RTR050');

            if UnitTestingValue.FINDSET then
                UnitTestingValue.DELETEALL;

            UnitTestingValue.RESET;
            UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10',
                                      'BPM013', 'BPM016', 'BPM058', 'BPM051', 'ADCCIA', 'RTR071', 'RTR054', 'RTR071', 'RTR119', 'RTR038');

            if UnitTestingValue.FINDSET then
                UnitTestingValue.DELETEALL;




            //HEI.04<<

            //HEI.05>>
            UnitTestingValue.RESET;
            UnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3',
                                      'RTR134', 'RTR136', 'RTR138');
            if UnitTestingValue.FINDSET then
                UnitTestingValue.DELETEALL;
            //HEI.05<<
            //HEI.25>>
            UnitTestingValue.RESET;
            UnitTestingValue.SETFILTER("Test Script Code", '%1|%2',
                                      'RTR144', 'RT_BPM001');
            if UnitTestingValue.FINDSET then
                UnitTestingValue.DELETEALL;
            //HEI.25<<

        end;


        //HEI.17>>
        WorkflowUserGroupMember.RESET();
        WorkflowUserGroupMember.SETFILTER("User Name", '%1', '');
        if WorkflowUserGroupMember.FINDSET() then// begin //Bc Upgrade YADAVM09 Warning Resolution variable<<
            WorkflowUserGroupMember.DELETEALL();
        //end; //Bc Upgrade YADAVM09 Warning Resolution<<
        //HEI.17<<

    end;

    var
        UnitTestValuesCreatedMsg: Label 'Unit Testing Values created.';
        DeleteExistingValues: Boolean;
        FirstItemNo: Code[20];
        AnalysisView: Record "Analysis View";
        HideDialogs: Boolean;
        CreateWarehouseEmployees: Boolean;
        CreateGenJournalUsers: Boolean;
        FolderPathTxt: Label 'C:\scripts\heilite-ops\TestScripts\RTR';
        WorkflowUserGroupMember: Record "Workflow User Group Member";
        ChangeLogSetup: Record "Change Log Setup";
        UnitTestingValue: Record "Unit Testing Value FND";

    procedure CreateUnitTestingValues(TestCode: Code[20]; TestDescription: Text[100]);
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        UnitTestingValue: Record "Unit Testing Value FND";
        //Route : Record Route; //BC Upgrade KAPOOV01 Drink-IT
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
        ItemTemplateName: Code[10];
        FANo: Code[20];
        ReclassJournalName: Code[20];
        lBankAccountPostingGroup: Record "Bank Account Posting Group";
    begin
        GeneralLedgerSetup.GET();

        case TestCode of
            'RT_RTR001',
            'RT_RTR005',
            'RT_RTR008',
            'RTR027',
            'ACPICHARGES',
            'BPM013',
            'RTR144',//HEI.12
            'BPM016':
                begin
                    //Gen. Journal Template
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Journal Template", UnitTestingValue);
                    if TestCode = 'RTR027' then
                        UnitTestingValue.VALIDATE(Value, FindReccuringJournal())
                    else
                        UnitTestingValue.VALIDATE(Value, FindGenJournal());
                    //HEI.09<<
                    if TestCode in ['RT_RTR005', 'RT_RTR008'] then
                        UnitTestingValue.VALIDATE("Value 3", FolderPathTxt);
                    //HEI.09>>
                    UnitTestingValue.MODIFY(true);
                    JournalTemplateName := UnitTestingValue.Value;
                    //Gen. Journal Batch
                    //HEI.24>>
                    if ((UPPERCASE(COMPANYNAME) = '10_BRARUDI') or (UPPERCASE(COMPANYNAME) = '10_SIERRALEONE') or (UPPERCASE(COMPANYNAME) = 'BRASCO')) and (TestCode = 'RT_RTR001') then begin//HEI.26
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Journal Batch", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindAlternateBatchName(JournalTemplateName));
                        UnitTestingValue.MODIFY(true);
                    end
                    else begin
                        //HEI.24<<
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Journal Batch", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindBatchName(JournalTemplateName));
                        UnitTestingValue.MODIFY(true);
                    end;



                    //GL Account
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
                    if TestCode = 'RT_RTR005' then
                        UnitTestingValue.VALIDATE(Value, FindGLAccountMissingCCC())
                    else
                        UnitTestingValue.VALIDATE(Value, FindGLAccount());
                    UnitTestingValue.MODIFY(true);


                end;

            'RT_BPM001':
                begin
                    //Item
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Item, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindItem());
                    UnitTestingValue.MODIFY(true);

                    //Item Journal Template
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Item Journal Template", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindItemRevalJournal());
                    ItemTemplateName := FindItemRevalJournal();
                    UnitTestingValue.MODIFY(true);

                    //Item Journal batch
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Item Journal Batch", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindItemRevalBatch(ItemTemplateName));
                    UnitTestingValue.MODIFY(true);
                end;

            'RT_RTR124':
                begin
                    //Location
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                    LocationCode := FindLocation();
                    UnitTestingValue.VALIDATE(Value, LocationCode);
                    UnitTestingValue.MODIFY(true);

                    //Inventory Posting Setup
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Inventory Posting Group", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindInvPostingGroup(LocationCode));
                    UnitTestingValue.MODIFY(true);

                end;

            'RT_RTR135',
            //HEI.05<<
            'RTR134',
            'RTR138':
                //HEI.05>>
                begin
                    if TestCode = 'RT_RTR135' then begin//HEI.05
                                                        //G/L Account
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindGLAccount());
                        UnitTestingValue.MODIFY(true);
                    end; //HEI.05

                    //Bank Account
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Bank Account", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindBankAcc());
                    UnitTestingValue.MODIFY(true);
                end;

            //HEI.02>>
            'RTR074',
            'RTR081',
            'RTR082',
            'RTR087',
            'RTR088',
            'RTR089',
            'RTR096',
            'RTR121':
                begin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Fixed Asset", UnitTestingValue);
                    FANo := FindFixedAsset();
                    UnitTestingValue.VALIDATE(Value, FANo);
                    UnitTestingValue.MODIFY(true);

                    if TestCode = 'RTR081' then begin
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"FA Subclass", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindSubClass(FANo));
                        UnitTestingValue.MODIFY(true);
                    end;

                    if TestCode = 'RTR082' then begin
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindLocation());
                        UnitTestingValue.MODIFY(true);

                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindCCCDimValue());
                        UnitTestingValue.MODIFY(true);
                    end;

                    if TestCode = 'RTR087' then begin
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"FA Reclass. Journal Template", UnitTestingValue);
                        ReclassJournalName := FindReclassJournal();
                        UnitTestingValue.VALIDATE(Value, ReclassJournalName);
                        UnitTestingValue.MODIFY(true);

                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"FA Reclass. Journal Batch", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindReclassBatch(ReclassJournalName));
                        UnitTestingValue.MODIFY(true);
                    end;

                    if TestCode = 'RTR088' then begin
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::Customer, UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindCustomer());
                        UnitTestingValue.MODIFY(true);
                    end;

                    //HEI.10>>
                    //IF TestCode = 'RTR089' THEN BEGIN
                    if TestCode in ['RTR087', 'RTR089'] then begin
                        //HEI.10<<
                        //Gen. Journal Template
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Journal Template", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindFAGLJournal());
                        UnitTestingValue.MODIFY(true);
                        JournalTemplateName := UnitTestingValue.Value;

                        //Gen. Journal Batch
                        InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Journal Batch", UnitTestingValue);
                        UnitTestingValue.VALIDATE(Value, FindBatchName(JournalTemplateName));
                        UnitTestingValue.MODIFY(true);
                    end;

                end;

            'RTR106':
                begin
                    //Bank Acc. Posting group
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Bank Account Posting Group", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindBankAccPostingGroup());
                    UnitTestingValue.MODIFY(true);

                    //Account Schedule
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Acc. Schedule Name", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindIncomeAccSchedule());
                    UnitTestingValue.MODIFY(true);
                end;
            //HEI.02>>
            //HEI.03>>
            'RTR102':
                begin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Entry", UnitTestingValue);
                    // HEI.09 commented
                    // UnitTestingValue.Value := '10';
                    // UnitTestingValue."Value 2" := '2017';
                    // HEI.09 commented

                    // HEI.09
                    UnitTestingValue.Value := '01';
                    UnitTestingValue."Value 2" := '2021';
                    // HEI. 09

                    UnitTestingValue.MODIFY(true);
                end;
            'RTR118':
                begin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Bank Account Posting Group", UnitTestingValue);
                    //HEI.06>>
                    //UnitTestingValue.Value := '13203001';
                    UnitTestingValue.Value := '';
                    //lBankAccountPostingGroup.SETFILTER("G/L Bank Account No.",'<>%1',''); //BC Upgrade KAPOOV01 field- "G/L Bank Account No." removed from Table-Bank Account Posting Group in BC.
                    lBankAccountPostingGroup.SETFILTER("G/L Account No.", '<>%1', ''); //BC Upgrade KAPOOV01 replaced field- "G/L Bank Account No." by field- "G/L Account No." as field "G/L Bank Account No." removed from Table-Bank Account Posting Group in BC.
                    if lBankAccountPostingGroup.FINDFIRST() then
                        //UnitTestingValue.Value := lBankAccountPostingGroup."G/L Bank Account No."; //BC Upgrade KAPOOV01 field- "G/L Bank Account No." removed from Table-Bank Account Posting Group in BC.
                        UnitTestingValue.Value := lBankAccountPostingGroup."G/L Account No."; //BC Upgrade KAPOOV01 replaced field- "G/L Bank Account No." by field- "G/L Account No." as field "G/L Bank Account No." removed from Table-Bank Account Posting Group in BC.
                                                                                              //HEI.06<<
                    UnitTestingValue.MODIFY(true);
                end;
            'RTR105':
                begin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
                    //HEI.10>>
                    //UnitTestingValue.Value := '<>7*';
                    //UnitTestingValue."Value 2" := '01/01/17..10/31/17';
                    UnitTestingValue.Value := '1*';
                    //UnitTestingValue."Value 2" := FORMAT(DMY2DATE(1,1,2017)) + '..' + FORMAT(DMY2DATE(31,10,2017));//HEI.14
                    //HEI.27>>
                    //UnitTestingValue."Value 2" := FORMAT(DMY2DATE(1,1,2017)) + '..' + FORMAT((DMY2DATE(28,2,2022)),0,'<Day,2>/<Month,2>/<Year,4>');//HEI.14
                    UnitTestingValue."Value 2" := FORMAT(CALCDATE('<-CM>', TODAY)) + '..' + FORMAT(TODAY);
                    //HEI.27<<
                    //HEI.10<<
                    UnitTestingValue.MODIFY(true);

                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Acc. Schedule Name", UnitTestingValue);
                    UnitTestingValue.Value := 'M-BALANCE';
                    UnitTestingValue.MODIFY(true);
                end;
            'RTR104':
                begin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Cash Flow Forecast", UnitTestingValue);
                    UnitTestingValue.Value := 'TST';
                    UnitTestingValue.MODIFY(true);
                end;
            //HEI.03<<
            //HEI.04>>
            'RTR109':
                begin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Currency, UnitTestingValue);
                    UnitTestingValue.Value := 'EUR';
                    UnitTestingValue.MODIFY(true);
                end;
            'BPM042':
                begin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Analysis View", UnitTestingValue);
                    if AnalysisView.GET('DZ_EBF') then
                        UnitTestingValue.Value := 'DZ_EBF'
                    else
                        UnitTestingValue.Value := 'EBF';
                    //HEI.10>>
                    //UnitTestingValue."Value 2":='010122D..022822D';
                    //HEI.13>>
                    //UnitTestingValue."Value 2":=FORMAT(DMY2DATE(1,1,2022)) + '..' + FORMAT(DMY2DATE(28,2,2022));
                    //UnitTestingValue."Value 2" := FORMAT(DMY2DATE(1, 1, 2022)) + '..' + FORMAT((DMY2DATE(28, 2, 2022)), 0, '<Day,2>/<Month,2>/<Year,4>'); //BC Upgrade KAPOOV01
                    UnitTestingValue."Value 2" := FORMAT(DMY2DATE(1, 1, 2022), 0) + '..' + FORMAT(DMY2DATE(28, 2, 2022), 0); //BC Upgrade KAPOOV01 fix for date format.
                    //HEI.13<<
                    //HEI.10<<
                    UnitTestingValue.MODIFY(true);
                end;
            'BPM043':
                begin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Analysis View", UnitTestingValue);

                    if AnalysisView.GET('MSV CIL') then
                        UnitTestingValue.Value := 'DZ_EBF' else
                        UnitTestingValue.Value := 'MRT';
                    UnitTestingValue.MODIFY(true);
                end;
            'RTR112':
                begin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Register", UnitTestingValue);
                    UnitTestingValue.Value := 'GENJNL';
                    UnitTestingValue."Value 2" := 'DEFAULT';
                    UnitTestingValue.MODIFY(true);
                end;
            'RTR050':
                begin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
                    // UnitTestingValue.Value := '41001001';
                    UnitTestingValue.Value := FindGLAccount();
                    //HEI.10>>
                    //UnitTestingValue."Value 2":='01012022D..02282022D';
                    //UnitTestingValue."Value 3":='10312020D';
                    //UnitTestingValue."Value 2" := FORMAT(DMY2DATE(1,1,2022)) + '..' + FORMAT(DMY2DATE(28,2,2022));//HEI.14
                    //UnitTestingValue."Value 2" := FORMAT(DMY2DATE(1, 1, 2022)) + '..' + FORMAT((DMY2DATE(28, 2, 2022)), 0, '<Day,2>/<Month,2>/<Year,4>');//HEI.14  //BC Upgrade KAPOOV01
                    UnitTestingValue."Value 2" := FORMAT(DMY2DATE(1, 1, 2022), 0) + '..' + FORMAT(DMY2DATE(28, 2, 2022), 0); //BC Upgrade KAPOOV01 fix for date format.
                    //UnitTestingValue."Value 3" := FORMAT(DMY2DATE(31,10,2020));//HEI.15
                    //HEI.16>>
                    //UnitTestingValue."Value 3" := FORMAT((DMY2DATE(31,10,2020)),0,'<Day,2>/<Month,2>/<Year,4>');//HEI.15
                    UnitTestingValue."Value 3" := FORMAT((DMY2DATE(31, 10, 2020)), 0, '<Day,2>/<Month,2>/<Year,2>');
                    //HEI.16<<
                    //HEI.10<<
                    UnitTestingValue.MODIFY(true);
                end;
            'BPM058':
                begin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Analysis View", UnitTestingValue);
                    UnitTestingValue.Value := 'CIL3';

                    UnitTestingValue.MODIFY(true);
                end;
            'BPM051':
                begin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Code Buffer", UnitTestingValue);
                    UnitTestingValue.Value := FindGLAccount();

                    UnitTestingValue.MODIFY(true);
                end;
            'ADCCIA':
                begin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Location, UnitTestingValue);
                    //UnitTestingValue.Value := 'DZ01';
                    UnitTestingValue.Value := FindLocation();

                    UnitTestingValue.MODIFY(true);
                end;
            'RTR054':
                begin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
                    UnitTestingValue.Value := FindGLAccountClearingofGL();

                    UnitTestingValue.MODIFY(true);

                end;
            'RTR071':
                begin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Entry", UnitTestingValue);
                    UnitTestingValue.Value := USERID;
                    UnitTestingValue."Value 2" := FindGLEntry();

                    UnitTestingValue.MODIFY(true);

                end;
            'RTR119':
                begin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Fixed Asset", UnitTestingValue);
                    //UnitTestingValue.Value:='FA-00085';//HEI.23
                    UnitTestingValue.Value := FindFixedAsset_RTR119();//HEI.23
                                                                      // UnitTestingValue.Value:= FindFixedAsset;
                    UnitTestingValue.MODIFY(true);
                end;
            'RTR038':
                begin
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Change Log Entry", UnitTestingValue);
                    UnitTestingValue.Value := 'G/L Entry';
                    UnitTestingValue."Value 2" := '85402';
                    UnitTestingValue.MODIFY(true);
                end;



            //HEI.04<<

            //HEI.05<<
            'RTR136':
                begin
                    //Gen. Journal Template
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Journal Template", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindGenJournal());
                    UnitTestingValue.MODIFY(true);
                    JournalTemplateName := UnitTestingValue.Value;

                    //Gen. Journal Batch
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Gen. Journal Batch", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindBatchName(JournalTemplateName));
                    UnitTestingValue.MODIFY(true);

                    //GL Account
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"G/L Account", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindGLAccountToApplyEntries());
                    UnitTestingValue.MODIFY(true);

                    //Bank Account
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Bank Account", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindBankAcc());
                    UnitTestingValue.MODIFY(true);

                    //Customer
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::Customer, UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, FindCustomer());
                    UnitTestingValue.MODIFY(true);

                    //HEI.12>>
                    //MVMT Dimension
                    InitUnitTestingValues(TestCode, TestDescription, DATABASE::"Dimension Value", UnitTestingValue);
                    UnitTestingValue.VALIDATE(Value, 'MVMT');
                    UnitTestingValue.VALIDATE("Value 2", FindMVMTDimValue());
                    UnitTestingValue.MODIFY(true);
                    //HEI.12<<
                end;
        //HEI.05<<

        end;
    end;

    local procedure InitUnitTestingValues(TestCode: Code[20]; TestDescription: Text[100]; TableID: Integer; var UnitTestingValue: Record "Unit Testing Value FND");
    begin
        UnitTestingValue.INIT;
        UnitTestingValue.VALIDATE("Test Script Code", TestCode);
        UnitTestingValue.VALIDATE("Table ID", TableID);
        UnitTestingValue.VALIDATE("Company Name", COMPANYNAME);
        UnitTestingValue.VALIDATE("Test Script Description", TestDescription);
        UnitTestingValue.INSERT(true);
    end;

    local procedure FindItem(): Code[20];
    var
        Item: Record Item;
        ItemFound: Boolean;
    begin
        Item.SETAUTOCALCFIELDS(Inventory, "Qty. on Sales Order");
        Item.SETRANGE(Type, Item.Type::Inventory);
        Item.SETRANGE(Blocked, false);
        //Item.SETFILTER(Inventory,'>%1',100);
        Item.SETRANGE("Item Tracking Code", '');
        if Item.FINDFIRST() then
            exit(Item."No.");
    end;

    local procedure FindLocation(): Code[10];
    var
        Location: Record Location;
    begin
        Location.SETRANGE("Require Shipment", true);
        Location.SETRANGE("Require Receive", true);
        Location.SETRANGE("Bin Mandatory", true);
        if Location.FINDFIRST() then
            exit(Location.Code);
    end;

    local procedure FindGLAccount(): Code[20];
    var
        GLAccount: Record "G/L Account";
        DefaultDim: Record "Default Dimension";
    begin
        GLAccount.SETRANGE(Blocked, false);
        GLAccount.SETRANGE("Direct Posting", true);
        GLAccount.SETRANGE("Account Type", GLAccount."Account Type"::Posting);
        GLAccount.SETRANGE("Income/Balance", GLAccount."Income/Balance"::"Balance Sheet");
        GLAccount.SETRANGE("Gen. Prod. Posting Group", '');
        GLAccount.SETRANGE("VAT Prod. Posting Group", '');
        if GLAccount.FINDSET() then
            repeat
                //HEI.33>>
                DefaultDim.RESET();
                DefaultDim.SETCURRENTKEY("Table ID", "No.");
                DefaultDim.SETRANGE("Table ID", 15);
                DefaultDim.SETRANGE("No.", GLAccount."No.");
                DefaultDim.SETRANGE("Value Posting", DefaultDim."Value Posting"::"Code Mandatory");
                if DefaultDim.FINDFIRST() then begin
                    DefaultDim."Value Posting" := DefaultDim."Value Posting"::" ";
                    DefaultDim.MODIFY();
                end;
                //HEI.33<<
                DefaultDim.RESET();
                DefaultDim.SETRANGE("Table ID", 15);
                DefaultDim.SETRANGE("No.", GLAccount."No.");
                DefaultDim.SETRANGE("Value Posting", DefaultDim."Value Posting"::"Code Mandatory");
                DefaultDim.SETFILTER("Dimension Value Code", '=%1', '');
                if not DefaultDim.FINDFIRST() then
                    exit(GLAccount."No.");
            until GLAccount.NEXT() = 0;
    end;

    local procedure FindGLEntry(): Code[20];
    var
        GLEntry: Record "G/L Entry";
        DefaultDim: Record "Default Dimension";
    begin
        GLEntry.RESET();
        GLEntry.SETRANGE("User ID", USERID);
        if GLEntry.FINDFIRST() then
            exit(GLEntry."Document No.");
    end;

    local procedure FindGLAccountClearingofGL(): Code[20];
    var
        GLAccount: Record "G/L Account";
        DefaultDim: Record "Default Dimension";
    begin
        GLAccount.SETRANGE(Blocked, false);
        GLAccount.SETRANGE("Direct Posting", true);
        GLAccount.SETRANGE("Authorize other App. Modes FND", true);
        if GLAccount.FINDFIRST() then
            DefaultDim.RESET();
        DefaultDim.SETRANGE("Table ID", 15);
        DefaultDim.SETRANGE("No.", GLAccount."No.");
        DefaultDim.SETRANGE("Value Posting", DefaultDim."Value Posting"::"Code Mandatory");
        DefaultDim.SETFILTER("Dimension Value Code", '=%1', '');
        if not DefaultDim.FINDFIRST() then
            exit(GLAccount."No.");
    end;

    local procedure FindGenJournal(): Code[10];
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
    begin
        if GenJournalTemplate.GET('RTR') then begin //HEI.10
                                                    //HEI.10>>
            if not GenJournalTemplate."Blocked FND" then begin //HEI.34
                GenJournalBatch.RESET();
                GenJournalBatch.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
                if not GenJournalBatch.ISEMPTY then
                    //HEI.10<<
                    exit(GenJournalTemplate.Name);
                //HEI.34>>
            end
            else if GenJournalTemplate.GET('RTR-MJE') then begin
                if not GenJournalTemplate."Blocked FND" then begin
                    GenJournalBatch.RESET();
                    GenJournalBatch.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
                    if not GenJournalBatch.ISEMPTY then
                        exit(GenJournalTemplate.Name);
                end;
            end;
            //HEI.34<<
        end; //HEI.10
             //HEI.35>>
             //IF GenJournalTemplate.GET('GENERAL') THEN
             //EXIT(GenJournalTemplate.Name);}
        if GenJournalTemplate.GET('GENERAL') then begin
            if not GenJournalTemplate."Blocked FND" then
                exit(GenJournalTemplate.Name)
            else if GenJournalTemplate.GET('RTR-MJE') then begin
                if not GenJournalTemplate."Blocked FND" then begin
                    GenJournalBatch.RESET();
                    GenJournalBatch.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
                    if not GenJournalBatch.ISEMPTY then
                        exit(GenJournalTemplate.Name);
                end;
            end;
        end
        //HEI.35<<
    end;

    local procedure FindBatchName(JournalTemplateName: Code[10]): Code[10];
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalTemplate: Record "Gen. Journal Template";
    begin
        if GenJournalTemplate.GET(JournalTemplateName) then;//HEI.32

        GenJournalBatch.RESET();
        GenJournalBatch.SETRANGE("Journal Template Name", JournalTemplateName);
        GenJournalBatch.SETFILTER(Name, '<>%1', '*&*');//HEI.11
        if GenJournalBatch.FINDSET() then
            repeat
                if (GenJournalTemplate.Type = GenJournalTemplate.Type::General) and (not GenJournalTemplate.Recurring) then begin
                    if (GenJournalBatch."No. Series" <> '') or (GenJournalBatch."Posting No. Series" <> '') then
                        exit(GenJournalBatch.Name)
                end else
                    exit(GenJournalBatch.Name);
            until GenJournalBatch.NEXT() = 0;
    end;

    local procedure FindReccuringJournal(): Code[10];
    var
        GenJournalTemplate: Record "Gen. Journal Template";
    begin
        GenJournalTemplate.RESET();
        GenJournalTemplate.SETRANGE(Type, GenJournalTemplate.Type::General);
        GenJournalTemplate.SETRANGE(Recurring, true);
        if GenJournalTemplate.FINDFIRST() then
            exit(GenJournalTemplate.Name);
    end;

    local procedure FindGLAccountMissingCCC(): Code[20];
    var
        GLAccount: Record "G/L Account";
        DefaultDim: Record "Default Dimension";
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.GET();

        DefaultDim.RESET();
        DefaultDim.SETRANGE("Table ID", 15);
        DefaultDim.SETRANGE("Dimension Code", GLSetup."Global Dimension 2 Code");
        DefaultDim.SETRANGE("Dimension Value Code", '');
        DefaultDim.SETRANGE("Value Posting", DefaultDim."Value Posting"::"Code Mandatory");
        if DefaultDim.FINDSET() then
            repeat
                GLAccount.SETRANGE("No.", DefaultDim."No.");
                GLAccount.SETRANGE(Blocked, false);
                GLAccount.SETRANGE("Direct Posting", true);
                GLAccount.SETRANGE("Account Type", GLAccount."Account Type"::Posting);
                if GLAccount.FINDFIRST() then
                    exit(GLAccount."No.");
            until DefaultDim.NEXT() = 0;
    end;

    local procedure FindItemRevalJournal(): Code[10];
    var
        ItemJournalTemplate: Record "Item Journal Template";
    begin
        ItemJournalTemplate.SETRANGE(Type, ItemJournalTemplate.Type::Revaluation);
        if ItemJournalTemplate.FINDFIRST() then
            exit(ItemJournalTemplate.Name);
    end;

    local procedure FindItemRevalBatch(JournalTemplateName: Code[10]): Code[10];
    var
        ItemJournalBatch: Record "Item Journal Batch";
    begin
        ItemJournalBatch.SETRANGE("Journal Template Name", JournalTemplateName);
        ItemJournalBatch.SETRANGE("Template Type", ItemJournalBatch."Template Type"::Revaluation);
        if ItemJournalBatch.FINDFIRST() then
            exit(ItemJournalBatch.Name);
    end;

    local procedure FindInvPostingGroup(LocationCode: Code[10]): Code[10];
    var
        InventoryPostingSetup: Record "Inventory Posting Setup";
    begin
        InventoryPostingSetup.SETRANGE("Location Code", LocationCode);
        InventoryPostingSetup.SETFILTER("Inventory Account", '<>%1', '');
        if InventoryPostingSetup.FINDFIRST() then
            exit(InventoryPostingSetup."Invt. Posting Group Code");
    end;

    local procedure FindBankAcc(): Code[20];
    var
        BankAccount: Record "Bank Account";
        BankAccPostingGroup: Record "Bank Account Posting Group";
        DefaultDim: Record "Default Dimension";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
    begin
        BankAccount.SETRANGE(Blocked, false);
        BankAccount.SETFILTER("Bank Acc. Posting Group", '<>%1', '');
        //IF BankAccount.FINDFIRST THEN //HEI.05 commented
        //HEI.05<<
        if BankAccount.FINDSET() then
            repeat
                BankAccountLedgerEntry.RESET();
                BankAccountLedgerEntry.SETRANGE("Bank Account No.", BankAccount."No.");
                BankAccountLedgerEntry.SETRANGE(Open, true);
                if BankAccountLedgerEntry.FINDFIRST() then
                    //HEI.05>>
                    exit(BankAccount."No.");
            until BankAccount.NEXT() = 0;
    end;

    local procedure FindFixedAsset(): Code[20];
    var
        FixedAsset: Record "Fixed Asset";
        FAFound: Boolean;
        FADepreciationBook: Record "FA Depreciation Book";
        Found: Boolean;
    begin
        //HEI.02<<
        FixedAsset.SETRANGE(Blocked, false);
        FixedAsset.SETRANGE(Inactive, false);
        if FixedAsset.FINDSET() then
            repeat
                FADepreciationBook.SETRANGE("FA No.", FixedAsset."No.");
                FADepreciationBook.SETFILTER("Depreciation Book Code", '%1|%2', 'LOCAL', 'HEINEKEN');//HEI.18
                FADepreciationBook.SETRANGE("Disposal Date", 0D);
                FADepreciationBook.SETFILTER("Acquisition Cost", '>%1', 0);//HEI.20
                                                                           //  FADepreciationBook.SETFILTER("Acquisition Cost",'<>%1',0);
                if FADepreciationBook.FINDFIRST() then
                    exit(FixedAsset."No.");
            until (FixedAsset.NEXT() = 0) or (Found = true);//HEI.18

        //HEI.02>>
    end;

    local procedure FindSubClass(FANo: Code[20]): Code[10];
    var
        FASubclass: Record "FA Subclass";
        FixedAsset: Record "Fixed Asset";
    begin
        //HEI.02>>
        FixedAsset.GET(FANo);
        FASubclass.SETFILTER("FA Class Code", '%1|%2', '', FixedAsset."FA Subclass Code");
        if FASubclass.FINDFIRST() then
            exit(FASubclass.Code);
        //HEI.02<<
    end;

    local procedure FindCCCDimValue(): Code[20];
    var
        DimensionValue: Record "Dimension Value";
        GenLedgSetup: Record "General Ledger Setup";
    begin
        //HEI.02<<
        GenLedgSetup.GET();
        DimensionValue.SETRANGE("Dimension Code", GenLedgSetup."Global Dimension 2 Code");
        DimensionValue.SETRANGE(Blocked, false);//HEI.12
        if DimensionValue.FINDFIRST() then
            exit(DimensionValue.Code);
        //HEI.02>>
    end;

    local procedure FindReclassJournal(): Code[10];
    var
        FAReclassJnlTemplate: Record "FA Reclass. Journal Template";
    begin
        //HEI.02<<
        if FAReclassJnlTemplate.FINDFIRST() then
            exit(FAReclassJnlTemplate.Name);
        //HEI.02>>
    end;

    local procedure FindReclassBatch(ReclassJnlName: Code[10]): Code[10];
    var
        FAReclassJnlBatch: Record "FA Reclass. Journal Batch";
    begin
        //HEI.02<<
        FAReclassJnlBatch.SETRANGE("Journal Template Name", ReclassJnlName);
        if FAReclassJnlBatch.FINDFIRST() then
            exit(FAReclassJnlBatch.Name);
        //HEI.02>>
    end;

    local procedure FindBankAccPostingGroup(): Code[20];
    var
        BankAccPostingGroup: Record "Bank Account Posting Group";
    begin
        //HEI.02<<
        //BankAccPostingGroup.SETFILTER("G/L Bank Account No.",'<>%1',''); //BC Upgrade KAPOOV01 field- "G/L Bank Account No." removed from Table-Bank Account Posting Group in BC.
        if BankAccPostingGroup.FINDFIRST() then
            exit(BankAccPostingGroup.Code);
        //HEI.02>>
    end;

    local procedure FindIncomeAccSchedule(): Code[20];
    var
        AccScheduleName: Record "Acc. Schedule Name";
    begin
        //HEI.02<<
        if AccScheduleName.FINDSET() then
            repeat
                if STRPOS(AccScheduleName.Name, UPPERCASE('INCOME')) <> 0 then
                    exit(AccScheduleName.Name);
            until AccScheduleName.NEXT() = 0;
        //HEI.02>>
    end;

    local procedure FindFAGLJournal(): Code[10];
    var
        GenJournalTemplate: Record "Gen. Journal Template";
    begin
        //HEI.02>>
        GenJournalTemplate.SETRANGE(Type, GenJournalTemplate.Type::Assets);
        GenJournalTemplate.SETRANGE(Recurring, false);
        if GenJournalTemplate.FINDFIRST() then
            exit(GenJournalTemplate.Name);
        //HEI.02<<
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
        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields-"Credit Limit","Deposit Limit","Sundry Customer" of Customer Table >>
        // BillToCustomer.SETRANGE("Credit Limit",false);
        // BillToCustomer.SETRANGE("Deposit Limit",false);
        // BillToCustomer.SETRANGE("Sundry Customer",false);
        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT fields-"Credit Limit","Deposit Limit","Sundry Customer" of Customer Table <<
        BillToCustomer.SETRANGE("Additional RPM Return FND", true);
        BillToCustomer.SETFILTER("Customer Posting Group", '<>%1', '');//HEI.12
        BillToCustomer.SETFILTER(Blocked, '<>%1&<>%2', BillToCustomer.Blocked::All, BillToCustomer.Blocked::Invoice);
        if BillToCustomer.FINDSET() then
            repeat
                BillToCustFound := FindSellToCustomer(BillToCustomer."No.", Customer);
            until (BillToCustomer.NEXT() = 0) or BillToCustFound;

        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT field-"Deposit Limit" defined in Customer Table >>
        // if Customer."No." = '' then begin
        //   BillToCustomer.SETRANGE("Deposit Limit"); 
        //   if BillToCustomer.FINDSET then
        //     repeat
        //       BillToCustFound := FindSellToCustomer(BillToCustomer."No.",Customer);
        //     until (BillToCustomer.NEXT = 0) or BillToCustFound;
        // end;
        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT field-"Deposit Limit" defined in Customer Table <<
        if Customer."No." = '' then begin
            BillToCustomer.SETRANGE("Additional RPM Return FND");
            if BillToCustomer.FINDSET() then
                repeat
                    BillToCustFound := FindSellToCustomer(BillToCustomer."No.", Customer);
                until (BillToCustomer.NEXT() = 0) or BillToCustFound;
        end;

        if Customer."No." = '' then begin
            //BillToCustomer.SETRANGE("Credit Limit");  //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT field-"Credit Limit" defined in Customer Table 
            BillToCustomer.SETFILTER("Credit Limit (LCY)", '>%1', 1000);
            //BillToCustomer.SETFILTER("Deposit Limit (LCY)", '>%1', 1000);  //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT field-"Deposit Limit (LCY)" defined in Customer Table
            if BillToCustomer.FINDSET() then
                repeat
                    BillToCustFound := FindSellToCustomer(BillToCustomer."No.", Customer);
                until (BillToCustomer.NEXT() = 0) or BillToCustFound;
        end;
        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT field-"Deposit Limit (LCY)" of Customer Table >>
        // if Customer."No." = '' then begin
        //     BillToCustomer.SETRANGE("Deposit Limit (LCY)");
        //     if BillToCustomer.FINDSET then
        //         repeat
        //             BillToCustFound := FindSellToCustomer(BillToCustomer."No.", Customer);
        //         until (BillToCustomer.NEXT = 0) or BillToCustFound;
        // end;
        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT field-"Deposit Limit (LCY)" of Customer Table <<

        if Customer."No." = '' then begin
            //BillToCustomer.SETRANGE("Credit Limit", true); //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT field-"Credit Limit" of Customer Table
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
        //CustLedgerEntry.SETFILTER("Item Charge Type", '<>%1', CustLedgerEntry."Item Charge Type"::Deposit);  //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT field-"Item Charge Type" of "Cust. Ledger Entry" Table
        CustLedgerEntry.SETFILTER("Due Date", '<%1', TODAY);
        CustLedgerEntry.SETFILTER("Remaining Amount", '>%1', 0);
        if not CustLedgerEntry.FINDFIRST() then begin
            Customer.SETRANGE("Bill-to Customer No.", BillToCustNo);
            Customer.CALCFIELDS("Flag for Deletion FND");
            Customer.SETRANGE("Flag for Deletion FND", false);
            Customer.SETFILTER("Account Group FND", '%1|%2', 'Y002', 'Y010');
            Customer.SETFILTER(Blocked, '<>%1&<>%2&<>%3', Customer.Blocked::Ship, Customer.Blocked::All, Customer.Blocked::Invoice);
            Customer.SETFILTER("Customer Posting Group", '<>%1', '');//HEI.12
            Customer.SETRANGE("Min. Order Value Limit FND", 0);
            //Customer.SETRANGE("Sundry Customer", false); //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT field-"Item Charge Type" of Customer Table
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

        if not BillToCustFound then
            CLEAR(Customer);

        if BillToCustNo = '' then begin
            Customer.CALCFIELDS("Flag for Deletion FND");
            Customer.SETRANGE("Flag for Deletion FND", false);
            Customer.SETRANGE("Account Group FND", 'Y006');
            Customer.SETFILTER(Blocked, '<>%1&<>%2&<>%3', Customer.Blocked::Ship, Customer.Blocked::All, Customer.Blocked::Invoice);
            Customer.SETRANGE("Min. Order Value Limit FND", 0);
            //Customer.SETRANGE("Sundry Customer", false); //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT field-"Sundry Customer" of Customer Table
            Customer.SETFILTER("Customer Posting Group", '<>%1', '');//HEI.12
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
        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT field-"Credit Limit","Deposit Limit","Sundry Customer","Gen. Bus. Posting Free Group" of Customer Table >>
        // BillToCustomer.SETRANGE("Credit Limit", false);
        // BillToCustomer.SETRANGE("Deposit Limit", false);
        // BillToCustomer.SETRANGE("Sundry Customer", false);
        BillToCustomer.SETRANGE("Additional RPM Return FND", true);
        // BillToCustomer.SETFILTER("Gen. Bus. Posting Free Group", '<>%1', '');
        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT field-"Credit Limit","Deposit Limit","Sundry Customer","Gen. Bus. Posting Free Group" of Customer Table <<
        //BillToCustomer.SETFILTER("Deposit Item Balance (LCY)",'>%1',100);
        BillToCustomer.SETFILTER(Blocked, '<>%1&<>%2', BillToCustomer.Blocked::All, BillToCustomer.Blocked::Invoice);
        if BillToCustomer.FINDSET() then
            repeat
                BillToCustFound := FindSellToCustomer(BillToCustomer."No.", Customer);
            until (BillToCustomer.NEXT() = 0) or BillToCustFound;

        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT field-"Deposit Limit" of Customer Table >>
        // if Customer."No." = '' then begin
        //     BillToCustomer.SETRANGE("Deposit Limit");
        //     if BillToCustomer.FINDSET then
        //         repeat
        //             BillToCustFound := FindSellToCustomer(BillToCustomer."No.", Customer);
        //         until (BillToCustomer.NEXT = 0) or BillToCustFound;
        // end;
        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT field-"Deposit Limit" of Customer Table <<

        if Customer."No." = '' then begin
            BillToCustomer.SETRANGE("Additional RPM Return FND");
            if BillToCustomer.FINDSET() then
                repeat
                    BillToCustFound := FindSellToCustomer(BillToCustomer."No.", Customer);
                until (BillToCustomer.NEXT() = 0) or BillToCustFound;
        end;

        if Customer."No." = '' then begin
            // BillToCustomer.SETRANGE("Credit Limit"); //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT field-"Credit Limit" of Customer Table 
            BillToCustomer.SETFILTER("Credit Limit (LCY)", '>%1', 1000);
            //BillToCustomer.SETFILTER("Deposit Limit (LCY)", '>%1', 1000); //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT field-"Deposit Limit (LCY)" of Customer Table 
            if BillToCustomer.FINDSET() then
                repeat
                    BillToCustFound := FindSellToCustomer(BillToCustomer."No.", Customer);
                until (BillToCustomer.NEXT() = 0) or BillToCustFound;
        end;

        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT field-"Deposit Limit (LCY)" of Customer Table >>
        // if Customer."No." = '' then begin
        //     BillToCustomer.SETRANGE("Deposit Limit (LCY)");
        //     //BillToCustomer.SETRANGE("Additional RPM Return");
        //     if BillToCustomer.FINDSET then
        //         repeat
        //             BillToCustFound := FindSellToCustomer(BillToCustomer."No.", Customer);
        //         until (BillToCustomer.NEXT = 0) or BillToCustFound;
        // end;
        //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT field-"Deposit Limit (LCY)" of Customer Table <<

        if Customer."No." = '' then begin
            //BillToCustomer.SETRANGE("Credit Limit", true); //BC Upgrade KAPOOV01 Commented code dependent on DRINK-IT field-"Credit Limit" of Customer Table 
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

    local procedure FindGLAccountToApplyEntries(): Code[20];
    var
        GLAccount: Record "G/L Account";
        DefaultDim: Record "Default Dimension";
    begin
        //HEI.05<<
        GLAccount.SETRANGE(Blocked, false);
        GLAccount.SETRANGE("Direct Posting", true);
        GLAccount.SETRANGE("Account Type", GLAccount."Account Type"::Posting);
        GLAccount.SETRANGE("Income/Balance", GLAccount."Income/Balance"::"Balance Sheet");
        GLAccount.SETRANGE("Gen. Prod. Posting Group", '');
        GLAccount.SETRANGE("VAT Prod. Posting Group", '');
        GLAccount.SETRANGE("Automatic application mode FND", GLAccount."Automatic application mode FND"::"Selection Criteria");
        GLAccount.SETRANGE("Same Amount FND", true);
        if GLAccount.FINDSET() then
            repeat
                DefaultDim.RESET();
                DefaultDim.SETRANGE("Table ID", 15);
                DefaultDim.SETRANGE("No.", GLAccount."No.");
                DefaultDim.SETRANGE("Value Posting", DefaultDim."Value Posting"::"Code Mandatory");
                DefaultDim.SETFILTER("Dimension Value Code", '=%1', '');
                if not DefaultDim.FINDFIRST() then
                    exit(GLAccount."No.");
            until GLAccount.NEXT() = 0;
        //HEI.05>>
    end;

    procedure SetParameters(pCreateGenJournalUsers: Boolean; pCreateWarehouseEmployees: Boolean; pDeleteExistingValues: Boolean; pHideDialogs: Boolean);
    begin
        //HEI.07>>
        CreateGenJournalUsers := pCreateGenJournalUsers; //HEI.08 uncommented
        CreateWarehouseEmployees := pCreateWarehouseEmployees; //HEI.08 uncommented
        DeleteExistingValues := pDeleteExistingValues;
        CurrReport.USEREQUESTPAGE(false);
        HideDialogs := pHideDialogs;
        //HEI.07<<
    end;

    local procedure CreateWarehouseEmployeesForUser(UserName: Code[50]; LocationCode: Code[10]; ZoneCode: Code[10]);
    var
        WarehouseEmployee: Record "Warehouse Employee";
        Location: Record Location;
        Zone: Record Zone;
    begin
        //HEI.08>>
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
                            if not WarehouseEmployee.GET(UserName, LocationCode, '', Zone.Code) then
                                if not WarehouseEmployee.GET(UserName, LocationCode) then
                                    // BC UPGRADE PATELS08 <<
                                    InsertWarehouseEmployee(UserName, LocationCode, Zone.Code);
                        until Zone.NEXT() = 0;
                end;
            end;
        //No creation for other cases
        //HEI.08<<
    end;

    local procedure CreateUserGeneralJournalForUser(UserName: Code[50]; JournalType: Option General,Item; GenJournalType: Option General,Sales,Purchases,"Cash Receipts",Payments,Assets,Intercompany,Jobs; ItemJournalType: Option Item,Transfer,"Phys. Inventory",Revaluation,Consumption,Output,Capacity,"Prod. Order");
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        ItemJournalTemplate: Record "Item Journal Template";
    begin
        //HEI.08>>
        if UserName = '' then
            exit;

        if JournalType = JournalType::General then begin
            GenJournalTemplate.RESET();
            GenJournalTemplate.SETRANGE(Type, GenJournalType);
            if GenJournalTemplate.FINDSET(false) then
                repeat
                    InsertGenUserSetup(JournalType, GenJournalTemplate.Name);
                until GenJournalTemplate.NEXT() = 0;
        end else begin
            ItemJournalTemplate.RESET();
            ItemJournalTemplate.SETRANGE(Type, ItemJournalType);
            if ItemJournalTemplate.FINDSET(false) then
                repeat
                    InsertGenUserSetup(JournalType, ItemJournalTemplate.Name);
                until ItemJournalTemplate.NEXT() = 0;
        end;
        //HEI.08<<
    end;

    local procedure InsertWarehouseEmployee(UserName: Code[50]; LocationCode: Code[10]; ZoneCode: Code[10]);
    var
        WarehouseEmployee: Record "Warehouse Employee";
    begin
        //HEI.08>>
        WarehouseEmployee.INIT();
        WarehouseEmployee.VALIDATE("User ID", UserName);
        WarehouseEmployee.VALIDATE("Location Code", LocationCode);
        WarehouseEmployee.VALIDATE("Zone Code FND", ZoneCode);
        WarehouseEmployee.INSERT(true);
        //HEI.08<<
    end;

    local procedure InsertGenUserSetup(JournalType: Option General,Item; JournalName: Code[10]);
    var
        UserGenJournalSetup: Record "User Gen. Journal Setup FND";
    begin
        //HEI.08>>
        UserGenJournalSetup.RESET;
        UserGenJournalSetup.SETRANGE("Journal Type", JournalType);
        UserGenJournalSetup.SETRANGE("Gen. Journal Template Name", JournalName);
        UserGenJournalSetup.SETRANGE("User ID", USERID);
        if not UserGenJournalSetup.FINDFIRST then begin
            UserGenJournalSetup.INIT;
            UserGenJournalSetup.VALIDATE("Journal Type", JournalType);
            UserGenJournalSetup.VALIDATE("Gen. Journal Template Name", JournalName);
            UserGenJournalSetup.VALIDATE("User ID", USERID);
            UserGenJournalSetup.INSERT;
        end;
        //HEI.08
    end;

    local procedure FindMVMTDimValue(): Code[20];
    var
        DimensionValue: Record "Dimension Value";
        GenLedgSetup: Record "General Ledger Setup";
    begin
        //HEI.12<<
        GenLedgSetup.GET();
        DimensionValue.SETRANGE("Dimension Code", 'MVMT');
        DimensionValue.SETRANGE(Blocked, false);
        if DimensionValue.FINDFIRST() then
            exit(DimensionValue.Code);
        //HEI.12>>
    end;

    local procedure FindFixedAsset_RTR119(): Code[20];
    var
        FixedAsset: Record "Fixed Asset";
        FAFound: Boolean;
        FADepreciationBook: Record "FA Depreciation Book";
        Found: Boolean;
    begin
        //HEI.23>>
        FixedAsset.SETRANGE(Blocked, false);
        FixedAsset.SETRANGE(Inactive, false);
        if FixedAsset.FINDSET() then
            //HEI.24>>
            repeat
                Found := false;
                FADepreciationBook.SETRANGE("FA No.", FixedAsset."No.");
                FADepreciationBook.SETFILTER("Depreciation Book Code", '%1', 'HEINEKEN');
                FADepreciationBook.SETRANGE("Disposal Date", 0D);
                FADepreciationBook.SETFILTER("Depreciation Ending Date", '>%1', TODAY);
                FADepreciationBook.SETFILTER("Acquisition Cost", '>%1', 0);
                if FADepreciationBook.FINDFIRST() then begin
                    FADepreciationBook.CALCFIELDS("Book Value");
                    if FADepreciationBook."Book Value" > 1000000 then begin
                        Found := true;
                        exit(FixedAsset."No.");
                    end;
                end;
            until (FixedAsset.NEXT() = 0) or (Found = true);
        //HEI.24<<
        //HEI.23<<
    end;

    local procedure FindAlternateBatchName(JournalTemplateName: Code[10]): Code[10];
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalTemplate: Record "Gen. Journal Template";
        "Count": Integer;
    begin
        //HEI.24>>
        Count := 0;
        GenJournalTemplate.GET(JournalTemplateName);

        GenJournalBatch.RESET();
        GenJournalBatch.SETRANGE("Journal Template Name", JournalTemplateName);
        GenJournalBatch.SETFILTER(Name, '<>%1', '*&*');
        if GenJournalBatch.FINDSET() then
            repeat
                Count := Count + 1;
                if (GenJournalTemplate.Type = GenJournalTemplate.Type::General) and (not GenJournalTemplate.Recurring) then begin
                    if ((GenJournalBatch."No. Series" <> '') or (GenJournalBatch."Posting No. Series" <> '')) and (Count > 1) then
                        exit(GenJournalBatch.Name)
                end else
                    if Count > 1 then
                        exit(GenJournalBatch.Name);
            until GenJournalBatch.NEXT() = 0;
        //HEI.24<<
    end;
}

