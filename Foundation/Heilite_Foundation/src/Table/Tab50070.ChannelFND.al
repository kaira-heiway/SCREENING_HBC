table 50070 "Channel FND"
{
    // version HEI.01

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 18.08.2017 # MDM Customer Card
    //   # Object created
    // 
    // HEI.02 FDD-HLSRM03 IBM LAZARE02 08.09.2017 # New field Allow Purch. Price Change

    Caption = 'Channel';
    DrillDownPageID = Channels;
    LookupPageID = Channels;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(5; "Contract Type"; Option)
        {
            Caption = 'Contract Type';
            OptionCaption = 'PxQ,Value Line';
            OptionMembers = PxQ,"Value Line";
        }
        field(6; "Type ID"; Code[10])
        {
            Caption = 'Type ID';
        }
        field(10; "Allow Purch. Price Change"; Boolean)
        {
            Caption = 'Allow Purch. Price Change';
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

