tableextension 50087 StockkeepingUnitExtFND extends "Stockkeeping Unit"
{
    //     HEI.01 FDD–PRDGAP043 IBM LAZARE02 30.06.2017
    //   # New field Plant-Specific Material Status

    // HEI.02 FDD-OTCGAP065 IBM.HORTOC01 11.07.2017
    //   # New Field SKU Type
    // HEI.03 FDD PRDGAP038 IBM COSTES02 07.08.2017 Added new fields : Quantity Quality Hold,Quantity Unrestricted (Pass),Quantity Blocked (Fail)

    // HEI.04 FDD-BPMGAP001_BPMGAP002 IBM HORTOC01 05.09.2017
    //   # New function
    // HEI.05 FDD-KDD0TC001 IBM HORTOC01 26.09.2017
    //   # New fields
    // HEI.06 FDD-KDD0TC001 IBM HORTOC01 02.10.2017
    //   # validate new fields
    // HEI.07 Defect 663 IBM HORTOC01 18.10.2017
    //   # change flowfield formula by adding Lot No <>'' condition
    // HEI.08 FDD–PRDGAP043 IBM LAZARE02 13.12.2017
    //   # Check if item exists before Item.GET
    // HEI.09 FDD-LB IBM NASTAA02 15.10.2018 # Item Availability excluding Blocked Stock
    //   # New Field created: 50010 - Available Inv. (Whse)
    // HEI.10 IBM.AK CHG2056363 23.09.2020
    //  # New Field-Item Category added 50011 added
    // HEI.11 IBM BHATTA09 CHG2123219 21.11.2021
    //  # New Field "CCC Dimension Code" ID- 50012 added

    fields
    {
        modify("Item No.")
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
        }
        modify("Variant Code")
        {

            //Unsupported feature: Change TableRelation on ""Variant Code"(Field 2)". Please convert manually.

            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Location Code")
        {

            //Unsupported feature: Change TableRelation on ""Location Code"(Field 3)". Please convert manually.

            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify(Description)
        {

            //Unsupported feature: Change CalcFormula on "Description(Field 4)". Please convert manually.

            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Description 2")
        {

            //Unsupported feature: Change CalcFormula on ""Description 2"(Field 5)". Please convert manually.

            CaptionML = ENU = 'Description 2', FRA = 'Désignation 2';
        }
        modify("Assembly BOM")
        {

            //Unsupported feature: Change CalcFormula on ""Assembly BOM"(Field 6)". Please convert manually.

            CaptionML = ENU = 'Assembly BOM', FRA = 'Nomenclature d''assemblage';
        }
        modify("Shelf No.")
        {
            CaptionML = ENU = 'Shelf No.', FRA = 'N° emplacement';
        }
        modify("Unit Cost")
        {
            CaptionML = ENU = 'Unit Cost', FRA = 'Coût unitaire';
        }
        modify("Standard Cost")
        {
            CaptionML = ENU = 'Standard Cost', FRA = 'Coût standard';
        }
        modify("Last Direct Cost")
        {
            CaptionML = ENU = 'Last Direct Cost', FRA = 'Dernier coût direct';
        }
        modify("Vendor No.")
        {
            CaptionML = ENU = 'Vendor No.', FRA = 'N° fournisseur';
        }
        modify("Vendor Item No.")
        {
            CaptionML = ENU = 'Vendor Item No.', FRA = 'Référence fournisseur';
        }
        modify("Lead Time Calculation")
        {
            CaptionML = ENU = 'Lead Time Calculation', FRA = 'Délai de réappro.';
        }
        modify("Reorder Point")
        {
            CaptionML = ENU = 'Reorder Point', FRA = 'Point de commande';
        }
        modify("Maximum Inventory")
        {
            CaptionML = ENU = 'Maximum Inventory', FRA = 'Stock maximum';
        }
        modify("Reorder Quantity")
        {
            CaptionML = ENU = 'Reorder Quantity', FRA = 'Quantité de réappro.';
        }
        modify(Comment)
        {

            //Unsupported feature: Change CalcFormula on "Comment(Field 53)". Please convert manually.

            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify("Last Date Modified")
        {
            CaptionML = ENU = 'Last Date Modified', FRA = 'Date dern. modification';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify("Global Dimension 1 Filter")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Filter"(Field 65)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Filter', FRA = 'Filtre axe principal 1';
        }
        modify("Global Dimension 2 Filter")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Filter"(Field 66)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Filter', FRA = 'Filtre axe principal 2';
        }
        modify(Inventory)
        {

            //Unsupported feature: Change CalcFormula on "Inventory(Field 68)". Please convert manually.

            CaptionML = ENU = 'Inventory', FRA = 'Stocks';
        }
        modify("Qty. on Purch. Order")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Purch. Order"(Field 84)". Please convert manually.

            CaptionML = ENU = 'Qty. on Purch. Order', FRA = 'Qté sur commande achat';
        }
        modify("Qty. on Sales Order")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Sales Order"(Field 85)". Please convert manually.

            CaptionML = ENU = 'Qty. on Sales Order', FRA = 'Qté sur commande vente';
        }
        modify("Drop Shipment Filter")
        {
            CaptionML = ENU = 'Drop Shipment Filter', FRA = 'Filtre livraison directe';
        }
        modify("Assembly Policy")
        {
            CaptionML = ENU = 'Assembly Policy', FRA = 'Politique d''assemblage';
            //OptionCaptionML = ENU = 'Assemble-to-Stock,Assemble-to-Order', FRA = 'Assemblage avant entreposage,Assemblage à la commande';
        }
        modify("Qty. on Assembly Order")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Assembly Order"(Field 977)". Please convert manually.

            CaptionML = ENU = 'Qty. on Assembly Order', FRA = 'Qté sur ordre d''assemblage';
        }
        modify("Qty. on Asm. Component")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Asm. Component"(Field 978)". Please convert manually.

            CaptionML = ENU = 'Qty. on Asm. Component', FRA = 'Qté sur composant d''assemblage';
        }
        modify("Qty. on Job Order")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Job Order"(Field 1001)". Please convert manually.

            CaptionML = ENU = 'Qty. on Job Order', FRA = 'Qté sur ordre de travail';
        }
        modify("Transfer-Level Code")
        {
            CaptionML = ENU = 'Transfer-Level Code', FRA = 'Code niveau transfert';
        }
        modify("Lot Size")
        {
            CaptionML = ENU = 'Lot Size', FRA = 'Taille lot';
        }
        modify("Discrete Order Quantity")
        {
            CaptionML = ENU = 'Discrete Order Quantity', FRA = 'Quantité commande discrète';
        }
        modify("Minimum Order Quantity")
        {
            CaptionML = ENU = 'Minimum Order Quantity', FRA = 'Qté minimum commande';
        }
        modify("Maximum Order Quantity")
        {
            CaptionML = ENU = 'Maximum Order Quantity', FRA = 'Qté maximum commande';
        }
        modify("Safety Stock Quantity")
        {
            CaptionML = ENU = 'Safety Stock Quantity', FRA = 'Stock de sécurité';
        }
        modify("Order Multiple")
        {
            CaptionML = ENU = 'Order Multiple', FRA = 'Commandé par';
        }
        modify("Safety Lead Time")
        {
            CaptionML = ENU = 'Safety Lead Time', FRA = 'Délai de sécurité';
        }
        modify("Components at Location")
        {
            CaptionML = ENU = 'Components at Location', FRA = 'Mag. composant par déf.';
        }
        modify("Flushing Method")
        {
            CaptionML = ENU = 'Flushing Method', FRA = 'Méthode consommation';
            //OptionCaptionML = ENU = 'Manual,Forward,Backward,Pick + Forward,Pick + Backward', FRA = 'Manuelle,Pré-déduction,Post-déduction,Prélèvement + Pré-déduction,Prélèvement + Post-déduction';
        }
        modify("Replenishment System")
        {
            CaptionML = ENU = 'Replenishment System', FRA = 'Système réappro.';
            //OptionCaptionML = ENU = 'Purchase,Prod. Order,Transfer,Assembly', FRA = 'Achat,O.F.,Transfert,Assemblage';
        }
        modify("Scheduled Receipt (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Scheduled Receipt (Qty.)"(Field 5420)". Please convert manually.

            CaptionML = ENU = 'Scheduled Receipt (Qty.)', FRA = 'Réception planifiée (qté)';
        }
        // modify("Scheduled Need (Qty.)") //BC Version 28.0 Compatibility Fix
        // {

        //     //Unsupported feature: Change CalcFormula on ""Scheduled Need (Qty.)"(Field 5421)". Please convert manually.

        //     CaptionML = ENU = 'Scheduled Need (Qty.)', FRA = 'Besoin planifié (qté)';
        // }
        modify("Bin Filter")
        {

            //Unsupported feature: Change TableRelation on ""Bin Filter"(Field 5423)". Please convert manually.

            CaptionML = ENU = 'Bin Filter', FRA = 'Filtre emplacement';
        }
        modify("Time Bucket")
        {
            CaptionML = ENU = 'Time Bucket', FRA = 'Période de vérification';
        }
        modify("Reordering Policy")
        {
            CaptionML = ENU = 'Reordering Policy', FRA = 'Méthode réapprovisionnement';
            // OptionCaptionML = ENU = ' ,Fixed Reorder Qty.,Maximum Qty.,Order,Lot-for-Lot', FRA = ' ,Qté fixe de commande,Qté maximum,Commande,Lot pour lot';
        }
        modify("Include Inventory")
        {
            CaptionML = ENU = 'Include Inventory', FRA = 'Inclure stock';
        }
        modify("Manufacturing Policy")
        {
            CaptionML = ENU = 'Manufacturing Policy', FRA = 'Mode de lancement';
            // OptionCaptionML = ENU = 'Make-to-Stock,Make-to-Order', FRA = 'Fabrication sur stock,Fabrication à la commande';
        }
        modify("Rescheduling Period")
        {
            CaptionML = ENU = 'Rescheduling Period', FRA = 'Période de replanification';
        }
        modify("Lot Accumulation Period")
        {
            CaptionML = ENU = 'Lot Accumulation Period', FRA = 'Période de regroupement de lots';
        }
        modify("Dampener Period")
        {
            CaptionML = ENU = 'Dampener Period', FRA = 'Période seuil';
        }
        modify("Dampener Quantity")
        {
            CaptionML = ENU = 'Dampener Quantity', FRA = 'Quantité tampon';
        }
        modify("Overflow Level")
        {
            CaptionML = ENU = 'Overflow Level', FRA = 'Niveau de dépassement de capacité';
        }
        modify("Transfer-from Code")
        {

            //Unsupported feature: Change TableRelation on ""Transfer-from Code"(Field 5700)". Please convert manually.

            CaptionML = ENU = 'Transfer-from Code', FRA = 'Code prov. transfert';
        }
        modify("Qty. in Transit")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. in Transit"(Field 5701)". Please convert manually.

            CaptionML = ENU = 'Qty. in Transit', FRA = 'Qté en transit';
        }
        modify("Trans. Ord. Receipt (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Trans. Ord. Receipt (Qty.)"(Field 5702)". Please convert manually.

            CaptionML = ENU = 'Trans. Ord. Receipt (Qty.)', FRA = 'Réception transfert (qté)';
        }
        modify("Trans. Ord. Shipment (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Trans. Ord. Shipment (Qty.)"(Field 5703)". Please convert manually.

            CaptionML = ENU = 'Trans. Ord. Shipment (Qty.)', FRA = 'Expédition transfert (qté)';
        }
        modify("Qty. on Service Order")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Service Order"(Field 5901)". Please convert manually.

            CaptionML = ENU = 'Qty. on Service Order', FRA = 'Qté sur commande service';
        }
        modify("Special Equipment Code")
        {
            CaptionML = ENU = 'Special Equipment Code', FRA = 'Code équipement spécial';
        }
        modify("Put-away Template Code")
        {
            CaptionML = ENU = 'Put-away Template Code', FRA = 'Code modèle rangement';
        }
        modify("Put-away Unit of Measure Code")
        {

            //Unsupported feature: Change TableRelation on ""Put-away Unit of Measure Code"(Field 7307)". Please convert manually.

            CaptionML = ENU = 'Put-away Unit of Measure Code', FRA = 'Code unité rangement';
        }
        modify("Phys Invt Counting Period Code")
        {
            CaptionML = ENU = 'Phys Invt Counting Period Code', FRA = 'Code période inventaire stock';
        }
        modify("Last Counting Period Update")
        {
            CaptionML = ENU = 'Last Counting Period Update', FRA = 'Dern. MAJ période d''inventaire';
        }
        modify("Last Phys. Invt. Date")
        {

            //Unsupported feature: Change CalcFormula on ""Last Phys. Invt. Date"(Field 7383)". Please convert manually.

            CaptionML = ENU = 'Last Phys. Invt. Date', FRA = 'Date dern. inventaire';
        }
        modify("Use Cross-Docking")
        {

            //Unsupported feature: Change InitValue on ""Use Cross-Docking"(Field 7384)". Please convert manually.

            CaptionML = ENU = 'Use Cross-Docking', FRA = 'Utiliser transbordement';
        }
        modify("Next Counting Start Date")
        {
            CaptionML = ENU = 'Next Counting Start Date', FRA = 'Proch. date début d''inventaire';
        }
        modify("Next Counting End Date")
        {
            CaptionML = ENU = 'Next Counting End Date', FRA = 'Proch. date fin d''inventaire';
        }
        modify("Planned Order Receipt (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Planned Order Receipt (Qty.)"(Field 99000765)". Please convert manually.

            CaptionML = ENU = 'Planned Order Receipt (Qty.)', FRA = 'Réception ordre planifiée (qté)';
        }
        modify("FP Order Receipt (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""FP Order Receipt (Qty.)"(Field 99000766)". Please convert manually.

            CaptionML = ENU = 'FP Order Receipt (Qty.)', FRA = 'Récep. ordre plan. ferme (qté)';
        }
        modify("Rel. Order Receipt (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Rel. Order Receipt (Qty.)"(Field 99000767)". Please convert manually.

            CaptionML = ENU = 'Rel. Order Receipt (Qty.)', FRA = 'Réception ordre lancé (qté)';
        }
        modify("Planned Order Release (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Planned Order Release (Qty.)"(Field 99000769)". Please convert manually.

            CaptionML = ENU = 'Planned Order Release (Qty.)', FRA = 'Lancement ordre planifié (qté)';
        }
        modify("Purch. Req. Receipt (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Purch. Req. Receipt (Qty.)"(Field 99000770)". Please convert manually.

            CaptionML = ENU = 'Purch. Req. Receipt (Qty.)', FRA = 'Réception prop. achat (qté)';
        }
        modify("Purch. Req. Release (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Purch. Req. Release (Qty.)"(Field 99000771)". Please convert manually.

            CaptionML = ENU = 'Purch. Req. Release (Qty.)', FRA = 'Lancement prop. achat (qté)';
        }
        modify("Qty. on Prod. Order")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Prod. Order"(Field 99000777)". Please convert manually.

            CaptionML = ENU = 'Qty. on Prod. Order', FRA = 'Qté sur ordre fabrication';
        }
        modify("Qty. on Component Lines")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Component Lines"(Field 99000778)". Please convert manually.

            CaptionML = ENU = 'Qty. on Component Lines', FRA = 'Qté sur lignes composant';
        }

        //Unsupported feature: CodeModification on ""Item No."(Field 1).OnValidate". Please convert manually.

        //trigger "(Field 1)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Item No." = xRec."Item No." THEN
          EXIT;

        IF Item.GET("Item No.") THEN BEGIN;
          "Shelf No." := Item."Shelf No.";
          "Vendor No." := Item."Vendor No.";
          "Vendor Item No." := Item."Vendor Item No.";
        #8..28
          "Last Direct Cost" := Item."Last Direct Cost";
          "Standard Cost" := Item."Standard Cost";
          "Unit Cost" := Item."Unit Cost";
        END;
        CALCFIELDS(Description,"Description 2","Assembly BOM",Inventory);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Item No." = xRec."Item No." then
          exit;

        if Item.GET("Item No.") then begin;
        #5..31
          //<< QXL10.01 VSC 26/09/2017 NRQ#38341
          "Quality Standard No." := Item."Quality Standard No.";
          "Quarantine Posting Policy" := Item."Quarantine Posting Policy";
          //>> QXL10.01 VSC NRQ#38341
          //HEI.06>>
          "Item Type" := Item."Item Type";
          "RPM Solution" := Item."RPM Solution";
          "RPM Type" := Item."RPM Type";
          //HEI.06<<
        end;
        CALCFIELDS(Description,"Description 2","Assembly BOM",Inventory);
        */
        //end;


        //Unsupported feature: CodeModification on ""Location Code"(Field 3).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Location Code" = '' THEN
          VALIDATE("Replenishment System");
        CheckTransferRoute;
        CALCFIELDS(
          Inventory,"Qty. on Purch. Order","Qty. on Prod. Order","Qty. in Transit",
          "Qty. on Component Lines","Qty. on Sales Order","Qty. on Service Order","Qty. on Job Order",
          "Qty. on Assembly Order","Qty. on Asm. Component");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Location Code" = '' then
        #2..7
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit Cost"(Field 22).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Item.GET("Item No.");
        IF Item."Costing Method" = Item."Costing Method"::Standard THEN
          VALIDATE("Standard Cost","Unit Cost")
        ELSE
          TestNoEntriesExist(FIELDCAPTION("Unit Cost"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.08>>
        //old code: Item.GET("Item No.");
        if not Item.GET("Item No.") then
          exit;
        //HEI.08<<
        if Item."Costing Method" = Item."Costing Method"::Standard then
          VALIDATE("Standard Cost","Unit Cost")
        else
          TestNoEntriesExist(FIELDCAPTION("Unit Cost"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Standard Cost"(Field 24).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Item.GET("Item No.");
        IF (Item."Costing Method" = Item."Costing Method"::Standard) AND (CurrFieldNo <> 0) THEN
          IF NOT
             CONFIRM(
               Text001 +
               Text002 +
               Text003,FALSE,
               FIELDCAPTION("Standard Cost"))
          THEN BEGIN
            "Standard Cost" := xRec."Standard Cost";
            EXIT;
          END;

        ItemCostMgt.UpdateUnitCostSKU(Item,Rec,0,0,TRUE,FIELDNO("Standard Cost"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.08>>
        //old code: Item.GET("Item No.");
        if not Item.GET("Item No.") then
          exit;
        //HEI.08<<
        if (Item."Costing Method" = Item."Costing Method"::Standard) and (CurrFieldNo <> 0) then
          if not
        #4..6
               Text003,false,
               FIELDCAPTION("Standard Cost"))
          then begin
            "Standard Cost" := xRec."Standard Cost";
            exit;
          end;
        // <<DITW18.00.06 MSF 09/03/2015 DIT-770 #1186
        ItemCostMgt.UpdateUnitCostSKU(Item,Rec,0,0,true,FIELDNO("Standard Cost"),true);
        // >>DITW18.00.06 MSF 09/03/2015 DIT-770 #1186
        */
        //end;


        //Unsupported feature: CodeModification on ""Vendor No."(Field 31).OnValidate". Please convert manually.

        //trigger "(Field 31)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (xRec."Vendor No." <> "Vendor No.") AND
           ("Vendor No." <> '')
        THEN
          IF Vend.GET("Vendor No.") THEN
            "Lead Time Calculation" := Vend."Lead Time Calculation";
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (xRec."Vendor No." <> "Vendor No.") and
           ("Vendor No." <> '')
        then
          if Vend.GET("Vendor No.") then
            "Lead Time Calculation" := Vend."Lead Time Calculation";
        */
        //end;


        //Unsupported feature: CodeModification on ""Assembly Policy"(Field 910).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Assembly Policy" = "Assembly Policy"::"Assemble-to-Order" THEN
          TESTFIELD("Replenishment System","Replenishment System"::Assembly);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Assembly Policy" = "Assembly Policy"::"Assemble-to-Order" then
          TESTFIELD("Replenishment System","Replenishment System"::Assembly);
        */
        //end;


        //Unsupported feature: CodeModification on ""Replenishment System"(Field 5419).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Replenishment System" <> "Replenishment System"::Assembly THEN
          TESTFIELD("Assembly Policy","Assembly Policy"::"Assemble-to-Stock");

        CASE "Replenishment System" OF
          "Replenishment System"::Purchase,
          "Replenishment System"::"Prod. Order",
          "Replenishment System"::Assembly:
            BEGIN
              "Transfer-Level Code" := 0;
              FromLocation := "Transfer-from Code";
              IF NOT UpdateTransferLevels(Rec) THEN
                ShowLoopError;
            END;
          "Replenishment System"::Transfer:
            BEGIN
              IF "Location Code" = '' THEN
                ERROR(
                  Text004,
                  FIELDCAPTION("Location Code"),TABLECAPTION,
                  "Replenishment System",FIELDCAPTION("Replenishment System"));
              VALIDATE("Transfer-from Code");
            END;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Replenishment System" <> "Replenishment System"::Assembly then
          TESTFIELD("Assembly Policy","Assembly Policy"::"Assemble-to-Stock");

        case "Replenishment System" of
        #5..7
            begin
              "Transfer-Level Code" := 0;
              FromLocation := "Transfer-from Code";
              if not UpdateTransferLevels(Rec) then
                ShowLoopError;
            end;
          "Replenishment System"::Transfer:
            begin
              if "Location Code" = '' then
        #17..21
            end;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Reordering Policy"(Field 5440).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Include Inventory" :=
          "Reordering Policy" IN ["Reordering Policy"::"Lot-for-Lot",
                                  "Reordering Policy"::"Maximum Qty.",
                                  "Reordering Policy"::"Fixed Reorder Qty."];
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        "Include Inventory" :=
          "Reordering Policy" in ["Reordering Policy"::"Lot-for-Lot",
                                  "Reordering Policy"::"Maximum Qty.",
                                  "Reordering Policy"::"Fixed Reorder Qty."];
        */
        //end;


        //Unsupported feature: CodeModification on ""Transfer-from Code"(Field 5700).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        FromSKU.SETRANGE("Location Code","Transfer-from Code");
        FromSKU.SETRANGE("Item No.","Item No.");
        FromSKU.SETRANGE("Variant Code","Variant Code");
        IF NOT FromSKU.FINDFIRST THEN
          "Transfer-Level Code" := -1
        ELSE
          "Transfer-Level Code" := FromSKU."Transfer-Level Code" - 1;
        FromLocation := "Transfer-from Code";
        MODIFY(TRUE);

        CheckTransferRoute;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        if not FromSKU.FINDFIRST then
          "Transfer-Level Code" := -1
        else
          "Transfer-Level Code" := FromSKU."Transfer-Level Code" - 1;
        FromLocation := "Transfer-from Code";
        MODIFY(true);

        CheckTransferRoute;
        */
        //end;


        //Unsupported feature: CodeModification on ""Phys Invt Counting Period Code"(Field 7380).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Phys Invt Counting Period Code" <> '' THEN BEGIN
          PhysInvtCountPeriod.GET("Phys Invt Counting Period Code");
          PhysInvtCountPeriod.TESTFIELD("Count Frequency per Year");
          IF "Phys Invt Counting Period Code" <> xRec."Phys Invt Counting Period Code" THEN BEGIN
            IF CurrFieldNo <> 0 THEN
              IF NOT CONFIRM(
                   Text7380,
                   FALSE,
                   FIELDCAPTION("Phys Invt Counting Period Code"),
                   FIELDCAPTION("Next Counting Start Date"),
                   FIELDCAPTION("Next Counting End Date"))
              THEN
                ERROR(Text7381);

            IF ("Last Counting Period Update" = 0D) OR
               ("Phys Invt Counting Period Code" <> xRec."Phys Invt Counting Period Code")
            THEN
              PhysInvtCountPeriodMgt.CalcPeriod(
                "Last Counting Period Update","Next Counting Start Date","Next Counting End Date",
                PhysInvtCountPeriod."Count Frequency per Year");
          END;
        END ELSE BEGIN
          IF NOT HideValidationDialog THEN
            IF NOT CONFIRM(Text003,FALSE,FIELDCAPTION("Phys Invt Counting Period Code")) THEN
              ERROR(Text7381);
          "Next Counting Start Date" := 0D;
          "Next Counting End Date" := 0D;
          "Last Counting Period Update" := 0D;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Phys Invt Counting Period Code" <> '' then begin
          PhysInvtCountPeriod.GET("Phys Invt Counting Period Code");
          PhysInvtCountPeriod.TESTFIELD("Count Frequency per Year");
          if "Phys Invt Counting Period Code" <> xRec."Phys Invt Counting Period Code" then begin
            if CurrFieldNo <> 0 then
              if not CONFIRM(
                   Text7380,
                   false,
        #9..11
              then
                ERROR(Text7381);

            if ("Last Counting Period Update" = 0D) or
               ("Phys Invt Counting Period Code" <> xRec."Phys Invt Counting Period Code")
            then
        #18..20
          end;
        end else begin
          if not HideValidationDialog then
            if not CONFIRM(Text003,false,FIELDCAPTION("Phys Invt Counting Period Code")) then
        #25..28
        end;
        */
        //end;

        // field(50000; "Plant-Specific Material Status"; Option)  // BC Upgrade NANDIS03 - Blocked Option Type
        field(50000; "Plant Spec.Material Status FND"; enum "Plant-Specific Material Status")  // BC Upgrade NANDIS03 - Used enum in stead of option
        {
            Caption = 'Plant-Specific Material Status';
            // Description = 'HEI.01';
            // OptionCaption = 'Local Setup,Local Active,Local Inact/ No Procurement,Local Inactive,Local to be Archived';
            // OptionMembers = "Local Setup","Local Active","Local Inact/ No Procurement","Local Inactive","Local to be Archived";
        }
        field(50003; "SKU Type FND"; Code[10])
        {
            Caption = 'Subtype Code';
            Description = 'HEI.02';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales | "Fin.Contract")); //---BC Upgrade KAMNAY01 Drinkit table in table TableRelation 
        }
        field(50004; "Quantity Quality Hold FND"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                  "Variant Code" = FIELD("Variant Code"),
                                                                  "Location Code" = FIELD("Location Code"),
                                                                  "Inspection Status 07FDW" = CONST('ON HOLD'),
                                                                  "Lot No." = FILTER(<> ''))); //Bc Upgrade PATHAA02 GAP014_DTW, IBM GAP DTW 43
            Caption = 'Quantity Quality Hold (Quarantine)';
            Description = 'HEI.03|HEI.07';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Quantity Unrestricted Pass FND"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                  "Variant Code" = FIELD("Variant Code"),
                                                                  "Location Code" = FIELD("Location Code"),
                                                                  "Inspection Status 07FDW" = CONST('UNBLOCKED'),
                                                                  "Lot No." = FILTER(<> ''))); //Bc Upgrade PATHAA02 GAP014_DTW, IBM GAP DTW 43
            Caption = 'Quantity Unrestricted (Pass)';
            Description = 'HEI.03|HEI.07';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; "Quantity Blocked (Fail) FND"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                  "Variant Code" = FIELD("Variant Code"),
                                                                  "Location Code" = FIELD("Location Code"),
                                                                  "Inspection Status 07FDW" = CONST('BLOCKED'),
                                                                  "Lot No." = FILTER(<> '')));
            Caption = 'Quantity Blocked (Fail)';
            Description = 'HEI.03|HEI.07';
            Editable = false;
            FieldClass = FlowField;
        }
        // field(50007; "Item Type"; Option)  // BC Upgrade NANDIS03 - Blocked Option Type
        field(50007; "Item Type FND"; enum "Item Type SKU")  // BC Upgrade NANDIS03 - Opened enum Type
        {
            Caption = 'Item Type';
            // Description = 'HEI.05';
            // Editable = false;
            // OptionCaption = '" ,RPM Related,Product Related"';
            // OptionMembers = " ","RPM Related","Product Related";
        }
        // field(50008; "RPM Solution"; Option)  // BC Upgrade NANDIS03 - Blocked option type
        field(50008; "RPM Solution FND"; enum "RPM Solution SKU")  // BC Upgrade NANDIS03 - Opened enum type
        {
            Caption = 'RPM Solution';
            // Description = 'HEI.05';
            // Editable = false;
            // OptionCaption = '" ,Deposit,Full-for-Empty with revenue impact (FFE with revenue),Full-for Empty without revenue impact (FFE w/o revenue)"';
            // OptionMembers = " ",Deposit,"Full-for-Empty with revenue impact (FFE with revenue)","Full-for Empty without revenue impact (FFE w/o revenue)";
        }
        field(50009; "RPM Type FND"; Code[20])
        {
            Description = 'HEI.05';
            Editable = false;
            Caption = 'RPM Type';
        }
        field(50010; "Available Inv. (Whse) FND"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                "Variant Code" = FIELD("Variant Code"),
                                                                "Location Code" = FIELD("Location Code"),
                                                                "Unavailable Stock (Bin) FND" = CONST(false),
                                                                "Unavail. Stock (Quality) FND" = CONST(false)));
            DecimalPlaces = 0 : 5;
            Description = 'HEI.09';
            Caption = 'Available Inventory (Whse)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "Item Category Code FND"; Code[20])
        {
            CalcFormula = Lookup(Item."Item Category Code" WHERE("No." = FIELD("Item No.")));
            Description = 'HEI.10';
            Caption = 'Item Category Code';
            FieldClass = FlowField;
        }
        field(50012; "CCC Dim. Code FND"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
            Caption = 'CCC Dimension Code';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('CCC'));
        }
        //BC Upgrade GUNREM01 >>Added blocked field
        field(50013; "Blocked FND"; Boolean)
        {
            Caption = 'Blocked';
            Description = 'DITW110.00.11 BL#30569';

            trigger OnValidate();
            var
                Lbln_Allowed: Boolean;
                UserSetup: Record "User Setup";
            begin
                // << DITW110.00.11 SFI 31/08/2017 BL#30569
                if ("Blocked FND" <> xRec."Blocked FND") and (USERID <> '') then begin
                    if UserSetup.GET(USERID) then begin
                        if not UserSetup."Release Item FND" then
                            ERROR(Text2014411, FIELDCAPTION("Blocked FND"));
                    end;
                end;
                // >> DITW110.00.11 SFI BL#30569
            end;
        }
        //PATHAA02 GAP014_DTW, IBM GAP DTW 43>>
        field(50014; "Quality Standard No. FND"; Code[20])
        {
            Caption = 'Quality Standard No.';
            DataClassification = ToBeClassified;
        }

        field(50015; "Quarantine Posting Policy FND"; Option)
        {
            Caption = 'Quarantine Posting Policy';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Allow Item into Stock","Prevent item from entering stock";
            OptionCaption = ' ,Allow item into stock,Prevent item from entering stock';
        }
        //PATHAA02 GAP014_DTW, IBM GAP DTW 43<<

        //---BC Upgrade KAMNAY01>>  
        // field(2013654;"Deposit Value";Decimal)
        // {
        //     AutoFormatType = 2;
        //     Caption = 'Deposit Value';
        //     Description = 'DITW110.00.11 BL#14417';
        // }
        // field(2014063;"Backorder Type";Option)
        // {
        //     Caption = 'Backorder Type';
        //     Description = 'DITW110.00.10 BL#15657';
        //     OptionCaption = '" ,Backorder,No Backorder"';
        //     OptionMembers = " ",Backorder,"No Backorder";
        // }
        // field(2014064;"Qty. on Sales Blanket Order";Decimal)
        // {
        //     AccessByPermission = TableData "Sales Shipment Header"=R;
        //     CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" WHERE ("Document Type"=CONST("Blanket Order"),
        //                                                                     Type=CONST(Item),
        //                                                                     "No."=FIELD("Item No."),
        //                                                                     "Location Code"=FIELD("Location Code"),
        //                                                                     "Shortcut Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
        //                                                                     "Shortcut Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),
        //                                                                     "Drop Shipment"=FIELD("Drop Shipment Filter"),
        //                                                                     "Variant Code"=FIELD("Variant Code"),
        //                                                                     "Shipment Date"=FIELD("Date Filter")));
        //     Caption = 'Qty. on Sales Blanket Order';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.10 BL#15657';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014410;"Production BOM No.";Code[20])
        // {
        //     CaptionML = ENU='Production BOM No.',
        //                 FRA='N° nomenclature production';
        //     Description = 'DITW18.00.06 MSF 03/02/2015 DIT-770 #1182';
        //     TableRelation = "Production BOM Header";

        //     trigger OnValidate();
        //     begin
        //         // << DITW18.00.06 MSF 03/02/2015 DIT-770 #1182
        //         if (xRec."Production BOM No." <> Rec."Production BOM No.") and (Rec."Production BOM No."='')   then begin
        //           GetItem("Item No.");
        //           if (Item."Replenishment System" = "Replenishment System")
        //             //<<DITW18.00.06 MSF 09/03/2015 DIT-770 #1186
        //             and ("Replenishment System"<> "Replenishment System"::Purchase) then
        //             //>>DITW18.00.06 MSF 09/03/2015 DIT-770 #1186
        //             ERROR(Text2014410,FIELDCAPTION("Production BOM No."));
        //         end;
        //         // >> DITW18.00.06 MSF 03/02/2015 DIT-770 #1182
        //     end;
        // }
        // field(2014411;"Routing No.";Code[20])
        // {
        //     CaptionML = ENU='Routing No.',
        //                 FRA='N° gamme';
        //     Description = 'DITW18.00.06 MSF 03/02/2015 DIT-770 #1182';
        //     TableRelation = "Routing Header";

        //     trigger OnValidate();
        //     begin
        //         // << DITW18.00.06 MSF 03/02/2015 DIT-770 #1182
        //         if (xRec."Routing No." <> Rec."Routing No.") and (Rec."Routing No."='') then begin
        //           GetItem("Item No.");
        //           if (Item."Replenishment System" = "Replenishment System")
        //             // <<DITW18.00.06 MSF 09/03/2015 DIT-770 #1186
        //             and ("Replenishment System"<> "Replenishment System"::Purchase) then
        //             //>>DITW18.00.06 MSF 09/03/2015 DIT-770 #1186
        //             ERROR(Text2014410,FIELDCAPTION("Routing No."));
        //         end;
        //         // >> DITW18.00.06 MSF 03/02/2015 DIT-770 #1182
        //     end;
        // }
        // field(2014412;"Scrap %";Decimal)
        // {
        //     CaptionML = ENU='Scrap %',
        //                 FRA='% perte';
        //     DecimalPlaces = 0:2;
        //     Description = 'DITW18.00.06 MSF 03/02/2015 DIT-770 #1182';
        //     MaxValue = 100;
        //     MinValue = 0;
        // }
        // field(2014413;"Single-Level Material Cost";Decimal)
        // {
        //     AutoFormatType = 2;
        //     CaptionML = ENU='Single-Level Material Cost',
        //                 FRA='Coût matière mono-niveau';
        //     Description = 'DITW18.00.06 MSF 16/02/2015 DIT-770 #1185';
        //     Editable = false;
        // }
        // field(2014414;"Single-Level Capacity Cost";Decimal)
        // {
        //     AutoFormatType = 2;
        //     CaptionML = ENU='Single-Level Capacity Cost',
        //                 FRA='Coût opératoire mono-niveau';
        //     Description = 'DITW18.00.06 MSF 16/02/2015 DIT-770 #1185';
        //     Editable = false;
        // }
        // field(2014415;"Single-Level Subcontrd. Cost";Decimal)
        // {
        //     AutoFormatType = 2;
        //     CaptionML = ENU='Single-Level Subcontrd. Cost',
        //                 FRA='Coût s/traitance mono-niveau';
        //     Description = 'DITW18.00.06 MSF 16/02/2015 DIT-770 #1185';
        //     Editable = false;
        // }
        // field(2014416;"Single-Level Cap. Ovhd Cost";Decimal)
        // {
        //     AutoFormatType = 2;
        //     CaptionML = ENU='Single-Level Cap. Ovhd Cost',
        //                 FRA='Frais gén. opérat. mono-niv.';
        //     Description = 'DITW18.00.06 MSF 16/02/2015 DIT-770 #1185';
        //     Editable = false;
        // }
        // field(2014417;"Single-Level Mfg. Ovhd Cost";Decimal)
        // {
        //     AutoFormatType = 2;
        //     CaptionML = ENU='Single-Level Mfg. Ovhd Cost',
        //                 FRA='Frais gén. matière mono-niv.';
        //     Description = 'DITW18.00.06 MSF 16/02/2015 DIT-770 #1185';
        //     Editable = false;
        // }
        // field(2014418;"Rolled-up Material Cost";Decimal)
        // {
        //     AutoFormatType = 2;
        //     CaptionML = ENU='Rolled-up Material Cost',
        //                 FRA='Coût matière multi-niveau';
        //     DecimalPlaces = 2:5;
        //     Description = 'DITW18.00.06 MSF 16/02/2015 DIT-770 #1185';
        //     Editable = false;
        // }
        // field(2014419;"Rolled-up Capacity Cost";Decimal)
        // {
        //     AutoFormatType = 2;
        //     CaptionML = ENU='Rolled-up Capacity Cost',
        //                 FRA='Coût opératoire multi-niveau';
        //     DecimalPlaces = 2:5;
        //     Description = 'DITW18.00.06 MSF 16/02/2015 DIT-770 #1185';
        //     Editable = false;
        // }
        // field(2014420;"Rolled-up Subcontracted Cost";Decimal)
        // {
        //     AutoFormatType = 2;
        //     CaptionML = ENU='Rolled-up Subcontracted Cost',
        //                 FRA='Coût s/traitance multi-niv.';
        //     Description = 'DITW18.00.06 MSF 16/02/2015 DIT-770 #1185';
        //     Editable = false;
        // }
        // field(2014421;"Rolled-up Mfg. Ovhd Cost";Decimal)
        // {
        //     AutoFormatType = 2;
        //     CaptionML = ENU='Rolled-up Mfg. Ovhd Cost',
        //                 FRA='Frais gén. matière multi-niv.';
        //     Description = 'DITW18.00.06 MSF 16/02/2015 DIT-770 #1185';
        //     Editable = false;
        // }
        // field(2014422;"Rolled-up Cap. Overhead Cost";Decimal)
        // {
        //     AutoFormatType = 2;
        //     CaptionML = ENU='Rolled-up Cap. Overhead Cost',
        //                 FRA='Frais gén. opérat. multi-niv.';
        //     Description = 'DITW18.00.06 MSF 16/02/2015 DIT-770 #1185';
        //     Editable = false;
        // }
        // field(2014423;"Last Unit Cost Calc. Date";Date)
        // {
        //     CaptionML = ENU='Last Unit Cost Calc. Date',
        //                 FRA='Date dern. calcul coût unitaire';
        //     Description = 'DITW18.00.06 MSF 16/02/2015 DIT-770 #1185';
        // }
        // field(2014424;"Overhead Rate";Decimal)
        // {
        //     AutoFormatType = 2;
        //     CaptionML = ENU='Overhead Rate',
        //                 FRA='Frais généraux';
        //     Description = 'DITW18.00.06 MSF 16/02/2015 DIT-770 #1185';
        // }
        // field(2014425;"Indirect Cost %";Decimal)
        // {
        //     CaptionML = ENU='Indirect Cost %',
        //                 FRA='% coût indirect';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW18.00.06 MSF 16/02/2015 DIT-770 #1185';
        //     MinValue = 0;

        //     trigger OnValidate();
        //     var
        //         Item : Record Item;
        //     begin
        //         //HEI.08>>
        //         //old code: Item.GET("Item No.");
        //         if not Item.GET("Item No.") then
        //           exit;
        //         //HEI.08<<
        //         // <<DITW18.00.06 MSF 09/03/2015 DIT-770 #1186
        //         ItemCostMgt.UpdateUnitCostSKU(Item,Rec,"Last Direct Cost","Standard Cost",true,FIELDNO("Indirect Cost %"),true);
        //         // >>DITW18.00.06 MSF 09/03/2015 DIT-770 #1186
        //     end;
        // }
        // field(2014426;Blocked;Boolean)
        // {
        //     Caption = 'Blocked';
        //     Description = 'DITW110.00.11 BL#30569';

        //     trigger OnValidate();
        //     var
        //         Lbln_Allowed : Boolean;
        //         UserSetup : Record "User Setup";
        //     begin
        //         // << DITW110.00.11 SFI 31/08/2017 BL#30569
        //         if (Blocked <> xRec.Blocked) and (USERID <> '') then begin
        //           if UserSetup.GET(USERID) then begin
        //             if not UserSetup."Release Item" then
        //               ERROR(Text2014411, FIELDCAPTION(Blocked));
        //           end;
        //         end;
        //         // >> DITW110.00.11 SFI BL#30569
        //     end;
        // }
        // field(2014509;"Parent BOM Item No.";Code[20])
        // {
        //     CaptionML = ENU='Parent BOM Item No.',
        //                 FRA='N° parent article nomenclature';
        //     Description = 'DITW18.00.06 DIT-770 #1186';
        //     Editable = false;
        //     TableRelation = Item;
        // }
        // field(2035091;"Quality Standard No.";Code[20])
        // {
        //     Caption = 'Quality Standard No.';
        //     Description = 'QXL10.01 NRQ#38341';
        //     TableRelation = "Quality Standard Header";
        // }
        // field(2035118;"Quarantine Posting Policy";Option)
        // {
        //     Caption = 'Quarantine Posting Policy';
        //     Description = 'QXL10.01 NRQ#38341';
        //     OptionCaption = '" ,Allow item into stock,Prevent item from entering stock"';
        //     OptionMembers = " ","Allow item into stock","Prevent item from entering stock";
        // }
        //---BC Upgrade KAMNAY01<<
    }


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ("Variant Code" = '') AND
       ("Location Code" = '')
    THEN
      ERROR(
        Text000,
        FIELDCAPTION("Location Code"),FIELDCAPTION("Variant Code"),TABLECAPTION);

    "Last Date Modified" := TODAY;
    PlanningAssignment.AssignOne("Item No.","Variant Code","Location Code",WORKDATE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if ("Variant Code" = '') and
       ("Location Code" = '')
    then
    #4..9
    */
    //end;


    //Unsupported feature: CodeModification on "OnRename". Please convert manually.

    //trigger OnRename();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ("Variant Code" = '') AND
       ("Location Code" = '')
    THEN
      ERROR(
        Text000,
        FIELDCAPTION("Location Code"),FIELDCAPTION("Variant Code"),TABLECAPTION);

    "Last Date Modified" := TODAY;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if ("Variant Code" = '') and
       ("Location Code" = '')
    then
    #4..8
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You must specify a %1 or a %2 for each %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You must specify a %1 or a %2 for each %3.;FRA=Vous devez spécifier un %1 ou un %2 pour chaque %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU="There may be orders and open ledger entries for the item. ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU="There may be orders and open ledger entries for the item. ";FRA="Il existe probablement des écritures comptables ouvertes et des ordres pour cet article. ";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=If you change %1 it may affect new orders and entries.\\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=If you change %1 it may affect new orders and entries.\\;FRA=Si vous modifiez la valeur du champ %1, cela peut affecter les nouveaux ordres et écritures.\\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=Do you want to change %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=Do you want to change %1?;FRA=Souhaitez-vous modifier la valeur du champ %1?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=You must specify a %1 for this %2 to use %3 as %4.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=You must specify a %1 for this %2 to use %3 as %4.;FRA=Vous devez spécifier un %1 pour ce %2 pour utiliser %3 comme %4.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=You must specify a %1 from %2 %3 to %2 %4.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=You must specify a %1 from %2 %3 to %2 %4.;FRA=Vous devez spécifier un %1 du %2 %3 vers %2 %4.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=A circular reference in %1 has been detected:\%2 ->%3 ->%4;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=A circular reference in %1 has been detected:\%2 ->%3 ->%4;FRA=Une référence circulaire a été détectée dans %1 :\%2 ->%3 ->%4;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=You cannot change %1 because there are one or more ledger entries for this SKU.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=You cannot change %1 because there are one or more ledger entries for this SKU.;FRA=Vous ne pouvez pas modifier %1 car il existe des écritures comptables associées à ce point de stock.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text7380(Variable 1015)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text7380 : @@@=If you change the Phys Invt Counting Period Code, the Next Counting Start Date and Next Counting End Date are calculated.\Do you still want to change the Phys Invt Counting Period Code?;ENU=If you change the %1, the %2 and %3 are calculated.\Do you still want to change the %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text7380 : @@@=If you change the Phys Invt Counting Period Code, the Next Counting Start Date and Next Counting End Date are calculated.\Do you still want to change the Phys Invt Counting Period Code?;ENU=If you change the %1, the %2 and %3 are calculated.\Do you still want to change the %1?;FRA=Si vous modifiez le %1, la %2 et la %3 sont calculées.\Souhaitez-vous quand même modifier le %1 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text7381(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text7381 : ENU=Cancelled.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text7381 : ENU=Cancelled.;FRA=Annulé.;
    //Variable type has not been exported.

    var
        Text2014410: TextConst ENU = '%1 must not be empty', FRA = '%1 ne doit pas être vide';
        Text2014411: Label 'You are not allowed to change the value of the field %1.';
        Text007: Label 'You cannot change %1 because there are one or more ledger entries for this item.';
        CannotChangeFieldErr: TextConst Comment = '%1 = Field Caption, %2 = Item Table Name, %3 = Item No., %4 = Table Name', ENU = 'You cannot change the %1 field on %2 %3 because at least one %4 exists for this item.';
        ItemLedgEntry: Record "Item Ledger Entry";

    //---BC Upgrade KAMNAY01>>
    procedure HasBOM(): Boolean
    begin

        //HEI.04>>
        CALCFIELDS("Assembly BOM");
        EXIT("Assembly BOM" OR ("Production BOM No." <> ''));
        //HEI.04<<
    end;
    //---BC Upgrade KAMNAY01<<
    //Bc Upgrade PATHAA02 GAP014_DTW, IBM GAP DTW 43 >>
    trigger OnAfterModify()
    var
        QCTrigger92FDW: Record QCTrigger92FDW;
        QCTrigger92FDW2: Record QCTrigger92FDW;
        ItemL: Record Item;

        LastEntryNo: Integer;
    begin
        If (Rec."Quality Standard No. FND" = '') and (rec."Item No." <> '') then
            exit;

        QCTrigger92FDW.Reset();
        QCTrigger92FDW.SetRange("No.", Rec."Item No.");
        QCTrigger92FDW.SetRange("Location Code", Rec."Location Code");
        IF not QCTrigger92FDW.FindFirst() then begin

            // Generate Entry No.
            QCTrigger92FDW2.RESET();
            if QCTrigger92FDW2.FindLast() then
                LastEntryNo := QCTrigger92FDW2."Entry No."
            else
                LastEntryNo := 0;
            QCTrigger92FDW.Init();
            QCTrigger92FDW."Entry No." := LastEntryNo + 1;
            // QCTrigger92FDW.Validate("Document Type", QCTrigger92FDW."Document Type"::"Production Order");
            // // QCTrigger92FDW.Validate("No.", Rec."Item No.");
            // QCTrigger92FDW."No." := Rec."Item No.";
            // QCTrigger92FDW.Validate("Document Action", 3);
            // QCTrigger92FDW.Validate("Location Type", QCTrigger92FDW."Location Type"::Location);
            // QCTrigger92FDW.Validate("Location Code", Rec."Location Code");
            // QCTrigger92FDW.Validate("Quality Check Type", QCTrigger92FDW."Quality Check Type"::Item);
            // QCTrigger92FDW.Validate("Source Type", QCTrigger92FDW."Source Type"::"All Work Centers");
            // QCTrigger92FDW.Validate("Team", 'ALL'); //hardcoded, need to chg                      
            // QCTrigger92FDW.Validate("Plan Certified", true);
            // QCTrigger92FDW.Validate("Plan Effective", true);
            // QCTrigger92FDW.Validate("Per Lot", true);
            // QCTrigger92FDW.Validate("Plan Code", Rec."Quality Standard No.");

            QCTrigger92FDW."Document Type" := QCTrigger92FDW."Document Type"::"Production Order";
            QCTrigger92FDW."No." := Rec."Item No.";
            IF ItemL.GET(Rec."Item No.") then
                QCTrigger92FDW.Name := ItemL.Description;
            QCTrigger92FDW."Document Action" := 3;
            QCTrigger92FDW."Document Action Caption" := QCTrigger92FDW."Document Action Caption"::Post;
            QCTrigger92FDW."Location Type" := QCTrigger92FDW."Location Type"::Location;
            QCTrigger92FDW."Location Code" := Rec."Location Code";
            QCTrigger92FDW."Quality Check Type" := QCTrigger92FDW."Quality Check Type"::Item;
            QCTrigger92FDW."Source Type" := QCTrigger92FDW."Source Type"::"All Work Centers";
            QCTrigger92FDW."Team" := 'ALL'; //hardcoded, need to chg                      
            QCTrigger92FDW."Plan Certified" := true;
            QCTrigger92FDW."Plan Effective" := true;
            QCTrigger92FDW."Per Lot" := true;
            QCTrigger92FDW."Plan Code" := Rec."Quality Standard No. FND";
            QCTrigger92FDW."Item Type" := QCTrigger92FDW."Item Type"::Item;
            QCTrigger92FDW.Insert();
        end;
    end;
    //Bc Upgrade PATHAA02 GAP014_DTW, IBM GAP DTW 43<<
}

