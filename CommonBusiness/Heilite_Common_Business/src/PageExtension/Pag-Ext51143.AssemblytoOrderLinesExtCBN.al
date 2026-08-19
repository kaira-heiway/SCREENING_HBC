pageextension 51143 AssembletoOrderLinesExtCBN extends "Assemble-to-Order Lines"
{
    //BC UPGRADE PATHAA02 19.11.25
    //1. Made "Description" field non editable as it can't be handled on Table 901-"Assembly Line"

    layout
    {
        // Add changes to page layout here
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the description of the assembly item.', FRA = 'Spécifie la description de l''article d''assemblage.';
            Editable = false;//BC UPGRADE PATHAA02
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
