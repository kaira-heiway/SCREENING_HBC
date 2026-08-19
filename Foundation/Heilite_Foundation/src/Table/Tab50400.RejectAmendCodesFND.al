table 50400 "Reject Amend Codes FND"
{
    // Heilite Navision Old Id - 80075
    // version HEI.01

    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 06.07.2021 Ibecor - PO API
    //   # New Table created for Ibecor PFI Interface

    // BC UPGRADE PATELS08 >>
    // # Table moved from Interfaces to Foundation Layer.
    // # Table name changed from "Reject Amend Codes" to "Reject Amend Codes FND".
    // BC UPGRADE PATELS08 <<

    fields
    {
        field(1; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Reject,Amend;
        }
        field(2; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Type, "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

