table 58017 "FuturMaster Interf. Setup INT"
{
    // Heilite Navision Old Id - 50068
    // version FM

    // HEI.01 S&OP FuturMaster Interfaces IBM LAZARE01
    //   # created object
    // HEI.02 S&OP FuturMaster Interfaces IBM POSTOI01 14.11.2018
    //   # create 8 new fields 12,13,14,101 ,102,103,104->121,200->205
    // HEI.03 S&OP FuturMaster Interfaces IBM POSTOI01 26.02.2019
    //   #add new field 142
    // 
    // HEI.04 CHG2042680 IBM TUDOSG01 04.02.2019 # New field "Cust. Contract Type Excl Filte"
    // HEI.05 CHG2042680 IBM.LS 21.07.2020
    //   # Datatype of the Field - "Cust. Contract Type Excl Filte" has been modified from Text to Option.
    // HEI.06 CHG2119356 HB2414 IBM GAVANM01 25.08.2021 #Update S&OP Core FuturMaster DP Customer Master interface
    //   # add new OptionString for field "Cust. Contract Type Excl Filte",  value Not Applicable
    //   # add Caption for field "Cust. Contract Type Excl Filter"
    // HEI.07 CHG2147112 HB2791 IBM BHANDS01 04.03.2022 Update in logic for FuturMaster DP Sell In Actuals Week
    //   # added new field "Sell Act Wk Prev Weeks"

    Caption = 'FuturMaster Interface Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(10; "Product Master Req. Interface"; Code[20])
        {
            Caption = 'Product Master Request Interface';
            TableRelation = "Interface Setup INT";
        }
        field(11; "Product Master Resp. Interface"; Code[20])
        {
            Caption = 'Product Master Response Interface';
            TableRelation = "Interface Setup INT";
        }
        field(12; "Cust. Master Req. Interface"; Code[20])
        {
            Caption = 'Customer Master Request Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(13; "Cust. Master Resp. Interface"; Code[20])
        {
            Caption = 'Customer Master Response Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(14; "Sell Act Mth Req. Interface"; Code[20])
        {
            Caption = 'Sell in Actuals Month Req. Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(15; "Sell Act Mth Resp. Interface"; Code[20])
        {
            Caption = 'Sell in Actuals Month Resp. Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(16; "Sell Act Week Req. Interface"; Code[20])
        {
            Caption = 'Sell in Actuals Week Req. Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(17; "Sell Act Week Resp. Interface"; Code[20])
        {
            Caption = 'Sell in Actuals Week Resp. Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(18; "Sell Act Mth 3YR  Req. Interf"; Code[20])
        {
            Caption = 'Sell in Actuals Month 3YR Req. Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(19; "Sell Act Mth 3YR Resp. Interf"; Code[20])
        {
            Caption = 'Sell in Actuals Month 3YR Resp. Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(20; "Sell Act Week 3YR  Req. Interf"; Code[20])
        {
            Caption = 'Sell in Actuals Week 3YR Req. Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(21; "Sell Act Week 3YR Resp. Interf"; Code[20])
        {
            Caption = 'Sell in Actuals Week 3YR Resp. Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(22; "Demand Plann Open Order Interf"; Code[20])
        {
            Caption = 'Demand Planning Open Orders Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(23; "Product Master Interface"; Code[20])
        {
            Caption = 'Product Master Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(24; "Customer Master Interface"; Code[20])
        {
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(25; "Sell Act Month Interface"; Code[20])
        {
            Caption = 'Sell in Actuals Month Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(26; "Sell Act Week Interface"; Code[20])
        {
            Caption = 'Sell in Actuals Week Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(27; "Sell Act Week 3YR Interface"; Code[20])
        {
            Caption = 'Sell in Actuals Week 3YR Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(28; "Sell Act Month 3YR Interface"; Code[20])
        {
            Caption = 'Sell in Actuals Month 3YR Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(29; "Supply Plann Open Order Interf"; Code[20])
        {
            Caption = 'Supply Planning Open Orders Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(30; "Stock on Hand Interface"; Code[20])
        {
            Caption = 'Stock on Hand Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(31; "Component Product Interface"; Code[20])
        {
            Caption = 'Component Product Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(32; "Finished Product UOM Interface"; Code[20])
        {
            Caption = 'Finished Products Units of Measure Interface';
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(100; "Product Master Category Filter"; Text[100])
        {
            Caption = 'Product Master Category Filter';
            Description = 'HEI.02';
        }
        field(101; "Cust. Master Acc Group Filter"; Text[100])
        {
            Caption = 'Customer Master Account Group Filter';
            Description = 'HEI.02';
        }
        field(102; "Sell Act MTH Doc Types Filter"; Text[100])
        {
            Caption = 'Sell in Actuals Month Document Types Filter';
            Description = 'HEI.02';
        }
        field(103; "Sell Act MTH Item Categ Filter"; Text[100])
        {
            Caption = 'Sell in Actuals Month Item Category Filter';
            Description = 'HEI.02';
        }
        field(104; "Sell Act MTH Location Filter"; Text[100])
        {
            Caption = 'Sell in Actuals Month Location Filter';
            Description = 'HEI.02';
        }
        field(105; "Demand Pl OO Item Categ Filter"; Text[100])
        {
            Caption = 'Demand Planning Open Orders Item Category  Filter';
            Description = 'HEI.02';
        }
        field(106; "Demand Pl OO  Doc Types Filter"; Text[100])
        {
            Caption = 'Demand Planning Open Orders Doc Types Filter';
            Description = 'HEI.02';
        }
        field(107; "Product Master Def UOM"; Code[10])
        {
            Caption = 'Product Master Default Unit of Measure';
            Description = 'HEI.02';
            TableRelation = "Unit of Measure";
        }
        field(108; "Sell Act Week Doc Types Filter"; Text[100])
        {
            Caption = 'Sell in Actuals Week Document Types Filter';
            Description = 'HEI.02';
        }
        field(109; "Sell Act MTH3YR Doc Typ Filter"; Text[100])
        {
            Caption = 'Sell in Actuals Month 3YR Document Types Filter';
            Description = 'HEI.02';
        }
        field(110; "Sell Act WK3YR Doc Typ Filter"; Text[100])
        {
            Caption = 'Sell in Actuals Week 3YR Document Types Filter';
            Description = 'HEI.02';
        }
        field(111; "Sell Act Week Location Filter"; Text[100])
        {
            Caption = 'Sell in Actuals Week Location Filter';
            Description = 'HEI.02';
        }
        field(112; "Sell Act MTH3YR Loc Filter"; Text[100])
        {
            Caption = 'Sell in Actuals Month 3YR Location Filter';
            Description = 'HEI.02';
        }
        field(113; "Sell Act WK3YR Loc Filter"; Text[100])
        {
            Caption = 'Sell in Actuals Week 3YR Location Filter';
            Description = 'HEI.02';
        }
        field(114; "Sell Act Week Item Cat Filter"; Text[100])
        {
            Caption = 'Sell in Actuals Week Item Category Filter';
            Description = 'HEI.02';
        }
        field(115; "Sell Act MTH3YR Item Ca Filter"; Text[100])
        {
            Caption = 'Sell in Actuals Month 3YR Item Category Filter';
            Description = 'HEI.02';
        }
        field(116; "Sell Act WK3YR Item Cat Filter"; Text[100])
        {
            Caption = 'Sell in Actuals Week 3YR Item Category Filter';
            Description = 'HEI.02';
        }
        field(117; "Cust. DOO Acc Group Filter"; Text[100])
        {
            Caption = 'Customer Demand Open Orders Account Group Filter';
            Description = 'HEI.02';
        }
        field(118; "Cust.SellActM Acc Group Filter"; Text[100])
        {
            Caption = 'Customer Sell in Actuals Month Account Group Filter';
            Description = 'HEI.02';
        }
        field(119; "Cust.SellActW Acc Group Filter"; Text[100])
        {
            Caption = 'Customer Sell in Actuals Week Account Group Filter';
            Description = 'HEI.02';
        }
        field(120; "Cust.SellActM3 Acc Gr Filter"; Text[100])
        {
            Caption = 'Customer Sell in Actuals Month 3YR Account Group Filter';
            Description = 'HEI.02';
        }
        field(121; "Cust.SellActW3 Acc Gr Filter"; Text[100])
        {
            Caption = 'Customer Sell in Actuals Week 3YR Account Group Filter';
            Description = 'HEI.02';
        }
        field(122; "Cust.SOO Acc Group Filter"; Text[100])
        {
            Caption = 'Customer Supply Open Orders Account Group Filter';
            Description = 'HEI.02';
        }
        field(123; "Supply Pl OO Item Categ Filter"; Text[100])
        {
            Caption = 'Supply Planning Open Orders Item Category  Filter';
            Description = 'HEI.02';
        }
        field(124; "Supply Pl OO  Doc Types Filter"; Text[100])
        {
            Caption = 'Supply Planning Open Orders Doc Types Filter';
            Description = 'HEI.02';
        }
        field(125; "StockOnHand ItemAttrValFilter1"; Text[100])
        {
            Caption = 'Item Attribute Value Filter 1';
        }
        field(126; "StockOnHand Item Attr Filter1"; Integer)
        {
            Caption = 'Item Attribute Code Filter 1';
            TableRelation = "Item Attribute";

            trigger OnValidate();
            begin
                if Rec."StockOnHand Item Attr Filter1" <> xRec."StockOnHand Item Attr Filter1" then
                    "StockOnHand ItemAttrValFilter1" := '';
            end;
        }
        field(127; "StockOnHand Item Categ Filter1"; Code[20])
        {
            Caption = 'Item Category Code Filter 1';
            TableRelation = "Item Category";
        }
        field(128; "StockOnHand CMG Filter"; Text[250])
        {
            Caption = 'Stock on Hand CMG Filter';
        }
        field(129; "StockOnHand Location Filter"; Text[100])
        {
            Caption = 'Stock On Hand Location Code Filter';
        }
        field(130; "StockOnHand Current Week"; Boolean)
        {
            Caption = 'Stock on Hand Current Week';
        }
        field(131; "StockOnHand ItemAttrValFilter2"; Text[100])
        {
            Caption = 'Item Attribute Value Filter2';
        }
        field(132; "StockOnHand Item Attr Filter2"; Integer)
        {
            Caption = 'Item Attribute Code 2';
            TableRelation = "Item Attribute";

            trigger OnValidate();
            begin
                if Rec."StockOnHand Item Attr Filter1" <> xRec."StockOnHand Item Attr Filter1" then
                    "StockOnHand ItemAttrValFilter1" := '';
            end;
        }
        field(133; "StockOnHand Item Categ Filter2"; Code[20])
        {
            Caption = 'Item Category Code Filter 2';
            TableRelation = "Item Category";
        }
        field(134; "StockOnHand ItemAttrValFilter3"; Text[100])
        {
            Caption = 'Item Attribute Value Filter3';
        }
        field(135; "StockOnHand Item Attr Filter3"; Integer)
        {
            Caption = 'Item Attribute Code 3';
            TableRelation = "Item Attribute";

            trigger OnValidate();
            begin
                if Rec."StockOnHand Item Attr Filter1" <> xRec."StockOnHand Item Attr Filter1" then
                    "StockOnHand ItemAttrValFilter1" := '';
            end;
        }
        field(136; "StockOnHand Item Categ Filter3"; Code[20])
        {
            Caption = 'Item Category Code Filter 3';
            TableRelation = "Item Category";
        }
        field(137; "Comp Product Category Filter"; Text[100])
        {
            Caption = 'Component Product Category Filter';
            Description = 'HEI.02';
        }
        field(138; "Finish UOM Prod Categ Filter"; Text[100])
        {
            Caption = 'Finished Products UOM Item Categ Filter';
            Description = 'HEI.02';
        }
        field(139; "Finish UOM Prod Def UOM"; Code[10])
        {
            Caption = 'Finished Products Default UOM Filter';
            Description = 'HEI.02';
            TableRelation = "Unit of Measure";
        }
        field(140; "Finish UOM Prod Alt1 UOM"; Code[10])
        {
            Caption = 'Finished Products Alternative 1 UOM Filter';
            Description = 'HEI.02';
            TableRelation = "Unit of Measure";
        }
        field(141; "Finish UOM Prod Alt2 UOM"; Code[10])
        {
            Caption = 'Finished Products Alternative 2 UOM Filter';
            Description = 'HEI.02';
            TableRelation = "Unit of Measure";
        }
        field(142; "Cust. Master Active Filter"; Option)
        {
            Caption = 'Customer Master Active Filter';
            Description = 'HEI.03';
            OptionMembers = " ",Active,Inactive;
        }
        field(200; "Sell Act Mth 3YR Start Date"; Date)
        {
            Caption = 'Sell in Actuals Month 3YR Start Date';
            Description = 'HEI.02';
        }
        field(201; "Sell Act Mth 3YR End  Date"; Date)
        {
            Caption = 'Sell in Actuals Month 3YR End Date';
            Description = 'HEI.02';
        }
        field(202; "Sell Act Wk 3YR Start Date"; Date)
        {
            Caption = 'Sell in Actuals Week 3YR Start Date';
            Description = 'HEI.02';
        }
        field(203; "Sell Act Wk 3YR End  Date"; Date)
        {
            Caption = 'Sell in Actuals Week 3YR End Date';
            Description = 'HEI.02';
        }
        field(204; "Sell Act MTH Ref Date"; Date)
        {
            Caption = 'Selll in Actuals Month Reference Date';
            Description = 'HEI.02';
        }
        field(205; "Sell Act WK Ref Date"; Date)
        {
            Caption = 'Selll in Actuals Week Reference Date';
            Description = 'HEI.02';
        }
        field(206; "Cust. Contract Type Excl Filte"; Option)
        {
            Caption = 'Cust. Contract Type Excl Filter';
            Description = 'HEI.04, HEI.05';
            InitValue = "Not applicable";
            OptionCaption = ' ,CTS Only,Full Contract,Not applicable';
            OptionMembers = " ","CTS Only","Full Contract","Not applicable";
        }
        field(207; "Sell Act Wk Prev Weeks"; Integer)
        {
            Caption = 'Previous Weeks Selection';
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
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

