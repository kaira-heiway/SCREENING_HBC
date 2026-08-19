table 50265 "H&S Tax Posting Group FND"
{
    // version HEI.01

    // HEI.01 CHG2224401 HB3624 YADAVM09 06.02.2024 Health and Security Levy Tax
    //   # New object created

    DataCaptionFields = "Code", Description;
    DrillDownPageID = "H&S Tax Posting Group";
    LookupPageID = "H&S Tax Posting Group";

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[30])
        {
            DataClassification = ToBeClassified;
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

