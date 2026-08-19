table 50121 "Item Buffer FND"
{
    // version HEI.01

    // HEI.01 RFC-CHG0261845 IBM.LS 01.03.2019
    //   # Created New Table - "Item Buffer".


    fields
    {
        field(1; "Item No."; Code[20])
        {
            Description = 'HEI.01';
            Editable = false;
            TableRelation = Item;
        }
        field(2; "Active Component"; Boolean)
        {
            Description = 'HEI.01';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Item No.")
        {
        }
    }

    fieldgroups
    {
    }
}

