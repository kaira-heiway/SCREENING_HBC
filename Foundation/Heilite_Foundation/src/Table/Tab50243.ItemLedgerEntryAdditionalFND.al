table 50243 "Item Ledger Entry Add FND"
{
    // version HEI.01

    // HEI.01 CHG2140470 SAHAL01 08.11.2022 # Created New Table: 50243 - Item Ledger Entry Additional

    Caption = 'Item Ledger Entry Additional';
    DrillDownPageID = "Item Ledger Entries Additional";
    LookupPageID = "Item Ledger Entries Additional";

    fields
    {
        field(1; "Item Ledger Entry No."; Integer)
        {
            Caption = 'Item Ledger Entry No.';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "Item Ledger Entry";
        }
        field(2; "Journal Template Name"; Code[10])
        {
            CaptionML = ENU = 'Journal Template Name',
                        FRA = 'Nom modèle feuille';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "Item Journal Template";
        }
        field(3; "Journal Batch Name"; Code[10])
        {
            CaptionML = ENU = 'Journal Batch Name',
                        FRA = 'Nom feuille';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(7; "Actual Posted Consumption"; Decimal)
        {
            Caption = 'Actual Posted Consumption';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.01';
            Editable = false;
        }
        field(8; "Actual Posted Lot No."; Code[20])
        {
            Caption = 'Actual Posted Lot No.';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "Lot No. Information"."Lot No.";
        }
        field(9; "Consumption Suggested"; Boolean)
        {
            Caption = 'Consumption Suggested';
            Description = 'HEI.01';
            Editable = false;
        }
        field(10; "Consumption Allocated"; Boolean)
        {
            Caption = 'Consumption Allocated';
            Description = 'HEI.01';
            Editable = false;
        }
        field(11; "Quantity Allocated"; Decimal)
        {
            Caption = 'Quantity Allocated';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.01';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Item Ledger Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

