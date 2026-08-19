table 58043 "SAGE Interface Setup INT"
{
    // Heilite Navision Old Id - 50173
    // HEI.01 FDD-HT664 SURYAS01 12-02-2020
    //  # New table Sage Interface Setup created.
    //  HEI.02  FDD-HT626 SURYAS01 12-02-2020
    //   #Created New Fields


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Cust Direct Debit Interface"; Code[20])
        {
            TableRelation = "Interface Setup INT";
        }
        field(3; "Vendor Non-SEPA interface"; Code[20])
        {
            Description = '/HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(4; "Vendor SEPA interface"; Code[20])
        {
            Description = '/HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(5; "Vendor Fixed Asset SEPA Interf"; Code[20])
        {
            Description = '/HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(6; "Vendor SEPA BRED Interface"; Code[20])
        {
            Description = '/HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(7; "Vendor Fixed Asset SEPA IC"; Code[20])
        {
            Description = '/HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(8; "Bank Account Balances"; Code[20])
        {
            Description = '//HEI.02';
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

