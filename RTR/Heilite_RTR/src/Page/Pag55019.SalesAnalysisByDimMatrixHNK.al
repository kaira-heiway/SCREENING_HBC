page 55019 SalesAnalysisByDimMatrixHNK
{
    // POENAB02, 19.03.2026, Gap "BPM051-Create CAPEX budget", new object

    // POENAB02, 08.04.2026, Gap "BPM051-Create CAPEX budget"
    // Adjustments for captions.

    //Bc upgrade YADAVM09 Action added for CIL1 and CIL2 reports.

    Caption = 'Sales Analysis by Dim Matrix';
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Dimension Code Buffer";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                IndentationColumn = Rec.Indentation;
                IndentationControls = Name;
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Dimensions;
                    StyleExpr = 'Strong';
                    ToolTip = 'Specifies the code of the record.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Dimensions;
                    StyleExpr = 'Strong';
                    ToolTip = 'Specifies the name of the record.';
                }
                field(TotalQuantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    Caption = 'Total Quantity';
                    StyleExpr = 'Strong';
                    ToolTip = 'Specifies the total value for the amount type that you select in the Show field.';
                    Visible = TotalQuantityVisible;

                    trigger OnDrillDown()
                    begin
                        ItemAnalysisMgt.DrillDownAmount(
                          CurrentAnalysisArea, ItemStatisticsBuffer, CurrentItemAnalysisViewCode,
                          ItemFilter, LocationFilter, DateFilter,
                          Dim1Filter, Dim2Filter, Dim3Filter, BudgetFilter,
                          LineDimType, Rec,
                          ColumnDimType, DimCodeBufferColumn,
                          false, ItemAnalysisValueTypeHNK::Quantity, ShowActualBudget);
                    end;
                }
                field(TotalInvtValue; Rec.Amount)
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    Caption = 'Total Sales Amount';
                    StyleExpr = 'Strong';
                    ToolTip = 'Specifies the total value for the amount type that you select in the Show field.';
                    Visible = TotalInvtValueVisible;

                    trigger OnDrillDown()
                    begin
                        ItemAnalysisMgt.DrillDownAmount(
                          CurrentAnalysisArea, ItemStatisticsBuffer, CurrentItemAnalysisViewCode,
                          ItemFilter, LocationFilter, DateFilter,
                          Dim1Filter, Dim2Filter, Dim3Filter, BudgetFilter,
                          LineDimType, Rec,
                          ColumnDimType, DimCodeBufferColumn,
                          false, ItemAnalysisValueTypeHNK::"Cost Amount", ShowActualBudget);
                    end;
                }
                field(TotalVolume1; Rec."Volume 1 FND")
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    Caption = 'Total Volume 1';
                    StyleExpr = 'Strong';
                    ToolTip = 'Specifies the total value for the Volume 1 type that you select in the Show field.';
                    Visible = TotalVolume1Visible;
                    CaptionClass = '3,' + TotalVolumeCaptionLbl + FoundationSetup101FDW."Add. Rep. Unit Volume UOM"; // POENAB02, 08.04.2026

                    trigger OnDrillDown()
                    begin
                        ItemAnalysisMgt.DrillDownAmount(
                          CurrentAnalysisArea, ItemStatisticsBuffer, CurrentItemAnalysisViewCode,
                          ItemFilter, LocationFilter, DateFilter,
                          Dim1Filter, Dim2Filter, Dim3Filter, BudgetFilter,
                          LineDimType, Rec,
                          ColumnDimType, DimCodeBufferColumn,
                          false, ItemAnalysisValueTypeHNK::"Volume 1", ShowActualBudget);
                    end;
                }
                field(TotalVolume2; Rec."Volume 2 FND")
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    Caption = 'Total Volume 2';
                    StyleExpr = 'Strong';
                    ToolTip = 'Specifies the total value for the Volume 2 type that you select in the Show field.';
                    Visible = TotalVolume2Visible;
                    CaptionClass = '3,' + TotalVolumeCaptionLbl + FoundationSetup101FDW."Unit Volume UOM"; // POENAB02, 08.04.2026

                    trigger OnDrillDown()
                    begin
                        ItemAnalysisMgt.DrillDownAmount(
                          CurrentAnalysisArea, ItemStatisticsBuffer, CurrentItemAnalysisViewCode,
                          ItemFilter, LocationFilter, DateFilter,
                          Dim1Filter, Dim2Filter, Dim3Filter, BudgetFilter,
                          LineDimType, Rec,
                          ColumnDimType, DimCodeBufferColumn,
                          false, ItemAnalysisValueTypeHNK::"Volume 2", ShowActualBudget);
                    end;
                }
                field(Field1; MatrixData[1])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[1];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field1Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(1);
                    end;
                }
                field(Field2; MatrixData[2])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[2];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field2Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(2);
                    end;
                }
                field(Field3; MatrixData[3])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[3];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field3Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(3);
                    end;
                }
                field(Field4; MatrixData[4])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[4];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field4Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(4);
                    end;
                }
                field(Field5; MatrixData[5])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[5];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field5Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(5);
                    end;
                }
                field(Field6; MatrixData[6])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[6];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field6Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(6);
                    end;
                }
                field(Field7; MatrixData[7])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[7];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field7Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(7);
                    end;
                }
                field(Field8; MatrixData[8])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[8];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field8Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(8);
                    end;
                }
                field(Field9; MatrixData[9])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[9];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field9Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(9);
                    end;
                }
                field(Field10; MatrixData[10])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[10];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field10Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(10);
                    end;
                }
                field(Field11; MatrixData[11])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[11];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field11Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(11);
                    end;
                }
                field(Field12; MatrixData[12])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[12];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field12Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(12);
                    end;
                }
                field(Field13; MatrixData[13])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[13];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field13Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(13);
                    end;
                }
                field(Field14; MatrixData[14])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[14];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field14Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(14);
                    end;
                }
                field(Field15; MatrixData[15])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[15];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field15Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(15);
                    end;
                }
                field(Field16; MatrixData[16])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[16];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field16Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(16);
                    end;
                }
                field(Field17; MatrixData[17])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[17];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field17Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(17);
                    end;
                }
                field(Field18; MatrixData[18])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[18];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field18Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(18);
                    end;
                }
                field(Field19; MatrixData[19])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[19];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field19Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(19);
                    end;
                }
                field(Field20; MatrixData[20])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[20];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field20Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(20);
                    end;
                }
                field(Field21; MatrixData[21])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[21];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field21Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(21);
                    end;
                }
                field(Field22; MatrixData[22])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[22];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field22Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(22);
                    end;
                }
                field(Field23; MatrixData[23])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[23];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field23Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(23);
                    end;
                }
                field(Field24; MatrixData[24])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[24];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field24Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(24);
                    end;
                }
                field(Field25; MatrixData[25])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[25];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field25Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(25);
                    end;
                }
                field(Field26; MatrixData[26])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[26];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field26Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(26);
                    end;
                }
                field(Field27; MatrixData[27])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[27];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field27Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(27);
                    end;
                }
                field(Field28; MatrixData[28])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[28];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field28Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(28);
                    end;
                }
                field(Field29; MatrixData[29])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[29];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field29Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(29);
                    end;
                }
                field(Field30; MatrixData[30])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[30];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field30Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';


                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(30);
                    end;
                }
                field(Field31; MatrixData[31])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[31];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field31Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(31);
                    end;
                }
                field(Field32; MatrixData[32])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr();
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[32];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field32Visible;
                    ToolTip = 'Shows the calculated value for the selected dimension or analysis column.';

                    trigger OnDrillDown()
                    begin
                        FieldDrillDown(32);
                    end;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Actions")
            {
                Caption = '&Actions';
                Image = "Action";
                action("Export to Excel")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Export to Excel';
                    Image = ExportToExcel;
                    ToolTip = 'Export the information in the analysis report to Excel.';

                    trigger OnAction()
                    var
                    // ItemAnalysisViewEntry: Record "Item Analysis View Entry";//Unused Variable
                    // ItemAnalysisViewToExcel: Codeunit "Export Item Analysis View";//Unused Variable
                    begin
                        // export to Excel is not supported in cloud; to be reviewed if needed in the future
                        /*
                        ItemAnalysisViewToExcel.SetCommonFilters(
                          CurrentAnalysisArea.AsInteger(), CurrentItemAnalysisViewCode,
                          ItemAnalysisViewEntry, DateFilter, ItemFilter, Dim1Filter, Dim2Filter, Dim3Filter, LocationFilter);
                        ItemAnalysisViewEntry.FindFirst();                        
                        ItemAnalysisViewToExcel.ExportData(
                          ItemAnalysisViewEntry, ShowColumnName, DateFilter, ItemFilter, BudgetFilter,
                          Dim1Filter, Dim2Filter, Dim3Filter, ShowActualBudget.AsInteger(), LocationFilter, ShowOppositeSign);                          
                        */
                        Message('Export to Excel is not supported in the cloud version.');
                    end;
                }
                //Bc Upgrade YADAVM09 Action Added>>
                action("Export to CIL1")
                {
                    ApplicationArea = all;
                    ToolTip = 'Export to CIL1';
                    Caption = 'Export to CIL1';
                    Image = ExportFile;

                    trigger OnAction();
                    var
                        Lrep_CIL1Export: Report "Export CIL1 RTR";//Bc Upgrade YADAVM09,28.04.26<<
                    begin
                        //>>HEI1.0:1:1 EDD072 WSA
                        CLEAR(Lrep_CIL1Export);
                        Lrep_CIL1Export.Setdefaults(CurrentAnalysisArea,
                                                    CurrentItemAnalysisViewCode,
                                                    ShowActualBudget,
                                                    BudgetFilter,
                                                    ItemFilter);
                        Lrep_CIL1Export.RUNMODAL();
                        //<<HEI 1.0:1:1 EDD072 WSA
                    end;
                }
                action("Export to CIL2")
                {
                    ApplicationArea = all;
                    Caption = 'Export to CIL2';
                    ToolTip = 'Export to CIL2';
                    Image = ExportFile;
                    trigger OnAction();
                    var
                        Lrep_CIL2Export: Report "Export CIL2";
                    begin
                        // >>HEI1.0:1:1 EDD072 WSA
                        CLEAR(Lrep_CIL2Export);
                        Lrep_CIL2Export.Setdefaults(CurrentAnalysisArea,
                                                    CurrentItemAnalysisViewCode,
                                                    ShowActualBudget,
                                                    BudgetFilter,
                                                    ItemFilter);
                        Lrep_CIL2Export.RUNMODAL();
                        // <<HEI1.0:1:1 EDD072 WSA
                    end;
                }


            }
            //Bc Upgrade YADAVM09 Action Added<<
        }

    }

    trigger OnAfterGetRecord()
    begin
        CalcAmounts();

        FormatLine();
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        exit(
          ItemAnalysisMgt.FindRecord(
            ItemAnalysisView, LineDimType, Rec, Which,
            ItemFilter, LocationFilter, PeriodType, DateFilter, PeriodInitialized, InternalDateFilter,
            Dim1Filter, Dim2Filter, Dim3Filter));
    end;

    trigger OnInit()
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
        TotalInvtValueVisible := true;
        TotalQuantityVisible := true;
        TotalVolume1Visible := true;
        TotalVolume2Visible := true;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        exit(
          ItemAnalysisMgt.NextRecord(
            ItemAnalysisView, LineDimType, Rec, Steps,
            ItemFilter, LocationFilter, PeriodType, DateFilter,
            Dim1Filter, Dim2Filter, Dim3Filter));
    end;

    trigger OnOpenPage()
    begin
        Field1Visible := 1 <= NoOfRecords;
        Field2Visible := 2 <= NoOfRecords;
        Field3Visible := 3 <= NoOfRecords;
        Field4Visible := 4 <= NoOfRecords;
        Field5Visible := 5 <= NoOfRecords;
        Field6Visible := 6 <= NoOfRecords;
        Field7Visible := 7 <= NoOfRecords;
        Field8Visible := 8 <= NoOfRecords;
        Field9Visible := 9 <= NoOfRecords;
        Field10Visible := 10 <= NoOfRecords;
        Field11Visible := 11 <= NoOfRecords;
        Field12Visible := 12 <= NoOfRecords;
        Field13Visible := 13 <= NoOfRecords;
        Field14Visible := 14 <= NoOfRecords;
        Field15Visible := 15 <= NoOfRecords;
        Field16Visible := 16 <= NoOfRecords;
        Field17Visible := 17 <= NoOfRecords;
        Field18Visible := 18 <= NoOfRecords;
        Field19Visible := 19 <= NoOfRecords;
        Field20Visible := 20 <= NoOfRecords;
        Field21Visible := 21 <= NoOfRecords;
        Field22Visible := 22 <= NoOfRecords;
        Field23Visible := 23 <= NoOfRecords;
        Field24Visible := 24 <= NoOfRecords;
        Field25Visible := 25 <= NoOfRecords;
        Field26Visible := 26 <= NoOfRecords;
        Field27Visible := 27 <= NoOfRecords;
        Field28Visible := 28 <= NoOfRecords;
        Field29Visible := 29 <= NoOfRecords;
        Field30Visible := 30 <= NoOfRecords;
        Field31Visible := 31 <= NoOfRecords;
        Field32Visible := 32 <= NoOfRecords;

        FoundationSetup101FDW.Get(); // POENAB02, 08.04.2026
    end;

    var
        ItemAnalysisView: Record "Item Analysis View";
        TempDimensionCodeAmountBuffer: Record "Dimension Code Amount Buffer" temporary;
        FoundationSetup101FDW: Record "FoundationSetup101FDW"; // POENAB02, 08.04.2026
        TotalVolumeCaptionLbl: Label 'Total Volume '; // POENAB02, 08.04.2026        
        DimCodeBufferColumn: Record "Dimension Code Buffer";
        DimCodeBufferColumn3: Record "Dimension Code Buffer";
        ItemStatisticsBuffer: Record "Item Statistics Buffer";
        ItemAnalysisMgt: Codeunit ItemAnalysisMgtRtR;
        MatrixMgt: Codeunit "Matrix Management";
        RoundingFactor: Enum "Analysis Rounding Factor";
        ValueType: Enum ItemAnalysisValueTypeHNK;
        LineDimType: Enum "Item Analysis Dimension Type";
        ColumnDimType: Enum "Item Analysis Dimension Type";
        PeriodType: Enum "Analysis Period Type";
        ShowActualBudget: Enum "Item Analysis Show Type";
        CurrentAnalysisArea: Enum "Analysis Area Type";
        CurrentItemAnalysisViewCode: Code[10];
        LocationFilter: Code[250];
        ItemFilter: Code[250];
        Dim1Filter: Code[250];
        Dim2Filter: Code[250];
        Dim3Filter: Code[250];
        CodeRange: Code[250];
        BudgetFilter: Code[250];
        DateFilter: Text[30];
        MatrixColumnCaptions: array[32] of Text[1024];
        InternalDateFilter: Text[30];
        Which: Text;
        RoundingFactorFormatString: Text;
        ShowOppositeSign: Boolean;
        PeriodInitialized: Boolean;
        i: Integer;
        Steps: Integer;
        NoOfRecords: Integer;
        MatrixData: array[32] of Decimal;
        ShowColumnName: Boolean;
        TotalQuantityVisible: Boolean;
        TotalInvtValueVisible: Boolean;
        TotalVolume1Visible: Boolean;
        TotalVolume2Visible: Boolean;
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
        Emphasize: Boolean;

    procedure LoadMatrix(NewItemAnalysisView: Record "Item Analysis View"; NewCurrentItemAnalysisViewCode: Code[10]; NewCurrentAnalysisArea: Enum "Analysis Area Type"; NewLineDimType: Enum "Item Analysis Dimension Type"; NewColumnDimType: Enum "Item Analysis Dimension Type"; NewPeriodType: Enum "Analysis Period Type"; NewValueType: Enum ItemAnalysisValueTypeHNK; NewRoundingFactor: Enum "Analysis Rounding Factor"; NewShowActualBudget: Enum "Item Analysis Show Type"; NewMatrixColumnCaptions: array[32] of Text[1024]; NewShowOppositeSign: Boolean; NewPeriodInitialized: Boolean; NewShowColumnName: Boolean; NoOfRecordsLocal: Integer)
    begin
        Clear(MatrixColumnCaptions);
        ItemAnalysisView.Copy(NewItemAnalysisView);

        CurrentItemAnalysisViewCode := NewCurrentItemAnalysisViewCode;
        CurrentAnalysisArea := NewCurrentAnalysisArea;

        LineDimType := NewLineDimType;
        ColumnDimType := NewColumnDimType;

        PeriodType := NewPeriodType;
        ShowOppositeSign := NewShowOppositeSign;

        CopyArray(MatrixColumnCaptions, NewMatrixColumnCaptions, 1);

        PeriodInitialized := NewPeriodInitialized;
        PeriodType := NewPeriodType;
        ValueType := NewValueType;
        RoundingFactor := NewRoundingFactor;
        ShowActualBudget := NewShowActualBudget;
        ShowColumnName := NewShowColumnName;

        NoOfRecords := NoOfRecordsLocal;
        RoundingFactorFormatString := MatrixMgt.FormatRoundingFactor(RoundingFactor, false);
    end;

    procedure LoadFilters(ItemFilter1: Code[250]; LocationFilter1: Code[250]; Dim1Filter1: Code[250]; Dim2Filter1: Code[250]; Dim3Filter1: Code[250]; DateFilter2: Text[30]; BudgetFilter1: Code[250]; InternalDateFilter1: Text[30])
    begin
        ItemFilter := ItemFilter1;
        LocationFilter := LocationFilter1;
        Dim1Filter := Dim1Filter1;
        Dim2Filter := Dim2Filter1;
        Dim3Filter := Dim3Filter1;
        DateFilter := DateFilter2;
        BudgetFilter := BudgetFilter1;
        InternalDateFilter := InternalDateFilter1;
    end;

    procedure LoadCodeRange(NewCodeRange: Code[250])
    begin
        CodeRange := NewCodeRange;
    end;

    local procedure CalcAmounts()
    begin
        if TotalQuantityVisible then
            Rec.Quantity := CalcAmt(DimCodeBufferColumn, ItemAnalysisValueTypeHNK::Quantity, false);
        if TotalVolume1Visible then
            Rec."Volume 1 FND" := CalcAmt(DimCodeBufferColumn, ItemAnalysisValueTypeHNK::"Volume 1", false);
        if TotalVolume2Visible then
            Rec."Volume 2 FND" := CalcAmt(DimCodeBufferColumn, ItemAnalysisValueTypeHNK::"Volume 2", false);
        Steps := 1;
        Which := '-';

        ItemAnalysisMgt.FindRecord(
          ItemAnalysisView, ColumnDimType, DimCodeBufferColumn3, Which,
          GetFieldItemFilter(), GetFieldLocationFilter(), PeriodType, DateFilter, PeriodInitialized, InternalDateFilter,
          GetFieldDim1Filter(), GetFieldDim2Filter(), GetFieldDim3Filter());

        i := 1;
        while (i <= NoOfRecords) and (i <= ArrayLen(MatrixColumnCaptions)) do begin
            MatrixData[i] := CalcAmt(DimCodeBufferColumn3, ValueType, true);
            ItemAnalysisMgt.NextRecord(
              ItemAnalysisView, ColumnDimType, DimCodeBufferColumn3, Steps,
              GetFieldItemFilter(), GetFieldLocationFilter(), PeriodType, DateFilter,
              GetFieldDim1Filter(), GetFieldDim2Filter(), GetFieldDim3Filter());
            i := i + 1;
        end;
    end;

    local procedure CalcAmt(DimCodeBufferColumn1: Record "Dimension Code Buffer"; ValueType: Enum ItemAnalysisValueTypeHNK; SetColFilter: Boolean): Decimal
    var
        Amt: Decimal;
        AmtFromBuffer: Boolean;
    begin
        if SetColFilter then
            if TempDimensionCodeAmountBuffer.Get(Rec.Code, DimCodeBufferColumn1.Code) then begin
                Amt := TempDimensionCodeAmountBuffer.Amount;
                AmtFromBuffer := true;
            end;

        if not AmtFromBuffer then begin
            Amt := ItemAnalysisMgt.CalculateAmount(
                ValueType, SetColFilter,
                CurrentAnalysisArea, ItemStatisticsBuffer, CurrentItemAnalysisViewCode,
                ItemFilter, LocationFilter, DateFilter, BudgetFilter,
                Dim1Filter, Dim2Filter, Dim3Filter,
                LineDimType, Rec,
                ColumnDimType, DimCodeBufferColumn1,
                ShowActualBudget);

            if SetColFilter then begin
                TempDimensionCodeAmountBuffer."Line Code" := Rec.Code;
                TempDimensionCodeAmountBuffer."Column Code" := DimCodeBufferColumn1.Code;
                TempDimensionCodeAmountBuffer.Amount := Amt;
                TempDimensionCodeAmountBuffer.Insert();
            end;
        end;

        if ShowOppositeSign then
            Amt := -Amt;

        Amt := MatrixMgt.RoundAmount(Amt, RoundingFactor);

        exit(Amt);
    end;

    local procedure FieldDrillDown(Ordinal: Integer)
    begin
        Clear(DimCodeBufferColumn3);
        Which := '-';

        ItemAnalysisMgt.FindRecord(
          ItemAnalysisView, ColumnDimType, DimCodeBufferColumn3, Which,
          GetFieldItemFilter(), GetFieldLocationFilter(), PeriodType, DateFilter, PeriodInitialized, InternalDateFilter,
          GetFieldDim1Filter(), GetFieldDim2Filter(), GetFieldDim3Filter());

        Steps := Ordinal - 1;
        ItemAnalysisMgt.NextRecord(
          ItemAnalysisView, ColumnDimType, DimCodeBufferColumn3, Steps,
          GetFieldItemFilter(), GetFieldLocationFilter(), PeriodType, DateFilter,
          GetFieldDim1Filter(), GetFieldDim2Filter(), GetFieldDim3Filter());

        ItemAnalysisMgt.DrillDownAmount(
          CurrentAnalysisArea, ItemStatisticsBuffer, CurrentItemAnalysisViewCode,
          GetFieldItemFilter(), GetFieldLocationFilter(), DateFilter,
          GetFieldDim1Filter(), GetFieldDim2Filter(), GetFieldDim3Filter(), BudgetFilter,
          LineDimType, Rec,
          ColumnDimType, DimCodeBufferColumn3,
          true, ValueType, ShowActualBudget);
    end;

    local procedure FormatLine()
    begin
        Emphasize := Rec."Show in Bold";
    end;

    procedure GetMatrixDimension(): Integer
    begin
        exit(ArrayLen(MatrixColumnCaptions));
    end;

    local procedure FormatStr(): Text
    begin
        exit(RoundingFactorFormatString);
    end;

    local procedure GetFieldItemFilter(): Code[250]
    begin
        exit(GetFieldFilter(ColumnDimType::Item, ItemFilter));
    end;

    local procedure GetFieldLocationFilter(): Code[250]
    begin
        exit(GetFieldFilter(ColumnDimType::Location, LocationFilter));
    end;

    local procedure GetFieldDim1Filter(): Code[250]
    begin
        exit(GetFieldFilter(ColumnDimType::"Dimension 1", Dim1Filter));
    end;

    local procedure GetFieldDim2Filter(): Code[250]
    begin
        exit(GetFieldFilter(ColumnDimType::"Dimension 2", Dim2Filter));
    end;

    local procedure GetFieldDim3Filter(): Code[250]
    begin
        exit(GetFieldFilter(ColumnDimType::"Dimension 3", Dim3Filter));
    end;

    local procedure GetFieldFilter(RequiredColumnDimOption: Enum "Item Analysis Dimension Type"; DefaultFilter: Code[250]): Code[250]
    begin
        if (ColumnDimType = RequiredColumnDimOption) and (CodeRange <> '') then
            exit(CodeRange);

        exit(DefaultFilter);
    end;
}

