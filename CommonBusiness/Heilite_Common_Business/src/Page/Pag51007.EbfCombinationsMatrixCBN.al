page 51007 "Ebf Combinations Matrix CBN"
{
    // version HEI.02

    // HEI.01 BPMGAP015 IBM SOICAD01 11.07.2017 EBF Matrix & Movement Type
    //   #new page created
    // HEI.02 CHG2208631 YADAVM09 IBM 13.06.2023 Data is (NOT) showing on EBF Combination page
    // # change in length of array Variable of function Load and other related variables

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "G/L Account";
    SourceTableView = where("Account Type" = FILTER(Posting));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                FreezeColumn = Name;
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ToolTip = 'Specifies the name of the general ledger account.';
                }
                field(Field1; MATRIX_CellData[1])
                {
                    CaptionClass = '3,' + MATRIX_ColumnCaption[1];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field1Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[1] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(1);
                        ShowCombRestriction();
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    CaptionClass = '3,' + MATRIX_ColumnCaption[2];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field2Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[2] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(2);
                        ShowCombRestriction();
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[3];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field3Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[3] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(3);
                        ShowCombRestriction();
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[4];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field4Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[4] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(4);
                        ShowCombRestriction();
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[5];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field5Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[5] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(5);
                        ShowCombRestriction();
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[6];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field6Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[6] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(6);
                        ShowCombRestriction();
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[7];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field7Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[7] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(7);
                        ShowCombRestriction();
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[8];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field8Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[8] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(8);
                        ShowCombRestriction();
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[9];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field9Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[9] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(9);
                        ShowCombRestriction();
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[10];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field10Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[10] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(10);
                        ShowCombRestriction();
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[11];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field11Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[11] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(11);
                        ShowCombRestriction();
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[12];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field12Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[12] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(12);
                        ShowCombRestriction();
                    end;
                }
                field(Field13; MATRIX_CellData[13])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[13];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field13Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[13] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(13);
                        ShowCombRestriction();
                    end;
                }
                field(Field14; MATRIX_CellData[14])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[14];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field14Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[14] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(14);
                        ShowCombRestriction();
                    end;
                }
                field(Field15; MATRIX_CellData[15])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[15];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field15Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[15] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(15);
                        ShowCombRestriction();
                    end;
                }
                field(Field16; MATRIX_CellData[16])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[16];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field16Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[16] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(16);
                        ShowCombRestriction();
                    end;
                }
                field(Field17; MATRIX_CellData[17])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[17];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field17Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[17] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(17);
                        ShowCombRestriction();
                    end;
                }
                field(Field18; MATRIX_CellData[18])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[18];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field18Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[18] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(18);
                        ShowCombRestriction();
                    end;
                }
                field(Field19; MATRIX_CellData[19])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[19];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field19Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[19] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(19);
                        ShowCombRestriction();
                    end;
                }
                field(Field20; MATRIX_CellData[20])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[20];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field20Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[20] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(20);
                        ShowCombRestriction();
                    end;
                }
                field(Field21; MATRIX_CellData[21])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[21];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field21Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[21] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(21);
                        ShowCombRestriction();
                    end;
                }
                field(Field22; MATRIX_CellData[22])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[22];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field22Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[22] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(22);
                        ShowCombRestriction();
                    end;
                }
                field(Field23; MATRIX_CellData[23])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[23];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field23Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[23] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(23);
                        ShowCombRestriction();
                    end;
                }
                field(Field24; MATRIX_CellData[24])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[24];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field24Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[24] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(24);
                        ShowCombRestriction();
                    end;
                }
                field(Field25; MATRIX_CellData[25])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[25];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field25Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[25] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(25);
                        ShowCombRestriction();
                    end;
                }
                field(Field26; MATRIX_CellData[26])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[26];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field26Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[26] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(26);
                        ShowCombRestriction();
                    end;
                }
                field(Field27; MATRIX_CellData[27])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[27];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field27Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[27] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(27);
                        ShowCombRestriction();
                    end;
                }
                field(Field28; MATRIX_CellData[28])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[28];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field28Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[28] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(28);
                        ShowCombRestriction();
                    end;
                }
                field(Field29; MATRIX_CellData[29])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[29];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field29Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[29] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(29);
                        ShowCombRestriction();
                    end;
                }
                field(Field30; MATRIX_CellData[30])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[30];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field30Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[30] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(30);
                        ShowCombRestriction();
                    end;
                }
                field(Field31; MATRIX_CellData[31])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[31];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field31Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[31] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(31);
                        ShowCombRestriction();
                    end;
                }
                field(Field32; MATRIX_CellData[32])
                {
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[32];
                    //DecimalPlaces = 0:5;  //BC Upgrade Kamnay01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                    Visible = Field32Visible;
                    ToolTip = 'Specifies the value of the MATRIX_CellData[32] field.';

                    trigger OnValidate();
                    begin
                        ChangeCombRestriction(32);
                        ShowCombRestriction();
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
        MATRIX_NoOfMatrixColumns := ARRAYLEN(MATRIX_CellData);
        CurrentDimCode := 'DEPARTMENT';
    end;

    trigger OnOpenPage();
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

    var
        MatrixRecord: Record "Dimension Value";
        MatrixRecords: array[33] of Record "Dimension Value";
        DimComb: Record "Ebf Combination FND";

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
        CurrentDimCode: Code[20];
        DimCode: Code[20];
        MATRIX_ColumnOrdinal: Integer;
        MATRIX_NoOfMatrixColumns: Integer;
        CombRestriction: Option " ",Limited,Blocked;
        MATRIX_CellData: array[32] of Option " ","Not Allowed","Allowed with Warn";
        MATRIX_ColumnCaption: array[32] of Text[100];

    procedure Load(MatrixColumns1: array[33] of Text[1024]; var MatrixRecords1: array[33] of Record "Dimension Value"; _ShowColumnName: Boolean; _DimCode: Code[20]);
    begin
        COPYARRAY(MATRIX_ColumnCaption, MatrixColumns1, 1);
        COPYARRAY(MatrixRecords, MatrixRecords1, 1);
        ShowColumnName := _ShowColumnName;
        DimCode := _DimCode;
    end;

    local procedure MATRIX_OnAfterGetRecord();
    begin
        ShowCombRestriction();
        /*
        IF CombRestriction = CombRestriction::" " THEN
          MATRIX_CellData[MATRIX_ColumnOrdinal] := ''
        else
          MATRIX_CellData[MATRIX_ColumnOrdinal] := SELECTSTR(CombRestriction + 1,Text001);*/
        SetVisible();

        //SetVisible;

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

    procedure ChangeCombRestriction(ColumnID: Integer);
    var
        EbfCombination: Record "Ebf Combination FND";
        AccountNo: Code[20];
        DimValueCode: Code[20];
    begin
        AccountNo := Rec."No.";
        DimValueCode := MatrixRecords[ColumnID].Code;
        if not EbfCombination.GET(Rec."No.", DimCode, DimValueCode) then
            if MATRIX_CellData[ColumnID] <> MATRIX_CellData[ColumnID] ::" " then begin
                EbfCombination.VALIDATE("GL Account No.", Rec."No.");
                EbfCombination.VALIDATE("Dimension Code", DimCode);
                EbfCombination.VALIDATE("Dimension Value Code", DimValueCode);
                EbfCombination.VALIDATE("Combination Restriction", MATRIX_CellData[ColumnID]);
                EbfCombination.INSERT(true);
                CurrPage.UPDATE();
                exit;
            end;

        if MATRIX_CellData[ColumnID] = MATRIX_CellData[ColumnID] ::" " then
            EbfCombination.DELETE(true)
        else begin
            EbfCombination.VALIDATE("Combination Restriction", MATRIX_CellData[ColumnID]);
            EbfCombination.MODIFY(true);
        end;
        CurrPage.UPDATE();
    end;

    procedure ShowCombRestriction();
    var
        EbfCombination: Record "Ebf Combination FND";
        AccountNo: Code[20];
        DimValueCode: Code[20];
    begin
        AccountNo := Rec."No.";
        DimValueCode := MatrixRecords[MATRIX_ColumnOrdinal].Code;
        if not EbfCombination.GET(Rec."No.", DimCode, DimValueCode) then begin
            EbfCombination.INIT();
            EbfCombination."GL Account No." := Rec."No.";
            EbfCombination."Dimension Value Code" := DimValueCode;
            EbfCombination."Dimension Code" := DimCode;
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MATRIX_CellData[MATRIX_ColumnOrdinal] ::" ";
            exit
        end;
        MATRIX_CellData[MATRIX_ColumnOrdinal] := EbfCombination."Combination Restriction";
    end;
}

