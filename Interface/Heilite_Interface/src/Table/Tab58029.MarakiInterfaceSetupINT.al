table 58029 "Maraki Interface Setup INT"
{
    // Heilite Navision Old Id - 50145
    // version HEI.01

    // HEI.01 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    //   # New table created to store Maraki Interface Setup

    Caption = 'Maraki Interface Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(10; "Sales Posting Interface"; Code[20])
        {
            Caption = 'Sales Posting Interface';
            TableRelation = "Interface Setup INT";
        }
        field(12; "Sales Confirmation Response"; Code[20])
        {
            Caption = 'Sales Confirmation Response';
            TableRelation = "Interface Setup INT";
        }
        field(13; "Status Update Interface"; Code[20])
        {
            Caption = 'Sales Update Interface';
            TableRelation = "Interface Setup INT";
        }
        field(20; "No. Of Conf Attempts"; Integer)
        {
            Caption = 'No. Of Confirmation Attempts';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

