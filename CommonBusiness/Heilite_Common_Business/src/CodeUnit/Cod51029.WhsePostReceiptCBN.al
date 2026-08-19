namespace GeneralLocal.GeneralLocal;
using Microsoft.Warehouse.Document;
using Microsoft.Warehouse.Structure;
using Microsoft.Warehouse.History;
using Microsoft.Sales.Setup;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Setup;
using Microsoft.Purchases.Document;
using Microsoft.Inventory.Transfer;
using Microsoft.Sales.Document;


codeunit 51029 WhsePostReceiptCBN
{
    //   HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //     # Called function "TestQtyWhseReceipt"
    //     # Code added for checking mandatory Gate Entry
    //     # Added code for updating posted Gate Entry Details

    //   HEI.03 FDD-HT658 IBM.GUNERE01 17.09.2019 # Code lines added to InitSourceDocumentHeader function,
    //                                              CheckCostByDistanceDocShipCost function added
    //                                 01.10.2019 # Code func. modified
    //   DITW111.00.13A MSF 22/04/2019 NRQ#108355 Discounts are not always posted while using warehouse location
    //   HEI.04 FDD-CHG2024489 Gate Control IBM SAXENS01  06.11.2019
    //     added code on Local Code() function
    //     Commented code written for HEI.01

    //   HEI.05 FDD-HT658 IBM.GUNERE01 01.11.2019 # InitSourceDocumentHeader func. modified
    //   HEI.06 FDD-HT1075 CHG2039144 IBM.GUNERE01 13.01.2020 # Code func. modified
    //   HEI.07 CHG2042951 IBM POENAB02 10.04.2020 # Procurement of Services Maximo - HeiLite
    //    # Modified function: Code
    //   DITW114.00.15 MSF 12/05/2020 NRQ#143673 Force Invoice From Receipt For IC Document
    //   HEI.08 CHG2109621 HT2170 IBM GAVANM01 10.06.2021 - Posting Setup for Sales Tax (Timbre), transport, free products
    //     # code added
    //   HEI.09 CHG2143756 SAHAL01 09.05.2022 # Created New Function - AllowedEmptyUnitCostOnWhseReceipt and Added Code to validate Missing Unit Cost Warning message
    //   HEI.10 CHG2165629 SAHAL01 22.07.2022
    //     # Added Code to fix the looping/undefined issue
    //   DITW114.00.15 DDR 17/04/2020 NRQ#39660 Fix skip handle promotion non-warehouse
    //   DITW114.00.15 DDR 24/04/2020 NRQ#102424 Fix allow validation promotion quantity zero
    //   DITW114.00.15 DDR 04/05/2020 NRQ#102424 Fix skip promotion non-warehouse posting
    //   HEI.11 CHG2188015 DEBUSD01 10.01.2023 Qty to Ship behavior on promotionline partialShipments
    //     # merge NRQ#39660 #102424
    //   HEI.12 CHG2188015 DEBUSD01 02.02.2023 Qty to Ship behavior on promotionline partialShipments
    //     # fix conflict with CHG2109621+CHG2188015
    //   HEI.13 CHG2191374 CC IBM MAJUMS03 13.02.2023 - Expected receipt date / Posting date - interface failed / related RITM3280410
    //     # Code is added to update the Posting Date of the Purchase Order with the Posting Date of Warehouse Receipt Posting Date
    //   HEI.14 CHG2200434 IBM COSTES04 19.05.2023 Column Data Availability of WH Shipment & WH Receipt No
    //     # Populate Whse No. in source document
    //   HEI.15 CHG2227143 IBM COSTE04 18.03.2024 Item Reclass to Support LSR Integrations-Dev
    //     # Post Item Reclass for LSR Interface

    //*********************************************************************************************************************************************************************************************************************************************
    //BC UPGRADE PATHAA02 CU5760-"Whse.-Post Receipt"-10.02.26
    //HEI.01-Event Subscribed-OnBeforePostedWhseRcptHeaderInsert & OnBeforePostedWhseRcptLineInsert-Done
    //HEI.02-Tag missing in NAV;skipped
    //HEI.03-DIT custom functions like CheckCostByDistanceDocShipCost--[Validate Cost by Distance / Route before posting]-skipped
    //HEI.04-Gate Control code added in Local Code() function-added-gatecontrol in BC-Event OnAfterCode-Done;skipped-WhseShippingTruck-DIT
    //HEI.05-Has DIT FIelds-Route, Shipping Agent Code, DocShipping COsts etc-Skipped
    //HEI.06/HEI.07-Has Text const-locText5000 and function used [WhseRcptHeader.CreateShippingCost-->T7316] is DrinkIT-Skipped
    //HEI.08-Event subscribed-OnInitSourceDocumentLinesOnBeforeProcessSalesLine; [For Sales Return Orders posted via Warehouse Receipt,only the Timbre Resource line is allowed to receive quantity. All other lines must have Return Qty. to Receive = 0.]
    //HEI.09/HEI.10- Event Subscribed-OnAfterCheckWhseRcptLine; [Empty Unit Cost restriction;System checks if Unit Cost is blank/zero and stops posting if not allowed to Prevent wrong inventory valuation due to missing cost.]
    //HEI.11-DrinkIT-Skipped
    //HEI.12-(Partial)-Event Subscribed-OnInitSourceDocumentLinesOnBeforeProcessPurchLine [In NAV, code is to skip Item Charge Lines(added for Purchase Lines). Source Document = PO&SO are not in BC under this Func, so code is not required.]
    //HEI.13-Instead of using event OnPostSourceDocumentOnBeforePostPurchaseHeader where posting checks are already completed, Moved to OnInitSourceDocumentHeaderOnBeforePurchHeaderModify as validations should be done before posting
    //HEI.14-Events subscribed-OnInitSourceDocumentHeaderOnBeforeSalesHeaderModify & OnInitSourceDocumentHeaderOnBeforeTransHeaderModify
    //HEI.15-Done; LSR Interface Item Reclassification Logic-Added in CU58016-InterfaceDTWCode;Func:WhsePostReceiptLSR_OnAfterCode
    //*********************************************************************************************************************************************************************************************************************************************

    //CU5760-HEI.01>>
    //NAV-Fn-Code-(CreatePostedRcptHeader)->BC Std Line no:1026-OnBeforePostedWhseRcptHeaderInsert(PostedWhseReceiptHeader, WarehouseReceiptHeader)
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnBeforePostedWhseRcptHeaderInsert, '', false, false)]
    local procedure WhsePostReceipt_OnBeforePostedWhseRcptHeaderInsert(var PostedWhseReceiptHeader: Record "Posted Whse. Receipt Header"; WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    begin
        PostedWhseReceiptHeader."Gate Entry No. FND" := WarehouseReceiptHeader."Gate Entry No. FND"; //HEI.01
    end;

    //NAV-Fn-Code-(CreatePostedRcptLine)-->BC Std Line no:-1087-OnBeforePostedWhseRcptLineInsert(PostedWhseReceiptLine, WarehouseReceiptLine)

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnBeforePostedWhseRcptLineInsert, '', false, false)]
    // local procedure WhsePostReceipt_OnBeforePostedWhseRcptLineInsert(var PostedWhseReceiptLine: Record "Posted Whse. Receipt Line"; WarehouseReceiptLine: Record "Warehouse Receipt Line")

    // begin
    //     //PostedWhseReceiptLine."Gate Entry No. FND" := PostedWhseRcptHeader."Gate Entry No. FND"; //Actual NAV code but parameter-PostedWhseRcptHeader not passed in event-PATHAA02 . this event is before inserting
    // end;

    //NAV-Fn-Code-(CreatePostedRcptLine)-->BC Std Line no:-1089-OnAfterPostedWhseRcptLineInsert(PostedWhseReceiptLine, WarehouseReceiptLine);
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", 'OnAfterPostedWhseRcptLineInsert', '', false, false)]
    local procedure WhsePostReceipt_OnAfterPostedWhseRcptLineInsert(var PostedWhseReceiptLine: Record "Posted Whse. Receipt Line"; WarehouseReceiptLine: Record "Warehouse Receipt Line")
    var
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
    begin
        if not WarehouseReceiptHeader.Get(WarehouseReceiptLine."No.") then  // Fetch header explicitly (not passed in event)
            exit;
        //PostedWhseReceiptLine."Gate Entry No. FND" := PostedWhseRcptHeader."Gate Entry No. FND"; //Actual NAV code but parameter-PostedWhseRcptHeader not passed in event-PATHAA02 . this event is before inserting

        PostedWhseReceiptLine."Gate Entry No. FND" := WarehouseReceiptHeader."Gate Entry No. FND"; //Workaround-Copy header-level traceability to line-PATHAA02
        PostedWhseReceiptLine.Modify(true);
    end;

    //CU5760-HEI.01<<

    //CU5760-HEI.04-Gate Entry automatic registration>>
    //NAV-Fn-Code-->BC Line no: 188-OnAfterCode(WhseRcptHeader, WhseRcptLine, CounterSourceDocTotal, CounterSourceDocOK) 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", 'OnAfterCode', '', false, false)]
    local procedure WhsePostReceipt_OnAfterCode(var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WarehouseReceiptLine: Record "Warehouse Receipt Line"; CounterSourceDocTotal: Integer; CounterSourceDocOK: Integer)
    var
        Zone: Record Zone;
        GateEntryHeader: Record "Gate Entry Header FND";
        // WhseShippingTruck: Record "Whse. Shipping Truck";//T2014068-DIT
        WhseShippingTruck: Record Vehicle101FDW;//T2014068-DIT

    begin
        //if CounterSourceDocOK = 0 then exit; // Ensure posting actually happened-PATHAA02
        IF WarehouseReceiptHeader."Create Posted Header" THEN BEGIN
            IF WarehouseReceiptHeader."Gate Entry No. FND" <> '' THEN BEGIN
                IF Zone.GET(WarehouseReceiptHeader."Location Code", WarehouseReceiptHeader."Zone Code") THEN BEGIN
                    IF (Zone."Inbound Auto. Registration FND") AND (NOT Zone."Gate Weighing Mandatory FND") THEN
                        IF GateEntryHeader.GET(WarehouseReceiptHeader."Gate Entry No. FND") THEN BEGIN
                            GateEntryHeader."Automatic Registration" := TRUE;
                            GateEntryHeader.Registered := TRUE;
                            GateEntryHeader."Date Out" := TODAY;
                            GateEntryHeader."Time Out" := TIME;
                            GateEntryHeader.MODIFY;
                            //BC UPGRADE KUMARR78 23-06-2026++
                            IF GateEntryHeader.Registered THEN BEGIN
                                WhseShippingTruck.GET(GateEntryHeader."Vehicle No.");
                                WhseShippingTruck."Status FND" := WhseShippingTruck."Status FND"::Open;
                                WhseShippingTruck.MODIFY;
                            end;
                            //BC UPGRADE KUMARR78 23-06-2026++

                            //BC UPGRADE PATHAA02-Commented-DIT>>
                            // IF GateEntryHeader.Registered THEN BEGIN
                            //     WhseShippingTruck.GET(GateEntryHeader."Vehicle No.");
                            //     WhseShippingTruck.Status := WhseShippingTruck.Status::Open;
                            //     WhseShippingTruck.MODIFY;
                            // END;
                            //BC UPGRADE PATHAA02-Commented-DIT<<
                        END;
                END;
            END;
        END;
    end;
    //CU5750-HEI.04<<


    //CU5760-HEI.08>>
    //NAV-FN-InitSourceDocumentLines---> BC Line 391-OnInitSourceDocumentLinesOnBeforeProcessSalesLine(SalesLine, IsHandled);
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnInitSourceDocumentLinesOnBeforeProcessSalesLine, '', false, false)]
    local procedure WhsePostReceipt_OnInitSourceDocumentLinesOnBeforeProcessSalesLine(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        if SalesLine."Document Type" <> SalesLine."Document Type"::"Return Order" then // Only applies to Sales Return Orders-PATHAA02
            exit;

        SalesSetup.Get();

        if (not SalesSetup."Timbre Electronique FND") or (SalesSetup."Timbre Resource Code FND" <> SalesLine."No.") then begin

            if SalesLine."Return Qty. to Receive" <> 0 then
                SalesLine.Validate("Return Qty. to Receive", 0);
        end;
    end;

    //CU5760-HEI.08<<

    //CU5760-HEI.09/HEI.10>>
    //NAV-Fn-Code-->BC Std Line-OnAfterCheckWhseRcptLine(WhseRcptLine);
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnAfterCheckWhseRcptLine, '', false, false)]
    local procedure WhsePostReceipt_OnAfterCheckWhseRcptLine(var WarehouseReceiptLine: Record "Warehouse Receipt Line")
    begin
        IF GUIALLOWED THEN BEGIN
            IF NOT AllowedEmptyUnitCostOnWhseReceipt(WarehouseReceiptLine) THEN
                EXIT;
        END;
    end;

    LOCAL procedure AllowedEmptyUnitCostOnWhseReceipt(VAR WarehouseReceiptLine: Record "Warehouse Receipt Line") Post: Boolean
    var
        InventorySetupL: Record "Inventory Setup";
        StockkeepingUnitL: Record "Stockkeeping Unit";
        DimensionFiltersL: Query "Dimension Filters";
        SKUNotExistL: Boolean;
        Text000L: Label 'Unit Cost of an Item %1 is 0.00. Please contact Controlling Team immediately, in order to set correct Unit Cost in the system. In case you proceed with this transaction as is, accounting transactions posted will be wrong. Would you like to proceed?';
    begin

        Post := TRUE;
        InventorySetupL.GET;
        IF NOT InventorySetupL."Activate UnitCost Warn.Msg FND" THEN
            EXIT;

        CLEAR(SKUNotExistL);
        IF NOT StockkeepingUnitL.GET(WarehouseReceiptLine."Location Code", WarehouseReceiptLine."Item No.", WarehouseReceiptLine."Variant Code") THEN
            SKUNotExistL := TRUE;
        IF (StockkeepingUnitL."Unit Cost" = 0) OR SKUNotExistL THEN BEGIN
            DimensionFiltersL.SETRANGE(No, WarehouseReceiptLine."Item No.");
            IF InventorySetupL."Exclude CMG Dime. Value FND" <> '' THEN
                DimensionFiltersL.SETFILTER(Dimension_Value_Code, '<>%1', InventorySetupL."Exclude CMG Dime. Value FND");
            DimensionFiltersL.OPEN;
            IF DimensionFiltersL.READ THEN BEGIN
                IF NOT CONFIRM(Text000L, FALSE, WarehouseReceiptLine."Item No.") THEN BEGIN
                    DimensionFiltersL.CLOSE;
                    EXIT(FALSE);
                END;
            END;
            DimensionFiltersL.CLOSE;
        END;
    end;
    //CU5760-HEI.09/HEI.10<<

    //CU5760-HEI.12-SkipAttachedChargeLines BC UPGRADE PATHAA02>>
    //NAV-(Fn-InitSourceDocumentLines)-->BC-Line no:353-OnInitSourceDocumentLinesOnBeforeProcessPurchLine(PurchaseLine, IsHandled);
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnInitSourceDocumentLinesOnBeforeProcessPurchLine, '', false, false)]
    local procedure WhsePostReceipt_OnInitSourceDocumentLinesOnBeforeProcessPurchLine(var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        if (PurchaseLine.Type <> PurchaseLine.Type::Item) and  //Skipping Item Charges Lines-PATHAA02
           (PurchaseLine."Attached to Line No." <> 0) then
            IsHandled := true;
    end;
    //CU5760-HEI.12<<


    //HEI.13-CU5760>>
    /*
    //Std event-NAV (Fn:PostSourceDocument)-->BC-Line no:722-OnPostSourceDocumentOnBeforePostPurchaseHeader
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnPostSourceDocumentOnBeforePostPurchaseHeader, '', false, false)]
    local procedure WhsePostReceipt_OnPostSourceDocumentOnBeforePostPurchaseHeader(var PurchHeader: Record "Purchase Header"; WhseRcptHeader: Record "Warehouse Receipt Header"; SuppressCommit: Boolean; var CounterSourceDocOK: Integer; var IsHandled: Boolean)
    begin
        //PurchHeader."Posting Date" := WhseRcptHeader."Posting Date"; //Current NAV code
        if PurchHeader."Posting Date" <> WhseRcptHeader."Posting Date" then begin
            PurchHeader.Validate("Posting Date", WhseRcptHeader."Posting Date");
            //PurchHeader."Posting Date" := WhseRcptHeader."Posting Date";
            PurchHeader.Modify();
        end;
    end;
    */

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnInitSourceDocumentHeaderOnBeforePurchHeaderModify, '', false, false)]
    local procedure WhsePostReceipt_OnInitSourceDocumentHeaderOnBeforePurchHeaderModify(var PurchaseHeader: Record "Purchase Header"; var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; var ModifyHeader: Boolean)
    begin
        //PurchaseHeader."Posting Date" := WarehouseReceiptHeader."Posting Date"; //Current NAV code
        if PurchaseHeader."Posting Date" <> WarehouseReceiptHeader."Posting Date" then begin
            PurchaseHeader.Validate("Posting Date", WarehouseReceiptHeader."Posting Date");
            //PurchaseHeader."Posting Date" := WarehouseReceiptHeader."Posting Date";
            ModifyHeader := TRUE;
        end;
    end;
    //HEI.13-CU5760<<<

    //HEI.14-CU5760>>
    //Std event-NAV (Fn:InitSourceDocumentHeader)-->BC-Line no:300-OnInitSourceDocumentHeaderOnBeforeSalesHeaderModify(SalesHeader, WhseRcptHeader, ModifyHeader);
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnInitSourceDocumentHeaderOnBeforeSalesHeaderModify, '', false, false)]
    local procedure WhsePostReceipt_OnInitSourceDocumentHeaderOnBeforeSalesHeaderModify(var SalesHeader: Record "Sales Header"; var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; var ModifyHeader: Boolean)
    begin
        IF SalesHeader."Posted Warehouse Ship. No. FND" <> WarehouseReceiptHeader."Receiving No." THEN BEGIN
            SalesHeader."Posted Warehouse Ship. No. FND" := WarehouseReceiptHeader."Receiving No.";
            ModifyHeader := TRUE;
        end;
    end;

    //Std event-NAV (Fn:InitSourceDocumentHeader)-->BC-Line no:319-OnInitSourceDocumentHeaderOnBeforeTransHeaderModify(TransHeader, WhseRcptHeader, ModifyHeader);
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnInitSourceDocumentHeaderOnBeforeTransHeaderModify, '', false, false)]
    local procedure WhsePostReceipt_OnInitSourceDocumentHeaderOnBeforeTransHeaderModify(var TransferHeader: Record "Transfer Header"; var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; var ModifyHeader: Boolean)
    begin
        IF TransferHeader."Posted Whse. Receipt No. FND" <> WarehouseReceiptHeader."Receiving No." THEN BEGIN
            TransferHeader."Posted Whse. Receipt No. FND" := WarehouseReceiptHeader."Receiving No.";
            ModifyHeader := TRUE;
        END;
    end;
    //HEI.14-CU5760<<

}
