table 50007 "Blocked Reason FND"
{
    // version HEI.01

    // HEI.01 FDD-OTCGAP057 IBM.NAIKH01 29-06-2017
    //   # created a new Table for Customers flagged for litigation

    DrillDownPageID = "Blocked Reasons";
    LookupPageID = "Blocked Reasons";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Description = 'HEI.01';

        }
        field(2; Description; Text[50])
        {
            Description = 'HEI.01';
        }
        field(3; Type; Option)
        {
            Description = 'HEI.01';
            OptionCaption = ' ,Litigation,Legal';
            OptionMembers = " ",Litigation,Legal;
        }
    }

    keys
    {
        key(Key1; "Code", Type)
        {
        }
    }

    fieldgroups
    {
    }
}

