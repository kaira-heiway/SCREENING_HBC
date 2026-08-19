page 50066 "Issued Cash Collection Stats"
{
    // version NAVW110.0,HEI.02

    // HEI.01 FDD OTCGAP022 Heilite BASE IBM ISYED01 28/06/2017
    //   # Cash Collection order
    // HEI.02 FDD OTCGAP022 Heilite BASE IBM ISYED01 17/08/2017
    //   # Renamed field on page Amount To Collect

    Caption = 'Issued Cash Collection Stats';
    Editable = false;
    LinksAllowed = false;
    PageType = Card;
    SourceTable = "Issue Cash Collection Head FND";
    ApplicationArea = All;  // BC Upgrade Manisha
    UsageCategory = Administration;  // BC Upgrade Manisha

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    DrillDown = false;
                    ToolTip = 'Specifies the total of the remaining amounts on the reminder lines.';
                }
                field(AmountTocollect; AmountTocollect)
                {
                    Caption = 'Amount To Collect';
                    ToolTip = 'Specifies the value of the Amount To Collect field.';
                }
            }
            group(Customer)
            {
                Caption = 'Customer';
                field("Cust.""Balance (LCY)"""; Cust."Balance (LCY)")
                {
                    AutoFormatType = 1;
                    Caption = 'Balance (LCY)';
                    ToolTip = 'Specifies the value of the Balance (LCY) field.';
                }
                field("Cust.""Credit Limit (LCY)"""; Cust."Credit Limit (LCY)")
                {
                    AutoFormatType = 1;
                    Caption = 'Credit Limit (LCY)';
                    ToolTip = 'Specifies the value of the Credit Limit (LCY) field.';
                }
                field(CreditLimitLCYExpendedPct; CreditLimitLCYExpendedPct)
                {
                    Caption = 'Expended % of Credit Limit (LCY)';
                    ExtendedDatatype = Ratio;
                    ToolTip = 'Specifies the expended percentage of the credit limit in (LCY).';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    var
        CustPostingGr: Record "Customer Posting Group";
        GLAcc: Record "G/L Account";
        ReminderLevel: Record "Reminder Level";
        VATPostingSetup: Record "VAT Posting Setup";
        VATInterest: Decimal;
    begin
        Rec.CALCFIELDS("Interest Amount", "VAT Amount", "Add. Fee per Line");
        ReminderTotal := Rec."Remaining Amount" + Rec."Additional Fee" + Rec."Interest Amount" + Rec."VAT Amount" + Rec."Add. Fee per Line";
        VatAmount := Rec."VAT Amount";
        CustPostingGr.GET(Rec."Customer Posting Group");
        /*IF ReminderLevel.GET("Reminder Terms Code","Reminder Level") THEN
          IF ReminderLevel."Calculate Interest" AND ("VAT Amount" <> 0) THEN BEGIN*/
        GLAcc.GET(CustPostingGr."Interest Account");
        VATPostingSetup.GET(Rec."VAT Bus. Posting Group", GLAcc."VAT Prod. Posting Group");
        VATInterest := VATPostingSetup."VAT %";
        if GLAcc.GET(CustPostingGr."Additional Fee Account") then
            VATPostingSetup.GET(Rec."VAT Bus. Posting Group", GLAcc."VAT Prod. Posting Group");
        Interest :=
          (ReminderTotal -
           Rec."Remaining Amount" - (Rec."Additional Fee" + Rec."Add. Fee per Line") * (VATPostingSetup."VAT %" / 100 + 1)) /
          (VATInterest / 100 + 1);
        VatAmount := Interest * VATInterest / 100 + Rec."Additional Fee" * VATPostingSetup."VAT %" / 100 + Rec.CalculateLineFeeVATAmount();
        /*end else
          Interest := "Interest Amount";*/

        if Cust.GET(Rec."Customer No.") then
            Cust.CALCFIELDS("Balance (LCY)")
        else
            CLEAR(Cust);
        if Cust."Credit Limit (LCY)" = 0 then
            CreditLimitLCYExpendedPct := 0
        else
            CreditLimitLCYExpendedPct := ROUND(Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" * 10000, 1);

        AmountTocollect := 0;
        IssuedCashCollectionLine.SETRANGE("Cash Collection No.", Rec."No.");
        if IssuedCashCollectionLine.findset() then begin
            repeat
                AmountTocollect += IssuedCashCollectionLine.Amount;
            until IssuedCashCollectionLine.NEXT() = 0;
        end;

    end;

    var
        Cust: Record Customer;
        IssuedCashCollectionLine: Record "Issue Cash Collection Line FND";
        AmountTocollect: Decimal;
        CreditLimitLCYExpendedPct: Decimal;
        Interest: Decimal;
        ReminderTotal: Decimal;
        VatAmount: Decimal;
}

