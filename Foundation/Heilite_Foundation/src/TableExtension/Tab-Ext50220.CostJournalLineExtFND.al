tableextension 50220 CostJournalLineExtFND extends "Cost Journal Line"
{
    // version NAVW19.00
    /* 
    HEI.01 FDD-BPMGAP BRD HB398 IBM NASTAA02 04.06.2019 # Actual Product Costing
      # New Field added: 50002 - Dimension Set ID
                         50003 - Starting Date
                         50004 - Ending Dateá
    HEI.02 CHG2068359 BULIMC01 IBM 08.10.2020 #new boolean field added: 50005-"Shipping Cost"
     */
    fields
    {
        modify("Journal Template Name")
        {
            CaptionML = ENU = 'Journal Template Name', FRA = 'Nom modèle feuille';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify("Cost Type No.")
        {
            CaptionML = ENU = 'Cost Type No.', FRA = 'N° type coût';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
            ClosingDates = true;
        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
        }
        modify("Journal Batch Name")
        {

            //Unsupported feature: Change TableRelation on ""Journal Batch Name"(Field 9)". Please convert manually.

            CaptionML = ENU = 'Journal Batch Name', FRA = 'Nom feuille';
        }
        modify("Bal. Cost Type No.")
        {
            CaptionML = ENU = 'Bal. Cost Type No.', FRA = 'N° type coût de solde';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify(Balance)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';

            //Unsupported feature: Change Editable on "Balance(Field 17)". Please convert manually.

        }
        modify("Debit Amount")
        {
            CaptionML = ENU = 'Debit Amount', FRA = 'Montant débit';
        }
        modify("Credit Amount")
        {
            CaptionML = ENU = 'Credit Amount', FRA = 'Montant crédit';
        }
        modify("Cost Center Code")
        {
            CaptionML = ENU = 'Cost Center Code', FRA = 'Code centre de coûts';
        }
        modify("Cost Object Code")
        {
            CaptionML = ENU = 'Cost Object Code', FRA = 'Code objet de coûts';
        }
        modify("Bal. Cost Center Code")
        {
            CaptionML = ENU = 'Bal. Cost Center Code', FRA = 'Code centre de coûts de solde';
        }
        modify("Bal. Cost Object Code")
        {
            CaptionML = ENU = 'Bal. Cost Object Code', FRA = 'Code objet de coûts de solde';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
        }
        modify("G/L Entry No.")
        {
            CaptionML = ENU = 'G/L Entry No.', FRA = 'N° séquence compta.';

            //Unsupported feature: Change Editable on ""G/L Entry No."(Field 29)". Please convert manually.

        }
        modify("Source Code")
        {
            CaptionML = ENU = 'Source Code', FRA = 'Code journal';
        }
        modify("System-Created Entry")
        {
            CaptionML = ENU = 'System-Created Entry', FRA = 'Écriture système';

            //Unsupported feature: Change Editable on ""System-Created Entry"(Field 31)". Please convert manually.

        }
        modify("Cost Entry No.")
        {
            CaptionML = ENU = 'Cost Entry No.', FRA = 'N° écriture de coûts';

            //Unsupported feature: Change Editable on ""Cost Entry No."(Field 32)". Please convert manually.

        }
        modify(Allocated)
        {
            CaptionML = ENU = 'Allocated', FRA = 'Ventilé';
        }
        modify("Allocation Description")
        {
            CaptionML = ENU = 'Allocation Description', FRA = 'Description ventilation';
        }
        modify("Allocation ID")
        {
            CaptionML = ENU = 'Allocation ID', FRA = 'ID ventilation';
        }
        modify("Additional-Currency Amount")
        {
            CaptionML = ENU = 'Additional-Currency Amount', FRA = 'Montant DR';

            //Unsupported feature: Change Editable on ""Additional-Currency Amount"(Field 68)". Please convert manually.

        }
        modify("Add.-Currency Debit Amount")
        {
            CaptionML = ENU = 'Add.-Currency Debit Amount', FRA = 'Montant débit DR';

            //Unsupported feature: Change Editable on ""Add.-Currency Debit Amount"(Field 69)". Please convert manually.

        }
        modify("Add.-Currency Credit Amount")
        {
            CaptionML = ENU = 'Add.-Currency Credit Amount', FRA = 'Montant crédit DR';

            //Unsupported feature: Change Editable on ""Add.-Currency Credit Amount"(Field 70)". Please convert manually.

        }
        modify("Budget Name")
        {
            CaptionML = ENU = 'Budget Name', FRA = 'Nom du budget';

            //Unsupported feature: Change Editable on ""Budget Name"(Field 100)". Please convert manually.

        }

        //Unsupported feature: CodeModification on ""Cost Type No."(Field 4).OnValidate". Please convert manually.

        //trigger "(Field 4)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if CostType.GET("Cost Type No.") then begin
          CostType.TESTFIELD(Blocked,false);
          CostType.TESTFIELD(Type,CostType.Type::"Cost Type");
          "Cost Center Code" := CostType."Cost Center Code";
          "Cost Object Code" := CostType."Cost Object Code";
          Description := CostType.Name;
        end;

        CalcBalance;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF CostType.GET("Cost Type No.") THEN BEGIN
          CostType.TESTFIELD(Blocked,FALSE);
        #3..6
        END;

        CalcBalance;
        */
        //end;


        //Unsupported feature: CodeModification on ""Bal. Cost Type No."(Field 11).OnValidate". Please convert manually.

        //trigger  Cost Type No();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if CostType.GET("Bal. Cost Type No.") then begin
          CostType.TESTFIELD(Blocked,false);
          CostType.TESTFIELD(Type,CostType.Type::"Cost Type");
          "Bal. Cost Center Code" := CostType."Cost Center Code";
          "Bal. Cost Object Code" := CostType."Cost Object Code";
        end;

        CalcBalance;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF CostType.GET("Bal. Cost Type No.") THEN BEGIN
          CostType.TESTFIELD(Blocked,FALSE);
        #3..5
        END;

        CalcBalance;
        */
        //end;
        field(50000; "Brand FND"; Code[20])
        {
            Caption = 'Brand';
        }
        field(50001; "Line FND"; Code[20])
        {
            Caption = 'Line';
        }
        field(50002; "Dimension Set ID FND"; Integer)
        {
            Caption = 'Dimension Set ID';
            Description = 'HEI.01';
        }
        field(50003; "Starting Date FND"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(50004; "Ending Date FND"; Date)
        {
            Caption = 'Ending Date';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(50005; "Shipping Cost FND"; Boolean)
        {
            Caption = 'Shipping Cost';
            Description = 'HEI.02';
        }
    }
    keys
    {

        //Unsupported feature: Deletion on ""Journal Template Name","Journal Batch Name","Line No."(Key)". Please convert manually.


        //Unsupported feature: Deletion on ""Cost Type No.","Cost Center Code","Cost Object Code"(Key)". Please convert manually.


        //Unsupported feature: Deletion on ""G/L Entry No."(Key)". Please convert manually.

        // key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        // {
        //     SumIndexFields = Balance;
        // }
        // key(Key2; "Cost Type No.", "Cost Center Code", "Cost Object Code")
        // {
        // }
        // key(Key3; "G/L Entry No.")
        // {
        // }
    }


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    LOCKTABLE;
    CostJournalTemplate.GET("Journal Template Name");
    CostJournalBatch.GET("Journal Template Name","Journal Batch Name");
    "Reason Code" := CostJournalBatch."Reason Code";

    if "Source Code" = '' then begin
      SourceCodeSetup.GET;
      "Source Code" := SourceCodeSetup."Cost Journal";
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    IF "Source Code" = '' THEN BEGIN
      SourceCodeSetup.GET;
      "Source Code" := SourceCodeSetup."Cost Journal";
    END;
    */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "System-Created Entry" := false;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "System-Created Entry" := FALSE;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "CheckCostCenter(PROCEDURE 2).CostCenter(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CheckCostCenter : "Cost Center";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CheckCostCenter : 1112;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CheckCostObject(PROCEDURE 3).CostObject(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CheckCostObject : "Cost Object";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CheckCostObject : 1113;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SetUpNewLine(PROCEDURE 8).CostJournalLine(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SetUpNewLine : "Cost Journal Line";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SetUpNewLine : 1101;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "IsOpenedFromBatch(PROCEDURE 42).CostJournalBatch(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //IsOpenedFromBatch : "Cost Journal Batch";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //IsOpenedFromBatch : 1102;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SourceCodeSetup(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SourceCodeSetup : "Source Code Setup";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SourceCodeSetup : 242;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CostType(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CostType : "Cost Type";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CostType : 1103;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CostJournalBatch(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CostJournalBatch : "Cost Journal Batch";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CostJournalBatch : 1102;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CostJournalTemplate(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CostJournalTemplate : "Cost Journal Template";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CostJournalTemplate : 1100;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text000(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : @@@="%2 = Cost Center or Cost Object; %3 = Cost Center or Cost Object Code";ENU=Line Type must be %1 or Begin-Total in %2 %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : @@@="%2 = Cost Center or Cost Object; %3 = Cost Center or Cost Object Code";ENU=Line Type must be %1 or Begin-Total in %2 %3.;FRA=Type ligne doit être %1 ou Début total dans %2 %3.;
    //Variable type has not been exported.
}

