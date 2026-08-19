tableextension 50011 GenJournalBatchExtFND extends "Gen. Journal Batch"
{
    // version NAVW110.0,HEI.10
    // HEI.01 FDD PTPGAP026 - Payment Method List IBM.NAIKH01 03.08.2017
    //   # Added a new Fields 50001 - Payment Method Code.
    // HEI.02 Defect #829 IBM NASTAA02 26.10.2017 # Amount on Journal Batch not correct
    //   # Added new condition on the FlowField "Amount" to include just the "Parent" lines in the total Amount
    // HEI.03 FDD-PTPGAP072 IBM NASTAA02 22.02.2018 # Cashier Order Creation
    //   # New field created: 50001 - Cashier Order Report ID
    // HEI.04 PTPGAP077 - IBM HORTOC01 23.03.2018
    //   #new field "Suggest Payment Param"
    // HEI.05 FDD PTPGAP078 IBM POSTOI01 15.05.2018
    //   # new field 50006 Heineken Bank Account Code; Code 20
    //   # new field 50007 Bank Payment Type; Option
    // HEI.06 FDD-HT704 IBM BULIMC01 #new field 50008 "Cashier ID"


    // HEI.07 CHG2030722 IBM.LS 17.09.2019
    //   # New field created:50000 - "Amount (LCY)"
    //   # New field created:50009 - "Debit Amount (LCY)"
    //   # New field created:50010 - "Credit Amount (LCY)"

    // HEI.08 CHG2255994 IBM KAPOOV01 04.07.2024 P&L Close 2022 in Production Environment
    //   # New field created:50011 - "Dim. Comb. Not Appl."
    // HEI.09 CHG2271823 IBM KAPOOV01 08.11.2024 Field to Block/Unblock General Journal templates
    //   #Modified Trigger/Functions- OnInsert(),OnModify(),OnDelete(),OnRename()
    //   #Added new functions-EnableActionIfTemplateNtBlock(),CheckTemplateBlocked()
    // HEI.10 CHG2279499 IBM POENAB02 25.11.2024 Cash Receipt Journal Template failed to open with attached error
    //   #Code added in functions CheckTemplateBlocked, EnableActionIfTemplateNtBlock
    fields
    {
        modify("Journal Template Name")
        {
            CaptionML = ENU = 'Journal Template Name', FRA = 'Nom modèle feuille';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
            // BC Upgrade NANDIS03 >>
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                CheckTemplateBlocked();//HEI.09
            end;
            // BC Upgrade NANDIS03 <<
        }
        modify("Bal. Account Type")
        {
            CaptionML = ENU = 'Bal. Account Type', FRA = 'Type compte contrepartie';
            //OptionCaptionML = ENU = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset', FRA = 'Général,Client,Fournisseur,Banque,Immobilisation';
        }
        modify("Bal. Account No.")
        {

            //Unsupported feature: Change TableRelation on ""Bal. Account No."(Field 6)". Please convert manually.

            CaptionML = ENU = 'Bal. Account No.', FRA = 'N° compte contrepartie';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Posting No. Series")
        {
            CaptionML = ENU = 'Posting No. Series', FRA = 'Souches de n° validation';

            // BC Upgrade NANDIS03 >>
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                CheckTemplateBlocked();//HEI.09
            end;
            // BC Upgrade NANDIS03 <<
        }
        modify("Copy VAT Setup to Jnl. Lines")
        {

            //Unsupported feature: Change InitValue on ""Copy VAT Setup to Jnl. Lines"(Field 9)". Please convert manually.

            CaptionML = ENU = 'Copy VAT Setup to Jnl. Lines', FRA = 'Copier paramètres TVA sur les lignes feuille';
        }
        modify("Allow VAT Difference")
        {
            CaptionML = ENU = 'Allow VAT Difference', FRA = 'Autoriser différence TVA';
        }
        modify("Allow Payment Export")
        {
            CaptionML = ENU = 'Allow Payment Export', FRA = 'Autoriser exportation paiement';
        }
        modify("Bank Statement Import Format")
        {
            CaptionML = ENU = 'Bank Statement Import Format', FRA = 'Format importation relevé bancaire';
        }
        modify("Template Type")
        {

            //Unsupported feature: Change CalcFormula on ""Template Type"(Field 21)". Please convert manually.

            CaptionML = ENU = 'Template Type', FRA = 'Type modèle';
            //OptionCaptionML = ENU = 'General,Sales,Purchases,Cash Receipts,Payments,Assets,Intercompany,Jobs', FRA = 'Général,Ventes,Achats,Règlements,Paiements,Immobilisations,Intersociété,Projets';
        }
        modify(Recurring)
        {

            //Unsupported feature: Change CalcFormula on "Recurring(Field 22)". Please convert manually.

            CaptionML = ENU = 'Recurring', FRA = 'Abonnement';
        }
        modify("Suggest Balancing Amount")
        {
            CaptionML = ENU = 'Suggest Balancing Amount', FRA = 'Suggérer le montant contrepartie';
        }

        //Unsupported feature: CodeModification on ""Reason Code"(Field 4).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Reason Code" <> xRec."Reason Code" THEN BEGIN
          ModifyLines(FIELDNO("Reason Code"));
          MODIFY;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckTemplateBlocked;//HEI.09
        if "Reason Code" <> xRec."Reason Code" then begin
          ModifyLines(FIELDNO("Reason Code"));
          MODIFY;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Bal. Account Type"(Field 5).OnValidate". Please convert manually.

        //trigger  Account Type"(Field 5)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Bal. Account No." := '';
        IF "Bal. Account Type" <> "Bal. Account Type"::"G/L Account" THEN
          "Bank Statement Import Format" := '';
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        "Bal. Account No." := '';
        if "Bal. Account Type" <> "Bal. Account Type"::"G/L Account" then
          "Bank Statement Import Format" := '';
        */
        //end;


        //Unsupported feature: CodeModification on ""Bal. Account No."(Field 6).OnValidate". Please convert manually.

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


        //Unsupported feature: CodeModification on ""No. Series"(Field 7).OnValidate". Please convert manually.

        //trigger  Series"(Field 7)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "No. Series" <> '' THEN BEGIN
          GenJnlTemplate.GET("Journal Template Name");
          IF GenJnlTemplate.Recurring THEN
            ERROR(
              Text000,
              FIELDCAPTION("Posting No. Series"));
          IF "No. Series" = "Posting No. Series" THEN
            VALIDATE("Posting No. Series",'');
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "No. Series" <> '' then begin
          GenJnlTemplate.GET("Journal Template Name");
          if GenJnlTemplate.Recurring then
        #4..6
          if "No. Series" = "Posting No. Series" then
            VALIDATE("Posting No. Series",'');
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Posting No. Series"(Field 8).OnValidate". Please convert manually.

        //trigger  Series"(Field 8)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Posting No. Series" = "No. Series") AND ("Posting No. Series" <> '') THEN
          FIELDERROR("Posting No. Series",STRSUBSTNO(Text001,"Posting No. Series"));
        ModifyLines(FIELDNO("Posting No. Series"));
        MODIFY;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckTemplateBlocked;//HEI.09
        if ("Posting No. Series" = "No. Series") and ("Posting No. Series" <> '') then
        #2..4
        */
        //end;


        //Unsupported feature: CodeModification on ""Allow VAT Difference"(Field 10).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Allow VAT Difference" THEN BEGIN
          GenJnlTemplate.GET("Journal Template Name");
          GenJnlTemplate.TESTFIELD("Allow VAT Difference",TRUE);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Allow VAT Difference" then begin
          GenJnlTemplate.GET("Journal Template Name");
          GenJnlTemplate.TESTFIELD("Allow VAT Difference",true);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Bank Statement Import Format"(Field 12).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Bank Statement Import Format" <> '') AND ("Bal. Account Type" <> "Bal. Account Type"::"G/L Account") THEN
          FIELDERROR("Bank Statement Import Format",BankStmtImpFormatBalAccErr);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Bank Statement Import Format" <> '') and ("Bal. Account Type" <> "Bal. Account Type"::"G/L Account") then
          FIELDERROR("Bank Statement Import Format",BankStmtImpFormatBalAccErr);
        */
        //end;
        field(50000; "Amount (LCY) FND"; Decimal)
        {
            caption = 'Amount (LCY)';
            CalcFormula = Sum("Gen. Journal Line"."Amount (LCY)" where("Journal Template Name" = FIELD("Journal Template Name"),
                                                                        "Journal Batch Name" = FIELD(Name),
                                                                        "Parent Line No. FND" = CONST(0)));
            Description = 'HEI.07';
            FieldClass = FlowField;
        }
        field(50001; "Payment Method Code FND"; Code[10])
        {
            caption = 'Payment Method Code';
            Description = 'HEI.01';
            TableRelation = "Payment Method".Code;
        }
        field(50002; "Amount FND"; Decimal)
        {
            caption = 'Amount';
            CalcFormula = Sum("Gen. Journal Line".Amount where("Journal Template Name" = FIELD("Journal Template Name"),
                                                                "Journal Batch Name" = FIELD(Name),
                                                                "Parent Line No. FND" = CONST(0)));
            Description = 'HEI.02';
            FieldClass = FlowField;
        }
        field(50003; "Debit Amount FND"; Decimal)
        {
            caption = 'Debit Amount';
            CalcFormula = Sum("Gen. Journal Line"."Debit Amount" where("Journal Template Name" = FIELD("Journal Template Name"),
                                                                        "Journal Batch Name" = FIELD(Name)));
            FieldClass = FlowField;
        }
        field(50004; "Cashier Order Report ID FND"; Integer)
        {
            caption = 'Cashier Order Report ID';
            Description = 'HEI.03';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = FILTER(Report));
        }
        field(50005; "Suggest Payment Param FND"; BLOB)
        {
            caption = 'Suggest Payment Param';
            Description = 'HEI.04';
        }
        field(50006; "HNK Bank Account FND"; Code[20])
        {
            caption = 'HNK Bank Account';
            Description = 'HEI.05';
            TableRelation = "Bank Account";
        }
        field(50007; "Bank Payment Type FND"; Enum "Bank Payment Type")
        {
            CaptionML = ENU = 'Bank Payment Type',
                        FRA = 'Mode émission paiement';
            Description = 'HEI.05';
            // OptionCaptionML = ENU = ' ,Computer Check,Manual Check',
            //                   FRA = ' ,Informatique,Manuel';
            // OptionMembers = " ","Computer Check","Manual Check";
        }
        field(50008; "Cashier ID FND"; Code[50])
        {
            caption = 'Cashier ID';
            Description = 'HEI.06';
            TableRelation = "User Setup";
        }
        field(50009; "Debit Amount (LCY) FND"; Decimal)
        {
            caption = 'Debit Amount (LCY)';
            CalcFormula = Sum("Gen. Journal Line"."Debit Amount (LCY) FND" where("Journal Template Name" = FIELD("Journal Template Name"),
                                                                              "Journal Batch Name" = FIELD(Name),
                                                                              "Parent Line No. FND" = CONST(0)));
            Description = 'HEI.07';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; "Credit Amount (LCY) FND"; Decimal)
        {
            caption = 'Credit Amount (LCY)';
            CalcFormula = Sum("Gen. Journal Line"."Credit Amount (LCY) FND" where("Journal Template Name" = FIELD("Journal Template Name"),
                                                                               "Journal Batch Name" = FIELD(Name),
                                                                               "Parent Line No. FND" = CONST(0)));
            Description = 'HEI.07';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "Dim. Comb. Not Appl. FND"; Boolean)
        {
            caption = 'Dim. Comb. Not Appl.';
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ApprovalsMgmt.OnCancelGeneralJournalBatchApprovalRequest(Rec);

    GenJnlAlloc.SETRANGE("Journal Template Name","Journal Template Name");
    GenJnlAlloc.SETRANGE("Journal Batch Name",Name);
    GenJnlAlloc.DELETEALL;
    GenJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
    GenJnlLine.SETRANGE("Journal Batch Name",Name);
    GenJnlLine.DELETEALL(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CheckTemplateBlocked;//HEI.09
    #1..7
    GenJnlLine.DELETEALL(true);
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    LOCKTABLE;
    GenJnlTemplate.GET("Journal Template Name");
    IF NOT GenJnlTemplate."Copy VAT Setup to Jnl. Lines" THEN
      "Copy VAT Setup to Jnl. Lines" := FALSE;
    "Allow Payment Export" := GenJnlTemplate.Type = GenJnlTemplate.Type::Payments;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //HEI.09>>
    GenJnlTemplate.GET("Journal Template Name");
    if GenJnlTemplate.Blocked then
        ERROR(Text50000,GenJnlTemplate.Name);
    //HEI.09<<
    LOCKTABLE;
    GenJnlTemplate.GET("Journal Template Name");
    if not GenJnlTemplate."Copy VAT Setup to Jnl. Lines" then
      "Copy VAT Setup to Jnl. Lines" := false;
    "Allow Payment Export" := GenJnlTemplate.Type = GenJnlTemplate.Type::Payments;
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //begin
    /*
    CheckTemplateBlocked;//HEI.09
    */
    //end;


    //Unsupported feature: CodeModification on "OnRename". Please convert manually.

    //trigger OnRename();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ApprovalsMgmt.RenameApprovalEntries(xRec.RECORDID,RECORDID);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CheckTemplateBlocked;//HEI.09
    ApprovalsMgmt.RenameApprovalEntries(xRec.RECORDID,RECORDID);
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


    //Unsupported feature: PropertyModification on "BankStmtImpFormatBalAccErr(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //BankStmtImpFormatBalAccErr : @@@="FIELDERROR ex: Bank Statement Import Format must be blank. When Bal. Account Type = Bank Account, then Bank Statement Import Format on the Bank Account card will be used in Gen. Journal Batch Journal Template Name='GENERAL',Name='CASH'.";ENU="must be blank. When Bal. Account Type = Bank Account, then Bank Statement Import Format on the Bank Account card will be used";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //BankStmtImpFormatBalAccErr : @@@="FIELDERROR ex: Bank Statement Import Format must be blank. When Bal. Account Type = Bank Account, then Bank Statement Import Format on the Bank Account card will be used in Gen. Journal Batch Journal Template Name='GENERAL',Name='CASH'.";ENU="must be blank. When Bal. Account Type = Bank Account, then Bank Statement Import Format on the Bank Account card will be used";FRA="doit être vide. Si Type compte contrepartie = Compte bancaire, c'est le Format importation relevé bancaire du compte bancaire qui sera utilisé.";
    //Variable type has not been exported.

    var
        Text50000: Label 'General journal Template %1 is blocked and new batch cannot be created. Please contact administrator for assistance';

    // BC Upgrade NANDIS03 >>
    local procedure CheckTemplateBlocked()
    var
        lText50000: TextConst ENU = 'General journal Template %1 linked with Batch %2 is blocked and cannot be deleted/modified. Please contact administrator for assistance';
    begin
        //HEI.09>>
        //HEI.10>>
        //GenJnlTemplate.GET("Journal Template Name");
        IF GenJnlTemplate.GET("Journal Template Name") THEN
            //HEI.10<<
            IF GenJnlTemplate."Blocked FND" THEN
                ERROR(lText50000, GenJnlTemplate.Name, Name);
        //HEI.09<<
    end;

    trigger OnInsert()

    begin
        //HEI.09>>
        GenJnlTemplate.GET("Journal Template Name");
        IF GenJnlTemplate."Blocked FND" THEN
            ERROR(Text50000, GenJnlTemplate.Name);
        //HEI.09<<
    end;

    trigger OnModify()

    begin
        CheckTemplateBlocked();//HEI.09
    end;

    trigger OnDelete()

    begin
        CheckTemplateBlocked();//HEI.09
    end;

    trigger OnRename()

    begin
        CheckTemplateBlocked();//HEI.09
    end;

    procedure EnableActionIfTemplateNtBlock(): Boolean
    begin
        //HEI.09>>
        //HEI.10>>
        //GenJnlTemplate.GET("Journal Template Name");
        IF GenJnlTemplate.GET("Journal Template Name") THEN BEGIN
            //HEI10<<
            IF GenJnlTemplate."Blocked FND" THEN
                EXIT(FALSE)
            else
                EXIT(TRUE);
        end;//HEI.10
        EXIT(TRUE);
        //HEI.09<<
    end;

    var
        GenJnlAlloc: Record "Gen. Jnl. Allocation";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlTemplate: Record "Gen. Journal Template";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    // BC Upgrade NANDIS03 <<
}

