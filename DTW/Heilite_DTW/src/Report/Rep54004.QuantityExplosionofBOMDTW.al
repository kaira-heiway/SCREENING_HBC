namespace BC_DTWLocal.BC_DTWLocal;
using Microsoft.Inventory.Item;
using System.Utilities;
using Microsoft.Inventory.Location;
using Microsoft.Foundation.UOM;
using Microsoft.Manufacturing.ProductionBOM;

report 54004 "Quantity Explosion of BOM DTW"
{// BC Upgrade Kamnay01  Created this report to provide the quantity explosion of BOM for the items. This is a  report for FDD-DTW-028

    ApplicationArea = All;
    Caption = 'Quantity Explosion of BOM DTW';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\QuantityExplosionofBOM_DTW.rdl';


    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Search Description", "Inventory Posting Group";
            column(AsOfCalcDate; Text000 + Format(CalculateDate))
            {
            }
            // RDLC only
            column(CompanyName; COMPANYPROPERTY.DisplayName())
            {
            }
            // RDLC only
            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(ItemTableCaptionFilter; TableCaption + ': ' + ItemFilter)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(No_Item; "No.")
            {
                IncludeCaption = true;
            }
            column(Desc_Item; Description)
            {
                IncludeCaption = true;
            }
            // RDLC only
            column(QtyExplosionofBOMCapt; QtyExplosionofBOMCaptLbl)
            {
            }
            // RDLC only
            column(CurrReportPageNoCapt; CurrReportPageNoCaptLbl)
            {
            }
            column(BOMQtyCaption; BOMQtyCaptionLbl)
            {
            }
            column(BomCompLevelQtyCapt; BomCompLevelQtyCaptLbl)
            {
            }
            column(BomCompLevelDescCapt; BomCompLevelDescCaptLbl)
            {
            }
            column(BomCompLevelNoCapt; BomCompLevelNoCaptLbl)
            {
            }
            column(LevelCapt; LevelCaptLbl)
            {
            }
            column(BomCompLevelUOMCodeCapt; BomCompLevelUOMCodeCaptLbl)
            {
            }
            column(LocationCodeCapt; LocationCodeCaptLbl)
            { }
            column(VariantCodeCapt; VariantCodeCaptLbl)
            { }
            column(CalculateFrom; CalculateFrom)
            {

            }
            column(BomCompLevelVersCodeCapt; BomCompLevelVersCodeCaptLbl)
            {
            }
            column(BomCompLevelScrapCapt; BomCompLevelScrapCaptLbl)
            {
            }
            column(ShowItem; ShowItem)
            { }
            dataitem(StockkeepingUnitLoop; "Integer")
            {
                DataItemLinkReference = Item;
                DataItemTableView = sorting(Number);

                column(LocationCode_StockkeepingUnit; StockkeepingUnit."Location Code")
                { }
                column(VariantCode_StockkeepingUnit; StockkeepingUnit."Variant Code")
                { }



                dataitem(BOMLoop; "Integer")
                {
                    DataItemTableView = sorting(Number);
                    DataItemLinkReference = StockkeepingUnitLoop;
                    dataitem("Integer"; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        MaxIteration = 1;
                        column(BomCompLevelNo; BomComponent[Level]."No.")
                        {
                            IncludeCaption = true;
                        }
                        column(BomCompLevelDesc; BomComponent[Level].Description)
                        {
                            IncludeCaption = true;
                        }
                        column(BOMQty; BOMQty)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(FormatLevel; PadStr('', Level, ' ') + Format(Level))
                        {
                        }
                        column(IndentLevel; IndentLevel)
                        {
                        }
                        column(BomCompLevelQty; BomComponent[Level].Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                            IncludeCaption = true;
                        }
                        column(BomCompLevelUOMCode; BomComponent[Level]."Unit of Measure Code")
                        {
                            IncludeCaption = true;
                        }
                        column(BomCompLevelScrap; BomComponent[Level]."Scrap %")
                        {
                            DecimalPlaces = 2;
                            IncludeCaption = true;
                        }
                        column(BomCompLevelVersCode; BomComponent[Level]."Version Code")
                        {
                            IncludeCaption = true;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            Clear(IndentLevel);
                            BOMQty := Quantity[Level] * QtyPerUnitOfMeasure * BomComponent[Level].Quantity * (1 + BomComponent[Level]."Scrap %" / 100);
                            while IndentLoop < Level do begin
                                IndentLevel += IndentLevel + '.';
                                IndentLoop += 1;
                            end;

                            IndentLoop := 0;
                        end;

                        trigger OnPostDataItem()
                        begin
                            Level := NextLevel;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    var
                        BomItem: Record Item;
                    begin
                        while BomComponent[Level].Next() = 0 do begin
                            Level := Level - 1;
                            if Level < 1 then
                                CurrReport.Break();
                        end;

                        NextLevel := Level;
                        Clear(CompItem);
                        QtyPerUnitOfMeasure := 1;
                        case BomComponent[Level].Type of
                            BomComponent[Level].Type::Item:
                                begin
                                    IF CalculateFrom = CalculateFrom::Item THEN BEGIN
                                        CompItem.Get(BomComponent[Level]."No.");
                                        if CompItem."Production BOM No." <> '' then begin
                                            ProdBOM.Get(CompItem."Production BOM No.");
                                        END ELSE BEGIN
                                            CompSKU.SETRANGE(CompSKU."Item No.", BomComponent[Level]."No.");
                                            // HEI.03- adding the location to the sku
                                            CompSKU.SETRANGE(CompSKU."Location Code", LocationCode);
                                            // HEI.03+ end
                                            IF CompSKU.FINDSET THEN BEGIN
                                                IF CompSKU."Production BOM No." <> '' THEN
                                                    ProdBOM.GET(CompSKU."Production BOM No.");
                                                CompItem."Production BOM No." := CompSKU."Production BOM No.";
                                            END;
                                        END;
                                        // >>DITW111.00.13 ISL NRQ#39742
                                        if ProdBOM.Status = ProdBOM.Status::Closed then
                                            CurrReport.Skip();
                                        NextLevel := Level + 1;
                                        if Level > 1 then
                                            if (NextLevel > 50) or (BomComponent[Level]."No." = NoList[Level - 1]) then
                                                Error(ProdBomErr, 50, Item."No.", NoList[Level], Level);
                                        Clear(BomComponent[NextLevel]);
                                        NoListType[NextLevel] := NoListType[NextLevel] ::Item;
                                        NoList[NextLevel] := CompItem."No.";
                                        VersionCode[NextLevel] :=
                                          VersionMgt.GetBOMVersion(CompItem."Production BOM No.", CalculateDate, true);
                                        BomComponent[NextLevel].SetRange("Production BOM No.", CompItem."Production BOM No.");
                                        BomComponent[NextLevel].SetRange("Version Code", VersionCode[NextLevel]);
                                        BomComponent[NextLevel].SetFilter("Starting Date", '%1|..%2', 0D, CalculateDate);
                                        BomComponent[NextLevel].SetFilter("Ending Date", '%1|%2..', 0D, CalculateDate);
                                    end;
                                    if Level > 1 then
                                        if BomComponent[Level - 1].Type = BomComponent[Level - 1].Type::Item then
                                            if BomItem.Get(BomComponent[Level - 1]."No.") then
                                                QtyPerUnitOfMeasure :=
                                                  UOMMgt.GetQtyPerUnitOfMeasure(BomItem, BomComponent[Level - 1]."Unit of Measure Code") /
                                                  UOMMgt.GetQtyPerUnitOfMeasure(
                                                    BomItem, VersionMgt.GetBOMUnitOfMeasure(BomItem."Production BOM No.", VersionCode[Level]));
                                end;
                            BomComponent[Level].Type::"Production BOM":
                                begin
                                    ProdBOM.Get(BomComponent[Level]."No.");
                                    if ProdBOM.Status = ProdBOM.Status::Closed then
                                        CurrReport.Skip();
                                    NextLevel := Level + 1;
                                    if Level > 1 then
                                        if (NextLevel > 50) or (BomComponent[Level]."No." = NoList[Level - 1]) then
                                            Error(ProdBomErr, 50, Item."No.", NoList[Level], Level);
                                    Clear(BomComponent[NextLevel]);
                                    NoListType[NextLevel] := NoListType[NextLevel] ::"Production BOM";
                                    NoList[NextLevel] := ProdBOM."No.";
                                    VersionCode[NextLevel] := VersionMgt.GetBOMVersion(ProdBOM."No.", CalculateDate, true);
                                    BomComponent[NextLevel].SetRange("Production BOM No.", NoList[NextLevel]);
                                    BomComponent[NextLevel].SetRange("Version Code", VersionCode[NextLevel]);
                                    BomComponent[NextLevel].SetFilter("Starting Date", '%1|..%2', 0D, CalculateDate);
                                    BomComponent[NextLevel].SetFilter("Ending Date", '%1|%2..', 0D, CalculateDate);
                                end;
                        end;

                        if NextLevel <> Level then
                            Quantity[NextLevel] := BomComponent[NextLevel - 1].Quantity * QtyPerUnitOfMeasure * Quantity[Level];
                    end;

                    trigger OnPreDataItem()
                    begin
                        Level := 1;
                        // <<DITW111.00.13 ISL 25/09/2018 NRQ#39742
                        IF CalculateFrom = CalculateFrom::Item THEN
                            // >>DITW111.00.13 ISL 25/09/2018 NRQ#39742
                            ProdBOM.Get(Item."Production BOM No.")
                        ELSE BEGIN
                            ProdBOM.GET(StockkeepingUnit."Production BOM No.");
                            Item."Production BOM No." := StockkeepingUnit."Production BOM No.";
                        END;
                        // >>DITW111.00.13 ISL 25/09/2018 NRQ#39742

                        VersionCode[Level] := VersionMgt.GetBOMVersion(Item."Production BOM No.", CalculateDate, true);
                        Clear(BomComponent);
                        BomComponent[Level]."Production BOM No." := Item."Production BOM No.";
                        BomComponent[Level].SetRange("Production BOM No.", Item."Production BOM No.");
                        BomComponent[Level].SetRange("Version Code", VersionCode[Level]);
                        BomComponent[Level].SetFilter("Starting Date", '%1|..%2', 0D, CalculateDate);
                        BomComponent[Level].SetFilter("Ending Date", '%1|%2..', 0D, CalculateDate);
                        NoListType[Level] := NoListType[Level] ::Item;
                        NoList[Level] := Item."No.";
                        Quantity[Level] :=
                          UOMMgt.GetQtyPerUnitOfMeasure(Item, Item."Base Unit of Measure") /
                          UOMMgt.GetQtyPerUnitOfMeasure(
                            Item,
                            VersionMgt.GetBOMUnitOfMeasure(
                              Item."Production BOM No.", VersionCode[Level]));
                    end;
                }
                trigger OnPreDataItem()
                begin
                    // <<DITW111.00.13 ISL 25/09/2018 NRQ#39742
                    IF CalculateFrom = CalculateFrom::Item THEN
                        SETRANGE(Number, 1)
                    ELSE
                        SETRANGE(Number, 1, StockkeepingUnit.COUNT);
                    // >>DITW111.00.13 ISL 25/09/2018 NRQ#39742
                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    // <<DITW111.00.13 ISL 25/09/2018 NRQ#39742
                    IF Number = 1 THEN
                        StockkeepingUnit.FINDFIRST
                    ELSE
                        StockkeepingUnit.NEXT;
                    // >>DITW111.00.13 ISL 25/09/2018 NRQ#39742
                end;
            }

            trigger OnPreDataItem()
            begin
                ItemFilter := GetFilters();

                // <<DITW111.00.13 ISL 08/10/2018 NRQ#39742
                IF CalculateFrom = CalculateFrom::Item THEN
                    // <<DITW111.00.13 ISL NRQ#39742
                    SETFILTER("Production BOM No.", '<>%1', '');
            end;

            trigger OnAfterGetRecord()
            begin
                ShowItem := TRUE; //HEI.02
                                  // <<DITW111.00.13 ISL 25/09/2018 NRQ#39742
                IF CalculateFrom = CalculateFrom::SKU THEN BEGIN
                    StockkeepingUnit.RESET;
                    StockkeepingUnit.SETRANGE("Item No.", Item."No.");
                    StockkeepingUnit.SETRANGE("Location Code", LocationCode);
                    // <<DITW111.00.13 ISL 08/10/2018 NRQ#39742-DITW111.00.13A MSF 07/06/2019 NRQ#110915
                    StockkeepingUnit.SETFILTER("Production BOM No.", '<>%1', '');
                    // <<DITW111.00.13 ISL NRQ#39742-DITW111.00.13A MSF 07/06/2019 NRQ#110915
                    //HEI.02>>
                    IF BOMlinked AND (StockkeepingUnit.COUNT = 0) THEN
                        ShowItem := FALSE;
                    //HEI.02<<
                END;
                // >>DITW111.00.13 ISL 25/09/2018 NRQ#39742
            End;

        }
    }

    requestpage
    {
        AboutTitle = 'About Quantity Explosion of BOM';
        AboutText = 'Provides an overview on the dynamic BOM availability. Visualise key inventory figures and forecast production capabilities to meet demand efficiently. Stay ahead with real-time insights into your assembly and production schedules.';


        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(CalculateDate; CalculateDate)
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Calculation Date';
                        ToolTip = 'Specifies the date you want the program to calculate the quantity of the BOM lines.';
                    }
                    field(CalculateFrom; CalculateFrom)
                    {
                        ApplicationArea = All;
                        Caption = 'Calculate From';
                        ToolTip = 'Specifies the level from which you want the program to calculate the quantity of the BOM lines. For example, if you enter 2, the program will calculate the quantity starting from level 2 and will not calculate the quantity for level 1.';
                    }
                    field(LocationCode; LocationCode)
                    {
                        ApplicationArea = All;
                        ;
                        Caption = 'Location Code';
                        ToolTip = 'Specifies the location code to filter the stockkeeping units. If you leave this field blank, the program will include all location codes.';
                        TableRelation = Location.Code;
                    }
                    field(BOMlinked; BOMlinked)
                    {
                        ApplicationArea = All;
                        Caption = 'Only BoM linked';
                        ToolTip = 'If you select this option, the program will only include items that have a BOM. If you leave this field blank, the program will include all items regardless of whether they have a BOM or not.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            CalculateDate := WorkDate();
        end;
    }



    labels
    {
        QuantityExplosionOfBOM = 'Quantity Explosion of BOM';
        QtyExplosionOfBOMPrint = 'Qty. Expl. Of BOM (Print)', MaxLength = 31, Comment = 'Excel worksheet name.';
        BOMTopLvlPrint = 'BOM (Top Level) (Print)', MaxLength = 31, Comment = 'Excel worksheet name.';
        QtyExplosionOfBOMAnalysis = 'Qty. Expl. Of BOM (Analysis)', MaxLength = 31, Comment = 'Excel worksheet name.';
        QtyExplosionOfBOMAnalysisL1 = 'Qty. Expl. Of BOM (Analysis) L1', MaxLength = 31, Comment = 'Excel worksheet name.';
        ItemNo = 'Item No.';
        ItemDesc = 'Item Description';
        Level = 'Level';
        BOMQtyCapt = 'Total Quantity';
        CalculationDateLabel = 'Calculation Date:';
        DataRetrieved = 'Data retrieved:';
        // About the report labels
        AboutTheReportLabel = 'About the report', MaxLength = 31, Comment = 'Excel worksheet name.';
        EnvironmentLabel = 'Environment';
        CompanyLabel = 'Company';
        UserLabel = 'User';
        RunOnLabel = 'Run on';
        ReportNameLabel = 'Report name';
        DocumentationLabel = 'Documentation';
    }

    trigger OnPreReport()
    begin
        // <<DITW111.00.13 ISL 25/09/2018 NRQ#39742
        IF CalculateFrom = CalculateFrom::SKU THEN
            IF LocationCode = '' THEN
                ERROR(LocationCodeErr);
        // <<DITW111.00.13 ISL 25/09/2018 NRQ#39742

    end;

    var
#pragma warning disable AA0074
        Text000: Label 'As of ';
#pragma warning restore AA0074
        StockkeepingUnit: Record "Stockkeeping Unit";
        LocationCodeErr: Label 'You must fill the Location Code';

        CalculateFrom: Option Item,SKU;
        LocationCode: Code[10];

        LocationEditable: Boolean;
        CompSKU: Record "Stockkeeping Unit";
        BOMlinked: Boolean;
        ShowItem: Boolean;
        ProdBOM: Record "Production BOM Header";
        CompItem: Record Item;
        UOMMgt: Codeunit "Unit of Measure Management";
        VersionMgt: Codeunit VersionManagement;
        ItemFilter: Text;
        IndentLevel: Text;
        IndentLoop: Integer;
        CalculateDate: Date;
        NoList: array[99] of Code[20];
        VersionCode: array[99] of Code[20];
        Quantity: array[99] of Decimal;
        QtyPerUnitOfMeasure: Decimal;
        NextLevel: Integer;
        BOMQty: Decimal;
        // RDLC only
        QtyExplosionofBOMCaptLbl: Label 'Quantity Explosion of BOM';
        // RDLC only
        CurrReportPageNoCaptLbl: Label 'Page';
        BOMQtyCaptionLbl: Label 'Total Quantity';
        BomCompLevelQtyCaptLbl: Label 'BOM Quantity';
        BomCompLevelDescCaptLbl: Label 'Description';
        BomCompLevelNoCaptLbl: Label 'No.';
        LevelCaptLbl: Label 'Level';
        BomCompLevelUOMCodeCaptLbl: Label 'Unit of Measure Code';
        NoListType: array[99] of Option " ",Item,"Production BOM";
#pragma warning disable AA0470
        ProdBomErr: Label 'The maximum number of BOM levels, %1, was exceeded. The process stopped at item number %2, BOM header number %3, BOM level %4.';
#pragma warning restore AA0470



        LocationCodeCaptLbl: Label 'Location Code';
        VariantCodeCaptLbl: Label 'Variant Code';
        BomCompLevelVersCodeCaptLbl: Label 'BOM Version Code';

        BomCompLevelScrapCaptLbl: Label 'Scrap %';
        BomCompLevelVersCodeLbl: Label 'BOM Version Code';

    protected var
        BomComponent: array[99] of Record "Production BOM Line";
        Level: Integer;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnPreReport(var Item: Record Item)
    begin
    end;
}
