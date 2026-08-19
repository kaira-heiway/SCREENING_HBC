report 53075 "IN_OUT Movement by Reason"
{
    // version IBM 1001

    // FDD-HNK CHG2011880 : 24/06/2019 ISYED01 :
    //     # Created New Report for Sales IN_OUT Movement By Reason.

    // BC Upgrade KUMARR78 >>
    //
    // Old Report ID and : 50270 
    // Name: "IN_OUT Movement by Reason"
    //
    // 1. Added ApplicationArea property at report level.
    //    Old:
    //         - ApplicationArea property was not defined at report level.
    //    New:
    //         - ApplicationArea = All;
    //
    // 2. Added UsageCategory property at report level.
    //    Old:
    //         - UsageCategory property was not defined at report level.
    //    New:
    //         - UsageCategory = ReportsAndAnalysis;
    //
    // 3. Added ApplicationArea property to all Request Page fields.
    //    Old:
    //         - Request page fields did not have ApplicationArea property.
    //    New:
    //         - ApplicationArea = All added to all request page fields.
    //
    // 4. Blocked usage of DIT field "Inventory Unit of Measure".
    //    Old:
    //         - Code was using Item."Inventory Unit of Measure".
    //         - ItemUnitofMeasure.GET(Item."No.", Item."Inventory Unit of Measure") was used.
    //         - Logic compared:
    //               Item."Base Unit of Measure" = Item."Inventory Unit of Measure".
    //    New:
    //         - DIT field usage removed.
    //         - ItemUnitofMeasure.GET call removed.
    //         - Base UOM comparison logic removed.
    //
    // 5. Rewritten quantity calculation logic due to removal of DIT field.
    //    Old:
    //         - Complex condition using:
    //               Item."Base Unit of Measure"
    //               Item."Inventory Unit of Measure"
    //               ItemUnitofMeasure."Qty. per Unit of Measure"
    //    New:
    //         - Simplified logic:
    //               If ShowqtyinInvUOM = TRUE
    //                   Quantity divided by ItemUnitofMeasure."Qty. per Unit of Measure"
    //               Else
    //                   Direct Quantity used
    // BC Upgrade KUMARR78 <<
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\IN_OUT Movement by Reason.rdl';
    ApplicationArea = All; // BC Upgrade RAHUL Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade RAHUL Adding Usagecategory

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = sorting(Number) order(ascending) where(Number = const(1));
            PrintOnlyIfDetail = true;
            column(ShowqtyinInvUOM; ShowqtyinInvUOM1)
            {
            }
            column(FromDate; Format(FromDate))
            {
            }
            column(ToDate; Format(ToDate))
            {
            }
            column(LocationFilter; LocationFilter)
            {
            }
            column(ItemCategoryFilter; ItemCategoryFilter)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(BrandFilter; BrandFilter)
            {
            }
            column(ShowPR1; ShowPR1)
            {
            }
            column(ShowPS1; ShowPS1)
            {
            }
            column(ShowOutput1; ShowOutput1)
            {
            }
            column(ShowConsumption1; ShowConsumption1)
            {
            }
            column(ShowRR1; ShowRR1)
            {
            }
            column(ShowSH1; ShowSH1)
            {
            }
            column(ShowTR1; ShowTR1)
            {
            }
            column(ShowInTransitLocation1; ShowInTransitLocation1)
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemTableView = sorting("Entry Type", "Document Type", "Item No.", "Source No.", "Location Code", "Variant Code", "Posting Date") order(ascending) where("Entry Type" = const(Purchase), "Document Type" = const("Purchase Receipt"));
                column(CompanyName; CompanyName)
                {
                }
                column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
                {
                }
                column(Description_ItemLedgerEntry; "Item Ledger Entry".Description)
                {
                }
                column(LocationCode_ItemLedgerEntry; "Item Ledger Entry"."Location Code")
                {
                }
                column(LotNo_ItemLedgerEntry; "Item Ledger Entry"."Lot No.")
                {
                }
                column(Location_Name; LocName)
                {
                }
                column(Expiry; Format(ExpiryDate))
                {
                }
                column(QtyIN; QtyIn)
                {
                }
                column(QtyOUT; QtyOut)
                {
                }
                column(ShowPR; ShowPR)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    Item.Get("Item No.");
                    //BC UPGRADE KUMARR78 >> Blocking DIT Field("Inventory Unit of Measure")
                    // if ShowqtyinInvUOM then begin
                    //     if Item."Inventory Unit of Measure" <> '' then
                    //         ItemUnitofMeasure.GET(Item."No.", Item."Inventory Unit of Measure");
                    // end;
                    //BC UPGRADE KUMARR78 ><< Blocking DIT Field("Inventory Unit of Measure")

                    QtyIn := 0;
                    QtyOut := 0;

                    //BC UPGRADE KUMARR78 >> Blocking DIT Field and Whole Condition to rewritte
                    // if ShowqtyinInvUOM then
                    //     if Item."Base Unit of Measure" = Item."Inventory Unit of Measure" then begin
                    //         if Quantity > 0 then
                    //             QtyIn := Quantity
                    //         else
                    //             QtyOut := -1 * Quantity;
                    //     end else begin
                    //         if Quantity > 0 then
                    //             QtyIn := Quantity / ItemUnitofMeasure."Qty. per Unit of Measure"
                    //         else
                    //             QtyOut := (-1 * Quantity) / ItemUnitofMeasure."Qty. per Unit of Measure";
                    //     end
                    // else begin
                    //     if Quantity > 0 then
                    //         QtyIn := Quantity
                    //     else
                    //         QtyOut := -1 * Quantity;
                    // end;
                    //BC UPGRADE KUMARR78 << Blocking DIT Field and Whole Condition to rewritte...

                    //BC UPGRADE KUMARR78 >> Rewritting Whole Above Conditon Due to Usage of DIT Field.
                    if ShowqtyinInvUOM then begin
                        if Quantity > 0 then
                            QtyIn := Quantity / ItemUnitofMeasure."Qty. per Unit of Measure"
                        else
                            QtyOut := (-1 * Quantity) / ItemUnitofMeasure."Qty. per Unit of Measure";
                    end else
                        if Quantity > 0 then
                            QtyIn := Quantity
                        else
                            QtyOut := -1 * Quantity;
                    //BC UPGRADE KUMARR78 << Rewritting Whole Above Conditon Due to Usage of DIT Field.

                    ExpiryDate := GetOutbountExpiryDate("Entry No.");

                    if Loc.Get(ItemLedgEntry."Location Code") then
                        LocName := Loc.Name;
                end;

                trigger OnPreDataItem();
                begin
                    if not ShowPR then
                        CurrReport.Break();
                    if LocationFilter <> '' then
                        SetFilter("Location Code", LocationFilter);
                    SetRange("Posting Date", FromDate, ToDate);
                    if ItemFilter <> '' then
                        SetFilter("Item No.", ItemFilter);
                    if ItemCategoryFilter <> '' then
                        SetFilter("Item Category Code", ItemCategoryFilter);
                    if BrandFilter <> '' then
                        SetFilter("Global Dimension 1 Code", BrandFilter);
                end;
            }
            dataitem("<Item Ledger Entry1>"; "Item Ledger Entry")
            {
                DataItemTableView = sorting("Entry Type", "Document Type", "Item No.", "Source No.", "Location Code", "Variant Code", "Posting Date") order(ascending) where("Entry Type" = const(Purchase), "Document Type" = const("Purchase Return Shipment"));
                column(ItemNo_ItemLedgerEntry_PS; "<Item Ledger Entry1>"."Item No.")
                {
                }
                column(Description_ItemLedgerEntry_PS; "<Item Ledger Entry1>".Description)
                {
                }
                column(LocationCode_ItemLedgerEntry_PS; "<Item Ledger Entry1>"."Location Code")
                {
                }
                column(LotNo_ItemLedgerEntry_PS; "<Item Ledger Entry1>"."Lot No.")
                {
                }
                column(Location_Name_PS; LocName)
                {
                }
                column(Expiry_PS; Format(ExpiryDate))
                {
                }
                column(QtyIN_PS; QtyIn)
                {
                }
                column(QtyOUT_PS; QtyOut)
                {
                }
                column(ShowPS; ShowPS)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    Item.Get("Item No.");

                    //BC UPGRADE KUMARR78 >> Blocking DIT Field("Inventory Unit of Measure")
                    // if ShowqtyinInvUOM then begin
                    //     if Item."Inventory Unit of Measure" <> '' then
                    //         ItemUnitofMeasure.GET(Item."No.", Item."Inventory Unit of Measure");
                    // end;
                    //BC UPGRADE KUMARR78 ><< Blocking DIT Field("Inventory Unit of Measure")

                    QtyIn := 0;
                    QtyOut := 0;

                    //BC UPGRADE KUMARR78 >> Blocking DIT Field and Whole Condition to rewritte
                    // if ShowqtyinInvUOM then
                    //     if Item."Base Unit of Measure" = Item."Inventory Unit of Measure" then begin
                    //         if Quantity > 0 then
                    //             QtyIn := Quantity
                    //         else
                    //             QtyOut := -1 * Quantity;
                    //     end else begin
                    //         if Quantity > 0 then
                    //             QtyIn := Quantity / ItemUnitofMeasure."Qty. per Unit of Measure"
                    //         else
                    //             QtyOut := (-1 * Quantity) / ItemUnitofMeasure."Qty. per Unit of Measure";
                    //     end
                    // else begin
                    //     if Quantity > 0 then
                    //         QtyIn := Quantity
                    //     else
                    //         QtyOut := -1 * Quantity;
                    // end;
                    //BC UPGRADE KUMARR78 << Blocking DIT Field and Whole Condition to rewritte...

                    //BC UPGRADE KUMARR78 >> Rewritting Whole Above Conditon Due to Usage of DIT Field.
                    if ShowqtyinInvUOM then begin
                        if Quantity > 0 then
                            QtyIn := Quantity / ItemUnitofMeasure."Qty. per Unit of Measure"
                        else
                            QtyOut := (-1 * Quantity) / ItemUnitofMeasure."Qty. per Unit of Measure";
                    end else
                        if Quantity > 0 then
                            QtyIn := Quantity
                        else
                            QtyOut := -1 * Quantity;
                    //BC UPGRADE KUMARR78 << Rewritting Whole Above Conditon Due to Usage of DIT Field.


                    ExpiryDate := GetOutbountExpiryDate("Entry No.");

                    if Loc.Get(ItemLedgEntry."Location Code") then
                        LocName := Loc.Name;
                end;

                trigger OnPreDataItem();
                begin
                    if not ShowPS then
                        CurrReport.Break();
                    if LocationFilter <> '' then
                        SetFilter("Location Code", LocationFilter);
                    SetRange("Posting Date", FromDate, ToDate);
                    if ItemFilter <> '' then
                        SetFilter("Item No.", ItemFilter);
                    if ItemCategoryFilter <> '' then
                        SetFilter("Item Category Code", ItemCategoryFilter);
                    if BrandFilter <> '' then
                        SetFilter("Global Dimension 1 Code", BrandFilter);
                end;
            }
            dataitem("<Item Ledger Entry2>"; "Item Ledger Entry")
            {
                DataItemTableView = sorting("Entry Type", "Document Type", "Item No.", "Source No.", "Location Code", "Variant Code", "Posting Date") order(ascending) where("Entry Type" = const(Output), "Document Type" = const(" "));
                column(ItemNo_ItemLedgerEntry_OutPut; "<Item Ledger Entry2>"."Item No.")
                {
                }
                column(Description_ItemLedgerEntry_OutPut; "<Item Ledger Entry2>".Description)
                {
                }
                column(LotNo_ItemLedgerEntry_OutPut; "<Item Ledger Entry2>"."Lot No.")
                {
                }
                column(LocationCode_ItemLedgerEntry_OutPut; "<Item Ledger Entry2>"."Location Code")
                {
                }
                column(Location_Name_OutPut; LocName)
                {
                }
                column(Expiry_OutPut; Format(ExpiryDate))
                {
                }
                column(QtyIN_OutPut; QtyIn)
                {
                }
                column(QtyOUT_OutPut; QtyOut)
                {
                }
                column(ShowOutput; ShowOutput)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    Item.Get("Item No.");
                    //BC UPGRADE KUMARR78 >> Blocking DIT Field("Inventory Unit of Measure")
                    // if ShowqtyinInvUOM then begin
                    //     if Item."Inventory Unit of Measure" <> '' then
                    //         ItemUnitofMeasure.GET(Item."No.", Item."Inventory Unit of Measure");
                    // end;
                    //BC UPGRADE KUMARR78 ><< Blocking DIT Field("Inventory Unit of Measure")

                    QtyIn := 0;
                    QtyOut := 0;

                    //BC UPGRADE KUMARR78 >> Blocking DIT Field and Whole Condition to rewritte
                    // if ShowqtyinInvUOM then
                    //     if Item."Base Unit of Measure" = Item."Inventory Unit of Measure" then begin
                    //         if Quantity > 0 then
                    //             QtyIn := Quantity
                    //         else
                    //             QtyOut := -1 * Quantity;
                    //     end else begin
                    //         if Quantity > 0 then
                    //             QtyIn := Quantity / ItemUnitofMeasure."Qty. per Unit of Measure"
                    //         else
                    //             QtyOut := (-1 * Quantity) / ItemUnitofMeasure."Qty. per Unit of Measure";
                    //     end
                    // else begin
                    //     if Quantity > 0 then
                    //         QtyIn := Quantity
                    //     else
                    //         QtyOut := -1 * Quantity;
                    // end;
                    //BC UPGRADE KUMARR78 << Blocking DIT Field and Whole Condition to rewritte...

                    //BC UPGRADE KUMARR78 >> Rewritting Whole Above Conditon Due to Usage of DIT Field.
                    if ShowqtyinInvUOM then begin
                        if Quantity > 0 then
                            QtyIn := Quantity / ItemUnitofMeasure."Qty. per Unit of Measure"
                        else
                            QtyOut := (-1 * Quantity) / ItemUnitofMeasure."Qty. per Unit of Measure";
                    end else
                        if Quantity > 0 then
                            QtyIn := Quantity
                        else
                            QtyOut := -1 * Quantity;
                    //BC UPGRADE KUMARR78 << Rewritting Whole Above Conditon Due to Usage of DIT Field.

                    ExpiryDate := GetOutbountExpiryDate("Entry No.");

                    if Loc.Get(ItemLedgEntry."Location Code") then
                        LocName := Loc.Name;
                end;

                trigger OnPreDataItem();
                begin
                    if not ShowOutput then
                        CurrReport.Break();
                    if LocationFilter <> '' then
                        SetFilter("Location Code", LocationFilter);
                    SetRange("Posting Date", FromDate, ToDate);
                    if ItemFilter <> '' then
                        SetFilter("Item No.", ItemFilter);
                    if ItemCategoryFilter <> '' then
                        SetFilter("Item Category Code", ItemCategoryFilter);
                    if BrandFilter <> '' then
                        SetFilter("Global Dimension 1 Code", BrandFilter);
                end;
            }
            dataitem("<Item Ledger Entry3>"; "Item Ledger Entry")
            {
                DataItemTableView = sorting("Entry Type", "Document Type", "Item No.", "Source No.", "Location Code", "Variant Code", "Posting Date") order(ascending) where("Entry Type" = const(Consumption), "Document Type" = const(" "));
                column(ItemNo_ItemLedgerEntry_SC; "<Item Ledger Entry3>"."Item No.")
                {
                }
                column(Description_ItemLedgerEntry_SC; "<Item Ledger Entry3>".Description)
                {
                }
                column(LocationCode_ItemLedgerEntry_SC; "<Item Ledger Entry3>"."Location Code")
                {
                }
                column(LotNo_ItemLedgerEntry_SC; "<Item Ledger Entry3>"."Lot No.")
                {
                }
                column(Location_Name_SC; LocName)
                {
                }
                column(Expiry_SC; Format(ExpiryDate))
                {
                }
                column(QtyIN_SC; QtyIn)
                {
                }
                column(QtyOUT_SC; QtyOut)
                {
                }
                column(ShowConsumption; ShowConsumption)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    Item.Get("Item No.");
                    //BC UPGRADE KUMARR78 >> Blocking DIT Field("Inventory Unit of Measure")
                    // if ShowqtyinInvUOM then begin
                    //     if Item."Inventory Unit of Measure" <> '' then
                    //         ItemUnitofMeasure.GET(Item."No.", Item."Inventory Unit of Measure");
                    // end;
                    //BC UPGRADE KUMARR78 ><< Blocking DIT Field("Inventory Unit of Measure")
                    QtyIn := 0;
                    QtyOut := 0;

                    //BC UPGRADE KUMARR78 >> Blocking DIT Field and Whole Condition to rewritte
                    // if ShowqtyinInvUOM then
                    //     if Item."Base Unit of Measure" = Item."Inventory Unit of Measure" then begin
                    //         if Quantity > 0 then
                    //             QtyIn := Quantity
                    //         else
                    //             QtyOut := -1 * Quantity;
                    //     end else begin
                    //         if Quantity > 0 then
                    //             QtyIn := Quantity / ItemUnitofMeasure."Qty. per Unit of Measure"
                    //         else
                    //             QtyOut := (-1 * Quantity) / ItemUnitofMeasure."Qty. per Unit of Measure";
                    //     end
                    // else begin
                    //     if Quantity > 0 then
                    //         QtyIn := Quantity
                    //     else
                    //         QtyOut := -1 * Quantity;
                    // end;
                    //BC UPGRADE KUMARR78 << Blocking DIT Field and Whole Condition to rewritte...

                    //BC UPGRADE KUMARR78 >> Rewritting Whole Above Conditon Due to Usage of DIT Field.
                    if ShowqtyinInvUOM then begin
                        if Quantity > 0 then
                            QtyIn := Quantity / ItemUnitofMeasure."Qty. per Unit of Measure"
                        else
                            QtyOut := (-1 * Quantity) / ItemUnitofMeasure."Qty. per Unit of Measure";
                    end else
                        if Quantity > 0 then
                            QtyIn := Quantity
                        else
                            QtyOut := -1 * Quantity;
                    //BC UPGRADE KUMARR78 << Rewritting Whole Above Conditon Due to Usage of DIT Field.


                    ExpiryDate := GetOutbountExpiryDate("Entry No.");

                    if Loc.Get(ItemLedgEntry."Location Code") then
                        LocName := Loc.Name;
                end;

                trigger OnPreDataItem();
                begin
                    if not ShowConsumption then
                        CurrReport.Break();
                    if LocationFilter <> '' then
                        SetFilter("Location Code", LocationFilter);
                    SetRange("Posting Date", FromDate, ToDate);
                    if ItemFilter <> '' then
                        SetFilter("Item No.", ItemFilter);
                    if ItemCategoryFilter <> '' then
                        SetFilter("Item Category Code", ItemCategoryFilter);
                    if BrandFilter <> '' then
                        SetFilter("Global Dimension 1 Code", BrandFilter);
                end;
            }
            dataitem("<Item Ledger Entry4>"; "Item Ledger Entry")
            {
                DataItemTableView = sorting("Entry Type", "Document Type", "Item No.", "Source No.", "Location Code", "Variant Code", "Posting Date") order(ascending) where("Entry Type" = const(Sale), "Document Type" = const("Sales Return Receipt"));
                column(ItemNo_ItemLedgerEntry_RR; "<Item Ledger Entry4>"."Item No.")
                {
                }
                column(Description_ItemLedgerEntry_RR; "<Item Ledger Entry4>".Description)
                {
                }
                column(LocationCode_ItemLedgerEntry_RR; "<Item Ledger Entry4>"."Location Code")
                {
                }
                column(LotNo_ItemLedgerEntry_RR; "<Item Ledger Entry4>"."Lot No.")
                {
                }
                column(Location_Name_RR; LocName)
                {
                }
                column(Expiry_RR; Format(ExpiryDate))
                {
                }
                column(QtyIN_RR; QtyIn)
                {
                }
                column(QtyOUT_RR; QtyOut)
                {
                }
                column(ShowRR; ShowRR)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    Item.Get("Item No.");
                    //BC UPGRADE KUMARR78 >> Blocking DIT Field("Inventory Unit of Measure")
                    // if ShowqtyinInvUOM then begin
                    //     if Item."Inventory Unit of Measure" <> '' then
                    //         ItemUnitofMeasure.GET(Item."No.", Item."Inventory Unit of Measure");
                    // end;
                    //BC UPGRADE KUMARR78 ><< Blocking DIT Field("Inventory Unit of Measure")
                    QtyIn := 0;
                    QtyOut := 0;

                    //BC UPGRADE KUMARR78 >> Blocking DIT Field and Whole Condition to rewritte
                    // if ShowqtyinInvUOM then
                    //     if Item."Base Unit of Measure" = Item."Inventory Unit of Measure" then begin
                    //         if Quantity > 0 then
                    //             QtyIn := Quantity
                    //         else
                    //             QtyOut := -1 * Quantity;
                    //     end else begin
                    //         if Quantity > 0 then
                    //             QtyIn := Quantity / ItemUnitofMeasure."Qty. per Unit of Measure"
                    //         else
                    //             QtyOut := (-1 * Quantity) / ItemUnitofMeasure."Qty. per Unit of Measure";
                    //     end
                    // else begin
                    //     if Quantity > 0 then
                    //         QtyIn := Quantity
                    //     else
                    //         QtyOut := -1 * Quantity;
                    // end;
                    //BC UPGRADE KUMARR78 << Blocking DIT Field and Whole Condition to rewritte...

                    //BC UPGRADE KUMARR78 >> Rewritting Whole Above Conditon Due to Usage of DIT Field.
                    if ShowqtyinInvUOM then begin
                        if Quantity > 0 then
                            QtyIn := Quantity / ItemUnitofMeasure."Qty. per Unit of Measure"
                        else
                            QtyOut := (-1 * Quantity) / ItemUnitofMeasure."Qty. per Unit of Measure";
                    end else
                        if Quantity > 0 then
                            QtyIn := Quantity
                        else
                            QtyOut := -1 * Quantity;
                    //BC UPGRADE KUMARR78 << Rewritting Whole Above Conditon Due to Usage of DIT Field.

                    ExpiryDate := GetOutbountExpiryDate("Entry No.");

                    if Loc.Get(ItemLedgEntry."Location Code") then
                        LocName := Loc.Name;
                end;

                trigger OnPreDataItem();
                begin
                    if not ShowRR then
                        CurrReport.Break();
                    if LocationFilter <> '' then
                        SetFilter("Location Code", LocationFilter);
                    SetRange("Posting Date", FromDate, ToDate);
                    if ItemFilter <> '' then
                        SetFilter("Item No.", ItemFilter);
                    if ItemCategoryFilter <> '' then
                        SetFilter("Item Category Code", ItemCategoryFilter);
                    if BrandFilter <> '' then
                        SetFilter("Global Dimension 1 Code", BrandFilter);
                end;
            }
            dataitem("<Item Ledger Entry5>"; "Item Ledger Entry")
            {
                DataItemTableView = sorting("Entry Type", "Document Type", "Item No.", "Source No.", "Location Code", "Variant Code", "Posting Date") order(ascending) where("Entry Type" = const(Sale), "Document Type" = const("Sales Shipment"));
                column(ItemNo_ItemLedgerEntry_SH; "<Item Ledger Entry5>"."Item No.")
                {
                }
                column(Description_ItemLedgerEntry_SH; "<Item Ledger Entry5>".Description)
                {
                }
                column(LocationCode_ItemLedgerEntry_SH; "<Item Ledger Entry5>"."Location Code")
                {
                }
                column(LotNo_ItemLedgerEntry_SH; "<Item Ledger Entry5>"."Lot No.")
                {
                }
                column(Location_Name_SH; LocName)
                {
                }
                column(Expiry_SH; Format(ExpiryDate))
                {
                }
                column(QtyIN_SH; QtyIn)
                {
                }
                column(QtyOUT_SH; QtyOut)
                {
                }
                column(ShowSH; ShowSH)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    Item.Get("Item No.");
                    //BC UPGRADE KUMARR78 >> Blocking DIT Field("Inventory Unit of Measure")
                    // if ShowqtyinInvUOM then begin
                    //     if Item."Inventory Unit of Measure" <> '' then
                    //         ItemUnitofMeasure.GET(Item."No.", Item."Inventory Unit of Measure");
                    // end;

                    //BC UPGRADE KUMARR78 ><< Blocking DIT Field("Inventory Unit of Measure")
                    QtyIn := 0;
                    QtyOut := 0;

                    //BC UPGRADE KUMARR78 >> Blocking DIT Field and Whole Condition to rewritte
                    // if ShowqtyinInvUOM then
                    //     if Item."Base Unit of Measure" = Item."Inventory Unit of Measure" then begin
                    //         if Quantity > 0 then
                    //             QtyIn := Quantity
                    //         else
                    //             QtyOut := -1 * Quantity;
                    //     end else begin
                    //         if Quantity > 0 then
                    //             QtyIn := Quantity / ItemUnitofMeasure."Qty. per Unit of Measure"
                    //         else
                    //             QtyOut := (-1 * Quantity) / ItemUnitofMeasure."Qty. per Unit of Measure";
                    //     end
                    // else begin
                    //     if Quantity > 0 then
                    //         QtyIn := Quantity
                    //     else
                    //         QtyOut := -1 * Quantity;
                    // end;
                    //BC UPGRADE KUMARR78 << Blocking DIT Field and Whole Condition to rewritte...

                    //BC UPGRADE KUMARR78 >> Rewritting Whole Above Conditon Due to Usage of DIT Field.
                    if ShowqtyinInvUOM then begin
                        if Quantity > 0 then
                            QtyIn := Quantity / ItemUnitofMeasure."Qty. per Unit of Measure"
                        else
                            QtyOut := (-1 * Quantity) / ItemUnitofMeasure."Qty. per Unit of Measure";
                    end else
                        if Quantity > 0 then
                            QtyIn := Quantity
                        else
                            QtyOut := -1 * Quantity;
                    //BC UPGRADE KUMARR78 << Rewritting Whole Above Conditon Due to Usage of DIT Field.


                    ExpiryDate := GetOutbountExpiryDate("Entry No.");

                    if Loc.Get(ItemLedgEntry."Location Code") then
                        LocName := Loc.Name;
                end;

                trigger OnPreDataItem();
                begin
                    if not ShowSH then
                        CurrReport.Break();
                    if LocationFilter <> '' then
                        SetFilter("Location Code", LocationFilter);
                    SetRange("Posting Date", FromDate, ToDate);
                    if ItemFilter <> '' then
                        SetFilter("Item No.", ItemFilter);
                    if ItemCategoryFilter <> '' then
                        SetFilter("Item Category Code", ItemCategoryFilter);
                    if BrandFilter <> '' then
                        SetFilter("Global Dimension 1 Code", BrandFilter);
                end;
            }
            dataitem("<Item Ledger Entry6>"; "Item Ledger Entry")
            {
                DataItemTableView = sorting("Entry Type", "Document Type", "Item No.", "Source No.", "Location Code", "Variant Code", "Posting Date") order(ascending) where("Entry Type" = const(Transfer));
                column(ItemNo_ItemLedgerEntry_TR; "<Item Ledger Entry6>"."Item No.")
                {
                }
                column(Description_ItemLedgerEntry_TR; "<Item Ledger Entry6>".Description)
                {
                }
                column(LocationCode_ItemLedgerEntry_TR; "<Item Ledger Entry6>"."Location Code")
                {
                }
                column(LotNo_ItemLedgerEntry_TR; "<Item Ledger Entry6>"."Lot No.")
                {
                }
                column(Location_Name_TR; LocName)
                {
                }
                column(Expiry_TR; Format(ExpiryDate))
                {
                }
                column(QtyIN_TR; QtyIn)
                {
                }
                column(QtyOUT_TR; QtyOut)
                {
                }
                column(ShowTR; ShowTR)
                {
                }
                column(ShowInTransitLocation; ShowInTransitLocation)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    if not ShowInTransitLocation then
                        if Loc.Get("Location Code") then
                            if Loc."Use As In-Transit" then
                                CurrReport.Skip();

                    Item.Get("Item No.");
                    //BC UPGRADE KUMARR78 >> Blocking DIT Field("Inventory Unit of Measure")
                    // if ShowqtyinInvUOM then begin
                    //     if Item."Inventory Unit of Measure" <> '' then
                    //         ItemUnitofMeasure.GET(Item."No.", Item."Inventory Unit of Measure");
                    // end;
                    //BC UPGRADE KUMARR78 ><< Blocking DIT Field("Inventory Unit of Measure")

                    QtyIn := 0;
                    QtyOut := 0;

                    //BC UPGRADE KUMARR78 >> Blocking DIT Field and Whole Condition to rewritte
                    // if ShowqtyinInvUOM then
                    //     if Item."Base Unit of Measure" = Item."Inventory Unit of Measure" then begin
                    //         if Quantity > 0 then
                    //             QtyIn := Quantity
                    //         else
                    //             QtyOut := -1 * Quantity;
                    //     end else begin
                    //         if Quantity > 0 then
                    //             QtyIn := Quantity / ItemUnitofMeasure."Qty. per Unit of Measure"
                    //         else
                    //             QtyOut := (-1 * Quantity) / ItemUnitofMeasure."Qty. per Unit of Measure";
                    //     end
                    // else begin
                    //     if Quantity > 0 then
                    //         QtyIn := Quantity
                    //     else
                    //         QtyOut := -1 * Quantity;
                    // end;
                    //BC UPGRADE KUMARR78 << Blocking DIT Field and Whole Condition to rewritte...

                    //BC UPGRADE KUMARR78 >> Rewritting Whole Above Conditon Due to Usage of DIT Field.
                    if ShowqtyinInvUOM then begin
                        if Quantity > 0 then
                            QtyIn := Quantity / ItemUnitofMeasure."Qty. per Unit of Measure"
                        else
                            QtyOut := (-1 * Quantity) / ItemUnitofMeasure."Qty. per Unit of Measure";
                    end else
                        if Quantity > 0 then
                            QtyIn := Quantity
                        else
                            QtyOut := -1 * Quantity;
                    //BC UPGRADE KUMARR78 << Rewritting Whole Above Conditon Due to Usage of DIT Field.


                    ExpiryDate := GetOutbountExpiryDate("Entry No.");

                    if Loc.Get(ItemLedgEntry."Location Code") then
                        LocName := Loc.Name;
                end;

                trigger OnPreDataItem();
                begin
                    if not ShowTR then
                        CurrReport.Break();
                    if LocationFilter <> '' then
                        SetFilter("Location Code", LocationFilter);
                    SetRange("Posting Date", FromDate, ToDate);
                    if ItemFilter <> '' then
                        SetFilter("Item No.", ItemFilter);
                    if ItemCategoryFilter <> '' then
                        SetFilter("Item Category Code", ItemCategoryFilter);
                    if BrandFilter <> '' then
                        SetFilter("Global Dimension 1 Code", BrandFilter);
                end;
            }

            trigger OnAfterGetRecord();
            begin

                ShowPR1 := Format(ShowPR);
                ShowPS1 := Format(ShowPS);
                ShowOutput1 := Format(ShowOutput);
                ShowConsumption1 := Format(ShowConsumption);
                ShowRR1 := Format(ShowRR);
                ShowSH1 := Format(ShowSH);
                ShowTR1 := Format(ShowTR);
                ShowInTransitLocation1 := Format(ShowInTransitLocation);
                ShowqtyinInvUOM1 := Format(ShowqtyinInvUOM);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                field("From Date"; FromDate)
                {
                    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea
                }
                field("To Date"; ToDate)
                {
                    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea
                }
                field("Location Filter"; LocationFilter)
                {
                    TableRelation = Location;
                    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea
                }
                field("Item Category Filter"; ItemCategoryFilter)
                {
                    TableRelation = "Item Category";
                    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea
                }
                field("Item Filter"; ItemFilter)
                {
                    TableRelation = Item;
                    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea
                }
                field("Brand Filter"; BrandFilter)
                {
                    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea
                    trigger OnLookup(var Text: Text): Boolean;
                    var
                        DimensionValues: Page "Dimension Values";
                    begin
                        Clear(DimensionValues);
                        Clear(Text);
                        DimensionValues.LookupMode := true;
                        DimensionValue.SetRange("Global Dimension No.", 1);
                        DimensionValues.SetTableView(DimensionValue);
                        if DimensionValues.RunModal() = Action::LookupOK then begin
                            if Text <> '' then
                                Text := Text + '|';
                            Text := Text + DimensionValues.GetSelectionFilter();
                            BrandFilter := Text;
                        end;
                        Clear(DimensionValues);
                    end;
                }
                field("Show Purchase Receipt"; ShowPR)
                {
                    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea
                }
                field("Show Return Shipment"; ShowPS)
                {
                    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea
                }
                field("Show OutPut Entries"; ShowOutput)
                {
                    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea
                }
                field("Show Consumption Entries"; ShowConsumption)
                {
                    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea
                }
                field("Show Return Receipt Entries"; ShowRR)
                {
                    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea
                }
                field("Show Sales Shipment Entries"; ShowSH)
                {
                    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea
                }
                field("Show Transfer Entries"; ShowTR)
                {
                    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea
                }
                field("Show In-Transit Location"; ShowInTransitLocation)
                {
                    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea
                }
                field("Show Qty. in Inventory UOM"; ShowqtyinInvUOM)
                {
                    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        lblHeader = 'IN/OUT Movement By Reason (Summary)'; lblQtyinInventoryUOM = 'Qty. in Inventory UOM'; lblBrandFilter = 'Brand Filter';
    }

    trigger OnInitReport();
    begin
        CompInfo.Get();
    end;

    trigger OnPreReport();
    begin
        if (FromDate = 0D) or (ToDate = 0D) then
            Error('You must fill From Date & To Date first.')
    end;

    var
        CompInfo: Record "Company Information";
        DimensionValue: Record "Dimension Value";
        Item: Record Item;
        ItemApplicationEntry: Record "Item Application Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        Loc: Record Location;
        ShowConsumption: Boolean;
        ShowInTransitLocation: Boolean;
        ShowOutput: Boolean;
        ShowPR: Boolean;
        ShowPS: Boolean;
        ShowqtyinInvUOM: Boolean;
        ShowRR: Boolean;
        ShowSH: Boolean;
        ShowTR: Boolean;
        ItemCategoryFilter: Code[30];
        ItemFilter: Code[30];
        LocationFilter: Code[30];
        BrandFilter: Code[250];
        ExpiryDate: Date;
        FromDate: Date;
        ToDate: Date;
        QtyIn: Decimal;
        QtyOut: Decimal;
        ShowConsumption1: Text[10];
        ShowInTransitLocation1: Text[10];
        ShowOutput1: Text[10];
        ShowPR1: Text[10];
        ShowPS1: Text[10];
        ShowqtyinInvUOM1: Text[10];
        ShowRR1: Text[10];
        ShowSH1: Text[10];
        ShowTR1: Text[10];
        LocName: Text[100];

    procedure GetOutbountExpiryDate(EntryNo: Integer): Date;
    begin
        ItemApplicationEntry.Reset();
        ItemApplicationEntry.SetCurrentKey("Item Ledger Entry No.");
        ItemApplicationEntry.SetRange("Item Ledger Entry No.", EntryNo);
        if ItemApplicationEntry.FindFirst() then begin
            if ItemLedgEntry.Get(ItemApplicationEntry."Inbound Item Entry No.") then
                exit(ItemLedgEntry."Expiration Date")
            else
                exit(0D);
        end;
    end;
}

