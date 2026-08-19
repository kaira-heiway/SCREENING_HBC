table 50092 "Customer Hierarchy FND"
{
    // HEI.01 Defect 6148 BULIMC01 IBM 10/08/2021 #Table relation property changed for Dimension Level 3 Value Code field


    fields
    {
        field(1; "Dimension Level 1 Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = Dimension;
        }
        field(2; "Dimension Level 1 Value Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Dimension Level 1 Code"));
        }
        field(3; "Dimension Level 2 Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = Dimension;
        }
        field(4; "Dimension Level 2 Value Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Dimension Level 2 Code"));
        }
        field(9; "Dimension Level 3 Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = Dimension;
        }
        field(10; "Dimension Level 3 Value Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Dimension Level 3 Code"));
        }
        field(11; "Customer No."; Code[20])
        {
            TableRelation = Customer;
        }
    }

    keys
    {
        key(Key1; "Dimension Level 1 Code", "Dimension Level 1 Value Code", "Dimension Level 2 Code", "Dimension Level 2 Value Code", "Dimension Level 3 Code", "Dimension Level 3 Value Code", "Customer No.")
        {
        }
        key(Key2; "Dimension Level 1 Value Code")
        {
        }
        key(Key3; "Dimension Level 2 Code")
        {
        }
        key(Key4; "Dimension Level 2 Value Code")
        {
        }
        key(Key5; "Dimension Level 3 Code")
        {
        }
        key(Key6; "Dimension Level 3 Value Code")
        {
        }
        key(Key7; "Customer No.")
        {
        }
    }

    fieldgroups
    {
    }
}

