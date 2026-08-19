table 50047 "Customer Sub-Type FND"
{
    // version HEI.01

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 18.08.2017 # MDM Customer Card
    //   # Object created

    Caption = 'Customer Sub-Type';
    DrillDownPageID = "Customer Sub-Type List";
    LookupPageID = "Customer Sub-Type List";

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
        field(3; "Account Group"; Code[20])
        {
            Caption = 'Account Group';
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

