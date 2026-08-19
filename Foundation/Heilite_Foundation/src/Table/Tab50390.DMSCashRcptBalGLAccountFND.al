table 50390 "DMS Cash Rcpt Bal GL Acc FND"
{
    // Heilite Navision Old Id - 50232
    // version HEI.01

    // HEI.01 CHG2160095 IBM GHOSHS05 21.07.22 -BASE-DDE driver payment integration
    //   # New table created

    // BC Upgrade MISHRS14 >>
    // Changed name to "DMS Cash Rcpt Bal GL Acc FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    Caption = 'DMS Cash Rcpt Bal G/L Account';

    fields
    {
        field(1; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(2; "Payment Method"; Code[10])
        {
            Caption = 'Payment Method';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }
        field(5; "Balance G/L Account"; Code[20])
        {
            Caption = 'Balance G/L Account';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(10; "Cash Journal Template"; Code[10])
        {
            Caption = 'Cash Journal Template';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(11; "Cash Journal Batch"; Code[10])
        {
            Caption = 'Cash Journal Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Cash Journal Template"));
        }
    }

    keys
    {
        key(Key1; "Location Code", "Payment Method")
        {
        }
    }

    fieldgroups
    {
    }
}

