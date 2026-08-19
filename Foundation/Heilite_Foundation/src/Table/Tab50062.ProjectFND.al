table 50062 "Project FND"
{
    // version HEI.01

    // HEI.01 FDD-BA-PRDGAP01 IBM POSTOI01 12.07.2018
    //   # create object

    DrillDownPageID = "Project List";
    LookupPageID = "Project List";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[80])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

