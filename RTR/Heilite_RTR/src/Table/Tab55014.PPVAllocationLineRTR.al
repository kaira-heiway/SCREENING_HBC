table 55014 "PPV Allocation Line RTR"
{
    // version HEI.02

    // HEI.01 CHG2193490 IBM SISUM01 26/07/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # new object created
    // HEI.02 CHG2193490 IBM SISUM01 12/09/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # change no of decimals property

    // BC Upgrade KUMARS145 Nav ID Table 50256 "PPV Allocation Line"

    Caption = 'PPV Allocation Line';
    DrillDownPageID = "PPV Allocation Line";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Processing Date"; Date)
        {
            Caption = 'Processing Date';
            DataClassification = ToBeClassified;
        }
        field(3; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = ToBeClassified;
        }
        field(4; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = ToBeClassified;
        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            TableRelation = Item."No." where("No." = field("Item No."));
        }
        field(6; Description; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Caption = 'Description';
            FieldClass = FlowField;
        }
        field(7; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            DataClassification = ToBeClassified;
            TableRelation = "Item Category".Code where(Code = field("Item Category Code"));
        }
        field(8; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            DataClassification = ToBeClassified;
        }
        field(9; "Period Purchased Qty."; Decimal)
        {
            Caption = 'Period Purchased Qty';
            DecimalPlaces = 2 : 5;
            Description = 'HEI.02';
        }
        field(10; "Period Purchased Amount"; Decimal)
        {
            Caption = 'Period Purchased Amount';
            DecimalPlaces = 2 : 5;
            Description = 'HEI.02';
        }
        field(11; "Purchase Unit Cost"; Decimal)
        {
            Caption = '"Purchase Unit Cost "';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
            Description = 'HEI.02';
        }
        field(12; "As of Purchased Qty."; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Description = 'HEI.02';
        }
        field(13; "As of Purchased Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
            Description = 'HEI.02';
        }
        field(14; "Avg. Purchased Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
            Description = 'HEI.02';
        }
        field(15; "Positive Adj. Qty"; Decimal)
        {
            FieldClass = Normal;
        }
        field(16; "As of Positive Adj. Qty."; Decimal)
        {
            FieldClass = Normal;
        }
        field(17; "Period Stock Qty."; Decimal)
        {
            FieldClass = Normal;
        }
        field(18; "Period Stock Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "YTD Stock Qty (Rem. Qty.)"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            FieldClass = Normal;
        }
        field(20; "YTD Stock Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Puchased Value of Rem. Stock"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
            Description = 'HEI.02';
        }
        field(22; "Standard Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Calc. Std. Value of Rem. Stock"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Deviation (Std. Cost Related)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "PPV Line Adj. Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(27; "As Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Item No.", "Item Category Code", "Lot No.")
        {
        }
    }

    fieldgroups
    {
    }
}

