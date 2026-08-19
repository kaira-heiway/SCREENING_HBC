table 50001 "GL Bulk Application FND"
{
    // HEI.01 CHG2317671 IBM POENAB02 02.10.2025 HB2428 Excel Mapping Report IBM tool for closing GL entries for GL Account with big volume of data
    //   # Object created
    // HEI.02 CHG2338202 IBM POENAB02 08.01.2026 Optimization needed for GL Mass Clearing report
    //   # New key created: "Application Combination"

    // BC UPGRADE PATELS08 >>
    // # Tags HEI.01 and HEI.02 added
    // # Created table
    // # NAV ID : 50290
    // BC UPGRADE PATELS08 <<

    Caption = 'GL Bulk Application';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Entry No. PK"; Integer)
        {
            Caption = 'Entry No. PK';
        }
        field(2; "Application Combination"; Integer)
        {
            Caption = 'Application Combination';
        }
        field(3; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(5; "Entry No. To Apply To"; Integer)
        {
            Caption = 'Entry No. To Apply To';
        }
        field(6; "Amount To Apply To"; Decimal)
        {
            Caption = 'Amount To Apply To';
        }
        field(7; "Amount From GL Entry (HeiLite)"; Decimal)
        {
            Caption = 'Amount From GL Entry (HeiLite)';
        }
        field(8; "Amount To Apply To (HeiLite)"; Decimal)
        {
            Caption = 'Amount To Apply To (HeiLite)';
        }
        field(9; "Difference (HeiLite)"; Decimal)
        {
            Caption = 'Difference (HeiLite)';
        }
        field(10; "Entry No. - Open (HeiLite)"; Text[30])
        {
            Caption = 'Entry No. - Open (HeiLite)';
        }
        field(11; "Entry No.ToApply-Open(HeiLite)"; Text[30])
        {
            Caption = 'Entry No.ToApply-Open(HeiLite)';
        }
        field(12; "Error Message"; Text[250])
        {
            Caption = 'Error Message';
        }
        field(13; "Error Message 2"; Text[250])
        {
            Caption = 'Error Message 2';
        }
        field(14; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
        }
        field(15; "Apply with G/L Account No."; Code[20])
        {
            Caption = 'Apply with G/L Account No.';
        }
    }
    keys
    {
        key(PK; "Entry No. PK")
        {
            Clustered = true;
        }

        key(PK2;"Error Message")
        {
        }

        key(PK3; "Application Combination")
        {
        }
    }
}
