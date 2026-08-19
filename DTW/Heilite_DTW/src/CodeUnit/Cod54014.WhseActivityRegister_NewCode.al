codeunit 54014 WhseActivityRegister_NewCode
{
    // # BC Upgrade - RD03 ------
    // Why NewCode function Migrated to BC, why it does not handled through Eventsubscribers, along with NewCode function 37 standard functions are copied to BC
    // In NAV Lines will not get deleted when posting shipment, but in BC it is getting deleted instead of posting shipment
    // In NAV we customized warehouse entries insertion, Shipment 1 Entry, to Intransit 1 Entry, From Intransit 1 Entry, to Receipt 1 Entry
    // In BC by standard system is creating overall 2 Entries, one for shipment and another for Receipt
    // we were not able to accomplish the above changes by subscribing events in BC.
    // since the above mentioned changes are the core changes to the process, in order to make the process work, we copied and created a new codeunit.

    Permissions = tabledata "Registered Invt. Movement Hdr." = rimd,
    tabledata "Registered Whse. Activity Hdr." = rimd,
    tabledata "Registered Invt. Movement Line" = rimd,
    tabledata "Registered Whse. Activity Line" = rimd,
    tabledata "Warehouse Entry" = rimd;
    procedure Execute(var WhseActivLine: Record "Warehouse Activity Line")
    var
        OldWhseActivLine: Record "Warehouse Activity Line";
        WhseActivHeader: Record "Warehouse Activity Header";
        TempWhseActivLineToReserve: Record "Warehouse Activity Line" temporary;
        QtyDiff: Decimal;
        QtyBaseDiff: Decimal;
        LastLine: Boolean;
        //OWMPostingUtils: Codeunit "N-owm Posting Utils";
        QtyTransit: Decimal;
        QtyTransitBase: Decimal;
        WhseActivityReg: Codeunit "Whse.-Activity-Register";
        TempWhseActivityLineGrouped: Record "Warehouse Activity Line" temporary;
        TempReservEntryBeforeSync: Record "Reservation Entry" temporary;
        TempReservEntryAfterSync: Record "Reservation Entry" temporary;
        WhseJnlRegisterLine: Codeunit "Whse. Jnl.-Register Line";
    begin
        //HEI.01 PRDGAP024>>
        //WhseActivHeader.Reset();
        WhseActivHeader.SetRange("No.", WhseActivLine."No.");
        WhseActivHeader.SetRange(Type, WhseActivLine."Activity Type");
        if WhseActivHeader.FindFirst() then begin
            WhseActivLine.SETFILTER("Qty. to Handle (Base)", '<>0');
            WhseActivHeader.TESTFIELD("Posting Type FND");
            IF WhseActivHeader."Posting Type FND" = WhseActivHeader."Posting Type FND"::Ship THEN
                WhseActivLine.SETRANGE("Action Type", WhseActivLine."Action Type"::Take);
            IF WhseActivHeader."Posting Type FND" = WhseActivHeader."Posting Type FND"::Receive THEN
                WhseActivLine.SETRANGE("Action Type", WhseActivLine."Action Type"::Place);
            IF NOT GUIALLOWED THEN BEGIN
                IF NOT WhseActivLine.FIND('-') THEN
                    EXIT;
            END
            ELSE
                IF NOT WhseActivLine.FIND('-') THEN
                    ERROR(Text003);
            WhseActivityReg.CheckWhseItemTrkgLine(WhseActivLine);
            WhseActivityReg.LocationGet(WhseActivHeader."Location Code");
            UpdateWindow(1, WhseActivHeader."No.");
            // Check Lines
            CheckLines(WhseActivHeader, WhseActivLine);
            // Register lines
            SourceCodeSetup.GET;
            LineCount := 0;
            WhseActivLine.LOCKTABLE;
            IF WhseActivLine.FIND('-') THEN BEGIN
                CreateRegActivHeader(WhseActivHeader);
                REPEAT
                    LineCount := LineCount + 1;
                    UpdateWindow(3, '');
                    UpdateWindow(4, '');
                    RegisterWhseJnlLine(WhseActivLine);
                    CreateRegActivLine(WhseActivLine);
                UNTIL WhseActivLine.NEXT = 0;
            END;

            TempWhseActivLineToReserve.DELETEALL;
            IF WhseActivLine.FIND('-') THEN
                REPEAT
                    CopyWhseActivityLineToReservBuf(TempWhseActivLineToReserve, WhseActivLine);
                    WhseActivHeader.TESTFIELD(Type, WhseActivHeader.Type::Movement);
                    QtyDiff := WhseActivLine."Qty. Outstanding" - WhseActivLine."Qty. to Handle";
                    QtyBaseDiff := WhseActivLine."Qty. Outstanding (Base)" - WhseActivLine."Qty. to Handle (Base)";
                    WhseActivLine.VALIDATE("Qty. Outstanding", QtyDiff);
                    IF WhseActivLine."Qty. Outstanding (Base)" > QtyBaseDiff THEN // round off error- qty same, not base qty
                        WhseActivLine."Qty. Outstanding (Base)" := QtyBaseDiff;
                    WhseActivLine.VALIDATE("Qty. to Handle", QtyDiff);
                    IF WhseActivLine."Qty. to Handle (Base)" > QtyBaseDiff THEN // round off error- qty same, not base qty
                        WhseActivLine."Qty. to Handle (Base)" := QtyBaseDiff;
                    WhseActivLine.VALIDATE("Qty. to Handle", 0);
                    WhseActivLine.VALIDATE(
                      "Qty. Handled", WhseActivLine.Quantity - WhseActivLine."Qty. Outstanding");
                    //HEI.01 PRDGAP024>>
                    IF WhseActivLine."Action Type" = WhseActivLine."Action Type"::Take THEN
                        WhseActivLine."Quantity Shipped FND" := WhseActivLine."Qty. Handled";
                    IF WhseActivLine."Action Type" = WhseActivLine."Action Type"::Place THEN
                        WhseActivLine."Quantity Received FND" := WhseActivLine."Qty. Handled";
                    //HEI.01 PRDGAP024<<
                    WhseActivLine.MODIFY;

                    OldWhseActivLine := WhseActivLine;
                    LastLine := WhseActivLine.NEXT = 0;

                    IF OldWhseActivLine."Action Type" = OldWhseActivLine."Action Type"::Take THEN
                        TempWhseActivityLineGrouped.DeleteBinContent(Enum::"Warehouse Action Type"::Take.AsInteger());
                UNTIL LastLine;
            ItemTrackingMgt.SetPick(OldWhseActivLine."Activity Type" = OldWhseActivLine."Activity Type"::Pick);
            // BC Upgrade - RD03 DITW and SSCC Dependent Code are Blocked --------- >>
            /*IF NOT GUIALLOWED THEN BEGIN
                ItemTrackingMgt.SynchronizeWhseItemTracking2(TempTrackingSpecification, RegisteredWhseActivLine."No.");
                //IF TempScTrackingSpecification.READPERMISSION THEN BEGIN  //commented by HEI.09
                IF TempScTrackingSpecification.READPERMISSION AND SSCCSetup.READPERMISSION THEN BEGIN  //commented by HEI.09
                    SSCCTrackingMgt.SetPick(OldWhseActivLine."Activity Type" = OldWhseActivLine."Activity Type"::Pick);
                    SSCCTrackingMgt.SynchronizeWhseSSCCTracking2(TempScTrackingSpecification, RegisteredWhseActivLine."No.");
                END;
            END
            ELSE BEGIN
                ItemTrackingMgt.SynchronizeWhseItemTracking(TempTrackingSpecification, RegisteredWhseActivLine."No.", FALSE);
                IF SSCCSetup.READPERMISSION THEN BEGIN
                    SSCCTrackingMgt.SetPick(OldWhseActivLine."Activity Type" = OldWhseActivLine."Activity Type"::Pick);
                    SSCCTrackingMgt.SynchronizeWhseSSCCTracking(TempScTrackingSpecification, RegisteredWhseActivLine."No.");
                END;
            END;*/
            // BC Upgrade - RD03 DITW and SSCC Dependent Code are Blocked --------- <<
            AutoReserveForSalesLine(TempWhseActivLineToReserve, TempReservEntryBeforeSync, TempReservEntryAfterSync);

            WhseActivLine.RESET;
            WhseActivLine.SETRANGE("Activity Type", WhseActivHeader.Type);
            WhseActivLine.SETRANGE("No.", WhseActivHeader."No.");
            WhseActivLine.SETFILTER("Qty. Outstanding", '<>%1', 0);
            //HEI.10>>
            //IF NOT WhseActivLine.FIND('-') THEN
            //DELETE(TRUE)
            IF NOT WhseActivLine.FIND('-') THEN BEGIN
                IF WhseActivHeader."Posting Type FND" = WhseActivHeader."Posting Type FND"::Receive THEN
                    WhseActivHeader.DELETE(TRUE);
                //ELSE BEGIN
            END ELSE BEGIN
                //HEI.10<<
                WhseActivHeader."Last Registering No." := WhseActivHeader."Registering No.";
                //HEI.01 PRDGAP024+
                WhseActivHeader."Transfer Status FND" := WhseActivHeader."Transfer Status FND"::"In Progress";
                //HEI.01 PRDGAP024-
                //HEI.08>>
                IF (WhseActivHeader."Posting Type FND" = WhseActivHeader."Posting Type FND"::Ship) AND (WhseActivHeader."Posting Date" = 0D) THEN
                    WhseActivHeader."Posting Date" := WORKDATE;
                //HEI.08<<
                WhseActivHeader."Registering No." := '';
                WhseActivHeader.MODIFY(true);
                WhseActivLine.AutofillQtyToHandle(WhseActivLine);
            END;
            IF NOT HideDialog THEN
                Window.CLOSE;

            //IF AppMgt.IsObjectLicense(5, CODEUNIT::"N-owm Posting Utils", 4) <> 0 THEN
            //  OWMPostingUtils.Post7307(WhseActivLine);  //DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806
            COMMIT;
            CLEAR(WhseJnlRegisterLine);
        end;
        //HEI.01 PRDGAP024<<
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure CheckLines(var WhseActivHeader: Record "Warehouse Activity Header"; var WhseActivLine: Record "Warehouse Activity Line")
    begin
        TempBinContentBuffer.DELETEALL;
        LineCount := 0;
        IF WhseActivLine.FIND('-') THEN
            REPEAT
                LineCount := LineCount + 1;
                UpdateWindow(2, '');
                WhseActivLine.CheckBinInSourceDoc;
                WhseActivLine.TESTFIELD("Item No.");
                IF (WhseActivLine."Activity Type" = WhseActivLine."Activity Type"::Pick) AND
                   (WhseActivLine."Destination Type" = WhseActivLine."Destination Type"::Customer)
                THEN BEGIN
                    WhseActivLine.TESTFIELD("Destination No.");
                    Cust.GET(WhseActivLine."Destination No.");
                    IF Cust.Blocked <> Cust.Blocked::Invoice THEN //soicad>>
                        Cust.CheckBlockedCustOnDocs(Cust, WhseActivHeader."Source Document", FALSE, FALSE);
                END;
                if Location.Get(WhseActivHeader."Location Code") then begin
                    IF Location."Bin Mandatory" THEN BEGIN
                        WhseActivLine.TESTFIELD("Unit of Measure Code");
                        WhseActivLine.TESTFIELD("Bin Code");
                        WhseActivLine.CheckWhseDocLine;
                        UpdateTempBinContentBuffer(WhseActivLine);
                    END;
                end;

                IF ((WhseActivLine."Activity Type" = WhseActivLine."Activity Type"::Pick) OR
                    (WhseActivLine."Activity Type" = WhseActivLine."Activity Type"::"Invt. Pick") OR
                    (WhseActivLine."Activity Type" = WhseActivLine."Activity Type"::"Invt. Movement")) AND
                   (WhseActivLine."Action Type" = WhseActivLine."Action Type"::Take)
                THEN BEGIN
                    CheckItemTrackingInfoBlocked(WhseActivLine);
                    // DITW Dependency Code Blocked ------- >>
                    // <<DITW16.00.00.43 DDR 24/10/2013 DIT-715 #819
                    //IF SSCCSetup.READPERMISSION AND (WhseActivLine."SSCC No." <> '') THEN
                    //  CheckSSCCTrackingInfoBlocked(
                    //  WhseActivLine."Item No.", WhseActivLine."Variant Code", WhseActivLine."SSCC No.", WhseActivLine."Lot No.");
                    // >>DITW16.00.00.43 DDR DIT-715 #819
                    // DITW Dependency Code Blocked ------- <<
                END;
            UNTIL WhseActivLine.NEXT = 0;
        NoOfRecords := LineCount;

        IF Location."Bin Mandatory" THEN BEGIN
            CheckBinContent(WhseActivHeader);
            CheckBin;
        END;
        IF WhseActivHeader."Registering No." = '' THEN BEGIN
            WhseActivHeader.TESTFIELD(WhseActivHeader."Registering No. Series");
            WhseActivHeader."Registering No." := NoSeriesMgt.GetNextNo(WhseActivHeader."Registering No. Series", WhseActivHeader."Assignment Date", TRUE);
            NoSeriesMgt.SaveState();
            WhseActivHeader.MODIFY(true);
            COMMIT;
        END;
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure CheckBinContent(var WhseActivHeader: Record "Warehouse Activity Header")
    var
        BinContent: Record "Bin Content";
        Bin: Record Bin;
        WhseItemTrackingSetup: Record "Item Tracking Setup";
        WhseLocation: Record Location;
        BreakBulkQtyBaseToPlace: Decimal;
        IsHandled: Boolean;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        WhseActivityReg: Codeunit "Whse.-Activity-Register";
    begin
        TempBinContentBuffer.SetFilter("Qty. to Handle (Base)", '<>0');
        if TempBinContentBuffer.Find('-') then
            repeat
                if TempBinContentBuffer."Qty. to Handle (Base)" < 0 then begin
                    BinContent.Get(TempBinContentBuffer."Location Code", TempBinContentBuffer."Bin Code", TempBinContentBuffer."Item No.", TempBinContentBuffer."Variant Code", TempBinContentBuffer."Unit of Measure Code");
                    ItemTrackingMgt.GetWhseItemTrkgSetup(BinContent."Item No.", WhseItemTrackingSetup);

                    BinContent.ClearTrackingFilters();
                    BinContent.SetTrackingFilterFromBinContentBufferIfRequired(WhseItemTrackingSetup, TempBinContentBuffer);

                    BreakBulkQtyBaseToPlace := CalcBreakBulkQtyToPlace(TempBinContentBuffer, WhseActivHeader);
                    WhseActivityReg.GetItem(TempBinContentBuffer."Item No.");

                    CheckBinContentQtyToHandle(TempBinContentBuffer, BinContent, BreakBulkQtyBaseToPlace);
                end else begin
                    Bin.Get(TempBinContentBuffer."Location Code", TempBinContentBuffer."Bin Code");
                    WhseLocation.Get(TempBinContentBuffer."Location Code");
                    if WhseLocation."Check Whse. Class" then
                        Bin.CheckWhseClass(TempBinContentBuffer."Item No.", false);
                end;
            until TempBinContentBuffer.Next() = 0;
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure CheckBinContentQtyToHandle(var TempBinContentBuffer: Record "Bin Content Buffer" temporary; var BinContent: Record "Bin Content"; BreakBulkQtyBaseToPlace: Decimal)
    var
        UOMMgt: Codeunit "Unit of Measure Management";
        AbsQtyToHandle: Decimal;
        AbsQtyToHandleBase: Decimal;
        IsHandled: Boolean;
    begin
        AbsQtyToHandleBase := Abs(TempBinContentBuffer."Qty. to Handle (Base)");
        if item.Get(TempBinContentBuffer."Item No.") then
            AbsQtyToHandle :=
                Round(AbsQtyToHandleBase / UOMMgt.GetQtyPerUnitOfMeasure(Item, TempBinContentBuffer."Unit of Measure Code"), UOMMgt.QtyRndPrecision());
        if BreakBulkQtyBaseToPlace > 0 then begin
            if BinContent.Get(TempBinContentBuffer."Location Code", TempBinContentBuffer."Bin Code", TempBinContentBuffer."Item No.", TempBinContentBuffer."Variant Code", TempBinContentBuffer."Unit of Measure Code") then
                CheckDecreaseBinContent(item, BinContent, AbsQtyToHandle, AbsQtyToHandleBase, BreakBulkQtyBaseToPlace - TempBinContentBuffer."Qty. to Handle (Base)")
        end else begin
            if BinContent.Get(TempBinContentBuffer."Location Code", TempBinContentBuffer."Bin Code", TempBinContentBuffer."Item No.", TempBinContentBuffer."Variant Code", TempBinContentBuffer."Unit of Measure Code") then
                CheckDecreaseBinContent(item, BinContent, AbsQtyToHandle, AbsQtyToHandleBase, Abs(TempBinContentBuffer."Qty. Outstanding (Base)"));
        end;
        if AbsQtyToHandleBase <> Abs(TempBinContentBuffer."Qty. to Handle (Base)") then begin
            TempBinContentBuffer."Qty. to Handle (Base)" := AbsQtyToHandleBase * TempBinContentBuffer."Qty. to Handle (Base)" / Abs(TempBinContentBuffer."Qty. to Handle (Base)");
            TempBinContentBuffer.Modify();
        end;
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure CheckDecreaseBinContent(Item: Record Item; BinContent: Record "Bin Content"; Qty: Decimal; var QtyBase: Decimal; DecreaseQtyBase: Decimal)
    var
        WhseActivLine: Record "Warehouse Activity Line";
        QtyAvailToPickBase: Decimal;
        QtyAvailToPick: Decimal;
        IsHandled: Boolean;
        UOMMgt: Codeunit "Unit of Measure Management";
    begin
        if BinContent."Block Movement" in [BinContent."Block Movement"::Outbound, BinContent."Block Movement"::All] then
            BinContent.FieldError(BinContent."Block Movement");

        GetLocation(BinContent."Location Code");
        if BinContent."Bin Code" = Location."Adjustment Bin Code" then
            exit;

        if BinContent.ReadIsolation() <> IsolationLevel::UpdLock then
            BinContent.ReadIsolation(IsolationLevel::ReadCommitted);

        WhseActivLine.ReadIsolation(IsolationLevel::ReadUnCommitted);
        WhseActivLine.SetRange("Item No.", BinContent."Item No.");
        WhseActivLine.SetRange("Bin Code", BinContent."Bin Code");
        WhseActivLine.SetRange("Location Code", BinContent."Location Code");
        WhseActivLine.SetRange("Unit of Measure Code", BinContent."Unit of Measure Code");
        WhseActivLine.SetRange("Variant Code", BinContent."Variant Code");

        if Location."Allow Breakbulk" then begin
            WhseActivLine.SetRange("Action Type", WhseActivLine."Action Type"::Take);
            WhseActivLine.SetRange("Original Breakbulk", true);
            WhseActivLine.SetRange("Breakbulk No.", 0);
            WhseActivLine.CalcSums("Qty. (Base)");
            DecreaseQtyBase := DecreaseQtyBase + WhseActivLine."Qty. (Base)";
        end;

        QtyAvailToPickBase := CalcTotalQtyAvailToTake(BinContent, DecreaseQtyBase);
        if QtyAvailToPickBase < QtyBase then begin
            GetItem(BinContent."Item No.");
            QtyAvailToPick :=
              Round(QtyAvailToPickBase / UOMMgt.GetQtyPerUnitOfMeasure(Item, BinContent."Unit of Measure Code"), UOMMgt.QtyRndPrecision());
            if QtyAvailToPick = Qty then
                QtyBase := QtyAvailToPickBase // rounding issue- qty is same, but not qty (base)
            else
                BinContent.FieldError(BinContent."Quantity (Base)", StrSubstNo(Text006, Abs(QtyBase)));
        end;
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure CalcTotalQtyAvailToTake(BinContent: Record "Bin Content"; ExcludeQtyBase: Decimal) Result: Decimal
    var
        TotalQtyBase: Decimal;
        TotalNegativeAdjmtQtyBase: Decimal;
        TotalATOComponentsPickQtyBase: Decimal;
        IsHandled: Boolean;
    begin
        TotalQtyBase := CalcTotalQtyBase(BinContent);
        TotalNegativeAdjmtQtyBase := CalcTotalNegativeAdjmtQtyBase(BinContent);
        TotalATOComponentsPickQtyBase := CalcTotalATOComponentsPickQtyBase(BinContent);
        BinContent.SetFilterOnUnitOfMeasure();
        BinContent.CalcFields("Pick Quantity (Base)");
        exit(
          TotalQtyBase -
          (BinContent."Pick Quantity (Base)" + TotalATOComponentsPickQtyBase - ExcludeQtyBase + TotalNegativeAdjmtQtyBase));
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure CalcTotalNegativeAdjmtQtyBase(BinContent: Record "Bin Content") TotalNegativeAdjmtQtyBase: Decimal
    var
        WarehouseJournalLine: Record "Warehouse Journal Line";
        WhseItemTrackingLine: Record "Whse. Item Tracking Line";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        WarehouseJournalLine.ReadIsolation(IsolationLevel::ReadUnCommitted);
        WhseItemTrackingLine.ReadIsolation(IsolationLevel::ReadUnCommitted);
        if not IsHandled then begin
            WarehouseJournalLine.SetRange("Location Code", BinContent."Location Code");
            WarehouseJournalLine.SetRange("From Bin Code", BinContent."Bin Code");
            WarehouseJournalLine.SetRange("Item No.", BinContent."Item No.");
            WarehouseJournalLine.SetRange("Variant Code", BinContent."Variant Code");
            if not TrackingFiltersExist(BinContent) then begin
                WarehouseJournalLine.CalcSums("Qty. (Absolute, Base)");
                TotalNegativeAdjmtQtyBase := WarehouseJournalLine."Qty. (Absolute, Base)";
            end else begin
                WhseItemTrackingLine.SetRange("Location Code", BinContent."Location Code");
                WhseItemTrackingLine.SetRange("Item No.", BinContent."Item No.");
                WhseItemTrackingLine.SetRange("Variant Code", BinContent."Variant Code");
                WhseItemTrackingLine.SetTrackingFilterFromBinContent(BinContent);
                WhseItemTrackingLine.SetRange("Source Type", DATABASE::"Warehouse Journal Line");
                if WarehouseJournalLine.FindSet() then
                    repeat
                        WhseItemTrackingLine.SetRange("Source ID", WarehouseJournalLine."Journal Batch Name");
                        WhseItemTrackingLine.SetRange("Source Batch Name", WarehouseJournalLine."Journal Template Name");
                        WhseItemTrackingLine.SetRange("Source Ref. No.", WarehouseJournalLine."Line No.");
                        WhseItemTrackingLine.CalcSums("Quantity (Base)");
                        TotalNegativeAdjmtQtyBase += WhseItemTrackingLine."Quantity (Base)";
                    until WarehouseJournalLine.Next() = 0;
            end;
        end;
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure TrackingFiltersExist(BinContent: Record "Bin Content") IsTrackingFiltersExist: Boolean
    begin
        IsTrackingFiltersExist := (BinContent.GetFilter(BinContent."Lot No. Filter") <> '') or (BinContent.GetFilter(BinContent."Serial No. Filter") <> '');
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure CalcTotalATOComponentsPickQtyBase(BinContent: Record "Bin Content"): Decimal
    var
        WarehouseActivityLine: Record "Warehouse Activity Line";
    begin
        GetLocation(BinContent."Location Code");
        WarehouseActivityLine.ReadIsolation(IsolationLevel::ReadUncommitted);
        WarehouseActivityLine.SetRange("Location Code", BinContent."Location Code");
        WarehouseActivityLine.SetRange("Bin Code", BinContent."Bin Code");
        WarehouseActivityLine.SetRange("Item No.", BinContent."Item No.");
        WarehouseActivityLine.SetRange("Variant Code", BinContent."Variant Code");
        if Location."Allow Breakbulk" then
            WarehouseActivityLine.SetRange("Unit of Measure Code", BinContent."Unit of Measure Code");
        WarehouseActivityLine.SetRange("Activity Type", WarehouseActivityLine."Activity Type"::Pick);
        WarehouseActivityLine.SetRange("Action Type", WarehouseActivityLine."Action Type"::Take);
        WarehouseActivityLine.SetRange("Assemble to Order", true);
        WarehouseActivityLine.SetRange("ATO Component", true);
        WarehouseActivityLine.SetTrackingFilterFromBinContent(BinContent);
        WarehouseActivityLine.CalcSums("Qty. Outstanding (Base)");
        exit(WarehouseActivityLine."Qty. Outstanding (Base)");
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure CalcTotalQtyBase(BinContent: Record "Bin Content"): Decimal
    var
        WarehouseEntry: Record "Warehouse Entry";
    begin
        WarehouseEntry.ReadIsolation(IsolationLevel::UpdLock);  // to prevent overcommitment
        WarehouseEntry.SetRange("Location Code", BinContent."Location Code");
        WarehouseEntry.SetRange("Bin Code", BinContent."Bin Code");
        WarehouseEntry.SetRange("Item No.", BinContent."Item No.");
        WarehouseEntry.SetRange("Variant Code", BinContent."Variant Code");
        WarehouseEntry.SetTrackingFilterFromBinContent(BinContent);
        WarehouseEntry.CalcSums("Qty. (Base)");
        exit(WarehouseEntry."Qty. (Base)");
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure GetItem(ItemNo: Code[20])
    begin
        if Item."No." = ItemNo then
            exit;

        if ItemNo = '' then
            Clear(Item)
        else begin
            Item.SetLoadFields("No.", Description, "Base Unit of Measure", "Warehouse Class Code");
            Item.Get(ItemNo);
        end;
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure CheckBin()
    var
        Bin: Record Bin;
        WhseActivityReg: Codeunit "Whse.-Activity-Register";
    begin
        TempBinContentBuffer.SetFilter("Qty. to Handle (Base)", '>0');
        if TempBinContentBuffer.Find('-') then
            repeat
                TempBinContentBuffer.SetRange("Qty. to Handle (Base)");
                TempBinContentBuffer.SetRange("Bin Code", TempBinContentBuffer."Bin Code");
                TempBinContentBuffer.CalcSums(Cubage, Weight);
                Bin.Get(TempBinContentBuffer."Location Code", TempBinContentBuffer."Bin Code");
                CheckIncreaseBin(Bin);
                TempBinContentBuffer.SetFilter("Qty. to Handle (Base)", '>0');
                TempBinContentBuffer.Find('+');
                TempBinContentBuffer.SetRange("Bin Code");
            until TempBinContentBuffer.Next() = 0;
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure CheckIncreaseBin(var Bin: Record Bin)
    var
        IsHandled: Boolean;
    begin
        Bin.CheckIncreaseBin(
            TempBinContentBuffer."Bin Code", '', TempBinContentBuffer."Qty. to Handle (Base)", TempBinContentBuffer.Cubage, TempBinContentBuffer.Weight, TempBinContentBuffer.Cubage, TempBinContentBuffer.Weight, true, false);
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure CalcBreakBulkQtyToPlace(TempBinContentBuffer: Record "Bin Content Buffer"; var GlobalWhseActivHeader: Record "Warehouse Activity Header") QtyBase: Decimal
    var
        BreakBulkWhseActivLine: Record "Warehouse Activity Line";
    begin
        BreakBulkWhseActivLine.SetCurrentKey(
            "Item No.", "Bin Code", "Location Code", "Action Type", "Variant Code",
            "Unit of Measure Code", "Breakbulk No.", "Activity Type", "Lot No.", "Serial No.");
        BreakBulkWhseActivLine.SetRange("Item No.", TempBinContentBuffer."Item No.");
        BreakBulkWhseActivLine.SetRange("Bin Code", TempBinContentBuffer."Bin Code");
        BreakBulkWhseActivLine.SetRange("Location Code", TempBinContentBuffer."Location Code");
        BreakBulkWhseActivLine.SetRange("Action Type", BreakBulkWhseActivLine."Action Type"::Place);
        BreakBulkWhseActivLine.SetRange("Variant Code", TempBinContentBuffer."Variant Code");
        BreakBulkWhseActivLine.SetRange("Unit of Measure Code", TempBinContentBuffer."Unit of Measure Code");
        BreakBulkWhseActivLine.SetFilter("Breakbulk No.", '<>0');
        BreakBulkWhseActivLine.SetRange("Activity Type", GlobalWhseActivHeader.Type);
        BreakBulkWhseActivLine.SetRange("No.", GlobalWhseActivHeader."No.");
        BreakBulkWhseActivLine.SetTrackingFilterFromBinContentBuffer(TempBinContentBuffer);
        if BreakBulkWhseActivLine.Find('-') then
            repeat
                QtyBase := QtyBase + BreakBulkWhseActivLine."Qty. to Handle (Base)";
            until BreakBulkWhseActivLine.Next() = 0;
        exit(QtyBase);
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure CheckItemTrackingInfoBlocked(WhseActivityLine: Record "Warehouse Activity Line")
    var
        SerialNoInfo: Record "Serial No. Information";
        LotNoInfo: Record "Lot No. Information";
    begin
        if not WhseActivityLine.TrackingExists() then
            exit;

        if WhseActivityLine."Serial No." <> '' then
            if SerialNoInfo.Get(WhseActivityLine."Item No.", WhseActivityLine."Variant Code", WhseActivityLine."Serial No.") then
                SerialNoInfo.TestField(Blocked, false);

        if WhseActivityLine."Lot No." <> '' then
            if LotNoInfo.Get(WhseActivityLine."Item No.", WhseActivityLine."Variant Code", WhseActivityLine."Lot No.") then
                LotNoInfo.TestField(Blocked, false);
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure CreateRegActivHeader(WhseActivHeader: Record "Warehouse Activity Header")
    var
        WhseCommentLine: Record "Warehouse Comment Line";
        WhseCommentLine2: Record "Warehouse Comment Line";
        RecordLinkManagement: Codeunit "Record Link Management";
        TableNameFrom: Option;
        TableNameTo: Option;
        RegisteredType: Enum "Warehouse Activity Type";
        RegisteredNo: Code[20];
        IsHandled: Boolean;
    begin
        TableNameFrom := WhseCommentLine."Table Name"::"Whse. Activity Header";
        if WhseActivHeader.Type = WhseActivHeader.Type::"Invt. Movement" then begin
            RegisteredInvtMovementHdr.Init();
            RegisteredInvtMovementHdr.TransferFields(WhseActivHeader);
            RegisteredInvtMovementHdr."No." := WhseActivHeader."Registering No.";
            RegisteredInvtMovementHdr."Invt. Movement No." := WhseActivHeader."No.";
            RegisteredInvtMovementHdr."Registering Date" := WorkDate();
            RegisteredInvtMovementHdr.Insert();
            RecordLinkManagement.CopyLinks(WhseActivHeader, RegisteredInvtMovementHdr);

            TableNameTo := WhseCommentLine."Table Name"::"Registered Invt. Movement";
            RegisteredType := RegisteredType::" ";
            RegisteredNo := RegisteredInvtMovementHdr."No.";
        end else begin
            RegisteredWhseActivHeader.Init();
            RegisteredWhseActivHeader.TransferFields(WhseActivHeader);
            RegisteredWhseActivHeader.Type := WhseActivHeader.Type;
            RegisteredWhseActivHeader."No." := WhseActivHeader."Registering No.";
            RegisteredWhseActivHeader."Whse. Activity No." := WhseActivHeader."No.";
            RegisteredWhseActivHeader."Registering Date" := WorkDate();
            RegisteredWhseActivHeader."No. Series" := WhseActivHeader."Registering No. Series";
            RegisteredWhseActivHeader."External Document No. FND" := WhseActivHeader."External Document No.";
            RegisteredWhseActivHeader."External Document No.2 FND" := WhseActivHeader."External Document No.2";
            RegisteredWhseActivHeader.Insert();
            RecordLinkManagement.CopyLinks(WhseActivHeader, RegisteredWhseActivHeader);

            TableNameTo := WhseCommentLine2."Table Name"::"Rgstrd. Whse. Activity Header";
            RegisteredType := RegisteredWhseActivHeader.Type;
            RegisteredNo := RegisteredWhseActivHeader."No.";
        end;

        WhseCommentLine.SetRange("Table Name", TableNameFrom);
        WhseCommentLine.SetRange(Type, WhseActivHeader.Type);
        WhseCommentLine.SetRange("No.", WhseActivHeader."No.");
        WhseCommentLine.LockTable();

        if WhseCommentLine.Find('-') then
            repeat
                WhseCommentLine2.Init();
                WhseCommentLine2 := WhseCommentLine;
                WhseCommentLine2."Table Name" := TableNameTo;
                WhseCommentLine2.Type := RegisteredType;
                WhseCommentLine2."No." := RegisteredNo;
                WhseCommentLine2.Insert();
            until WhseCommentLine.Next() = 0;
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure RegisterWhseJnlLine(WhseActivLine: Record "Warehouse Activity Line")
    var
        WhseJnlLine: Record "Warehouse Journal Line";
        WMSMgt: Codeunit "WMS Management";
        IsHandled: Boolean;
        WhseJnlRegisterLine: Codeunit "Whse. Jnl.-Register Line";
        WhseActivityReg: Codeunit "Whse.-Activity-Register";
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        WhseJnlLine.Init();
        WhseJnlLine."Location Code" := WhseActivLine."Location Code";
        WhseJnlLine."Item No." := WhseActivLine."Item No.";
        WhseJnlLine."Registering Date" := WorkDate();
        WhseJnlLine."User ID" := CopyStr(UserId(), 1, MaxStrLen(WhseJnlLine."User ID"));
        WhseJnlLine."Variant Code" := WhseActivLine."Variant Code";
        WhseJnlLine."Entry Type" := WhseJnlLine."Entry Type"::Movement;
        if WhseActivLine."Action Type" = WhseActivLine."Action Type"::Take then begin
            WhseJnlLine."From Zone Code" := WhseActivLine."Zone Code";
            WhseJnlLine."From Bin Code" := WhseActivLine."Bin Code";
        end else begin
            WhseJnlLine."To Zone Code" := WhseActivLine."Zone Code";
            WhseJnlLine."To Bin Code" := WhseActivLine."Bin Code";
        end;
        WhseJnlLine.Description := WhseActivLine.Description;

        WhseActivityReg.LocationGet(WhseActivLine."Location Code");
        if Location."Directed Put-away and Pick" then begin
            WhseJnlLine.Quantity := WhseActivLine."Qty. to Handle";
            WhseJnlLine."Unit of Measure Code" := WhseActivLine."Unit of Measure Code";
            WhseJnlLine."Qty. per Unit of Measure" := WhseActivLine."Qty. per Unit of Measure";
            WhseJnlLine."Qty. Rounding Precision" := WhseActivLine."Qty. Rounding Precision";
            WhseJnlLine."Qty. Rounding Precision (Base)" := WhseActivLine."Qty. Rounding Precision (Base)";

            WhseActivityReg.GetItemUnitOfMeasure(WhseActivLine."Item No.", WhseActivLine."Unit of Measure Code");
            WhseJnlLine.Cubage :=
              Abs(WhseJnlLine.Quantity) * ItemUnitOfMeasure.Cubage;
            WhseJnlLine.Weight :=
              Abs(WhseJnlLine.Quantity) * ItemUnitOfMeasure.Weight;
        end else begin
            WhseJnlLine.Quantity := WhseActivLine."Qty. to Handle (Base)";
            WhseJnlLine."Unit of Measure Code" := WMSMgt.GetBaseUOM(WhseActivLine."Item No.");
            WhseJnlLine."Qty. per Unit of Measure" := 1;
        end;
        WhseJnlLine."Qty. (Base)" := WhseActivLine."Qty. to Handle (Base)";
        WhseJnlLine."Qty. (Absolute)" := WhseJnlLine.Quantity;
        WhseJnlLine."Qty. (Absolute, Base)" := WhseActivLine."Qty. to Handle (Base)";

        WhseJnlLine.SetSource(WhseActivLine."Source Type", WhseActivLine."Source Subtype", WhseActivLine."Source No.", WhseActivLine."Source Line No.", WhseActivLine."Source Subline No.");
        WhseJnlLine."Source Document" := WhseActivLine."Source Document";
        WhseJnlLine."External Document No. FND" := RegisteredWhseActivHeader."External Document No. FND";
        WhseJnlLine."External Document No.2 FND" := RegisteredWhseActivHeader."External Document No.2 FND";
        WhseJnlLine."Reference No." := RegisteredWhseActivHeader."No.";
        case WhseActivLine."Activity Type" of
            WhseActivLine."Activity Type"::"Put-away":
                begin
                    WhseJnlLine."Source Code" := SourceCodeSetup."Whse. Put-away";
                    WhseJnlLine.SetWhseDocument(WhseActivLine."Whse. Document Type", WhseActivLine."Whse. Document No.", WhseActivLine."Whse. Document Line No.");
                    WhseJnlLine."Reference Document" := WhseJnlLine."Reference Document"::"Put-away";
                end;
            WhseActivLine."Activity Type"::Pick:
                begin
                    WhseJnlLine."Source Code" := SourceCodeSetup."Whse. Pick";
                    WhseJnlLine.SetWhseDocument(WhseActivLine."Whse. Document Type", WhseActivLine."Whse. Document No.", WhseActivLine."Whse. Document Line No.");
                    WhseJnlLine."Reference Document" := WhseJnlLine."Reference Document"::Pick;
                end;
            WhseActivLine."Activity Type"::Movement:
                begin
                    WhseJnlLine."Source Code" := SourceCodeSetup."Whse. Movement";
                    WhseJnlLine."Whse. Document Type" :=
                      WhseJnlLine."Whse. Document Type"::" ";
                    WhseJnlLine."Reference Document" :=
                      WhseJnlLine."Reference Document"::Movement;
                    //HEI.05>>
                    //IF (TENANTID = 'ethiopia') {OR (TENANTID = 'default')} THEN BEGIN   //commented by HEI.07
                    WhseJnlLine."Source No." := WhseActivLine."No.";
                    IF RegisteredWhseActivHeader."Transfer Type FND" = RegisteredWhseActivHeader."Transfer Type FND"::Receipt THEN
                        WhseJnlLine."Whse. Document Type" := WhseJnlLine."Whse. Document Type"::Receipt;
                    IF RegisteredWhseActivHeader."Transfer Type FND" = RegisteredWhseActivHeader."Transfer Type FND"::Shipment THEN
                        WhseJnlLine."Whse. Document Type" := WhseJnlLine."Whse. Document Type"::Shipment;
                    WhseJnlLine."Whse. Document No." := RegisteredWhseActivHeader."No.";
                    //END;    //commented by HEI.07
                    //HEI.05<<
                    WhseJnlLine."Zone-Transfer FND" := WhseActivLine."Zone-Transfer FND";
                    WhseJnlLine."Transfer Type FND" := RegisteredWhseActivHeader."Transfer Type FND";
                    WhseJnlLine."Bin Code" := WhseActivLine."Bin Code";
                end;
        /*WhseJnlLine."Activity Type"::"Invt. Put-away",
          "Activity Type"::"Invt. Pick",
          "Activity Type"::"Invt. Movement":
            WhseJnlLine."Whse. Document Type" := WhseJnlLine."Whse. Document Type"::" ";*/
        end;
        IF WhseActivLine."Serial No." <> '' THEN
            WhseActivLine.TESTFIELD("Qty. per Unit of Measure", 1);
        WhseJnlLine."Serial No." := WhseActivLine."Serial No.";
        WhseJnlLine."Lot No." := WhseActivLine."Lot No.";
        WhseJnlLine."Warranty Date" := WhseActivLine."Warranty Date";
        WhseJnlLine."Expiration Date" := WhseActivLine."Expiration Date";
        // <<DITW16.00.00.40 DDR 06/03/2012 DIT-715 #274
        //WhseJnlLine."SSCC No." := WhseActivLine."SSCC No.";
        // >>DITW16.00.00.40 DDR DIT-715 #274
        //HEI.01 PRDGAP024>>
        WhseJnlLine."In-Transit Zone Code FND" := WhseActivLine."In-Transit Zone Code FND";
        WhseJnlLine."In-Transit Bin Code FND" := WhseActivLine."In-Transit Bin Code FND";
        WhseJnlLine."Zone-Transfer FND" := WhseActivLine."Zone-Transfer FND";
        WhseJnlLine."Reference Line No. FND" := WhseActivLine."Line No.";
        IF WhseActivLine."Action Type" = WhseActivLine."Action Type"::Place THEN
            WhseJnlLine."Transfer Type FND" := WhseJnlLine."Transfer Type FND"::Receipt;
        IF WhseActivLine."Action Type" = WhseActivLine."Action Type"::Take THEN
            WhseJnlLine."Transfer Type FND" := WhseJnlLine."Transfer Type FND"::Shipment;
        WhseJnlLine."Movement No. FND" := WhseActivLine."No.";
        WhseActivLine.ValidateQtyWhenSNDefined();
        WhseJnlLine.CopyTrackingFromWhseActivityLine(WhseActivLine);
        WhseJnlLine."Warranty Date" := WhseActivLine."Warranty Date";
        WhseJnlLine."Expiration Date" := WhseActivLine."Expiration Date";
        WhseJnlRegisterLine.Run(WhseJnlLine);
    end;

    // BC Upgrade - RD03 ----------- >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse. Jnl.-Register Line", 'OnBeforeCode', '', false, false)]
    procedure OnBeforeCode(var WarehouseJournalLine: Record "Warehouse Journal Line"; var WhseEntryNo: Integer; var IsHandled: Boolean)
    var
        Item: Record Item;
        WhseJnlRegisterLine: codeunit "Whse. Jnl.-Register Line";
        xGlobalWhseEntryNo: Integer;
        GlobalWhseEntry: Record "Warehouse Entry";
    begin
        xGlobalWhseEntryNo := GlobalWhseEntryNo;
        ValidateSequenceNo(GlobalWhseEntryNo, xGlobalWhseEntryNo, Database::"Warehouse Entry");

        if (WarehouseJournalLine."Qty. (Absolute)" = 0) and (WarehouseJournalLine."Qty. (Base)" = 0) and (not WarehouseJournalLine."Phys. Inventory") then
            exit;
        WarehouseJournalLine.TestField("Item No.");
        GetLocation(WarehouseJournalLine."Location Code");

        Item.SetLoadFields("Variant Mandatory if Exists");
        Item.Get(WarehouseJournalLine."Item No.");
        if Item.IsVariantMandatory() then
            WarehouseJournalLine.TestField("Variant Code");

        //OnCodeOnAfterGetLastEntryNo(WarehouseJournalLine);

        OnMovement := false;
        IF WarehouseJournalLine."Zone-Transfer FND" THEN BEGIN
            IF WarehouseJournalLine."Transfer Type FND" = WarehouseJournalLine."Transfer Type FND"::Shipment THEN BEGIN
                WarehouseJournalLine."Transit-Zone FND" := FALSE;
                InitWhseEntry(GlobalWhseEntry, WarehouseJournalLine."From Zone Code", WarehouseJournalLine."From Bin Code", -1, WarehouseJournalLine);
                InsertWhseEntry(GlobalWhseEntry, WarehouseJournalLine);
                WarehouseJournalLine."Transit-Zone FND" := TRUE;
                InitWhseEntry(GlobalWhseEntry, WarehouseJournalLine."In-Transit Zone Code FND", WarehouseJournalLine."In-Transit Bin Code FND", 1, WarehouseJournalLine);
                InsertWhseEntry(GlobalWhseEntry, WarehouseJournalLine);
                IsHandled := true;
            END;
            IF WarehouseJournalLine."Transfer Type FND" = WarehouseJournalLine."Transfer Type FND"::Receipt THEN BEGIN
                WarehouseJournalLine."Transit-Zone FND" := TRUE;
                InitWhseEntry(GlobalWhseEntry, WarehouseJournalLine."In-Transit Zone Code FND", WarehouseJournalLine."In-Transit Bin Code FND", -1, WarehouseJournalLine);
                InsertWhseEntry(GlobalWhseEntry, WarehouseJournalLine);
                WarehouseJournalLine."Transit-Zone FND" := FALSE;
                InitWhseEntry(GlobalWhseEntry, WarehouseJournalLine."To Zone Code", WarehouseJournalLine."To Bin Code", 1, WarehouseJournalLine);
                InsertWhseEntry(GlobalWhseEntry, WarehouseJournalLine);
                IsHandled := true;
            END;
            EXIT;
        END;

        xGlobalWhseEntryNo := GlobalWhseEntryNo;
        ValidateSequenceNo(GlobalWhseEntryNo, xGlobalWhseEntryNo, Database::"Warehouse Entry");
    end;

    procedure InsertWhseEntry(var WhseEntry: Record "Warehouse Entry"; var WhseJnlLine: Record "Warehouse Journal Line")
    var
        ItemTrackingCode: Record "Item Tracking Code";
        Item: Record Item;
        IsHandled: Boolean;
        WMSMgt: Codeunit "WMS Management";
        Text001: Label 'Serial No. %1 is found in inventory .';
    begin
        IsHandled := false;
        if IsHandled then
            exit;
        GetLocation(WhseJnlLine."Location Code");//Bc Upgrade YADAVM09
        Item.SetLoadFields("Item Tracking Code");
        Item.ReadIsolation(IsolationLevel::ReadCommitted);
        Item.Get(WhseEntry."Item No.");

        if ItemTrackingCode.Get(Item."Item Tracking Code") then
            if (WhseEntry."Serial No." <> '') and
               (WhseEntry."Bin Code" <> Location."Adjustment Bin Code") and
               (WhseEntry.Quantity > 0) and
               ItemTrackingCode."SN Specific Tracking"
            then begin
                IsHandled := false;
                if not IsHandled then
                    if WMSMgt.SerialNoOnInventory(WhseEntry."Location Code", WhseEntry."Item No.", WhseEntry."Variant Code", WhseEntry."Serial No.") then
                        Error(Text001, WhseEntry."Serial No.");
            end;

        CheckExpiration(WhseEntry, ItemTrackingCode);

        InsertWhseReg(WhseEntry."Entry No.", WhseJnlLine);//Bc Upgrade YADAVM09
        WhseEntry."Warehouse Register No." := WhseReg."No.";
        WhseEntry.Insert(true);
        UpdateBinEmpty(WhseEntry, WhseJnlLine);//Bc Upgrade YADAVM09
    end;

    procedure UpdateBinEmpty(NewWarehouseEntry: Record "Warehouse Entry"; WhseJnlLine: Record "Warehouse Journal Line")
    var
        WarehouseEntry: Record "Warehouse Entry";
        IsHandled: Boolean;
    begin
        GetBin(WhseJnlLine."Location Code", WhseJnlLine."Bin Code");//Bc Upgrade YADAVM09
        if IsHandled then
            exit;

        if NewWarehouseEntry.Quantity > 0 then
            ModifyBinEmpty(false)
        else begin
            WarehouseEntry.ReadIsolation(IsolationLevel::ReadUnCommitted);
            WarehouseEntry.SetRange("Bin Code", NewWarehouseEntry."Bin Code");
            WarehouseEntry.SetRange("Location Code", NewWarehouseEntry."Location Code");
            WarehouseEntry.CalcSums("Qty. (Base)");
            ModifyBinEmpty(WarehouseEntry."Qty. (Base)" = 0);
        end;
    end;

    procedure ModifyBinEmpty(NewEmpty: Boolean)
    begin
        if Bin.Empty <> NewEmpty then begin
            Bin.ReadIsolation(IsolationLevel::UpdLock);
            Bin.Find();
            Bin.Empty := NewEmpty;
            Bin.Modify();
        end;
    end;

    procedure InsertWhseReg(WhseEntryNo: Integer; WhseJnlLine: Record "Warehouse Journal Line")
    begin
        if WhseReg."No." = 0 then begin
            WhseReg.Init();
            WhseReg."No." := WhseReg.GetNextEntryNo();
            WhseReg."From Entry No." := WhseEntryNo;
            WhseReg."To Entry No." := WhseEntryNo;
            WhseReg."Creation Date" := Today;
            WhseReg."Creation Time" := Time;
            WhseReg."Journal Batch Name" := WhseJnlLine."Journal Batch Name";
            WhseReg."Source Code" := WhseJnlLine."Source Code";
            WhseReg."User ID" := CopyStr(UserId(), 1, MaxStrLen(WhseJnlLine."User ID"));
            WhseReg.InsertRecord();
        end else begin
            if ((WhseEntryNo < WhseReg."From Entry No.") and (WhseEntryNo <> 0)) or
               ((WhseReg."From Entry No." = 0) and (WhseEntryNo <> 0))
            then
                WhseReg."From Entry No." := WhseEntryNo;
            if WhseEntryNo > WhseReg."To Entry No." then
                WhseReg."To Entry No." := WhseEntryNo;
            WhseReg.Modify();
        end;
    end;

    procedure CheckExpiration(var WarehouseEntry: Record "Warehouse Entry"; ItemTrackingCode: Record "Item Tracking Code")
    var
        ItemTrackingSetup: Record "Item Tracking Setup";
        ExistingExpDate: Date;
        IsHandled: Boolean;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        if ItemTrackingCode."Man. Expir. Date Entry Reqd." and (WarehouseEntry."Entry Type" = WarehouseEntry."Entry Type"::"Positive Adjmt.") and ItemTrackingCode.IsWarehouseTracking() then begin
            WarehouseEntry.TestField("Expiration Date");
            ItemTrackingSetup.CopyTrackingFromWhseEntry(WarehouseEntry);
            ItemTrackingMgt.GetWhseExpirationDate(WarehouseEntry."Item No.", WarehouseEntry."Variant Code", Location, ItemTrackingSetup, ExistingExpDate);
            if (ExistingExpDate <> 0D) and (WarehouseEntry."Expiration Date" <> ExistingExpDate) then begin
                IsHandled := false;
                if not IsHandled then
                    WarehouseEntry.TestField("Expiration Date", ExistingExpDate);
            end;
        end;
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure InitWhseEntry(var WhseEntry: Record "Warehouse Entry"; ZoneCode: Code[10]; BinCode: Code[20]; Sign: Integer; WhseJnlLine: Record "Warehouse Journal Line")
    var
        ToBinContent: Record "Bin Content";
        xGlobalWhseEntryNo: Integer;
        IsHandled: Boolean;
        ShouldDeleteFromBinContent: Boolean;
        WhseJnlRegisterLine: codeunit "Whse. Jnl.-Register Line";
        LotNoInformation: Record "Lot No. Information";
        Item2: Record Item;
        InventorySetup: Record "Inventory Setup";
    begin
        GlobalWhseEntryNo := WhseEntry.GetNextEntryNo();
        InventorySetup.Get(); //PATHAA02 GAP014_DTW, IBM GAP DTW 43

        WhseEntry.Init();
        WhseEntry."Entry No." := GlobalWhseEntryNo;
        WhseEntry."Journal Template Name" := WhseJnlLine."Journal Template Name";
        WhseEntry."Journal Batch Name" := WhseJnlLine."Journal Batch Name";
        if WhseJnlLine."Entry Type" <> WhseJnlLine."Entry Type"::Movement then begin
            if Sign >= 0 then
                WhseEntry."Entry Type" := WhseEntry."Entry Type"::"Positive Adjmt."
            else
                WhseEntry."Entry Type" := WhseEntry."Entry Type"::"Negative Adjmt.";
        end else
            WhseEntry."Entry Type" := WhseJnlLine."Entry Type";
        WhseEntry."Line No." := WhseJnlLine."Line No.";
        WhseEntry."Whse. Document No." := WhseJnlLine."Whse. Document No.";
        WhseEntry."Whse. Document Type" := WhseJnlLine."Whse. Document Type";
        WhseEntry."Whse. Document Line No." := WhseJnlLine."Whse. Document Line No.";
        WhseEntry."No. Series" := WhseJnlLine."Registering No. Series";
        WhseEntry."Location Code" := WhseJnlLine."Location Code";
        WhseEntry."Zone Code" := ZoneCode;
        WhseEntry."Bin Code" := BinCode;
        GetLocation(WhseJnlLine."Location Code");
        GetBin(WhseJnlLine."Location Code", BinCode);
        WhseEntry.Dedicated := Bin.Dedicated;
        WhseEntry."Bin Type Code" := Bin."Bin Type Code";
        WhseEntry."Item No." := WhseJnlLine."Item No.";
        WhseEntry.Description := GetItemDescription(WhseJnlLine."Item No.", WhseJnlLine.Description);
        if Location."Directed Put-away and Pick" then begin
            WhseEntry.Quantity := WhseJnlLine."Qty. (Absolute)" * Sign;
            WhseEntry."Unit of Measure Code" := WhseJnlLine."Unit of Measure Code";
            WhseEntry."Qty. per Unit of Measure" := WhseJnlLine."Qty. per Unit of Measure";
        end else begin
            WhseEntry.Quantity := WhseJnlLine."Qty. (Absolute, Base)" * Sign;
            WhseEntry."Unit of Measure Code" := WMSMgt.GetBaseUOM(WhseJnlLine."Item No.");
            WhseEntry."Qty. per Unit of Measure" := 1;
        end;
        WhseEntry."Qty. (Base)" := WhseJnlLine."Qty. (Absolute, Base)" * Sign;
        WhseEntry."Registering Date" := WhseJnlLine."Registering Date";
        WhseEntry."User ID" := WhseJnlLine."User ID";
        WhseEntry."Variant Code" := WhseJnlLine."Variant Code";
        WhseEntry."Source Type" := WhseJnlLine."Source Type";
        WhseEntry."Source Subtype" := WhseJnlLine."Source Subtype";
        WhseEntry."Source No." := WhseJnlLine."Source No.";
        WhseEntry."Source Line No." := WhseJnlLine."Source Line No.";
        WhseEntry."Source Subline No." := WhseJnlLine."Source Subline No.";
        WhseEntry."Source Document" := WhseJnlLine."Source Document";
        WhseEntry."External Document No. FND" := WhseJnlLine."External Document No. FND";
        WhseEntry."External Document No.2 FND" := WhseJnlLine."External Document No.2 FND";
        WhseEntry."Reference Document" := WhseJnlLine."Reference Document";
        WhseEntry."Reference No." := WhseJnlLine."Reference No.";
        WhseEntry."Source Code" := WhseJnlLine."Source Code";
        WhseEntry."Reason Code" := WhseJnlLine."Reason Code";
        WhseEntry.Cubage := WhseJnlLine.Cubage * Sign;
        WhseEntry.Weight := WhseJnlLine.Weight * Sign;
        WhseEntry.CopyTrackingFromWhseJnlLine(WhseJnlLine);
        WhseEntry."Expiration Date" := WhseJnlLine."Expiration Date";
        if OnMovement and (WhseJnlLine."Entry Type" = WhseJnlLine."Entry Type"::Movement) then begin
            WhseEntry.CopyTrackingFromNewWhseJnlLine(WhseJnlLine);
            if (WhseJnlLine."New Expiration Date" <> WhseJnlLine."Expiration Date") and (WhseEntry."Entry Type" = WhseEntry."Entry Type"::Movement) then
                WhseEntry."Expiration Date" := WhseJnlLine."New Expiration Date";
        end;
        WhseEntry."Warranty Date" := WhseJnlLine."Warranty Date";
        WhseEntry."Phys Invt Counting Period Code" := WhseJnlLine."Phys Invt Counting Period Code";
        WhseEntry."Phys Invt Counting Period Type" := WhseJnlLine."Phys Invt Counting Period Type";

        IsHandled := false;
        IF WhseEntry."Zone Code" = '' THEN
            IF Bin.GET(WhseEntry."Location Code", WhseEntry."Bin Code") THEN
                WhseEntry."Zone Code" := Bin."Zone Code";
        IF WhseEntry."Zone Code" = '' THEN
            IF Bin.GET(WhseJnlLine."Location Code", WhseJnlLine."Bin Code") THEN
                WhseEntry."Zone Code" := Bin."Zone Code";
        //>>HEI.02 FDD-PRDGAP024

        //HEI.07>>
        //IF ((TENANTID = 'ethiopia') {OR (TENANTID = 'default')}) AND (WhseEntry.Description = '') THEN  //commented by HEI.08
        IF WhseEntry.Description = '' THEN        //HEI.08
            WhseEntry.Description := WhseJnlLine.Description;
        //HEI.07<<

        //HEI.10>>
        WhseEntry."External Document No. FND" := WhseJnlLine."External Document No. FND";
        WhseEntry."External Document No.2 FND" := WhseJnlLine."External Document No.2 FND";
        //WhseEntry."Quality Status" := "Quality Status";//HEI.03
        IF LotNoInformation.GET(WhseEntry."Item No.", WhseEntry."Variant Code", WhseEntry."Lot No.") THEN BEGIN
            //HEI.06>>
            IF Item2.GET(WhseEntry."Item No.") AND (Item2."Item Tracking Code" = '') THEN
                // WhseEntry."Quality Status FND" := WhseEntry."Quality Status FND"::Unrestricted //PATHAA02 GAP014_DTW, IBM GAP DTW 43
                WhseEntry."Inspection Status FND" := InventorySetup."Quality Unrestricted FND"; //PATHAA02 GAP014_DTW, IBM GAP DTW 43
        END ELSE
            IF Item2.GET(WhseEntry."Item No.") AND (Item2."Item Tracking Code" = '') THEN
                // WhseEntry."Quality Status FND" := WhseEntry."Quality Status FND"::Unrestricted; //PATHAA02 GAP014_DTW, IBM GAP DTW 43
                WhseEntry."Inspection Status FND" := InventorySetup."Quality Unrestricted FND"; //PATHAA02 GAP014_DTW, IBM GAP DTW 43
        WhseEntry."Zone-Transfer FND" := WhseJnlLine."Zone-Transfer FND";
        WhseEntry."Reference Line No. FND" := WhseJnlLine."Reference Line No. FND";
        WhseEntry."Transit-Zone FND" := WhseJnlLine."Transit-Zone FND";
        WhseEntry."Movement No. FND" := WhseJnlLine."Movement No. FND";
        WHSUTILS.OnAferCreateWhseEntry(WhseEntry);
        IF LotNoInformation.GET(WhseEntry."Item No.", WhseEntry."Variant Code", WhseEntry."Lot No.") THEN BEGIN
            //HEI.06>>
            IF Item2.GET(WhseEntry."Item No.") AND (Item2."Item Tracking Code" = '') THEN
                // WhseEntry."Quality Status FND" := WhseEntry."Quality Status FND"::Unrestricted //PATHAA02 GAP014_DTW, IBM GAP DTW 43
                WhseEntry."Inspection Status FND" := InventorySetup."Quality Unrestricted FND"; //PATHAA02 GAP014_DTW, IBM GAP DTW 43
        END ELSE
            IF Item2.GET(WhseEntry."Item No.") AND (Item2."Item Tracking Code" = '') THEN
                //  WhseEntry."Quality Status FND" := WhseEntry."Quality Status FND"::Unrestricted; //PATHAA02 GAP014_DTW, IBM GAP DTW 43
                WhseEntry."Inspection Status FND" := InventorySetup."Quality Unrestricted FND"; //PATHAA02 GAP014_DTW, IBM GAP DTW 43
        if not IsHandled then
            if Sign > 0 then begin
                if BinCode <> Location."Adjustment Bin Code" then begin
                    if not ToBinContent.Get(
                            WhseJnlLine."Location Code", BinCode, WhseJnlLine."Item No.", WhseJnlLine."Variant Code", WhseJnlLine."Unit of Measure Code")
                    then
                        WhseJnlRegisterLine.InsertToBinContent(WhseEntry)
                    else
                        if Location."Default Bin Selection" = Location."Default Bin Selection"::"Last-Used Bin" then
                            WhseJnlRegisterLine.UpdateDefaultBinContent(WhseJnlLine."Item No.", WhseJnlLine."Variant Code", WhseJnlLine."Location Code", BinCode);
                    xGlobalWhseEntryNo := GlobalWhseEntryNo;
                    ValidateSequenceNo(GlobalWhseEntryNo, xGlobalWhseEntryNo, Database::"Warehouse Entry");
                end
            end else begin
                ShouldDeleteFromBinContent := BinCode <> Location."Adjustment Bin Code";
                if ShouldDeleteFromBinContent then
                    DeleteFromBinContent(WhseEntry, WhseJnlLine);
            end;
    end;

    procedure GetLocation(LocationCode: Code[10])

    begin
        if Location.Code <> LocationCode then
            Location.Get(LocationCode);
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure DeleteFromBinContent(var WhseEntry: Record "Warehouse Entry"; WhseJnlLine: Record "Warehouse Journal Line")
    var
        FromBinContent: Record "Bin Content";
        WhseEntry2: Record "Warehouse Entry";
        WhseItemTrackingSetup: Record "Item Tracking Setup";
        Sign: Integer;
        xGlobalWhseEntryNo: Integer;
        IsHandled: Boolean;
        InventorySetup: Record "Inventory Setup";
        Bin: Record Bin;

    begin
        InventorySetup.GET();
        FromBinContent.ReadIsolation(IsolationLevel::Readcommitted);
        FromBinContent.Get(
            WhseEntry."Location Code", WhseEntry."Bin Code", WhseEntry."Item No.", WhseEntry."Variant Code",
            WhseEntry."Unit of Measure Code");
        ItemTrackingMgt.GetWhseItemTrkgSetup(FromBinContent."Item No.", WhseItemTrackingSetup);
        WhseItemTrackingSetup.CopyTrackingFromWhseEntry(WhseEntry);
        FromBinContent.SetTrackingFilterFromItemTrackingSetupIfRequired(WhseItemTrackingSetup);
        IsHandled := false;
        xGlobalWhseEntryNo := GlobalWhseEntryNo;
        IF Bin.GET(WhseEntry."Location Code", WhseEntry."Bin Code") THEN //PATHAA02 GAP014_DTW, IBM GAP DTW 43
            WhseEntry."Unavailable Stock (Bin) FND" := Bin."Unavailable Stock FND";
        IF WhseEntry."Lot No." <> '' THEN
            // IF WhseEntry."Quality Status FND" = WhseEntry."Quality Status FND"::Blocked THEN BEGIN //PATHAA02 GAP014_DTW, IBM GAP DTW 43
            IF WhseEntry."Inspection Status FND" = InventorySetup."Quality Blocked FND" THEN BEGIN //PATHAA02 GAP014_DTW, IBM GAP DTW 43
                WhseEntry."Unavail. Stock (Quality) FND" := TRUE;
                WhseEntry."Unavailable Stock FND" := TRUE;
            END ELSE BEGIN
                WhseEntry."Unavail. Stock (Quality) FND" := FALSE;
                WhseEntry."Unavailable Stock FND" := FALSE;
            END;
        IF (NOT WhseEntry."Unavailable Stock (Bin) FND" AND NOT WhseEntry."Unavail. Stock (Quality) FND") THEN
            WhseEntry."Unavailable Stock FND" := FALSE
        ELSE
            WhseEntry."Unavailable Stock FND" := TRUE;
        ValidateSequenceNo(GlobalWhseEntryNo, xGlobalWhseEntryNo, Database::"Warehouse Entry");
        if IsHandled then
            exit;
        FromBinContent.CalcFields("Quantity (Base)", "Positive Adjmt. Qty. (Base)", "Put-away Quantity (Base)");
        if FromBinContent."Quantity (Base)" + WhseEntry."Qty. (Base)" = 0 then begin
            WhseEntry2.ReadIsolation(IsolationLevel::ReadCommitted);
            WhseEntry2.SetRange("Item No.", WhseEntry."Item No.");
            WhseEntry2.SetRange("Bin Code", WhseEntry."Bin Code");
            WhseEntry2.SetRange("Location Code", WhseEntry."Location Code");
            WhseEntry2.SetRange("Variant Code", WhseEntry."Variant Code");
            WhseEntry2.SetRange("Unit of Measure Code", WhseEntry."Unit of Measure Code");
            WhseEntry2.SetTrackingFilterFromItemTrackingSetupIfRequired(WhseItemTrackingSetup);
            WhseEntry2.CalcSums(Cubage, Weight, "Qty. (Base)");
            WhseEntry.Cubage := -WhseEntry2.Cubage;
            WhseEntry.Weight := -WhseEntry2.Weight;
            if WhseEntry2."Qty. (Base)" + WhseEntry."Qty. (Base)" <> 0 then
                RegisterRoundResidual(WhseEntry, WhseEntry2, WhseJnlLine);

            FromBinContent.ClearTrackingFilters();
            FromBinContent.CalcFields("Quantity (Base)");
            if FromBinContent."Quantity (Base)" + WhseEntry."Qty. (Base)" = 0 then
                if (FromBinContent."Positive Adjmt. Qty. (Base)" = 0) and
                    (FromBinContent."Put-away Quantity (Base)" = 0) and
                    (not FromBinContent.Fixed)
                then begin
                    FromBinContent.Delete();
                end;
        end else begin
            FromBinContent.CalcFields(Quantity);
            if FromBinContent.Quantity + WhseEntry.Quantity = 0 then begin
                WhseEntry."Qty. (Base)" := -FromBinContent."Quantity (Base)";
                Sign := WhseJnlLine."Qty. (Base)" / WhseJnlLine."Qty. (Absolute, Base)";
                WhseJnlLine."Qty. (Base)" := WhseEntry."Qty. (Base)" * Sign;
                WhseJnlLine."Qty. (Absolute, Base)" := Abs(WhseEntry."Qty. (Base)");
            end else
                if FromBinContent."Quantity (Base)" + WhseEntry."Qty. (Base)" < 0 then begin
                    IsHandled := false;
                    if not IsHandled then
                        FromBinContent.FieldError(
                            "Quantity (Base)",
                            StrSubstNo(Text000, FromBinContent."Quantity (Base)", -(FromBinContent."Quantity (Base)" + WhseEntry."Qty. (Base)")));
                end;
        end;
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure RegisterRoundResidual(var WhseEntry: Record "Warehouse Entry"; var WhseEntry2: Record "Warehouse Entry"; WhseJnlLine: Record "Warehouse Journal Line")
    var
        WhseJnlLine2: Record "Warehouse Journal Line";
        WhseJnlRegLine: Codeunit "Whse. Jnl.-Register Line";
    begin
        WhseJnlLine2 := WhseJnlLine;
        GetBin(WhseJnlLine2."Location Code", Location."Adjustment Bin Code");
        WhseJnlLine2.Quantity := 0;
        WhseJnlLine2."Qty. (Base)" := WhseEntry2."Qty. (Base)" + WhseEntry."Qty. (Base)";
        if WhseEntry2."Qty. (Base)" > Abs(WhseEntry."Qty. (Base)") then begin
            WhseJnlLine2."To Zone Code" := Bin."Zone Code";
            WhseJnlLine2."To Bin Code" := Bin.Code;
        end else begin
            WhseJnlLine2."To Zone Code" := WhseJnlLine2."From Zone Code";
            WhseJnlLine2."To Bin Code" := WhseJnlLine2."From Bin Code";
            WhseJnlLine2."From Zone Code" := Bin."Zone Code";
            WhseJnlLine2."From Bin Code" := Bin.Code;
            WhseJnlLine2."Qty. (Base)" := -WhseJnlLine2."Qty. (Base)";
        end;
        WhseJnlLine2."Qty. (Absolute)" := 0;
        WhseJnlLine2."Qty. (Absolute, Base)" := Abs(WhseJnlLine2."Qty. (Base)");
        WhseJnlRegLine.SetWhseRegister(WhseReg);
        WhseJnlRegLine.Run(WhseJnlLine2);
        WhseJnlRegLine.GetWhseRegister(WhseReg);
        GlobalWhseEntryNo := WhseEntry.GetNextEntryNo();
        WhseEntry."Entry No." := GlobalWhseEntryNo;
    end;

    procedure GetBin(LocationCode: Code[10]; BinCode: Code[20])
    begin
        if (Bin."Location Code" <> LocationCode) or
           (Bin.Code <> BinCode)
        then
            Bin.Get(LocationCode, BinCode);
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure GetItemDescription(ItemNo: Code[20]; Description2: Text[100]): Text[100]
    var
        WarehouseSetup2: Record "Warehouse Setup";
        Item: Record Item;
    begin
        WarehouseSetup2.SetLoadFields("Copy Item Descr. to Entries");
        WarehouseSetup2.Get();
        if WarehouseSetup2."Copy Item Descr. to Entries" then
            exit(Description2);

        Item.SetLoadFields(Description);
        Item.ReadIsolation(IsolationLevel::ReadCommitted);
        Item.Get(ItemNo);
        if Item.Description = Description2 then
            exit('');
        exit(Description2);
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure ValidateSequenceNo(LedgEntryNo: Integer; xLedgEntryNo: Integer; TableNo: Integer)
    var
        SequenceNoMgt: Codeunit "Sequence No. Mgt.";
    begin
        if LedgEntryNo = xLedgEntryNo then
            exit;
        SequenceNoMgt.ValidateSeqNo(TableNo);
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure CreateRegActivLine(WhseActivLine: Record "Warehouse Activity Line")
    begin
        if WhseActivLine."Activity Type" = WhseActivLine."Activity Type"::"Invt. Movement" then begin
            RegisteredInvtMovementLine.Init();
            RegisteredInvtMovementLine.TransferFields(WhseActivLine);
            RegisteredInvtMovementLine."No." := RegisteredInvtMovementHdr."No.";
            RegisteredInvtMovementLine.Validate(Quantity, WhseActivLine."Qty. to Handle");
            RegisteredInvtMovementLine.Insert();
        end else begin
            RegisteredWhseActivLine.Init();
            RegisteredWhseActivLine.TransferFields(WhseActivLine);
            RegisteredWhseActivLine."Activity Type" := RegisteredWhseActivHeader.Type;
            RegisteredWhseActivLine."No." := RegisteredWhseActivHeader."No.";
            RegisteredWhseActivLine.Quantity := WhseActivLine."Qty. to Handle";
            RegisteredWhseActivLine."Qty. (Base)" := WhseActivLine."Qty. to Handle (Base)";
            RegisteredWhseActivLine.Insert();
        end;
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure CopyWhseActivityLineToReservBuf(var TempWhseActivLineToReserve: Record "Warehouse Activity Line" temporary; WhseActivLine: Record "Warehouse Activity Line")
    var
        IsHandled: Boolean;
    begin
        if IsPickPlaceForSalesOrderTrackedItem(WhseActivLine) or
           IsInvtMovementForAssemblyOrderTrackedItem(WhseActivLine)
        then begin
            TempWhseActivLineToReserve.TransferFields(WhseActivLine);
            TempWhseActivLineToReserve.Insert();
        end;
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure IsPickPlaceForSalesOrderTrackedItem(WhseActivityLine: Record "Warehouse Activity Line"): Boolean
    begin
        exit(
          (WhseActivityLine."Activity Type" = WhseActivityLine."Activity Type"::Pick) and
          (WhseActivityLine."Action Type" in [WhseActivityLine."Action Type"::Place, WhseActivityLine."Action Type"::" "]) and
          (WhseActivityLine."Source Document" = WhseActivityLine."Source Document"::"Sales Order") and
          (WhseActivityLine."Breakbulk No." = 0) and
          WhseActivityLine.TrackingExists());
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure IsInvtMovementForAssemblyOrderTrackedItem(WhseActivityLine: Record "Warehouse Activity Line"): Boolean
    begin
        exit(
          (WhseActivityLine."Activity Type" = WhseActivityLine."Activity Type"::"Invt. Movement") and
          (WhseActivityLine."Action Type" in [WhseActivityLine."Action Type"::Place, WhseActivityLine."Action Type"::" "]) and
          (WhseActivityLine."Source Document" = WhseActivityLine."Source Document"::"Assembly Consumption") and
          (WhseActivityLine."Breakbulk No." = 0) and
          WhseActivityLine.TrackingExists());
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure AutoReserveForSalesLine(var TempWhseActivLineToReserve: Record "Warehouse Activity Line" temporary; var TempReservEntryBefore: Record "Reservation Entry" temporary; var TempReservEntryAfter: Record "Reservation Entry" temporary)
    var
        SalesLine: Record "Sales Line";
        WhseItemTrackingSetup: Record "Item Tracking Setup";
        ReservMgt: Codeunit "Reservation Management";
        FullAutoReservation: Boolean;
        IsHandled: Boolean;
        QtyToReserve: Decimal;
        QtyToReserveBase: Decimal;
    begin
        if TempWhseActivLineToReserve.FindSet() then
            repeat
                ItemTrackingMgt.GetWhseItemTrkgSetup(TempWhseActivLineToReserve."Item No.", WhseItemTrackingSetup);
                if TempWhseActivLineToReserve.HasRequiredTracking(WhseItemTrackingSetup) then begin
                    SalesLine.Get(TempWhseActivLineToReserve."Source Subtype", TempWhseActivLineToReserve."Source No.", TempWhseActivLineToReserve."Source Line No.");

                    TempReservEntryBefore.SetSourceFilter(TempWhseActivLineToReserve."Source Type", TempWhseActivLineToReserve."Source Subtype", TempWhseActivLineToReserve."Source No.", TempWhseActivLineToReserve."Source Line No.", true);
                    TempReservEntryBefore.SetTrackingFilterFromWhseActivityLine(TempWhseActivLineToReserve);
                    TempReservEntryBefore.CalcSums(Quantity, "Quantity (Base)");

                    TempReservEntryAfter.CopyFilters(TempReservEntryBefore);
                    TempReservEntryAfter.CalcSums(Quantity, "Quantity (Base)");

                    QtyToReserve :=
                      TempWhseActivLineToReserve."Qty. to Handle" + (TempReservEntryAfter.Quantity - TempReservEntryBefore.Quantity);
                    QtyToReserveBase :=
                      TempWhseActivLineToReserve."Qty. to Handle (Base)" + (TempReservEntryAfter."Quantity (Base)" - TempReservEntryBefore."Quantity (Base)");

                    if not IsSalesLineCompletelyReserved(SalesLine) and (QtyToReserve > 0) then begin
                        ReservMgt.SetReservSource(SalesLine);
                        ReservMgt.SetTrackingFromWhseActivityLine(TempWhseActivLineToReserve);
                        ReservMgt.AutoReserve(FullAutoReservation, '', SalesLine."Shipment Date", QtyToReserve, QtyToReserveBase);
                    end;
                end;
            until TempWhseActivLineToReserve.Next() = 0;
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure IsSalesLineCompletelyReserved(SalesLine: Record "Sales Line"): Boolean
    begin
        SalesLine.CalcFields("Reserved Quantity");
        exit(SalesLine.Quantity = SalesLine."Reserved Quantity");
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure UpdateTempBinContentBuffer(WhseActivLine: Record "Warehouse Activity Line")
    var
        WMSMgt: Codeunit "WMS Management";
        UOMCode: Code[10];
        Sign: Integer;
    begin
        //WITH WhseActivLine DO BEGIN
        IF Location."Directed Put-away and Pick" THEN
            UOMCode := WhseActivLine."Unit of Measure Code"
        ELSE
            UOMCode := WMSMgt.GetBaseUOM(WhseActivLine."Item No.");
        IF NOT TempBinContentBuffer.GET(WhseActivLine."Location Code", WhseActivLine."Bin Code", WhseActivLine."Item No.", WhseActivLine."Variant Code", UOMCode, WhseActivLine."Lot No.", WhseActivLine."Serial No.")
        THEN BEGIN
            TempBinContentBuffer.INIT();
            TempBinContentBuffer."Location Code" := WhseActivLine."Location Code";
            TempBinContentBuffer."Zone Code" := WhseActivLine."Zone Code";
            TempBinContentBuffer."Bin Code" := WhseActivLine."Bin Code";
            TempBinContentBuffer."Item No." := WhseActivLine."Item No.";
            TempBinContentBuffer."Variant Code" := WhseActivLine."Variant Code";
            TempBinContentBuffer."Unit of Measure Code" := UOMCode;
            TempBinContentBuffer.INSERT();
        END;
        Sign := 1;
        IF WhseActivLine."Action Type" = WhseActivLine."Action Type"::Take THEN
            Sign := -1;

        TempBinContentBuffer."Base Unit of Measure" := WMSMgt.GetBaseUOM(WhseActivLine."Item No.");
        TempBinContentBuffer."Qty. to Handle (Base)" := TempBinContentBuffer."Qty. to Handle (Base)" + Sign * WhseActivLine."Qty. to Handle (Base)";
        TempBinContentBuffer."Qty. Outstanding (Base)" :=
          TempBinContentBuffer."Qty. Outstanding (Base)" + Sign * WhseActivLine."Qty. Outstanding (Base)";
        TempBinContentBuffer.Cubage := TempBinContentBuffer.Cubage + Sign * WhseActivLine.Cubage;
        TempBinContentBuffer.Weight := TempBinContentBuffer.Weight + Sign * WhseActivLine.Weight;
        TempBinContentBuffer.MODIFY();
        //END;
    end;

    // BC Upgrade - RD03 ----------- >>
    procedure UpdateWindow(ControlNo: Integer; Value: Code[20])
    var
        Text00: Label 'Warehouse Activity    #1##########\\';
        Text01: Label 'Checking lines        #2######\';
        Text02: Label 'Registering lines     #3###### @4@@@@@@@@@@@@@';
    begin
        if not HideDialog then
            case ControlNo of
                1:
                    begin
                        Window.Open(Text00 + Text01 + Text02);
                        Window.Update(1, Value);
                    end;
                2:
                    Window.Update(2, LineCount);
                3:
                    Window.Update(3, LineCount);
                4:
                    Window.Update(4, Round(LineCount / NoOfRecords * 10000, 1));
            end;
    end;

    var
        Window: Dialog;
        TempBinContentBuffer: Record "Bin Content Buffer" temporary;
        Cust: Record Customer;
        NoSeriesMgt: Codeunit "No. Series - Batch";
        RegisteredInvtMovementHdr: Record "Registered Invt. Movement Hdr.";
        RegisteredWhseActivHeader: Record "Registered Whse. Activity Hdr.";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        RegisteredInvtMovementLine: Record "Registered Invt. Movement Line";
        RegisteredWhseActivLine: Record "Registered Whse. Activity Line";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        NoOfRecords: Integer;
        LineCount: Integer;
        HideDialog: Boolean;
        GlobalWhseEntryNo: Integer;
        OnMovement: Boolean;
        WMSMgt: Codeunit "WMS Management";
        WhseReg: Record "Warehouse Register";
        Bin: Record Bin;
        Location: Record Location;
        Text000: Label 'is not sufficient to complete this action. The quantity in the bin is %1. %2 units are not available';//BC Upgrade Kamnay01 Bug fix
        SourceCodeSetup: Record "Source Code Setup";
        WHSUTILS: Codeunit "WHS-UTILS";
        Item: Record Item;
        Text003: Label 'There is nothing to register.';//BC Upgrade Kamnay01 Bug fix
        Text006: Label '%1 + %2 must be -%3.';
}