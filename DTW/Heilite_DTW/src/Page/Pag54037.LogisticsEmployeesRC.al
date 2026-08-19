page 54037 "Logistics Employees RC"
{
    // version HEI.01

    // HEI.01 FDD-HB2190 - CHG2110204 IBM NASTAA02 20.05.2021 # Mobile devices for Logistics Employees -
    //   # New Page created

    // BC Upgrade KAPOOV01 >>
    // 1. Old Page ID- 50452.
    // 2. Add ApplicationArea & UsageCategory  property in page,fields and actions.
    // 3. Commented Page-Connect Online this page is obsolete in BC.
    // 4. Page-"Transfer List" used in RunObject Property of action, its name changed from "Transfer List" to "Transfer Orders.
    // BC Upgrade KAPOOV01 <<

    Caption = 'Logistics Employees Role Center';
    PageType = RoleCenter;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(rolecenter)
        {
            group(Control55001)
            {
            }
            group(Control55004)
            {
                part(Control55013; "My Job Queue")
                {
                    Visible = false;
                }
                part(Control55012; "My Items")
                {
                }
                part(Control55006; "Report Inbox Part")
                {
                }
                // //BC Upgrade KAPOOV01- “Connect Online” page is obsolete in BC >>
                // part(Control55005; "Connect Online")
                // {
                // }
                // //BC Upgrade KAPOOV01- “Connect Online” page is obsolete in BC <<
                systempart(Control55003; MyNotes)
                {
                }
            }
        }
    }

    actions
    {
        area(embedding)
        {
            ToolTipML = ENU = 'Manage sales processes. See KPIs and your favorite items and customers.',
                        FRA = 'Gérez les processus de vente. Examinez les KPI et vos articles et clients favoris.';
            action(ZoneWarehouseMovements)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Zone Warehouse Movements';
                Image = ZoneCode;
                RunObject = Page "Zone Warehouse Movements";
            }
            action(TransferOrders)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Transfer Orders';
                Image = TransferOrder;
                //RunObject = Page "Transfer List";  //BC Upgrade KAPOOV01 Page name changed from "Transfer List" to "Transfer Orders"
                RunObject = Page "Transfer Order";   //BC Upgrade KAPOOV01 Page name changed from "Transfer List" to "Transfer Orders"
            }
            action(WarehouseReceipts)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Warehouse Receipts';
                Image = WarehouseRegisters;
                RunObject = Page "Warehouse Receipts";
            }
            action(ReleasedProductionOrders)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Released Production Orders';
                Image = Production;
                RunObject = Page "Released Production Orders";
            }
        }
    }
}

