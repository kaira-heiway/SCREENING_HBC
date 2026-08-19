pageextension 54029 PostedWhseShipmentSubformExt extends "Posted Whse. Shipment Subform"
{
    // version NAVW110.0,DITW110.00.08,HEI.02

    //     DITW15.00.00.21 DDR 18/06/2008 Added new columns
    //                                  "Weight","Cubage"
    // DITW15.00.00.33 DDR 13/05/2009 Added columns "Item DTax Group Code","Src. DTax Group Code" (non-visible)
    // DITW15.00.00.37 DDR 10/06/2010 issue 1061 Added fields "Location Code","Physical Location Group Code"
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields "Delivery Sequence","Route"
    // DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
    //                                Added shortcut (warehouse) fields
    //                                  Control1100079000 Shortcut Unit of Measure1 Code
    //                                  Control1100079001 Shortcut Unit of Measure2 Code
    //                                  Control1100079002 Shortcut Unit of Measure3 Code
    //                                Added Standard Global Dimension Lookup (see from 53 as reference)

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new fields added "Load No." & "Sequence No."
    // HEI.02 CHG2217161 SAHAL01 02.11.2023 SPL for Returns and GR cancellations
    //   # Added New Fields - SPL Code
    //                      - SPL Name
    //                      - Consumption SPL Code

    //Bc Upgrade YADAVM09 Field property Added.
    //Bc Upgrade YADAVM09 Drink it field blocked.
    //Bc Upgrade YADAVM09 "Load No." & "Sequence No." fields added in interface extension.

    layout
    {
        modify("Source Document")
        {
            ToolTipML = ENU = 'Specifies the type of document to which the line relates.', FRA = 'Spécifie le type de document auquel la ligne fait référence.';
        }
        modify("Source No.")
        {
            ToolTipML = ENU = 'Specifies the source number of the document from which the line originates.', FRA = 'Spécifie le numéro source du document d''où est issue la ligne demande.';
        }
        modify("Source Line No.")
        {
            ToolTipML = ENU = 'Specifies the source line number of the document from which the entry originates.', FRA = 'Spécifie le numéro de ligne source du document d''où est issue l''écriture.';
        }
        modify("Destination Type")
        {
            ToolTipML = ENU = 'Specifies the type of destination associated with the posted warehouse shipment line.', FRA = 'Spécifie le type de destination associé à la ligne expédition entrepôt enregistrée.';
        }
        modify("Destination No.")
        {
            ToolTipML = ENU = 'Specifies the number of the customer, vendor, or location to which the items have been shipped.', FRA = 'Spécifie le numéro du client, du fournisseur ou du magasin auquel les articles ont été expédiés.';
        }
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item that has been shipped.', FRA = 'Spécifie le numéro de l''article qui a été expédié.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the variant number of the item on the line, if any.', FRA = 'Indique le numéro de variante pour l''article sur la ligne, le cas échéant.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the description of the item on the line.', FRA = 'Spécifie la description de l''article sur la ligne.';
        }
        modify("Description 2")
        {
            ToolTipML = ENU = 'Specifies the a second description of the item on the line, if any.', FRA = 'Indique une deuxième description de l''article sur la ligne, le cas échéant.';
        }
        modify("Zone Code")
        {
            ToolTipML = ENU = 'Specifies the code of the zone where the bin on this posted shipment line is located.', FRA = 'Spécifie le code de la zone dans laquelle est situé l''emplacement de cette ligne expédition validée.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies the code of the bin on the posted warehouse shipment line.', FRA = 'Spécifie le code de l''emplacement qui figure sur la ligne expédition entrepôt.';
        }
        modify("Shelf No.")
        {
            ToolTipML = ENU = 'Specifies the shelf number of the item for informational use.', FRA = 'Spécifie le numéro de rayon de l''article, à titre informatif.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the quantity that was shipped.', FRA = 'Spécifie la quantité qui a été expédiée.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code of the line.', FRA = 'Spécifie le code unité de l''article de la ligne.';
        }
        modify("Shipping Advice")
        {
            ToolTipML = ENU = 'Specifies the shipping advice for the posted warehouse shipment line.', FRA = 'Spécifie l''option d''expédition de la ligne expédition entrepôt validée.';
        }
        // addafter("Source Line No.")
        // {
        //     field("Src. DTax Group Code"; Rec."Src. DTax Group Code")
        //     {
        //         Visible = false;
        //     }
        // }
        // addafter("Destination No.")
        // {
        //     field(Route; Rec.Route)
        //     {
        //     }
        //     field("Delivery Sequence"; Rec."Delivery Sequence")
        //     {
        //         Visible = false;
        //     }
        // }
        // addafter("Item No.")
        // {
        //     field("Item DTax Group Code"; "Item DTax Group Code")
        //     {
        //         Visible = false;
        //     }
        // } //Bc Upgrade YADAVM09 Drik it fields<<
        addafter("Description 2")
        {
            // field("Physical Location Group Code"; "Physical Location Group Code")
            // {
            //     Visible = false;
            // }//Bc Upgrade YADAVM09 Drink it field<<
            field("Location Code"; Rec."Location Code")
            {
                Visible = false;
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
        }
        // addafter("Unit of Measure Code")
        // {
        //     field(Weight; Rec.Weight)
        //     {
        //     }
        //     field(Cubage; Rec.Cubage)
        //     {
        //     }
        // }//Bc Upgrade YADAVM09 Drink it Fields<<
        addafter("Shipping Advice")
        {
            // field("ShortcutQtyUomValue[1]"; ShortcutQtyUomValue[1])
            // {
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassUom(1);
            //     DecimalPlaces = 0 : 5;
            //     Description = 'DIT-715 #244';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("ShortcutQtyUomValue[2]"; ShortcutQtyUomValue[2])
            // {
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassUom(2);
            //     DecimalPlaces = 0 : 5;
            //     Description = 'DIT-715 #244';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("ShortcutQtyUomValue[3]"; ShortcutQtyUomValue[3])
            // {
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassUom(3);
            //     DecimalPlaces = 0 : 5;
            //     Description = 'DIT-715 #244';
            //     Editable = false;
            //     Visible = false;
            // } //Bc Upgrade YADAVM09 Drink it Fields<<
            // field("Load No."; Rec."Load No.")
            // {
            //     Description = 'HEI.01';
            //     Visible = false;
            //     ApplicationArea = All;//Bc Upgrade YADAVM09<<
            // }
            // field("Sequence No."; Rec."Sequence No.")
            // {
            //     Description = 'HEI.01';
            //     Visible = false;
            //     ApplicationArea = All;//Bc Upgrade YADAVM09<<
            // }//Bc Upgrade YADAVM09 Added in interface Extension<<
            field("SPL Code"; Rec."SPL Code FND")
            {
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
            field("SPL Name"; Rec."SPL Name FND")
            {
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
            field("Consumption SPL Code"; Rec."Consumption SPL Code FND")
            {
                Visible = false;
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
        }
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify("Posted Source Document")
        {
            CaptionML = ENU = 'Posted Source Document', FRA = 'Document origine enreg.';
        }
        modify("Whse. Document Line")
        {
            CaptionML = ENU = 'Whse. Document Line', FRA = 'Ligne document entrepôt';
        }
        modify("Bin Contents List")
        {
            CaptionML = ENU = 'Bin Contents List', FRA = 'Liste contenus emplacement';
        }
    }

    var
        ShortcutQtyUomValue: array[3] of Decimal;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //begin
    /*
    // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
    ShowShortcutUomValue(ShortcutQtyUomValue);
    // >>DITW16.00.00.40 DDR DIT-715 #244
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

