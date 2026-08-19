report 53051 "Material Stocks"
{
    // version HEI.02

    // HEI.01 FDD PRDGAP055 IBM ISYED01 23.05.2017
    //   # New report for material
    // 09.07.2018 FCE  I have increased the length of the WhseEntryLot from 10 --> 20

    // BC Upgrade KUMARR78 >>
    // Report Name  : Material Stocks
    // Report ID    : 50137
    // 1. Added Business Central visibility properties.
    //    Old:
    //         - ApplicationArea not mandatory in NAV.
    //         - UsageCategory not defined.
    //    New:
    //         - ApplicationArea = All
    //         - UsageCategory = ReportsAndAnalysis
    // 2. Updated Request Page OnLookup trigger signatures.
    //    Old:
    //         trigger OnLookup(Text: Text): Boolean;
    //    New:
    //         trigger OnLookup(var Text: Text): Boolean;
    //    Applied on:
    //         - LocationFilter
    //         - ZoneFilter
    //         - BinFilter
    // 3. Added ApplicationArea on Request Page fields.
    //    Old:
    //         - Fields without ApplicationArea property.
    //    New:
    //         - ApplicationArea = All added to:
    //              • LocationFilter
    //              • ZoneFilter
    //              • BinFilter
    // BC Upgrade KUMARR78 <<

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Material Stocks.rdl';
    ApplicationArea = All; // BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade KUMARR78 Adding Usagecategory


    Caption = 'Item Availability by Quality';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Item No.", Open, "Variant Code", "Location Code", "Lot No.") ORDER(Ascending) WHERE("Item No." = FILTER(<> 0));
            RequestFilterFields = "Item No.", "Lot No.";
            column(ReportTitle; ReportTitle)
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(ItemCptFilter; TABLECAPTION + ': ' + GETFILTERS)
            {
            }
            column(ItemFilter; GETFILTERS)
            {
            }
            column(ItemLedgerEntryFilterCpt; "Item Ledger Entry".TABLECAPTION + ': ' + "Item Ledger Entry".GETFILTERS)
            {
            }
            column(ItemLedgerEntryFilters; "Item Ledger Entry".GETFILTERS)
            {
            }
            column(PageNoCpt; PageNoCpt)
            {
            }
            column(ItemNo; "Item Ledger Entry"."Item No.")
            {
            }
            column(ItemDescription; Description)
            {
            }
            column(LocationCodeCpt; LocationCodeCpt)
            {
            }
            column(ItemNoCpt; ItemNoCpt)
            {
            }
            column(ItemDescriptionCpt; ItemDescriptionCpt)
            {
            }
            column(UnitOfMeasureCpt; UnitOfMeasureCpt)
            {
            }
            column(LotNoCpt; LotNoCpt)
            {
            }
            column(QualityStatusCpt; QualityStatusCpt)
            {
            }
            column(ZoneCpt; ZoneCpt)
            {
            }
            column(BinCpt; BinCpt)
            {
            }
            column(QuantityCpt; QuantityCpt)
            {
            }
            column(Qty; Quantoty_IOUM)
            {
            }
            column(LocationCode; "Item Ledger Entry"."Location Code")
            {
            }
            column(UnitOfMeasureCode; "Item Ledger Entry"."Unit of Measure Code")
            {
            }
            column(LotNo; "Item Ledger Entry"."Lot No.")
            {
            }
            column(Quantity; ItemLedgerEntryQty)
            {
            }
            column(QualityStatus; "Item Ledger Entry"."Quality Status FND")
            {
            }
            column(QtyHL; QuantityHL)
            {
            }
            column(LineType; LineType)
            {
            }
            column(WarehouseEntryQualityStatus; WarehouseEntryQualityStatus)
            {
            }
            column(IsBlocked; IsBlocked)
            {
            }
            column(WarehouseExpDate; WarehouseExpDate)
            {
            }
            column(B1; Bincode)
            {
            }
            column(Z1; ZoneCode)
            {
            }
            column(ItemLedgerEntryQualityStatus; ItemLedgerEntryQualityStatus)
            {
            }
            column(WhsQuantityBase; WarehouseQtyBase)
            {
            }
            column(WhseEntryLotNo; WhseEntryLotNo)
            {
            }

            trigger OnAfterGetRecord();
            begin
                CLEAR(ItemLedgerEntryQty);
                CLEAR(WhseEntryLotNo);
                ItemLedgerEntryQty := "Item Ledger Entry".Quantity * "Item Ledger Entry"."Qty. per Unit of Measure";

                if "Item Ledger Entry"."Unit of Measure Code" <> 'HL' then begin
                    ItemUnitofMeasure.RESET();
                    ItemUnitofMeasure.SETRANGE("Item No.", "Item Ledger Entry"."Item No.");
                    ItemUnitofMeasure.SETRANGE(Code, 'HL');
                    if ItemUnitofMeasure.FINDFIRST() then
                        QuantityHL := "Item Ledger Entry".Quantity / ItemUnitofMeasure."Qty. per Unit of Measure";
                end;

                ItemUnitofMeasure.RESET();
                ItemUnitofMeasure.SETRANGE("Item No.", "Item Ledger Entry"."Item No.");
                ItemUnitofMeasure.SETRANGE(Code, "Item Ledger Entry"."Unit of Measure Code");
                if ItemUnitofMeasure.FINDFIRST() then
                    Quantoty_IOUM := "Item Ledger Entry".Quantity / ItemUnitofMeasure."Qty. per Unit of Measure";

                CLEAR(LineType);
                ItemLedgerEntryQualityStatus := FORMAT("Item Ledger Entry"."Quality Status FND");

                WarehouseEntry.RESET();
                WarehouseEntry.SETFILTER(WarehouseEntry."Location Code", LocationFilter);
                WarehouseEntry.SETFILTER(WarehouseEntry."Item No.", "Item Ledger Entry"."Item No.");
                WarehouseEntry.SETFILTER(WarehouseEntry."Lot No.", "Item Ledger Entry"."Lot No.");
                WarehouseEntry.SETFILTER(WarehouseEntry."Zone Code", ZoneFilter);
                WarehouseEntry.SETFILTER(WarehouseEntry."Bin Code", BinFilter);
                //syed test june20>>
                WarehouseEntry.SETFILTER(WarehouseEntry."Reference No.", "Item Ledger Entry"."Document No.");
                //syed test june20>>

                if WarehouseEntry.FINDFIRST() then begin
                    WarehouseQtyBase := 0;
                    CLEAR(WarehouseEntryQualityStatus);
                    CLEAR(WarehouseExpDate);
                    CLEAR(ZoneCode);
                    CLEAR(Bincode);
                    CLEAR(IsBlocked);


                    WarehouseEntry.CALCSUMS("Qty. (Base)");
                    WarehouseQtyBase := WarehouseEntry."Qty. (Base)";
                    if WarehouseQtyBase = 0 then
                        CurrReport.SKIP();
                    LineType += 1;
                    if LineType > 1 then
                        CLEAR(ItemLedgerEntryQty);
                    CLEAR(IsBlocked);
                    WarehouseEntryQualityStatus := FORMAT("Item Ledger Entry"."Quality Status FND");
                    WarehouseExpDate := WarehouseEntry."Expiration Date";
                    ZoneCode := WarehouseEntry."Zone Code";
                    WhseEntryLotNo := WarehouseEntry."Lot No.";
                    Bincode := WarehouseEntry."Bin Code";
                    Bin.RESET();
                    Bin.SETFILTER(Code, BinFilter);
                    Bin.SETFILTER("Location Code", LocationFilter);
                    Bin.SETFILTER("Zone Code", ZoneFilter);
                    if Bin.FINDFIRST() then begin
                        if Bin."Block Movement" <> Bin."Block Movement"::" " then begin
                            WarehouseEntryQualityStatus := 'BLOCKED';
                            IsBlocked := true;
                            if "Item Ledger Entry"."Quality Status FND" <> "Item Ledger Entry"."Quality Status FND"::Blocked then
                                ItemLedgerEntryQualityStatus := 'Partially BLOCKED';
                        end;
                    end;

                    repeat until WarehouseEntry.NEXT() = 0;
                end
                else
                    CurrReport.SKIP();
            end;

            trigger OnPreDataItem();
            begin
                //IF (LocationFilter <>'') AND (BinFilter <> '') THEN BEGIN
                "Item Ledger Entry".SETFILTER("Item Ledger Entry"."Location Code", LocationFilter);
                //"Item Ledger Entry".SETFILTER("Item Ledger Entry"."Bin Code",BinFilter);
                //END;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(GENERAL)
                {
                    field(LocationFilter; LocationFilter)
                    {
                        Caption = 'LocationFilter';
                        ApplicationArea = all; //BC UPGRDAE KUMARR78 Adding ApplicationArea

                        // trigger OnLookup(Text: Text): Boolean; //BC UPGRDAE KUMARR78 Blocking
                        trigger OnLookup(Var Text: Text): Boolean; //BC UPGRDAE KUMARR78 Adding VAR into this.

                        var
                            Location: Record Location;
                        begin
                            CLEAR(LocationList);
                            CLEAR(Text);
                            LocationList.LOOKUPMODE := true;
                            if LocationList.RUNMODAL() = ACTION::LookupOK then begin
                                if Text <> '' then
                                    Text := Text + '|';
                                Text := Text + LocationList.GetSelectionFilter();
                                LocationFilter := Text;
                            end;
                            CLEAR(LocationList);
                        end;

                        trigger OnValidate();
                        var
                            Location: Record Location;
                        begin
                            if LocationFilter <> '' then begin
                                ZoneFilter := '';
                                BinFilter := '';
                            end;
                        end;
                    }
                    field(ZoneFilter; ZoneFilter)
                    {
                        Caption = 'ZoneFilter';
                        ApplicationArea = all; //BC UPGRDAE KUMARR78 Adding ApplicationArea

                        // trigger OnLookup(Text: Text): Boolean; //BC UPGRDAE KUMARR78 Blocking
                        trigger OnLookup(Var Text: Text): Boolean; //BC UPGRDAE KUMARR78 Adding VAR into this.
                        var
                            zone: Record Zone;
                        begin
                            if LocationFilter <> '' then begin
                                CLEAR(ZoneList);
                                zone.RESET();
                                zone.SETFILTER(zone."Location Code", LocationFilter);
                                ZoneList.SETTABLEVIEW(zone);
                                ZoneList.LOOKUPMODE := true;
                                if ZoneList.RUNMODAL() = ACTION::LookupOK then begin
                                    Text := ZoneList.GetSelectionFilter();
                                    ZoneFilter := Text;
                                end;
                            end;
                            CLEAR(ZoneList);
                        end;

                        trigger OnValidate();
                        begin
                            if ZoneFilter <> '' then begin
                                BinFilter := '';
                            end;
                        end;
                    }
                    field(BinFilter; BinFilter)
                    {
                        Caption = 'BinFilter';
                        ApplicationArea = all; //BC UPGRDAE KUMARR78 Adding ApplicationArea

                        // trigger OnLookup(Text: Text): Boolean; //BC UPGRDAE KUMARR78 Blocking
                        trigger OnLookup(Var Text: Text): Boolean; //BC UPGRDAE KUMARR78 Adding VAR into this.
                        var
                            Bin: Record Bin;
                        begin
                            CLEAR(BinFilter);
                            CLEAR(BinList);
                            if (ZoneFilter <> '') or (LocationFilter <> '') then begin
                                Bin.RESET();
                                Bin.SETFILTER(Bin."Zone Code", ZoneFilter);
                                Bin.SETFILTER(Bin."Location Code", LocationFilter);

                                BinList.SETTABLEVIEW(Bin);

                                BinList.LOOKUPMODE := true;
                                if BinList.RUNMODAL() = ACTION::LookupOK then begin
                                    Text := BinList.GetSelectionFilter();
                                    BinFilter := Text;
                                end;
                            end;
                            CLEAR(BinList);
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            if (LocationFilter = '') and (BinFilter = '') and (ZoneFilter = '') then
                UseAsInTransit := true
            else
                UseAsInTransit := false;
        end;
    }

    labels
    {
        lblQuantity = 'Quantity'; lblQuantityHL = 'Quantity HL'; lblExpiryDate = 'Expiry Date'; lblQuantityBase = 'Quantity (Base)';
    }

    var
        Bin: Record Bin;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        WarehouseEntry: Record "Warehouse Entry";
        BinList: Page "Bin List";
        LocationList: Page "Location List";
        ZoneList: Page "Zone List";
        IsBlocked: Boolean;
        UseAsInTransit: Boolean;
        WhseEntryLotNo: Code[20];
        Bincode: Code[250];
        ZoneCode: Code[250];
        WarehouseExpDate: Date;
        ItemLedgerEntryQty: Decimal;
        QuantityHL: Decimal;
        Quantoty_IOUM: Decimal;
        WarehouseQtyBase: Decimal;
        LineType: Integer;
        BinCpt: Label 'Bin';
        ItemDescriptionCpt: Label 'Item Description';
        ItemNoCpt: Label 'Item No.';
        LocationCodeCpt: Label 'Location Code';
        LotNoCpt: Label 'Lot No.';
        PageNoCpt: Label 'Page';
        QualityStatusCpt: Label 'Quality Status';
        QuantityCpt: Label 'Quantity';
        ReportTitle: Label 'Item Availability by Quality';
        UnitOfMeasureCpt: Label 'UOM';
        ZoneCpt: Label '"Zone "';
        ItemLedgerEntryQualityStatus: Text[30];
        WarehouseEntryQualityStatus: Text[30];
        BinFilter: Text[250];
        LocationFilter: Text[250];
        ZoneFilter: Text[250];
}

