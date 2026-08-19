page 51069 "EBF Matrix CBN"
{
    // version HEI.01

    // HEI.01 CHG2171687 IBM SISUM01 06/03/2023 #create new object

    // BC Upgrade MISHRS14 >>
    // Changed FINDSET(false, false) as its depreceted in-procedure MATRIX_GenerateColumnCaptions
    // BC Upgrade MISHRS14 <<

    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
            }
            part(MatrixForm; "EBF Matrix Setup Matrix CBN")
            {
                ApplicationArea = Suite;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Previous Set")
            {
                ApplicationArea = Suite;
                Caption = 'Previous Set';
                Image = PreviousSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the previous set of data.';

                trigger OnAction();
                var
                    Step: Option First,Previous,Same,Next;
                begin
                    // SetPoints(Direction::Backward);
                    MATRIX_GenerateColumnCaptions(Step::Previous);
                    UpdateMatrixSubform();
                end;
            }
            action("Previous Column")
            {
                ApplicationArea = Suite;
                Caption = 'Previous Column';
                Image = PreviousRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the previous column.';

                trigger OnAction();
                var
                    Step: Option First,Previous,Same,Next,PreviousColumn,NextColumn;
                begin
                    // SetPoints(Direction::Backward);
                    MATRIX_GenerateColumnCaptions(Step::PreviousColumn);
                    UpdateMatrixSubform();
                end;
            }
            action("Next Column")
            {
                ApplicationArea = Suite;
                Caption = 'Next Column';
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the next column.';

                trigger OnAction();
                var
                    Step: Option First,Previous,Same,Next,PreviousColumn,NextColumn;
                begin
                    // SetPoints(Direction::Forward);
                    MATRIX_GenerateColumnCaptions(Step::NextColumn);
                    UpdateMatrixSubform();
                end;
            }
            action("Next Set")
            {
                ApplicationArea = Suite;
                Caption = 'Next Set';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the next set of data.';

                trigger OnAction();
                var
                    Step: Option First,Previous,Same,Next;
                begin
                    // SetPoints(Direction::Forward);
                    MATRIX_GenerateColumnCaptions(Step::Next);
                    UpdateMatrixSubform();
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        if DimCode = '' then
            ERROR(Text001);
        MaximumNoOfCaptions := ARRAYLEN(MATRIX_CaptionSet);
        MATRIX_GenerateColumnCaptions(MATRIX_SetWanted::Initial);
        UpdateMatrixSubform();
    end;

    var
        MatrixRecords: array[32] of Record "Dimension Value";
        MatrixRecord: Record "Dimension Value";
        MatrixRecordTmp: Record "Dimension Value" temporary;
        MatrixMgm: Codeunit "Matrix Management";
        MATRIX_CaptionSet: array[32] of Text[1024];
        MATRIX_ColumnSet: Text[1024];
        MATRIX_CaptionFieldNo: Integer;
        ShowColumnName: Boolean;
        MaximumNoOfCaptions: Integer;
        PrimaryKeyFirstCaptionInCurrSe: Text[1024];
        MATRIX_CurrSetLength: Integer;
        MATRIX_SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        DimCode: Code[20];
        Text001: Label 'Dimension code must be specified';

    local procedure MATRIX_GenerateColumnCaptions(SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn);
    var
        RecRef: RecordRef;
        CurrentMatrixRecordOrdinal: Integer;
        FinancialUtils: Codeunit "Financial-Utils";
        StartPosNoDigits: array[4] of Integer;
        FilterOperator: Text;
    begin
        FinancialUtils.GetEBFFilterPattern(StartPosNoDigits, FilterOperator);
        MatrixRecord.SETFILTER("Dimension Code", DimCode);

        // BC Upgrade MISHRS14 >>
        // FINDSET(false, false) is deprecated
        //if MatrixRecord.FINDSET(false, false) then
        if MatrixRecord.FINDSET(false) then
            // BC Upgrade MISHRS14 <<

            repeat
                MatrixRecordTmp."Dimension Code" := DimCode;
                MatrixRecordTmp.Code := '??' + COPYSTR(MatrixRecord.Code, StartPosNoDigits[3], StartPosNoDigits[4]) + '??';
                if MatrixRecordTmp.INSERT() then;
            until MatrixRecord.NEXT() = 0;

        MatrixRecordTmp.FILTERGROUP(2);
        MatrixRecordTmp.SETFILTER("Dimension Code", DimCode);
        MatrixRecordTmp.FILTERGROUP(0);
        RecRef.GETTABLE(MatrixRecordTmp);
        if ShowColumnName then
            MATRIX_CaptionFieldNo := 3
        else
            MATRIX_CaptionFieldNo := 2;
        MatrixMgm.GenerateMatrixData(RecRef, SetWanted, MaximumNoOfCaptions, MATRIX_CaptionFieldNo, PrimaryKeyFirstCaptionInCurrSe,
          MATRIX_CaptionSet, MATRIX_ColumnSet, MATRIX_CurrSetLength);

        CLEAR(MatrixRecords);
        MatrixRecordTmp.SETPOSITION(PrimaryKeyFirstCaptionInCurrSe);
        CurrentMatrixRecordOrdinal := 1;
        repeat
            MatrixRecords[CurrentMatrixRecordOrdinal].COPY(MatrixRecordTmp);
            CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
        until (CurrentMatrixRecordOrdinal = ARRAYLEN(MatrixRecords)) or (MatrixRecordTmp.NEXT() <> 1);
    end;

    local procedure UpdateMatrixSubform();
    begin
        CurrPage.MatrixForm.PAGE.Load(MATRIX_CaptionSet, MatrixRecords, ShowColumnName, DimCode);
        CurrPage.UPDATE(false);
    end;

    local procedure ShowColumnNameOnAfterValidate();
    begin
        UpdateMatrixSubform();
    end;

    local procedure ShowColumnNameOnPush();
    begin
        MATRIX_GenerateColumnCaptions(MATRIX_SetWanted::Same);
        UpdateMatrixSubform();
    end;

    procedure SetDimCode(_DimCode: Code[20]);
    begin
        DimCode := _DimCode;
    end;
}

