table 50389 "API Order Status Mapping FND"
{
    // Heilite Navision Old Id - 50203
    // version HEI.01

    // HEI.01 FDD-HB1234 - CHG2053453 IBM NASTAA02 15.02.2021 # B2B Order Status
    //   # New Table created for API Order Status Interface

    // BC Upgrade MISHRS14 >>
    // Changed table name to "API Order Status Mapping FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    Caption = 'API Order Status Mapping';

    fields
    {
        field(1; Source; Option)
        {
            Caption = 'Source';
            DataClassification = ToBeClassified;
            OptionCaption = 'Order,Shipment';
            OptionMembers = "Order",Shipment;
        }
        field(2; "Status Field 1"; Text[30])
        {
            Caption = 'Status Field 1';
            DataClassification = ToBeClassified;
        }
        field(3; "Status Field 2"; Text[30])
        {
            Caption = 'Status Field 2';
            DataClassification = ToBeClassified;
        }
        field(4; Message; Text[50])
        {
            Caption = 'Message';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Source, "Status Field 1", "Status Field 2")
        {
        }
    }

    fieldgroups
    {
    }
}

