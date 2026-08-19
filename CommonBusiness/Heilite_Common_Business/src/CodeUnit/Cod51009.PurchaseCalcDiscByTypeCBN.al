codeunit 51009 "Purch-Calc Disc. By Type CBN"
{
    // version NAVW17.10

    // HEI.01 FDD-GAPLOG006 IBM ISYED01 29.09.2017 # Algerai Local
    //   # Imported  from HEI2.0 to support report ("50040 -Sales Invoice - Base")

    // BC Upgrade PATELP08 >> 
    // Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
    // BC Upgrade PATELP08 <<
    trigger OnRun();
    begin
    end;

    var
        InvDiscBaseAmountIsZeroErr: TextConst ENU = 'There is no amount that you can apply an invoice discount to.', FRA = 'Il n''existe pas de montant avec lequel vous pouvez lettrer une remise facture.';

    procedure ApplyDefaultInvoiceDiscount(InvoiceDiscountAmount: Decimal; var PurchaseHeader: Record "Purchase Header");
    begin
        if PurchaseHeader."Invoice Discount Calculation" = PurchaseHeader."Invoice Discount Calculation"::Amount then
            ApplyInvDiscBasedOnAmt(InvoiceDiscountAmount, PurchaseHeader)
        else
            ApplyInvDiscBasedOnPct(PurchaseHeader);
    end;

    procedure ApplyInvDiscBasedOnAmt(InvoiceDiscountAmount: Decimal; var PurchaseHeader: Record "Purchase Header");
    var
        PurchaseLine: Record "Purchase Line";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        InvDiscBaseAmount: Decimal;
    begin
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required
        // with PurchaseHeader do begin
        //     PurchaseLine.SETRANGE("Document No.", "No.");
        //     PurchaseLine.SETRANGE("Document Type", "Document Type");

        //     PurchaseLine.CalcVATAmountLines(0, PurchaseHeader, PurchaseLine, TempVATAmountLine);

        //     InvDiscBaseAmount := TempVATAmountLine.GetTotalInvDiscBaseAmount(false, "Currency Code");

        //     if (InvDiscBaseAmount = 0) and (InvoiceDiscountAmount > 0) then
        //         ERROR(InvDiscBaseAmountIsZeroErr);

        //     TempVATAmountLine.SetInvoiceDiscountAmount(InvoiceDiscountAmount, "Currency Code",
        //       "Prices Including VAT", "VAT Base Discount %");

        //     PurchaseLine.UpdateVATOnLines(0, PurchaseHeader, PurchaseLine, TempVATAmountLine);

        //     "Invoice Discount Calculation" := "Invoice Discount Calculation"::Amount;
        //     "Invoice Discount Value" := InvoiceDiscountAmount;

        //     MODIFY();
        // end;
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");

        PurchaseLine.CalcVATAmountLines(0, PurchaseHeader, PurchaseLine, TempVATAmountLine);

        InvDiscBaseAmount := TempVATAmountLine.GetTotalInvDiscBaseAmount(false, PurchaseHeader."Currency Code");

        if (InvDiscBaseAmount = 0) and (InvoiceDiscountAmount > 0) then
            ERROR(InvDiscBaseAmountIsZeroErr);

        TempVATAmountLine.SetInvoiceDiscountAmount(InvoiceDiscountAmount, PurchaseHeader."Currency Code",
            PurchaseHeader."Prices Including VAT", PurchaseHeader."VAT Base Discount %");

        PurchaseLine.UpdateVATOnLines(0, PurchaseHeader, PurchaseLine, TempVATAmountLine);

        PurchaseHeader."Invoice Discount Calculation" := PurchaseHeader."Invoice Discount Calculation"::Amount;
        PurchaseHeader."Invoice Discount Value" := InvoiceDiscountAmount;

        PurchaseHeader.MODIFY();
        // BC Upgrade PATELP08 <<
    end;

    local procedure ApplyInvDiscBasedOnPct(var PurchaseHeader: Record "Purchase Header");
    var
        PurchaseLine: Record "Purchase Line";
    begin
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required
        // with PurchaseHeader do begin
        //     PurchaseLine.SETRANGE("Document No.", "No.");
        //     PurchaseLine.SETRANGE("Document Type", "Document Type");
        //     if PurchaseLine.FINDFIRST() then begin
        //         CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount", PurchaseLine);
        //         GET("Document Type", "No.");
        //     end;
        // end;
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        if PurchaseLine.FINDFIRST() then begin
            CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount", PurchaseLine);
            PurchaseHeader.GET(PurchaseHeader."Document Type", PurchaseHeader."No.");
        end;
        // BC Upgrade PATELP08 <<
    end;

    procedure GetVendInvoiceDiscountPct(PurchaseLine: Record "Purchase Line"): Decimal;
    var
        PurchaseHeader: Record "Purchase Header";
        VendInvDisc: Record "Vendor Invoice Disc.";
    begin
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required
        // with PurchaseHeader do
        //     if GET(PurchaseLine."Document Type", PurchaseLine."Document No.") then
        //         if "Invoice Discount Calculation" = "Invoice Discount Calculation"::"%" then begin
        //             // Only if CustInvDisc table is empty header is not updated
        //             VendInvDisc.SETRANGE(Code, "Invoice Disc. Code");
        //             if not VendInvDisc.FINDFIRST() then
        //                 exit(0);

        //             exit("Invoice Discount Value");
        //         end;

        // // We are returning zero because Discount percentage from customer is not used
        // exit(0);
        if PurchaseHeader.GET(PurchaseLine."Document Type", PurchaseLine."Document No.") then
            if PurchaseHeader."Invoice Discount Calculation" = PurchaseHeader."Invoice Discount Calculation"::"%" then begin
                // Only if CustInvDisc table is empty header is not updated
                VendInvDisc.SETRANGE(Code, PurchaseHeader."Invoice Disc. Code");
                if not VendInvDisc.FINDFIRST() then
                    exit(0);

                exit(PurchaseHeader."Invoice Discount Value");
            end;

        // We are returning zero because Discount percentage from customer is not used
        exit(0);
        // BC Upgrade PATELP08 <<
    end;
}

