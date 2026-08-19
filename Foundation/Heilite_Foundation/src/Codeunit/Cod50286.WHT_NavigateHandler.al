using Microsoft.Foundation.Navigate;

codeunit 50286 "WHT Navigate Handler FND"
{
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        WithholdingTaxEntry: Record "WHT Entry FND";
        // WHTHooksAPS: Codeunit "WHT Hook APS";
        WHTMgtL: Codeunit WHTManagement;

    [EventSubscriber(ObjectType::Page, Page::Navigate, OnAfterNavigateFindRecords, '', false, false)]
    local procedure OnAfterNavigateFindRecords(var DocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text)
    begin
        if WithholdingTaxEntry.ReadPermission() then begin
            SetWithholdingEntryFilters(DocNoFilter, PostingDateFilter);
            DocumentEntry.InsertIntoDocEntry(Database::"WHT Entry FND", WithholdingTaxEntry.TableCaption(), WithholdingTaxEntry.Count);
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::Navigate, OnBeforeShowRecords, '', false, false)]
    local procedure OnBeforeShowRecords(var TempDocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text; var IsHandled: Boolean; ContactNo: Code[250])
    begin
        case TempDocumentEntry."Table ID" of
            Database::"WHT Entry FND":
                begin
                    SetWithholdingEntryFilters(DocNoFilter, PostingDateFilter);
                    Page.Run(Page::"WHT Entry", WithholdingTaxEntry);
                    IsHandled := true;
                end;
        end;
    end;

    local procedure SetWithholdingEntryFilters(DocNoFilter: Text; PostingDateFilter: Text)
    begin
        WithholdingTaxEntry.Reset();
        WithholdingTaxEntry.SetCurrentKey("Document No.", "Posting Date");
        WithholdingTaxEntry.SetFilter("Document No.", DocNoFilter);
        WithholdingTaxEntry.SetFilter("Posting Date", PostingDateFilter);
    end;
}
