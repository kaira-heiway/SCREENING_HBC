table 50407 "PFI Approval FND"
{
    // Heilite Navision Old Id - 80076
    // version HEI.01

    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 07.07.2021 Ibecor - PO API
    //   # New Table created for Ibecor PFI Interface
    
    // BC Upgrade MISHRS14 >>
    // Changed table name to "PFI Approval FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    fields
    {
        field(1; "PFI document No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "PFI Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Accepted,Rejected;
        }
        field(3; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(4; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Comments; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Rejected; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Accepted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Rejected Reason"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Amend; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Amend Reason"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Mail Sent"; Boolean)
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

