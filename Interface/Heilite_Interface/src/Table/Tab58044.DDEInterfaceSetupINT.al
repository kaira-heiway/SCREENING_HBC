table 58044 "DDE Interface Setup INT"
{
    // Heilite Navision Old Id - 50174
    // version HEI.02

    // HEI.01 FDD-HT678 IBM NASTAA02 25.08.2020 # DMS / DDE Integration
    //   # New Table created for DMS / DDE Interfaces
    // HEI.02 CHG2249480 IBM COSTES04 11.06.2024 Burundi-shipment to DDE – sending all distributors related shipments to DDE
    //   # new field Enable Manual DDE Shipment

    Caption = 'Legacy Futur Master Interface Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Enable DDE Ship Interface"; Boolean)
        {
            Caption = 'Enable DDE Shipment Interface';
        }
        field(3; "Enable Manual DDE Shipment"; Boolean)
        {
            Caption = 'Enable Manual DDE Shipment';
            DataClassification = CustomerContent;
            Description = 'HEI.02';
        }
        field(10; "DDE Ship Interface Code"; Code[20])
        {
            Caption = 'DDE Shipment Interface Code';
            TableRelation = "Interface Setup INT";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

