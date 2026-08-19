namespace Interface.Interface;
using System.Utilities;

codeunit 58135 "Error Message Hide TestScripts"
{
    SingleInstance = true;
    EventSubscriberInstance = Manual;
    [EventSubscriber(ObjectType::Table, Database::"Error Message", OnShowErrorsOnBeforeErrorMessagesRun, '', false, false)]
    local procedure OnShowErrorsOnBeforeErrorMessagesRun(var ErrorMessage: Record "Error Message"; var IsPageOpen: Boolean; var IsHandled: Boolean)
    begin
        checkError(ErrorMessage);
        IsHandled := true;
    end;

    // [TryFunction]
    procedure checkError(ErrorMessage: Record "Error Message"): text
    begin
        ErrorMessage.SetRange("Message Type", ErrorMessage."Message Type"::Error);
        if ErrorMessage.FindLast() then begin
            ErrorText := ErrorMessage."Message";
            exit(ErrorText);
        end;

    end;

    procedure ErrorMesage(): Text
    begin
        exit(ErrorText);
    end;


    var
        ErrorText: text;
        BatchName: Code[35];
        VendInvNo: Code[35];

}
