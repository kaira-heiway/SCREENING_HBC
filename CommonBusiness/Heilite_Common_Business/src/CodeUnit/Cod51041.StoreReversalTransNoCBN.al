namespace CommonBusiness.CommonBusiness;
using Microsoft.Finance.GeneralLedger.Reversal;

codeunit 51041 "Store Reversal Trans.No CBN"
{
    SingleInstance = true;
    [EventSubscriber(ObjectType::Table, Database::"Reversal Entry", OnBeforeInsertReversalEntry, '', false, false)]
    local procedure OnBeforeInsertReversalEntry(var ReversalEntry: Record "Reversal Entry"; Number: Integer; RevType: Option Transaction,Register; var IsHandled: Boolean)
    begin
        Clear(TransNum);
        Clear(TransRevType);
        TransNum := Number;
        TransRevType := RevType;
    end;

    procedure GetTransNoAndType(var TransactionNo: Integer; var TransactionType: Option Transaction,Register)
    begin
        TransactionNo := TransNum;
        TransactionType := TransRevType;
    end;

    var
        TransNum: Integer;
        TransRevType: Option Transaction,Register;
}