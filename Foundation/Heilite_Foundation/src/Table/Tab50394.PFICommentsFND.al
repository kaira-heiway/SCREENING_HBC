table 50394 "PFI Comments FND"
{
    // Heilite Navision Old Id - 80078
    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 08.07.2021 Ibecor - PO API
    //   # New Page created for Ibecor PFI Interface

    // BC Upgrade PATELP08>>
    // Moved table from Interface to Foundation Ext.
    // Changed name of table from "PFI Comments" to "PFI Comments FND"
    // BC Upgrade PATELP08<<

    fields
    {
        field(1; "PFI Document No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Comments; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "PFI Document No", "Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

