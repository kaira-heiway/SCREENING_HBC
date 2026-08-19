table 50050 "Local Customer Sub-Type FND"
{
    // version HEI.02

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 18.08.2017 # MDM Customer Card
    //   # Object created
    // HEI.02 FDD-SLSGAP001 IBM NASTAA02 12.09.2017 # MDM Customer Card
    //   # Added "Account Group" field with Table Relation to "Account Group" tableto

    Caption = 'Local Customer Sub-Type';
    DrillDownPageID = "Local Customer Sub-Type. List";
    LookupPageID = "Local Customer Sub-Type. List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; "Global Cust. Sub-Type"; Code[20])
        {
            Caption = 'Global Cust. Sub-Type';
            TableRelation = "Customer Sub-Type FND".Code;
        }
        field(4; "Account Group"; Code[20])
        {
            Caption = 'Account Group';
            Description = 'HEI.02';
            TableRelation = "Account Group FND".Code;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

