page 55005 "PPV Allocation"
{
    // version HEI.01

    // HEI.01 CHG2193490 IBM SISUM01 26/07/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # new object created

    // BC Upgrade POENAB02: Original (HeiLite) page id 50281

    // BC Upgrade POENAB02, 25.03.2026, Gap "Purchase Price Variance (PPV) Allocation"

    Caption = 'PPV Allocation';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "PPV Allocation Header RTR";


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Processing Date"; Rec."Processing Date")
                {
                    ToolTip = 'Specifies the date when the PPV allocation processing was done.';
                }
                field(Month; Rec.Month)
                {
                    ToolTip = 'Specifies the month for which the PPV allocation is done.';
                }
                field(Year; Rec.Year)
                {
                    ToolTip = 'Specifies the year for which the PPV allocation is done.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the item number for which the PPV allocation is done.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description of the item.';
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ToolTip = 'Specifies the item category code of the item.';
                }
                field("Gen. Product Posting Group"; Rec."Gen. Product Posting Group")
                {
                    ToolTip = 'Specifies the general product posting group of the item.';
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ToolTip = 'Specifies the inventory posting group of the item.';
                }
                field("Period Purchased Qty"; Rec."Period Purchased Qty")
                {
                    ToolTip = 'Specifies the quantity of the item purchased during the specified period.';
                }
                field("Period Purchased Amount"; Rec."Period Purchased Amount")
                {
                    ToolTip = 'Specifies the amount spent on purchasing the item during the specified period.';
                }
                field("As of Purchased Qty"; Rec."As of Purchased Qty")
                {
                    ToolTip = 'Specifies the cumulative quantity of the item purchased up to the end of the specified period.';
                }
                field("As of Purchased Amount"; Rec."As of Purchased Amount")
                {
                    ToolTip = 'Specifies the cumulative amount spent on purchasing the item up to the end of the specified period.';
                }
                field("Positive Adj. Qty"; Rec."Positive Adj. Qty")
                {
                    ToolTip = 'Specifies the quantity of positive adjustments made to the item during the specified period.';
                }
                field("As of Positive Adj. Qty"; Rec."As of Positive Adj. Qty")
                {
                    ToolTip = 'Specifies the cumulative quantity of positive adjustments made to the item up to the end of the specified period.';
                }
                field("Period Stock Qty"; Rec."Period Stock Qty")
                {
                    ToolTip = 'Specifies the quantity of stock available for the item at the end of the specified period.';
                }
                field("Period Stock Balance"; Rec."Period Stock Balance")
                {
                    ToolTip = 'Specifies the monetary value of the stock available for the item at the end of the specified period.';
                }
                field("YTD Stock Qty. (Rem. Qty.)"; Rec."YTD Stock Qty. (Rem. Qty.)")
                {
                    ToolTip = 'Specifies the year-to-date quantity of stock remaining for the item.';
                }
                field("YTD Stock Value"; Rec."YTD Stock Value")
                {
                    ToolTip = 'Specifies the year-to-date monetary value of the stock remaining for the item.';
                }
                field("Purchase Value of Rem. Stock"; Rec."Purchase Value of Rem. Stock")
                {
                    ToolTip = 'Specifies the purchase value of the remaining stock for the item.';
                }
                field("Calculated Standard Value"; Rec."Calculated Standard Value")
                {
                    ToolTip = 'Specifies the calculated standard value of the item based on the standard costing method.';
                }
                field("Standard cost"; Rec."Standard cost")
                {
                    ToolTip = 'Specifies the standard cost of the item as defined in the item card.';
                }
                field("Standard Cost Deviation"; Rec."Standard Cost Deviation")
                {
                    ToolTip = 'Specifies the deviation between the calculated standard value and the standard cost of the item.';
                }
                field("PPV Adjustment Amount"; Rec."PPV Adjustment Amount")
                {
                    ToolTip = 'Specifies the amount of the purchase price variance (PPV) adjustment for the item.';
                }
            }
        }
    }

    actions
    {
    }
}

