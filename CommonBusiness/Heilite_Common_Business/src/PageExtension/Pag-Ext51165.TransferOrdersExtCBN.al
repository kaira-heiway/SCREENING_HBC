pageextension 51165 TransferOrdersExtCBN extends "Transfer Orders"
{
    //     // version NAVW110.0,FINXL8.00,DITW110.00.08,HEI.11
    //     FINXL8.00.001 BSA 29/05/2015 #180: Added Replenishment Status

    // DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
    //                                Added shortcut (warehouse) fields
    //                                  Control1100079000 Shortcut Unit of Measure1 Code
    //                                  Control1100079001 Shortcut Unit of Measure2 Code
    //                                  Control1100079002 Shortcut Unit of Measure3 Code
    //                                Added Standard Global Dimension Lookup (see from 53 as reference)
    //                     17/02/2012 DIT-715 #244 Added/Moved columns
    // DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457 Added fields "Work Order No."

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.12 AKH 30/03/2018 NRQ#16026 Order Shipment Planning: Sync Sales - Transfer

    // HEI.01 FDD-HT1304 IBM NASTAA02 01.07.2020 # IC Transfer Order Automation
    //   # New Fields added: "IC Document" and "External Document No."
    // HEI.02 FDD-HB1438 CHG2065311 IBM SHANKJ03 30.07.2020
    //   # New Field created : PO Reference & Extra PO reference
    // HEI.03 CHG2069358 IBM.AK 25.08.20
    //  # new field added on -"Created By"
    // HEI.04 FDD-HB899 - CHG2093869 IBM NASTAA02 02.03.2021 # LSR - Transfer and Stock
    //   # Code added on Page Actions: "Create Whse. S&hipment" and "Create &Whse. Receipt"
    // HEI.05 CHG2093869 GAVANM01 05.03.2021 #Transfer and Stock adjustments interfaces Bahamas LS Retail
    //   # new field added: LSR Order No

    // HEI.06 CHG2103751 MARTIR52 23.03.2021 - Fields added for Bahamas Visibility
    //  # Field "Last Shipment No." Added
    //  # Field "Las Receipt No". Added
    // HEI.07 FDD-HB1195 CHG2070051 IBM NANDIS01 24.05.2021 Import Purchasing & Receiving process HeiLite-Maximo integration
    //   # TO can not be posted manually if its created from PO

    // HEI.08 CHG2161266 HB3003  NORRRIQ KOROLA04 06.10.2022
    //   # "Import Idemtifier" - field added

    // HEI.09 CHG2161266 HB3003 NORRIQ KOROLA04 20.10.2022
    //   # Import Identifier - field name fixed
    // HEI.10 CHG2184698 IBM NANDIS01 07.12.2022 #Issue to change the expected receipt date on PO header
    //   Reopen of TO will depend on extra condition of respective PO
    // HEI.11 CHG2216722 IBM SISUM01 02.10.2023  Request for email functionality for Transfer Order Creation
    //   # Add the new field id 50021
    //   # Add new action: Send Email

    // BC Upgrade SHUKLP03 >>
    // "WMS Export" AND "LSR Order No" shared with Sakshi.
    // DrinkIT code, fields, actions and procedures are blocked.
    // Table "Transfer Header" => Trigger OnLookup() code of field "Shipping Agent Service Code" is added on page "Transfer Orders".
    // Page name changed from "Transfer List" to "Transfer Orders"
    // Action("Create &Whse. Receipt"), action(SendEmail) of Transfer order shared with Sakshi because interface related objects are used.
    // Action("Create Whse. S&hipment Custom") of Transfer order shared with Sakshi because interface related objects are used.
    // BC Upgrade SHUKLP03 <<


    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the transfer order.', FRA = 'Spécifie le numéro de l''ordre de transfert.';
        }
        modify("Transfer-from Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location from which items are transferred.', FRA = 'Spécifie le code du magasin à partir duquel les articles sont transférés.';
        }
        modify("Transfer-to Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location that you are transferring items to.', FRA = 'Spécifie le code du magasin vers lequel vous transférez les articles.';
        }
        modify("In-Transit Code")
        {
            ToolTipML = ENU = 'Specifies the in-transit code that identifies this transfer.', FRA = 'Indique le code transit identifiant le transfert.';
        }
        modify(Status)
        {
            ToolTipML = ENU = 'Indicates whether the transfer order is open or has been released for the next stage of processing.', FRA = 'Indique si l''ordre de transfert est ouvert ou a été lancé pour l''étape suivante.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code for the dimension that has been chosen as Global Dimension 1.', FRA = 'Spécifie le code section analytique de l''axe choisi comme axe principal 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code for the dimension that has been chosen as Global Dimension 2.', FRA = 'Spécifie le code section analytique de l''axe choisi comme axe principal 2.';
        }
        modify("Assigned User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user who is responsible for the document.', FRA = 'Spécifie le code de l''utilisateur qui est responsable du document.';
        }
        modify("Shipment Date")
        {
            ToolTipML = ENU = 'Specifies the date the order is expected to be shipped.', FRA = 'Indique la date d''expédition prévue de la commande.';

            //Unsupported feature: Change Visible on ""Shipment Date"(Control 1102601021)". Please convert manually.

        }
        modify("Shipment Method Code")
        {
            ToolTipML = ENU = 'Specifies the shipment method code that you have entered for this order.', FRA = 'Spécifie le code condition livraison saisi pour cette commande.';

            //Unsupported feature: Change Visible on ""Shipment Method Code"(Control 1102601023)". Please convert manually.

        }
        modify("Shipping Agent Code")
        {
            ToolTipML = ENU = 'Specifies the code for the shipping agent you are using to ship the items on this transfer order.', FRA = 'Indique le code du transporteur que vous utilisez pour expédier les articles de l''ordre de transfert.';

            //Unsupported feature: Change Visible on ""Shipping Agent Code"(Control 1102601025)". Please convert manually.

        }
        modify("Shipping Advice")
        {
            ToolTipML = ENU = 'Specifies advice for the warehouse sending the items, about whether a partial delivery is acceptable.', FRA = 'Indique à l''entrepôt qui doit expédier les articles si une livraison partielle est possible ou non.';
        }
        modify("Receipt Date")
        {
            ToolTipML = ENU = 'Specifies the date that you expect the transfer-to location to receive the shipment.', FRA = 'Spécifie la date à laquelle le magasin destination transfert doit réceptionner l''expédition.';
        }

        //Unsupported feature: PropertyDeletion on ""Receipt Date"(Control 1102601029)". Please convert manually.

        addafter("Shipping Agent Code")
        {
            field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
            {
                Description = 'DIT-715 #244';
                ApplicationArea = All;
                ToolTip = 'Specifies the code for the service, such as a one-day delivery, that is offered by the shipping agent.';

                trigger OnLookup(var Text: Text): Boolean
                var
                    myInt: Integer;
                begin
                    //>> HEI.05
                    Rec.FilterShippingAgentServiceCode(); // BC Upgrade SHUKLP03 << Table "Transfer Header" code is added here because we can't add OnLookup code on table.
                    //<< HEI.05
                end;
            }
        }

        // BC Upgrade SHUKLP03 >> DrinkIT fields are bocked.
        // addafter("Shipping Advice")
        // {
        //     field("Truck Code";Rec."Truck Code")
        //     {
        //         Description = 'DIT-715 #244';
        //         Visible = false;
        //     }
        //     field("Driver Code";Rec."Driver Code")
        //     {
        //         Description = 'DIT-715 #244';
        //         Visible = false;
        //     }
        // }
        // BC Upgrade SHUKLP03 >> DrinkIT fields are bocked.

        addafter("Receipt Date")
        {

            // BC Upgrade SHUKLP03 >> DrinkIT fields are bocked.
            // field("ShortcutQtyUomValue[1]";ShortcutQtyUomValue[1])
            // {
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassUom(1);
            //     DecimalPlaces = 0:5;
            //     Description = 'DIT-715 #244';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("ShortcutQtyUomValue[2]";ShortcutQtyUomValue[2])
            // {
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassUom(2);
            //     DecimalPlaces = 0:5;
            //     Description = 'DIT-715 #244';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("ShortcutQtyUomValue[3]";ShortcutQtyUomValue[3])
            // {
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassUom(3);
            //     DecimalPlaces = 0:5;
            //     Description = 'DIT-715 #244';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Work Order No.";"Work Order No.")
            // {
            //     Visible = false;
            // }
            // field(txtStatusCtrl;txtStatus)
            // {
            //     CaptionML = ENU='Replenishment Status',
            //                 FRA='Etat Réapprovisionnement';
            //     Description = 'FINXL8.00';
            //     Editable = false;
            //     Style = StandardAccent;
            //     StyleExpr = blnNoStock;
            //     Visible = false;
            // }
            // BC Upgrade SHUKLP03 >> DrinkIT fields are bocked.

            field("Last Shipment No."; Rec."Last Shipment No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Last Shipment No. field.';
            }
            field("Last Receipt No."; Rec."Last Receipt No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Last Receipt No. field.';
            }
            field("IC Document"; Rec."IC Document FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the IC Document field.';
            }
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the External Document No. field.';
            }
            field("PO Reference"; Rec."PO Reference FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PO Reference field.';
            }
            field("Import Identifier"; Rec."Import Identifier FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Import Identifier field.';
            }
            field("Extra PO Reference"; Rec."Extra PO Reference FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Extra PO Reference field.';
            }
            field("Request Order No."; Rec."Request Order No. FND")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the Request Order No. field.';
            }
            field("Created By"; Rec."Created By FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Created By field.';
            }
            field("Email Sent-Create"; Rec."Email Sent-Create FND")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
                ToolTip = 'Specifies the value of the Email Sent-Create field.';
            }
        }
    }
    actions
    {
        modify("O&rder")
        {
            CaptionML = ENU = 'O&rder', FRA = 'C&ommande';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(Documents)
        {
            CaptionML = ENU = 'Documents', FRA = 'Documents';
        }
        modify("S&hipments")
        {
            CaptionML = ENU = 'S&hipments', FRA = 'E&xpéditions';
        }
        modify("Re&ceipts")
        {
            CaptionML = ENU = 'Re&ceipts', FRA = 'Ré&ceptions';
        }
        modify(Warehouse)
        {
            CaptionML = ENU = 'Warehouse', FRA = 'Entrepôt';
        }
        modify("Whse. Shi&pments")
        {
            CaptionML = ENU = 'Whse. Shi&pments', FRA = 'E&xpéditions entrep.';
        }
        modify("&Whse. Receipts")
        {
            CaptionML = ENU = '&Whse. Receipts', FRA = 'Ré&ceptions entrep.';
        }
        modify("In&vt. Put-away/Pick Lines")
        {
            CaptionML = ENU = 'In&vt. Put-away/Pick Lines', FRA = 'Lignes prélè&v./rangement stock';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
        }
        modify(Release)
        {
            CaptionML = ENU = 'Release', FRA = 'Lancer';
        }
        modify("Re&lease")
        {
            CaptionML = ENU = 'Re&lease', FRA = '&Lancer';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Create Whse. S&hipment")
        {
            CaptionML = ENU = 'Create Whse. S&hipment', FRA = 'Créer e&xpédition entrepôt';
        }
        modify("Create &Whse. Receipt")
        {
            CaptionML = ENU = 'Create &Whse. Receipt', FRA = 'Créer &réception entrepôt';
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            CaptionML = ENU = 'Create Inventor&y Put-away/Pick', FRA = 'Créer prélèv./rangement stoc&k';
        }
        modify("Get Bin Content")
        {
            CaptionML = ENU = 'Get Bin Content', FRA = 'Extraire contenu emplacement';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
        }
        modify(Post)
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
        }
        modify(PostAndPrint)
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
        }
        modify("Inventory - Inbound Transfer")
        {
            CaptionML = ENU = 'Inventory - Inbound Transfer', FRA = 'Stocks : Enlogement transfert';
        }
        modify("Reo&pen")
        {
            trigger OnBeforeAction()
            var
                PurchHeader: Record "Purchase Header";
                lrec_PurchHdrAddtnl: Record "Purchase Header Additional FND";
                lrec_PurchLn: Record "Purchase Line";
                ReleaseTransferDoc: Codeunit "Release Transfer Document";
                Onelienreceipt: Boolean;
            begin
                //HEI.10>>
                IF Rec."PO Reference FND" <> '' THEN
                    IF PurchHeader.GET(PurchHeader."Document Type"::Order, Rec."PO Reference FND") THEN BEGIN
                        PurchHeader.CALCFIELDS("Import Identifier FND");
                        IF PurchHeader."Import Identifier FND" THEN BEGIN
                            lrec_PurchLn.RESET();
                            lrec_PurchLn.SETRANGE("Document Type", PurchHeader."Document Type");
                            lrec_PurchLn.SETRANGE("Document No.", PurchHeader."No.");
                            lrec_PurchLn.SETFILTER("Quantity Received", '<>%1', 0);
                            IF NOT lrec_PurchLn.ISEMPTY THEN
                                ReleaseTransferDoc.Reopen(Rec)
                            else
                                ERROR(Text50001, Rec."No.", Rec."PO Reference FND");
                        end;
                    end;
                //ReleaseTransferDoc.Reopen(Rec); // BC Upgrade SHUKLP03 << Blocked because code is written on OnAction.
                //HEI.10<<

            end;
        }


        //Unsupported feature: CodeModification on ""Reo&pen"(Action 1102601017).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReleaseTransferDoc.Reopen(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.08>>
        //ReleaseTransferDoc.Reopen(Rec);
        //HEI.10>>
        //Onelienreceipt := FALSE;
        //IF lrec_PurchHdrAddtnl.GET(lrec_PurchHdrAddtnl."Document Type"::Order,"PO Reference") THEN BEGIN
        //  IF lrec_PurchHdrAddtnl."Import Identifier" THEN BEGIN
        //    lrec_PurchLn.RESET;
        //    lrec_PurchLn.SETRANGE("Document Type",lrec_PurchHdrAddtnl."Document Type");
        //    lrec_PurchLn.SETRANGE("Document No.",lrec_PurchHdrAddtnl."No.");
        //    IF lrec_PurchLn.findset THEN REPEAT
        //      IF (lrec_PurchLn."Quantity Received" <> 0) THEN
        //        Onelienreceipt := TRUE;
        //    UNTIL (lrec_PurchLn.NEXT = 0) OR (Onelienreceipt = TRUE);
        //  end;
        //end;
        //IF ("PO Reference" <> '') THEN BEGIN
        //  IF NOT Onelienreceipt THEN
        //    ERROR(Text50001,"No.","PO Reference")
        //  else
        //    ReleaseTransferDoc.Reopen(Rec);
        //end else
        //  ReleaseTransferDoc.Reopen(Rec);
        ////HEI.08<<
        if Rec."PO Reference" <> '' then
          if PurchHeader.GET(PurchHeader."Document Type"::Order, "PO Reference") then begin
            PurchHeader.CALCFIELDS("Import Identifier");
            if PurchHeader."Import Identifier" then begin
              lrec_PurchLn.RESET;
              lrec_PurchLn.SETRANGE("Document Type",PurchHeader."Document Type");
              lrec_PurchLn.SETRANGE("Document No.",PurchHeader."No.");
              lrec_PurchLn.SETFILTER("Quantity Received",'<>%1',0);
              if not lrec_PurchLn.ISEMPTY then
                ReleaseTransferDoc.Reopen(Rec)
              else
                ERROR(Text50001, Rec."No.", Rec."PO Reference");
            end;
          end;
        ReleaseTransferDoc.Reopen(Rec);
        //HEI.10<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Create Whse. S&hipment"(Action 1102601013).OnAction". Please convert manually.

        //trigger  S&hipment"(Action 1102601013)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetSourceDocOutbound.CreateFromOutbndTransferOrder(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.04>>
        if LSRInterfaceSetup.GET and LSRInterfaceSetup."Enable LSR Interface" then
          if InterfaceSetup.GET(LSRInterfaceSetup."Transfer Shipment Interface") then
          if InterfaceSetup.Enabled then
            if "LSR Order No" <> '' then begin
              LocationFrom.GET("Transfer-from Code");
              if LocationFrom.Store then
                ERROR(CannotShipInHLErr);
            end;
        //HEI.04<<
        //HEI.07>>
        Onelienreceipt := false;
        MaximoDoc := false;
        if lrec_PurchHdrAddtnl.GET(lrec_PurchHdrAddtnl."Document Type"::Order,"PO Reference") then begin
          if lrec_PurchHdrAddtnl."Import Identifier" then begin
            if lrec_PurchHdr.GET(lrec_PurchHdr."Document Type"::Order,"PO Reference") then
              if (lrec_PurchHdr."Maximo Requisition No." <> '') then
                MaximoDoc := true;
            lrec_PurchLn.RESET;
            lrec_PurchLn.SETRANGE("Document Type",lrec_PurchHdrAddtnl."Document Type");
            lrec_PurchLn.SETRANGE("Document No.",lrec_PurchHdrAddtnl."No.");
            if lrec_PurchLn.findset then repeat
              if (lrec_PurchLn."Quantity Received" <> 0) then
                Onelienreceipt := true;
            until (lrec_PurchLn.NEXT = 0) or (Onelienreceipt = true);
          end;
        end;
        if MaximoDoc then
          ERROR(Text50000,"No.");

        if ("PO Reference" <> '') then begin
          if not MaximoDoc and not Onelienreceipt then
            ERROR(Text50002,"No.","PO Reference");
          if not MaximoDoc and Onelienreceipt then
            GetSourceDocOutbound.CreateFromOutbndTransferOrder(Rec);
        end else
        //HEI.07<<
        GetSourceDocOutbound.CreateFromOutbndTransferOrder(Rec);
        */
        //end;


        //Unsupported feature: CodeModification on ""Create &Whse. Receipt"(Action 1102601012).OnAction". Please convert manually.

        //trigger  Receipt"(Action 1102601012)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetSourceDocInbound.CreateFromInbndTransferOrder(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.04>>
        if LSRInterfaceSetup.GET and LSRInterfaceSetup."Enable LSR Interface" then
          if InterfaceSetup.GET(LSRInterfaceSetup."Transfer Receipt Interface Out") then
          if InterfaceSetup.Enabled then
            if "LSR Order No" <> '' then begin
              LocationTo.GET("Transfer-to Code");
              if LocationTo.Store then
                ERROR(CannotReceiveInHLErr);
            end;
        //HEI.04<<

        GetSourceDocInbound.CreateFromInbndTransferOrder(Rec);
        */
        //end;
    }

    var
        LocationFrom: Record Location;

        LocationTo: Record Location;
        lrec_PurchHdr: Record "Purchase Header";
        PurchHeader: Record "Purchase Header";
        lrec_PurchHdrAddtnl: Record "Purchase Header Additional FND";
        lrec_PurchLn: Record "Purchase Line";

        cduOrderTrackingMngt: Codeunit OrderTrackingManagement;
        blnNoStock: Boolean;
        MaximoDoc: Boolean;
        Onelienreceipt: Boolean;
        ShortcutQtyUomBase: array[3] of Decimal;
        ShortcutQtyUomOutstd: array[3] of Decimal;
        //recFinXLSetup: Record "Finance XL Setup";      // BC Upgrade SHUKLP03 >> DrinkIT Variable.
        ShortcutQtyUomValue: array[3] of Decimal;
        CannotReceiveInHLErr: Label 'A Transfer Order to Store Location can not be received in Heilite.';
        CannotShipInHLErr: Label 'A Transfer Order from Store Location can not be shipped in Heilite.';
        Text50000: Label 'Warehouse Shipment Doc can not be created for this Transfer Order - %1 as it is created from PO process';
        Text50001: Label '"Tranfer Order - %1 can not be opened manually as it is created from Import PO - %2 "';
        Text50002: Label 'Warehouse Shipment Doc can not be created for this Transfer Order - %1 as it is created from Import PO process and PO- %2 is not fully or partially received';
        txtStatus: Text[80];
        txt2036301: TextConst ENU = 'No Stock', FRA = 'Pas d''inv.';


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //begin
    /*
    // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244 - DITW110.00.12 AKH 30/03/2018 NRQ#16026
    ShowShortcutUomValue(ShortcutQtyUomBase,ShortcutQtyUomOutstd,2);
    // >>DITW16.00.00.40 DDR DIT-715 #244 - DITW110.00.12 AKH NRQ#16026
    //<<FINXL8.00.001 BSA 29/05/2015 #180
    if recFinXLSetup.READPERMISSION then fctCalculateReplanStatus;
    //>>FINXL8.00.001 BSA 29/05/2015 #180
    */
    //end;

    // BC Upgrade SHUKLP03 >> DrinkIT procedure is blocked.
    // local procedure fctCalculateReplanStatus();
    // begin
    //     //<<FINXL8.00.001 BSA 29/05/2015 #180
    //     txtStatus:= '';
    //     CLEAR(cduOrderTrackingMngt);
    //     txtStatus := cduOrderTrackingMngt.CalculateStatusString(cduOrderTrackingMngt.fctCalculateTransferStatus(Rec));
    //     blnNoStock := (STRPOS(txtStatus,txt2036301) <> 0);
    //     //>>FINXL8.00.001 BSA 29/05/2015 #180
    // end;
    // BC Upgrade SHUKLP03 >> DrinkIT procedure is blocked.


    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

