table 58026 "Bank Conn. Interface Setup INT"
{
    // Heilite Navision Old Id - 50130
    // version HEI.01

    // HEI.01 V1.05 HT84 IBM POENAB02 19.03.2019 # New table for Bank Connectivity interface
    // 
    // HEI.02 CHG2020184 IBM POENAB02 26.06.2019 Bank Connectivity interface
    //   # New fields:
    //     # 4 CAMT053 Inbound Interface
    //     # 5 MT940 Inbound Interface

    Caption = 'Bank Connectivity Interface Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            Description = 'HEI.01';
        }
        field(2; "Non-SEPA Outbound Interface"; Code[20])
        {
            Caption = 'Non-SEPA Outbound Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(3; SNDPRN; Text[50])
        {
            Caption = 'SNDPRN';
            Description = 'HEI.01';
        }
        field(4; "CAMT053 Inbound Interface"; Code[20])
        {
            Caption = 'CAMT053 Inbound Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(5; "MT940 Inbound Interface"; Code[20])
        {
            Caption = 'MT940 Inbound Interface';
            Description = 'HEI.02';
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

