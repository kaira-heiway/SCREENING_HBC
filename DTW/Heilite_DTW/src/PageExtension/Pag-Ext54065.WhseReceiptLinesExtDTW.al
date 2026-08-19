pageextension 54065 WhseReceiptLinesExtDTW extends "whse. Receipt Lines"
{
    //BC Upgrade GUNREM01 - Created new action "Show Document Custom" to write the custom code using ware house employee custom table to check if user is warehouse employee for the location of the warehouse receipt line and show the document accordingly.
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        modify(ShowDocument)
        {
            Visible = false;
            ShortcutKey = '';
        }

        addafter(ShowDocument)
        {
            action(ShowDocumentCustom)
            {
                ApplicationArea = Warehouse;
                Caption = 'Show Document';
                Image = ViewOrder;
                ShortCutKey = 'Return';
                ToolTip = 'View the related warehouse document.';

                trigger OnAction()
                var
                    WhseRcptHeader: Record "Warehouse Receipt Header";
                    HeinekenBCUpgrade: Codeunit "Heineken BC Upgrade DTW";
                begin
                    WhseRcptHeader.Get(Rec."No.");
                    HeinekenBCUpgrade.CheckUserIsWhseEmployeeForLocationCustom(WhseRcptHeader."Location Code", false);
                    PAGE.Run(PAGE::"Warehouse Receipt", WhseRcptHeader);
                end;
            }

        }
    }

    var
        myInt: Integer;
}