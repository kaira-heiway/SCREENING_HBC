page 51074 "BinContentAnalysisReportCBN"
{
    // version NAVW110.0,DITW110.00.09,HEI.01

    // HEI.01 HT1615 BULIMC01 IBM 21.10.2020 #new page created
    // HEI.02 CHG2112762 INC3414257 BASAKB01 IBM 15.04.2021

    CaptionML = ENU = 'Bin Content Analysis Report',
                FRA = 'Contenu emplacement';
    InsertAllowed = false;
    PageType = List;
    SaveValues = true;
    SourceTable = "Bin Content";
    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
    UsageCategory = Lists; // BC Upgrade SHUKLP03 <<


    layout
    {

        area(content)
        {
            group(Filters)
            {
                CaptionML = ENU = 'Filters',
                            FRA = 'Options';
                field(LocationCode; LocationCode)
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    CaptionML = ENU = 'Location Filter',
                                FRA = 'Filtre magasin';
                    ToolTip = 'Specifies the value of the LocationCode field.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Location.RESET();
                        Location.SETRANGE("Bin Mandatory", true);
                        if LocationCode <> '' then
                            Location.Code := LocationCode;
                        if PAGE.RUNMODAL(PAGE::"Locations with Warehouse List", Location) = ACTION::LookupOK then begin
                            Location.TESTFIELD("Bin Mandatory", true);
                            LocationCode := Location.Code;
                            DefFilter();
                        end;
                        CurrPage.UPDATE(true);
                    end;

                    trigger OnValidate();
                    begin
                        ZoneCode := '';
                        if LocationCode <> '' then begin
                            if WMSMgt.LocationIsAllowed(LocationCode) then begin
                                Location.GET(LocationCode);
                                Location.TESTFIELD("Bin Mandatory", true);
                            end else
                                ERROR(Text000, USERID);
                        end;
                        DefFilter();
                        LocationCodeOnAfterValidate();
                    end;
                }

                field("<StartingDate>"; StartDate)
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Caption = 'Opening Date';
                    ToolTip = 'Specifies the value of the Opening Date field.';

                    trigger OnValidate();
                    begin
                        Rec.SETRANGE("Date Filter FND", StartDate, EndDate);
                        CurrPage.UPDATE(true);
                    end;
                }
                field(ZoneCode; ZoneCode)
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    CaptionML = ENU = 'Zone Filter',
                                FRA = 'Filtre zone';
                    ToolTip = 'Specifies the value of the ZoneCode field.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Zone.RESET();
                        if ZoneCode <> '' then
                            Zone.Code := ZoneCode;
                        if LocationCode <> '' then
                            Zone.SETRANGE("Location Code", LocationCode);
                        if PAGE.RUNMODAL(0, Zone) = ACTION::LookupOK then begin
                            ZoneCode := Zone.Code;
                            LocationCode := Zone."Location Code";
                            DefFilter();
                        end;
                        CurrPage.UPDATE(true);
                    end;

                    trigger OnValidate();
                    begin
                        DefFilter();
                        ZoneCodeOnAfterValidate();
                    end;
                }
                field("<EndingDate>"; EndDate)
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Caption = 'Closing Date';
                    ToolTip = 'Specifies the value of the Closing Date field.';

                    trigger OnValidate();
                    begin
                        Rec.SETRANGE("Date Filter FND", StartDate, EndDate);
                        CurrPage.UPDATE(true);
                    end;
                }
            }
            repeater(Control37)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the location code of the bin.',
                                FRA = 'Spécifie le code du magasin de l''emplacement.';
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies the zone code of the bin.',
                                FRA = 'Spécifie le code de la zone de l''emplacement.';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the bin code.',
                                FRA = 'Spécifie le code de l''emplacement.';

                    trigger OnValidate();
                    begin
                        CheckQty();
                    end;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the number of the item that will be stored in the bin.',
                                FRA = 'Spécifie le numéro de l''article à stocker dans cet emplacement.';

                    trigger OnValidate();
                    begin
                        CheckQty();
                    end;
                }
                field("Item Description"; Rec."Item Description FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Description field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Item Description field.';

                }
                field("Item Category Code"; Rec."Item Category Code FND")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Editable = false;
                    ToolTip = 'Specifies the value of the Item Category Code field.';
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inventory Posting Group field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Inventory Posting Group field.';

                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies the variant code for the item in the bin.',
                                FRA = 'Spécifie le code variante pour l''article dans l''emplacement.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        CheckQty();
                    end;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the unit of measure code of the item in the bin.',
                                FRA = 'Spécifie le code unité de l''article dans l''emplacement.';
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies the number of base units of measure that are in the unit of measure specified for the item in the bin.',
                                FRA = 'Spécifie le nombre d''unités de base qui se trouvent dans l''unité spécifiée pour l''article dans l''emplacement.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        CheckQty();
                    end;
                }
                field(Default; Rec.Default)
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies if the bin is the default bin for the associated item.',
                                FRA = 'Indique si l''emplacement correspond à l''emplacement par défaut de l''article associé.';
                    Visible = false;
                }
                field(Dedicated; Rec.Dedicated)
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies if the bin is used as a dedicated bin, which means that its bin content is available only to certain resources.',
                                FRA = 'Indique si l''emplacement est utilisé comme emplacement dédié, ce qui signifie que son contenu est uniquement disponible à certaines ressources.';
                    Visible = false;
                }
                field("Warehouse Class Code"; Rec."Warehouse Class Code")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies the warehouse class code. Only items with the same warehouse class can be stored in this bin.',
                                FRA = 'Spécifie le code classe de l''entrepôt. Seuls les articles ayant la même classe entrepôt peuvent être triés dans cet emplacement.';
                    Visible = false;
                }
                field("Bin Type Code"; Rec."Bin Type Code")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies the code of the bin type that was selected for this bin.',
                                FRA = 'Spécifie le code du type emplacement choisi pour cet emplacement.';
                    Visible = false;
                }
                field("Bin Ranking"; Rec."Bin Ranking")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies the bin ranking.',
                                FRA = 'Spécifie le niveau de priorité de l''emplacement.';
                    Visible = false;
                }
                field("Block Movement"; Rec."Block Movement")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies how the movement of a particular item, or bin content, into or out of this bin, is blocked.',
                                FRA = 'Spécifie la manière dont le transfert d''un article particulier, ou le contenu de l''emplacement, dans ou en dehors de cet emplacement, est bloqué.';
                    Visible = false;
                }
                field("Min. Qty."; Rec."Min. Qty.")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Indicates the minimum number of units of the item that you want to have in the bin at all times.',
                                FRA = 'Indique le nombre d''unités minimum de cet article que vous souhaitez voir en permanence dans l''emplacement.';
                    Visible = false;
                }
                field("Max. Qty."; Rec."Max. Qty.")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Indicates the maximum number of units of the item that you want to have in the bin.',
                                FRA = 'Indique le nombre maximum d''unités de cet article que vous souhaitez avoir dans l''emplacement.';
                    Visible = false;
                }
                field(CalcQtyUOM; Rec.CalcQtyUOM())
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    CaptionML = ENU = 'Quantity',
                                FRA = 'Quantité';
                    DecimalPlaces = 0 : 5;
                    Visible = false;
                    ToolTip = 'Specifies the value of the CalcQtyUOM() field.';
                }
                field("Pick Quantity (Base)"; Rec."Pick Quantity (Base)")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies how many units of the item, in the base unit of measure, will be picked from the bin.',
                                FRA = 'Indique le nombre d''unités de mesure de l''article contenues dans une unité de mesure de l''article prélevées dans l''emplacement.';
                    Visible = false;
                }
                field("ATO Components Pick Qty (Base)"; Rec."ATO Components Pick Qty (Base)")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Visible = false;
                    ToolTip = 'Specifies how many assemble-to-order units are picked for assembly.';
                }
                field("Negative Adjmt. Qty. (Base)"; Rec."Negative Adjmt. Qty. (Base)")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies how many item units, in the base unit of measure, will be posted on journal lines as negative quantities.',
                                FRA = 'Indique le nombre d''unités d''article, exprimé en unité de base, qui sera validé sur les lignes feuille en tant que quantités négatives.';
                    Visible = false;
                }
                field("Put-away Quantity (Base)"; Rec."Put-away Quantity (Base)")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies how many units of the item, in the base unit of measure, will be put away in the bin.',
                                FRA = 'Indique le nombre d''unités de mesure de l''article contenues dans une unité de mesure de l''article rangées dans l''emplacement.';
                    Visible = false;
                }
                field("Positive Adjmt. Qty. (Base)"; Rec."Positive Adjmt. Qty. (Base)")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies how many item units, in the base unit of measure, will be posted on journal lines as positive quantities.',
                                FRA = 'Indique le nombre d''unités d''article, exprimé en unité de base, qui sera validé sur les lignes feuille en tant que quantités positives.';
                    Visible = false;
                }
                field(CalcQtyAvailToTakeUOM; Rec.CalcQtyAvailToTakeUOM())
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    CaptionML = ENU = 'Available Qty. to Take',
                                FRA = 'Qté disponible pour prélèv.';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the quantity of the item that is available in the bin.',
                                FRA = 'Spécifie la quantité de l''article disponible dans l''emplacement.';
                    Visible = false;
                }
                field("Fixed"; Rec.Fixed)
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies that the item (bin content) has been associated with this bin, and that the bin should normally contain the item.',
                                FRA = 'Indique que l''article (contenu de l''emplacement) a été associé à cet emplacement et que ce dernier doit normalement contenir l''article.';
                    Visible = false;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies how many units of the item, in the base unit of measure, are stored in the bin.',
                                FRA = 'Indique le nombre d''unités de mesure de l''article contenues dans une unité de mesure de l''article stockées dans l''emplacement.';
                    Visible = false;
                }
                field("Cross-Dock Bin"; Rec."Cross-Dock Bin")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies if the bin content is in a cross-dock bin.',
                                FRA = 'Indique si le contenu de l''emplacement est considéré comme étant un emplacement de transbordement.';
                    Visible = false;
                }
                field("Available Inv. (Whse)"; Rec."Available Inv. (Whse) FND")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Visible = false;
                    ToolTip = 'Specifies the value of the Available Inv. (Whse) field.';
                }
                field("Quantity Quality Hold (Base)"; Rec."Quantity Qual Hold (Base) FND")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Visible = false;
                    ToolTip = 'Specifies the value of the Quantity Quality Hold (Base) field.';
                }
                field("Quantity Unrestricted (Base)"; Rec."Quantity Unrestrict (Base) FND")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Visible = false;
                    ToolTip = 'Specifies the value of the Quantity Unrestricted (Base) field.';
                }
                field("Quantity Blocked (Base)"; Rec."Quantity Blocked (Base) FND")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Visible = false;
                    ToolTip = 'Specifies the value of the Quantity Blocked (Base) field.';
                }
                field("Opening Stock"; Rec."Opening Stock FND")
                {
                    Caption = 'Opening Stock';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Opening Stock field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Opening Stock field.';


                    trigger OnDrillDown();
                    begin
                        DrillDownOpeningStock(Rec);
                    end;
                }
                field("Purchase Receipts"; Rec."Purchase Receipts FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Receipts field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Purchase Receipts field.';

                }
                field("Production Output"; Rec."Production Output FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Production Output field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Production Output field.';

                }
                field("Positive Adjustment"; Rec."Positive Adjustment FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Positive Adjustment field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Positive Adjustment field.';

                }
                field("Negative Adjustment"; Rec."Negative Adjustment FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Negative Adjustment field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Negative Adjustment field.';

                }
                field("Production Consumption"; Rec."Production Consumption FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Production Consumption field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Production Consumption field.';

                }
                field(Transfers; Rec."Transfers FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transfers field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Transfers field.';

                }
                field("Internal Transfers"; Rec."Internal Transfers FND")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Caption = 'Internal Movements';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Internal Movements field.';
                }
                field("Sales Shipments"; Rec."Sales Shipments FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Shipments field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Sales Shipments field.';

                }
                field("Final Stock"; Rec."Final Stock FND")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Caption = 'Closing Stock';
                    ToolTip = 'Specifies the value of the Closing Stock field.';
                }
                field("Unit Cost Final Stock"; Rec."Unit Cost Final Stock FND")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Caption = 'Unit Cost SKU';
                    ToolTip = 'Specifies the value of the Unit Cost SKU field.';

                    trigger OnDrillDown();
                    begin
                        CLEAR(AverageCostCalcPage);
                        Item.RESET();
                        if Item.GET(Rec."Item No.") then begin
                            AverageCostCalcPage.SetBinAnalysisFilters(Item, Rec."Location Code", EndingDate, Rec."Variant Code");
                            AverageCostCalcPage.RUNMODAL();
                        end;
                    end;
                }
                field(TotalOpeningValue; TotalOpeningValue)
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Caption = 'Value Opening Stock';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Value Opening Stock field.';
                }
                field(TotalFinalValue; TotalFinalValue)
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Caption = 'Value Closing Stock';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Value Closing Stock field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {

                CaptionML = ENU = '&Line',
                            FRA = '&Ligne';
                Image = Line;
                action("Warehouse Entries")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    CaptionML = ENU = 'Warehouse Entries',
                                FRA = 'Écritures entrepôt';
                    Image = BinLedger;
                    RunObject = Page "Warehouse Entries";
                    RunPageLink = "Item No." = FIELD("Item No."),
                                  "Location Code" = FIELD("Location Code"),
                                  "Bin Code" = FIELD("Bin Code"),
                                  "Variant Code" = FIELD("Variant Code");
                    RunPageView = sorting("Item No.", "Bin Code", "Location Code", "Variant Code");
                    ToolTip = 'Executes the Warehouse Entries action.';
                }
            }
        }
        area(processing)
        {
            group("&Update History")
            {
                Caption = '&Update History';
                action("UpdateZone/Bin")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Caption = 'Update Zone/Bin in Value Entries and Item Ledg. entries';
                    Image = Zones;
                    RunObject = Report "Update Zones/Bins CBN";
                    ToolTip = 'Executes the Update Zone/Bin in Value Entries and Item Ledg. entries action.';
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        Rec.GetItemDescr(Rec."Item No.", Rec."Variant Code", ItemDescription);
        DataCaption := STRSUBSTNO('%1 ', Rec."Bin Code");
    end;

    trigger OnAfterGetRecord();
    begin
        Rec.SETRANGE("Date Filter FND", StartDate, EndDate);

        StartingDate := Rec.GETRANGEMIN("Date Filter FND");
        EndingDate := Rec.GETRANGEMAX("Date Filter FND");

        //calculate Opening Stock
        //CalculateOpeningStock;//HEI.02
        CalculateOpeningStockQuery(); //HEI.02

        //Calculate Avg cost overview Unit Cost + Quantity
        //InsertAvgCalcOverviewValues;//HEI.02


        //"Unit Cost Opening Stock" := CalculateUnitCost(StartingDate); //HEI.02
        //"Unit Cost Final Stock" := CalculateUnitCost(EndingDate); //HEI.02

        //HEI.02 start

        if recItemNo.GET(Rec."Item No.") then begin
            Rec."Unit Cost Opening Stock FND" := recItemNo."Unit Cost";
            Rec."Unit Cost Final Stock FND" := recItemNo."Unit Cost";
        end else begin
            Rec."Unit Cost Opening Stock FND" := 0;
            Rec."Unit Cost Final Stock FND" := 0;
        end;

        /*
        tAvgCostCalcOverview.RESET();
        tAvgCostCalcOverview.SETRANGE("Item No.",Rec."Item No.");
        tAvgCostCalcOverview.SETRANGE("Location Code",Rec."Location Code");
        tAvgCostCalcOverview.SETRANGE("Valuation Date",StartingDate);
        IF tAvgCostCalcOverview.FINDFIRST THEN BEGIN
           "Unit Cost Opening Stock":=tAvgCostCalcOverview."Cost Amount (Actual)";
        end else BEGIN
            InsertAvgCalcOverviewValues;
            EntryNo:=EntryNo+1;
            tAvgCostCalcOverview.INIT;
            tAvgCostCalcOverview."Entry No.":=EntryNo;
            tAvgCostCalcOverview."Item No.":=Rec."Item No.";
            tAvgCostCalcOverview."Location Code":=Rec."Location Code";
            tAvgCostCalcOverview."Valuation Date":=StartingDate;
            tAvgCostCalcOverview."Cost Amount (Actual)":=CalculateUnitCost(StartingDate);
            tAvgCostCalcOverview.INSERT();
            "Unit Cost Opening Stock":=tAvgCostCalcOverview."Cost Amount (Actual)";
        end;
        
        tAvgCostCalcOverview.RESET();
        tAvgCostCalcOverview.SETRANGE("Item No.",Rec."Item No.");
        tAvgCostCalcOverview.SETRANGE("Location Code",Rec."Location Code");
        tAvgCostCalcOverview.SETRANGE("Valuation Date",EndingDate);
        IF tAvgCostCalcOverview.FINDFIRST THEN BEGIN
           "Unit Cost Final Stock":=tAvgCostCalcOverview."Cost Amount (Actual)";
        end else BEGIN
            InsertAvgCalcOverviewValues;
            EntryNo:=EntryNo+1;
            tAvgCostCalcOverview.INIT;
            tAvgCostCalcOverview."Entry No.":=EntryNo;
            tAvgCostCalcOverview."Item No.":=Rec."Item No.";
            tAvgCostCalcOverview."Location Code":=Rec."Location Code";
            tAvgCostCalcOverview."Valuation Date":=EndingDate;
            tAvgCostCalcOverview."Cost Amount (Actual)":=CalculateUnitCost(EndingDate);
            tAvgCostCalcOverview.INSERT();
            "Unit Cost Final Stock":=tAvgCostCalcOverview."Cost Amount (Actual)";
        end;
        */

        //calculate Total Opening Value

        TotalOpeningValue := Rec."Unit Cost Opening Stock FND" * Rec."Opening Stock FND";
        //HEI.02 end

        //calculate Total Closing Value
        TotalFinalValue := Rec."Unit Cost Final Stock FND" * Rec."Final Stock FND";

    end;

    trigger OnOpenPage();
    begin
        ItemDescription := '';
        Rec.GetWhseLocation(LocationCode, ZoneCode);

        //CLEAR(StartDate);
        //CLEAR(EndDate);
        Rec.SETRANGE("Date Filter FND", WORKDATE());
        StartDate := WORKDATE();
        EndDate := WORKDATE();
        //HEI.02>>
        //InsertAllAvgCalcOverviewValues;
        tAvgCostCalcOverview.DELETEALL();
        //HEI.02<<
        CurrPage.UPDATE(true);
    end;

    var
        AvgCostCalcOverview: Record "Average Cost Calc. Overview" temporary;
        tAvgCostCalcOverview: Record "Average Cost Calc. Overview" temporary;
        ExcelBuffer: Record "Excel Buffer";
        Item: Record Item;
        recItemNo: Record Item;
        AdjmtLocation: Record Location;
        Location: Record Location;
        WarehouseEntry: Record "Warehouse Entry";
        Zone: Record Zone;
        GetAvgCostCalcOverview: Codeunit "Get Average Cost Calc Overview";
        ShowAvgCalcItem: Codeunit "Show Avg. Calc. - Item";
        WMSMgt: Codeunit "WMS Management";
        AverageCostCalcPage: Page "BinAvgCostCalcOverviewCBN";
        ItemCategory: Code[10];
        LocationCode: Code[10];
        ZoneCode: Code[10];
        DateFilter: Date;
        EndDate: Date;
        EndingDate: Date;
        StartDate: Date;
        StartingDate: Date;
        TotalFinalValue: Decimal;
        TotalOpeningValue: Decimal;
        EntryNo: Integer;
        Text001: Label 'Updating Opening Stock @1@@@@@@@';
        DateFilterTxt: Text;
        ItemDescription: Text[50];
        DataCaption: Text[80];
        LocFilter: Text[250];
        Text000: TextConst ENU = 'Location code is not allowed for user %1.', FRA = 'L''utilisateur %1 n''est pas autorisé à utiliser ce code magasin.';

    local procedure DefFilter();
    begin
        Rec.FILTERGROUP := 2;
        if LocationCode <> '' then
            Rec.SETRANGE("Location Code", LocationCode)
        else begin
            CLEAR(LocFilter);
            CLEAR(Location);
            Location.SETRANGE("Bin Mandatory", true);
            if Location.FIND('-') then
                repeat
                    if WMSMgt.LocationIsAllowed(Location.Code) then
                        LocFilter := LocFilter + Location.Code + '|';
                until Location.NEXT() = 0;
            if STRLEN(LocFilter) <> 0 then
                LocFilter := COPYSTR(LocFilter, 1, (STRLEN(LocFilter) - 1));
            Rec.SETFILTER("Location Code", LocFilter);
        end;
        if ZoneCode <> '' then
            Rec.SETRANGE("Zone Code", ZoneCode)
        else
            Rec.SETRANGE("Zone Code");
        Rec.FILTERGROUP := 0;
    end;

    local procedure CheckQty();
    begin
        Rec.TESTFIELD(Quantity, 0);
        Rec.TESTFIELD("Pick Qty.", 0);
        Rec.TESTFIELD("Put-away Qty.", 0);
        Rec.TESTFIELD("Pos. Adjmt. Qty.", 0);
        Rec.TESTFIELD("Neg. Adjmt. Qty.", 0);
    end;

    local procedure LocationGet(LocationCode: Code[10]);
    begin
        if AdjmtLocation.Code <> LocationCode then
            AdjmtLocation.GET(LocationCode);
    end;

    local procedure LocationCodeOnAfterValidate();
    begin
        CurrPage.UPDATE(true);
    end;

    local procedure ZoneCodeOnAfterValidate();
    begin
        CurrPage.UPDATE(true);
    end;

    local procedure DrillDownOpeningStock(Rec: Record "Bin Content");
    var
        WarehouseEntry: Record "Warehouse Entry";
    begin
        WarehouseEntry.RESET();
        WarehouseEntry.SETRANGE("Location Code", Rec."Location Code");
        WarehouseEntry.SETRANGE("Bin Code", Rec."Bin Code");
        WarehouseEntry.SETRANGE("Item No.", Rec."Item No.");
        WarehouseEntry.SETRANGE("Variant Code", Rec."Variant Code");
        WarehouseEntry.SETRANGE("Unit of Measure Code", Rec."Unit of Measure Code");
        WarehouseEntry.SETRANGE("Registering Date", 0D, StartingDate);
        PAGE.RUN(0, WarehouseEntry, WarehouseEntry."Qty. (Base)");
    end;

    local procedure CalculateOpeningStock();
    var
        WarehouseEntry: Record "Warehouse Entry";
    begin
        WarehouseEntry.RESET();
        WarehouseEntry.SETRANGE("Location Code", Rec."Location Code");
        WarehouseEntry.SETRANGE("Bin Code", Rec."Bin Code");
        WarehouseEntry.SETRANGE("Item No.", Rec."Item No.");
        WarehouseEntry.SETRANGE("Variant Code", Rec."Variant Code");
        WarehouseEntry.SETRANGE("Unit of Measure Code", Rec."Unit of Measure Code");
        WarehouseEntry.SETRANGE("Registering Date", 0D, StartingDate);
        if WarehouseEntry.findset() then
            repeat
                Rec."Opening Stock FND" += WarehouseEntry."Qty. (Base)";
            until WarehouseEntry.NEXT() = 0;
    end;

    local procedure CalculateUnitCost(var ValuationDate: Date) UnitCost: Decimal;
    begin
        //calculate Unit Cost Opening Stock
        AvgCostCalcOverview.RESET();
        AvgCostCalcOverview.SETRANGE("Item No.", Rec."Item No.");
        AvgCostCalcOverview.SETFILTER("Location Code", Rec."Location Code");
        AvgCostCalcOverview.SETFILTER("Variant Code", Rec."Variant Code");
        AvgCostCalcOverview.SETRANGE(Type, AvgCostCalcOverview.Type::"Closing Entry");
        AvgCostCalcOverview.SETRANGE("Valuation Date", 0D, ValuationDate);
        AvgCostCalcOverview.SETRANGE("Cost is Adjusted", true);
        AvgCostCalcOverview.SETFILTER(Quantity, '<>%1', 0);
        if AvgCostCalcOverview.FINDLAST() then begin
            UnitCost := AvgCostCalcOverview.CalculateAverageCost();
            //MESSAGE(FORMAT(UnitCost));
        end else begin
            AvgCostCalcOverview.RESET();
            AvgCostCalcOverview.SETRANGE("Item No.", Rec."Item No.");
            AvgCostCalcOverview.SETFILTER("Variant Code", Rec."Variant Code");
            AvgCostCalcOverview.SETRANGE(Type, AvgCostCalcOverview.Type::"Closing Entry");
            AvgCostCalcOverview.SETRANGE("Valuation Date", 0D, ValuationDate);
            AvgCostCalcOverview.SETRANGE("Cost is Adjusted", true);
            AvgCostCalcOverview.SETFILTER(Quantity, '<>%1', 0);
            if AvgCostCalcOverview.FINDLAST() then begin
                UnitCost := AvgCostCalcOverview.CalculateAverageCost();
                //MESSAGE(FORMAT(UnitCost));
            end else
                UnitCost := 0;
        end;
        exit(UnitCost);
    end;

    local procedure InsertAvgCalcOverviewValues();
    var
        lrec_AvgCostCalcOverview: Record "Average Cost Calc. Overview" temporary;
    begin

        AvgCostCalcOverview.DELETEALL();

        AvgCostCalcOverview.RESET();
        AvgCostCalcOverview."Item No." := Rec."Item No.";
        AvgCostCalcOverview.SETFILTER("Variant Code", Rec."Variant Code");
        AvgCostCalcOverview.SETFILTER("Location Code", Rec."Location Code");
        AvgCostCalcOverview.SETRANGE(Type, AvgCostCalcOverview.Type::"Closing Entry");
        GetAvgCostCalcOverview.RUN(AvgCostCalcOverview);
        if AvgCostCalcOverview.findset() then
            repeat
                AvgCostCalcOverview.Quantity := AvgCostCalcOverview.CalculateRemainingQty();
                AvgCostCalcOverview.MODIFY();
            until AvgCostCalcOverview.NEXT() = 0;
    end;

    local procedure InsertAllAvgCalcOverviewValuesPreload();
    var
        lrec_AvgCostCalcOverview: Record "Average Cost Calc. Overview" temporary;
        lrecBinContent: Record "Bin Content";
        recItem: Record Item;
        LPage50506: Page "BinContentAnalysisReportCBN";
        lqueryBinContent: Query "Bin Content CBN";
        ProgressWindow: Dialog;
        i: Integer;
        ProcessingRow: Integer;
        TotalRows: Integer;
    begin
        //HEI.02>>

        ProgressWindow.OPEN('Processing Bin Entry ... #1##########');
        CLEAR(AvgCostCalcOverview);

        tAvgCostCalcOverview.RESET();
        tAvgCostCalcOverview.DELETEALL();

        CLEAR(ProcessingRow);

        lqueryBinContent.OPEN();
        while lqueryBinContent.READ() do begin
            ProcessingRow += 1;
            ProgressWindow.UPDATE(1, FORMAT(ProcessingRow));


            AvgCostCalcOverview.DELETEALL();

            AvgCostCalcOverview.RESET();
            AvgCostCalcOverview."Item No." := lqueryBinContent.Item_No;
            AvgCostCalcOverview.SETFILTER("Variant Code", lqueryBinContent.Variant_Code);
            AvgCostCalcOverview.SETFILTER("Location Code", lqueryBinContent.Location_Code);
            AvgCostCalcOverview.SETRANGE(Type, AvgCostCalcOverview.Type::"Closing Entry");
            GetAvgCostCalcOverview.RUN(AvgCostCalcOverview);
            if AvgCostCalcOverview.findset() then
                repeat
                    AvgCostCalcOverview.Quantity := AvgCostCalcOverview.CalculateRemainingQty();
                    AvgCostCalcOverview.MODIFY();
                until AvgCostCalcOverview.NEXT() = 0;


            tAvgCostCalcOverview.RESET();
            tAvgCostCalcOverview.SETRANGE("Item No.", lqueryBinContent.Item_No);
            tAvgCostCalcOverview.SETRANGE("Location Code", lqueryBinContent.Location_Code);
            tAvgCostCalcOverview.SETRANGE("Valuation Date", StartingDate);
            if not tAvgCostCalcOverview.FINDFIRST() then begin
                InsertAvgCalcOverviewValues();
                EntryNo := EntryNo + 1;
                tAvgCostCalcOverview.INIT();
                tAvgCostCalcOverview."Entry No." := EntryNo;
                tAvgCostCalcOverview."Item No." := lqueryBinContent.Item_No;
                tAvgCostCalcOverview."Location Code" := lqueryBinContent.Location_Code;
                tAvgCostCalcOverview."Valuation Date" := StartingDate;
                tAvgCostCalcOverview."Cost Amount (Actual)" := CalculateUnitCostPreload(StartDate, lqueryBinContent.Item_No, lqueryBinContent.Location_Code, lqueryBinContent.Variant_Code);
                tAvgCostCalcOverview.INSERT();

            end;

            tAvgCostCalcOverview.RESET();
            tAvgCostCalcOverview.SETRANGE("Item No.", lqueryBinContent.Item_No);
            tAvgCostCalcOverview.SETRANGE("Location Code", lqueryBinContent.Location_Code);
            tAvgCostCalcOverview.SETRANGE("Valuation Date", EndingDate);
            if not tAvgCostCalcOverview.FINDFIRST() then begin
                InsertAvgCalcOverviewValues();
                EntryNo := EntryNo + 1;
                tAvgCostCalcOverview.INIT();
                tAvgCostCalcOverview."Entry No." := EntryNo;
                tAvgCostCalcOverview."Item No." := lqueryBinContent.Item_No;
                tAvgCostCalcOverview."Location Code" := lqueryBinContent.Location_Code;
                tAvgCostCalcOverview."Valuation Date" := EndingDate;
                tAvgCostCalcOverview."Cost Amount (Actual)" := CalculateUnitCostPreload(EndDate, lqueryBinContent.Item_No, lqueryBinContent.Location_Code, lqueryBinContent.Variant_Code);
                tAvgCostCalcOverview.INSERT();
            end;
        end;
        ProgressWindow.CLOSE();//process dialog
        lqueryBinContent.CLOSE();


        //HEI.02<<
    end;

    local procedure CalculateAllOpeningStock();
    var
        lrecBinContent: Record "Bin Content";
        lqueryWarehouseEntry: Query "Warehouse Entry Totals CBN";
        Progressbar: Dialog;
        MaxCount: Integer;
        ProcessingRow: Integer;
        recCount: Integer;
    begin
        //HEI.02>>
        /*
        CLEAR(ProcessingRow);
        
        lqueryWarehouseEntry.SETFILTER(Registering_Date,'%1..%2',0D,StartDate);
        lqueryWarehouseEntry.OPEN;
        WHILE lqueryWarehouseEntry.READ DO BEGIN
        
          lrecBinContent.SETRANGE("Location Code",lqueryWarehouseEntry.Location_Code);
          lrecBinContent.SETRANGE("Bin Code",lqueryWarehouseEntry.Bin_Code);
          lrecBinContent.SETRANGE("Item No.",lqueryWarehouseEntry.Item_No);
          lrecBinContent.SETRANGE("Variant Code",lqueryWarehouseEntry.Variant_Code);
          lrecBinContent.SETRANGE("Unit of Measure Code",lqueryWarehouseEntry.Unit_of_Measure_Code);
          IF lrecBinContent.FINDFIRST THEN BEGIN
            lrecBinContent."Opening Stock" := lqueryWarehouseEntry.Sum_Qty_Base;
            ProcessingRow:=ProcessingRow+1;
            lrecBinContent.MODIFY(FALSE);
          end;
          //ProgressWindow.UPDATE(1,FORMAT(ProcessingRow));
        end;
        lqueryWarehouseEntry.CLOSE;
        */
        //HEI.02<<

    end;

    local procedure CalculateOpeningStockQuery();
    var
        lrecBinContent: Record "Bin Content";
        lqueryWarehouseEntry: Query "Warehouse Entry Totals CBN";
        Progressbar: Dialog;
        MaxCount: Integer;
        ProcessingRow: Integer;
        recCount: Integer;
    begin
        //HEI.02>>
        Rec."Opening Stock FND" := 0;
        lqueryWarehouseEntry.SETRANGE(Location_Code, Rec."Location Code");
        lqueryWarehouseEntry.SETRANGE(Bin_Code, Rec."Bin Code");
        lqueryWarehouseEntry.SETRANGE(Item_No, Rec."Item No.");
        lqueryWarehouseEntry.SETRANGE(Variant_Code, Rec."Variant Code");
        lqueryWarehouseEntry.SETRANGE(Unit_of_Measure_Code, Rec."Unit of Measure Code");
        lqueryWarehouseEntry.SETRANGE(Registering_Date, 0D, StartingDate);
        //lqueryWarehouseEntry.SETFILTER(Registering_Date,'%1..%2',0D,StartDate);
        lqueryWarehouseEntry.OPEN();
        while lqueryWarehouseEntry.READ() do begin
            Rec."Opening Stock FND" := Rec."Opening Stock FND" + lqueryWarehouseEntry.Sum_Qty_Base;
        end;
        lqueryWarehouseEntry.CLOSE();
        //HEI.02<<
    end;

    local procedure CalculateUnitCostPreload(var ValuationDate: Date; ItemNo: Code[20]; LocationCode: Code[20]; VariantCode: Code[20]) UnitCost: Decimal;
    begin
        //calculate Unit Cost Opening Stock
        //MESSAGE(FORMAT(AvgCostCalcOverview.COUNT));
        AvgCostCalcOverview.RESET();
        AvgCostCalcOverview.SETRANGE("Item No.", ItemNo);
        AvgCostCalcOverview.SETFILTER("Location Code", LocationCode);
        AvgCostCalcOverview.SETFILTER("Variant Code", VariantCode);
        AvgCostCalcOverview.SETRANGE(Type, AvgCostCalcOverview.Type::"Closing Entry");
        AvgCostCalcOverview.SETRANGE("Valuation Date", 0D, ValuationDate);
        AvgCostCalcOverview.SETRANGE("Cost is Adjusted", true);
        AvgCostCalcOverview.SETFILTER(Quantity, '<>%1', 0);
        if AvgCostCalcOverview.FINDLAST() then begin
            UnitCost := AvgCostCalcOverview.CalculateAverageCost();
            //MESSAGE(FORMAT(UnitCost));
        end else begin
            AvgCostCalcOverview.RESET();
            AvgCostCalcOverview.SETRANGE("Item No.", ItemNo);
            AvgCostCalcOverview.SETFILTER("Variant Code", VariantCode);
            AvgCostCalcOverview.SETRANGE(Type, AvgCostCalcOverview.Type::"Closing Entry");
            AvgCostCalcOverview.SETRANGE("Valuation Date", 0D, ValuationDate);
            AvgCostCalcOverview.SETRANGE("Cost is Adjusted", true);
            AvgCostCalcOverview.SETFILTER(Quantity, '<>%1', 0);
            if AvgCostCalcOverview.FINDLAST() then begin
                UnitCost := AvgCostCalcOverview.CalculateAverageCost();
                //MESSAGE(FORMAT(UnitCost));
            end else
                UnitCost := 0;
        end;
        exit(UnitCost);
    end;

    local procedure UpdateItemUnitCost();
    begin
        Rec.RESET();
        if Rec.findset(false) then
            repeat

                if recItemNo.GET(Rec."Item No.") then begin
                    // Rec."Unit Cost Opening Stock":=recItemNo."Unit Cost";
                    Rec."Unit Cost Final Stock FND" := recItemNo."Unit Cost";
                    Rec.MODIFY(false);
                end else begin
                    // Rec."Unit Cost Opening Stock":=0;
                    Rec."Unit Cost Final Stock FND" := 0;
                    Rec.MODIFY(false);
                end;

            until Rec.NEXT() = 0;
    end;
}

