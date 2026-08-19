table 50378 "EBM Log FND"
{
    // Heilite Navision Old Id - 50067
    // version HEI.01

    // HEI.01 RW-GAPLOG08 IBM LAZARE02 23.10.2018 # New table for EBM interface
    // HEI.02 FDD-ET-MARAKI POS Interface IBM NASTAA02 06.08.2019 # Maraki POS Interface
    //   # New Fields created: 20 - Maraki Fiscal No.
    //                         21 - Maraki Posted Date
    //                         22 - Maraki Machine No.
    // BC Upgrade PATELP08>>
    // Moved table from Interface to Foundation Ext.
    // Changes name of table from "EBM Log" to "EBM Log FND"
    // BC Upgrade PATELP08<<

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = " ",Invoice,"Credit Memo";
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Date and Time Stamped SDC"; Text[50])
        {
            Caption = 'Date and Time Stamped SDC';
        }
        field(4; "Receipt Signature"; Text[50])
        {
            Caption = 'Receipt Signature';
        }
        field(5; "Sequential Receipt Type Number"; Text[50])
        {
            Caption = 'Sequential Receipt Type Number';
        }
        field(7; "Date and Time Stamped CIS"; Text[50])
        {
            Caption = 'Date and Time Stamped CIS';
        }
        field(8; "Machine Registration Code"; Text[50])
        {
            Caption = 'Machine Registration Code';
        }
        field(9; "SDC Identification Number"; Text[50])
        {
            Caption = 'SDC Identification Number';
        }
        field(10; "Internal Data"; Text[50])
        {
            Caption = 'Internal Data';
        }
        field(20; "Maraki Fiscal No."; Text[25])
        {
            Description = 'HEI.02';
        }
        field(21; "Maraki Posted Date"; Date)
        {
            Description = 'HEI.02';
        }
        field(22; "Maraki Machine No."; Text[12])
        {
            Description = 'HEI.02';
        }
        field(23; "Maraki Supress Value"; Boolean)
        {
            Description = 'HEI.02';
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.")
        {
        }
    }

    fieldgroups
    {
    }
}

