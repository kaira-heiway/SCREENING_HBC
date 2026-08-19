pageextension 51025 GenBusinessPostingGroupsExtCBN extends "Gen. Business Posting Groups"
{
    // version NAVW110.0
    //HEI.01 FDD-HT671 IBM BULIMC01 18.02.2020 #new function created "GetSelectionFilter"

    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a code for the business group.', FRA = 'Spécifie un code pour le groupe comptabilisation marché.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description for the general business posting group.', FRA = 'Spécifie une description pour le groupe comptabilisation marché.';
        }
        modify("Def. VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a default VAT business group code.', FRA = 'Spécifie un code groupe comptabilisation marché TVA par défaut.';
        }
        modify("Auto Insert Default")
        {
            ToolTipML = ENU = 'Specifies whether to automatically insert the Def. VAT Bus. Posting Group when the corresponding Code is inserted on new customer and vendor cards.', FRA = 'Spécifie s''il convient d''insérer automatiquement le Gpe compta. marché TVA défaut lorsque le code correspondant est inséré dans les nouvelles fiches client et fournisseur.';
        }

        //Unsupported feature: CodeModification on ""Def. VAT Bus. Posting Group"(Control 9).OnValidate". Please convert manually.

        //trigger  VAT Bus();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Def. VAT Bus. Posting Group" <> xRec."Def. VAT Bus. Posting Group" THEN
          IF NOT CONFIRM(Text000,FALSE,Code,xRec."Def. VAT Bus. Posting Group") THEN
            ERROR('');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Def. VAT Bus. Posting Group" <> xRec."Def. VAT Bus. Posting Group" then
          if not CONFIRM(Text000,false,Code,xRec."Def. VAT Bus. Posting Group") then
            ERROR('');
        */
        //end;
        addafter("Auto Insert Default")
        {
            field("Market Type"; Rec."Market Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Market Type field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Market Type field.';

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


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=This will change all occurrences of VAT Bus. Posting Group in G/L Account, Customer, and Vendor tables\where Gen. Bus. Posting Group is %1\and VAT Bus. Posting Group is %2. Are you sure that you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=This will change all occurrences of VAT Bus. Posting Group in G/L Account, Customer, and Vendor tables\where Gen. Bus. Posting Group is %1\and VAT Bus. Posting Group is %2. Are you sure that you want to continue?;FRA=Cette opération va modifier toutes les occurrences de Groupe compta. marché TVA dans les tables Compte général, Client et Fournisseur\où Groupe compta. marché est %1\et Groupe compta. marché TVA est %2. Útes-vous sûr de vouloir continuer ?;
    //Variable type has not been exported.

    procedure GetSelectionFilter(): Text;
    var
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
        SelectionFilterManagement: Codeunit "Heineken BC Upgrade";
    begin
        //HEI.01>>
        CurrPage.SETSELECTIONFILTER(GenBusinessPostingGroup);
        exit(SelectionFilterManagement.GetSelectionFilterForGenBusPostingGr(GenBusinessPostingGroup));  // BC Upgrade NANDIS03 - Blocked for compilation
        //HEI.01<<
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

