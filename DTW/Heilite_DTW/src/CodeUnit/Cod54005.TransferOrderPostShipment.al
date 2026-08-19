codeunit 54005 "Transfer Order Post Shipment"
{

    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Code added for checking mandatory Gate Entry
    //   # Added code for updating posted Gate Entry Details

    // HEI.02 FDD-HT658 IBM.GUNERE01 23.09.2019 # PostShippingCosts, UpdatePostedShippingCost funcs. added
    //                                          # LoC added to Code()
    // HEI.03 FDD-HT658 IBM.GUNERE01 29.10.2019 # PostShippingCosts func. modified
    // HEI.04 CHG2039144 FDD-HT949 IBM.GUNERE01 12.02.2019 # GetWarehouseSetup, CalcTotalPerUOMShippingCosts funcs. added
    //                                                     # PostShippingCosts, UpdatePostedShippingCost funcs. modified
    // HEI.05 FDD-HT1075 CHG2039144 IBM.GUNERE01 15.01.2020 # PostShippingCosts func. modified
    // HEI.06 CHG2069113 IBM.GUNERE01 18.06.2020 #PostShippingCosts, CalcTotalPerUOMShippingCosts funcs modified
    // HEI.07 FDD-HT1304 IBM NASTAA02 14.07.2020 # IC Transfer Order Automation
    //   # Code added to update "IC Shipment Adjusted" Field
    // HEI.08 FDD-HB1438 CHG2065311 IBM SHANKJ03 30.07.2020
    //   # code added to update "PO Reference"
    // CHG2104608: DITW111.00.13 ISL 18/12/2018 NRQ#96024 Updated code (Deleted field "Prod. BOM Version Code")
    // HEI.10 CHG2093869 GAVANM01 05.03.2021 #Transfer and Stock adjustments interfaces Bahamas LS Retail
    //   # fill in the LSR Order No for Transfer Shipment
    // HEI.11 CHG2200434 IBM COSTES04 19.05.2023 Column Data Availability of WH Shipment & WH Receipt No
    //   # Populate Whse No. in source document
    // HEI.12 CHG2244491 IBM COSTES02 12.11.2024 Gate Control relation to having Zone and Bin Codes mandator
    //   # update condition from IsTransferGateEntryMandatory
    // HEI.13 CHG2282709 IBM COSTES02 03.03.2025 Gate Control relation to having Zone and Bin Codes mandator
    //   # update condition from IsTransferGateEntryMandatory
    // HEI.14 CHG2302652 IBM COSTES04 07.05.2025 Excluding Sales Invoice and Sales Credit Memo to the Change
    //   # skip gate control
    //********************************************************************************************************************************************************************
    //BC UPGRADE PATHAA02-30.01.26 CU5704-"TransferOrder-Post Shipment"(DTWExt)
    //HEI.01-Subscribed to Events--> OnBeforeInsertTransShptLine, OnBeforeInsertTransShptLine ;Procedures-IsTransGateEntryMandatory, UpdateOutboundGateEntry;To initialize Global variable-OnAfterCheckInvtPostingSetup
    //HEI.02-HEI.03; Shipping Cost related changes not included in this codeunit as it is DrinkIT 
    //HEI.04-HEI.06; CHG2039144-Transport Cost Calculation enhancement-DIT
    //HEI.08-Event Subscribed-->OnBeforeInsertTransShptHeader
    //HEI.09-No tag
    //HEI.11-Event Subscribed-->OnBeforeInsertTransShptHeader
    //HEI.12-HEI.13; Changes included in IsTransGateEntryMandatory procedure
    //HEI.14-Event Subscribed-->OnBeforeInsertTransShptHeader
    //********************************************************************************************************************************************************************

    var
        TempWhseShptHeader: Record "Warehouse Shipment Header" temporary;
        WhseShip: Boolean;
        GateEntryLoc: Code[20];
        GateEntryZone: Code[10];
        TransferHeaderG: Record "Transfer Header";
        TransShptHeaderG: Record "Transfer Shipment Header";

    //BC UPGRADE PATHAA02-Event Subscribed to initialize Global variables used in other Event Subscribers-line102(OnAfterCheckInvtPostingSetup)>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnAfterCheckInvtPostingSetup, '', false, false)]
    local procedure OnAfterCheckInvtPostingSetup(var TransferHeader: Record "Transfer Header"; var TempWhseShipmentHeader: Record "Warehouse Shipment Header" temporary; var SourceCode: Code[10])
    begin

        TempWhseShptHeader := TempWhseShipmentHeader;
        WhseShip := TempWhseShptHeader.FindFirst();
        TransferHeaderG := TransferHeader;
    end;
    //BC UPGRADE PATHAA02-Event Subscribed to initialize Global variables used in other Event Subscribers<<


    //Std--> Line 108(InsertTransShptHeader)--> Line 532(OnBeforeInsertTransShptHeader)//PATHAA02
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnBeforeInsertTransShptHeader, '', false, false)]
    local procedure OnBeforeInsertTransShptHeader(var TransShptHeader: Record "Transfer Shipment Header"; TransHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
    begin
        // HEI.08 >>
        TransShptHeader."PO Reference FND" := TransHeader."PO Reference FND";
        TransShptHeader."Extra PO Reference FND" := TransHeader."Extra PO Reference FND";
        // HEI.08 <<

        //HEI.01>>
        TransShptHeader."From Gate Entry No. FND" := TempWhseShptHeader."Gate Entry No. FND";
        GateEntryLoc := TransHeader."In-Transit Code";

        IF WhseShip THEN BEGIN
            GateEntryLoc := TempWhseShptHeader."Location Code";
            GateEntryZone := TempWhseShptHeader."Zone Code";
        END;

        IF WhseShip THEN//HEI.14
            IF IsTransGateEntryMandatory(GateEntryLoc, GateEntryZone) THEN
                TransShptHeader.TESTFIELD("From Gate Entry No. FND");
        //HEI.01<<

        //TransShptHeader."LSR Order No" := TransHeader."LSR Order No";  //HEI.10 //BC UPGRADE PATHAA02-will be moved to Interface Extension
        TransShptHeader."Posted Whse. Shipment No. FND" := TransHeader."Posted Whse. Shipment No. FND";//HEI.11
    end;

    procedure IsTransGateEntryMandatory(LocationCode: Code[20]; ZoneCode: Code[20]): Boolean
    var
        LocationRec: Record Location;
        ZoneRec: Record Zone;
    begin
        //HEI.01>>
        //>>HEI:EDD001:1:1
        //HEI.12>>
        //IF LocationRec.GET(LocationCode) AND ZoneRec.GET(LocationCode,ZoneCode) THEN BEGIN
        //HEI.13>>
        //IF LocationRec.GET(LocationCode) OR ZoneRec.GET(LocationCode,ZoneCode) THEN BEGIN
        //IF LocationRec."Transfer Gate Entry Mandatory" OR ZoneRec."Transfer Gate Entry Mandatory" THEN
        IF (ZoneCode <> '') AND ZoneRec.GET(LocationCode, ZoneCode) THEN
            EXIT(ZoneRec."Transf.Gate EntryMandatory FND");

        IF LocationRec.GET(LocationCode) THEN BEGIN
            IF LocationRec."Transfer Gate Entry Mandat FND" THEN
                //HEI.13<<
                //HEI.12<<
                EXIT(TRUE)
            ELSE
                EXIT(FALSE);
        END ELSE
            EXIT(FALSE);
        //<<HEI:EDD001:1:1
        //HEI.01<<
    end;

    //Std-->Line 155(InsertTransShptLine(TransShptHeader)--> Line 568(OnBeforeInsertTransShptLine)//PATHAA02
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnBeforeInsertTransShptLine, '', false, false)]
    local procedure OnBeforeInsertTransShptLine(var TransShptLine: Record "Transfer Shipment Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var IsHandled: Boolean; TransShptHeader: Record "Transfer Shipment Header")
    begin
        //HEI.01>>
        TransShptLine."From Gate Entry No. FND" := TransShptHeader."From Gate Entry No. FND";
        IF TransShptLine."From Gate Entry No. FND" <> '' THEN BEGIN
            IF WhseShip THEN
                UpdateOutboundGateEntry(TransShptLine."From Gate Entry No. FND", TransShptLine.Quantity, TransShptLine."Item No.",
                                         TransShptLine."Gross Weight", TransShptLine."Unit of Measure Code",
                                         TransShptLine."In-Transit Code");
        END;
        //HEI.01<<

        //TransShptLine."IC Shipment Adjusted" := TransHeader."IC Document"; //HEI.07
        //TransShptLine."IC Shipment Adjusted" := TransferHeaderG."IC Document"; //HEI.07 //BC UPGRADE PATHAA02(coming from event-OnAfterCheckInvtPostingSetup)

        TransShptHeaderG := TransShptHeader; //PATHAA02-Global variable for use in other Event Subscribers
    end;

    procedure UpdateOutboundGateEntry(GateEntryNo: Code[20]; OutboundQuantity: Decimal; ItemNo: Code[20]; OutboundWeight: Decimal; UnitOfMeasure: Code[20]; LocationCode: Code[20])
    var
        GateEntryLine: Record "Gate Entry Line FND";
        GateEntryHeader: Record "Gate Entry Header FND";
    begin
        //HEI.01>>
        //>>HEI:EDD151:1:1
        GateEntryLine.RESET;
        GateEntryLine.SETRANGE("Gate Entry Document No.", GateEntryNo);
        GateEntryLine.SETRANGE("Unit Of Measure Code", UnitOfMeasure);
        GateEntryLine.SETRANGE("Location Code", LocationCode);
        IF GateEntryLine.FINDFIRST THEN BEGIN
            GateEntryLine."Posted Quantity Outbound" += OutboundQuantity;
            GateEntryLine."Reference Document" := GateEntryLine."Reference Document"::"Posted Transfer Shipment";
            //GateEntryLine."Reference No." := TransShptHeader."No."; //BC UPGRADE PATHAA02
            GateEntryLine."Reference No." := TransShptHeaderG."No."; //BC UPGRADE PATHAA02 (used Global variable,value from event-OnBeforeInsertTransShptLine)
            GateEntryLine.MODIFY;
        END;
        IF GateEntryHeader.GET(GateEntryNo) THEN BEGIN
            GateEntryHeader."Posted Weight Outbound" += OutboundWeight;
            GateEntryHeader."Document Type" := GateEntryHeader."Document Type"::"Transfer Order";
            // GateEntryHeader."Document No." := TransShptHeader."Transfer Order No.";//BC UPGRADE PATHAA02
            GateEntryHeader."Document No." := TransShptHeaderG."Transfer Order No.";//BC UPGRADE PATHAA02 (used Global variable,value from event-OnBeforeInsertTransShptLine)
            GateEntryHeader."Reference Document" := GateEntryHeader."Reference Document"::"Posted Transfer Shipment";
            //GateEntryHeader."Reference No." := TransShptHeader."No.";//BC UPGRADE PATHAA02
            GateEntryHeader."Reference No." := TransShptHeaderG."No.";//BC UPGRADE PATHAA02 (used Global variable,value from event-OnBeforeInsertTransShptLine)
            GateEntryHeader.MODIFY;
        END;
        //<<HEI:EDD151:1:1
        //HEI.01<<
    end;
    //BC UPGRADE KUMARR78 FDD-MTC-007 ++
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", OnBeforePostedWhseShptHeaderInsert, '', false, false)]
    local procedure OnBeforePostedWhseShptHeaderInsert(var PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header"; WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
        GateEntryLoc: Code[20];
        GateEntryZone: Code[10];
    begin
        //BC UPGRADE KUMARR78 ++29-06-2026
        if (WarehouseShipmentHeader."Source Document Type FND" = WarehouseShipmentHeader."Source Document Type FND"::"Inbound Transfer") or
        (WarehouseShipmentHeader."Source Document Type FND" = WarehouseShipmentHeader."Source Document Type FND"::"Outbound Transfer") then begin
            //BC UPGRADE KUMARR78 ++29-06-2026

            //BC UPGRADE KUMARR78 ++
            Clear(GateEntryLoc);
            Clear(GateEntryZone);
            GateEntryLoc := WarehouseShipmentHeader."Location Code";
            GateEntryZone := WarehouseShipmentHeader."Zone Code";
            IF IsTransGateEntryMandatory(GateEntryLoc, GateEntryZone) THEN
                WarehouseShipmentHeader.TESTFIELD("Gate Entry No. FND");
            PostedWhseShipmentHeader."Gate Entry No. FND" := WarehouseShipmentHeader."Gate Entry No. FND";
        end;//BC UPGRADE KUMARR78 ++29-06-2026
    end;
    //BC UPGRADE KUMARR78 ++

    //BC UPGRADE KUMARR78 ++
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnBeforePostedWhseRcptHeaderInsert, '', false, false)]
    local procedure OnBeforePostedWhseRcptHeaderInsert(var PostedWhseReceiptHeader: Record "Posted Whse. Receipt Header"; WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        GateEntryLoc1: Code[20];
        GateEntryZone1: Code[10];
        TransHeader: Record "Transfer Header";//BC UPGRADE KUMARR78 24-06-2026++
    begin
        //BC UPGRADE KUMARR78 ++29-06-2026
        if (WarehouseReceiptHeader."Source Document Type FND" = WarehouseReceiptHeader."Source Document Type FND"::"Inbound Transfer") or
        (WarehouseReceiptHeader."Source Document Type FND" = WarehouseReceiptHeader."Source Document Type FND"::"Outbound Transfer") then begin
            //BC UPGRADE KUMARR78 ++29-06-2026
            if TransHeader.Get(WarehouseReceiptHeader."Source No. FND") then;//BC UPGRADE KUMARR78 24-06-2026++

            Clear(GateEntryLoc1);
            Clear(GateEntryZone1);
            GateEntryLoc1 := WarehouseReceiptHeader."Location Code";
            GateEntryZone1 := WarehouseReceiptHeader."Zone Code";
            TransHeader.CalcFields("Import Identifier FND");//BC UPGRADE KUMARR78 24-06-2026++
            IF TransHeader."Import Identifier FND" = false then begin //BC UPGRADE KUMARR78 24-06-2026++
                IF IsTransGateEntryMandatory(GateEntryLoc1, GateEntryZone1) THEN
                    WarehouseReceiptHeader.TESTFIELD("Gate Entry No. FND");
            end;
            PostedWhseReceiptHeader."Gate Entry No. FND" := WarehouseReceiptHeader."Gate Entry No. FND";
        end;
    end;//BC UPGRADE KUMARR78 ++29-06-2026
    //BC UPGRADE KUMARR78 FDD-MTC-007++


}