tableextension 50129 ItemJournalTemplateExtFND extends "Item Journal Template"
{
    // DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457
    //                                  Added fields
    //                                    80016 Work Order Mandatory
    // DITW17.00.02 SR 10/09/2013 DIT-770 #143 : Added new field "2034640" "Def. Gen. Bus. Posting Group"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-BA-SLSGAP01 IBM NASTAA02 26.10.2018 # Counterpoint Interface
    //   # New Field created: 50000 - Save Batch
    // HEI.02 CHG2180069 ZOGHLE01 03.02.2023 #Limiting selection options in Entry Type column in Item journal template SCRAP
    //   # New Field created: 50001 - "Limit Type Selection"

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
            //OptionCaptionML = ENU = 'Item,Transfer,Phys. Inventory,Revaluation,Consumption,Output,Capacity,Prod. Order', FRA = 'Article,Transfert,Inventaire,Réévaluation,Consommation,Production,Capacité,O.F.';
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
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Posting No. Series")
        {
            CaptionML = ENU = 'Posting No. Series', FRA = 'Souches de n° validation';
        }
        modify("Whse. Register Report ID")
        {

            //Unsupported feature: Change TableRelation on ""Whse. Register Report ID"(Field 21)". Please convert manually.

            CaptionML = ENU = 'Whse. Register Report ID', FRA = 'ID état historique transactions entrepôt';
        }
        modify("Whse. Register Report Caption")
        {

            //Unsupported feature: Change CalcFormula on ""Whse. Register Report Caption"(Field 22)". Please convert manually.

            CaptionML = ENU = 'Whse. Register Report Caption', FRA = 'Légende de l''état historique transactions entrepôt';
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
        "Test Report ID" := REPORT::"Inventory Posting - Test";
        "Posting Report ID" := REPORT::"Item Register - Quantity";
        "Whse. Register Report ID" := REPORT::"Warehouse Register - Quantity";
        SourceCodeSetup.GET;
        CASE Type OF
          Type::Item:
            BEGIN
              "Source Code" := SourceCodeSetup."Item Journal";
              "Page ID" := PAGE::"Item Journal";
            end;
          Type::Transfer:
            BEGIN
              "Source Code" := SourceCodeSetup."Item Reclass. Journal";
              "Page ID" := PAGE::"Item Reclass. Journal";
            end;
          Type::"Phys. Inventory":
            BEGIN
              "Source Code" := SourceCodeSetup."Phys. Inventory Journal";
              "Page ID" := PAGE::"Phys. Inventory Journal";
            end;
          Type::Revaluation:
            BEGIN
              "Source Code" := SourceCodeSetup."Revaluation Journal";
              "Page ID" := PAGE::"Revaluation Journal";
              "Test Report ID" := REPORT::"Revaluation Posting - Test";
              "Posting Report ID" := REPORT::"Item Register - Value";
            end;
          Type::Consumption:
            BEGIN
              "Source Code" := SourceCodeSetup."Consumption Journal";
              "Page ID" := PAGE::"Consumption Journal";
            end;
          Type::Output:
            BEGIN
              "Source Code" := SourceCodeSetup."Output Journal";
              "Page ID" := PAGE::"Output Journal";
            end;
          Type::Capacity:
            BEGIN
              "Source Code" := SourceCodeSetup."Capacity Journal";
              "Page ID" := PAGE::"Capacity Journal";
            end;
          Type::"Prod. Order":
            BEGIN
              "Source Code" := SourceCodeSetup."Production Journal";
              "Page ID" := PAGE::"Production Journal";
            end;
        end;
        IF Recurring THEN
          CASE Type OF
            Type::Item:
              "Page ID" := PAGE::"Recurring Item Jnl.";
            Type::Consumption:
              "Page ID" := PAGE::"Recurring Consumption Journal";
            Type::Output:
              "Page ID" := PAGE::"Recurring Output Journal";
            Type::Capacity:
              "Page ID" := PAGE::"Recurring Capacity Journal";
          end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        case Type of
          Type::Item:
            begin
              "Source Code" := SourceCodeSetup."Item Journal";
              "Page ID" := PAGE::"Item Journal";
            end;
          Type::Transfer:
            begin
              "Source Code" := SourceCodeSetup."Item Reclass. Journal";
              "Page ID" := PAGE::"Item Reclass. Journal";
            end;
          Type::"Phys. Inventory":
            begin
              "Source Code" := SourceCodeSetup."Phys. Inventory Journal";
              "Page ID" := PAGE::"Phys. Inventory Journal";
            end;
          Type::Revaluation:
            begin
        #23..26
            end;
          Type::Consumption:
            begin
              "Source Code" := SourceCodeSetup."Consumption Journal";
              "Page ID" := PAGE::"Consumption Journal";
            end;
          Type::Output:
            begin
              "Source Code" := SourceCodeSetup."Output Journal";
              "Page ID" := PAGE::"Output Journal";
            end;
          Type::Capacity:
            begin
              "Source Code" := SourceCodeSetup."Capacity Journal";
              "Page ID" := PAGE::"Capacity Journal";
            end;
          Type::"Prod. Order":
            begin
              "Source Code" := SourceCodeSetup."Production Journal";
              "Page ID" := PAGE::"Production Journal";
            end;
        end;
        if Recurring then
          case Type of
        #51..58
          end;
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


        //Unsupported feature: CodeModification on ""No. Series"(Field 19).OnValidate". Please convert manually.

        //trigger  Series"(Field 19)();
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
        end;
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


        //Unsupported feature: CodeModification on ""Posting No. Series"(Field 20).OnValidate". Please convert manually.

        //trigger  Series"(Field 20)();
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
        field(50000; "Save Batch FND"; Boolean)
        {
            Caption = 'Save Batch';
            Description = 'HEI.01';
        }
        field(50001; "Limit Type Selection FND"; Boolean)
        {
            caption = 'Limit Type Selection';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }

        //BCUP0-92 PATHAA02 08.07.26>>
        field(50002; "Def. Gen. Bus. Posting Group FND"; Code[10])
        {
            CaptionML = ENU = 'Def. Gen. Bus. Posting Group',
                        FRA = 'Groupe comptable marché par défaut';
            Description = 'BCUP0-92';
            TableRelation = "Gen. Business Posting Group";
        }
        //BCUP0-92 PATHAA02 08.07.26<<


        //BC Upgrade Kamnay01 >>DIT fields
        // field(2034640; "Def. Gen. Bus. Posting Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Def. Gen. Bus. Posting Group',
        //                 FRA = 'Groupe comptable marché par défaut';
        //     Description = 'DITW17.00.02 DIT-770 #143';
        //     TableRelation = "Gen. Business Posting Group";
        // }
        // field(2034982; "Work Order Mandatory"; Boolean)
        // {
        //     CaptionML = ENU = 'Work Order Mandatory',
        //                 FRA = 'Commande d''intervention oblgatoire';
        //     Description = 'DIT-715 #457';
        // }
        // BC Upgrade Kamnay01 <<DIT fields
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemJnlLine.SETRANGE("Journal Template Name",Name);
    ItemJnlLine.DELETEALL(TRUE);
    ItemJnlBatch.SETRANGE("Journal Template Name",Name);
    ItemJnlBatch.DELETEALL;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ItemJnlLine.SETRANGE("Journal Template Name",Name);
    ItemJnlLine.DELETEALL(true);
    ItemJnlBatch.SETRANGE("Journal Template Name",Name);
    ItemJnlBatch.DELETEALL;
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
}

