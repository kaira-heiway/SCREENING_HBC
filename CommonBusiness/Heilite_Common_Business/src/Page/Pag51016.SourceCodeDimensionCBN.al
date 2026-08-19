page 51016 "Source Code Dimension CBN"
{
    // version HEI.01

    // HEI.01 BPMGAP015 IBM SOICAD01 11.07.2017 EBF Matrix & Movement Type
    //   #new page created
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(ShowColumnName; ShowColumnName)
                {
                    ApplicationArea = Suite;
                    Caption = 'Show Column Name';
                    ToolTip = 'Specifies that the names of columns are shown in the matrix window.';

                    trigger OnValidate();
                    begin
                        ShowColumnNameOnPush();
                        ShowColumnNameOnAfterValidate();
                        MATRIX_GenerateColumnCaptions(MATRIX_SetWanted::Initial);
                        UpdateMatrixSubform();
                    end;
                }
            }
            part(MatrixForm; "Source Code Dim Matrix CBN")
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
        MatrixRecords: array[32] of Record "Source Code";
        MatrixRecord: Record "Source Code";
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
    begin
        RecRef.GETTABLE(MatrixRecord);
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

