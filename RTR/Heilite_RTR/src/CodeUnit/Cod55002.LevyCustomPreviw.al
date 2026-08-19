codeunit 55002 "Levy Preview Custom RTR"
{
    //Bc Upgrade YADAVM09 Codeunit created to get current leavy transactions.
    //Bc upgrade YADAVM09 08072026 added to delete Previous Levy entries.
    //Bc Upgrade YADAVM09 Code added to fix Bug BCUP0-200.
    SingleInstance = true;
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::"Levy Tax Entries FND", OnAfterInsertEvent, '', false, false)]
    local procedure OnInsertLevyTaxEntry(VAR Rec: Record "Levy Tax Entries FND"; RunTrigger: Boolean)
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";

    begin
        //HEI.01>>
        PurchasesPayablesSetup.GET();
        IF PurchasesPayablesSetup."H&S Levy Tax FND" THEN BEGIN

            IF Rec.ISTEMPORARY THEN
                EXIT;
            TempLevyTaxEntries.DeleteAll();//Bc upgrade YADAVM09 08072026<<
            if TempLevyTaxEntries.Get(Rec."Entry No.") then
                exit;

            TempLevyTaxEntries := Rec;
            TempLevyTaxEntries."Doc. No." := '***';
            TempLevyTaxEntries.INSERT();
        END;
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Levy Tax Entries FND", OnAfterModifyEvent, '', false, false)]
    local procedure OnModifyGLEntry(var Rec: Record "Levy Tax Entries FND"; RunTrigger: Boolean)
    var
        PostingPreviewEventHandler: Codeunit "Posting Preview Event Handler";
    begin
        if Rec.IsTemporary() then
            exit;
        TempLevyTaxEntries := Rec;
        TempLevyTaxEntries."Doc. No." := '***';
        if not TempLevyTaxEntries.Insert() then
            TempLevyTaxEntries.Modify();
    end;

    Procedure SetNextTransactionNo(var pNextTransactionNo: Integer)

    begin
        NextTransactionNo := pNextTransactionNo;
    end;

    Procedure GetNextTransactionNo(): Integer
    begin
        exit(NextTransactionNo);
    end;

    procedure GetTempLevyTaxEntries(var OutTempLevyTaxEntries: Record "Levy Tax Entries FND" temporary)
    begin
        OutTempLevyTaxEntries.Copy(TempLevyTaxEntries, true);
    end;
    //Bc Upgrade YADAVM09>>
    Procedure SetAnalysisViewCode(var pNextTransactionNo: Code[10])

    begin
        AnalysisViewCode := pNextTransactionNo;
    end;

    Procedure getAnalysisViewCode(): Code[10]
    begin
        exit(AnalysisViewCode);
    end;

    //Bc Upgrade YADAVM09<<
    //Bc Upgrade YADAVM09 BCUP0-140>>
    procedure SetValueforGLaccountCil3(Value: Code[250])
    begin
        LastValue := Value;
    end;

    procedure GetValueforGLaccountCil3(): Code[250]
    begin
        exit(LastValue);
    end;
    //Bc Upgrade YADAVM09 BCUP0-140<<

    //Bc Upgrade YADAVM09 BCUP0-200>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPostFixedAssetOnBeforeAssignGLEntry, '', false, false)]
    local procedure OnPostFixedAssetOnBeforeAssignGLEntry(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJnlLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var GLEntry2: Record "G/L Entry")
    var
        DepreciationBook: Record "Depreciation Book";
        FASetup: record "FA Posting Group";
        FALedgerEntry: Record "FA Ledger Entry";
    begin
        //>>HEI.06
        IF FALedgerEntry.GET(GLEntry."FA Entry No.") THEN BEGIN
            // FAGAAPPosting(GenJnlLine, FALedgerEntry."FA Posting Category", FALedgerEntry.Amount, GLEntry, FALedgerEntry."FA Posting Group"
            // , FALedgerEntry."FA Posting Type", FALedgerEntry."Depreciation Book Code");

            DepreciationBook.GET(FALedgerEntry."Depreciation Book Code");
            IF DepreciationBook."Disposal Calculation Method" = DepreciationBook."Disposal Calculation Method"::Gross THEN EXIT;
            FASetup.GET(FALedgerEntry."FA Posting Group");
            CASE FALedgerEntry."FA Posting Type" OF
                FALedgerEntry."FA Posting Type"::Depreciation:
                    BEGIN
                        IF DepreciationBook."Part of Duplication List" THEN BEGIN
                            FASetup.TESTFIELD(FASetup."Accum. Dep. Account Offset FND");
                            FASetup.TESTFIELD(FASetup."Dep. Expense Acc Offset FND");
                            //>>HEI.08
                            FASetup.TESTFIELD(FASetup."Acqi.CostAcc.Dsposl Offset FND");
                            //<<HEI.08
                        END;

                        IF (FASetup."Accum. Dep. Account Offset FND" <> '') OR (FASetup."Dep. Expense Acc Offset FND" <> '') THEN BEGIN
                            FASetup.TESTFIELD(FASetup."Accum. Dep. Account Offset FND");
                            FASetup.TESTFIELD(FASetup."Dep. Expense Acc Offset FND");

                            //GenJnlPostline.InitGLEntry(GenJnlLine, TempGLEntry, FASetup."Accum. Dep. Account Offset FND", -1 * Amount, tempglentry."Additional-Currency Amount", TRUE, TRUE);
                            Sender.CreateGLEntry(GenJnlLine, FASetup."Accum. Dep. Account Offset FND", ROUND(-GLEntry.amount), ROUND(-GLEntry."Additional-Currency Amount"), TRUE);
                            //InitFACommonFields(TempGLEntry);
                            //GenJnlPostline.InsertGLEntry(GenJnlLine, tempglentry, TRUE);
                            IF FALedgerEntry."FA Posting Category" = FALedgerEntry."FA Posting Category"::" " THEN BEGIN
                                //GenJnlPostline.InitGLEntry(GenJnlLine, TempGLEntry, FASetup."Dep. Expense Acc Offset FND", Amount, tempglentry."Additional-Currency Amount", TRUE, TRUE);
                                Sender.CreateGLEntry(GenJnlLine, FASetup."Dep. Expense Acc Offset FND", ROUND(GLEntry.amount), ROUND(-GLEntry."Additional-Currency Amount"), TRUE);
                                //InitFACommonFields(GLEntry);
                                //GenJnlPostline.InsertGLEntry(GenJnlLine, tempglentry, TRUE);
                            END;
                            //>>HEI.08
                            //HEI.30 commented
                            //   { IF FAPostingCategory=FAPostingCategory::Disposal THEN BEGIN
                            //       InitGLEntry(GenJnlLine,GLEntry,FASetup."Acqi.Cost Acc. Disposal Offset", -1 * TempGLEntry.Amount, TempGLEntry."Additional-Currency Amount",TRUE,TRUE);
                            //       InitFACommonFields(GLEntry);
                            //       InsertGLEntry(GenJnlLine,GLEntry,TRUE);
                            //      END; }
                            //<<HEI.08
                            //HEI.30 commented
                        END;
                    END;

                FALedgerEntry."FA Posting Type"::"Gain/Loss":
                    BEGIN
                        IF GenJnlLine."FA Posting Type" <> GenJnlLine."FA Posting Type"::Depreciation THEN BEGIN
                            IF DepreciationBook."Part of Duplication List" THEN BEGIN
                                FASetup.TESTFIELD(FASetup."GainAcc.on Disposal Offset FND");
                                FASetup.TESTFIELD(FASetup."SaleBal.Acc.on Disp.Offset FND");
                                FASetup.TESTFIELD(FASetup."Losses Acc. on Disp. Off FND");
                            END;
                            IF (FASetup."GainAcc.on Disposal Offset FND" <> '') OR (FASetup."SaleBal.Acc.on Disp.Offset FND" <> '')
                              OR (FASetup."Losses Acc. on Disp. Off FND" <> '') THEN BEGIN
                                FASetup.TESTFIELD(FASetup."GainAcc.on Disposal Offset FND");
                                FASetup.TESTFIELD(FASetup."SaleBal.Acc.on Disp.Offset FND");
                                FASetup.TESTFIELD(FASetup."Losses Acc. on Disp. Off FND");
                                IF GLEntry.Amount < 0 THEN BEGIN
                                    // GenJnlPostline.InitGLEntry(GenJnlLine, glentry, FASetup."GainAcc.on Disposal Offset FND", -1 * glentry.Amount, glentry."Additional-Currency Amount", TRUE, TRUE);
                                    Sender.CreateGLEntry(GenJnlLine, FASetup."GainAcc.on Disposal Offset FND", ROUND(-GLEntry.amount), ROUND(GLEntry."Additional-Currency Amount"), TRUE);
                                    //BRM InitFACommonFields(GLEntry);
                                    //BRM InsertGLEntry(GenJnlLine,GLEntry,TRUE);
                                END
                                ELSE
                                    // GenJnlPostline.InitGLEntry(GenJnlLine, glentry, FASetup."Losses Acc. on Disp. Off FND", -1 * glentry.Amount, glentry."Additional-Currency Amount", TRUE, TRUE);
                                    Sender.CreateGLEntry(GenJnlLine, FASetup."Losses Acc. on Disp. Off FND", ROUND(-GLEntry.amount), ROUND(GLEntry."Additional-Currency Amount"), TRUE);
                                //InitFACommonFields(tempglentry);
                                //GenJnlPostline.InsertGLEntry(GenJnlLine, glentry, TRUE);//Bc Upgrade YADAVM09<<
                                //HEI.30 commented<<
                                //>>HEI.29
                                // {  IF GenJnlLine.Amount = 0 THEN
                                //     InitGLEntry(GenJnlLine, GLEntry, FASetup."Sales Bal.Acc. on Disp. Offset", Amount, GLEntry."Additional-Currency Amount",TRUE,TRUE)
                                //   ELSE IF  GenJnlLine.Amount <> 0 THEN }
                                //<<HEI.29
                                //HEI.30 commented>>
                                //HEI.08 comment line InitGLEntry(GenJnlLine,GLEntry,FASetup."Sales Bal.Acc. on Disp. Offset",Amount,GLEntry."Additional-Currency Amount",TRUE,TRUE);
                                //>>HEI.08
                                //GenJnlPostline.InitGLEntry(GenJnlLine, glentry, FASetup."SaleBal.Acc.on Disp.Offset FND", GenJnlLine.Amount, glentry."Additional-Currency Amount", TRUE, TRUE);
                                //<<HEI.08
                                //InitFACommonFields(GLEntry);
                                //GenJnlPostline.InsertGLEntry(GenJnlLine, glentry, TRUE);
                                Sender.CreateGLEntry(GenJnlLine, FASetup."SaleBal.Acc.on Disp.Offset FND", ROUND(GLEntry.amount), ROUND(GLEntry."Additional-Currency Amount"), TRUE);

                            END;
                        END;
                    END;
                FALedgerEntry."FA Posting Type"::"Acquisition Cost":
                    BEGIN
                        //for acquisitions use the BASE solution
                        //uncommented HEI.30<<
                        IF FALedgerEntry."FA Posting Category" <> FALedgerEntry."FA Posting Category"::" " THEN BEGIN
                            IF (FASetup."Acqi.CostAcc.Dsposl Offset FND" <> '') THEN BEGIN
                                FASetup.TESTFIELD(FASetup."Acqi.CostAcc.Dsposl Offset FND");
                                //GenJnlPostline.InitGLEntry(GenJnlLine, glentry, FASetup."Acqi.CostAcc.Dsposl Offset FND", -1 * glentry.Amount, glentry."Additional-Currency Amount", TRUE, TRUE);//Bc Upgrade YADAVM09<<
                                // InitFACommonFields(GLEntry);
                                // GenJnlPostline.InsertGLEntry(GenJnlLine, glentry, TRUE);
                                Sender.CreateGLEntry(GenJnlLine, FASetup."Acqi.CostAcc.Dsposl Offset FND", ROUND(-GLEntry.amount), ROUND(GLEntry."Source Currency Amount"), TRUE);//Bc Upgrade YADAVM09<<
                            END;
                        END;
                        //uncommented HEI.30>>
                    END;

                //HEI.30<<
                FALedgerEntry."FA Posting Type"::"Write-Down":
                    BEGIN
                        IF FALedgerEntry."FA Posting Category" = FALedgerEntry."FA Posting Category"::Disposal THEN
                            IF (FASetup."Write-Down Bal. Acc. on Disp." <> '') THEN BEGIN
                                FASetup.TESTFIELD("Write-Down Bal. Acc. on Disp.");
                                //GenJnlPostline.InitGLEntry(GenJnlLine, GLEntry, FASetup."Write-Down Bal. Acc. on Disp.", -1 * glentry.Amount, glentry."Additional-Currency Amount", TRUE, TRUE);
                                // InitFACommonFields(GLEntry);
                                //GenJnlPostline.InsertGLEntry(GenJnlLine, GLEntry, TRUE);
                                Sender.CreateGLEntry(GenJnlLine, FASetup."Write-Down Bal. Acc. on Disp.", ROUND(-GLEntry.amount), ROUND(GLEntry."Source Currency Amount"), TRUE);//Bc Upgrade YADAVM09<<
                            END;
                    END;
            //HEI.30>>
            END;
        END;
        //<<HEI.06

    end;
    //Bc Upgrade YADAVM09 BCUP0-200<<

    var

        TempLevyTaxEntries: Record "Levy Tax Entries FND" temporary;
        NextTransactionNo: Integer;
        AnalysisViewCode: Code[10];
        LastValue: Code[250];//Bc Upgrade YADAVM09 BCUP0-140<<
}