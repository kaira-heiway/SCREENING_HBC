report 54046 "Item Availability by Quality-N"
{
    // version HEI.10

    // HEI.01 IBM.AK CHG2072471
    //   # Copied from R50018 base report
    //   # Export to Excel functionality (Ungrouped data)
    //   # new design to save as excel for pivot filtering (Grouped data)
    // 
    // HEI.09 CHG2105032  IBM POENAB02 06.05.2021 HT2116 Inventory Aging Report
    //   # modified layout
    //   # modified trigger Item - OnAfterGetRecord
    //   # modified trigger Warehouse Entry - OnAfterGetRecord
    //   # modified function MakeExcelDataBody
    // 
    // HEI.10 CC-CHG2173831 IBM.AK 22.09.22
    //  # The value of the Extract content to be taken from the last entry registered.
    //*************************************************************************************************************************************

    // BC UPGRADE SHIKHD02 >>
    // 1. OLD ID -> 50457
    // 2. Added ApplicationArea = All; and UsageCategory = ReportsAndAnalysis; at report level below PreviewMode = PrintLayout;.
    // 3. Blocked Drink-IT field "Inventory Unit of Measure" but kept the column UOM and made SourceExpression blank in dataset > dataitem(Location) > dataitem(Item).
    // 4. Removed empty DataItemTableView = ''; from dataset > dataitem(Location) > dataitem(Item) > dataitem("Warehouse Entry").
    // 5. Blocked Drink-IT field "Inventory Unit of Measure" in trigger OnAfterGetRecord() of dataset > dataitem(Location) > dataitem(Item) > dataitem("Warehouse Entry") > dataitem(Total).
    // 6. Blocked Drink-IT field "Volume Unit of Measure Code" in trigger OnAfterGetRecord() of dataset > dataitem(Location) > dataitem(Item) > dataitem("Warehouse Entry") > dataitem(Total).
    // 7. Blocked Drink-IT field "Strength Spec. Value" in trigger OnAfterGetRecord() of dataset > dataitem(Location) > dataitem(Item) > dataitem("Warehouse Entry").
    // 8. Blocked Drink-IT field "Inventory Unit of Measure" while calculating QtyIUOM in trigger OnAfterGetRecord() of dataset > dataitem(Location) > dataitem(Item) > dataitem("Warehouse Entry").
    // 9. Blocked Drink-IT field "Volume Unit of Measure Code" while calculating QtyVUOM in trigger OnAfterGetRecord() of dataset > dataitem(Location) > dataitem(Item) > dataitem("Warehouse Entry").
    // 10. Blocked Drink-IT field "Inventory Unit of Measure" while updating temporary WarehouseEntryTMP in trigger OnAfterGetRecord() of dataset > dataitem(Location) > dataitem(Item) > dataitem("Warehouse Entry").
    // 11. Blocked Drink-IT field "Volume Unit of Measure Code" while updating temporary WarehouseEntryTMP2 in trigger OnAfterGetRecord() of dataset > dataitem(Location) > dataitem(Item) > dataitem("Warehouse Entry").
    // 12. Blocked Drink-IT field "Inventory Unit of Measure" while assigning temporary WarehouseEntryTMP."Qty. per Unit of Measure" in trigger OnAfterGetRecord() of dataset > dataitem(Location) > dataitem(Item) > dataitem("Warehouse Entry").
    // 13. Blocked Drink-IT field "Inventory Unit of Measure" while assigning temporary WarehouseEntryTMP."Reason Code" in trigger OnAfterGetRecord() of dataset > dataitem(Location) > dataitem(Item) > dataitem("Warehouse Entry").
    // 14. Blocked Drink-IT field "Volume Unit of Measure Code" while assigning temporary WarehouseEntryTMP2."Qty. per Unit of Measure" in trigger OnAfterGetRecord() of dataset > dataitem(Location) > dataitem(Item) > dataitem("Warehouse Entry").
    // 15. Blocked Drink-IT field "Inventory Unit of Measure" while calculating Quantity_IOUM in trigger OnAfterGetRecord() of dataset > dataitem(Location) > dataitem(Item).
    // 16. Blocked Drink-IT field "Volume Unit of Measure Code" while calculating QuantityHL in trigger OnAfterGetRecord() of dataset > dataitem(Location) > dataitem(Item).
    // 17. Blocked Drink-IT field "Strength Spec. Code" in trigger OnPreDataItem() of dataset > dataitem(Location) > dataitem(Item).
    // 18. Fixed OnLookup signature to trigger OnLookup(var Text: Text): Boolean; in request page field LocationFilter.
    // 19. Fixed OnLookup signature to trigger OnLookup(var Text: Text): Boolean; in request page field ZoneFilter.
    // 20. Fixed OnLookup signature to trigger OnLookup(var Text: Text): Boolean; in request page field BinFilter.
    // 21. Fixed OnLookup signature to trigger OnLookup(var Text: Text): Boolean; in request page field LotFiltering.
    // 22. Resolved ambiguous page reference by replacing LocationList: Page "Location List"; with LocationList: Page 15; in var section.
    // 23. Blocked entire procedure InitAutoEmailOnWarningThreshold() because 2C objects is used inside this procedure.
    // 24. Replaced on-prem only ExcelBuf.CreateBookAndOpenExcel with SaaS-compatible Excel handling in procedure CreateExcelbook().
    //BC UPGRADE SHIKHD02 <<
    //*************************************************************************************************************************************************************

    //#FDD PID- 201, FDD DtW 015, IBM GAP DtW 21)-item Availability by Quality Report  PATHAA02 30.03.26 >>
    //** Aptean dependency("Aptean Beverage Foundation Management for Drink-IT Edition" to be added to unlock "Unit of Volume HL" field from DITFoundation Extension.
    //"Volume Unit of Measure Code" field is replaced with "Unit Volume HL"; Usage category added to show on search
    //Quantity_IUoM--> As "Inventory Unit of Measure" is no more DIT and now IBM field, uncomented the code to show in report column
    // Added ApplicationArea and UsageCategory-PATHAA02

    DefaultLayout = RDLC;
    RDLCLayout = './Item Availability by Quality-N.rdl';
    Caption = 'Item Availability by Quality-Excel';
    Permissions = TableData "Item Ledger Entry" = rm,
                  TableData "Warehouse Entry" = rm;
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            column(ReportTitle; ReportTitle)
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(LocationFilterCp; Text002)
            {
            }
            column(ItemCategoryFilterCp; Text003)
            {
            }
            column(ItemNoFilterCp; Text004)
            {
            }
            column(ZoneFilterCp; Text005)
            {
            }
            column(BinFilterCp; Text006)
            {
            }
            column(LotNoFilterCp; Text007)
            {
            }
            column(QualityStatusFilterCp; Text008)
            {
            }
            column(RemShelfLifeDaysCp; Text009)
            {
            }
            column(RegisteringDateFilterCp; Text011)
            {
            }
            column(ExpirationDateFilterCp; Text012)
            {
            }
            column(LocationFilter; LocationFilter)
            {
            }
            column(ItemCategoryTypology; ItemCategoryFilter)
            {
            }
            column(ItemNoGetfilter; Item.GETFILTER("No."))
            {
            }
            column(ZoneFilter; ZoneFilter)
            {
            }
            column(BinFilter; BinFilter)
            {
            }
            column(LotFiltering; LotFiltering)
            {
            }
            column(QualityFltr; QualityFilter)
            {
            }
            column(RegisteringDateFilter; Item.GETFILTER("Date Filter"))
            {
            }
            column(ExpirationDateFilter; "Warehouse Entry".GETFILTER("Expiration Date"))
            {
            }
        }
        dataitem(Location; Location)
        {
            DataItemTableView = SORTING(Code) ORDER(Ascending);
            column(LocationDescrp; Code + ' : ' + Name + ' ' + "Name 2")
            {
            }
            column(WarningThresholdDaysFlag; STRSUBSTNO(Text010, FIELDCAPTION("Warning Threshold Days FND")) + FORMAT("Warning Threshold Days FND"))
            {
            }
            column(WarningThresholdDays; "Warning Threshold Days FND")
            {
            }
            dataitem(Item; Item)
            {
                RequestFilterFields = "No.", "Item Category Code", "Date Filter";
                column(ItemCode; "No.")
                {
                }
                column(ItemDescription_itm; Description)
                {
                }
                column(UOM; "Inventory Unit of Measure FND") //PATHAA02
                {
                }

                column(ItemCatCode; "Item Category Code")
                {
                }
                column(DimValueCode1; DimValueCode1)
                {
                }
                column(DimValName1; DimValName1)
                {
                }
                column(BOUM; "Base Unit of Measure")
                {
                }
                column(SKUUnitCost; SKUUnitCost)
                {
                }
                dataitem("Warehouse Entry"; "Warehouse Entry")
                {
                    DataItemLink = "Item No." = FIELD("No.");
                    // BC UPGRADE SHIKHD02 >>
                    // Removed empty DataItemTableView assignment 
                    // DataItemTableView = '';
                    // BC UPGRADE SHIKHD02 <<
                    RequestFilterFields = "Expiration Date";
                    column(WeLocation; "Location Code")
                    {
                    }
                    column(WEZone; "Zone Code")
                    {
                    }
                    column(WEBin; "Bin Code")
                    {
                    }
                    column(WeLot; "Lot No.")
                    {
                    }
                    column(WEQuantityBase; "Qty. (Base)")
                    {
                    }
                    column(WeQualityStatus; "Inspection Status FND") //Bc Upgrade PATHAA02 GAP014_DTW, IBM GAP DTW 43
                    {
                    }
                    column(WEExpiration; "Expiration Date")
                    {
                    }
                    column(WeBinMovementStatus; WeBinMovementStatus)
                    {
                    }
                    column(RemShelfLifeDays; RemShelfLifeDays)
                    {
                    }
                    column(RemShelfLifeDaysValue; RemShelfLifeDaysValue)
                    {
                    }
                    column(SystemDate; FORMAT(TODAY))
                    {
                    }
                    column(BinMovementStatus; BinMovementStatus_1)
                    {
                    }
                    column(StrengthSpecValueactual; StrengthSpecValueactual)
                    {
                    }
                    column(QtyIUOM; QtyIUOM)
                    {
                    }
                    column(QtyVUOM; QtyVUOM)
                    {
                    }
                    column(PostingdatePurchOut; PostingdatePurchOut)
                    {
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(Quantity_IOUM; Quantity_IOUM)
                        {
                        }
                        column(QuantityBased; QuantityBased)
                        {
                        }
                        column(QuantityHL; QuantityHL)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            //HEI.02>>
                            if ApplyWarningThreshold then begin
                                // BC Upgrade SHUKLP03 >> Blocked because DrinkIT field "Inventory Unit of Measure" is used.
                                //PATHAA02 30.03.26>>
                                if ItemUnitofMeasure.GET(Item."No.", Item."Inventory Unit of Measure FND") then
                                    Quantity_IOUM := QuantityBased / ItemUnitofMeasure."Qty. per Unit of Measure";
                                //PATHAA02 30.03.26<<

                                CLEAR(ItemUnitofMeasure);
                                //if ItemUnitofMeasure.GET(Item."No.", InventorySetup."Volume Unit of Measure Code") then 
                                //    QuantityHL := QuantityBased / ItemUnitofMeasure."Qty. per Unit of Measure";
                                // BC Upgrade SHUKLP03 << Blocked because DrinkIT field "Volume Unit of Measure Code", "Inventory Unit of Measure" is used.
                                //PATHAA02  30.03.26>>
                                IF ItemUnitofMeasure.GET(Item."No.", DITFoundation."Unit Volume UOM") then
                                    QuantityHL := QuantityBased / ItemUnitofMeasure."Qty. per Unit of Measure";
                                //PATHAA02 30.03.26<<
                            end;
                            //HEI.02<<
                        end;
                    }

                    trigger OnAfterGetRecord();
                    var
                        lRecBinContent: Record "Bin Content";
                        LotNoInfo: Record "Lot No. Information";
                        ItemLedgerEntry: Record "Item Ledger Entry";
                        ILEEntryType: Option Purchase,Output;
                    begin
                        //HEI.09>>
                        CLEAR(RemShelfLifeDays);
                        CLEAR(RemShelfLifeDaysValue);
                        if "Expiration Date" <> 0D then begin
                            RemShelfLifeDays := ("Expiration Date" - TODAY);
                            RemShelfLifeDaysValue := FORMAT(RemShelfLifeDays);
                        end else
                            RemShelfLifeDaysValue := '';
                        //HEI.09<<

                        //HEI.08>>
                        CLEAR(WeBinMovementStatus);
                        if lRecBinContent.GET("Location Code", "Bin Code", "Item No.", "Variant Code", "Unit of Measure Code") then
                            if lRecBinContent."Block Movement" > 0 then
                                WeBinMovementStatus := Text001;

                        QuantityBased += "Qty. (Base)";
                        if BinContent.GET("Location Code", "Bin Code", "Item No.", "Variant Code", "Unit of Measure Code") then
                            BinMovementStatus_1 += BinContent."Block Movement";
                        //HEI.05<<

                        //HEI.10>>

                        //HEI.05>>
                        CLEAR(StrengthSpecValueactual);
                        ILE.RESET;
                        ILE.SETRANGE("Item No.", "Item No.");
                        ILE.SETRANGE("Lot No.", "Lot No.");
                        if ILE.FINDLAST then begin
                            // BC UPGRADE SHIKHD02 >>
                            //  Blocked Drink-IT field "Strength Spec. Value"
                            //  ILE.CALCFIELDS("Strength Spec. Value");
                            //  StrengthSpecValueactual  := ILE."Strength Spec. Value";
                            // BC UPGRADE SHIKHD02 <<
                        end;

                        CLEAR(PostingdatePurchOut);
                        ILE1.RESET;
                        ILE1.SETRANGE("Item No.", "Item No.");
                        ILE1.SETRANGE("Lot No.", "Lot No.");
                        if ILE1.FINDFIRST then
                            PostingdatePurchOut := ILE1."Posting Date";
                        //HEI.05>>

                        //HEI.10<<

                        //HEI.08>>
                        // BC UPGRADE PATHAA02 >>                     
                        if ItemUnitofMeasure.GET(Item."No.", Item."Inventory Unit of Measure FND") then
                            QtyIUOM := "Warehouse Entry"."Qty. (Base)" / ItemUnitofMeasure."Qty. per Unit of Measure";
                        // BC UPGRADE PATHAA02 <<

                        // BC UPGRADE SHIKHD02 >>
                        // Blocked because DrinkIT field "Volume Unit of Measure Code" 
                        // if ItemUnitofMeasure.GET(Item."No.", InventorySetup."Volume Unit of Measure Code") then
                        //     QtyVUOM := "Warehouse Entry"."Qty. (Base)" / ItemUnitofMeasure."Qty. per Unit of Measure";
                        // BC UPGRADE SHIKHD02 <<
                        //PATHAA02>>
                        IF ItemUnitofMeasure.GET(Item."No.", DITFoundation."Unit Volume UOM") then
                            QtyVUOM := "Warehouse Entry"."Qty. (Base)" / ItemUnitofMeasure."Qty. per Unit of Measure";
                        //PATHAA02<<

                        //HEI.08<<


                        //HEI.09>>
                        /*
                        //HEi.08<<
                        IF PrintToExcel THEN
                         MakeExcelDataBody;
                        //HEi.08>>
                        */
                        //HEI.09<<

                        //HEI.09>>
                        if "Qty. (Base)" <> 0 then begin
                            QtyIUOM := 0;
                            QtyVUOM := 0;
                            WarehouseEntryTMP.RESET;
                            WarehouseEntryTMP.SETRANGE("Item No.", Item."No.");
                            WarehouseEntryTMP.SETRANGE("Location Code", "Location Code");
                            WarehouseEntryTMP.SETRANGE("Zone Code", "Zone Code");
                            WarehouseEntryTMP.SETRANGE("Bin Code", "Bin Code");
                            WarehouseEntryTMP.SETRANGE("Lot No.", "Lot No.");
                            if WarehouseEntryTMP.FINDFIRST then begin
                                // BC UPGRADE PATHAA02 >>
                                if ItemUnitofMeasure.GET(Item."No.", Item."Inventory Unit of Measure FND") then
                                    QtyIUOM := "Warehouse Entry"."Qty. (Base)" / ItemUnitofMeasure."Qty. per Unit of Measure";
                                // BC UPGRADE PATHAA02 <<
                                WarehouseEntryTMP."Qty. per Unit of Measure" += QtyIUOM;

                                WarehouseEntryTMP."Qty. (Base)" += "Warehouse Entry"."Qty. (Base)";
                                WarehouseEntryTMP.Weight += "Warehouse Entry"."Qty. (Base)" * SKUUnitCost;

                                //PATHAA02>>
                                IF ItemUnitofMeasure.GET(Item."No.", DITFoundation."Unit Volume UOM") then
                                    QtyVUOM := "Warehouse Entry"."Qty. (Base)" / ItemUnitofMeasure."Qty. per Unit of Measure";
                                //PATHAA02<<
                                if WarehouseEntryTMP2.GET(WarehouseEntryTMP."Entry No.") then begin
                                    WarehouseEntryTMP2."Qty. per Unit of Measure" += QtyVUOM;
                                    WarehouseEntryTMP2.MODIFY;
                                end;

                                WarehouseEntryTMP.MODIFY;
                            end
                            else begin
                                WarehouseEntryTMP."Entry No." := WarehouseEntryTMPEntryno;
                                WarehouseEntryTMP."Location Code" := "Warehouse Entry"."Location Code";
                                WarehouseEntryTMP."Source No." := Item."Item Category Code";
                                WarehouseEntryTMP."Whse. Document No." := DimValueCode1;
                                WarehouseEntryTMP.Description := DimValName1;
                                WarehouseEntryTMP."Item No." := Item."No.";

                                WarehouseEntryTMP2."Entry No." := WarehouseEntryTMP."Entry No.";
                                WarehouseEntryTMP2.Description := Item.Description;

                                // BC UPGRADE PATHAA02 >>                                
                                if ItemUnitofMeasure.GET(Item."No.", Item."Inventory Unit of Measure FND") then
                                    QtyIUOM := "Warehouse Entry"."Qty. (Base)" / ItemUnitofMeasure."Qty. per Unit of Measure";
                                // BC UPGRADE PATHAA02 <<
                                WarehouseEntryTMP."Qty. per Unit of Measure" := QtyIUOM;

                                // BC UPGRADE PATHAA02 >>                              
                                WarehouseEntryTMP."Reason Code" := Item."Inventory Unit of Measure FND";
                                // BC UPGRADE PATHAA02 <<
                                WarehouseEntryTMP."Qty. (Base)" := "Warehouse Entry"."Qty. (Base)";
                                WarehouseEntryTMP."Variant Code" := Item."Base Unit of Measure";
                                WarehouseEntryTMP.Cubage := SKUUnitCost;
                                WarehouseEntryTMP.Weight := "Warehouse Entry"."Qty. (Base)" * SKUUnitCost;//bbb
                                WarehouseEntryTMP."Lot No." := "Warehouse Entry"."Lot No.";
                                WarehouseEntryTMP.Quantity := StrengthSpecValueactual;
                                WarehouseEntryTMP."Warranty Date" := PostingdatePurchOut;
                                WarehouseEntryTMP."Zone Code" := "Warehouse Entry"."Zone Code";
                                WarehouseEntryTMP."Bin Code" := "Warehouse Entry"."Bin Code";

                                // BC UPGRADE PATHAA02>>
                                // Blocked Drink-IT field "Volume Unit of Measure Code"
                                // if ItemUnitofMeasure.GET(Item."No.", InventorySetup."Volume Unit of Measure Code") then
                                //     QtyVUOM := "Warehouse Entry"."Qty. (Base)" / ItemUnitofMeasure."Qty. per Unit of Measure";

                                IF ItemUnitofMeasure.GET(Item."No.", DITFoundation."Unit Volume UOM") then
                                    QtyVUOM := "Warehouse Entry"."Qty. (Base)" / ItemUnitofMeasure."Qty. per Unit of Measure";
                                // BC UPGRADE PATHAA02 <<
                                WarehouseEntryTMP2."Qty. per Unit of Measure" := QtyVUOM;

                                WarehouseEntryTMP."Inspection Status FND" := "Warehouse Entry"."Inspection Status FND";
                                WarehouseEntryTMP."Expiration Date" := "Warehouse Entry"."Expiration Date";
                                WarehouseEntryTMP."No. Series" := RemShelfLifeDaysValue;

                                WarehouseEntryTMP.INSERT;
                                WarehouseEntryTMP2.INSERT;

                                WarehouseEntryTMPEntryno += 1;
                            end;
                        end;
                        //HEI.09<<
                    end;

                    trigger OnPreDataItem();
                    begin
                        "Warehouse Entry".SETCURRENTKEY("Location Code", "Item No.", "Variant Code", "Zone Code", "Bin Code", "Lot No.");
                        //HEI.02>>
                        //"Warehouse Entry".SETFILTER("Warehouse Entry"."Location Code", Item.GETFILTER(Item."Location Filter"));
                        "Warehouse Entry".SETRANGE("Location Code", Location.Code);
                        //HEI.02<<
                        "Warehouse Entry".SETRANGE("Item No.", Item."No.");
                        "Warehouse Entry".SETFILTER("Zone Code", ZoneFilter);
                        "Warehouse Entry".SETFILTER("Bin Code", BinFilter);
                        "Warehouse Entry".SETFILTER("Lot No.", LotFiltering);
                        //HEI.02>>
                        //"Warehouse Entry".SETFILTER("Registering Date",FORMAT(Item."Date Filter"));
                        SETFILTER("Registering Date", Item.GETFILTER("Date Filter"));
                        //HEI.02<<
                        "Warehouse Entry".SETFILTER("Inspection Status FND", FORMAT(QualityFilter));
                        //HEI.02>>
                        SETFILTER("Expiration Date", GETFILTER("Expiration Date"));
                        //HEI.02<<
                        CLEAR(QtyIUOM);//HEI.08
                        CLEAR(QtyVUOM);//HEI.08
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    CLEAR(QuantityBased);
                    CLEAR(Quantity_IOUM);
                    CLEAR(QuantityHL);
                    CLEAR(QtyIUOM);//HEI.08
                    CLEAR(QtyVUOM);//HEI.08
                    CLEAR(BinMovementStatus_1);
                    //HEI.02>>
                    CLEAR(RemShelfLifeDays);
                    CLEAR(RemShelfLifeDaysValue);
                    if not ApplyWarningThreshold then begin // >>HEI.03 // HEI.04fce
                                                            //HEI.02<<
                        CalcWEBased(Item."No.", QuantityBased, BinMovementStatus_1);
                        if QuantityBased = 0 then
                            CurrReport.SKIP;
                        //PATHAA02 30.03.26>>                       
                        if ItemUnitofMeasure.GET(Item."No.", Item."Inventory Unit of Measure FND") then
                            Quantity_IOUM := QuantityBased / ItemUnitofMeasure."Qty. per Unit of Measure";
                        //PATHAA02 30.03.26<<

                        //HEI.02>>
                        CLEAR(ItemUnitofMeasure);
                        //HEI.02<<
                        //PATHAA02  30.03.26>>
                        IF ItemUnitofMeasure.GET(Item."No.", DITFoundation."Unit Volume UOM") then
                            QuantityHL := QuantityBased / ItemUnitofMeasure."Qty. per Unit of Measure";
                        //PATHAA02 30.03.26<<
                        //HEI.02>>
                    end; // <<HEI.03 // HEI0.4
                    //HEI.02<<

                    //HEI.05>>
                    CLEAR(DimValueCode1);
                    CLEAR(DimValName1);

                    if DefaulltDimension.GET(DATABASE::Item, Item."No.", 'CMG') then
                        DimValueCode1 := DefaulltDimension."Dimension Value Code";

                    if DimensionValue.GET('CMG', DimValueCode1) then
                        DimValName1 := DimensionValue.Name;

                    //HEI.05<<

                    //HEI.09>>
                    SKUUnitCost := 0;
                    StockkeepingUnit.RESET;
                    StockkeepingUnit.SETRANGE("Location Code", Location.Code);
                    StockkeepingUnit.SETRANGE("Item No.", "No.");
                    if StockkeepingUnit.FINDFIRST then
                        SKUUnitCost := StockkeepingUnit."Unit Cost";
                    //HEI.09<<
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.02>>
                    SETRANGE("Location Filter", Location.Code);
                    SETFILTER("Item Category Code", ItemCategoryFilter);
                    //HEI.02<<
                    // BC UPGRADE SHIKHD02 >>
                    // Blocked because DrinkIT field "Strength Spec. Code"
                    //HEI.05>>
                    // if ExtraRelevantFilter then
                    //     SETFILTER(Item."Strength Spec. Code", '%1', 'EXT.[%w/w]');
                    //HEI.05<<
                    // BC UPGRADE SHIKHD02 <<
                end;
            }

            trigger OnPreDataItem();
            begin
                //HEI.02>>
                SETFILTER(Code, LocationFilter);
                //HEI.02<<
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
                        Caption = 'Location Code Filter';
                        ApplicationArea = All;

                        // BC UPGRADE SHIKHD02 >>
                        // Fixed OnLookup signature by passing Text as var
                        // trigger OnLookup(Text: Text): Boolean;
                        trigger OnLookup(var Text: Text): Boolean;
                        // BC UPGRADE SHIKHD02 <<
                        var
                            Location: Record Location;
                        begin
                            CLEAR(LocationList);
                            CLEAR(Text);
                            LocationList.LOOKUPMODE := true;
                            if LocationList.RUNMODAL = ACTION::LookupOK then begin
                                if Text <> '' then
                                    Text := Text + '|';
                                Text := Text + LocationList.GetSelectionFilter;
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
                        Caption = 'Zone Code Filter';
                        ApplicationArea = All;
                        // BC UPGRADE SHIKHD02 >>
                        // Fixed OnLookup signature by passing Text as var
                        // trigger OnLookup(Text: Text): Boolean;
                        trigger OnLookup(var Text: Text): Boolean;
                        // BC UPGRADE SHIKHD02 <<
                        var
                            zone: Record Zone;
                        begin
                            if LocationFilter <> '' then begin
                                CLEAR(ZoneList);
                                zone.RESET;
                                zone.SETFILTER(zone."Location Code", LocationFilter);
                                ZoneList.SETTABLEVIEW(zone);
                                ZoneList.LOOKUPMODE := true;
                                if ZoneList.RUNMODAL = ACTION::LookupOK then begin
                                    Text := ZoneList.GetSelectionFilter;
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
                        Caption = 'Bin Code Filter';
                        ApplicationArea = All;

                        // BC UPGRADE SHIKHD02 >>
                        // Fixed OnLookup signature by passing Text as var
                        // trigger OnLookup(Text: Text): Boolean;
                        trigger OnLookup(var Text: Text): Boolean;
                        // BC UPGRADE SHIKHD02 <<
                        var
                            Bin: Record Bin;
                        begin
                            CLEAR(BinFilter);
                            CLEAR(BinList);
                            if (ZoneFilter <> '') or (LocationFilter <> '') then begin
                                Bin.RESET;
                                Bin.SETFILTER(Bin."Zone Code", ZoneFilter);
                                Bin.SETFILTER(Bin."Location Code", LocationFilter);

                                BinList.SETTABLEVIEW(Bin);

                                BinList.LOOKUPMODE := true;
                                if BinList.RUNMODAL = ACTION::LookupOK then begin
                                    Text := BinList.GetSelectionFilter;
                                    BinFilter := Text;
                                end;
                            end;
                            CLEAR(BinList);
                        end;
                    }
                    field(LotFiltering; LotFiltering)
                    {
                        Caption = 'Lot No. Filter';
                        ApplicationArea = All;

                        // BC UPGRADE SHIKHD02 >>
                        // Fixed OnLookup signature by passing Text as var
                        // trigger OnLookup(Text: Text): Boolean;
                        trigger OnLookup(var Text: Text): Boolean;
                        // BC UPGRADE SHIKHD02 <<
                        var
                            LotNumberInfoRec: Record "Lot No. Information";
                        begin
                            LotNumberInfoRec.SETFILTER(LotNumberInfoRec."Item No.", Item.GETFILTER(Item."No."));

                            /*lotNumberList.SETTABLEVIEW(LotNumberInfoRec);
                            lotNumberList.LOOKUPMODE(TRUE);
                            IF lotNumberList.RUNMODAL=ACTION::LookupOK THEN
                            
                            */
                            if PAGE.RUNMODAL(0, LotNumberInfoRec) = ACTION::LookupOK then
                                LotFiltering := LotNumberInfoRec."Lot No.";

                        end;
                    }
                    field(QualityFilter; QualityFilter)
                    {
                        Caption = 'Quality Status Filter';
                        ApplicationArea = All;
                    }
                    field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print to Excel';
                        Editable = true;
                        Visible = true;
                        ApplicationArea = All;

                        trigger OnValidate();
                        begin
                            //PrintToExcel :=TRUE;
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
        lblQuantity = 'Quantity'; lblQuantityHL = 'Quantity HL'; lblExpiryDate = 'Expiry Date'; lblQuantityBase = 'Quantity (Base)'; lbItemNoCpt = 'Item Number'; lbItemDescriptionCpt = 'Description'; lbLotNoCpt = 'Lot Number'; lbQualityStatusCpt = 'Quality Status'; lbCode = 'Code'; lbZOne = 'Zone Code'; lbBin = 'Bin Code'; lbUoM = 'UOM'; lbLocation = 'Location'; lblPage = 'Page'; lbBinBlocked = 'Partially Blocked'; lblItemCatCode = 'Item Cat. Code'; lblCMGCode = 'CMG Code'; lblCMGDesc = 'CMG Description'; lblExtRelevant = 'Extract Relevant'; lblExtCont = 'Extra Content [%w/w]'; lblDateReceipt = 'Date of Receipt/Production';
    }

    trigger OnPostReport();
    begin
        //HEI.09>>
        if PrintToExcel then
            MakeExcelDataBody;
        //HEI.09<<

        //HEi.08<<
        if PrintToExcel then
            CreateExcelbook;
        //HEi.08>>
    end;

    trigger OnPreReport();
    begin
        //HEI.09>>
        WarehouseEntryTMPEntryno := 1;
        //HEI.09<<

        InventorySetup.GET;
        //HEI.02>>
        CLEAR(ItemCategoryFilter);
        if ApplyWarningThreshold then begin
            if InventorySetup."Active Best Before Date FND" then begin
                if InventorySetup."Item Category Typology FND" <> '' then
                    ItemCategoryFilter := InventorySetup."Item Category Typology FND";
            end;
        end else begin
            if Item.GETFILTER("Item Category Code") <> '' then
                ItemCategoryFilter := Item.GETFILTER("Item Category Code");
        end;
        //HEI.02<<

        //HEI.08>>
        if PrintToExcel then
            MakeExcelInfo;
        //HEI.08<<
        DITFoundation.Get();//BC upgrade Pathaa02 // Bug fix Qty HL 
    end;

    var
        ReportTitle: Label 'Item Availability by Quality';
        LocationCodeCpt: Label 'Location Code';
        ItemNoCpt: Label 'Item No.';
        ItemDescriptionCpt: Label 'Item Description';
        UnitOfMeasureCpt: Label 'UOM';
        LotNoCpt: Label 'Lot No.';
        QualityStatusCpt: Label 'Quality Status';
        ZoneCpt: Label '"Zone "';
        BinCpt: Label 'Bin';
        QuantityCpt: Label 'Quantity';
        PageNoCpt: Label 'Page';
        LocationFilter: Code[250];
        ZoneFilter: Code[250];
        BinFilter: Code[250];
        QuantityHL: Decimal;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        Quantoty_IOUM: Decimal;
        UseAsInTransit: Boolean;
        // BC UPGRADE SHIKHD02 >>
        // Resolved ambiguous page reference by replacing page name with unique page ID
        // LocationList: Page "Location List";
        LocationList: Page 15;
        // BC UPGRADE SHIKHD02 <<
        BinList: Page "Bin List";
        ZoneList: Page "Zone List";
        InventorySetup: Record "Inventory Setup";
        ItmCode: Code[20];
        QualityStatusFilter: Option OnHold,Unrestricted,Blocked;
        QuantityBased: Decimal;
        LotFiltering: Code[100];
        Quantity_IOUM: Decimal;
        QualityFilter: Option " ","Quality Hold",Unrestricted,Blocked;
        lotNumberList: Page "Lot No. Information List";
        BinMovementStatus: Text;
        BinContent: Record "Bin Content";
        BinMovementStatus_1: Integer;
        WeBinMovementStatus: Text[30];
        Text001: Label 'BLOCKED';
        WeQualityStatus: Text[30];
        RemShelfLifeDays: Integer;
        RemShelfLifeDaysValue: Text[10];
        ApplyWarningThreshold: Boolean;
        UserSetup: Record "User Setup";
        Text002: Label '"Location Filter         : "';
        Text003: Label '"Item Category Filter : "';
        Text004: Label '"Item No. Filter         : "';
        Text005: Label '"Zone Filter     : "';
        Text006: Label '"Bin Filter       : "';
        Text007: Label '"Lot No. Filter : "';
        Text008: Label '"Quality Status Filter     : "';
        Text009: Label 'Rem. Shelf Life Days';
        Text010: Label '"%1 : "';
        ItemCategoryFilter: Code[250];
        Text011: Label '"Registering Date Filter : "';
        Text012: Label '"Expiration Date Filter   : "';
        StrengthSpecCode: Code[20];
        ExtraRelevantFilter: Boolean;
        ItemCatCode: Code[20];
        DefaulltDimension: Record "Default Dimension";
        DimValueCode1: Code[20];
        DimValName1: Text[50];
        DimensionValue: Record "Dimension Value";
        StrengthSpecValueactual: Decimal;
        ILE: Record "Item Ledger Entry";
        PostingdatePurchOut: Date;
        ILE1: Record "Item Ledger Entry";
        CMGFilter1: Code[20];
        CMGFilter: Code[20];
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        Text013: Label 'Item Availability by Quality';
        Text014: Label 'Company Name';
        Text015: Label 'Report No.';
        Text016: Label 'Report Name';
        Text017: Label 'User ID';
        Text018: Label 'Date';
        QtyIUOM: Decimal;
        QtyVUOM: Decimal;
        SKUUnitCost: Decimal;
        StockkeepingUnit: Record "Stockkeeping Unit";
        WarehouseEntryTMP: Record "Warehouse Entry" temporary;
        WarehouseEntryTMPEntryno: Integer;
        WarehouseEntryTMP2: Record "Warehouse Entry" temporary;
        DITFoundation: Record FoundationSetup101FDW;

    local procedure CalcWEBased(ItmCode: Code[20]; var WEQuantity: Decimal; var BinMovement: Integer);
    var
        WarehouseEntries: Record "Warehouse Entry";
    begin
        CLEAR(WEQuantity);
        WarehouseEntries.SETCURRENTKEY("Location Code", "Item No.", "Variant Code", "Zone Code", "Bin Code", "Lot No.");
        //HEI.02>>
        //WarehouseEntries.SETFILTER(WarehouseEntries."Location Code", Item.GETFILTER(Item."Location Filter"));
        WarehouseEntries.SETRANGE("Location Code", Location.Code);
        //HEI.02<<
        WarehouseEntries.SETRANGE(WarehouseEntries."Item No.", ItmCode);
        WarehouseEntries.SETFILTER(WarehouseEntries."Zone Code", ZoneFilter);
        WarehouseEntries.SETFILTER(WarehouseEntries."Bin Code", BinFilter);
        WarehouseEntries.SETFILTER(WarehouseEntries."Lot No.", LotFiltering);
        //HEI.02>>
        //WarehouseEntries.SETFILTER(WarehouseEntries."Registering Date", FORMAT(Item."Date Filter"));
        WarehouseEntries.SETFILTER("Registering Date", Item.GETFILTER("Date Filter"));
        //HEI.02<<
        WarehouseEntries.SETFILTER(WarehouseEntries."Inspection Status FND", FORMAT(QualityFilter));
        //HEI.02>>
        WarehouseEntries.SETFILTER("Expiration Date", "Warehouse Entry".GETFILTER("Expiration Date"));
        //HEI.02<<
        if WarehouseEntries.FINDSET then
            repeat
                WEQuantity += WarehouseEntries."Qty. (Base)";
                if BinContent.GET(WarehouseEntries."Location Code", WarehouseEntries."Bin Code", WarehouseEntries."Item No.", WarehouseEntries."Variant Code", WarehouseEntries."Unit of Measure Code") then
                    BinMovement += BinContent."Block Movement";
            until WarehouseEntries.NEXT = 0;
        exit;
    end;
    // BC UPGRADE SHIKHD02 >>
    // 2C objects code is blocked
    // procedure InitAutoEmailOnWarningThreshold(ApplyWT: Boolean; SendEmail: Boolean) EmailUsers: Text;
    // var
    //     "2CUserProfileL": Record "2C User Profile";
    //     "2CUserperUserProfileL": Record "2C User per User Profile";
    //     EmailUsersL: Text;
    //     "2CCompanyGroupL": Record "2C Company Group";
    //     "2CUserNameL": Text[100];
    // begin
    //     //HEI.02>>
    //     ApplyWarningThreshold := ApplyWT;
    //     if not SendEmail then
    //         exit
    //     else begin
    //         "2CUserProfileL".SETRANGE("E-mail for Item Availability", true);
    //         //HEI.06>>
    //         "2CUserProfileL".SETRANGE(Status, "2CUserProfileL".Status::Synchronized);
    //         //HEI.06<<
    //         if "2CUserProfileL".FINDSET then begin
    //             repeat
    //                 UserSetup.GET("2CUserProfileL".Responsible);
    //                 "2CUserperUserProfileL".RESET;
    //                 "2CUserperUserProfileL".SETRANGE("User Profile", "2CUserProfileL"."User Profile");
    //                 //HEI.06>>
    //                 "2CUserperUserProfileL".SETRANGE("User Profile Status", "2CUserperUserProfileL"."User Profile Status"::Synchronized);
    //                 "2CUserperUserProfileL".SETRANGE("Sync Status", "2CUserperUserProfileL"."Sync Status"::Synchronized);
    //                 //HEI.06<<
    //                 if "2CUserperUserProfileL".FINDSET then begin
    //                     repeat
    //                         //HEI.06>>
    //                         CLEAR("2CUserNameL");
    //                         if "2CUserperUserProfileL"."Company (Group)" <> '' then begin
    //                             if "2CUserperUserProfileL"."Company (Group)" = COMPANYNAME then begin
    //                                 "2CCompanyGroupL".RESET;
    //                                 "2CCompanyGroupL".SETRANGE(Type, "2CCompanyGroupL".Type::Company);
    //                                 "2CCompanyGroupL".SETRANGE("Company Group", COMPANYNAME);
    //                                 if "2CCompanyGroupL".FINDFIRST then
    //                                     "2CUserNameL" := "2CUserperUserProfileL"."User Name";
    //                             end;
    //                         end else
    //                             "2CUserNameL" := "2CUserperUserProfileL"."User Name";

    //                         //IF UserSetup.GET("2CUserperUserProfileL"."User Name") THEN BEGIN
    //                         if ("2CUserNameL" <> '') and UserSetup.GET("2CUserNameL") then begin
    //                             //HEI.06<<
    //                             if not UserSetup.MARK then begin
    //                                 if STRPOS(UserSetup."E-Mail", '@') > 0 then begin
    //                                     UserSetup.MARK(true);
    //                                     EmailUsersL += UserSetup."E-Mail" + '; ';
    //                                 end;
    //                             end;
    //                         end;
    //                     until "2CUserperUserProfileL".NEXT = 0;
    //                 end;
    //             until "2CUserProfileL".NEXT = 0;
    //         end;
    //         EmailUsers := DELCHR(EmailUsersL, '>', '; ');
    //     end;
    //     //HEI.02<<
    // end;
    // BC UPGRADE SHIKHD02 <<

    procedure MakeExcelInfo();
    begin
        //HEI.08>>
        //ExcelBuf.SetUseInfoSheet;
        /*ExcelBuf.AddInfoColumn(FORMAT(Text014),FALSE,TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        
        ExcelBuf.AddInfoColumn(FORMAT(Text016),FALSE,TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text013),FALSE,FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        
        ExcelBuf.AddInfoColumn(FORMAT(Text017),FALSE,TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID,FALSE,FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        
        ExcelBuf.AddInfoColumn(FORMAT(Text018),FALSE,TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY,FALSE,FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.NewRow;
        */
        //ExcelBuf.ClearNewRow;

        MakeExcelDataHeader;
        //HEI.08<<

    end;

    local procedure MakeExcelDataHeader();
    begin
        //HEI.08>>
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Location', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Item Category Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('CMG Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);  //SIR
        ExcelBuf.AddColumn('CMG Description', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text); //SIR
        ExcelBuf.AddColumn('Item Number', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Item Description', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Quantity Inv UoM', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('UOM', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Quantity (Base)', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        //HEI.09>>
        ExcelBuf.AddColumn('UOM Base', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Stock Keeping Unit Cost', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Value', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        //HEI.09<<
        ExcelBuf.AddColumn('Lot No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Extra Content[%w/w]', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Date of Receipt/Production', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Zone Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Bin code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Quantity HL', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Quality Status', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Expiry Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Rem. Shelf Life Days', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        //HEI.08<<
    end;

    procedure MakeExcelDataBody();
    begin
        WarehouseEntryTMP.RESET;
        if WarehouseEntryTMP.FINDFIRST then
            repeat
                if WarehouseEntryTMP."Qty. (Base)" <> 0 then begin
                    WarehouseEntryTMP2.RESET;
                    if WarehouseEntryTMP2.GET(WarehouseEntryTMP."Entry No.") then;

                    ExcelBuf.NewRow;//aaa
                    ExcelBuf.AddColumn(WarehouseEntryTMP."Location Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(WarehouseEntryTMP."Source No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(WarehouseEntryTMP."Whse. Document No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(WarehouseEntryTMP.Description, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(WarehouseEntryTMP."Item No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(WarehouseEntryTMP2.Description, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(WarehouseEntryTMP."Qty. per Unit of Measure", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);

                    ExcelBuf.AddColumn(WarehouseEntryTMP."Reason Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(WarehouseEntryTMP."Qty. (Base)", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);

                    ExcelBuf.AddColumn(WarehouseEntryTMP."Variant Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(WarehouseEntryTMP.Cubage, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(WarehouseEntryTMP.Weight, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);

                    ExcelBuf.AddColumn(WarehouseEntryTMP."Lot No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(WarehouseEntryTMP.Quantity, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(WarehouseEntryTMP."Warranty Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Date);
                    ExcelBuf.AddColumn(WarehouseEntryTMP."Zone Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(WarehouseEntryTMP."Bin Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

                    ExcelBuf.AddColumn(WarehouseEntryTMP2."Qty. per Unit of Measure", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(WarehouseEntryTMP."Inspection Status FND", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); //BC Upgrade PATHAA02
                    ExcelBuf.AddColumn(WarehouseEntryTMP."Expiration Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(WarehouseEntryTMP."No. Series", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                end;
            until WarehouseEntryTMP.NEXT = 0;
        //HEI.09<<

    end;

    procedure CreateExcelbook();
    begin
        //HEi.08<<
        // BC UPGRADE SHIKHD02 >>
        // Blocked CreateBookAndOpenExcel because only for On-prem and modified code as per SaaS
        //ExcelBuf.CreateBookAndOpenExcel('', Text002, '', COMPANYNAME, USERID);
        ExcelBuf.CreateNewBook(Text002);
        ExcelBuf.WriteSheet('', CompanyName, UserId);
        ExcelBuf.SetFriendlyFilename('ItemAvailabilityByQuality_' + Format(TODAY) + '_' + UserId);//PATHAA02
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
        // BC UPGRADE SHIKHD02 <<
        //ExcelBuf.SaveExcel('',FORMAT(USERID)+FORMAT(WORKDATE));
        ERROR('');
        //HEi.08>>
    end;
}
