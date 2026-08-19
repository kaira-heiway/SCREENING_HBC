pageextension 51032 VATProductPostingGroupsExtCBN extends "VAT Product Posting Groups"
{
    // version NAVW110.0,HEI.01
    //     HEI.01 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //   # New Field added: "TIN No."
    // HEI.02 FDD-HT670 IBM BULIMC01 18.02.2020 #new function created: "GetSelectionFilter"

    //BC Upgrade PATHAA02 01/09/25 

    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a code for the VAT product posting group.', FRA = 'Spécifie un code pour le groupe comptabilisation produit TVA.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description for the product posting group.', FRA = 'Spécifie une description pour le groupe comptabilisation produit.';
        }
        addafter(Description)
        {
            field("TIN No."; Rec."TIN No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TIN No. field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the TIN No. field.';

            }
        }
    }
    actions
    {
        modify("&Setup")
        {
            CaptionML = ENU = '&Setup', FRA = 'Para&mètres';
            ToolTipML = ENU = 'View or edit combinations of Tax business posting groups and Tax product posting groups. Fill in a line for each combination of VAT business posting group and VAT product posting group.', FRA = 'Affichez ou modifiez des combinaisons de Groupes compta. marché TVA et de Groupes compta. produit TVA. Remplissez une ligne pour chaque combinaison de groupe comptabilisation marché TVA et de groupe comptabilisation produit TVA.';

            //Unsupported feature: Change RunPageLink on ""&Setup"(Action 8)". Please convert manually.

        }
    }

    procedure GetSelectionFilter(): Text;
    var
        VATProductPostingGroup: Record "VAT Product Posting Group";
        HNKBCUpgrade: Codeunit "Heineken BC Upgrade";
    begin
        //HEI.02<<
        CurrPage.SETSELECTIONFILTER(VATProductPostingGroup);
        exit(HNKBCUpgrade.GetSelectionFilterForVATProdPostingGr(VATProductPostingGroup));//BC UPGRADE PATHAA02
        //HEI.02>>
    end;
}

