pageextension 51007 GeneralLedgerSetupExtCBN extends "General Ledger Setup"
{

    //     DITW15.00.00.24 DDR 22/09/2008 Drink-It Tax rounding functionnalities
    //                                Added tab "Drink-it"
    //                                Added fields into tab "Drink-it"
    //                                  Amount Decimal Places
    //                                  Unit-Amount Decimal Places
    //                                  Amount Rounding Precision
    //                                  Unit-Amount Rounding Precision
    // DITW15.00.00.25 DDR 28/10/2008 Added fields into tab "Drink-it"
    //                                  Tax Amount Decimal Places
    //                                  Tax Unit-Amount Decimal Places
    //                                  Tax Amount Rounding Precision
    //                                  Tax Unit-Amount Rounding Precision
    //                                Added tab "Rounding" (for W1 only)
    //                                Moved Std fields into tab "Rounding"
    // DITW15.00.00.38 DDR 23/02/2011 issue 1286 Added field "Sell-to/Bill-to DTax Gr. Calc." into tab "Drink-it"
    // DITW15.00.00.38 DDR 18/03/2011 issue 703 Added field "Copy Item to Tax Tracking Item" into tab "Drink-it"
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields
    //                                 2014428 Appln. per Source reference
    // DITW16.00.00.43 DDR 25/09/2013 DIT-715 #519 Added field "Calculate DIT Charges from" (Drink-It tab)

    // FINXL7.00.001 RBE 20/03/2013 : SEPA
    //                                Added field "Mail Standard Text" on Extra group
    //                                Created new action "Mail Standard Text"
    //                                Added fields "Jnl. Template Name (Aut. Acc.)" and "Jnl. Batch Name (Aut. Acc.)"
    //                                Default value for fields: Transaction Type, Transport Method, Area
    // FINXL8.00.001 BSA 23/06/2015 #161 : Added field : "Apply Template"

    // DITW17.00.02 DDR 24/05/2013 DIT-770 #99 Added fields "W5 Nos.","W6 Nos." (tab Tax Report UK)
    //                  31/05/2013 DIT-770 #100 Added fields "W5d Nos.""W6d Nos." (tab Tax Report UK)
    //                  31/05/2013 DIT-770 #101 Added fields "Customer Tax Group W1" (tab Tax Report UK)
    //                  19/07/2013 DIT-770 #101 Added fields "Vendor Tax Group W1" (tab Tax Report UK)
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #99 #100 #101
    //              DDR 01/10/2013 DIT-715 #519 Merge
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 AT  06/12/2013 DIT-770 #222 Added Field
    //                                            2014430  Post Inv. Line Desc. to G/L
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 DDR 23/10/2015 DIT-770 #1395 Added fields 2014412 Gift Box Other Item Charge
    // DITW18.00.07 AKH 08/01/2016 DIT-770 #1280 Inventory Movement report - by Entry type in Qty and HL : Displayed field "Tax Spec. DegPlato Code" under Drink-It tab
    // DITW19.00.08 SFI 18/08/2016 BL#10868  (DIT-770 #2141) Added fields to group "Drink-IT"
    //                                                       2014413 Allow Invoice Disc. G/L Acc.
    //                                                       2014414 Allow Invoice Disc. Resource
    //                                                       2014415 Allow Invoice Disc. FA
    //                                                       2014416 Allow Invoice Disc. Item Chrg.
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // FINXL9.00.001 ACH 05/08/2016 : Add Groups "Finance Enhancements","Mail Enhancements" and "Intrastat Enhancements"
    // FINXL9.00.000.01 AKH 13/01/2017 Added field "Automatic Intrastat" under tab "Intastat Enhancements"

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New action on General tab in the ribbon to open Outbound Interface Setup
    // HEI.02 FDD-BPMGAP016 IBM SOICAD01 17.06.2017 #Investment Order
    //   #New fields: Capex Dimension Code, Capex Reference Budget, Capex Acc. Schedule Name
    // HEI.03 FDD-RTRGAP043 IBM POENAB01 26.07.2017 #Upload Mass Journal Entry Template
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
    // HEI.04 FDD RTRGAP062 Heilite BASE IBM ISYED01 04/08/2017 HeiMatch Flatfile
    //   # filed created for "OPCO Dimension Code"
    // HEI.05 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # New group: Local functionalities
    //   # New fields for MDM integration: WHT Minimum Invoice Amount, Manual Sales WHT Calc., Enable WHT, Round Amount for WHT Calc, Min. WHT Calc only on Inv. Amt
    //     added in group "Local Functionalities"
    // HEI.06 FDD RTRGAP057 IBM HORTOC01 27.07.2017
    //   # Add new field
    // HEI.07 FDD-BPMGAP014 IBM ISYED01 24.08.2017
    //   #Added added new field "Business Type Dimension Code", "Brand Dimension Code"  to page
    // HEI.08 FDD-RTRGAP001 IBM CHAUHB01 18.09.2017
    //   #Added fileds Cadency Temporary Path
    // HEI.09 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //   # New Field added: "Enable TIN By Location"
    // HEI.10 FDD-CHG2022328 IBM POENAB02 07.07.2019 # External document No. duplication in journal
    //   #New field added: "Restrt Duplicate Extrnl Doc" in "Local Functionalities" group

    // HEI.11 FDD-HT667 IBM SURYAS01 12-07-2019
    //   #New Field added:"Final Reporting Extracted" - In General Tab
    // HEI.12 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Added fields "Local Currency", "Currency Euro" in General group
    //   # Added action "<Page Allowed Posting Range>" in ActionGroup Functions
    // HEI.14 FDD-HT626 IBM SURYAS01 16-12-2019 La Reunion_Bank Connection Setup
    //   #New Field added: "File path"
    // HEI.15 FDD-HT1103 IBM SURYAS01  13-04-2020
    //   #Created new Field - "Apply Compensation"
    // HEI.16 FDD HT1136 CHG2055070 IBM Shankj03 16.06.2020
    //   # Created new field License Dimension Code
    // HEI.17 CHG CHG2060993 WIP Func. FCE 09.07.2020 (DDMMYYYY)
    //   # Added the fields 50063 and 50064 to the Page in Section "Local Funtionalities"
    // HEI.18 CHG CHG2060993 WIP Func. FCE 16.07.2020 (DDMMYYYY)
    //   # Added the field 50065 "WIP Output Zone Filtering"  to the page in Section "Local Funtionalities"
    // HEI.19 FDD-HT1330 IBM BULIMC01 08.02.2021#new field displayed to "Dimensions" tab - "Maison des Vins Dim. Code"
    // HEI.20 HT1812 IBM BULIMC01 24.02.2021 #new fields displayed to "Dimensions" tab - "Payroll Dimension Code" and "Salaries Dimension code"
    // HEI.21 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # New Field added: "Enable CAD"
    // HEI.22 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //    # New Field added: "Max CAD Difference Allowed"
    // HEI.23 FDD-HB2373 - CHG2123486 IBM NANDIS01 24.09.2021 - Development - CMG mandatory on FA card
    //   # New field shown - CMG Dimension Code(Field ID - 50071) in TAB - Dimensions
    // HEI.24 CHG2169924 IBM SISUM01 13/01/2023 #Add new field Id 50072 (G/L Application No. Series) under Finance Enhancements tab
    // HEI.25 CHG2200302 IBM POENAB02 04.05.2023 P&L by Nature in Heilite Base
    //   # New field added in "Finance Enhancements" group - 50073 P&L by Nature code
    // HEI.26 CHG2225264 IBM SISUM01 12.01.2024 HB3640_BRD_GT_FX on Working capital payables & receivables (excluding derivatives)
    //   # Add new field
    // HEI.27 CHG2236692 IBM SISUM01 06.03.2024 HB3717_Development to perform revaluation for AR/AP
    //   # Add new field        
    // HEI.28 CHG2232991 IBM POENAB02 12.03.2024 HB3713_Limitation on the reverse action in table “create document shipping cost”
    //   # New field added - 50076 "Posted Document Shipping Limit" in "Local Functionalities" group
    // HEI.29 CHG2236692 IBM POENAB02 09.04.2024 HB3717_Change in the process of performing revaluation for AR/AP
    //   # For visible = false for field "Reversal Reev. Activate Date"
    // version NAVW110.0,FINXL9.00.000.01,DITW110.00.08,BPMGAP016,HEI.29

    // BC Upgrade SHUKLP03 >>
    // Added group("Local Functionalities") and action("Interface Setup") in interface extension.
    // BC Upgrade SHUKLP03 <<

    //Bc Upgrade YADAVM09 Drink it field commented-Local Currency,Currency Euro

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Allow Posting From")
        {
            ToolTipML = ENU = 'Specifies the earliest date on which posting to the company is allowed.', FRA = 'Spécifie la première date à laquelle la validation dans la société est autorisée.';
        }
        modify("Allow Posting To")
        {
            ToolTipML = ENU = 'Specifies the last date on which posting to the company is allowed.', FRA = 'Spécifie la dernière date à laquelle la validation dans la société est autorisée.';
        }
        modify("Register Time")
        {
            ToolTipML = ENU = 'Specifies whether the program will register the user''s time usage. Place a check mark in the field if you want the program to register time for each user.', FRA = 'Spécifie si le programme doit enregistrer le temps d''utilisation de l''utilisateur. Sélectionnez le champ si vous souhaitez que le programme enregistre le temps de chaque utilisateur.';
        }
        modify("Local Address Format")
        {
            ToolTipML = ENU = 'Specifies the format in which addresses must appear on printouts.', FRA = 'Spécifie le format des adresses sur les documents imprimés.';
        }
        modify("Local Cont. Addr. Format")
        {
            ToolTipML = ENU = 'Specifies where you want the contact name to appear in mailing addresses.', FRA = 'Spécifie où le nom du contact est imprimé sur l''adresse.';
        }
        modify("Inv. Rounding Precision (LCY)")
        {
            ToolTipML = ENU = 'Specifies the size of the interval to be used when rounding amounts in your local currency. You can also specify invoice rounding for each currency in the Currency table.', FRA = 'Spécifie la taille de l''intervalle à utiliser lorsque vous arrondissez des montants dans votre devise locale. Vous pouvez également spécifier un arrondi facture pour chaque devise dans la table Devise.';
        }
        modify("Inv. Rounding Type (LCY)")
        {
            ToolTipML = ENU = 'Specifies whether an invoice amount will be rounded up or down. The program uses this information together with the interval for rounding that you have specified in the Inv. Rounding Precision (LCY) field.', FRA = 'Spécifie si le montant d''une facture est arrondi par excès ou par défaut. Le programme utilise cette information avec l''intervalle d''arrondi que vous avez spécifié dans le champ Précis. arrondi fact. DS.';
        }
        modify("Allow G/L Acc. Deletion Before")
        {
            ToolTipML = ENU = 'Specifies if and when general ledger accounts can be deleted. If you enter a date, G/L accounts with entries on or after this date cannot be deleted.', FRA = 'Spécifie s''il est possible de supprimer des comptes généraux, et quand. Si vous saisissez une date, les comptes généraux comportant des écritures à cette date ou après ne peuvent pas être supprimés.';
        }
        modify("Check G/L Account Usage")
        {
            ToolTipML = ENU = 'Specifies that you want the program to protect G/L accounts that are used in setup tables from being deleted.', FRA = 'Spécifie que vous souhaitez que le programme empêche la suppression des comptes généraux utilisés dans les tables de configuration.';
        }
        modify("EMU Currency")
        {
            ToolTipML = ENU = 'Specifies whether LCY is an EMU currency.', FRA = 'Spécifie si la DS est une devise U.M.E.';
        }
        modify("LCY Code")
        {
            ToolTipML = ENU = 'Specifies the currency code for LCY.', FRA = 'Spécifie le code de la DS.';
        }
        modify("Local Currency Symbol")
        {
            ToolTipML = ENU = 'Specifies the symbol for this currency that you wish to appear on checks and charts, $ for USD, CAD or MXP for example.', FRA = 'Spécifie le symbole de la devise que vous souhaitez indiquer sur les chèques et les tableaux, $ pour USD, CAD ou MXP, par exemple.';
        }
        modify("Pmt. Disc. Excl. VAT")
        {
            ToolTipML = ENU = 'Specifies whether the payment discount is calculated based on amounts including or excluding VAT.', FRA = 'Spécifie si l''escompte est calculé sur la base des montants incluant ou n''incluant pas la TVA.';
        }
        modify("Adjust for Payment Disc.")
        {
            ToolTipML = ENU = 'Specifies whether to recalculate tax amounts when you post payments that trigger payment discounts.', FRA = 'Spécifie si vous souhaitez recalculer les montants de taxe lorsque vous validez des paiements qui entraînent des escomptes.';
        }
        modify("Max. VAT Difference Allowed")
        {
            ToolTipML = ENU = 'Specifies the maximum VAT correction amount allowed for the local currency.', FRA = 'Spécifie le montant maximal de différence TVA autorisée pour la devise locale.';
        }
        modify("VAT Rounding Type")
        {
            ToolTipML = ENU = 'Specifies how the program will round VAT when calculated for the local currency.', FRA = 'Spécifie la manière dont le programme arrondit la TVA de cette devise locale.';
        }
        modify("Bank Account Nos.")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign numbers to bank accounts.', FRA = 'Spécifie le code des souches de numéros qui sont utiliséees pour affecter des numéros aux comptes bancaires.';
        }
        modify("Bill-to/Sell-to VAT Calc.")
        {
            ToolTipML = ENU = 'Specifies where the VAT Bus. Posting Group code on an order or invoice is copied from.', FRA = 'Spécifie l''emplacement à partir duquel est copié le code Groupe compta. marché TVA d''une commande ou d''une facture.';
        }
        modify("Print VAT specification in LCY")
        {
            ToolTipML = ENU = 'Specifies that an extra VAT specification in local currency will be included on documents in a foreign currency.', FRA = 'Spécifie qu''un détail TVA supplémentaire en devise locale figurera sur les documents en devise étrangère.';
        }
        // modify("Use Legacy G/L Entry Locking")
        // {
        //     ToolTipML = ENU = 'Specifies when the G/L Entry table should be locked during sales, purchase and service posting.', FRA = 'Spécifie à quel moment la table Écriture comptable doit être verrouillée durant les ventes, les achats et la validation de service.';
        // }
        // modify(Dimensions)
        // {
        //     CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
        // } //BC Upgrade KAPVOO01 Field not present in table
        modify("Global Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies a global dimension. Global dimensions are the dimensions that you analyze most frequently.', FRA = 'Spécifie un axe principal. Les axes principaux sont ceux que vous analysez le plus fréquemment.';
        }
        modify("Global Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies a global dimension. Global dimensions are the dimensions that you analyze most frequently.', FRA = 'Spécifie un axe principal. Les axes principaux sont ceux que vous analysez le plus fréquemment.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
        }
        modify("Shortcut Dimension 3 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 3.', FRA = 'Spécifie le code pour Raccourci axe 3.';
        }
        modify("Shortcut Dimension 4 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 4.', FRA = 'Spécifie le code pour Raccourci axe 4.';
        }
        modify("Shortcut Dimension 5 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 5.', FRA = 'Spécifie le code pour Raccourci axe 5.';
        }
        modify("Shortcut Dimension 6 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 6.', FRA = 'Spécifie le code pour Raccourci axe 6.';
        }
        modify("Shortcut Dimension 7 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 7.', FRA = 'Spécifie le code pour Raccourci axe 7.';
        }
        modify("Shortcut Dimension 8 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 8.', FRA = 'Spécifie le code pour Raccourci axe 8.';
        }
        modify(Reporting)
        {
            CaptionML = ENU = 'Reporting', FRA = 'Génération d''états';
        }
        modify("Acc. Sched. for Balance Sheet")
        {
            ToolTipML = ENU = 'Specifies which account schedule name is used to generate the Balance Sheet report.', FRA = 'Spécifie quel nom du tableau d''analyse est utilisé pour générer l''état du bilan.';
        }
        modify("Acc. Sched. for Income Stmt.")
        {
            ToolTipML = ENU = 'Specifies which account schedule name is used to generate the Income Statement report.', FRA = 'Spécifie quel nom du tableau d''analyse est utilisé pour générer l''état des comptes de gestion.';
        }
        modify("Acc. Sched. for Cash Flow Stmt")
        {
            ToolTipML = ENU = 'Specifies which account schedule name is used to generate the Cash Flow Statement report.', FRA = 'Spécifie quel nom du tableau d''analyse est utilisé pour générer l''état de la déclaration de trésorerie.';
        }
        modify("Acc. Sched. for Retained Earn.")
        {
            ToolTipML = ENU = 'Specifies which account schedule name is used to generate the Retained Earnings report.', FRA = 'Spécifie quel nom du tableau d''analyse est utilisé pour générer l''état des réserves.';
        }
        modify("Additional Reporting Currency")
        {
            ToolTipML = ENU = 'Specifies the currency that will be used as an additional reporting currency in the general ledger application area.', FRA = 'Spécifie la devise qui est utilisée comme devise report dans le domaine d''application Comptabilité.';
        }
        modify("VAT Exchange Rate Adjustment")
        {
            ToolTipML = ENU = 'Specifies how the accounts set up for VAT posting in the VAT Posting Setup table will be adjusted for exchange rate fluctuations.', FRA = 'Spécifie comment les comptes paramétrés pour comptabilisation TVA dans la table Paramètres comptabilisation TVA seront ajustés pour les fluctuations de taux de change.';
        }
        // modify("VAT Reg. No. Validation URL")
        // {
        //     ToolTipML = ENU = 'Specifies the URL of the EU web service that is used by default to verify VAT registration numbers.', FRA = 'Spécifie l''URL du service Web de l''Union européenne qui est utilisé par défaut pour vérifier les numéros d''identification intracommunautaire.';
        // }//BC Upgrade KAPVOO01 Obselete field.
        modify(Application)
        {
            CaptionML = ENU = 'Application', FRA = 'Lettrage';
        }
        modify("Appln. Rounding Precision")
        {
            ToolTipML = ENU = 'Specifies the rounding difference that will be allowed when you apply entries in LCY to entries in a different currency.', FRA = 'Spécifie les différences d''arrondi qui seront autorisées lorsque vous lettrez des écritures en DS avec des écritures dans une autre devise.';
        }
        modify("Pmt. Disc. Tolerance Warning")
        {
            ToolTipML = ENU = 'Specifies a warning will appear every time an application occurs between the dates specified in the Payment Discount Date field and the Pmt. Disc. Tolerance Date field in the General Ledger Setup table.', FRA = 'Spécifie qu''un avertissement apparaît chaque fois qu''un lettrage se produit entre les dates spécifiées dans le champ Date d''escompte et le champ Date écart d''escompte dans la table Paramètres comptabilité.';
        }
        modify("Pmt. Disc. Tolerance Posting")
        {
            ToolTipML = ENU = 'Specifies the posting method, which the program follows when posting a payment tolerance.', FRA = 'Spécifie la méthode comptabilisation que le programme utilise pour valider un écart de règlement.';
        }
        modify("Payment Discount Grace Period")
        {
            ToolTipML = ENU = 'Specifies the number of days that a payment or refund can pass the payment discount due date and still receive payment discount.', FRA = 'Spécifie le nombre de jours pendant lesquels un paiement ou un remboursement peut bénéficier d''un escompte malgré l''expiration de la date d''échéance de ce dernier.';
        }
        modify("Payment Tolerance Warning")
        {
            ToolTipML = ENU = 'Specifies a warning will appear when an application has a balance within the tolerance specified in the Max. Payment Tolerance field in the General Ledger Setup table.', FRA = 'Spécifie qu''un avertissement apparaît lorsqu''un lettrage présente un solde respectant l''écart mentionné dans le champ Écart de règlement max. dans la table Paramètres comptabilité.';
        }
        modify("Payment Tolerance Posting")
        {
            ToolTipML = ENU = 'Specifies the posting methods when posting a payment tolerance.', FRA = 'Spécifie les méthodes comptabilisation d''un écart de règlement.';
        }
        modify("Payment Tolerance %")
        {
            ToolTipML = ENU = 'Specifies the percentage that the payment or refund is allowed to be less than the amount on the invoice or credit memo.', FRA = 'Spécifie le pourcentage que le paiement ou le remboursement peut atteindre en dessous du montant de la facture ou de l''avoir.';
        }
        modify("Max. Payment Tolerance Amount")
        {
            ToolTipML = ENU = 'Specifies the maximum allowed amount that the payment or refund can differ from the amount on the invoice or credit memo.', FRA = 'Spécifie l''écart maximal autorisé entre le paiement ou le remboursement et le montant de la facture ou de l''avoir.';
        }
        modify("Payroll Transaction Import")
        {
            CaptionML = ENU = 'Payroll Transaction Import', FRA = 'Importation de la transaction Paie';
        }
        modify("Payroll Trans. Import Format")
        {
            ToolTipML = ENU = 'Specifies the format of the payroll transaction file that can be imported into the General Journal window.', FRA = 'Indique le format du fichier de transaction Paie qui peut être importé dans la fenêtre Feuille comptabilité.';
        }

        //Unsupported feature: CodeModification on ""Additional Reporting Currency"(Control 12).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Additional Reporting Currency" <> xRec."Additional Reporting Currency" THEN BEGIN
          IF "Additional Reporting Currency" = '' THEN
            Confirmed := CONFIRM(Text002,FALSE)
          else
            Confirmed := CONFIRM(Text003,FALSE);
          IF NOT Confirmed THEN
            ERROR('');
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Additional Reporting Currency" <> xRec."Additional Reporting Currency" then begin
          if "Additional Reporting Currency" = '' then
            Confirmed := CONFIRM(Text002,false)
          else
            Confirmed := CONFIRM(Text003,false);
          if not Confirmed then
            ERROR('');
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Payment Discount Grace Period"(Control 62).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CONFIRM(Text001,TRUE) THEN
          PaymentToleranceMgt.CalcGracePeriodCVLedgEntry("Payment Discount Grace Period");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if CONFIRM(Text001,true) then
          PaymentToleranceMgt.CalcGracePeriodCVLedgEntry("Payment Discount Grace Period");
        */
        //end;

        /* //Bc Upgrade YADAVM09 Drink it field commented>>
        addafter("Check G/L Account Usage")
        {
            field("Local Currency"; Rec."Local Currency")
            {
                ApplicationArea = Basic, Suite;
                ToolTipML = ENU = 'Specifies if your local currency is euro or another currency.',
                            FRA = 'Indique si vous souhaitez que votre devise société soit l''euro ou une autre devise.';
            }
            field("Currency Euro"; Rec."Currency Euro")
            {
                ApplicationArea = Basic, Suite;
                ToolTipML = ENU = 'Specify the currency code that represents euro.',
                            FRA = 'Spécifiez le code devise qui représente les euros.';
            }
        }
        */ //Bc Upgrade YADAVM09 Drink it field commented<<
        addafter("Max. VAT Difference Allowed")
        {
            field("Max CAD Difference Allowed"; Rec."Max CAD Difference Allowed FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Max CAD Difference Allowed field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Max CAD Difference Allowed field.';

            }
            field("WIP Account"; Rec."WIP Account FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the WIP Account field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the WIP Account field.';

            }
            field("Bal. Wip Account"; Rec."Bal. Wip Account FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bal. Wip Account field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Bal. Wip Account field.';

            }
            // field("Post Inv. Line Desc. to G/L"; "Post Inv. Line Desc. to G/L")
            // {
            // }////BC Upgrade KAPOOV01-drink-it
            field("Final Reporting Extracted"; Rec."Final Reporting Extracted FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Final Reporting Extracted field.';
                // BC Upgrade NANDIS03                                                                                                                                                                        ToolTip = 'Specifies the value of the Final Reporting Extracted field.';

            }
            field("File path"; Rec."File path FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the File path field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the File path field.';

            }
            field("Enable GT FX"; Rec."Enable GT FX FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Enable GT FX field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Enable GT FX field.';

            }
            field("Reversal Reev. Activate Date"; Rec."Reversal Reev. Act Date FND")
            {
                ApplicationArea = All;  // BC Upgrade NANDIS03
                Visible = false;
                ToolTip = 'Specifies the value of the Reversal Reev. Activate Date field.';
            }
        }
        //addafter("Use Legacy G/L Entry Locking") 
        // {

        // } //BC Upgrade KAPVOO01 Field Removed
        addafter("Shortcut Dimension 8 Code")
        {
            field("Business Type Dimension Code"; Rec."Business Type Dim Code FND")
            {
                ApplicationArea = All;  // BC Upgrade NANDIS03
                Description = 'HEI1.0,EDD072';
                ToolTip = 'Specifies the value of the Business Type Dimension Code field.';
            }
            field("Brand Dimension Code"; Rec."Brand Dimension Code FND")
            {
                ApplicationArea = All;  // BC Upgrade NANDIS03
                Description = 'HEI1.0,EDD072';
                ToolTip = 'Specifies the value of the Brand Dimension Code field.';
            }
            field("OPCO Dimension Code"; Rec."OPCO Dimension Code FND")
            {
                ApplicationArea = All;  // BC Upgrade NANDIS03
                Description = 'HEI1.0,EDD072';
                ToolTip = 'Specifies the value of the OPCO Dimension Code field.';
            }
            field("Cost Center Dimension Code"; Rec."Cost Center Dimension Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Cost Center Dimension Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Cost Center Dimension Code field.';

            }
            field("SKU Dimension Code"; Rec."SKU Dimension Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SKU Dimension Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the SKU Dimension Code field.';

            }
            field("Line ext Dimension Code"; Rec."Line ext Dimension Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Line ext Dimension Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Line ext Dimension Code field.';

            }
            field("Primary Pack Type Dim"; Rec."Primary Pack Type Dim FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Primary Pack Type Dim field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Primary Pack Type Dim field.';

            }
            field("Customer Dimension Code"; Rec."Customer Dimension Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Dimension Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Customer Dimension Code field.';

            }
            field("License Dimension Code"; Rec."License Dimension Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the License Dimension Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the License Dimension Code field.';

            }
            field("Maison des Vins Dim. Code"; Rec."Maison des Vins Dim. Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Maison des Vins Dim. Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Maison des Vins Dim. Code field.';

            }
            field("Payroll Dimension Code"; Rec."Payroll Dimension Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Payroll Dimension Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Payroll Dimension Code field.';

            }
            field("Salaries Dimension Code"; Rec."Salaries Dimension Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Salaries Dimension Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Salaries Dimension Code field.';

            }
            field("CMG Dimension Code"; Rec."CMG Dimension Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CMG Dimension Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the CMG Dimension Code field.';

            }
            field("Cadency Temporary Path"; Rec."Cadency Temporary Path FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Cadency Temporary Path field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Cadency Temporary Path field.';

            }
        }

        addafter(Control1900309501)
        {
            group(Heilite)
            {
                Caption = 'Heilite';
                group(Capex)
                {
                    Caption = 'Capex';
                    field("Capex Dimension Code"; Rec."Capex Dimension Code FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Capex Dimension Code field.';
                        // BC Upgrade NANDIS03                        ToolTip = 'Specifies the value of the Capex Dimension Code field.';

                    }
                    field("Capex Reference Budget"; Rec."Capex Reference Budget FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Capex Reference Budget field.';
                        // BC Upgrade NANDIS03                        ToolTip = 'Specifies the value of the Capex Reference Budget field.';

                    }
                    field("Capex Acc. Schedule Name"; Rec."Capex Acc. Schedule Name FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Capex Acc. Schedule Name field.';
                        // BC Upgrade NANDIS03                        ToolTip = 'Specifies the value of the Capex Acc. Schedule Name field.';

                    }
                    field("Gl Budget Standard Cost"; Rec."Gl Budget Standard Cost FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Gl Budget Standard Cost field.';
                        // BC Upgrade NANDIS03                        ToolTip = 'Specifies the value of the Gl Budget Standard Cost field.';

                    }
                }
            }
        }
        // addafter("VAT Reg. No. Validation URL")
        // {

        // }//BC Upgrade KAPVOO01 Obselete field.
        addafter("Payroll Transaction Import")
        {
            group(FinanceEnhancements)
            {
                CaptionML = ENU = 'Finance Enhancements',
                            FRA = 'Extra';
                Description = 'FINXL7.00.001';
                // field("Apply template"; Rec."Apply template")
                // {
                // }
                // field("Jnl. Template Name (Aut. Acc.)"; "Jnl. Template Name (Aut. Acc.)")
                // {
                //     Description = 'FINXL7.00.001';
                // }
                // field("Jnl. Batch Name (Aut. Acc.)"; "Jnl. Batch Name (Aut. Acc.)")
                // {
                //     Description = 'FINXL7.00.001';
                // }//BC Upgrade KAPOOV01-drink-it
                field("G/L Application No. Series"; Rec."G/L Application No. Series FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the G/L Application No. Series field.';
                    // BC Upgrade NANDIS03                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            ToolTip = 'Specifies the value of the G/L Application No. Series field.';

                }
                field("P&L by Nature code"; Rec."P&L by Nature code FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P&L by Nature code field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the P&L by Nature code field.';

                }
            }
            group("Mail Enhancements")
            {
                CaptionML = ENU = 'Mail Enhancements',
                            FRA = 'Mail Amélioriations';
            }
            group("Intrastat Enhancements")
            {
                CaptionML = ENU = 'Intrastat Enhancements',
                            FRA = 'Intrastat Amélioriations';
                // field("Transaction Type"; "Transaction Type")
                // {
                //     Description = 'FINXL7.00.001';
                // }
                // field("Transport Method"; "Transport Method")
                // {
                //     Description = 'FINXL7.00.001';
                // }
                // field("Area"; Area)
                // {
                //     Description = 'FINXL7.00.001';
                // }
                // field("Automatic Intrastat"; "Automatic Intrastat")
                // {
                // }
                // field("Transaction Type Mandatory"; "Transaction Type Mandatory")
                // {
                // }
                // field("Transport Method Mandatory"; "Transport Method Mandatory")
                // {
                // }
                // field("Area Mandatory"; "Area Mandatory")
                // {
                // }//BC Upgrade KAPOOV01-drink-it
            }
            group(Rounding)
            {
                CaptionML = ENU = 'Rounding',
                            FRA = 'Arrondi';
                field("Amount Rounding Precision"; Rec."Amount Rounding Precision")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the size of the interval to be used when rounding amounts in LCY. This covers amounts created with all types of transactions and is useful to avoid inconsistencies when viewing or summing different amounts. Amounts will be rounded to the nearest digit. Example: To have amounts rounded to whole numbers, enter 1.00 in this field. In this case, amounts less than 0.5 will be rounded down and amounts greater than or equal to 0.5 will be rounded up. On the Currencies page, you specify how amounts in foreign currencies are rounded.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the size of the interval to be used when rounding amounts in LCY. This covers amounts created with all types of transactions and is useful to avoid inconsistencies when viewing or summing different amounts. Amounts will be rounded to the nearest digit. Example: To have amounts rounded to whole numbers, enter 1.00 in this field. In this case, amounts less than 0.5 will be rounded down and amounts greater than or equal to 0.5 will be rounded up. On the Currencies page, you specify how amounts in foreign currencies are rounded.';

                }
                field("Amount Decimal Places"; Rec."Amount Decimal Places")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of decimal places that are shown for amounts in LCY. This covers amounts created with all types of transactions and is useful to avoid inconsistencies when viewing or summing different amounts. The default setting, 2:2, specifies that all amounts in LCY are shown with a minimum of 2 decimal places and a maximum of 2 decimal places. You can also enter a fixed number, such as 2, which also means that amounts are shown with two decimals. On the Currencies page, you specify how many decimal places to show for amounts in foreign currencies.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the number of decimal places that are shown for amounts in LCY. This covers amounts created with all types of transactions and is useful to avoid inconsistencies when viewing or summing different amounts. The default setting, 2:2, specifies that all amounts in LCY are shown with a minimum of 2 decimal places and a maximum of 2 decimal places. You can also enter a fixed number, such as 2, which also means that amounts are shown with two decimals. On the Currencies page, you specify how many decimal places to show for amounts in foreign currencies.';

                }
                field("Unit-Amount Rounding Precision"; Rec."Unit-Amount Rounding Precision")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the size of the interval to be used when rounding unit amounts, item or resource prices per unit, in LCY. Amounts will be rounded to the nearest digit. Example: To have unit amounts rounded to whole numbers, enter 1.00 in this field. In this case, amounts less than 0.5 will be rounded down and amounts greater than or equal to 0.5 will be rounded up. On the Currencies page, you specify how unit amounts in foreign currencies are rounded.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the size of the interval to be used when rounding unit amounts, item or resource prices per unit, in LCY. Amounts will be rounded to the nearest digit. Example: To have unit amounts rounded to whole numbers, enter 1.00 in this field. In this case, amounts less than 0.5 will be rounded down and amounts greater than or equal to 0.5 will be rounded up. On the Currencies page, you specify how unit amounts in foreign currencies are rounded.';

                }
                field("Unit-Amount Decimal Places"; Rec."Unit-Amount Decimal Places")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of decimal places that are shown for unit amounts, item or resource prices per unit, in LCY. The default setting, 2:5, specifies that unit amounts will be shown with a minimum of two decimal places and a maximum of five decimal places. You can also enter a fixed number, such as 2, to specify that all unit amounts are shown with two decimal places. On the Currencies page, you specify how many decimal places to show for unit amounts in foreign currencies.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the number of decimal places that are shown for unit amounts, item or resource prices per unit, in LCY. The default setting, 2:5, specifies that unit amounts will be shown with a minimum of two decimal places and a maximum of five decimal places. You can also enter a fixed number, such as 2, to specify that all unit amounts are shown with two decimal places. On the Currencies page, you specify how many decimal places to show for unit amounts in foreign currencies.';

                }
            }
            // group("Drink-It")
            // {
            //     CaptionML = ENU = 'Drink-It',
            //                 FRA = 'Drink-It';
            //     field("Tax Amount Rounding Prec."; "Tax Amount Rounding Prec.")
            //     {
            //     }
            //     field("Tax Amount Decimal Places"; "Tax Amount Decimal Places")
            //     {
            //     }
            //     field("Tax Unit-Amount Rounding Prec."; "Tax Unit-Amount Rounding Prec.")
            //     {
            //     }
            //     field("Tax Unit-Amount Decimal Places"; "Tax Unit-Amount Decimal Places")
            //     {
            //     }
            //     field("Sell-to/Bill-to DTax Gr. Calc."; "Sell-to/Bill-to DTax Gr. Calc.")
            //     {
            //     }
            //     field("Copy Item to Tax Tracking Item"; "Copy Item to Tax Tracking Item")
            //     {
            //     }
            //     field("Appln. per Charge Type"; "Appln. per Charge Type")
            //     {
            //     }
            //     field("Calculate GiftBox Charges from"; "Calculate GiftBox Charges from")
            //     {

            //         trigger OnValidate();
            //         begin
            //             // <<DITW18.00.06 DDR 23/10/2015 DIT-770 #1395
            //             CurrPage.UPDATE(true);
            //             // >>DITW18.00.06 DDR DIT-770 #1395
            //         end;
            //     }
            //     field("Include Gift Box Charges"; "Include Gift Box Charges")
            //     {
            //         Editable = GiftboxEditable;
            //     }
            //     field("Gift Box Other Item Charge"; "Gift Box Other Item Charge")
            //     {
            //         Editable = GiftboxEditable;
            //     }
            //     field("Tax Spec. DegPlato Code"; "Tax Spec. DegPlato Code")
            //     {
            //     }
            //     field("Allow Invoice Disc. G/L Acc."; "Allow Invoice Disc. G/L Acc.")
            //     {
            //     }
            //     field("Allow Invoice Disc. Resource"; "Allow Invoice Disc. Resource")
            //     {
            //     }
            //     field("Allow Invoice Disc. FA"; "Allow Invoice Disc. FA")
            //     {
            //     }
            //     field("Allow Invoice Disc. Item Chrg."; "Allow Invoice Disc. Item Chrg.")
            //     {
            //     }
            // }//BC Upgrade KAPOOV01-drink-it
            group("Upload Mass Journal")
            {
                Caption = 'Upload Mass Journal';
                field("Mass Upload Dimension 9"; Rec."Mass Upload Dimension 9 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mass Upload Dimension 9 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Mass Upload Dimension 9 field.';

                }
                field("Mass Upload Dimension 10"; Rec."Mass Upload Dimension 10 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mass Upload Dimension 10 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Mass Upload Dimension 10 field.';

                }
                field("Mass Upload Dimension 11"; Rec."Mass Upload Dimension 11 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mass Upload Dimension 11 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Mass Upload Dimension 11 field.';

                }
                field("Mass Upload Dimension 12"; Rec."Mass Upload Dimension 12 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mass Upload Dimension 12 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Mass Upload Dimension 12 field.';

                }
                field("Mass Upload Dimension 13"; Rec."Mass Upload Dimension 13 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mass Upload Dimension 13 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Mass Upload Dimension 13 field.';

                }
                field("Mass Upload Dimension 14"; Rec."Mass Upload Dimension 14 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mass Upload Dimension 14 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Mass Upload Dimension 14 field.';

                }
                field("Mass Upload Dimension 15"; Rec."Mass Upload Dimension 15 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mass Upload Dimension 15 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Mass Upload Dimension 15 field.';

                }
                field("Mass Upload Dimension 16"; Rec."Mass Upload Dimension 16 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mass Upload Dimension 16 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Mass Upload Dimension 16 field.';

                }
                field("Mass Upload Dimension 17"; Rec."Mass Upload Dimension 17 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mass Upload Dimension 17 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Mass Upload Dimension 17 field.';

                }
                field("Mass Upload Dimension 18"; Rec."Mass Upload Dimension 18 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mass Upload Dimension 18 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Mass Upload Dimension 18 field.';

                }
                field("Mass Upload Dimension 19"; Rec."Mass Upload Dimension 19 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mass Upload Dimension 19 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Mass Upload Dimension 19 field.';

                }
                field("Mass Upload Dimension 20"; Rec."Mass Upload Dimension 20 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mass Upload Dimension 20 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Mass Upload Dimension 20 field.';

                }
                field("Mass Upload Dimension 21"; Rec."Mass Upload Dimension 21 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mass Upload Dimension 21 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Mass Upload Dimension 21 field.';

                }
                field("Mass Upload Dimension 22"; Rec."Mass Upload Dimension 22 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mass Upload Dimension 22 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Mass Upload Dimension 22 field.';

                }
                field("Mass Upload Dimension 23"; Rec."Mass Upload Dimension 23 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mass Upload Dimension 23 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Mass Upload Dimension 23 field.';

                }
                field("Mass Upload Dimension 24"; Rec."Mass Upload Dimension 24 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mass Upload Dimension 24 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Mass Upload Dimension 24 field.';

                }
                field("Mass Upload Dimension 25"; Rec."Mass Upload Dimension 25 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mass Upload Dimension 25 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Mass Upload Dimension 25 field.';

                }
                field("Mass Upload Dimension 26"; Rec."Mass Upload Dimension 26 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mass Upload Dimension 26 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Mass Upload Dimension 26 field.';

                }
                field("Mass Upload Dimension 27"; Rec."Mass Upload Dimension 27 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mass Upload Dimension 27 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Mass Upload Dimension 27 field.';

                }
                field("Mass Upload Dimension 28"; Rec."Mass Upload Dimension 28 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mass Upload Dimension 28 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Mass Upload Dimension 28 field.';

                }
                field("Mass Upload Dimension 29"; Rec."Mass Upload Dimension 29 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mass Upload Dimension 29 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Mass Upload Dimension 29 field.';

                }
                field("Mass Upload Dimension 30"; Rec."Mass Upload Dimension 30 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mass Upload Dimension 30 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Mass Upload Dimension 30 field.';

                }
            }

            // BC Upgrade SHUKLP03 >> Moved in Interface Ext
            // group("Local Functionalities")
            // {
            //     Caption = 'Local Functionalities';
            //     field("WHT Minimum Invoice Amount"; Rec."WHT Minimum Invoice Amount")
            //     {
            //         ApplicationArea = All;  // BC Upgrade NANDIS03
            //     }
            //     field("Manual Sales WHT Calc."; Rec."Manual Sales WHT Calc.")
            //     {
            //         ApplicationArea = All;  // BC Upgrade NANDIS03
            //     }
            //     field("Enable WHT"; Rec."Enable WHT")
            //     {
            //         ApplicationArea = All;  // BC Upgrade NANDIS03
            //     }
            //     field("Apply Compensation"; Rec."Apply Compensation")
            //     {
            //         ApplicationArea = All;  // BC Upgrade NANDIS03
            //     }
            //     field("Round Amount for WHT Calc"; Rec."Round Amount for WHT Calc")
            //     {
            //         ApplicationArea = All;  // BC Upgrade NANDIS03
            //     }
            //     field("Min. WHT Calc only on Inv. Amt"; Rec."Min. WHT Calc only on Inv. Amt")
            //     {
            //         ApplicationArea = All;  // BC Upgrade NANDIS03
            //     }
            //     field("Enable TIN By Location"; Rec."Enable TIN By Location")
            //     {
            //         ApplicationArea = All;  // BC Upgrade NANDIS03
            //         Caption = 'Enable TIN By Location';
            //         Description = 'HEI.09';
            //     }
            //     field("Restrt Duplicate Extrnl Doc"; Rec."Restrt Duplicate Extrnl Doc")
            //     {
            //         ApplicationArea = All;  // BC Upgrade NANDIS03
            //     }
            //     field("WIP Accrual. Mat. Perc."; Rec."WIP Accrual. Mat. Perc.")
            //     {
            //         ApplicationArea = All;  // BC Upgrade NANDIS03
            //     }
            //     field("WIP Accrual. Cap. Perc."; Rec."WIP Accrual. Cap. Perc.")
            //     {
            //         ApplicationArea = All;  // BC Upgrade NANDIS03
            //     }
            //     field("WIP Output Zone Filtering"; Rec."WIP Output Zone Filtering")
            //     {
            //         ApplicationArea = All;  // BC Upgrade NANDIS03
            //     }
            //     field("Enable CAD"; Rec."Enable CAD")
            //     {
            //         ApplicationArea = All;  // BC Upgrade NANDIS03
            //     }
            //     field("Posted Document Shipping Limit"; Rec."Posted Document Shipping Limit")
            //     {
            //         ApplicationArea = All;  // BC Upgrade NANDIS03
            //     }
            // }
            // BC Upgrade SHUKLP03 >> Moved in Interface Ext

        }
    }
    actions
    {
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("ChangeGlobalDimensions")
        {
            CaptionML = ENU = 'Change Global Dimensions', FRA = 'Modifier axes principaux';
            ToolTipML = ENU = 'Change either one or both of the global dimensions.', FRA = 'Modifiez un ou les deux axes principaux.';
        }
        modify("Change Payment &Tolerance")
        {
            CaptionML = ENU = 'Change Payment &Tolerance', FRA = '&Modifier écart de règlement';
            ToolTipML = ENU = 'Change either or both the maximum payment tolerance and the payment tolerance percentage and filters by currency.', FRA = 'Modifiez l''écart de règlement maximum, le pourcentage d''écart de règlement ou les deux et filtre par devise.';
        }
        modify("Accounting Periods")
        {
            CaptionML = ENU = 'Accounting Periods', FRA = 'Périodes comptables';
            ToolTipML = ENU = 'Set up the number of accounting periods, such as 12 monthly periods, within the fiscal year and specify which period is the start of the new fiscal year.', FRA = 'Paramétrez le nombre de périodes comptables, par exemple 12 périodes mensuelles, au cours de l''exercice et spécifiez quelle période marque le début du nouvel exercice.';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'Set up dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Configurez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("User Setup")
        {
            CaptionML = ENU = 'User Setup', FRA = 'Paramètres utilisateur';
            ToolTipML = ENU = 'Set up users to restrict access to post to the general ledger.', FRA = 'Paramétrez les utilisateurs afin de limiter l''accès pour valider en comptabilité.';
        }
        modify("Cash Flow Setup")
        {
            CaptionML = ENU = 'Cash Flow Setup', FRA = 'Paramètres trésorerie';
            ToolTipML = ENU = 'Set up the accounts where cash flow figures for sales, purchase, and fixed-asset transactions are stored.', FRA = 'Paramétrez les comptes dans lesquels sont enregistrés les chiffres de trésorerie pour les transactions de vente, d''achat et d''immobilisation.';
        }
        modify("Bank Export/Import Setup")
        {
            CaptionML = ENU = 'Bank Export/Import Setup', FRA = 'Paramètres exportation/importation bancaire';
            ToolTipML = ENU = 'Set up the formats for exporting vendor payments and for importing bank statements.', FRA = 'Paramétrez les formats pour l''exportation des paiements fournisseur et pour l''importation des relevés bancaires.';
        }
        modify("General Ledger Posting")
        {
            CaptionML = ENU = 'General Ledger Posting', FRA = 'Validation en comptabilité';
        }
        modify("General Posting Setup")
        {
            CaptionML = ENU = 'General Posting Setup', FRA = 'Paramètres comptabilisation';
            ToolTipML = ENU = 'Set up combinations of general business and general product posting groups by specifying account numbers for posting of sales and purchase transactions.', FRA = 'Paramétrez des combinaisons de groupes comptabilisation marché et comptabilisation produit en spécifiant les numéros de compte en vue de valider les transactions de vente ou d''achat.';
        }
        modify("Gen. Business Posting Groups")
        {
            CaptionML = ENU = 'Gen. Business Posting Groups', FRA = 'Groupes compta. marché';
            ToolTipML = ENU = 'Set up the trade-type posting groups that you assign to customer and vendor cards to link transactions with the appropriate general ledger account.', FRA = 'Paramétrez les groupes comptabilisation de type commercial que vous affectez aux fiches client et fournisseur afin de lier les transactions au compte général approprié.';
        }
        modify("Gen. Product Posting Groups")
        {
            CaptionML = ENU = 'Gen. Product Posting Groups', FRA = 'Groupes compta. produit';
            ToolTipML = ENU = 'Set up the item-type posting groups that you assign to customer and vendor cards to link transactions with the appropriate general ledger account.', FRA = 'Paramétrez les groupes comptabilisation de type article que vous affectez aux fiches client et fournisseur afin de lier les transactions au compte général approprié.';
        }
        modify("VAT Posting")
        {
            CaptionML = ENU = 'VAT Posting', FRA = 'Comptabilisation TVA';
        }
        modify("VAT Posting Setup")
        {
            CaptionML = ENU = 'VAT Posting Setup', FRA = 'Paramètres compta. TVA';
            ToolTipML = ENU = 'Set up how tax must be posted to the general ledger.', FRA = 'Paramétrez la manière dont la taxe doit être validée en comptabilité.';
        }
        modify("VAT Business Posting Groups")
        {
            CaptionML = ENU = 'VAT Business Posting Groups', FRA = 'Groupes compta. marché TVA';
            ToolTipML = ENU = 'Set up the trade-type posting groups that you assign to customer and vendor cards to link VAT amounts with the appropriate general ledger account.', FRA = 'Paramétrez les groupes comptabilisation de type commercial que vous affectez aux fiches client et fournisseur afin de lier les montants de TVA au compte général approprié.';
        }
        modify("VAT Product Posting Groups")
        {
            CaptionML = ENU = 'VAT Product Posting Groups', FRA = 'Groupes compta. produit TVA';
            ToolTipML = ENU = 'Set up the item-type posting groups that you assign to customer and vendor cards to link VAT amounts with the appropriate general ledger account.', FRA = 'Paramétrez les groupes comptabilisation de type article que vous affectez aux fiches client et fournisseur afin de lier les montants de TVA au compte général approprié.';
        }
        modify("VAT Report Setup")
        {
            CaptionML = ENU = 'VAT Report Setup', FRA = 'Paramétrage état TVA';
            ToolTipML = ENU = 'Set up number series and options for the report that you periodically send to the authorities to declare your VAT.', FRA = 'Paramétrez une souche de numéros et des options pour l''état que vous envoyez régulièrement aux autorités pour déclarer votre TVA.';
        }
        modify("Bank Posting")
        {
            CaptionML = ENU = 'Bank Posting', FRA = 'Validation bancaire';
        }
        modify("Bank Account Posting Groups")
        {
            CaptionML = ENU = 'Bank Account Posting Groups', FRA = 'Groupes compta. banque';
            ToolTipML = ENU = 'Set up posting groups, so that payments in and out of each bank account are posted to the specified general ledger account.', FRA = 'Paramétrez des groupes comptabilisation afin que les paiements entrants et sortants de chaque compte bancaire soient validés dans le compte général spécifié.';
        }
        modify("Journal Templates")
        {
            CaptionML = ENU = 'Journal Templates', FRA = 'Modèles feuille';
        }
        modify("General Journal Templates")
        {
            CaptionML = ENU = 'General Journal Templates', FRA = 'Modèles feuille comptabilité';
            ToolTipML = ENU = 'Set up templates for the journals that you use for bookkeeping tasks. Templates allow you to work in a journal window that is designed for a specific purpose.', FRA = 'Paramétrez des modèles pour les feuilles que vous utilisez pour les tâches de comptabilité. Ces modèles vous permettent de travailler dans une fenêtre feuille qui est conçue dans un but spécifique.';
        }
        modify("VAT Statement Templates")
        {
            CaptionML = ENU = 'VAT Statement Templates', FRA = 'Modèles déclaration TVA';
            ToolTipML = ENU = 'Set up the reports that you use to settle VAT and report to the customs and tax authorities.', FRA = 'Paramétrez les états que vous utilisez pour régler la TVA et effectuer les déclarations auprès des administrations douanières et fiscales.';
        }
        // modify("Intrastat Templates")
        // {
        //     CaptionML = ENU = 'Intrastat Templates', FRA = 'Modèles intracommunautaires';
        //     ToolTipML = ENU = 'Define how you want to set up and keep track of journals to report Intrastat.', FRA = 'Définissez la manière dont vous souhaitez paramétrer et suivre les feuilles afin de signaler les échanges intracommunautaires.';
        // }
        addafter("Change Payment &Tolerance")
        {
            separator(Separator2029610)
            {
            }
            action("Get Allowed Posting Range")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Get Allowed Posting Range',
                            FRA = 'Extraire plage de validation autorisée';
                Image = Ranges;
                //RunObject = Page "Allowed Posting Range";//BC Upgrade KAPOOV01-French Localization
                ShortCutKey = 'F7';
                ToolTip = 'Executes the Get Allowed Posting Range action.';
            }
            separator(Separator55012)
            {
            }
            action("Mail Standard Text")
            {
                CaptionML = ENU = 'Mail Standard Text',
                            FRA = 'Mail Texte standard';
                Description = 'FINXL7.00.001';
                ApplicationArea = All;
                ToolTip = 'Executes the Mail Standard Text action.';
                //RunObject = Page "Mail Standard Text List"; //BC Upgrade KAPOOV01-drink-it page
            }
        }
    }


    //Unsupported feature: PropertyModification on "Text001(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Do you want to change all open entries for every customer and vendor that are not blocked?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Do you want to change all open entries for every customer and vendor that are not blocked?;FRA=Souhaitez-vous modifier toutes les écritures ouvertes de tous les clients et fournisseurs non bloqués ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=If you delete the additional reporting currency, future general ledger entries are posted in LCY only. Deleting the additional reporting currency does not affect already posted general ledger entries.\\Are you sure that you want to delete the additional reporting currency?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=If you delete the additional reporting currency, future general ledger entries are posted in LCY only. Deleting the additional reporting currency does not affect already posted general ledger entries.\\Are you sure that you want to delete the additional reporting currency?;FRA=Si vous supprimez la devise report, les futures écritures comptables sont validées en DS uniquement. La suppression de la devise report n'a aucune incidence sur les écritures comptables déjà validées.\\Voulez-vous vraiment supprimer la devise report ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=If you change the additional reporting currency, future general ledger entries are posted in the new reporting currency and in LCY. To enable the additional reporting currency, a batch job opens, and running the batch job recalculates already posted general ledger entries in the new additional reporting currency.\Entries will be deleted in the Analysis View if it is unblocked, and an update will be necessary.\\Are you sure that you want to change the additional reporting currency?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=If you change the additional reporting currency, future general ledger entries are posted in the new reporting currency and in LCY. To enable the additional reporting currency, a batch job opens, and running the batch job recalculates already posted general ledger entries in the new additional reporting currency.\Entries will be deleted in the Analysis View if it is unblocked, and an update will be necessary.\\Are you sure that you want to change the additional reporting currency?;FRA=Si vous modifiez la devise report, les futures écritures comptables sont validées dans la nouvelle devise report et en DS. Pour activer la devise report, un traitement par lots s'ouvre et son exécution entraîne le recalcul des écritures comptables déjà validées dans la nouvelle devise report.\Les écritures seront supprimées dans la vue d'analyse si elle est débloquée et une mise à jour sera alors nécessaire.\\Útes-vous sûr de vouloir modifier la devise report ?;
    //Variable type has not been exported.

    var
        GiftboxEditable: Boolean;


    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //begin
    /*
    // <<DITW18.00.06 DDR 23/10/2015 DIT-770 #1395
    GiftboxEditable := ("Calculate GiftBox Charges from" <> "Calculate GiftBox Charges from"::" ");
    // >>DITW18.00.06 DDR DIT-770 #1395
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RESET;
    IF NOT GET THEN BEGIN
      INIT;
      INSERT;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    RESET;
    if not GET then begin
      INIT;
      INSERT;
    end;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

