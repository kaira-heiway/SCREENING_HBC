namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Purchases.Document;
using Microsoft.Warehouse.Request;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Transfer;

pageextension 58003 TransferOrder_InterfaceAct extends "Transfer Order"
{
    // BC Upgrade SHUKLP03 >>
    // DrinkIT code is blocked.
    // Made action("Create Whse. S&hipment") visible false, because of HEI code else condition.
    // Added action("Create &Whse. Receipt") of Transfer order in this page because interface related objects are used.
    // Created custom action("Create Whse. S&hipment Custom") of Transfer order in this page because interface related objects are used in this action.
    // BC Upgrade SHUKLP03 <<

    layout
    {
        addafter("External Document No.")
        {
            field("WMS Export"; Rec."WMS Export FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the WMS Export field.';

            }
            field("LSR Order No"; Rec."LSR Order No FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LSR Order No field.';
            }
        }
    }
    actions
    {
        modify("Create Whse. S&hipment")
        {
            Visible = false; // BC Upgrade SHUKLP03 << Made it visible false because of HEI code else condition.
        }
        addafter("F&unctions")
        {
            action("Create Whse. S&hipment Custom")
            {
                CaptionML = ENU = 'Create Whse. S&hipment', FRA = 'Créer e&xpédition entrep.';
                ApplicationArea = All;
                ToolTip = 'Executes the Create Whse. S&hipment Custom action.';

                trigger OnAction()
                var
                    GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                begin
                    //HEI.12>>
                    IF LSRInterfaceSetup.GET() AND LSRInterfaceSetup."Enable LSR Interface" THEN
                        IF InterfaceSetup.GET(LSRInterfaceSetup."Transfer Shipment Interface") THEN
                            IF InterfaceSetup.Enabled THEN
                                IF Rec."LSR Order No FND" <> '' THEN BEGIN
                                    LocationFrom.GET(Rec."Transfer-from Code");
                                    IF LocationFrom."Store FND" THEN
                                        ERROR(CannotShipInHLErr);
                                END;
                    //HEI.12<<

                    // // <<DITW15.00.00.38 DDR 21/12/2010 #1146
                    // ReleaseTransferOrder();  // BC Upgrade SHUKLP03 << DrinkIT code is blocked.
                    // // >>DITW15.00.00.38 DDR #1146

                    //HEI.14>>
                    Onelienreceipt := FALSE;
                    MaximoDoc := FALSE;
                    IF lrec_PurchHdrAddtnl.GET(lrec_PurchHdrAddtnl."Document Type"::Order, Rec."PO Reference FND") THEN BEGIN
                        IF lrec_PurchHdrAddtnl."Import Identifier" THEN BEGIN
                            IF lrec_PurchHdr.GET(lrec_PurchHdr."Document Type"::Order, Rec."PO Reference FND") THEN
                                IF (lrec_PurchHdr."Maximo Requisition No. FND" <> '') THEN
                                    MaximoDoc := TRUE;
                            lrec_PurchLn.RESET();
                            lrec_PurchLn.SETRANGE("Document Type", lrec_PurchHdrAddtnl."Document Type");
                            lrec_PurchLn.SETRANGE("Document No.", lrec_PurchHdrAddtnl."No.");
                            IF lrec_PurchLn.findset() THEN
                                REPEAT
                                    IF (lrec_PurchLn."Quantity Received" <> 0) THEN
                                        Onelienreceipt := TRUE;
                                UNTIL (lrec_PurchLn.NEXT() = 0) OR (Onelienreceipt = TRUE);
                        END;
                    END;
                    IF MaximoDoc THEN
                        ERROR(Text50000, Rec."No.");

                    IF (Rec."PO Reference FND" <> '') THEN BEGIN
                        IF NOT MaximoDoc AND NOT Onelienreceipt THEN
                            ERROR(Text50002, Rec."No.", Rec."PO Reference FND");
                        IF NOT MaximoDoc AND Onelienreceipt THEN
                            GetSourceDocOutbound.CreateFromOutbndTransferOrder(Rec);
                    END ELSE
                        GetSourceDocOutbound.CreateFromOutbndTransferOrder(Rec);

                    //HEI.14<<

                end;
            }
        }
        modify("Create &Whse. Receipt")
        {
            CaptionML = ENU = 'Create &Whse. Receipt', FRA = 'Créer &réception entrepôt';
            trigger OnBeforeAction()
            var
            begin
                //HEI.12>>
                IF LSRInterfaceSetup.GET() AND LSRInterfaceSetup."Enable LSR Interface" THEN
                    IF InterfaceSetup.GET(LSRInterfaceSetup."Transfer Receipt Interface Out") THEN
                        IF InterfaceSetup.Enabled THEN
                            IF Rec."LSR Order No FND" <> '' THEN BEGIN
                                LocationTo.GET(Rec."Transfer-to Code");
                                IF LocationTo."Store FND" THEN
                                    ERROR(CannotReceiveInHLErr);
                            END;
                //HEI.12<<
            end;
        }
    }

    var
        LSRInterfaceSetup: Record "LSR Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        Text50002: Label 'Warehouse Shipment Doc can not be created for this Transfer Order - %1 as it is created from Import PO process and PO- %2 is not fully or partially received';
        CannotShipInHLErr: Label 'A Transfer Order from Store Location can not be shipped in Heilite.';
        CannotReceiveInHLErr: Label 'A Transfer Order to Store Location can not be received in Heilite.';
        Text50000: Label 'Warehouse Shipment Doc can not be created for this Transfer Order - %1 as it is created from Import PO process';
        LocationFrom: Record Location;
        lrec_PurchHdrAddtnl: Record "Purchase Header Additional FND";
        lrec_PurchLn: Record "Purchase Line";
        lrec_PurchHdr: Record "Purchase Header";
        MaximoDoc: Boolean;
        Onelienreceipt: Boolean;

        LocationTo: Record Location;



}
