table 50406 "Logistics Officers FND"
{
    // Heilite Navision Old Id - 80071
    // version HEI.01

    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 25.06.2021 Ibecor - PO API
    //   # New Table created for Ibecor PFI Interface

    // BC Upgrade MISHRA14 >>
    // Changed table name to "Logistics Officers FND" as its moved from Interface to Fondation Layer.
    // BC Upgrade MISHRS14 <<


    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3; "LO Code"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "LO Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "LO Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

