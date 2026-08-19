namespace CommonBusiness.CommonBusiness;
using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Purchases.Payables;
using Microsoft.Purchases.History;
using Microsoft.Sales.Customer;
using Microsoft.Finance.VAT.Ledger;
using Microsoft.Finance.ReceivablesPayables;
using Microsoft.Purchases.Vendor;
using System.Utilities;
using Microsoft.Bank.Check;
using Microsoft.Bank.Ledger;
using Microsoft.Bank.BankAccount;
using Microsoft.Sales.Receivables;
using Microsoft.Purchases.Document;
using ALProject.ALProject;
using Microsoft.Foundation.AuditCodes;
using Microsoft.Finance.Currency;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.GeneralLedger.Ledger;

codeunit 51039 "WHT Gen. Jnl.-Post Line FND"
{

    Permissions = tabledata "Vendor Ledger Entry" = RIMD,
    tabledata "G/L Entry" = RIMD;
    // BC Upgrade BHARDA11 
    /* Currently, the WHT-related code in the CustUnrealizedVAT function is missing in Navision. */
    /* To implement `OldCustLedgEntry."Rem. Amt for WHT" := -OldAppliedAmount;` inside `ApplyCustLedgEntry`, I could not find any link or equivalent for `OldAppliedAmount` in Business Central.*/
    //BC UPGRADE KUMARR78 WHT Related
    // BC Upgrade RD03 - the below event is not triggered when processing with and without WHT, but it is causing GL Inconsistency error when running Adjust Exchange Rate report. so the below event is commented.
    // WHT is for Purchase / Vendor - so the customer related WHT calculation is commented

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforeInitGLEntryForGLAcc, '', false, false)]
    // local procedure OnBeforeInitGLEntryForGLAcc(GenJnlLine: Record "Gen. Journal Line"; GLAcc: Record "G/L Account"; var GLEntry: Record "G/L Entry"; var TaxAmount: Decimal; var TaxAmountLCY: Decimal; var IsHandled: Boolean)
    // var
    //     GLSetup: record "General Ledger Setup";
    // begin
    //     SourceCodeSetup.GET;
    //     CalcGLAccWHT(GenJnlLine, WHTPostingSetup, WHTAmountLCY, WHTAmount); // BC Upgrade BHARDA11 -- 24June2026
    //HEI.19>>
    // GLSetup.Get();
    // IF GenJnlLine."Source Code" = SourceCodeSetup."Payment Journal Tree FND" THEN BEGIN
    //     IF GLSetup."Enable WHT FND" = TRUE THEN BEGIN
    //         IF lWHTPostingSetup.GET(GenJnlLine."WHT Business Posting Group FND", GenJnlLine."WHT Product Posting Group FND") AND
    //           (GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::" ") THEN BEGIN
    //             IF lWHTPostingSetup."WHT Bearer" = lWHTPostingSetup."WHT Bearer"::Vendor THEN
    //                 //HEI.28>>
    //                 IF (GLSetup."Round Amount for WHT Calc FND") AND (lWHTPostingSetup."WHT %" <> 0) THEN
    //                     GenJnlPost.InitGLEntry(GenJnlLine, GLEntry, GenJnlLine."Account No.", ROUND((GenJnlLine."Amount (LCY)" + WHTAmountLCY), 1, '<'),
    //                       ROUND((GenJnlLine."Source Currency Amount" + WHTAmountLCY), 1, '<'), TRUE, GenJnlLine."System-Created Entry", 0)
    //                 ELSE
    //                     //HEI.28<<
    //                     GenJnlPost.InitGLEntry(GenJnlLine, GLEntry, GenJnlLine."Account No.", GenJnlLine."Amount (LCY)" + WHTAmountLCY,
    //             GenJnlLine."Source Currency Amount" + WHTAmountLCY, TRUE, GenJnlLine."System-Created Entry", 0);
    //             IF lWHTPostingSetup."WHT Bearer" = lWHTPostingSetup."WHT Bearer"::Opco THEN
    //                 //HEI.28>>
    //                 IF (GLSetup."Round Amount for WHT Calc FND") AND (lWHTPostingSetup."WHT %" <> 0) THEN
    //                     GenJnlPost.InitGLEntry(GenJnlLine, GLEntry, GenJnlLine."Account No.", ROUND(GenJnlLine."Amount (LCY)", 1, '<'),
    //                       ROUND((GenJnlLine."Source Currency Amount" + WHTAmountLCY), 1, '<'), TRUE, GenJnlLine."System-Created Entry", 0)
    //                 ELSE
    //                     //HEI.28<<
    //                     GenJnlPost.InitGLEntry(GenJnlLine, GLEntry, GenJnlLine."Account No.", GenJnlLine."Amount (LCY)",
    //             GenJnlLine."Source Currency Amount" + WHTAmountLCY, TRUE, GenJnlLine."System-Created Entry", 0);
    //         END
    //         ELSE //HEI.28<<
    //             IF (GLSetup."Round Amount for WHT Calc FND") AND (lWHTPostingSetup."WHT %" <> 0) THEN
    //                 GenJnlPost.InitGLEntry(GenJnlLine, GLEntry, GenJnlLine."Account No.", ROUND((GenJnlLine."Amount (LCY)" + WHTAmountLCY), 1, '<'),
    //                 ROUND((GenJnlLine."Source Currency Amount" + WHTAmountLCY), 1, '<'), TRUE, GenJnlLine."System-Created Entry", 0)
    //             ELSE //HEI.28>>
    //                 GenJnlPost.InitGLEntry(GenJnlLine, GLEntry,
    //                   GenJnlLine."Account No.", GenJnlLine."Amount (LCY)" + WHTAmountLCY,
    //                   GenJnlLine."Source Currency Amount" + WHTAmountLCY, TRUE, GenJnlLine."System-Created Entry", 0);
    //     END
    //     ELSE
    //         GenJnlPost.InitGLEntry(GenJnlLine, GLEntry,
    //           GenJnlLine."Account No.", GenJnlLine."Amount (LCY)" + WHTAmountLCY,
    //           GenJnlLine."Source Currency Amount" + WHTAmountLCY, TRUE, GenJnlLine."System-Created Entry", 0);
    //     IsHandled := true;
    // END
    // ELSE begin
    //     GenJnlPost.InitGLEntry(GenJnlLine, GLEntry,
    //            GenJnlLine."Account No.", GenJnlLine."Amount (LCY)" + WHTAmountLCY,
    //            GenJnlLine."Source Currency Amount" + WHTAmountLCY, TRUE, GenJnlLine."System-Created Entry", 0);
    //     IsHandled := true;
    // end;
    //HEI.19<<
    //end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPostGLAccOnAfterInitGLEntry, '', false, false)]
    local procedure OnPostGLAccOnAfterInitGLEntry(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry");
    var
        GLSetup: record "General Ledger Setup";
        GenJournalPostLine: Codeunit "Gen. Jnl.-Post Line";
    begin
        SourceCodeSetup.GET;
        CalcGLAccWHT(GenJournalLine, WHTPostingSetup, WHTAmountLCY, WHTAmount); // BC Upgrade BHARDA11 -- 24June2026
        //HEI.19>>
        GLSetup.Get();
        IF GenJournalLine."Source Code" = SourceCodeSetup."Payment Journal Tree FND" THEN BEGIN
            IF GLSetup."Enable WHT FND" = TRUE THEN BEGIN
                IF lWHTPostingSetup.GET(GenJournalLine."WHT Business Posting Group FND", GenJournalLine."WHT Product Posting Group FND") AND
                  (GenJournalLine."Applies-to Doc. Type" = GenJournalLine."Applies-to Doc. Type"::" ") THEN BEGIN
                    IF lWHTPostingSetup."WHT Bearer" = lWHTPostingSetup."WHT Bearer"::Vendor THEN
                        IF (GLSetup."Round Amount for WHT Calc FND") AND (lWHTPostingSetup."WHT %" <> 0) THEN begin
                            GLEntry.Amount := ROUND((GenJournalLine."Amount (LCY)" + WHTAmountLCY), 1, '<');
                            GLEntry."Additional-Currency Amount" := GenJournalPostLine.GLCalcAddCurrency(GLEntry.Amount,
                            ROUND((GenJournalLine."Source Currency Amount" + WHTAmountLCY), 1, '<'), GLEntry."Additional-Currency Amount", true, GenJournalLine);
                            //ROUND((GenJournalLine."Source Currency Amount" + WHTAmountLCY), 1, '<');
                            // GenJnlPost.InitGLEntry(GenJournalLine, GLEntry, GenJournalLine."Account No.", ROUND((GenJournalLine."Amount (LCY)" + WHTAmountLCY), 1, '<'),
                            //                       ROUND((GenJournalLine."Source Currency Amount" + WHTAmountLCY), 1, '<'), TRUE, GenJournalLine."System-Created Entry", 0)
                        end ELSE begin
                            GLEntry.Amount := GenJournalLine."Amount (LCY)" + WHTAmountLCY;
                            GLEntry."Additional-Currency Amount" := GenJournalPostLine.GLCalcAddCurrency(GLEntry.Amount,
                            GenJournalLine."Source Currency Amount" + WHTAmountLCY, GLEntry."Additional-Currency Amount", true, GenJournalLine);
                            //GenJournalLine."Source Currency Amount" + WHTAmountLCY;
                            // GenJnlPost.InitGLEntry(GenJournalLine, GLEntry, GenJournalLine."Account No.", GenJournalLine."Amount (LCY)" + WHTAmountLCY,
                            //            GenJournalLine."Source Currency Amount" + WHTAmountLCY, TRUE, GenJournalLine."System-Created Entry", 0);
                        end;
                    IF lWHTPostingSetup."WHT Bearer" = lWHTPostingSetup."WHT Bearer"::Opco THEN
                        IF (GLSetup."Round Amount for WHT Calc FND") AND (lWHTPostingSetup."WHT %" <> 0) THEN begin
                            GLEntry.Amount := ROUND(GenJournalLine."Amount (LCY)", 1, '<');
                            GLEntry."Additional-Currency Amount" := GenJournalPostLine.GLCalcAddCurrency(GLEntry.Amount,
                            ROUND((GenJournalLine."Source Currency Amount" + WHTAmountLCY), 1, '<'), GLEntry."Additional-Currency Amount", true, GenJournalLine);
                            //ROUND((GenJournalLine."Source Currency Amount" + WHTAmountLCY), 1, '<');
                            // GenJnlPost.InitGLEntry(GenJournalLine, GLEntry, GenJournalLine."Account No.", ROUND(GenJournalLine."Amount (LCY)", 1, '<'),
                            //   ROUND((GenJournalLine."Source Currency Amount" + WHTAmountLCY), 1, '<'), TRUE, GenJournalLine."System-Created Entry", 0)
                        end ELSE begin
                            GLEntry.Amount := GenJournalLine."Amount (LCY)";
                            GLEntry."Additional-Currency Amount" := GenJournalPostLine.GLCalcAddCurrency(GLEntry.Amount,
                            GenJournalLine."Source Currency Amount" + WHTAmountLCY, GLEntry."Additional-Currency Amount", true, GenJournalLine);
                            //GenJournalLine."Source Currency Amount" + WHTAmountLCY;
                            // GenJnlPost.InitGLEntry(GenJournalLine, GLEntry, GenJournalLine."Account No.", GenJournalLine."Amount (LCY)",
                            //                     GenJournalLine."Source Currency Amount" + WHTAmountLCY, TRUE, GenJournalLine."System-Created Entry", 0);
                        end;
                END ELSE
                    IF (GLSetup."Round Amount for WHT Calc FND") AND (lWHTPostingSetup."WHT %" <> 0) THEN begin
                        GLEntry.Amount := ROUND((GenJournalLine."Amount (LCY)" + WHTAmountLCY), 1, '<');
                        GLEntry."Additional-Currency Amount" := GenJournalPostLine.GLCalcAddCurrency(GLEntry.Amount,
                            ROUND((GenJournalLine."Source Currency Amount" + WHTAmountLCY), 1, '<'), GLEntry."Additional-Currency Amount", true, GenJournalLine);
                        //ROUND((GenJournalLine."Source Currency Amount" + WHTAmountLCY), 1, '<');
                        // GenJnlPost.InitGLEntry(GenJournalLine, GLEntry, GenJournalLine."Account No.", ROUND((GenJournalLine."Amount (LCY)" + WHTAmountLCY), 1, '<'),
                        //                         ROUND((GenJournalLine."Source Currency Amount" + WHTAmountLCY), 1, '<'), TRUE, GenJournalLine."System-Created Entry", 0)
                    end ELSE begin
                        GLEntry.Amount := GenJournalLine."Amount (LCY)" + WHTAmountLCY;
                        GLEntry."Additional-Currency Amount" := GenJournalPostLine.GLCalcAddCurrency(GLEntry.Amount,
                            GenJournalLine."Source Currency Amount" + WHTAmountLCY, GLEntry."Additional-Currency Amount", true, GenJournalLine);
                        //GenJournalLine."Source Currency Amount" + WHTAmountLCY;
                        // GenJnlPost.InitGLEntry(GenJournalLine, GLEntry, GenJournalLine."Account No.", GenJournalLine."Amount (LCY)" + WHTAmountLCY,
                        //                           GenJournalLine."Source Currency Amount" + WHTAmountLCY, TRUE, GenJournalLine."System-Created Entry", 0);
                    end;
            END ELSE begin
                GLEntry.Amount := GenJournalLine."Amount (LCY)" + WHTAmountLCY;
                GLEntry."Additional-Currency Amount" := GenJournalPostLine.GLCalcAddCurrency(GLEntry.Amount,
                            GenJournalLine."Source Currency Amount" + WHTAmountLCY, GLEntry."Additional-Currency Amount", true, GenJournalLine);
                //GenJournalLine."Source Currency Amount" + WHTAmountLCY;
                // GenJnlPost.InitGLEntry(GenJournalLine, GLEntry, GenJournalLine."Account No.", GenJournalLine."Amount (LCY)" + WHTAmountLCY,
                //               GenJournalLine."Source Currency Amount" + WHTAmountLCY, TRUE, GenJournalLine."System-Created Entry", 0);
                //IsHandled := true;
            end;
        END ELSE begin
            GLEntry.Amount := GenJournalLine."Amount (LCY)" + WHTAmountLCY;
            GLEntry."Additional-Currency Amount" := GenJournalPostLine.GLCalcAddCurrency(GLEntry.Amount,
                            GenJournalLine."Source Currency Amount" + WHTAmountLCY, GLEntry."Additional-Currency Amount", true, GenJournalLine);
            //GenJournalLine."Source Currency Amount" + WHTAmountLCY;
            // GenJnlPost.InitGLEntry(GenJournalLine, GLEntry, GenJournalLine."Account No.", GenJournalLine."Amount (LCY)" + WHTAmountLCY,
            //        GenJournalLine."Source Currency Amount" + WHTAmountLCY, TRUE, GenJournalLine."System-Created Entry", 0);
            //IsHandled := true;
        end;
    end;

    // RD03
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforeInitGLEntry, '', false, false)]
    // local procedure OnBeforeInitGLEntry(var GenJournalLine: Record "Gen. Journal Line"; var GLAccNo: Code[20]; SystemCreatedEntry: Boolean; Amount: Decimal; AmountAddCurr: Decimal; FADimAlreadyChecked: Boolean; var IsHandled: Boolean; var GLEntry: Record "G/L Entry"; UseAmountAddCurr: Boolean; NextEntryNo: Integer; NextTransactionNo: Integer)
    // var
    //     GLSetup: record "General Ledger Setup";
    // begin
    //     SourceCodeSetup.GET;
    //     CalcGLAccWHT(GenJournalLine, WHTPostingSetup, WHTAmountLCY, WHTAmount); // BC Upgrade BHARDA11 -- 24June2026
    //     //HEI.19>>
    //     GLSetup.Get();
    //     IF GenJournalLine."Source Code" = SourceCodeSetup."Payment Journal Tree FND" THEN BEGIN
    //         IF GLSetup."Enable WHT FND" = TRUE THEN BEGIN
    //             IF lWHTPostingSetup.GET(GenJournalLine."WHT Business Posting Group FND", GenJournalLine."WHT Product Posting Group FND") AND
    //               (GenJournalLine."Applies-to Doc. Type" = GenJournalLine."Applies-to Doc. Type"::" ") THEN BEGIN
    //                 IF lWHTPostingSetup."WHT Bearer" = lWHTPostingSetup."WHT Bearer"::Vendor THEN
    //                     IF (GLSetup."Round Amount for WHT Calc FND") AND (lWHTPostingSetup."WHT %" <> 0) THEN begin
    //                         Amount := ROUND((GenJournalLine."Amount (LCY)" + WHTAmountLCY), 1, '<');
    //                         AmountAddCurr := ROUND((GenJournalLine."Source Currency Amount" + WHTAmountLCY), 1, '<');
    //                         // GenJnlPost.InitGLEntry(GenJournalLine, GLEntry, GenJournalLine."Account No.", ROUND((GenJournalLine."Amount (LCY)" + WHTAmountLCY), 1, '<'),
    //                         //                       ROUND((GenJournalLine."Source Currency Amount" + WHTAmountLCY), 1, '<'), TRUE, GenJournalLine."System-Created Entry", 0)
    //                     end ELSE begin
    //                         Amount := GenJournalLine."Amount (LCY)" + WHTAmountLCY;
    //                         AmountAddCurr := GenJournalLine."Source Currency Amount" + WHTAmountLCY;
    //                         // GenJnlPost.InitGLEntry(GenJournalLine, GLEntry, GenJournalLine."Account No.", GenJournalLine."Amount (LCY)" + WHTAmountLCY,
    //                         //            GenJournalLine."Source Currency Amount" + WHTAmountLCY, TRUE, GenJournalLine."System-Created Entry", 0);
    //                     end;
    //                 IF lWHTPostingSetup."WHT Bearer" = lWHTPostingSetup."WHT Bearer"::Opco THEN
    //                     IF (GLSetup."Round Amount for WHT Calc FND") AND (lWHTPostingSetup."WHT %" <> 0) THEN begin
    //                         Amount := ROUND(GenJournalLine."Amount (LCY)", 1, '<');
    //                         AmountAddCurr := ROUND((GenJournalLine."Source Currency Amount" + WHTAmountLCY), 1, '<');
    //                         // GenJnlPost.InitGLEntry(GenJournalLine, GLEntry, GenJournalLine."Account No.", ROUND(GenJournalLine."Amount (LCY)", 1, '<'),
    //                         //   ROUND((GenJournalLine."Source Currency Amount" + WHTAmountLCY), 1, '<'), TRUE, GenJournalLine."System-Created Entry", 0)
    //                     end ELSE begin
    //                         Amount := GenJournalLine."Amount (LCY)";
    //                         AmountAddCurr := GenJournalLine."Source Currency Amount" + WHTAmountLCY;
    //                         // GenJnlPost.InitGLEntry(GenJournalLine, GLEntry, GenJournalLine."Account No.", GenJournalLine."Amount (LCY)",
    //                         //                     GenJournalLine."Source Currency Amount" + WHTAmountLCY, TRUE, GenJournalLine."System-Created Entry", 0);
    //                     end;
    //             END ELSE
    //                 IF (GLSetup."Round Amount for WHT Calc FND") AND (lWHTPostingSetup."WHT %" <> 0) THEN begin
    //                     Amount := ROUND((GenJournalLine."Amount (LCY)" + WHTAmountLCY), 1, '<');
    //                     AmountAddCurr := ROUND((GenJournalLine."Source Currency Amount" + WHTAmountLCY), 1, '<');
    //                     // GenJnlPost.InitGLEntry(GenJournalLine, GLEntry, GenJournalLine."Account No.", ROUND((GenJournalLine."Amount (LCY)" + WHTAmountLCY), 1, '<'),
    //                     //                         ROUND((GenJournalLine."Source Currency Amount" + WHTAmountLCY), 1, '<'), TRUE, GenJournalLine."System-Created Entry", 0)
    //                 end ELSE begin
    //                     Amount := GenJournalLine."Amount (LCY)" + WHTAmountLCY;
    //                     AmountAddCurr := GenJournalLine."Source Currency Amount" + WHTAmountLCY;
    //                     // GenJnlPost.InitGLEntry(GenJournalLine, GLEntry, GenJournalLine."Account No.", GenJournalLine."Amount (LCY)" + WHTAmountLCY,
    //                     //                           GenJournalLine."Source Currency Amount" + WHTAmountLCY, TRUE, GenJournalLine."System-Created Entry", 0);
    //                 end;
    //         END ELSE begin
    //             Amount := GenJournalLine."Amount (LCY)" + WHTAmountLCY;
    //             AmountAddCurr := GenJournalLine."Source Currency Amount" + WHTAmountLCY;
    //             // GenJnlPost.InitGLEntry(GenJournalLine, GLEntry, GenJournalLine."Account No.", GenJournalLine."Amount (LCY)" + WHTAmountLCY,
    //             //               GenJournalLine."Source Currency Amount" + WHTAmountLCY, TRUE, GenJournalLine."System-Created Entry", 0);
    //             //IsHandled := true;
    //         end;
    //     END ELSE begin
    //         Amount := GenJournalLine."Amount (LCY)" + WHTAmountLCY;
    //         AmountAddCurr := GenJournalLine."Source Currency Amount" + WHTAmountLCY;
    //         // GenJnlPost.InitGLEntry(GenJournalLine, GLEntry, GenJournalLine."Account No.", GenJournalLine."Amount (LCY)" + WHTAmountLCY,
    //         //        GenJournalLine."Source Currency Amount" + WHTAmountLCY, TRUE, GenJournalLine."System-Created Entry", 0);
    //         //IsHandled := true;
    //     end;
    // end;
    // RD03

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPostGLAccOnBeforePostJob, '', false, false)]
    local procedure OnPostGLAccOnBeforePostJob(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var IsHandled: Boolean; Balancing: Boolean)
    var
        GenJnlPost: Codeunit "Gen. Jnl.-Post Line";
        lWHTPostingSetup: Record "WHT Posting Setup FND";
        lVendLedgEntry: Record "Vendor Ledger Entry";
        lWHTEntry: Record "WHT Entry FND";
        lPurchInvLine: Record "Purch. Inv. Line";
        TempPurchInvLine: Record "Purch. Inv. Line" temporary;
        GLSetup: record "General Ledger Setup";
    begin
        SourceCodeSetup.GET;
        GLSetup.Get();
        IF ((GenJournalLine."Source Code" = SourceCodeSetup."Payment Journal Tree FND") AND (GLSetup."Enable WHT FND" = TRUE)) THEN
            //IF GenJnlLine1."Applies-to Doc. Type" = GenJnlLine1."Applies-to Doc. Type"::Invoice THEN //HEI.28 commented
            //IF lWHTPostingSetup.GET(GenJnlLine1."WHT Business Posting Group",GenJnlLine1."WHT Product Posting Group") THEN //HEI.28 commented
            IF lWHTPostingSetup.GET(GenJournalLine."WHT Business Posting Group FND", GenJournalLine."WHT Product Posting Group FND") THEN
                IF (lWHTPostingSetup."WHT Bearer" = lWHTPostingSetup."WHT Bearer"::Opco) THEN BEGIN
                    //HEI.28>>
                    lVendLedgEntry.RESET;
                    IF GenJournalLine."Applies-to ID" <> '' THEN
                        lVendLedgEntry.SETRANGE("Applies-to ID", GenJournalLine."Applies-to ID")
                    ELSE
                        lVendLedgEntry.SETRANGE("Applies-to ID", GenJournalLine."Document No.");
                    lVendLedgEntry.SETRANGE("Document Type", lVendLedgEntry."Document Type"::Invoice);
                    lVendLedgEntry.SETRANGE(Open, TRUE);
                    IF GenJournalLine."Bill-to/Pay-to No." = '' THEN
                        lVendLedgEntry.SETRANGE("Buy-from Vendor No.", GenJournalLine."Account No.")
                    ELSE
                        lVendLedgEntry.SETRANGE("Buy-from Vendor No.", GenJournalLine."Bill-to/Pay-to No.");

                    IF lVendLedgEntry.FINDSET THEN
                        REPEAT
                            lWHTEntry.RESET;
                            lWHTEntry.SETRANGE("Document Type", lWHTEntry."Document Type"::Invoice);
                            lWHTEntry.SETRANGE("Document No.", lVendLedgEntry."Document No.");
                            lWHTEntry.SETFILTER("Unrealized Amount", '<>%1', 0);
                            IF lWHTEntry.FINDSET THEN
                                REPEAT
                                    lPurchInvLine.RESET;
                                    lPurchInvLine.SETRANGE("Document No.", lWHTEntry."Document No.");
                                    lPurchInvLine.SETRANGE(Type, lPurchInvLine.Type::"G/L Account");
                                    lPurchInvLine.SETRANGE("WHT Business Posting Group FND", lWHTEntry."WHT Bus. Posting Group"); //HEI.28
                                    lPurchInvLine.SETRANGE("WHT Product Posting Group FND", lWHTEntry."WHT Prod. Posting Group"); //HEi.28
                                    IF lPurchInvLine.FINDFIRST THEN
                                        REPEAT
                                            PurchInvHeader.RESET;
                                            PurchInvHeader.GET(lPurchInvLine."Document No.");

                                            TempPurchInvLine.RESET;
                                            TempPurchInvLine.SETRANGE("Document No.", lPurchInvLine."Document No.");
                                            TempPurchInvLine.SETRANGE(Type, lPurchInvLine.Type::"G/L Account");
                                            TempPurchInvLine.SETRANGE("No.", lPurchInvLine."No.");
                                            TempPurchInvLine.SETRANGE("WHT Business Posting Group FND", lWHTEntry."WHT Bus. Posting Group");
                                            TempPurchInvLine.SETRANGE("WHT Product Posting Group FND", lWHTEntry."WHT Prod. Posting Group");
                                            IF NOT TempPurchInvLine.FINDFIRST THEN BEGIN
                                                TempPurchInvLine.TRANSFERFIELDS(lPurchInvLine);
                                                CLEAR(TempPurchInvLine."WHT Absorb Base FND");
                                                IF PurchInvHeader."Currency Code" <> '' THEN
                                                    TempPurchInvLine."WHT Absorb Base FND" :=
                                                      ABS(CurrExchRate.ExchangeAmtFCYToLCY(
                                                        PurchInvHeader."Posting Date", PurchInvHeader."Currency Code", lPurchInvLine."Line Amount",
                                                        CurrExchRate.ExchangeRate(PurchInvHeader."Posting Date", PurchInvHeader."Currency Code"))) * (lWHTEntry."WHT %" / 100)
                                                ELSE
                                                    TempPurchInvLine."WHT Absorb Base FND" := lPurchInvLine."Line Amount" * (lWHTEntry."WHT %" / 100);
                                                TempPurchInvLine.INSERT;
                                            END ELSE BEGIN
                                                IF PurchInvHeader."Currency Code" <> '' THEN
                                                    TempPurchInvLine."WHT Absorb Base FND" +=
                                                      ABS(CurrExchRate.ExchangeAmtFCYToLCY(
                                                        PurchInvHeader."Posting Date", PurchInvHeader."Currency Code", lPurchInvLine."Line Amount",
                                                        CurrExchRate.ExchangeRate(PurchInvHeader."Posting Date", PurchInvHeader."Currency Code"))) * (lWHTEntry."WHT %" / 100)
                                                ELSE
                                                    TempPurchInvLine."WHT Absorb Base FND" += lPurchInvLine."Line Amount" * (lWHTEntry."WHT %" / 100);
                                                TempPurchInvLine.MODIFY;
                                            END;

                                        /*  GenJnlLine."Dimension Set ID" := lPurchInvLine."Dimension Set ID"; //HEI.28 commented
                                           CreateGLEntry(
                                               GenJnlLine,lPurchInvLine."No.",-("Amount (LCY)" + WHTAmountLCY),-("Amount (LCY)" + WHTAmountLCY),TRUE); */  //HEI.28 commented
                                        UNTIL lPurchInvLine.NEXT = 0;
                                UNTIL lWHTEntry.NEXT = 0;
                        UNTIL lVendLedgEntry.NEXT = 0;

                    TempPurchInvLine.RESET;
                    IF TempPurchInvLine.FINDSET THEN
                        REPEAT
                            GenJournalLine."Dimension Set ID" := TempPurchInvLine."Dimension Set ID";
                            IF GLSetup."Round Amount for WHT Calc FND" THEN
                                GenJnlPost.CreateGLEntry(
                                  GenJournalLine, TempPurchInvLine."No.", ROUND(TempPurchInvLine."WHT Absorb Base FND", 1, '<'), ROUND(TempPurchInvLine."WHT Absorb Base FND", 1, '<'), TRUE)
                            ELSE
                                GenJnlPost.CreateGLEntry(
                                  GenJournalLine, TempPurchInvLine."No.", ROUND(TempPurchInvLine."WHT Absorb Base FND", GLSetup."Amount Rounding Precision"), ROUND(TempPurchInvLine."WHT Absorb Base FND", GLSetup."Amount Rounding Precision"), TRUE);
                        UNTIL TempPurchInvLine.NEXT = 0;
                    //HEI.28<<

                    IF NOT lPurchInvLine.FINDFIRST THEN
                        ERROR(Text50001);
                END;
        //HEI.19<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPostGLAccOnBeforeDeferralPosting, '', false, false)]
    local procedure OnPostGLAccOnBeforeDeferralPosting(var GenJournalLine: Record "Gen. Journal Line"; TaxAmount: Decimal; TaxAmountLCY: Decimal);
    var
        PurchLine: Record "Purchase Line";
    begin
        if WHTPostingSetup.GET(GenJournalLine."WHT Business Posting Group FND", GenJournalLine."WHT Product Posting Group FND") then
            PostGLAccWHT(GenJournalLine, WHTPostingSetup, WHTAmountLCY)
        else
            PostGLAccWHT(GenJournalLine, WHTPostingSetup, WHTAmountLCY)
    end;

    procedure PostGLAccWHT(GenJnlLine: Record "Gen. Journal Line"; WHTPostingSetup: Record "WHT Posting Setup fnd"; WHTAmountLCY: Decimal) //78..83
    var
        GenJnlPost: Codeunit "Gen. Jnl.-Post Line";
    begin
        IF WHTAmountLCY = 0 THEN
            EXIT;

        WITH GenJnlLine DO BEGIN
            IF "Document Type" = "Document Type"::Invoice THEN
                EXIT;

            CASE TRUE OF
                GenJnlPostLineCBN.IsVendAcc(GenJnlLine):
                    IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN
                        GenJnlPost.CreateGLEntry(
                          GenJnlLine, WHTPostingSetup."Payable WHT Account Code", -WHTAmountLCY, -WHTAmountLCY, TRUE);
                GenJnlPostLineCBN.IsCustAcc(GenJnlLine):
                    IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN
                        GenJnlPost.CreateGLEntry(
                          GenJnlLine, WHTPostingSetup."Prepaid WHT Account Code", -WHTAmountLCY, -WHTAmountLCY, TRUE);
            END;
        END;
    end;
    // BC Upgrade BHARAD11 << --24June2026
    // BC Upgrade BHARDA11 >> --24June2026
    procedure CalcGLAccWHT(GenJnlLine: Record "Gen. Journal Line"; var WHTPostingSetup: Record "WHT Posting Setup FND"; var WHTAmountLCY: Decimal; VAr WHTAmount: Decimal) //57..77
    var
        WHTManagement: Codeunit "WHTManagement";
        GLSetup: record "General Ledger Setup";
    begin
        GLSetup.Get();
        WITH GenJnlLine DO BEGIN
            WHTAmountLCY := 0;
            IF GLSetup."Enable WHT FND" THEN
                IF NOT "Skip WHT FND" THEN
                    IF ("Applies-to ID" = '') AND ("Applies-to Doc. No." = '') THEN BEGIN
                        IF ("Document Type" = "Document Type"::Payment) OR
                           ("Document Type" = "Document Type"::Refund)
                        THEN
                            IF WHTPostingSetup.GET(
                                 "WHT Business Posting Group FND",
                                 "WHT Product Posting Group FND")
                            THEN
                                IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN
                                    IF GenJnlPostLineCBN.IsCustAcc(GenJnlLine) THEN BEGIN
                                        IF "WHT Absorb Base FND" <> 0 THEN
                                            WHTAmountLCY :=
                                              -ABS(ROUND("WHT Absorb Base FND" * WHTPostingSetup."WHT %" / 100))
                                        ELSE
                                            WHTAmountLCY :=
                                              -ABS(ROUND(Amount * WHTPostingSetup."WHT %" / 100));
                                        IF "Document Type" = "Document Type"::Refund THEN
                                            WHTAmountLCY := ABS(WHTAmountLCY);
                                    END ELSE
                                        IF GenJnlPostLineCBN.IsVendAcc(GenJnlLine) THEN BEGIN
                                            IF "WHT Absorb Base FND" <> 0 THEN
                                                WHTAmountLCY :=
                                                  ABS(ROUND("WHT Absorb Base FND" * WHTPostingSetup."WHT %" / 100))
                                            ELSE
                                                WHTAmountLCY :=
                                                  ABS(ROUND(Amount * WHTPostingSetup."WHT %" / 100));

                                            IF "Document Type" = "Document Type"::Refund THEN
                                                WHTAmountLCY := -ABS(WHTAmountLCY);
                                        END;
                    END ELSE
                        IF ("Applies-to ID" <> '') OR ("Applies-to Doc. No." <> '') THEN BEGIN
                            GenJnlLine1.RESET;
                            GenJnlLine1.COPY(GenJnlLine);
                            IF "Applies-to Doc. No." <> '' THEN
                                GenJnlLine1.SETRANGE("Applies-to Doc. No.", "Applies-to Doc. No.")
                            ELSE
                                GenJnlLine1.SETRANGE("Applies-to ID", "Applies-to ID");

                            GenJnlLine1.SETRANGE("Account Type", "Account Type"::Vendor);
                            IF ("Account Type" = "Account Type"::Vendor) OR
                               ("Bal. Account Type" = "Bal. Account Type"::Vendor) OR
                               GenJnlLine1.FINDFIRST
                            THEN BEGIN
                                CurrFactor :=
                                  CurrExchRate.ExchangeRate(
                                    "Document Date", "Currency Code");

                                GenJnlLine1.VALIDATE(Amount, GenJnlLine1.Amount);//WHTWORK

                                IF ("Document Type" = "Document Type"::Payment) OR
                                   ("Document Type" = "Document Type"::Refund)
                                THEN
                                    IF WHTPostingSetup.GET(
                                         "WHT Business Posting Group FND",
                                         "WHT Product Posting Group FND")
                                    THEN BEGIN
                                        IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                                            IF GenJnlLine1.FINDFIRST THEN
                                                WHTManagement.CheckApplicationGenPurchWHT(GenJnlLine1);
                                            WHTAmountLCY :=
                                              CurrExchRate.ExchangeAmtFCYToLCY(
                                                "Document Date",
                                                "Currency Code",
                                                ABS(
                                                  WHTManagement.CalcVendExtraWHTForEarliest(GenJnlLine1)), CurrFactor);
                                        END;

                                        IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment) AND
                                           (NOT GLSetup."Manual Sales WHT Calc. FND")
                                        THEN
                                            WHTAmountLCY :=
                                              CurrExchRate.ExchangeAmtFCYToLCY(
                                                "Document Date",
                                                "Currency Code",
                                                ABS(
                                                  WHTManagement.WHTAmountJournal(GenJnlLine1, TRUE)), CurrFactor);
                                    END;
                                IF "Document Type" = "Document Type"::Refund THEN
                                    WHTAmountLCY := -ABS(WHTAmountLCY);
                            END;

                            IF GenJnlPostLineCBN.IsCustAcc(GenJnlLine) THEN BEGIN
                                CurrFactor :=
                                  CurrExchRate.ExchangeRate(
                                    GenJnlLine1."Document Date", "Currency Code");
                                IF "Bal. Account Type" = "Bal. Account Type"::Customer THEN
                                  //GenJnlLine1.VALIDATE(Amount,-GenJnlLine1.Amount);  //HEI.27
                                  //HEI.27<<
                                  BEGIN
                                    GenJnlLine1.Amount := -GenJnlLine1.Amount;
                                    GenJnlLine1."Amount (LCY)" := -GenJnlLine1."Amount (LCY)";
                                END;
                                //HEI.27>>

                                IF GenJnlPostLineCBN.IsPaymentOrRefund(GenJnlLine) THEN
                                    IF WHTPostingSetup.GET("WHT Business Posting Group FND", "WHT Product Posting Group FND") THEN BEGIN
                                        IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest) THEN BEGIN
                                            IF GenJnlLine1.FINDFIRST THEN
                                                WHTManagement.CheckApplicationGenSalesWHT(GenJnlLine1);
                                            WHTAmountLCY :=
                                              -CurrExchRate.ExchangeAmtFCYToLCY(
                                                "Document Date",
                                                "Currency Code",
                                                ABS(
                                                  WHTManagement.CalcCustExtraWHTForEarliest(GenJnlLine)), CurrFactor);
                                        END;

                                        IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment) AND
                                           (NOT GLSetup."Manual Sales WHT Calc. FND")
                                        THEN
                                            WHTAmountLCY :=
                                              -CurrExchRate.ExchangeAmtFCYToLCY(
                                                GenJnlLine1."Document Date",
                                                GenJnlLine1."Currency Code",
                                                ABS(
                                                  WHTManagement.ApplyCustCalcWHT(GenJnlLine1)), CurrFactor);
                                    END;

                                IF "Document Type" = "Document Type"::Refund THEN
                                    WHTAmountLCY := -ABS(WHTAmountLCY);
                            END;
                            WHTAmountLCY := ROUND(WHTAmountLCY);
                        END;

            IF WHTPostingSetup.GET("WHT Business Posting Group FND",
                 "WHT Product Posting Group FND")
            THEN
                IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                    IF ABS(Amount) < WHTPostingSetup."WHT Minimum Invoice Amount" THEN
                        WHTAmountLCY := 0;
                END;
        END;
    end;
    // BC Upgrade BHARDA11 << --24June2026
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPostCustOnAfterInitCustLedgEntry, '', false, false)]
    local procedure OnPostCustOnAfterInitCustLedgEntry(var GenJournalLine: Record "Gen. Journal Line"; var CustLedgEntry: Record "Cust. Ledger Entry"; Cust: Record Customer; CustPostingGr: Record "Customer Posting Group")
    begin
        //WHTPostingSetup.Get(GenJournalLine."WHT Business Posting Group FND", GenJournalLine."WHT Product Posting Group FND");
        CalcCustWHT(GenJournalLine, WHTPostingSetup, WHTAmountLCY, WHTAmount);
    end;

    procedure CalcCustWHT(GenJnlLine: Record "Gen. Journal Line"; var WHTPostingSetup: Record "WHT Posting Setup FND"; var WHTAmountLCY: Decimal; var WHTAmount: Decimal) //84..97
    var
        SourceCodeSetup: Record "Source Code Setup";
        GLSetup: record "General Ledger Setup";
    begin
        GLSetup.Get();
        WITH GenJnlLine DO BEGIN
            WHTAmountLCY := 0;
            SourceCodeSetup.GET;
            IF ProcessSourceCode("Source Code", SourceCodeSetup) THEN BEGIN
                GenJnlLine1.RESET;
                GenJnlLine1.COPY(GenJnlLine);
                IF GLSetup."Enable WHT FND" THEN
                    IF NOT GenJnlLine1."Skip WHT FND" THEN
                        IF (GenJnlLine1."Applies-to Doc. No." = '') AND
                           (GenJnlLine1."Applies-to ID" = '')
                        THEN BEGIN
                            IF (((GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::Invoice) OR
                                 (GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::"Credit Memo")) AND
                                ((GenJnlLine1."Account Type" = GenJnlLine1."Account Type"::"G/L Account") OR
                                 (GenJnlLine1."Bal. Account Type" = GenJnlLine1."Bal. Account Type"::"G/L Account")))
                            THEN
                                IF WHTPostingSetup.GET(GenJnlLine1."WHT Business Posting Group FND", GenJnlLine1."WHT Product Posting Group FND") THEN
                                    IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice) OR
                                       (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest)
                                    THEN BEGIN
                                        IF GenJnlLine1."WHT Absorb Base FND" <> 0 THEN
                                            WHTAmountLCY := -ROUND(GenJnlLine1."WHT Absorb Base FND" * WHTPostingSetup."WHT %" / 100)
                                        ELSE
                                            WHTAmountLCY := ROUND(GenJnlLine1.Amount * WHTPostingSetup."WHT %" / 100);
                                        WHTAmount := WHTAmountLCY;
                                    END;
                        END ELSE
                            IF (((GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::Invoice) OR
                                 (GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::"Credit Memo")) AND
                                ((GenJnlLine1."Account Type" = GenJnlLine1."Account Type"::"G/L Account") OR
                                 (GenJnlLine1."Bal. Account Type" = GenJnlLine1."Bal. Account Type"::"G/L Account")))
                            THEN
                                IF WHTPostingSetup.GET(GenJnlLine1."WHT Business Posting Group FND", GenJnlLine1."WHT Product Posting Group FND") THEN BEGIN
                                    IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest) THEN BEGIN
                                        GenJnlLine1.RESET;
                                        GenJnlLine1.COPY(GenJnlLine);
                                        IF GenJnlLine1.FINDFIRST THEN
                                            WHTManagement.CheckApplicationGenSalesWHT(GenJnlLine1);
                                        WHTAmountLCY := ROUND(WHTManagement.CalcCustExtraWHTForEarliest(GenJnlLine1));
                                        WHTAmount := WHTAmountLCY;
                                    END;

                                    IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice) THEN BEGIN
                                        GenJnlLine1.RESET;
                                        GenJnlLine1.COPY(GenJnlLine);
                                        IF GenJnlLine1.FINDFIRST THEN
                                            WHTManagement.CheckApplicationGenSalesWHT(GenJnlLine1);
                                        IF GenJnlLine1."WHT Absorb Base FND" <> 0 THEN
                                            WHTAmountLCY := -ROUND(GenJnlLine1."WHT Absorb Base FND" * WHTPostingSetup."WHT %" / 100)
                                        ELSE
                                            WHTAmountLCY := ROUND(GenJnlLine1.Amount * WHTPostingSetup."WHT %" / 100);
                                        WHTAmount := WHTAmountLCY;
                                    END;
                                END;

                IF GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::Invoice THEN BEGIN
                    IF "Currency Code" <> '' THEN
                        WHTAmountLCY :=
                          ABS(ROUND(
                              CurrExchRate.ExchangeAmtFCYToLCY(
                                "Posting Date", "Currency Code", WHTAmountLCY,
                                CurrExchRate.ExchangeRate("Posting Date", "Currency Code"))))
                    ELSE
                        WHTAmountLCY := ABS(WHTAmountLCY);
                    WHTAmount := ABS(WHTAmount);
                END ELSE BEGIN
                    IF "Currency Code" <> '' THEN
                        WHTAmountLCY :=
                          -ABS(ROUND(
                              CurrExchRate.ExchangeAmtFCYToLCY(
                                "Posting Date", "Currency Code", WHTAmountLCY,
                                CurrExchRate.ExchangeRate("Posting Date", "Currency Code"))))
                    ELSE
                        WHTAmountLCY := -ABS(WHTAmountLCY);
                    WHTAmount := -ABS(WHTAmount);
                END;
            END;
        END;
    end;

    procedure ProcessSourceCode(SourceCode: Code[10]; SourceCodeSetup: Record "Source Code Setup"): Boolean
    begin
        SourceCodeSetup.GET;
        EXIT(SourceCode IN [SourceCodeSetup."Payment Journal",
                            SourceCodeSetup."Purchase Journal",
                            SourceCodeSetup."Sales Journal",
                            SourceCodeSetup."Cash Receipt Journal",
                            SourceCodeSetup."General Journal"]);

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPostVendOnAfterInitVendLedgEntry, '', false, false)]
    local procedure OnPostVendOnAfterInitVendLedgEntry(var GenJnlLine: Record "Gen. Journal Line"; var VendLedgEntry: Record "Vendor Ledger Entry"; Vendor: Record Vendor; var TaxAmount: Decimal; var TaxAmountLCY: Decimal)
    begin
        CalcVendWHT(GenJnlLine, WHTPostingSetup, WHTAmountLCY, WHTAmount);
    end;

    procedure CalcVendWHT(GenJnlLine: Record "Gen. Journal Line"; var WHTPostingSetup: Record "WHT Posting Setup FND"; var WHTAmountLCY: Decimal; var WHTAmount: Decimal) //133..152
    var
        SourceCodeSetup: Record "Source Code Setup";
        GLSetup: record "General Ledger Setup";
    begin
        GLSetup.Get();
        WITH GenJnlLine DO BEGIN
            WHTAmountLCY := 0;
            SourceCodeSetup.GET;
            IF ProcessSourceCode("Source Code", SourceCodeSetup) THEN BEGIN
                GenJnlLine1.RESET;
                GenJnlLine1.COPY(GenJnlLine);
                IF GLSetup."Enable WHT FND" THEN
                    IF NOT GenJnlLine1."Skip WHT FND" THEN
                        IF (GenJnlLine1."Applies-to Doc. No." = '') AND
                           (GenJnlLine1."Applies-to ID" = '')
                        THEN BEGIN
                            IF (((GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::Invoice) OR
                                 (GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::"Credit Memo")) AND
                                ((GenJnlLine1."Account Type" = GenJnlLine1."Account Type"::"G/L Account") OR
                                 (GenJnlLine1."Bal. Account Type" = GenJnlLine1."Bal. Account Type"::"G/L Account")))
                            THEN
                                IF WHTPostingSetup.GET(GenJnlLine1."WHT Business Posting Group FND", GenJnlLine1."WHT Product Posting Group FND") THEN
                                    IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice) OR
                                       (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest)
                                    THEN BEGIN
                                        IF GenJnlLine1."WHT Absorb Base FND" <> 0 THEN
                                            WHTAmountLCY :=
                                              -ROUND(
                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                  "Posting Date", "Currency Code",
                                                  ROUND(GenJnlLine1."WHT Absorb Base FND" * WHTPostingSetup."WHT %" / 100), "Currency Factor"))
                                        ELSE
                                            WHTAmountLCY :=
                                              ROUND(
                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                  "Posting Date", "Currency Code",
                                                  ROUND(GenJnlLine1.Amount * WHTPostingSetup."WHT %" / 100), "Currency Factor"));
                                        WHTAmount := CalcDtldCVLedgEntryAmount(GenJnlLine, WHTPostingSetup."WHT %");
                                    END;
                        END ELSE
                            IF (((GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::Invoice) OR
                                 (GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::"Credit Memo")) AND
                                ((GenJnlLine1."Account Type" = GenJnlLine1."Account Type"::"G/L Account") OR
                                 (GenJnlLine1."Bal. Account Type" = GenJnlLine1."Bal. Account Type"::"G/L Account")))
                            THEN
                                IF WHTPostingSetup.GET(GenJnlLine1."WHT Business Posting Group FND", GenJnlLine1."WHT Product Posting Group FND") THEN BEGIN
                                    IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                                        GenJnlLine1.RESET;
                                        GenJnlLine1.COPY(GenJnlLine);
                                        IF GenJnlLine1.FINDFIRST THEN
                                            WHTManagement.CheckApplicationGenPurchWHT(GenJnlLine1);
                                        WHTAmountLCY := ROUND(WHTManagement.CalcVendExtraWHTForEarliest(GenJnlLine1));
                                        WHTAmount := WHTAmountLCY;
                                    END;

                                    IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice THEN BEGIN
                                        GenJnlLine1.RESET;
                                        GenJnlLine1.COPY(GenJnlLine);
                                        IF GenJnlLine1.FINDFIRST THEN
                                            WHTManagement.CheckApplicationGenPurchWHT(GenJnlLine1);
                                        IF GenJnlLine1."WHT Absorb Base FND" <> 0 THEN
                                            WHTAmountLCY :=
                                              -ROUND(
                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                  "Posting Date", "Currency Code",
                                                  ROUND(GenJnlLine1."WHT Absorb Base FND" * WHTPostingSetup."WHT %" / 100), "Currency Factor"))
                                        ELSE
                                            WHTAmountLCY :=
                                              ROUND(
                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                  "Posting Date", "Currency Code",
                                                  ROUND(GenJnlLine1.Amount * WHTPostingSetup."WHT %" / 100), "Currency Factor"));
                                        WHTAmount := CalcDtldCVLedgEntryAmount(GenJnlLine, WHTPostingSetup."WHT %");
                                    END;
                                END;
                IF GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::Invoice THEN BEGIN
                    WHTAmountLCY := -ABS(WHTAmountLCY);
                    WHTAmount := -ABS(WHTAmount);
                END ELSE BEGIN
                    WHTAmountLCY := ABS(WHTAmountLCY);
                    WHTAmount := ABS(WHTAmount);
                END;
            END;

            IF WHTPostingSetup.GET("WHT Business Posting Group FND", "WHT Product Posting Group FND") THEN
                IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN
                    IF Amount < WHTPostingSetup."WHT Minimum Invoice Amount" THEN
                        WHTAmountLCY := 0;
        END;

    end;

    local procedure CalcDtldCVLedgEntryAmount(GenJnlLine: Record "Gen. Journal Line"; WHTPercent: Decimal): Decimal
    begin
        WITH GenJnlLine DO BEGIN
            IF "WHT Absorb Base FND" <> 0 THEN
                EXIT(GenJnlPost.ExchangeAmtLCYToFCY2(-ROUND("WHT Absorb Base FND" * WHTPercent / 100)));
            EXIT(GenJnlPost.ExchangeAmtLCYToFCY2(ROUND(Amount * WHTPercent / 100)));
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterCustLedgEntryInsert, '', false, false)]
    local procedure OnAfterCustLedgEntryInsert(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; var DtldLedgEntryInserted: Boolean; PreviewMode: Boolean)
    begin
        PostCustWHT(GenJournalLine, CustLedgerEntry, WHTPostingSetup, WHTAmountLCY);
    end;

    procedure PostCustWHT(GenJnlLine: Record "Gen. Journal Line"; CustLedgEntry: Record "Cust. Ledger Entry"; WHTPostingSetup: Record "WHT Posting Setup FND"; WHTAmountLCY: Decimal) //98..132
    var
        TempGenJnlTemp: Record "Gen. Journal Template";
        SourceCodeSetup: Record "Source Code Setup";
        GLSetup: record "General Ledger Setup";
    begin
        GLSetup.Get();
        SourceCodeSetup.GET;
        WITH GenJnlLine DO BEGIN
            GenJnlLine1.RESET;
            GenJnlLine1.COPY(GenJnlLine);
            IF WHTAmountLCY <> 0 THEN
                IF ((GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::Invoice) OR
                    (GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::"Credit Memo"))
                THEN
                    IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice) OR
                       (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest)
                    THEN BEGIN
                        WHTPostingSetup.TESTFIELD("Prepaid WHT Account Code");
                        GenJnlPost.CreateGLEntry(
                          GenJnlLine, WHTPostingSetup."Prepaid WHT Account Code", WHTAmountLCY, WHTAmountLCY, TRUE);
                    END;

            SourceCodeSetup.GET;
            IF "Source Code" <> SourceCodeSetup."Financially Voided Check" THEN BEGIN
                GenJnlLine1.RESET;
                GenJnlLine1.COPY(GenJnlLine);
                IF GLSetup."Enable WHT FND" THEN
                    IF IsAboveWHTMinInvoiceAmount(GenJnlLine) THEN BEGIN
                        IF NOT "Skip WHT FND" THEN BEGIN
                            IF ("Applies-to Doc. No." <> '') OR ("Applies-to ID" <> '') THEN BEGIN
                                KeepWHTEntryNo := NextWHTEntryNo;
                                CASE "Document Type" OF
                                    "Document Type"::Payment:
                                        IF GLSetup."Manual Sales WHT Calc. FND" THEN BEGIN
                                            IF "WHT Payment FND" THEN
                                                NextWHTEntryNo := WHTManagement.ApplyManualCustInvoiceWHT(CustLedgEntry, GenJnlLine1);
                                        END ELSE
                                            IF WHTPostingSetup.GET(
                                                 "WHT Business Posting Group FND",
                                                 "WHT Product Posting Group FND")
                                            THEN BEGIN
                                                IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN BEGIN
                                                    NextWHTEntryNo := WHTManagement.ApplyCustInvoiceWHT(CustLedgEntry, GenJnlLine1);
                                                    IF NextWHTEntryNo <> -1 THEN
                                                        HadWHTEntryNo := TRUE
                                                    ELSE
                                                        NextWHTEntryNo := KeepWHTEntryNo;
                                                END;

                                                IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                                                    NextWHTEntryNo := WHTManagement.InsertCustJournalWHT(GenJnlLine);
                                                    IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                        WHTEntry."Transaction No." := NextTransactionNo;
                                                        WHTEntry.MODIFY;
                                                    END;
                                                END;
                                            END;
                                    "Document Type"::Invoice:
                                        BEGIN
                                            IF ProcessSourceCode("Source Code", SourceCodeSetup) THEN
                                                IF WHTPostingSetup.GET("WHT Business Posting Group FND", "WHT Product Posting Group FND") THEN
                                                    IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice) OR
                                                       (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest)
                                                    THEN BEGIN
                                                        GenJnlLine2.RESET;
                                                        GenJnlLine2.COPY(GenJnlLine);
                                                        GenJnlLine2.Amount := ABS(GenJnlLine2.Amount);
                                                        GenJnlLine2."WHT Absorb Base FND" := ABS(GenJnlLine2."WHT Absorb Base FND");
                                                        NextWHTEntryNo := WHTManagement.InsertCustJournalWHT(GenJnlLine2);
                                                        IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                            WHTEntry."Transaction No." := NextTransactionNo;
                                                            WHTEntry.MODIFY;
                                                        END;
                                                    END;
                                            IF SourceCodeSetup.Sales = "Source Code" THEN
                                                UpdateWHTEntryTransaction("Document No.");
                                        END;
                                    "Document Type"::"Credit Memo":
                                        BEGIN
                                            IF ProcessSourceCode("Source Code", SourceCodeSetup) THEN
                                                IF WHTPostingSetup.GET("WHT Business Posting Group FND", "WHT Product Posting Group FND") THEN
                                                    IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice) OR
                                                       (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest)
                                                    THEN BEGIN
                                                        GenJnlLine2.RESET;
                                                        GenJnlLine2.COPY(GenJnlLine);
                                                        GenJnlLine2.Amount := ABS(GenJnlLine2.Amount);
                                                        GenJnlLine2."WHT Absorb Base FND" := ABS(GenJnlLine2."WHT Absorb Base FND");
                                                        NextWHTEntryNo := WHTManagement.InsertCustJournalWHT(GenJnlLine2);
                                                        IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                            WHTEntry."Transaction No." := NextTransactionNo;
                                                            WHTEntry.MODIFY;
                                                        END;
                                                    END;

                                            IF SourceCodeSetup.Sales = "Source Code" THEN
                                                UpdateWHTEntryTransaction("Document No.");
                                        END;
                                    "Document Type"::Refund:
                                        IF GLSetup."Manual Sales WHT Calc. FND" THEN BEGIN
                                            IF "WHT Payment FND" THEN
                                                NextWHTEntryNo := WHTManagement.ApplyManualCustInvoiceWHT(CustLedgEntry, GenJnlLine1);
                                        END ELSE
                                            IF WHTPostingSetup.GET("WHT Business Posting Group FND", "WHT Product Posting Group FND") THEN BEGIN
                                                IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN BEGIN
                                                    NextWHTEntryNo := WHTManagement.ApplyCustInvoiceWHT(CustLedgEntry, GenJnlLine1);
                                                    IF NextWHTEntryNo <> -1 THEN
                                                        HadWHTEntryNo := TRUE
                                                    ELSE
                                                        NextWHTEntryNo := KeepWHTEntryNo;
                                                END;

                                                IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                                                    NextWHTEntryNo := WHTManagement.InsertCustJournalWHT(GenJnlLine);
                                                    IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                        WHTEntry."Transaction No." := NextTransactionNo;
                                                        WHTEntry.MODIFY;
                                                    END;
                                                END;
                                            END;
                                END;
                                TempGenJnlTemp.SETRANGE(Type, TempGenJnlTemp.Type::Sales);
                                IF TempGenJnlTemp.FINDFIRST THEN
                                    IF "Journal Template Name" = TempGenJnlTemp.Name THEN BEGIN
                                        WHTEntry.RESET;
                                        WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::Payment);
                                        WHTEntry.SETRANGE("Document No.", "Document No.");
                                        WHTEntry.SETRANGE("Bill-to/Pay-to No.", "Account No.");
                                        WHTEntry.SETFILTER("Remaining Unrealized Amount", '<>0');
                                        IF WHTEntry.FIND('-') THEN
                                            REPEAT
                                                WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                                WHTPostingSetup.TESTFIELD("Prepaid WHT Account Code");
                                                GenJnlPost.CreateGLEntry(
                                                  GenJnlLine, WHTPostingSetup."Prepaid WHT Account Code", -WHTEntry."Amount (LCY)", "Source Currency Amount", TRUE);
                                            UNTIL WHTEntry.NEXT = 0;
                                    END;
                            END ELSE
                                KeepWHTEntryNo := NextWHTEntryNo;
                            CASE "Document Type" OF
                                "Document Type"::Invoice:
                                    BEGIN
                                        IF ProcessSourceCode("Source Code", SourceCodeSetup) THEN BEGIN
                                            GenJnlLine2.RESET;
                                            GenJnlLine2.COPY(GenJnlLine);
                                            GenJnlLine2.Amount := -ABS(GenJnlLine2.Amount);
                                            GenJnlLine2."WHT Absorb Base FND" := -ABS(GenJnlLine2."WHT Absorb Base FND");
                                            NextWHTEntryNo := WHTManagement.InsertCustJournalWHT(GenJnlLine2);
                                        END;
                                        UpdateWHTEntryTransaction("Document No.");
                                    END;
                                "Document Type"::"Credit Memo":
                                    BEGIN
                                        IF ProcessSourceCode("Source Code", SourceCodeSetup) THEN BEGIN
                                            GenJnlLine2.RESET;
                                            GenJnlLine2.COPY(GenJnlLine);
                                            GenJnlLine2.Amount := ABS(GenJnlLine2.Amount);
                                            GenJnlLine2."WHT Absorb Base FND" := ABS(GenJnlLine2."WHT Absorb Base FND");
                                            NextWHTEntryNo := WHTManagement.InsertCustJournalWHT(GenJnlLine2);
                                        END;
                                        UpdateWHTEntryTransaction("Document No.");
                                    END;
                                "Document Type"::Payment:
                                    IF WHTPostingSetup.GET("WHT Business Posting Group FND", "WHT Product Posting Group FND") THEN
                                        IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                                            GenJnlLine2.RESET;
                                            GenJnlLine2.COPY(GenJnlLine);
                                            GenJnlLine2.Amount := -ABS(GenJnlLine2.Amount);
                                            GenJnlLine2."WHT Absorb Base FND" := -ABS(GenJnlLine2."WHT Absorb Base FND");
                                            NextWHTEntryNo := WHTManagement.InsertCustJournalWHT(GenJnlLine2);
                                            IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                WHTEntry."Transaction No." := NextTransactionNo;
                                                WHTEntry.MODIFY;
                                            END;
                                        END ELSE
                                            IF GLSetup."Manual Sales WHT Calc. FND" THEN
                                                IF "WHT Payment FND" THEN BEGIN
                                                    GenJnlLine2.RESET;
                                                    GenJnlLine2.COPY(GenJnlLine);
                                                    GenJnlLine2.Amount := -ABS(GenJnlLine2.Amount);
                                                    GenJnlLine2."WHT Absorb Base FND" := -ABS(GenJnlLine2."WHT Absorb Base FND");
                                                    NextWHTEntryNo := WHTManagement.InsertCustJournalWHT(GenJnlLine2);
                                                    InsertWHTPaymentGL(GenJnlLine2, GenJnlLine, CustLedgEntry."Entry No.");
                                                    IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                        WHTEntry."Transaction No." := NextTransactionNo;
                                                        WHTEntry.MODIFY;
                                                    END;
                                                END;
                                "Document Type"::Refund:
                                    IF WHTPostingSetup.GET("WHT Business Posting Group FND", "WHT Product Posting Group FND") THEN
                                        IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                                            GenJnlLine2.RESET;
                                            GenJnlLine2.COPY(GenJnlLine);
                                            GenJnlLine2.Amount := -ABS(GenJnlLine2.Amount);
                                            GenJnlLine2."WHT Absorb Base FND" := -ABS(GenJnlLine2."WHT Absorb Base FND");
                                            NextWHTEntryNo := WHTManagement.InsertCustJournalWHT(GenJnlLine2);
                                            IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                WHTEntry."Transaction No." := NextTransactionNo;
                                                WHTEntry.MODIFY;
                                            END;
                                        END;
                            END;
                        END
                    END;
                IF NextWHTEntryNo = 0 THEN
                    NextWHTEntryNo := KeepWHTEntryNo;

                //PostCustWHTTaxInv(GenJnlLine,CustLedgEntry);

                IF "Applies-to ID" <> '' THEN BEGIN
                    CustLedgEntry.RESET;
                    CustLedgEntry.SETCURRENTKEY("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
                    IF "Account Type" = "Account Type"::Customer THEN
                        CustLedgEntry.SETRANGE("Customer No.", "Account No.");
                    CustLedgEntry.SETRANGE("Applies-to ID", "Applies-to ID");
                    CustLedgEntry.SETRANGE("Amount to Apply", 0);
                    IF CustLedgEntry.FINDFIRST THEN
                        CustLedgEntry.MODIFYALL("Applies-to ID", '');
                END;
            END;
        END;
    end;

    procedure UpdateWHTEntryTransaction(DocNo: Code[20]) // 239..243
    var
        WHTEntry: Record "WHT Entry FND";
        WHTPostingSetup: Record "WHT Posting Setup FND";
    Begin
        WHTEntry.RESET;
        WHTEntry.SETCURRENTKEY("Document No.", "Posting Date");
        WHTEntry.SETRANGE("Document No.", DocNo);
        IF WHTEntry.FINDSET(TRUE, FALSE) THEN
            REPEAT
                WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice) OR
                   (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest)
                THEN BEGIN
                    WHTEntry."Transaction No." := NextTransactionNo;
                    WHTEntry.MODIFY;
                END;
            UNTIL WHTEntry.NEXT = 0;
    End;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnUnapplyCustLedgEntryOnAfterCreateGLEntriesForTotalAmounts, '', false, false)]
    local procedure OnUnapplyCustLedgEntryOnAfterCreateGLEntriesForTotalAmounts(var GenJournalLine: Record "Gen. Journal Line"; DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; GLReg: Record "G/L Register")
    begin
        UnapplyWHTEntry(
  GenJournalLine, WHTEntry."Transaction Type"::Sale, DetailedCustLedgEntry."Customer No.", DetailedCustLedgEntry."Transaction No.", FALSE);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnUnapplyVendLedgEntryOnAfterCreateGLEntriesForTotalAmounts, '', false, false)]
    local procedure OnUnapplyVendLedgEntryOnAfterCreateGLEntriesForTotalAmounts(var GenJournalLine: Record "Gen. Journal Line"; DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry"; GLReg: Record "G/L Register"; GenJournalLineToPost: Record "Gen. Journal Line"; var NextTaxEntryNo: Integer; var NextEntryNo: Integer; var NextCheckEntryNo: Integer; NextTransactionNo: Integer)
    begin
        UnapplyWHTEntry(
          GenJournalLine, WHTEntry."Transaction Type"::Purchase, DetailedVendorLedgEntry."Vendor No.", DetailedVendorLedgEntry."Transaction No.", false);
    end;

    // BC Upgrade RD03 - "Manual Sales WHT Calc. FND" field is not enabled in any Opco In NAV, so the below event is commented -->>
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnVendUnrealizedVATOnBeforeGetUnrealizedVATPart, '', false, false)]
    // local procedure OnVendUnrealizedVATOnBeforeGetUnrealizedVATPart(var GenJournalLine: Record "Gen. Journal Line"; var VendorLedgerEntry: Record "Vendor Ledger Entry"; PaidAmount: Decimal; TotalUnrealVATAmountFirst: Decimal; TotalUnrealVATAmountLast: Decimal; SettledAmount: Decimal; VATEntry2: Record "VAT Entry"; var VATPart: Decimal; var IsHandled: Boolean)
    // var
    //     PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
    //     GLSetup: record "General Ledger Setup";
    // begin
    //     GLSetup.Get();
    //     IsHandled := true;
    //     IF GenJournalLine."Document Type" = GenJournalLine."Document Type"::Refund THEN
    //         IF GLSetup."Manual Sales WHT Calc. FND" THEN BEGIN
    //             IF PurchCrMemoHeader.GET(VendorLedgerEntry."Document No.") THEN
    //                 WHTAmount := -CollectWHTAmount(PurchCrMemoHeader."No.");

    //             VATPart :=
    //              VATEntry2.GetUnrealizedVATPart(
    //                Round(SettledAmount / VendorLedgerEntry.GetAdjustedCurrencyFactor()),
    //                PaidAmount,
    //                VendorLedgerEntry."Amount (LCY)" - WHTAmount,
    //                TotalUnrealVATAmountFirst,
    //                TotalUnrealVATAmountLast);
    //         END;
    // end;
    // BC Upgrade RD03 - "Manual Sales WHT Calc. FND" field is not enabled in any Opco In NAV, so the below event is commented -->>

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforeCustUnrealizedVAT, '', false, false)]
    local procedure OnBeforeCustUnrealizedVAT(var GenJnlLine: Record "Gen. Journal Line"; var CustLedgEntry: Record "Cust. Ledger Entry"; SettledAmount: Decimal; var IsHandled: Boolean)
    var
        WHTAmount: Decimal;
        GLSetup: record "General Ledger Setup";
    begin
        WHTAmount := CollectWHTAmount(CustLedgEntry."Document No.");
        GLSetup.Get();
        IF (SettledAmount > 0) AND (WHTAmount <> 0) THEN
            SettledAmount := -SettledAmount;

        IF WHTAmount <> 0 THEN
            IF GLSetup."Manual Sales WHT Calc. FND" THEN BEGIN
                IF ((GenJnlLine."Posting Date" < CustLedgEntry."Pmt. Discount Date") AND
                    ((ABS(SettledAmount) + ABS(WHTAmount)) >=
                     (ABS(CustLedgEntry."Rem. Amt FND") - ABS(CustLedgEntry."Original Pmt. Disc. Possible"))))
                THEN
                    SettledAmount := SettledAmount - CustLedgEntry."Remaining Pmt. Disc. Possible";
            END;

    end;

    procedure CollectWHTAmount(DocNo: Code[20]) WHTAmount: Decimal
    var
        WHTEntry: Record "WHT Entry FND";
    begin
        WITH WHTEntry DO BEGIN
            RESET;
            SETCURRENTKEY("Document No.");
            SETRANGE("Document No.", DocNo);
            SETFILTER("Applies-to Entry No.", '%1', 0);
            IF FINDSET THEN
                REPEAT
                    WHTAmount := WHTAmount + "Unrealized Amount (LCY)";
                UNTIL NEXT = 0;
        END;
    end;

    procedure UnapplyWHTEntry(GenJnlLine: Record "Gen. Journal Line"; TransactionType: Option; CVNo: Code[20]; TransactionNo: Integer; VoidCheck: Boolean)// 244..248
    var
        WHTEntry: Record "WHT Entry FND";
        NewWHTEntry: Record "WHT Entry FND";
        UnrealizedWHTEntry: Record "WHT Entry FND";
        WHTPostingSetup: Record "WHT Posting Setup FND";
        Vend: Record Vendor;
        Source: Option;
        PurchInvHeader: Record "Purch. Inv. Header";
        lWHTEntry: Record "WHT Entry FND";
    begin
        GenJnlLine2.Reset();
        GenJnlLine2.copy(GenJnlLine);
        WHTEntry.RESET;
        WHTEntry.SETCURRENTKEY("Transaction Type", "Bill-to/Pay-to No.", "Transaction No.");
        WHTEntry.SETRANGE("Transaction Type", TransactionType);
        WHTEntry.SETRANGE("Bill-to/Pay-to No.", CVNo);
        WHTEntry.SETRANGE("Transaction No.", TransactionNo);
        WHTEntry.SETFILTER("Document Type", '<>%1', WHTEntry."Document Type"::"Credit Memo");
        IF WHTEntry.FINDSET THEN
            REPEAT
                NewWHTEntry := WHTEntry;
                NewWHTEntry."Closed by Entry No." := 0;
                NewWHTEntry.Closed := FALSE;
                NewWHTEntry."Posting Date" := GenJnlLine2."Posting Date";
                NewWHTEntry.Base := -WHTEntry.Base;
                NewWHTEntry.Amount := -WHTEntry.Amount;
                NewWHTEntry."Base (LCY)" := -WHTEntry."Base (LCY)";
                NewWHTEntry."Amount (LCY)" := -WHTEntry."Amount (LCY)";
                NewWHTEntry."Unrealized Amount" := -WHTEntry."Unrealized Amount";
                NewWHTEntry."Unrealized Base" := -WHTEntry."Unrealized Base";
                NewWHTEntry."Remaining Unrealized Amount" := -WHTEntry."Remaining Unrealized Amount";
                NewWHTEntry."Remaining Unrealized Base" := -WHTEntry."Remaining Unrealized Base";
                NewWHTEntry."Original Document No." := WHTEntry."Document No.";
                NewWHTEntry."Transaction No." := NextTransactionNo;
                //<<HEI.13
                IF GenJnlLine2."Document Type" = GenJnlLine2."Document Type"::Payment THEN
                    IF GenJnlLine2."Applies-to Doc. Type" = GenJnlLine2."Applies-to Doc. Type"::Invoice THEN
                        IF PurchInvHeader.GET(GenJnlLine2."Applies-to Doc. No.") THEN BEGIN
                            lWHTEntry.RESET;
                            lWHTEntry.SETCURRENTKEY("Document No.");
                            lWHTEntry.SETRANGE("Document No.", GenJnlLine2."Applies-to Doc. No.");
                            IF lWHTEntry.FINDFIRST THEN
                                NewWHTEntry."Invoice Payment Date" := GenJnlLine2."Posting Date";
                        END;
                //>>HEI.13
                NewWHTEntry."Entry No." := NextWHTEntryNo;
                NextWHTEntryNo := NextWHTEntryNo + 1;
                //HEI.19>>
                IF gWHTPostingSetup.GET(NewWHTEntry."WHT Bus. Posting Group", NewWHTEntry."WHT Prod. Posting Group") THEN
                    NewWHTEntry."WHT Bearer" := gWHTPostingSetup."WHT Bearer";
                //HEI.19<<
                NewWHTEntry.INSERT;
                IF WHTEntry."Unrealized WHT Entry No." <> 0 THEN BEGIN
                    WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                    IF NOT VoidCheck THEN BEGIN
                        GenJnlLine1.COPY(GenJnlLine);
                        GenJnlLine1.Amount := -WHTEntry.Amount;
                        GenJnlLine1."Amount (LCY)" := -WHTEntry."Amount (LCY)";
                        CASE TransactionType OF
                            WHTEntry."Transaction Type"::Sale:
                                Source := 0;
                            WHTEntry."Transaction Type"::Purchase:
                                Source := 1;
                        END;
                        InsertWHTPostingBufferPosted(WHTEntry, GenJnlLine1, FALSE, Source);
                    END ELSE BEGIN

                        IF WHTEntry."Amount (LCY)" <> 0 THEN
                            WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                        GenJnlPost.CreateGLEntry(
                          GenJnlLine, WHTPostingSetup."Payable WHT Account Code", WHTEntry."Amount (LCY)", 0, FALSE);
                    END;

                    UnrealizedWHTEntry.GET(WHTEntry."Unrealized WHT Entry No.");
                    UnrealizedWHTEntry."Remaining Unrealized Amount" := UnrealizedWHTEntry."Remaining Unrealized Amount" + WHTEntry.Amount;
                    UnrealizedWHTEntry."Remaining Unrealized Base" := UnrealizedWHTEntry."Remaining Unrealized Base" + WHTEntry.Base;
                    UnrealizedWHTEntry."Rem Unrealized Amount (LCY)" := UnrealizedWHTEntry."Rem Unrealized Amount (LCY)" + WHTEntry."Amount (LCY)";
                    UnrealizedWHTEntry."Rem Unrealized Base (LCY)" := UnrealizedWHTEntry."Rem Unrealized Base (LCY)" + WHTEntry."Base (LCY)";
                    UnrealizedWHTEntry.Closed := FALSE;
                    UnrealizedWHTEntry.MODIFY;
                END;
                WHTEntry."Original Document No." := NewWHTEntry."Document No.";
                WHTEntry.MODIFY;
            UNTIL WHTEntry.NEXT = 0;
    end;

    procedure InsertWHTPaymentGL(GenJnlLine: Record "Gen. Journal Line"; var GenJnlLineWHT: Record "Gen. Journal Line"; var EntryNo: Integer) //51..54
    var
        BankAcc: Record "Bank Account";
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        CheckLedgEntry: Record "Check Ledger Entry";
        CheckLedgEntry2: Record "Check Ledger Entry";
        BankAccPostingGr: Record "Bank Account Posting Group";
        WHTPostingSetup: Record "WHT Posting Setup FND";
        WHTAmountLCY: Decimal;
        WHTAmount: Decimal;
    begin
        WITH GenJnlLineWHT DO BEGIN
            WHTPostingSetup.GET("WHT Business Posting Group FND", "WHT Product Posting Group FND");
            IF "Bal. Account Type" = "Bal. Account Type"::"Bank Account" THEN BEGIN
                "Line No." += 10000;
                BankAcc.GET("Bal. Account No.");
                BankAccPostingGr.GET(BankAcc."Bank Acc. Posting Group");
            END;
            WHTPostingSetup.TESTFIELD("Prepaid WHT Account Code");
            GenJnlPost.CreateGLEntry(
              GenJnlLineWHT, WHTPostingSetup."Prepaid WHT Account Code", -GenJnlLine.Amount, -GenJnlLine.Amount, TRUE);
            GenJnlPost.CreateGLEntry(
              GenJnlLineWHT, BankAccPostingGr."G/L Account No.", GenJnlLine.Amount, GenJnlLine.Amount, TRUE);

            BankAccLedgEntry.LOCKTABLE;
            IF BankAcc."No." <> "Bal. Account No." THEN
                BankAcc.GET("Bal. Account No.");
            BankAcc.TESTFIELD(Blocked, FALSE);
            IF "Currency Code" = '' THEN
                BankAcc.TESTFIELD("Currency Code", '')
            ELSE
                IF BankAcc."Currency Code" <> '' THEN
                    TESTFIELD("Currency Code", BankAcc."Currency Code");

            BankAcc.TESTFIELD("Bank Acc. Posting Group");
            BankAccPostingGr.GET(BankAcc."Bank Acc. Posting Group");

            BankAccLedgEntry.INIT;
            BankAccLedgEntry."Bank Account No." := "Bal. Account No.";
            BankAccLedgEntry."Posting Date" := "Posting Date";
            BankAccLedgEntry."Document Date" := "Document Date";
            BankAccLedgEntry."Document Type" := "Document Type";
            BankAccLedgEntry."Document No." := "Document No.";
            BankAccLedgEntry."External Document No." := "External Document No.";
            BankAccLedgEntry.Description := Description;
            BankAccLedgEntry."Bank Acc. Posting Group" := BankAcc."Bank Acc. Posting Group";
            BankAccLedgEntry."Global Dimension 1 Code" := "Shortcut Dimension 1 Code";
            BankAccLedgEntry."Global Dimension 2 Code" := "Shortcut Dimension 2 Code";
            BankAccLedgEntry."Our Contact Code" := "Salespers./Purch. Code";
            BankAccLedgEntry."Source Code" := "Source Code";
            BankAccLedgEntry."Journal Batch Name" := "Journal Batch Name";
            BankAccLedgEntry."Reason Code" := "Reason Code";
            BankAccLedgEntry."Entry No." := NextEntryNo;
            BankAccLedgEntry."Transaction No." := NextTransactionNo;
            BankAccLedgEntry."Currency Code" := BankAcc."Currency Code";

            CalcBankAccWHT2(GenJnlLine, WHTPostingSetup, WHTAmountLCY, WHTAmount);

            IF BankAcc."Currency Code" <> '' THEN
                BankAccLedgEntry.Amount := Amount
            ELSE
                BankAccLedgEntry.Amount := "Amount (LCY)" + WHTAmountLCY;
            BankAccLedgEntry."Amount (LCY)" := "Amount (LCY)" + WHTAmountLCY;
            BankAccLedgEntry."User ID" := USERID;
            IF BankAccLedgEntry.Amount <> 0 THEN BEGIN
                BankAccLedgEntry.Open := TRUE;
                BankAccLedgEntry."Remaining Amount" := BankAccLedgEntry.Amount;
            END;
            BankAccLedgEntry.Positive := BankAccLedgEntry.Amount > 0;
            BankAccLedgEntry."Bal. Account Type" := "Bal. Account Type";
            BankAccLedgEntry."Bal. Account No." := "Bal. Account No.";
            IF (Amount > 0) AND (NOT Correction) OR
               ("Amount (LCY)" > 0) AND (NOT Correction) OR
               (Amount < 0) AND Correction OR
               ("Amount (LCY)" < 0) AND Correction
            THEN BEGIN
                BankAccLedgEntry."Debit Amount" := BankAccLedgEntry.Amount;
                BankAccLedgEntry."Credit Amount" := 0;
                BankAccLedgEntry."Debit Amount (LCY)" := BankAccLedgEntry."Amount (LCY)";
                BankAccLedgEntry."Credit Amount (LCY)" := 0;
            END ELSE BEGIN
                BankAccLedgEntry."Debit Amount" := 0;
                BankAccLedgEntry."Credit Amount" := -BankAccLedgEntry.Amount;
                BankAccLedgEntry."Debit Amount (LCY)" := 0;
                BankAccLedgEntry."Credit Amount (LCY)" := -BankAccLedgEntry."Amount (LCY)";
            END;
            BankAccLedgEntry.INSERT;
        END;
    end;

    procedure CalcBankAccWHT(GenJnlLine: Record "Gen. Journal Line"; var WHTPostingSetup: Record "WHT Posting Setup FND"; var WHTAmountLCY: Decimal; var WHTAmount: Decimal)//184..209
    var
        CheckLedgEntry: Record "Check Ledger Entry";
        GLSetup: record "General Ledger Setup";
    begin
        GLSetup.Get();
        WITH GenJnlLine DO BEGIN
            WHTAmountLCY := 0;
            IF NOT GLSetup."Enable WHT FND" OR "Skip WHT FND" THEN
                EXIT;

            IF ("Applies-to ID" = '') AND ("Applies-to Doc. No." = '') THEN BEGIN
                IF ("Document Type" = "Document Type"::Payment) OR ("Document Type" = "Document Type"::Refund) THEN
                    IF WHTPostingSetup.GET("WHT Business Posting Group FND", "WHT Product Posting Group FND") THEN BEGIN
                        IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN
                            IF GenJnlPostLineCBN.IsCustAcc(GenJnlLine) THEN BEGIN
                                IF "WHT Absorb Base FND" <> 0 THEN
                                    WHTAmountLCY := -ABS(ROUND("WHT Absorb Base FND" * WHTPostingSetup."WHT %" / 100))
                                ELSE
                                    WHTAmountLCY := -ABS(ROUND(Amount * WHTPostingSetup."WHT %" / 100));
                                IF "Document Type" = "Document Type"::Refund THEN
                                    WHTAmountLCY := ABS(WHTAmountLCY);
                            END ELSE
                                IF GenJnlPostLineCBN.IsVendAcc(GenJnlLine) THEN BEGIN
                                    IF "WHT Absorb Base FND" <> 0 THEN
                                        WHTAmountLCY := ABS(ROUND("WHT Absorb Base FND" * WHTPostingSetup."WHT %" / 100))
                                    ELSE
                                        WHTAmountLCY := ABS(ROUND(Amount * WHTPostingSetup."WHT %" / 100));
                                    IF "Document Type" = "Document Type"::Refund THEN
                                        WHTAmountLCY := -ABS(WHTAmountLCY);
                                END;
                        IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN
                            ERROR(Text016, WHTPostingSetup."Realized WHT Type");
                    END;
                IF ("Currency Code" <> '') AND (CurrFactor <> 0) THEN
                    IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment) AND
                       (NOT GLSetup."Manual Sales WHT Calc. FND")
                    THEN
                        WHTAmountLCY :=
                          CurrExchRate.ExchangeAmtFCYToLCY(
                            "Document Date", "Currency Code",
                            ABS(WHTManagement.WHTAmountJournal(GenJnlLine, TRUE)), CurrFactor);
            END ELSE
                IF ("Applies-to ID" <> '') OR ("Applies-to Doc. No." <> '') THEN BEGIN
                    GenJnlLine1.RESET;
                    GenJnlLine1.COPY(GenJnlLine);
                    IF "Applies-to Doc. No." <> '' THEN
                        GenJnlLine1.SETRANGE("Applies-to Doc. No.", "Applies-to Doc. No.")
                    ELSE
                        GenJnlLine1.SETRANGE("Applies-to ID", "Applies-to ID");

                    GenJnlLine1.SETRANGE("Account Type", "Account Type"::Vendor);
                    IF ("Account Type" = "Account Type"::Vendor) OR
                       ("Bal. Account Type" = "Bal. Account Type"::Vendor) OR
                       GenJnlLine1.FINDFIRST
                    THEN BEGIN
                        CurrFactor :=
                          CurrExchRate.ExchangeRate(
                            "Document Date", "Currency Code");

                        GenJnlLine1.VALIDATE(Amount, GenJnlLine1.Amount);

                        IF (GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::Payment) OR
                           (GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::Refund)
                        THEN
                            IF WHTPostingSetup.GET(
                                 GenJnlLine1."WHT Business Posting Group FND",
                                 GenJnlLine1."WHT Product Posting Group FND")
                            THEN BEGIN
                                IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                                    IF GenJnlLine1.FINDFIRST THEN
                                        WHTManagement.CheckApplicationGenPurchWHT(GenJnlLine1);
                                    WHTAmountLCY :=
                                      CurrExchRate.ExchangeAmtFCYToLCY(
                                        "Document Date", "Currency Code",
                                        ABS(WHTManagement.CalcVendExtraWHTForEarliest(GenJnlLine1)), CurrFactor);
                                END;

                                IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment) AND
                                   (NOT GLSetup."Manual Sales WHT Calc. FND")
                                THEN BEGIN
                                    WHTAmount := ABS(WHTManagement.WHTAmountJournal(GenJnlLine1, TRUE));
                                    WHTAmountLCY :=
                                      CurrExchRate.ExchangeAmtFCYToLCY(
                                        GenJnlLine1."Document Date",
                                        GenJnlLine1."Currency Code",
                                        WHTAmount, CurrFactor);
                                END;
                            END;

                        IF "Document Type" = "Document Type"::Refund THEN
                            WHTAmountLCY := -ABS(WHTAmountLCY);
                    END;
                    // WHT is for Purchase / Vendor - so the customer related WHT calculation is commented -->>
                    // IF GenJnlPostLineCBN.IsCustAcc(GenJnlLine) THEN BEGIN
                    //     CurrFactor :=
                    //       CurrExchRate.ExchangeRate(
                    //         GenJnlLine1."Document Date", "Currency Code");
                    //     IF "Bal. Account Type" = "Bal. Account Type"::Customer THEN
                    //       GenJnlLine1.VALIDATE(Amount,-GenJnlLine1.Amount);  //HEI.27
                    //       HEI.27<<
                    //       BEGIN
                    //         GenJnlLine1.Amount := -GenJnlLine1.Amount;
                    //         GenJnlLine1."Amount (LCY)" := -GenJnlLine1."Amount (LCY)";
                    //     END;
                    //     HEI.27>>
                    //     IF GenJnlPostLineCBN.IsPaymentOrRefund(GenJnlLine1) THEN
                    //         IF WHTPostingSetup.GET(GenJnlLine1."WHT Business Posting Group FND", GenJnlLine1."WHT Product Posting Group FND") THEN BEGIN
                    //             IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                    //                 IF GenJnlLine1.FINDFIRST THEN
                    //                     WHTManagement.CheckApplicationGenSalesWHT(GenJnlLine1);
                    //                 WHTAmountLCY :=
                    //                   -CurrExchRate.ExchangeAmtFCYToLCY(
                    //                     GenJnlLine1."Document Date", GenJnlLine1."Currency Code",
                    //                     ABS(WHTManagement.CalcCustExtraWHTForEarliest(GenJnlLine1)), CurrFactor);
                    //             END;

                    //             IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment) AND
                    //                (NOT GLSetup."Manual Sales WHT Calc. FND")
                    //             THEN BEGIN
                    //                 WHTAmount := -ABS(WHTManagement.ApplyCustCalcWHT(GenJnlLine1));
                    //                 WHTAmountLCY :=
                    //                   -CurrExchRate.ExchangeAmtFCYToLCY(
                    //                     GenJnlLine1."Document Date",
                    //                     GenJnlLine1."Currency Code",
                    //                     ABS(WHTAmount), CurrFactor);
                    //             END;
                    //         END;

                    //     IF "Document Type" = "Document Type"::Refund THEN
                    //         WHTAmountLCY := ABS(WHTAmountLCY);
                    // END;
                    // WHT is for Purchase / Vendor - so the customer related WHT calculation is commented --<<
                    WHTAmountLCY := ROUND(WHTAmountLCY);

                    IF GLSetup."Round Amount for WHT Calc FND" THEN
                        WHTAmountLCY := ROUND(WHTAmountLCY, 1, '<');
                END ELSE
                    IF "Bank Payment Type" =
                       "Bank Payment Type"::"Computer Check"
                    THEN BEGIN
                        TESTFIELD("Check Printed", TRUE);
                        CheckLedgEntry.LOCKTABLE;
                        CheckLedgEntry.RESET;
                        CheckLedgEntry.SETCURRENTKEY("Bank Account No.", "Entry Status", "Check No.");
                        CheckLedgEntry.SETRANGE("Bank Account No.", "Account No.");
                        CheckLedgEntry.SETRANGE("Entry Status", CheckLedgEntry."Entry Status"::Printed);
                        CheckLedgEntry.SETRANGE("Check No.", "Document No.");
                        IF CheckLedgEntry.FIND('-') THEN
                            WHTAmountLCY := ABS(CheckLedgEntry."WHT Amount FND")
                    END;

            IF WHTPostingSetup.GET("WHT Business Posting Group FND", "WHT Product Posting Group FND") THEN
                IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN
                    IF ABS(Amount) < WHTPostingSetup."WHT Minimum Invoice Amount" THEN
                        WHTAmountLCY := 0;
        END;
    end;

    procedure CalcBankAccWHT2(GenJnlLine: Record "Gen. Journal Line"; var WHTPostingSetup: Record "WHT Posting Setup FND"; var WHTAmountLCY: Decimal; var WHTAmount: Decimal) //210..228
    var
        CheckLedgEntry: Record "Check Ledger Entry";
        GLSetup: record "General Ledger Setup";
    begin
        GLSetup.Get();
        WHTAmountLCY := 0;
        WITH GenJnlLine DO BEGIN
            IF NOT GLSetup."Enable WHT FND" OR "Skip WHT fnd" THEN
                EXIT;

            IF ("Applies-to ID" = '') AND ("Applies-to Doc. No." = '') THEN BEGIN
                IF GenJnlPostLineCBN.IsPaymentOrRefund(GenJnlLine) THEN
                    IF WHTPostingSetup.GET("WHT Business Posting Group FND", "WHT Product Posting Group FND") THEN
                        IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN
                            IF GenJnlPostLineCBN.IsCustAcc(GenJnlLine) THEN BEGIN
                                IF "WHT Absorb Base FND" <> 0 THEN
                                    WHTAmountLCY := -ABS(ROUND("WHT Absorb Base FND" * WHTPostingSetup."WHT %" / 100))
                                ELSE
                                    WHTAmountLCY := -ABS(ROUND(Amount * WHTPostingSetup."WHT %" / 100));
                                IF "Document Type" = "Document Type"::Refund THEN
                                    WHTAmountLCY := ABS(WHTAmountLCY);
                            END ELSE
                                IF GenJnlPostLineCBN.IsVendAcc(GenJnlLine) THEN BEGIN
                                    IF "WHT Absorb Base FND" <> 0 THEN
                                        WHTAmountLCY :=
                                          ABS(ROUND("WHT Absorb Base FND" * WHTPostingSetup."WHT %" / 100))
                                    ELSE
                                        WHTAmountLCY :=
                                          ABS(ROUND(Amount * WHTPostingSetup."WHT %" / 100));
                                    IF "Document Type" = "Document Type"::Refund THEN
                                        WHTAmountLCY := -ABS(WHTAmountLCY);
                                END;
                IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment) AND
                   (NOT GLSetup."Manual Sales WHT Calc. FND")
                THEN
                    WHTAmountLCY :=
                      CurrExchRate.ExchangeAmtFCYToLCY(
                        GenJnlLine1."Document Date",
                        GenJnlLine1."Currency Code",
                        ABS(
                          WHTManagement.WHTAmountJournal(GenJnlLine1, TRUE)), CurrFactor);
            END ELSE
                IF ("Applies-to ID" <> '') OR ("Applies-to Doc. No." <> '') THEN BEGIN
                    GenJnlLine1.RESET;
                    GenJnlLine1.COPY(GenJnlLine);
                    IF "Applies-to Doc. No." <> '' THEN
                        GenJnlLine1.SETRANGE("Applies-to Doc. No.", "Applies-to Doc. No.")
                    ELSE
                        GenJnlLine1.SETRANGE("Applies-to ID", "Applies-to ID");

                    GenJnlLine1.SETRANGE("Account Type", "Account Type"::Vendor);
                    IF ("Account Type" = "Account Type"::Vendor) OR ("Bal. Account Type" = "Bal. Account Type"::Vendor) OR
                       GenJnlLine1.FINDFIRST
                    THEN BEGIN
                        CurrFactor :=
                          CurrExchRate.ExchangeRate(
                            "Document Date", "Currency Code");

                        GenJnlLine1.VALIDATE(Amount, GenJnlLine1.Amount);

                        IF GenJnlPostLineCBN.IsPaymentOrRefund(GenJnlLine1) THEN
                            IF WHTPostingSetup.GET(GenJnlLine1."WHT Business Posting Group FND", GenJnlLine1."WHT Product Posting Group FND") THEN BEGIN
                                IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                                    IF GenJnlLine1.FINDFIRST THEN
                                        WHTManagement.CheckApplicationGenPurchWHT(GenJnlLine1);
                                    WHTAmountLCY :=
                                      CurrExchRate.ExchangeAmtFCYToLCY(
                                        "Document Date", "Currency Code",
                                        ABS(
                                          WHTManagement.CalcVendExtraWHTForEarliest(GenJnlLine1)), CurrFactor);
                                END;

                                IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment) AND
                                   (NOT GLSetup."Manual Sales WHT Calc. FND")
                                THEN
                                    WHTAmountLCY :=
                                      CurrExchRate.ExchangeAmtFCYToLCY(
                                        GenJnlLine1."Document Date",
                                        GenJnlLine1."Currency Code",
                                        ABS(
                                          WHTManagement.WHTAmountJournal(GenJnlLine1, TRUE)), CurrFactor);
                            END;

                        IF "Document Type" = "Document Type"::Refund THEN
                            WHTAmountLCY := -ABS(WHTAmountLCY);
                    END;

                    IF GenJnlPostLineCBN.IsCustAcc(GenJnlLine) THEN BEGIN
                        CurrFactor :=
                          CurrExchRate.ExchangeRate(
                            GenJnlLine1."Document Date", "Currency Code");
                        IF "Bal. Account Type" = "Bal. Account Type"::Customer THEN
                            GenJnlLine1.VALIDATE(Amount, -GenJnlLine1.Amount);

                        IF GenJnlPostLineCBN.IsPaymentOrRefund(GenJnlLine1) THEN
                            IF WHTPostingSetup.GET(GenJnlLine1."WHT Business Posting Group FND", GenJnlLine1."WHT Product Posting Group FND") THEN BEGIN
                                IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest) THEN BEGIN
                                    IF GenJnlLine1.FINDFIRST THEN
                                        WHTManagement.CheckApplicationGenSalesWHT(GenJnlLine1);
                                    WHTAmountLCY :=
                                      -CurrExchRate.ExchangeAmtFCYToLCY(
                                        GenJnlLine1."Document Date",
                                        GenJnlLine1."Currency Code",
                                        ABS(
                                          WHTManagement.CalcCustExtraWHTForEarliest(GenJnlLine1)), CurrFactor);
                                END;

                                IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment) AND
                                   (NOT GLSetup."Manual Sales WHT Calc. FND")
                                THEN
                                    WHTAmountLCY :=
                                      -CurrExchRate.ExchangeAmtFCYToLCY(
                                        GenJnlLine1."Document Date",
                                        GenJnlLine1."Currency Code",
                                        ABS(WHTManagement.ApplyCustCalcWHT(GenJnlLine1)), CurrFactor);
                            END;

                        IF "Document Type" = "Document Type"::Refund THEN
                            WHTAmountLCY := ABS(WHTAmountLCY);
                    END;
                    WHTAmountLCY := ROUND(WHTAmountLCY);

                    IF GLSetup."Round Amount for WHT Calc FND" THEN
                        WHTAmountLCY := ROUND(WHTAmountLCY, 1, '<');
                END ELSE
                    IF "Bank Payment Type" =
                       "Bank Payment Type"::"Computer Check"
                    THEN BEGIN
                        TESTFIELD("Check Printed", TRUE);
                        CheckLedgEntry.LOCKTABLE;
                        CheckLedgEntry.RESET;
                        CheckLedgEntry.SETCURRENTKEY("Bank Account No.", "Entry Status", "Check No.");
                        CheckLedgEntry.SETRANGE("Bank Account No.", "Account No.");
                        CheckLedgEntry.SETRANGE("Entry Status", CheckLedgEntry."Entry Status"::Printed);
                        CheckLedgEntry.SETRANGE("Check No.", "Document No.");
                        IF CheckLedgEntry.FIND('-') THEN
                            WHTAmountLCY := ABS(CheckLedgEntry."WHT Amount FND")
                    END;
        END;
    end;

    procedure IsAboveWHTMinInvoiceAmount(GenJnlLine: Record "Gen. Journal Line"): Boolean// 55|56
    var
        WHTPostingSetup: Record "WHT Posting Setup FND";
    begin
        WITH GenJnlLine DO BEGIN
            IF NOT ("Document Type" IN ["Document Type"::Invoice, "Document Type"::"Credit Memo"]) THEN
                EXIT(TRUE);

            IF WHTPostingSetup.GET("WHT Business Posting Group FND", "WHT Product Posting Group FND") THEN
                EXIT(ABS(Amount) >= WHTPostingSetup."WHT Minimum Invoice Amount");
            EXIT(FALSE);
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforePostingDeferral, '', false, false)]
    local procedure OnBeforePostingDeferral(GenJnlLine: Record "Gen. Journal Line"; VendLedgEntry: Record "Vendor Ledger Entry"; TaxAmount: Decimal; TaxAmountLCY: Decimal; NextTransactionNo: Integer; var NextTaxEntryNo: Integer; var IsHandled: Boolean);
    begin
        // WHTPostingSetup.GET(GenJnlLine."WHT Business Posting Group FND", GenJnlLine."WHT Product Posting Group FND");
        CalcVendWHT(GenJnlLine, WHTPostingSetup, WHTAmountLCY, WHTAmount);
        // PostVendWHT(GenJnlLine, VendLedgEntry, WHTPostingSetup, WHTAmountLCY, WHTAmount);//BC UPGRADE KUMARR78 --13-07-2026
        PostVendWHT(GenJnlLine, VendLedgEntry, WHTPostingSetup, WHTAmountLCY, WHTAmount, NextTransactionNo);//BC UPGRADE KUMARR78 ++13-07-2026

    end;

    procedure PostVendWHT(GenJnlLine: Record "Gen. Journal Line"; VendLedgEntry: Record "Vendor Ledger Entry"; WHTPostingSetup: Record "WHT Posting Setup FND"; WHTAmountLCY: Decimal; WHTAmount: Decimal; NextTransactionNo: Integer) //153..183//BC UPGRADE KUMARR78 ++13-07-2026
    var
        TempGenJnlTemp: Record "Gen. Journal Template";
        SourceCodeSetup: Record "Source Code Setup";
        localVLE: Record "Vendor Ledger Entry";
        GLSetup: record "General Ledger Setup";
    begin
        GLSetup.Get();
        WITH GenJnlLine DO BEGIN
            GenJnlLine1.reset();
            GenJnlLine1.copy(GenJnlLine);
            IF WHTAmountLCY <> 0 THEN
                IF (GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::Invoice) OR
                   (GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::"Credit Memo")
                THEN
                    IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice) OR
                       (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest)
                    THEN
                        GenJnlPost.CreateGLEntry(
                          GenJnlLine, WHTPostingSetup."Payable WHT Account Code", WHTAmountLCY, WHTAmountLCY, TRUE);

            SourceCodeSetup.GET;
            IF "Source Code" <> SourceCodeSetup."Financially Voided Check" THEN BEGIN
                GenJnlLine1.RESET;
                IF GLSetup."Enable WHT FND" THEN
                    // IF IsAboveWHTMinInvoiceAmount(GenJnlLine) THEN BEGIN //BC UPGRADE KUMARR78  --14-07-2026
                    IF IsAboveWHTMinInvoiceAmountNew(GenJnlLine, VendLedgEntry) THEN BEGIN//BC UPGRADE KUMARR78 ++ 14-07-2026
                        IF ("Applies-to Doc. No." <> '') OR ("Applies-to ID" <> '') THEN BEGIN
                            GenJnlLine1.COPY(GenJnlLine);

                            GenJnlLine1.VALIDATE(Amount, GenJnlLine1.Amount);
                            IF NOT "Skip WHT FND" THEN BEGIN
                                KeepWHTEntryNo := NextWHTEntryNo;
                                CASE "Document Type" OF
                                    "Document Type"::"Credit Memo":
                                        BEGIN
                                            IF ProcessSourceCode("Source Code", SourceCodeSetup) THEN
                                                IF WHTPostingSetup.GET("WHT Business Posting Group FND", "WHT Product Posting Group FND") THEN
                                                    IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice) OR
                                                       (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest)
                                                    THEN BEGIN
                                                        GenJnlLine2.RESET;
                                                        GenJnlLine2.COPY(GenJnlLine);
                                                        GenJnlLine2.Amount := -ABS(GenJnlLine2.Amount);
                                                        GenJnlLine2."WHT Absorb Base FND" := -ABS(GenJnlLine2."WHT Absorb Base FND");
                                                        NextWHTEntryNo := WHTManagement.InsertVendJournalWHT(GenJnlLine2);
                                                        IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                            WHTEntry."Transaction No." := NextTransactionNo;
                                                            WHTEntry.MODIFY;
                                                        END;
                                                    END;
                                            IF SourceCodeSetup.Purchases = "Source Code" THEN
                                                // UpdateWHTEntryTransaction("Document No.");//BC UPGRADE KUMARR78 --14-07-2026
                                            UpdateWHTEntryTransactionTemp("Document No.", NextTransactionNo);//BC UPGRADE KUMARR78 ++14-07-2026
                                        END;
                                    "Document Type"::Payment:
                                        IF WHTPostingSetup.GET("WHT Business Posting Group FND", "WHT Product Posting Group FND") THEN BEGIN
                                            IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN BEGIN
                                                NextWHTEntryNo := WHTManagement.ApplyVendInvoiceWHT(VendLedgEntry, GenJnlLine1);
                                                IF NextWHTEntryNo <> -1 THEN
                                                    HadWHTEntryNo := TRUE
                                                ELSE
                                                    NextWHTEntryNo := KeepWHTEntryNo;
                                            END;
                                            IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                                                NextWHTEntryNo := WHTManagement.InsertVendJournalWHT(GenJnlLine);
                                                IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                    WHTEntry."Transaction No." := NextTransactionNo;
                                                    WHTEntry.MODIFY;
                                                END;
                                            END;
                                        END;
                                    "Document Type"::Refund:
                                        IF GLSetup."Manual Sales WHT Calc. FND" THEN BEGIN
                                            IF "WHT Payment FND" THEN
                                                NextWHTEntryNo := WHTManagement.ProcessManualReceipt(
                                                    GenJnlLine1, VendLedgEntry."Transaction No.", VendLedgEntry."Entry No.", 0);
                                        END ELSE
                                            IF WHTPostingSetup.GET("WHT Business Posting Group FND", "WHT Product Posting Group FND") THEN BEGIN
                                                IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN BEGIN
                                                    NextWHTEntryNo := WHTManagement.ApplyVendInvoiceWHT(VendLedgEntry, GenJnlLine1);
                                                    IF NextWHTEntryNo <> -1 THEN
                                                        HadWHTEntryNo := TRUE
                                                    ELSE
                                                        NextWHTEntryNo := KeepWHTEntryNo;
                                                END;
                                                IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                                                    NextWHTEntryNo := WHTManagement.InsertVendJournalWHT(GenJnlLine);
                                                    IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                        WHTEntry."Transaction No." := NextTransactionNo;
                                                        WHTEntry.MODIFY;
                                                    END;
                                                END;
                                            END;
                                    "Document Type"::Invoice:
                                        BEGIN
                                            IF ProcessSourceCode("Source Code", SourceCodeSetup) THEN
                                                IF WHTPostingSetup.GET("WHT Business Posting Group FND", "WHT Product Posting Group FND") THEN
                                                    IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice) OR
                                                       (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest)
                                                    THEN BEGIN
                                                        GenJnlLine2.RESET;
                                                        GenJnlLine2.COPY(GenJnlLine);
                                                        GenJnlLine2.Amount := -ABS(GenJnlLine2.Amount);
                                                        GenJnlLine2."WHT Absorb Base FND" := -ABS(GenJnlLine2."WHT Absorb Base FND");
                                                        NextWHTEntryNo := WHTManagement.InsertVendJournalWHT(GenJnlLine2);
                                                        IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                            WHTEntry."Transaction No." := NextTransactionNo;
                                                            WHTEntry.MODIFY;
                                                        END;
                                                    END;
                                            IF SourceCodeSetup.Purchases = "Source Code" THEN
                                                // UpdateWHTEntryTransaction("Document No.");//BC UPGRADE KUMARR78 --14-07-2026
                                                UpdateWHTEntryTransactionTemp("Document No.", NextTransactionNo);//BC UPGRADE KUMARR78 ++14-07-2026
                                        END;
                                END;
                            END;

                            TempGenJnlTemp.SETRANGE(Type, TempGenJnlTemp.Type::Purchases);
                            IF TempGenJnlTemp.FINDFIRST THEN
                                IF "Journal Template Name" = TempGenJnlTemp.Name THEN BEGIN
                                    WHTEntry.RESET;
                                    WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::Payment);
                                    WHTEntry.SETRANGE("Document No.", "Document No.");
                                    WHTEntry.SETRANGE("Bill-to/Pay-to No.", "Account No.");
                                    IF WHTEntry.FIND('-') THEN
                                        REPEAT
                                            WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                            WHTPostingSetup.TESTFIELD("Payable WHT Account Code");
                                            GenJnlPost.CreateGLEntry(
                                              GenJnlLine, WHTPostingSetup."Payable WHT Account Code", -WHTEntry."Amount (LCY)", "Source Currency Amount", TRUE);
                                        UNTIL WHTEntry.NEXT = 0;
                                END;
                        END ELSE BEGIN
                            KeepWHTEntryNo := NextWHTEntryNo;
                            CASE "Document Type" OF
                                "Document Type"::Invoice,
                                "Document Type"::"Credit Memo":
                                    BEGIN
                                        IF ProcessSourceCode("Source Code", SourceCodeSetup) THEN BEGIN
                                            GenJnlLine2.RESET;
                                            GenJnlLine2.COPY(GenJnlLine);
                                            GenJnlLine2."WHT Absorb Base FND" := -ABS(GenJnlLine2."WHT Absorb Base FND");
                                            NextWHTEntryNo := WHTManagement.InsertVendJournalWHT(GenJnlLine2);
                                        END;
                                        // UpdateWHTEntryTransaction("Document No.");//BC UPGRADE KUMARR78 --14-07-2026
                                        UpdateWHTEntryTransactionTemp("Document No.", NextTransactionNo);//BC UPGRADE KUMARR78 ++14-07-2026
                                    END;
                                "Document Type"::Payment,
                              "Document Type"::Refund:
                                    IF WHTPostingSetup.GET("WHT Business Posting Group FND", "WHT Product Posting Group FND") THEN
                                        IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                                            NextWHTEntryNo := WHTManagement.InsertVendJournalWHT(GenJnlLine);
                                            IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                WHTEntry."Transaction No." := NextTransactionNo;
                                                WHTEntry.MODIFY;
                                            END;
                                        END;
                                "Document Type"::" ":
                                    NextWHTEntryNo := KeepWHTEntryNo;
                            END;
                        END;
                        IF NextWHTEntryNo = 0 THEN
                            NextWHTEntryNo := KeepWHTEntryNo;

                        //WHTWORK PostVendWHTTaxInv(GenJnlLine,VendLedgEntry);
                    END;

                IF "Applies-to ID" <> '' THEN BEGIN
                    VendLedgEntry.RESET;
                    VendLedgEntry.SETCURRENTKEY("Vendor No.", "Applies-to ID", Open, Positive, "Due Date");
                    VendLedgEntry.SETRANGE("Vendor No.", "Account No.");
                    VendLedgEntry.SETRANGE("Applies-to ID", "Applies-to ID");
                    VendLedgEntry.SETRANGE("Amount to Apply", 0);
                    VendLedgEntry.MODIFYALL("Applies-to ID", '');
                END;
            END;
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforeBankAccLedgEntryUpdateAmounts, '', false, false)]
    local procedure OnBeforeBankAccLedgEntryUpdateAmounts(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; BankAccount: Record "Bank Account"; TaxAmount: Decimal; TaxAmountLCY: Decimal)
    begin
        CalcBankAccWHT(GenJournalLine, WHTPostingSetup, WHTAmountLCY, WHTAmount);
    end;

    // BC Upgrade RD03 - the below event is not triggered when processing with and without WHT, but it is causing GL Inconsistency error when running Adjust Exchange Rate report. so the below event is commented -- >> 
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPostBankAccOnBeforeCreateGLEntryBalAcc, '', false, false)]
    // local procedure OnPostBankAccOnBeforeCreateGLEntryBalAcc(var GenJnlLine: Record "Gen. Journal Line"; BankAccPostingGr: Record "Bank Account Posting Group"; BankAccount: Record "Bank Account"; NextEntryNo: Integer; var IsHandled: Boolean; TaxAmount: Decimal; TaxAmountLCY: Decimal)
    // begin
    //     GenJnlPost.CreateGLEntryBalAcc(
    //           GenJnlLine, BankAccPostingGr."G/L Account No.", GenJnlLine."Amount (LCY)", GenJnlLine."Source Currency Amount",
    //           GenJnlLine."Bal. Account Type", GenJnlLine."Bal. Account No.");
    //     IsHandled := true;
    //     PostBankAccWHT(GenJnlLine, WHTPostingSetup, WHTAmountLCY);
    // end;
    // BC Upgrade RD03 - the below event is not triggered when processing with and without WHT, but it is causing GL Inconsistency error when running Adjust Exchange Rate report. so the below event is commented -- >> 

    procedure PostBankAccWHT(GenJnlLine: Record "Gen. Journal Line"; WHTPostingSetup: Record "WHT Posting Setup FND"; WHTAmountLCY: Decimal)//229..238
    begin
        IF WHTAmountLCY = 0 THEN
            EXIT;

        WITH GenJnlLine DO BEGIN
            CASE TRUE OF
                GenJnlPostLineCBN.IsVendAcc(GenJnlLine):
                    IF ((WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest) OR
                        (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment)) AND
                       (("Applies-to Doc. No." = '') AND ("Applies-to ID" = ''))
                    THEN BEGIN
                        WHTPostingSetup.TESTFIELD("Payable WHT Account Code");
                        GenJnlPost.CreateGLEntry(
                          GenJnlLine, WHTPostingSetup."Payable WHT Account Code", -WHTAmountLCY, -WHTAmountLCY, TRUE);
                    END;
                GenJnlPostLineCBN.IsCustAcc(GenJnlLine):
                    IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                        WHTPostingSetup.TESTFIELD("Prepaid WHT Account Code");
                        GenJnlPost.CreateGLEntry(
                          GenJnlLine, WHTPostingSetup."Prepaid WHT Account Code", -WHTAmountLCY, -WHTAmountLCY, TRUE);
                    END;
            END;
        END;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnApplyCustLedgEntryOnAfterCalcShouldUpdateCalcInterestFromOldBuf, '', false, false)]

    local procedure OnApplyCustLedgEntryOnAfterCalcShouldUpdateCalcInterestFromOldBuf(var OldCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; Cust: Record Customer; var ShouldUpdateCalcInterest: Boolean)
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterOldCustLedgEntryModify, '', false, false)]
    local procedure OnAfterOldCustLedgEntryModify(var CustLedgEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; var TempCustLedgerEntry: Record "Cust. Ledger Entry" temporary; var DetailedCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer")
    var
        WHTEntry1: Record "WHT Entry FND";
        RemAmtWHT: Decimal;
        ApplyingCustLedgEntry: Record "Cust. Ledger Entry";
        NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer";
        WHTEntryInserted: Boolean;
        PostedWHTEntry: Record "WHT Entry FND";
        LastWHtEntry: Record "WHT Entry FND";
        GLSetup: record "General Ledger Setup";
    begin

        NewCVLedgEntryBuf.CopyFromCustLedgEntry(TempCustLedgerEntry);
        IF CustLedgEntry."Document Type" = CustLedgEntry."Document Type"::Payment THEN BEGIN
            ApplyingCustLedgEntry.SETRANGE("Document Type", NewCVLedgEntryBuf."Document Type");
            ApplyingCustLedgEntry.SETRANGE("Document No.", NewCVLedgEntryBuf."Document No.");
            IF ApplyingCustLedgEntry.FINDFIRST THEN;
            WHTEntry1.SETRANGE("Document No.", ApplyingCustLedgEntry."Document No.");
            WHTEntry1.SETRANGE("Posting Date", ApplyingCustLedgEntry."Posting Date");
            IF WHTEntry1.FINDFIRST THEN;
        END;
        RemAmtWHT := TempCustLedgerEntry."Remaining Amount";
        // CustLedgEntry."Rem. Amt for WHT FND" := 
        GenJournalLine."WHT Payment FND" := CustLedgEntry."WHT Payment FND";
        GenJnlLine1.RESET;
        GLSetup.Get();
        IF GLSetup."Enable WHT FND" THEN
            SourceCodeSetup.GET;
        IF GenJournalLine."Source Code" = SourceCodeSetup."Sales Entry Application" THEN
            IF (GenJournalLine."Applies-to Doc. No." <> '') OR (GenJournalLine."Applies-to ID" <> '') THEN BEGIN
                GenJnlLine1.COPY(GenJournalLine);

                GenJnlLine1."WHT Entry No. FND" := NextEntryNo;
                IF NOT GenJournalLine."Skip WHT FND" THEN BEGIN
                    KeepWHTEntryNo := NextWHTEntryNo;
                    CASE GenJnlLine1."Document Type" OF
                        GenJnlLine1."Document Type"::Payment:
                            BEGIN
                                NextNo := WHTManagement.ApplyCustInvoiceWHTPosted(ApplyingCustLedgEntry, GenJnlLine1, NextTransactionNo, 0);
                                IF NextWHTEntryNo <> -1 THEN
                                    HadWHTEntryNo := TRUE
                                ELSE
                                    NextWHTEntryNo := KeepWHTEntryNo;
                                WHTEntry.SETRANGE("Original Document No.", GenJournalLine."Document No.");
                                IF WHTEntry.FIND('-') THEN
                                    WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN BEGIN
                                    REPEAT
                                        GenJnlLine1.COPY(GenJournalLine);
                                        GenJnlLine1.Amount := WHTEntry.Amount;
                                        GenJnlLine1."Amount (LCY)" := WHTEntry."Amount (LCY)";
                                        IF NOT WHTEntryInserted THEN
                                            InsertWHTPostingBufferPosted(WHTEntry, GenJnlLine1, TRUE, 0);
                                    UNTIL WHTEntry.NEXT = 0;
                                    NextWHTEntryNo := WHTEntry."Entry No." + 1;
                                END;
                            END;
                    END;
                END;
            END;

        PostedWHTEntry.RESET;
        GenJnlLine1.RESET;
        PostedWHTEntry.SETRANGE("Document Type", CustLedgEntry."Document Type");
        PostedWHTEntry.SETRANGE("Document No.", CustLedgEntry."Document No.");
        PostedWHTEntry.SETRANGE("Posting Date", CustLedgEntry."Posting Date");
        IF NOT PostedWHTEntry.FINDFIRST THEN BEGIN
            IF GLSetup."Enable WHT FND" THEN
                SourceCodeSetup.GET;
            IF GenJournalLine."Source Code" = SourceCodeSetup."Sales Entry Application" THEN
                IF (GenJournalLine."Applies-to Doc. No." <> '') OR (GenJournalLine."Applies-to ID" <> '') THEN BEGIN
                    GenJnlLine1.COPY(GenJournalLine);
                    //GenJnlLine1.VALIDATE(Amount,AppliedAmount);HEI.10
                    //HEI.10>>
                    // GenJnlLine1.Amount := AppliedAmount;
                    // GenJnlLine1."Amount (LCY)" := GetAmountLCY(GenJnlLine1);
                    //HEI.10<<
                    GenJnlLine1."WHT Entry No. FND" := NextEntryNo;
                    IF NOT GenJournalLine."Skip WHT FND" THEN BEGIN
                        KeepWHTEntryNo := NextWHTEntryNo;
                        CASE GenJnlLine1."Document Type" OF
                            GenJnlLine1."Document Type"::Invoice:
                                BEGIN
                                    NextNo := WHTManagement.ApplyCustInvoiceWHTPosted(ApplyingCustLedgEntry, GenJnlLine1, NextTransactionNo,
                                        CustLedgEntry."Transaction No.");
                                    IF NextWHTEntryNo <> -1 THEN
                                        HadWHTEntryNo := TRUE
                                    ELSE
                                        NextWHTEntryNo := KeepWHTEntryNo;
                                    GenJnlLine1.COPY(GenJournalLine);
                                    LastWHtEntry.SETRANGE("Original Document No.", GenJnlLine1."Document No.");
                                    LastWHtEntry.SETRANGE("Entry No.", NextNo);
                                    IF LastWHtEntry.FINDLAST THEN BEGIN
                                        GenJnlLine1.Amount := LastWHtEntry.Amount;
                                        GenJnlLine1."Amount (LCY)" := LastWHtEntry."Amount (LCY)";
                                        InsertWHTPostingBufferPosted(LastWHtEntry, GenJnlLine1, FALSE, 0);
                                    END;
                                    NextWHTEntryNo := LastWHtEntry."Entry No." + 1;
                                END;
                        END;
                    END;
                END;
        END;

    end;
    // end;
    procedure InsertWHTPostingBufferPosted(var WHTEntryGL: Record "WHT Entry FND"; var GenJnlLine: Record "Gen. Journal Line"; Apply: Boolean; Source: Option Sales,Purchase) //27..50
    var
        BankAcc: Record "Bank Account";
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        CheckLedgEntry: Record "Check Ledger Entry";
        CheckLedgEntry2: Record "Check Ledger Entry";
        BankAccPostingGr: Record "Bank Account Posting Group";
        PurchSetup: Record "General Ledger Setup";
        GenJnlLine3: Record "Gen. Journal Line";
        Vendor: Record Vendor;
        WHTPostingSetup: Record "WHT Posting Setup FND";
        GLEntry: Record "G/L Entry";
        GLSetup: record "General Ledger Setup";
    begin
        GLSetup.Get();
        IF WHTEntryGL."Amount (LCY)" <> 0 THEN BEGIN
            WHTPostingSetup.GET(WHTEntryGL."WHT Bus. Posting Group", WHTEntryGL."WHT Prod. Posting Group");
            PurchSetup.GET;
            GenJnlLine3.RESET;
            GenJnlLine3 := GenJnlLine;
            GenJnlLine3.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
            GenJnlLine3.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
            GenJnlLine3."Line No." := 10000;

            GenJnlLine3.INIT;
            GenJnlLine3.VALIDATE("Posting Date", GenJnlLine."Posting Date");
            GenJnlLine3."Document Type" := GenJnlLine."Document Type";
            GenJnlLine3."Account Type" := GenJnlLine3."Account Type"::"G/L Account";
            GenJnlLine3.VALIDATE("Currency Code", WHTEntryGL."Currency Code");
            IF Apply THEN
                GenJnlLine3.VALIDATE(Amount, WHTEntryGL.Amount)
            ELSE
                GenJnlLine3.VALIDATE(Amount, -WHTEntryGL.Amount);

            IF Source = Source::Purchase THEN BEGIN
                IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::Refund THEN BEGIN
                    GenJnlLine3.VALIDATE("Account No.", WHTPostingSetup."Purch. WHT Adj. Account No.");
                END ELSE
                    GenJnlLine3.VALIDATE("Account No.", WHTPostingSetup."Payable WHT Account Code");

                CASE WHTPostingSetup."Bal. Payable Account Type" OF
                    WHTPostingSetup."Bal. Payable Account Type"::"Bank Account":
                        GenJnlLine3."Bal. Account Type" := GenJnlLine3."Account Type"::"Bank Account";
                    WHTPostingSetup."Bal. Payable Account Type"::"G/L Account":
                        GenJnlLine3."Bal. Account Type" := GenJnlLine3."Account Type"::"G/L Account";
                END;
                GenJnlLine3.VALIDATE("Bal. Account No.", WHTPostingSetup."Bal. Payable Account No.");
            END;

            IF Source = Source::Sales THEN BEGIN
                IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::Refund THEN BEGIN
                    GenJnlLine3.VALIDATE("Account No.", WHTPostingSetup."Sales WHT Adj. Account No.");
                END ELSE BEGIN
                    WHTPostingSetup.TESTFIELD("Prepaid WHT Account Code");
                    GenJnlLine3.VALIDATE("Account No.", WHTPostingSetup."Prepaid WHT Account Code");
                END;

                CASE WHTPostingSetup."Bal. Prepaid Account Type" OF
                    WHTPostingSetup."Bal. Prepaid Account Type"::"Bank Account":
                        GenJnlLine3."Bal. Account Type" := GenJnlLine3."Account Type"::"Bank Account";
                    WHTPostingSetup."Bal. Prepaid Account Type"::"G/L Account":
                        GenJnlLine3."Bal. Account Type" := GenJnlLine3."Account Type"::"G/L Account";
                END;
                GenJnlLine3.VALIDATE("Bal. Account No.", WHTPostingSetup."Bal. Prepaid Account No.");
            END;
            GenJnlLine3.VALIDATE("Currency Code", WHTEntryGL."Currency Code");
            IF Apply THEN BEGIN
                GenJnlLine3.VALIDATE(Amount, WHTEntryGL.Amount);
                GenJnlLine3."Amount (LCY)" := WHTEntryGL."Amount (LCY)";
            END ELSE BEGIN
                GenJnlLine3.VALIDATE(Amount, -WHTEntryGL.Amount);
                GenJnlLine3."Amount (LCY)" := -WHTEntryGL."Amount (LCY)";
            END;
            GenJnlLine3.TESTFIELD("Bal. Account No.");
            GenJnlLine3."Source Code" := GenJnlLine."Source Code";
            GenJnlLine3."Reason Code" := GenJnlLine."Reason Code";
            GenJnlLine3."Shortcut Dimension 1 Code" := GenJnlLine."Shortcut Dimension 1 Code";
            GenJnlLine3."Shortcut Dimension 2 Code" := GenJnlLine."Shortcut Dimension 2 Code";
            GenJnlLine3."Allow Zero-Amount Posting" := TRUE;
            GenJnlLine3."WHT Business Posting Group FND" := WHTEntryGL."WHT Bus. Posting Group";
            GenJnlLine3."WHT Product Posting Group FND" := WHTEntryGL."WHT Prod. Posting Group";
            GenJnlLine3."Document Type" := GenJnlLine."Document Type";
            GenJnlLine3."Document No." := GenJnlLine."Document No.";
            GenJnlLine3."External Document No." := GenJnlLine."External Document No.";
            IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::Refund THEN
                GenJnlLine3."Gen. Posting Type" := GenJnlLine3."Gen. Posting Type"::" ";

            IF NextEntryNo = 0 THEN
                NextEntryNo := GenJnlLine."WHT Entry No. FND";
            IF Apply THEN BEGIN
                IF Source = Source::Purchase THEN BEGIN
                    IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::Refund THEN
                        GenJnlPost.InitGLEntry(
                          GenJnlLine, GLEntry, WHTPostingSetup."Purch. WHT Adj. Account No.", -WHTEntryGL."Amount (LCY)", 0, FALSE, TRUE)
                    ELSE
                        GenJnlPost.InitGLEntry(
                          GenJnlLine, GLEntry, WHTPostingSetup."Payable WHT Account Code", -WHTEntryGL."Amount (LCY)", 0, FALSE, TRUE);
                END;

                IF Source = Source::Sales THEN
                    IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::Refund THEN
                        GenJnlPost.InitGLEntry(
                          GenJnlLine, GLEntry, WHTPostingSetup."Sales WHT Adj. Account No.", -WHTEntryGL."Amount (LCY)", 0, FALSE, TRUE)
                    ELSE BEGIN
                        WHTPostingSetup.TESTFIELD("Prepaid WHT Account Code");
                        GenJnlPost.InitGLEntry(
                          GenJnlLine, GLEntry, WHTPostingSetup."Prepaid WHT Account Code", -WHTEntryGL."Amount (LCY)", 0, FALSE, TRUE);
                    END;
                GLEntry."Posting Date" := GenJnlLine3."Posting Date";
                GLEntry."Additional-Currency Amount" := -WHTEntryGL.Amount;
            END ELSE BEGIN
                IF Source = Source::Purchase THEN BEGIN
                    IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::Refund THEN
                        GenJnlPost.InitGLEntry(
                          GenJnlLine, GLEntry, WHTPostingSetup."Purch. WHT Adj. Account No.", WHTEntryGL."Amount (LCY)", 0, FALSE, TRUE)
                    ELSE
                        GenJnlPost.InitGLEntry(
                          GenJnlLine, GLEntry, WHTPostingSetup."Payable WHT Account Code", WHTEntryGL."Amount (LCY)", 0, FALSE, TRUE);
                END;
                IF Source = Source::Sales THEN
                    IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::Refund THEN
                        GenJnlPost.InitGLEntry(
                          GenJnlLine, GLEntry, WHTPostingSetup."Sales WHT Adj. Account No.", WHTEntryGL."Amount (LCY)", 0, FALSE, TRUE)
                    ELSE BEGIN
                        WHTPostingSetup.TESTFIELD("Prepaid WHT Account Code");
                        GenJnlPost.InitGLEntry(
                          GenJnlLine, GLEntry, WHTPostingSetup."Prepaid WHT Account Code", WHTEntryGL."Amount (LCY)", 0, FALSE, TRUE);
                    END;
                GLEntry."Posting Date" := GenJnlLine3."Posting Date";
                GLEntry."Additional-Currency Amount" := WHTEntryGL.Amount;
            END;

            GLEntry."Gen. Posting Type" := GenJnlLine."Gen. Posting Type";
            GLEntry."Gen. Bus. Posting Group" := GenJnlLine."Gen. Bus. Posting Group";
            GLEntry."Gen. Prod. Posting Group" := GenJnlLine."Gen. Prod. Posting Group";
            GLEntry."VAT Bus. Posting Group" := GenJnlLine."VAT Bus. Posting Group";
            GLEntry."VAT Prod. Posting Group" := GenJnlLine."VAT Prod. Posting Group";
            GenJnlPost.InsertGLEntry(GenJnlLine, GLEntry, TRUE);

            CASE GenJnlLine3."Bal. Account Type" OF
                GenJnlLine3."Bal. Account Type"::"Bank Account":
                    WITH GenJnlLine3 DO BEGIN
                        BankAccLedgEntry.LOCKTABLE;
                        IF BankAcc."No." <> "Bal. Account No." THEN
                            BankAcc.GET("Bal. Account No.");
                        BankAcc.TESTFIELD(Blocked, FALSE);
                        IF "Currency Code" = '' THEN
                            BankAcc.TESTFIELD("Currency Code", '')
                        ELSE
                            IF BankAcc."Currency Code" <> '' THEN
                                TESTFIELD("Currency Code", BankAcc."Currency Code");

                        BankAcc.TESTFIELD("Bank Acc. Posting Group");
                        BankAccPostingGr.GET(BankAcc."Bank Acc. Posting Group");

                        BankAccLedgEntry.INIT;
                        BankAccLedgEntry."Bank Account No." := "Bal. Account No.";
                        BankAccLedgEntry."Posting Date" := "Posting Date";
                        BankAccLedgEntry."Document Date" := "Document Date";
                        BankAccLedgEntry."Document Type" := "Document Type";
                        BankAccLedgEntry."Document No." := "Document No.";
                        BankAccLedgEntry."External Document No." := "External Document No.";
                        BankAccLedgEntry.Description := Description;
                        BankAccLedgEntry."Bank Acc. Posting Group" := BankAcc."Bank Acc. Posting Group";
                        BankAccLedgEntry."Global Dimension 1 Code" := "Shortcut Dimension 1 Code";
                        BankAccLedgEntry."Global Dimension 2 Code" := "Shortcut Dimension 2 Code";
                        BankAccLedgEntry."Dimension Set ID" := "Dimension Set ID";
                        BankAccLedgEntry."Our Contact Code" := "Salespers./Purch. Code";
                        BankAccLedgEntry."Source Code" := "Source Code";
                        BankAccLedgEntry."Journal Batch Name" := "Journal Batch Name";
                        BankAccLedgEntry."Reason Code" := "Reason Code";
                        BankAccLedgEntry."Entry No." := NextEntryNo;
                        BankAccLedgEntry."Transaction No." := NextTransactionNo;
                        BankAccLedgEntry."Currency Code" := BankAcc."Currency Code";
                        IF BankAcc."Currency Code" <> '' THEN
                            BankAccLedgEntry.Amount := Amount
                        ELSE
                            BankAccLedgEntry.Amount := "Amount (LCY)";
                        BankAccLedgEntry."Amount (LCY)" := "Amount (LCY)";
                        BankAccLedgEntry."User ID" := USERID;
                        IF BankAccLedgEntry.Amount <> 0 THEN BEGIN
                            BankAccLedgEntry.Open := TRUE;
                            BankAccLedgEntry."Remaining Amount" := BankAccLedgEntry.Amount;
                        END;
                        BankAccLedgEntry.Positive := BankAccLedgEntry.Amount > 0;
                        BankAccLedgEntry."Bal. Account Type" := "Bal. Account Type";
                        BankAccLedgEntry."Bal. Account No." := "Bal. Account No.";
                        IF (Amount > 0) AND (NOT Correction) OR
                           ("Amount (LCY)" > 0) AND (NOT Correction) OR
                           (Amount < 0) AND Correction OR
                           ("Amount (LCY)" < 0) AND Correction
                        THEN BEGIN
                            BankAccLedgEntry."Debit Amount" := BankAccLedgEntry.Amount;
                            BankAccLedgEntry."Credit Amount" := 0;
                            BankAccLedgEntry."Debit Amount (LCY)" := BankAccLedgEntry."Amount (LCY)";
                            BankAccLedgEntry."Credit Amount (LCY)" := 0;
                        END ELSE BEGIN
                            BankAccLedgEntry."Debit Amount" := 0;
                            BankAccLedgEntry."Credit Amount" := -BankAccLedgEntry.Amount;
                            BankAccLedgEntry."Debit Amount (LCY)" := 0;
                            BankAccLedgEntry."Credit Amount (LCY)" := -BankAccLedgEntry."Amount (LCY)";
                        END;
                        BankAccLedgEntry.INSERT;

                        //
                        //HEI.07>>
                        SourceCodeSetup.GET;
                        //IF "Source Code" <> SourceCodeSetup."Payment Journal Tree" THEN BEGIN //HEI.07<<
                        IF "Source Code" = SourceCodeSetup."Payment Journal Tree FND" THEN BEGIN //>>HEI.20
                            IF ((Amount <= 0) AND ("Bank Payment Type" = "Bank Payment Type"::"Computer Check") AND "Check Printed") OR
                               ((Amount < 0) AND ("Bank Payment Type" = "Bank Payment Type"::"Manual Check"))
                            THEN BEGIN
                                IF BankAcc."Currency Code" <> "Currency Code" THEN
                                    ERROR(BankPaymentTypeMustNotBeFilledErr);
                                CASE "Bank Payment Type" OF
                                    "Bank Payment Type"::"Computer Check":
                                        BEGIN
                                            TESTFIELD("Check Printed", TRUE);
                                            CheckLedgEntry.LOCKTABLE;
                                            CheckLedgEntry.RESET;
                                            CheckLedgEntry.SETCURRENTKEY("Bank Account No.", "Entry Status", "Check No.");
                                            //>>HEI.20
                                            //CheckLedgEntry.SETRANGE("Bank Account No.","Account No.");
                                            IF GenJnlLine.Amount <= 0 THEN
                                                IF GenJnlLine."HNK Bank Account FND" = '' THEN
                                                    CheckLedgEntry.SETRANGE("Bank Account No.", GenJnlLine."Account No.")
                                                ELSE
                                                    CheckLedgEntry.SETRANGE("Bank Account No.", GenJnlLine."HNK Bank Account FND")
                                            ELSE
                                                IF GenJnlLine."HNK Bank Account FND" = '' THEN
                                                    CheckLedgEntry.SETRANGE("Bank Account No.", GenJnlLine."Bal. Account No.")
                                                ELSE
                                                    CheckLedgEntry.SETRANGE("Bank Account No.", GenJnlLine."HNK Bank Account FND");
                                            CheckLedgEntry.SETRANGE("Entry Status", CheckLedgEntry."Entry Status"::Printed);
                                            //CheckLedgEntry.SETRANGE("Check No.","Document No.");
                                            IF GenJnlLine."HNK Bank Account FND" = '' THEN
                                                CheckLedgEntry.SETRANGE("Check No.", GenJnlLine."Document No.")
                                            ELSE
                                                CheckLedgEntry.SETRANGE("Check No.", GenJnlLine."HNK Check No. FND");
                                            //<<HEI.20
                                            IF CheckLedgEntry.FIND('-') THEN
                                                REPEAT
                                                    CheckLedgEntry2 := CheckLedgEntry;
                                                    CheckLedgEntry2."Entry Status" := CheckLedgEntry2."Entry Status"::Posted;
                                                    CheckLedgEntry2."Bank Account Ledger Entry No." := BankAccLedgEntry."Entry No.";
                                                    CheckLedgEntry2.MODIFY;
                                                UNTIL CheckLedgEntry.NEXT = 0;
                                        END;
                                    "Bank Payment Type"::"Manual Check":
                                        BEGIN
                                            IF "Document No." = '' THEN
                                                ERROR(DocNoMustBeEnteredErr, "Bank Payment Type");
                                            CheckLedgEntry.RESET;
                                            IF NextCheckEntryNo = 0 THEN BEGIN
                                                CheckLedgEntry.LOCKTABLE;
                                                IF CheckLedgEntry.FIND('+') THEN
                                                    NextCheckEntryNo := CheckLedgEntry."Entry No." + 1
                                                ELSE
                                                    NextCheckEntryNo := 1;
                                            END;

                                            CheckLedgEntry.SETCURRENTKEY("Bank Account No.", "Entry Status", "Check No.");
                                            CheckLedgEntry.SETRANGE("Bank Account No.", "Account No.");
                                            CheckLedgEntry.SETFILTER(
                                              "Entry Status", '%1|%2|%3',
                                              CheckLedgEntry."Entry Status"::Printed,
                                              CheckLedgEntry."Entry Status"::Posted,
                                              CheckLedgEntry."Entry Status"::"Financially Voided");
                                            CheckLedgEntry.SETRANGE("Check No.", "Document No.");
                                            IF CheckLedgEntry.FIND('-') THEN
                                                ERROR(CheckAlreadyExistsErr, "Document No.");

                                            CheckLedgEntry.INIT;
                                            CheckLedgEntry."Entry No." := NextCheckEntryNo;
                                            CheckLedgEntry."Bank Account No." := BankAccLedgEntry."Bank Account No.";
                                            CheckLedgEntry."Bank Account Ledger Entry No." := BankAccLedgEntry."Entry No.";
                                            CheckLedgEntry."Posting Date" := BankAccLedgEntry."Posting Date";
                                            CheckLedgEntry."Document Type" := BankAccLedgEntry."Document Type";
                                            CheckLedgEntry."Document No." := BankAccLedgEntry."Document No.";
                                            CheckLedgEntry."External Document No." := BankAccLedgEntry."External Document No.";
                                            CheckLedgEntry.Description := BankAccLedgEntry.Description;
                                            CheckLedgEntry."Bank Payment Type" := "Bank Payment Type";
                                            CheckLedgEntry."Bal. Account Type" := BankAccLedgEntry."Bal. Account Type";
                                            CheckLedgEntry."Bal. Account No." := BankAccLedgEntry."Bal. Account No.";
                                            CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::Posted;
                                            CheckLedgEntry.Open := TRUE;
                                            CheckLedgEntry."User ID" := USERID;
                                            CheckLedgEntry."Check Date" := BankAccLedgEntry."Posting Date";
                                            CheckLedgEntry."Check No." := BankAccLedgEntry."Document No.";

                                            GenJnlLine1.RESET;
                                            GenJnlLine1.COPY(GenJnlLine);
                                            IF GLSetup."Enable WHT FND" THEN
                                                IF NOT GenJnlLine."Skip WHT FND" THEN
                                                    CheckLedgEntry."WHT Amount FND" := -WHTManagement.WHTAmountJournal(GenJnlLine1, FALSE);

                                            IF BankAcc."Currency Code" <> '' THEN
                                                CheckLedgEntry.Amount := -Amount - CheckLedgEntry."WHT Amount FND"
                                            ELSE
                                                CheckLedgEntry.Amount := -"Amount (LCY)" - CheckLedgEntry."WHT Amount FND";
                                            CheckLedgEntry.INSERT;
                                            NextCheckEntryNo := NextCheckEntryNo + 1;
                                        END;
                                END;
                            END;
                        END ELSE //HEI.07
                                 //HEI.07>>
                            IF "Bank Payment Type" = "Bank Payment Type"::"Computer Check" THEN
                                TESTFIELD("Check Printed", TRUE);
                        //HEI.07<<


                        BankAccPostingGr.TESTFIELD("G/L Account No.");
                        GenJnlPost.InitGLEntry(GenJnlLine, GLEntry,
                          BankAccPostingGr."G/L Account No.", "Amount (LCY)", "Source Currency Amount", TRUE, TRUE);
                    END;
                GenJnlLine3."Bal. Account Type"::"G/L Account":
                    GenJnlPost.InitGLEntry(GenJnlLine, GLEntry,
                      GenJnlLine3."Bal. Account No.", GenJnlLine3."Amount (LCY)", GenJnlLine3."Source Currency Amount", TRUE, TRUE);
            END;
            GLEntry."Posting Date" := GenJnlLine3."Posting Date";
            GLEntry."Bal. Account Type" := GenJnlLine3."Bal. Account Type";
            GLEntry."Bal. Account No." := GenJnlLine3."Bal. Account No.";
            GenJnlPost.InsertGLEntry(GenJnlLine, GLEntry, TRUE);
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforeCopyFromCVLedgEntryBuffer, '', false, false)] // 24
    local procedure OnBeforeCopyFromCVLedgEntryBuffer(var GenJnlLine: Record "Gen. Journal Line"; OldVendLedgEntry: Record "Vendor Ledger Entry"; TempOldVendLedgEntry: Record "Vendor Ledger Entry" temporary; var OldCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; AppliedAmount: Decimal; var RemainingTaxAmount: Decimal; NextTransactionNo: Integer; var NextTaxEntryNo: Integer)
    var
        GLSetup: record "General Ledger Setup";
    begin
        GLSetup.Get();
        IF GLSetup."Enable WHT FND" AND
   (GenJnlLine."Document Type" IN [GenJnlLine."Document Type"::Payment, GenJnlLine."Document Type"::Refund])
THEN
            IF (GenJnlLine."Applies-to Doc. No." = '') AND (GenJnlLine."Applies-to ID" = '') THEN BEGIN
                GenJnlLine1.RESET;
                GenJnlLine1.COPY(GenJnlLine);
                GenJnlLine1.VALIDATE(Amount, AppliedAmount);
                GenJnlLine1."Applies-to Doc. Type" := OldVendLedgEntry."Document Type";
                GenJnlLine1."Applies-to Doc. No." := OldVendLedgEntry."Document No.";
                NextWHTEntryNo := WHTManagement.ProcessPayment(GenJnlLine1, NextTransactionNo,
                    OldVendLedgEntry."Entry No.", 0, TRUE);
            END;
        RemAmtWHT := TempOldVendLedgEntry."Remaining Amount"
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforeUpdateOldVendLedgEntryAmountToApply, '', false, false)] // 24
    local procedure OnBeforeUpdateOldVendLedgEntryAmountToApply(GenJnlLine: Record "Gen. Journal Line"; var OldVendLedgEntry: Record "Vendor Ledger Entry"; OldCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; RemainingTaxAmount: Decimal; AppliedAmount: Decimal; var IsHandled: Boolean)
    begin
        OldVendLedgEntry."Rem. Amt for WHT FND" := -AppliedAmount;
        OldVendLedgEntry."Rem. Amt FND" := RemAmtWHT;
        OldVendLedgEntry."Amount to Apply" := 0;
        IsHandled := true;
        // if OldVendLedgEntry."Amount to Apply" = 0 then
        //     OldVendLedgEntry."Applies-to ID" := '' else begin
        //     TempVendorLedgerEntry := OldVendLedgEntry;
        //     if TempVendorLedgerEntry.Insert() then;
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterOldVendLedgEntryModify, '', false, false)] // 24
    local procedure OnAfterOldVendLedgEntryModify(var VendLedgEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; var TempVendorLedgerEntry: Record "Vendor Ledger Entry" temporary; var DetailedCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; AppliedAmount: Decimal; var NextTaxEntryNo: Integer; var NextEntryNo: Integer; var NextCheckEntryNo: Integer; NextTransactionNo: Integer)
    var
        PostedWHTEntry: Record "WHT Entry FND";
        GLSetup: record "General Ledger Setup";
    begin
        GenJnlLine1.RESET;
        SourceCodeSetup.GET;
        GLSetup.Get();
        IF GLSetup."Enable WHT FND" THEN
            IF GenJournalLine."Source Code" = SourceCodeSetup."Purchase Entry Application" THEN
                IF (GenJournalLine."Applies-to Doc. No." <> '') OR (GenJournalLine."Applies-to ID" <> '') THEN BEGIN
                    GenJnlLine1.COPY(GenJournalLine);
                    //GenJnlLine1.VALIDATE(Amount,AppliedAmount);HEI.10
                    //HEI.10>>
                    GenJnlLine1.Amount := AppliedAmount;
                    GenJnlLine1."Amount (LCY)" := GetAmountLCY(GenJnlLine1);
                    //HEI.10<<
                    GenJnlLine1."WHT Entry No. FND" := NextEntryNo;
                    IF NOT GenJournalLine."Skip WHT FND" THEN BEGIN
                        KeepWHTEntryNo := NextWHTEntryNo;
                        CASE GenJnlLine1."Document Type" OF
                            GenJnlLine1."Document Type"::Payment:
                                BEGIN
                                    NextNo := WHTManagement.ApplyVendInvoiceWHTPosted(VendLedgEntry, GenJnlLine1, NextTransactionNo);
                                    IF NextWHTEntryNo <> -1 THEN
                                        HadWHTEntryNo := TRUE
                                    ELSE
                                        NextWHTEntryNo := KeepWHTEntryNo;
                                    WHTEntry.SETRANGE("Original Document No.", GenJournalLine."Document No.");
                                    IF WHTEntry.FIND('-') THEN
                                        IF WHTPostingSetup.GET(
                                             WHTEntry."WHT Bus. Posting Group",
                                             WHTEntry."WHT Prod. Posting Group")
                                        THEN
                                            IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN BEGIN
                                                REPEAT
                                                    GenJnlLine1.COPY(GenJournalLine);
                                                    GenJnlLine1.Amount := WHTEntry.Amount;
                                                    GenJnlLine1."Amount (LCY)" := WHTEntry."Amount (LCY)";
                                                    InsertWHTPostingBufferPosted(WHTEntry, GenJnlLine1, TRUE, 1);
                                                UNTIL WHTEntry.NEXT = 0;
                                                NextWHTEntryNo := WHTEntry."Entry No." + 1;
                                            END;
                                END;
                        END;
                    END;
                END;
    end;

    local procedure GetAmountLCY(GenJournalLine: Record "Gen. Journal Line"): Decimal
    begin
        //HEI.10>>
        //GetCurrency;
        IF GenJournalLine."Currency Code" = '' THEN
            EXIT(GenJournalLine.Amount)
        ELSE
            EXIT(ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  GenJournalLine."Posting Date", GenJournalLine."Currency Code",
                  GenJournalLine.Amount, GenJournalLine."Currency Factor")));
        //HEI.10<<

    end;

    procedure IncreaseWHTEntryNo()
    begin
        NextWHTEntryNo := NextWHTEntryNo + 1;
    end;

    var
        RemAmtWHT: Decimal;
        NextTransactionNo: Integer;
        NextWHTEntryNo: Integer;
        WHTEntry: Record "WHT Entry FND";
        GenJnlLine2: Record "Gen. Journal Line";
        WHTManagement: Codeunit "WHTManagement";
        GenJnlPostLineCBN: Codeunit "Gen Jnl Post Line CU CBN";
        Text50001: Label 'Type should be G/L Account for WHT Bearer as "OpCo"!';
        // GLSetup: record "General Ledger Setup";
        CurrFactor: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        SourceCodeSetup: Record "Source Code Setup";
        // GenJnlLine: Record "Gen. Journal Line";
        GenJnlLine1: record "Gen. Journal Line";
        PurchInvHeader: record "Purch. Inv. Header";
        CD90: Codeunit 90;
        WHTPostingSetup: Record "WHT Posting Setup FND";
        WHTAmountLCY: Decimal;
        WHTAmount: Decimal;
        lWHTPostingSetup: Record "WHT Posting Setup FND";
        GenJnlPost: Codeunit "Gen. Jnl.-Post Line";
        KeepWHTEntryNo: Integer;
        HadWHTEntryNo: Boolean;
        NextEntryNo: Integer;
        Text016: Label 'Cannot post the payment journal because one or more journal lines must be applied to an invoice line when the WHT Realized Type %1';
        BankPaymentTypeMustNotBeFilledErr: Label 'Bank Payment Type must not be filled if Currency Code is different in Gen. Journal Line and Bank Account.';
        NextCheckEntryNo: Integer;
        CheckAlreadyExistsErr: Label 'Check %1 already exists for this Bank Account.';
        DocNoMustBeEnteredErr: Label 'Document No. must be entered when Bank Payment Type is %1.';
        NextNo: Integer;
        gWHTPostingSetup: Record "WHT Posting Setup FND";
    // BC Upgrade BHARDA11 >> -- Custom Code

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterInitGLEntry, '', false, false)]

    local procedure OnAfterInitGLEntry(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line"; Amount: Decimal; AddCurrAmount: Decimal; UseAddCurrAmount: Boolean; var CurrencyFactor: Decimal; var GLRegister: Record "G/L Register")
    var
        GenLedEnt, GLENtryTrans : Record "G/L Entry";
        LastEntryNo, LastTransactionNo : integer;
    begin
        // GLEntry.LockTable();
        // GLEntry.GetLastEntry(LastEntryNo, LastTransactionNo);
        // NextEntryNo := LastEntryNo + 1;
        // NextTransactionNo := LastTransactionNo + 1;

        // if GLEntry."Entry No." = 0 then
        //     GLEntry."Entry No." := NextEntryNo;
        // if GLEntry."Transaction No." = 0 then
        //     GLEntry."Transaction No." := NextTransactionNo;
    end;
    // BC Upgrade BHARDA11 << -- Custom Code
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", OnBeforeGenJnlPostBatchRun, '', false, false)]
    local procedure OnBeforeGenJnlPostBatchRun(var GenJnlLine: Record "Gen. Journal Line"; var IsHandled: Boolean; var GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch")
    begin
        // GenJnlPostBatch.SetSuppressCommit(true);
    end;

    // [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnAfterInsertEvent, '', false, false)]
    // local procedure On(var Rec: Record "Gen. Journal Line")
    // begin
    //     // Message('%1', Rec.RecordId);
    // end;

    // [EventSubscriber(ObjectType::Table, Database::"G/L Entry", OnAfterValidateEvent, "Transaction No.", false, false)]
    // local procedure TransactionNoVal(var Rec: Record "G/L Entry"; var xRec: Record "G/L Entry")
    // begin
    //     // Message('%1', Rec."Transaction No.");
    // end;

    // [EventSubscriber(ObjectType::Table, Database::"G/L Entry", OnBeforeInsertEvent, '', false, false)]
    // local procedure MyProcedure(var rec: Record "G/L Entry")
    // begin
    //     // Message('%1', rec."Entry No.");
    // end;

    //RD03 -- >>
    // [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", OnBeforeInsertGlEntry, '', false, false)]
    // local procedure OnBeforeInsertGlEntry(var GenJnlLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var IsHandled: Boolean)
    // var
    //     GenLedEnt, GLENtryTrans : Record "G/L Entry";
    //     LastEntryNo, LastTransactionNo : integer;
    //     GL_ENtry: Record "G/L Entry";
    // begin
    //     GLEntry.LockTable();
    //     GLEntry.GetLastEntry(LastEntryNo, LastTransactionNo);
    //     NextEntryNo := LastEntryNo + 1;
    //     NextTransactionNo := LastTransactionNo + 1;

    //     if GLEntry."Entry No." = 0 then
    //         GLEntry."Entry No." := NextEntryNo;
    //     // if (GLEntry."Transaction No." = 0) AND (GenJnlLine."IS WHT Line FND" = true) then begin
    //     if (GLEntry."Transaction No." = 0) AND (GLEntry."Document No." <> '') then begin
    //         GL_ENtry.Reset();
    //         GL_ENtry.SetRange("Document No.", GLEntry."Document No.");
    //         if GL_ENtry.FindFirst() then begin
    //             if GL_ENtry."Transaction No." <> 0 then
    //                 GLEntry."Transaction No." := GL_ENtry."Transaction No.";
    //         end
    //         else
    //             // Error('Not Found');
    //         GLEntry."Transaction No." := NextTransactionNo;
    //     end;
    // end;
    //RD03 -- >>

    //BC UPGRADE KUMARR78 ++13-07-2026
    procedure UpdateWHTEntryTransactionTemp(DocNo: Code[20]; NextTransactionNo: Integer)
    var
        WHTEntry: Record "WHT Entry FND";
        WHTPostingSetup: Record "WHT Posting Setup FND";
    //cc: Codeunit "Purch.-Post";
    Begin
        WHTEntry.RESET;
        WHTEntry.SETCURRENTKEY("Document No.", "Posting Date");
        WHTEntry.SETRANGE("Document No.", DocNo);
        IF WHTEntry.FINDSET(TRUE, FALSE) THEN
            REPEAT
                WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice) OR
                   (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest)
                THEN BEGIN
                    WHTEntry."Transaction No." := NextTransactionNo;
                    WHTEntry.MODIFY;
                END;
            UNTIL WHTEntry.NEXT = 0;
    End;


    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", OnAfterCopyVendLedgerEntryFromGenJnlLine, '', false, false)]
    local procedure CopyFromGenJnlLineVLE2(GenJournalLine: Record "Gen. Journal Line"; var VendorLedgerEntry: Record "Vendor Ledger Entry")
    var
        PurInvHeader: Record "Purch. Inv. Header";
        PurInvLine: Record "Purch. Inv. Line";
        PurchCrHeader: Record "Purch. Cr. Memo Hdr.";
        VendorBankAccount: Record "Vendor Bank Account";
    begin

        if PurInvHeader.Get(VendorLedgerEntry."Document No.") then begin
            PurInvLine.SetRange("Document No.", PurInvHeader."No.");
            PurInvLine.SetFilter("WHT Business Posting Group FND", '<>%1', '');

            if PurInvLine.FindFirst() then begin
                VendorLedgerEntry."WHT Business Posting Grp FND" := PurInvLine."WHT Business Posting Group FND";
                VendorLedgerEntry."WHT Product Posting Grp FND" := PurInvLine."WHT Product Posting Group FND";
            end;
        end;
    end;

    procedure IsAboveWHTMinInvoiceAmountNew(GenJnlLine: Record "Gen. Journal Line"; VenderLedgerentry: Record "Vendor Ledger Entry"): Boolean// 55|56
    var
        WHTPostingSetup: Record "WHT Posting Setup FND";
    begin
        WITH GenJnlLine DO BEGIN
            IF NOT ("Document Type" IN ["Document Type"::Invoice, "Document Type"::"Credit Memo"]) THEN
                EXIT(TRUE);

            IF WHTPostingSetup.GET(VenderLedgerentry."WHT Business Posting Grp FND", VenderLedgerentry."WHT Product Posting Grp FND") THEN
                EXIT(ABS(Amount) >= WHTPostingSetup."WHT Minimum Invoice Amount");
            EXIT(FALSE);
        END;
    end;
    //BC UPGRADE KUMARR78 WHT Related
}
