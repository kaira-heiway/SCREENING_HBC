table 50210 "Tolerance Exceptions FND"
{
    // version HEI.01

    // HEI.01 FDD-HB1886 IBM NASTAA02 30.03.2021 # Specific Invoice Tolerances
    //   # New Table created for Specific Invoice Tolerances

    Caption = 'Tolerance Exceptions';
    DrillDownPageID = "Tolerance Exceptions";
    LookupPageID = "Tolerance Exceptions";

    fields
    {
        field(1; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = ,"G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(2; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
        field(10; "Upper % Tolerance"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(11; "Upper Amount Tolerance"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(15; "Lower % Tolerance"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(16; "Lower Amount Tolerance"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1; Type, "Vendor No.")
        {
        }
    }

    fieldgroups
    {
    }
}

