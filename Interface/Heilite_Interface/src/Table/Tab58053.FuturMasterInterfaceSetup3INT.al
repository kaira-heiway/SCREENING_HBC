table 58053 "FuturMaster Interf. Stp 3 INT"
{
    // Heilite Navision Old Id - 50192
    // version HEI.08

    // HEI.01 CHG2179087 COSTES04 12.12.2022 Demand planning Sell in Actuals Month/Week - VAN
    //   # new object created
    // HEI.02 CHG2195346 PATHAA02 19.04.2023 BOM interface Enhancement
    //   # Added new Fields 123-"Exclude BOM Cmp ItemCat Filtr1" & 124-"Exclude BOM Cmp ItemCat Filtr2"
    // HEI.03 CHG2201050 17.07.2023 Standard cost Interface Chg-ETH
    //  # Added a new Field 125-"Convert Cost PC to HL"
    // HEI.05 CHG2226024 PATHAA02 28.10.23  #Bug Fix-Stock Transport Orders Interface
    //   # New Field 129-StockTransOrd Virtual Location added
    // HEI.06 CHG2232149 PATHAA02 18.12.23  #BOM Interface logic to be modified.
    //   # New Field 130-Semi Finished Goods WorkCenter added
    // HEI.07 CHG2226940 HB3632 IBM SRIVAS07 19.02.2024 # Development- Ice Cube to be removed from Item Category Code 01 (S&OP Fit Project)
    //   # Added new field CMG Filter
    // HEI.08 CHG2285048 HB4203 IBM PATHAA02 14.02.2025 # Dev-Standard cost FM interface to take the Unit cost value
    //   # Added new field 132- "Inventory Posting Group"

    Caption = 'FuturMaster Interface Setup 3';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(100; "Sell Act M. Incl. Return Rcpt."; Boolean)
        {
            Caption = 'Sell in Actuals Month Include Return Receipt';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(101; "Sell Act W. Incl. Return Rcpt."; Boolean)
        {
            Caption = 'Sell in Actuals Week Include Return Receipt';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(102; "Sell Act M3YR Incl. Rtrn Rcpt"; Boolean)
        {
            Caption = 'Sell in Actuals Month 3YR Include Return Receipt';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(103; "Sell Act W3YR Incl. Rtrn. Rcpt"; Boolean)
        {
            Caption = 'Sell in Actuals Week 3YR Include Return Receipt';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(104; "Sell Act M. Location Filter 2"; Text[30])
        {
            Caption = 'Sell in Actuals Month Location Filter 2';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(105; "Sell Act W. Location Filter 2"; Text[30])
        {
            Caption = 'Sell in Actuals Week Location Filter 2';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(106; "Sell Act M3YR Loc Filter 2"; Text[30])
        {
            Caption = 'Sell in Actuals Month 3YR Location Filter 2';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(107; "Sell Act W3YR Loc Filter 2"; Text[30])
        {
            Caption = 'Sell in Actuals Week 3YR Location Filter 2';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(108; "Sell Act M. Item Cat  Filter 2"; Text[30])
        {
            Caption = 'Sell in Actuals Month Item Category Filter 2';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(109; "Sell Act W. Item Cat Filter 2"; Text[30])
        {
            Caption = 'Sell in Actuals Week Item Category Filter 2';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(110; "Sell Act M3YR Item Ca Filter 2"; Text[30])
        {
            Caption = 'Sell in Actuals Month 3YR Item Category Filter 2';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(111; "Sell Act W3YR Item Ca Filter 2"; Text[30])
        {
            Caption = 'Sell in Actuals Week 3YR Item Category Filter 2';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(112; "Sell Act M. Acc Group Filter 2"; Text[30])
        {
            Caption = 'Customer Sell in Actuals Month Account Group Filter 2';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(113; "Sell Act W. Acc Group Filter 2"; Text[30])
        {
            Caption = 'Customer Sell in Actuals Week Account Group Filter 2';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(114; "Sell Act M3YR Acc Gr Filter 2"; Text[30])
        {
            Caption = 'Customer Sell in Actuals Month 3YR Account Group Filter 2';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(115; "Sell Act W3YR Acc Gr Filter 2"; Text[30])
        {
            Caption = 'Customer Sell in Actuals Week 3YR Account Group Filter 2';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(116; "Sell Act M. Reference Date 2"; Date)
        {
            Caption = 'Selll in Actuals Month Reference Date 2';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(117; "Sell Act W. Reference Date 2"; Date)
        {
            Caption = 'Selll in Actuals Week Reference Date 2';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(118; "Sell Act M3YR Start Date 2"; Date)
        {
            Caption = 'Sell in Actuals Month 3YR Start Date 2';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(119; "Sell Act M3YR End Date 2"; Date)
        {
            Caption = 'Sell in Actuals Month 3YR End Date 2';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(120; "Sell Act W3YR Start Date 2"; Date)
        {
            Caption = 'Sell in Actuals Week 3YR Start Date 2';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(121; "Sell Act W3YR End Date 2"; Date)
        {
            Caption = 'Sell in Actuals Week 3YR End Date 2';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(122; "Sell Act W. Previous Weeks 2"; Integer)
        {
            Caption = 'Previous Weeks Selection 2';
            DataClassification = CustomerContent;
            Description = 'HEI.01';
        }
        field(123; "Exclude BOM Cmp ItemCat Filtr1"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "Item Category";
        }
        field(124; "Exclude BOM Cmp ItemCat Filtr2"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "Item Category";
        }
        field(125; "Convert Cost PC to HL"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(126; "Transport Req. Interface"; Code[20])
        {
            Caption = 'Production Orders Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = "Interface Setup INT";
        }
        field(127; "Transport Req. WksTempName"; Code[10])
        {
            Caption = 'Production Orders Journal Template Name';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = "Req. Wksh. Template";
        }
        field(128; "Transport Req. JournBatchName"; Code[10])
        {
            Caption = 'Production Orders Journal Batch Name';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(129; "StockTransOrd Virtual Location"; Text[100])
        {
            Caption = 'StockTransOrd Virtual Location';
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
        }
        field(130; "Semi Finished Goods WorkCenter"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.06';
        }
        field(131; "CMG Filter"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(132; "Inventory Posting Group"; Code[10])
        {
            CaptionML = ENU = 'Inventory Posting Group',
                        FRA = 'Groupe compta. stock';
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
            TableRelation = "Inventory Posting Group";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

