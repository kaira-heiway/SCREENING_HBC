codeunit 53004 BatchPostPrintMgt
{
    SingleInstance = true;

    var
        PrintInvoices: Boolean;
        InvoiceList: List of [Code[20]];

    procedure SetPrint(Value: Boolean)
    begin
        PrintInvoices := Value;
        Clear(InvoiceList);
    end;

    procedure GetPrint(): Boolean
    begin
        exit(PrintInvoices);
    end;

    procedure AddInvoice(No: Code[20])
    begin
        InvoiceList.Add(No);
    end;

    procedure GetInvoices(): List of [Code[20]]
    begin
        exit(InvoiceList);
    end;
}