table 55013 "PPV Allocation Header RTR"
{
    // version HEI.02

    // HEI.01 CHG2193490 IBM SISUM01 26/07/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //     # new object created
    // HEI.02 CHG2193490 IBM SISUM01 12/09/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //     # change no of decimals property

    // BC Upgrade KUMARS145 Nav ID Table 50255 "PPV Allocation Header"

    // BC Upgrade MISHRS14 >>
    // Changed Text data type length from 50 to 100 in field - "Description" due to warning.
    // BC Upgrade MISHRS14 <<


    Caption = 'PPV Allocation Header';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Processing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Month; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Year; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No." WHERE("No." = FIELD("Item No."));
        }

        // BC Upgrade MISHRS14 >>
        //field(6; Description; Text[50])
        // Changed Text data type length from 50 to 100 due to warning.
        field(6; Description; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        // BC Upgrade MISHRS14 <<

        field(7; "Item Category Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Category".Code WHERE(Code = FIELD("Item Category Code"));
        }
        field(8; "Gen. Product Posting Group"; Code[10])
        {
            Caption = 'Gen. Product Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Product Posting Group".Code;
        }
        field(9; "Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Inventory Posting Group".Code;
        }
        field(10; "Period Purchased Qty"; Decimal)
        {
            CalcFormula = Sum("PPV Allocation Line RTR"."Period Purchased Qty." WHERE(Month = FIELD(Month),
                                                                                   Year = FIELD(Year),
                                                                                   "Item No." = FIELD("Item No.")));
            Caption = 'Period Purchased Qty';
            DecimalPlaces = 2 : 5;
            Description = 'HEI.02';
            FieldClass = FlowField;
        }
        field(11; "Period Purchased Amount"; Decimal)
        {
            CalcFormula = Sum("PPV Allocation Line RTR"."Period Purchased Amount" WHERE(Month = FIELD(Month),
                                                                                     Year = FIELD(Year),
                                                                                     "Item No." = FIELD("Item No.")));
            Caption = 'Period Purchased Amount';
            DecimalPlaces = 2 : 5;
            Description = 'HEI.02';
            FieldClass = FlowField;
        }
        field(12; "As of Purchased Qty"; Decimal)
        {
            CalcFormula = Sum("PPV Allocation Line RTR"."As of Purchased Qty." WHERE(Month = FIELD(Month),
                                                                                  Year = FIELD(Year),
                                                                                  "Item No." = FIELD("Item No.")));
            Caption = 'As of Purchased Qty';
            DecimalPlaces = 2 : 5;
            Description = 'HEI.02';
            FieldClass = FlowField;
        }
        field(13; "As of Purchased Amount"; Decimal)
        {
            CalcFormula = Sum("PPV Allocation Line RTR"."As of Purchased Amount" WHERE(Month = FIELD(Month),
                                                                                    Year = FIELD(Year),
                                                                                    "Item No." = FIELD("Item No.")));
            Caption = 'As of Purchased Amount';
            DecimalPlaces = 2 : 5;
            Description = 'HEI.02';
            FieldClass = FlowField;
        }
        field(14; "Positive Adj. Qty"; Decimal)
        {
            CalcFormula = Sum("PPV Allocation Line RTR"."Positive Adj. Qty" WHERE(Month = FIELD(Month),
                                                                               Year = FIELD(Year),
                                                                               "Item No." = FIELD("Item No.")));
            Caption = 'Positive Adj. Qty';
            FieldClass = FlowField;
        }
        field(15; "As of Positive Adj. Qty"; Decimal)
        {
            CalcFormula = Sum("PPV Allocation Line RTR"."As of Positive Adj. Qty." WHERE(Month = FIELD(Month),
                                                                                      Year = FIELD(Year),
                                                                                      "Item No." = FIELD("Item No.")));
            Caption = 'As of Positive Adj. Qty';
            FieldClass = FlowField;
        }
        field(16; "Period Stock Qty"; Decimal)
        {
            CalcFormula = Sum("PPV Allocation Line RTR"."Period Stock Qty." WHERE(Month = FIELD(Month),
                                                                               Year = FIELD(Year),
                                                                               "Item No." = FIELD("Item No.")));
            Caption = 'Period Stock Qty';
            FieldClass = FlowField;
        }
        field(17; "Period Stock Balance"; Decimal)
        {
            CalcFormula = Sum("PPV Allocation Line RTR"."Period Stock Balance" WHERE(Month = FIELD(Month),
                                                                                  Year = FIELD(Year),
                                                                                  "Item No." = FIELD("Item No.")));
            Caption = 'Period Stock Balance';
            FieldClass = FlowField;
        }
        field(18; "YTD Stock Qty. (Rem. Qty.)"; Decimal)
        {
            CalcFormula = Sum("PPV Allocation Line RTR"."YTD Stock Qty (Rem. Qty.)" WHERE(Month = FIELD(Month),
                                                                                       Year = FIELD(Year),
                                                                                       "Item No." = FIELD("Item No.")));
            Caption = 'YTD Stock Qty (Remaining Quantity)';
            FieldClass = FlowField;
        }
        field(19; "YTD Stock Value"; Decimal)
        {
            CalcFormula = Sum("PPV Allocation Line RTR"."YTD Stock Value" WHERE(Month = FIELD(Month),
                                                                             Year = FIELD(Year),
                                                                             "Item No." = FIELD("Item No.")));
            Caption = 'YTD Stock Value';
            FieldClass = FlowField;
        }
        field(20; "Standard cost"; Decimal)
        {
            Caption = 'Standard cost';
            DataClassification = ToBeClassified;
        }
        field(21; "Calculated Standard Value"; Decimal)
        {
            CalcFormula = Sum("PPV Allocation Line RTR"."Calc. Std. Value of Rem. Stock" WHERE(Month = FIELD(Month),
                                                                                            Year = FIELD(Year),
                                                                                            "Item No." = FIELD("Item No.")));
            Caption = 'Calculated Standard Value';
            FieldClass = FlowField;
        }
        field(22; "Standard Cost Deviation"; Decimal)
        {
            CalcFormula = Sum("PPV Allocation Line RTR"."Deviation (Std. Cost Related)" WHERE(Month = FIELD(Month),
                                                                                           Year = FIELD(Year),
                                                                                           "Item No." = FIELD("Item No.")));
            Caption = 'Standard Cost Deviation';
            FieldClass = FlowField;
        }
        field(23; "PPV Adjustment Amount"; Decimal)
        {
            CalcFormula = Sum("PPV Allocation Line RTR"."PPV Line Adj. Amount" WHERE(Month = FIELD(Month),
                                                                                  Year = FIELD(Year),
                                                                                  "Item No." = FIELD("Item No.")));
            Caption = 'PPV Adjustment Amount';
            FieldClass = FlowField;
        }
        field(24; "Purchase Value of Rem. Stock"; Decimal)
        {
            CalcFormula = Sum("PPV Allocation Line RTR"."Puchased Value of Rem. Stock" WHERE(Month = FIELD(Month),
                                                                                          Year = FIELD(Year),
                                                                                          "Item No." = FIELD("Item No.")));
            Caption = 'Purchased value of remaining stock';
            DecimalPlaces = 2 : 5;
            Description = 'HEI.02';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Item No.", "Item Category Code")
        {
        }
    }

    fieldgroups
    {
    }
}

