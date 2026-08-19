table 58023 "FuturMaster Interf Setup_2 INT"
{
    // Heilite Navision Old Id - 50111
    // version FM,HEI.16

    // HEI.01 S&OP FuturMaster Interfaces IBM LAZARE01
    //   # created object
    // 
    // HEI.03 S&OP FuturMaster Interfaces IBM POSTOI01 14.11.2018
    //   # create 3 new fields 11, 103, 104
    // HEI.04 S&OP FuturMaster Interfaces IBM POSTOI01 14.11.2018
    //   # create 8 new fields 12, 105, 106, 107, 108, 301, 302, 305
    //   # write comment HEI.03
    // HEI.05 S&OP FuturMaster Interfaces IBM POSTOI01 22.01.2019
    //   # create 5 new fields 13, 109, 110, 111, 112
    // HEI.06 S&OP FuturMaster Interfaces IBM POSTOI01 23.01.2019
    //   # create 2 new fields 113, 114
    // HEI.07 S&OP FuturMaster Interfaces IBM POSTOI01 25.01.2019
    //   # create 3 new fields 14, 115, 116
    // HEI.08 S&OP FuturMaster Interfaces IBM POSTOI01 31.01.2019
    //   # create 4 new fields 15, 117, 118, 119
    // HEI.09 S&OP FuturMaster Interfaces IBM POSTOI01 04.02.2019
    //   # create 4 new fields 16, 17, 120, 121
    // HEI.10 S&OP FuturMaster Interfaces IBM POSTOI01 05.02.2019
    //   # create 5 new fields 18, 122, 123, 124, 125, 126
    // HEI.11 S&OP FuturMaster Interfaces IBM POSTOI01 10.02.2019
    //   # create 15 new fields 19, 127->140
    // HEI.12 S&OP FuturMaster Interfaces IBM POSTOI01 15.02.2019
    //   # change Name, Caption property for field 16 : Purch. Requisitions Interface
    //   # change Name, Caption property for field 17 : Production Orders Interface
    // HEI.13 CHG2139842 IBM.AK 23.02.22  [New FM Outbound Interface-Stock Transfer Order Virtual Warehouse]
    // # Created new Fields 306 (Stock TransOrd Virtual  Interf), 307(StockTOVirtual Category Filter) & 308(StockTOVirtual Location Filter)
    // HEI.14 CHG2150741 IBM GOKULS01 26/07/2022 # BOM Version interface
    //   # New feilds are updated for schema changes
    // HEI.15 CHG2161264 DEBUSD01 10.11.2022 Shipment KPI Interface
    //   # add fields "Shipment Order & STO Interface"
    // HEI.16 CHG2174570 COSTES04 06.12.2022 New Interface Demand Planning for Returns
    //   # add new fields 21,22,23,24
    //   # add new fields 310 -> 325
    // BC Upgrade SHUKLP03 >> Document subtype table relation added.

    Caption = 'FuturMaster Interface Setup 2';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(10; "Standard Cost Interface"; Code[20])
        {
            Caption = 'Standard Cost Interface';
            TableRelation = "Interface Setup INT";
        }
        field(11; "Semi Finished Prod Interface"; Code[20])
        {
            Caption = 'Semi Finished Product Master Interface';
            Description = 'HEI.03';
            TableRelation = "Interface Setup INT";
        }
        field(12; "Open Purch Orders Interface"; Code[20])
        {
            Caption = 'Supply Open Purchase Orders';
            Description = 'HEI.04';
            TableRelation = "Interface Setup INT";
        }
        field(13; "Proc And Firm Pl Orders Interf"; Code[20])
        {
            Caption = 'Processed And Firm Planned Orders Interface';
            Description = 'HEI.05';
            TableRelation = "Interface Setup INT";
        }
        field(14; "Stock Transport Orders Interf"; Code[20])
        {
            Caption = 'Stock Transport Order Related Receipts Interface';
            Description = 'HEI.07';
            TableRelation = "Interface Setup INT";
        }
        field(15; "Actual Production Interf"; Code[20])
        {
            Caption = 'Actual Production Interface';
            Description = 'HEI.08';
            TableRelation = "Interface Setup INT";
        }
        field(16; "Purch. Requisitions Interface"; Code[20])
        {
            Caption = 'Purch. Requisitions Interface';
            Description = 'HEI.09';
            TableRelation = "Interface Setup INT";
        }
        field(17; "Production Orders Interface"; Code[20])
        {
            Caption = 'Production Orders Interface';
            Description = 'HEI.09';
            TableRelation = "Interface Setup INT";
        }
        field(18; "PurchMasterData Interf"; Code[20])
        {
            Caption = '"Purchasing Master Data Interface "';
            Description = 'HEI.10';
            TableRelation = "Interface Setup INT";
        }
        field(19; "BOMMasterData Interf"; Code[20])
        {
            Caption = '"BOM Master Data Interface "';
            Description = 'HEI.11';
            TableRelation = "Interface Setup INT";
        }
        field(20; "Shipment KPI Interface"; Code[20])
        {
            Caption = 'Shipment KPI Interface';
            Description = 'HEI.15';
            TableRelation = "Interface Setup INT";
        }
        field(21; "Return Act Month Interface"; Code[20])
        {
            Caption = 'Returns Act Month Interface';
            DataClassification = CustomerContent;
            Description = 'HEI.16';
            TableRelation = "Interface Setup INT";
        }
        field(22; "Return Act Week Interface"; Code[20])
        {
            Caption = 'Returns Act Week Interface';
            DataClassification = CustomerContent;
            Description = 'HEI.16';
            TableRelation = "Interface Setup INT";
        }
        field(23; "Return Act Week 3YR Interface"; Code[20])
        {
            Caption = 'Returns Act Week 3YR Interface';
            DataClassification = CustomerContent;
            Description = 'HEI.16';
            TableRelation = "Interface Setup INT";
        }
        field(24; "Return Act Month 3YR Interface"; Code[20])
        {
            Caption = 'Returns Act Month 3YR Interface';
            DataClassification = CustomerContent;
            Description = 'HEI.16';
            TableRelation = "Interface Setup INT";
        }
        field(100; "Std Cost Category Filter"; Text[100])
        {
            Caption = 'Standard Cost Item Category Filter';
            Description = 'HEI.02';
        }
        field(101; "Std Cost Location Filter"; Text[100])
        {
            Caption = 'Standard Cost Location Filter';
        }
        field(102; "SemiFinish Category Filter"; Text[100])
        {
            Caption = 'Semi Finished Prod Item Category Filter';
            Description = 'HEI.03';
        }
        field(103; "SemiFinish Location Filter"; Text[100])
        {
            Caption = 'Semi Finished Prod Location Filter';
            Description = 'HEI.03';
        }
        field(104; "SemiFinish Def UOM"; Code[10])
        {
            Caption = 'Semi Finished Default Unit of Measure';
            Description = 'HEI.03';
        }
        field(105; "OpenPurchOrd Category Filter"; Text[100])
        {
            Caption = 'Open Purchase Orders Item Category Filter';
            Description = 'HEI.04';
        }
        field(106; "OpenPurchOrd Location Filter"; Text[100])
        {
            Caption = 'Open Purchase Orders Location Filter';
            Description = 'HEI.04';
        }
        field(107; "OpenPurchOrd Doc Types Filter"; Text[100])
        {
            Caption = 'Open Purchase Orders Document Type Filter';
            Description = 'HEI.04';
        }
        field(108; "OpenPurchOrd Age Days Filter"; Integer)
        {
            Description = 'HEI.04';
        }
        field(109; "ProcFirmOrd Location Filter"; Text[50])
        {
            Caption = 'Processed And Firm Planned Orders Location Filter';
            Description = 'HEI.05';
        }
        field(110; "ProcFirmOrd Zone Filter"; Text[50])
        {
            Caption = 'Processed And Firm Planned Orders Zone Filter';
            Description = 'HEI.05';
        }
        field(111; "ProcFirmOrd Status Filter"; Text[50])
        {
            Caption = 'Processed And Firm Planned Orders Status Filter';
            Description = 'HEI.05';
        }
        field(112; "OpenPurchOrd Status Filter"; Text[50])
        {
            Caption = 'Open Purchase Orders Status Filter';
            Description = 'HEI.05';
        }
        field(113; "SemiFinishCrossPlMatSt  Filter"; Boolean)
        {
            Caption = 'Semi Finished Cross Plant Material Status Filter';
            Description = 'HEI.06';
        }
        field(114; "SemiFinishPlSpMatStt  Filter"; Boolean)
        {
            Caption = 'Semi Finished Plant-Specific Material Status';
            Description = 'HEI.06';
        }
        field(115; "StockTransOrd Category Filter"; Text[50])
        {
            Caption = 'Stock Transport Order Item Category Filter';
            Description = 'HEI.07';
        }
        field(116; "StockTransOrd Location Filter"; Text[50])
        {
            Caption = 'Stock Transport Orders Location Filter';
            Description = 'HEI.07';
        }
        field(117; "ActualProd Location Filter"; Text[50])
        {
            Caption = 'Actual Production Location Filter';
            Description = 'HEI.08';
        }
        field(118; "ActualProd Zone Filter"; Text[50])
        {
            Caption = 'Actual Production Zone Filter';
            Description = 'HEI.08';
        }
        field(119; "ActualProd Status Filter"; Text[50])
        {
            Caption = 'Actual Production Order Status Filter';
            Description = 'HEI.08';
        }
        field(120; "PurchOrds WksTempName"; Code[10])
        {
            Caption = 'Purchase Orders WorkSheets Template Name';
            Description = 'HEI.09';
            TableRelation = "Req. Wksh. Template";
        }
        field(121; PurchOrdsJournBatchName; Code[10])
        {
            Caption = 'Purchase Orders Journal Batch Name';
            Description = 'HEI.09';
        }
        field(122; "PurchMasterData DocType Filter"; Text[50])
        {
            Caption = 'Purchasing Master Data Document Type Filter';
            Description = 'HEI.10';
        }
        field(123; "PurchMasterDataCrossPlant Filt"; Text[50])
        {
            Caption = 'Purchasing Master Data Cross Plant Material Status Filter';
            Description = 'HEI.10';
        }
        field(124; "PurchMasterDataPlantSp Fiilter"; Text[50])
        {
            Caption = 'Purchasing Master Data Plant Specific Material Status Filter';
            Description = 'HEI.10';
        }
        field(125; PurchMasterDataContrTypeFilter; Text[50])
        {
            Caption = 'Purchasing Master Data Contract Type Filter';
            Description = 'HEI.10';
        }
        field(126; "PurchMasterDataLocCode Filter"; Text[50])
        {
            Caption = '"Purchasing Master Data Location Filter "';
            Description = 'HEI.10';
        }
        field(127; "BOM ItemAttrValFilter1"; Text[50])
        {
            Caption = 'Item Attribute Value Filter 1';
            Description = 'HEI.11';
        }
        field(128; "BOM Item Attr Filter1"; Integer)
        {
            Caption = 'Item Attribute Code Filter 1';
            Description = 'HEI.11';
            TableRelation = "Item Attribute";

            trigger OnValidate();
            begin
                if Rec."BOM Item Attr Filter1" <> xRec."BOM Item Attr Filter1" then
                    "BOM ItemAttrValFilter1" := '';
            end;
        }
        field(129; "BOM Item Categ Filter1"; Code[20])
        {
            Caption = 'Item Category Code Filter 1';
            Description = 'HEI.11';
            TableRelation = "Item Category";
        }
        field(130; "BOM CMG Filter"; Text[50])
        {
            Caption = 'Stock on Hand CMG Filter';
            Description = 'HEI.11';
        }
        field(131; "BOM Location Filter"; Text[50])
        {
            Caption = 'Stock On Hand Location Code Filter';
            Description = 'HEI.11';
        }
        field(132; "BOM ItemAttrValFilter2"; Text[50])
        {
            Caption = 'Item Attribute Value Filter2';
            Description = 'HEI.11';
        }
        field(133; "BOM Item Attr Filter2"; Integer)
        {
            Caption = 'Item Attribute Code 2';
            Description = 'HEI.11';
            TableRelation = "Item Attribute";

            trigger OnValidate();
            begin
                if Rec."BOM Item Attr Filter1" <> xRec."BOM Item Attr Filter1" then
                    "BOM ItemAttrValFilter1" := '';
            end;
        }
        field(134; "BOM Item Categ Filter2"; Code[20])
        {
            Caption = 'Item Category Code Filter 2';
            Description = 'HEI.11';
            TableRelation = "Item Category";
        }
        field(135; "BOM ItemAttrValFilter3"; Text[50])
        {
            Caption = 'Item Attribute Value Filter3';
            Description = 'HEI.11';
        }
        field(136; "BOM Item Attr Filter3"; Integer)
        {
            Caption = 'Item Attribute Code 3';
            Description = 'HEI.11';
            TableRelation = "Item Attribute";

            trigger OnValidate();
            begin
                if Rec."BOM Item Attr Filter1" <> xRec."BOM Item Attr Filter1" then
                    "BOM ItemAttrValFilter1" := '';
            end;
        }
        field(137; "BOM Item Categ Filter3"; Code[20])
        {
            Caption = 'Item Category Code Filter 3';
            Description = 'HEI.11';
            TableRelation = "Item Category";
        }
        field(138; "BOM Status Flter"; Text[50])
        {
            Caption = 'Production BOM Status Filter';
            Description = 'HEI.11';
        }
        field(139; "BOM Vers St Filter"; Text[50])
        {
            Caption = 'Production BOM Version Status Filter';
            Description = 'HEI.11';
        }
        field(140; "BOM Ref UM"; Text[20])
        {
            Caption = 'BOM Reference Unit of Measure';
            Description = 'HEI.11';
        }
        field(141; "ProdOrds WksTempName"; Code[10])
        {
            Caption = 'Production Orders Journal Template Name';
            Description = 'HEI.13';
            TableRelation = "Req. Wksh. Template";
        }
        field(142; ProdOrdsJournBatchName; Code[10])
        {
            Caption = 'Production Orders Journal Batch Name';
            Description = 'HEI.13';
        }
        field(150; "Shpt. Location Filter"; Code[100])
        {
            Caption = 'Location Filter';
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
            TableRelation = Location;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(151; "Shpt. Item Category Filter"; Code[50])
        {
            Caption = 'Item Category Filter';
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
            TableRelation = "Item Category";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(152; "Shpt. Doc. Sub Type Filter"; Code[100])
        {
            Caption = 'Document Sub. Type Filter';
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales | "Fin.Contract"));  // BC Upgrade SHUKLP03
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(153; "Shpt. Prev. Weeks"; Integer)
        {
            Caption = 'Transfer Previous Weeks';
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
            InitValue = 8;
            MinValue = 0;
        }
        field(160; "ShpTrsf. Location Filter"; Code[100])
        {
            Caption = 'Transfer Location Filter';
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
            TableRelation = Location;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(161; "ShpTrsf. Item Category Filter"; Code[50])
        {
            Caption = 'Transfer Item Category Filter';
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
            TableRelation = "Item Category";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(162; "ShptTrsf. Doc. Sub Type Filter"; Code[100])
        {
            Caption = 'Document Sub. Type Filter';
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = CONST(Inventory));  // BC Upgrade SHUKLP03
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(163; "ShptTrsf. Prev. Weeks"; Integer)
        {
            Caption = 'Transfer Previous Weeks';
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
            InitValue = 8;
            MinValue = 0;
        }
        field(301; "Notify User ID 1"; Code[50])
        {
            Caption = 'Notify User ID 1';
            Description = 'HEI.04';
            TableRelation = "User Setup";
        }
        field(302; "Notify User ID 2"; Code[50])
        {
            Caption = 'Notify User ID 2';
            Description = 'HEI.04';
            TableRelation = "User Setup";
        }
        field(305; "Interface Web Service User ID"; Code[50])
        {
            Caption = 'Interface Job Queue User ID';
            Description = 'HEI.04';
            TableRelation = "User Setup";
        }
        field(306; "Stock TransOrd Virtual  Interf"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(307; "StockTOVirtual Category Filter"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(308; "StockTOVirtual Location Filter"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(309; "Prod. BOM Version Interface"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.14';
            TableRelation = "Interface Setup INT";
        }
        field(310; "Ret. Act Week Doc Type Filter"; Text[50])
        {
            Caption = 'Returns Actuals Week Document Types Filter';
            Description = 'HEI.16';
        }
        field(311; "Ret. Act Month Doc Type Filter"; Text[50])
        {
            Caption = 'Returns Actuals Month 3YR Document Types Filter';
            Description = 'HEI.16';
        }
        field(312; "Ret. Act WK3YR Doc Type Filter"; Text[50])
        {
            Caption = 'Returns Actuals Week 3YR Document Types Filter';
            Description = 'HEI.16';
        }
        field(313; "Ret. Act MTH3YR Doc Typ Filter"; Text[50])
        {
            Caption = 'Returns Actuals Week 3YR Document Types Filter';
            Description = 'HEI.16';
        }
        field(314; "Ret. Act Week Acc. Gr. Filter"; Text[50])
        {
            Caption = 'Returns Actuals Week Cust. Account Gr. Filter';
            Description = 'HEI.16';
        }
        field(315; "Ret. Act Month Acc. Gr. Filter"; Text[50])
        {
            Caption = 'Returns Actuals Month 3YR Cust. Account Gr. Filter';
            Description = 'HEI.16';
        }
        field(316; "Ret. Act WK3YR Acc. Gr. Filter"; Text[50])
        {
            Caption = 'Returns Actuals Week 3YR Cust. Account Gr. Filter';
            Description = 'HEI.16';
        }
        field(317; "Ret. Act MTH3YR Acc. Gr Filter"; Text[50])
        {
            Caption = 'Returns Actuals Week 3YR Cust. Account Gr. Filter';
            Description = 'HEI.16';
        }
        field(318; "Ret. Act Week Item Cat. Filter"; Text[50])
        {
            Caption = 'Returns Actuals Week Item Category Filter';
            Description = 'HEI.16';
        }
        field(319; "Ret. Act Month Item Cat Filter"; Text[50])
        {
            Caption = 'Returns Actuals Month 3YR Item Category Filter';
            Description = 'HEI.16';
        }
        field(320; "Ret. Act WK3YR Item Cat Filter"; Text[50])
        {
            Caption = 'Returns Actuals Week 3YR Item Category Filter';
            Description = 'HEI.16';
        }
        field(321; "Ret. Act MTH3YR Item Ca Filter"; Text[50])
        {
            Caption = 'Returns Actuals Week 3YR Item Category Filter';
            Description = 'HEI.16';
        }
        field(322; "Ret. Act Week Location Filter"; Text[50])
        {
            Caption = 'Returns Actuals Week Location Filter';
            Description = 'HEI.16';
        }
        field(323; "Ret. Act Month Location Filter"; Text[50])
        {
            Caption = 'Returns Actuals Month 3YR Location Filter';
            Description = 'HEI.16';
        }
        field(324; "Ret. Act WK3YR Location Filter"; Text[50])
        {
            Caption = 'Returns Actuals Week 3YR Location Filter';
            Description = 'HEI.16';
        }
        field(325; "Ret. Act MTH3YR Loc. Filter"; Text[50])
        {
            Caption = 'Returns Actuals Week 3YR Location Filter';
            Description = 'HEI.16';
        }
        field(326; "Ret. Act Week Reference Date"; Date)
        {
            Caption = 'Returns Actuals Week Reference Date';
            Description = 'HEI.16';
        }
        field(327; "Ret. Act Month Reference Date"; Date)
        {
            Caption = 'Returns Actuals Month Reference Date';
            Description = 'HEI.16';
        }
        field(328; "Ret. Act WK3YR Start Date"; Date)
        {
            Caption = 'Returns Actuals Week 3YR Start Date';
            Description = 'HEI.16';
        }
        field(329; "Ret. Act MTH3YR Start Date"; Date)
        {
            Caption = 'Returns Actuals Week 3YR Start Date';
            Description = 'HEI.16';
        }
        field(330; "Ret. Act Week Previous Weeks"; Integer)
        {
            Caption = 'Returns Actuals Week End Date';
            Description = 'HEI.16';
        }
        field(331; "Ret. Act WK3YR End Date"; Date)
        {
            Caption = 'Returns Actuals Week 3YR End Date';
            Description = 'HEI.16';
        }
        field(332; "Ret. Act MTH3YR End Date"; Date)
        {
            Caption = 'Returns Actuals Week 3YR End Date';
            Description = 'HEI.16';
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

