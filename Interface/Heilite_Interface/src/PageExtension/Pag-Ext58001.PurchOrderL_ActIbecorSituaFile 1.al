namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Purchases.Document;

pageextension 58001 PurchOrderL_ActIbecorSituaFile extends "Purchase Order List"
{
    // BC Upgrade SHUKLP03 >>
    //  action("Ibecor Situational File") of purchase order list is added in this page because interface related objects is used in this action.
    // BC Upgrade SHUKLP03 <<


    // BC Upgrade MISHRS14 >>
    // Changed table name to "Ibecor Situational File FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    actions
    {
        addbefore(Documents)
        {
            action("Ibecor Situational File")
            {
                Caption = 'Ibecor Situational File';
                Image = Filed;
                ApplicationArea = All;
                ToolTip = 'Executes the Ibecor Situational File action.';

                trigger OnAction();
                var
                    IbecorSituationalFile: Record "Ibecor Situational File FND";
                    StoreLastShipmentNo: Code[10];
                begin
                    //HEI.21>>
                    IbecorSituationalFile.RESET();
                    IbecorSituationalFile.SETRANGE("Order No.", Rec."No.");
                    IbecorSituationalFile.SETRANGE("Shipment Type", IbecorSituationalFile."Shipment Type"::Registered);
                    if IbecorSituationalFile.FINDFIRST() then
                        PAGE.RUNMODAL(PAGE::"Ibecor Situational File", IbecorSituationalFile)
                    else begin
                        IbecorSituationalFile.SETRANGE("Shipment Type", IbecorSituationalFile."Shipment Type"::Current);
                        if IbecorSituationalFile.FINDLAST() then
                            StoreLastShipmentNo := IbecorSituationalFile."Shipment No.";
                        IbecorSituationalFile.SETRANGE("Shipment No.", StoreLastShipmentNo);
                        PAGE.RUNMODAL(PAGE::"Ibecor Situational File", IbecorSituationalFile)
                    end;
                    //HEI.21<<
                end;
            }

        }
    }
}
