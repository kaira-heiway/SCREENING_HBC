tableextension 50171 ProdOrderRoutingLineExtFND extends "Prod. Order Routing Line"
{
    // version NAVW110.0,FINXL9.00.000.01,MANXL8.00.001,QXL9.00.001,DITW110.00.09
    //     HEI.01 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New key added: "No.,Type"
    //*****************************************************************************************
    // BC UPGRADE PATHAA02 11.11.25-Done
    //1. DIT fields and Keys linked to DIT fields are commented
    //2. Key50000, not related to DIT is retained.
    //HEI.01-Key50001 added-Done
    //*****************************************************************************************
    //HEI.02 09.03.26 BC UPGRADE PATHAA02 -FDD -Line Speed field to be added from DIT
    //# Field-50004 & 50005-"Show on Production Order" & "Line Speed" with Validations added from DIT fields.
    //# Validations on "Line Speed" and "Run time" (Onaftervalidate) added from NAV-DIT.  


    fields
    {
        modify("Routing No.")
        {
            CaptionML = ENU = 'Routing No.', FRA = 'N° gamme';
        }
        modify("Routing Reference No.")
        {
            CaptionML = ENU = 'Routing Reference No.', FRA = 'N° référence gamme';
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
            //OptionCaptionML = ENU = 'Work Center,Machine Center', FRA = 'Centre de charge,Poste de charge';
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
            //HEI.02>>
            trigger OnAfterValidate()
            begin
                //IF rMANXLSetup.READPERMISSION THEN BEGIN
                IF "Run Time" <> xRec."Run Time" THEN BEGIN
                    IF "Run Time" = 0 THEN
                        "Line Speed FND" := 0
                    ELSE
                        "Line Speed FND" := 1 / "Run Time";
                    recManufacturingSetup.RESET();
                    recManufacturingSetup.GET();
                    recManufacturingSetup.TESTFIELD("Line Speed UOM FND");
                    CLEAR(cduCalanderMgmt);
                    "Line Speed FND" := "Line Speed FND" * (cduCalanderMgmt.TimeFactor(recManufacturingSetup."Line Speed UOM FND") /
                                 cduCalanderMgmt.TimeFactor("Run Time Unit of Meas. Code"));
                END;
            END;
            //HEI.02<<
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
        modify("Sequence No. (Actual)")
        {
            CaptionML = ENU = 'Sequence No. (Actual)', FRA = 'N° séquence (réel)';
        }
        modify("Direct Unit Cost")
        {
            CaptionML = ENU = 'Direct Unit Cost', FRA = 'Coût unitaire direct';
        }
        modify("Indirect Cost %")
        {
            CaptionML = ENU = 'Indirect Cost %', FRA = '% coût indirect';
        }
        modify("Overhead Rate")
        {
            CaptionML = ENU = 'Overhead Rate', FRA = 'Frais généraux';
        }
        modify("Starting Time")
        {
            CaptionML = ENU = 'Starting Time', FRA = 'Heure début';
        }
        modify("Starting Date")
        {
            CaptionML = ENU = 'Starting Date', FRA = 'Date début';
        }
        modify("Ending Time")
        {
            CaptionML = ENU = 'Ending Time', FRA = 'Heure fin';
        }
        modify("Ending Date")
        {
            CaptionML = ENU = 'Ending Date', FRA = 'Date fin';
        }
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            //OptionCaptionML = ENU = 'Simulated,Planned,Firm Planned,Released,Finished', FRA = 'Simulé,Planifié,Planifié ferme,Lancé,Terminé';
        }
        modify("Prod. Order No.")
        {
            CaptionML = ENU = 'Prod. Order No.', FRA = 'N° ordre de fabrication';
        }
        modify("Unit Cost Calculation")
        {
            CaptionML = ENU = 'Unit Cost Calculation', FRA = 'Unité de coût';
            //OptionCaptionML = ENU = 'Time,Units', FRA = 'Temps,Quantité';
        }
        modify("Input Quantity")
        {
            CaptionML = ENU = 'Input Quantity', FRA = 'Quantité d''entrée';
        }
        modify("Critical Path")
        {
            CaptionML = ENU = 'Critical Path', FRA = 'Chemin critique';
        }
        modify("Routing Status")
        {
            CaptionML = ENU = 'Routing Status', FRA = 'Statut gamme';
            //OptionCaptionML = ENU = ' ,Planned,In Progress,Finished', FRA = ' ,Planifiée,En cours,Terminée';
        }
        modify("Flushing Method")
        {
            CaptionML = ENU = 'Flushing Method', FRA = 'Méthode consommation';
            //OptionCaptionML = ENU = 'Manual,Forward,Backward', FRA = 'Manuelle,Pré-déduction,Post-déduction';
        }
        modify("Expected Operation Cost Amt.")
        {
            CaptionML = ENU = 'Expected Operation Cost Amt.', FRA = 'Coût opératoire total prévu';
        }
        modify("Expected Capacity Need")
        {
            CaptionML = ENU = 'Expected Capacity Need', FRA = 'Charge prévue';
        }
        modify("Expected Capacity Ovhd. Cost")
        {
            CaptionML = ENU = 'Expected Capacity Ovhd. Cost', FRA = 'Frais gén. opératoires prévus';
        }
        modify("Starting Date-Time")
        {
            CaptionML = ENU = 'Starting Date-Time', FRA = 'Date/Heure début';
        }
        modify("Ending Date-Time")
        {
            CaptionML = ENU = 'Ending Date-Time', FRA = 'Date/Heure fin';
        }
        modify("Schedule Manually")
        {
            CaptionML = ENU = 'Schedule Manually', FRA = 'Planifier manuellement';
        }
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Open Shop Floor Bin Code")
        {
            CaptionML = ENU = 'Open Shop Floor Bin Code', FRA = 'Code empl. atelier ouvert';
        }
        modify("To-Production Bin Code")
        {
            CaptionML = ENU = 'To-Production Bin Code', FRA = 'Code empl. des consommations';
        }
        modify("From-Production Bin Code")
        {
            CaptionML = ENU = 'From-Production Bin Code', FRA = 'Code empl. après production';
        }

        //HEI.02>>
        field(50004; "Show on Production Order FND"; Boolean)
        {
            CaptionML = ENU = 'Show on Production Order',
                        FRA = 'Montrer sur Ordre de fabrication';
            Editable = false;
        }
        field(50005; "Line Speed FND"; Decimal)
        {
            CaptionML = ENU = 'Line Speed',
                        FRA = 'Vitesse de ligne';
            DecimalPlaces = 0 : 5;

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
                    CalcStartingEndingDates(Direction::Forward);
                end;
            end;
        }
        //HEI.02<<

        //Unsupported feature: CodeModification on ""Run Time"(Field 13).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CalcStartingEndingDates(Direction::Forward);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CalcStartingEndingDates(Direction::Forward);
        //<<MANXL7.00.001 WSA 11/07/2014 #87
        if rMANXLSetup.READPERMISSION then begin
        //>>MANXL7.00.001 WSA 11/07/2014 #87
          //<<MANXL7.00.001 DAT 03/03/2014 #11
          if "Run Time" <> xRec."Run Time" then begin
            if "Run Time" = 0 then
              "Line Speed":= 0
            else
              "Line Speed":= 1/"Run Time";
            recManufacturingSetup.RESET;
            recManufacturingSetup.GET;
            recManufacturingSetup.TESTFIELD("Line Speed UOM");
            CLEAR(cduCalanderMgmt);
            "Line Speed":= "Line Speed"*(cduCalanderMgmt.TimeFactor(recManufacturingSetup."Line Speed UOM")/
                         cduCalanderMgmt.TimeFactor("Run Time Unit of Meas. Code"));
          end;
          //>>MANXL7.00.001 DAT 03/03/2014 #11
        //<<MANXL7.00.001 WSA 11/07/2014 #87
        end;
        //>>MANXL7.00.001 WSA 11/07/2014 #87
        */
        //end;

        //BC UPGRADE DIT>>
        // field(2035040; Active; Boolean)
        // {
        //     Caption = 'Actif';
        //     Description = 'DIT-715 #806';

        //     trigger OnValidate();
        //     var
        //         lrecProdOrderRoutingLine: Record "Prod. Order Routing Line";
        //     begin
        //         lrecProdOrderRoutingLine.RESET();
        //         lrecProdOrderRoutingLine.SETRANGE(Status, lrecProdOrderRoutingLine.Status::Released);
        //         lrecProdOrderRoutingLine.SETRANGE(Type, Type);
        //         lrecProdOrderRoutingLine.SETRANGE(lrecProdOrderRoutingLine."No.", "No.");
        //         lrecProdOrderRoutingLine.SETRANGE(lrecProdOrderRoutingLine."Work Center No.", "Work Center No.");
        //         lrecProdOrderRoutingLine.SETRANGE("Work Center Group Code", "Work Center Group Code");
        //         lrecProdOrderRoutingLine.SETFILTER(lrecProdOrderRoutingLine."Prod. Order No.", '<>%1', "Prod. Order No.");

        //         lrecProdOrderRoutingLine.SETRANGE(Active, true);
        //         if lrecProdOrderRoutingLine.FINDFIRST then begin
        //             lrecProdOrderRoutingLine.Active := false;
        //             lrecProdOrderRoutingLine.MODIFY;
        //         end;
        //     end;
        // }
        // field(2035090; "No. of Quality Tests"; Integer)
        // {
        //     CalcFormula = Count("Quality Test Header" where("Document Type" = CONST("In Process Test"),
        //                                                      "Source Type" = CONST(5405),
        //                                                      "Source ID" = FIELD("Prod. Order No."),
        //                                                      "Source Operation No." = FIELD("Operation No.")));
        //     CaptionML = ENU = 'No. of Quality Tests',
        //                 FRA = '<Nbre de Tests Qualité>';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035091; "Quality Test"; Boolean)
        // {
        //     CalcFormula = Exist("Quality Test Header" where("Document Type" = CONST("In Process Test"),
        //                                                      "Source Type" = CONST(5405),
        //                                                      "Source ID" = FIELD("Prod. Order No."),
        //                                                      "Source Operation No." = FIELD("Operation No.")));
        //     CaptionML = ENU = 'Quality Test',
        //                 FRA = 'Test qualité';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035092; "Quality Pass"; Boolean)
        // {
        //     CalcFormula = Exist("Quality Test Header" where("Document Type" = CONST("In Process Test"),
        //                                                      "Source Type" = CONST(5405),
        //                                                      "Source ID" = FIELD("Prod. Order No."),
        //                                                      "Source Operation No." = FIELD("Operation No."),
        //                                                      Pass = CONST(true)));
        //     CaptionML = ENU = 'Quality Pass',
        //                 FRA = 'Qualité approuvée';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035093; "Quality Status"; Option)
        // {
        //     CaptionML = ENU = 'Quality Status',
        //                 FRA = 'Status qualité';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     OptionCaptionML = ENU = 'Quarantine,Pass,Fail,Concession,Rejected',
        //                       FRA = 'Quarantaine,Bon,Mauvais,Concession,Refusé';
        //     OptionMembers = Quarantine,Pass,Fail,Concession,Rejected;
        // }
        // field(2035094; "No. of Passed Quality Tests"; Integer)
        // {
        //     CalcFormula = Count("Quality Test Header" where("Document Type" = CONST("In Process Test"),
        //                                                      "Source Type" = CONST(5405),
        //                                                      "Source ID" = FIELD("Prod. Order No."),
        //                                                      "Source Operation No." = FIELD("Operation No."),
        //                                                      Pass = CONST(true)));
        //     CaptionML = ENU = 'No. of Passed Quality Tests',
        //                 FRA = 'Nbre de Tests qualité approuvés';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035095; "No. of Untested Quality Tests"; Integer)
        // {
        //     CalcFormula = Count("Quality Test Header" where("Document Type" = CONST("In Process Test"),
        //                                                      "Source Type" = CONST(5405),
        //                                                      "Source ID" = FIELD("Prod. Order No."),
        //                                                      "Source Operation No." = FIELD("Operation No."),
        //                                                      Status = CONST(Quarantine)));
        //     CaptionML = ENU = 'No. of Untested Quality Tests',
        //                 FRA = 'Nbre de Tests qualité non testés';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035096; "Completion Required"; Boolean)
        // {
        //     CaptionML = ENU = 'Completion Required',
        //                 FRA = 'Achèvement requis';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        // }
        // field(2035097; Completed; Boolean)
        // {
        //     CaptionML = ENU = 'Completed',
        //                 FRA = 'Terminé';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        // }
        // field(2035098; "Alert Time"; Decimal)
        // {
        //     CaptionML = ENU = 'Alert Time',
        //                 FRA = 'Heure alerte';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        // }
        // field(2035099; "Completed by"; Code[30])
        // {
        //     CaptionML = ENU = 'Completed by',
        //                 FRA = 'Réalisé par';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        // }
        // field(2035100; "Alert Time Unit of Meas. Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Alert Time Unit of Meas. Code',
        //                 FRA = 'Unité Heure alerte';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     TableRelation = "Capacity Unit of Measure";
        // }
        // field(2035101; "Completed Date"; Date)
        // {
        //     CaptionML = ENU = 'Completed Date',
        //                 FRA = 'Date d''achèvement';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        // }
        // field(2035102; "Allow Alert Cancel"; Boolean)
        // {
        //     CaptionML = ENU = 'Allow Alert Cancel',
        //                 FRA = 'Autoriser l''annulation d''alerte';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        // }
        // field(2035103; "Completed Time"; Time)
        // {
        //     CaptionML = ENU = 'Completed Time',
        //                 FRA = 'Autoriser l''annulation d''alerte';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        // }
        // field(2035104; "Completed Date-Time"; DateTime)
        // {
        //     AutoFormatExpression = 'DATETIME';
        //     AutoFormatType = 10;
        //     CaptionML = ENU = 'Completed Date - Time',
        //                 FRA = 'Heure d''achèvement';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        // }
        // field(2035105; "Show on Production Order"; Boolean)
        // {
        //     CaptionML = ENU = 'Show on Production Order',
        //                 FRA = 'Montrer sur Ordre de fabrication';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        // }
        // field(2035106; "Operation Start Time"; Time)
        // {
        //     CaptionML = ENU = 'Operation Start Time',
        //                 FRA = 'Heure début de l''opération';
        //     Description = 'QXL9.00.001';
        // }
        // field(2035107; "Next Test Within (Hours)"; Decimal)
        // {
        //     CaptionML = ENU = 'Next Test Within (Hours)',
        //                 FRA = 'Proch.Test dans (Heures)';
        //     DecimalPlaces = 0 : 2;
        //     Description = 'QXL9.00.001';
        // }
        // field(2035208; Comment; Boolean)
        // {
        //     CalcFormula = Exist("Prod. Order Rtng Comment Line" where(Status = FIELD(Status),
        //                                                                "Prod. Order No." = FIELD("Prod. Order No."),
        //                                                                "Routing Reference No." = FIELD("Routing Reference No."),
        //                                                                "Routing No." = FIELD("Routing No."),
        //                                                                "Operation No." = FIELD("Operation No.")));
        //     CaptionML = ENU = 'Comment',
        //                 FRA = 'Commentaire';
        //     Description = 'DITW16.00.00.39 PRODW16.00.00.18';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2036301; "Line Speed"; Decimal)
        // {
        //     CaptionML = ENU = 'Line Speed',
        //                 FRA = 'Vitesse de ligne';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'MANXL7.00.001';

        //     trigger OnValidate();
        //     begin
        //         //<<MANXL7.00.001 DAT 03/03/2014 #11
        //         if "Line Speed" <> xRec."Line Speed" then begin
        //             if "Line Speed" = 0 then
        //                 "Run Time" := 0
        //             else
        //                 "Run Time" := 1 / "Line Speed";
        //             recManufacturingSetup.RESET;
        //             recManufacturingSetup.GET;
        //             recManufacturingSetup.TESTFIELD("Line Speed UOM");
        //             CLEAR(cduCalanderMgmt);
        //             "Run Time" := "Run Time" * (cduCalanderMgmt.TimeFactor(recManufacturingSetup."Line Speed UOM") /
        //                          cduCalanderMgmt.TimeFactor("Run Time Unit of Meas. Code"));
        //             CalcStartingEndingDates(Direction::Forward);
        //         end;
        //         //>>MANXL7.00.001 DAT 03/03/2014 #11
        //     end;
        // }
        // field(2036302; "Source Description"; Text[250])
        // {
        //     CaptionML = ENU = 'Source Description',
        //                 FRA = 'Désignation origine';
        //     Description = 'MANXL7.00.001';
        // }
        // field(2036303; "Subcontractor No."; Code[20])
        // {
        //     CaptionML = ENU = 'Subcontractor No.',
        //                 FRA = 'N° sous-traitant';
        //     Description = 'MANXL7.00.001';
        //     TableRelation = Vendor;
        // }
        // field(2036304; "Subcontractor Name"; Text[30])
        // {
        //     CalcFormula = Lookup(Vendor.Name where("No." = FIELD("Subcontractor No.")));
        //     CaptionML = ENU = 'Subcontractor Name',
        //                 FRA = 'Nom sous-traitant';
        //     Description = 'MANXL7.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2036305; "Item No."; Code[20])
        // {
        //     CalcFormula = Lookup("Prod. Order Line"."Item No." where(Status = FIELD(Status),
        //                                                               "Prod. Order No." = FIELD("Prod. Order No."),
        //                                                               "Routing Reference No." = FIELD("Routing Reference No."),
        //                                                               "Routing No." = FIELD("Routing No.")));
        //     CaptionML = ENU = 'Item No.',
        //                 FRA = 'N° article';
        //     Description = 'MANXL7.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     TableRelation = Item;
        // }
        // field(2036306; "Item Description"; Text[50])
        // {
        //     CalcFormula = Lookup("Prod. Order Line".Description where(Status = FIELD(Status),
        //                                                                "Prod. Order No." = FIELD("Prod. Order No."),
        //                                                                "Routing Reference No." = FIELD("Routing Reference No."),
        //                                                                "Routing No." = FIELD("Routing No.")));
        //     CaptionML = ENU = 'Description',
        //                 FRA = 'Désignation';
        //     Description = 'MANXL7.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2036307; "Item Category Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Item Category Code',
        //                 FRA = 'Code catégorie article';
        //     Description = 'MANXL7.00.001';
        //     TableRelation = "Item Category";
        // }
        // field(2036308; "Item Product Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Product Group Code',
        //                 FRA = 'Code groupe produits article';
        //     Description = 'MANXL7.00.001';
        //     TableRelation = "Product Group".Code where("Item Category Code" = FIELD("Item Category Code"));
        // }
        // field(2036309; "Planning Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Planning Group',
        //                 FRA = 'Groupe de planification';
        //     Description = 'MANXL7.00.001';
        //     TableRelation = "Planning Group";
        // }
        // field(2036310; "Production Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Production Group',
        //                 FRA = 'Groupe de production';
        //     Description = 'MANXL7.00.001';
        //     TableRelation = "Production Group";
        // }
        // field(2036311; "Qty. Received Purchase"; Decimal)
        // {
        //     CalcFormula = Sum("Purchase Line"."Quantity Received" where("Document Type" = CONST(Order),
        //                                                                  Type = CONST(Item),
        //                                                                  "Prod. Order No." = FIELD("Prod. Order No."),
        //                                                                  "Prod. Order Line No." = FIELD("Routing Reference No."),
        //                                                                  "Operation No." = FIELD("Operation No.")));
        //     CaptionML = ENU = 'Quantity Received Purchase',
        //                 FRA = 'Quantité d''achat reçue';
        //     DecimalPlaces = 0 : 2;
        //     Description = 'MANXL7.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2036312; "Qty. Invoiced Purchase"; Decimal)
        // {
        //     CalcFormula = Sum("Purchase Line"."Quantity Invoiced" where("Document Type" = CONST(Order),
        //                                                                  Type = CONST(Item),
        //                                                                  "Prod. Order No." = FIELD("Prod. Order No."),
        //                                                                  "Prod. Order Line No." = FIELD("Routing Reference No."),
        //                                                                  "Operation No." = FIELD("Operation No.")));
        //     CaptionML = ENU = 'Quantity Invoiced Purchase',
        //                 FRA = 'Quantité d''achat facturée';
        //     DecimalPlaces = 0 : 2;
        //     Description = 'MANXL7.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2036313; "Purchase Exist"; Boolean)
        // {
        //     CalcFormula = Exist("Purchase Line" where("Document Type" = CONST(Order),
        //                                                Type = CONST(Item),
        //                                                "Prod. Order No." = FIELD("Prod. Order No."),
        //                                                "Prod. Order Line No." = FIELD("Routing Reference No."),
        //                                                "Operation No." = FIELD("Operation No.")));
        //     CaptionML = ENU = 'Purchase Order Created',
        //                 FRA = 'Commande achat créée';
        //     Description = 'MANXL7.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2036314; "Revision No."; Code[10])
        // {
        //     CaptionML = ENU = 'Revision No.',
        //                 FRA = 'N° révision';
        //     Description = 'MANXL7.00.001';
        //     Editable = false;
        //     TableRelation = "Item Minor Revision"."Revision No." where("Item No." = FIELD("Item No."));
        // }
        //BC UPGRADE PATHAA02-DIT<<
    }
    keys
    {
        //BC UPGRADE -DIT>>
        // key(Key1; "Subcontractor No.")
        // {
        // } (Field-2036303)
        // key(Key2; "Item Category Code", "Item Product Group Code", "Planning Group", "Production Group")
        // {
        // }
        //BC UPGRADE -DIT<<
        key(Key50000; Status, "Prod. Order No.", "Routing Status")
        {
        }
        ////BC UPGRADE -DIT(Field-2036303)>>
        // key(Key4; Status, "Prod. Order No.", "Subcontractor No.")
        // {
        // } 
        //BC UPGRADE -DIT(Field-2036303)<<

        //HEI.01>>
        key(Key50001; "No.", Type)
        {
            SumIndexFields = "Expected Operation Cost Amt.";
        }
        //HEI.01<< //BC UPGRADE
    }


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD("Routing No.");
    if Status = Status::Finished then
      ERROR(Text006,Status,TABLECAPTION);

    if "Next Operation No." = '' then
      SetNextOperations(Rec);

    UpdateComponentsBin(0); // from trigger = insert
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    //<<MANXL7.00.001 WSA 11/07/2014 #87
    if rMANXLSetup.READPERMISSION then begin
    //>>MANXL7.00.001 WSA 11/07/2014 #87
      //<<MANXL7.00.001 DAT 03/03/2014 #10
      recProdOrder.RESET;
      if recProdOrder.GET(Status,"Prod. Order No.") then begin
        "Item Category Code":= recProdOrder."Item Category Code";
        "Item Product Group Code":= recProdOrder."Item Product Group Code";
        "Production Group" := recProdOrder."Production Group";
        "Planning Group":= recProdOrder."Planning Group";
      end;
      //>>MANXL7.00.001 DAT 03/03/2014 #10
    //<<MANXL7.00.001 WSA 11/07/2014 #87
    end;
    //>>MANXL7.00.001 WSA 11/07/2014 #87

    UpdateComponentsBin(0); // from trigger = insert
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : @@@="%1 = Document status; %2 = Table Caption; %3 = Field Value; %4 = Table Caption";ENU=You cannot delete %1 %2 %3 because there is at least one %4 associated with it.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : @@@="%1 = Document status; %2 = Table Caption; %3 = Field Value; %4 = Table Caption";ENU=You cannot delete %1 %2 %3 because there is at least one %4 associated with it.;FRA=Vous ne pouvez pas supprimer %1 %2 %3 car il existe au moins un %4 qui lui est associé.;
    //Variable type has not been exported.


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
    //Text002 : ENU=This routing line cannot be moved because of critical work centers in previous operations;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=This routing line cannot be moved because of critical work centers in previous operations;FRA=Cette ligne gamme ne peut pas être déplacée car il existe des centres de charge critiques dans les opérations précédentes.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=This routing line cannot be moved because of critical work centers in next operations;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=This routing line cannot be moved because of critical work centers in next operations;FRA=Cette ligne gamme ne peut pas être déplacée car il existe des centres de charge critiques dans les opérations suivantes;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1019)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=Some routing lines are referring to the operation just deleted. The references are\in the fields %1 and %2.\\This may have to be corrected as a routing line referring to a non-existent\operation will lead to serious errors in capacity planning.\\Do you want to see a list of the lines in question?\(Access the columns Next Operation No. and Previous Operation No.);
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=Some routing lines are referring to the operation just deleted. The references are\in the fields %1 and %2.\\This may have to be corrected as a routing line referring to a non-existent\operation will lead to serious errors in capacity planning.\\Do you want to see a list of the lines in question?\(Access the columns Next Operation No. and Previous Operation No.);FRA=Certaines lignes gamme sont associées à une opération qui vient d'être supprimée. Les références sont \dans les champs %1 et %2.\\Cela doit être corrigé car une ligne gamme qui se réfère à une opération\qui n'existe pas risque de provoquer des erreurs dans la planification des besoins en capacité.\\Souhaitez-vous visualiser la liste de ces lignes gamme ?\(Reportez-vous aux colonnes N° opération suivante et N° opération précédente.);
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=Routing Lines referring to deleted Operation No. %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=Routing Lines referring to deleted Operation No. %1;FRA=Lignes gamme associées à l'opération supprimée n° %1;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=A %1 %2 can not be inserted, modified, or deleted.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=A %1 %2 can not be inserted, modified, or deleted.;FRA=Un enregistrement %2 %1 ne peut pas être inséré, modifié ou supprimé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1022)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=You cannot change %1, because there is at least one %2 associated with %3 %4 %5.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=You cannot change %1, because there is at least one %2 associated with %3 %4 %5.;FRA=Vous ne pouvez pas modifier %1, car au moins un(e) %2 est associé(e) à %3 %4 %5.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1023)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=You cannot change the %1 from %2 to %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=You cannot change the %1 from %2 to %3.;FRA=Vous ne pouvez pas modifier le %1 de %2 en %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text009(Variable 1024)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU=If you change the %1 to %2, then all related allocated capacity will be deleted, and you will not be able to change the %1 of the operation again.\\Are you sure that you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : ENU=If you change the %1 to %2, then all related allocated capacity will be deleted, and you will not be able to change the %1 of the operation again.\\Are you sure that you want to continue?;FRA=Si vous modifiez le %1 en %2, alors toute la capacité allouée associée sera supprimée et vous ne pourrez pas modifier de nouveau le %1 de l'opération.\\Útes-vous sûr de vouloir continuer ?;
    //Variable type has not been exported.

    var
        recManufacturingSetup: Record "Manufacturing Setup";
        recProdOrder: Record "Production Order";
        blnBlockReplanning: Boolean;
        cduCalanderMgmt: Codeunit "Shop Calendar Management"; //BC UPGRADE PATHAA02
    // rMANXLSetup: Record "Manufacturing XL Setup"; //BC UPGRADE PATHAA02
}

