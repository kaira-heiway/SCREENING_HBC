table 50190 "Profile ID-Tile Code Setup FND"
{
    // HEI.01 CHG2070663 IBM POENAB02 18.09.2020 Role Centre Production Bottling Role Centre
    //  # New object created

    //Bc Upgrade YADAVM09 in place of profile table profile All table is used.
    fields
    {
        field(1; "Profile ID"; Code[30])
        {
            Caption = 'Profile ID';
            Description = 'HEI.01';
            //TableRelation = Profile;//Bc Upgrade YADAVM09
            TableRelation = "All Profile";//Bc Upgrade YADAVM09
        }
        field(2; "Tile Code"; Code[20])
        {
            Caption = 'Tile Code';
            Description = 'HEI.01';
        }
        field(3; "Role Centre Grouping"; Code[250])
        {
            Caption = 'Role Centre Grouping';
            Description = 'HEI.01';
        }
        field(4; Description; Text[30])
        {
            Caption = 'Description';
            Description = 'HEI.01';
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Description = 'HEI.01';
        }
    }

    keys
    {
        key(Key1; "Profile ID", "Tile Code")
        {
        }
    }

    fieldgroups
    {
    }
}

