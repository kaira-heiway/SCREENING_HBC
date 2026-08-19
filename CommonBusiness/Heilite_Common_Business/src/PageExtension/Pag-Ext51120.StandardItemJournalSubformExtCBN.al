pageextension 51120 StandardItemJnlSubformExt extends "Standard Item Journal Subform"
{
    //BC Upgrade KAPOOV01 05.11.2025 # field-Description made non-editable in NAV version it was made non-editable on table level under HEI.01
    // version NAVW110.0


    layout
    {
        modify("Entry Type")
        {
            ToolTipML = ENU = 'Specifies which type of transaction that the entry is created from.', FRA = 'Spécifie le type de transaction à partir duquel l''écriture est créée.';
        }
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item on the journal line.', FRA = 'Spécifie le numéro de l''article de la ligne feuille.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the variant of the item on the line.', FRA = 'Indique la variante de l''article sur la ligne.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the description of the item on the line.', FRA = 'Spécifie la description de l''article sur la ligne.';
            Editable = false; //BC Upgrade KAPOOV01 field made non-editable on table level under HEI.01
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code that the item journal line is linked to.', FRA = 'Spécifie le code section analytique qui est lié à cette ligne feuille article.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code that the item journal line is linked to.', FRA = 'Spécifie le code section analytique qui est lié à cette ligne feuille article.';
        }

        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[3]"(Control 18)". Please convert manually.


        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[4]"(Control 20)". Please convert manually.


        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[5]"(Control 22)". Please convert manually.


        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[6]"(Control 24)". Please convert manually.


        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[7]"(Control 26)". Please convert manually.


        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[8]"(Control 32)". Please convert manually.

        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location code for the item on the line.', FRA = 'Indique le code magasin pour l''article sur la ligne.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies the bin code for the items on the line.', FRA = 'Spécifie le code emplacement des articles de la ligne.';
        }
        modify("Salespers./Purch. Code")
        {
            ToolTipML = ENU = 'Specifies the code for the salesperson or purchaser who is linked to the sale or purchase on the journal line.', FRA = 'Spécifie le code du vendeur ou de l''acheteur lié à la vente ou à l''achat de la ligne feuille.';
        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the posting group of the master record on the journal line.', FRA = 'Spécifie le groupe comptabilisation de l''enregistrement principal de la ligne feuille.';
        }
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general product account in the general ledger to which transactions involving the item are posted.', FRA = 'Spécifie le groupe comptabilisation dans la comptabilité dans lequel des transactions impliquant l''article sont validées.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the quantity of the item in the journal line.', FRA = 'Spécifie le quantité de l''article dans la ligne feuille.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies a unit of measure code that has been set up in the Unit of Measure table.', FRA = 'Spécifie un code d''unité de mesure qui a été défini dans la table Unité.';
        }
        modify("Unit Amount")
        {
            ToolTipML = ENU = 'Specifies the amount of the unit in the line of the journal line.', FRA = 'Spécifie le montant de l''unité de la ligne de la ligne feuille.';
        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the amount of the unit in the line of the journal line.', FRA = 'Spécifie le montant de l''unité de la ligne de la ligne feuille.';
        }
        modify("Indirect Cost %")
        {
            ToolTipML = ENU = 'Specifies the item indirect cost.', FRA = 'Spécifie le coût indirect de l''article.';
        }
        modify("Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the cost of the unit in the line of the journal line.', FRA = 'Spécifie le coût de l''unité de la ligne de la ligne feuille.';
        }
        modify("Transaction Type")
        {
            ToolTipML = ENU = 'Specifies the transaction type of the item journal line.', FRA = 'Spécifie le type de transaction de la ligne feuille article.';
        }
        modify("Transport Method")
        {
            ToolTipML = ENU = 'Specifies the code for the transport method used for the item.', FRA = 'Spécifie le code pour le mode de transport utilisé pour l''article.';
        }
        modify("Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region code of the item.', FRA = 'Spécifie le code pays/région de l''article.';
        }
        modify("Reason Code")
        {
            ToolTipML = ENU = 'Specifies the template that is the source of the journal line.', FRA = 'Spécifie le modèle source lié de la ligne feuille.';
        }

        //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Entry Type"(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Entry Type"(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Item No."(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Item No."(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Variant Code"(Control 34)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Variant Code"(Control 34)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Description(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Description(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 30)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 30)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""ShortcutDimCode[3]"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""ShortcutDimCode[4]"(Control 20)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""ShortcutDimCode[5]"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""ShortcutDimCode[6]"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""ShortcutDimCode[7]"(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""ShortcutDimCode[8]"(Control 32)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 36)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 36)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bin Code"(Control 38)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bin Code"(Control 38)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Salespers./Purch. Code"(Control 40)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Salespers./Purch. Code"(Control 40)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Gen. Bus. Posting Group"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Gen. Bus. Posting Group"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Gen. Prod. Posting Group"(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Gen. Prod. Posting Group"(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Quantity(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Quantity(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit of Measure Code"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit of Measure Code"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit Amount"(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit Amount"(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Amount(Control 42)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Amount(Control 42)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Indirect Cost %"(Control 44)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Indirect Cost %"(Control 44)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit Cost"(Control 46)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit Cost"(Control 46)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transaction Type"(Control 48)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transaction Type"(Control 48)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transport Method"(Control 50)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Transport Method"(Control 50)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Country/Region Code"(Control 52)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Country/Region Code"(Control 52)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Reason Code"(Control 54)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Reason Code"(Control 54)". Please convert manually.

    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify(Dimensions)
        {

            //Unsupported feature: Change AccessByPermission on "Dimensions(Action 1900206304)". Please convert manually.

            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }

        //Unsupported feature: PropertyDeletion on "ActionContainer1900000004(Action 1900000004)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Line"(Action 1907935204)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Dimensions(Action 1900206304)". Please convert manually.

    }

    //Unsupported feature: PropertyModification on "GetSourceCodeFromJnlTemplate(PROCEDURE 1).ItemJnlTemplate(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //GetSourceCodeFromJnlTemplate : "Item Journal Template";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //GetSourceCodeFromJnlTemplate : 82;
    //Variable type has not been exported.


    //Unsupported feature: CodeModification on "GetSourceCodeFromJnlTemplate(PROCEDURE 1)". Please convert manually.

    //procedure GetSourceCodeFromJnlTemplate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemJnlTemplate.GET("Journal Template Name");
    exit(ItemJnlTemplate."Source Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ItemJnlTemplate.GET("Journal Template Name");
    EXIT(ItemJnlTemplate."Source Code");
    */
    //end;

    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

