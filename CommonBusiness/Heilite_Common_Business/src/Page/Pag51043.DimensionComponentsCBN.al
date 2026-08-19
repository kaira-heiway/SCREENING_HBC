page 51043 "Dimension Components CBN"
{
    // version HEI.01

    Caption = 'Dimension Components';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Card;
    SaveValues = true;
    SourceTable = Dimension;
    ApplicationArea = All; // BC Upgrade SHARMP16
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(ResultDimCode; ResultDimCode)
                {
                    ApplicationArea = Suite;
                    Caption = 'Dimension Code';
                    TableRelation = Dimension;
                    ToolTip = 'Specifies the dimension code for which the concatenation is done.';

                    trigger OnValidate();
                    begin
                        ResultDimCodeOnAfterValidate();
                    end;
                }
                field(ShowColumnName; ShowColumnName)
                {
                    ApplicationArea = Suite;
                    Caption = 'Show Column Name';
                    ToolTip = 'Specifies that the names of columns are shown in the matrix window.';

                    trigger OnValidate();
                    begin
                        ShowColumnNameOnPush();
                        ShowColumnNameOnAfterValidate();
                    end;
                }
            }
            part(MatrixForm; "Dimension Comp Matrix CBN")
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

    trigger OnAfterGetRecord();
    begin
        rec.Name := rec.GetMLName(GLOBALLANGUAGE);
    end;

    trigger OnOpenPage();
    begin
        MaximumNoOfCaptions := ARRAYLEN(MATRIX_CaptionSet);
        MATRIX_GenerateColumnCaptions(MATRIX_SetWanted::Initial);
        UpdateMatrixSubform();
    end;

    var
        MatrixRecord: Record Dimension;
        MatrixRecords: array[32] of Record Dimension;
        MatrixMgm: Codeunit "Matrix Management";
        ShowColumnName: Boolean;
        ResultDimCode: Code[20];
        MATRIX_CaptionFieldNo: Integer;
        MATRIX_CurrSetLength: Integer;
        MaximumNoOfCaptions: Integer;
        NoDimensionsErr: Label 'No Dimensions are available in the database.';
        MATRIX_SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        MATRIX_CaptionSet: array[32] of Text[1024];
        MATRIX_ColumnSet: Text[1024];
        PrimaryKeyFirstCaptionInCurrSe: Text[1024];

    local procedure MATRIX_GenerateColumnCaptions(SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn);
    var
        RecRef: RecordRef;
        CurrentMatrixRecordOrdinal: Integer;
    begin
        RecRef.GETTABLE(MatrixRecord);

        if RecRef.ISEMPTY then
            ERROR(NoDimensionsErr);

        if ShowColumnName then
            MATRIX_CaptionFieldNo := 2
        else
            MATRIX_CaptionFieldNo := 1;

        MatrixMgm.GenerateMatrixData(RecRef, SetWanted, MaximumNoOfCaptions, MATRIX_CaptionFieldNo, PrimaryKeyFirstCaptionInCurrSe,
          MATRIX_CaptionSet, MATRIX_ColumnSet, MATRIX_CurrSetLength);

        CLEAR(MatrixRecords);
        MatrixRecord.SETPOSITION(PrimaryKeyFirstCaptionInCurrSe);
        CurrentMatrixRecordOrdinal := 1;
        repeat
            MatrixRecords[CurrentMatrixRecordOrdinal].COPY(MatrixRecord);
            CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
        until (CurrentMatrixRecordOrdinal = ARRAYLEN(MatrixRecords)) or (MatrixRecord.NEXT() <> 1);
    end;

    local procedure UpdateMatrixSubform();
    begin
        CurrPage.MatrixForm.PAGE.Load(MATRIX_CaptionSet, MatrixRecords, ShowColumnName, ResultDimCode);
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

    local procedure ResultDimCodeOnAfterValidate();
    begin
        CurrPage.MatrixForm.PAGE.Load(MATRIX_CaptionSet, MatrixRecords, ShowColumnName, ResultDimCode);
        CurrPage.MatrixForm.PAGE.SetFilters();
        CurrPage.UPDATE(false);
    end;
}

