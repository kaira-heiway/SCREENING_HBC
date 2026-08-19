table 50368 "Adj Cost and Post to G/L FND"
{
    // version HEI.03

    // HEI.01 CHG2098896 IBM POENAB02 18.02.2021 Skip/step over error messages during running an batch job (adjust cost and post cost to G/L)
    //   # Object created
    // HEI.02 CHG2207812 IBM PRASAA03  12.06.2023 Error message Handling for more than 250 character
    //   # Added Error Log 2 Field
    // HEI.03 CHG2207812 IBM PRASAA03  13.06.2023 Error message Handling for more than 250 character
    //   # Error Log 2 Field Caption changed.

    // BC Upgrade KUMARS145 Nav ID Table 50198 "Adj Cost and Post to G/L FND"

    Caption = 'Adj Cost and Post to G/L';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
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
        field(6; "Error Message 2"; Text[250])
        {
            Caption = 'Error Message 2';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

