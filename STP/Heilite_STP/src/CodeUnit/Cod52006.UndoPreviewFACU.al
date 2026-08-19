codeunit 52006 "UndoPreviewFACU"
{
    Permissions = TableData "Purchase Line" = rimd,
                  TableData "Purch. Rcpt. Line" = rimd,
                  TableData "Item Entry Relation" = ri,
                  TableData "Whse. Item Entry Relation" = rimd;
    TableNo = "Purch. Rcpt. Line";
    EventSubscriberInstance = Manual;

    trigger OnRun()
    var

    begin
        PurchRcptLine.Copy(Rec);
        OnBeforeCheckPurchRcptLineUndoFA(PurchRcptLine);
        PreviewPostGLOnUndoFixedAssets(PurchRcptLine);
    end;
    // end;

    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
        TempWhseJnlLine: Record "Warehouse Journal Line" temporary;
        TempGlobalItemLedgEntry: Record "Item Ledger Entry" temporary;
        TempGlobalItemEntryRelation: Record "Item Entry Relation" temporary;
        UndoPostingMgt: Codeunit "Undo Posting Management";
        WhseUndoQty: Codeunit "Whse. Undo Quantity";
        UOMMgt: Codeunit "Unit of Measure Management";
        ItemsToAdjust: List of [Code[20]];
        HideDialog: Boolean;
        JobItem: Boolean;
        NextLineNo: Integer;

#pragma warning disable AA0074
        Text000: Label 'Do you really want to undo the selected Receipt lines?';
        Text001: Label 'Undo quantity posting...';
        Text002: Label 'There is not enough space to insert correction lines.';
        Text003: Label 'Checking lines...';
        Text004: Label 'This receipt has already been invoiced. Undo Receipt can be applied only to posted, but not invoiced receipts.';
#pragma warning restore AA0074
        NoLinesForCorrectionErr: Label 'There is no lines with quantity to process.';
        AlreadyReversedErr: Label 'This receipt has already been reversed.';
        GenJnlLineDocType: Enum "Gen. Journal Document Type";
        // BC Upgrade MISHRS14 <<

        GenJnlLineDocNo: Code[20];
        GenJnlLineExtDocNo: Code[35];


    procedure OnBeforeCheckPurchRcptLineUndoFA(var PurchRcptLine: Record "Purch. Rcpt. Line")
    var
        Text004: Label 'This receipt has already been invoiced. Undo Receipt can be applied only to posted, but not invoiced receipts.';
        FADepBook: Record "FA Depreciation Book";
        DepBook: Record "Depreciation Book";
        PurchLineCopy: Record "Purch. Rcpt. Line";
        ReturnAmtLCY: Decimal;
        PurchRcptHeader: Record "Purch. Rcpt. Header";
    begin

        //HEI.01>>
        IF PurchRcptLine.Type IN [PurchRcptLine.Type::"G/L Account", PurchRcptLine.Type::"Charge (Item)"] THEN BEGIN
            IF PurchRcptLine."Qty. Rcd. Not Invoiced" <> PurchRcptLine.Quantity THEN
                ERROR(Text004)
        END ELSE
            //HEI.03>>

            IF PurchRcptLine.Type = PurchRcptLine.Type::"Fixed Asset" THEN BEGIN
                Clear(ReturnAmtLCY);
                IF PurchRcptLine."Qty. Rcd. Not Invoiced" <> PurchRcptLine.Quantity THEN
                    ERROR(Text004);
                ReturnAmtLCY := PurchRcptLine.Quantity * PurchRcptLine."Unit Cost (LCY)";
                DepBook.RESET;
                IF DepBook.FINDFIRST THEN BEGIN

                    //HEI.12>>
                    FADepBook.SETCURRENTKEY("FA No.", "Depreciation Book Code");
                    FADepBook.SETRANGE("FA No.", PurchRcptLine."No.");
                    FADepBook.SETRANGE("Depreciation Book Code", DepBook.Code);
                    IF FADepBook.FINDFIRST THEN BEGIN
                        FADepBook.CalcFields("Book Value");
                        if FADepBook."Book Value" < ReturnAmtLCY then
                            Error('For fixed asset %1 and depr book code %2. The current book value is %3 which is lesser than return amount %4', FADepBook."FA No.", FADepBook."Depreciation Book Code", FADepBook."Book Value", ReturnAmtLCY);
                    end;
                end;
            end;


        //HEI.03<<
        //HEI.01<<





    end;

    procedure PreviewPostGLOnUndoFixedAssets(VAR PurchRcptLine: Record "Purch. Rcpt. Line")
    var
        GenJournalLine: Record "Gen. Journal Line";
        FAJnlSetup: Record "FA Journal Setup";
        DeprBook: Record "Depreciation Book";
        PurchRcptHeader2: Record "Purch. Rcpt. Header";
        PurchReceiptHeader: Record "Purch. Rcpt. Header";
        TotalPurchLine: Record "Purchase Line";
        TotalPurchLineLCY: Record "Purchase Line";
        SrcCode: Code[10];
        TotalFAPurchLine: Record "Purchase Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        SourceCodeSetup: Record "Source Code Setup";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        FADepreciationBookL: Record "FA Depreciation Book";

    begin
        //HEI.06>>
        DeprBook.RESET;
        DeprBook.SETRANGE("Part of Duplication List", TRUE);
        IF DeprBook.FINDFIRST THEN BEGIN
            GenJnlLine.RESET;
            GenJnlLine.SETRANGE("Document Type", GenJnlLine."Document Type"::"Purchase Receipt");
            GenJnlLine.SETRANGE("Document No.", PurchRcptLine."Document No.");
            GenJnlLine.SETRANGE("Undo FA Receipt FND", TRUE);
            GenJnlLine.SETFILTER("Journal Template Name", '<>%1', GetFATemplate2(DeprBook.Code));
            GenJnlLine.SETFILTER("Journal Batch Name", '<>%1', GetFABatch2(DeprBook.Code));
            IF GenJnlLine.FINDSET THEN
                GenJnlLine.DELETEALL; //Deleting un-posted local book line
        END;
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Document Type", GenJnlLine."Document Type"::"Purchase Receipt");
        GenJnlLine.SETRANGE("Document No.", PurchRcptLine."Document No.");
        GenJnlLine.SETRANGE("Undo FA Receipt FND", TRUE);
        GenJnlLine.SETFILTER("Journal Template Name", '%1', GetFATemplate(PurchRcptLine."Depreciation Book Code"));
        GenJnlLine.SETFILTER("Journal Batch Name", '%1', GetFABatch(PurchRcptLine."Depreciation Book Code"));
        IF GenJnlLine.FINDSET THEN
            GenJnlLine.DELETEALL; //Deleting un-posted local book line

        TotalPurchLine.GET(TotalPurchLine."Document Type"::Order, PurchRcptLine."Order No.", PurchRcptLine."Order Line No.");
        PurchReceiptHeader.GET(PurchRcptLine."Document No.");
        GenJnlLineDocType := GenJournalLine."Document Type"::"Purchase Receipt";
        GenJnlLineDocNo := PurchRcptLine."Document No.";
        GenJnlLineExtDocNo := PurchReceiptHeader."Vendor Order No.";
        PostUndoFaGlEntry_1(
            PurchReceiptHeader, PurchRcptLine, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, PurchReceiptHeader."Source Code", TotalFAPurchLine);
        PostUndoFaGlEntry_2(
            PurchReceiptHeader, PurchRcptLine, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, PurchReceiptHeader."Source Code", TotalFAPurchLine);

        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", GetFATemplate(PurchRcptLine."Depreciation Book Code"));
        GenJournalLine.SETRANGE("Journal Batch Name", GetFABatch(PurchRcptLine."Depreciation Book Code"));
        GenJournalLine.SETRANGE("Document Type", GenJournalLine."Document Type"::"Purchase Receipt");
        GenJournalLine.SETRANGE("Document No.", PurchRcptLine."Document No.");
        GenJournalLine.FINDSET;

        COMMIT;
        // GenJnlPost.PreviewSRM(GenJournalLine);
        PreviewSRM(GenJournalLine);

        //  PreviewSRM(GenJnlLine);

        //------------------------------------------------------Local Close

        DeprBook.RESET;
        DeprBook.SETRANGE("Part of Duplication List", TRUE);
        IF DeprBook.FINDFIRST THEN BEGIN
            //HEI.12>>
            FADepreciationBookL.SETCURRENTKEY("FA No.", "Depreciation Book Code");
            FADepreciationBookL.SETRANGE("FA No.", PurchRcptLine."No.");
            FADepreciationBookL.SETRANGE("Depreciation Book Code", DeprBook.Code);
            IF FADepreciationBookL.FINDFIRST THEN BEGIN
                //HEI.12<<
                //Source
                SourceCodeSetup.GET;
                PostUndoFaGlEntry_3(
                  PurchReceiptHeader, PurchRcptLine, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, SourceCodeSetup."Fixed Asset G/L Journal", TotalFAPurchLine, DeprBook.Code);
                PostUndoFaGlEntry_4(
                  PurchReceiptHeader, PurchRcptLine, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, SourceCodeSetup."Fixed Asset G/L Journal", TotalFAPurchLine, DeprBook.Code);

                FAJnlSetup.RESET;
                FAJnlSetup.SETFILTER("Depreciation Book Code", DeprBook.Code);
                FAJnlSetup.SETRANGE("User ID", USERID);
                IF FAJnlSetup.FINDFIRST THEN BEGIN
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name", GetFATemplate2(DeprBook.Code));
                    GenJournalLine.SETRANGE("Journal Batch Name", GetFABatch2(DeprBook.Code));
                    GenJournalLine.SETRANGE("Document No.", PurchReceiptHeader."No.");
                    GenJournalLine.SETRANGE("Posting Date", TODAY);

                    // BC Upgrade MISHRS14 >>
                    // Removed false from FINDSET as it being depreceted
                    //IF GenJournalLine.FINDSET(TRUE, FALSE) THEN BEGIN
                    IF GenJournalLine.FINDSET(TRUE) THEN BEGIN
                        // BC Upgrade MISHRS14 <<

                        GenJournalLine."Reference Number FND" := PurchReceiptHeader."Your Reference";

                        IF PurchReceiptHeader."Order No." <> '' THEN
                            GenJournalLine."PO Number FND" := PurchReceiptHeader."Order No.";

                        GenJournalLine."Source Type" := GenJournalLine."Source Type"::Vendor;
                        GenJournalLine."Source No." := PurchReceiptHeader."Buy-from Vendor No.";
                        GenJournalLine.MODIFY();
                        COMMIT();
                        //  GenJnlPost.PreviewSRM(GenJournalLine);
                        PreviewSRM(GenJournalLine);  // BC Upgrade BHARDA11
                        // PreviewSRM(GenJnlLine);
                    END;
                END;
                //HEI.12>>
            END;
            //HEI.12<<
        END;
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Document Type", GenJnlLine."Document Type"::"Purchase Receipt");
        GenJnlLine.SETRANGE("Document No.", PurchRcptLine."Document No.");
        GenJnlLine.SETRANGE("Undo FA Receipt FND", TRUE);
        IF GenJnlLine.FINDSET THEN
            GenJnlLine.DELETEALL; //Deleting un-posted local book line
        COMMIT;
        //HEI.06<<
    end;

    LOCAL procedure GetFATemplate2(DeprBookCode: Code[10]): Code[10]
    var
        FAJnlSetup: Record "FA Journal Setup";
    begin
        //HEI.03>>
        IF FAJnlSetup.GET(DeprBookCode, USERID) THEN
            EXIT(FAJnlSetup."Gen. Jnl. Template Name")
        ELSE
            EXIT(GetFATemplate(DeprBookCode));
        //HEI.03<<
    end;

    LOCAL procedure GetFABatch2(DeprBookCode: Code[10]): Code[10]
    var
        FAJnlSetup: Record "FA Journal Setup";
    begin


        //HEI.03>>
        IF FAJnlSetup.GET(DeprBookCode, USERID) THEN
            EXIT(FAJnlSetup."Gen. Jnl. Batch Name")
        ELSE
            EXIT(GetFABatch(DeprBookCode));
        //HEI.03<<
    end;

    LOCAL procedure GetFATemplate(DeprBookCode: Code[10]): Code[10]
    var
        FAJnlSetup: Record "FA Journal Setup";
    begin
        //HEI.03>>
        FAJnlSetup.GET(DeprBookCode, '');
        EXIT(FAJnlSetup."Gen. Jnl. Template Name");
    end;
    //HEI.03<<
    LOCAL procedure GetFABatch(DeprBookCode: Code[10]): Code[10]
    var
        FAJnlSetup: Record "FA Journal Setup";
    begin
        //HEI.03>>
        FAJnlSetup.GET(DeprBookCode, '');

        EXIT(FAJnlSetup."Gen. Jnl. Batch Name");
        //HEI.03<<
    end;

    LOCAL procedure GetLastLineNo(GenJouTemplate: Code[10]; GenJouBatch: Code[10]): Integer
    var
        GenJouLine: Record "Gen. Journal Line";
    begin
        //HEI.03>>
        GenJouLine.RESET;
        GenJouLine.SETRANGE("Journal Template Name", GenJouTemplate);
        GenJouLine.SETRANGE("Journal Batch Name", GenJouBatch);
        IF GenJouLine.FINDLAST THEN
            EXIT(GenJouLine."Line No." + 10000);

        EXIT(10000);
        //HEI.03<<
    end;


    LOCAL procedure PostUndoFaGlEntry_1(PurchReceptHeader: Record "Purch. Rcpt. Header"; TotalPurchReceipt: Record "Purch. Rcpt. Line"; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20];
                                                                                                                                                   ExtDocNo: Code[35];
                                                                                                                                                   SourceCode: Code[10];
                                                                                                                                                   TotalFAPurchLine: Record "Purchase Line")
    // BC Upgrade MISHRS14 <<

    var
        GenJnlLine: Record "Gen. Journal Line";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        FAPurchaseLine: Record "Purchase Line";
        FASetup: Record "FA Setup";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        PurchHeader: Record "Purchase Header";
    begin
        //HEI.03>>
        FASetup.GET;
        FASetup.TESTFIELD("Payable Acc.Purch. Receipt FND");
        IF FASetup."Post GL on Purchase Return FND" THEN
            FASetup.TESTFIELD("Payable Acc. Purch. Return FND");
        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with GenJnlLine
        GenJnlLine.InitNewLine(Today, PurchReceptHeader."Document Date", 0D, PurchReceptHeader."Posting Description", TotalPurchReceipt."Shortcut Dimension 1 Code", TotalPurchReceipt."Shortcut Dimension 2 Code", TotalPurchReceipt."Dimension Set ID", PurchReceptHeader."Reason Code");
        // GenJnlLine.InitNewLine(TODAY, PurchReceptHeader."Document Date", PurchReceptHeader."Posting Description",
        //   TotalPurchReceipt."Shortcut Dimension 1 Code", TotalPurchReceipt."Shortcut Dimension 2 Code",
        //   TotalPurchReceipt."Dimension Set ID", PurchReceptHeader."Reason Code");
        GenJnlLine."Journal Template Name" := GetFATemplate(TotalPurchReceipt."Depreciation Book Code");
        GenJnlLine."Journal Batch Name" := GetFABatch(TotalPurchReceipt."Depreciation Book Code");
        GenJnlLine."Line No." := GetLastLineNo(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Fixed Asset";
        GenJnlLine."Account No." := TotalPurchReceipt."No.";
        GenJnlLine."FA Posting Type" := GenJnlLine."FA Posting Type"::"Acquisition Cost";
        GenJnlLine."Depreciation Book Code" := TotalPurchReceipt."Depreciation Book Code";

        GenJnlLine.CopyDocumentFields(DocType, DocNo, ExtDocNo, SourceCode, '');

        GenJnlLine."System-Created Entry" := TRUE;

        GenJnlLine."Pmt. Discount Date" := 0D;

        GenJnlLine.Amount := -GetFaLedgerEntryCost(TotalPurchReceipt);
        GenJnlLine."Amount (LCY)" := GenJnlLine.Amount;

        GenJnlLine."Reference Number FND" := PurchReceptHeader."Your Reference";

        IF PurchReceptHeader."Order No." <> '' THEN
            GenJnlLine."PO Number FND" := PurchReceptHeader."Order No.";

        GenJnlLine."Source Type" := GenJnlLine."Source Type"::Vendor;
        GenJnlLine."Source No." := PurchReceptHeader."Buy-from Vendor No.";
        GenJnlLine."Undo FA Receipt FND" := TRUE;//HEI.04
        GenJnlLine."GR Validation Temp Line FND" := true;
        // BC Upgrade BHARDA11 27April2026
        GenJnlLine."FA Receipt Line No. FND" := TotalPurchReceipt."Line No.";
        GenJnlLine.INSERT;
        // //HEI.03<<

        // BC Upgrade MISHRS14 <<

        //HEI.03<<
    end;

    LOCAL procedure GetFaLedgerEntryCost(PurchLineReceipt: Record "Purch. Rcpt. Line"): Decimal
    var
        FALedgerEntry: Record "FA Ledger Entry";
    begin
        //HEI.03>>
        FALedgerEntry.RESET;
        FALedgerEntry.SETRANGE("Document Type", FALedgerEntry."Document Type"::"Purchase Receipt");
        FALedgerEntry.SETRANGE("Document No.", PurchLineReceipt."Document No.");
        FALedgerEntry.SETRANGE("Purchase Receipt Line No. FND", PurchLineReceipt."Line No.");
        IF FALedgerEntry.FINDFIRST THEN
            EXIT(FALedgerEntry.Amount);
        //HEI.03<<
    end;

    LOCAL procedure PostUndoFaGlEntry_2(PurchReceptHeader: Record "Purch. Rcpt. Header"; TotalPurchReceipt: Record "Purch. Rcpt. Line"; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20];
                                                                                                                                                    ExtDocNo: Code[35];
                                                                                                                                                    SourceCode: Code[10];
                                                                                                                                                    TotalFAPurchLine: Record "Purchase Line")
    // BC Upgrade MISHRS14 <<

    var
        GenJnlLine: Record "Gen. Journal Line";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        FAPurchaseLine: Record "Purchase Line";
        FASetup: Record "FA Setup";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        PurchHeader: Record "Purchase Header";
    begin
        //HEI.03>>
        FASetup.GET;
        FASetup.TESTFIELD("Payable Acc.Purch. Receipt FND");
        IF FASetup."Post GL on Purchase Return FND" THEN
            FASetup.TESTFIELD("Payable Acc. Purch. Return FND");
        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with GenJnlLine
        GenJnlLine.InitNewLine(
  TODAY, PurchReceptHeader."Document Date", 0D, PurchReceptHeader."Posting Description",
  PurchReceptHeader."Shortcut Dimension 1 Code", PurchReceptHeader."Shortcut Dimension 2 Code",
  PurchReceptHeader."Dimension Set ID", PurchReceptHeader."Reason Code");

        GenJnlLine."Journal Template Name" := GetFATemplate(TotalPurchReceipt."Depreciation Book Code");
        GenJnlLine."Journal Batch Name" := GetFABatch(TotalPurchReceipt."Depreciation Book Code");
        GenJnlLine."Line No." := GetLastLineNo(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
        GenJnlLine."Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Account No." := FASetup."Payable Acc.Purch. Receipt FND";

        GenJnlLine.CopyDocumentFields(DocType, DocNo, ExtDocNo, SourceCode, '');

        GenJnlLine."System-Created Entry" := TRUE;

        GenJnlLine."Pmt. Discount Date" := 0D;

        GenJnlLine.Amount := GetFaLedgerEntryCost(TotalPurchReceipt);
        GenJnlLine."Amount (LCY)" := GenJnlLine.Amount;

        GenJnlLine."Reference Number FND" := PurchReceptHeader."Your Reference";

        IF PurchReceptHeader."Order No." <> '' THEN
            GenJnlLine."PO Number FND" := PurchReceptHeader."Order No.";

        GenJnlLine."Source Type" := GenJnlLine."Source Type"::Vendor;
        GenJnlLine."Source No." := PurchReceptHeader."Buy-from Vendor No.";
        GenJnlLine."Undo FA Receipt FND" := TRUE;//HEI.04
        GenJnlLine."GR Validation Temp Line FND" := true;
        // BC Upgrade BHARDA11 27April2026
        GenJnlLine."FA Receipt Line No. FND" := TotalPurchReceipt."Line No.";
        GenJnlLine.INSERT;
        // //HEI.03<<

        //WITH GenJnlLine DO BEGIN
        // GenJnlLine.InitNewLine(
        //   TODAY, PurchReceptHeader."Document Date", 0D, PurchReceptHeader."Posting Description",
        //   PurchReceptHeader."Shortcut Dimension 1 Code", PurchReceptHeader."Shortcut Dimension 2 Code",
        //   PurchReceptHeader."Dimension Set ID", PurchReceptHeader."Reason Code");

        // GenJnlLine."Journal Template Name" := GetFATemplate(TotalPurchReceipt."Depreciation Book Code");
        // GenJnlLine."Journal Batch Name" := GetFABatch(TotalPurchReceipt."Depreciation Book Code");
        // GenJnlLine."Line No." := GetLastLineNo(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
        // GenJnlLine."Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        // GenJnlLine."Account No." := FASetup."Payable Acc.Purch. Receipt FND";

        // GenJnlLine.CopyDocumentFields(DocType, DocNo, ExtDocNo, SourceCode, '');

        // GenJnlLine."System-Created Entry" := TRUE;

        // GenJnlLine."Pmt. Discount Date" := 0D;

        // GenJnlLine.Amount := GetFaLedgerEntryCost(TotalPurchReceipt);
        // GenJnlLine."Amount (LCY)" := GenJnlLine.Amount;

        // GenJnlLine."Reference Number" := PurchReceptHeader."Your Reference";

        // IF PurchReceptHeader."Order No." <> '' THEN
        //     GenJnlLine."PO Number" := PurchReceptHeader."Order No.";

        // GenJnlLine."Source Type" := GenJnlLine."Source Type"::Vendor;
        // GenJnlLine."Source No." := PurchReceptHeader."Buy-from Vendor No.";
        // GenJnlLine."Undo FA Receipt" := TRUE;//HEI.04
        // GenJnlLine.INSERT;
        //END;
        // BC Upgrade MISHRS14 <<

    end;

    LOCAL procedure PostUndoFaGlEntry_3(PurchReceptHeader: Record "Purch. Rcpt. Header"; TotalPurchReceipt: Record "Purch. Rcpt. Line"; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20];
                                                                                                                                                     ExtDocNo: Code[35];
                                                                                                                                                     SourceCode: Code[10];
                                                                                                                                                     TotalFAPurchLine: Record "Purchase Line";
                                                                                                                                                     DeperBookCode: Code[10])
    // BC Upgrade MISHRS14 <<

    var
        GenJnlLine: Record "Gen. Journal Line";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        FAPurchaseLine: Record "Purchase Line";
        FASetup: Record "FA Setup";
        PurchHeader: Record "Purchase Header";
    begin
        //HEI.03>>
        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with GenJnlLine
        GenJnlLine.InitNewLine(
  TODAY, PurchReceptHeader."Document Date", 0D, PurchReceptHeader."Posting Description",
  TotalPurchReceipt."Shortcut Dimension 1 Code", TotalPurchReceipt."Shortcut Dimension 2 Code",
  TotalPurchReceipt."Dimension Set ID", PurchReceptHeader."Reason Code");

        GenJnlLine."Journal Template Name" := GetFATemplate2(DeperBookCode);
        GenJnlLine."Journal Batch Name" := GetFABatch2(DeperBookCode);
        GenJnlLine."Line No." := GetLastLineNo(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Fixed Asset";
        GenJnlLine.VALIDATE("Account No.", TotalPurchReceipt."No.");
        GenJnlLine."FA Posting Type" := GenJnlLine."FA Posting Type"::"Acquisition Cost";
        GenJnlLine.VALIDATE("Depreciation Book Code", DeperBookCode);

        GenJnlLine.CopyDocumentFields(DocType, DocNo, ExtDocNo, SourceCode, '');

        GenJnlLine."Pmt. Discount Date" := 0D;

        GenJnlLine.VALIDATE(Amount, -GetFaLedgerEntryCost(TotalPurchReceipt));

        GenJnlLine."Reference Number FND" := PurchReceptHeader."Your Reference";
        GenJnlLine."PO Number FND" := '';
        GenJnlLine."Source Type" := GenJnlLine."Source Type"::" ";
        GenJnlLine."Source No." := '';
        GenJnlLine."Shortcut Dimension 1 Code" := TotalPurchReceipt."Shortcut Dimension 1 Code";
        GenJnlLine."Shortcut Dimension 2 Code" := TotalPurchReceipt."Shortcut Dimension 2 Code";
        GenJnlLine."Dimension Set ID" := TotalPurchReceipt."Dimension Set ID";
        //  GenJnlLine.Description := TotalPurchReceipt.Description;//sharmp16--
        GenJnlLine."Undo FA Receipt FND" := TRUE;//HEI.04
        GenJnlLine."GR Validation Temp Line FND" := true;
        // BC Upgrade BHARDA11 27April2026
        GenJnlLine.INSERT;
        // //HEI.03<<
        //WITH GenJnlLine DO BEGIN
        // GenJnlLine.InitNewLine(
        //   TODAY, PurchReceptHeader."Document Date", 0D, PurchReceptHeader."Posting Description",
        //   TotalPurchReceipt."Shortcut Dimension 1 Code", TotalPurchReceipt."Shortcut Dimension 2 Code",
        //   TotalPurchReceipt."Dimension Set ID", PurchReceptHeader."Reason Code");

        // GenJnlLine."Journal Template Name" := GetFATemplate2(DeperBookCode);
        // GenJnlLine."Journal Batch Name" := GetFABatch2(DeperBookCode);
        // GenJnlLine."Line No." := GetLastLineNo(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
        // GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Fixed Asset";
        // GenJnlLine.VALIDATE("Account No.", TotalPurchReceipt."No.");
        // GenJnlLine."FA Posting Type" := GenJnlLine."FA Posting Type"::"Acquisition Cost";
        // GenJnlLine.VALIDATE("Depreciation Book Code", DeperBookCode);

        // GenJnlLine.CopyDocumentFields(DocType, DocNo, ExtDocNo, SourceCode, '');

        // GenJnlLine."Pmt. Discount Date" := 0D;

        // GenJnlLine.VALIDATE(Amount, -GetFaLedgerEntryCost(TotalPurchReceipt));

        // GenJnlLine."Reference Number" := PurchReceptHeader."Your Reference";
        // GenJnlLine."PO Number" := '';
        // GenJnlLine."Source Type" := GenJnlLine."Source Type"::" ";
        // GenJnlLine."Source No." := '';
        // GenJnlLine."Shortcut Dimension 1 Code" := TotalPurchReceipt."Shortcut Dimension 1 Code";
        // GenJnlLine."Shortcut Dimension 2 Code" := TotalPurchReceipt."Shortcut Dimension 2 Code";
        // GenJnlLine."Dimension Set ID" := TotalPurchReceipt."Dimension Set ID";
        // GenJnlLine.Description := TotalPurchReceipt.Description;
        // GenJnlLine."Undo FA Receipt" := TRUE;//HEI.04
        // GenJnlLine.INSERT;
        //END;
        // BC Upgrade MISHRS14 <<

        //HEI.03<<


    end;

    // BC Upgrade MISHRS14 >>
    // Chnaged data type of DocType from option to enum to remove implicit warning
    LOCAL procedure PostUndoFaGlEntry_4(PurchReceptHeader: Record "Purch. Rcpt. Header"; TotalPurchReceipt: Record "Purch. Rcpt. Line"; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20];
                                                                                                                                                    ExtDocNo: Code[35];
                                                                                                                                                    SourceCode: Code[10];
                                                                                                                                                    TotalFAPurchLine: Record "Purchase Line";
                                                                                                                                                    DeperBookCode: Code[10])
    // BC Upgrade MISHRS14 <<

    var
        GenJnlLine: Record "Gen. Journal Line";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        FAPurchaseLine: Record "Purchase Line";
        FASetup: Record "FA Setup";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        PurchHeader: Record "Purchase Header";
        FAPostingGroup: Record "FA Posting Group";
        DepreBookLine: Record "FA Depreciation Book";
    begin
        //HEI.03>>
        DepreBookLine.GET(TotalPurchReceipt."No.", DeperBookCode);
        FAPostingGroup.GET(DepreBookLine."FA Posting Group");
        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with GenJnlLine
        GenJnlLine.InitNewLine(
     TODAY, PurchReceptHeader."Document Date", 0D, PurchReceptHeader."Posting Description",
     TotalPurchReceipt."Shortcut Dimension 1 Code", TotalPurchReceipt."Shortcut Dimension 2 Code",
     TotalPurchReceipt."Dimension Set ID", PurchReceptHeader."Reason Code");


        GenJnlLine."Journal Template Name" := GetFATemplate2(DeperBookCode);
        GenJnlLine."Journal Batch Name" := GetFABatch2(DeperBookCode);
        GenJnlLine."Line No." := GetLastLineNo(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine.VALIDATE("Account No.", FAPostingGroup."Acquisition Cost Bal. Acc.");

        GenJnlLine.CopyDocumentFields(DocType, DocNo, ExtDocNo, SourceCode, '');

        GenJnlLine."Pmt. Discount Date" := 0D;

        GenJnlLine.VALIDATE(Amount, GetFaLedgerEntryCost(TotalPurchReceipt));
        GenJnlLine."Reference Number FND" := PurchReceptHeader."Your Reference";
        GenJnlLine."PO Number FND" := '';
        GenJnlLine."Source Type" := GenJnlLine."Source Type"::" ";
        GenJnlLine."Source No." := '';
        GenJnlLine."Shortcut Dimension 1 Code" := TotalPurchReceipt."Shortcut Dimension 1 Code";
        GenJnlLine."Shortcut Dimension 2 Code" := TotalPurchReceipt."Shortcut Dimension 2 Code";
        GenJnlLine."Dimension Set ID" := TotalPurchReceipt."Dimension Set ID";
        //  GenJnlLine.Description := TotalPurchReceipt.Description;//sharmp16--
        GenJnlLine."Undo FA Receipt FND" := TRUE;//HEI.04
        GenJnlLine."GR Validation Temp Line FND" := true;
        // BC Upgrade BHARDA11 27April2026
        GenJnlLine.INSERT;
        //HEI.03<<

        //WITH GenJnlLine DO BEGIN
        // GenJnlLine.InitNewLine(
        //      TODAY, PurchReceptHeader."Document Date", 0D, PurchReceptHeader."Posting Description",
        //      TotalPurchReceipt."Shortcut Dimension 1 Code", TotalPurchReceipt."Shortcut Dimension 2 Code",
        //      TotalPurchReceipt."Dimension Set ID", PurchReceptHeader."Reason Code");


        // GenJnlLine."Journal Template Name" := GetFATemplate2(DeperBookCode);
        // GenJnlLine."Journal Batch Name" := GetFABatch2(DeperBookCode);
        // GenJnlLine."Line No." := GetLastLineNo(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
        // GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        // GenJnlLine.VALIDATE("Account No.", FAPostingGroup."Acquisition Cost Bal. Acc.");

        // GenJnlLine.CopyDocumentFields(DocType, DocNo, ExtDocNo, SourceCode, '');

        // GenJnlLine."Pmt. Discount Date" := 0D;

        // GenJnlLine.VALIDATE(Amount, GetFaLedgerEntryCost(TotalPurchReceipt));
        // GenJnlLine."Reference Number" := PurchReceptHeader."Your Reference";
        // GenJnlLine."PO Number" := '';
        // GenJnlLine."Source Type" := GenJnlLine."Source Type"::" ";
        // GenJnlLine."Source No." := '';
        // GenJnlLine."Shortcut Dimension 1 Code" := TotalPurchReceipt."Shortcut Dimension 1 Code";
        // GenJnlLine."Shortcut Dimension 2 Code" := TotalPurchReceipt."Shortcut Dimension 2 Code";
        // GenJnlLine."Dimension Set ID" := TotalPurchReceipt."Dimension Set ID";
        // GenJnlLine.Description := TotalPurchReceipt.Description;
        // GenJnlLine."Undo FA Receipt" := TRUE;//HEI.04
        // GenJnlLine.INSERT;
        //END;
        // BC Upgrade MISHRS14 <<

    end;

    local procedure PreviewSRM(VAR GenJournalLineSource: Record "Gen. Journal Line")
    var
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";

    begin
        //HEI.01>>
        // BINDSUBSCRIPTION(GenJnlPost);
        PreviewSRMInterface(GenJnlPost, GenJournalLineSource);
        //HEI.01<<
    end;

    // [IntegrationEvent(false, false)] // BC Upgrade BHARDA11 
    local procedure PreviewSRMInterface(Subscriber: Variant; RecVar: Variant)
    // local procedure PreviewSRMInterface(Subscriber: Variant; Rec: Record "Gen. Journal Line")
    var
        SubscriberTypeErr: Label 'Invalid Subscriber type. The type must be CODEUNIT.';
        RecVarTypeErr: Label 'Invalid RecVar type. The type must be RECORD.';
        PostingPreviewEventHandler: Codeunit 20;
        RunResult: Boolean;
        genJournalPostPr: Codeunit "Gen. Jnl.-Post Preview";
        PaymentJnl: page "Payment Journal";
        PreviewExitStateErr: Label 'The posting preview has stopped because of a state that is not valid.';
        PreviewModeErr: Label 'Preview mode.';
        HeinekenBCUpgrade: Codeunit "Heineken BC Upgrade";
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
    begin
        //HEI.01>>
        // Error('%1', UserId);
        // IF NOT Subscriber.ISCODEUNIT THEN
        //     ERROR(SubscriberTypeErr);

        // IF NOT RecVar.ISRECORD THEN
        //     ERROR(RecVarTypeErr);

        // BINDSUBSCRIPTION(PostingPreviewEventHandler);
        // genJournalPostPr.
        // RunResult := RunPreview(Subscriber, RecVar); // Need to check
        BindSubscription(GenJnlPost);
        GenJnlPostPreview.SetContext(GenJnlPost, RecVar);
        if not GenJnlPostPreview.Run() then begin
            if GetLastErrorText <> '' then
                Error(GetLastErrorText);
        end;
        // BindSubscription(testcu);
        // GenJnlPost := Subscriber;
        // GenJnlPost.Preview(RecVar);
        // testcu.Run();
        // UnbindSubscription(testcu);

        // RunResult := HeinekenBCUpgrade.RunPreview(Subscriber, RecVar);
        // UNBINDSUBSCRIPTION(PostingPreviewEventHandler);

        // The OnRunPreview event expects subscriber following template: Result := <Codeunit>.RUN

        // So we assume RunPreview returns FALSE with the error.

        // To prevent return FALSE without thrown error we check error call stack.
        // BC Upgrade BHARDA11 >> 
        // IF RunResult OR (GETLASTERRORCALLSTACK = '') THEN
        //     ERROR(PreviewExitStateErr);

        IF GETLASTERRORTEXT <> PreviewModeErr THEN
            ERROR(GETLASTERRORTEXT);
        // BC Upgrade BHARDA11 << 
        //HEI.01<<


    end;
}