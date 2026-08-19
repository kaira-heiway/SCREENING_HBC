codeunit 54015 "Calculate Bom Tree DTW"
{
    //BC Upgrade GUNREM01 created new codeunit for standard cost  FDD DTW 16

    procedure SetRunParam(RunFromSKU: Boolean)

    begin
        RunFromStockKeepingUnit := RunFromSKU;
    end;

    procedure GenerateTreeForItems(VAR ParentItem: Record Item; VAR BOMBuffer: Record "BOM Buffer"; TreeType: Option " ",Availability,Cost; LocationCode: Code[20]; VariantCode: Code[20])
    var
        ItemFilter: Record Item;
        //StockkeepingUnit: Record "Stockkeeping Unit";'
        Item: Record Item;
        HeinkinBCUpgrade: Codeunit "Heineken BC Upgrade";
        DemandDate: Date;
        HeinekenCustFunctions: Codeunit "Heineken BC Custom Functions";
    begin
        //HEI.01>>
        Item.GET(ParentItem."No.");//HEI.01
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
        // WITH ParentItem DO BEGIN
        //     ItemFilter.COPY(ParentItem);

        //     GET("No.");
        //     InitBOMBuffer(BOMBuffer);
        //     InitTreeType(TreeType);

        //     //"Replenishment System" := "Replenishment System"::"Prod. Order";//HEI.01
        //     "Replenishment System" := StockkeepingUnit."Replenishment System";//HEI.01
        //     IF "Replenishment System" = "Replenishment System"::"Prod. Order" THEN BEGIN
        //         "Production BOM No." := StockkeepingUnit."Production BOM No.";
        //         "Routing No." := StockkeepingUnit."Routing No.";
        //     end;
        //     HeinkinBCUpgrade.GenerateTreeForItemSKULocal(ParentItem, BOMBuffer, DemandDate, TreeType, StockkeepingUnit);
        //     COPY(ItemFilter);
        // end;
        ItemFilter.COPY(ParentItem);

        ParentItem.GET(ParentItem."No.");
        InitBOMBuffer(BOMBuffer);
        InitTreeType(TreeType);

        //"Replenishment System" := "Replenishment System"::"Prod. Order";//HEI.01
        ParentItem."Replenishment System" := Item."Replenishment System";//HEI.01
        IF ParentItem."Replenishment System" = "Replenishment System"::"Prod. Order" THEN BEGIN
            ParentItem."Production BOM No." := Item."Production BOM No.";
            ParentItem."Routing No." := Item."Routing No.";
        end;
        GenerateTreeForItemSKULocal(ParentItem, BOMBuffer, DemandDate, TreeType, Item);
        ParentItem.COPY(ItemFilter);
        // BC Upgrade PATELP08 <<
    end;

    local procedure InitBOMBuffer(var BOMBuffer: Record "BOM Buffer")
    begin
        //  Clear(BOMBuffer);
        BOMBuffer.Reset();
        BOMBuffer.DeleteAll();
    end;

    local procedure InitTreeType(NewTreeType: Option)
    begin
        TreeType := NewTreeType;
    end;

    procedure GenerateTreeForItemSKULocal(VAR ParentItem: Record Item; VAR BOMBuffer: Record "BOM Buffer"; DemandDate: Date; TreeType: Option; item: Record Item)
    var
        BOMComp: Record "BOM Component";
        ProdBOMLine: Record "Production BOM Line";
        ItemFilter: Record Item;
        EntryNo: Integer;
        ShowTotalAvailability: Boolean;
        HeinkinBCUpgrade: Codeunit "Heineken BC Custom Functions";
    begin
        //InitVars;
        BOMComp.SETRANGE(Type, BOMComp.Type::Item);
        BOMComp.SETRANGE("No.", ParentItem."No.");

        ProdBOMLine.SETRANGE(Type, ProdBOMLine.Type::Item);
        ProdBOMLine.SETRANGE("No.", ParentItem."No.");

        IF item.HasBOM() OR (item."Routing No." <> '') THEN BEGIN
            BOMBuffer.SetLocationVariantFiltersFrom(ParentItem);
            SetRunParam(item, TRUE);
            //HEI.03>>
            BOMBuffer.ActivateBlankVersionCode(ForBlankVersionCode);
            //HEI.03<<
            BOMBuffer.TransferFromItem(EntryNo, ParentItem, DemandDate);
            GenerateItemSubTreeSKU(ParentItem."No.", BOMBuffer, item);
            HeinkinBCUpgrade.CalculateTreeType(BOMBuffer, ShowTotalAvailability, TreeType);
        END;
    end;

    procedure SetRunParam(item: Record Item; RumFromStockKeeping: Boolean)
    begin
        //HEI.01
        RunFromStockKeepingUnit := RumFromStockKeeping;
        Item2 := item;
    end;

    procedure GenerateItemSubTreeSKU(ItemNo: Code[20]; VAR BOMBuffer: Record "BOM Buffer"; item: Record Item): Boolean
    var
        ParentItem: Record Item;
        TempItem: Record Item temporary;
        HeinkinBCFunctionCU: Codeunit "Heineken BC Custom Functions";
    begin
        //HEI.01>>
        Item2 := item;
        ParentItem.GET(ItemNo);
        //ParentItem."Replenishment System" := ParentItem."Replenishment System"::"Prod. Order";
        ParentItem."Replenishment System" := Item2."Replenishment System";

        IF ParentItem."Replenishment System" = ParentItem."Replenishment System"::"Prod. Order" THEN BEGIN
            ParentItem."Production BOM No." := Item2."Production BOM No.";
            ParentItem."Routing No." := Item2."Routing No.";
        END;
        IF TempItem.GET(ItemNo) THEN BEGIN
            BOMBuffer."Is Leaf" := FALSE;
            BOMBuffer.MODIFY(TRUE);
            EXIT(FALSE);
        END;
        TempItem := ParentItem;
        TempItem.INSERT();

        IF ParentItem."Replenishment System" = ParentItem."Replenishment System"::"Prod. Order" THEN BEGIN
            BOMBuffer."Is Leaf" := NOT GenerateProdCompSubTree(ParentItem, BOMBuffer);
            IF BOMBuffer."Is Leaf" THEN
                BOMBuffer."Is Leaf" := NOT GenerateBOMCompSubTree(ParentItem, BOMBuffer);
        END ELSE BEGIN
            BOMBuffer."Is Leaf" := NOT GenerateBOMCompSubTree(ParentItem, BOMBuffer);
            IF BOMBuffer."Is Leaf" THEN
                BOMBuffer."Is Leaf" := NOT GenerateProdCompSubTree(ParentItem, BOMBuffer);
        END;
        BOMBuffer.MODIFY(TRUE);

        TempItem.GET(ItemNo);
        TempItem.DELETE();
        EXIT(NOT BOMBuffer."Is Leaf");
    end;

    procedure GenerateProdCompSubTree(ParentItem: Record Item; var BOMBuffer: Record "BOM Buffer") FoundSubTree: Boolean
    var
        ParentBOMBuffer: Record "BOM Buffer";
        CopyOfParentItem: Record Item;
        ItemFilter: Record Item;
        ProdBOMLine: Record "Production BOM Line";
        RoutingLine: Record "Routing Line";
        BCUpgradeCU: Codeunit "Heineken BC Upgrade";
        MfgCostCalcMgt: Codeunit "Mfg. Cost Calculation Mgt.";
        UOMMgt: Codeunit "Unit of Measure Management";
        VersionMgt: Codeunit VersionManagement;
        IsHandled: Boolean;
        RunIteration: Boolean;
        BomQtyPerUom: Decimal;
        LotSize: Decimal;
        EntryNo: Integer;
        TreeType: Option " ",Availability,Cost;
        HeinekenBCFunctionCU: Codeunit "Heineken BC Custom Functions";
        ManufacturingSetup: Record "Manufacturing Setup";
    begin
        //GUNREM01 >>
        //   Clear(EntryNo);
        //GUNREM01 <<
        ParentBOMBuffer := BOMBuffer;

        if not ProdBOMLine.ReadPermission then
            exit;
        ProdBOMLine.SetRange("Production BOM No.", ParentItem."Production BOM No.");
        // ProdBOMLine.SetRange("Version Code", VersionMgt.GetBOMVersion(ParentItem."Production BOM No.", WorkDate(), true));//BC Upgrade Kamnay01 Std cost correction 07-05-2026
        ProdBOMLine.SetRange("Version Code", ''); //BC Upgrade Kamnay01 Std cost correction 07-05-2026
        ProdBOMLine.SetFilter("Starting Date", '%1|..%2', 0D, ParentBOMBuffer."Needed by Date");
        ProdBOMLine.SetFilter("Ending Date", '%1|%2..', 0D, ParentBOMBuffer."Needed by Date");
        IsHandled := false;
        // OnBeforeFilterByQuantityPer(ProdBOMLine, IsHandled, ParentBOMBuffer);
        if not IsHandled then
            if TreeType = TreeType::Availability then
                ProdBOMLine.SetFilter("Quantity per", '>%1', 0);
        if ProdBOMLine.FindSet() then begin
            if ParentItem."Replenishment System" <> ParentItem."Replenishment System"::"Prod. Order" then begin
                FoundSubTree := true;
                //OnGenerateProdCompSubTreeOnBeforeExitForNonProdOrder(ParentItem, BOMBuffer, FoundSubTree);
                //exit(FoundSubTree);
            end;
            repeat
                IsHandled := false;
                //  OnBeforeTransferProdBOMLine(BOMBuffer, ProdBOMLine, ParentItem, ParentBOMBuffer, EntryNo, TreeType, IsHandled);
                if not IsHandled then
                    if ProdBOMLine."No." <> '' then
                        case ProdBOMLine.Type of
                            ProdBOMLine.Type::Item:
                                begin
                                    BOMBuffer.SetLocationVariantFiltersFrom(ItemFilter);
                                    BomQtyPerUom :=
                                    BCUpgradeCU.GetQtyPerBOMHeaderUnitOfMeasure(
                                        ParentItem, ParentBOMBuffer."Production BOM No.",
                                        // VersionMgt.GetBOMVersion(ParentBOMBuffer."Production BOM No.", WorkDate(), true));
                                        ''); //BC Upgrade Kamnay01 Std cost correction 07-05-2026
                                    //GUNREM01 >>
                                    EntryNo := GetNextEntryNo(BOMBuffer);
                                    //GUNREM01 <<
                                    //BC Upgrade Kamnay01 >> STD cost fix   ManufacturingSetup."Std Cost Version" field is created to control version code 
                                    ManufacturingSetup.Get();
                                    ManufacturingSetup."Std Cost Version FND" := true;
                                    ManufacturingSetup.Modify(false);
                                    //BC Upgrade Kamnay01 << STD cost fix 
                                    BOMBuffer.TransferFromProdComp(
                                    EntryNo, ProdBOMLine, ParentBOMBuffer.Indentation + 1,
                                    Round(
                                        ParentBOMBuffer."Qty. per Top Item" *
                                        UOMMgt.GetQtyPerUnitOfMeasure(ParentItem, ParentBOMBuffer."Unit of Measure Code"), UOMMgt.QtyRndPrecision()),
                                    Round(
                                        ParentBOMBuffer."Scrap Qty. per Top Item" *
                                        UOMMgt.GetQtyPerUnitOfMeasure(ParentItem, ParentBOMBuffer."Unit of Measure Code"), UOMMgt.QtyRndPrecision()),
                                    ParentBOMBuffer."Scrap %",
                                HeinekenBCFunctionCU.CalcCompDueDate(ParentBOMBuffer."Needed by Date", ParentItem, ProdBOMLine."Lead-Time Offset"),
                                    ParentBOMBuffer."Location Code",
                                    ParentItem, BomQtyPerUom);

                                    if ParentItem."Production BOM No." <> ParentBOMBuffer."Production BOM No." then begin
                                        BOMBuffer."Qty. per Parent" := BOMBuffer."Qty. per Parent" * ParentBOMBuffer."Qty. per Parent";
                                        BOMBuffer."Scrap Qty. per Parent" := BOMBuffer."Scrap Qty. per Parent" * ParentBOMBuffer."Qty. per Parent";
                                        BOMBuffer."Qty. per BOM Line" := BOMBuffer."Qty. per BOM Line" * ParentBOMBuffer."Qty. per Parent";
                                    end;
                                    // OnAfterTransferFromProdItem(BOMBuffer, ProdBOMLine, EntryNo);
                                    GenerateItemSubTree(ProdBOMLine."No.", BOMBuffer);
                                    //OnGenerateProdCompSubTreeOnAfterGenerateItemSubTree(ParentBOMBuffer, BOMBuffer);
                                end;
                            ProdBOMLine.Type::"Production BOM":
                                begin
                                    // OnBeforeTransferFromProdBOM(BOMBuffer, ProdBOMLine, ParentItem, ParentBOMBuffer, EntryNo, TreeType);

                                    BOMBuffer := ParentBOMBuffer;

                                    BOMBuffer."Qty. per Top Item" := Round(BOMBuffer."Qty. per Top Item" * ProdBOMLine."Quantity per", UOMMgt.QtyRndPrecision());
                                    if ParentItem."Production BOM No." <> ParentBOMBuffer."Production BOM No." then
                                        BOMBuffer."Qty. per Parent" := ParentBOMBuffer."Qty. per Parent" * ProdBOMLine."Quantity per"
                                    else
                                        BOMBuffer."Qty. per Parent" := ProdBOMLine."Quantity per";

                                    BOMBuffer."Scrap %" := HeinekenBCFunctionCU.CombineScrapFactors(BOMBuffer."Scrap %", ProdBOMLine."Scrap %");
                                    if MfgCostCalcMgt.FindRoutingLine(RoutingLine, ProdBOMLine, WorkDate(), ParentItem."Routing No.") then
                                        BOMBuffer."Scrap %" := HeinekenBCFunctionCU.CombineScrapFactors(BOMBuffer."Scrap %", RoutingLine."Scrap Factor % (Accumulated)" * 100);
                                    BOMBuffer."Scrap %" := Round(BOMBuffer."Scrap %", 0.00001);

                                    // OnAfterTransferFromProdBOM(BOMBuffer, ProdBOMLine);

                                    CopyOfParentItem := ParentItem;
                                    ParentItem."Routing No." := '';
                                    ParentItem."Production BOM No." := ProdBOMLine."No.";
                                    GenerateProdCompSubTree(ParentItem, BOMBuffer);
                                    ParentItem := CopyOfParentItem;

                                    // OnAfterGenerateProdCompSubTree(ParentItem, BOMBuffer, ParentBOMBuffer);
                                end;
                        end;
            // OnGenerateProdCompSubTreeOnAfterProdBOMLineLoop(ParentBOMBuffer, BOMBuffer);
            until ProdBOMLine.Next() = 0;
            FoundSubTree := true;
        end;

        if RoutingLine.ReadPermission then
            if (TreeType in [TreeType::" ", TreeType::Cost]) and
                   RoutingLine.CertifiedRoutingVersionExists(ParentItem."Routing No.", WorkDate())
            then begin
                repeat
                    RunIteration := RoutingLine."No." <> '';
                    // OnGenerateProdCompSubTreeOnBeforeRoutingLineLoop(RoutingLine, BOMBuffer, RunIteration);
                    if RunIteration then begin
                        BOMBuffer.SetLocationVariantFiltersFrom(ItemFilter);
                        //GUNREM01 >>
                        EntryNo := GetNextEntryNo(BOMBuffer);
                        //GUNREM01 <<
                        BOMBuffer.TransferFromProdRouting(
                          EntryNo, RoutingLine, ParentBOMBuffer.Indentation + 1,
                          ParentBOMBuffer."Qty. per Top Item" *
                          UOMMgt.GetQtyPerUnitOfMeasure(ParentItem, ParentBOMBuffer."Unit of Measure Code"),
                          ParentBOMBuffer."Needed by Date",
                          ParentBOMBuffer."Location Code");
                        //  OnAfterTransferFromProdRouting(BOMBuffer, RoutingLine);
                        if TreeType = TreeType::Cost then begin
                            LotSize := ParentBOMBuffer."Lot Size";
                            if LotSize = 0 then
                                if ParentBOMBuffer."Qty. per Top Item" <> 0 then
                                    LotSize := ParentBOMBuffer."Qty. per Top Item"
                                else
                                    LotSize := 1;
                            CalcRoutingLineCosts(RoutingLine, LotSize, ParentBOMBuffer."Scrap %", BOMBuffer, ParentItem);
                            BOMBuffer.RoundCosts(
                              ParentBOMBuffer."Qty. per Top Item" *
                              UOMMgt.GetQtyPerUnitOfMeasure(ParentItem, ParentBOMBuffer."Unit of Measure Code") / LotSize);
                            // OnGenerateProdCompSubTreeOnBeforeBOMBufferModify(BOMBuffer, ParentBOMBuffer, ParentItem);
                            BOMBuffer.Modify();
                        end;
                        // OnGenerateProdCompSubTreeOnAfterBOMBufferModify(BOMBuffer, RoutingLine, LotSize, ParentItem, ParentBOMBuffer, TreeType);
                    end;
                until RoutingLine.Next() = 0;
                FoundSubTree := true;
            end;

        BOMBuffer := ParentBOMBuffer;
    end;

    local procedure CalcRoutingLineCosts(RoutingLine: Record "Routing Line"; LotSize: Decimal; ScrapPct: Decimal; var BOMBuffer: Record "BOM Buffer"; ParentItem: Record Item)
    var
        CalcStdCost: Codeunit "Calculate Standard Cost";
        MfgCostCalcMgt: Codeunit "Mfg. Cost Calculation Mgt.";
        CapCost: Decimal;
        CapOverhead: Decimal;
        SubcontractedCapCost: Decimal;
    begin
        //OnBeforeCalcRoutingLineCosts(RoutingLine, LotSize, ScrapPct, ParentItem);

        CalcStdCost.SetProperties(WorkDate(), false, false, false, '', false);
        CalcStdCost.CalcRtngLineCost(
          RoutingLine, MfgCostCalcMgt.CalcQtyAdjdForBOMScrap(LotSize, ScrapPct), CapCost, SubcontractedCapCost, CapOverhead);

        //OnCalcRoutingLineCostsOnBeforeBOMBufferAdd(RoutingLine, LotSize, ScrapPct, CapCost, SubcontractedCapCost, CapOverhead, BOMBuffer);

        BOMBuffer.AddCapacityCost(CapCost, CapCost);
        BOMBuffer.AddSubcontrdCost(SubcontractedCapCost, SubcontractedCapCost);
        BOMBuffer.AddCapOvhdCost(CapOverhead, CapOverhead);
    end;

    procedure GenerateBOMCompSubTree(ParentItem: Record Item; var BOMBuffer: Record "BOM Buffer"): Boolean
    var
        ParentBOMBuffer: Record "BOM Buffer";
        BOMComp: Record "BOM Component";
        ItemFilter: Record Item;
        UOMMgt: Codeunit "Unit of Measure Management";
        IsHandled: Boolean;
        EntryNo: Integer;
        TreeType: Option " ",Availability,Cost;
        HeinekenBCFunctionCU: Codeunit "Heineken BC Custom Functions";
    begin
        //GUNREM01 >>
        //  Clear(EntryNo);
        //GUNREM01 <<
        ParentBOMBuffer := BOMBuffer;
        BOMComp.SetRange("Parent Item No.", ParentItem."No.");
        if BOMComp.FindSet() then begin
            if ParentItem."Replenishment System" <> ParentItem."Replenishment System"::Assembly then
                exit(true);

            IsHandled := false;
            //   OnGenerateBOMCompSubTreeOnBeforeLoopBOMComponents(ParentItem, IsHandled);
            if IsHandled then
                exit(true);
            repeat
                if (BOMComp."No." <> '') and ((BOMComp.Type = BOMComp.Type::Item) or (TreeType in [TreeType::" ", TreeType::Cost])) then begin
                    BOMBuffer.SetLocationVariantFiltersFrom(ItemFilter);
                    //GUNREM01 >>
                    EntryNo := GetNextEntryNo(BOMBuffer);
                    //GUNREM01 <<
                    BOMBuffer.TransferFromBOMComp(
                      EntryNo, BOMComp, ParentBOMBuffer.Indentation + 1,
                      Round(
                        ParentBOMBuffer."Qty. per Top Item" *
                        UOMMgt.GetQtyPerUnitOfMeasure(ParentItem, ParentBOMBuffer."Unit of Measure Code"), UOMMgt.QtyRndPrecision()),
                      Round(
                        ParentBOMBuffer."Scrap Qty. per Top Item" *
                        UOMMgt.GetQtyPerUnitOfMeasure(ParentItem, ParentBOMBuffer."Unit of Measure Code"), UOMMgt.QtyRndPrecision()),
                    HeinekenBCFunctionCU.CalcCompDueDate(ParentBOMBuffer."Needed by Date", ParentItem, BOMComp."Lead-Time Offset"),
                      ParentBOMBuffer."Location Code");
                    if BOMComp.Type = BOMComp.Type::Item then
                        GenerateItemSubTree(BOMComp."No.", BOMBuffer);
                end;
            until BOMComp.Next() = 0;
            BOMBuffer := ParentBOMBuffer;
            exit(true);
        end;
    end;

    procedure GenerateItemSubTree(ItemNo: Code[20]; var BOMBuffer: Record "BOM Buffer"): Boolean
    var
        ParentItem: Record Item;
        TempItem: Record Item temporary;
    begin
        ParentItem.Get(ItemNo);
        //OnGenerateItemSubTreeOnAfterParentItemGet(ParentItem);
        if TempItem.Get(ItemNo) then begin
            BOMBuffer."Is Leaf" := false;
            BOMBuffer.Modify(true);
            exit(false);
        end;
        TempItem := ParentItem;
        TempItem.Insert();

        if ParentItem."Replenishment System" = ParentItem."Replenishment System"::"Prod. Order" then begin
            BOMBuffer."Is Leaf" := not GenerateProdCompSubTree(ParentItem, BOMBuffer);
            if BOMBuffer."Is Leaf" then
                BOMBuffer."Is Leaf" := not GenerateBOMCompSubTree(ParentItem, BOMBuffer);
        end else begin
            BOMBuffer."Is Leaf" := not GenerateBOMCompSubTree(ParentItem, BOMBuffer);
            if BOMBuffer."Is Leaf" then
                BOMBuffer."Is Leaf" := not GenerateProdCompSubTree(ParentItem, BOMBuffer);
        end;
        BOMBuffer.Modify(true);

        TempItem.Get(ItemNo);
        TempItem.Delete();
        exit(not BOMBuffer."Is Leaf");
    end;

    local procedure GetNextEntryNo(var BOMBuffer: Record "BOM Buffer"): Integer
    begin
        if BOMBuffer.FindLast() then
            exit(BOMBuffer."Entry No." + 1)
        else
            exit(1);
    end;

    var
        TreeType: Option " ",Availability,Cost;
        RunFromStockKeepingUnit: Boolean;
        Item2: Record Item;
        ForBlankVersionCode: Boolean;
}
