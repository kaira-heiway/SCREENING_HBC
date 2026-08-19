namespace Interface.Interface;
using Microsoft.Finance.GeneralLedger.Preview;
using Microsoft.Foundation.Navigate;
codeunit 58134 "GR Validation Hide Entries"
{
    // Only for GR Validation for SRM
    EventSubscriberInstance = Manual;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Preview", OnBeforeShowAllEntries, '', false, false)]
    local procedure OnBeforeShowAllEntries(var TempDocumentEntry: Record "Document Entry" temporary; var IsHandled: Boolean; var PostingPreviewEventHandler: Codeunit "Posting Preview Event Handler")
    begin
        IsHandled := true;
    end;
}