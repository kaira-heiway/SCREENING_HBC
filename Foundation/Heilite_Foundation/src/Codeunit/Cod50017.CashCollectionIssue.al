codeunit 50017 "Cash Collection-Issue"
{
    // version NAVW110.0

    // HEI.01 FDD-HNK-HeiliteBASE-OTCGAP030 IBM ISYED01 05/07/2017
    //   # Update table Issued Reminder Line with data for Disputed and Disputed Reason Code.

    // BC Upgrade PATELP08 >>
    // Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
    // Changed the AccType parameter datatype from Integer to Enum ("Gen. Journal Account Type") to align with the calling functions where an enum value is passed, resolving the warning in InitGenJnlLine procedure.
    // BC Upgrade PATELP08 <<

    Permissions = TableData "Cust. Ledger Entry" = rm,
                  TableData "Issued Reminder Header" = rimd,
                  TableData "Issued Reminder Line" = rimd,
                  TableData "Reminder/Fin. Charge Entry" = rimd;

    trigger OnRun();
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        Cust: Record Customer;
    begin
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
        //HEI.01>>
        // with CashCollectionHeader do begin
        //     CashCollectionHeader.UpdateReminderRounding(CashCollectionHeader);
        //     if (PostingDate <> 0D) and (ReplacePostingDate or ("Posting Date" = 0D)) then
        //         VALIDATE("Posting Date", PostingDate);
        //     TESTFIELD("Customer No.");
        //     Cust.GET("Customer No.");
        //     if Cust.Blocked = Cust.Blocked::All then
        //         ERROR(Text004, Cust.FIELDCAPTION(Blocked), Cust.Blocked, Cust.TABLECAPTION, "Customer No.");

        //     TESTFIELD("Posting Date");
        //     TESTFIELD("Document Date");
        //     TESTFIELD("Due Date");
        //     TESTFIELD("Customer Posting Group");
        //     if not DimMgt.CheckDimIDComb("Dimension Set ID") then
        //         ERROR(
        //           DimensionCombinationIsBlockedErr,
        //           TABLECAPTION, "No.", DimMgt.GetDimCombErr());

        //     TableID[1] := DATABASE::Customer;
        //     No[1] := "Customer No.";
        //     if not DimMgt.CheckDimValuePosting(TableID, No, "Dimension Set ID") then
        //         ERROR(
        //           Text003,
        //           TABLECAPTION, "No.", DimMgt.GetDimValuePostingErr());

        //     CustPostingGr.GET("Customer Posting Group");
        //     CALCFIELDS("Interest Amount", "Additional Fee", "Remaining Amount", "Add. Fee per Line");
        //     if ("Interest Amount" = 0) and ("Additional Fee" = 0) and ("Add. Fee per Line" = 0) and ("Remaining Amount" = 0) then
        //         ERROR(Text000);
        //     SourceCodeSetup.GET();
        //     SourceCodeSetup.TESTFIELD(Reminder);
        //     SrcCode := SourceCodeSetup.Reminder;

        //     if ("Issuing No." = '') and ("No. Series" <> "Issuing No. Series") then begin
        //         TESTFIELD("Issuing No. Series");
        //         "Issuing No." := NoSeriesMgt.GetNextNo("Issuing No. Series", "Posting Date", true);
        //         MODIFY();
        //         COMMIT();
        //     end;
        //     if "Issuing No." <> '' then
        //         DocNo := "Issuing No."
        //     else
        //         DocNo := "No.";

        //     CashCollectionLine.SETRANGE("Cash Collection No.", "No.");
        //     if CashCollectionLine.FIND('-') then
        //         repeat
        //             case CashCollectionLine.Type of
        //                 CashCollectionLine.Type::" ":
        //                     CashCollectionLine.TESTFIELD(Amount, 0);
        //                 /*CashCollectionLine.Type::"Customer Ledger Entry":
        //                   IF "Post Additional Fee" THEN
        //                     InsertGenJnlLineForFee(CashCollectionLine);*/
        //                 CashCollectionLine.Type::"Customer Ledger Entry":
        //                     begin
        //                         CashCollectionLine.TESTFIELD("Entry No.");
        //                         ReminderInterestAmount := ReminderInterestAmount + CashCollectionLine.Amount;
        //                         ReminderInterestVATAmount := ReminderInterestVATAmount + CashCollectionLine."VAT Amount";
        //                     end;
        //             /*CashCollectionLine.Type::"3":
        //               IF "Post Add. Fee per Line" THEN BEGIN
        //                 CheckLineFee(CashCollectionLine,CashCollectionHeader);
        //                 InsertGenJnlLineForFee(CashCollectionLine);
        //               end;*/
        //             end;
        //         until CashCollectionLine.NEXT() = 0;

        //     if (ReminderInterestAmount <> 0) and "Post Interest" then begin
        //         if ReminderInterestAmount < 0 then
        //             ERROR(Text001);
        //         CustPostingGr.TESTFIELD("Interest Account");
        //         InitGenJnlLine(GenJnlLine."Account Type"::"G/L Account", CustPostingGr."Interest Account", true);
        //         GenJnlLine.VALIDATE("VAT Bus. Posting Group", "VAT Bus. Posting Group");
        //         GenJnlLine.VALIDATE(Amount, -ReminderInterestAmount - ReminderInterestVATAmount);
        //         GenJnlLine.UpdateLineBalance();
        //         TotalAmount := TotalAmount - GenJnlLine.Amount;
        //         TotalAmountLCY := TotalAmountLCY - GenJnlLine."Balance (LCY)";
        //         GenJnlLine."Bill-to/Pay-to No." := "Customer No.";
        //         GenJnlLine.INSERT();
        //     end;

        //     if (TotalAmount <> 0) or (TotalAmountLCY <> 0) then begin
        //         InitGenJnlLine(GenJnlLine."Account Type"::Customer, "Customer No.", true);
        //         GenJnlLine.VALIDATE(Amount, TotalAmount);
        //         GenJnlLine.VALIDATE("Amount (LCY)", TotalAmountLCY);
        //         GenJnlLine.INSERT();
        //     end;

        //     CLEAR(GenJnlPostLine);
        //     if GenJnlLine.FIND('-') then
        //         repeat
        //             GenJnlLine2 := GenJnlLine;
        //             GenJnlLine2."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
        //             GenJnlLine2."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
        //             GenJnlLine2."Dimension Set ID" := "Dimension Set ID";
        //             GenJnlPostLine.RUN(GenJnlLine2);
        //         until GenJnlLine.NEXT() = 0;

        //     GenJnlLine.DELETEALL();

        //     if (ReminderInterestAmount <> 0) and "Post Interest" then begin
        //         TESTFIELD("Fin. Charge Terms Code");
        //         FinChrgTerms.GET("Fin. Charge Terms Code");
        //         if FinChrgTerms."Interest Calculation" in
        //            [FinChrgTerms."Interest Calculation"::"Closed Entries",
        //             FinChrgTerms."Interest Calculation"::"All Entries"]
        //         then begin
        //             CashCollectionLine.SETRANGE(Type, CashCollectionLine.Type::"Customer Ledger Entry");
        //             if CashCollectionLine.FIND('-') then
        //                 repeat
        //                     CustLedgEntry.GET(CashCollectionLine."Entry No.");
        //                     CustLedgEntry.TESTFIELD("Currency Code", "Currency Code");
        //                     CustLedgEntry.CALCFIELDS("Remaining Amount");
        //                     if CustLedgEntry."Remaining Amount" = 0 then begin
        //                         CustLedgEntry."Calculate Interest" := false;
        //                         CustLedgEntry.MODIFY();
        //                     end;
        //                     CustLedgEntry2.SETCURRENTKEY("Closed by Entry No.");
        //                     CustLedgEntry2.SETRANGE("Closed by Entry No.", CustLedgEntry."Entry No.");
        //                     CustLedgEntry2.SETRANGE("Closing Interest Calculated", false);
        //                     CustLedgEntry2.MODIFYALL("Closing Interest Calculated", true);
        //                 until CashCollectionLine.NEXT() = 0;
        //             CashCollectionLine.SETRANGE(Type);
        //         end;
        //     end;

        //     IssuedCashCollectionHeader.TRANSFERFIELDS(CashCollectionHeader);
        //     IssuedCashCollectionHeader."No." := DocNo;
        //     IssuedCashCollectionHeader."Pre-Assigned No." := "No.";
        //     IssuedCashCollectionHeader."Source Code" := SrcCode;
        //     IssuedCashCollectionHeader."User ID" := USERID;
        //     IssuedCashCollectionHeader.TESTFIELD("Shipping Agent Code");
        //     //BC Upgrade Manisha Drink it field commented
        //     // IssuedCashCollectionHeader."Truck Code" := CashCollectionHeader."Truck Code";
        //     // IssuedCashCollectionHeader."Driver Code" := CashCollectionHeader."Driver Code";
        //     //BC Upgrade Manisha Drink it field commented
        //     IssuedCashCollectionHeader."Shipping Agent Code" := CashCollectionHeader."Shipping Agent Code";
        //     IssuedCashCollectionHeader.INSERT();

        //     if NextEntryNo = 0 then begin
        //     end;
        //     CashCollectionCommentLine.SETRANGE(Type, CashCollectionCommentLine.Type::"Cash Collection");
        //     CashCollectionCommentLine.SETRANGE("No.", "No.");
        //     if CashCollectionCommentLine.FIND('-') then
        //         repeat
        //             CashCollectionCommentLine2.TRANSFERFIELDS(CashCollectionCommentLine);
        //             CashCollectionCommentLine2.Type := CashCollectionCommentLine2.Type::"Issued Cash Collection";
        //             CashCollectionCommentLine2."No." := IssuedCashCollectionHeader."No.";
        //             CashCollectionCommentLine2.INSERT();
        //         until CashCollectionCommentLine.NEXT() = 0;
        //     CashCollectionCommentLine.DELETEALL();

        //     if CashCollectionLine.FIND('-') then
        //         repeat
        //             if (CashCollectionLine.Type = CashCollectionLine.Type::"Customer Ledger Entry") and
        //                (CashCollectionLine."Entry No." <> 0)
        //             then begin
        //                 NextEntryNo := NextEntryNo + 1;
        //             end;
        //             IssuedCashCollectionLine.TRANSFERFIELDS(CashCollectionLine);
        //             IssuedCashCollectionLine."Cash Collection No." := IssuedCashCollectionHeader."No.";
        //             IssuedCashCollectionLine.Disputed := CashCollectionLine.Disputed;
        //             IssuedCashCollectionLine."Disputed Reason code" := CashCollectionLine."Disputed Reason code";

        //             IssuedCashCollectionLine.INSERT();
        //         until CashCollectionLine.NEXT() = 0;
        //     CashCollectionLine.DELETEALL();
        //     DELETE();
        // end;
        //HEI.01<<
        CashCollectionHeader.UpdateReminderRounding(CashCollectionHeader);
        if (PostingDate <> 0D) and (ReplacePostingDate or (CashCollectionHeader."Posting Date" = 0D)) then
            CashCollectionHeader.VALIDATE("Posting Date", PostingDate);
        CashCollectionHeader.TESTFIELD("Customer No.");
        Cust.GET(CashCollectionHeader."Customer No.");
        if Cust.Blocked = Cust.Blocked::All then
            ERROR(Text004, Cust.FIELDCAPTION(Blocked), Cust.Blocked, Cust.TABLECAPTION, CashCollectionHeader."Customer No.");

        CashCollectionHeader.TESTFIELD("Posting Date");
        CashCollectionHeader.TESTFIELD("Document Date");
        CashCollectionHeader.TESTFIELD("Due Date");
        CashCollectionHeader.TESTFIELD("Customer Posting Group");
        if not DimMgt.CheckDimIDComb(CashCollectionHeader."Dimension Set ID") then
            ERROR(
                DimensionCombinationIsBlockedErr,
                CashCollectionHeader.TABLECAPTION, CashCollectionHeader."No.", DimMgt.GetDimCombErr());

        TableID[1] := DATABASE::Customer;
        No[1] := CashCollectionHeader."Customer No.";
        if not DimMgt.CheckDimValuePosting(TableID, No, CashCollectionHeader."Dimension Set ID") then
            ERROR(
                Text003,
                CashCollectionHeader.TABLECAPTION, CashCollectionHeader."No.", DimMgt.GetDimValuePostingErr());

        CustPostingGr.GET(CashCollectionHeader."Customer Posting Group");
        CashCollectionHeader.CALCFIELDS("Interest Amount", "Additional Fee", "Remaining Amount", "Add. Fee per Line");
        if (CashCollectionHeader."Interest Amount" = 0) and (CashCollectionHeader."Additional Fee" = 0) and (CashCollectionHeader."Add. Fee per Line" = 0) and (CashCollectionHeader."Remaining Amount" = 0) then
            ERROR(Text000);
        SourceCodeSetup.GET();
        SourceCodeSetup.TESTFIELD(Reminder);
        SrcCode := SourceCodeSetup.Reminder;

        if (CashCollectionHeader."Issuing No." = '') and (CashCollectionHeader."No. Series" <> CashCollectionHeader."Issuing No. Series") then begin
            CashCollectionHeader.TESTFIELD("Issuing No. Series");
            CashCollectionHeader."Issuing No." := NoSeriesMgt.GetNextNo(CashCollectionHeader."Issuing No. Series", CashCollectionHeader."Posting Date", true);
            CashCollectionHeader.MODIFY();
            COMMIT();
        end;
        if CashCollectionHeader."Issuing No." <> '' then
            DocNo := CashCollectionHeader."Issuing No."
        else
            DocNo := CashCollectionHeader."No.";

        CashCollectionLine.SETRANGE("Cash Collection No.", CashCollectionHeader."No.");
        if CashCollectionLine.FIND('-') then
            repeat
                case CashCollectionLine.Type of
                    CashCollectionLine.Type::" ":
                        CashCollectionLine.TESTFIELD(Amount, 0);
                    /*CashCollectionLine.Type::"Customer Ledger Entry":
                        IF "Post Additional Fee" THEN
                        InsertGenJnlLineForFee(CashCollectionLine);*/
                    CashCollectionLine.Type::"Customer Ledger Entry":
                        begin
                            CashCollectionLine.TESTFIELD("Entry No.");
                            ReminderInterestAmount := ReminderInterestAmount + CashCollectionLine.Amount;
                            ReminderInterestVATAmount := ReminderInterestVATAmount + CashCollectionLine."VAT Amount";
                        end;
                /*CashCollectionLine.Type::"3":
                    IF "Post Add. Fee per Line" THEN BEGIN
                    CheckLineFee(CashCollectionLine,CashCollectionHeader);
                    InsertGenJnlLineForFee(CashCollectionLine);
                    end;*/
                end;
            until CashCollectionLine.NEXT() = 0;

        if (ReminderInterestAmount <> 0) and CashCollectionHeader."Post Interest" then begin
            if ReminderInterestAmount < 0 then
                ERROR(Text001);
            CustPostingGr.TESTFIELD("Interest Account");
            InitGenJnlLine(GenJnlLine."Account Type"::"G/L Account", CustPostingGr."Interest Account", true);
            GenJnlLine.VALIDATE("VAT Bus. Posting Group", CashCollectionHeader."VAT Bus. Posting Group");
            GenJnlLine.VALIDATE(Amount, -ReminderInterestAmount - ReminderInterestVATAmount);
            GenJnlLine.UpdateLineBalance();
            TotalAmount := TotalAmount - GenJnlLine.Amount;
            TotalAmountLCY := TotalAmountLCY - GenJnlLine."Balance (LCY)";
            GenJnlLine."Bill-to/Pay-to No." := CashCollectionHeader."Customer No.";
            GenJnlLine.INSERT();
        end;

        if (TotalAmount <> 0) or (TotalAmountLCY <> 0) then begin
            InitGenJnlLine(GenJnlLine."Account Type"::Customer, CashCollectionHeader."Customer No.", true);
            GenJnlLine.VALIDATE(Amount, TotalAmount);
            GenJnlLine.VALIDATE("Amount (LCY)", TotalAmountLCY);
            GenJnlLine.INSERT();
        end;

        CLEAR(GenJnlPostLine);
        if GenJnlLine.FIND('-') then
            repeat
                GenJnlLine2 := GenJnlLine;
                GenJnlLine2."Shortcut Dimension 1 Code" := CashCollectionHeader."Shortcut Dimension 1 Code";
                GenJnlLine2."Shortcut Dimension 2 Code" := CashCollectionHeader."Shortcut Dimension 2 Code";
                GenJnlLine2."Dimension Set ID" := CashCollectionHeader."Dimension Set ID";
                GenJnlPostLine.RUN(GenJnlLine2);
            until GenJnlLine.NEXT() = 0;

        GenJnlLine.DELETEALL();

        if (ReminderInterestAmount <> 0) and CashCollectionHeader."Post Interest" then begin
            CashCollectionHeader.TESTFIELD("Fin. Charge Terms Code");
            FinChrgTerms.GET(CashCollectionHeader."Fin. Charge Terms Code");
            if FinChrgTerms."Interest Calculation" in
                [FinChrgTerms."Interest Calculation"::"Closed Entries",
                FinChrgTerms."Interest Calculation"::"All Entries"]
            then begin
                CashCollectionLine.SETRANGE(Type, CashCollectionLine.Type::"Customer Ledger Entry");
                if CashCollectionLine.FIND('-') then
                    repeat
                        CustLedgEntry.GET(CashCollectionLine."Entry No.");
                        CustLedgEntry.TESTFIELD("Currency Code", CashCollectionHeader."Currency Code");
                        CustLedgEntry.CALCFIELDS("Remaining Amount");
                        if CustLedgEntry."Remaining Amount" = 0 then begin
                            CustLedgEntry."Calculate Interest" := false;
                            CustLedgEntry.MODIFY();
                        end;
                        CustLedgEntry2.SETCURRENTKEY("Closed by Entry No.");
                        CustLedgEntry2.SETRANGE("Closed by Entry No.", CustLedgEntry."Entry No.");
                        CustLedgEntry2.SETRANGE("Closing Interest Calculated", false);
                        CustLedgEntry2.MODIFYALL("Closing Interest Calculated", true);
                    until CashCollectionLine.NEXT() = 0;
                CashCollectionLine.SETRANGE(Type);
            end;
        end;

        IssuedCashCollectionHeader.TRANSFERFIELDS(CashCollectionHeader);
        IssuedCashCollectionHeader."No." := DocNo;
        IssuedCashCollectionHeader."Pre-Assigned No." := CashCollectionHeader."No.";
        IssuedCashCollectionHeader."Source Code" := SrcCode;
        IssuedCashCollectionHeader."User ID" := USERID;
        IssuedCashCollectionHeader.TESTFIELD("Shipping Agent Code");
        //BC Upgrade Manisha Drink it field commented
        // IssuedCashCollectionHeader."Truck Code" := CashCollectionHeader."Truck Code";
        // IssuedCashCollectionHeader."Driver Code" := CashCollectionHeader."Driver Code";
        //BC Upgrade Manisha Drink it field commented
        IssuedCashCollectionHeader."Shipping Agent Code" := CashCollectionHeader."Shipping Agent Code";
        IssuedCashCollectionHeader.INSERT();

        if NextEntryNo = 0 then begin
        end;
        CashCollectionCommentLine.SETRANGE(Type, CashCollectionCommentLine.Type::"Cash Collection");
        CashCollectionCommentLine.SETRANGE("No.", CashCollectionHeader."No.");
        if CashCollectionCommentLine.FIND('-') then
            repeat
                CashCollectionCommentLine2.TRANSFERFIELDS(CashCollectionCommentLine);
                CashCollectionCommentLine2.Type := CashCollectionCommentLine2.Type::"Issued Cash Collection";
                CashCollectionCommentLine2."No." := IssuedCashCollectionHeader."No.";
                CashCollectionCommentLine2.INSERT();
            until CashCollectionCommentLine.NEXT() = 0;
        CashCollectionCommentLine.DELETEALL();

        if CashCollectionLine.FIND('-') then
            repeat
                if (CashCollectionLine.Type = CashCollectionLine.Type::"Customer Ledger Entry") and
                    (CashCollectionLine."Entry No." <> 0)
                then begin
                    NextEntryNo := NextEntryNo + 1;
                end;
                IssuedCashCollectionLine.TRANSFERFIELDS(CashCollectionLine);
                IssuedCashCollectionLine."Cash Collection No." := IssuedCashCollectionHeader."No.";
                IssuedCashCollectionLine.Disputed := CashCollectionLine.Disputed;
                IssuedCashCollectionLine."Disputed Reason code" := CashCollectionLine."Disputed Reason code";

                IssuedCashCollectionLine.INSERT();
            until CashCollectionLine.NEXT() = 0;
        CashCollectionLine.DELETEALL();
        CashCollectionHeader.DELETE();
        // BC Upgrade PATELP08 <<
    end;

    var
        CashCollectionCommentLine: Record "Cash Collection Cmt Line FND";
        CashCollectionCommentLine2: Record "Cash Collection Cmt Line FND";
        CashCollectionHeader: Record "Cash Collection Header FND";
        CashCollectionLine: Record "Cash Collection Line FND";
        CustLedgEntry2: Record "Cust. Ledger Entry";
        CustPostingGr: Record "Customer Posting Group";
        FinChrgTerms: Record "Finance Charge Terms";
        GenJnlLine: Record "Gen. Journal Line" temporary;
        GenJnlLine2: Record "Gen. Journal Line";
        IssuedCashCollectionHeader: Record "Issue Cash Collection Head FND";
        IssuedCashCollectionLine: Record "Issue Cash Collection Line FND";
        SourceCode: Record "Source Code";
        SourceCodeSetup: Record "Source Code Setup";
        DimMgt: Codeunit DimensionManagement;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        // NoSeriesMgt: Codeunit NoSeriesManagement;  // BC Upgrade NANDIS03 - Blocked
        NoSeriesMgt: Codeunit "No. Series";  // BC Upgrade NANDIS03 - Added
        ReplacePostingDate: Boolean;
        SrcCode: Code[10];
        DocNo: Code[20];
        No: array[10] of Code[20];
        PostingDate: Date;
        ReminderInterestAmount: Decimal;
        ReminderInterestVATAmount: Decimal;
        TotalAmount: Decimal;
        TotalAmountLCY: Decimal;
        NextEntryNo: Integer;
        TableID: array[10] of Integer;
        AppliesToDocErr: Label 'Line Fee has to be applied to an open overdue document.';
        DimensionCombinationIsBlockedErr: Label 'The combination of dimensions used in %1 %2 is blocked. %3.', Comment = '"%1: TABLECAPTION(Reminder Header)';
        Text000: Label 'There is nothing to issue.';
        Text001: Label 'Interests must be positive or 0';
        Text003: Label 'A dimension used in %1 %2 has caused an error. %3';
        Text004: Label '%1 must not be %2 in %3 %4';
        EntryNotOverdueErr: TextConst Comment = '%1 = Document Type, %2 = Document No., %3 = Table name. E.g. Invoice 12313 in Cust. Ledger Entry is not overdue.', ENU = '%1 %2 in %3 is not overdue.';
        LineFeeAlreadyIssuedErr: TextConst Comment = '%1 = Document Type, %2 = Document No. %3 = Reminder Level. E.g. The Line Fee for Invoice 141232 on reminder level 2 has already been issued.', ENU = 'The Line Fee for %1 %2 on reminder level %3 has already been issued.';
        LineFeeAmountErr: TextConst Comment = '%1 = Document Type, %2 = Document No.. E.g. Line Fee amount must be positive and non-zero for Line Fee applied to Invoice 102421', ENU = 'Line Fee amount must be positive and non-zero for Line Fee applied to %1 %2.';
        MultipleLineFeesSameDocErr: TextConst Comment = '%1 = Document Type, %2 = Document No. E.g. You cannot issue multiple line fees for the same level for the same document. Error with line fees for Invoice 1312312.', ENU = 'You cannot issue multiple line fees for the same level for the same document. Error with line fees for %1 %2.';

    procedure Set(var NewCashCollectionHeader: Record "Cash Collection Header FND"; NewReplacePostingDate: Boolean; NewPostingDate: Date);
    begin
        //HEI.01>>
        CashCollectionHeader := NewCashCollectionHeader;
        ReplacePostingDate := NewReplacePostingDate;
        PostingDate := NewPostingDate;
        //HEI.01<<
    end;

    procedure GetIssuedReminder(var NewIssuedCashCollectionHeader: Record "Issue Cash Collection Head FND");
    begin
        //HEI.01>>
        NewIssuedCashCollectionHeader := IssuedCashCollectionHeader;
        //HEI.01<<
    end;
    // BC Upgrade PATELP08 >> Changed the AccType parameter datatype from Integer to Enum ("Gen. Journal Account Type") to align with the calling functions where an enum value is passed, resolving the warning.
    // local procedure InitGenJnlLine(AccType: Integer; AccNo: Code[20]; SystemCreatedEntry: Boolean);
    local procedure InitGenJnlLine(AccType: Enum "Gen. Journal Account Type"; AccNo: Code[20]; SystemCreatedEntry: Boolean);
    // BC Upgrade PATELP08 <<
    begin
        //HEI.01>>
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
        // with CashCollectionHeader do begin
        //     GenJnlLine.INIT();
        //     GenJnlLine."Line No." := GenJnlLine."Line No." + 1;
        //     GenJnlLine."Document Type" := GenJnlLine."Document Type"::Reminder;
        //     GenJnlLine."Document No." := DocNo;
        //     GenJnlLine."Posting Date" := "Posting Date";
        //     GenJnlLine."Document Date" := "Document Date";
        //     GenJnlLine."Account Type" := AccType;
        //     GenJnlLine."Account No." := AccNo;
        //     GenJnlLine.VALIDATE("Account No.");
        //     if GenJnlLine."Account Type" = GenJnlLine."Account Type"::"G/L Account" then begin
        //         GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::Sale;
        //         GenJnlLine."Gen. Bus. Posting Group" := "Gen. Bus. Posting Group";
        //         GenJnlLine."VAT Bus. Posting Group" := "VAT Bus. Posting Group";
        //     end;
        //     GenJnlLine.VALIDATE("Currency Code", "Currency Code");
        //     if GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer then begin
        //         GenJnlLine.VALIDATE(Amount, TotalAmount);
        //         GenJnlLine.VALIDATE("Amount (LCY)", TotalAmountLCY);
        //         GenJnlLine."Due Date" := "Due Date";
        //     end;
        //     GenJnlLine.Description := "Posting Description";
        //     GenJnlLine."Source Type" := GenJnlLine."Source Type"::Customer;
        //     GenJnlLine."Source No." := "Customer No.";
        //     GenJnlLine."Source Code" := SrcCode;
        //     GenJnlLine."Reason Code" := "Reason Code";
        //     GenJnlLine."System-Created Entry" := SystemCreatedEntry;
        //     GenJnlLine."Posting No. Series" := "Issuing No. Series";
        //     GenJnlLine."Salespers./Purch. Code" := '';
        // end;
        GenJnlLine.INIT();
        GenJnlLine."Line No." := GenJnlLine."Line No." + 1;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Reminder;
        GenJnlLine."Document No." := DocNo;
        GenJnlLine."Posting Date" := CashCollectionHeader."Posting Date";
        GenJnlLine."Document Date" := CashCollectionHeader."Document Date";
        GenJnlLine."Account Type" := AccType;
        GenJnlLine."Account No." := AccNo;
        GenJnlLine.VALIDATE("Account No.");
        if GenJnlLine."Account Type" = GenJnlLine."Account Type"::"G/L Account" then begin
            GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::Sale;
            GenJnlLine."Gen. Bus. Posting Group" := CashCollectionHeader."Gen. Bus. Posting Group";
            GenJnlLine."VAT Bus. Posting Group" := CashCollectionHeader."VAT Bus. Posting Group";
        end;
        GenJnlLine.VALIDATE("Currency Code", CashCollectionHeader."Currency Code");
        if GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer then begin
            GenJnlLine.VALIDATE(Amount, TotalAmount);
            GenJnlLine.VALIDATE("Amount (LCY)", TotalAmountLCY);
            GenJnlLine."Due Date" := CashCollectionHeader."Due Date";
        end;
        GenJnlLine.Description := CashCollectionHeader."Posting Description";
        GenJnlLine."Source Type" := GenJnlLine."Source Type"::Customer;
        GenJnlLine."Source No." := CashCollectionHeader."Customer No.";
        GenJnlLine."Source Code" := SrcCode;
        GenJnlLine."Reason Code" := CashCollectionHeader."Reason Code";
        GenJnlLine."System-Created Entry" := SystemCreatedEntry;
        GenJnlLine."Posting No. Series" := CashCollectionHeader."Issuing No. Series";
        GenJnlLine."Salespers./Purch. Code" := '';
        //HEI.01<<
        // BC Upgrade PATELP08 <<
    end;

    procedure DeleteIssuedReminderLines(IssuedCashCollectionHeader: Record "Issue Cash Collection Head FND");
    var
        IssuedReminderLine: Record "Issued Reminder Line";
    begin
        //HEI.01>>
        IssuedCashCollectionLine.SETRANGE("Cash Collection No.", IssuedCashCollectionHeader."No.");
        IssuedCashCollectionLine.DELETEALL();
        //HEI.01<<
    end;

    procedure IncrNoPrinted(var IssuedCashCollectionHeader: Record "Issue Cash Collection Head FND");
    begin
        //HEI.01>>
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
        // with IssuedCashCollectionHeader do begin
        //     FIND();
        //     "No. Printed" := "No. Printed" + 1;
        //     MODIFY();
        //     COMMIT();
        // end;
        IssuedCashCollectionHeader.FIND();
        IssuedCashCollectionHeader."No. Printed" := IssuedCashCollectionHeader."No. Printed" + 1;
        IssuedCashCollectionHeader.MODIFY();
        COMMIT();
        //HEI.01<<
        // BC Upgrade PATELP08 <<
    end;

    procedure TestDeleteHeader(CashCollectionHeader: Record "Cash Collection Header FND"; var IssuedCashCollectionHeader: Record "Issue Cash Collection Head FND");
    begin
        //HEI.01>>
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
        // with CashCollectionHeader do begin
        //     CLEAR(IssuedCashCollectionHeader);
        //     SourceCodeSetup.GET();
        //     SourceCodeSetup.TESTFIELD("Deleted Document");
        //     SourceCode.GET(SourceCodeSetup."Deleted Document");

        //     if ("Issuing No. Series" <> '') and
        //        (("Issuing No." <> '') or ("No. Series" = "Issuing No. Series"))
        //     then begin
        //         IssuedCashCollectionHeader.TRANSFERFIELDS(CashCollectionHeader);
        //         if "Issuing No." <> '' then
        //             IssuedCashCollectionHeader."No." := "Issuing No.";
        //         IssuedCashCollectionHeader."Pre-Assigned No. Series" := "No. Series";
        //         IssuedCashCollectionHeader."Pre-Assigned No." := "No.";
        //         IssuedCashCollectionHeader."Posting Date" := TODAY;
        //         IssuedCashCollectionHeader."User ID" := USERID;
        //         IssuedCashCollectionHeader."Source Code" := SourceCode.Code;
        //     end;
        // end;
        CLEAR(IssuedCashCollectionHeader);
        SourceCodeSetup.GET();
        SourceCodeSetup.TESTFIELD("Deleted Document");
        SourceCode.GET(SourceCodeSetup."Deleted Document");

        if (CashCollectionHeader."Issuing No. Series" <> '') and
            ((CashCollectionHeader."Issuing No." <> '') or (CashCollectionHeader."No. Series" = CashCollectionHeader."Issuing No. Series"))
        then begin
            IssuedCashCollectionHeader.TRANSFERFIELDS(CashCollectionHeader);
            if CashCollectionHeader."Issuing No." <> '' then
                IssuedCashCollectionHeader."No." := CashCollectionHeader."Issuing No.";
            IssuedCashCollectionHeader."Pre-Assigned No. Series" := CashCollectionHeader."No. Series";
            IssuedCashCollectionHeader."Pre-Assigned No." := CashCollectionHeader."No.";
            IssuedCashCollectionHeader."Posting Date" := TODAY;
            IssuedCashCollectionHeader."User ID" := USERID;
            IssuedCashCollectionHeader."Source Code" := SourceCode.Code;
        end;
        //HEI.01<<
        // BC Upgrade PATELP08 <<
    end;

    procedure DeleteHeader(CashCollectionHeader: Record "Cash Collection Header FND"; var IssuedCashCollectionHeader: Record "Issue Cash Collection Head FND");
    begin
        //HEI.01>>
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
        // with CashCollectionHeader do begin
        //     TestDeleteHeader(CashCollectionHeader, IssuedCashCollectionHeader);
        //     if IssuedCashCollectionHeader."No." <> '' then begin
        //         IssuedCashCollectionHeader."Shortcut Dimension 1 Code" := '';
        //         IssuedCashCollectionHeader."Shortcut Dimension 2 Code" := '';
        //         IssuedCashCollectionHeader.INSERT();
        //         IssuedCashCollectionLine.INIT();
        //         IssuedCashCollectionLine."Cash Collection No." := "No.";
        //         IssuedCashCollectionLine."Line No." := 10000;
        //         IssuedCashCollectionLine.Description := SourceCode.Description;
        //         IssuedCashCollectionLine.INSERT();
        //     end;
        // end;
        TestDeleteHeader(CashCollectionHeader, IssuedCashCollectionHeader);
        if IssuedCashCollectionHeader."No." <> '' then begin
            IssuedCashCollectionHeader."Shortcut Dimension 1 Code" := '';
            IssuedCashCollectionHeader."Shortcut Dimension 2 Code" := '';
            IssuedCashCollectionHeader.INSERT();
            IssuedCashCollectionLine.INIT();
            IssuedCashCollectionLine."Cash Collection No." := CashCollectionHeader."No.";
            IssuedCashCollectionLine."Line No." := 10000;
            IssuedCashCollectionLine.Description := SourceCode.Description;
            IssuedCashCollectionLine.INSERT();
        end;
        //HEI.01<<
        // BC Upgrade PATELP08 <<
    end;

    procedure ChangeDueDate(NewDueDate: Date; OldDueDate: Date);
    begin
    end;

    local procedure InsertGenJnlLineForFee(var CashCollectionLine: Record "Cash Collection Line FND");
    begin
        //HEI.01>>
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
        // with CashCollectionHeader do
        //     if CashCollectionLine.Amount <> 0 then begin
        //         CashCollectionLine.TESTFIELD("No.");
        //         InitGenJnlLine(GenJnlLine."Account Type"::"G/L Account",
        //           CashCollectionLine."No.",
        //           CashCollectionLine."Line Type" = CashCollectionLine."Line Type"::Rounding);
        //         GenJnlLine."Gen. Prod. Posting Group" := CashCollectionLine."Gen. Prod. Posting Group";
        //         GenJnlLine."VAT Prod. Posting Group" := CashCollectionLine."VAT Prod. Posting Group";
        //         GenJnlLine."VAT Calculation Type" := CashCollectionLine."VAT Calculation Type";
        //         if CashCollectionLine."VAT Calculation Type" =
        //            CashCollectionLine."VAT Calculation Type"::"Sales Tax"
        //         then begin
        //             GenJnlLine."Tax Area Code" := "Tax Area Code";
        //             GenJnlLine."Tax Liable" := "Tax Liable";
        //             GenJnlLine."Tax Group Code" := CashCollectionLine."Tax Group Code";
        //         end;
        //         GenJnlLine."VAT %" := CashCollectionLine."VAT %";
        //         GenJnlLine.VALIDATE(Amount, -CashCollectionLine.Amount - CashCollectionLine."VAT Amount");
        //         GenJnlLine."VAT Amount" := -CashCollectionLine."VAT Amount";
        //         GenJnlLine.UpdateLineBalance();
        //         TotalAmount := TotalAmount - GenJnlLine.Amount;
        //         TotalAmountLCY := TotalAmountLCY - GenJnlLine."Balance (LCY)";
        //         GenJnlLine."Bill-to/Pay-to No." := "Customer No.";
        //         GenJnlLine.INSERT();
        //     end;
        //HEI.01<<
        if CashCollectionLine.Amount <> 0 then begin
            CashCollectionLine.TESTFIELD("No.");
            InitGenJnlLine(GenJnlLine."Account Type"::"G/L Account",
                CashCollectionLine."No.",
                CashCollectionLine."Line Type" = CashCollectionLine."Line Type"::Rounding);
            GenJnlLine."Gen. Prod. Posting Group" := CashCollectionLine."Gen. Prod. Posting Group";
            GenJnlLine."VAT Prod. Posting Group" := CashCollectionLine."VAT Prod. Posting Group";
            GenJnlLine."VAT Calculation Type" := CashCollectionLine."VAT Calculation Type";
            if CashCollectionLine."VAT Calculation Type" =
                CashCollectionLine."VAT Calculation Type"::"Sales Tax"
            then begin
                GenJnlLine."Tax Area Code" := CashCollectionHeader."Tax Area Code";
                GenJnlLine."Tax Liable" := CashCollectionHeader."Tax Liable";
                GenJnlLine."Tax Group Code" := CashCollectionLine."Tax Group Code";
            end;
            GenJnlLine."VAT %" := CashCollectionLine."VAT %";
            GenJnlLine.VALIDATE(Amount, -CashCollectionLine.Amount - CashCollectionLine."VAT Amount");
            GenJnlLine."VAT Amount" := -CashCollectionLine."VAT Amount";
            GenJnlLine.UpdateLineBalance();
            TotalAmount := TotalAmount - GenJnlLine.Amount;
            TotalAmountLCY := TotalAmountLCY - GenJnlLine."Balance (LCY)";
            GenJnlLine."Bill-to/Pay-to No." := CashCollectionHeader."Customer No.";
            GenJnlLine.INSERT();
        end;
        // BC Upgrade PATELP08 <<
    end;

    local procedure CheckLineFee(var CashCollectionLine: Record "Cash Collection Line FND"; var CashCollectionHeader: Record "Cash Collection Header FND");
    var
        CashCollectionLine2: Record "Cash Collection Line FND";
        CustLedgEntry3: Record "Cust. Ledger Entry";
    begin
        //HEI.01>>
        if CashCollectionLine.Amount <= 0 then
            ERROR(LineFeeAmountErr, CashCollectionLine."Applies-to Document Type", CashCollectionLine."Applies-to Document No.");
        if CashCollectionLine."Applies-to Document No." = '' then
            ERROR(AppliesToDocErr);
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
        // with CustLedgEntry3 do begin
        //     SETRANGE("Document Type", CashCollectionLine."Applies-to Document Type");
        //     SETRANGE("Document No.", CashCollectionLine."Applies-to Document No.");
        //     SETRANGE("Customer No.", CashCollectionHeader."Customer No.");
        //     FINDFIRST();
        //     if "Due Date" >= CashCollectionHeader."Document Date" then
        //         ERROR(
        //           EntryNotOverdueErr, FIELDCAPTION("Document No."), CashCollectionLine."Applies-to Document No.", TABLENAME);
        // end;
        CustLedgEntry3.SETRANGE("Document Type", CashCollectionLine."Applies-to Document Type");
        CustLedgEntry3.SETRANGE("Document No.", CashCollectionLine."Applies-to Document No.");
        CustLedgEntry3.SETRANGE("Customer No.", CashCollectionHeader."Customer No.");
        CustLedgEntry3.FINDFIRST();
        if CustLedgEntry3."Due Date" >= CashCollectionHeader."Document Date" then
            ERROR(
                EntryNotOverdueErr, CustLedgEntry3.FIELDCAPTION("Document No."), CashCollectionLine."Applies-to Document No.", CustLedgEntry3.TABLENAME);
        // BC Upgrade PATELP08 <<
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
        // with IssuedCashCollectionLine do begin
        //     RESET();
        //     SETRANGE("Applies-To Document Type", CashCollectionLine."Applies-to Document Type");
        //     SETRANGE("Applies-To Document No.", CashCollectionLine."Applies-to Document No.");
        //     SETRANGE(Type, Type::"Customer Ledger Entry");
        //     SETRANGE("No. of Reminders", CashCollectionLine."No. of Reminders");
        //     if FINDFIRST() then
        //         ERROR(
        //           LineFeeAlreadyIssuedErr, CashCollectionLine."Applies-to Document Type", CashCollectionLine."Applies-to Document No.",
        //           CashCollectionLine."No. of Reminders");
        // end;
        IssuedCashCollectionLine.RESET();
        IssuedCashCollectionLine.SETRANGE("Applies-To Document Type", CashCollectionLine."Applies-to Document Type");
        IssuedCashCollectionLine.SETRANGE("Applies-To Document No.", CashCollectionLine."Applies-to Document No.");
        IssuedCashCollectionLine.SETRANGE(Type, IssuedCashCollectionLine.Type::"Customer Ledger Entry");
        IssuedCashCollectionLine.SETRANGE("No. of Reminders", CashCollectionLine."No. of Reminders");
        if IssuedCashCollectionLine.FINDFIRST() then
            ERROR(
                LineFeeAlreadyIssuedErr, CashCollectionLine."Applies-to Document Type", CashCollectionLine."Applies-to Document No.",
                CashCollectionLine."No. of Reminders");
        // BC Upgrade PATELP08 <<
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
        // with CashCollectionLine2 do begin
        //     RESET();
        //     SETRANGE("Applies-to Document Type", CashCollectionLine."Applies-to Document Type");
        //     SETRANGE("Applies-to Document No.", CashCollectionLine."Applies-to Document No.");
        //     SETRANGE(Type, IssuedCashCollectionLine.Type::"Customer Ledger Entry");
        //     SETRANGE("No. of Reminders", CashCollectionLine."No. of Reminders");
        //     if COUNT > 1 then
        //         ERROR(MultipleLineFeesSameDocErr, CashCollectionLine."Applies-to Document Type", CashCollectionLine."Applies-to Document No.");
        // end;
        CashCollectionLine2.RESET();
        CashCollectionLine2.SETRANGE("Applies-to Document Type", CashCollectionLine."Applies-to Document Type");
        CashCollectionLine2.SETRANGE("Applies-to Document No.", CashCollectionLine."Applies-to Document No.");
        CashCollectionLine2.SETRANGE(Type, IssuedCashCollectionLine.Type::"Customer Ledger Entry");
        CashCollectionLine2.SETRANGE("No. of Reminders", CashCollectionLine."No. of Reminders");
        if CashCollectionLine2.COUNT > 1 then
            ERROR(MultipleLineFeesSameDocErr, CashCollectionLine."Applies-to Document Type", CashCollectionLine."Applies-to Document No.");
        //HEI.01<<
        // BC Upgrade PATELP08 <<
    end;
}

