table 58093 "Err Log Prod. Plan Interf. INT"
{
    // version FM,HEI.01

    // HEI.01 CHG2207158 PATHAA02 29.08.2023 #S&OP FM-Production Plan Inbound Interface Enhancement
    //  # New Table to track the failed Interfaces lines sent from FM

    // BC Upgrade SHUKLP03 >> Nav old ID - 50257


    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Interface Code"; Code[20])
        {
            Caption = 'Interface Code';
            DataClassification = ToBeClassified;
            TableRelation = "Interface Setup INT";
        }
        field(3; Direction; Option)
        {
            Caption = 'Direction';
            DataClassification = ToBeClassified;
            OptionCaption = 'Inbound,Outbound';
            OptionMembers = Inbound,Outbound;
        }
        field(4; Date; DateTime)
        {
            Caption = 'Synchronize Date';
            DataClassification = ToBeClassified;
        }
        field(7; "Error Message"; Text[250])
        {
            Caption = 'Error Message';
            DataClassification = ToBeClassified;
        }
        field(8; "Error Source Referrence"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

