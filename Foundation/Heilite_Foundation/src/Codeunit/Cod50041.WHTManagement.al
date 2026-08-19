codeunit 50041 WHTManagement
{
    // version NAVAPAC10.00

    // HEI.01 Defect 3156 IBM ISYED01 #Error while posting cash receipt journal
    //   #Fixed the issue while posting cash receipt journal when customer is selected.
    // HEI.05 CHG2040699  HT971 IBM POSTOI01 07.02.2020 # payment posting for many applied invoices on Applies-to ID
    //   # modify CalcAppliedWHTAmount
    //   # modify InsertWHTpostingBuffer
    //   # modify WHTAmountJournal
    // HEI.06 CHG2057437 IBM POENAB02 28.04.2020 # FDD_HT1104_DRC_WHT functionality enhancement
    //   # Modified functions ProcessPayment, ProcessManualReceipt, InsertWHT, ProcessPaymentPosted, InsertPrepaymentUnrealizedWHT, InitWHTEntry
    // HEI.07 CHG2057371 HT1292 IBM SHANKJ03 04.27.2020
    //   # code Modified StatisticsCalcWHTAmount

    // BC Upgrade PATELP08 >> 
    // Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
    // Changed datatype of parameter "DocType" in procedure FindWHTEntryForApply from Option to Enum for compatibility with calling functions passing Enum values. Enum members match the previous Option values.
    // Changed datatype of "ApplyDocType", "DocType" variable from option to Enum, values matched.
    // BC Upgrade PATELP08 <<

    Permissions = TableData "Cust. Ledger Entry" = rimd,
                  TableData "Vendor Ledger Entry" = rimd,
                  tabledata "G/L Entry" = RIMD,
                  TableData "G/L Register" = rimd;

    trigger OnRun();
    begin
    end;

    var
        CurrExchRate: Record "Currency Exchange Rate";
        TempCustLedgEntry: Record "Cust. Ledger Entry";
        TempCustLedgEntry1: Record "Cust. Ledger Entry";
        Customer: Record Customer;
        TempGenJnlLine: Record "Gen. Journal Line" temporary;
        GLSetup: Record "General Ledger Setup";
        PurchCreditLine: Record "Purch. Cr. Memo Line";
        TempPurchCreditLine: Record "Purch. Cr. Memo Line";
        PurchInvLine: Record "Purch. Inv. Line";
        TempPurchInvLine: Record "Purch. Inv. Line";
        SalesCreditLine: Record "Sales Cr.Memo Line";
        SalesInvLine: Record "Sales Invoice Line";
        SourceCodeSetup: Record "Source Code Setup";
        Vendor: Record Vendor;
        TempVendLedgEntry: Record "Vendor Ledger Entry";
        TempVendLedgEntry1: Record "Vendor Ledger Entry";
        gWHTPostingSetup: Record "WHT Posting Setup FND";
        WHTPostingSetup: Record "WHT Posting Setup FND";
        //NoSeriesMgt: Codeunit NoSeriesManagement;  // BC Upgrade NANDIS03 - Blocked
        NoSeriesMgt: Codeunit "No. Series";  // BC Upgrade NANDIS03 - Added
        ExitLoop: Boolean;
        FullWHT: Boolean;
        UnrealizedWHT: Boolean;
        CurrencyCode: Code[10];
        Dim1: Code[10];
        Dim2: Code[10];
        GenBusPostGrp: Code[10];
        GenProdPostGrp: Code[10];
        ReasonCode: Code[10];
        SourceCode: Code[10];
        WHTBusPostGrp: Code[10];
        WHTProdPostGrp: Code[10];
        WHTReportLineNo: Code[10];
        WHTRevenueType: Code[10];
        ActualVendorNo: Code[20];
        "Applies-toID": Code[20];
        ApplyDocNo: Code[20];
        BuyFromVendCustNo: Code[20];
        DocNo: Code[20];
        PayToVendCustNo: Code[20];
        ExtDocNo: Code[35];
        DocDate: Date;
        InvoicePaymentDate: Date;
        PostingDate: Date;
        AbsorbBase: Decimal;
        Amount: Decimal;
        AmountVAT: Decimal;
        AppliedAmount: Decimal;
        AppliedBase: Decimal;
        CurrFactor: Decimal;
        TempRemAmt: Decimal;
        TempRemBase: Decimal;
        TotalInvoiceAmount: Decimal;
        TotalInvoiceAmountLCY: Decimal;
        TotAmt: Decimal;
        WHTMinInvoiceAmt: Decimal;
        NextEntry: Integer;
        NextWHTEntryNo: Integer;
        Text1500000: Label 'Currency Code should be same for Payment and Invoice.';
        Text1500001: Label 'You cannot reprint the certificate from here. Go to reports and reprint.';
        Text1500003: Label 'The WHT posting groups are different and thus the entries cannot be apply.';
        Text1500004: Label 'You cannot post a transaction using different WHT minimum invoice amounts on lines.';
        // BC Upgrade PATELP08 >> Changed datatype of ApplyDocType variable from option to Enum, values matched.
        // ApplyDocType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        ApplyDocType: Enum "Gen. Journal Document Type";
        // BC Upgrade PATELP08 <<
        // BC Upgrade PATELP08 >> Changed datatype of DocType variable from option to Enum, values matched.
        DocType: Enum "Gen. Journal Document Type";
        // BC Upgrade PATELP08 <<
        TType: Option Purchase,Sale;
        TransType: Option Purchase,Sale,Settlement;
        BuyFromAccType: Option Vendor,Customer;
        PayToAccType: Option Vendor,Customer;

    procedure ApplyVendInvoiceWHT(var VendLedgerEntry: Record "Vendor Ledger Entry"; var GenJnlLine: Record "Gen. Journal Line") EntryNo: Integer;
    var
        localCLE: Record "Cust. Ledger Entry";
        localCustomer: Record Customer;
        localVLE: Record "Vendor Ledger Entry";
        RemainingAmt: Decimal;
        Currency: Option Vendor,Customer;
    begin
        GLSetup.GET();
        TempVendLedgEntry1.RESET();
        SetVendAppliesToFilter(TempVendLedgEntry1, GenJnlLine);
        // if TempVendLedgEntry1.findset(true) then
        if TempVendLedgEntry1.findset(true) then
            repeat
                TempVendLedgEntry1.CALCFIELDS(
                  Amount, "Amount (LCY)", "Remaining Amount", "Remaining Amt. (LCY)",
                  "Original Amount", "Original Amt. (LCY)");
                if TempVendLedgEntry1."Rem. Amt for WHT FND" = 0 then
                    TempVendLedgEntry1."Rem. Amt for WHT FND" := TempVendLedgEntry1."Remaining Amount";
                RemainingAmt := RemainingAmt + TempVendLedgEntry1."Rem. Amt for WHT FND";
                if TempVendLedgEntry1."Document Type" = TempVendLedgEntry1."Document Type"::"Credit Memo" then
                    RemainingAmt := RemainingAmt + TempVendLedgEntry1."Rem. Amt for WHT FND";
            until TempVendLedgEntry1.NEXT() = 0;
        TotAmt := ABS(GenJnlLine.Amount);

        TempVendLedgEntry.RESET();
        SetVendAppliesToFilter(TempVendLedgEntry, GenJnlLine);
        TempVendLedgEntry.SETRANGE("Document Type", TempVendLedgEntry."Document Type"::"Credit Memo");
        if TempVendLedgEntry.findset() then
            repeat
                TempVendLedgEntry.CALCFIELDS(
                  Amount, "Amount (LCY)", "Remaining Amount", "Remaining Amt. (LCY)",
                  "Original Amount", "Original Amt. (LCY)");
                if CheckPmtDisc(
                     GenJnlLine."Posting Date", TempVendLedgEntry."Pmt. Discount Date",
                     ABS(TempVendLedgEntry."Rem. Amt for WHT FND"),
                     ABS(TempVendLedgEntry."Rem. Amt FND"),
                     ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"),
                     ABS(TotAmt))
                then
                    TotAmt := TotAmt + TempVendLedgEntry."Original Pmt. Disc. Possible";

                if (ABS(RemainingAmt) < ABS(TotAmt)) or
                   (ABS(TempVendLedgEntry."Rem. Amt for WHT FND") < ABS(TotAmt))
                then begin
                    if CheckPmtDisc(GenJnlLine."Posting Date",
                         TempVendLedgEntry."Pmt. Discount Date",
                         ABS(TempVendLedgEntry."Rem. Amt for WHT FND"),
                         ABS(TempVendLedgEntry."Rem. Amt FND"),
                         ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"),
                         ABS(TotAmt))
                    then begin
                        GenJnlLine.VALIDATE(
                          Amount,
                          -ABS(TempVendLedgEntry."Rem. Amt for WHT FND" - TempVendLedgEntry."Original Pmt. Disc. Possible"));
                        RemainingAmt :=
                          RemainingAmt - TempVendLedgEntry."Rem. Amt for WHT FND" - TempVendLedgEntry."Original Pmt. Disc. Possible";
                    end else begin
                        GenJnlLine.VALIDATE(Amount, -ABS(TempVendLedgEntry."Rem. Amt for WHT FND"));
                        if TempVendLedgEntry."Document Type" <>
                           TempVendLedgEntry."Document Type"::"Credit Memo"
                        then
                            TotAmt := TotAmt - TempVendLedgEntry."Rem. Amt for WHT FND";
                        RemainingAmt := RemainingAmt - TempVendLedgEntry."Rem. Amt for WHT FND";
                    end;
                end else begin
                    if CheckPmtDisc(GenJnlLine."Posting Date",
                         TempVendLedgEntry."Pmt. Discount Date",
                         ABS(TempVendLedgEntry."Rem. Amt for WHT FND"),
                         ABS(TempVendLedgEntry."Rem. Amt FND"),
                         ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"),
                         ABS(TotAmt))
                    then
                        GenJnlLine.VALIDATE(Amount, -TotAmt + TempVendLedgEntry."Original Pmt. Disc. Possible")
                    else
                        GenJnlLine.VALIDATE(Amount, -TotAmt);
                    ExitLoop := true;
                end;
                if TempVendLedgEntry."Document Type" = TempVendLedgEntry."Document Type"::Invoice then
                    GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice
                else begin
                    if TempVendLedgEntry."Document Type" = TempVendLedgEntry."Document Type"::"Credit Memo" then
                        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::"Credit Memo";
                    RemainingAmt := RemainingAmt - TempVendLedgEntry."Rem. Amt for WHT FND";
                    TotAmt := TotAmt + TempVendLedgEntry."Rem. Amt for WHT FND";
                    ExitLoop := false;
                end;
                GenJnlLine."Applies-to Doc. No." := TempVendLedgEntry."Document No.";
                NextEntry :=
                  ProcessPayment(
                    GenJnlLine, VendLedgerEntry."Transaction No.", VendLedgerEntry."Entry No.", Currency::Vendor, false);

                if ExitLoop then
                    exit(NextEntry);
            until TempVendLedgEntry.NEXT() = 0;
        ExitLoop := false;
        TempVendLedgEntry.RESET();
        SetVendAppliesToFilter(TempVendLedgEntry, GenJnlLine);
        TempVendLedgEntry.SETFILTER("Document Type", '<>%1', TempVendLedgEntry."Document Type"::"Credit Memo");
        if TempVendLedgEntry.findset() then
            repeat
                TempVendLedgEntry.CALCFIELDS(
                  Amount,
                  "Amount (LCY)",
                  "Remaining Amount",
                  "Remaining Amt. (LCY)",
                  "Original Amount",
                  "Original Amt. (LCY)");
                if TempVendLedgEntry."Remaining Amount" = 0 then
                    if CheckPmtDisc(
                         GenJnlLine."Posting Date",
                         TempVendLedgEntry."Pmt. Discount Date",
                         ABS(TempVendLedgEntry."Rem. Amt for WHT FND"),
                         ABS(TempVendLedgEntry."Rem. Amt FND"),
                         ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"),
                         ABS(TotAmt))
                    then
                        TotAmt := TotAmt - TempVendLedgEntry."Original Pmt. Disc. Possible";

                if (ABS(RemainingAmt) < ABS(TotAmt)) or
                   (ABS(TempVendLedgEntry."Rem. Amt for WHT FND") < ABS(TotAmt))
                then begin
                    if CheckPmtDisc(
                         GenJnlLine."Posting Date",
                         TempVendLedgEntry."Pmt. Discount Date",
                         ABS(TempVendLedgEntry."Rem. Amt for WHT FND"),
                         ABS(TempVendLedgEntry."Rem. Amt FND"),
                         ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"),
                         ABS(TotAmt))
                    then begin
                        if (ABS(TotAmt) < ABS(TempVendLedgEntry."Rem. Amt for WHT FND")) or (TempVendLedgEntry."Rem. Amt for WHT FND" = 0) then
                            GenJnlLine.VALIDATE(Amount, TotAmt)
                        else
                            GenJnlLine.VALIDATE(
                              Amount,
                              ABS(TempVendLedgEntry."Rem. Amt for WHT FND" - TempVendLedgEntry."Original Pmt. Disc. Possible"));

                        if TempVendLedgEntry."Document Type" <> TempVendLedgEntry."Document Type"::"Credit Memo" then
                            TotAmt := TotAmt + TempVendLedgEntry."Rem. Amt for WHT FND";
                        RemainingAmt :=
                          RemainingAmt - TempVendLedgEntry."Rem. Amt for WHT FND" + TempVendLedgEntry."Original Pmt. Disc. Possible";
                    end else begin
                        GenJnlLine.VALIDATE(Amount, ABS(TempVendLedgEntry."Rem. Amt for WHT FND"));
                        if TempVendLedgEntry."Document Type" <> TempVendLedgEntry."Document Type"::"Credit Memo" then
                            TotAmt := TotAmt + TempVendLedgEntry."Rem. Amt for WHT FND";
                        RemainingAmt := RemainingAmt - TempVendLedgEntry."Rem. Amt for WHT FND";
                    end;
                end else begin
                    if CheckPmtDisc(
                         GenJnlLine."Posting Date",
                         TempVendLedgEntry."Pmt. Discount Date",
                         ABS(TempVendLedgEntry."Rem. Amt for WHT FND"),
                         ABS(TempVendLedgEntry."Rem. Amt FND"),
                         ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"),
                         ABS(TotAmt))
                    then
                        GenJnlLine.VALIDATE(Amount, TotAmt + TempVendLedgEntry."Original Pmt. Disc. Possible")
                    else
                        GenJnlLine.VALIDATE(Amount, TotAmt);
                    ExitLoop := true;
                end;

                if TempVendLedgEntry."Document Type" = TempVendLedgEntry."Document Type"::Invoice then
                    GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice
                else begin
                    if TempVendLedgEntry."Document Type" = TempVendLedgEntry."Document Type"::"Credit Memo" then
                        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::"Credit Memo";
                    RemainingAmt := RemainingAmt + TempVendLedgEntry."Rem. Amt for WHT FND";
                    TotAmt := TotAmt + TempVendLedgEntry."Rem. Amt for WHT FND";
                    ExitLoop := false;
                end;

                GenJnlLine."Applies-to Doc. No." := TempVendLedgEntry."Document No.";
                NextEntry :=
                  ProcessPayment(
                    GenJnlLine, VendLedgerEntry."Transaction No.", VendLedgerEntry."Entry No.", Currency::Vendor, false);

                if ExitLoop then
                    exit(NextEntry);
            until TempVendLedgEntry.NEXT() = 0;
        exit(NextEntry);
    end;

    local procedure SetVendAppliesToFilter(var VendLedgEntry: Record "Vendor Ledger Entry"; GenJnlLine: Record "Gen. Journal Line");
    begin
        if GenJnlLine."Applies-to ID" <> '' then
            VendLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID")
        else begin
            VendLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
            VendLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
        end;
    end;

    procedure ApplyCustInvoiceWHT(var CustLedgerEntry: Record "Cust. Ledger Entry"; var GenJnlLine: Record "Gen. Journal Line") EntryNo: Integer;
    var
        RemainingAmt: Decimal;
        Currency: Option Vendor,Customer;
    begin
        TotAmt := ABS(GenJnlLine.Amount);
        TempCustLedgEntry1.RESET();
        SetCustAppliesToFilter(TempCustLedgEntry1, GenJnlLine);
        //if TempCustLedgEntry1.findset(true) then
        if TempCustLedgEntry1.findset(true) then
            repeat
                TempCustLedgEntry1.CALCFIELDS(
                  Amount,
                  "Amount (LCY)",
                  "Remaining Amount",
                  "Remaining Amt. (LCY)",
                  "Original Amount",
                  "Original Amt. (LCY)");
                if TempCustLedgEntry1."Rem. Amt for WHT FND" = 0 then
                    TempCustLedgEntry1."Rem. Amt for WHT FND" := TempCustLedgEntry1."Remaining Amount";
                RemainingAmt := RemainingAmt + TempCustLedgEntry1."Rem. Amt for WHT FND";
                if TempCustLedgEntry1."Document Type" = TempCustLedgEntry1."Document Type"::"Credit Memo" then
                    RemainingAmt := RemainingAmt + TempCustLedgEntry1."Rem. Amt for WHT FND";
            until TempCustLedgEntry1.NEXT() = 0;

        TempCustLedgEntry.RESET();
        SetCustAppliesToFilter(TempCustLedgEntry, GenJnlLine);
        TempCustLedgEntry.SETRANGE("Document Type", TempCustLedgEntry."Document Type"::"Credit Memo");
        if TempCustLedgEntry.findset() then
            repeat
                TempCustLedgEntry.CALCFIELDS(
                  Amount,
                  "Amount (LCY)",
                  "Remaining Amount",
                  "Remaining Amt. (LCY)",
                  "Original Amount",
                  "Original Amt. (LCY)");
                if CheckPmtDisc(
                     GenJnlLine."Posting Date",
                     TempCustLedgEntry."Pmt. Discount Date",
                     ABS(TempCustLedgEntry."Rem. Amt for WHT FND"),
                     ABS(TempCustLedgEntry."Rem. Amt FND"),
                     ABS(TempCustLedgEntry."Original Pmt. Disc. Possible"),
                     ABS(TotAmt))
                then
                    TotAmt := TotAmt + ABS(TempCustLedgEntry."Original Pmt. Disc. Possible");
                if (ABS(RemainingAmt) <= ABS(TotAmt)) or
                   (ABS(TempCustLedgEntry."Rem. Amt for WHT FND") < ABS(TotAmt))
                then begin
                    if CheckPmtDisc(
                         GenJnlLine."Posting Date",
                         TempCustLedgEntry."Pmt. Discount Date",
                         ABS(TempCustLedgEntry."Rem. Amt for WHT FND"),
                         ABS(TempCustLedgEntry."Rem. Amt FND"),
                         ABS(TempCustLedgEntry."Original Pmt. Disc. Possible"),
                         ABS(TotAmt))
                    then begin
                        GenJnlLine.VALIDATE(
                          Amount,
                          ABS(TempCustLedgEntry."Rem. Amt for WHT FND" - TempCustLedgEntry."Original Pmt. Disc. Possible"));
                        if TempCustLedgEntry."Document Type" <> TempCustLedgEntry."Document Type"::"Credit Memo" then
                            TotAmt := -(TotAmt - TempCustLedgEntry."Rem. Amt for WHT FND");
                        RemainingAmt :=
                          RemainingAmt - TempCustLedgEntry."Rem. Amt for WHT FND" + TempCustLedgEntry."Original Pmt. Disc. Possible";
                    end else begin
                        GenJnlLine.VALIDATE(Amount, ABS(TempCustLedgEntry."Rem. Amt for WHT FND"));
                        if TempCustLedgEntry."Document Type" <> TempCustLedgEntry."Document Type"::"Credit Memo" then
                            TotAmt := -(TotAmt - TempCustLedgEntry."Rem. Amt for WHT FND");
                        RemainingAmt := RemainingAmt - TempCustLedgEntry."Rem. Amt for WHT FND";
                    end;
                end else begin
                    if CheckPmtDisc(
                         GenJnlLine."Posting Date",
                         TempCustLedgEntry."Pmt. Discount Date",
                         ABS(TempCustLedgEntry."Rem. Amt for WHT FND"),
                         ABS(TempCustLedgEntry."Rem. Amt FND"),
                         ABS(TempCustLedgEntry."Original Pmt. Disc. Possible"),
                         ABS(TotAmt))
                    then
                        GenJnlLine.VALIDATE(Amount, ABS(TotAmt - ABS(TempCustLedgEntry."Original Pmt. Disc. Possible")))
                    else
                        GenJnlLine.VALIDATE(Amount, ABS(TotAmt));
                    ExitLoop := true;
                end;
                if TempCustLedgEntry."Document Type" = TempCustLedgEntry."Document Type"::Invoice then
                    GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice
                else
                    if TempCustLedgEntry."Document Type" = TempCustLedgEntry."Document Type"::"Credit Memo" then begin
                        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::"Credit Memo";
                        RemainingAmt := RemainingAmt - TempCustLedgEntry."Rem. Amt for WHT FND";
                        TotAmt := TotAmt - TempCustLedgEntry."Rem. Amt for WHT FND";
                        ExitLoop := false;
                    end;
                GenJnlLine."Applies-to Doc. No." := TempCustLedgEntry."Document No.";
                NextEntry :=
                  ProcessPayment(
                    GenJnlLine, CustLedgerEntry."Transaction No.", CustLedgerEntry."Entry No.", Currency::Customer, false);
                if ExitLoop then
                    exit(NextEntry);
            until TempCustLedgEntry.NEXT() = 0;

        ExitLoop := false;
        TempCustLedgEntry.RESET();
        SetCustAppliesToFilter(TempCustLedgEntry, GenJnlLine);
        TempCustLedgEntry.SETFILTER("Document Type", '<>%1', TempCustLedgEntry."Document Type"::"Credit Memo");
        if TempCustLedgEntry.findset() then
            repeat
                TempCustLedgEntry.CALCFIELDS(
                  Amount, "Amount (LCY)", "Remaining Amount", "Remaining Amt. (LCY)", "Original Amount", "Original Amt. (LCY)");
                if CheckPmtDisc(
                     GenJnlLine."Posting Date",
                     TempCustLedgEntry."Pmt. Discount Date",
                     ABS(TempCustLedgEntry."Rem. Amt for WHT FND"),
                     ABS(TempCustLedgEntry."Rem. Amt FND"),
                     ABS(TempCustLedgEntry."Original Pmt. Disc. Possible"),
                     ABS(TotAmt))
                then
                    TotAmt := TotAmt + ABS(TempCustLedgEntry."Original Pmt. Disc. Possible");
                if (ABS(RemainingAmt) <= ABS(TotAmt)) or
                   (ABS(TempCustLedgEntry."Rem. Amt for WHT FND") < ABS(TotAmt))
                then begin
                    if CheckPmtDisc(
                         GenJnlLine."Posting Date",
                         TempCustLedgEntry."Pmt. Discount Date",
                         ABS(TempCustLedgEntry."Rem. Amt for WHT FND"),
                         ABS(TempCustLedgEntry."Rem. Amt FND"),
                         ABS(TempCustLedgEntry."Original Pmt. Disc. Possible"),
                         ABS(TotAmt))
                    then begin
                        RemainingAmt :=
                          RemainingAmt - TempCustLedgEntry."Rem. Amt for WHT FND" + TempCustLedgEntry."Original Pmt. Disc. Possible";
                        GenJnlLine.VALIDATE(
                          Amount, -ABS(TempCustLedgEntry."Rem. Amt for WHT FND" - TempCustLedgEntry."Original Pmt. Disc. Possible"));
                        if TempCustLedgEntry."Document Type" <> TempCustLedgEntry."Document Type"::"Credit Memo" then
                            TotAmt := (TotAmt - TempCustLedgEntry."Rem. Amt for WHT FND")
                    end else begin
                        RemainingAmt := RemainingAmt - TempCustLedgEntry."Rem. Amt for WHT FND";
                        GenJnlLine.VALIDATE(Amount, -ABS(TempCustLedgEntry."Rem. Amt for WHT FND"));
                        if TempCustLedgEntry."Document Type" <> TempCustLedgEntry."Document Type"::"Credit Memo" then
                            TotAmt := (TotAmt - TempCustLedgEntry."Rem. Amt for WHT FND");
                    end;
                end else begin
                    if CheckPmtDisc(
                         GenJnlLine."Posting Date",
                         TempCustLedgEntry."Pmt. Discount Date",
                         ABS(TempCustLedgEntry."Rem. Amt for WHT FND"),
                         ABS(TempCustLedgEntry."Rem. Amt FND"),
                         ABS(TempCustLedgEntry."Original Pmt. Disc. Possible"),
                         ABS(TotAmt))
                    then
                        GenJnlLine.VALIDATE(Amount, -ABS(TotAmt - TempCustLedgEntry."Original Pmt. Disc. Possible"))
                    else
                        GenJnlLine.VALIDATE(Amount, -ABS(TotAmt));
                    ExitLoop := true;
                end;
                if TempCustLedgEntry."Document Type" = TempCustLedgEntry."Document Type"::Invoice then
                    GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice
                else
                    if TempCustLedgEntry."Document Type" = TempCustLedgEntry."Document Type"::"Credit Memo" then begin
                        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::"Credit Memo";
                        RemainingAmt := RemainingAmt - TempCustLedgEntry."Rem. Amt for WHT FND";
                        TotAmt := TotAmt - TempCustLedgEntry."Rem. Amt for WHT FND";
                        ExitLoop := false;
                    end;
                GenJnlLine."Applies-to Doc. No." := TempCustLedgEntry."Document No.";
                NextEntry :=
                  ProcessPayment(
                    GenJnlLine, CustLedgerEntry."Transaction No.", CustLedgerEntry."Entry No.", Currency::Customer, false);
                if ExitLoop then
                    exit(NextEntry);
            until TempCustLedgEntry.NEXT() = 0;
        exit(NextEntry);
    end;

    local procedure SetCustAppliesToFilter(var CustLedgEntry: Record "Cust. Ledger Entry"; GenJnlLine: Record "Gen. Journal Line");
    begin
        if GenJnlLine."Applies-to ID" <> '' then
            CustLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID")
        else begin
            CustLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
            CustLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
        end;
    end;

    procedure ApplyManualCustInvoiceWHT(var CustLedgerEntry: Record "Cust. Ledger Entry"; var GenJnlLine: Record "Gen. Journal Line") NextEntry: Integer;
    var
        WHTEntry: Record "WHT Entry FND";
        Currency: Option Vendor,Customer;
    begin
        TempCustLedgEntry.RESET();
        TotAmt := ABS(GenJnlLine.Amount);
        if GenJnlLine."Applies-to Doc. No." = '' then begin
            TempCustLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
            TempCustLedgEntry.SETRANGE("Document Type", TempCustLedgEntry."Document Type"::"Credit Memo");
            if TempCustLedgEntry.findset() then
                repeat
                    WHTEntry.RESET();
                    WHTEntry.SETRANGE("Document No.", TempCustLedgEntry."Document No.");
                    WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");
                    if WHTEntry.findset() then
                        repeat
                            GenJnlLine.VALIDATE(Amount, WHTEntry."Remaining Unrealized Amount");
                            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::"Credit Memo";
                            GenJnlLine."Applies-to Doc. No." := TempCustLedgEntry."Document No.";
                            TotAmt := TotAmt - WHTEntry."Remaining Unrealized Amount";
                        until WHTEntry.NEXT() = 0;
                    CustLedgerEntry."Applies-to ID" := '';
                    CustLedgerEntry.MODIFY();
                until TempCustLedgEntry.NEXT() = 0;

            TempCustLedgEntry.RESET();
            TempCustLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
            TempCustLedgEntry.SETFILTER("Document Type", '<>%1', TempCustLedgEntry."Document Type"::"Credit Memo");
            if TempCustLedgEntry.findset() then
                repeat
                    WHTEntry.RESET();
                    WHTEntry.SETRANGE("Document No.", TempCustLedgEntry."Document No.");
                    WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::Invoice);
                    if WHTEntry.findset() then
                        repeat
                            if TotAmt > ABS(WHTEntry."Remaining Unrealized Amount") then begin
                                GenJnlLine.VALIDATE(Amount, WHTEntry."Remaining Unrealized Amount");
                                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                                GenJnlLine."Applies-to Doc. No." := TempCustLedgEntry."Document No.";
                                TotAmt := TotAmt - ABS(WHTEntry."Remaining Unrealized Amount");
                                ExitLoop := false;
                            end else begin
                                GenJnlLine.VALIDATE(Amount, -TotAmt);
                                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                                GenJnlLine."Applies-to Doc. No." := TempCustLedgEntry."Document No.";
                                ExitLoop := true;
                            end;
                        until WHTEntry.NEXT() = 0;
                    NextEntry :=
                      ProcessManualReceipt(
                        GenJnlLine, CustLedgerEntry."Transaction No.", CustLedgerEntry."Entry No.", Currency::Customer);
                    CustLedgerEntry."Applies-to ID" := '';
                    CustLedgerEntry.MODIFY();
                    if ExitLoop then
                        exit(NextEntry);
                until TempCustLedgEntry.NEXT() = 0;
        end else
            NextEntry :=
              ProcessManualReceipt(
                GenJnlLine, CustLedgerEntry."Transaction No.", CustLedgerEntry."Entry No.", Currency::Customer);
    end;

    procedure InsertVendInvoiceWHT(var PurchInvHeader: Record "Purch. Inv. Header")
    var
        GenPostingSetup: Record "General Posting Setup";
        TempPurchLine: Record "Purchase Line";
        TempWHTEntry: Record "WHT Entry FND" temporary;
        WHTSingleInstance: Codeunit "Post WHT Single Instance FND";
        PrepaymentAmtDeducted: Decimal;
    begin
        PurchInvLine.Reset();
        PurchInvLine.SetCurrentKey("Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
        PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
        PurchInvLine.SetFilter(Quantity, '<>0');
        if PurchInvLine.FindSet() then begin
            WHTBusPostGrp := PurchInvLine."WHT Business Posting Group FND";
            WHTProdPostGrp := PurchInvLine."WHT Product Posting Group FND";
            if WHTPostingSetup.Get(PurchInvLine."WHT Business Posting Group FND", PurchInvLine."WHT Product Posting Group FND") then
                WHTMinInvoiceAmt := WHTPostingSetup."WHT Minimum Invoice Amount";
            repeat
                if WHTPostingSetup.Get(PurchInvLine."WHT Business Posting Group FND", PurchInvLine."WHT Product Posting Group FND") then begin
                    if (WHTBusPostGrp <> PurchInvLine."WHT Business Posting Group FND") or
                       (WHTProdPostGrp <> PurchInvLine."WHT Product Posting Group FND")
                    then
                        if WHTMinInvoiceAmt <> WHTPostingSetup."WHT Minimum Invoice Amount" then
                            Error(Text1500004);
                    WHTBusPostGrp := PurchInvLine."WHT Business Posting Group FND";
                    WHTProdPostGrp := PurchInvLine."WHT Product Posting Group FND";
                end;
            until PurchInvLine.Next() = 0;
        end;

        GLSetup.Get();

        PurchInvLine.Reset();
        PurchInvLine.SetCurrentKey("Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
        PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
        PurchInvLine.SetFilter(Quantity, '<>0');
        PurchInvLine.SetRange("Prepayment Line", false);
        if PurchInvLine.FindSet() then
            repeat
                if WHTPostingSetup.Get(PurchInvLine."WHT Business Posting Group FND", PurchInvLine."WHT Product Posting Group FND") then
                    if WHTPostingSetup."WHT %" > 0 then begin
                        DocNo := PurchInvLine."Document No.";
                        DocType := DocType::Invoice;
                        PayToAccType := PayToAccType::Vendor;
                        PayToVendCustNo := PurchInvHeader."Pay-to Vendor No.";
                        BuyFromAccType := BuyFromAccType::Vendor;
                        GenBusPostGrp := PurchInvLine."Gen. Bus. Posting Group";
                        GenProdPostGrp := PurchInvLine."Gen. Prod. Posting Group";
                        TransType := TransType::Purchase;
                        BuyFromVendCustNo := PurchInvHeader."Actual Vendor No. FND";
                        PostingDate := PurchInvHeader."Posting Date";
                        DocDate := PurchInvHeader."Document Date";
                        CurrencyCode := PurchInvHeader."Currency Code";
                        CurrFactor := PurchInvHeader."Currency Factor";
                        ApplyDocType := PurchInvHeader."Applies-to Doc. Type";
                        ApplyDocNo := PurchInvHeader."Applies-to Doc. No.";
                        SourceCode := PurchInvHeader."Source Code";
                        ReasonCode := PurchInvHeader."Reason Code";

                        if (WHTBusPostGrp <> PurchInvLine."WHT Business Posting Group FND") or
                           (WHTProdPostGrp <> PurchInvLine."WHT Product Posting Group FND")
                        then begin
                            if AmountVAT <> 0 then begin
                                if WHTPostingSetup."Realized WHT Type" in
                                   [WHTPostingSetup."Realized WHT Type"::Earliest,
                                    WHTPostingSetup."Realized WHT Type"::Invoice]
                                then begin
                                    TempPurchLine.Reset();
                                    TempPurchLine.SetCurrentKey("Document Type", "Document No.",
                                      "WHT Business Posting Group FND", "WHT Product Posting Group FND");
                                    TempPurchLine.SetRange("Document Type", TempPurchLine."Document Type"::Order);
                                    TempPurchLine.SetRange("Document No.", PurchInvHeader."Order No.");
                                    TempPurchLine.SetRange("WHT Business Posting Group FND", WHTBusPostGrp);
                                    TempPurchLine.SetRange("WHT Product Posting Group FND", WHTProdPostGrp);
                                    TempPurchLine.CalcSums(TempPurchLine."Prepmt. Amt. Inv.", TempPurchLine."Prepmt Amt to Deduct");
                                    PrepaymentAmtDeducted := TempPurchLine."Prepmt Amt to Deduct";
                                    AmountVAT := AmountVAT - PrepaymentAmtDeducted;
                                end;
                                InsertWHT(TType::Purchase);
                            end;
                            WHTBusPostGrp := PurchInvLine."WHT Business Posting Group FND";
                            WHTProdPostGrp := PurchInvLine."WHT Product Posting Group FND";
                            PurchInvHeader.Amount := 0;
                            AbsorbBase := 0;
                            AmountVAT := 0;
                            PurchInvHeader.Amount := PurchInvHeader.Amount + PurchInvLine.Amount;
                            AbsorbBase := AbsorbBase + PurchInvLine."WHT Absorb Base FND";
                            if AbsorbBase <> 0 then
                                AmountVAT := AbsorbBase
                            else
                                AmountVAT := PurchInvHeader.Amount;
                        end else begin
                            WHTBusPostGrp := PurchInvLine."WHT Business Posting Group FND";
                            WHTProdPostGrp := PurchInvLine."WHT Product Posting Group FND";
                            PurchInvHeader.Amount := PurchInvHeader.Amount + PurchInvLine.Amount;
                            AbsorbBase := AbsorbBase + PurchInvLine."WHT Absorb Base FND";
                            if AbsorbBase <> 0 then
                                AmountVAT := AbsorbBase
                            else
                                AmountVAT := PurchInvHeader.Amount;
                        end;
                        WHTBusPostGrp := PurchInvLine."WHT Business Posting Group FND";
                        WHTProdPostGrp := PurchInvLine."WHT Product Posting Group FND";
                    end;
                TempWHTEntry."Entry No." := PurchInvLine."Line No.";
                TempWHTEntry.Amount := Round(PurchInvLine.Amount * WHTPostingSetup."WHT %" / 100);
                // TempWHTEntry."GL Account No. To Use" := WHTPostingSetup.GetPayableWHTAccount();
                // Prepare to Split GenJrnlLine posting per Purchase Line.
                // TempWHTEntry."Dimension Set ID To Use" := PurchInvLine."Dimension Set ID";
                WHTSingleInstance.InsertTempWHTEntrySI(TempWHTEntry);
            until PurchInvLine.Next() = 0;

        if WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest then begin
            TempPurchLine.Reset();
            TempPurchLine.SetCurrentKey("Document Type", "Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
            TempPurchLine.SetRange("Document Type", TempPurchLine."Document Type"::Order);
            TempPurchLine.SetRange("Document No.", PurchInvHeader."Order No.");
            TempPurchLine.SetRange("WHT Business Posting Group FND", WHTBusPostGrp);
            TempPurchLine.SetRange("WHT Product Posting Group FND", WHTProdPostGrp);
            TempPurchLine.CalcSums(TempPurchLine."Prepmt. Amt. Inv.", TempPurchLine."Prepmt Amt to Deduct");
            PrepaymentAmtDeducted := TempPurchLine."Prepmt Amt to Deduct";
            if AmountVAT <> 0 then
                AmountVAT := AmountVAT - PrepaymentAmtDeducted;
        end;
        InsertWHT(TType::Purchase);
    end;



    // BLocked >>
    /*  procedure InsertVendInvoiceWHT(var PurchInvHeader: Record "Purch. Inv. Header");
     var
         TempPurchLine: Record "Purchase Line";
         VATPostingSetup: Record "VAT Posting Setup";
         PrepaymentAmtDeducted: Decimal;
     begin
         // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
         // with PurchInvHeader do begin
         //     PurchInvLine.RESET();
         //     PurchInvLine.SETCURRENTKEY("Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
         //     PurchInvLine.SETRANGE("Document No.", "No.");
         //     PurchInvLine.SETFILTER(Quantity, '<>0');
         //     if PurchInvLine.findset() then begin
         //         WHTBusPostGrp := PurchInvLine."WHT Business Posting Group FND";
         //         WHTProdPostGrp := PurchInvLine."WHT Product Posting Group FND";
         //         if WHTPostingSetup.GET(PurchInvLine."WHT Business Posting Group FND", PurchInvLine."WHT Product Posting Group FND") then
         //             WHTMinInvoiceAmt := WHTPostingSetup."WHT Minimum Invoice Amount";
         //         repeat
         //             if WHTPostingSetup.GET(PurchInvLine."WHT Business Posting Group FND", PurchInvLine."WHT Product Posting Group FND") then begin
         //                 if (WHTBusPostGrp <> PurchInvLine."WHT Business Posting Group FND") or
         //                    (WHTProdPostGrp <> PurchInvLine."WHT Product Posting Group FND")
         //                 then begin
         //                     if WHTMinInvoiceAmt <> WHTPostingSetup."WHT Minimum Invoice Amount" then
         //                         ERROR(Text1500004);
         //                 end;
         //                 WHTBusPostGrp := PurchInvLine."WHT Business Posting Group FND";
         //                 WHTProdPostGrp := PurchInvLine."WHT Product Posting Group FND";
         //             end;
         //         until PurchInvLine.NEXT() = 0;
         //     end;
         // end;
         PurchInvLine.RESET();
         PurchInvLine.SETCURRENTKEY("Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
         PurchInvLine.SETRANGE("Document No.", PurchInvHeader."No.");
         PurchInvLine.SETFILTER(Quantity, '<>0');
         if PurchInvLine.findset() then begin
             WHTBusPostGrp := PurchInvLine."WHT Business Posting Group FND";
             WHTProdPostGrp := PurchInvLine."WHT Product Posting Group FND";
             if WHTPostingSetup.GET(PurchInvLine."WHT Business Posting Group FND", PurchInvLine."WHT Product Posting Group FND") then
                 WHTMinInvoiceAmt := WHTPostingSetup."WHT Minimum Invoice Amount";
             repeat
                 if WHTPostingSetup.GET(PurchInvLine."WHT Business Posting Group FND", PurchInvLine."WHT Product Posting Group FND") then begin
                     if (WHTBusPostGrp <> PurchInvLine."WHT Business Posting Group FND") or
                         (WHTProdPostGrp <> PurchInvLine."WHT Product Posting Group FND")
                     then begin
                         if WHTMinInvoiceAmt <> WHTPostingSetup."WHT Minimum Invoice Amount" then
                             ERROR(Text1500004);
                     end;
                     WHTBusPostGrp := PurchInvLine."WHT Business Posting Group FND";
                     WHTProdPostGrp := PurchInvLine."WHT Product Posting Group FND";
                 end;
             until PurchInvLine.NEXT() = 0;
         end;
         // BC Upgrade PATELP08 <<
         GLSetup.GET();

         Vendor.GET(PurchInvHeader."Pay-to Vendor No.");
         //  IF (Vendor.ABN <> '') OR Vendor."Foreign Vend" THEN
         //  EXIT;
         TotalInvoiceAmount := 0;
         TotalInvoiceAmountLCY := 0;
         TempPurchInvLine.RESET();
         TempPurchInvLine.SETRANGE("Document No.", PurchInvHeader."No.");
         TempPurchInvLine.SETFILTER(Quantity, '<>0');
         if TempPurchInvLine.findset() then
             repeat
                 if WHTPostingSetup.GET(
                      TempPurchInvLine."WHT Business Posting Group FND",
                      TempPurchInvLine."WHT Product Posting Group FND")
                 then
                     if TempPurchInvLine."WHT Absorb Base FND" <> 0 then
                         TotalInvoiceAmount := TotalInvoiceAmount + TempPurchInvLine."WHT Absorb Base FND"
                     else begin
                         //soicad>>

                         if TempPurchInvLine."VAT Calculation Type" = TempPurchInvLine."VAT Calculation Type"::"Full VAT" then begin
                             VATPostingSetup.GET(TempPurchInvLine."VAT Bus. Posting Group", TempPurchInvLine."VAT Prod. Posting Group");
                             if VATPostingSetup."Top Gross WHT Deductible FND" then
                                 TotalInvoiceAmount := TotalInvoiceAmount + TempPurchInvLine."Amount Including VAT"
                             else
                                 TotalInvoiceAmount := TotalInvoiceAmount + TempPurchInvLine.Amount;
                         end else //soicad<<
                             TotalInvoiceAmount := TotalInvoiceAmount + TempPurchInvLine.Amount;
                     end;
             until TempPurchInvLine.NEXT() = 0;

         if PurchInvHeader."Currency Code" = '' then
             TotalInvoiceAmountLCY := TotalInvoiceAmount
         else
             TotalInvoiceAmountLCY :=
               ROUND(
                 CurrExchRate.ExchangeAmtFCYToLCY(
                   PurchInvHeader."Document Date",
                   PurchInvHeader."Currency Code",
                   TotalInvoiceAmount,
                   PurchInvHeader."Currency Factor"));

         if CheckWHTCalculationRule(TotalInvoiceAmountLCY, WHTPostingSetup) then
             exit;

         // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
         // with PurchInvHeader do begin
         //     PurchInvLine.RESET();
         //     PurchInvLine.SETCURRENTKEY("Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
         //     PurchInvLine.SETRANGE("Document No.", "No.");
         //     PurchInvLine.SETFILTER(Quantity, '<>0');
         //     PurchInvLine.SETRANGE("Prepayment Line", false);
         //     if PurchInvLine.findset() then
         //         repeat
         //             if WHTPostingSetup.GET(PurchInvLine."WHT Business Posting Group FND", PurchInvLine."WHT Product Posting Group FND") then
         //                 if WHTPostingSetup."WHT %" > 0 then begin
         //                     DocNo := PurchInvLine."Document No.";
         //                     DocType := DocType::Invoice;
         //                     PayToAccType := PayToAccType::Vendor;
         //                     PayToVendCustNo := "Pay-to Vendor No.";
         //                     BuyFromAccType := BuyFromAccType::Vendor;
         //                     GenBusPostGrp := PurchInvLine."Gen. Bus. Posting Group";
         //                     GenProdPostGrp := PurchInvLine."Gen. Prod. Posting Group";
         //                     TransType := TransType::Purchase;
         //                     BuyFromVendCustNo := "Actual Vendor No. FND";
         //                     PostingDate := "Posting Date";
         //                     DocDate := "Document Date";
         //                     CurrencyCode := "Currency Code";
         //                     CurrFactor := "Currency Factor";
         //                     ApplyDocType := "Applies-to Doc. Type";
         //                     ApplyDocNo := "Applies-to Doc. No.";
         //                     SourceCode := "Source Code";
         //                     ReasonCode := "Reason Code";
         //                     ExtDocNo := PurchInvHeader."Vendor Invoice No.";

         //                     if (WHTBusPostGrp <> PurchInvLine."WHT Business Posting Group FND") or
         //                        (WHTProdPostGrp <> PurchInvLine."WHT Product Posting Group FND")
         //                     then begin
         //                         if AmountVAT <> 0 then begin
         //                             if WHTPostingSetup."Realized WHT Type" in
         //                                [WHTPostingSetup."Realized WHT Type"::Earliest,
         //                                 WHTPostingSetup."Realized WHT Type"::Invoice]
         //                             then begin
         //                                 TempPurchLine.RESET();
         //                                 TempPurchLine.SETCURRENTKEY("Document Type", "Document No.",
         //                                   "WHT Business Posting Group FND", "WHT Product Posting Group FND");
         //                                 TempPurchLine.SETRANGE("Document Type", TempPurchLine."Document Type"::Order);
         //                                 TempPurchLine.SETRANGE("Document No.", "Order No.");
         //                                 TempPurchLine.SETRANGE("WHT Business Posting Group FND", WHTBusPostGrp);
         //                                 TempPurchLine.SETRANGE("WHT Product Posting Group FND", WHTProdPostGrp);
         //                                 TempPurchLine.CALCSUMS(TempPurchLine."Prepmt. Amt. Inv.", TempPurchLine."Prepmt Amt to Deduct");
         //                                 PrepaymentAmtDeducted := TempPurchLine."Prepmt Amt to Deduct";
         //                                 AmountVAT := AmountVAT - PrepaymentAmtDeducted;
         //                             end;
         //                             InsertWHT(TType::Purchase);
         //                         end;
         //                         WHTBusPostGrp := PurchInvLine."WHT Business Posting Group FND";
         //                         WHTProdPostGrp := PurchInvLine."WHT Product Posting Group FND";
         //                         Amount := 0;
         //                         AbsorbBase := 0;
         //                         AmountVAT := 0;
         //                         //soicad>>
         //                         if PurchInvLine."VAT Calculation Type" = PurchInvLine."VAT Calculation Type"::"Full VAT" then begin
         //                             VATPostingSetup.GET(PurchInvLine."VAT Bus. Posting Group", PurchInvLine."VAT Prod. Posting Group");
         //                             if VATPostingSetup."Top Gross WHT Deductible FND" then
         //                                 Amount := Amount + PurchInvLine."Amount Including VAT"
         //                             else
         //                                 Amount := Amount + PurchInvLine.Amount;
         //                         end else //soicad<<
         //                             Amount := Amount + PurchInvLine.Amount;
         //                         AbsorbBase := AbsorbBase + PurchInvLine."WHT Absorb Base FND";
         //                         if AbsorbBase <> 0 then
         //                             AmountVAT := AbsorbBase
         //                         else
         //                             AmountVAT := Amount;
         //                     end else begin
         //                         WHTBusPostGrp := PurchInvLine."WHT Business Posting Group FND";
         //                         WHTProdPostGrp := PurchInvLine."WHT Product Posting Group FND";
         //                         //soicad>>
         //                         if PurchInvLine."VAT Calculation Type" = PurchInvLine."VAT Calculation Type"::"Full VAT" then begin
         //                             VATPostingSetup.GET(PurchInvLine."VAT Bus. Posting Group", PurchInvLine."VAT Prod. Posting Group");
         //                             if VATPostingSetup."Top Gross WHT Deductible FND" then
         //                                 Amount := Amount + PurchInvLine."Amount Including VAT"
         //                             else
         //                                 Amount := Amount + PurchInvLine.Amount;
         //                         end else //soicad<<
         //                             Amount := Amount + PurchInvLine.Amount;
         //                         AbsorbBase := AbsorbBase + PurchInvLine."WHT Absorb Base FND";
         //                         if AbsorbBase <> 0 then
         //                             AmountVAT := AbsorbBase
         //                         else
         //                             AmountVAT := Amount;
         //                     end;
         //                     WHTBusPostGrp := PurchInvLine."WHT Business Posting Group FND";
         //                     WHTProdPostGrp := PurchInvLine."WHT Product Posting Group FND";
         //                 end;
         //         until PurchInvLine.NEXT() = 0;

         //     if WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest then begin
         //         TempPurchLine.RESET();
         //         TempPurchLine.SETCURRENTKEY("Document Type", "Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
         //         TempPurchLine.SETRANGE("Document Type", TempPurchLine."Document Type"::Order);
         //         TempPurchLine.SETRANGE("Document No.", "Order No.");
         //         TempPurchLine.SETRANGE("WHT Business Posting Group FND", WHTBusPostGrp);
         //         TempPurchLine.SETRANGE("WHT Product Posting Group FND", WHTProdPostGrp);
         //         TempPurchLine.CALCSUMS(TempPurchLine."Prepmt. Amt. Inv.", TempPurchLine."Prepmt Amt to Deduct");
         //         PrepaymentAmtDeducted := TempPurchLine."Prepmt Amt to Deduct";
         //         if AmountVAT <> 0 then
         //             AmountVAT := AmountVAT - PrepaymentAmtDeducted;
         //     end;
         //     InsertWHT(TType::Purchase);
         // end;
         PurchInvLine.RESET();
         PurchInvLine.SETCURRENTKEY("Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
         PurchInvLine.SETRANGE("Document No.", PurchInvHeader."No.");
         PurchInvLine.SETFILTER(Quantity, '<>0');
         PurchInvLine.SETRANGE("Prepayment Line", false);
         if PurchInvLine.findset() then
             repeat
                 if WHTPostingSetup.GET(PurchInvLine."WHT Business Posting Group FND", PurchInvLine."WHT Product Posting Group FND") then
                     if WHTPostingSetup."WHT %" > 0 then begin
                         DocNo := PurchInvLine."Document No.";
                         DocType := DocType::Invoice;
                         PayToAccType := PayToAccType::Vendor;
                         PayToVendCustNo := PurchInvHeader."Pay-to Vendor No.";
                         BuyFromAccType := BuyFromAccType::Vendor;
                         GenBusPostGrp := PurchInvLine."Gen. Bus. Posting Group";
                         GenProdPostGrp := PurchInvLine."Gen. Prod. Posting Group";
                         TransType := TransType::Purchase;
                         BuyFromVendCustNo := PurchInvHeader."Actual Vendor No. FND";
                         PostingDate := PurchInvHeader."Posting Date";
                         DocDate := PurchInvHeader."Document Date";
                         CurrencyCode := PurchInvHeader."Currency Code";
                         CurrFactor := PurchInvHeader."Currency Factor";
                         ApplyDocType := PurchInvHeader."Applies-to Doc. Type";
                         ApplyDocNo := PurchInvHeader."Applies-to Doc. No.";
                         SourceCode := PurchInvHeader."Source Code";
                         ReasonCode := PurchInvHeader."Reason Code";
                         ExtDocNo := PurchInvHeader."Vendor Invoice No.";

                         if (WHTBusPostGrp <> PurchInvLine."WHT Business Posting Group FND") or
                             (WHTProdPostGrp <> PurchInvLine."WHT Product Posting Group FND")
                         then begin
                             if AmountVAT <> 0 then begin
                                 if WHTPostingSetup."Realized WHT Type" in
                                     [WHTPostingSetup."Realized WHT Type"::Earliest,
                                     WHTPostingSetup."Realized WHT Type"::Invoice]
                                 then begin
                                     TempPurchLine.RESET();
                                     TempPurchLine.SETCURRENTKEY("Document Type", "Document No.",
                                         "WHT Business Posting Group FND", "WHT Product Posting Group FND");
                                     TempPurchLine.SETRANGE("Document Type", TempPurchLine."Document Type"::Order);
                                     TempPurchLine.SETRANGE("Document No.", PurchInvHeader."Order No.");
                                     TempPurchLine.SETRANGE("WHT Business Posting Group FND", WHTBusPostGrp);
                                     TempPurchLine.SETRANGE("WHT Product Posting Group FND", WHTProdPostGrp);
                                     TempPurchLine.CALCSUMS(TempPurchLine."Prepmt. Amt. Inv.", TempPurchLine."Prepmt Amt to Deduct");
                                     PrepaymentAmtDeducted := TempPurchLine."Prepmt Amt to Deduct";
                                     AmountVAT := AmountVAT - PrepaymentAmtDeducted;
                                 end;
                                 InsertWHT(TType::Purchase);
                             end;
                             WHTBusPostGrp := PurchInvLine."WHT Business Posting Group FND";
                             WHTProdPostGrp := PurchInvLine."WHT Product Posting Group FND";
                             Amount := 0;
                             AbsorbBase := 0;
                             AmountVAT := 0;
                             //soicad>>
                             if PurchInvLine."VAT Calculation Type" = PurchInvLine."VAT Calculation Type"::"Full VAT" then begin
                                 VATPostingSetup.GET(PurchInvLine."VAT Bus. Posting Group", PurchInvLine."VAT Prod. Posting Group");
                                 if VATPostingSetup."Top Gross WHT Deductible FND" then
                                     Amount := Amount + PurchInvLine."Amount Including VAT"
                                 else
                                     Amount := Amount + PurchInvLine.Amount;
                             end else //soicad<<
                                 Amount := Amount + PurchInvLine.Amount;
                             AbsorbBase := AbsorbBase + PurchInvLine."WHT Absorb Base FND";
                             if AbsorbBase <> 0 then
                                 AmountVAT := AbsorbBase
                             else
                                 AmountVAT := Amount;
                         end else begin
                             WHTBusPostGrp := PurchInvLine."WHT Business Posting Group FND";
                             WHTProdPostGrp := PurchInvLine."WHT Product Posting Group FND";
                             //soicad>>
                             if PurchInvLine."VAT Calculation Type" = PurchInvLine."VAT Calculation Type"::"Full VAT" then begin
                                 VATPostingSetup.GET(PurchInvLine."VAT Bus. Posting Group", PurchInvLine."VAT Prod. Posting Group");
                                 if VATPostingSetup."Top Gross WHT Deductible FND" then
                                     Amount := Amount + PurchInvLine."Amount Including VAT"
                                 else
                                     Amount := Amount + PurchInvLine.Amount;
                             end else //soicad<<
                                 Amount := Amount + PurchInvLine.Amount;
                             AbsorbBase := AbsorbBase + PurchInvLine."WHT Absorb Base FND";
                             if AbsorbBase <> 0 then
                                 AmountVAT := AbsorbBase
                             else
                                 AmountVAT := Amount;
                         end;
                         WHTBusPostGrp := PurchInvLine."WHT Business Posting Group FND";
                         WHTProdPostGrp := PurchInvLine."WHT Product Posting Group FND";
                     end;
             until PurchInvLine.NEXT() = 0;

         if WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest then begin
             TempPurchLine.RESET();
             TempPurchLine.SETCURRENTKEY("Document Type", "Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
             TempPurchLine.SETRANGE("Document Type", TempPurchLine."Document Type"::Order);
             TempPurchLine.SETRANGE("Document No.", PurchInvHeader."Order No.");
             TempPurchLine.SETRANGE("WHT Business Posting Group FND", WHTBusPostGrp);
             TempPurchLine.SETRANGE("WHT Product Posting Group FND", WHTProdPostGrp);
             TempPurchLine.CALCSUMS(TempPurchLine."Prepmt. Amt. Inv.", TempPurchLine."Prepmt Amt to Deduct");
             PrepaymentAmtDeducted := TempPurchLine."Prepmt Amt to Deduct";
             if AmountVAT <> 0 then
                 AmountVAT := AmountVAT - PrepaymentAmtDeducted;
         end;
         InsertWHT(TType::Purchase);
         // BC Upgrade PATELP08 <<
     end; */
    // BLocked <<
    // Blocked >> 
    /*     procedure InsertVendCreditWHT(var PurchCreditHeader: Record "Purch. Cr. Memo Hdr."; AppliesID: Code[20]);
        var
            VATPostingSetup: Record "VAT Posting Setup";
            WHTEntry: Record "WHT Entry FND";
        begin
            // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
            // with PurchCreditHeader do begin
            //     PurchCreditLine.RESET();
            //     PurchCreditLine.SETCURRENTKEY("Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
            //     PurchCreditLine.SETRANGE("Document No.", "No.");
            //     PurchCreditLine.SETFILTER(Quantity, '<>0');
            //     if PurchCreditLine.findset() then begin
            //         WHTBusPostGrp := PurchCreditLine."WHT Business Posting Group FND";
            //         WHTProdPostGrp := PurchCreditLine."WHT Product Posting Group FND";
            //         if WHTPostingSetup.GET(PurchCreditLine."WHT Business Posting Group FND", PurchCreditLine."WHT Product Posting Group FND") then
            //             WHTMinInvoiceAmt := WHTPostingSetup."WHT Minimum Invoice Amount";
            //         repeat
            //             if WHTPostingSetup.GET(PurchCreditLine."WHT Business Posting Group FND", PurchCreditLine."WHT Product Posting Group FND") then begin
            //                 if (WHTBusPostGrp <> PurchCreditLine."WHT Business Posting Group FND") or
            //                    (WHTProdPostGrp <> PurchCreditLine."WHT Product Posting Group FND")
            //                 then begin
            //                     if WHTMinInvoiceAmt <> WHTPostingSetup."WHT Minimum Invoice Amount" then
            //                         ERROR(Text1500004);
            //                 end;
            //                 WHTBusPostGrp := PurchCreditLine."WHT Business Posting Group FND";
            //                 WHTProdPostGrp := PurchCreditLine."WHT Product Posting Group FND";
            //             end;
            //         until PurchCreditLine.NEXT() = 0;
            //     end;
            // end;
            PurchCreditLine.RESET();
            PurchCreditLine.SETCURRENTKEY("Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
            PurchCreditLine.SETRANGE("Document No.", PurchCreditHeader."No.");
            PurchCreditLine.SETFILTER(Quantity, '<>0');
            if PurchCreditLine.findset() then begin
                WHTBusPostGrp := PurchCreditLine."WHT Business Posting Group FND";
                WHTProdPostGrp := PurchCreditLine."WHT Product Posting Group FND";
                if WHTPostingSetup.GET(PurchCreditLine."WHT Business Posting Group FND", PurchCreditLine."WHT Product Posting Group FND") then
                    WHTMinInvoiceAmt := WHTPostingSetup."WHT Minimum Invoice Amount";
                repeat
                    if WHTPostingSetup.GET(PurchCreditLine."WHT Business Posting Group FND", PurchCreditLine."WHT Product Posting Group FND") then begin
                        if (WHTBusPostGrp <> PurchCreditLine."WHT Business Posting Group FND") or
                            (WHTProdPostGrp <> PurchCreditLine."WHT Product Posting Group FND")
                        then begin
                            if WHTMinInvoiceAmt <> WHTPostingSetup."WHT Minimum Invoice Amount" then
                                ERROR(Text1500004);
                        end;
                        WHTBusPostGrp := PurchCreditLine."WHT Business Posting Group FND";
                        WHTProdPostGrp := PurchCreditLine."WHT Product Posting Group FND";
                    end;
                until PurchCreditLine.NEXT() = 0;
            end;
            // BC Upgrade PATELP08 <<
            GLSetup.GET();

            Vendor.GET(PurchCreditHeader."Pay-to Vendor No.");
            // IF (Vendor.ABN <> '') OR Vendor."Foreign Vend" THEN
            // EXIT;
            TotalInvoiceAmount := 0;
            TotalInvoiceAmountLCY := 0;
            TempPurchCreditLine.RESET();
            TempPurchCreditLine.SETRANGE("Document No.", PurchCreditHeader."No.");
            TempPurchCreditLine.SETFILTER(Quantity, '<>0');
            if TempPurchCreditLine.findset() then
                repeat
                    if WHTPostingSetup.GET(
                         TempPurchCreditLine."WHT Business Posting Group FND",
                         TempPurchCreditLine."WHT Product Posting Group FND")
                    then
                        if TempPurchCreditLine."WHT Absorb Base FND" <> 0 then
                            TotalInvoiceAmount := TotalInvoiceAmount + TempPurchCreditLine."WHT Absorb Base FND"
                        else begin
                            //soicad>>
                            if TempPurchCreditLine."VAT Calculation Type" = TempPurchCreditLine."VAT Calculation Type"::"Full VAT" then begin
                                VATPostingSetup.GET(TempPurchCreditLine."VAT Bus. Posting Group", TempPurchCreditLine."VAT Prod. Posting Group");
                                if VATPostingSetup."Top Gross WHT Deductible FND" then
                                    TotalInvoiceAmount := TotalInvoiceAmount + TempPurchCreditLine."Amount Including VAT"
                                else
                                    TotalInvoiceAmount := TotalInvoiceAmount + TempPurchCreditLine.Amount;
                            end else //soicad<<
                                TotalInvoiceAmount := TotalInvoiceAmount + TempPurchCreditLine.Amount;
                        end;
                until TempPurchCreditLine.NEXT() = 0;

            if PurchCreditHeader."Currency Code" = '' then
                TotalInvoiceAmountLCY := TotalInvoiceAmount
            else
                TotalInvoiceAmountLCY :=
                  ROUND(
                    CurrExchRate.ExchangeAmtFCYToLCY(
                      PurchCreditHeader."Document Date",
                      PurchCreditHeader."Currency Code",
                      TotalInvoiceAmount,
                      PurchCreditHeader."Currency Factor"));

            TempVendLedgEntry.RESET();
            if ((PurchCreditHeader."Applies-to Doc. Type" = PurchCreditHeader."Applies-to Doc. Type"::Invoice) and
                (PurchCreditHeader."Applies-to Doc. No." <> ''))
            then
                TempVendLedgEntry.SETRANGE("Document No.", PurchCreditHeader."Applies-to Doc. No.")
            else
                if AppliesID <> '' then
                    TempVendLedgEntry.SETRANGE("Applies-to ID", AppliesID);

            if TempVendLedgEntry.GETFILTERS <> '' then begin
                if TempVendLedgEntry.findset() then begin
                    WHTEntry.RESET();
                    WHTEntry.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
                    WHTEntry.SETRANGE("Document No.", TempVendLedgEntry."Document No.");
                    if not WHTEntry.FINDFIRST() then
                        if CheckWHTCalculationRule(TotalInvoiceAmountLCY, WHTPostingSetup) then
                            exit;
                end;
            end else
                if CheckWHTCalculationRule(TotalInvoiceAmountLCY, WHTPostingSetup) then
                    exit;

            // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
            // with PurchCreditHeader do begin
            //     PurchCreditLine.RESET();
            //     PurchCreditLine.SETCURRENTKEY("Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
            //     PurchCreditLine.SETRANGE("Document No.", "No.");
            //     PurchCreditLine.SETFILTER(Quantity, '<>0');
            //     if PurchCreditLine.findset() then
            //         repeat
            //             if WHTPostingSetup.GET(PurchCreditLine."WHT Business Posting Group FND", PurchCreditLine."WHT Product Posting Group FND") then
            //                 if WHTPostingSetup."WHT %" > 0 then begin
            //                     DocNo := PurchCreditLine."Document No.";
            //                     DocType := DocType::"Credit Memo";
            //                     PayToAccType := PayToAccType::Vendor;
            //                     PayToVendCustNo := "Pay-to Vendor No.";
            //                     BuyFromAccType := BuyFromAccType::Vendor;
            //                     GenBusPostGrp := PurchCreditLine."Gen. Bus. Posting Group";
            //                     GenProdPostGrp := PurchCreditLine."Gen. Prod. Posting Group";
            //                     TransType := TransType::Purchase;
            //                     BuyFromVendCustNo := "Actual Vendor No. FND";
            //                     PostingDate := "Posting Date";
            //                     DocDate := "Document Date";
            //                     CurrencyCode := "Currency Code";
            //                     CurrFactor := "Currency Factor";
            //                     ApplyDocType := "Applies-to Doc. Type";
            //                     ApplyDocNo := "Applies-to Doc. No.";
            //                     "Applies-toID" := AppliesID;
            //                     SourceCode := "Source Code";
            //                     ReasonCode := "Reason Code";
            //                     if (WHTBusPostGrp <> PurchCreditLine."WHT Business Posting Group FND") or
            //                        (WHTProdPostGrp <> PurchCreditLine."WHT Product Posting Group FND")
            //                     then begin
            //                         if AmountVAT <> 0 then
            //                             InsertWHT(TType::Purchase);
            //                         WHTBusPostGrp := PurchCreditLine."WHT Business Posting Group FND";
            //                         WHTProdPostGrp := PurchCreditLine."WHT Product Posting Group FND";
            //                         Amount := 0;
            //                         AbsorbBase := 0;
            //                         AmountVAT := 0;

            //                         //soicad>>
            //                         if PurchCreditLine."VAT Calculation Type" = PurchCreditLine."VAT Calculation Type"::"Full VAT" then begin
            //                             VATPostingSetup.GET(PurchCreditLine."VAT Bus. Posting Group", PurchCreditLine."VAT Prod. Posting Group");
            //                             if VATPostingSetup."Top Gross WHT Deductible FND" then
            //                                 Amount := Amount + PurchCreditLine."Amount Including VAT"
            //                             else
            //                                 Amount := Amount + PurchCreditLine.Amount;
            //                         end else//soicad<<
            //                             Amount := Amount + PurchCreditLine.Amount;
            //                         AbsorbBase := AbsorbBase + PurchCreditLine."WHT Absorb Base FND";
            //                         if AbsorbBase <> 0 then
            //                             AmountVAT := -AbsorbBase
            //                         else
            //                             AmountVAT := -Amount;
            //                     end else begin
            //                         WHTBusPostGrp := PurchCreditLine."WHT Business Posting Group FND";
            //                         WHTProdPostGrp := PurchCreditLine."WHT Product Posting Group FND";

            //                         //soicad>>
            //                         if PurchCreditLine."VAT Calculation Type" = PurchCreditLine."VAT Calculation Type"::"Full VAT" then begin
            //                             VATPostingSetup.GET(PurchCreditLine."VAT Bus. Posting Group", PurchCreditLine."VAT Prod. Posting Group");
            //                             if VATPostingSetup."Top Gross WHT Deductible FND" then
            //                                 Amount := Amount + PurchCreditLine."Amount Including VAT"
            //                             else
            //                                 Amount := Amount + PurchCreditLine.Amount;
            //                         end else//soicad<<
            //                             Amount := Amount + PurchCreditLine.Amount;
            //                         AbsorbBase := AbsorbBase + PurchCreditLine."WHT Absorb Base FND";
            //                         if AbsorbBase <> 0 then
            //                             AmountVAT := -AbsorbBase
            //                         else
            //                             AmountVAT := -Amount;
            //                     end;
            //                     WHTBusPostGrp := PurchCreditLine."WHT Business Posting Group FND";
            //                     WHTProdPostGrp := PurchCreditLine."WHT Product Posting Group FND";
            //                 end;
            //         until PurchCreditLine.NEXT() = 0;
            //     InsertWHT(TType::Purchase);
            // end;
            PurchCreditLine.RESET();
            PurchCreditLine.SETCURRENTKEY("Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
            PurchCreditLine.SETRANGE("Document No.", PurchCreditHeader."No.");
            PurchCreditLine.SETFILTER(Quantity, '<>0');
            if PurchCreditLine.findset() then
                repeat
                    if WHTPostingSetup.GET(PurchCreditLine."WHT Business Posting Group FND", PurchCreditLine."WHT Product Posting Group FND") then
                        if WHTPostingSetup."WHT %" > 0 then begin
                            DocNo := PurchCreditLine."Document No.";
                            DocType := DocType::"Credit Memo";
                            PayToAccType := PayToAccType::Vendor;
                            PayToVendCustNo := PurchCreditHeader."Pay-to Vendor No.";
                            BuyFromAccType := BuyFromAccType::Vendor;
                            GenBusPostGrp := PurchCreditLine."Gen. Bus. Posting Group";
                            GenProdPostGrp := PurchCreditLine."Gen. Prod. Posting Group";
                            TransType := TransType::Purchase;
                            BuyFromVendCustNo := PurchCreditHeader."Actual Vendor No. FND";
                            PostingDate := PurchCreditHeader."Posting Date";
                            DocDate := PurchCreditHeader."Document Date";
                            CurrencyCode := PurchCreditHeader."Currency Code";
                            CurrFactor := PurchCreditHeader."Currency Factor";
                            ApplyDocType := PurchCreditHeader."Applies-to Doc. Type";
                            ApplyDocNo := PurchCreditHeader."Applies-to Doc. No.";
                            "Applies-toID" := AppliesID;
                            SourceCode := PurchCreditHeader."Source Code";
                            ReasonCode := PurchCreditHeader."Reason Code";
                            if (WHTBusPostGrp <> PurchCreditLine."WHT Business Posting Group FND") or
                                (WHTProdPostGrp <> PurchCreditLine."WHT Product Posting Group FND")
                            then begin
                                if AmountVAT <> 0 then
                                    InsertWHT(TType::Purchase);
                                WHTBusPostGrp := PurchCreditLine."WHT Business Posting Group FND";
                                WHTProdPostGrp := PurchCreditLine."WHT Product Posting Group FND";
                                Amount := 0;
                                AbsorbBase := 0;
                                AmountVAT := 0;

                                //soicad>>
                                if PurchCreditLine."VAT Calculation Type" = PurchCreditLine."VAT Calculation Type"::"Full VAT" then begin
                                    VATPostingSetup.GET(PurchCreditLine."VAT Bus. Posting Group", PurchCreditLine."VAT Prod. Posting Group");
                                    if VATPostingSetup."Top Gross WHT Deductible FND" then
                                        Amount := Amount + PurchCreditLine."Amount Including VAT"
                                    else
                                        Amount := Amount + PurchCreditLine.Amount;
                                end else//soicad<<
                                    Amount := Amount + PurchCreditLine.Amount;
                                AbsorbBase := AbsorbBase + PurchCreditLine."WHT Absorb Base FND";
                                if AbsorbBase <> 0 then
                                    AmountVAT := -AbsorbBase
                                else
                                    AmountVAT := -Amount;
                            end else begin
                                WHTBusPostGrp := PurchCreditLine."WHT Business Posting Group FND";
                                WHTProdPostGrp := PurchCreditLine."WHT Product Posting Group FND";

                                //soicad>>
                                if PurchCreditLine."VAT Calculation Type" = PurchCreditLine."VAT Calculation Type"::"Full VAT" then begin
                                    VATPostingSetup.GET(PurchCreditLine."VAT Bus. Posting Group", PurchCreditLine."VAT Prod. Posting Group");
                                    if VATPostingSetup."Top Gross WHT Deductible FND" then
                                        Amount := Amount + PurchCreditLine."Amount Including VAT"
                                    else
                                        Amount := Amount + PurchCreditLine.Amount;
                                end else//soicad<<
                                    Amount := Amount + PurchCreditLine.Amount;
                                AbsorbBase := AbsorbBase + PurchCreditLine."WHT Absorb Base FND";
                                if AbsorbBase <> 0 then
                                    AmountVAT := -AbsorbBase
                                else
                                    AmountVAT := -Amount;
                            end;
                            WHTBusPostGrp := PurchCreditLine."WHT Business Posting Group FND";
                            WHTProdPostGrp := PurchCreditLine."WHT Product Posting Group FND";
                        end;
                until PurchCreditLine.NEXT() = 0;
            InsertWHT(TType::Purchase);
            //BC Upgrade PATELP08 <<
        end; */
    // Blocked <<
    procedure InsertVendCreditWHT(var PurchCreditHeader: Record "Purch. Cr. Memo Hdr."; AppliesID: Code[20])
    var
        GenPostingSetup: Record "General Posting Setup";
        TempWHTEntry: Record "WHT Entry FND" temporary;
        WHTSingleInstance: Codeunit "Post WHT Single Instance FND";
    begin
        PurchCreditLine.Reset();
        PurchCreditLine.SetCurrentKey("Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
        PurchCreditLine.SetRange("Document No.", PurchCreditHeader."No.");
        PurchCreditLine.SetFilter(Quantity, '<>0');
        if PurchCreditLine.FindSet() then begin
            WHTBusPostGrp := PurchCreditLine."WHT Business Posting Group FND";
            WHTProdPostGrp := PurchCreditLine."WHT Product Posting Group FND";
            if WHTPostingSetup.Get(PurchCreditLine."WHT Business Posting Group FND", PurchCreditLine."WHT Product Posting Group FND") then
                WHTMinInvoiceAmt := WHTPostingSetup."WHT Minimum Invoice Amount";
            repeat
                if WHTPostingSetup.Get(PurchCreditLine."WHT Business Posting Group FND", PurchCreditLine."WHT Product Posting Group FND") then begin
                    if (WHTBusPostGrp <> PurchCreditLine."WHT Business Posting Group FND") or
                       (WHTProdPostGrp <> PurchCreditLine."WHT Product Posting Group FND")
                    then
                        if WHTMinInvoiceAmt <> WHTPostingSetup."WHT Minimum Invoice Amount" then
                            Error(Text1500004);
                    WHTBusPostGrp := PurchCreditLine."WHT Business Posting Group FND";
                    WHTProdPostGrp := PurchCreditLine."WHT Product Posting Group FND";
                end;
            until PurchCreditLine.Next() = 0;
        end;

        GLSetup.Get();
        PurchCreditLine.Reset();
        PurchCreditLine.SetCurrentKey("Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
        PurchCreditLine.SetRange("Document No.", PurchCreditHeader."No.");
        PurchCreditLine.SetFilter(Quantity, '<>0');
        if PurchCreditLine.FindSet() then
            repeat
                if WHTPostingSetup.Get(PurchCreditLine."WHT Business Posting Group FND", PurchCreditLine."WHT Product Posting Group FND") then
                    if WHTPostingSetup."WHT %" > 0 then begin
                        DocNo := PurchCreditLine."Document No.";
                        DocType := DocType::"Credit Memo";
                        PayToAccType := PayToAccType::Vendor;
                        PayToVendCustNo := PurchCreditHeader."Pay-to Vendor No.";
                        BuyFromAccType := BuyFromAccType::Vendor;
                        GenBusPostGrp := PurchCreditLine."Gen. Bus. Posting Group";
                        GenProdPostGrp := PurchCreditLine."Gen. Prod. Posting Group";
                        TransType := TransType::Purchase;
                        BuyFromVendCustNo := PurchCreditHeader."Actual Vendor No. FND";
                        PostingDate := PurchCreditHeader."Posting Date";
                        DocDate := PurchCreditHeader."Document Date";
                        CurrencyCode := PurchCreditHeader."Currency Code";
                        CurrFactor := PurchCreditHeader."Currency Factor";
                        ApplyDocType := PurchCreditHeader."Applies-to Doc. Type";
                        ApplyDocNo := PurchCreditHeader."Applies-to Doc. No.";
                        "Applies-toID" := AppliesID;
                        SourceCode := PurchCreditHeader."Source Code";
                        ReasonCode := PurchCreditHeader."Reason Code";
                        if (WHTBusPostGrp <> PurchCreditLine."WHT Business Posting Group FND") or
                           (WHTProdPostGrp <> PurchCreditLine."WHT Product Posting Group FND")
                        then begin
                            if AmountVAT <> 0 then
                                InsertWHT(TType::Purchase);
                            WHTBusPostGrp := PurchCreditLine."WHT Business Posting Group FND";
                            WHTProdPostGrp := PurchCreditLine."WHT Product Posting Group FND";
                            PurchCreditHeader.Amount := 0;
                            AbsorbBase := 0;
                            AmountVAT := 0;
                            PurchCreditHeader.Amount := PurchCreditHeader.Amount + PurchCreditLine.Amount;
                            AbsorbBase := AbsorbBase + PurchCreditLine."WHT Absorb Base FND";
                            if AbsorbBase <> 0 then
                                AmountVAT := -AbsorbBase
                            else
                                AmountVAT := -PurchCreditHeader.Amount;
                        end else begin
                            WHTBusPostGrp := PurchCreditLine."WHT Business Posting Group FND";
                            WHTProdPostGrp := PurchCreditLine."WHT Product Posting Group FND";
                            PurchCreditHeader.Amount := PurchCreditHeader.Amount + PurchCreditLine.Amount;
                            AbsorbBase := AbsorbBase + PurchCreditLine."WHT Absorb Base FND";
                            if AbsorbBase <> 0 then
                                AmountVAT := -AbsorbBase
                            else
                                AmountVAT := -PurchCreditHeader.Amount;
                        end;
                        WHTBusPostGrp := PurchCreditLine."WHT Business Posting Group FND";
                        WHTProdPostGrp := PurchCreditLine."WHT Product Posting Group FND";
                    end;
                TempWHTEntry."Entry No." := PurchCreditLine."Line No.";
                TempWHTEntry.Amount := Round(PurchCreditLine.Amount * WHTPostingSetup."WHT %" / 100);

                // if WHTPostingSetup."WHT Expense" then begin
                //     TempWHTEntry."GL Account No. To Use" := WHTPostingSetup.GetWHTExpenseAccount();
                //     if TempWHTEntry."GL Account No. To Use" = '' then
                //         case PurchCreditLine.Type of
                //             PurchCreditLine.Type::"G/L Account":
                //                 TempWHTEntry."GL Account No. To Use" := PurchCreditLine."No.";
                //             PurchCreditLine.Type::Item, PurchCreditLine.Type::"Fixed Asset":
                //                 begin
                //                     GenPostingSetup.Get(PurchCreditLine."Gen. Bus. Posting Group", PurchCreditLine."Gen. Prod. Posting Group");
                //                     TempWHTEntry."GL Account No. To Use" := GenPostingSetup.GetPurchAccount();
                //                 end;
                //         end;
                // end else
                // TempWHTEntry."GL Account No. To Use" := WHTPostingSetup.GetPayableWHTAccount();
                // Prepare to Split GenJrnlLine posting per Purchase Line.
                // TempWHTEntry. := PurchCreditLine."Dimension Set ID";
                WHTSingleInstance.InsertTempWHTEntrySI(TempWHTEntry);
            until PurchCreditLine.Next() = 0;
        InsertWHT(TType::Purchase);
    end;

    procedure InsertCustInvoiceWHT(var SalesInvHeader: Record "Sales Invoice Header");
    begin
        // with SalesInvHeader do begin
        //     SalesInvLine.RESET;
        //     SalesInvLine.SETCURRENTKEY("Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
        //     SalesInvLine.SETRANGE("Document No.", "No.");
        //     SalesInvLine.SETFILTER(Quantity, '<>0');
        //     if SalesInvLine.findset then begin
        //         WHTBusPostGrp := SalesInvLine."WHT Business Posting Group FND";
        //         WHTProdPostGrp := SalesInvLine."WHT Product Posting Group FND";
        //         if WHTPostingSetup.GET(SalesInvLine."WHT Business Posting Group FND", SalesInvLine."WHT Product Posting Group FND") then
        //             WHTMinInvoiceAmt := WHTPostingSetup."WHT Minimum Invoice Amount";
        //         repeat
        //             if WHTPostingSetup.GET(SalesInvLine."WHT Business Posting Group FND", SalesInvLine."WHT Product Posting Group FND") then begin
        //                 if (WHTBusPostGrp <> SalesInvLine."WHT Business Posting Group FND") or
        //                    (WHTProdPostGrp <> SalesInvLine."WHT Product Posting Group FND")
        //                 then begin
        //                     if WHTMinInvoiceAmt <> WHTPostingSetup."WHT Minimum Invoice Amount" then
        //                         ERROR(Text1500004);
        //                 end;
        //                 WHTBusPostGrp := SalesInvLine."WHT Business Posting Group FND";
        //                 WHTProdPostGrp := SalesInvLine."WHT Product Posting Group FND";
        //             end;
        //         until SalesInvLine.NEXT = 0;
        //     end;
        // end;

        // with SalesInvHeader do begin
        //     SalesInvLine.RESET;
        //     SalesInvLine.SETCURRENTKEY("Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
        //     SalesInvLine.SETRANGE("Document No.", "No.");
        //     SalesInvLine.SETFILTER(Quantity, '<>0');
        //     SalesInvLine.SETRANGE("Prepayment Line", false);
        //     if SalesInvLine.findset then
        //         repeat
        //             if WHTPostingSetup.GET(SalesInvLine."WHT Business Posting Group FND", SalesInvLine."WHT Product Posting Group FND") then
        //                 if WHTPostingSetup."WHT %" > 0 then begin
        //                     DocNo := SalesInvLine."Document No.";
        //                     DocType := DocType::Invoice;
        //                     PayToAccType := PayToAccType::Customer;
        //                     PayToVendCustNo := "Bill-to Customer No.";
        //                     BuyFromAccType := BuyFromAccType::Customer;
        //                     BuyFromVendCustNo := "Sell-to Customer No.";
        //                     SourceCode := "Source Code";
        //                     ReasonCode := "Reason Code";
        //                     GenBusPostGrp := SalesInvLine."Gen. Bus. Posting Group";
        //                     GenProdPostGrp := SalesInvLine."Gen. Prod. Posting Group";
        //                     TransType := TransType::Sale;
        //                     PostingDate := "Posting Date";
        //                     DocDate := "Document Date";
        //                     CurrencyCode := "Currency Code";
        //                     CurrFactor := "Currency Factor";
        //                     ApplyDocType := "Applies-to Doc. Type";
        //                     ApplyDocNo := "Applies-to Doc. No.";
        //                     if (WHTBusPostGrp <> SalesInvLine."WHT Business Posting Group FND") or
        //                        (WHTProdPostGrp <> SalesInvLine."WHT Product Posting Group FND")
        //                     then begin
        //                         if AmountVAT <> 0 then
        //                             InsertWHT(TType::Sale);
        //                         WHTBusPostGrp := SalesInvLine."WHT Business Posting Group FND";
        //                         WHTProdPostGrp := SalesInvLine."WHT Product Posting Group FND";
        //                         Amount := 0;
        //                         AbsorbBase := 0;
        //                         AmountVAT := 0;
        //                         Amount := Amount - SalesInvLine.Amount;
        //                         AbsorbBase := AbsorbBase - SalesInvLine."WHT Absorb Base FND";
        //                         if AbsorbBase <> 0 then
        //                             AmountVAT := AbsorbBase
        //                         else
        //                             AmountVAT := Amount;
        //                     end else begin
        //                         WHTBusPostGrp := SalesInvLine."WHT Business Posting Group FND";
        //                         WHTProdPostGrp := SalesInvLine."WHT Product Posting Group FND";
        //                         Amount := Amount - SalesInvLine.Amount;
        //                         AbsorbBase := AbsorbBase - SalesInvLine."WHT Absorb Base FND";
        //                         if AbsorbBase <> 0 then
        //                             AmountVAT := AbsorbBase
        //                         else
        //                             AmountVAT := Amount;
        //                     end;
        //                     WHTBusPostGrp := SalesInvLine."WHT Business Posting Group FND";
        //                     WHTProdPostGrp := SalesInvLine."WHT Product Posting Group FND";
        //                 end;
        //         until SalesInvLine.NEXT = 0;
        //     InsertWHT(TType::Sale);
        // end;  // BC Upgrade NANDIS03 - Temporary blocked for compilation
    end;

    procedure InsertCustCreditWHT(var SalesCreditHeader: Record "Sales Cr.Memo Header"; AppliesID: Code[20]);
    begin
        // with SalesCreditHeader do begin
        //     SalesCreditLine.RESET;
        //     SalesCreditLine.SETCURRENTKEY("Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
        //     SalesCreditLine.SETRANGE("Document No.", "No.");
        //     SalesCreditLine.SETFILTER(Quantity, '<>0');
        //     if SalesCreditLine.findset then begin
        //         WHTBusPostGrp := SalesCreditLine."WHT Business Posting Group FND";
        //         WHTProdPostGrp := SalesCreditLine."WHT Product Posting Group FND";
        //         if WHTPostingSetup.GET(SalesCreditLine."WHT Business Posting Group FND", SalesCreditLine."WHT Product Posting Group FND") then
        //             WHTMinInvoiceAmt := WHTPostingSetup."WHT Minimum Invoice Amount";
        //         repeat
        //             if WHTPostingSetup.GET(SalesCreditLine."WHT Business Posting Group FND", SalesCreditLine."WHT Product Posting Group FND") then begin
        //                 if (WHTBusPostGrp <> SalesCreditLine."WHT Business Posting Group FND") or
        //                    (WHTProdPostGrp <> SalesCreditLine."WHT Product Posting Group FND")
        //                 then begin
        //                     if WHTMinInvoiceAmt <> WHTPostingSetup."WHT Minimum Invoice Amount" then
        //                         ERROR(Text1500004);
        //                 end;
        //                 WHTBusPostGrp := SalesCreditLine."WHT Business Posting Group FND";
        //                 WHTProdPostGrp := SalesCreditLine."WHT Product Posting Group FND";
        //             end;
        //         until SalesCreditLine.NEXT = 0;
        //     end;
        // end;

        // with SalesCreditHeader do begin
        //     SalesCreditLine.RESET;
        //     SalesCreditLine.SETCURRENTKEY("Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
        //     SalesCreditLine.SETRANGE("Document No.", "No.");
        //     SalesCreditLine.SETFILTER(Quantity, '<>0');
        //     if SalesCreditLine.findset then
        //         repeat
        //             if WHTPostingSetup.GET(SalesCreditLine."WHT Business Posting Group FND", SalesCreditLine."WHT Product Posting Group FND") then
        //                 if WHTPostingSetup."WHT %" > 0 then begin
        //                     DocNo := SalesCreditLine."Document No.";
        //                     DocType := DocType::"Credit Memo";
        //                     PayToAccType := PayToAccType::Customer;
        //                     PayToVendCustNo := "Bill-to Customer No.";
        //                     BuyFromAccType := BuyFromAccType::Customer;
        //                     BuyFromVendCustNo := "Sell-to Customer No.";
        //                     SourceCode := "Source Code";
        //                     ReasonCode := "Reason Code";
        //                     GenBusPostGrp := SalesCreditLine."Gen. Bus. Posting Group";
        //                     GenProdPostGrp := SalesCreditLine."Gen. Prod. Posting Group";
        //                     TransType := TransType::Sale;
        //                     PostingDate := "Posting Date";
        //                     DocDate := "Document Date";
        //                     CurrencyCode := "Currency Code";
        //                     CurrFactor := "Currency Factor";
        //                     ApplyDocType := "Applies-to Doc. Type";
        //                     ApplyDocNo := "Applies-to Doc. No.";
        //                     "Applies-toID" := AppliesID;
        //                     if (WHTBusPostGrp <> SalesCreditLine."WHT Business Posting Group FND") or
        //                        (WHTProdPostGrp <> SalesCreditLine."WHT Product Posting Group FND")
        //                     then begin
        //                         if AmountVAT <> 0 then
        //                             InsertWHT(TType::Sale);
        //                         WHTBusPostGrp := SalesCreditLine."WHT Business Posting Group FND";
        //                         WHTProdPostGrp := SalesCreditLine."WHT Product Posting Group FND";
        //                         Amount := 0;
        //                         AbsorbBase := 0;
        //                         AmountVAT := 0;
        //                         Amount := Amount - SalesCreditLine.Amount;
        //                         AbsorbBase := AbsorbBase - SalesCreditLine."WHT Absorb Base FND";
        //                         if AbsorbBase <> 0 then
        //                             AmountVAT := -AbsorbBase
        //                         else
        //                             AmountVAT := -Amount;
        //                     end else begin
        //                         WHTBusPostGrp := SalesCreditLine."WHT Business Posting Group FND";
        //                         WHTProdPostGrp := SalesCreditLine."WHT Product Posting Group FND";
        //                         Amount := Amount - SalesCreditLine.Amount;
        //                         AbsorbBase := AbsorbBase - SalesCreditLine."WHT Absorb Base FND";
        //                         if AbsorbBase <> 0 then
        //                             AmountVAT := -AbsorbBase
        //                         else
        //                             AmountVAT := -Amount;
        //                     end;
        //                     WHTBusPostGrp := SalesCreditLine."WHT Business Posting Group FND";
        //                     WHTProdPostGrp := SalesCreditLine."WHT Product Posting Group FND";
        //                 end;
        //         until SalesCreditLine.NEXT = 0;
        //     InsertWHT(TType::Sale);
        // end;  // BC Upgrade NANDIS03 - Temporary blocked for compilation
    end;

    procedure ProcessPayment(var GenJnlLine: Record "Gen. Journal Line"; TransactionNo: Integer; EntryNo: Integer; Source: Option Vendor,Customer; AmountWithDisc: Boolean) PaymentNo: Integer;
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntry1: Record "Cust. Ledger Entry";
        Customer: Record Customer;
        TempGenJnlTemp: Record "Gen. Journal Template";
        GLSetup: Record "General Ledger Setup";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        TempWHT: Record "Temp WHT Entry FND";
        VendLedgEntry: Record "Vendor Ledger Entry";
        VendLedgEntry1: Record "Vendor Ledger Entry";
        WHTEntry: Record "WHT Entry FND";
        WHTEntry2: Record "WHT Entry FND";
        WHTEntry3: Record "WHT Entry FND";
        WHTEntry4: Record "WHT Entry FND";
        WHTEntryTemp: Record "WHT Entry FND";
        AppldAmount: Decimal;
        ExpectedAmount: Decimal;
        PaymentAmount: Decimal;
        PaymentAmount1: Decimal;
    begin
        GLSetup.GET();

        if GenJnlLine."Bill-to/Pay-to No." = '' then begin
            //HEI.01>>
            if Source = Source::Customer then
                Customer.GET(GenJnlLine."Account No.")
            else if Source = Source::Vendor then
                Vendor.GET(GenJnlLine."Account No.");
            //HEI.01<<
            // IF (Vendor.ABN <> '') OR Vendor."Foreign Vend" THEN
            // EXIT;
        end else begin
            //HEI.01>>
            if Source = Source::Customer then
                Customer.GET(GenJnlLine."Bill-to/Pay-to No.")
            else if Source = Source::Vendor then
                Vendor.GET(GenJnlLine."Bill-to/Pay-to No.");
            //HEI.01<<
            // IF (Vendor.ABN <> '') OR Vendor."Foreign Vend" THEN
            // EXIT;
        end;

        case Source of
            Source::Customer:
                begin
                    WHTEntry4.RESET();
                    WHTEntry4.SETCURRENTKEY("Document Type", "Document No.");
                    WHTEntry4.SETRANGE("Document Type", TempCustLedgEntry."Document Type");
                    WHTEntry4.SETFILTER("Document No.", TempCustLedgEntry."Document No.");
                    if WHTEntry4.FINDFIRST() then begin
                        if ABS(GenJnlLine.Amount) < ABS(TempCustLedgEntry.Amount) then
                            PaymentAmount1 := GenJnlLine.Amount
                        else
                            PaymentAmount1 := -TempCustLedgEntry.Amount;
                        if CheckPmtDisc(
                          GenJnlLine."Posting Date",
                          TempCustLedgEntry."Pmt. Discount Date", ABS(TempCustLedgEntry."Amount to Apply"),
                          ABS(TempCustLedgEntry."Remaining Amount"), ABS(TempCustLedgEntry."Original Pmt. Disc. Possible"),
                          ABS(PaymentAmount1))
                        then
                            PaymentAmount1 := PaymentAmount1 - TempCustLedgEntry."Original Pmt. Disc. Possible";
                    end else
                        if (TempCustLedgEntry."Document No." = '') and (GenJnlLine.Amount <> 0) then
                            PaymentAmount1 := GenJnlLine.Amount;
                end;
            Source::Vendor:
                begin
                    WHTEntry4.RESET();
                    WHTEntry4.SETCURRENTKEY("Document Type", "Document No.");
                    WHTEntry4.SETRANGE("Document Type", TempVendLedgEntry."Document Type");
                    WHTEntry4.SETFILTER("Document No.", TempVendLedgEntry."Document No.");
                    if WHTEntry4.FINDFIRST() then begin
                        if ABS(GenJnlLine.Amount) < ABS(TempVendLedgEntry.Amount) then
                            PaymentAmount1 := GenJnlLine.Amount
                        else
                            PaymentAmount1 := -TempVendLedgEntry.Amount;
                        if CheckPmtDisc(
                          GenJnlLine."Posting Date",
                          TempVendLedgEntry."Pmt. Discount Date", ABS(TempVendLedgEntry."Amount to Apply"),
                          ABS(TempVendLedgEntry."Remaining Amount"), ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"),
                          ABS(PaymentAmount1))
                        then
                            PaymentAmount1 := PaymentAmount1 - TempVendLedgEntry."Original Pmt. Disc. Possible"; //xxx
                    end else
                        if (TempVendLedgEntry."Document No." = '') and (GenJnlLine.Amount <> 0) then
                            PaymentAmount1 := GenJnlLine.Amount;
                end;
        end;

        WHTEntry.RESET();
        WHTEntry.SETCURRENTKEY("Transaction Type", "Document No.", "Document Type", "Bill-to/Pay-to No.");
        if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::Invoice then
            WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::Invoice);
        if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::"Credit Memo" then
            WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");
        case Source of
            Source::Vendor:
                WHTEntry.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
            Source::Customer:
                WHTEntry.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Sale);
        end;

        WHTEntry.SETRANGE(Closed, false);
        WHTEntry.SETRANGE("Transaction No.", 0);
        if GenJnlLine."Applies-to Doc. No." <> '' then
            WHTEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.")
        else
            WHTEntry.SETRANGE("Bill-to/Pay-to No.", GenJnlLine."Account No.");
        if WHTEntry.findset() then
            repeat
                WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                if (WHTPostingSetup."Realized WHT Type" =
                    WHTPostingSetup."Realized WHT Type"::Payment)
                then begin
                    WHTEntry3.RESET();
                    WHTEntry3 := WHTEntry;
                    case Source of
                        Source::Vendor:
                            begin
                                if GenJnlLine."Applies-to Doc. No." = '' then
                                    exit;
                                PurchCrMemoHeader.RESET();
                                PurchCrMemoHeader.SETRANGE("Applies-to Doc. No.", GenJnlLine."Applies-to Doc. No.");
                                PurchCrMemoHeader.SETRANGE("Applies-to Doc. Type", PurchCrMemoHeader."Applies-to Doc. Type"::Invoice);
                                if PurchCrMemoHeader.FINDFIRST() then begin
                                    TempRemAmt := 0;
                                    VendLedgEntry1.RESET();
                                    VendLedgEntry1.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                                    VendLedgEntry1.SETRANGE("Document Type", VendLedgEntry1."Document Type"::"Credit Memo");
                                    if VendLedgEntry1.FINDFIRST() then
                                        VendLedgEntry1.CALCFIELDS(Amount, "Remaining Amount");
                                    WHTEntryTemp.RESET();
                                    WHTEntryTemp.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                                    WHTEntryTemp.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");
                                    WHTEntryTemp.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
                                    WHTEntryTemp.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                    WHTEntryTemp.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                    if WHTEntryTemp.FINDFIRST() then begin
                                        TempRemBase := WHTEntryTemp."Unrealized Amount";
                                        TempRemAmt := WHTEntryTemp."Unrealized Base";
                                    end;
                                end;

                                VendLedgEntry.RESET();
                                VendLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                                if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::Invoice then
                                    VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::Invoice)
                                else
                                    if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::"Credit Memo" then
                                        VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::"Credit Memo");
                                if VendLedgEntry.FINDFIRST() then
                                    VendLedgEntry.CALCFIELDS(Amount, "Remaining Amount");
                                ExpectedAmount := -(VendLedgEntry.Amount + VendLedgEntry1.Amount);
                                if VendLedgEntry1."Amount (LCY)" = 0 then
                                    VendLedgEntry1."Rem. Amt FND" := 0;
                                if (GenJnlLine."Posting Date" <= VendLedgEntry."Pmt. Discount Date") and
                                   (ABS(PaymentAmount1) >=
                                    (ABS(VendLedgEntry."Rem. Amt FND" + VendLedgEntry1."Rem. Amt FND") -
                                     ABS(VendLedgEntry."Original Pmt. Disc. Possible"))) and
                                   (not AmountWithDisc)
                                then begin
                                    if VendLedgEntry."Remaining Amount" = 0 then begin
                                        AppldAmount :=
                                          ROUND(
                                            (PaymentAmount1 *
                                             (WHTEntry."Unrealized Base" + TempRemAmt)) /
                                            ExpectedAmount);
                                        WHTEntry3."Remaining Unrealized Base" :=
                                          ROUND(
                                            WHTEntry."Remaining Unrealized Base" -
                                            ROUND(
                                              (PaymentAmount1 *
                                               (WHTEntry."Unrealized Base" + TempRemAmt)) /
                                              ExpectedAmount));
                                        WHTEntry3."Remaining Unrealized Amount" :=
                                          ROUND(
                                            WHTEntry."Remaining Unrealized Amount" -
                                            ROUND(
                                              (PaymentAmount1 *
                                               ((WHTEntry."Unrealized Base"
                                                 * WHTEntry."WHT %" / 100) + TempRemBase)) /
                                              ExpectedAmount));
                                    end else begin
                                        AppldAmount :=
                                          ROUND(
                                            (PaymentAmount1 *
                                             (WHTEntry."Unrealized Base" + TempRemAmt)) /
                                            ExpectedAmount);
                                        WHTEntry3."Remaining Unrealized Base" :=
                                          ROUND(
                                            WHTEntry."Remaining Unrealized Base" -
                                            ROUND(
                                              (PaymentAmount1 *
                                               (WHTEntry."Unrealized Base" + TempRemAmt)) /
                                              ExpectedAmount));
                                        WHTEntry3."Remaining Unrealized Amount" :=
                                          ROUND(
                                            WHTEntry."Remaining Unrealized Amount" -
                                            ROUND(
                                              (PaymentAmount1 *
                                               (WHTEntry."Unrealized Amount" + TempRemBase)) /
                                              ExpectedAmount));
                                    end
                                end else begin
                                    AppldAmount :=
                                      ROUND(
                                        (PaymentAmount1 * (WHTEntry."Unrealized Base" + TempRemAmt)) /
                                        ExpectedAmount);
                                    WHTEntry3."Remaining Unrealized Base" :=
                                      ROUND(
                                        WHTEntry."Remaining Unrealized Base" -
                                        ROUND(
                                          (PaymentAmount1 * (WHTEntry."Unrealized Base" + TempRemAmt)) /
                                          ExpectedAmount));
                                    WHTEntry3."Remaining Unrealized Amount" :=
                                      ROUND(
                                        WHTEntry."Remaining Unrealized Amount" -
                                        ROUND(
                                          (PaymentAmount1 * (WHTEntry."Unrealized Amount" + TempRemBase)) /
                                          ExpectedAmount));
                                end;
                                PaymentAmount := PaymentAmount + AppldAmount;
                            end;
                        Source::Customer:
                            begin
                                SalesCrMemoHeader.RESET();
                                SalesCrMemoHeader.SETRANGE("Applies-to Doc. No.", GenJnlLine."Applies-to Doc. No.");
                                SalesCrMemoHeader.SETRANGE("Applies-to Doc. Type", SalesCrMemoHeader."Applies-to Doc. Type"::Invoice);
                                if SalesCrMemoHeader.FINDFIRST() then begin
                                    TempRemAmt := 0;
                                    CustLedgEntry1.RESET();
                                    CustLedgEntry1.SETRANGE("Document No.", SalesCrMemoHeader."No.");
                                    CustLedgEntry1.SETRANGE("Document Type", CustLedgEntry1."Document Type"::"Credit Memo");
                                    if CustLedgEntry1.FINDFIRST() then
                                        CustLedgEntry1.CALCFIELDS(Amount, "Remaining Amount");
                                    WHTEntryTemp.RESET();
                                    WHTEntryTemp.SETRANGE("Document No.", SalesCrMemoHeader."No.");
                                    WHTEntryTemp.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");
                                    WHTEntryTemp.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Sale);
                                    WHTEntryTemp.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                    WHTEntryTemp.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                    if WHTEntryTemp.FINDFIRST() then begin
                                        TempRemBase := WHTEntryTemp."Unrealized Amount";
                                        TempRemAmt := WHTEntryTemp."Unrealized Base";
                                    end;
                                end;

                                CustLedgEntry.RESET();
                                CustLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                                if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::Invoice then
                                    CustLedgEntry.SETRANGE("Document Type", CustLedgEntry."Document Type"::Invoice)
                                else
                                    if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::"Credit Memo" then
                                        CustLedgEntry.SETRANGE("Document Type", CustLedgEntry."Document Type"::"Credit Memo");
                                if CustLedgEntry.FINDFIRST() then
                                    CustLedgEntry.CALCFIELDS(Amount, "Remaining Amount");
                                if CustLedgEntry1."Amount (LCY)" = 0 then
                                    CustLedgEntry1."Rem. Amt FND" := 0;
                                ExpectedAmount := -(CustLedgEntry.Amount + CustLedgEntry1.Amount);
                                if (GenJnlLine."Posting Date" <= CustLedgEntry."Pmt. Discount Date") and
                                   (ABS(PaymentAmount1) >= (ABS(CustLedgEntry."Rem. Amt FND" + CustLedgEntry1."Rem. Amt FND") -
                                                            ABS(CustLedgEntry."Original Pmt. Disc. Possible"))) and
                                   (not AmountWithDisc)
                                then begin
                                    AppldAmount :=
                                      ROUND(
                                        (PaymentAmount1 * (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount);
                                    WHTEntry3."Remaining Unrealized Base" :=
                                      ROUND(
                                        WHTEntry."Remaining Unrealized Base" -
                                        ROUND(
                                          (PaymentAmount1 * (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount));
                                    WHTEntry3."Remaining Unrealized Amount" :=
                                      ROUND(
                                        WHTEntry."Remaining Unrealized Amount" -
                                        ROUND(
                                          (PaymentAmount1 * (WHTEntry."Unrealized Amount" + TempRemBase)) / ExpectedAmount));
                                end else begin
                                    AppldAmount :=
                                      ROUND(
                                        (PaymentAmount1 * (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount);
                                    WHTEntry3."Remaining Unrealized Base" :=
                                      ROUND(
                                        WHTEntry."Remaining Unrealized Base" -
                                        ROUND(
                                          (PaymentAmount1 * (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount));
                                    WHTEntry3."Remaining Unrealized Amount" :=
                                      ROUND(
                                        WHTEntry."Remaining Unrealized Amount" -
                                        ROUND(
                                          (PaymentAmount1 * (WHTEntry."Unrealized Amount" + TempRemBase)) / ExpectedAmount));
                                end;
                                PaymentAmount := PaymentAmount + AppldAmount;
                            end;
                    end;
                    if (WHTEntry."Remaining Unrealized Base" = 0) and (WHTEntry."Remaining Unrealized Amount" = 0) then
                        WHTEntry3.Closed := true;
                    if GenJnlLine."Currency Code" <> WHTEntry."Currency Code" then
                        ERROR(Text1500000);
                    if AppldAmount = 0 then
                        exit;
                    WHTEntry2.INIT();
                    WHTEntry2."Posting Date" := GenJnlLine."Document Date";
                    WHTEntry2."Entry No." := NextEntryNo();
                    WHTEntry2."Document Date" := WHTEntry."Document Date";
                    WHTEntry2."Document Type" := GenJnlLine."Document Type";
                    WHTEntry2."Document No." := WHTEntry."Document No.";
                    WHTEntry2."Gen. Bus. Posting Group" := WHTEntry."Gen. Bus. Posting Group";
                    WHTEntry2."Gen. Prod. Posting Group" := WHTEntry."Gen. Prod. Posting Group";
                    WHTEntry2."Bill-to/Pay-to No." := WHTEntry."Bill-to/Pay-to No.";
                    WHTEntry2."WHT Bus. Posting Group" := WHTEntry."WHT Bus. Posting Group";
                    WHTEntry2."WHT Prod. Posting Group" := WHTEntry."WHT Prod. Posting Group";
                    WHTEntry2."WHT Revenue Type" := WHTEntry."WHT Revenue Type";
                    WHTEntry2."Currency Code" := GenJnlLine."Currency Code";
                    WHTEntry2."Applies-to Entry No." := WHTEntry."Entry No.";
                    WHTEntry2."User ID" := USERID;
                    WHTEntry2."External Document No." := GenJnlLine."External Document No.";
                    WHTEntry2."Actual Vendor No." := GenJnlLine."Actual Vendor No. FND";
                    WHTEntry2."Original Document No." := GenJnlLine."Document No.";
                    WHTEntry2."Source Code" := GenJnlLine."Source Code";
                    WHTEntry2."Transaction No." := TransactionNo;
                    WHTEntry2."Unrealized WHT Entry No." := WHTEntry."Entry No.";
                    WHTEntry2."WHT %" := WHTEntry."WHT %";
                    case Source of
                        Source::Vendor:
                            begin
                                WHTEntry2.Base := ROUND(AppldAmount);
                                WHTEntry2.Amount := ROUND(WHTEntry2.Base * WHTEntry2."WHT %" / 100);
                                WHTEntry2."Payment Amount" := PaymentAmount1;
                                WHTEntry2."Transaction Type" := WHTEntry2."Transaction Type"::Purchase;
                                WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                WHTEntry2."WHT Report" := WHTPostingSetup."WHT Report";
                                if GenJnlLine."Certificate Printed FND" then begin
                                    WHTEntry2."WHT Report Line No" := GenJnlLine."WHT Report Line No. FND";
                                    TempWHT.SETRANGE("Document No.", WHTEntry2."Document No.");
                                    if TempWHT.FINDFIRST() then
                                        WHTEntry2."WHT Certificate No." := TempWHT."WHT Certificate No.";
                                end else begin
                                    if ((Source = Source::Vendor) and
                                        (WHTEntry."Document Type" = WHTEntry."Document Type"::Invoice)) or
                                       ((Source = Source::Customer) and
                                        (WHTEntry."Document Type" = WHTEntry."Document Type"::"Credit Memo"))
                                    then
                                        if (WHTReportLineNo = '') and
                                           (WHTEntry2.Amount <> 0) and
                                           (WHTPostingSetup."WHT Report Line No. Series" <> '')
                                        then
                                            WHTReportLineNo :=
                                              NoSeriesMgt.GetNextNo(
                                                WHTPostingSetup."WHT Report Line No. Series", WHTEntry2."Posting Date", true);
                                    WHTEntry2."WHT Report Line No" := WHTReportLineNo;
                                end;
                                TType := TType::Purchase;
                            end;
                        Source::Customer:
                            begin
                                WHTEntry2.Base := ROUND(AppldAmount);
                                WHTEntry2.Amount := ROUND(WHTEntry2.Base * WHTEntry2."WHT %" / 100);
                                WHTEntry2."Payment Amount" := PaymentAmount1;
                                WHTEntry2."Transaction Type" := WHTEntry2."Transaction Type"::Sale;
                                TType := TType::Sale;
                            end;
                    end;

                    if WHTEntry2."Currency Code" <> '' then begin
                        CurrFactor := GenJnlLine."Currency Factor";
                        WHTEntry2."Base (LCY)" :=
                          ROUND(
                            CurrExchRate.ExchangeAmtFCYToLCY(
                              GenJnlLine."Document Date",
                              WHTEntry2."Currency Code",
                              WHTEntry2.Base, CurrFactor));
                        WHTEntry2."Amount (LCY)" :=
                          ROUND(
                            CurrExchRate.ExchangeAmtFCYToLCY(
                              GenJnlLine."Document Date",
                              WHTEntry2."Currency Code",
                              WHTEntry2.Amount, CurrFactor));
                    end else begin
                        WHTEntry2."Amount (LCY)" := WHTEntry2.Amount;
                        WHTEntry2."Base (LCY)" := WHTEntry2.Base;
                    end;
                    if WHTEntry2."Currency Code" <> '' then begin
                        CurrFactor := GenJnlLine."Currency Factor";
                        WHTEntry2."Base (LCY)" :=
                          ROUND(
                            CurrExchRate.ExchangeAmtFCYToLCY(
                              GenJnlLine."Document Date",
                              WHTEntry2."Currency Code",
                              WHTEntry2.Base, CurrFactor));
                        WHTEntry2."Amount (LCY)" :=
                          ROUND(
                            CurrExchRate.ExchangeAmtFCYToLCY(
                              GenJnlLine."Document Date",
                              WHTEntry2."Currency Code",
                              WHTEntry2.Amount, CurrFactor));
                    end else begin
                        WHTEntry2."Amount (LCY)" := WHTEntry2.Amount;
                        WHTEntry2."Base (LCY)" := WHTEntry2.Base;
                    end;
                    if VendLedgEntry."Original Pmt. Disc. Possible" <> 0 then begin
                        if WHTEntry2.Base <> WHTEntry."Unrealized Base" then begin
                            if VendLedgEntry."Remaining Amount" = 0 then begin
                                WHTEntry3."Rem Unrealized Amount (LCY)" := WHTEntry2."Rem Unrealized Amount (LCY)";
                                WHTEntry3."Rem Unrealized Base (LCY)" := WHTEntry2."Rem Unrealized Base (LCY)";
                                WHTEntry3."Remaining Unrealized Amount" := WHTEntry2."Remaining Unrealized Amount";
                                WHTEntry3."Remaining Unrealized Base" := WHTEntry2."Remaining Unrealized Base";
                                WHTEntry4.RESET();
                                WHTEntry4.SETCURRENTKEY("Applies-to Entry No.");
                                WHTEntry4.SETFILTER("Applies-to Entry No.", '=%1', WHTEntry."Entry No.");
                                WHTEntry4.CALCSUMS(WHTEntry4.Base);
                                WHTEntry3."Pymt. Disc. Diff. Base" := WHTEntry."Unrealized Base" - (WHTEntry4.Base + WHTEntry2.Base);
                                WHTEntry3."Pymt. Disc. Diff. Amount" := ROUND((WHTEntry3."Pymt. Disc. Diff. Base" * WHTEntry3."WHT %") / 100);
                                WHTEntry3."WHT Difference" :=
                                  WHTEntry3."WHT Difference" + ABS(ABS(WHTEntry3."Pymt. Disc. Diff. Amount") -
                                  ABS(WHTEntry."Unrealized Amount" - (WHTEntry4.Amount + WHTEntry2.Amount)));
                            end
                        end
                    end else begin
                        WHTEntry3."Rem Unrealized Amount (LCY)" :=
                          WHTEntry."Rem Unrealized Amount (LCY)" - WHTEntry2."Amount (LCY)";
                        WHTEntry3."Rem Unrealized Base (LCY)" :=
                          WHTEntry."Rem Unrealized Base (LCY)" - WHTEntry2."Base (LCY)";
                    end;

                    //HEI.06>>
                    gWHTPostingSetup.RESET();
                    if gWHTPostingSetup.GET(WHTEntry2."WHT Bus. Posting Group", WHTEntry2."WHT Prod. Posting Group") then
                        WHTEntry2."WHT Bearer" := gWHTPostingSetup."WHT Bearer";
                    //HEI.06<<
                    WHTEntry2.INSERT();
                    WHTEntry3.MODIFY();

                    AdjustWHTEntryWithWHTDifference(WHTEntry, WHTEntry2, WHTEntry3);

                    // Payment Method Code.Begin
                    if Source = Source::Customer then
                        TempGenJnlTemp.SETRANGE(Type, TempGenJnlTemp.Type::Sales)
                    else
                        TempGenJnlTemp.SETRANGE(Type, TempGenJnlTemp.Type::Purchases);
                    if TempGenJnlTemp.FINDFIRST() then
                        if GenJnlLine."Journal Template Name" <> TempGenJnlTemp.Name then begin
                            // Payment Method Code.End;
                            if WHTEntry2.Amount <> 0 then
                                InsertWHTPostingBuffer(WHTEntry2, GenJnlLine, 0, AmountWithDisc)
                        end; // Payment Method Code
                end;
            until (WHTEntry.NEXT() = 0);
        if (WHTPostingSetup."Realized WHT Type" =
            WHTPostingSetup."Realized WHT Type"::Payment)
        then
            exit(WHTEntry2."Entry No." + 1);
    end;

    procedure ProcessManualReceipt(var GenJnlLine: Record "Gen. Journal Line"; TransactionNo: Integer; EntryNo: Integer; Source: Option Vendor,Customer) PaymentNo: Integer;
    var
        WHTEntry: Record "WHT Entry FND";
        WHTEntry2: Record "WHT Entry FND";
        WHTEntry3: Record "WHT Entry FND";
        WHTEntryTemp: Record "WHT Entry FND";
        AppldAmount: Decimal;
        PaymentAmount: Decimal;
        PaymentAmount1: Decimal;
        PaymentAmountLCY: Decimal;
        WHTAmount: Decimal;
    begin
        PaymentAmount := GenJnlLine.Amount;
        PaymentAmount1 := GenJnlLine.Amount;
        PaymentAmountLCY := GenJnlLine."Amount (LCY)";
        WHTEntry.RESET();
        WHTEntry.SETCURRENTKEY("Transaction Type", "Document No.", "Document Type", "Bill-to/Pay-to No.");
        case Source of
            Source::Vendor:
                WHTEntry.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
            Source::Customer:
                WHTEntry.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Sale);
        end;

        if GenJnlLine."Applies-to Doc. No." <> '' then
            WHTEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.")
        else
            WHTEntry.SETRANGE("Bill-to/Pay-to No.", GenJnlLine."Account No.");

        if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::Invoice then
            WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::Invoice)
        else
            if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::"Credit Memo" then
                WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");

        if WHTEntry.findset() then
            repeat
                WHTEntryTemp.RESET();
                WHTEntryTemp := WHTEntry;
                case Source of
                    Source::Vendor:
                        begin
                            if GenJnlLine."Applies-to Doc. No." = '' then
                                exit;
                            WHTEntry3.RESET();
                            WHTAmount := 0;
                            WHTEntry3.COPY(WHTEntry);
                            if WHTEntry3.findset() then
                                repeat
                                    WHTAmount := WHTAmount + WHTEntry3."Unrealized Amount";
                                until WHTEntry3.NEXT() = 0;
                            AppldAmount := -ROUND(GenJnlLine.Amount * WHTEntry."Unrealized Amount" / WHTAmount);

                            if AppldAmount = 0 then
                                AppliedBase := WHTEntry."Remaining Unrealized Base"
                            else
                                AppliedBase := ROUND(AppldAmount * 100 / WHTEntry."WHT %");

                            if WHTEntry."WHT %" <> 0 then
                                WHTEntryTemp."Remaining Unrealized Base" :=
                                  ROUND(WHTEntry."Remaining Unrealized Base" - ROUND(AppldAmount * 100 / WHTEntry."WHT %"))
                            else
                                WHTEntryTemp."Remaining Unrealized Base" := 0;
                            WHTEntryTemp."Remaining Unrealized Amount" :=
                              ROUND(
                                WHTEntry."Remaining Unrealized Amount" -
                                ROUND(AppldAmount));
                            PaymentAmount := PaymentAmount + AppldAmount;
                            TType := TType::Purchase;
                        end;
                    Source::Customer:
                        begin
                            WHTEntry3.RESET();
                            WHTAmount := 0;
                            WHTEntry3.COPY(WHTEntry);
                            if WHTEntry3.findset() then
                                repeat
                                    WHTAmount := WHTAmount + WHTEntry3."Unrealized Amount";
                                until WHTEntry3.NEXT() = 0;

                            AppldAmount := ROUND(GenJnlLine.Amount * WHTEntry."Unrealized Amount" / WHTAmount);

                            if AppldAmount = 0 then
                                AppliedBase := WHTEntry."Remaining Unrealized Base"
                            else
                                AppliedBase := ROUND(AppldAmount * 100 / WHTEntry."WHT %");

                            TType := TType::Sale;

                            if WHTEntry."WHT %" <> 0 then
                                WHTEntryTemp."Remaining Unrealized Base" :=
                                  ROUND(
                                    WHTEntry."Remaining Unrealized Base" -
                                    ROUND(
                                      AppldAmount * 100 / WHTEntry."WHT %"))
                            else
                                WHTEntryTemp."Remaining Unrealized Base" := 0;

                            WHTEntryTemp."Remaining Unrealized Amount" :=
                              ROUND(
                                WHTEntry."Remaining Unrealized Amount" -
                                ROUND(AppldAmount));
                            PaymentAmount := PaymentAmount + AppldAmount;
                        end;
                end;

                if GenJnlLine."Currency Code" <> WHTEntry."Currency Code" then
                    ERROR(Text1500000);
                WHTEntry2.INIT();
                WHTEntry2."Posting Date" := GenJnlLine."Document Date";
                WHTEntry2."Entry No." := NextEntryNo();
                WHTEntry2."Document Date" := WHTEntry."Document Date";
                WHTEntry2."Document Type" := GenJnlLine."Document Type";
                WHTEntry2."Document No." := WHTEntry."Document No.";
                WHTEntry2."Gen. Bus. Posting Group" := WHTEntry."Gen. Bus. Posting Group";
                WHTEntry2."Gen. Prod. Posting Group" := WHTEntry."Gen. Prod. Posting Group";
                WHTEntry2."Bill-to/Pay-to No." := WHTEntry."Bill-to/Pay-to No.";
                WHTEntry2."WHT Bus. Posting Group" := WHTEntry."WHT Bus. Posting Group";
                WHTEntry2."WHT Prod. Posting Group" := WHTEntry."WHT Prod. Posting Group";
                WHTEntry2."WHT Revenue Type" := WHTEntry."WHT Revenue Type";
                WHTEntry2."Currency Code" := GenJnlLine."Currency Code";
                WHTEntry2."Applies-to Entry No." := WHTEntry."Entry No.";
                WHTEntry2."User ID" := USERID;
                WHTEntry2."External Document No." := GenJnlLine."External Document No.";
                WHTEntry2."Original Document No." := GenJnlLine."Document No.";
                WHTEntry2."Source Code" := GenJnlLine."Source Code";
                WHTEntry2."Transaction No." := TransactionNo;
                if TType = TType::Sale then
                    WHTEntry2."Transaction Type" := WHTEntry2."Transaction Type"::Sale
                else
                    WHTEntry2."Transaction Type" := WHTEntry2."Transaction Type"::Purchase;
                WHTEntry2."WHT %" := WHTEntry."WHT %";
                WHTEntry2."Unrealized WHT Entry No." := WHTEntry."Entry No.";
                WHTEntry2.Base := ROUND(AppliedBase);
                WHTEntry2.Amount := ROUND(AppldAmount);
                if WHTEntry2."Currency Code" <> '' then begin
                    CurrFactor :=
                      CurrExchRate.ExchangeRate(WHTEntry2."Posting Date", WHTEntry2."Currency Code");
                    WHTEntry2."Base (LCY)" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          GenJnlLine."Document Date",
                          WHTEntry2."Currency Code",
                          WHTEntry2.Base, CurrFactor));
                    WHTEntry2."Amount (LCY)" := ROUND(WHTEntry2."Base (LCY)");
                end else begin
                    WHTEntry2."Amount (LCY)" := WHTEntry2.Amount;
                    WHTEntry2."Base (LCY)" := WHTEntry2.Base;
                end;
                //HEI.06>>
                gWHTPostingSetup.RESET();
                if gWHTPostingSetup.GET(WHTEntry2."WHT Bus. Posting Group", WHTEntry2."WHT Prod. Posting Group") then
                    WHTEntry2."WHT Bearer" := gWHTPostingSetup."WHT Bearer";
                //HEI.06<<
                WHTEntry2.INSERT();
                WHTEntryTemp."Rem Unrealized Amount (LCY)" :=
                  WHTEntry."Rem Unrealized Amount (LCY)" - WHTEntry2."Amount (LCY)";
                WHTEntryTemp."Rem Unrealized Base (LCY)" :=
                  WHTEntry."Rem Unrealized Base (LCY)" - WHTEntry2."Base (LCY)";
                WHTEntryTemp.MODIFY();
                if WHTEntry2.Amount <> 0 then
                    InsertWHTPostingBuffer(WHTEntry2, GenJnlLine, 0, false);
            until (WHTEntry.NEXT() = 0);
        exit(WHTEntry2."Entry No." + 1);
    end;

    procedure InsertWHTPostingBuffer(var WHTEntryGL: Record "WHT Entry FND"; var GenJnlLine: Record "Gen. Journal Line"; Source: Option Payment,Refund; Oldest: Boolean);
    var
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlLine3: Record "Gen. Journal Line";
        GenJnlLine4: Record "Gen. Journal Line";
        PurchSetup: Record "General Ledger Setup";
        HighestLineNo: Integer;
    begin
        WHTPostingSetup.GET(WHTEntryGL."WHT Bus. Posting Group", WHTEntryGL."WHT Prod. Posting Group");
        PurchSetup.GET();
        GenJnlLine2 := GenJnlLine;
        GenJnlLine2.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
        GenJnlLine2.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
        GenJnlLine2.FINDLAST();
        HighestLineNo := GenJnlLine2."Line No." + 10000;
        GenJnlLine3.RESET();
        GenJnlLine3 := GenJnlLine;
        GenJnlLine3.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
        GenJnlLine3.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
        //HEI.05>>
        HighestLineNo := GenJnlLine."Line No." + 10;

        GenJnlLine4.RESET();
        GenJnlLine4.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
        GenJnlLine4.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
        GenJnlLine4.SETRANGE("Line No.", HighestLineNo);
        while GenJnlLine4.FINDFIRST() do begin
            HighestLineNo := HighestLineNo + 1;
            GenJnlLine4.SETRANGE("Line No.", HighestLineNo);
        end;
        GenJnlLine3."Line No." := HighestLineNo;

        //HEI.05<<
        //HEI.05>>
        /*
        GenJnlLine3."Line No." := HighestLineNo;
        IF GenJnlLine3.NEXT = 0 THEN
          GenJnlLine3."Line No." := HighestLineNo + 10000
        else BEGIN
          WHILE GenJnlLine3."Line No." = HighestLineNo + 1 DO BEGIN
            HighestLineNo := GenJnlLine3."Line No.";
            IF GenJnlLine3.NEXT = 0 THEN
              GenJnlLine3."Line No." := HighestLineNo + 20000;
          end;
          GenJnlLine3."Line No." := HighestLineNo + 10000;
        end;
        */  //HEI.05<<


        GenJnlLine3.INIT();
        GenJnlLine3.VALIDATE("Posting Date", GenJnlLine."Posting Date");
        GenJnlLine3."Document Type" := GenJnlLine."Document Type";
        GenJnlLine3."Account Type" := GenJnlLine3."Account Type"::"G/L Account";
        GenJnlLine3."System-Created Entry" := true;
        GenJnlLine3."Is WHT FND" := true;
        if GenJnlLine."Document Type" = GenJnlLine."Document Type"::Refund then begin
            if TType = TType::Purchase then
                GenJnlLine3.VALIDATE("Account No.", WHTPostingSetup."Purch. WHT Adj. Account No.");
            if TType = TType::Sale then
                GenJnlLine3.VALIDATE("Account No.", WHTPostingSetup."Sales WHT Adj. Account No.");
        end else begin
            if TType = TType::Purchase then
                GenJnlLine3.VALIDATE("Account No.", WHTPostingSetup."Payable WHT Account Code");
            if TType = TType::Sale then begin
                WHTPostingSetup.TESTFIELD("Prepaid WHT Account Code");
                GenJnlLine3.VALIDATE("Account No.", WHTPostingSetup."Prepaid WHT Account Code");
            end;
        end;
        GenJnlLine3.VALIDATE("Currency Code", WHTEntryGL."Currency Code");
        if GLSetup."Round Amount for WHT Calc FND" then begin
            GenJnlLine3.VALIDATE(Amount, ROUND(-WHTEntryGL.Amount, 1, '<'));
            GenJnlLine3."Amount (LCY)" := ROUND(-WHTEntryGL."Amount (LCY)", 1, '<');
        end else begin
            GenJnlLine3.VALIDATE(Amount, -WHTEntryGL.Amount);
            GenJnlLine3."Amount (LCY)" := -WHTEntryGL."Amount (LCY)";
        end;
        GenJnlLine3."Gen. Posting Type" := GenJnlLine."Gen. Posting Type";
        GenJnlLine3."System-Created Entry" := true; // Payment Method Code
        GLSetup.GET();
        if (Oldest = true) or GLSetup."Manual Sales WHT Calc. FND" then begin
            if TType = TType::Purchase then begin
                case WHTPostingSetup."Bal. Payable Account Type" of
                    WHTPostingSetup."Bal. Payable Account Type"::"Bank Account":
                        GenJnlLine3."Bal. Account Type" := GenJnlLine3."Account Type"::"Bank Account";
                    WHTPostingSetup."Bal. Payable Account Type"::"G/L Account":
                        GenJnlLine3."Bal. Account Type" := GenJnlLine3."Account Type"::"G/L Account";
                end;
                WHTPostingSetup.TESTFIELD("Bal. Payable Account No.");
                GenJnlLine3.VALIDATE("Bal. Account No.", WHTPostingSetup."Bal. Payable Account No.");
            end;

            if TType = TType::Sale then begin
                case WHTPostingSetup."Bal. Prepaid Account Type" of
                    WHTPostingSetup."Bal. Prepaid Account Type"::"Bank Account":
                        GenJnlLine3."Bal. Account Type" := GenJnlLine3."Account Type"::"Bank Account";
                    WHTPostingSetup."Bal. Prepaid Account Type"::"G/L Account":
                        GenJnlLine3."Bal. Account Type" := GenJnlLine3."Account Type"::"G/L Account";
                end;
                WHTPostingSetup.TESTFIELD("Bal. Prepaid Account No.");
                GenJnlLine3.VALIDATE("Bal. Account No.", WHTPostingSetup."Bal. Prepaid Account No.");
            end;
        end;
        GenJnlLine3."Source Code" := GenJnlLine."Source Code";
        GenJnlLine3."Reason Code" := GenJnlLine."Reason Code";
        GenJnlLine3."Shortcut Dimension 1 Code" := GenJnlLine."Shortcut Dimension 1 Code";
        GenJnlLine3."Shortcut Dimension 2 Code" := GenJnlLine."Shortcut Dimension 2 Code";
        GenJnlLine3."Allow Zero-Amount Posting" := true;
        GenJnlLine3."WHT Business Posting Group FND" := WHTEntryGL."WHT Bus. Posting Group";
        GenJnlLine3."WHT Product Posting Group FND" := WHTEntryGL."WHT Prod. Posting Group";
        GenJnlLine3."Document Type" := GenJnlLine."Document Type";
        GenJnlLine3."Document No." := GenJnlLine."Document No.";
        GenJnlLine3."External Document No." := GenJnlLine."External Document No.";
        if Source = Source::Refund then
            GenJnlLine3."Gen. Posting Type" := GenJnlLine3."Gen. Posting Type"::" ";
        GenJnlLine3.INSERT();

    end;

    procedure NextEntryNo(): Integer;
    var
        NewWHTEntry: Record "WHT Entry FND";
    begin
        NewWHTEntry.RESET();
        if NewWHTEntry.FINDLAST() then
            exit(NewWHTEntry."Entry No." + 1);

        exit(1);
    end;

    procedure NextTempEntryNo(): Integer;
    var
        NewWHTEntry: Record "Temp WHT Entry FND";
    begin
        NewWHTEntry.RESET();
        if NewWHTEntry.FINDLAST() then
            exit(NewWHTEntry."Entry No." + 1);

        exit(1);
    end;

    procedure PrintWHTSlips(var GLReg: Record "G/L Register");
    var
        GLEntry: Record "G/L Entry";
        PurchSetup: Record "Purchases & Payables Setup";
        ReportSelection: Record "Report Selections";
        SalesSetup: Record "Sales & Receivables Setup";
        WHTSlipBuffer: Record "WHT Certificate Buffer FND";
        WHTEntry: Record "WHT Entry FND";
        WHTEntry2: Record "WHT Entry FND";
        WHTRevenueTypes: Record "WHT Revenue Types FND";
        ActualVendorNo: Boolean;
        DocumentArray: array[1000] of Code[20];
        VendorArray: array[1000] of Code[20];
        WHTSlipBuffer2: Code[20];
        WHTSlipDocument2: Code[20];
        WHTSlipNo: Code[20];
        EndTrans: Integer;
        PrintSlips: Integer;
        StartTrans: Integer;
        x: Integer;
        GLRegFilter: Text[250];
    begin
        x := 0;
        GLRegFilter := GLReg.GETFILTERS;
        GLEntry.RESET();
        if GLReg."From Entry No." < 0 then
            GLEntry.SETRANGE("Entry No.", GLReg."To Entry No.", GLReg."From Entry No.")
        else
            GLEntry.SETRANGE("Entry No.", GLReg."From Entry No.", GLReg."To Entry No.");
        GLEntry.FINDFIRST();
        StartTrans := GLEntry."Transaction No.";
        GLEntry.FINDLAST();
        EndTrans := GLEntry."Transaction No.";

        WHTEntry.RESET();
        //soicad begin delete
        // WHTEntry.SETCURRENTKEY("Bill-to/Pay-to No.","Original Document No.","WHT Revenue Type");
        // WHTEntry.SETRANGE("Transaction No.",StartTrans,EndTrans);
        //end delete
        //soica>>
        WHTEntry.SETRANGE("Entry No.", GLReg."From WHT Entry No. FND", GLReg."To WHT Entry No. FND");
        //soica<<
        if not WHTEntry.FINDFIRST() then
            exit;
        repeat
            if WHTEntry."Transaction Type" = WHTEntry."Transaction Type"::Sale then begin
                if WHTEntry."Document Type" in [
                                                WHTEntry."Document Type"::Invoice,
                                                WHTEntry."Document Type"::Payment]
                then
                    exit;

                SalesSetup.GET();
                if not SalesSetup."Print WHT on Credit Memo FND" then
                    if WHTEntry."Document Type" = WHTEntry."Document Type"::"Credit Memo" then
                        exit;
            end;
            x := x + 1;
            if WHTEntry."Actual Vendor No." <> '' then begin
                VendorArray[x] := WHTEntry."Actual Vendor No.";
                ActualVendorNo := true;
            end else
                VendorArray[x] := WHTEntry."Bill-to/Pay-to No.";
            DocumentArray[x] := WHTEntry."Original Document No.";
        until WHTEntry.NEXT() = 0;

        PurchSetup.GET();
        WHTSlipBuffer.DELETEALL();
        for PrintSlips := 1 to x do begin
            WHTSlipBuffer.INIT();
            WHTSlipBuffer."Line No." := PrintSlips;
            WHTSlipBuffer."Vendor No." := VendorArray[PrintSlips];
            WHTSlipBuffer."Document No." := DocumentArray[PrintSlips];
            WHTSlipBuffer.INSERT();
        end;

        x := 0;
        CLEAR(VendorArray);
        CLEAR(DocumentArray);
        WHTSlipBuffer.RESET();
        WHTSlipBuffer.SETCURRENTKEY("Vendor No.", "Document No.");
        WHTSlipBuffer.findset();
        repeat
            x := x + 1;
            VendorArray[x] := WHTSlipBuffer."Vendor No.";
            DocumentArray[x] := WHTSlipBuffer."Document No.";
        until WHTSlipBuffer.NEXT() = 0;

        for PrintSlips := 1 to x do begin
            if (VendorArray[PrintSlips] <> WHTSlipBuffer2) or
               (DocumentArray[PrintSlips] <> WHTSlipDocument2)
            then begin
                WHTSlipNo :=
                  NoSeriesMgt.GetNextNo(
                    PurchSetup."WHT Certificate No. Series FND", WHTEntry."Posting Date", true);
                WHTEntry.RESET();
                WHTEntry.SETCURRENTKEY("Bill-to/Pay-to No.", "Original Document No.", "WHT Revenue Type");
                if ActualVendorNo then
                    WHTEntry.SETRANGE("Actual Vendor No.", VendorArray[PrintSlips])
                else
                    WHTEntry.SETRANGE("Bill-to/Pay-to No.", VendorArray[PrintSlips]);
                WHTEntry.SETRANGE("Original Document No.", DocumentArray[PrintSlips]);
                if WHTEntry.findset() then
                    repeat
                        WHTRevenueTypes.RESET();
                        WHTRevenueTypes.SETRANGE(Code, WHTEntry."WHT Revenue Type");
                        WHTEntry2.RESET();
                        WHTEntry2 := WHTEntry;
                        if WHTRevenueTypes.FINDFIRST() then begin
                            WHTEntry2."WHT Certificate No." := WHTSlipNo;
                            WHTEntry2.MODIFY();
                        end;
                    until WHTEntry.NEXT() = 0;
                WHTEntry.RESET();
                WHTEntry.SETCURRENTKEY("Bill-to/Pay-to No.", "Original Document No.", "WHT Revenue Type");
                if ActualVendorNo then
                    WHTEntry.SETRANGE("Actual Vendor No.", VendorArray[PrintSlips])
                else
                    WHTEntry.SETRANGE("Bill-to/Pay-to No.", VendorArray[PrintSlips]);
                WHTEntry.SETRANGE("Original Document No.", DocumentArray[PrintSlips]);
                WHTEntry.SETRANGE("WHT Certificate No.", WHTSlipNo);
                if WHTEntry.findset() then
                    ReportSelection.RESET();
                ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"WHT Certificate");
                if ReportSelection.findset() then
                    repeat
                        REPORT.RUN(ReportSelection."Report ID", PurchSetup."Print Dialog FND", false, WHTEntry);
                    until ReportSelection.NEXT() = 0;
            end;
            WHTSlipBuffer2 := VendorArray[PrintSlips];
            WHTSlipDocument2 := DocumentArray[PrintSlips];
        end;
    end;

    procedure InsertVendJournalWHT(var GenJnlLine: Record "Gen. Journal Line") EntryNo: Integer;
    begin
        if ((GenJnlLine."Document Type" <> GenJnlLine."Document Type"::Invoice) and
            (GenJnlLine."Document Type" <> GenJnlLine."Document Type"::"Credit Memo") and
            (GenJnlLine."Document Type" <> GenJnlLine."Document Type"::Payment) and
            (GenJnlLine."Document Type" <> GenJnlLine."Document Type"::Refund))
        then
            exit;

        if not WHTPostingSetup.GET(
             GenJnlLine."WHT Business Posting Group FND", GenJnlLine."WHT Product Posting Group FND")
        then
            exit;

        TransType := TransType::Purchase;
        case GenJnlLine."Document Type" of
            GenJnlLine."Document Type"::Invoice:
                DocType := DocType::Invoice;
            GenJnlLine."Document Type"::"Credit Memo":
                DocType := DocType::"Credit Memo";
            GenJnlLine."Document Type"::Payment:
                DocType := DocType::Payment;
            GenJnlLine."Document Type"::Refund:
                DocType := DocType::Refund;
        end;

        PostingDate := GenJnlLine."Posting Date";
        DocNo := GenJnlLine."Document No.";
        PayToAccType := PayToAccType::Vendor;
        PayToVendCustNo := GenJnlLine."Account No.";
        BuyFromAccType := BuyFromAccType::Vendor;
        BuyFromVendCustNo := GenJnlLine."Account No.";
        ActualVendorNo := GenJnlLine."Actual Vendor No. FND";
        ApplyDocType := GenJnlLine."Applies-to Doc. Type";
        ApplyDocNo := GenJnlLine."Applies-to Doc. No.";
        "Applies-toID" := GenJnlLine."Applies-to ID";
        WHTBusPostGrp := GenJnlLine."WHT Business Posting Group FND";
        WHTProdPostGrp := GenJnlLine."WHT Product Posting Group FND";
        WHTPostingSetup.RESET();
        WHTPostingSetup.GET(WHTBusPostGrp, WHTProdPostGrp);
        WHTRevenueType := WHTPostingSetup."Revenue Type";
        Amount := -GenJnlLine.Amount;
        AbsorbBase := -GenJnlLine."WHT Absorb Base FND";
        if AbsorbBase <> 0 then
            AmountVAT := AbsorbBase
        else
            AmountVAT := Amount;
        CurrFactor := GenJnlLine."Currency Factor";
        DocDate := GenJnlLine."Document Date";
        Dim1 := GenJnlLine."Shortcut Dimension 1 Code";
        Dim2 := GenJnlLine."Shortcut Dimension 2 Code";
        ExtDocNo := GenJnlLine."External Document No.";
        CurrencyCode := GenJnlLine."Currency Code";
        SourceCode := GenJnlLine."Source Code";
        FullWHT := GenJnlLine."Full WHT FND";
        TempGenJnlLine.RESET();
        TempGenJnlLine.DELETEALL();
        TempGenJnlLine := GenJnlLine;
        GLSetup.GET();

        Vendor.GET(GenJnlLine."Account No.");

        if CheckWHTCalculationRule(GenJnlLine."Amount (LCY)", WHTPostingSetup) then
            exit;

        exit(InsertWHT(TType::Purchase));
    end;

    procedure InsertCustJournalWHT(var GenJnlLine: Record "Gen. Journal Line") EntryNo: Integer;
    begin
        SourceCodeSetup.GET();
        if GenJnlLine."Source Code" = SourceCodeSetup.sales then
            exit;
        if ((GenJnlLine."Document Type" <> GenJnlLine."Document Type"::Invoice) and
            (GenJnlLine."Document Type" <> GenJnlLine."Document Type"::"Credit Memo") and
            (GenJnlLine."Document Type" <> GenJnlLine."Document Type"::Payment) and
            (GenJnlLine."Document Type" <> GenJnlLine."Document Type"::Refund))
        then
            exit;

        if not WHTPostingSetup.GET(
             GenJnlLine."WHT Business Posting Group FND", GenJnlLine."WHT Product Posting Group FND")
        then
            exit;

        TransType := TransType::Sale;
        case GenJnlLine."Document Type" of
            GenJnlLine."Document Type"::Invoice:
                DocType := DocType::Invoice;
            GenJnlLine."Document Type"::"Credit Memo":
                DocType := DocType::"Credit Memo";
            GenJnlLine."Document Type"::Payment:
                DocType := DocType::Payment;
            GenJnlLine."Document Type"::Refund:
                DocType := DocType::Refund;
        end;

        PostingDate := GenJnlLine."Posting Date";
        DocNo := GenJnlLine."Document No.";
        PayToAccType := PayToAccType::Customer;
        PayToVendCustNo := GenJnlLine."Account No.";
        BuyFromAccType := BuyFromAccType::Customer;
        BuyFromVendCustNo := GenJnlLine."Account No.";
        ApplyDocType := GenJnlLine."Applies-to Doc. Type";
        ApplyDocNo := GenJnlLine."Applies-to Doc. No.";
        "Applies-toID" := GenJnlLine."Applies-to ID";
        WHTBusPostGrp := GenJnlLine."WHT Business Posting Group FND";
        WHTProdPostGrp := GenJnlLine."WHT Product Posting Group FND";
        WHTPostingSetup.RESET();
        WHTPostingSetup.GET(WHTBusPostGrp, WHTProdPostGrp);
        WHTRevenueType := WHTPostingSetup."Revenue Type";
        AbsorbBase := GenJnlLine."WHT Absorb Base FND";
        Amount := GenJnlLine.Amount;
        if AbsorbBase <> 0 then
            AmountVAT := AbsorbBase
        else
            AmountVAT := Amount;
        CurrFactor := GenJnlLine."Currency Factor";
        DocDate := GenJnlLine."Document Date";
        Dim1 := GenJnlLine."Shortcut Dimension 1 Code";
        Dim2 := GenJnlLine."Shortcut Dimension 2 Code";
        ExtDocNo := GenJnlLine."External Document No.";
        CurrencyCode := GenJnlLine."Currency Code";
        SourceCode := GenJnlLine."Source Code";
        exit(InsertWHT(TType::Sale));
    end;

    procedure InsertWHT(TransType: Option Purchase,Sale) EntryNo: Integer;
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry1: Record "Cust. Ledger Entry";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        VendLedgEntry: Record "Vendor Ledger Entry";
        VendLedgEntry1: Record "Vendor Ledger Entry";
        VendLedgerEntry: Record "Vendor Ledger Entry";
        VendLedgerEntry1: Record "Vendor Ledger Entry";
        TempWHTEntry: Record "WHT Entry FND";
        WHTEntry: Record "WHT Entry FND";
        WHTEntry3: Record "WHT Entry FND";
        WHTEntryTemp: Record "WHT Entry FND";
        IsRefund: Boolean;
        AppldAmount: Decimal;
        ExpectedAmount: Decimal;
        PaymentAmount1: Decimal;
        RemainingAmt: Decimal;
        TotalWHT: Decimal;
        TotalWHTBase: Decimal;
        WHTPart: Decimal;
    begin
        if WHTPostingSetup.GET(WHTBusPostGrp, WHTProdPostGrp) then
            if WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::" " then begin
                UnrealizedWHT := (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment);
                WHTEntry.INIT();
                WHTEntry."Entry No." := NextEntryNo();
                WHTEntry."Gen. Bus. Posting Group" := GenBusPostGrp;
                WHTEntry."Gen. Prod. Posting Group" := GenProdPostGrp;
                WHTEntry."WHT Bus. Posting Group" := WHTBusPostGrp;
                WHTEntry."WHT Prod. Posting Group" := WHTProdPostGrp;
                WHTEntry."Posting Date" := PostingDate;
                WHTEntry."Document Date" := DocDate;
                WHTEntry."Document No." := DocNo;
                WHTEntry."External Document No." := ExtDocNo;
                WHTEntry."WHT %" := WHTPostingSetup."WHT %";
                WHTEntry."Applies-to Doc. Type" := ApplyDocType;
                WHTEntry."Applies-to Doc. No." := ApplyDocNo;
                WHTEntry."Source Code" := SourceCode;
                WHTEntry."Reason Code" := ReasonCode;
                WHTEntry."WHT Revenue Type" := WHTPostingSetup."Revenue Type";
                WHTEntry."Document Type" := DocType;
                if TransType = TransType::Purchase then
                    WHTEntry."Transaction Type" := WHTEntry."Transaction Type"::Purchase
                else
                    WHTEntry."Transaction Type" := WHTEntry."Transaction Type"::Sale;
                WHTEntry."Actual Vendor No." := ActualVendorNo;
                WHTEntry."Source Code" := SourceCode;
                WHTEntry."Bill-to/Pay-to No." := PayToVendCustNo;
                WHTEntry."User ID" := USERID;
                WHTEntry."Currency Code" := CurrencyCode;

                // VAT for G/L entry/entries
                if UnrealizedWHT then begin
                    SetWHTEntryAmounts(WHTEntry, AbsorbBase, AmountVAT, CurrFactor);
                    if WHTEntry."Applies-to Doc. No." <> '' then begin
                        TempWHTEntry.RESET();
                        TempWHTEntry.SETRANGE("Document Type", WHTEntry."Applies-to Doc. Type");
                        TempWHTEntry.SETRANGE("Document No.", WHTEntry."Applies-to Doc. No.");
                        TempWHTEntry.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                        TempWHTEntry.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                        if TempWHTEntry.FINDFIRST() then begin
                            if ABS(WHTEntry."Unrealized Amount") <=
                               ABS(TempWHTEntry."Remaining Unrealized Amount")
                            then begin
                                TempWHTEntry."Remaining Unrealized Amount" :=
                                  TempWHTEntry."Remaining Unrealized Amount" + WHTEntry."Unrealized Amount";
                                TempWHTEntry."Remaining Unrealized Base" :=
                                  TempWHTEntry."Remaining Unrealized Base" + WHTEntry."Unrealized Base";
                                WHTEntry."Remaining Unrealized Amount" := 0;
                                WHTEntry."Remaining Unrealized Base" := 0;
                                WHTEntry.Closed := true;
                            end else begin
                                TempWHTEntry."Remaining Unrealized Amount" := 0;
                                TempWHTEntry."Remaining Unrealized Base" := 0;
                                WHTEntry."Remaining Unrealized Amount" :=
                                  TempWHTEntry."Remaining Unrealized Amount" + WHTEntry."Unrealized Amount";
                                WHTEntry."Remaining Unrealized Base" :=
                                  TempWHTEntry."Remaining Unrealized Base" + WHTEntry."Unrealized Base";
                            end;

                            if (TempWHTEntry."Remaining Unrealized Base" = 0) and
                               (TempWHTEntry."Remaining Unrealized Amount" = 0)
                            then
                                TempWHTEntry.Closed := true;

                            TempWHTEntry.MODIFY();
                            WHTEntry."Applies-to Entry No." := TempWHTEntry."Entry No.";
                        end;
                    end else begin
                        if "Applies-toID" <> '' then begin
                            if (TransType = TransType::Purchase) and
                               (WHTEntry."Document Type" = WHTEntry."Document Type"::"Credit Memo")
                            then begin
                                VendLedgerEntry1.SETRANGE("Applies-to ID", "Applies-toID");
                                if VendLedgerEntry1.findset() then
                                    repeat
                                        if FindWHTEntryForApply(
                                             TempWHTEntry, VendLedgerEntry1."Document Type", VendLedgerEntry1."Document No.",
                                             WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group")
                                        then begin
                                            VendLedgerEntry1.CALCFIELDS("Remaining Amount");
                                            WHTPart := ABS(VendLedgerEntry1."Amount to Apply" / VendLedgerEntry1."Remaining Amount");
                                            if WHTPart >= 1 then begin
                                                if ABS(WHTEntry."Remaining Unrealized Amount") <=
                                                   ABS(TempWHTEntry."Remaining Unrealized Amount" * WHTPart)
                                                then
                                                    CalcWHTEntriesRemAmounts(TempWHTEntry, WHTEntry, WHTPart)
                                                else
                                                    CalcWHTEntriesRemAmounts(WHTEntry, TempWHTEntry, WHTPart);
                                            end else
                                                CalcWHTEntriesRemAmounts(TempWHTEntry, WHTEntry, WHTPart)
                                        end;
                                        TempWHTEntry."Applies-to Entry No." := WHTEntry."Entry No.";
                                        TempWHTEntry.MODIFY();
                                    until VendLedgerEntry1.NEXT() = 0;
                            end;

                            if TransType = TransType::Sale then begin
                                CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::"Credit Memo");
                                CustLedgerEntry.SETRANGE("Document No.", WHTEntry."Document No.");
                                if CustLedgerEntry.FINDFIRST() then begin
                                    CustLedgerEntry1.SETRANGE("Closed by Entry No.", CustLedgerEntry."Entry No.");
                                    if CustLedgerEntry1.findset() then
                                        repeat
                                            TempWHTEntry.RESET();
                                            TempWHTEntry.SETRANGE("Document Type", CustLedgerEntry1."Document Type");
                                            TempWHTEntry.SETRANGE("Document No.", CustLedgerEntry1."Document No.");
                                            TempWHTEntry.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                            TempWHTEntry.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                            if TempWHTEntry.FINDFIRST() then begin
                                                WHTEntry."Remaining Unrealized Amount" :=
                                                  TempWHTEntry."Unrealized Amount" + WHTEntry."Unrealized Amount";
                                                WHTEntry."Remaining Unrealized Base" :=
                                                  TempWHTEntry."Unrealized Base" + WHTEntry."Unrealized Base";
                                                TempWHTEntry."Remaining Unrealized Amount" := 0;
                                                TempWHTEntry."Remaining Unrealized Base" := 0;
                                                TempWHTEntry.Closed := true;
                                                TempWHTEntry."Applies-to Entry No." := WHTEntry."Entry No.";
                                                TempWHTEntry.MODIFY();
                                            end;
                                        until CustLedgerEntry1.NEXT() = 0;

                                    if CustLedgerEntry."Closed by Entry No." <> 0 then begin
                                        CustLedgerEntry1.RESET();
                                        CustLedgerEntry1.SETRANGE("Entry No.", CustLedgerEntry."Closed by Entry No.");
                                        if CustLedgerEntry1.FINDFIRST() then begin
                                            TempWHTEntry.RESET();
                                            TempWHTEntry.SETRANGE("Document Type", CustLedgerEntry1."Document Type");
                                            TempWHTEntry.SETRANGE("Document No.", CustLedgerEntry1."Document No.");
                                            TempWHTEntry.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                            TempWHTEntry.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                            if TempWHTEntry.FINDFIRST() then begin
                                                if ABS(WHTEntry."Remaining Unrealized Amount") <=
                                                   ABS(TempWHTEntry."Remaining Unrealized Amount")
                                                then begin
                                                    TempWHTEntry."Remaining Unrealized Amount" :=
                                                      TempWHTEntry."Remaining Unrealized Amount" +
                                                      WHTEntry."Remaining Unrealized Amount";
                                                    TempWHTEntry."Remaining Unrealized Base" :=
                                                      TempWHTEntry."Remaining Unrealized Base" +
                                                      WHTEntry."Remaining Unrealized Base";
                                                    TempWHTEntry.MODIFY();
                                                    WHTEntry."Remaining Unrealized Amount" := 0;
                                                    WHTEntry."Remaining Unrealized Base" := 0;
                                                    WHTEntry.Closed := true;
                                                    WHTEntry."Applies-to Entry No." := TempWHTEntry."Entry No.";
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end else begin
                    if AbsorbBase <> 0 then
                        WHTEntry.Base := AbsorbBase
                    else
                        WHTEntry.Base := AmountVAT;
                    WHTEntry."Unrealized Amount" := 0;
                    WHTEntry."Unrealized Base" := 0;
                    WHTEntry."Remaining Unrealized Amount" := 0;
                    WHTEntry."Remaining Unrealized Base" := 0;
                    WHTEntry.Amount := ROUND(WHTEntry.Base * WHTEntry."WHT %" / 100);
                    WHTEntry."Rem Realized Amount" := WHTEntry.Amount;
                    WHTEntry."Rem Realized Base" := WHTEntry.Base;
                    WHTEntry."Original Document No." := DocNo;
                    WHTEntry."WHT Report" := WHTPostingSetup."WHT Report";
                    if ((WHTReportLineNo = '') and
                        (WHTPostingSetup."WHT Report Line No. Series" <> ''))
                    then
                        WHTEntry."WHT Report Line No" :=
                          NoSeriesMgt.GetNextNo(
                            WHTPostingSetup."WHT Report Line No. Series", WHTEntry."Posting Date", true);

                    if TransType = TransType::Purchase then begin
                        if ((WHTEntry."Document Type" = WHTEntry."Document Type"::Invoice) or
                            (WHTEntry."Document Type" = WHTEntry."Document Type"::Payment))
                        then begin
                            WHTEntry.Base := ABS(WHTEntry.Base);
                            WHTEntry.Amount := ABS(WHTEntry.Amount);
                            WHTEntry."Payment Amount" := ABS(Amount);
                            WHTEntry."Rem Realized Base" := WHTEntry.Base;
                            WHTEntry."Rem Realized Amount" := WHTEntry.Amount;
                            if (WHTPostingSetup."Realized WHT Type" =
                                WHTPostingSetup."Realized WHT Type"::Earliest)
                            then begin
                                if WHTEntry."Applies-to Doc. No." <> '' then begin
                                    TempWHTEntry.RESET();
                                    // TempWHTEntry.SETRANGE(Settled,FALSE);
                                    TempWHTEntry.SETRANGE("Document Type", WHTEntry."Applies-to Doc. Type");
                                    TempWHTEntry.SETRANGE("Document No.", WHTEntry."Applies-to Doc. No.");
                                    TempWHTEntry.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                    TempWHTEntry.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                    if WHTEntry."Document Type" = WHTEntry."Document Type"::Invoice then
                                        TempWHTEntry.SETRANGE(
                                          "Document Type",
                                          TempWHTEntry."Document Type"::Payment,
                                          TempWHTEntry."Document Type"::"Credit Memo");

                                    if WHTEntry."Document Type" = WHTEntry."Document Type"::Payment then
                                        TempWHTEntry.SETFILTER(
                                          "Document Type",
                                          '%1|%2',
                                          TempWHTEntry."Document Type"::Invoice,
                                          TempWHTEntry."Document Type"::Refund);

                                    if TempWHTEntry.FINDFIRST() then begin
                                        if TempWHTEntry.Prepayment then begin
                                            PaymentAmount1 := WHTEntry.Base;
                                            WHTEntry3.RESET();
                                            WHTEntry3 := TempWHTEntry;

                                            PurchCrMemoHeader.RESET();
                                            PurchCrMemoHeader.SETRANGE("Applies-to Doc. No.", WHTEntry."Applies-to Doc. No.");
                                            PurchCrMemoHeader.SETRANGE("Applies-to Doc. Type", PurchCrMemoHeader."Applies-to Doc. Type"::Invoice);
                                            if PurchCrMemoHeader.FINDFIRST() then begin
                                                TempRemAmt := 0;
                                                VendLedgEntry1.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                                                VendLedgEntry1.SETRANGE("Document Type", VendLedgEntry1."Document Type"::"Credit Memo");
                                                if VendLedgEntry1.FINDFIRST() then
                                                    VendLedgEntry1.CALCFIELDS(Amount, "Remaining Amount");
                                                WHTEntryTemp.RESET();
                                                WHTEntryTemp.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                                                WHTEntryTemp.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");
                                                WHTEntryTemp.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
                                                WHTEntryTemp.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                                WHTEntryTemp.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                                if WHTEntryTemp.FINDFIRST() then begin
                                                    TempRemBase := WHTEntryTemp."Unrealized Amount";
                                                    TempRemAmt := WHTEntryTemp."Unrealized Base";
                                                end;
                                            end;

                                            VendLedgEntry.RESET();
                                            VendLedgEntry.SETRANGE("Document No.", WHTEntry."Applies-to Doc. No.");
                                            if WHTEntry."Applies-to Doc. Type" = WHTEntry."Applies-to Doc. Type"::Invoice then
                                                VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::Invoice)
                                            else
                                                if WHTEntry."Applies-to Doc. Type" = WHTEntry."Applies-to Doc. Type"::"Credit Memo" then
                                                    VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::"Credit Memo");
                                            if VendLedgEntry.FINDFIRST() then
                                                VendLedgEntry.CALCFIELDS(Amount, "Remaining Amount");
                                            ExpectedAmount := -(VendLedgEntry.Amount + VendLedgEntry1.Amount);
                                            if VendLedgEntry1."Amount (LCY)" = 0 then
                                                VendLedgEntry1."Rem. Amt FND" := 0;
                                            if (WHTEntry."Posting Date" <= VendLedgEntry."Pmt. Discount Date") and
                                               (ABS(PaymentAmount1) >=
                                                (ABS(VendLedgEntry."Rem. Amt FND" + VendLedgEntry1."Rem. Amt FND") -
                                                 ABS(VendLedgEntry."Original Pmt. Disc. Possible")))
                                            then begin
                                                AppldAmount :=
                                                  ROUND(
                                                    ((PaymentAmount1 - VendLedgEntry."Original Pmt. Disc. Possible") *
                                                     (TempWHTEntry."Unrealized Base" + TempRemAmt)) /
                                                    ExpectedAmount);
                                                WHTEntry3."Remaining Unrealized Base" :=
                                                  ROUND(
                                                    TempWHTEntry."Remaining Unrealized Base" -
                                                    ROUND(
                                                      ((PaymentAmount1 - VendLedgEntry."Original Pmt. Disc. Possible") *
                                                       (TempWHTEntry."Unrealized Base" + TempRemAmt)) /
                                                      ExpectedAmount));
                                                WHTEntry3."Remaining Unrealized Amount" :=
                                                  ROUND(
                                                    TempWHTEntry."Remaining Unrealized Amount" -
                                                    ROUND(
                                                      ((PaymentAmount1 - VendLedgEntry."Original Pmt. Disc. Possible") *
                                                       (TempWHTEntry."Unrealized Amount" + TempRemBase)) /
                                                      ExpectedAmount));
                                            end else begin
                                                AppldAmount :=
                                                  ROUND(
                                                    (PaymentAmount1 * (TempWHTEntry."Unrealized Base" + TempRemAmt)) /
                                                    ExpectedAmount);
                                                WHTEntry3."Remaining Unrealized Base" :=
                                                  ROUND(
                                                    TempWHTEntry."Remaining Unrealized Base" -
                                                    ROUND(
                                                      (PaymentAmount1 * (TempWHTEntry."Unrealized Base" + TempRemAmt)) /
                                                      ExpectedAmount));
                                                WHTEntry3."Remaining Unrealized Amount" :=
                                                  ROUND(
                                                    TempWHTEntry."Remaining Unrealized Amount" -
                                                    ROUND(
                                                      (PaymentAmount1 * (TempWHTEntry."Unrealized Amount" + TempRemBase)) /
                                                      ExpectedAmount));
                                            end;
                                            WHTEntry."Applies-to Entry No." := TempWHTEntry."Entry No.";
                                            WHTEntry."Unrealized WHT Entry No." := TempWHTEntry."Entry No.";
                                            WHTEntry."WHT %" := TempWHTEntry."WHT %";
                                            WHTEntry.Base := ROUND(AppldAmount);
                                            WHTEntry.Amount := ROUND(WHTEntry.Base * WHTEntry."WHT %" / 100);
                                            WHTEntry."Payment Amount" := PaymentAmount1;
                                            WHTEntry."Rem Realized Base" := 0;
                                            WHTEntry."Rem Realized Amount" := 0;

                                            if CurrencyCode = '' then begin
                                                WHTEntry3."Rem Unrealized Amount (LCY)" :=
                                                  TempWHTEntry."Rem Unrealized Amount (LCY)" - WHTEntry.Amount;
                                                WHTEntry3."Rem Unrealized Base (LCY)" :=
                                                  TempWHTEntry."Rem Unrealized Base (LCY)" - WHTEntry.Base;
                                            end else begin
                                                WHTEntry3."Rem Unrealized Amount (LCY)" := TempWHTEntry."Rem Unrealized Amount (LCY)" -
                                                  ROUND(CurrExchRate.ExchangeAmtFCYToLCY(DocDate, CurrencyCode, WHTEntry.Amount, CurrFactor));
                                                WHTEntry3."Rem Unrealized Base (LCY)" := TempWHTEntry."Rem Unrealized Base (LCY)" -
                                                  ROUND(CurrExchRate.ExchangeAmtFCYToLCY(DocDate, CurrencyCode, WHTEntry.Base, CurrFactor));
                                            end;
                                            if (WHTEntry3."Remaining Unrealized Base" = 0) and (WHTEntry3."Remaining Unrealized Amount" = 0) then
                                                WHTEntry3.Closed := true;
                                            WHTEntry3.MODIFY();
                                        end else begin
                                            if WHTEntry."Document Type" = WHTEntry."Document Type"::Invoice then begin
                                                if ABS(TempWHTEntry."Rem Realized Amount") >= ABS(WHTEntry.Amount) then begin
                                                    if ((TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::"Credit Memo") or
                                                        (TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::Refund))
                                                    then begin
                                                        TempWHTEntry."Rem Realized Base" :=
                                                          TempWHTEntry."Rem Realized Base" + WHTEntry.Base;
                                                        TempWHTEntry."Rem Realized Amount" :=
                                                          TempWHTEntry."Rem Realized Amount" + WHTEntry.Amount;
                                                    end else begin
                                                        TempWHTEntry."Rem Realized Base" :=
                                                          TempWHTEntry."Rem Realized Base" - WHTEntry.Base;
                                                        TempWHTEntry."Rem Realized Amount" :=
                                                          TempWHTEntry."Rem Realized Amount" - WHTEntry.Amount;
                                                        WHTEntry.Amount := 0;
                                                    end;

                                                    if CurrencyCode = '' then begin
                                                        TempWHTEntry."Rem Realized Base (LCY)" := TempWHTEntry."Rem Realized Base";
                                                        TempWHTEntry."Rem Realized Amount (LCY)" := TempWHTEntry."Rem Realized Amount";
                                                    end else begin
                                                        TempWHTEntry."Rem Realized Amount (LCY)" :=
                                                          ROUND(
                                                            CurrExchRate.ExchangeAmtFCYToLCY(
                                                              DocDate, CurrencyCode, TempWHTEntry."Rem Realized Amount", CurrFactor));
                                                        TempWHTEntry."Rem Realized Base (LCY)" :=
                                                          ROUND(
                                                            CurrExchRate.ExchangeAmtFCYToLCY(
                                                              DocDate, CurrencyCode, TempWHTEntry."Rem Realized Base", CurrFactor));
                                                    end;
                                                end else begin
                                                    if ((TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::"Credit Memo") or
                                                        (TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::Refund))
                                                    then begin
                                                        WHTEntry."Rem Realized Base" := WHTEntry."Rem Realized Base" + TempWHTEntry."Rem Realized Base";
                                                        WHTEntry."Rem Realized Amount" := WHTEntry."Rem Realized Amount" + TempWHTEntry."Rem Realized Amount";
                                                    end else begin
                                                        WHTEntry.Base := WHTEntry.Base - TempWHTEntry."Rem Realized Base";
                                                        WHTEntry.Amount := WHTEntry.Amount - TempWHTEntry."Rem Realized Amount";
                                                        WHTEntry."Rem Realized Base" := WHTEntry."Rem Realized Base" - TempWHTEntry."Rem Realized Base";
                                                        WHTEntry."Rem Realized Amount" := WHTEntry."Rem Realized Amount" - TempWHTEntry."Rem Realized Amount";
                                                    end;
                                                    TempWHTEntry."Rem Realized Base" := 0;
                                                    TempWHTEntry."Rem Realized Amount" := 0;
                                                    TempWHTEntry."Rem Realized Base (LCY)" := 0;
                                                    TempWHTEntry."Rem Realized Amount (LCY)" := 0;
                                                end;
                                            end else begin
                                                TotAmt := 0;
                                                TotAmt := TempGenJnlLine.Amount;
                                                VendLedgerEntry.RESET();
                                                VendLedgerEntry.SETRANGE("Document No.", TempWHTEntry."Document No.");
                                                VendLedgerEntry.SETRANGE("Document Type", TempWHTEntry."Document Type");
                                                if VendLedgerEntry.FINDFIRST() then begin
                                                    TempVendLedgEntry.RESET();
                                                    TempVendLedgEntry.SETRANGE("Entry No.", VendLedgerEntry."Entry No.");
                                                    if TempVendLedgEntry.findset() then begin
                                                        TempVendLedgEntry.CALCFIELDS(
                                                          Amount, "Amount (LCY)",
                                                          "Remaining Amount", "Remaining Amt. (LCY)");

                                                        if ((WHTEntry."Document Type" = WHTEntry."Document Type"::Payment) and
                                                            (TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::Invoice))
                                                        then begin
                                                            if CheckPmtDisc(
                                                                 TempGenJnlLine."Posting Date",
                                                                 TempVendLedgEntry."Pmt. Discount Date",
                                                                 ABS(TempVendLedgEntry."Rem. Amt for WHT FND"),
                                                                 ABS(TempVendLedgEntry."Rem. Amt FND"),
                                                                 ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"),
                                                                 ABS(TotAmt))
                                                            then
                                                                TotAmt := TotAmt - TempVendLedgEntry."Original Pmt. Disc. Possible";
                                                        end;

                                                        if ABS(TempVendLedgEntry."Rem. Amt for WHT FND") < ABS(TotAmt) then begin
                                                            if ((TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::"Credit Memo") or
                                                                (TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::Refund))
                                                            then begin
                                                                WHTEntry."Rem Realized Base" := WHTEntry."Rem Realized Base" + TempWHTEntry."Rem Realized Base";
                                                                WHTEntry."Rem Realized Amount" :=
                                                                  WHTEntry."Rem Realized Amount" + TempWHTEntry."Rem Realized Amount";
                                                            end else begin
                                                                if CheckPmtDisc(
                                                                     TempGenJnlLine."Posting Date",
                                                                     TempVendLedgEntry."Pmt. Discount Date",
                                                                     ABS(TempVendLedgEntry."Rem. Amt for WHT FND"),
                                                                     ABS(TempVendLedgEntry."Rem. Amt FND"),
                                                                     ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"),
                                                                     ABS(TotAmt))
                                                                then begin
                                                                    WHTEntry.Base := (WHTEntry.Base -
                                                                                      ABS(TempVendLedgEntry."Rem. Amt for WHT FND" -
                                                                                        TempVendLedgEntry."Original Pmt. Disc. Possible")) - ABS(TempWHTEntry.Amount);
                                                                    WHTEntry.Amount :=
                                                                      ROUND(WHTEntry.Base * WHTEntry."WHT %" / 100);
                                                                    WHTEntry."Rem Realized Base" := WHTEntry."Rem Realized Base" -
                                                                      ABS(TempVendLedgEntry."Rem. Amt for WHT FND" -
                                                                        TempVendLedgEntry."Original Pmt. Disc. Possible" - TempWHTEntry.Amount);
                                                                    WHTEntry."Rem Realized Amount" := WHTEntry."Rem Realized Amount" -
                                                                      ROUND(ABS(TempVendLedgEntry."Rem. Amt for WHT FND" -
                                                                          TempVendLedgEntry."Original Pmt. Disc. Possible" - TempWHTEntry.Amount) *
                                                                        WHTEntry."WHT %" / 100);
                                                                end else begin
                                                                    WHTEntry.Base := (WHTEntry.Base -
                                                                                      ABS(TempVendLedgEntry."Rem. Amt for WHT FND")) - ABS(TempWHTEntry.Amount);
                                                                    WHTEntry.Amount :=
                                                                      ROUND(WHTEntry.Base * WHTEntry."WHT %" / 100);
                                                                    WHTEntry."Rem Realized Base" := WHTEntry."Rem Realized Base" -
                                                                      ABS(TempVendLedgEntry."Rem. Amt for WHT FND" - TempWHTEntry.Amount);
                                                                    WHTEntry."Rem Realized Amount" := WHTEntry."Rem Realized Amount" -
                                                                      ROUND(ABS(TempVendLedgEntry."Rem. Amt for WHT FND" - TempWHTEntry.Amount) * WHTEntry."WHT %" / 100);
                                                                end;
                                                            end;
                                                            TempWHTEntry."Rem Realized Base" := 0;
                                                            TempWHTEntry."Rem Realized Amount" := 0;
                                                            TempWHTEntry."Rem Realized Base (LCY)" := 0;
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := 0;
                                                        end else begin
                                                            if ((TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::"Credit Memo") or
                                                                (TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::Refund))
                                                            then begin
                                                                TempWHTEntry."Rem Realized Base" :=
                                                                  TempWHTEntry."Rem Realized Base" + WHTEntry.Base;
                                                                TempWHTEntry."Rem Realized Amount" :=
                                                                  TempWHTEntry."Rem Realized Amount" + WHTEntry.Amount;
                                                            end else begin
                                                                TempWHTEntry."Rem Realized Base" :=
                                                                  TempWHTEntry."Rem Realized Base" - TotAmt;
                                                                TempWHTEntry."Rem Realized Amount" :=
                                                                  TempWHTEntry."Rem Realized Amount" - ROUND(ABS(TotAmt) * WHTEntry."WHT %" / 100);
                                                                WHTEntry.Amount := 0;
                                                            end;

                                                            if CurrencyCode = '' then begin
                                                                TempWHTEntry."Rem Realized Base (LCY)" := TempWHTEntry."Rem Realized Base";
                                                                TempWHTEntry."Rem Realized Amount (LCY)" := TempWHTEntry."Rem Realized Amount";
                                                            end else begin
                                                                TempWHTEntry."Rem Realized Amount (LCY)" :=
                                                                  ROUND(
                                                                    CurrExchRate.ExchangeAmtFCYToLCY(
                                                                      DocDate, CurrencyCode, TempWHTEntry."Rem Realized Amount", CurrFactor));
                                                                TempWHTEntry."Rem Realized Base (LCY)" :=
                                                                  ROUND(
                                                                    CurrExchRate.ExchangeAmtFCYToLCY(
                                                                      DocDate, CurrencyCode, TempWHTEntry."Rem Realized Base", CurrFactor));
                                                            end;
                                                            TotAmt := 0;
                                                        end;
                                                    end;
                                                end;
                                            end;

                                            if (TempWHTEntry."Rem Realized Amount" = 0) and
                                               (TempWHTEntry."Rem Realized Base" = 0)
                                            then
                                                TempWHTEntry.Closed := true;
                                            TempWHTEntry.MODIFY();
                                        end;
                                    end;
                                end else begin
                                    if "Applies-toID" <> '' then begin
                                        if WHTEntry."Document Type" = WHTEntry."Document Type"::Payment then begin
                                            TotAmt := 0;
                                            RemainingAmt := 0;
                                            TempVendLedgEntry1.RESET();
                                            TempVendLedgEntry1.SETRANGE("Applies-to ID", TempGenJnlLine."Applies-to ID");
                                            //if TempVendLedgEntry1.findset(true) then
                                            if TempVendLedgEntry1.findset(true) then
                                                repeat
                                                    TempVendLedgEntry1.CALCFIELDS(
                                                      Amount, "Amount (LCY)", "Remaining Amount", "Remaining Amt. (LCY)",
                                                      "Original Amount", "Original Amt. (LCY)");
                                                    if TempVendLedgEntry1."Rem. Amt for WHT FND" = 0 then
                                                        TempVendLedgEntry1."Rem. Amt for WHT FND" := TempVendLedgEntry1."Remaining Amt. (LCY)";
                                                    RemainingAmt := RemainingAmt + TempVendLedgEntry1."Rem. Amt for WHT FND";
                                                until TempVendLedgEntry1.NEXT() = 0;
                                            TotAmt := ABS(TempGenJnlLine.Amount);
                                            VendLedgerEntry.RESET();
                                            VendLedgerEntry.SETRANGE("Applies-to ID", "Applies-toID");
                                            VendLedgerEntry.SETRANGE("Document Type", VendLedgerEntry."Document Type"::Refund);
                                            if VendLedgerEntry.findset() then begin
                                                TotalWHTBase := WHTEntry."Rem Realized Base";
                                                TotalWHT := WHTEntry."Rem Realized Amount";
                                                repeat
                                                    TempWHTEntry.RESET();
                                                    TempWHTEntry.SETRANGE(Settled, false);
                                                    TempWHTEntry.SETRANGE("Document No.", VendLedgerEntry."Document No.");
                                                    TempWHTEntry.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                                    TempWHTEntry.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                                    if TempWHTEntry.FINDFIRST() then begin
                                                        if ABS(TotalWHT) > ABS(TempWHTEntry."Rem Realized Amount") then begin
                                                            WHTEntry."Rem Realized Base" :=
                                                              WHTEntry."Rem Realized Base" + TempWHTEntry."Rem Realized Base";
                                                            WHTEntry."Rem Realized Amount" :=
                                                              WHTEntry."Rem Realized Amount" + TempWHTEntry."Rem Realized Amount";
                                                            TotalWHTBase := TotalWHTBase - ABS(TempWHTEntry."Rem Realized Base");
                                                            TotalWHT := TotalWHT - ABS(TempWHTEntry."Rem Realized Amount");
                                                            TempWHTEntry."Rem Realized Base" := 0;
                                                            TempWHTEntry."Rem Realized Amount" := 0;
                                                            TempWHTEntry."Rem Realized Base (LCY)" := 0;
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := 0;
                                                        end else begin
                                                            if (ABS(TotalWHT) > 0) and (ABS(TotalWHT) <= ABS(TempWHTEntry."Rem Realized Amount")) then begin
                                                                TempWHTEntry."Rem Realized Base" :=
                                                                  TempWHTEntry."Rem Realized Base" + TotalWHTBase;
                                                                TempWHTEntry."Rem Realized Amount" :=
                                                                  TempWHTEntry."Rem Realized Amount" + TotalWHT;
                                                                WHTEntry."Rem Realized Amount" := 0;
                                                                WHTEntry."Rem Realized Base" := 0;
                                                                TotalWHTBase := 0;
                                                                TotalWHT := 0;
                                                            end;
                                                        end;

                                                        if CurrencyCode = '' then begin
                                                            TempWHTEntry."Rem Realized Base (LCY)" := TempWHTEntry."Rem Realized Base";
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := TempWHTEntry."Rem Realized Amount";
                                                        end else begin
                                                            TempWHTEntry."Rem Realized Amount (LCY)" :=
                                                              ROUND(
                                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                                  DocDate, CurrencyCode, TempWHTEntry."Rem Realized Amount (LCY)", CurrFactor));
                                                            TempWHTEntry."Rem Realized Base (LCY)" :=
                                                              ROUND(
                                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                                  DocDate, CurrencyCode, TempWHTEntry."Rem Realized Base (LCY)", CurrFactor));
                                                        end;
                                                        if ((TempWHTEntry."Rem Realized Amount" = 0) and
                                                            (TempWHTEntry."Rem Realized Base" = 0))
                                                        then
                                                            TempWHTEntry.Closed := true;
                                                        TempWHTEntry.MODIFY();
                                                    end;
                                                until VendLedgerEntry.NEXT() = 0;
                                                WHTEntry."Applies-to Entry No." := TempWHTEntry."Entry No.";
                                            end;

                                            VendLedgerEntry.RESET();
                                            VendLedgerEntry.SETRANGE("Applies-to ID", "Applies-toID");
                                            VendLedgerEntry.SETRANGE("Document Type", VendLedgerEntry."Document Type"::Invoice);
                                            if VendLedgerEntry.findset() then begin
                                                TotalWHTBase := WHTEntry."Rem Realized Base";
                                                TotalWHT := WHTEntry."Rem Realized Amount";
                                                repeat
                                                    if VendLedgerEntry.Prepayment then begin
                                                        TempVendLedgEntry.RESET();
                                                        TempVendLedgEntry.SETRANGE("Entry No.", VendLedgerEntry."Entry No.");
                                                        if TempVendLedgEntry.FINDFIRST() then begin
                                                            TempVendLedgEntry.CALCFIELDS(
                                                              Amount, "Amount (LCY)",
                                                              "Remaining Amount", "Remaining Amt. (LCY)");

                                                            if CheckPmtDisc(
                                                                 TempGenJnlLine."Posting Date",
                                                                 TempVendLedgEntry."Pmt. Discount Date",
                                                                 ABS(TempVendLedgEntry."Rem. Amt for WHT FND"),
                                                                 ABS(TempVendLedgEntry."Rem. Amt FND"),
                                                                 ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"),
                                                                 ABS(TotAmt))
                                                            then
                                                                TotAmt := TotAmt - TempVendLedgEntry."Original Pmt. Disc. Possible";

                                                            if (ABS(RemainingAmt) < ABS(TotAmt)) or
                                                               (ABS(TempVendLedgEntry."Rem. Amt for WHT FND") < ABS(TotAmt))
                                                            then begin
                                                                if CheckPmtDisc(
                                                                     TempGenJnlLine."Posting Date",
                                                                     TempVendLedgEntry."Pmt. Discount Date",
                                                                     ABS(TempVendLedgEntry."Rem. Amt for WHT FND"),
                                                                     ABS(TempVendLedgEntry."Rem. Amt FND"),
                                                                     ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"),
                                                                     ABS(TotAmt))
                                                                then begin
                                                                    TempGenJnlLine.VALIDATE(
                                                                      Amount,
                                                                      ABS(TempVendLedgEntry."Rem. Amt for WHT FND" -
                                                                        TempVendLedgEntry."Original Pmt. Disc. Possible"));

                                                                    if TempVendLedgEntry."Document Type" <>
                                                                       TempVendLedgEntry."Document Type"::"Credit Memo"
                                                                    then
                                                                        TotAmt := TotAmt + TempVendLedgEntry."Rem. Amt for WHT FND";

                                                                    RemainingAmt :=
                                                                      RemainingAmt -
                                                                      TempVendLedgEntry."Rem. Amt for WHT FND";
                                                                end else begin
                                                                    TempGenJnlLine.VALIDATE(Amount, ABS(TempVendLedgEntry."Rem. Amt for WHT FND"));
                                                                    if TempVendLedgEntry."Document Type" <>
                                                                       TempVendLedgEntry."Document Type"::"Credit Memo"
                                                                    then
                                                                        TotAmt := TotAmt + TempVendLedgEntry."Rem. Amt for WHT FND";
                                                                    RemainingAmt := RemainingAmt - TempVendLedgEntry."Rem. Amt for WHT FND";
                                                                end;
                                                            end else begin
                                                                if CheckPmtDisc(
                                                                     TempGenJnlLine."Posting Date",
                                                                     TempVendLedgEntry."Pmt. Discount Date",
                                                                     ABS(TempVendLedgEntry."Rem. Amt for WHT FND"),
                                                                     ABS(TempVendLedgEntry."Rem. Amt FND"),
                                                                     ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"),
                                                                     ABS(TotAmt))
                                                                then
                                                                    TempGenJnlLine.VALIDATE(Amount, TotAmt + TempVendLedgEntry."Original Pmt. Disc. Possible")
                                                                else
                                                                    TempGenJnlLine.VALIDATE(Amount, TotAmt);
                                                                WHTEntry.Amount := 0;
                                                                TotAmt := 0;
                                                            end;

                                                            if TempVendLedgEntry."Document Type" = TempVendLedgEntry."Document Type"::Invoice then
                                                                TempGenJnlLine."Applies-to Doc. Type" := TempGenJnlLine."Applies-to Doc. Type"::Invoice
                                                            else begin
                                                                if TempVendLedgEntry."Document Type" = TempVendLedgEntry."Document Type"::"Credit Memo" then
                                                                    TempGenJnlLine."Applies-to Doc. Type" := TempGenJnlLine."Applies-to Doc. Type"::"Credit Memo";
                                                                RemainingAmt := RemainingAmt + TempVendLedgEntry."Rem. Amt for WHT FND";
                                                                TotAmt := TotAmt + TempVendLedgEntry."Rem. Amt for WHT FND";
                                                            end;
                                                            TempGenJnlLine."Applies-to Doc. No." := TempVendLedgEntry."Document No.";
                                                            PaymentAmount1 := TempGenJnlLine.Amount;

                                                            TempWHTEntry.RESET();
                                                            TempWHTEntry.SETCURRENTKEY("Transaction Type", "Document No.", "Document Type", "Bill-to/Pay-to No.");
                                                            TempWHTEntry.SETRANGE("Transaction Type", TempWHTEntry."Transaction Type"::Purchase);
                                                            if TempGenJnlLine."Applies-to Doc. No." <> '' then begin
                                                                TempWHTEntry.SETRANGE("Document No.", TempGenJnlLine."Applies-to Doc. No.");
                                                                TempWHTEntry.SETRANGE("Document Type", TempGenJnlLine."Applies-to Doc. Type");
                                                            end else
                                                                TempWHTEntry.SETRANGE("Bill-to/Pay-to No.", TempGenJnlLine."Account No.");
                                                            if TempWHTEntry.findset() then
                                                                repeat
                                                                    WHTEntry3.RESET();
                                                                    WHTEntry3 := TempWHTEntry;
                                                                    PurchCrMemoHeader.RESET();
                                                                    PurchCrMemoHeader.SETRANGE("Applies-to Doc. No.", TempGenJnlLine."Applies-to Doc. No.");
                                                                    PurchCrMemoHeader.SETRANGE(
                                                                      "Applies-to Doc. Type", PurchCrMemoHeader."Applies-to Doc. Type"::Invoice);
                                                                    if PurchCrMemoHeader.FINDFIRST() then begin
                                                                        TempRemAmt := 0;
                                                                        VendLedgEntry1.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                                                                        VendLedgEntry1.SETRANGE("Document Type", VendLedgEntry1."Document Type"::"Credit Memo");
                                                                        if VendLedgEntry1.FINDFIRST() then
                                                                            VendLedgEntry1.CALCFIELDS(Amount, "Remaining Amount");
                                                                        WHTEntryTemp.RESET();
                                                                        WHTEntryTemp.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                                                                        WHTEntryTemp.SETRANGE("Document Type", TempWHTEntry."Document Type"::"Credit Memo");
                                                                        WHTEntryTemp.SETRANGE("Transaction Type", TempWHTEntry."Transaction Type"::Purchase);
                                                                        WHTEntryTemp.SETRANGE("WHT Bus. Posting Group", TempWHTEntry."WHT Bus. Posting Group");
                                                                        WHTEntryTemp.SETRANGE("WHT Prod. Posting Group", TempWHTEntry."WHT Prod. Posting Group");
                                                                        if WHTEntryTemp.FINDFIRST() then begin
                                                                            TempRemBase := WHTEntryTemp."Unrealized Amount";
                                                                            TempRemAmt := WHTEntryTemp."Unrealized Base";
                                                                        end;
                                                                    end;

                                                                    VendLedgEntry.RESET();
                                                                    VendLedgEntry.SETRANGE("Document No.", TempGenJnlLine."Applies-to Doc. No.");
                                                                    if TempGenJnlLine."Applies-to Doc. Type" = TempGenJnlLine."Applies-to Doc. Type"::Invoice then
                                                                        VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::Invoice)
                                                                    else
                                                                        if TempGenJnlLine."Applies-to Doc. Type" =
                                                                           TempGenJnlLine."Applies-to Doc. Type"::"Credit Memo"
                                                                        then
                                                                            VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::"Credit Memo");
                                                                    if VendLedgEntry.FINDFIRST() then
                                                                        VendLedgEntry.CALCFIELDS(Amount, "Remaining Amount");
                                                                    ExpectedAmount := -(VendLedgEntry.Amount + VendLedgEntry1.Amount);
                                                                    if VendLedgEntry1."Amount (LCY)" = 0 then
                                                                        VendLedgEntry1."Rem. Amt FND" := 0;
                                                                    if (TempGenJnlLine."Posting Date" <= VendLedgEntry."Pmt. Discount Date") and
                                                                       (ABS(PaymentAmount1) >=
                                                                        (ABS(VendLedgEntry."Rem. Amt FND" + VendLedgEntry1."Rem. Amt FND") -
                                                                         ABS(VendLedgEntry."Original Pmt. Disc. Possible")))
                                                                    then begin
                                                                        AppldAmount :=
                                                                          ROUND(
                                                                            ((PaymentAmount1 - VendLedgEntry."Original Pmt. Disc. Possible") *
                                                                             (TempWHTEntry."Unrealized Base" + TempRemAmt)) /
                                                                            ExpectedAmount);
                                                                        WHTEntry3."Remaining Unrealized Base" :=
                                                                          ROUND(
                                                                            TempWHTEntry."Remaining Unrealized Base" -
                                                                            ROUND(
                                                                              ((PaymentAmount1 - VendLedgEntry."Original Pmt. Disc. Possible") *
                                                                               (TempWHTEntry."Unrealized Base" + TempRemAmt)) /
                                                                              ExpectedAmount));
                                                                        WHTEntry3."Remaining Unrealized Amount" :=
                                                                          ROUND(
                                                                            TempWHTEntry."Remaining Unrealized Amount" -
                                                                            ROUND(
                                                                              ((PaymentAmount1 - VendLedgEntry."Original Pmt. Disc. Possible") *
                                                                               (TempWHTEntry."Unrealized Amount" + TempRemBase)) /
                                                                              ExpectedAmount));
                                                                    end else begin
                                                                        AppldAmount :=
                                                                          ROUND(
                                                                            (PaymentAmount1 *
                                                                             (TempWHTEntry."Unrealized Base" + TempRemAmt)) /
                                                                            ExpectedAmount);
                                                                        WHTEntry3."Remaining Unrealized Base" :=
                                                                          ROUND(
                                                                            TempWHTEntry."Remaining Unrealized Base" -
                                                                            ROUND(
                                                                              (PaymentAmount1 * (TempWHTEntry."Unrealized Base" + TempRemAmt)) /
                                                                              ExpectedAmount));
                                                                        WHTEntry3."Remaining Unrealized Amount" :=
                                                                          ROUND(
                                                                            TempWHTEntry."Remaining Unrealized Amount" -
                                                                            ROUND(
                                                                              (PaymentAmount1 * (TempWHTEntry."Unrealized Amount" + TempRemBase)) /
                                                                              ExpectedAmount));
                                                                    end;

                                                                    InitWHTEntry(TempWHTEntry, AppldAmount, PaymentAmount1, WHTEntry3);
                                                                until TempWHTEntry.NEXT(-1) = 0;
                                                        end;
                                                    end else begin
                                                        TempWHTEntry.RESET();
                                                        // TempWHTEntry.SETRANGE(Settled,FALSE);
                                                        TempWHTEntry.SETRANGE("Document No.", VendLedgerEntry."Document No.");
                                                        TempWHTEntry.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                                        TempWHTEntry.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                                        if TempWHTEntry.FINDFIRST() then begin
                                                            TempVendLedgEntry.RESET();
                                                            TempVendLedgEntry.SETRANGE("Entry No.", VendLedgerEntry."Entry No.");
                                                            if TempVendLedgEntry.FINDFIRST() then begin
                                                                TempVendLedgEntry.CALCFIELDS(
                                                                  Amount, "Amount (LCY)",
                                                                  "Remaining Amount", "Remaining Amt. (LCY)");

                                                                if CheckPmtDisc(
                                                                     TempGenJnlLine."Posting Date",
                                                                     TempVendLedgEntry."Pmt. Discount Date",
                                                                     ABS(TempVendLedgEntry."Rem. Amt for WHT FND"),
                                                                     ABS(TempVendLedgEntry."Rem. Amt FND"),
                                                                     ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"),
                                                                     ABS(TotAmt))
                                                                then
                                                                    TotAmt := TotAmt - TempVendLedgEntry."Original Pmt. Disc. Possible";

                                                                if (ABS(RemainingAmt) < ABS(TotAmt)) or
                                                                   (ABS(TempVendLedgEntry."Rem. Amt for WHT FND") < ABS(TotAmt))
                                                                then begin
                                                                    if CheckPmtDisc(
                                                                         TempGenJnlLine."Posting Date",
                                                                         TempVendLedgEntry."Pmt. Discount Date",
                                                                         ABS(TempVendLedgEntry."Rem. Amt for WHT FND"),
                                                                         ABS(TempVendLedgEntry."Rem. Amt FND"),
                                                                         ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"),
                                                                         ABS(TotAmt))
                                                                    then begin
                                                                        if TempVendLedgEntry."Document Type" <>
                                                                           TempVendLedgEntry."Document Type"::"Credit Memo"
                                                                        then
                                                                            TotAmt := TotAmt + TempVendLedgEntry."Rem. Amt for WHT FND";

                                                                        RemainingAmt :=
                                                                          RemainingAmt -
                                                                          TempVendLedgEntry."Rem. Amt for WHT FND" +
                                                                          TempVendLedgEntry."Original Pmt. Disc. Possible";

                                                                        WHTEntry.Base := WHTEntry.Base -
                                                                          ABS(TempVendLedgEntry."Rem. Amt for WHT FND" -
                                                                            TempVendLedgEntry."Original Pmt. Disc. Possible");
                                                                        WHTEntry.Amount := WHTEntry.Amount -
                                                                          ROUND(ABS(TempVendLedgEntry."Rem. Amt for WHT FND" -
                                                                              TempVendLedgEntry."Original Pmt. Disc. Possible") * WHTEntry."WHT %" / 100);
                                                                        WHTEntry."Rem Realized Base" := WHTEntry."Rem Realized Base" -
                                                                          ABS(TempVendLedgEntry."Rem. Amt for WHT FND" -
                                                                            TempVendLedgEntry."Original Pmt. Disc. Possible");
                                                                        WHTEntry."Rem Realized Amount" := WHTEntry."Rem Realized Amount" -
                                                                          ROUND(ABS(TempVendLedgEntry."Rem. Amt for WHT FND" -
                                                                              TempVendLedgEntry."Original Pmt. Disc. Possible") * WHTEntry."WHT %" / 100);
                                                                    end else begin
                                                                        if TempVendLedgEntry."Document Type" <>
                                                                           TempVendLedgEntry."Document Type"::"Credit Memo"
                                                                        then
                                                                            TotAmt := TotAmt + TempVendLedgEntry."Rem. Amt for WHT FND";
                                                                        RemainingAmt := RemainingAmt - TempVendLedgEntry."Rem. Amt for WHT FND";

                                                                        WHTEntry.Base := WHTEntry.Base -
                                                                          ABS(TempVendLedgEntry."Rem. Amt for WHT FND");
                                                                        WHTEntry.Amount := WHTEntry.Amount -
                                                                          ROUND(ABS(TempVendLedgEntry."Rem. Amt for WHT FND") * WHTEntry."WHT %" / 100);
                                                                        WHTEntry."Rem Realized Base" := WHTEntry."Rem Realized Base" -
                                                                          ABS(TempVendLedgEntry."Rem. Amt for WHT FND");
                                                                        WHTEntry."Rem Realized Amount" := WHTEntry."Rem Realized Amount" -
                                                                          ROUND(ABS(TempVendLedgEntry."Rem. Amt for WHT FND") * WHTEntry."WHT %" / 100);
                                                                    end;
                                                                    TempWHTEntry."Rem Realized Base" := 0;
                                                                    TempWHTEntry."Rem Realized Amount" := 0;
                                                                    TempWHTEntry."Rem Realized Base (LCY)" := 0;
                                                                    TempWHTEntry."Rem Realized Amount (LCY)" := 0;
                                                                end else begin
                                                                    TempWHTEntry."Rem Realized Base" :=
                                                                      TempWHTEntry."Rem Realized Base" - TotAmt;
                                                                    TempWHTEntry."Rem Realized Amount" :=
                                                                      TempWHTEntry."Rem Realized Amount" -
                                                                      ROUND(ABS(TotAmt) * WHTEntry."WHT %" / 100);
                                                                    WHTEntry.Amount := 0;
                                                                    TotAmt := 0;
                                                                end;
                                                            end;

                                                            if CurrencyCode = '' then begin
                                                                TempWHTEntry."Rem Realized Base (LCY)" := TempWHTEntry."Rem Realized Base";
                                                                TempWHTEntry."Rem Realized Amount (LCY)" := TempWHTEntry."Rem Realized Amount";
                                                            end else begin
                                                                TempWHTEntry."Rem Realized Amount (LCY)" :=
                                                                  ROUND(
                                                                    CurrExchRate.ExchangeAmtFCYToLCY(
                                                                      DocDate, CurrencyCode, TempWHTEntry."Rem Realized Amount (LCY)", CurrFactor));
                                                                TempWHTEntry."Rem Realized Base (LCY)" :=
                                                                  ROUND(
                                                                    CurrExchRate.ExchangeAmtFCYToLCY(
                                                                      DocDate, CurrencyCode, TempWHTEntry."Rem Realized Base (LCY)", CurrFactor));
                                                            end;
                                                            if ((TempWHTEntry."Rem Realized Amount" = 0) and
                                                                (TempWHTEntry."Rem Realized Base" = 0))
                                                            then
                                                                TempWHTEntry.Closed := true;
                                                            TempWHTEntry.MODIFY();
                                                        end;
                                                    end;
                                                until VendLedgerEntry.NEXT() = 0;
                                                if TotAmt > 0 then begin
                                                    WHTEntry.Base := TotAmt;
                                                    WHTEntry.Amount := ROUND(TotAmt * WHTPostingSetup."WHT %" / 100);
                                                    WHTEntry."Rem Realized Amount" := WHTEntry.Amount;
                                                    WHTEntry."Rem Realized Base" := WHTEntry.Base;
                                                    WHTEntry."Entry No." := NextEntryNo();
                                                end else
                                                    WHTEntry."Applies-to Entry No." := TempWHTEntry."Entry No.";
                                            end;
                                        end;

                                        if WHTEntry."Document Type" = WHTEntry."Document Type"::Invoice then begin
                                            VendLedgerEntry.RESET();
                                            VendLedgerEntry.SETRANGE("Applies-to ID", "Applies-toID");
                                            VendLedgerEntry.SETFILTER(
                                              "Document Type",
                                              '%1|%2',
                                              VendLedgerEntry."Document Type"::Payment,
                                              VendLedgerEntry."Document Type"::"Credit Memo");
                                            if VendLedgerEntry.findset() then begin
                                                TotalWHTBase := ABS(WHTEntry."Rem Realized Base");
                                                TotalWHT := ABS(WHTEntry."Rem Realized Amount");
                                                repeat
                                                    TempWHTEntry.RESET();
                                                    TempWHTEntry.SETRANGE(Settled, false);
                                                    TempWHTEntry.SETRANGE("Document No.", VendLedgerEntry."Document No.");
                                                    TempWHTEntry.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                                    TempWHTEntry.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                                    if TempWHTEntry.FINDFIRST() then begin
                                                        if TotalWHT > ABS(TempWHTEntry."Rem Realized Amount") then begin
                                                            if TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::Payment then begin
                                                                WHTEntry.Base := WHTEntry.Base - ABS(TempWHTEntry."Rem Realized Base");
                                                                WHTEntry.Amount := WHTEntry.Amount - ABS(TempWHTEntry."Rem Realized Amount");
                                                            end;
                                                            WHTEntry."Rem Realized Base" := WHTEntry."Rem Realized Base" - ABS(TempWHTEntry."Rem Realized Base");
                                                            WHTEntry."Rem Realized Amount" :=
                                                              WHTEntry."Rem Realized Amount" - ABS(TempWHTEntry."Rem Realized Amount");
                                                            WHTEntry."Rem Realized Base" := WHTEntry."Rem Realized Base" - ABS(TempWHTEntry."Rem Realized Base");
                                                            WHTEntry."Rem Realized Amount" :=
                                                              WHTEntry."Rem Realized Amount" - ABS(TempWHTEntry."Rem Realized Amount");
                                                            TotalWHTBase := TotalWHTBase - ABS(TempWHTEntry."Rem Realized Base");
                                                            TotalWHT := TotalWHT - ABS(TempWHTEntry."Rem Realized Amount");
                                                            TempWHTEntry."Rem Realized Base" := 0;
                                                            TempWHTEntry."Rem Realized Amount" := 0;
                                                            TempWHTEntry."Rem Realized Base (LCY)" := 0;
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := 0;
                                                        end else begin
                                                            if (TotalWHT > 0) and (TotalWHT <= ABS(TempWHTEntry."Rem Realized Amount")) then begin
                                                                if TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::"Credit Memo" then begin
                                                                    TempWHTEntry."Rem Realized Base" :=
                                                                      TempWHTEntry."Rem Realized Base" + TotalWHTBase;
                                                                    TempWHTEntry."Rem Realized Amount" :=
                                                                      TempWHTEntry."Rem Realized Amount" + TotalWHT;
                                                                end else begin
                                                                    TempWHTEntry."Rem Realized Base" :=
                                                                      TempWHTEntry."Rem Realized Base" - TotalWHTBase;
                                                                    TempWHTEntry."Rem Realized Amount" :=
                                                                      TempWHTEntry."Rem Realized Amount" - TotalWHT;
                                                                    WHTEntry.Base := 0;
                                                                    WHTEntry.Amount := 0;
                                                                end;
                                                                WHTEntry."Rem Realized Amount" := 0;
                                                                WHTEntry."Rem Realized Base" := 0;
                                                                TotalWHTBase := 0;
                                                                TotalWHT := 0;
                                                            end;
                                                        end;

                                                        if CurrencyCode = '' then begin
                                                            TempWHTEntry."Rem Realized Base (LCY)" := TempWHTEntry."Rem Realized Base";
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := TempWHTEntry."Rem Realized Amount";
                                                        end else begin
                                                            TempWHTEntry."Rem Realized Amount (LCY)" :=
                                                              ROUND(
                                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                                  DocDate, CurrencyCode, TempWHTEntry."Rem Realized Amount (LCY)", CurrFactor));
                                                            TempWHTEntry."Rem Realized Base (LCY)" :=
                                                              ROUND(
                                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                                  DocDate, CurrencyCode, TempWHTEntry."Rem Realized Base (LCY)", CurrFactor));
                                                        end;
                                                        if ((TempWHTEntry."Rem Realized Amount" = 0) and
                                                            (TempWHTEntry."Rem Realized Base" = 0))
                                                        then
                                                            TempWHTEntry.Closed := true;
                                                        TempWHTEntry.MODIFY();
                                                    end;
                                                until VendLedgerEntry.NEXT() = 0;
                                                WHTEntry."Applies-to Entry No." := TempWHTEntry."Entry No.";
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;

                        // Purchase Credit Memo & Refund
                        if ((WHTEntry."Document Type" = WHTEntry."Document Type"::"Credit Memo") or
                            (WHTEntry."Document Type" = WHTEntry."Document Type"::Refund))
                        then begin
                            WHTEntry.Base := -ABS(WHTEntry.Base);
                            WHTEntry.Amount := -ABS(WHTEntry.Amount);
                            WHTEntry."Payment Amount" := -ABS(Amount);
                            WHTEntry."Rem Realized Base" := WHTEntry.Base;
                            WHTEntry."Rem Realized Amount" := WHTEntry.Amount;
                            if (WHTPostingSetup."Realized WHT Type" =
                                WHTPostingSetup."Realized WHT Type"::Earliest)
                            then begin
                                if WHTEntry."Applies-to Doc. No." <> '' then begin
                                    TempWHTEntry.RESET();
                                    // TempWHTEntry.SETRANGE(Settled,FALSE);
                                    TempWHTEntry.SETRANGE("Document Type", WHTEntry."Applies-to Doc. Type");
                                    TempWHTEntry.SETRANGE("Document No.", WHTEntry."Applies-to Doc. No.");
                                    TempWHTEntry.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                    TempWHTEntry.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                    if WHTEntry."Document Type" = WHTEntry."Document Type"::"Credit Memo" then
                                        TempWHTEntry.SETFILTER(
                                          "Document Type",
                                          '%1|%2',
                                          TempWHTEntry."Document Type"::Refund,
                                          TempWHTEntry."Document Type"::Invoice);

                                    if WHTEntry."Document Type" = WHTEntry."Document Type"::Refund then
                                        TempWHTEntry.SETFILTER(
                                          "Document Type",
                                          '%1|%2',
                                          TempWHTEntry."Document Type"::"Credit Memo",
                                          TempWHTEntry."Document Type"::Payment);

                                    if TempWHTEntry.FINDFIRST() then begin
                                        if ABS(TempWHTEntry."Rem Realized Amount") >= ABS(WHTEntry.Amount) then begin
                                            if ((TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::Invoice) or
                                                (TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::Payment))
                                            then begin
                                                TempWHTEntry."Rem Realized Base" :=
                                                  TempWHTEntry."Rem Realized Base" + WHTEntry.Base;
                                                TempWHTEntry."Rem Realized Amount" :=
                                                  TempWHTEntry."Rem Realized Amount" + WHTEntry.Amount;
                                                WHTEntry."Rem Realized Base" := 0;
                                                WHTEntry."Rem Realized Amount" := 0;
                                            end else begin
                                                TempWHTEntry."Rem Realized Base" :=
                                                  TempWHTEntry."Rem Realized Base" - WHTEntry.Base;
                                                TempWHTEntry."Rem Realized Amount" :=
                                                  TempWHTEntry."Rem Realized Amount" - WHTEntry.Amount;
                                                WHTEntry.Amount := 0;
                                            end;

                                            if CurrencyCode = '' then begin
                                                TempWHTEntry."Rem Realized Base (LCY)" := TempWHTEntry."Rem Realized Base";
                                                TempWHTEntry."Rem Realized Amount (LCY)" := TempWHTEntry."Rem Realized Amount";
                                            end else begin
                                                TempWHTEntry."Rem Realized Amount (LCY)" :=
                                                  ROUND(
                                                    CurrExchRate.ExchangeAmtFCYToLCY(
                                                      DocDate, CurrencyCode, TempWHTEntry."Rem Realized Amount (LCY)", CurrFactor));
                                                TempWHTEntry."Rem Realized Base (LCY)" :=
                                                  ROUND(
                                                    CurrExchRate.ExchangeAmtFCYToLCY(
                                                      DocDate, CurrencyCode, TempWHTEntry."Rem Realized Base (LCY)", CurrFactor));
                                            end;
                                        end else begin
                                            if ((TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::Invoice) or
                                                (TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::Payment))
                                            then begin
                                                WHTEntry."Rem Realized Base" := WHTEntry."Rem Realized Base" + TempWHTEntry."Rem Realized Base";
                                                WHTEntry."Rem Realized Amount" := WHTEntry."Rem Realized Amount" + TempWHTEntry."Rem Realized Amount";
                                            end else begin
                                                WHTEntry.Base := WHTEntry.Base - TempWHTEntry."Rem Realized Base";
                                                WHTEntry.Amount := WHTEntry.Amount - TempWHTEntry."Rem Realized Amount";
                                                WHTEntry."Rem Realized Base" := WHTEntry."Rem Realized Base" - TempWHTEntry."Rem Realized Base";
                                                WHTEntry."Rem Realized Amount" := WHTEntry."Rem Realized Amount" - TempWHTEntry."Rem Realized Amount";
                                            end;
                                            TempWHTEntry."Rem Realized Base" := 0;
                                            TempWHTEntry."Rem Realized Amount" := 0;
                                            TempWHTEntry."Rem Realized Base (LCY)" := 0;
                                            TempWHTEntry."Rem Realized Amount (LCY)" := 0;
                                        end;

                                        if ((TempWHTEntry."Rem Realized Amount" = 0) and
                                            (TempWHTEntry."Rem Realized Base" = 0))
                                        then
                                            TempWHTEntry.Closed := true;
                                        TempWHTEntry.MODIFY();
                                    end;
                                end else begin
                                    if "Applies-toID" <> '' then begin
                                        if WHTEntry."Document Type" = WHTEntry."Document Type"::"Credit Memo" then begin
                                            VendLedgerEntry.RESET();
                                            VendLedgerEntry.SETRANGE("Applies-to ID", "Applies-toID");
                                            VendLedgerEntry.SETRANGE("Document Type", VendLedgerEntry."Document Type"::Refund);
                                            if VendLedgerEntry.findset() then begin
                                                TotalWHTBase := WHTEntry."Rem Realized Base";
                                                TotalWHT := WHTEntry."Rem Realized Amount";
                                                repeat
                                                    TempWHTEntry.RESET();
                                                    TempWHTEntry.SETRANGE(Settled, false);
                                                    TempWHTEntry.SETRANGE("Document No.", VendLedgerEntry."Document No.");
                                                    TempWHTEntry.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                                    TempWHTEntry.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                                    if TempWHTEntry.FINDFIRST() then begin
                                                        if ABS(TotalWHT) > ABS(TempWHTEntry."Rem Realized Amount") then begin
                                                            WHTEntry.Base := WHTEntry.Base + TempWHTEntry."Rem Realized Base";
                                                            WHTEntry.Amount := WHTEntry.Amount + TempWHTEntry."Rem Realized Amount";
                                                            WHTEntry."Rem Realized Base" :=
                                                              WHTEntry."Rem Realized Base" + TempWHTEntry."Rem Realized Base";
                                                            WHTEntry."Rem Realized Amount" :=
                                                              WHTEntry."Rem Realized Amount" + TempWHTEntry."Rem Realized Amount";
                                                            TotalWHTBase := TotalWHTBase - ABS(TempWHTEntry."Rem Realized Base");
                                                            TotalWHT := TotalWHT - ABS(TempWHTEntry."Rem Realized Amount");
                                                            TempWHTEntry."Rem Realized Base" := 0;
                                                            TempWHTEntry."Rem Realized Amount" := 0;
                                                            TempWHTEntry."Rem Realized Base (LCY)" := 0;
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := 0;
                                                        end else begin
                                                            if (ABS(TotalWHT) > 0) and (ABS(TotalWHT) <= ABS(TempWHTEntry."Rem Realized Amount")) then begin
                                                                TempWHTEntry."Rem Realized Base" :=
                                                                  TempWHTEntry."Rem Realized Base" + TotalWHTBase;
                                                                TempWHTEntry."Rem Realized Amount" :=
                                                                  TempWHTEntry."Rem Realized Amount" + TotalWHT;
                                                                WHTEntry.Base := 0;
                                                                WHTEntry.Amount := 0;
                                                                WHTEntry."Rem Realized Amount" := 0;
                                                                WHTEntry."Rem Realized Base" := 0;
                                                                TotalWHTBase := 0;
                                                                TotalWHT := 0;
                                                            end;
                                                        end;

                                                        if CurrencyCode = '' then begin
                                                            TempWHTEntry."Rem Realized Base (LCY)" := TempWHTEntry."Rem Realized Base";
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := TempWHTEntry."Rem Realized Amount";
                                                        end else begin
                                                            TempWHTEntry."Rem Realized Amount (LCY)" :=
                                                              ROUND(
                                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                                  DocDate, CurrencyCode, TempWHTEntry."Rem Realized Amount (LCY)", CurrFactor));
                                                            TempWHTEntry."Rem Realized Base (LCY)" :=
                                                              ROUND(
                                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                                  DocDate, CurrencyCode, TempWHTEntry."Rem Realized Base (LCY)", CurrFactor));
                                                        end;
                                                        if ((TempWHTEntry."Rem Realized Amount" = 0) and
                                                            (TempWHTEntry."Rem Realized Base" = 0))
                                                        then
                                                            TempWHTEntry.Closed := true;
                                                        TempWHTEntry.MODIFY();
                                                    end;
                                                until VendLedgerEntry.NEXT() = 0;
                                                WHTEntry."Applies-to Entry No." := TempWHTEntry."Entry No.";
                                            end;

                                            VendLedgerEntry.RESET();
                                            VendLedgerEntry.SETRANGE("Applies-to ID", "Applies-toID");
                                            VendLedgerEntry.SETRANGE("Document Type", VendLedgerEntry."Document Type"::Invoice);
                                            if VendLedgerEntry.findset() then begin
                                                TotalWHTBase := ABS(WHTEntry."Rem Realized Base");
                                                TotalWHT := ABS(WHTEntry."Rem Realized Amount");
                                                repeat
                                                    TempWHTEntry.RESET();
                                                    TempWHTEntry.SETRANGE(Settled, false);
                                                    TempWHTEntry.SETRANGE("Document No.", VendLedgerEntry."Document No.");
                                                    TempWHTEntry.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                                    TempWHTEntry.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                                    if TempWHTEntry.FINDFIRST() then begin
                                                        if TotalWHT > ABS(TempWHTEntry."Rem Realized Amount") then begin
                                                            WHTEntry."Rem Realized Base" := WHTEntry."Rem Realized Base" + TempWHTEntry."Rem Realized Base";
                                                            WHTEntry."Rem Realized Amount" := WHTEntry."Rem Realized Amount" + TempWHTEntry."Rem Realized Amount";
                                                            TotalWHTBase := TotalWHTBase - ABS(TempWHTEntry."Rem Realized Base");
                                                            TotalWHT := TotalWHT - ABS(TempWHTEntry."Rem Realized Amount");
                                                            TempWHTEntry."Rem Realized Base" := 0;
                                                            TempWHTEntry."Rem Realized Amount" := 0;
                                                            TempWHTEntry."Rem Realized Base (LCY)" := 0;
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := 0;
                                                        end else begin
                                                            if (TotalWHT > 0) and (ABS(TotalWHT) <= ABS(TempWHTEntry."Rem Realized Amount")) then begin
                                                                TempWHTEntry."Rem Realized Base" :=
                                                                  TempWHTEntry."Rem Realized Base" - TotalWHTBase;
                                                                TempWHTEntry."Rem Realized Amount" :=
                                                                  TempWHTEntry."Rem Realized Amount" - TotalWHT;
                                                                WHTEntry."Rem Realized Amount" := 0;
                                                                WHTEntry."Rem Realized Base" := 0;
                                                                TotalWHTBase := 0;
                                                                TotalWHT := 0;
                                                            end;
                                                        end;

                                                        if CurrencyCode = '' then begin
                                                            TempWHTEntry."Rem Realized Base (LCY)" := TempWHTEntry."Rem Realized Base";
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := TempWHTEntry."Rem Realized Amount";
                                                        end else begin
                                                            TempWHTEntry."Rem Realized Amount (LCY)" :=
                                                              ROUND(
                                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                                  DocDate, CurrencyCode, TempWHTEntry."Rem Realized Amount (LCY)", CurrFactor));
                                                            TempWHTEntry."Rem Realized Base (LCY)" :=
                                                              ROUND(
                                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                                  DocDate, CurrencyCode, TempWHTEntry."Rem Realized Base (LCY)", CurrFactor));
                                                        end;
                                                        if ((TempWHTEntry."Rem Realized Amount" = 0) and
                                                            (TempWHTEntry."Rem Realized Base" = 0))
                                                        then
                                                            TempWHTEntry.Closed := true;
                                                        TempWHTEntry.MODIFY();
                                                    end;
                                                until VendLedgerEntry.NEXT() = 0;
                                                WHTEntry."Applies-to Entry No." := TempWHTEntry."Entry No.";
                                            end;
                                        end;

                                        if WHTEntry."Document Type" = WHTEntry."Document Type"::Refund then begin
                                            VendLedgerEntry.RESET();
                                            VendLedgerEntry.SETRANGE("Applies-to ID", "Applies-toID");
                                            VendLedgerEntry.SETFILTER(
                                              "Document Type",
                                              '%1|%2',
                                              VendLedgerEntry."Document Type"::Payment,
                                              VendLedgerEntry."Document Type"::"Credit Memo");
                                            if VendLedgerEntry.findset() then begin
                                                TotalWHTBase := ABS(WHTEntry."Rem Realized Base");
                                                TotalWHT := ABS(WHTEntry."Rem Realized Amount");
                                                repeat
                                                    TempWHTEntry.RESET();
                                                    TempWHTEntry.SETRANGE(Settled, false);
                                                    TempWHTEntry.SETRANGE("Document No.", VendLedgerEntry."Document No.");
                                                    TempWHTEntry.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                                    TempWHTEntry.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                                    if TempWHTEntry.FINDFIRST() then begin
                                                        if TotalWHT > ABS(TempWHTEntry."Rem Realized Amount") then begin
                                                            if TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::"Credit Memo" then begin
                                                                WHTEntry.Base := WHTEntry.Base + ABS(TempWHTEntry."Rem Realized Base");
                                                                WHTEntry.Amount := WHTEntry.Amount + ABS(TempWHTEntry."Rem Realized Amount");
                                                            end;
                                                            WHTEntry."Rem Realized Base" := WHTEntry."Rem Realized Base" + ABS(TempWHTEntry."Rem Realized Base");
                                                            WHTEntry."Rem Realized Amount" :=
                                                              WHTEntry."Rem Realized Amount" + ABS(TempWHTEntry."Rem Realized Amount");
                                                            TotalWHTBase := TotalWHTBase - ABS(TempWHTEntry."Rem Realized Base");
                                                            TotalWHT := TotalWHT - ABS(TempWHTEntry."Rem Realized Amount");
                                                            TempWHTEntry."Rem Realized Base" := 0;
                                                            TempWHTEntry."Rem Realized Amount" := 0;
                                                            TempWHTEntry."Rem Realized Base (LCY)" := 0;
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := 0;
                                                        end else begin
                                                            if (TotalWHT > 0) and (TotalWHT <= ABS(TempWHTEntry."Rem Realized Amount")) then begin
                                                                if TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::Payment then begin
                                                                    TempWHTEntry."Rem Realized Base" :=
                                                                      TempWHTEntry."Rem Realized Base" - TotalWHTBase;
                                                                    TempWHTEntry."Rem Realized Amount" :=
                                                                      TempWHTEntry."Rem Realized Amount" - TotalWHT;
                                                                end else begin
                                                                    TempWHTEntry."Rem Realized Base" :=
                                                                      TempWHTEntry."Rem Realized Base" + TotalWHTBase;
                                                                    TempWHTEntry."Rem Realized Amount" :=
                                                                      TempWHTEntry."Rem Realized Amount" + TotalWHT;
                                                                    WHTEntry.Base := 0;
                                                                    WHTEntry.Amount := 0;
                                                                end;
                                                                WHTEntry."Rem Realized Amount" := 0;
                                                                WHTEntry."Rem Realized Base" := 0;
                                                                TotalWHTBase := 0;
                                                                TotalWHT := 0;
                                                            end;
                                                        end;

                                                        if CurrencyCode = '' then begin
                                                            TempWHTEntry."Rem Realized Base (LCY)" := TempWHTEntry."Rem Realized Base";
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := TempWHTEntry."Rem Realized Amount";
                                                        end else begin
                                                            TempWHTEntry."Rem Realized Amount (LCY)" :=
                                                              ROUND(
                                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                                  DocDate, CurrencyCode, TempWHTEntry."Rem Realized Amount (LCY)", CurrFactor));
                                                            TempWHTEntry."Rem Realized Base (LCY)" :=
                                                              ROUND(
                                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                                  DocDate, CurrencyCode, TempWHTEntry."Rem Realized Base (LCY)", CurrFactor));
                                                        end;
                                                        if ((TempWHTEntry."Rem Realized Amount" = 0) and
                                                            (TempWHTEntry."Rem Realized Base" = 0))
                                                        then
                                                            TempWHTEntry.Closed := true;
                                                        TempWHTEntry.MODIFY();
                                                    end;
                                                until VendLedgerEntry.NEXT() = 0;
                                                WHTEntry."Applies-to Entry No." := TempWHTEntry."Entry No.";
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;

                    if TransType = TransType::Sale then begin
                        if ((WHTEntry."Document Type" = WHTEntry."Document Type"::Invoice) or
                            (WHTEntry."Document Type" = WHTEntry."Document Type"::Payment))
                        then begin
                            WHTEntry.Base := -ABS(WHTEntry.Base);
                            WHTEntry.Amount := -ABS(WHTEntry.Amount);
                            WHTEntry."Payment Amount" := -ABS(Amount);
                            WHTEntry."Rem Realized Base" := WHTEntry.Base;
                            WHTEntry."Rem Realized Amount" := WHTEntry.Amount;
                            if (WHTPostingSetup."Realized WHT Type" =
                                WHTPostingSetup."Realized WHT Type"::Earliest)
                            then begin
                                if WHTEntry."Applies-to Doc. No." <> '' then begin
                                    CustLedgerEntry.RESET();
                                    CustLedgerEntry.SETRANGE("Document No.", WHTEntry."Applies-to Doc. No.");
                                    CustLedgerEntry.SETRANGE("Document Type", WHTEntry."Applies-to Doc. Type");
                                    CustLedgerEntry.SETRANGE(Prepayment, false);
                                    if CustLedgerEntry.FINDFIRST() then begin
                                        TempWHTEntry.RESET();
                                        TempWHTEntry.SETRANGE(Settled, false);
                                        TempWHTEntry.SETRANGE("Document Type", WHTEntry."Applies-to Doc. Type");
                                        TempWHTEntry.SETRANGE("Document No.", WHTEntry."Applies-to Doc. No.");
                                        TempWHTEntry.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                        TempWHTEntry.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                        if WHTEntry."Document Type" = WHTEntry."Document Type"::Invoice then
                                            TempWHTEntry.SETFILTER(
                                              "Document Type",
                                              '%1|%2',
                                              TempWHTEntry."Document Type"::Payment,
                                              TempWHTEntry."Document Type"::"Credit Memo");

                                        if WHTEntry."Document Type" = WHTEntry."Document Type"::Payment then
                                            TempWHTEntry.SETFILTER(
                                              "Document Type",
                                              '%1|%2',
                                              TempWHTEntry."Document Type"::Invoice,
                                              TempWHTEntry."Document Type"::Refund);

                                        if TempWHTEntry.FINDFIRST() then begin
                                            if ABS(TempWHTEntry."Rem Realized Amount") >= ABS(WHTEntry.Amount) then begin
                                                if ((TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::"Credit Memo") or
                                                    (TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::Refund))
                                                then begin
                                                    TempWHTEntry."Rem Realized Base" :=
                                                      TempWHTEntry."Rem Realized Base" - WHTEntry.Base;
                                                    TempWHTEntry."Rem Realized Amount" :=
                                                      TempWHTEntry."Rem Realized Amount" - WHTEntry.Amount;
                                                    WHTEntry."Rem Realized Base" := 0;
                                                    WHTEntry."Rem Realized Amount" := 0;
                                                end else begin
                                                    TempWHTEntry."Rem Realized Base" :=
                                                      TempWHTEntry."Rem Realized Base" - WHTEntry.Base;
                                                    TempWHTEntry."Rem Realized Amount" :=
                                                      TempWHTEntry."Rem Realized Amount" - WHTEntry.Amount;
                                                    WHTEntry.Amount := 0;
                                                end;

                                                if CurrencyCode = '' then begin
                                                    TempWHTEntry."Rem Realized Base (LCY)" := TempWHTEntry."Rem Realized Base";
                                                    TempWHTEntry."Rem Realized Amount (LCY)" := TempWHTEntry."Rem Realized Amount";
                                                end else begin
                                                    TempWHTEntry."Rem Realized Amount (LCY)" :=
                                                      ROUND(
                                                        CurrExchRate.ExchangeAmtFCYToLCY(
                                                          DocDate, CurrencyCode, TempWHTEntry."Rem Realized Amount (LCY)", CurrFactor));
                                                    TempWHTEntry."Rem Realized Base (LCY)" :=
                                                      ROUND(
                                                        CurrExchRate.ExchangeAmtFCYToLCY(
                                                          DocDate, CurrencyCode, TempWHTEntry."Rem Realized Base (LCY)", CurrFactor));
                                                end;
                                            end else begin
                                                if ((TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::"Credit Memo") or
                                                    (TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::Refund))
                                                then begin
                                                    WHTEntry."Rem Realized Base" := WHTEntry."Rem Realized Base" - TempWHTEntry."Rem Realized Base";
                                                    WHTEntry."Rem Realized Amount" := WHTEntry."Rem Realized Amount" - TempWHTEntry."Rem Realized Amount";
                                                end else begin
                                                    WHTEntry.Base := WHTEntry.Base - TempWHTEntry."Rem Realized Base";
                                                    WHTEntry.Amount := WHTEntry.Amount - TempWHTEntry."Rem Realized Amount";
                                                    WHTEntry."Rem Realized Base" := WHTEntry."Rem Realized Base" - TempWHTEntry."Rem Realized Base";
                                                    WHTEntry."Rem Realized Amount" := WHTEntry."Rem Realized Amount" - TempWHTEntry."Rem Realized Amount";
                                                end;
                                                TempWHTEntry."Rem Realized Base" := 0;
                                                TempWHTEntry."Rem Realized Amount" := 0;
                                                TempWHTEntry."Rem Realized Base (LCY)" := 0;
                                                TempWHTEntry."Rem Realized Amount (LCY)" := 0;
                                            end;

                                            if (TempWHTEntry."Rem Realized Amount" = 0) and
                                               (TempWHTEntry."Rem Realized Base" = 0)
                                            then
                                                TempWHTEntry.Closed := true;
                                            TempWHTEntry.MODIFY();
                                        end;
                                    end else
                                        WHTEntry.Amount := 0;
                                end else begin
                                    if "Applies-toID" <> '' then begin
                                        if WHTEntry."Document Type" = WHTEntry."Document Type"::Payment then begin
                                            IsRefund := false;
                                            CustLedgerEntry.RESET();
                                            CustLedgerEntry.SETRANGE("Applies-to ID", "Applies-toID");
                                            CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Refund);
                                            if CustLedgerEntry.FINDFIRST() then begin
                                                TotalWHTBase := ABS(WHTEntry."Rem Realized Base");
                                                TotalWHT := ABS(WHTEntry."Rem Realized Amount");
                                                IsRefund := true;
                                                repeat
                                                    TempWHTEntry.RESET();
                                                    TempWHTEntry.SETRANGE(Settled, false);
                                                    TempWHTEntry.SETRANGE("Document No.", CustLedgerEntry."Document No.");
                                                    TempWHTEntry.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                                    TempWHTEntry.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                                    if TempWHTEntry.FINDFIRST() then begin
                                                        if TotalWHT > ABS(TempWHTEntry."Rem Realized Amount") then begin
                                                            WHTEntry."Rem Realized Base" :=
                                                              WHTEntry."Rem Realized Base" + TempWHTEntry."Rem Realized Base";
                                                            WHTEntry."Rem Realized Amount" :=
                                                              WHTEntry."Rem Realized Amount" + TempWHTEntry."Rem Realized Amount";
                                                            TotalWHTBase := TotalWHTBase - ABS(TempWHTEntry."Rem Realized Base");
                                                            TotalWHT := TotalWHT - ABS(TempWHTEntry."Rem Realized Amount");
                                                            TempWHTEntry."Rem Realized Base" := 0;
                                                            TempWHTEntry."Rem Realized Amount" := 0;
                                                            TempWHTEntry."Rem Realized Base (LCY)" := 0;
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := 0;
                                                        end else begin
                                                            if (TotalWHT > 0) and (ABS(TotalWHT) <= ABS(TempWHTEntry."Rem Realized Amount")) then begin
                                                                TempWHTEntry."Rem Realized Base" :=
                                                                  TempWHTEntry."Rem Realized Base" - TotalWHTBase;
                                                                TempWHTEntry."Rem Realized Amount" :=
                                                                  TempWHTEntry."Rem Realized Amount" - TotalWHT;
                                                                WHTEntry."Rem Realized Amount" := 0;
                                                                WHTEntry."Rem Realized Base" := 0;
                                                                TotalWHTBase := 0;
                                                                TotalWHT := 0;
                                                            end;
                                                        end;

                                                        if CurrencyCode = '' then begin
                                                            TempWHTEntry."Rem Realized Base (LCY)" := TempWHTEntry."Rem Realized Base";
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := TempWHTEntry."Rem Realized Amount";
                                                        end else begin
                                                            TempWHTEntry."Rem Realized Amount (LCY)" :=
                                                              ROUND(
                                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                                  DocDate, CurrencyCode, TempWHTEntry."Rem Realized Amount (LCY)", CurrFactor));
                                                            TempWHTEntry."Rem Realized Base (LCY)" :=
                                                              ROUND(
                                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                                  DocDate, CurrencyCode, TempWHTEntry."Rem Realized Base (LCY)", CurrFactor));
                                                        end;
                                                        if ((TempWHTEntry."Rem Realized Amount" = 0) and
                                                            (TempWHTEntry."Rem Realized Base" = 0))
                                                        then
                                                            TempWHTEntry.Closed := true;
                                                        TempWHTEntry.MODIFY();
                                                    end;
                                                until CustLedgerEntry.NEXT() = 0;
                                                WHTEntry."Applies-to Entry No." := TempWHTEntry."Entry No.";
                                            end;

                                            CustLedgerEntry.RESET();
                                            CustLedgerEntry.SETRANGE("Applies-to ID", "Applies-toID");
                                            CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                                            CustLedgerEntry.SETRANGE(Prepayment, false);
                                            if CustLedgerEntry.findset() then begin
                                                TotalWHTBase := ABS(WHTEntry."Rem Realized Base");
                                                TotalWHT := ABS(WHTEntry."Rem Realized Amount");
                                                repeat
                                                    TempWHTEntry.RESET();
                                                    TempWHTEntry.SETRANGE(Settled, false);
                                                    TempWHTEntry.SETRANGE("Document No.", CustLedgerEntry."Document No.");
                                                    TempWHTEntry.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                                    TempWHTEntry.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                                    if TempWHTEntry.FINDFIRST() then begin
                                                        if TotalWHT > ABS(TempWHTEntry."Rem Realized Amount") then begin
                                                            WHTEntry.Base := WHTEntry.Base + TempWHTEntry."Rem Realized Base";
                                                            WHTEntry.Amount := WHTEntry.Amount + TempWHTEntry."Rem Realized Amount";
                                                            WHTEntry."Rem Realized Base" := WHTEntry."Rem Realized Base" + TempWHTEntry."Rem Realized Base";
                                                            WHTEntry."Rem Realized Amount" := WHTEntry."Rem Realized Amount" + TempWHTEntry."Rem Realized Amount";
                                                            TotalWHTBase := TotalWHTBase - ABS(TempWHTEntry."Rem Realized Base");
                                                            TotalWHT := TotalWHT - ABS(TempWHTEntry."Rem Realized Amount");
                                                            TempWHTEntry."Rem Realized Base" := 0;
                                                            TempWHTEntry."Rem Realized Amount" := 0;
                                                            TempWHTEntry."Rem Realized Base (LCY)" := 0;
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := 0;
                                                        end else begin
                                                            if (TotalWHT > 0) and (ABS(TotalWHT) <= ABS(TempWHTEntry."Rem Realized Amount")) then begin
                                                                TempWHTEntry."Rem Realized Base" :=
                                                                  TempWHTEntry."Rem Realized Base" + TotalWHTBase;
                                                                TempWHTEntry."Rem Realized Amount" :=
                                                                  TempWHTEntry."Rem Realized Amount" + TotalWHT;
                                                                WHTEntry.Base := 0;
                                                                WHTEntry.Amount := 0;
                                                                WHTEntry."Rem Realized Amount" := 0;
                                                                WHTEntry."Rem Realized Base" := 0;
                                                                TotalWHTBase := 0;
                                                                TotalWHT := 0;
                                                            end;
                                                        end;

                                                        if CurrencyCode = '' then begin
                                                            TempWHTEntry."Rem Realized Base (LCY)" := TempWHTEntry."Rem Realized Base";
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := TempWHTEntry."Rem Realized Amount";
                                                        end else begin
                                                            TempWHTEntry."Rem Realized Amount (LCY)" :=
                                                              ROUND(
                                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                                  DocDate, CurrencyCode, TempWHTEntry."Rem Realized Amount (LCY)", CurrFactor));
                                                            TempWHTEntry."Rem Realized Base (LCY)" :=
                                                              ROUND(
                                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                                  DocDate, CurrencyCode, TempWHTEntry."Rem Realized Base (LCY)", CurrFactor));
                                                        end;
                                                        if ((TempWHTEntry."Rem Realized Amount" = 0) and
                                                            (TempWHTEntry."Rem Realized Base" = 0))
                                                        then
                                                            TempWHTEntry.Closed := true;
                                                        TempWHTEntry.MODIFY();
                                                    end;
                                                until CustLedgerEntry.NEXT() = 0;
                                                WHTEntry."Applies-to Entry No." := TempWHTEntry."Entry No.";
                                            end else
                                                if not IsRefund then
                                                    WHTEntry.Amount := 0;
                                        end;

                                        if WHTEntry."Document Type" = WHTEntry."Document Type"::Invoice then begin
                                            CustLedgerEntry.RESET();
                                            CustLedgerEntry.SETRANGE("Applies-to ID", "Applies-toID");
                                            CustLedgerEntry.SETFILTER(
                                              "Document Type",
                                              '%1|%2',
                                              CustLedgerEntry."Document Type"::Payment,
                                              CustLedgerEntry."Document Type"::"Credit Memo");
                                            if CustLedgerEntry.findset() then begin
                                                TotalWHTBase := ABS(WHTEntry."Rem Realized Base");
                                                TotalWHT := ABS(WHTEntry."Rem Realized Amount");
                                                repeat
                                                    TempWHTEntry.RESET();
                                                    TempWHTEntry.SETRANGE(Settled, false);
                                                    TempWHTEntry.SETRANGE("Document No.", CustLedgerEntry."Document No.");
                                                    TempWHTEntry.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                                    TempWHTEntry.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                                    if TempWHTEntry.FINDFIRST() then begin
                                                        if TotalWHT > ABS(TempWHTEntry."Rem Realized Amount") then begin
                                                            if TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::Payment then begin
                                                                WHTEntry.Base := WHTEntry.Base + ABS(TempWHTEntry."Rem Realized Base");
                                                                WHTEntry.Amount := WHTEntry.Amount + ABS(TempWHTEntry."Rem Realized Amount");
                                                            end;
                                                            WHTEntry."Rem Realized Base" := WHTEntry."Rem Realized Base" + ABS(TempWHTEntry."Rem Realized Base");
                                                            WHTEntry."Rem Realized Amount" :=
                                                              WHTEntry."Rem Realized Amount" + ABS(TempWHTEntry."Rem Realized Amount");
                                                            TotalWHTBase := TotalWHTBase - ABS(TempWHTEntry."Rem Realized Base");
                                                            TotalWHT := TotalWHT - ABS(TempWHTEntry."Rem Realized Amount");
                                                            TempWHTEntry."Rem Realized Base" := 0;
                                                            TempWHTEntry."Rem Realized Amount" := 0;
                                                            TempWHTEntry."Rem Realized Base (LCY)" := 0;
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := 0;
                                                        end else begin
                                                            if (TotalWHT > 0) and (TotalWHT <= ABS(TempWHTEntry."Rem Realized Amount")) then begin
                                                                if TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::"Credit Memo" then begin
                                                                    TempWHTEntry."Rem Realized Base" :=
                                                                      TempWHTEntry."Rem Realized Base" - TotalWHTBase;
                                                                    TempWHTEntry."Rem Realized Amount" :=
                                                                      TempWHTEntry."Rem Realized Amount" - TotalWHT;
                                                                end else begin
                                                                    TempWHTEntry."Rem Realized Base" :=
                                                                      TempWHTEntry."Rem Realized Base" + TotalWHTBase;
                                                                    TempWHTEntry."Rem Realized Amount" :=
                                                                      TempWHTEntry."Rem Realized Amount" + TotalWHT;
                                                                    WHTEntry.Base := 0;
                                                                    WHTEntry.Amount := 0;
                                                                end;
                                                                WHTEntry."Rem Realized Amount" := 0;
                                                                WHTEntry."Rem Realized Base" := 0;
                                                                TotalWHTBase := 0;
                                                                TotalWHT := 0;
                                                            end;
                                                        end;

                                                        if CurrencyCode = '' then begin
                                                            TempWHTEntry."Rem Realized Base (LCY)" := TempWHTEntry."Rem Realized Base";
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := TempWHTEntry."Rem Realized Amount";
                                                        end else begin
                                                            TempWHTEntry."Rem Realized Amount (LCY)" :=
                                                              ROUND(
                                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                                  DocDate, CurrencyCode, TempWHTEntry."Rem Realized Amount (LCY)", CurrFactor));
                                                            TempWHTEntry."Rem Realized Base (LCY)" :=
                                                              ROUND(
                                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                                  DocDate, CurrencyCode, TempWHTEntry."Rem Realized Base (LCY)", CurrFactor));
                                                        end;
                                                        if ((TempWHTEntry."Rem Realized Amount" = 0) and
                                                            (TempWHTEntry."Rem Realized Base" = 0))
                                                        then
                                                            TempWHTEntry.Closed := true;
                                                        TempWHTEntry.MODIFY();
                                                    end;
                                                until CustLedgerEntry.NEXT() = 0;
                                                WHTEntry."Applies-to Entry No." := TempWHTEntry."Entry No.";
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;

                        // sales Credit Memo & Refund
                        if ((WHTEntry."Document Type" = WHTEntry."Document Type"::"Credit Memo") or
                            (WHTEntry."Document Type" = WHTEntry."Document Type"::Refund))
                        then begin
                            WHTEntry.Base := ABS(WHTEntry.Base);
                            WHTEntry.Amount := ABS(WHTEntry.Amount);
                            WHTEntry."Payment Amount" := ABS(Amount);
                            WHTEntry."Rem Realized Base" := WHTEntry.Base;
                            WHTEntry."Rem Realized Amount" := WHTEntry.Amount;
                            if (WHTPostingSetup."Realized WHT Type" =
                                WHTPostingSetup."Realized WHT Type"::Earliest)
                            then begin
                                if WHTEntry."Applies-to Doc. No." <> '' then begin
                                    TempWHTEntry.RESET();
                                    TempWHTEntry.SETRANGE(Settled, false);
                                    TempWHTEntry.SETRANGE("Document Type", WHTEntry."Applies-to Doc. Type");
                                    TempWHTEntry.SETRANGE("Document No.", WHTEntry."Applies-to Doc. No.");
                                    TempWHTEntry.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                    TempWHTEntry.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                    if WHTEntry."Document Type" = WHTEntry."Document Type"::"Credit Memo" then
                                        TempWHTEntry.SETFILTER(
                                          "Document Type",
                                          '%1|%2',
                                          TempWHTEntry."Document Type"::Refund,
                                          TempWHTEntry."Document Type"::Invoice);

                                    if WHTEntry."Document Type" = WHTEntry."Document Type"::Refund then
                                        TempWHTEntry.SETFILTER(
                                          "Document Type",
                                          '%1|%2',
                                          TempWHTEntry."Document Type"::"Credit Memo",
                                          TempWHTEntry."Document Type"::Payment);

                                    if TempWHTEntry.FINDFIRST() then begin
                                        if ABS(TempWHTEntry."Rem Realized Amount") >= ABS(WHTEntry.Amount) then begin
                                            if ((TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::Invoice) or
                                                (TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::Payment))
                                            then begin
                                                TempWHTEntry."Rem Realized Base" :=
                                                  TempWHTEntry."Rem Realized Base" + WHTEntry.Base;
                                                TempWHTEntry."Rem Realized Amount" :=
                                                  TempWHTEntry."Rem Realized Amount" + WHTEntry.Amount;
                                                WHTEntry."Rem Realized Base" := 0;
                                                WHTEntry."Rem Realized Amount" := 0;
                                            end else begin
                                                TempWHTEntry."Rem Realized Base" :=
                                                  TempWHTEntry."Rem Realized Base" - WHTEntry.Base;
                                                TempWHTEntry."Rem Realized Amount" :=
                                                  TempWHTEntry."Rem Realized Amount" - WHTEntry.Amount;
                                                WHTEntry.Amount := 0;
                                            end;

                                            if CurrencyCode = '' then begin
                                                TempWHTEntry."Rem Realized Base (LCY)" := TempWHTEntry."Rem Realized Base";
                                                TempWHTEntry."Rem Realized Amount (LCY)" := TempWHTEntry."Rem Realized Amount";
                                            end else begin
                                                TempWHTEntry."Rem Realized Amount (LCY)" :=
                                                  ROUND(
                                                    CurrExchRate.ExchangeAmtFCYToLCY(
                                                      DocDate, CurrencyCode, TempWHTEntry."Rem Realized Amount (LCY)", CurrFactor));
                                                TempWHTEntry."Rem Realized Base (LCY)" :=
                                                  ROUND(
                                                    CurrExchRate.ExchangeAmtFCYToLCY(
                                                      DocDate, CurrencyCode, TempWHTEntry."Rem Realized Base (LCY)", CurrFactor));
                                            end;
                                        end else begin
                                            if ((TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::Invoice) or
                                                (TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::Payment))
                                            then begin
                                                WHTEntry."Rem Realized Base" := WHTEntry."Rem Realized Base" + TempWHTEntry."Rem Realized Base";
                                                WHTEntry."Rem Realized Amount" := WHTEntry."Rem Realized Amount" + TempWHTEntry."Rem Realized Amount";
                                            end else begin
                                                WHTEntry.Base := WHTEntry.Base - TempWHTEntry."Rem Realized Base";
                                                WHTEntry.Amount := WHTEntry.Amount - TempWHTEntry."Rem Realized Amount";
                                                WHTEntry."Rem Realized Base" := WHTEntry."Rem Realized Base" - TempWHTEntry."Rem Realized Base";
                                                WHTEntry."Rem Realized Amount" := WHTEntry."Rem Realized Amount" - TempWHTEntry."Rem Realized Amount";
                                            end;
                                            TempWHTEntry."Rem Realized Base" := 0;
                                            TempWHTEntry."Rem Realized Amount" := 0;
                                            TempWHTEntry."Rem Realized Base (LCY)" := 0;
                                            TempWHTEntry."Rem Realized Amount (LCY)" := 0;
                                        end;

                                        if ((TempWHTEntry."Rem Realized Amount" = 0) and
                                            (TempWHTEntry."Rem Realized Base" = 0))
                                        then
                                            TempWHTEntry.Closed := true;
                                        TempWHTEntry.MODIFY();
                                    end;
                                end else begin
                                    if "Applies-toID" <> '' then begin
                                        if WHTEntry."Document Type" = WHTEntry."Document Type"::"Credit Memo" then begin
                                            CustLedgerEntry.RESET();
                                            CustLedgerEntry.SETRANGE("Applies-to ID", "Applies-toID");
                                            CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Refund);
                                            if CustLedgerEntry.findset() then begin
                                                TotalWHTBase := ABS(WHTEntry."Rem Realized Base");
                                                TotalWHT := ABS(WHTEntry."Rem Realized Amount");
                                                repeat
                                                    TempWHTEntry.RESET();
                                                    TempWHTEntry.SETRANGE(Settled, false);
                                                    TempWHTEntry.SETRANGE("Document No.", CustLedgerEntry."Document No.");
                                                    TempWHTEntry.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                                    TempWHTEntry.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                                    if TempWHTEntry.FINDFIRST() then begin
                                                        if TotalWHT > ABS(TempWHTEntry."Rem Realized Amount") then begin
                                                            WHTEntry.Base := WHTEntry.Base - TempWHTEntry."Rem Realized Base";
                                                            WHTEntry.Amount := WHTEntry.Amount - TempWHTEntry."Rem Realized Amount";
                                                            WHTEntry."Rem Realized Base" :=
                                                              WHTEntry."Rem Realized Base" - TempWHTEntry."Rem Realized Base";
                                                            WHTEntry."Rem Realized Amount" :=
                                                              WHTEntry."Rem Realized Amount" - TempWHTEntry."Rem Realized Amount";
                                                            TotalWHTBase := TotalWHTBase - ABS(TempWHTEntry."Rem Realized Base");
                                                            TotalWHT := TotalWHT - ABS(TempWHTEntry."Rem Realized Amount");
                                                            TempWHTEntry."Rem Realized Base" := 0;
                                                            TempWHTEntry."Rem Realized Amount" := 0;
                                                            TempWHTEntry."Rem Realized Base (LCY)" := 0;
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := 0;
                                                        end else begin
                                                            if (TotalWHT > 0) and (TotalWHT <= ABS(TempWHTEntry."Rem Realized Amount")) then begin
                                                                TempWHTEntry."Rem Realized Base" :=
                                                                  TempWHTEntry."Rem Realized Base" - TotalWHTBase;
                                                                TempWHTEntry."Rem Realized Amount" :=
                                                                  TempWHTEntry."Rem Realized Amount" - TotalWHT;
                                                                WHTEntry.Base := 0;
                                                                WHTEntry.Amount := 0;
                                                                WHTEntry."Rem Realized Amount" := 0;
                                                                WHTEntry."Rem Realized Base" := 0;
                                                                TotalWHTBase := 0;
                                                                TotalWHT := 0;
                                                            end;
                                                        end;

                                                        if CurrencyCode = '' then begin
                                                            TempWHTEntry."Rem Realized Base (LCY)" := TempWHTEntry."Rem Realized Base";
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := TempWHTEntry."Rem Realized Amount";
                                                        end else begin
                                                            TempWHTEntry."Rem Realized Amount (LCY)" :=
                                                              ROUND(
                                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                                  DocDate, CurrencyCode, TempWHTEntry."Rem Realized Amount (LCY)", CurrFactor));
                                                            TempWHTEntry."Rem Realized Base (LCY)" :=
                                                              ROUND(
                                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                                  DocDate, CurrencyCode, TempWHTEntry."Rem Realized Base (LCY)", CurrFactor));
                                                        end;
                                                        if ((TempWHTEntry."Rem Realized Amount" = 0) and
                                                            (TempWHTEntry."Rem Realized Base" = 0))
                                                        then
                                                            TempWHTEntry.Closed := true;
                                                        TempWHTEntry.MODIFY();
                                                    end;
                                                until CustLedgerEntry.NEXT() = 0;
                                                WHTEntry."Applies-to Entry No." := TempWHTEntry."Entry No.";
                                            end;

                                            CustLedgerEntry.RESET();
                                            CustLedgerEntry.SETRANGE("Applies-to ID", "Applies-toID");
                                            CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                                            if CustLedgerEntry.findset() then begin
                                                TotalWHTBase := ABS(WHTEntry."Rem Realized Base");
                                                TotalWHT := ABS(WHTEntry."Rem Realized Amount");
                                                repeat
                                                    TempWHTEntry.RESET();
                                                    TempWHTEntry.SETRANGE(Settled, false);
                                                    TempWHTEntry.SETRANGE("Document No.", CustLedgerEntry."Document No.");
                                                    TempWHTEntry.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                                    TempWHTEntry.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                                    if TempWHTEntry.FINDFIRST() then begin
                                                        if TotalWHT > ABS(TempWHTEntry."Rem Realized Amount") then begin
                                                            WHTEntry."Rem Realized Base" := WHTEntry."Rem Realized Base" + TempWHTEntry."Rem Realized Base";
                                                            WHTEntry."Rem Realized Amount" := WHTEntry."Rem Realized Amount" + TempWHTEntry."Rem Realized Amount";
                                                            TotalWHTBase := TotalWHTBase - ABS(TempWHTEntry."Rem Realized Base");
                                                            TotalWHT := TotalWHT - ABS(TempWHTEntry."Rem Realized Amount");
                                                            TempWHTEntry."Rem Realized Base" := 0;
                                                            TempWHTEntry."Rem Realized Amount" := 0;
                                                            TempWHTEntry."Rem Realized Base (LCY)" := 0;
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := 0;
                                                        end else begin
                                                            if (TotalWHT > 0) and (TotalWHT <= ABS(TempWHTEntry."Rem Realized Amount")) then begin
                                                                TempWHTEntry."Rem Realized Base" :=
                                                                  TempWHTEntry."Rem Realized Base" + TotalWHTBase;
                                                                TempWHTEntry."Rem Realized Amount" :=
                                                                  TempWHTEntry."Rem Realized Amount" + TotalWHT;
                                                                WHTEntry."Rem Realized Amount" := 0;
                                                                WHTEntry."Rem Realized Base" := 0;
                                                                TotalWHTBase := 0;
                                                                TotalWHT := 0;
                                                            end;
                                                        end;

                                                        if CurrencyCode = '' then begin
                                                            TempWHTEntry."Rem Realized Base (LCY)" := TempWHTEntry."Rem Realized Base";
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := TempWHTEntry."Rem Realized Amount";
                                                        end else begin
                                                            TempWHTEntry."Rem Realized Amount (LCY)" :=
                                                              ROUND(
                                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                                  DocDate, CurrencyCode, TempWHTEntry."Rem Realized Amount (LCY)", CurrFactor));
                                                            TempWHTEntry."Rem Realized Base (LCY)" :=
                                                              ROUND(
                                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                                  DocDate, CurrencyCode, TempWHTEntry."Rem Realized Base (LCY)", CurrFactor));
                                                        end;
                                                        if ((TempWHTEntry."Rem Realized Amount" = 0) and
                                                            (TempWHTEntry."Rem Realized Base" = 0))
                                                        then
                                                            TempWHTEntry.Closed := true;
                                                        TempWHTEntry.MODIFY();
                                                    end;
                                                until CustLedgerEntry.NEXT() = 0;
                                                WHTEntry."Applies-to Entry No." := TempWHTEntry."Entry No.";
                                            end;
                                        end;

                                        if WHTEntry."Document Type" = WHTEntry."Document Type"::Refund then begin
                                            CustLedgerEntry.RESET();
                                            CustLedgerEntry.SETRANGE("Applies-to ID", "Applies-toID");
                                            CustLedgerEntry.SETFILTER(
                                              "Document Type",
                                              '%1|%2',
                                              CustLedgerEntry."Document Type"::Payment,
                                              CustLedgerEntry."Document Type"::"Credit Memo");
                                            if CustLedgerEntry.findset() then begin
                                                TotalWHTBase := ABS(WHTEntry."Rem Realized Base");
                                                TotalWHT := ABS(WHTEntry."Rem Realized Amount");
                                                repeat
                                                    TempWHTEntry.RESET();
                                                    TempWHTEntry.SETRANGE(Settled, false);
                                                    TempWHTEntry.SETRANGE("Document No.", CustLedgerEntry."Document No.");
                                                    TempWHTEntry.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                                    TempWHTEntry.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                                    if TempWHTEntry.FINDFIRST() then begin
                                                        if TotalWHT > ABS(TempWHTEntry."Rem Realized Amount") then begin
                                                            if TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::"Credit Memo" then begin
                                                                WHTEntry.Base := WHTEntry.Base - ABS(TempWHTEntry."Rem Realized Base");
                                                                WHTEntry.Amount := WHTEntry.Amount - ABS(TempWHTEntry."Rem Realized Amount");
                                                            end;
                                                            WHTEntry."Rem Realized Base" := WHTEntry."Rem Realized Base" - ABS(TempWHTEntry."Rem Realized Base");
                                                            WHTEntry."Rem Realized Amount" :=
                                                              WHTEntry."Rem Realized Amount" - ABS(TempWHTEntry."Rem Realized Amount");
                                                            TotalWHTBase := TotalWHTBase - ABS(TempWHTEntry."Rem Realized Base");
                                                            TotalWHT := TotalWHT - ABS(TempWHTEntry."Rem Realized Amount");
                                                            TempWHTEntry."Rem Realized Base" := 0;
                                                            TempWHTEntry."Rem Realized Amount" := 0;
                                                            TempWHTEntry."Rem Realized Base (LCY)" := 0;
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := 0;
                                                        end else begin
                                                            if (TotalWHT > 0) and (TotalWHT <= ABS(TempWHTEntry."Rem Realized Amount")) then begin
                                                                if TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::Payment then begin
                                                                    TempWHTEntry."Rem Realized Base" :=
                                                                      TempWHTEntry."Rem Realized Base" + TotalWHTBase;
                                                                    TempWHTEntry."Rem Realized Amount" :=
                                                                      TempWHTEntry."Rem Realized Amount" + TotalWHT;
                                                                end else begin
                                                                    TempWHTEntry."Rem Realized Base" :=
                                                                      TempWHTEntry."Rem Realized Base" - TotalWHTBase;
                                                                    TempWHTEntry."Rem Realized Amount" :=
                                                                      TempWHTEntry."Rem Realized Amount" - TotalWHT;
                                                                    WHTEntry.Base := 0;
                                                                    WHTEntry.Amount := 0;
                                                                end;
                                                                WHTEntry."Rem Realized Amount" := 0;
                                                                WHTEntry."Rem Realized Base" := 0;
                                                                TotalWHTBase := 0;
                                                                TotalWHT := 0;
                                                            end;
                                                        end;

                                                        if CurrencyCode = '' then begin
                                                            TempWHTEntry."Rem Realized Base (LCY)" := TempWHTEntry."Rem Realized Base";
                                                            TempWHTEntry."Rem Realized Amount (LCY)" := TempWHTEntry."Rem Realized Amount";
                                                        end else begin
                                                            TempWHTEntry."Rem Realized Amount (LCY)" :=
                                                              ROUND(
                                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                                  DocDate, CurrencyCode, TempWHTEntry."Rem Realized Amount (LCY)", CurrFactor));
                                                            TempWHTEntry."Rem Realized Base (LCY)" :=
                                                              ROUND(
                                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                                  DocDate, CurrencyCode, TempWHTEntry."Rem Realized Base (LCY)", CurrFactor));
                                                        end;
                                                        if ((TempWHTEntry."Rem Realized Amount" = 0) and
                                                            (TempWHTEntry."Rem Realized Base" = 0))
                                                        then
                                                            TempWHTEntry.Closed := true;
                                                        TempWHTEntry.MODIFY();
                                                    end;
                                                until CustLedgerEntry.NEXT() = 0;
                                                WHTEntry."Applies-to Entry No." := TempWHTEntry."Entry No.";
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;

                    if WHTEntry.Amount = 0 then
                        if NextWHTEntryNo = 0 then
                            exit
                        else
                            exit(NextWHTEntryNo);

                    if ((WHTEntry."Rem Realized Amount" = 0) and
                        (WHTEntry."Rem Realized Base" = 0))
                    then
                        WHTEntry.Closed := true;
                end;

                if CurrencyCode = '' then begin
                    WHTEntry."Base (LCY)" := WHTEntry.Base;
                    WHTEntry."Amount (LCY)" := WHTEntry.Amount;
                    WHTEntry."Unrealized Amount (LCY)" := WHTEntry."Unrealized Amount";
                    WHTEntry."Unrealized Base (LCY)" := WHTEntry."Unrealized Base";
                    WHTEntry."Rem Realized Base (LCY)" := WHTEntry."Rem Realized Base";
                    WHTEntry."Rem Realized Amount (LCY)" := WHTEntry."Rem Realized Amount";
                    WHTEntry."Rem Unrealized Amount (LCY)" := WHTEntry."Remaining Unrealized Amount";
                    WHTEntry."Rem Unrealized Base (LCY)" := WHTEntry."Remaining Unrealized Base";
                end else begin
                    WHTEntry."Base (LCY)" :=
                      ROUND(CurrExchRate.ExchangeAmtFCYToLCY(DocDate, CurrencyCode, WHTEntry.Base, CurrFactor));
                    WHTEntry."Amount (LCY)" :=
                      ROUND(CurrExchRate.ExchangeAmtFCYToLCY(DocDate, CurrencyCode, WHTEntry.Amount, CurrFactor));
                    WHTEntry."Unrealized Base (LCY)" :=
                      ROUND(CurrExchRate.ExchangeAmtFCYToLCY(DocDate, CurrencyCode, WHTEntry."Unrealized Base", CurrFactor));
                    WHTEntry."Rem Realized Amount (LCY)" :=
                      ROUND(CurrExchRate.ExchangeAmtFCYToLCY(DocDate, CurrencyCode, WHTEntry."Rem Realized Amount", CurrFactor));
                    WHTEntry."Rem Realized Base (LCY)" :=
                      ROUND(CurrExchRate.ExchangeAmtFCYToLCY(DocDate, CurrencyCode, WHTEntry."Rem Realized Base", CurrFactor));
                    WHTEntry."Unrealized Amount (LCY)" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          DocDate, CurrencyCode, WHTEntry."Unrealized Amount", CurrFactor));
                    WHTEntry."Rem Unrealized Amount (LCY)" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          DocDate, CurrencyCode, WHTEntry."Remaining Unrealized Amount", CurrFactor));
                    WHTEntry."Rem Unrealized Base (LCY)" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          DocDate, CurrencyCode, WHTEntry."Remaining Unrealized Base", CurrFactor));
                end;

                if (WHTEntry."Applies-to Doc. No." <> '') and UnrealizedWHT then begin
                    TempWHTEntry.SETRANGE("Document Type", WHTEntry."Applies-to Doc. Type");
                    TempWHTEntry.SETRANGE("Document No.", WHTEntry."Applies-to Doc. No.");
                    TempWHTEntry.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                    TempWHTEntry.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                    if TempWHTEntry.FINDFIRST() then begin
                        TempWHTEntry."Rem Unrealized Amount (LCY)" :=
                          TempWHTEntry."Rem Unrealized Amount (LCY)" + WHTEntry."Unrealized Amount (LCY)";
                        TempWHTEntry."Rem Unrealized Base (LCY)" :=
                          TempWHTEntry."Rem Unrealized Base (LCY)" + WHTEntry."Unrealized Base (LCY)";
                        TempWHTEntry.MODIFY();
                        WHTEntry."Rem Unrealized Amount (LCY)" := 0;
                        WHTEntry."Rem Unrealized Base (LCY)" := 0;
                    end;
                end;

                if WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest then begin
                    if ABS(WHTEntry.Base) < WHTPostingSetup."WHT Minimum Invoice Amount" then
                        exit;
                end;
                //soicad>>
                if FullWHT then begin
                    WHTEntry.Amount := WHTEntry.Base;
                    WHTEntry."Amount (LCY)" := WHTEntry."Base (LCY)";
                    WHTEntry."Unrealized Amount" := WHTEntry."Unrealized Base";
                    WHTEntry."Unrealized Amount (LCY)" := WHTEntry."Unrealized Base (LCY)";
                    WHTEntry."Rem Realized Amount" := WHTEntry."Rem Realized Base";
                    WHTEntry."Rem Unrealized Amount (LCY)" := WHTEntry."Rem Unrealized Base (LCY)";
                    WHTEntry.Closed := true;
                    WHTEntry."Closed by Entry No." := WHTEntry."Entry No.";
                    WHTEntry.Settled := true;
                end;
                if (WHTEntry."Actual Vendor No." = '') and (WHTEntry."Transaction Type" = WHTEntry."Transaction Type"::Purchase) then
                    WHTEntry."Actual Vendor No." := WHTEntry."Bill-to/Pay-to No.";
                //soicad<<
                //HEI.06>>
                gWHTPostingSetup.RESET();
                if gWHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group") then
                    WHTEntry."WHT Bearer" := gWHTPostingSetup."WHT Bearer";
                //HEI.06<<
                WHTEntry.INSERT();
                NextWHTEntryNo := WHTEntry."Entry No." + 1;

                if TempWHTEntry.Prepayment then begin
                    WHTEntry3.RESET();
                    WHTEntry3.SETCURRENTKEY("Applies-to Entry No.");
                    WHTEntry3.SETRANGE("Applies-to Entry No.", TempWHTEntry."Entry No.");
                    WHTEntry3.CALCSUMS(Amount, "Amount (LCY)");
                    if (ABS(ABS(WHTEntry3.Amount) - ABS(TempWHTEntry."Unrealized Amount")) < 0.1) and
                       (ABS(ABS(WHTEntry3.Amount) - ABS(TempWHTEntry."Unrealized Amount")) > 0)
                    then begin
                        WHTEntry."WHT Difference" := TempWHTEntry."Unrealized Amount" - WHTEntry3.Amount;
                        WHTEntry.Amount := WHTEntry.Amount + WHTEntry."WHT Difference";
                        WHTEntry.MODIFY();
                    end;
                    if (ABS(ABS(WHTEntry3."Amount (LCY)") - ABS(TempWHTEntry."Unrealized Amount (LCY)")) < 0.1) and
                       (ABS(ABS(WHTEntry3."Amount (LCY)") - ABS(TempWHTEntry."Unrealized Amount (LCY)")) > 0)
                    then begin
                        WHTEntry."Amount (LCY)" := WHTEntry."Amount (LCY)" +
                          TempWHTEntry."Unrealized Amount (LCY)" - WHTEntry3."Amount (LCY)";
                        WHTEntry.MODIFY();
                    end;
                end;
            end;
        exit(NextWHTEntryNo);
    end;

    procedure WHTAmountJournal(var GenJnlLine1: Record "Gen. Journal Line"; Post: Boolean) WHTAmount: Decimal;
    var
        GenJnlLine: Record "Gen. Journal Line";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        VendLedgEntry: Record "Vendor Ledger Entry";
        VendLedgEntry1: Record "Vendor Ledger Entry";
        WHTEntry: Record "WHT Entry FND";
        WHTEntry3: Record "WHT Entry FND";
        WHTEntryTemp: Record "WHT Entry FND";
        AppldAmount: Decimal;
        ExpectedAmount: Decimal;
        GenJnlLineAmount: Decimal;
        PaymentAmount: Decimal;
        PaymentAmount1: Decimal;
        PaymentAmountLCY: Decimal;
        RemainingAmt: Decimal;
        TotalWHTAmount: Decimal;
        TotalWHTAmount2: Decimal;
        TotalWHTAmount3: Decimal;
        TotalWHTAmount4: Decimal;
        WHTAmount1: Decimal;
    begin
        GenJnlLine.COPY(GenJnlLine1);
        if (GenJnlLine."Document Type" <> GenJnlLine."Document Type"::Payment) and
           (GenJnlLine."Document Type" <> GenJnlLine."Document Type"::Refund)
        then
            exit;

        GLSetup.GET();
        if IsForeignVendor(GenJnlLine) then
            exit;

        TotalWHTAmount := 0;
        TotalWHTAmount2 := 0;
        TotalWHTAmount3 := 0;
        TotalWHTAmount4 := 0;
        RemainingAmt := 0;
        TotAmt := 0;
        TempVendLedgEntry.RESET();
        TempVendLedgEntry1.RESET();
        if GenJnlLine."Applies-to Doc. No." = '' then begin
            if GenJnlLine."Applies-to ID" <> '' then begin
                TempVendLedgEntry1.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                TempVendLedgEntry1.SETRANGE(Open, true);
                if GenJnlLine."Bill-to/Pay-to No." = '' then
                    TempVendLedgEntry1.SETRANGE("Buy-from Vendor No.", GenJnlLine."Account No.")
                else
                    TempVendLedgEntry1.SETRANGE("Buy-from Vendor No.", GenJnlLine."Bill-to/Pay-to No.");
            end else
                exit(TotalWHTAmount);

            if TempVendLedgEntry1.findset() then
                repeat
                    TempVendLedgEntry1.CALCFIELDS(
                      Amount, "Amount (LCY)",
                      "Remaining Amount", "Remaining Amt. (LCY)",
                      "Original Amount", "Original Amt. (LCY)");
                    RemainingAmt := RemainingAmt + TempVendLedgEntry1."Remaining Amount";

                    if TempVendLedgEntry1."Document Type" = TempVendLedgEntry1."Document Type"::"Credit Memo" then
                        RemainingAmt := RemainingAmt + TempVendLedgEntry1."Remaining Amount";
                until TempVendLedgEntry1.NEXT() = 0;

            TotAmt := ABS(GenJnlLine.Amount);

            if GenJnlLine."Applies-to ID" <> '' then begin
                TempVendLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                if GenJnlLine."Bill-to/Pay-to No." = '' then
                    TempVendLedgEntry.SETRANGE("Buy-from Vendor No.", GenJnlLine."Account No.")
                else
                    TempVendLedgEntry.SETRANGE("Buy-from Vendor No.", GenJnlLine."Bill-to/Pay-to No.");
            end else
                TempVendLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Document No.");

            TempVendLedgEntry.SETRANGE(Open, true);
            TempVendLedgEntry.SETRANGE("Document Type", TempVendLedgEntry."Document Type"::"Credit Memo");
            if TempVendLedgEntry.findset() then
                repeat
                    TempVendLedgEntry.CALCFIELDS(
                      Amount, "Amount (LCY)",
                      "Remaining Amount",
                      "Remaining Amt. (LCY)",
                      "Original Amount",
                      "Original Amt. (LCY)");

                    if CheckPmtDisc(
                         GenJnlLine."Posting Date",
                         TempVendLedgEntry."Pmt. Discount Date",
                         ABS(TempVendLedgEntry."Amount to Apply"),
                         ABS(TempVendLedgEntry."Remaining Amount"),
                         ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"),
                         ABS(TotAmt))
                    then
                        TotAmt := TotAmt + ABS(TempVendLedgEntry."Original Pmt. Disc. Possible");

                    if (ABS(RemainingAmt) < ABS(TotAmt)) or
                       (ABS(TempVendLedgEntry."Remaining Amount") < ABS(TotAmt))
                    then begin
                        GenJnlLine.VALIDATE(Amount, -ABS(TempVendLedgEntry."Remaining Amount"));
                        RemainingAmt := RemainingAmt - TempVendLedgEntry."Remaining Amount";
                    end else begin
                        GenJnlLine.VALIDATE(Amount, -TotAmt);
                        ExitLoop := true;
                    end;

                    if TempVendLedgEntry."Document Type" = TempVendLedgEntry."Document Type"::Invoice then
                        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice
                    else begin
                        if TempVendLedgEntry."Document Type" = TempVendLedgEntry."Document Type"::"Credit Memo" then
                            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::"Credit Memo";
                        RemainingAmt := RemainingAmt - TempVendLedgEntry."Remaining Amount";
                        TotAmt := TotAmt + ABS(TempVendLedgEntry."Remaining Amount");
                        ExitLoop := false;
                    end;

                    GenJnlLine."Applies-to Doc. No." := TempVendLedgEntry."Document No.";
                    PaymentAmount := GenJnlLine.Amount;
                    PaymentAmount1 := GenJnlLine.Amount;
                    PaymentAmountLCY := GenJnlLine."Amount (LCY)";
                    FilterWHTEntry(WHTEntry, GenJnlLine);

                    if WHTEntry.findset() then
                        repeat
                            PurchCrMemoHeader.RESET();
                            PurchCrMemoHeader.SETRANGE("Applies-to Doc. Type", PurchCrMemoHeader."Applies-to Doc. Type"::Invoice);
                            PurchCrMemoHeader.SETRANGE("Applies-to Doc. No.", GenJnlLine."Applies-to Doc. No.");
                            if PurchCrMemoHeader.FINDFIRST() then begin
                                TempRemAmt := 0;
                                VendLedgEntry1.SETRANGE("Document Type", VendLedgEntry1."Document Type"::"Credit Memo");
                                VendLedgEntry1.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                                if VendLedgEntry1.FINDFIRST() then
                                    VendLedgEntry1.CALCFIELDS(Amount, "Remaining Amount");
                                WHTEntryTemp.RESET();
                                WHTEntryTemp.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");
                                WHTEntryTemp.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
                                WHTEntryTemp.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                                WHTEntryTemp.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                WHTEntryTemp.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                if WHTEntryTemp.FINDFIRST() then begin
                                    TempRemBase := WHTEntryTemp."Unrealized Amount";
                                    TempRemAmt := WHTEntryTemp."Unrealized Base";
                                end;
                            end;

                            VendLedgEntry.RESET();
                            VendLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                            if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::Invoice then
                                VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::Invoice)
                            else
                                if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::"Credit Memo" then
                                    VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::"Credit Memo");

                            if VendLedgEntry.FINDFIRST() then
                                VendLedgEntry.CALCFIELDS(Amount, "Remaining Amount");

                            ExpectedAmount := -(VendLedgEntry.Amount + VendLedgEntry1.Amount);
                            if (GenJnlLine."Posting Date" <= VendLedgEntry."Pmt. Discount Date") and
                               (ABS(PaymentAmount1) >=
                                (ABS(VendLedgEntry."Remaining Amount" +
                                   VendLedgEntry1."Remaining Amount") -
                                 ABS(VendLedgEntry."Original Pmt. Disc. Possible")))
                            then
                                AppldAmount :=
                                  ROUND(
                                    ((PaymentAmount1 * (WHTEntry."Unrealized Base" + TempRemAmt)) /
                                     ExpectedAmount))
                            else
                                AppldAmount :=
                                  ROUND(
                                    (PaymentAmount1 * (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount);

                            if GenJnlLine."Currency Code" <> '' then begin
                                CurrFactor :=
                                  CurrExchRate.ExchangeRate(
                                    GenJnlLine."Document Date",
                                    GenJnlLine."Currency Code");

                                WHTAmount1 := ROUND(AppldAmount * WHTEntry."WHT %" / 100);
                                WHTEntry3.RESET();
                                WHTEntry3.SETCURRENTKEY("Applies-to Entry No.");
                                WHTEntry3.SETRANGE("Applies-to Entry No.", WHTEntry."Entry No.");
                                WHTEntry3.CALCSUMS(Amount);
                                if (ABS(ABS(WHTEntry3.Amount) + ABS(WHTAmount1) - ABS(WHTEntry."Unrealized Amount")) < 0.1) and
                                   (ABS(ABS(WHTEntry3.Amount) + ABS(WHTAmount1) - ABS(WHTEntry."Unrealized Amount")) > 0)
                                then
                                    WHTAmount1 := WHTAmount1 + (WHTEntry."Unrealized Amount" - (WHTEntry3.Amount + WHTAmount1));

                                TotalWHTAmount4 :=
                                    CurrExchRate.ExchangeAmtFCYToLCY(
                                      GenJnlLine."Document Date",
                                      GenJnlLine."Currency Code",
                                      // ROUND(AppldAmount * WHTEntry."WHT %" / 100),
                                      WHTAmount1,
                                      CurrFactor);

                                TotalWHTAmount4 :=
                                  CurrExchRate.ExchangeAmtLCYToFCY(
                                    GenJnlLine."Document Date",
                                    GenJnlLine."Currency Code",
                                    TotalWHTAmount4,
                                    CurrFactor);
                                TotalWHTAmount := (TotalWHTAmount + TotalWHTAmount4);
                            end else begin
                                // TotalWHTAmount := ROUND(TotalWHTAmount + AppldAmount * WHTEntry."WHT %" / 100);
                                WHTAmount1 := ROUND(AppldAmount * WHTEntry."WHT %" / 100);
                                WHTEntry3.RESET();
                                WHTEntry3.SETCURRENTKEY("Applies-to Entry No.");
                                WHTEntry3.SETRANGE("Applies-to Entry No.", WHTEntry."Entry No.");
                                WHTEntry3.CALCSUMS(Amount);
                                if (ABS(ABS(WHTEntry3.Amount) + ABS(WHTAmount1) - ABS(WHTEntry."Unrealized Amount")) < 0.1) and
                                   (ABS(ABS(WHTEntry3.Amount) + ABS(WHTAmount1) - ABS(WHTEntry."Unrealized Amount")) > 0)
                                then
                                    WHTAmount1 := WHTAmount1 + (WHTEntry."Unrealized Amount" - (WHTEntry3.Amount + WHTAmount1));

                                TotalWHTAmount := ROUND(TotalWHTAmount + WHTAmount1);
                            end;
                            TotalWHTAmount2 := TotalWHTAmount;
                        until WHTEntry.NEXT() = 0;

                until TempVendLedgEntry.NEXT() = 0;
            ExitLoop := false;
            TempVendLedgEntry.RESET();
            if GenJnlLine."Applies-to ID" <> '' then begin
                TempVendLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                if GenJnlLine."Bill-to/Pay-to No." = '' then
                    TempVendLedgEntry.SETRANGE("Buy-from Vendor No.", GenJnlLine."Account No.")
                else
                    TempVendLedgEntry.SETRANGE("Buy-from Vendor No.", GenJnlLine."Bill-to/Pay-to No.");
            end else
                TempVendLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Document No.");

            TempVendLedgEntry.SETRANGE(Open, true);
            TempVendLedgEntry.SETFILTER("Document Type", '<>%1', TempVendLedgEntry."Document Type"::"Credit Memo");
            if TempVendLedgEntry.findset() then begin
                repeat
                    TempVendLedgEntry.CALCFIELDS(
                      Amount,
                      "Amount (LCY)",
                      "Remaining Amount",
                      "Remaining Amt. (LCY)",
                      "Original Amount",
                      "Original Amt. (LCY)");

                    if CheckPmtDisc(
                         GenJnlLine."Posting Date",
                         TempVendLedgEntry."Pmt. Discount Date",
                         ABS(TempVendLedgEntry."Amount to Apply"),
                         ABS(TempVendLedgEntry."Remaining Amount"),
                         ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"),
                         ABS(TotAmt))
                    then
                        TotAmt := TotAmt + ABS(TempVendLedgEntry."Original Pmt. Disc. Possible");

                    UpdateAmounts(TempVendLedgEntry, GenJnlLine, RemainingAmt, TotAmt, GenJnlLineAmount, ExitLoop);

                    if TempVendLedgEntry."Document Type" = TempVendLedgEntry."Document Type"::Invoice then
                        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice
                    else begin
                        if TempVendLedgEntry."Document Type" = TempVendLedgEntry."Document Type"::"Credit Memo" then
                            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::"Credit Memo";
                        RemainingAmt := RemainingAmt + TempVendLedgEntry."Remaining Amount";
                        TotAmt := TotAmt + TempVendLedgEntry."Remaining Amount";
                        ExitLoop := false;
                    end;

                    GenJnlLine."Applies-to Doc. No." := TempVendLedgEntry."Document No.";
                    PaymentAmount := GenJnlLine.Amount;
                    PaymentAmount1 := GenJnlLine.Amount;
                    PaymentAmountLCY := GenJnlLine."Amount (LCY)";
                    FilterWHTEntry(WHTEntry, GenJnlLine);
                    if WHTEntry.findset() then
                        repeat
                            PurchCrMemoHeader.SETRANGE("Applies-to Doc. Type", PurchCrMemoHeader."Applies-to Doc. Type"::Invoice);
                            PurchCrMemoHeader.SETRANGE("Applies-to Doc. No.", GenJnlLine."Applies-to Doc. No.");
                            if PurchCrMemoHeader.FINDFIRST() then begin
                                TempRemAmt := 0;
                                VendLedgEntry1.SETRANGE("Document Type", VendLedgEntry1."Document Type"::"Credit Memo");
                                VendLedgEntry1.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                                if VendLedgEntry1.FINDFIRST() then
                                    VendLedgEntry1.CALCFIELDS(Amount, "Remaining Amount");
                                WHTEntryTemp.RESET();
                                WHTEntryTemp.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");
                                WHTEntryTemp.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
                                WHTEntryTemp.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                                WHTEntryTemp.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                WHTEntryTemp.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                if WHTEntryTemp.FINDFIRST() then begin
                                    TempRemBase := WHTEntryTemp."Unrealized Amount";
                                    TempRemAmt := WHTEntryTemp."Unrealized Base";
                                end;
                            end;

                            VendLedgEntry.RESET();
                            VendLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                            if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::Invoice then
                                VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::Invoice)
                            else
                                if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::"Credit Memo" then
                                    VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::"Credit Memo");
                            if VendLedgEntry.FINDFIRST() then
                                VendLedgEntry.CALCFIELDS(Amount, "Remaining Amount");
                            ExpectedAmount := -(VendLedgEntry.Amount + VendLedgEntry1.Amount);
                            if (GenJnlLine."Posting Date" <= VendLedgEntry."Pmt. Discount Date") and
                               (ABS(PaymentAmount1) >=
                                (ABS(VendLedgEntry."Remaining Amount" + VendLedgEntry1."Remaining Amount") -
                                 ABS(VendLedgEntry."Original Pmt. Disc. Possible")))
                            then
                                AppldAmount :=
                                  ROUND(
                                    (PaymentAmount1 *
                                     (WHTEntry."Unrealized Base" + TempRemAmt)) /
                                    ExpectedAmount)
                            else
                                AppldAmount :=
                                  ROUND(
                                    (PaymentAmount1 *
                                     (WHTEntry."Unrealized Base" + TempRemAmt)) /
                                    ExpectedAmount);

                            if GenJnlLine."Currency Code" <> '' then begin
                                CurrFactor :=
                                  CurrExchRate.ExchangeRate(
                                    GenJnlLine."Document Date",
                                    GenJnlLine."Currency Code");
                                WHTAmount1 := ROUND(AppldAmount * WHTEntry."WHT %" / 100);

                                TotalWHTAmount4 :=
                                    CurrExchRate.ExchangeAmtFCYToLCY(
                                      GenJnlLine."Document Date",
                                      GenJnlLine."Currency Code",
                                      WHTAmount1,
                                       CurrFactor);
                                TotalWHTAmount4 :=
                                  CurrExchRate.ExchangeAmtLCYToFCY(
                                    GenJnlLine."Document Date",
                                    GenJnlLine."Currency Code",
                                    TotalWHTAmount4,
                                    CurrFactor);
                                TotalWHTAmount := (TotalWHTAmount + TotalWHTAmount4);
                            end else begin
                                //HEI.05>>comb
                                TempVendLedgEntry."Amount to Apply" := -AppldAmount;
                                //HEI.05<<

                                WHTAmount1 := CalcAppliedWHTAmount(TempVendLedgEntry, GenJnlLine, WHTEntry."WHT %", ExitLoop);
                                TotalWHTAmount := ROUND(TotalWHTAmount + WHTAmount1);
                            end;
                            TotalWHTAmount2 := TotalWHTAmount;
                        until WHTEntry.NEXT() = 0;

                    if ExitLoop then
                        exit(TotalWHTAmount2);
                until TempVendLedgEntry.NEXT() = 0;

                if GenJnlLine."Currency Code" <> '' then begin
                    CurrFactor :=
                      CurrExchRate.ExchangeRate(
                        GenJnlLine."Document Date",
                        GenJnlLine."Currency Code");

                    TotalWHTAmount3 :=
                      ROUND(
                        TotalWHTAmount3 +
                        ROUND(
                          CurrExchRate.ExchangeAmtFCYToLCY(
                            GenJnlLine."Document Date",
                            GenJnlLine."Currency Code",
                            TotalWHTAmount2, CurrFactor)));
                end;
            end;
            exit(TotalWHTAmount2);
        end;
        TotAmt := ABS(GenJnlLine.Amount);
        TempVendLedgEntry.RESET();
        TempVendLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
        TempVendLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
        if TempVendLedgEntry.FINDFIRST() then begin
            if TempVendLedgEntry."Document Type" = TempVendLedgEntry."Document Type"::Invoice then begin
                TempVendLedgEntry.CALCFIELDS(
                  Amount,
                  "Amount (LCY)",
                  "Remaining Amount",
                  "Remaining Amt. (LCY)",
                  "Original Amount",
                  "Original Amt. (LCY)");

                if TempVendLedgEntry."Amount to Apply" = 0 then
                    TempVendLedgEntry."Amount to Apply" := -ABSMin(TempVendLedgEntry."Remaining Amount", GenJnlLine.Amount);

                if CheckPmtDisc(
                     GenJnlLine."Posting Date",
                     TempVendLedgEntry."Pmt. Discount Date",
                     ABS(TempVendLedgEntry."Amount to Apply"),
                     ABS(TempVendLedgEntry."Remaining Amount"),
                     ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"),
                     ABS(TotAmt))
                then
                    TotAmt := TotAmt + ABS(TempVendLedgEntry."Original Pmt. Disc. Possible");

                if ABS(TempVendLedgEntry."Remaining Amount") < ABS(TotAmt) then
                    GenJnlLine.VALIDATE(Amount, ABS(TempVendLedgEntry."Remaining Amount"))
                else
                    GenJnlLine.VALIDATE(Amount, TotAmt);
            end else
                if TempVendLedgEntry."Document Type" = TempVendLedgEntry."Document Type"::"Credit Memo" then begin
                    TempVendLedgEntry.CALCFIELDS(
                      Amount,
                      "Amount (LCY)",
                      "Remaining Amount",
                      "Remaining Amt. (LCY)",
                      "Original Amount",
                      "Original Amt. (LCY)");

                    if TempVendLedgEntry."Amount to Apply" = 0 then
                        TempVendLedgEntry."Amount to Apply" := ABSMin(TempVendLedgEntry."Remaining Amount", GenJnlLine.Amount);

                    if CheckPmtDisc(
                         GenJnlLine."Posting Date",
                         TempVendLedgEntry."Pmt. Discount Date",
                         ABS(TempVendLedgEntry."Amount to Apply"),
                         ABS(TempVendLedgEntry."Remaining Amount"),
                         ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"),
                         ABS(TotAmt))
                    then
                        TotAmt := TotAmt + ABS(TempVendLedgEntry."Original Pmt. Disc. Possible");

                    if ABS(TempVendLedgEntry."Remaining Amount") < ABS(TotAmt) then
                        GenJnlLine.VALIDATE(Amount, -ABS(TempVendLedgEntry."Remaining Amount"))
                    else
                        GenJnlLine.VALIDATE(Amount, -TotAmt);
                end;
        end;
        TotalWHTAmount := 0;
        PaymentAmount := GenJnlLine.Amount;
        PaymentAmount1 := GenJnlLine.Amount;
        PaymentAmountLCY := GenJnlLine."Amount (LCY)";
        FilterWHTEntry(WHTEntry, GenJnlLine);
        if WHTEntry.findset() then begin
            repeat
                PurchCrMemoHeader.SETRANGE(
                  "Applies-to Doc. Type",
                  PurchCrMemoHeader."Applies-to Doc. Type"::Invoice);
                PurchCrMemoHeader.SETRANGE("Applies-to Doc. No.", GenJnlLine."Applies-to Doc. No.");
                if PurchCrMemoHeader.FINDFIRST() then begin
                    TempRemAmt := 0;
                    VendLedgEntry1.SETRANGE("Document Type", VendLedgEntry1."Document Type"::"Credit Memo");
                    VendLedgEntry1.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                    if VendLedgEntry1.FINDFIRST() then
                        VendLedgEntry1.CALCFIELDS(Amount, "Remaining Amount", "Remaining Amt. (LCY)");
                    WHTEntryTemp.RESET();
                    WHTEntryTemp.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");
                    WHTEntryTemp.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
                    WHTEntryTemp.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                    WHTEntryTemp.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                    WHTEntryTemp.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                    if WHTEntryTemp.FINDFIRST() then
                        TempRemAmt := WHTEntryTemp."Unrealized Base";
                end;

                VendLedgEntry.RESET();
                VendLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                VendLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                if VendLedgEntry.FINDFIRST() then
                    VendLedgEntry.CALCFIELDS(Amount, "Remaining Amount", "Remaining Amt. (LCY)");
                ExpectedAmount := -(VendLedgEntry.Amount + VendLedgEntry1.Amount);
                AppldAmount :=
                  ROUND(
                    (PaymentAmount1 * (WHTEntry."Unrealized Base" + TempRemAmt)) /
                    ExpectedAmount);

                if GenJnlLine."Currency Code" <> '' then begin
                    CurrFactor :=
                      CurrExchRate.ExchangeRate(
                        GenJnlLine."Document Date",
                        GenJnlLine."Currency Code");

                    WHTAmount1 := ROUND(AppldAmount * WHTEntry."WHT %" / 100);
                    WHTEntry3.RESET();
                    WHTEntry3.SETCURRENTKEY("Applies-to Entry No.");
                    WHTEntry3.SETRANGE("Applies-to Entry No.", WHTEntry."Entry No.");
                    WHTEntry3.CALCSUMS(Amount);
                    if (ABS(ABS(WHTEntry3.Amount) + ABS(WHTAmount1) - ABS(WHTEntry."Unrealized Amount")) < 0.1) and
                       (ABS(ABS(WHTEntry3.Amount) + ABS(WHTAmount1) - ABS(WHTEntry."Unrealized Amount")) > 0)
                    then
                        WHTAmount1 := WHTAmount1 + (WHTEntry."Unrealized Amount" - (WHTEntry3.Amount + WHTAmount1));


                    TotalWHTAmount4 :=
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          GenJnlLine."Document Date",
                          GenJnlLine."Currency Code",
                          WHTAmount1,
                          CurrFactor);

                    TotalWHTAmount4 :=
                      CurrExchRate.ExchangeAmtLCYToFCY(
                        GenJnlLine."Document Date",
                        GenJnlLine."Currency Code",
                        TotalWHTAmount4,
                        CurrFactor);
                    TotalWHTAmount := (TotalWHTAmount + TotalWHTAmount4);
                end else begin
                    WHTAmount1 := ROUND(AppldAmount * WHTEntry."WHT %" / 100);
                    WHTEntry3.RESET();
                    WHTEntry3.SETCURRENTKEY("Applies-to Entry No.");
                    WHTEntry3.SETRANGE("Applies-to Entry No.", WHTEntry."Entry No.");
                    WHTEntry3.CALCSUMS(Amount);
                    TotalWHTAmount := ROUND(TotalWHTAmount + WHTAmount1, GLSetup."Inv. Rounding Precision (LCY)", '=');
                end;
            until WHTEntry.NEXT() = 0;
            exit(TotalWHTAmount);
        end;
    end;

    procedure ApplyCustCalcWHT(var GenJnlLine: Record "Gen. Journal Line") WHTAmt: Decimal;
    var
        RemainingAmt: Decimal;
        Currency: Option Vendor,Customer;
    begin
        AppliedAmount := ABS(GenJnlLine."Amount (LCY)");
        TotAmt := ABS(GenJnlLine.Amount);
        TempCustLedgEntry1.RESET();
        SetCustAppliesToFilter(TempCustLedgEntry1, GenJnlLine);
        if TempCustLedgEntry1.findset() then
            repeat
                TempCustLedgEntry1.CALCFIELDS(
                  Amount,
                  "Amount (LCY)",
                  "Remaining Amount",
                  "Remaining Amt. (LCY)",
                  "Original Amount",
                  "Original Amt. (LCY)");

                RemainingAmt := RemainingAmt + TempCustLedgEntry1."Remaining Amount";

                if TempCustLedgEntry1."Document Type" =
                   TempCustLedgEntry1."Document Type"::"Credit Memo"
                then
                    RemainingAmt := RemainingAmt + TempCustLedgEntry1."Remaining Amount";
            until TempCustLedgEntry1.NEXT() = 0;

        TempCustLedgEntry.RESET();
        SetCustAppliesToFilter(TempCustLedgEntry, GenJnlLine);
        TempCustLedgEntry.SETRANGE("Document Type", TempCustLedgEntry."Document Type"::"Credit Memo");
        if TempCustLedgEntry.findset() then
            repeat
                TempCustLedgEntry.CALCFIELDS(
                  Amount,
                  "Amount (LCY)",
                  "Remaining Amount",
                  "Remaining Amt. (LCY)",
                  "Original Amount", "Original Amt. (LCY)");

                if TempCustLedgEntry."Amount to Apply" = 0 then
                    TempCustLedgEntry."Amount to Apply" := -ABSMin(TempCustLedgEntry."Remaining Amount", GenJnlLine.Amount);

                if CheckPmtDisc(
                     GenJnlLine."Posting Date",
                     TempCustLedgEntry."Pmt. Discount Date",
                     ABS(TempCustLedgEntry."Amount to Apply"),
                     ABS(TempCustLedgEntry."Remaining Amount"),
                     ABS(TempCustLedgEntry."Original Pmt. Disc. Possible"),
                     ABS(TotAmt))
                then
                    TotAmt := TotAmt + ABS(TempCustLedgEntry."Original Pmt. Disc. Possible");

                if (ABS(RemainingAmt) <= ABS(TotAmt)) or
                   (ABS(TempCustLedgEntry."Remaining Amount") < ABS(TotAmt))
                then begin
                    if CheckPmtDisc(
                         GenJnlLine."Posting Date",
                         TempCustLedgEntry."Pmt. Discount Date",
                         ABS(TempCustLedgEntry."Amount to Apply"),
                         ABS(TempCustLedgEntry."Remaining Amount"),
                         ABS(TempCustLedgEntry."Original Pmt. Disc. Possible"),
                         ABS(TotAmt))
                    then begin
                        GenJnlLine.VALIDATE(
                          Amount,
                          ABS(TempCustLedgEntry."Remaining Amount" -
                            TempCustLedgEntry."Original Pmt. Disc. Possible"));
                        if TempCustLedgEntry."Document Type" <>
                           TempCustLedgEntry."Document Type"::"Credit Memo"
                        then
                            TotAmt := -(TotAmt - TempCustLedgEntry."Remaining Amount");

                        RemainingAmt :=
                          RemainingAmt - TempCustLedgEntry."Remaining Amount" +
                          TempCustLedgEntry."Original Pmt. Disc. Possible";
                    end else begin
                        GenJnlLine.VALIDATE(Amount, ABS(TempCustLedgEntry."Remaining Amount"));
                        if TempCustLedgEntry."Document Type" <>
                           TempCustLedgEntry."Document Type"::"Credit Memo"
                        then
                            TotAmt := -(TotAmt - TempCustLedgEntry."Remaining Amount");
                        RemainingAmt := RemainingAmt - TempCustLedgEntry."Remaining Amount";
                    end;
                end else begin
                    if CheckPmtDisc(
                         GenJnlLine."Posting Date",
                         TempCustLedgEntry."Pmt. Discount Date",
                         ABS(TempCustLedgEntry."Amount to Apply"),
                         ABS(TempCustLedgEntry."Remaining Amount"),
                         ABS(TempCustLedgEntry."Original Pmt. Disc. Possible"),
                         ABS(TotAmt))
                    then
                        GenJnlLine.VALIDATE(
                          Amount, TotAmt - ABS(TempCustLedgEntry."Original Pmt. Disc. Possible"))
                    else
                        GenJnlLine.VALIDATE(Amount, ABS(TotAmt));
                    ExitLoop := true;
                end;

                if TempCustLedgEntry."Document Type" = TempCustLedgEntry."Document Type"::Invoice then
                    GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice
                else
                    if TempCustLedgEntry."Document Type" = TempCustLedgEntry."Document Type"::"Credit Memo" then begin
                        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::"Credit Memo";
                        RemainingAmt := RemainingAmt - TempCustLedgEntry."Remaining Amount";
                        TotAmt := TotAmt - TempCustLedgEntry."Remaining Amount";
                        ExitLoop := false;
                    end;

                GenJnlLine."Applies-to Doc. No." := TempCustLedgEntry."Document No.";
                WHTAmt += CalcWHT(GenJnlLine, Currency::Customer);
            until (TempCustLedgEntry.NEXT() = 0) or ExitLoop;

        ExitLoop := false;
        TempCustLedgEntry.RESET();
        SetCustAppliesToFilter(TempCustLedgEntry, GenJnlLine);
        TempCustLedgEntry.SETFILTER("Document Type", '<>%1', TempCustLedgEntry."Document Type"::"Credit Memo");
        if TempCustLedgEntry.findset() then
            repeat
                TempCustLedgEntry.CALCFIELDS(
                  Amount,
                  "Amount (LCY)",
                  "Remaining Amount",
                  "Remaining Amt. (LCY)",
                  "Original Amount",
                  "Original Amt. (LCY)");

                if TempCustLedgEntry."Amount to Apply" = 0 then
                    TempCustLedgEntry."Amount to Apply" := ABSMin(TempCustLedgEntry."Remaining Amount", GenJnlLine.Amount);

                if CheckPmtDisc(
                     GenJnlLine."Posting Date",
                     TempCustLedgEntry."Pmt. Discount Date",
                     ABS(TempCustLedgEntry."Amount to Apply"),
                     ABS(TempCustLedgEntry."Remaining Amount"),
                     ABS(TempCustLedgEntry."Original Pmt. Disc. Possible"),
                     ABS(TotAmt))
                then
                    TotAmt := TotAmt + ABS(TempCustLedgEntry."Original Pmt. Disc. Possible");

                if (ABS(RemainingAmt) <= ABS(TotAmt)) or
                   (ABS(TempCustLedgEntry."Remaining Amount") < ABS(TotAmt))
                then begin
                    if CheckPmtDisc(
                         GenJnlLine."Posting Date",
                         TempCustLedgEntry."Pmt. Discount Date",
                         ABS(TempCustLedgEntry."Amount to Apply"),
                         ABS(TempCustLedgEntry."Remaining Amount"),
                         ABS(TempCustLedgEntry."Original Pmt. Disc. Possible"),
                         ABS(TotAmt))
                    then begin
                        RemainingAmt :=
                          RemainingAmt - TempCustLedgEntry."Remaining Amount" +
                          TempCustLedgEntry."Original Pmt. Disc. Possible";

                        GenJnlLine.VALIDATE(
                          Amount,
                          -ABS(TempCustLedgEntry."Remaining Amount" -
                            TempCustLedgEntry."Original Pmt. Disc. Possible"));

                        if TempCustLedgEntry."Document Type" <>
                           TempCustLedgEntry."Document Type"::"Credit Memo"
                        then
                            TotAmt := (TotAmt - TempCustLedgEntry."Remaining Amount");
                    end else begin
                        RemainingAmt := RemainingAmt - TempCustLedgEntry."Remaining Amount";
                        GenJnlLine.VALIDATE(Amount, -ABS(TempCustLedgEntry."Remaining Amount"));
                        if TempCustLedgEntry."Document Type" <> TempCustLedgEntry."Document Type"::"Credit Memo" then
                            TotAmt := (TotAmt - TempCustLedgEntry."Remaining Amount");
                    end;
                end else begin
                    if CheckPmtDisc(
                         GenJnlLine."Posting Date",
                         TempCustLedgEntry."Pmt. Discount Date",
                         ABS(TempCustLedgEntry."Amount to Apply"),
                         ABS(TempCustLedgEntry."Remaining Amount"),
                         ABS(TempCustLedgEntry."Original Pmt. Disc. Possible"),
                         ABS(TotAmt))
                    then
                        GenJnlLine.VALIDATE(
                          Amount, -(TotAmt - ABS(TempCustLedgEntry."Original Pmt. Disc. Possible")))
                    else
                        GenJnlLine.VALIDATE(Amount, -ABS(TotAmt));
                    ExitLoop := true;
                end;

                if TempCustLedgEntry."Document Type" = TempCustLedgEntry."Document Type"::Invoice then
                    GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice
                else
                    if TempCustLedgEntry."Document Type" = TempCustLedgEntry."Document Type"::"Credit Memo" then begin
                        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::"Credit Memo";
                        RemainingAmt := RemainingAmt - TempCustLedgEntry."Remaining Amount";
                        TotAmt := TotAmt - TempCustLedgEntry."Remaining Amount";
                        ExitLoop := false;
                    end;
                GenJnlLine."Applies-to Doc. No." := TempCustLedgEntry."Document No.";
                WHTAmt += CalcWHT(GenJnlLine, Currency::Customer);
            until (TempCustLedgEntry.NEXT() = 0) or ExitLoop;
        exit(WHTAmt);
    end;

    procedure CalcWHT(var GenJnlLine: Record "Gen. Journal Line"; Source: Option Vendor,Customer) PaymentNo: Decimal;
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntry1: Record "Cust. Ledger Entry";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        VendLedgEntry: Record "Vendor Ledger Entry";
        VendLedgEntry1: Record "Vendor Ledger Entry";
        WHTEntry: Record "WHT Entry FND";
        WHTEntry3: Record "WHT Entry FND";
        WHTEntryTemp: Record "WHT Entry FND";
        AppldAmount: Decimal;
        ExpectedAmount: Decimal;
        PaymentAmount: Decimal;
        PaymentAmount1: Decimal;
        PaymentAmountLCY: Decimal;
        WHTAmount1: Decimal;
        WHTTotAmt: Decimal;
    begin
        PaymentAmount := GenJnlLine.Amount;
        PaymentAmount1 := GenJnlLine.Amount;
        PaymentAmountLCY := GenJnlLine."Amount (LCY)";
        WHTEntry.RESET();
        WHTEntry.SETCURRENTKEY("Transaction Type", "Document No.", "Document Type", "Bill-to/Pay-to No.");
        if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::Invoice then
            WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::Invoice);

        if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::"Credit Memo" then
            WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");

        case Source of
            Source::Vendor:
                WHTEntry.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
            Source::Customer:
                WHTEntry.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Sale);
        end;

        WHTEntry.SETRANGE(Closed, false);
        if GenJnlLine."Applies-to Doc. No." <> '' then begin
            WHTEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
            WHTEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
        end else
            WHTEntry.SETRANGE("Bill-to/Pay-to No.", GenJnlLine."Account No.");
        if WHTEntry.findset() then begin
            repeat
                case Source of
                    Source::Vendor:
                        begin
                            if GenJnlLine."Applies-to Doc. No." = '' then
                                exit;
                            PurchCrMemoHeader.SETRANGE("Applies-to Doc. No.", GenJnlLine."Applies-to Doc. No.");
                            PurchCrMemoHeader.SETRANGE("Applies-to Doc. Type", PurchCrMemoHeader."Applies-to Doc. Type"::Invoice);
                            if PurchCrMemoHeader.FINDFIRST() then begin
                                TempRemAmt := 0;
                                VendLedgEntry1.RESET();
                                VendLedgEntry1.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                                VendLedgEntry1.SETRANGE("Document Type", VendLedgEntry1."Document Type"::"Credit Memo");
                                if VendLedgEntry1.FINDFIRST() then
                                    VendLedgEntry1.CALCFIELDS(Amount, "Remaining Amount");
                                WHTEntryTemp.RESET();
                                WHTEntryTemp.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                                WHTEntryTemp.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");
                                WHTEntryTemp.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
                                WHTEntryTemp.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                WHTEntryTemp.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                if WHTEntryTemp.FINDFIRST() then begin
                                    TempRemBase := WHTEntryTemp."Unrealized Amount";
                                    TempRemAmt := WHTEntryTemp."Unrealized Base";
                                end;
                            end;

                            VendLedgEntry.RESET();
                            VendLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                            if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::Invoice then
                                VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::Invoice)
                            else
                                if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::"Credit Memo" then
                                    VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::"Credit Memo");
                            if VendLedgEntry.FINDFIRST() then
                                VendLedgEntry.CALCFIELDS(Amount, "Remaining Amount");
                            ExpectedAmount := -(VendLedgEntry.Amount + VendLedgEntry1.Amount);
                            if (GenJnlLine."Posting Date" <= VendLedgEntry."Pmt. Discount Date") and
                               (ABS(PaymentAmount1) >=
                                (ABS(VendLedgEntry."Remaining Amount" + VendLedgEntry1."Remaining Amount") -
                                 ABS(VendLedgEntry."Original Pmt. Disc. Possible")))
                            then
                                AppldAmount :=
                                  ROUND(
                                    ((PaymentAmount1 - VendLedgEntry."Original Pmt. Disc. Possible") *
                                     (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount)
                            else
                                AppldAmount :=
                                  ROUND(
                                    (PaymentAmount1 * (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount);

                            PaymentAmount := PaymentAmount + AppldAmount;
                        end;
                    Source::Customer:
                        begin
                            SalesCrMemoHeader.SETRANGE("Applies-to Doc. Type", SalesCrMemoHeader."Applies-to Doc. Type"::Invoice);
                            SalesCrMemoHeader.SETRANGE("Applies-to Doc. No.", GenJnlLine."Applies-to Doc. No.");
                            if SalesCrMemoHeader.FINDFIRST() then begin
                                TempRemAmt := 0;
                                CustLedgEntry1.RESET();
                                CustLedgEntry1.SETRANGE("Document No.", SalesCrMemoHeader."No.");
                                CustLedgEntry1.SETRANGE("Document Type", CustLedgEntry1."Document Type"::"Credit Memo");
                                if CustLedgEntry1.FINDFIRST() then
                                    CustLedgEntry1.CALCFIELDS(Amount, "Remaining Amount");
                                WHTEntryTemp.RESET();
                                WHTEntryTemp.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");
                                WHTEntryTemp.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Sale);
                                WHTEntryTemp.SETRANGE("Document No.", SalesCrMemoHeader."No.");
                                WHTEntryTemp.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                WHTEntryTemp.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                if WHTEntryTemp.FINDFIRST() then begin
                                    TempRemBase := WHTEntryTemp."Unrealized Amount";
                                    TempRemAmt := WHTEntryTemp."Unrealized Base";
                                end;
                            end;

                            CustLedgEntry.RESET();
                            CustLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                            CustLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                            if CustLedgEntry.FINDFIRST() then
                                CustLedgEntry.CALCFIELDS(Amount, "Remaining Amount");
                            ExpectedAmount := -(CustLedgEntry.Amount + CustLedgEntry1.Amount);
                            if (GenJnlLine."Posting Date" <= CustLedgEntry."Pmt. Discount Date") and
                               (ABS(PaymentAmount1) >=
                                (ABS(CustLedgEntry."Remaining Amount" + CustLedgEntry1."Remaining Amount") -
                                 ABS(CustLedgEntry."Original Pmt. Disc. Possible")))
                            then
                                AppldAmount :=
                                  ROUND(
                                    ((PaymentAmount1 - CustLedgEntry."Original Pmt. Disc. Possible") *
                                     (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount)
                            else
                                AppldAmount :=
                                  ROUND(
                                    (PaymentAmount1 * (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount);
                            PaymentAmount := PaymentAmount + AppldAmount;
                        end;
                end;

                if GenJnlLine."Currency Code" <> WHTEntry."Currency Code" then
                    ERROR(Text1500000);
                WHTAmount1 := ROUND(AppldAmount * WHTEntry."WHT %" / 100);
                WHTEntry3.RESET();
                WHTEntry3.SETCURRENTKEY("Applies-to Entry No.");
                WHTEntry3.SETRANGE("Applies-to Entry No.", WHTEntry."Entry No.");
                WHTEntry3.CALCSUMS(Amount);
                if (ABS(ABS(WHTEntry3.Amount) + ABS(WHTAmount1) - ABS(WHTEntry."Unrealized Amount")) < 0.1) and
                   (ABS(ABS(WHTEntry3.Amount) + ABS(WHTAmount1) - ABS(WHTEntry."Unrealized Amount")) > 0)
                then
                    WHTAmount1 := WHTAmount1 + (WHTEntry."Unrealized Amount" - (WHTEntry3.Amount + WHTAmount1));

                WHTTotAmt := ROUND(WHTTotAmt + WHTAmount1);
            until (WHTEntry.NEXT() = 0);
            exit(WHTTotAmt);
        end;
    end;

    procedure ApplyTempWHTEntry(var GenJnlLine: Record "Gen. Journal Line"; Source: Option Vendor,Customer) PaymentNo: Integer;
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntry1: Record "Cust. Ledger Entry";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        PurchSetup: Record "Purchases & Payables Setup";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        TempWHTEntry: Record "Temp WHT Entry FND";
        WHTEntry3: Record "Temp WHT Entry FND";
        VendLedgEntry: Record "Vendor Ledger Entry";
        VendLedgEntry1: Record "Vendor Ledger Entry";
        WHTEntry: Record "WHT Entry FND";
        WHTEntryTemp: Record "WHT Entry FND";
        WHTSlipNo: Code[10];
        AppldAmount: Decimal;
        ExpectedAmount: Decimal;
        PaymentAmount: Decimal;
        PaymentAmount1: Decimal;
        PaymentAmountLCY: Decimal;
    begin
        PaymentAmount := GenJnlLine.Amount;
        PaymentAmount1 := GenJnlLine.Amount;
        PaymentAmountLCY := GenJnlLine."Amount (LCY)";
        WHTEntry.RESET();
        WHTEntry.SETCURRENTKEY("Transaction Type", "Document No.", "Document Type", "Bill-to/Pay-to No.");
        case Source of
            Source::Vendor:
                WHTEntry.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
            Source::Customer:
                WHTEntry.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Sale);
        end;
        if GenJnlLine."Applies-to Doc. No." <> '' then begin
            WHTEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
            WHTEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
        end else
            WHTEntry.SETRANGE("Bill-to/Pay-to No.", GenJnlLine."Account No.");
        if WHTEntry.findset() then
            repeat
                case Source of
                    Source::Vendor:
                        begin
                            if GenJnlLine."Applies-to Doc. No." = '' then
                                exit;
                            PurchCrMemoHeader.RESET();
                            PurchCrMemoHeader.SETRANGE("Applies-to Doc. No.", GenJnlLine."Applies-to Doc. No.");
                            PurchCrMemoHeader.SETRANGE("Applies-to Doc. Type", PurchCrMemoHeader."Applies-to Doc. Type"::Invoice);
                            if PurchCrMemoHeader.FINDFIRST() then begin
                                TempRemAmt := 0;
                                VendLedgEntry1.SETRANGE("Document Type", VendLedgEntry1."Document Type"::"Credit Memo");
                                VendLedgEntry1.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                                if VendLedgEntry1.FINDFIRST() then
                                    VendLedgEntry1.CALCFIELDS(Amount, "Remaining Amount");
                                WHTEntryTemp.RESET();
                                WHTEntryTemp.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                                WHTEntryTemp.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");
                                WHTEntryTemp.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
                                WHTEntryTemp.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                WHTEntryTemp.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                if WHTEntryTemp.FINDFIRST() then begin
                                    TempRemBase := WHTEntryTemp."Unrealized Amount";
                                    TempRemAmt := WHTEntryTemp."Unrealized Base";
                                end;
                            end;
                            VendLedgEntry.RESET();
                            VendLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                            if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::Invoice then
                                VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::Invoice)
                            else
                                if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::"Credit Memo" then
                                    VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::"Credit Memo");

                            if VendLedgEntry.FINDFIRST() then
                                VendLedgEntry.CALCFIELDS(Amount, "Remaining Amount");
                            ExpectedAmount := -(VendLedgEntry.Amount + VendLedgEntry1.Amount);
                            if (GenJnlLine."Posting Date" <= VendLedgEntry."Pmt. Discount Date") and
                               (ABS(PaymentAmount1) >=
                                (ABS(VendLedgEntry."Remaining Amt. (LCY)" + VendLedgEntry1."Remaining Amt. (LCY)") -
                                 ABS(VendLedgEntry."Original Pmt. Disc. Possible")))
                            then begin
                                AppldAmount :=
                                  ROUND(
                                    ((PaymentAmount1 - VendLedgEntry."Original Pmt. Disc. Possible") *
                                     (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount);
                                WHTEntry."Remaining Unrealized Base" :=
                                  ROUND(
                                    WHTEntry."Remaining Unrealized Base" -
                                    ROUND(
                                      ((PaymentAmount1 - VendLedgEntry."Original Pmt. Disc. Possible") *
                                       (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount));
                                WHTEntry."Remaining Unrealized Amount" :=
                                  ROUND(
                                    WHTEntry."Remaining Unrealized Amount" -
                                    ROUND(
                                      ((PaymentAmount1 - VendLedgEntry."Original Pmt. Disc. Possible") *
                                       (WHTEntry."Unrealized Amount" + TempRemBase)) / ExpectedAmount));
                            end else begin
                                AppldAmount :=
                                  ROUND(
                                    (PaymentAmount1 * (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount);
                                WHTEntry."Remaining Unrealized Base" :=
                                  ROUND(
                                    WHTEntry."Remaining Unrealized Base" -
                                    ROUND(
                                      (PaymentAmount1 *
                                       (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount));
                                WHTEntry."Remaining Unrealized Amount" :=
                                  ROUND(
                                    WHTEntry."Remaining Unrealized Amount" -
                                    ROUND(
                                      (PaymentAmount1 * (WHTEntry."Unrealized Amount" + TempRemBase)) /
                                      ExpectedAmount));
                            end;
                            PaymentAmount := PaymentAmount + AppldAmount;
                        end;
                    Source::Customer:
                        begin
                            SalesCrMemoHeader.RESET();
                            SalesCrMemoHeader.SETRANGE("Applies-to Doc. Type", SalesCrMemoHeader."Applies-to Doc. Type"::Invoice);
                            SalesCrMemoHeader.SETRANGE("Applies-to Doc. No.", GenJnlLine."Applies-to Doc. No.");
                            if SalesCrMemoHeader.FINDFIRST() then begin
                                TempRemAmt := 0;
                                CustLedgEntry1.RESET();
                                CustLedgEntry1.SETRANGE("Document No.", SalesCrMemoHeader."No.");
                                CustLedgEntry1.SETRANGE("Document Type", CustLedgEntry1."Document Type"::"Credit Memo");
                                if CustLedgEntry1.FINDFIRST() then
                                    CustLedgEntry1.CALCFIELDS(Amount, "Remaining Amount");
                                WHTEntryTemp.RESET();
                                WHTEntryTemp.SETRANGE("Document No.", SalesCrMemoHeader."No.");
                                WHTEntryTemp.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");
                                WHTEntryTemp.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Sale);
                                WHTEntryTemp.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                WHTEntryTemp.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                if WHTEntryTemp.FINDFIRST() then begin
                                    TempRemBase := WHTEntryTemp."Unrealized Amount";
                                    TempRemAmt := WHTEntryTemp."Unrealized Base";
                                end;
                            end;

                            CustLedgEntry.RESET();
                            CustLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                            CustLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                            if CustLedgEntry.FINDFIRST() then
                                CustLedgEntry.CALCFIELDS(Amount, "Remaining Amount");
                            ExpectedAmount := -(CustLedgEntry.Amount + CustLedgEntry1.Amount);
                            if (GenJnlLine."Posting Date" <= CustLedgEntry."Pmt. Discount Date") and
                               (ABS(PaymentAmount1) >=
                                (ABS(CustLedgEntry."Remaining Amount" + CustLedgEntry1."Remaining Amt. (LCY)") -
                                 ABS(CustLedgEntry."Original Pmt. Disc. Possible")))
                            then begin
                                AppldAmount :=
                                  ROUND(
                                    ((PaymentAmount1 - CustLedgEntry."Original Pmt. Disc. Possible") *
                                     (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount);

                                WHTEntry."Remaining Unrealized Base" :=
                                  ROUND(
                                    WHTEntry."Remaining Unrealized Base" -
                                    ROUND(
                                      ((PaymentAmount1 - CustLedgEntry."Original Pmt. Disc. Possible") *
                                       (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount));

                                WHTEntry."Remaining Unrealized Amount" :=
                                  ROUND(
                                    WHTEntry."Remaining Unrealized Amount" -
                                    ROUND(
                                      ((PaymentAmount1 - CustLedgEntry."Original Pmt. Disc. Possible") *
                                       (WHTEntry."Unrealized Amount" + TempRemBase)) / ExpectedAmount));
                            end else begin
                                AppldAmount :=
                                  ROUND(
                                    (PaymentAmount1 * (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount);

                                WHTEntry."Remaining Unrealized Base" :=
                                  ROUND(
                                    WHTEntry."Remaining Unrealized Base" -
                                    ROUND(
                                      (PaymentAmount1 * (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount));
                                WHTEntry."Remaining Unrealized Amount" :=
                                  ROUND(
                                    WHTEntry."Remaining Unrealized Amount" -
                                    ROUND(
                                      (PaymentAmount1 * (WHTEntry."Unrealized Amount" + TempRemBase)) / ExpectedAmount));
                            end;
                            PaymentAmount := PaymentAmount + AppldAmount;
                        end;
                end;

                TempWHTEntry.INIT();
                TempWHTEntry."Posting Date" := GenJnlLine."Document Date";
                TempWHTEntry."Entry No." := NextTempEntryNo();
                TempWHTEntry."Document Date" := WHTEntry."Document Date";
                TempWHTEntry."Document Type" := GenJnlLine."Document Type";
                TempWHTEntry."Document No." := WHTEntry."Document No.";
                TempWHTEntry."Gen. Bus. Posting Group" := WHTEntry."Gen. Bus. Posting Group";
                TempWHTEntry."Gen. Prod. Posting Group" := WHTEntry."Gen. Prod. Posting Group";
                TempWHTEntry."Bill-to/Pay-to No." := WHTEntry."Bill-to/Pay-to No.";
                TempWHTEntry."WHT Bus. Posting Group" := WHTEntry."WHT Bus. Posting Group";
                TempWHTEntry."WHT Prod. Posting Group" := WHTEntry."WHT Prod. Posting Group";
                TempWHTEntry."WHT Revenue Type" := WHTEntry."WHT Revenue Type";
                TempWHTEntry."Currency Code" := GenJnlLine."Currency Code";
                TempWHTEntry."Unrealized WHT Entry No." := WHTEntry."Entry No.";
                TempWHTEntry."Applies-to Entry No." := WHTEntry."Entry No.";
                TempWHTEntry."User ID" := USERID;
                TempWHTEntry."External Document No." := GenJnlLine."External Document No.";
                TempWHTEntry."Original Document No." := GenJnlLine."Document No.";
                TempWHTEntry."Source Code" := GenJnlLine."Source Code";
                TempWHTEntry."WHT %" := WHTEntry."WHT %";
                case Source of
                    Source::Vendor:
                        begin
                            TempWHTEntry.Base := ROUND(AppldAmount);
                            TempWHTEntry.Amount := ROUND(TempWHTEntry.Base * TempWHTEntry."WHT %" / 100);
                            TempWHTEntry."Transaction Type" := TempWHTEntry."Transaction Type"::Purchase;
                        end;
                    Source::Customer:
                        begin
                            TempWHTEntry.Base := ROUND(AppldAmount);
                            TempWHTEntry.Amount := ROUND(TempWHTEntry.Base * TempWHTEntry."WHT %" / 100);
                            TempWHTEntry."Transaction Type" := TempWHTEntry."Transaction Type"::Sale;
                        end;
                end;
                if TempWHTEntry."Currency Code" <> '' then begin
                    CurrFactor :=
                      CurrExchRate.ExchangeRate(
                        TempWHTEntry."Posting Date", TempWHTEntry."Currency Code");

                    TempWHTEntry."Base (LCY)" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          GenJnlLine."Document Date",
                          TempWHTEntry."Currency Code",
                          TempWHTEntry.Base, CurrFactor));

                    TempWHTEntry."Amount (LCY)" :=
                      ROUND(
                        TempWHTEntry."Base (LCY)" * TempWHTEntry."WHT %" / 100);
                end else begin
                    TempWHTEntry."Amount (LCY)" := TempWHTEntry.Amount;
                    TempWHTEntry."Base (LCY)" := TempWHTEntry.Base;
                end;

                if WHTSlipNo = '' then begin
                    PurchSetup.GET();
                    WHTSlipNo :=
                      NoSeriesMgt.GetNextNo(
                        PurchSetup."WHT Certificate No. Series FND", TempWHTEntry."Posting Date", true);
                end;

                TempWHTEntry."WHT Certificate No." := WHTSlipNo;
                WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                TempWHTEntry."WHT Report" := WHTPostingSetup."WHT Report";

                if GenJnlLine."WHT Report Line No. FND" <> '' then
                    TempWHTEntry."WHT Report Line No" := GenJnlLine."WHT Report Line No. FND";

                TempWHTEntry.INSERT();
                NextWHTEntryNo := NextWHTEntryNo + 1;
                TType := TType::Purchase;
                WHTEntry3.RESET();
                WHTEntry3.SETCURRENTKEY("Applies-to Entry No.");
                WHTEntry3.SETRANGE("Applies-to Entry No.", WHTEntry."Entry No.");
                WHTEntry3.CALCSUMS(Amount, "Amount (LCY)");

                if (ABS(ABS(WHTEntry3.Amount) - ABS(WHTEntry."Unrealized Amount")) < 0.1) and
                   (ABS(ABS(WHTEntry3.Amount) - ABS(WHTEntry."Unrealized Amount")) > 0)
                then begin
                    TempWHTEntry."WHT Difference" := WHTEntry."Unrealized Amount" - WHTEntry3.Amount;
                    TempWHTEntry.Amount := TempWHTEntry.Amount - TempWHTEntry."WHT Difference";
                    TempWHTEntry.MODIFY();
                end;

                if (ABS(ABS(WHTEntry3."Amount (LCY)") - ABS(WHTEntry."Unrealized Amount (LCY)")) < 0.1) and
                   (ABS(ABS(WHTEntry3."Amount (LCY)") - ABS(WHTEntry."Unrealized Amount (LCY)")) > 0)
                then begin
                    TempWHTEntry."Amount (LCY)" :=
                      TempWHTEntry."Amount (LCY)" - WHTEntry."Unrealized Amount (LCY)" + WHTEntry3."Amount (LCY)";
                    TempWHTEntry.MODIFY();
                end;
            until (WHTEntry.NEXT() = 0);
    end;

    procedure ApplyTempVendInvoiceWHT(var GenJnlLine: Record "Gen. Journal Line") EntryNo: Integer;
    var
        GenJnlLineTemp: Record "Gen. Journal Line";
        RemainingAmt: Decimal;
        Currency: Option Vendor,Customer;
    begin
        GenJnlLineTemp.COPY(GenJnlLine);
        TempVendLedgEntry1.RESET();
        if GenJnlLine."Applies-to Doc. No." = '' then begin
            TempVendLedgEntry1.SETRANGE(Open, true);
            TempVendLedgEntry1.SETRANGE("Applies-to ID", GenJnlLine."Document No.");
            if TempVendLedgEntry1.findset() then
                repeat
                    TempVendLedgEntry1.CALCFIELDS(
                      Amount, "Amount (LCY)",
                      "Remaining Amount",
                      "Remaining Amt. (LCY)",
                      "Original Amount",
                      "Original Amt. (LCY)");
                    RemainingAmt := RemainingAmt + TempVendLedgEntry1."Remaining Amt. (LCY)";
                    if TempVendLedgEntry1."Document Type" = TempVendLedgEntry1."Document Type"::"Credit Memo" then
                        RemainingAmt := RemainingAmt + TempVendLedgEntry1."Remaining Amt. (LCY)";
                until TempVendLedgEntry1.NEXT() = 0;

            TotAmt := ABS(GenJnlLineTemp.Amount);
            TempVendLedgEntry.RESET();
            TempVendLedgEntry.SETRANGE("Applies-to ID", GenJnlLineTemp."Document No.");
            TempVendLedgEntry.SETRANGE(Open, true);
            TempVendLedgEntry.SETRANGE("Document Type", TempVendLedgEntry."Document Type"::"Credit Memo");
            if TempVendLedgEntry.findset() then
                repeat
                    TempVendLedgEntry.CALCFIELDS(
                      Amount,
                      "Amount (LCY)",
                      "Remaining Amount",
                      "Remaining Amt. (LCY)",
                      "Original Amount",
                      "Original Amt. (LCY)");

                    if (GenJnlLineTemp."Posting Date" < TempVendLedgEntry."Pmt. Discount Date") and
                       (ABS(TotAmt) >= (ABS(TempVendLedgEntry."Remaining Amt. (LCY)") -
                                        ABS(TempVendLedgEntry."Original Pmt. Disc. Possible")))
                    then
                        TotAmt := TotAmt - TempVendLedgEntry."Original Pmt. Disc. Possible";

                    if (ABS(RemainingAmt) < ABS(TotAmt)) or
                       (ABS(TempVendLedgEntry."Remaining Amt. (LCY)") < ABS(TotAmt))
                    then begin
                        if (GenJnlLineTemp."Posting Date" < TempVendLedgEntry."Pmt. Discount Date") and
                           (ABS(TotAmt) >= (ABS(TempVendLedgEntry."Remaining Amt. (LCY)") -
                                            ABS(TempVendLedgEntry."Original Pmt. Disc. Possible")))
                        then begin
                            GenJnlLineTemp.VALIDATE(
                              Amount,
                              -ABS(TempVendLedgEntry."Remaining Amt. (LCY)" +
                                TempVendLedgEntry."Original Pmt. Disc. Possible"));
                            if TempVendLedgEntry."Document Type" <> TempVendLedgEntry."Document Type"::"Credit Memo" then
                                TotAmt := TotAmt - TempVendLedgEntry."Remaining Amt. (LCY)";
                            RemainingAmt :=
                              RemainingAmt - TempVendLedgEntry."Remaining Amt. (LCY)" + TempVendLedgEntry."Original Pmt. Disc. Possible";
                        end else begin
                            GenJnlLineTemp.VALIDATE(Amount, -ABS(TempVendLedgEntry."Remaining Amt. (LCY)"));
                            if TempVendLedgEntry."Document Type" <> TempVendLedgEntry."Document Type"::"Credit Memo" then
                                TotAmt := TotAmt - TempVendLedgEntry."Remaining Amt. (LCY)";
                            RemainingAmt := RemainingAmt - TempVendLedgEntry."Remaining Amt. (LCY)";
                        end;
                    end else begin
                        if (GenJnlLineTemp."Posting Date" < TempVendLedgEntry."Pmt. Discount Date") and
                           (ABS(TotAmt) >= (ABS(TempVendLedgEntry."Remaining Amt. (LCY)") -
                                            ABS(TempVendLedgEntry."Original Pmt. Disc. Possible")))
                        then
                            GenJnlLineTemp.VALIDATE(Amount, TotAmt + TempVendLedgEntry."Original Pmt. Disc. Possible")
                        else
                            GenJnlLineTemp.VALIDATE(Amount, TotAmt);
                        ExitLoop := true;
                    end;

                    if TempVendLedgEntry."Document Type" = TempVendLedgEntry."Document Type"::Invoice then
                        GenJnlLineTemp."Applies-to Doc. Type" := GenJnlLineTemp."Applies-to Doc. Type"::Invoice
                    else begin
                        if TempVendLedgEntry."Document Type" = TempVendLedgEntry."Document Type"::"Credit Memo" then
                            GenJnlLineTemp."Applies-to Doc. Type" := GenJnlLineTemp."Applies-to Doc. Type"::"Credit Memo";
                        RemainingAmt := RemainingAmt - TempVendLedgEntry."Remaining Amt. (LCY)";
                        TotAmt := TotAmt + TempVendLedgEntry."Remaining Amt. (LCY)";
                        ExitLoop := false;
                    end;

                    GenJnlLineTemp."Applies-to Doc. No." := TempVendLedgEntry."Document No.";
                    NextEntry := ApplyTempWHTEntry(GenJnlLineTemp, Currency::Vendor);
                    if ExitLoop then
                        exit(NextEntry);
                until TempVendLedgEntry.NEXT() = 0;

            ExitLoop := false;
            TempVendLedgEntry.RESET();
            TempVendLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Document No.");
            TempVendLedgEntry.SETRANGE(Open, true);
            TempVendLedgEntry.SETFILTER("Document Type", '<>%1', TempVendLedgEntry."Document Type"::"Credit Memo");
            if TempVendLedgEntry.findset() then begin
                repeat
                    TempVendLedgEntry.CALCFIELDS(
                      Amount,
                      "Amount (LCY)",
                      "Remaining Amount",
                      "Remaining Amt. (LCY)",
                      "Original Amount",
                      "Original Amt. (LCY)");
                    if (GenJnlLineTemp."Posting Date" < TempVendLedgEntry."Pmt. Discount Date") and
                       (ABS(TotAmt) >= (ABS(TempVendLedgEntry."Remaining Amt. (LCY)") -
                                        ABS(TempVendLedgEntry."Original Pmt. Disc. Possible")))
                    then
                        TotAmt := TotAmt - TempVendLedgEntry."Original Pmt. Disc. Possible";
                    if (ABS(RemainingAmt) < ABS(TotAmt)) or
                       (ABS(TempVendLedgEntry."Remaining Amt. (LCY)") < ABS(TotAmt))
                    then begin
                        if (GenJnlLineTemp."Posting Date" < TempVendLedgEntry."Pmt. Discount Date") and
                           (ABS(TotAmt) >= (ABS(TempVendLedgEntry."Remaining Amt. (LCY)") -
                                            ABS(TempVendLedgEntry."Original Pmt. Disc. Possible")))
                        then begin
                            GenJnlLineTemp.VALIDATE(
                              Amount,
                              ABS(TempVendLedgEntry."Remaining Amt. (LCY)" -
                                TempVendLedgEntry."Original Pmt. Disc. Possible"));

                            if TempVendLedgEntry."Document Type" <> TempVendLedgEntry."Document Type"::"Credit Memo" then
                                TotAmt := TotAmt + TempVendLedgEntry."Remaining Amt. (LCY)";
                            RemainingAmt :=
                              RemainingAmt - TempVendLedgEntry."Remaining Amt. (LCY)" + TempVendLedgEntry."Original Pmt. Disc. Possible";
                        end else begin
                            GenJnlLineTemp.VALIDATE(Amount, ABS(TempVendLedgEntry."Remaining Amt. (LCY)"));
                            if TempVendLedgEntry."Document Type" <> TempVendLedgEntry."Document Type"::"Credit Memo" then
                                TotAmt := TotAmt + TempVendLedgEntry."Remaining Amt. (LCY)";
                            RemainingAmt := RemainingAmt - TempVendLedgEntry."Remaining Amt. (LCY)";
                        end;
                    end else begin
                        if (GenJnlLineTemp."Posting Date" < TempVendLedgEntry."Pmt. Discount Date") and
                           (ABS(TotAmt) >= (ABS(TempVendLedgEntry."Remaining Amt. (LCY)") -
                                            ABS(TempVendLedgEntry."Original Pmt. Disc. Possible")))
                        then
                            GenJnlLineTemp.VALIDATE(Amount, TotAmt + TempVendLedgEntry."Original Pmt. Disc. Possible")
                        else
                            GenJnlLineTemp.VALIDATE(Amount, TotAmt);
                        ExitLoop := true;
                    end;

                    if TempVendLedgEntry."Document Type" = TempVendLedgEntry."Document Type"::Invoice then
                        GenJnlLineTemp."Applies-to Doc. Type" := GenJnlLineTemp."Applies-to Doc. Type"::Invoice
                    else begin
                        if TempVendLedgEntry."Document Type" = TempVendLedgEntry."Document Type"::"Credit Memo" then
                            GenJnlLineTemp."Applies-to Doc. Type" := GenJnlLineTemp."Applies-to Doc. Type"::"Credit Memo";
                        RemainingAmt := RemainingAmt + TempVendLedgEntry."Remaining Amt. (LCY)";
                        TotAmt := TotAmt + TempVendLedgEntry."Remaining Amt. (LCY)";
                    end;

                    GenJnlLineTemp."Applies-to Doc. No." := TempVendLedgEntry."Document No.";
                    NextEntry := ApplyTempWHTEntry(GenJnlLineTemp, Currency::Vendor);
                    if ExitLoop then
                        exit(NextEntry);
                until TempVendLedgEntry.NEXT() = 0;
            end else
                NextEntry := ApplyTempWHTEntry(GenJnlLineTemp, Currency::Vendor);
        end else
            NextEntry := ApplyTempWHTEntry(GenJnlLineTemp, Currency::Vendor);
    end;

    procedure VoidCheck2(CheckLedgEntry: Record "Check Ledger Entry");
    var
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
    begin
        BankAccLedgEntry.GET(CheckLedgEntry."Bank Account Ledger Entry No.");
    end;

    procedure ApplyVendInvoiceWHTPosted(var VendLedgerEntry: Record "Vendor Ledger Entry"; var GenJnlLine: Record "Gen. Journal Line"; TransNo: Integer) EntryNo: Integer;
    var
        RemainingAmt: Decimal;
        Currency: Option Vendor,Customer;
    begin
        TempVendLedgEntry.RESET();
        if GenJnlLine."Applies-to Doc. No." = '' then begin
            TempVendLedgEntry1.SETRANGE("Applies-to ID", GenJnlLine."Document No.");
            TempVendLedgEntry1.SETRANGE(Open, true);
            if TempVendLedgEntry1.findset(true) then
                repeat
                    TempVendLedgEntry1.CALCFIELDS(
                      Amount,
                      "Amount (LCY)",
                      "Remaining Amount",
                      "Remaining Amt. (LCY)",
                      "Original Amount",
                      "Original Amt. (LCY)");

                    if TempVendLedgEntry1."Rem. Amt for WHT FND" = 0 then
                        TempVendLedgEntry1."Rem. Amt for WHT FND" := TempVendLedgEntry1."Remaining Amt. (LCY)";
                    RemainingAmt := RemainingAmt + TempVendLedgEntry1."Rem. Amt for WHT FND";
                    if TempVendLedgEntry1."Document Type" = TempVendLedgEntry1."Document Type"::"Credit Memo" then
                        RemainingAmt := RemainingAmt + TempVendLedgEntry1."Rem. Amt for WHT FND";
                until TempVendLedgEntry1.NEXT() = 0;

            TotAmt := ABS(GenJnlLine.Amount);
            if GenJnlLine."Applies-to ID" <> '' then
                TempVendLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID")
            else
                TempVendLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Document No.");
            TempVendLedgEntry.SETRANGE("Document Type", TempVendLedgEntry."Document Type"::"Credit Memo");

            if TempVendLedgEntry.findset() then
                repeat
                    TempVendLedgEntry.CALCFIELDS(
                      Amount,
                      "Amount (LCY)",
                      "Remaining Amount",
                      "Remaining Amt. (LCY)",
                      "Original Amount",
                      "Original Amt. (LCY)");

                    if (GenJnlLine."Posting Date" <= TempVendLedgEntry."Pmt. Discount Date") and
                       (ABS(TotAmt) >= (ABS(TempVendLedgEntry."Rem. Amt for WHT FND") -
                                        ABS(TempVendLedgEntry."Original Pmt. Disc. Possible")))
                    then
                        TotAmt := TotAmt - TempVendLedgEntry."Original Pmt. Disc. Possible";

                    if (ABS(RemainingAmt) < ABS(TotAmt)) or
                       (ABS(TempVendLedgEntry."Rem. Amt for WHT FND") < ABS(TotAmt))
                    then begin
                        if (GenJnlLine."Posting Date" <= TempVendLedgEntry."Pmt. Discount Date") and
                           (ABS(TotAmt) >= (ABS(TempVendLedgEntry."Rem. Amt for WHT FND") -
                                            ABS(TempVendLedgEntry."Original Pmt. Disc. Possible")))
                        then begin
                            GenJnlLine.VALIDATE(
                              Amount,
                              -ABS(TempVendLedgEntry."Rem. Amt for WHT FND" +
                                TempVendLedgEntry."Original Pmt. Disc. Possible"));

                            if TempVendLedgEntry."Document Type" <> TempVendLedgEntry."Document Type"::"Credit Memo" then
                                TotAmt := TotAmt - TempVendLedgEntry."Rem. Amt for WHT FND";
                            RemainingAmt :=
                              RemainingAmt - TempVendLedgEntry."Rem. Amt for WHT FND" + TempVendLedgEntry."Original Pmt. Disc. Possible";
                        end else begin
                            GenJnlLine.VALIDATE(Amount, -ABS(TempVendLedgEntry."Rem. Amt for WHT FND"));
                            if TempVendLedgEntry."Document Type" <> TempVendLedgEntry."Document Type"::"Credit Memo" then
                                TotAmt := TotAmt - TempVendLedgEntry."Rem. Amt for WHT FND";
                            RemainingAmt := RemainingAmt - TempVendLedgEntry."Rem. Amt for WHT FND";
                        end;
                    end else begin
                        if (GenJnlLine."Posting Date" <= TempVendLedgEntry."Pmt. Discount Date") and
                           (ABS(TotAmt) >= (ABS(TempVendLedgEntry."Rem. Amt for WHT FND") -
                                            ABS(TempVendLedgEntry."Original Pmt. Disc. Possible")))
                        then
                            GenJnlLine.VALIDATE(Amount, TotAmt + TempVendLedgEntry."Original Pmt. Disc. Possible")
                        else
                            GenJnlLine.VALIDATE(Amount, TotAmt);
                        ExitLoop := true;
                    end;

                    if TempVendLedgEntry."Document Type" = TempVendLedgEntry."Document Type"::Invoice then
                        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice
                    else begin
                        if TempVendLedgEntry."Document Type" = TempVendLedgEntry."Document Type"::"Credit Memo" then
                            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::"Credit Memo";
                        RemainingAmt := RemainingAmt - TempVendLedgEntry."Rem. Amt for WHT FND";
                        TotAmt := TotAmt + TempVendLedgEntry."Rem. Amt for WHT FND";
                        ExitLoop := false;
                    end;

                    GenJnlLine."Applies-to Doc. No." := TempVendLedgEntry."Document No.";
                    NextEntry :=
                      ProcessPaymentPosted(
                        GenJnlLine, TransNo, VendLedgerEntry."Entry No.", Currency::Vendor);

                    if ExitLoop then
                        exit(NextEntry);
                until TempVendLedgEntry.NEXT() = 0;

            ExitLoop := false;
            TempVendLedgEntry.RESET();
            if GenJnlLine."Applies-to ID" <> '' then
                TempVendLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID")
            else
                TempVendLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Document No.");

            TempVendLedgEntry.SETFILTER("Document Type", '<>%1', TempVendLedgEntry."Document Type"::"Credit Memo");
            if TempVendLedgEntry.findset() then begin
                repeat
                    TempVendLedgEntry.CALCFIELDS(
                      Amount, "Amount (LCY)",
                      "Remaining Amount",
                      "Remaining Amt. (LCY)",
                      "Original Amount",
                      "Original Amt. (LCY)");

                    if (GenJnlLine."Posting Date" <= TempVendLedgEntry."Pmt. Discount Date") and
                       (ABS(TotAmt) >= (ABS(TempVendLedgEntry."Rem. Amt for WHT FND") -
                                        ABS(TempVendLedgEntry."Original Pmt. Disc. Possible")))
                    then
                        TotAmt := TotAmt - TempVendLedgEntry."Original Pmt. Disc. Possible";

                    if (ABS(RemainingAmt) < ABS(TotAmt)) or
                       (ABS(TempVendLedgEntry."Rem. Amt for WHT FND") < ABS(TotAmt))
                    then begin
                        if (GenJnlLine."Posting Date" <= TempVendLedgEntry."Pmt. Discount Date") and
                           (ABS(TotAmt) >= (ABS(TempVendLedgEntry."Rem. Amt for WHT FND") -
                                            ABS(TempVendLedgEntry."Original Pmt. Disc. Possible")))
                        then begin
                            GenJnlLine.VALIDATE(
                              Amount,
                              ABS(TempVendLedgEntry."Rem. Amt for WHT FND" -
                                TempVendLedgEntry."Original Pmt. Disc. Possible"));

                            if TempVendLedgEntry."Document Type" <> TempVendLedgEntry."Document Type"::"Credit Memo" then
                                TotAmt := TotAmt + TempVendLedgEntry."Rem. Amt for WHT FND";
                            RemainingAmt :=
                              RemainingAmt -
                              TempVendLedgEntry."Rem. Amt for WHT FND" +
                              TempVendLedgEntry."Original Pmt. Disc. Possible";
                        end else begin
                            GenJnlLine.VALIDATE(Amount, ABS(TempVendLedgEntry."Rem. Amt for WHT FND"));
                            if TempVendLedgEntry."Document Type" <>
                               TempVendLedgEntry."Document Type"::"Credit Memo"
                            then
                                TotAmt := TotAmt + TempVendLedgEntry."Rem. Amt for WHT FND";
                            RemainingAmt := RemainingAmt - TempVendLedgEntry."Rem. Amt for WHT FND";
                        end;
                    end else begin
                        if (GenJnlLine."Posting Date" <= TempVendLedgEntry."Pmt. Discount Date") and
                           (ABS(TotAmt) >= (ABS(TempVendLedgEntry."Rem. Amt for WHT FND") -
                                            ABS(TempVendLedgEntry."Original Pmt. Disc. Possible")))
                        then
                            GenJnlLine.VALIDATE(Amount, TotAmt + TempVendLedgEntry."Original Pmt. Disc. Possible")
                        else
                            GenJnlLine.VALIDATE(Amount, TotAmt);
                        ExitLoop := true;
                    end;

                    if TempVendLedgEntry."Document Type" = TempVendLedgEntry."Document Type"::Invoice then
                        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice
                    else begin
                        if TempVendLedgEntry."Document Type" = TempVendLedgEntry."Document Type"::"Credit Memo" then
                            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::"Credit Memo";
                        RemainingAmt := RemainingAmt + TempVendLedgEntry."Rem. Amt for WHT FND";
                        TotAmt := TotAmt + TempVendLedgEntry."Rem. Amt for WHT FND";
                        ExitLoop := false;
                    end;

                    GenJnlLine."Applies-to Doc. No." := TempVendLedgEntry."Document No.";
                    NextEntry :=
                      ProcessPaymentPosted(
                        GenJnlLine, TransNo, VendLedgerEntry."Entry No.", Currency::Vendor);
                    if ExitLoop then
                        exit(NextEntry);
                until TempVendLedgEntry.NEXT() = 0;
                exit(NextEntry);
            end;
            exit(
              ProcessPaymentPosted(
                GenJnlLine, TransNo, VendLedgerEntry."Entry No.", Currency::Vendor));
        end;
        exit(
          ProcessPaymentPosted(
            GenJnlLine, TransNo, VendLedgerEntry."Entry No.", Currency::Vendor));
    end;

    procedure ApplyCustInvoiceWHTPosted(var CustLedgerEntry: Record "Cust. Ledger Entry"; var GenJnlLine: Record "Gen. Journal Line"; TransNo: Integer; AppliedEntryTransNo: Integer) EntryNo: Integer;
    var
        RemainingAmt: Decimal;
        Currency: Option Vendor,Customer;
    begin
        TempCustLedgEntry1.RESET();
        TotAmt := ABS(GenJnlLine.Amount);
        if GenJnlLine."Applies-to Doc. No." = '' then begin
            if GenJnlLine."Applies-to ID" <> '' then
                TempCustLedgEntry1.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID")
            else
                TempCustLedgEntry1.SETRANGE("Applies-to ID", GenJnlLine."Document No.");
            TempCustLedgEntry1.SETFILTER("Document No.", '<>%1', GenJnlLine."Document No.");
            //   if TempCustLedgEntry1.findset(true) then
            if TempCustLedgEntry1.findset(true) then
                repeat
                    TempCustLedgEntry1.CALCFIELDS(
                      Amount,
                      "Amount (LCY)",
                      "Remaining Amount",
                      "Remaining Amt. (LCY)",
                      "Original Amount", "Original Amt. (LCY)");

                    if TempCustLedgEntry1."Rem. Amt for WHT FND" = 0 then
                        TempCustLedgEntry1."Rem. Amt for WHT FND" := TempCustLedgEntry1."Remaining Amt. (LCY)";

                    if GenJnlLine."Posting Date" <= TempCustLedgEntry1."Pmt. Discount Date" then
                        RemainingAmt :=
                          RemainingAmt +
                          TempCustLedgEntry1."Rem. Amt for WHT FND" -
                          TempCustLedgEntry1."Original Pmt. Disc. Possible"
                    else
                        RemainingAmt := RemainingAmt + TempCustLedgEntry1."Rem. Amt for WHT FND";

                    if TempCustLedgEntry1."Document Type" = TempCustLedgEntry1."Document Type"::"Credit Memo" then
                        RemainingAmt := RemainingAmt + TempCustLedgEntry1."Rem. Amt for WHT FND";
                until TempCustLedgEntry1.NEXT() = 0;

            TempCustLedgEntry.RESET();
            if GenJnlLine."Applies-to ID" <> '' then
                TempCustLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID")
            else
                TempCustLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Document No.");
            TempCustLedgEntry.SETRANGE("Document Type", TempCustLedgEntry."Document Type"::"Credit Memo");
            if TempCustLedgEntry.findset() then
                repeat
                    TempCustLedgEntry.CALCFIELDS(
                      Amount,
                      "Amount (LCY)",
                      "Remaining Amount",
                      "Remaining Amt. (LCY)",
                      "Original Amount",
                      "Original Amt. (LCY)");

                    if (GenJnlLine."Posting Date" <= TempCustLedgEntry."Pmt. Discount Date") and
                       (ABS(TotAmt) >= (ABS(TempCustLedgEntry."Rem. Amt for WHT FND") -
                                        ABS(TempCustLedgEntry."Original Pmt. Disc. Possible")))
                    then
                        TotAmt := TotAmt + TempCustLedgEntry."Original Pmt. Disc. Possible";

                    if (ABS(RemainingAmt) <= ABS(TotAmt)) or
                       (ABS(TempCustLedgEntry."Rem. Amt for WHT FND") < ABS(TotAmt))
                    then begin
                        if (GenJnlLine."Posting Date" <= TempCustLedgEntry."Pmt. Discount Date") and
                           (ABS(TotAmt) >= (ABS(TempCustLedgEntry."Rem. Amt for WHT FND") -
                                            ABS(TempCustLedgEntry."Original Pmt. Disc. Possible")))
                        then begin
                            GenJnlLine.VALIDATE(
                              Amount,
                              -ABS(TempCustLedgEntry."Rem. Amt for WHT FND" -
                                TempCustLedgEntry."Original Pmt. Disc. Possible"));

                            if TempCustLedgEntry."Document Type" <>
                               TempCustLedgEntry."Document Type"::"Credit Memo"
                            then
                                TotAmt := -(TotAmt - TempCustLedgEntry."Rem. Amt for WHT FND");

                            RemainingAmt :=
                              RemainingAmt -
                              TempCustLedgEntry."Rem. Amt for WHT FND" +
                              TempCustLedgEntry."Original Pmt. Disc. Possible";
                        end else begin
                            GenJnlLine.VALIDATE(Amount, ABS(TempCustLedgEntry."Rem. Amt for WHT FND"));
                            if TempCustLedgEntry."Document Type" <>
                               TempCustLedgEntry."Document Type"::"Credit Memo"
                            then
                                TotAmt := -(TotAmt - TempCustLedgEntry."Rem. Amt for WHT FND");
                            RemainingAmt := RemainingAmt - TempCustLedgEntry."Rem. Amt for WHT FND";
                        end;
                    end else begin
                        if (GenJnlLine."Posting Date" <= TempCustLedgEntry."Pmt. Discount Date") and
                           (ABS(TotAmt) >= (ABS(TempCustLedgEntry."Rem. Amt for WHT FND") -
                                            ABS(TempCustLedgEntry."Original Pmt. Disc. Possible")))
                        then
                            GenJnlLine.VALIDATE(
                              Amount, ABS(TotAmt - TempCustLedgEntry."Original Pmt. Disc. Possible"))
                        else
                            GenJnlLine.VALIDATE(Amount, ABS(TotAmt));
                        ExitLoop := true;
                    end;

                    if TempCustLedgEntry."Document Type" = TempCustLedgEntry."Document Type"::Invoice then begin
                        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                    end else
                        if TempCustLedgEntry."Document Type" = TempCustLedgEntry."Document Type"::"Credit Memo" then begin
                            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::"Credit Memo";
                            RemainingAmt := RemainingAmt - TempCustLedgEntry."Rem. Amt for WHT FND";
                            TotAmt := TotAmt - TempCustLedgEntry."Rem. Amt for WHT FND";
                            ExitLoop := false;
                        end;
                    GenJnlLine."Applies-to Doc. No." := TempCustLedgEntry."Document No.";
                    NextEntry :=
                      ProcessPaymentPosted(
                        GenJnlLine,
                        TempCustLedgEntry."Transaction No.",
                        CustLedgerEntry."Entry No.",
                        Currency::Customer);

                    if ExitLoop then
                        exit(NextEntry);
                until TempCustLedgEntry.NEXT() = 0;

            ExitLoop := false;
            TempCustLedgEntry.RESET();
            if GenJnlLine."Applies-to ID" <> '' then
                TempCustLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID")
            else
                TempCustLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Document No.");
            TempCustLedgEntry.SETFILTER("Document Type", '<>%1', TempCustLedgEntry."Document Type"::"Credit Memo");
            TempCustLedgEntry.SETFILTER("Document No.", '<>%1', GenJnlLine."Document No.");
            if TempCustLedgEntry.findset() then begin
                repeat
                    TempCustLedgEntry.CALCFIELDS(
                      Amount,
                      "Amount (LCY)",
                      "Remaining Amount",
                      "Remaining Amt. (LCY)",
                      "Original Amount",
                      "Original Amt. (LCY)");

                    if (GenJnlLine."Posting Date" <= TempCustLedgEntry."Pmt. Discount Date") and
                       (ABS(TotAmt) >= (ABS(TempCustLedgEntry."Rem. Amt for WHT FND") -
                                        ABS(TempCustLedgEntry."Original Pmt. Disc. Possible")))
                    then
                        TotAmt := TotAmt + TempCustLedgEntry."Original Pmt. Disc. Possible";

                    if (ABS(RemainingAmt) <= ABS(TotAmt)) or
                       (ABS(TempCustLedgEntry."Rem. Amt for WHT FND") < ABS(TotAmt))
                    then begin
                        if (GenJnlLine."Posting Date" <= TempCustLedgEntry."Pmt. Discount Date") and
                           (ABS(TotAmt) >= (ABS(TempCustLedgEntry."Rem. Amt for WHT FND") -
                                            ABS(TempCustLedgEntry."Original Pmt. Disc. Possible")))
                        then begin
                            RemainingAmt :=
                              RemainingAmt -
                              TempCustLedgEntry."Rem. Amt for WHT FND" +
                              TempCustLedgEntry."Original Pmt. Disc. Possible";

                            if TempCustLedgEntry."Rem. Amt for WHT FND" <> 0 then
                                GenJnlLine.VALIDATE(
                                  Amount,
                                  -ABS(TempCustLedgEntry."Rem. Amt for WHT FND" -
                                    TempCustLedgEntry."Original Pmt. Disc. Possible"));

                            if TempCustLedgEntry."Document Type" <>
                               TempCustLedgEntry."Document Type"::"Credit Memo"
                            then
                                TotAmt := (TotAmt - TempCustLedgEntry."Rem. Amt for WHT FND");
                        end else begin
                            RemainingAmt := RemainingAmt - TempCustLedgEntry."Rem. Amt for WHT FND";
                            if (AppliedEntryTransNo <> 0) and (TempCustLedgEntry."Transaction No." <> AppliedEntryTransNo) then
                                GenJnlLine.VALIDATE(Amount, 0)
                            else
                                if TempCustLedgEntry."Rem. Amt for WHT FND" <> 0 then
                                    GenJnlLine.VALIDATE(Amount, -ABS(TempCustLedgEntry."Rem. Amt for WHT FND"));
                            if TempCustLedgEntry."Document Type" <> TempCustLedgEntry."Document Type"::"Credit Memo" then
                                TotAmt := (TotAmt - TempCustLedgEntry."Rem. Amt for WHT FND");
                        end;
                    end else begin
                        if (GenJnlLine."Posting Date" <= TempCustLedgEntry."Pmt. Discount Date") and
                           (ABS(TotAmt) >= (ABS(TempCustLedgEntry."Rem. Amt for WHT FND") -
                                            ABS(TempCustLedgEntry."Original Pmt. Disc. Possible")))
                        then
                            GenJnlLine.VALIDATE(
                              Amount,
                              -ABS(TotAmt - TempCustLedgEntry."Original Pmt. Disc. Possible"))
                        else
                            GenJnlLine.VALIDATE(Amount, -ABS(TotAmt));
                        ExitLoop := true;
                    end;

                    if TempCustLedgEntry."Document Type" = TempCustLedgEntry."Document Type"::Invoice then
                        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice
                    else
                        if TempCustLedgEntry."Document Type" = TempCustLedgEntry."Document Type"::"Credit Memo" then begin
                            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::"Credit Memo";
                            RemainingAmt := RemainingAmt - TempCustLedgEntry."Rem. Amt for WHT FND";
                            TotAmt := TotAmt - TempCustLedgEntry."Rem. Amt for WHT FND";
                            ExitLoop := false;
                        end;

                    GenJnlLine."Applies-to Doc. No." := TempCustLedgEntry."Document No.";
                    if TempCustLedgEntry."Document Type" = TempCustLedgEntry."Document Type"::Payment then begin
                        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                        GenJnlLine."Applies-to Doc. No." := CustLedgerEntry."Document No.";
                    end;

                    NextEntry :=
                      ProcessPaymentPosted(
                        GenJnlLine, TransNo, CustLedgerEntry."Entry No.", Currency::Customer);

                    if ExitLoop then
                        exit(NextEntry);
                until TempCustLedgEntry.NEXT() = 0;
                exit(NextEntry);
            end;
            exit(
              ProcessPaymentPosted(
                GenJnlLine, TransNo, CustLedgerEntry."Entry No.", Currency::Customer));
        end;
        exit(
          ProcessPaymentPosted(
            GenJnlLine, TransNo, CustLedgerEntry."Entry No.", Currency::Customer));
    end;

    procedure ProcessPaymentPosted(var GenJnlLine: Record "Gen. Journal Line"; TransactionNo: Integer; EntryNo: Integer; Source: Option Vendor,Customer) PaymentNo: Integer;
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntry1: Record "Cust. Ledger Entry";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        TempWHT: Record "Temp WHT Entry FND";
        VendLedgEntry: Record "Vendor Ledger Entry";
        VendLedgEntry1: Record "Vendor Ledger Entry";
        WHTEntry: Record "WHT Entry FND";
        WHTEntry2: Record "WHT Entry FND";
        WHTEntry3: Record "WHT Entry FND";
        WHTEntryTemp: Record "WHT Entry FND";
        AppldAmount: Decimal;
        ExpectedAmount: Decimal;
        PaymentAmount: Decimal;
        PaymentAmount1: Decimal;
        PaymentAmountLCY: Decimal;
        PmtDiscToBeDeducted: Decimal;
    begin
        GLSetup.GET();
        PaymentAmount := GenJnlLine.Amount;
        PaymentAmount1 := GenJnlLine.Amount;
        PaymentAmountLCY := GenJnlLine."Amount (LCY)";

        WHTEntry.RESET();
        WHTEntry.SETCURRENTKEY("Transaction Type", "Document No.", "Document Type", "Bill-to/Pay-to No.");
        if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::Invoice then
            WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::Invoice);

        if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::"Credit Memo" then
            WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");

        case Source of
            Source::Vendor:
                WHTEntry.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
            Source::Customer:
                WHTEntry.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Sale);
        end;

        WHTEntry.SETRANGE(Closed, false);
        if GenJnlLine."Applies-to Doc. No." <> '' then begin
            WHTEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
            WHTEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
        end else
            WHTEntry.SETRANGE("Bill-to/Pay-to No.", GenJnlLine."Account No.");

        if WHTEntry.findset() then
            repeat
                WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                if (WHTPostingSetup."Realized WHT Type" =
                    WHTPostingSetup."Realized WHT Type"::Payment)
                then begin
                    WHTEntry3.RESET();
                    WHTEntry3 := WHTEntry;
                    case Source of
                        Source::Vendor:
                            begin
                                if GenJnlLine."Applies-to Doc. No." = '' then
                                    exit;
                                PurchCrMemoHeader.RESET();
                                PurchCrMemoHeader.SETRANGE("Applies-to Doc. No.", GenJnlLine."Applies-to Doc. No.");
                                PurchCrMemoHeader.SETRANGE("Applies-to Doc. Type", PurchCrMemoHeader."Applies-to Doc. Type"::Invoice);
                                if PurchCrMemoHeader.FINDFIRST() then begin
                                    TempRemAmt := 0;
                                    VendLedgEntry1.SETRANGE("Document Type", VendLedgEntry1."Document Type"::"Credit Memo");
                                    VendLedgEntry1.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                                    if VendLedgEntry1.FINDFIRST() then
                                        VendLedgEntry1.CALCFIELDS(Amount, "Remaining Amount");
                                    WHTEntryTemp.RESET();
                                    WHTEntryTemp.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                                    WHTEntryTemp.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");
                                    WHTEntryTemp.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
                                    WHTEntryTemp.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                    WHTEntryTemp.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                    if WHTEntryTemp.FINDFIRST() then begin
                                        TempRemBase := WHTEntryTemp."Unrealized Amount";
                                        TempRemAmt := WHTEntryTemp."Unrealized Base";
                                    end;
                                end;

                                VendLedgEntry.RESET();
                                VendLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                                if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::Invoice then
                                    VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::Invoice)
                                else
                                    if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::"Credit Memo" then
                                        VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::"Credit Memo");

                                if VendLedgEntry.FINDFIRST() then
                                    VendLedgEntry.CALCFIELDS(Amount, "Remaining Amount");

                                ExpectedAmount := -(VendLedgEntry.Amount + VendLedgEntry1.Amount);
                                if VendLedgEntry1."Amount (LCY)" = 0 then
                                    VendLedgEntry1."Rem. Amt for WHT FND" := 0;
                                if (GenJnlLine."Posting Date" <= VendLedgEntry."Pmt. Discount Date") and
                                   (ABS(PaymentAmount1) >=
                                    (ABS(VendLedgEntry."Rem. Amt for WHT FND" + VendLedgEntry1."Rem. Amt for WHT FND") -
                                     ABS(VendLedgEntry."Original Pmt. Disc. Possible")))
                                then begin
                                    AppldAmount :=
                                      ROUND(
                                        ((PaymentAmount1 - VendLedgEntry."Original Pmt. Disc. Possible") *
                                         (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount);
                                    WHTEntry3."Remaining Unrealized Base" :=
                                      ROUND(
                                        WHTEntry."Remaining Unrealized Base" -
                                        ROUND(
                                          ((PaymentAmount1 - VendLedgEntry."Original Pmt. Disc. Possible") *
                                           (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount));
                                    WHTEntry3."Remaining Unrealized Amount" :=
                                      ROUND(
                                        WHTEntry."Remaining Unrealized Amount" -
                                        ROUND(
                                          ((PaymentAmount1 - VendLedgEntry."Original Pmt. Disc. Possible") *
                                           (WHTEntry."Unrealized Amount" + TempRemBase)) / ExpectedAmount));
                                end else begin
                                    AppldAmount :=
                                      ROUND(
                                        (PaymentAmount1 * (WHTEntry."Unrealized Base" + TempRemAmt)) /
                                        ExpectedAmount);

                                    WHTEntry3."Remaining Unrealized Base" :=
                                      ROUND(
                                        WHTEntry."Remaining Unrealized Base" -
                                        ROUND(
                                          (PaymentAmount1 * (WHTEntry."Unrealized Base" + TempRemAmt)) /
                                          ExpectedAmount));

                                    WHTEntry3."Remaining Unrealized Amount" :=
                                      ROUND(
                                        WHTEntry."Remaining Unrealized Amount" -
                                        ROUND(
                                          (PaymentAmount1 * (WHTEntry."Unrealized Amount" + TempRemBase)) /
                                          ExpectedAmount));
                                end;
                                PaymentAmount := PaymentAmount + AppldAmount;
                            end;
                        Source::Customer:
                            begin
                                SalesCrMemoHeader.SETRANGE("Applies-to Doc. No.", GenJnlLine."Applies-to Doc. No.");
                                SalesCrMemoHeader.SETRANGE("Applies-to Doc. Type", SalesCrMemoHeader."Applies-to Doc. Type"::Invoice);
                                if SalesCrMemoHeader.FINDFIRST() then begin
                                    TempRemAmt := 0;
                                    CustLedgEntry1.RESET();
                                    CustLedgEntry1.SETRANGE("Document Type", CustLedgEntry1."Document Type"::"Credit Memo");
                                    CustLedgEntry1.SETRANGE("Document No.", SalesCrMemoHeader."No.");
                                    if CustLedgEntry1.FINDFIRST() then
                                        CustLedgEntry1.CALCFIELDS(Amount, "Remaining Amount");
                                    WHTEntryTemp.RESET();
                                    WHTEntryTemp.SETRANGE("Document No.", SalesCrMemoHeader."No.");
                                    WHTEntryTemp.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");
                                    WHTEntryTemp.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Sale);
                                    WHTEntryTemp.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                    WHTEntryTemp.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                    if WHTEntryTemp.FINDFIRST() then begin
                                        TempRemBase := WHTEntryTemp."Unrealized Amount";
                                        TempRemAmt := WHTEntryTemp."Unrealized Base";
                                    end;
                                end;

                                CustLedgEntry.RESET();
                                CustLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                                CustLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                                if CustLedgEntry.FINDFIRST() then
                                    CustLedgEntry.CALCFIELDS(Amount, "Remaining Amount");
                                if CustLedgEntry1."Amount (LCY)" = 0 then
                                    CustLedgEntry1."Rem. Amt for WHT FND" := 0;

                                ExpectedAmount := -(CustLedgEntry.Amount + CustLedgEntry1.Amount);
                                if (GenJnlLine."Posting Date" <= CustLedgEntry."Pmt. Discount Date") and
                                   (ABS(PaymentAmount1) >=
                                    (ABS(CustLedgEntry."Rem. Amt for WHT FND" + CustLedgEntry1."Rem. Amt for WHT FND") -
                                     ABS(CustLedgEntry."Original Pmt. Disc. Possible")))
                                then begin
                                    PmtDiscToBeDeducted := CustLedgEntry."Original Pmt. Disc. Possible" *
                                      (PaymentAmount1 / (ExpectedAmount + CustLedgEntry."Original Pmt. Disc. Possible"));
                                    AppldAmount :=
                                      ROUND(
                                        ((PaymentAmount1 - PmtDiscToBeDeducted) *
                                         (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount);
                                    WHTEntry3."Remaining Unrealized Base" :=
                                      ROUND(
                                        WHTEntry."Remaining Unrealized Base" -
                                        ROUND(
                                          ((PaymentAmount1 - PmtDiscToBeDeducted) *
                                           (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount));
                                    WHTEntry3."Remaining Unrealized Amount" :=
                                      ROUND(
                                        WHTEntry."Remaining Unrealized Amount" -
                                        ROUND(
                                          ((PaymentAmount1 - PmtDiscToBeDeducted) *
                                           (WHTEntry."Unrealized Amount" + TempRemBase)) / ExpectedAmount));
                                end else begin
                                    AppldAmount :=
                                      ROUND(
                                        (PaymentAmount1 * (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount);
                                    GLSetup.GET();
                                    if GLSetup."Manual Sales WHT Calc. FND" and GenJnlLine."WHT Payment FND" then begin
                                        if ABS(PaymentAmount1) > ABS(WHTEntry."Unrealized Amount") then begin
                                            WHTEntry3."Remaining Unrealized Base" := 0;
                                            WHTEntry3."Remaining Unrealized Amount" := 0;
                                            WHTEntry3."Rem Unrealized Base (LCY)" := 0;
                                            WHTEntry3."Rem Unrealized Amount (LCY)" := 0;
                                        end;
                                    end else begin
                                        WHTEntry3."Remaining Unrealized Base" :=
                                          ROUND(
                                            WHTEntry."Remaining Unrealized Base" -
                                            ROUND(
                                              (PaymentAmount1 * (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount));

                                        WHTEntry3."Remaining Unrealized Amount" :=
                                          ROUND(
                                            WHTEntry."Remaining Unrealized Amount" -
                                            ROUND(
                                              (PaymentAmount1 * (WHTEntry."Unrealized Amount" + TempRemBase)) / ExpectedAmount));
                                    end;
                                end;
                                PaymentAmount := PaymentAmount + AppldAmount;
                            end;
                    end;
                    if (WHTEntry."Remaining Unrealized Base" = 0) and
                       (WHTEntry."Remaining Unrealized Amount" = 0)
                    then
                        WHTEntry3.Closed := true;

                    if GenJnlLine."Source Currency Code" <> WHTEntry."Currency Code" then
                        ERROR(Text1500000);

                    GLSetup.GET();
                    if GLSetup."Manual Sales WHT Calc. FND" and not GenJnlLine."WHT Payment FND" then
                        AppldAmount := 0;
                    if AppldAmount = 0 then
                        exit(WHTEntry2."Entry No.");

                    WHTEntry2.INIT();
                    WHTEntry2."Posting Date" := GenJnlLine."Document Date";
                    WHTEntry2."Entry No." := NextEntryNo();
                    WHTEntry2."Document Date" := WHTEntry."Document Date";
                    WHTEntry2."Document Type" := GenJnlLine."Document Type";
                    WHTEntry2."Document No." := WHTEntry."Document No.";
                    WHTEntry2."Gen. Bus. Posting Group" := WHTEntry."Gen. Bus. Posting Group";
                    WHTEntry2."Gen. Prod. Posting Group" := WHTEntry."Gen. Prod. Posting Group";
                    WHTEntry2."Bill-to/Pay-to No." := WHTEntry."Bill-to/Pay-to No.";
                    WHTEntry2."WHT Bus. Posting Group" := WHTEntry."WHT Bus. Posting Group";
                    WHTEntry2."WHT Prod. Posting Group" := WHTEntry."WHT Prod. Posting Group";
                    WHTEntry2."WHT Revenue Type" := WHTEntry."WHT Revenue Type";
                    WHTEntry2."Unrealized WHT Entry No." := WHTEntry."Entry No.";
                    WHTEntry2."Currency Code" := GenJnlLine."Source Currency Code";
                    WHTEntry2."Applies-to Entry No." := WHTEntry."Entry No.";
                    WHTEntry2."User ID" := USERID;
                    WHTEntry2."External Document No." := GenJnlLine."External Document No.";
                    WHTEntry2."Actual Vendor No." := GenJnlLine."Actual Vendor No. FND";
                    WHTEntry2."Original Document No." := GenJnlLine."Document No.";
                    WHTEntry2."Source Code" := GenJnlLine."Source Code";
                    WHTEntry2."Transaction No." := TransactionNo;
                    WHTEntry2."WHT %" := WHTEntry."WHT %";
                    case Source of
                        Source::Vendor:
                            begin
                                WHTEntry2.Base := ROUND(AppldAmount);
                                WHTEntry2.Amount := ROUND(WHTEntry2.Base * WHTEntry2."WHT %" / 100);
                                WHTEntry2."Transaction Type" := WHTEntry2."Transaction Type"::Purchase;
                                WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                WHTEntry2."WHT Report" := WHTPostingSetup."WHT Report";
                                if GenJnlLine."Certificate Printed FND" then begin
                                    WHTEntry2."WHT Report Line No" := GenJnlLine."WHT Report Line No. FND";
                                    TempWHT.SETRANGE("Document No.", WHTEntry2."Document No.");
                                    if TempWHT.FINDFIRST() then
                                        WHTEntry2."WHT Certificate No." := TempWHT."WHT Certificate No.";
                                end else begin
                                    if ((Source = Source::Vendor) and
                                        (WHTEntry."Document Type" = WHTEntry."Document Type"::Invoice)) or
                                       ((Source = Source::Customer) and
                                        (WHTEntry."Document Type" = WHTEntry."Document Type"::"Credit Memo"))
                                    then
                                        if (WHTReportLineNo = '') and (WHTEntry2.Amount <> 0) and
                                           (WHTPostingSetup."WHT Report Line No. Series" <> '')
                                        then
                                            WHTReportLineNo :=
                                              NoSeriesMgt.GetNextNo(
                                                WHTPostingSetup."WHT Report Line No. Series", WHTEntry2."Posting Date", true);

                                    WHTEntry2."WHT Report Line No" := WHTReportLineNo;
                                end;
                            end;
                        Source::Customer:
                            begin
                                GLSetup.GET();
                                if GLSetup."Manual Sales WHT Calc. FND" and GenJnlLine."WHT Payment FND" then begin
                                    WHTEntry2.Amount := GenJnlLine.Amount;
                                    WHTEntry2.Base := ROUND((WHTEntry2.Amount * 100) / WHTEntry2."WHT %");
                                    WHTEntry2."Transaction Type" := WHTEntry2."Transaction Type"::Sale;
                                end else begin
                                    WHTEntry2.Base := ROUND(AppldAmount);
                                    WHTEntry2.Amount := ROUND(WHTEntry2.Base * WHTEntry2."WHT %" / 100);
                                    WHTEntry2."Transaction Type" := WHTEntry2."Transaction Type"::Sale;
                                end;
                            end;
                    end;

                    WHTEntry2."Payment Amount" := PaymentAmount1;
                    if WHTEntry2."Currency Code" <> '' then begin
                        CurrFactor :=
                          CurrExchRate.ExchangeRate(
                            WHTEntry2."Posting Date", WHTEntry2."Currency Code");

                        WHTEntry2."Base (LCY)" :=
                          ROUND(
                            CurrExchRate.ExchangeAmtFCYToLCY(
                              GenJnlLine."Document Date",
                              WHTEntry2."Currency Code",
                              WHTEntry2.Base, CurrFactor));

                        WHTEntry2."Amount (LCY)" :=
                          ROUND(
                            CurrExchRate.ExchangeAmtFCYToLCY(
                              GenJnlLine."Document Date",
                              WHTEntry2."Currency Code",
                              WHTEntry2.Amount, CurrFactor));
                    end else begin
                        WHTEntry2."Amount (LCY)" := WHTEntry2.Amount;
                        WHTEntry2."Base (LCY)" := WHTEntry2.Base;
                    end;

                    //HEI.06>>
                    gWHTPostingSetup.RESET();
                    if gWHTPostingSetup.GET(WHTEntry2."WHT Bus. Posting Group", WHTEntry2."WHT Prod. Posting Group") then
                        WHTEntry2."WHT Bearer" := gWHTPostingSetup."WHT Bearer";
                    //HEI.06<<
                    WHTEntry2.INSERT();
                    TType := TType::Purchase;
                    WHTEntry3.MODIFY();

                    WHTEntry3.RESET();
                    WHTEntry3.SETCURRENTKEY("Applies-to Entry No.");
                    WHTEntry3.SETRANGE("Applies-to Entry No.", WHTEntry."Entry No.");
                    WHTEntry3.CALCSUMS(Amount, "Amount (LCY)");
                    if (ABS(ABS(WHTEntry3.Amount) - ABS(WHTEntry."Unrealized Amount")) < 0.1) and
                       (ABS(ABS(WHTEntry3.Amount) - ABS(WHTEntry."Unrealized Amount")) > 0)
                    then begin
                        WHTEntry2."WHT Difference" := WHTEntry."Unrealized Amount" - WHTEntry3.Amount;
                        WHTEntry2.Amount := WHTEntry2.Amount - WHTEntry2."WHT Difference";
                        WHTEntry2.MODIFY();
                    end;

                    if (ABS(ABS(WHTEntry3."Amount (LCY)") -
                          ABS(WHTEntry."Unrealized Amount (LCY)")) < 0.1) and
                       (ABS(ABS(WHTEntry3."Amount (LCY)") - ABS(WHTEntry."Unrealized Amount (LCY)")) > 0)
                    then begin
                        WHTEntry2."Amount (LCY)" := WHTEntry2."Amount (LCY)" -
                          WHTEntry."Unrealized Amount (LCY)" + WHTEntry3."Amount (LCY)";
                        WHTEntry2.MODIFY();
                    end;
                end;
            until (WHTEntry.NEXT() = 0);

        if (WHTPostingSetup."Realized WHT Type" =
            WHTPostingSetup."Realized WHT Type"::Payment)
        then
            exit(WHTEntry2."Entry No." + 1);
    end;

    procedure CheckPmtDisc(PostingDate: Date; PmtDiscDate: Date; Amount1: Decimal; Amount2: Decimal; Amount3: Decimal; Amount4: Decimal): Boolean;
    begin
        if (PostingDate <= PmtDiscDate) and
           (Amount1 >= (Amount2 - Amount3)) and
           (Amount4 >= (Amount2 - Amount3))
        then
            exit(true);

        exit(false);
    end;

    procedure PreprintingWHT(var GenJournalLine: Record "Gen. Journal Line");
    var
        PurchSetup: Record "Purchases & Payables Setup";
        TempWHTEntry: Record "Temp WHT Entry FND";
        VendLedgEntry: Record "Vendor Ledger Entry";
        WHTEntry: Record "WHT Entry FND";
        WHTExists: Boolean;
        NoS: Code[10];
    begin
        if GenJournalLine."Certificate Printed FND" then
            ERROR(Text1500001);
        if GenJournalLine."Document Type" <> GenJournalLine."Document Type"::Payment then
            exit;
        if GenJournalLine."Skip WHT FND" then
            exit;
        PurchSetup.GET();
        if GenJournalLine."Applies-to Doc. No." <> '' then begin
            WHTEntry.RESET();
            WHTEntry.SETCURRENTKEY("Transaction Type", "Document No.", "Document Type", "Bill-to/Pay-to No.");
            if GenJournalLine."Applies-to Doc. Type" = GenJournalLine."Applies-to Doc. Type"::Invoice then
                WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::Invoice);
            if GenJournalLine."Applies-to Doc. Type" = GenJournalLine."Applies-to Doc. Type"::"Credit Memo" then
                WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");
            WHTEntry.SETRANGE("Document No.", GenJournalLine."Applies-to Doc. No.");
            if WHTEntry.FINDFIRST() then begin
                WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                WHTPostingSetup.TESTFIELD("WHT Report Line No. Series");
                GenJournalLine."WHT Report Line No. FND" :=
                  NoSeriesMgt.GetNextNo(
                    WHTPostingSetup."WHT Report Line No. Series", GenJournalLine."Posting Date", true);
            end;
        end else begin
            VendLedgEntry.RESET();
            VendLedgEntry.SETRANGE("Applies-to ID", GenJournalLine."Document No.");
            if VendLedgEntry.findset() then
                repeat
                    WHTEntry.RESET();
                    WHTEntry.SETCURRENTKEY("Transaction Type", "Document No.", "Document Type", "Bill-to/Pay-to No.");
                    if VendLedgEntry."Document Type" = VendLedgEntry."Document Type"::Invoice then
                        WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::Invoice);
                    if VendLedgEntry."Document Type" = VendLedgEntry."Document Type"::"Credit Memo" then
                        WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");
                    WHTEntry.SETRANGE("Document No.", VendLedgEntry."Document No.");
                    if not WHTExists then
                        if WHTEntry.FINDFIRST() then begin
                            WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                            WHTPostingSetup.TESTFIELD("WHT Report Line No. Series");
                            NoS := WHTPostingSetup."WHT Report Line No. Series";
                            WHTExists := true;
                        end;
                until VendLedgEntry.NEXT() = 0;
            if NoS <> '' then
                GenJournalLine."WHT Report Line No. FND" :=
                  NoSeriesMgt.GetNextNo(NoS, GenJournalLine."Posting Date", true);
        end;

        ApplyTempVendInvoiceWHT(GenJournalLine);
        TempWHTEntry.RESET();
        TempWHTEntry.SETCURRENTKEY("Bill-to/Pay-to No.", "Original Document No.", "WHT Revenue Type");
        TempWHTEntry.SETRANGE("Original Document No.", GenJournalLine."Document No.");
        // BC Upgrade NANDIS03 >>
        // if TempWHTEntry.FINDFIRST then
        //     if TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::Payment then
        //         REPORT.RUN(REPORT::Report14304, PurchSetup."Print Dialog", false, TempWHTEntry);  
        // BC Upgrade NANDIS03 << - Blocked as Report14304 is not found
        GenJournalLine."Certificate Printed FND" := true;
        GenJournalLine.MODIFY();
    end;

    procedure CheckApplicationSalesWHT(var SalesHeader: Record "Sales Header");
    var
        TempCustLedgEntry: Record "Cust. Ledger Entry";
        SalesLine1: Record "Sales Line";
        WHTEntry: Record "WHT Entry FND";
    begin
        if SalesHeader."Applies-to Doc. No." <> '' then
            TempCustLedgEntry.SETRANGE("Document No.", SalesHeader."Applies-to Doc. No.")
        else
            TempCustLedgEntry.SETRANGE("Applies-to ID", SalesHeader."Applies-to ID");

        if TempCustLedgEntry.findset() then
            repeat
                WHTEntry.RESET();
                WHTEntry.SETRANGE("Document No.", TempCustLedgEntry."Document No.");
                WHTEntry.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Sale);
                if WHTEntry.findset() then
                    repeat
                        SalesLine1.RESET();
                        SalesLine1.SETRANGE("Document No.", SalesHeader."No.");
                        SalesLine1.SETRANGE("Document Type", SalesHeader."Document Type");
                        SalesLine1.SETRANGE("WHT Business Posting Group FND", WHTEntry."WHT Bus. Posting Group");
                        SalesLine1.SETRANGE("WHT Product Posting Group FND", WHTEntry."WHT Prod. Posting Group");
                        if not SalesLine1.FINDFIRST() then
                            ERROR(Text1500003);
                    until WHTEntry.NEXT() = 0;
            until TempCustLedgEntry.NEXT() = 0;
    end;

    procedure CheckApplicationPurchWHT(var PurchHeader: Record "Purchase Header");
    var
        PurchLine1: Record "Purchase Line";
        TempVendLedgEntry: Record "Vendor Ledger Entry";
        WHTEntry: Record "WHT Entry FND";
    begin
        if PurchHeader."Applies-to Doc. No." <> '' then
            TempVendLedgEntry.SETRANGE("Document No.", PurchHeader."Applies-to Doc. No.")
        else
            TempVendLedgEntry.SETRANGE("Applies-to ID", PurchHeader."Applies-to ID");

        if TempVendLedgEntry.findset() then
            repeat
                WHTEntry.RESET();
                WHTEntry.SETRANGE("Document No.", TempVendLedgEntry."Document No.");
                WHTEntry.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
                if WHTEntry.findset() then
                    repeat
                        PurchLine1.RESET();
                        PurchLine1.SETRANGE("Document No.", PurchHeader."No.");
                        PurchLine1.SETRANGE("Document Type", PurchHeader."Document Type");
                        PurchLine1.SETRANGE("WHT Business Posting Group FND", WHTEntry."WHT Bus. Posting Group");
                        PurchLine1.SETRANGE("WHT Product Posting Group FND", WHTEntry."WHT Prod. Posting Group");
                        if not PurchLine1.FINDFIRST() then
                            ERROR(Text1500003);
                    until WHTEntry.NEXT() = 0;
            until TempVendLedgEntry.NEXT() = 0;
    end;

    procedure CheckApplicationGenSalesWHT(var GenJnlLine: Record "Gen. Journal Line");
    var
        TempCustLedgEntry: Record "Cust. Ledger Entry";
        WHTEntry: Record "WHT Entry FND";
    begin
        if (GenJnlLine."Applies-to Doc. No." <> '') or
           (GenJnlLine."Applies-to ID" <> '')
        then begin
            TempCustLedgEntry.RESET();
            if GenJnlLine."Applies-to Doc. No." <> '' then
                TempCustLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.")
            else
                TempCustLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
            if TempCustLedgEntry.findset() then
                repeat
                    WHTEntry.RESET();
                    WHTEntry.SETRANGE("Document No.", TempCustLedgEntry."Document No.");
                    WHTEntry.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Sale);
                    if WHTEntry.findset() then
                        repeat
                            GenJnlLine.SETRANGE("WHT Business Posting Group FND", WHTEntry."WHT Bus. Posting Group");
                            GenJnlLine.SETRANGE("WHT Product Posting Group FND", WHTEntry."WHT Prod. Posting Group");
                            if not GenJnlLine.FINDFIRST() then
                                ERROR(Text1500003);
                        until WHTEntry.NEXT() = 0;
                until TempCustLedgEntry.NEXT() = 0;
        end;
    end;

    procedure CheckApplicationGenPurchWHT(var GenJnlLine: Record "Gen. Journal Line");
    var
        TempVendLedgEntry: Record "Vendor Ledger Entry";
        WHTEntry: Record "WHT Entry FND";
    begin
        if (GenJnlLine."Applies-to Doc. No." <> '') or
           (GenJnlLine."Applies-to ID" <> '')
        then begin
            TempVendLedgEntry.RESET();
            if GenJnlLine."Applies-to Doc. No." <> '' then
                TempVendLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.")
            else
                TempVendLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
            if TempVendLedgEntry.findset() then
                repeat
                    WHTEntry.RESET();
                    WHTEntry.SETRANGE("Document No.", TempVendLedgEntry."Document No.");
                    WHTEntry.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
                    if WHTEntry.findset() then
                        repeat
                            GenJnlLine.SETRANGE("WHT Business Posting Group FND", WHTEntry."WHT Bus. Posting Group");
                            GenJnlLine.SETRANGE("WHT Product Posting Group FND", WHTEntry."WHT Prod. Posting Group");
                            if not GenJnlLine.FINDFIRST() then
                                ERROR(Text1500003);
                        until WHTEntry.NEXT() = 0;
                until TempVendLedgEntry.NEXT() = 0;
        end;
    end;

    procedure CalcVendExtraWHTForEarliest(var GenJnlLine: Record "Gen. Journal Line") WHTAmount: Decimal;
    var
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        VendLedgEntry: Record "Vendor Ledger Entry";
        VendLedgEntry1: Record "Vendor Ledger Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        WHTEntry: Record "WHT Entry FND";
        WHTEntry3: Record "WHT Entry FND";
        WHTEntryTemp: Record "WHT Entry FND";
        AppldAmount: Decimal;
        Diff: Decimal;
        ExpectedAmount: Decimal;
        PaymentAmount1: Decimal;
        RemainingAmt: Decimal;
        TotalWHTAmount: Decimal;
        TotalWHTAmount2: Decimal;
        TotalWHTAmount3: Decimal;
        TotalWHTBase: Decimal;
        WHTBase: Decimal;
    begin
        GLSetup.GET();

        WHTAmount := 0;
        TotalWHTBase := 0;
        WHTBase := 0;
        if WHTPostingSetup.GET(
             GenJnlLine."WHT Business Posting Group FND",
             GenJnlLine."WHT Product Posting Group FND")
        then begin
            if (WHTPostingSetup."Realized WHT Type" =
                WHTPostingSetup."Realized WHT Type"::Earliest)
            then begin
                if GenJnlLine."WHT Absorb Base FND" <> 0 then
                    WHTBase := ABS(GenJnlLine."WHT Absorb Base FND")
                else
                    WHTBase := ABS(GenJnlLine.Amount);
            end;
        end;
        TotalWHTBase := WHTBase;
        if GenJnlLine."Applies-to Doc. No." <> '' then begin
            VendorLedgerEntry.RESET();
            VendorLedgerEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
            if (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Payment) then
                VendorLedgerEntry.SETFILTER(
                  "Document Type",
                  '%1',
                  VendorLedgerEntry."Document Type"::Invoice);

            if (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Refund) then
                VendorLedgerEntry.SETFILTER(
                  "Document Type",
                  '%1',
                  VendorLedgerEntry."Document Type"::"Credit Memo");

            if (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Invoice) then
                VendorLedgerEntry.SETFILTER(
                  "Document Type",
                  '%1',
                  VendorLedgerEntry."Document Type"::Payment);

            if (GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Credit Memo") then
                VendorLedgerEntry.SETFILTER(
                  "Document Type",
                  '%1',
                  VendorLedgerEntry."Document Type"::Refund);

            if VendorLedgerEntry.FINDFIRST() then begin
                if GenJnlLine."Currency Code" <> VendorLedgerEntry."Currency Code" then
                    ERROR(Text1500000);

                if VendorLedgerEntry.Prepayment then begin
                    TotalWHTAmount := 0;
                    PaymentAmount1 := GenJnlLine.Amount;
                    WHTEntry.RESET();
                    WHTEntry.SETCURRENTKEY("Transaction Type", "Document No.", "Document Type", "Bill-to/Pay-to No.");
                    WHTEntry.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
                    if GenJnlLine."Applies-to Doc. No." <> '' then begin
                        WHTEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                        WHTEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                    end else
                        WHTEntry.SETRANGE("Bill-to/Pay-to No.", GenJnlLine."Account No.");
                    if WHTEntry.findset() then begin
                        repeat
                            PurchCrMemoHeader.SETRANGE(
                              "Applies-to Doc. Type",
                              PurchCrMemoHeader."Applies-to Doc. Type"::Invoice);
                            PurchCrMemoHeader.SETRANGE("Applies-to Doc. No.", GenJnlLine."Applies-to Doc. No.");
                            if PurchCrMemoHeader.FINDFIRST() then begin
                                TempRemAmt := 0;
                                VendLedgEntry1.SETRANGE("Document Type", VendLedgEntry1."Document Type"::"Credit Memo");
                                VendLedgEntry1.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                                if VendLedgEntry1.FINDFIRST() then
                                    VendLedgEntry1.CALCFIELDS(Amount, "Remaining Amount");
                                WHTEntryTemp.RESET();
                                WHTEntryTemp.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");
                                WHTEntryTemp.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
                                WHTEntryTemp.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                                WHTEntryTemp.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                WHTEntryTemp.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                if WHTEntryTemp.FINDFIRST() then
                                    TempRemAmt := WHTEntryTemp."Unrealized Base";
                            end;

                            VendLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                            VendLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                            if VendLedgEntry.FINDFIRST() then
                                VendLedgEntry.CALCFIELDS(Amount, "Remaining Amount");
                            ExpectedAmount := -(VendLedgEntry.Amount + VendLedgEntry1.Amount);
                            if (GenJnlLine."Posting Date" <= VendLedgEntry."Pmt. Discount Date") and
                               (ABS(PaymentAmount1) >= (ABS(VendLedgEntry."Remaining Amount" +
                                                          VendLedgEntry1."Remaining Amount") -
                                                        ABS(VendLedgEntry."Original Pmt. Disc. Possible")))
                            then
                                AppldAmount :=
                                  ROUND(
                                    ((PaymentAmount1 - VendLedgEntry."Original Pmt. Disc. Possible") *
                                     (WHTEntry."Unrealized Base" + TempRemAmt)) / ExpectedAmount)
                            else
                                AppldAmount :=
                                  ROUND(
                                    (PaymentAmount1 * (WHTEntry."Unrealized Base" + TempRemAmt)) /
                                    ExpectedAmount);
                            TotalWHTAmount := ROUND(TotalWHTAmount + AppldAmount * WHTEntry."WHT %" / 100);
                        until WHTEntry.NEXT() = 0;

                        WHTEntry3.RESET();
                        WHTEntry3.SETCURRENTKEY("Applies-to Entry No.");
                        WHTEntry3.SETRANGE("Applies-to Entry No.", WHTEntry."Entry No.");
                        WHTEntry3.CALCSUMS(Amount, "Amount (LCY)");
                        if (ABS(ABS(WHTEntry3.Amount) + ABS(TotalWHTAmount) - ABS(WHTEntry."Unrealized Amount")) < 0.1) and
                           (ABS(ABS(WHTEntry3.Amount) + ABS(TotalWHTAmount) - ABS(WHTEntry."Unrealized Amount")) > 0)
                        then begin
                            Diff := WHTEntry."Unrealized Amount" - (WHTEntry3.Amount + TotalWHTAmount);
                            TotalWHTAmount := TotalWHTAmount + Diff;
                        end;

                        exit(ROUND(TotalWHTAmount));
                    end
                end else begin
                    WHTEntry.RESET();
                    WHTEntry.SETRANGE("Document No.", VendorLedgerEntry."Document No.");
                    if WHTEntry.FINDFIRST() then
                        if WHTPostingSetup.GET(
                             WHTEntry."WHT Bus. Posting Group",
                             WHTEntry."WHT Prod. Posting Group")
                        then
                            if ((WHTPostingSetup."Realized WHT Type" =
                                 WHTPostingSetup."Realized WHT Type"::Earliest) and
                                (WHTEntry."WHT %" = WHTPostingSetup."WHT %"))
                            then begin
                                TotAmt := 0;
                                TotAmt := GenJnlLine.Amount;
                                TempVendLedgEntry.RESET();
                                TempVendLedgEntry.SETRANGE("Entry No.", VendorLedgerEntry."Entry No.");
                                if TempVendLedgEntry.findset() then begin
                                    TempVendLedgEntry.CALCFIELDS(
                                      Amount, "Amount (LCY)",
                                      "Remaining Amount", "Remaining Amt. (LCY)");

                                    if CheckPmtDisc(
                                         GenJnlLine."Posting Date",
                                         TempVendLedgEntry."Pmt. Discount Date",
                                         ABS(TempVendLedgEntry."Amount to Apply"),
                                         ABS(TempVendLedgEntry."Remaining Amount"),
                                         ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"),
                                         ABS(TotAmt))
                                    then
                                        TotAmt := TotAmt - TempVendLedgEntry."Original Pmt. Disc. Possible";

                                    if ABS(WHTEntry."Rem Realized Base") >= WHTBase then
                                        TotAmt := 0
                                    else
                                        TotAmt := TotAmt - ABS(WHTEntry."Rem Realized Base");
                                end;
                                WHTBase := TotAmt;
                            end;
                end;
            end;
        end else begin
            if GenJnlLine."Applies-to ID" <> '' then begin
                if ((GenJnlLine."Document Type" = GenJnlLine."Document Type"::Invoice) or
                    (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Refund))
                then begin
                    VendorLedgerEntry.RESET();
                    VendorLedgerEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                    VendorLedgerEntry.SETFILTER(
                      "Document Type",
                      '%1|%2',
                      VendorLedgerEntry."Document Type"::Payment,
                      VendorLedgerEntry."Document Type"::"Credit Memo");
                    if VendorLedgerEntry.findset() then
                        repeat
                            WHTEntry.RESET();
                            WHTEntry.SETRANGE("Document No.", VendorLedgerEntry."Document No.");
                            if WHTEntry.findset() then
                                repeat
                                    if WHTPostingSetup.GET(
                                         WHTEntry."WHT Bus. Posting Group",
                                         WHTEntry."WHT Prod. Posting Group")
                                    then
                                        if ((WHTPostingSetup."Realized WHT Type" =
                                             WHTPostingSetup."Realized WHT Type"::Earliest) and
                                            (WHTEntry."WHT %" = WHTPostingSetup."WHT %"))
                                        then begin
                                            if TotalWHTBase > ABS(WHTEntry."Rem Realized Base") then begin
                                                TotalWHTBase := TotalWHTBase - ABS(WHTEntry."Rem Realized Base");
                                                if (((GenJnlLine."Document Type" = GenJnlLine."Document Type"::Refund) and
                                                     (WHTEntry."Document Type" = WHTEntry."Document Type"::"Credit Memo")) or
                                                    ((GenJnlLine."Document Type" = GenJnlLine."Document Type"::Invoice) and
                                                     (WHTEntry."Document Type" = WHTEntry."Document Type"::Payment)))
                                                then
                                                    WHTBase := WHTBase - ABS(WHTEntry."Rem Realized Base");
                                            end else begin
                                                if (TotalWHTBase > 0) and (ABS(TotalWHTBase) <= ABS(WHTEntry."Rem Realized Base")) then
                                                    TotalWHTBase := TotalWHTBase - TotalWHTBase;
                                                if (((GenJnlLine."Document Type" = GenJnlLine."Document Type"::Refund) and
                                                     (WHTEntry."Document Type" = WHTEntry."Document Type"::"Credit Memo")) or
                                                    ((GenJnlLine."Document Type" = GenJnlLine."Document Type"::Invoice) and
                                                     (WHTEntry."Document Type" = WHTEntry."Document Type"::Payment)))
                                                then
                                                    WHTBase := 0;
                                            end;
                                        end;
                                until WHTEntry.NEXT() = 0;
                        until VendorLedgerEntry.NEXT() = 0;
                end;

                if ((GenJnlLine."Document Type" = GenJnlLine."Document Type"::Payment) or
                    (GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Credit Memo"))
                then begin
                    TotalWHTAmount := 0;
                    TotalWHTAmount2 := 0;
                    TotalWHTAmount3 := 0;
                    RemainingAmt := 0;
                    TotAmt := 0;
                    TempVendLedgEntry1.RESET();
                    TempVendLedgEntry1.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                    TempVendLedgEntry1.SETRANGE(Open, true);
                    if GenJnlLine."Bill-to/Pay-to No." = '' then
                        TempVendLedgEntry1.SETRANGE("Buy-from Vendor No.", GenJnlLine."Account No.")
                    else
                        TempVendLedgEntry1.SETRANGE("Buy-from Vendor No.", GenJnlLine."Bill-to/Pay-to No.");

                    if TempVendLedgEntry1.findset() then
                        repeat
                            TempVendLedgEntry1.CALCFIELDS(
                              Amount, "Amount (LCY)",
                              "Remaining Amount", "Remaining Amt. (LCY)");

                            RemainingAmt := RemainingAmt + TempVendLedgEntry1."Remaining Amt. (LCY)";
                        until TempVendLedgEntry1.NEXT() = 0;

                    TotAmt := ABS(GenJnlLine."Amount (LCY)");
                    CurrFactor :=
                      CurrExchRate.ExchangeRate(
                        GenJnlLine."Document Date", GenJnlLine."Currency Code");

                    VendorLedgerEntry.RESET();
                    VendorLedgerEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                    VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Refund);
                    if VendorLedgerEntry.findset() then
                        repeat
                            WHTEntry.RESET();
                            WHTEntry.SETRANGE("Document No.", VendorLedgerEntry."Document No.");
                            if WHTEntry.findset() then
                                repeat
                                    if WHTPostingSetup.GET(
                                         WHTEntry."WHT Bus. Posting Group",
                                         WHTEntry."WHT Prod. Posting Group")
                                    then
                                        if ((WHTPostingSetup."Realized WHT Type" =
                                             WHTPostingSetup."Realized WHT Type"::Earliest) and
                                            (WHTEntry."WHT %" = WHTPostingSetup."WHT %"))
                                        then begin
                                            if TotalWHTBase > ABS(WHTEntry."Rem Realized Base") then begin
                                                TotalWHTBase := TotalWHTBase - ABS(WHTEntry."Rem Realized Base");
                                                if GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Credit Memo" then
                                                    WHTBase := WHTBase - ABS(WHTEntry."Rem Realized Base");
                                            end else begin
                                                if (TotalWHTBase > 0) and (ABS(TotalWHTBase) <= ABS(WHTEntry."Rem Realized Base")) then begin
                                                    TotalWHTBase := 0;
                                                    if GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Credit Memo" then
                                                        WHTBase := 0;
                                                end;
                                            end;
                                        end;
                                until WHTEntry.NEXT() = 0;
                        until VendorLedgerEntry.NEXT() = 0;

                    VendorLedgerEntry.RESET();
                    VendorLedgerEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                    VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Invoice);
                    if VendorLedgerEntry.findset() then begin
                        repeat
                            if GenJnlLine."Currency Code" <> VendorLedgerEntry."Currency Code" then
                                ERROR(Text1500000);

                            if VendorLedgerEntry.Prepayment then begin
                                TempVendLedgEntry.RESET();
                                TempVendLedgEntry.SETRANGE("Entry No.", VendorLedgerEntry."Entry No.");
                                if TempVendLedgEntry.findset() then begin
                                    TempVendLedgEntry.CALCFIELDS(
                                      Amount, "Amount (LCY)",
                                      "Remaining Amount", "Remaining Amt. (LCY)");

                                    if CheckPmtDisc(
                                         GenJnlLine."Posting Date",
                                         TempVendLedgEntry."Pmt. Discount Date",
                                         CurrExchRate.ExchangeAmtFCYToLCY(
                                           GenJnlLine."Document Date",
                                           GenJnlLine."Currency Code",
                                           ABS(TempVendLedgEntry."Amount to Apply"), CurrFactor),
                                         ABS(TempVendLedgEntry."Remaining Amt. (LCY)"),
                                         CurrExchRate.ExchangeAmtFCYToLCY(
                                           GenJnlLine."Document Date",
                                           GenJnlLine."Currency Code",
                                           ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"), CurrFactor),
                                         ABS(TotAmt))
                                    then
                                        TotAmt := TotAmt -
                                          CurrExchRate.ExchangeAmtFCYToLCY(
                                            GenJnlLine."Document Date",
                                            GenJnlLine."Currency Code",
                                            TempVendLedgEntry."Original Pmt. Disc. Possible", CurrFactor);

                                    if (ABS(RemainingAmt) < ABS(TotAmt)) or
                                       (ABS(TempVendLedgEntry."Remaining Amt. (LCY)") < ABS(TotAmt))
                                    then begin
                                        if CheckPmtDisc(
                                             GenJnlLine."Posting Date",
                                             TempVendLedgEntry."Pmt. Discount Date",
                                             CurrExchRate.ExchangeAmtFCYToLCY(
                                               GenJnlLine."Document Date",
                                               GenJnlLine."Currency Code",
                                               ABS(TempVendLedgEntry."Amount to Apply"), CurrFactor),
                                             ABS(TempVendLedgEntry."Remaining Amt. (LCY)"),
                                             CurrExchRate.ExchangeAmtFCYToLCY(
                                               GenJnlLine."Document Date",
                                               GenJnlLine."Currency Code",
                                               ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"), CurrFactor),
                                             ABS(TotAmt))
                                        then begin
                                            GenJnlLine.VALIDATE(
                                              Amount,
                                              ABS(TempVendLedgEntry."Remaining Amt. (LCY)" -
                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                  GenJnlLine."Document Date",
                                                  GenJnlLine."Currency Code",
                                                  TempVendLedgEntry."Original Pmt. Disc. Possible", CurrFactor)));

                                            if TempVendLedgEntry."Document Type" <>
                                               TempVendLedgEntry."Document Type"::"Credit Memo"
                                            then
                                                TotAmt := TotAmt + TempVendLedgEntry."Remaining Amt. (LCY)";

                                            RemainingAmt :=
                                              RemainingAmt -
                                              TempVendLedgEntry."Remaining Amt. (LCY)";
                                        end else begin
                                            GenJnlLine.VALIDATE(Amount, ABS(TempVendLedgEntry."Remaining Amt. (LCY)"));
                                            if TempVendLedgEntry."Document Type" <>
                                               TempVendLedgEntry."Document Type"::"Credit Memo"
                                            then
                                                TotAmt := TotAmt + TempVendLedgEntry."Remaining Amt. (LCY)";
                                            RemainingAmt := RemainingAmt - TempVendLedgEntry."Remaining Amt. (LCY)";
                                        end;
                                    end else begin
                                        if CheckPmtDisc(
                                             GenJnlLine."Posting Date",
                                             TempVendLedgEntry."Pmt. Discount Date",
                                             CurrExchRate.ExchangeAmtFCYToLCY(
                                               GenJnlLine."Document Date",
                                               GenJnlLine."Currency Code",
                                               ABS(TempVendLedgEntry."Amount to Apply"), CurrFactor),
                                             ABS(TempVendLedgEntry."Remaining Amt. (LCY)"),
                                             CurrExchRate.ExchangeAmtFCYToLCY(
                                               GenJnlLine."Document Date",
                                               GenJnlLine."Currency Code",
                                               ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"), CurrFactor),
                                             ABS(TotAmt))
                                        then
                                            GenJnlLine.VALIDATE(Amount, TotAmt +
                                              CurrExchRate.ExchangeAmtFCYToLCY(
                                                GenJnlLine."Document Date",
                                                GenJnlLine."Currency Code",
                                                TempVendLedgEntry."Original Pmt. Disc. Possible", CurrFactor))
                                        else
                                            GenJnlLine.VALIDATE(Amount, TotAmt);
                                        TotAmt := 0;
                                    end;

                                    if TempVendLedgEntry."Document Type" = TempVendLedgEntry."Document Type"::Invoice then
                                        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice
                                    else begin
                                        if TempVendLedgEntry."Document Type" = TempVendLedgEntry."Document Type"::"Credit Memo" then
                                            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::"Credit Memo";
                                        RemainingAmt := RemainingAmt + TempVendLedgEntry."Remaining Amt. (LCY)";
                                        TotAmt := TotAmt + TempVendLedgEntry."Remaining Amt. (LCY)";
                                    end;
                                    GenJnlLine."Applies-to Doc. No." := TempVendLedgEntry."Document No.";
                                    PaymentAmount1 := GenJnlLine.Amount;
                                    WHTEntry.RESET();
                                    WHTEntry.SETCURRENTKEY("Transaction Type", "Document No.", "Document Type", "Bill-to/Pay-to No.");
                                    WHTEntry.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
                                    if GenJnlLine."Applies-to Doc. No." <> '' then begin
                                        WHTEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                                        WHTEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                                    end else
                                        WHTEntry.SETRANGE("Bill-to/Pay-to No.", GenJnlLine."Account No.");
                                    if WHTEntry.findset() then
                                        repeat
                                            PurchCrMemoHeader.RESET();
                                            PurchCrMemoHeader.SETRANGE("Applies-to Doc. No.", GenJnlLine."Applies-to Doc. No.");
                                            PurchCrMemoHeader.SETRANGE("Applies-to Doc. Type", PurchCrMemoHeader."Applies-to Doc. Type"::Invoice);
                                            if PurchCrMemoHeader.FINDFIRST() then begin
                                                TempRemAmt := 0;
                                                VendLedgEntry1.SETRANGE("Document Type", VendLedgEntry1."Document Type"::"Credit Memo");
                                                VendLedgEntry1.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                                                if VendLedgEntry1.FINDFIRST() then
                                                    VendLedgEntry1.CALCFIELDS(Amount, "Remaining Amount",
                                                      "Amount (LCY)", "Remaining Amt. (LCY)");
                                                WHTEntryTemp.RESET();
                                                WHTEntryTemp.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");
                                                WHTEntryTemp.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
                                                WHTEntryTemp.SETRANGE("Document No.", PurchCrMemoHeader."No.");
                                                WHTEntryTemp.SETRANGE("WHT Bus. Posting Group", WHTEntry."WHT Bus. Posting Group");
                                                WHTEntryTemp.SETRANGE("WHT Prod. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                                if WHTEntryTemp.FINDFIRST() then begin
                                                    TempRemBase := WHTEntryTemp."Unrealized Amount";
                                                    TempRemAmt := WHTEntryTemp."Unrealized Base";
                                                end;
                                            end;

                                            VendLedgEntry.RESET();
                                            VendLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                                            if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::Invoice then
                                                VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::Invoice)
                                            else
                                                if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::"Credit Memo" then
                                                    VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::"Credit Memo");
                                            if VendLedgEntry.FINDFIRST() then
                                                VendLedgEntry.CALCFIELDS(Amount, "Remaining Amount",
                                                  "Amount (LCY)", "Remaining Amt. (LCY)");
                                            ExpectedAmount := -(VendLedgEntry.Amount + VendLedgEntry1.Amount);
                                            if (GenJnlLine."Posting Date" <= VendLedgEntry."Pmt. Discount Date") and
                                               (ABS(PaymentAmount1) >=
                                                (ABS(VendLedgEntry."Remaining Amt. (LCY)" + VendLedgEntry1."Remaining Amt. (LCY)") -
                                                 ABS(
                                                   CurrExchRate.ExchangeAmtFCYToLCY(
                                                     GenJnlLine."Document Date",
                                                     GenJnlLine."Currency Code",
                                                     TempVendLedgEntry."Original Pmt. Disc. Possible", CurrFactor))))
                                            then
                                                AppldAmount :=
                                                  ROUND(
                                                    ((PaymentAmount1 -
                                                      CurrExchRate.ExchangeAmtFCYToLCY(
                                                        GenJnlLine."Document Date",
                                                        GenJnlLine."Currency Code",
                                                        TempVendLedgEntry."Original Pmt. Disc. Possible", CurrFactor)) *
                                                     (WHTEntry."Unrealized Base" + TempRemAmt)) /
                                                    ExpectedAmount)
                                            else
                                                AppldAmount :=
                                                  ROUND(
                                                    (PaymentAmount1 *
                                                     (WHTEntry."Unrealized Base" + TempRemAmt)) /
                                                    ExpectedAmount);
                                            TotalWHTAmount := ROUND(TotalWHTAmount + AppldAmount * WHTEntry."WHT %" / 100);
                                            if GenJnlLine."Currency Code" <> '' then begin
                                                TotalWHTAmount2 :=
                                                  ROUND(
                                                    TotalWHTAmount2 +
                                                    ROUND(
                                                      CurrExchRate.ExchangeAmtLCYToFCY(
                                                        GenJnlLine."Document Date",
                                                        GenJnlLine."Currency Code",
                                                        AppldAmount * WHTEntry."WHT %" / 100,
                                                        CurrFactor)));
                                            end else
                                                TotalWHTAmount2 := TotalWHTAmount;

                                            WHTEntry3.RESET();
                                            WHTEntry3.SETCURRENTKEY("Applies-to Entry No.");
                                            WHTEntry3.SETRANGE("Applies-to Entry No.", WHTEntry."Entry No.");
                                            WHTEntry3.CALCSUMS(Amount, "Amount (LCY)");
                                            if (ABS(ABS(WHTEntry3.Amount) + ABS(TotalWHTAmount2) - ABS(WHTEntry."Unrealized Amount")) < 0.1) and
                                               (ABS(ABS(WHTEntry3.Amount) + ABS(TotalWHTAmount2) - ABS(WHTEntry."Unrealized Amount")) > 0)
                                            then begin
                                                Diff := WHTEntry."Unrealized Amount" - (WHTEntry3.Amount + TotalWHTAmount2);
                                                TotalWHTAmount2 := TotalWHTAmount2 + Diff;
                                            end;

                                        until WHTEntry.NEXT() = 0;
                                end;
                            end else begin
                                WHTEntry.RESET();
                                WHTEntry.SETRANGE("Document No.", VendorLedgerEntry."Document No.");
                                if WHTEntry.findset() then
                                    repeat
                                        if WHTPostingSetup.GET(
                                             WHTEntry."WHT Bus. Posting Group",
                                             WHTEntry."WHT Prod. Posting Group")
                                        then
                                            if ((WHTPostingSetup."Realized WHT Type" =
                                                 WHTPostingSetup."Realized WHT Type"::Earliest) and
                                                (WHTEntry."WHT %" = WHTPostingSetup."WHT %"))
                                            then begin
                                                TempVendLedgEntry.RESET();
                                                TempVendLedgEntry.SETRANGE("Entry No.", VendorLedgerEntry."Entry No.");
                                                if TempVendLedgEntry.findset() then begin
                                                    TempVendLedgEntry.CALCFIELDS(
                                                      Amount, "Amount (LCY)",
                                                      "Remaining Amount", "Remaining Amt. (LCY)");

                                                    if CheckPmtDisc(
                                                         GenJnlLine."Posting Date",
                                                         TempVendLedgEntry."Pmt. Discount Date",
                                                         CurrExchRate.ExchangeAmtFCYToLCY(
                                                           GenJnlLine."Document Date",
                                                           GenJnlLine."Currency Code",
                                                           ABS(TempVendLedgEntry."Amount to Apply"), CurrFactor),
                                                         ABS(TempVendLedgEntry."Remaining Amt. (LCY)"),
                                                         CurrExchRate.ExchangeAmtFCYToLCY(
                                                           GenJnlLine."Document Date",
                                                           GenJnlLine."Currency Code",
                                                           ABS(TempVendLedgEntry."Original Pmt. Disc. Possible"), CurrFactor),
                                                         ABS(TotAmt))
                                                    then
                                                        TotAmt := TotAmt -
                                                          CurrExchRate.ExchangeAmtFCYToLCY(
                                                            GenJnlLine."Document Date",
                                                            GenJnlLine."Currency Code",
                                                            TempVendLedgEntry."Original Pmt. Disc. Possible", CurrFactor);

                                                    if (ABS(RemainingAmt) < ABS(TotAmt)) or
                                                       (ABS(TempVendLedgEntry."Remaining Amt. (LCY)") < ABS(TotAmt))
                                                    then begin
                                                        if TempVendLedgEntry."Document Type" <>
                                                           TempVendLedgEntry."Document Type"::"Credit Memo"
                                                        then
                                                            TotAmt := TotAmt + TempVendLedgEntry."Remaining Amt. (LCY)";
                                                        RemainingAmt := RemainingAmt - TempVendLedgEntry."Remaining Amt. (LCY)";
                                                    end else
                                                        TotAmt := 0;
                                                end;
                                            end;
                                    until WHTEntry.NEXT() = 0;
                            end;
                        until VendorLedgerEntry.NEXT() = 0;
                        if TotAmt > 0 then begin
                            TotalWHTAmount3 := ROUND(TotalWHTAmount3 + TotAmt * WHTPostingSetup."WHT %" / 100);
                            if GenJnlLine."Currency Code" <> '' then
                                TotalWHTAmount2 :=
                                  ROUND(
                                    TotalWHTAmount2 +
                                    ROUND(
                                      CurrExchRate.ExchangeAmtLCYToFCY(
                                        GenJnlLine."Document Date",
                                        GenJnlLine."Currency Code",
                                        TotAmt * WHTPostingSetup."WHT %" / 100,
                                        CurrFactor)))
                            else
                                TotalWHTAmount2 := TotalWHTAmount2 + TotalWHTAmount3;
                        end else
                            WHTBase := 0;
                        if ROUND(TotalWHTAmount2) <> 0 then
                            exit(ROUND(TotalWHTAmount2));
                    end;
                end;
            end;
        end;

        WHTAmount := ROUND(WHTBase * WHTPostingSetup."WHT %" / 100);

        if WHTPostingSetup.GET(GenJnlLine."WHT Business Posting Group FND",
             GenJnlLine."WHT Product Posting Group FND")
        then
            if WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest then begin
                if WHTBase < WHTPostingSetup."WHT Minimum Invoice Amount" then
                    WHTAmount := 0;
            end;
    end;

    procedure CalcCustExtraWHTForEarliest(var GenJnlLine: Record "Gen. Journal Line") WHTAmount: Decimal;
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        WHTEntry: Record "WHT Entry FND";
        IsRefund: Boolean;
        TotalWHTBase: Decimal;
        WHTBase: Decimal;
    begin
        GLSetup.GET();
        WHTAmount := 0;
        TotalWHTBase := 0;
        WHTBase := 0;
        if WHTPostingSetup.GET(
             GenJnlLine."WHT Business Posting Group FND",
             GenJnlLine."WHT Product Posting Group FND")
        then begin
            if (WHTPostingSetup."Realized WHT Type" =
                WHTPostingSetup."Realized WHT Type"::Earliest)
            then begin
                if GenJnlLine."WHT Absorb Base FND" <> 0 then
                    WHTBase := ABS(GenJnlLine."WHT Absorb Base FND")
                else
                    WHTBase := ABS(GenJnlLine.Amount);
            end;
        end;
        TotalWHTBase := WHTBase;
        if GenJnlLine."Applies-to Doc. No." <> '' then begin
            CustLedgerEntry.RESET();
            CustLedgerEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
            if (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Payment) then
                CustLedgerEntry.SETFILTER(
                  "Document Type",
                  '%1',
                  CustLedgerEntry."Document Type"::Invoice);

            if (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Refund) then
                CustLedgerEntry.SETFILTER(
                  "Document Type",
                  '%1',
                  CustLedgerEntry."Document Type"::"Credit Memo");

            if (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Invoice) then
                CustLedgerEntry.SETFILTER(
                  "Document Type",
                  '%1',
                  CustLedgerEntry."Document Type"::Payment);

            if (GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Credit Memo") then
                CustLedgerEntry.SETFILTER(
                  "Document Type",
                  '%1',
                  CustLedgerEntry."Document Type"::Refund);

            if CustLedgerEntry.FINDFIRST() then
                if not CustLedgerEntry.Prepayment then begin
                    WHTEntry.RESET();
                    WHTEntry.SETRANGE("Document No.", CustLedgerEntry."Document No.");
                    if WHTEntry.FINDFIRST() then
                        if WHTPostingSetup.GET(
                             WHTEntry."WHT Bus. Posting Group",
                             WHTEntry."WHT Prod. Posting Group")
                        then
                            if ((WHTPostingSetup."Realized WHT Type" =
                                 WHTPostingSetup."Realized WHT Type"::Earliest) and
                                (WHTEntry."WHT %" = WHTPostingSetup."WHT %"))
                            then begin
                                if ABS(WHTEntry."Rem Realized Base") >= WHTBase then
                                    WHTBase := 0
                                else
                                    WHTBase := WHTBase - ABS(WHTEntry."Rem Realized Base");
                            end;
                end else
                    WHTBase := 0;
        end else begin
            if GenJnlLine."Applies-to ID" <> '' then begin
                if ((GenJnlLine."Document Type" = GenJnlLine."Document Type"::Invoice) or
                    (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Refund))
                then begin
                    CustLedgerEntry.RESET();
                    CustLedgerEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                    CustLedgerEntry.SETFILTER(
                      "Document Type",
                      '%1|%2',
                      CustLedgerEntry."Document Type"::Payment,
                      CustLedgerEntry."Document Type"::"Credit Memo");
                    if CustLedgerEntry.findset() then
                        repeat
                            WHTEntry.RESET();
                            WHTEntry.SETRANGE("Document No.", CustLedgerEntry."Document No.");
                            if WHTEntry.findset() then
                                repeat
                                    if WHTPostingSetup.GET(
                                         WHTEntry."WHT Bus. Posting Group",
                                         WHTEntry."WHT Prod. Posting Group")
                                    then
                                        if ((WHTPostingSetup."Realized WHT Type" =
                                             WHTPostingSetup."Realized WHT Type"::Earliest) and
                                            (WHTEntry."WHT %" = WHTPostingSetup."WHT %"))
                                        then begin
                                            if TotalWHTBase > ABS(WHTEntry."Rem Realized Base") then begin
                                                TotalWHTBase := TotalWHTBase - ABS(WHTEntry."Rem Realized Base");
                                                if (((GenJnlLine."Document Type" = GenJnlLine."Document Type"::Refund) and
                                                     (WHTEntry."Document Type" = WHTEntry."Document Type"::"Credit Memo")) or
                                                    ((GenJnlLine."Document Type" = GenJnlLine."Document Type"::Invoice) and
                                                     (WHTEntry."Document Type" = WHTEntry."Document Type"::Payment)))
                                                then
                                                    WHTBase := WHTBase - ABS(WHTEntry."Rem Realized Base");
                                            end else begin
                                                if (TotalWHTBase > 0) and (ABS(TotalWHTBase) <= ABS(WHTEntry."Rem Realized Base")) then
                                                    TotalWHTBase := TotalWHTBase - TotalWHTBase;
                                                if (((GenJnlLine."Document Type" = GenJnlLine."Document Type"::Refund) and
                                                     (WHTEntry."Document Type" = WHTEntry."Document Type"::"Credit Memo")) or
                                                    ((GenJnlLine."Document Type" = GenJnlLine."Document Type"::Invoice) and
                                                     (WHTEntry."Document Type" = WHTEntry."Document Type"::Payment)))
                                                then
                                                    WHTBase := 0;
                                            end;
                                        end;
                                until WHTEntry.NEXT() = 0;
                        until CustLedgerEntry.NEXT() = 0;
                end;

                if ((GenJnlLine."Document Type" = GenJnlLine."Document Type"::Payment) or
                    (GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Credit Memo"))
                then begin
                    IsRefund := false;
                    CustLedgerEntry.RESET();
                    CustLedgerEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                    CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Refund);
                    if CustLedgerEntry.findset() then
                        repeat
                            IsRefund := true;
                            WHTEntry.RESET();
                            WHTEntry.SETRANGE("Document No.", CustLedgerEntry."Document No.");
                            if WHTEntry.findset() then
                                repeat
                                    if WHTPostingSetup.GET(
                                         WHTEntry."WHT Bus. Posting Group",
                                         WHTEntry."WHT Prod. Posting Group")
                                    then
                                        if ((WHTPostingSetup."Realized WHT Type" =
                                             WHTPostingSetup."Realized WHT Type"::Earliest) and
                                            (WHTEntry."WHT %" = WHTPostingSetup."WHT %"))
                                        then begin
                                            if TotalWHTBase > ABS(WHTEntry."Rem Realized Base") then begin
                                                TotalWHTBase := TotalWHTBase - ABS(WHTEntry."Rem Realized Base");
                                                if GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Credit Memo" then
                                                    WHTBase := WHTBase - ABS(WHTEntry."Rem Realized Base");
                                            end else begin
                                                if (TotalWHTBase > 0) and (ABS(TotalWHTBase) <= ABS(WHTEntry."Rem Realized Base")) then begin
                                                    TotalWHTBase := 0;
                                                    if GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Credit Memo" then
                                                        WHTBase := 0;
                                                end;
                                            end;
                                        end;
                                until WHTEntry.NEXT() = 0;
                        until CustLedgerEntry.NEXT() = 0;

                    CustLedgerEntry.RESET();
                    CustLedgerEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                    CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                    CustLedgerEntry.SETRANGE(Prepayment, false);
                    if CustLedgerEntry.findset() then
                        repeat
                            WHTEntry.RESET();
                            WHTEntry.SETRANGE("Document No.", CustLedgerEntry."Document No.");
                            if WHTEntry.findset() then
                                repeat
                                    if WHTPostingSetup.GET(
                                         WHTEntry."WHT Bus. Posting Group",
                                         WHTEntry."WHT Prod. Posting Group")
                                    then
                                        if ((WHTPostingSetup."Realized WHT Type" =
                                             WHTPostingSetup."Realized WHT Type"::Earliest) and
                                            (WHTEntry."WHT %" = WHTPostingSetup."WHT %"))
                                        then begin
                                            if TotalWHTBase > ABS(WHTEntry."Rem Realized Base") then begin
                                                TotalWHTBase := TotalWHTBase - ABS(WHTEntry."Rem Realized Base");
                                                if GenJnlLine."Document Type" = GenJnlLine."Document Type"::Payment then
                                                    WHTBase := WHTBase - ABS(WHTEntry."Rem Realized Base");
                                            end else begin
                                                if (TotalWHTBase > 0) and (ABS(TotalWHTBase) <= ABS(WHTEntry."Rem Realized Base")) then begin
                                                    TotalWHTBase := 0;
                                                    if GenJnlLine."Document Type" = GenJnlLine."Document Type"::Payment then
                                                        WHTBase := 0;
                                                end;
                                            end;
                                        end;
                                until WHTEntry.NEXT() = 0;
                        until CustLedgerEntry.NEXT() = 0
                    else
                        if not IsRefund then
                            WHTBase := 0;
                end;
            end;
        end;

        WHTAmount := ROUND(WHTBase * WHTPostingSetup."WHT %" / 100);
    end;

    procedure InsertVendPrepaymentInvoiceWHT(var PurchInvHeader: Record "Purch. Inv. Header"; var PurchHeader: Record "Purchase Header");
    var
        PurchLine: Record "Purchase Line";
    begin
        GLSetup.GET();
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
        // with PurchInvHeader do begin
        //     PurchLine.RESET();
        //     PurchLine.SETCURRENTKEY("Document Type", "Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
        //     PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        //     PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        //     PurchLine.SETFILTER(Type, '<>%1', PurchLine.Type::" ");

        //     if PurchLine.findset() then
        //         repeat
        //             if (PurchLine."Prepmt. Line Amount" - PurchLine."Prepmt. Amt. Inv.") <> 0 then
        //                 if WHTPostingSetup.GET(PurchLine."WHT Business Posting Group FND", PurchLine."WHT Product Posting Group FND") then
        //                     if WHTPostingSetup."WHT %" > 0 then begin
        //                         DocNo := "No.";
        //                         DocType := DocType::Invoice;
        //                         PayToAccType := PayToAccType::Vendor;
        //                         PayToVendCustNo := "Pay-to Vendor No.";
        //                         BuyFromAccType := BuyFromAccType::Vendor;
        //                         GenBusPostGrp := PurchLine."Gen. Bus. Posting Group";
        //                         GenProdPostGrp := PurchLine."Gen. Prod. Posting Group";
        //                         TransType := TransType::Purchase;
        //                         BuyFromVendCustNo := "Actual Vendor No. FND";
        //                         PostingDate := "Posting Date";
        //                         DocDate := "Document Date";
        //                         CurrencyCode := "Currency Code";
        //                         CurrFactor := "Currency Factor";
        //                         ApplyDocType := "Applies-to Doc. Type";
        //                         ApplyDocNo := "Applies-to Doc. No.";
        //                         SourceCode := "Source Code";
        //                         ReasonCode := "Reason Code";

        //                         if (WHTBusPostGrp <> PurchLine."WHT Business Posting Group FND") or
        //                            (WHTProdPostGrp <> PurchLine."WHT Product Posting Group FND")
        //                         then begin
        //                             if AmountVAT <> 0 then
        //                                 InsertPrepaymentUnrealizedWHT(TType::Purchase);
        //                             WHTBusPostGrp := PurchLine."WHT Business Posting Group FND";
        //                             WHTProdPostGrp := PurchLine."WHT Product Posting Group FND";
        //                             Amount := 0;
        //                             AbsorbBase := 0;
        //                             AmountVAT := 0;
        //                             Amount := Amount + PurchLine."Prepayment Amount";
        //                             AbsorbBase := AbsorbBase + PurchLine."WHT Absorb Base FND";
        //                             if AbsorbBase <> 0 then
        //                                 AmountVAT := AbsorbBase
        //                             else
        //                                 AmountVAT := Amount;
        //                         end else begin
        //                             WHTBusPostGrp := PurchLine."WHT Business Posting Group FND";
        //                             WHTProdPostGrp := PurchLine."WHT Product Posting Group FND";
        //                             Amount := Amount + PurchLine."Prepayment Amount";
        //                             AbsorbBase := AbsorbBase + PurchLine."WHT Absorb Base FND";
        //                             if AbsorbBase <> 0 then
        //                                 AmountVAT := AbsorbBase
        //                             else
        //                                 AmountVAT := Amount;
        //                         end;
        //                         WHTBusPostGrp := PurchLine."WHT Business Posting Group FND";
        //                         WHTProdPostGrp := PurchLine."WHT Product Posting Group FND";
        //                     end;
        //         until PurchLine.NEXT() = 0;
        //     InsertPrepaymentUnrealizedWHT(TType::Purchase);
        // end;
        PurchLine.RESET();
        PurchLine.SETCURRENTKEY("Document Type", "Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        PurchLine.SETFILTER(Type, '<>%1', PurchLine.Type::" ");

        if PurchLine.findset() then
            repeat
                if (PurchLine."Prepmt. Line Amount" - PurchLine."Prepmt. Amt. Inv.") <> 0 then
                    if WHTPostingSetup.GET(PurchLine."WHT Business Posting Group FND", PurchLine."WHT Product Posting Group FND") then
                        if WHTPostingSetup."WHT %" > 0 then begin
                            DocNo := PurchInvHeader."No.";
                            DocType := DocType::Invoice;
                            PayToAccType := PayToAccType::Vendor;
                            PayToVendCustNo := PurchInvHeader."Pay-to Vendor No.";
                            BuyFromAccType := BuyFromAccType::Vendor;
                            GenBusPostGrp := PurchLine."Gen. Bus. Posting Group";
                            GenProdPostGrp := PurchLine."Gen. Prod. Posting Group";
                            TransType := TransType::Purchase;
                            BuyFromVendCustNo := PurchInvHeader."Actual Vendor No. FND";
                            PostingDate := PurchInvHeader."Posting Date";
                            DocDate := PurchInvHeader."Document Date";
                            CurrencyCode := PurchInvHeader."Currency Code";
                            CurrFactor := PurchInvHeader."Currency Factor";
                            ApplyDocType := PurchInvHeader."Applies-to Doc. Type";
                            ApplyDocNo := PurchInvHeader."Applies-to Doc. No.";
                            SourceCode := PurchInvHeader."Source Code";
                            ReasonCode := PurchInvHeader."Reason Code";

                            if (WHTBusPostGrp <> PurchLine."WHT Business Posting Group FND") or
                                (WHTProdPostGrp <> PurchLine."WHT Product Posting Group FND")
                            then begin
                                if AmountVAT <> 0 then
                                    InsertPrepaymentUnrealizedWHT(TType::Purchase);
                                WHTBusPostGrp := PurchLine."WHT Business Posting Group FND";
                                WHTProdPostGrp := PurchLine."WHT Product Posting Group FND";
                                Amount := 0;
                                AbsorbBase := 0;
                                AmountVAT := 0;
                                Amount := Amount + PurchLine."Prepayment Amount";
                                AbsorbBase := AbsorbBase + PurchLine."WHT Absorb Base FND";
                                if AbsorbBase <> 0 then
                                    AmountVAT := AbsorbBase
                                else
                                    AmountVAT := Amount;
                            end else begin
                                WHTBusPostGrp := PurchLine."WHT Business Posting Group FND";
                                WHTProdPostGrp := PurchLine."WHT Product Posting Group FND";
                                Amount := Amount + PurchLine."Prepayment Amount";
                                AbsorbBase := AbsorbBase + PurchLine."WHT Absorb Base FND";
                                if AbsorbBase <> 0 then
                                    AmountVAT := AbsorbBase
                                else
                                    AmountVAT := Amount;
                            end;
                            WHTBusPostGrp := PurchLine."WHT Business Posting Group FND";
                            WHTProdPostGrp := PurchLine."WHT Product Posting Group FND";
                        end;
            until PurchLine.NEXT() = 0;
        InsertPrepaymentUnrealizedWHT(TType::Purchase);
        // BC Upgrade PATELP08 <<
    end;

    procedure InsertPrepaymentUnrealizedWHT(TransType: Option Purchase,Sale) EntryNo: Integer;
    var
        WHTEntry: Record "WHT Entry FND";
    begin
        if WHTPostingSetup.GET(WHTBusPostGrp, WHTProdPostGrp) then
            if WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::" " then begin
                UnrealizedWHT := (WHTPostingSetup."Realized WHT Type" in [WHTPostingSetup."Realized WHT Type"::Earliest,
                                                                          WHTPostingSetup."Realized WHT Type"::Invoice]);
                WHTEntry.INIT();
                WHTEntry."Entry No." := NextEntryNo();
                WHTEntry."Gen. Bus. Posting Group" := GenBusPostGrp;
                WHTEntry."Gen. Prod. Posting Group" := GenProdPostGrp;
                WHTEntry."WHT Bus. Posting Group" := WHTBusPostGrp;
                WHTEntry."WHT Prod. Posting Group" := WHTProdPostGrp;
                WHTEntry."Posting Date" := PostingDate;
                WHTEntry."Document Date" := DocDate;
                WHTEntry."Document No." := DocNo;
                WHTEntry."WHT %" := WHTPostingSetup."WHT %";
                WHTEntry."Applies-to Doc. Type" := ApplyDocType;
                WHTEntry."Applies-to Doc. No." := ApplyDocNo;
                WHTEntry."Source Code" := SourceCode;
                WHTEntry."Reason Code" := ReasonCode;
                WHTEntry."WHT Revenue Type" := WHTPostingSetup."Revenue Type";
                WHTEntry."Document Type" := DocType;
                if TransType = TransType::Purchase then
                    WHTEntry."Transaction Type" := WHTEntry."Transaction Type"::Purchase
                else
                    WHTEntry."Transaction Type" := WHTEntry."Transaction Type"::Sale;
                WHTEntry."Actual Vendor No." := ActualVendorNo;
                WHTEntry."Source Code" := SourceCode;
                WHTEntry."Bill-to/Pay-to No." := PayToVendCustNo;
                WHTEntry."User ID" := USERID;
                WHTEntry."Currency Code" := CurrencyCode;

                if UnrealizedWHT then begin
                    WHTEntry.Amount := 0;
                    WHTEntry.Base := 0;
                    WHTEntry.Prepayment := true;
                    if AbsorbBase <> 0 then
                        WHTEntry."Unrealized Base" := AbsorbBase
                    else
                        WHTEntry."Unrealized Base" := AmountVAT;

                    WHTEntry."Unrealized Amount" :=
                      ROUND(WHTEntry."Unrealized Base" * WHTEntry."WHT %" / 100);
                    WHTEntry."Remaining Unrealized Amount" := WHTEntry."Unrealized Amount";
                    WHTEntry."Remaining Unrealized Base" := WHTEntry."Unrealized Base";
                end;

                if CurrencyCode = '' then begin
                    WHTEntry."Base (LCY)" := WHTEntry.Base;
                    WHTEntry."Amount (LCY)" := WHTEntry.Amount;
                    WHTEntry."Unrealized Amount (LCY)" := WHTEntry."Unrealized Amount";
                    WHTEntry."Unrealized Base (LCY)" := WHTEntry."Unrealized Base";
                    WHTEntry."Rem Realized Base (LCY)" := WHTEntry."Rem Realized Base";
                    WHTEntry."Rem Realized Amount (LCY)" := WHTEntry."Rem Realized Amount";
                    WHTEntry."Rem Unrealized Amount (LCY)" := WHTEntry."Remaining Unrealized Amount";
                    WHTEntry."Rem Unrealized Base (LCY)" := WHTEntry."Remaining Unrealized Base";
                end else begin
                    WHTEntry."Base (LCY)" :=
                      ROUND(CurrExchRate.ExchangeAmtFCYToLCY(DocDate, CurrencyCode, WHTEntry.Base, CurrFactor));
                    WHTEntry."Amount (LCY)" :=
                      ROUND(CurrExchRate.ExchangeAmtFCYToLCY(DocDate, CurrencyCode, WHTEntry.Amount, CurrFactor));
                    WHTEntry."Unrealized Base (LCY)" :=
                      ROUND(CurrExchRate.ExchangeAmtFCYToLCY(DocDate, CurrencyCode, WHTEntry."Unrealized Base", CurrFactor));
                    WHTEntry."Rem Realized Amount (LCY)" :=
                      ROUND(CurrExchRate.ExchangeAmtFCYToLCY(DocDate, CurrencyCode, WHTEntry."Rem Realized Amount (LCY)", CurrFactor));
                    WHTEntry."Rem Realized Base (LCY)" :=
                      ROUND(CurrExchRate.ExchangeAmtFCYToLCY(DocDate, CurrencyCode, WHTEntry."Rem Realized Base (LCY)", CurrFactor));
                    WHTEntry."Unrealized Amount (LCY)" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          DocDate, CurrencyCode, WHTEntry."Unrealized Amount", CurrFactor));
                    WHTEntry."Rem Unrealized Amount (LCY)" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          DocDate, CurrencyCode, WHTEntry."Remaining Unrealized Amount", CurrFactor));
                    WHTEntry."Rem Unrealized Base (LCY)" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          DocDate, CurrencyCode, WHTEntry."Remaining Unrealized Base", CurrFactor));
                end;

                //HEI.06>>
                gWHTPostingSetup.RESET();
                if gWHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group") then
                    WHTEntry."WHT Bearer" := gWHTPostingSetup."WHT Bearer";
                //HEI.06<<
                WHTEntry.INSERT();
                NextWHTEntryNo := WHTEntry."Entry No." + 1;
            end;
        exit(NextWHTEntryNo);
    end;

    procedure InitWHTEntry(TempWHTEntry: Record "WHT Entry FND"; AppldAmount: Decimal; PaymentAmount1: Decimal; var WHTEntry3: Record "WHT Entry FND");
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
        TempWHT: Record "WHT Entry FND";
        WHTEntry2: Record "WHT Entry FND";
        WHTEntry4: Record "WHT Entry FND";
    begin
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
        // with TempWHTEntry do begin
        //     WHTEntry2.INIT();
        //     WHTEntry2."Posting Date" := TempGenJnlLine."Document Date";
        //     WHTEntry2."Entry No." := NextEntryNo();
        //     WHTEntry2."Document Date" := "Document Date";
        //     WHTEntry2."Document Type" := TempGenJnlLine."Document Type";
        //     WHTEntry2."Document No." := DocNo;
        //     WHTEntry2."Gen. Bus. Posting Group" := "Gen. Bus. Posting Group";
        //     WHTEntry2."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
        //     WHTEntry2."Bill-to/Pay-to No." := "Bill-to/Pay-to No.";
        //     WHTEntry2."WHT Bus. Posting Group" := "WHT Bus. Posting Group";
        //     WHTEntry2."WHT Prod. Posting Group" := "WHT Prod. Posting Group";
        //     WHTEntry2."WHT Revenue Type" := "WHT Revenue Type";
        //     WHTEntry2."Currency Code" := TempGenJnlLine."Currency Code";
        //     WHTEntry2."Applies-to Entry No." := "Entry No.";
        //     WHTEntry2."User ID" := USERID;
        //     WHTEntry2."External Document No." := TempGenJnlLine."External Document No.";
        //     WHTEntry2."Actual Vendor No. FND" := TempGenJnlLine."Actual Vendor No. FND";
        //     WHTEntry2."Original Document No." := TempGenJnlLine."Document No.";
        //     WHTEntry2."Source Code" := TempGenJnlLine."Source Code";
        //     WHTEntry2."Unrealized WHT Entry No." := "Entry No.";
        //     WHTEntry2."WHT %" := "WHT %";
        //     VendLedgEntry.RESET();
        //     VendLedgEntry.SETRANGE("Document Type", TempGenJnlLine."Document Type");
        //     VendLedgEntry.SETRANGE("Document No.", TempGenJnlLine."Document No.");
        //     if VendLedgEntry.FINDLAST() then
        //         WHTEntry2."Transaction No." := VendLedgEntry."Transaction No.";
        //     WHTEntry2.Base := ROUND(AppldAmount);
        //     WHTEntry2.Amount := ROUND(WHTEntry2.Base * WHTEntry2."WHT %" / 100);
        //     WHTEntry2."Payment Amount" := PaymentAmount1;
        //     WHTEntry2."Transaction Type" := WHTEntry2."Transaction Type"::Purchase;
        //     WHTPostingSetup.GET("WHT Bus. Posting Group", "WHT Prod. Posting Group");
        //     WHTEntry2."WHT Report" := WHTPostingSetup."WHT Report";

        //     if TempGenJnlLine."Certificate Printed" then begin
        //         WHTEntry2."WHT Report Line No" := TempGenJnlLine."WHT Report Line No.";
        //         TempWHT.SETRANGE("Document No.", "Document No.");
        //         if TempWHT.FINDFIRST() then
        //             WHTEntry2."WHT Certificate No." := TempWHT."WHT Certificate No.";
        //     end else begin
        //         if ((TransType = TransType::Purchase) and
        //             ("Document Type" = "Document Type"::Invoice))
        //         then
        //             if (WHTReportLineNo = '') and
        //                (WHTEntry2.Amount <> 0) and
        //                (WHTPostingSetup."WHT Report Line No. Series" <> '')
        //             then
        //                 WHTReportLineNo :=
        //                   NoSeriesMgt.GetNextNo(
        //                     WHTPostingSetup."WHT Report Line No. Series", WHTEntry2."Posting Date", true);
        //         WHTEntry2."WHT Report Line No" := WHTReportLineNo;
        //     end;

        //     if WHTEntry2."Currency Code" <> '' then begin
        //         CurrFactor :=
        //           CurrExchRate.ExchangeRate(
        //             WHTEntry2."Posting Date",
        //             WHTEntry2."Currency Code");
        //         WHTEntry2."Base (LCY)" :=
        //           ROUND(
        //             CurrExchRate.ExchangeAmtFCYToLCY(
        //               TempGenJnlLine."Document Date",
        //               WHTEntry2."Currency Code",
        //               WHTEntry2.Base, CurrFactor));
        //         WHTEntry2."Amount (LCY)" :=
        //           ROUND(
        //             CurrExchRate.ExchangeAmtFCYToLCY(
        //               TempGenJnlLine."Document Date",
        //               WHTEntry2."Currency Code",
        //               WHTEntry2.Amount, CurrFactor));
        //     end else begin
        //         WHTEntry2."Amount (LCY)" := WHTEntry2.Amount;
        //         WHTEntry2."Base (LCY)" := WHTEntry2.Base;
        //     end;

        //     if CurrencyCode = '' then begin
        //         WHTEntry3."Rem Unrealized Amount (LCY)" -= WHTEntry2.Amount;
        //         WHTEntry3."Rem Unrealized Base (LCY)" -= WHTEntry2.Base;
        //     end else begin
        //         WHTEntry3."Rem Unrealized Amount (LCY)" -=
        //           ROUND(CurrExchRate.ExchangeAmtFCYToLCY(DocDate, CurrencyCode, WHTEntry2.Amount, CurrFactor));
        //         WHTEntry3."Rem Unrealized Base (LCY)" -=
        //           ROUND(CurrExchRate.ExchangeAmtFCYToLCY(DocDate, CurrencyCode, WHTEntry2.Base, CurrFactor));
        //     end;
        //     WHTEntry3.Closed :=
        //       (WHTEntry3."Remaining Unrealized Base" = 0) and (WHTEntry3."Remaining Unrealized Amount" = 0);

        //     if ((WHTEntry2."Rem Realized Amount" = 0) and
        //         (WHTEntry2."Rem Realized Base" = 0))
        //     then
        //         WHTEntry2.Closed := true;

        //     //HEI.06>>
        //     gWHTPostingSetup.RESET();
        //     if gWHTPostingSetup.GET(WHTEntry2."WHT Bus. Posting Group", WHTEntry2."WHT Prod. Posting Group") then
        //         WHTEntry2."WHT Bearer" := gWHTPostingSetup."WHT Bearer";
        //     //HEI.06<<
        //     WHTEntry2.INSERT();
        //     NextWHTEntryNo := WHTEntry2."Entry No." + 1;
        //     WHTEntry3.MODIFY();

        //     WHTEntry4.RESET();
        //     WHTEntry4.SETCURRENTKEY("Applies-to Entry No.");
        //     WHTEntry4.SETRANGE("Applies-to Entry No.", "Entry No.");
        //     WHTEntry4.CALCSUMS(Amount, "Amount (LCY)");
        //     if (ABS(ABS(WHTEntry4.Amount) - ABS("Unrealized Amount")) < 0.1) and
        //        (ABS(ABS(WHTEntry4.Amount) - ABS("Unrealized Amount")) > 0)
        //     then begin
        //         WHTEntry2."WHT Difference" := "Unrealized Amount" - WHTEntry4.Amount;
        //         WHTEntry2.Amount := WHTEntry2.Amount + WHTEntry2."WHT Difference";
        //         WHTEntry2.MODIFY();
        //     end;
        //     if (ABS(ABS(WHTEntry4."Amount (LCY)") - ABS("Unrealized Amount (LCY)")) < 0.1) and
        //        (ABS(ABS(WHTEntry4."Amount (LCY)") - ABS("Unrealized Amount (LCY)")) > 0)
        //     then begin
        //         WHTEntry2."Amount (LCY)" := WHTEntry2."Amount (LCY)" +
        //           "Unrealized Amount (LCY)" - WHTEntry4."Amount (LCY)";
        //         WHTEntry2.MODIFY();
        //     end;
        // end;
        WHTEntry2.INIT();
        WHTEntry2."Posting Date" := TempGenJnlLine."Document Date";
        WHTEntry2."Entry No." := NextEntryNo();
        WHTEntry2."Document Date" := TempWHTEntry."Document Date";
        WHTEntry2."Document Type" := TempGenJnlLine."Document Type";
        WHTEntry2."Document No." := DocNo;
        WHTEntry2."Gen. Bus. Posting Group" := TempWHTEntry."Gen. Bus. Posting Group";
        WHTEntry2."Gen. Prod. Posting Group" := TempWHTEntry."Gen. Prod. Posting Group";
        WHTEntry2."Bill-to/Pay-to No." := TempWHTEntry."Bill-to/Pay-to No.";
        WHTEntry2."WHT Bus. Posting Group" := TempWHTEntry."WHT Bus. Posting Group";
        WHTEntry2."WHT Prod. Posting Group" := TempWHTEntry."WHT Prod. Posting Group";
        WHTEntry2."WHT Revenue Type" := TempWHTEntry."WHT Revenue Type";
        WHTEntry2."Currency Code" := TempGenJnlLine."Currency Code";
        WHTEntry2."Applies-to Entry No." := TempWHTEntry."Entry No.";
        WHTEntry2."User ID" := USERID;
        WHTEntry2."External Document No." := TempGenJnlLine."External Document No.";
        WHTEntry2."Actual Vendor No." := TempGenJnlLine."Actual Vendor No. FND";
        WHTEntry2."Original Document No." := TempGenJnlLine."Document No.";
        WHTEntry2."Source Code" := TempGenJnlLine."Source Code";
        WHTEntry2."Unrealized WHT Entry No." := TempWHTEntry."Entry No.";
        WHTEntry2."WHT %" := TempWHTEntry."WHT %";
        VendLedgEntry.RESET();
        VendLedgEntry.SETRANGE("Document Type", TempGenJnlLine."Document Type");
        VendLedgEntry.SETRANGE("Document No.", TempGenJnlLine."Document No.");
        if VendLedgEntry.FINDLAST() then
            WHTEntry2."Transaction No." := VendLedgEntry."Transaction No.";
        WHTEntry2.Base := ROUND(AppldAmount);
        WHTEntry2.Amount := ROUND(WHTEntry2.Base * WHTEntry2."WHT %" / 100);
        WHTEntry2."Payment Amount" := PaymentAmount1;
        WHTEntry2."Transaction Type" := WHTEntry2."Transaction Type"::Purchase;
        WHTPostingSetup.GET(TempWHTEntry."WHT Bus. Posting Group", TempWHTEntry."WHT Prod. Posting Group");
        WHTEntry2."WHT Report" := WHTPostingSetup."WHT Report";

        if TempGenJnlLine."Certificate Printed FND" then begin
            WHTEntry2."WHT Report Line No" := TempGenJnlLine."WHT Report Line No. FND";
            TempWHT.SETRANGE("Document No.", TempWHTEntry."Document No.");
            if TempWHT.FINDFIRST() then
                WHTEntry2."WHT Certificate No." := TempWHT."WHT Certificate No.";
        end else begin
            if ((TransType = TransType::Purchase) and
                (TempWHTEntry."Document Type" = TempWHTEntry."Document Type"::Invoice))
            then
                if (WHTReportLineNo = '') and
                    (WHTEntry2.Amount <> 0) and
                    (WHTPostingSetup."WHT Report Line No. Series" <> '')
                then
                    WHTReportLineNo :=
                        NoSeriesMgt.GetNextNo(
                        WHTPostingSetup."WHT Report Line No. Series", WHTEntry2."Posting Date", true);
            WHTEntry2."WHT Report Line No" := WHTReportLineNo;
        end;

        if WHTEntry2."Currency Code" <> '' then begin
            CurrFactor :=
                CurrExchRate.ExchangeRate(
                WHTEntry2."Posting Date",
                WHTEntry2."Currency Code");
            WHTEntry2."Base (LCY)" :=
                ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                    TempGenJnlLine."Document Date",
                    WHTEntry2."Currency Code",
                    WHTEntry2.Base, CurrFactor));
            WHTEntry2."Amount (LCY)" :=
                ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                    TempGenJnlLine."Document Date",
                    WHTEntry2."Currency Code",
                    WHTEntry2.Amount, CurrFactor));
        end else begin
            WHTEntry2."Amount (LCY)" := WHTEntry2.Amount;
            WHTEntry2."Base (LCY)" := WHTEntry2.Base;
        end;

        if CurrencyCode = '' then begin
            WHTEntry3."Rem Unrealized Amount (LCY)" -= WHTEntry2.Amount;
            WHTEntry3."Rem Unrealized Base (LCY)" -= WHTEntry2.Base;
        end else begin
            WHTEntry3."Rem Unrealized Amount (LCY)" -=
                ROUND(CurrExchRate.ExchangeAmtFCYToLCY(DocDate, CurrencyCode, WHTEntry2.Amount, CurrFactor));
            WHTEntry3."Rem Unrealized Base (LCY)" -=
                ROUND(CurrExchRate.ExchangeAmtFCYToLCY(DocDate, CurrencyCode, WHTEntry2.Base, CurrFactor));
        end;
        WHTEntry3.Closed :=
            (WHTEntry3."Remaining Unrealized Base" = 0) and (WHTEntry3."Remaining Unrealized Amount" = 0);

        if ((WHTEntry2."Rem Realized Amount" = 0) and
            (WHTEntry2."Rem Realized Base" = 0))
        then
            WHTEntry2.Closed := true;

        //HEI.06>>
        gWHTPostingSetup.RESET();
        if gWHTPostingSetup.GET(WHTEntry2."WHT Bus. Posting Group", WHTEntry2."WHT Prod. Posting Group") then
            WHTEntry2."WHT Bearer" := gWHTPostingSetup."WHT Bearer";
        //HEI.06<<
        WHTEntry2.INSERT();
        NextWHTEntryNo := WHTEntry2."Entry No." + 1;
        WHTEntry3.MODIFY();

        WHTEntry4.RESET();
        WHTEntry4.SETCURRENTKEY("Applies-to Entry No.");
        WHTEntry4.SETRANGE("Applies-to Entry No.", TempWHTEntry."Entry No.");
        WHTEntry4.CALCSUMS(Amount, "Amount (LCY)");
        if (ABS(ABS(WHTEntry4.Amount) - ABS(TempWHTEntry."Unrealized Amount")) < 0.1) and
            (ABS(ABS(WHTEntry4.Amount) - ABS(TempWHTEntry."Unrealized Amount")) > 0)
        then begin
            WHTEntry2."WHT Difference" := TempWHTEntry."Unrealized Amount" - WHTEntry4.Amount;
            WHTEntry2.Amount := WHTEntry2.Amount + WHTEntry2."WHT Difference";
            WHTEntry2.MODIFY();
        end;
        if (ABS(ABS(WHTEntry4."Amount (LCY)") - ABS(TempWHTEntry."Unrealized Amount (LCY)")) < 0.1) and
            (ABS(ABS(WHTEntry4."Amount (LCY)") - ABS(TempWHTEntry."Unrealized Amount (LCY)")) > 0)
        then begin
            WHTEntry2."Amount (LCY)" := WHTEntry2."Amount (LCY)" +
                TempWHTEntry."Unrealized Amount (LCY)" - WHTEntry4."Amount (LCY)";
            WHTEntry2.MODIFY();
        end;
        // BC Upgrade PATELP08 <<
    end;

    procedure CheckWHTCalculationRule(TotalInvoiceAmountLCY: Decimal; WHTPostingSetup: Record "WHT Posting Setup FND"): Boolean;
    begin
        case WHTPostingSetup."WHT Calculation Rule" of
            WHTPostingSetup."WHT Calculation Rule"::"Less than":
                if ABS(TotalInvoiceAmountLCY) < WHTPostingSetup."WHT Minimum Invoice Amount" then
                    exit(true);
            WHTPostingSetup."WHT Calculation Rule"::"Less than or equal to":
                if ABS(TotalInvoiceAmountLCY) <= WHTPostingSetup."WHT Minimum Invoice Amount" then
                    exit(true);
            WHTPostingSetup."WHT Calculation Rule"::"Equal to":
                if ABS(TotalInvoiceAmountLCY) = WHTPostingSetup."WHT Minimum Invoice Amount" then
                    exit(true);
            WHTPostingSetup."WHT Calculation Rule"::"Greater than":
                if ABS(TotalInvoiceAmountLCY) > WHTPostingSetup."WHT Minimum Invoice Amount" then
                    exit(true);
            WHTPostingSetup."WHT Calculation Rule"::"Greater than or equal to":
                if ABS(TotalInvoiceAmountLCY) >= WHTPostingSetup."WHT Minimum Invoice Amount" then
                    exit(true);
        end;
        exit(false);
    end;

    procedure InsertVendPrepaymentCrMemoWHT(var PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr."; var PurchHeader: Record "Purchase Header");
    var
        PurchLine: Record "Purchase Line";
    begin
        GLSetup.GET();
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
        // with PurchCrMemoHeader do begin
        //     PurchLine.RESET();
        //     PurchLine.SETCURRENTKEY("Document Type", "Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
        //     PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        //     PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        //     PurchLine.SETFILTER(Type, '<>%1', PurchLine.Type::" ");

        //     if PurchLine.findset() then
        //         repeat
        //             if (PurchLine."Prepmt. Line Amount" - PurchLine."Prepmt. Amt. Inv.") <> 0 then
        //                 if WHTPostingSetup.GET(PurchLine."WHT Business Posting Group FND", PurchLine."WHT Product Posting Group FND") then
        //                     if WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest then
        //                         if WHTPostingSetup."WHT %" > 0 then begin
        //                             DocNo := "No.";
        //                             DocType := DocType::Invoice;
        //                             PayToAccType := PayToAccType::Vendor;
        //                             PayToVendCustNo := "Pay-to Vendor No.";
        //                             BuyFromAccType := BuyFromAccType::Vendor;
        //                             GenBusPostGrp := PurchLine."Gen. Bus. Posting Group";
        //                             GenProdPostGrp := PurchLine."Gen. Prod. Posting Group";
        //                             TransType := TransType::Purchase;
        //                             BuyFromVendCustNo := "Actual Vendor No. FND";
        //                             PostingDate := "Posting Date";
        //                             DocDate := "Document Date";
        //                             CurrencyCode := "Currency Code";
        //                             CurrFactor := "Currency Factor";
        //                             ApplyDocType := "Applies-to Doc. Type";
        //                             ApplyDocNo := "Applies-to Doc. No.";
        //                             SourceCode := "Source Code";
        //                             ReasonCode := "Reason Code";

        //                             if (WHTBusPostGrp <> PurchLine."WHT Business Posting Group FND") or
        //                                (WHTProdPostGrp <> PurchLine."WHT Product Posting Group FND")
        //                             then begin
        //                                 if AmountVAT <> 0 then
        //                                     InsertPrepaymentUnrealizedWHT(TType::Purchase);
        //                                 WHTBusPostGrp := PurchLine."WHT Business Posting Group FND";
        //                                 WHTProdPostGrp := PurchLine."WHT Product Posting Group FND";
        //                                 Amount := 0;
        //                                 AbsorbBase := 0;
        //                                 AmountVAT := 0;
        //                                 Amount := -(Amount + PurchLine."Prepayment Amount");
        //                                 AbsorbBase := -(AbsorbBase + PurchLine."WHT Absorb Base FND");
        //                                 if AbsorbBase <> 0 then
        //                                     AmountVAT := AbsorbBase
        //                                 else
        //                                     AmountVAT := Amount;
        //                             end else begin
        //                                 WHTBusPostGrp := PurchLine."WHT Business Posting Group FND";
        //                                 WHTProdPostGrp := PurchLine."WHT Product Posting Group FND";
        //                                 Amount := -(Amount + PurchLine."Prepayment Amount");
        //                                 AbsorbBase := -(AbsorbBase + PurchLine."WHT Absorb Base FND");
        //                                 if AbsorbBase <> 0 then
        //                                     AmountVAT := AbsorbBase
        //                                 else
        //                                     AmountVAT := Amount;
        //                             end;
        //                             WHTBusPostGrp := PurchLine."WHT Business Posting Group FND";
        //                             WHTProdPostGrp := PurchLine."WHT Product Posting Group FND";
        //                         end;
        //         until PurchLine.NEXT() = 0;
        //     InsertPrepaymentUnrealizedWHT(TType::Purchase);
        // end;
        PurchLine.RESET();
        PurchLine.SETCURRENTKEY("Document Type", "Document No.", "WHT Business Posting Group FND", "WHT Product Posting Group FND");
        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        PurchLine.SETFILTER(Type, '<>%1', PurchLine.Type::" ");

        if PurchLine.findset() then
            repeat
                if (PurchLine."Prepmt. Line Amount" - PurchLine."Prepmt. Amt. Inv.") <> 0 then
                    if WHTPostingSetup.GET(PurchLine."WHT Business Posting Group FND", PurchLine."WHT Product Posting Group FND") then
                        if WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest then
                            if WHTPostingSetup."WHT %" > 0 then begin
                                DocNo := PurchCrMemoHeader."No.";
                                DocType := DocType::Invoice;
                                PayToAccType := PayToAccType::Vendor;
                                PayToVendCustNo := PurchCrMemoHeader."Pay-to Vendor No.";
                                BuyFromAccType := BuyFromAccType::Vendor;
                                GenBusPostGrp := PurchLine."Gen. Bus. Posting Group";
                                GenProdPostGrp := PurchLine."Gen. Prod. Posting Group";
                                TransType := TransType::Purchase;
                                BuyFromVendCustNo := PurchCrMemoHeader."Actual Vendor No. FND";
                                PostingDate := PurchCrMemoHeader."Posting Date";
                                DocDate := PurchCrMemoHeader."Document Date";
                                CurrencyCode := PurchCrMemoHeader."Currency Code";
                                CurrFactor := PurchCrMemoHeader."Currency Factor";
                                ApplyDocType := PurchCrMemoHeader."Applies-to Doc. Type";
                                ApplyDocNo := PurchCrMemoHeader."Applies-to Doc. No.";
                                SourceCode := PurchCrMemoHeader."Source Code";
                                ReasonCode := PurchCrMemoHeader."Reason Code";

                                if (WHTBusPostGrp <> PurchLine."WHT Business Posting Group FND") or
                                    (WHTProdPostGrp <> PurchLine."WHT Product Posting Group FND")
                                then begin
                                    if AmountVAT <> 0 then
                                        InsertPrepaymentUnrealizedWHT(TType::Purchase);
                                    WHTBusPostGrp := PurchLine."WHT Business Posting Group FND";
                                    WHTProdPostGrp := PurchLine."WHT Product Posting Group FND";
                                    Amount := 0;
                                    AbsorbBase := 0;
                                    AmountVAT := 0;
                                    Amount := -(Amount + PurchLine."Prepayment Amount");
                                    AbsorbBase := -(AbsorbBase + PurchLine."WHT Absorb Base FND");
                                    if AbsorbBase <> 0 then
                                        AmountVAT := AbsorbBase
                                    else
                                        AmountVAT := Amount;
                                end else begin
                                    WHTBusPostGrp := PurchLine."WHT Business Posting Group FND";
                                    WHTProdPostGrp := PurchLine."WHT Product Posting Group FND";
                                    Amount := -(Amount + PurchLine."Prepayment Amount");
                                    AbsorbBase := -(AbsorbBase + PurchLine."WHT Absorb Base FND");
                                    if AbsorbBase <> 0 then
                                        AmountVAT := AbsorbBase
                                    else
                                        AmountVAT := Amount;
                                end;
                                WHTBusPostGrp := PurchLine."WHT Business Posting Group FND";
                                WHTProdPostGrp := PurchLine."WHT Product Posting Group FND";
                            end;
            until PurchLine.NEXT() = 0;
        InsertPrepaymentUnrealizedWHT(TType::Purchase);
        // BC Upgrade PATELP08 <<
    end;

    procedure ABSMin(Decimal1: Decimal; Decimal2: Decimal): Decimal;
    begin
        if ABS(Decimal1) < ABS(Decimal2) then
            exit(Decimal1);
        exit(Decimal2);
    end;

    local procedure CalcWHTEntriesRemAmounts(var WHTEntry: Record "WHT Entry FND"; var ClosingWHTEntry: Record "WHT Entry FND"; WHTPart: Decimal);
    var
        WHTAmountToApply: Decimal;
        WHTAmountToApplyLCY: Decimal;
        WHTBaseToApply: Decimal;
        WHTBaseToApplyLCY: Decimal;
    begin
        if WHTPart >= 1 then begin
            WHTEntry."Remaining Unrealized Amount" += ClosingWHTEntry."Remaining Unrealized Amount";
            WHTEntry."Remaining Unrealized Base" += ClosingWHTEntry."Remaining Unrealized Base";
            WHTEntry."Rem Unrealized Amount (LCY)" += ClosingWHTEntry."Rem Unrealized Amount (LCY)";
            WHTEntry."Rem Unrealized Base (LCY)" += ClosingWHTEntry."Rem Unrealized Base (LCY)";

            ClosingWHTEntry."Remaining Unrealized Amount" := 0;
            ClosingWHTEntry."Remaining Unrealized Base" := 0;
            ClosingWHTEntry."Rem Unrealized Amount (LCY)" := 0;
            ClosingWHTEntry."Rem Unrealized Base (LCY)" := 0;
        end else begin
            WHTBaseToApply := ROUND(WHTEntry."Remaining Unrealized Base" * WHTPart);
            WHTAmountToApply := ROUND(WHTEntry."Remaining Unrealized Amount" * WHTPart);
            WHTBaseToApplyLCY := ROUND(WHTEntry."Rem Unrealized Base (LCY)" * WHTPart);
            WHTAmountToApplyLCY := ROUND(WHTEntry."Remaining Unrealized Amount" * WHTPart);

            WHTEntry."Remaining Unrealized Amount" -= WHTAmountToApply;
            WHTEntry."Remaining Unrealized Base" -= WHTBaseToApply;
            WHTEntry."Rem Unrealized Amount (LCY)" -= WHTAmountToApplyLCY;
            WHTEntry."Rem Unrealized Base (LCY)" -= WHTBaseToApplyLCY;

            ClosingWHTEntry."Remaining Unrealized Amount" += WHTAmountToApply;
            ClosingWHTEntry."Remaining Unrealized Base" += WHTBaseToApply;
            ClosingWHTEntry."Rem Unrealized Amount (LCY)" += WHTAmountToApplyLCY;
            ClosingWHTEntry."Rem Unrealized Base (LCY)" += WHTBaseToApplyLCY;
        end;

        CloseWHTEntry(WHTEntry);
        CloseWHTEntry(ClosingWHTEntry);
    end;

    local procedure CloseWHTEntry(var WHTEntry: Record "WHT Entry FND");
    begin
        if (WHTEntry."Remaining Unrealized Base" = 0) and
           (WHTEntry."Remaining Unrealized Amount" = 0)
        then
            WHTEntry.Closed := true;
    end;
    // BC Upgrade PATELP08 >> Changed datatype of parameter "DocType" in procedure FindWHTEntryForApply from Option to Enum for compatibility with calling functions passing Enum values. Enum members match the previous Option values.
    // local procedure FindWHTEntryForApply(var WHTEntry: Record "WHT Entry FND"; DocType: Option; DocNo: Code[20]; WHTBusPostingGr: Code[10]; WHTProdPostingGr: Code[10]): Boolean;
    // begin
    //     WHTEntry.RESET();
    //     WHTEntry.SETRANGE("Document Type", DocType);
    //     WHTEntry.SETRANGE("Document No.", DocNo);
    //     WHTEntry.SETRANGE("WHT Bus. Posting Group", WHTBusPostingGr);
    //     WHTEntry.SETRANGE("WHT Prod. Posting Group", WHTProdPostingGr);
    //     exit(WHTEntry.FINDFIRST());
    // end;
    local procedure FindWHTEntryForApply(var WHTEntry: Record "WHT Entry FND"; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20]; WHTBusPostingGr: Code[10]; WHTProdPostingGr: Code[10]): Boolean;
    begin
        WHTEntry.RESET();
        WHTEntry.SETRANGE("Document Type", DocType);
        WHTEntry.SETRANGE("Document No.", DocNo);
        WHTEntry.SETRANGE("WHT Bus. Posting Group", WHTBusPostingGr);
        WHTEntry.SETRANGE("WHT Prod. Posting Group", WHTProdPostingGr);
        exit(WHTEntry.FINDFIRST());
    end;
    // BC Upgrade PATELP08 <<
    local procedure SetWHTEntryAmounts(var WHTEntry: Record "WHT Entry FND"; AbsorbBase: Decimal; AmountVAT: Decimal; CurrFactor: Decimal);
    begin
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
        // with WHTEntry do begin
        //     Amount := 0;
        //     Base := 0;
        //     if AbsorbBase <> 0 then
        //         "Unrealized Base" := AbsorbBase
        //     else
        //         "Unrealized Base" := AmountVAT;
        //     "Unrealized Amount" := ROUND("Unrealized Base" * "WHT %" / 100);
        //     "Unrealized Base (LCY)" :=
        //       ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Document Date", "Currency Code", "Unrealized Base", CurrFactor));
        //     "Unrealized Amount (LCY)" :=
        //       ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Document Date", "Currency Code", "Unrealized Amount", CurrFactor));
        //     "Remaining Unrealized Amount" := "Unrealized Amount";
        //     "Remaining Unrealized Base" := "Unrealized Base";
        //     "Rem Unrealized Amount (LCY)" := "Unrealized Amount (LCY)";
        //     "Rem Unrealized Base (LCY)" := "Unrealized Base (LCY)";
        // end;
        Amount := 0;
        WHTEntry.Base := 0;
        if AbsorbBase <> 0 then
            WHTEntry."Unrealized Base" := AbsorbBase
        else
            WHTEntry."Unrealized Base" := AmountVAT;
        WHTEntry."Unrealized Amount" := ROUND(WHTEntry."Unrealized Base" * WHTEntry."WHT %" / 100);
        WHTEntry."Unrealized Base (LCY)" :=
            ROUND(CurrExchRate.ExchangeAmtFCYToLCY(WHTEntry."Document Date", WHTEntry."Currency Code", WHTEntry."Unrealized Base", CurrFactor));
        WHTEntry."Unrealized Amount (LCY)" :=
            ROUND(CurrExchRate.ExchangeAmtFCYToLCY(WHTEntry."Document Date", WHTEntry."Currency Code", WHTEntry."Unrealized Amount", CurrFactor));
        WHTEntry."Remaining Unrealized Amount" := WHTEntry."Unrealized Amount";
        WHTEntry."Remaining Unrealized Base" := WHTEntry."Unrealized Base";
        WHTEntry."Rem Unrealized Amount (LCY)" := WHTEntry."Unrealized Amount (LCY)";
        WHTEntry."Rem Unrealized Base (LCY)" := WHTEntry."Unrealized Base (LCY)";
        // BC Upgrade PATELP08 <<
    end;

    local procedure IsForeignVendor(GenJnlLine: Record "Gen. Journal Line"): Boolean;
    begin

        if GenJnlLine."Bill-to/Pay-to No." = '' then begin
            if GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor then
                Vendor.GET(GenJnlLine."Account No.");
        end else
            if (GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Vendor) or
               (GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor)
            then
                Vendor.GET(GenJnlLine."Bill-to/Pay-to No.");
        exit(false);
        //BC UpgradeSHARMP16 begin>> French localisation fields
        // if (Vendor.ABN <> '') or Vendor."Foreign Vend" then
        //     exit(true);
        //BC UpgradeSHARMP16 begin<< French localisation fields

        exit(false);
    end;

    local procedure AdjustWHTEntryWithWHTDifference(WHTEntry: Record "WHT Entry FND"; var WHTEntry2: Record "WHT Entry FND"; var WHTEntry3: Record "WHT Entry FND");
    var
        AmountDifference: Decimal;
    begin
        WHTEntry3.RESET();
        WHTEntry3.SETCURRENTKEY("Applies-to Entry No.");
        WHTEntry3.SETRANGE("Applies-to Entry No.", WHTEntry."Entry No.");
        WHTEntry3.CALCSUMS(Amount, "Amount (LCY)");
        AmountDifference := ABS(WHTEntry3.Amount) - ABS(WHTEntry."Unrealized Amount");
        if (ABS(AmountDifference) < 0.1) and
           (ABS(AmountDifference) > 0)
        then begin
            WHTEntry2."WHT Difference" := WHTEntry2."WHT Difference" + ABS(WHTEntry."Unrealized Amount" - WHTEntry3.Amount);
            WHTEntry2.MODIFY();
        end else
            if WHTEntry2."WHT Difference" = 0 then
                if (ABS(ABS(WHTEntry3."Amount (LCY)") - ABS(WHTEntry."Unrealized Amount (LCY)")) < 0.1) and
                   (ABS(ABS(WHTEntry3."Amount (LCY)") - ABS(WHTEntry."Unrealized Amount (LCY)")) > 0)
                then begin
                    WHTEntry2."Amount (LCY)" :=
                      WHTEntry2."Amount (LCY)" + (WHTEntry."Unrealized Amount (LCY)" - WHTEntry3."Amount (LCY)");
                    WHTEntry2.MODIFY();
                end;
    end;

    local procedure UpdateAmounts(VendorLedgerEntry: Record "Vendor Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; var RemainingAmt: Decimal; var TotAmt: Decimal; var GenJnlLineAmount: Decimal; var ExitLoop: Boolean);
    begin
        if (ABS(RemainingAmt) < ABS(TotAmt)) or
           (ABS(VendorLedgerEntry."Remaining Amount") < ABS(TotAmt))
        then begin
            GenJnlLineAmount := ABS(ABSMin(VendorLedgerEntry."Remaining Amount", RemainingAmt));
            GenJournalLine.VALIDATE(Amount, ABS(ABSMin(VendorLedgerEntry."Amount to Apply", GenJnlLineAmount)));
            TotAmt := TotAmt - ABS(GenJournalLine.Amount);
            RemainingAmt := RemainingAmt + ABS(GenJournalLine.Amount);
        end else begin
            GenJournalLine.VALIDATE(Amount, TotAmt);
            ExitLoop := true;
        end;
    end;

    local procedure FilterWHTEntry(var WHTEntry: Record "WHT Entry FND"; GenJournalLine: Record "Gen. Journal Line");
    begin
        WHTEntry.RESET();
        WHTEntry.SETCURRENTKEY("Transaction Type", "Document No.", "Document Type", "Bill-to/Pay-to No.");
        WHTEntry.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
        if GenJournalLine."Applies-to Doc. No." <> '' then begin
            WHTEntry.SETRANGE("Document Type", GenJournalLine."Applies-to Doc. Type");
            WHTEntry.SETRANGE("Document No.", GenJournalLine."Applies-to Doc. No.");
        end else
            WHTEntry.SETRANGE("Bill-to/Pay-to No.", GenJournalLine."Account No.");
    end;

    procedure CalcAppliedWHTAmount(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; WHTPercent: Decimal; ExitLoop: Boolean): Decimal;
    var
        AppliedAmount: Decimal;
        Result: Decimal;
        TotalAmountToApply: Decimal;
        EntryNo: Integer;
    begin
        if ExitLoop then begin
            // Here we can have several Vendor Ledger Entries to be applied.
            // So we need iterate through remaining entries to calculate WHT amount per entry
            EntryNo := VendorLedgerEntry."Entry No.";
            TotalAmountToApply := GenJournalLine.Amount;
            repeat
                AppliedAmount := ABSMin(-VendorLedgerEntry."Amount to Apply", TotalAmountToApply);
                Result += CalcWHTAmount(AppliedAmount, WHTPercent);
                TotalAmountToApply -= AppliedAmount;
            until (VendorLedgerEntry.NEXT() = 0) or (TotalAmountToApply <= 0);
            VendorLedgerEntry.GET(EntryNo);
            exit(Result);
        end;
        //HEI.05>>comb
        exit(ROUND(-VendorLedgerEntry."Amount to Apply" * WHTPercent / 100));
        //HEI.05<<
        //HEI.05 comb EXIT(ROUND(GenJournalLine.Amount * WHTPercent / 100));
    end;

    local procedure CalcWHTAmount(Amount: Decimal; WHTPercent: Decimal): Decimal;
    begin
        exit(ROUND(Amount * WHTPercent / 100));
    end;

    procedure StatisticsCalcWHTAmount(TableID: Integer; DocumentNo: Code[20]; DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"): Decimal;
    var
        PurchaseLine: Record "Purchase Line";
        SalesLine: Record "Sales Line";
        VATPostingSetup: Record "VAT Posting Setup";
        WHTPostingSetup: Record "WHT Posting Setup FND";
        LineAmount: Decimal;
        WHTAmnt: Decimal;
        WHTTotalAmount: Decimal;
    begin
        //function called from pages 160, 161, 402, 403
        //for sales
        if TableID = 37 then begin
            SalesLine.RESET();
            SalesLine.SETRANGE("Document No.", DocumentNo);
            SalesLine.SETRANGE("Document Type", DocumentType);
            if SalesLine.FINDFIRST() then begin
                repeat
                    if WHTPostingSetup.GET(SalesLine."WHT Business Posting Group FND", SalesLine."WHT Product Posting Group FND") then begin
                        //LineAmount := SalesLine.GetTotalingLine(1, SalesLine.FIELDNO(SalesLine.Amount), true);  // BC Upgrade NANDIS03 - Dependency on Aptean
                        WHTTotalAmount += ROUND(LineAmount * WHTPostingSetup."WHT %" / 100);
                    end;
                until SalesLine.NEXT() = 0;
            end;
        end;

        //for purchases
        if TableID = 39 then begin
            PurchaseLine.RESET();
            PurchaseLine.SETRANGE("Document No.", DocumentNo);
            PurchaseLine.SETRANGE("Document Type", DocumentType);
            if PurchaseLine.FINDFIRST() then begin
                repeat
                    if WHTPostingSetup.GET(PurchaseLine."WHT Business Posting Group FND", PurchaseLine."WHT Product Posting Group FND") then begin
                        LineAmount := PurchaseLine.Amount;
                        if VATPostingSetup.GET(PurchaseLine."VAT Bus. Posting Group", PurchaseLine."VAT Prod. Posting Group") then
                            if (VATPostingSetup."VAT Calculation Type" = VATPostingSetup."VAT Calculation Type"::"Full VAT")
                            and (VATPostingSetup."Top Gross WHT Deductible FND") then
                                LineAmount := PurchaseLine."Amount Including VAT";
                        //HEI.07 >>
                        if PurchaseLine."WHT Absorb Base FND" <> 0 then begin
                            WHTAmnt := PurchaseLine."WHT Absorb Base FND";
                            WHTTotalAmount += ROUND(WHTAmnt * WHTPostingSetup."WHT %" / 100)
                        end else
                            //HEI.07  <<
                            WHTTotalAmount += ROUND(LineAmount * WHTPostingSetup."WHT %" / 100);
                        // else
                        //end;
                    end;
                until PurchaseLine.NEXT() = 0
            end;
        end;

        exit(WHTTotalAmount);
    end;
}