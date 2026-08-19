table 50258 "G/L Entry Additional FND"
{
    // version HEI.01

    // HEI.01 CHG2236692 IBM SISUM01 29.02.2024 HB3717_Development to perform revaluation for AR/AP
    //   #new object created


    fields
    {
        field(1; "G/L Entry No."; Integer)
        {
            Caption = 'G/L Entry No.';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Entry"."Entry No.";
        }
        field(2; "CV No."; Code[20])
        {
            Caption = 'Customer/Vendor No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "G/L Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

