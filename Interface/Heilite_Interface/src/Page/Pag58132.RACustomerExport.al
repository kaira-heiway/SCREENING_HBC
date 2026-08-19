page 58132 "RA Customer Export"
{
    // HEI.01 FDD-LC-HT736 IBM.GUNERE01 02.10.2019 # Object created,
    //                                             # LoC added to OnOpenPage func.
    //                                             # Address2, RemitTo, BillTo,
    //                                               AccountingNo, ARBalance, DefaultRouteWarehouse
    //                                               fields added to the page
    //                                  10.10.2019 # Code added to OnAfterGetRecord

    //Bc Upgrade YADAVM09 Drink it field commented<<
    //Bc Upgrade YADAVM09 old id is 50360.

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Customer;
    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(CustomerCode; Rec."No.")
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                }
                field(CreditLine; BillToCustomer."Credit Limit (LCY)")
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                }
                field(PaymentCondition; BillToCustomer."Payment Terms Code")
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                }
                field(PriceList; BillToCustomer."Customer Price Group")
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                }
                field(VatCode; BillToCustomer."VAT Bus. Posting Group")
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                }
                field(Address1; Rec.Address)
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                }
                field(Address2; Address2)
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                }
                field(DeliveryCity; Rec.City)
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                }
                field(DeliveryCountry; Rec."Country/Region Code")
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                }
                field(RemitTo; RemitTo)
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                }
                field(BillTo; BillTo)
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                    CaptionML = ENU = 'BillTo',
                                FRA = 'N°';
                }
                field(AccountingNo; AccountingNo)
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                    CaptionML = ENU = 'AccountingNo',
                                FRA = 'N°';
                }
                field(ARBalance; BillToCustomer."Balance (LCY)")
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                }
                field(DefaultRouteWarehouse; REC."Default Route 107FDW")
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                }
                field(RAStatus; RAStatus)
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                    Caption = 'RAStatus';
                }
                field(SearchName; SearchName)
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                    Caption = 'SearchName';
                }
                field(SellToCustomer; sell2customer)
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
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
        BillToCustomer.CALCFIELDS("Balance (LCY)");
        BillTo := Rec."No.";
        AccountingNo := Rec."No.";

        //>> HEI.01 FDD-LC-HT736 IBM.GUNERE01 10.10.2019
        if (Rec.Blocked = Rec.Blocked::All) or (Rec.Blocked = Rec.Blocked::Invoice) then
            RAStatus := false
        else
            RAStatus := true;

        if (Rec.Blocked = Rec.Blocked::All) or (Rec.Blocked = Rec.Blocked::Ship) then
            sell2customer := 'F'
        else
            sell2customer := 'T';

        if Rec."Address 2" = '' then
            Address2 := '-'
        else
            Address2 := Rec."Address 2";

        RemitTo := 2;
        if Rec."Search Name" <> '' then
            SearchName := COPYSTR(Rec."Search Name", 1, 30)
        else
            SearchName := '';
        //<< HEI.01 FDD-LC-HT736 IBM.GUNERE01 10.10.2019
    end;

    trigger OnOpenPage();
    begin
        OrtecKStoreInterfaceSetup.GET;
        GeneralLedgerSetup.GET;
        CompanyInformation.GET; // HEI.01 FDD-LC-HT736 IBM.GUNERE01 02.10.2019
        OrtecKStoreInterfaceSetup.TESTFIELD("Customer Account Group");
        Rec.SETRANGE("Account Group FND", OrtecKStoreInterfaceSetup."Customer Account Group");
        Rec.SETFILTER("Location Code", OrtecKStoreInterfaceSetup."Inventory Location Code");
    end;

    var
        OrtecKStoreInterfaceSetup: Record "Ortec & KStore Interf. Stp INT";
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
        CompanyInformation: Record "Company Information";
        Route: Record Route107FDW;//Bc Upgrade YADAVM09 Drink it object<<
        RAStatus: Boolean;
        Address2: Text;
        RemitTo: Integer;
        SearchName: Text;
        AccountingNo: Code[20];
        BillTo: Code[20];
        sell2customer: Code[1];

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

