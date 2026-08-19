pageextension 51155 WhseShipmentSubformExtCBN extends "Whse. Shipment Subform"

{
    // version NAVW110.0,QXL9.00.001,DITW110.00.09,NRQ102424,HEI.05
    //     DITW15.00.00.21 DDR 18/06/2008 added function PutWhseShipmentLines() using with button from Header form
    //                                added columns "Weight" and "Cubage"
    // DITW15.00.00.23.04 DDR£ 12/09/2008
    //                                added columns "Cubage to Ship","Weight to Ship"
    // DITW15.00.00.33 DDR 13/05/2009 Added columns "Item DTax Group Code","Src. DTax Group Code" (non-visible/non-editable)
    // DITW15.00.00.35-PRODW14.00.00.14 DDR 18/08/2009 issue 767 Added View & Lookup for LotNo. field
    // DITW15.00.00.36 DDR 06/11/2009 issue 777 Added functions ShowCommentLines(),HasComments(),CalcSourceTotalWV()
    // DITW15.00.00.37 DDR 10/06/2010 issue 1061 Added fields "Physical Location Group Code"
    // DITW15.00.00.38 DDR 19/11/2010 issue 1139 SSCC Functionnalities
    //                                  Added functions OpenSSCCTrackingLines()
    // DITW15.00.00.39 DDR 22/08/2011 issue 1399 Added fields "Posting Error Line"
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields "Delivery Sequence","Route"
    // DITW16.00.00.40 DDR 02/01/2012 DIT-715 #185 Added refresh subform on "Qty. to Ship" field
    //                                             Added non-editable when existing "Attached to line no." on fields
    //                                               "Qty. to Ship","Qty. to Ship (Base)"
    //                     03/02/2012 #1331 (HIT0069.1 VVE 19/04/2011) FEFO tracking
    //                                             Added function CreateFEFOTracking()
    //                     08/02/2012 #1002 Column "Route" non-visible default
    // DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
    //                                Added shortcut (warehouse) fields
    //                                  Control1100079000 Shortcut Unit of Measure1 Code
    //                                  Control1100079001 Shortcut Unit of Measure2 Code
    //                                  Control1100079002 Shortcut Unit of Measure3 Code
    //                                Added Standard Global Dimension Lookup (see from 53 as reference)
    //                     17/02/2012 DIT-715 #246
    //                                Removed call parameter function PutWhseShipmentLines()
    //                     01/03/2012 DIT-715 #246 Bugfix RTC to show columns SourceTotalWeight,SourceTotalVolume
    //                                             Removed all depending of HasColumnTotVW global variable
    //                                             Removed 'Name' property columns SourceTotalWeight,SourceTotalVolume
    // DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific

    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW18.00.07 VSC 19/02/2016 DIT-770 #1703 New _AllItemsAvailability
    // DITW18.00.07 VSC 19/02/2016 DIT-770 #1703 New Page Actions

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // DITW110.00.09 AKH 29/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // DITW111.00.13 MSF 06/12/2018 NRQ#94671 Line and header alert for not fully assigned lines - in warehouse shipment and sales order
    // DITW111.00.13 MSF 13/12/2018 NRQ#94671 check based on outstadning Qty
    // HEI.01 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new fields added "Load No." & "Sequence No."
    // HEI.02 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
    //   # Code added on 'OnDelete' trigger
    // HEI.03 HB2156 CHG2107450 IBM GAVANM01 07.02.2022 # WMS Phase 2 - Transportation cost
    //   # code added to avoid error on display lines when Item is blank
    // DITW114.00.15 DDR 24/04/2020 NRQ#102424 Fix remove non-editable on source promotion lines
    // DITW114.00.15 DDR 05/05/2020 NRQ#102424 Fix promotion checking with partial quantity Ship/Receive/Return/Invoice
    // HEI.04 CHG2188015 DEBUSD01 10.01.2023 Qty to Ship behavior on promotionline partialShipments
    //   # merge NRQ#102424
    // HEI.05 CHG2217161 SAHAL01 02.11.2023 SPL for Returns and GR cancellations
    //   # Added New Fields - SPL Code
    //                      - SPL Name
    //                      - Consumption SPL Code

    // BC Upgrade SHUKLP03 >>
    // HEI.03 => Trigger OnAfterGetRecord code is not added because code is added in between DrinkIT code.
    // DrinkIT code, fields, actions and procedures are blocked.
    // BC Upgrade SHUKLP03 <<     

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
            ToolTipML = ENU = 'Specifies the type of destination associated with the warehouse shipment line.', FRA = 'Spécifie le type de destination associé à la ligne expédition entrepôt.';
        }
        modify("Destination No.")
        {
            ToolTipML = ENU = 'Specifies the number of the customer, vendor, or location to which the items should be shipped.', FRA = 'Spécifie le numéro du client, du fournisseur ou du magasin auquel les articles doivent être expédiés.';
        }
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item that should be shipped.', FRA = 'Spécifie le numéro de l''article à expédier.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the variant code of the item in the line, if any.', FRA = 'Indique le code variante de l''article de la ligne, le cas échéant.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the description of the item in the line.', FRA = 'Spécifie la description de l''article de la ligne.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location from which the items on the line are being shipped.', FRA = 'Spécifie le code du magasin à partir duquel les articles de la ligne sont expédiés.';
        }
        modify("Zone Code")
        {
            ToolTipML = ENU = 'Specifies the code of the zone where the bin on this shipment line is located.', FRA = 'Spécifie le code de la zone dans laquelle est situé l''emplacement de cette ligne expédition.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies the code of the bin in which the items will be placed before shipment.', FRA = 'Spécifie le code de l''emplacement dans lequel les articles seront placés avant d''être expédiés.';
        }
        modify("Shelf No.")
        {
            ToolTipML = ENU = 'Specifies the shelf number of the item for informational use.', FRA = 'Spécifie le numéro de rayon de l''article, à titre informatif.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the quantity that should be shipped.', FRA = 'Spécifie la quantité qui doit être expédiée.';
        }
        modify("Qty. (Base)")
        {
            ToolTipML = ENU = 'Specifies the quantity that should be shipped, in the base unit of measure.', FRA = 'Spécifie la quantité qui doit être expédiée, exprimée en unité de base.';
        }
        modify("Qty. to Ship")
        {
            ToolTipML = ENU = 'Specifies the quantity that will be shipped when the warehouse shipment is posted.', FRA = 'Affiche la quantité qui sera expédiée à la validation de l''expédition entrepôt.';

            //Unsupported feature: Change Editable on ""Qty. to Ship"(Control 46)". Please convert manually.

        }
        modify("Qty. Shipped")
        {
            ToolTipML = ENU = 'Specifies the quantity of the item on the line that is posted as shipped.', FRA = 'Spécifie la quantité de l''article de la ligne qui est validée comme expédiée.';
        }
        modify("Qty. to Ship (Base)")
        {
            ToolTipML = ENU = 'Specifies the quantity, in base units of measure, that will be shipped when the warehouse shipment is posted.', FRA = 'Spécifie la quantité (en unité de base) qui sera expédiée à la validation de l''expédition entrepôt.';

            //Unsupported feature: Change Editable on ""Qty. to Ship (Base)"(Control 28)". Please convert manually.

        }
        modify("Qty. Shipped (Base)")
        {
            ToolTipML = ENU = 'Specifies the quantity that is posted as shipped expressed in the base unit of measure.', FRA = 'Spécifie la quantité validée comme expédiée, exprimée en unité de base.';
        }
        modify("Qty. Outstanding")
        {
            ToolTipML = ENU = 'Specifies the quantity that still needs to be handled.', FRA = 'Indique la quantité restant à traiter.';
        }
        modify("Qty. Outstanding (Base)")
        {
            ToolTipML = ENU = 'Specifies the quantity that still needs to be handled, expressed in the base unit of measure.', FRA = 'Spécifie la quantité restant à traiter, exprimée en unité de base.';
        }
        modify("Pick Qty.")
        {
            ToolTipML = ENU = 'Specifies the quantity in pick instructions assigned to be picked for the warehouse shipment line.', FRA = 'Spécifie la quantité spécifiée dans les instructions de prélèvement, qui est affectée à la ligne d''expédition entrepôt.';
        }
        modify("Pick Qty. (Base)")
        {
            ToolTipML = ENU = 'Specifies the quantity, in the base unit of measure, in pick instructions, that is assigned to be picked for the warehouse shipment line.', FRA = 'Spécifie la quantité en unité de base indiquée dans les instructions de prélèvement, qui est affectée au prélèvement pour la ligne expédition entrepôt.';
        }
        modify("Qty. Picked")
        {
            ToolTipML = ENU = 'Specifies how many of the total shipment quantity have been registered as picked.', FRA = 'Indique la proportion de la quantité d''expédition totale enregistrée comme étant prélevée.';
        }
        modify("Qty. Picked (Base)")
        {
            ToolTipML = ENU = 'Specifies how many of the total shipment quantity in the base unit of measure have been registered as picked.', FRA = 'Indique la proportion de la quantité d''expédition totale, exprimée en unité de mesure, enregistrée comme étant prélevée.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies the date when the related warehouse activity, such as a pick, must be completed to ensure items can be shipped by the shipment date.', FRA = 'Spécifie la date à laquelle l''activité entrepôt associée (un prélèvement, par exemple) doit être terminée pour s''assurer que les articles peuvent être livrés au plus tard à la date d''expédition.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code of the item on the line.', FRA = 'Spécifie le code unité de l''article sur la ligne.';
        }
        modify("Qty. per Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the number of base units of measure that are in the unit of measure specified for the item on the line.', FRA = 'Spécifie le nombre d''unités de base qui se trouvent dans l''unité spécifiée pour l''article dans la ligne.';
        }
        modify(QtyCrossDockedUOM)
        {
            CaptionML = ENU = 'Qty. on Cross-Dock Bin', FRA = 'Qté empl. transbordement';
        }
        modify(QtyCrossDockedUOMBase)
        {
            CaptionML = ENU = 'Qty. on Cross-Dock Bin (Base)', FRA = 'Qté empl. transbord. (base)';
        }
        modify(QtyCrossDockedAllUOMBase)
        {
            CaptionML = ENU = 'Qty. on Cross-Dock Bin (Base all UOM)', FRA = 'Qté empl. transbord. (base toute unité)';
        }

        //Unsupported feature: CodeInsertion on ""Qty. to Ship"(Control 46)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        QtytoShipOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Qty. to Ship (Base)"(Control 28)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        QtytoShipBaseOnAfterValidate;
        */
        //end;

        // BC Upgrade SHUKLP03 >> DrinkIT fields are blocked.
        // addafter("Source Line No.")
        // {
        //     field("Src. DTax Group Code";"Src. DTax Group Code")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field(SourceTotalWeight;SourceTotalWeight)
        //     {
        //         CaptionML = ENU='Source Header Total Weight',
        //                     FRA='Origine entête poids total';
        //         Editable = false;
        //         Visible = false;

        //         trigger OnDrillDown();
        //         begin
        //             // <<DITW15.00.00.36 DDR 06/11/2009
        //             DrillDownTotalHeaderVolWeight(0);
        //             // >>DITW15.00.00.36 DDR
        //         end;
        //     }
        //     field(SourceTotalVolume;SourceTotalVolume)
        //     {
        //         CaptionML = ENU='Source Header Total Volume (Cubage)',
        //                     FRA='Origine entête volume total (cubage)';
        //         Editable = false;
        //         Visible = false;

        //         trigger OnDrillDown();
        //         begin
        //             // <<DITW15.00.00.36 DDR 06/11/2009
        //             DrillDownTotalHeaderVolWeight(1);
        //             // >>DITW15.00.00.36 DDR
        //         end;
        //     }
        // }
        // addafter("Destination No.")
        // {
        //     field(Route;Route)
        //     {
        //         Visible = false;
        //     }
        //     field("Delivery Sequence";"Delivery Sequence")
        //     {
        //         Visible = false;
        //     }
        // }
        // addafter("Item No.")
        // {
        //     field("Item DTax Group Code";"Item DTax Group Code")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        // }
        // addafter(Description)
        // {
        //     field("Physical Location Group Code";"Physical Location Group Code")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        // }

        // addafter("Bin Code")
        // {
        //     field(LotNo; LotNoText)
        //     {
        //         CaptionML = ENU = 'Lot No.',
        //                     FRA = 'N° lot';
        //         Editable = false;
        //         Style = Attention;
        //         StyleExpr = LotNocolor;
        //         Visible = false;

        //         trigger OnLookup(Text: Text): Boolean;
        //         begin
        //             //<<QXL9.00.001 DAT 23/03/2016
        //             OpenItemTrackingLines;
        //             if QualitySetup.READPERMISSION and ("Item No." <> '') then begin
        //                 case "Source Type" of
        //                     DATABASE::"Purchase Line":
        //                         begin
        //                             QualityManagement.CheckQualityMeasuresStatus("Item No.", "Variant Code", DATABASE::"Purchase Line");
        //                             LotNo :=
        //                               QualityManagement.GetLotNos(DATABASE::"Purchase Line", "Source Subtype", "Source No.", '', 0, "Source Line No.", "Item No.",
        //                               10, Quantity < 0);
        //                         end;
        //                     DATABASE::"Sales Line":
        //                         begin
        //                             LotNo :=
        //                               QualityManagement.GetLotNos(DATABASE::"Sales Line", "Source Subtype", "Source No.", '', 0, "Source Line No.", "Item No.",
        //                               10, Quantity < 0);
        //                         end;
        //                     DATABASE::"Transfer Line":
        //                         begin
        //                             Direction := Direction::Outbound;
        //                             if TransferLine.GET("Source No.", "Source Line No.") then
        //                                 LotNo :=
        //                                   QualityManagement.GetLotNos(DATABASE::"Transfer Line",
        //                                     Direction, "Source No.", '', TransferLine."Derived From Line No.", "Source Line No.", "Item No.",
        //                                     10, Quantity < 0);
        //                         end
        //                 end;
        //             end;
        //             //>>QXL9.00.001 DAT 23/03/2016
        //         end;
        //     }
        // }
        // BC Upgrade SHUKLP03 >> DrinkIT fields are blocked.

        addafter(Control3)
        {
            // BC Upgrade SHUKLP03 >> DrinkIT fields is blocked.
            // field("Weight to Ship"; "Weight to Ship")
            // {
            //     Editable = false;
            // }
            // BC Upgrade SHUKLP03 >> DrinkIT fields is blocked.

            field(Weight; Rec.Weight)
            {
                ApplicationArea = ALL;
                Editable = false;
                Visible = false;
                ToolTip = 'Specifies the value of the Weight field.';
            }

            // BC Upgrade SHUKLP03 >> DrinkIT fields is blocked.
            // field("Cubage to Ship"; "Cubage to Ship")
            // {
            //     Editable = false;
            // }
            // BC Upgrade SHUKLP03 >> DrinkIT fields is blocked.

            field(Cubage; Rec.Cubage)
            {
                ApplicationArea = ALL;
                Editable = false;
                Visible = false;
                ToolTip = 'Specifies the value of the Cubage field.';
            }

            // BC Upgrade SHUKLP03 << DrinkIT fields are blocked.
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
            // }
            // field("Posting Error Line"; "Posting Error Line")
            // {
            //     Editable = false;
            // }
            // BC Upgrade SHUKLP03 << DrinkIT fields are blocked.

            field("RPM Solution"; Rec."RPM Solution FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the RPM Solution field.';
            }
            field("RPM Type"; Rec."RPM Type FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the RPM Type field.';
            }
            field("Item Type"; Rec."Item Type FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Item Type field.';
            }
            field("Load No."; Rec."Load No. FND")
            {
                ApplicationArea = ALL;
                Description = 'HEI.01';
                Visible = false;
                ToolTip = 'Specifies the value of the Load No. field.';
            }
            field("Sequence No."; Rec."Sequence No. FND")
            {
                ApplicationArea = ALL;
                Description = 'HEI.01';
                ToolTip = 'Specifies the value of the Sequence No. field.';
                //Visible = false;//Bc Upgrade YADAVM09 Blocked for FAT issue
            }
            field("SPL Code"; Rec."SPL Code FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the SPL Code field.';
            }
            field("SPL Name"; Rec."SPL Name FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the SPL Name field.';
            }
            field("Consumption SPL Code"; Rec."Consumption SPL Code FND")
            {
                //Visible = false;//Bc Upgrade YADAVM09 Blocked for FAT issue
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Consumption SPL Code field.';
            }
            //Bc Upgrade YADAVM09 Added for FAT Issue>>
            field("Item Category Code"; Rec."Item Category Code FND")
            {

                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Item Category Code field.';
            }
            //Bc Upgrade YADAVM09 Added for FAT Issue<<
        }
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify("Source &Document Line")
        {
            CaptionML = ENU = 'Source &Document Line', FRA = 'Ligne document o&rigine';
        }
        modify("&Bin Contents List")
        {
            CaptionML = ENU = '&Bin Contents List', FRA = 'Li&ste contenus emplacement';
        }
        modify(ItemTrackingLines)
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = 'Lignes &traçabilité';
        }
        modify("Assemble to Order")
        {
            CaptionML = ENU = 'Assemble to Order', FRA = 'Assemblage à la commande';
        }

        // BC Upgrade SHUKLP03 >> DrinkIT actions are blocked.
        // addfirst(ActionContainer1900000004)
        // {
        //     group("F&unctions")
        //     {
        //         CaptionML = ENU = 'F&unctions',
        //                     FRA = 'Fonction&s';
        //         action("&Move Whse. Shipment Line")
        //         {
        //             CaptionML = ENU = '&Move Whse. Shipment Line',
        //                         FRA = 'Deplacer les lignes entrepôt expétion';
        //             Ellipsis = true;
        //             Image = Export;
        //             ShortCutKey = 'Ctrl+M';

        //             trigger OnAction();
        //             begin
        //                 // <<DITW15.00.00.21 DDR 19/06/2008
        //                 //This functionality was copied from page #7335. Unsupported part was commented. Please check it.
        //                 /*CurrPage.WhseShptLines.PAGE.*/
        //                 _PutWhseShipmentLines;
        //                 // >>DITW15.00.00.21 DDR

        //             end;
        //         }
        //     }
        // }
        // addfirst("&Line")
        // {
        //     action("Items by Period")
        //     {
        //         CaptionML = ENU = 'Items by Period',
        //                     FRA = 'Articles par période';
        //         Description = 'DIT-715 #338';

        //         trigger OnAction();
        //         begin
        //             //<< DITW18.00.07 VSC 19/02/2016 DIT-770 #1703
        //             _AllItemsAvailability(1);
        //         end;
        //     }
        //     group("Item Availability by")
        //     {
        //         CaptionML = ENU = 'Item Availability by',
        //                     FRA = 'Disponibilité article par';
        //         Image = ItemAvailability;
        //         action("Event")
        //         {
        //             CaptionML = ENU = 'Event',
        //                         FRA = 'Événement';
        //             Image = "Event";

        //             trigger OnAction();
        //             begin
        //                 //<< DITW18.00.07 VSC 19/02/2016 DIT-770 #1703
        //                 ItemAvailFormsMgt.ShowItemAvailFromWhseShptLine(Rec, ItemAvailFormsMgt.ByEvent)
        //             end;
        //         }
        //         action(Period)
        //         {
        //             CaptionML = ENU = 'Period',
        //                         FRA = 'Période';
        //             Image = Period;

        //             trigger OnAction();
        //             begin
        //                 //<< DITW18.00.07 VSC 19/02/2016 DIT-770 #1703
        //                 ItemAvailFormsMgt.ShowItemAvailFromWhseShptLine(Rec, ItemAvailFormsMgt.ByPeriod)
        //             end;
        //         }
        //         action(Variant)
        //         {
        //             CaptionML = ENU = 'Variant',
        //                         FRA = 'Variante';
        //             Image = ItemVariant;

        //             trigger OnAction();
        //             begin
        //                 //<< DITW18.00.07 VSC 19/02/2016 DIT-770 #1703
        //                 ItemAvailFormsMgt.ShowItemAvailFromWhseShptLine(Rec, ItemAvailFormsMgt.ByVariant)
        //             end;
        //         }
        //         action(Location)
        //         {
        //             AccessByPermission = TableData Location = R;
        //             CaptionML = ENU = 'Location',
        //                         FRA = 'Magasin';
        //             Image = Warehouse;

        //             trigger OnAction();
        //             begin
        //                 //<< DITW18.00.07 VSC 19/02/2016 DIT-770 #1703
        //                 ItemAvailFormsMgt.ShowItemAvailFromWhseShptLine(Rec, ItemAvailFormsMgt.ByLocation)
        //             end;
        //         }
        //         action("Period (Items)")
        //         {
        //             CaptionML = ENU = 'Period (Items)',
        //                         FRA = 'Période (Article)';
        //             Description = 'DIT-715 #338';

        //             trigger OnAction();
        //             begin
        //                 //<< DITW18.00.07 VSC 19/02/2016 DIT-770 #1703
        //                 _AllItemsAvailability(0);
        //             end;
        //         }
        //         action("BOM Level")
        //         {
        //             CaptionML = ENU = 'BOM Level',
        //                         FRA = 'Niveau nomenclature';
        //             Image = BOMLevel;

        //             trigger OnAction();
        //             begin
        //                 ItemAvailFormsMgt.ShowItemAvailFromWhseShptLine(Rec, ItemAvailFormsMgt.ByBOM)
        //             end;
        //         }
        //     }
        //}
        // addafter("Assemble to Order")
        // {
        //     action("&Automatic FEFO Tracking")
        //     {
        //         CaptionML = ENU = '&Automatic FEFO Tracking',
        //                     FRA = 'Traçabilité Automatique FEFO';
        //         Description = '#1331';
        //         ShortCutKey = 'Shift+Ctrl+T';

        //         trigger OnAction();
        //         begin
        //             // <<DITW16.00.00.40 DDR 03/02/2012 #1331
        //             //This functionality was copied from page #7335. Unsupported part was commented. Please check it.
        //             /*CurrPage.WhseShptLines.PAGE.*/
        //             _CreateFEFOTracking();

        //         end;
        //     }
        //     action("SSCC Tracking Lines")
        //     {
        //         CaptionML = ENU = 'SSCC Tracking Lines',
        //                     FRA = 'Lignes Traçabilité SSCC';
        //         Image = ItemTrackingLines;

        //         trigger OnAction();
        //         begin
        //             // <<DITW15.00.00.38 DDR 19/11/2010 #1139
        //             //This functionality was copied from page #7335. Unsupported part was commented. Please check it.
        //             /*CurrPage.WhseShptLines.PAGE.*/
        //             _OpenSSCCTrackingLines;

        //         end;
        //     }
        //     action("Source &Comment Lines (header)")
        //     {
        //         CaptionML = ENU = 'Source &Comment Lines (header)',
        //                     FRA = 'Ligne origine commentaire (Entête)';

        //         trigger OnAction();
        //         begin
        //             // <<DITW15.00.00.36 DDR 06/11/2009
        //             //This functionality was copied from page #7335. Unsupported part was commented. Please check it.
        //             /*CurrPage.WhseShptLines.PAGE.*/
        //             _ShowCommentLines(0);
        //             // >>DITW15.00.00.36 DDR

        //         end;
        //     }
        //     action("Source &Comment Lines")
        //     {
        //         CaptionML = ENU = 'Source &Comment Lines',
        //                     FRA = 'Lignes origine &commentaire';

        //         trigger OnAction();
        //         begin
        //             // <<DITW15.00.00.36 DDR 06/11/2009
        //             //This functionality was copied from page #7335. Unsupported part was commented. Please check it.
        //             /*CurrPage.WhseShptLines.PAGE.*/
        //             _ShowCommentLines(1);
        //             // >>DITW15.00.00.36 DDR

        //         end;
        //     }
        // }
        // BC Upgrade SHUKLP03 >> DrinkIT actions are blocked.

    }
    trigger OnDeleteRecord(): Boolean
    begin
        //HEI.02>>
        IF SalesHeader2.GET(SalesHeader2."Document Type"::Order, Rec."Source No.") THEN
            IF SourceSystemIdentifierAPI.GET(SalesHeader2."Source System Identifier FND") THEN
                IF SourceSystemIdentifierAPI."Automatic SO Posting" THEN
                    ERROR(CantDeleteErr, SalesHeader."Source System Identifier FND");
        //HEI.02<<

    end;

    var
        // QualitySetup: Record "Quality Setup"; // BC Upgrade SHUKLP03 << DrinkIT variable
        // QualityManagement: Codeunit "Quality Management"; // BC Upgrade SHUKLP03 << DrinkIT variable
        TransferLine: Record "Transfer Line";

        LotNocolor: Boolean;

        LotNoText: Text[1024];
        LotNo: Code[20];
        Direction: Option Outbound,Inbound;
        HasSourceCommentHeader: Boolean;
        HasSourceCommentLine: Boolean;
        SourceTotalWeight: Decimal;
        SourceTotalVolume: Decimal;

        SalesHeader: Record "Sales Header";
        PurchHeader: Record "Purchase Header";
        ShortcutQtyUomValue: array[3] of Decimal;

        "Qty. to ShipEditable": Boolean;

        "Qty. to Ship (Base)Editable": Boolean;

    //ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";




    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //begin
    /*
    /// DITW16.00.00.40 DDR 02/01/2012 DIT-715 #185 - DITW114.00.15 DDR 24/04/2020 NRQ#102424
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CrossDockMgt.CalcCrossDockedItems("Item No.","Variant Code","Unit of Measure Code","Location Code",
      QtyCrossDockedUOMBase,
      QtyCrossDockedAllUOMBase);
    QtyCrossDockedUOM := 0;
    if  "Qty. per Unit of Measure" <> 0 then
      QtyCrossDockedUOM := ROUND(QtyCrossDockedUOMBase / "Qty. per Unit of Measure",0.00001);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
    ShowShortcutUomValue(ShortcutQtyUomValue);
    // >>DITW16.00.00.40 DDR DIT-715 #244
    #1..6
    //<<QXL9.00.001 DAT 23/03/2016
    if QualitySetup.READPERMISSION and ("Item No." <> '') then begin
      case "Source Type" of
        DATABASE::"Purchase Line":
          begin
            LotNo :=
              QualityManagement.GetWhseLotNo(
                DATABASE::"Purchase Line","Source Subtype","Source No.",'',0,"Source Line No.","Item No.",Quantity < 0);
          end;
        DATABASE::"Sales Line":
          begin
            LotNo :=
              QualityManagement.GetWhseLotNo(
                DATABASE::"Sales Line","Source Subtype","Source No.",'',0,"Source Line No.","Item No.",Quantity < 0);
          end;
        DATABASE::"Transfer Line":
          begin
            Direction := Direction::Outbound;
            if TransferLine.GET("Source No.","Source Line No.") then
              LotNo :=
                QualityManagement.GetWhseLotNo(DATABASE::"Transfer Line",
                  Direction,"Source No.",'',TransferLine."Derived From Line No.","Source Line No.","Item No.",Quantity < 0);
          end
      end;
    end else
      LotNo := '';

    // <<DITW15.00.00.36 DDR 06/11/2009
    HasSourceCommentHeader := HasComments(0);
    HasSourceCommentLine := HasComments(1);
    if Rec."Item No." <> '' then  //HEI.03
      CalcSourceTotalWV();
    // >>DITW15.00.00.36 DDR
    LotNoText := FORMAT(LotNo);
    LotNoTextOnFormat(LotNoText);
    //>>QXL9.00.001 DAT 23/03/2016
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnDeleteRecord". Please convert manually.

    //trigger OnDeleteRecord() : Boolean;
    var
        SalesHeader2: Record "Sales Header";
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        CantDeleteErr: Label 'You can not delete a Shipment Line for an Order sent by %1.';
    //begin
    /*
    //HEI.02>>
    if SalesHeader2.GET(SalesHeader2."Document Type"::Order,"Source No.") then
      if SourceSystemIdentifierAPI.GET(SalesHeader2."Source System Identifier") then
        if SourceSystemIdentifierAPI."Automatic SO Posting" then
          ERROR(CantDeleteErr,SalesHeader."Source System Identifier");
    //HEI.02<<
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    "Qty. to Ship (Base)Editable" := true;
    "Qty. to ShipEditable" := true;
    */
    //end;



    // BC Upgrade SHUKLPO3 << DrinkIT procedures are blocked.
    // procedure _PutWhseShipmentLines();
    // var
    //     lrWhseShptLine: Record "Warehouse Shipment Line";
    //     lcduWhseTranspMgt: Codeunit "Warehouse & Transport Mgt.";
    // begin
    //     // <<DITW15.00.00.21 DDR 19/06/2008
    //     CurrPage.SAVERECORD;
    //     COMMIT;

    //     with lrWhseShptLine do begin
    //         COPY(Rec);
    //         MARKEDONLY(true);
    //         if ISEMPTY then begin
    //             CLEAR(lrWhseShptLine);
    //             CurrPage.SETSELECTIONFILTER(lrWhseShptLine);
    //             SETRANGE("No.", Rec."No.");
    //         end;
    //     end;
    //     // <<DITW16.00.00.40 DDR 22/02/2012 DIT-715 #246
    //     lcduWhseTranspMgt.PutWhseShipmentLines(lrWhseShptLine);
    //     RESET;
    //     SETCURRENTKEY("No.", "Sorting Sequence No.");
    //     CurrPage.UPDATE(false);
    // end;

    // procedure PutWhseShipmentLines();
    // var
    //     lrWhseShptLine: Record "Warehouse Shipment Line";
    //     lcduWhseTranspMgt: Codeunit "Warehouse & Transport Mgt.";
    // begin
    //     // <<DITW15.00.00.21 DDR 19/06/2008
    //     CurrPage.SAVERECORD;
    //     COMMIT;

    //     with lrWhseShptLine do begin
    //         COPY(Rec);
    //         MARKEDONLY(true);
    //         if ISEMPTY then begin
    //             CLEAR(lrWhseShptLine);
    //             CurrPage.SETSELECTIONFILTER(lrWhseShptLine);
    //             SETRANGE("No.", Rec."No.");
    //         end;
    //     end;
    //     // <<DITW16.00.00.40 DDR 22/02/2012 DIT-715 #246
    //     lcduWhseTranspMgt.PutWhseShipmentLines(lrWhseShptLine);
    //     RESET;
    //     SETCURRENTKEY("No.", "Sorting Sequence No.");
    //     CurrPage.UPDATE(false);
    // end;

    // procedure _ShowCommentLines(FromType: Option Header,Line);
    // begin
    //     // <<DITW15.00.00.36 DDR 06/11/2009
    //     Rec.ShowCommentLines(FromType);
    // end;

    // procedure ShowCommentLines(FromType: Option Header,Line);
    // begin
    //     // <<DITW15.00.00.36 DDR 06/11/2009
    //     Rec.ShowCommentLines(FromType);
    // end;

    // procedure HasComments(FromType: Option Header,Line): Boolean;
    // begin
    //     // <<DITW15.00.00.36 DDR 06/11/2009
    //     exit(not Rec.HasComments(FromType));
    // end;

    // local procedure CalcSourceTotalWV();
    // begin
    //     // <<DITW15.00.00.36 DDR 06/11/2009
    //     case "Source Type" of
    //         "Source Type"::"37":
    //             begin
    //                 if (SalesHeader."Document Type" <> "Source Subtype") or
    //                   (SalesHeader."No." <> "Source No.")
    //                 then
    //                     SalesHeader.GET("Source Subtype", "Source No.");
    //                 SalesHeader.CALCFIELDS("Total Weight", "Total Cubage");
    //                 SourceTotalWeight := SalesHeader."Total Weight";
    //                 SourceTotalVolume := SalesHeader."Total Cubage";
    //             end;
    //         "Source Type"::"39":
    //             begin
    //                 if (PurchHeader."Document Type" <> "Source Subtype") or
    //                   (PurchHeader."No." <> "Source No.")
    //                 then
    //                     PurchHeader.GET("Source Subtype", "Source No.");
    //                 PurchHeader.CALCFIELDS("Total Weight", "Total Cubage");
    //                 SourceTotalWeight := PurchHeader."Total Weight";
    //                 SourceTotalVolume := PurchHeader."Total Cubage";
    //             end;
    //     end;
    // end;

    // procedure _OpenSSCCTrackingLines();
    // begin
    //     // <<DITW15.00.00.38 DDR 19/11/2010 #1139
    //     Rec.OpenSSCCTrackingLines;
    // end;

    // procedure OpenSSCCTrackingLines();
    // begin
    //     // <<DITW15.00.00.38 DDR 19/11/2010 #1139
    //     Rec.OpenSSCCTrackingLines;
    // end;

    // procedure _CreateFEFOTracking();
    // begin
    //     // <<DITW16.00.00.40 DDR 03/02/2012 #1331
    //     FIND();
    //     FEFOTracking();
    // end;

    // procedure CreateFEFOTracking();
    // begin
    //     // <<DITW16.00.00.40 DDR 03/02/2012 #1331
    //     FIND();
    //     FEFOTracking();
    // end;

    // local procedure QtytoShipOnAfterValidate();
    // begin
    //     // <<DITW16.00.00.40 DDR 02/01/2012 DIT-715 #185
    //     CurrPage.UPDATE(true);
    //     // >>DITW16.00.00.40 DDR DIT-715 #185
    // end;

    // local procedure QtytoShipBaseOnAfterValidate();
    // begin
    //     // <<DITW16.00.00.40 DDR 02/01/2012 DIT-715 #185
    //     CurrPage.UPDATE(true);
    //     // >>DITW16.00.00.40 DDR DIT-715 #185
    // end;

    // local procedure HasSourceCommentHeaderOnPush();
    // begin
    //     // <<DITW15.00.00.36 DDR 06/11/2009
    //     ShowCommentLines(0);
    //     // >>DITW15.00.00.36 DDR
    // end;

    // local procedure HasSourceCommentLineOnPush();
    // begin
    //     // <<DITW15.00.00.36 DDR 06/11/2009
    //     ShowCommentLines(1);
    //     // >>DITW15.00.00.36 DDR
    // end;

    // local procedure LotNoTextOnFormat(var Text: Text[1024]);
    // begin
    //     //<<QXL9.00.001 DAT 23/03/2016
    //     if QualitySetup.READPERMISSION then begin
    //         //<<DITW111.00.13 MSF 06/12/2018 NRQ#94671-DITW111.00.13 MSF 13/12/2018 NRQ#94671
    //         CALCFIELDS("Lot Reserved Qty. (Base)");
    //         LotNocolor := QualityManagement.IsRequired(Text) or ((ABS("Qty. (Base)") - ABS("Lot Reserved Qty. (Base)") > 0) and ("Lot Reserved Qty. (Base)" <> 0));
    //         //>>DITW111.00.13 MSF 06/12/2018 NRQ#94671-DITW111.00.13 MSF 13/12/2018 NRQ#94671
    //     end;
    //     //>>QXL9.00.001 DAT 23/03/2016
    // end;

    // procedure _AllItemsAvailability(AvailabilityType: Option Date2,Date3);
    // begin
    //     //<< DITW18.00.07 VSC 19/02/2016 DIT-770 #1703
    //     Rec.AllItemsAvailability(AvailabilityType);
    // end;
    // BC Upgrade SHUKLPO3 << DrinkIT procedures are blocked.

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

