pageextension 51026 GenProductPostingGroupsExtCBN extends "Gen. Product Posting Groups"
{
    // version NAVW110.0,DITW110.00.08
    // DITW15.00.00.38 DDR 03/02/2011 issue 941 Added fields "Def. Prod. Posting Free Group"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 Cash Van Sales IBM HORTOC01 30.07.2018 # new function
    // HEI.02 CHG2109621 HT2170 IBM GAVANM01 10.06.2021 - Posting Setup for Sales Tax (Timbre), transport, free products
    //   # Added field: Include Timbre
    //   # code changes in function GetSelectionFilter
    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a code for the product posting group.', FRA = 'Spécifie un code pour le groupe comptabilisation produit.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description for the product posting group.', FRA = 'Spécifie une description pour le groupe comptabilisation produit.';
        }
        modify("Def. VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a default VAT product group code.', FRA = 'Spécifie un code groupe comptabilisation produit TVA par défaut.';
        }
        modify("Auto Insert Default")
        {
            ToolTipML = ENU = 'Specifies whether to automatically insert the default VAT product posting group code in the Def. VAT Prod. Posting Group field when you insert the corresponding general product posting group code from the Code field, for example on new item and resource cards, or in the item charges setup.', FRA = 'Spécifie s''il faut insérer automatiquement le code groupe comptabilisation produit TVA par défaut dans le champ Gpe compta. produit TVA défaut lorsque vous insérez le code groupe comptabilisation produit pertinent depuis le champ Code, par exemple sur de nouvelles fiches article et ressource ou sur les paramètres frais annexes.';
        }
        addafter("Def. VAT Prod. Posting Group")
        {
            // field("Def. Prod. Posting Free Group"; "Def. Prod. Posting Free Group")
            // {
            //     Visible = false;
            // }  // BC Upgrade NANDIS03
        }
        addafter("Auto Insert Default")
        {
            field("Include Timbre"; Rec."Include Timbre FND")
            {
                Description = 'HEI.02';
                ToolTip = 'The trigger for the Timbre electronique calculation on documents.';
                ApplicationArea = All;  // BC Upgrade NANDIS03
            }
        }
    }
    actions
    {
        modify("&Setup")
        {
            CaptionML = ENU = '&Setup', FRA = 'Para&mètres';
            ToolTipML = ENU = 'View or edit how you want to set up combinations of general business and general product posting groups.', FRA = 'Affichez ou modifiez la manière dont vous souhaitez configurer des combinaisons de groupes comptabilisation marché et produit.';

            //Unsupported feature: Change RunPageLink on ""&Setup"(Action 8)". Please convert manually.

        }
    }

    procedure GetSelectionFilter(): Text;
    var
        GenProductPostingGroup: Record "Gen. Product Posting Group";
        HeinekenBCUpgrade: Codeunit "Heineken BC Upgrade";  // BC Upgrade NANDIS03
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        //HEI.01>>
        CurrPage.SETSELECTIONFILTER(GenProductPostingGroup);
        //EXIT(SelectionFilterManagement.GetSelectionFilterForVATBusPostingGr(GenProductPostingGroup)); //commented by HEI.02
        //exit(SelectionFilterManagement.GetSelectionFilterForGenProdPostingGr(GenProductPostingGroup));  //HEI.02  // BC Upgrade NANDIS03
        HeinekenBCUpgrade.GetSelectionFilterForGenProdPostingGr(GenProductPostingGroup); // BC Upgrade NANDIS03
        //HEI.01<<
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

