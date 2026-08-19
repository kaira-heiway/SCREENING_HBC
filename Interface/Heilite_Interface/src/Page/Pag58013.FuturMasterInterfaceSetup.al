page 58013 "FuturMaster Interface Setup"
{
    // Heilite Navision Old Id - 50214

    // version HEI.34

    // HEI.01 S&OP FuturMaster Interfaces IBM LAZARE01
    //   # created object
    // HEI.02 S&OP FuturMaster Interfaces IBM POSTOI01 14.11.2018
    //   # show 8 new fields 12,13,14,101,102,103,104-121, 200->205
    // HEI.03 S&OP FuturMaster Interfaces IBM POSTOI01 15.01.2019
    //   # new group Semi Finished Prod Filters
    //   # new field in group Interfaces: SemiFinished Products Interface
    // HEI.04 S&OP FuturMaster Interfaces IBM POSTOI01 17.01.2019
    //   # new group Open Purchase Orders Filters
    //   # new group Notification
    //   # new field in group Interfaces: InterfSetup2."Open Purch Orders Interface"
    //   # add comment HEI.03 in the Documentation
    // HEI.05 S&OP FuturMaster Interfaces IBM POSTOI01 22.01.2019
    //   # new group Processed and Firm Planned Orders Filters
    //   # new field in group Interfaces: InterfSetup2."Proc And Firm Pl Orders Interf"
    //   # new field in group Open Purchase Orders Filters : InterfSetup2."OpenPurchOrd Status Filter"
    // HEI.06 S&OP FuturMaster Interfaces IBM POSTOI01 23.01.2019
    //   # add 2 fields to group Semi Finished Prod Filters: 113 Cross Plant Material Status, 114 Plant-Specific Material Status
    // HEI.07 S&OP FuturMaster Interfaces IBM POSTOI01 25.01.2019
    //   # new group Stock Transport Orders Filters with 2 fields : Location Filter and Item Category Filter
    //   # new field 14 in group Interfaces  : Stock Transport Order Realated Receipts
    // HEI.08 S&OP FuturMaster Interfaces IBM POSTOI01 31.01.2019
    //   # new group Actual Production Filters with 3 fields : Location Filter and Zone Filter and Status Filter
    //   # new field 15 in group Interfaces  : Actual Production Interface
    // HEI.09 S&OP FuturMaster Interfaces IBM POSTOI01 04.02.2019
    //   # new group Production Requisition Filters with 2 fields : Worksheet Template Name and Journal Batch Name
    //   # new fields 16, 17 in group Interfaces  :Purchase Requisition Interface, Purchase Requisition Confirmation Interface
    // HEI.10 S&OP FuturMaster Interfaces IBM POSTOI01 05.02.2019
    //   # new group Purchasing Master Data with 5 fields
    //   # new fields 18 in group Interfaces  :Purchasing Master Data Interface
    // HEI.11 S&OP FuturMaster Interfaces IBM POSTOI01 10.02.2019
    //   # new group BOM Master Data Filters with 14 fields
    //   # new fields 19 in group Interfaces  :BOM Master Data Interface
    // HEI.12 S&OP FuturMaster Interfaces IBM POSTOI01 26.02.2019
    //   # show field 142 "Cust Master Active Filter" in group DP Customers Master Filters
    // HEI.13 S&OP FuturMaster Interfaces IBM POSTOI01 26.02.2019
    //   # new group SP Production Orders with 2 fields
    //       InterfSetup2."ProdOrds WksTempName"
    //       InterfSetup2.ProdOrdsJournBatchName
    // HEI.14 S&OP FuturMaster Interfaces IBM POSTOI01 20.05.2019
    //   # change caption for field "Supply Plann Open Order Interf" from SP Open Orders Interface->SP Open Sales Orders Interface
    //   # change the group caption from SP Open Orders Filters->SP Open Sales Orders Filters
    // HEI.17 CHG2042680 IBM TUDOSG01 04.02.2019 # New field "Cust. Contract Type Excl Filte"
    // HEI.18 CHG2139842 IBM.AK 24.02.22  [New FM Outbound Interface-Stock Transfer Order Virtual Warehouse]
    // # Added Field Stock TransOrd Virtual  Interf in the Group-Interfaces
    // # Added new Group-SP Stock Transport Order Virtual Related Receipts Filters with Fields (StockTOVirtual Category Filter, StockTOVirtual Location Filter)
    // HEI.19 CHG2147112-HB2791 IBM BHANDS01 04.03.2022 Update in logic for FuturMaster DP Sell In Actuals Week
    //   # added new field "Sell Act Wk Prev Weeks"
    // HEI.20 CHG2153383 HB2883 IBM NANDIS01 06.06.2022 - FuturMaster update of Expected Receipt Date
    //   # Caption changed from "Age of Planned Receipt in Days" to "Age of Expected Receipt in Days" in tab - SP Open Purchase Orders Filters
    // HEI.21 CHG2150741 IBM GOKULS01 26/07/2022 # BOM Version interface
    //   # New feilds are updated for schema changes
    // HEI.22 CHG2161264 DEBUSD01 10.11.2022 Shipment KPI Interface
    //   # add field "Shipment Order & STO Interface"
    // HEI.23 CHG2174570 COSTES04 06.12.2022 New Interface Demand Planning for Returns
    //   # add new fields "Return Act Month Interface", "Return Act Week Interface","Return Act Week 3YR Interface","Return Act Month 3YR Interface"
    //   # add new fast tabs "DP Returns Actuals Month Filters","DP Returns Actuals Week Filters","DP Returns Actuals Month 3YR Filters","DP Returns Actuals Week 3YR Filters"
    // HEI.24 CHG2179087 COSTES04 12.12.2022 Demand planning Sell in Actuals Month/Week - VAN
    //   # add new fields "Sell Act M. Incl. Return Rcpt.","Sell Act M. Acc Group Filter 2","Sell Act M. Item Cat  Filter 2","Sell Act M. Location Filter 2","Sell Act M. Reference Date 2"
    //   # add new fields "Sell Act W. Incl. Return Rcpt.","Sell Act W. Acc Group Filter 2","Sell Act W. Item Cat  Filter 2","Sell Act W. Location Filter 2","Sell Act W. Reference Date 2"
    //   # add new fields "Sell Act M3YR Incl. Return Rcpt.","Sell Act M3YR Acc Group Filter 2","Sell Act M3YR Item Cat  Filter 2","Sell Act M3YR Location Filter 2","Sell Act M3YR Reference Date 2"
    //   # add new fields "Sell Act W3YR Incl. Return Rcpt.","Sell Act W3YR Acc Group Filter 2","Sell Act W3YR Item Cat  Filter 2","Sell Act W3YR Location Filter 2","Sell Act W3YR Reference Date 2"
    // HEI.25 CHG2195346 PATHAA02 19.04.2023 BOM interface Enhancement
    //   # Added new Group for BOM Master Filters with 2 new Fields -"Exclude BOMComp.ItemCat Filtr1" & "Exclude BOMComp.ItemCat Filtr2"
    // HEI.26 CHG2201050 17.07.2023 Standard cost Interface Chg-ETH
    //  # Added a new Field 125-"Convert Cost PC to HL"
    // HEI.28 CHG2226024 PATHAA02 28.10.23  #Bug Fix-Stock Transport Orders Interface
    //   # New Field 129-StockTransOrd Virtual Location added
    // HEI.30 CHG2232149 PATHAA02 18.12.23  #BOM Interface logic to be modified.
    //   # New Field-Semi Finished Goods WorkCenter added
    // HEI.32 CHG2226940 HB3632 IBM SRIVAS07 19.02.2024 # Development- Ice Cube to be removed from Item Category Code 01 (S&OP Fit Project)
    //   # Added new field CMG Filter
    // HEI.33 CHG2254591 IBM COSTES04 09.07.2024 adjust the caption of FM 3Y Returns W/M
    //   # Change caption for "Return Act Week 3YR Interface", "Return Act Month 3YR Interface"
    // HEI.34 CHG2285048 HB4203 IBM PATHAA02 14.02.2025 # Dev-Standard cost FM interface to take the Unit cost value
    //   # Added new field - "Inventory Posting Group"(Finished Imported Goods) under Standard Cost Filters FastTab

    // BC Upgrade SHUKLP03 >> "Document Subtype Code" code added

    Caption = 'FuturMaster Interface Setup';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "FuturMaster Interf. Setup INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            group(Interfaces)
            {
                Caption = 'Interfaces';
                field("Product Master Interface"; Rec."Product Master Interface")
                {
                    Caption = 'DP Products Master Data Interface';
                    ToolTip = 'Specifies the value of the DP Products Master Data Interface field.';
                }
                field("Customer Master Interface"; Rec."Customer Master Interface")
                {
                    Caption = 'DP Customers Master Data Interface';
                    ToolTip = 'Specifies the value of the DP Customers Master Data Interface field.';
                }
                field("Demand Plann Open Order Interf"; Rec."Demand Plann Open Order Interf")
                {
                    Caption = 'DP Open Orders Interface';
                    ToolTip = 'Specifies the value of the DP Open Orders Interface field.';
                }
                field("Sell Act Month Interface"; Rec."Sell Act Month Interface")
                {
                    Caption = 'DP Sell in Actuals Month Interface';
                    ToolTip = 'Specifies the value of the DP Sell in Actuals Month Interface field.';
                }
                field("Sell Act Week Interface"; Rec."Sell Act Week Interface")
                {
                    Caption = 'DP Sell in Actuals Week Interface';
                    ToolTip = 'Specifies the value of the DP Sell in Actuals Week Interface field.';
                }
                field("Sell Act Month 3YR Interface"; Rec."Sell Act Month 3YR Interface")
                {
                    Caption = 'DP Sell in Actuals Month 3YR Interface';
                    ToolTip = 'Specifies the value of the DP Sell in Actuals Month 3YR Interface field.';
                }
                field("Sell Act Week 3YR Interface"; Rec."Sell Act Week 3YR Interface")
                {
                    Caption = 'DP Sell in Actuals Week 3YR Interface';
                    ToolTip = 'Specifies the value of the DP Sell in Actuals Week 3YR Interface field.';
                }
                field("InterfSetup2.""Return Act Month Interface"""; InterfSetup2."Return Act Month Interface")
                {
                    Caption = 'DP Returns Actuals Month Interface';
                    TableRelation = "Interface Setup INT".Code;
                    ToolTip = 'Specifies the value of the DP Returns Actuals Month Interface field.';
                }
                field("InterfSetup2.""Return Act Week Interface"""; InterfSetup2."Return Act Week Interface")
                {
                    Caption = 'DP Returns Actuals Week Interface';
                    TableRelation = "Interface Setup INT".Code;
                    ToolTip = 'Specifies the value of the DP Returns Actuals Week Interface field.';
                }
                field("InterfSetup2.""Return Act Week 3YR Interface"""; InterfSetup2."Return Act Week 3YR Interface")
                {
                    Caption = 'DP Returns Actuals Week 3YR Interface';
                    TableRelation = "Interface Setup INT".Code;
                    ToolTip = 'Specifies the value of the DP Returns Actuals Week 3YR Interface field.';
                }
                field("InterfSetup2.""Return Act Month 3YR Interface"""; InterfSetup2."Return Act Month 3YR Interface")
                {
                    Caption = 'DP Returns Actuals Month 3YR Interface';
                    TableRelation = "Interface Setup INT".Code;
                    ToolTip = 'Specifies the value of the DP Returns Actuals Month 3YR Interface field.';
                }
                field("InterfSetup2.""Shipment KPI Interface"""; InterfSetup2."Shipment KPI Interface")
                {
                    Caption = 'DP Shipments Week KPI Interface';
                    TableRelation = "Interface Setup INT";
                    ToolTip = 'Specifies the value of the DP Shipments Week KPI Interface field.';
                }
                field("Supply Plann Open Order Interf"; Rec."Supply Plann Open Order Interf")
                {
                    Caption = 'SP Open Sales Orders Interface';
                    ToolTip = 'Specifies the value of the SP Open Sales Orders Interface field.';
                }
                field("Stock on Hand Interface"; Rec."Stock on Hand Interface")
                {
                    Caption = 'SP Stock on Hand Interface';
                    ToolTip = 'Specifies the value of the SP Stock on Hand Interface field.';
                }
                field("Component Product Interface"; Rec."Component Product Interface")
                {
                    Caption = 'SP Component Products Master Data Interface';
                    ToolTip = 'Specifies the value of the SP Component Products Master Data Interface field.';
                }
                field("Finished Product UOM Interface"; Rec."Finished Product UOM Interface")
                {
                    Caption = 'SP Finished Products UOM Interface';
                    ToolTip = 'Specifies the value of the SP Finished Products UOM Interface field.';
                }
                field("InterfSetup2.""Standard Cost Interface"""; InterfSetup2."Standard Cost Interface")
                {
                    Caption = 'SP Standard Costs Interface';
                    TableRelation = "Interface Setup INT".Code;
                    ToolTip = 'Specifies the value of the SP Standard Costs Interface field.';
                }
                field("InterfSetup2.""Semi Finished Prod Interface"""; InterfSetup2."Semi Finished Prod Interface")
                {
                    Caption = 'SP Semi Finished Products Master Interface';
                    TableRelation = "Interface Setup INT".Code;
                    ToolTip = 'Specifies the value of the SP Semi Finished Products Master Interface field.';
                }
                field("InterfSetup2.""Open Purch Orders Interface"""; InterfSetup2."Open Purch Orders Interface")
                {
                    Caption = 'SP Open Purchase Orders Interface';
                    TableRelation = "Interface Setup INT".Code;
                    ToolTip = 'Specifies the value of the SP Open Purchase Orders Interface field.';
                }
                field("InterfSetup2.""Proc And Firm Pl Orders Interf"""; InterfSetup2."Proc And Firm Pl Orders Interf")
                {
                    Caption = 'SP Production Orders Scheduled Receipts  Interface';
                    TableRelation = "Interface Setup INT".Code;
                    ToolTip = 'Specifies the value of the SP Production Orders Scheduled Receipts  Interface field.';
                }
                field("InterfSetup2.""Stock Transport Orders Interf"""; InterfSetup2."Stock Transport Orders Interf")
                {
                    Caption = 'SP Stock Transport Order Related Receipts Interface';
                    TableRelation = "Interface Setup INT".Code;
                    ToolTip = 'Specifies the value of the SP Stock Transport Order Related Receipts Interface field.';
                }
                field("InterfSetup2.""Actual Production Interf"""; InterfSetup2."Actual Production Interf")
                {
                    Caption = 'SP Actual Production Interface';
                    TableRelation = "Interface Setup INT";
                    ToolTip = 'Specifies the value of the SP Actual Production Interface field.';
                }
                field("InterfSetup2.""PurchMasterData Interf"""; InterfSetup2."PurchMasterData Interf")
                {
                    Caption = 'SP Purchasing Master Data Interface';
                    TableRelation = "Interface Setup INT";
                    ToolTip = 'Specifies the value of the SP Purchasing Master Data Interface field.';
                }
                field("InterfSetup2.""BOMMasterData Interf"""; InterfSetup2."BOMMasterData Interf")
                {
                    Caption = 'SP BOM Master Data Filters';
                    TableRelation = "Interface Setup INT";
                    ToolTip = 'Specifies the value of the SP BOM Master Data Filters field.';
                }
                field("InterfSetup2.""Prod. BOM Version Interface"""; InterfSetup2."Prod. BOM Version Interface")
                {
                    Caption = 'SP Prodcution BOM Version interface';
                    TableRelation = "Interface Setup INT";
                    ToolTip = 'Specifies the value of the SP Prodcution BOM Version interface field.';
                }
                field("InterfSetup2.""Purch. Requisitions Interface"""; InterfSetup2."Purch. Requisitions Interface")
                {
                    Caption = 'SP Purchase Requisition';
                    TableRelation = "Interface Setup INT";
                    ToolTip = 'Specifies the value of the SP Purchase Requisition field.';
                }
                field("InterfSetup2.""Production Orders Interface"""; InterfSetup2."Production Orders Interface")
                {
                    Caption = 'SP Production Orders';
                    TableRelation = "Interface Setup INT";
                    ToolTip = 'Specifies the value of the SP Production Orders field.';
                }
                field("InterfSetup2.""Stock TransOrd Virtual  Interf"""; InterfSetup2."Stock TransOrd Virtual  Interf")
                {
                    Caption = 'SP Stock Transport Order Virtual Location Interface';
                    Description = 'HEI.18';
                    TableRelation = "Interface Setup INT".Code;
                    ToolTip = 'Specifies the value of the SP Stock Transport Order Virtual Location Interface field.';
                }
            }
            group(Notification)
            {
                Caption = 'Notification';
                field("InterfSetup2.""Notify User ID 1"""; InterfSetup2."Notify User ID 1")
                {
                    Caption = 'Notify User ID 1';
                    TableRelation = "User Setup"."User ID";
                    ToolTip = 'Specifies the value of the Notify User ID 1 field.';
                }
                field("InterfSetup2.""Notify User ID 2"""; InterfSetup2."Notify User ID 2")
                {
                    Caption = 'Notify User ID 2';
                    TableRelation = "User Setup"."User ID";
                    ToolTip = 'Specifies the value of the Notify User ID 2 field.';
                }
                field("InterfSetup2.""Interface Web Service User ID"""; InterfSetup2."Interface Web Service User ID")
                {
                    Caption = 'Interface Web Server User ID';
                    TableRelation = "User Setup"."User ID";
                    ToolTip = 'Specifies the value of the Interface Web Server User ID field.';
                }
            }
            group("Product Master Filters")
            {
                Caption = 'DP Products Master Data Filters';
                field("Product Master Category Filter"; Rec."Product Master Category Filter")
                {
                    Caption = 'Category Filter';
                    ToolTip = 'Specifies the value of the Category Filter field.';
                }
                field("Product Master Def UOM"; Rec."Product Master Def UOM")
                {
                    Caption = 'Default Unit of Measure';
                    ToolTip = 'Specifies the value of the " Default Unit of Measure" field.';
                }
            }
            group("Customer Master Filters")
            {
                Caption = 'DP Customers Master Data Filters';
                field("Cust. Master Acc Group Filter"; Rec."Cust. Master Acc Group Filter")
                {
                    Caption = 'Customer Account Group Filter';
                    ToolTip = 'Specifies the value of the Customer Account Group Filter field.';
                }
                field("Cust. Master Active Filter"; Rec."Cust. Master Active Filter")
                {
                    Caption = 'Customer Active Filter';
                    ToolTip = 'Specifies the value of the Customer Active Filter field.';
                }
                field("Cust. Contract Type Excl Filte"; Rec."Cust. Contract Type Excl Filte")
                {
                    ToolTip = 'Specifies the value of the Cust. Contract Type Excl Filter field.';
                }
            }
            group("Demand Plan Open Orders Filters")
            {
                Caption = 'DP Open Orders Filters';
                field("Demand Pl OO  Doc Types Filter"; Rec."Demand Pl OO  Doc Types Filter")
                {
                    Caption = 'Document Types Filter';
                    ToolTip = 'Specifies the value of the Document Types Filter field.';
                }
                field("Cust. DOO Acc Group Filter"; Rec."Cust. DOO Acc Group Filter")
                {
                    Caption = 'Customer Account Group Filter';
                    ToolTip = 'Specifies the value of the Customer Account Group Filter field.';
                }
                field("Demand Pl OO Item Categ Filter"; Rec."Demand Pl OO Item Categ Filter")
                {
                    Caption = 'Item Category  Filter';
                    ToolTip = 'Specifies the value of the Item Category  Filter field.';
                }
            }
            group("Sell in Actuals Month Filters")
            {
                Caption = 'DP Sell in Actuals Month Filters';
                group(Shipment)
                {
                    Caption = 'Shipment';
                    field("Sell Act MTH Doc Types Filter"; Rec."Sell Act MTH Doc Types Filter")
                    {
                        Caption = 'Document Types Filter';
                        ToolTip = 'Specifies the value of the Document Types Filter field.';
                    }
                    field("Cust.SellActM Acc Group Filter"; Rec."Cust.SellActM Acc Group Filter")
                    {
                        Caption = 'Customer Account Group Filter';
                        TableRelation = "Account Group FND";
                        ToolTip = 'Specifies the value of the Customer Account Group Filter field.';
                    }
                    field("Sell Act MTH Item Categ Filter"; Rec."Sell Act MTH Item Categ Filter")
                    {
                        Caption = 'Item Category Filter';
                        TableRelation = "Item Category";
                        ToolTip = 'Specifies the value of the Item Category Filter field.';
                    }
                    field("Sell Act MTH Location Filter"; Rec."Sell Act MTH Location Filter")
                    {
                        Caption = 'Location Filter';
                        TableRelation = Location;
                        ToolTip = 'Specifies the value of the Location Filter field.';
                    }
                    field("Sell Act MTH Ref Date"; Rec."Sell Act MTH Ref Date")
                    {
                        Caption = 'Reference Date';
                        ToolTip = 'Specifies the value of the Reference Date field.';
                    }
                }
                group("Return Receipt")
                {
                    Caption = 'Return Receipt';
                    field("FMIntSetup3.""Sell Act M. Incl. Return Rcpt."""; FMIntSetup3."Sell Act M. Incl. Return Rcpt.")
                    {
                        Caption = 'Include Return Receipt';
                        ToolTip = 'Specifies the value of the Include Return Receipt field.';
                    }
                    field("FMIntSetup3.""Sell Act M. Acc Group Filter 2"""; FMIntSetup3."Sell Act M. Acc Group Filter 2")
                    {
                        Caption = 'Customer Account Group Filter';
                        TableRelation = "Account Group FND";
                        ToolTip = 'Specifies the value of the Customer Account Group Filter field.';
                    }
                    field("FMIntSetup3.""Sell Act M. Item Cat  Filter 2"""; FMIntSetup3."Sell Act M. Item Cat  Filter 2")
                    {
                        Caption = 'Item Category Filter';
                        TableRelation = "Item Category";
                        ToolTip = 'Specifies the value of the Item Category Filter field.';
                    }
                    field("FMIntSetup3.""Sell Act M. Location Filter 2"""; FMIntSetup3."Sell Act M. Location Filter 2")
                    {
                        Caption = 'Location Filter';
                        TableRelation = Location;
                        ToolTip = 'Specifies the value of the Location Filter field.';
                    }
                    field("FMIntSetup3.""Sell Act M. Reference Date 2"""; FMIntSetup3."Sell Act M. Reference Date 2")
                    {
                        Caption = 'Reference Date';
                        ToolTip = 'Specifies the value of the Reference Date field.';
                    }
                }
            }
            group("Sell in Actuals Week Filters")
            {
                Caption = 'DP Sell in Actuals Week Filters';
                group(Control55207)
                {
                    Caption = 'Shipment';
                    field("Sell Act Week Doc Types Filter"; Rec."Sell Act Week Doc Types Filter")
                    {
                        Caption = 'Document Types Filter';
                        ToolTip = 'Specifies the value of the Document Types Filter field.';
                    }
                    field("Cust.SellActW Acc Group Filter"; Rec."Cust.SellActW Acc Group Filter")
                    {
                        Caption = 'Customer Account Group Filter';
                        ToolTip = 'Specifies the value of the Customer Account Group Filter field.';
                    }
                    field("Sell Act Week Item Cat Filter"; Rec."Sell Act Week Item Cat Filter")
                    {
                        Caption = 'Item Category Filter';
                        TableRelation = "Item Category";
                        ToolTip = 'Specifies the value of the Item Category Filter field.';
                    }
                    field("Sell Act Week Location Filter"; Rec."Sell Act Week Location Filter")
                    {
                        Caption = 'Location Filter';
                        TableRelation = Location;
                        ToolTip = 'Specifies the value of the Location Filter field.';
                    }
                    field("Sell Act WK Ref Date"; Rec."Sell Act WK Ref Date")
                    {
                        Caption = 'Reference Date';
                        ToolTip = 'Specifies the value of the Reference Date field.';
                    }
                    field("Sell Act Wk Prev Weeks"; Rec."Sell Act Wk Prev Weeks")
                    {
                        ToolTip = 'Specifies the value of the Previous Weeks Selection field.';
                    }
                }
                group(Control55208)
                {
                    Caption = 'Return Receipt';
                    field("FMIntSetup3.""Sell Act W. Incl. Return Rcpt."""; FMIntSetup3."Sell Act W. Incl. Return Rcpt.")
                    {
                        Caption = 'Include Return Receipt';
                        ToolTip = 'Include Sales Return Receipt documents in the shipment quantity calculation.';
                    }
                    field("FMIntSetup3.""Sell Act W. Acc Group Filter 2"""; FMIntSetup3."Sell Act W. Acc Group Filter 2")
                    {
                        Caption = 'Customer Account Group Filter';
                        TableRelation = "Account Group FND";
                        ToolTip = 'Specifies the value of the Customer Account Group Filter field.';
                    }
                    field("FMIntSetup3.""Sell Act W. Item Cat Filter 2"""; FMIntSetup3."Sell Act W. Item Cat Filter 2")
                    {
                        Caption = 'Item Category Filter';
                        TableRelation = "Item Category";
                        ToolTip = 'Specifies the value of the Item Category Filter field.';
                    }
                    field("FMIntSetup3.""Sell Act W. Location Filter 2"""; FMIntSetup3."Sell Act W. Location Filter 2")
                    {
                        Caption = 'Location Filter';
                        TableRelation = Location;
                        ToolTip = 'Specifies the value of the Location Filter field.';
                    }
                    field("FMIntSetup3.""Sell Act W. Reference Date 2"""; FMIntSetup3."Sell Act W. Reference Date 2")
                    {
                        Caption = 'Reference Date';
                        ToolTip = 'Specifies the value of the Reference Date field.';
                    }
                    field("FMIntSetup3.""Sell Act W. Previous Weeks 2"""; FMIntSetup3."Sell Act W. Previous Weeks 2")
                    {
                        Caption = 'Previous Weeks Selection';
                        ToolTip = 'Specifies the value of the Previous Weeks Selection field.';
                    }
                }
            }
            group("Sell in Act Month 3YR Filters")
            {
                Caption = 'DP Sell in Actuals Month 3YR Filters';
                field("Sell Act MTH3YR Doc Typ Filter"; Rec."Sell Act MTH3YR Doc Typ Filter")
                {
                    Caption = 'Document Types Filter';
                    ToolTip = 'Specifies the value of the Document Types Filter field.';
                }
                field("Cust.SellActM3 Acc Gr Filter"; Rec."Cust.SellActM3 Acc Gr Filter")
                {
                    Caption = 'Customer Account Group Filter';
                    TableRelation = "Account Group FND";
                    ToolTip = 'Specifies the value of the Customer Account Group Filter field.';
                }
                field("Sell Act MTH3YR Item Ca Filter"; Rec."Sell Act MTH3YR Item Ca Filter")
                {
                    Caption = 'Item Category Filter';
                    TableRelation = "Item Category";
                    ToolTip = 'Specifies the value of the Item Category Filter field.';
                }
                field("Sell Act MTH3YR Loc Filter"; Rec."Sell Act MTH3YR Loc Filter")
                {
                    Caption = 'Location Filter';
                    TableRelation = Location;
                    ToolTip = 'Specifies the value of the Location Filter field.';
                }
                field("Sell Act Mth 3YR Start Date"; Rec."Sell Act Mth 3YR Start Date")
                {
                    Caption = 'Start Date';
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("Sell Act Mth 3YR End  Date"; Rec."Sell Act Mth 3YR End  Date")
                {
                    Caption = 'End Date';
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("FMIntSetup3.""Sell Act M3YR Incl. Rtrn Rcpt"""; FMIntSetup3."Sell Act M3YR Incl. Rtrn Rcpt")
                {
                    Caption = 'Include Return Receipt';
                    ToolTip = 'Include Sales Return Receipt documents in the shipment quantity calculation.';
                }
                field("FMIntSetup3.""Sell Act M3YR Acc Gr Filter 2"""; FMIntSetup3."Sell Act M3YR Acc Gr Filter 2")
                {
                    Caption = 'Customer Account Group Filter';
                    TableRelation = "Account Group FND";
                    ToolTip = 'Specifies the value of the Customer Account Group Filter field.';
                }
                field("FMIntSetup3.""Sell Act M3YR Item Ca Filter 2"""; FMIntSetup3."Sell Act M3YR Item Ca Filter 2")
                {
                    Caption = 'Item Category Filter';
                    TableRelation = "Item Category";
                    ToolTip = 'Specifies the value of the Item Category Filter field.';
                }
                field("FMIntSetup3.""Sell Act M3YR Loc Filter 2"""; FMIntSetup3."Sell Act M3YR Loc Filter 2")
                {
                    Caption = 'Location Filter';
                    TableRelation = Location;
                    ToolTip = 'Specifies the value of the Location Filter field.';
                }
                field("FMIntSetup3.""Sell Act M3YR Start Date 2"""; FMIntSetup3."Sell Act M3YR Start Date 2")
                {
                    Caption = 'Start Date';
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("FMIntSetup3.""Sell Act M3YR End Date 2"""; FMIntSetup3."Sell Act M3YR End Date 2")
                {
                    Caption = 'End Date';
                    ToolTip = 'Specifies the value of the End Date field.';
                }
            }
            group("Sell in Act Week 3YR Filters")
            {
                Caption = 'DP Sell in Actuals Week 3YR Filters';
                field("Sell Act WK3YR Doc Typ Filter"; Rec."Sell Act WK3YR Doc Typ Filter")
                {
                    Caption = 'Document Types Filte';
                    ToolTip = 'Specifies the value of the Document Types Filte field.';
                }
                field("Cust.SellActW3 Acc Gr Filter"; Rec."Cust.SellActW3 Acc Gr Filter")
                {
                    Caption = 'Customer Account Group Filter>';
                    TableRelation = "Account Group FND";
                    ToolTip = 'Specifies the value of the Customer Account Group Filter> field.';
                }
                field("Sell Act WK3YR Item Cat Filter"; Rec."Sell Act WK3YR Item Cat Filter")
                {
                    Caption = 'Item Category Filter';
                    TableRelation = "Item Category";
                    ToolTip = 'Specifies the value of the Item Category Filter field.';
                }
                field("Sell Act WK3YR Loc Filter"; Rec."Sell Act WK3YR Loc Filter")
                {
                    Caption = 'Location Filte';
                    TableRelation = Location;
                    ToolTip = 'Specifies the value of the Location Filte field.';
                }
                field("Sell Act Wk 3YR Start Date"; Rec."Sell Act Wk 3YR Start Date")
                {
                    Caption = 'Start Date';
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("Sell Act Wk 3YR End  Date"; Rec."Sell Act Wk 3YR End  Date")
                {
                    Caption = 'End Date';
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("FMIntSetup3.""Sell Act W3YR Incl. Rtrn. Rcpt"""; FMIntSetup3."Sell Act W3YR Incl. Rtrn. Rcpt")
                {
                    Caption = 'Include Return Receipt';
                    ToolTip = 'Include Sales Return Receipt documents in the shipment quantity calculation.';
                }
                field("FMIntSetup3.""Sell Act W3YR Acc Gr Filter 2"""; FMIntSetup3."Sell Act W3YR Acc Gr Filter 2")
                {
                    Caption = 'Customer Account Group Filter';
                    TableRelation = "Account Group FND";
                    ToolTip = 'Specifies the value of the Customer Account Group Filter field.';
                }
                field("FMIntSetup3.""Sell Act W3YR Item Ca Filter 2"""; FMIntSetup3."Sell Act W3YR Item Ca Filter 2")
                {
                    Caption = 'Item Category Filter';
                    TableRelation = "Item Category";
                    ToolTip = 'Specifies the value of the Item Category Filter field.';
                }
                field("FMIntSetup3.""Sell Act W3YR Loc Filter 2"""; FMIntSetup3."Sell Act W3YR Loc Filter 2")
                {
                    Caption = 'Location Filter';
                    TableRelation = Location;
                    ToolTip = 'Specifies the value of the Location Filter field.';
                }
                field("FMIntSetup3.""Sell Act W3YR Start Date 2"""; FMIntSetup3."Sell Act W3YR Start Date 2")
                {
                    Caption = 'Start Date';
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("FMIntSetup3.""Sell Act W3YR End Date 2"""; FMIntSetup3."Sell Act W3YR End Date 2")
                {
                    Caption = 'End Date';
                    ToolTip = 'Specifies the value of the End Date field.';
                }
            }
            group(DPReturnsMonthFilter)
            {
                Caption = 'DP Returns Actuals Month Filters';
                field("InterfSetup2.""Ret. Act Month Doc Type Filter"""; InterfSetup2."Ret. Act Month Doc Type Filter")
                {
                    Caption = 'Dcument Type Filter';
                    ToolTip = 'Specifies the value of the Dcument Type Filter field.';
                }
                field("InterfSetup2.""Ret. Act Month Acc. Gr. Filter"""; InterfSetup2."Ret. Act Month Acc. Gr. Filter")
                {
                    Caption = 'Customer Account Group Filter';
                    TableRelation = "Account Group FND";
                    ToolTip = 'Specifies the value of the Customer Account Group Filter field.';
                }
                field("InterfSetup2.""Ret. Act Month Item Cat Filter"""; InterfSetup2."Ret. Act Month Item Cat Filter")
                {
                    Caption = 'Item Category Filter';
                    TableRelation = "Item Category";
                    ToolTip = 'Specifies the value of the Item Category Filter field.';
                }
                field("InterfSetup2.""Ret. Act Month Location Filter"""; InterfSetup2."Ret. Act Month Location Filter")
                {
                    Caption = 'Location Filter';
                    TableRelation = Location;
                    ToolTip = 'Specifies the value of the Location Filter field.';
                }
                field("InterfSetup2.""Ret. Act Month Reference Date"""; InterfSetup2."Ret. Act Month Reference Date")
                {
                    Caption = 'Reference Date';
                    ToolTip = 'Specifies the value of the Reference Date field.';
                }
            }
            group(DPReturnsWeekFilter)
            {
                Caption = 'DP Returns Actuals Week Filters';
                field("InterfSetup2.""Ret. Act Week Doc Type Filter"""; InterfSetup2."Ret. Act Week Doc Type Filter")
                {
                    Caption = 'Dcument Type Filter';
                    ToolTip = 'Specifies the value of the Dcument Type Filter field.';
                }
                field("InterfSetup2.""Ret. Act Week Acc. Gr. Filter"""; InterfSetup2."Ret. Act Week Acc. Gr. Filter")
                {
                    Caption = 'Customer Account Group Filter';
                    TableRelation = "Account Group FND";
                    ToolTip = 'Specifies the value of the Customer Account Group Filter field.';
                }
                field("InterfSetup2.""Ret. Act Week Item Cat. Filter"""; InterfSetup2."Ret. Act Week Item Cat. Filter")
                {
                    Caption = 'Item Category Filter';
                    TableRelation = "Item Category";
                    ToolTip = 'Specifies the value of the Item Category Filter field.';
                }
                field("InterfSetup2.""Ret. Act Week Location Filter"""; InterfSetup2."Ret. Act Week Location Filter")
                {
                    Caption = 'Location Filter';
                    TableRelation = Location;
                    ToolTip = 'Specifies the value of the Location Filter field.';
                }
                field("InterfSetup2.""Ret. Act Week Reference Date"""; InterfSetup2."Ret. Act Week Reference Date")
                {
                    Caption = 'Start Date';
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("InterfSetup2.""Ret. Act Week Previous Weeks"""; InterfSetup2."Ret. Act Week Previous Weeks")
                {
                    Caption = 'Previous Weeks Selection';
                    ToolTip = 'Specifies the value of the Previous Weeks Selection field.';
                }
            }
            group(DPReturnsMonth3YRFilter)
            {
                Caption = 'DP Returns Actuals Month 3YR Filters';
                field("InterfSetup2.""Ret. Act MTH3YR Doc Typ Filter"""; InterfSetup2."Ret. Act MTH3YR Doc Typ Filter")
                {
                    Caption = 'Dcument Type Filter';
                    ToolTip = 'Specifies the value of the Dcument Type Filter field.';
                }
                field("InterfSetup2.""Ret. Act MTH3YR Acc. Gr Filter"""; InterfSetup2."Ret. Act MTH3YR Acc. Gr Filter")
                {
                    Caption = 'Customer Account Group Filter';
                    TableRelation = "Account Group FND";
                    ToolTip = 'Specifies the value of the Customer Account Group Filter field.';
                }
                field("InterfSetup2.""Ret. Act MTH3YR Item Ca Filter"""; InterfSetup2."Ret. Act MTH3YR Item Ca Filter")
                {
                    Caption = 'Item Category Filter';
                    TableRelation = "Item Category";
                    ToolTip = 'Specifies the value of the Item Category Filter field.';
                }
                field("InterfSetup2.""Ret. Act MTH3YR Loc. Filter"""; InterfSetup2."Ret. Act MTH3YR Loc. Filter")
                {
                    Caption = 'Location Filter';
                    TableRelation = Location;
                    ToolTip = 'Specifies the value of the Location Filter field.';
                }
                field("InterfSetup2.""Ret. Act MTH3YR Start Date"""; InterfSetup2."Ret. Act MTH3YR Start Date")
                {
                    Caption = 'Start Date';
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("InterfSetup2.""Ret. Act MTH3YR End Date"""; InterfSetup2."Ret. Act MTH3YR End Date")
                {
                    Caption = 'End Date';
                    ToolTip = 'Specifies the value of the End Date field.';
                }
            }
            group(DPReturnsWK3YRFilter)
            {
                Caption = 'DP Returns Actuals Week 3YR Filters';
                field("InterfSetup2.""Ret. Act WK3YR Doc Type Filter"""; InterfSetup2."Ret. Act WK3YR Doc Type Filter")
                {
                    Caption = 'Dcument Type Filter';
                    ToolTip = 'Specifies the value of the Dcument Type Filter field.';
                }
                field("InterfSetup2.""Ret. Act WK3YR Acc. Gr. Filter"""; InterfSetup2."Ret. Act WK3YR Acc. Gr. Filter")
                {
                    Caption = 'Customer Account Group Filter';
                    TableRelation = "Account Group FND";
                    ToolTip = 'Specifies the value of the Customer Account Group Filter field.';
                }
                field("InterfSetup2.""Ret. Act WK3YR Item Cat Filter"""; InterfSetup2."Ret. Act WK3YR Item Cat Filter")
                {
                    Caption = 'Item Category Filter';
                    TableRelation = "Item Category";
                    ToolTip = 'Specifies the value of the Item Category Filter field.';
                }
                field("InterfSetup2.""Ret. Act WK3YR Location Filter"""; InterfSetup2."Ret. Act WK3YR Location Filter")
                {
                    Caption = 'Location Filter';
                    TableRelation = Location;
                    ToolTip = 'Specifies the value of the Location Filter field.';
                }
                field("InterfSetup2.""Ret. Act WK3YR Start Date"""; InterfSetup2."Ret. Act WK3YR Start Date")
                {
                    Caption = 'Start Date';
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("InterfSetup2.""Ret. Act WK3YR End Date"""; InterfSetup2."Ret. Act WK3YR End Date")
                {
                    Caption = 'End Date';
                    ToolTip = 'Specifies the value of the End Date field.';
                }
            }
            group(ShipmentsKPI)
            {
                Caption = 'DP Order Shipment Filters';
                field("InterfSetup2.""Shpt. Prev. Weeks"""; InterfSetup2."Shpt. Prev. Weeks")
                {
                    Caption = 'Shipment Previous Weeks';
                    ToolTip = 'Specifies the value of the Shipment Previous Weeks field.';
                }
                field("InterfSetup2.""Shpt. Location Filter"""; InterfSetup2."Shpt. Location Filter")
                {
                    Caption = 'Location Filter';
                    TableRelation = Location;
                    ToolTip = 'Specifies the value of the Location Filter field.';
                }
                field("InterfSetup2.""Shpt. Item Category Filter"""; InterfSetup2."Shpt. Item Category Filter")
                {
                    Caption = 'Item Category Filter';
                    TableRelation = "Item Category";
                    ToolTip = 'Specifies the value of the Item Category Filter field.';
                }
                field("InterfSetup2.""Shpt. Doc. Sub Type Filter"""; InterfSetup2."Shpt. Doc. Sub Type Filter")
                {
                    Caption = 'Document Sub Type Filter';
                    ToolTip = 'Specifies the value of the Document Sub Type Filter field.';
                    TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales | "Fin.Contract"));  // BC Upgrade SHUKLP03
                }
            }
            group(TransfersKPI)
            {
                Caption = 'DP Transfer Shipment Filters';
                field("InterfSetup2.""ShptTrsf. Prev. Weeks"""; InterfSetup2."ShptTrsf. Prev. Weeks")
                {
                    Caption = 'Transfer Previous Weeks';
                    ToolTip = 'Specifies the value of the Transfer Previous Weeks field.';
                }
                field("InterfSetup2.""ShpTrsf. Location Filter"""; InterfSetup2."ShpTrsf. Location Filter")
                {
                    Caption = 'Location Filter';
                    TableRelation = Location;
                    ToolTip = 'Specifies the value of the Location Filter field.';
                }
                field("InterfSetup2.""ShpTrsf. Item Category Filter"""; InterfSetup2."ShpTrsf. Item Category Filter")
                {
                    Caption = 'Item Category Filter';
                    TableRelation = "Item Category";
                    ToolTip = 'Specifies the value of the Item Category Filter field.';
                }
                field("InterfSetup2.""ShptTrsf. Doc. Sub Type Filter"""; InterfSetup2."ShptTrsf. Doc. Sub Type Filter")
                {
                    Caption = 'Document Sub Type Filter';
                    ToolTip = 'Specifies the value of the Document Sub Type Filter field.';
                    TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = CONST(Inventory));  // BC Upgrade SHUKLP03
                }
            }
            group("Supply Plan Open Orders Filters")
            {
                Caption = 'SP Open Sales Orders Filters';
                field("Supply Pl OO  Doc Types Filter"; Rec."Supply Pl OO  Doc Types Filter")
                {
                    Caption = 'Document Types Filter';
                    ToolTip = 'Specifies the value of the Document Types Filter field.';
                }
                field("Customer Account Group Filter"; Rec."Cust.SOO Acc Group Filter")
                {
                    Caption = 'Customer Account Group Filter';
                    ToolTip = 'Specifies the value of the Customer Account Group Filter field.';
                }
                field("Supply Pl OO Item Categ Filter"; Rec."Supply Pl OO Item Categ Filter")
                {
                    Caption = 'Item Category  Filter';
                    ToolTip = 'Specifies the value of the Item Category  Filter field.';
                }
            }
            group("Stock On Hand")
            {
                Caption = 'SP Stock on Hand Filters';
                grid(Control55074)
                {
                    group(Control55073)
                    {
                        field("StockOnHand Location Filter"; Rec."StockOnHand Location Filter")
                        {
                            Caption = 'Location Code Filter';
                            ToolTip = 'Specifies the value of the Location Code Filter field.';

                            //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                            trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                            var
                                locLocation: Record Location;
                            begin
                                //HEI.01
                                locLocation.RESET();
                                if PAGE.RUNMODAL(0, locLocation) = ACTION::LookupOK then begin
                                    Text := Text + locLocation.Code;
                                    exit(true);
                                end;
                            end;
                        }
                        field("StockOnHand Current Week"; Rec."StockOnHand Current Week")
                        {
                            Caption = 'Current Week';
                            ToolTip = 'Specifies the value of the Current Week field.';
                        }
                    }
                }
                grid(Control55070)
                {
                    GridLayout = Rows;
                    group("CMG Filter 1")
                    {
                        //The GridLayout property is only supported on controls of type Grid
                        //GridLayout = Columns;
                        field("StockOnHand CMG Filter"; Rec."StockOnHand CMG Filter")
                        {
                            Caption = 'Item Category Code Filter';
                            ToolTip = 'Specifies the value of the Item Category Code Filter field.';

                            //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                            trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                            var
                                locItemCateg: Record "Item Category";
                            begin
                                //HEI.01
                                locItemCateg.RESET();
                                if PAGE.RUNMODAL(0, locItemCateg) = ACTION::LookupOK then begin
                                    Text := Text + locItemCateg.Code;
                                    exit(true);
                                end;
                            end;
                        }
                    }
                    group("CMG Filter Set 1")
                    {
                        //The GridLayout property is only supported on controls of type Grid
                        //GridLayout = Columns;
                        field("StockOnHand Item Categ Filter1"; Rec."StockOnHand Item Categ Filter1")
                        {
                            Caption = 'Item Category Code Filter';
                            ToolTip = 'Specifies the value of the Item Category Code Filter field.';
                        }
                        field("StockOnHand Item Attr Filter1"; Rec."StockOnHand Item Attr Filter1")
                        {
                            Caption = 'Item Attribute Code Filter';
                            ToolTip = 'Specifies the value of the Item Attribute Code Filter field.';
                        }
                        field("StockOnHand ItemAttrValFilter1"; Rec."StockOnHand ItemAttrValFilter1")
                        {
                            Caption = 'Item Attribute Value Filter';
                            ToolTip = 'Specifies the value of the Item Attribute Value Filter field.';

                            //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                            trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                            var
                                locItemAttribValue: Record "Item Attribute Value";
                            begin
                                //HEI.01
                                locItemAttribValue.RESET();
                                locItemAttribValue.SETRANGE("Attribute ID", Rec."StockOnHand Item Attr Filter1");
                                if PAGE.RUNMODAL(0, locItemAttribValue) = ACTION::LookupOK then begin
                                    Text := Text + locItemAttribValue.Value;
                                    exit(true);
                                end;
                            end;
                        }
                    }
                    group("CMG Filter Set 2")
                    {
                        field("StockOnHand Item Categ Filter2"; Rec."StockOnHand Item Categ Filter2")
                        {
                            Caption = 'Item Category Code Filter';
                            ToolTip = 'Specifies the value of the Item Category Code Filter field.';
                        }
                        field("StockOnHand Item Attr Filter2"; Rec."StockOnHand Item Attr Filter2")
                        {
                            Caption = 'Item Attribute Code Filter';
                            ToolTip = 'Specifies the value of the Item Attribute Code Filter field.';
                        }
                        field("StockOnHand ItemAttrValFilter2"; Rec."StockOnHand ItemAttrValFilter2")
                        {
                            Caption = 'Item Attribute Value Filter';
                            ToolTip = 'Specifies the value of the Item Attribute Value Filter field.';

                            //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                            trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                            var
                                locItemAttribValue: Record "Item Attribute Value";
                            begin
                                //HEI.01
                                locItemAttribValue.RESET();
                                locItemAttribValue.SETRANGE("Attribute ID", Rec."StockOnHand Item Attr Filter1");
                                if PAGE.RUNMODAL(0, locItemAttribValue) = ACTION::LookupOK then begin
                                    Text := Text + locItemAttribValue.Value;
                                    exit(true);
                                end;
                            end;
                        }
                    }
                    group("CMG Filter Set 3")
                    {
                        field("StockOnHand Item Categ Filter3"; Rec."StockOnHand Item Categ Filter3")
                        {
                            Caption = 'Item Category Code Filter';
                            ToolTip = 'Specifies the value of the Item Category Code Filter field.';
                        }
                        field("StockOnHand Item Attr Filter3"; Rec."StockOnHand Item Attr Filter3")
                        {
                            Caption = 'Item Attribute Code Filter';
                            ToolTip = 'Specifies the value of the Item Attribute Code Filter field.';
                        }
                        field("StockOnHand ItemAttrValFilter3"; Rec."StockOnHand ItemAttrValFilter3")
                        {
                            Caption = 'Item Attribute Value Filter';
                            ToolTip = 'Specifies the value of the Item Attribute Value Filter field.';

                            //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                            trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                            var
                                locItemAttribValue: Record "Item Attribute Value";
                            begin
                                //HEI.01
                                locItemAttribValue.RESET();
                                locItemAttribValue.SETRANGE("Attribute ID", Rec."StockOnHand Item Attr Filter1");
                                if PAGE.RUNMODAL(0, locItemAttribValue) = ACTION::LookupOK then begin
                                    Text := Text + locItemAttribValue.Value;
                                    exit(true);
                                end;
                            end;
                        }
                    }
                }
            }
            group("Component Product Master Filters")
            {
                Caption = 'SP Component Products Master Data Filters';
                field("Comp Product Category Filter"; Rec."Comp Product Category Filter")
                {
                    Caption = 'Item Category Filter';
                    ToolTip = 'Specifies the value of the Item Category Filter field.';
                }
            }
            group("Finished Product UOMs Filters")
            {
                Caption = 'SP Finished Products UOM Filters';
                field("Finish UOM Prod Categ Filter"; Rec."Finish UOM Prod Categ Filter")
                {
                    Caption = 'Item Category Filter';
                    ToolTip = 'Specifies the value of the Item Category Filter field.';
                }
                field("Finish UOM Prod Def UOM"; Rec."Finish UOM Prod Def UOM")
                {
                    Caption = 'Default UOM Filter';
                    ToolTip = 'Specifies the value of the Default UOM Filter field.';
                }
                field("Finish UOM Prod Alt1 UOM"; Rec."Finish UOM Prod Alt1 UOM")
                {
                    Caption = 'Alternative 1 UOM Filter';
                    ToolTip = 'Specifies the value of the Alternative 1 UOM Filter field.';
                }
                field("Finish UOM Prod Alt2 UOM"; Rec."Finish UOM Prod Alt2 UOM")
                {
                    Caption = 'Alternative 2 UOM Filter';
                    ToolTip = 'Specifies the value of the Alternative 2 UOM Filter field.';
                }
            }
            group("Standard Cost Filters")
            {
                Caption = 'SP Standard Costs Filters';
                field("InterfSetup2.""Std Cost Category Filter"""; InterfSetup2."Std Cost Category Filter")
                {
                    Caption = 'Item Category Filter';
                    ToolTip = 'Specifies the value of the Item Category Filter field.';
                }
                field("InterfSetup2.""Std Cost Location Filter"""; InterfSetup2."Std Cost Location Filter")
                {
                    Caption = 'Location Filter';
                    ToolTip = 'Specifies the value of the Location Filter field.';
                }
                field("FMIntSetup3.""Convert Cost PC to HL"""; FMIntSetup3."Convert Cost PC to HL")
                {
                    Caption = 'Convert Cost PC to HL';
                    ToolTip = 'Specifies the value of the Convert Cost PC to HL field.';
                }
                field("FMIntSetup3.""Inventory Posting Group"""; FMIntSetup3."Inventory Posting Group")
                {
                    Caption = 'Finished Imported Goods';
                    TableRelation = "Inventory Posting Group".Code;
                    ToolTip = 'Specifies the value of the Finished Imported Goods field.';
                }
            }
            group("Semi Finished Prod Filters")
            {
                Caption = 'SP Semi Finished Products Master Filters';
                field("InterfSetup2.""SemiFinish Category Filter"""; InterfSetup2."SemiFinish Category Filter")
                {
                    Caption = 'Item Category Filter';
                    ToolTip = 'Specifies the value of the Item Category Filter field.';
                }
                field("InterfSetup2.""SemiFinish Location Filter"""; InterfSetup2."SemiFinish Location Filter")
                {
                    Caption = 'Location Filter';
                    ToolTip = 'Specifies the value of the Location Filter field.';
                }
                field("InterfSetup2.""SemiFinish Def UOM"""; InterfSetup2."SemiFinish Def UOM")
                {
                    Caption = 'Default Unit of Measure';
                    ToolTip = 'Specifies the value of the Default Unit of Measure field.';
                }
            }
            group("Open Purchase Orders Filters")
            {
                Caption = 'SP Open Purchase Orders Filters';
                field("InterfSetup2.""OpenPurchOrd Doc Types Filter"""; InterfSetup2."OpenPurchOrd Doc Types Filter")
                {
                    Caption = 'Document Type Filter';
                    ToolTip = 'Specifies the value of the Document Type Filter field.';
                }
                field("InterfSetup2.""OpenPurchOrd Age Days Filter"""; InterfSetup2."OpenPurchOrd Age Days Filter")
                {
                    Caption = 'Age of Expected Receipt in Days';
                    ToolTip = 'Specifies the value of the Age of Expected Receipt in Days field.';
                }
                field("InterfSetup2.""OpenPurchOrd Category Filter"""; InterfSetup2."OpenPurchOrd Category Filter")
                {
                    Caption = 'Item Category Filter';
                    ToolTip = 'Specifies the value of the Item Category Filter field.';
                }
                field("InterfSetup2.""OpenPurchOrd Location Filter"""; InterfSetup2."OpenPurchOrd Location Filter")
                {
                    Caption = 'Location Filter';
                    ToolTip = 'Specifies the value of the Location Filter field.';
                }
                field("InterfSetup2.""OpenPurchOrd Status Filter"""; InterfSetup2."OpenPurchOrd Status Filter")
                {
                    Caption = 'Status Filter';
                    ToolTip = 'Specifies the value of the Status Filter field.';
                }
                field("FMIntSetup3.""CMG Filter"""; FMIntSetup3."CMG Filter")
                {
                    Caption = 'CMG Filter';
                    ToolTip = 'Specified to add CMG filter to exclude from Export PO, start with <>CMGXXXX.';

                    //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                    trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                    var
                        GenledSetup: Record "General Ledger Setup";
                        DimensionValue: Record "Dimension Value";
                    begin
                        //HEI.32>>
                        GenledSetup.GET();
                        DimensionValue.RESET();
                        DimensionValue.SETRANGE("Dimension Code", GenledSetup."CMG Dimension Code FND");
                        if PAGE.RUNMODAL(0, DimensionValue) = ACTION::LookupOK then begin
                            Text := Text + DimensionValue.Code;
                            exit(true);
                        end;
                        //HEI.32<<
                    end;
                }
            }
            group("ProcAndFirm Pl Orders Filters")
            {
                Caption = 'SP Production Orders Scheduled Receipts Filters';
                field("InterfSetup2.""ProcFirmOrd Location Filter"""; InterfSetup2."ProcFirmOrd Location Filter")
                {
                    Caption = 'Location Filter';
                    ToolTip = 'Specifies the value of the Location Filter field.';
                }
                field("InterfSetup2.""ProcFirmOrd Zone Filter"""; InterfSetup2."ProcFirmOrd Zone Filter")
                {
                    Caption = 'Zone Filter';
                    ToolTip = 'Specifies the value of the Zone Filter field.';
                }
                field("InterfSetup2.""ProcFirmOrd Status Filter"""; InterfSetup2."ProcFirmOrd Status Filter")
                {
                    Caption = 'Status Filter';
                    ToolTip = 'Specifies the value of the Status Filter field.';
                }
            }
            group("StockTran Orders Filters")
            {
                Caption = 'SP Stock Transport Order Related Receipts Filters';
                field("InterfSetup2.""StockTransOrd Category Filter"""; InterfSetup2."StockTransOrd Category Filter")
                {
                    Caption = 'Item Category  Filter';
                    ToolTip = 'Specifies the value of the Item Category  Filter field.';
                }
                field("InterfSetup2.""StockTransOrd Location Filter"""; InterfSetup2."StockTransOrd Location Filter")
                {
                    Caption = 'Location Filter';
                    ToolTip = 'Specifies the value of the Location Filter field.';
                }
                field("FMIntSetup3.""StockTransOrd Virtual Location"""; FMIntSetup3."StockTransOrd Virtual Location")
                {
                    Caption = 'Virtual Location Filter';
                    ToolTip = 'Specifies the value of the Virtual Location Filter field.';

                    //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                    trigger OnLookup(Var Text: Text): Boolean;  // BC Upgrade NANDIS03
                    var
                        locLocation: Record Location;
                    begin
                        //HEI.28<<
                        locLocation.RESET();
                        if PAGE.RUNMODAL(0, locLocation) = ACTION::LookupOK then begin
                            Text := Text + locLocation.Code;
                            exit(true);
                        end;
                        //HEI.28>>
                    end;
                }
            }
            group(ActualProduction)
            {
                Caption = 'SP Actual Production Filters';
                field("InterfSetup2.""ActualProd Status Filter"""; InterfSetup2."ActualProd Status Filter")
                {
                    Caption = 'Status Filter';
                    ToolTip = 'Specifies the value of the Status Filter field.';
                }
                field("InterfSetup2.""ActualProd Location Filter"""; InterfSetup2."ActualProd Location Filter")
                {
                    Caption = 'Location Filter';
                    ToolTip = 'Specifies the value of the Location Filter field.';
                }
                field("InterfSetup2.""ActualProd Zone Filter"""; InterfSetup2."ActualProd Zone Filter")
                {
                    Caption = 'Zone Filter';
                    ToolTip = 'Specifies the value of the Zone Filter field.';
                }
            }
            group(PurchMasterData)
            {
                Caption = 'SP Purchasing Master Data Filters';
                field("InterfSetup2.""PurchMasterData DocType Filter"""; InterfSetup2."PurchMasterData DocType Filter")
                {
                    Caption = 'Document Type Filter';
                    ToolTip = 'Specifies the value of the Document Type Filter field.';
                }
                field("InterfSetup2.""PurchMasterDataCrossPlant Filt"""; InterfSetup2."PurchMasterDataCrossPlant Filt")
                {
                    Caption = 'Cross Plant Material Status Filter';
                    ToolTip = 'Specifies the value of the Cross Plant Material Status Filter field.';
                }
                field("InterfSetup2.""PurchMasterDataPlantSp Fiilter"""; InterfSetup2."PurchMasterDataPlantSp Fiilter")
                {
                    Caption = 'Plant Specific Material Status Filter';
                    ToolTip = 'Specifies the value of the Plant Specific Material Status Filter field.';
                }
                field("InterfSetup2.PurchMasterDataContrTypeFilter"; InterfSetup2.PurchMasterDataContrTypeFilter)
                {
                    Caption = 'Contract Type Filter';
                    ToolTip = 'Specifies the value of the Contract Type Filter field.';

                    //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                    trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                    var
                        locSRMContractType: Record "SRM Contract Type FND";
                    begin
                        //HEI.01
                        locSRMContractType.RESET();
                        if PAGE.RUNMODAL(0, locSRMContractType) = ACTION::LookupOK then begin
                            Text := Text + FORMAT(locSRMContractType.Code);
                            exit(true);
                        end;
                    end;
                }
            }
            group("BOM Master Data")
            {
                Caption = 'SP BOM Master Data Filters';
                grid(Control55145)
                {
                    group(Control55144)
                    {
                        field(LocationCode; InterfSetup2."BOM Location Filter")
                        {
                            Caption = 'Location Code Filter';
                            ToolTip = 'Specifies the value of the Location Code Filter field.';

                            //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                            trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                            var
                                locLocation: Record Location;
                            begin
                                //HEI.01
                                locLocation.RESET();
                                if PAGE.RUNMODAL(0, locLocation) = ACTION::LookupOK then begin
                                    Text := Text + locLocation.Code;
                                    exit(true);
                                end;
                            end;
                        }
                        field(RefUOM; InterfSetup2."BOM Ref UM")
                        {
                            Caption = 'Reference Unit of Measure';
                            ToolTip = 'Specifies the value of the Reference Unit of Measure field.';

                            //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                            trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                            var
                                locUOM: Record "Unit of Measure";
                            begin
                                //HEI.01
                                locUOM.RESET();
                                if PAGE.RUNMODAL(0, locUOM) = ACTION::LookupOK then begin
                                    Text := locUOM.Code;
                                    exit(true);
                                end;
                            end;
                        }
                        field(ProdBOMStatus; InterfSetup2."BOM Status Flter")
                        {
                            Caption = 'Prod BOM Status Filter';
                            ToolTip = 'Specifies the value of the Prod BOM Status Filter field.';
                        }
                        field(ProdBOMVersStatus; InterfSetup2."BOM Vers St Filter")
                        {
                            Caption = 'Prod BOM Version Status Filter';
                            ToolTip = 'Specifies the value of the Prod BOM Version Status Filter field.';
                        }
                    }
                    group("BOM Component")
                    {
                        field("Exclude BOMComp.ItemCat Filtr1"; FMIntSetup3."Exclude BOM Cmp ItemCat Filtr1")
                        {
                            Caption = 'Exclude BOM CompItemCat Filtr1';
                            ToolTip = 'Specifies the value of the Exclude BOM CompItemCat Filtr1 field.';

                            //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                            trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                            var
                                locitemCategory: Record "Item Category";
                            begin
                                //HEI.25>>
                                locitemCategory.RESET();
                                if PAGE.RUNMODAL(0, locitemCategory) = ACTION::LookupOK then begin
                                    Text := Text + locitemCategory.Code;
                                    exit(true);
                                end;
                                //HEI.25<<
                            end;
                        }
                        field("Exclude BOMComp.ItemCat Filtr2"; FMIntSetup3."Exclude BOM Cmp ItemCat Filtr2")
                        {
                            Caption = 'Exclude BOM CompItemCat Filtr2';
                            ToolTip = 'Specifies the value of the Exclude BOM CompItemCat Filtr2 field.';

                            //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                            trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                            var
                                locitemCategory: Record "Item Category";
                            begin
                                //HEI.25>>
                                locitemCategory.RESET();
                                if PAGE.RUNMODAL(0, locitemCategory) = ACTION::LookupOK then begin
                                    Text := Text + locitemCategory.Code;
                                    exit(true);
                                end;
                                //HEI.25<<
                            end;
                        }
                        field("Semi Finished Goods WorkCenter"; FMIntSetup3."Semi Finished Goods WorkCenter")
                        {
                            ToolTip = 'Specifies the value of the Semi Finished Goods WorkCenter field.';
                        }
                    }
                }
                grid(Control55139)
                {
                    GridLayout = Rows;
                    group("BOM CMG Filter 1")
                    {
                        //The GridLayout property is only supported on controls of type Grid
                        //GridLayout = Columns;
                        field("InterfSetup2.""BOM CMG Filter"""; InterfSetup2."BOM CMG Filter")
                        {
                            Caption = 'Item Category Code Filter';
                            ToolTip = 'Specifies the value of the Item Category Code Filter field.';

                            //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                            trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                            var
                                locItemCateg: Record "Item Category";
                            begin
                                //HEI.01
                                locItemCateg.RESET();
                                if PAGE.RUNMODAL(0, locItemCateg) = ACTION::LookupOK then begin
                                    Text := Text + locItemCateg.Code;
                                    exit(true);
                                end;
                            end;
                        }
                    }
                    group("BOM CMG Filter Set 1")
                    {
                        //The GridLayout property is only supported on controls of type Grid
                        //GridLayout = Columns;
                        field(ItemCategCode1; InterfSetup2."BOM Item Categ Filter1")
                        {
                            Caption = 'Item Category Code Filter';
                            ToolTip = 'Specifies the value of the Item Category Code Filter field.';

                            //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                            trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                            var
                                locItemCategory: Record "Item Category";
                            begin
                                //HEI.01
                                locItemCategory.RESET();

                                if PAGE.RUNMODAL(0, locItemCategory) = ACTION::LookupOK then begin
                                    Text := Text + locItemCategory.Code;
                                    exit(true);
                                end;
                            end;
                        }
                        field(ItemAttribCode1; InterfSetup2."BOM Item Attr Filter1")
                        {
                            Caption = 'Item Attribute Code Filter';
                            ToolTip = 'Specifies the value of the Item Attribute Code Filter field.';

                            //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                            trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                            var
                                locItemAttribute: Record "Item Attribute";
                            begin
                                //HEI.01
                                locItemAttribute.RESET();
                                if PAGE.RUNMODAL(0, locItemAttribute) = ACTION::LookupOK then begin
                                    Text := Text + FORMAT(locItemAttribute.ID);
                                    exit(true);
                                end;
                            end;
                        }
                        field(ItemAttribValue1; InterfSetup2."BOM ItemAttrValFilter1")
                        {
                            Caption = 'Item Attribute Value Filter';
                            ToolTip = 'Specifies the value of the Item Attribute Value Filter field.';

                            //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                            trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                            var
                                locItemAttribValue: Record "Item Attribute Value";
                            begin
                                //HEI.01
                                locItemAttribValue.RESET();
                                locItemAttribValue.SETRANGE("Attribute ID", InterfSetup2."BOM Item Attr Filter1");
                                if PAGE.RUNMODAL(0, locItemAttribValue) = ACTION::LookupOK then begin
                                    Text := Text + locItemAttribValue.Value;
                                    exit(true);
                                end;
                            end;
                        }
                    }
                    group("BOM CMG Filter Set 2")
                    {
                        field(ItemCategCode2; InterfSetup2."BOM Item Categ Filter2")
                        {
                            Caption = 'Item Category Code Filter';
                            ToolTip = 'Specifies the value of the Item Category Code Filter field.';

                            //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                            trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                            var
                                locitemCategory: Record "Item Category";
                            begin
                                //HEI.01
                                locitemCategory.RESET();
                                if PAGE.RUNMODAL(0, locitemCategory) = ACTION::LookupOK then begin
                                    Text := Text + locitemCategory.Code;
                                    exit(true);
                                end;
                            end;
                        }
                        field(ItemAttribCode2; InterfSetup2."BOM Item Attr Filter2")
                        {
                            Caption = 'Item Attribute Code Filter';
                            ToolTip = 'Specifies the value of the Item Attribute Code Filter field.';

                            //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                            trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                            var
                                locItemAttribute: Record "Item Attribute";
                            begin
                                //HEI.01
                                locItemAttribute.RESET();
                                if PAGE.RUNMODAL(0, locItemAttribute) = ACTION::LookupOK then begin
                                    Text := Text + FORMAT(locItemAttribute.ID);
                                    exit(true);
                                end;
                            end;
                        }
                        field(ItemAttribValue2; InterfSetup2."BOM ItemAttrValFilter2")
                        {
                            Caption = 'Item Attribute Value Filter';
                            ToolTip = 'Specifies the value of the Item Attribute Value Filter field.';

                            //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                            trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                            var
                                locItemAttribValue: Record "Item Attribute Value";
                            begin
                                //HEI.01
                                locItemAttribValue.RESET();
                                locItemAttribValue.SETRANGE("Attribute ID", Rec."StockOnHand Item Attr Filter1");
                                if PAGE.RUNMODAL(0, locItemAttribValue) = ACTION::LookupOK then begin
                                    Text := Text + locItemAttribValue.Value;
                                    exit(true);
                                end;
                            end;
                        }
                    }
                    group("BOM CMG Filter Set 3")
                    {
                        field(ItemCategCode3; InterfSetup2."BOM Item Categ Filter3")
                        {
                            Caption = 'Item Category Code Filter';
                            ToolTip = 'Specifies the value of the Item Category Code Filter field.';

                            //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                            trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                            var
                                locItemCategory: Record "Item Category";
                            begin
                                //HEI.01
                                locItemCategory.RESET();
                                if PAGE.RUNMODAL(0, locItemCategory) = ACTION::LookupOK then begin
                                    Text := Text + locItemCategory.Code;
                                    exit(true);
                                end;
                            end;
                        }
                        field(ItemAttribCode3; InterfSetup2."BOM Item Attr Filter3")
                        {
                            Caption = 'Item Attribute Code Filter';
                            ToolTip = 'Specifies the value of the Item Attribute Code Filter field.';

                            //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                            trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                            var
                                locItemAttribute: Record "Item Attribute";
                            begin
                                //HEI.01
                                locItemAttribute.RESET();
                                if PAGE.RUNMODAL(0, locItemAttribute) = ACTION::LookupOK then begin
                                    Text := Text + FORMAT(locItemAttribute.ID);
                                    exit(true);
                                end;
                            end;
                        }
                        field(ItemAttribValue3; InterfSetup2."BOM ItemAttrValFilter3")
                        {
                            Caption = 'Item Attribute Value Filter';
                            ToolTip = 'Specifies the value of the Item Attribute Value Filter field.';

                            //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                            trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                            var
                                locItemAttribValue: Record "Item Attribute Value";
                            begin
                                //HEI.01
                                locItemAttribValue.RESET();
                                locItemAttribValue.SETRANGE("Attribute ID", Rec."StockOnHand Item Attr Filter1");
                                if PAGE.RUNMODAL(0, locItemAttribValue) = ACTION::LookupOK then begin
                                    Text := Text + locItemAttribValue.Value;
                                    exit(true);
                                end;
                            end;
                        }
                    }
                }
            }
            group(PurchOrders)
            {
                Caption = 'SP Purchase Requisition';
                field("InterfSetup2.""PurchOrds WksTempName"""; InterfSetup2."PurchOrds WksTempName")
                {
                    Caption = 'Worksheet Template Name';
                    TableRelation = "Req. Wksh. Template";
                    ToolTip = 'Specifies the value of the Worksheet Template Name field.';

                    //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                    trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                    var
                        locReqWkshTemp: Record "Req. Wksh. Template";
                    begin
                        //HEI.01
                        locReqWkshTemp.RESET();
                        if PAGE.RUNMODAL(0, locReqWkshTemp) = ACTION::LookupOK then begin
                            Text := locReqWkshTemp.Name;
                            exit(true);
                        end;
                    end;
                }
                field("InterfSetup2.PurchOrdsJournBatchName"; InterfSetup2.PurchOrdsJournBatchName)
                {
                    Caption = 'Journal Batch Name';
                    ToolTip = 'Specifies the value of the Journal Batch Name field.';

                    //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                    trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                    var
                        locWkTempName: Record "Requisition Wksh. Name";
                    begin
                        //HEI.01
                        locWkTempName.RESET();
                        locWkTempName.SETRANGE("Worksheet Template Name", InterfSetup2."PurchOrds WksTempName");
                        if PAGE.RUNMODAL(0, locWkTempName) = ACTION::LookupOK then begin
                            Text := locWkTempName.Name;
                            exit(true);
                        end;
                    end;
                }
            }
            group(ProdOrders)
            {
                Caption = 'SP Production Orders';
                field("InterfSetup2.""ProdOrds WksTempName"""; InterfSetup2."ProdOrds WksTempName")
                {
                    Caption = 'Worksheet Template Name';
                    TableRelation = "Req. Wksh. Template";
                    ToolTip = 'Specifies the value of the Worksheet Template Name field.';

                    //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                    trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                    var
                        locReqWkshTemp: Record "Req. Wksh. Template";
                    begin
                        //HEI.01
                        locReqWkshTemp.RESET();
                        if PAGE.RUNMODAL(0, locReqWkshTemp) = ACTION::LookupOK then begin
                            Text := locReqWkshTemp.Name;
                            exit(true);
                        end;
                    end;
                }
                field("InterfSetup2.ProdOrdsJournBatchName"; InterfSetup2.ProdOrdsJournBatchName)
                {
                    Caption = 'Journal Batch Name';
                    ToolTip = 'Specifies the value of the Journal Batch Name field.';

                    //trigger OnLookup(Text: Text): Boolean;  // BC Upgrade NANDIS03
                    trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                    var
                        locWkTempName: Record "Requisition Wksh. Name";
                    begin
                        //HEI.01
                        locWkTempName.RESET();
                        locWkTempName.SETRANGE("Worksheet Template Name", InterfSetup2."PurchOrds WksTempName");
                        if PAGE.RUNMODAL(0, locWkTempName) = ACTION::LookupOK then begin
                            Text := locWkTempName.Name;
                            exit(true);
                        end;
                    end;
                }
            }
            group("StockTO Virtual Filters")
            {
                Caption = 'SP Stock Transport Order Virtual Location Filters';
                field("InterfSetup2.""StockTOVirtual Category Filter"""; InterfSetup2."StockTOVirtual Category Filter")
                {
                    Caption = 'Item Category  Filter';
                    Description = 'HEI.18';
                    ToolTip = 'Specifies the value of the Item Category  Filter field.';
                }
                field("InterfSetup2.""StockTOVirtual Location Filter"""; InterfSetup2."StockTOVirtual Location Filter")
                {
                    Caption = 'Location Filter';
                    Description = 'HEI.18';
                    ToolTip = 'Specifies the value of the Location Filter field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        //>>HEI.01
        if not Rec.GET() then begin  // BC Upgrade NANDIS03 - Added Rec
            Rec.INIT();  // BC Upgrade NANDIS03 - Added Rec
            Rec.INSERT();  // BC Upgrade NANDIS03 - Added Rec
        end;

        InterfSetup2.RESET();
        if not InterfSetup2.GET() then begin
            InterfSetup2.INIT();
            InterfSetup2.INSERT();
        end;
        //<<HEI.01
        //>>HEI.24
        if not FMIntSetup3.GET() then begin
            FMIntSetup3.INIT();
            FMIntSetup3.INSERT();
        end;
        //<<HEI.24
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        //>>HEI.01
        if InterfSetup2.MODIFY() then;
        //<<HEI.01
        if FMIntSetup3.MODIFY() then;//HEI.24
    end;

    var
        TempItemAtrribValue: Record "Item Attribute Value" temporary;
        Item: Record Item;
        ItemAttribValueMapp: Record "Item Attribute Value Mapping";
        ItemAtrribValue: Record "Item Attribute Value";
        ItemAtrrib: Record "Item Attribute";
        NumItemCategCode: Integer;
        InterfSetup2: Record "FuturMaster Interf Setup_2 INT";
        FMIntSetup3: Record "FuturMaster Interf. Stp 3 INT";
}

