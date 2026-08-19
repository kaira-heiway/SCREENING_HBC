table 50283 "Customer Statement Setup FND"
{
    // version HEI.01

    // HEI.01 CHG2228480-HB3631 COSTES04 02.08.2024 Sierra Leone Automate the separation of deposit and finish product
    //   # New object created


    fields
    {
        field(1; Frequency; Option)
        {
            Caption = 'Frequency';
            DataClassification = CustomerContent;
            OptionMembers = Weekly,Monthly;
        }
        field(10; "Start Date"; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(11; "End Date"; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(20; "Running Date"; DateFormula)
        {
            Caption = 'Running Date';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Frequency)
        {
        }
    }

    fieldgroups
    {
    }
}

