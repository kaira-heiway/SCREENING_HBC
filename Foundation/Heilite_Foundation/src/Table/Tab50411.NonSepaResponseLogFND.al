table 50411 "Non Sepa Response Log FND"
{
    // HEI.01 V1.05 HT84 IBM POENAB02 27.03.2019 # New table for Bank Connectivity interface

    //BC UPGRADE KUMARR78 >>
    // 1. TABLE ID Modification
    // ---------------------------------------------------------------------------
    // Old:
    //   TABLE 50131 "Non Sepa Response Log"
    //
    // New:
    //   TABLE 58098 "Non Sepa Response Log"
    //BC UPGRADE KUMARR78 <<

    // BC Upgrade MISHRS14 >>
    // Changed table name to "Non Sepa Response Log FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
        }
        field(3; Time; Time)
        {
            Caption = 'Time';
        }
        field(4; "Interface Code"; Code[20])
        {
            Caption = 'Interface Code';
        }
        field(5; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
        }
        field(6; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
        }
        field(7; "Journal Line No."; Integer)
        {
            Caption = 'Journal Line No.';
        }
        field(8; "Journal Document No."; Code[20])
        {
            Caption = 'Journal Document No.';
        }
        field(9; "Journal Description"; Text[50])
        {
            Caption = 'Journal Description';
        }
        field(10; Direction; Option)
        {
            Caption = 'Direction';
            OptionCaption = 'Inbound,Outbound';
            OptionMembers = Inbound,Outbound;
        }
        field(11; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(12; Message; Text[250])
        {
            Caption = 'Message';
        }
        field(13; Error; Boolean)
        {
            Caption = 'Error';
        }
        field(14; "WS MessageID"; Code[20])
        {
            Caption = 'WS MessageID';
            Description = 'HEI.01';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

