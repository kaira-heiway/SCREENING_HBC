table 50340 "Dimension Relations FND"
{
    // version HEI.01,Bogdan

    //DrillDownPageID = 80077;  // BC Upgrade NANDIS03 - Redundant Code

    //Table ID chenged from 80077 to 50340  - // BC Upgrade NANDIS03

    fields
    {
        field(1; "Order No."; Integer)
        {
        }
        field(2; "Dimension Code"; Code[20])
        {
            Editable = true;
            TableRelation = Dimension.Code;
        }
    }

    keys
    {
        key(Key1; "Order No.")
        {
        }
    }

    fieldgroups
    {
    }
}

