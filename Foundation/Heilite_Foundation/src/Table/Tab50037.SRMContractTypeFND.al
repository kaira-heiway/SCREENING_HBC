table 50037 "SRM Contract Type FND"
{
    // version HEI.01

    // HEI.01 HLSRM02 IBM LAZARE02 31.07.2017 # New table

    Caption = 'SRM Contract Type';
    LookupPageID = "SRM Contract Types";

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Allow Over Consumption on Qty."; Option)
        {
            Caption = 'Allow Over Consumption on Quantity';
            OptionCaption = 'Always,Setup Dependant,Never';
            OptionMembers = Always,"Setup Dependant",Never;
        }
        field(4; "Allow Over Consumption on Amt."; Option)
        {
            Caption = 'Allow Over Consumption on Amount';
            OptionMembers = Always,"Setup Dependant",Never;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

