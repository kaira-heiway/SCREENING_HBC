pageextension 51011 GLAccountCardExtCBN extends "G/L Account Card"
{
    // version NAVW110.0.00.16177,FINXL9.00.000.01,DITW110.00.08,HEI.04,HEI.18
    //     DITW15.00.00.01 DDR 22/01/2008 Added Drink-it functionnalities
    //                                Added field "Collapse"
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327 Added fields "DIT Sub-Contract Posting Type" (Drink-It tab)
    // FINXL7.00.001 RBE 20/03/2013 : Added field "No. 2" on Page
    //                                Added following fields: "Auto. Acc. Group"
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // FINXL9.00.001 DAT 07/03/2016 : Extend Master Property functionalities
    // DITW18.00.07 AKH 22/03/2016 DIT-770 #1805 Merge FINXL extended master data properties
    // DITW19.00.08 SFI 18/08/2016 BL#10868  (DIT-770 #2141) Added field 2014411 "Allow Invoice Disc." to Group "Drink IT"
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7

    // HEI.01 FDD RTRGAP062 Heilite BASE IBM ISYED01 04/08/2017 HeiMatch Flatfile
    //   # Added new filed Std. Invoice Reference
    //   # Added new filed "HeiMatch Code"
    //   # Added new filed "Export HeiMatch Payments"
    // HEI.02 RTRGAP038 IBM.CHAUHB01 05/08/17
    //  # Added Field in GL Account Card
    // HEI.03 RTRGAP047 IBM.ISYED01 07/08/17
    //  # Added Field in CIL Account
    //  # Added Field in Local Name
    // HEI.04 FDD-SLSGAP001 IBM POENAB01 19.08.2017 # MDM Customer Card
    //   # added "WHT Business Posting Group" and "WHT Product Posting Group" in Posting Group
    // HEI.05 FDD-BPMGAP014 IBM ISYED01 24.08.2017
    //   #Added added new field "No Trading Partner","Posting Heineken","CIL3 Code","MR Code" to page
    // HEI.06 FDD-RTRGAP001 IBM CHAUHB01 18.09.2017
    //   #Added fileds Cadency Transaction Export
    // HEI.08 FDD-HT670 IBM BULIMC01 30.09.2019 #new field "VAT account" displayed
    // HEI.09 FDD-HT671 IBM BULIMC01 07.10.2019 #new field "WHT account" displayed
    // HEI.10 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New action: Navigate -> "Apply Enties"
    //   # Code added in OnOpenPage()
    // HEI.11 CHG2021732 FDD-HB755 IBM.GUNERE01 03.12.2019 # CMG Mappings PageAction added
    // HEI.12 FDD-HT1143 SURYAS01  02.07.2020
    //   #Created New Field "Non Deductible VAT %"
    // HEI.13 CHG2065276 BULIMC01 IBM 29.09.2020 #new field added to Automatic Application tab - "Same Comment"
    // HEI.14 CHG0248106 IBM POENAB02 30.03.2020 # HeiMatch Export Inv. & Balance
    //  # Added field "Heimatch Sign" in Posting Group
    // HEi.15 CHG2093754 IBM PANDES01 23.02.2021
    //   # Added New field "C&TP CODE".
    // HEI.16 CHG2255465 IBM YADAVM09 19/06/2024 # Change required in HeiMatch sign values in COA
    // New boolean variable created "HeiMatchEditable" to make HeiMatch Sign editable depending on HeiMatch Code
    // HEI.17 CHG2224401 HB3624 YADAVM09 09.02.2024 Health and Security Levy Tax
    //   # New Field Added #H&S Levy Tax Posting Group
    // HEI.18 CHG2210794 MAJUMS03 21.03.2024 Zycus - BASE HL Integration Master Vendor and GL Account.
    //   # New Page Action ZycusTimeStamp is added to view the related Zycus Time Stamp Entry via Zycus Master Timestamp Page of the
    //   specific GL Account to show when the Last Zycus related record is Inserted or Deleted or Renamed and fields are Modified.

    // BC Upgrade SHUKLP03 >>
    // action("ZycusTime Stamp") shared with Sakshi.
    // BC Upgrade SHUKLP03 <<

    //Bc Upgrade YADAVM09 Automatic Application tab is corrected
    //BC UPGRADE KUMARR78 FDD-MTC-008 >>
    //1. Adding Show Item charge on Invoice Field
    //BC UPGRADE KUMARR78 FDD-MTC-008 <<

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the No. of the G/L Account you are setting up.', FRA = 'Spécifie le N° du compte général que vous configurez.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name of the general ledger account.', FRA = 'Spécifie le nom du compte général.';
        }
        modify("Income/Balance")
        {
            ToolTipML = ENU = 'Specifies whether a general ledger account is an income statement account or a balance sheet account.', FRA = 'Spécifie si un compte général est un compte résultats ou un compte de bilan.';
        }
        modify("Account Category")
        {
            ToolTipML = ENU = 'Specifies the category of the G/L account.', FRA = 'Spécifie la catégorie du compte général.';
        }
        modify(SubCategoryDescription)
        {
            CaptionML = ENU = 'Account Subcategory', FRA = 'Sous-catégorie du compte';
            ToolTipML = ENU = 'Specifies the subcategory of the account category of the G/L account.', FRA = 'Spécifie la sous-catégorie de la catégorie du compte du compte général.';
        }
        modify("Debit/Credit")
        {
            ToolTipML = ENU = 'Specifies the type of entries that will normally be posted to this general ledger account.', FRA = 'Spécifie le type d''écriture qui est normalement validée sur ce compte général.';
        }
        modify("Account Type")
        {
            ToolTipML = ENU = 'Specifies the purpose of the account. Newly created accounts are automatically assigned the Posting account type, but you can change this.', FRA = 'Spécifie l''objet du compte. Les comptes nouvellement créés sont automatiquement affectés au type de compte Comptabilisation, mais vous pouvez le modifier.';
        }
        modify(Totaling)
        {
            ToolTipML = ENU = 'Specifies an account interval or a list of account numbers.', FRA = 'Spécifie un intervalle de comptes ou une liste de numéros de compte.';
        }
        modify("No. of Blank Lines")
        {
            ToolTipML = ENU = 'Specifies the number of blank lines that you want inserted before this account in the chart of accounts.', FRA = 'Spécifie le nombre de lignes blanches que vous souhaitez insérer avant ce compte dans le plan comptable.';
        }
        modify("New Page")
        {
            ToolTipML = ENU = 'Specifies whether you want a new page to start immediately after this general ledger account when you print the chart of accounts. Select this field to start a new page after this general ledger account.', FRA = 'Spécifie si vous souhaitez qu''une nouvelle page commence immédiatement après ce compte général lorsque vous imprimez le plan comptable. Sélectionnez ce champ pour commencer une nouvelle page après ce compte général.';
        }
        modify("Search Name")
        {
            ToolTipML = ENU = 'Specifies a search name.', FRA = 'Spécifie un nom de recherche.';
        }
        modify(Balance)
        {
            ToolTipML = ENU = 'Specifies the balance on this account.', FRA = 'Spécifie le solde du compte.';
        }
        modify("Automatic Ext. Texts")
        {
            ToolTipML = ENU = 'Specifies that an extended text will be added automatically to the account.', FRA = 'Spécifie qu''un texte étendu est automatiquement ajouté au compte.';
        }
        modify("Direct Posting")
        {
            ToolTipML = ENU = 'Specifies whether you will be able to post directly or only indirectly to this general ledger account. To allow Direct Posting to the G/L account, place a check mark in the check box.', FRA = 'Spécifie si vous pouvez choisir d''enregistrer directement ou uniquement indirectement sur ce compte général. Pour autoriser une imputation directe, cochez la case.';
        }
        modify(Blocked)
        {
            ToolTipML = ENU = 'Specifies that entries cannot be posted to the G/L account.', FRA = 'Spécifie que les écritures ne peuvent pas être validées sur le compte général.';
        }
        modify("Last Date Modified")
        {
            ToolTipML = ENU = 'Specifies when the G/L account was last modified.', FRA = 'Spécifie la date de la dernière modification du compte général.';
        }
        modify("Omit Default Descr. in Jnl.")
        {
            ToolTipML = ENU = 'Specifies if the default description is automatically inserted in the Description field on journal lines created for this general ledger account.', FRA = 'Spécifie si la description par défaut est automatiquement insérée dans le champ Description sur les lignes feuille créées pour ce compte général.';
        }
        modify(Posting)
        {
            CaptionML = ENU = 'Posting', FRA = 'Validation';
        }
        modify("Gen. Posting Type")
        {
            ToolTipML = ENU = 'Specifies the general posting type to use when posting to this account.', FRA = 'Spécifie le type de validation à utiliser lors de la validation sur ce compte.';
        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general business posting group that applies to the entry.', FRA = 'Spécifie le groupe comptabilisation marché qui s''applique à cette écriture.';
        }
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a general product posting group code.', FRA = 'Spécifie un code groupe comptabilisation produit.';
        }
        modify("VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a VAT Bus. Posting Group.', FRA = 'Spécifie un Groupe compta. marché TVA.';
        }
        modify("VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a VAT Prod. Posting Group code.', FRA = 'Spécifie un code Groupe compta. produit TVA.';
        }
        modify("Default IC Partner G/L Acc. No")
        {
            ToolTipML = ENU = 'Specifies accounts that you often enter in the Bal. Account No. field on intercompany journal or document lines.', FRA = 'Spécifie des comptes que vous entrez régulièrement dans le champ N° compte contrepartie de la feuille intersociété ou des lignes de document.';
        }
        modify("Default Deferral Template Code")
        {
            CaptionML = ENU = 'Default Deferral Template', FRA = 'Modèle échelonnement par défaut';
            ToolTipML = ENU = 'Specifies the default deferral template that governs how to defer revenues and expenses to the periods when they occurred.', FRA = 'Spécifie le modèle d''échelonnement par défaut qui régit la manière de reporter les revenus et les dépenses aux périodes auxquelles ils se sont produits.';
        }
        modify(Consolidation)
        {
            CaptionML = ENU = 'Consolidation', FRA = 'Consolidation';
        }
        modify("Consol. Debit Acc.")
        {
            ToolTipML = ENU = 'Specifies the number of the account in a consolidated company to which to transfer debit balances on this account.', FRA = 'Spécifie le numéro de compte d''une société consolidée vers laquelle transférer tous les soldes débit de ce compte.';
        }
        modify("Consol. Credit Acc.")
        {
            ToolTipML = ENU = 'Specifies the number of the account in a consolidated company to which to transfer credit balances on this account.', FRA = 'Spécifie le numéro de compte d''une société consolidée vers laquelle transférer tous les soldes crédit de ce compte.';
        }
        modify("Consol. Translation Method")
        {
            ToolTipML = ENU = 'Specifies the account''s consolidation translation method, which identifies the currency translation rate to be applied to the account.', FRA = 'Spécifie la méthode de traduction de consolidation qui identifie le taux de conversion de devise à appliquer au compte.';
        }
        modify(Reporting)
        {
            CaptionML = ENU = 'Reporting', FRA = 'Génération d''états';
        }
        modify("Exchange Rate Adjustment")
        {
            ToolTipML = ENU = 'Specifies how general ledger accounts will be adjusted for exchange rate fluctuations between LCY and the additional reporting currency.', FRA = 'Spécifie comment des comptes généraux seront ajustés pour les fluctuations de taux de change entre devise société et la devise report.';
        }
        modify("Cost Accounting")
        {
            CaptionML = ENU = 'Cost Accounting', FRA = 'Comptabilité analytique';
        }
        modify("Cost Type No.")
        {
            ToolTipML = ENU = 'Specifies a cost type number to establish which cost type a general ledger account belongs to.', FRA = 'Spécifie un numéro de type de coût pour connaître le type de coût auquel appartient un compte général.';
        }

        //Unsupported feature: Change SubPageLink on "Control1905532107(Control 1905532107)". Please convert manually.


        //Unsupported feature: CodeInsertion on ""Account Category"(Control 11)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        CurrPage.UPDATE;
        */
        //end;


        //Unsupported feature: CodeModification on "Totaling(Control 16).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        OldText := Text;
        GLAccountList.LOOKUPMODE(TRUE);
        IF NOT (GLAccountList.RUNMODAL = ACTION::LookupOK) THEN
          EXIT(FALSE);

        Text := OldText + GLAccountList.GetSelectionFilter;
        EXIT(TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        OldText := Text;
        GLAccountList.LOOKUPMODE(true);
        if not (GLAccountList.RUNMODAL = ACTION::LookupOK) then
          exit(false);

        Text := OldText + GLAccountList.GetSelectionFilter;
        exit(true);
        */
        //end;
        addafter("No.")
        {
            // field("No. 2"; "No. 2")
            // {
            //     Description = 'FINXL7.00.001';
            // }  // BC Upgrade NANDIS03
        }
        addafter(Name)
        {
            field("Local Name"; Rec."Local Name FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Local Name field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Local Name field.';

            }
            field("Financial Statement version"; Rec."Financial Stmt version FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Financial Statement version field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Financial Statement version field.';

            }
        }
        addafter("Omit Default Descr. in Jnl.")
        {
            field("CIL account"; Rec."CIL account FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CIL account field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the CIL account field.';

            }
            field("VAT Account"; Rec."VAT Account FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT Account field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the VAT Account field.';

            }
            field("WHT Account"; Rec."WHT Account FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the WHT Account field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the WHT Account field.';

            }
            field("Non Deductible VAT %"; Rec."Non Deductible VAT % FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Non Deductible VAT % field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Non Deductible VAT % field.';

            }
        }
        addfirst(Posting)
        {
            field("HeiMatch Code"; Rec."HeiMatch Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the HeiMatch Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the HeiMatch Code field.';

                trigger OnValidate();
                begin
                    EditHeiMatchSign(); //HEI.16
                end;
            }
            field("Heimatch Sign"; Rec."Heimatch Sign FND")
            {
                Editable = HeiMatchEditable;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Heimatch Sign field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Heimatch Sign field.';

            }
        }
        addafter("VAT Prod. Posting Group")
        {
            // field("Auto. Acc. Group"; "Auto. Acc. Group")
            // {
            //     Description = 'FINXL7.00.001';
            // }  // BC Upgrade NANDIS03
        }
        addafter("Default Deferral Template Code")
        {
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the WHT Business Posting Group field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the WHT Business Posting Group field.';

            }
            field("WHT Product Posting Group"; Rec."WHT Product Posting Group FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the WHT Product Posting Group field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the WHT Product Posting Group field.';

            }
            field("Posting Heineken"; Rec."Posting Heineken FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posting Heineken field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Posting Heineken field.';

            }
            field("H&S Levy Tax Posting Group"; Rec."H&S Levy Tax Posting Group FND")
            {
                Visible = EnableHSLevy;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the H&S Levy Tax Posting Group field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the H&S Levy Tax Posting Group field.';

            }
        }
        addafter("Exchange Rate Adjustment")
        {
            field("Export HeiMatch Payments"; Rec."Export HeiMatch Payments FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Export HeiMatch Payments field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Export HeiMatch Payments field.';

            }
            field("CIL3 Code"; Rec."CIL3 Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CIL3 Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the CIL3 Code field.';

            }
            field("No Trading Partner"; Rec."No Trading Partner FND")
            {
                Description = 'HEI:EDD072';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the No Trading Partner field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the No Trading Partner field.';

            }
            field("MR Code"; Rec."MR Code FND")
            {
                Description = 'HEI:EDD072';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MR Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the MR Code field.';

            }
            field("Cadency Transaction Export"; Rec."Cadency Transaction Export FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Cadency Transaction Export field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Cadency Transaction Export field.';

            }
            field("C&TP CODE"; Rec."C&TP CODE FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the C&TP CODE field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the C&TP CODE field.';

            }
        }
        addafter("Cost Type No.")
        {
            field("Acc Type"; Rec."Acc Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Acc Type field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Acc Type field.';

            }
            group("Drink-It")
            {
                CaptionML = ENU = 'Drink-It',
                            FRA = 'Drink-It';
                // field(Collapse; Collapse)
                // {
                //     Importance = Promoted;
                // }
                // field("DIT Sub-Contract Posting Type"; "DIT Sub-Contract Posting Type")
                // {
                //     OptionCaptionML = ENU = ' ,Rent,Loan,Loan in use,,Other,,,,,,All',
                //                       FRA = ' ,Location,Prêt,Mise à disposition,,Divers,,,,,,Tous';
                // }
                // field("Allow Invoice Disc."; "Allow Invoice Disc.")
                // {
                // }  // BC Upgrade NANDIS03
                //BC UPGRADE KUMARR78 FDD-MTC-008 >>   
                field("Show Item charge on Invoice"; Rec."Show Item charge on Inv. FND")
                {
                    ApplicationArea = all;
                }
                //BC UPGRADE KUMARR78 FDD-MTC-008 <<
            }
            // group(Properties)
            // {
            //     CaptionML = ENU = 'Properties',
            //                 FRA = 'Propriétés';
            //     field("Shortcut Property 1 Code"; "Shortcut Property 1 Code")
            //     {
            //     }
            //     field("Shortcut Property 2 Code"; "Shortcut Property 2 Code")
            //     {
            //     }
            //     field("Shortcut Property 3 Code"; "Shortcut Property 3 Code")
            //     {
            //     }
            //     field("Shortcut Property 4 Code"; "Shortcut Property 4 Code")
            //     {
            //     }
            //     field("Shortcut Property 5 Code"; "Shortcut Property 5 Code")
            //     {
            //     }
            //     field("Shortcut Property 6 Code"; "Shortcut Property 6 Code")
            //     {
            //     }
            //     field("Shortcut Property 7 Code"; "Shortcut Property 7 Code")
            //     {
            //     }
            //     field("Shortcut Property 8 Code"; "Shortcut Property 8 Code")
            //     {
            //     }
            //     field("Shortcut Property 9 Code"; "Shortcut Property 9 Code")
            //     {
            //     }
            //     field("Shortcut Property 10 Code"; "Shortcut Property 10 Code")
            //     {
            //     }
            // }  // BC Upgrade NANDIS03
        }
        addafter("Cost Accounting")
        {
            group("Automatic Application")
            {
                Caption = 'Automatic Application';

                field("Authorize other App. Modes"; Rec."Authorize other App. Modes FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Authorize other App. Modes field.';
                    // BC Upgrade NANDIS03                      ToolTip = 'Specifies the value of the Authorize other App. Modes field.';

                }
                field("Same Amount"; Rec."Same Amount FND")
                {
                    Editable = Rec."Automatic application mode FND" = Rec."Automatic application mode FND"::"Selection Criteria";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Same Amount field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Same Amount field.';

                }
                field("Same Remaining Amount"; Rec."Same Remaining Amount FND")
                {
                    Editable = Rec."Automatic application mode FND" = Rec."Automatic application mode FND"::"Selection Criteria";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Same Remaining Amount field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Same Remaining Amount field.';

                }
                field("Same Document No."; Rec."Same Document No. FND")
                {
                    Editable = Rec."Automatic application mode FND" = Rec."Automatic application mode FND"::"Selection Criteria";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Same Document No. field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Same Document No. field.';

                }
                field("Same External Document No."; Rec."Same External Document No. FND")
                {
                    Editable = Rec."Automatic application mode FND" = Rec."Automatic application mode FND"::"Selection Criteria";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Same External Document No. field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Same External Document No. field.';

                }
                field("Same Comment"; Rec."Same Comment FND")
                {
                    Editable = Rec."Automatic application mode FND" = Rec."Automatic application mode FND"::"Selection Criteria";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Same Comment field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Same Comment field.';

                }
                field("Automatic application mode"; Rec."Automatic application mode FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Automatic application mode field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Automatic application mode field.';

                }
            }
        }

    }
    actions
    {
        modify("A&ccount")
        {
            CaptionML = ENU = 'A&ccount', FRA = '&Compte';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
            ToolTipML = ENU = 'View the history of transactions that have been posted for the selected record.', FRA = 'Affichez l''historique des transactions qui ont été validées pour l''enregistrement sélectionné.';

            //Unsupported feature: Change RunPageView on ""Ledger E&ntries"(Action 41)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Ledger E&ntries"(Action 41)". Please convert manually.

        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
            ToolTipML = ENU = 'View or add comments to the account.', FRA = 'Affichez ou ajoutez des commentaires au compte.';

            //Unsupported feature: Change RunPageLink on ""Co&mments"(Action 38)". Please convert manually.

        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';

            //Unsupported feature: Change RunPageLink on "Dimensions(Action 84)". Please convert manually.

        }
        modify("E&xtended Texts")
        {
            CaptionML = ENU = 'E&xtended Texts', FRA = '&Textes étendus';
            ToolTipML = ENU = 'Set up additional text for the description of the selected item. Extended text can be inserted under the Description field on document lines for the item.', FRA = 'Définissez un texte supplémentaire pour la description de l''article sélectionné. Un texte plus long peut être inséré sous le champ Description sur les lignes document de l''article.';

            //Unsupported feature: Change RunPageView on ""E&xtended Texts"(Action 166)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""E&xtended Texts"(Action 166)". Please convert manually.

        }
        modify("Receivables-Payables")
        {
            CaptionML = ENU = 'Receivables-Payables', FRA = 'Échéancier';
            ToolTipML = ENU = 'View a summary of the receivables and payables for the account, including customer and vendor balance due amounts.', FRA = 'Affichez un résumé des clients et des fournisseurs pour le compte, dont les montants dus du solde client et fournisseur.';
        }
        modify("Where-Used List")
        {
            CaptionML = ENU = 'Where-Used List', FRA = 'Liste des cas d''emploi';
            ToolTipML = ENU = 'View setup tables where a general ledger account is used.', FRA = 'Affichez les tables paramètres dans lesquelles un compte général est utilisé.';
        }
        modify("&Balance")
        {
            CaptionML = ENU = '&Balance', FRA = 'Sol&de';
        }
        modify("G/L &Account Balance")
        {
            CaptionML = ENU = 'G/L &Account Balance', FRA = 'Solde &compte général';
            ToolTipML = ENU = 'View a summary of the debit and credit balances for different time periods, for the account that you select in the chart of accounts.', FRA = 'Affichez un résumé des soldes débiteurs et créditeurs pour différentes périodes, pour le compte que vous sélectionnez dans le plan comptable.';

            //Unsupported feature: Change RunPageLink on ""G/L &Account Balance"(Action 46)". Please convert manually.

        }
        modify("G/L &Balance")
        {
            CaptionML = ENU = 'G/L &Balance', FRA = '&Solde par compte';
            ToolTipML = ENU = 'View a scrollable summary of the debit and credit balances for all the accounts in the chart of accounts, for the time period that you select.', FRA = 'Affichez un résumé, dans lequel vous pouvez défiler, des soldes débiteurs et créditeurs pour tous les comptes dans le plan de comptes, pour la période que vous sélectionnez.';
        }
        modify("G/L Balance by &Dimension")
        {
            CaptionML = ENU = 'G/L Balance by &Dimension', FRA = 'Solde par &axe';
            ToolTipML = ENU = 'View a summary of the debit and credit balances by dimensions for the current account.', FRA = 'Affichez un résumé des soldes débit et crédit par axe pour le compte actuel.';
        }
        modify("General Posting Setup")
        {
            CaptionML = ENU = 'General Posting Setup', FRA = 'Paramètres comptabilisation';
            ToolTipML = ENU = 'View or edit how you want to set up combinations of general business and general product posting groups.', FRA = 'Affichez ou modifiez la manière dont vous souhaitez configurer des combinaisons de groupes comptabilisation marché et produit.';
        }
        modify("VAT Posting Setup")
        {
            CaptionML = ENU = 'VAT Posting Setup', FRA = 'Paramètres compta. TVA';
            ToolTipML = ENU = 'View or edit combinations of Tax business posting groups and Tax product posting groups.', FRA = 'Affichez ou modifiez des combinaisons de Groupes compta. marché TVA et de Groupes compta. produit TVA.';
        }
        modify("G/L Register")
        {
            CaptionML = ENU = 'G/L Register', FRA = 'Historique des transactions comptabilité';
            ToolTipML = ENU = 'View posted G/L entries.', FRA = 'Affichez les écritures comptables validées.';
        }
        modify(DocsWithoutIC)
        {
            CaptionML = ENU = 'Posted Documents without Incoming Document', FRA = 'Documents validés sans document entrant';
            ToolTipML = ENU = 'Show a list of posted purchase and sales documents under the G/L account that do not have related incoming document records.', FRA = 'Affichez une liste des documents ventes et achats validés sous le compte général qui n''a pas d''enregistrement de document entrant associé.';
        }
        modify("Detail Trial Balance")
        {
            CaptionML = ENU = 'Detail Trial Balance', FRA = 'Grand livre';
            ToolTipML = ENU = 'View detail general ledger account balances and activities for all the selected accounts, one transaction per line.', FRA = 'Affichez les activités et les soldes comptes généraux détaillés pour tous les comptes sélectionnés, une transaction par ligne.';
        }
        modify("Trial Balance")
        {
            CaptionML = ENU = 'Trial Balance', FRA = 'Balance';
            ToolTipML = ENU = 'View general ledger account balances and activities for all the selected accounts, one transaction per line.', FRA = 'Affichez les activités et les soldes comptes généraux pour tous les comptes sélectionnés, une transaction par ligne.';
        }
        modify("Trial Balance by Period")
        {
            CaptionML = ENU = 'Trial Balance by Period', FRA = 'Balance par période';
            ToolTipML = ENU = 'View general ledger account balances and activities for all the selected accounts, one transaction per line for a selected period.', FRA = 'Affichez les activités et les soldes comptes généraux pour tous les comptes sélectionnés, une transaction par ligne pour une période sélectionnée.';
        }
        modify(Action1900210206)
        {
            CaptionML = ENU = 'G/L Register', FRA = 'Historique des transactions comptabilité';
            ToolTipML = ENU = 'View posted G/L entries.', FRA = 'Affichez les écritures comptables validées.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Apply Template")
        {
            CaptionML = ENU = 'Apply Template', FRA = 'Appliquer modèle';
            ToolTipML = ENU = 'Select a configuration template to quickly create a general ledger account.', FRA = 'Sélectionnez un modèle de configuration pour créer rapidement un compte général.';
        }


        //Unsupported feature: CodeModification on "DocsWithoutIC(Action 15).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Account Type" = "Account Type"::Posting THEN
          PostedDocsWithNoIncBuf.SETRANGE("G/L Account No. Filter","No.")
        else
          IF Totaling <> '' THEN
            PostedDocsWithNoIncBuf.SETFILTER("G/L Account No. Filter",Totaling)
          else
            EXIT;
        PAGE.RUN(PAGE::"Posted Docs. With No Inc. Doc.",PostedDocsWithNoIncBuf);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Account Type" = "Account Type"::Posting then
          PostedDocsWithNoIncBuf.SETRANGE("G/L Account No. Filter","No.")
        else
          if Totaling <> '' then
            PostedDocsWithNoIncBuf.SETFILTER("G/L Account No. Filter",Totaling)
          else
            exit;
        PAGE.RUN(PAGE::"Posted Docs. With No Inc. Doc.",PostedDocsWithNoIncBuf);
        */
        //end;
        addafter("Where-Used List")
        {
            action("Apply Entries")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Apply Entries',
                            FRA = 'Lettrer écritures';
                Enabled = FRLocAction;
                Image = ApplyEntries;
                // RunObject = Page "Apply G/L Entries";
                // RunPageLink = "G/L Account No." = FIELD("No.");  // BC Upgrade NANDIS03
                ShortCutKey = 'Shift+F11';
                Visible = FRLocAction;
                ToolTip = 'Executes the Apply Entries action.';
            }
            action(Properties)
            {
                CaptionML = ENU = 'Properties',
                            FRA = 'Propriétés';
                Description = 'FINXL9.00';
                Image = Category;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Executes the Properties action.';
                // RunObject = Page "Master Data Properties";
                // RunPageLink = "Table ID" = CONST(15),
                //               Code = FIELD("No.");  // BC Upgrade NANDIS03
            }
        }
        addafter("Apply Template")
        {
            action("CMG Mappings CBN")
            {
                ApplicationArea = All;
                Caption = 'CMG Mappings';
                Image = MapAccounts;
                RunObject = Page "CMG Mappings CBN";
                RunPageLink = "G/L Account" = FIELD("CIL3 Code FND");
                ToolTip = 'Executes the CMG Mappings action.';
            }
        }
    }

    var
        //HeinekenGlobal: Codeunit "Heineken Global";
        CompanyInfo: Record "Company Information";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        EnableHSLevy: Boolean;
        FRLocAction: Boolean;
        HeiMatchEditable: Boolean;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        EditHeiMatchSign(); //HEI.16
                            //HEI.17>>
        PurchasesPayablesSetup.GET();
        EnableHSLevy := PurchasesPayablesSetup."H&S Levy Tax FND";
        //HEI.17<<
    end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //begin
    /*
    //HEI.10>>
    FRLocAction := false;
    CompanyInfo.GET;
    if CompanyInfo."Enable French Localization" then
      FRLocAction := true;
    //HEI.10<<

    //HEI.17>>
    PurchasesPayablesSetup.GET;
    EnableHSLevy := PurchasesPayablesSetup."H&S Levy Tax";
    //HEI.17<<
    EditHeiMatchSign; //HEI.16
    */
    //end;

    local procedure EditHeiMatchSign();
    begin
        //HEI.16<<
        if Rec."HeiMatch Code FND" = '' then
            HeiMatchEditable := false
        else
            HeiMatchEditable := true;
        //HEI.16>>
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

