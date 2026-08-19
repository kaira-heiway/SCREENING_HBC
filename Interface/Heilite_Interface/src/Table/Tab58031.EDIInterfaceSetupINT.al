table 58031 "EDI Interface Setup INT"
{
    // Heilite Navision Old Id - 50151
    // HEI.01 CHG2026335 HT653 FDD_La Reunion_EDI_EDI Order IBM GAVANM01 04.10.2019 - #new table


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Error email address"; Text[50])
        {
        }
        field(3; "Error email subject"; Text[100])
        {
        }
        field(4; "Accounting group filter"; Code[50])
        {
        }
        field(5; "SO/SRO Interface Request"; Code[20])
        {
            Caption = 'SO/SRO Interface Request';
            TableRelation = "Interface Setup INT".Code;
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

