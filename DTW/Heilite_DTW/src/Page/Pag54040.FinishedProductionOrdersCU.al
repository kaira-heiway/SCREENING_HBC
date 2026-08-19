page 54040 "Finished Production Orders- CU"
{
    // version Role

    // DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 Added fields 2014410 "Responsibility Center"
    //                                                        2014411 "Physical Location Group Code"
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-PRDGAP039 IBM.HORTOC01 13/07/2017
    //   # Page action ProcessOrderGoodsMovement
    // 
    // HEI.02 CHG0270593 - IBM ISYED01 2.15.2019
    //   # When more than one Lot No is found for the same one line/ 1 Prod. Order description “Multiple” should be displayed
    //     # added Gyle no to the page
    // HEI.03 CHG2013123 IBM GAVANM01 01/11/2019
    //   # new global variable ILEStrengthSpecValue
    //   # new column ILEStrengthSpecValue
    //   # code added in OnAfterGetRecord()
    // HEI.04 CHG2069358 IBM.AK 25.08.20
    //  # new field added on -"Created By"
    // HEI.05 CHG2098891 IBM.LS      19.07.2021
    //   # Added Field - Blocked (Caption: Admin. Completed)
    //   # Moved Field - Blocked after No.
    // BC Upgrade BHARDA11 >>
    // 1. OLD PAge ID - 50182.
    // 2. Remove Drink-IT Fields and related code("Gyle No.", "Routing Version Code", "Routing Version Description", "Production BOM No.", "Production BOM Version Code", "Production BOM Version Desc.", "Unit of Measure Code", "Quantity (Base)", "Quantity HL", "Responsibility Center", "Physical Location Group Code")
    // 3. Remove Drink-IT Related customization.
    // 4. Add ApplicationArea property in page , Fields , Part and actions.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Finished Production Orders';
    CardPageID = "Finished Production Order";
    Editable = false;
    PageType = List;
    SourceTable = "Production Order";
    SourceTableView = SORTING(Status, "No.")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Lookup = false;
                    ToolTip = 'Specifies the number of the production order.';
                }
                //BC Upgrade Kamnay01>>field added
                field("Unit of Measure Code"; Rec."Unit of Measure Code FND")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Unit of Measure Code',
                            FRA = 'Code de l''unité de mesure';
                }
                //BC Upgrade Kamnay01<< field added 

                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the production order.';
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source number of the production order.';
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the routing number used for this production order.';
                }

                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many units of the item or the family to produce (production quantity).';
                }
                field("EXT.[%w/w] (Actual)"; ILEStrengthSpecValue)
                {
                    ApplicationArea = All;
                }

                // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Gyle No.", "Routing Version Code", "Routing Version Description", "Production BOM No.", "Production BOM Version Code", "Production BOM Version Desc.", "Unit of Measure Code", "Quantity (Base)", "Quantity HL", "Responsibility Center", "Physical Location Group Code")
                //  BC upgrade GUNREM01 >> UnCommented DIT Field >>
                field("Gyle No."; Rec."Gyle No. FND")
                {
                    applicationArea = All;
                    CaptionML = ENU = 'Ref No.',
                            FRA = 'Gyle N°';
                }
                //  BC upgrade GUNREM01 >> UnCommented DIT Field <<
                // field("Routing Version Code"; Rec."Routing Version Code")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Routing Version Description"; Rec."Routing Version Description")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Production BOM No."; Rec."Production BOM No.")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Production BOM Version Code"; Rec."Production BOM Version Code")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Production BOM Version Desc."; Rec."Production BOM Version Desc.")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Unit of Measure Code"; Rec."Unit of Measure Code")
                // {
                //     ApplicationArea = All;
                // }
                // field("Quantity (Base)"; Rec."Quantity (Base)")
                // {
                //     ApplicationArea = All;
                // }
                // field("Quantity HL"; Rec."Quantity HL")
                // {
                //     ApplicationArea = All;
                // }
                // field("Responsibility Center"; Rec."Responsibility Center")
                // {
                //     Importance = Additional;
                //     QuickEntry = false;
                // }
                // field("Physical Location Group Code"; Rec."Physical Location Group Code")
                // {
                //     Importance = Additional;
                //     QuickEntry = false;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Fields("Gyle No.", "Routing Version Code", "Routing Version Description", "Production BOM No.", "Production BOM Version Code", "Production BOM Version Desc.", "Unit of Measure Code", "Quantity (Base)", "Quantity HL", "Responsibility Center", "Physical Location Group Code")
                field("<decFinishedQty>"; decFinishedQty)
                {
                    ApplicationArea = All;
                    Caption = 'Finished Quantity';
                    DecimalPlaces = 0 : 5;
                    Description = 'NRQ#72678';
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for the dimension associated with the production order.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for the dimension associated with the production order.';
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the location code to which you want to post the finished product from this production order.';
                    Visible = false;
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the starting time of the production order.';
                    Visible = false;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the starting date of the production order.';
                }
                field("Ending Time"; Rec."Ending Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ending time of the production order.';
                    Visible = false;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ending date of the production order.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the due date of the production order.';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field("Finished Date"; Rec."Finished Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the actual finishing date of a finished production order.';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the production order.';
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the search description.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the production order card was last modified.';
                    Visible = false;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a bin to which you want to post the finished items.';
                    Visible = false;
                }

                field("Lot No"; LotNo)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By FND")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = All;
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
                        ApplicationArea = All;
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
                        ApplicationArea = All;
                        Caption = 'Capacity Ledger Entries';
                        Image = CapacityLedger;
                        RunObject = Page "Capacity Ledger Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                    }
                    action("Value Entries")
                    {
                        ApplicationArea = All;
                        Caption = 'Value Entries';
                        Image = ValueLedger;
                        RunObject = Page "Value Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                    }
                    action("&Warehouse Entries")
                    {
                        ApplicationArea = All;
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
                    ApplicationArea = ALl;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Prod. Order Comment Sheet";
                    RunPageLink = Status = FIELD(Status),
                                  "Prod. Order No." = FIELD("No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                ApplicationArea = All;
                Caption = 'Prod. Order - Detail Calc.';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Prod. Order - Detailed Calc.";
            }
            action("Prod. Order - Precalc. Time")
            {
                ApplicationArea = All;
                Caption = 'Prod. Order - Precalc. Time';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Prod. Order - Precalc. Time";
            }
            action("Production Order - Comp. and Routing")
            {
                ApplicationArea = All;
                Caption = 'Production Order - Comp. and Routing';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Prod. Order Comp. and Routing";
            }
            action(ProdOrderJobCard)
            {
                ApplicationArea = All;
                Caption = 'Production Order Job Card';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction();
                begin
                    ManuPrintReport.PrintProductionOrder(Rec, 0);
                end;
            }
            action("Production Order - Picking List")
            {
                ApplicationArea = All;
                Caption = 'Production Order - Picking List';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Prod. Order - Picking List";
            }
            action(ProdOrderMaterialRequisition)
            {
                ApplicationArea = All;
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
                ApplicationArea = All;
                Caption = 'Production Order List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Prod. Order - List";
            }
            action(ProdOrderShortageList)
            {
                ApplicationArea = All;
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
                ApplicationArea = All;
                Caption = 'Production Order Statistics';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Production Order Statistics";
            }
            action(ProcessOrderGoodsMovement)
            {
                ApplicationArea = All;
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
                    //  REPORT.RUN(50003, true, true, ProductionOrder);
                    REPORT.RUN(Report::"Process Order Goods Movement", true, true, ProductionOrder);

                    //HEI.01<<
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        //HEI.02>>
        LotNo := HeinekenGlobal.GetLotItemTracking(Rec."No.");
        //HEI.02<<
        //<< DITW111.00.13 ISL 13/09/2018 NRQ#84282
        // BC Upgrade BHARDA11 >>-----Drink-IT Customization
        // decFinishedQty := fctCalcQuantityFinished();
        // ILEStrengthSpecValue := HeinekenGlobal.GetStrengthSpecValue("No.");  //HEI.03
        // BC Upgrade BHARDA11 <<-----Drink-IT Customization
        //>> DITW111.00.13 ISL NRQ#84282
    end;

    trigger OnOpenPage();
    begin
        // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        // SetSecurityFilterOnRespCenter(); // BC Upgrade BHARDA11 -----Drink-IT Customization
        // >>DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        GeneralOpCoSetup.GET();
        Rec.SETFILTER(Status, 'Finished');
        Rec.SETFILTER("Location Code", GeneralOpCoSetup."RC Location Code");
     //   Rec.SETFILTER("Zone Code FND", GeneralOpCoSetup."RC Brewing Zone code");//BC Upgrade GUNREM01 commented Zone code filter
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

