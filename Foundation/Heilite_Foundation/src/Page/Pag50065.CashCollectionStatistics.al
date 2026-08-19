page 50065 "Cash Collection Statistics"
{
    // version NAVW110.0,HEI.02

    // HEI.01 FDD OTCGAP022 Heilite BASE IBM ISYED01 28/06/2017
    //   # Cash Collection order
    // HEI.02 FDD OTCGAP022 Heilite BASE IBM ISYED01 17/08/2017
    //   # Renamed field on page Amount To Collect

    Caption = 'Cash Collection Statistics';
    Editable = false;
    LinksAllowed = false;
    PageType = Card;
    SourceTable = "Cash Collection Header FND";
    ApplicationArea = All;  // BC Upgrade Manisha
    UsageCategory = Documents;  // BC Upgrade Manisha

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Remaining Amount"; rec."Remaining Amount")
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
        rec.CALCFIELDS("Interest Amount", "VAT Amount", "Add. Fee per Line");
        ReminderTotal := rec."Remaining Amount" + rec."Additional Fee" + rec."Interest Amount" + rec."VAT Amount" + rec."Add. Fee per Line";
        VatAmount := rec."VAT Amount";
        CustPostingGr.GET(rec."Customer Posting Group");
        VATInterest := 0;
        //IF ReminderLevel.GET("Reminder Terms Code","Reminder Level") THEN
        //IF ReminderLevel."Calculate Interest" AND ("VAT Amount" <> 0) THEN BEGIN
        GLAcc.GET(CustPostingGr."Interest Account");
        VATPostingSetup.GET(rec."VAT Bus. Posting Group", GLAcc."VAT Prod. Posting Group");
        VATInterest := VATPostingSetup."VAT %";
        if GLAcc.GET(CustPostingGr."Additional Fee Account") then
            VATPostingSetup.GET(rec."VAT Bus. Posting Group", GLAcc."VAT Prod. Posting Group");
        Interest :=
          (ReminderTotal -
           rec."Remaining Amount" - (rec."Additional Fee" + rec."Add. Fee per Line") * (VATPostingSetup."VAT %" / 100 + 1)) /
          (VATInterest / 100 + 1);
        VatAmount := Interest * VATInterest / 100 + rec."Additional Fee" * VATPostingSetup."VAT %" / 100 + rec.CalculateLineFeeVATAmount();
        //end else
        if Interest <> 0 then
            Interest := rec."Interest Amount";

        if Cust.GET(rec."Customer No.") then
            Cust.CALCFIELDS("Balance (LCY)")
        else
            CLEAR(Cust);
        if Cust."Credit Limit (LCY)" = 0 then
            CreditLimitLCYExpendedPct := 0
        else
            CreditLimitLCYExpendedPct := ROUND(Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" * 10000, 1);

        AmountTocollect := 0;
        CashCollectionLine.SETRANGE("Cash Collection No.", Rec."No.");
        if CashCollectionLine.findset() then begin
            repeat
                AmountTocollect += CashCollectionLine.Amount;
            until CashCollectionLine.NEXT() = 0;
        end;
    end;

    var
        CashCollectionLine: Record "Cash Collection Line FND";
        Cust: Record Customer;
        AmountTocollect: Decimal;
        CreditLimitLCYExpendedPct: Decimal;
        Interest: Decimal;
        ReminderTotal: Decimal;
        VatAmount: Decimal;
}

