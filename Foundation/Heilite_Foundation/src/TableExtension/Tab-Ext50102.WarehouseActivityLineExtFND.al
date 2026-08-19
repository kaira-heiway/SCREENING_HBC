tableextension 50102 WarehouseActivityLineExtFND extends "Warehouse Activity Line"
{
    // version NAVW110.0.00.16996,OWM4.50,DITW110.00.11,HEI.02
    //HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 # Added FIELDS Linked To Line No.,In-Transit Zone Code,In-Transit Bin Code,Zone-Transfer,Quantity Shipped,
    //   Quantity Received
    //   #EDITABLE FIELDS Item No., Unit of Measure Code, Quantity, Location Code,Activity Type
    //   #Code for handling Zone Code restrictions
    //   #new function IsEditable
    // HEI.02 IBM SOICAD if invt. unit of measure in not blank, take this value as unit of measure in whse. activity line
    // HEI.03 FDD-BA-LOGGAP07 IBM NASTAA02 29.01.2019 # Picking List
    //   # Added new key on: "Source No", "Description"
    // HEI.04 INC2035218 IBM ISYED01 02.12.2019 # WH Zone Movement
    //   # Added code to flow the expiration date while posting receipt for zone warehouse movement
    // HEI.05 CC-CHG2091264 IBM.LS 22.01.2021
    //   # Code uncommented.
    // HEI.06 CHG2075364 IBM.LS 20.07.2021
    //   # Added Code
    //**************************************************************************************************************************

    //BC Upgrade PATHAA02 17.04.25- Changed the Key No. to avoid the error and Keys with DIT fields are commented, 2 DIT fields(Delivery Seq and SSSC No.) and DIT variables commented.

    //HEI.02-->No event in local func-GetItemUnitOfMeasure to adjust the customised code-Pending
    //HEI.04-->Lot no onaftervalidate pending-->CU6500-->ItemTrackingMgt.ExistingExpirationDate-dome
    //HEI.06-//WhseActivityRegisterL.CallItemTracking(Rec) commented-depending on CU7307-Pending
    //Incomplete-need to finalise


    //*****************Review by Saikat******************************************
    // 1. Documentation trigger missed - please add that.
    // 2. Now HEI.04 can be merged as CU6500 is compiled by Priya.
    // 3. Zone Code - OnValidate trigger --> HEI.01 Code needs to be validated as it is missed
    // 4. AutofillQtyToHandle function needs to be revalidated, be noted that few codes are without HEI tag
    // 5. GetItemUnitOfMeasure function needs to be handled - looks like pending
    // 6. Not finding the function - IsEditable
    //******************Response-AK***************************************
    // 2.-->AK-this is std function and parameters changed in BC
    //3-Done-handled(BC UPGRADE PATHAA02 01.12.25 Subscribed to this event to handle code- HEI.01 of "Bin COde-on validate" of T5767<<)--> WarehouseActivityLine_OnBeforeCheckInvalidBinCode
    //4. Done-WarehouseActivityLine_OnBeforeAutofillQtyToHandle
    //5.  GetItemUnitOfMeasure() is a local std function, we cannot do hei.02 as events are missing.
    //6-done
    //----------------------------------------------------------------------
    //HEI.01 done- Table events(OnAfterInsert event, onaftermodifyEvent) is missing for this Table; Bin Code-OnValidate--> CheckInvalidBinCode() is called before event(OnBeforeCheckInvalidBinCode) so can't be subscribed; Zone-Code-->Written on aftervalidate;AutofillQtyToHandle-Eventsubscriber;
    //HEI.02-GetItemUnitOfMeasure() is a local std function, we cannot do hei.02 as events are missing. check if it can written for "Item no" onvalidate-->event(OnValidateItemNoOnAfterValidateUoMCode) )
    //HEI.02 cannot be written on fields (Itemno and Uom code Onaftervalidate as it has dependency with DIT fields-Production UoM and Inventory UoM. HEI.02 might come from DIT
    //HEI.03-Key added
    //HEI.04-Std function-'ExistingExpirationDate' called is different in parameters in BC (CU6500-ItemTrackingMgt)-function parameters changes-done
    //HEI.05 is covered in HEI.01
    //HEI.06-done; Function-OpenItemTrackingLines--> CallItemTracking called from CU7307 is added in HeinekenBCUpgrade CU, applyfilters() comment to be removed after P6510 moves to repo-currently with Priya
    // BC Upgrade - RD03 -- Field value updation -- >> 


    fields
    {
        modify("Activity Type")
        {
            CaptionML = ENU = 'Activity Type', FRA = 'Type activité';
            //OptionCaptionML = ENU = ' ,Put-away,Pick,Movement,Invt. Put-away,Invt. Pick,Invt. Movement', FRA = ' ,Rangement,Prélèvement,Mouvement,Rangement stock,Prélèvement stock,Mouvement stock';
        }
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
        modify("Source Subline No.")
        {
            CaptionML = ENU = 'Source Subline No.', FRA = 'N° sous-ligne origine';
        }
        modify("Source Document")
        {
            CaptionML = ENU = 'Source Document', FRA = 'Document origine';
            //OptionCaptionML = ENU = ' ,Sales Order,,,Sales Return Order,Purchase Order,,,Purchase Return Order,Inbound Transfer,Outbound Transfer,Prod. Consumption,Prod. Output,,,,,,Service Order,,Assembly Consumption,Assembly Order', FRA = ' ,Commande vente,,,Retour vente,Commande achat,,,Retour achat,Enlogement transfert,Désenlogement transfert,Consommation O.F.,Production O.F.,,,,,,Commande service,,Consommation d''assemblage,Ordre d''assemblage';
        }
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Shelf No.")
        {
            CaptionML = ENU = 'Shelf No.', FRA = 'N° emplacement';
        }
        modify("Sorting Sequence No.")
        {
            CaptionML = ENU = 'Sorting Sequence No.', FRA = 'N° séquence tri';
        }
        modify("Item No.")
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
            //BC upgrade GUNREM01 FDD-DTW12 >>
            trigger OnBeforeValidate()
            var
                Item: Record Item;
            begin
                if Item.Get(Rec."Item No.") then
                    Item.BlockedSKU(Rec."Location Code", Rec."Variant Code", true);
            end;
            //BC upgrade GUNREM01 FDD-DTW12 << 
        }
        modify("Variant Code")
        {

            //Unsupported feature: Change TableRelation on ""Variant Code"(Field 15)". Please convert manually.

            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Unit of Measure Code")
        {

            //Unsupported feature: Change TableRelation on ""Unit of Measure Code"(Field 16)". Please convert manually.

            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description 2', FRA = 'Désignation 2';
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
        modify("Qty. to Handle")
        {
            CaptionML = ENU = 'Qty. to Handle', FRA = 'Quantité à traiter';
        }
        modify("Qty. to Handle (Base)")
        {
            CaptionML = ENU = 'Qty. to Handle (Base)', FRA = 'Quantité à traiter (base)';
        }
        modify("Qty. Handled")
        {
            CaptionML = ENU = 'Qty. Handled', FRA = 'Quantité traitée';
        }
        modify("Qty. Handled (Base)")
        {
            CaptionML = ENU = 'Qty. Handled (Base)', FRA = 'Quantité traitée (base)';
        }
        modify("Shipping Advice")
        {
            CaptionML = ENU = 'Shipping Advice', FRA = 'Option d''expédition';
            //OptionCaptionML = ENU = 'Partial,Complete', FRA = 'Partielle,Totale';
        }
        modify("Due Date")
        {
            CaptionML = ENU = 'Due Date', FRA = 'Délai';
        }
        modify("Destination Type")
        {
            CaptionML = ENU = 'Destination Type', FRA = 'Type destination';
           // OptionCaptionML = ENU = ' ,Customer,Vendor,Location,Item,Family,Sales Order', FRA = ' ,Client,Fournisseur,Magasin,Article,Famille,Commande vente';
        }
        modify("Destination No.")
        {

            //Unsupported feature: Change TableRelation on ""Destination No."(Field 40)". Please convert manually.

            CaptionML = ENU = 'Destination No.', FRA = 'N° destination';
        }
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Shipping Agent Code', FRA = 'Code transporteur';
        }
        modify("Shipping Agent Service Code")
        {

            //Unsupported feature: Change TableRelation on ""Shipping Agent Service Code"(Field 43)". Please convert manually.

            CaptionML = ENU = 'Shipping Agent Service Code', FRA = 'Code prestation transporteur';
        }
        modify("Shipment Method Code")
        {
            CaptionML = ENU = 'Shipment Method Code', FRA = 'Code condition livraison';
        }
        modify("Starting Date")
        {
            CaptionML = ENU = 'Starting Date', FRA = 'Date début';
        }
        modify("Assemble to Order")
        {
            CaptionML = ENU = 'Assemble to Order', FRA = 'Assemblage à la commande';
        }
        modify("ATO Component")
        {
            CaptionML = ENU = 'ATO Component', FRA = 'Composant ATO';
        }
        modify("Serial No.")
        {
            CaptionML = ENU = 'Serial No.', FRA = 'N° de série';
        }
        modify("Lot No.")
        {
            CaptionML = ENU = 'Lot No.', FRA = 'N° lot';
            // BC UPGRADE PATHAA02>>
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.04>>
                IF "Lot No." <> '' THEN
                    // ExpDate := ItemTrackingMgt.ExistingExpirationDate(Rec."Item No.", Rec."Variant Code", Rec."Lot No.", Rec."Serial No.", FALSE, EntriesExist) //BC Upgrade PATHAA02-commented-error
                    ExpDate := ItemTrackingMgt.ExistingExpirationDate(Rec, FALSE, EntriesExist) //BC Upgrade PATHAA02-mapped tp function with this table as parameter-->searching for ile exp date.        
                else
                    "Expiration Date" := 0D;

                IF ExpDate <> 0D THEN
                    "Expiration Date" := ExpDate;
                //HEI.04<<                
            end;
            //BC UPGRADE PATHAA02<<

            /*        
        -----------------------------------------------------------------------------------------------------------
            procedure ExistingExpirationDate(WarehouseActivityLine: Record "Warehouse Activity Line"; TestMultiple: Boolean; var EntriesExist: Boolean) ExpiryDate: Date
            var
                ItemTrackingSetup: Record "Item Tracking Setup";
            begin
                ItemTrackingSetup.CopyTrackingFromWhseActivityLine(WarehouseActivityLine);
                exit(
                    ExistingExpirationDate(
                        WarehouseActivityLine."Item No.", WarehouseActivityLine."Variant Code", ItemTrackingSetup, TestMultiple, EntriesExist));
            end;
            */
        }
        modify("Warranty Date")
        {
            CaptionML = ENU = 'Warranty Date', FRA = 'Date garantie';
        }
        modify("Expiration Date")
        {
            CaptionML = ENU = 'Expiration Date', FRA = 'Date d''expiration';
        }
        modify("Serial No. Blocked")
        {

            //Unsupported feature: Change CalcFormula on ""Serial No. Blocked"(Field 6504)". Please convert manually.

            CaptionML = ENU = 'Serial No. Blocked', FRA = 'N° de série bloqué';
        }
        modify("Lot No. Blocked")
        {

            //Unsupported feature: Change CalcFormula on ""Lot No. Blocked"(Field 6505)". Please convert manually.

            CaptionML = ENU = 'Lot No. Blocked', FRA = 'N° lot bloqué';
        }
        modify("Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""Bin Code"(Field 7300)". Please convert manually.

            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement';
        }
        modify("Zone Code")
        {
            CaptionML = ENU = 'Zone Code', FRA = 'Code zone';
            //BC UPGRADE PATHAA02>>
            trigger OnAfterValidate()
            begin
                Hooks.OnAfterValidateWhseActivityLineZoneCode(Rec, xRec, CurrFieldNo);//HEI.01 PRDGAP024
            end;
            //BC UPGRADE PATHAA02<<
        }
        modify("Action Type")
        {
            CaptionML = ENU = 'Action Type', FRA = 'Type action';
           // OptionCaptionML = ENU = ' ,Take,Place', FRA = ' ,Prélever,Ranger';
        }
        modify("Whse. Document Type")
        {
            CaptionML = ENU = 'Whse. Document Type', FRA = 'Type document entrepôt';
           // OptionCaptionML = ENU = ' ,Receipt,Shipment,Internal Put-away,Internal Pick,Production,Movement Worksheet,,Assembly', FRA = ' ,Réception,Expédition,Rangement interne,Prélèvement interne,Production,Feuille mouvement,,Assemblage';
        }
        modify("Whse. Document No.")
        {

            //Unsupported feature: Change TableRelation on ""Whse. Document No."(Field 7307)". Please convert manually.

            CaptionML = ENU = 'Whse. Document No.', FRA = 'N° document entrepôt';
        }
        modify("Whse. Document Line No.")
        {

            //Unsupported feature: Change TableRelation on ""Whse. Document Line No."(Field 7308)". Please convert manually.

            CaptionML = ENU = 'Whse. Document Line No.', FRA = 'N° ligne document entrep.';
        }
        modify("Bin Ranking")
        {
            CaptionML = ENU = 'Bin Ranking', FRA = 'Priorité emplacement';
        }
        modify(Cubage)
        {
            CaptionML = ENU = 'Cubage', FRA = 'Cubage';
        }
        modify(Weight)
        {
            CaptionML = ENU = 'Weight', FRA = 'Poids';
        }
        modify("Special Equipment Code")
        {
            CaptionML = ENU = 'Special Equipment Code', FRA = 'Code équipement spécial';
        }
        modify("Bin Type Code")
        {
            CaptionML = ENU = 'Bin Type Code', FRA = 'Code type emplacement';
        }
        modify("Breakbulk No.")
        {
            CaptionML = ENU = 'Breakbulk No.', FRA = 'N° déconditionnement';
        }
        modify("Original Breakbulk")
        {
            CaptionML = ENU = 'Original Breakbulk', FRA = 'Déconditionnement initial';
        }
        modify(Breakbulk)
        {
            CaptionML = ENU = 'Breakbulk', FRA = 'Déconditionnement';
        }
        modify("Cross-Dock Information")
        {
            CaptionML = ENU = 'Cross-Dock Information', FRA = 'Informations transbordement';
            OptionCaptionML = ENU = ' ,Cross-Dock Items,Some Items Cross-Docked', FRA = ' ,Transbordement articles,Quelques articles transbordés';
        }
        modify(Dedicated)
        {
            CaptionML = ENU = 'Dedicated', FRA = 'Dédié';
        }

        //Unsupported feature: CodeModification on ""Item No."(Field 14).OnValidate". Please convert manually.

        //trigger "(Field 14)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Item No." <> xRec."Item No." THEN
          "Variant Code" := '';

        IF "Item No." <> '' THEN BEGIN
          GetItemUnitOfMeasure;
          Description := Item.Description;
          "Description 2" := Item."Description 2";
          VALIDATE("Unit of Measure Code",ItemUnitOfMeasure.Code);
        end else BEGIN
          Description := '';
          "Description 2" := '';
          "Variant Code" := '';
          VALIDATE("Unit of Measure Code",'');
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Item No." <> xRec."Item No." then
          "Variant Code" := '';

        if "Item No." <> '' then begin
        #5..8
        end else begin
        #10..13
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Variant Code"(Field 15).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Variant Code" = '' THEN
          VALIDATE("Item No.")
        else BEGIN
          ItemVariant.GET("Item No.","Variant Code");
          Description := ItemVariant.Description;
          "Description 2" := ItemVariant."Description 2";
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Variant Code" = '' then
          VALIDATE("Item No.")
        else begin
        #4..6
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit of Measure Code"(Field 16).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Item No." <> '' THEN BEGIN
          GetItemUnitOfMeasure;
          "Qty. per Unit of Measure" := ItemUnitOfMeasure."Qty. per Unit of Measure";
        end else
          "Qty. per Unit of Measure" := 1;

        VALIDATE(Quantity);
        VALIDATE("Qty. Outstanding");
        VALIDATE("Qty. to Handle");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Item No." <> '' then begin
          GetItemUnitOfMeasure;
          "Qty. per Unit of Measure" := ItemUnitOfMeasure."Qty. per Unit of Measure";
        end else
        #5..9
        */
        //end;


        //Unsupported feature: CodeModification on ""Qty. to Handle"(Field 26).OnValidate". Please convert manually.

        //trigger  to Handle"(Field 26)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Qty. to Handle" > "Qty. Outstanding" THEN
          ERROR(
            Text002,
            "Qty. Outstanding");

        GetLocation("Location Code");
        IF Location."Directed Put-away and Pick" THEN
          WMSMgt.CalcCubageAndWeight(
            "Item No.","Unit of Measure Code","Qty. to Handle",Cubage,Weight);

        IF (CurrFieldNo <> 0) AND
           ("Action Type" = "Action Type"::Place) AND
           ("Breakbulk No." = 0) AND
           ("Qty. to Handle" > 0) AND
           Location."Directed Put-away and Pick"
        THEN
          IF GetBin("Location Code","Bin Code") THEN
            CheckIncreaseCapacity(TRUE);

        IF NOT UseBaseQty THEN BEGIN
          "Qty. to Handle (Base)" := CalcBaseQty("Qty. to Handle");
          IF "Qty. to Handle (Base)" > "Qty. Outstanding (Base)" THEN // rounding error- qty same, not base qty
            "Qty. to Handle (Base)" := "Qty. Outstanding (Base)";
        end;

        IF ("Activity Type" = "Activity Type"::"Put-away") AND
           ("Action Type" = "Action Type"::Take) AND
           (CurrFieldNo <> 0)
        THEN
          IF ("Breakbulk No." <> 0) OR "Original Breakbulk" THEN
            UpdateBreakbulkQtytoHandle;

        IF ("Activity Type" IN ["Activity Type"::Pick,"Activity Type"::"Invt. Pick"]) AND
           ("Action Type" <> "Action Type"::Place) AND ("Lot No." <> '') AND (CurrFieldNo <> 0)
        THEN
          CheckReservedItemTrkg(1,"Lot No.");

        IF ("Qty. to Handle" = 0) AND RegisteredWhseActLineIsEmpty THEN
          UpdateReservation(Rec,FALSE)
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Qty. to Handle" > "Qty. Outstanding" then
        #2..6
        // <<DITW15.00.00.21 DDR 20/06/2008
        //IF Location."Directed Put-away and Pick" THEN
        if Location."Directed Put-away and Pick" or Location."Allow Calculate Weight Cubage" then
        // >>DITW15.00.00.21 DDR 20/06/2008
        #8..10
        if (CurrFieldNo <> 0) and
           ("Action Type" = "Action Type"::Place) and
           ("Breakbulk No." = 0) and
           ("Qty. to Handle" > 0) and
           Location."Directed Put-away and Pick"
        then
          if GetBin("Location Code","Bin Code") then
            CheckIncreaseCapacity(true);

        if not UseBaseQty then begin
          "Qty. to Handle (Base)" := CalcBaseQty("Qty. to Handle");
          if "Qty. to Handle (Base)" > "Qty. Outstanding (Base)" then // rounding error- qty same, not base qty
            "Qty. to Handle (Base)" := "Qty. Outstanding (Base)";
        end;

        if ("Activity Type" = "Activity Type"::"Put-away") and
           ("Action Type" = "Action Type"::Take) and
           (CurrFieldNo <> 0)
        then
          if ("Breakbulk No." <> 0) or "Original Breakbulk" then
            UpdateBreakbulkQtytoHandle;

        if ("Activity Type" in ["Activity Type"::Pick,"Activity Type"::"Invt. Pick"]) and
           ("Action Type" <> "Action Type"::Place) and ("Lot No." <> '') and (CurrFieldNo <> 0)
        then
          CheckReservedItemTrkg(1,"Lot No.");

        if ("Qty. to Handle" = 0) and RegisteredWhseActLineIsEmpty then
          UpdateReservation(Rec,false);

        // <<DITW16.00.00.40 DDR 02/03/2012 DIT-715 #274
        if ("Activity Type" in ["Activity Type"::Pick,"Activity Type"::"Invt. Pick"]) and
           ("Action Type" <> "Action Type"::Place) and ("SSCC No." <> '') and (CurrFieldNo <> 0)
        then
          CheckReservedSSCCTrkg("SSCC No.","Lot No.");
        // >>DITW16.00.00.40 DDR DIT-715 #274
        */
        //end;


        //Unsupported feature: CodeModification on ""Qty. to Handle (Base)"(Field 27).OnValidate". Please convert manually.

        //trigger  to Handle (Base)"(Field 27)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UseBaseQty := TRUE;
        VALIDATE("Qty. to Handle",CalcQty("Qty. to Handle (Base)"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UseBaseQty := true;
        VALIDATE("Qty. to Handle",CalcQty("Qty. to Handle (Base)"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Serial No."(Field 6500).OnLookup". Please convert manually.

        //trigger "(Field 6500)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        LookUpBinContent := ("Activity Type" <= "Activity Type"::Movement) OR ("Action Type" <> "Action Type"::Place);
        LookUpTrackingSummary(Rec,LookUpBinContent,-1,0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        LookUpBinContent := ("Activity Type" <= "Activity Type"::Movement) or ("Action Type" <> "Action Type"::Place);
        LookUpTrackingSummary(Rec,LookUpBinContent,-1,0);
        */
        //end;


        //Unsupported feature: CodeModification on ""Serial No."(Field 6500).OnValidate". Please convert manually.

        //trigger "(Field 6500)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Serial No." <> '' THEN BEGIN
          ItemTrackingMgt.CheckWhseItemTrkgSetup("Item No.",SNRequired,LNRequired,TRUE);
          TESTFIELD("Qty. per Unit of Measure",1);

          IF "Activity Type" IN ["Activity Type"::Pick,"Activity Type"::"Invt. Pick"] THEN
            CheckReservedItemTrkg(0,"Serial No.");

          CheckSNSpecificationExists;

          IF SNRequired AND LNRequired THEN
            FindLotNoBySerialNo;
        end;

        IF "Serial No." <> xRec."Serial No." THEN
          "Expiration Date" := 0D;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Serial No." <> '' then begin
          ItemTrackingMgt.CheckWhseItemTrkgSetup("Item No.",SNRequired,LNRequired,true);
          TESTFIELD("Qty. per Unit of Measure",1);

          if "Activity Type" in ["Activity Type"::Pick,"Activity Type"::"Invt. Pick"] then
        #6..9
          if SNRequired and LNRequired then
            FindLotNoBySerialNo;
        end;

        if "Serial No." <> xRec."Serial No." then begin
          "Expiration Date" := 0D;
          // <<DITW16.00.00.40 DDR 02/03/2012 DIT-715 #274
          "SSCC No." := '';
          // >>DITW16.00.00.40 DDR DIT-715 #274
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Lot No."(Field 6501).OnLookup". Please convert manually.

        //trigger "(Field 6501)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        LookUpBinContent := ("Activity Type" <= "Activity Type"::Movement) OR ("Action Type" <> "Action Type"::Place);
        LookUpTrackingSummary(Rec,LookUpBinContent,-1,1);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        LookUpBinContent := ("Activity Type" <= "Activity Type"::Movement) or ("Action Type" <> "Action Type"::Place);
        LookUpTrackingSummary(Rec,LookUpBinContent,-1,1);
        */
        //end;


        //Unsupported feature: CodeModification on ""Lot No."(Field 6501).OnValidate". Please convert manually.

        //trigger "(Field 6501)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Lot No." <> '' THEN BEGIN
          ItemTrackingMgt.CheckWhseItemTrkgSetup("Item No.",SNRequired,LNRequired,TRUE);

          IF "Activity Type" IN ["Activity Type"::Pick,"Activity Type"::"Invt. Pick"] THEN
            CheckReservedItemTrkg(1,"Lot No.");
        end;

        IF "Lot No." <> xRec."Lot No." THEN
          "Expiration Date" := 0D;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Lot No." <> '' then begin
          ItemTrackingMgt.CheckWhseItemTrkgSetup("Item No.",SNRequired,LNRequired,true);

          if "Activity Type" in ["Activity Type"::Pick,"Activity Type"::"Invt. Pick"] then
            CheckReservedItemTrkg(1,"Lot No.");
        end;

        if "Lot No." <> xRec."Lot No." then begin
          "Expiration Date" := 0D;
          // <<DITW16.00.00.40 DDR 02/03/2012 DIT-715 #274
          if (xRec."Lot No." <> '') or
            ((CurrFieldNo <> FIELDNO("SSCC No.")) and (CurrFieldNo <> 0))
          then
            "SSCC No." := '';
          // >>DITW16.00.00.40 DDR DIT-715 #274
        end;
        //HEI.04>>
        if "Lot No." <> '' then
          ExpDate := ItemTrackingMgt.ExistingExpirationDate("Item No.","Variant Code","Lot No.","Serial No.",false,EntriesExist)
        else
          "Expiration Date" := 0D;

        if ExpDate <> 0D then
          "Expiration Date" := ExpDate;
        //HEI.04<<b
        */
        //end;


        //Unsupported feature: CodeModification on ""Expiration Date"(Field 6503).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Lot No." <> '' THEN
          WITH WhseActivLine DO BEGIN
            RESET;
            SETCURRENTKEY("No.","Line No.","Activity Type");
            SETRANGE("No.",Rec."No.");
            SETRANGE("Item No.",Rec."Item No.");
            SETRANGE("Lot No.",Rec."Lot No.");

            IF FINDSET THEN
              REPEAT
                IF ("Line No." <> Rec."Line No.") AND ("Expiration Date" <> Rec."Expiration Date") AND
                   (Rec."Expiration Date" <> 0D) AND ("Expiration Date" <> 0D)
                THEN
                  Rec.FIELDERROR("Expiration Date");
              UNTIL NEXT = 0;
          end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Lot No." <> '' then
          with WhseActivLine do begin
        #3..8
            if FINDSET then
              repeat
                if ("Line No." <> Rec."Line No.") and ("Expiration Date" <> Rec."Expiration Date") and
                   (Rec."Expiration Date" <> 0D) and ("Expiration Date" <> 0D)
                then
                  Rec.FIELDERROR("Expiration Date");
              until NEXT = 0;
          end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Bin Code"(Field 7300).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Action Type" = "Action Type"::Take THEN
          BinCode := WMSMgt.BinContentLookUp2("Location Code","Item No.","Variant Code","Zone Code","Lot No.","Serial No.","Bin Code")
        else
          BinCode := WMSMgt.BinLookUp("Location Code","Item No.","Variant Code","Zone Code");

        IF BinCode <> '' THEN BEGIN
          VALIDATE("Bin Code",BinCode);
          MODIFY;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Action Type" = "Action Type"::Take then
          BinCode := WMSMgt.BinContentLookUp2("Location Code","Item No.","Variant Code","Zone Code","Lot No.","Serial No.","Bin Code")
        else
          BinCode := WMSMgt.BinLookUp("Location Code","Item No.","Variant Code","Zone Code");

        if BinCode <> '' then begin
          VALIDATE("Bin Code",BinCode);
          MODIFY;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Bin Code"(Field 7300).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckBinInSourceDoc;

        IF "Bin Code" <> '' THEN
          IF NOT "Assemble to Order" AND ("Action Type" = "Action Type"::Take) THEN
            WMSMgt.FindBinContent("Location Code","Bin Code","Item No.","Variant Code","Zone Code")
          else
            WMSMgt.FindBin("Location Code","Bin Code","Zone Code");

        IF "Bin Code" <> xRec."Bin Code" THEN BEGIN
          CheckInvalidBinCode;
          IF GetBin("Location Code","Bin Code") THEN BEGIN
            IF CurrFieldNo <> 0 THEN BEGIN
              IF ("Activity Type" = "Activity Type"::"Put-away") AND
                 ("Breakbulk No." <> 0)
              THEN
                ERROR(Text005,FIELDCAPTION("Bin Code"));
              CheckWhseDocLine;
              IF "Action Type" = "Action Type"::Take THEN BEGIN
                IF (("Whse. Document Type" <> "Whse. Document Type"::Receipt) AND
                    (Bin."Bin Type Code" <> ''))
                THEN
                  IF BinType.GET(Bin."Bin Type Code") THEN
                    BinType.TESTFIELD(Receive,FALSE);
                GetLocation("Location Code");
                IF Location."Directed Put-away and Pick" THEN BEGIN
                  UOMCode := "Unit of Measure Code";
                  QtyOutstanding := "Qty. Outstanding";
                end else BEGIN
                  UOMCode := WMSMgt.GetBaseUOM("Item No.");
                  QtyOutstanding := "Qty. Outstanding (Base)";
                end;
                NewBinCode := "Bin Code";
                IF BinContent.GET("Location Code","Bin Code","Item No.","Variant Code",UOMCode) THEN BEGIN
                  IF "Activity Type" IN ["Activity Type"::Pick,"Activity Type"::"Invt. Pick","Activity Type"::"Invt. Movement"] THEN
                    QtyAvail := BinContent.CalcQtyAvailToPick(0)
                  else
                    QtyAvail := BinContent.CalcQtyAvailToTake(0);
                  IF Location."Directed Put-away and Pick" THEN BEGIN
                    CreatePick.SetCrossDock(Bin."Cross-Dock Bin");
                    AvailableQty :=
                      CreatePick.CalcTotalAvailQtyToPick(
                        "Location Code","Item No.","Variant Code","Lot No.","Serial No.",
                        "Source Type","Source Subtype","Source No.","Source Line No.","Source Subline No.",0,FALSE);
                    AvailableQty := AvailableQty + "Qty. Outstanding (Base)";
                    IF AvailableQty < 0 THEN
                      AvailableQty := 0;

                    IF AvailableQty = 0 THEN
                      ERROR(Text015);
                  end else
                    AvailableQty := QtyAvail;

                  IF AvailableQty < QtyAvail THEN
                    QtyAvail := AvailableQty;

                  IF (QtyAvail < QtyOutstanding) AND NOT "Assemble to Order" THEN BEGIN
                    IF NOT
                       CONFIRM(
                         STRSUBSTNO(
                           Text012,
                           FIELDCAPTION("Qty. Outstanding"),QtyOutstanding,
                           QtyAvail,BinContent.TABLECAPTION,FIELDCAPTION("Bin Code")),
                         FALSE)
                    THEN
                      ERROR(Text006);

                    "Bin Code" := NewBinCode;
                    MODIFY;
                  end;
                end else BEGIN
                  IF NOT "Assemble to Order" THEN
                    IF NOT
                       CONFIRM(
                         STRSUBSTNO(
                           Text012,
                           FIELDCAPTION("Qty. Outstanding"),QtyOutstanding,
                           QtyAvail,BinContent.TABLECAPTION,FIELDCAPTION("Bin Code")),
                         FALSE)
                    THEN
                      ERROR(Text006);

                  "Bin Code" := NewBinCode;
                  MODIFY;
                end;
              end else BEGIN
                IF "Qty. to Handle" > 0 THEN
                  CheckIncreaseCapacity(FALSE);
                DeleteBinContent(xRec);
              end;
            end;
            Dedicated := Bin.Dedicated;
            IF Location."Directed Put-away and Pick" THEN BEGIN
              "Bin Ranking" := Bin."Bin Ranking";
              "Bin Type Code" := Bin."Bin Type Code";
              "Zone Code" := Bin."Zone Code";
            end;
          end else BEGIN
            Dedicated := FALSE;
            "Bin Ranking" := 0;
            "Bin Type Code" := '';
          end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckBinInSourceDoc;

        if "Bin Code" <> '' then
          if not "Assemble to Order" and ("Action Type" = "Action Type"::Take) then
            WMSMgt.FindBinContent("Location Code","Bin Code","Item No.","Variant Code","Zone Code")
          else
            WMSMgt.FindBin("Location Code","Bin Code","Zone Code");

        if "Bin Code" <> xRec."Bin Code" then begin
          if not "Zone-Transfer" then//HEI.01 PRDGAP024>>
          CheckInvalidBinCode;
          if GetBin("Location Code","Bin Code") then begin
            if CurrFieldNo <> 0 then begin
              if ("Activity Type" = "Activity Type"::"Put-away") and
                 ("Breakbulk No." <> 0)
              then
                ERROR(Text005,FIELDCAPTION("Bin Code"));
              CheckWhseDocLine;
              if "Action Type" = "Action Type"::Take then begin
                if (("Whse. Document Type" <> "Whse. Document Type"::Receipt) and
                    (Bin."Bin Type Code" <> ''))
                then
                  if BinType.GET(Bin."Bin Type Code") then
                    BinType.TESTFIELD(Receive,false);
                GetLocation("Location Code");
                if Location."Directed Put-away and Pick" then begin
                  UOMCode := "Unit of Measure Code";
                  QtyOutstanding := "Qty. Outstanding";
                end else begin
                  UOMCode := WMSMgt.GetBaseUOM("Item No.");
                  QtyOutstanding := "Qty. Outstanding (Base)";
                end;
                NewBinCode := "Bin Code";
                if BinContent.GET("Location Code","Bin Code","Item No.","Variant Code",UOMCode) then begin
                  if "Activity Type" in ["Activity Type"::Pick,"Activity Type"::"Invt. Pick","Activity Type"::"Invt. Movement"] then
                    QtyAvail := BinContent.CalcQtyAvailToPick(0)
                  else
                    QtyAvail := BinContent.CalcQtyAvailToTake(0);
                  if Location."Directed Put-away and Pick" then begin
        #39..42
                        "Source Type","Source Subtype","Source No.","Source Line No.","Source Subline No.",0,false);
                    AvailableQty := AvailableQty + "Qty. Outstanding (Base)";
                    if AvailableQty < 0 then
                      AvailableQty := 0;

                    if AvailableQty = 0 then
                      ERROR(Text015);
                  end else
                    AvailableQty := QtyAvail;

                  if AvailableQty < QtyAvail then
                    QtyAvail := AvailableQty;

                  if (QtyAvail < QtyOutstanding) and not "Assemble to Order" then begin
                    if not
        #58..62
                         false)
                    then
        #65..68
                  end;
                end else begin
                  if not "Assemble to Order" then
                    if not
        #73..77
                         false)
                    then
        #80..83
                end;
              end else begin
                if "Qty. to Handle" > 0 then
                  CheckIncreaseCapacity(false);
                DeleteBinContent(xRec);
              end;
            end;
            Dedicated := Bin.Dedicated;
            if Location."Directed Put-away and Pick" then begin
        #93..95
            end;
          end else begin
            Dedicated := false;
            "Bin Ranking" := 0;
            "Bin Type Code" := '';
          end;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Zone Code"(Field 7301).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec."Zone Code" <> "Zone Code" THEN BEGIN
          GetLocation("Location Code");
          Location.TESTFIELD("Directed Put-away and Pick");
          IF "Action Type" = "Action Type"::Place THEN
            DeleteBinContent(xRec);
          "Bin Code" := '';
          "Bin Ranking" := 0;
          "Bin Type Code" := '';
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec."Zone Code" <> "Zone Code" then begin
          GetLocation("Location Code");
          //HEI.01 PRDGAP024 delete Location.TESTFIELD("Directed Put-away and Pick");
          if "Action Type" = "Action Type"::Place then
        #5..8
        end;
        Hooks.OnAfterValidateWhseActivityLineZoneCode(Rec,xRec,CurrFieldNo);//HEI.01 PRDGAP024
        */
        //end;
        field(50000; "Linked To Line No. FND"; Integer)
        {
            caption = 'Linked To Line No.';
            Description = 'PRDGAP024';
            Editable = false;
            TableRelation = "Warehouse Activity Line" where("Activity Type" = FIELD("Activity Type"),
                                                             "No." = FIELD("No."),
                                                             "Linked To Line No. FND" = FIELD("Line No."));
        }
        field(50001; "In-Transit Zone Code FND"; Code[10])
        {
            caption = 'In-Transit Zone Code';
            Description = 'PRDGAP024';
            Editable = false;
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"));
        }
        field(50002; "In-Transit Bin Code FND"; Code[20])
        {
            caption = 'In-Transit Bin Code';
            Description = 'PRDGAP024';
            Editable = false;
        }
        field(50003; "Zone-Transfer FND"; Boolean)
        {
            caption = 'Zone-Transfer';
            Description = 'PRDGAP024';
            Editable = false;
        }
        field(50004; "Quantity Shipped FND"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantity Shipped';
            DecimalPlaces = 0 : 5;
            Description = 'PRDGAP024';
            Editable = false;
        }
        field(50005; "Quantity Received FND"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantity Received';
            DecimalPlaces = 0 : 5;
            Description = 'PRDGAP024';
            Editable = false;
        }

        //BC Upgrade PATHAA02>> DIT
        // field(2014495;"Delivery Sequence";Integer)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU='Delivery Sequence',
        //                 FRA='Séquence de livraison';
        //     Description = 'DITW16.00.00.40 #1002';
        //     MinValue = 0;
        // }
        // field(2035040;"SSCC No.";Code[50])
        // {
        //     CaptionML = ENU='SSCC No.',
        //                 FRA='N° SSCC';
        //     Description = 'DITW16.00.00.40 DIT-715 #274';

        //     trigger OnLookup();
        //     var
        //         LookUpBinContent : Boolean;
        //     begin
        //         // <<DITW16.00.00.40 DDR 05/03/2012 DIT-715 #274
        //         LookUpBinContent := ("Activity Type" <= "Activity Type"::Movement) or ("Action Type" <> "Action Type"::Place);
        //         SCLookUpTrackingSummary(Rec,LookUpBinContent,-1);
        //     end;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.40 DDR 05/03/2012 DIT-715 #274
        //         if "SSCC No." <> '' then begin
        //           SSCCTrackingMgt.CheckWhseSSCCTrkgSetup("Item No.",SCRequired,SCLNRequired,true);
        //           TESTFIELD("Serial No.",'');

        //           if "Activity Type" in ["Activity Type"::Pick,"Activity Type"::"Invt. Pick"] then
        //             CheckReservedSSCCTrkg("SSCC No.","Lot No.");
        //         end;

        //         //<<DITW18.00.07 MSF 12/05/2016 DIT-770 #1876
        //         if ("SSCC No." <> xRec."SSCC No.") and ("Lot No." = '') and ("Serial No." = '') then
        //         //>>HIT0087.1 DDR DIT-770 #1876
        //           VALIDATE("Lot No.",GetLotNoFromSSCCNo("SSCC No."));

        //         //>>DITW18.00.07 MSF 12/05/2016 DIT-770 #1876
        //     end;
        // }
        //BC Upgrade PATHAA02<< DIT
    }
    keys
    {

        //Unsupported feature: Deletion on ""Whse. Document No.","Whse. Document Type","Activity Type","Whse. Document Line No.","Action Type","Unit of Measure Code","Original Breakbulk","Breakbulk No.","Lot No.","Serial No.","Assemble to Order"(Key)". Please convert manually.

        //BC Upgrade PATHAA02>>-DIT(Delivery Sequence, SSSC no.)
        // key(Key1; "Whse. Document No.", "Whse. Document Type", "Activity Type", "Whse. Document Line No.", "Action Type", "Unit of Measure Code", "Original Breakbulk", "Breakbulk No.", "Lot No.", "Serial No.", "SSCC No.", "Assemble to Order")
        // {
        //     MaintainSIFTIndex = false;
        //     SumIndexFields = "Qty. Outstanding (Base)", "Qty. Outstanding";
        // }

        // key(Key2; "Activity Type", "No.", "Delivery Sequence")
        // {
        // }      

        // key(Key3; "Source No.", "Source Line No.", "Source Subline No.", "SSCC No.", "Lot No.")
        // {
        // }
        //BC Upgrade PATHAA02<<
        key(Key50000; "Activity Type", "No.", "Source No.") //BC Upgrade PATHAA02-Key No. changed
        {
            MaintainSQLIndex = false;
        }

        //BC Upgrade PATHAA02>>-DIT(SSSC no.)
        // key(Key5; "Item No.", "Location Code", "Activity Type", "Bin Type Code", "Unit of Measure Code", "Variant Code", "Breakbulk No.", "Action Type", "Lot No.", "Serial No.", "SSCC No.", "Assemble to Order")
        // {
        //     MaintainSIFTIndex = false;
        //     SumIndexFields = "Qty. Outstanding (Base)";
        // }
        //BC Upgrade PATHAA02<<

        key(Key50001; "Source No.", Description)//HEI.03- BC UPGRADE PATHAA02>>
        {
        }
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DeleteRelatedWhseActivLines(Rec,FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DeleteRelatedWhseActivLines(Rec,false);
    Hooks.CheckEditAllowedWhseActivityLine(Rec);//HEI.01 PRDGAP024
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInsert". Please convert manually.


    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //begin
    /*
    //HEI.01 PRDGAP024>>
    //HEI.05>>
    Hooks.UpdateRelatedActivityLine(Rec);
    Hooks.CheckEditAllowedWhseActivityLine(Rec);
    //HEI.05<<
    //HEI.01 PRDGAP024<<
    */
    //end;

    //Unsupported feature: CodeInsertion on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //begin
    /*
    //HEI.01 PRDGAP024>>
    Hooks.UpdateRelatedActivityLine(Rec);
    //HEI.01 PRDGAP024<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        QtyTransit: Decimal;
        QtyTransitBase: Decimal;

    var
        WhseRequest: Record "Warehouse Request";


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot rename a %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot rename a %1.;FRA=Vous ne pouvez pas renommer l'enregistrement %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=You cannot handle more than the outstanding %1 units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=You cannot handle more than the outstanding %1 units.;FRA=Vous ne pouvez pas traiter plus que les %1 unités restantes.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=must not be %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=must not be %1;FRA=ne doit pas être %1;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=If you delete %1 %2, %3 %4, %5 %6\the quantity to %7 will be imbalanced.\Do you still want to delete the %8?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=If you delete %1 %2, %3 %4, %5 %6\the quantity to %7 will be imbalanced.\Do you still want to delete the %8?;FRA=Si vous supprimez le %1 %2, %3 %4, %5 %6,\la quantité du %7 sera déséquilibrée.\Souhaitez-vous supprimer %8 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1045)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=You must not change the %1 in breakbulk lines.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=You must not change the %1 in breakbulk lines.;FRA=Vous ne devez pas modifier le %1 dans les lignes déconditionnement.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=The update was interrupted to respect the warning.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=The update was interrupted to respect the warning.;FRA=La mise à jour a été interrompue pour respecter l'alerte.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=You must not split breakbulk lines.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=You must not split breakbulk lines.;FRA=Vous ne pouvez pas diviser les lignes déconditionnement.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1022)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=Quantity available to pick is not enough to fill in all the lines.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=Quantity available to pick is not enough to fill in all the lines.;FRA=La quantité disponible pour prélèvement n'est pas suffisante pour renseigner toutes les lignes.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text009(Variable 1023)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU=If you delete the %1\you must recreate related Warehouse Worksheet Lines manually.\\Do you want to delete the %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : ENU=If you delete the %1\you must recreate related Warehouse Worksheet Lines manually.\\Do you want to delete the %1?;FRA=Si vous supprimez l'%1,\vous aurez à recréer manuellement les lignes feuille entrepôt.\\Souhaitez-vous supprimer l'%1 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text011(Variable 1027)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text011 : ENU=You cannot enter the %1 of the %2 as %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text011 : ENU=You cannot enter the %1 of the %2 as %3.;FRA=Vous ne pouvez pas entrer le %1 du %2 comme %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text012(Variable 1028)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text012 : ENU=The %1 %2 exceeds the quantity available to pick %3 of the %4.\Do you still want to enter this %5?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text012 : ENU=The %1 %2 exceeds the quantity available to pick %3 of the %4.\Do you still want to enter this %5?;FRA=La %1 %2 dépasse la quantité disponible pour prélèvement de %3 du %4.\Souhaitez-vous entrer ce %5 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text013(Variable 1029)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text013 : ENU=All related Warehouse Activity Lines are deleted.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text013 : ENU=All related Warehouse Activity Lines are deleted.;FRA=Toutes les lignes activité entrepôt associées ont été supprimées.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text014(Variable 1030)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text014 : ENU=%1 %2 has already been reserved for another document.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text014 : ENU=%1 %2 has already been reserved for another document.;FRA=L'enregistrement %1 %2 a déjà été réservé pour un autre document.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text015(Variable 1031)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text015 : ENU=The total available quantity has already been applied.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text015 : ENU=The total available quantity has already been applied.;FRA=La quantité disponible totale a déjà été lettrée.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text017(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text017 : ENU=%1 %2 is not available in inventory, it has already been reserved for another document, or the quantity available is lower than the quantity to handle specified on the line.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text017 : ENU=%1 %2 is not available in inventory, it has already been reserved for another document, or the quantity available is lower than the quantity to handle specified on the line.;FRA=%1 %2 n'est pas disponible dans le stock, a déjà été réservé(e) pour un autre document ou la quantité disponible est inférieure à la quantité à traiter spécifiée sur la ligne.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text018(Variable 1024)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text018 : @@@=Warehouse Activity Line already exists with Serial No. XXX;ENU=%1 already exists with %2 %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text018 : @@@=Warehouse Activity Line already exists with Serial No. XXX;ENU=%1 already exists with %2 %3.;FRA=La %1 existe déjà pour le %2 %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text019(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text019 : ENU=The %1 bin code must be different from the %2 bin code on location %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text019 : ENU=The %1 bin code must be different from the %2 bin code on location %3.;FRA=Le code emplacement %1 doit être différent du code emplacement %2 sur le magasin %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text020(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text020 : ENU=The %1 bin code must not be the Receipt Bin Code or the Shipment Bin Code that are set up on location %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text020 : ENU=The %1 bin code must not be the Receipt Bin Code or the Shipment Bin Code that are set up on location %2.;FRA=Le code emplacement %1 ne doit pas correspondre au code emplacement réception ou au code emplacement expédition configuré sur le magasin %2.;
    //Variable type has not been exported.

    var
        //BC Upgrade PATHAA02 -DIT>>
        // SSCCTrackingMgt: Codeunit "SSCC Tracking Management"; 
        // SSCCTrackingDataCollection: Codeunit "SSCC Tracking Data Collection";
        //SCRequired: Boolean;
        //SCLNRequired: Boolean;        
        //Text2035040: TextConst ENU = '%1 %2 has already been reserved for another %3 %4.', FRA = '%1 %2 est déjà réservé pour un autre %3 %4.';
        // SCCreatePick: Codeunit "SSCC Create Pick"; 
        //Text2035041: TextConst ENU = '%1 %2 (%3 %4) is not available on inventory or it has already been reserved for another document.', FRA = '%1 %2 (%3 %4) n''est pas disponible sur inventaire ou il a déjà été réservé pour un autre document.';
        //BC UPGRADE PATHAA02-DIT <<
        WhseActivLine2: Record "Warehouse Activity Line";
        ItemTrackingMgt: Codeunit "Item Tracking Management"; //BC Upgrade PATHAA02
        Hooks: Codeunit "WHS-UTILS";
        EntriesExist: Boolean;
        ExpDate: Date;

    //BC UPGRADE PATHAA02>>   
    // BC Upgrade - RD03 -- Field value updation -- >> 
    trigger OnBeforeInsert()
    begin
        "Zone-Transfer FND" := true;
    end;
    // BC Upgrade - RD03 -- Field value updation -- <<

    trigger OnAfterInsert();
    begin
        //HEI.01 PRDGAP024>>
        //HEI.05>>
        Hooks.UpdateRelatedActivityLine(Rec);
        Hooks.CheckEditAllowedWhseActivityLine(Rec);
        //HEI.05<<
        //HEI.01 PRDGAP024<<        
    end;

    trigger OnAfterModify();
    begin
        //HEI.01 PRDGAP024>>
        Hooks.UpdateRelatedActivityLine(Rec);
        //HEI.01 PRDGAP024<<
    end;

    trigger OnAfterDelete()
    var
        myInt: Integer;
    begin
        Hooks.CheckEditAllowedWhseActivityLine(Rec);//HEI.01 PRDGAP024
    end;


    procedure IsEditable(): Boolean
    begin
        //HEI01<<
        EXIT(Hooks.CheckedWhseActLineAllowedChange(Rec));
        //HEI.01 PRDGAP024<<
    end;

    procedure IsInbound(): Boolean;
    begin
        //HEI.06>>
        EXIT("Qty. (Base)" > 0);
        //HEI.06<<
    end;

    procedure OpenItemTrackingLines()
    var
        HeinekenTableCu: Codeunit "Heineken Table Cu";
        WhseActivityRegisterL: Codeunit "Whse.-Activity-Register";
        myInt: Integer;
    begin
        //HEI.06>>
        TESTFIELD("Location Code");
        TESTFIELD("Item No.");
        TESTFIELD("Zone Code");
        TESTFIELD("Bin Code");
        TESTFIELD(Quantity);
        TESTFIELD("Qty. (Base)");
        TESTFIELD("Unit of Measure Code");
        TESTFIELD("Zone-Transfer FND", TRUE);
        TESTFIELD("Quantity Shipped FND", 0);
        TESTFIELD("Quantity Received FND", 0);
        //WhseActivityRegisterL.CallItemTracking(Rec); //BC UPGRADE PATHAA02-commented
        HeinekenTableCu.CallItemTracking(Rec); //BC UPGRADE PATHAA02      
        //HEI.06<<
    end;
    //BC Upgrade PATHAA02<<

}

