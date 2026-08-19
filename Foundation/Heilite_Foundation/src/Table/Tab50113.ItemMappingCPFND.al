table 50113 "Item Mapping CP FND"
{
    // version HEI.01

    // HEI.01 FDD-BA-SLSGAP01 IBM NASTAA02 18.10.2018 # Counterpoint Interface
    //   # New Table created to map Items from CP and HL

    //SHIKHD02>>
    //Updated the FlowField "Heilite Item Description" length from Text[50] to Text[100] to align with the source field definition
    //SHIKHD02<<

    Caption = 'Item Mapping CP';

    fields
    {
        field(1; "CP Item ID"; Code[20])
        {
            Description = 'SKU ID in CP';
        }
        field(2; "Heilite Item ID"; Code[20])
        {
            TableRelation = Item;
        }
        //SHIKHD02>>
        //Updated the FlowField "Heilite Item Description" length from Text[50] to Text[100] to align with the source field definition
        field(5; "Heilite Item Description"; Text[100])
        {
            CalcFormula = Lookup(Item.Description where("No." = FIELD("Heilite Item ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        //SHIKHD02<<
        field(10; "Item Product Posting"; Code[20])
        {
            CalcFormula = Lookup(Item."Gen. Prod. Posting Group" where("No." = FIELD("Heilite Item ID")));
            Caption = 'Item - Product Posting';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Item Sales Account"; Code[20])
        {
            Caption = 'Item - Sales Account';
            TableRelation = "G/L Account";
        }
        field(12; "Item Sales Discount"; Code[20])
        {
            Caption = 'Item - Sales Discount';
            TableRelation = "G/L Account";
        }
        field(13; "Item Free Item Sales"; Code[20])
        {
            Caption = 'Item - Free Item Sales';
            TableRelation = "G/L Account";
        }
        field(20; "Top-Up Item"; Boolean)
        {

            trigger OnValidate();
            begin
                if "Top-Up Item" then
                    "Excise Tax Item" := false;
            end;
        }
        field(21; "Excise Tax Item"; Boolean)
        {

            trigger OnValidate();
            begin
                if "Excise Tax Item" then
                    "Top-Up Item" := false;
            end;
        }
        field(25; Dimension; Code[20])
        {
            TableRelation = Dimension;

            trigger OnValidate();
            begin
                if "Dimension Value" <> '' then
                    CLEAR("Dimension Value");
            end;
        }
        field(26; "Dimension Value"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD(Dimension));
        }
    }

    keys
    {
        key(Key1; "CP Item ID", "Heilite Item ID")
        {
        }
    }

    fieldgroups
    {
    }
}

