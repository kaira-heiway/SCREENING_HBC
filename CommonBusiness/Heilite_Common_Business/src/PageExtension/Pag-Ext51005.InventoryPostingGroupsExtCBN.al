pageextension 51005 InventoryPostingGroupsExtCBN extends "Inventory Posting Groups"
{
    // BC UPGRADE PATHAA02 01/09/25 -DIT fields commented, action trigger removed

    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies an inventory posting group code.', FRA = 'Spécifie un code groupe comptabilisation stock.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the inventory posting group.', FRA = 'Spécifie une description du groupe comptabilisation stock.';
        }
        //BC UPGRADE PATHAA02-DIT fields>>
        // addafter(Description)
        // {
        //     field("As Empty Good";"As Empty Good")
        //     {
        //     }
        //     field("No. of Items";"No. of Items")
        //     {
        //     }
        // }
        //BC UPGRADE PATHAA02<<
    }
}

