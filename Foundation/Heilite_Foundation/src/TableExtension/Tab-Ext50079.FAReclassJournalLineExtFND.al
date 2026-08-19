tableextension 50079 FAREclassJournalLineExtFND extends "FA Reclass. Journal Line"
{
    // HEI.01 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    // # New field:
    //   # 10800 Reclassify Derogatory
    // version NAVW19.00,DITW18.00.06

    //Bc Upgrade YADAVM09 Drink it field commented-Reclassify Derogatory

    fields
    {
        modify("Journal Template Name")
        {
            CaptionML = ENU = 'Journal Template Name', FRA = 'Nom modèle feuille';
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
        modify("FA No.")
        {
            CaptionML = ENU = 'FA No.', FRA = 'N° immo.';
        }
        modify("New FA No.")
        {
            CaptionML = ENU = 'New FA No.', FRA = 'Nouveau N° immo.';
        }
        modify("FA Posting Date")
        {
            CaptionML = ENU = 'FA Posting Date', FRA = 'Date compta. immo.';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Depreciation Book Code")
        {
            CaptionML = ENU = 'Depreciation Book Code', FRA = 'Code loi d''amortissement';
        }
        modify("Reclassify Acq. Cost Amount")
        {
            CaptionML = ENU = 'Reclassify Acq. Cost Amount', FRA = 'Reclass. montant coût acq.';
        }
        modify("Reclassify Acq. Cost %")
        {
            CaptionML = ENU = 'Reclassify Acq. Cost %', FRA = 'Reclass. coût acq. %';
        }
        modify("Reclassify Acquisition Cost")
        {
            CaptionML = ENU = 'Reclassify Acquisition Cost', FRA = 'Reclass. coût acq.';
        }
        modify("Reclassify Depreciation")
        {
            CaptionML = ENU = 'Reclassify Depreciation', FRA = 'Reclass. amortissement';
        }
        modify("Reclassify Write-Down")
        {
            CaptionML = ENU = 'Reclassify Write-Down', FRA = 'Reclass. dépréciation';
        }
        modify("Reclassify Appreciation")
        {
            CaptionML = ENU = 'Reclassify Appreciation', FRA = 'Reclass. évaluation';
        }
        modify("Reclassify Custom 1")
        {
            CaptionML = ENU = 'Reclassify Custom 1', FRA = 'Reclass. param. 1';
        }
        modify("Reclassify Custom 2")
        {
            CaptionML = ENU = 'Reclassify Custom 2', FRA = 'Reclass. param. 2';
        }
        modify("Reclassify Salvage Value")
        {
            CaptionML = ENU = 'Reclassify Salvage Value', FRA = 'Reclass. valeur résiduelle';
        }
        modify("Insert Bal. Account")
        {
            CaptionML = ENU = 'Insert Bal. Account', FRA = 'Insérer compte contrepartie';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify("Calc. DB1 Depr. Amount")
        {
            CaptionML = ENU = 'Calc. DB1 Depr. Amount', FRA = 'Montant amortissement dégr. 1 calc.';
        }

        //Unsupported feature: CodeModification on ""FA No."(Field 4).OnValidate". Please convert manually.

        //trigger "(Field 4)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "FA No." = '' THEN
          EXIT;
        FA.GET("FA No.");
        FA.TESTFIELD(Blocked,FALSE);
        FA.TESTFIELD(Inactive,FALSE);
        Description := FA.Description;
        IF "Depreciation Book Code" = '' THEN BEGIN
          FASetup.GET;
          "Depreciation Book Code" := FASetup."Default Depr. Book";
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "FA No." = '' then
          exit;
        FA.GET("FA No.");
        FA.TESTFIELD(Blocked,false);
        FA.TESTFIELD(Inactive,false);
        Description := FA.Description;
        if "Depreciation Book Code" = '' then begin
          FASetup.GET;
          "Depreciation Book Code" := FASetup."Default Depr. Book";
        end;

        // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        if FA."Financial Contract No." <> '' then begin
          VALIDATE("Contract Type","Contract Type"::Financial);
          VALIDATE("Financial Contract No.",FA."Financial Contract No.");
        end else begin
          if ContractDIT.READPERMISSION then
            VALIDATE("Contract Type","Contract Type"::Financial)
          else
            CLEAR("Contract Type");
          CLEAR("DIT Sub-Contract Type");
          CLEAR("Contract Group Code");
          CLEAR("Financial Contract No.");
        end;
        // >>DITW16.00.00.41 AHU DIT-715 #327
        */
        //end;


        //Unsupported feature: CodeModification on ""New FA No."(Field 5).OnValidate". Please convert manually.

        //trigger "(Field 5)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "New FA No." = '' THEN
          EXIT;
        FA.GET("New FA No.");
        FA.TESTFIELD(Blocked,FALSE);
        FA.TESTFIELD(Inactive,FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "New FA No." = '' then
          exit;
        FA.GET("New FA No.");
        FA.TESTFIELD(Blocked,false);
        FA.TESTFIELD(Inactive,false);
        */
        //end;

        /*//Bc Upgrade YADAVM09 Drink it field>>
        field(10800; "Reclassify Derogatory"; Boolean)
        {
            CaptionML = ENU = 'Reclassify Derogatory',
                        FRA = 'Reclasser dérogatoire';
            Description = 'HEI.01';
        }
        *///Bc Upgrade YADAVM09 Drink it field<<

        //BC Upgrade KAPOOV01-drink-it>>
        // field(2014310; "Service Contract Line No."; Integer)
        // {
        //     CaptionML = ENU = 'Contract Line No.',
        //                 FRA = 'N° ligne contrat';
        //     Description = 'DIT-715 #392';
        // }
        // field(2014313; "Financial Contract No."; Code[20])
        // {
        //     CaptionML = ENU = 'Financial Contract No.',
        //                 FRA = 'N° Contrat Financier';
        //     Description = 'DITW18.00.06 DIT-770 #1368';
        //     TableRelation = IF ("DIT Sub-Contract Type" = CONST(" ")) "Financial Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
        //                                                                                                               Status = FILTER(" " | Signed))
        //     else IF ("DIT Sub-Contract Type" = FILTER(<> " ")) "Financial Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
        //                                                                                                                                                                                                                 "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"),
        //                                                                                                                                                                                                                 Status = FILTER(" " | Signed));

        //     trigger OnValidate();
        //     begin
        //         ///  DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //         // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
        //         if "Financial Contract No." <> '' then begin
        //             //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //             "Contract Type" := "Contract Type"::Financial;
        //             TESTFIELD("Service Contract No.", '');
        //             //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //             if (CurrFieldNo = FIELDNO("Financial Contract No.")) and
        //               (xRec."Financial Contract No." <> "Financial Contract No.")
        //             then begin
        //                 "Service Contract Line No." := 0;
        //                 "Contract Group Code" := '';
        //             end;

        //             ContractDIT.GET(ContractDIT."Contract Type"::Contract, "Financial Contract No.");
        //             if ("DIT Sub-Contract Type" <> 0) or
        //               ((xRec."DIT Sub-Contract Type" <> 0) and ("DIT Sub-Contract Type" = 0) and
        //               (xRec."Financial Contract No." = "Financial Contract No."))
        //             then
        //                 TESTFIELD("DIT Sub-Contract Type", ContractDIT."DIT Sub-Contract Type")
        //             else
        //                 "DIT Sub-Contract Type" := ContractDIT."DIT Sub-Contract Type";
        //             if ("Contract Group Code" <> '') or
        //               ((xRec."Contract Group Code" <> '') and ("Contract Group Code" = '') and
        //               (xRec."Financial Contract No." = "Financial Contract No."))
        //             then
        //                 TESTFIELD("Contract Group Code", ContractDIT."Contract Group Code")
        //             else
        //                 "Contract Group Code" := ContractDIT."Contract Group Code";
        //         end else begin
        //             //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //             "Contract Type" := "Contract Type"::" ";
        //             //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //             "Service Contract Line No." := 0;
        //         end;
        //     end;
        // }
        // field(2034850; "DIT Sub-Contract Type"; Option)
        // {
        //     CaptionML = ENU = 'Sub Contract Type',
        //                 FRA = 'Sous type contrat';
        //     Description = 'DIT-715 #392';
        //     OptionCaptionML = ENU = ' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA = ' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,"Loan in use",Maintenance,Other,PlantMaintenance;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
        //         if (xRec."DIT Sub-Contract Type" <> "DIT Sub-Contract Type") and
        //           (CurrFieldNo = FIELDNO("DIT Sub-Contract Type"))
        //         then begin
        //             VALIDATE("Contract Group Code", '');
        //             //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //             TESTFIELD("Contract Type");
        //             case "Contract Type" of
        //                 "Contract Type"::Service:
        //                     VALIDATE("Service Contract No.");
        //                 "Contract Type"::Financial:
        //                     VALIDATE("Financial Contract No.");
        //             end;
        //             //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //         end;
        //     end;
        // }
        // field(2034872; "Contract Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Contract Group Code',
        //                 FRA = 'Code groupe contrat';
        //     Description = 'DIT-715 #392';
        //     TableRelation = IF ("Contract Type" = CONST(Service),
        //                         "DIT Sub-Contract Type" = FILTER(<> " ")) "Contract Group".Code where("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"))
        //     else IF ("Contract Type" = CONST(Service),
        //                                  "DIT Sub-Contract Type" = CONST(" ")) "Contract Group".Code
        //     else IF ("Contract Type" = CONST(Financial)) "Financial Contract Group".Code where("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
        //         if "Contract Group Code" <> '' then begin
        //             case "Contract Type" of
        //                 "Contract Type"::Service:
        //                     begin
        //                         if ContractGroup.Code <> "Contract Group Code" then
        //                             ContractGroup.GET("Contract Group Code");
        //                         "DIT Sub-Contract Type" := ContractGroup."DIT Sub-Contract Type";
        //                     end;
        //                 "Contract Type"::Financial:
        //                     begin
        //                         if ContractGroupDIT.Code <> "Contract Group Code" then
        //                             ContractGroupDIT.GET("Contract Group Code");
        //                         "DIT Sub-Contract Type" := ContractGroupDIT."DIT Sub-Contract Type";
        //                     end;
        //             end;
        //         end else begin
        //             CLEAR(ContractGroup);
        //             CLEAR(ContractGroupDIT);
        //         end;

        //         if "Service Contract No." <> '' then
        //             VALIDATE("Service Contract No.");
        //         //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //         if "Financial Contract No." <> '' then
        //             VALIDATE("Financial Contract No.");
        //         //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //     end;
        // }
        // field(2034915; "Service Contract No."; Code[20])
        // {
        //     CaptionML = ENU = 'Service Contract No.',
        //                 FRA = 'N° contrat de service';
        //     Description = 'DIT-715 #392 - DITW18.00.06 DIT-770 #1368';
        //     TableRelation = IF ("DIT Sub-Contract Type" = CONST(" ")) "Service Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
        //                                                                                                             Status = FILTER(" " | Signed))
        //     else IF ("DIT Sub-Contract Type" = FILTER(<> " ")) "Service Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
        //                                                                                                                                                                                                             "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"),
        //                                                                                                                                                                                                             Status = FILTER(" " | Signed));

        //     trigger OnValidate();
        //     var
        //         FA2: Record "Fixed Asset";
        //     begin
        //         /// DITW18.00.06 MSF 31/07/2015 - DDR 07/08/2015 DIT-770 #1368
        //         // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
        //         if "Service Contract No." <> '' then begin
        //             //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //             "Contract Type" := "Contract Type"::Service;
        //             TESTFIELD("Financial Contract No.", '');
        //             //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //             if (CurrFieldNo = FIELDNO("Service Contract No.")) and
        //               (xRec."Service Contract No." <> "Service Contract No.")
        //             then begin
        //                 "Service Contract Line No." := 0;
        //                 "Contract Group Code" := '';
        //             end;
        //             ///DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //             ServContract.GET(ServContract."Contract Type"::Contract, "Service Contract No.");
        //             if ("DIT Sub-Contract Type" <> 0) or
        //               ((xRec."DIT Sub-Contract Type" <> 0) and ("DIT Sub-Contract Type" = 0) and
        //               (xRec."Service Contract No." = "Service Contract No."))
        //             then
        //                 TESTFIELD("DIT Sub-Contract Type", ServContract."DIT Sub-Contract Type")
        //             else
        //                 "DIT Sub-Contract Type" := ServContract."DIT Sub-Contract Type";
        //             if ("Contract Group Code" <> '') or
        //               ((xRec."Contract Group Code" <> '') and ("Contract Group Code" = '') and
        //               (xRec."Service Contract No." = "Service Contract No."))
        //             then
        //                 TESTFIELD("Contract Group Code", ServContract."Contract Group Code")
        //             else
        //                 "Contract Group Code" := ServContract."Contract Group Code";
        //             ////DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //         end else begin
        //             //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //             "Contract Type" := "Contract Type"::" ";
        //             //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //             "Service Contract Line No." := 0;
        //         end;
        //     end;
        // }
        // field(2035393; "Contract Type"; Option)
        // {
        //     CaptionML = ENU = 'Contract Type',
        //                 FRA = 'Type contrat';
        //     Description = 'DIT-715 #392 -DITW18.00.06 DIT-770 #1368';
        //     OptionCaptionML = ENU = ' ,Service,Financial',
        //                       FRA = ' ,Service,Financier';
        //     OptionMembers = " ",Service,Financial;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
        //         if "Contract Type" <> xRec."Contract Type" then begin
        //             "DIT Sub-Contract Type" := "DIT Sub-Contract Type"::" ";
        //             "Contract Group Code" := '';
        //             //<<DITW18.00.06 MSF 31/07/2015 - DDR 07/08/2015 DIT-770 #1368
        //             if "Service Contract No." <> '' then
        //                 VALIDATE("Service Contract No.", '');
        //             if "Financial Contract No." <> '' then
        //                 VALIDATE("Financial Contract No.", '');
        //             //>>DITW18.00.06 MSF 31/07/2015 - DDR 07/08/2015 DIT-770 #1368
        //             "Service Contract Line No." := 0;
        //         end;
        //     end;
        // }
        //BC Upgrade KAPOOV01-drink-it<<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        ContractGroup: Record "Contract Group";
        //DITServMgtSetup: Record "Property Service Mgt. Setup";//BC Upgrade KAPOOV01-drink-it
        //DITPurchServMgtSetup: Record "Property Purch Serv Mgt. Setup";//BC Upgrade KAPOOV01-drink-it
        ServContract: Record "Service Contract Header";
    //ContractDIT: Record "Financial Contract Header";//BC Upgrade KAPOOV01-drink-it
    //ContractGroupDIT: Record "Financial Contract Group";//BC Upgrade KAPOOV01-drink-it
}

