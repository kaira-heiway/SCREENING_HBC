table 50351 "COGS Alloc STD Price Line FND"
{
    // version HEI.01,HEI.02

    // HEI.01 HB2605 - CHG2132673 IBM NASTAA02 15.03.2022 # COGS Allocation
    //   # New Table created
    // HEI.02 HB2605 - CHG2132673 IBM BULIMC01 06.04.2022 # COGS Allocation #new changes
    // HEI.03 CHG2135085 SAHAL01      24.03.2022
    //   # Created New Fields: 81 - Cost Energy & Water
    //                         82 - Cost Other Variable Exp.

    // BC Upgrade KUMARS145 Nav ID Table 50241 "COGS Alloc STD Price Line FND"

    Caption = 'COGS Allocation on STD Price Line';
    DrillDownPageID = "COGS Alloc on STD Price Lines";
    LookupPageID = "COGS Alloc on STD Price Lines";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Processing Date"; Date)
        {
            Caption = 'Processing Date';
            DataClassification = ToBeClassified;
        }
        field(4; "COGS Allocation"; Option)
        {
            Caption = 'COGS Allocation';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            OptionCaption = '" ,Energy & Water,Inv. Mov. Var. Prod Exp.,Other Variable Expenses,Packaging Materials,Prod Bought in for Resale,Prod Fix Exp,Raw Materials,Finished Goods"';
            OptionMembers = " ","Energy & Water","Inv. Mov. Var. Prod Exp.","Other Variable Expenses","Packaging Materials","Prod Bought in for Resale","Prod Fix Exp","Raw Materials","Finished Goods";
        }
        field(10; Company; Text[30])
        {
            Caption = 'Company';
            DataClassification = ToBeClassified;
            TableRelation = Company;
        }
        field(11; "Fiscal Year"; Integer)
        {
            Caption = 'Fiscal Year';
            DataClassification = ToBeClassified;
        }
        field(12; "Period Number"; Integer)
        {
            Caption = 'Period Number';
            DataClassification = ToBeClassified;
        }
        field(13; Location; Code[10])
        {
            Caption = 'Location';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(14; "Parent Item No."; Code[20])
        {
            Caption = 'Parent Item No.';
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(20; "Production BOM No."; Code[20])
        {
            Caption = 'Production BOM No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "Production BOM Header";
        }
        field(21; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(22; "Item UoM"; Code[10])
        {
            Caption = 'Item Unit of Measure Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(23; "Quantity per"; Decimal)
        {
            Caption = 'Quantity per';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(24; "Scrap %"; Decimal)
        {
            BlankNumbers = BlankNeg;
            Caption = 'Scrap %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
        }
        field(25; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
            DataClassification = ToBeClassified;
            TableRelation = "Routing Header";
        }
        field(30; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(32; "Unit Cost Raw&Pack"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost Raw and Pack.';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.02';
            MinValue = 0;
            TableRelation = "Base Price STD Cost Calc. FND"."Direct Unit Cost" WHERE("Item No." = FIELD("Item No."),
                                                                                  "Unit of Measure Code" = FIELD("Item UoM"));
        }
        field(33; "Unit Volume HL"; Decimal)
        {
            Caption = 'Unit Volume HL';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(40; "Quantity HL"; Decimal)
        {
            Caption = 'Quantity HL';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50; "Total Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51; Description; Text[50])
        {
            Caption = 'Description';
            Description = 'HEI.02';
        }
        field(52; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "Item Category";
        }
        field(53; "Sub-Parent Item No."; Code[20])
        {
            Caption = 'Sub-Parent Item No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = Item;
        }
        field(54; "BOM Level"; Integer)
        {
            Caption = 'BOM Level';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(55; "Qty. Including Scrap"; Decimal)
        {
            Caption = 'Qty. Including Scrap';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.02';
        }
        field(56; "Work Center No."; Code[20])
        {
            CaptionML = ENU = 'Work Center No.',
                        FRA = 'N° centre de charge';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            Editable = false;
            TableRelation = "Work Center";
        }
        field(57; "Setup Time"; Decimal)
        {
            CaptionML = ENU = 'Setup Time',
                        FRA = 'Temps de préparation';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.02';
        }
        field(58; "Run Time"; Decimal)
        {
            CaptionML = ENU = 'Run Time',
                        FRA = 'Temps d''exécution';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.02';
        }
        field(59; "Batch Size"; Decimal)
        {
            Caption = 'Batch Size';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(60; "Lot Size"; Decimal)
        {
            Caption = 'Lot Size';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(61; "Cost Raw or Pack Mat."; Decimal)
        {
            Caption = 'Cost of Raw or Packaging Materials';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.02';
        }
        field(62; "Cost Prod. Fix. Exp. BuOM"; Decimal)
        {
            Caption = 'Cost Prod. Fix. Exp. (COGS) per BuOM';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.02';
        }
        field(66; "Unit Cost of Work Center"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost of Work Center';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.02';
            MinValue = 0;
        }
        field(81; "Cost Energy & Water"; Decimal)
        {
            Caption = 'Cost Energy & Water';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.03';
        }
        field(82; "Cost Other Variable Exp."; Decimal)
        {
            Caption = 'Cost Other Variable Exp.';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.03';
        }
        field(83; "Prod. BOM Header UoM"; Code[10])
        {
            Caption = 'Production BOM Header UOM';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(84; "Prod. BOM Header in HL"; Decimal)
        {
            Caption = 'Production BOM Header in HL';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.02';
        }
        field(85; "Prod. BOM Qty. per BUoM"; Decimal)
        {
            Caption = 'Production BOM Header Qty. per BUoM';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.02';
        }
        field(86; "Qty. per HL of FG"; Decimal)
        {
            Caption = 'Qty. per 1 HL of Finished Good';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.02';
        }
        field(87; "Cost. Prod. Fix. per HL of FG"; Decimal)
        {
            Caption = 'Cost Prod. Fix. Exp. (COGS) for 1 HL of FG';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; Company, "Fiscal Year", "Period Number", "Parent Item No.")
        {
        }
    }

    fieldgroups
    {
    }
}

