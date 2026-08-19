tableextension 50141 RequisitionLineExtFND extends "Requisition Line"
{
    // version NAVW110.0.00.16585,FINXL10.00,MANXL8.00.002,DITW110.00.10,HEI.04
    //BC Upgrade kamnay01 >> Added DITW field for Production Unit of Measure
    fields
    {
        modify("Worksheet Template Name")
        {
            CaptionML = ENU = 'Worksheet Template Name', FRA = 'Nom modèle feuille';
        }
        modify("Journal Batch Name")
        {

            //Unsupported feature: Change TableRelation on ""Journal Batch Name"(Field 2)". Please convert manually.

            CaptionML = ENU = 'Journal Batch Name', FRA = 'Nom feuille';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            // OptionCaptionML = ENU = ' ,G/L Account,Item', FRA = ' ,Compte gnéral,Article';
        }
        modify("No.")
        {

            //Unsupported feature: Change TableRelation on ""No."(Field 5)". Please convert manually.

            CaptionML = ENU = 'No.', FRA = 'N°';

            //Unsupported feature: Change Description on ""No."(Field 5)". Please convert manually.


            //Unsupported feature: Change Editable on ""No."(Field 5)". Please convert manually.

        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';

            //Unsupported feature: Change Description on "Description(Field 6)". Please convert manually.


            //Unsupported feature: Change Editable on "Description(Field 6)". Please convert manually.

        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description 2', FRA = 'Désignation 2';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';

            //Unsupported feature: Change Description on "Quantity(Field 8)". Please convert manually.

        }
        modify("Vendor No.")
        {
            CaptionML = ENU = 'Vendor No.', FRA = 'N° fournisseur';

            //Unsupported feature: Change Description on ""Vendor No."(Field 9)". Please convert manually.

        }
        modify("Direct Unit Cost")
        {
            CaptionML = ENU = 'Direct Unit Cost', FRA = 'Coût unitaire direct';
        }
        modify("Due Date")
        {
            CaptionML = ENU = 'Due Date', FRA = 'Délai';
        }
        modify("Requester ID")
        {
            CaptionML = ENU = 'Requester ID', FRA = 'ID demandeur';
        }
        modify(Confirmed)
        {
            CaptionML = ENU = 'Confirmed', FRA = 'Confirmé';
        }
        modify("Shortcut Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Shortcut Dimension 1 Code"(Field 15)". Please convert manually.

            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Shortcut Dimension 2 Code"(Field 16)". Please convert manually.

            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Location Code")
        {

            //Unsupported feature: Change TableRelation on ""Location Code"(Field 17)". Please convert manually.

            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Recurring Method")
        {
            CaptionML = ENU = 'Recurring Method', FRA = 'Mode abonnement';
            OptionCaptionML = ENU = ',Fixed,Variable', FRA = ',Fixe,Variable';
        }
        modify("Expiration Date")
        {
            CaptionML = ENU = 'Expiration Date', FRA = 'Date d''expiration';
        }
        modify("Recurring Frequency")
        {
            CaptionML = ENU = 'Recurring Frequency', FRA = 'Périodicité abonnement';
        }
        modify("Order Date")
        {
            CaptionML = ENU = 'Order Date', FRA = 'Date commande';
        }
        modify("Vendor Item No.")
        {
            CaptionML = ENU = 'Vendor Item No.', FRA = 'Référence fournisseur';
        }
        modify("Sales Order No.")
        {

            //Unsupported feature: Change TableRelation on ""Sales Order No."(Field 23)". Please convert manually.

            CaptionML = ENU = 'Sales Order No.', FRA = 'N° commande vente';
        }
        modify("Sales Order Line No.")
        {
            CaptionML = ENU = 'Sales Order Line No.', FRA = 'N° ligne commande vente';
        }
        modify("Sell-to Customer No.")
        {
            CaptionML = ENU = 'Sell-to Customer No.', FRA = 'N° donneur d''ordre';
        }
        modify("Ship-to Code")
        {

            //Unsupported feature: Change TableRelation on ""Ship-to Code"(Field 26)". Please convert manually.

            CaptionML = ENU = 'Ship-to Code', FRA = 'Code destinataire';
        }
        modify("Order Address Code")
        {

            //Unsupported feature: Change TableRelation on ""Order Address Code"(Field 28)". Please convert manually.

            CaptionML = ENU = 'Order Address Code', FRA = 'Code adresse commande';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Currency Factor")
        {
            CaptionML = ENU = 'Currency Factor', FRA = 'Facteur devise';
        }
        modify("Reserved Quantity")
        {

            //Unsupported feature: Change CalcFormula on ""Reserved Quantity"(Field 31)". Please convert manually.

            CaptionML = ENU = 'Reserved Quantity', FRA = 'Quantité réservée';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Prod. Order No.")
        {

            //Unsupported feature: Change TableRelation on ""Prod. Order No."(Field 5401)". Please convert manually.

            CaptionML = ENU = 'Prod. Order No.', FRA = 'N° ordre de fabrication';
        }
        modify("Variant Code")
        {

            //Unsupported feature: Change TableRelation on ""Variant Code"(Field 5402)". Please convert manually.

            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';

            //Unsupported feature: Change Description on ""Variant Code"(Field 5402)". Please convert manually.

        }
        modify("Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""Bin Code"(Field 5403)". Please convert manually.

            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
        }
        modify("Unit of Measure Code")
        {

            //Unsupported feature: Change TableRelation on ""Unit of Measure Code"(Field 5407)". Please convert manually.

            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Quantity (Base)")
        {
            CaptionML = ENU = 'Quantity (Base)', FRA = 'Quantité (base)';
        }
        modify("Reserved Qty. (Base)")
        {

            //Unsupported feature: Change CalcFormula on ""Reserved Qty. (Base)"(Field 5431)". Please convert manually.

            CaptionML = ENU = 'Reserved Qty. (Base)', FRA = 'Quantité réservée (base)';
        }
        modify("Demand Type")
        {

            //Unsupported feature: Change TableRelation on ""Demand Type"(Field 5520)". Please convert manually.

            CaptionML = ENU = 'Demand Type', FRA = 'Type de demande';
        }
        modify("Demand Subtype")
        {
            CaptionML = ENU = 'Demand Subtype', FRA = 'Sous-type de demande';
            OptionCaptionML = ENU = '0,1,2,3,4,5,6,7,8,9', FRA = '0,1,2,3,4,5,6,7,8,9';
        }
        modify("Demand Order No.")
        {
            CaptionML = ENU = 'Demand Order No.', FRA = 'N° ordre demande';
        }
        modify("Demand Line No.")
        {
            CaptionML = ENU = 'Demand Line No.', FRA = 'N° ligne demande';
        }
        modify("Demand Ref. No.")
        {
            CaptionML = ENU = 'Demand Ref. No.', FRA = 'N° réf. demande';
        }
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            OptionCaptionML = ENU = '0,1,2,3,4,5,6,7,8,9,10', FRA = '0,1,2,3,4,5,6,7,8,9,10';
        }
        modify("Demand Date")
        {
            CaptionML = ENU = 'Demand Date', FRA = 'Date demande';
        }
        modify("Demand Quantity")
        {
            CaptionML = ENU = 'Demand Quantity', FRA = 'Quantité demandée';
        }
        modify("Demand Quantity (Base)")
        {
            CaptionML = ENU = 'Demand Quantity (Base)', FRA = 'Quantité demande (base)';
        }
        modify("Needed Quantity")
        {
            CaptionML = ENU = 'Needed Quantity', FRA = 'Quantité nécessaire';
        }
        modify("Needed Quantity (Base)")
        {
            CaptionML = ENU = 'Needed Quantity (Base)', FRA = 'Quantité nécessaire (base)';
        }
        modify(Reserve)
        {
            CaptionML = ENU = 'Reserve', FRA = 'Réserver';
        }
        modify("Qty. per UOM (Demand)")
        {
            CaptionML = ENU = 'Qty. per UOM (Demand)', FRA = 'Qté par unité (demande)';
        }
        modify("Unit Of Measure Code (Demand)")
        {

            //Unsupported feature: Change TableRelation on ""Unit Of Measure Code (Demand)"(Field 5542)". Please convert manually.

            CaptionML = ENU = 'Unit Of Measure Code (Demand)', FRA = 'Code unité (demande)';
        }
        modify("Supply From")
        {

            //Unsupported feature: Change TableRelation on ""Supply From"(Field 5552)". Please convert manually.

            CaptionML = ENU = 'Supply From', FRA = 'Origine approvisionnement';
        }
        modify("Original Item No.")
        {
            CaptionML = ENU = 'Original Item No.', FRA = 'N° de l''article initial';
        }
        modify("Original Variant Code")
        {

            //Unsupported feature: Change TableRelation on ""Original Variant Code"(Field 5554)". Please convert manually.

            CaptionML = ENU = 'Original Variant Code', FRA = 'Code variante initial';
        }
        modify(Level)
        {
            CaptionML = ENU = 'Level', FRA = 'Niveau';
        }
        modify("Demand Qty. Available")
        {
            CaptionML = ENU = 'Demand Qty. Available', FRA = 'Qté demande disponible';
        }
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("Item Category Code")
        {
            CaptionML = ENU = 'Item Category Code', FRA = 'Code catégorie article';
        }
        modify(Nonstock)
        {
            CaptionML = ENU = 'Nonstock', FRA = 'Non stocké';
        }
        modify("Purchasing Code")
        {
            CaptionML = ENU = 'Purchasing Code', FRA = 'Procédure achat';
        }
        // modify("Product Group Code")
        // {

        //     //Unsupported feature: Change TableRelation on ""Product Group Code"(Field 5705)". Please convert manually.

        //     CaptionML = ENU='Product Group Code',FRA='Code groupe produits';
        // }  // BC Upgrade NANDIS03
        modify("Transfer-from Code")
        {

            //Unsupported feature: Change TableRelation on ""Transfer-from Code"(Field 5706)". Please convert manually.

            CaptionML = ENU = 'Transfer-from Code', FRA = 'Code prov. transfert';
        }
        modify("Transfer Shipment Date")
        {
            CaptionML = ENU = 'Transfer Shipment Date', FRA = 'Date expédition transfert';
        }
        modify("Line Discount %")
        {
            CaptionML = ENU = 'Line Discount %', FRA = '% remise ligne';
        }
        modify("Blanket Purch. Order Exists")
        {

            //Unsupported feature: Change CalcFormula on ""Blanket Purch. Order Exists"(Field 7100)". Please convert manually.

            CaptionML = ENU = 'Blanket Purch. Order Exists', FRA = 'La commande achat ouverte existe';
        }
        modify("Routing No.")
        {
            CaptionML = ENU = 'Routing No.', FRA = 'N° gamme';
        }
        modify("Operation No.")
        {

            //Unsupported feature: Change TableRelation on ""Operation No."(Field 99000751)". Please convert manually.

            CaptionML = ENU = 'Operation No.', FRA = 'N° opération';
        }
        modify("Work Center No.")
        {
            CaptionML = ENU = 'Work Center No.', FRA = 'N° centre de charge';
        }
        modify("Prod. Order Line No.")
        {

            //Unsupported feature: Change TableRelation on ""Prod. Order Line No."(Field 99000754)". Please convert manually.

            CaptionML = ENU = 'Prod. Order Line No.', FRA = 'N° ligne O.F.';
        }
        modify("MPS Order")
        {
            CaptionML = ENU = 'MPS Order', FRA = 'Ordre PDP';
        }
        modify("Planning Flexibility")
        {
            CaptionML = ENU = 'Planning Flexibility', FRA = 'Flexibilité planification';
            // OptionCaptionML = ENU = 'Unlimited,None', FRA = 'Illimitée,Aucune';
        }
        modify("Routing Reference No.")
        {
            CaptionML = ENU = 'Routing Reference No.', FRA = 'N° référence gamme';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        modify("Gen. Business Posting Group")
        {
            CaptionML = ENU = 'Gen. Business Posting Group', FRA = 'Groupe compta. marché';
        }
        modify("Low-Level Code")
        {
            CaptionML = ENU = 'Low-Level Code', FRA = 'Code plus bas niveau';
        }
        modify("Production BOM Version Code")
        {

            //Unsupported feature: Change TableRelation on ""Production BOM Version Code"(Field 99000885)". Please convert manually.

            CaptionML = ENU = 'Production BOM Version Code', FRA = 'Code version nomenclature';
        }
        modify("Routing Version Code")
        {

            //Unsupported feature: Change TableRelation on ""Routing Version Code"(Field 99000886)". Please convert manually.

            CaptionML = ENU = 'Routing Version Code', FRA = 'Code version gamme';
        }
        modify("Routing Type")
        {
            CaptionML = ENU = 'Routing Type', FRA = 'Type gamme';
            OptionCaptionML = ENU = 'Serial,Parallel', FRA = 'Séquentielle,Parallèle';
        }
        modify("Original Quantity")
        {
            CaptionML = ENU = 'Original Quantity', FRA = 'Quantité initiale';
        }
        modify("Finished Quantity")
        {
            CaptionML = ENU = 'Finished Quantity', FRA = 'Quantité réalisée';
        }
        modify("Remaining Quantity")
        {
            CaptionML = ENU = 'Remaining Quantity', FRA = 'Quantité restante';
        }
        modify("Original Due Date")
        {
            CaptionML = ENU = 'Original Due Date', FRA = 'Délai initial';
        }
        modify("Scrap %")
        {
            CaptionML = ENU = 'Scrap %', FRA = '% perte';
        }
        modify("Starting Date")
        {
            CaptionML = ENU = 'Starting Date', FRA = 'Date début';
        }
        modify("Starting Time")
        {
            CaptionML = ENU = 'Starting Time', FRA = 'Heure début';
        }
        modify("Ending Date")
        {
            CaptionML = ENU = 'Ending Date', FRA = 'Date fin';
        }
        modify("Ending Time")
        {
            CaptionML = ENU = 'Ending Time', FRA = 'Heure fin';
        }
        modify("Production BOM No.")
        {

            //Unsupported feature: Change TableRelation on ""Production BOM No."(Field 99000898)". Please convert manually.

            CaptionML = ENU = 'Production BOM No.', FRA = 'N° nomenclature production';
        }
        modify("Indirect Cost %")
        {
            CaptionML = ENU = 'Indirect Cost %', FRA = '% coût indirect';
        }
        modify("Overhead Rate")
        {
            CaptionML = ENU = 'Overhead Rate', FRA = 'Frais généraux';
        }
        modify("Unit Cost")
        {
            CaptionML = ENU = 'Unit Cost', FRA = 'Coût unitaire';
        }
        modify("Cost Amount")
        {
            CaptionML = ENU = 'Cost Amount', FRA = 'Coût total';
        }
        modify("Replenishment System")
        {
            CaptionML = ENU = 'Replenishment System', FRA = 'Système réappro.';
            // OptionCaptionML = ENU = 'Purchase,Prod. Order,Transfer,Assembly, ', FRA = 'Achat,O.F.,Transfert,Assemblage, ';
        }
        modify("Ref. Order No.")
        {

            //Unsupported feature: Change TableRelation on ""Ref. Order No."(Field 99000904)". Please convert manually.

            CaptionML = ENU = 'Ref. Order No.', FRA = 'N° ordre référence';
        }
        modify("Ref. Order Type")
        {
            CaptionML = ENU = 'Ref. Order Type', FRA = 'Type ordre référence';
           // OptionCaptionML = ENU = ' ,Purchase,Prod. Order,Transfer,Assembly', FRA = ' ,Achat,O.F.,Transfert,Assemblage';
        }
        modify("Ref. Order Status")
        {
            CaptionML = ENU = 'Ref. Order Status', FRA = 'Statut ordre référence';
           // OptionCaptionML = ENU = ',Planned,Firm Planned,Released', FRA = ',Planifié,Planifié ferme,Lancé';
        }
        modify("Ref. Line No.")
        {
            CaptionML = ENU = 'Ref. Line No.', FRA = 'N° ligne référence';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Expected Operation Cost Amt.")
        {

            //Unsupported feature: Change CalcFormula on ""Expected Operation Cost Amt."(Field 99000909)". Please convert manually.

            CaptionML = ENU = 'Expected Operation Cost Amt.', FRA = 'Coût opératoire total prévu';
        }
        modify("Expected Component Cost Amt.")
        {

            //Unsupported feature: Change CalcFormula on ""Expected Component Cost Amt."(Field 99000910)". Please convert manually.

            CaptionML = ENU = 'Expected Component Cost Amt.', FRA = 'Coût composant total prévu';
        }
        modify("Finished Qty. (Base)")
        {
            CaptionML = ENU = 'Finished Qty. (Base)', FRA = 'Quantité réalisée (base)';
        }
        modify("Remaining Qty. (Base)")
        {
            CaptionML = ENU = 'Remaining Qty. (Base)', FRA = 'Quantité restante (base)';
        }
        modify("Related to Planning Line")
        {
            CaptionML = ENU = 'Related to Planning Line', FRA = 'Ligne planning liée';
        }
        modify("Planning Level")
        {
            CaptionML = ENU = 'Planning Level', FRA = 'Niveau planification';
        }
        modify("Planning Line Origin")
        {
            CaptionML = ENU = 'Planning Line Origin', FRA = 'Origine ligne planning';
           // OptionCaptionML = ENU = ' ,Action Message,Planning,Order Planning', FRA = ' ,Message d''action,Planning,Planning commande';
        }
        modify("Action Message")
        {
            CaptionML = ENU = 'Action Message', FRA = 'Message d''action';
           // OptionCaptionML = ENU = ' ,New,Change Qty.,Reschedule,Resched. & Chg. Qty.,Cancel,Append', FRA = ' ,Nouveau,Changer qté,Replanifier,Replanifier & changer qté,Annuler,Ajouter';

            //Unsupported feature: Change OptionString on ""Action Message"(Field 99000916)". Please convert manually.

        }
        modify("Accept Action Message")
        {
            CaptionML = ENU = 'Accept Action Message', FRA = 'Accepter message d''action';
        }
        modify("Net Quantity (Base)")
        {
            CaptionML = ENU = 'Net Quantity (Base)', FRA = 'Quantité nette (base)';
        }
        modify("Starting Date-Time")
        {
            CaptionML = ENU = 'Starting Date-Time', FRA = 'Date/Heure début';
        }
        modify("Ending Date-Time")
        {
            CaptionML = ENU = 'Ending Date-Time', FRA = 'Date/Heure fin';
        }
        modify("Order Promising ID")
        {
            CaptionML = ENU = 'Order Promising ID', FRA = 'ID promesse livraison';
        }
        modify("Order Promising Line No.")
        {
            CaptionML = ENU = 'Order Promising Line No.', FRA = 'N° ligne promesse livraison';
        }
        modify("Order Promising Line ID")
        {
            CaptionML = ENU = 'Order Promising Line ID', FRA = 'ID ligne promesse livraison';
        }

        //Unsupported feature: CodeModification on "Type(Field 4).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Type <> xRec.Type THEN BEGIN
          NewType := Type;

          DeleteRelations;
        #5..10
          AddOnIntegrMgt.ResetReqLineFields(Rec);
          INIT;
          Type := NewType;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Type <> xRec.Type then begin
        #2..13
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""No."(Field 5).OnValidate". Please convert manually.

        //trigger "(Field 5)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckActionMessageNew;
        ReserveReqLine.VerifyChange(Rec,xRec);
        DeleteRelations;

        IF "No." = '' THEN BEGIN
          CreateDim(
            DimMgt.TypeToTableID3(Type),
            "No.",DATABASE::Vendor,"Vendor No.");
          INIT;
          Type := xRec.Type;
          EXIT;
        end;

        IF "No." <> xRec."No." THEN BEGIN
          "Variant Code" := '';
          "Prod. Order No." := '';
          AddOnIntegrMgt.ResetReqLineFields(Rec);
        end;

        TESTFIELD(Type);
        CASE Type OF
          Type::"G/L Account":
            BEGIN
              GLAcc.GET("No.");
              GLAcc.CheckGLAcc;
              GLAcc.TESTFIELD("Direct Posting",TRUE);
              Description := GLAcc.Name;
            end;
          Type::Item:
            BEGIN
              GetItem;
              IF PlanningResiliency AND Item.Blocked THEN
                TempPlanningErrorLog.SetError(
                  STRSUBSTNO(Text031,Item.TABLECAPTION,Item."No."),
                  DATABASE::Item,Item.GETPOSITION);
              Item.TESTFIELD(Blocked,FALSE);
              UpdateDescription;
              "Low-Level Code" := Item."Low-Level Code";
              "Scrap %" := Item."Scrap %";
              "Item Category Code" := Item."Item Category Code";
              "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
              "Gen. Business Posting Group" := '';
              IF PlanningResiliency AND (Item."Base Unit of Measure" = '') THEN
                TempPlanningErrorLog.SetError(
                  STRSUBSTNO(Text032,Item.TABLECAPTION,Item."No.",
                    Item.FIELDCAPTION("Base Unit of Measure")),
                  DATABASE::Item,Item.GETPOSITION);
              Item.TESTFIELD("Base Unit of Measure");
              "Indirect Cost %" := Item."Indirect Cost %";
              GetPlanningParameters.AtSKU(TempSKU,"No.","Variant Code","Location Code");
              IF Subcontracting THEN
                TempSKU."Replenishment System" := TempSKU."Replenishment System"::"Prod. Order";
              VALIDATE("Replenishment System",TempSKU."Replenishment System");
              "Accept Action Message" := TRUE;
              "Product Group Code" := Item."Product Group Code";
              GetDirectCost(FIELDNO("No."));
              IF ("Location Code" <> '') AND ("No." <> '') THEN BEGIN
                IF ("Bin Code" = '') AND ("Ref. Order Type" = "Ref. Order Type"::"Prod. Order") THEN
                  "Bin Code" := WMSManagement.GetLastOperationFromBinCode("Routing No.","Routing Version Code","Location Code",FALSE,0);
                GetLocation("Location Code");
                IF ("Bin Code" = '') AND ("Ref. Order Type" = "Ref. Order Type"::"Prod. Order") THEN
                  "Bin Code" := Location.GetBinCode(FALSE,0);
                IF ("Bin Code" = '') AND Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN
                  WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code")
              end;
            end;
        end;

        IF "Planning Line Origin" <> "Planning Line Origin"::"Order Planning" THEN
          IF ("Replenishment System" = "Replenishment System"::Purchase) AND
             (Item."Purch. Unit of Measure" <> '')
          THEN
            VALIDATE("Unit of Measure Code",Item."Purch. Unit of Measure")
          else
            VALIDATE("Unit of Measure Code",Item."Base Unit of Measure");

        CreateDim(
          DimMgt.TypeToTableID3(Type),
          "No.",DATABASE::Vendor,"Vendor No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        if "No." = '' then begin
        #6..10
          exit;
        end;

        if "No." <> xRec."No." then begin
        #15..17
        end;

        TESTFIELD(Type);
        case Type of
          Type::"G/L Account":
            begin
              GLAcc.GET("No.");
              GLAcc.CheckGLAcc;
              GLAcc.TESTFIELD("Direct Posting",true);
              Description := GLAcc.Name;
            end;
          Type::Item:
            begin
              GetItem;
              if PlanningResiliency and Item.Blocked then
        #33..35
              Item.TESTFIELD(Blocked,false);
              // << DITW110.00.11 SFI 31/08/2017 BL#30569
              Item.BlockedSKU("Location Code","Variant Code",true);
              // >> DITW110.00.11 SFI BL#30569
        #37..42
              if PlanningResiliency and (Item."Base Unit of Measure" = '') then
        #44..50
              if Subcontracting then
                TempSKU."Replenishment System" := TempSKU."Replenishment System"::"Prod. Order";
              VALIDATE("Replenishment System",TempSKU."Replenishment System");
              "Accept Action Message" := true;
              "Product Group Code" := Item."Product Group Code";
              GetDirectCost(FIELDNO("No."));
              if ("Location Code" <> '') and ("No." <> '') then begin
                if ("Bin Code" = '') and ("Ref. Order Type" = "Ref. Order Type"::"Prod. Order") then
                  "Bin Code" := WMSManagement.GetLastOperationFromBinCode("Routing No.","Routing Version Code","Location Code",false,0);
                GetLocation("Location Code");
                if ("Bin Code" = '') and ("Ref. Order Type" = "Ref. Order Type"::"Prod. Order") then
                  "Bin Code" := Location.GetBinCode(false,0);
                if ("Bin Code" = '') and Location."Bin Mandatory" and not Location."Directed Put-away and Pick" then
                  WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code");
                //<<DITW18.00.06 AKH 09/02/2015 DIT-770 #1183
                if TempSKU."Scrap %" <> 0 then
                  "Scrap %" := TempSKU."Scrap %";
                //>>DITW18.00.06 AKH 09/02/2015 DIT-770 #1183
                //<<DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
                "Indirect Cost %" := TempSKU."Indirect Cost %";
                "Overhead Rate" := TempSKU."Overhead Rate";
                //>>DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
              end;
              //<<FINXL8.00.001 BSA #178 02/06/2015
              if recFinXLSetup.READPERMISSION then
                fctGetCrossReference;
              //>>FINXL8.00.001 BSA #178 02/06/2015
            end;
        end;

        if "Planning Line Origin" <> "Planning Line Origin"::"Order Planning" then
          if ("Replenishment System" = "Replenishment System"::Purchase) and
             (Item."Purch. Unit of Measure" <> '')
          then
            VALIDATE("Unit of Measure Code",Item."Purch. Unit of Measure")
          else
        #75..79

        //<<MANXL8.00.002 ZMN 26/11/2015
        //FctCheckBlanketOrder();  //HEI.02
        //>>MANXL8.00.002 ZMN 26/11/2015
        */
        //end;


        //Unsupported feature: CodeModification on "Quantity(Field 8).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Quantity (Base)" := CalcBaseQty(Quantity);
        IF Type = Type::Item THEN BEGIN
          GetDirectCost(FIELDNO(Quantity));
          "Remaining Quantity" := Quantity - "Finished Quantity";
          "Remaining Qty. (Base)" := "Remaining Quantity" * "Qty. per Unit of Measure";

          IF (CurrFieldNo = FIELDNO(Quantity)) OR (CurrentFieldNo = FIELDNO(Quantity)) THEN
            SetActionMessage;

          "Net Quantity (Base)" := (Quantity - "Original Quantity") * "Qty. per Unit of Measure";

          VALIDATE("Unit Cost");
          IF ValidateFields THEN
            IF "Ending Date" <> 0D THEN
              VALIDATE("Ending Time")
            else BEGIN
              IF "Starting Date" = 0D THEN
                "Starting Date" := WORKDATE;
              VALIDATE("Starting Time");
            end;
          ReserveReqLine.VerifyQuantity(Rec,xRec);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        "Quantity (Base)" := CalcBaseQty(Quantity);
        if Type = Type::Item then begin
        #3..6
          if (CurrFieldNo = FIELDNO(Quantity)) or (CurrentFieldNo = FIELDNO(Quantity)) then
        #8..12
          if ValidateFields then
            if "Ending Date" <> 0D then
              VALIDATE("Ending Time")
            else begin
              if "Starting Date" = 0D then
                "Starting Date" := WORKDATE;
              VALIDATE("Starting Time");
            end;
          ReserveReqLine.VerifyQuantity(Rec,xRec);
        end;

        //<<MANXL8.00.002 ZMN 26/11/2015
        //FctCheckBlanketOrder();//HEI.02
        //>>MANXL8.00.002 ZMN 26/11/2015
        */
        //end;


        //Unsupported feature: CodeModification on ""Vendor No."(Field 9).OnLookup". Please convert manually.

        //trigger "(Field 9)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF LookupVendor(Vend) THEN
          VALIDATE("Vendor No.",Vend."No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if LookupVendor(Vend) then
          VALIDATE("Vendor No.",Vend."No.");
        */
        //end;


        //Unsupported feature: CodeModification on ""Vendor No."(Field 9).OnValidate". Please convert manually.

        //trigger "(Field 9)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckActionMessageNew;
        IF "Vendor No." <> '' THEN
          IF Vend.GET("Vendor No.") THEN BEGIN
            IF Vend.Blocked = Vend.Blocked::All THEN BEGIN
              IF PlanningResiliency THEN
                TempPlanningErrorLog.SetError(
                  STRSUBSTNO(Text031,Vend.TABLECAPTION,Vend."No."),
                  DATABASE::Vendor,Vend.GETPOSITION);
              Vend.VendBlockedErrorMessage(Vend,FALSE);
            end;
            IF "Order Date" = 0D THEN
              VALIDATE("Order Date",WORKDATE);

            VALIDATE("Currency Code",Vend."Currency Code");
            IF Type = Type::Item THEN
              UpdateDescription;
            VALIDATE(Quantity);
          end else BEGIN
            IF ValidateFields THEN
              ERROR(Text005,FIELDCAPTION("Vendor No."),"Vendor No.");
            "Vendor No." := '';
          end
        else
          UpdateDescription;

        "Order Address Code" := '';

        IF (Type = Type::Item) AND ("No." <> '') AND ("Prod. Order No." = '') THEN BEGIN
          IF ItemVend.GET("Vendor No.","No.","Variant Code") THEN BEGIN
            "Vendor Item No." := ItemVend."Vendor Item No.";
            UpdateOrderReceiptDate(ItemVend."Lead Time Calculation");
          end else BEGIN
            IF "Vendor No." = Item."Vendor No." THEN
              "Vendor Item No." := Item."Vendor Item No."
            else
              "Vendor Item No." := '';
          end;
          GetDirectCost(FIELDNO("Vendor No."))
        end;
        "Supply From" := "Vendor No.";

        CreateDim(
          DATABASE::Vendor,"Vendor No.",
          DimMgt.TypeToTableID3(Type),"No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckActionMessageNew;
        "Vendor Name" := ''; //HEI.04
        if "Vendor No." <> '' then
          if Vend.GET("Vendor No.") then begin
            "Vendor Name" := Vend.Name; //HEI.04
            if Vend.Blocked = Vend.Blocked::All then begin
              if PlanningResiliency then
        #6..8
              Vend.VendBlockedErrorMessage(Vend,false);
            end;
            if "Order Date" = 0D then
        #12..14
            if Type = Type::Item then
              UpdateDescription;
            VALIDATE(Quantity);
          end else begin
            if ValidateFields then
              ERROR(Text005,FIELDCAPTION("Vendor No."),"Vendor No.");
            "Vendor No." := '';
          end
        else
        #24..27
        if (Type = Type::Item) and ("No." <> '') and ("Prod. Order No." = '') then begin
          if ItemVend.GET("Vendor No.","No.","Variant Code") then begin
            "Vendor Item No." := ItemVend."Vendor Item No.";
            UpdateOrderReceiptDate(ItemVend."Lead Time Calculation");
            //<<FINXL8.00.001 BSA 02/06/2015 #178
            if recFinXLSetup.READPERMISSION then
              fctGetCrossReference;
            //>>FINXL8.00.001 BSA 02/06/2015 #178
          end else begin
            if "Vendor No." = Item."Vendor No." then
              "Vendor Item No." := Item."Vendor Item No."
            else
              "Vendor Item No." := '';
          end;
          GetDirectCost(FIELDNO("Vendor No."))
        end;
        #40..44

        //<<MANXL8.00.002 ZMN 26/11/2015
        //FctCheckBlanketOrder();//HEI.02
        //>>MANXL8.00.002 ZMN 26/11/2015
        */
        //end;


        //Unsupported feature: CodeModification on ""Due Date"(Field 12).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (CurrFieldNo = FIELDNO("Due Date")) OR (CurrentFieldNo = FIELDNO("Due Date")) THEN
          SetActionMessage;

        IF "Due Date" = 0D THEN
          EXIT;

        IF (CurrFieldNo = FIELDNO("Due Date")) OR (CurrentFieldNo = FIELDNO("Due Date")) THEN
          IF (Type = Type::Item) AND
             ("Planning Level" = 0)
          THEN
            VALIDATE(
              "Ending Date",
              LeadTimeMgt.PlannedEndingDate("No.","Location Code","Variant Code","Due Date",'',"Ref. Order Type"))
          else
            VALIDATE("Ending Date","Due Date");

        CheckDueDateToDemandDate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (CurrFieldNo = FIELDNO("Due Date")) or (CurrentFieldNo = FIELDNO("Due Date")) then
          SetActionMessage;

        if "Due Date" = 0D then
          exit;

        if (CurrFieldNo = FIELDNO("Due Date")) or (CurrentFieldNo = FIELDNO("Due Date")) then
          if (Type = Type::Item) and
             ("Planning Level" = 0)
          then
        #11..13
          else
        #15..17
        */
        //end;


        //Unsupported feature: CodeModification on ""Location Code"(Field 17).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateLocationChange;
        CheckActionMessageNew;
        "Bin Code" := '';
        ReserveReqLine.VerifyChange(Rec,xRec);

        IF Type = Type::Item THEN BEGIN
          GetPlanningParameters.AtSKU(TempSKU,"No.","Variant Code","Location Code");
          IF Subcontracting THEN
            TempSKU."Replenishment System" := TempSKU."Replenishment System"::"Prod. Order";
          VALIDATE("Replenishment System",TempSKU."Replenishment System");
          IF "Location Code" <> xRec."Location Code" THEN BEGIN
            IF ("Location Code" <> '') AND ("No." <> '') AND NOT IsDropShipment THEN BEGIN
              GetLocation("Location Code");
              IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN
                WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code");
            end;
            IF "Location Code" = '' THEN
              UpdateDescription;
          end;
          IF ItemVend.GET("Vendor No.","No.","Variant Code") THEN
            "Vendor Item No." := ItemVend."Vendor Item No.";
        end;
        GetDirectCost(FIELDNO("Location Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
        if Type = Type::Item then begin
          GetPlanningParameters.AtSKU(TempSKU,"No.","Variant Code","Location Code");
          if Subcontracting then
            TempSKU."Replenishment System" := TempSKU."Replenishment System"::"Prod. Order";
          VALIDATE("Replenishment System",TempSKU."Replenishment System");
          if "Location Code" <> xRec."Location Code" then begin
            if ("Location Code" <> '') and ("No." <> '') and not IsDropShipment then begin
              GetLocation("Location Code");
              if Location."Bin Mandatory" and not Location."Directed Put-away and Pick" then
                WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code");
              //<<DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
              "Indirect Cost %" := TempSKU."Indirect Cost %";
              "Overhead Rate" := TempSKU."Overhead Rate";
               //>>DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
            end;
            if "Location Code" = '' then
              UpdateDescription;
          end;
          if ItemVend.GET("Vendor No.","No.","Variant Code") then
            "Vendor Item No." := ItemVend."Vendor Item No.";
          // << DITW110.00.11 SFI 31/08/2017 BL#30569
          if (Type = Type::Item) then begin
            GetItem();
            Item.BlockedSKU("Location Code","Variant Code",true);
          end;
          // >> DITW110.00.11 SFI BL#30569
        end;
        GetDirectCost(FIELDNO("Location Code"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Order Date"(Field 21).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Starting Date" := "Order Date";

        GetDirectCost(FIELDNO("Order Date"));

        IF CurrFieldNo = FIELDNO("Order Date") THEN
          VALIDATE("Starting Date");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        if CurrFieldNo = FIELDNO("Order Date") then
          VALIDATE("Starting Date");
        */
        //end;


        //Unsupported feature: CodeModification on ""Sell-to Customer No."(Field 25).OnValidate". Please convert manually.

        //trigger "(Field 25)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Sell-to Customer No." = '' THEN
          "Ship-to Code" := ''
        else
          VALIDATE("Ship-to Code",'');

        ReserveReqLine.VerifyChange(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Sell-to Customer No." = '' then
          "Ship-to Code" := ''
        else
        #4..6
        */
        //end;


        //Unsupported feature: CodeModification on ""Ship-to Code"(Field 26).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Ship-to Code" <> '' THEN BEGIN
          ShipToAddr.GET("Sell-to Customer No.","Ship-to Code");
          "Location Code" := ShipToAddr."Location Code";
        end else BEGIN
          Cust.GET("Sell-to Customer No.");
          "Location Code" := Cust."Location Code";
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Ship-to Code" <> '' then begin
          ShipToAddr.GET("Sell-to Customer No.","Ship-to Code");
          "Location Code" := ShipToAddr."Location Code";
        end else begin
          Cust.GET("Sell-to Customer No.");
          "Location Code" := Cust."Location Code";
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Currency Code"(Field 29).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetCurrency;
        IF "Currency Code" <> '' THEN BEGIN
          TESTFIELD("Order Date");
          IF PlanningResiliency THEN
            CheckExchRate;
          VALIDATE(
            "Currency Factor",CurrExchRate.ExchangeRate(
              "Order Date","Currency Code"));
        end else
          VALIDATE("Currency Factor",0);
        GetDirectCost(FIELDNO("Currency Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetCurrency;
        if "Currency Code" <> '' then begin
          TESTFIELD("Order Date");
          if PlanningResiliency then
        #5..8
        end else
          VALIDATE("Currency Factor",0);
        GetDirectCost(FIELDNO("Currency Code"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Currency Factor"(Field 30).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Currency Code" <> '' THEN
          TESTFIELD("Currency Factor");
        IF "Currency Factor" <> xRec."Currency Factor" THEN BEGIN
          IF xRec."Currency Factor" <> 0 THEN
            "Direct Unit Cost" :=
              CurrExchRate.ExchangeAmtFCYToLCY(
                "Order Date",xRec."Currency Code","Direct Unit Cost",xRec."Currency Factor");
          IF "Currency Factor" <> 0 THEN
            "Direct Unit Cost" :=
              CurrExchRate.ExchangeAmtLCYToFCY(
                "Order Date","Currency Code","Direct Unit Cost","Currency Factor");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Currency Code" <> '' then
          TESTFIELD("Currency Factor");
        if "Currency Factor" <> xRec."Currency Factor" then begin
          if xRec."Currency Factor" <> 0 then
        #5..7
          if "Currency Factor" <> 0 then
        #9..11
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Variant Code"(Field 5402).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Variant Code" <> '' THEN
          TESTFIELD(Type,Type::Item);
        CheckActionMessageNew;
        ReserveReqLine.VerifyChange(Rec,xRec);

        CALCFIELDS("Reserved Qty. (Base)");
        TESTFIELD("Reserved Qty. (Base)",0);

        GetDirectCost(FIELDNO("Variant Code"));
        IF "Variant Code" <> '' THEN BEGIN
          UpdateDescription;
          GetPlanningParameters.AtSKU(TempSKU,"No.","Variant Code","Location Code");
          IF Subcontracting THEN
            TempSKU."Replenishment System" := TempSKU."Replenishment System"::"Prod. Order";
          VALIDATE("Replenishment System",TempSKU."Replenishment System");
          IF "Variant Code" <> xRec."Variant Code" THEN BEGIN
            "Bin Code" := '';
            IF ("Location Code" <> '') AND ("No." <> '') THEN BEGIN
              GetLocation("Location Code");
              IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN
                WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code")
            end;
          end;
          IF ItemVend.GET("Vendor No.","No.","Variant Code") THEN
            "Vendor Item No." := ItemVend."Vendor Item No.";
        end else
          VALIDATE("No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Variant Code" <> '' then
        #2..9
        if "Variant Code" <> '' then begin
          UpdateDescription;
          GetPlanningParameters.AtSKU(TempSKU,"No.","Variant Code","Location Code");
          if Subcontracting then
            TempSKU."Replenishment System" := TempSKU."Replenishment System"::"Prod. Order";
          VALIDATE("Replenishment System",TempSKU."Replenishment System");
          if "Variant Code" <> xRec."Variant Code" then begin
            "Bin Code" := '';
            if ("Location Code" <> '') and ("No." <> '') then begin
              GetLocation("Location Code");
              if Location."Bin Mandatory" and not Location."Directed Put-away and Pick" then
                WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code");
                //<<DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
                "Indirect Cost %" := TempSKU."Indirect Cost %";
                "Overhead Rate" := TempSKU."Overhead Rate";
                //>>DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
            end;
          end;
          if ItemVend.GET("Vendor No.","No.","Variant Code") then
            "Vendor Item No." := ItemVend."Vendor Item No.";
        end else
          VALIDATE("No.");
        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        if (Type = Type::Item) then begin
          GetItem();
          Item.BlockedSKU("Location Code","Variant Code",true);
        end;
        // >> DITW110.00.11 SFI BL#30569

        //<<MANXL8.00.002 ZMN 26/11/2015
         //FctCheckBlanketOrder();//HEI.02
        //>>MANXL8.00.002 ZMN 26/11/2015
        */
        //end;


        //Unsupported feature: CodeModification on ""Bin Code"(Field 5403).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckActionMessageNew;
        IF (CurrFieldNo = FIELDNO("Bin Code")) AND
           ("Action Message" <> "Action Message"::" ")
        THEN
          TESTFIELD("Action Message","Action Message"::New);
        TESTFIELD(Type,Type::Item);
        TESTFIELD("Location Code");
        IF ("Bin Code" <> xRec."Bin Code") AND ("Bin Code" <> '') THEN BEGIN
          GetLocation("Location Code");
          Location.TESTFIELD("Bin Mandatory");
          Location.TESTFIELD("Directed Put-away and Pick",FALSE);
          GetBin("Location Code","Bin Code");
          TESTFIELD("Location Code",Bin."Location Code");
        end;
        ReserveReqLine.VerifyChange(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckActionMessageNew;
        if (CurrFieldNo = FIELDNO("Bin Code")) and
           ("Action Message" <> "Action Message"::" ")
        then
        #5..7
        if ("Bin Code" <> xRec."Bin Code") and ("Bin Code" <> '') then begin
          GetLocation("Location Code");
          Location.TESTFIELD("Bin Mandatory");
          Location.TESTFIELD("Directed Put-away and Pick",false);
          GetBin("Location Code","Bin Code");
          TESTFIELD("Location Code",Bin."Location Code");
        end;
        ReserveReqLine.VerifyChange(Rec,xRec);
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Unit of Measure Code"(Field 5407).OnValidate". Please convert manually.

        //trigger (Variable: SKU)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit of Measure Code"(Field 5407).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckActionMessageNew;
        IF (Type = Type::Item) AND
           ("No." <> '') AND
           ("Prod. Order No." = '')
        THEN BEGIN
          GetItem;
          "Unit Cost" := Item."Unit Cost";
          "Overhead Rate" := Item."Overhead Rate";
          "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
          IF "Unit of Measure Code" <> '' THEN BEGIN
            "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
            "Unit Cost" := ROUND(Item."Unit Cost" * "Qty. per Unit of Measure",0.00001);
            "Overhead Rate" := ROUND(Item."Overhead Rate" * "Qty. per Unit of Measure",0.00001);
          end else
            "Qty. per Unit of Measure" := 1;
        end else
          IF "Prod. Order No." = '' THEN
            "Qty. per Unit of Measure" := 1
          else
            "Qty. per Unit of Measure" := 0;
        GetDirectCost(FIELDNO("Unit of Measure Code"));

        IF "Planning Line Origin" = "Planning Line Origin"::"Order Planning" THEN
          SetSupplyQty("Demand Quantity (Base)","Needed Quantity (Base)")
        else
          VALIDATE(Quantity);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckActionMessageNew;
        if (Type = Type::Item) and
           ("No." <> '') and
           ("Prod. Order No." = '')
        then begin
        #6..9
          if "Unit of Measure Code" <> '' then begin
            "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
            "Unit Cost" := ROUND(Item."Unit Cost" * "Qty. per Unit of Measure",0.00001);
            //<<DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
             if SKU.GET("Location Code","No.","Variant Code") then
              "Overhead Rate" := ROUND(SKU."Overhead Rate" * "Qty. per Unit of Measure",0.00001)
             else
             //>>DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
               "Overhead Rate" := ROUND(Item."Overhead Rate" * "Qty. per Unit of Measure",0.00001);
          end else
            "Qty. per Unit of Measure" := 1;
        end else
          if "Prod. Order No." = '' then
            "Qty. per Unit of Measure" := 1
          else
        #20..22
        if "Planning Line Origin" = "Planning Line Origin"::"Order Planning" then
          SetSupplyQty("Demand Quantity (Base)","Needed Quantity (Base)")
        else
          VALIDATE(Quantity);
        */
        //end;


        //Unsupported feature: CodeModification on "Reserve(Field 5540).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetItem;
        IF Item.Reserve <> Item.Reserve::Optional THEN
          TESTFIELD(Reserve,Item.Reserve = Item.Reserve::Always);
        IF Reserve AND
           ("Demand Type" = DATABASE::"Prod. Order Component") AND
           ("Demand Subtype" = ProdOrderCapNeed.Status::Planned)
        THEN
          ERROR(Text030);
        TESTFIELD("Planning Level",0);
        TESTFIELD("Planning Line Origin","Planning Line Origin"::"Order Planning");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetItem;
        if Item.Reserve <> Item.Reserve::Optional then
          TESTFIELD(Reserve,Item.Reserve = Item.Reserve::Always);
        if Reserve and
           ("Demand Type" = DATABASE::"Prod. Order Component") and
           ("Demand Subtype" = ProdOrderCapNeed.Status::Planned)
        then
        #8..10
        */
        //end;


        //Unsupported feature: CodeModification on ""Supply From"(Field 5552).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CASE "Replenishment System" OF
          "Replenishment System"::Purchase:
            IF LookupVendor(Vend) THEN
              VALIDATE("Supply From",Vend."No.");
          "Replenishment System"::Transfer:
            IF LookupFromLocation(Location) THEN
              VALIDATE("Supply From",Location.Code);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        case "Replenishment System" of
          "Replenishment System"::Purchase:
            if LookupVendor(Vend) then
              VALIDATE("Supply From",Vend."No.");
          "Replenishment System"::Transfer:
            if LookupFromLocation(Location) then
              VALIDATE("Supply From",Location.Code);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Supply From"(Field 5552).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CASE "Replenishment System" OF
          "Replenishment System"::Purchase:
            VALIDATE("Vendor No.","Supply From");
          "Replenishment System"::Transfer:
            VALIDATE("Transfer-from Code","Supply From");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        case "Replenishment System" of
        #2..5
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Routing No."(Field 99000750).OnValidate". Please convert manually.

        //trigger "(Field 99000750)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckActionMessageNew;
        "Routing Version Code" := '';

        IF "Routing No." = '' THEN
          EXIT;

        IF CurrFieldNo = FIELDNO("Starting Date") THEN
          RtngDate := "Starting Date"
        else
          RtngDate := "Ending Date";

        VALIDATE("Routing Version Code",VersionMgt.GetRtngVersion("Routing No.",RtngDate,TRUE));
        IF "Routing Version Code" = '' THEN BEGIN
          RtngHeader.GET("Routing No.");
          IF PlanningResiliency AND (RtngHeader.Status <> RtngHeader.Status::Certified) THEN
            TempPlanningErrorLog.SetError(
              STRSUBSTNO(Text033,RtngHeader.TABLECAPTION,RtngHeader.FIELDCAPTION("No."),RtngHeader."No."),
              DATABASE::"Routing Header",RtngHeader.GETPOSITION);
          RtngHeader.TESTFIELD(Status,RtngHeader.Status::Certified);
          "Routing Type" := RtngHeader.Type;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        if "Routing No." = '' then
          exit;

        if CurrFieldNo = FIELDNO("Starting Date") then
          RtngDate := "Starting Date"
        else
          RtngDate := "Ending Date";

        VALIDATE("Routing Version Code",VersionMgt.GetRtngVersion("Routing No.",RtngDate,true));
        if "Routing Version Code" = '' then begin
          RtngHeader.GET("Routing No.");
          if PlanningResiliency and (RtngHeader.Status <> RtngHeader.Status::Certified) then
        #16..20
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Operation No."(Field 99000751).OnValidate". Please convert manually.

        //trigger "(Field 99000751)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Operation No." = '' THEN
          EXIT;

        TESTFIELD(Type,Type::Item);
        TESTFIELD("Prod. Order No.");
        #6..20
        VALIDATE("Work Center No.",ProdOrderRtngLine."No.");

        VALIDATE("Direct Unit Cost",ProdOrderRtngLine."Direct Unit Cost");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Operation No." = '' then
          exit;
        #3..23
        */
        //end;


        //Unsupported feature: CodeModification on ""Planning Flexibility"(Field 99000756).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Planning Flexibility" <> xRec."Planning Flexibility" THEN
          ReserveReqLine.UpdatePlanningFlexibility(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Planning Flexibility" <> xRec."Planning Flexibility" then
          ReserveReqLine.UpdatePlanningFlexibility(Rec);
        */
        //end;


        //Unsupported feature: CodeModification on ""Production BOM Version Code"(Field 99000885).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckActionMessageNew;
        IF "Production BOM Version Code" = '' THEN
          EXIT;

        ProdBOMVersion.GET("Production BOM No.","Production BOM Version Code");
        IF PlanningResiliency AND (ProdBOMVersion.Status <> ProdBOMVersion.Status::Certified) THEN
          TempPlanningErrorLog.SetError(
            STRSUBSTNO(
              Text034,ProdBOMVersion.TABLECAPTION,
              ProdBOMVersion.FIELDCAPTION("Production BOM No."),ProdBOMVersion."Production BOM No.",
              ProdBOMVersion.FIELDCAPTION("Version Code"),ProdBOMVersion."Version Code"),
            DATABASE::"Production BOM Version",ProdBOMVersion.GETPOSITION);
        ProdBOMVersion.TESTFIELD(Status,ProdBOMVersion.Status::Certified);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckActionMessageNew;
        if "Production BOM Version Code" = '' then
          exit;

        ProdBOMVersion.GET("Production BOM No.","Production BOM Version Code");
        if PlanningResiliency and (ProdBOMVersion.Status <> ProdBOMVersion.Status::Certified) then
        #7..13
        */
        //end;


        //Unsupported feature: CodeModification on ""Routing Version Code"(Field 99000886).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckActionMessageNew;
        IF "Routing Version Code" = '' THEN
          EXIT;

        RtngVersion.GET("Routing No.","Routing Version Code");
        IF PlanningResiliency AND (RtngVersion.Status <> RtngVersion.Status::Certified) THEN
          TempPlanningErrorLog.SetError(
            STRSUBSTNO(
              Text034,RtngVersion.TABLECAPTION,
              RtngVersion.FIELDCAPTION("Routing No."),RtngVersion."Routing No.",
              RtngVersion.FIELDCAPTION("Version Code"),RtngVersion."Version Code"),
            DATABASE::"Routing Version",RtngVersion.GETPOSITION);
        RtngVersion.TESTFIELD(Status,RtngVersion.Status::Certified);
        "Routing Type" := RtngVersion.Type;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckActionMessageNew;
        if "Routing Version Code" = '' then
          exit;

        RtngVersion.GET("Routing No.","Routing Version Code");
        if PlanningResiliency and (RtngVersion.Status <> RtngVersion.Status::Certified) then
        #7..14
        */
        //end;


        //Unsupported feature: CodeModification on ""Starting Date"(Field 99000894).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Type = Type::Item THEN BEGIN
          GetWorkCenter;
          IF NOT Subcontracting THEN BEGIN
            VALIDATE("Production BOM No.");
            VALIDATE("Routing No.");
          end;
          VALIDATE("Starting Time");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Type = Type::Item then begin
          GetWorkCenter;
          if not Subcontracting then begin
            VALIDATE("Production BOM No.");
            VALIDATE("Routing No.");
          end;
          VALIDATE("Starting Time");
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Starting Time"(Field 99000895).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Type,Type::Item);
        IF ReqLine.GET("Worksheet Template Name","Journal Batch Name","Line No.") THEN
          PlngLnMgt.Recalculate(Rec,0)
        else
          CalcEndingDate('');

        CheckEndingDate(ValidateFields);
        SetDueDate;
        SetActionMessage;
        UpdateDatetime;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Type,Type::Item);
        if ReqLine.GET("Worksheet Template Name","Journal Batch Name","Line No.") then
          PlngLnMgt.Recalculate(Rec,0)
        else
        #5..10
        */
        //end;


        //Unsupported feature: CodeModification on ""Ending Date"(Field 99000896).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckEndingDate(ValidateFields);

        IF Type = Type::Item THEN BEGIN
          VALIDATE("Ending Time");
          GetWorkCenter;
          IF NOT Subcontracting THEN BEGIN
            VALIDATE("Production BOM No.");
            VALIDATE("Routing No.");
          end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckEndingDate(ValidateFields);

        if Type = Type::Item then begin
          VALIDATE("Ending Time");
          GetWorkCenter;
          if not Subcontracting then begin
            VALIDATE("Production BOM No.");
            VALIDATE("Routing No.");
          end;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Ending Time"(Field 99000897).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Type,Type::Item);
        IF ReqLine.GET("Worksheet Template Name","Journal Batch Name","Line No.") THEN
          PlngLnMgt.Recalculate(Rec,1)
        else
          CalcStartingDate('');

        IF (CurrFieldNo IN [FIELDNO("Ending Date"),FIELDNO("Ending Date-Time")]) AND (CurrentFieldNo <> FIELDNO("Due Date")) THEN
          SetDueDate;
        SetActionMessage;
        IF "Ending Time" = 0T THEN BEGIN
          MfgSetup.GET;
          "Ending Time" := MfgSetup."Normal Ending Time";
        end;
        UpdateDatetime;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Type,Type::Item);
        if ReqLine.GET("Worksheet Template Name","Journal Batch Name","Line No.") then
          PlngLnMgt.Recalculate(Rec,1)
        else
          CalcStartingDate('');

        if (CurrFieldNo in [FIELDNO("Ending Date"),FIELDNO("Ending Date-Time")]) and (CurrentFieldNo <> FIELDNO("Due Date")) then
          SetDueDate;
        SetActionMessage;
        if "Ending Time" = 000000T then begin
          MfgSetup.GET;
          "Ending Time" := MfgSetup."Normal Ending Time";
        end;
        UpdateDatetime;
        */
        //end;


        //Unsupported feature: CodeModification on ""Production BOM No."(Field 99000898).OnValidate". Please convert manually.

        //trigger "(Field 99000898)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Type,Type::Item);
        CheckActionMessageNew;
        "Production BOM Version Code" := '';
        IF "Production BOM No." = '' THEN
          EXIT;

        IF CurrFieldNo = FIELDNO("Starting Date") THEN
          BOMDate := "Starting Date"
        else
          BOMDate := "Ending Date";

        VALIDATE("Production BOM Version Code",VersionMgt.GetBOMVersion("Production BOM No.",BOMDate,TRUE));
        IF "Production BOM Version Code" = '' THEN BEGIN
          ProdBOMHeader.GET("Production BOM No.");
          IF PlanningResiliency AND (ProdBOMHeader.Status <> ProdBOMHeader.Status::Certified) THEN
            TempPlanningErrorLog.SetError(
              STRSUBSTNO(
                Text033,
                ProdBOMHeader.TABLECAPTION,
                ProdBOMHeader.FIELDCAPTION("No."),ProdBOMHeader."No."),
              DATABASE::"Production BOM Header",ProdBOMHeader.GETPOSITION);

          ProdBOMHeader.TESTFIELD(Status,ProdBOMHeader.Status::Certified);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        if "Production BOM No." = '' then
          exit;

        if CurrFieldNo = FIELDNO("Starting Date") then
          BOMDate := "Starting Date"
        else
          BOMDate := "Ending Date";

        VALIDATE("Production BOM Version Code",VersionMgt.GetBOMVersion("Production BOM No.",BOMDate,true));
        if "Production BOM Version Code" = '' then begin
          ProdBOMHeader.GET("Production BOM No.");
          if PlanningResiliency and (ProdBOMHeader.Status <> ProdBOMHeader.Status::Certified) then
        #16..23
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit Cost"(Field 99000901).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Type,Type::Item);
        TESTFIELD("No.");

        Item.GET("No.");
        IF Item."Costing Method" = Item."Costing Method"::Standard THEN BEGIN
          IF CurrFieldNo = FIELDNO("Unit Cost") THEN
            ERROR(
              Text006,
              FIELDCAPTION("Unit Cost"),Item.FIELDCAPTION("Costing Method"),Item."Costing Method");
          "Unit Cost" := Item."Unit Cost" * "Qty. per Unit of Measure";
        end;
        "Cost Amount" := ROUND("Unit Cost" * Quantity);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        if Item."Costing Method" = Item."Costing Method"::Standard then begin
          if CurrFieldNo = FIELDNO("Unit Cost") then
        #7..10
        end;
        "Cost Amount" := ROUND("Unit Cost" * Quantity);
        */
        //end;


        //Unsupported feature: CodeModification on ""Replenishment System"(Field 99000903).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Type,Type::Item);
        CheckActionMessageNew;
        IF ValidateFields AND
           ("Replenishment System" = xRec."Replenishment System") AND
           ("No." = xRec."No.") AND
           ("Location Code" = xRec."Location Code") AND
           ("Variant Code" = xRec."Variant Code")
        THEN
          EXIT;

        TESTFIELD(Type,Type::Item);
        TESTFIELD("No.");
        GetItem;
        GetPlanningParameters.AtSKU(TempSKU,"No.","Variant Code","Location Code");
        IF Subcontracting THEN
          TempSKU."Replenishment System" := TempSKU."Replenishment System"::"Prod. Order";

        "Supply From" := '';

        CASE "Replenishment System" OF
          "Replenishment System"::Purchase:
            BEGIN
              "Ref. Order Type" := "Ref. Order Type"::Purchase;
              CLEAR("Ref. Order Status");
              "Ref. Order No." := '';
              DeleteRelations;
              VALIDATE("Production BOM No.",'');
              VALIDATE("Routing No.",'');
              IF Item."Purch. Unit of Measure" <> '' THEN
                VALIDATE("Unit of Measure Code",Item."Purch. Unit of Measure");
              VALIDATE("Transfer-from Code",'');
              IF CurrFieldNo = FIELDNO("Location Code") THEN
                VALIDATE("Vendor No.")
              else
                VALIDATE("Vendor No.",TempSKU."Vendor No.");
            end;
          "Replenishment System"::"Prod. Order":
            BEGIN
              IF ReqWkshTmpl.GET("Worksheet Template Name") AND (ReqWkshTmpl.Type = ReqWkshTmpl.Type::"Req.") AND
                 (ReqWkshTmpl.Name <> '') AND NOT SourceDropShipment
              THEN
                ERROR(ReplenishmentErr);
              IF PlanningResiliency AND (Item."Base Unit of Measure" = '') THEN
                TempPlanningErrorLog.SetError(
                  STRSUBSTNO(
                    Text032,Item.TABLECAPTION,Item."No.",
                    Item.FIELDCAPTION("Base Unit of Measure")),
                  DATABASE::Item,Item.GETPOSITION);
              Item.TESTFIELD("Base Unit of Measure");
              IF "Ref. Order No." = '' THEN BEGIN
                "Ref. Order Type" := "Ref. Order Type"::"Prod. Order";
                "Ref. Order Status" := "Ref. Order Status"::Planned;

                MfgSetup.GET;
                IF PlanningResiliency AND (MfgSetup."Planned Order Nos." = '') THEN
                  TempPlanningErrorLog.SetError(
                    STRSUBSTNO(Text032,MfgSetup.TABLECAPTION,'',
                      MfgSetup.FIELDCAPTION("Planned Order Nos.")),
                    DATABASE::"Manufacturing Setup",MfgSetup.GETPOSITION);
                MfgSetup.TESTFIELD("Planned Order Nos.");

                IF PlanningResiliency THEN
                  CheckNoSeries(MfgSetup."Planned Order Nos.","Due Date");
                IF NOT Subcontracting THEN
                  NoSeriesMgt.InitSeries(
                    MfgSetup."Planned Order Nos.",xRec."No. Series","Due Date","Ref. Order No.","No. Series");
              end;
              VALIDATE("Vendor No.",'');

              IF NOT Subcontracting THEN BEGIN
                VALIDATE("Production BOM No.",Item."Production BOM No.");
                VALIDATE("Routing No.",Item."Routing No.");
              end else BEGIN
                "Production BOM No." := Item."Production BOM No.";
                "Routing No." := Item."Routing No.";
              end;
              VALIDATE("Transfer-from Code",'');
              VALIDATE("Unit of Measure Code",Item."Base Unit of Measure");

              IF ("Planning Line Origin" = "Planning Line Origin"::"Order Planning") AND
                 ValidateFields
              THEN
                PlngLnMgt.Calculate(Rec,1,TRUE,TRUE,0);
            end;
          "Replenishment System"::Assembly:
            BEGIN
              IF PlanningResiliency AND (Item."Base Unit of Measure" = '') THEN
                TempPlanningErrorLog.SetError(
                  STRSUBSTNO(
                    Text032,Item.TABLECAPTION,Item."No.",
                    Item.FIELDCAPTION("Base Unit of Measure")),
                  DATABASE::Item,Item.GETPOSITION);
              Item.TESTFIELD("Base Unit of Measure");
              IF "Ref. Order No." = '' THEN BEGIN
                "Ref. Order Type" := "Ref. Order Type"::Assembly;
                "Ref. Order Status" := AsmHeader."Document Type"::Order;
              end;
              VALIDATE("Vendor No.",'');
              VALIDATE("Production BOM No.",'');
              VALIDATE("Routing No.",'');
              VALIDATE("Transfer-from Code",'');
              VALIDATE("Unit of Measure Code",Item."Base Unit of Measure");

              IF ("Planning Line Origin" = "Planning Line Origin"::"Order Planning") AND
                 ValidateFields
              THEN
                PlngLnMgt.Calculate(Rec,1,TRUE,TRUE,0);
            end;
          "Replenishment System"::Transfer:
            BEGIN
              "Ref. Order Type" := "Ref. Order Type"::Transfer;
              CLEAR("Ref. Order Status");
              "Ref. Order No." := '';
              DeleteRelations;
              VALIDATE("Vendor No.",'');
              VALIDATE("Production BOM No.",'');
              VALIDATE("Routing No.",'');
              VALIDATE("Transfer-from Code",TempSKU."Transfer-from Code");
              VALIDATE("Unit of Measure Code",Item."Base Unit of Measure");
            end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Type,Type::Item);
        CheckActionMessageNew;
        if ValidateFields and
           ("Replenishment System" = xRec."Replenishment System") and
           ("No." = xRec."No.") and
           ("Location Code" = xRec."Location Code") and
           ("Variant Code" = xRec."Variant Code")
        then
          exit;
        #10..14
        if Subcontracting then
        #16..19
        case "Replenishment System" of
          "Replenishment System"::Purchase:
            begin
        #23..28
              if Item."Purch. Unit of Measure" <> '' then
                VALIDATE("Unit of Measure Code",Item."Purch. Unit of Measure");
              VALIDATE("Transfer-from Code",'');
              if CurrFieldNo = FIELDNO("Location Code") then
                VALIDATE("Vendor No.")
              else
                VALIDATE("Vendor No.",TempSKU."Vendor No.");
            end;
          "Replenishment System"::"Prod. Order":
            begin
              if ReqWkshTmpl.GET("Worksheet Template Name") and (ReqWkshTmpl.Type = ReqWkshTmpl.Type::"Req.") and
                 (ReqWkshTmpl.Name <> '') and not SourceDropShipment
              then
                ERROR(ReplenishmentErr);
              if PlanningResiliency and (Item."Base Unit of Measure" = '') then
        #44..49
              if "Ref. Order No." = '' then begin
        #51..54
                if PlanningResiliency and (MfgSetup."Planned Order Nos." = '') then
        #56..61
                if PlanningResiliency then
                  CheckNoSeries(MfgSetup."Planned Order Nos.","Due Date");
                if not Subcontracting then
                  NoSeriesMgt.InitSeries(
                    MfgSetup."Planned Order Nos.",xRec."No. Series","Due Date","Ref. Order No.","No. Series");
              end;
              VALIDATE("Vendor No.",'');

              if not Subcontracting then begin
                //<<DITW18.00.06 AKH 09/02/2015 DIT-770 #1183
                //VALIDATE("Production BOM No.",Item."Production BOM No.");
                //VALIDATE("Routing No.",Item."Routing No.");
                VALIDATE("Production BOM No.",TempSKU."Production BOM No.");
                VALIDATE("Routing No.",TempSKU."Routing No.");
                //>>DITW18.00.06 AKH 09/02/2015 DIT-770 #1183
              end else begin
                //<<DITW18.00.06 AKH 09/02/2015 DIT-770 #1183
                //"Production BOM No." := Item."Production BOM No.";
                //"Routing No." := Item."Routing No.";
                "Production BOM No." := TempSKU."Production BOM No.";
                "Routing No." := TempSKU."Routing No.";
                //>>DITW18.00.06 AKH 09/02/2015 DIT-770 #1183
              end;
        #77..79
              if ("Planning Line Origin" = "Planning Line Origin"::"Order Planning") and
                 ValidateFields
              then
                PlngLnMgt.Calculate(Rec,1,true,true,0);
            end;
          "Replenishment System"::Assembly:
            begin
              if PlanningResiliency and (Item."Base Unit of Measure" = '') then
        #88..93
              if "Ref. Order No." = '' then begin
                "Ref. Order Type" := "Ref. Order Type"::Assembly;
                "Ref. Order Status" := AsmHeader."Document Type"::Order;
              end;
        #98..103
              if ("Planning Line Origin" = "Planning Line Origin"::"Order Planning") and
                 ValidateFields
              then
                PlngLnMgt.Calculate(Rec,1,true,true,0);
            end;
          "Replenishment System"::Transfer:
            begin
        #111..119
            end;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Ref. Order No."(Field 99000904).OnLookup". Please convert manually.

        //trigger  Order No();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CASE "Ref. Order Type" OF
          "Ref. Order Type"::Purchase:
            IF PurchHeader.GET(PurchHeader."Document Type"::Order,"Ref. Order No.") THEN
              PAGE.RUN(PAGE::"Purchase Order",PurchHeader)
            else
              MESSAGE(Text007,PurchHeader.TABLECAPTION);
          "Ref. Order Type"::"Prod. Order":
            IF ProdOrder.GET("Ref. Order Status","Ref. Order No.") THEN
              CASE ProdOrder.Status OF
                ProdOrder.Status::Planned:
                  PAGE.RUN(PAGE::"Planned Production Order",ProdOrder);
                ProdOrder.Status::"Firm Planned":
                  PAGE.RUN(PAGE::"Firm Planned Prod. Order",ProdOrder);
                ProdOrder.Status::Released:
                  PAGE.RUN(PAGE::"Released Production Order",ProdOrder);
              end
            else
              MESSAGE(Text007,ProdOrder.TABLECAPTION);
          "Ref. Order Type"::Transfer:
            IF TransHeader.GET("Ref. Order No.") THEN
              PAGE.RUN(PAGE::"Transfer Order",TransHeader)
            else
              MESSAGE(Text007,TransHeader.TABLECAPTION);
          "Ref. Order Type"::Assembly:
            IF AsmHeader.GET("Ref. Order Status","Ref. Order No.") THEN
              PAGE.RUN(PAGE::"Assembly Order",AsmHeader)
            else
              MESSAGE(Text007,AsmHeader.TABLECAPTION);
          else
            MESSAGE(Text008);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        case "Ref. Order Type" of
          "Ref. Order Type"::Purchase:
            if PurchHeader.GET(PurchHeader."Document Type"::Order,"Ref. Order No.") then
              PAGE.RUN(PAGE::"Purchase Order",PurchHeader)
            else
              MESSAGE(Text007,PurchHeader.TABLECAPTION);
          "Ref. Order Type"::"Prod. Order":
            if ProdOrder.GET("Ref. Order Status","Ref. Order No.") then
              case ProdOrder.Status of
        #10..15
              end
            else
              MESSAGE(Text007,ProdOrder.TABLECAPTION);
          "Ref. Order Type"::Transfer:
            if TransHeader.GET("Ref. Order No.") then
              PAGE.RUN(PAGE::"Transfer Order",TransHeader)
            else
              MESSAGE(Text007,TransHeader.TABLECAPTION);
          "Ref. Order Type"::Assembly:
            if AsmHeader.GET("Ref. Order Status","Ref. Order No.") then
              PAGE.RUN(PAGE::"Assembly Order",AsmHeader)
            else
              MESSAGE(Text007,AsmHeader.TABLECAPTION);
          else
            MESSAGE(Text008);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Action Message"(Field 99000916).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Action Message" = xRec."Action Message") OR
           (("Action Message" IN ["Action Message"::" ","Action Message"::New]) AND
            (xRec."Action Message" IN ["Action Message"::" ","Action Message"::New]))
        THEN
          EXIT;
        TESTFIELD("Action Message",xRec."Action Message");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Action Message" = xRec."Action Message") or
           (("Action Message" in ["Action Message"::" ","Action Message"::New]) and
            (xRec."Action Message" in ["Action Message"::" ","Action Message"::New]))
        then
          exit;
        TESTFIELD("Action Message",xRec."Action Message");
        */
        //end;


        //Unsupported feature: CodeModification on ""Accept Action Message"(Field 99000917).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Action Message" = "Action Message"::" " THEN
          VALIDATE("Action Message","Action Message"::New);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Action Message" = "Action Message"::" " then
          VALIDATE("Action Message","Action Message"::New);
        */
        //end;
        field(50000; "SRM Contract No. FND"; Code[10])
        {
            // CalcFormula = Lookup("Purchase Line"."SRM Contract No." where("Document No." = FIELD("Blanket Order No."),
            //  "Line No." = FIELD("Blanket Order Line No.")));  // BC Upgrade NANDIS03 - Bloced DIT fields
            caption = 'SRM Contract No.';
            Description = 'HEI.02';
            FieldClass = FlowField;
        }
        field(50001; "SRM Contract Line No. FND"; Code[10])
        {
            // CalcFormula = Lookup("Purchase Line"."SRM Contract Line No." where("Document No." = FIELD("Blanket Order No."),
            //  "Line No." = FIELD("Blanket Order Line No.")));  // BC Upgrade NANDIS03 - Bloced DIT fields
            caption = 'SRM Contract Line No.';
            Description = 'HEI.02';
            FieldClass = FlowField;
        }
        field(50002; "Vendor Name FND"; Text[50])
        {
            caption = 'Vendor Name';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            Editable = false;
        }
        //BC Upgrade kamnay01 >> Added new field for Production Unit of Measure
        field(50003; "Production Unit of Measure FND"; Code[10])
        {
            caption = 'Production Unit of Measure';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        //BC Upgrade kamnay01 << Added new field for Production Unit of Measure
        // field(2014080;"Minimum Order Quantity";Decimal)
        // {
        //     Caption = 'Minimum Order Quantity';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.10 BL#15657';
        //     Editable = false;
        //     MinValue = 0;
        // }
        // field(2014081;"Safety Stock Quantity";Decimal)
        // {
        //     AccessByPermission = TableData "Req. Wksh. Template"=R;
        //     Caption = 'Safety Stock Quantity';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.10 BL#15657';
        //     Editable = false;
        //     MinValue = 0;
        // }
        // field(2014082;"Order Multiple";Decimal)
        // {
        //     AccessByPermission = TableData "Req. Wksh. Template"=R;
        //     Caption = 'Order Multiple';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.10 BL#15657';
        //     Editable = false;
        //     MinValue = 0;
        // }
        // field(2014083;Inventory;Decimal)
        // {
        //     CalcFormula = Sum("Item Ledger Entry".Quantity WHERE ("Item No."=FIELD("No."),
        //                                                           "Location Code"=FIELD("Location Code"),
        //                                                           "Variant Code"=FIELD("Variant Code")));
        //     Caption = 'Inventory';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.10 BL#15657';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014084;"Qty. on Purch. Order";Decimal)
        // {
        //     AccessByPermission = TableData "Purch. Rcpt. Header"=R;
        //     CalcFormula = Sum("Purchase Line"."Outstanding Qty. (Base)" WHERE ("Document Type"=CONST(Order),
        //                                                                        Type=CONST(Item),
        //                                                                        "No."=FIELD("No."),
        //                                                                        "Location Code"=FIELD("Location Code"),
        //                                                                        "Variant Code"=FIELD("Variant Code")));
        //     Caption = 'Qty. on Purch. Order';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.10 BL#15657';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014085;"Qty. on Sales Order";Decimal)
        // {
        //     AccessByPermission = TableData "Sales Shipment Header"=R;
        //     CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" WHERE ("Document Type"=CONST(Order),
        //                                                                     Type=CONST(Item),
        //                                                                     "No."=FIELD("No."),
        //                                                                     "Location Code"=FIELD("Location Code"),
        //                                                                     "Variant Code"=FIELD("Variant Code")));
        //     Caption = 'Qty. on Sales Order';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.10 BL#15657';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014086;"Qty. on Assembly Order";Decimal)
        // {
        //     CalcFormula = Sum("Assembly Header"."Remaining Quantity (Base)" WHERE ("Document Type"=CONST(Order),
        //                                                                            "Item No."=FIELD("No."),
        //                                                                            "Location Code"=FIELD("Location Code"),
        //                                                                            "Variant Code"=FIELD("Variant Code")));
        //     Caption = 'Qty. on Assembly Order';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.10 BL#15657';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014087;"Qty. on Asm. Component";Decimal)
        // {
        //     CalcFormula = Sum("Assembly Line"."Remaining Quantity (Base)" WHERE ("Document Type"=CONST(Order),
        //                                                                          Type=CONST(Item),
        //                                                                          "No."=FIELD("No."),
        //                                                                          "Location Code"=FIELD("Location Code"),
        //                                                                          "Variant Code"=FIELD("Variant Code")));
        //     Caption = 'Qty. on Asm. Component';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.10 BL#15657';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014088;"Qty. on Job Order";Decimal)
        // {
        //     CalcFormula = Sum("Job Planning Line"."Remaining Qty. (Base)" WHERE (Status=CONST(Order),
        //                                                                          Type=CONST(Item),
        //                                                                          "No."=FIELD("No."),
        //                                                                          "Location Code"=FIELD("Location Code"),
        //                                                                          "Variant Code"=FIELD("Variant Code")));
        //     Caption = 'Qty. on Job Order';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.10 BL#15657';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014089;"Qty. in Transit";Decimal)
        // {
        //     CalcFormula = Sum("Transfer Line"."Qty. in Transit (Base)" WHERE ("Derived From Line No."=CONST(0),
        //                                                                       "Item No."=FIELD("No."),
        //                                                                       "Transfer-to Code"=FIELD("Location Code"),
        //                                                                       "Variant Code"=FIELD("Variant Code")));
        //     Caption = 'Qty. in Transit';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.10 BL#15657';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014090;"Qty. on Service Order";Decimal)
        // {
        //     CalcFormula = Sum("Service Line"."Outstanding Qty. (Base)" WHERE ("Document Type"=CONST(Order),
        //                                                                       Type=CONST(Item),
        //                                                                       "No."=FIELD("No."),
        //                                                                       "Location Code"=FIELD("Location Code"),
        //                                                                       "Variant Code"=FIELD("Variant Code")));
        //     Caption = 'Qty. on Service Order';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.10 BL#15657';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014091;"Qty. on Sales Blanket Order";Decimal)
        // {
        //     AccessByPermission = TableData "Sales Shipment Header"=R;
        //     CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" WHERE ("Document Type"=CONST("Blanket Order"),
        //                                                                     Type=CONST(Item),
        //                                                                     "No."=FIELD("No."),
        //                                                                     "Location Code"=FIELD("Location Code"),
        //                                                                     "Variant Code"=FIELD("Variant Code")));
        //     Caption = 'Qty. on Sales Blanket Order';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.10 BL#15657';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014092;"Proposed Qty.";Decimal)
        // {
        //     Caption = 'Proposed Qty.';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.10 BL#15657';
        //     Editable = false;
        // }
        // field(2029610;"Cross-Reference No.";Code[20])
        // {
        //     CaptionML = ENU='Cross-Reference No.',
        //                 FRA='Référence externe';
        //     Description = 'FINXL8.00.001';

        //     trigger OnLookup();
        //     begin
        //         //<<FINXL8.00.001 BSA 02/06/2015 #178
        //         if recFinXLSetup.READPERMISSION then
        //           fctLookupCrossReference();
        //         //>>FINXL8.00.001 BSA 02/06/2015 #178
        //     end;

        //     trigger OnValidate();
        //     begin
        //         //<<FINXL8.00.001 BSA 02/06/2015 #178
        //         if recFinXLSetup.READPERMISSION then
        //           fctValidateCrossReference();
        //         //>>FINXL8.00.001 BSA 02/06/2015 #178
        //     end;
        // }
        // field(2029611;Emergency;Boolean)
        // {
        //     CaptionML = ENU='Emergency',
        //                 FRA='Urgence';
        //     Description = 'FINXL8.00.001';
        // }
        // field(2036301;"Blanket Order No.";Code[20])
        // {
        //     CaptionML = ENU='Blanket Order No.',
        //                 FRA='N° commande ouverte';
        //     Description = 'MANXL7.00.001';
        //     TableRelation = "Purchase Line"."Document No." WHERE ("Document Type"=CONST("Blanket Order"),
        //                                                           "No."=FIELD("No."),
        //                                                           "Buy-from Vendor No."=FIELD("Vendor No."));
        //     //This property is currently not supported
        //     //TestTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         if "Blanket Order No." = '' then
        //               VALIDATE("Blanket Order Line No." , 0 )
        //     end;
        // }
        // field(2036302;"Blanket Order Line No.";Integer)
        // {
        //     CaptionML = ENU='Blanket Order Line No.',
        //                 FRA='N° ligne cde ouverte';
        //     Description = 'MANXL7.00.001';
        //     TableRelation = "Purchase Line"."Line No." WHERE ("Document Type"=CONST("Blanket Order"),
        //                                                       "Document No."=FIELD("Blanket Order No."),
        //                                                       Type=FIELD(Type),
        //                                                       "No."=FIELD("No."),
        //                                                       "Location Code"=FIELD("Location Code"),
        //                                                       "Variant Code"=FIELD("Variant Code"));
        //     //This property is currently not supported
        //     //TestTableRelation = false;

        //     trigger OnValidate();
        //     var
        //         ldecQuantityonBlanketOrder : Decimal;
        //         ldecQuantityonPurchaseOrder : Decimal;
        //         lrecPurchaseLine : Record "Purchase Line";
        //         text2031004 : TextConst ENU='You cannot modify the quantity to more than %1 because the line is linked to a blanket purchase order line',FRA='Vous ne pouvez pas changer la quantité à plus de %1  car la ligne est attachée à une ligne commande ouverte';
        //         lrecNormalPurchaseLine : Record "Purchase Line";
        //         PurchaseHeader : Record "Purchase Header";
        //     begin
        //         //<<FINXL8.00.001 BSA 20/07/2015
        //         if "Blanket Order No." <> '' then begin
        //           if lrecPurchaseLine.GET(lrecPurchaseLine."Document Type"::"Blanket Order","Blanket Order No.","Blanket Order Line No.") then begin
        //             ldecQuantityonBlanketOrder := lrecPurchaseLine."Outstanding Quantity";
        //             lrecNormalPurchaseLine.RESET;
        //             lrecNormalPurchaseLine.SETRANGE("Blanket Order No.",lrecPurchaseLine."Document No.");
        //             lrecNormalPurchaseLine.SETRANGE("Blanket Order Line No.",lrecPurchaseLine."Line No.");
        //             if lrecNormalPurchaseLine.findset then repeat
        //               ldecQuantityonPurchaseOrder += lrecNormalPurchaseLine."Outstanding Quantity";
        //             until lrecNormalPurchaseLine.NEXT=0;
        //             //HEI.04>>
        //             PurchaseHeader.GET(lrecPurchaseLine."Document Type"::"Blanket Order","Blanket Order No.");
        //             VALIDATE("Currency Code",PurchaseHeader."Currency Code");
        //             //HEI.04<<
        //           end;
        //           if  Quantity > (ldecQuantityonBlanketOrder - ldecQuantityonPurchaseOrder) then
        //             ERROR(text2031004,(ldecQuantityonBlanketOrder - ldecQuantityonPurchaseOrder));
        //         end;
        //         //>>FINXL8.00.001 BSA 20/07/2015
        //     end;
        // }
        // field(2036303;"Qty. On Purchase Order BO";Decimal)
        // {
        //     CalcFormula = Sum("Purchase Line"."Outstanding Quantity" WHERE ("Document Type"=CONST(Order),
        //                                                                     "Blanket Order No."=FIELD("Blanket Order No."),
        //                                                                     "Blanket Order Line No."=FIELD("Blanket Order Line No.")));
        //     CaptionML = ENU='Quantity On Purchase Order',
        //                 FRA='Qté sur commande achat';
        //     DecimalPlaces = 0:5;
        //     Description = 'MANXL7.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2036304;"Qty. To Invoice BO";Decimal)
        // {
        //     CalcFormula = Sum("Purchase Line"."Qty. Rcd. Not Invoiced" WHERE ("Document Type"=CONST(Order),
        //                                                                       "Blanket Order No."=FIELD("Blanket Order No."),
        //                                                                       "Blanket Order Line No."=FIELD("Blanket Order Line No.")));
        //     CaptionML = ENU='Qty. to Invoice',
        //                 FRA='Qté à facturer';
        //     DecimalPlaces = 0:5;
        //     Description = 'MANXL7.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2036305;"Qty. Planned BO";Decimal)
        // {
        //     CalcFormula = Sum("Requisition Line".Quantity WHERE ("Blanket Order No."=FIELD("Blanket Order No."),
        //                                                          "Blanket Order Line No."=FIELD("Blanket Order Line No."),
        //                                                          "Action Message"=CONST(New)));
        //     CaptionML = ENU='Quantity Planned',
        //                 FRA='Qté planifiée';
        //     DecimalPlaces = 0:5;
        //     Description = 'MANXL7.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2036306;"Blanket order Exist";Boolean)
        // {
        //     CaptionML = ENU='Blanket order Exist',
        //                 FRA='Commande ouverte existe';
        //     Description = 'MANXL8.00.002';
        // }  // BC Upgrade NANDIS03 - Bloced DIT fields
    }
    keys
    {
        // key(Key1;"Action Message","Blanket Order No.","Blanket Order Line No.")
        // {
        //     SumIndexFields = Quantity;
        // }  // BC Upgrade NANDIS03 - Bloced DIT fields
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ReqLine.RESET;
    ReqLine.GET("Worksheet Template Name","Journal Batch Name","Line No.");
    WHILE (ReqLine.NEXT <> 0) AND (ReqLine.Level > Level) DO
      ReqLine.DELETE(TRUE);

    ReserveReqLine.DeleteLine(Rec);

    CALCFIELDS("Reserved Qty. (Base)");
    TESTFIELD("Reserved Qty. (Base)",0);

    DeleteRelations;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ReqLine.RESET;
    ReqLine.GET("Worksheet Template Name","Journal Batch Name","Line No.");
    while (ReqLine.NEXT <> 0) and (ReqLine.Level > Level) do
      ReqLine.DELETE(true);
    #5..11
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF CURRENTKEY <> Rec2.CURRENTKEY THEN BEGIN
      Rec2 := Rec;
      Rec2.SETRECFILTER;
      Rec2.SETRANGE("Line No.");
      IF Rec2.FINDLAST THEN
        "Line No." := Rec2."Line No." + 10000;
    end;

    ReserveReqLine.VerifyQuantity(Rec,xRec);

    ReqWkshTmpl.GET("Worksheet Template Name");
    ReqWkshName.GET("Worksheet Template Name","Journal Batch Name");

    ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
    ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if CURRENTKEY <> Rec2.CURRENTKEY then begin
    #2..4
      if Rec2.FINDLAST then
        "Line No." := Rec2."Line No." + 10000;
    end;
    #8..15
    //<<MANXL7.00.001 WSA 11/07/2014 #87
    if rMANXLSetup.READPERMISSION then
    //>>MANXL7.00.001 WSA 11/07/2014 #87
      VALIDATE("Requester ID",USERID);  //MANXL7.00.001 DAT 05/03/2014 #18
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        SKU: Record "Stockkeeping Unit";


    //Unsupported feature: PropertyModification on "Text004(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=You cannot rename a %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=You cannot rename a %1.;FRA=Vous ne pouvez pas renommer l'enregistrement %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=%1 %2 does not exist.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=%1 %2 does not exist.;FRA=%1 %2 n'existe pas.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=You cannot change %1 when %2 is %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=You cannot change %1 when %2 is %3.;FRA=Vous ne pouvez pas modifier %1 si %2 est %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=There is no %1 for this line.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=There is no %1 for this line.;FRA=Il n'existe pas d'%1 pour cette ligne.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=There is no replenishment order for this line.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=There is no replenishment order for this line.;FRA=Il n'existe pas d'ordre de réappro. pour cette ligne.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text028(Variable 1055)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text028 : ENU=The %1 on this %2 must match the %1 on the sales order line it is associated with.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text028 : ENU=The %1 on this %2 must match the %1 on the sales order line it is associated with.;FRA=La valeur %1 de cet enregistrement %2 doit correspondre à la valeur %1 de la ligne commande vente associée.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text029(Variable 1036)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text029 : ENU=Line %1 has a %2 that exceeds the %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text029 : ENU=Line %1 has a %2 that exceeds the %3.;FRA=La ligne %1 comporte un/une %2 qui dépasse l'/le/la %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text030(Variable 1037)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text030 : ENU=You cannot reserve components with status Planned.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text030 : ENU=You cannot reserve components with status Planned.;FRA=Vous ne pouvez pas réserver de composants qui ont le statut Planifié.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text031(Variable 1059)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text031 : ENU=%1 %2 is blocked.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text031 : ENU=%1 %2 is blocked.;FRA=%1 %2 est bloqué(e).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text032(Variable 1060)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text032 : ENU=%1 %2 has no %3 defined.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text032 : ENU=%1 %2 has no %3 defined.;FRA=%1 %2 : %3 non défini(e).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text033(Variable 1068)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text033 : ENU=%1 %2 %3 is not certified.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text033 : ENU=%1 %2 %3 is not certified.;FRA=%1 %2 %3 n'est pas validé(e).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text034(Variable 1053)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text034 : ENU=%1 %2 %3 %4 %5 is not certified.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text034 : ENU=%1 %2 %3 %4 %5 is not certified.;FRA=%1 %2 %3 %4 %5 n'est pas validé(e).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text035(Variable 1071)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text035 : ENU=%1 %2 %3 specified on %4 %5 does not exist.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text035 : ENU=%1 %2 %3 specified on %4 %5 does not exist.;FRA=%1 %2 %3 indiqué(e) sur %4 %5 n'existe pas.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text036(Variable 1072)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text036 : ENU=%1 %2 %3 does not allow default numbering.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text036 : ENU=%1 %2 %3 does not allow default numbering.;FRA=%1 %2 %3 ne permet pas la numérotation par défaut.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text037(Variable 1065)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text037 : ENU=The currency exchange rate for the %1 %2 that vendor %3 uses on the order date %4, does not have an %5 specified.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text037 : ENU=The currency exchange rate for the %1 %2 that vendor %3 uses on the order date %4, does not have an %5 specified.;FRA=%5 non défini(e) pour le taux de change devise de %1 %2 que le fournisseur %3 utilise à la date de commande (%4).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text038(Variable 1067)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text038 : ENU=The currency exchange rate for the %1 %2 that vendor %3 uses on the order date %4, does not exist.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text038 : ENU=The currency exchange rate for the %1 %2 that vendor %3 uses on the order date %4, does not exist.;FRA=Le taux de change devise de %1 %2 que le fournisseur %3 utilise à la date de commande (%4) n'existe pas.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text039(Variable 1066)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text039 : ENU=You cannot assign new numbers from the number series %1 on %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text039 : ENU=You cannot assign new numbers from the number series %1 on %2.;FRA=Vous ne pouvez pas attribuer de nouveaux numéros à partir de la souche de numéros %1 dans %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text040(Variable 1064)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text040 : ENU=You cannot assign new numbers from the number series %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text040 : ENU=You cannot assign new numbers from the number series %1.;FRA=Vous ne pouvez pas attribuer de nouveaux numéros à partir de la souche de numéros %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text041(Variable 1062)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text041 : ENU=You cannot assign new numbers from the number series %1 on a date before %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text041 : ENU=You cannot assign new numbers from the number series %1 on a date before %2.;FRA=Vous ne pouvez pas attribuer de nouveaux numéros à partir de la souche de numéros %1 pour une date antérieure au %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text042(Variable 1054)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text042 : ENU=You cannot assign new numbers from the number series %1 line %2 because the %3 is not defined.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text042 : ENU=You cannot assign new numbers from the number series %1 line %2 because the %3 is not defined.;FRA=Vous ne pouvez pas attribuer de nouveaux numéros à partir de la souche de numéros %1 ligne %2 car le/la %3 n'est pas défini(e).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text043(Variable 1061)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text043 : ENU=The number %1 on number series %2 cannot be extended to more than 20 characters.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text043 : ENU=The number %1 on number series %2 cannot be extended to more than 20 characters.;FRA=Le numéro %1 de la souche de numéros %2 ne peut pas être étendu à plus de 20 caractères.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text044(Variable 1069)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text044 : ENU=You cannot assign numbers greater than %1 from the number series %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text044 : ENU=You cannot assign numbers greater than %1 from the number series %2.;FRA=Vous ne pouvez pas attribuer de numéros supérieurs à %1 à partir de la souche de numéros %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ReplenishmentErr(Variable 1073)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ReplenishmentErr : ENU=Requisition Worksheet cannot be used to create Prod. Order replenishment.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ReplenishmentErr : ENU=Requisition Worksheet cannot be used to create Prod. Order replenishment.;FRA=Une demande achat ne peut pas être utilisée pour créer un réapprovisionnement O.F.;
    //Variable type has not been exported.

    var
        Text003: TextConst ENU = 'Change %1 from %2 to %3?', FRA = 'Remplacer %2 par %3 dans le champ %1 ?';

    var
        RecPurchaseBlacketOrderLine: Record "Purchase Line";
        RecPurchaseOrderLine: Record "Purchase Line";
        // rMANXLSetup: Record "Manufacturing XL Setup";  // BC Upgrade NANDIS03 - Bloced DIT fields
        // recFinXLSetup: Record "Finance XL Setup";  // BC Upgrade NANDIS03 - Bloced DIT fields
        recServiceLine: Record "Service Line";
        blnFromServiceLine: Boolean;
        blnValidateCrossRef: Boolean;
}

