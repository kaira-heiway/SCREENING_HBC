pageextension 58034 BlanketPurchaseOrderSubforIntE extends "Blanket Purchase Order Subform"
{
    actions
    {
        addlast("Posted Lines")
        {
            action("Page Purchase Line Prices")
            {
                Caption = 'Prices';
                ApplicationArea = All;
                Image = Price;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Purchase Line Prices CBN";
            }
        }
    }
}
