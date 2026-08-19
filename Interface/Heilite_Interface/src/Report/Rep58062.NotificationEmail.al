reportextension 58062 NotificationEmailExt extends "Notification Email"
{
    dataset
    {
        modify("Notification Entry")
        {
            trigger OnBeforeAfterGetRecord()
            var
                NotificationSetup: Record "Notification Setup";
                RecipientUser: Record User;
            begin
                NotificationSetup.GetNotificationTypeSetupForUser(Type, RecipientUser."User Name")
            end;
        }
    }
}