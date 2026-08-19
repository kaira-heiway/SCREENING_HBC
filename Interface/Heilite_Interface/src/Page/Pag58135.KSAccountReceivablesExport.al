page 58135 "KS Account Receivables Export"
{
    //BC Upgrade SHIKHD02  >>
    // old object ID - 50345
    // added ApplicationArea and UsageCategory
    //added Rec for fields and SETFILTER in trigger OnOpenPage()
    //Blocked Drink-IT field "Item Charge Type" in trigger OnAfterGetRecord() 
    //BC Upgrade SHIKHD02  <<

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Cust. Ledger Entry";
    SourceTableView = SORTING("Entry No.")
                      WHERE("Document Type" = FILTER(Payment | Invoice | "Credit Memo"));
    //BC Upgrade SHIKHD02  >> added application area and usage category
    ApplicationArea = All;
    UsageCategory = Lists;
    //BC Upgrade SHIKHD02  <<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(CustomerCode; Rec."Sell-to Customer No.")
                {
                }
                field(InvoiceNumber; Rec."Document No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(InvoiceDate; ConvertDate(Rec."Posting Date"))
                {
                }
                field(DueDate; ConvertDate(Rec."Due Date"))
                {
                }
                field(Amount; Rec."Remaining Amount")
                {
                }
                field(sysModified; ConvertDate(Rec."Posting Date"))
                {
                }
                field(CurrencyCode; Currency)
                {
                }
                field(DocumentType; DocumentType)
                {
                }
                field(Last_Date_Modified; Rec."Posting Date")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        Rec.CALCFIELDS("Customer Account Group FND");
        if Rec."Document Type" <> Rec."Document Type"::Payment then
            Rec.SETRANGE("Customer Account Group FND", OrtecKStoreInterfaceSetup."Customer Account Group")
        else
            Rec.SETFILTER("Customer Account Group FND", '<>%1', 'Y006');
        if Rec."Currency Code" <> '' then
            Currency := Rec."Currency Code"
        else
            Currency := GeneralLedgerSetup."LCY Code";
        //BC Upgrade SHIKHD02 >> Blocking code ---> Drink-IT Field "Item Charge Type"
        // if Rec.Open then
        //     if Rec."Document Type" = Rec."Document Type"::Invoice then
        //         if "Item Charge Type" = "Item Charge Type"::Deposit then
        //             DocumentType := '11'
        //         else
        //             DocumentType := '10'
        //     else
        //         if Rec."Document Type" = Rec."Document Type"::"Credit Memo" then
        //             if "Item Charge Type" = "Item Charge Type"::Deposit then
        //                 DocumentType := '21'
        //             else
        //                 DocumentType := '20'
        //         else
        //             if (Rec."Document Type" = Rec."Document Type"::Payment) or (Rec."Document Type" = Rec."Document Type"::" ") then
        //                 DocumentType := '30';

        //DocumentType := '3'
        //ELSE
        //DocumentType := '5';
        //BC Upgrade SHIKHD02 <<
    end;

    trigger OnOpenPage();
    begin
        OrtecKStoreInterfaceSetup.GET();
        GeneralLedgerSetup.GET();
        OrtecKStoreInterfaceSetup.TESTFIELD("Customer Account Group");
        Rec.SETFILTER("Remaining Amount", '<>%1', 0);
    end;

    var
        OrtecKStoreInterfaceSetup: Record "Ortec & KStore Interf. Stp INT";
        Currency: Code[10];
        GeneralLedgerSetup: Record "General Ledger Setup";
        DocumentType: Text;

    local procedure ConvertDate(SysModified: Date): Text;
    var
        ReturnDate: Text;
    begin
        ReturnDate := FORMAT(SysModified, 0, '<Year4>-<Month,2>-<Day,2>') + 'T00:' + '00:00.000+00:00';
        exit(ReturnDate);
    end;
}

