table 50115 "Payment Method Mapping CP FND"
{
    // version HEI.01

    // HEI.01 FDD-BA-SLSGAP01 IBM NASTAA02 18.10.2018 # Counterpoint Interface
    //   # New Table created to map Payment Methods from CP and HL

    Caption = 'Payment Method Mapping CP';

    fields
    {
        field(1; "CP Payment Type"; Code[20])
        {
            Description = 'Payment Method in CP';
        }
        field(2; "Location Code Heilite"; Code[10])
        {
            TableRelation = "Location Mapping CP FND"."Location Code";
        }
        field(4; "Payment GL Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(5; "CP Payment Description"; Text[50])
        {
        }
        field(8; "Excise tax Payment Type"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "CP Payment Type", "Location Code Heilite")
        {
        }
    }

    fieldgroups
    {
    }
}

