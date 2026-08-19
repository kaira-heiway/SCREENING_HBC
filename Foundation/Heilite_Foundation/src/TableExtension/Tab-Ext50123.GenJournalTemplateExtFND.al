tableextension 50123 GenJournalTemplateExtFND extends "Gen. Journal Template"
{
    // version NAVW110.0,FINXL7.00,DITW110.00.08,HEI.06
    // FINXL7.00.001 RBE 04/06/2013: Added field: "Credit Memo"

    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-HNK LOGGAP001 03/10/2018 IBM.CHAUHB01
    //   #New field added "Save Batch"

    // HEI.02 FDD-CHG2022328 IBM POENAB02 07.07.2019 # External document No. duplication in journal
    //   #New fields 50002 "Customer Mandate", 50003 "RPM Payment", 50000 "Ext. Doc. No. Mandatory", 50004 "Restrct Duplicate Extrn Doc"
    // HEI.04 FDD-CD-HT1350 IBM BULIMC01 16.07.2020#new field added: 50006 - "SO Cash Application"

    // HEI.01 CHG2127493 IBM YADAVP04 27.11.2021 HB2527 Development of Payroll interface in Heilite Base V1.6 # 50007PayrollBooleanfield Created

    // HEI.05 CHG2190168 IBM POENAB02 25.01.2023 HB2330 BKT-EFT Citi bank payment file update for DRC
    //   #New field 50008 DRC - Show Pay. Method
    //   # 25.01.2023 Old CHG CHG2117475 was replaced with CHG2190168. Initial change was on 13.12.2021.
    // HEI.06 CHG2271823 IBM KAPOOV01 08.11.2024 Field to Block/Unblock General Journal templates
    //   #New field added-Blocked.
    //   #Modified Trigger/Functions- OnModify(),OnDelete(),OnRename(),Source Code - OnValidate()
    //   #Added new function-CheckTemplateBlocked()

    fields
    {
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Test Report ID")
        {

            //Unsupported feature: Change TableRelation on ""Test Report ID"(Field 5)". Please convert manually.

            CaptionML = ENU = 'Test Report ID', FRA = 'ID impression test';
        }
        modify("Page ID")
        {

            //Unsupported feature: Change TableRelation on ""Page ID"(Field 6)". Please convert manually.

            CaptionML = ENU = 'Page ID', FRA = 'ID page';
        }
        modify("Posting Report ID")
        {

            //Unsupported feature: Change TableRelation on ""Posting Report ID"(Field 7)". Please convert manually.

            CaptionML = ENU = 'Posting Report ID', FRA = 'ID rapport validation';
        }
        modify("Force Posting Report")
        {
            CaptionML = ENU = 'Force Posting Report', FRA = 'Forcer rapport validation';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
           // OptionCaptionML = ENU = 'General,Sales,Purchases,Cash Receipts,Payments,Assets,Intercompany,Jobs', FRA = 'Général,Ventes,Achats,Règlements,Paiements,Immobilisations,Intersociété,Projets,,,,,Financier';
        }
        modify("Source Code")
        {
            CaptionML = ENU = 'Source Code', FRA = 'Code journal';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
        }
        modify(Recurring)
        {
            CaptionML = ENU = 'Recurring', FRA = 'Abonnement';
        }
        modify("Test Report Caption")
        {

            //Unsupported feature: Change CalcFormula on ""Test Report Caption"(Field 15)". Please convert manually.

            CaptionML = ENU = 'Test Report Caption', FRA = 'Légende de l''impression test';
        }
        modify("Page Caption")
        {

            //Unsupported feature: Change CalcFormula on ""Page Caption"(Field 16)". Please convert manually.

            CaptionML = ENU = 'Page Caption', FRA = 'Légende de la page';
        }
        modify("Posting Report Caption")
        {

            //Unsupported feature: Change CalcFormula on ""Posting Report Caption"(Field 17)". Please convert manually.

            CaptionML = ENU = 'Posting Report Caption', FRA = 'Légende du rapport de validation';
        }
        modify("Force Doc. Balance")
        {

            //Unsupported feature: Change InitValue on ""Force Doc. Balance"(Field 18)". Please convert manually.

            CaptionML = ENU = 'Force Doc. Balance', FRA = 'Forcer équ. n° doc.';
        }
        modify("Bal. Account Type")
        {
            CaptionML = ENU = 'Bal. Account Type', FRA = 'Type compte contrepartie';
           // OptionCaptionML = ENU = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset', FRA = 'Général,Client,Fournisseur,Banque,Immobilisation';
        }
        modify("Bal. Account No.")
        {

            //Unsupported feature: Change TableRelation on ""Bal. Account No."(Field 20)". Please convert manually.

            CaptionML = ENU = 'Bal. Account No.', FRA = 'N° compte contrepartie';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Posting No. Series")
        {
            CaptionML = ENU = 'Posting No. Series', FRA = 'Souches de n° validation';
        }
        modify("Copy VAT Setup to Jnl. Lines")
        {

            //Unsupported feature: Change InitValue on ""Copy VAT Setup to Jnl. Lines"(Field 23)". Please convert manually.

            CaptionML = ENU = 'Copy VAT Setup to Jnl. Lines', FRA = 'Copier paramètres TVA sur les lignes feuille';
        }
        modify("Allow VAT Difference")
        {
            CaptionML = ENU = 'Allow VAT Difference', FRA = 'Autoriser différence TVA';
        }
        modify("Cust. Receipt Report ID")
        {

            //Unsupported feature: Change TableRelation on ""Cust. Receipt Report ID"(Field 25)". Please convert manually.

            CaptionML = ENU = 'Cust. Receipt Report ID', FRA = 'ID état réception client';
        }
        modify("Cust. Receipt Report Caption")
        {

            //Unsupported feature: Change CalcFormula on ""Cust. Receipt Report Caption"(Field 26)". Please convert manually.

            CaptionML = ENU = 'Cust. Receipt Report Caption', FRA = 'Légende de l''état réception client';
        }
        modify("Vendor Receipt Report ID")
        {

            //Unsupported feature: Change TableRelation on ""Vendor Receipt Report ID"(Field 27)". Please convert manually.

            CaptionML = ENU = 'Vendor Receipt Report ID', FRA = 'ID état réception fournisseur';
        }
        modify("Vendor Receipt Report Caption")
        {

            //Unsupported feature: Change CalcFormula on ""Vendor Receipt Report Caption"(Field 28)". Please convert manually.

            CaptionML = ENU = 'Vendor Receipt Report Caption', FRA = 'Légende de l''état réception fournisseur';
        }

        //Unsupported feature: CodeModification on ""Page ID"(Field 6).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Page ID" = 0 THEN
          VALIDATE(Type);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Page ID" = 0 then
          VALIDATE(Type);
        */
        //end;


        //Unsupported feature: CodeModification on "Type(Field 9).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Test Report ID" := REPORT::"General Journal - Test";
        "Posting Report ID" := REPORT::"G/L Register";
        SourceCodeSetup.GET;
        CASE Type OF
          Type::General:
            BEGIN
              "Source Code" := SourceCodeSetup."General Journal";
              "Page ID" := PAGE::"General Journal";
            END;
          Type::Sales:
            BEGIN
              "Source Code" := SourceCodeSetup."Sales Journal";
              "Page ID" := PAGE::"Sales Journal";
            END;
          Type::Purchases:
            BEGIN
              "Source Code" := SourceCodeSetup."Purchase Journal";
              "Page ID" := PAGE::"Purchase Journal";
            END;
          Type::"Cash Receipts":
            BEGIN
              "Source Code" := SourceCodeSetup."Cash Receipt Journal";
              "Page ID" := PAGE::"Cash Receipt Journal";
            END;
          Type::Payments:
            BEGIN
              "Source Code" := SourceCodeSetup."Payment Journal";
              "Page ID" := PAGE::"Payment Journal";
            END;
          Type::Assets:
            BEGIN
              "Source Code" := SourceCodeSetup."Fixed Asset G/L Journal";
              "Page ID" := PAGE::"Fixed Asset G/L Journal";
            END;
          Type::Intercompany:
            BEGIN
              "Source Code" := SourceCodeSetup."IC General Journal";
              "Page ID" := PAGE::"IC General Journal";
            END;
          Type::Jobs:
            BEGIN
              "Source Code" := SourceCodeSetup."Job G/L Journal";
              "Page ID" := PAGE::"Job G/L Journal";
            END;
        END;

        IF Recurring THEN
          "Page ID" := PAGE::"Recurring General Journal";
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        case Type of
          Type::General:
            begin
              "Source Code" := SourceCodeSetup."General Journal";
              "Page ID" := PAGE::"General Journal";
            end;
          Type::Sales:
            begin
              "Source Code" := SourceCodeSetup."Sales Journal";
              "Page ID" := PAGE::"Sales Journal";
            end;
          Type::Purchases:
            begin
              "Source Code" := SourceCodeSetup."Purchase Journal";
              "Page ID" := PAGE::"Purchase Journal";
            end;
          Type::"Cash Receipts":
            begin
              "Source Code" := SourceCodeSetup."Cash Receipt Journal";
              "Page ID" := PAGE::"Cash Receipt Journal";
            end;
          Type::Payments:
            begin
              "Source Code" := SourceCodeSetup."Payment Journal";
              "Page ID" := PAGE::"Payment Journal";
            end;
          Type::Assets:
            begin
              "Source Code" := SourceCodeSetup."Fixed Asset G/L Journal";
              "Page ID" := PAGE::"Fixed Asset G/L Journal";
            end;
          Type::Intercompany:
            begin
              "Source Code" := SourceCodeSetup."IC General Journal";
              "Page ID" := PAGE::"IC General Journal";
            end;
          Type::Jobs:
            begin
              "Source Code" := SourceCodeSetup."Job G/L Journal";
              "Page ID" := PAGE::"Job G/L Journal";
            end;
        end;

        if Recurring then
          "Page ID" := PAGE::"Recurring General Journal";
        */
        //end;


        //Unsupported feature: CodeModification on ""Source Code"(Field 10).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GenJnlLine.SETRANGE("Journal Template Name",Name);
        GenJnlLine.MODIFYALL("Source Code","Source Code");
        MODIFY;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckTemplateBlocked; //HEI.06
        #1..3
        */
        //end;


        //Unsupported feature: CodeModification on "Recurring(Field 12).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE(Type);
        IF Recurring THEN
          TESTFIELD("No. Series",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        VALIDATE(Type);
        if Recurring then
          TESTFIELD("No. Series",'');
        */
        //end;


        //Unsupported feature: CodeModification on ""Bal. Account No."(Field 20).OnValidate". Please convert manually.

        //trigger  Account No();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bal. Account Type" = "Bal. Account Type"::"G/L Account" THEN
          CheckGLAcc("Bal. Account No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Bal. Account Type" = "Bal. Account Type"::"G/L Account" then
          CheckGLAcc("Bal. Account No.");
        */
        //end;


        //Unsupported feature: CodeModification on ""No. Series"(Field 21).OnValidate". Please convert manually.

        //trigger  Series"(Field 21)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "No. Series" <> '' THEN BEGIN
          IF Recurring THEN
            ERROR(
              Text000,
              FIELDCAPTION("Posting No. Series"));
          IF "No. Series" = "Posting No. Series" THEN
            "Posting No. Series" := '';
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "No. Series" <> '' then begin
          if Recurring then
        #3..5
          if "No. Series" = "Posting No. Series" then
            "Posting No. Series" := '';
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Posting No. Series"(Field 22).OnValidate". Please convert manually.

        //trigger  Series"(Field 22)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Posting No. Series" = "No. Series") AND ("Posting No. Series" <> '') THEN
          FIELDERROR("Posting No. Series",STRSUBSTNO(Text001,"Posting No. Series"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Posting No. Series" = "No. Series") and ("Posting No. Series" <> '') then
          FIELDERROR("Posting No. Series",STRSUBSTNO(Text001,"Posting No. Series"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Copy VAT Setup to Jnl. Lines"(Field 23).OnValidate". Please convert manually.

        //trigger  Lines"(Field 23)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Copy VAT Setup to Jnl. Lines" <> xRec."Copy VAT Setup to Jnl. Lines" THEN BEGIN
          GenJnlBatch.SETRANGE("Journal Template Name",Name);
          GenJnlBatch.MODIFYALL("Copy VAT Setup to Jnl. Lines","Copy VAT Setup to Jnl. Lines");
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Copy VAT Setup to Jnl. Lines" <> xRec."Copy VAT Setup to Jnl. Lines" then begin
          GenJnlBatch.SETRANGE("Journal Template Name",Name);
          GenJnlBatch.MODIFYALL("Copy VAT Setup to Jnl. Lines","Copy VAT Setup to Jnl. Lines");
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Allow VAT Difference"(Field 24).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Allow VAT Difference" <> xRec."Allow VAT Difference" THEN BEGIN
          GenJnlBatch.SETRANGE("Journal Template Name",Name);
          GenJnlBatch.MODIFYALL("Allow VAT Difference","Allow VAT Difference");
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Allow VAT Difference" <> xRec."Allow VAT Difference" then begin
          GenJnlBatch.SETRANGE("Journal Template Name",Name);
          GenJnlBatch.MODIFYALL("Allow VAT Difference","Allow VAT Difference");
        end;
        */
        //end;
        field(50000; "Ext. Doc. No. Mandatory FND"; Boolean)
        {
            Caption = 'Ext. Doc. No. Mandatory';
            Description = 'HEI.02';
        }
        field(50001; "Save Batch FND"; Boolean)
        {
          caption = 'Save Batch';
            Description = 'HEI.01';
        }
        field(50002; "Customer Mandate FND"; Boolean)
        {
            Caption = 'Customer Mandate';
            Description = 'HEI.02';
        }
        field(50003; "RPM Payment FND"; Boolean)
        {
            Caption = 'RPM Payment';
            Description = 'HEI.02';
        }
        field(50004; "Restrct Dplct. Extrn Doc FND"; Boolean)
        {
            Caption = 'Restrct Duplicate Extrn Doc';
            Description = 'HEI.02';
        }
        field(50006; "SO Cash Application FND"; Boolean)
        {
            caption = 'SO Cash Application';
            Description = 'HEI.04';
        }
        field(50007; "Payroll FND"; Boolean)
        {
            caption = 'Payroll';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(50008; "DRC - Show Pay. Method FND"; Boolean)
        {
            Caption = 'DRC - Show Payment Method';
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
        }
        field(50009; "Blocked FND"; Boolean)
        {
            caption = 'Blocked';
            DataClassification = ToBeClassified;
            Description = 'HEI.06';
        }
        // BC Upgrade NANDIS03 - Blocked DIT field >>
        // field(2029610; "Credit Memo"; Boolean)
        // {
        //     CaptionML = ENU = 'Credit Memo',
        //                 FRA = 'Avoir';
        //     Description = 'FINXL7.00.001';
        // }
        // BC Upgrade NANDIS03 - Blocked DIT field <<
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GenJnlAlloc.SETRANGE("Journal Template Name",Name);
    GenJnlAlloc.DELETEALL;
    GenJnlLine.SETRANGE("Journal Template Name",Name);
    GenJnlLine.DELETEALL(TRUE);
    GenJnlBatch.SETRANGE("Journal Template Name",Name);
    GenJnlBatch.DELETEALL;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CheckTemplateBlocked; //HEI.06
    #1..3
    GenJnlLine.DELETEALL(true);
    GenJnlBatch.SETRANGE("Journal Template Name",Name);
    GenJnlBatch.DELETEALL;
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //begin
    /*
    //HEI.06>>
    if Blocked = xRec.Blocked then
      if Blocked then
        ERROR(Text50000,Name);
    //HEI.06<<
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnRename". Please convert manually.

    //trigger OnRename();
    //Parameters and return type have not been exported.
    //begin
    /*
    CheckTemplateBlocked; //HEI.06
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Only the %1 field can be filled in on recurring journals.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=Only the %1 field can be filled in on recurring journals.;FRA=Seul le champ %1 est à renseigner dans les feuilles abonnement.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=must not be %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=must not be %1;FRA=ne doit pas être %1;
    //Variable type has not been exported.

    // Code added GUNREM01 >>
    trigger OnAfterModify()
    begin
        //HEI.06>>
        if "Blocked FND" = xRec."Blocked FND" then
            if "Blocked FND" then
                ERROR(Text50000, Name);
        //HEI.06<<
    end;
    // Code added GUNREM01 <<

    var
        Text50000: Label 'General journal template %1 is blocked and cannot be deleted/modified. Please contact administrator for assistance.';
}

