table 50366 "Adj Cost Post to G/L Arch. FND"
{
    // HEI.01 CHG2098896 IBM POENAB02 18.02.2021 Skip/step over error messages during running an batch job (adjust cost and post cost to G/L)
    //   # Object created
    //BC Upgrade SHIKHA02  >>
    //   # NAV OLD ID 50199
    //BC Upgrade SHIKHA02  <<


    Caption = 'Adj Cost and Post to G/L Arch.';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(3; "Error Message"; Text[250])
        {
            Caption = 'Error Message';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(4; Date; Date)
        {
            Caption = 'Date and Time';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(5; Time; Time)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

