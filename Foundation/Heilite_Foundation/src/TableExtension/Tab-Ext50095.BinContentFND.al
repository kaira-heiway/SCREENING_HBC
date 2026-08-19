tableextension 50095 BinContentExtFND extends "Bin Content"
{
    // version NAVW110.0.00.16585,DITW110.00.09,HEI.02
    // DITW16.00.00.40 DDR 03/05/2012 DIT-715 #292 SSCC Functionnalities
    //                                             Added fields
    //                                               2035056 SSCC Quantity (Base)
    //                     18/06/2012 DIT-715 #292 Added fields
    //                                               2035052 SSCC No. Filter

    // FINXL7.00.001 RBE 20/03/2013: Item description extend from 30 -> 80 chars

    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 AKH 31/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #Zone code development without whs advanced mgmt
    // HEI.02 FDD-LB IBM NASTAA02 15.10.2018 # Item Availability excluding Blocked Stock
    //   # New Fields created: 50001 - Available Inv. (Whse)
    //                         50002- Quantity Quality Hold (Base)
    //                         50003- Quantity Unrestricted (Base)
    //                         50004- Quantity Blocked (Base)
    // HEI.03 HT1615 BULIMC01 IBM 21.10.2020#new flowfields created: 50005-50022
    // HEI.04 INC3687884/CHG2125321 IBM.AK 07.09.21.
    //  # 3 tablefilters-Variant code,Location code & UOM Code added on calcformula for flowfield 50001-Available Inv. (Whse)
    fields
    {
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Zone Code")
        {

            //Unsupported feature: Change TableRelation on ""Zone Code"(Field 2)". Please convert manually.

            CaptionML = ENU = 'Zone Code', FRA = 'Code zone';
        }
        modify("Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""Bin Code"(Field 3)". Please convert manually.

            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement';
        }
        modify("Item No.")
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
        }
        modify("Bin Type Code")
        {
            CaptionML = ENU = 'Bin Type Code', FRA = 'Code type emplacement';
        }
        modify("Warehouse Class Code")
        {
            CaptionML = ENU = 'Warehouse Class Code', FRA = 'Code classe entrepôt';
        }
        modify("Block Movement")
        {
            CaptionML = ENU = 'Block Movement', FRA = 'Bloquer mouvement';
            OptionCaptionML = ENU = ' ,Inbound,Outbound,All', FRA = ' ,Enlogement,Désenlogement,Tous';
        }
        modify("Min. Qty.")
        {
            CaptionML = ENU = 'Min. Qty.', FRA = 'Qté min.';
        }
        modify("Max. Qty.")
        {
            CaptionML = ENU = 'Max. Qty.', FRA = 'Qté max.';
        }
        modify("Bin Ranking")
        {
            CaptionML = ENU = 'Bin Ranking', FRA = 'Priorité emplacement';
        }
        modify(Quantity)
        {

            //Unsupported feature: Change CalcFormula on "Quantity(Field 26)". Please convert manually.

            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Pick Qty.")
        {

            //Unsupported feature: Change CalcFormula on ""Pick Qty."(Field 29)". Please convert manually.

            CaptionML = ENU = 'Pick Qty.', FRA = 'Prélever qté';
        }
        modify("Neg. Adjmt. Qty.")
        {

            //Unsupported feature: Change CalcFormula on ""Neg. Adjmt. Qty."(Field 30)". Please convert manually.

            CaptionML = ENU = 'Neg. Adjmt. Qty.', FRA = 'Qté ajust. négatif';
        }
        modify("Put-away Qty.")
        {

            //Unsupported feature: Change CalcFormula on ""Put-away Qty."(Field 31)". Please convert manually.

            CaptionML = ENU = 'Put-away Qty.', FRA = 'Qté rangement';
        }
        modify("Pos. Adjmt. Qty.")
        {

            //Unsupported feature: Change CalcFormula on ""Pos. Adjmt. Qty."(Field 32)". Please convert manually.

            CaptionML = ENU = 'Pos. Adjmt. Qty.', FRA = 'Qté ajust. positif';
        }
        modify("Fixed")
        {
            CaptionML = ENU = 'Fixed', FRA = 'Statique';
        }
        modify("Cross-Dock Bin")
        {
            CaptionML = ENU = 'Cross-Dock Bin', FRA = 'Emplacement transbordement';
        }
        modify(Default)
        {
            CaptionML = ENU = 'Default', FRA = 'Par défaut';
        }
        modify("Quantity (Base)")
        {

            //Unsupported feature: Change CalcFormula on ""Quantity (Base)"(Field 50)". Please convert manually.

            CaptionML = ENU = 'Quantity (Base)', FRA = 'Quantité (base)';
        }
        modify("Pick Quantity (Base)")
        {

            //Unsupported feature: Change CalcFormula on ""Pick Quantity (Base)"(Field 51)". Please convert manually.

            CaptionML = ENU = 'Pick Quantity (Base)', FRA = 'Quantité prélèvement (base)';
        }
        modify("Negative Adjmt. Qty. (Base)")
        {

            //Unsupported feature: Change CalcFormula on ""Negative Adjmt. Qty. (Base)"(Field 52)". Please convert manually.

            CaptionML = ENU = 'Negative Adjmt. Qty. (Base)', FRA = 'Qté Ajust. négatif (base)';
        }
        modify("Put-away Quantity (Base)")
        {

            //Unsupported feature: Change CalcFormula on ""Put-away Quantity (Base)"(Field 53)". Please convert manually.

            CaptionML = ENU = 'Put-away Quantity (Base)', FRA = 'Quantité rangement (base)';
        }
        modify("Positive Adjmt. Qty. (Base)")
        {

            //Unsupported feature: Change CalcFormula on ""Positive Adjmt. Qty. (Base)"(Field 54)". Please convert manually.

            CaptionML = ENU = 'Positive Adjmt. Qty. (Base)', FRA = 'Qté Ajust. positif (base)';
        }
        modify("ATO Components Pick Qty.")
        {

            //Unsupported feature: Change CalcFormula on ""ATO Components Pick Qty."(Field 55)". Please convert manually.

            CaptionML = ENU = 'ATO Components Pick Qty.', FRA = 'Qté à prélever composants ATO';
        }
        modify("ATO Components Pick Qty (Base)")
        {

            //Unsupported feature: Change CalcFormula on ""ATO Components Pick Qty (Base)"(Field 56)". Please convert manually.

            CaptionML = ENU = 'ATO Components Pick Qty (Base)', FRA = 'Qté à prélever composants ATO (Base)';
        }
        modify("Variant Code")
        {

            //Unsupported feature: Change TableRelation on ""Variant Code"(Field 5402)". Please convert manually.

            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
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
        modify("Lot No. Filter")
        {
            CaptionML = ENU = 'Lot No. Filter', FRA = 'Filtre n° lot';
        }
        modify("Serial No. Filter")
        {
            CaptionML = ENU = 'Serial No. Filter', FRA = 'Filtre n° de série';
        }
        modify(Dedicated)
        {
            CaptionML = ENU = 'Dedicated', FRA = 'Dédié';
        }
        modify("Unit of Measure Filter")
        {

            //Unsupported feature: Change TableRelation on ""Unit of Measure Filter"(Field 6503)". Please convert manually.

            CaptionML = ENU = 'Unit of Measure Filter', FRA = 'Filtre unité';
        }

        //Unsupported feature: CodeModification on ""Location Code"(Field 1).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (CurrFieldNo <> 0) AND ("Location Code" <> xRec."Location Code") THEN BEGIN
          CheckManualChange(FIELDCAPTION("Location Code"));
          "Bin Code" := '';
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (CurrFieldNo <> 0) and ("Location Code" <> xRec."Location Code") then begin
          CheckManualChange(FIELDCAPTION("Location Code"));
          "Bin Code" := '';
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Zone Code"(Field 2).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (CurrFieldNo <> 0) AND ("Zone Code" <> xRec."Zone Code") THEN
          CheckManualChange(FIELDCAPTION("Zone Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (CurrFieldNo <> 0) and ("Zone Code" <> xRec."Zone Code") then
          CheckManualChange(FIELDCAPTION("Zone Code"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Bin Code"(Field 3).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (CurrFieldNo <> 0) AND ("Bin Code" <> xRec."Bin Code") THEN BEGIN
          CheckManualChange(FIELDCAPTION("Bin Code"));
          GetBin("Location Code","Bin Code");
          Dedicated := Bin.Dedicated;
          "Bin Type Code" := Bin."Bin Type Code";
          "Warehouse Class Code" := Bin."Warehouse Class Code";
          "Bin Ranking" := Bin."Bin Ranking";
          "Block Movement" := Bin."Block Movement";
          "Zone Code" := Bin."Zone Code";
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (CurrFieldNo <> 0) and ("Bin Code" <> xRec."Bin Code") then begin
        #2..9
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Item No."(Field 4).OnValidate". Please convert manually.

        //trigger "(Field 4)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (CurrFieldNo <> 0) AND ("Item No." <> xRec."Item No.") THEN BEGIN
          CheckManualChange(FIELDCAPTION("Item No."));
          "Variant Code" := '';
        end;

        IF ("Item No." <> xRec."Item No.") AND ("Item No." <> '') THEN BEGIN
          GetItem("Item No.");
          VALIDATE("Unit of Measure Code",Item."Base Unit of Measure");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (CurrFieldNo <> 0) and ("Item No." <> xRec."Item No.") then begin
          CheckManualChange(FIELDCAPTION("Item No."));
          "Variant Code" := '';
        end;

        if ("Item No." <> xRec."Item No.") and ("Item No." <> '') then begin
          GetItem("Item No.");
          VALIDATE("Unit of Measure Code",Item."Base Unit of Measure");
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Max. Qty."(Field 16).OnValidate". Please convert manually.

        //trigger  Qty();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Max. Qty." <> xRec."Max. Qty." THEN
          CheckBinMaxCubageAndWeight;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Max. Qty." <> xRec."Max. Qty." then
          CheckBinMaxCubageAndWeight;
        */
        //end;


        //Unsupported feature: CodeModification on "Default(Field 41).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (xRec.Default <> Default) AND Default THEN
          IF WMSManagement.CheckDefaultBin(
               "Item No.","Variant Code","Location Code","Bin Code")
          THEN
            ERROR(Text010,"Location Code","Item No.","Variant Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (xRec.Default <> Default) and Default then
          if WMSManagement.CheckDefaultBin(
               "Item No.","Variant Code","Location Code","Bin Code")
          then
            ERROR(Text010,"Location Code","Item No.","Variant Code");
        */
        //end;


        //Unsupported feature: CodeModification on ""Variant Code"(Field 5402).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (CurrFieldNo <> 0) AND ("Variant Code" <> xRec."Variant Code") THEN
          CheckManualChange(FIELDCAPTION("Variant Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (CurrFieldNo <> 0) and ("Variant Code" <> xRec."Variant Code") then
          CheckManualChange(FIELDCAPTION("Variant Code"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit of Measure Code"(Field 5407).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (CurrFieldNo <> 0) AND ("Unit of Measure Code" <> xRec."Unit of Measure Code") THEN
          CheckManualChange(FIELDCAPTION("Unit of Measure Code"));

        GetItem("Item No.");
        "Qty. per Unit of Measure" :=
          UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (CurrFieldNo <> 0) and ("Unit of Measure Code" <> xRec."Unit of Measure Code") then
        #2..6
        */
        //end;
        field(50000; "Item Description FND"; Text[100])
        {
            CalcFormula = Lookup(Item.Description where("No." = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Item Description';
        }
        field(50001; "Available Inv. (Whse) FND"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry".Quantity where("Item No." = FIELD("Item No."),
                                                                "Bin Code" = FIELD("Bin Code"),
                                                                "Unavailable Stock (Bin) FND" = CONST(false),
                                                                "Unavail. Stock (Quality) FND" = CONST(false),
                                                                "Location Code" = FIELD("Location Code"),
                                                                "Variant Code" = FIELD("Variant Code"),
                                                                "Unit of Measure Code" = FIELD("Unit of Measure Code")));
            DecimalPlaces = 0 : 5;
            Description = 'HEI.02';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Available Inventory (Warehouse)';
        }
        field(50002; "Quantity Qual Hold (Base) FND"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry"."Qty. (Base)" where("Location Code" = FIELD("Location Code"),
                                                                     "Bin Code" = FIELD("Bin Code"),
                                                                     "Item No." = FIELD("Item No."),
                                                                     "Variant Code" = FIELD("Variant Code"),
                                                                     "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                                     "Lot No." = FIELD("Lot No. Filter"),
                                                                     "Serial No." = FIELD("Serial No. Filter"),
                                                                     "Inspection Status FND" = CONST('ON HOLD'))); //Bc Upgrade PATHAA02 GAP014_DTW, IBM GAP DTW 43
            DecimalPlaces = 0 : 5;
            Description = 'HEI.02';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Quantity Quality Hold (Base)';
        }
        field(50003; "Quantity Unrestrict (Base) FND"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry"."Qty. (Base)" where("Location Code" = FIELD("Location Code"),
                                                                     "Bin Code" = FIELD("Bin Code"),
                                                                     "Item No." = FIELD("Item No."),
                                                                     "Variant Code" = FIELD("Variant Code"),
                                                                     "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                                     "Lot No." = FIELD("Lot No. Filter"),
                                                                     "Serial No." = FIELD("Serial No. Filter"),
                                                                     "Inspection Status FND" = CONST('UNBLOCKED'))); //Bc Upgrade PATHAA02 GAP014_DTW, IBM GAP DTW 43
            DecimalPlaces = 0 : 5;
            Description = 'HEI.02';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Quantity Unrestricted (Base)';
        }
        field(50004; "Quantity Blocked (Base) FND"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry"."Qty. (Base)" where("Location Code" = FIELD("Location Code"),
                                                                     "Bin Code" = FIELD("Bin Code"),
                                                                     "Item No." = FIELD("Item No."),
                                                                     "Variant Code" = FIELD("Variant Code"),
                                                                     "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                                     "Lot No." = FIELD("Lot No. Filter"),
                                                                     "Serial No." = FIELD("Serial No. Filter"),
                                                                     "Inspection Status FND" = CONST('BLOCKED'))); //Bc Upgrade PATHAA02 GAP014_DTW, IBM GAP DTW 43
            DecimalPlaces = 0 : 5;
            Description = 'HEI.02';
            Caption = 'Quantity Blocked (Base)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Item Category Code FND"; Code[20])
        {
            CalcFormula = Lookup(Item."Item Category Code" where("No." = FIELD("Item No.")));
            Caption = 'Item Category Code';
            Description = 'HEI.03';
            FieldClass = FlowField;
            TableRelation = "Item Category";
        }
        field(50006; "Opening Stock FND"; Decimal)
        {
            Description = 'HEI.03';
            Caption = 'Opening Stock';
            Editable = false;
        }
        field(50007; "Unit Cost Opening Stock FND"; Decimal)
        {
            Description = 'HEI.03';
            Caption = 'Unit Cost Opening Stock';
            Editable = false;
        }
        field(50008; "Purchase Receipts FND"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry"."Qty. (Base)" where("Location Code" = FIELD("Location Code"),
                                                                     "Bin Code" = FIELD("Bin Code"),
                                                                     "Item No." = FIELD("Item No."),
                                                                     "Variant Code" = FIELD("Variant Code"),
                                                                     "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                                     "Lot No." = FIELD("Lot No. Filter"),
                                                                     "Serial No." = FIELD("Serial No. Filter"),
                                                                     "Registering Date" = FIELD(FILTER("Date Filter FND")),
                                                                     "Entry Type" = FILTER("Positive Adjmt." | "Negative Adjmt."),
                                                                     "Source Document" = FILTER("P. Order" | "P. Invoice" | "P. Credit Memo" | "P. Return Order")));
            Description = 'HEI.03';
            Caption = 'Purchase Receipts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50009; "Production Output FND"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry"."Qty. (Base)" where("Location Code" = FIELD("Location Code"),
                                                                     "Bin Code" = FIELD("Bin Code"),
                                                                     "Item No." = FIELD("Item No."),
                                                                     "Variant Code" = FIELD("Variant Code"),
                                                                     "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                                     "Lot No." = FIELD("Lot No. Filter"),
                                                                     "Serial No." = FIELD("Serial No. Filter"),
                                                                     "Registering Date" = FIELD(FILTER("Date Filter FND")),
                                                                     "Entry Type" = FILTER("Positive Adjmt." | "Negative Adjmt."),
                                                                     "Source Document" = FILTER("Output Jnl." | "Assembly Order" | "BOM Jnl." | "Job Jnl.")));
            Description = 'HEI.03';
            Caption = 'Production Output';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; "Positive Adjustment FND"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry"."Qty. (Base)" where("Location Code" = FIELD("Location Code"),
                                                                     "Bin Code" = FIELD("Bin Code"),
                                                                     "Item No." = FIELD("Item No."),
                                                                     "Variant Code" = FIELD("Variant Code"),
                                                                     "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                                     "Lot No." = FIELD("Lot No. Filter"),
                                                                     "Serial No." = FIELD("Serial No. Filter"),
                                                                     "Registering Date" = FIELD(FILTER("Date Filter FND")),
                                                                     "Entry Type" = FILTER("Positive Adjmt."),
                                                                     "Source Document" = FILTER("Item Jnl." | "Phys. Invt. Jnl." | "Reclass. Jnl.")));
            Description = 'HEI.03';
            Caption = 'Positive Adjustment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "Negative Adjustment FND"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry"."Qty. (Base)" where("Location Code" = FIELD("Location Code"),
                                                                     "Bin Code" = FIELD("Bin Code"),
                                                                     "Item No." = FIELD("Item No."),
                                                                     "Variant Code" = FIELD("Variant Code"),
                                                                     "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                                     "Lot No." = FIELD("Lot No. Filter"),
                                                                     "Serial No." = FIELD("Serial No. Filter"),
                                                                     "Registering Date" = FIELD(FILTER("Date Filter FND")),
                                                                     "Entry Type" = FILTER("Negative Adjmt."),
                                                                     "Source Document" = FILTER("Item Jnl." | "Phys. Invt. Jnl." | "Reclass. Jnl.")));
            Description = 'HEI.03';
            Caption = 'Negative Adjustment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50012; "Production Consumption FND"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry"."Qty. (Base)" where("Location Code" = FIELD("Location Code"),
                                                                     "Bin Code" = FIELD("Bin Code"),
                                                                     "Item No." = FIELD("Item No."),
                                                                     "Variant Code" = FIELD("Variant Code"),
                                                                     "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                                     "Lot No." = FIELD("Lot No. Filter"),
                                                                     "Serial No." = FIELD("Serial No. Filter"),
                                                                     "Registering Date" = FIELD(FILTER("Date Filter FND")),
                                                                     "Entry Type" = FILTER("Positive Adjmt." | "Negative Adjmt."),
                                                                     "Source Document" = FILTER("Prod. Consumption" | "Consumption Jnl." | "Assembly Consumption" | "Serv. Order")));
            Description = 'HEI.03';
            Caption = 'Production Consumption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50013; "Transfers FND"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry"."Qty. (Base)" where("Location Code" = FIELD("Location Code"),
                                                                     "Bin Code" = FIELD("Bin Code"),
                                                                     "Item No." = FIELD("Item No."),
                                                                     "Variant Code" = FIELD("Variant Code"),
                                                                     "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                                     "Lot No." = FIELD("Lot No. Filter"),
                                                                     "Serial No." = FIELD("Serial No. Filter"),
                                                                     "Registering Date" = FIELD(FILTER("Date Filter FND")),
                                                                     "Entry Type" = FILTER("Positive Adjmt." | "Negative Adjmt."),
                                                                     "Source Document" = FILTER("Inb. Transfer" | "Outb. Transfer")));
            Description = 'HEI.03';
            Editable = false;
            Caption = 'Transfers';
            FieldClass = FlowField;
        }
        field(50014; "Sales Shipments FND"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry"."Qty. (Base)" where("Location Code" = FIELD("Location Code"),
                                                                     "Bin Code" = FIELD("Bin Code"),
                                                                     "Item No." = FIELD("Item No."),
                                                                     "Variant Code" = FIELD("Variant Code"),
                                                                     "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                                     "Lot No." = FIELD("Lot No. Filter"),
                                                                     "Serial No." = FIELD("Serial No. Filter"),
                                                                     "Registering Date" = FIELD(FILTER("Date Filter FND")),
                                                                     "Entry Type" = FILTER("Positive Adjmt." | "Negative Adjmt."),
                                                                     "Source Document" = FILTER("S. Order" | "S. Invoice" | "S. Credit Memo" | "S. Return Order")));
            Description = 'HEI.03';
            Editable = false;
            Caption = 'Sales Shipments';
            FieldClass = FlowField;
        }
        field(50015; "Final Stock FND"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry"."Qty. (Base)" where("Location Code" = FIELD("Location Code"),
                                                                     "Bin Code" = FIELD("Bin Code"),
                                                                     "Item No." = FIELD("Item No."),
                                                                     "Variant Code" = FIELD("Variant Code"),
                                                                     "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                                     "Lot No." = FIELD("Lot No. Filter"),
                                                                     "Serial No." = FIELD("Serial No. Filter"),
                                                                     "Registering Date" = FIELD(UPPERLIMIT("Date Filter FND"))));
            Description = 'HEI.03';
            Caption = 'Final Stock';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50016; "Unit Cost Final Stock FND"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry"."Qty. (Base)" where("Location Code" = FIELD("Location Code"),
                                                                     "Bin Code" = FIELD("Bin Code"),
                                                                     "Item No." = FIELD("Item No."),
                                                                     "Variant Code" = FIELD("Variant Code"),
                                                                     "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                                     "Lot No." = FIELD("Lot No. Filter"),
                                                                     "Serial No." = FIELD("Serial No. Filter"),
                                                                     "Registering Date" = FIELD(FILTER("Date Filter FND")),
                                                                     "Entry Type" = FILTER("Positive Adjmt." | "Negative Adjmt."),
                                                                     "Source Document" = FILTER("Output Jnl." | "Assembly Order" | "BOM Jnl." | "Job Jnl.")));
            Description = 'HEI.03';
            Caption = 'Unit Cost Final Stock';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50017; "Total Value Final Stock FND"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry"."Qty. (Base)" where("Location Code" = FIELD("Location Code"),
                                                                     "Bin Code" = FIELD("Bin Code"),
                                                                     "Item No." = FIELD("Item No."),
                                                                     "Variant Code" = FIELD("Variant Code"),
                                                                     "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                                     "Lot No." = FIELD("Lot No. Filter"),
                                                                     "Serial No." = FIELD("Serial No. Filter"),
                                                                     "Registering Date" = FIELD(FILTER("Date Filter FND")),
                                                                     "Entry Type" = FILTER("Positive Adjmt." | "Negative Adjmt."),
                                                                     "Source Document" = FILTER("Output Jnl." | "Assembly Order" | "BOM Jnl." | "Job Jnl.")));
            Description = 'HEI.03';
            Caption = 'Total Value Final Stock';
            FieldClass = FlowField;
        }
        field(50020; "Date Filter FND"; Date)
        {
            Description = 'HEI.03';
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(50021; "Internal Transfers FND"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry"."Qty. (Base)" where("Location Code" = FIELD("Location Code"),
                                                                     "Bin Code" = FIELD("Bin Code"),
                                                                     "Item No." = FIELD("Item No."),
                                                                     "Variant Code" = FIELD("Variant Code"),
                                                                     "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                                     "Lot No." = FIELD("Lot No. Filter"),
                                                                     "Serial No." = FIELD("Serial No. Filter"),
                                                                     "Registering Date" = FIELD(FILTER("Date Filter FND")),
                                                                     "Entry Type" = FILTER(Movement)));
            Description = 'HEI.03';
            Caption = 'Internal Transfers';
            FieldClass = FlowField;
        }
        field(50022; "Inventory Posting Group FND"; Code[20])
        {
            CalcFormula = Lookup(Item."Inventory Posting Group" where("No." = FIELD("Item No.")));
            Caption = 'Inventory Posting Group';
            Description = 'HEI.03';
            FieldClass = FlowField;
            TableRelation = "Inventory Posting Group";
        }
        // field(2035052; "SSCC No. Filter"; Code[50])
        // {
        //     CaptionML = ENU = 'SSCC No. Filter',
        //                 FRA = 'Filtre N° SSCC';
        //     Description = 'DIT-715 #292';
        //     FieldClass = FlowFilter;
        // }
        // field(2035056; "SSCC Quantity (Base)"; Decimal)
        // {
        //     CalcFormula = Sum("SSCC Ledger Entry".Quantity where("Location Code" = FIELD("Location Code"),
        //                                                           "Bin Code" = FIELD("Bin Code"),
        //                                                           "Item No." = FIELD("Item No."),
        //                                                           "Variant Code" = FIELD("Variant Code"),
        //                                                           "Lot No." = FIELD("Lot No. Filter"),
        //                                                           "SSCC No." = FIELD("SSCC No. Filter")));
        //     CaptionML = ENU = 'SSCC Quantity (Base)',
        //                 FRA = 'SSCC Quantité (base)';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DIT-715 #292';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }  // BC Upgrade NANDIS03
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    BinContent := Rec;
    BinContent.CALCFIELDS(
      "Quantity (Base)","Pick Quantity (Base)","Negative Adjmt. Qty. (Base)",
      "Put-away Quantity (Base)","Positive Adjmt. Qty. (Base)");
    IF BinContent."Quantity (Base)" <> 0 THEN
      ERROR(Text000,TABLECAPTION);

    IF (BinContent."Pick Quantity (Base)" <> 0) OR (BinContent."Negative Adjmt. Qty. (Base)" <> 0) OR
       (BinContent."Put-away Quantity (Base)" <> 0) OR (BinContent."Positive Adjmt. Qty. (Base)" <> 0)
    THEN
      ERROR(Text001,TABLECAPTION);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    if BinContent."Quantity (Base)" <> 0 then
      ERROR(Text000,TABLECAPTION);

    if (BinContent."Pick Quantity (Base)" <> 0) or (BinContent."Negative Adjmt. Qty. (Base)" <> 0) or
       (BinContent."Put-away Quantity (Base)" <> 0) or (BinContent."Positive Adjmt. Qty. (Base)" <> 0)
    then
      ERROR(Text001,TABLECAPTION);
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Default THEN
      IF WMSManagement.CheckDefaultBin(
           "Item No.","Variant Code","Location Code","Bin Code")
      THEN
        ERROR(Text010,"Location Code","Item No.","Variant Code");

    GetLocation("Location Code");
    IF Location."Directed Put-away and Pick" THEN
      TESTFIELD("Zone Code")
    else
      TESTFIELD("Zone Code",'');

    IF "Min. Qty." > "Max. Qty." THEN
      ERROR(
        Text005,
        FIELDCAPTION("Max. Qty."),"Max. Qty.",
        FIELDCAPTION("Min. Qty."),"Min. Qty.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if Default then
      if WMSManagement.CheckDefaultBin(
           "Item No.","Variant Code","Location Code","Bin Code")
      then
    #5..7
    //HEI.01 PRDGAP024 PRDGAP024>>
    if Location."Zone Mandatory" then
      TESTFIELD("Zone Code") else
    //HEI.01 PRDGAP024<<
    if Location."Directed Put-away and Pick" then
      TESTFIELD("Zone Code")
    else
      TESTFIELD("Zone Code",'');

    if "Min. Qty." > "Max. Qty." then
    #14..17
    */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Default THEN
      IF WMSManagement.CheckDefaultBin(
           "Item No.","Variant Code","Location Code","Bin Code")
      THEN
        ERROR(Text010,"Location Code","Item No.","Variant Code");

    GetLocation("Location Code");
    IF Location."Directed Put-away and Pick" THEN
      TESTFIELD("Zone Code")
    else
      TESTFIELD("Zone Code",'');

    IF "Min. Qty." > "Max. Qty." THEN
      ERROR(
        Text005,
        FIELDCAPTION("Max. Qty."),"Max. Qty.",
        FIELDCAPTION("Min. Qty."),"Min. Qty.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if Default then
      if WMSManagement.CheckDefaultBin(
           "Item No.","Variant Code","Location Code","Bin Code")
      then
    #5..7
    //HEI.01 PRDGAP024 PRDGAP024>>
    if Location."Zone Mandatory" then
      TESTFIELD("Zone Code") else
    //HEI.01 PRDGAP024<<

    if Location."Directed Put-away and Pick" then
      TESTFIELD("Zone Code")
    else
      TESTFIELD("Zone Code",'');

    if "Min. Qty." > "Max. Qty." then
    #14..17
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        retval: Decimal;


    //Unsupported feature: PropertyModification on "Text000(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You cannot delete this %1, because the %1 contains items.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot delete this %1, because the %1 contains items.;FRA=Vous ne pouvez pas supprimer %1, car %1 contient du stock.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot delete this %1, because warehouse document lines have items allocated to this %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot delete this %1, because warehouse document lines have items allocated to this %1.;FRA=Vous ne pouvez pas supprimer cet %1, car il existe des lignes document entrepôt avec des articles affectés cet %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=The total cubage %1 of the %2 for the %5 exceeds the %3 %4 of the %5.\Do you still want enter this %2?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=The total cubage %1 of the %2 for the %5 exceeds the %3 %4 of the %5.\Do you still want enter this %2?;FRA=Le cubage total %1 de la %2 pour l' %5 dépasse le %3 %4 de l'%5.\Souhaitez-vous entrer cette %2 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=The total weight %1 of the %2 for the %5 exceeds the %3 %4 of the %5.\Do you still want enter this %2?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=The total weight %1 of the %2 for the %5 exceeds the %3 %4 of the %5.\Do you still want enter this %2?;FRA=Le poids total %1 de la %2 pour l' %5 dépasse le %3 %4 de l'%5.\Souhaitez-vous entrer cette %2 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=Cancelled.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=Cancelled.;FRA=Annulé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=The %1 %2 must not be less than the %3 %4.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=The %1 %2 must not be less than the %3 %4.;FRA=La %1 %2 ne doit pas être inférieure à la %3 %4.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=available must not be less than %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=available must not be less than %1;FRA=disponible ne doit pas être inférieur(e) à %1;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=You cannot modify the %1, because the %2 contains items.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=You cannot modify the %1, because the %2 contains items.;FRA=Vous ne pouvez pas modifier l'enregistrement %1, car l'enregistrement %2 comporte des articles.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=You cannot modify the %1, because warehouse document lines have items allocated to this %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=You cannot modify the %1, because warehouse document lines have items allocated to this %2.;FRA=Vous ne pouvez pas modifier l'enregistrement %1, car les lignes document entrepôt comportent des articles affectés à l'enregistrement %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text009(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU=You must first set up user %1 as a warehouse employee.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : ENU=You must first set up user %1 as a warehouse employee.;FRA=Vous devez d'abord configurer l'utilisateur %1 en tant que magasinier.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text010(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text010 : ENU=There is already a default bin content for location code %1, item no. %2 and variant code %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text010 : ENU=There is already a default bin content for location code %1, item no. %2 and variant code %3.;FRA=Il existe déjà un contenu emplacement par défaut pour le code magasin %1, le n° article %2 et le code variante %3.;
    //Variable type has not been exported.
}

