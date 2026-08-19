tableextension 50194 WarehouseShipmentLineExtFND extends "Warehouse Shipment Line"
{
    //     DIT15.00.00.21 DDR 19/06/2008 Change Caption of field41 "Cubage" > Caption "Volume (Cubage)"
    //                               Calculate Item Weight & Cubage anytime
    //                               Added key "Source Document,Source No."
    //                               Added function UpdateShippingWhseHeader()
    // DITW15.00.00.23.04 DDR 12/09/2008
    //                               Added fields
    //                                  2014079 "Weight to ship"
    //                                  2014080 "Cubage to ship"
    //                               Change Caption of field41 "Volume (Cubage)" -> "Volume Outstanding (Cubage)"
    //                               Change Caption of field42 "Weight"          -> "Weight Outstanding"
    //                               Move call function UpdateShippingWhseHeader(Rec) into fieldtrigger "Qty. to ship"
    //                               Added UpdateShippingWhseHeader when insert new record
    // DITW15.00.00.25 DDR 17/10/2008 Added UpdateShippingWhseHeader when insert new record
    //                                Added sumindexfields for Weight,Cubage for key [No.,Item No.]
    //                                  fields [Weight,Cubage,Weight to Ship,Cubage to Ship]
    // DITW15.00.00.25.01 DDR 12/01/2009 License problem
    // DITW15.00.00.30 DDR 21/01/2009 merge DITW15.00.00.25.01
    // DITW15.00.00.33 DDR 13/05/2009 Added fields
    //                                  2013667 Item DTax Group Code
    //                                  2013751 Src. DTax Group Code
    // DITW15.00.00.35 DLE 06/09/2009 issue 516 Added fields
    //                                  2013696 Location Group Code
    //                                  2014094 Physical Location Group Code
    // DITW15.00.00.36 DDR 06/11/2009 issue 777 Added functions ShowCommentLines(),HasComments(),DrillDownTotalHeaderVolWeight()
    // DITW15.00.00.38 DDR 19/11/2010 issue 1139 SSCC Functionnalities
    //                                  Added functions OpenSSCCTrackingLines()
    // DITW15.00.00.38 PRODW14.00.00.08.17 DDR 10/02/2011 issue 1273
    //                                Added to transfer Bin Code for item tracking lines
    // DITW15.00.00.38 DDR 11/03/2011 issue 458 Replaced caption field2013696 'Location Group' -> 'Location Tax Group'
    //                                                           field2014094 (dutch)
    // DITW15.00.00.39 DDR 21/06/2011 issue 1370 Bugfix TableRelation property field2013751 "Source DTax Group Code"
    // DITW15.00.00.39 DDR 22/08/2011 issue 1399 Modified function TestReleased() for pending pick status
    //                                Added fields
    //                                  2014105 Exist Posting Error Lines (flowfield)
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002
    //                                Added fields
    //                                  2014107 Route
    //                                  2014495 Delivery Sequence
    //                                Added keys
    //                                  "No.,Delivery Sequence"
    //                                  "No.,Route"
    //                                  "No.,Route,Destination No."
    //                                Added call function DeleteLinkWhseRqst()
    //                                Added functions IsLastSourceSourceDoc()
    //                     02/01/2012 DIT-715 issue 185
    //                                Added fields
    //                                  2014440 Attached to Line No.
    //                                Added functions UpdateAttachedLines(),SetWhseShptHeader()
    // DITW16.00.00.40 DDR 03/02/2012 #1331 (HIT0069.1 VVE 19/04/2011) FEFO tracking
    //                                Added function FEFOTracking()
    //                     13/02/2012 DIT-715 #244
    //                                Added fields
    //                                  2014069 Shortcut Unit of Measure1 Code
    //                                  2014089 Shortcut Unit of Measure2 Code
    //                                  2014093 Shortcut Unit of Measure3 Code
    //                                Added functions GetCaptionClassUom(),ShowShortcutUomValue()
    // DITW16.00.00.43 DDR 27/08/2013 DIT-715 #720 Added functions EmcsSalesHeaderExist()
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM

    // FINXL7.00.001 RBE 20/03/2013: Item description extend from 30 -> 80 chars

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 DDR 17/05/2013 DIT-770 #95 Added "Location Code" to key "No.,Item No.,Location Code"
    //                  27/08/2013 DIT-770 #720 merge
    // DITW17.00.02 SR 20/09/2013 DIT-770 #180 : New Field "2035391" Added
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.07 VSC 28/01/2016 DIT-770 #1702 Assign "Manco/Surplus Tolerance %" from ItemCat.
    // DITW18.00.07 VSC 16/02/2016 DIT-770 #1703 Managing of partial Warehouse shipments
    // DITW18.00.07 VSC 19/02/2016 DIT-770 #1703 CalcBaseQty Set to Global
    // DITW18.00.07 VSC 19/02/2016 DIT-770 #1703 New Function AllItemsAvailability
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // DITW18.00.07 VSC 29/06/2016 DIT-770 #1066 Removed Fields and allign code Delete Function UpdateShippingWhseHeader

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 AKH 31/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // DITW110.00.11 VSC 03/10/2017 NRQ#33755 New Field Backorder Type
    // DITW110.00.12 MSF 07/05/2018 NRQ#69180 Create whse receipt-shipment should work directly again after the Whse document was deleted
    // DITW111.00.13 MSF 01/02/2019 NRQ#100207 : Auto Fefo in warehouse shipment should not skip promotion item lines
    // DITW111.00.13A MSF 30/04/2019 NRQ#106834 AUTO FEFO and Undo Tracking Lines functions for transfer orders

    // HEI.02 FDD-PRDGAP024 IBM POENAB01 01.08.2017
    //   #changed table relation for field 13 Zone Code
    //   #Code added in Bin Code - OnValidate()
    // HEI.03 FDD-SLSGAP001 IBM NASTAA02 08.09.2017 # MDM Customer Card
    //   # Increased "Src. DTax Group Code" field length from 10 to 20 characters
    // HEI.04 FDD-KDD0TC001 IBM HORTOC01 26.09.2017
    //   # New fields
    // HEI.05 FDD-LB-GAPLOG03 IBM NASTAA02 17.07.2018 # Loading Note Almaza
    //   # New Field created 50008 - Print Load List Shipment
    // DITW110.00.13 ISL 05/12/2018 NRQ#91882 Synchnized "Backorder Type"
    // DITW111.00.13 MSF 06/12/2018 NRQ#94671 Line and header alert for not fully assigned lines - in warehouse shipment and sales order
    //                                         Added field Lot Reserved Qty. (Base)
    // DITW111.00.13 MSF 31/01/2019 NRQ#99742 :Auto Fefo in Whse shipment should be based on shipment line's BIN (not source line's Bin)
    // DITW111.00.13 MSF 01/02/2019 NRQ#100207 : Auto Fefo in warehouse shipment should not skip promotion item lines
    // HEI.06 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new fields added "Load No." & "Sequence No."

    // HEI.07 FDD-SR_HT465 IBM 30.07.2019 - #new key added  "No.,Source Type,Source Subtype,Source No.,Source Line No.,Sequence No."
    // HEI.08 CHG2095415 IBM BULIMC01 06.05.2021#new field added: 50012 -"Item Category Code"
    // DITW114.00.15 DDR 24/04/2020 NRQ#102424 Fix remove checking on source promotion lines
    // HEI.09 CHG2188015 DEBUSD01 10.01.2023 Qty to Ship behavior on promotionline partialShipments
    //   # merge NRQ#102424
    // HEI.10 CHG2217161 SAHAL01 02.11.2023 SPL for Returns and GR cancellations
    //   # Created New Fields: 50057 - SPL Code
    //                         50058 - SPL Name
    //                         50059 - Consumption SPL Code

    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify("Source Type")
        {
            CaptionML = ENU = 'Source Type', FRA = 'Type origine';
        }
        modify("Source Subtype")
        {
            CaptionML = ENU = 'Source Subtype', FRA = 'Sous-type origine';
            OptionCaptionML = ENU = '0,1,2,3,4,5,6,7,8,9,10', FRA = '0,1,2,3,4,5,6,7,8,9,10';
        }
        modify("Source No.")
        {
            CaptionML = ENU = 'Source No.', FRA = 'N° origine';
        }
        modify("Source Line No.")
        {
            CaptionML = ENU = 'Source Line No.', FRA = 'N° ligne origine';
        }
        modify("Source Document")
        {
            CaptionML = ENU = 'Source Document', FRA = 'Document origine';
            //  OptionCaptionML = ENU = ',Sales Order,,,Sales Return Order,Purchase Order,,,Purchase Return Order,,Outbound Transfer,,,,,,,,Service Order', FRA = ',Commande vente,,,Retour vente,Commande achat,,,Retour achat,,Désenlogement transfert,,,,,,,,Commande service';
        }
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Shelf No.")
        {
            CaptionML = ENU = 'Shelf No.', FRA = 'N° emplacement';
        }
        modify("Bin Code")
        {
            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement';
            trigger OnAfterValidate()
            var
                Bin: Record Bin;
                Location: Record Location;
            begin
                //HEI.02 PRDGAP024>>
                if Location.Get("Location Code") then begin
                    if Bin.Get(Location.Code, "Bin Code") then
                        "Zone Code" := Bin."Zone Code";
                end;
                //HEI.02 PRDGAP024<<
            end;
            //BC Upgrade SHARMP16 end<<
        }
        modify("Zone Code")
        {

            //Unsupported feature: Change TableRelation on ""Zone Code"(Field 13)". Please convert manually.

            CaptionML = ENU = 'Zone Code', FRA = 'Code zone';
        }
        modify("Item No.")
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Qty. (Base)")
        {
            CaptionML = ENU = 'Qty. (Base)', FRA = 'Qté (base)';
        }
        modify("Qty. Outstanding")
        {
            CaptionML = ENU = 'Qty. Outstanding', FRA = 'Qté ouverte';
        }
        modify("Qty. Outstanding (Base)")
        {
            CaptionML = ENU = 'Qty. Outstanding (Base)', FRA = 'Qté ouverte (base)';
        }
        modify("Qty. to Ship")
        {
            CaptionML = ENU = 'Qty. to Ship', FRA = 'Qté à expédier';
        }
        modify("Qty. to Ship (Base)")
        {
            CaptionML = ENU = 'Qty. to Ship (Base)', FRA = 'Qté à expédier (base)';
        }
        modify("Qty. Picked")
        {
            CaptionML = ENU = 'Qty. Picked', FRA = 'Qté prélevée';
        }
        modify("Qty. Picked (Base)")
        {
            CaptionML = ENU = 'Qty. Picked (Base)', FRA = 'Qté prélevée (base)';
        }
        modify("Qty. Shipped")
        {
            CaptionML = ENU = 'Qty. Shipped', FRA = 'Qté expédiée';
        }
        modify("Qty. Shipped (Base)")
        {
            CaptionML = ENU = 'Qty. Shipped (Base)', FRA = 'Qté expédiée (base)';
        }
        modify("Pick Qty.")
        {
            CaptionML = ENU = 'Pick Qty.', FRA = 'Prélever qté';
        }
        modify("Pick Qty. (Base)")
        {
            CaptionML = ENU = 'Pick Qty. (Base)', FRA = 'Prélever qté (base)';
        }
        modify("Unit of Measure Code")
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
        }
        modify("Variant Code")
        {
            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description 2', FRA = 'Désignation 2';
        }
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            // OptionCaptionML = ENU = ' ,Partially Picked,Partially Shipped,Completely Picked,Completely Shipped', FRA = ' ,Partiellement prélevé,Partiellement expédié,Entièrement prélevé,Entièrement expédié';
        }
        modify("Sorting Sequence No.")
        {
            CaptionML = ENU = 'Sorting Sequence No.', FRA = 'N° séquence tri';
        }
        modify("Due Date")
        {
            CaptionML = ENU = 'Due Date', FRA = 'Délai';
        }
        modify("Destination Type")
        {
            CaptionML = ENU = 'Destination Type', FRA = 'Type destination';
            // OptionCaptionML = ENU = ' ,Customer,Vendor,Location', FRA = ' ,Client,Fournisseur,Magasin';
        }
        modify("Destination No.")
        {
            CaptionML = ENU = 'Destination No.', FRA = 'N° destination';
        }
        modify(Cubage)
        {
            CaptionML = ENU = 'Volume Outstanding (Cubage)', FRA = 'Cubage';

            //Unsupported feature: Change Description on "Cubage(Field 41)". Please convert manually.

        }
        modify(Weight)
        {
            CaptionML = ENU = 'Weight Outstanding', FRA = 'Poids';
        }
        modify("Shipping Advice")
        {
            CaptionML = ENU = 'Shipping Advice', FRA = 'Option d''expédition';
            // OptionCaptionML = ENU = 'Partial,Complete', FRA = 'Partielle,Totale';
        }
        modify("Shipment Date")
        {
            CaptionML = ENU = 'Shipment Date', FRA = 'Date d''expédition';
        }
        modify("Completely Picked")
        {
            CaptionML = ENU = 'Completely Picked', FRA = 'Entièrement prélévé';
        }
        modify("Not upd. by Src. Doc. Post.")
        {
            CaptionML = ENU = 'Not upd. by Src. Doc. Post.', FRA = 'Pas de MAJ par doc. source';
        }
        modify("Posting from Whse. Ref.")
        {
            CaptionML = ENU = 'Posting from Whse. Ref.', FRA = 'Validation à partir réf. entrepôt';
        }
        modify("Assemble to Order")
        {
            CaptionML = ENU = 'Assemble to Order', FRA = 'Assemblage à la commande';
        }

        //Unsupported feature: CodeModification on ""Bin Code"(Field 12).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestReleased;
        if xRec."Bin Code" <> "Bin Code" then
          if "Bin Code" <> '' then begin
        #4..11
              CheckBin(0,0);
            end;
          end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..14
        //HEI.02 PRDGAP024>>
          Bin.GET("Location Code","Bin Code");
          "Zone Code" := Bin."Zone Code";
        //HEI.02 PRDGAP024<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Zone Code"(Field 13).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestReleased;
        if xRec."Zone Code" <> "Zone Code" then begin
          if "Zone Code" <> '' then begin
            GetLocation("Location Code");
            Location.TESTFIELD("Directed Put-away and Pick");
          end;
          "Bin Code" := '';
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
            //HEI.01 PRDGAP024 delete line Location.TESTFIELD("Directed Put-away and Pick");
        #6..8
        */
        //end;


        //Unsupported feature: CodeModification on "Quantity(Field 15).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if Quantity <= 0 then
          FIELDERROR(Quantity,Text003);
        TestReleased;
        #4..24
            WhseShptHeader.MODIFY;
          end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..27
        // <<DITW15.00.00.39 DDR 22/08/2011 #1399
        "Posting Error Line" := false;
        // >>DITW15.00.00.39 DDR #1399
        */
        //end;


        //Unsupported feature: CodeModification on ""Qty. Outstanding"(Field 19).OnValidate". Please convert manually.

        //trigger  Outstanding"(Field 19)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetLocation("Location Code");
        "Qty. Outstanding (Base)" := CalcBaseQty("Qty. Outstanding");
        if Location."Require Pick" then begin
        #4..7
        end else
          VALIDATE("Qty. to Ship","Qty. Outstanding");

        if Location."Directed Put-away and Pick" then
          WMSMgt.CalcCubageAndWeight(
            "Item No.","Unit of Measure Code","Qty. Outstanding",Cubage,Weight);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..10
        // <<DIT15.00.00.21 DDR 20/06/2008
        //IF Location."Directed Put-away and Pick" THEN
        if Location."Directed Put-away and Pick" or Location."Allow Calculate Weight Cubage" then
        // >>DIT15.00.00.21 DDR 20/06/2008
          WMSMgt.CalcCubageAndWeight(
            "Item No.","Unit of Measure Code","Qty. Outstanding",Cubage,Weight);
        */
        //end;


        //Unsupported feature: CodeModification on ""Qty. to Ship"(Field 21).OnValidate". Please convert manually.

        //trigger  to Ship"(Field 21)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetLocation("Location Code");
        if ("Qty. to Ship" > "Qty. Picked" - "Qty. Shipped") and
           Location."Require Pick" and
           not "Assemble to Order"
        then
          FIELDERROR("Qty. to Ship",
            STRSUBSTNO(Text002,"Qty. Picked" - "Qty. Shipped"));

        if "Qty. to Ship" > "Qty. Outstanding" then
          ERROR(
            Text000,
        #12..32
        if CurrFieldNo <> FIELDNO("Qty. to Ship (Base)") then
          "Qty. to Ship (Base)" := CalcBaseQty("Qty. to Ship");

        if "Assemble to Order" then
          ATOLink.UpdateQtyToAsmFromWhseShptLine(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..8
        //<< DITW18.00.07 VSC 28/01/2016 DIT-770 #1702
        if CurrFieldNo <> 0 then begin
          if ("Source Type" = 37) and ("Source Subtype" = 1) then begin // Sales Order
            if SalesLine.GET("Source Subtype","Source No.","Source Line No.") then begin
              if CurrFieldNo = FIELDNO("Qty. to Ship") then
                MancoSurplusTolerance := SalesLine.ApplyMancoSurplusTolerance("Qty. to Ship")
              else
                MancoSurplusTolerance := false;

              if MancoSurplusTolerance then begin
                SalesHeader.GET(SalesLine."Document Type",SalesLine."Document No.");
                OldSalesHeader := SalesHeader;
                if SalesHeader.Status = SalesHeader.Status::Released then
                  ReleaseSalesDocument.Reopen(SalesHeader);
                SalesLine.FIND;
              end;
              SalesLine.SetChangedFromWarehouse(true);
              SalesLine.VALIDATE("Qty. to Ship","Qty. to Ship");
              SalesLine.MODIFY(true);
              "Qty. Outstanding" := SalesLine."Outstanding Quantity";
              "Qty. Outstanding (Base)" := CalcBaseQty("Qty. Outstanding");

              if MancoSurplusTolerance then begin
                Quantity := SalesLine.Quantity;
                "Qty. (Base)" := CalcBaseQty(Quantity);
                if OldSalesHeader.Status = OldSalesHeader.Status::Released then
                  ReleaseSalesDocument.RUN(SalesHeader);
              end;
            end;
          end;
          if ("Source Type" = 39) and ("Source Subtype" = 5) then begin // Return Order
            if PurchLine.GET("Source Subtype","Source No.","Source Line No.") then begin
              if CurrFieldNo = FIELDNO("Qty. to Ship") then
                MancoSurplusTolerance := PurchLine.ApplyMancoSurplusTolerance("Qty. to Ship")
              else
                MancoSurplusTolerance := false;

              if MancoSurplusTolerance then begin
                PurchHeader.GET(SalesLine."Document Type",PurchLine."Document No.");
                OldPurchHeader := PurchHeader;
                if PurchHeader.Status = PurchHeader.Status::Released then
                  ReleasePurchDocument.Reopen(PurchHeader);
                PurchLine.FIND;
              end;
              PurchLine.fctSetChangedFromWarehouseRcpt(true);
              PurchLine.VALIDATE("Return Qty. to Ship","Qty. to Ship");
              PurchLine.MODIFY(true);
              "Qty. Outstanding" := PurchLine."Outstanding Quantity";
              "Qty. Outstanding (Base)" := CalcBaseQty("Qty. Outstanding");

              if MancoSurplusTolerance then begin
                Quantity := PurchLine.Quantity;
                "Qty. (Base)" := CalcBaseQty(Quantity);
                if OldPurchHeader.Status = OldPurchHeader.Status::Released then
                  ReleasePurchDocument.RUN(PurchHeader);
              end;
            end;
          end;
        end;
        //>> DITW18.00.07 VSC DIT-770 #1702

        #9..35
        // <<DITW16.00.00.40 DDR 02/01/2012 DIT-715 #185
        if CurrFieldNo = FIELDNO("Qty. to Ship") then begin
          /// DITW114.00.15 DDR 24/04/2020 NRQ#102424
          if xRec."Qty. to Ship" <> "Qty. to Ship" then begin
            UpdateAttachedLines(FIELDNO("Qty. to Ship"),true);
          end;
        end;
        // >>DITW16.00.00.40 DDR DIT-715 #185

        // <<DITW15.00.00.23.04 DDR£ 12/09/2008
        if Location."Directed Put-away and Pick" or Location."Allow Calculate Weight Cubage" then
          WMSMgt.CalcCubageAndWeight(
            "Item No.","Unit of Measure Code","Qty. to Ship","Cubage to Ship","Weight to Ship");
        // >>DITW15.00.00.23.04 DDR

        // <<DITW15.00.00.39 DDR 22/08/2011 #1399
        "Posting Error Line" := false;
        // >>DITW15.00.00.39 DDR #1399

        if "Assemble to Order" then
          ATOLink.UpdateQtyToAsmFromWhseShptLine(Rec);
        */
        //end;
        field(50005; "RPM Solution FND"; Option)
        {
            Caption = 'RPM Solution';
            Description = 'HEI.04';
            Editable = false;
            OptionCaption = '" ,Deposit,Full-for-Empty with revenue impact (FFE with revenue),Full-for Empty without revenue impact (FFE w/o revenue)"';
            OptionMembers = " ",Deposit,"Full-for-Empty with revenue impact (FFE with revenue)","Full-for Empty without revenue impact (FFE w/o revenue)";
        }
        field(50006; "RPM Type FND"; Code[20])
        {
            Caption = 'RPM Type';
            Description = 'HEI.04';
            Editable = false;
            TableRelation = "Return Pack Material Type FND".Code;
        }
        field(50007; "Item Type FND"; Option)
        {
            Caption = 'Item Type';
            Description = 'HEI.04';
            Editable = false;
            OptionCaption = '" ,RPM Related,Product Related"';
            OptionMembers = " ","RPM Related","Product Related";
        }
        field(50008; "Print Load List Shipment FND"; Boolean)
        {
            Caption = 'Print Load List Shipment';
            Description = 'HEI.05';
            Editable = false;
        }
        field(50010; "Sequence No. FND"; Integer)
        {
            Caption = 'Sequence No.';
            Description = 'HEI.06';
            FieldClass = Normal;
        }
        field(50011; "Load No. FND"; Integer)
        {
            Caption = 'Load No.';
            Description = 'HEI.06';
        }
        field(50012; "Item Category Code FND"; Code[20])
        {
            Caption = 'Item Category Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(50057; "SPL Code FND"; Code[20])
        {
            Caption = 'SPL Code';
            Description = 'HEI.10';
            TableRelation = "Vendor SPL Relation FND"."SPL Code" where(Blocked = CONST(false));

            trigger OnValidate();
            var
                VendorSPL: Record "Vendor SPL Relation FND";
            begin
            end;
        }
        field(50058; "SPL Name FND"; Text[50])
        {
            Caption = 'SPL Name';
            Description = 'HEI.10';
            Editable = false;
        }
        field(50059; "Consumption SPL Code FND"; Code[20])
        {
            Caption = 'Consumption SPL Code';
            Description = 'HEI.10';
            Editable = false;
            TableRelation = "Vendor SPL Relation FND"."SPL Code" where(Blocked = CONST(false));
        }
        field(50060; "External Document No. FND"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50061; "Cubag To Ship FND"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        //BC Upgrade SHARMP16 Begin<<-------------------Drink-IT fields
        // field(2013667;"Item DTax Group Code";Code[10])
        // {
        //     CaptionML = ENU='Item Tax Group Code',
        //                 FRA='Code groupe taxe article';
        //     Description = 'DITW15.00.00.33';
        //     TableRelation = "Drink Tax Group".Code WHERE ("Source Type"=CONST(Item));
        // }
        // field(2013696;"Location Group Code";Code[10])
        // {
        //     CaptionML = ENU='Location Tax Group Code',
        //                 FRA='Code groupe magasin taxe';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Location Group";
        // }
        // field(2013751;"Src. DTax Group Code";Code[20])
        // {
        //     CaptionML = ENU='Source Tax Group Code',
        //                 FRA='Code groupe taxe Source';
        //     Description = 'DITW15.00.00.33-.39 #1370,HEI.03';
        //     TableRelation = "Drink Tax Group".Code;
        // }
        // field(2014067;"Backorder Type";Option)
        // {
        //     Caption = 'Backorder Type';
        //     Description = 'DITW110.00.11 NRQ#33755';
        //     OptionCaption = '" ,Backorder,No Backorder"';
        //     OptionMembers = " ",Backorder,"No Backorder";

        //     trigger OnValidate();
        //     var
        //         ItemBackOrderNotification : Notification;
        //     begin
        //         //<< DITW110.00.11 VSC 03/10/2017 NRQ#33755
        //         case "Source Type" of
        //           DATABASE::"Purchase Line":begin
        //             case "Source Subtype" of
        //               1:begin
        //                 if "Backorder Type" = "Backorder Type"::Backorder then
        //                   ERROR(Text2014067,FIELDCAPTION("Backorder Type"),"Backorder Type");
        //               end;
        //               5:;
        //               else
        //                 "Backorder Type" := "Backorder Type"::" ";
        //             end;
        //           end;
        //           DATABASE::"Sales Line":begin
        //             case "Source Subtype" of
        //               // <<DITW110.00.13 ISL 05/12/2018 NRQ#91882
        //               1:BackorderMgt.SyncBackorder("Source Subtype","Source No.","Source Line No.","Backorder Type");
        //               // >>DITW110.00.13 ISL NRQ#91882
        //               5:begin
        //                 if "Backorder Type" = "Backorder Type"::Backorder then
        //                   ERROR(Text2014067,FIELDCAPTION("Backorder Type"),"Backorder Type");
        //               end;
        //               else
        //                 "Backorder Type" := "Backorder Type"::" ";
        //             end;
        //           end;
        //           DATABASE::"Transfer Line" :begin
        //               "Backorder Type" := "Backorder Type"::" ";
        //           end;
        //         end;
        //     end;
        // }
        // field(2014079;"Cubage to Ship";Decimal)
        // {
        //     CaptionML = ENU='Volume To Ship (Cubage)',
        //                 FRA='Volume à expédier (cubage)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.23.04';
        // }
        // field(2014080;"Weight to Ship";Decimal)
        // {
        //     CaptionML = ENU='Weight To Ship',
        //                 FRA='Poids à expédier';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.23.04';
        // }
        // field(2014094;"Physical Location Group Code";Code[10])
        // {
        //     CaptionML = ENU='Physical Location Group Code',
        //                 FRA='Code groupe magasin réel';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014105;"Posting Error Line";Boolean)
        // {
        //     CaptionML = ENU='Posting Error',
        //                 FRA='Erreur de validation';
        //     Description = 'DITW15.00.00.39 #1399';
        // }
        // field(2014107;Route;Code[20])
        // {
        //     CaptionML = ENU='Route',
        //                 FRA='Route';
        //     Description = 'DITW16.00.00.40 #1002';
        //     TableRelation = Route;
        // }
        // field(2014418;"Lot Reserved Qty. (Base)";Decimal)
        // {
        //     CalcFormula = -Sum("Reservation Entry"."Quantity (Base)" WHERE ("Source ID"=FIELD("Source No."),
        //                                                                     "Source Type"=FIELD("Source Type"),
        //                                                                     "Source Subtype"=FIELD("Source Subtype"),
        //                                                                     "Source Ref. No."=FIELD("Source Line No."),
        //                                                                     "Reservation Status"=CONST(Surplus),
        //                                                                     "Lot No."=FILTER(<>'')));
        //     Caption = 'Lot Reserved Qty. (Base)';
        //     Description = 'NRQ#94671';
        //     FieldClass = FlowField;
        // }
        // field(2014440;"Attached to Line No.";Integer)
        // {
        //     CaptionML = ENU='Attached to Line No.',
        //                 FRA='Attaché à la ligne n°';
        //     Description = 'DITW16.00.00.40 DIT715 #185';
        //     Editable = false;
        //     TableRelation = "Warehouse Receipt Line"."Line No." WHERE ("No."=FIELD("No."),
        //                                                                "Attached to Line No."=CONST(0));
        // }
        // field(2014495;"Delivery Sequence";Integer)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU='Delivery Sequence',
        //                 FRA='Séquence de livraison';
        //     Description = 'DITW16.00.00.40 #1002';
        //     MinValue = 0;
        // }
        // field(2035391;"External Document No.";Code[35])
        // {
        //     CalcFormula = Lookup("Warehouse Shipment Header"."External Document No." WHERE ("No."=FIELD("No.")));
        //     CaptionML = ENU='External Document No.',
        //                 FRA='N° doc. externe';
        //     Description = 'DITW17.00.02 DIT-770 #180';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        //BC Upgrade SHARMP16 End>>-------------------Drink-IT fields
    }
    keys
    {

        //Unsupported feature: PropertyChange on ""No.","Source Document","Source No."(Key)". Please convert manually.


        //Unsupported feature: Deletion on ""No.","Item No."(Key)". Please convert manually.

        key(Key50000; "No.", "Item No.", "Location Code")
        {
            MaintainSQLIndex = false;
            // SumIndexFields = Weight, Cubage, "Weight to Ship", "Cubage to Ship";////BC Upgrade SHARMP16 Begin<<-------------------Drink-IT field used
        }
        key(Key50001; "Source Document", "Source No.")
        {
        }
        // key(Key3; "No.", "Delivery Sequence")
        // {
        // }//BC Upgrade SHARMP16 Begin<<-------------------Drink-IT fields used
        // key(Key4; "No.", Route)
        // {
        // }//BC Upgrade SHARMP16 Begin<<-------------------Drink-IT fields used
        // key(Key5; "No.", Route, "Destination No.")
        // {
        // }//BC Upgrade SHARMP16 Begin<<-------------------Drink-IT fields used
        // key(Key50003; "No.", "Source Type", "Source Subtype", "Source No.", "Source Line No.", "Sequence No.")
        // {
        // }
    }


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: lrWhseShptLine)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestReleased;

    if "Assemble to Order" then
    #4..21
      WhseShptHeader.VALIDATE("Document Status",OrderStatus);
      WhseShptHeader.MODIFY;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..24

    // <<DITW16.00.00.40 DDR 12/12/2011 #1002
    if IsLastSourceSourceDoc() then
      WMSMgt.DeleteLinkWhseRqst("No.","Source Type","Source Subtype","Source No.","Source Line No.",0);
    // >>DITW16.00.00.40 DDR #1002
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW15.00.00.39 DDR 22/08/2011 #1399
    "Posting Error Line" := false;
    // >>DITW15.00.00.39 DDR #1399
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        OldPurchHeader: Record "Purchase Header";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        OldSalesHeader: Record "Sales Header";
        SalesHeader: Record "Sales Header";
        ReleasePurchDocument: Codeunit "Release Purchase Document";
        ReleaseSalesDocument: Codeunit "Release Sales Document";
        // WMSMgt: Codeunit "WMS Management";
        // SalesLine: Record "Sales Line";
        MancoSurplusTolerance: Boolean;

    var
        lrWhseShptLine: Record "Warehouse Shipment Line";


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You cannot handle more than the outstanding %1 units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot handle more than the outstanding %1 units.;FRA=Vous ne pouvez pas traiter plus que les %1 unités restantes.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=must not be less than %1 units;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=must not be less than %1 units;FRA=ne doit pas être inférieur(e) à %1 unité(s);
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=must not be greater than %1 units;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=must not be greater than %1 units;FRA=doit être inférieur(e) à %1 unités.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=must be greater than zero;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=must be greater than zero;FRA=doit être supérieur(e) à zéro.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=The picked quantity is not enough to ship all lines.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=The picked quantity is not enough to ship all lines.;FRA=La quantité prélevée n'est pas suffisante pour expédier toutes les lignes.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : @@@="Qty. Picked = 2 is greater than Qty. Shipped = 0. If you delete the Warehouse Shipment Line, the items will remain in the shipping area until you put them away.\Related Item Tracking information defined during pick will be deleted.\Do you still want to delete the Warehouse Shipment Line?";ENU="%1 = %2 is greater than %3 = %4. If you delete the %5, the items will remain in the shipping area until you put them away.\Related Item Tracking information defined during pick will be deleted.\Do you still want to delete the %5?";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : @@@="Qty. Picked = 2 is greater than Qty. Shipped = 0. If you delete the Warehouse Shipment Line, the items will remain in the shipping area until you put them away.\Related Item Tracking information defined during pick will be deleted.\Do you still want to delete the Warehouse Shipment Line?";ENU="%1 = %2 is greater than %3 = %4. If you delete the %5, the items will remain in the shipping area until you put them away.\Related Item Tracking information defined during pick will be deleted.\Do you still want to delete the %5?";FRA="La %1 = %2 est supérieure à %3 = %4. Si vous supprimez %5, les articles vont rester dans la zone d'expédition jusqu'a ce que vous les rangiez.\Les informations de traçabilité associées définies lors du prélèvement seront supprimées.\Souhaitez-vous quand même supprimer %5 ?";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=You cannot rename a %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=You cannot rename a %1.;FRA=Vous ne pouvez pas renommer l'enregistrement %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text009(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU=%1 is set to %2. %3 should be %4.\\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : ENU=%1 is set to %2. %3 should be %4.\\;FRA=L'%1 est paramétrée sur %2. La %3 devrait être %4.\\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text010(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text010 : ENU=Accept the entered value?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text010 : ENU=Accept the entered value?;FRA=Acceptez-vous la valeur entrée ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text011(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text011 : ENU=Nothing to handle.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text011 : ENU=Nothing to handle.;FRA=Il n'y a rien à traiter.;
    //Variable type has not been exported.

    var
        //  BackorderMgt: Codeunit "Backorder Mgt.";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        PurchCommentLine: Record "Purch. Comment Line";
        //    rShippingWhseSetup: Record "Shipping-Warehouse Setup";
        SalesCommentLine: Record "Sales Comment Line";
        SalesLine: Record "Sales Line";
        // TaxChargesMgt: Codeunit "Tax Item Charges Mgt.";
        // DepositChargesMgt: Codeunit "Deposit Item Charges Mgt.";
        // PromotionChargesMgt: Codeunit "Promotion Item Charges Mgt.";
        // TransferChargesMgt: Codeunit "Transfer Document Charges Mgt.";
        WhseSetup: Record "Warehouse Setup";
        SaveTempWhseShptLine: Record "Warehouse Shipment Line" temporary;
        WMSMgt: Codeunit "WMS Management";
        Text2014067: Label '%1 can not been set to %2!';
}

