table 54002 "Actual Product Cost Struct DTW"
{
    // version HEI.01
    // HEI.01 FDD-BPMGAP BRD HB398 IBM NASTAA02 14.05.2019 # Actual Product Costing
    //   # New Table created to store Actual Product Cost Structure
    //  BC Upgrade KUMARS145 Nav ID Table 50133	"Actual Product Cost Structure"

    Caption = 'Actual Product Cost Structure';
    DrillDownPageID = "Actual Product Cost Tree";
    LookupPageID = "Actual Product Cost Tree";

    fields
    {
        field(1; "Item No."; Code[20])
        {
            TableRelation = Item;
        }
        field(2; "Location Code"; Code[10])
        {
            TableRelation = Location;
        }
        field(3; "Total Actual Quantity"; Decimal) { }
        field(4; "Base Unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(5; "Total Actual Qty in PUM"; Decimal)
        {
            Caption = 'Total Actual Qty in PUM';
        }
        field(6; "Total Actual Qty in HL"; Decimal)
        {
            Caption = 'Total Actual Qty in HL';
        }
        field(7; "Total Actual Cost"; Decimal) { }
        field(8; "Total Expected Cost"; Decimal) { }
        field(9; "Total Std Cost"; Decimal)
        {
            Caption = 'Total Standard Cost';
        }
        field(10; "Total Variance"; Decimal) { }
        field(11; "As % of Std Cost"; Decimal)
        {
            Caption = 'Total Variance as % of Std. Cost';
        }
        field(12; "Price Variance"; Decimal) { }
        field(13; "As % of Price"; Decimal)
        {
            Caption = 'Price Variance as % of Std. Cost';
        }
        field(14; "Consumption Variance"; Decimal) { }
        field(15; "As % of Std Consumption"; Decimal)
        {
            Caption = 'Consumption Variance as % of Std. Cost';
        }
        field(16; "Actual Cost BUoM"; Decimal) { }
        field(17; "Actual Cost PUM"; Decimal) { }
        field(18; "Actual Cost HL"; Decimal) { }
        field(19; "Exp Cost BUoM"; Decimal) { }
        field(20; "Exp Cost PUM"; Decimal) { }
        field(21; "Exp Cost HL"; Decimal) { }
        field(22; "Std Cost BUoM"; Decimal)
        {
            Caption = 'Standard Cost BUoM';
        }
        field(23; "Std Cost PUM"; Decimal)
        {
            Caption = 'Standard Cost PUM';
        }
        field(24; "Std Cost HL"; Decimal)
        {
            Caption = 'Standard Cost HL';
        }
        field(25; "Standard Consumption"; Decimal) { }
        field(26; Archived; Boolean) { }
        field(27; "Period Actual Quantity"; Decimal)
        {
            Caption = 'Period Actual Quantity';
        }
        field(28; "Period Actual Cost"; Decimal)
        {
            Caption = 'Period Actual Cost';
        }
        field(30; "Starting Date"; Date) { }
        field(31; "Ending Date"; Date) { }
        field(35; "Item Category Code"; Code[20])
        {
            TableRelation = "Item Category";
        }
        field(36; "Product Type"; Option)
        {
            OptionMembers = "Raw and Packaging Material Cost","Semi-Finished Goods Cost","Finished Goods Cost";
        }
        field(37; "Variant Code"; Code[10])
        {
            CaptionML = ENU = 'Variant Code',
                        FRA = 'Code variante';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(38; "Is Child"; Boolean) { }
        field(39; "Is on Tree"; Boolean) { }
        field(42; "Use Std Cost SKU"; Boolean) { }
        field(43; "Calculation Corrected"; Boolean) { }
        field(45; Negatives; Decimal) { }
        field(46; Transfers; Decimal) { }
        field(47; Positives; Decimal) { }
        field(48; Purchases; Decimal) { }
        field(49; "Prod. Orders Non Consumpt"; Decimal) { }
        field(50; "Prod. Orders Consumption"; Decimal) { }
        field(59; "Period Expected Quantity"; Decimal)
        {
            Caption = 'Period Expected Quantity';
        }
        field(60; "Tree Level"; Integer) { }
        field(61; "Line No."; Integer) { }
        field(62; "Parent Line No."; Integer) { }
        field(63; "Is Parent"; Boolean) { }
        field(64; "Variable Cost Line"; Boolean) { }
        field(65; "Capacity Cost Line"; Boolean) { }
        field(66; "Parent Item No."; Code[20])
        {
            FieldClass = Normal;
        }
    }

    keys
    {
        key(Key1; "Line No.") { }
        key(Key2; "Item No.", "Location Code", "Starting Date", "Ending Date") { }
    }

    fieldgroups
    {
    }
}

