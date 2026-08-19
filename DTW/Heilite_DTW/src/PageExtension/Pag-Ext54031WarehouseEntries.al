pageextension 54031 WarehouseEntriesExt extends "Warehouse Entries"
{
    // version NAVW110.0,DITW110.00.08,HEI.03

    //     DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457 Added fields "Work Order No."
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-LB IBM NASTAA02 15.10.2018 # Item Availability excluding Blocked Stock
    //   # New Fields added: "Unavailable Stock (Bin)", "Unavailable Stock (Quality)", "Quality Status"
    // HEI.02 IBM MATHEJ01 25.21.2020 - #CHG2044177: Report on warehouse entries additional filter on Item category code
    //   # New Field: "Item Category Code"
    // HEI.03 CHG2154364 SAHAL01 15.03.2023 Astro - I/F Production - ProductionOrderOperationLinePick
    //   # Added New Fields - External Document No.
    //                      - External Document No.2

    //Bc Upgrade YADAVM09 Drink it field Blocked.

    layout
    {
        modify("Entry Type")
        {
            ToolTipML = ENU = 'Specifies the entry type, which can be Negative Adjmt., Positive Adjmt., or Movement.', FRA = 'Spécifie le type d''écriture qui peut être Négatif (ajust.), Positif (ajust.) ou Mouvement.';
        }
        modify("Journal Batch Name")
        {
            ToolTipML = ENU = 'Specifies the name of the journal batch that the entry was posted from.', FRA = 'Spécifie le nom du lot comptabilité à partir duquel l''écriture a été validée.';
        }
        modify("Line No.")
        {
            ToolTipML = ENU = 'Specifies the line number of the warehouse document line or warehouse journal line that was registered.', FRA = 'Spécifie le numéro ligne du document entrepôt ou de la feuille entrepôt enregistrée.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location to which the entry is linked.', FRA = 'Spécifie le code du magasin auquel la ligne demande est liée.';
        }
        modify("Serial No.")
        {
            ToolTipML = ENU = 'Specifies the serial number.', FRA = 'Spécifie le numéro de série.';
        }
        modify("Lot No.")
        {
            ToolTipML = ENU = 'Specifies the lot number assigned to the warehouse entry.', FRA = 'Spécifie le numéro de lot qui est affecté à l''écriture entrepôt.';
        }
        modify("Expiration Date")
        {
            ToolTipML = ENU = 'Specifies the expiration date of the serial number.', FRA = 'Spécifie la date d''expiration du numéro de série.';
        }
        modify("Zone Code")
        {
            ToolTipML = ENU = 'Specifies the code of the zone to which the entry is linked.', FRA = 'Spécifie le code de la zone à laquelle l''écriture est associée.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies the code of the bin linked to the entry.', FRA = 'Spécifie le code de l''emplacement associé à l''écriture.';
        }
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item in the entry.', FRA = 'Spécifie le numéro de l''article dans l''écriture.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the warehouse entry.', FRA = 'Spécifie la description de l''écriture entrepôt.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the variant code for the item.', FRA = 'Spécifie le code variante pour l''article.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the number of units of the item in the warehouse entry.', FRA = 'Spécifie le nombre d''unités de l''article dans l''écriture entrepôt.';
        }
        modify("Qty. (Base)")
        {
            ToolTipML = ENU = 'Specifies the quantity of the entry, in the base unit of measure.', FRA = 'Spécifie la quantité de l''écriture, exprimée en unités de base.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the quantity per item unit of measure.', FRA = 'Spécifie la quantité par unité d''article.';
        }
        modify("Qty. per Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the number of base units of measure that are in the unit of measure specified for the item on the line.', FRA = 'Spécifie le nombre d''unités de base qui se trouvent dans l''unité spécifiée pour l''article dans la ligne.';
        }
        modify("Source Type")
        {
            ToolTipML = ENU = 'Specifies the table number that is the source of the entry line, for example, 39 for a purchase line, 37 for a sales line.', FRA = 'Spécifie le numéro de la table origine de la ligne écriture, par exemple, 39 pour une ligne achat ou 37 pour une ligne vente.';
        }
        modify("Source Subtype")
        {
            ToolTipML = ENU = 'Specifies the source subtype of the document to which the warehouse entry line relates.', FRA = 'Spécifie le sous-type origine du document auquel est liée la ligne écriture entrepôt.';
        }
        modify("Source Document")
        {
            ToolTipML = ENU = 'Specifies the type of document related to the line.', FRA = 'Spécifie le type de document associé à la ligne.';
        }
        modify("Source No.")
        {
            ToolTipML = ENU = 'Specifies the source number of the document from which the entry originates.', FRA = 'Spécifie le numéro source du document d''où est issue l''écriture.';
        }
        modify("Source Line No.")
        {
            ToolTipML = ENU = 'Specifies the source line number of the document from which the entry originates.', FRA = 'Spécifie le numéro de ligne source du document d''où est issue l''écriture.';
        }
        modify("Source Subline No.")
        {
            ToolTipML = ENU = 'Specifies the source subline number of the document from which the entry originates.', FRA = 'Spécifie le numéro de sous-ligne origine du document dont est issue l''écriture.';
        }
        modify("Reason Code")
        {
            ToolTipML = ENU = 'Specifies the reason code of the entry.', FRA = 'Spécifie le code motif de l''écriture.';
        }
        modify("No. Series")
        {
            ToolTipML = ENU = 'Specifies the posting or registering number series for the entry.', FRA = 'Spécifie la souche de numéros validation ou enregistrement de l''écriture.';
        }
        modify(Cubage)
        {
            ToolTipML = ENU = 'Specifies the total cubage of the items on the warehouse entry line.', FRA = 'Spécifie le volume total d''articles sur la ligne écriture entrepôt.';
        }
        modify(Weight)
        {
            ToolTipML = ENU = 'Specifies the total weight of items on the warehouse entry line.', FRA = 'Spécifie le poids total des articles sur la ligne écriture entrepôt.';
        }
        modify("Journal Template Name")
        {
            ToolTipML = ENU = 'Specifies the journal template name of the warehouse journal line for which the entry is created.', FRA = 'Spécifie le nom du modèle feuille de la ligne feuille entrepôt pour laquelle l''écriture est créée.';
        }
        modify("Whse. Document Type")
        {
            ToolTipML = ENU = 'Specifies the type of the document from which this entry originated.', FRA = 'Spécifie le type du document dont est issue cette écriture.';
        }
        modify("Whse. Document No.")
        {
            ToolTipML = ENU = 'Specifies the number of the warehouse document from which this entry originated.', FRA = 'Spécifie le numéro du document entrepôt dont est issue cette écriture.';
        }
        modify("Registering Date")
        {
            ToolTipML = ENU = 'Specifies the date the entry was registered.', FRA = 'Spécifie la date à laquelle l''écriture a été enregistrée.';
        }
        modify("User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user entering or posting this entry.', FRA = 'Spécifie le code de l''utilisateur qui saisit ou valide l''écriture.';
        }
        modify("Entry No.")
        {
            ToolTipML = ENU = 'Specifies the entry number for the entry.', FRA = 'Spécifie le numéro d''écriture de l''écriture.';
        }
        addafter("Qty. per Unit of Measure")
        {
            field("Item Category Code"; Rec."Item Category Code FND")
            {
                ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
            }
        }
        // addafter("User ID")
        // {
        //     field("Work Order No."; Rec."Work Order No.")
        //     {
        //         Visible = false;
        //     }
        // }//Bc Upgrade YADAVM09 Drink it field<<
        addafter("Entry No.")
        {
            field("Unavailable Stock (Bin)"; Rec."Unavailable Stock (Bin) FND")
            {
                Visible = false;
                ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
            }
            field("Unavailable Stock (Quality)"; Rec."Unavail. Stock (Quality) FND")
            {
                ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
            }
            field("Quality Status"; Rec."Quality Status FND")
            {
                Visible = false;
                ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
            }
            field("External Document No."; Rec."External Document No. FND")
            {
                ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
            }
            field("External Document No.2"; Rec."External Document No.2 FND")
            {
                ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
            }
            //Bc Upgrade PATHAA02 GAP014_DTW, IBM GAP DTW 43 >>
            field("Inspection Status"; Rec."Inspection Status FND")
            {
                ApplicationArea = ALL;
            }
            //Bc Upgrade PATHAA02 GAP014_DTW, IBM GAP DTW 43 <<
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

