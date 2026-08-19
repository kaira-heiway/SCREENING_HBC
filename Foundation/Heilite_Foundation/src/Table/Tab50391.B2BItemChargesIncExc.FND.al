table 50391 "B2B Item Charges Inc./Exc. FND"
{
    // Heilite Navision Old Id - 50250
    // version HEI.01

    // HEI.01 CHG2174235 IBM COSTES04 22.03.2023 Interface Order Simulation
    //   # new object for DOT order simulation

    // BC Upgrade PATELP08>>
    // Moved table from Interface to Foundation Ext.
    // Changed name of table from "B2B Item Charges Inc./Exc." to "B2B Item Charges Inc./Exc. FND"
    // BC Upgrade PATELP08<<

    Caption = 'B2B Item Charges Inc./Exc.';

    fields
    {
        field(1; "Item Charge No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Charge";
        }
        field(10; "Exclude from Total Amount"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                "Exclude from List Price" := "Exclude from Total Amount";
            end;
        }
        field(20; "Exclude from List Price"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                if not "Exclude from List Price" then
                    TESTFIELD("Exclude from Total Amount", false);
            end;
        }
        field(30; "Include in Transport Amount"; Boolean)
        {
            Caption = 'Include in Transport Amount';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Item Charge No.")
        {
        }
    }

    fieldgroups
    {
    }
}

