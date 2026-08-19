table 50114 "Location Mapping CP FND"
{
    // version HEI.01

    // HEI.01 FDD-BA-SLSGAP01 IBM NASTAA02 18.10.2018 # Counterpoint Interface
    //   # New Table created to map Stores from CP and Locations from HL

    // BC Upgrade PATELP08 >>
    // # Increased field(5) length to 100 to match source field Location.Name 100 to prevent runtime error.
    // BC Upgrade PATELP08 <<

    Caption = 'Location Mapping CP';

    fields
    {
        field(1; "CP Store Code"; Code[20])
        {
            Description = 'Store ID in CP';
        }
        field(2; "Location Code"; Code[10])
        {
            Caption = 'Location Code (Heilite)';
            TableRelation = Location;
        }
        // BC Upgrade PATELP08 >> # Increased field length to 100 to match source field Location.Name 100 to prevent runtime error.
        // field(5; "Location Code Name"; Text[50])
        // {
        //     CalcFormula = Lookup(Location.Name where(Code = FIELD("Location Code")));
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        field(5; "Location Code Name"; Text[100])
        {
            CalcFormula = Lookup(Location.Name where(Code = FIELD("Location Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        // BC Upgrade PATELP08 <<
        field(10; "Accounts Receivables"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(11; "Payouts Bank Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(15; "CCC Dimension"; Code[20])
        {
            TableRelation = Dimension.Code where(Code = CONST('CCC'));
        }
        field(16; "CCC Dimension Value"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("CCC Dimension"));
        }
    }

    keys
    {
        key(Key1; "CP Store Code", "Location Code")
        {
        }
    }

    fieldgroups
    {
    }
}

