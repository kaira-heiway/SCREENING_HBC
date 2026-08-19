codeunit 51031 WhseActivityRegisterHookCBN
{
    //*********************************************************************************************************************************************************************************************************************************************
    //   HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #Zone code development without whs advanced mgmt
    //   #Code for zone transfer movement
    //   #New function NewCode
    //   HEI.05 FDD-HT623 CHG2022293 IBM GAVANM01 02.07.2019
    //   # New functions for handle Transfer from Bin and Transfer to Bin:
    //       - UpdateTransferInfo, UpdateRegTransferInfo,
    //       - WsheActivityLine_OnAfterModifyEvent, WsheActivityLine_OnAfterInsertEvent, WsheActivityLine_OnAfterDeleteEvent
    //       - RegisteredWsheActLine_OnAfterModifyEvent, RegisteredWsheActLine_OnAfterInsertEvent, RegisteredWsheActLine_OnAfterDeleteEvent
    //   # Code added in function 'RegisterWhseJnlLine'
    //   HEI.08 FDD-HT623 CHG2022293 IBM GAVANM01 12.08.2019
    //   # fill in Posting Date if it is blank and if it is a shipment
    //   HEI.11 CHG2075364 IBM.LS      20.07.2021
    //   # Added Code
    //   HEI.12 CHG2154364 SAHAL01 15.03.2023 Astro - I/F Production - ProductionOrderOperationLinePick
    //   # Added Code to update External Document No. and External Document No.2
    //*********************************************************************************************************************************************************************************************************************************************

    // BC UPGRADE KAIRAR01 codeunit 7307 "Whse.-Activity-Register" -Code Refactored >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Register", OnBeforeWhseActivLineModify, '', false, false)]
    local procedure OnBeforeWhseActivLineModify(var WarehouseActivityLine: Record "Warehouse Activity Line")
    var
        WarehouseActivityHeader: Record "Warehouse Activity Header";
    begin
        if WarehouseActivityHeader.Get(WarehouseActivityLine."Activity Type", WarehouseActivityLine."No.") then
            if WarehouseActivityHeader."Zone transfer FND" then
                if WarehouseActivityHeader.Type = WarehouseActivityHeader.Type::Movement then begin

                    //HEI.01 PRDGAP024>>
                    IF WarehouseActivityLine."Action Type" = WarehouseActivityLine."Action Type"::Take THEN
                        WarehouseActivityLine."Quantity Shipped FND" := WarehouseActivityLine."Qty. Handled";
                    IF WarehouseActivityLine."Action Type" = WarehouseActivityLine."Action Type"::Place THEN
                        WarehouseActivityLine."Quantity Received FND" := WarehouseActivityLine."Qty. Handled";
                    //HEI.01 PRDGAP024<<
                end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Register", OnBeforeUpdateWhseSourceDocLine, '', false, false)]
    local procedure OnBeforeUpdateWhseSourceDocLine(var WarehouseActivityLine: Record "Warehouse Activity Line"; var IsHandled: Boolean)
    var
        WarehouseActivityHeader: Record "Warehouse Activity Header";
    begin
        if WarehouseActivityHeader.Get(WarehouseActivityLine."Activity Type", WarehouseActivityLine."No.") then
            if WarehouseActivityHeader."Zone transfer FND" then
                if WarehouseActivityHeader.Type = WarehouseActivityHeader.Type::Movement then
                    IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Register", OnBeforeUpdateWhseDocHeader, '', false, false)]
    local procedure OnBeforeUpdateWhseDocHeader(var WarehouseActivityLine: Record "Warehouse Activity Line"; var IsHandled: Boolean)
    var
        WarehouseActivityHeader: Record "Warehouse Activity Header";
    begin
        if WarehouseActivityHeader.Get(WarehouseActivityLine."Activity Type", WarehouseActivityLine."No.") then
            if WarehouseActivityHeader."Zone transfer FND" then
                if WarehouseActivityHeader.Type = WarehouseActivityHeader.Type::Movement then
                    IsHandled := true;
    end;

    // For Zone Transfer Movements, the logic is now executed even when Location."Bin Mandatory" is disabled.
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Register", OnAfterRegisteredWhseActivLineInsert, '', false, false)]
    local procedure OnAfterRegisteredWhseActivLineInsert(var RegisteredWhseActivityLine: Record "Registered Whse. Activity Line"; WarehouseActivityLine: Record "Warehouse Activity Line")
    var
        WarehouseActivityHeader: Record "Warehouse Activity Header";
        Location: Record Location;
    begin
        if WarehouseActivityHeader.Get(WarehouseActivityLine."Activity Type", WarehouseActivityLine."No.") then
            if WarehouseActivityHeader."Zone transfer FND" then
                if WarehouseActivityHeader.Type = WarehouseActivityHeader.Type::Movement then
                    if Location.Get(WarehouseActivityLine."Location Code") then
                        if not Location."Bin Mandatory" then
                            RegisterWhseJnlLine(WarehouseActivityLine);

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Register", OnBeforeWhseActivHeaderDelete, '', false, false)]
    local procedure OnBeforeWhseActivHeaderDelete(var WarehouseActivityHeader: Record "Warehouse Activity Header"; var SkipDelete: Boolean)
    begin
        if WarehouseActivityHeader."Zone transfer FND" then
            if WarehouseActivityHeader.Type = WarehouseActivityHeader.Type::Movement then
                IF WarehouseActivityHeader."Posting Type FND" = WarehouseActivityHeader."Posting Type FND"::Receive THEN
                    SkipDelete := false
                else
                    SkipDelete := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Register", OnBeforeCheckWhseActivLineIsEmpty, '', false, false)]
    local procedure OnBeforeCheckWhseActivLineIsEmpty(var WhseActivityLine: Record "Warehouse Activity Line"; var IsHandled: Boolean; var HideDialog: Boolean)
    var
        WarehouseActivityHeader: Record "Warehouse Activity Header";
    begin
        if WarehouseActivityHeader.Get(WhseActivityLine."Activity Type", WhseActivityLine."No.") then begin
            //HEI.01 PRDGAP024>>
            IF WarehouseActivityHeader."Posting Type FND" = WarehouseActivityHeader."Posting Type FND"::Ship THEN
                WhseActivityLine.SETRANGE("Action Type", WhseActivityLine."Action Type"::Take);
            IF WarehouseActivityHeader."Posting Type FND" = WarehouseActivityHeader."Posting Type FND"::Receive THEN
                WhseActivityLine.SETRANGE("Action Type", WhseActivityLine."Action Type"::Place);
            //HEI.01 PRDGAP024<<
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Register", OnCodeOnBeforeModifyGlobalWhseActivHeader, '', false, false)]
    local procedure OnCodeOnBeforeModifyGlobalWhseActivHeader(var WarehouseActivityHeader: Record "Warehouse Activity Header")
    begin
        //HEI.01 PRDGAP024+
        WarehouseActivityHeader."Transfer Status FND" := WarehouseActivityHeader."Transfer Status FND"::"In Progress";
        //HEI.01 PRDGAP024-
        //HEI.08>>
        IF (WarehouseActivityHeader."Posting Type FND" = WarehouseActivityHeader."Posting Type FND"::Ship) AND (WarehouseActivityHeader."Posting Date" = 0D) THEN
            WarehouseActivityHeader."Posting Date" := WORKDATE;
        //HEI.08<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Register", OnBeforeWhseJnlRegisterLine, '', false, false)]
    local procedure OnBeforeWhseJnlRegisterLine(var WarehouseJournalLine: Record "Warehouse Journal Line"; WarehouseActivityLine: Record "Warehouse Activity Line")
    var
        RegisteredWhseActivHeader: Record "Registered Whse. Activity Hdr.";
    begin
        RegisteredWhseActivHeader.Reset();
        RegisteredWhseActivHeader.SetCurrentKey("Whse. Activity No.");
        RegisteredWhseActivHeader.SetRange("Whse. Activity No.", WarehouseActivityLine."No.");
        if RegisteredWhseActivHeader.FindFirst() then begin
            //HEI.12>>
            WarehouseJournalLine."External Document No. FND" := RegisteredWhseActivHeader."External Document No. FND";
            WarehouseJournalLine."External Document No.2 FND" := RegisteredWhseActivHeader."External Document No.2 FND";
            //Reference:   RegisteredWhseActivHeader."Whse. Activity No." := WhseActivHeader."No.";
            //HEI.12<<
        end;

        //HEI.01 PRDGAP024>>
        WarehouseJournalLine."In-Transit Zone Code FND" := WarehouseActivityLine."In-Transit Zone Code FND";
        WarehouseJournalLine."In-Transit Bin Code FND" := WarehouseActivityLine."In-Transit Bin Code FND";
        WarehouseJournalLine."Zone-Transfer FND" := WarehouseActivityLine."Zone-Transfer FND";
        WarehouseJournalLine."Reference Line No. FND" := WarehouseActivityLine."Line No.";
        IF WarehouseActivityLine."Action Type" = WarehouseActivityLine."Action Type"::Place THEN
            WarehouseJournalLine."Transfer Type FND" := WarehouseJournalLine."Transfer Type FND"::Receipt;
        IF WarehouseActivityLine."Action Type" = WarehouseActivityLine."Action Type"::Take THEN
            WarehouseJournalLine."Transfer Type FND" := WarehouseJournalLine."Transfer Type FND"::Shipment;
        WarehouseJournalLine."Movement No. FND" := WarehouseActivityLine."No.";
        //HEI.01 PRDGAP024<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Register", OnBeforeRegisteredWhseActivHeaderInsert, '', false, false)]
    local procedure OnBeforeRegisteredWhseActivHeaderInsert(var RegisteredWhseActivityHdr: Record "Registered Whse. Activity Hdr."; WarehouseActivityHeader: Record "Warehouse Activity Header")
    begin
        //HEI.12>>
        RegisteredWhseActivityHdr."External Document No. FND" := WarehouseActivityHeader."External Document No.";
        RegisteredWhseActivityHdr."External Document No.2 FND" := WarehouseActivityHeader."External Document No.2";
        //HEI.12<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Register", OnBeforeRegisteredWhseActivLineInsert, '', false, false)]
    local procedure OnBeforeRegisteredWhseActivLineInsert(var RegisteredWhseActivityLine: Record "Registered Whse. Activity Line"; WarehouseActivityLine: Record "Warehouse Activity Line")
    begin
        //HEI.12>>
        RegisteredWhseActivityLine."Whse. Activity No." := WarehouseActivityLine."No.";
        //HEI.12<<
    end;

    procedure RegisterWhseJnlLine(WhseActivLine: Record "Warehouse Activity Line")
    var
        WhseJnlLine: Record "Warehouse Journal Line";
        SourceCodeSetup: Record "Source Code Setup";
        Location: Record Location;
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        RegisteredWhseActivHeader: Record "Registered Whse. Activity Hdr.";
        WhseJnlRegisterLine: Codeunit "Whse. Jnl.-Register Line";
        WMSMgt: Codeunit "WMS Management";
        IsHandled: Boolean;
    begin
        SourceCodeSetup.Get();
        if Location.Get(WhseActivLine."Location Code") then;
        RegisteredWhseActivHeader.Reset();
        RegisteredWhseActivHeader.SetCurrentKey("Whse. Activity No.");
        RegisteredWhseActivHeader.SetRange("Whse. Activity No.", WhseActivLine."No.");
        if RegisteredWhseActivHeader.FindFirst() then;

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

        if Location."Directed Put-away and Pick" then begin
            WhseJnlLine.Quantity := WhseActivLine."Qty. to Handle";
            WhseJnlLine."Unit of Measure Code" := WhseActivLine."Unit of Measure Code";
            WhseJnlLine."Qty. per Unit of Measure" := WhseActivLine."Qty. per Unit of Measure";
            WhseJnlLine."Qty. Rounding Precision" := WhseActivLine."Qty. Rounding Precision";
            WhseJnlLine."Qty. Rounding Precision (Base)" := WhseActivLine."Qty. Rounding Precision (Base)";

            if ItemUnitOfMeasure.Get(WhseActivLine."Item No.", WhseActivLine."Unit of Measure Code") then;
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
        //HEI.12>>
        WhseJnlLine."External Document No. FND" := RegisteredWhseActivHeader."External Document No. FND";
        WhseJnlLine."External Document No.2 FND" := RegisteredWhseActivHeader."External Document No.2 FND";
        //HEI.12<<
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
                    WhseJnlLine."Whse. Document Type" := WhseJnlLine."Whse. Document Type"::" ";
                    WhseJnlLine."Reference Document" := WhseJnlLine."Reference Document"::Movement;
                end;
            WhseActivLine."Activity Type"::"Invt. Put-away",
          WhseActivLine."Activity Type"::"Invt. Pick",
          WhseActivLine."Activity Type"::"Invt. Movement":
                WhseJnlLine."Whse. Document Type" := WhseJnlLine."Whse. Document Type"::" ";
        end;
        WhseActivLine.ValidateQtyWhenSNDefined();
        WhseJnlLine.CopyTrackingFromWhseActivityLine(WhseActivLine);
        WhseJnlLine."Warranty Date" := WhseActivLine."Warranty Date";
        WhseJnlLine."Expiration Date" := WhseActivLine."Expiration Date";
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
        //HEI.01 PRDGAP024<<
        WhseJnlRegisterLine.Run(WhseJnlLine);
    end;

    //HEI.05>>
    procedure UpdateRegTransferInfo(Rec_RegWhActLine: Record "Registered Whse. Activity Line")
    var
        RegWhseActivityHeader: Record "Registered Whse. Activity Hdr.";
        RegWhseActivityHeader1: Record "Registered Whse. Activity Hdr.";
        RegWhseActivityLines: Record "Registered Whse. Activity Line";
        FromBinCode: Code[20];
        ToBinCode: Code[20];
    begin
        if Rec_RegWhActLine."Activity Type" = Rec_RegWhActLine."Activity Type"::Movement then begin
            Clear(FromBinCode);
            Clear(ToBinCode);
            RegWhseActivityHeader.Reset();
            RegWhseActivityHeader.SetRange(Type, Rec_RegWhActLine."Activity Type");
            RegWhseActivityHeader.SetRange("No.", Rec_RegWhActLine."No.");
            if RegWhseActivityHeader.FindFirst() then begin
                RegWhseActivityHeader1.Reset();
                RegWhseActivityHeader1.SetRange("Whse. Activity No.", RegWhseActivityHeader."Whse. Activity No.");
                if RegWhseActivityHeader1.FindFirst() then
                    repeat
                        RegWhseActivityLines.Reset();
                        RegWhseActivityLines.SetRange("Activity Type", Rec_RegWhActLine."Activity Type");
                        RegWhseActivityLines.SetRange("No.", RegWhseActivityHeader1."No.");
                        //RegWhseActivityLines.SETRANGE("Action Type", Rec_RegWhActLine."Action Type");
                        RegWhseActivityLines.SetFilter("Bin Code", '<>%1', '');
                        if RegWhseActivityLines.FindFirst() then
                            repeat
                                case RegWhseActivityLines."Action Type" of
                                    RegWhseActivityLines."Action Type"::Take:
                                        begin
                                            if FromBinCode = '' then
                                                FromBinCode := RegWhseActivityLines."Bin Code";
                                            if (RegWhseActivityLines."Bin Code" <> '') and
                                               (FromBinCode <> RegWhseActivityLines."Bin Code") then
                                                FromBinCode := 'MULTIPLE';
                                        end;
                                    RegWhseActivityLines."Action Type"::Place:
                                        begin
                                            if ToBinCode = '' then
                                                ToBinCode := RegWhseActivityLines."Bin Code";
                                            if (RegWhseActivityLines."Bin Code" <> '') and
                                               (ToBinCode <> RegWhseActivityLines."Bin Code") then
                                                ToBinCode := 'MULTIPLE';
                                        end;
                                end;
                            until (RegWhseActivityLines.Next() = 0) or
                                  ((FromBinCode = 'MULTIPLE') and (ToBinCode = 'MULTIPLE'));
                    until (RegWhseActivityHeader1.Next() = 0) or
                          ((FromBinCode = 'MULTIPLE') and (ToBinCode = 'MULTIPLE'));

                RegWhseActivityHeader1.Reset();
                RegWhseActivityHeader1.SetRange("Whse. Activity No.", RegWhseActivityHeader."Whse. Activity No.");
                if RegWhseActivityHeader1.FindFirst() then
                    repeat
                        RegWhseActivityHeader1."Transfer From Bin FND" := FromBinCode;
                        RegWhseActivityHeader1."Transfer To Bin FND" := ToBinCode;
                        RegWhseActivityHeader1.Modify();
                    // {CASE Rec_RegWhActLine."Action Type" OF
                    //      Rec_RegWhActLine."Action Type"::Take:
                    //          BEGIN
                    //              RegWhseActivityHeader1."Transfer From Bin" := BinCode;
                    //              RegWhseActivityHeader1.MODIFY;
                    //          END;
                    //      Rec_RegWhActLine."Action Type"::Place:
                    //          BEGIN
                    //              RegWhseActivityHeader1."Transfer To Bin" := BinCode;
                    //              RegWhseActivityHeader1.MODIFY;
                    //          END;
                    // END;}
                    until RegWhseActivityHeader1.Next() = 0;
            end;
        end;
    end;
    //HEI.05<<
    //HEI.05>>
    procedure UpdateTransferInfo(Rec_WhActLine: Record "Warehouse Activity Line")
    var
        WhseActivityHeader: Record "Warehouse Activity Header";
        WhseActivityLines: Record "Warehouse Activity Line";
        BinCode: Code[20];
    begin
        if Rec_WhActLine."Activity Type" = Rec_WhActLine."Activity Type"::Movement then begin
            WhseActivityHeader.Reset();
            WhseActivityHeader.SetRange(Type, Rec_WhActLine."Activity Type");
            WhseActivityHeader.SetRange("No.", Rec_WhActLine."No.");
            if WhseActivityHeader.FindFirst() then begin
                case Rec_WhActLine."Action Type" of
                    Rec_WhActLine."Action Type"::Take:
                        begin
                            Clear(BinCode);
                            WhseActivityLines.Reset();
                            WhseActivityLines.SetRange("Activity Type", Rec_WhActLine."Activity Type");
                            WhseActivityLines.SetRange("Action Type", Rec_WhActLine."Action Type");
                            WhseActivityLines.SetRange("No.", Rec_WhActLine."No.");
                            WhseActivityLines.SetFilter("Bin Code", '<>%1', '');
                            if WhseActivityLines.FindFirst() then begin
                                BinCode := WhseActivityLines."Bin Code";
                                repeat
                                    if (WhseActivityLines."Bin Code" <> '') and
                                       (BinCode <> WhseActivityLines."Bin Code") then
                                        BinCode := 'MULTIPLE';
                                until (WhseActivityLines.Next() = 0) or (BinCode = 'MULTIPLE');
                            end;
                            WhseActivityHeader."Transfer From Bin FND" := BinCode;
                            WhseActivityHeader.Modify();
                        end;
                    Rec_WhActLine."Action Type"::Place:
                        begin
                            Clear(BinCode);
                            WhseActivityLines.Reset();
                            WhseActivityLines.SetRange("Activity Type", Rec_WhActLine."Activity Type");
                            WhseActivityLines.SetRange("Action Type", Rec_WhActLine."Action Type");
                            WhseActivityLines.SetRange("No.", Rec_WhActLine."No.");
                            WhseActivityLines.SetFilter("Bin Code", '<>%1', '');
                            if WhseActivityLines.FindFirst() then begin
                                BinCode := WhseActivityLines."Bin Code";
                                repeat
                                    if (WhseActivityLines."Bin Code" <> '') and
                                       (BinCode <> WhseActivityLines."Bin Code") then
                                        BinCode := 'MULTIPLE';
                                until (WhseActivityLines.Next() = 0) or (BinCode = 'MULTIPLE');
                            end;
                            WhseActivityHeader."Transfer To Bin FND" := BinCode;
                            WhseActivityHeader.Modify();
                        end;
                end;
            end;
        end;
    end;
    //HEI.05<<
    //HEI.11>>
    procedure CallItemTracking(var WarehouseActivityLine: Record "Warehouse Activity Line")
    var
        TrackingSpecification: Record "Tracking Specification";
        ItemTrackingLines: Page "Item Tracking Lines";
    begin
        WarehouseActivityLine.TestField("Item No.");
        TrackingSpecification.InitFromWhseActivityLine(WarehouseActivityLine);
        ItemTrackingLines.ApplyFilters();
        ItemTrackingLines.SetSourceSpec(TrackingSpecification, WarehouseActivityLine."Due Date");
        ItemTrackingLines.SetInbound(WarehouseActivityLine.IsInbound());
        ItemTrackingLines.RunModal();
    end;
    //HEI.11>>

    // BC UPGRADE KAIRAR01 codeunit 7307 "Whse.-Activity-Register" <<
}