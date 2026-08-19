table 50002 "Zycus CMG Info. Buffer FND"
{
    // Heilite NAV Old Id - 50293
    // version HEI.01

    // HEI.01 CHG2293817 SAHAL01 11.03.2025 Zycus - E2E test for Zycus HL integration - G/L CMG Rule Map
    //   # Created New Table: 50293 - Zycus CMG Information Buffer
    //   # Changed Ticket No. from CHG2278614 to CHG2293817

    // BC UPGRADE PATELP08>>
    // # Tag HEI.01 added
    // # Created table from NAV object Table 50293 - Zycus CMG Information Buffer FND
    // BC UPGRADE PATELP08<<

    Caption = 'Zycus CMG Information Buffer';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
            NotBlank = true;
            Editable = false;
        }
        field(2; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
            NotBlank = true;
            Editable = false;
            TableRelation = Dimension;
        }
        field(3; "CMG Code"; Code[20])
        {
            Caption = 'CMG Code';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
            NotBlank = true;
            Editable = false;
        }
        field(4; "CTP Code"; Code[20])
        {
            Caption = 'CTP Code';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
            Editable = false;
        }
        field(5; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(6; "G/L Account Type"; Option)
        {
            Caption = 'G/L Account Type';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
            Editable = false;
            OptionCaption = 'Income Statement,Balance Sheet';
            OptionMembers = "Income Statement","Balance Sheet";
        }
        field(7; "Purchase Type Code"; Code[20])
        {
            Caption = 'Purchase Type Code';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
            Editable = false;
        }
        field(9; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
            Editable = false;
        }
        field(10; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
            Editable = false;
        }
        field(11; "Last Time Modified"; Time)
        {
            Caption = 'Last Time Modified';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
            Editable = false;
        }
        field(12; "Last Modified By User"; Code[50])
        {
            Caption = 'Last Modified By User';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
            Editable = false;
            TableRelation = User."User Name";
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                UserMgtL: Codeunit "User Management";
            begin
                // HEI.01>>
                // UserMgtL.LookupUserID("Last Modified By User"); // BC Upgrade PATELP08 >> funtion not in bc
                UserMgtL.DisplayUserInformation("Last Modified By User");
                // HEI.01<<
            end;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        // HEI.01>>
        // ERROR(Text000Lbl);
        // HEI.01<<
    end;

    trigger OnRename()
    begin
        // HEI.01>>
        Error(Text001Lbl);
        // HEI.01<<
    end;

    var
        Text000Lbl: Label 'You cannot delete the record.';
        Text001Lbl: Label 'You cannot change the primary key value in the record.';
}
