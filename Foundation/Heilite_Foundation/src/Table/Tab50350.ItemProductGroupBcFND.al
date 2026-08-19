table 50350 "Item Product Group BC FND"
{
    //Bc Upgrade YADAVM09 new table created for item Product group code functionality.
    DataClassification = ToBeClassified;
    Caption = 'Item Product Group';
    LookupPageId = "Item Product Group Code BC";
    //Permissions = tabledata "Item Product Group BC FND" = RIMD;

    fields
    {
        field(1; "Item Category Code"; Code[10])
        {
            TableRelation = "Item Category".Code;
            DataClassification = ToBeClassified;
        }
        field(2; Code; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(3; Description; Text[50])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; "Item Category Code", Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}