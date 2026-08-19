codeunit 51037 "GL Bulk App-Post Group CBN"
{
    // HEI.01 CHG2317671 IBM POENAB02 08.10.2025 HB2428 Excel Mapping Report IBM tool for closing GL entries for GL Account with big volume of data
    //   # Object created

    // BC Upgrade PATELS08 >>
    // # Created Codeunit
    // # Nav ID : 50235
    // BC Upgrade PATELS08 <<

    Permissions = tabledata "G/L Entry" = rim;
 
    var
        GLBulkApplication: Record "GL Bulk Application FND";
        ApplicationCombination: Integer;
        TempGLEntryBuf: Record "G/L Entry Application Bffr FND" temporary;
        TempGLEntryBuf3: Record "G/L Entry Application Bffr FND";
        GLEntryApplID: Code[50];
        ShowTotalAppliedAmount: Decimal;
        GLEntry: Record "G/L Entry";
        GLEntry2: Record "G/L Entry";
        i : Integer;
        AllowPartialApplication: Boolean;
        GLSetup: Record "General Ledger Setup";
        TXT50000: Label 'You cannot apply the G/L entries because the final reporting isn''t extracted yet.';
        TXT50001: Label 'Partial application  isn''t allowed';
        Text11301: Label 'Another user has modified the record for this %1 after you retrieved it from the database.';

    trigger OnRun()
    begin
        AllowPartialApplication := FALSE;
        GLSetup.GET;
        GLBulkApplication.RESET;

        TempGLEntryBuf.RESET;
        TempGLEntryBuf.DELETEALL;
        TempGLEntryBuf3.RESET;
        TempGLEntryBuf3.DELETEALL;
        i := 1;

        GLBulkApplication.SETRANGE("Application Combination",ApplicationCombination);
        IF GLBulkApplication.FINDSET(FALSE) THEN
        REPEAT
            IF i = 1 THEN
            BEGIN
                GLEntry.GET(GLBulkApplication."Entry No.");
                TransferGLEntry(TempGLEntryBuf,GLEntry);
            END;

            GLEntry2.GET(GLBulkApplication."Entry No. To Apply To");
            TransferGLEntry(TempGLEntryBuf,GLEntry2);
            i += 1;
        UNTIL GLBulkApplication.NEXT = 0;

        //set Applies-to ID
        SetApplId(TempGLEntryBuf);

        //post application
        TempGLEntryBuf.RESET;
        TempGLEntryBuf.SETFILTER("Applies-to ID",'<>%1','');
        IF TempGLEntryBuf.FINDFIRST THEN
        REPEAT
            TempGLEntryBuf3.RESET;
            TempGLEntryBuf3.SETRANGE("Applies-to ID",TempGLEntryBuf."Applies-to ID");
            IF NOT TempGLEntryBuf3.FINDFIRST THEN
            BEGIN
                TempGLEntryBuf3.TRANSFERFIELDS(TempGLEntryBuf);
                IF TempGLEntryBuf3.INSERT THEN;
            END;
        UNTIL TempGLEntryBuf.NEXT = 0;

        IF TempGLEntryBuf3.COUNT = 1 THEN
        BEGIN
            TempGLEntryBuf.COPY(TempGLEntryBuf3);
            Apply(TempGLEntryBuf);
        END;

        IF TempGLEntryBuf3.COUNT > 1 THEN
        REPEAT
            TempGLEntryBuf.RESET;
            TempGLEntryBuf.COPY(TempGLEntryBuf3);
            Apply(TempGLEntryBuf);
        UNTIL TempGLEntryBuf3.NEXT = 0;

        TempGLEntryBuf.RESET;
        TempGLEntryBuf.DELETEALL;
        TempGLEntryBuf3.RESET;
        TempGLEntryBuf3.DELETEALL;

    end;
 
    procedure SetApplicationCombination(CombApplication: Integer)
    begin
        ApplicationCombination := CombApplication;
    end;
 
    local procedure TransferGLEntry(var GLEntryBuf: Record "G/L Entry Application Bffr FND"; GLEntry: Record "G/L Entry")
    begin
        GLEntryBuf.TRANSFERFIELDS(GLEntry);
        GLEntryBuf.Positive := GLEntry.Amount > 0;
        GLEntryBuf.Comment := GLEntry.Comment;
        GLEntryBuf.INSERT;
    end;
 
    local procedure SetApplId(var GLEntryBuf: Record "G/L Entry Application Bffr FND")
    begin
        GLEntryBuf.TESTFIELD(Open,TRUE);
        IF GLEntryBuf.FIND('-') THEN BEGIN
            // Make Applies-to ID
            IF GLEntryBuf."Applies-to ID" <> '' THEN BEGIN
                GLEntryApplID := '';
                ShowTotalAppliedAmount := ShowTotalAppliedAmount - GLEntryBuf."Remaining Amount";
            END ELSE BEGIN
                GLEntryApplID := USERID;
                IF GLEntryApplID = '' THEN
                GLEntryApplID := '***';
                ShowTotalAppliedAmount := ShowTotalAppliedAmount + GLEntryBuf."Remaining Amount";
            END;

            // Set Applies-to ID
            REPEAT
                GLEntryBuf.TESTFIELD(Open,TRUE);
                GLEntryBuf."Applies-to ID" := GLEntryApplID;
                GLEntryBuf.MODIFY;
            UNTIL GLEntryBuf.NEXT = 0;
        END;
    end;
 
    local procedure Apply(var GLEntryBuf: Record "G/L Entry Application Bffr FND")
    var
        GLEntry: Record "G/L Entry";
        AppliedAmount: Decimal;
        TotalAppliedAmount: Decimal;
        RemainingAmount: Decimal;
        BaseEntryNo: Integer;
        GLEntryBufBalanced: Record "G/L Entry Application Bffr FND";
        TotalBalanced: Decimal;
        AccountingPeriod: Record "Accounting Period";
        GeneralLedSetup: Record "General Ledger Setup";
        LoopReturn: Integer;
        LetterNoSeries: Text[20];
        NoSeriesMgt: Codeunit GlobalNoSeriesManagement;
        LetterDate: Date;
    begin
        GLEntryBuf.TESTFIELD("Applies-to ID");
        BaseEntryNo := TempGLEntryBuf."Entry No.";
        RemainingAmount := GLEntryBuf."Remaining Amount";

        GLEntry.GET(TempGLEntryBuf."Entry No.");

        RealEntryChanged(TempGLEntryBuf,GLEntry);
        TotalBalanced := 0;

        GLEntryBufBalanced.COPY(GLEntryBuf,TRUE);
        GLEntryBufBalanced.SETCURRENTKEY("Applies-to ID");
        GLEntryBufBalanced.SETRANGE("Applies-to ID",GLEntryBuf."Applies-to ID");
        IF GLEntryBufBalanced.FINDSET(FALSE) THEN BEGIN
        REPEAT
            GeneralLedSetup.GET;
            IF GeneralLedSetup."Final Reporting Extracted FND" = TRUE THEN BEGIN
            IF AccountingPeriod.GET(CALCDATE('<CM+1D-2M>',TODAY)) AND (NOT AccountingPeriod."Final Reporting Extracted FND") THEN BEGIN
                ERROR(TXT50001);
            END;
            END;
            TotalBalanced += GLEntryBufBalanced."Remaining Amount";
        UNTIL GLEntryBufBalanced.NEXT = 0;
        END;
        IF (NOT AllowPartialApplication) AND (TotalBalanced <> 0) THEN
        ERROR(TXT50000);

        GLSetup.TESTFIELD("G/L Application No. Series FND");
        LetterNoSeries := NoSeriesMgt.GetNextGlobalNo(GLSetup."G/L Application No. Series FND",TODAY(),TRUE);
        LetterDate     := TODAY();

        GLEntryBuf.SETCURRENTKEY("Applies-to ID");
        GLEntryBuf.SETRANGE("Applies-to ID",GLEntryBuf."Applies-to ID");
        GLEntryBuf.SETFILTER("Entry No.",'<> %1',GLEntryBuf."Entry No.");
        IF GLEntryBuf.FIND('-') THEN BEGIN
        REPEAT
            GLEntryBuf.TESTFIELD("G/L Account No.",GLEntryBuf."G/L Account No.");
            GLEntryBuf.TESTFIELD(Open,TRUE);
            AppliedAmount := -GLEntryBuf."Remaining Amount";
            TotalAppliedAmount := TotalAppliedAmount + AppliedAmount;
            RealEntryChanged(GLEntryBuf,GLEntry);
            UpdateTempTable(GLEntryBuf,0,FALSE,BaseEntryNo,GLEntryBuf."Posting Date",-AppliedAmount,'',LetterNoSeries,LetterDate);
            UpdateRealTable(GLEntry,0,FALSE,BaseEntryNo,GLEntryBuf."Posting Date",-AppliedAmount,'',LetterNoSeries,LetterDate);
        UNTIL GLEntryBuf.NEXT = 0;
        END ELSE
        EXIT;
        // Update entry where cursor is on
        // Update real Table
        GLEntry.GET(BaseEntryNo);
        UpdateRealTable(
            GLEntry, GLEntry."Remaining Amount FND" - TotalAppliedAmount,
            (GLEntry."Remaining Amount FND" - TotalAppliedAmount) <> 0, 0, 0D, 0, '', LetterNoSeries, LetterDate);
        // Update Temporary Table
        TempGLEntryBuf.GET(BaseEntryNo);
        UpdateTempTable(
            TempGLEntryBuf, TempGLEntryBuf."Remaining Amount" - TotalAppliedAmount,
            (TempGLEntryBuf."Remaining Amount" - TotalAppliedAmount) <> 0, 0, 0D, 0, '', LetterNoSeries, LetterDate);

        ShowTotalAppliedAmount := 0;

    end;
 
    local procedure RealEntryChanged(TempEntry: Record "G/L Entry Application Bffr FND"; var GlEntry: Record "G/L Entry")
    begin
        // 'Real' G/L Entry changed
        GlEntry.LOCKTABLE();
        GlEntry.GET(TempEntry."Entry No.");
        IF (GlEntry."Remaining Amount FND" <> TempEntry."Remaining Amount") OR
            (GlEntry."Open FND" <> TempEntry.Open) OR
            (GlEntry."Closed by Entry No. FND" <> TempEntry."Closed by Entry No.") OR
            (GlEntry."Closed at Date FND" <> TempEntry."Closed at Date") OR
            (GlEntry."Closed by Amount FND" <> TempEntry."Closed by Amount")
        THEN
            ERROR(Text11301, GlEntry.TABLECAPTION);
    end;
 
    local procedure UpdateTempTable(
    VAR
        TempEntry : Record "G/L Entry Application Bffr FND";
        RemainingAmt : Decimal;
        IsOpen : Boolean;
        ClosedbyEntryNo : Integer;
        ClosedbyDate : Date;
        ClosedbyAmt : Decimal;
        AppliesToID : Code[50];
        LetterNoSeries : Text[20];
        LetterDate : Date)
    begin
        TempEntry."Remaining Amount" := RemainingAmt;
        TempEntry.Open := IsOpen;
        TempEntry."Closed by Entry No." := ClosedbyEntryNo;
        TempEntry."Closed at Date" := ClosedbyDate;
        TempEntry."Closed by Amount" := ClosedbyAmt;
        TempEntry."Applies-to ID" := AppliesToID;
        TempEntry."Entries Posted By" := USERID;
        TempEntry.Letter := LetterNoSeries;
        TempEntry."Letter Date" := LetterDate;
        TempEntry.MODIFY();
    end;
 
    local procedure UpdateRealTable(
        RealEntry : Record "G/L Entry";
        RemainingAmt : Decimal;
        IsOpen : Boolean;
        ClosedbyEntryNo : Integer;
        ClosedbyDate : Date;
        ClosedbyAmt : Decimal;
        AppliesToID : Code[50];
        LetterNoSeries : Text[20];
        LetterDate : Date)
    begin
        // Update Temporary Table
        RealEntry."Remaining Amount FND" := RemainingAmt;
        RealEntry."Open FND" := IsOpen;
        RealEntry."Closed by Entry No. FND" := ClosedbyEntryNo;
        RealEntry."Closed at Date FND" := ClosedbyDate;
        RealEntry."Closed by Amount FND" := ClosedbyAmt;
        RealEntry."Applies-to ID FND" := AppliesToID;
        RealEntry."Entries Posted By FND" := USERID;
        RealEntry.LetterFND := LetterNoSeries;
        RealEntry."Letter Date FND" := LetterDate;
        RealEntry.MODIFY;
    end;
 
    
}