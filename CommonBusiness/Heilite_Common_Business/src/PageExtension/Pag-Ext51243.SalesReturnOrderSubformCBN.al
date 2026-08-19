namespace General_MTC.General_MTC;

using Microsoft.Sales.Document;
using Microsoft.Foundation.AuditCodes;

pageextension 51243 SalesReturnOrderSubformextCBN extends "Sales Return Order Subform"
{
    // BC Upgrade SHUKLP03 >> Modified the OnLookup trigger of "Return Reason Code" field to filter out blocked return reasons in the lookup page, because we cannot modify base TableRelation.
    layout
    {
        modify("Return Reason Code")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                ReturnReason: Record "Return Reason";
                ReturnReasonList: Page "Return Reasons"; // adjust to actual lookup page
            begin
                ReturnReason.SetRange("Blocked FND", false);
                ReturnReasonList.SetTableView(ReturnReason);
                ReturnReasonList.LookupMode(true);
                if ReturnReasonList.RunModal() = Action::LookupOK then begin
                    ReturnReasonList.GetRecord(ReturnReason);
                    Text := ReturnReason.Code;
                    exit(true);
                end;
                exit(false);
            end;
        }
    }
}
