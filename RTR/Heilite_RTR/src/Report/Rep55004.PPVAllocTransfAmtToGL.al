report 55004 "PPV Alloc. Transf Amt to GL"
{
    // version HEI.03

    // HEI.01 CHG2193490 IBM SISUM01 27/07/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # new object created
    // HEI.02 CHG2193490 IBM POENAB02 08.08.2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # Modified function InsertGenJnlLine
    // HEI.03 CHG2193490 IBM SISUM01 11/09/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # Modified function InsertGenJnlLine

    // BC Upgrade POENAB02: Original (HeiLite) report id 50168

    // BC Upgrade POENAB02, 26.03.2026, FDD FDD-RTR-024 "Purchase Price Variance Allocation"

    Caption = 'Transfer PPV Allocation Amount into a G/L Journal';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Tasks;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = sorting(Number) where(Number = const(1));

            trigger OnAfterGetRecord();
            begin
                PPVAllocationHeader.SetRange(Month, Month);
                PPVAllocationHeader.SetRange(Year, Year);

                if GuiAllowed then begin
                    NoOfRecords := PPVAllocationHeader.Count;
                    NoOfRecProgress := NoOfRecords div 100;
                    Counter := 0;
                    NoOfProgresed := 0;
                    TimeProgress := Time;
                end;

                CreateGenJnlLine();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(PPVAllocDate; PPVAllocDateVar)
                {
                    ToolTip = 'Specifies the PPV Allocation Date for which the amounts will be transferred to the G/L Journal.';
                    Caption = 'PPV Allocation Date';
                    ApplicationArea = All;
                }
                field(GenJnlTemplateName; GenJnlTemplateNameVar)
                {
                    ToolTip = 'Specifies the General Journal Template to be used for the G/L Journal.';
                    Caption = 'Gen. Journal Template';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(GenJnlBatchName; GenJnlBatchNameVar)
                {
                    ToolTip = 'Specifies the General Journal Batch to be used for the G/L Journal.';
                    Caption = 'Gen. Journal Batch';
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        Clear(GenJnlBatch);
                        Clear(GenJnlBatchPage);
                        GenJnlBatch.SetRange("Journal Template Name", GenJnlTemplateNameVar);
                        GenJnlBatchPage.LookupMode(true);
                        GenJnlBatchPage.SetTableView(GenJnlBatch);
                        if GenJnlBatchPage.RunModal() = Action::LookupOK then begin
                            GenJnlBatchPage.GetRecord(GenJnlBatch);
                            GenJnlBatchNameVar := GenJnlBatch.Name;
                            exit(true);
                        end;
                        exit(false);
                    end;

                    trigger OnValidate();
                    begin
                        if GenJnlBatch.Get(GenJnlTemplateNameVar, GenJnlBatchNameVar) then begin
                            if (GenJnlBatch."No. Series" <> '') then begin
                                Clear(NoSeriesMgt);
                                //NewDocumentNo := NoSeriesMgt.TryGetNextNo(GenJnlBatch."No. Series", Today);                                
                                NewDocumentNo := TryGetNextNo(GenJnlBatch."No. Series", Today);

                                if (DocumentNoTxt <> NewDocumentNo) then
                                    DocumentNoTxt := NewDocumentNo;
                            end;
                        end else
                            Error(Text005);
                    end;
                }
                field(DocumentNo; DocumentNoTxt)
                {
                    ToolTip = 'Specifies the Document No. to be used for the G/L Journal entries.';
                    Caption = 'Document No.';
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        SetDefaultParam();
    end;

    trigger OnPostReport();
    begin
        Clear(GenJnlBatchPage);
        if GuiAllowed then begin
            ProgressWindow.Close();
            if (GenJnlLineAdded) and Confirm(Text008, true, GenJnlTemplateNameVar, GenJnlBatchNameVar) then begin
                Clear(GenJnlBatch);
                GenJnlBatch.SetRange("Journal Template Name", GenJnlTemplateNameVar);
                GenJnlBatch.SetRange(Name, GenJnlBatchNameVar);
                GenJnlBatchPage.SetTableView(GenJnlBatch);
                GenJnlBatchPage.Run();
            end else
                Message(Text011);
        end;
    end;

    trigger OnPreReport();
    // BC Upgrade POENAB02, 26.03.2026>>
    var
        NoSeries: Codeunit "No. Series";
    // BC Upgrade POENAB02, 26.03.2026<<    
    begin
        // BC Upgrade POENAB02, 26.03.2026>>
        DocumentNoTxt := NoSeries.GetNextNo(GenJnlBatch."No. Series", Today);
        // BC Upgrade POENAB02, 26.03.2026<<        
        CheckSetup();
        if GuiAllowed then
            ProgressWindow.Open(Text010);

        SourceCodeSetup.Get();
        GenLedgerSetup.Get();
        Month := Date2DMY(PPVAllocDateVar, 2);
        Year := Date2DMY(PPVAllocDateVar, 3);
    end;

    var
        InventorySetup: Record "Inventory Setup";
        GenJnlBatch: Record "Gen. Journal Batch";
        PPVAllocationHeader: Record "PPV Allocation Header RTR";
        PPVAllocationLine: Record "PPV Allocation Line RTR";
        GenPostingSetup: Record "General Posting Setup";
        GenJournalLine: Record "Gen. Journal Line";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        DimSetEntry: Record "Dimension Set Entry";
        GenLedgerSetup: Record "General Ledger Setup";
        SourceCodeSetup: Record "Source Code Setup";
        SourceCodeDimSetup: Record "Source Code Dimension FND";
        DimensionValue: Record "Dimension Value";

        qPPVAlloctionAmt: Query "PPV Allocation Amt.";

        GenJnlLinePage: Page "General Journal";
        GenJnlBatchPage: Page "General Journal Batches";

        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit "No. Series";

        ProgressWindow: Dialog;

        PPVAllocDateVar: Date;
        GenJnlTemplateNameVar: Code[20];
        GenJnlBatchNameVar: Code[10];
        DocumentNoTxt: Code[20];
        NewDocumentNo: Code[20];
        DimAdded: Boolean;
        GenJnlLineAdded: Boolean;
        NoOfRecords: Integer;
        NoOfRecProgress: Integer;
        NoOfProgresed: Integer;
        Counter: Integer;
        Month: Integer;
        Year: Integer;
        LineNo: Integer;
        TimeProgress: Time;

        Text001: Label 'PPV Allocation Date must not be blank.';
        Text002: Label 'General Journal Template must not be blank.';
        Text003: Label 'General Journal Batch must not be blank.';
        Text004: Label 'Document No. must not be blank.';
        Text005: Label 'Journal Batch Name doesn''t exist.';
        Text006: Label 'Gen. Journal %1 batch %2 is not empty. Do you want to delete the existing lines?', Comment = '%1 = Gen. Journal Template Name, %2 = Gen. Journal Batch Name';
        Text007: Label 'Transfer PPV Allocation Amount to G/L Journal is canceled.';
        Text008: Label 'General Journal %1 batch %2 successfully created. Do you want to open the journal?', Comment = '%1 = Gen. Journal Template Name, %2 = Gen. Journal Batch Name';
        Text009: Label '%1 PPV Allocation %2.%3', Comment = '%1 = Inventory Posting Group, %2 = Month, %3 = Year';
        Text010: Label 'Transfer PPV Allocation to G/L Journal @1@@@@@@';
        Text011: Label 'Nothing to create.';

    local procedure SetDefaultParam();
    begin
        InventorySetup.Get();
        GenJnlTemplateNameVar := InventorySetup."PPV Gen. Journal Template FND";
        GenJnlBatchNameVar := InventorySetup."PPV Gen. Journal Batch FND";
        GenJnlBatch.Get(GenJnlTemplateNameVar, GenJnlBatchNameVar);
        if (GenJnlBatch."No. Series" <> '') then begin
            Clear(NoSeriesMgt);
            //DocumentNoTxt := NoSeriesMgt.TryGetNextNo(GenJnlBatch."No. Series", Today);            
            // DocumentNoTxt := TryGetNextNo(GenJnlBatch."No. Series", Today); // BC Upgrade POENAB02, 26.03.2026
        end;
    end;

    local procedure CheckSetup();
    begin
        if (PPVAllocDateVar = 0D) then
            Error(Text001);
        if (GenJnlTemplateNameVar = '') then
            Error(Text002);
        if (GenJnlBatchNameVar = '') then
            Error(Text003);
        if (DocumentNoTxt = '') then
            Error(Text004);
        Clear(GenJournalLine);
        GenJournalLine.SetRange("Journal Template Name", GenJnlTemplateNameVar);
        GenJournalLine.SetRange("Journal Batch Name", GenJnlBatchNameVar);
        if not GenJournalLine.IsEmpty() then begin
            if Confirm(Text006, true, GenJnlTemplateNameVar, GenJnlBatchNameVar) then
                GenJournalLine.DeleteAll()
            else
                Error(Text007);
        end;
    end;

    local procedure CreateGenJnlLine();
    var
        InvPostingSetup: Record "Inventory Posting Setup";
        DebitCreditOption: Option InitLine1,InitLine2,ReversalLine1,ReversalLine2;
    begin
        LineNo := 10000;
        qPPVAlloctionAmt.SetRange(FilterMonth, Month);
        qPPVAlloctionAmt.SetRange(FilterYear, Year);
        qPPVAlloctionAmt.Open();
        while qPPVAlloctionAmt.Read() do begin
            if qPPVAlloctionAmt.Sum_PPV_Line_Adj_Amount <> 0 then begin
                if GuiAllowed then begin
                    Counter += 1;
                    if Counter >= NoOfRecProgress then begin
                        NoOfProgresed := NoOfProgresed + Counter;
                        ProgressWindow.Update(1, Round(NoOfProgresed / NoOfRecords * 10000, 1));
                        Counter := 0;
                        TimeProgress := Time;
                    end;
                end;

                GenPostingSetup.Get('', qPPVAlloctionAmt.Gen_Product_Posting_Group);
                InvPostingSetup.Get('', qPPVAlloctionAmt.Inventory_Posting_Group);

                // insert initial line 1
                InsertGenJnlLine(qPPVAlloctionAmt.Sum_PPV_Line_Adj_Amount, GenPostingSetup."PPV Adjustment Account FND", DebitCreditOption::InitLine1, CalcDate('<CM>', PPVAllocDateVar));

                // insert initial line 2
                InsertGenJnlLine(qPPVAlloctionAmt.Sum_PPV_Line_Adj_Amount, InvPostingSetup."PPV Inv. Adjmt. Account FND", DebitCreditOption::InitLine2, CalcDate('<CM>', PPVAllocDateVar));

                // insert reversal line 1
                InsertGenJnlLine(qPPVAlloctionAmt.Sum_PPV_Line_Adj_Amount, GenPostingSetup."PPV Adjustment Account FND", DebitCreditOption::ReversalLine1, CalcDate('<CM+1D>', PPVAllocDateVar));

                // insert reversal line 2
                InsertGenJnlLine(qPPVAlloctionAmt.Sum_PPV_Line_Adj_Amount, InvPostingSetup."PPV Inv. Adjmt. Account FND", DebitCreditOption::ReversalLine2, CalcDate('<CM+1D>', PPVAllocDateVar));
                GenJnlLineAdded := true;
            end;
        end;
        qPPVAlloctionAmt.Close();
    end;

    local procedure InsertGenJnlLine(Amount: Decimal; AccNo: Code[20]; DebitCreditOption: Option InitLine1,InitLine2,ReversalLine1,ReversalLine2; PostingDate: Date);
    begin
        Clear(GenJournalLine);
        GenJournalLine.Init();
        GenJournalLine."Journal Template Name" := GenJnlTemplateNameVar;
        GenJournalLine."Journal Batch Name" := GenJnlBatchNameVar;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine.Insert(true);
        GenJournalLine.Validate("Posting Date", PostingDate);
        GenJournalLine.Validate("Document No.", DocumentNoTxt);
        GenJournalLine.Validate("Account Type", GenJournalLine."Account Type"::"G/L Account");
        GenJournalLine.Validate("Account No.", AccNo);
        case DebitCreditOption of
            //HEI.03>>
            DebitCreditOption::InitLine1:
                GenJournalLine.Validate(Amount, -Amount);
            DebitCreditOption::InitLine2:
                GenJournalLine.Validate(Amount, Amount);
            DebitCreditOption::ReversalLine1:
                GenJournalLine.Validate(Amount, Amount);
            DebitCreditOption::ReversalLine2:
                GenJournalLine.Validate(Amount, -Amount);
        //HEI.03<<
        end;
        GenJournalLine.Validate("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
        GenJournalLine.Validate(Description, StrSubstNo(Text009, qPPVAlloctionAmt.Inventory_Posting_Group, Month, Year));
        GenJournalLine."Source Code" := SourceCodeSetup."PPV Source Code FND"; //HEI.02
        GenJournalLine.Modify(true);

        TempDimensionSetEntry.DeleteAll();

        if (GenJournalLine."Dimension Set ID" <> 0) then begin
            DimSetEntry.SetRange("Dimension Set ID", GenJournalLine."Dimension Set ID");
            if DimSetEntry.FindSet() then
                repeat
                    TempDimensionSetEntry."Dimension Code" := DimSetEntry."Dimension Code";
                    TempDimensionSetEntry."Dimension Value Code" := DimSetEntry."Dimension Value Code";
                    TempDimensionSetEntry."Dimension Value ID" := DimSetEntry."Dimension Value ID";
                    if TempDimensionSetEntry.Insert() then;
                until DimSetEntry.Next() = 0;
        end;

        if SourceCodeDimSetup.Get(AccNo, SourceCodeSetup."PPV Source Code FND", GenLedgerSetup."Global Dimension 2 Code") then begin
            TempDimensionSetEntry."Dimension Code" := GenLedgerSetup."Global Dimension 2 Code";
            TempDimensionSetEntry."Dimension Value Code" := SourceCodeDimSetup."Dimension Value Code";
            DimensionValue.Reset();
            DimensionValue.SetRange("Dimension Code", GenLedgerSetup."Global Dimension 2 Code");
            DimensionValue.SetRange(Code, SourceCodeDimSetup."Dimension Value Code");
            if DimensionValue.FindFirst() then
                TempDimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
            if TempDimensionSetEntry.Insert() then;
            GenJournalLine.Validate("Shortcut Dimension 2 Code", SourceCodeDimSetup."Dimension Value Code");
            DimAdded := true;
        end;

        if SourceCodeDimSetup.Get(AccNo, SourceCodeSetup."PPV Source Code FND", 'MVMT') then begin
            TempDimensionSetEntry."Dimension Code" := 'MVMT';
            TempDimensionSetEntry."Dimension Value Code" := SourceCodeDimSetup."Dimension Value Code";
            DimensionValue.Reset();
            DimensionValue.SetRange("Dimension Code", 'MVMT');
            DimensionValue.SetRange(Code, SourceCodeDimSetup."Dimension Value Code");
            if DimensionValue.FindFirst() then
                TempDimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
            if TempDimensionSetEntry.Insert() then;
            DimAdded := true;
        end;

        if DimAdded then begin
            GenJournalLine.Validate("Dimension Set ID", DimMgt.GetDimensionSetID(TempDimensionSetEntry));
            GenJournalLine.Modify(true);
        end;

        LineNo += 10000;
    end;

    local procedure TryGetNextNo(NoSeriesCode: Code[20]; SeriesDate: Date): Code[20];
    begin
        Clear(NoSeriesMgt);
        exit(NoSeriesMgt.GetNextNo(NoSeriesCode, SeriesDate));
    end;
}