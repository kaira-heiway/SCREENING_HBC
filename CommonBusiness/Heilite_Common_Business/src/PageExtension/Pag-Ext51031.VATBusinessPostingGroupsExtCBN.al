pageextension 51031 VATBusinessPostingGroupsExtCBN extends "VAT Business Posting Groups"
{
    //BC Upgrade PATHAA02 01/09/25 

    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a code for the group.', FRA = 'Spécifie un code pour le groupe.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description for the VAT business posting group.', FRA = 'Spécifie une description pour le groupe comptabilisation marché TVA.';
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
        VATBusinessPostingGroup: Record "VAT Business Posting Group";
        HNKBCUpgrade: Codeunit "Heineken BC Upgrade";
    begin
        //HEI.01<<
        CurrPage.SETSELECTIONFILTER(VATBusinessPostingGroup);
        exit(HNKBCUpgrade.GetSelectionFilterForVATBusPostingGr(VATBusinessPostingGroup)); //BC UPGRADE PATHAA02
        //HEI.01<<
    end;


}

