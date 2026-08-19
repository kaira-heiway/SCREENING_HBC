tableextension 50099 WarehouseActivityHeaderExtFND extends "Warehouse Activity Header"
{
    //     DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added 'Delivery Sequence' optionstring field6 "Sorting Meting"
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM
    //                                             NORRIQ owm - Online Warehouse Management
    //                                             Copyright 2008 by NORRIQ A/S, www.norriq.dk
    //                                               Code added (OnInsert).
    //                                               New field: Release to OWM, Only used for Whse. Movement.
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW19.00.08 DDR 25/11/2016 BL#12308 Added parameter for functions GetActivityStatus, SetActivityStatus for multi prod. order lines

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.10 VSC 22/07/2017 NRQ#27479 fix issue BL#12308 Not creating a put-away anymore
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 # Added Zone transfer, From Zone Code, To Zone Code, In-Transit Zone,
    //   #In-Transit Bin,Posting Type,Transfer Status
    // HEI.02 FDD-HT623 CHG2022293 IBM GAVANM01 02.07.2019 # New fields added: Transfer From Bin, Transfer To Bin
    // HEI.03 IBM.AK CHG2096760 (HT-1296) 11.03.21
    //  # Added new fields -> 50012-50016
    //  # new global variable TruckMovementProcess
    //  # Added code on On Insert
    // version NAVW110.0.00.14199,OWM4.50,DITW110.00.10,HEI.01
    //BC Upgrade PATHAA02- 17.04.25 Field-6062398 (DIT and OWM) commented
    //Driver Code and Truck Code fields-->Table Relation commented -DIT

    fields
    {
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            //OptionCaptionML = ENU = ' ,Put-away,Pick,Movement,Invt. Put-away,Invt. Pick,Invt. Movement', FRA = ' ,Rangement,Prélèvement,Mouvement,Rangement stock,Prélèvement stock,Mouvement stock';
        }
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Location Code")
        {

            //Unsupported feature: Change TableRelation on ""Location Code"(Field 3)". Please convert manually.

            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
            //BC Upgrade PATHAA02>>
            trigger OnAfterValidate()
            var
                WHSUtils: Codeunit "WHS-UTILS";
            begin
                WHSUtils.OnAfterValidateLocationCodeWarehouseActivityHeader(Rec, xRec);//HEI.01 
            end;
            //BC Upgrade PATHAA02<<
        }
        modify("Assigned User ID")
        {

            //Unsupported feature: Change TableRelation on ""Assigned User ID"(Field 4)". Please convert manually.

            CaptionML = ENU = 'Assigned User ID', FRA = 'Code utilisateur affecté';
        }
        modify("Assignment Date")
        {
            CaptionML = ENU = 'Assignment Date', FRA = 'Date affectation';
        }
        modify("Assignment Time")
        {
            CaptionML = ENU = 'Assignment Time', FRA = 'Heure affectation';
        }
        modify("Sorting Method")
        {
            CaptionML = ENU = 'Sorting Method', FRA = 'Méthode de tri';
            //OptionCaptionML = ENU = ' ,Item,Document,Shelf or Bin,Due Date,Ship-To,Bin Ranking,Action Type,,,,Delivery', FRA = ' ,Article,Document,Emplacement,Délai,Destinataire,Priorité emplacement,Type action,,,,Livraison';

            //Unsupported feature: Change OptionString on ""Sorting Method"(Field 7)". Please convert manually.


            //Unsupported feature: Change Description on ""Sorting Method"(Field 7)". Please convert manually.

        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify(Comment)
        {

            //Unsupported feature: Change CalcFormula on "Comment(Field 10)". Please convert manually.

            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify("No. Printed")
        {
            CaptionML = ENU = 'No. Printed', FRA = 'Nbre impressions';
        }
        modify("No. of Lines")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Lines"(Field 13)". Please convert manually.

            CaptionML = ENU = 'No. of Lines', FRA = 'Nbre de lignes';
        }
        modify("Source Type Filter")
        {
            CaptionML = ENU = 'Source Type Filter', FRA = 'Filtre type origine';
        }
        modify("Source Subtype Filter")
        {
            CaptionML = ENU = 'Source Subtype Filter', FRA = 'Filtre sous-type origine';
            OptionCaptionML = ENU = '0,1,2,3,4,5,6,7,8,9,10', FRA = '0,1,2,3,4,5,6,7,8,9,10';
        }
        modify("Source No. Filter")
        {
            CaptionML = ENU = 'Source No. Filter', FRA = 'Filtre n° origine';
        }
        modify("Location Filter")
        {
            CaptionML = ENU = 'Location Filter', FRA = 'Filtre magasin';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Registering No.")
        {
            CaptionML = ENU = 'Registering No.', FRA = 'N° d''enregistrement.';
        }
        modify("Last Registering No.")
        {

            //Unsupported feature: Change TableRelation on ""Last Registering No."(Field 62)". Please convert manually.

            CaptionML = ENU = 'Last Registering No.', FRA = 'Dernier N° enreg.';
        }
        modify("Registering No. Series")
        {
            CaptionML = ENU = 'Registering No. Series', FRA = 'Enregistrement des n° de série';
        }
        modify("Date of Last Printing")
        {
            CaptionML = ENU = 'Date of Last Printing', FRA = 'Date dern. impression';
        }
        modify("Time of Last Printing")
        {
            CaptionML = ENU = 'Time of Last Printing', FRA = 'Heure dern. impression';
        }
        modify("Breakbulk Filter")
        {
            CaptionML = ENU = 'Breakbulk Filter', FRA = 'Filtre déconditionnement';
        }
        modify("Source No.")
        {
            CaptionML = ENU = 'Source No.', FRA = 'N° origine';
        }
        modify("Source Document")
        {
            CaptionML = ENU = 'Source Document', FRA = 'Document origine';
            //OptionCaptionML = ENU = ' ,Sales Order,,,Sales Return Order,Purchase Order,,,Purchase Return Order,Inbound Transfer,Outbound Transfer,Prod. Consumption,Prod. Output,,,,,,,,Assembly Consumption,Assembly Order', FRA = ' ,Commande vente,,,Retour vente,Commande achat,,,Retour achat,Enlogement transfert,Désenlogement transfert,Consommation O.F.,Production O.F.,,,,,,,,Consommation d''assemblage,Ordre d''assemblage';
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
        modify("Destination Type")
        {
            CaptionML = ENU = 'Destination Type', FRA = 'Type destination';
           // OptionCaptionML = ENU = ' ,Customer,Vendor,Location,Item,Family,Sales Order', FRA = ' ,Client,Fournisseur,Magasin,Article,Famille,Commande vente';
        }
        modify("Destination No.")
        {

            //Unsupported feature: Change TableRelation on ""Destination No."(Field 7311)". Please convert manually.

            CaptionML = ENU = 'Destination No.', FRA = 'N° destination';
        }
        modify("External Document No.")
        {
            CaptionML = ENU = 'External Document No.', FRA = 'N° doc. externe';
        }
        modify("Expected Receipt Date")
        {
            CaptionML = ENU = 'Expected Receipt Date', FRA = 'Date réception prévue';
        }
        modify("Shipment Date")
        {
            CaptionML = ENU = 'Shipment Date', FRA = 'Date d''expédition';
        }
        modify("External Document No.2")
        {
            CaptionML = ENU = 'External Document No.2', FRA = 'N° doc. externe 2';
        }
        //Unsupported feature: CodeModification on ""No."(Field 2).OnValidate". Please convert manually.

        //trigger "(Field 2)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "No." <> xRec."No." THEN BEGIN
          NoSeriesMgt.TestManual(GetNoSeriesCode);
          "No. Series" := '';
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "No." <> xRec."No." then begin
          NoSeriesMgt.TestManual(GetNoSeriesCode);
          "No. Series" := '';
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Location Code"(Field 3).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Location Code" <> '' THEN
          IF NOT WMSManagement.LocationIsAllowed("Location Code") THEN
            ERROR(STRSUBSTNO(Text001,USERID) + STRSUBSTNO(' %1 %2.',FIELDCAPTION("Location Code"),"Location Code"));

        GetLocation("Location Code");
        CASE Type OF
          Type::"Invt. Put-away":
            IF Location.RequireReceive("Location Code") AND ("Source Document" <> "Source Document"::"Prod. Output") THEN
              VALIDATE("Source Document","Source Document"::"Prod. Output");
          Type::"Invt. Pick":
            IF Location.RequireShipment("Location Code") THEN
              Location.TESTFIELD("Require Shipment",FALSE);
          Type::"Invt. Movement":
            Location.TESTFIELD("Directed Put-away and Pick",FALSE);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Location Code" <> '' then
          if not WMSManagement.LocationIsAllowed("Location Code") then
        #3..5
        case Type of
          Type::"Invt. Put-away":
            if Location.RequireReceive("Location Code") and ("Source Document" <> "Source Document"::"Prod. Output") then
              VALIDATE("Source Document","Source Document"::"Prod. Output");
          Type::"Invt. Pick":
            if Location.RequireShipment("Location Code") then
              Location.TESTFIELD("Require Shipment",false);
          Type::"Invt. Movement":
            Location.TESTFIELD("Directed Put-away and Pick",false);
        end;
        WHSUtils.OnAfterValidateLocationCodeWarehouseActivityHeader(Rec,xRec);//HEI.01 PRDGAP024 SINGLE LINE
        */
        //end;


        //Unsupported feature: CodeModification on ""Assigned User ID"(Field 4).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Assigned User ID" <> '' THEN BEGIN
          "Assignment Date" := TODAY;
          "Assignment Time" := TIME;
        end else BEGIN
          "Assignment Date" := 0D;
          "Assignment Time" := 0T;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Assigned User ID" <> '' then begin
          "Assignment Date" := TODAY;
          "Assignment Time" := TIME;
        end else begin
          "Assignment Date" := 0D;
          "Assignment Time" := 000000T;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Sorting Method"(Field 7).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Sorting Method" <> xRec."Sorting Method" THEN
          SortWhseDoc;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Sorting Method" <> xRec."Sorting Method" then
          SortWhseDoc;
        */
        //end;


        //Unsupported feature: CodeModification on ""Registering No. Series"(Field 63).OnLookup". Please convert manually.

        //trigger  Series"(Field 63)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WITH WhseActivHeader DO BEGIN
          WhseActivHeader := Rec;
          WhseSetup.GET;
          TestNoSeries;
          IF NoSeriesMgt.LookupSeries(GetRegisteringNoSeriesCode,"Registering No. Series") THEN
            VALIDATE("Registering No. Series");
          Rec := WhseActivHeader;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        with WhseActivHeader do begin
        #2..4
          if NoSeriesMgt.LookupSeries(GetRegisteringNoSeriesCode,"Registering No. Series") then
            VALIDATE("Registering No. Series");
          Rec := WhseActivHeader;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Registering No. Series"(Field 63).OnValidate". Please convert manually.

        //trigger  Series"(Field 63)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Registering No. Series" <> '' THEN BEGIN
          WhseSetup.GET;
          TestNoSeries;
          NoSeriesMgt.TestSeries(GetRegisteringNoSeriesCode,"Registering No. Series");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Registering No. Series" <> '' then begin
        #2..4
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Breakbulk Filter"(Field 7305).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Breakbulk Filter" <> xRec."Breakbulk Filter" THEN
          SetBreakbulkFilter;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Breakbulk Filter" <> xRec."Breakbulk Filter" then
          SetBreakbulkFilter;
        */
        //end;


        //Unsupported feature: CodeModification on ""Source No."(Field 7306).OnValidate". Please convert manually.

        //trigger "(Field 7306)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Source No." <> xRec."Source No." THEN BEGIN
          IF LineExist THEN
            ERROR(Text002,FIELDCAPTION("Source No."));
          IF "Source No." <> '' THEN BEGIN
            TESTFIELD("Location Code");
            TESTFIELD("Source Document");
          end;
          ClearDestinationFields;

          IF ("Source Type" <> 0) AND ("Source No." <> '') THEN BEGIN
            IF Type = Type::"Invt. Put-away" THEN BEGIN
              WhseRequest.GET(
                WhseRequest.Type::Inbound,"Location Code","Source Type","Source Subtype","Source No.");
              WhseRequest.TESTFIELD("Document Status",WhseRequest."Document Status"::Released);
              CreateInvtPutAway.SetWhseRequest(WhseRequest,TRUE);
              CreateInvtPutAway.RUN(Rec);
            end;
            IF Type = Type::"Invt. Pick" THEN BEGIN
              WhseRequest.GET(
                WhseRequest.Type::Outbound,"Location Code","Source Type","Source Subtype","Source No.");
              WhseRequest.TESTFIELD("Document Status",WhseRequest."Document Status"::Released);
              CreateInvtPick.SetWhseRequest(WhseRequest,TRUE);
              CreateInvtPick.RUN(Rec);
            end;
            IF Type = Type::"Invt. Movement" THEN BEGIN
              WhseRequest.GET(
                WhseRequest.Type::Outbound,"Location Code","Source Type","Source Subtype","Source No.");
              WhseRequest.TESTFIELD("Document Status",WhseRequest."Document Status"::Released);
              CreateInvtPick.SetInvtMovement(TRUE);
              CreateInvtPick.SetWhseRequest(WhseRequest,TRUE);
              CreateInvtPick.RUN(Rec);
            end;
          end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Source No." <> xRec."Source No." then begin
          if LineExist then
            ERROR(Text002,FIELDCAPTION("Source No."));
          if "Source No." <> '' then begin
            TESTFIELD("Location Code");
            TESTFIELD("Source Document");
          end;
          ClearDestinationFields;

          if ("Source Type" <> 0) and ("Source No." <> '') then begin
            if Type = Type::"Invt. Put-away" then begin
        #12..14
              CreateInvtPutAway.SetWhseRequest(WhseRequest,true);
              CreateInvtPutAway.RUN(Rec);
            end;
            if Type = Type::"Invt. Pick" then begin
        #19..21
              CreateInvtPick.SetWhseRequest(WhseRequest,true);
              CreateInvtPick.RUN(Rec);
            end;
            if Type = Type::"Invt. Movement" then begin
        #26..28
              CreateInvtPick.SetInvtMovement(true);
              CreateInvtPick.SetWhseRequest(WhseRequest,true);
              CreateInvtPick.RUN(Rec);
            end;
          end;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Source Document"(Field 7307).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Source Document" <> xRec."Source Document" THEN BEGIN
          IF LineExist THEN
            ERROR(Text002,FIELDCAPTION("Source Document"));
          "Source No." := '';
          ClearDestinationFields;
          IF Type = Type::"Invt. Put-away" THEN BEGIN
            GetLocation("Location Code");
            IF Location.RequireReceive("Location Code") THEN
              TESTFIELD("Source Document","Source Document"::"Prod. Output");
          end;
        end;

        CASE "Source Document" OF
          "Source Document"::"Purchase Order":
            BEGIN
              "Source Type" := 39;
              "Source Subtype" := 1;
            end;
          "Source Document"::"Purchase Return Order":
            BEGIN
              "Source Type" := 39;
              "Source Subtype" := 5;
            end;
          "Source Document"::"Sales Order":
            BEGIN
              "Source Type" := 37;
              "Source Subtype" := 1;
            end;
          "Source Document"::"Sales Return Order":
            BEGIN
              "Source Type" := 37;
              "Source Subtype" := 5;
            end;
          "Source Document"::"Outbound Transfer":
            BEGIN
              "Source Type" := 5741;
              "Source Subtype" := 0;
            end;
          "Source Document"::"Inbound Transfer":
            BEGIN
              "Source Type" := 5741;
              "Source Subtype" := 1;
            end;
          "Source Document"::"Prod. Consumption":
            BEGIN
              "Source Type" := 5407;
              "Source Subtype" := 3;
            end;
          "Source Document"::"Prod. Output":
            BEGIN
              "Source Type" := 5406;
              "Source Subtype" := 3;
            end;
          "Source Document"::"Assembly Consumption":
            BEGIN
              "Source Type" := DATABASE::"Assembly Line";
              "Source Subtype" := AssemblyLine."Document Type"::Order;
            end;
        end;

        IF "Source Document" = 0 THEN BEGIN
          "Source Type" := 0;
          "Source Subtype" := 0;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Source Document" <> xRec."Source Document" then begin
          if LineExist then
        #3..5
          if Type = Type::"Invt. Put-away" then begin
            GetLocation("Location Code");
            if Location.RequireReceive("Location Code") then
              TESTFIELD("Source Document","Source Document"::"Prod. Output");
          end;
        end;

        case "Source Document" of
          "Source Document"::"Purchase Order":
            begin
              "Source Type" := 39;
              "Source Subtype" := 1;
            end;
          "Source Document"::"Purchase Return Order":
            begin
              "Source Type" := 39;
              "Source Subtype" := 5;
            end;
          "Source Document"::"Sales Order":
            begin
              "Source Type" := 37;
              "Source Subtype" := 1;
            end;
          "Source Document"::"Sales Return Order":
            begin
              "Source Type" := 37;
              "Source Subtype" := 5;
            end;
          "Source Document"::"Outbound Transfer":
            begin
              "Source Type" := 5741;
              "Source Subtype" := 0;
            end;
          "Source Document"::"Inbound Transfer":
            begin
              "Source Type" := 5741;
              "Source Subtype" := 1;
            end;
          "Source Document"::"Prod. Consumption":
            begin
              "Source Type" := 5407;
              "Source Subtype" := 3;
            end;
          "Source Document"::"Prod. Output":
            begin
              "Source Type" := 5406;
              "Source Subtype" := 3;
            end;
          "Source Document"::"Assembly Consumption":
            begin
              "Source Type" := DATABASE::"Assembly Line";
              "Source Subtype" := AssemblyLine."Document Type"::Order;
            end;
        end;

        if "Source Document" = 0 then begin
          "Source Type" := 0;
          "Source Subtype" := 0;
        end;
        */
        //end;

        field(50000; "Zone transfer FND"; Boolean)
        {
            Caption = 'Zone transfer';
            Description = 'HEI.01 PRDGAP024';
        }
        field(50001; "From Zone Code FND"; Code[10])
        {
            Caption = 'From Zone Code';
            Description = 'HEI.01 PRDGAP024';
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"),
                                             "Use As In-Transit FND" = CONST(false));

            trigger OnValidate();
            begin
                TESTFIELD("Transfer Status FND", "Transfer Status FND"::Pending);//HEI.01 PRDGAP024 SINGLE LINE
            end;
        }
        field(50002; "To Zone Code FND"; Code[10])
        {
            caption = 'To Zone Code';
            Description = 'HEI.01 PRDGAP024';
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"),
                                             "Use As In-Transit FND" = CONST(false));

            trigger OnValidate();
            begin
                TESTFIELD("Transfer Status FND", "Transfer Status FND"::Pending);//HEI.01 PRDGAP024 SINGLE LINE
            end;
        }
        field(50003; "In-Transit Zone FND"; Code[10])
        {
            caption = 'In-Transit Zone';
            Description = 'HEI.01 PRDGAP024';
            Editable = false;
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"),
                                             "Use As In-Transit FND" = FILTER(true));
        }
        field(50004; "In-Transit Bin FND"; Code[20])
        {
            caption = 'In-Transit Bin';
            Description = 'HEI.01 PRDGAP024';
            Editable = false;
            TableRelation = Bin.Code where("Location Code" = FIELD("Location Code"),
                                            "Zone Code" = FIELD("In-Transit Zone FND"));
        }
        field(50005; "Posting Type FND"; Option)
        {
            caption = 'Posting Type';
            Description = 'HEI.01 PRDGAP024';
            OptionMembers = " ",Ship,Receive;
        }
        field(50006; "Transfer Status FND"; Option)
        {
            caption = 'Transfer Status';
            Description = 'HEI.01 PRDGAP024';
            Editable = false;
            OptionMembers = Pending,"In Progress";
        }
        field(50007; "Posted Shipments FND"; Integer)
        {
            caption = 'Posted Shipments';
            CalcFormula = Count("Registered Whse. Activity Hdr." where(Type = FIELD(Type),
                                                                        "Whse. Activity No." = FIELD("No."),
                                                                        "Transfer Type FND" = FILTER(Shipment)));
            Description = 'HEI.01 PRDGAP024';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50008; "Posted Receipts FND"; Integer)
        {
            caption = 'Posted Receipts';
            CalcFormula = Count("Registered Whse. Activity Hdr." where(Type = FIELD(Type),
                                                                        "Whse. Activity No." = FIELD("No."),
                                                                        "Transfer Type FND" = FILTER(Receipt)));
            Description = 'HEI.01 PRDGAP024';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50009; "Whse. Entries FND"; Integer)
        {
            caption = 'Whse. Entries';
            CalcFormula = Count("Warehouse Entry" where("Movement No. FND" = FIELD("No."),
                                                         "Zone-Transfer FND" = FILTER(true)));
            Description = 'HEI.01 PRDGAP024';
            FieldClass = FlowField;
        }
        field(50010; "Transfer From Bin FND"; Code[20])
        {
            caption = 'Transfer From Bin';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50011; "Transfer To Bin FND"; Code[20])
        {
            caption = 'Transfer To Bin';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50012; "Shipping Agent Code FND"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            CaptionML = ENU = 'Shipping Agent Code',
                        FRA = 'Code transporteur';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "Shipping Agent";
        }
        field(50013; "Shipping Agent Service Cod FND"; Code[10])
        {
            CaptionML = ENU = 'Shipping Agent Service Code',
                        FRA = 'Code prestation transporteur';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "Shipping Agent Services".Code where("Shipping Agent Code" = FIELD("Shipping Agent Code FND"));
        }
        field(50014; "Truck Code FND"; Code[10])
        {
            CaptionML = ENU = 'Truck Code',
                        FRA = 'Code camion';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            //TableRelation = "Whse. Shipping Truck"; //BC Upgrade PATHAA02>>-DIT table

            trigger OnLookup();
            var
                TruckCodeText: Text[10];
            begin
            end;
        }

        field(50015; "Driver Code FND"; Code[10])
        {
            CaptionML = ENU = 'Driver Code',
                        FRA = 'Code chauffeur';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            // TableRelation = "Whse. Shipping Driver";  //BC Upgrade PATHAA02>>-DIT table
        }

        field(50016; "Truck Movement FND"; Boolean)
        {
            caption = 'Truck Movement';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        //BC Upgrade PATHAA02>>
        // field(6062398;"Released to N-owm";Boolean)
        // {
        //     CaptionML = ENU='Released to N-owm',
        //                 FRA='Lancé à N-owm';
        //     Description = 'OWM3.50';

        //     trigger OnValidate();
        //     var
        //         lrecNowmLocation : Record "N-owm Location";
        //     begin
        //         if Type = Type::Movement then begin
        //           if "Released to N-owm" then begin
        //             // <<DITW19.00.08 DDR 25/11/2016 BL#12308
        //             if OWMUtils.GetActivityStatus(OWMUtils.ActWhseMove, "No.", 0, Type,0, "No.", "Location Code") = OWMUtils.StatusNotCreated then
        //               OWMUtils.SetActivityStatus(OWMUtils.ActWhseMove, "No.", 0, Type,0, "No.", "Location Code", OWMUtils.StatusReleased,USERID);
        //             // >>DITW19.00.08 DDR BL#12308
        //           end else begin
        //             // <<DITW19.00.08 DDR 25/11/2016 BL#12308
        //             if OWMUtils.GetActivityStatus(OWMUtils.ActWhseMove, "No.", 0, Type,0, "No.", "Location Code") in
        //             // >>DITW19.00.08 DDR BL#12308
        //                  [OWMUtils.StatusNotCreated, OWMUtils.StatusCreated, OWMUtils.StatusReleased, OWMUtils.StatusPosted, OWMUtils.StatusError]
        //             then
        //               OWMUtils.DelAct_WarehouseActivityHeader(Rec);
        //           end;
        //         end;
        //         // <<DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806
        //         if lrecNowmLocation.GET("Location Code") then
        //           begin
        //             if lrecNowmLocation."Post Put-Away after Receipt" then
        //               // <<DITW19.00.08 DDR 25/11/2016 BL#12308
        //               if OWMUtils.GetActivityStatus(OWMUtils.ActWhseMove, "No.", 0, Type,0, "No.", "Location Code") = OWMUtils.StatusNotCreated then
        //               // >>DITW19.00.08 DDR BL#12308
        //                 OWMUtils.SetActivityStatus(OWMUtils.ActWhseMove, "No.", 0, Type,0, "No.", "Location Code", OWMUtils.StatusPosting,USERID);
        //           end;
        //         // >>DITW16.00.00.43 RBE DIT-715 #806
        //     end;
        // }
        //BC Upgrade PATHAA02<<
    }

    //BC Upgrade PATHAA02>>
    trigger OnInsert();
    begin
        //HEI.03>>
        "Truck Movement FND" := TruckMovementProcess.TruckMovTrue();
        CLEAR(TruckMovementProcess);
        //HEI.03<<
    end;
    //BC Upgrade PATHAA02<<


    //Unsupported feature: CodeInsertion on "OnInsert". Please convert manually.

    //trigger (Variable: OWMLocation)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "No." = '' THEN BEGIN
      TestNoSeries;
      NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series","Posting Date","No.","No. Series");
    end;

    NoSeriesMgt.SetDefaultSeries("Registering No. Series",GetRegisteringNoSeriesCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if "No." = '' then begin
      TestNoSeries;
      NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series","Posting Date","No.","No. Series");
    end;

    NoSeriesMgt.SetDefaultSeries("Registering No. Series",GetRegisteringNoSeriesCode);

    // <<DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806
    // NIQ OWM >>
    if OWMLocation.GET("Location Code") and (OWMLocation.Active) then begin
      case Type of
        Type::Pick, Type::"Invt. Pick":begin
           // <<DITW19.00.08 DDR 25/11/2016 BL#12308
           OWMUtils.SetActivityStatus(OWMUtils.ActPick, "No.", 0, "Source Type", "Source Subtype", "Source No.", "Location Code",
                                      OWMUtils.StatusReleased,USERID);
           // >>DITW19.00.08 DDR BL#12308
        end;
        //<< DITW110.00.10 VSC 22/07/2017 NRQ#27479
        Type::"Put-away", Type::"Invt. Put-away":begin

           if OWMLocation."Post Put-Away after Receipt" then begin
               // <<DITW19.00.08 DDR 25/11/2016 BL#12308
               OWMUtils.SetActivityStatus(OWMUtils.ActPutAway, "No.", 0, "Source Type", "Source Subtype", "Source No.", "Location Code",
                                          OWMUtils.StatusPosting,USERID);
               // >>DITW19.00.08 DDR BL#12308
           end else begin
               // <<DITW19.00.08 DDR 25/11/2016 BL#12308
               OWMUtils.SetActivityStatus(OWMUtils.ActPutAway, "No.", 0, "Source Type", "Source Subtype", "Source No.", "Location Code",
                                          OWMUtils.StatusReleased,USERID);
               // >>DITW19.00.08 DDR BL#12308
           end;
         end;
         //>> DITW110.00.10 VSC 22/07/2017 NRQ#27479
      end;
    end;
    // NIQ OWM <<
    // >>DITW16.00.00.43 RBE DIT-715 #806
    //HEI.03>>
    "Truck Movement" := TruckMovementProcess.TruckMovTrue;
    CLEAR(TruckMovementProcess);
    //HEI.03<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
    // OWMLocation: Record "N-owm Location"; //BC Upgrade PATHAA02


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You cannot rename a %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot rename a %1.;FRA=Vous ne pouvez pas renommer l'enregistrement %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You must first set up user %1 as a warehouse employee.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You must first set up user %1 as a warehouse employee.;FRA=Vous devez d'abord configurer l'utilisateur %1 en tant que magasinier.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=You cannot change %1 because one or more lines exist.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=You cannot change %1 because one or more lines exist.;FRA=Vous ne pouvez pas modifier %1 car il existe une ou plusieurs lignes.;
    //Variable type has not been exported.

    var

        TruckMovementProcess: Codeunit "Truck Movement Process";
        // OWMUtils: Codeunit "N-owm Utils"; //BC Upgrade PATHAA02
        WHSUtils: Codeunit "WHS-UTILS";

}

