table 50098 "Request Ord Header Archive FND"
{
    // version HEI.01

    // HEI.01 FDD-BA-LOGGAP01 IBM NASTAA02 06.07.2018 # Request Order
    //   # New Table created

    Caption = 'Request Order Header Archive';
    DataCaptionFields = "No.";
    DrillDownPageID = "Posted Request Orders";
    LookupPageID = "Posted Request Orders";

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Request Date"; Date)
        {
        }
        field(3; "To-Code"; Code[10])
        {
            TableRelation = Location;
        }
        field(4; "To-Name"; Text[50])
        {
            Editable = false;
        }
        field(5; "In-Transit Code"; Code[10])
        {
            TableRelation = Location where("Use As In-Transit" = CONST(true));
        }
        field(6; "External Document No."; Text[50])
        {
        }
        field(7; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(28; "No. Series"; Code[10])
        {
            CaptionML = ENU = 'No. Series',
                        FRA = 'Souches de n°';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(29; "Requester ID"; Code[50])
        {
            TableRelation = User;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        ERROR(Text000, TABLECAPTION);
    end;

    var
        Text000: TextConst ENU = 'You cannot delete a %1.', FRA = 'Vous ne pouvez pas renommer l''enregistrement %1.';
}

