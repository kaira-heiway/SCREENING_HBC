table 50266 "H&S Tax Posting Setup FND"
{
    // version HEI.01

    // HEI.01 CHG2224401 HB3624 YADAVM09 06.02.2024 Health and Security Levy Tax
    //   # New object created

    DrillDownPageID = "H&S Tax Posting Setup";
    LookupPageID = "H&S Tax Posting Setup";

    fields
    {
        field(1; "H&S Tax Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "H&S Tax Posting Group FND";
        }
        field(2; "H&S Tax %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Purchase H&S Tax Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1; "H&S Tax Posting Group")
        {
        }
    }

    fieldgroups
    {
    }
}

