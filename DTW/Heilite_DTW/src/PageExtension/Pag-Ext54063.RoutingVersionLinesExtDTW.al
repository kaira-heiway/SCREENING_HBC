namespace DTWLocal.DTWLocal;

using Microsoft.Manufacturing.Routing;

pageextension 54063 RoutingVersionLinesExtDTW extends "Routing Version Lines"
{
    //PATHAA02 14.04.26 #Line Speed added to pageExt of FDD-GAP-008
    layout
    {
        addafter("Lot Size")
        {
            field("Line Speed"; Rec."Line Speed FND")
            {
                Description = 'HEI.01';
                Visible = true;
                ApplicationArea = All;
            }

        }
    }
}
