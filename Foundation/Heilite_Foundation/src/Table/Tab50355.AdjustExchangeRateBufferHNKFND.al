table 50355 AdjustExchangeRateBufferHNKFND
{
    //BC Upgrade POENAB02, 06.04.2026, "RTR112-Revaluation of AR"
    // new object

    Caption = 'AdjustExchangeRateBufferHNK';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = SystemMetadata;
            TableRelation = Currency;
        }
        field(2; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            DataClassification = SystemMetadata;
        }
        field(3; AdjBase; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'AdjBase';
            DataClassification = SystemMetadata;
        }
        field(4; AdjBaseLCY; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'AdjBaseLCY';
            DataClassification = SystemMetadata;
        }
        field(5; AdjAmount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'AdjAmount';
            DataClassification = SystemMetadata;
        }
        field(6; TotalGainsAmount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'TotalGainsAmount';
            DataClassification = SystemMetadata;
        }
        field(7; TotalLossesAmount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'TotalLossesAmount';
            DataClassification = SystemMetadata;
        }
        field(8; "Dimension Entry No."; Integer)
        {
            Caption = 'Dimension Entry No.';
            DataClassification = SystemMetadata;
        }
        field(9; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = SystemMetadata;
        }
        field(10; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            DataClassification = SystemMetadata;
        }
        field(11; Index; Integer)
        {
            Caption = 'Index';
            DataClassification = SystemMetadata;
        }
        field(50000; "Detailed Entry No."; Integer)
        {
            Caption = 'Detailed Entry No.';
        }
        field(50001; "Acc Type"; Integer)
        {
            Caption = 'Acc Type';
        }
        field(50002; "CV Ledger Entry No."; Integer)
        {
            Caption = 'CV Ledger Entry No.';
        }
    }
    keys
    {
        key(Hey1; "Currency Code", "Posting Group", "Dimension Entry No.", "Posting Date", "IC Partner Code", "Detailed Entry No.")
        {
            Clustered = true;
        }
    }
}
