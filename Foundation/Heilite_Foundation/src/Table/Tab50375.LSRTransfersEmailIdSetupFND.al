table 50375 "LSR Transfer Email Setup FND"
{
    // Heilite Navision Old Id - 50195
    // version HEI.01

    // HEI.01 CHG2216722 IBM SISUM01 03.10.2023  Request for email functionality for Transfer Order Creation
    //   # New object created

    // BC UPGRADE PATELS08 >>
    // # Table moved from Interfaces to Foundation Layer.
    // # Table name changed from "LSR Transfers Email Id Setup" to "LSR Transfer Email Setup FND".
    // BC UPGRADE PATELS08 <<

    Caption = 'LSR Transfers Email Id Setup';

    fields
    {
        field(1; "Transfer To Location"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(2; "Create Email Id"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Shipped Email Id"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Transfer To Location")
        {
        }
    }

    fieldgroups
    {
    }
}

