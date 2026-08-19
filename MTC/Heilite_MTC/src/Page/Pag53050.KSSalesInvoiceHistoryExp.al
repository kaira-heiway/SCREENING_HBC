page 53050 "KS Sales Invoice History Exp"
{
    //BC Upgrade SHIKHD02  >>
    // old object ID - 50346
    //added Rec for fields 
    //BC Upgrade SHIKHD02  <<

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    SourceTable = "Sales Invoice Header";
    ApplicationArea = All;  //BC Upgrade SHIKHD02  <<

    layout
    {
        area(content)
        {
            group(General)
            {
                field(OrderNumber; Rec."Order No.")
                {
                }
                field(OrderDebtor; Rec."Sell-to Customer No.")
                {
                }
                field(OrderDeliveryDebtor; Rec."Bill-to Customer No.")
                {
                }
                field(OrderInvoiceDebtor; Rec."No.")
                {
                }
                field(OrderReference; Rec."Your Reference")
                {
                }
                field(OrderDate; ConvertDate(Rec."Document Date"))
                {
                }
                field(OrderDeliveryDate; ConvertDate(Rec."Shipment Date"))
                {
                }
                field(Warehouse; Rec."Location Code")
                {
                }
                field(Currency; Currency)
                {
                }
                field(PaymentCondition; Rec."Payment Terms Code")
                {
                }
                field(DeliveryMethod; Rec."Shipment Method Code")
                {
                }
                field(SalesRepresentative; SalesRepresentative)
                {
                }
                field(TotalAmountNET; Rec."Amount Including VAT")
                {
                }
                field(TotalAmountTaxes; Rec."Amount Including VAT" - Rec.Amount)
                {
                }
                field(TotalAmountGross; Rec.Amount)
                {
                }
                field(OrderDebtorName; Rec."Bill-to Name")
                {
                }
                field(OrderDebtorAddress1; Rec."Bill-to Address")
                {
                }
                field(OrderDebtorAddress2; Rec."Bill-to Address 2")
                {
                }
                field(OrderCity; Rec."Bill-to City")
                {
                }
                field(InvoiceCountry; Rec."Bill-to Country/Region Code")
                {
                }
                field(DeliveryDebtorName; Rec."Ship-to Name")
                {
                }
                field(DeliveryDebtorAddress1; Rec."Ship-to Address")
                {
                }
                field(DeliveryDebtorAddress2; Rec."Ship-to Address 2")
                {
                }
                field(DeliveryCity; Rec."Ship-to City")
                {
                }
                field(OrderDelivered; OrderDelivered)
                {
                }
                field(Sysmodified; ConvertDate(Rec."Posting Date"))
                {
                }
                field(OrderType; OrderType)
                {
                }
                field(OrderStatus; OrderStatus)
                {
                }
                field(OrderAuthorization; OrderAuthorization)
                {
                }
                field(OrderCountry; SellToCustomer."Country/Region Code")
                {
                }
                field(DeliveryCountry; Rec."Ship-to Country/Region Code")
                {
                }
                field(OrderApproved; OrderApproved)
                {
                }
                field(OrderContactName; Rec."Sell-to Customer Name")
                {
                }
                field(Last_Date_Modified; Rec."Posting Date")
                {
                }
                part(Control55027; "KS Sales Inv Line Subform")
                {
                    SubPageLink = "Document No." = FIELD("No.");
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        Rec.CALCFIELDS("Amount Including VAT", Amount);
        if Rec."Currency Code" <> '' then
            Currency := Rec."Currency Code"
        else
            Currency := GeneralLedgerSetup."LCY Code";

        if SellToCustomer.GET(Rec."Sell-to Customer No.") then;

        if Rec."Salesperson Code" <> '' then
            SalesRepresentative := Rec."Salesperson Code"
        else
            SalesRepresentative := '0';
    end;

    trigger OnOpenPage();
    begin
        GeneralLedgerSetup.GET();
        OrderDelivered := '1';
        Rec.SETRANGE("Vans Sales Route FND", true);
        OrderType := 'V';
        OrderStatus := '1';
        OrderAuthorization := 'J';
        OrderApproved := '1';
    end;

    var
        TOBEADDED: Text;
        OrderDelivered: Text;
        OrderType: Text;
        OrderStatus: Text;
        GeneralLedgerSetup: Record "General Ledger Setup";
        Currency: Code[10];
        OrderAuthorization: Text;
        SellToCustomer: Record Customer;
        OrderApproved: Text;
        SalesRepresentative: Text;
        SellToCustNo: Code[20];

    local procedure ConvertDate(SysModified: Date): Text;
    var
        ReturnDate: Text;
    begin
        ReturnDate := FORMAT(SysModified, 0, '<Year4>-<Month,2>-<Day,2>') + 'T00:' + '00:00.000+00:00';
        exit(ReturnDate);
    end;
}

