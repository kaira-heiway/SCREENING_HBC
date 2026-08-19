table 58022 "Maximo Item Category Flter INT"
{

    // Heilite Navision Old Id - 50094
    // version HEI.01

    // HEI.01 FDD-PURGAP026 IBM NASTAA02 26.07.2018 # Item Selection Heilite-Maximo Interface
    //   # New Table created to store the Maximo Item Category Filter
    // HEI.02 Defect #2638 IBM NASTAA02 12.09.2018 # CMG Code not updated
    //   # Changed Table Relation for "CMG Code" from "Item Attributes Value" to "Dimension Values", Length changed to 50
    //   # Deleted Field "CMG ID"

    Caption = 'Maximo Item Category Filter';
    DrillDownPageID = "Maximo Item Category Filter";
    LookupPageID = "Maximo Item Category Filter";

    fields
    {
        field(1; "Item Category"; Code[20])
        {
            Caption = 'Item Category';
            NotBlank = true;
            TableRelation = "Item Category";
        }
        field(2; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(4; "CMG Code"; Text[50])
        {
            Caption = 'CMG Code';
            FieldClass = Normal;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('CMG'));
        }
    }

    keys
    {
        key(Key1; "Item Category", "Gen. Prod. Posting Group", "CMG Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if ("Item Category" <> '') and ("CMG Code" <> '') then
            TESTFIELD("Gen. Prod. Posting Group");
    end;

    trigger OnModify();
    begin
        if ("Item Category" <> '') and ("CMG Code" <> '') then
            TESTFIELD("Gen. Prod. Posting Group");
    end;

    trigger OnRename();
    begin
        if ("Item Category" <> '') and ("CMG Code" <> '') then
            TESTFIELD("Gen. Prod. Posting Group");
    end;
}

