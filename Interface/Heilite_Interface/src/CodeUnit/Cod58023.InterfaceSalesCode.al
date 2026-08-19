namespace INTERFACES.INTERFACES;
using Heineken_BC_Upgrade.Heineken_BC_Upgrade;
using Microsoft.Sales.Posting;
using Microsoft.Sales.History;
using Microsoft.Sales.Document;

codeunit 58023 InterfaceSalesCode
{
    trigger OnRun()
    begin

    end;

    // BC Upgrade SHUKLP03 >> codeunit 80 "Sales-Post"
    // HEI.18 => Subscribed event OnAfterFinalizePostingOnBeforeCommit and OnPostResJnlLineOnAfterInit to add code of procedure FinalizePosting() and PostResJnlLine().

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterFinalizePostingOnBeforeCommit, '', false, false)]
    local procedure OnAfterFinalizePostingOnBeforeCommit(var SalesHeader: Record "Sales Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        PostSalesAPI: Codeunit "Auto Posting API Interfaces";
    begin
        //HEI.18>>
        IF SalesHeader."Source System Identifier FND" <> '' THEN
            IF SourceSystemIdentifierAPI.GET(SalesHeader."Source System Identifier FND") THEN
                IF SourceSystemIdentifierAPI."Automatic SO Posting" THEN
                    PostSalesAPI.PostResourceCostValues(SalesHeader, SalesInvoiceHeader."No.", SalesCrMemoHeader."No.");
        //HEI.18<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnPostResJnlLineOnAfterInit, '', false, false)]
    local procedure OnPostResJnlLineOnAfterInit(var SalesLine: Record "Sales Line")
    var
        // /ResJnlLine	Record	Res. Journal Line	
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        PostSalesAPI: Codeunit "Auto Posting API Interfaces";
        SalesHeader: Record "Sales Header";  // BC Upgrade SHUKLP03 <<
    begin
        //HEI.18>>
        IF SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.") THEN    // BC Upgrade SHUKLP03 << Added code to get SalesHeader.
            IF SalesHeader."Source System Identifier FND" <> '' THEN
                IF SourceSystemIdentifierAPI.GET(SalesHeader."Source System Identifier FND") THEN
                    IF SourceSystemIdentifierAPI."Automatic SO Posting" THEN
                        PostSalesAPI.PostResourceCostGLEntries(SalesHeader, SalesLine);
        //HEI.18<<
    end;


    // BC Upgrade SHUKLP03 >> codeunit 80 "Sales-Post"



}
