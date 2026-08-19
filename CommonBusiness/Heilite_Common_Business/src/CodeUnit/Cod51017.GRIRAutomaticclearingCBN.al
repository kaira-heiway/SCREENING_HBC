codeunit 51017 "GR/IR Automatic clearing CBN"
{
    // version HEI.05

    // HEI.01 CHG2047407 IBM PANDES01 01/04/20
    //  # Created Codeunit for GR/IR Automatic clearing.
    // HEI.02 CHG2047407 IBM PANDES01 28/04/20
    //  # Added Code related to Entries Posted by
    // HEI.03 CHG2076275 IBM PANDES01 21/08/2020
    //  # Added code to fix the issue for multiple entries posting.
    // HEI.04 CHG2208499 - HB1699 IBM SRIVAS07 03.07.2023 - Enhancement to HB1057 to include FA
    //  # Added Few Code in OnRun()
    // HEI.05 CHG2201773 HB3442 SRIVAS07 IBM 20/03/24 # Development - Undoing a Goods Receipt for Fixed Asset
    //  # Added few code in code()
    //  # Added new function Setundoflag()

    // BC UPGRADE PATELS08 >>
    // # In Procedures Apply, RealEntryChanged, UpdateTempTable, UpdateRealTable : Blocked 'With' statement and prefixed variables respective table recored variables.
    // BC UPGRADE PATELS08 <<

    Permissions = TableData "G/L Entry" = rm;

    trigger OnRun();
    begin
        GLAcc.RESET();
        GLAcc.SETRANGE("Automatic application mode FND", GLAcc."Automatic application mode FND"::"GR/IR Accounts Payable");
        if GLAcc.findset() then
            repeat
                SetAllEntries(GLAcc."No.");
                UpdateAllowpartial(true);
                GLEntryApplyPostedEntries."SetApplyIDWithGR/IRAccountsPayable"(G_TempGLEntryBuf);
                G_TempGLEntryBuf.RESET();
                G_TempGLEntryBuf.SETFILTER("Applies-to ID", '<>%1', '');
                G_TempGLEntryBuf.SETRANGE(Open, true);
                //HEI.03>>
                TotalNo := G_TempGLEntryBuf.COUNT;
                if G_TempGLEntryBuf.FIND('-') then
                    Apply(G_TempGLEntryBuf);
                for i := 1 to (TotalNo / 2) do begin
                    G_TempGLEntryBuf.RESET();
                    G_TempGLEntryBuf.SETFILTER("Applies-to ID", '<>%1', '');
                    G_TempGLEntryBuf.SETRANGE(Open, true);
                    if G_TempGLEntryBuf.FIND('-') then
                        Apply(G_TempGLEntryBuf);
                end;
                //HEI.03<<
                //HEI.04>>
                G_TempGLEntryBuf.RESET();
                G_TempGLEntryBuf.SETFILTER("Applies-to ID", '%1', '');
                G_TempGLEntryBuf.SETRANGE(Open, true);
                G_TempGLEntryBuf1.COPY(G_TempGLEntryBuf, true);
                GLEntryApplyPostedEntries.SetApplyIDWithGRIRAccountsPayableFA(G_TempGLEntryBuf1);
            //HEI.04<<
            until GLAcc.NEXT() = 0;
    end;

    var
        GLAcc: Record "G/L Account";
        GenLEntry: Record "G/L Entry";
        G_TempGLEntryBuf: Record "G/L Entry Application Bffr FND" temporary;
        G_TempGLEntryBuf1: Record "G/L Entry Application Bffr FND" temporary;
        GLEntryAppBuffer: Record "G/L Entry Application Bffr FND";
        GLEntryAppBufferCpy: Record "G/L Entry Application Bffr FND";
        GLSetup: Record "General Ledger Setup";
        GLEntryApplyPostedEntries: Codeunit "GLEntry Apply Posted Entr. CBN";
        ApplyGLEntries: Page "Apply Gen Ledger Entries CBN";
        AllowPartialApplication: Boolean;
        GLSetupRead: Boolean;
        skipforundo: Boolean;
        GLEntryApplID: Code[50];
        ShowTotalAppliedAmount: Decimal;
        i: Integer;
        Number: Integer;
        TotalNo: Integer;
        Text11306: Label 'Option must have a value !';
        TXT50000: Label '"Partial application  isn''t allowed "';
        TXT50001: Label 'You cannot apply the G/L entries because the final reporting isn''t extracted yet.';
        Option: Option " ","Purchase Prepayment","Sales Prepayment","AR Control Account","AP Control Account","GS/IS Accounts Receivable","GR/IR Accounts Payable","Selection Criteria","Default Automatic Application Mode";
        IncludeEntryFilter: Option All,Open,Closed;
        DynamicCaption: Text[100];
        PostingDateFilter: Text[100];
        Text11300: TextConst ENU = 'Preparing Entries      @1@@@@@@@@@@@@@', FRB = 'Préparation des écr.   @1@@@@@@@@@@@@@', NLB = 'Voorbereiden posten    @1@@@@@@@@@@@@@';
        Text11301: TextConst ENU = 'Another user has modified the record for this %1 after you retrieved it from the database.', FRB = 'Un autre utilisateur a modifié l''enregistrement de cette %1 alors que vous étiez en train de travailler dessus.', NLB = 'Een andere gebruiker heeft de record voor deze %1 gewijzigd nadat u het in de database hebt opgevraagd.';
        Text11302: TextConst ENU = 'Apply General Ledger Entries', FRB = 'Lettrer écritures comptables', NLB = 'Grootboekposten vereffenen';
        Text11303: TextConst ENU = 'Applied General Ledger Entries', FRB = 'Ecritures comptables lettrées', NLB = 'Vereffende grootboekposten';
        Text11304: TextConst ENU = 'You can apply multiple entries only if all entries being applied can be fully closed.', FRB = 'Vous ne pouvez lettrer plusieurs écritures que si toutes les écritures lettrées peuvent être entièrement clôturées.', NLB = 'U kunt alleen meerdere posten vereffenen als alle vereffende posten volledig kunnen worden gesloten.';
        Text11305: TextConst ENU = 'There are no general ledger entries to apply', FRB = 'Il n''y a aucune écriture comptable à lettrer', NLB = 'Er zijn grootboekposten te vereffenen';

    procedure SetAllEntries(GLAccNo: Code[20]);
    var
        GLEntry: Record "G/L Entry";
        Window: Dialog;
        LineCount: Integer;
        NoOfRecords: Integer;
    begin
        GLEntry.SETCURRENTKEY("G/L Account No.");
        GLEntry.SETRANGE("G/L Account No.", GLAccNo);
        GLEntry.SETRANGE(Reversed, false);
        GLEntry.SETRANGE("Open FND", true);
        if GLEntry.findset() then
            repeat
                TransferGLEntry(G_TempGLEntryBuf, GLEntry);
            until GLEntry.NEXT() = 0;
    end;

    local procedure TransferGLEntry(var GLEntryBuf: Record "G/L Entry Application Bffr FND"; GLEntry: Record "G/L Entry");
    begin
        GLEntryBuf.TRANSFERFIELDS(GLEntry);
        GLEntryBuf.Positive := GLEntry.Amount > 0;
        GLEntryBuf.INSERT();
    end;

    procedure Apply(var GLEntryBuf: Record "G/L Entry Application Bffr FND");
    var
        AccountingPeriod: Record "Accounting Period";
        GLEntry: Record "G/L Entry";
        GLEntryBufBalanced: Record "G/L Entry Application Bffr FND" temporary;
        GeneralLedSetup: Record "General Ledger Setup";
        AppliedAmount: Decimal;
        RemainingAmount: Decimal;
        TotalAppliedAmount: Decimal;
        TotalBalanced: Decimal;
        BaseEntryNo: Integer;
    begin

        GLEntryBuf.TESTFIELD("Applies-to ID");
        BaseEntryNo := GLEntryBuf."Entry No.";
        RemainingAmount := GLEntryBuf."Remaining Amount";

        RealEntryChanged(GLEntryBuf, GLEntry);
        //<<FDD-HNK-Auto Clear HNK 10/10/16
        TotalBalanced := 0;
        GLEntryBufBalanced.COPY(GLEntryBuf, true);
        GLEntryBufBalanced.SETCURRENTKEY("Applies-to ID");
        GLEntryBufBalanced.SETRANGE("Applies-to ID", GLEntryBuf."Applies-to ID");
        if GLEntryBufBalanced.findset() then begin
            repeat

                //>>HEI.01  12-07-2019
                GeneralLedSetup.GET();
                //IF GeneralLedSetup."Final Reporting Extracted" = TRUE THEN BEGIN //HEI.05
                if (GeneralLedSetup."Final Reporting Extracted FND" = true) and not skipforundo then begin //HEI.05
                    if AccountingPeriod.GET(CALCDATE('<CM+1D-2M>', TODAY)) and (not AccountingPeriod."Final Reporting Extracted FND") then begin
                        ERROR(TXT50001);
                    end;
                end;
                //<<HEI.01  12-07-2019

                TotalBalanced += GLEntryBufBalanced."Remaining Amount";
            until GLEntryBufBalanced.NEXT() = 0;
        end;
        if (not AllowPartialApplication) and (TotalBalanced <> 0) then
            ERROR(TXT50000);
        //<<FDD-HNK-Auto Clear HNK 10/10/16

        GLEntryBuf.SETCURRENTKEY("Applies-to ID");
        GLEntryBuf.SETRANGE("Applies-to ID", GLEntryBuf."Applies-to ID");
        GLEntryBuf.SETFILTER("Entry No.", '<> %1', GLEntryBuf."Entry No.");
        if GLEntryBuf.FIND('-') then begin
            repeat
                GLEntryBuf.TESTFIELD("G/L Account No.", GLEntryBuf."G/L Account No.");
                GLEntryBuf.TESTFIELD(Open, true);
                AppliedAmount := -GLEntryBuf."Remaining Amount";
                TotalAppliedAmount := TotalAppliedAmount + AppliedAmount;
                RealEntryChanged(GLEntryBuf, GLEntry);
                UpdateTempTable(GLEntryBuf, 0, false, BaseEntryNo, GLEntryBuf."Posting Date", -AppliedAmount, '');
                UpdateRealTable(GLEntry, 0, false, BaseEntryNo, GLEntryBuf."Posting Date", -AppliedAmount, '');
            until GLEntryBuf.NEXT() = 0;
        end else
            exit;

        // Update entry where cursor is on
        // Update real Table
        // BC Upgrade PATELS08 >> # Blocked "With" statment as it is deprecated and prefixed variables with 'GLEntry'
        // with GLEntry do begin
        // GET(BaseEntryNo);
        // UpdateRealTable(
        //   GLEntry, "Remaining Amount" - TotalAppliedAmount,
        //   ("Remaining Amount" - TotalAppliedAmount) <> 0, 0, 0D, 0, '');
        GLEntry.GET(BaseEntryNo);
        UpdateRealTable(
          GLEntry, GLEntry."Remaining Amount FND" - TotalAppliedAmount,
          (GLEntry."Remaining Amount FND" - TotalAppliedAmount) <> 0, 0, 0D, 0, '');
        // end;
        // BC Upgrade PATELS08 >>

        // Update Temporary Table
        // BC UPGRADE PATELS08 >> # Blocked "With" statment as it is deprecated and prefixed variables with 'GLEntryBuf'
        // with GLEntryBuf do begin
        // GET(BaseEntryNo);
        // UpdateTempTable(
        //   GLEntryBuf, "Remaining Amount" - TotalAppliedAmount,
        //   ("Remaining Amount" - TotalAppliedAmount) <> 0, 0, 0D, 0, '');
        GLEntryBuf.GET(BaseEntryNo);
        UpdateTempTable(
          GLEntryBuf, GLEntryBuf."Remaining Amount" - TotalAppliedAmount,
          (GLEntryBuf."Remaining Amount" - TotalAppliedAmount) <> 0, 0, 0D, 0, '');
        // end;
        // BC UPGRADE PATELS08 <<

        ShowTotalAppliedAmount := 0;
    end;

    procedure RealEntryChanged(TempEntry: Record "G/L Entry Application Bffr FND"; var GlEntry: Record "G/L Entry");
    begin
        // 'Real' G/L Entry changed whilst application ?
        // BC Upgrade PATELS08 >> # Blocked "With" statment as it is deprecated and prefixed variables with 'GlEntry'
        // with GlEntry do begin
        // LOCKTABLE();
        // GET(TempEntry."Entry No.");
        // if ("Remaining Amount" <> TempEntry."Remaining Amount") or
        //    (Open <> TempEntry.Open) or
        //    ("Closed by Entry No." <> TempEntry."Closed by Entry No.") or
        //    ("Closed at Date" <> TempEntry."Closed at Date") or
        //    ("Closed by Amount" <> TempEntry."Closed by Amount")
        //  then
        //     ERROR(Text11301, GlEntry.TABLECAPTION);

        GlEntry.LOCKTABLE();
        GlEntry.GET(TempEntry."Entry No.");
        if (GlEntry."Remaining Amount FND" <> TempEntry."Remaining Amount") or
           (GlEntry."Open FND" <> TempEntry.Open) or
           (GlEntry."Closed by Entry No. FND" <> TempEntry."Closed by Entry No.") or
           (GlEntry."Closed at Date FND" <> TempEntry."Closed at Date") or
           (GlEntry."Closed by Amount FND" <> TempEntry."Closed by Amount")
         then
            ERROR(Text11301, GlEntry.TABLECAPTION);
        // end;
        // BC Upgrade PATELS08 <<
    end;

    procedure UpdateTempTable(var TempEntry: Record "G/L Entry Application Bffr FND"; RemainingAmt: Decimal; IsOpen: Boolean; ClosedbyEntryNo: Integer; ClosedbyDate: Date; ClosedbyAmt: Decimal; AppliesToID: Code[50]);
    begin
        // Update Temporary Table
        // BC Upgrade PATELS08 >> # Blocked "With" statment as it is deprecated and prefixed variables with 'TempEntry'
        // with TempEntry do begin
        //     "Remaining Amount" := RemainingAmt;
        //     Open := IsOpen;
        //     "Closed by Entry No." := ClosedbyEntryNo;
        //     "Closed at Date" := ClosedbyDate;
        //     "Closed by Amount" := ClosedbyAmt;
        //     "Applies-to ID" := AppliesToID;
        //     "Entries Posted By" := USERID;
        //     MODIFY();

        TempEntry."Remaining Amount" := RemainingAmt;
        TempEntry.Open := IsOpen;
        TempEntry."Closed by Entry No." := ClosedbyEntryNo;
        TempEntry."Closed at Date" := ClosedbyDate;
        TempEntry."Closed by Amount" := ClosedbyAmt;
        TempEntry."Applies-to ID" := AppliesToID;
        TempEntry."Entries Posted By" := USERID();
        TempEntry.MODIFY();
        // end;
        // BC Upgrade PATELS08 <<
    end;

    procedure UpdateRealTable(RealEntry: Record "G/L Entry"; RemainingAmt: Decimal; IsOpen: Boolean; ClosedbyEntryNo: Integer; ClosedbyDate: Date; ClosedbyAmt: Decimal; AppliesToID: Code[50]);
    begin
        // Update Temporary Table

        // BC Upgrade PATELS08 >> # Blocked "With" statment as it is deprecated and prefixed variables with 'RealEntry'
        // with RealEntry do begin
        // "Remaining Amount" := RemainingAmt;
        // Open := IsOpen;
        // "Closed by Entry No." := ClosedbyEntryNo;
        // "Closed at Date" := ClosedbyDate;
        // "Closed by Amount" := ClosedbyAmt;
        // "Applies-to ID" := AppliesToID;
        // "Entries Posted By" := USERID; //>>HEI.02
        // MODIFY();

        RealEntry."Remaining Amount FND" := RemainingAmt;
        RealEntry."Open FND":= IsOpen;
        RealEntry."Closed by Entry No. FND" := ClosedbyEntryNo;
        RealEntry."Closed at Date FND" := ClosedbyDate;
        RealEntry."Closed by Amount FND" := ClosedbyAmt;
        RealEntry."Applies-to ID FND" := AppliesToID;
        RealEntry."Entries Posted By FND" := USERID; //>>HEI.02
        RealEntry.MODIFY();

        // end;
        // BC Upgrade PATELS08 <<
    end;

    procedure SetApplId(var GLEntryBuf: Record "G/L Entry Application Bffr FND");
    begin
        GLEntryBuf.TESTFIELD(Open, true);
        if GLEntryBuf.FIND('-') then begin
            // Make Applies-to ID
            if GLEntryBuf."Applies-to ID" <> '' then begin
                GLEntryApplID := '';
                ShowTotalAppliedAmount := ShowTotalAppliedAmount - GLEntryBuf."Remaining Amount";
            end else begin
                GLEntryApplID := USERID;
                if GLEntryApplID = '' then
                    GLEntryApplID := '***';
                ShowTotalAppliedAmount := ShowTotalAppliedAmount + GLEntryBuf."Remaining Amount";
            end;

            // Set Applies-to ID
            repeat
                GLEntryBuf.TESTFIELD(Open, true);
                GLEntryBuf."Applies-to ID" := GLEntryApplID;
                GLEntryBuf.MODIFY();
            until GLEntryBuf.NEXT() = 0;
        end;
    end;

    procedure UpdateAllowpartial(P_Allowpartail: Boolean);
    begin

        AllowPartialApplication := P_Allowpartail;
    end;

    procedure Setundoflag(skipforundoReceipt: Boolean);
    begin
        //HEI.05
        skipforundo := skipforundoReceipt;
    end;
}

