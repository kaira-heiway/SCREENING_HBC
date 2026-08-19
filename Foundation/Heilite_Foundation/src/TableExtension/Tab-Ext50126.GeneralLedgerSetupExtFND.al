tableextension 50126 GeneralLedgerSetupExtFND extends "General Ledger Setup"
{
    //     DITW15.00.00.24 DDR 22/09/2008 Drink-It Tax rounding functionnalities
    //                                Added fields
    //                                  2013716 Amount Decimal Places
    //                                  2013717 Unit-Amount Decimal Places
    //                                  2013718 Amount Rounding Precision
    //                                  2013719 Unit-Amount Rounding Precision
    // DITW15.00.00.32 DDR 08/04/2009 Added functions
    //                                  SetRoundingPrecisionDrink(useTaxRnd)
    // DITW15.00.00.38 DDR 23/02/2011 issue 1286 Added fields
    //                                  2014120 Sell-to/Bill-to DTax Gr. Calc.
    // DITW15.00.00.38 DDR 18/03/2011 issue 703 Added fields
    //                                 2014121 Copy Item to Tax Tracking Item
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields
    //                                 2014428 Appln. per Source reference
    //                     11/12/2012 DIT-715 #370 Renamed field2014428 -> "Appln per Charge Type"
    //                     19/12/2012 DIT-715 #520 Modified 'Caption' field2014120 Sell/Bill DTax gr. calc.
    // DITW16.00.00.43 DDR 25/09/2013 DIT-715 #519 Added fields
    //                                               2014410 Calculate GiftBox Charges from
    //                                               2014411 Include GiftBox Charges

    // FINXL7.00.001 RBE 20/03/2013: Created fields 2029610..2029611
    //                               Created field 2029612 "Mail Standard Text"
    //                               Default value for fields: Transaction Type, Transport Method, Area
    // FINXL8.00.001 BSA 23/06/2015 #161: Created field : "Apply Template"

    // DITW17.00.02 DDR 24/05/2013 DIT-770 #99 Added fields
    //                                           2014560 W5 Nos.
    //                                           2014561 W6 Nos.
    //                  31/05/2013 DIT-770 #100 Added fields
    //                                           2014562 W5d Nos.
    //                                           2014563 W6d Nos.
    //                  31/05/2013 DIT-770 #101 Added fields
    //                                           2014564 Customer Tax Group W1
    //                  19/07/2013 DIT-770 #101 Added fields
    //                                           2014565 Vendor Tax Group W1
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #99 #100 #101
    //              DDR 01/10/2013 DIT-715 #519 Merge
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 AT  06/12/2013 DIT-770 #222 Added Field
    //                                            2014430  Post Inv. Line Desc. to G/L
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 DDR 23/10/2015 DIT-770 #1395 Added fields 2014412 Gift Box Other Item Charge
    // DITW18.00.07 AKH 08/01/2016 DIT-770 #1280 Inventory Movement report - by Entry type in Qty and HL : Added new field 2013720 "Tax Spec. DegPlato Code"
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // DITW19.00.08 SFI 18/08/2016 BL#10868  (DIT-770 #2141) New fields
    //                                                       2014413 Allow Invoice Disc. G/L Acc.
    //                                                       2014414 Allow Invoice Disc. Resource
    //                                                       2014415 Allow Invoice Disc. FA
    //                                                       2014416 Allow Invoice Disc. Item Chrg.

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // FINXL8.00.001 DAT 17/08/2015 #140: changed captions for Fields : "Post Per.template. from Jrnl","Jnl. Temp Name (Aut.accrual.)","Jnl. Btch Name (Aut.accrual .)"
    // FINXL9.00.001 ACH 05/08/2016 : Added Fields 2029620 Transaction Type Mandatory (Boolean)
    //                                             2029621 Transport Method Mandatory (Boolean)
    //                                             2029622 Area Mandatory             (Boolean)
    // FINXL9.00.001 KSW 29/09/2016: added missing captions
    // FINXL9.00.000.01 AKH 13/01/2017 Added new field 2029623 "Automatic Intrastat"

    // HEI.01 FDD-BPMGAP016 IBM SOICAD01 17.06.2017 #Investment Order
    //   #New fields: Capex Dimension Code, Capex Reference Budget, Capex Acc. Schedule Name
    //   #Call to function to mantain acc schedule columns
    // HEI.02 FDD-RTRGAP043 IBM POENAB01 26.07.2017 #Upload Mass Journal Entry Template
    //   #New fields:
    //       50003 Mass Upload Dimension 9
    //       50004 Mass Upload Dimension 10
    //       50005 Mass Upload Dimension 11
    //       50006 Mass Upload Dimension 12
    //       50007 Mass Upload Dimension 13
    //       50008 Mass Upload Dimension 14
    //       50009 Mass Upload Dimension 15
    //       50010 Mass Upload Dimension 16
    //       50011 Mass Upload Dimension 17
    //       50012 Mass Upload Dimension 18
    //       50013 Mass Upload Dimension 19
    //       50014 Mass Upload Dimension 20
    //       50015 Mass Upload Dimension 21
    //       50016 Mass Upload Dimension 22
    //       50017 Mass Upload Dimension 23
    //       50018 Mass Upload Dimension 24
    //       50019 Mass Upload Dimension 25
    //       50020 Mass Upload Dimension 26
    //       50021 Mass Upload Dimension 27
    //       50022 Mass Upload Dimension 28
    //       50023 Mass Upload Dimension 29
    //       50024 Mass Upload Dimension 30
    // HEI.03 FDD RTRGAP062 Heilite BASE IBM ISYED01 04/08/2017 HeiMatch Flatfile
    //   # field created OPCO Dimension Code
    // HEI.04 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # New fields for MDM integration
    // HEI.05 FDD RTRGAP057 IBM HORTOC01 27.07.2017
    //   # Add new field
    // HEI.06 FDD-BPMGAP014 IBM ISYED01 24.08.2017
    //   #Added fileds "Business Type Dimension Code","Brand Dimension Code" to table
    // HEI.07 FDD-BPMGAP001_BPMGAP002 IBM HORTOC01 06.09.2017
    //   Added new fields
    // HEI.08 FDD-RTRGAP001 IBM CHAUHB01 18.09.2017
    //   #Added fileds Cadency Temporary Path
    // HEI.09 FDD-BPMGAP001_BPMGAP002 IBM HORTOC01 21.12.2017
    //   #new field "Gl Budget Standard Cost"
    // HEI.10 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //   # New Field created: 50057 - "Enable TIN By Location"
    // HEI.11 FDD-CHG2022328 IBM POENAB02 07.07.2019 # External document No. duplication in journal
    //   #New field added: 50058 "Restrt Duplicate Extrnl Doc"
    // HEI.12 FDD-HT667 IBM SURYAS01 12-07-2019
    //   #New Field created:50059 - "Final Reporting Extracted"
    // HEI.13 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New functions:
    //     # CheckPostingRange
    //   # New code added in:
    //     # Unrealized VAT - OnValidate
    //     # Allow Posting From - OnValidate
    //     # Allow Posting To - OnValidate
    //   # New fields:
    //     # 10800 Posting Allowed From
    //     # 10801 Posting Allowed To
    //     # 10805 Local Currency
    //     # 10806 Currency Euro
    // HEI.15 FDD-HT626 IBM SURYAS01 16-12-2019 FDD_Bank Connection Setup_La Réunion
    //  #Created New Field:  "File Path"

    // HEI.16 FDD-HT1103 IBM SURYAS01  13-04-2020
    //   #Created new Field - "Apply Compensation"
    // HEI.17 FDD HT1136 CHG2055070 IBM Shankj03 16.06.2020
    //   # Created new field License Dimension Code
    // HEI.18 10.07.2020 (dd/mm)  FCE CHG CHG2060993 WIP Accrual Func.
    //   # Added fields 50063 and 50064 to define the percentage to calculate potential accrual value for PO's

    // HEI.19 16.07.2020 (dd/mm)  FCE CHG CHG2060993 WIP Accrual Func.
    //   # Added field 50065- to have the possibility to filter on Output Zones in the Production Orders
    // HEI.20 FDD-HT1330 IBM BULIMC01 08.02.2021#new field added: 50066 - "Maison des Vins Dim. Code"
    // HEI.21 HT1812 IBM BULIMC01 24.02.2021 #2 new fields added- 50067-"Payroll Dimension Code" and 50068 - "Salaries Dimension Code"
    // HEI.22 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # New Fields created: 50069 - Enable CAD
    // HEI.23 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //   # New Fields created: 50070 - Max CAD Difference Allowed
    // HEI.24 FDD-HB2373 - CHG2123486 IBM NANDIS01 23.09.2021 - Development - CMG mandatory on FA card
    //   # New field added - CMG Dimension Code(Field ID - 50071)
    // HEI.25 CHG2169924 IBM SISUM01 13/01/2023 #Add new field Id 50072 for G/L Automatic Application
    // HEI.26 CHG2200302 IBM POENAB02 18.05.2023 P&L by Nature in Heilite Base
    //   # New field added - 50073 P&L by Nature code
    // HEI.27 CHG2215009 IBM POENAB02 04.10.2023 HB3349 Enhancement of HB3349 To add column for L3 in main view
    //   # Code added in P&L by Nature code - OnValidate
    // HEI.28 CHG2225264 IBM SISUM01 12.01.2024 HB3640_BRD_GT_FX on Working capital payables & receivables (excluding derivatives)
    //   # Add new field
    // HEI.29 CHG2236692 IBM SISUM01 06.03.2024 HB3717_Development to perform revaluation for AR/AP
    //   # Add new field        
    // HEI.30 CHG2232991 IBM POENAB02 12.03.2024 HB3713_Limitation on the reverse action in table “create document shipping cost”
    //   # New field added - 50076 "Posted Document Shipping Limit"
    // version NAVW110.0,FINXL9.00.000.01,DITW110.00.08,BPMGAP016,HEI.30

    //Bc Upgrade YADAVM09 Drink it field commented - Posting Allowed From,Posting Allowed To,Local Currency,Currency Euro.

    // POENAB02 25.02.2026 gap/fit fixes for P&L by Nature

    fields
    {
        modify("Primary Key")
        {
            CaptionML = ENU = 'Primary Key', FRA = 'Clé primaire';
        }
        modify("Allow Posting From")
        {
            CaptionML = ENU = 'Allow Posting From', FRA = 'Début période validation';
            trigger OnBeforeValidate()
            var
                CompanyInfo: Record "Company Information";
            begin
                //BC Upgrade KAPOOV01-French Localization<<
                //HEI.13>>
                // CompanyInfo.GET;
                // IF CompanyInfo."Enable French Localization" THEN
                //     Rec.CheckPostingRange("Allow Posting From", FIELDCAPTION("Allow Posting From"));
                //HEI.13<<
                //BC Upgrade KAPOOV01-French Localization<<
            end;
        }
        modify("Allow Posting To")
        {
            CaptionML = ENU = 'Allow Posting To', FRA = 'Fin période validation';
            trigger OnBeforeValidate()
            var
                CompanyInfo: Record "Company Information";
            begin
                //BC Upgrade KAPOOV01-French Localization>>
                //HEI.13>>
                // CompanyInfo.GET;
                // if CompanyInfo."Enable French Localization" then
                //     CheckPostingRange("Allow Posting To", FIELDCAPTION("Allow Posting To"));
                //HEI.13<< 
                //BC Upgrade KAPOOV01-French Localization<<
            end;
        }
        modify("Register Time")
        {
            CaptionML = ENU = 'Register Time', FRA = 'Registre temps';
        }
        modify("Pmt. Disc. Excl. VAT")
        {
            CaptionML = ENU = 'Pmt. Disc. Excl. VAT', FRA = 'Escompte sans TVA';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify("Global Dimension 1 Filter")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Filter"(Field 42)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Filter', FRA = 'Filtre axe principal 1';
        }
        modify("Global Dimension 2 Filter")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Filter"(Field 43)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Filter', FRA = 'Filtre axe principal 2';
        }
        modify("Cust. Balances Due")
        {

            //Unsupported feature: Change CalcFormula on ""Cust. Balances Due"(Field 44)". Please convert manually.

            CaptionML = ENU = 'Cust. Balances Due', FRA = 'Soldes dus client';
        }
        modify("Vendor Balances Due")
        {

            //Unsupported feature: Change CalcFormula on ""Vendor Balances Due"(Field 45)". Please convert manually.

            CaptionML = ENU = 'Vendor Balances Due', FRA = 'Soldes dus fournisseur';
        }
        modify("Unrealized VAT")
        {
            CaptionML = ENU = 'Unrealized VAT', FRA = 'TVA sur encaissement';
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //BC Upgrade KAPOOV01-French Localization>>
                //HEI.13>>
                // CompanyInfo.GET;
                // IF CompanyInfo."Enable French Localization" THEN BEGIN
                //     PaymentClass.SETFILTER(
                //       PaymentClass."Unrealized VAT Reversal", '=%1', PaymentClass."Unrealized VAT Reversal"::Delayed);
                //     IF PaymentClass.FIND('-') THEN
                //         ERROR(
                //           Text10801, PaymentClass.TABLECAPTION, PaymentClass.Code,
                //           PaymentClass.FIELDCAPTION("Unrealized VAT Reversal"), PaymentClass."Unrealized VAT Reversal");
                // end;
                //HEI.13<<
                //BC Upgrade KAPOOV01-French Localization<<
            end;
        }
        modify("Adjust for Payment Disc.")
        {
            CaptionML = ENU = 'Adjust for Payment Disc.', FRA = 'Ajust. TVA si escompte';
        }
        modify("Mark Cr. Memos as Corrections")
        {
            CaptionML = ENU = 'Mark Cr. Memos as Corrections', FRA = 'Marquer avoirs comme corr.';
        }
        modify("Local Address Format")
        {
            CaptionML = ENU = 'Local Address Format', FRA = 'Format adresse local';
            OptionCaptionML = ENU = 'Post Code+City,City+Post Code,City+County+Post Code,Blank Line+Post Code+City', FRA = 'CP + Ville,Ville + CP,Ville + Région + CP,Ligne blanche + CP + Ville';
        }
        modify("Inv. Rounding Precision (LCY)")
        {
            CaptionML = ENU = 'Inv. Rounding Precision (LCY)', FRA = 'Précis. arrondi fact. DS';
        }
        modify("Inv. Rounding Type (LCY)")
        {
            CaptionML = ENU = 'Inv. Rounding Type (LCY)', FRA = 'Type arrondi facture DS';
            OptionCaptionML = ENU = 'Nearest,Up,Down', FRA = 'Au plus près,Par excès,Par défaut';
        }
        modify("Local Cont. Addr. Format")
        {

            //Unsupported feature: Change InitValue on ""Local Cont. Addr. Format"(Field 60)". Please convert manually.

            CaptionML = ENU = 'Local Cont. Addr. Format', FRA = 'Format adresse contact local';
            OptionCaptionML = ENU = 'First,After Company Name,Last', FRA = 'Début,Après nom société,Fin';
        }
        modify("Bank Account Nos.")
        {
            CaptionML = ENU = 'Bank Account Nos.', FRA = 'N° compte bancaire';
        }
        modify("Summarize G/L Entries")
        {
            CaptionML = ENU = 'Summarize G/L Entries', FRA = 'Une écriture cpta. (Sales Tax)';
        }
        modify("Amount Decimal Places")
        {
            CaptionML = ENU = 'Amount Decimal Places', FRA = 'Nombre décimales montant';
        }
        modify("Unit-Amount Decimal Places")
        {
            CaptionML = ENU = 'Unit-Amount Decimal Places', FRA = 'Nombre décimales montant unit.';
        }
        modify("Additional Reporting Currency")
        {
            CaptionML = ENU = 'Additional Reporting Currency', FRA = 'Devise report (DR)';
        }
        modify("VAT Tolerance %")
        {
            CaptionML = ENU = 'VAT Tolerance %', FRA = '% tolérance TVA';
        }
        modify("EMU Currency")
        {
            CaptionML = ENU = 'EMU Currency', FRA = 'Devise U.M.E.';
        }
        modify("LCY Code")
        {
            CaptionML = ENU = 'LCY Code', FRA = 'Code devise société (DS)';
        }
        modify("VAT Exchange Rate Adjustment")
        {
            CaptionML = ENU = 'VAT Exchange Rate Adjustment', FRA = 'Ajustement tx de change TVA';
            // OptionCaptionML = ENU = 'No Adjustment,Adjust Amount,Adjust Additional-Currency Amount', FRA = 'Aucun ajustement,Ajuster montant,Ajuster montant DR';
        }
        modify("Amount Rounding Precision")
        {
            CaptionML = ENU = 'Amount Rounding Precision', FRA = 'Précision arrondi montant';
        }
        modify("Unit-Amount Rounding Precision")
        {
            CaptionML = ENU = 'Unit-Amount Rounding Precision', FRA = 'Précis. arrondi montant unité';
        }
        modify("Appln. Rounding Precision")
        {
            CaptionML = ENU = 'Appln. Rounding Precision', FRA = 'Précision arrondi lettrage';
        }
        modify("Global Dimension 1 Code")
        {
            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {
            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("Shortcut Dimension 1 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Shortcut Dimension 3 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 3 Code', FRA = 'Code raccourci axe 3';
        }
        modify("Shortcut Dimension 4 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 4 Code', FRA = 'Code raccourci axe 4';
        }
        modify("Shortcut Dimension 5 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 5 Code', FRA = 'Code raccourci axe 5';
        }
        modify("Shortcut Dimension 6 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 6 Code', FRA = 'Code raccourci axe 6';
        }
        modify("Shortcut Dimension 7 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 7 Code', FRA = 'Code raccourci axe 7';
        }
        modify("Shortcut Dimension 8 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 8 Code', FRA = 'Code raccourci axe 8';
        }
        modify("Max. VAT Difference Allowed")
        {
            CaptionML = ENU = 'Max. VAT Difference Allowed', FRA = 'Différence TVA max. autorisée';
        }
        modify("VAT Rounding Type")
        {
            CaptionML = ENU = 'VAT Rounding Type', FRA = 'Type arrondi TVA';
            OptionCaptionML = ENU = 'Nearest,Up,Down', FRA = 'Au plus près,Par excès,Par défaut';
        }
        modify("Pmt. Disc. Tolerance Posting")
        {
            CaptionML = ENU = 'Pmt. Disc. Tolerance Posting', FRA = 'Validation écart d''escompte';
            OptionCaptionML = ENU = 'Payment Tolerance Accounts,Payment Discount Accounts', FRA = 'Comptes écart de règlement,Comptes escompte';
        }
        modify("Payment Discount Grace Period")
        {
            CaptionML = ENU = 'Payment Discount Grace Period', FRA = 'Période carence escompte';
        }
        modify("Payment Tolerance %")
        {
            CaptionML = ENU = 'Payment Tolerance %', FRA = '% écart de règlement';
        }
        modify("Max. Payment Tolerance Amount")
        {
            CaptionML = ENU = 'Max. Payment Tolerance Amount', FRA = 'Montant écart règlement max.';
        }
        //BC Upgrade KAPVOO01 Obselete field>>
        // modify("Adapt Main Menu to Permissions")  
        // {

        //     //Unsupported feature: Change InitValue on ""Adapt Main Menu to Permissions"(Field 96)". Please convert manually.

        //     CaptionML = ENU = 'Adapt Main Menu to Permissions', FRA = 'Adapter menu aux autorisations';
        // }
        //BC Upgrade KAPVOO01 Obselete field>>
        modify("Allow G/L Acc. Deletion Before")
        {
            CaptionML = ENU = 'Allow G/L Acc. Deletion Before', FRA = 'Autoriser suppr. cpte gén. av.';
        }
        modify("Check G/L Account Usage")
        {
            CaptionML = ENU = 'Check G/L Account Usage', FRA = 'Vérifier activité cpte général';
        }
        modify("Payment Tolerance Posting")
        {
            CaptionML = ENU = 'Payment Tolerance Posting', FRA = 'Validation écart de règlement';
            OptionCaptionML = ENU = 'Payment Tolerance Accounts,Payment Discount Accounts', FRA = 'Comptes écart de règlement,Comptes escompte';
        }
        modify("Pmt. Disc. Tolerance Warning")
        {
            CaptionML = ENU = 'Pmt. Disc. Tolerance Warning', FRA = 'Alerte écart d''escompte';
        }
        modify("Payment Tolerance Warning")
        {
            CaptionML = ENU = 'Payment Tolerance Warning', FRA = 'Alerte écart de règlement';
        }
        modify("Last IC Transaction No.")
        {
            CaptionML = ENU = 'Last IC Transaction No.', FRA = 'Dernier n° transaction IC';
        }
        modify("Bill-to/Sell-to VAT Calc.")
        {
            CaptionML = ENU = 'Bill-to/Sell-to VAT Calc.', FRA = 'Calcul TVA client facturé/donneur d''ordre';
            // OptionCaptionML = ENU = 'Bill-to/Pay-to No.,Sell-to/Buy-from No.', FRA = 'N° client facturé/personne à payer,N° donneur d''ordre/fournisseur';
        }
        //BC Upgrade KAPVOO01 Field Removed>>
        // modify("Acc. Sched. for Balance Sheet")
        // {
        //     CaptionML = ENU = 'Acc. Sched. for Balance Sheet', FRA = 'Tableau d''analyse pour le bilan';
        // }
        // modify("Acc. Sched. for Income Stmt.")
        // {
        //     CaptionML = ENU = 'Acc. Sched. for Income Stmt.', FRA = 'Tableau d''analyse pour la déclaration de revenus';
        // }
        // modify("Acc. Sched. for Cash Flow Stmt")
        // {
        //     CaptionML = ENU = 'Acc. Sched. for Cash Flow Stmt', FRA = 'Tableau d''analyse pour la déclaration de trésorerie';
        // }
        // modify("Acc. Sched. for Retained Earn.")
        // {
        //     CaptionML = ENU = 'Acc. Sched. for Retained Earn.', FRA = 'Tableau d''analyse pour la déclaration de réserves';
        // }
        //BC Upgrade KAPVOO01 Field Removed<<
        modify("Print VAT specification in LCY")
        {
            CaptionML = ENU = 'Print VAT specification in LCY', FRA = 'Imprimer le détail TVA en devise société';
        }
        modify("Prepayment Unrealized VAT")
        {
            CaptionML = ENU = 'Prepayment Unrealized VAT', FRA = 'TVA sur encaissement acompte';
        }
        // modify("Use Legacy G/L Entry Locking")
        // {
        //     CaptionML = ENU = 'Use Legacy G/L Entry Locking', FRA = 'Utiliser le verrouillage de l''écriture comptable héritée';
        // }//BC Upgrade KAPVOO01 Field Removed

        modify("Payroll Trans. Import Format")
        {

            //Unsupported feature: Change TableRelation on ""Payroll Trans. Import Format"(Field 160)". Please convert manually.

            CaptionML = ENU = 'Payroll Trans. Import Format', FRA = 'Format importation trans. Paie';
        }
        // modify("VAT Reg. No. Validation URL")
        // {
        //     CaptionML = ENU = 'VAT Reg. No. Validation URL', FRA = 'URL de validation de n° id. intracomm.';
        // } //BC Upgrade KAPVOO01 Obselete field.
        modify("Local Currency Symbol")
        {
            CaptionML = ENU = 'Local Currency Symbol', FRA = 'Symbole devise société';
        }

        //Unsupported feature: CodeInsertion on ""Allow Posting From"(Field 2)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //HEI.13>>
        CompanyInfo.GET;
        if CompanyInfo."Enable French Localization" then
          CheckPostingRange("Allow Posting From",FIELDCAPTION("Allow Posting From"));
        //HEI.13<<
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Allow Posting To"(Field 3)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //HEI.13>>
        CompanyInfo.GET;
        if CompanyInfo."Enable French Localization" then
          CheckPostingRange("Allow Posting To",FIELDCAPTION("Allow Posting To"));
        //HEI.13<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Pmt. Disc. Excl. VAT"(Field 28).OnValidate". Please convert manually.

        //trigger  Disc();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Pmt. Disc. Excl. VAT" THEN
          TESTFIELD("Adjust for Payment Disc.",FALSE)
        else
          TESTFIELD("VAT Tolerance %",0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Pmt. Disc. Excl. VAT" then
          TESTFIELD("Adjust for Payment Disc.",false)
        else
          TESTFIELD("VAT Tolerance %",0);
        */
        //end;


        //Unsupported feature: CodeModification on ""Unrealized VAT"(Field 48).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT "Unrealized VAT" THEN BEGIN
          VATPostingSetup.SETFILTER(
            "Unrealized VAT Type",'>=%1',VATPostingSetup."Unrealized VAT Type"::Percentage);
          IF VATPostingSetup.FINDFIRST THEN
            ERROR(
              Text000,VATPostingSetup.TABLECAPTION,
              VATPostingSetup."VAT Bus. Posting Group",VATPostingSetup."VAT Prod. Posting Group",
              VATPostingSetup.FIELDCAPTION("Unrealized VAT Type"),VATPostingSetup."Unrealized VAT Type");
          TaxJurisdiction.SETFILTER(
            "Unrealized VAT Type",'>=%1',TaxJurisdiction."Unrealized VAT Type"::Percentage);
          IF TaxJurisdiction.FINDFIRST THEN
            ERROR(
              Text001,TaxJurisdiction.TABLECAPTION,
              TaxJurisdiction.Code,TaxJurisdiction.FIELDCAPTION("Unrealized VAT Type"),
              TaxJurisdiction."Unrealized VAT Type");
        end;
        IF "Unrealized VAT" THEN
          "Prepayment Unrealized VAT" := TRUE
        else
          "Prepayment Unrealized VAT" := FALSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not "Unrealized VAT" then begin
          VATPostingSetup.SETFILTER(
            "Unrealized VAT Type",'>=%1',VATPostingSetup."Unrealized VAT Type"::Percentage);
          if VATPostingSetup.FINDFIRST then
        #5..10
          if TaxJurisdiction.FINDFIRST then
        #12..15
        //HEI.13>>
        CompanyInfo.GET;
        if CompanyInfo."Enable French Localization" then
          begin
            PaymentClass.SETFILTER(
              PaymentClass."Unrealized VAT Reversal",'=%1',PaymentClass."Unrealized VAT Reversal"::Delayed);
            if PaymentClass.FIND('-') then
              ERROR(
                Text10801,PaymentClass.TABLECAPTION,PaymentClass.Code,
                PaymentClass.FIELDCAPTION("Unrealized VAT Reversal"),PaymentClass."Unrealized VAT Reversal");
          end;
        //HEI.13<<
        end;
        if "Unrealized VAT" then
          "Prepayment Unrealized VAT" := true
        else
          "Prepayment Unrealized VAT" := false;
        */
        //end;


        //Unsupported feature: CodeModification on ""Adjust for Payment Disc."(Field 49).OnValidate". Please convert manually.

        //trigger "(Field 49)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Adjust for Payment Disc." THEN BEGIN
          TESTFIELD("Pmt. Disc. Excl. VAT",FALSE);
          TESTFIELD("VAT Tolerance %",0);
        end else BEGIN
          VATPostingSetup.SETRANGE("Adjust for Payment Discount",TRUE);
          IF VATPostingSetup.FINDFIRST THEN
            ERROR(
              Text002,VATPostingSetup.TABLECAPTION,
              VATPostingSetup."VAT Bus. Posting Group",VATPostingSetup."VAT Prod. Posting Group",
              VATPostingSetup.FIELDCAPTION("Adjust for Payment Discount"));
          TaxJurisdiction.SETRANGE("Adjust for Payment Discount",TRUE);
          IF TaxJurisdiction.FINDFIRST THEN
            ERROR(
              Text003,TaxJurisdiction.TABLECAPTION,
              TaxJurisdiction.Code,TaxJurisdiction.FIELDCAPTION("Adjust for Payment Discount"));
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Adjust for Payment Disc." then begin
          TESTFIELD("Pmt. Disc. Excl. VAT",false);
          TESTFIELD("VAT Tolerance %",0);
        end else begin
          VATPostingSetup.SETRANGE("Adjust for Payment Discount",true);
          if VATPostingSetup.FINDFIRST then
        #7..10
          TaxJurisdiction.SETRANGE("Adjust for Payment Discount",true);
          if TaxJurisdiction.FINDFIRST then
        #13..15
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Inv. Rounding Precision (LCY)"(Field 58).OnValidate". Please convert manually.

        //trigger  Rounding Precision (LCY)"(Field 58)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Amount Rounding Precision" <> 0 THEN
          IF "Inv. Rounding Precision (LCY)" <> ROUND("Inv. Rounding Precision (LCY)","Amount Rounding Precision") THEN
            ERROR(
              Text004,
              FIELDCAPTION("Inv. Rounding Precision (LCY)"),"Amount Rounding Precision");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Amount Rounding Precision" <> 0 then
          if "Inv. Rounding Precision (LCY)" <> ROUND("Inv. Rounding Precision (LCY)","Amount Rounding Precision") then
        #3..5
        */
        //end;


        //Unsupported feature: CodeModification on ""Additional Reporting Currency"(Field 68).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Additional Reporting Currency" <> xRec."Additional Reporting Currency") AND
           ("Additional Reporting Currency" <> '')
        THEN BEGIN
          AdjAddReportingCurr.SetAddCurr("Additional Reporting Currency");
          AdjAddReportingCurr.RUNMODAL;
          IF NOT AdjAddReportingCurr.IsExecuted THEN
            "Additional Reporting Currency" := xRec."Additional Reporting Currency";
        end;
        IF ("Additional Reporting Currency" <> xRec."Additional Reporting Currency") AND
           AdjAddReportingCurr.IsExecuted
        THEN
          DeleteIntrastatJnl;
        IF ("Additional Reporting Currency" <> xRec."Additional Reporting Currency") AND
           ("Additional Reporting Currency" <> '') AND
           AdjAddReportingCurr.IsExecuted
        THEN
          DeleteAnalysisView;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Additional Reporting Currency" <> xRec."Additional Reporting Currency") and
           ("Additional Reporting Currency" <> '')
        then begin
          AdjAddReportingCurr.SetAddCurr("Additional Reporting Currency");
          AdjAddReportingCurr.RUNMODAL;
          if not AdjAddReportingCurr.IsExecuted then
            "Additional Reporting Currency" := xRec."Additional Reporting Currency";
        end;
        if ("Additional Reporting Currency" <> xRec."Additional Reporting Currency") and
           AdjAddReportingCurr.IsExecuted
        then
          DeleteIntrastatJnl;
        if ("Additional Reporting Currency" <> xRec."Additional Reporting Currency") and
           ("Additional Reporting Currency" <> '') and
           AdjAddReportingCurr.IsExecuted
        then
          DeleteAnalysisView;
        */
        //end;


        //Unsupported feature: CodeModification on ""VAT Tolerance %"(Field 69).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "VAT Tolerance %" <> 0 THEN BEGIN
          TESTFIELD("Adjust for Payment Disc.",FALSE);
          TESTFIELD("Pmt. Disc. Excl. VAT",TRUE);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "VAT Tolerance %" <> 0 then begin
          TESTFIELD("Adjust for Payment Disc.",false);
          TESTFIELD("Pmt. Disc. Excl. VAT",true);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""LCY Code"(Field 71).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Local Currency Symbol" = '' THEN
          "Local Currency Symbol" := Currency.ResolveCurrencySymbol("LCY Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Local Currency Symbol" = '' then
          "Local Currency Symbol" := Currency.ResolveCurrencySymbol("LCY Code");
        */
        //end;


        //Unsupported feature: CodeModification on ""Amount Rounding Precision"(Field 73).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Amount Rounding Precision" <> 0 THEN
          "Inv. Rounding Precision (LCY)" := ROUND("Inv. Rounding Precision (LCY)","Amount Rounding Precision");
        RoundingErrorCheck(FIELDCAPTION("Amount Rounding Precision"));
        IF HideDialog THEN
          MESSAGE(Text021);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Amount Rounding Precision" <> 0 then
          "Inv. Rounding Precision (LCY)" := ROUND("Inv. Rounding Precision (LCY)","Amount Rounding Precision");
        RoundingErrorCheck(FIELDCAPTION("Amount Rounding Precision"));
        if HideDialog then
          MESSAGE(Text021);
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit-Amount Rounding Precision"(Field 74).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF HideDialog THEN
          MESSAGE(Text022);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if HideDialog then
          MESSAGE(Text022);
        */
        //end;


        //Unsupported feature: CodeModification on ""Max. VAT Difference Allowed"(Field 89).OnValidate". Please convert manually.

        //trigger  VAT Difference Allowed"(Field 89)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Max. VAT Difference Allowed" <> ROUND("Max. VAT Difference Allowed") THEN
          ERROR(
            Text004,
            FIELDCAPTION("Max. VAT Difference Allowed"),"Amount Rounding Precision");

        "Max. VAT Difference Allowed" := ABS("Max. VAT Difference Allowed");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Max. VAT Difference Allowed" <> ROUND("Max. VAT Difference Allowed") then
        #2..6
        */
        //end;


        //Unsupported feature: CodeModification on ""Prepayment Unrealized VAT"(Field 151).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Unrealized VAT" AND xRec."Prepayment Unrealized VAT" THEN
          ERROR(DependentFieldActivatedErr,FIELDCAPTION("Prepayment Unrealized VAT"),FIELDCAPTION("Unrealized VAT"));

        IF NOT "Prepayment Unrealized VAT" THEN BEGIN
          VATPostingSetup.SETFILTER(
            "Unrealized VAT Type",'>=%1',VATPostingSetup."Unrealized VAT Type"::Percentage);
          IF VATPostingSetup.FINDFIRST THEN
            ERROR(
              Text000,VATPostingSetup.TABLECAPTION,
              VATPostingSetup."VAT Bus. Posting Group",VATPostingSetup."VAT Prod. Posting Group",
              VATPostingSetup.FIELDCAPTION("Unrealized VAT Type"),VATPostingSetup."Unrealized VAT Type");
          TaxJurisdiction.SETFILTER(
            "Unrealized VAT Type",'>=%1',TaxJurisdiction."Unrealized VAT Type"::Percentage);
          IF TaxJurisdiction.FINDFIRST THEN
            ERROR(
              Text001,TaxJurisdiction.TABLECAPTION,
              TaxJurisdiction.Code,TaxJurisdiction.FIELDCAPTION("Unrealized VAT Type"),
              TaxJurisdiction."Unrealized VAT Type");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Unrealized VAT" and xRec."Prepayment Unrealized VAT" then
          ERROR(DependentFieldActivatedErr,FIELDCAPTION("Prepayment Unrealized VAT"),FIELDCAPTION("Unrealized VAT"));

        if not "Prepayment Unrealized VAT" then begin
          VATPostingSetup.SETFILTER(
            "Unrealized VAT Type",'>=%1',VATPostingSetup."Unrealized VAT Type"::Percentage);
          if VATPostingSetup.FINDFIRST then
        #8..13
          if TaxJurisdiction.FINDFIRST then
        #15..18
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Use Legacy G/L Entry Locking"(Field 152).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT "Use Legacy G/L Entry Locking" THEN BEGIN
          IF InventorySetup.GET THEN
            IF InventorySetup."Automatic Cost Posting" THEN
              ERROR(Text025,
                FIELDCAPTION("Use Legacy G/L Entry Locking"),
                "Use Legacy G/L Entry Locking",
                InventorySetup.FIELDCAPTION("Automatic Cost Posting"),
                InventorySetup.TABLECAPTION,
                InventorySetup."Automatic Cost Posting");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not "Use Legacy G/L Entry Locking" then begin
          if InventorySetup.GET then
            if InventorySetup."Automatic Cost Posting" then
        #4..9
        end;
        */
        //end;

        /* //Bc Upgrade YADAVM09 Drink it field commented>>
       field(10800; "Posting Allowed From"; Date)
       {
           CalcFormula = Min("Accounting Period"."Starting Date" where("Fiscally Closed" = FILTER(false)));
           CaptionML = ENU = 'Posting Allowed From',
                       FRA = 'Début validation autorisée';
           Description = 'HEI.13';
           Editable = false;
           FieldClass = FlowField;
       }
       field(10801; "Posting Allowed To"; Date)
       {
           CalcFormula = Max("Accounting Period"."Starting Date" where("New Fiscal Year" = FILTER(true),
                                                                        "Fiscally Closed" = FILTER(false)));
           CaptionML = ENU = 'Posting Allowed To',
                       FRA = 'Fin validation autorisée';
           Description = 'HEI.13';
           Editable = false;
           FieldClass = FlowField;
       }
       field(10805; "Local Currency"; Option)
       {
           CaptionML = ENU = 'Local Currency',
                       FRA = 'Devise société';
           Description = 'HEI.13';
           OptionCaptionML = ENU = 'Euro,Other',
                             FRA = 'Euro,Autre';
           OptionMembers = Euro,Other;

           trigger OnValidate();
           begin
               if "Local Currency" = "Local Currency"::Euro then
                   "Currency Euro" := '';
           end;
       }
       field(10806; "Currency Euro"; Code[10])
       {
           CaptionML = ENU = 'Currency Euro',
                       FRA = 'Devise Euro';
           Description = 'HEI.13';
           TableRelation = Currency;

           trigger OnValidate();
           begin
               if ("Local Currency" = "Local Currency"::Euro) and ("Currency Euro" <> '') then
                   ERROR(
                     Text10802,
                     FIELDCAPTION("Currency Euro"),
                     FIELDCAPTION("Local Currency"),
                     "Local Currency");
           end;
       }
       */ //Bc Upgrade YADAVM09 Drink it field commented<<
        field(50000; "Capex Dimension Code FND"; Code[20])
        {
            caption = 'Capex Dimension Code';
            Description = 'HEI.01 BPMGAP016';
            TableRelation = Dimension;
        }
        field(50001; "Capex Reference Budget FND"; Code[20])
        {
            caption = 'Capex Reference Budget';
            Description = 'HEI.01 BPMGAP016';
            TableRelation = "G/L Budget Name";
        }
        field(50002; "Capex Acc. Schedule Name FND"; Code[10])
        {
            caption = 'Capex Acc. Schedule Name';
            Description = 'HEI.01 BPMGAP016';
            TableRelation = "Acc. Schedule Name";
        }
        field(50003; "Mass Upload Dimension 9 FND"; Code[20])
        {
            Caption = 'Mass Upload Dimension 9';
            Description = 'HEI.02 RTRGAP043';
            TableRelation = Dimension;
        }
        field(50004; "Mass Upload Dimension 10 FND"; Code[20])
        {
            Caption = 'Mass Upload Dimension 10';
            Description = 'HEI.02 RTRGAP043';
            TableRelation = Dimension;
        }
        field(50005; "Mass Upload Dimension 11 FND"; Code[20])
        {
            Caption = 'Mass Upload Dimension 11';
            Description = 'HEI.02 RTRGAP043';
            TableRelation = Dimension;
        }
        field(50006; "Mass Upload Dimension 12 FND"; Code[20])
        {
            Caption = 'Mass Upload Dimension 12';
            Description = 'HEI.02 RTRGAP043';
            TableRelation = Dimension;
        }
        field(50007; "Mass Upload Dimension 13 FND"; Code[20])
        {
            Caption = 'Mass Upload Dimension 13';
            Description = 'HEI.02 RTRGAP043';
            TableRelation = Dimension;
        }
        field(50008; "Mass Upload Dimension 14 FND"; Code[20])
        {
            Caption = 'Mass Upload Dimension 14';
            Description = 'HEI.02 RTRGAP043';
            TableRelation = Dimension;
        }
        field(50009; "Mass Upload Dimension 15 FND"; Code[20])
        {
            Caption = 'Mass Upload Dimension 15';
            Description = 'HEI.02 RTRGAP043';
            TableRelation = Dimension;
        }
        field(50010; "Mass Upload Dimension 16 FND"; Code[20])
        {
            Caption = 'Mass Upload Dimension 16';
            Description = 'HEI.02 RTRGAP043';
            TableRelation = Dimension;
        }
        field(50011; "Mass Upload Dimension 17 FND"; Code[20])
        {
            Caption = 'Mass Upload Dimension 17';
            Description = 'HEI.02 RTRGAP043';
            TableRelation = Dimension;
        }
        field(50012; "Mass Upload Dimension 18 FND"; Code[20])
        {
            Caption = 'Mass Upload Dimension 18';
            Description = 'HEI.02 RTRGAP043';
            TableRelation = Dimension;
        }
        field(50013; "Mass Upload Dimension 19 FND"; Code[20])
        {
            Caption = 'Mass Upload Dimension 19';
            Description = 'HEI.02 RTRGAP043';
            TableRelation = Dimension;
        }
        field(50014; "Mass Upload Dimension 20 FND"; Code[20])
        {
            Caption = 'Mass Upload Dimension 20';
            Description = 'HEI.02 RTRGAP043';
            TableRelation = Dimension;
        }
        field(50015; "Mass Upload Dimension 21 FND"; Code[20])
        {
            Caption = 'Mass Upload Dimension 21';
            Description = 'HEI.02 RTRGAP043';
            TableRelation = Dimension;
        }
        field(50016; "Mass Upload Dimension 22 FND"; Code[20])
        {
            Caption = 'Mass Upload Dimension 22';
            Description = 'HEI.02 RTRGAP043';
            TableRelation = Dimension;
        }
        field(50017; "Mass Upload Dimension 23 FND"; Code[20])
        {
            Caption = 'Mass Upload Dimension 23';
            Description = 'HEI.02 RTRGAP043';
            TableRelation = Dimension;
        }
        field(50018; "Mass Upload Dimension 24 FND"; Code[20])
        {
            Caption = 'Mass Upload Dimension 24';
            Description = 'HEI.02 RTRGAP043';
            TableRelation = Dimension;
        }
        field(50019; "Mass Upload Dimension 25 FND"; Code[20])
        {
            Caption = 'Mass Upload Dimension 25';
            Description = 'HEI.02 RTRGAP043';
            TableRelation = Dimension;
        }
        field(50020; "Mass Upload Dimension 26 FND"; Code[20])
        {
            Caption = 'Mass Upload Dimension 26';
            Description = 'HEI.02 RTRGAP043';
            TableRelation = Dimension;
        }
        field(50021; "Mass Upload Dimension 27 FND"; Code[20])
        {
            Caption = 'Mass Upload Dimension 27';
            Description = 'HEI.02 RTRGAP043';
            TableRelation = Dimension;
        }
        field(50022; "Mass Upload Dimension 28 FND"; Code[20])
        {
            Caption = 'Mass Upload Dimension 28';
            Description = 'HEI.02 RTRGAP043';
            TableRelation = Dimension;
        }
        field(50023; "Mass Upload Dimension 29 FND"; Code[20])
        {
            Caption = 'Mass Upload Dimension 29';
            Description = 'HEI.02 RTRGAP043';
            TableRelation = Dimension;
        }
        field(50024; "Mass Upload Dimension 30 FND"; Code[20])
        {
            Caption = 'Mass Upload Dimension 30';
            Description = 'HEI.02 RTRGAP043';
            TableRelation = Dimension;
        }
        field(50025; "OPCO Dimension Code FND"; Code[20])
        {
            CaptionML = ENU = 'OPCO Dimension Code',
                        FRA = 'OPCO Dimension Code';
            Description = 'HEI.03';
            TableRelation = Dimension;

            trigger OnValidate();
            begin
                //HEI.03>>
                if Dim.CheckIfDimUsed("Shortcut Dimension 8 Code", 8, '', '', 0) then
                    ERROR(Text023, Dim.GetCheckDimErr());
                MODIFY();
                //HEI.03<<
            end;
        }
        field(50026; "Business Type Dim Code FND"; Code[20])
        {
            CaptionML = ENU = 'Business Type Dimension Code',
                        FRA = 'Business Type Dimension Code';
            Description = 'HEI.06';
            TableRelation = Dimension;

            trigger OnValidate();
            begin
                //>>HEI:EDD072:1:1
                if Dim.CheckIfDimUsed("Shortcut Dimension 8 Code", 8, '', '', 0) then
                    ERROR(Text023, Dim.GetCheckDimErr());
                MODIFY();
                //<<HEI:EDD072:1:1
            end;
        }
        field(50027; "Brand Dimension Code FND"; Code[20])
        {
            CaptionML = ENU = 'Brand Dimension Code',
                        FRA = 'Brand Dimension Code';
            Description = 'HEI.06';
            TableRelation = Dimension;

            trigger OnValidate();
            begin
                //>>HEI:EDD072:1:1
                if Dim.CheckIfDimUsed("Shortcut Dimension 8 Code", 8, '', '', 0) then
                    ERROR(Text023, Dim.GetCheckDimErr());
                MODIFY();
                //<<HEI:EDD072:1:1
            end;
        }
        field(50028; "WHT Minimum Invoice Amount FND"; Decimal)
        {
            Caption = 'WHT Minimum Invoice Amount';
            Description = 'HEI.04';
        }
        field(50029; "Manual Sales WHT Calc. FND"; Boolean)
        {
            Caption = 'Manual Sales WHT Calc.';
            Description = 'HEI.04';
        }
        field(50030; "Enable WHT FND"; Boolean)
        {
            Caption = 'Enable WHT';
            Description = 'HEI.04';
        }
        field(50031; "Round Amount for WHT Calc FND"; Boolean)
        {
            Caption = 'Round Amount for WHT Calc';
            Description = 'HEI.04';
        }
        field(50032; "Min. WHT CalconlyonInv.Amt FND"; Boolean)
        {
            Caption = 'Min. WHT Calc only on Inv. Amt';
            Description = 'HEI.04';
        }
        field(50033; "Cost Center Dimension Code FND"; Code[20])
        {
            CaptionML = ENU = 'Cost Center Dimension Code',
                        FRA = 'Cost Center Dimension Code';
            Description = 'HEI.05';
            TableRelation = Dimension;

            trigger OnValidate();
            Var
                Dim: Record Dimension;
            begin
                //HEI.03>>
                if Dim.CheckIfDimUsed("Shortcut Dimension 8 Code", 8, '', '', 0) then
                    ERROR(Text023, Dim.GetCheckDimErr());
                MODIFY();
                //HEI.03<<
            end;
        }
        field(50034; "Energy Dim. Code FND"; Code[20])
        {
            Caption = 'Energy Dim. Code';
            Description = 'HEI.07';
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Cost Center Dimension Code FND"));
        }
        field(50035; "Water Consump Dim. Code FND"; Code[20])
        {
            Caption = 'Water Consumption Dim. Code';
            Description = 'HEI.07';
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Cost Center Dimension Code FND"));
        }
        field(50036; "Waste Water Dim. Code FND"; Code[20])
        {
            Caption = 'Waste Water Dim. Code';
            Description = 'HEI.07';
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Cost Center Dimension Code FND"));
        }
        field(50037; "Maintenance Dim. Code FND"; Code[20])
        {
            Caption = 'Maintenance Dim. Code';
            Description = 'HEI.07';
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Cost Center Dimension Code FND"));
        }
        field(50038; "Cadency Temporary Path FND"; Text[250])
        {
            caption = 'Cadency Temporary Path';
            Description = 'HEI.08';
        }
        field(50039; "SKU Dimension Code FND"; Code[20])
        {
            caption = 'SKU Dimension Code';
            TableRelation = Dimension;
        }
        field(50040; "WIP Account FND"; Code[10])
        {
            caption = 'WIP Account';
            TableRelation = "G/L Account";
        }
        field(50041; "Bal. Wip Account FND"; Code[10])
        {
            caption = 'Bal. Wip Account';
            TableRelation = "G/L Account";
        }
        field(50042; "Line ext Dimension Code FND"; Code[20])
        {
            caption = 'Line ext Dimension Code';
            TableRelation = Dimension;
        }
        field(50043; "Customer Dimension Code FND"; Code[20])
        {
            caption = 'Customer Dimension Code';
            TableRelation = Dimension;
        }
        field(50044; "Gl Budget Standard Cost FND"; Code[10])
        {
            Caption = 'Gl Budget Standard Cost';
            Description = 'HEI.09';
            TableRelation = "G/L Budget Name".Name;
        }
        field(50054; "Primary Pack Type Dim FND"; Code[20])
        {
            caption = 'Primary Pack Type Dim';
            TableRelation = Dimension;
        }
        field(50055; "Area Dim FND"; Code[20])
        {
            caption = 'Area Dim';
            TableRelation = Dimension;
        }
        field(50056; "Extended Address Formating FND"; Boolean)
        {
            caption = 'Extended Address Formating';
        }
        field(50057; "Enable TIN By Location FND"; Boolean)
        {
            Caption = 'Enable TIN By Location';
            Description = 'HEI.10';
        }
        field(50058; "Restrt Dupli Extrnl Doc FND"; Boolean)
        {
            Caption = 'Restrt Duplicate Extrnl Doc';
            Description = 'HEI.11';
        }
        field(50059; "Final Reporting Extracted FND"; Boolean)
        {
            caption = 'Final Reporting Extracted';
            Description = 'HEI.12';
        }
        field(50061; "Apply Compensation FND"; Boolean)
        {
            caption = 'Apply Compensation';
            Description = 'HEI.16';
        }
        field(50062; "License Dimension Code FND"; Code[20])
        {
            CaptionML = ENU = 'License Dimension Code',
                        FRA = 'License Dimension Code';
            Description = 'HEI.17';
            TableRelation = Dimension;

            trigger OnValidate();
            var
                Dim: Record Dimension;
            begin
                //>>HEI:EDD072:1:1
                if Dim.CheckIfDimUsed("Shortcut Dimension 8 Code", 8, '', '', 0) then
                    ERROR(Text023, Dim.GetCheckDimErr());
                MODIFY();
                //<<HEI:EDD072:1:1
            end;
        }
        field(50063; "WIP Accrual. Mat. Perc. FND"; Decimal)
        {
            Caption = 'WIP Accrual. Mat. Perc.';
            Description = 'CHG2060993 HEI.18';
            MaxValue = 100;
            MinValue = 0;
        }
        field(50064; "WIP Accrual. Cap. Perc. FND"; Decimal)
        {
            Caption = 'WIP Accrual. Cap. Perc.';
            Description = 'CHG2060993 HEI.18';
            MaxValue = 100;
            MinValue = 0;
        }
        field(50065; "WIP Output Zone Filtering FND"; Code[100])
        {
            caption = 'WIP Output Zone Filtering';
            Description = 'CHG2060993 HEI.19';

            trigger OnLookup();
            var
                TmpZones: Record Zone temporary;
                Zones: Record Zone;
            begin
                // hei.19>>
                Zones.SETRANGE(Zones."Use As In-Transit FND", FALSE);
                IF Zones.findset() THEN
                    REPEAT
                        TmpZones := Zones;
                        TmpZones."Location Code" := '';
                        IF TmpZones.INSERT() THEN;
                    UNTIL Zones.NEXT() = 0;

                IF PAGE.RUNMODAL(PAGE::Zones, TmpZones) = ACTION::LookupOK THEN BEGIN
                    "WIP Output Zone Filtering FND" := "WIP Output Zone Filtering FND" + TmpZones.Code

                end;
                //hei.19<<
            end;
        }
        field(50066; "Maison des Vins Dim. Code FND"; Code[20])
        {
            Caption = 'Maison des Vins Dim. Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.20';
            TableRelation = Dimension;

            trigger OnValidate();
            begin
                //HEI.20<<
                UpdateDimValueGlobalDimNo(xRec."Maison des Vins Dim. Code FND", "Maison des Vins Dim. Code FND", 15);
                //HEI.20<<
            end;
        }
        field(50067; "Payroll Dimension Code FND"; Code[20])
        {
            Caption = 'Payroll Dimension Code';
            Description = 'HEI.21';
            TableRelation = Dimension;

            trigger OnValidate();
            begin
                //HEI.21<<
                UpdateDimValueGlobalDimNo(xRec."Payroll Dimension Code FND", "Payroll Dimension Code FND", 16);
                //HEI.21<<
            end;
        }
        field(50068; "Salaries Dimension Code FND"; Code[20])
        {
            Caption = 'Salaries Dimension Code';
            Description = 'HEI.21';
            TableRelation = Dimension;

            trigger OnValidate();
            begin
                //HEI.21<<
                UpdateDimValueGlobalDimNo(xRec."Salaries Dimension Code FND", "Salaries Dimension Code FND", 17);
                //HEI.21<<
            end;
        }
        field(50069; "Enable CAD FND"; Boolean)
        {
            Caption = 'Enable CAD';
            DataClassification = ToBeClassified;
            Description = 'HEI.22';
        }
        field(50070; "Max CAD Difference Allowed FND"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Max CAD Difference Allowed';
            DataClassification = ToBeClassified;
            Description = 'HEI.23';

            trigger OnValidate();
            begin
                //HEI.22>>
                "Max CAD Difference Allowed FND" := ABS("Max CAD Difference Allowed FND");
                //HEI.22<<
            end;
        }
        field(50071; "CMG Dimension Code FND"; Code[20])
        {
            CaptionML = ENU = 'CMG Dimension Code',
                        FRA = 'License Dimension Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.24';
            TableRelation = Dimension;
        }
        field(50072; "G/L Application No. Series FND"; Code[10])
        {
            Caption = 'G/L Application No. Series';
            DataClassification = ToBeClassified;
            Description = 'HEI.25';
            TableRelation = "No. Series";
        }
        field(50073; "P&L by Nature code FND"; Code[10])
        {
            Caption = 'P&L by Nature code';
            DataClassification = ToBeClassified;
            Description = 'HEI.26';
            //BC Upgrade POENAB02, 25.02.2026 >>
            //TableRelation = "Acc. Schedule Name".Name;
            TableRelation = "Financial Report".Name;
            //BC Upgrade POENAB02, 25.02.2026 <<

            trigger OnValidate();
            var
                AccScheduleLine: Record "Acc. Schedule Line";
            begin
                //HEI.26>>
                if (Rec."P&L by Nature code FND" <> xRec."P&L by Nature code FND") then
                  //HEI.27>>
                  //AccScheduleLine.MODIFYALL("CIL account",'');
                  begin
                    AccScheduleLine.MODIFYALL("CIL account FND", '');
                    AccScheduleLine.MODIFYALL("L3 Account FND", '');
                end;
                //HEI.27<<
                //HEI.26<<
            end;
        }
        field(50074; "Enable GT FX FND"; Boolean)
        {
            Caption = 'Enable GT FX';
            DataClassification = ToBeClassified;
            Description = 'HEI.28';
        }
        field(50075; "Reversal Reev. Act Date FND"; Date)
        {
            Caption = 'Reversal Reev. Activate Date';
            DataClassification = ToBeClassified;
            Description = 'HEI.29';
        }
        field(50076; "Posted Doc Shipping Limit FND"; Integer)
        {
            Caption = 'Posted Document Shipping Limit';
            DataClassification = ToBeClassified;
            Description = 'HEI.30';
            MaxValue = 50;
            MinValue = 0;
        }
        field(55001; "File path FND"; Text[250])
        {
            Caption = 'File path';
            Description = 'HEI.15';
        }
        //BC Upgrade KAPOOV01 drink-it>>
        // field(2013716;"Tax Amount Decimal Places";Text[5])
        // {
        //     CaptionML = ENU='Amount Decimal Places (Tax)',
        //                 FRA='Nombre décimales montant (Taxe)';
        //     Description = 'DITW15.00.00.24';
        //     InitValue = '2:2';

        //     trigger OnValidate();
        //     begin
        //         CheckDecimalPlacesFormat("Tax Amount Decimal Places");
        //     end;
        // }
        // field(2013717;"Tax Unit-Amount Decimal Places";Text[5])
        // {
        //     CaptionML = ENU='Unit-Amount Decimal Places (Tax)',
        //                 FRA='Nombre décimales montant unit. (Taxe)';
        //     Description = 'DITW15.00.00.24';
        //     InitValue = '2:5';

        //     trigger OnValidate();
        //     begin
        //         CheckDecimalPlacesFormat("Tax Unit-Amount Decimal Places");
        //     end;
        // }
        // field(2013718;"Tax Amount Rounding Prec.";Decimal)
        // {
        //     CaptionML = ENU='Amount Rounding Precision (Tax)',
        //                 FRA='Précision arrondi montant (Taxe)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.24';
        //     InitValue = 0.01;

        //     trigger OnValidate();
        //     begin
        //         //$$ obsolete to upgrade (bug DIT, find a way to check if tax g/l entries and others)
        //         /*
        //         RoundingErrorCheck(FIELDCAPTION("Tax Amount Rounding Prec."));
        //         MESSAGE(
        //           Text021);
        //         */

        //         // <<DITW15.00.00.32 DDR 08/04/2009
        //         TESTFIELD("Tax Amount Rounding Prec.","Amount Rounding Precision");
        //         // >>DITW15.00.00.32 DDR

        //     end;
        // }
        // field(2013719;"Tax Unit-Amount Rounding Prec.";Decimal)
        // {
        //     CaptionML = ENU='Unit-Amount Rounding Precision (Tax)',
        //                 FRA='Précis. arrondi montant unité (Taxe)';
        //     DecimalPlaces = 0:9;
        //     Description = 'DITW15.00.00.24';
        //     InitValue = 0.00001;

        //     trigger OnValidate();
        //     begin
        //         MESSAGE(
        //           Text022);
        //     end;
        // }
        // field(2013720;"Tax Spec. DegPlato Code";Code[20])
        // {
        //     CaptionML = ENU='Tax Spec. Code [Degree PLATO]',
        //                 FRA='Code spécif. taxe [Degré PLATO]';
        //     Description = 'DITW18.00.07 DIT-770 #1280';
        //     TableRelation = "Tax Specification" WHERE (Type=CONST(Specification));
        // }
        // field(2014120;"Sell-to/Bill-to DTax Gr. Calc.";Option)
        // {
        //     CaptionML = ENU='Sell-to/Bill-to Tax Calculation',
        //                 FRA='Calcul Taxes donneur d''ordre/client facturé';
        //     Description = 'DITW15.00.00.38 #1286';
        //     OptionCaptionML = ENU='Sell-to/Buy-from No.,Bill-to/Pay-to No.',
        //                       FRA='N° donneur d''ordre/fournisseur,N° client facturé/personne à payer';
        //     OptionMembers = "Sell-to/Buy-from No.","Bill-to/Pay-to No.";
        // }
        // field(2014121;"Copy Item to Tax Tracking Item";Option)
        // {
        //     CaptionML = ENU='Copy Item to Tax Tracking Item',
        //                 FRA='Copier article -> article traçable taxe';
        //     Description = 'DITW15.00.00.38 #703';
        //     OptionCaptionML = ENU=' ,Setup,Entries,Both',
        //                       FRA=' ,Paramètres,Ecritures,Les deux';
        //     OptionMembers = " ",Setup,Entry,Both;
        // }
        // field(2014410;"Calculate GiftBox Charges from";Option)
        // {
        //     CaptionML = ENU='Calculate Gift Box Item Charges from',
        //                 FRA='Calculer frais annexes Coffret de';
        //     Description = 'DITW16.00.00.43 DIT-715 #519';
        //     OptionCaptionML = ENU=' ,Assembly List,Production BOM',
        //                       FRA=' ,Assemblage,Nomenclature de production';
        //     OptionMembers = " ",AssemblyList,ProductionBom;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.43 DDR 25/09/2013 DIT-715 #519
        //         if "Calculate GiftBox Charges from" = "Calculate GiftBox Charges from"::" " then begin
        //           CLEAR("Include Gift Box Charges");
        //           // <<DITW18.00.06 DDR 23/10/2015 DIT-770 #1395
        //           CLEAR("Gift Box Other Item Charge");
        //           // >>DITW18.00.06 DDR DIT-770 #1395
        //         end;
        //         // >>DITW16.00.00.43 DDR DIT-715 #519
        //     end;
        // }
        // field(2014411;"Include Gift Box Charges";Option)
        // {
        //     CaptionML = ENU='Include Gift Box Item Charges',
        //                 FRA='Inclure frais annexes avec Coffret';
        //     Description = 'DITW16.00.00.43 DIT-715 #519';
        //     OptionCaptionML = ENU='Tax,Deposit & Tax',
        //                       FRA='Taxe,Consigne & Taxe';
        //     OptionMembers = Tax,TaxDeposit;
        // }
        // field(2014412;"Gift Box Other Item Charge";Code[20])
        // {
        //     CaptionML = ENU='Gift Box Other Item Charge',
        //                 FRA='Autre Frais annexes Coffret';
        //     Description = 'DITW18.00.06 DIT-770 #1395';
        //     TableRelation = "Item Charge" WHERE ("Item Charge Type"=CONST(" "));
        // }
        // field(2014413;"Allow Invoice Disc. G/L Acc.";Boolean)
        // {
        //     CaptionML = ENU='Allow Invoice Disc. G/L Account',
        //                 FRA='Autoriser remise facture compte général';
        //     Description = 'DITW19.00.08 BL#10868';
        // }
        // field(2014414;"Allow Invoice Disc. Resource";Boolean)
        // {
        //     CaptionML = ENU='Allow Invoice Disc. Resource',
        //                 FRA='Autoriser remise facture ressource';
        //     Description = 'DITW19.00.08 BL#10868';
        // }
        // field(2014415;"Allow Invoice Disc. FA";Boolean)
        // {
        //     CaptionML = ENU='Allow Invoice Disc. Fixed Asset',
        //                 FRA='Autoriser remise facture immobilisation';
        //     Description = 'DITW19.00.08 BL#10868';
        // }
        // field(2014416;"Allow Invoice Disc. Item Chrg.";Boolean)
        // {
        //     CaptionML = ENU='Allow Invoice Disc. Item Chcarge',
        //                 FRA='Autoriser remise facture frais annexe';
        //     Description = 'DITW19.00.08 BL#10868';
        // }
        // field(2014428;"Appln. per Charge Type";Boolean)
        // {
        //     CaptionML = ENU='Appln. per Charge Type',
        //                 FRA='Lettrage par type frais';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        // }
        // field(2014430;"Post Inv. Line Desc. to G/L";Boolean)
        // {
        //     CaptionML = ENU='Post Inv. Line Desc. to G/L',
        //                 FRA='Valider Lignes Desc. Factures  dans Ecriture comptable';
        //     Description = 'DITW17.00.02 DIT-770 #222';
        // }
        // field(2029610;"Jnl. Template Name (Aut. Acc.)";Code[10])
        // {
        //     CaptionML = ENU='Jnl. Templ. Name for Aut. Acc.',
        //                 FRA='Modèle FS de Aut. Acc.';
        //     Description = 'FINXL7.00.001';
        //     TableRelation = "Gen. Journal Template";
        // }
        // field(2029611;"Jnl. Batch Name (Aut. Acc.)";Code[10])
        // {
        //     CaptionML = ENU='Jnl. Batch Name for Aut. Acc.',
        //                 FRA='Nom FS de Aut. Acc.';
        //     Description = 'FINXL7.00.001';
        //     TableRelation = "Gen. Journal Batch".Name WHERE ("Journal Template Name"=FIELD("Jnl. Template Name (Aut. Acc.)"));
        // }
        // field(2029612;"Mail Standard Text";Code[10])
        // {
        //     CaptionML = ENU='Mail Standard Text',
        //                 FRA='Mail Texte standard';
        //     Description = 'FINXL7.00.001';
        //     TableRelation = "Standard Text";
        // }
        // field(2029613;"Transaction Type";Code[10])
        // {
        //     CaptionML = ENU='Transaction Type',
        //                 FRA='Nature transaction';
        //     Description = 'FINXL7.00.001';
        //     TableRelation = "Transaction Type";
        // }
        // field(2029614;"Transport Method";Code[10])
        // {
        //     CaptionML = ENU='Transport Method',
        //                 FRA='Mode de transport';
        //     Description = 'FINXL7.00.001';
        //     TableRelation = "Transport Method";
        // }
        // field(2029615;"Area";Code[10])
        // {
        //     CaptionML = ENU='Area',
        //                 FRA='Dépt destination/provenance';
        //     Description = 'FINXL7.00.001';
        //     TableRelation = Area;
        // }
        // field(2029617;"Apply template";Boolean)
        // {
        //     CaptionML = ENU='Apply template',
        //                 FRA='Appliquer Modèle';
        //     Description = 'FINXL8.00.001';
        // }
        // field(2029620;"Transaction Type Mandatory";Boolean)
        // {
        //     Caption = 'Transaction Type Mandatory';
        //     Description = 'FINXL9.00.001';
        // }
        // field(2029621;"Transport Method Mandatory";Boolean)
        // {
        //     Caption = 'Transport Method Mandatory';
        //     Description = 'FINXL9.00.001';
        // }
        // field(2029622;"Area Mandatory";Boolean)
        // {
        //     Caption = 'Area Mandatory';
        //     Description = 'FINXL9.00.001';
        // }
        // field(2029623;"Automatic Intrastat";Boolean)
        // {
        //     Caption = 'Automatic Intrastat';
        //     Description = 'FINXL9.00.000.01';
        // }
        //BC Upgrade KAPOOV01 drink-it<<
    }


    //Unsupported feature: CodeInsertion on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    var
    //FinancialUtils: Codeunit "Financial-Utils"; //BC Upgrade KAPOOV01-Codeunit
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    var
    //   FinancialUtils : Codeunit "Financial-Utils";//BC Upgrade KAPOOV01-Codeunit
    //begin
    /*
    FinancialUtils.MaintainCapexDim("Capex Dimension Code");//HEI.01 BPMGAP016
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=%1 %2 %3 have %4 to %5.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=%1 %2 %3 have %4 to %5.;FRA=%4 a pour valeur %5 dans %1 %2 %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=%1 %2 have %3 to %4.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=%1 %2 have %3 to %4.;FRA=%3 a pour valeur %4 dans %1 %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=%1 %2 %3 use %4.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=%1 %2 %3 use %4.;FRA=%1 %2 %3 utilise %4.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=%1 %2 use %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=%1 %2 use %3.;FRA=%1 %2 utilise %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=%1 must be rounded to the nearest %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=%1 must be rounded to the nearest %2.;FRA=%1 doit être arrondi au %2 le plus proche.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text016(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text016 : ENU="Enter one number or two numbers separated by a colon. ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text016 : ENU="Enter one number or two numbers separated by a colon. ";FRA="Entrez un nombre ou deux séparés par une virgule. ";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text017(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text017 : ENU=The online Help for this field describes how you can fill in the field.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text017 : ENU=The online Help for this field describes how you can fill in the field.;FRA=L'aide en ligne de ce champ vous explique comment le renseigner.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text018(Variable 1015)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text018 : ENU=You cannot change the contents of the %1 field because there are posted ledger entries.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text018 : ENU=You cannot change the contents of the %1 field because there are posted ledger entries.;FRA=Vous ne pouvez pas modifier le contenu du champ %1 car il existe des écritures comptables validées.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text021(Variable 1018)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text021 : ENU=You must close the program and start again in order to activate the amount-rounding feature.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text021 : ENU=You must close the program and start again in order to activate the amount-rounding feature.;FRA=Vous devez quitter le programme et redémarrer pour pouvoir activer la fonction d'arrondi montant.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text022(Variable 1019)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text022 : ENU=You must close the program and start again in order to activate the unit-amount rounding feature.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text022 : ENU=You must close the program and start again in order to activate the unit-amount rounding feature.;FRA=Vous devez quitter le programme et redémarrer pour pouvoir activer la fonction d'arrondi montant unité.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text023(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text023 : ENU=%1\You cannot use the same dimension twice in the same setup.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text023 : ENU=%1\You cannot use the same dimension twice in the same setup.;FRA=%1\Vous ne pouvez pas utiliser le même axe analytique deux fois dans le même paramétrage.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "DependentFieldActivatedErr(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DependentFieldActivatedErr : ENU=You cannot change %1 because %2 is selected.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DependentFieldActivatedErr : ENU=You cannot change %1 because %2 is selected.;FRA=Vous ne pouvez pas modifier %1 car %2 est sélectionné.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text025(Variable 1016)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text025 : ENU=The field %1 should not be set to %2 if field %3 in %4 table is set to %5 because deadlocks can occur.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text025 : ENU=The field %1 should not be set to %2 if field %3 in %4 table is set to %5 because deadlocks can occur.;FRA=Le champ %1 ne doit pas être défini sur %2 si le champ %3 dans la table %4 est défini sur %5 car des blocages peuvent être engendrés.;
    //Variable type has not been exported.
    //BC Upgrade KAPOOV01 Start
    trigger OnAfterModify()
    var
        myInt: Integer;
    begin
        //FinancialUtils.MaintainCapexDim("Capex Dimension Code");//HEI.01 BPMGAP016  ////BC Upgrade KAPOOV01-Codeunit
    end;

    /* //Bc Upgrade YADAVM09 Drink it field dependency commented>>
       procedure CheckPostingRange(DateToCheck: Date; FldCaption: Text[50])
       var
           myInt: Integer;
       begin
           CALCFIELDS("Posting Allowed From", "Posting Allowed To");
           IF ((DateToCheck < "Posting Allowed From") OR (DateToCheck >= "Posting Allowed To")) THEN
               ERROR(Text10800, FldCaption,
                 "Posting Allowed From", CALCDATE('<-1D>', "Posting Allowed To"));
       end;
        */ //Bc Upgrade YADAVM09 Drink it field dependency commented<<
           //BC Upgrade KAPOOV01 End

    var
        //PaymentClass: Record "Payment Class";  //BC Upgrade KAPOOV01-French Localization
        CompanyInfo: Record "Company Information";
        Dim: Record Dimension;
        Text023: Label '%1\You cannot use the same dimension twice in the same setup.';
        Text10800: TextConst ENU = '%1 must be within the allowed posting range: %2..%3', FRA = '%1 doit se situer dans la plage de validation autorisée : %2..%3';
        Text10801: TextConst ENU = '%1 %2 has %3 set to %4.', FRA = '%1 %2 a %3 défini sur %4.';
        Text10802: TextConst ENU = 'It is not allowed to specify %1 when %2 is %3.', FRA = 'Il n''est pas autorisé de spécifier %1 si %2 est %3.';



}

