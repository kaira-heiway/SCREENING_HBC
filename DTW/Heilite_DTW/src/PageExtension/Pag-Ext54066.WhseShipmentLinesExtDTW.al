pageextension 54066 WhseShipmentLinesExtDTW extends "Whse. Shipment Lines"
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
                    WhseShptHeader: Record "Warehouse Shipment Header";
                    HeinekenBCUpgrade: Codeunit "Heineken BC Upgrade DTW";
                begin
                    WhseShptHeader.Get(Rec."No.");
                    HeinekenBCUpgrade.CheckUserIsWhseEmployeeForLocationCustom(WhseShptHeader."Location Code", false);
                    PAGE.Run(PAGE::"Warehouse Shipment", WhseShptHeader);
                end;
            }

        }
    }

    var
        myInt: Integer;
}