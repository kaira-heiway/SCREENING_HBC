page 54042 "DtW  Bev Prod Shift Leader RC2"
{
    // version Role

    // HEI.01 CHG2070663 IBM POENAB02 18.09.2020 Role Centre Production Bottling Role Centre
    //  # New object created
    // HEI.02 CHG2119213 IBM BHATTA09 02.08.2021
    //   # Quick Access ListPart page added
    //   # My Items and Report Inbox Part pages are removed
    // BC Upgrade BHARDA11 >>
    // 1. OLD Page ID - 50426.
    // 2. Add ApplicationArea property in all actions and parts.
    // 3. Remove all Obsolete pages.
    // BC Upgrade BHARDA11 <<

    // BC Upgrade PATELP08 >> 
    // # Blocking action 'Prod. Order - Calculation' as Report 'Prod. Order - Calculation' is marked for removal and replaced by the report 'Production Order Statistics' but report 'Production Order Statistics' action already exists.
    // # Blocking action 'Work Center List' as Report 'Work Center List' as it is marked for removal and replaced by the page 'Work Center List', but page 'Work Center List' action already exists.
    // # Blocking Promoted property as it can only be used if 'PageType' is: 'Card,Document,List,ListPlus,Worksheet' and current page is Rolecenter and rolecenter does not support Promoted property.
    // BC Upgrade PATELP08 <<

    ApplicationArea = All;
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                part(Control1905113808; "DtW Bev Prod Shift Leader Act2")
                {
                    ApplicationArea = All;
                }
            }
            group(Control1900724708)
            {
                part(Control54; "My Job Queue")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                // BC Upgrade BHARDA11 >> ----Page "Quick Access" and  "Connect Online" obsolete in BC

                // part("Quick Access"; "Quick Access")
                // {
                //     ApplicationArea = All;
                // }
                // part(Control1903012608; "Connect Online")
                // {
                //     ApplicationArea = All;
                // }
                // BC Upgrade BHARDA11 << ----Page "Quick Access" and  "Connect Online" obsolete in BC

                systempart(Control1901377608; MyNotes)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Inventory - List")
            {
                ApplicationArea = All;
                Caption = 'Inventory - List';
                Image = "Report";
                RunObject = Report "Inventory - List";
            }
            action("Item Register - Quantity")
            {
                ApplicationArea = All;
                Caption = 'Item Register - Quantity';
                Image = ItemAvailability;
                RunObject = Report "Item Register - Quantity";
            }
            action("Inventory - Transaction Detail")
            {
                ApplicationArea = All;
                Caption = 'Inventory - Transaction Detail';
                Image = "Report";
                RunObject = Report "Inventory - Transaction Detail";
            }
            action("Inventory Availability")
            {
                ApplicationArea = All;
                Caption = 'Inventory Availability';
                Image = "Report";
                RunObject = Report "Inventory Availability";
            }
            action(Status)
            {
                ApplicationArea = All;
                Caption = 'Status';
                Image = "Report";
                RunObject = Report Status;
            }
            separator(Separator111)
            {
            }
            action("Inventory - Availability Plan")
            {
                ApplicationArea = All;
                Caption = 'Inventory - Availability Plan';
                Image = "Report";
                RunObject = Report "Inventory - Availability Plan";
            }
            action("Phys. Inventory List")
            {
                ApplicationArea = All;
                Caption = 'Phys. Inventory List';
                Image = "Report";
                RunObject = Report "Phys. Inventory List";
            }
            separator(Separator113)
            {
            }
            action("Fixed Asset - List")
            {
                ApplicationArea = All;
                Caption = 'Fixed Asset - List';
                Image = "Report";
                RunObject = Report "Fixed Asset - List";
            }
            action("<Report Item - Able to Make ")
            {
                ApplicationArea = All;
                Caption = 'Item - Able to Make (Timeline)';
                Image = "Report";
                RunObject = Report "Item - Able to Make (Timeline)";
            }
            action("Movement List")
            {
                ApplicationArea = All;
                Caption = 'Movement List';
                Image = "Report";
                RunObject = Report "Movement List";
            }
            action("<Report Whse. Phys. Inv. List")
            {
                ApplicationArea = All;
                Caption = 'Whse. Phys. Inventory List';
                Image = "Report";
                RunObject = Report "Whse. Phys. Inventory List";
            }
            separator("Inventory &Valuation WIP")
            {

                Caption = 'Inventory &Valuation WIP';
            }
            action("<Report Process Order Goods Mov.")
            {
                ApplicationArea = All;
                Caption = 'Process Order Goods Movement';
                Image = "Report";
                RunObject = Report "Process Order Goods Movement";
            }
            action("<Item Availability by Quality")
            {
                ApplicationArea = All;
                Caption = 'Item Availability by Quality';
                Image = "Report";
                RunObject = Report "Item Availability by Qua CBN";
            }
            action("Detailed Calculation")
            {
                ApplicationArea = All;
                Caption = 'Detailed Calculation';
                Image = "Report";
                RunObject = Report "Detailed Calculation";
            }
            // BC Upgrade PATELP08 >> Blocking this action as Report 'Work Center List' as it is marked for removal and replaced by the page 'Work Center List' by microsoft, but page 'Work Center List' action already exists.
            // action("Work Center List")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Work Center List';
            //     Image = "Report";
            //     RunObject = Report "Work Center List"; // PATELP08 - Report 'Work Center List' as it is marked for removal and replaced by the page 'Work Center List' by microsoft, but page 'Work Center List' action already exists.
            // }
            // BC Upgrade PATELP08 <<
            separator(Separator55011)
            {

                Caption = 'Inventory &Valuation WIP';
            }
            action("<Prod. Order - Routing List")
            {
                ApplicationArea = All;
                Caption = 'Prod. Order - Routing List';
                Image = "Report";
                RunObject = Report "Prod. Order - Routing List";
            }
            action("<Prod. Order - List")
            {
                ApplicationArea = All;
                Caption = 'Prod. Order - List';
                Image = "Report";
                RunObject = Report "Prod. Order - List";
            }
            action("<Report Prod. Order - Mat. Req.")
            {
                ApplicationArea = All;
                Caption = 'Prod. Order - Mat. Requisition';
                Image = "Report";
                RunObject = Report "Prod. Order - Mat. Requisition";
            }
            // BC Upgrade PATELP08 >> Blocking this action as Report 'Prod. Order - Calculation' is marked for removal and replaced by the report 'Production Order Statistics' but report 'Production Order Statistics' action already exists.
            // action("Prod. Order - Calculation")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Prod. Order - Calculation';
            //     Image = "Report";
            //     RunObject = Report "Prod. Order - Calculation"; // PATELP08 >> Report 'Prod. Order - Calculation' is marked for removal and replaced by the report 'Production Order Statistics' but report 'Production Order Statistics' action already exists.
            // }
            // BC Upgrade PATELP08 <<
            separator(Separator55016)
            {

                Caption = 'Inventory &Valuation WIP';
            }
            action("<Prod. Order - Detailed Calc.")
            {
                ApplicationArea = All;
                Caption = 'Prod. Order - Detailed Calc.';
                Image = "Report";
                RunObject = Report "Prod. Order - Detailed Calc.";
            }
            action("<Prod. Order - Shortage List")
            {
                ApplicationArea = All;
                Caption = 'Prod. Order - Shortage List';
                Image = "Report";
                RunObject = Report "Prod. Order - Shortage List";
            }
            action("<Production Order Statistics")
            {
                ApplicationArea = All;
                Caption = 'Production Order Statistics';
                Image = "Report";
                RunObject = Report "Production Order Statistics";
            }
            action("Planning Availability")
            {
                ApplicationArea = All;
                Caption = 'Planning Availability';
                Image = "Report";
                RunObject = Report "Planning Availability";
            }
            separator(Separator55017)
            {
            }
            // BC Upgrade BHARDA11 >> ----Page "Item Availability by Timeline" obsolete in BC

            // action("<Item Availability by Timeline")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Item Availability by Timeline';
            //     Image = "Report";
            //     RunObject = Page "Item Availability by Timeline";
            // }
            // BC Upgrade BHARDA11 << ----Page "Item Availability by Timeline" obsolete in BC

        }
        area(embedding)
        {
            action("Simulated Production Orders")
            {
                ApplicationArea = All;
                Caption = 'Simulated Production Orders';
                RunObject = Page "Simulated Production Orders";
            }
            action("Planned Production Orders")
            {
                ApplicationArea = All;
                Caption = 'Planned Production Orders';
                RunObject = Page "Planned Production Orders";
            }
            action("Firm Planned Production Orders")
            {
                ApplicationArea = All;
                Caption = 'Firm Planned Production Orders';
                RunObject = Page "Firm Planned Prod. Orders";
            }
            action("Released Production Orders")
            {
                ApplicationArea = All;
                Caption = 'Released Production Orders';
                RunObject = Page "Released Production Orders";
            }
            action("Finished Production Orders")
            {
                ApplicationArea = All;
                Caption = 'Finished Production Orders';
                RunObject = Page "Finished Production Orders";
            }
            // BC Upgrade BHARDA11 >> ----Page "Production Forecast Names" obsolete in BC
            // action("Production Forecast")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Production Forecast';
            //     RunObject = Page "Production Forecast Names";

            // }
            // BC Upgrade BHARDA11 << ----Page "Production Forecast Names" obsolete in BC

            action("Blanket Sales Orders")
            {
                ApplicationArea = All;
                Caption = 'Blanket Sales Orders';
                RunObject = Page "Blanket Sales Orders";
            }
            action("Sales Orders")
            {
                ApplicationArea = All;
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List";
            }
            action("Blanket Purchase Orders")
            {
                ApplicationArea = All;
                Caption = 'Blanket Purchase Orders';
                RunObject = Page "Blanket Purchase Orders";
            }
            action("Purchase Orders")
            {
                ApplicationArea = All;
                Caption = 'Purchase Orders';
                RunObject = Page "Purchase Order List";
            }
            action("Transfer Orders")
            {
                ApplicationArea = All;
                Caption = 'Transfer Orders';
                Image = Document;
                // RunObject = Page "Transfer List"; -- BC Upgrade BHARDA11 ----Page "Transfer List" is obsolete in BC , so here we are using "Transfer Orders"
                RunObject = Page "Transfer Orders";
            }
            action(Vendors)
            {
                ApplicationArea = All;
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
            }
            action(Items)
            {
                ApplicationArea = All;
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
            }
            action(ItemsProduced)
            {
                ApplicationArea = All;
                Caption = 'Produced';
                RunObject = Page "Item List";
                RunPageView = WHERE("Replenishment System" = CONST("Prod. Order"));
            }
            action(ItemsRawMaterials)
            {
                ApplicationArea = All;
                Caption = 'Raw Materials';
                RunObject = Page "Item List";
                RunPageView = WHERE("Low-Level Code" = FILTER(> 0),
                                    "Replenishment System" = CONST(Purchase),
                                    "Production BOM No." = FILTER(= ''));
            }
            action("Stockkeeping Units")
            {
                ApplicationArea = All;
                Caption = 'Stockkeeping Units';
                Image = SKU;
                RunObject = Page "Stockkeeping Unit List";
            }
            action(ProductionBOMs)
            {
                ApplicationArea = All;
                Caption = 'Production BOMs';
                RunObject = Page "Production BOM List";
            }
            action(ProductionBOMsCertified)
            {
                ApplicationArea = All;
                Caption = 'Certified';
                RunObject = Page "Production BOM List";
                RunPageView = WHERE(Status = CONST(Certified));
            }
            action(Routings)
            {
                ApplicationArea = All;
                Caption = 'Routings';
                RunObject = Page "Routing List";
            }
        }
        area(sections)
        {
            group(Journals)
            {
                Caption = 'Journals';
                Image = Journals;
                action(ItemJournals)
                {
                    ApplicationArea = All;
                    Caption = 'Item Journals';
                    RunObject = Page "Item Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Item),
                                        Recurring = CONST(false));
                }
                action(ItemReclassificationJournals)
                {
                    ApplicationArea = All;
                    Caption = 'Item Reclassification Journals';
                    RunObject = Page "Item Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Transfer),
                                        Recurring = CONST(false));
                }
                action(RevaluationJournals)
                {
                    ApplicationArea = All;
                    Caption = 'Revaluation Journals';
                    RunObject = Page "Item Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Revaluation),
                                        Recurring = CONST(false));
                }
            }
            group(Worksheets)
            {

                Caption = 'Worksheets';
                Image = Worksheets;
                action(PlanningWorksheets)
                {
                    ApplicationArea = All;
                    Caption = 'Planning Worksheets';
                    RunObject = Page "Req. Wksh. Names";
                    RunPageView = WHERE("Template Type" = CONST(Planning),
                                        Recurring = CONST(false));
                }
                action(RequisitionWorksheets)
                {
                    ApplicationArea = All;
                    Caption = 'Requisition Worksheets';
                    RunObject = Page "Req. Wksh. Names";
                    RunPageView = WHERE("Template Type" = CONST("Req."),
                                        Recurring = CONST(false));
                }
                action(SubcontractingWorksheets)
                {
                    ApplicationArea = All;
                    Caption = 'Subcontracting Worksheets';
                    RunObject = Page "Req. Wksh. Names";
                    RunPageView = WHERE("Template Type" = CONST("For. Labor"),
                                        Recurring = CONST(false));
                }
                action("Standard Cost Worksheet")
                {
                    ApplicationArea = All;
                    Caption = 'Standard Cost Worksheet';
                    RunObject = Page "Standard Cost Worksheet Names";
                }
            }
            group("Product Design")
            {

                Caption = 'Product Design';
                Image = ProductDesign;
                action(ProductionBOM)
                {
                    ApplicationArea = All;
                    Caption = 'Production BOM';
                    Image = BOM;
                    RunObject = Page "Production BOM List";
                }
                action(ProductionBOMCertified)
                {
                    ApplicationArea = All;
                    Caption = 'Certified';
                    RunObject = Page "Production BOM List";
                    RunPageView = WHERE(Status = CONST(Certified));
                }
                action(Action26)
                {
                    ApplicationArea = All;
                    Caption = 'Routings';
                    RunObject = Page "Routing List";
                }
                action("Standard Tasks")
                {
                    ApplicationArea = All;
                    Caption = 'Standard Tasks';
                    RunObject = Page "Standard Tasks";
                }
                action(Families)
                {
                    ApplicationArea = All;
                    Caption = 'Families';
                    RunObject = Page "Family List";
                }
                action(ProdDesign_Items)
                {
                    ApplicationArea = All;
                    Caption = 'Items';
                    Image = Item;
                    RunObject = Page "Item List";
                }
                action(ProdDesign_ItemsProduced)
                {
                    ApplicationArea = All;
                    Caption = 'Produced';
                    RunObject = Page "Item List";
                    RunPageView = WHERE("Replenishment System" = CONST("Prod. Order"));
                }
                action(ProdDesign_ItemsRawMaterials)
                {
                    ApplicationArea = All;
                    Caption = 'Raw Materials';
                    RunObject = Page "Item List";
                    RunPageView = WHERE("Low-Level Code" = FILTER(> 0),
                                        "Replenishment System" = CONST(Purchase));
                }
                action(Action37)
                {
                    ApplicationArea = All;
                    Caption = 'Stockkeeping Units';
                    Image = SKU;
                    RunObject = Page "Stockkeeping Unit List";
                }
            }
            group(Capacities)
            {

                Caption = 'Capacities';
                Image = Capacities;
                action(WorkCenters)
                {
                    ApplicationArea = All;
                    Caption = 'Work Centers';
                    RunObject = Page "Work Center List";
                }
                action(WorkCentersInternal)
                {
                    ApplicationArea = All;
                    Caption = 'Internal';
                    Image = Comment;
                    RunObject = Page "Work Center List";
                    RunPageView = WHERE("Subcontractor No." = FILTER(= ''));
                }
                action(WorkCentersSubcontracted)
                {
                    ApplicationArea = All;
                    Caption = 'Subcontracted';
                    RunObject = Page "Work Center List";
                    RunPageView = WHERE("Subcontractor No." = FILTER(<> ''));
                }
                action("Machine Centers")
                {
                    ApplicationArea = All;
                    Caption = 'Machine Centers';
                    RunObject = Page "Machine Center List";
                }
                action("Registered Absence")
                {
                    ApplicationArea = All;
                    Caption = 'Registered Absence';
                    RunObject = Page "Registered Absences";
                }
                action(Action44)
                {
                    ApplicationArea = All;
                    Caption = 'Vendors';
                    Image = Vendor;
                    RunObject = Page "Vendor List";
                }
            }
        }
        area(creation)
        {
            action("&Item")
            {
                ApplicationArea = All;
                Caption = '&Item';
                Image = Item;
                // BC Upgrade PATELP08 >> Blocking Promoted property as it can only be used if 'PageType' is: 'Card,Document,List,ListPlus,Worksheet' and current page is Rolecenter and rolecenter does not support Promoted property.
                //Promoted = false;
                // BC Upgrade PATELP08 <<
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Item Card";
                RunPageMode = Create;
            }
            action("Firm Planned Prod. Order")
            {
                ApplicationArea = All;
                Caption = 'Firm Planned Prod. Order';
                Image = "Order";
                // BC Upgrade PATELP08 >> Blocking Promoted property as it can only be used if 'PageType' is: 'Card,Document,List,ListPlus,Worksheet' and current page is Rolecenter and rolecenter does not support Promoted property.
                //Promoted = false;
                // BC Upgrade PATELP08 <<
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Firm Planned Prod. Order";
                RunPageMode = Create;
            }
            action("Released Production Order")
            {
                ApplicationArea = All;
                Caption = 'Released Production Order';
                Image = "Order";
                // BC Upgrade PATELP08 >> Blocking Promoted property as it can only be used if 'PageType' is: 'Card,Document,List,ListPlus,Worksheet' and current page is Rolecenter and rolecenter does not support Promoted property.
                //Promoted = false;
                // BC Upgrade PATELP08 <<
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Released Production Order";
                RunPageMode = Create;
            }
            action("<Import Firm. Prod. Orders")
            {
                ApplicationArea = All;
                Caption = 'Import Firm. Prod. Orders';
                Image = "Report";
                RunObject = Report "Import Firm. Prod. Orders";
            }
            action("Production &BOM")
            {
                ApplicationArea = All;
                Caption = 'Production &BOM';
                Image = BOM;
                // BC Upgrade PATELP08 >> Blocking Promoted property as it can only be used if 'PageType' is: 'Card,Document,List,ListPlus,Worksheet' and current page is Rolecenter and rolecenter does not support Promoted property.
                //Promoted = false;
                // BC Upgrade PATELP08 <<
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Production BOM";
                RunPageMode = Create;
            }
            action("&Routing")
            {
                ApplicationArea = All;
                Caption = '&Routing';
                Image = Route;
                // BC Upgrade PATELP08 >> Blocking Promoted property as it can only be used if 'PageType' is: 'Card,Document,List,ListPlus,Worksheet' and current page is Rolecenter and rolecenter does not support Promoted property.
                //Promoted = false;
                // BC Upgrade PATELP08 <<
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page Routing;
                RunPageMode = Create;
            }
            action("&Purchase Order")
            {
                ApplicationArea = All;
                Caption = '&Purchase Order';
                Image = Document;
                // BC Upgrade PATELP08 >> Blocking Promoted property as it can only be used if 'PageType' is: 'Card,Document,List,ListPlus,Worksheet' and current page is Rolecenter and rolecenter does not support Promoted property.
                //Promoted = false;
                // BC Upgrade PATELP08 <<
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Purchase Order";
                RunPageMode = Create;
            }
        }
        area(processing)
        {
            separator(Tasks)
            {

                Caption = 'Tasks';
                IsHeader = true;
            }
            action("Item &Journal")
            {
                ApplicationArea = All;
                Caption = 'Item &Journal';
                Image = Journals;
                RunObject = Page "Item Journal";
            }
            action("Phys. Inventory Journal")
            {
                ApplicationArea = All;
                Caption = 'Phys. Inventory Journal';
                Image = "Order";
                // BC Upgrade PATELP08 >> Blocking Promoted property as it can only be used if 'PageType' is: 'Card,Document,List,ListPlus,Worksheet' and current page is Rolecenter and rolecenter does not support Promoted property.
                //Promoted = false;
                // BC Upgrade PATELP08 <<
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Phys. Inventory Journal";
                RunPageMode = Edit;
            }
            action("Item Reclass. Journal")
            {
                ApplicationArea = All;
                Caption = 'Item Reclass. Journal';
                Image = "Order";
                // BC Upgrade PATELP08 >> Blocking Promoted property as it can only be used if 'PageType' is: 'Card,Document,List,ListPlus,Worksheet' and current page is Rolecenter and rolecenter does not support Promoted property.
                //Promoted = false;
                // BC Upgrade PATELP08 <<
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Item Reclass. Journal";
                RunPageMode = Edit;
            }
            action("Re&quisition Worksheet")
            {
                ApplicationArea = All;
                Caption = 'Re&quisition Worksheet';
                Image = Worksheet;
                RunObject = Page "Req. Worksheet";
            }
            action("Planning Works&heet")
            {
                ApplicationArea = All;
                Caption = 'Planning Works&heet';
                Image = PlanningWorksheet;
                RunObject = Page "Planning Worksheet";
            }
            // BC Upgrade BHARDA11 >> ----PAge "Item Availability by Timeline" obsolete in BC
            // action("Item Availability by Timeline")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Item Availability by Timeline';
            //     Image = Timeline;
            //     RunObject = Page "Item Availability by Timeline";
            // }
            // BC Upgrade BHARDA11 << ----PAge "Item Availability by Timeline" obsolete in BC

            action("Subcontracting &Worksheet")
            {
                ApplicationArea = All;
                Caption = 'Subcontracting &Worksheet';
                Image = SubcontractingWorksheet;
                RunObject = Page "Subcontracting Worksheet";
            }
            separator(Separator45)
            {
            }
            action("Change Pro&duction Order Status")
            {
                ApplicationArea = All;
                Caption = 'Change Pro&duction Order Status';
                Image = ChangeStatus;
                RunObject = Page "Change Production Order Status";
            }
            action("Order Pla&nning")
            {
                ApplicationArea = All;
                Caption = 'Order Pla&nning';
                Image = Planning;
                RunObject = Page "Order Planning";
            }
            separator(Administration)
            {

                Caption = 'Administration';
                IsHeader = true;
            }
            action("Order Promising S&etup")
            {
                ApplicationArea = All;
                Caption = 'Order Promising S&etup';
                Image = OrderPromisingSetup;
                RunObject = Page "Order Promising Setup";
            }
            action("&Manufacturing Setup")
            {
                ApplicationArea = All;
                Caption = '&Manufacturing Setup';
                Image = ProductionSetup;
                RunObject = Page "Manufacturing Setup";
            }
            separator(History)
            {

                Caption = 'History';
                IsHeader = true;
            }
            action("Item &Tracing")
            {
                ApplicationArea = All;
                Caption = 'Item &Tracing';
                Image = ItemTracing;
                RunObject = Page "Item Tracing";
            }
            action("Navi&gate")
            {
                ApplicationArea = All;
                Caption = 'Navi&gate';
                Image = Navigate;
                RunObject = Page Navigate;
            }
        }
    }
}

