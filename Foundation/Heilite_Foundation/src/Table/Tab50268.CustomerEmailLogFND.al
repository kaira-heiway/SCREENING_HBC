table 50268 "Customer Email Log FND"
{
    // version HEI.01

    // HEI.01 CHG2228480-HB3631 COSTES04 17.04.2024 Sierra Leone Automate the separation of deposit and finish product
    //   # New object created

    Caption = 'Customer Email Log';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(10; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(20; DateTime; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Report Sent"; Boolean)
        {
            Caption = 'Report Sent';
            DataClassification = CustomerContent;
        }
        field(40; "Error Message"; Text[100])
        {
            Caption = 'Error Message';
            DataClassification = CustomerContent;
        }
        field(50; "Period From"; Date)
        {
            Caption = 'Period From';
            DataClassification = CustomerContent;
        }
        field(51; "Period To"; Date)
        {
            Caption = 'Period To';
            DataClassification = CustomerContent;
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

