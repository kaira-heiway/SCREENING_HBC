table 50384 "Server Instance Detail FND"
{
    // Heilite Navision Old Id - 50060
    // version HEI.01

    // HEI.01 FDD-GAPID001 IBM LAZARE02 04.07.2018 # New table for Interface Common Framework

    // BC Upgrade MISHRS14 >>
    // Old Table id-58013
    // Changed table name from "Server Instance Detail" to "Server Instance Detail FND" as it moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    Caption = 'Server Instance Detail';

    fields
    {
        field(1; "Server Computer Name"; Text[250])
        {
            CaptionML = ENU = 'Server Computer Name',
                        FRA = 'Nom du serveur';
        }
        field(2; "Server Instance Name"; Text[100])
        {
            CaptionML = ENU = 'Server Instance Name',
                        FRA = 'Nom d''instance de serveur';
        }
        field(10; "Environment Code"; Option)
        {
            Caption = 'Environment Code';
            OptionCaption = 'D,Q,A,P';
            OptionMembers = D,Q,A,P;
        }
    }

    keys
    {
        key(Key1; "Server Computer Name", "Server Instance Name")
        {
        }
    }

    fieldgroups
    {
    }
}

