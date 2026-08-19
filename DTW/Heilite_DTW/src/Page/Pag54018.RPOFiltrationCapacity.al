
page 54018 "RPO Filtration Capacity"
//page 50198 "RPO <> Filtration Capacity"//Bc Upgrade YADAVM09 Page anme change
//BC Upgrade Kamnay01 Original(Heilite) page id 50198
{
    // version Role,HEI.04

    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM
    // DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 Added fields 2014410 "Responsibility Center"
    //                                                        2014411 "Physical Location Group Code"
    // 
    // MANXL7.00.001 DAT 04/03/2014 #13: Prod. Order KPI's in overview screen
    // MANXL7.00.001 WSA 11/07/2014 #87: Added code MANXL security
    // 
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Added "Losses" & "Register Loss Strength Journal" ribbon button
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-PRDGAP039 IBM.HORTOC01 13/07/2017
    //   # Page action ProcessOrderGoodsMovement
    // HEI.02 FDD-PRDGAP024 IBM SOICAD01 25.07.2017 #Zone code development without whs advanced mgmt
    //   #new fields Zone Code
    //   #set table relation from Bin Code field:  Bin.Code WHERE (Location Code=FIELD(Location Code),Zone Code=FIELD(Zone Code))
    // HEI.03 defect #1543 POSTOI01 26.02.2018
    //   #change filtering in OnOpenPage trigger from Decsription to Description 2
    // HEI.04 Defect #2799 IBM NASTAA02 24.09.2018 # Wort RPO tile not acesible
    //   # Added column decFinishedQty, adjusted fctCalcQuantityPlannedVsAct
    // HEI.05 RFC-CHG0255624 IBM.LS 16.11.2018
    //   # Code added to execute filters correctly.
    // HEI.06 CHG0270593 - IBM ISYED01 2.15.2019
    //   # When more than one Lot No is found for the same one line/ 1 Prod. Order description “Multiple” should be displayed
    //   # added Gyle no to the page
    // HEI.07 CHG2013123 IBM GAVANM01 01/11/2019
    //   # new global variable ILEStrengthSpecValue
    //   # new column ILEStrengthSpecValue
    //   # code added in OnAfterGetRecord()
    // HEI.08 CHG2069358 IBM.AK 25.08.20
    //  # new field added on -"Created By"
    // HEI.09 CHG2098891 IBM.LS      19.07.2021
    //   # Added Field - Blocked (Caption: Admin. Completed)
    //   # Moved Field - Blocked after No.

    //Bc Upgrade YADAVM09 Drink it field and code commented.
    //Bc Upgrade YADAVM09 Application area property added for page and field.
    //Bc Upgrade YADAVM09 caption added Admin. Completed.
    //Bc Upgrade YADAVM09 page action property prooted changes false to true for below action:
    // #Prod. Order - Detail Calc.
    // #Prod. Order - Precalc. Time
    // #Production Order - Comp. and Routing"
    // #Production Order Job Card
    // #Production Order - Picking List
    //Bc Upgrade YADAVM09 page name and caption changed

    //Caption = 'Released Production Orders';//Bc Upgrade YADAVM09
    Caption = 'RPO Filtration Capacity';//Bc Upgrade YADAVM09
    CardPageID = "Released Production Order";
    ApplicationArea = all;
    Editable = false;
    PageType = List;
    SourceTable = "Production Order";
    SourceTableView = SORTING(Status, "No.")
                      ORDER(Descending)
                      WHERE(Status = CONST(Released));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Lookup = false;
                    ToolTip = 'Specifies the number of the production order.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = all;
                }
                /* //Bc Upgrade YADAVM09 Drink it field commented>>
                field("Gyle No."; "Gyle No.")
                {
                    CaptionML = ENU = 'Ref No.',
                                FRA = 'Gyle N°';
                }
                */ //Bc Upgrade YADAVM09 drink it field commented<<
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the description of the production order.';
                }
                field("Source No."; Rec."Source No.")
                {
                    ToolTip = 'Specifies the source number of the production order.';
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ToolTip = 'Specifies the routing number used for this production order.';
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
                */ //Bc Upgrade YADAVM09 Drink it field commented<<
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies how many units of the item or the family to produce (production quantity).';
                }
                /* //Bc Upgrade YADAVM09 Drink it field commented>>
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea=all;
                }
                field("Quantity (Base)"; "Quantity (Base)")
                {
                }
                field("Quantity HL"; "Quantity HL")
                {
                }
                */ // Bc Upgrade YADAVM09 Drink it field commented<<
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
                    ToolTip = 'Specifies when the production order card was last modified.';
                    Visible = false;
                }
                field("Zone Code"; Rec."Zone Code FND")
                {
                    ApplicationArea = all;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"),
                                                    "Zone Code" = FIELD("Zone Code FND"));
                    ToolTip = 'Specifies a bin to which you want to post the finished items.';
                    Visible = false;
                }
                field(decPlannedQty; decPlannedQty)
                {
                    Caption = 'Planned Quantity';
                    DecimalPlaces = 0 : 5;
                    Description = 'MANXL7.00.001';
                    Editable = false;
                }
                field("<decFinishedQty>"; decFinishedQty)
                {
                    Caption = 'Finished Quantity';
                    DecimalPlaces = 0 : 5;
                    Description = 'HEI.03';
                    Editable = false;
                }
                field("EXT.[%w/w] (Actual)"; ILEStrengthSpecValue)
                {
                    ApplicationArea = all;
                }
                field("Lot No"; LotNo)
                {
                    ApplicationArea = all;
                }
                /* //Bc Upgrade YADAVM09 Drink it field commented>>
                field(decActualVsPlannedQty; decActualVsPlannedQty)
                {
                    Caption = 'Actual Produced Quantity';
                    Description = 'MANXL7.00.001';
                    ExtendedDatatype = Ratio;
                    MaxValue = 100;
                    MinValue = 0;
                    ToolTip = 'Actual Produced Quantity';
                }
                field(decPlannedOperations; decPlannedOperations)
                {
                    Caption = 'Planned Operations';
                    DecimalPlaces = 0 : 5;
                    Description = 'MANXL7.00.001';
                    Editable = false;
                }
                field(decActualVsPlannedOperations; decActualVsPlannedOperations)
                {
                    Caption = 'Actual Executed Operations';
                    Description = 'MANXL7.00.001';
                    ExtendedDatatype = Ratio;
                    MaxValue = 100;
                    MinValue = 0;
                    ToolTip = 'Actual Executed Operations';
                }
                field(decPlannedHours; decPlannedHours)
                {
                    Caption = 'Planned Operation Hours';
                    DecimalPlaces = 0 : 5;
                    Description = 'MANXL7.00.001';
                    Editable = false;
                }
                field(decActualVsPlannedHours; decActualVsPlannedHours)
                {
                    Caption = 'Actual Consumed Hours';
                    Description = 'MANXL7.00.001';
                    ExtendedDatatype = Ratio;
                    MaxValue = 100;
                    MinValue = 0;
                    ToolTip = 'Actual Consumed Hours';
                }
                field(decPlannedSubcontract; decPlannedSubcontract)
                {
                    Caption = 'Planned Subcontractor Tasks';
                    DecimalPlaces = 0 : 5;
                    Description = 'MANXL7.00.001';
                    Editable = false;
                }
                field(decActualVsPlannedSubcontract; decActualVsPlannedSubcontract)
                {
                    Caption = 'Ordered Subcontractor Tasks';
                    Description = 'MANXL7.00.001';
                    ExtendedDatatype = Ratio;
                    MaxValue = 100;
                    MinValue = 0;
                    ToolTip = 'Ordered Subcontractor Tasks';
                }
                field(decPlannedCritical; decPlannedCritical)
                {
                    Caption = 'Planned Critical Components';
                    DecimalPlaces = 0 : 5;
                    Description = 'MANXL7.00.001';
                    Editable = false;
                }
                field(decActualVsPlannedCritical; decActualVsPlannedCritical)
                {
                    Caption = 'Critical Components Available';
                    Description = 'MANXL7.00.001';
                    ExtendedDatatype = Ratio;
                    MaxValue = 100;
                    MinValue = 0;
                    ToolTip = 'Critical Components Available';
                }
                field(decExpectedVsActualCost; decExpectedVsActualCost)
                {
                    Caption = 'Expected Cost vs Actual Cost';
                    Description = 'MANXL7.00.001';
                    ExtendedDatatype = Ratio;
                    MaxValue = 100;
                    MinValue = 0;
                    ToolTip = 'Expected Cost vs Actual Cost';
                }
                field(decStandardVsExpectedCost; decStandardVsExpectedCost)
                {
                    Caption = 'Standard Cost vs Expected Cost';
                    Description = 'MANXL7.00.001';
                    ExtendedDatatype = Ratio;
                    MaxValue = 100;
                    MinValue = 0;
                    ToolTip = 'Standard Cost vs Expected Cost';
                }
                field(decStandardVsActualCost; decStandardVsActualCost)
                {
                    Caption = 'Standard Cost vs Actual Cost';
                    Description = 'MANXL7.00.001';
                    ExtendedDatatype = Ratio;
                    MaxValue = 100;
                    MinValue = 0;
                    ToolTip = 'Standard Cost vs Actual Cost';
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    Importance = Additional;
                    QuickEntry = false;
                }
                field("Physical Location Group Code"; "Physical Location Group Code")
                {
                    Importance = Additional;
                    QuickEntry = false;
                }
                */ //Bc Upgrade YADAVM09 Drink it field commented<<
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
                separator(Separator1100910002)
                {
                }
                /* //BC Upgrade YADAVM09 Drink it code commented>>
                action(Losses)
                {
                    Caption = 'Losses';
                    Image = GainLossEntries;

                    trigger OnAction();
                    var
                        CapacityLedgerEntry: Record "Capacity Ledger Entry";
                        BrewingLosses: Page "Brewing Losses";
                    begin
                        // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008
                        // <<DITW17.00.01 KCO 18/03/2013 DIT-770 #001
                        CapacityLedgerEntry.SETRANGE("Order Type", CapacityLedgerEntry."Order Type"::Production);
                        CapacityLedgerEntry.SETRANGE("Order No.", Rec."No.");
                        // >>DITW17.00.01 KCO DIT-770 #001
                        BrewingLosses.SETTABLEVIEW(CapacityLedgerEntry);
                        BrewingLosses.RUNMODAL;
                        // >>DITW15.00.00.22 PRODW14.00.00.08 DDR
                    end;
                }
                */
                //BC Upgrade YADAVM09 Drink it code commented<<
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
                    Ellipsis = true;
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
                action("Create Inventor&y Put-away/Pick/Movement")
                {
                    Caption = 'Create Inventor&y Put-away/Pick/Movement';
                    Ellipsis = true;
                    Image = CreatePutAway;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction();
                    begin
                        Rec.CreateInvtPutAwayPick();
                    end;
                }
                /*  //Bc Upgrade YADAVM09 Drink it Action commented>>
               action("Print SSCC")
               {
                   Caption = 'Print SSCC';

                   trigger OnAction();
                   var
                       lfrmPrintLabels: Page "Print Labels";
                   begin
                       // <<DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806
                       lfrmPrintLabels.SetProdOrder(Rec);
                       lfrmPrintLabels.RUNMODAL();
                       // >>DITW16.00.00.43 RBE DIT-715 #806
                   end;
               }
                */  //Bc Upgrade YADAVM09 Drink it Action commented<<
                /*  //Bc Upgrade YADAVM09 Drink it Action commented>>
                separator(Separator1100910001)
                {
                }
                
                action("Register Loss Strength Journal")
                {
                    Caption = 'Register Loss Strength Journal';
                    Ellipsis = true;
                    Image = OpenJournal;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction();
                    begin
                        // <<DITW19.00.08 DDR 20/10/2016 BL#10443
                        OpenLossOutputJournal;
                    end;

                }
                 */  //Bc Upgrade YADAVM09 Drink it Action commented<<
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
                    //REPORT.RUN(50003, true, true, ProductionOrder);
                    Report.Run(report::"Process Order Goods Movement", true, true, ProductionOrder);//BC Upgrade GUNREM01, changed report id from 50003 to "Process Order Goods Movement"

                    //HEI.01<<
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        /* //Bc Upgrade YADAVM09 Drink it field commented>>
        //<<MANXL7.00.001 WSA 11/07/2014 #87
        if rMANXLSetup.READPERMISSION then begin
            //>>MANXL7.00.001 WSA 11/07/2014 #87
            //<<MANXL7.00.001 DAT 04/03/2014 #13
            decActualVsPlannedQty := fctCalcQuantityPlannedVsAct(decPlannedQty, decFinishedQty); //HEI.04
            decActualVsPlannedOperations := fctCalcOperationsPlannedVsAct(decPlannedOperations);
            decActualVsPlannedHours := fctCalcHoursPlannedVsAct(decPlannedHours);
            decActualVsPlannedSubcontract := fctCalcSubcontrPlannedVsAct(decPlannedSubcontract);
            decActualVsPlannedCritical := fctCalcCriticalPlannedVsAct(decPlannedCritical);
            fctCalcStatisticalInfo(decActualCost, decStandardCost, decExpectedCost, decStandardVsActualCost, decStandardVsExpectedCost,
                                   decExpectedVsActualCost);
            //>>MANXL7.00.001 DAT 04/03/2014 #13
            //<<MANXL7.00.001 WSA 11/07/2014 #87
        end;
        //>>MANXL7.00.001 WSA 11/07/2014 #87
        */ //Bc Upgrade YADAVM09 Drink it field commented<<
        //HEI.06>>
        LotNo := HeinekenGlobal.GetLotItemTracking(Rec."No.");
        //HEI.06<<
        // ILEStrengthSpecValue := HeinekenGlobal.GetStrengthSpecValue("No."); //HEI.07//Bc Upgrade YADAVM09 Dependency on drink it field
    end;
    /*  //Bc Upgrade YADAVM09 Drink it code commented>>
       trigger OnNewRecord(BelowxRec: Boolean);
       begin
           //<<MANXL7.00.001 WSA 11/07/2014 #87
           if rMANXLSetup.READPERMISSION then begin
               //>>MANXL7.00.001 WSA 11/07/2014 #87
               //<<MANXL7.00.001 DAT 04/03/2014 #13
               decActualVsPlannedQty := 0;
               decPlannedQty := 0;
               decFinishedQty := 0; //HEI.04
               decActualVsPlannedOperations := 0;
               decPlannedOperations := 0;
               decActualVsPlannedHours := 0;
               decPlannedHours := 0;
               decActualVsPlannedSubcontract := 0;
               decPlannedSubcontract := 0;
               decActualVsPlannedCritical := 0;
               decPlannedCritical := 0;
               decActualCost := 0;
               decStandardCost := 0;
               decExpectedCost := 0;
               decStandardVsActualCost := 0;
               decStandardVsExpectedCost := 0;
               decExpectedVsActualCost := 0;
               //>>MANXL7.00.001 DAT 04/03/2014 #13
               //<<MANXL7.00.001 WSA 11/07/2014 #87
           end;
           //>>MANXL7.00.001 WSA 11/07/2014 #87
       end;
        */  //Bc Upgrade YADAVM09 Drink it Action commented<<

    trigger OnOpenPage();
    begin
        // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        //SetSecurityFilterOnRespCenter(); //Bc Upgrade YADAVM09 Drink it code commented
        // >>DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        GeneralOpCoSetup.GET();

        Rec.SETFILTER("Location Code", GeneralOpCoSetup."RC Location Code");
        //HEI.05>>
        //SETFILTER("Zone Code",'%1',GeneralOpCoSetup."RC F&Mix Zone Code");
        Rec.SETFILTER("Zone Code FND", GeneralOpCoSetup."RC F&Mix Zone Code");
        //HEI.05<<
        Rec.SETFILTER("Description 2", '<>%1', '@*filtration*'); //HEI.03
    end;

    var
        UserMgt: Codeunit "User Setup Management";
        decPlannedQty: Decimal;
        decFinishedQty: Decimal;
        decActualVsPlannedQty: Decimal;
        decPlannedOperations: Decimal;
        decActualVsPlannedOperations: Decimal;
        decPlannedHours: Decimal;
        decActualVsPlannedHours: Decimal;
        decPlannedSubcontract: Decimal;
        decActualVsPlannedSubcontract: Decimal;
        decPlannedCritical: Decimal;
        decActualVsPlannedCritical: Decimal;
        decActualCost: Decimal;
        decStandardCost: Decimal;
        decExpectedCost: Decimal;
        decStandardVsActualCost: Decimal;
        decStandardVsExpectedCost: Decimal;
        decExpectedVsActualCost: Decimal;
        //rMANXLSetup: Record "Manufacturing XL Setup";//Bc Upgrade YADAVM09 Drink it table commented
        ManuPrintReport: Codeunit "Manu. Print Report";
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        LotNo: Text[50];
        HeinekenGlobal: Codeunit "Heineken Global";
        ILEStrengthSpecValue: Code[10];
}

