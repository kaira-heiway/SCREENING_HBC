codeunit 55001 ItemAnalysisMgtRtR
{
    // POENAB02, 19.03.2026, Gap "BPM051-Create CAPEX budget", new object

    trigger OnRun()
    begin
    end;

    procedure DrillDownAmount(CurrentAnalysisArea: Enum "Analysis Area Type"; ItemStatisticsBuffer: Record "Item Statistics Buffer"; CurrentItemAnalysisViewCode: Code[10]; ItemFilter: Text; LocationFilter: Text; DateFilter: Text; Dim1Filter: Text; Dim2Filter: Text; Dim3Filter: Text; BudgetFilter: Text; LineDimType: Enum "Item Analysis Dimension Type"; LineDimCodeBuf: Record "Dimension Code Buffer"; ColDimType: Enum "Item Analysis Dimension Type"; ColDimCodeBuf: Record "Dimension Code Buffer"; SetColumnFilter: Boolean; ValueType: Enum ItemAnalysisValueTypeHNK; ShowActualBudget: Enum "Item Analysis Show Type")
    var
        ItemAnalysisViewEntry: Record "Item Analysis View Entry";
        ItemAnalysisViewBudgetEntry: Record "Item Analysis View Budg. Entry";
    begin
        SetBufferFilters(
          CurrentAnalysisArea, ItemStatisticsBuffer, CurrentItemAnalysisViewCode,
          ItemFilter, LocationFilter, DateFilter, Dim1Filter, Dim2Filter, Dim3Filter, BudgetFilter);
        SetDimFilters(ItemStatisticsBuffer, LineDimType, LineDimCodeBuf);
        if SetColumnFilter then
            SetDimFilters(ItemStatisticsBuffer, ColDimType, ColDimCodeBuf);

        case ShowActualBudget of
            ShowActualBudget::"Actual Amounts",
            ShowActualBudget::Variance,
            ShowActualBudget::"Variance%",
            ShowActualBudget::"Index%":
                begin
                    FilterItemAnalyViewEntry(ItemStatisticsBuffer, ItemAnalysisViewEntry);
                    case ValueType of
                        ValueType::"Sales Amount":
                            PAGE.Run(0, ItemAnalysisViewEntry, ItemAnalysisViewEntry."Sales Amount (Actual)");
                        ValueType::"Cost Amount":
                            PAGE.Run(0, ItemAnalysisViewEntry, ItemAnalysisViewEntry."Cost Amount (Actual)");
                        ValueType::Quantity:
                            PAGE.Run(0, ItemAnalysisViewEntry, ItemAnalysisViewEntry.Quantity);
                        ValueType::"Volume 1":
                            PAGE.Run(0, ItemAnalysisViewEntry, ItemAnalysisViewEntry."Volume 1 101FDW");
                        ValueType::"Volume 2":
                            PAGE.Run(0, ItemAnalysisViewEntry, ItemAnalysisViewEntry."Volume 2 101FDW");
                    end;
                end;
            ShowActualBudget::"Budgeted Amounts":
                begin
                    FilterItemAnalyViewBudgEntry(ItemStatisticsBuffer, ItemAnalysisViewBudgetEntry);
                    case ValueType of
                        ValueType::"Sales Amount":
                            PAGE.Run(0, ItemAnalysisViewBudgetEntry, ItemAnalysisViewBudgetEntry."Sales Amount");
                        ValueType::"Cost Amount":
                            PAGE.Run(0, ItemAnalysisViewBudgetEntry, ItemAnalysisViewBudgetEntry."Cost Amount");
                        ValueType::Quantity:
                            PAGE.Run(0, ItemAnalysisViewBudgetEntry, ItemAnalysisViewBudgetEntry.Quantity);
                        ValueType::"Volume 1":
                            PAGE.Run(0, ItemAnalysisViewBudgetEntry, ItemAnalysisViewBudgetEntry."Volume 1 FND");
                        ValueType::"Volume 2":
                            PAGE.Run(0, ItemAnalysisViewBudgetEntry, ItemAnalysisViewBudgetEntry."Volume 2 FND");
                    end;
                end;
        end;
    end;

    procedure SetBufferFilters(CurrentAnalysisArea: Enum "Analysis Area Type"; var ItemStatisticsBuffer: Record "Item Statistics Buffer"; CurrentAnalysisViewCode: Code[10]; ItemFilter: Text; LocationFilter: Text; DateFilter: Text; Dim1Filter: Text; Dim2Filter: Text; Dim3Filter: Text; BudgetFilter: Text)
    begin
        ItemStatisticsBuffer.Reset();
        ItemStatisticsBuffer.SetRange("Analysis Area Filter", CurrentAnalysisArea);
        ItemStatisticsBuffer.SetRange("Analysis View Filter", CurrentAnalysisViewCode);

        if ItemFilter <> '' then
            ItemStatisticsBuffer.SetFilter("Item Filter", ItemFilter);
        if LocationFilter <> '' then
            ItemStatisticsBuffer.SetFilter("Location Filter", LocationFilter);
        if DateFilter <> '' then
            ItemStatisticsBuffer.SetFilter("Date Filter", DateFilter);
        if Dim1Filter <> '' then
            ItemStatisticsBuffer.SetFilter("Dimension 1 Filter", Dim1Filter);
        if Dim2Filter <> '' then
            ItemStatisticsBuffer.SetFilter("Dimension 2 Filter", Dim2Filter);
        if Dim3Filter <> '' then
            ItemStatisticsBuffer.SetFilter("Dimension 3 Filter", Dim3Filter);
        if BudgetFilter <> '' then
            ItemStatisticsBuffer.SetFilter("Budget Filter", BudgetFilter);
    end;

    local procedure FilterItemAnalyViewEntry(var ItemStatisticsBuffer: Record "Item Statistics Buffer"; var ItemAnalysisViewEntry: Record "Item Analysis View Entry")
    begin
        ItemStatisticsBuffer.CopyFilter("Analysis Area Filter", ItemAnalysisViewEntry."Analysis Area");
        ItemStatisticsBuffer.CopyFilter("Analysis View Filter", ItemAnalysisViewEntry."Analysis View Code");

        if ItemStatisticsBuffer.GetFilter("Item Filter") <> '' then
            ItemStatisticsBuffer.CopyFilter("Item Filter", ItemAnalysisViewEntry."Item No.");

        if ItemStatisticsBuffer.GetFilter("Date Filter") <> '' then
            ItemStatisticsBuffer.CopyFilter("Date Filter", ItemAnalysisViewEntry."Posting Date");

        if ItemStatisticsBuffer.GetFilter("Location Filter") <> '' then
            ItemStatisticsBuffer.CopyFilter("Location Filter", ItemAnalysisViewEntry."Location Code");

        if ItemStatisticsBuffer.GetFilter("Dimension 1 Filter") <> '' then
            ItemStatisticsBuffer.CopyFilter("Dimension 1 Filter", ItemAnalysisViewEntry."Dimension 1 Value Code");

        if ItemStatisticsBuffer.GetFilter("Dimension 2 Filter") <> '' then
            ItemStatisticsBuffer.CopyFilter("Dimension 2 Filter", ItemAnalysisViewEntry."Dimension 2 Value Code");

        if ItemStatisticsBuffer.GetFilter("Dimension 3 Filter") <> '' then
            ItemStatisticsBuffer.CopyFilter("Dimension 3 Filter", ItemAnalysisViewEntry."Dimension 3 Value Code");
    end;

    local procedure SetDimFilters(var ItemStatisticsBuffer: Record "Item Statistics Buffer"; DimType: Enum "Item Analysis Dimension Type"; DimCodeBuf: Record "Dimension Code Buffer")
    begin
        case DimType of
            DimType::Item:
                ItemStatisticsBuffer.SetRange("Item Filter", DimCodeBuf.Code);
            DimType::Period:
                ItemStatisticsBuffer.SetRange("Date Filter", DimCodeBuf."Period Start", DimCodeBuf."Period End");
            DimType::Location:
                ItemStatisticsBuffer.SetRange("Location Filter", DimCodeBuf.Code);
            DimType::"Dimension 1":
                if DimCodeBuf.Totaling <> '' then
                    ItemStatisticsBuffer.SetFilter("Dimension 1 Filter", DimCodeBuf.Totaling)
                else
                    ItemStatisticsBuffer.SetRange("Dimension 1 Filter", DimCodeBuf.Code);
            DimType::"Dimension 2":
                if DimCodeBuf.Totaling <> '' then
                    ItemStatisticsBuffer.SetFilter("Dimension 2 Filter", DimCodeBuf.Totaling)
                else
                    ItemStatisticsBuffer.SetRange("Dimension 2 Filter", DimCodeBuf.Code);
            DimType::"Dimension 3":
                if DimCodeBuf.Totaling <> '' then
                    ItemStatisticsBuffer.SetFilter("Dimension 3 Filter", DimCodeBuf.Totaling)
                else
                    ItemStatisticsBuffer.SetRange("Dimension 3 Filter", DimCodeBuf.Code);
        end;
    end;

    local procedure FilterItemAnalyViewBudgEntry(var ItemStatisticsBuf: Record "Item Statistics Buffer"; var ItemAnalysisViewBudgEntry: Record "Item Analysis View Budg. Entry")
    begin
        ItemStatisticsBuf.CopyFilter("Analysis Area Filter", ItemAnalysisViewBudgEntry."Analysis Area");
        ItemStatisticsBuf.CopyFilter("Analysis View Filter", ItemAnalysisViewBudgEntry."Analysis View Code");
        ItemStatisticsBuf.CopyFilter("Budget Filter", ItemAnalysisViewBudgEntry."Budget Name");

        if ItemStatisticsBuf.GetFilter("Item Filter") <> '' then
            ItemStatisticsBuf.CopyFilter("Item Filter", ItemAnalysisViewBudgEntry."Item No.");

        if ItemStatisticsBuf.GetFilter("Location Filter") <> '' then
            ItemStatisticsBuf.CopyFilter("Location Filter", ItemAnalysisViewBudgEntry."Location Code");

        if ItemStatisticsBuf.GetFilter("Date Filter") <> '' then
            ItemStatisticsBuf.CopyFilter("Date Filter", ItemAnalysisViewBudgEntry."Posting Date");

        if ItemStatisticsBuf.GetFilter("Dimension 1 Filter") <> '' then
            ItemStatisticsBuf.CopyFilter("Dimension 1 Filter", ItemAnalysisViewBudgEntry."Dimension 1 Value Code");

        if ItemStatisticsBuf.GetFilter("Dimension 2 Filter") <> '' then
            ItemStatisticsBuf.CopyFilter("Dimension 2 Filter", ItemAnalysisViewBudgEntry."Dimension 2 Value Code");

        if ItemStatisticsBuf.GetFilter("Dimension 3 Filter") <> '' then
            ItemStatisticsBuf.CopyFilter("Dimension 3 Filter", ItemAnalysisViewBudgEntry."Dimension 3 Value Code");
    end;

    procedure FindRecord(var ItemAnalysisView: Record "Item Analysis View"; DimType: Enum "Item Analysis Dimension Type"; var DimCodeBuf: Record "Dimension Code Buffer"; Which: Text[250]; ItemFilter: Code[250]; LocationFilter: Code[250]; PeriodType: Enum "Analysis Period Type"; var DateFilter: Text[30]; var PeriodInitialized: Boolean; InternalDateFilter: Text[30]; Dim1Filter: Code[250]; Dim2Filter: Code[250]; Dim3Filter: Code[250]): Boolean
    var
        Item: Record Item;
        Location: Record Location;
        Period: Record Date;
        DimVal: Record "Dimension Value";
        PeriodPageMgt: Codeunit PeriodPageManagement;
        Found: Boolean;
    begin
        case DimType of
            DimType::Item:
                begin
                    Item."No." := DimCodeBuf.Code;
                    if ItemFilter <> '' then
                        Item.SetFilter("No.", ItemFilter);
                    Found := Item.Find(Which);
                    if Found then
                        CopyItemToBuf(Item, DimCodeBuf);
                end;
            DimType::Period:
                begin
                    if not PeriodInitialized then
                        DateFilter := '';
                    PeriodInitialized := true;
                    Period."Period Start" := DimCodeBuf."Period Start";
                    case PeriodType of
                        PeriodType::Week:
                            if (InternalDateFilter <> '') then
                                Period.SetFilter("Period Start", InternalDateFilter)
                            else
                                if DateFilter <> '' then
                                    Period.SetFilter("Period Start", DateFilter);
                        else
                            if DateFilter <> '' then
                                Period.SetFilter("Period Start", DateFilter)
                            else
                                if InternalDateFilter <> '' then
                                    Period.SetFilter("Period Start", InternalDateFilter);
                    end;
                    Found := PeriodPageMgt.FindDate(Which, Period, PeriodType);
                    if Found then
                        CopyPeriodToBuf(Period, DimCodeBuf, DateFilter);
                end;
            DimType::Location:
                begin
                    Location.Code := CopyStr(DimCodeBuf.Code, 1, MaxStrLen(Location.Code));
                    if LocationFilter <> '' then
                        Location.SetFilter(Code, LocationFilter);
                    Found := Location.Find(Which);
                    if Found then
                        CopyLocationToBuf(Location, DimCodeBuf);
                end;
            DimType::"Dimension 1":
                begin
                    if Dim1Filter <> '' then
                        DimVal.SetFilter(Code, Dim1Filter);
                    DimVal."Dimension Code" := ItemAnalysisView."Dimension 1 Code";
                    DimVal.SetRange("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    Found := DimVal.Find(Which);
                    if Found then
                        CopyDimValueToBuf(DimVal, DimCodeBuf);
                end;
            DimType::"Dimension 2":
                begin
                    if Dim2Filter <> '' then
                        DimVal.SetFilter(Code, Dim2Filter);
                    DimVal."Dimension Code" := ItemAnalysisView."Dimension 2 Code";
                    DimVal.SetRange("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    Found := DimVal.Find(Which);
                    if Found then
                        CopyDimValueToBuf(DimVal, DimCodeBuf);
                end;
            DimType::"Dimension 3":
                begin
                    if Dim3Filter <> '' then
                        DimVal.SetFilter(Code, Dim3Filter);
                    DimVal."Dimension Code" := ItemAnalysisView."Dimension 3 Code";
                    DimVal.SetRange("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    Found := DimVal.Find(Which);
                    if Found then
                        CopyDimValueToBuf(DimVal, DimCodeBuf);
                end;
            else
        end;
        exit(Found);
    end;

    local procedure CopyItemToBuf(var Item: Record Item; var DimCodeBuf: Record "Dimension Code Buffer")
    begin
        DimCodeBuf.Init();
        DimCodeBuf.Code := Item."No.";
        DimCodeBuf.Name := Item.Description;
    end;

    local procedure CopyPeriodToBuf(var Period: Record Date; var DimCodeBuf: Record "Dimension Code Buffer"; DateFilter: Text[30])
    var
        Period2: Record Date;
    begin
        DimCodeBuf.Init();
        DimCodeBuf.Code := Format(Period."Period Start");
        DimCodeBuf."Period Start" := Period."Period Start";
        DimCodeBuf."Period End" := Period."Period End";
        if DateFilter <> '' then begin
            Period2.SetFilter("Period End", DateFilter);
            if Period2.GetRangeMax("Period End") < DimCodeBuf."Period End" then
                DimCodeBuf."Period End" := Period2.GetRangeMax("Period End");
        end;
        DimCodeBuf.Name := Period."Period Name";
    end;

    local procedure CopyLocationToBuf(var Location: Record Location; var DimCodeBuf: Record "Dimension Code Buffer")
    begin
        DimCodeBuf.Init();
        DimCodeBuf.Code := Location.Code;
        DimCodeBuf.Name := Location.Name;
    end;

    local procedure CopyDimValueToBuf(var DimVal: Record "Dimension Value"; var DimCodeBuf: Record "Dimension Code Buffer")
    begin
        DimCodeBuf.Init();
        DimCodeBuf.Code := DimVal.Code;
        DimCodeBuf.Name := DimVal.Name;
        DimCodeBuf.Totaling := DimVal.Totaling;
        DimCodeBuf.Indentation := DimVal.Indentation;
        DimCodeBuf."Show in Bold" :=
          DimVal."Dimension Value Type" <> DimVal."Dimension Value Type"::Standard;
    end;

    procedure NextRecord(var ItemAnalysisView: Record "Item Analysis View"; DimType: Enum "Item Analysis Dimension Type"; var DimCodeBuf: Record "Dimension Code Buffer"; Steps: Integer; ItemFilter: Code[250]; LocationFilter: Code[250]; PeriodType: Enum "Analysis Period Type"; DateFilter: Text[30]; Dim1Filter: Code[250]; Dim2Filter: Code[250]; Dim3Filter: Code[250]): Integer
    var
        Item: Record Item;
        Location: Record Location;
        Period: Record Date;
        DimVal: Record "Dimension Value";
        PeriodPageMgt: Codeunit PeriodPageManagement;
        ResultSteps: Integer;
    begin
        case DimType of
            DimType::Item:
                begin
                    Item."No." := DimCodeBuf.Code;
                    if ItemFilter <> '' then
                        Item.SetFilter("No.", ItemFilter);
                    ResultSteps := Item.Next(Steps);
                    if ResultSteps <> 0 then
                        CopyItemToBuf(Item, DimCodeBuf);
                end;
            DimType::Period:
                begin
                    if DateFilter <> '' then
                        Period.SetFilter("Period Start", DateFilter);
                    Period."Period Start" := DimCodeBuf."Period Start";
                    ResultSteps := PeriodPageMgt.NextDate(Steps, Period, PeriodType);
                    if ResultSteps <> 0 then
                        CopyPeriodToBuf(Period, DimCodeBuf, DateFilter);
                end;
            DimType::Location:
                begin
                    Location.Code := CopyStr(DimCodeBuf.Code, 1, MaxStrLen(Location.Code));
                    if LocationFilter <> '' then
                        Location.SetFilter(Code, LocationFilter);
                    ResultSteps := Location.Next(Steps);
                    if ResultSteps <> 0 then
                        CopyLocationToBuf(Location, DimCodeBuf);
                end;
            DimType::"Dimension 1":
                begin
                    if Dim1Filter <> '' then
                        DimVal.SetFilter(Code, Dim1Filter);
                    DimVal."Dimension Code" := ItemAnalysisView."Dimension 1 Code";
                    DimVal.SetRange("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    ResultSteps := DimVal.Next(Steps);
                    if ResultSteps <> 0 then
                        CopyDimValueToBuf(DimVal, DimCodeBuf);
                end;
            DimType::"Dimension 2":
                begin
                    if Dim2Filter <> '' then
                        DimVal.SetFilter(Code, Dim2Filter);
                    DimVal."Dimension Code" := ItemAnalysisView."Dimension 2 Code";
                    DimVal.SetRange("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    ResultSteps := DimVal.Next(Steps);
                    if ResultSteps <> 0 then
                        CopyDimValueToBuf(DimVal, DimCodeBuf);
                end;
            DimType::"Dimension 3":
                begin
                    if Dim3Filter <> '' then
                        DimVal.SetFilter(Code, Dim3Filter);
                    DimVal."Dimension Code" := ItemAnalysisView."Dimension 3 Code";
                    DimVal.SetRange("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    ResultSteps := DimVal.Next(Steps);
                    if ResultSteps <> 0 then
                        CopyDimValueToBuf(DimVal, DimCodeBuf);
                end;
        end;
        exit(ResultSteps);
    end;

    procedure CalculateAmount(ValueType: Enum ItemAnalysisValueTypeHNK; SetColumnFilter: Boolean; CurrentAnalysisArea: Enum "Analysis Area Type"; var ItemStatisticsBuffer: Record "Item Statistics Buffer"; CurrentItemAnalysisViewCode: Code[10]; ItemFilter: Code[250]; LocationFilter: Code[250]; DateFilter: Text[30]; BudgetFilter: Code[250]; Dim1Filter: Code[250]; Dim2Filter: Code[250]; Dim3Filter: Code[250]; LineDimType: Enum "Item Analysis Dimension Type"; LineDimCodeBuf: Record "Dimension Code Buffer"; ColDimType: Enum "Item Analysis Dimension Type"; ColDimCodeBuf: Record "Dimension Code Buffer"; ShowActualBudget: Enum "Item Analysis Show Type"): Decimal
    var
        Amount: Decimal;
        ActualAmt: Decimal;
        BudgetAmt: Decimal;
    begin
        case ShowActualBudget of
            ShowActualBudget::"Actual Amounts":
                Amount :=
                  CalcActualAmount(
                    ValueType, SetColumnFilter,
                    CurrentAnalysisArea, ItemStatisticsBuffer, CurrentItemAnalysisViewCode,
                    ItemFilter, LocationFilter, DateFilter, BudgetFilter,
                    Dim1Filter, Dim2Filter, Dim3Filter,
                    LineDimType, LineDimCodeBuf,
                    ColDimType, ColDimCodeBuf);
            ShowActualBudget::"Budgeted Amounts":
                Amount :=
                  CalcBudgetAmount(
                    ValueType, SetColumnFilter,
                    CurrentAnalysisArea, ItemStatisticsBuffer, CurrentItemAnalysisViewCode,
                    ItemFilter, LocationFilter, DateFilter, BudgetFilter,
                    Dim1Filter, Dim2Filter, Dim3Filter,
                    LineDimType, LineDimCodeBuf,
                    ColDimType, ColDimCodeBuf);
            ShowActualBudget::Variance:
                begin
                    ActualAmt :=
                      CalcActualAmount(
                        ValueType, SetColumnFilter,
                        CurrentAnalysisArea, ItemStatisticsBuffer, CurrentItemAnalysisViewCode,
                        ItemFilter, LocationFilter, DateFilter, BudgetFilter,
                        Dim1Filter, Dim2Filter, Dim3Filter,
                        LineDimType, LineDimCodeBuf,
                        ColDimType, ColDimCodeBuf);
                    BudgetAmt :=
                      CalcBudgetAmount(
                        ValueType, SetColumnFilter,
                        CurrentAnalysisArea, ItemStatisticsBuffer, CurrentItemAnalysisViewCode,
                        ItemFilter, LocationFilter, DateFilter, BudgetFilter,
                        Dim1Filter, Dim2Filter, Dim3Filter,
                        LineDimType, LineDimCodeBuf,
                        ColDimType, ColDimCodeBuf);
                    Amount := ActualAmt - BudgetAmt;
                end;
            ShowActualBudget::"Variance%":
                begin
                    Amount :=
                      CalcBudgetAmount(
                        ValueType, SetColumnFilter,
                        CurrentAnalysisArea, ItemStatisticsBuffer, CurrentItemAnalysisViewCode,
                        ItemFilter, LocationFilter, DateFilter, BudgetFilter,
                        Dim1Filter, Dim2Filter, Dim3Filter,
                        LineDimType, LineDimCodeBuf,
                        ColDimType, ColDimCodeBuf);
                    if Amount <> 0 then begin
                        ActualAmt :=
                          CalcActualAmount(
                            ValueType, SetColumnFilter,
                            CurrentAnalysisArea, ItemStatisticsBuffer, CurrentItemAnalysisViewCode,
                            ItemFilter, LocationFilter, DateFilter, BudgetFilter,
                            Dim1Filter, Dim2Filter, Dim3Filter,
                            LineDimType, LineDimCodeBuf,
                            ColDimType, ColDimCodeBuf);
                        Amount := Round(100 * (ActualAmt - Amount) / Amount);
                    end;
                end;
            ShowActualBudget::"Index%":
                begin
                    Amount :=
                      CalcBudgetAmount(
                        ValueType, SetColumnFilter,
                        CurrentAnalysisArea, ItemStatisticsBuffer, CurrentItemAnalysisViewCode,
                        ItemFilter, LocationFilter, DateFilter, BudgetFilter,
                        Dim1Filter, Dim2Filter, Dim3Filter,
                        LineDimType, LineDimCodeBuf,
                        ColDimType, ColDimCodeBuf);
                    ActualAmt :=
                      CalcActualAmount(
                        ValueType, SetColumnFilter,
                        CurrentAnalysisArea, ItemStatisticsBuffer, CurrentItemAnalysisViewCode,
                        ItemFilter, LocationFilter, DateFilter, BudgetFilter,
                        Dim1Filter, Dim2Filter, Dim3Filter,
                        LineDimType, LineDimCodeBuf,
                        ColDimType, ColDimCodeBuf);
                    if Amount <> 0 then
                        Amount := Round(100 * ActualAmt / Amount);
                end;
        end;
        exit(Amount);
    end;

    local procedure CalcActualAmount(ValueType: Enum ItemAnalysisValueTypeHNK; SetColumnFilter: Boolean; CurrentAnalysisArea: Enum "Analysis Area Type"; var ItemStatisticsBuffer: Record "Item Statistics Buffer"; CurrentItemAnalysisViewCode: Code[10]; ItemFilter: Code[250]; LocationFilter: Code[250]; DateFilter: Text[30]; BudgetFilter: Code[250]; Dim1Filter: Code[250]; Dim2Filter: Code[250]; Dim3Filter: Code[250]; LineDimType: Enum "Item Analysis Dimension Type"; LineDimCodeBuf: Record "Dimension Code Buffer"; ColDimType: Enum "Item Analysis Dimension Type"; ColDimCodeBuf: Record "Dimension Code Buffer"): Decimal
    var
        Amount: Decimal;
    begin
        SetBufferFilters(
          CurrentAnalysisArea, ItemStatisticsBuffer, CurrentItemAnalysisViewCode,
          ItemFilter, LocationFilter, DateFilter, Dim1Filter, Dim2Filter, Dim3Filter, BudgetFilter);

        SetDimFilters(ItemStatisticsBuffer, LineDimType, LineDimCodeBuf);
        if SetColumnFilter then
            SetDimFilters(ItemStatisticsBuffer, ColDimType, ColDimCodeBuf)
        else
            case ColDimType of
                ColDimType::"Dimension 1":
                    ItemStatisticsBuffer.SetRange("Dimension 1 Filter");
                ColDimType::"Dimension 2":
                    ItemStatisticsBuffer.SetRange("Dimension 2 Filter");
                ColDimType::"Dimension 3":
                    ItemStatisticsBuffer.SetRange("Dimension 3 Filter");
            end;

        case ValueType of
            ValueType::"Sales Amount":
                begin
                    ItemStatisticsBuffer.CalcFields("Analysis - Sales Amt. (Actual)", "Analysis - Sales Amt. (Exp)");
                    Amount :=
                      ItemStatisticsBuffer."Analysis - Sales Amt. (Actual)" +
                      ItemStatisticsBuffer."Analysis - Sales Amt. (Exp)";
                end;
            ValueType::"Cost Amount":
                begin
                    ItemStatisticsBuffer.CalcFields(
                      "Analysis - Cost Amt. (Actual)",
                      "Analysis - Cost Amt. (Exp)",
                      "Analysis CostAmt.(Non-Invtbl.)");
                    Amount :=
                      ItemStatisticsBuffer."Analysis - Cost Amt. (Actual)" +
                      ItemStatisticsBuffer."Analysis - Cost Amt. (Exp)" +
                      ItemStatisticsBuffer."Analysis CostAmt.(Non-Invtbl.)";
                end;
            ValueType::Quantity:
                begin
                    ItemStatisticsBuffer.CalcFields("Analysis - Quantity");
                    Amount := ItemStatisticsBuffer."Analysis - Quantity";
                end;
            ValueType::"Volume 1":
                begin
                    ItemStatisticsBuffer.CalcFields("Analysis - Volume 1 FND");
                    Amount := ItemStatisticsBuffer."Analysis - Volume 1 FND";
                end;
            ValueType::"Volume 2":
                begin
                    ItemStatisticsBuffer.CalcFields("Analysis - Volume 2 FND");
                    Amount := ItemStatisticsBuffer."Analysis - Volume 2 FND";
                end;
        end;

        exit(Amount);
    end;

    local procedure CalcBudgetAmount(ValueType: Enum ItemAnalysisValueTypeHNK; SetColumnFilter: Boolean; CurrentAnalysisArea: Enum "Analysis Area Type"; var ItemStatisticsBuffer: Record "Item Statistics Buffer"; CurrentItemAnalysisViewCode: Code[10]; ItemFilter: Code[250]; LocationFilter: Code[250]; DateFilter: Text[30]; BudgetFilter: Code[250]; Dim1Filter: Code[250]; Dim2Filter: Code[250]; Dim3Filter: Code[250]; LineDimType: Enum "Item Analysis Dimension Type"; LineDimCodeBuf: Record "Dimension Code Buffer"; ColDimType: Enum "Item Analysis Dimension Type"; ColDimCodeBuf: Record "Dimension Code Buffer"): Decimal
    var
        Amount: Decimal;
    begin
        SetBufferFilters(
          CurrentAnalysisArea, ItemStatisticsBuffer, CurrentItemAnalysisViewCode,
          ItemFilter, LocationFilter, DateFilter, Dim1Filter, Dim2Filter, Dim3Filter, BudgetFilter);

        SetDimFilters(ItemStatisticsBuffer, LineDimType, LineDimCodeBuf);
        if SetColumnFilter then
            SetDimFilters(ItemStatisticsBuffer, ColDimType, ColDimCodeBuf);

        case ValueType of
            ValueType::"Sales Amount":
                begin
                    ItemStatisticsBuffer.CalcFields("Analysis - Budgeted Sales Amt.");
                    Amount := ItemStatisticsBuffer."Analysis - Budgeted Sales Amt.";
                end;
            ValueType::"Cost Amount":
                begin
                    ItemStatisticsBuffer.CalcFields("Analysis - Budgeted Cost Amt.");
                    Amount := ItemStatisticsBuffer."Analysis - Budgeted Cost Amt.";
                end;
            ValueType::Quantity:
                begin
                    ItemStatisticsBuffer.CalcFields("Analysis - Budgeted Quantity");
                    Amount := ItemStatisticsBuffer."Analysis - Budgeted Quantity";
                end;
            ValueType::"Volume 1":
                begin
                    ItemStatisticsBuffer.CalcFields("Analysis - Budget Volume 1 FND");
                    Amount := ItemStatisticsBuffer."Analysis - Budget Volume 1 FND";
                end;
            ValueType::"Volume 2":
                begin
                    ItemStatisticsBuffer.CalcFields("Analysis - Budget Volume 2 FND");
                    Amount := ItemStatisticsBuffer."Analysis - Budget Volume 2 FND";
                end;
        end;

        exit(Amount);
    end;
}
