pageextension 54028 PostedWhseReceiptSubformExt extends "Posted Whse. Receipt Subform"
{
    //     // version NAVW110.0,DITW110.00.08,HEI.04

    // DITW15.00.00.21 DDR 18/06/2008 Added new columns "Weight","Cubage"
    // DITW15.00.00.33 DDR 13/05/2009 Added columns
    //                                  "Source Line No.","Item DTax Group Code","Src. DTax Group Code" (non-visible)
    // DITW15.00.00.37 DDR 10/06/2010 issue 1061 Added fields "Location Code","Physical Location Group Code"
    // DITW15.00.00.39 DDR 12/04/2011 issue 1296 Added AAD/ARC functionnality
    //                                  Added fields
    //                                    "AAD No.","ARC No.","SAD No.","ARC Line No.",
    //                                    "Unsatisfactory reason","Unsatisfactory quantity","unsatisfactory comments"
    //                                  Added functions
    //                                    ShowLineUnstatisfactoryCmts()
    //                     11/07/2011 issue 1369 Added fields "Applies-to AAD Trck. Entry No."
    // DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
    //                                Added shortcut (warehouse) fields
    //                                  Control1100079000 Shortcut Unit of Measure1 Code
    //                                  Control1100079001 Shortcut Unit of Measure2 Code
    //                                  Control1100079002 Shortcut Unit of Measure3 Code
    //                                Added Standard Global Dimension Lookup (see from 53 as reference)

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD LOGGAP08 IBM POSTOI01 29.05.2018
    //   # show new field Source Original Quantity
    // HEI.02 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new fields added "Load No." & "Sequence No."
    // HEI.03 CHG2162715 HB3020 NORRIQ KOROLA04 07.11.2022
    //   # SPL Code, SPL Name - fields created
    // HEI.04 CHG2217161 SAHAL01 09.11.2023 SPL for Returns and GR cancellations
    //   # Added New Field - Consumption SPL Code

    //Bc Upgrade YADAVM09 Drink it field blocked.
    //Bc Upgrade YADAVM09 "Load No." & "Sequence No." fields added in interface extension.

    layout
    {
        modify("Source Document")
        {
            ToolTipML = ENU = 'Specifies the type of document to which the line relates.', FRA = 'Spécifie le type de document auquel la ligne fait référence.';
            Editable = false;//Bc Upgrade YADAVM09<< 
            //Unsupported feature: Change Editable on ""Source Document"(Control 2)". Please convert manually.

        }
        modify("Source No.")
        {
            ToolTipML = ENU = 'Specifies the source number of the document from which the line originates.', FRA = 'Spécifie le numéro source du document d''où est issue la ligne demande.';
            Editable = false;//Bc Upgrade YADAVM09<< 
            //Unsupported feature: Change Editable on ""Source No."(Control 6)". Please convert manually.

        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies the date that the receipt line was due.', FRA = 'Spécifie la date d''échéance de la ligne réception.';
            Editable = false;//Bc Upgrade YADAVM09<< 
            //Unsupported feature: Change Editable on ""Due Date"(Control 62)". Please convert manually.

        }
        modify("Shelf No.")
        {
            ToolTipML = ENU = 'Specifies the shelf number of the item for informational use.', FRA = 'Spécifie le numéro de rayon de l''article, à titre informatif.';
            Editable = false;//Bc Upgrade YADAVM09<< 
            Visible = false;//Bc Upgrade YADAVM09<<
            //Unsupported feature: Change Editable on ""Shelf No."(Control 18)". Please convert manually.

        }
        modify("Zone Code")
        {
            ToolTipML = ENU = 'Specifies the code of the zone on this posted receipt line.', FRA = 'Spécifie le code de la zone qui figure sur cette ligne réception enregistrée.';
            Editable = false;//Bc Upgrade YADAVM09<< 
            Visible = false;//Bc Upgrade YADAVM09<<
            //Unsupported feature: Change Editable on ""Zone Code"(Control 10)". Please convert manually.

        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies the code of the bin on the posted receipt line.', FRA = 'Spécifie le code de l''emplacement qui figure sur la ligne réception enregistrée.';
            Visible = false;//Bc Upgrade YADAVM09<<
            Editable = false;//Bc Upgrade YADAVM09<< 
            //Unsupported feature: Change Editable on ""Bin Code"(Control 8)". Please convert manually.

        }
        modify("Cross-Dock Zone Code")
        {
            ToolTipML = ENU = 'Specifies the zone code used to create the cross-dock put-away for this line when the receipt was posted.', FRA = 'Spécifie le code zone utilisé pour créer le rangement transbordement pour cette ligne lorsque la réception a été enregistrée.';
            Visible = false;//Bc Upgrade YADAVM09<<
            Editable = false;//Bc Upgrade YADAVM09<< 
            //Unsupported feature: Change Editable on ""Cross-Dock Zone Code"(Control 38)". Please convert manually.

        }
        modify("Cross-Dock Bin Code")
        {
            ToolTipML = ENU = 'Specifies the bin code used to create the cross-dock put-away for this line when the receipt was posted.', FRA = 'Spécifie le code emplacement utilisé pour créer le rangement transbordement pour cette ligne lorsque la réception a été enregistrée.';
            Visible = false;//Bc Upgrade YADAVM09<<
            Editable = false;//Bc Upgrade YADAVM09<< 
            //Unsupported feature: Change Editable on ""Cross-Dock Bin Code"(Control 40)". Please convert manually.

        }
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item that was received and posted.', FRA = 'Spécifie le numéro de l''article réceptionné et enregistré.';
            Editable = false;//Bc Upgrade YADAVM09<< 
            //Unsupported feature: Change Editable on ""Item No."(Control 22)". Please convert manually.

        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the variant number of the item in the line, if any.', FRA = 'Indique le numéro de variante pour l''article sur la ligne, le cas échéant.';
            Visible = false;//Bc Upgrade YADAVM09<<
            Editable = false;//Bc Upgrade YADAVM09<< 
            //Unsupported feature: Change Editable on ""Variant Code"(Control 24)". Please convert manually.

        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the description of the item in the line.', FRA = 'Spécifie la description de l''article de la ligne.';
            Editable = false;//Bc Upgrade YADAVM09<< 
            //Unsupported feature: Change Editable on "Description(Control 30)". Please convert manually.

        }
        modify("Description 2")
        {
            ToolTipML = ENU = 'Specifies a second description of the item in the line, if any.', FRA = 'Indique une deuxième description de l''article sur la ligne, le cas échéant.';
            Visible = false;//Bc Upgrade YADAVM09<<
            Editable = false;//Bc Upgrade YADAVM09<< 
            //Unsupported feature: Change Editable on ""Description 2"(Control 32)". Please convert manually.

        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the quantity that was received.', FRA = 'Spécifie la quantité qui a été réceptionnée.';
            Editable = false;//Bc Upgrade YADAVM09<< 
            //Unsupported feature: Change Editable on "Quantity(Control 4)". Please convert manually.

        }
        modify("Qty. (Base)")
        {
            ToolTipML = ENU = 'Specifies the quantity that was received, in the base unit of measure.', FRA = 'Spécifie la quantité réceptionnée exprimée en unité de base.';
            Visible = false;//Bc Upgrade YADAVM09<<
            Editable = false;//Bc Upgrade YADAVM09<< 
            //Unsupported feature: Change Editable on ""Qty. (Base)"(Control 12)". Please convert manually.

        }
        modify("Qty. Put Away")
        {
            ToolTipML = ENU = 'Specifies the quantity that is put away.', FRA = 'Spécifie la quantité qui a été rangée.';
            Visible = false;//Bc Upgrade YADAVM09<<
            Editable = false;//Bc Upgrade YADAVM09<< 
            //Unsupported feature: Change Editable on ""Qty. Put Away"(Control 14)". Please convert manually.

        }
        modify("Qty. Cross-Docked")
        {
            ToolTipML = ENU = 'Specifies the quantity of items that was in the Qty. To Cross-Dock field on the warehouse receipt line when it was posted.', FRA = 'Spécifie la quantité d''articles indiquée dans le champ Qté à transborder de la ligne réception entrepôt lorsqu''elle a été enregistrée.';
            Visible = false;//Bc Upgrade YADAVM09<<
            Editable = false;//Bc Upgrade YADAVM09<< 
            //Unsupported feature: Change Editable on ""Qty. Cross-Docked"(Control 34)". Please convert manually.

        }
        modify("Qty. Put Away (Base)")
        {
            ToolTipML = ENU = 'Specifies the quantity that is put away, in the base unit of measure.', FRA = 'Spécifie la quantité rangée exprimée en unité de base.';
            Visible = false;//Bc Upgrade YADAVM09<<
            Editable = false;//Bc Upgrade YADAVM09<< 
            //Unsupported feature: Change Editable on ""Qty. Put Away (Base)"(Control 16)". Please convert manually.

        }
        modify("Qty. Cross-Docked (Base)")
        {
            ToolTipML = ENU = 'Specifies the base quantity of items in the Qty. To Cross-Dock (Base) field on the warehouse receipt line when it was posted.', FRA = 'Spécifie la quantité de base d''articles indiquée dans le champ Qté à transborder de la ligne réception entrepôt lorsqu''elle a été enregistrée.';
            Visible = false;//Bc Upgrade YADAVM09<<
            Editable = false;//Bc Upgrade YADAVM09<< 
            //Unsupported feature: Change Editable on ""Qty. Cross-Docked (Base)"(Control 36)". Please convert manually.

        }
        modify("Put-away Qty.")
        {
            ToolTipML = ENU = 'Specifies the quantity on put-away instructions in the process of being put away.', FRA = 'Spécifie la quantité figurant dans les instructions de rangement, qui est en cours de rangement.';
            Visible = false;//Bc Upgrade YADAVM09<<
            Editable = false;//Bc Upgrade YADAVM09<< 
            //Unsupported feature: Change Editable on ""Put-away Qty."(Control 20)". Please convert manually.

        }
        modify("Put-away Qty. (Base)")
        {
            ToolTipML = ENU = 'Specifies the quantity on put-away instructions, in the base unit of measure, in the process of being put away.', FRA = 'Spécifie la quantité figurant dans les instructions de rangement, exprimée en unité de base, qui est en cours de rangement.';
            Visible = false;//Bc Upgrade YADAVM09<<
            Editable = false;//Bc Upgrade YADAVM09<< 
            //Unsupported feature: Change Editable on ""Put-away Qty. (Base)"(Control 28)". Please convert manually.

        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the code of the unit of measure for the item on the line.', FRA = 'Spécifie le code de l''unité de mesure de l''article sur la ligne.';
            Editable = false;//Bc Upgrade YADAVM09<< 
            //Unsupported feature: Change Editable on ""Unit of Measure Code"(Control 26)". Please convert manually.

        }
        addafter("Source No.")
        {
            field("Source Line No."; Rec."Source Line No.")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
        }
        // addafter("Due Date")
        // {
        //     field("Src. DTax Group Code"; Rec."Src. DTax Group Code")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        // }//Bc Upgrade YADAVM09 Drink it field<<
        addafter("Shelf No.")
        {
            // field("Physical Location Group Code"; Rec."Physical Location Group Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }//Bc Upgrade YADAVM09 Drink it field<<
            field("Location Code"; Rec."Location Code")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
        }
        // addafter("Item No.")
        // {
        //     field("Item DTax Group Code"; "Item DTax Group Code")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        // }
        // addafter("Qty. Put Away")
        // {
        //     field("ShortcutQtyUomValue[1]"; ShortcutQtyUomValue[1])
        //     {
        //         BlankZero = true;
        //         CaptionClass = GetCaptionClassUom(1);
        //         DecimalPlaces = 0 : 5;
        //         Description = 'DIT-715 #244';
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("ShortcutQtyUomValue[2]"; ShortcutQtyUomValue[2])
        //     {
        //         BlankZero = true;
        //         CaptionClass = GetCaptionClassUom(2);
        //         DecimalPlaces = 0 : 5;
        //         Description = 'DIT-715 #244';
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("ShortcutQtyUomValue[3]"; ShortcutQtyUomValue[3])
        //     {
        //         BlankZero = true;
        //         CaptionClass = GetCaptionClassUom(3);
        //         DecimalPlaces = 0 : 5;
        //         Description = 'DIT-715 #244';
        //         Editable = false;
        //         Visible = false;
        //     }
        // } //Bc Upgrade YADAVM09 Drink it field<<
        addafter("Qty. Cross-Docked (Base)")
        {
            field("Source Original Quantity"; Rec."Source Original Quantity FND")
            {
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
        }
        addafter("Unit of Measure Code")
        {
            // field(Weight; Rec.Weight)
            // {
            //     Editable = false;
            // }
            // field(Cubage; Rec.Cubage)
            // {
            //     Editable = false;
            // }
            // field("AAD No."; "AAD No.")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("ARC No."; "ARC No.")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("SAD No."; "SAD No.")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("ARC Line No."; "ARC Line No.")
            // {
            //     Visible = false;
            // }
            // field("Unsatisfactory Type"; Rec."Unsatisfactory Type")
            // {
            //     Visible = false;
            // }
            // field("Unsatisfactory Quantity"; Rec."Unsatisfactory Quantity")
            // {
            //     Visible = false;
            // }
            // field("Unsatisfactory Comment"; Rec."Unsatisfactory Comment")
            // {
            //     Visible = false;
            // }
            // field("Applies-to AAD Trck. Entry No."; Rec."Applies-to AAD Trck. Entry No.")
            // {
            //     Description = 'DITW15.00.00.39 #1369';
            //     Visible = false;
            // } //Bc Upgrade YADAVM09 Drink it fields<<
            // field("Load No."; Rec."Load No.")
            // {
            //     Description = 'HEI.02';
            //     Visible = false;
            //     ApplicationArea = All;//Bc Upgrade YADAVM09<<
            // }
            // field("Sequence No."; Rec."Sequence No.")
            // {
            //     Description = 'HEI.02';
            //     Visible = false;
            //     ApplicationArea = All;//Bc Upgrade YADAVM09<<
            // }//Bc Upgrade YADAVM09 Added in interface Extension
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
        // addafter("Bin Contents List")
        // {
        //     action("Unsatisfactory Comment")
        //     {
        //         CaptionML = ENU = 'Unsatisfactory Comment',
        //                     FRA = 'Commentaires insatisfaisant';

        //         trigger OnAction();
        //         begin
        //             // <<DITW15.00.00.39 DDR 12/04/2011 DIT-712 #1296
        //             //This functionality was copied from page #7330. Unsupported part was commented. Please check it.
        //             /*CurrPage.PostedWhseRcptLines.PAGE.*/
        //             _ShowLineUnstatisfactoryCmts();

        //         end;
        //     }
        // }//Bc Upgrade YADAVM09 Drink it Action<<
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

    // procedure _ShowLineUnstatisfactoryCmts();
    // begin
    //     // <<DITW15.00.00.38 DDR 05/10/2010
    //     Rec.ShowLineUnstatisfactoryCmts();
    // end;//Bc Upgrade YADAVM09 Drink it Function<<

    // procedure ShowLineUnstatisfactoryCmts();
    // begin
    //     // <<DITW15.00.00.38 DDR 05/10/2010
    //     Rec.ShowLineUnstatisfactoryCmts();
    // end;//Bc Upgrade YADAVM09 Drink it Function<<

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

