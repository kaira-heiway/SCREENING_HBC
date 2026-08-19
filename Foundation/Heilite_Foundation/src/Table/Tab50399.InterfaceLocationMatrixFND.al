table 50399 "Interface Location Matrix FND"
{
    // Heilite Navision Old Id - 80070
    // version HEI.02

    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 22.06.2021 Ibecor - PO API
    //   # New Table created for Ibecor Interface
    // HEI.02 CHG2195261 IBM NANDIS01 16.03.2023 # Ibecor Retrofit DCR
    //   # Changed the primary key of the table by adding "IBC Location Code"'

    // BC UPGRADE PATELS08 >>
    // # Table moved from Interfaces to Foundation Layer.
    // # Table name changed from "Interface Location Matrix" to "Interface Location Matrix FND".
    // BC UPGRADE PATELS08 <<


    fields
    {
        field(1; "Global Vendor ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Heilite Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(5; "IBC Location Code"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Global Vendor ID", "Heilite Location Code", "IBC Location Code")
        {
        }
    }

    fieldgroups
    {
    }
}

