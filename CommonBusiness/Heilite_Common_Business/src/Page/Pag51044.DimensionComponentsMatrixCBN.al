page 51044 "Dimension Comp Matrix CBN"
{
    // version HEI.01

    Caption = 'Dimension Components Matrix';
    Editable = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Dimension Value";
    ApplicationArea = All; // BC Upgrade SHARMP16

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for the dimension.';
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the dimension code you enter in the Code field.';
                }
                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[1];
                    Visible = Field1Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[1] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(1);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(1, MATRIX_CellData[1]);
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[2];
                    Visible = Field2Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[2] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(2);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(2, MATRIX_CellData[2]);
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[3];
                    Visible = Field3Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[3] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(3);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(3, MATRIX_CellData[3]);
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[4];
                    Visible = Field4Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[4] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(4);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(4, MATRIX_CellData[4]);
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[5];
                    Visible = Field5Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[5] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(5);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(5, MATRIX_CellData[5]);
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[6];
                    Visible = Field6Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[6] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(6);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(6, MATRIX_CellData[6]);
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[7];
                    Visible = Field7Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[7] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(7);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(7, MATRIX_CellData[7]);
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[8];
                    Visible = Field8Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[8] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(8);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(8, MATRIX_CellData[8]);
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[9];
                    Visible = Field9Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[9] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(9);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(9, MATRIX_CellData[9]);
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[10];
                    Visible = Field10Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[10] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(10);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(10, MATRIX_CellData[10]);
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[11];
                    Visible = Field11Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[11] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(11);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(11, MATRIX_CellData[11]);
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[12];
                    Visible = Field12Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[12] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(12);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(12, MATRIX_CellData[12]);
                    end;
                }
                field(Field13; MATRIX_CellData[13])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[13];
                    Visible = Field13Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[13] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(13);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(13, MATRIX_CellData[13]);
                    end;
                }
                field(Field14; MATRIX_CellData[14])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[14];
                    Visible = Field14Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[14] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(14);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(14, MATRIX_CellData[14]);
                    end;
                }
                field(Field15; MATRIX_CellData[15])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[15];
                    Visible = Field15Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[15] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(15);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(15, MATRIX_CellData[15]);
                    end;
                }
                field(Field16; MATRIX_CellData[16])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[16];
                    Visible = Field16Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[16] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(16);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(16, MATRIX_CellData[16]);
                    end;
                }
                field(Field17; MATRIX_CellData[17])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[17];
                    Visible = Field17Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[17] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(17);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(17, MATRIX_CellData[17]);
                    end;
                }
                field(Field18; MATRIX_CellData[18])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[18];
                    Visible = Field18Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[18] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(18);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(18, MATRIX_CellData[18]);
                    end;
                }
                field(Field19; MATRIX_CellData[19])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[19];
                    Visible = Field19Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[19] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(19);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(19, MATRIX_CellData[19]);
                    end;
                }
                field(Field20; MATRIX_CellData[20])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[20];
                    Visible = Field20Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[20] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(20);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(20, MATRIX_CellData[20]);
                    end;
                }
                field(Field21; MATRIX_CellData[21])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[21];
                    Visible = Field21Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[21] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(21);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(21, MATRIX_CellData[21]);
                    end;
                }
                field(Field22; MATRIX_CellData[22])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[22];
                    Visible = Field22Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[22] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(22);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(22, MATRIX_CellData[22]);
                    end;
                }
                field(Field23; MATRIX_CellData[23])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[23];
                    Visible = Field23Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[23] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(23);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(23, MATRIX_CellData[23]);
                    end;
                }
                field(Field24; MATRIX_CellData[24])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[24];
                    Visible = Field24Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[24] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(24);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(24, MATRIX_CellData[24]);
                    end;
                }
                field(Field25; MATRIX_CellData[25])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[25];
                    Visible = Field25Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[25] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(25);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(25, MATRIX_CellData[25]);
                    end;
                }
                field(Field26; MATRIX_CellData[26])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[26];
                    Visible = Field26Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[26] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(26);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(26, MATRIX_CellData[26]);
                    end;
                }
                field(Field27; MATRIX_CellData[27])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[27];
                    Visible = Field27Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[27] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(27);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(27, MATRIX_CellData[27]);
                    end;
                }
                field(Field28; MATRIX_CellData[28])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[28];
                    Visible = Field28Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[28] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(28);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(28, MATRIX_CellData[28]);
                    end;
                }
                field(Field29; MATRIX_CellData[29])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[29];
                    Visible = Field29Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[29] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(29);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(29, MATRIX_CellData[29]);
                    end;
                }
                field(Field30; MATRIX_CellData[30])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[30];
                    Visible = Field30Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[30] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(30);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(30, MATRIX_CellData[30]);
                    end;
                }
                field(Field31; MATRIX_CellData[31])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[31];
                    Visible = Field31Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[31] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(31);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(31, MATRIX_CellData[31]);
                    end;
                }
                field(Field32; MATRIX_CellData[32])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[32];
                    Visible = Field32Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[32] field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupValue(32);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateValue(32, MATRIX_CellData[32]);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    var
        MATRIX_CurrentColumnOrdinal: Integer;
        MATRIX_Steps: Integer;
    begin
        MATRIX_CurrentColumnOrdinal := 0;
        if MATRIX_OnFindRecord('=><') then begin
            MATRIX_CurrentColumnOrdinal := 1;
            repeat
                MATRIX_ColumnOrdinal := MATRIX_CurrentColumnOrdinal;
                MATRIX_OnAfterGetRecord();
                MATRIX_Steps := MATRIX_OnNextRecord(1);
                MATRIX_CurrentColumnOrdinal := MATRIX_CurrentColumnOrdinal + MATRIX_Steps;
            until (MATRIX_CurrentColumnOrdinal - MATRIX_Steps = MATRIX_NoOfMatrixColumns) or (MATRIX_Steps = 0);
            if MATRIX_CurrentColumnOrdinal <> 1 then
                MATRIX_OnNextRecord(1 - MATRIX_CurrentColumnOrdinal);
        end
    end;

    trigger OnInit();
    begin
        Field32Visible := true;
        Field31Visible := true;
        Field30Visible := true;
        Field29Visible := true;
        Field28Visible := true;
        Field27Visible := true;
        Field26Visible := true;
        Field25Visible := true;
        Field24Visible := true;
        Field23Visible := true;
        Field22Visible := true;
        Field21Visible := true;
        Field20Visible := true;
        Field19Visible := true;
        Field18Visible := true;
        Field17Visible := true;
        Field16Visible := true;
        Field15Visible := true;
        Field14Visible := true;
        Field13Visible := true;
        Field12Visible := true;
        Field11Visible := true;
        Field10Visible := true;
        Field9Visible := true;
        Field8Visible := true;
        Field7Visible := true;
        Field6Visible := true;
        Field5Visible := true;
        Field4Visible := true;
        Field3Visible := true;
        Field2Visible := true;
        Field1Visible := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    var
        MATRIX_CurrentColumnOrdinal: Integer;
        MATRIX_Steps: Integer;
    begin
        MATRIX_CurrentColumnOrdinal := 0;
        if MATRIX_OnFindRecord('=><') then begin
            MATRIX_CurrentColumnOrdinal := 1;
            repeat
                MATRIX_ColumnOrdinal := MATRIX_CurrentColumnOrdinal;
                MATRIX_OnAfterGetRecord();
                MATRIX_Steps := MATRIX_OnNextRecord(1);
                MATRIX_CurrentColumnOrdinal := MATRIX_CurrentColumnOrdinal + MATRIX_Steps;
            until (MATRIX_CurrentColumnOrdinal - MATRIX_Steps = MATRIX_NoOfMatrixColumns) or (MATRIX_Steps = 0);
            if MATRIX_CurrentColumnOrdinal <> 1 then
                MATRIX_OnNextRecord(1 - MATRIX_CurrentColumnOrdinal);
        end
    end;

    trigger OnOpenPage();
    begin
        MATRIX_NoOfMatrixColumns := ARRAYLEN(MATRIX_CellData);
        SetFilters();
    end;

    var
        MatrixRecord: Record Dimension;
        MatrixRecords: array[32] of Record Dimension;
        DimensionValueComponent: Record "Dimension Value Component FND";

        Field1Visible: Boolean;

        Field2Visible: Boolean;

        Field3Visible: Boolean;

        Field4Visible: Boolean;

        Field5Visible: Boolean;

        Field6Visible: Boolean;

        Field7Visible: Boolean;

        Field8Visible: Boolean;

        Field9Visible: Boolean;

        Field10Visible: Boolean;

        Field11Visible: Boolean;

        Field12Visible: Boolean;

        Field13Visible: Boolean;

        Field14Visible: Boolean;

        Field15Visible: Boolean;

        Field16Visible: Boolean;

        Field17Visible: Boolean;

        Field18Visible: Boolean;

        Field19Visible: Boolean;

        Field20Visible: Boolean;

        Field21Visible: Boolean;

        Field22Visible: Boolean;

        Field23Visible: Boolean;

        Field24Visible: Boolean;

        Field25Visible: Boolean;

        Field26Visible: Boolean;

        Field27Visible: Boolean;

        Field28Visible: Boolean;

        Field29Visible: Boolean;

        Field30Visible: Boolean;

        Field31Visible: Boolean;

        Field32Visible: Boolean;
        ShowColumnName: Boolean;
        ResultDimCode: Code[20];
        MATRIX_ColumnOrdinal: Integer;
        MATRIX_NoOfMatrixColumns: Integer;
        SeeCombinationsQst: Label 'Do you want to see the list of values?';
        Text001: Label 'No limitations,Limited,Blocked';
        MATRIX_CellData: array[32] of Text[1024];
        MATRIX_ColumnCaption: array[32] of Text[1024];

    procedure Load(MatrixColumns1: array[32] of Text[1024]; var MatrixRecords1: array[32] of Record Dimension; _ShowColumnName: Boolean; _ResultDimCode: Code[20]);
    begin
        COPYARRAY(MATRIX_ColumnCaption, MatrixColumns1, 1);
        COPYARRAY(MatrixRecords, MatrixRecords1, 1);
        ShowColumnName := _ShowColumnName;
        ResultDimCode := _ResultDimCode;
    end;

    local procedure LookupValue(ColumnID: Integer);
    var
        DimValueCode: Code[20];
    begin
        if MatrixRecords[ColumnID].Code <> rec."Dimension Code" then begin
            rec.LookupDimValue(MatrixRecords[ColumnID].Code, DimValueCode);
            if DimValueCode <> '' then
                ValidateValue(ColumnID, DimValueCode);
        end;
    end;

    local procedure ValidateValue(ColumnID: Integer; DimValueCode: Code[20]);
    begin
        if DimValueCode <> '' then begin
            if DimensionValueComponent.GET(rec."Dimension Code", rec.Code, MatrixRecords[ColumnID].Code) then begin
                DimensionValueComponent.VALIDATE("Dimension 2 Value Code", DimValueCode);
                DimensionValueComponent.MODIFY();
            end else begin
                CLEAR(DimensionValueComponent);
                DimensionValueComponent.VALIDATE("Dimension 1 Code", rec."Dimension Code");
                DimensionValueComponent.VALIDATE("Dimension 1 Value Code", rec.Code);
                DimensionValueComponent.VALIDATE("Dimension 2 Code", MatrixRecords[ColumnID].Code);
                DimensionValueComponent.VALIDATE("Dimension 2 Value Code", DimValueCode);
                DimensionValueComponent.INSERT();
            end;
        end else
            if DimensionValueComponent.GET(rec."Dimension Code", rec.Code, MatrixRecords[ColumnID].Code) then
                DimensionValueComponent.DELETE();

        DimensionValueComponent.CreateDimValueName(rec."Dimension Code", rec.Code);
        CurrPage.UPDATE(false);
    end;

    local procedure MATRIX_OnAfterGetRecord();
    begin
        if DimensionValueComponent.GET(rec."Dimension Code", rec.Code, MatrixRecords[MATRIX_ColumnOrdinal].Code) then
            MATRIX_CellData[MATRIX_ColumnOrdinal] := DimensionValueComponent."Dimension 2 Value Code"
        else
            MATRIX_CellData[MATRIX_ColumnOrdinal] := '';
        SetVisible();
    end;

    local procedure MATRIX_OnFindRecord(Which: Text[1024]): Boolean;
    begin
        exit(MatrixRecord.FIND(Which));
    end;

    local procedure MATRIX_OnNextRecord(Steps: Integer): Integer;
    begin
        exit(MatrixRecord.NEXT(Steps));
    end;

    procedure SetVisible();
    begin
        Field1Visible := MATRIX_ColumnCaption[1] <> '';
        Field2Visible := MATRIX_ColumnCaption[2] <> '';
        Field3Visible := MATRIX_ColumnCaption[3] <> '';
        Field4Visible := MATRIX_ColumnCaption[4] <> '';
        Field5Visible := MATRIX_ColumnCaption[5] <> '';
        Field6Visible := MATRIX_ColumnCaption[6] <> '';
        Field7Visible := MATRIX_ColumnCaption[7] <> '';
        Field8Visible := MATRIX_ColumnCaption[8] <> '';
        Field9Visible := MATRIX_ColumnCaption[9] <> '';
        Field10Visible := MATRIX_ColumnCaption[10] <> '';
        Field11Visible := MATRIX_ColumnCaption[11] <> '';
        Field12Visible := MATRIX_ColumnCaption[12] <> '';
        Field13Visible := MATRIX_ColumnCaption[13] <> '';
        Field14Visible := MATRIX_ColumnCaption[14] <> '';
        Field15Visible := MATRIX_ColumnCaption[15] <> '';
        Field16Visible := MATRIX_ColumnCaption[16] <> '';
        Field17Visible := MATRIX_ColumnCaption[17] <> '';
        Field18Visible := MATRIX_ColumnCaption[18] <> '';
        Field19Visible := MATRIX_ColumnCaption[19] <> '';
        Field20Visible := MATRIX_ColumnCaption[20] <> '';
        Field21Visible := MATRIX_ColumnCaption[21] <> '';
        Field22Visible := MATRIX_ColumnCaption[22] <> '';
        Field23Visible := MATRIX_ColumnCaption[23] <> '';
        Field24Visible := MATRIX_ColumnCaption[24] <> '';
        Field25Visible := MATRIX_ColumnCaption[25] <> '';
        Field26Visible := MATRIX_ColumnCaption[26] <> '';
        Field27Visible := MATRIX_ColumnCaption[27] <> '';
        Field28Visible := MATRIX_ColumnCaption[28] <> '';
        Field29Visible := MATRIX_ColumnCaption[29] <> '';
        Field30Visible := MATRIX_ColumnCaption[30] <> '';
        Field31Visible := MATRIX_ColumnCaption[31] <> '';
        Field32Visible := MATRIX_ColumnCaption[32] <> '';
    end;

    procedure SetFilters();
    begin
        rec.SETRANGE("Dimension Code", ResultDimCode);
        CurrPage.UPDATE(false);
    end;
}

