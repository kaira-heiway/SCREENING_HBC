table 50398 "WMS Source Sys ID FND"
{
    // Heilite Navision Old Id - 50251
    // version HEI.01

    // HEI.01 CHG2184595 IBM COSTES04 31.03.2023 Prioritization Sales Orders
    //   # new object

    // BC UPGRADE PATELS08 >>
    // # Table moved from Interfaces to Foundation Layer.
    // # Table name changed from "WMS Source System Identifier" to "WMS Source Sys ID FND". 
    // BC UPGRADE PATELS08 << 


    fields
    {
        field(1; "Source System Identifier"; Code[10])
        {
            Caption = 'Source System Identifier';
            DataClassification = CustomerContent;
        }
        field(10; "Reservation Indicator"; Boolean)
        {
            Caption = 'Reservation Indicator';
            DataClassification = CustomerContent;
        }
        field(20; "EDI System Identifier"; Boolean)
        {
            Caption = 'EDI System Identifier';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Source System Identifier")
        {
        }
    }

    fieldgroups
    {
    }
}

