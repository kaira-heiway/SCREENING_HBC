page 58029 "KS Customer Export"
{
    // Heilite Navision Old Id - 50327

    // version HEI.02

    // HEI.01
    // HEI.02 CHG2182881 IBM SOICAD02 22.11.2022  K store interface bug Fix for wrong VAT calculation
    // HEI.02 CHG2182881 IBM SOICAD02 29.11.2022  K store interface bug Second fix for wrong VAT calculation

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Customer;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(CustomerCode; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Currency; CurrencyCode)
                {
                    ToolTip = 'Specifies the value of the CurrencyCode field.';
                }
                field(VATNumber; Rec."VAT Registration No.")
                {
                    ToolTip = 'Specifies the value of the VAT Registration No. field.';
                }
                field(CreditLine; BillToCustomer."Credit Limit (LCY)")
                {
                    ToolTip = 'Specifies the value of the Credit Limit (LCY) field.';
                }
                field(PaymentCondition; BillToCustomer."Payment Terms Code")
                {
                    ToolTip = 'Specifies the value of the Payment Terms Code field.';
                }
                field(SalesRepresentative; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies the value of the Salesperson Code field.';
                }
                field(Status; Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(ExcludeFromKstore; ExcludeFromKStore)
                {
                    ToolTip = 'Specifies the value of the ExcludeFromKStore field.';
                }
                field(OnlyCotation; OnlyCotation)
                {
                    ToolTip = 'Specifies the value of the OnlyCotation field.';
                }
                field(ContactName; ContactName)
                {
                    ToolTip = 'Specifies the value of the ContactName field.';
                }
                field(PriceList; BillToCustomer."Customer Price Group")
                {
                    ToolTip = 'Specifies the value of the Customer Price Group field.';
                }
                field(VatCode; BillToCustomer."VAT Bus. Posting Group")
                {
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field.';
                }
                field("VAT%"; VATPerc)
                {
                    ToolTip = 'Specifies the value of the VATPerc field.';
                }
                field(SysModified; ConvertDate(rec."Last Date Modified"))
                {
                    ToolTip = 'Specifies the value of the Last Date Modified) field.';
                }
                field(DeliveryAddress; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field(DeliveryCity; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.';
                }
                field(DeliveryPostCode; Rec."Post Code")
                {
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
                field(DeliveryCountry; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                }
                field(InvoiceCity; BillToCustomer.City)
                {
                    ToolTip = 'Specifies the value of the City field.';
                }
                field(InvoiceCountry; BillToCustomer."Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                }
                field("Last_Date_Modified "; Rec."Last Date Modified")
                {
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        if BillToCustomer.GET(Rec."Bill-to Customer No.") then;
        if CustomerAttributes.GET(Rec."No.") then;

        if CustomerAttributes."C/O Name" <> '' then
            ContactName := CustomerAttributes."C/O Name"
        else
            ContactName := '-';
        VATPerc := 0;//HEI.02
        //VATPostingSetup.SETRANGE("VAT Bus. Posting Group",Rec."VAT Bus. Posting Group"); //HEI02 delete line
        VATPostingSetup.SETRANGE("VAT Bus. Posting Group", BillToCustomer."VAT Bus. Posting Group"); //HEI02 single line
        //VATPostingSetup.SETRANGE("VAT Prod. Posting Group", OrtecKStoreInterfaceSetup."Def. VAT Prod Pst Group");//HEI.02 single line //BC Upgrade SHARMP16-- Interface related code.
        if VATPostingSetup.FINDFIRST() then
            VATPerc := VATPostingSetup."VAT %";//HEI.02 single line

        if (Rec.Blocked = Rec.Blocked::All) or (Rec.Blocked = Rec.Blocked::Ship) then
            Status := 'B'
        else
            Status := 'A';

        ExcludeFromKStore := 0;
        OnlyCotation := 0;

        SysDateTime := CREATEDATETIME(BillToCustomer."Last Date Modified", 000000T);
        SysModified := FORMAT(SysDateTime, 0, 9);

        if BillToCustomer."Currency Code" = '' then
            CurrencyCode := GeneralLedgerSetup."LCY Code"
        else
            CurrencyCode := BillToCustomer."Currency Code";
    end;

    trigger OnOpenPage();
    begin
        OrtecKStoreInterfaceSetup.GET();//BC Upgrade SHARMP16-- Interface related code.
        GeneralLedgerSetup.GET();
        OrtecKStoreInterfaceSetup.TESTFIELD("Customer Account Group");//BC Upgrade SHARMP16-- Interface related code.
        rec.SETRANGE("Account Group FND", OrtecKStoreInterfaceSetup."Customer Account Group");//BC Upgrade SHARMP16-- Interface related code.
    end;

    var
        OrtecKStoreInterfaceSetup: Record "Ortec & KStore Interf. Stp INT";//BC Upgrade SHARMP16-- Interface related code.
        BillToCustomer: Record Customer;
        VATPostingSetup: Record "VAT Posting Setup";
        Status: Text;
        ExcludeFromKStore: Integer;
        OnlyCotation: Integer;
        CustomerAttributes: Record "Customer Attributes FND";
        ContactName: Text;
        SysModified: Text;
        SysDateTime: DateTime;
        CustGuid: Guid;
        CurrencyCode: Code[20];
        GeneralLedgerSetup: Record "General Ledger Setup";
        VATPerc: Decimal;

    local procedure ConvertDate(SysModified: Date): Text;
    var
        ReturnDate: Text;
    begin
        if SysModified = 0D then
            SysModified := TODAY;
        ReturnDate := FORMAT(SysModified, 0, '<Year4>-<Month,2>-<Day,2>') + 'T00:' + '00:00.000+00:00';
        exit(ReturnDate);
    end;
}

