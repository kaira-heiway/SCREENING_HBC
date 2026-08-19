tableextension 50013 ItemJournalBatchExtFND extends "Item Journal Batch"
{
    // version NAVW17.00,HEI.03

    //     HEI.01 CHG2049056 IBM.LS      01.03.2021
    //   # Created New Field: 50000 - Use in Workflow
    //   # Added Code
    // HEI.02 CHG2118467 IBM.LS      22.09.2021
    //   # Created New Field: 50001 - Use in Bulk Transfer

    // HEI.03 CHG2219877 PRASAA03 10.10.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
    //   # Created New Field: 50002 - "Mand. Global DImension 1"
    //   # Created New Field: 50003 - "Mand. Global DImension 2"

    // BC Upgrade MISHRS14 >>
    // HEI.04 Added NAV Table ID- 233 ( "Item Journal Batch" )
    // HEI.04 CHG2336029 SS40 17.03.2026 # Workflow Approval Functionality for Stock Adjustments
    // # Created New Field: 50004 - "Amount"
    // BC Upgrade MISHRS14 <<


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
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Posting No. Series")
        {
            CaptionML = ENU = 'Posting No. Series', FRA = 'Souches de n° validation';
        }
        modify("Template Type")
        {

            //Unsupported feature: Change CalcFormula on ""Template Type"(Field 21)". Please convert manually.

            CaptionML = ENU = 'Template Type', FRA = 'Type modèle';
            // OptionCaptionML = ENU = 'Item,Transfer,Phys. Inventory,Revaluation,Consumption,Output,Capacity,Prod. Order', FRA = 'Article,Transfert,Inventaire,Réévaluation,Consommation,Production,Capacité,O.F.';
        }
        modify(Recurring)
        {

            //Unsupported feature: Change CalcFormula on "Recurring(Field 22)". Please convert manually.

            CaptionML = ENU = 'Recurring', FRA = 'Abonnement';
        }

        //Unsupported feature: CodeModification on ""Reason Code"(Field 4).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Reason Code" <> xRec."Reason Code" THEN BEGIN
          ItemJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
          ItemJnlLine.SETRANGE("Journal Batch Name",Name);
          ItemJnlLine.MODIFYALL("Reason Code","Reason Code");
          MODIFY;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Reason Code" <> xRec."Reason Code" then begin
        #2..5
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""No. Series"(Field 5).OnValidate". Please convert manually.

        //trigger  Series"(Field 5)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "No. Series" <> '' THEN BEGIN
          ItemJnlTemplate.GET("Journal Template Name");
          IF ItemJnlTemplate.Recurring THEN
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
          ItemJnlTemplate.GET("Journal Template Name");
          if ItemJnlTemplate.Recurring then
        #4..6
          if "No. Series" = "Posting No. Series" then
            VALIDATE("Posting No. Series",'');
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Posting No. Series"(Field 6).OnValidate". Please convert manually.

        //trigger  Series"(Field 6)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Posting No. Series" = "No. Series") AND ("Posting No. Series" <> '') THEN
          FIELDERROR("Posting No. Series",STRSUBSTNO(Text001,"Posting No. Series"));
        ItemJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
        ItemJnlLine.SETRANGE("Journal Batch Name",Name);
        ItemJnlLine.MODIFYALL("Posting No. Series","Posting No. Series");
        MODIFY;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Posting No. Series" = "No. Series") and ("Posting No. Series" <> '') then
        #2..6
        */
        //end;
        field(50000; "Use in Workflow FND"; Boolean)
        {
            Description = 'HEI.01';
            Caption = 'Use in Workflow';
        }
        field(50001; "Use in Bulk Transfer FND"; Boolean)
        {
            Description = 'HEI.02';
            Caption = 'Use in Bulk Transfer';
        }
        field(50002; "Mand. Global DImension 1 FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            Caption = 'Mandatory Global Dimension 1';
        }
        field(50003; "Mand. Global DImension 2 FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            Caption = 'Mandatory Global Dimension 2';
        }
        
        // BC Upgrade MISHRS14 >>
        // HEI.04 Added field
        field(50004; "Amount FND"; Decimal)
        {
            Caption = 'Amount';
            Description = 'HEI.04';
            FieldClass = FlowField;
            CalcFormula = Sum("Item Journal Line".Amount
                WHERE(
                    "Journal Template Name" = FIELD("Journal Template Name"),
                    "Journal Batch Name" = FIELD(Name)));
        }
        // BC Upgrade MISHRS14 <<

    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
    ItemJnlLine.SETRANGE("Journal Batch Name",Name);
    ItemJnlLine.DELETEALL(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ItemJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
    ItemJnlLine.SETRANGE("Journal Batch Name",Name);
    ItemJnlLine.DELETEALL(true);
    */
    //end;


    //Unsupported feature: CodeModification on "OnRename". Please convert manually.

    //trigger OnRename();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemJnlLine.SETRANGE("Journal Template Name",xRec."Journal Template Name");
    ItemJnlLine.SETRANGE("Journal Batch Name",xRec.Name);
    WHILE ItemJnlLine.FINDFIRST DO
      ItemJnlLine.RENAME("Journal Template Name",Name,ItemJnlLine."Line No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ItemJnlLine.SETRANGE("Journal Template Name",xRec."Journal Template Name");
    ItemJnlLine.SETRANGE("Journal Batch Name",xRec.Name);
    while ItemJnlLine.FINDFIRST do
      ItemJnlLine.RENAME("Journal Template Name",Name,ItemJnlLine."Line No.");
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

    //---BC Upgrade KAMNAY01>>
    procedure GetBalance(): Decimal
    var
        ItemJournalLine: Record "Item Journal Line";
    begin
        //HEI.01>>
        ItemJournalLine.SETRANGE("Journal Template Name", "Journal Template Name");
        ItemJournalLine.SETRANGE("Journal Batch Name", Name);
        ItemJournalLine.CALCSUMS("Amount (ACY)");
        EXIT(ItemJournalLine."Amount (ACY)");
        //HEI.01<<
    end;

    procedure CheckBalance() Balance: Decimal
    var
        ishandeled: Boolean;
        myInt: Integer;
    begin
        //HEI.01>>
        Balance := GetBalance();

        IF Balance = 0 THEN
            OnItemJournalBatchBalanced()
        else
            OnItemJournalBatchNotBalanced();
        //HEI.01<<
    end;

    [IntegrationEvent(true, false)]
    local procedure OnItemJournalBatchBalanced()
    begin

    end;

    [IntegrationEvent(true, false)]
    local procedure OnItemJournalBatchNotBalanced()
    begin
    end;
    //---BC Upgrade KAMNAY01<<
}

