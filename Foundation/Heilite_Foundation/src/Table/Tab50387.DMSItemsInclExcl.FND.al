table 50387 "DMS Items Incl. Excl. FND"
{
    // Heilite Navision Old Id - 50178
    // version HEI.01

    // HEI.01 FDD-HB1268 - CHG2068666 IBM NASTAA02 26.10.2020 # DMS Integration Ivory Coast
    //   # New Table created for DMS Interfaces

    // BC Upgrade MISHRS14 >>
    // Changed length of Data type - text from 50 to 100 due to warning in field 2.
    // BC Upgrade MISHRS14 <<

    // BC Upgrade MISHRS14 >>
    // Changed table name from "DMS Items Incl. Excl." to "DMS Items Incl. Excl. FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<


    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }

        // BC Upgrade MISHRS14 >>
        // Changed length of Data type - text from 50 to 100 due to warning in field 2.
        //field(2; Description; Text[50])
        field(2; Description; Text[100])
        // BC Upgrade MISHRS14 <<
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(10; Included; Boolean)
        {
            Caption = 'Included';

            trigger OnValidate();
            begin
                TESTFIELD(Excluded, false);
            end;
        }
        field(11; Excluded; Boolean)
        {
            Caption = 'Excluded';

            trigger OnValidate();
            begin
                TESTFIELD(Included, false);
            end;
        }
    }

    keys
    {
        key(Key1; "Item No.")
        {
        }
    }

    fieldgroups
    {
    }
}

