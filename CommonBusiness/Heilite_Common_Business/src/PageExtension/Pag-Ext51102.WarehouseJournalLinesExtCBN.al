pageextension 51102 WarehouseJournalLinesExtCBN extends "Warehouse Journal Lines"
{
    //  HEI.01 CHG2154364 SAHAL01 15.03.2023 Astro - I/F Production - ProductionOrderOperationLinePick
    //   # Added New Fields - External Document No.
    //                      - External Document No.2
    // version NAVW110.0,HEI.01

    layout
    {
        modify("Journal Template Name")
        {
            ToolTipML = ENU = 'Specifies the name of the journal template that applies to the line.', FRA = 'Spécifie le nom du modèle feuille qui s''applique à la ligne.';
        }
        modify("Journal Batch Name")
        {
            ToolTipML = ENU = 'Specifies the name of the journal batch that applies to the line.', FRA = 'Spécifie le nom du lot feuille qui s''applique à la ligne.';
        }
        modify("Line No.")
        {
            ToolTipML = ENU = 'Specifies the number of the warehouse journal line.', FRA = 'Spécifie le numéro de la ligne feuille entrepôt.';
        }
        modify("Entry Type")
        {
            ToolTipML = ENU = 'Specifies the type of transaction that will be registered from the line.', FRA = 'Spécifie le type de transaction qui sera enregistrée à partir de la ligne.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location to which the journal line applies.', FRA = 'Spécifie le code emplacement auquel s''applique la ligne feuille.';
        }
        modify("From Zone Code")
        {
            ToolTipML = ENU = 'Specifies the code of the zone from which the item on the journal line is taken.', FRA = 'Spécifie le code de la zone d''origine de l''article de la ligne feuille.';
        }
        modify("From Bin Code")
        {
            ToolTipML = ENU = 'Specifies the code of the bin from which the item on the journal line is taken.', FRA = 'Spécifie le code de l''emplacement d''origine de l''article de la ligne feuille.';
        }
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item on the journal line.', FRA = 'Spécifie le numéro de l''article de la ligne feuille.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the number of units of the item in the adjustment (positive or negative) or the reclassification.', FRA = 'Spécifie le nombre d''unités article présentes dans l''ajustement (positif ou négatif) ou dans le reclassement.';
        }
        modify("Qty. (Absolute, Base)")
        {
            ToolTipML = ENU = 'Specifies the quantity expressed as an absolute (positive) number, in the base unit of measure.', FRA = 'Spécifie la quantité, exprimée sous la forme d''un nombre absolu (positif), en unité de base.';
        }
        modify("To Zone Code")
        {
            ToolTipML = ENU = 'Specifies the code of the zone to which the item on the journal line will be moved.', FRA = 'Spécifie le code de la zone vers laquelle l''article de la ligne feuille sera déplacé.';
        }
        modify("To Bin Code")
        {
            ToolTipML = ENU = 'Specifies the code of the bin to which the item on the journal line will be moved.', FRA = 'Spécifie le code de l''emplacement vers lequel l''article de la ligne feuille sera déplacé.';
        }
        modify("Reason Code")
        {
            ToolTipML = ENU = 'Specifies the reason code for the warehouse journal line.', FRA = 'Spécifie le code motif de la ligne feuille entrepôt.';
        }
        modify(Cubage)
        {
            ToolTipML = ENU = 'Specifies the total cubage of the items on the warehouse journal line.', FRA = 'Spécifie le volume total d''articles sur la ligne feuille entrepôt.';
        }
        modify(Weight)
        {
            ToolTipML = ENU = 'Specifies the total weight of items on the warehouse journal line.', FRA = 'Spécifie le poids total d''articles sur la ligne feuille entrepôt.';
        }
        modify("User ID")
        {
            ToolTipML = ENU = 'Specifies the User ID of the user who created the warehouse journal line.', FRA = 'Spécifie le code de l''utilisateur qui a créé la ligne feuille entrepôt.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the code of the item variant.', FRA = 'Spécifie le code de variante de l''article.';
        }
        modify("Qty. per Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the number of base units of measure in the unit of measure specified for the item on the journal line.', FRA = 'Spécifie le nombre d''unités de base qui se trouvent dans l''unité spécifiée pour l''article dans la ligne feuille.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the code of the unit of measure for this item.', FRA = 'Spécifie le code unité de l''article.';
        }

        //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Journal Template Name"(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Journal Template Name"(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Journal Batch Name"(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Journal Batch Name"(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Line No."(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Line No."(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Entry Type"(Control 30)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Entry Type"(Control 30)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""From Zone Code"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""From Zone Code"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""From Bin Code"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""From Bin Code"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Item No."(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Item No."(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Quantity(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Quantity(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Qty. (Absolute, Base)"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Qty. (Absolute, Base)"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""To Zone Code"(Control 20)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""To Zone Code"(Control 20)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""To Bin Code"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""To Bin Code"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Reason Code"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Reason Code"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Cubage(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Cubage(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Weight(Control 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Weight(Control 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""User ID"(Control 32)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""User ID"(Control 32)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Variant Code"(Control 34)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Variant Code"(Control 34)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Qty. per Unit of Measure"(Control 36)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Qty. per Unit of Measure"(Control 36)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit of Measure Code"(Control 38)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit of Measure Code"(Control 38)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900000007(Control 1900000007)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900383207(Control 1900383207)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1905767507(Control 1905767507)". Please convert manually.

        addafter("Unit of Measure Code")
        {
            field("External Document No."; Rec."External Document No. FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the External Document No. field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the External Document No. field.';

            }
            field("External Document No.2"; Rec."External Document No.2 FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the External Document No.2 field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the External Document No.2 field.';

            }
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

