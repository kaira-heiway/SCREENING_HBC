codeunit 55003 "Levy Custom RTR"
{
    //Bc Upgrade YADAVM09 codeunit create to compile all Levy code in single codeunit.
    Permissions = TableData "Detailed Vendor Ledg. Entry" = rimd;

    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforeDivideAmount, '', false, false)]
    local procedure OnBeforeDivideAmount(var PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; QtyType: Option General,Invoicing,Shipping; var PurchLineQty: Decimal; var TempVATAmountLine: Record "VAT Amount Line" temporary; var TempVATAmountLineRemainder: Record "VAT Amount Line" temporary; var IsHandled: Boolean)
    var
        Currency: Record Currency;
        NonDeductibleVAT: Codeunit "Non-Deductible VAT";
        OriginalDeferralAmount: Decimal;
    begin
        PurchasesPayablesSetup.Get();
        if PurchasesPayablesSetup."H&S Levy Tax FND" then
            if PurchLine."H&S Levy Tax % FND" <> 0 then begin
                if (PurchLineQty = 0) or (PurchLine."Direct Unit Cost" = 0) then begin
                    PurchLine."Line Amount" := 0;
                    PurchLine."Line Discount Amount" := 0;
                    PurchLine."Inv. Discount Amount" := 0;
                    PurchLine."VAT Base Amount" := 0;
                    PurchLine.Amount := 0;
                    PurchLine."Amount Including VAT" := 0;
                    OnDivideAmountOnAfterClearAmounts(PurchHeader, PurchLine, PurchLineQty);
                end else begin
                    OriginalDeferralAmount := PurchLine.GetDeferralAmount();
                    IsHandled := false;
                    OnDivideAmountOnBeforeTempVATAmountLineGet(PurchLine, TempVATAmountLine, IsHandled);
                    if not IsHandled then
                        TempVATAmountLine.Get(
                            PurchLine."VAT Identifier", PurchLine."VAT Calculation Type", PurchLine."Tax Group Code", PurchLine."Use Tax", PurchLine."Line Amount" >= 0);
                    if PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Sales Tax" then
                        PurchLine."VAT %" := TempVATAmountLine."VAT %";
                    TempVATAmountLineRemainder := TempVATAmountLine;
                    if not TempVATAmountLineRemainder.Find() then begin
                        TempVATAmountLineRemainder.Init();
                        TempVATAmountLineRemainder.Insert();
                    end;
                    CalcLineAmountAndLineDiscountAmount(PurchHeader, PurchLine, PurchLineQty, Currency);

                    OnDivideAmountOnAfterCalcLineAmountAndLineDiscountAmount(PurchHeader, PurchLine, PurchLineQty);

                    if PurchLine."Allow Invoice Disc." and (TempVATAmountLine."Inv. Disc. Base Amount" <> 0) then
                        if QtyType = QtyType::Invoicing then
                            PurchLine."Inv. Discount Amount" := PurchLine."Inv. Disc. Amount to Invoice"
                        else begin
                            TempVATAmountLineRemainder."Invoice Discount Amount" :=
                              TempVATAmountLineRemainder."Invoice Discount Amount" +
                              TempVATAmountLine."Invoice Discount Amount" * PurchLine."Line Amount" /
                              TempVATAmountLine."Inv. Disc. Base Amount";
                            PurchLine."Inv. Discount Amount" :=
                              Round(
                                TempVATAmountLineRemainder."Invoice Discount Amount", Currency."Amount Rounding Precision");
                            TempVATAmountLineRemainder."Invoice Discount Amount" :=
                              TempVATAmountLineRemainder."Invoice Discount Amount" - PurchLine."Inv. Discount Amount";
                        end;

                    if PurchHeader."Prices Including VAT" then begin
                        if (TempVATAmountLine.CalcLineAmount() = 0) or (PurchLine."Line Amount" = 0) then begin
                            TempVATAmountLineRemainder."VAT Amount" := 0;
                            TempVATAmountLineRemainder."Amount Including VAT" := 0;
                        end else begin
                            TempVATAmountLineRemainder."VAT Amount" +=
                              TempVATAmountLine."VAT Amount" * PurchLine.CalcLineAmount() / TempVATAmountLine.CalcLineAmount();
                            TempVATAmountLineRemainder."Amount Including VAT" +=
                              TempVATAmountLine."Amount Including VAT" * PurchLine.CalcLineAmount() / TempVATAmountLine.CalcLineAmount();
                        end;
                        CalculateAmountsInclVAT(PurchHeader, PurchLine, TempVATAmountLine, TempVATAmountLineRemainder);
                        TempVATAmountLineRemainder."Amount Including VAT" :=
                          TempVATAmountLineRemainder."Amount Including VAT" - PurchLine."Amount Including VAT";
                        TempVATAmountLineRemainder."VAT Amount" :=
                          TempVATAmountLineRemainder."VAT Amount" - PurchLine."Amount Including VAT" + PurchLine.Amount;
                    end else
                        if PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Full VAT" then begin
                            IsHandled := false;
                            OnDivideAmountOnBeforeCalcAmountsForFullVAT(PurchHeader, PurchLine, IsHandled);
                            if not IsHandled then
                                if PurchLine."Line Discount %" <> 100 then
                                    PurchLine."Amount Including VAT" := PurchLine.CalcLineAmount()
                                else
                                    PurchLine."Amount Including VAT" := 0;
                            PurchLine.Amount := 0;
                            PurchLine."VAT Base Amount" := 0;
                        end else begin
                            PurchLine.Amount := PurchLine.CalcLineAmount();
                            //HEI.45>>
                            IF PurchLine."H&S Levy Tax Amount FND" <> 0 THEN
                                PurchLine."VAT Base Amount" :=
                                  ROUND(
                                    PurchLine.Amount + PurchLine."H&S Levy Tax Amount FND" * (1 - PurchHeader."VAT Base Discount %" / 100), Currency."Amount Rounding Precision")
                            else //HEI.45
                                PurchLine."VAT Base Amount" :=
                                  Round(
                                    PurchLine.Amount * (1 - PurchHeader."VAT Base Discount %" / 100), Currency."Amount Rounding Precision");
                            OnDivideAmountOnAfterCalcVATBaseAmount(PurchLine);
                            if TempVATAmountLine."VAT Base" = 0 then
                                TempVATAmountLineRemainder."VAT Amount" := 0
                            else
                                IF PurchLine."H&S Levy Tax Amount FND" <> 0 THEN//HEI.45>>
                                    TempVATAmountLineRemainder."VAT Amount" :=
                                    TempVATAmountLineRemainder."VAT Amount" +
                                    TempVATAmountLine."VAT Amount" *
                                    (PurchLine."Line Amount" + PurchLine."H&S Levy Tax Amount FND" - PurchLine."Inv. Discount Amount") /
                                    (TempVATAmountLine."Line Amount" - TempVATAmountLine."Invoice Discount Amount")
                                ELSE   //HEI.45<<
                                    TempVATAmountLineRemainder."VAT Amount" +=
                                      TempVATAmountLine."VAT Amount" * PurchLine.CalcLineAmount() / TempVATAmountLine.CalcLineAmount();

                            IsHandled := false;
                            OnDivideAmountOnBeforeAmountIncludingVATAmountRound(PurchLine, TempVATAmountLineRemainder, Currency, IsHandled);
                            if not IsHandled then
                                if PurchLine."Line Discount %" <> 100 then
                                    PurchLine."Amount Including VAT" :=
                                        PurchLine.Amount + Round(TempVATAmountLineRemainder."VAT Amount", Currency."Amount Rounding Precision")
                                else
                                    PurchLine."Amount Including VAT" := 0;
                            TempVATAmountLineRemainder."VAT Amount" :=
                              TempVATAmountLineRemainder."VAT Amount" - PurchLine."Amount Including VAT" + PurchLine.Amount;
                        end;

                    NonDeductibleVAT.DivideNonDeductibleVATInPurchaseLine(
                        PurchLine, TempVATAmountLineRemainder, TempVATAmountLine, Currency, PurchLine.CalcLineAmount(), TempVATAmountLine.CalcLineAmount());

                    OnDivideAmountOnBeforeTempVATAmountLineRemainderModify(PurchHeader, PurchLine, TempVATAmountLine, TempVATAmountLineRemainder, Currency);
                    TempVATAmountLineRemainder.Modify();
#pragma warning disable AA0005
                    if PurchLine."Deferral Code" <> '' then begin
                        GetInvoicePostingSetup();
                        InvoicePostingInterface.CalcDeferralAmounts(PurchHeader, PurchLine, OriginalDeferralAmount);
                    end;
#pragma warning restore AA0005
                end;

                OnAfterDivideAmount(PurchHeader, PurchLine, QtyType, PurchLineQty, TempVATAmountLine, TempVATAmountLineRemainder);
                IsHandled := true;
            end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnDivideAmountOnBeforeTempVATAmountLineRemainderModify(PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var TempVATAmountLine: Record "VAT Amount Line" temporary; var TempVATAmountLineRemainder: Record "VAT Amount Line" temporary; Currency: Record Currency)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnDivideAmountOnAfterCalcVATBaseAmount(var PurchaseLine: Record "Purchase Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterDivideAmount(PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; QtyType: Option General,Invoicing,Shipping; PurchLineQty: Decimal; var TempVATAmountLine: Record "VAT Amount Line" temporary; var TempVATAmountLineRemainder: Record "VAT Amount Line" temporary)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnDivideAmountOnBeforeAmountIncludingVATAmountRound(var PurchaseLine: Record "Purchase Line"; var TempVATAmountLineRemainder: Record "VAT Amount Line" temporary; Currency: Record Currency; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnDivideAmountOnBeforeCalcAmountsForFullVAT(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
    end;

    local procedure CalcLineAmountAndLineDiscountAmount(PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; PurchLineQty: Decimal; currency: Record Currency)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCalcLineAmountAndLineDiscountAmount(PurchHeader, PurchLine, PurchLineQty, IsHandled, Currency);
        if IsHandled then
            exit;

        PurchLine."Line Amount" := PurchLine.GetLineAmountToHandleInclPrepmt(PurchLineQty) + CuPurchPost.GetPrepmtDiffToLineAmount(PurchLine);
        if PurchLineQty <> PurchLine.Quantity then
            PurchLine."Line Discount Amount" :=
              Round(PurchLine."Line Discount Amount" * PurchLineQty / PurchLine.Quantity, Currency."Amount Rounding Precision");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnDivideAmountOnAfterCalcLineAmountAndLineDiscountAmount(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; PurchaseLineQty: Decimal)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeCalcLineAmountAndLineDiscountAmount(PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; PurchLineQty: Decimal; var IsHandled: Boolean; Currency: Record Currency)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnDivideAmountOnBeforeTempVATAmountLineGet(PurchaseLine: Record "Purchase Line"; var TempVATAmountLine: Record "VAT Amount Line" temporary; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnDivideAmountOnAfterClearAmounts(var PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var PurchLineQty: Decimal)
    begin
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnSumVATAmountLineOnBeforeModify, '', false, false)]
    local procedure OnSumVATAmountLineOnBeforeModify(var PurchaseLine: Record "Purchase Line"; var VATAmountLine: Record "VAT Amount Line")
    var
    begin
        // if PurchaseLine."H&S Levy Tax Amount FND" <> 0 then begin
        //     VATAmountLine."Line Amount" += VATAmountLine."Line Amount" + PurchaseLine."H&S Levy Tax Amount FND";
        //     if PurchaseLine."Allow Invoice Disc." then
        //         VATAmountLine."Inv. Disc. Base Amount" += VATAmountLine."Inv. Disc. Base Amount" + PurchaseLine."H&S Levy Tax Amount FND";
        // end;//Temp Comment MYs
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforeInsertVAT, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnBeforeInsertVAT"(var GenJournalLine: Record "Gen. Journal Line"; var VATEntry: Record "VAT Entry"; var UnrealizedVAT: Boolean; var AddCurrencyCode: Code[10]; var VATPostingSetup: Record "VAT Posting Setup"; var GLEntryAmount: Decimal; var GLEntryVATAmount: Decimal; var GLEntryBaseAmount: Decimal; var SrcCurrCode: Code[10]; var SrcCurrGLEntryAmt: Decimal; var SrcCurrGLEntryVATAmt: Decimal; var SrcCurrGLEntryBaseAmt: Decimal; var IsHandled: Boolean)
    begin
        //HEI.42>>
        PurchasesPayablesSetup.Get();
#pragma warning disable AA0005
        if PurchasesPayablesSetup."H&S Levy Tax FND" then begin
            IF GenJournalLine."Document Type" = GenJournalLine."Document Type"::"Credit Memo" THEN
                GenJournalLine."H&S Levy Tax Amount FND" := -GenJournalLine."H&S Levy Tax Amount FND";
        end;
#pragma warning restore AA0005
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnSumPurchLines2OnAfterDivideAmount, '', false, false)]
    local procedure OnSumPurchLines2OnAfterDivideAmount(PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; QtyType: Option General,Invoicing,Shipping; PurchLineQty: Decimal; var TempVATAmountLine: Record "VAT Amount Line" temporary; var TempVATAmountLineRemainder: Record "VAT Amount Line" temporary)
    var
    begin
        PurchasesPayablesSetup.Get();
#pragma warning disable AA0005
        if PurchasesPayablesSetup."H&S Levy Tax FND" then begin
            //HEI.45>>
            IF PurchLine."H&S Levy Tax % FND" <> 0 THEN BEGIN
                IF (PurchLine."Document Type" = PurchLine."Document Type"::Invoice) OR (PurchLine."Document Type" = PurchLine."Document Type"::"Credit Memo") THEN
                    DivideAmount2(PurchHeader, PurchLine, QtyType, PurchLineQty, TempVATAmountLine, TempVATAmountLineRemainder);//HEI.45
            END;
        end;
#pragma warning restore AA0005

    end;

    local procedure DivideAmount2(PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; QtyType: Option General,Invoicing,Shipping; PurchLineQty: Decimal; var TempVATAmountLine: Record "VAT Amount Line" temporary; var TempVATAmountLineRemainder: Record "VAT Amount Line" temporary)
    var
        Currency: Record Currency;
        NonDeductibleVAT: Codeunit "Non-Deductible VAT";
        OriginalDeferralAmount: Decimal;
        IsHandled: Boolean;
        RoundingLineNo: Integer;
        RoundingLineInserted: Boolean;

    begin
        if RoundingLineInserted and (RoundingLineNo = PurchLine."Line No.") then
            exit;
        if Currency.get(PurchHeader."Currency Code") then;
        if (PurchLineQty = 0) or (PurchLine."Direct Unit Cost" = 0) then begin
            PurchLine."Line Amount" := 0;
            PurchLine."Line Discount Amount" := 0;
            PurchLine."Inv. Discount Amount" := 0;
            PurchLine."VAT Base Amount" := 0;
            PurchLine.Amount := 0;
            PurchLine."Amount Including VAT" := 0;
            // OnDivideAmountOnAfterClearAmounts(PurchHeader, PurchLine, PurchLineQty);
        end else begin
            OriginalDeferralAmount := PurchLine.GetDeferralAmount();
            IsHandled := false;
            // OnDivideAmountOnBeforeTempVATAmountLineGet(PurchLine, TempVATAmountLine, IsHandled);
            if not IsHandled then
                TempVATAmountLine.Get(
                    PurchLine."VAT Identifier", PurchLine."VAT Calculation Type", PurchLine."Tax Group Code", PurchLine."Use Tax", PurchLine."Line Amount" >= 0);
            if PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Sales Tax" then
                PurchLine."VAT %" := TempVATAmountLine."VAT %";
            TempVATAmountLineRemainder := TempVATAmountLine;
            if not TempVATAmountLineRemainder.Find() then begin
                TempVATAmountLineRemainder.Init();
                TempVATAmountLineRemainder.Insert();
            end;
            //   CalcLineAmountAndLineDiscountAmount(PurchHeader, PurchLine, PurchLineQty);
            PurchLine."Line Amount" := PurchLine.GetLineAmountToHandleInclPrepmt(PurchLineQty) + CuPurchPost.GetPrepmtDiffToLineAmount(PurchLine) + PurchLine."H&S Levy Tax Amount FND";
            if PurchLineQty <> PurchLine.Quantity then
                PurchLine."Line Discount Amount" :=
                  Round(PurchLine."Line Discount Amount" * PurchLineQty / PurchLine.Quantity, Currency."Amount Rounding Precision");


            //OnDivideAmountOnAfterCalcLineAmountAndLineDiscountAmount(PurchHeader, PurchLine, PurchLineQty);

            if PurchLine."Allow Invoice Disc." and (TempVATAmountLine."Inv. Disc. Base Amount" <> 0) then
                if QtyType = QtyType::Invoicing then
                    PurchLine."Inv. Discount Amount" := PurchLine."Inv. Disc. Amount to Invoice"
                else begin
                    TempVATAmountLineRemainder."Invoice Discount Amount" :=
                      TempVATAmountLineRemainder."Invoice Discount Amount" +
                      TempVATAmountLine."Invoice Discount Amount" * PurchLine."Line Amount" /
                      TempVATAmountLine."Inv. Disc. Base Amount";
                    PurchLine."Inv. Discount Amount" :=
                      Round(
                        TempVATAmountLineRemainder."Invoice Discount Amount", Currency."Amount Rounding Precision");
                    TempVATAmountLineRemainder."Invoice Discount Amount" :=
                      TempVATAmountLineRemainder."Invoice Discount Amount" - PurchLine."Inv. Discount Amount";
                end;

            if PurchHeader."Prices Including VAT" then begin
                if (TempVATAmountLine.CalcLineAmount() = 0) or (PurchLine."Line Amount" = 0) then begin
                    TempVATAmountLineRemainder."VAT Amount" := 0;
                    TempVATAmountLineRemainder."Amount Including VAT" := 0;
                end else begin
                    TempVATAmountLineRemainder."VAT Amount" +=
                      TempVATAmountLine."VAT Amount" * PurchLine.CalcLineAmount() / TempVATAmountLine.CalcLineAmount();
                    TempVATAmountLineRemainder."Amount Including VAT" +=
                      TempVATAmountLine."Amount Including VAT" * PurchLine.CalcLineAmount() / TempVATAmountLine.CalcLineAmount();
                end;
                CalculateAmountsInclVAT(PurchHeader, PurchLine, TempVATAmountLine, TempVATAmountLineRemainder);
                TempVATAmountLineRemainder."Amount Including VAT" :=
                  TempVATAmountLineRemainder."Amount Including VAT" - PurchLine."Amount Including VAT";
                TempVATAmountLineRemainder."VAT Amount" :=
                  TempVATAmountLineRemainder."VAT Amount" - PurchLine."Amount Including VAT" + PurchLine.Amount;
            end else
                if PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Full VAT" then begin
                    IsHandled := false;
                    //OnDivideAmountOnBeforeCalcAmountsForFullVAT(PurchHeader, PurchLine, IsHandled);
                    if not IsHandled then
                        if PurchLine."Line Discount %" <> 100 then
                            PurchLine."Amount Including VAT" := PurchLine.CalcLineAmount()
                        else
                            PurchLine."Amount Including VAT" := 0;
                    PurchLine.Amount := 0;
                    PurchLine."VAT Base Amount" := 0;
                end else begin
                    PurchLine.Amount := PurchLine.CalcLineAmount();
                    PurchLine."VAT Base Amount" :=
                      Round(
                        PurchLine.Amount * (1 - PurchHeader."VAT Base Discount %" / 100), Currency."Amount Rounding Precision");
                    OnDivideAmountOnAfterCalcVATBaseAmount(PurchLine);
                    if TempVATAmountLine."VAT Base" = 0 then
                        TempVATAmountLineRemainder."VAT Amount" := 0
                    else
                        TempVATAmountLineRemainder."VAT Amount" +=
                          TempVATAmountLine."VAT Amount" * PurchLine.CalcLineAmount() / TempVATAmountLine.CalcLineAmount();
                    IsHandled := false;
                    //OnDivideAmountOnBeforeAmountIncludingVATAmountRound(PurchLine, TempVATAmountLineRemainder, Currency, IsHandled);
                    if not IsHandled then
                        if PurchLine."Line Discount %" <> 100 then
                            PurchLine."Amount Including VAT" :=
                                PurchLine.Amount + Round(TempVATAmountLineRemainder."VAT Amount", Currency."Amount Rounding Precision")
                        else
                            PurchLine."Amount Including VAT" := 0;
                    TempVATAmountLineRemainder."VAT Amount" :=
                      TempVATAmountLineRemainder."VAT Amount" - PurchLine."Amount Including VAT" + PurchLine.Amount;
                end;

            NonDeductibleVAT.DivideNonDeductibleVATInPurchaseLine(
                PurchLine, TempVATAmountLineRemainder, TempVATAmountLine, Currency, PurchLine.CalcLineAmount(), TempVATAmountLine.CalcLineAmount());

            // OnDivideAmountOnBeforeTempVATAmountLineRemainderModify(PurchHeader, PurchLine, TempVATAmountLine, TempVATAmountLineRemainder, Currency);
            TempVATAmountLineRemainder.Modify();
#pragma warning disable AA0005
            if PurchLine."Deferral Code" <> '' then begin
                GetInvoicePostingSetup();
                InvoicePostingInterface.CalcDeferralAmounts(PurchHeader, PurchLine, OriginalDeferralAmount);
            end;
#pragma warning restore AA0005
        end;

        //OnAfterDivideAmount(PurchHeader, PurchLine, QtyType, PurchLineQty, TempVATAmountLine, TempVATAmountLineRemainder);
    end;

    local procedure GetInvoicePostingSetup()
    var
        IsHandled: Boolean;
        IsInterfaceInitialized: Boolean;
        HideProgressWindow: Boolean;
        PreviewMode: Boolean;
        SuppressCommit: Boolean;
    begin
        if IsInterfaceInitialized then
            exit;

        IsHandled := false;
        //  OnBeforeGetInvoicePostingSetup(InvoicePostingInterface, IsHandled);
        if not IsHandled then
            InvoicePostingInterface := Enum::"Purchase Invoice Posting"::"Invoice Posting (v.19)";

        InvoicePostingInterface.Check(Database::"Purchase Header");
        IsInterfaceInitialized := true;

        InvoicePostingInterface.SetHideProgressWindow(HideProgressWindow);
        InvoicePostingInterface.SetPreviewMode(PreviewMode);
        InvoicePostingInterface.SetSuppressCommit(SuppressCommit);
    end;

    local procedure CalculateAmountsInclVAT(PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var TempVATAmountLine: Record "VAT Amount Line" temporary; var TempVATAmountLineRemainder: Record "VAT Amount Line" temporary)
    var
        IsHandled: Boolean;
        Currency: Record Currency;
    begin
        // IsHandled := false;
        // OnBeforeCalculateAmountsInclVAT(PurchHeader, PurchLine, TempVATAmountLine, TempVATAmountLineRemainder, Currency, IsHandled);
        // if IsHandled then
        //     exit;
        if Currency.get(PurchHeader."Currency Code") then;
        if PurchLine."Line Discount %" <> 100 then
            PurchLine."Amount Including VAT" :=
                Round(TempVATAmountLineRemainder."Amount Including VAT", Currency."Amount Rounding Precision")
        else
            PurchLine."Amount Including VAT" := 0;
        PurchLine.Amount :=
            Round(PurchLine."Amount Including VAT", Currency."Amount Rounding Precision") -
            Round(TempVATAmountLineRemainder."VAT Amount", Currency."Amount Rounding Precision");
        PurchLine."VAT Base Amount" :=
            Round(
                PurchLine.Amount * (1 - PurchHeader."VAT Base Discount %" / 100), Currency."Amount Rounding Precision");
    end;


    [EventSubscriber(ObjectType::Table, database::"Invoice Posting Buffer", OnUpdateOnBeforeModify, '', false, false)]
    local procedure OnUpdateOnBeforeModify(var InvoicePostingBuffer: Record "Invoice Posting Buffer"; FromInvoicePostingBuffer: Record "Invoice Posting Buffer")
    var
    begin
        InvoicePostingBuffer."H&S Levy Tax Amount FND" += FromInvoicePostingBuffer."H&S Levy Tax Amount FND";//HEI.06
    end;

    [EventSubscriber(ObjectType::Table, database::"Invoice Posting Buffer", OnAfterCopyToGenJnlLine, '', false, false)]
    local procedure OnAfterCopyToGenJnlLine(var GenJnlLine: Record "Gen. Journal Line"; InvoicePostingBuffer: Record "Invoice Posting Buffer")
    var
    begin
        PurchasesPayablesSetup.Get();
        if PurchasesPayablesSetup."H&S Levy Tax FND" then begin
            //HEI.58>>
            GenJnlLine."H&S Levy Tax % FND" := InvoicePostingBuffer."H&S Levy Tax % FND";
            GenJnlLine."H&S Levy Tax Amount FND" := InvoicePostingBuffer."H&S Levy Tax Amount FND";
            GenJnlLine."HS Posting Group FND" := InvoicePostingBuffer."HS Posting Group FND";
            //HEI.58<<
        end;
    end;

    [EventSubscriber(ObjectType::Table, database::"Invoice Posting Buffer", OnAfterCopyToGenJnlLineFA, '', false, false)]
    local procedure OnAfterCopyToGenJnlLineFA(var GenJnlLine: Record "Gen. Journal Line"; InvoicePostingBuffer: Record "Invoice Posting Buffer")
    var
    begin
        PurchasesPayablesSetup.Get();
        if PurchasesPayablesSetup."H&S Levy Tax FND" then begin
            //HEI.58>>
            GenJnlLine."H&S Levy Tax % FND" := InvoicePostingBuffer."H&S Levy Tax % FND";
            GenJnlLine."H&S Levy Tax Amount FND" := InvoicePostingBuffer."H&S Levy Tax Amount FND";
            //HEI.58<<
        end;

    end;

    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", OnAfterCopyGLEntryFromGenJnlLine, '', false, false)]
    local procedure OnAfterCopyGLEntryFromGenJnlLineSubscriber(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    begin
        GLEntry."H&S Levy Tax Amount FND" := GenJournalLine."H&S Levy Tax Amount FND";//HEI.25
    end;
    //BC Upgrade KAPOOV01 <<

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforeCreateGLEntriesForTotalAmountsV19, '', false, false)]
    local procedure OnBeforeCreateGLEntriesForTotalAmountsV19(var Sender: Codeunit "Gen. Jnl.-Post Line"; var TempDimPostingBuffer: Record "Dimension Posting Buffer" temporary; GenJournalLine: Record "Gen. Journal Line"; var GLAccNo: Code[20]; var IsHandled: Boolean; AdjAmountBuf: array[4] of Decimal; SavedEntryNo: Integer; LedgEntryInserted: Boolean)
    var
        DimMgt: Codeunit DimensionManagement;
        GLEntryInserted: Boolean;
    begin
        PurchasesPayablesSetup.Get();
        if PurchasesPayablesSetup."H&S Levy Tax FND" then
            if GenJournalLine."H&S Levy Tax Amount FND" <> 0 then begin
                GLEntryInserted := false;

                TempDimPostingBuffer.Reset();
                if TempDimPostingBuffer.FindSet() then
                    repeat
                        if (TempDimPostingBuffer.Amount <> 0) or (TempDimPostingBuffer."Amount (ACY)" <> 0) and (AddCurrencyCode <> '') then begin
                            IsHandled := false;
                            OnCreateGLEntriesForTotalAmountsOnBeforeUpdateGenJnlLineDim(IsHandled);
                            if not IsHandled then
                                DimMgt.UpdateGenJnlLineDim(GenJournalLine, TempDimPostingBuffer."Dimension Set ID");
                            OnBeforeCreateGLEntryForTotalAmountsForDimPostBuf(GenJournalLine, TempDimPostingBuffer, GLAccNo);
                            CreateGLEntryForTotalAmounts(GenJournalLine, TempDimPostingBuffer.Amount, TempDimPostingBuffer."Amount (ACY)", AdjAmountBuf, SavedEntryNo, GLAccNo, Sender);
                            GLEntryInserted := true;
                        end;
                    until TempDimPostingBuffer.Next() = 0;

                if not GLEntryInserted and LedgEntryInserted then
                    CreateGLEntryForTotalAmounts(GenJournalLine, 0, 0, AdjAmountBuf, SavedEntryNo, GLAccNo, Sender);
                IsHandled := true;
            end;
    end;


    local procedure CreateGLEntryForTotalAmounts(GenJnlLine: Record "Gen. Journal Line"; Amount: Decimal; AmountACY: Decimal; AdjAmountBuf: array[4] of Decimal; var SavedEntryNo: Integer; GLAccNo: Code[20]; var Sender: Codeunit "Gen. Jnl.-Post Line")
    var
        GLEntry: Record "G/L Entry";
        IsHandled: Boolean;
        Currency: Record Currency;
        hsamount: Decimal;
        CUGenJnlLine: Codeunit "Gen. Jnl.-Post Line";
        TempGLEntryVATEntryLink: Record "G/L Entry - VAT Entry Link" temporary;
        GLEntryRec: Record "G/L Entry";
    begin
        //HEI.42>>
        PurchasesPayablesSetup.Get();
        if PurchasesPayablesSetup."H&S Levy Tax FND" then begin
            // GetTotalLevyTaxAmount(GlobalGLEntry2, GLEntryRec);
            CLEAR(hsamount);
            IF Amount < 0 THEN
                hsamount := -ROUND(GenJnlLine."H&S Levy Tax Amount FND", Currency."Amount Rounding Precision")
            ELSE
                hsamount := ROUND(GenJnlLine."H&S Levy Tax Amount FND", Currency."Amount Rounding Precision");

            IF PurchasesPayablesSetup."H&S Levy Tax FND" THEN
                Sender.HandleDtldAdjustment(
                  GenJnlLine, GLEntry, AdjAmountBuf, Amount + hsamount, AmountACY + hsamount, GLAccNo)
            ELSE//HE/I.42<<
                Sender.HandleDtldAdjustment(GenJnlLine, GLEntry, AdjAmountBuf, Amount, AmountACY, GLAccNo);
            GLEntry."Bal. Account Type" := GenJnlLine."Bal. Account Type";
            GLEntry."Bal. Account No." := GenJnlLine."Bal. Account No.";
            Sender.UpdateGLEntryNo(GLEntry."Entry No.", SavedEntryNo);

            IsHandled := false;
            OnCreateGLEntryForTotalAmountsOnBeforeInsertGLEntry(GenJnlLine, GLEntry, IsHandled, TempGLEntryVATEntryLink);
            if IsHandled then
                exit;

            Sender.InsertGLEntry(GenJnlLine, GLEntry, true);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreateGLEntryForTotalAmountsOnBeforeInsertGLEntry(var GenJnlLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var IsHandled: Boolean; var TempGLEntryVATEntryLink: Record "G/L Entry - VAT Entry Link" temporary);
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeCreateGLEntryForTotalAmountsForDimPostBuf(var GenJnlLine: Record "Gen. Journal Line"; TempDimPostingBuffer: Record "Dimension Posting Buffer" temporary; var GLAccNo: Code[20])
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnCreateGLEntriesForTotalAmountsOnBeforeUpdateGenJnlLineDim(var IsHandled: Boolean)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforeInsertDtldVendLedgEntryProcedure, '', false, false)]
    local procedure OnBeforeInsertDtldVendLedgEntryProcedure(GenJnlLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; var DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry"; var IsHandled: Boolean)
    var
        VendorLedgerEntry2: Record "Vendor Ledger Entry";
        TotalLevyTax: Decimal;
        Currency: Record Currency;
        DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        Offset: Integer;
        GLReg: Record "G/L Register";
        CdLevyCustomPreview: Codeunit "Levy Preview Custom RTR";
    begin
        PurchasesPayablesSetup.Get();
        if PurchasesPayablesSetup."H&S Levy Tax FND" then
            if GenJnlLine."H&S Levy Tax Amount FND" <> 0 then begin
                if DetailedVendorLedgEntry.FindLast() then
                    Offset := DetailedVendorLedgEntry."Entry No."
                else
                    Offset := 0;
                DtldVendLedgEntry.Init();
                DtldVendLedgEntry.TransferFields(DtldCVLedgEntryBuf);
                DtldVendLedgEntry."Entry No." := Offset + DtldCVLedgEntryBuf."Entry No.";
                DtldVendLedgEntry."Journal Batch Name" := GenJnlLine."Journal Batch Name";
                DtldVendLedgEntry."Reason Code" := GenJnlLine."Reason Code";
                DtldVendLedgEntry."Source Code" := GenJnlLine."Source Code";
                //DtldVendLedgEntry."Transaction No." := NextTransactionNo;//Bc Upgrade YADAVM09<<
                DtldVendLedgEntry."Transaction No." := CdLevyCustomPreview.GetNextTransactionNo();//Bc Upgrade YADAVM09<<
                                                                                                  //HEI.42>>
                CLEAR(TotalLevyTax);
                PurchasesPayablesSetup.GET();
                IF PurchasesPayablesSetup."H&S Levy Tax FND" THEN BEGIN
                    //   GetTotalLevyTaxAmount(GlobalGLEntry, GLEntryRec);
                    IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::Invoice THEN
                        TotalLevyTax := -GenJnlLine."H&S Levy Tax Amount FND";
                    IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Credit Memo" THEN BEGIN
                        IF DtldCVLedgEntryBuf.Amount > 0 THEN
                            TotalLevyTax := ROUND(GenJnlLine."H&S Levy Tax Amount FND", Currency."Amount Rounding Precision")
                        ELSE
                            TotalLevyTax := -ROUND(GenJnlLine."H&S Levy Tax Amount FND", Currency."Amount Rounding Precision");
                    END;
                END;
                IF GenJnlLine."H&S Levy Tax Amount FND" <> 0 THEN BEGIN
                    DtldVendLedgEntry.Amount := GenJnlLine.Amount + TotalLevyTax;
                    DtldVendLedgEntry."Amount (LCY)" := GenJnlLine."Amount (LCY)" + TotalLevyTax;
                END ELSE BEGIN
                    DtldVendLedgEntry.Amount := GenJnlLine.Amount + TotalLevyTax;
                    DtldVendLedgEntry."Amount (LCY)" := GenJnlLine."Amount (LCY)" + TotalLevyTax;
                END;
                //HEI.42<<
                VendorLedgerEntry2.Get(DtldCVLedgEntryBuf."CV Ledger Entry No.");
                DtldVendLedgEntry."Posting Group" := VendorLedgerEntry2."Vendor Posting Group";
                DtldVendLedgEntry.UpdateDebitCredit(GenJnlLine.Correction);
                OnBeforeInsertDtldVendLedgEntry(DtldVendLedgEntry, GenJnlLine, DtldCVLedgEntryBuf, GLReg);
                DtldVendLedgEntry.Insert(true);
                OnAfterInsertDtldVendLedgEntry(DtldVendLedgEntry, GenJnlLine, DtldCVLedgEntryBuf, Offset);
                IsHandled := true;//BC Upgrade YADAVM09<<
            end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInsertDtldVendLedgEntry(var DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; Offset: Integer)
    begin
    end;


    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertDtldVendLedgEntry(var DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; GLRegister: Record "G/L Register")
    begin
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPostGLAccOnBeforePostJob, '', false, false)]
    local procedure OnPostGLAccOnBeforePostJob(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var IsHandled: Boolean; Balancing: Boolean)
    var
        Text50000: label 'H&S Tax Posting Group must have value on HS Tax Posting Setup';

    begin
        //HEI.42>>
        PurchasesPayablesSetup.GET();
#pragma warning disable AA0005
        IF PurchasesPayablesSetup."H&S Levy Tax FND" THEN begin
            IF GenJournalLine."Document Type" = GenJournalLine."Document Type"::Invoice THEN BEGIN
                IF (GenJournalLine."H&S Levy Tax Amount FND" <> 0) THEN BEGIN
                    HSTaxPostingSetup.GET(GenJournalLine."HS Posting Group FND");//HEI.44
                    IF HSTaxPostingSetup."Purchase H&S Tax Account" = '' THEN
                        ERROR(Text50000, HSTaxPostingSetup."H&S Tax Posting Group");
                    Sender.CreateGLEntry(GenJournalLine, HSTaxPostingSetup."Purchase H&S Tax Account", ROUND(GLEntry."H&S Levy Tax Amount FND"), ROUND(GLEntry."H&S Levy Tax Amount FND"), TRUE);
                END;
            END ELSE IF GenJournalLine."Document Type" = GenJournalLine."Document Type"::"Credit Memo" THEN BEGIN
                IF (GenJournalLine."H&S Levy Tax Amount FND" <> 0) THEN BEGIN
                    HSTaxPostingSetup.GET(GenJournalLine."HS Posting Group FND");
                    IF HSTaxPostingSetup."Purchase H&S Tax Account" = '' THEN //HEI.44
                        ERROR(Text50000, HSTaxPostingSetup."H&S Tax Posting Group");
                    Sender.CreateGLEntry(GenJournalLine, HSTaxPostingSetup."Purchase H&S Tax Account", ROUND(-GLEntry."H&S Levy Tax Amount FND"), ROUND(-GLEntry."H&S Levy Tax Amount FND"), TRUE);
                END;
            END;
            //HEI.42<<
        end;
#pragma warning restore AA0005
    end;

    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        HSTaxPostingSetup: Record "H&S Tax Posting Setup FND";
        CuPurchPost: Codeunit "Purch.-Post";
        InvoicePostingInterface: Interface "Invoice Posting";

        AddCurrencyCode: Code[10];



    //codeunit50012 code>>

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure OnAfterValidatePurchLineNo(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        FixedAsset: Record "Fixed Asset";
        GLAcc: Record "G/L Account";
        HSTaxPostingSetup: Record "H&S Tax Posting Setup FND";
        Item: Record Item;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Text50000: Label 'Levy posting setup must have a value for %1.';
    begin
        //HEI.48>>
        if Rec.IsTemporary then
            exit;

        PurchasesPayablesSetup.Get();
        if not PurchasesPayablesSetup."H&S Levy Tax FND" then
            exit;
        if Rec.Type = Rec.Type::"G/L Account" then begin
            GLAcc.Get(Rec."No.");
            if HSTaxPostingSetup.Get(GLAcc."H&S Levy Tax Posting Group FND") then begin
                Rec."H&S Levy Tax % FND" := HSTaxPostingSetup."H&S Tax %";
                Rec."HS Posting Group FND" := HSTaxPostingSetup."H&S Tax Posting Group";//HEI.52
            end;
        end;

        if Rec.Type = Rec.Type::Item then begin
            Item.Get(Rec."No.");
            if HSTaxPostingSetup.Get(Item."H&S Levy Tax Posting Group FND") then begin
                Rec."H&S Levy Tax % FND" := HSTaxPostingSetup."H&S Tax %";
                Rec."HS Posting Group FND" := HSTaxPostingSetup."H&S Tax Posting Group";//HEI.52
            end;
        end;

        if Rec.Type = Rec.Type::"Fixed Asset" then begin
            FixedAsset.Get(Rec."No.");
            if HSTaxPostingSetup.Get(FixedAsset."H&S Levy Tax Posting Group FND") then begin
                Rec."H&S Levy Tax % FND" := HSTaxPostingSetup."H&S Tax %";
                Rec."HS Posting Group FND" := HSTaxPostingSetup."H&S Tax Posting Group";//HEI.52
            end;
        end;
        //HEI.48<<
    end;


    [EventSubscriber(ObjectType::Table, 39, 'OnBeforeUpdateAmounts', '', false, false)]
    local procedure OnBeforeupdateAmountPurchLine(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; CurrentFieldNo: Integer; var IsHandled: Boolean);
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Currency: Record Currency;
    begin
        //HEI.48>>
        PurchasesPayablesSetup.Get();
        if PurchasesPayablesSetup."H&S Levy Tax FND" then begin
            Clear(PurchaseLine."H&S Levy Tax Amount FND");
            Clear(PurchaseLine."Total Amount Excl VAT/H&S FND");
            if (PurchaseLine."Document Type" = PurchaseLine."Document Type"::Invoice) or (PurchaseLine."Document Type" = PurchaseLine."Document Type"::"Credit Memo") then begin
                if PurchasesPayablesSetup."H&S Levy Tax FND" then
                    if (PurchaseLine.Type = PurchaseLine.Type::Item) or (PurchaseLine.Type = PurchaseLine.Type::"G/L Account") or (PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset") then
                        if PurchaseLine."HS Posting Group FND" <> '' then //HEI.52
                            PurchaseLine.Validate("H&S Levy Tax Amount FND", Round(PurchaseLine."H&S Levy Tax Amount FND", Currency."Amount Rounding Precision") + Round(((PurchaseLine."Direct Unit Cost" * PurchaseLine.Quantity - PurchaseLine."Line Discount Amount") * PurchaseLine."H&S Levy Tax % FND") / 100, Currency."Amount Rounding Precision"));

                if PurchaseLine."Line Discount %" <> 0 then
                    PurchaseLine."Total Amount Excl VAT/H&S FND" := Round(PurchaseLine."Direct Unit Cost" * PurchaseLine.Quantity, Currency."Amount Rounding Precision") - PurchaseLine."Line Discount Amount" - Round(PurchaseLine."H&S Levy Tax Amount FND");

                if (PurchaseLine.Type = PurchaseLine.Type::Item) or (PurchaseLine.Type = PurchaseLine.Type::"G/L Account") or (PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset") then
                    if (PurchaseLine."HS Posting Group FND" <> '') then //HEI.52
                        PurchaseLine."Total Amount Excl VAT/H&S FND" := Round(PurchaseLine."Direct Unit Cost" * PurchaseLine.Quantity + PurchaseLine."H&S Levy Tax Amount FND", Currency."Amount Rounding Precision") - Round(PurchaseLine."H&S Levy Tax Amount FND") - PurchaseLine."Line Discount Amount";
            end;

            if PurchaseLine."HS Posting Group FND" <> '' then//HEI.52
                if (PurchaseLine.Type = PurchaseLine.Type::Item) or (PurchaseLine.Type = PurchaseLine.Type::"G/L Account") or (PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset") then
                    PurchaseLine."Line Amount" :=
                     Round((PurchaseLine.Quantity * PurchaseLine."Direct Unit Cost" + PurchaseLine."H&S Levy Tax Amount FND"), Currency."Amount Rounding Precision") - PurchaseLine."Line Discount Amount";
            //HEI.48<<
        end;
    end;

    [EventSubscriber(ObjectType::Table, 121, 'OnAfterCopyFromPurchRcptLine', '', false, false)]
    local procedure OnAfterCopyFromPurchRcptLine(var PurchaseLine: Record "Purchase Line"; PurchRcptLine: Record "Purch. Rcpt. Line"; var TempPurchLine: Record "Purchase Line");
    var
        GLAccount: Record "G/L Account";
        Item: Record Item;
        FixedAsset: Record "Fixed Asset";
        HSTaxPostingSetup: Record "H&S Tax Posting Setup FND";
    begin
        //HEI.48>>
        if (PurchaseLine."Document Type" = PurchaseLine."Document Type"::Invoice) or (PurchaseLine."Document Type" = PurchaseLine."Document Type"::"Credit Memo") then begin
            PurchasesPayablesSetup.Get();
            if PurchasesPayablesSetup."H&S Levy Tax FND" then begin
                if PurchaseLine.Type = PurchaseLine.Type::"G/L Account" then
                    if GLAccount.Get(PurchaseLine."No.") then
                        if HSTaxPostingSetup.Get(GLAccount."H&S Levy Tax Posting Group FND") then
                            PurchaseLine."H&S Levy Tax % FND" := HSTaxPostingSetup."H&S Tax %";
                PurchaseLine."HS Posting Group FND" := HSTaxPostingSetup."H&S Tax Posting Group";//HEI.52
            end;

            if PurchasesPayablesSetup."H&S Levy Tax FND" then begin
                if PurchaseLine.Type = PurchaseLine.Type::Item then
                    if Item.Get(PurchaseLine."No.") then
                        if HSTaxPostingSetup.Get(Item."H&S Levy Tax Posting Group FND") then
                            PurchaseLine."H&S Levy Tax % FND" := HSTaxPostingSetup."H&S Tax %";
                PurchaseLine."HS Posting Group FND" := HSTaxPostingSetup."H&S Tax Posting Group";//HEI.52
            end;
            if PurchasesPayablesSetup."H&S Levy Tax FND" then begin
                if PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset" then
                    if FixedAsset.Get(PurchaseLine."No.") then
                        if HSTaxPostingSetup.Get(FixedAsset."H&S Levy Tax Posting Group FND") then
                            PurchaseLine."H&S Levy Tax % FND" := HSTaxPostingSetup."H&S Tax %";
                PurchaseLine."HS Posting Group FND" := HSTaxPostingSetup."H&S Tax Posting Group";//HEI.52
            end;
            PurchaseLine."Total Amount Excl VAT/H&S FND" := PurchaseLine."Total Amount Excl VAT/H&S FND";
            PurchaseLine."HS Posting Group FND" := PurchaseLine."HS Posting Group FND";//HEI.52
            PurchaseLine."Line Amount" := Round(PurchaseLine."Line Amount" * HSTaxPostingSetup."H&S Tax %" / 100);
            PurchaseLine.Amount := Round(PurchaseLine."Line Amount" * HSTaxPostingSetup."H&S Tax %" / 100);
        end;
        //HEI.48<<
    end;

    // BC Upgrade POENAB02 <<



    [EventSubscriber(ObjectType::Table, 123, 'OnAfterInitFromPurchLine', '', false, false)]
    local procedure OnBeforePurchInvlineInsertForLevyTax(PurchInvHeader: Record "Purch. Inv. Header"; PurchLine: Record "Purchase Line"; var PurchInvLine: Record "Purch. Inv. Line");
    begin
        //HEI.48>>
        if (PurchLine."Document Type" = PurchLine."Document Type"::Invoice) or (PurchLine."Document Type" = PurchLine."Document Type"::"Credit Memo") then begin
            PurchasesPayablesSetup.Get();
            if PurchasesPayablesSetup."H&S Levy Tax FND" then
                if PurchLine."H&S Levy Tax % FND" <> 0 then begin
                    PurchInvLine."H&S Levy Tax % FND" := PurchLine."H&S Levy Tax % FND";
                    PurchInvLine."HS Posting Group FND" := PurchLine."HS Posting Group FND";//HEI.52
                    PurchInvLine."H&S Levy Tax Amount FND" := PurchLine."H&S Levy Tax Amount FND";
                    PurchInvLine."Total Amount Excl VAT/H&S FND" := PurchLine."Total Amount Excl VAT/H&S FND";
                    PurchInvLine."VAT Base Amount" := PurchLine."Line Amount" + PurchLine."H&S Levy Tax Amount FND";
                    PurchInvLine."Line Amount" := PurchLine."Line Amount" + PurchLine."H&S Levy Tax Amount FND";
                    PurchInvLine.Amount := PurchLine.Amount + PurchLine."H&S Levy Tax Amount FND";
                    PurchInvLine."Amount Including VAT" := PurchLine."Amount Including VAT" + PurchLine."H&S Levy Tax Amount FND";
                    InitFromLevyTaxEntries(PurchInvHeader, PurchLine, PurchInvLine);//HEI.50
                end;
        end;
        //HEI.48<<
    end;

    // BC Upgrade POENAB02 <<

    procedure InitFromLevyTaxEntries(PurchInvHeader: Record "Purch. Inv. Header"; PurchLine: Record "Purchase Line"; PurchInvLine: Record "Purch. Inv. Line");
    var
        LevyTaxEntries: Record "Levy Tax Entries FND";
        NextLeavyTaxEntryNo: Integer;
    begin
        //HEI.48>>
        LevyTaxEntries.LockTable();
        if PurchLine.Type <> PurchLine.Type::" " then begin
            LevyTaxEntries.Reset();
            if LevyTaxEntries.FindLast() then
                NextLeavyTaxEntryNo := LevyTaxEntries."Entry No." + 1
            else
                NextLeavyTaxEntryNo := 1;
            LevyTaxEntries.Init();
            LevyTaxEntries."Entry No." := NextLeavyTaxEntryNo;
            LevyTaxEntries."Transaction Type" := LevyTaxEntries."Transaction Type"::Invoice;//HEI.50
            LevyTaxEntries."Doc. No." := PurchInvHeader."No.";
            LevyTaxEntries."Unit of Measure" := PurchLine."Unit of Measure Code";
            LevyTaxEntries."Posting Date" := PurchInvHeader."Posting Date";
            LevyTaxEntries."Doc. Date" := PurchInvHeader."Document Date";
            LevyTaxEntries."Vendor No." := PurchInvHeader."Buy-from Vendor No.";
            LevyTaxEntries."Vendor Name" := PurchInvHeader."Buy-from Vendor Name";
            LevyTaxEntries."Line No." := PurchInvLine."Line No.";//HEI.50
            LevyTaxEntries."HS Posting Group" := PurchInvLine."HS Posting Group FND";//HEI.52
            LevyTaxEntries.Type := PurchLine.Type;
            LevyTaxEntries."No." := PurchLine."No.";
            LevyTaxEntries.Description := PurchLine.Description;
            LevyTaxEntries.Location := PurchLine."Location Code";
            LevyTaxEntries.Zone := PurchLine."Zone Code FND";
            LevyTaxEntries.Bin := PurchLine."Bin Code";
            LevyTaxEntries.Quantity := PurchLine.Quantity;
            LevyTaxEntries."Direct Unit Cost Exl. VAT" := PurchLine."Direct Unit Cost";
            LevyTaxEntries."Line Amount Excl. VAT" := PurchLine."Line Amount";
            LevyTaxEntries."H&S Levy Tax %" := PurchLine."H&S Levy Tax % FND";
            LevyTaxEntries."H&S Levy Tax Amount" := PurchLine."H&S Levy Tax Amount FND";
            LevyTaxEntries."Total Amount Excl VAT/H&S" := PurchLine."Total Amount Excl VAT/H&S FND";
            LevyTaxEntries."Discount %" := PurchLine."Line Discount %";
            LevyTaxEntries."Discount Line Amt Excl. VAT" := PurchLine."Line Discount Amount";
            LevyTaxEntries."Creation Date" := Today;
            LevyTaxEntries."User ID" := UserId;
            LevyTaxEntries."Inv Credit Memo No." := PurchInvHeader."Vendor Order No.";
            LevyTaxEntries."Total Amount Excl VAT/H&S" := PurchLine."Total Amount Excl VAT/H&S FND";
            LevyTaxEntries.Insert();
        end;
        //HEI.48<<
    end;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInsertValueEntry', '', false, false)]
    local procedure OnAfterInsertValueEntry(var ValueEntry: Record "Value Entry"; ItemJournalLine: Record "Item Journal Line");
    var
        LevyTaxEntries: Record "Levy Tax Entries FND";
    begin
        //HEI.50>>
        LevyTaxEntries.Reset();
        LevyTaxEntries.SetRange("Doc. No.", ValueEntry."Document No.");
        LevyTaxEntries.SetRange("Line No.", ValueEntry."Line No. FND");
        if LevyTaxEntries.FindFirst() then begin
            LevyTaxEntries."Value Entry No." := ValueEntry."Entry No.";
            LevyTaxEntries."ILE Entry No." := ValueEntry."Item Ledger Entry No.";
            LevyTaxEntries.Modify();
        end;
        //HEI.50<<
    end;

    [EventSubscriber(ObjectType::Table, 125, 'OnAfterInitFromPurchLine', '', false, false)]
    local procedure OnAfterInitFromPurchLine(PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; PurchLine: Record "Purchase Line"; var PurchCrMemoLine: Record "Purch. Cr. Memo Line");
    begin
        //HEI.48>>
        if (PurchLine."Document Type" = PurchLine."Document Type"::"Credit Memo") then begin
            PurchasesPayablesSetup.Get();
            if PurchasesPayablesSetup."H&S Levy Tax FND" then
                if PurchLine."H&S Levy Tax % FND" <> 0 then begin
                    PurchCrMemoLine."H&S Levy Tax % FND" := PurchLine."H&S Levy Tax % FND";
                    PurchCrMemoLine."HS Posting Group FND" := PurchLine."HS Posting Group FND";//HEI.52
                    PurchCrMemoLine."H&S Levy Tax Amount FND" := PurchLine."H&S Levy Tax Amount FND";
                    PurchCrMemoLine."Total Amount Excl VAT/H&S FND" := PurchLine."Total Amount Excl VAT/H&S FND";
                    PurchCrMemoLine."Line Amount" := PurchLine."Line Amount" + PurchLine."H&S Levy Tax Amount FND";
                    PurchCrMemoLine.Amount := PurchLine.Amount + PurchLine."H&S Levy Tax Amount FND";
                    PurchCrMemoLine."Amount Including VAT" := PurchLine."Amount Including VAT" + PurchLine."H&S Levy Tax Amount FND";
                    InitFromLevyTaxEntriesPurchCrMemo(PurchCrMemoHdr, PurchLine, PurchCrMemoLine);//HEI.50
                end;
        end;
        //HEI.48<<
    end;

    // BC Upgrade POENAB02 <<



    [EventSubscriber(ObjectType::Table, 6651, 'OnBeforeInsertShipmentForLevyTax', '', false, false)]
    local procedure OnBeforeInsertShipmentForLevyTax(var PurchLine: Record "Purchase Line");
    var
        GLAccount: Record "G/L Account";
        Item: Record Item;
        FixedAsset: Record "Fixed Asset";
        HSTaxPostingSetup: Record "H&S Tax Posting Setup FND";
    begin
        //HEI.48>>
        if (PurchLine."Document Type" = PurchLine."Document Type"::Invoice) or (PurchLine."Document Type" = PurchLine."Document Type"::"Credit Memo") then begin
            PurchasesPayablesSetup.Get();
            if PurchasesPayablesSetup."H&S Levy Tax FND" then
                if PurchLine."H&S Levy Tax % FND" <> 0 then begin
                    if PurchLine.Type = PurchLine.Type::"G/L Account" then
                        if GLAccount.Get(PurchLine."No.") then
                            if HSTaxPostingSetup.Get(GLAccount."H&S Levy Tax Posting Group FND") then
                                PurchLine."H&S Levy Tax % FND" := HSTaxPostingSetup."H&S Tax %";
                    PurchLine."HS Posting Group FND" := HSTaxPostingSetup."H&S Tax Posting Group";//HEI.52
                end;

            if PurchasesPayablesSetup."H&S Levy Tax FND" then
                if PurchLine."H&S Levy Tax % FND" <> 0 then begin
                    if PurchLine.Type = PurchLine.Type::Item then
                        if Item.Get(PurchLine."No.") then
                            if HSTaxPostingSetup.Get(Item."H&S Levy Tax Posting Group FND") then
                                PurchLine."H&S Levy Tax % FND" := HSTaxPostingSetup."H&S Tax %";
                    PurchLine."HS Posting Group FND" := HSTaxPostingSetup."H&S Tax Posting Group";//HEI.52
                end;

            if PurchasesPayablesSetup."H&S Levy Tax FND" then
                if PurchLine."H&S Levy Tax % FND" <> 0 then begin
                    if PurchLine.Type = PurchLine.Type::"Fixed Asset" then
                        if FixedAsset.Get(PurchLine."No.") then
                            if HSTaxPostingSetup.Get(FixedAsset."H&S Levy Tax Posting Group FND") then
                                PurchLine."H&S Levy Tax % FND" := HSTaxPostingSetup."H&S Tax %";
                    PurchLine."HS Posting Group FND" := HSTaxPostingSetup."H&S Tax Posting Group";//HEI.52
                end;

            if PurchLine."H&S Levy Tax % FND" <> 0 then begin
                PurchLine."H&S Levy Tax Amount FND" := Round(PurchLine."Line Amount" * PurchLine."H&S Levy Tax % FND" / 100);
                PurchLine."Total Amount Excl VAT/H&S FND" := PurchLine."Total Amount Excl VAT/H&S FND";
                PurchLine."HS Posting Group FND" := PurchLine."HS Posting Group FND";//HEI.52
                PurchLine."Line Amount" := Round(PurchLine."Line Amount" + PurchLine."H&S Levy Tax Amount FND");
                PurchLine."Total Amount Excl VAT/H&S FND" := PurchLine."Line Amount" - PurchLine."H&S Levy Tax Amount FND";
                PurchLine.Amount := PurchLine.Amount + PurchLine."H&S Levy Tax Amount FND";
                PurchLine."Amount Including VAT" := PurchLine."Amount Including VAT" + PurchLine."H&S Levy Tax Amount FND";
            end;
        end;
        //HEI.48<<
    end;

    // BC Upgrade POENAB02 <<


    [EventSubscriber(ObjectType::Codeunit, 6620, 'OnAfterCopyPurchaseDocument', '', false, false)]
    local procedure OnAfterCopyPurchaseDocument(FromDocumentType: Option; FromDocumentNo: Code[20]; var ToPurchaseHeader: Record "Purchase Header");
    var
        PurchaseLine: Record "Purchase Line";
        LAAmountC: Decimal;
        LAmountI: Decimal;
    begin

        //HEI.48>>
        Clear(LAmountI);
        Clear(LAAmountC);
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", ToPurchaseHeader."No.");
        PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Invoice);
        PurchaseLine.SetFilter("H&S Levy Tax % FND", '<>%1', 0);
        if PurchaseLine.FindSet(true) then
            repeat
                LAmountI := PurchaseLine."Total Amount Excl VAT/H&S FND" + PurchaseLine."H&S Levy Tax Amount FND";
                if PurchaseLine."Line Amount" <> LAmountI then
                    PurchaseLine."Line Amount" := PurchaseLine."Line Amount" + PurchaseLine."H&S Levy Tax Amount FND";
                PurchaseLine."HS Posting Group FND" := PurchaseLine."HS Posting Group FND";//HEI.52
                PurchaseLine.Modify();
            until PurchaseLine.Next() = 0;

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", ToPurchaseHeader."No.");
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::"Credit Memo");
        PurchaseLine.SetFilter("H&S Levy Tax % FND", '<>%1', 0);
        if PurchaseLine.FindSet(true) then
            repeat
                LAAmountC := PurchaseLine."Total Amount Excl VAT/H&S FND" + PurchaseLine."H&S Levy Tax Amount FND";
                if PurchaseLine."Line Amount" <> LAAmountC then
                    PurchaseLine."Line Amount" := PurchaseLine."Line Amount" + PurchaseLine."H&S Levy Tax Amount FND";
                PurchaseLine."HS Posting Group FND" := PurchaseLine."HS Posting Group FND";//HEI.52
                PurchaseLine.Modify();
            until PurchaseLine.Next() = 0;
        //HEI.48<<
    end;


    procedure InitFromLevyTaxEntriesPurchCrMemo(PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; PurchLine: Record "Purchase Line"; PurchCrMemoLine: Record "Purch. Cr. Memo Line");
    var
        LevyTaxEntries: Record "Levy Tax Entries FND";
        NextLeavyTaxEntryNo: Integer;
    begin
        //HEI.48>>
        LevyTaxEntries.LockTable();
        if PurchLine.Type <> PurchLine.Type::" " then begin
            LevyTaxEntries.Reset();
            if LevyTaxEntries.FindLast() then
                NextLeavyTaxEntryNo := LevyTaxEntries."Entry No." + 1
            else
                NextLeavyTaxEntryNo := 1;
            LevyTaxEntries.Init();
            LevyTaxEntries."Entry No." := NextLeavyTaxEntryNo;
            LevyTaxEntries."Transaction Type" := LevyTaxEntries."Transaction Type"::"Credit Memo";//HEI.50
            LevyTaxEntries."Doc. No." := PurchCrMemoHdr."No.";
            LevyTaxEntries."Unit of Measure" := PurchLine."Unit of Measure Code";
            LevyTaxEntries."Posting Date" := PurchCrMemoHdr."Posting Date";
            LevyTaxEntries."Doc. Date" := PurchCrMemoHdr."Document Date";
            LevyTaxEntries."Vendor No." := PurchCrMemoHdr."Buy-from Vendor No.";
            LevyTaxEntries."Vendor Name" := PurchCrMemoHdr."Buy-from Vendor Name";
            LevyTaxEntries."Line No." := PurchCrMemoLine."Line No.";//HEI.50
            LevyTaxEntries."HS Posting Group" := PurchLine."HS Posting Group FND";//HEI.52
            LevyTaxEntries.Type := PurchLine.Type;
            LevyTaxEntries."No." := PurchLine."No.";
            LevyTaxEntries.Description := PurchLine.Description;
            LevyTaxEntries.Location := PurchLine."Location Code";
            LevyTaxEntries.Zone := PurchLine."Zone Code FND";
            LevyTaxEntries.Bin := PurchLine."Bin Code";
            LevyTaxEntries.Quantity := PurchLine.Quantity;
            LevyTaxEntries."Direct Unit Cost Exl. VAT" := PurchLine."Direct Unit Cost";
            LevyTaxEntries."Line Amount Excl. VAT" := PurchLine."Line Amount";
            LevyTaxEntries."H&S Levy Tax %" := PurchLine."H&S Levy Tax % FND";
            LevyTaxEntries."H&S Levy Tax Amount" := PurchLine."H&S Levy Tax Amount FND";
            LevyTaxEntries."Total Amount Excl VAT/H&S" := PurchLine."Total Amount Excl VAT/H&S FND";
            LevyTaxEntries."Discount %" := PurchLine."Line Discount %";
            LevyTaxEntries."Discount Line Amt Excl. VAT" := PurchLine."Line Discount Amount";
            LevyTaxEntries."Creation Date" := Today;
            LevyTaxEntries."User ID" := UserId;
            LevyTaxEntries."Inv Credit Memo No." := PurchCrMemoHdr."Vendor Cr. Memo No.";
            LevyTaxEntries."Total Amount Excl VAT/H&S" := PurchLine."Total Amount Excl VAT/H&S FND";
            LevyTaxEntries.Insert();
        end;
        //HEI.48<<
    end;


    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'HS Posting Group FND', false, false)]
    local procedure OnAfterValidatePurchlineHspostingGroup(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        HSTaxPostingsetup: Record "H&S Tax Posting Setup FND";
    begin
        //HEI.52
        if (Rec.Type = Rec.Type::"G/L Account") or (Rec.Type = Rec.Type::Item) or (Rec.Type = Rec.Type::"Fixed Asset") then
            if HSTaxPostingsetup.Get(Rec."HS Posting Group FND") then
                Rec."H&S Levy Tax % FND" := HSTaxPostingsetup."H&S Tax %";
        Rec.UpdateAmounts();
        //HEI.52
    end;
    //Codeunit 50012 code<<

    //Codeunit-90-


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", OnBeforeInitGenJnlLine, '', false, false)]
    local procedure OnBeforeInitGenJnlLine(InvoicePostingBuffer: Record "Invoice Posting Buffer" temporary; PurchHeader: Record "Purchase Header"; var GenJnlLine: Record "Gen. Journal Line")
    begin

        //HEI.06
        GenJnlLine."H&S Levy Tax Amount FND" := InvoicePostingBuffer."H&S Levy Tax Amount FND";
        GenJnlLine."H&S Levy Tax % FND" := InvoicePostingBuffer."H&S Levy Tax % FND";
        GenJnlLine."HS Posting Group FND" := InvoicePostingBuffer."HS Posting Group FND";
        //HEI.06

    end;
    //codeunit-90+


    [EventSubscriber(ObjectType::Page, PAGE::Navigate, OnAfterFindRecords, '', false, false)]
    local procedure OnAfterFindRecords(var DocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text)
    var
    begin
        //HEI.04>>
        IF LevyTaxEntries.READPERMISSION THEN BEGIN
            LevyTaxEntries.RESET();
            LevyTaxEntries.SETCURRENTKEY("Doc. No.", "Posting Date");
            LevyTaxEntries.SETFILTER("Doc. No.", DocNoFilter);
            LevyTaxEntries.SETFILTER("Posting Date", PostingDateFilter);
            DocumentEntry.InsertIntoDocEntry(
              DATABASE::"Levy Tax Entries FND", LevyTaxEntries.TABLECAPTION, LevyTaxEntries.COUNT);
        END;
        //HEI.04<<
    end;

    [EventSubscriber(ObjectType::Page, PAGE::Navigate, OnAfterShowRecords, '', false, false)]
    local procedure OnAfterShowRecords(var DocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text; ItemTrackingSearch: Boolean; ContactType: Enum "Navigate Contact Type"; ContactNo: Code[250]; ExtDocNo: Code[250])
    var
        LocalLevyTaxEntries: Record "Levy Tax Entries FND";
    begin
        LocalLevyTaxEntries.RESET();
        LocalLevyTaxEntries.SETCURRENTKEY("Doc. No.", "Posting Date");
        LocalLevyTaxEntries.FilterGroup(2);
        LocalLevyTaxEntries.SETFILTER("Doc. No.", DocNoFilter);
        LocalLevyTaxEntries.SETFILTER("Posting Date", PostingDateFilter);
        LocalLevyTaxEntries.FilterGroup(0);
        //HEI.04>>
        case DocumentEntry."Table ID" of
            Database::"Levy Tax Entries FND":
#pragma warning disable AA0005
                begin
                    if DocumentEntry."No. of Records" = 1 then
                        Page.Run(Page::"Levy Tax Entries", LocalLevyTaxEntries)
                    else
                        Page.Run(Page::"Levy Tax Entries", LocalLevyTaxEntries);
                end;
#pragma warning restore AA0005

        end;

        //HEI.04<<
    end;


    //Codeunit
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnBeforeUpdateLineAmount, '', false, false)]
    local procedure OnBeforeUpdateLineAmount(Currency: Record Currency; var LineAmountChanged: Boolean; var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; sender: Record "Purchase Line"; var IsHandled: Boolean)
    var
        NonDeductibleVAT: Codeunit "Non-Deductible VAT";
    begin
        PurchasesPayablesSetup.Get();
        if PurchasesPayablesSetup."H&S Levy Tax FND" then
            if PurchaseLine."H&S Levy Tax % FND" <> 0 then begin
                if PurchaseLine."Line Amount" <> xPurchaseLine."Line Amount" then begin
                    PurchaseLine."VAT Difference" := 0;
                    NonDeductibleVAT.InitNonDeductibleVATDiff(PurchaseLine);
                    LineAmountChanged := true;
                end;
                if PurchaseLine."Line Amount" <> Round(PurchaseLine.Quantity * PurchaseLine."Direct Unit Cost", Currency."Amount Rounding Precision") - PurchaseLine."Line Discount Amount" then begin
                    //HEI.67>>
                    IF PurchaseLine."H&S Levy Tax % FND" <> 0 THEN
                        PurchaseLine."Line Amount" :=
                      ROUND(PurchaseLine.Quantity * PurchaseLine."Direct Unit Cost" + PurchaseLine."H&S Levy Tax Amount FND", Currency."Amount Rounding Precision") - PurchaseLine."Line Discount Amount"
                    ELSE//HEI.67<<
                        PurchaseLine."Line Amount" :=
                          Round(PurchaseLine.Quantity * PurchaseLine."Direct Unit Cost", Currency."Amount Rounding Precision") - PurchaseLine."Line Discount Amount";
                    PurchaseLine."VAT Difference" := 0;
                    NonDeductibleVAT.InitNonDeductibleVATDiff(PurchaseLine);
                    LineAmountChanged := true;
                end;
                IsHandled := true;
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", OnPostLedgerEntryOnBeforeGenJnlPostLine, '', false, false)]
    local procedure OnPostLedgerEntryOnBeforeGenJnlPostLine(var GenJnlLine: Record "Gen. Journal Line"; var PurchHeader: Record "Purchase Header"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line")
    var
        PurchaseLine: record "Purchase Line";
        PurchLine2: Record "Purchase Line";
        CurrExchRate: record "Currency Exchange Rate";
        TotalWHTLCY: Decimal;

    begin
        PurchasesPayablesSetup.Get();
        if PurchasesPayablesSetup."H&S Levy Tax FND" then begin
            PurchLine2.Reset();
            PurchLine2.SetRange("Document No.", PurchHeader."No.");
            PurchLine2.SetRange("Document Type", PurchHeader."Document Type");
            if PurchLine2.FindSet() then
                repeat
                    if PurchLine2."H&S Levy Tax Amount FND" <> 0 then begin
                        GenJnlLine."H&S Levy Tax % FND" := PurchLine2."H&S Levy Tax % FND";
                        GenJnlLine."H&S Levy Tax Amount FND" += PurchLine2."H&S Levy Tax Amount FND";
                        GenJnlLine."HS Posting Group FND" := PurchLine2."HS Posting Group FND";
                    end;
                until PurchLine2.Next() = 0;

        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnCalcVATAmountLinesOnAfterCalcLineTotals, '', false, false)]
    local procedure OnCalcVATAmountLinesOnAfterCalcLineTotals(var VATAmountLine: Record "VAT Amount Line"; PurchaseHeader: Record "Purchase Header"; PurchaseLine: Record "Purchase Line"; Currency: Record Currency; QtyType: Option General,Invoicing,Shipping; var TotalVATAmount: Decimal)
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        //HEI.67>>
        IF (PurchaseLine."Document Type" = PurchaseLine."Document Type"::Invoice) OR (PurchaseLine."Document Type" = PurchaseLine."Document Type"::"Credit Memo") THEN BEGIN
            PurchasesPayablesSetup.GET();
            IF PurchasesPayablesSetup."H&S Levy Tax FND" THEN
                VATAmountLine.UpdateLevyTaxAmount(PurchaseLine."H&S Levy Tax Amount FND", PurchaseLine."H&S Levy Tax % FND");//BC UPGRADE SHARMP16 
        END;
        //HEI.67<<
    end;
    //Preview Code+
    //HEI.01-CU20>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Posting Preview Event Handler", 'OnAfterShowEntries', '', false, false)]
    local procedure OnAfterShowEntries(TableNo: Integer)
    var
    begin
        GetAllTables();
        CASE TableNo OF
            //HEI.01>>
            DATABASE::"Levy Tax Entries FND":
                PAGE.RUN(Page::"Levy Tax Entries Preview", TempLevyTaxEntries2);
        //HEI.01<<
        end
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Posting Preview Event Handler", 'OnAfterFillDocumentEntry', '', false, false)]
    local procedure OnAfterFillDocumentEntry(var DocumentEntry: Record "Document Entry" temporary)
    var
        PostingPreviewEventHandler: Codeunit "Posting Preview Event Handler";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        GetAllTables();
        //HEI.01>>
        PurchasesPayablesSetup.GET();
        IF PurchasesPayablesSetup."H&S Levy Tax FND" THEN
            //InsertDocumentEntry(TempLevyTaxEntries,TempDocumentEntry); //BC Upgrade KAPOOV01 Commented as need to change variable name-TempDocumentEntry to DocumentEntry as defined in the Event Subcriber function.
            PostingPreviewEventHandler.InsertDocumentEntry(TempLevyTaxEntries2, DocumentEntry);
        //BC Upgrade KAPOOV01<<
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Posting Preview Event Handler", 'OnGetEntries', '', true, false)]
    local procedure OnGetEntries(TableNo: Integer; var RecRef: RecordRef)
    begin
        GetAllTables();
        case TableNo of
            Database::"Levy Tax Entries FND":
                RecRef.GETTABLE(TempLevyTaxEntries2);
        end;
    end;

    local procedure GetAllTables()
    var
        CUHenikenGlobal: Codeunit "Levy Preview Custom RTR";
    begin
        Clear(TempLevyTaxEntries2);
        CUHenikenGlobal.GetTempLevyTaxEntries(TempLevyTaxEntries2);
    end;

    //Preview Code

    //Bc Upgrade YADAVM09 for Fixed asset Levy Gl Entries>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPostFixedAssetOnBeforeAssignGLEntry, '', false, false)]
    local procedure OnPostFixedAssetOnBeforeAssignGLEntry(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJnlLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var GLEntry2: Record "G/L Entry")
    var
        Text50000: label 'H&S Tax Posting Group must have value on HS Tax Posting Setup';

    begin
        //HEI.42>>
        PurchasesPayablesSetup.GET();
        IF PurchasesPayablesSetup."H&S Levy Tax FND" THEN begin
            IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::Invoice THEN BEGIN
                IF (GenJnlLine."H&S Levy Tax Amount FND" <> 0) THEN BEGIN
                    HSTaxPostingSetup.GET(GenJnlLine."HS Posting Group FND");//HEI.44
                    IF HSTaxPostingSetup."Purchase H&S Tax Account" = '' THEN
                        ERROR(Text50000, HSTaxPostingSetup."H&S Tax Posting Group");
                    Sender.CreateGLEntry(GenJnlLine, HSTaxPostingSetup."Purchase H&S Tax Account", ROUND(GLEntry."H&S Levy Tax Amount FND"), ROUND(GLEntry."H&S Levy Tax Amount FND"), TRUE);
                END;
            END ELSE IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Credit Memo" THEN BEGIN
                IF (GenJnlLine."H&S Levy Tax Amount FND" <> 0) THEN BEGIN
                    HSTaxPostingSetup.GET(GenJnlLine."HS Posting Group FND");
                    IF HSTaxPostingSetup."Purchase H&S Tax Account" = '' THEN //HEI.44
                        ERROR(Text50000, HSTaxPostingSetup."H&S Tax Posting Group");
                    Sender.CreateGLEntry(GenJnlLine, HSTaxPostingSetup."Purchase H&S Tax Account", ROUND(-GLEntry."H&S Levy Tax Amount FND"), ROUND(-GLEntry."H&S Levy Tax Amount FND"), TRUE);
                END;
            END;
            //HEI.42<<
        end;
    end;
    //BC Upgrade YADAVM09 for Fixed asset Levy Gl Entries<<
    //BC Upgrade YADAVM09 Finance Utils Code>>

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Location Code', false, false)]
    local procedure OnAfterValidateLocationCodePurch(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    var
        PurchaseLine: Record "Purchase Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        LAmount: Decimal;
    begin
        //HEI.31>>
        if Rec.IsTemporary then
            exit;
        //HEI.48>>
        PurchasesPayablesSetup.Get();

        if PurchasesPayablesSetup."H&S Levy Tax FND" then begin
            if Rec."Document Type" = Rec."Document Type"::Invoice then begin
                PurchaseLine.Reset();
                PurchaseLine.SetRange("Document No.", Rec."No.");
                PurchaseLine.SetFilter("H&S Levy Tax % FND", '<>%1', 0);
                PurchaseLine.SetRange("Receipt No.", '');
                if PurchaseLine.FindSet(true) then
                    repeat
                        LAmount := PurchaseLine."Total Amount Excl VAT/H&S FND" + PurchaseLine."H&S Levy Tax Amount FND";
                        if PurchaseLine."Line Amount" <> LAmount then
                            PurchaseLine."Line Amount" := PurchaseLine."Line Amount" + PurchaseLine."H&S Levy Tax Amount FND";
                        PurchaseLine.Modify();
                    until PurchaseLine.Next() = 0;
            end;
        end;
    end;

    // Finance Utils Code
    //Heninken BC Custom Function
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Totals", 'OnCalculatePurchasePageTotalsOnAfterCalculateVATAmount', '', true, true)]
    local procedure OnCalculatePurchasePageTotalsOnAfterCalculateVATAmount(var TotalPurchaseLine: Record "Purchase Line"; var VATAmount: Decimal; var PurchaseLine: Record "Purchase Line"; var TotalPurchaseLine2: Record "Purchase Line")
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        VPS: Record "VAT Posting Setup";
        rcVat: Decimal;
    begin
        //HEI.02>>
        PurchasesPayablesSetup.GET();
        IF PurchasesPayablesSetup."H&S Levy Tax FND" THEN
            TotalPurchaseLine.CALCSUMS("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", "H&S Levy Tax Amount FND");//HEI.03
    end;

    [EventSubscriber(ObjectType::Page, Page::Navigate, OnBeforeFindCustLedgerEntry, '', false, false)]
    local procedure Navigate_OnBeforeFindCustLedgerEntry(var Sender: Page Navigate; var CustLedgerEntry: Record "Cust. Ledger Entry"; DocNoFilter: Text; PostingDateFilter: Text; ExtDocNo: Text; var IsHandled: Boolean)
    var
        CADEntry: Record "CAD Entry FND";
        Rec_Navigate: Record "Document Entry";
        LevyTaxEntries: Record "Levy Tax Entries FND";
        WHTEntry: Record "WHT Entry FND";

    begin

        //HEI.04>>
        IF LevyTaxEntries.READPERMISSION THEN BEGIN
            LevyTaxEntries.RESET();
            LevyTaxEntries.SETCURRENTKEY("Doc. No.", "Posting Date");
            LevyTaxEntries.SETFILTER("Doc. No.", DocNoFilter);
            LevyTaxEntries.SETFILTER("Posting Date", PostingDateFilter);
            Rec_Navigate.InsertIntoDocEntry(
            // BC Upgrade PATELP08 >> Replaced integer document type with Document Entry Document Type enum to avoid implicit integer-to-enum conversion.
            //   DATABASE::"Levy Tax Entries FND", 0, LevyTaxEntries.TABLECAPTION, LevyTaxEntries.COUNT);
              DATABASE::"Levy Tax Entries FND", Enum::"Document Entry Document Type"::Quote, LevyTaxEntries.TABLECAPTION, LevyTaxEntries.COUNT);
            // BC Upgrade PATELP08 <<
        end;
        //HEI.04<<

    end;

    //Heninken BC Custom Function

    //Heninken BC Table CU
    [EventSubscriber(ObjectType::Codeunit, 826, OnAfterPrepareInvoicePostingBuffer, '', false, false)]
    local procedure OnAfterPrepareInvoicePostingBuffer(var PurchaseLine: Record "Purchase Line"; var InvoicePostingBuffer: Record "Invoice Posting Buffer")
    begin

        //HEI.06
        InvoicePostingBuffer."H&S Levy Tax Amount FND" := PurchaseLine."H&S Levy Tax Amount FND";
        InvoicePostingBuffer."H&S Levy Tax % FND" := PurchaseLine."H&S Levy Tax % FND";
        InvoicePostingBuffer."HS Posting Group FND" := PurchaseLine."HS Posting Group FND";
        //HEI.06
    end;

    //heinken Table CU
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterInitNextEntryNo, '', false, false)]
    local procedure OnAfterInitNextEntryNo(var GLEntry: Record "G/L Entry"; var NextEntryNo: Integer; var NextTransactionNo: Integer)
    var
        CdLevyCustomPreview: Codeunit "Levy Preview Custom RTR";
    begin
        CdLevyCustomPreview.SetNextTransactionNo(NextTransactionNo);
    end;

    var
        TempLevyTaxEntries2: Record "Levy Tax Entries FND" temporary;
        LevyTaxEntries: Record "Levy Tax Entries FND";


}