tableextension 50161 RoutingLineExtFND extends "Routing Line"
{
    //  DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008: BrewIt & Quality
    // DITW15.00.00.23 PRODW14.00.00.08.02 JFE 08/09/2008: Added the field "Qality Meausure Exist"
    // DITW15.00.00.27 PRODW14.03.00.08.05
    //   DOC K3BREWING  JJ  20/11/08 - Changed Quality Measure Exist flowfield to include Operation No. and set Editable: No
    // DITW15.00.00.30 PRODW14.00.00.09 DLE 20/01/09 : Added field for recurring test

    // FINXL7.00.001 RBE 20/03/2013: Item description extend from 30 -> 80 chars

    // MANXL7.00.001 DAT 24/02/2014 #11: Routing Line Speed parameter

    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // DITW110.00.09 AKH 30/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9

    // HEI.01 DefectID #1394 IBM HORTOC01 19.01.2018
    //   #new field added "Batch size"
    // HEI.02 FDD CHG2041183 HT938 IBM TUDOSG01 11.02.2020 # New fields: Zone Code, Bin Code
    // HEI.03 FDD-CHG2136735 IBM.PATHAA02 07.02.2022
    // # Code on Zone Code-Onlookup
    // # Prefiltered Zone Code based on Linked SKU for all versions
    // HEI.04 CHG2135085 SAHAL01      22.03.2022
    //   # Added Code to calculate cost on blank Version Code

    //BC UPGRADE PATHAA02 09.03.26 LineSpeed,LineSpeed UoM & Show on Prod Order fields to be added
    // HEI.05- "Show on Production Order"(DIT2035173-->50004) & "Line Speed"(DIT2036301-->50005) fields are moved to 50K series as part of BC Upgrade


    fields
    {
        modify("Routing No.")
        {
            CaptionML = ENU = 'Routing No.', FRA = 'N° gamme';
        }
        modify("Version Code")
        {
            CaptionML = ENU = 'Version Code', FRA = 'Code version';
        }
        modify("Operation No.")
        {
            CaptionML = ENU = 'Operation No.', FRA = 'N° opération';
        }
        modify("Next Operation No.")
        {
            CaptionML = ENU = 'Next Operation No.', FRA = 'N° opération suivante';
        }
        modify("Previous Operation No.")
        {
            CaptionML = ENU = 'Previous Operation No.', FRA = 'N° opération précédente';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            //OptionCaptionML = ENU = 'Work Center,Machine Center, ', FRA = 'Centre de charge,Poste de charge, ';
        }
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Work Center No.")
        {
            CaptionML = ENU = 'Work Center No.', FRA = 'N° centre de charge';
        }
        modify("Work Center Group Code")
        {
            CaptionML = ENU = 'Work Center Group Code', FRA = 'Code groupe centres de charge';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Setup Time")
        {
            CaptionML = ENU = 'Setup Time', FRA = 'Temps de préparation';
        }
        modify("Run Time")
        {
            CaptionML = ENU = 'Run Time', FRA = 'Temps d''exécution';
        }
        modify("Wait Time")
        {
            CaptionML = ENU = 'Wait Time', FRA = 'Temps d''attente';
        }
        modify("Move Time")
        {
            CaptionML = ENU = 'Move Time', FRA = 'Temps de transfert';
        }
        modify("Fixed Scrap Quantity")
        {
            CaptionML = ENU = 'Fixed Scrap Quantity', FRA = 'Quantité perte fixe';
        }
        modify("Lot Size")
        {
            CaptionML = ENU = 'Lot Size', FRA = 'Taille lot';
        }
        modify("Scrap Factor %")
        {
            CaptionML = ENU = 'Scrap Factor %', FRA = '% perte';
        }
        modify("Setup Time Unit of Meas. Code")
        {
            CaptionML = ENU = 'Setup Time Unit of Meas. Code', FRA = 'Unité temps de préparation';
        }
        modify("Run Time Unit of Meas. Code")
        {
            CaptionML = ENU = 'Run Time Unit of Meas. Code', FRA = 'Unité temps d''exécution';
        }
        modify("Wait Time Unit of Meas. Code")
        {
            CaptionML = ENU = 'Wait Time Unit of Meas. Code', FRA = 'Unité temps d''attente';
        }
        modify("Move Time Unit of Meas. Code")
        {
            CaptionML = ENU = 'Move Time Unit of Meas. Code', FRA = 'Unité temps de transfert';
        }
        modify("Minimum Process Time")
        {
            CaptionML = ENU = 'Minimum Process Time', FRA = 'Temps opératoire min.';
        }
        modify("Maximum Process Time")
        {
            CaptionML = ENU = 'Maximum Process Time', FRA = 'Temps opératoire max.';
        }
        modify("Concurrent Capacities")
        {
            CaptionML = ENU = 'Concurrent Capacities', FRA = 'Capacités simultanées';
        }
        modify("Send-Ahead Quantity")
        {
            CaptionML = ENU = 'Send-Ahead Quantity', FRA = 'Quantité de transfert';
        }
        modify("Routing Link Code")
        {
            CaptionML = ENU = 'Routing Link Code', FRA = 'Code lien gamme';
        }
        modify("Standard Task Code")
        {
            CaptionML = ENU = 'Standard Task Code', FRA = 'Code tâche standard';
        }
        modify("Unit Cost per")
        {
            CaptionML = ENU = 'Unit Cost per', FRA = 'Coût unitaire par';
        }
        modify(Recalculate)
        {
            CaptionML = ENU = 'Recalculate', FRA = 'Recalculer';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify("Sequence No. (Forward)")
        {
            CaptionML = ENU = 'Sequence No. (Forward)', FRA = 'N° séquence (aval)';
        }
        modify("Sequence No. (Backward)")
        {
            CaptionML = ENU = 'Sequence No. (Backward)', FRA = 'N° séquence (amont)';
        }
        modify("Fixed Scrap Qty. (Accum.)")
        {
            CaptionML = ENU = 'Fixed Scrap Qty. (Accum.)', FRA = 'Quantité perte fixe (cumulée)';
        }
        modify("Scrap Factor % (Accumulated)")
        {
            CaptionML = ENU = 'Scrap Factor % (Accumulated)', FRA = '% perte (cumulée)';
        }
        field(50000; "Batch Size FND"; Decimal)
        {
            Caption = 'Batch Size';
            Description = 'HEI.01';
        }
        field(50001; "Version Active FND"; Boolean)
        {
            caption = 'Version Active';
            CalcFormula = Lookup("Routing Version"."Active FND" where("Routing No." = FIELD("Routing No."),
                                                                 "Version Code" = FIELD("Version Code")));
            Description = 'HEI.01';
            FieldClass = FlowField;
        }
        field(50002; "Zone Code FND"; Code[10])
        {
            Caption = 'Zone Code';
            Description = 'HEI.02 TUDOSG01';
            TableRelation = Zone.Code where("Use As In-Transit FND" = FILTER(false));

            trigger OnLookup();
            var
                zone: Record Zone;
                zonelist: Page "Zone List";
            begin
                //HEI.03<<
                if "Routing No." <> '' then begin
                    if RoutingHeaderRec.GET(Rec."Routing No.") then
                        SKULocation := RoutingHeaderRec."Linked SKU FND";

                    zone.RESET();
                    zone.SETCURRENTKEY("Location Code");
                    zone.FILTERGROUP(50);
                    zone.SETFILTER("Location Code", SKULocation);

                    zonelist.SETTABLEVIEW(zone);
                    zonelist.LOOKUPMODE := true;

                    if zonelist.RUNMODAL() = ACTION::LookupOK then begin
                        "Zone Code FND" := zonelist.GetSelectionFilter();
                    end;
                    CLEAR(zonelist);
                    zone.FILTERGROUP(0);
                end;
                //HEI.03>>
            end;

            trigger OnValidate();
            begin
                "Bin Code FND" := ''; //HEI.02
            end;
        }
        field(50003; "Bin Code FND"; Code[20])
        {
            Caption = 'Bin Code';
            Description = 'HEI.02 TUDOSG01';
            TableRelation = Bin.Code where("Zone Code" = FIELD("Zone Code FND"));
        }

        //HEI.05>>
        field(50004; "Show on Production Order FND"; Boolean)
        {
            CaptionML = ENU = 'Show on Production Order',
                        FRA = 'Montrer sur Ordre de fabrication';
            InitValue = true;
        }
        field(50005; "Line Speed FND"; Decimal)
        {
            CaptionML = ENU = 'Line Speed',
                        FRA = 'Vitesse de ligne';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.05';

            trigger OnValidate();
            begin
                if "Line Speed FND" <> xRec."Line Speed FND" then begin
                    if "Line Speed FND" = 0 then
                        "Run Time" := 0
                    else
                        "Run Time" := 1 / "Line Speed FND";

                    recManufacturingSetup.RESET();
                    recManufacturingSetup.GET();
                    recManufacturingSetup.TESTFIELD("Line Speed UOM FND");
                    CLEAR(cduCalanderMgmt);
                    "Run Time" := "Run Time" * (cduCalanderMgmt.TimeFactor(recManufacturingSetup."Line Speed UOM FND") /
                                 cduCalanderMgmt.TimeFactor("Run Time Unit of Meas. Code"));
                end;
            end;
            //HEI.05<<
        }


        /* //BCUpgrade YADAVM09 Drink it field commented>>
        field(2035090; "Quality Measure Exist"; Boolean)
        {
            CalcFormula = Exist("Routing Quality Measure" where("Routing No." = FIELD("Routing No."),
                                                                 "Operation No." = FIELD("Operation No.")));
            CaptionML = ENU = 'Quality Measure Exist',
                        FRA = 'Mesure qualité existe';
            Description = 'QXL9.00.001';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2035159; "Completion Required"; Boolean)
        {
            CaptionML = ENU = 'Completion Required',
                        FRA = 'Achêvement requis';
            Description = 'Description=DITW15.00.00.22 PRODW14.00.00.08';
        }
        field(2035163; "Alert Time"; Decimal)
        {
            CaptionML = ENU = 'Alert Time',
                        FRA = 'Heure alerte';
            DecimalPlaces = 0 : 5;
            Description = 'Description=DITW15.00.00.22 PRODW14.00.00.08';
        }
        field(2035165; "Alert Time Unit of Meas. Code"; Code[10])
        {
            CaptionML = ENU = 'Alert Time Unit of Meas. Code',
                        FRA = 'Unité Heure alerte';
            Description = 'Description=DITW15.00.00.22 PRODW14.00.00.08';
            TableRelation = "Capacity Unit of Measure";
        }
        field(2035168; "Allow Alert Cancel"; Boolean)
        {
            CaptionML = ENU = 'Allow Alert Cancel',
                        FRA = 'Autoriser l''annulation d''alerte';
            Description = 'Description=DITW15.00.00.22 PRODW14.00.00.08';
        }
        field(2035173; "Show on Production Order"; Boolean)
        {
            CaptionML = ENU = 'Show on Production Order',
                        FRA = 'Montrer sur Ordre de fabrication';
            Description = 'Description=DITW15.00.00.22 PRODW14.00.00.08';
            InitValue = true;
        }
        field(2035175; "Next Test Within (Hours)"; Decimal)
        {
            CaptionML = ENU = 'Next Test Within (Hours)',
                        FRA = 'Proch.Test dans (Heures)';
            DecimalPlaces = 0 : 2;
            Description = 'DITW15.00.00.30 PRODW14.00.00.09';
        }
        field(2036301; "Line Speed"; Decimal)
        {
            CaptionML = ENU = 'Line Speed',
                        FRA = 'Vitesse de ligne';
            DecimalPlaces = 0 : 5;
            Description = 'MANXL7.00.001';

            trigger OnValidate();
            begin
                //<<MANXL7.00.001 DAT 24/02/2014 #1
                if "Line Speed" <> xRec."Line Speed" then begin
                    if "Line Speed" = 0 then
                        "Run Time" := 0
                    else
                        "Run Time" := 1 / "Line Speed";

                    recManufacturingSetup.RESET;
                    recManufacturingSetup.GET;
                    recManufacturingSetup.TESTFIELD("Line Speed UOM");
                    CLEAR(cduCalanderMgmt);
                    "Run Time" := "Run Time" * (cduCalanderMgmt.TimeFactor(recManufacturingSetup."Line Speed UOM") /
                                 cduCalanderMgmt.TimeFactor("Run Time Unit of Meas. Code"));

                end;
                //>>MANXL7.00.001 DAT 24/02/2014 #1

            end;
        }
          */ //BCUpgrade YADAVM09 Drink it field commented<<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    Procedure ActivateBlankVersionCode(IsBlankVersionCode: Boolean): Boolean
    begin
        //HEI.04>>
        ForBlankVersionCode := IsBlankVersionCode;
        //HEI.04<<
    end;


    var
        // cduCalanderMgmt: Codeunit CalendarManagement;//BC Upgrade YADAVM09 Codeunit not used in Code
        recManufacturingSetup: Record "Manufacturing Setup";
        RoutingHeaderRec: Record "Routing Header";
        ForBlankVersionCode: Boolean;
        SKULocation: Code[10];
        cduCalanderMgmt: Codeunit "Shop calendar management"; //CU99000755 //HEI.05


}

