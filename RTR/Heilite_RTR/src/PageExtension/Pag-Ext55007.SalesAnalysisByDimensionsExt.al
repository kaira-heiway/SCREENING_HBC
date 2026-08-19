pageextension 55007 SalesAnalysisByDimensionsExt extends "Sales Analysis by Dimensions"
{
    // POENAB02, 19.03.2026, Gap "BPM051-Create CAPEX budget", new object

    // POENAB02, 08.04.2026, Gap "BPM051-Create CAPEX budget"
    // Adjustments for captions.
    //Bc Upgrade YADAVM09 Action blocked to use base feature

    layout
    {
        modify(ValueType)
        {
            Visible = false;
            Enabled = false;
        }

        addafter(ValueType)
        {
            field(ValueTypeHNK; ValueTypeHNK)
            {
                ApplicationArea = All;
                Caption = 'Show Value As';
                ToolTipML = ENU = 'Specifies how data is shown in the analysis view.', FRA = 'Spécifie comment les données sont affichées dans la vue d''analyse.';
            }

            field("Volume 1"; rec."Volume 1 FND")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Total Volume 1', FRA = 'Volume total 1';
                ToolTipML = ENU = 'Specifies the total volume 1 of the record.', FRA = 'Spécifie le volume total 1 de l''enregistrement.';
                CaptionClass = '3,' + VolumeCaption + FoundationSetup101FDW."Add. Rep. Unit Volume UOM"; // POENAB02, 08.04.2026
            }
            field("Volume 2"; rec."Volume 2 FND")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Total Volume 2', FRA = 'Volume total 2';
                ToolTipML = ENU = 'Specifies the total volume 2 of the record.', FRA = 'Spécifie le volume total 2 de l''enregistrement.';
                CaptionClass = '3,' + VolumeCaption + FoundationSetup101FDW."Unit Volume UOM"; // POENAB02, 08.04.2026
            }
        }
    }

    // actions
    // {
    //     addafter(ShowMatrix_Process)
    //     {
    //         action(Show_MatrixHNK)
    //         {
    //             ApplicationArea = All;
    //             Caption = 'Show Matrix', comment = 'ENU="Show Matrix"';
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //             Image = ShowMatrix;

    //             trigger OnAction()
    //             begin
    //                 Clear(SalesAnalysisByDimMatrixHNK);
    //                 ShowMatrixHNK();
    //             end;
    //         }
    //     }

    //     modify(ShowMatrix_Process)
    //     {
    //         Visible = false;
    //         Enabled = false;
    //     }
    // }//Bc Upgrade YADAVM09 Action blocked to use base feature<<

    // POENAB02, 08.04.2026>>
    trigger OnOpenPage()
    begin
        // FoundationSetup101FDW.Get();
    end;
    // POENAB02, 08.04.2026<<

    var
        ValueTypeHNK: Enum ItemAnalysisValueTypeHNK;
        GLSetup: Record "General Ledger Setup";
        FoundationSetup101FDW: Record "FoundationSetup101FDW"; // POENAB02, 08.04.2026
        VolumeCaption: Label 'Volume '; // POENAB02, 08.04.2026        
        ItemAnalysisView: Record "Item Analysis View";
        ItemStatisticsBuffer: Record "Item Statistics Buffer";
        MATRIX_PeriodRecords: array[32] of Record Date;
        ItemAnalysisMgt: Codeunit "Item Analysis Management";
        MatrixMgt: Codeunit "Matrix Management";
        SalesAnalysisByDimMatrixHNK: Page SalesAnalysisByDimMatrixHNK;
        CurrentItemAnalysisViewCode: Code[10];
        CurrentAnalysisArea: Enum "Analysis Area Type";
        ShowActualBudget: Enum "Item Analysis Show Type";
        RoundingFactor: Enum "Analysis Rounding Factor";
        LineDimType: Enum "Item Analysis Dimension Type";
        ColumnDimType: Enum "Item Analysis Dimension Type";
        PeriodType: Enum "Analysis Period Type";
        BudgetFilter: Code[250];
        LineDimCode: Text[30];
        ColumnDimCode: Text[30];
        InternalDateFilter: Text[30];
        MatrixColumnCaptions: array[32] of Text[80];
        PeriodInitialized: Boolean;
        ShowColumnName: Boolean;
        ShowOppositeSign: Boolean;
        DateFilter: Text[30];
        Dim1Filter: Code[250];
        Dim2Filter: Code[250];
        Dim3Filter: Code[250];
        ItemFilter: Code[250];
        LocationFilter: Code[250];
        FirstColumnDate: Date;
        LastColumnDate: Date;
        NoOfColumns: Integer;
        MATRIX_PKFirstRecInCurrSet: Text;
        MATRIX_CurrSetLength: Integer;
        MATRIX_CaptionRange: Text;
        MATRIX_CodeRange: Text[250];
        NewItemAnalysisCode: Code[10];
        Dim1FilterEnable: Boolean;
        Dim2FilterEnable: Boolean;
        Dim3FilterEnable: Boolean;


    local procedure ShowMatrixHNK()
    var
        CurItemFilter: Text[250];
        CurLocationFilter: Text[250];
        CurDim1Filter: Text[250];
        CurDim2Filter: Text[250];
        CurDim3Filter: Text[250];
    begin
        PeriodInitialized := ColumnDimType = ColumnDimType::Period;
        if CurItemFilter = '' then
            CurItemFilter := ItemFilter;
        if CurLocationFilter = '' then
            CurLocationFilter := LocationFilter;
        if CurDim1Filter = '' then
            CurDim1Filter := Dim1Filter;
        if CurDim2Filter = '' then
            CurDim2Filter := Dim2Filter;
        if CurDim3Filter = '' then
            CurDim3Filter := Dim3Filter;

        SalesAnalysisByDimMatrixHNK.LoadMatrix(ItemAnalysisView,
          CurrentItemAnalysisViewCode, CurrentAnalysisArea,
          LineDimType, ColumnDimType, PeriodType, ValueTypeHNK,
          RoundingFactor, ShowActualBudget, MatrixColumnCaptions,
          ShowOppositeSign, PeriodInitialized, ShowColumnName, MATRIX_CurrSetLength);
        SalesAnalysisByDimMatrixHNK.LoadFilters(CurItemFilter, CurLocationFilter, CurDim1Filter, CurDim2Filter, CurDim3Filter,
          DateFilter, BudgetFilter, InternalDateFilter);
        SalesAnalysisByDimMatrixHNK.LoadCodeRange(MATRIX_CodeRange);

        SalesAnalysisByDimMatrixHNK.RunModal();
    end;
}
