table 50259 "Detail CVLedgerEntry Addit FND"
{
    // version HEI.02

    // HEI.01 CHG2236692 IBM SISUM01 29.02.2024 HB3717_Development to perform revaluation for AR/AP
    //   #new object created
    // HEI.02 CHG2236692 IBM POENAB02 09.04.2024 HB3717_Change in the process of performing revaluation for AR/AP
    //   # New field added: 4 "CV Ledger Entry No."

    Caption = 'Detailed CV Ledger Entry Addit';

    fields
    {
        field(1; "Detaile CV Ledger Entry No."; Integer)
        {
            Caption = 'Detaile CV Ledger Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Source Type"; Option)
        {
            Caption = 'Source Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Customer,Vendor';
            OptionMembers = Customer,Vendor;
        }
        field(3; "Reverse Unrealiz Gain/Loss"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "CV Ledger Entry No."; Integer)
        {
            Caption = 'CV Ledger Entry No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
    }

    keys
    {
        key(Key1; "Detaile CV Ledger Entry No.", "Source Type")
        {
        }
    }

    fieldgroups
    {
    }
}

