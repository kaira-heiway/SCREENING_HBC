table 50386 "FM Discount Charges FND"
{
    // Heilite Navision Old Id - 50168
    // version HEI.01

    // HEI.01 FDD-HT610 IBM NASTAA02 11.12.2019 # La Reunion Futur Master
    //   # New Table created to store Legacy Futur Master Discount Charges

    // BC Upgrade MISHRS14 >>
    // Changed table name from "FM Discount Charges" to "FM Discount Charges FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    Caption = 'Maraki Interface Setup';

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(2; "Item Charge No."; Code[20])
        {
            //TableRelation = "Item Charge" WHERE ("Item Charge Type"=FILTER(Discount));  // BC Upgrade NANDIS03 - Blocked as dependecy on DIT
        }
    }

    keys
    {
        key(Key1; "Item No.", "Item Charge No.")
        {
        }
    }

    fieldgroups
    {
    }
}

