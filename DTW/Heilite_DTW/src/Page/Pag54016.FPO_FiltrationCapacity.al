page 54016 "FPO - Filtration Capacity"
{//BC Upgrade Kamnay01 Original(Heilite) page id 50196
    // version Role,HEI.02

    // DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 Added fields 2014410 "Responsibility Center"
    //                                                        2014411 "Physical Location Group Code"
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-PRDGAP039 IBM.HORTOC01 13/07/2017
    //   # Page action ProcessOrderGoodsMovement
    // HEI.02 defect #1543 POSTOI01 26.02.2018
    //   #change filtering in OnOpenPage trigger from Decsription to Description 2
    // HEI.03 RFC-CHG0255624 IBM.LS 16.11.2018
    //   # Code added to execute filters correctly.
    //   # Added "Zone Code" field in page.
    // HEI.04 CHG0270593 - IBM ISYED01 2.15.2019
    //   # When more than one Lot No is found for the same one line/ 1 Prod. Order description “Multiple” should be displayed
    //     # added Gyle no to the page
    // HEI.05 CHG2013123 IBM GAVANM01 01/11/2019
    //   # new global variable ILEStrengthSpecValue
    //   # new column ILEStrengthSpecValue
    //   # code added in OnAfterGetRecord()
    // HEI.07 CHG2069358 IBM.AK 25.08.20
    //  # new field added on -"Created By"
    // HEI.08 CHG2098891 IBM.LS      19.07.2021
    //   # Added Field - Blocked (Caption: Admin. Completed)
    //   # Moved Field - Blocked after No.

    //Bc Upgrade YADAVM09 Drink it field and code commented.
    //Bc Upgrade YADAVM09 Caption added for blocked field.
    //Bc Upgrade YADAVM09 Application Area Property added for page and fields.
    //Bc Upgrade YADAVM09 Promoted property change false to true for below action to handle PromotedCategory property
    // #Prod. Order - Detail Calc.
    // #Prod. Order - Precalc. Time
    // #Production Order Job Card
    // #Production Order - Comp. and Routing
    // #Production Order - Picking List
    Caption = 'Finished Production Orders';
    CardPageID = "Finished Production Orders";
    Editable = false;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Production Order";
    SourceTableView = SORTING(Status, "No.")
                      ORDER(Descending)
                      WHERE(Status = CONST(Finished));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    Lookup = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the number of the production order.';
                }
                field(Blocked; Rec.Blocked)
                {
                    Caption = 'Admin. Completed';
                    ApplicationArea = all;
                }
                /* //Bc Upgrade YADAVM09 Drink it field commented>>
                field("Gyle No."; "Gyle No.")
                {
                    CaptionML = ENU = 'Ref No.',
                                FRA = 'Gyle N°';
                }
                */ //Bc Upgrade YADAVM09 Drink it field commented<<
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description of the production order.';
                    ApplicationArea = all;
                }
                field("Source No."; Rec."Source No.")
                {
                    ToolTip = 'Specifies the source number of the production order.';
                    ApplicationArea = all;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ToolTip = 'Specifies the routing number used for this production order.';
                    ApplicationArea = all;
                }
                /* //Bc Upgrade YADAVM09 Drink it field commented>>
                field("Routing Version Code"; Rec."Routing Version Code")
                {
                    Visible = false;
                }
                field("Routing Version Description"; "Routing Version Description")
                {
                    Visible = false;
                }
                field("Production BOM No."; "Production BOM No.")
                {
                    Visible = false;
                }
                field("Production BOM Version Code"; "Production BOM Version Code")
                {
                    Visible = false;
                }
                field("Production BOM Version Desc."; "Production BOM Version Desc.")
                {
                    Visible = false;
                }
                */ //Bc Upgrade YADAVM09 Drink it field<<
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many units of the item or the family to produce (production quantity).';
                }
                field("EXT.[%w/w] (Actual)"; ILEStrengthSpecValue)
                {
                    ApplicationArea = all;
                }
                /* //Bc Upgrade YADAVM09 Drink it field commented>>
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field("Quantity (Base)"; "Quantity (Base)")
                {
                }
                field("Quantity HL"; "Quantity HL")
                {
                }
                */ //Bc Upgrade YADAVM09 Drink it field commented<<
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for the dimension associated with the production order.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for the dimension associated with the production order.';
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location code to which you want to post the finished product from this production order.';
                    Visible = false;
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    ToolTip = 'Specifies the starting time of the production order.';
                    Visible = false;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the starting date of the production order.';
                    ApplicationArea = all;
                }
                field("Ending Time"; Rec."Ending Time")
                {
                    ToolTip = 'Specifies the ending time of the production order.';
                    Visible = false;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ToolTip = 'Specifies the ending date of the production order.';
                    ApplicationArea = all;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies the due date of the production order.';
                    ApplicationArea = all;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                    ApplicationArea = all;
                }
                field("Finished Date"; Rec."Finished Date")
                {
                    ToolTip = 'Specifies the actual finishing date of a finished production order.';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the status of the production order.';
                    ApplicationArea = all;
                }
                field("Search Description"; Rec."Search Description")
                {
                    ToolTip = 'Specifies the search description.';
                    ApplicationArea = all;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ToolTip = 'Specifies when the production order card was last modified.';
                    Visible = false;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies a bin to which you want to post the finished items.';
                    Visible = false;
                }
                /* //Bc Upgrade YADAVM09 Drink it field code commented>>
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Importance = Additional;
                    QuickEntry = false;
                }
                field("Physical Location Group Code"; "Physical Location Group Code")
                {
                    Importance = Additional;
                    QuickEntry = false;
                }
                field("<decFinishedQty>"; decFinishedQty)
                {
                    Caption = 'Finished Quantity';
                    DecimalPlaces = 0 : 5;
                    Description = 'NRQ#72678';
                    Editable = false;
                }
                */ //Bc Upgrade YADAVM09 Drink it field code commented<<
                field("Lot No"; LotNo)
                {
                    ApplicationArea = all;
                }
                field("Created By"; Rec."Created By FND")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Pro&d. Order")
            {
                Caption = 'Pro&d. Order';
                Image = "Order";
                group("E&ntries")
                {
                    Caption = 'E&ntries';
                    Image = Entries;
                    action("Item Ledger E&ntries")
                    {
                        Caption = 'Item Ledger E&ntries';
                        Image = ItemLedger;
                        RunObject = Page "Item Ledger Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                        ShortCutKey = 'Ctrl+F7';
                    }
                    action("Capacity Ledger Entries")
                    {
                        Caption = 'Capacity Ledger Entries';
                        Image = CapacityLedger;
                        RunObject = Page "Capacity Ledger Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                    }
                    action("Value Entries")
                    {
                        Caption = 'Value Entries';
                        Image = ValueLedger;
                        RunObject = Page "Value Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                    }
                    action("&Warehouse Entries")
                    {
                        Caption = '&Warehouse Entries';
                        Image = BinLedger;
                        RunObject = Page "Warehouse Entries";
                        RunPageLink = "Source Type" = FILTER(83 | 5407),
                                      "Source Subtype" = FILTER(3 | 4 | 5),
                                      "Source No." = FIELD("No.");
                        RunPageView = SORTING("Source Type", "Source Subtype", "Source No.");
                    }
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Prod. Order Comment Sheet";
                    RunPageLink = Status = FIELD(Status),
                                  "Prod. Order No." = FIELD("No.");
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction();
                    begin
                        Rec.ShowDocDim();
                    end;
                }
                separator(Separator31)
                {
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Production Order Statistics";
                    RunPageLink = Status = FIELD(Status),
                                  "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter");
                    ShortCutKey = 'F7';
                }
            }
        }
        area(reporting)
        {
            action("Prod. Order - Detail Calc.")
            {
                Caption = 'Prod. Order - Detail Calc.';
                Image = "Report";
                //Promoted = false;//Bc Upgrade YADAVM09
                Promoted = true;//Bc Upgrade YADAVM09
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                PromotedCategory = "Report";
                RunObject = Report "Prod. Order - Detailed Calc.";
            }
            action("Prod. Order - Precalc. Time")
            {
                Caption = 'Prod. Order - Precalc. Time';
                //Promoted = false;//Bc Upgrade YADAVM09
                Promoted = true;//Bc Upgrade YADAVM09
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                PromotedCategory = "Report";
                RunObject = Report "Prod. Order - Precalc. Time";
            }
            action("Production Order - Comp. and Routing")
            {
                Caption = 'Production Order - Comp. and Routing';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Prod. Order Comp. and Routing";
            }
            action(ProdOrderJobCard)
            {
                Caption = 'Production Order Job Card';
                Image = "Report";
                //Promoted = false;//Bc Upgrade YADAVM09
                Promoted = true;//Bc Upgrade YADAVM09
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                PromotedCategory = "Report";

                trigger OnAction();
                begin
                    ManuPrintReport.PrintProductionOrder(Rec, 0);
                end;
            }
            action("Production Order - Picking List")
            {
                Caption = 'Production Order - Picking List';
                Image = "Report";
                //Promoted = false;//Bc Upgrade YADAVM09
                Promoted = true;//Bc Upgrade YADAVM09
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                PromotedCategory = "Report";
                RunObject = Report "Prod. Order - Picking List";
            }
            action(ProdOrderMaterialRequisition)
            {
                Caption = 'Production Order - Material Requisition';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction();
                begin
                    ManuPrintReport.PrintProductionOrder(Rec, 1);
                end;
            }
            action("Production Order List")
            {
                Caption = 'Production Order List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Prod. Order - List";
            }
            action(ProdOrderShortageList)
            {
                Caption = 'Production Order - Shortage List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction();
                begin
                    ManuPrintReport.PrintProductionOrder(Rec, 2);
                end;
            }
            action("Production Order Statistics")
            {
                Caption = 'Production Order Statistics';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Production Order Statistics";
            }
            action(ProcessOrderGoodsMovement)
            {
                Caption = 'Process Order Goods Movement';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction();
                var
                    ProductionOrder: Record "Production Order";
                begin
                    //HEI.01>>
                    ProductionOrder.RESET();
                    ProductionOrder.SETRANGE(ProductionOrder.Status, Rec.Status);
                    ProductionOrder.SETRANGE(ProductionOrder."No.", Rec."No.");
                    //   REPORT.RUN(50003, true, true, ProductionOrder);
                    Report.Run(report::"Process Order Goods Movement", true, true, ProductionOrder);//BC Upgrade GUNREM01, changed report id from 50003 to "Process Order Goods Movement"

                    //HEI.01<<
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        //ILEStrengthSpecValue := HeinekenGlobal.GetStrengthSpecValue(Rec."No."); //HEI.05
        //HEI.04>>//Bc Upgrade YADAVM09 Dependency on drink it field
        LotNo := HeinekenGlobal.GetLotItemTracking(Rec."No.");
        //HEI.04<<
        //<< DITW111.00.13 ISL 13/09/2018 NRQ#84282
        //decFinishedQty := fctCalcQuantityFinished();//Bc Upgrade YADAVM09 Drink it code commented
        //>> DITW111.00.13 ISL NRQ#84282
    end;


    //Bc Upgrade YADAVM09 drink it code commented>>
    // trigger OnNewRecord(BelowxRec: Boolean);
    // begin
    //     //<< DITW111.00.13 ISL 13/09/2018 NRQ#84282
    //     decFinishedQty := 0;
    //     //>> DITW111.00.13 ISL NRQ#84282
    // end;
    //Bc Upgrade YADAVM09 drink it code commented<<
    trigger OnOpenPage();
    begin
        // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        //Rec.SetSecurityFilterOnRespCenter();//Bc Upgrade YADAVM09 drink it code commented
        // >>DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        GeneralOpCoSetup.GET();

        Rec.SETFILTER("Location Code", GeneralOpCoSetup."RC Location Code");
        //HEI.03>>
        //SETFILTER("Zone Code",'%1',GeneralOpCoSetup."RC F&Mix Zone Code");
        Rec.SETFILTER("Zone Code FND", GeneralOpCoSetup."RC F&Mix Zone Code");
        //HEI.03<<
        //HEI.02 SETFILTER(Description,'%1','@*filtration*');
        //HEI.02+
        Rec.SETFILTER("Description 2", '%1', '@*filtration*');
        //HEI.02-
    end;

    var
        ManuPrintReport: Codeunit "Manu. Print Report";
        UserMgt: Codeunit "User Setup Management";
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        decFinishedQty: Decimal;
        LotNo: Text[50];
        HeinekenGlobal: Codeunit "Heineken Global";
        ILEStrengthSpecValue: Code[10];
}

