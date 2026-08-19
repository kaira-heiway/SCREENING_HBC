pageextension 54019 PostedTransferShptSubfDTWExt extends "Posted Transfer Shpt. Subform"
{
    /* HEI.01 FDD-GAPLOG015 IBM NASTAA02 18.04.2018 # Undo Transfer Shipment
        # Added new Action Button "Undo Transfer Shipment" and new function "UndoShipmentPosting" */
    // BC Upgrade BHARAD11 
    actions
    {
        addafter("Item &Tracking Lines")
        {
            action(UndoShipment1)
            {
                ApplicationArea = All;
                CaptionML = ENU = '&Undo Transfer Shipment',
                            FRA = '&Annuler expédition';
                Image = UndoShipment;

                trigger OnAction();
                begin
                    //HEI.01>>
                    UndoShipmentPosting;
                    //HEI.01<<
                end;
            }
        }
    }
    local procedure UndoShipmentPosting()
    var
        TransferShptLine: Record "Transfer Shipment Line";
    begin
        //HEI.01>>
        TransferShptLine.COPY(Rec);
        CurrPage.SETSELECTIONFILTER(TransferShptLine);
        CODEUNIT.RUN(CODEUNIT::"Undo Transfer Shipment Line", TransferShptLine);
        //HEI.01<<
    end;
}
