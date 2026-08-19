table 58097 "RASalesPromotionExport INT"
{
    // BC Upgrade SHUKLP03 >> Created table for RASalesPromotionExport page webservice. Restuctured code according to new table and field.

    Caption = 'RA Sales Promotion Export';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Source Type"; Enum IntlRuleSourceType105FDW)
        {
            Caption = 'Source Type';
        }
        field(2; "Source No."; Code[20])
        {
            Caption = 'Source No.';
        }
        field(3; "Item Type"; Enum IntlRuleItemType105FDW)
        {
            Caption = 'Item Type';
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(5; "Based Item Type"; Enum IntlRuleBaseItemType105FDW)
        {
            Caption = 'Minimum Based on Item Type';
        }
        field(6; "Based Location Code"; Code[10])
        {
            Caption = 'Based on Location Code';
        }
        field(7; "Based Shipment Method Code"; Code[10])
        {
            Caption = 'Based on Shipment Method Code';
        }
        field(8; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(9; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
        }
        field(10; "Minimum Quantity"; Decimal)
        {
            Caption = 'Minimum Quantity';
        }
        field(11; "Minimum Amount"; Decimal)
        {
            Caption = 'Minimum Amount';
        }
        field(12; "Free Item No."; Code[20])
        {
            Caption = 'Free Item No.';
        }
        field(13; "Free Unit of Measure Code"; Code[10])
        {
            Caption = 'Free Unit of Measure Code';
        }
        field(14; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(15; "Rule No."; integer)
        {

        }
        field(16; "Rate Value"; Decimal)
        {
            Caption = 'Unit Value';
        }
        field(17; "Free Quantity"; Decimal)
        {
            Caption = 'Free Quantity';
        }
        field(18; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        field(19; "Tier Level 1"; Decimal)
        {
            Caption = 'Tier Unit Level 1';
        }
        field(20; "Tier Level 2"; Decimal)
        {
            Caption = 'Tier Unit Level 2';
        }
        field(21; "Tier Level 3"; Decimal)
        {
            Caption = 'Tier Unit Level 3';
        }
        field(22; Calculation_Type; ENUM IntlCalculationType105FDW)
        {
            Caption = 'Calculation Type';
        }

    }
    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
        key(SK1; "Source No.", "Item No.", "Starting Date", "Ending Date") { }
    }
}
