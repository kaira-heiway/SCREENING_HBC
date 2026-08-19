table 50260 "Revaluation Jrnl Error Log FND"
{
    // version HEI.01

    // HEI.01 CHG2187702 SAHAL01 18.08.2023 Revaluation journal items in error
    //   # Created New Table: 50260 - Revaluation Journal Error Log

    Caption = 'Revaluation Journal Error Log';
    DrillDownPageID = "Revaluation Journal Error Log";
    LookupPageID = "Revaluation Journal Error Log";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            Description = 'HEI.01';
        }
        field(2; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Description = 'HEI.01';
        }
        field(3; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            Description = 'HEI.01';
        }
        field(4; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            Description = 'HEI.01';
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Description = 'HEI.01';
        }
        field(6; "Item Ledger Entry No."; Integer)
        {
            Caption = 'Item Ledger Entry No.';
            Description = 'HEI.01';
        }
        field(8; "Error Message"; Text[250])
        {
            Caption = 'Error Message';
            Description = 'HEI.01';
        }
        field(10; "Document Type"; Option)
        {
            Caption = 'Document Type';
            Description = 'HEI.01';
            OptionCaption = '" ,Sales Shipment,Sales Invoice,Sales Return Receipt,Sales Credit Memo,Purchase Receipt,Purchase Invoice,Purchase Return Shipment,Purchase Credit Memo,Transfer Shipment,Transfer Receipt,Service Shipment,Service Invoice,Service Credit Memo,Posted Assembly,,,,,Service Receipt,Service P.Invoice,Service P.Credit Memo"';
            OptionMembers = " ","Sales Shipment","Sales Invoice","Sales Return Receipt","Sales Credit Memo","Purchase Receipt","Purchase Invoice","Purchase Return Shipment","Purchase Credit Memo","Transfer Shipment","Transfer Receipt","Service Shipment","Service Invoice","Service Credit Memo","Posted Assembly",,,,,"Service Receipt","Service P.Invoice","Service P.Credit Memo";
        }
        field(11; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Description = 'HEI.01';
        }
        field(12; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            Description = 'HEI.01';
        }
        field(13; "Document Date"; Date)
        {
            Caption = 'Document Date';
            Description = 'HEI.01';
        }
        field(16; "Order Type"; Option)
        {
            Caption = 'Order Type';
            Description = 'HEI.01';
            OptionCaption = '" ,Production,Transfer,Service,Assembly"';
            OptionMembers = " ",Production,Transfer,Service,Assembly;
        }
        field(17; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            Description = 'HEI.01';
        }
        field(18; "Order Line No."; Integer)
        {
            Caption = 'Order Line No.';
            Description = 'HEI.01';
        }
        field(21; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            Description = 'HEI.01';
        }
        field(22; "Zone Code"; Code[10])
        {
            Caption = 'Zone Code';
            Description = 'HEI.01';
        }
        field(23; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            Description = 'HEI.01';
        }
        field(26; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            Description = 'HEI.01';
        }
        field(31; Quantity; Decimal)
        {
            Caption = 'Quantity';
            Description = 'HEI.01';
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

