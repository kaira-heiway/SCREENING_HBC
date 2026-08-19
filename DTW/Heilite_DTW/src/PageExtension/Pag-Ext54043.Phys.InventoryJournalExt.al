pageextension 54043 "Phys.InventoryJournalExt" extends "Phys. Inventory Journal"
{

    // BC Upgrade MISHRS14 >>
    // Created this page extension for "Phys. Inventory Journal" to add action for new report of "Calculate Inventory" - 790 with all HEI Tags.
    // BC Upgrade MISHRS14 <<

    //# FDD-GAP001 IBM PATHAA02-07.04.26
    //# New action button to run the customised Report 790-"Calculate Inventory Heililte"
    // # RunObject property commented and Code added-OnAction

    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(CalculateInventory)
        {
            action("Calculate Inventory Heilite")
            {
                ApplicationArea = all;
                Caption = 'Calculate Inventory Heilite';
                // Ellipsis = true;
                Image = CalculateCalendar;
                ToolTip = 'Show all items that a counting period has been assigned to, according to the counting period, the last counting period update, and the current work date.';
                // Promoted = true;
                // RunObject = Report "Calculate Inventory Heilite";

                trigger OnAction()
                var
                    CalculateInventoryHeilite: Report "Calculate Inventory Heilite";
                begin
                    CalculateInventoryHeilite.GetTemplateBatch(Rec);
                    CalculateInventoryHeilite.Run();
                end;

            }
        }

    }
}