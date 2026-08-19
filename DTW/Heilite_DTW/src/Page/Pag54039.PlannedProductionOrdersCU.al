page 54039 "Planned Production Orders - CU"
{
    // version Role

    // FINXL8.00.001 BSA 05/06/2015 #182: Added Field "Emergency Order"
    // 
    // DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 Added fields 2014410 "Responsibility Center"
    //                                                        2014411 "Physical Location Group Code"
    // DITW18.00.06 MSF 03/03/2015 DIT-770 #1192 Bug Fix
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // BC Upgrade BHARDA11 >>
    // 1. OLD Page ID -  50179.
    // 2. Remove Drink-IT Fields and related customization("Unit of Measure Code", "Quantity (Base)", "Quantity HL", "Responsibility Center", "Physical Location Group Code", "Emergency Order")
    // 3. Add ApplicationArea and UsageCategory property in page and ApplicationArea Property in all fields ,Actions and Part.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Planned Production Orders';
    CardPageID = "Planned Production Order";
    Editable = false;
    PageType = List;
    SourceTable = "Production Order";
    SourceTableView = WHERE(Status = CONST(Planned));

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
                field(Description; REc.Description)
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
                // BC Upgrade BHARAD11 >> ----Drink-IT Fields("Unit of Measure Code", "Quantity (Base)", "Quantity HL")
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
                // BC Upgrade BHARAD11 << ----Drink-IT Fields("Unit of Measure Code", "Quantity (Base)", "Quantity HL")

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

                    trigger OnValidate();
                    begin
                        // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
                        // BC Upgrade BHARAD11 >> ----Drink-IT Customization
                        // if "Location Code" <> xRec."Location Code" then
                        //     CurrPage.UPDATE(true);
                        // BC Upgrade BHARAD11 << ----Drink-IT Customization
                        // >>DITW18.00.06 MSF DIT-770 #1192
                    end;
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
                // BC Upgrade BHARAD11 >> ----Drink-IT Field("Emergency Order")
                // field("Emergency Order"; Rec."Emergency Order")
                // {
                //     ApplicationArea = All;
                // }
                // BC Upgrade BHARAD11 << ----Drink-IT Field("Emergency Order")

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
                // BC Upgrade BHARAD11 >> ----Drink-IT Fields("Responsibility Center", "Physical Location Group Code")
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
                // BC Upgrade BHARAD11 << ----Drink-IT Fields("Responsibility Center", "Physical Location Group Code")

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
                    ApplicationArea = All;
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
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Change &Status")
                {
                    ApplicationArea = All;
                    Caption = 'Change &Status';
                    Image = ChangeStatus;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Codeunit "Prod. Order Status Management";
                }
                action("&Update Unit Cost")
                {
                    ApplicationArea = All;
                    Caption = '&Update Unit Cost';
                    Ellipsis = true;
                    Image = UpdateUnitCost;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction();
                    var
                        ProdOrder: Record "Production Order";
                    begin
                        ProdOrder.SETRANGE(Status, Rec.Status);
                        ProdOrder.SETRANGE("No.", Rec."No.");

                        REPORT.RUNMODAL(REPORT::"Update Unit Cost", true, true, ProdOrder);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        // SetSecurityFilterOnRespCenter(); // BC Upgrade BHARDA11 ----Drink-IT Customization
        // >>DITW18.00.06 MSF 26/02/2015 DIT-770 #1192

        GeneralOpCoSetup.GET();

        Rec.SETFILTER("Location Code", GeneralOpCoSetup."RC Location Code");
        Rec.SETFILTER("Zone Code FND", GeneralOpCoSetup."RC Brewing Zone code");
    end;

    var
        UserMgt: Codeunit "User Setup Management";
        GeneralOpCoSetup: Record "General OpCo Setup FND";
}

