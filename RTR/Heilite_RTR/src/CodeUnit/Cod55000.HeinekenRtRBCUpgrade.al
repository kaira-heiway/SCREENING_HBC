codeunit 55000 "Heineken RtR BC Upgrade"
{
    // BC Upgrade POENAB02 >>
    // Migration of CU 370 "Bank Acc. Reconciliation Post" from HeiLite
    // there are changes that are not marked accordingly in HeiLite, with HEI.01, 
    // but are part of the customized developments done in HeiLite
    // waiting for Microsoft to create an event for ApplyVendLedgEntry - https://github.com/microsoft/ALAppExtensions/issues/29597

    //HEI.01 CHG2020184 IBM POENAB02 26.06.2019
    //  # Modified function CloseBankAccLedgEntry
    //Bc Upgrade YADAVM09 Bug fix for BCUP0-29 added event OnInitGLEntryOnBeforeCheckGLAccDimError.
    //Bc Upgrade YADAVM09 BCUP0-140 event added OnAfterSetCommonFilters,OnAfterSetCommonFilters1 to get value of current analysis view code.
    //Bc Upgrade YADAVM09 BCUP0-124 Vat Entry fix for Revaluation entry.
    Permissions = TableData "Bank Account Ledger Entry" = rm,
                  TableData "Gen. Journal Line" = rm,
                  TableData "G/L Entry" = rm,
                  TableData "Bank Acc. Reconciliation" = rm,
                  TableData "Bank Account" = rm,
                  TableData "Applied Payment Entry" = rm;

    var
        BankAccReconciliationLine2: Record "Bank Acc. Reconciliation Line";
        BankAccReconciliationLineTmp: Record "Bank Acc. Reconciliation Line" temporary;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Bank Acc. Reconciliation Post", OnBeforePostPaymentApplications, '', false, false)]
    local procedure OnBeforePostPaymentApplications(BankAccReconLine: Record "Bank Acc. Reconciliation Line"; var AppliedAmount: Decimal; var IsHandled: Boolean)
    var
        BankAcc: Record "Bank Account";
    begin
        BankAcc.Get(BankAccReconLine."Bank Account No.");
        if BankAcc."SuspnsAcc. for Paym.Reconc FND" then begin
            PostPaymentApplicationsHnk(BankAccReconLine, AppliedAmount);
            IsHandled := true;
        end;
    end;

    local procedure PostPaymentApplicationsHnk(BankAccReconLine: Record "Bank Acc. Reconciliation Line"; var AppliedAmount: Decimal);
    var
        BankAcc: Record "Bank Account";
        GenJnlLine: Record "Gen. Journal Line";
        CurrExchRate: Record "Currency Exchange Rate";
        AppliedPmtEntry: Record "Applied Payment Entry";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        GLSetup: Record "General Ledger Setup";
        BankAccRecon: Record "Bank Acc. Reconciliation";
        DimensionManagement: Codeunit "DimensionManagement";
        PaymentLineAmount: Decimal;
        RemainingAmount: Decimal;
        IsApplied: Boolean;
        ApplyCust: Boolean;
        PostPaymentsOnly: Boolean;
        BankAccountPostingGroup: Record "Bank Account Posting Group";
        PostNotMatched: Boolean;
        ToleranceAmount: Decimal;
        CLE: Record "Cust. Ledger Entry";
        VLE: Record "Vendor Ledger Entry";
        RemAmt: Decimal;
        FullyMatched: Boolean;
        ApplPaymentEntry: Record "Applied Payment Entry";
        MultipleEntries: Boolean;
        GLAccToPost: Code[20];
        PostedStamentNo: Code[20];
        TolExceded: Boolean;
        InitialGLEntryNo: Integer;
        GLEntry: Record "G/L Entry";
        GLEntry2: Record "G/L Entry";
        FirstGLEntryToApply: Integer;
        LastGLEntryToApply: Integer;
        LCurrFactor: Decimal;
        TransactionAlreadyReconciledErr: Label 'The line with transaction date %1 and transaction text ''%2'' is already reconciled.\\You must remove it from the payment reconciliation journal before posting.';
        Text50001: Label 'Not allowed entries with payment confidence Manual';
        BankAccReconciliationPost: Codeunit "Bank Acc. Reconciliation Post";
    begin
        if BankAccReconLine.IsTransactionPostedAndReconciled() then
            Error(TransactionAlreadyReconciledErr, BankAccReconLine."Transaction Date", BankAccReconLine."Transaction Text");
        if (BankAccReconLine."Account Type" = BankAccReconLine."Account Type"::"G/L Account") and (BankAccReconLine."Account No." <> '') then
            Error(Text50001, BankAccReconLine."Statement Line No.");
        BankAcc.Get(BankAccReconLine."Bank Account No.");
        if BankAcc."SuspnsAcc. for Paym.Reconc FND" then begin
            BankAcc.TestField("Bank Acc. Posting Group");
            BankAccountPostingGroup.Get(BankAcc."Bank Acc. Posting Group");
            BankAccountPostingGroup.TestField("AR Suspense Account FND");
            BankAccountPostingGroup.TestField("AP Suspense Account FND");
            BankAccReconLine.CalcFields("Match Confidence");
            //IF BankAccReconLine."Match Confidence" = BankAccReconLine."Match Confidence"::Manual THEN
            //ERROR(Text50000);
            PostNotMatched := (BankAccReconLine."Account Type" = BankAccReconLine."Account Type"::"G/L Account")
              and (BankAccReconLine."Match Confidence" = BankAccReconLine."Match Confidence"::Manual);
        end;
        if BankAccReconLine."Applied Amount" >= 0 then
            GLAccToPost := BankAccountPostingGroup."AR Suspense Account FND"
        else
            GLAccToPost := BankAccountPostingGroup."AP Suspense Account FND";

        Clear(ApplPaymentEntry);
        ApplyCust := false;
        ToleranceAmount := 0;
        RemAmt := 0;
        if BankAccReconLine."Account Type" in [BankAccReconLine."Account Type"::Vendor, BankAccReconLine."Account Type"::Customer] then begin
            Clear(ApplPaymentEntry);
            ApplPaymentEntry.SetRange("Statement Type", BankAccReconLine."Statement Type");
            ApplPaymentEntry.SetRange("Bank Account No.", BankAccReconLine."Bank Account No.");
            ApplPaymentEntry.SetRange("Statement No.", BankAccReconLine."Statement No.");
            ApplPaymentEntry.SetRange("Statement Line No.", BankAccReconLine."Statement Line No.");

            if ApplPaymentEntry.FindSet(false) then
                repeat
                    if BankAccReconLine."Account Type" = BankAccReconLine."Account Type"::Vendor then begin
                        if VLE.Get(ApplPaymentEntry."Applies-to Entry No.") then begin
                            ToleranceAmount += VLE."Max. Payment Tolerance";
                            VLE.CalcFields("Remaining Amount");
                            RemAmt += VLE."Remaining Amount";
                            GLEntry.SetCurrentKey("Transaction No.");
                            GLEntry.SetRange("Transaction No.", VLE."Transaction No.");
                            GLEntry.SetRange("G/L Account No.", BankAccountPostingGroup."AP Suspense Account FND");
                            if GLEntry.FindFirst() then;

                        end;
                    end;
                    if BankAccReconLine."Account Type" = BankAccReconLine."Account Type"::Customer then begin
                        if CLE.Get(ApplPaymentEntry."Applies-to Entry No.") then begin
                            ToleranceAmount += CLE."Max. Payment Tolerance";
                            CLE.CalcFields("Remaining Amount");
                            RemAmt += CLE."Remaining Amount";
                        end;
                    end;

                //ToleranceAmount +=
                UNTIL ApplPaymentEntry.Next() = 0;
        END;

        if abs(RemAmt) - abs(BankAccReconLine."Statement Amount") > abs(ToleranceAmount) then
            TolExceded := true;

        Clear(ApplPaymentEntry);
        ApplPaymentEntry.SetRange("Statement Type", BankAccReconLine."Statement Type");
        ApplPaymentEntry.SetRange("Bank Account No.", BankAccReconLine."Bank Account No.");
        ApplPaymentEntry.SetRange("Statement No.", BankAccReconLine."Statement No.");
        ApplPaymentEntry.SetRange("Statement Line No.", BankAccReconLine."Statement Line No.");
        MultipleEntries := ApplPaymentEntry.Count > 1;
        FullyMatched := BankAccReconLine.Difference = 0;
        if ApplPaymentEntry.FindSet() then
            repeat
                AppliedAmount += ApplPaymentEntry."Applied Amount" - ApplPaymentEntry."Applied Pmt. Discount";
            UNTIL ApplPaymentEntry.Next() = 0;

        if (BankAccReconLine."Account Type" = BankAccReconLine."Account Type"::Customer) and
          (BankAccReconLine."Statement Amount" > 0) then begin
            PostLine(BankAccReconLine,
                  ApplPaymentEntry,
                  GenJnlLine."Account Type"::"Bank Account",
                  BankAcc."No.",
                  GenJnlLine."Account Type"::"G/L Account",
                  GLAccToPost, BankAccReconLine."Statement Amount", 0, 0, ApplyCust);
            Clear(GLEntry);
            GLEntry.SetCurrentKey("Document No.", "Posting Date");
            GLEntry.SetRange("Document No.", BankAccReconLine."Statement No.");
            GLEntry.SetRange("Posting Date", BankAccReconLine."Transaction Date");
            GLEntry.SetRange("G/L Account No.", GLAccToPost);
            GLEntry.FindLast();

            //post diff as an open CLE
            if BankAccReconLine.Difference <> 0 then
                PostLine(BankAccReconLine,
                      ApplPaymentEntry,
                      GenJnlLine."Account Type"::"G/L Account",
                      GLAccToPost,
                      GenJnlLine."Account Type"::Customer,
                      BankAccReconLine."Account No.", BankAccReconLine."Statement Amount", 0, 0, ApplyCust);
        END;

        //>DS_001 29.01.18
        Clear(AppliedAmount);
        //<DS_001 29.01.18
        Clear(ApplPaymentEntry);
        ApplPaymentEntry.SetRange("Statement Type", BankAccReconLine."Statement Type");
        ApplPaymentEntry.SetRange("Bank Account No.", BankAccReconLine."Bank Account No.");
        ApplPaymentEntry.SetRange("Statement No.", BankAccReconLine."Statement No.");
        ApplPaymentEntry.SetRange("Statement Line No.", BankAccReconLine."Statement Line No.");
        MultipleEntries := ApplPaymentEntry.Count > 1;
        FullyMatched := BankAccReconLine.Difference = 0;


        if ApplPaymentEntry.FindSet(false) then
            repeat
                AppliedAmount += ApplPaymentEntry."Applied Amount" - ApplPaymentEntry."Applied Pmt. Discount";
                //IF NOT TolExceded THEN BEGIN
                case ApplPaymentEntry."Account Type" of
                    ApplPaymentEntry."Account Type"::Vendor:
                        begin
                            if BankAccReconLine."Applied Amount" >= 0 then begin//refund to a vendor
                                PostLine(BankAccReconLine,
                                        ApplPaymentEntry,
                                        GenJnlLine."Account Type"::"Bank Account",
                                        BankAcc."No.",
                                        GenJnlLine."Account Type"::"G/L Account",
                                        GLAccToPost, ApplPaymentEntry."Applied Amount", 0, 0, ApplyCust);
                                PostLine(BankAccReconLine,
                                        ApplPaymentEntry,
                                        GenJnlLine."Account Type"::"G/L Account",
                                        GLAccToPost,
                                        GenJnlLine."Account Type"::Vendor,
                                        ApplPaymentEntry."Account No.", ApplPaymentEntry."Applied Amount", 0, 0, ApplyCust);
                            end else begin
                                //>DS003 08/02/18
                                LCurrFactor := 0;
                                if VLE."Currency Code" <> '' then
                                    LCurrFactor := VLE."Original Currency Factor";
                                //<DS003 08/02/18
                                PostLine(BankAccReconLine,
                                        ApplPaymentEntry,
                                        GenJnlLine."Account Type"::"Bank Account",
                                        BankAcc."No.",
                                        GenJnlLine."Account Type"::"G/L Account",
                                        //>DS003 08/02/18
                                        //GLAccToPost,ApplPaymentEntry."Applied Amount",0,VLE."Original Currency Factor");
                                        GLAccToPost, ApplPaymentEntry."Applied Amount", 0, LCurrFactor, ApplyCust);
                                //<DS003 08/02/18
                                Clear(GLEntry2);
                                GLEntry2.SetCurrentKey("Document No.");
                                GLEntry2.SetRange("G/L Account No.", GLAccToPost);
                                GLEntry2.SetRange("Document No.", BankAccReconLine."Statement No.");
                                GLEntry2.SetRange("Posting Date", BankAccReconLine."Transaction Date");
                                if GLEntry2.FindLast() then begin
                                    if GLEntry2."G/L Account No." = GLEntry."G/L Account No." then begin
                                        if GLEntry2.Amount = -GLEntry.Amount then begin
                                            GLEntry."Open FND" := false;
                                            GLEntry."Remaining Amount FND" := 0;
                                            GLEntry."Closed by Entry No. FND" := GLEntry2."Entry No.";
                                            GLEntry.Modify();
                                            GLEntry2."Open FND" := false;
                                            GLEntry2."Remaining Amount FND" := 0;
                                            GLEntry2."Closed by Entry No. FND" := GLEntry."Entry No.";
                                            GLEntry2.Modify();
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    ApplPaymentEntry."Account Type"::Customer:
                        begin
                            if BankAccReconLine.Difference = 0 then begin
                                ToleranceAmount := 0;
                                ApplyCust := TRUE;

                                Clear(CLE);
                                if CLE.Get(ApplPaymentEntry."Applies-to Entry No.") then begin
                                    CLE.CalcFields("Remaining Amount");
                                    // ApplyCust := CLE."Remaining Amount FND" - ApplPaymentEntry."Applied Amount" <=  CLE."Max. Payment Tolerance" ;
                                end;
                                GLSetup.Get();


                                PostLine(BankAccReconLine,
                                        ApplPaymentEntry,
                                        GenJnlLine."Account Type"::"G/L Account",
                                        GLAccToPost,
                                        GenJnlLine."Account Type"::Customer,
                                        ApplPaymentEntry."Account No.", ApplPaymentEntry."Applied Amount", CLE."Entry No.", 0, ApplyCust);
                                if ApplyCust then begin
                                    Clear(GLEntry2);
                                    GLEntry2.SetCurrentKey("Document No.", "Posting Date");
                                    GLEntry2.SetRange("Document No.", BankAccReconLine."Statement No.");
                                    GLEntry2.SetRange("Posting Date", BankAccReconLine."Transaction Date");
                                    GLEntry2.SetRange("G/L Account No.", GLAccToPost);

                                    if GLEntry2.FindLast() then begin
                                        if GLEntry2."G/L Account No." = GLEntry."G/L Account No." then begin
                                            if GLEntry2.Amount <= -GLEntry.Amount then begin
                                                GLEntry2."Open FND" := false;
                                                GLEntry2."Remaining Amount FND" := 0;
                                                GLEntry2."Closed by Entry No. FND" := GLEntry."Entry No.";
                                                GLEntry2.Modify();
                                                GLEntry."Remaining Amount FND" := GLEntry."Remaining Amount FND" + GLEntry2.Amount;
                                                if GLEntry."Remaining Amount FND" = 0 then begin
                                                    GLEntry."Open FND" := FALSE;
                                                    GLEntry."Remaining Amount FND" := 0;
                                                    GLEntry."Closed by Entry No. FND" := GLEntry2."Entry No.";
                                                end;
                                                GLEntry.Modify();
                                                /*
                                                GLEntry.Open := FALSE;
                                                GLEntry."Remaining Amount FND" := 0;
                                                GLEntry."Closed by Entry No." := GLEntry2."Entry No.";
                                                GLEntry.Modify();
                                                */
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end else begin
                        PostLine(BankAccReconLine,
                                ApplPaymentEntry,
                                GenJnlLine."Account Type"::"Bank Account",
                                BankAcc."No.",
                                GenJnlLine."Account Type"::"G/L Account",
                                GLAccToPost, ApplPaymentEntry."Applied Amount", 0, 0, ApplyCust);
                    end;
                end;
            until ApplPaymentEntry.Next() = 0;
        if BankAccReconLine."Account Type" in [BankAccReconLine."Account Type"::"Bank Account", BankAccReconLine."Account Type"::"G/L Account"] then
            PostLine(BankAccReconLine,
                  ApplPaymentEntry,
                  GenJnlLine."Account Type"::"Bank Account",
                  BankAcc."No.",
                  GenJnlLine."Account Type"::"G/L Account",
                  GLAccToPost, BankAccReconLine."Statement Amount", 0, 0, ApplyCust);

        BankAccRecon.Get(BankAccReconLine."Statement Type", BankAccReconLine."Bank Account No.", BankAccReconLine."Statement No.");
        if BankAccRecon."Statement Type" = BankAccRecon."Statement Type"::"Payment Application" then
            PostPaymentsOnly := BankAccRecon."Post Payments Only";

        if not PostPaymentsOnly then begin
            PostedStamentNo := GetPostedStamentNo(BankAccRecon);
            BankAccountLedgerEntry.SetRange(Open, TRUE);
            BankAccountLedgerEntry.SetRange("Bank Account No.", BankAcc."No.");
            //BankAccountLedgerEntry.SetRange("Document Type",GenJnlLine."Document Type"::Payment);
            BankAccountLedgerEntry.SetRange("Document No.", BankAccReconLine."Statement No.");
            BankAccountLedgerEntry.SetRange("Posting Date", GenJnlLine."Posting Date");
            if BankAccountLedgerEntry.FindLast() then
                CloseBankAccountLedgerEntry(BankAccountLedgerEntry."Entry No.", BankAccountLedgerEntry.Amount, BankAccRecon."Statement Date", BankAccReconLine."Statement Line No.", PostedStamentNo);
        END;
        /*
      IF BankAccReconLine."Account Type" = BankAccReconLine."Account Type"::Customer THEN BEGIN
        IF BankAccReconLine."Applied Amount" >= 0 THEN BEGIN
          PostLine(BankAccReconLine,
            ApplPaymentEntry,
            GenJnlLine."Account Type"::"Bank Account",
            BankAcc."No.",
            GenJnlLine."Account Type"::"G/L Account",
            GLAccToPost,BankAccReconLine.Difference);
          PostLine(BankAccReconLine,
            ApplPaymentEntry,
            GenJnlLine."Account Type"::"G/L Account",
            GLAccToPost,
            GenJnlLine."Account Type"::Customer,
            ApplPaymentEntry."Account No.",BankAccReconLine.Difference);
        END;
        */
    end;

    local procedure PostLine(VAR BankAccReconLine: Record "Bank Acc. Reconciliation Line"; VAR ApplPaymentEntry: Record "Applied Payment Entry"; AccType: Enum "Gen. Journal Account Type"; AccNo: Code[20]; BalAccType: Enum "Gen. Journal Account Type"; BalAccNo: Code[20]; AmountToPost: Decimal; ApplyToEntryNo: Integer; CurrFactor: Decimal; ApplyCust: Boolean);
    var
        GenJnlLine: Record "Gen. Journal Line";
        BankAcc: Record "Bank Account";
        BankAccRecon: Record "Bank Acc. Reconciliation";
        SourceCodeSetup: Record "Source Code Setup";
        DimensionManagement: Codeunit DimensionManagement;
        CurrExchRate: Record "Currency Exchange Rate";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        CLE: Record "Cust. Ledger Entry";
        BankAccReconciliationPost: codeunit "Bank Acc. Reconciliation Post";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        SourceCode: Code[10];
    begin
        BankAcc.Get(BankAccReconLine."Bank Account No.");
        BankAccRecon.Get(BankAccReconLine."Statement Type", BankAccReconLine."Bank Account No.", BankAccReconLine."Statement No.");
        if (BankAccRecon."Statement Type" = BankAccRecon."Statement Type"::"Payment Application") then begin
            SourceCodeSetup.Get();
            SourceCode := SourceCodeSetup."Payment Reconciliation Journal";
        end;
        //HEI.01>>
        Clear(GenJnlLine);
        GenJnlLine.Init();
        if AccType <> AccType::"G/L Account" then begin
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
            if IsRefund(BankAccReconLine) then
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Refund;
        end;
        GenJnlLine."Account Type" := AccType;
        GenJnlLine.Validate("Account No.", AccNo);
        GenJnlLine."Dimension Set ID" := BankAccReconLine."Dimension Set ID";
        DimensionManagement.UpdateGlobalDimFromDimSetID(
          BankAccReconLine."Dimension Set ID", GenJnlLine."Shortcut Dimension 1 Code", GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine."Posting Date" := BankAccReconLine."Transaction Date";
        GenJnlLine.Validate("Currency Code", BankAcc."Currency Code");

        if BankAcc."Currency Code" <> '' then begin
            GenJnlLine.Validate("Currency Factor",
              CurrExchRate.ExchangeRate(GenJnlLine."Posting Date", BankAcc."Currency Code"));
        end else
            GenJnlLine."Currency Factor" := 0;
        if CurrFactor <> 0 then
            GenJnlLine.Validate("Currency Factor", CurrFactor);

        GenJnlLine.Description := BankAccReconLine.Description;
        GenJnlLine."Document No." := BankAccReconLine."Statement No.";

        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Allow Zero-Amount Posting" := TRUE;
        GenJnlLine.Validate(Amount, AmountToPost);//HEI.01
        if ApplyCust then
            if (GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer) then begin
                if CLE.Get(ApplPaymentEntry."Applies-to Entry No.") then begin
                    // GenJnlLine."Applies-to Doc. No." := CLE."Document No.";
                    //GenJnlLine."Applies-to Doc. Type" := CLE."Document Type";
                    //GenJnlLine."Applies-to ID" := CLE."Entry No.";
                    if CLE."Remaining Amount" - ApplPaymentEntry."Applied Amount" <= CLE."Max. Payment Tolerance" then begin
                        GenJnlLine."Applies-to ID" := BankAccReconLine.GetAppliesToID();
                        BankAccReconciliationPost.ApplyCustLedgEntry(
                                ApplPaymentEntry, GenJnlLine."Applies-to ID", GenJnlLine."Posting Date", 0D, 0D, ApplPaymentEntry."Applied Pmt. Discount");
                    end;
                end;
            end;

        AssignPostingGroup(ApplPaymentEntry, GenJnlLine);
        GenJnlPostLine.RunWithCheck(GenJnlLine);

        Clear(GenJnlLine);
        GenJnlLine.Init();
        if BalAccType <> BalAccType::"G/L Account" then begin
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
            IF IsRefund(BankAccReconLine) THEN
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Refund;
        end;
        GenJnlLine."Account Type" := BalAccType;
        GenJnlLine.Validate("Account No.", BalAccNo);
        GenJnlLine."Dimension Set ID" := BankAccReconLine."Dimension Set ID";
        DimensionManagement.UpdateGlobalDimFromDimSetID(
          BankAccReconLine."Dimension Set ID", GenJnlLine."Shortcut Dimension 1 Code", GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine."Posting Date" := BankAccReconLine."Transaction Date";
        GenJnlLine.Validate("Currency Code", BankAcc."Currency Code");
        GenJnlLine.Description := BankAccReconLine.Description;
        GenJnlLine."Document No." := BankAccReconLine."Statement No.";
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Allow Zero-Amount Posting" := TRUE;

        if BankAcc."Currency Code" <> '' then
            GenJnlLine.Validate("Currency Factor",
              CurrExchRate.ExchangeRate(GenJnlLine."Posting Date", BankAcc."Currency Code"))
        else
            GenJnlLine."Currency Factor" := 0;
        if CurrFactor <> 0 then
            GenJnlLine.Validate("Currency Factor", CurrFactor);
        GenJnlLine.Validate(Amount, -AmountToPost);//HEI.01
        if ApplyCust then
            if (GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer) then begin
                if CLE.Get(ApplPaymentEntry."Applies-to Entry No.") then begin
                    //GenJnlLine."Applies-to Doc. No." := CLE."Document No.";
                    //GenJnlLine."Applies-to Doc. Type" := CLE."Document Type";
                    //GenJnlLine."Applies-to ID" := CLE."Entry No.";

                    if CLE."Remaining Amount" - ApplPaymentEntry."Applied Amount" <= CLE."Max. Payment Tolerance" then begin
                        GenJnlLine."Applies-to ID" := BankAccReconLine.GetAppliesToID();
                        // BC upgrade POENAB02 >>
                        //ApplyCustLedgEntry(
                        //          ApplPaymentEntry, GenJnlLine."Applies-to ID", GenJnlLine."Posting Date", 0D, 0D, ApplPaymentEntry."Applied Pmt. Discount");
                        BankAccReconciliationPost.ApplyCustLedgEntry(
                                  ApplPaymentEntry, GenJnlLine."Applies-to ID", GenJnlLine."Posting Date", 0D, 0D, ApplPaymentEntry."Applied Pmt. Discount");
                        // BC upgrade POENAB02 <<
                    end;
                end;
            end;
        AssignPostingGroup(ApplPaymentEntry, GenJnlLine);

        GenJnlPostLine.RunWithCheck(GenJnlLine);
        //HEI.01<<
    end;

    local procedure IsRefund(BankAccReconLine: Record "Bank Acc. Reconciliation Line"): Boolean
    begin
        if (BankAccReconLine."Account Type" = BankAccReconLine."Account Type"::Customer) and (BankAccReconLine."Statement Amount" < 0) or
            (BankAccReconLine."Account Type" = BankAccReconLine."Account Type"::Vendor) and (BankAccReconLine."Statement Amount" > 0)
        then
            exit(true);
        exit(false);
    end;

    local procedure AssignPostingGroup(VAR ApplPaymentEntry: Record "Applied Payment Entry"; VAR GenJLine: Record "Gen. Journal Line");
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        if GenJLine."Account Type" = GenJLine."Account Type"::Customer then begin
            if CustLedgerEntry.get(ApplPaymentEntry."Applies-to Entry No.") then begin
                GenJLine."Posting Group" := CustLedgerEntry."Customer Posting Group";
            end;
        end;
        if GenJLine."Account Type" = GenJLine."Account Type"::Vendor then begin
            if VendorLedgerEntry.get(ApplPaymentEntry."Applies-to Entry No.") then begin
                GenJLine."Posting Group" := VendorLedgerEntry."Vendor Posting Group";
            end;
        end;
    end;
    // taken from standard BC
    local procedure CloseBankAccountLedgerEntry(EntryNo: Integer; AppliedAmount: Decimal; StatementDate: Date; StatementLineNo: Integer; PostedStamentNo: Code[20])
    var
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        CheckLedgerEntry: Record "Check Ledger Entry";
    begin
        BankAccountLedgerEntry.Get(EntryNo);
        BankAccountLedgerEntry.TestField(Open);
        BankAccountLedgerEntry.TestField("Remaining Amount", AppliedAmount);
        BankAccountLedgerEntry."Remaining Amount" := 0;
        BankAccountLedgerEntry.Open := false;
        BankAccountLedgerEntry."Statement Status" := BankAccountLedgerEntry."Statement Status"::Closed;
        BankAccountLedgerEntry."Closed at Date" := StatementDate;
        BankAccountLedgerEntry."Statement No." := PostedStamentNo;
        BankAccountLedgerEntry."Statement Line No." := StatementLineNo;
        BankAccountLedgerEntry.Modify();

        CheckLedgerEntry.Reset();
        CheckLedgerEntry.SetCurrentKey("Bank Account Ledger Entry No.");
        CheckLedgerEntry.SetRange(
          "Bank Account Ledger Entry No.", BankAccountLedgerEntry."Entry No.");
        CheckLedgerEntry.SetRange(Open, true);
        if CheckLedgerEntry.FindSet() then
            repeat
                CheckLedgerEntry.Open := false;
                CheckLedgerEntry."Statement Status" := CheckLedgerEntry."Statement Status"::Closed;
                CheckLedgerEntry.Modify();
            until CheckLedgerEntry.Next() = 0;
    end;

    // taken from standard BC
    local procedure GetPostedStamentNo(BankAccRecon: Record "Bank Acc. Reconciliation") StatementNo: Code[20]
    var
        BankAccStmt: Record "Bank Account Statement";
    begin
        StatementNo := BankAccRecon."Statement No.";

        BankAccStmt.SetRange("Bank Account No.", BankAccRecon."Bank Account No.");
        BankAccStmt.SetRange("Statement No.", BankAccRecon."Statement No.");
        if not BankAccStmt.IsEmpty() then
            StatementNo := GetNextStatementNoAndUpdateBankAccount(BankAccRecon."Bank Account No.");
    end;

    // taken from standard BC
    local procedure GetNextStatementNoAndUpdateBankAccount(BankAccountNo: Code[20]): Code[20]
    var
        BankAccount: Record "Bank Account";
    begin
        BankAccount.SetLoadFields("Last Statement No.");
        BankAccount.Get(BankAccountNo);
        if BankAccount."Last Statement No." <> '' then
            BankAccount."Last Statement No." := IncStr(BankAccount."Last Statement No.")
        else
            BankAccount."Last Statement No." := '1';
        BankAccount.Modify();
        exit(BankAccount."Last Statement No.");
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Bank Acc. Reconciliation Post", OnCloseBankAccLedgEntryOnBeforeBankAccLedgEntryModify, '', false, false)]
    local procedure OnCloseBankAccLedgEntryOnBeforeBankAccLedgEntryModify(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line")
    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
    begin
        BankAccReconciliation.Reset();
        IF BankAccReconciliation.GET(BankAccReconciliationLine."Statement Type", BankAccReconciliationLine."Bank Account No.", BankAccReconciliationLine."Statement No.") then
            BankAccountLedgerEntry."Statement No. Imported FND" := BankAccReconciliation."Statement No. Imported FND";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Bank Acc. Reconciliation Post", OnPostPaymentApplicationsOnAfterInitGenJnlLine, '', false, false)]
    local procedure OnPostPaymentApplicationsOnAfterInitGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line"; var IsApplied: Boolean; var AppliedAmount: Decimal; var PaymentLineAmount: Decimal; var IsHandled: Boolean)
    var
        BankAcc: Record "Bank Account";
        BankAccountPostingGroup: Record "Bank Account Posting Group";
        PostNotMatched: Boolean;
    begin
        PostNotMatched := false;
        //HEI.01>>
        BankAcc.Get(BankAccReconciliationLine."Bank Account No.");
        if BankAcc."SuspnsAcc. for Paym.Reconc FND" then begin
            BankAcc.TestField("Bank Acc. Posting Group");
            BankAccountPostingGroup.Get(BankAcc."Bank Acc. Posting Group");
            BankAccountPostingGroup.TestField("AR Suspense Account FND");
            BankAccountPostingGroup.TestField("AP Suspense Account FND");
            BankAccReconciliationLine.CalcFields("Match Confidence");
            PostNotMatched := (BankAccReconciliationLine."Account Type" = BankAccReconciliationLine."Account Type"::"G/L Account")
              and (BankAccReconciliationLine."Match Confidence" = BankAccReconciliationLine."Match Confidence"::Manual);
        end;
        //HEI.01<<

        //HEI.01>>
        if BankAcc."SuspnsAcc. for Paym.Reconc FND" then
            if PostNotMatched then begin
                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                GenJournalLine."Bal. Account No." := BankAccountPostingGroup."AR Suspense Account FND";
            end;
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Bank Acc. Reconciliation Post", OnPostPaymentApplicationsOnAccountTypeCaseElse, '', false, false)]
    local procedure OnPostPaymentApplicationsOnAccountTypeCaseElse(var AppliedPaymentEntry: Record "Applied Payment Entry"; var GenJournalLine: Record "Gen. Journal Line")
    var
        BankAcc: Record "Bank Account";
        BankAccReconLine: Record "Bank Acc. Reconciliation Line";
        CLE: Record "Cust. Ledger Entry";
        VLE: Record "Vendor Ledger Entry";
        BankAccountPostingGroup: Record "Bank Account Posting Group";
        RemAmt: Decimal;
        ToleranceAmount: Decimal;
    begin
        if BankAccReconLine.get(AppliedPaymentEntry."Statement Type", AppliedPaymentEntry."Bank Account No.", AppliedPaymentEntry."Statement No.", AppliedPaymentEntry."Statement Line No.") then
            if BankAcc.Get(BankAccReconLine."Bank Account No.") then begin
                case AppliedPaymentEntry."Account Type" of
                    AppliedPaymentEntry."Account Type"::Customer:
                        begin
                            //HEI.01
                            if BankAcc."SuspnsAcc. for Paym.Reconc FND" then
                                if BankAccReconLine."Statement Amount" = 0 then begin
                                    if CLE.Get(AppliedPaymentEntry."Applies-to Entry No.") then begin
                                        ToleranceAmount += CLE."Max. Payment Tolerance";
                                        CLE.CalcFields("Remaining Amount");
                                        RemAmt += CLE."Remaining Amount";
                                    end;
                                end;
                            //HEI.01
                        end;
                    AppliedPaymentEntry."Account Type"::Vendor:
                        begin
                            //HEI.01
                            if BankAcc."SuspnsAcc. for Paym.Reconc FND" then
                                if VLE.Get(AppliedPaymentEntry."Applies-to Entry No.") then begin
                                    ToleranceAmount += VLE."Max. Payment Tolerance";
                                    VLE.CalcFields("Remaining Amount");
                                    RemAmt += VLE."Remaining Amount";
                                end;
                            //HEI.01
                        end;
                end;
                if BankAcc."SuspnsAcc. for Paym.Reconc FND" then begin
                    GenJournalLine.Amount := -BankAccReconLine."Statement Amount";//HEI.01
                    //HEI.01>>
                    if abs(RemAmt) - abs(BankAccReconLine."Statement Amount") > abs(ToleranceAmount) then begin
                        //GenJnlLine."Applies-to ID" := '';
                        BankAccountPostingGroup.Get(BankAcc."Bank Acc. Posting Group");
                        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := BankAccountPostingGroup."AR Suspense Account FND";
                    end;
                end;
                //HEI.01<<
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Bank Acc. Reconciliation Post", OnBeforeApplyCustLedgEntry, '', false, false)]
    local procedure OnBeforeApplyCustLedgEntry(var CustLedgerEntry: Record "Cust. Ledger Entry"; AppliedPaymentEntry: Record "Applied Payment Entry"; var BankAccount: Record "Bank Account"; AppliesToID: Code[50]; PostingDate: Date; PmtDiscDueDate: Date; PmtDiscToleranceDate: Date; RemPmtDiscPossible: Decimal; var IsHandled: Boolean)
    begin
        //HEI.01
        if BankAccount."SuspnsAcc. for Paym.Reconc FND" then begin
            CustLedgerEntry.CalcFields("Remaining Amount");
            if CustLedgerEntry."Remaining Amount" - CustLedgerEntry."Amount to Apply" <= CustLedgerEntry."Max. Payment Tolerance" then begin
                CustLedgerEntry."Accepted Payment Tolerance" := CustLedgerEntry."Remaining Amount" - CustLedgerEntry."Amount to Apply";
                CustLedgerEntry."Amount to Apply" := CustLedgerEntry."Accepted Payment Tolerance" + CustLedgerEntry."Amount to Apply";
            end;
        end;
        //HEI.01
    end;

    // changes to ApplyVendLedgEntry from CU 370 -> to be done after Microsoft will implement the proper
    // event in BC for applying vendor ledger entry in payment reconciliation process
    // https://github.com/microsoft/ALAppExtensions/issues/29597

    // BC Upgrade POENAB02 << 
    // BC Upgrade BHARDA11 >> ----We have used this event so that we can replace the old reports with new reports.
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnSubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = Report::"Fixed Asset - Book Value 01" then
            NewReportId := Report::"Fixed Asset - Book Value 01New";
        if ReportId = Report::"Fixed Asset - Book Value 02" then
            NewReportId := Report::"Fixed Asset - Book Value 02New";
    end;
    // BC Upgrade BHARDA11 << ----We have used this event so that we can replace the old reports with new reports.

    // BC UPGRADE PATELS08 >> ----------- Codeunit 1255 Match Bank Payments

    // HEI.01 PURGAP05 IBM LAZARE02 27.07.2017 # Extend City variable to 35 and Address variable to 120 in RelatedPartyInfoMatching function

    // BC UPGRADE PATELS08 << 
    // Added Tag HEI.01 to the documentation.
    // Added Global variables BankAccReconciliationLine2, BankAccReconciliationLineTmp
    // BC UPGRADE PATELS08 << 


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Match Bank Payments", 'OnAfterCode', '', false, false)]
    local procedure OnAfterCodeProcedure(var BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line")
    begin
        //soicad>>
        CLEAR(BankAccReconciliationLineTmp);
        IF BankAccReconciliationLineTmp.FINDSET THEN
            REPEAT
                CLEAR(BankAccReconciliationLine);
                BankAccReconciliationLine.GET(BankAccReconciliationLineTmp."Statement Type", BankAccReconciliationLineTmp."Bank Account No.",
                    BankAccReconciliationLineTmp."Statement No.", BankAccReconciliationLineTmp."Statement Line No.");
                IF BankAccReconciliationLine."Account No." = '' THEN BEGIN
                    BankAccReconciliationLine.VALIDATE("Account Type", BankAccReconciliationLineTmp."Account Type");
                    BankAccReconciliationLine.VALIDATE("Account No.", BankAccReconciliationLineTmp."Account No.");
                    BankAccReconciliationLine."IBAN Matched FND" := BankAccReconciliationLineTmp."IBAN Matched FND";
                    BankAccReconciliationLine.MODIFY;
                END;
            UNTIL BankAccReconciliationLineTmp.NEXT = 0;
        CLEAR(BankAccReconciliationLineTmp);
        IF BankAccReconciliationLineTmp.FINDSET THEN
            REPEAT
                CLEAR(BankAccReconciliationLine);
                BankAccReconciliationLine.GET(BankAccReconciliationLineTmp."Statement Type", BankAccReconciliationLineTmp."Bank Account No.",
                    BankAccReconciliationLineTmp."Statement No.", BankAccReconciliationLineTmp."Statement Line No.");
                BankAccReconciliationLine."IBAN Matched FND" := BankAccReconciliationLineTmp."IBAN Matched FND";
                BankAccReconciliationLine.MODIFY;
            UNTIL BankAccReconciliationLineTmp.NEXT = 0;
        //soicad<<

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Match Bank Payments", 'OnDisableBankLedgerEntriesMatch', '', false, false)]
    local procedure OnDisableBankLedgerEntriesMatchProcedure(var Disable: boolean; BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line")
    var
        BankAccount: Record "Bank Account"; // HEI.01
    begin
        // HEI.01 >>
        BankAccount.Get(BankAccReconciliationLine."Bank Account No.");
        Disable := BankAccount."IBAN Matching Criteria FND";
        // HEI.01 <<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Match Bank Payments", 'OnMapLedgerEntriesToStatementLinesOnAfterCalcTotalTimeTimeTextMappingsPerLine', '', false, false)]
    local procedure OnMapLedgerEntriesToStatementLinesOnAfterCalcTotalTimeTimeTextMappingsPerLineProcedure(var BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line"; var TempBankStatementMatchingBuffer: Record "Bank Statement Matching Buffer" temporary; var TotalTimeMatchingCustomerLedgerEntriesPerLine: Duration; var TotalTimeMatchingVendorLedgerEntriesPerLine: Duration; var TotalTimeMatchingEmployeeLedgerEntriesPerLine: Duration; var TotalTimeMatchingBankLedgerEntriesPerLine: Duration; var RelatedPartyMatchedInfoText: Text; LogInfoText: Boolean; var TotalTimeStringNearness: Duration; UsePaymentDiscounts: Boolean; OneToManyTempBankStatementMatchingBuffer: Record "Bank Statement Matching Buffer" temporary; var TempCustomerLedgerEntryMatchingBuffer: Record "Ledger Entry Matching Buffer" temporary; var TempVendorLedgerEntryMatchingBuffer: Record "Ledger Entry Matching Buffer" temporary; var TempEmployeeLedgerEntryMatchingBuffer: Record "Ledger Entry Matching Buffer" temporary; var TempBankAccLedgerEntryMatchingBuffer: Record "Ledger Entry Matching Buffer" temporary)
    begin
        // HEI.01 >>
        BankAccReconciliationLine."IBAN Matched FND" := FALSE;
        BankAccReconciliationLine.MODIFY();//soicad
        // HEI.01 <<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Match Bank Payments", 'OnUpdatePaymentMatchDetailsOnAfterBankAccReconciliationLine2SetFilters', '', false, false)]
    local procedure OnUpdatePaymentMatchDetailsOnAfterBankAccReconciliationLine2SetFiltersProcedure(var BankAccReconciliationLine2: Record "Bank Acc. Reconciliation Line"; var BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line")
    var
        AppliedPaymentEntry2: Record "Applied Payment Entry";
    begin
        //soicad01>>
        CLEAR(BankAccReconciliationLine2);
        BankAccReconciliationLine2.COPYFILTERS(BankAccReconciliationLine);
        IF BankAccReconciliationLine2.FINDSET THEN
            REPEAT
                IF BankAccReconciliationLine2."Account Type" = BankAccReconciliationLine2."Account Type"::Customer THEN BEGIN
                    BankAccReconciliationLine2.CALCFIELDS("Rem Amount FND");
                    IF BankAccReconciliationLine2."Rem Amount FND" = BankAccReconciliationLine2."Statement Amount" THEN BEGIN
                        AppliedPaymentEntry2.SETRANGE("Statement Type", BankAccReconciliationLine2."Statement Type");
                        AppliedPaymentEntry2.SETRANGE("Bank Account No.", BankAccReconciliationLine2."Bank Account No.");
                        AppliedPaymentEntry2.SETRANGE("Statement No.", BankAccReconciliationLine2."Statement No.");
                        AppliedPaymentEntry2.SETRANGE("Statement Line No.", BankAccReconciliationLine2."Statement Line No.");
                        IF AppliedPaymentEntry2.FINDSET THEN
                            REPEAT
                                AppliedPaymentEntry2.VALIDATE("Applied Amount", AppliedPaymentEntry2."Rem. Amount FND");
                                AppliedPaymentEntry2.MODIFY;
                            UNTIL AppliedPaymentEntry2.NEXT = 0;
                    END;
                END;
            UNTIL BankAccReconciliationLine2.NEXT = 0;
        CLEAR(BankAccReconciliationLine2);
        //soicad<<

        BankAccReconciliationLine2.COPYFILTERS(BankAccReconciliationLine);
    end;
    //Bc Upgrade YADAVM09 Bug fix BCUP0-29>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnInitGLEntryOnBeforeCheckGLAccDimError, '', false, false)]
    local procedure OnInitGLEntryOnBeforeCheckGLAccDimError(var GenJnlLine: Record "Gen. Journal Line"; var GLAcc: Record "G/L Account")
    var
        FinancialUtils: Codeunit "Financial-Utils";
    begin
        //HEI.39>>
        FinancialUtils.InsertDim2SkipDimCheck4SrcCodeWithSkip(GenJnlLine, GLAcc."No.");
        //HEI.39<<
    end;
    //Bc Upgrade YADAVM09 Bug fix BCUP0-29<<


    // BC UPGRADE PATELS08 << ----------- Codeunit 1255 Match Bank Payments 

    //Bc Upgrade YADAVM09 BCUP0-140>>
    [EventSubscriber(ObjectType::Page, page::"Analysis by Dimensions Matrix", OnAfterSetCommonFilters, '', false, false)]
    local procedure OnAfterSetCommonFilters(var AnalysisViewEntry: Record "Analysis View Entry"; AnalysisByDimParameters: Record "Analysis by Dim. Parameters")
    var
        SPreview: codeunit "Levy Preview Custom RTR";
    begin
        SPreview.SetAnalysisViewCode(AnalysisByDimParameters."Analysis View Code");
        SPreview.SetValueforGLaccountCil3(AnalysisByDimParameters."Account Filter");//Bc Upgrade YADAVM09 BCUP0-140<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Item Analysis Management", OnAfterSetCommonFilters, '', false, false)]
    local procedure OnAfterSetCommonFilters1(CurrentAnalysisArea: Enum "Analysis Area Type"; var ItemStatisticsBuffer: Record "Item Statistics Buffer"; CurrentAnalysisViewCode: Code[10])
    var
        SPreview: codeunit "Levy Preview Custom RTR";
    begin
        SPreview.SetAnalysisViewCode(CurrentAnalysisViewCode);
    end;
    //Bc Upgrade YADAVM09 BCUP0-140<<
    //Bc Upgrade YADAVM09 BCUP0-124>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforePostVAT, '', false, false)]
    local procedure OnBeforePostVAT(var GenJnlLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; VATPostingSetup: Record "VAT Posting Setup"; var IsHandled: Boolean; var AddCurrGLEntryVATAmt: Decimal; var NextConnectionNo: Integer; var TaxDetail: Record "Tax Detail")
    var
        GLSetup: Record "General Ledger Setup";
        SourceCodeSetup: Record "Source Code Setup";
    begin
        GLSetup.Get();
        SourceCodeSetup.Get();
        if (GLSetup."VAT Exchange Rate Adjustment" = GLSetup."VAT Exchange Rate Adjustment"::"No Adjustment") and
           (GLEntry."Source Code" = SourceCodeSetup."Exchange Rate Adjmt.") then
            IsHandled := true;
    end;
    //Bc Upgrade YADAVM09 BCUP0-124<<
}
