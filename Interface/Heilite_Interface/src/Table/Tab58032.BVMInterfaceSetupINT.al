table 58032 "BVM Interface Setup INT"
{
    // Heilite Navision Old Id - 50154
    // version HEI.01

    // HEI.01 FDD-HT1139A IBM NASTAA02 12.05.2020 # DRC - BVM Interface
    //   # New Table created to store BVM Interface Setup

    Caption = 'BVM Interface Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Account Group Filter"; Text[100])
        {
            Caption = 'Account Group Filter';
            TableRelation = "Account Group FND";
            ValidateTableRelation = false;
        }
        field(3; "Item Category Code Filter"; Text[100])
        {
            Caption = 'Item Category Code Filter';
            TableRelation = "Item Category";
            ValidateTableRelation = false;
        }
        field(4; "Company Prefix"; Code[10])
        {
            Caption = 'Company Prefix';
        }
        field(20; "BVM Customer Interface Code"; Code[20])
        {
            Caption = 'BVM Customer Interface Code';
            TableRelation = "Interface Setup INT";
        }
        field(21; "BVM Item Interface Code"; Code[20])
        {
            Caption = 'BVM Item Interface Code';
            TableRelation = "Interface Setup INT";
        }
        field(22; "BVM Delivery Interface Code"; Code[20])
        {
            Caption = 'BVM Delivery Interface Code';
            TableRelation = "Interface Setup INT";
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

