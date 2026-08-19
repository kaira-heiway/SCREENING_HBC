tableextension 50040 CustomerExtFND extends Customer
{
    // version NAVW110.0.00.18609,FINXL10.01,IPLXL9.00.001,DITW110.00.12A,NRQ61583,HEI.44
    /* Documentation
    HEI.01 FDD-PTPGAP002 IBM HORTOC01 19.08.2017
    - add new option for Blocked field
    - change function "CheckBlockedCustOnJnls"
    HEI.05 FDD-SLSGAP001 IBM POENAB01 17.08.2017 # MDM Customer Card
    # Changed field City from Text(30) to Text(35)
    # Changed fields Address and Address 2 from Text(50) to Text(60)
    # Changed field Customer DTax Group Code from Text(10) to Text(20)
    # New function - InsertInCustAttributes
    # New fields:
        - 50006 Blockage Reason
        - 50007 Tax Registration Number
        - 50008 National Identity Card
        - 50009 Approval Of Alcohol
        - 50010 Trade Register
        - 50011 Litigious
        - 50012 WHT Business Posting Group
        - 50013 WHT Payable Amount (LCY)
        - 50014 Return Order Mandatory
        - 50015 Account Group
        - 50016 Business Segment
        - 50017 Business OrganizationalSegment
        - 50018 Customer Type
        - 50019 Customer Sub-Type
        - 50020 Local Customer Sub-Type
    HEI.06 FDD-SLSGAP001 IBM POENAB01 17.08.2017 # MDM Customer Card
    # added function CopyToDefaultDimensions
    HEI.07 FDD-SLSGAP001 IBM POENAB01 25.08.2017 # MDM Customer Card
    # Changed field 50015 Account Group from Flow Field to Normal
    HEI.08 FDD-SLSGAP001 IBM NASTAA02 12.09.2017 # MDM Customer Card
    # Remove Table Relation for fields "Customer Sub-Type" and "Local Customer Sub-Type"
    HEI.09 FDD-SLSGAP001 IBM NASTAA02 15.09.2017 # MDM Customer Card
    # Used "Dimension Code" instead of "Field Name" in Function "CopyToDefaultDimensions"
    HEI.10 FDD-GAPLOG006 IBM ISYED01 29.09.2017 # Algerai Local
    # Added Fileds "Business Register","Taxable ItemText","N.I.S."
    HEI.11 FDD-KDD0TC002 IBM HORTOC01 04.10.2017 - new field "Interest Rate Credit Amount"
    HEI.12 FDD-SLSGAP001 IBM NASTAA02 06.10.2017 # MDM Customer Card
    # Removed some fields
    # Renamed field from "Risk Grade" to "Risk Category"
    # Removed usage of field "Return Order Mandatory" in Customer Attributes table
    HEI.13 FDD-KFFOTC003 IBM ISYED01 10.10.2017
    # Added field Additional RPM Return
    HEI.14 FDD-KDDOTC007 IBM.NAIKH01 10.10.2017
    # Added Field 50026 - Open Sales RPM Value
    # Added Field 50027 - RPM Exposure
    # On Field 50029 "FFE Security Amount"changed the field to Non Editable and added the flowfield Formula.
    HEI.15 DefectID 936 IBM HORTOC01 13.11.2017 # new field
    HEI.16 Bugfixing IBM NASTAA02 17.11.2017 # Local Algeria
    # Deleted fields "Business Register","Taxable ItemText","N.I.S."
    HEI.17 Bugfixing IBM NASTAA02 04.01.2018 # Local Algeria
    # Modify was missing from function "CopyToDefaultDimensions"
    HEI.18 Bugfixing IBM NASTAA02 04.01.2018 # Local Algeria
    # Deleted field 50006 - Blockage Reason
    HEI.19 FDD-HNK LOGGAP001 03/12/2017 IBM.CHAUHB01
    # Added new field "Sales Routes"
    HEI.20 FDD-SLSGAP014 IBM NASTAA02 16.04.2018 # Customer Blocked for Option 'Ship'
    # New function created CheckBlockedCustOnDocs2 to verify the blockage of the Sell-to Customer No.
    HEI.21 FDD-PTPGAP084 IBM POSTOI01 05.04.2018
    # Rename field 50032 from Sensitive Block into Sensitive Payment Block
    # create new boolean field Sensitive Workflow Block Id 50033
    # modify text constant SensitiveBlockError (add payment to the text)
    HEI.22 FDD-OTCGAP075 IBM NASTAA02 15.05.2018 # No dependency between respective credit risk Master Date fields in the system
    # When a new Customer is created "Risk Score" and "Risk Grade" should be automatically filled-in with the default values,
        code added on 'OnInsert' Trigger
    # "Risk Grade" Field will be automatically filled-in when the "Risc Score" is choosen, code added on 'OnValidate' Trigger
        of Field "Risk Score"

    HEI.23 FDD - Indirect Customer Master IBM.NAIKH01 28.09.2018
    # Added a new field 50034 - "Contract Type"
    # Added a new Flow Field 50035 - "Customer Relationship"
    # Added code in onValidate Trigger of "Customer Template Code"
    HEI.24 FDD-SLSGAP020  IBM HORTOC01 25.10.2018 # new field "Customer Description" used for customer interface
    HEI.25 RFC-CHG0255777 IBM.LS 17.12.2018
    # New Fields created: 50040 - "Min. Order Value Limit"
                            50041 - "Min. Order Value Limit Type"
    HEI.26 RFC-CHG0264361 IBM.AB 20.12.2018
    # New Fields created: 50042 - "Trading End Date"
    HEI.27 PRMBREAKAGES IBM ISYED01 03.06.2019
    # NEw filed created "Compensate RPM Differences"    
    HEI.30 Defect #4398 IBM NASTAA02 28.08.2019 # Sales order created for blocked SOLD To customer (Ref to #4316)
    # When "Bill-to Customer No." is Blocked with option "All" no document should be created
    HEI.31 RFC-CHG2007388 IBM.KUMARN15 12.09.2019
    # New field created: 50047 - "Available for Sales Order/Return Order"
    HEI.32 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    # New fields added
        # 10860Payment in progress (LCY)
    HEI.33 FDD-HT658 IBM.GUNERE01 23.09.2019 # "No. of Shipping Agent Rel." field added
    HEI.34 FDD-HT587 IBM BULIMC01 14/10/2019 - new flowfield created: 50048-"Classification"
    HEI.36 CHG2035637 IBM.LS 14.01.2020
    # Code added to update the following fields Blocked and "Blocked Reason Code".
    HEI.37 CHG2034524 FDD-HT788 IBM GAVANM01 25.02.2020
    # New field added: 60013 - Search
    HEI.38 Defect ID 5294 IBM GAVANM01 31.03.2020
    # New code in function CopyToDefaultDimensions
    DITW114.00.15 DDR 28/07/2020 NRQ#152502 Fix (#103941) Wrong overdue date checking & sorting entries in function HasGracePeriodOverdueDate()
    HEI.39 FDD-HB1609 CHG2074002 IBM BULIMC01 26.08.2020 #new boolean field added: 60014 -"Free Goods Accounting (HNK)"
    DITW114.00.15 NLAB 16/11/2020 NRQ#163535 Adjust Filter on  CalcAvailableCreditCommon()
    DITW114.00.15 NLAB 16/11/2020 - 26/11/2020 NRQ#163535 Adjust Filter on  CalcAvailableCreditCommon() and CalcAvailableDepositCommon()
    DITW114.00.15 NLAB 11/02/2021 NRQ#172616 Exclude negative entries from overdue calculation
    HEI.40 CHG2084621 IBM GAVANM01 23.03.2021 # Sales Quotes functionality
    # code changes in function CheckBlockedCustOnDocs2
    DITW110.00.11 ASA 13/11/2017 NRQ#18375 Disable Code OnValidate Route & "Responsibility Center"
    HEI.41 CHG2115040 HB2342 IBM GAVANM01 16.08.2021 #SEM Customer Integration
    # New field 50049 - SEM Id, created for SEM Interface
    HEI.42 CHG2129700 INC3758798 IBM GAVANM01 06.10.2021 #SEM ID is not available for Mendix
    # Change in Properties: Editable = No for field 50049SEM Id
    DITW114.00.15 EZOG 22/10/2021 NRQ#198973  not take into account Deposit customer ledger entries when Overdue approval setup
    NRQ199479 EZOG 22/10/2021 Merge NRQ#198973
    HEI.43 CHG2178940 IBM COSTES04  16.01.2023 # Add Required Freshness field on Customer Card
    # Add new field Required Freshness
    HEI.44 CHG2194603 HB3289 COSTES04 15.11.2023 Electronic invoice interface
    # New fields Reg. Structure Grouping Code, Reg. Structure Grouping Description    
    */
    // BC Upgrade BHARDA11 >>
    // Migration from NAV 2018 to Business Central 26
    // SUMMARY OF CHANGES:
    // ===================
    // 1. FIELD LENGTH CHANGES (Cannot be modified in BC Extensions):
    //    - Address: Attempted 50→60, BC already has 100 (no change needed)
    //    - Address 2: Attempted 50→60, BC base is 50 (CANNOT MODIFY)
    //    - City: Attempted 30→35, BC base is 30 (CANNOT MODIFY)
    //    - Customer Posting Group: Field length 20 in BC (no change needed)
    //    - Salesperson Code: Field length 20 in BC (no change needed)
    //    - Gen. Bus. Posting Group: Field length 20 in BC (no change needed)
    //    - No. Series: Field length 20 in BC (no change needed)
    //    - VAT Bus. Posting Group: Field length 20 in BC (no change needed)
    //
    // 2. DRINK-IT CUSTOM FIELDS COMMENTED (Total: 100+ Fields):
    //    Range: 2013610..2035394
    // 3. DRINK-IT CUSTOM KEYS COMMENTED 
    // 4. For Custom Code or events , we create Codeunit -- Customer Events
    // 5. There is a code on function CheckBlockedCustOnJnls //HEI.15>> so we use this event OnBeforeCheckBlockedCust.
    // 6. There is a code on Trigger OnInsert() //<<HEI.05 and //HEI.22>> So we use this Event OnBeforeCheckBlockedCust.
    // BC Upgrade BHARDA11 

    // BC Upgrade MISHRS14 >>
    // Changed datatype of DocType from option to enum to remove warning in CU-50998 in procedure - CheckBlockedCustOnDocs2.
    // Blocked a line to remove warning in modify (Blocked) as its enum so OptionCaptionML not required.
    // Blocked a line to remove warning in modify(Application Method) as its enum so OptionCaptionML not required.
    // Blocked a line to remove warning in modify(Reserve) as its enum so OptionCaptionML not required.
    // Blocked a line to remove warning in modify(Partner Type) as its enum so OptionCaptionML not required.
    // Blocked a line to remove warning in modify(Shipping Advice) as its enum so OptionCaptionML not required.
    // Blocked a line to remove warning in modify(Copy Sell-to Addr. to Qte From) as its enum so OptionCaptionML not required.
    // Blocked with statement as its depreceted in procedure - CheckBlockedCustOnDocs2.
    // BC Upgrade MISHRS14 <<

    // BC Upgrade SHUKLP03 >> OTC008 Testscript changes.

    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
            //BCUPGREAD>>
            //TO REMOVE DRINKIT
            //CaptionClass = GetCaptionClassPM(FIELDCAPTION("No."),Text2014310_1);
            //BCUPGREAD<<

        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Search Name")
        {
            CaptionML = ENU = 'Search Name', FRA = 'Nom de recherche';
        }
        modify("Name 2")
        {
            CaptionML = ENU = 'Name 2', FRA = 'Nom 2';
        }
        modify(Address)
        {
            // BC Upgrade BHARDA11 --- Field Length change 50 to 60 , It is not implement in BC . Now field length is 100.
            //Unsupported feature: Change Data type on "Address(Field 5)". Please convert manually.

            CaptionML = ENU = 'Address', FRA = 'Adresse';
            Description = 'HEI.04';
            //Unsupported feature: Change Description on "Address(Field 5)". Please convert manually.

        }
        modify("Address 2")
        {
            // BC Upgrade BHARDA11 --- Field Length change 50 to 60 , It is not implement in BC . Now field length is 50.

            //Unsupported feature: Change Data type on ""Address 2"(Field 6)". Please convert manually.

            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
            Description = 'HEI.04';

            //Unsupported feature: Change Description on ""Address 2"(Field 6)". Please convert manually.

        }
        modify(City)
        {
            // BC Upgrade BHARDA11 --- Field Length change 30 to 35, It is not implement in BC . Now field length is 30.

            //Unsupported feature: Change Data type on "City(Field 7)". Please convert manually.


            //Unsupported feature: Change TableRelation on "City(Field 7)". Please convert manually.

            CaptionML = ENU = 'City', FRA = 'Ville';
            Description = 'HEI.04';

            //Unsupported feature: Change Description on "City(Field 7)". Please convert manually.

        }
        modify(Contact)
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
        }
        modify("Phone No.")
        {
            CaptionML = ENU = 'Phone No.', FRA = 'N° téléphone';
        }
        modify("Telex No.")
        {
            CaptionML = ENU = 'Telex No.', FRA = 'N° télex';
        }
        modify("Document Sending Profile")
        {
            CaptionML = ENU = 'Document Sending Profile', FRA = 'Profil d''envoi de documents';
        }
        modify("Our Account No.")
        {
            CaptionML = ENU = 'Our Account No.', FRA = 'Notre n° cpte/fourn.';
        }
        modify("Territory Code")
        {
            CaptionML = ENU = 'Territory Code', FRA = 'Code secteur';
        }
        modify("Global Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Code"(Field 16)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Code"(Field 17)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("Chain Name")
        {
            CaptionML = ENU = 'Chain Name', FRA = 'Nom du groupe';
        }
        modify("Budgeted Amount")
        {
            CaptionML = ENU = 'Budgeted Amount', FRA = 'Montant budgété';
        }
        modify("Credit Limit (LCY)")
        {
            CaptionML = ENU = 'Credit Limit (LCY)', FRA = 'Crédit autorisé DS';
        }
        modify("Customer Posting Group")
        {
            // BC Upgrade BHARDA11 ---Field Length changes 20 to 10, Not imlement in BC. Now Field length is 20.
            CaptionML = ENU = 'Customer Posting Group', FRA = 'Groupe compta. client';
            //BCUPGREAD>>
            //TO REMOVE DRINKIT            
            //CaptionClass = GetCaptionClassPM(FIELDCAPTION("Customer Posting Group"),Text2014310_21);
            //BCUPGREAD>>            
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Customer Price Group")
        {
            CaptionML = ENU = 'Customer Price Group', FRA = 'Groupe prix client';
            //BCUPGREAD>>            
            //CaptionClass = GetCaptionClassPM(FIELDCAPTION("Customer Price Group"),Text2014310_23);
            //BCUPGREAD<<            
        }
        modify("Language Code")
        {
            CaptionML = ENU = 'Language Code', FRA = 'Code langue';
        }
        modify("Statistics Group")
        {
            CaptionML = ENU = 'Statistics Group', FRA = 'Groupe statistiques';
        }
        modify("Payment Terms Code")
        {
            CaptionML = ENU = 'Payment Terms Code', FRA = 'Code conditions paiement';
        }
        modify("Fin. Charge Terms Code")
        {
            CaptionML = ENU = 'Fin. Charge Terms Code', FRA = 'Code condition intérêts';
        }
        modify("Salesperson Code")
        {
            // BC Upgrade BHARDA11 ---Field Length changes 20 to 10, Not imlement in BC. Now Field length is 20.

            //Unsupported feature: Change TableRelation on ""Salesperson Code"(Field 29)". Please convert manually.

            CaptionML = ENU = 'Salesperson Code', FRA = 'Code vendeur';
        }
        modify("Shipment Method Code")
        {
            CaptionML = ENU = 'Shipment Method Code', FRA = 'Code condition livraison';
        }
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Shipping Agent Code', FRA = 'Code transporteur';
        }
        modify("Place of Export")
        {
            CaptionML = ENU = 'Place of Export', FRA = 'Lieu d''exportation';
        }
        modify("Invoice Disc. Code")
        {
            CaptionML = ENU = 'Invoice Disc. Code', FRA = 'Code remise facture';
        }
        modify("Customer Disc. Group")
        {
            CaptionML = ENU = 'Customer Disc. Group', FRA = 'Groupe rem. client';
        }
        modify("Country/Region Code")
        {

            //Unsupported feature: Change TableRelation on ""Country/Region Code"(Field 35)". Please convert manually.

            CaptionML = ENU = 'Country/Region Code', FRA = 'Code pays/région';
        }
        modify("Collection Method")
        {
            CaptionML = ENU = 'Collection Method', FRA = 'Mode de recouvrement';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify(Comment)
        {

            //Unsupported feature: Change CalcFormula on "Comment(Field 38)". Please convert manually.

            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify(Blocked)
        {
            CaptionML = ENU = 'Blocked', FRA = 'Bloqué';

            // BC Upgrade MISHRS14 >>
            // Blocked below line to remove warning as modify (Blocked) is enum so OptionCaptionML not required
            //OptionCaptionML = ENU = ' ,Ship,Invoice,All,Payment', FRA = ' ,Livrer,Facturer,Tous,Paiement';
            // BC Upgrade MISHRS14 <<

            //Unsupported feature: Change OptionString on "Blocked(Field 39)". Please convert manually.


            //Unsupported feature: Change Description on "Blocked(Field 39)". Please convert manually.

        }
        //modify("Invoice Copies")
        // {
        //           CaptionML = ENU = 'Invoice Copies', FRA = 'Nombre exemplaires facture';

        //Unsupported feature: Change MinValue on ""Invoice Copies"(Field 40)". Please convert manually.

        //        }
        modify("Last Statement No.")
        {
            CaptionML = ENU = 'Last Statement No.', FRA = 'N° dern. relevé';

            //Unsupported feature: Change MinValue on ""Last Statement No."(Field 41)". Please convert manually.

        }
        modify("Print Statements")
        {
            CaptionML = ENU = 'Print Statements', FRA = 'Imprimer relevés';
        }
        modify("Bill-to Customer No.")
        {
            CaptionML = ENU = 'Bill-to Customer No.', FRA = 'N° client facturé';
        }
        modify(Priority)
        {
            CaptionML = ENU = 'Priority', FRA = 'Priorité';
        }
        modify("Payment Method Code")
        {
            CaptionML = ENU = 'Payment Method Code', FRA = 'Code mode de règlement';
        }
        modify("Last Date Modified")
        {
            CaptionML = ENU = 'Last Date Modified', FRA = 'Date dern. modification';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify("Global Dimension 1 Filter")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Filter"(Field 56)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Filter', FRA = 'Filtre axe principal 1';
        }
        modify("Global Dimension 2 Filter")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Filter"(Field 57)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Filter', FRA = 'Filtre axe principal 2';
        }
        modify(Balance)
        {

            //Unsupported feature: Change CalcFormula on "Balance(Field 58)". Please convert manually.

            CaptionML = ENU = 'Balance', FRA = 'Solde';

            //Unsupported feature: Change Description on "Balance(Field 58)". Please convert manually.

        }
        modify("Balance (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Balance (LCY)"(Field 59)". Please convert manually.

            CaptionML = ENU = 'Balance (LCY)', FRA = 'Solde DS';

            //Unsupported feature: Change Description on ""Balance (LCY)"(Field 59)". Please convert manually.

        }
        modify("Net Change")
        {

            //Unsupported feature: Change CalcFormula on ""Net Change"(Field 60)". Please convert manually.

            CaptionML = ENU = 'Net Change', FRA = 'Solde période';

            //Unsupported feature: Change Description on ""Net Change"(Field 60)". Please convert manually.

        }
        modify("Net Change (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Net Change (LCY)"(Field 61)". Please convert manually.

            CaptionML = ENU = 'Net Change (LCY)', FRA = 'Solde période DS';

            //Unsupported feature: Change Description on ""Net Change (LCY)"(Field 61)". Please convert manually.

        }
        modify("Sales (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Sales (LCY)"(Field 62)". Please convert manually.

            CaptionML = ENU = 'Sales (LCY)', FRA = 'Ventes DS';

            //Unsupported feature: Change Description on ""Sales (LCY)"(Field 62)". Please convert manually.

        }
        modify("Profit (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Profit (LCY)"(Field 63)". Please convert manually.

            CaptionML = ENU = 'Profit (LCY)', FRA = 'Marge DS';

            //Unsupported feature: Change Description on ""Profit (LCY)"(Field 63)". Please convert manually.

        }
        modify("Inv. Discounts (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Inv. Discounts (LCY)"(Field 64)". Please convert manually.

            CaptionML = ENU = 'Inv. Discounts (LCY)', FRA = 'Remises facture DS';

            //Unsupported feature: Change Description on ""Inv. Discounts (LCY)"(Field 64)". Please convert manually.

        }
        modify("Pmt. Discounts (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Pmt. Discounts (LCY)"(Field 65)". Please convert manually.

            CaptionML = ENU = 'Pmt. Discounts (LCY)', FRA = 'Escomptes DS';

            //Unsupported feature: Change Description on ""Pmt. Discounts (LCY)"(Field 65)". Please convert manually.

        }
        modify("Balance Due")
        {

            //Unsupported feature: Change CalcFormula on ""Balance Due"(Field 66)". Please convert manually.

            CaptionML = ENU = 'Balance Due', FRA = 'Solde dû';

            //Unsupported feature: Change Description on ""Balance Due"(Field 66)". Please convert manually.

        }
        modify("Balance Due (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Balance Due (LCY)"(Field 67)". Please convert manually.

            CaptionML = ENU = 'Balance Due (LCY)', FRA = 'Solde dû DS';

            //Unsupported feature: Change Description on ""Balance Due (LCY)"(Field 67)". Please convert manually.

        }
        modify(Payments)
        {

            //Unsupported feature: Change CalcFormula on "Payments(Field 69)". Please convert manually.

            CaptionML = ENU = 'Payments', FRA = 'Paiements';

            //Unsupported feature: Change Description on "Payments(Field 69)". Please convert manually.

        }
        modify("Invoice Amounts")
        {

            //Unsupported feature: Change CalcFormula on ""Invoice Amounts"(Field 70)". Please convert manually.

            CaptionML = ENU = 'Invoice Amounts', FRA = 'Montants factures';

            //Unsupported feature: Change Description on ""Invoice Amounts"(Field 70)". Please convert manually.

        }
        modify("Cr. Memo Amounts")
        {

            //Unsupported feature: Change CalcFormula on ""Cr. Memo Amounts"(Field 71)". Please convert manually.

            CaptionML = ENU = 'Cr. Memo Amounts', FRA = 'Montants avoirs';

            //Unsupported feature: Change Description on ""Cr. Memo Amounts"(Field 71)". Please convert manually.

        }
        modify("Finance Charge Memo Amounts")
        {

            //Unsupported feature: Change CalcFormula on ""Finance Charge Memo Amounts"(Field 72)". Please convert manually.

            CaptionML = ENU = 'Finance Charge Memo Amounts', FRA = 'Montants intérêts de retard';

            //Unsupported feature: Change Description on ""Finance Charge Memo Amounts"(Field 72)". Please convert manually.

        }
        modify("Payments (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Payments (LCY)"(Field 74)". Please convert manually.

            CaptionML = ENU = 'Payments (LCY)', FRA = 'Paiements DS';

            //Unsupported feature: Change Description on ""Payments (LCY)"(Field 74)". Please convert manually.

        }
        modify("Inv. Amounts (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Inv. Amounts (LCY)"(Field 75)". Please convert manually.

            CaptionML = ENU = 'Inv. Amounts (LCY)', FRA = 'Montants factures DS';

            //Unsupported feature: Change Description on ""Inv. Amounts (LCY)"(Field 75)". Please convert manually.

        }
        modify("Cr. Memo Amounts (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Cr. Memo Amounts (LCY)"(Field 76)". Please convert manually.

            CaptionML = ENU = 'Cr. Memo Amounts (LCY)', FRA = 'Montants avoirs DS';

            //Unsupported feature: Change Description on ""Cr. Memo Amounts (LCY)"(Field 76)". Please convert manually.

        }
        modify("Fin. Charge Memo Amounts (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Fin. Charge Memo Amounts (LCY)"(Field 77)". Please convert manually.

            CaptionML = ENU = 'Fin. Charge Memo Amounts (LCY)', FRA = 'Montants int. retard DS';

            //Unsupported feature: Change Description on ""Fin. Charge Memo Amounts (LCY)"(Field 77)". Please convert manually.

        }
        modify("Outstanding Orders")
        {

            //Unsupported feature: Change CalcFormula on ""Outstanding Orders"(Field 78)". Please convert manually.

            CaptionML = ENU = 'Outstanding Orders', FRA = 'Commandes ouvertes';
        }
        modify("Shipped Not Invoiced")
        {

            //Unsupported feature: Change CalcFormula on ""Shipped Not Invoiced"(Field 79)". Please convert manually.

            CaptionML = ENU = 'Shipped Not Invoiced', FRA = 'Livré non facturé';
        }
        modify("Application Method")
        {
            CaptionML = ENU = 'Application Method', FRA = 'Mode de lettrage';

            // BC Upgrade MISHRS14 >>
            // Blocked below line as modify(Application Method) is enum so OptionCaptionML not required.
            //OptionCaptionML = ENU = 'Manual,Apply to Oldest', FRA = 'Manuel,Au plus ancien';
            // BC Upgrade MISHRS14 <<

        }
        modify("Prices Including VAT")
        {
            CaptionML = ENU = 'Prices Including VAT', FRA = 'Prix TTC';
        }
        modify("Location Code")
        {

            //Unsupported feature: Change TableRelation on ""Location Code"(Field 83)". Please convert manually.

            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Fax No.")
        {
            CaptionML = ENU = 'Fax No.', FRA = 'N° télécopie';
        }
        modify("Telex Answer Back")
        {
            CaptionML = ENU = 'Telex Answer Back', FRA = 'Télex retour';
        }
        modify("VAT Registration No.")
        {
            CaptionML = ENU = 'VAT Registration No.', FRA = 'N° identif. intracomm.';
        }
        modify("Combine Shipments")
        {
            CaptionML = ENU = 'Combine Shipments', FRA = 'Regroupement B.L.';
        }
        modify("Gen. Bus. Posting Group")
        {
            // BC Upgrade BHARDA11 ---- Field length change 20 to 10 not implement in BC , Now field length is 20
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marché';
        }
        //BCUPGREAD>>
        //modify(Picture)
        //{
        //    CaptionML = ENU='Picture',FRA='illustration';
        //}
        //BCUPGREAD<<        
        modify(GLN)
        {
            CaptionML = ENU = 'GLN', FRA = 'GLN';
        }
        modify("Post Code")
        {

            //Unsupported feature: Change TableRelation on ""Post Code"(Field 91)". Please convert manually.

            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
        }
        modify(County)
        {
            CaptionML = ENU = 'County', FRA = 'Région';
        }
        modify("Debit Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Debit Amount"(Field 97)". Please convert manually.

            CaptionML = ENU = 'Debit Amount', FRA = 'Montant débit';

            //Unsupported feature: Change Description on ""Debit Amount"(Field 97)". Please convert manually.

        }
        modify("Credit Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Credit Amount"(Field 98)". Please convert manually.

            CaptionML = ENU = 'Credit Amount', FRA = 'Montant crédit';

            //Unsupported feature: Change Description on ""Credit Amount"(Field 98)". Please convert manually.

        }
        modify("Debit Amount (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Debit Amount (LCY)"(Field 99)". Please convert manually.

            CaptionML = ENU = 'Debit Amount (LCY)', FRA = 'Montant débit DS';

            //Unsupported feature: Change Description on ""Debit Amount (LCY)"(Field 99)". Please convert manually.

        }
        modify("Credit Amount (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Credit Amount (LCY)"(Field 100)". Please convert manually.

            CaptionML = ENU = 'Credit Amount (LCY)', FRA = 'Montant crédit DS';

            //Unsupported feature: Change Description on ""Credit Amount (LCY)"(Field 100)". Please convert manually.

        }
        modify("E-Mail")
        {
            CaptionML = ENU = 'Email', FRA = 'Adresse e-mail';
        }
        // modify("Home Page")
        // {
        //     CaptionML = ENU = 'Home Page', FRA = 'Page d''accueil';
        // }
        modify("Reminder Terms Code")
        {
            CaptionML = ENU = 'Reminder Terms Code', FRA = 'Code condition relance';
        }
        modify("Reminder Amounts")
        {

            //Unsupported feature: Change CalcFormula on ""Reminder Amounts"(Field 105)". Please convert manually.

            CaptionML = ENU = 'Reminder Amounts', FRA = 'Montants relances';

            //Unsupported feature: Change Description on ""Reminder Amounts"(Field 105)". Please convert manually.

        }
        modify("Reminder Amounts (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Reminder Amounts (LCY)"(Field 106)". Please convert manually.

            CaptionML = ENU = 'Reminder Amounts (LCY)', FRA = 'Montants relances DS';

            //Unsupported feature: Change Description on ""Reminder Amounts (LCY)"(Field 106)". Please convert manually.

        }
        modify("No. Series")
        {
            // BC Upgrade BHARDA11 ---- Field length change 20 to 10. Not implement in BC. Now field length is 20
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Tax Area Code")
        {
            CaptionML = ENU = 'Tax Area Code', FRA = 'Code zone recouvrement';
        }
        modify("Tax Liable")
        {
            CaptionML = ENU = 'Tax Liable', FRA = 'Soumis à recouvrement';
        }
        modify("VAT Bus. Posting Group")
        {
            // BC Upgrade BHARDA11 ---- Field length change 20 to 10. Not implement in BC. Now field length is 20

            CaptionML = ENU = 'VAT Bus. Posting Group', FRA = 'Groupe compta. marché TVA';
        }
        modify("Currency Filter")
        {
            CaptionML = ENU = 'Currency Filter', FRA = 'Filtre devise';
        }
        modify("Outstanding Orders (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Outstanding Orders (LCY)"(Field 113)". Please convert manually.

            CaptionML = ENU = 'Outstanding Orders (LCY)', FRA = 'Commandes ouvertes DS';
        }
        modify("Shipped Not Invoiced (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Shipped Not Invoiced (LCY)"(Field 114)". Please convert manually.

            CaptionML = ENU = 'Shipped Not Invoiced (LCY)', FRA = 'Livré non facturé DS';
        }
        modify(Reserve)
        {
            CaptionML = ENU = 'Reserve', FRA = 'Réserver';

            // BC Upgrade MISHRS14 >>
            // Blocked below line as modify(Reserve) is enum so OptionCaptionML not required.
            //OptionCaptionML = ENU = 'Never,Optional,Always', FRA = 'Jamais,Manuel,Toujours';
            // BC Upgrade MISHRS14 <<

        }
        modify("Block Payment Tolerance")
        {
            CaptionML = ENU = 'Block Payment Tolerance', FRA = 'Bloquer écart de règlement';
        }
        modify("Pmt. Disc. Tolerance (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Pmt. Disc. Tolerance (LCY)"(Field 117)". Please convert manually.

            CaptionML = ENU = 'Pmt. Disc. Tolerance (LCY)', FRA = 'Validation écart d''escompte DS';

            //Unsupported feature: Change Description on ""Pmt. Disc. Tolerance (LCY)"(Field 117)". Please convert manually.

        }
        modify("Pmt. Tolerance (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Pmt. Tolerance (LCY)"(Field 118)". Please convert manually.

            CaptionML = ENU = 'Pmt. Tolerance (LCY)', FRA = 'Écart de règlement DS';

            //Unsupported feature: Change Description on ""Pmt. Tolerance (LCY)"(Field 118)". Please convert manually.

        }
        modify("IC Partner Code")
        {
            CaptionML = ENU = 'IC Partner Code', FRA = 'Code du partenaire IC';
        }
        modify(Refunds)
        {

            //Unsupported feature: Change CalcFormula on "Refunds(Field 120)". Please convert manually.

            CaptionML = ENU = 'Refunds', FRA = 'Remboursements';

            //Unsupported feature: Change Description on "Refunds(Field 120)". Please convert manually.

        }
        modify("Refunds (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Refunds (LCY)"(Field 121)". Please convert manually.

            CaptionML = ENU = 'Refunds (LCY)', FRA = 'Remboursements DS';

            //Unsupported feature: Change Description on ""Refunds (LCY)"(Field 121)". Please convert manually.

        }
        modify("Other Amounts")
        {

            //Unsupported feature: Change CalcFormula on ""Other Amounts"(Field 122)". Please convert manually.

            CaptionML = ENU = 'Other Amounts', FRA = 'Autres montants';

            //Unsupported feature: Change Description on ""Other Amounts"(Field 122)". Please convert manually.

        }
        modify("Other Amounts (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Other Amounts (LCY)"(Field 123)". Please convert manually.

            CaptionML = ENU = 'Other Amounts (LCY)', FRA = 'Autres montants DS';

            //Unsupported feature: Change Description on ""Other Amounts (LCY)"(Field 123)". Please convert manually.

        }
        modify("Prepayment %")
        {
            CaptionML = ENU = 'Prepayment %', FRA = '% acompte';
        }
        modify("Outstanding Invoices (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Outstanding Invoices (LCY)"(Field 125)". Please convert manually.

            CaptionML = ENU = 'Outstanding Invoices (LCY)', FRA = 'Factures en attente DS';
        }
        modify("Outstanding Invoices")
        {

            //Unsupported feature: Change CalcFormula on ""Outstanding Invoices"(Field 126)". Please convert manually.

            CaptionML = ENU = 'Outstanding Invoices', FRA = 'Factures en attente';
        }
        modify("Bill-to No. Of Archived Doc.")
        {

            //Unsupported feature: Change CalcFormula on ""Bill-to No. Of Archived Doc."(Field 130)". Please convert manually.

            CaptionML = ENU = 'Bill-to No. Of Archived Doc.', FRA = 'Facturation - Nbre de doc. archivés';
        }
        modify("Sell-to No. Of Archived Doc.")
        {

            //Unsupported feature: Change CalcFormula on ""Sell-to No. Of Archived Doc."(Field 131)". Please convert manually.

            CaptionML = ENU = 'Sell-to No. Of Archived Doc.', FRA = 'Vente - Nbre de doc. archivés';
        }
        modify("Partner Type")
        {
            CaptionML = ENU = 'Partner Type', FRA = 'Type partenaire';

            // BC Upgrade MISHRS14 >>
            // Blocked below line as modify(Partner Type) is enum so OptionCaptionML not required.
            //OptionCaptionML = ENU = ' ,Company,Person', FRA = ' ,Société,Personne';
            // BC Upgrade MISHRS14 <<

        }
        modify(Image)
        {
            CaptionML = ENU = 'Image', FRA = 'Image';
        }
        modify("Preferred Bank Account Code")
        {

            //Unsupported feature: Change TableRelation on ""Preferred Bank Account Code"(Field 288)". Please convert manually.

            CaptionML = ENU = 'Preferred Bank Account Code', FRA = 'Code de compte bancaire préféré';
        }
        modify("Cash Flow Payment Terms Code")
        {
            CaptionML = ENU = 'Cash Flow Payment Terms Code', FRA = 'Code modalités de paiement de trésorerie';
        }
        modify("Primary Contact No.")
        {
            CaptionML = ENU = 'Primary Contact No.', FRA = 'N° contact principal';
        }
        modify("Responsibility Center")
        {
            CaptionML = ENU = 'Responsibility Center', FRA = 'Centre de gestion';
        }
        modify("Shipping Advice")
        {
            CaptionML = ENU = 'Shipping Advice', FRA = 'Option d''expédition';

            // BC Upgrade MISHRS14 >>
            // Blocked below line as modify(Shipping Advice) is enum so OptionCaptionML not required.
            //OptionCaptionML = ENU = 'Partial,Complete', FRA = 'Partielle,Totale';
            // BC Upgrade MISHRS14 <<

        }
        modify("Shipping Time")
        {
            CaptionML = ENU = 'Shipping Time', FRA = 'Délai d''expédition';
        }
        modify("Shipping Agent Service Code")
        {

            //Unsupported feature: Change TableRelation on ""Shipping Agent Service Code"(Field 5792)". Please convert manually.

            CaptionML = ENU = 'Shipping Agent Service Code', FRA = 'Code prestation transporteur';
        }
        modify("Service Zone Code")
        {
            CaptionML = ENU = 'Service Zone Code', FRA = 'Code zone service';
        }
        modify("Contract Gain/Loss Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Contract Gain/Loss Amount"(Field 5902)". Please convert manually.

            CaptionML = ENU = 'Contract Gain/Loss Amount', FRA = 'Montant gain/perte contrat';
        }
        modify("Ship-to Filter")
        {

            //Unsupported feature: Change TableRelation on ""Ship-to Filter"(Field 5903)". Please convert manually.

            CaptionML = ENU = 'Ship-to Filter', FRA = 'Filtre destinataire';
        }
        modify("Outstanding Serv. Orders (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Outstanding Serv. Orders (LCY)"(Field 5910)". Please convert manually.

            CaptionML = ENU = 'Outstanding Serv. Orders (LCY)', FRA = 'Commandes serv. ouvertes DS';
        }
        modify("Serv Shipped Not Invoiced(LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Serv Shipped Not Invoiced(LCY)"(Field 5911)". Please convert manually.

            CaptionML = ENU = 'Serv Shipped Not Invoiced(LCY)', FRA = 'Serv. livré non facturé DS';
        }
        modify("Outstanding Serv.Invoices(LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Outstanding Serv.Invoices(LCY)"(Field 5912)". Please convert manually.

            CaptionML = ENU = 'Outstanding Serv.Invoices(LCY)', FRA = 'Factures service en attente DS';
        }
        modify("Allow Line Disc.")
        {

            //Unsupported feature: Change InitValue on ""Allow Line Disc."(Field 7001)". Please convert manually.

            CaptionML = ENU = 'Allow Line Disc.', FRA = 'Autoriser remise ligne';
        }
        modify("No. of Quotes")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Quotes"(Field 7171)". Please convert manually.

            CaptionML = ENU = 'No. of Quotes', FRA = 'Nbre de devis';
        }
        modify("No. of Blanket Orders")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Blanket Orders"(Field 7172)". Please convert manually.

            CaptionML = ENU = 'No. of Blanket Orders', FRA = 'Nbre de commandes ouvertes';
        }
        modify("No. of Orders")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Orders"(Field 7173)". Please convert manually.

            CaptionML = ENU = 'No. of Orders', FRA = 'Nbre de commandes';

            //Unsupported feature: Change Description on ""No. of Orders"(Field 7173)". Please convert manually.

        }
        modify("No. of Invoices")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Invoices"(Field 7174)". Please convert manually.

            CaptionML = ENU = 'No. of Invoices', FRA = 'Nbre de factures';
        }
        modify("No. of Return Orders")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Return Orders"(Field 7175)". Please convert manually.

            CaptionML = ENU = 'No. of Return Orders', FRA = 'Nbre de retours';
        }
        modify("No. of Credit Memos")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Credit Memos"(Field 7176)". Please convert manually.

            CaptionML = ENU = 'No. of Credit Memos', FRA = 'Nbre d''avoirs';
        }
        modify("No. of Pstd. Shipments")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Pstd. Shipments"(Field 7177)". Please convert manually.

            CaptionML = ENU = 'No. of Pstd. Shipments', FRA = 'Nbre d''expéditions enregistrées';
        }
        modify("No. of Pstd. Invoices")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Pstd. Invoices"(Field 7178)". Please convert manually.

            CaptionML = ENU = 'No. of Pstd. Invoices', FRA = 'Nbre de factures enregistrées';
        }
        modify("No. of Pstd. Return Receipts")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Pstd. Return Receipts"(Field 7179)". Please convert manually.

            CaptionML = ENU = 'No. of Pstd. Return Receipts', FRA = 'Nbre de réceptions retour enregistrées';
        }
        modify("No. of Pstd. Credit Memos")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Pstd. Credit Memos"(Field 7180)". Please convert manually.

            CaptionML = ENU = 'No. of Pstd. Credit Memos', FRA = 'Nbre d''avoirs enregistrés';
        }
        modify("No. of Ship-to Addresses")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Ship-to Addresses"(Field 7181)". Please convert manually.

            CaptionML = ENU = 'No. of Ship-to Addresses', FRA = 'Nbre d''adresses destinataire';
        }
        modify("Bill-To No. of Quotes")
        {

            //Unsupported feature: Change CalcFormula on ""Bill-To No. of Quotes"(Field 7182)". Please convert manually.

            CaptionML = ENU = 'Bill-To No. of Quotes', FRA = 'Facturation - Nbre de devis';
        }
        modify("Bill-To No. of Blanket Orders")
        {

            //Unsupported feature: Change CalcFormula on ""Bill-To No. of Blanket Orders"(Field 7183)". Please convert manually.

            CaptionML = ENU = 'Bill-To No. of Blanket Orders', FRA = 'Facturation - Nbre de commandes ouvertes';
        }
        modify("Bill-To No. of Orders")
        {

            //Unsupported feature: Change CalcFormula on ""Bill-To No. of Orders"(Field 7184)". Please convert manually.

            CaptionML = ENU = 'Bill-To No. of Orders', FRA = 'Facturation - Nbre de commandes';
        }
        modify("Bill-To No. of Invoices")
        {

            //Unsupported feature: Change CalcFormula on ""Bill-To No. of Invoices"(Field 7185)". Please convert manually.

            CaptionML = ENU = 'Bill-To No. of Invoices', FRA = 'Facturation - Nbre de factures';
        }
        modify("Bill-To No. of Return Orders")
        {

            //Unsupported feature: Change CalcFormula on ""Bill-To No. of Return Orders"(Field 7186)". Please convert manually.

            CaptionML = ENU = 'Bill-To No. of Return Orders', FRA = 'Facturation - Nbre de retours';
        }
        modify("Bill-To No. of Credit Memos")
        {

            //Unsupported feature: Change CalcFormula on ""Bill-To No. of Credit Memos"(Field 7187)". Please convert manually.

            CaptionML = ENU = 'Bill-To No. of Credit Memos', FRA = 'Facturation - Nbre d''avoirs';
        }
        modify("Bill-To No. of Pstd. Shipments")
        {

            //Unsupported feature: Change CalcFormula on ""Bill-To No. of Pstd. Shipments"(Field 7188)". Please convert manually.

            CaptionML = ENU = 'Bill-To No. of Pstd. Shipments', FRA = 'Facturation - Nbre d''expéditions enregistrées';
        }
        modify("Bill-To No. of Pstd. Invoices")
        {

            //Unsupported feature: Change CalcFormula on ""Bill-To No. of Pstd. Invoices"(Field 7189)". Please convert manually.

            CaptionML = ENU = 'Bill-To No. of Pstd. Invoices', FRA = 'Facturation - Nbre de factures enregistrées';
        }
        modify("Bill-To No. of Pstd. Return R.")
        {

            //Unsupported feature: Change CalcFormula on ""Bill-To No. of Pstd. Return R."(Field 7190)". Please convert manually.

            CaptionML = ENU = 'Bill-To No. of Pstd. Return R.', FRA = 'Facturation - Nbre de réceptions retour enregistrées';
        }
        modify("Bill-To No. of Pstd. Cr. Memos")
        {

            //Unsupported feature: Change CalcFormula on ""Bill-To No. of Pstd. Cr. Memos"(Field 7191)". Please convert manually.

            CaptionML = ENU = 'Bill-To No. of Pstd. Cr. Memos', FRA = 'Facturation - Nbre d''avoirs enregistrés';
        }
        modify("Base Calendar Code")
        {
            CaptionML = ENU = 'Base Calendar Code', FRA = 'Code calendrier principal';
        }
        modify("Copy Sell-to Addr. to Qte From")
        {
            CaptionML = ENU = 'Copy Sell-to Addr. to Qte From', FRA = 'Copier adr donn ordre => devis';

            // BC Upgrade MISHRS14 >>
            // Blocked below line as modify(Copy Sell-to Addr. to Qte From) is enum so OptionCaptionML not required.
            //OptionCaptionML = ENU = 'Company,Person', FRA = 'Société,Personne';
            // BC Upgrade MISHRS14 <<

        }


        //Unsupported feature: CodeModification on ""No."(Field 1).OnValidate". Please convert manually.

        //trigger "(Field 1)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "No." <> xRec."No." THEN BEGIN
          SalesSetup.GET;
          NoSeriesMgt.TestManual(SalesSetup."Customer Nos.");
          "No. Series" := '';
        end;
        IF "Invoice Disc. Code" = '' THEN
          "Invoice Disc. Code" := "No.";
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "No." <> xRec."No." then begin
        #2..4
        end;
        if "Invoice Disc. Code" = '' then
          "Invoice Disc. Code" := "No.";
        */
        //end;


        //Unsupported feature: CodeModification on "Name(Field 2).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Search Name" = UPPERCASE(xRec.Name)) OR ("Search Name" = '') THEN
          "Search Name" := Name;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Search Name" = UPPERCASE(xRec.Name)) or ("Search Name" = '') then
          "Search Name" := Name;




        //<< FINXL10.01 AKH 19/07/2017 NRQ#33089
        if (Name <> xRec.Name) then begin
          SalesSetup.GET;
          if (SalesSetup."Customer Auto Dimension Code" <> '') then begin
            txtDimName := DimMgt.fctGetDimNameFromSource(Name,"Name 2");
            if rDimValue.GET(SalesSetup."Customer Auto Dimension Code","No.") and (rDimValue.Name <> txtDimName) then begin
              rDimValue.Name := txtDimName;
              rDimValue.MODIFY;
            end;
          end;
        end;
        //>> FINXL10.01 AKH 19/07/2017 NRQ#33089
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Name 2"(Field 4)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<< FINXL10.01 AKH 19/07/2017 NRQ#33089
        if ("Name 2" <> xRec."Name 2") then begin
          SalesSetup.GET;
          if (SalesSetup."Customer Auto Dimension Code" <> '') then begin
            txtDimName := DimMgt.fctGetDimNameFromSource(Name,"Name 2");
            if rDimValue.GET(SalesSetup."Customer Auto Dimension Code","No.") and (rDimValue.Name <> txtDimName) then begin
              rDimValue.Name := txtDimName;
              rDimValue.MODIFY;
            end;
          end;
        end;
        //>> FINXL10.01 AKH 19/07/2017 NRQ#33089
        */
        //end;


        //Unsupported feature: CodeModification on "City(Field 7).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on "Contact(Field 8).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ContactBusinessRelation.SETCURRENTKEY("Link to Table","No.");
        ContactBusinessRelation.SETRANGE("Link to Table",ContactBusinessRelation."Link to Table"::Customer);
        ContactBusinessRelation.SETRANGE("No.","No.");
        IF ContactBusinessRelation.FINDFIRST THEN
          Cont.SETRANGE("Company No.",ContactBusinessRelation."Contact No.")
        else
          Cont.SETRANGE("Company No.",'');

        IF "Primary Contact No." <> '' THEN
          IF Cont.GET("Primary Contact No.") THEN ;
        IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN
          VALIDATE("Primary Contact No.",Cont."No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        if ContactBusinessRelation.FINDFIRST then
          Cont.SETRANGE("Company No.",ContactBusinessRelation."Contact No.")
        else
          Cont.SETRANGE("Company No.",'');

        if "Primary Contact No." <> '' then
          if Cont.GET("Primary Contact No.") then ;
        if PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK then
          VALIDATE("Primary Contact No.",Cont."No.");
        */
        //end;


        //Unsupported feature: CodeModification on "Contact(Field 8).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF RMSetup.GET THEN
          IF RMSetup."Bus. Rel. Code for Customers" <> '' THEN
            IF (xRec.Contact = '') AND (xRec."Primary Contact No." = '') AND (Contact <> '') THEN BEGIN
              MODIFY;
              UpdateContFromCust.OnModify(Rec);
              UpdateContFromCust.InsertNewContactPerson(Rec,FALSE);
              MODIFY(TRUE);
            end
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if RMSetup.GET then
          if RMSetup."Bus. Rel. Code for Customers" <> '' then
            if (xRec.Contact = '') and (xRec."Primary Contact No." = '') and (Contact <> '') then begin
              MODIFY;
              UpdateContFromCust.OnModify(Rec);
              UpdateContFromCust.InsertNewContactPerson(Rec,false);
              MODIFY(true);
            end
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Credit Limit (LCY)"(Field 20)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.32 DDR 06/04/2009
        cduUserSetupMngt.CheckCustomerCreditLimit(Rec);
        // <<DITW18.00.06A DDR 24/11/2015 DIT-770 #1701
        if "Credit Limit (LCY)" <> 0 then
          "Credit Limit" := true;
        // >>DITW18.00.06A DDR DIT-770 #1701
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Customer Posting Group"(Field 21)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //var
        //FinancialContractHeader : Record "Financial Contract Header";
        //DrinkDepositGroup : Record "Drink Deposit Group";
        //begin
        /*
        //<<DITW18.00.07 VSC 16/02/2016 DIT-770 #1755
        if FinancialContractHeader.READPERMISSION then begin
          // <<DITW15.00.00.35 DDR 23/09/2009
          if "Contract Cust. Post. Gr. Rent" = '' then
            "Contract Cust. Post. Gr. Rent" := "Customer Posting Group";
          if "Contract Cust. Post. Gr. Loan" = '' then
            "Contract Cust. Post. Gr. Loan" := "Customer Posting Group";
          if "Contract Cust. Post. Gr. LoanU" = '' then
            "Contract Cust. Post. Gr. LoanU" := "Customer Posting Group";
          if "Contract Cust. Post. Gr. Maint" = '' then
            "Contract Cust. Post. Gr. Maint" := "Customer Posting Group";
          if "Contract Cust. Post. Gr. Other" = '' then
            "Contract Cust. Post. Gr. Other" := "Customer Posting Group";
          // >>DITW15.00.00.35 DDR
          //<<DITW17.10.03 MSF 08/05/2014 DIT-770 #340
          if "Contract Cust. Post. Gr. Plant" = '' then
            "Contract Cust. Post. Gr. Plant"  := "Customer Posting Group";
          if "Contract Cust. Post. Gr. Plant" = '' then
            "Contract Cust. Post. Gr. Plant"  :="Customer Posting Group";
          //>>DITW17.10.03 MSF 08/05/2014 DIT-770 #340
        end;

        if DrinkDepositGroup.READPERMISSION then begin
          // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
          if ("Deposit Cust. Posting Group" = '') and "Split Deposit on Invoice" then
            "Deposit Cust. Posting Group" := "Customer Posting Group";
          // >>DITW16.00.00.42 DDR DIT-715 #370
        end;
        //>>DITW18.00.07 VSC DIT-770 #1755
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Payment Terms Code"(Field 27)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW16.00.00.42 DDR 11/12/2012 DIT-715 #370
        if ("Deposit Payment Terms Code" = '') and "Split Deposit on Invoice" then
          VALIDATE("Deposit Payment Terms Code","Payment Terms Code");
        // >>DITW16.00.00.42 DDR DIT-715 #370
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Shipment Method Code"(Field 30)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<<DITW17.00.02 TEC1 12/09/2013 DIT-770 #154
        if (xRec."Shipment Method Code" <> "Shipment Method Code") then begin
          if rShipmentMethod.GET("Shipment Method Code") then
          begin
            if rShipmentMethod."Shipping Agent" <> '' then
              "Shipping Agent Code" := rShipmentMethod."Shipping Agent";
            if rShipmentMethod."Shipping Agent Service Code" <> '' then
              "Shipping Agent Service Code" := rShipmentMethod."Shipping Agent Service Code";
            if rShipmentMethod."Payment Terms" <> '' then
              "Payment Terms Code" := rShipmentMethod."Payment Terms";
            if rShipmentMethod."Payment Method" <> '' then
              "Payment Method Code" := rShipmentMethod."Payment Method";
          end;
        end;
        //>>DITW17.00.02 TEC1 DIT-770 #154
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipping Agent Code"(Field 31).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Shipping Agent Code" <> xRec."Shipping Agent Code" THEN
          VALIDATE("Shipping Agent Service Code",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Shipping Agent Code" <> xRec."Shipping Agent Code" then
          VALIDATE("Shipping Agent Service Code",'');
        */
        //end;


        //Unsupported feature: CodeInsertion on "Blocked(Field 39)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //var
        //    Lbln_Allowed : Boolean;
        //begin
        /*
        //<<DITW17.00.02 SR 10/09/2013 DIT-770 #143 - DITW110.00.08 DDR 02/01/2017 NRQ#0
        if (Blocked <> xRec.Blocked) and (USERID <> '')  then begin
        // <<DITW18.00.06A DDR 23/11/2015 DIT-770 #1714
          GetUserSetup();
          Lbln_Allowed := UserSetup."Release Customer";
        end;
        // >>DITW18.00.06A DDR DIT-770 #1714 -DITW110.00.11 MSF 08/11/2017 NRQ#13577
        if (Blocked <> xRec.Blocked) and  (Blocked = Blocked::" ") and  not Lbln_Allowed then
          ERROR(Text2014412);
        //>>DITW17.00.02 SR DIT-770 #143 -DITW110.00.11 MSF 08/11/2017 NRQ#13577
        // <<DITW110.00.11 MSF 08/11/2017 NRQ#13577
        if (xRec.Blocked <> Rec.Blocked) and (Rec.Blocked = Rec.Blocked::" ") then
        TestMsgTaxRegistration();
        // >>DITW110.00.11 MSF 08/11/2017 NRQ#13577
        /// DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1 - DITW110.00.08 DDR 09/02/2017 NRQ#20699
        // HEI.02 NAIKH01
        if "Netting Agreement" then begin
          if "Vendor No." = '' then
            Blocked := Blocked::All;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Payment Method Code"(Field 47).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Payment Method Code" = '' THEN
          EXIT;
        PaymentMethod.GET("Payment Method Code");
        IF PaymentMethod."Direct Debit" AND ("Payment Terms Code" = '') THEN
          "Payment Terms Code" := PaymentMethod."Direct Debit Pmt. Terms Code";
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Payment Method Code" = '' then
          exit;
        PaymentMethod.GET("Payment Method Code");
        if PaymentMethod."Direct Debit" and ("Payment Terms Code" = '') then
          "Payment Terms Code" := PaymentMethod."Direct Debit Pmt. Terms Code";
        // <<DITW16.00.00.42 DDR 11/12/2012 DIT-715 #370
        if ("Deposit Payment Method Code" = '') and "Split Deposit on Invoice" then
          VALIDATE("Deposit Payment Method Code","Payment Method Code");
        // >>DITW16.00.00.42 DDR DIT-715 #370
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Location Code"(Field 83)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<<DITW18.00.06 MSF 07/07/2015 DIT-770 #1212
        //<< DITW19.00.08 AKH 16/12/2016 BL#9797
        if ("Location Code" <> xRec."Location Code") and ("Location Code" <> '') and (CurrFieldNo <> FIELDNO("Location Code")) then
        //>> DITW19.00.08 AKH BL#9797
          cduUserSetupMngt.CheckResponsiblityCenterLocation("Location Code","Responsibility Center");
        //>>DITW18.00.06 MSF 07/07/2015 DIT-770 #1212
        */
        //end;


        //Unsupported feature: CodeModification on ""VAT Registration No."(Field 86).OnValidate". Please convert manually.

        //trigger "(Field 86)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF VATRegNoFormat.Test("VAT Registration No.","Country/Region Code","No.",DATABASE::Customer) THEN
          IF "VAT Registration No." <> xRec."VAT Registration No." THEN
            VATRegistrationLogMgt.LogCustomer(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if VATRegNoFormat.Test("VAT Registration No.","Country/Region Code","No.",DATABASE::Customer) then
          if "VAT Registration No." <> xRec."VAT Registration No." then
            VATRegistrationLogMgt.LogCustomer(Rec);
        */
        //end;


        //Unsupported feature: CodeModification on ""Gen. Bus. Posting Group"(Field 88).OnValidate". Please convert manually.

        //trigger  Bus();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" THEN
          IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") THEN
            VALIDATE("VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then
          if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") then
            VALIDATE("VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");

        // <<DITW15.00.00.35 DDR 09/10/2009
        if (xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group") and
          ("Gen. Bus. Posting Free Group" = '') and
          ("Gen. Bus. Posting Group" <> '')
        then
          VALIDATE("Gen. Bus. Posting Free Group","Gen. Bus. Posting Group");
        // >>DITW15.00.00.35 DDR
        */
        //end;


        //Unsupported feature: CodeModification on "GLN(Field 90).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF GLN <> '' THEN
          GLNCalculator.AssertValidCheckDigit13(GLN);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if GLN <> '' then
          GLNCalculator.AssertValidCheckDigit13(GLN);
        */
        //end;


        //Unsupported feature: CodeModification on ""Post Code"(Field 91).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""Block Payment Tolerance"(Field 116).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdatePaymentTolerance((CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UpdatePaymentTolerance((CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""IC Partner Code"(Field 119).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec."IC Partner Code" <> "IC Partner Code" THEN BEGIN
          IF NOT CustLedgEntry.SETCURRENTKEY("Customer No.",Open) THEN
            CustLedgEntry.SETCURRENTKEY("Customer No.");
          CustLedgEntry.SETRANGE("Customer No.","No.");
          CustLedgEntry.SETRANGE(Open,TRUE);
          IF CustLedgEntry.FINDLAST THEN
            ERROR(Text012,FIELDCAPTION("IC Partner Code"),TABLECAPTION);

          CustLedgEntry.RESET;
          CustLedgEntry.SETCURRENTKEY("Customer No.","Posting Date");
          CustLedgEntry.SETRANGE("Customer No.","No.");
          AccountingPeriod.SETRANGE(Closed,FALSE);
          IF AccountingPeriod.FINDFIRST THEN BEGIN
            CustLedgEntry.SETFILTER("Posting Date",'>=%1',AccountingPeriod."Starting Date");
            IF CustLedgEntry.FINDFIRST THEN
              IF NOT CONFIRM(Text011,FALSE,TABLECAPTION) THEN
                "IC Partner Code" := xRec."IC Partner Code";
          end;
        end;

        IF "IC Partner Code" <> '' THEN BEGIN
          ICPartner.GET("IC Partner Code");
          IF (ICPartner."Customer No." <> '') AND (ICPartner."Customer No." <> "No.") THEN
            ERROR(Text010,FIELDCAPTION("IC Partner Code"),"IC Partner Code",TABLECAPTION,ICPartner."Customer No.");
          ICPartner."Customer No." := "No.";
          ICPartner.MODIFY;
        end;

        IF (xRec."IC Partner Code" <> "IC Partner Code") AND ICPartner.GET(xRec."IC Partner Code") THEN BEGIN
          ICPartner."Customer No." := '';
          ICPartner.MODIFY;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec."IC Partner Code" <> "IC Partner Code" then begin
          if not CustLedgEntry.SETCURRENTKEY("Customer No.",Open) then
            CustLedgEntry.SETCURRENTKEY("Customer No.");
          CustLedgEntry.SETRANGE("Customer No.","No.");
          CustLedgEntry.SETRANGE(Open,true);
          if CustLedgEntry.FINDLAST then
        #7..11
          AccountingPeriod.SETRANGE(Closed,false);
          if AccountingPeriod.FINDFIRST then begin
            CustLedgEntry.SETFILTER("Posting Date",'>=%1',AccountingPeriod."Starting Date");
            if CustLedgEntry.FINDFIRST then
              if not CONFIRM(Text011,false,TABLECAPTION) then
                "IC Partner Code" := xRec."IC Partner Code";
          end;
        end;

        if "IC Partner Code" <> '' then begin
          ICPartner.GET("IC Partner Code");
          if (ICPartner."Customer No." <> '') and (ICPartner."Customer No." <> "No.") then
        #24..26
        end;

        if (xRec."IC Partner Code" <> "IC Partner Code") and ICPartner.GET(xRec."IC Partner Code") then begin
          ICPartner."Customer No." := '';
          ICPartner.MODIFY;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Primary Contact No."(Field 5049).OnLookup". Please convert manually.

        //trigger "(Field 5049)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ContBusRel.SETCURRENTKEY("Link to Table","No.");
        ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Customer);
        ContBusRel.SETRANGE("No.","No.");
        IF ContBusRel.FINDFIRST THEN
          Cont.SETRANGE("Company No.",ContBusRel."Contact No.")
        else
          Cont.SETRANGE("No.",'');

        IF "Primary Contact No." <> '' THEN
          IF Cont.GET("Primary Contact No.") THEN ;
        IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN BEGIN
          TempCust.COPY(Rec);
          FIND;
          TRANSFERFIELDS(TempCust,FALSE);
          VALIDATE("Primary Contact No.",Cont."No.");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        if ContBusRel.FINDFIRST then
          Cont.SETRANGE("Company No.",ContBusRel."Contact No.")
        else
          Cont.SETRANGE("No.",'');

        if "Primary Contact No." <> '' then
          if Cont.GET("Primary Contact No.") then ;
        if PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK then begin
          TempCust.COPY(Rec);
          FIND;
          TRANSFERFIELDS(TempCust,false);
          VALIDATE("Primary Contact No.",Cont."No.");
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Primary Contact No."(Field 5049).OnValidate". Please convert manually.

        //trigger "(Field 5049)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Contact := '';
        IF "Primary Contact No." <> '' THEN BEGIN
          Cont.GET("Primary Contact No.");

          ContBusRel.SETCURRENTKEY("Link to Table","No.");
          ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Customer);
          ContBusRel.SETRANGE("No.","No.");
          ContBusRel.FINDFIRST;

          IF Cont."Company No." <> ContBusRel."Contact No." THEN
            ERROR(Text003,Cont."No.",Cont.Name,"No.",Name);

          IF Cont.Type = Cont.Type::Person THEN
            Contact := Cont.Name
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        Contact := '';
        if "Primary Contact No." <> '' then begin
        #3..9
          if Cont."Company No." <> ContBusRel."Contact No." then
            ERROR(Text003,Cont."No.",Cont.Name,"No.",Name);

          if Cont.Type = Cont.Type::Person then
            Contact := Cont.Name
        end;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Responsibility Center"(Field 5700)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        /*
        var

            //CurrentRoute : Record Route;
            Confirmed : Boolean;
            CurrentRespCenter : Record "Responsibility Center";
            CurrentLocation : Record Location;
            */
        //begin
        /*
        //<<DITW18.00.06 MSF 07/07/2015 DIT-770 #1212
        //<< DITW19.00.08 AKH 16/12/2016 BL#9797
        if ("Responsibility Center" <> xRec."Responsibility Center") and ("Responsibility Center" <> '') and (CurrFieldNo <> FIELDNO("Responsibility Center"))then
        //>> DITW19.00.08 AKH BL#9797
          cduUserSetupMngt.CheckResponsiblityCenterLocation("Location Code","Responsibility Center");
        //>>DITW18.00.06 MSF 07/07/2015 DIT-770 #1212
        /// DITW19.00.08 AKH 16/12/2016 BL#9797 -DITW110.00.11 ASA 13/11/2017 NRQ#18375
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipping Agent Service Code"(Field 5792).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Shipping Agent Code" <> '') AND
           ("Shipping Agent Service Code" <> '')
        THEN
          IF ShippingAgentService.GET("Shipping Agent Code","Shipping Agent Service Code") THEN
            "Shipping Time" := ShippingAgentService."Shipping Time"
          else
            EVALUATE("Shipping Time",'<>');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Shipping Agent Code" <> '') and
           ("Shipping Agent Service Code" <> '')
        then
          if ShippingAgentService.GET("Shipping Agent Code","Shipping Agent Service Code") then begin
            "Shipping Time" := ShippingAgentService."Shipping Time";
            // <<DITW15.00.00.39 DDR 06/07/2011 #1353
            "Journey Time" := ShippingAgentService."Journey Time";
            // >>DITW15.00.00.39 DDR #1353
          end else begin
            EVALUATE("Shipping Time",'<>');
            // <<DITW15.00.00.39 DDR 06/07/2011 #1353
            EVALUATE("Journey Time",'<>');
            // >>DITW15.00.00.39 DDR #1353
        end;
        */
        //end;
        //BCUPGRADE>>
        /*
        (10860;"Payment in progress (LCY)";Decimal)
        {
            CalcFormula = -Sum("Payment Line"."Amount (LCY)" WHERE ("Account Type"=CONST(Customer),
                                                                    "Account No."=FIELD("No."),
                                                                    "Copied To Line"=CONST(0),
                                                                    "Payment in Progress"=CONST(true)));
            CaptionML = ENU='Payment in progress (LCY)',
                        FRA='Règlement en cours DS';
            Description = 'HEI.32';
            Editable = false;
            FieldClass = FlowField;
        }
        */
        //BCUPGRADE<<

        field(50000; "Blocked Reason Code FND"; Code[20])
        {
            Description = 'FDD-OTCGAP057';
            Caption = 'Blocked Reason Code';
            TableRelation = "Blocked Reason FND".Code;

            trigger OnValidate();
            var
                BlockedReason: Record "Blocked Reason FND";
                CustLedgerEntry: Record "Cust. Ledger Entry";
                DisputeExists: Boolean;
            begin
                //HEI.03>>
                BlockedReason.SETRANGE(Code, "Blocked Reason Code FND");
                BlockedReason.SETRANGE(Type, BlockedReason.Type::Litigation);
                if BlockedReason.findset() then begin
                    repeat
                        DisputeExists := false;
                        CustLedgerEntry.SETRANGE(CustLedgerEntry."Customer No.", "No.");
                        CustLedgerEntry.SETRANGE(CustLedgerEntry."Dispute Case FND", true);
                        if CustLedgerEntry.findset() then begin
                            repeat
                                DisputeExists := true;
                            until CustLedgerEntry.NEXT() = 0;
                        end;

                        if DisputeExists then begin
                            if not CONFIRM(DisputeErr, true, "No.") then begin
                                "Blocked Reason Code FND" := xRec."Blocked Reason Code FND";
                                exit;
                            end;
                        end;
                    until BlockedReason.NEXT() = 0;
                end;
                //HEI.03<<
            end;
        }
        field(50001; "Netting Agreement FND"; Boolean)
        {
            Description = 'FDD-OTCGAP060';
            Caption = 'Netting Agreement';
        }
        field(50002; "Vendor No. FND"; Code[20])
        {
            Description = 'FDD-OTCGAP060';
            TableRelation = Vendor."No.";
            Caption = 'Vendor No.';
        }
        field(50004; "Risk Category FND"; Code[20])
        {
            Description = 'HEI.04';
            Caption = 'Risk Category';
            TableRelation = "Risk Grade FND".Code;
        }
        field(50005; "Risk Score FND"; Integer)
        {
            Description = 'HEI.04';
            Caption = 'Risk Score';
            TableRelation = "Risk Score FND".Code;

            trigger OnValidate();
            var
                RiskGrade: Record "Risk Grade FND";
                SalesSetup: Record "Sales & Receivables Setup";
            begin
                //HEI.22>>
                SalesSetup.GET();
                if "Risk Score FND" = SalesSetup."Default Risk Score FND" then
                    "Risk Category FND" := SalesSetup."Default Risk Grade FND"
                else begin
                    if RiskGrade.findset() then
                        repeat
                            if (("Risk Score FND" >= RiskGrade."Lower Margin") and ("Risk Score FND" <= RiskGrade."Upper Margin")) or
                                (("Risk Score FND" >= RiskGrade."Lower Margin") and (RiskGrade."Upper Margin" = 0))
                            then
                                "Risk Category FND" := RiskGrade.Code;
                        until RiskGrade.NEXT() = 0;
                end;
                //HEI.22<<
            end;
        }
        field(50007; "Tax Registration Number FND"; Boolean)
        {
            CaptionML = ENU = 'Tax Registration Number',
                        FRA = 'Matricule Fiscale';
            Description = 'HEI.05';
        }
        field(50008; "National Identity Card FND"; Boolean)
        {
            CaptionML = ENU = 'National Identity Card',
                        FRA = 'Carte d''identité Nationale';
            Description = 'HEI.05';
        }
        field(50009; "Approval Of Alcohol FND"; Boolean)
        {
            CaptionML = ENU = 'Approval Of Alcohol',
                        FRA = 'Agrément d''alcool';
            Description = 'HEI.05';
        }
        field(50010; "Sales Routes FND"; Code[10])
        {
            Description = 'HEI.19';
            Caption = 'Sales Routes';
            TableRelation = "Sales Routes FND";
        }
        field(50011; "Litigious FND"; Boolean)
        {
            CaptionML = ENU = 'Litigious',
                        FRA = 'Contentieux';
            Description = 'HEI.05';
        }
        field(50012; "WHT Business Posting Group FND"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            Description = 'HEI.05';
            TableRelation = "WHT Business Posting Group FND".Code;
        }
        field(50013; "WHT Payable Amount (LCY) FND"; Decimal)
        {
            CalcFormula = Sum("WHT Entry FND"."Unrealized Amount (LCY)" where("Currency Code" = FIELD("No."),
                                                                           "Remaining Unrealized Amount" = CONST(2)));
            Caption = 'WHT Payable Amount (LCY)';
            Description = 'HEI.05';
            FieldClass = FlowField;
        }
        field(50014; "Return Order Mandatory FND"; Boolean)
        {
            Caption = 'Return Order Mandatory';
            Description = 'HEI.05';
        }
        field(50015; "Account Group FND"; Code[20])
        {
            Caption = 'Account Group';
            Description = 'HEI.07';
            TableRelation = "Account Group FND";

            trigger OnValidate();
            var
                AccountGroup: Record "Account Group FND";
            begin
                //<<HEI.31
                if AccountGroup.GET("Account Group FND") then
                    "Avail.for Sales/ReturnOrd. FND" := AccountGroup."Avail. for Sales/Return Order"
                else
                    "Avail.for Sales/ReturnOrd. FND" := false;
                //>>HEI.31
            end;
        }
        field(50016; "Business Segment FND"; Code[20])
        {
            CalcFormula = Lookup("Customer Attributes FND"."Business Segment" where("Customer No." = FIELD("No.")));
            Caption = 'Business Segment';
            Description = 'HEI.05';
            FieldClass = FlowField;
            TableRelation = "Business Segment FND";
        }
        field(50017; "Business Org. Segment FND"; Code[20])
        {
            CalcFormula = Lookup("Customer Attributes FND"."Business OrganizationalSegment" where("Customer No." = FIELD("No.")));
            Caption = 'Business Organizational Segment';
            Description = 'HEI.05';
            FieldClass = FlowField;
            TableRelation = "Business Org Segment FND";
        }
        field(50018; "Customer Type FND"; Code[20])
        {
            CalcFormula = Lookup("Customer Attributes FND"."Customer Type" where("Customer No." = FIELD("No.")));
            Caption = 'Customer Type';
            Description = 'HEI.05';
            FieldClass = FlowField;
            TableRelation = "Customer Type FND";
        }
        field(50019; "Customer Sub-Type FND"; Code[20])
        {
            CalcFormula = Lookup("Customer Attributes FND"."Customer Sub-Type" where("Customer No." = FIELD("No.")));
            Caption = 'Customer Sub-Type';
            Description = 'HEI.05,HEI.06,HEI.08';
            FieldClass = FlowField;
        }
        field(50020; "Local Customer Sub-Type FND"; Code[20])
        {
            CalcFormula = Lookup("Customer Attributes FND"."Local Customer Sub-Type" where("Customer No." = FIELD("No.")));
            Caption = 'Local Customer Sub-Type';
            Description = 'HEI.05,HEI.06,HEI.08';
            FieldClass = FlowField;
        }
        field(50024; "Interest Rate Credit Amt FND"; Decimal)
        {
            CalcFormula = Sum("G/L Entry".Amount where("Document Type" = FILTER("Interest Rate Credit"),
                                                        "Source Type" = FILTER(Customer),
                                                        "Source No." = FIELD("No.")));
            Caption = 'Interest Rate Credit Amount';
            Description = 'HEI.11';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50025; "Additional RPM Return FND"; Boolean)
        {
            Description = 'HEI.13';
            Caption = 'Additional RPM Return';
        }
        field(50026; "Open Sales RPM Value FND"; Decimal)
        {
            Description = 'HEI.14';
            Caption = 'Open Sales RPM Value';
            Editable = false;
        }
        field(50027; "RPM Exposure FND"; Decimal)
        {
            Description = 'HEI.14';
            Caption = 'RPM Exposure';
        }
        field(50028; "Packaging Credit Value PCV FND"; Decimal)
        {
            Description = 'HEI.13';
            Caption = 'Packaging Credit Value (PCV)';
        }
        field(50029; "FFE Security Amount FND"; Decimal)
        {
            CalcFormula = Sum("G/L Entry".Amount where("Document Type" = FILTER("FFE Security Payment"),
                                                        "Source Type" = FILTER(Customer),
                                                        "Source No." = FIELD("No.")));
            Description = 'HEI.13';
            Caption = 'FFE Security Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50030; "Default Blocked FND"; Option)
        {
            Caption = 'Blocked';
            Description = 'HEI.01';
            OptionCaption = ' ,Ship,Invoice,All,Payment';
            OptionMembers = " ",Ship,Invoice,All,Payment;

            trigger OnValidate();
            var
                Lbln_Allowed: Boolean;
            begin
            end;
        }
        field(50031; "Check Bal/FFE security Amt FND"; Boolean)
        {
            Description = 'HEI.13';
            Caption = 'Check Balance/FFE Security Amount';
        }
        field(50032; "Sensitive Payment Block FND"; Boolean)
        {
            Caption = 'Sensitive Payment Block';
            Description = 'HEI.15';
            Editable = false;
        }
        field(50033; "Sensitive Workflow Block FND"; Boolean)
        {
            Caption = 'Sensitive Workflow Block';
            Description = 'HEI.21';
            Editable = true;
        }
        field(50034; "Contract Type FND"; Option)
        {
            Description = 'HEI.23';
            Caption = 'Contract Type';
            OptionCaption = ' ,CTS Only,Full Contract';
            OptionMembers = " ","CTS Only","Full Contract";
        }
        field(50035; "Customer Relationship FND"; Integer)
        {
            CalcFormula = Count("Customer Relationship FND" where("Customer No." = FIELD("No.")));
            Description = 'HEI.23';
            Caption = 'Customer Relationships';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50036; "Customer Description FND"; Text[250])
        {
            Caption = 'Customer Description';
            Description = 'HEI.24';
        }
        field(50037; "Compensate RPM Differences FND"; Boolean)
        {
            Description = 'HEI.27';
            Caption = 'Compensate RPM Differences';
        }
        field(50040; "Min. Order Value Limit FND"; Decimal)
        {
            Description = 'HEI.25';
            Caption = 'Minimum Order Value Limit';
        }
        field(50041; "Min. Ord. Value Limit Type FND"; Option)
        {
            Description = 'HEI.25';
            Caption = 'Minimum Order Value Limit Type';
            OptionCaption = 'None,Warning,Blocking';
            OptionMembers = "None",Warning,Blocking;
        }
        field(50042; "Trading End Date FND"; Date)
        {
            Description = 'HEI.26';
            Caption = 'Trading End Date';
        }
        field(50043; "Longitude Coordinate FND"; Text[30])
        {
            Description = 'HEI.28';
            Caption = 'Longitude Coordinate';
        }
        field(50044; "Latitude Coordinate FND"; Text[30])
        {
            Description = 'HEI.28';
            Caption = 'Latitude Coordinate';
        }
        field(50045; "Deposit Payment Quantity FND"; Decimal)
        {
            //BCUPGRADE>>
            //TO be uncomented after Drinkit app
            //CalcFormula = Sum("Cust. Ledger Entry"."Deposit Quantity" WHERE ("Document Type"=FILTER(Payment),
            //                                                                 "Item Charge Type"=FILTER(Deposit),
            //                                                                 "Customer No."=FIELD("No.")));
            //BCUPGRADE<<                                                           
            Caption = 'Deposit Payment Quantity';
            DecimalPlaces = 0 : 2;
            Description = 'HEI.29';
            Editable = false;
            // FieldClass = FlowField; //BCUPGRADE
        }
        field(50046; "No. of Shipping Agent Rel. FND"; Integer)
        {
            //BCUPGRADE
            //DRINKIT Field
            //TO Be checked after DRINKIT APP
            //CalcFormula = Count("Shipping Agent Serv. Relation" WHERE (Type=CONST(Customer),
            //                                                           "No."=FIELD("No.")));

            Caption = 'No. of Shipping Agent Service Relations';
            Description = 'HEI.33';
            Editable = false;
            // FieldClass = FlowField; //BCUPGRADE
        }
        field(50047; "Avail.for Sales/ReturnOrd. FND"; Boolean)
        {
            Description = 'HEI.31';
            Caption = 'Available for Sales/Return Order';
            Editable = false;
        }
        field(50048; "Classification FND"; Code[10])
        {
            CalcFormula = Lookup("Customer Attributes FND".Classification where("Customer No." = FIELD("No.")));
            Description = 'HEI.34';
            Caption = 'Classification';
            FieldClass = FlowField;
        }
        field(50049; "SEM Id FND"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.41';
            Caption = 'SEM Id';
            Editable = false;
        }
        field(50050; "Required Freshness FND"; Decimal)
        {
            Caption = 'Required Freshness';
            DataClassification = CustomerContent;
            Description = 'HEI.43';
        }
        field(50051; "Reg. Structure Group. Code FND"; Code[10])
        {
            Caption = 'Reg. Structure Grouping Code';
            DataClassification = CustomerContent;
            Description = 'HEI.44';
            TableRelation = "PAC Post Code FND";
        }
        field(50052; "Reg. Struct. Group. Desc. FND"; Text[100])
        {
            CalcFormula = Lookup("PAC Post Code FND".Description where(Code = FIELD("Reg. Structure Group. Code FND")));
            Caption = 'Reg, Structure Grouping Desc.';
            Description = 'HEI.44';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60000; "House No. FND"; Text[10])
        {
            CalcFormula = Lookup("Customer Attributes FND"."House No. 1" where("Customer No." = FIELD("No.")));
            Caption = 'House No.';
            Description = 'HEI.24';
            FieldClass = FlowField;
        }
        field(60001; "House Supplement 2 FND"; Text[10])
        {
            CalcFormula = Lookup("Customer Attributes FND"."House Supplement 2" where("Customer No." = FIELD("No.")));
            Caption = 'House Supplement 2';
            Description = 'HEI.24';
            FieldClass = FlowField;
        }
        field(60002; "P.O.Box FND"; Text[10])
        {
            CalcFormula = Lookup("Customer Attributes FND"."P.O.Box" where("Customer No." = FIELD("No.")));
            Caption = 'P.O.Box';
            Description = 'HEI.24';
            FieldClass = FlowField;
        }
        field(60003; "Tax Number 1 FND"; Code[20])
        {
            CalcFormula = Lookup("Customer Attributes FND"."Tax Number 1" where("Customer No." = FIELD("No.")));
            Caption = 'Tax Number 1';
            Description = 'HEI.24';
            FieldClass = FlowField;
        }
        field(60004; "Tax Number 2 FND"; Text[11])
        {
            CalcFormula = Lookup("Customer Attributes FND"."Tax Number 2" where("Customer No." = FIELD("No.")));
            Caption = 'Tax Number 2';
            Description = 'HEI.24';
            FieldClass = FlowField;
        }
        field(60005; "Tax Number 3 FND"; Text[18])
        {
            CalcFormula = Lookup("Customer Attributes FND"."Tax Number 3" where("Customer No." = FIELD("No.")));
            Caption = 'Tax Number 3';
            Description = 'HEI.24';
            FieldClass = FlowField;
        }
        field(60006; "Tax Number 4 FND"; Text[18])
        {
            CalcFormula = Lookup("Customer Attributes FND"."Tax Number 4" where("Customer No." = FIELD("No.")));
            Caption = 'Tax Number 4';
            Description = 'HEI.24';
            FieldClass = FlowField;
        }
        field(60007; "Trading Partner FND"; Code[29])
        {
            CalcFormula = Lookup("Customer Attributes FND"."Trading Partner" where("Customer No." = FIELD("No.")));
            Caption = 'Trading Partner';
            Description = 'HEI.24';
            FieldClass = FlowField;
        }
        field(60008; "Street 3 FND"; Text[60])
        {
            CalcFormula = Lookup("Customer Attributes FND"."Street 3" where("Customer No." = FIELD("No.")));
            Caption = 'Street 3';
            Description = 'HEI.24';
            FieldClass = FlowField;
        }
        field(60009; "Street 4 FND"; Text[60])
        {
            CalcFormula = Lookup("Customer Attributes FND"."Street 4" where("Customer No." = FIELD("No.")));
            Caption = 'Street 4';
            Description = 'HEI.24';
            FieldClass = FlowField;
        }
        field(60010; "Street 5 FND"; Text[60])
        {
            CalcFormula = Lookup("Customer Attributes FND"."Street 5" where("Customer No." = FIELD("No.")));
            Caption = 'Street 5';
            Description = 'HEI.24';
            FieldClass = FlowField;
        }
        field(60011; "Flag for Deletion FND"; Boolean)
        {
            CalcFormula = Lookup("Customer Attributes FND"."Flag for Deletion" where("Customer No." = FIELD("No.")));
            Caption = 'Flag for Deletion';
            Description = 'HEI.24';
            FieldClass = FlowField;
        }
        field(60012; "Search 2 FND"; Text[20])
        {
            CalcFormula = Lookup("Customer Attributes FND"."Search 2" where("Customer No." = FIELD("No.")));
            Caption = 'Search 2';
            Description = 'HEI.24';
            FieldClass = FlowField;
        }
        field(60013; "Search FND"; Text[20])
        {
            CalcFormula = Lookup("Customer Attributes FND".Search where("Customer No." = FIELD("No.")));
            Description = 'HEI.37';
            Caption = 'Search';
            FieldClass = FlowField;
        }
        field(60014; "Free Goods Accounting HNK FND"; Boolean)
        {
            Description = 'HEI.39';
            Caption = 'Free Goods Accounting HNK';
        }
        field(60015; "Test1 FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Test1';
        }
        field(50055; "Send Document FND"; Option) // BC Upgrade SHUKLP03 << OTC008
        {
            CaptionML = ENU = 'Send Document',
                        FRA = 'Envoyer Document';
            Description = 'FINXL8.00.001';
            OptionCaptionML = ENU = ' ,Mail,Print,Mail & Print',
                              FRA = ' ,E-Mail,Imprimer,E-Mail & Imprimer';
            OptionMembers = " ",Mail,Print,"Mail & Print";
        }
        // BC Upgrade SHUKLP03 >> Delivary note report => PID 70
        field(50056; "Cross. Ref. on Del. Note FND"; Boolean)
        {
            Caption = 'Cross. Ref. on Del. Note';
            DataClassification = ToBeClassified;
        }
        field(50057; "Exp. Date on Del. Note FND"; Boolean)
        {
            Caption = 'Exp. Date on Del. Note';
            DataClassification = ToBeClassified;
        }
        // BC Upgrade SHUKLP03 << Delivary note report => PID 70


        //BCUPGRADE
        //Sales Net Price - Drinkit Table
        /*
        field(80000;"Last Net sales price";Date)
        {
            CalcFormula = Max("Sales Net Price"."As Per date" WHERE ("Customer No."=FIELD("No.")));
            Caption = 'Last Net sales price';
            Description = 'NRQ61583 MSF 04/06/18';
            Editable = false;
            FieldClass = FlowField;
        }
        */
        //BCUPGRADE 
        //DRINKIT FIELDS
        /*
        field(2013610;"Customer DDeposit Group Code";Code[10])
        {
            CaptionML = ENU='Customer Deposit Group Code',
                        FRA='Code groupe consigne client';
            Description = 'DITW15.00.00.01';
            TableRelation = "Drink Deposit Group".Code WHERE ("Source Type"=CONST(Customer));
        }
        field(2013611;"Empty Goods Item No. Filter";Code[20])
        {
            CaptionML = ENU='Empty Goods Item No. Filter',
                        FRA='Filtre article vidange n°';
            Description = 'DITW15.00.00.01';
            FieldClass = FlowFilter;
            TableRelation = Item;
        }
        field(2013617;"Deposit Limit (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU='Deposit Limit (LCY)',
                        FRA='Crédit consigne DS';
            Description = 'DITW15.00.00.01';

            trigger OnValidate();
            begin
                //<<DITW18.00.06 MVN 02/10/2015 DIT-770 #1524
                cduUserSetupMngt.CheckCustomerDepositLimit(Rec);
                //>>DITW18.00.06 MVN 02/10/2015 DIT-770 #1524
                // <<DITW18.00.06A DDR 24/11/2015 DIT-770 #1701
                if "Deposit Limit (LCY)" <> 0 then
                  "Deposit Limit" := true;
                // >>DITW18.00.06A DDR DIT-770 #1701
            end;
        }
        field(2013618;"Deposit Limit";Boolean)
        {
            CaptionML = ENU='Deposit Limit',
                        FRA='Crédit consigne';
            Description = 'DIT-770 #1701';
        }
        field(2013619;"Deposit Item Balance (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Sales Deposit Amount (Actual)" WHERE ("Item Charge Type"=CONST(Deposit),
                                                                                   "Source Type"=CONST(Customer),
                                                                                   "Source No."=FIELD("No."),
                                                                                   "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                                                                                   "Global Dimension 2 Code"=FIELD("Global Dimension 1 Filter"),
                                                                                   "Empty Goods Item No."=FIELD("Empty Goods Item No. Filter")));
            CaptionML = ENU='Deposit Item Balance (LCY)',
                        FRA='Solde article consigne DS';
            Description = 'DITW15.00.00.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013620;"Deposit Item Balance Due (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Sales Deposit Amount (Actual)" WHERE ("Source Type"=CONST(Customer),
                                                                                   "Source No."=FIELD("No."),
                                                                                   "Posting Date"=FIELD(UPPERLIMIT("Date Filter")),
                                                                                   "Initial Entry Due Date"=FIELD("Date Filter"),
                                                                                   "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                                                                                   "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),
                                                                                   "Empty Goods Item No."=FIELD("Empty Goods Item No. Filter")));
            CaptionML = ENU='Deposit Item Balance Due (LCY)',
                        FRA='Solde article consigne dû DS';
            Description = 'DITW15.00.00.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013621;"Deposit Item Net Change (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Sales Deposit Amount (Actual)" WHERE ("Source No."=FIELD("No."),
                                                                                   "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                                                                                   "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),
                                                                                   "Posting Date"=FIELD("Date Filter"),
                                                                                   "Empty Goods Item No."=FIELD("Empty Goods Item No. Filter")));
            CaptionML = ENU='Deposit Item Net Change (LCY)',
                        FRA='Solde article consigne période DS';
            Description = 'DITW15.00.00.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013622;"Deposit Item Net Chg (LCY) src";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Sales Deposit Amount (Actual)" WHERE ("Item Ledger Entry Source No."=FIELD("No."),
                                                                                   "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                                                                                   "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),
                                                                                   "Posting Date"=FIELD("Date Filter"),
                                                                                   "Empty Goods Item No."=FIELD("Empty Goods Item No. Filter")));
            CaptionML = ENU='Deposit Item Net Change (LCY) Sell-to',
                        FRA='Solde article consigne période DS donneur d''ordre';
            Description = 'DTI-770 #705  - DIT-770 #862 ';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013630;"Deposit Cust. Posting Group";Code[10])
        {
            CaptionML = ENU='Deposit - Customer Posting Group',
                        FRA='Consigne - Groupe compta. client';
            Description = 'DITW16.00.00.42 DIT-715 #370';
            TableRelation = "Customer Posting Group";
        }
        field(2013631;"Deposit Payment Terms Code";Code[10])
        {
            CaptionML = ENU='Deposit - Payment Terms Code',
                        FRA='Consigne - Code conditions paiement';
            Description = 'DITW16.00.00.42 DIT-715 #370';
            TableRelation = "Payment Terms";
        }
        field(2013632;"Deposit Payment Method Code";Code[10])
        {
            CaptionML = ENU='Deposit - Payment Method Code',
                        FRA='Consigne - Code mode de règlement';
            Description = 'DITW16.00.00.42 DIT-715 #370';
            TableRelation = "Payment Method";
        }
        field(2013636;"Split Deposit on Invoice";Boolean)
        {
            CaptionML = ENU='Split Deposit on Invoice (Entries)',
                        FRA='Diviser consigne sur facture (écritures)';
            Description = 'DITW16.00.00.42 DIT-715 #370';

            trigger OnValidate();
            begin
                // <<DITW16.00.00.42 DDR 30/11/2012 11/12/2012 DIT-715 #370
                if "Split Deposit on Invoice" then begin
                  if "Deposit Cust. Posting Group" = '' then
                    VALIDATE("Deposit Cust. Posting Group","Customer Posting Group");
                  if "Deposit Payment Terms Code" = '' then
                    VALIDATE("Deposit Payment Terms Code","Payment Terms Code");
                  if "Deposit Payment Method Code" = '' then
                    VALIDATE("Deposit Payment Method Code","Payment Method Code");
                end;
                // >>DITW16.00.00.42 DDR DIT-715 #370
            end;
        }
        field(2013637;"Deposit Cust. Balance (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE ("Customer No."=FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1"=FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2"=FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code"=FIELD("Currency Filter"),
                                                                                 "Item Charge Type"=CONST(Deposit)));
            CaptionML = ENU='Deposit Balance (LCY)',
                        FRA='Solde consigne DS';
            Description = 'DITW16.00.00.42 DIT-715 #370';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013638;"Deposit Cust.Balance Due (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE ("Customer No."=FIELD("No."),
                                                                                 "Posting Date"=FIELD(UPPERLIMIT("Date Filter")),
                                                                                 "Initial Entry Due Date"=FIELD("Date Filter"),
                                                                                 "Initial Entry Global Dim. 1"=FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2"=FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code"=FIELD("Currency Filter"),
                                                                                 "Item Charge Type"=CONST(Deposit)));
            CaptionML = ENU='Deposit Cust. Balance Due (LCY)',
                        FRA='Solde consigne dû DS';
            Description = 'DITW18.00.07A DIT-770 #2115';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013666;"Autom. Item Charge";Option)
        {
            CaptionML = ENU='Calculate Item Charges',
                        FRA='Calculer Frais annexes';
            Description = 'DITW15.00.00.39 #1407';
            OptionCaptionML = ENU='Direct,Release,Posting,Posting (Excl. Item)',
                              FRA='Direct,Lancé,Validation,Validation (Excl. Article)';
            OptionMembers = " ",Release,Posting,PostingExclItem;
        }
        field(2013667;"Customer DTax Group Code";Code[20])
        {
            CaptionML = ENU='Customer Tax Group Code',
                        FRA='Code groupe taxe client';
            Description = 'DITW15.00.00.01,HEI.05';
            TableRelation = "Drink Tax Group".Code WHERE ("Source Type"=CONST(Customer));

            trigger OnValidate();
            begin
                // <<DITW15.00.00.33 DDR 08/05/2009
                TestMsgTaxRegistration();
                // >>DITW15.00.00.33 DDR
            end;
        }
        field(2013695;"Item Charge Type Filter";Option)
        {
            CaptionML = ENU='Item Charge Type Filter',
                        FRA='Filtre type frais article';
            Description = 'DITW15.00.00.01';
            FieldClass = FlowFilter;
            OptionCaptionML = ENU=' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
                              FRA=' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
            OptionMembers = " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost";
        }
        field(2013726;"Tax Registration No.";Text[20])
        {
            CaptionML = ENU='Tax Registration No.',
                        FRA='N° Registration Taxe';
            Description = 'DITW15.00.00.28';

            trigger OnValidate();
            begin
                // <<DITW15.00.00.33 DDR 08/05/2009 - DITW15.00.00.34 DDR 09/07/2009
                TestMsgTaxRegistration();
                // >>DITW15.00.00.34 DDR
            end;
        }
        field(2013730;"Fiscal Representative No.";Code[20])
        {
            CaptionML = ENU='Fiscal Representative / Customs Agent No.',
                        FRA='N° représentant fiscal / Agent des douanes';
            Description = 'DITW15.00.00.28-.38 #1217';
            TableRelation = "Fiscal Representative";

            trigger OnValidate();
            begin
                // <<DITW15.00.00.33 DDR 08/05/2009
                TestMsgTaxRegistration();
                // >>DITW15.00.00.33 DDR
            end;
        }
        field(2013761;"No. of Drink Disc. Groups";Integer)
        {
            CalcFormula = Count("Drink Discount Relation" WHERE ("Source Type"=CONST(Customer),
                                                                 "Source No."=FIELD("No.")));
            CaptionML = ENU='No. of Drink-It Disc. Groups',
                        FRA='Nombre de Drink-It Groupes remises';
            Description = 'DITW15.00.00.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013762;"Calculate Payment Terms From";Option)
        {
            CaptionML = ENU='Calculate Payment Terms From',
                        FRA='Cacluler Code conditions paiement';
            Description = 'DITW17.00.02 DIT-770 #140';
            OptionCaptionML = ENU='Bill-to Customer,Sell-to Customer',
                              FRA='Client facturé,donneur d''ordre';
            OptionMembers = "Bill-to Customer","Sell-to Customer";
        }
        field(2013763;"Calculate Payment Method From";Option)
        {
            CaptionML = ENU='Calculate Payment Method From',
                        FRA='Calculer méthode de paiement';
            Description = 'DITW17.00.02 DIT-770 #140';
            OptionCaptionML = ENU='Bill-to Customer,Sell-to Customer',
                              FRA='Client facturé,donneur d''ordre';
            OptionMembers = "Bill-to Customer","Sell-to Customer";
        }
        field(2013764;"No. of Promotion Groups";Integer)
        {
            CalcFormula = Count("Drink Promotion Relation" WHERE ("Source Type"=CONST(Customer),
                                                                  "Source No."=FIELD("No.")));
            CaptionML = ENU='No. of Promotion Groups',
                        FRA='Nombre de Groupes promotions';
            Description = 'DITW15.00.00.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013774;"Item DDisc. Group Code";Code[10])
        {
            CaptionML = ENU='Item Disc. Group',
                        FRA='Groupe rem. article';
            Description = 'DITW16.00.00.42 DIT-715 #378';
            TableRelation = "Drink Discount Group".Code WHERE ("Source Type"=CONST(Item));
        }
        field(2013804;"Item DDisc. Group Filter";Code[10])
        {
            CaptionML = ENU='Item Discount Group Filter',
                        FRA='Filtre groupe remise article';
            Description = 'DITW16.00.00.41 DIT-715 #378';
            FieldClass = FlowFilter;
            TableRelation = "Drink Discount Group".Code WHERE ("Source Type"=CONST(Item));
        }
        field(2013812;"Delayed Sequence No. Filter";Integer)
        {
            CaptionML = ENU='Delayed Sequence No.',
                        FRA='N° séquence retardé';
            Description = 'DITW17.00.01';
            FieldClass = FlowFilter;
        }
        field(2013823;"Gen. Bus. Posting Free Group";Code[10])
        {
            CaptionML = ENU='Gen. Bus. Posting Group Free item',
                        FRA='Groupe article gratuit compta. marché';
            Description = 'DITW15.00.00.35';
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate();
            begin
                if "Gen. Bus. Posting Free Group" = '' then
                  "Free Item Posting Type" := "Free Item Posting Type"::" ";
            end;
        }
        field(2013825;"Free Item Posting Type";Option)
        {
            CaptionML = ENU='Calculate Price on Free',
                        FRA='Calculer Prix sur gratuit';
            Description = 'DITW15.00.00.35';
            OptionCaptionML = ENU=' ,Price 0,Discount 100%',
                              FRA=' ,Prix 0,Remise 100%';
            OptionMembers = " ",Price,Amount;

            trigger OnValidate();
            begin
                if "Free Item Posting Type" = "Free Item Posting Type"::" " then
                  "Gen. Bus. Posting Free Group" := '';
            end;
        }
        field(2013826;"Free Item";Boolean)
        {
            CaptionML = ENU='Free Item',
                        FRA='Article gratuit';
            Description = 'DITW17.00.02 DIT-770 #132';

            trigger OnValidate();
            begin
                //<< DITW17.00.02 TEC1 12/09/2013 DIT-770 #132
                if not "Free Item" then
                  "Free Reason Code" := '';
                //<< DITW17.00.02 TEC1 DIT-770 #132
            end;
        }
        field(2013827;"Free Reason Code";Code[10])
        {
            CaptionML = ENU='Free Reason Code',
                        FRA='Code motif gratuit';
            Description = 'DITW17.00.02 DIT-770 #132';
            TableRelation = "Free Reason Code";

            trigger OnValidate();
            begin
                //<< DITW17.00.02 TEC1 12/09/2013 DIT-770 #132
                "Free Item" := "Free Reason Code" <> '';
                //>> DITW17.00.02 TEC1 DIT-770 #132
            end;
        }
        field(2013830;"Delayed Balance (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Delayed Disc. & Promo. Line"."Remaining Amount (LCY)" WHERE ("Status Customer No."=FIELD("No."),
                                                                                            "Entry Type"=CONST(Discount),
                                                                                            Status=FILTER(Approved|Processing)));
            CaptionML = ENU='Delayed Discount Balance (LCY)',
                        FRA='Solde Remises retardées DS';
            Description = 'DITW15.00.00.37';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013831;"Delayed Balance Due (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Delayed Disc. & Promo. Line"."Remaining Amount (LCY)" WHERE ("Status Customer No."=FIELD("No."),
                                                                                            "Entry Type"=CONST(Discount),
                                                                                            Status=FILTER(Approved|Processing),
                                                                                            "Due Date"=FIELD("Date Filter")));
            CaptionML = ENU='Delayed Discount Balance Due (LCY)',
                        FRA='Solde Remises retardées dû DS';
            Description = 'DITW15.00.00.37';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013832;"Delayed Net Change (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Delayed Disc. & Promo. Line"."Remaining Amount (LCY)" WHERE ("Status Customer No."=FIELD("No."),
                                                                                            "Entry Type"=CONST(Discount),
                                                                                            Status=FILTER(Approved|Processing),
                                                                                            "Status Posting Date"=FIELD("Date Filter")));
            CaptionML = ENU='Delayed Discount Net Change (LCY)',
                        FRA='Solde Remises retardées période DS';
            Description = 'DITW15.00.00.37';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013833;"No. of Pstd. Delayed Disc.";Integer)
        {
            CalcFormula = Count("Delayed Disc. & Promo. Entry" WHERE ("Bill-to Customer No."=FIELD("No."),
                                                                      "Entry Type"=CONST(Discount)));
            CaptionML = ENU='No. of Pstd. Delayed Discounts',
                        FRA='Nbre de remises retardées enregistrées';
            Description = 'DITW15.00.00.39 #1230';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013834;"No. of Pstd. Delayed Promo.";Integer)
        {
            CalcFormula = Count("Delayed Disc. & Promo. Entry" WHERE ("Bill-to Customer No."=FIELD("No."),
                                                                      "Entry Type"=CONST(Promotion)));
            CaptionML = ENU='No. of Pstd. Delayed Promotions',
                        FRA='Nbre de promotions retardées enregistrées';
            Description = 'DITW15.00.00.39 #1230';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013910;"Caller-ID";Code[50])
        {
            CaptionML = ENU='Caller-ID',
                        FRA='ID Appelant';
            Description = 'DITW15.00.00.39 RBE 20/04/2011 #1230';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup();
            var
                UserMgt : Codeunit "User Management";
            begin
                UserMgt.LookupUserID("Caller-ID");
                //<<DITW17.00.02 AT  28/01/2014 DIT-770 #303
                VALIDATE("Caller-ID");
                //>>DITW17.00.02 AT  28/01/2014 DIT-770 #303
            end;

            trigger OnValidate();
            begin
                //<<DITW17.00.02 AT  28/01/2014 DIT-770 #303
                if xRec."Caller-ID" <> "Caller-ID" then
                begin
                  CustCalenderChanges.RESET;
                  CustCalenderChanges.SETRANGE("Source Type",CustCalenderChanges."Source Type"::Customer);
                  CustCalenderChanges.SETRANGE("Source Code","No.");
                  if CustCalenderChanges.findset then
                  repeat
                    CustCalenderChanges.VALIDATE("Caller-ID","Caller-ID");
                    CustCalenderChanges.MODIFY;
                  until CustCalenderChanges.NEXT = 0;
                end;
                //>>DITW17.00.02 AT  28/01/2014 DIT-770 #303
            end;
        }
        field(2013911;"Sell-to Contact No.";Code[20])
        {
            CaptionML = ENU='Sell-to Contact No.',
                        FRA='N° contact donneur d''ordre';
            Description = 'DITW15.00.00.39 RBE 20/04/2011 #1230';
            TableRelation = Contact;

            trigger OnLookup();
            var
                Cont : Record Contact;
                ContBusinessRelation : Record "Contact Business Relation";
            begin
                //  <<DITW15.00.00.39 RBE 20/04/2011 #1230
                if Cont.GET("Sell-to Contact No.") then
                  Cont.SETRANGE("Company No.",Cont."Company No.")
                else begin
                  ContBusinessRelation.RESET;
                  ContBusinessRelation.SETCURRENTKEY("Link to Table","No.");
                  ContBusinessRelation.SETRANGE("Link to Table",ContBusinessRelation."Link to Table"::Customer);
                  ContBusinessRelation.SETRANGE("No.","No.");
                  if ContBusinessRelation.FINDFIRST then
                    Cont.SETRANGE("Company No.",ContBusinessRelation."Contact No.")
                  else
                    Cont.SETRANGE("No.",'');
                end;

                if "Sell-to Contact No." <> '' then
                  if Cont.GET("Sell-to Contact No.") then ;
                if PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK then begin
                  xRec := Rec;
                  VALIDATE("Sell-to Contact No.",Cont."No.");
                end;
                //  >>DITW15.00.00.39 RBE #1230
            end;

            trigger OnValidate();
            var
                ContBusinessRelation : Record "Contact Business Relation";
                Cont : Record Contact;
                Opportunity : Record Opportunity;
                ChangeLogMgt : Codeunit "Change Log Management";
                RecRef : RecordRef;
                xRecRef : RecordRef;
            begin
                //  <<DITW15.00.00.39 RBE 20/04/2011 #1230
                if "Sell-to Contact No." <> '' then begin
                  Cont.GET("Sell-to Contact No.");
                  ContBusinessRelation.RESET;
                  ContBusinessRelation.SETCURRENTKEY("Link to Table","No.");
                  ContBusinessRelation.SETRANGE("Link to Table",ContBusinessRelation."Link to Table"::Customer);
                  ContBusinessRelation.SETRANGE("No.","No.");
                  if ContBusinessRelation.FINDFIRST then
                    if ContBusinessRelation."Contact No." <> Cont."Company No." then
                      ERROR(Text2013910,Cont."No.",Cont.Name,"No.");
                end;
                //  >>DITW15.00.00.39 RBE #1230
            end;
        }
        field(2013920;"No. of Calls";Integer)
        {
            CalcFormula = Count("Telesales Entry" WHERE ("Customer No."=FIELD("No."),
                                                         "Calling Date"=FIELD("Date Filter"),
                                                         "Ship-to Code"=FIELD("Ship-to Filter"),
                                                         "Call Status"=FIELD("Call Status Filter"),
                                                         Closed=FIELD("Call Closed Filter")));
            CaptionML = ENU='No. of Calls',
                        FRA='Nbre d''appels';
            Description = 'DITW15.00.00.39 DDR 22/04/2011 #1230';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013940;"Call Closed Filter";Boolean)
        {
            CaptionML = ENU='Closed Call Filter',
                        FRA='Filtre appel clôturé';
            Description = 'DITW15.00.00.39 DDR 26/04/2011 #1230';
            FieldClass = FlowFilter;
        }
        field(2013941;"Call Status Filter";Option)
        {
            CaptionML = ENU='Calling Status Filter',
                        FRA='Filtre Status de l''appel';
            Description = 'DITW15.00.00.39 DDR 26/04/2011 #1230';
            FieldClass = FlowFilter;
            OptionCaptionML = ENU=' ,No Sale,Ring Back,Customer Rings Back,LeftVoicemail,Sent Email,Unable To Contact,Next Schedule,Goods Ordered',
                              FRA=' ,Pas de vente,Rappeler,Client va rappeler,Messagerie vocale,courrier électronique Envoyé,Impossible de contacter,Horaire suivant,Marchandises commandées';
            OptionMembers = " ","No Sale","Ring Back","Customer Rings Back",LeftVoicemail,"Sent Email","Unable To Contact","Next Schedule","Goods Ordered";
        }
        field(2013942;"Min HL Volume";Decimal)
        {
            CaptionClass = GetUomCaptionClassHL(FIELDNO("Min HL Volume"));
            CaptionML = ENU='Min. Volume',
                        FRA='Volume Min.';
            Description = 'DITW17.00.02 DIT-770 #189';
            MinValue = 0;
        }
        field(2013943;"Min. Eq. UOM quantity";Decimal)
        {
            CaptionClass = GetUomCaptionClassEqUom(FIELDNO("Min. Eq. UOM quantity"));
            CaptionML = ENU='Min. Eq. UOM Quantity',
                        FRA='Quantité Min Eq. UOM';
            Description = 'DITW17.00.02 DIT-770 #189 - DITW17.10.03  DIT-770 #354';
            MinValue = 0;
        }
        field(2014060;"Picking Type";Option)
        {
            CaptionML = ENU='Picking Type',
                        FRA='Type de prélèvement';
            Description = 'DITW17.00.02 DIT-770 #154-DITW18.00.06 DIT-770 #1376';
            OptionCaptionML = ENU=' ,Order,Combined',
                              FRA=' ,Commande,Regroupée';
            OptionMembers = " ","Order",Combined;
        }
        field(2014061;"Truck Zone";Option)
        {
            CaptionML = ENU='Truck Zone',
                        FRA='Zone de camion';
            Description = 'DITW17.00.02 DIT-770 #154';
            OptionCaptionML = ENU=' ,Right,Left',
                              FRA=' ,Droite,Gauche';
            OptionMembers = " ",Right,Left;
        }
        field(2014062;"Shipment Date Formula";DateFormula)
        {
            CaptionML = ENU='Shipment Date Formula',
                        FRA='Formule date d''expédition';
            Description = 'DITW17.00.02 DIT-770 #146';
        }
        field(2014063;"Require 2 Drivers";Boolean)
        {
            CaptionML = ENU='Require 2 Drivers',
                        FRA='Demande 2 chauffeurs';
            Description = 'DITW17.00.02 DIT-770 #154';
        }
        field(2014064;"Ship-to Address Key No.";Code[20])
        {
            CaptionML = ENU='Ship-to Address Key No.',
                        FRA='N° clé adresse destinataire';
            Description = 'DITW17.00.02 DIT-770 #154';
        }
        field(2014065;"No. of Routes";Integer)
        {
            CalcFormula = Count("Route Combination" WHERE ("No."=FIELD("No.")));
            CaptionML = ENU='No. of Routes',
                        FRA='Nbre de routes';
            Description = 'DITW17.00.02 DIT-770 #154';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014066;"Purchasing Code";Code[10])
        {
            CaptionML = ENU='Purchasing Code',
                        FRA='Code Achat';
            Description = 'DITW18.00.07 DIT-770 #1425';
            TableRelation = Purchasing;
        }
        field(2014067;"Customer Delivery Type";Code[10])
        {
            CaptionML = ENU='Customer Delivery Type',
                        FRA='Type Livraison Client';
            Description = 'DITW18.00.07 DIT-770 #1346';
            TableRelation = "Delivery Type".Code WHERE (Type=CONST(Customer));
        }
        field(2014087;Distance;Decimal)
        {
            CaptionML = ENU='Distance',
                        FRA='Distance';
            DecimalPlaces = 0:5;
            Description = 'DITW15.00.00.24';
            MinValue = 0;
        }
        field(2014094;"Invoice Method";Option)
        {
            CaptionML = ENU='Invoice Method',
                        FRA='Méthode de facturation';
            Description = 'DITW17.00.02 DIT-770 #154';
            OptionCaptionML = ENU=' ,Shipment,Order,Combine Shipments,Combine Shipments Per Sell-to',
                              FRA=' ,Expédition,Commande,Combiner expeditions,Combiner les expeditions par donneur d''ordre';
            OptionMembers = " ",Shipment,"Order","Combine Shipments","Combine Shipments Per Sell-to";

            trigger OnValidate();
            begin
                //<<DITW17.00.02 TEC1 12/09/2013 DIT-770 #154
                CLEAR("Invoice Period");
                //>>DITW17.00.02 TEC1 DIT-770 #154

                //<<DITW17.00.02 RPG 05/11/2013 DIT-770 #235
                if "Invoice Method" <> "Invoice Method"::"Combine Shipments" then
                  "Shipment specification" := false;
                //>>DITW17.00.02 RPG DIT-770 #235

                //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
                if "Sundry Customer" and ("Invoice Method" in ["Invoice Method"::"Combine Shipments","Invoice Method"::"Combine Shipments Per Sell-to"]) then
                  VALIDATE("Invoice Period","Invoice Period"::Order);
                //>> DITW18.00.07 AKH DIT-770 #1804
            end;
        }
        field(2014095;"Invoice Period";Option)
        {
            CaptionML = ENU='Invoice Period',
                        FRA='Période de facturation';
            Description = 'DITW17.00.02 DIT-770 #154, #338  - DIT-770 #1051';
            OptionCaptionML = ENU=' ,Direct Delivery,Order,Event,Daily,Weekly,Half Montly,Montly,10 Days',
                              FRA=' ,Livraison directe,Ordre,Événement,Quotidienne,Hebdomadaire,Demi-Mensuelle,Mensuelle,10 Jours';
            OptionMembers = " ","Direct Delivery","Order","Order Manually",Daily,Weekly,"Half Montly",Montly,"10 Days";

            trigger OnValidate();
            begin
                //<<DITW17.00.02 TEC1 12/09/2013 DIT-770 #154
                //<< DITW17.00.02 VSC 28/02/2014 DIT-770 #338 :Change Type of field "Invoice Period" from Dateformula To Option
                if "Invoice Period" <> "Invoice Period"::" " then
                //>> DITW17.00.02 VSC 28/02/2014 DIT-770 #338
                if (("Invoice Method" <> "Invoice Method"::"Combine Shipments") and
                   ("Invoice Method" <> "Invoice Method"::"Combine Shipments Per Sell-to")) then
                   ERROR(Text2014095);
                //>>DITW17.00.02 TEC1 DIT-770 #154
                //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
                if "Sundry Customer" and ("Invoice Method" in ["Invoice Method"::"Combine Shipments","Invoice Method"::"Combine Shipments Per Sell-to"]) then
                  if "Invoice Period" <> "Invoice Period"::Order then
                    FIELDERROR("Invoice Period");
                //>> DITW18.00.07 AKH DIT-770 #1804
            end;
        }
        field(2014101;"Transport Time Text";Text[50])
        {
            CaptionML = ENU='Transport Time Description (AAD)',
                        FRA='Désignation Temps de transport (DAA)';
            Description = 'DITW15.00.00.37';
        }
        field(2014107;Route;Code[20])
        {
            CaptionML = ENU='Route',
                        FRA='Itinéraire';
            Description = 'DITW16.00.00.40 #1002 - DITW17.00.02 DIT-770 #154 - DITW19.00.08 BL#9797';
            TableRelation = IF ("Responsibility Center"=CONST('')) Route
                            else IF ("Responsibility Center"=FILTER(<>'')) Route WHERE ("Responsibility Center"=FIELD("Resp. Center Table Filter"));

            trigger OnValidate();
            var
                lrRouteCombination : Record "Route Combination";
                CurrentRoute : Record Route;
                Confirmed : Boolean;
            begin
                //<<DITW17.00.02 TEC1 12/09/2013 DIT-770 #154
                /// DITW19.00.08 AKH 16/12/2016 BL#9797 - DITW110.00.11 ASA 13/11/2017 NRQ#18375
                lrRouteCombination.RESET;
                //<< DITW18.00.07 VSC 09/05/2016 DIT-770 #1968 - #1977
                lrRouteCombination.SETRANGE("Source Type",lrRouteCombination."Source Type"::Customer);
                //>> DITW18.00.07 VSC DIT-770 #1968 - #1977
                lrRouteCombination.SETRANGE("No.","No.");
                lrRouteCombination.SETRANGE(Code,Route);
                if not lrRouteCombination.FINDFIRST then
                begin
                  lrRouteCombination.INIT;
                  //<< DITW18.00.07 VSC 09/05/2016 DIT-770 #1968 - #1977
                  lrRouteCombination."Source Type" := lrRouteCombination."Source Type"::Customer;
                  //>> DITW18.00.07 VSC DIT-770 #1968 - #1977
                  lrRouteCombination."No." := "No.";
                  lrRouteCombination.Code := Route;
                  lrRouteCombination.INSERT;
                end;
                //>>DITW17.00.02 TEC1 DIT-770 #154
            end;
        }
        field(2014108;"Minimum Cubage";Decimal)
        {
            CaptionML = ENU='Minimum Volume (Cubage)',
                        FRA='Volume (cubage) minimum';
            DecimalPlaces = 0:5;
            Description = 'DITW16.00.00.40 #1002';
            MinValue = 0;
        }
        field(2014109;"Minimum Weight";Decimal)
        {
            CaptionML = ENU='Minimum Weight',
                        FRA='Poids minimum';
            DecimalPlaces = 0:5;
            Description = 'DITW16.00.00.40 #1002';
            MinValue = 0;
        }
        field(2014110;"Route Planning No. Filter";Code[20])
        {
            Caption = 'Route Planning No. Filter';
            Description = 'NRQ#39012';
            FieldClass = FlowFilter;
            TableRelation = "Route Planning Worksheet";
        }
        field(2014120;"Sell-to/Bill-to DTax Gr. Calc.";Option)
        {
            CaptionML = ENU='Sell-to/Bill-to Tax Calculation',
                        FRA='Calcul Taxes donneur d''ordre/client facturé';
            Description = 'DITW16.00.00.42 DIT-715 #520';
            OptionCaptionML = ENU=' ,Sell-to,Bill-to',
                              FRA=' ,Donneur d''ordre,Client facturé';
            OptionMembers = " ","Sell-to/Buy-from No.","Bill-to/Pay-to No.";
        }
        field(2014271;"Tax Warehouse Reference";Text[20])
        {
            CaptionML = ENU='Tax Warehouse Reference',
                        FRA='Entrepôt fiscal de référence';
            Description = 'DITW15.00.00.38 #1217';
        }
        field(2014290;"Journey Time";DateFormula)
        {
            CaptionML = ENU='Journey Time (EMCS)',
                        FRA='Temps de trajet (EMCS)';
            Description = 'DITW15.00.00.39 #1353';
        }
        field(2014313;"Sales (Qty.) HL";Decimal)
        {
            CalcFormula = -Sum("Value Entry"."Invoiced Quantity in HL" WHERE ("Item Ledger Entry Type"=CONST(Sale),
                                                                              "Source No."=FIELD("No."),
                                                                              "Posting Date"=FIELD("Date Filter"),
                                                                              "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                                                                              "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),
                                                                              "Item DDisc. Group Code"=FIELD("Item DDisc. Group Filter")));
            CaptionClass = GetUomCaptionClassHL(FIELDNO("Sales (Qty.) HL"));
            CaptionML = ENU='Sales (Qty.)',
                        FRA='Ventes (qté)';
            DecimalPlaces = 0:5;
            Description = 'DITW16.00.00.41 DIT-715 #378';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014314;"Sales Indirect (Qty.) HL";Decimal)
        {
            CalcFormula = Sum("Indirect Cust. Ledger Entry"."Quantity HL" WHERE ("Customer No."=FIELD("No."),
                                                                                 "Posting Date"=FIELD("Date Filter"),
                                                                                 "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                                                                                 "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),
                                                                                 "Item DDisc. Group Code"=FIELD("Item DDisc. Group Filter")));
            CaptionClass = GetUomCaptionClassHL(FIELDNO("Sales Indirect (Qty.) HL"));
            CaptionML = ENU='Sales Indirect (Qty.)',
                        FRA='Ventes indirecte (Qté)';
            DecimalPlaces = 0:5;
            Description = 'DITW16.00.00.41 DIT-715 #378';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014315;"Item DDisc. Group Code 2";Code[10])
        {
            CaptionML = ENU='Item Disc. Group 2',
                        FRA='Groupe rem. article 2';
            Description = 'DITW16.00.00.42 DIT-715 #378';
            TableRelation = "Drink Discount Group".Code WHERE ("Source Type"=CONST(Item));
        }
        field(2014316;"Sales Free (Qty.) HL";Decimal)
        {
            CalcFormula = -Sum("Value Entry"."Invoiced Quantity in HL" WHERE ("Item Ledger Entry Type"=CONST(Sale),
                                                                              "Source No."=FIELD("Bill-to Customer No."),
                                                                              "Posting Date"=FIELD("Date Filter"),
                                                                              "Item DDisc. Group Code"=FIELD("Item DDisc. Group Filter"),
                                                                              "Free Item"=CONST(true)));
            CaptionClass = GetUomCaptionClassHL(FIELDNO("Sales Free (Qty.) HL"));
            CaptionML = ENU='Sales Volume Free (Direct)',
                        FRA='Volume des ventes gratuit (Direct)';
            DecimalPlaces = 0:5;
            Description = 'DITW16.00.00.43 DIT-715 #617';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014317;"Sales Indirect Free (Qty.) HL";Decimal)
        {
            CalcFormula = Sum("Indirect Cust. Ledger Entry"."Quantity HL" WHERE ("Customer No."=FIELD("Bill-to Customer No."),
                                                                                 "Posting Date"=FIELD("Date Filter"),
                                                                                 "Item DDisc. Group Code"=FIELD("Item DDisc. Group Filter"),
                                                                                 "Free Item"=CONST(true)));
            CaptionClass = GetUomCaptionClassHL(FIELDNO("Sales Indirect Free (Qty.) HL"));
            CaptionML = ENU='Sales Volume Free (Indirect)',
                        FRA='Volume des ventes gratuit (Indirect)';
            DecimalPlaces = 0:5;
            Description = 'DITW16.00.00.43 DIT-715 #617';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014410;"Bill-to Contact No.";Code[20])
        {
            CaptionML = ENU='Bill-to Contact No.',
                        FRA='N° contact facturation';
            Description = 'DITW17.00.02 DIT-770 #235';
            TableRelation = Contact;

            trigger OnLookup();
            var
                Cont : Record Contact;
                ContBusRel : Record "Contact Business Relation";
            begin
                //<<DITW17.00.02 RPG 11/05/2013 DIT-770 #235
                if "Bill-to Contact No." <> '' then
                  if Cont.GET("Bill-to Contact No.") then ;
                if PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK then
                  VALIDATE("Bill-to Contact No.",Cont."No.");
                //>>DITW17.00.02 RPG DIT-770 #235
            end;

            trigger OnValidate();
            var
                Cont : Record Contact;
                ContBusRel : Record "Contact Business Relation";
            begin
                //<<DITW17.00.02 RPG 11/05/2013 DIT-770 #235
                "Bill-to Contact" := '';
                if "Bill-to Contact No." <> '' then begin
                  Cont.GET("Bill-to Contact No.");
                  if Cont.Type = Cont.Type::Person then
                    "Bill-to Contact" := Cont.Name;
                end;
                //>>DITW17.00.02 RPG DIT-770 #235
            end;
        }
        field(2014411;"Bill-to Contact";Text[50])
        {
            CaptionML = ENU='Bill-to Contact',
                        FRA='Contact facturation';
            Description = 'DITW17.00.02 DIT-770 #235';

            trigger OnValidate();
            begin
                //<<DITW17.00.02 RPG 11/05/2013 DIT-770 #235
                if RMSetup.GET then
                  if RMSetup."Bus. Rel. Code for Customers" <> '' then
                    if (xRec."Bill-to Contact" = '') and (xRec."Bill-to Contact No." = '') then begin
                      MODIFY;
                      UpdateContFromCust.OnModify(Rec);
                      UpdateContFromCust.InsertNewBilltoContactPerson(Rec,false);
                      MODIFY(true);
                    end
                //>>DITW17.00.02 RPG DIT-770 #235
            end;
        }
        field(2014412;"Invoice Address from";Option)
        {
            CaptionML = ENU='Invoice Address from',
                        FRA='Adresse facturation de';
            Description = 'DITW17.00.02 DIT-770 #235';
            OptionCaptionML = ENU='Bill-to Customer, Sell-to Customer',
                              FRA='Client facturé,Donneur d''ordre';
            OptionMembers = "Bill-to Customer"," Sell-to Customer";
        }
        field(2014413;"Empty Goods Statement On";Option)
        {
            CaptionML = ENU='Empty Goods Statement On',
                        FRA='Relevé vidanges sur';
            Description = 'DITW17.00.02 DIT-770 #235 - DIT-770 #827';
            OptionCaptionML = ENU='  ,Delivery Note,Invoice,Invoice + Delivery Note',
                              FRA='  ,Note de livraison,Facture,Facture + Note de livraison';
            OptionMembers = "  ","Delivery Note",Invoice,"Invoice + Delivery Note";
        }
        field(2014414;"Delivery Note Copies";Integer)
        {
            CaptionML = ENU='Delivery Note Copies',
                        FRA='Copies bon de livraison';
            Description = 'DITW17.00.02 DIT-770 #235';
            MinValue = 0;
        }
        field(2014415;"Accumulate items on Invoice";Boolean)
        {
            CaptionML = ENU='Accumulate items on Invoice',
                        FRA='Accumulez les articles sur la facture';
            Description = 'DITW17.00.02 DIT-770 #235';
        }
        field(2014416;"Start Selling Date";Date)
        {
            CaptionML = ENU='Start Selling Date',
                        FRA='Date début';
            Description = 'DITW17.00.02 DIT-770 #151';

            trigger OnValidate();
            begin
                // <<DITW110.00.08 DDR 03/03/2017 NRQ#23042
                if ("Start Selling Date" > "End Selling Date") and ("End Selling Date" <> 0D) then
                  ERROR(Text2014414,FIELDCAPTION("Start Selling Date"),FIELDCAPTION("End Selling Date"));
                // >>DITW110.00.08 DDR NRQ#23042
            end;
        }
        field(2014417;"Start Selling Reason Code";Code[10])
        {
            CaptionML = ENU='Start Selling Reason Code',
                        FRA='Début Code Motif';
            Description = 'DITW17.00.02 DIT-770 #151';
            TableRelation = "Reason Code";

            trigger OnValidate();
            begin
                // <<DITW110.00.08 DDR 03/03/2017 NRQ#23042
                if ("Start Selling Date" = 0D) and ("Start Selling Reason Code" <> '') then
                  "Start Selling Date" := TODAY;
                // >>DITW110.00.08 DDR NRQ#23042
            end;
        }
        field(2014418;"End Selling Date";Date)
        {
            CaptionML = ENU='End Selling Date',
                        FRA='Date fin';
            Description = 'DITW17.00.02 DIT-770 #151';

            trigger OnValidate();
            begin
                // <<DITW110.00.08 DDR 03/03/2017 NRQ#23042
                VALIDATE("Start Selling Date");
                // >>DITW110.00.08 DDR NRQ#23042
            end;
        }
        field(2014419;"End Selling Reason Code";Code[10])
        {
            CaptionML = ENU='End Selling Reason Code',
                        FRA='Fin Code Motif';
            Description = 'DITW17.00.02 DIT-770 #151';
            TableRelation = "Reason Code";

            trigger OnValidate();
            begin
                // <<DITW110.00.08 DDR 03/03/2017 NRQ#23042
                if ("End Selling Date" = 0D) and ("End Selling Reason Code" <> '') then
                  "End Selling Date" := TODAY;
                // >>DITW110.00.08 DDR NRQ#23042
            end;
        }
        field(2014420;"Shipment specification";Boolean)
        {
            CaptionML = ENU='Shipment specification',
                        FRA='Spécification Expédition';
            Description = 'DITW17.00.02 DIT-770 #235';

            trigger OnValidate();
            begin
                if "Shipment specification" then
                  TESTFIELD("Invoice Method","Invoice Method"::"Combine Shipments");
            end;
        }
        field(2014421;"No. of Resp. Center Relations";Integer)
        {
            CalcFormula = Count("Cust.- resp. center relations" WHERE ("Customer No."=FIELD("No.")));
            CaptionML = ENU='No. of Resp. Center Relations',
                        FRA='Relation Centre de gestion Client';
            Description = 'DITW18.00.06 MSF 05/05/2015 DIT-770 #1212 #1213 #1214';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014422;"Sundry Customer";Boolean)
        {
            CaptionML = ENU='Sundry Customer',
                        FRA='Client Diver';
            Description = 'DITW18.00.07 DIT-770 #1804';

            trigger OnValidate();
            begin
                //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
                if "Sundry Customer" then
                  if ("Invoice Method" in ["Invoice Method"::"Combine Shipments","Invoice Method"::"Combine Shipments Per Sell-to"]) then
                    VALIDATE("Invoice Period","Invoice Period"::Order)
                  else
                    VALIDATE("Invoice Period","Invoice Period"::" ");
                //>> DITW18.00.07 AKH DIT-770 #1804
            end;
        }
        field(2014423;"No. of Exclusivity Groups";Integer)
        {
            CalcFormula = Count("Item Exclusivity Relation" WHERE ("Source Type"=CONST(Customer),
                                                                   "Source No."=FIELD("No.")));
            CaptionML = ENU='No. of Exclusivity Groups',
                        FRA='Nombre de Groupes exclusivité';
            Description = 'DITW15.00.00.39';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014424;"No. of Quota Groups";Integer)
        {
            CalcFormula = Count("Item Quota Relation" WHERE ("Source Type"=CONST(Customer),
                                                             "Source No."=FIELD("No.")));
            CaptionML = ENU='No. of Quota Groups',
                        FRA='Nombre de groupes de quotas';
            Description = 'DITW17.10.03 DDR 13/06/14 DIT-770 #392';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014425;"Ext. Doc. No. Mandatory";Option)
        {
            CaptionML = ENU='Ext. Doc. No. Mandatory',
                        FRA='N° doc. ext. obligatoire';
            Description = 'DITW18.00.07 DIT-770 #1409';
            OptionCaptionML = ENU='Default,No,Yes(Posting),Yes(Order release),Yes(Both)',
                              FRA='Par Défaut,Non,Oui(Validation),Oui(Lancement Commande),Oui(Tout)';
            OptionMembers = Default,No,"Yes(Posting)","Yes(Order Release)","Yes(Both)";
        }
        field(2014426;"Return Location Code";Code[10])
        {
            CaptionML = ENU='Return Location Code',
                        FRA='Code Magasin Retour';
            Description = 'DITW19.00.08 BL#10756';
            TableRelation = Location.Code WHERE ("Use As In-Transit"=CONST(false));
        }
        field(2014427;"Resp. Center Table Filter";Code[10])
        {
            CaptionML = ENU='Resp. Center Table Filter',
                        FRA='Filtre Centre de gestion (table)';
            Description = 'DITW19.00.08 BL#9797';
            FieldClass = FlowFilter;
            TableRelation = "Responsibility Center";
        }
        field(2014429;"Bill-to/Sell-to Prices Calc.";Option)
        {
            CaptionML = ENU='Bill-to/Sell-to Prices Calculation',
                        FRA='Calcul Prix client facturé/donneur d''ordre';
            Description = 'DITW16.00.00.42 DIT-715 #520';
            OptionCaptionML = ENU=' ,Bill-to,Sell-to',
                              FRA=' ,Client facturé,Donneur d''ordre';
            OptionMembers = " ","Bill-to","Sell-to";
        }
        field(2014430;"Shipment Date Alert Filter";DateFormula)
        {
            CaptionML = ENU='Shipment Date Alert Filter',
                        FRA='Filtre alerte date d''expedition';
            Description = 'DITW17.10.05 DIT-770 #754';
        }
        field(2014431;"Shipment Status Alert Filter";Option)
        {
            CaptionML = ENU='Shipment Status Alert Filter',
                        FRA='Filtre Alerte Statut expedition';
            Description = 'DITW17.10.05 DIT-770 #754';
            OptionCaptionML = ENU='Open,Picklist Printed,Assigned,Picked,Shipped,Return completed,Invoice',
                              FRA='Ouvert,Prélèvement imprimé,Affecté,Prélevé,Expédié,Retour terminée,Facturée';
            OptionMembers = Open,"Picklist Printed",Assigned,Picked,Shipped,"Return completed",Invoice;
        }
        field(2014440;Exclusivity;Boolean)
        {
            CaptionML = ENU='Contract Exclusivity',
                        FRA='Contrat d''exclusivité';
            Description = 'DITW16.00.00.43 DIT-715 #497';
        }
        field(2014459;"Credit Limit";Boolean)
        {
            CaptionML = ENU='Credit Limit',
                        FRA='Credit Limit';
            Description = 'DIT-770 #1701';
        }
        field(2014460;"Tax Office Code";Code[10])
        {
            CaptionML = ENU='Tax Office Code',
                        FRA='Code Bureau de taxe';
            Description = 'DITW15.00.00.38 #1217';
            TableRelation = "Tax Office";
        }
        field(2014464;"Transaction Type";Code[10])
        {
            CaptionML = ENU='Transaction Type',
                        FRA='Type de transaction';
            Description = 'DITW15.00.00.38 #1217';
            TableRelation = "Transaction Type";
        }
        field(2014465;"Transport Method";Code[10])
        {
            CaptionML = ENU='Transport Method',
                        FRA='Mode de transport';
            Description = 'DITW15.00.00.38 #1217';
            TableRelation = "Transport Method";
        }
        field(2014466;"Transaction Specification";Code[10])
        {
            CaptionML = ENU='Transaction Specification',
                        FRA='Régime';
            Description = 'DITW15.00.00.38 #1217';
            TableRelation = "Transaction Specification";
        }
        field(2014467;"Exit Point";Code[10])
        {
            CaptionML = ENU='Exit Point',
                        FRA='Pays destination';
            Description = 'DITW15.00.00.38 #1217';
            TableRelation = "Entry/Exit Point";
        }
        field(2014468;"Empty Returned Items Based On";Option)
        {
            Caption = 'Empty Returned Items Based On';
            Description = 'NRQ#16224 - NRQ#42285';
            OptionCaption = '" ,Document,History,Fixed Block,Document / Item(charges)"';
            OptionMembers = " ",Document,History,"Fixed Block","Document / Item(charges)";
        }
        field(2014470;"Area";Code[10])
        {
            CaptionML = ENU='Area',
                        FRA='Dépt destination/provenance';
            Description = 'DITW15.00.00.38 #1217';
            TableRelation = Area;
        }
        field(2014473;"Customer Template Code";Code[10])
        {
            CaptionClass = GetCaptionClassPM(FIELDCAPTION("Customer Template Code"),Text2014310_2014473);
            CaptionML = ENU='Customer Template Code',
                        FRA='Code Modèle client';
            Description = 'DITW15.00.00.38 #1217';
            TableRelation = "Customer Template";

            trigger OnValidate();
            var
                DDiscGrRelation2 : Record "Drink Discount Relation";
                DPromoGrRelation2 : Record "Drink Promotion Relation";
                DefaultDim : Record "Default Dimension";
                SalesReceivablesSetupL : Record "Sales & Receivables Setup";
            begin
                TESTFIELD("No.");
                if "Customer Template Code" <> '' then begin
                  if ((Name <> '') or
                    ("Gen. Bus. Posting Group" <> '') or
                    ("VAT Bus. Posting Group" <> '') or
                    ("Customer Posting Group" <> '') or
                    ("Location Code" <> '') or
                    ("Responsibility Center" <> '') or
                    ("VAT Registration No." <> '')) and GUIALLOWED and (CurrFieldNo <> 0)
                  then begin
                    if CONFIRM(Text2014410,false,"No.","Customer Template Code") then begin
                        CustTemplate.Code := "Customer Template Code";
                        "Customer Template Code" := CustTemplate.Code;
                        DDiscGrRelation2.RESET;
                        DDiscGrRelation2.SETRANGE("Source Type",DDiscGrRelation."Source Type"::Customer);
                        DDiscGrRelation2.SETRANGE("Source No.","No.");
                        DDiscGrRelation2.DELETEALL;
                        DPromoGrRelation2.RESET;
                        DPromoGrRelation2.SETRANGE("Source Type",DPromoGrRelation."Source Type"::Customer);
                        DPromoGrRelation2.SETRANGE("Source No.","No.");
                        DPromoGrRelation2.DELETEALL;
                        //<<DITW17.10.05 MSF 24/07/14 DIT-770 #723
                        DefaultDim.SETRANGE("Table ID",DATABASE::Customer);
                        DefaultDim.SETRANGE("No.","No.");
                        DefaultDim.DELETEALL;
                        //>>DITW17.10.05 MSF 24/07/14 DIT-770 #723
                    end else begin
                      "Customer Template Code" := xRec."Customer Template Code";
                      exit;
                    end;
                  end;

                  CustTemplate.GET("Customer Template Code");
                  //<<DITW17.10.05 WSA 20/08/2014 DIT-770 #723
                  if CustTemplate."Territory Code" <>'' then
                    VALIDATE("Territory Code",CustTemplate."Territory Code");
                  if CustTemplate."Currency Code" <>'' then
                    VALIDATE("Currency Code",CustTemplate."Currency Code");
                  if CustTemplate."Country/Region Code" <>'' then
                    VALIDATE("Country/Region Code",CustTemplate."Country/Region Code");
                  if CustTemplate."Customer Posting Group" <>'' then
                    VALIDATE("Customer Posting Group",CustTemplate."Customer Posting Group");
                  if CustTemplate."Customer Price Group" <>'' then
                    VALIDATE("Customer Price Group",CustTemplate."Customer Price Group");
                  if CustTemplate."Invoice Disc. Code" <>'' then
                    VALIDATE("Invoice Disc. Code",CustTemplate."Invoice Disc. Code");
                  if CustTemplate."Customer Disc. Group" <>'' then
                    VALIDATE("Customer Disc. Group",CustTemplate."Customer Disc. Group");
                  if CustTemplate."Allow Line Disc."  then
                    VALIDATE("Allow Line Disc.",CustTemplate."Allow Line Disc.");
                  if CustTemplate."Gen. Bus. Posting Group" <>'' then
                    VALIDATE("Gen. Bus. Posting Group",CustTemplate."Gen. Bus. Posting Group");
                  if CustTemplate."VAT Bus. Posting Group" <>'' then
                    VALIDATE("VAT Bus. Posting Group",CustTemplate."VAT Bus. Posting Group");
                  if CustTemplate."Payment Terms Code" <>'' then
                    VALIDATE("Payment Terms Code",CustTemplate."Payment Terms Code");
                  if CustTemplate."Payment Method Code" <>'' then
                    VALIDATE("Payment Method Code",CustTemplate."Payment Method Code");
                  if CustTemplate."Shipment Method Code" <>'' then
                    VALIDATE("Shipment Method Code",CustTemplate."Shipment Method Code");
                  if CustTemplate."DDeposit Group Code" <>'' then
                    VALIDATE("Customer DDeposit Group Code",CustTemplate."DDeposit Group Code");
                  if CustTemplate."DTax Group Code" <>'' then
                    VALIDATE("Customer DTax Group Code",CustTemplate."DTax Group Code");
                  if CustTemplate."Shipping Agent Code" <>'' then
                    VALIDATE("Shipping Agent Code",CustTemplate."Shipping Agent Code");
                  if CustTemplate."Shipping Agent Service Code" <>'' then
                    VALIDATE("Shipping Agent Service Code",CustTemplate."Shipping Agent Service Code");
                  if CustTemplate."Responsibility Center" <>'' then
                    VALIDATE("Responsibility Center",CustTemplate."Responsibility Center");
                  if CustTemplate."Location Code" <>'' then
                    VALIDATE("Location Code",CustTemplate."Location Code");
                  if CustTemplate."Base Calendar Code" <>'' then
                    VALIDATE("Base Calendar Code",CustTemplate."Base Calendar Code");
                  if CustTemplate.Distance <>0 then
                    VALIDATE(Distance,CustTemplate.Distance);
                  VALIDATE("Application Method",CustTemplate."Application Method");
                  if CustTemplate."Reminder Terms Code" <>'' then
                    VALIDATE("Reminder Terms Code",CustTemplate."Reminder Terms Code");
                  if CustTemplate."Fin. Charge Terms Code" <>'' then
                    VALIDATE("Fin. Charge Terms Code",CustTemplate."Fin. Charge Terms Code");
                  if CustTemplate."Contract Cust. Post. Gr. Rent" <>'' then
                    VALIDATE("Contract Cust. Post. Gr. Rent",CustTemplate."Contract Cust. Post. Gr. Rent");
                  if CustTemplate."Contract Cust. Post. Gr. Loan" <>'' then
                    VALIDATE("Contract Cust. Post. Gr. Loan",CustTemplate."Contract Cust. Post. Gr. Loan");
                  if CustTemplate."Contract Cust. Post. Gr. LoanU" <>'' then
                    VALIDATE("Contract Cust. Post. Gr. LoanU",CustTemplate."Contract Cust. Post. Gr. LoanU");
                  if CustTemplate."Contract Cust. Post. Gr. Maint" <>'' then
                    VALIDATE("Contract Cust. Post. Gr. Maint",CustTemplate."Contract Cust. Post. Gr. Maint");
                  if CustTemplate."Contract Cust. Post. Gr. Other" <>'' then
                    VALIDATE("Contract Cust. Post. Gr. Other",CustTemplate."Contract Cust. Post. Gr. Other");
                  if CustTemplate."Contract Cust. Post. Gr. Plant" <>'' then
                    VALIDATE("Contract Cust. Post. Gr. Plant",CustTemplate."Contract Cust. Post. Gr. Plant");
                  if CustTemplate."Loan Interest Cust. Post. Grp." <>'' then
                    VALIDATE("Loan Interest Cust. Post. Grp.",CustTemplate."Loan Interest Cust. Post. Grp.");
                  if CustTemplate."Customer Posting Group" <>'' then
                    VALIDATE("Customer Posting Group",CustTemplate."Customer Posting Group");
                  if CustTemplate."Loan Interest Cust. Post. Grp." <>'' then
                    VALIDATE("Loan Interest Cust. Post. Grp.",CustTemplate."Loan Interest Cust. Post. Grp.");
                  if CustTemplate."Contract Cust. Post. Gr. Plant" <>'' then
                    VALIDATE("Contract Cust. Post. Gr. Plant",CustTemplate."Contract Cust. Post. Gr. Plant");
                  // >>DITW17.10.05 WSA 20/08/2014 DIT-770 #723
                  //<<DITW17.10.05 MSF 14/08/2014 DIT-770 #827
                  "Empty Goods Statement On" :=CustTemplate."Empty goods statement on";
                  //>>DITW17.10.05 MSF 14/08/2014 DIT-770 #827
                  //<< DITW18.00.07 AKH 28/03/2016 DIT-770 #1409
                  "Ext. Doc. No. Mandatory" := CustTemplate."Ext. Doc. No. Mandatory";
                  //>> DITW18.00.07 AKH DIT-770 #1409
                  //<<DITW110.00.10 MSF 07/07/2017 NRQ#16224
                  "Empty Returned Items Based On" :=CustTemplate."Empty Returned Items Based On";
                  //>>DITW110.00.10 MSF 07/07/2017 NRQ#16224

                  //<<HEI.23
                  "Credit Limit" := CustTemplate."Credit Limit";
                  "Credit Limit (LCY)" := CustTemplate."Credit Limit (LCY)";
                  "RPM Exposure" :=CustTemplate."RPM Exposure";
                  "Risk Category" :=CustTemplate."Risk Category";
                  "Risk Score" := CustTemplate."Risk Score";
                  "Invoice Method" := CustTemplate."Invoice Method";
                  "Customer DDeposit Group Code":= CustTemplate."Customer DDeposit Group Code";
                  "Gen. Bus. Posting Free Group":= CustTemplate."Gen. Bus. Posting Free Group";
                  "WHT Business Posting Group" := CustTemplate."WHT Business Posting Group";
                  "Free Item Posting Type" := CustTemplate."Free Item Posting Type";
                  //>>HEI.23

                  //HEI.36>>
                  SalesReceivablesSetupL.GET;
                  VALIDATE(Blocked,CustTemplate.Blocked);
                  if CustTemplate.Blocked <> CustTemplate.Blocked::" " then begin
                    SalesReceivablesSetupL.TESTFIELD("Block Reason for New Customer");
                    "Blocked Reason Code" := SalesReceivablesSetupL."Block Reason for New Customer";
                  end;
                  //HEI.36<<
                  DDiscGrRelation.RESET;
                  DDiscGrRelation.SETRANGE("Source Type",DDiscGrRelation."Source Type"::TCustomer);
                  DDiscGrRelation.SETRANGE("Source No.",CustTemplate.Code);
                  if DDiscGrRelation.findset then
                    repeat
                      DDiscGrRelation2 := DDiscGrRelation;
                      DDiscGrRelation2."Source Type" := DDiscGrRelation2."Source Type"::Customer;
                      DDiscGrRelation2."Source No." := "No.";
                      if DDiscGrRelation2.INSERT then;
                    until DDiscGrRelation.NEXT = 0;

                  DPromoGrRelation.RESET;
                  DPromoGrRelation.SETRANGE("Source Type",DPromoGrRelation."Source Type"::TCustomer);
                  DPromoGrRelation.SETRANGE("Source No.",CustTemplate.Code);
                  if DPromoGrRelation.findset then
                    repeat
                      DPromoGrRelation2 := DPromoGrRelation;
                      DPromoGrRelation2."Source Type" := DPromoGrRelation2."Source Type"::Customer;
                      DPromoGrRelation2."Source No." := "No.";
                      if DPromoGrRelation2.INSERT then;
                    until DPromoGrRelation.NEXT = 0;

                  DefaultDim.SETRANGE("Table ID",DATABASE::"Customer Template");
                  DefaultDim.SETRANGE("No.",CustTemplate.Code);
                  DimMgt.MoveDefaultDimToDefaultDim(DefaultDim,DATABASE::Customer,"No.");
                  DimMgt.UpdateDefaultDim(
                    DATABASE::Customer,"No.",
                    "Global Dimension 1 Code","Global Dimension 2 Code");
                  ///DITW110.00.11 MSF 08/11/2017 NRQ#13577
                  MODIFY(true);
                end;
            end;
        }
        field(2014495;"Delivery Sequence";Integer)
        {
            BlankZero = true;
            CaptionML = ENU='Delivery Sequence',
                        FRA='Séquence de livraison';
            Description = 'DITW15.00.00.39 RBE 21/04/2011 #1230 #1002';
            MinValue = 0;
        }
        field(2014496;"Invoice List Customer No.";Code[20])
        {
            CaptionML = ENU='Invoice List Customer No.',
                        FRA='N° client liste facture';
            Description = 'DITW17.10.05 DIT-715 #761';
            TableRelation = Customer;
        }
        field(2014509;"Ship-to Code";Code[10])
        {
            CaptionML = ENU='Ship-to Code',
                        FRA='Code destinataire';
            Description = 'DITW16.00.00.43 DIT-715 #604';
            TableRelation = "Ship-to Address".Code WHERE ("Customer No."=FIELD("No."));
        }
        field(2014512;"No. of Loyalty Groups";Integer)
        {
            CalcFormula = Count("Loyalty Relation" WHERE ("Source Type"=CONST(Customer),
                                                          "Source No."=FIELD("No.")));
            CaptionML = ENU='No. of Loyalty Groups',
                        FRA='Nre de Groupes Fidélité';
            Description = 'DITW16.00.00.40 DIT-715 #243';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2029610;"Postal address";Code[20])
        {
            CaptionML = ENU='Postal address',
                        FRA='Adresse postale';
            Description = 'FINXL7.00.001';
            TableRelation = Contact;
        }
        field(2029611;"Send Document";Option)
        {
            CaptionML = ENU='Send Document',
                        FRA='Envoyer Document';
            Description = 'FINXL8.00.001';
            OptionCaptionML = ENU=' ,Mail,Print,Mail & Print',
                              FRA=' ,E-Mail,Imprimer,E-Mail & Imprimer';
            OptionMembers = " ",Mail,Print,"Mail & Print";
        }
        field(2029612;"Bill-to Adress Code";Code[10])
        {
            CaptionML = ENU='Bill-to Adress Code',
                        FRA='Caude Adresse facturation';
            Description = 'FINXL8.00.001';
            TableRelation = IF ("Bill-to Customer No."=CONST('')) "Ship-to Address".Code WHERE ("Customer No."=FIELD("No."),
                                                                                                "Bill-to"=CONST(true))
                                                                                                else "Ship-to Address".Code WHERE ("Customer No."=FIELD("Bill-to Customer No."),
                                                                                                                                   "Bill-to"=CONST(true));
        }
        field(2029613;"Shortcut Property 1 Code";Code[20])
        {
            CaptionClass = '2029610,2,1/18';
            CaptionML = ENU='Shortcut Property 1 Code',
                        FRA='Code raccourci propriété 1';
            Description = 'FINXL9.00';
            TableRelation = "Property Value".Code WHERE ("Table ID"=CONST(18),
                                                         "Property Code"=FILTER(<>''),
                                                         "Shortcut No."=CONST(1));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                "Shortcut Property 1 Code" := fctValidateShortcutPropertyCode(1,"Shortcut Property 1 Code");  //FINXL9.00.001 DAT 07/03/2016
            end;
        }
        field(2029614;"Shortcut Property 2 Code";Code[20])
        {
            CaptionClass = '2029610,2,2/18';
            CaptionML = ENU='Shortcut Property 2 Code',
                        FRA='Code raccourci propriété 2';
            Description = 'FINXL9.00';
            TableRelation = "Property Value".Code WHERE ("Table ID"=CONST(18),
                                                         "Property Code"=FILTER(<>''),
                                                         "Shortcut No."=CONST(2));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                "Shortcut Property 2 Code" := fctValidateShortcutPropertyCode(2,"Shortcut Property 2 Code");  //FINXL9.00.001 DAT 07/03/2016
            end;
        }
        field(2029615;"Shortcut Property 3 Code";Code[20])
        {
            CaptionClass = '2029610,2,3/18';
            CaptionML = ENU='Shortcut Property 3 Code',
                        FRA='Code raccourci propriété 3';
            Description = 'FINXL9.00';
            TableRelation = "Property Value".Code WHERE ("Table ID"=CONST(18),
                                                         "Property Code"=FILTER(<>''),
                                                         "Shortcut No."=CONST(3));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                "Shortcut Property 3 Code" := fctValidateShortcutPropertyCode(3,"Shortcut Property 3 Code");  //FINXL9.00.001 DAT 07/03/2016
            end;
        }
        field(2029616;"Shortcut Property 4 Code";Code[20])
        {
            CaptionClass = '2029610,2,4/18';
            CaptionML = ENU='Shortcut Property 4 Code',
                        FRA='Code raccourci propriété 4';
            Description = 'FINXL9.00';
            TableRelation = "Property Value".Code WHERE ("Table ID"=CONST(18),
                                                         "Property Code"=FILTER(<>''),
                                                         "Shortcut No."=CONST(4));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                "Shortcut Property 4 Code" := fctValidateShortcutPropertyCode(4,"Shortcut Property 4 Code");  //FINXL9.00.001 DAT 07/03/2016
            end;
        }
        field(2029617;"Shortcut Property 5 Code";Code[20])
        {
            CaptionClass = '2029610,2,5/18';
            CaptionML = ENU='Shortcut Property 5 Code',
                        FRA='Code raccourci propriété 5';
            Description = 'FINXL9.00';
            TableRelation = "Property Value".Code WHERE ("Table ID"=CONST(18),
                                                         "Property Code"=FILTER(<>''),
                                                         "Shortcut No."=CONST(5));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                "Shortcut Property 5 Code" := fctValidateShortcutPropertyCode(5,"Shortcut Property 5 Code");  //FINXL9.00.001 DAT 07/03/2016
            end;
        }
        field(2029618;"Shortcut Property 6 Code";Code[20])
        {
            CaptionClass = '2029610,2,6/18';
            CaptionML = ENU='Shortcut Property 6 Code',
                        FRA='Code raccourci propriété 6';
            Description = 'FINXL9.00';
            TableRelation = "Property Value".Code WHERE ("Table ID"=CONST(18),
                                                         "Property Code"=FILTER(<>''),
                                                         "Shortcut No."=CONST(6));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                "Shortcut Property 6 Code" := fctValidateShortcutPropertyCode(6,"Shortcut Property 6 Code");  //FINXL9.00.001 DAT 07/03/2016
            end;
        }
        field(2029619;"Shortcut Property 7 Code";Code[20])
        {
            CaptionClass = '2029610,2,7/18';
            CaptionML = ENU='Shortcut Property 7 Code',
                        FRA='Code raccourci propriété 7';
            Description = 'FINXL9.00';
            TableRelation = "Property Value".Code WHERE ("Table ID"=CONST(18),
                                                         "Property Code"=FILTER(<>''),
                                                         "Shortcut No."=CONST(7));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                "Shortcut Property 7 Code" := fctValidateShortcutPropertyCode(7,"Shortcut Property 7 Code");  //FINXL9.00.001 DAT 07/03/2016
            end;
        }
        field(2029620;"Shortcut Property 8 Code";Code[20])
        {
            CaptionClass = '2029610,2,8/18';
            CaptionML = ENU='Shortcut Property 8 Code',
                        FRA='Code raccourci propriété 8';
            Description = 'FINXL9.00';
            TableRelation = "Property Value".Code WHERE ("Table ID"=CONST(18),
                                                         "Property Code"=FILTER(<>''),
                                                         "Shortcut No."=CONST(8));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                "Shortcut Property 8 Code" := fctValidateShortcutPropertyCode(8,"Shortcut Property 8 Code");  //FINXL9.00.001 DAT 07/03/2016
            end;
        }
        field(2029621;"Shortcut Property 9 Code";Code[20])
        {
            CaptionClass = '2029610,2,9/18';
            CaptionML = ENU='Shortcut Property 9 Code',
                        FRA='Code raccourci propriété 9';
            Description = 'FINXL9.00';
            TableRelation = "Property Value".Code WHERE ("Table ID"=CONST(18),
                                                         "Property Code"=FILTER(<>''),
                                                         "Shortcut No."=CONST(9));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                "Shortcut Property 9 Code" := fctValidateShortcutPropertyCode(9,"Shortcut Property 9 Code");  //FINXL9.00.001 DAT 07/03/2016
            end;
        }
        field(2029622;"Shortcut Property 10 Code";Code[20])
        {
            CaptionClass = '2029610,2,10/18';
            CaptionML = ENU='Shortcut Property 10 Code',
                        FRA='Code raccourci propriété 10';
            Description = 'FINXL9.00';
            TableRelation = "Property Value".Code WHERE ("Table ID"=CONST(18),
                                                         "Property Code"=FILTER(<>''),
                                                         "Shortcut No."=CONST(10));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                "Shortcut Property 10 Code" := fctValidateShortcutPropertyCode(10,"Shortcut Property 10 Code");  //FINXL9.00.001 DAT 07/03/2016
            end;
        }
        field(2030011;"Interface Partner";Code[50])
        {
            CaptionML = ENU='Interface Partner',
                        FRA='Interface Partenaire';
            Description = 'IPLXL9.00.001';
            TableRelation = "Interface Partner";
        }
        field(2034840;"Building No.";Code[20])
        {
            CaptionML = ENU='Building No.',
                        FRA='N° immeuble';
            Description = 'DITW15.00.00.35';
            TableRelation = Building;

            trigger OnValidate();
            var
                BuildingCustRel : Record "Building Customer Relation";
                BuildingDefDim : Record "Default Dimension";
                BuildingCustRel2 : Record "Building Customer Relation";
            begin
                CALCFIELDS(
                  "Building Desciption","Building Address","Building Address 2",
                  "Building City","Building Post Code","Building Country/Region Code",
                  "Building Employment Date","Building Last Inactive Date");

                BuildingCustRel.SuspendCustUpdate(true);

                // <<DITW17.10.05 DDR 07/10/2014 DIT-770 #935
                if "Building No." <> '' then begin
                  BuildingCustRel2.SETRANGE("Building No.","Building No.");
                  BuildingCustRel2.SETFILTER("Customer No.",'<>%1',"No.");
                  BuildingCustRel2.SETRANGE(Status,BuildingCustRel2.Status::Active);
                  if BuildingCustRel2.FINDFIRST then begin
                    if not CONFIRM(Text2034841,false,"Building No.",
                      BuildingCustRel2."Customer No.",
                      BuildingCustRel2.FIELDCAPTION("Employment Date"),
                      BuildingCustRel2."Employment Date")
                    then begin
                      xRec."Building No." := "Building No.";
                      exit;
                    end;
                    BuildingCustRel2.DELETE;
                    BuildingCustRel2.Status := BuildingCustRel.Status::Inactive;
                    BuildingCustRel2."Inactive Date" := CALCDATE('<-1D>',TODAY);
                    BuildingCustRel2."Last Date Modified" := TODAY;
                    BuildingCustRel2.INSERT;
                  end;
                end;
                // >>DITW17.10.05 DDR DIT-770 #935

                if ("Building No." <> '')  and (xRec."Building No." = '') then begin
                  BuildingCustRel.SETRANGE("Building No.","Building No.");
                  BuildingCustRel.SETRANGE("Customer No.","No.");
                  if not BuildingCustRel.FINDFIRST then begin
                    BuildingCustRel."Building No." := "Building No.";
                    BuildingCustRel."Customer No." := "No.";
                    BuildingCustRel."Employment Date" := TODAY;
                    BuildingCustRel.Status := BuildingCustRel.Status::Active;
                    BuildingCustRel.INSERT(true);
                  end else begin
                    BuildingCustRel.DELETE;
                    BuildingCustRel.Status := BuildingCustRel.Status::Active;
                    BuildingCustRel."Inactive Date" := 0D;
                    BuildingCustRel."Cause of Inactivity Code" := '';
                    BuildingCustRel."Last Date Modified" := TODAY;
                    BuildingCustRel.INSERT(true);
                  end;
                end else begin
                  BuildingCustRel.SETCURRENTKEY("Customer No.");
                  BuildingCustRel.SETRANGE("Customer No.","No.");
                  BuildingCustRel.SETRANGE("Building No.",xRec."Building No.");
                  if BuildingCustRel.FINDFIRST then begin
                    BuildingCustRel.DELETE;
                    BuildingCustRel.Status := BuildingCustRel.Status::Inactive;
                    BuildingCustRel."Inactive Date" := CALCDATE('<-1D>',TODAY);
                    BuildingCustRel."Last Date Modified" := TODAY;
                    BuildingCustRel.INSERT;
                    if "Building No." <> '' then begin
                      BuildingCustRel.SETRANGE("Building No.","Building No.");
                      if not BuildingCustRel.FINDFIRST then begin
                        BuildingCustRel."Building No." := "Building No.";
                        BuildingCustRel."Customer No." := "No.";
                        BuildingCustRel."Employment Date" := TODAY;
                        BuildingCustRel.Status := BuildingCustRel.Status::Active;
                        BuildingCustRel.INSERT(true);
                      end else begin
                        BuildingCustRel.DELETE;
                        BuildingCustRel.Status := BuildingCustRel.Status::Active;
                        BuildingCustRel."Inactive Date" := 0D;
                        BuildingCustRel."Cause of Inactivity Code" := '';
                        BuildingCustRel."Last Date Modified" := TODAY;
                        BuildingCustRel.INSERT(true);
                      end;
                    end;
                  end else begin
                    BuildingCustRel.SETRANGE("Building No.","Building No.");
                    BuildingCustRel.DELETEALL;
                  end;
                end;
            end;
        }
        field(2034841;"Building Desciption";Text[50])
        {
            CalcFormula = Lookup(Building.Name WHERE ("No."=FIELD("Building No.")));
            CaptionML = ENU='Building Desciption',
                        FRA='Désignation immeuble';
            Description = 'DITW15.00.00.35';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2034842;"Building Address";Text[50])
        {
            CalcFormula = Lookup(Building.Address WHERE ("No."=FIELD("Building No.")));
            CaptionML = ENU='Building Address',
                        FRA='Adresse immeuble';
            Description = 'DITW15.00.00.35';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2034843;"Building Address 2";Text[50])
        {
            CalcFormula = Lookup(Building."Address 2" WHERE ("No."=FIELD("Building No.")));
            CaptionML = ENU='Building Address 2',
                        FRA='Adresse immeuble (2ème ligne)';
            Description = 'DITW15.00.00.35';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2034844;"Building City";Text[30])
        {
            CalcFormula = Lookup(Building.City WHERE ("No."=FIELD("Building No.")));
            CaptionML = ENU='Building City',
                        FRA='Ville immeuble';
            Description = 'DITW15.00.00.35';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2034845;"Building Post Code";Code[20])
        {
            CalcFormula = Lookup(Building."Post Code" WHERE ("No."=FIELD("Building No.")));
            CaptionML = ENU='Building Post Code',
                        FRA='Code postal immeuble';
            Description = 'DITW15.00.00.35';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Post Code";
            ValidateTableRelation = false;
        }
        field(2034846;"Building Country/Region Code";Code[10])
        {
            CalcFormula = Lookup(Building."Country/Region Code" WHERE ("No."=FIELD("Building No.")));
            CaptionML = ENU='Building Country/Region Code',
                        FRA='Code pays/région immeuble';
            Description = 'DITW15.00.00.35';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Country/Region";
        }
        field(2034847;"Building Employment Date";Date)
        {
            CalcFormula = Lookup("Building Customer Relation"."Employment Date" WHERE ("Building No."=FIELD("Building No."),
                                                                                       "Customer No."=FIELD("No."),
                                                                                       Status=CONST(Active)));
            CaptionML = ENU='Building Employment Date',
                        FRA='Date d''entrée immeuble';
            Description = 'DITW15.00.00.35';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2034848;"Building Last Inactive Date";Date)
        {
            CalcFormula = Lookup("Building Customer Relation"."Inactive Date" WHERE ("Customer No."=FIELD(UPPERLIMIT("No.")),
                                                                                     Status=CONST(Inactive)));
            CaptionML = ENU='Building Last Inactive Date',
                        FRA='Dernière Date indisponibilité immeuble';
            Description = 'DITW15.00.00.35';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2034850;"DIT Sub-Contract Type Filter";Option)
        {
            CaptionML = ENU='Sub Contract Type Filter',
                        FRA='Filtre sous type contrat';
            Description = 'DITW15.00.00.37 -  DIT-715 #297';
            FieldClass = FlowFilter;
            OptionCaptionML = ENU=' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
                              FRA=' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
            OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;
        }
        field(2034851;"Loan Interest Cust. Post. Grp.";Code[10])
        {
            CaptionML = ENU='Loan Interest Cust. Post. Grp.',
                        FRA='Groupe Compta Interêts Client';
            Description = 'DITW17.00.02 DIT-770 #163';
            TableRelation = "Customer Posting Group";
        }
        field(2034872;"Contract Group Filter";Code[10])
        {
            CaptionML = ENU='Contract Group Filter',
                        FRA='Filtre groupe contrat';
            Description = 'DITW15.00.00.36';
            FieldClass = FlowFilter;
            TableRelation = "Contract Group" WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type Filter"));
        }
        field(2034873;"Contract Cust. Post. Gr. Stand";Code[10])
        {
            CaptionML = ENU='Customer Posting Group (Service)',
                        FRA='Groupe compta. client (Service)';
            Description = 'DITW15.00.00.35';
            TableRelation = "Customer Posting Group";
        }
        field(2034910;"Contract Cust. Post. Gr. Rent";Code[10])
        {
            CaptionML = ENU='Rent - Customer Posting Group',
                        FRA='Location - Groupe compta. client';
            Description = 'DITW15.00.00.35';
            TableRelation = "Customer Posting Group";
        }
        field(2034911;"Contract Cust. Post. Gr. Loan";Code[10])
        {
            CaptionML = ENU='Loan - Customer Posting Group',
                        FRA='Prêt - Groupe compta. client';
            Description = 'DITW15.00.00.35';
            TableRelation = "Customer Posting Group";
        }
        field(2034912;"Contract Cust. Post. Gr. LoanU";Code[10])
        {
            CaptionML = ENU='Loan in Use - Customer Posting Group',
                        FRA='Prêt à usage - Groupe compta. client';
            Description = 'DITW15.00.00.35';
            TableRelation = "Customer Posting Group";
        }
        field(2034913;"Contract Cust. Post. Gr. Maint";Code[10])
        {
            CaptionML = ENU='Maintenance - Customer Posting Group',
                        FRA='Maintenance - Groupe compta. client';
            Description = 'DITW15.00.00.35';
            TableRelation = "Customer Posting Group";
        }
        field(2034914;"Contract Cust. Post. Gr. Other";Code[10])
        {
            CaptionML = ENU='Other - Customer Posting Group',
                        FRA='Autre - Groupe compta. client';
            Description = 'DITW15.00.00.35';
            TableRelation = "Customer Posting Group";
        }
        field(2034915;"Service Contract No. Filter";Code[20])
        {
            CaptionML = ENU='Contract DIT No. Filter',
                        FRA='Filtre N° contrat DIT';
            Description = 'DITW16.00.00.41 DIT-715 #327';
            FieldClass = FlowFilter;
            TableRelation = "Financial Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract));
        }
        field(2034941;"Contract Cust. Post. Gr. Plant";Code[10])
        {
            CaptionML = ENU='Plant Maint. - Customer Posting Group',
                        FRA='Maint. Usine - Groupe compta. client';
            Description = 'DITW16.00.00.41 DIT-715 #297';
            TableRelation = "Customer Posting Group";
        }
        field(2034942;"Plant Maintenance Caption";Boolean)
        {
            CaptionML = ENU='Plant Maintenance Caption',
                        FRA='Label Maintenance Usine';
            Description = 'DITW16.00.00.41 DIT-715 #297';
            FieldClass = FlowFilter;
        }
        field(2034943;"Customer Posting Group Filter";Code[10])
        {
            CaptionML = ENU='Customer Posting Group Filter',
                        FRA='Filtre groupe compta. client';
            Description = 'DITW17.00.02 SR DIT-770 #163';
            FieldClass = FlowFilter;
            TableRelation = "Customer Posting Group";
        }
        field(2034944;"Plant Maintenance Plant";Boolean)
        {
            CaptionML = ENU='Plant Maintenance Plant',
                        FRA='Maintenance Usine';
            Description = 'DITW18.00.06 DIT-770 #1535';
        }
        field(2035390;"Loyalty Statement On";Option)
        {
            Caption = 'Loyalty Statement On';
            Description = 'DITW110.00.11 NRQ#43605';
            OptionCaption = '"  ,Delivery Note,Invoice,Invoice + Delivery Note"';
            OptionMembers = "  ","Delivery Note",Invoice,"Invoice + Delivery Note";
        }
        field(2035391;"Cross. Ref. on Del. Note";Boolean)
        {
            Caption = 'Show Cross References on Delivery Note';
            Description = 'DITW110.00.11 NRQ#43605';
        }
        field(2035392;"Exp. Date on Del. Note";Boolean)
        {
            Caption = 'Show Expiration Date on Delivery Note';
            Description = 'DITW110.00.11 NRQ#43605';
        }
        field(2035393;"Balance (LCY) (INV.)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE ("Customer No."=FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1"=FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2"=FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code"=FIELD("Currency Filter"),
                                                                                 "Posting Date"=FIELD("Date Filter"),
                                                                                 "DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type Filter"),
                                                                                 "Service Contract No."=FIELD("Service Contract No. Filter"),
                                                                                 "Item Charge Type"=FIELD("Item Charge Type Filter"),
                                                                                 "Customer Posting Group"=FIELD("Customer Posting Group Filter"),
                                                                                 "Initial Document Type"=FILTER(Invoice|" ")));
            Caption = 'Balance (LCY) (INV.)';
            Description = 'NRQ#39758';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2035394;"Balance (LCY) (CM/PMT)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE ("Customer No."=FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1"=FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2"=FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code"=FIELD("Currency Filter"),
                                                                                 "Posting Date"=FIELD("Date Filter"),
                                                                                 "DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type Filter"),
                                                                                 "Service Contract No."=FIELD("Service Contract No. Filter"),
                                                                                 "Item Charge Type"=FIELD("Item Charge Type Filter"),
                                                                                 "Customer Posting Group"=FIELD("Customer Posting Group Filter"),
                                                                                 "Initial Document Type"=FILTER("Credit Memo"|Payment)));
            Caption = 'Balance (LCY) (CM/PMT)';
            Description = 'NRQ#39758';
            Editable = false;
            FieldClass = FlowField;
        }
        */
        //end OF DRINKIT FIELDS
        //BCUPGRADE<<
    }

    keys
    {
        //BCUPGRaDE>>
        //NOT added for hnk
        /*
        key(Key1;"Customer DDeposit Group Code")
        {
        }
        key(Key2;"Customer DTax Group Code")
        {
        }
        key(Key3;Route)
        {
        }
        key(Key4;GLN)
        {
        }
        key(Key5;"Account Group")
        {
        }*/
        //BCUPGRADE
    }
    //BC UPGRDAE KUMARR78 ++30-06-2026
    fieldgroups
    {
        addlast(DropDown; "Account Group FND")
        {
        }
    }
    //BC UPGRDAE KUMARR78 ++30-06-2026


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: SalesTaxItemCharge)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ApprovalsMgmt.OnCancelCustomerApprovalRequest(Rec);

    ServiceItem.SETRANGE("Customer No.","No.");
    IF ServiceItem.FINDFIRST THEN
      IF CONFIRM(
           Text008,
           FALSE,
           TABLECAPTION,
           "No.",
           ServiceItem.FIELDCAPTION("Customer No."))
      THEN
        ServiceItem.MODIFYALL("Customer No.",'')
      else
        ERROR(Text009);

    Job.SETRANGE("Bill-to Customer No.","No.");
    IF NOT Job.ISEMPTY THEN
      ERROR(Text015,TABLECAPTION,"No.",Job.TABLECAPTION);

    MoveEntries.MoveCustEntries(Rec);
    #21..42
    SalesPrepmtPct.DELETEALL;

    StdCustSalesCode.SETRANGE("Customer No.","No.");
    StdCustSalesCode.DELETEALL(TRUE);

    ItemCrossReference.SETCURRENTKEY("Cross-Reference Type","Cross-Reference Type No.");
    ItemCrossReference.SETRANGE("Cross-Reference Type",ItemCrossReference."Cross-Reference Type"::Customer);
    ItemCrossReference.SETRANGE("Cross-Reference Type No.","No.");
    ItemCrossReference.DELETEALL;

    IF NOT SocialListeningSearchTopic.ISEMPTY THEN BEGIN
      SocialListeningSearchTopic.FindSearchTopic(SocialListeningSearchTopic."Source Type"::Customer,"No.");
      SocialListeningSearchTopic.DELETEALL;
    end;

    SalesOrderLine.SETCURRENTKEY("Document Type","Bill-to Customer No.");
    SalesOrderLine.SETFILTER(
      "Document Type",'%1|%2',
      SalesOrderLine."Document Type"::Order,
      SalesOrderLine."Document Type"::"Return Order");
    SalesOrderLine.SETRANGE("Bill-to Customer No.","No.");
    IF SalesOrderLine.FINDFIRST THEN
      ERROR(
        Text000,
        TABLECAPTION,"No.",SalesOrderLine."Document Type");

    SalesOrderLine.SETRANGE("Bill-to Customer No.");
    SalesOrderLine.SETRANGE("Sell-to Customer No.","No.");
    IF SalesOrderLine.FINDFIRST THEN
      ERROR(
        Text000,
        TABLECAPTION,"No.",SalesOrderLine."Document Type");

    CampaignTargetGr.SETRANGE("No.","No.");
    CampaignTargetGr.SETRANGE(Type,CampaignTargetGr.Type::Customer);
    IF CampaignTargetGr.FIND('-') THEN BEGIN
      ContactBusRel.SETRANGE("Link to Table",ContactBusRel."Link to Table"::Customer);
      ContactBusRel.SETRANGE("No.","No.");
      ContactBusRel.FINDFIRST;
      REPEAT
        CampaignTargetGrMgmt.ConverttoContact(Rec,ContactBusRel."Contact No.");
      UNTIL CampaignTargetGr.NEXT = 0;
    end;

    ServContract.SETFILTER(Status,'<>%1',ServContract.Status::Canceled);
    ServContract.SETRANGE("Customer No.","No.");
    IF NOT ServContract.ISEMPTY THEN
      ERROR(
        Text007,
        TABLECAPTION,"No.");
    #93..95

    ServContract.SETFILTER(Status,'<>%1',ServContract.Status::Canceled);
    ServContract.SETRANGE("Bill-to Customer No.","No.");
    IF NOT ServContract.ISEMPTY THEN
      ERROR(
        Text007,
        TABLECAPTION,"No.");
    #103..105

    ServHeader.SETCURRENTKEY("Customer No.","Order Date");
    ServHeader.SETRANGE("Customer No.","No.");
    IF ServHeader.FINDFIRST THEN
      ERROR(
        Text013,
        TABLECAPTION,"No.",ServHeader."Document Type");

    ServHeader.SETRANGE("Bill-to Customer No.");
    IF ServHeader.FINDFIRST THEN
      ERROR(
        Text013,
        TABLECAPTION,"No.",ServHeader."Document Type");

    UpdateContFromCust.OnDelete(Rec);

    CustomReportSelection.SETRANGE("Source Type",DATABASE::Customer);
    #123..127
    VATRegistrationLogMgt.DeleteCustomerLog(Rec);

    DimMgt.DeleteDefaultDim(DATABASE::Customer,"No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    if ServiceItem.FINDFIRST then
      if CONFIRM(
           Text008,
           false,
    #8..10
      then
        ServiceItem.MODIFYALL("Customer No.",'')
      else
    #14..16
    if not Job.ISEMPTY then
    #18..45
    StdCustSalesCode.DELETEALL(true);
    #47..52
    // <<DITW15.00.00.01 DDR 18/03/2008
    SalesTaxItemCharge.SETRANGE("Sales Type",SalesTaxItemCharge."Sales Type"::Customer);
    SalesTaxItemCharge.SETRANGE("Sales Code","No.");
    SalesTaxItemCharge.DELETEALL;

    SalesDepositItemCharge.SETRANGE("Sales Type",SalesDepositItemCharge."Sales Type"::Customer);
    SalesDepositItemCharge.SETRANGE("Sales Code","No.");
    SalesDepositItemCharge.DELETEALL;

    SalesDiscountItemCharge.SETRANGE("Sales Type",SalesDiscountItemCharge."Sales Type"::Customer);
    SalesDiscountItemCharge.SETRANGE("Sales Code","No.");
    SalesDiscountItemCharge.DELETEALL;

    SalesPromotionItemCharge.SETRANGE("Sales Type",SalesPromotionItemCharge."Sales Type"::Customer);
    SalesPromotionItemCharge.SETRANGE("Sales Code","No.");
    SalesPromotionItemCharge.DELETEALL;

    // <<DITW15.00.00.23 DDR 01/08/2008
    DrinkDiscountRelation.SETRANGE("Source Type",DrinkDiscountRelation."Source Type"::Customer);
    DrinkDiscountRelation.SETRANGE("Source No.","No.");
    DrinkDiscountRelation.DELETEALL;

    DrinkPromotionRelaton.SETRANGE("Source Type",DrinkPromotionRelaton."Source Type"::Customer);
    DrinkPromotionRelaton.SETRANGE("Source No.","No.");
    DrinkPromotionRelaton.DELETEALL;
    // >>DITW15.00.00.23 DDR

    SalesDepositLimit.SETCURRENTKEY("Sales Type","Sales Code");
    SalesDepositLimit.SETRANGE("Sales Type",SalesDepositLimit."Sales Type"::Customer);
    SalesDepositLimit.SETRANGE("Sales Code","No.");
    SalesDepositLimit.DELETEALL;
    // >>DITW15.00.00.01 DDR

    if not SocialListeningSearchTopic.ISEMPTY then begin
      SocialListeningSearchTopic.FindSearchTopic(SocialListeningSearchTopic."Source Type"::Customer,"No.");
      SocialListeningSearchTopic.DELETEALL;
    end;
    #57..63
    if SalesOrderLine.FINDFIRST then
    #65..70
    if SalesOrderLine.FINDFIRST then
    #72..77
    if CampaignTargetGr.FIND('-') then begin
    #79..81
      repeat
        CampaignTargetGrMgmt.ConverttoContact(Rec,ContactBusRel."Contact No.");
      until CampaignTargetGr.NEXT = 0;
    end;

    // <<DITW16.00.00.42 DDR 12/02/2013 DIT-715 #523
    ServContract.SETFILTER(Status,'<>%1&<>%2',ServContract.Status::Canceled,ServContract.Status::Closed);
    // >>DITW16.00.00.42 DDR DIT-715 #523
    ServContract.SETRANGE("Customer No.","No.");
    if not ServContract.ISEMPTY then
    #90..98
    if not ServContract.ISEMPTY then
    #100..108
    if ServHeader.FINDFIRST then
    #110..114
    if ServHeader.FINDFIRST then
    #116..119
    // <<DITW15.00.00.35 DDR 10/04/2009
    BuildingCustRel.SETCURRENTKEY("Customer No.");
    BuildingCustRel.SETRANGE("Customer No.","No.");
    BuildingCustRel.SETRANGE(Status,BuildingCustRel.Status::Active);
    if BuildingCustRel.FINDFIRST then
      ERROR(
        Text2034840,TABLECAPTION,"No.");

    BuildingCustRel.SETRANGE(Status);
    BuildingCustRel.DELETEALL;
    // >>DITW15.00.00.35 DDR

    //<< DITW110.00.12A ISL 21/06/2018 NRQ#67425
    ServiceCustRel.SETCURRENTKEY("Customer No.");
    ServiceCustRel.SETRANGE("Customer No.","No.");
    ServiceCustRel.SETRANGE(Status,ServiceCustRel.Status::Active);
    if ServiceCustRel.FINDFIRST then
      ERROR(
        Text2034845,TABLECAPTION,"No.");

    ServiceCustRel.SETRANGE(Status);
    ServiceCustRel.DELETEALL;
    //>> DITW110.00.12A ISL NRQ#67425
    #120..130

    //<< FINXL10.01 AKH 19/07/2017 NRQ#33089
    SalesSetup.GET;
    if (SalesSetup."Customer Auto Dimension Code" <> '') then begin
      if rDimValue.GET(SalesSetup."Customer Auto Dimension Code","No.") then
        rDimValue.DELETE(true);
    end;
    //>> FINXL10.01 AKH 19/07/2017 NRQ#33089
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "No." = '' THEN BEGIN
      SalesSetup.GET;
      SalesSetup.TESTFIELD("Customer Nos.");
      NoSeriesMgt.InitSeries(SalesSetup."Customer Nos.",xRec."No. Series",0D,"No.","No. Series");
    end;

    IF "Invoice Disc. Code" = '' THEN
      "Invoice Disc. Code" := "No.";

    IF NOT (InsertFromContact OR (InsertFromTemplate AND (Contact <> ''))) THEN
      UpdateContFromCust.OnInsert(Rec);

    DimMgt.UpdateDefaultDim(
      DATABASE::Customer,"No.",
      "Global Dimension 1 Code","Global Dimension 2 Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if "No." = '' then begin
    #2..4
    end;

    if "Invoice Disc. Code" = '' then
      "Invoice Disc. Code" := "No.";

    if not (InsertFromContact or (InsertFromTemplate and (Contact <> ''))) then
    #11..15
    //<< FINXL10.01 AKH 19/07/2017 NRQ#33089
    SalesSetup.GET;
    if SalesSetup."Customer Auto Dimension Code" <> '' then begin
      txtDimName := DimMgt.fctGetDimNameFromSource(Name,"Name 2");
      DimMgt.fctUpdateSetupAnyDimValueCode(
        SalesSetup."Customer Auto Dimension Code","No.",txtDimName,false);
      DimMgt.fctSaveAnyDefaultDimOnInsert(
        DATABASE::Customer,"No.",SalesSetup."Customer Auto Dimension Code","No.",
        //<< FINXL10.01 AKH 28/07/2017 NRQ#33089
        rDefaultDim."Value Posting"::" ");
        //>> FINXL10.01 AKH 28/07/2017 NRQ#33089
    end;
    //>> FINXL10.01 AKH 19/07/2017 NRQ#33089
    ///DITW110.00.11 MSF 07/11/2017 NRQ#13577
    //<<DITW17.10.05 MSF 14/08/2014 DIT-770 #827
    "Empty Goods Statement On" :="Empty Goods Statement On" ::"Invoice + Delivery Note";
    //>>DITW17.10.05 MSF 14/08/2014 DIT-770 #827

    //<< DITW17.10.05 YHE 02/09/2014 DIT-770 #754
    if SalesSetup.GET then begin
     "Shipment Date Alert Filter" := SalesSetup."Shipment Date Alert Filter" ;
     "Shipment Status Alert Filter" := SalesSetup."Shipment Status Alert Filter";
    end;
    //>> DITW17.10.05 YHE 02/09/2014 DIT-770 #754

    //<<HEI.05
    InsertInCustAttributes("No.");
    //>>HEI.05
    //HEI.22>>
    "Risk Category" := SalesSetup."Default Risk Grade";
    "Risk Score" := SalesSetup."Default Risk Score";
    //HEI.22<<
    */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Last Date Modified" := TODAY;

    IF (Name <> xRec.Name) OR
       ("Search Name" <> xRec."Search Name") OR
       ("Name 2" <> xRec."Name 2") OR
       (Address <> xRec.Address) OR
       ("Address 2" <> xRec."Address 2") OR
       (City <> xRec.City) OR
       ("Phone No." <> xRec."Phone No.") OR
       ("Telex No." <> xRec."Telex No.") OR
       ("Territory Code" <> xRec."Territory Code") OR
       ("Currency Code" <> xRec."Currency Code") OR
       ("Language Code" <> xRec."Language Code") OR
       ("Salesperson Code" <> xRec."Salesperson Code") OR
       ("Country/Region Code" <> xRec."Country/Region Code") OR
       ("Fax No." <> xRec."Fax No.") OR
       ("Telex Answer Back" <> xRec."Telex Answer Back") OR
       ("VAT Registration No." <> xRec."VAT Registration No.") OR
       ("Post Code" <> xRec."Post Code") OR
       (County <> xRec.County) OR
       ("E-Mail" <> xRec."E-Mail") OR
       ("Home Page" <> xRec."Home Page") OR
       (Contact <> xRec.Contact)
    THEN BEGIN
      MODIFY;
      UpdateContFromCust.OnModify(Rec);
      IF NOT FIND THEN BEGIN
        RESET;
        IF FIND THEN;
      end;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Last Date Modified" := TODAY;

    if (Name <> xRec.Name) or
       ("Search Name" <> xRec."Search Name") or
       ("Name 2" <> xRec."Name 2") or
       (Address <> xRec.Address) or
       ("Address 2" <> xRec."Address 2") or
       (City <> xRec.City) or
       ("Phone No." <> xRec."Phone No.") or
       ("Telex No." <> xRec."Telex No.") or
       ("Territory Code" <> xRec."Territory Code") or
       ("Currency Code" <> xRec."Currency Code") or
       ("Language Code" <> xRec."Language Code") or
       ("Salesperson Code" <> xRec."Salesperson Code") or
       ("Country/Region Code" <> xRec."Country/Region Code") or
       ("Fax No." <> xRec."Fax No.") or
       ("Telex Answer Back" <> xRec."Telex Answer Back") or
       ("VAT Registration No." <> xRec."VAT Registration No.") or
       ("Post Code" <> xRec."Post Code") or
       (County <> xRec.County) or
       ("E-Mail" <> xRec."E-Mail") or
       ("Home Page" <> xRec."Home Page") or
       (Contact <> xRec.Contact)
    then begin
      MODIFY;
      UpdateContFromCust.OnModify(Rec);
      if not FIND then begin
        RESET;
        if FIND then;
      end;
    end;
    ///DITW110.00.11 MSF 08/11/2017 NRQ#13577 - DITW15.00.00.33 DDR 08/05/2009
    // HEI.02 NAIKH01
    if "Netting Agreement" then begin
      if "Vendor No." = '' then
        Blocked := Blocked::All;
    end;
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnRename". Please convert manually.

    //trigger (Variable: lcodNewNo)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnRename". Please convert manually.

    //trigger OnRename();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ApprovalsMgmt.RenameApprovalEntries(xRec.RECORDID,RECORDID);
    "Last Date Modified" := TODAY;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    /// DITW17.00.02 SR 20/09/2013 DIT-770 #187 - DITW110.00.08 DDR 09/02/2017 NRQ#20699
    ApprovalsMgmt.RenameApprovalEntries(xRec.RECORDID,RECORDID);
    //<< FINXL10.01 AKH 19/07/2017 NRQ#33089
    SalesSetup.GET;
    if (SalesSetup."Customer Auto Dimension Code" <> '') then begin
      txtDimName := DimMgt.fctGetDimNameFromSource(Name,"Name 2");
      DimMgt.fctRenameSetupAnyDimValueCode(
        SalesSetup."Customer Auto Dimension Code",xRec."No.","No.",txtDimName);
      //<< FINXL10.01 AKH 28/07/2017 NRQ#33089
      lcodNewNo := "No.";
      GET(xRec."No.");
      "No." := lcodNewNo;
      //>> FINXL10.01 AKH 28/07/2017 NRQ#33089
    end;
    //>> FINXL10.01 AKH 19/07/2017 NRQ#33089
    "Last Date Modified" := TODAY;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        BlockedReason: Record "Blocked Reason FND";
        "Cust.LedEntry": Record "Cust. Ledger Entry";
        CustCalenderChanges: Record "Customized Calendar Change";
        rDefaultDim: Record "Default Dimension";
        rDim: Record Dimension;
        rDimValue: Record "Dimension Value";
        rShipmentMethod: Record "Shipment Method";
        //BCUPGRADE>>
        //AppMgt : Codeunit ApplicationManagement;
        //BCUPGRADE<<
        UserSetup: Record "User Setup";
        DisputeExists: Boolean;
        RunModeCaptionPM: Boolean;
        //BCUPGRADE>>
        //DRINKIT
        /*
            SalesTaxItemCharge : Record "Sales Tax Item Charge";
            SalesDepositItemCharge : Record "Sales Deposit Item Charge";
            SalesDiscountItemCharge : Record "Sales Discount Item Charge";
            SalesPromotionItemCharge : Record "Sales Promotion Item Charge";
            DrinkDiscountRelation : Record "Drink Discount Relation";
            DrinkPromotionRelaton : Record "Drink Promotion Relation";
            SalesDepositLimit : Record "Sales Deposit Limit";
            BuildingCustRel : Record "Building Customer Relation";
            ServiceCustRel : Record "Service Item Customer Relation";
           */
        //BCUPGRADE<<
        lcodNewNo: Code[20];

        AddCreditLimitLCY: Decimal;
        DelayedBalanceDueLCY: Decimal;
        //HeinekenGlobal : Codeunit "Heineken Global";
        SensitiveBlockError: Label 'You cannot create this type of document when sensitive payment block is enable for Customer %1';
        Text2034845: Label 'You cannot delete %1 %2 because there is at least one active Service item relation for this customer.';
        txtDimName: Text;
        DisputeErr: TextConst ENU = 'Open dispute cases exist for customer %1 Do you want to continue?';


        //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //Text000 : ENU=You cannot delete %1 %2 because there is at least one outstanding Sales %3 for this customer.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text000 : ENU=You cannot delete %1 %2 because there is at least one outstanding Sales %3 for this customer.;FRA=Vous ne pouvez pas supprimer %1 %2 car il existe encore au moins une %3 vente ouverte pour ce client.;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "Text002(Variable 1001)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //Text002 : ENU=Do you wish to create a contact for %1 %2?;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text002 : ENU=Do you wish to create a contact for %1 %2?;FRA=Souhaitez-vous créer un contact pour %1 %2 ?;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "Text003(Variable 1020)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //Text003 : ENU=Contact %1 %2 is not related to customer %3 %4.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text003 : ENU=Contact %1 %2 is not related to customer %3 %4.;FRA=Le contact %1 %2 n'est pas associé au client %3 %4.;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "Text004(Variable 1023)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //Text004 : ENU=post;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text004 : ENU=post;FRA=valider;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "Text005(Variable 1024)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //Text005 : ENU=create;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text005 : ENU=create;FRA=créer;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "Text006(Variable 1025)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //Text006 : ENU=You cannot %1 this type of document when Customer %2 is blocked with type %3;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text006 : ENU=You cannot %1 this type of document when Customer %2 is blocked with type %3;FRA=Vous ne pouvez pas %1 ce type de document lorsque le client %2 est bloqué avec le type %3;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "Text007(Variable 1028)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //Text007 : ENU=You cannot delete %1 %2 because there is at least one not cancelled Service Contract for this customer.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text007 : ENU=You cannot delete %1 %2 because there is at least one not cancelled Service Contract for this customer.;FRA=Vous ne pouvez pas supprimer l'enregistrement %1 %2 car il existe au moins un contrat service qui n'a pas été annulé pour ce client.;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "Text008(Variable 1029)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //Text008 : ENU=Deleting the %1 %2 will cause the %3 to be deleted for the associated Service Items. Do you want to continue?;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text008 : ENU=Deleting the %1 %2 will cause the %3 to be deleted for the associated Service Items. Do you want to continue?;FRA=Supprimer l'enregistrement %1 %2 va entraîner la suppression de la valeur %3 pour les articles de service associés. Souhaitez-vous continuer ?;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "Text009(Variable 1030)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //Text009 : ENU=Cannot delete customer.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text009 : ENU=Cannot delete customer.;FRA=Impossible de supprimer ce client.;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "Text010(Variable 1031)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //Text010 : ENU=The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3. Enter another code.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text010 : ENU=The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3. Enter another code.;FRA=La valeur %1 %2 a été affectée à %3 %4.\La même valeur %1 ne peut pas être entrée sur plus d'un/une %3. Entrez un autre code.;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "Text011(Variable 1033)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //Text011 : ENU=Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text011 : ENU=Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?;FRA=Le rapprochement des transactions IC risque de poser problème si vous modifiez le code partenaire IC car ce/cette %1 comporte des écritures comptables appartenant à un exercice comptable qui n'a pas encore été clôturé.\ Souhaitez-vous quand même modifier le code partenaire IC ?;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "Text012(Variable 1032)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //Text012 : ENU=You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text012 : ENU=You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.;FRA=Vous ne pouvez pas modifier la valeur du champ %1 car ce/cette %2 comporte une ou plusieurs écritures comptables ouvertes.;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "Text013(Variable 1035)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //Text013 : ENU=You cannot delete %1 %2 because there is at least one outstanding Service %3 for this customer.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text013 : ENU=You cannot delete %1 %2 because there is at least one outstanding Service %3 for this customer.;FRA=Vous ne pouvez pas supprimer %1 %2 car il existe encore au moins un(e) %3 service ouvert(e) pour ce client.;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "Text014(Variable 1017)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //Text014 : ENU=Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text014 : ENU=Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.;FRA=Avant de pouvoir utiliser Online Map, vous devez compléter la fenêtre Configuration Online Map.\Consultez la section Configuration d'Online Map dans l'Aide.;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "Text015(Variable 1036)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //Text015 : ENU=You cannot delete %1 %2 because there is at least one %3 associated to this customer.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text015 : ENU=You cannot delete %1 %2 because there is at least one %3 associated to this customer.;FRA=Vous ne pouvez pas supprimer %1 %2 car au moins un/une %3 est associé(e) à ce client.;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "AllowPaymentToleranceQst(Variable 1037)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //AllowPaymentToleranceQst : ENU=Do you want to allow payment tolerance for entries that are currently open?;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //AllowPaymentToleranceQst : ENU=Do you want to allow payment tolerance for entries that are currently open?;FRA=Souhaitez-vous autoriser les écarts de règlement pour les écritures actuellement ouvertes ?;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "RemovePaymentRoleranceQst(Variable 1019)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //RemovePaymentRoleranceQst : ENU=Do you want to remove payment tolerance from entries that are currently open?;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //RemovePaymentRoleranceQst : ENU=Do you want to remove payment tolerance from entries that are currently open?;FRA=Souhaitez-vous supprimer les écarts de règlement pour les écritures actuellement ouvertes ?;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "CreateNewCustTxt(Variable 1041)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //CreateNewCustTxt : @@@="%1 is the name to be used to create the customer. ";ENU=Create a new customer card for %1;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CreateNewCustTxt : @@@="%1 is the name to be used to create the customer. ";ENU=Create a new customer card for %1;FRA=Créer une fiche client pour %1;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "SelectCustErr(Variable 1040)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //SelectCustErr : ENU=You must select an existing customer.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //SelectCustErr : ENU=You must select an existing customer.;FRA=Vous devez sélectionner un client existant.;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "CustNotRegisteredTxt(Variable 1042)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //CustNotRegisteredTxt : ENU=This customer is not registered. To continue, choose one of the following options:;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CustNotRegisteredTxt : ENU=This customer is not registered. To continue, choose one of the following options:;FRA=Ce client n'est pas enregistré. Pour continuer, sélectionnez l'une des options suivantes :;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "SelectCustTxt(Variable 1043)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //SelectCustTxt : ENU=Select an existing customer;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //SelectCustTxt : ENU=Select an existing customer;FRA=Sélectionner un client existant;
        //Variable type has not been exported.

        //cduUserSetupMngt : Codeunit "User Setup Management";
        Text2013660: TextConst ENU = 'You must specify %1 in %2 or %3 or %4 when %5 %6.', FRA = 'Vous devez spécifier %1 dans %2 ou %3 ou %4 quand %5 %6.';
        //BCUPGRADE>>
        //DRINKIT
        /*
        PropServMgtSetup : Record "Property Service Mgt. Setup";
        CustTemplate : Record "Customer Template";
        DDiscGrRelation : Record "Drink Discount Relation";
        DPromoGrRelation : Record "Drink Promotion Relation";
*/
        //BCUPGRADE<<
        Text2013910: TextConst ENU = 'Contact %1 %2 is related to a different company than customer %3.', FRA = 'Le contact %1 %2 est associé à une société différente de celle du client %3.';
        Text2014060: TextConst ENU = 'Do you want to replace the existing %1 ''%2'' with the ''%3'' from %4 ''%5''?', FRA = 'Voulez-vous remplacer le %1 ''%2'' existant avec le ''%3'' de %4 ''%5''?';
        Text2014095: TextConst ENU = 'Can only be filled in, if Invoice Method is Combine Shipments or Combine Shipments Per Sell-to', FRA = 'Ne peut pas être rempli si methode de facturation est Combiner expeditions ou Combiner les expeditions par donneur d''ordre';
        Text2014310_1: TextConst ENU = 'Plant No.', FRA = 'N° usine';
        Text2014310_21: TextConst ENU = 'Plant Posting Group', FRA = 'Groupe validation usine';
        Text2014310_23: TextConst ENU = 'Plant Price Group', FRA = 'Groupe prix usine';
        Text2014310_2014473: TextConst ENU = 'Plant Template Code', FRA = 'Code Modèle usine';
        Text2014410: TextConst ENU = 'Changing the Customer Template will update fields with a default value. Do you want to continue?', FRA = 'Modifier le Modéle Client Mettra à jour les champs avec les valeurs par défaut.Voulez-vous continuer?';
        Text2014411: TextConst ENU = 'Do you want to clear all fields before?', FRA = 'Souhaitez-vous effacer tous les champs avant?';
        Text2014412: TextConst ENU = 'You are not allowed to release a customer (user setup)', FRA = 'Opération non autorisée';
        Text2014413: TextConst ENU = 'Do you want to replace the existing %1 with the one from this %2?', FRA = 'Voulez vous remplacer le %1 existant par celui de ce %2?';
        Text2014414: TextConst ENU = '%1 cannot be after %2', FRA = '%1 ne peut pas être après %2';
        Text2029611: TextConst ENU = '%1 is not valid', FRA = '%1 n''est pas valide';
        Text2029612: TextConst ENU = '%1 is valid\Name: %2\Address: %3', FRA = '%1 est valide\Nom: %2\Address: %3';
        Text2034840: TextConst ENU = 'You cannot delete %1 %2 because there is at least one active building relation for this customer.', FRA = 'Vous ne pouvez pas supprimer %1 %2 car il existe encore au moins une relation immeuble active pour ce client.';
        Text2034841: TextConst ENU = 'Building No. %1 is already active for the customer %2 (%3 %4).\Do want to change the building to this customer?', FRA = 'L''immeuble N° %1 est déjà actif pour le client %2 (%3 %4).\Voulez-vous modifier l''immeuble pour ce client?';

    PROCEDURE InsertInCustAttributes(CustNo: Code[20]);
    VAR
        CustomerAttributes: Record "Customer Attributes FND";
    BEGIN
        //>>HEI.05
        IF NOT CustomerAttributes.GET(CustNo) THEN BEGIN
            CustomerAttributes."Customer No." := CustNo;
            CustomerAttributes.INSERT();
        end;
        //<<HEI.05
    end;

    PROCEDURE CopyToDefaultDimensions(CustNo: Code[20]);
    VAR
        Customer2: Record Customer;
        CustomerAttributes: Record "Customer Attributes FND";
        lCustDefaultDimension: Record "Customer Default Dimension FND";
        lDefaultDimension: Record "Default Dimension";
        recLanguage: Record Language;
        RecRef: RecordRef;
        FRef: FieldRef;
        DimensionValue: Code[20];
        intCurrentLanguage: Integer;
    BEGIN
        //<<HEI.06
        IF lCustDefaultDimension.FINDFIRST() THEN
            REPEAT
                lDefaultDimension.RESET();
                //>>HEI.09
                //IF NOT lDefaultDimension.GET(18,"No.",lCustDefaultDimension."Field Name") THEN
                //<<HEI.09
                IF lCustDefaultDimension."Table ID" = lCustDefaultDimension."Table ID"::Cust THEN BEGIN
                    Customer2.GET("No.");
                    RecRef.GETTABLE(Customer2);
                end else IF lCustDefaultDimension."Table ID" = lCustDefaultDimension."Table ID"::"Cust. Attributes" THEN BEGIN
                    CustomerAttributes.GET("No.");
                    RecRef.GETTABLE(CustomerAttributes);
                end;
                FRef := RecRef.FIELD(lCustDefaultDimension."Field ID");
                IF FORMAT(FRef.VALUE) <> '' THEN BEGIN
                    IF NOT lDefaultDimension.GET(18, "No.", lCustDefaultDimension."Dimension Code") THEN BEGIN
                        lDefaultDimension.VALIDATE("Table ID", 18);
                        lDefaultDimension.VALIDATE("No.", "No.");
                        //>>HEI.09
                        //lDefaultDimension.VALIDATE("Dimension Code",lCustDefaultDimension."Field Name");
                        lDefaultDimension.VALIDATE("Dimension Code", lCustDefaultDimension."Dimension Code");
                        lDefaultDimension.INSERT(TRUE); //HEI.17
                    end;
                    //HEI.38>>
                    intCurrentLanguage := GLOBALLANGUAGE;
                    IF recLanguage.GET('ENU') THEN
                        GLOBALLANGUAGE := recLanguage."Windows Language ID";
                    //HEI.38<<
                    lDefaultDimension.VALIDATE("Dimension Value Code", FORMAT(FRef.VALUE));
                    GLOBALLANGUAGE := intCurrentLanguage;  //HEI.38
                                                           //<<HEI.09
                                                           //HEI.17>>
                                                           //lDefaultDimension.INSERT(TRUE);
                    lDefaultDimension.MODIFY(TRUE);
                    //HEI.17<<
                end;
            UNTIL lCustDefaultDimension.NEXT() = 0;
        //>>HEI.06
    end;


    // BC Upgrade MISHRS14 >>
    // Changed datatype of DocType from option to enum to remove warning in CU-50998
    //PROCEDURE CheckBlockedCustOnDocs2(Cust2: Record Customer; DocType: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order"; Shipment: Boolean; Transaction: Boolean; CustType: Option SellTo,BillTo; ForInvoice: Boolean; Ship: Boolean; Invoice: Boolean): Boolean;
    PROCEDURE CheckBlockedCustOnDocs2(Cust2: Record Customer; DocType: Enum "Sales Document Type"; Shipment: Boolean; Transaction: Boolean; CustType: Option SellTo,BillTo; ForInvoice: Boolean; Ship: Boolean; Invoice: Boolean): Boolean;
    // BC Upgrade MISHRS14 <<

    VAR
        Cust3: Record Customer;
    BEGIN
        //HEI.20>>

        //BC Upgrade MISHRS14 >>
        // Blocked with statement as its depreceted
        //WITH Cust2 DO BEGIN
        IF Cust3.GET(Cust2."Bill-to Customer No.") THEN;
        //HEI.30>>
        IF Cust3.Blocked = Cust3.Blocked::All THEN
            CustBlockedErrorMessage(Cust3, Transaction);
        //HEI.30<<
        IF (CustType = CustType::SellTo) AND (NOT ForInvoice) THEN
            IF ((Blocked = Blocked::All) OR
                //((Blocked = Blocked::Invoice) AND (DocType IN [DocType::Quote,DocType::Invoice,DocType::"Blanket Order"])) OR   //commented by HEI.40
                ((Blocked = Blocked::Invoice) AND (DocType IN [DocType::Invoice, DocType::"Blanket Order"])) OR     //HEI.40
                ((Blocked = Blocked::Ship) AND (DocType IN [DocType::Quote, DocType::Order, DocType::"Blanket Order"]) AND (NOT Transaction)) OR
                ((Blocked = Blocked::Ship) AND (DocType IN [DocType::Quote, DocType::Order, DocType::Invoice, DocType::"Blanket Order"]) AND Shipment AND Transaction))
            THEN
                CustBlockedErrorMessage(Cust2, Transaction);

        IF ForInvoice THEN
            IF ((Blocked = Blocked::Ship) AND
                (Cust3."No." <> Cust3."Bill-to Customer No.") AND
                Shipment AND
                Ship AND NOT Invoice) OR
                ((Blocked = Blocked::Invoice) AND
                Shipment AND
                Ship AND Invoice AND
                ((Cust3.Blocked = Cust3.Blocked::Invoice) OR (Cust3.Blocked = Cust3.Blocked::All)))
            THEN
                CustBlockedErrorMessage(Cust2, Transaction);
        EXIT(TRUE);
        //end;
        // BC Upgrade MISHRS14 <<

        //HEI.20<<
    end;
}


