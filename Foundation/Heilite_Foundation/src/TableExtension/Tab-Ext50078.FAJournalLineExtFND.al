tableextension 50078 FAJournalLineExtFND extends "FA Journal Line"
{
    // HEI.01 FDD-HT584 IBM NASTAA02 02.09.2019 # La Reunion FA Derogatory Depreciation
    //   # Added new option 'Derogatory' to "FA Posting Type" Field
    // HEI.02 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Modified function ConvertToLedgEntry
    // version NAVW19.00,DITW18.00.06

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
        modify("Depreciation Book Code")
        {
            CaptionML = ENU = 'Depreciation Book Code', FRA = 'Code loi d''amortissement';
        }
        modify("FA Posting Type")
        {
            CaptionML = ENU = 'FA Posting Type', FRA = 'Type compta. immo.';
            //OptionCaptionML = ENU = 'Acquisition Cost,Depreciation,Write-Down,Appreciation,Custom 1,Custom 2,Disposal,Maintenance,Salvage Value,,,,Derogatory', FRA = 'Coût acquisition,Amortissement,Dépréciation,Réévaluation,Param. 1,Param. 2,Cession,Maintenance,Valeur résiduelle,,,,Dérogatoire';

            //Unsupported feature: Change OptionString on ""FA Posting Type"(Field 5)". Please convert manually.

        }
        modify("FA No.")
        {
            CaptionML = ENU = 'FA No.', FRA = 'N° immo.';
        }
        modify("FA Posting Date")
        {
            CaptionML = ENU = 'FA Posting Date', FRA = 'Date compta. immo.';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            // OptionCaptionML = ENU = ' ,,Invoice,Credit Memo', FRA = ' ,,Facture,Avoir';
        }
        modify("Document Date")
        {
            CaptionML = ENU = 'Document Date', FRA = 'Date document';
        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify("External Document No.")
        {
            CaptionML = ENU = 'External Document No.', FRA = 'N° doc. externe';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Debit Amount")
        {
            CaptionML = ENU = 'Debit Amount', FRA = 'Montant débit';
        }
        modify("Credit Amount")
        {
            CaptionML = ENU = 'Credit Amount', FRA = 'Montant crédit';
        }
        modify("Salvage Value")
        {
            CaptionML = ENU = 'Salvage Value', FRA = 'Valeur résiduelle';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify(Correction)
        {
            CaptionML = ENU = 'Correction', FRA = 'Correction';
        }
        modify("No. of Depreciation Days")
        {
            CaptionML = ENU = 'No. of Depreciation Days', FRA = 'Nbre jours amort.';
        }
        modify("Depr. until FA Posting Date")
        {
            CaptionML = ENU = 'Depr. until FA Posting Date', FRA = 'Amort. jusqu''à date compta.';
        }
        modify("Depr. Acquisition Cost")
        {
            CaptionML = ENU = 'Depr. Acquisition Cost', FRA = 'Amortir coût acquisition';
        }
        modify("FA Posting Group")
        {
            CaptionML = ENU = 'FA Posting Group', FRA = 'Groupe compta. immo.';
        }
        modify("Maintenance Code")
        {
            CaptionML = ENU = 'Maintenance Code', FRA = 'Code maintenance';
        }
        modify("Shortcut Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Shortcut Dimension 1 Code"(Field 27)". Please convert manually.

            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Shortcut Dimension 2 Code"(Field 28)". Please convert manually.

            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Insurance No.")
        {
            CaptionML = ENU = 'Insurance No.', FRA = 'N° assurance';
        }
        modify("Budgeted FA No.")
        {
            CaptionML = ENU = 'Budgeted FA No.', FRA = 'N° immo. budgétée';
        }
        modify("Use Duplication List")
        {
            CaptionML = ENU = 'Use Duplication List', FRA = 'Utiliser liste duplication';
        }
        modify("Duplicate in Depreciation Book")
        {
            CaptionML = ENU = 'Duplicate in Depreciation Book', FRA = 'Dupliquer dans journaux amort.';
        }
        modify("FA Reclassification Entry")
        {
            CaptionML = ENU = 'FA Reclassification Entry', FRA = 'Ecriture reclass. immo.';
        }
        modify("FA Error Entry No.")
        {
            CaptionML = ENU = 'FA Error Entry No.', FRA = 'N° séquence erreur immo.';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
        }
        modify("Source Code")
        {
            CaptionML = ENU = 'Source Code', FRA = 'Code journal';
        }
        modify("Recurring Method")
        {
            CaptionML = ENU = 'Recurring Method', FRA = 'Mode abonnement';
            OptionCaptionML = ENU = ' ,F Fixed,V Variable', FRA = ' ,F Fixe,V Variable';
        }
        modify("Recurring Frequency")
        {
            CaptionML = ENU = 'Recurring Frequency', FRA = 'Périodicité abonnement';
        }
        modify("Expiration Date")
        {
            CaptionML = ENU = 'Expiration Date', FRA = 'Date d''expiration';
        }
        modify("Index Entry")
        {
            CaptionML = ENU = 'Index Entry', FRA = 'Ecriture réévaluation';
        }
        modify("Posting No. Series")
        {
            CaptionML = ENU = 'Posting No. Series', FRA = 'Souches de n° validation';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }

        //Unsupported feature: CodeModification on ""Depreciation Book Code"(Field 4).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("FA No." = '') OR ("Depreciation Book Code" = '') THEN
          EXIT;
        FADeprBook.GET("FA No.","Depreciation Book Code");
        "FA Posting Group" := FADeprBook."FA Posting Group";
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("FA No." = '') or ("Depreciation Book Code" = '') then
          exit;
        FADeprBook.GET("FA No.","Depreciation Book Code");
        "FA Posting Group" := FADeprBook."FA Posting Group";
        */
        //end;


        //Unsupported feature: CodeModification on ""FA Posting Type"(Field 5).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "FA Posting Type" <> "FA Posting Type"::"Acquisition Cost" THEN
          TESTFIELD("Insurance No.",'');
        IF "FA Posting Type" <> "FA Posting Type"::Maintenance THEN
          TESTFIELD("Maintenance Code",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "FA Posting Type" <> "FA Posting Type"::"Acquisition Cost" then
          TESTFIELD("Insurance No.",'');
        if "FA Posting Type" <> "FA Posting Type"::Maintenance then
          TESTFIELD("Maintenance Code",'');
        */
        //end;


        //Unsupported feature: CodeModification on ""FA No."(Field 6).OnValidate". Please convert manually.

        //trigger "(Field 6)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "FA No." = '' THEN BEGIN
          CreateDim(DATABASE::"Fixed Asset","FA No.");
          EXIT;
        end;

        FA.GET("FA No.");
        FA.TESTFIELD(Blocked,FALSE);
        FA.TESTFIELD(Inactive,FALSE);
        Description := FA.Description;
        IF "Depreciation Book Code" = '' THEN BEGIN
          FASetup.GET;
          "Depreciation Book Code" := FASetup."Default Depr. Book";
          IF NOT FADeprBook.GET("FA No.","Depreciation Book Code") THEN
            "Depreciation Book Code" := '';
        end;
        IF "Depreciation Book Code" <> '' THEN BEGIN
          FADeprBook.GET("FA No.","Depreciation Book Code");
          "FA Posting Group" := FADeprBook."FA Posting Group";
        end;

        CreateDim(DATABASE::"Fixed Asset","FA No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "FA No." = '' then begin
          CreateDim(DATABASE::"Fixed Asset","FA No.",
          // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          DimMgt.TypeToTableID2034932(1,"Contract Type"),GetContractNo());
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          // >>DITW16.00.00.41 AHU DIT-715 #327
          exit;
        end;

        FA.GET("FA No.");
        FA.TESTFIELD(Blocked,false);
        FA.TESTFIELD(Inactive,false);
        Description := FA.Description;
        if "Depreciation Book Code" = '' then begin
          FASetup.GET;
          "Depreciation Book Code" := FASetup."Default Depr. Book";
          if not FADeprBook.GET("FA No.","Depreciation Book Code") then
            "Depreciation Book Code" := '';
        end;
        if "Depreciation Book Code" <> '' then begin
          FADeprBook.GET("FA No.","Depreciation Book Code");
          "FA Posting Group" := FADeprBook."FA Posting Group";
        end;

        // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        if FA."Financial Contract No." <> '' then begin
          VALIDATE("Contract Type","Contract Type"::Financial);
          //<<DITW16.00.00.43 FBL 10/07/2013 DIT-715 #620
          FA.CALCFIELDS("DIT Sub-Contract Type");
          VALIDATE("DIT Sub-Contract Type", FA."DIT Sub-Contract Type");
          //>>DITW16.00.00.43 FBL 10/07/2013 DIT-715 #620
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

        CreateDim(DATABASE::"Fixed Asset","FA No.",
        // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        DimMgt.TypeToTableID2034932(1,"Contract Type"),"Financial Contract No.");
        //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        // >>DITW16.00.00.41 AHU DIT-715 #327
        */
        //end;


        //Unsupported feature: CodeModification on "Amount(Field 14).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ((Amount > 0) AND (NOT Correction)) OR
           ((Amount < 0) AND Correction)
        THEN BEGIN
          "Debit Amount" := Amount;
          "Credit Amount" := 0
        end else BEGIN
          "Debit Amount" := 0;
          "Credit Amount" := -Amount;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ((Amount > 0) and (not Correction)) or
           ((Amount < 0) and Correction)
        then begin
          "Debit Amount" := Amount;
          "Credit Amount" := 0
        end else begin
          "Debit Amount" := 0;
          "Credit Amount" := -Amount;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Maintenance Code"(Field 26).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Maintenance Code" <> '' THEN
          TESTFIELD("FA Posting Type","FA Posting Type"::Maintenance);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Maintenance Code" <> '' then
          TESTFIELD("FA Posting Type","FA Posting Type"::Maintenance);
        */
        //end;


        //Unsupported feature: CodeModification on ""Insurance No."(Field 30).OnValidate". Please convert manually.

        //trigger "(Field 30)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Insurance No." <> '' THEN
          TESTFIELD("FA Posting Type","FA Posting Type"::"Acquisition Cost");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Insurance No." <> '' then
          TESTFIELD("FA Posting Type","FA Posting Type"::"Acquisition Cost");
        */
        //end;


        //Unsupported feature: CodeModification on ""Budgeted FA No."(Field 31).OnValidate". Please convert manually.

        //trigger "(Field 31)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Budgeted FA No." = '' THEN
          EXIT;
        FA.GET("Budgeted FA No.");
        FA.TESTFIELD("Budgeted Asset",TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Budgeted FA No." = '' then
          exit;
        FA.GET("Budgeted FA No.");
        FA.TESTFIELD("Budgeted Asset",true);
        */
        //end;


        //Unsupported feature: CodeModification on ""Duplicate in Depreciation Book"(Field 33).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Use Duplication List" := FALSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        "Use Duplication List" := false;
        */
        //end;
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
        //     var
        //         FA2: Record "Fixed Asset";
        //     begin
        //         // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
        //         /// DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //         if "Financial Contract No." <> '' then begin
        //             //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //             "Contract Type" := "Contract Type"::Financial;
        //             //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //             if (CurrFieldNo = FIELDNO("Financial Contract No.")) and
        //               (xRec."Financial Contract No." <> "Financial Contract No.")
        //             then begin
        //                 "Service Contract Line No." := 0;
        //                 "Contract Group Code" := '';
        //             end;
        //             TESTFIELD("FA No.");
        //             FA2.GET("FA No.");
        //             if FA2."Financial Contract No." <> '' then
        //                 TESTFIELD("Financial Contract No.", FA2."Financial Contract No.");

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
        //             "Contract Type" := "Contract Type"::Financial;
        //             //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //             "Service Contract Line No." := 0;
        //         end;

        //         CreateDim(
        //           DimMgt.TypeToTableID2034932(1, "Contract Type"), "Financial Contract No.",
        //           DATABASE::"Fixed Asset", "FA No.");
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
        //             //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //             end;
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
        //     Description = 'DIT-715 #392';
        //     TableRelation = IF ("DIT Sub-Contract Type" = CONST(" ")) "Service Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
        //                                                                                                             Status = FILTER(" " | Signed))
        //     else IF ("DIT Sub-Contract Type" = FILTER(<> " ")) "Service Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
        //                                                                                                                                                                                                             "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"),
        //                                                                                                                                                                                                             Status = FILTER(" " | Signed));

        //     trigger OnValidate();
        //     var
        //         FA2: Record "Fixed Asset";
        //     begin
        //         // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
        //         if "Service Contract No." <> '' then begin
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
        //             ///DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //         end else
        //             "Service Contract Line No." := 0;

        //         CreateDim(
        //           DimMgt.TypeToTableID2034932(1, "Contract Type"), "Service Contract No.",
        //           DATABASE::"Fixed Asset", "FA No.");
        //     end;
        // }
        // field(2035393; "Contract Type"; Option)
        // {
        //     CaptionML = ENU = 'Contract Type',
        //                 FRA = 'Type contrat';
        //     Description = 'DIT-715 #392- DITW17.10.05 DIT-770 DIT-770 #690 - DIT-770 #1368';
        //     OptionCaptionML = ENU = ' ,Service,Financial',
        //                       FRA = ' ,Service,Financier';
        //     OptionMembers = " ",Service,Financial;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
        //         if "Contract Type" <> xRec."Contract Type" then begin
        //             "DIT Sub-Contract Type" := "DIT Sub-Contract Type"::" ";
        //             "Contract Group Code" := '';
        //             //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //             case "Contract Type" of
        //                 "Contract Type"::" ":
        //                     VALIDATE("Service Contract No.", '');
        //                 "Contract Type"::Service:
        //                     VALIDATE("Financial Contract No.", '');
        //             end;
        //             //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
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
        li: Integer;

    var
        //ContractDIT: Record "Financial Contract Header";//BC Upgrade KAPOOV01-drink-it
        //ContractGroupDIT: Record "Financial Contract Group";//BC Upgrade KAPOOV01-drink-it
        CompanyInfo: Record "Company Information";
        ContractGroup: Record "Contract Group";
        //DITServMgtSetup: Record "Property Service Mgt. Setup";//BC Upgrade KAPOOV01-drink-it
        //DITPurchServMgtSetup: Record "Property Purch Serv Mgt. Setup";//BC Upgrade KAPOOV01-drink-it
        ServContract: Record "Service Contract Header";
}

