page 54017 "FPPO Filtration Capacity"
//page 50197 "FPPO <>  Filtration Capacity"//Bc Upgrade YADAVM09 Page name change.
//BC Upgrade Kamnay01 Original(Heilite) page id 50197
{
    // version Role,HEI.03

    // DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 Added fields 2014410 "Responsibility Center"
    //                                                        2014411 "Physical Location Group Code"
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-PRDGAP034 IBM HORTOC01 22.06.2017
    //     # add new action - importfirmprodorder
    // HEI.02 FDD-PRDGAP024 IBM SOICAD01 25.07.2017 #Zone code development without whs advanced mgmt
    //   #new fields Zone Code
    // HEI.03 defect #1543 POSTOI01 26.02.2018
    //   #change filtering in OnOpenPage trigger from Decsription to Description 2
    // HEI.04 RFC-CHG0255624 IBM.LS 16.11.2018
    //   # Code added to execute filters correctly.
    // HEI.05 CHG2069358 IBM.AK 25.08.20
    //  # new field added on -"Created By"

    //Bc Upgrade YADAVM09 Drink it field and code commented.
    //Bc Upgrade YADAVM09 Application Area property added for page and fields.
    //Bc Upgrade YADAVM09 Page action promoted property changes from false to true for below action:
    // #Prod. Order - Detail Calc.
    // #Prod. Order - Precalc. Time
    // #Production Order List
    // #Production Order Statistics
    //Bc Upgrade YADAVM09 page name name and caption changed.

    // Caption = 'Firm Planned Prod. Orders';//Bc Upgrade YADAVM09
    Caption = 'FPPO Filtration Capacity';//Bc Upgrade YADAVM09
    CardPageID = "Firm Planned Prod. Order";
    Editable = false;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Production Order";
    SourceTableView = SORTING(Status, "No.")
                      ORDER(Descending)
                      WHERE(Status = CONST("Firm Planned"));

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the description of the production order.';
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the source number of the production order.';
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the routing number used for this production order.';
                }
                /* //Bc Upgrade YADAVM09 Drink it field commented>>
                field("Routing Version Code";Rec."Routing Version Code")
                {
                    Visible = false;
                }
                field("Routing Version Description";"Routing Version Description")
                {
                    Visible = false;
                }
                field("Production BOM No.";"Production BOM No.")
                {
                    Visible = false;
                }
                field("Production BOM Version Code";"Production BOM Version Code")
                {
                    Visible = false;
                }
                field("Production BOM Version Desc.";"Production BOM Version Desc.")
                {
                    Visible = false;
                }
                */ //Bc Upgrade YADAVM09 Drink it field commented<<
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies how many units of the item or the family to produce (production quantity).';
                }
                /* //Bc Upgrade YADAVM09 Drink it field Commented>>
                field("Unit of Measure Code";Rec."Unit of Measure Code")
                {
                    ApplicationArea =all;
                }
                field("Quantity (Base)";"Quantity (Base)")
                {
                }
                field("Quantity HL";"Quantity HL")
                {
                }
                */ //Bc Upgrade YADAVM09 Drink it field Commented<<
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the code for the dimension associated with the production order.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the code for the dimension associated with the production order.';
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the location code to which you want to post the finished product from this production order.';
                    Visible = false;
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the starting time of the production order.';
                    Visible = false;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the starting date of the production order.';
                }
                field("Ending Time"; Rec."Ending Time")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the ending time of the production order.';
                    Visible = false;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the ending date of the production order.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the due date of the production order.';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field("Finished Date"; Rec."Finished Date")
                {
                    ToolTip = 'Specifies the actual finishing date of a finished production order.';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the status of the production order.';
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the search description.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies when the production order card was last modified.';
                    Visible = false;
                }
                field("Zone Code"; Rec."Zone Code FND")
                {
                    ApplicationArea = all;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies a bin to which you want to post the finished items.';
                    Visible = false;
                }
                /* //Bc Upgrade YADAVM09 Drink it field and code commented>>
                field("Responsibility Center";"Responsibility Center")
                {
                    Importance = Additional;
                    QuickEntry = false;
                }
                field("Physical Location Group Code";"Physical Location Group Code")
                {
                    Importance = Additional;
                    QuickEntry = false;
                }
                */ //Bc Upgrade YADAVM09 Drink it field and code commented<<
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
                        CurrPage.SAVERECORD();
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
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Change &Status")
                {
                    Caption = 'Change &Status';
                    Image = ChangeStatus;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Codeunit "Prod. Order Status Management";
                }
                action("&Update Unit Cost")
                {
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
                action(ImportFirmProdOrder)
                {
                    Caption = 'Import Firm Prod. Order';
                    Description = 'HEI.01';
                    Image = Import;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Report "Import Firm. Prod. Orders";
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
                Image = "Report";
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
                //Promoted = false;//Bc Upgrade YADAVM09 
                Promoted = true;//Bc Upgrade YADAVM09 
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
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
                //Promoted = false;//Bc Upgrade YADAVM09 
                Promoted = true;//Bc Upgrade YADAVM09 
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                PromotedCategory = "Report";
                RunObject = Report "Production Order Statistics";
            }
        }
    }

    trigger OnOpenPage();
    begin
        // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        //SetSecurityFilterOnRespCenter();//Bc Upgrade YADAVM09 Drink it Function commented
        // >>DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        GeneralOpCoSetup.GET();

        Rec.SETFILTER("Location Code", GeneralOpCoSetup."RC Location Code");
        //HEI.04>>
        //SETFILTER("Zone Code",'%1',GeneralOpCoSetup."RC F&Mix Zone Code");
        Rec.SETFILTER("Zone Code FND", GeneralOpCoSetup."RC F&Mix Zone Code");
        //HEI.04<<
        Rec.SETFILTER("Description 2", '<>%1', '@*filtration*'); //HEI.03
    end;

    var
        ManuPrintReport: Codeunit "Manu. Print Report";
        UserMgt: Codeunit "User Setup Management";
        GeneralOpCoSetup: Record "General OpCo Setup FND";
}

