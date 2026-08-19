tableextension 50192 PostedWhseReceiptLineExtFND extends "Posted Whse. Receipt Line"
{
    // DITW15.00.00.21 DDR 13/06/2008 Added fields + sumindex primarykey
    //                                  2014079 Weight
    //                                  2014080 Cubage
    //                                Added Form property DrillDownFormID
    //                                Added key
    //                                  "Source Document,Source No."
    //                                  "Posted Source Document,Posted Source No.,Source Line No."
    //                                Change Caption of field41 "Cubage" > Caption "Volume (Cubage)"
    // DITW15.00.00.33 DDR 13/05/2009 Added fields
    //                                  2013667 Item DTax Group Code
    //                                  2013751 Src. DTax Group Code
    // DITW15.00.00.35 DLE 06/09/2009 issue 516 Added fields
    //                                  2014094 Physical Location Group Code
    // DITW15.00.00.38 DDR 01/12/2010 issue 1226 Added fields
    //                                  2014479 Correction
    // DITW15.00.00.38 DDR 11/03/2011 issue 458 Replaced caption field2014094 (dutch)
    // DITW15.00.00.39 21/06/2011 issue 1370 Bugfix TableRelation property field2013751 "Source DTax Group Code"
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields
    //                                    2014107 Route
    //                                    2014495 Delivery Sequence
    //                     02/01/2012 DIT-715 issue 185 Added fields
    //                                  2014440 Attached to Line No.
    //                     13/02/2012 DIT-715 #244
    //                                Added fields
    //                                  2014069 Shortcut Unit of Measure1 Code
    //                                  2014089 Shortcut Unit of Measure2 Code
    //                                  2014093 Shortcut Unit of Measure3 Code
    //                                Added functions GetCaptionClassUom(),ShowShortcutUomValue()

    // FINXL7.00.001 RBE 20/03/2013: Item description extend from 30 -> 80 chars

    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW110.00.09 AKH 31/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9

    // HEI.01 FDD-SLSGAP001 IBM NASTAA02 08.09.2017 # MDM Customer Card
    //   # Increased "Src. DTax Group Code" field length from 10 to 20 characters
    // HEI.02 FDD-KDD0TC001 IBM HORTOC01 26.09.2017
    //   # New fields
    // HEI.03 FDD-LB-GAPLOG03 IBM NASTAA02 17.07.2018 # Loading Note Almaza
    //   # New Field created 50008 - Print Load List Shipment
    //   # New Keys added for "Item No.", Description and "Shelf No."
    // HEI.04 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Field created: 50009 - "Gate Entry No."
    // HEI.05 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new fields added "Load No." & "Sequence No."
    // HEI.06 CHG2095415 IBM BULIMC01 06.05.2021#new field added: 50012 -"Item Category Code"
    // HEI.07 CHG2217161 SAHAL01 02.11.2023 SPL for Returns and GR cancellations
    //   # Created New Fields: 50057 - SPL Code
    //                         50058 - SPL Name
    //                         50059 - Consumption SPL Code
    // HEI.08 CHG2217161 SAHAL01 09.11.2023 SPL for Returns and GR cancellations
    //# Created New Field: 50059 - Consumption SPL Code
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
            // OptionCaptionML = ENU = ',Sales Order,,,Sales Return Order,Purchase Order,,,Purchase Return Order,Inbound Transfer', FRA = ',Commande vente,,,Retour vente,Commande achat,,,Retour achat,Enlogement transfert';
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
        }
        modify("Zone Code")
        {
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
        modify("Qty. Put Away")
        {
            CaptionML = ENU = 'Qty. Put Away', FRA = 'Qté rangement';
        }
        modify("Qty. Put Away (Base)")
        {
            CaptionML = ENU = 'Qty. Put Away (Base)', FRA = 'Qté rangement (base)';
        }
        modify("Put-away Qty.")
        {
            CaptionML = ENU = 'Put-away Qty.', FRA = 'Ranger qté';
        }
        modify("Put-away Qty. (Base)")
        {
            CaptionML = ENU = 'Put-away Qty. (Base)', FRA = 'Ranger qté (base)';
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
        modify("Due Date")
        {
            CaptionML = ENU = 'Due Date', FRA = 'Délai';
        }
        modify("Starting Date")
        {
            CaptionML = ENU = 'Starting Date', FRA = 'Date début';
        }
        modify("Qty. Cross-Docked")
        {
            CaptionML = ENU = 'Qty. Cross-Docked', FRA = 'Qté transbordée';
        }
        modify("Qty. Cross-Docked (Base)")
        {
            CaptionML = ENU = 'Qty. Cross-Docked (Base)', FRA = 'Qté transbordée (base)';
        }
        modify("Cross-Dock Zone Code")
        {
            CaptionML = ENU = 'Cross-Dock Zone Code', FRA = 'Code zone transbordement';
        }
        modify("Cross-Dock Bin Code")
        {
            CaptionML = ENU = 'Cross-Dock Bin Code', FRA = 'Code empl. transbord.';
        }
        modify("Posted Source Document")
        {
            CaptionML = ENU = 'Posted Source Document', FRA = 'Document origine enreg.';
            // OptionCaptionML = ENU = ' ,Posted Receipt,,Posted Return Receipt,,Posted Shipment,,Posted Return Shipment,,Posted Transfer Receipt', FRA = ' ,Réception enreg.,,Réception retour enreg.,,Expédition enreg.,,Expédition retour enreg.,,Réception transfert enreg.';
        }
        modify("Posted Source No.")
        {
            CaptionML = ENU = 'Posted Source No.', FRA = 'N° origine enreg.';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Vendor Shipment No.")
        {
            CaptionML = ENU = 'Vendor Shipment No.', FRA = 'N° B.L. fournisseur';
        }
        modify("Whse. Receipt No.")
        {
            CaptionML = ENU = 'Whse. Receipt No.', FRA = 'N° réception entrepôt';
        }
        modify("Whse Receipt Line No.")
        {
            CaptionML = ENU = 'Whse Receipt Line No.', FRA = 'N° ligne réception entrepôt';
        }
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            OptionCaptionML = ENU = ' ,Partially Put Away,Completely Put Away', FRA = ' ,Partiellement rangé,Entièrement rangé';
        }
        modify("Serial No.")
        {
            CaptionML = ENU = 'Serial No.', FRA = 'N° de série';
        }
        modify("Lot No.")
        {
            CaptionML = ENU = 'Lot No.', FRA = 'N° lot';
        }
        modify("Warranty Date")
        {
            CaptionML = ENU = 'Warranty Date', FRA = 'Date garantie';
        }
        modify("Expiration Date")
        {
            CaptionML = ENU = 'Expiration Date', FRA = 'Date d''expiration';
        }
        field(50005; "RPM Solution FND"; Option)
        {
            Caption = 'RPM Solution';
            Description = 'HEI.01';
            Editable = false;
            OptionCaption = '" ,Deposit,Full-for-Empty with revenue impact (FFE with revenue),Full-for Empty without revenue impact (FFE w/o revenue)"';
            OptionMembers = " ",Deposit,"Full-for-Empty with revenue impact (FFE with revenue)","Full-for Empty without revenue impact (FFE w/o revenue)";
        }
        field(50006; "RPM Type FND"; Code[20])
        {
            Caption = 'RPM Type';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "Return Pack Material Type FND".Code;
        }
        field(50007; "Item Type FND"; Option)
        {
            Caption = 'Item Type';
            Description = 'HEI.01';
            Editable = false;
            OptionCaption = '" ,RPM Related,Product Related"';
            OptionMembers = " ","RPM Related","Product Related";
        }
        field(50008; "Source Original Quantity FND"; Decimal)
        {
            CaptionML = ENU = 'Source Original Quantity',
                        FRA = 'Quantité Original';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.02';
            Editable = false;
        }
        field(50009; "Gate Entry No. FND"; Code[20])
        {
            Caption = 'Gate Entry No.';
            Description = 'HEI.03';
            Editable = false;
            TableRelation = "Gate Entry Header FND";
        }
        field(50010; "Sequence No. FND"; Integer)
        {
            Caption = 'Sequence No.';
            Description = 'HEI.04';
        }
        field(50011; "Load No. FND"; Integer)
        {
            Caption = 'Load No.';
            Description = 'HEI.04';
        }
        field(50012; "Item Category Code FND"; Code[20])
        {
            Caption = 'Item Category Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.06';
        }
        field(50057; "SPL Code FND"; Code[20])
        {
            Caption = 'SPL Code';
            Description = 'HEI.07,HEI.08';
            Editable = false;
            TableRelation = "Vendor SPL Relation FND"."SPL Code" where(Blocked = CONST(false));
        }
        field(50058; "SPL Name FND"; Text[50])
        {
            Caption = 'SPL Name';
            Description = 'HEI.07,HEI.08';
            Editable = false;
        }
        field(50059; "Consumption SPL Code FND"; Code[20])
        {
            Caption = 'Consumption SPL Code';
            Description = 'HEI.08';
            Editable = false;
            TableRelation = "Vendor SPL Relation FND"."SPL Code" where(Blocked = CONST(false));
        }
        // BC Upgrade SHARMP16 Begin>> ---------------Drink-IT fields
        // field(2013667;"Item DTax Group Code";Code[10])
        // {
        //     CaptionML = ENU='Item Tax Group Code',
        //                 FRA='Code groupe taxe article';
        //     Description = 'DITW15.00.00.33';
        //     TableRelation = "Drink Tax Group".Code WHERE ("Source Type"=CONST(Item));
        // }
        // field(2013728;"AAD No.";Code[20])
        // {
        //     CaptionML = ENU='AAD No.',
        //                 FRA='N° DAA';
        //     Description = 'DITW15.00.00.39 #1296';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.39 DDR 12/04/2011 DIT-712 #1296
        //         if xRec."AAD No." <> "AAD No." then
        //           UpdatePstdDocSourceLines(FIELDNAME("AAD No."));
        //         // <<DITW15.00.00.39 DDR 11/07/2011 #1369
        //         if CurrFieldNo = FIELDNO("AAD No.") then
        //           TESTFIELD("Applies-to AAD Trck. Entry No.",0);
        //         // >>DITW15.00.00.39 DDR #1369
        //     end;
        // }
        // field(2013731;"Applies-to AAD Trck. Entry No.";Integer)
        // {
        //     CaptionML = ENU='Applies-to Correction AAD Trck. Entry No.',
        //                 FRA='N° Ecriture correction suivi DAA lettrage';
        //     Description = 'DITW15.00.00.39 #1369';
        //     TableRelation = "AAD Tracking Entry"."Entry No." WHERE ("Entry Type"=CONST(Outbound));

        //     trigger OnValidate();
        //     var
        //         AADTrackingEntry : Record "AAD Tracking Entry";
        //     begin
        //         TESTFIELD("Item No.");
        //         if "Applies-to AAD Trck. Entry No." <> 0 then begin
        //           AADTrackingEntry.GET("Applies-to AAD Trck. Entry No.");
        //           "AAD No." := AADTrackingEntry."AAD No.";
        //           "ARC No." := AADTrackingEntry."ARC No.";
        //         end;
        //     end;
        // }
        // field(2013751;"Src. DTax Group Code";Code[10])
        // {
        //     CaptionML = ENU='Source Tax Group Code',
        //                 FRA='Code groupe taxe Source';
        //     Description = 'DITW15.00.00.33-.39 #1370';
        //     TableRelation = "Drink Tax Group".Code;
        // }
        // field(2014079;Cubage;Decimal)
        // {
        //     CaptionML = ENU='Volume (Cubage)',
        //                 FRA='Volume (cubage)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.21';
        // }
        // field(2014080;Weight;Decimal)
        // {
        //     CaptionML = ENU='Weight',
        //                 FRA='Poids';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.21';
        // }
        // field(2014094;"Physical Location Group Code";Code[10])
        // {
        //     CaptionML = ENU='Physical Location Group Code',
        //                 FRA='Code groupe magasin réel';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014262;"ARC No.";Code[30])
        // {
        //     CaptionML = ENU='ARC No.',
        //                 FRA='N° ARC';
        //     Description = 'DITW15.00.00.39 #1296';

        //     trigger OnLookup();
        //     var
        //         NewText : Text[1024];
        //     begin
        //     end;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.39 DDR 19/07/2011 #1406
        //         if TestExistEDIOutboxDocNo(false) then
        //           TESTFIELD("ARC No.",xRec."ARC No.");
        //         // >>DITW15.00.00.39 DDR #1406
        //         // <<DITW15.00.00.39 DDR 12/04/2011 DIT-712 #1296
        //         if "ARC No." <> xRec."ARC No." then
        //           UpdatePstdDocSourceLines(FIELDNAME("ARC No."));
        //         // <<DITW15.00.00.39 DDR 11/07/2011 #1369
        //         if CurrFieldNo = FIELDNO("ARC No.") then
        //           TESTFIELD("Applies-to AAD Trck. Entry No.",0);
        //         // >>DITW15.00.00.39 DDR #1369
        //     end;
        // }
        // field(2014263;"SAD No.";Code[30])
        // {
        //     CaptionML = ENU='SAD No.',
        //                 FRA='N° SAD';
        //     Description = 'DITW15.00.00.39 #1296';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.39 DDR 19/07/2011 #1406
        //         if TestExistEDIOutboxDocNo(false) then
        //           TESTFIELD("SAD No.",xRec."SAD No.");
        //         // >>DITW15.00.00.39 DDR #1406
        //         // <<DITW15.00.00.39 DDR 12/04/2011 DIT-712 #1296
        //         if "SAD No." <> xRec."SAD No." then
        //           UpdatePstdDocSourceLines(FIELDNAME("SAD No."));
        //     end;
        // }
        // field(2014267;"ARC No. Mandatory";Boolean)
        // {
        //     CaptionML = ENU='ARC No. Mandatory (EMCS)',
        //                 FRA='N° ARC obligatoire (EMCS)';
        //     Description = 'DITW15.00.00.39 #1296';
        // }
        // field(2014283;"ARC Line No.";Integer)
        // {
        //     CaptionML = ENU='ARC Line No.',
        //                 FRA='N° ligne ARC';
        //     Description = 'DITW15.00.00.39 #1296';

        //     trigger OnValidate();
        //     var
        //         PstdWhseRcptLine : Record "Posted Whse. Receipt Line";
        //     begin
        //         // <<DITW15.00.00.39 DDR 12/04/2011 DIT-712 #1296
        //         TESTFIELD("ARC No. Mandatory",true);
        //         TESTFIELD("ARC No.");
        //         // <<DITW15.00.00.39 DDR 19/07/2011 #1406
        //         if TestExistEDIOutboxDocNo(false) then
        //           TESTFIELD("ARC Line No.",xRec."ARC Line No.");
        //         // >>DITW15.00.00.39 DDR #1406
        //         // <<DITW16.00.00.40 DDR 01/02/2012 DIT-715 #200
        //         if "Unsatisfactory Type" > 0 then
        //           TESTFIELD("ARC Line No.")
        //         else
        //           TESTFIELD("ARC Line No.",0);
        //         // >>DITW16.00.00.40 DDR DIT-715 #200

        //         if "ARC Line No." <> 0 then begin
        //           PstdWhseRcptLine.SETCURRENTKEY("No.","ARC No.","ARC Line No.");
        //           PstdWhseRcptLine.SETRANGE("No.","No.");
        //           PstdWhseRcptLine.SETRANGE("ARC No.","ARC No.");
        //           PstdWhseRcptLine.SETFILTER("Line No.",'<>%1',"Line No.");
        //           PstdWhseRcptLine.SETRANGE("ARC Line No.","ARC Line No.");
        //           if PstdWhseRcptLine.FINDFIRST then
        //             PstdWhseRcptLine.FIELDERROR("ARC Line No.");
        //           /// DITW16.00.00.40 DDR 01/02/2012 DIT-715 #200
        //         end;
        //         if xRec."ARC Line No." <> "ARC Line No." then
        //           UpdatePstdDocSourceLines(FIELDNAME("ARC Line No."));
        //     end;
        // }
        // field(2014284;"Unsatisfactory Type";Option)
        // {
        //     CaptionML = ENU='Unsatisfactory Type',
        //                 FRA='Type Insatisfaisant';
        //     Description = 'DITW15.00.00.39 #1296';
        //     OptionCaptionML = ENU='Other,Excess,Shortage,Good Damaged,Broken Seal,Reported by Export Control System,Incorrect Values',
        //                       FRA='Autre,En excès,En pénurie,Marchandise abimée,Sceau brisé,Rapporté par ECS,Valeurs incorrectes';
        //     OptionMembers = " ",Excess,Shortage,"Good damaged","Broken Seal","Reported by ECS","Incorrect Values";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.39 DDR 12/04/2011 DIT-712 #1296
        //         TESTFIELD("ARC No. Mandatory",true);
        //         TESTFIELD("ARC No.");
        //         // <<DITW15.00.00.39 DDR 19/07/2011 #1406
        //         if TestExistEDIOutboxDocNo(false) then
        //           TESTFIELD("Unsatisfactory Type",xRec."Unsatisfactory Type");
        //         // >>DITW15.00.00.39 DDR #1406

        //         if xRec."Unsatisfactory Type" <> "Unsatisfactory Type" then
        //           UpdatePstdDocSourceLines(FIELDNAME("Unsatisfactory Type"));

        //         // <<DITW16.00.00.40 DDR 01/02/2012 DIT-715 #200
        //         if "Unsatisfactory Type" = "Unsatisfactory Type"::" " then begin
        //           "Unsatisfactory Quantity" := 0;
        //           "ARC Line No." := 0;
        //         end;
        //         // >>DITW16.00.00.40 DDR DIT-715 #200
        //     end;
        // }
        // field(2014285;"Unsatisfactory Quantity";Decimal)
        // {
        //     CaptionML = ENU='Unsatisfactory Quantity',
        //                 FRA='Quantité Insatisfaisant';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.39 #1296';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.39 DDR 12/04/2011 DIT-712 #1296
        //         TESTFIELD("ARC No. Mandatory",true);
        //         TESTFIELD("ARC No.");
        //         // <<DITW15.00.00.39 DDR 19/07/2011 #1406
        //         if TestExistEDIOutboxDocNo(false) then
        //           TESTFIELD("Unsatisfactory Quantity",xRec."Unsatisfactory Quantity");
        //         // >>DITW15.00.00.39 DDR #1406

        //         if xRec."Unsatisfactory Quantity" <> "Unsatisfactory Quantity" then
        //           UpdatePstdDocSourceLines(FIELDNAME("Unsatisfactory Quantity"));
        //     end;
        // }
        // field(2014286;"Unsatisfactory Comment";Boolean)
        // {
        //     CalcFormula = Exist("EMCS Comment Line" WHERE ("Table ID"=FILTER(121|5747|6661),
        //                                                    "Document Type"=CONST(0),
        //                                                    "Document No."=FIELD("Posted Source No."),
        //                                                    "Document Line No."=FIELD("Source Line No."),
        //                                                    "Field ID"=CONST(2014285)));
        //     CaptionML = ENU='Unsatisfactory Comment',
        //                 FRA='Commentaires insatisfaisant';
        //     Description = 'DITW15.00.00.39 #1296';
        //     Editable = false;
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
        // field(2014476;"Packaging Type Code";Code[10])
        // {
        //     CaptionML = ENU='Packaging Type Code',
        //                 FRA='Code Type de Conditionnement';
        //     Description = 'DITW15.00.00.39 #1296';
        //     TableRelation = "Packaging Type";

        //     trigger OnValidate();
        //     var
        //         PackagingType : Record "Packaging Type";
        //     begin
        //         // <<DITW15.00.00.39 DDR 19/07/2011 #1406
        //         if TestExistEDIOutboxDocNo(false) then
        //           TESTFIELD("Packaging Type Code",xRec."Packaging Type Code");
        //         // >>DITW15.00.00.39 DDR #1406
        //         // <<DITW15.00.00.39 DDR 12/04/2011 DIT-712 #1296
        //         if xRec."Packaging Type Code" <> "Packaging Type Code" then
        //           UpdatePstdDocSourceLines(FIELDNAME("Packaging Type Code"));
        //     end;
        // }
        // field(2014477;"No. of Packages";Decimal)
        // {
        //     CaptionML = ENU='No. of Packages',
        //                 FRA='Nbre de colis';
        //     DecimalPlaces = 0:0;
        //     Description = 'DITW15.00.00.39 #1296';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.39 DDR 19/07/2011 #1406
        //         if TestExistEDIOutboxDocNo(false) then
        //           TESTFIELD("No. of Packages",xRec."No. of Packages");
        //         // >>DITW15.00.00.39 DDR #1406
        //         // <<DITW15.00.00.38 DDR 16/09/2010 - 12/10/2010 #1217
        //         TESTFIELD(Quantity);
        //         if "Item No." = '' then
        //           TESTFIELD("No. of Packages",0);

        //         if xRec."No. of Packages" <> "No. of Packages" then
        //           UpdatePstdDocSourceLines(FIELDNAME("No. of Packages"));
        //     end;
        // }
        // field(2014478;"Commercial Seal ID";Text[35])
        // {
        //     CaptionML = ENU='Commercial Seal ID',
        //                 FRA='ID sceau commerciale';
        //     Description = 'DITW15.00.00.39 #1296';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.39 DDR 19/07/2011 #1406
        //         if TestExistEDIOutboxDocNo(false) then
        //           TESTFIELD("Commercial Seal ID",xRec."Commercial Seal ID");
        //         // >>DITW15.00.00.39 DDR #1406
        //         // <<DITW15.00.00.39 DDR 12/04/2011 DIT-712 #1296
        //         TESTFIELD(Quantity);
        //         if "Item No." = '' then
        //           TESTFIELD("Commercial Seal ID",'');

        //         if xRec."AAD No." <> "AAD No." then
        //           UpdatePstdDocSourceLines(FIELDNAME("Commercial Seal ID"));
        //     end;
        // }
        // field(2014482;"Pack Qty. per Unit of Measure";Decimal)
        // {
        //     CaptionML = ENU='Packaging Qty. per Unit of Measure',
        //                 FRA='Quantité conditionnement par unité';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.39 #1296';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.39 DDR 19/07/2011 #1406
        //         if TestExistEDIOutboxDocNo(false) then
        //           TESTFIELD("Pack Qty. per Unit of Measure",xRec."Pack Qty. per Unit of Measure");
        //         // >>DITW15.00.00.39 DDR #1406
        //         // <<DITW15.00.00.39 DDR 12/04/2011 DIT-712 #1296
        //         TESTFIELD(Quantity);
        //         if "Item No." = '' then
        //           TESTFIELD("No. of Packages",0);

        //         if xRec."Pack Qty. per Unit of Measure" <> "Pack Qty. per Unit of Measure" then
        //           UpdatePstdDocSourceLines(FIELDNAME("Pack Qty. per Unit of Measure"));
        //     end;
        // }
        // field(2035040;"SSCC No.";Code[50])
        // {
        //     CaptionML = ENU='SSCC No. (Buffer)',
        //                 FRA='N° de SSCC (Tampon)';
        //     Description = 'DITW16.00.00.40 DIT-715 #274';
        //     Editable = false;

        //     trigger OnValidate();
        //     begin
        //         // DITW16.00.00.40 DDR 06/03/2012 DIT-715 #274
        //         // Temporary buffer field to split and create the lines into Put-Away (table 5767 Warehouse Activity Line)
        //     end;
        // }
        // BC Upgrade SHARMP16 End<< ---------------Drink-IT fields
    }
    keys
    {

        //Unsupported feature: PropertyChange on ""No.","Line No."(Key)". Please convert manually.

        key(Key50000; "Source Document", "Source No.")
        {
        }
        key(Key50001; "Posted Source Document", "Posted Source No.", "Source Line No.")
        {
        }
        // key(Key3;"No.","ARC No.","ARC Line No.")
        // {
        // }//// BC Upgrade SHARMP16 Begin>> ---------------Drink-IT fields used
        // key(Key4;"Applies-to AAD Trck. Entry No.")
        // {
        // }// BC Upgrade SHARMP16 Begin>> ---------------Drink-IT fields used
        key(Key50002; "Item No.", "Whse. Receipt No.")
        {
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Nothing to handle.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=Nothing to handle.;FRA=Il n'y a rien à traiter.;
    //Variable type has not been exported.

    var
        WhseSetup: Record "Warehouse Setup";
}

