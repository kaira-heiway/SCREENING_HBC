pageextension 51038 FixedAssetCardExtCBN extends "Fixed Asset Card"
{
    // DITW15.00.00.35 DDR 24/04/2009 Added 'Drink-It' tab
    //                                Added field "FA Template Code" into 'Drink-It' tab
    //                     31/08/2009 Added fields into 'Drink-It' tab
    //                                  "Depreciation Starting Date","Exist Service Items","Fixed Asset on Inventory"
    //                                Added fields "Description 2" into 'General' tab
    //                                Added 'Service Item List' menu into 'Fixed Asset' button
    //                                Added standard field 9 "Location Code"  !! (never used in Standard Navision)
    //                                  indicate a real location for Drink-it field "Fixed Asset on Inventory"
    // DITW15.00.00.39 DDR 14/07/2011 issue 1258 Added fields "Item No. (Service Item)" into 'Drink-It' tab
    // DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327 Added fields  "DIT Contract No.","Customer No."
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename Field  "DIT Contract No." => Financial Contract No.
    // FINXL9.00.001 DAT 07/03/2016 : Extend Master Property functionalities
    // DITW18.00.07 AKH 22/03/2016 DIT-770 #1805 Merge FINXL extended master data properties
    // DITW19.00.08 SFI 18/08/2016 BL#10868  (DIT-770 #2141) Added field 2014411 "Allow Invoice Disc." to Group "Drink-IT"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // HEI.01 FDD RTRGAP057 IBM HORTOC01 29.07.2017
    //   # add new function to check/change Fa. Indicator
    // HEI.02 FDD RTRGAP014 IBM COSTES02 04.08.2017
    //   # add new actions: FA Book Val. Trial Balance,G/L Analysis - Trial Balance

    // HEI.03 FDD RTRGAP057 IBM POENAB01 14.08.2017
    //   # check Fa. Indicator when getting a new record
    // HEI.04 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # New fields for MDM integration: "WHT Product Posting Group"
    // HEI.05 FDD_CHG0246293 IBM ISYED01 10.10.2018 #Asset Quantity and Tag No info in FA Card  to incl. Quantiy, Tag No.
    //   # new filed Quantity and Tag No added to Page
    // HEI.06 FDD-ET-MARAKI POS Interface IBM POSTOI01 # Maraki POS Interface
    //   # show field FA Posting Group field
    //   # OnOpenPage make DocNoVisible = true
    // HEI.08 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New action added in ActionContainer Reports: <Report FA - Proj. Value (Deroga
    //   # Code added in OnOpenPage()
    // HEI.10 FDD-HB1617 BULIMC01 IBM 28/12/2020 # new field added to General tab - "Picture"
    // HEI.11 FDD-HB2373 - CHG2123486 IBM NANDIS01 24.09.2021 - Development - CMG mandatory on FA card
    //   # New field shown - CMG Code(Field ID - 50004) shown in TAB - Genaral

    // HEI.12 CHG2224401 HB3624 YADAVM09 09.02.2024 Health and Security Levy Tax
    //   # New Field Added #H&S Levy Tax Posting Group
    // version NAVW110.0.00.16585,FINXL9.00.000.01,DITW110.00.08,HEI.12

    //---------------------------------------------------------------------------------------------------------------------------

    //BC Upgrade KAPOOV01 18.12.2025 #Commented Drink-It fields, function,actions,group controls-Properties,Drink-It.
    //BC Upgrade KAPOOV01 18.12.2025 #Commented action-Projected Value (Derogatory) related to FR localization,Commented report related to FR Localization.
    //BC Upgrade KAPOOV01 18.12.2025 #Changed Action name from Picture to FAPicture as there is one Page field with caption Picture due to which getting compilation error.
    //BC Upgrade KAPOOV01 18.12.2025 #Replaced Picture with Rec.ImageID
    //BC Upgrade KAPOOV01 18.12.2025 #Changed factbox name from "<Fixed Asset Picture>" to FixedAssetPicture as defined in Base page
    //BC Upgrade KAPOOV01 18.12.2025 #Added code on Triggers-OnOpenPage,OnClosePage.
    // BC Upgrade BHARDA11 ---- Whenever the base report “Copy Fixed Asset” is run, the report “Copy Fixed Asset 2” will be executed instead, as it has been configured in the OnSubstituteReport event. This substitution was required due to existing customizations in the base report.
    // BC Upgrade BHARDA11 >>
    // 1. Standard report "Fixed Asset - Book Value 01" is substituted via OnAfterSubstituteReport event.Custom report "Fixed Asset - Book Value 01New" will run instead.
    // 2. Standard report "Fixed Asset - Book Value 02" is substituted via OnAfterSubstituteReport event.Custom report "Fixed Asset - Book Value 02New" will run instead.
    // BC Upgrade BHARDA11 <<
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies a number for the fixed asset.', FRA = 'Indique un numéro d''immobilisation.';

            //Unsupported feature: Change Visible on ""No."(Control 2)". Please convert manually.

        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the fixed asset.', FRA = 'Spécifie une description de l''immobilisation.';
        }
        modify("FA Class Code")
        {
            CaptionML = ENU = 'Class Code', FRA = 'Code classe';
            ToolTipML = ENU = 'Specifies the class that the fixed asset belongs to.', FRA = 'Spécifie une classe à laquelle l''immobilisation appartient.';
        }
        modify("FA Subclass Code")
        {
            CaptionML = ENU = 'Subclass Code', FRA = 'Code sous-classe';
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
        modify("Serial No.")
        {
            ToolTipML = ENU = 'Specifies the fixed asset''s serial number.', FRA = 'Indique le n° de série de l''immobilisation.';
        }
        modify("Main Asset/Component")
        {
            ToolTipML = ENU = 'Specifies if the fixed asset is a main fixed asset or a component of a fixed asset.', FRA = 'Indique si l''immobilisation est une immobilisation principale ou le composant d''une immobilisation.';
        }
        modify("Component of Main Asset")
        {
            ToolTipML = ENU = 'Specifies the number of the main fixed asset.', FRA = 'Spécifie le numéro de l''immobilisation principale.';
        }
        modify("Search Description")
        {
            ToolTipML = ENU = 'Specifies a search description for the fixed asset.', FRA = 'Spécifie une description de recherche de l''immobilisation.';
        }
        modify("Responsible Employee")
        {
            ToolTipML = ENU = 'Specifies which employee is responsible for the fixed asset.', FRA = 'Spécifie le nom du salarié responsable de l''immobilisation.';
        }
        modify(Inactive)
        {
            ToolTipML = ENU = 'Specifies that the fixed asset is inactive (for example, if the asset is not in service or is obsolete).', FRA = 'Indique que l''immobilisation est inactive (par exemple, si l''immobilisation est détériorée ou obsolète).';
        }
        modify(Blocked)
        {
            ToolTipML = ENU = 'Specifies that transcations with this fixed asset cannot be posted. Blocked fixed assets will be omitted in batch jobs that create journal lines for fixed asset posting.', FRA = 'Spécifie que les transactions liées à cette immobilisation ne peuvent pas être validées. Les immobilisations bloquées seront omises dans les traitements par lots qui créent des lignes feuille pour la comptabilisation des immobilisations.';
        }
        modify("Last Date Modified")
        {
            ToolTipML = ENU = 'Specifies when the fixed asset card was last modified.', FRA = 'Indique la date à laquelle la fiche immobilisation a été modifiée pour la dernière fois.';
        }
        modify("Depreciation Book")
        {
            CaptionML = ENU = 'Depreciation Book', FRA = 'Loi d''amortissement';
        }
        modify(DepreciationBookCode)
        {
            CaptionML = ENU = 'Depreciation Book Code', FRA = 'Code loi d''amortissement';
            ToolTipML = ENU = 'Specifies the depreciation book that is assigned to the fixed asset.', FRA = 'Spécifie la loi d''amortissement affectée à l''immobilisation.';
        }
        modify(FAPostingGroup)
        {
            CaptionML = ENU = 'Posting Group', FRA = 'Groupe comptabilisation';
            ToolTipML = ENU = 'Specifies which posting group is used for the depreciation book when posting fixed asset transactions.', FRA = 'Spécifie le groupe comptabilisation utilisé pour la loi d''amortissement lors de la validation des transactions d''immobilisation.';
        }
        modify(DepreciationMethod)
        {
            CaptionML = ENU = 'Depreciation Method', FRA = 'Méthode amortissement';
            ToolTipML = ENU = 'Specifies how depreciation is calculated for the depreciation book.', FRA = 'Spécifie comment l''amortissement est calculé pour la loi d''amortissement.';
        }
        modify(DepreciationStartingDate)
        {
            CaptionML = ENU = 'Depreciation Starting Date', FRA = 'Date début amortissement';
            ToolTipML = ENU = 'Specifies the date on which depreciation of the fixed asset starts.', FRA = 'Spécifie la date à laquelle l''amortissement de l''immobilisation commence.';
        }
        modify(NumberOfDepreciationYears)
        {
            CaptionML = ENU = 'No. of Depreciation Years', FRA = 'Nombre années amortissement';
            ToolTipML = ENU = 'Specifies the length of the depreciation period, expressed in years.', FRA = 'Spécifie la durée de la période d''amortissement, exprimée en années.';
        }
        modify(DepreciationEndingDate)
        {
            CaptionML = ENU = 'Depreciation Ending Date', FRA = 'Date fin amortissement';
            ToolTipML = ENU = 'Specifies the date on which depreciation of the fixed asset ends.', FRA = 'Spécifie la date à laquelle l''amortissement de l''immobilisation finit.';
        }
        modify(BookValue)
        {
            CaptionML = ENU = 'Book Value', FRA = 'Valeur comptable';
            ToolTipML = ENU = 'Specifies the book value for the fixed asset as a FlowField.', FRA = 'Spécifie la valeur comptable de l''immobilisation en tant que FlowField.';
        }
        modify(DepreciationBook)
        {
            CaptionML = ENU = 'Depreciation Books', FRA = 'Lois d''amortissement';

            //Unsupported feature: Change SubPageLink on "DepreciationBook(Control 6)". Please convert manually.

        }
        modify(Maintenance)
        {
            CaptionML = ENU = 'Maintenance', FRA = 'Maintenance';
        }
        modify("Vendor No.")
        {
            ToolTipML = ENU = 'Specifies the number of the vendor from which you purchased this fixed asset.', FRA = 'Spécifie le numéro du fournisseur auquel vous avez acheté l''immobilisation.';
        }
        modify("Maintenance Vendor No.")
        {
            ToolTipML = ENU = 'Specifies the number of the vendor who performs repairs and maintenance on the fixed asset.', FRA = 'Spécifie le numéro du fournisseur qui effectue les réparations et la maintenance de l''immobilisation.';
        }
        modify("Under Maintenance")
        {
            ToolTipML = ENU = 'Specifies if the fixed asset is currently being repaired.', FRA = 'Spécifie si l''immobilisation est en réparation/maintenance.';
        }
        modify("Next Service Date")
        {
            ToolTipML = ENU = 'Specifies the next scheduled service date for the fixed asset. This is used as a filter in the Maintenance - Next Service report.', FRA = 'Spécifie la date de la prochaine intervention prévue sur l''immobilisation. Ce champ est utilisé dans l''état Maintenance - à effectuer.';
        }
        modify("Warranty Date")
        {
            ToolTipML = ENU = 'Specifies the warranty expiration date of the fixed asset.', FRA = 'Indique la date d''expiration de la garantie de l''immobilisation.';
        }
        modify(Insured)
        {
            ToolTipML = ENU = 'Specifies that the fixed asset is linked to an insurance policy.', FRA = 'Indique que l''immobilisation est liée à une police d''assurance.';
        }
        //BC Upgrade KAPOOV01 changed factboxe name from "<Fixed Asset Picture>" to FixedAssetPicture as defined in Base page>>  >>

        modify(FixedAssetPicture)
        {
            CaptionML = ENU = 'Fixed Asset Picture', FRA = 'Image immo.';

        }
        // modify("<Fixed Asset Picture>")
        // {
        //     CaptionML = ENU = 'Fixed Asset Picture', FRA = 'Image immo.';

        //     //Unsupported feature: Change SubPageLink on ""<Fixed Asset Picture>"(Control 46)". Please convert manually.

        // }
        //BC Upgrade KAPOOV01 changed factboxes name from "<Fixed Asset Picture>" to FixedAssetPicture as defined in Base page<<

        //Unsupported feature: CodeModification on ""No."(Control 2).OnAssistEdit". Please convert manually.

        //trigger "(Control 2)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF AssistEdit(xRec) THEN
          CurrPage.UPDATE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if AssistEdit(xRec) then
          CurrPage.UPDATE;
        */
        //end;


        //Unsupported feature: CodeModification on ""FA Subclass Code"(Control 45).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "FA Class Code" <> '' THEN
          FASubclass.SETFILTER("FA Class Code",'%1|%2','',"FA Class Code");

        IF FASubclass.GET("FA Subclass Code") THEN;
        IF PAGE.RUNMODAL(0,FASubclass) = ACTION::LookupOK THEN BEGIN
          Text := FASubclass.Code;
          EXIT(TRUE);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "FA Class Code" <> '' then
          FASubclass.SETFILTER("FA Class Code",'%1|%2','',"FA Class Code");

        if FASubclass.GET("FA Subclass Code") then;
        if PAGE.RUNMODAL(0,FASubclass) = ACTION::LookupOK then begin
          Text := FASubclass.Code;
          exit(true);
        end;
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""FA Location Code"(Control 52)". Please convert manually.



        //Unsupported feature: CodeModification on "AddMoreDeprBooks(Control 15).OnDrillDown". Please convert manually.

        //trigger OnDrillDown();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Simple := NOT Simple;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        Simple := not Simple;
        */
        //end;
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Description 2 field.';
            }
        }
        addafter("Budgeted Asset")
        {
            field(Picture; Rec.Image)//BC Upgrade KAPOOV01 Picture replaced by Image.
            {
                Importance = Additional;
                ApplicationArea = All;
                ToolTip = 'Specifies the picture that has been inserted for the fixed asset.';
            }
        }
        addafter("Last Date Modified")
        {
            field("WHT Product Posting Group"; Rec."WHT Product Posting Group FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the WHT Product Posting Group field.';
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
            field("FA Posting Group"; Rec."FA Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the FA Posting Group field.';
            }
            field("CMG code"; Rec."CMG code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CMG code field.';
            }
            field("H&S Levy Tax Posting Group"; Rec."H&S Levy Tax Posting Group FND")
            {
                Visible = EnableHSLevy;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the H&S Levy Tax Posting Group field.';
            }
        }
        addafter(Maintenance)
        {
            //BC Upgrade KAPOOV01-drink-it>>
            // group("Drink-It")
            // {
            //     CaptionML = ENU = 'Drink-It',
            //                 FRA = 'Drink-It';
            //     field("FA Template Code"; "FA Template Code")
            //     {

            //         trigger OnValidate();
            //         begin
            //             FATemplateCodeOnAfterValidate;
            //         end;
            //     }
            //     field("Depreciation Starting Date"; "Depreciation Starting Date")
            //     {
            //     }
            //     field("Exist Service Items"; "Exist Service Items")
            //     {
            //         Editable = false;
            //     }
            //     field("Item No. (Service Item)"; "Item No. (Service Item)")
            //     {
            //     }
            //     field("Fixed Asset on Inventory"; "Fixed Asset on Inventory")
            //     {
            //     }
            //     field("Location Code"; "Location Code")
            //     {
            //     }
            //     field("Financial Contract No."; "Financial Contract No.")
            //     {
            //     }
            //     field("DIT Sub-Contract Type"; "DIT Sub-Contract Type")
            //     {
            //     }
            //     field("Customer No."; "Customer No.")
            //     {
            //     }
            //     field("Allow Invoice Disc."; "Allow Invoice Disc.")
            //     {
            //     }
            // }

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
            // }
            //BC Upgrade KAPOOV01-drink-it<<
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
            CaptionML = ENU = 'Depreciation &Books', FRA = 'Lois d''am&ortissement';
            ToolTipML = ENU = 'View or edit the depreciation book or books that must be used for each of the fixed assets. Here you also specify the way depreciation must be calculated.', FRA = 'Affichez ou modifiez la ou les lois d''amortissement à utiliser pour chacune des immobilisations. Vous spécifiez aussi la manière dont les amortissements doivent être calculés.';

            //Unsupported feature: Change RunPageLink on ""Depreciation &Books"(Action 51)". Please convert manually.

        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
            ToolTipML = ENU = 'View detailed historical information about the fixed asset.', FRA = 'Affichez des informations d''historique détaillées sur l''immobilisation.';

            //Unsupported feature: Change RunPageLink on "Statistics(Action 40)". Please convert manually.

        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';

            //Unsupported feature: Change RunPageLink on "Dimensions(Action 84)". Please convert manually.

        }
        modify("Maintenance &Registration")
        {
            CaptionML = ENU = 'Maintenance &Registration', FRA = 'Saisi&e de la maintenance';
            ToolTipML = ENU = 'View or edit maintenance codes for the various types of maintenance, repairs, and services performed on your fixed assets. You can then enter the code in the Maintenance Code field on journals.', FRA = 'Affichez ou modifiez les codes maintenance des divers types de maintenance, réparation et service effectués sur vos immobilisations. Vous pouvez ensuite saisir le code dans le champ Code maintenance des feuilles.';

            //Unsupported feature: Change RunPageLink on ""Maintenance &Registration"(Action 35)". Please convert manually.

        }
        modify("FA Posting Types Overview")
        {
            CaptionML = ENU = 'FA Posting Types Overview', FRA = 'Aperçu types compta. immo.';
            ToolTipML = ENU = 'View accumulated amounts for each field, such as book value, acquisition cost, and depreciation, and for each fixed asset. For every fixed asset, a separate line is shown for each depreciation book linked to the asset.', FRA = 'Affichez les montants cumulés de chaque champ, par exemple, valeur comptable, coût d''acquisition et amortissement, et de chaque immobilisation. Pour chaque immobilisation, une nouvelle ligne s''affiche pour chacune des lois d''amortissement liées à l''immobilisation.';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';

            //Unsupported feature: Change RunPageLink on ""Co&mments"(Action 50)". Please convert manually.

        }
        modify("Main Asset")
        {
            CaptionML = ENU = 'Main Asset', FRA = 'Immobilisation principale';
        }
        modify("M&ain Asset Components")
        {
            CaptionML = ENU = 'M&ain Asset Components', FRA = '&Composants immo. principale';
            ToolTipML = ENU = 'View or edit fixed asset components of the main fixed asset that is represented by the fixed asset card.', FRA = 'Affichez ou modifiez les composants d''immobilisation de l''immobilisation principale qui est représentée par la fiche immobilisation.';

            //Unsupported feature: Change RunPageLink on ""M&ain Asset Components"(Action 29)". Please convert manually.

        }
        modify("Ma&in Asset Statistics")
        {
            CaptionML = ENU = 'Ma&in Asset Statistics', FRA = 'Statistiques immo. pri&ncipale';
            ToolTipML = ENU = 'View detailed historical information about the fixed asset.', FRA = 'Affichez des informations d''historique détaillées sur l''immobilisation.';

            //Unsupported feature: Change RunPageLink on ""Ma&in Asset Statistics"(Action 41)". Please convert manually.

        }
        modify(Insurance)
        {
            CaptionML = ENU = 'Insurance', FRA = 'Assurance';
        }
        modify("Total Value Ins&ured")
        {
            CaptionML = ENU = 'Total Value Ins&ured', FRA = '&Valeur totale assurée';
            ToolTipML = ENU = 'View the amounts that you posted to each insurance policy for the fixed asset. The amounts shown can be more or less than the actual insurance policy coverage. The amounts shown can differ from the actual book value of the asset.', FRA = 'Affichez les montants que vous avez validés dans chaque police d''assurance pour l''immobilisation. Les montants affichés peuvent être supérieurs ou inférieurs à la couverture de la police réelle. Ils peuvent différer de la valeur comptable réelle de l''immobilisation.';

            //Unsupported feature: Change RunPageLink on ""Total Value Ins&ured"(Action 68)". Please convert manually.

        }
        modify(History)
        {
            CaptionML = ENU = 'History', FRA = 'Historique';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
            ToolTipML = ENU = 'View detailed information about transactions made for the fixed asset.', FRA = 'Affichez des informations détaillées sur les transactions effectuées pour l''immobilisation.';

            //Unsupported feature: Change RunPageView on ""Ledger E&ntries"(Action 7)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Ledger E&ntries"(Action 7)". Please convert manually.

        }
        modify("Error Ledger Entries")
        {
            CaptionML = ENU = 'Error Ledger Entries', FRA = 'Erreur écritures comptables';
            ToolTipML = ENU = 'View the entries that have been posted as a result of you using the Cancel function to cancel an entry.', FRA = 'Affichez les écritures qui ont été validées en tant que résultat de l''annulation d''une écriture.';

            //Unsupported feature: Change RunPageView on ""Error Ledger Entries"(Action 8)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Error Ledger Entries"(Action 8)". Please convert manually.

        }
        modify("Main&tenance Ledger Entries")
        {
            CaptionML = ENU = 'Main&tenance Ledger Entries', FRA = 'Écritures comptables main&tenance';
            ToolTipML = ENU = 'View all the maintenance ledger entries for a fixed asset.', FRA = 'Affichez toutes les écritures comptables maintenance d''une immobilisation.';

            //Unsupported feature: Change RunPageView on ""Main&tenance Ledger Entries"(Action 9)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Main&tenance Ledger Entries"(Action 9)". Please convert manually.

        }
        modify(Acquire)
        {
            CaptionML = ENU = 'Acquire', FRA = 'Acquérir';
            ToolTipML = ENU = 'Acquire the fixed asset.', FRA = 'Faites l''acquisition de l''immobilisation.';
        }
        modify("C&opy Fixed Asset")
        {
            // BC Upgrade BHARDA11 ---- Whenever the base report “Copy Fixed Asset” is run, the report “Copy Fixed Asset 2” will be executed instead, as it has been configured in the OnSubstituteReport event. This substitution was required due to existing customizations in the base report.
            CaptionML = ENU = 'C&opy Fixed Asset', FRA = 'C&opier immobilisation';
            ToolTipML = ENU = 'View or edit fixed asset components of the main fixed asset that is represented by the fixed asset card.', FRA = 'Affichez ou modifiez les composants d''immobilisation de l''immobilisation principale qui est représentée par la fiche immobilisation.';
        }
        modify(Details)
        {
            CaptionML = ENU = 'Details', FRA = 'Détails';
            ToolTipML = ENU = 'View detailed information about the fixed asset ledger entries that have been posted to a specified depreciation book for each fixed asset.', FRA = 'Affichez des informations détaillées sur les écritures comptables immobilisation validées sur une loi d''amortissement donnée pour chacune des immobilisations.';
        }
        modify("FA Book Value")
        {
            CaptionML = ENU = 'FA Book Value', FRA = 'Valeur comptable immo.';
            ToolTipML = ENU = 'View detailed information about acquisition cost, depreciation and book value for both individual fixed assets and groups of fixed assets. For each of these three amount types, amounts are calculated at the beginning and at the end of a specified period as well as for the period itself.', FRA = 'Affichez des informations détaillées concernant le coût d''acquisition, l''amortissement et la valeur comptable à la fois pour les immobilisations individuelles et les groupes d''immobilisations. Pour ces trois types de montants, les calculs sont effectués au début et à la fin d''une période spécifique ainsi que pour la période elle-même.';
        }
        modify("FA Book Val. - Appr. & Write-D")
        {
            CaptionML = ENU = 'FA Book Val. - Appr. & Write-D', FRA = 'Valeur comptable immo. - Rééval. et Dépr.';
            ToolTipML = ENU = 'View detailed information about acquisition cost, depreciation, appreciation, write-down and book value for both individual fixed assets and groups of fixed assets. For each of these categories, amounts are calculated at the beginning and at the end of a specified period, as well as for the period itself.', FRA = 'Affichez des informations détaillées concernant le coût d''acquisition, l''amortissement, la réévaluation, la dépréciation et la valeur comptable à la fois pour les immobilisations individuelles et les groupes d''immobilisations. Pour chacune de ces catégories, les montants sont calculés au début et à la fin d''une période spécifique ainsi que pour la période elle-même.';
        }
        modify(Analysis)
        {
            CaptionML = ENU = 'Analysis', FRA = 'Analyse';
            ToolTipML = ENU = 'View an analysis of your fixed assets with various types of data for both individual fixed assets and groups of fixed assets.', FRA = 'Affichez une analyse de vos immobilisations en incluant divers types de données, pour les immobilisations et les classes d''immobilisations.';
        }
        modify("Projected Value")
        {
            CaptionML = ENU = 'Projected Value', FRA = 'Valeur projetée';
            ToolTipML = ENU = 'View the calculated future depreciation and book value. You can print the report for one depreciation book at a time.', FRA = 'Affichez l''amortissement futur calculé et la valeur comptable. Vous pouvez imprimer l''état par loi d''amortissement.';
        }
        modify("G/L Analysis")
        {
            CaptionML = ENU = 'G/L Analysis', FRA = 'Analyse comptabilité';
            ToolTipML = ENU = 'View an analysis of your fixed assets with various types of data for individual fixed assets and/or groups of fixed assets.', FRA = 'Affichez une analyse de vos immobilisations en incluant divers types de données, pour les immobilisations et/ou les classes d''immobilisations.';
        }
        modify(Register)
        {
            CaptionML = ENU = 'Register', FRA = 'Transaction';
            ToolTipML = ENU = 'View registers containing all the fixed asset entries that are created. Each register shows the first and last entry number of its entries.', FRA = 'Affichez les historiques contenant toutes les écritures immobilisation créées. Chaque historique affiche le premier et le dernier numéro de séquence des écritures qu''il comporte.';
        }
        addafter("Maintenance &Registration")
        {
            action(FAPicture)
            {
                ApplicationArea = FixedAssets;
                Caption = 'Picture';
                Image = Picture;
                RunObject = Page "Fixed Asset Picture";
                RunPageLink = "No." = FIELD("No.");
                ToolTip = 'Add or view a picture of the fixed asset.';
            }
        }
        addafter("Co&mments")
        {
            //BC Upgrade KAPOOV01-drink-it>>
            // action(Properties)
            // {
            //     CaptionML = ENU = 'Properties',
            //                 FRA = 'Propriétés';
            //     Description = 'FINXL9.00';
            //     Image = Category;
            //     Promoted = true;
            //     PromotedCategory = Process;
            // RunObject = Page "Master Data Properties";
            // RunPageLink = "Table ID" = CONST(5600),
            //               Code = FIELD("No.");
            //}
            //BC Upgrade KAPOOV01-drink-it<<
        }
        addafter("Main&tenance Ledger Entries")
        {
            separator(Separator1100083008)
            {
            }
            //BC Upgrade KAPOOV01-drink-it action>>
            // action("Service Item List")
            // {
            //     CaptionML = ENU = 'Service Item List',
            //                 FRA = 'Liste des articles de service';
            //     Image = ServiceAgreement;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Page "Service Item List";
            //     // RunPageLink = "FA No." = FIELD("No.");//BC Upgrade KAPOOV01-drink-it, FA No. field is drink-it field.
            // }
            //BC Upgrade KAPOOV01-drink-it action<<
        }
        addafter("Projected Value")
        {
            //BC Upgrade KAPOOV01 Commented action-Projected Value (Derogatory) related to FR localization>>
            // action("Projected Value (Derogatory)")
            // {
            //     ApplicationArea = FixedAssets;
            //     CaptionML = ENU = 'Projected Value (Derogatory)',
            //                 FRA = 'Valeur projetée (Dérogatoire)';
            //     Enabled = FRLocAction;
            //     Image = "Report";
            //     Promoted = true;
            //     PromotedCategory = "Report";
            //     RunObject = Report "FA - Proj. Value (Derogatory)"; 
            //     Visible = FRLocAction;
            // }
            //BC Upgrade KAPOOV01 Commented action-Projected Value (Derogatory) related to FR localization<<
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
        }
    }


    //Unsupported feature: PropertyModification on "AddMoreDeprBooksLbl(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //AddMoreDeprBooksLbl : ENU=Add More Depreciation Books;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //AddMoreDeprBooksLbl : ENU=Add More Depreciation Books;FRA=Ajouter d'autres lois d'amortissement;
    //Variable type has not been exported.

    var
        CompanyInfo: Record "Company Information";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        UserSetup: Record "User Setup";
        FinancialUtils: Codeunit "Financial-Utils";
        DocNoVisible: Boolean;
        EnableHSLevy: Boolean;
        FRLocAction: Boolean;



    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "No." <> xRec."No." THEN
      SaveSimpleDepriciationBook(xRec."No.");

    LoadDepreciationBooks;
    CurrPage.UPDATE(FALSE);
    FADepreciationBook.COPY(FADepreciationBookOld);
    ShowAcquireNotification;
    FADepreciationBook.UpdateBookValue;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if "No." <> xRec."No." then
    #2..4
    CurrPage.UPDATE(false);
    #6..8
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnClosePage". Please convert manually.

    //trigger OnClosePage();
    //begin
    /*
    //HEI.01>>
    FinancialUtils.ChangeFaIndicator(Rec);
    CurrPage.SAVERECORD;
    CurrPage.UPDATE(true);
    //HEI.01<<
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //begin
    /*
    // << DITW19.00.08 SFI 18/08/2016 BL#10868
    SetupNewRec();
    // >> DITW19.00.08 SFI 18/08/2016
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Simple := TRUE;
    DocNoVisible := DocumentNoVisibility.FixedAssetNoIsVisible;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //HEI.06>>

    DocNoVisible := DocumentNoVisibility.FixedAssetNoIsVisible;
    //HEI.06<<
    //HEI.08>>
    FRLocAction := false;
    CompanyInfo.GET;
    if CompanyInfo."Enable French Localization" then
      FRLocAction := true;
    //HEI.08
    //HEI.12>>
    PurchasesPayablesSetup.GET;
    EnableHSLevy := PurchasesPayablesSetup."H&S Levy Tax";
    //HEI.12<<
    */
    //end;


    //Unsupported feature: CodeModification on "ShowAcquireNotification(PROCEDURE 7)". Please convert manually.

    //procedure ShowAcquireNotification();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ShowAcquireNotification :=
      (NOT Acquired) AND FieldsForAcquitionInGeneralGroupAreCompleted AND AtLeastOneDepreciationLineIsComplete;
    IF ShowAcquireNotification AND ISNULLGUID(FAAcquireWizardNotificationId) THEN BEGIN
      Acquirable := TRUE;
      FixedAssetAcquisitionWizard.ShowAcquireWizardNotification(FAAcquireWizardNotificationId,"No.");
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ShowAcquireNotification :=
      (not Acquired) and FieldsForAcquitionInGeneralGroupAreCompleted and AtLeastOneDepreciationLineIsComplete;
    if ShowAcquireNotification and ISNULLGUID(FAAcquireWizardNotificationId) then begin
      Acquirable := true;
      FixedAssetAcquisitionWizard.ShowAcquireWizardNotification(FAAcquireWizardNotificationId,"No.");
    end;
    */
    //end;


    //Unsupported feature: CodeModification on "AtLeastOneDepreciationLineIsComplete(PROCEDURE 24)". Please convert manually.

    //procedure AtLeastOneDepreciationLineIsComplete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Simple THEN
      EXIT(FADepreciationBook.RecIsReadyForAcquisition);

    EXIT(FADepreciationBookMultiline.LineIsReadyForAcquisition("No."));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if Simple then
      exit(FADepreciationBook.RecIsReadyForAcquisition);

    exit(FADepreciationBookMultiline.LineIsReadyForAcquisition("No."));
    */
    //end;


    //Unsupported feature: CodeModification on "SaveSimpleDepriciationBook(PROCEDURE 28)". Please convert manually.

    //procedure SaveSimpleDepriciationBook();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT SimpleDepreciationBookHasChanged THEN
      EXIT;

    IF Simple AND FixedAsset.GET(FixedAssetNo) THEN BEGIN
      IF FADepreciationBook."Depreciation Book Code" <> '' THEN
        IF FADepreciationBook."FA No." = '' THEN BEGIN
          FADepreciationBook.VALIDATE("FA No.",FixedAssetNo);
          FADepreciationBook.INSERT(TRUE)
        end else
          FADepreciationBook.MODIFY(TRUE)
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if not SimpleDepreciationBookHasChanged then
      exit;

    if Simple and FixedAsset.GET(FixedAssetNo) then begin
      if FADepreciationBook."Depreciation Book Code" <> '' then
        if FADepreciationBook."FA No." = '' then begin
          FADepreciationBook.VALIDATE("FA No.",FixedAssetNo);
          FADepreciationBook.INSERT(true)
        end else
          FADepreciationBook.MODIFY(true)
    end;
    */
    //end;


    //Unsupported feature: CodeModification on "SetDefaultDepreciationBook(PROCEDURE 21)". Please convert manually.

    //procedure SetDefaultDepreciationBook();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF FADepreciationBook."Depreciation Book Code" = '' THEN BEGIN
      FASetup.GET;
      FADepreciationBook.VALIDATE("Depreciation Book Code",FASetup."Default Depr. Book");
      SaveSimpleDepriciationBook("No.");
      LoadDepreciationBooks;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if FADepreciationBook."Depreciation Book Code" = '' then begin
    #2..5
    end;
    */
    //end;


    //Unsupported feature: CodeModification on "SetDefaultPostingGroup(PROCEDURE 22)". Please convert manually.

    //procedure SetDefaultPostingGroup();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF FASubclass.GET("FA Subclass Code") THEN;
    FADepreciationBook.VALIDATE("FA Posting Group",FASubclass."Default FA Posting Group");
    SaveSimpleDepriciationBook("No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if FASubclass.GET("FA Subclass Code") then;
    FADepreciationBook.VALIDATE("FA Posting Group",FASubclass."Default FA Posting Group");
    SaveSimpleDepriciationBook("No.");
    */
    //end;


    //Unsupported feature: CodeModification on "SimpleDepreciationBookHasChanged(PROCEDURE 3)". Please convert manually.

    //procedure SimpleDepreciationBookHasChanged();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    EXIT(FORMAT(FADepreciationBook) <> FORMAT(FADepreciationBookOld));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    exit(FORMAT(FADepreciationBook) <> FORMAT(FADepreciationBookOld));
    */
    //end;


    //Unsupported feature: CodeModification on "LoadDepreciationBooks(PROCEDURE 5)". Please convert manually.

    //procedure LoadDepreciationBooks();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CLEAR(FADepreciationBookOld);
    FADepreciationBookOld.SETRANGE("FA No.","No.");
    IF FADepreciationBookOld.COUNT <= 1 THEN BEGIN
      IF FADepreciationBookOld.FINDFIRST THEN BEGIN
        FADepreciationBookOld.CALCFIELDS("Book Value");
        ShowAddMoreDeprBooksLbl := TRUE
      end;
      Simple := TRUE;
    end else
      Simple := FALSE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CLEAR(FADepreciationBookOld);
    FADepreciationBookOld.SETRANGE("FA No.","No.");
    if FADepreciationBookOld.COUNT <= 1 then begin
      if FADepreciationBookOld.FINDFIRST then begin
        FADepreciationBookOld.CALCFIELDS("Book Value");
        ShowAddMoreDeprBooksLbl := true
      end;
      Simple := true;
    end else
      Simple := false;
    */
    //end;
    //BC Upgrade KAPOOV01 Drink-IT>>
    // local procedure FATemplateCodeOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.35 DDR 24/04/2009
    //     CurrPage.UPDATE(true);
    // end;
    //BC Upgrade KAPOOV01 Drink-IT<<

    //BC Upgrade KAPOOV01>>

    trigger OnOpenPage()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        //HEI.06>>

        DocNoVisible := DocumentNoVisibility.FixedAssetNoIsVisible();
        //HEI.06<<
        //HEI.08>>
        FRLocAction := FALSE;
        CompanyInfo.GET();
        IF CompanyInfo."Enable French Localization FND" THEN
            FRLocAction := TRUE;
        //HEI.08
        //HEI.12>>
        PurchasesPayablesSetup.GET();
        EnableHSLevy := PurchasesPayablesSetup."H&S Levy Tax FND";
        //HEI.12
    end;

    trigger OnClosePage()
    var
        myInt: Integer;
    begin
        //HEI.01>>
        FinancialUtils.ChangeFaIndicator(Rec);
        CurrPage.SAVERECORD();
        CurrPage.UPDATE(TRUE);
        //HEI.01<<
    end;
    //BC Upgrade KAPOOV01<<


    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

