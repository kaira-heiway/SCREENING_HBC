pageextension 51244 SalesOrdersubformExt2CBN extends "Sales Order Subform"
{
    layout
    {
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                ItemCheckAva: Codeunit "Item-Check Avail.";
                AvailabilityCheckNotification: Notification;
            begin
                if Rec.Type <> Rec.Type::Item then
                    exit;

                if not ItemCheckAva.SalesLineShowWarning(Rec) then begin
                    AvailabilityCheckNotification.Id(GetItemAvailabilityNotificationId());
                    AvailabilityCheckNotification.Recall();
                    CurrPage.Update(false);
                end;
            end;
        }
    }
    local procedure GetItemAvailabilityNotificationId(): Guid
    begin
        exit('2712AD06-C48B-4C20-820E-347A60C9AD00');
    end;
}
