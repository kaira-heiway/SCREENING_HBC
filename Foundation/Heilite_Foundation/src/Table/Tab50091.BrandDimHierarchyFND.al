table 50091 "Brand Dim Hierarchy FND"
{
    // version HEI.01


    fields
    {
        field(1; "Dimension Level 1 Code"; Code[20])
        {
            NotBlank = true;
            Caption = 'Dimension Level 1 Code';
            TableRelation = Dimension;
        }
        field(2; "Dimension Level 1 Value Code"; Code[20])
        {
            NotBlank = true;
            Caption = 'Dimension Level 1 Value Code';
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Dimension Level 1 Code"));
        }
        field(3; "Dimension Level 2 Code"; Code[20])
        {
            NotBlank = true;
            Caption = 'Dimension Level 2 Code';
            TableRelation = Dimension;
        }
        field(4; "Dimension Level 2 Value Code"; Code[20])
        {
            NotBlank = true;
            Caption = 'Dimension Level 2 Value Code';
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Dimension Level 2 Code"));
        }
        field(5; "Item No."; Code[20])
        {
            NotBlank = true;
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(6; "Sold Amt"; Decimal)
        {
            Caption = 'Sold Amt';
        }
        field(7; Expenses; Decimal)
        {
            Caption = 'Expenses';
        }
        field(8; "Customer No."; Code[20])
        {
            TableRelation = Customer;
            Caption = 'Customer No.';
        }
        field(9; "Dimension Level 3 Code"; Code[20])
        {
            NotBlank = true;
            Caption = 'Dimension Level 3 Code';
            TableRelation = Dimension;
        }
        field(10; "Dimension Level 3 Value Code"; Code[20])
        {
            NotBlank = true;
            Caption = 'Dimension Level 3 Value Code';
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Dimension Level 3 Code"));
        }
        field(11; "Dimension Level 4 Code"; Code[20])
        {
            NotBlank = true;
            Caption = 'Dimension Level 4 Code';
            TableRelation = Dimension;
        }
        field(12; "Dimension Level 4 Value Code"; Code[20])
        {
            NotBlank = true;
            Caption = 'Dimension Level 4 Value Code';
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Dimension Level 4 Code"));
        }
        field(13; "Dimension Level 5 Code"; Code[20])
        {
            NotBlank = true;
            Caption = 'Dimension Level 5 Code';
            TableRelation = Dimension;
        }
        field(14; "Dimension Level 5 Value Code"; Code[20])
        {
            NotBlank = true;
            Caption = 'Dimension Level 5 Value Code';
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Dimension Level 5 Code"));
        }
        field(15; "Dimension Level 6 Code"; Code[20])
        {
            NotBlank = true;
            Caption = 'Dimension Level 6 Code';
            TableRelation = Dimension;
        }
        field(16; "Dimension Level 6 Value Code"; Code[20])
        {
            NotBlank = true;
            Caption = 'Dimension Level 6 Value Code';
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Dimension Level 6 Code"));
        }
        field(17; "New Customer No."; Code[20])
        {
        }
        field(50000; KMs; Decimal)
        {
            Caption = 'KMs';
            Description = 'HEI.01';
        }
    }

    keys
    {
        key(Key1; "Dimension Level 1 Code", "Dimension Level 1 Value Code", "Dimension Level 2 Code", "Dimension Level 2 Value Code", "Dimension Level 3 Code", "Dimension Level 3 Value Code", "Item No.", "Customer No.")
        {
        }
    }

    fieldgroups
    {
    }
}

