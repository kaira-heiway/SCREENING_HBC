table 50409 "API Stock Info FND"
{
    // version HEI.01

    // HEI.01 FDD-HB899 - CHG2093869 IBM NASTAA02 16.03.2021 # LSR - Transfer and Stock
    //   # New Table created for API Stock Interface
    // BC Upgrade MISHRS14 >>
    // NAV OLD ID 50204
    // BC Upgrade MISHRS14 <<

    // BC Upgrade MISHRS14 >>
    // Changed table name to "API Stock Info FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<
    
    Caption = 'API Stock Info';

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(2; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(10; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Item No.", "Location Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

