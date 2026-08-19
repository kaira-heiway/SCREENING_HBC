table 50381 "Cash Rcpt Bal G/L Account FND"
{
    // Heilite Navision Old Id - 50179
    // version HEI.01

    // HEI.01 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
    //   # New Table created to store Balance G/L Accouts for Payment Interface

    // BC Upgrade PATELP08>>
    // Moved table from Interface to Foundation Ext.
    // Changed name of table from "Cash Rcpt Bal G/L Account" to "Cash Rcpt Bal G/L Account FND"
    // BC Upgrade PATELP08<<

    Caption = 'Cash Receipt Balance G/L Account';

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

