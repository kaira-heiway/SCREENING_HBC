table 50016 "Restricted Fld User Access FND"
{
    // version HEI.01

    // HEI.01 FDD-HNK-HeiliteBASE-OTCGAP015a IBM ISYED01 11/07/2017
    //   #Added new table Restricted field user access


    fields
    {
        field(1; "Table ID"; Integer)
        {
            Description = 'HEI.01';
        }
        field(2; "Field ID"; Integer)
        {
            Description = 'HEI.01';
        }
        field(3; Type; Option)
        {
            Description = 'HEI.01';
            OptionCaption = 'User,User Group';
            OptionMembers = User,"User Group";
        }
        field(4; "User / User Group ID"; Code[50])
        {
            Description = 'HEI.01';
        }
    }

    keys
    {
        //added Type key to remove warning in Page 51014 in CBN line 73
        key(Key1; "Table ID", "Field ID",Type,"User / User Group ID")
        {
        }
        key(Key2; "User / User Group ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    var
        User: Record User;
    begin
    end;

    var
        User: Record User;
}

