codeunit 50285 "WHT Gen. Jnl.-Apply FND"
{
    Permissions = tabledata "G/L Register" = rimd,
    tabledata "Vendor Ledger Entry" = RIMD,
    tabledata "Purchase Header" = rimd;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Apply", OnAfterUpdateVendLedgEntry, '', false, false)]
    local procedure OnAfterUpdateVendLedgEntry(var GenJournalLine: Record "Gen. Journal Line"; var VendorLedgerEntry: Record "Vendor Ledger Entry")
    var
        GenLedgerSetup: Record "General Ledger Setup";
        TempWHTEntry: Record "WHT Entry FND" temporary;
        PaymentToleranceMgt: Codeunit 426;
    begin
        //HEI.01>>
        GenLedgerSetup.GET();
        IF GenLedgerSetup."Enable WHT FND" AND (NOT GenJournalLine."Skip WHT FND") THEN BEGIN
            TempWHTEntry.INIT();
            TempWHTEntry."Entry No." := VendorLedgerEntry."Entry No.";
            TempWHTEntry."Document Type" := VendorLedgerEntry."Document Type";
            TempWHTEntry."Document No." := VendorLedgerEntry."Document No.";
            TempWHTEntry."Applies-to Doc. No." := VendorLedgerEntry."Applies-to ID";
            TempWHTEntry."Posting Date" := GenJournalLine."Posting Date";
            WHTEntry.RESET();
            WHTEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type");
            WHTEntry.SETRANGE("Document No.", VendorLedgerEntry."Document No.");
            IF WHTEntry.FINDFIRST() THEN BEGIN
                TempWHTEntry."WHT Bus. Posting Group" := WHTEntry."WHT Bus. Posting Group";
                TempWHTEntry."WHT Prod. Posting Group" := WHTEntry."WHT Prod. Posting Group";
            END;
            TempWHTEntry.INSERT();

        END;
        //HEI.01<<
        //HEI.01>>
        IF GenLedgerSetup."Enable WHT FND" AND (NOT GenJournalLine."Skip WHT FND") THEN BEGIN
            IF PaymentToleranceMgt.CheckCalcPmtDiscGenJnlVend(GenJournalLine, VendorLedgerEntry, 0, FALSE) AND
             (ABS(VendorLedgerEntry."Amount to Apply") >=
              ABS(VendorLedgerEntry."Remaining Amount" - VendorLedgerEntry."Remaining Pmt. Disc. Possible")) THEN
                TempWHTEntry.Amount := -(VendorLedgerEntry."Amount to Apply" - VendorLedgerEntry."Remaining Pmt. Disc. Possible")
            ELSE
                TempWHTEntry.Amount := -VendorLedgerEntry."Amount to Apply";
            TempWHTEntry.MODIFY;
        END;
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Apply", OnApplyVendorLedgerEntryOnBeforeCheckAgainstApplnCurrencyAmountNotZero, '', false, false)]

    local procedure OnApplyVendorLedgerEntryOnBeforeCheckAgainstApplnCurrencyAmountNotZero(GenJournalLine: Record "Gen. Journal Line"; VendorLedgerEntry: Record "Vendor Ledger Entry")
    var
        GenLedgerSetup: Record "General Ledger Setup";
        TempWHTEntry: Record "WHT Entry FND" temporary;
        PaymentToleranceMgt: Codeunit 426;
    begin
        GenLedgerSetup.GET;
        IF GenLedgerSetup."Enable WHT FND" AND (NOT GenJournalLine."Skip WHT FND") THEN BEGIN
            TempWHTEntry.INIT;
            TempWHTEntry."Entry No." := VendorLedgerEntry."Entry No.";
            TempWHTEntry."Document Type" := VendorLedgerEntry."Document Type";
            TempWHTEntry."Document No." := VendorLedgerEntry."Document No.";
            TempWHTEntry."Applies-to Doc. No." := VendorLedgerEntry."Applies-to ID";
            TempWHTEntry."Posting Date" := GenJournalLine."Posting Date";
            WHTEntry.RESET;
            WHTEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type");
            WHTEntry.SETRANGE("Document No.", VendorLedgerEntry."Document No.");
            IF WHTEntry.FINDFIRST THEN BEGIN
                TempWHTEntry."WHT Bus. Posting Group" := WHTEntry."WHT Bus. Posting Group";
                TempWHTEntry."WHT Prod. Posting Group" := WHTEntry."WHT Prod. Posting Group";
            END;
            TempWHTEntry.INSERT;
        END;
        //HEI.01<<
    end;

    var
        GenJNLAPply: Codeunit "Gen. Jnl.-Apply";
        PurchLine: Record "Purchase Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        PurchInvHeader: Record "Purch. Inv. Header";
        WHTEntry: Record "WHT Entry FND";
        WHTEntryPrePmt: Record "WHT Entry FND";
        WHTManagement: Codeunit WHTManagement;
        TotalWHTAmtToBeDeducted: Decimal;
        PurchInvHeaderPrePmt: Record "Purch. Inv. Header";
        GenJnlLineDocType: Integer;
        GenJnlLineDocNo: Code[20];
        GenJnlLineExtDocNo: Code[35];
        SrcCode: Code[10];
        TotalPurchLineLCY: Record "Purchase Line";
        NextWHTEntryNo: Integer;
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";

        TotalSalesLineLCY: Record "Sales Line";
        TotalWHTAmount: Decimal;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostInvoiceOnAfterPostLines', '', false, false)]
    // local procedure OnPostInvoiceOnAfterPostLines(var PurchaseHeader: Record "Purchase Header"; SrcCode: Code[10]; GenJnlLineDocType: Enum "Gen. Journal Document Type"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; var TempPurchLineGlobal: Record "Purchase Line" temporary; TotalAmount: Decimal)
    // var
    //     TempInvoicePostBuffer: Record "Invoice Posting Buffer" temporary;
    //     GLSetup: Record "General Ledger Setup";
    // begin

    //     // Post WHT
    //     GLSetup.GET;
    //     IF GLSetup."Enable WHT FND" THEN
    //         PostWHTFROMCODEUNIT90(PurchaseHeader, TotalAmount, TotalWHTAmount);
    // end;
    // WHt APS
    //    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnPostInvoiceOnAfterPostLines, '', false, false)]
    //     local procedure PurchPost_OnPostInvoiceOnAfterPostLines(var PurchaseHeader: Record "Purchase Header"; SrcCode: Code[10]; GenJnlLineDocType: Enum "Gen. Journal Document Type"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line")
    //     var
    //         WHTHook: Codeunit "WHT Hook APS";
    //     begin
    //         if not IsWHTEnabled() then
    //             exit;
    //         PurchaseHeader.CalcFields("Amount Including VAT");
    //         WHTHook.PostWHT(PurchaseHeader, TempPurchLineGlobalSI, TotalPurchLineLCY, PurchaseHeader."Amount Including VAT", WHTTotalAmount, PurchInvHeaderSI, PurchCrMHeaderSI, SrcCode, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, GenJnlPostLine);
    //     end;
    // WHT APS
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnRunOnAfterPostInvoice', '', false, false)]

    // // local procedure OnRunOnBeforeMakeInventoryAdjustment(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line"; PreviewMode: Boolean; PurchRcptHeader: Record "Purch. Rcpt. Header"; PurchInvHeader: Record "Purch. Inv. Header"; var IsHandled: Boolean)
    // local procedure OnRunOnAfterPostInvoice(var PurchaseHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var ReturnShipmentHeader: Record "Return Shipment Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PreviewMode: Boolean; var Window: Dialog; SrcCode: Code[10]; GenJnlLineDocType: Enum "Gen. Journal Document Type"; GenJnlLineDocNo: Code[20]; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    // procedure OnAfterPostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]; CommitIsSupressed: Boolean)
    // local procedure OnRunOnBeforePostInvoice(PurchaseHeader: Record "Purchase Header"; var EverythingInvoiced: Boolean)
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnPostInvoiceOnAfterPostLines, '', false, false)]
    local procedure PurchPost_OnPostInvoiceOnAfterPostLines(var PurchaseHeader: Record "Purchase Header"; SrcCode: Code[10]; GenJnlLineDocType: Enum "Gen. Journal Document Type"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line")
    var
        TotalInvAmount: Decimal;
        GLSetup: Record "General Ledger Setup";
        TempInvoicePostBuffer: Record "Invoice Posting Buffer";
        DocType: Enum "Gen. Journal Document Type";
    begin
        // IF PurchaseHeader.Invoice AND (PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::"Credit Memo") THEN BEGIN  //HEI.43
        //     GLSetup.get();
        //     IF GLSetup."Enable WHT FND" THEN begin
        //         // PostGLOnFaInvoice(PurchaseHeader, TempInvoicePostBuffer);
        //         // TotalInvAmount := PostFAReturnPostingBuffer(PurchaseHeader, TempInvoicePostBuffer, DocType::Invoice, PurchaseHeader."No.", PurchaseHeader."Vendor Invoice No.");
        //         PostWHT(PurchaseHeader, TotalInvAmount, TotalWHTAmount, PurchInvHeader);
        //     end;
        // END; //HEI.22
        // IF PurchaseHeader.IsCreditDocType() AND (PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::"Credit Memo") THEN BEGIN  //HEI.43
        //     GLSetup.get();
        //     IF GLSetup."Enable WHT FND" THEN begin
        //         // PostGLOnFaCreditMemo(PurchaseHeader, TempInvoicePostBuffer);
        //         PostWHT(PurchaseHeader, TotalInvAmount, TotalWHTAmount, PurchInvHeader);
        //     end;
        // END; //HEI.22
    end;

    // procedure PostWHT(PurchHeader: Record "Purchase Header"; TotalInvAmount: Decimal; var TotalWHTAmount: Decimal; PurchInvHeader: Record "Purch. Inv. Header"; SrcCode: Code[10]) // Add Perimeter // BC Upgrade BHARDA11 --08July2026 // OLD
    procedure PostWHT(PurchHeader: Record "Purchase Header"; TempPurchLineGlobal: Record "Purchase Line"; TotalPurchLineLCY: Record "Purchase Line"; TotalInvAmount: Decimal;
                        var TotalWHTAmount: Decimal; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
                        SrcCode: Code[10]; GenJnlLineDocType: Enum "Gen. Journal Document Type"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35];
                        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line") // Add Perimeter // BC Upgrade BHARDA11 --08July2026 // New
    var
        GenJnlLine: Record "Gen. Journal Line";
        WHTPostingSetup: Record "WHT Posting Setup FND";
        GLReg: Record "G/L Register";
        PostWHTSingleIns: Codeunit "Post WHT Single Instance FND";
        PurchSetup: Record "Purchases & Payables Setup";
        WHTSingleInstance: Codeunit "Post WHT Single Instance FND";
        TempWHTEntrySI: Record "WHT Entry FND" temporary;
        InvoiceWHTEntryExists: Boolean;
    begin
        WITH PurchHeader DO BEGIN
            // OLD >>
            // PurchLine.Reset();
            // PurchLine.SetRange("Document Type", PurchHeader."Document Type");
            // PurchLine.SetRange("Document No.", PurchHeader."No.");
            // PurchLine.SetFilter("No.", '<>%1', '');
            // PurchLine.SetFilter(Type, '<>%1', PurchLine.Type::" ");
            // if PurchLine.FindFirst() then
            //     WHTPostingSetup.GET(PurchLine."WHT Business Posting Group FND", PurchLine."WHT Product Posting Group FND");
            // OLD <<
            // NEW >>
            PurchSetup.Get();
            if TempPurchLineGlobal.Type <> TempPurchLineGlobal.Type::" " then
                WHTPostingSetup.Get(TempPurchLineGlobal."WHT Business Posting Group FND", TempPurchLineGlobal."WHT Product Posting Group FND");
            // NEW <<
            IF "Document Type" IN ["Document Type"::Order, "Document Type"::Invoice] THEN BEGIN
                IF TotalInvAmount >= WHTPostingSetup."WHT Minimum Invoice Amount" THEN
                    WHTManagement.InsertVendInvoiceWHT(PurchInvHeader);
                WHTEntry.RESET;
                WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::Invoice);
                WHTEntry.SETRANGE("Document No.", PurchInvHeader."No.");
                IF WHTEntry.FIND('-') THEN
                    REPEAT
                        WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                        IF (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::Payment) AND
                            (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::" ")
                        THEN
                            IF WHTEntry.Amount <> 0 THEN BEGIN
                                // WHTSingleInstance.GetTempWHTEntrySI(TempWHTEntrySI);
                                // if TempWHTEntrySI.FindSet() then
                                //     repeat
                                TotalWHTAmount := TotalWHTAmount + WHTEntry.Amount;
                                // InsertGenJournalWHT(PurchHeader, GenJnlLine, WHTPostingSetup."Payable WHT Account Code", WHTEntry, PurchInvHeader."No.", SrcCode); // BC Upgrade BHARAD11 --04July2026
                                InsertGenJournalWHT(PurchHeader, WHTEntry, GenJnlLine, WHTPostingSetup."Payable WHT Account Code", TotalPurchLineLCY, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode, -1);
                                PostWHTSingleIns.IncreaseWHTEntryNo;
                                GenJnlPostLine.RUN(GenJnlLine);
                                // until TempWHTEntrySI.Next() = 0;
                            END;

                    UNTIL WHTEntry.NEXT = 0;
                WHTSingleInstance.ClearTempWHTEntrySI();
                IF WHTEntry.FIND('+') then begin
                    InvoiceWHTEntryExists := true;
                    GenJnlPostLine.GetGLReg(GLReg);
                    IF GLReg.FINDLAST THEN BEGIN
                        GLReg."To WHT Entry No. FND" := WHTEntry."Entry No.";
                        GLReg.MODIFY;
                    END;
                end;
            END ELSE BEGIN
                WHTManagement.InsertVendCreditWHT(PurchCrMemoHeader, "Applies-to ID");
                WHTEntry.RESET;
                WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");
                WHTEntry.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                IF WHTEntry.FIND('-') THEN
                    REPEAT
                        WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                        IF (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::Payment) AND
                            (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::" ")
                        THEN BEGIN
                            IF WHTEntry.Amount <> 0 THEN BEGIN
                                TotalWHTAmount := TotalWHTAmount + WHTEntry.Amount;
                                // InsertGenJournalWHT(PurchHeader, GenJnlLine, WHTPostingSetup."Payable WHT Account Code", WHTEntry, PurchCrMemoHeader."No.", SrcCode); // BC Upgrade BHARDA11 -- 04July2026 // OLD
                                InsertGenJournalWHT(PurchHeader, WHTEntry, GenJnlLine, WHTPostingSetup."Payable WHT Account Code", TotalPurchLineLCY, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode, -1); // BC Upgrade BHARDA11 -- 04July2026 // New
                                PostWHTSingleIns.IncreaseWHTEntryNo;
                                GenJnlPostLine.RunWithCheck(GenJnlLine);
                            END;
                        END;
                    UNTIL WHTEntry.NEXT = 0;
                GenJnlPostLine.GetGLReg(GLReg);
                IF WHTEntry.FIND('+') THEN begin
                    IF GLReg.FINDLAST THEN BEGIN
                        GLReg."To WHT Entry No. FND" := WHTEntry."Entry No.";
                        GLReg.MODIFY;
                    END;
                    InvoiceWHTEntryExists := true;
                    WHTSingleInstance.ClearTempWHTEntrySI();
                end;
            END;

            TotalWHTAmount := TotalWHTAmount - CalcWHTAmountOnPrepayment(PurchLine."Document No.");
            // if InvoiceWHTEntryExists then
            //     if PurchHeader."Document Type" = PurchHeader."Document Type"::"Credit Memo" then begin
            //         if PurchSetup."WHT Print Docs. Cr. Memo FND" then
            //             WHTManagement.PrintWHTSlips(GLReg, false);
            //     end else
            //         WHTManagement.PrintWHTSlips(GLReg, false);


            /* { IF (TotalWHTAmount <> 0) THEN
               IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                 IF PurchSetup."Print WHT Docs. on Credit Memo" THEN
                   WHTManagement.PrintWHTSlips(GLReg);
               END ELSE
                 WHTManagement.PrintWHTSlips(GLReg);} */
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", OnBeforeInitGenJnlLineAmountFieldsFromTotalLines, '', false, false)]
    local procedure PurchPostInvoiceEvents_OnBeforeInitGenJnlLineAmountFieldsFromTotalLines(var GenJnlLine: Record "Gen. Journal Line"; var PurchHeader: Record "Purchase Header"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; var IsHandled: Boolean)
    var
        // WHTHook: Codeunit "WHT Hook APS";
        WHTSingleInstance: Codeunit "Post WHT Single Instance FND";
    begin
        if not WHTSingleInstance.IsWHTEnabled() then
            exit;
        InitGenJnlLineAmountFieldsFromTotalPurchLine(GenJnlLine, PurchHeader, TotalPurchLine, TotalPurchLineLCY, IsHandled);
    end;

    // LOCAL procedure PostWHTFROMCODEUNIT90(PurchHeader: Record "Purchase Header"; TotalInvAmount: Decimal; VAR TotalWHTAmount: Decimal)
    // var
    //     WHTPostingSetup: Record "WHT Posting Setup FND";
    //     GLReg: Record "G/L Register";
    //     GenJnlLine: Record "Gen. Journal Line";
    // begin
    //     PurchLine.Reset();
    //     PurchLine.SetRange("Document No.", PurchHeader."No.");
    //     if PurchLine.FindFirst() then
    //         WHTPostingSetup.GET(PurchLine."WHT Business Posting Group FND", PurchLine."WHT Product Posting Group FND");
    //     IF PurchHeader."Document Type" IN [PurchHeader."Document Type"::Order, PurchHeader."Document Type"::Invoice] THEN BEGIN
    //         IF TotalInvAmount >= WHTPostingSetup."WHT Minimum Invoice Amount" THEN
    //             WHTManagement.InsertVendInvoiceWHT(PurchInvHeader);
    //         WHTEntry.RESET();
    //         WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::Invoice);
    //         WHTEntry.SETRANGE("Document No.", PurchInvHeader."No.");
    //         IF WHTEntry.FIND('-') THEN
    //             REPEAT
    //                 WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
    //                 IF (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::Payment) AND
    //                     (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::" ")
    //                 THEN BEGIN
    //                     IF WHTEntry.Amount <> 0 THEN BEGIN
    //                         TotalWHTAmount := TotalWHTAmount + WHTEntry.Amount;
    //                         InsertGenJournalWHT(PurchHeader, GenJnlLine, WHTPostingSetup."Payable WHT Account Code");
    //                         // GenJnlPostLine.IncreaseWHTEntryNo;
    //                         IncreaseWHTEntryNo;
    //                         GenJnlPostLine.RUN(GenJnlLine);
    //                     END;
    //                 END;
    //             UNTIL WHTEntry.NEXT = 0;

    //         IF WHTEntry.FIND('+') THEN
    //             IF GLReg.FINDLAST THEN BEGIN
    //                 GLReg."To WHT Entry No. FND" := WHTEntry."Entry No.";
    //                 GLReg.MODIFY;
    //             END;
    //     END ELSE BEGIN
    //         WHTManagement.InsertVendCreditWHT(PurchCrMemoHeader, PurchHeader."Applies-to ID");
    //         WHTEntry.RESET;
    //         WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");
    //         WHTEntry.SETRANGE("Document No.", PurchCrMemoHeader."No.");
    //         IF WHTEntry.FIND('-') THEN
    //             REPEAT
    //                 WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
    //                 IF (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::Payment) AND
    //                     (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::" ")
    //                 THEN BEGIN
    //                     IF WHTEntry.Amount <> 0 THEN BEGIN
    //                         TotalWHTAmount := TotalWHTAmount + WHTEntry.Amount;
    //                         InsertGenJournalWHT(PurchHeader, GenJnlLine, WHTPostingSetup."Payable WHT Account Code");
    //                         // GenJnlPostLine.IncreaseWHTEntryNo;
    //                         IncreaseWHTEntryNo;
    //                         GenJnlPostLine.RunWithCheck(GenJnlLine);
    //                     END;
    //                 END;
    //             UNTIL WHTEntry.NEXT = 0;

    //         IF WHTEntry.FIND('+') THEN
    //             IF GLReg.FINDLAST THEN BEGIN
    //                 GLReg."To WHT Entry No. FND" := WHTEntry."Entry No.";
    //                 GLReg.MODIFY;
    //             END;
    //     END;

    //     TotalWHTAmount := TotalWHTAmount - CalcWHTAmountOnPrepayment(PurchLine."Document No.");
    //     // { IF (TotalWHTAmount <> 0) THEN
    //     //     IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
    //     //     IF PurchSetup."Print WHT Docs. on Credit Memo" THEN
    //     //         WHTManagement.PrintWHTSlips(GLReg);
    //     //     END ELSE
    //     //     WHTManagement.PrintWHTSlips(GLReg);}
    // end;

    // from codeunit 12 >>
    local procedure IncreaseWHTEntryNo()
    begin
        NextWHTEntryNo := NextWHTEntryNo + 1;
    end;
    // from codeunit 12 <<

    local procedure CalcWHTAmountOnPrepayment(DocNo: Code[20]): Decimal
    begin
        PurchInvHeaderPrePmt.RESET;
        PurchInvHeaderPrePmt.SETRANGE("Prepayment Order No.", DocNo);
        PurchInvHeaderPrePmt.SETRANGE("Prepayment Invoice", TRUE);
        IF PurchInvHeaderPrePmt.FINDSET THEN
            REPEAT
                WHTEntryPrePmt.SETRANGE("Document Type", WHTEntryPrePmt."Document Type"::Invoice);
                WHTEntryPrePmt.SETRANGE("Document No.", PurchInvHeaderPrePmt."No.");
                IF WHTEntryPrePmt.FINDSET THEN
                    REPEAT
                        TotalWHTAmtToBeDeducted := TotalWHTAmtToBeDeducted + WHTEntryPrePmt."Unrealized Amount";
                    UNTIL WHTEntryPrePmt.NEXT = 0;
            UNTIL PurchInvHeaderPrePmt.NEXT = 0;
        EXIT(TotalWHTAmtToBeDeducted);
    end;

    local procedure InsertGenJournalWHT(var PurchHeader: Record "Purchase Header"; var TempWHTEntrySplitted: Record "WHT Entry FND"; var GenJnlLine: Record "Gen. Journal Line"; AccountNo: Code[20];
               var TotalPurchLineLCY: Record "Purchase Line"; GenJnlLineDocType: Enum "Gen. Journal Document Type"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; SrcCode: Code[10]; Sign: Integer)
    var
        CurrExchRate: Record "Currency Exchange Rate";
        PurchaseLine: Record "Purchase Line";
    begin
        GenJnlLine.Init();
        GenJnlLine."Posting Date" := PurchHeader."Posting Date";
        GenJnlLine."Document Date" := PurchHeader."Document Date";
        GenJnlLine.Description := PurchHeader."Posting Description";
        GenJnlLine."Shortcut Dimension 1 Code" := PurchHeader."Shortcut Dimension 1 Code";
        GenJnlLine."Shortcut Dimension 2 Code" := PurchHeader."Shortcut Dimension 2 Code";
        GenJnlLine."Dimension Set ID" := PurchHeader."Dimension Set ID";
        GenJnlLine."Reason Code" := PurchHeader."Reason Code";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := AccountNo;
        GenJnlLine."Document Type" := GenJnlLineDocType;
        GenJnlLine."Document No." := GenJnlLineDocNo;
        GenJnlLine."External Document No." := GenJnlLineExtDocNo;
        GenJnlLine."Currency Code" := PurchHeader."Currency Code";
        GenJnlLine.Amount := Sign * TempWHTEntrySplitted.Amount;
        GenJnlLine."Source Currency Code" := PurchHeader."Currency Code";
        GenJnlLine."Source Currency Amount" := Sign * TempWHTEntrySplitted.Amount;
        if PurchHeader."Currency Code" <> '' then
            GenJnlLine."Amount (LCY)" :=
              Round(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  PurchHeader."Posting Date", PurchHeader."Currency Code", Sign * TempWHTEntrySplitted.Amount, PurchHeader."Currency Factor"));
        if PurchHeader."Currency Code" = '' then
            GenJnlLine."Currency Factor" := 1
        else
            GenJnlLine."Currency Factor" := PurchHeader."Currency Factor";
        GenJnlLine."Sales/Purch. (LCY)" := Sign * TotalPurchLineLCY.Amount;
        GenJnlLine.Correction := PurchHeader.Correction;
        GenJnlLine."Inv. Discount (LCY)" := Sign * TotalPurchLineLCY."Inv. Discount Amount";
        GenJnlLine."Sell-to/Buy-from No." := PurchHeader."Buy-from Vendor No.";
        GenJnlLine."Bill-to/Pay-to No." := PurchHeader."Pay-to Vendor No.";
        GenJnlLine."Salespers./Purch. Code" := PurchHeader."Purchaser Code";
        GenJnlLine."System-Created Entry" := true;
        GenJnlLine."On Hold" := PurchHeader."On Hold";
        GenJnlLine."Allow Application" := PurchHeader."Bal. Account No." = '';
        GenJnlLine."Due Date" := PurchHeader."Due Date";
        GenJnlLine."Payment Terms Code" := PurchHeader."Payment Terms Code";
        GenJnlLine."Source Type" := GenJnlLine."Source Type"::Vendor;
        GenJnlLine."Source No." := PurchHeader."Pay-to Vendor No.";
        GenJnlLine."Source Code" := SrcCode;
        GenJnlLine."Posting No. Series" := PurchHeader."Posting No. Series";
        GenJnlLine."IC Partner Code" := PurchHeader."Pay-to IC Partner Code";
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchHeader."No.");
        if PurchaseLine.FindFirst() then
            GenJnlLine.Validate("Dimension Set ID", PurchaseLine."Dimension Set ID");
    end;
    // Blocked >>
    /*  local procedure InsertGenJournalWHT(VAR PurchHeader: Record "Purchase Header"; VAR GenJnlLine: Record "Gen. Journal Line"; AccountNo: Code[20]; WHTEntry: Record "WHT Entry FND"; DocNoGenJnlLine: Code[20]; SrcCode: code[20]) // BC Upgrade BHARDA11 -- 04July2026 Add Perimeter
     var
         CurrExchRate: Record "Currency Exchange Rate";
         Noseries: Codeunit "No. Series";
         PurchaseLine: Record "Purchase Line";
     begin
         GenJnlLine.INIT;
         GenJnlLine."Posting Date" := PurchHeader."Posting Date";
         GenJnlLine."Document Date" := PurchHeader."Document Date";
         GenJnlLine.Description := PurchHeader."Posting Description";
         GenJnlLine."Shortcut Dimension 1 Code" := PurchHeader."Shortcut Dimension 1 Code";
         GenJnlLine."Shortcut Dimension 2 Code" := PurchHeader."Shortcut Dimension 2 Code";
         GenJnlLine."Dimension Set ID" := PurchHeader."Dimension Set ID";
         GenJnlLine."Reason Code" := PurchHeader."Reason Code";
         GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
         GenJnlLine."Account No." := AccountNo;
         // GenJnlLine."Document Type" := GenJnlLineDocType; //2
         GenJnlLine."Document Type" := PurchHeader."Document Type"; //2
         // GenJnlLine."Document No." := GenJnlLineDocNo;// Invoice No.
         // GenJnlLine."Document No." := PurchHeader."Posting No.";// Invoice No.
         GenJnlLine."Document No." := DocNoGenJnlLine;// Noseries.PeekNextNo(PurchHeader."Posting No. Series");// PurchHeader."Posting No.";// Invoice No.

         // GenJnlLine."External Document No." := GenJnlLineExtDocNo; // Vendor Inv No.
         GenJnlLine."External Document No." := PurchHeader."Vendor Invoice No."; // Vendor Inv No.
         GenJnlLine."Currency Code" := PurchHeader."Currency Code";
         GenJnlLine.Amount := -WHTEntry.Amount;
         // GenJnlLine."Source Currency Amount" := -PurchHeader."WHT Amount Post FND"; // Testing

         if PurchHeader."Currency Code" <> '' then
             GenJnlLine."Amount (LCY)" :=
               Round(
                 CurrExchRate.ExchangeAmtFCYToLCY(
                   PurchHeader."Posting Date", PurchHeader."Currency Code", -WHTEntry.Amount, PurchHeader."Currency Factor"));
         if PurchHeader."Currency Code" = '' then
             GenJnlLine."Currency Factor" := 1
         else
             GenJnlLine."Currency Factor" := PurchHeader."Currency Factor";


         GenJnlLine."Source Currency Code" := PurchHeader."Currency Code";
         GenJnlLine."Source Currency Amount" := -WHTEntry.Amount;
         // IF PurchHeader."Currency Code" <> '' THEN
         //     GenJnlLine."Amount (LCY)" :=
         //     ROUND(
         //         CurrExchRate.ExchangeAmtFCYToLCY(
         //         PurchHeader."Posting Date", PurchHeader."Currency Code", -WHTEntry.Amount, PurchHeader."Currency Factor"));
         // IF PurchHeader."Currency Code" = '' THEN
         //     GenJnlLine."Currency Factor" := 1
         // ELSE
         //     GenJnlLine."Currency Factor" := PurchHeader."Currency Factor";
         GenJnlLine."Sales/Purch. (LCY)" := -TotalPurchLineLCY.Amount;
         GenJnlLine.Correction := PurchHeader.Correction;
         GenJnlLine."Inv. Discount (LCY)" := -TotalPurchLineLCY."Inv. Discount Amount";
         GenJnlLine."Sell-to/Buy-from No." := PurchHeader."Buy-from Vendor No.";
         GenJnlLine."Bill-to/Pay-to No." := PurchHeader."Pay-to Vendor No.";
         GenJnlLine."Salespers./Purch. Code" := PurchHeader."Purchaser Code";
         GenJnlLine."System-Created Entry" := TRUE;
         GenJnlLine."On Hold" := PurchHeader."On Hold";
         GenJnlLine."Allow Application" := PurchHeader."Bal. Account No." = '';
         GenJnlLine."Due Date" := PurchHeader."Due Date";
         GenJnlLine."Payment Terms Code" := PurchHeader."Payment Terms Code";
         GenJnlLine."Source Type" := GenJnlLine."Source Type"::Vendor;
         GenJnlLine."Source No." := PurchHeader."Pay-to Vendor No.";
         GenJnlLine."Source Code" := SrcCode;
         GenJnlLine."Posting No. Series" := PurchHeader."Posting No. Series";
         GenJnlLine."IC Partner Code" := PurchHeader."Pay-to IC Partner Code";
         PurchaseLine.Reset();
         PurchaseLine.SetRange("Document Type", PurchHeader."Document Type");
         PurchaseLine.SetRange("Document No.", PurchHeader."No.");
         if PurchaseLine.FindFirst() then
             GenJnlLine.Validate("Dimension Set ID", PurchaseLine."Dimension Set ID");
         GenJnlLine."IS WHT Line FND" := true; // BC Upgrade BHARDA11 -- 04July2026

     end; */
    // Blocked <<
    // ----------------------------------------------------------------------------------------------------
    [EventSubscriber(ObjectType::Table, Database::"WHT Entry FND", OnAfterInsertEvent, '', false, false)]
    local procedure UY5888uu(var Rec: Record "WHT Entry FND")
    begin
        // Message('%1', Rec."Entry No.");
    end;

    var
        SalesLine: Record "Sales Line";
        SalesInvHeader: Record "Sales Invoice Header";

    LOCAL procedure PostWHTFROMCODEUNIT80(SalesHeader: Record "Sales Header"; TotalInvAmount: Decimal; VAR TotalWHTAmount: Decimal)
    var
        WHTPostingSetup: Record "WHT Posting Setup FND";
        GLReg: Record "G/L Register";
        GenJnlLine: Record "Gen. Journal Line";
    begin
        WHTPostingSetup.GET(SalesLine."WHT Business Posting Group FND", SalesLine."WHT Product Posting Group FND");
        IF SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice] THEN BEGIN
            IF TotalInvAmount >= WHTPostingSetup."WHT Minimum Invoice Amount" THEN
                WHTManagement.InsertCustInvoiceWHT(SalesInvHeader);
            WHTEntry.RESET;
            WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::Invoice);
            WHTEntry.SETRANGE("Document No.", SalesInvHeader."No.");
            IF WHTEntry.FIND('-') THEN
                REPEAT
                    WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                    IF (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::Payment) AND
                        (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::" ")
                    THEN BEGIN
                        IF WHTEntry.Amount <> 0 THEN BEGIN
                            TotalWHTAmount := TotalWHTAmount + WHTEntry.Amount;
                            InsertGenJournalWHT(SalesHeader, GenJnlLine, WHTPostingSetup."Prepaid WHT Account Code", -WHTEntry.Amount);
                            // GenJnlPostLine.IncreaseWHTEntryNo;
                            IncreaseWHTEntryNo;
                            GenJnlPostLine.RUN(GenJnlLine);
                        END;
                    END;
                UNTIL WHTEntry.NEXT = 0;

            IF WHTEntry.FIND('+') THEN
                IF GLReg.FINDLAST THEN BEGIN
                    GLReg."To WHT Entry No. FND" := WHTEntry."Entry No.";
                    GLReg.MODIFY;
                END;
        END ELSE BEGIN
            WHTManagement.InsertCustCreditWHT(SalesCrMemoHeader, SalesHeader."Applies-to ID");
            WHTEntry.RESET;
            WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");
            WHTEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
            IF WHTEntry.FIND('-') THEN
                REPEAT
                    WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                    IF (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::Payment) AND
                        (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::" ")
                    THEN BEGIN
                        IF WHTEntry.Amount <> 0 THEN BEGIN
                            TotalWHTAmount := TotalWHTAmount + WHTEntry.Amount;
                            InsertGenJournalWHT(SalesHeader, GenJnlLine, WHTPostingSetup."Prepaid WHT Account Code", -WHTEntry.Amount);
                            // GenJnlPostLine.IncreaseWHTEntryNo;
                            IncreaseWHTEntryNo;
                            GenJnlPostLine.RUN(GenJnlLine);
                        END;
                    END;
                UNTIL WHTEntry.NEXT = 0;

            IF WHTEntry.FIND('+') THEN
                IF GLReg.FINDLAST THEN BEGIN
                    GLReg."To WHT Entry No. FND" := WHTEntry."Entry No.";
                    GLReg.MODIFY;
                END;
        END;

        IF (TotalWHTAmount <> 0) THEN
            WHTManagement.PrintWHTSlips(GLReg);
    end;

    local procedure InsertGenJournalWHT(VAR SalesHeader: Record "Sales Header"; VAR GenJnlLine: Record "Gen. Journal Line"; AccountNo: Code[20]; AmountWHT: Decimal)
    var
        CurrExchRate: Record "Currency Exchange Rate";
        // PurchPost: Codeunit "Purch Post Custom CU CBN";
        Purc: Codeunit "Purch. Post Invoice";
    begin
        GenJnlLine.INIT;
        GenJnlLine."Posting Date" := SalesHeader."Posting Date";
        GenJnlLine."Document Date" := SalesHeader."Document Date";
        GenJnlLine.Description := SalesHeader."Posting Description";
        GenJnlLine."Shortcut Dimension 1 Code" := SalesHeader."Shortcut Dimension 1 Code";
        GenJnlLine."Shortcut Dimension 2 Code" := SalesHeader."Shortcut Dimension 2 Code";
        GenJnlLine."Dimension Set ID" := SalesHeader."Dimension Set ID";
        GenJnlLine."Reason Code" := SalesHeader."Reason Code";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := AccountNo;
        GenJnlLine."Document Type" := GenJnlLineDocType;
        GenJnlLine."Document No." := GenJnlLineDocNo;
        GenJnlLine."External Document No." := GenJnlLineExtDocNo;
        GenJnlLine."Currency Code" := SalesHeader."Currency Code";
        GenJnlLine.Amount := AmountWHT;
        GenJnlLine."Source Currency Code" := SalesHeader."Currency Code";
        GenJnlLine."Source Currency Amount" := AmountWHT;
        IF SalesHeader."Currency Code" <> '' THEN
            GenJnlLine."Amount (LCY)" :=
            ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                SalesHeader."Posting Date", SalesHeader."Currency Code", AmountWHT, SalesHeader."Currency Factor"));
        IF SalesHeader."Currency Code" = '' THEN
            GenJnlLine."Currency Factor" := 1
        ELSE
            GenJnlLine."Currency Factor" := SalesHeader."Currency Factor";
        GenJnlLine."Sales/Purch. (LCY)" := -TotalSalesLineLCY.Amount;
        GenJnlLine.Correction := SalesHeader.Correction;
        GenJnlLine."Inv. Discount (LCY)" := -TotalSalesLineLCY."Inv. Discount Amount";
        GenJnlLine."Sell-to/Buy-from No." := SalesHeader."Sell-to Customer No.";
        GenJnlLine."Bill-to/Pay-to No." := SalesHeader."Bill-to Customer No.";
        GenJnlLine."System-Created Entry" := TRUE;
        GenJnlLine."On Hold" := SalesHeader."On Hold";
        GenJnlLine."Allow Application" := SalesHeader."Bal. Account No." = '';
        GenJnlLine."Due Date" := SalesHeader."Due Date";
        GenJnlLine."Payment Terms Code" := SalesHeader."Payment Terms Code";
        GenJnlLine."Source Type" := GenJnlLine."Source Type"::Vendor;
        GenJnlLine."Source No." := SalesHeader."Bill-to Customer No.";
        GenJnlLine."Source Code" := SrcCode;
        GenJnlLine."Posting No. Series" := SalesHeader."Posting No. Series";
        GenJnlLine."IC Partner Code" := SalesHeader."Sell-to IC Partner Code";
    end;
    //-----------------------------
    // Codeunit 225
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Apply", 'OnApplyVendorLedgerEntryOnBeforeModify', '', false, false)]
    local procedure OnApplyVendorLedgerEntryOnBeforeModify(var GenJournalLine: Record "Gen. Journal Line"; VendorLedgerEntry: Record "Vendor Ledger Entry"; VendorLedgerEntryLocal: Record "Vendor Ledger Entry")
    var
        GenLedgerSetup: Record "General Ledger Setup";
        TempPaymJournalLine: Record "Gen. Journal Line" temporary;
        PaymGenJnlLine: Record "Gen. Journal Line";
        LastDocNo: Code[20];
        WHTPostingSetup: Record "WHT Posting Setup FND";
        TempWHTEntry: Record "WHT Entry FND" temporary;
        locVendLedgerEntry: Record "Vendor Ledger Entry";
        GenJnlBatch: Record "Gen. Journal Batch";
        lrGenJnlLine: Record "Gen. Journal Line";
        NoSeriesMgt: Codeunit GlobalNoSeriesManagement;
    begin
        //HEI.01>>
        GenLedgerSetup.GET;
        IF GenLedgerSetup."Enable WHT FND" AND (NOT GenJournalLine."Skip WHT FND") THEN BEGIN
            TempPaymJournalLine.TRANSFERFIELDS(GenJournalLine);
            TempPaymJournalLine.INSERT;
            LastDocNo := '';
            //DELETE(TRUE);
            //split the payment line for diff WHT group combinations , if MODIFY
            WHTPostingSetup.RESET;
            //WHT comb
            WHTPostingSetup.SETCURRENTKEY("Realized WHT Type");
            WHTPostingSetup.SETASCENDING("Realized WHT Type", FALSE);
            IF WHTPostingSetup.FINDFIRST THEN
                REPEAT
                    TempWHTEntry.RESET;
                    TempWHTEntry.SETRANGE("WHT Bus. Posting Group", WHTPostingSetup."WHT Business Posting Group");
                    TempWHTEntry.SETRANGE("WHT Prod. Posting Group", WHTPostingSetup."WHT Product Posting Group");
                    IF TempWHTEntry.FINDFIRST THEN BEGIN
                        TempWHTEntry.CALCSUMS(Amount);
                        //for the first line
                        IF LastDocNo = '' THEN BEGIN
                            GenJournalLine."WHT Business Posting Group FND" := TempWHTEntry."WHT Bus. Posting Group";
                            GenJournalLine."WHT Product Posting Group FND" := TempWHTEntry."WHT Prod. Posting Group";
                            GenJournalLine.VALIDATE(Amount, TempWHTEntry.Amount);
                            GenJournalLine.MODIFY(TRUE);
                            LastDocNo := GenJournalLine."Document No.";
                        END ELSE BEGIN
                            PaymGenJnlLine.INIT;
                            PaymGenJnlLine.TRANSFERFIELDS(TempPaymJournalLine);
                            lrGenJnlLine.RESET;
                            lrGenJnlLine.SETRANGE("Journal Template Name", TempPaymJournalLine."Journal Template Name");
                            lrGenJnlLine.SETRANGE("Journal Batch Name", TempPaymJournalLine."Journal Batch Name");
                            IF lrGenJnlLine.FIND('+') THEN BEGIN
                                PaymGenJnlLine."Line No." := lrGenJnlLine."Line No." + 10000;
                            END ELSE
                                PaymGenJnlLine."Line No." := 10000;
                            IF GenJnlBatch.GET(TempPaymJournalLine."Journal Template Name", TempPaymJournalLine."Journal Batch Name") THEN
                                IF GenJnlBatch."No. Series" <> '' THEN BEGIN
                                    CLEAR(NoSeriesMgt);
                                    IF LastDocNo = '' THEN
                                        PaymGenJnlLine."Document No." := NoSeriesMgt.TryGetNextGlobalNo(GenJnlBatch."No. Series", PaymGenJnlLine."Posting Date")
                                    ELSE
                                        PaymGenJnlLine."Document No." := INCSTR(LastDocNo);
                                    LastDocNo := PaymGenJnlLine."Document No.";
                                END ELSE
                                    PaymGenJnlLine."Document No." := INCSTR(LastDocNo);
                            LastDocNo := PaymGenJnlLine."Document No.";
                            PaymGenJnlLine."WHT Business Posting Group FND" := TempWHTEntry."WHT Bus. Posting Group";
                            PaymGenJnlLine."WHT Product Posting Group FND" := TempWHTEntry."WHT Prod. Posting Group";
                            PaymGenJnlLine.VALIDATE(Amount, TempWHTEntry.Amount);
                            PaymGenJnlLine."Applies-to ID" := PaymGenJnlLine."Document No.";
                            PaymGenJnlLine.INSERT;
                            REPEAT
                                //update the Apply-to id
                                locVendLedgerEntry.GET(TempWHTEntry."Entry No.");
                                locVendLedgerEntry."Applies-to ID" := PaymGenJnlLine."Document No.";
                                //locVendLedgerEntry.MODIFY;
                                CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit", locVendLedgerEntry);
                            UNTIL TempWHTEntry.NEXT = 0;
                        END;
                        //WHT comb
                        //update the WHT amount , WHT Amount LCY after the Apply-to ID are correctly defined
                        PaymGenJnlLine.RESET;
                        PaymGenJnlLine.SETRANGE("Journal Template Name", TempPaymJournalLine."Journal Template Name");
                        PaymGenJnlLine.SETRANGE("Journal Batch Name", TempPaymJournalLine."Journal Batch Name");
                        IF PaymGenJnlLine.FINDSET THEN
                            REPEAT
                                PaymGenJnlLine.VALIDATE(Amount, PaymGenJnlLine.Amount);
                                PaymGenJnlLine.MODIFY;
                            UNTIL PaymGenJnlLine.NEXT = 0;


                    END;
                UNTIL WHTPostingSetup.NEXT = 0
        END;
        //HEI.01<<
    end;

    // Test for Mail
    procedure SendEmailWithAttachment(PurchaseHdrNo: Code[20])
    var
        PurchHdrRec: Record "Purchase Header";
        TempPurchHdrRec: Record "Purchase Header" temporary;
        PurchHdrAddRec: Record "Purchase Header Additional FND";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        ReportSelectionRec: Record "Report Selections";
        VendorRec: Record Vendor;
        WorkflowRule: Record "Workflow Rule";
        Base64Convert: Codeunit "Base64 Convert";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        FileManagement: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        FileInStream: InStream;
        OutStream: OutStream;
        AttachmentBase64: Text;
        BodyText: Text;
        FileName: Text;
        SubjectText: Text;
        VendorEmail: Text;
        FileNameL: Text[250];
        AllObjWithCaption: Record AllObjWithCaption;
        ReportParameters: Text;
        ReportLbl: Label '<?xml version="1.0" standalone="yes"?><ReportParameters name= "%1" id="%2"><Options><Field name="ArchiveDocument">false</Field><Field name="LogInteraction">true</Field></Options><DataItems><DataItem name="Purchase Header">VERSION(1) SORTING(Field1,Field3) WHERE(Field3=1(%3))</DataItem><DataItem name="Purchase Line">VERSION(1) SORTING(Field1,Field3,Field4)</DataItem><DataItem name="Totals">VERSION(1) SORTING(Field1)</DataItem><DataItem name="VATCounter">VERSION(1) SORTING(Field1)</DataItem><DataItem name="VATCounterLCY">VERSION(1) SORTING(Field1)</DataItem><DataItem name="PrepmtLoop">VERSION(1) SORTING(Field1)</DataItem><DataItem name="PrepmtVATCounter">VERSION(1) SORTING(Field1)</DataItem><DataItem name="LetterText">VERSION(1) SORTING(Field1)</DataItem></DataItems></ReportParameters>';

    begin
        // HEI.44 >>
        Clear(VendorEmail);
        Clear(FileName);
        // Get Purchase Header
        if not PurchHdrRec.Get(PurchHdrRec."Document Type"::Order, PurchaseHdrNo) then
            exit;

        // Get Vendor Email
        if VendorRec.Get(PurchHdrRec."Buy-from Vendor No.") then
            VendorEmail := VendorRec."E-Mail";

        if VendorEmail = '' then
            exit;

        // Optional validation
        if not CheckValidEmailAddress(VendorEmail) then
            exit;
        // Get report selection for Purchase Order
        ReportSelectionRec.Reset();
        ReportSelectionRec.SetRange(Usage, ReportSelectionRec.Usage::"P.Order");
        ReportSelectionRec.SetFilter("Report ID", '<>%1', 0);
        ReportSelectionRec.SETRANGE("Document Subtype Code FND", PurchHdrRec."Document Subtype Code FND");
        if not ReportSelectionRec.FindFirst() then
            exit;

        if AllObjWithCaption.Get(AllObjWithCaption."Object Type"::Report, ReportSelectionRec."Report ID") then;

        ReportParameters := StrSubstNo(ReportLbl, AllObjWithCaption."Object Caption", ReportSelectionRec."Report ID", PurchHdrRec."No.");
        TempBlob.CreateOutStream(OutStream);
        Report.SaveAs(ReportSelectionRec."Report ID", ReportParameters, ReportFormat::Pdf, OutStream);
        TempBlob.CreateInStream(FileInStream);

        SubjectText := StrSubstNo('Purchase Order %1', PurchHdrRec."No.");
        BodyText :=
          'Hi ' + PurchHdrRec."Buy-from Vendor Name" + ',' + '<br><br>' +
          'Please find the attached Purchase Order.' + '<br><br>' +
          '<hr>This is a system-generated email. Please do not reply.';

        // Create and configure email message
        EmailMessage.Create(VendorEmail, SubjectText, BodyText, true);

        // Add attachment
        EmailMessage.AddAttachment(PurchHdrRec."No." + '.pdf', 'application/pdf', FileInStream);

        // Add CC (optional logic)
        PurchasesPayablesSetup.Get();
        if PurchasesPayablesSetup."Auto Email to Requestor FND" then begin
            if (PurchHdrRec."Maximo Requisition No. FND" <> '') and (FindPQApproerEmail(PurchHdrRec) <> '') then
                EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, FindPQApproerEmail(PurchHdrRec))

            else if (PurchHdrRec."Maximo Requisition No. FND" = '') and (FindCreaterEmail(PurchHdrRec) <> '') then
                EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, FindCreaterEmail(PurchHdrRec))

        end;

        // Send the email using the default email account
        Email.Send(EmailMessage, Enum::"Email Scenario"::"Purchase Order");

        // Update "Mail Sent" tracking
        if PurchHdrAddRec.Get(PurchHdrRec."Document Type", PurchHdrRec."No.") then begin
            PurchHdrAddRec."Mail Sent" := true;
            PurchHdrAddRec."Mail Sent Date Time" := CreateDateTime(Today, Time);
            PurchHdrAddRec.Modify();
        end;
        // HEI.44 <<
    end;
    //BC Upgrade ATHUKS01<<


    local procedure FindPQApproerEmail(var PurchaseHeader: Record "Purchase Header"): Text[100];
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        UserSetup: Record "User Setup";
    begin
        //HEI.98 >>
        //HEI.99>>
        if PurchaseHeaderAdditional.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") then
            if UserSetup.GET(PurchaseHeaderAdditional."PQ Approver") then
                //IF UserSetup.GET(PurchaseHeader."PQ Approver") THEN
                //HEI.99<<
                if UserSetup."E-Mail" <> '' then
                    exit(UserSetup."E-Mail");
        //HEI.98 <<
    end;

    local procedure FindCreaterEmail(var PurchaseHeader: Record "Purchase Header"): Text[100];
    var
        UserSetup: Record "User Setup";
    begin
        //HEI.98 >>
        if UserSetup.GET(PurchaseHeader.SystemCreatedBy) then
            if UserSetup."E-Mail" <> '' then
                exit(UserSetup."E-Mail");
        //HEI.98 <<
    end;

    procedure CheckValidEmailAddress(EmailAddress: Text): Boolean;
    var
        i: Integer;
        NoOfAtSigns: Integer;
    begin
        //HEi.44 >>
        EmailAddress := DELCHR(EmailAddress, '<>');

        if EmailAddress = '' then
            exit(false);
        //ERROR(InvalidEmailAddressErr,EmailAddress);

        if (EmailAddress[1] = '@') or (EmailAddress[STRLEN(EmailAddress)] = '@') then
            exit(false);
        //ERROR(InvalidEmailAddressErr,EmailAddress);

        for i := 1 to STRLEN(EmailAddress) do begin
            if EmailAddress[i] = '@' then
                NoOfAtSigns := NoOfAtSigns + 1
            else
                if EmailAddress[i] = ' ' then
                    exit(false);
            //ERROR(InvalidEmailAddressErr,EmailAddress);
        end;

        if NoOfAtSigns <> 1 then
            exit(false);
        //ERROR(InvalidEmailAddressErr,EmailAddress);
        exit(true);
        //HEI.44 <<
    end;
    // Test for mail



    procedure UpdateInvoicePostBuffer(var TempInvoicePostBuffer: Record "Invoice Posting Buffer" temporary; InvoicePostBuffer: Record "Invoice Posting Buffer")
    var
        FALineNo: Integer;
    begin
        IF InvoicePostBuffer.Type = InvoicePostBuffer.Type::"Fixed Asset" THEN BEGIN
            FALineNo := FALineNo + 1;
            InvoicePostBuffer."Fixed Asset Line No." := FALineNo;
        END;

        TempInvoicePostBuffer.Update(InvoicePostBuffer, InvDefLineNo, DeferralLineNo);
    end;

    local procedure UpdDeferralPostBuffer(InvoicePostBuffer: Record "Invoice Posting Buffer")
    begin
        DeferralPostBuffer[1]."Dimension Set ID" := InvoicePostBuffer."Dimension Set ID";
        DeferralPostBuffer[1]."Global Dimension 1 Code" := InvoicePostBuffer."Global Dimension 1 Code";
        DeferralPostBuffer[1]."Global Dimension 2 Code" := InvoicePostBuffer."Global Dimension 2 Code";

        DeferralPostBuffer[2] := DeferralPostBuffer[1];
        IF DeferralPostBuffer[2].FIND THEN BEGIN
            DeferralPostBuffer[2].Amount += DeferralPostBuffer[1].Amount;
            DeferralPostBuffer[2]."Amount (LCY)" += DeferralPostBuffer[1]."Amount (LCY)";
            DeferralPostBuffer[2]."Sales/Purch Amount" += DeferralPostBuffer[1]."Sales/Purch Amount";
            DeferralPostBuffer[2]."Sales/Purch Amount (LCY)" += DeferralPostBuffer[1]."Sales/Purch Amount (LCY)";

            IF NOT DeferralPostBuffer[1]."System-Created Entry" THEN
                DeferralPostBuffer[2]."System-Created Entry" := FALSE;
            IF IsCombinedDeferralZero THEN
                DeferralPostBuffer[2].DELETE
            ELSE
                DeferralPostBuffer[2].MODIFY;
        END ELSE
            DeferralPostBuffer[1].INSERT;
    end;

    procedure IsCombinedDeferralZero(): Boolean
    begin
        IF (DeferralPostBuffer[2].Amount = 0) AND (DeferralPostBuffer[2]."Amount (LCY)" = 0) AND
   (DeferralPostBuffer[2]."Sales/Purch Amount" = 0) AND (DeferralPostBuffer[2]."Sales/Purch Amount (LCY)" = 0)
THEN
            EXIT(TRUE);

        EXIT(FALSE);

    end;

    LOCAL procedure FillDeferralPostingBuffer(PurchHeader: Record "Purchase Header"; PurchLine: Record "Purchase Line"; InvoicePostBuffer: Record "Invoice Posting Buffer"; RemainAmtToDefer: Decimal; RemainAmtToDeferACY: Decimal; DeferralAccount: Code[20]; PurchAccount: Code[20])
    var
        DeferralTemplate: Record "Deferral Template";
        TempDeferralLine: Record "Deferral Line" temporary;
        TempDeferralHeader: Record "Deferral Header" temporary;

    begin

        IF PurchLine."Deferral Code" <> '' THEN BEGIN
            DeferralTemplate.GET(PurchLine."Deferral Code");

            IF TempDeferralHeader.GET(TempDeferralHeader."Deferral Doc. Type"::Purchase, '', '',
                 PurchLine."Document Type", PurchLine."Document No.", PurchLine."Line No.")
            THEN BEGIN
                IF TempDeferralHeader."Amount to Defer" <> 0 THEN BEGIN
                    TempDeferralLine.SETRANGE("Deferral Doc. Type", TempDeferralHeader."Deferral Doc. Type"::Purchase);
                    TempDeferralLine.SETRANGE("Gen. Jnl. Template Name", '');
                    TempDeferralLine.SETRANGE("Gen. Jnl. Batch Name", '');
                    TempDeferralLine.SETRANGE("Document Type", PurchLine."Document Type");
                    TempDeferralLine.SETRANGE("Document No.", PurchLine."Document No.");
                    TempDeferralLine.SETRANGE("Line No.", PurchLine."Line No.");

                    // The remaining amounts only need to be adjusted into the deferral account and are always reversed
                    IF (RemainAmtToDefer <> 0) OR (RemainAmtToDeferACY <> 0) THEN BEGIN
                        DeferralPostBuffer[1].PreparePurch(PurchLine, GenJnlLineDocNo);
                        DeferralPostBuffer[1]."Amount (LCY)" := -RemainAmtToDefer;
                        DeferralPostBuffer[1].Amount := -RemainAmtToDeferACY;
                        DeferralPostBuffer[1]."Sales/Purch Amount (LCY)" := 0;
                        DeferralPostBuffer[1]."Sales/Purch Amount" := 0;
                        // DeferralPostBuffer[1].ReverseAmounts;
                        DeferralPostBuffer[1]."G/L Account" := PurchAccount;
                        DeferralPostBuffer[1]."Deferral Account" := DeferralAccount;
                        // Remainder always goes to the Posting Date
                        DeferralPostBuffer[1]."Posting Date" := PurchHeader."Posting Date";
                        DeferralPostBuffer[1].Description := PurchHeader."Posting Description";
                        DeferralPostBuffer[1]."Period Description" := DeferralTemplate."Period Description";
                        DeferralPostBuffer[1]."Deferral Line No." := InvDefLineNo;
                        DeferralPostBuffer[1]."Partial Deferral" := TRUE;
                        UpdDeferralPostBuffer(InvoicePostBuffer);
                    END;

                    // Add the deferral lines for each period to the deferral posting buffer merging when they are the same
                    IF TempDeferralLine.FINDSET THEN
                        REPEAT
                            IF (TempDeferralLine."Amount (LCY)" <> 0) OR (TempDeferralLine.Amount <> 0) THEN BEGIN
                                DeferralPostBuffer[1].PreparePurch(PurchLine, GenJnlLineDocNo);
                                DeferralPostBuffer[1]."Amount (LCY)" := TempDeferralLine."Amount (LCY)";
                                DeferralPostBuffer[1].Amount := TempDeferralLine.Amount;
                                DeferralPostBuffer[1]."Sales/Purch Amount (LCY)" := TempDeferralLine."Amount (LCY)";
                                DeferralPostBuffer[1]."Sales/Purch Amount" := TempDeferralLine.Amount;
                                IF PurchLine.IsCreditDocType THEN
                                    DeferralPostBuffer[1].ReverseAmounts;
                                DeferralPostBuffer[1]."G/L Account" := PurchAccount;
                                DeferralPostBuffer[1]."Deferral Account" := DeferralAccount;
                                DeferralPostBuffer[1]."Posting Date" := TempDeferralLine."Posting Date";
                                DeferralPostBuffer[1].Description := TempDeferralLine.Description;
                                DeferralPostBuffer[1]."Period Description" := DeferralTemplate."Period Description";
                                DeferralPostBuffer[1]."Deferral Line No." := InvDefLineNo;
                                UpdDeferralPostBuffer(InvoicePostBuffer);
                            END ELSE
                                ERROR(ZeroDeferralAmtErr, PurchLine."No.", PurchLine."Deferral Code");

                        UNTIL TempDeferralLine.NEXT = 0

                    ELSE
                        ERROR(NoDeferralScheduleErr, PurchLine."No.", PurchLine."Deferral Code");
                END ELSE
                    ERROR(NoDeferralScheduleErr, PurchLine."No.", PurchLine."Deferral Code")
            END ELSE
                ERROR(NoDeferralScheduleErr, PurchLine."No.", PurchLine."Deferral Code")
        END;
    end;

    local procedure FillInvoicePostBufferFADiscount(var TempInvoicePostBuffer: Record "Invoice Posting Buffer" temporary; var InvoicePostBuffer: Record "Invoice Posting Buffer"; GenPostingSetup: Record "General Posting Setup"; AccountNo: Code[20]; TotalVAT: Decimal; TotalVATACY: Decimal; TotalAmount: Decimal; TotalAmountACY: Decimal)
    var
        DeprBook: Record "Depreciation Book";
    begin
        DeprBook.GET(InvoicePostBuffer."Depreciation Book Code");
        IF DeprBook."Subtract Disc. in Purch. Inv." THEN BEGIN
            GenPostingSetup.TESTFIELD("Purch. FA Disc. Account");
            InvoicePostBuffer.SetAccount(AccountNo, TotalVAT, TotalVATACY, TotalAmount, TotalAmountACY);
            // InvoicePostBuffer.SetAccount
            UpdateInvoicePostBuffer(TempInvoicePostBuffer, InvoicePostBuffer);
            InvoicePostBuffer.ReverseAmounts;
            InvoicePostBuffer.SetAccount(GenPostingSetup."Purch. FA Disc. Account", TotalVAT, TotalVATACY, TotalAmount, TotalAmountACY);
            InvoicePostBuffer.Type := InvoicePostBuffer.Type::"G/L Account";
            UpdateInvoicePostBuffer(TempInvoicePostBuffer, InvoicePostBuffer);
            InvoicePostBuffer.ReverseAmounts;
        END;
    end;


    procedure InitGenJnlLineAmountFieldsFromTotalPurchLine(var GenJnlLine: Record "Gen. Journal Line"; var PurchHeader: Record "Purchase Header"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY2: Record "Purchase Line"; var IsHandled: Boolean)
    var
        CurrExchRate: Record "Currency Exchange Rate";
        TotalWHTAmount: Decimal;
        WHTSingleInstance: Codeunit "Post WHT Single Instance FND";
        PurchPostInvoiceEvents: Codeunit "Purch. Post Invoice Events";
    begin
        WHTSingleInstance.GetWHTTotalAmount(TotalWHTAmount);
        if TotalWHTAmount = 0 then
            exit;

        GenJnlLine.Amount := -(TotalPurchLine."Amount Including VAT" - TotalWHTAmount);
        GenJnlLine."Source Currency Amount" :=
          -(TotalPurchLine."Amount Including VAT" - TotalWHTAmount);
        if PurchHeader."Currency Code" <> '' then
            GenJnlLine."Amount (LCY)" :=
              -(TotalPurchLineLCY2."Amount Including VAT" -
                Round(
                  CurrExchRate.ExchangeAmtFCYToLCY(
                    PurchHeader."Posting Date", PurchHeader."Currency Code", TotalWHTAmount, PurchHeader."Currency Factor")))
        else
            GenJnlLine."Amount (LCY)" :=
              -(TotalPurchLineLCY2."Amount Including VAT" - TotalWHTAmount);

        GenJnlLine."Sales/Purch. (LCY)" := -TotalPurchLineLCY2.Amount;
        GenJnlLine."Inv. Discount (LCY)" := -TotalPurchLineLCY2."Inv. Discount Amount";
        GenJnlLine."Orig. Pmt. Disc. Possible" := -TotalPurchLine."Pmt. Discount Amount";
        GenJnlLine."Orig. Pmt. Disc. Possible(LCY)" :=
          CurrExchRate.ExchangeAmtFCYToLCY(
            PurchHeader.GetUseDate(), PurchHeader."Currency Code", -TotalPurchLine."Pmt. Discount Amount", PurchHeader."Currency Factor");
        PurchPostInvoiceEvents.RunOnAfterInitGenJnlLineAmountFieldsFromTotalLines(GenJnlLine, PurchHeader, TotalPurchLine, TotalPurchLineLCY);
        IsHandled := true;
    end;

    var
        TotalFAPurchLine: Record "Purchase Line";
        GenJnlLineType: Record "Gen. Journal Line";
        TotalPurchLine: Record "Purchase Line";
        FASetup: Record "FA Setup";
        DeferralPostBuffer: array[2] of Record "Deferral Posting Buffer";
        ZeroDeferralAmtErr: Label 'Deferral amounts cannot be 0. Line: %1, Deferral Template: %2.';
        NoDeferralScheduleErr: Label 'You must create a deferral schedule because you have specified the deferral code %2 in line %1.';
        DeferralUtilities: Codeunit "Deferral Utilities";
        InvDefLineNo, DeferralLineNo : Integer;
        LineCount: Decimal;
        Window: Dialog;
        GLSetup: Record "General Ledger Setup";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforePostInvoice, '', false, false)]

    local procedure OnBeforePostInvoice(var PurchHeader: Record "Purchase Header"; PreviewMode: Boolean; CommitIsSupressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var IsHandled: Boolean; var Window: Dialog; HideProgressWindow: Boolean; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; var InvoicePostingInterface: Interface "Invoice Posting"; var InvoicePostingParameters: Record "Invoice Posting Parameters"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; GenJnlLineDocType: Enum "Gen. Journal Document Type"; SrcCode: Code[10])
    begin
        // Message('OnBeforePost %1', PurchHeader."Posting No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnafterPostInvoice, '', false, false)]

    local procedure OnAfterPostInvoice(var PurchHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; TotalPurchLine: Record "Purchase Line"; TotalPurchLineLCY: Record "Purchase Line"; CommitIsSupressed: Boolean; var VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        // Message('Onafterpost %1', PurchHeader."Posting No.");
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnFinalizePostingOnBeforeCommit, '', false, false)]
    // local procedure OnFinalizePostingOnBeforeCommit(PreviewMode: Boolean; var IsHandled: Boolean)
    // begin
    //     IsHandled := true;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforeCommitAndUpdateAnalysisVeiw, '', false, false)]
    // local procedure OnBeforeCommitAndUpdateAnalysisVeiw(InvtPickPutaway: Boolean; SuppressCommit: Boolean; PreviewMode: Boolean; var IsHandled: Boolean)
    // begin
    //     IsHandled := true;
    // end;
}
