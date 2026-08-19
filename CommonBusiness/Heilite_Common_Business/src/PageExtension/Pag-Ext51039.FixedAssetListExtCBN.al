pageextension 51039 FixedAssetListExtCBN extends "Fixed Asset List"
{
    // DITW15.00.00.35 DDR 01/09/2009 Added fields
    //                                  "Created by Service Item No.","Description 2","FA Template Code",
    //                                  "Exist Service Items"
    //                                Added 'Service Item List' menu into 'Fixed Asset' button
    // DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327 Added fields  "DIT Contract No.","Customer No."
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename Field  "DIT Contract No." => Financial Contract No.
    // FINXL9.00.001 DAT 07/03/2016 : Extend Master Property functionalities
    // DITW18.00.07 AKH 22/03/2016 DIT-770 #1805 Merge FINXL extended master data properties

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD RTRGAP057 IBM HORTOC01 29.07.2017
    //   # add new function to check/change Fa. Indicator
    // HEI.02 FDD RTRGAP014 IBM COSTES02 04.08.2017
    //   # add new actions: FA Book Val. Trial Balance,G/L Analysis - Trial Balance
    // HEI.03 FDD RTRGAP057 IBM POENAB01 14.08.2017
    //   # check Fa. Indicator when getting a new record
    // HEI.04 FDD_CHG0246293 IBM ISYED01 10.10.2018 #Asset Quantity and Tag No info in FA Card  to incl. Quantiy, Tag No.
    //   # new filed Quantity and Tag No added to Page
    // version NAVW110.0,FINXL9.00.000.01,DITW110.00.08,HEI.01,HEI.02

    //---------------------------------------------------------------------------------------------------------------------------
    //BC Upgrade KAPOOV01 18.12.2025 #Commented Drink-It fields & actions
    //BC Upgrade KAPOOV01 Added code that was added under SOICAD Tag on trigger-OnAfterGetRecord
    //Bc Upgrade YADAVM09 Page action Service item charge unblocked and Action property added.
    // BC Upgrade BHARDA11 ---- Whenever the base report “Copy Fixed Asset” is run, the report “Copy Fixed Asset 2” will be executed instead, as it has been configured in the OnSubstituteReport event. This substitution was required due to existing customizations in the base report.
    // BC Upgrade BHARDA11 >>
    // 1. Standard report "Fixed Asset - Book Value 01" is substituted via OnAfterSubstituteReport event.Custom report "Fixed Asset - Book Value 01New" will run instead.
    // 2. Standard report "Fixed Asset - Book Value 02" is substituted via OnAfterSubstituteReport event.Custom report "Fixed Asset - Book Value 02New" will run instead.
    // BC Upgrade BHARDA11 <<

    // BC Upgrade POENAB02, 01.04.2026, FDD "Mass FA Creation"
    // added action "FA Upload"

    //POENAB02, 10.07.2026, Removed "Global Dimension 1 Code", as it was already added by Aptean
    //Bc Upgrade YADAVM09 BCUP0-200 Custom report added for Action Calulate Depriciation and base action visisble false.
    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies a number for the fixed asset.', FRA = 'Indique un numéro d''immobilisation.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the fixed asset.', FRA = 'Spécifie une description de l''immobilisation.';
        }
        modify("Vendor No.")
        {
            ToolTipML = ENU = 'Specifies the number of the vendor from which you purchased this fixed asset.', FRA = 'Spécifie le numéro du fournisseur auquel vous avez acheté l''immobilisation.';
        }
        modify("Maintenance Vendor No.")
        {
            ToolTipML = ENU = 'Specifies the number of the vendor who performs repairs and maintenance on the fixed asset.', FRA = 'Spécifie le numéro du fournisseur qui effectue les réparations et la maintenance de l''immobilisation.';
        }
        modify("Responsible Employee")
        {
            ToolTipML = ENU = 'Specifies which employee is responsible for the fixed asset.', FRA = 'Spécifie le nom du salarié responsable de l''immobilisation.';
        }
        modify("FA Class Code")
        {
            ToolTipML = ENU = 'Specifies the class that the fixed asset belongs to.', FRA = 'Spécifie une classe à laquelle l''immobilisation appartient.';
        }
        modify("FA Subclass Code")
        {
            ToolTipML = ENU = 'Specifies the subclass of the class that the fixed asset belongs to.', FRA = 'Spécifie une sous-classe de la classe à laquelle l''immobilisation appartient.';
        }
        modify("FA Location Code")
        {
            ToolTipML = ENU = 'Specifies the location, such as a building, where the fixed asset is located.', FRA = 'Spécifie l''emplacement, par exemple un immeuble, où se trouve l''immobilisation.';
        }
        modify("Budgeted Asset")
        {
            ToolTipML = ENU = 'Specifies if the asset is for budgeting purposes.', FRA = 'Indique si l''immobilisation est budgétée.';
        }
        modify("Search Description")
        {
            ToolTipML = ENU = 'Specifies a search description for the fixed asset.', FRA = 'Spécifie une description de recherche de l''immobilisation.';
        }
        modify(Acquired)
        {
            ToolTipML = ENU = 'Specifies that the fixed asset has been acquired.', FRA = 'Spécifie si l''immobilisation a été acquise.';
        }
        //POENAB02, 10.07.2026>>
        /*
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Description 2 field.';
            }
        }
        */
        //POENAB02, 10.07.2026<<
        addafter("Budgeted Asset")
        {
            //BC Upgrade KAPOOV01-drink-it>>
            // field("Created by Service Item No."; "Created by Service Item No.")
            // {
            //     Visible = false;
            // }
            // field("FA Template Code"; "FA Template Code")
            // {
            //     Visible = false;
            // }
            // field("Exist Service Items"; "Exist Service Items")
            // {
            // }
            // field("DIT Sub-Contract Type"; "DIT Sub-Contract Type")
            // {
            //     Description = 'DIT-715 #327';
            // }
            // field("Financial Contract No."; "Financial Contract No.")
            // {
            //     Description = 'DIT-715 #327';
            // }
            // field("Customer No."; "Customer No.")
            // {
            //     Description = 'DIT-715 #327';
            // }
            // field("Customer Name"; "Customer Name")
            // {
            //     Description = 'DIT-715 #327';
            //     Visible = false;
            // }

        }
        addafter("Search Description")
        {
            // field("Shortcut Property 1 Code"; "Shortcut Property 1 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 2 Code"; "Shortcut Property 2 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 3 Code"; "Shortcut Property 3 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 4 Code"; "Shortcut Property 4 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 5 Code"; "Shortcut Property 5 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 6 Code"; "Shortcut Property 6 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 7 Code"; "Shortcut Property 7 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 8 Code"; "Shortcut Property 8 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 9 Code"; "Shortcut Property 9 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 10 Code"; "Shortcut Property 10 Code")
            // {
            //     Visible = false;
            // }
            //BC Upgrade KAPOOV01-drink-it<<
        }
        addafter(Acquired)
        {
            //POENAB02, 10.07.2026>>
            /*            
            field("Serial No."; Rec."Serial No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the fixed asset''s serial number.';
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
            }
            */
            //POENAB02, 10.07.2026<<            
            field("Asset Indicator"; Rec."Asset Indicator FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Asset Indicator field.';
            }
            field(Capex; Capex)
            {
                Caption = 'Capex';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Capex field.';
            }
            field(Quantity; Rec."Quantity FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quantity field.';
            }
            field("Tag No"; Rec."Tag No FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Tag No field.';
            }
            //POENAB02, 10.07.2026>>
            /*
            field(Blocked; Rec.Blocked)
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies that the related record is blocked from being posted in transactions, for example a customer that is declared insolvent or an item that is placed in quarantine.';
            }
            */
            //POENAB02, 10.07.2026<<
            field("FA Posting Group"; Rec."FA Posting Group")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the FA Posting Group field.';
            }
        }
    }
    actions
    {

        modify("Fixed &Asset")
        {
            CaptionML = ENU = 'Fixed &Asset', FRA = 'I&mmo.';
        }
        modify("Depreciation &Books")
        {
            CaptionML = ENU = 'Depreciation &Books', FRA = '&Lois d''amortissement';
            ToolTipML = ENU = 'View or edit the depreciation book or books that must be used for each of the fixed assets. Here you also specify the way depreciation must be calculated.', FRA = 'Affichez ou modifiez la ou les lois d''amortissement à utiliser pour chacune des immobilisations. Vous spécifiez aussi la manière dont les amortissements doivent être calculés.';

            //Unsupported feature: Change RunPageLink on ""Depreciation &Books"(Action 32)". Please convert manually.

        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
            ToolTipML = ENU = 'View detailed historical information about the fixed asset.', FRA = 'Affichez des informations d''historique détaillées sur l''immobilisation.';

            //Unsupported feature: Change RunPageLink on "Statistics(Action 46)". Please convert manually.

        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
        }
        modify("Dimensions-Single")
        {
            CaptionML = ENU = 'Dimensions-Single', FRA = 'Affectations - Simples';
            ToolTipML = ENU = 'View or edit the single set of dimensions that are set up for the selected record.', FRA = 'Affichez ou modifiez l''ensemble unique de dimensions paramétrées pour l''enregistrement sélectionné.';

            //Unsupported feature: Change RunPageLink on ""Dimensions-Single"(Action 41)". Please convert manually.

        }
        modify("Dimensions-&Multiple")
        {
            CaptionML = ENU = 'Dimensions-&Multiple', FRA = 'Affectations - &Multiples';
            ToolTipML = ENU = 'View or edit dimensions for a group of records. You can assign dimension codes to transactions to distribute costs and analyze historical information.', FRA = 'Affichez ou modifiez les axes analytiques pour un groupe d''enregistrements. Vous pouvez affecter des codes axe aux transactions dans le but de répartir les coûts et d''analyser les informations d''historique.';
        }
        modify("Main&tenance Ledger Entries")
        {
            CaptionML = ENU = 'Main&tenance Ledger Entries', FRA = 'Écritures comptables main&tenance';
            ToolTipML = ENU = 'View all the maintenance ledger entries for a fixed asset. ', FRA = 'Affichez toutes les écritures comptables maintenance d''une immobilisation. ';

            //Unsupported feature: Change RunPageView on ""Main&tenance Ledger Entries"(Action 39)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Main&tenance Ledger Entries"(Action 39)". Please convert manually.

        }
        modify(Picture)
        {
            CaptionML = ENU = 'Picture', FRA = 'Image';
            ToolTipML = ENU = 'Add or view a picture of the fixed asset.', FRA = 'Ajoutez ou affichez une image de l''immobilisation.';

            //Unsupported feature: Change RunPageLink on "Picture(Action 42)". Please convert manually.

        }
        modify("FA Posting Types Overview")
        {
            CaptionML = ENU = 'FA Posting Types Overview', FRA = 'Aperçu types compta. immo.';
            ToolTipML = ENU = 'View accumulated amounts for each field, such as book value, acquisition cost, and depreciation, and for each fixed asset. For every fixed asset, a separate line is shown for each depreciation book linked to the asset.', FRA = 'Affichez les montants cumulés de chaque champ, par exemple, valeur comptable, coût d''acquisition et amortissement, et de chaque immobilisation. Pour chaque immobilisation, une nouvelle ligne s''affiche pour chacune des lois d''amortissement liées à l''immobilisation.';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';

            //Unsupported feature: Change RunPageLink on ""Co&mments"(Action 40)". Please convert manually.

        }
        modify("Main Asset")
        {
            CaptionML = ENU = 'Main Asset', FRA = 'Immobilisation principale';
        }
        modify("M&ain Asset Components")
        {
            CaptionML = ENU = 'M&ain Asset Components', FRA = '&Composants immo. principale';
            ToolTipML = ENU = 'View or edit fixed asset components of the main fixed asset that is represented by the fixed asset card.', FRA = 'Affichez ou modifiez les composants d''immobilisation de l''immobilisation principale qui est représentée par la fiche immobilisation.';

            //Unsupported feature: Change RunPageLink on ""M&ain Asset Components"(Action 44)". Please convert manually.

        }
        modify("Ma&in Asset Statistics")
        {
            CaptionML = ENU = 'Ma&in Asset Statistics', FRA = 'Statistiques immo. pri&ncipale';
            ToolTipML = ENU = 'View detailed historical information about all the components that make up the main asset.', FRA = 'Affichez des informations d''historique détaillées sur tous les composants de l''immobilisation principale.';

            //Unsupported feature: Change RunPageLink on ""Ma&in Asset Statistics"(Action 47)". Please convert manually.

        }
        modify(History)
        {
            CaptionML = ENU = 'History', FRA = 'Historique';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
            ToolTipML = ENU = 'View detailed information about transactions made for the fixed asset.', FRA = 'Affichez des informations détaillées sur les transactions effectuées pour l''immobilisation.';

            //Unsupported feature: Change RunPageView on ""Ledger E&ntries"(Action 37)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Ledger E&ntries"(Action 37)". Please convert manually.

        }
        modify("Error Ledger Entries")
        {
            CaptionML = ENU = 'Error Ledger Entries', FRA = 'Erreur écritures comptables';
            ToolTipML = ENU = 'View the entries that have been posted as a result of you using the Cancel function to cancel an entry.', FRA = 'Affichez les écritures qui ont été validées en tant que résultat de l''annulation d''une écriture.';

            //Unsupported feature: Change RunPageView on ""Error Ledger Entries"(Action 38)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Error Ledger Entries"(Action 38)". Please convert manually.

        }
        modify("Maintenance &Registration")
        {
            CaptionML = ENU = 'Maintenance &Registration', FRA = 'S&aisie de la maintenance';
            ToolTipML = ENU = 'View or edit maintenance codes for the various types of maintenance, repairs, and services performed on your fixed assets. You can then enter the code in the Maintenance Code field on journals.', FRA = 'Affichez ou modifiez les codes maintenance des divers types de maintenance, réparation et service effectués sur vos immobilisations. Vous pouvez ensuite saisir le code dans le champ Code maintenance des feuilles.';

            //Unsupported feature: Change RunPageLink on ""Maintenance &Registration"(Action 43)". Please convert manually.

        }
        modify("Fixed Asset Journal")
        {
            CaptionML = ENU = 'Fixed Asset Journal', FRA = 'Feuille immo';
            ToolTipML = ENU = 'Post fixed asset transactions with a depreciation book that is not integrated with the general ledger, for internal management. Only fixed asset ledger entries are created. ', FRA = 'Valider les transactions d''immobilisation avec une loi d''amortissement qui n''est pas intégrée à la comptabilité pour la gestion interne. Seules les écritures comptables immobilisation sont créées. ';
        }
        modify("Fixed Asset G/L Journal")
        {
            CaptionML = ENU = 'Fixed Asset G/L Journal', FRA = 'Feuille compta. immo.';
            ToolTipML = ENU = 'Post fixed asset transactions with a depreciation book that is integrated with the general ledger, for financial reporting. Both fixed asset ledger entries are general ledger entries are created. ', FRA = 'Valider les transactions d''immobilisation avec une loi d''amortissement intégrée à la comptabilité pour les états financiers. Les deux écritures comptables immobilisation sont des écritures comptables qui sont créées. ';
        }
        modify("Fixed Asset Reclassification Journal")
        {
            CaptionML = ENU = 'Fixed Asset Reclassification Journal', FRA = 'Feuille reclassement immobilisation';
            ToolTipML = ENU = 'Transfer, split, or combine fixed assets.', FRA = 'Transférez, fractionnez ou regroupez des immobilisations.';
        }
        modify("Recurring Fixed Asset Journal")
        {
            CaptionML = ENU = 'Recurring Fixed Asset Journal', FRA = 'Feuille abonnement immo.';
            ToolTipML = ENU = 'Post recurring entries to a depreciation book without integration with general ledger.', FRA = 'Validez les écritures récurrentes sur une loi d''amortissement sans les intégrer dans la comptabilité.';
        }
        modify(CalculateDepreciation)
        {
            Visible = false;//Bc upgrade YADAVM09 BCUP0-200<<
            CaptionML = ENU = 'Calculate Depreciation', FRA = 'Calculer amortissement';
            ToolTipML = ENU = 'Calculate depreciation according to conditions that you specify. If the related depreciation book is set up to integrate with the general ledger, then the calculated entries are transferred to the fixed asset general ledger journal. Otherwise, the calculated entries are transferred to the fixed asset journal. You can then review the entries and post the journal.', FRA = 'Calculez l''amortissement en fonction des conditions que vous spécifiez. Si la loi d''amortissement concernée est configurée pour être intégrée dans la comptabilité, les écritures calculées sont transférées vers la feuille comptabilisation immobilisation. Sinon, les écritures calculées sont transférées vers la feuille immobilisation. Vous pouvez alors examiner les écritures et valider la feuille.';
        }
        modify("C&opy Fixed Asset")
        {
            // BC Upgrade BHARDA11 ---- Whenever the base report “Copy Fixed Asset” is run, the report “Copy Fixed Asset 2” will be executed instead, as it has been configured in the OnSubstituteReport event. This substitution was required due to existing customizations in the base report.
            CaptionML = ENU = 'C&opy Fixed Asset', FRA = 'C&opier immobilisation';
            ToolTipML = ENU = 'Create one or more new fixed assets by copying from an existing fixed asset that has similar information.', FRA = 'Créez une ou plusieurs immobilisations en copiant des immobilisations existantes présentant des informations similaires.';
        }
        modify("Fixed Assets List")
        {
            CaptionML = ENU = 'Fixed Assets List', FRA = 'Liste immobilisations';
            ToolTipML = ENU = 'View the list of fixed assets that exist in the system .', FRA = 'Affichez la liste des immobilisations existant dans le système.';
        }
        modify("Acquisition List")
        {
            CaptionML = ENU = 'Acquisition List', FRA = 'Liste des acquisitions';
            ToolTipML = ENU = 'View the related acquisitions.', FRA = 'Affichez les acquisitions associées.';
        }
        modify(Details)
        {
            CaptionML = ENU = 'Details', FRA = 'Détails';
            ToolTipML = ENU = 'View detailed information about the fixed asset ledger entries that have been posted to a specified depreciation book for each fixed asset.', FRA = 'Affichez des informations détaillées sur les écritures comptables immobilisation validées sur une loi d''amortissement donnée pour chacune des immobilisations.';
        }
        modify("FA Book Value")
        {
            CaptionML = ENU = 'FA Book Value', FRA = 'Valeur comptable immo.';
            ToolTipML = ENU = 'View detailed information about acquisition cost, depreciation and book value for both individual assets and groups of assets. For each of these three amount types, amounts are calculated at the beginning and at the end of a specified period as well as for the period itself.', FRA = 'Affichez des informations détaillées concernant le coût d''acquisition, l''amortissement et la valeur comptable à la fois pour les immobilisations individuelles et les groupes d''immobilisations. Pour ces trois types de montants, les calculs sont effectués au début et à la fin d''une période spécifique ainsi que pour la période elle-même.';
        }
        modify("FA Book Val. - Appr. & Write-D")
        {
            CaptionML = ENU = 'FA Book Val. - Appr. & Write-D', FRA = 'Valeur comptable immo. - Rééval. et Dépr.';
            ToolTipML = ENU = 'View detailed information about acquisition cost, depreciation, appreciation, write-down and book value for both individual assets and groups of assets. For each of these categories, amounts are calculated at the beginning and at the end of a specified period, as well as for the period itself.', FRA = 'Affichez des informations détaillées concernant le coût d''acquisition, l''amortissement, la réévaluation, la dépréciation et la valeur comptable à la fois pour les immobilisations individuelles et les groupes d''immobilisations. Pour chacune de ces catégories, les montants sont calculés au début et à la fin d''une période spécifique ainsi que pour la période elle-même.';
        }
        modify(Analysis)
        {
            CaptionML = ENU = 'Analysis', FRA = 'Analyse';
            ToolTipML = ENU = 'View an analysis of your fixed assets with various types of data for both individual assets and groups of fixed assets.', FRA = 'Affichez une analyse de vos immobilisations en incluant divers types de données, pour les immobilisations et les classes d''immobilisations.';
        }
        modify("Projected Value")
        {
            CaptionML = ENU = 'Projected Value', FRA = 'Valeur projetée';
            ToolTipML = ENU = 'View the calculated future depreciation and book value. You can print the report for one depreciation book at a time.', FRA = 'Affichez l''amortissement futur calculé et la valeur comptable. Vous pouvez imprimer l''état par loi d''amortissement.';
        }
        modify("G/L Analysis")
        {
            CaptionML = ENU = 'G/L Analysis', FRA = 'Analyse comptabilité';
            ToolTipML = ENU = 'View an analysis of your fixed assets with various types of data for individual assets and/or groups of fixed assets.', FRA = 'Affichez une analyse de vos immobilisations en incluant divers types de données, pour les immobilisations individuelles et/ou les groupes d''immobilisations.';
        }
        modify(Register)
        {
            CaptionML = ENU = 'Register', FRA = 'Transaction';
            ToolTipML = ENU = 'View registers containing all the fixed asset entries that are created. Each register shows the first and last entry number of its entries.', FRA = 'Affichez les historiques contenant toutes les écritures immobilisation créées. Chaque historique affiche le premier et le dernier numéro de séquence des écritures qu''il comporte.';
        }


        //Unsupported feature: CodeModification on "CalculateDepreciation(Action 11).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        REPORT.RUNMODAL(REPORT::"Calculate Depreciation",TRUE,FALSE,Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        REPORT.RUNMODAL(REPORT::"Calculate Depreciation",true,false,Rec);
        */
        //end;
        addafter("Co&mments")
        {
            //BC Upgrade KAPOOV01-drink-it>>
            // action(Properties)
            // {
            // CaptionML = ENU = 'Properties',
            //             FRA = 'Propriétés';
            // Description = 'FINXL9.00';
            // Image = Category;
            // Promoted = true;
            // PromotedCategory = Process;
            // RunObject = Page "Master Data Properties";
            // RunPageLink = "Table ID" = CONST(5600),
            //               Code = FIELD("No.");
            // }
            //BC Upgrade KAPOOV01-drink-it<<
        }
        addafter("Maintenance &Registration")
        {
            separator(Separator1100083000)
            {
            }

            //BC Upgrade KAPOOV01-drink-it>>
            action("Service Item List")
            {
                CaptionML = ENU = 'Service Item List',
                            FRA = 'Liste des articles de service';
                ToolTip = 'Open Service item page';
                Image = ServiceAgreement;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Service Item List";
                ApplicationArea = All;
                //RunPageLink = "FA No." = FIELD("No.");//Bc Upgrade YADAVM09 Dependency on Drink it field
            }
            //BC Upgrade KAPOOV01-drink-it<<

        }
        addafter(Register)
        {
            action("FA Book Val. Trial Balance")
            {
                ApplicationArea = FixedAssets;
                Caption = 'FA Book Val. Trial Balance';
                Image = "Report";
                RunObject = Report "Fixed Asset-Trial Balance CBN";
                ToolTip = 'View detailed information about acquisition cost, depreciation, appreciation, write-down and book value for both individual fixed assets and groups of fixed assets. For each of these categories, amounts are calculated at the beginning and at the end of a specified period, as well as for the period itself.';
            }
            action("G/L Analysis - Trial Balance")
            {
                ApplicationArea = FixedAssets;
                Caption = 'G/L Analysis - Trial Balance';
                Image = "Report";
                RunObject = Report "FA -G/L Analysis Trial Bal CBN";
                ToolTip = 'View an analysis of your fixed assets with various types of data for individual fixed assets and/or groups of fixed assets.';
            }
            // BC Upgrade POENAB02, 01.04.2026>>
            action("FA Upload")
            {
                ApplicationArea = FixedAssets;
                Caption = 'FA Upload';
                Image = "Report";
                RunObject = Report "FA Upload CBN";
                ToolTip = 'Upload fixed assets from an Excel template. This will create new fixed assets or update existing ones based on the information in the template.';
            }
            // BC Upgrade POENAB02, 01.04.2026<<  

        }
        //Bc Upgrade YADAVM09 BCUP0-200>> 
        addafter("Recurring Fixed Asset Journal")
        {
            action(CalculateDepreciation1)
            {
                ApplicationArea = FixedAssets;
                Caption = 'Calculate Depreciation';
                Ellipsis = true;
                Image = CalculateDepreciation;
                ToolTip = 'Calculate depreciation according to conditions that you specify. If the related depreciation book is set up to integrate with the general ledger, then the calculated entries are transferred to the fixed asset general ledger journal. Otherwise, the calculated entries are transferred to the fixed asset journal. You can then review the entries and post the journal.';

                trigger OnAction()
                begin
                    REPORT.RunModal(REPORT::"Calculate Depreciation-RtR", true, false, Rec);
                end;
            }
        }
        //Bc Upgrade YADAVM09 BCUP0-200<<        

    }

    var
        FinancialUtils: Codeunit "Financial-Utils";
        Capex: Code[20];


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    var
        DefDim: Record "Default Dimension";
    //begin
    /*
    //SOICAD>>
    Capex := '';
    DefDim.SETRANGE("Table ID",DATABASE::"Fixed Asset");
    DefDim.SETRANGE("No.","No.");
    DefDim.SETRANGE("Dimension Code",'CAPEX');
    if DefDim.FINDFIRST then
      Capex := DefDim."Dimension Value Code";
    //SOICAD>>
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

    //BC Upgrade KAPOOV01 Added code that was added under SOICAD Tag>>
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        //SOICAD>>
        Capex := '';
        DefDim.SETRANGE("Table ID", DATABASE::"Fixed Asset");
        DefDim.SETRANGE("No.", Rec."No.");
        DefDim.SETRANGE("Dimension Code", 'CAPEX');
        IF DefDim.FINDFIRST() THEN
            Capex := DefDim."Dimension Value Code";
        //SOICAD>>
    end;

    //BC Upgrade KAPOOV01 Added code that was added under SOICAD Tag<<

}

