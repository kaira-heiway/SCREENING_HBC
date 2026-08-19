table 54001 "Actual Product Cost DTW"
{
    // version HEI.01

    // HEI.01 FDD-BPMGAP BRD HB398 IBM NASTAA02 19.04.2019 # Actual Product Costing
    //   # New Table created to store Actual Product Costs

    //   BC Upgrade KUMARS145 Nav ID Table 50127 "Actual Product Cost" 

    Caption = 'Actual Product Cost';
    DrillDownPageID = "Raw and Pack Material Cost";
    LookupPageID = "Raw and Pack Material Cost";

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
        field(40; "Is Parent"; Boolean) { }
        field(42; "Use Std Cost SKU"; Boolean) { }
        field(43; "Calculation Corrected"; Boolean) { }
        field(45; Negatives; Decimal) { }
        field(46; Transfers; Decimal) { }
        field(47; Positives; Decimal) { }
        field(48; Purchases; Decimal) { }
        field(49; "Prod. Orders Non Consumpt"; Decimal) { }
        field(50; "Prod. Orders Consumption"; Decimal) { }
    }

    keys
    {
        key(Key1; "Item No.", "Location Code", "Starting Date", "Ending Date") { }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    var
        ActualProductCostStructure: Record "Actual Product Cost Struct DTW";
    begin
        ActualProductCostStructure.SETCURRENTKEY("Item No.", "Location Code", "Starting Date", "Ending Date");
        ActualProductCostStructure.SETRANGE("Item No.", "Item No.");
        ActualProductCostStructure.SETRANGE("Location Code", "Location Code");
        ActualProductCostStructure.SETRANGE("Starting Date", "Starting Date");
        ActualProductCostStructure.SETRANGE("Ending Date", "Ending Date");
        if ActualProductCostStructure.FINDFIRST() then
            ActualProductCostStructure.DELETEALL();
    end;
}

