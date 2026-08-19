namespace HEILITE_MTC_.HEILITE_MTC_;

pageextension 51240 RouteExtCBN extends Routes107FDW
{
    // BC Upgrade SHUKLP03 >> Created table extension to add field "Van Sales Route FND" in Route table for RA SalesOrder interface.
    layout
    {
        addafter(Trailer)
        {
            field("Van Sales Route"; Rec."Van Sales Route FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Van Sales Route field.';
            }
        }
    }
}
