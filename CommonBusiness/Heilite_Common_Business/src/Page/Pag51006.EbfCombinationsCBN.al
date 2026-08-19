page 51006 "Ebf Combinations CBN"
{
    ApplicationArea = All;
    // version HEI.02

    // HEI.01 BPMGAP015 IBM SOICAD01 11.07.2017 EBF Matrix & Movement Type
    //   #new page created
    // HEI.02 CHG2208631 YADAVM09 IBM 13.06.2023 Data is (NOT) showing on EBF Combination page
    // # change in length of array Variable of function Load and other related variables


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
            part(MatrixForm; "Ebf Combinations Matrix CBN")
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
        MatrixRecord: Record "Dimension Value";
        MatrixRecords: array[33] of Record "Dimension Value";
        MatrixMgm: Codeunit "Matrix Management";
        ShowColumnName: Boolean;
        DimCode: Code[20];
        MATRIX_CaptionFieldNo: Integer;
        MATRIX_CurrSetLength: Integer;
        MaximumNoOfCaptions: Integer;
        Text001: Label 'Dimension code must be specified';
        MATRIX_SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        MATRIX_CaptionSet: array[32] of Text[1024];
        MATRIX_ColumnSet: Text[1024];
        PrimaryKeyFirstCaptionInCurrSe: Text[1024];

    local procedure MATRIX_GenerateColumnCaptions(SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn);
    var
        RecRef: RecordRef;
        CurrentMatrixRecordOrdinal: Integer;
    begin
        MatrixRecord.FILTERGROUP(2);
        MatrixRecord.SETFILTER("Dimension Code", DimCode);
        MatrixRecord.FILTERGROUP(0);
        RecRef.GETTABLE(MatrixRecord);
        if ShowColumnName then
            MATRIX_CaptionFieldNo := 3
        else
            MATRIX_CaptionFieldNo := 2;
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

