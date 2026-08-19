codeunit 51032 "Whse Post Shipment Events CBN"
{

    SingleInstance = true;

    //BC UPGRADE KUMARR78 >>
    // 1. Created new Integration Events and supporting procedures migrated from 
    //    Codeunit 5763 - "Whse.-Post Shipment" (NAV18 standard).
    // 2. NAV Reference:
    //    Object: Codeunit 5763 - "Whse.-Post Shipment"
    //    Lines: 914 to 965
    //    Analysis:
    //      - Reviewed for standard event availability in Business Central.
    //      - Logic identified as DIT customization.
    //      - Since no standard Integration Event exists in BC for this block,
    //        custom event handling decision required.
    // 3. FIND Function Change (BC Compatibility):
    //    NAV Old Code:
    //        IF FIND('-') THEN BEGIN   // Blocking by HEI
    //
    //    BC Updated Code:
    //        IF FINDFIRST THEN BEGIN   // Added by HEI
    //
    //    Reason:
    //      - FIND('-') is legacy syntax.
    //      - Replaced with FindFirst() for SaaS compatibility and readability.
    // 4. HEI Custom Code Migration:
    //      - Entire HEI customization from NAV Codeunit 5763 migrated.
    //      - Some events intentionally commented.
    //      - Reason: These events must be relocated to separate extensions
    //        as per BC extension architecture best practices.
    //      - Ensures clean separation of custom logic and avoids base modification.
    // Upgrade Type:
    //      - Custom Event Injection
    //      - Legacy FIND replacement
    //      - DIT customization review
    //      - Extension-based refactoring

    //BC UPGRADE KUMARR78 <<
    // BC Upgrade RD03 - Not possible in BC
    // Commending #IF FIND('-') THEN# is not possible, the original code #if WhseShptLine.Find('-') THEN# will works as it is
    // BC Upgrade RD03 - in NAV 5763 handles Sales, Transfer and Purchase Whse posting, but in BC splitted into 3 CU, instead of creating 3 CU like BC, we added all our custom code which is available in 5763 are here.
    // BC Upgrade RD03 - Drint it Table and related fields commended ---------->>

    // BC Upgrade MISHRS14 >>
    // Blocked with statement to remove warning in procedure - AllowedEmptyUnitCostOnWhseShipment and variable were already prefixed.
    // BC Upgrade MISHRS14 <<


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", OnAfterCheckWhseShptLine, '', false, false)]
    local procedure OnAfterCheckWhseShptLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line")
    begin
        if GuiAllowed then begin
            if not AllowedEmptyUnitCostOnWhseShipment(WarehouseShipmentLine) then
                exit;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", OnCodeOnAfterGetWhseShptHeader, '', false, false)]
    local procedure OnCodeOnAfterGetWhseShptHeader(var WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
    begin
        CheckShipmentDateMandatory(WarehouseShipmentHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", OnCodeOnAfterWhseShptHeaderModify, '', false, false)]
    local procedure OnCodeOnAfterWhseShptHeaderModify(var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; Print: Boolean)
    begin
        InitPostedWhseShipmentNo(WarehouseShipmentHeader."No.");//HEI.01
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", OnAfterPostWhseShipment, '', false, false)]
    local procedure OnAfterPostWhseShipment(var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; SuppressCommit: Boolean; var IsHandled: Boolean)
    var
        RecWhareShipmentLine: Record "Warehouse Shipment Line";
    begin
        //BC UPGRADE KUMARR78 >> Blocking Migrated Code As CreateShippingCost is DIT Function.
        // if RecWhareShipmentLine.Get(WarehouseShipmentHeader."No.") then begin
        //     IF RecWhareShipmentLine."Shipping Advice" = RecWhareShipmentLine."Shipping Advice"::Partial THEN
        //         WarehouseShipmentHeader.CreateShippingCost;
        // end;
        //BC UPGRADE KUMARR78 << Blocking Migrated Code As CreateShippingCost is DIT Function.
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Whse. Post Shipment", OnInitSourceDocumentHeaderOnBeforeSalesHeaderModify, '', false, false)]
    local procedure OnInitSourceDocumentHeaderOnBeforeSalesHeaderModify(var SalesHeader: Record "Sales Header"; var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var ModifyHeader: Boolean; WhsePostParameters: Record "Whse. Post Parameters"; var WarehouseShipmentLine: Record "Warehouse Shipment Line")
    var
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesReturnOrder: Record "Sales Header";
        SalesReturnOrderLine: Record "Sales Line";
    begin
        IF (WarehouseShipmentHeader."Shipment Date" <> 0D) AND (WarehouseShipmentHeader."Shipment Date" <> SalesHeader."Shipment Date") THEN BEGIN
            //HEI.13>>
            IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN
                ArchiveManagement.ArchSalesDocumentNoConfirm(SalesHeader);
            //HEI.13<<
            SalesHeader."Shipment Date" := WarehouseShipmentHeader."Shipment Date";
            ModifyHeader := TRUE;
        END;

        //HEI.01 IBM PATHAA02 Code Migrated from Helite 2.0 for LOGGAP07>>
        IF (WarehouseShipmentHeader."Shipping No." <> '')
         AND (WarehouseShipmentHeader."Shipping No." <> SalesHeader."Posted Warehouse Ship. No. FND") THEN BEGIN
            SalesHeader."Posted Warehouse Ship. No. FND" := WarehouseShipmentHeader."Shipping No.";

            SalesHeader."Whse. Shipment No. FND" := WarehouseShipmentHeader."No."; //AK

            ModifyHeader := TRUE;
            //If there is a return order
            SalesReturnOrder.SETRANGE("Document Type", SalesReturnOrder."Document Type"::"Return Order");
            // SalesReturnOrder.SETRANGE("Link Sales Document No.", SalesHeader."No.");//BC UPGRADE KUMARR78 Blocking DIT Variable
            IF SalesReturnOrder.FINDSET() THEN
                REPEAT
                    SalesReturnOrder."Posted Warehouse Ship. No. FND" := WarehouseShipmentHeader."Shipping No.";
                    SalesReturnOrder.MODIFY();
                    SalesReturnOrderLine.SETRANGE("Document Type", SalesReturnOrder."Document Type"::"Return Order");
                    SalesReturnOrderLine.SETRANGE("Document No.", SalesReturnOrder."No.");
                    IF SalesReturnOrderLine.FINDSET() THEN
                        REPEAT
                            SalesReturnOrderLine."Posted Whse. Shpmnt No. FND" := WarehouseShipmentHeader."Shipping No.";
                            SalesReturnOrderLine.MODIFY();
                        UNTIL SalesReturnOrderLine.NEXT() = 0;
                UNTIL SalesReturnOrder.NEXT() = 0;
        END;
        // BC Upgrade RD03 - Drint it Table and related fields commended ---------->>
        /*IF SalesHeader.Route <> '' THEN BEGIN
            RouteRec.GET(SalesHeader.Route);
            //>> HEI.06 FDD-HT658 IBM.GUNERE01 17.09.2019
            IF RouteRec."Shipping Agent Code Mantatory" THEN
                WhseShptHeader.TESTFIELD("Shipping Agent Code");
            IF RouteRec."Ship. Ag. Serv. Code Mandatory" THEN
                WhseShptHeader.TESTFIELD("Shipping Agent Service Code");
            IF RouteRec."Driver Mandatory" THEN
                WhseShptHeader.TESTFIELD("Driver Code");
            IF RouteRec."Truck No. Mandatory" THEN
                WhseShptHeader.TESTFIELD("Truck Code");
            //<< HEI.06 FDD-HT658 IBM.GUNERE01 17.09.2019
        END;*/
        // BC Upgrade RD03 - Drint it Table and related fields commended ------------<<

        //-------------------------------------------------------------------------------------------------------//
        //BC UPGRADE KUMARR78 >> Blocking DIT Code.

        //>> HEI.06 FDD-HT658 IBM.GUNERE01 17.09.2019
        // WarehouseShipmentHeader.CALCFIELDS("Document Shipping Costs");
        // IF WarehouseShipmentHeader."Document Shipping Costs" = TRUE THEN
        //     CheckCostByDistanceDocShipCost(WarehouseShipmentHeader);
        //<< HEI.06 FDD-HT658 IBM.GUNERE01 17.09.2019

        //BC UPGRADE KUMARR78 << Blocking DIT Code.
        //-------------------------------------------------------------------------------------------------------//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Whse. Post Shipment", OnInitSourceDocumentHeaderOnBeforePurchHeaderModify, '', false, false)]
    local procedure OnInitSourceDocumentHeaderOnBeforePurchHeaderModify(var PurchaseHeader: Record "Purchase Header"; var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var ModifyHeader: Boolean)
    begin
        // BC Upgrade RD03 - Drint it Table and related fields commended ---------->>
        /*IF RouteRec."Shipping Agent Code Mantatory" THEN
            WhseShptHeader.TESTFIELD("Shipping Agent Code");
        IF RouteRec."Ship. Ag. Serv. Code Mandatory" THEN
            WhseShptHeader.TESTFIELD("Shipping Agent Service Code");
        IF RouteRec."Driver Mandatory" THEN
            WhseShptHeader.TESTFIELD("Driver Code");
        IF RouteRec."Truck No. Mandatory" THEN
            WhseShptHeader.TESTFIELD("Truck Code");
        //<< HEI.06 FDD-HT658 IBM.GUNERE01 17.09.2019
        //>> HEI.06 FDD-HT658 IBM.GUNERE01 17.09.2019
        WarehouseShipmentHeader.CALCFIELDS("Document Shipping Costs");
        IF WarehouseShipmentHeader."Document Shipping Costs" = TRUE THEN
            CheckCostByDistanceDocShipCost(WarehouseShipmentHeader);*/
        // BC Upgrade RD03 - Drint it Table and related fields commended ----------<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Transfer Whse. Post Shipment", OnInitSourceDocumentHeaderOnBeforeTransHeaderModify, '', false, false)]
    local procedure OnInitSourceDocumentHeaderOnBeforeTransHeaderModify(var TransferHeader: Record "Transfer Header"; var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var ModifyHeader: Boolean)
    begin
        //HEI.20>>
        IF TransferHeader."Posted Whse. Shipment No. FND" <> WarehouseShipmentHeader."Shipping No." THEN BEGIN
            TransferHeader."Posted Whse. Shipment No. FND" := WarehouseShipmentHeader."Shipping No.";
            ModifyHeader := TRUE;
        END;
        // BC Upgrade RD03 - Drint it Table and related fields commended ---------->>
        /*IF RouteRec."Shipping Agent Code Mantatory" THEN
            WhseShptHeader.TESTFIELD("Shipping Agent Code");
        IF RouteRec."Ship. Ag. Serv. Code Mandatory" THEN
            WhseShptHeader.TESTFIELD("Shipping Agent Service Code");
        IF RouteRec."Driver Mandatory" THEN
            WhseShptHeader.TESTFIELD("Driver Code");
        IF RouteRec."Truck No. Mandatory" THEN
            WhseShptHeader.TESTFIELD("Truck Code");
        //<< HEI.06 FDD-HT658 IBM.GUNERE01 17.09.2019
        //>> HEI.06 FDD-HT658 IBM.GUNERE01 17.09.2019
        WarehouseShipmentHeader.CALCFIELDS("Document Shipping Costs");
        IF WarehouseShipmentHeader."Document Shipping Costs" = TRUE THEN
            CheckCostByDistanceDocShipCost(WarehouseShipmentHeader);*/
        // BC Upgrade RD03 - Drint it Table and related fields commended ----------<<

        IF ModifyHeader THEN
            TransferHeader.MODIFY();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Whse. Post Shipment", OnPostSourceDocumentOnBeforePrintSalesShipment, '', false, false)]
    local procedure OnPostSourceDocumentOnBeforePrintSalesShipment(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var SalesShptHeader: Record "Sales Shipment Header"; WhseShptHeader: Record "Warehouse Shipment Header")
    var
        WhseSetup: Record "Warehouse Setup";
        LocationL: Record Location;
        WhseShptLine: Record "Warehouse Shipment Line";

    begin
        SalesShptHeader."Document Subtype Code FND" := SalesHeader."Document Subtype Code FND";
        WhseSetup.GET;//HEI.01
        if WhseShptLine.Get(WhseShptHeader."No.") then;

        IF WhseShptLine."Location Code" <> '' THEN
            LocationL.GET(WhseShptLine."Location Code");
        IF (WhseSetup."Enable Post & Print on Loc FND" AND
           LocationL."Print Loading Note FND")
        OR
          (NOT WhseSetup."Enable Post & Print on Loc FND" AND
          WhseShptLine."Print Load List Shipment FND")
        THEN
            PrintLoadListShipment(WhseShptLine);

        //BC UPGRADE SHUKLP03 >> Document subtype
        //HEI.11>>
        IF WhseSetup."Enable Post & Print on Loc FND" AND
            LocationL."Print DN (Whse Ship) FND"
        THEN
            PrintDeliveryNoteWhseShip(SalesShptHeader."No.", SalesShptHeader."Document Subtype Code FND");
        //HEI.11<<
        //BC UPGRADE SHUKLP03 << Document subtype
    end;

    // BC Upgrade SHUKLP03 >> Subscribed event to add invoice condition code.
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Whse. Post Shipment", OnPostSourceDocumentOnBeforePrintSalesInvoice, '', false, false)]
    local procedure OnPostSourceDocumentOnBeforePrintSalesInvoice(var SalesHeader: Record "Sales Header"; var WhseShptLine: Record "Warehouse Shipment Line")
    var
        WhseSetup: Record "Warehouse Setup";
        LocationL: Record Location;
        SalesInvHeader: Record "Sales Invoice header";
    begin
        //HEI.10>>
        SalesInvHeader.SetRange("Order No.", SalesHeader."No.");
        If SalesInvHeader.FindFirst() then begin
            SalesInvHeader."Document Subtype Code FND" := SalesHeader."Document Subtype Code FND";
            //HEI.10<<
            //HEI.08>>
            //HEI.11>>
            WhseSetup.get();

            IF WhseShptLine."Location Code" <> '' THEN
                LocationL.GET(WhseShptLine."Location Code");
            IF (WhseSetup."Enable Post & Print on Loc FND" AND
               LocationL."Print Invoice FND")
            OR
              NOT WhseSetup."Enable Post & Print on Loc FND"
            THEN
                //HEI.11<<
                //HEI.08<<
                SalesInvHeader.PrintRecords(FALSE);
            IF SalesInvHeader."No." <> '' THEN BEGIN
                //HEI.09>>
                //HEI.11>>
                IF WhseSetup."Enable Post & Print on Loc FND" AND
                   LocationL."Print DN (Sales Ship) FND"
                THEN
                    //HEI.11<<
                    PrintDeliveryNoteSalesInv(SalesInvHeader."No.", SalesInvHeader."Document Subtype Code FND");
                //HEI.09<<
            end;

        end;
    END;

    // BC Upgrade SHUKLP03 << Subscribed event to add invoice condition code.

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Transfer Whse. Post Shipment", OnPostSourceDocumentOnBeforeCaseTransferLine, '', false, false)]
    local procedure OnPostSourceDocumentOnBeforeCaseTransferLine(var TransferHeader: Record Microsoft.Inventory.Transfer."Transfer Header"; WarehouseShipmentLine: Record "Warehouse Shipment Line")
    var
        PartialShipNotAllowed: TextConst ENU = 'IC Transfer Order must be completely shipped.';
        WhseShptHeader: Record "Warehouse Shipment Header";
    begin
        if WhseShptHeader.Get(WarehouseShipmentLine."No.") then; //BC UPGRADE KUMARR78 get "Warehouse Shipment Header" for Function Parameter.
        //HEI.12>>
        IF TransferHeader."IC Document FND" THEN
            IF WarehouseShipmentLine.Quantity <> WarehouseShipmentLine."Qty. to Ship" THEN
                ERROR(PartialShipNotAllowed);

        SetWarehouseShipment(WhseShptHeader, WarehouseShipmentLine);
        //HEI.12<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", OnBeforePostedWhseShptHeaderInsert, '', false, false)]
    local procedure OnBeforePostedWhseShptHeaderInsert(var PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header"; WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    begin
        // BC Upgrade RD03 - Drink it field commended --------->>
        //PostedWhseShipmentHeader.Distance := PostedWhseShipmentHeader.Distance;
        // BC Upgrade RD03 - Drink it field commended ---------<<
        PostedWhseShipmentHeader."Gate Entry No. FND" := WarehouseShipmentHeader."Gate Entry No. FND"; //HEI.03
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", OnCreatePostedShptLineOnBeforePostedWhseShptLineInsert, '', false, false)]
    local procedure OnCreatePostedShptLineOnBeforePostedWhseShptLineInsert(var PostedWhseShptLine: Record "Posted Whse. Shipment Line"; WhseShptLine: Record "Warehouse Shipment Line")
    var
        PostedWhseShptHeader: Record "Posted Whse. Shipment Header";
    begin
        if PostedWhseShptHeader.Get(PostedWhseShptLine."No.") then;//BC UPGRADE KUMARR78 Adding to Get Header.

        PostedWhseShptLine."Gate Entry No. FND" := PostedWhseShptHeader."Gate Entry No. FND"; //HEI.03
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Whse. Post Shipment", OnBeforeHandleSalesLine, '', false, false)]
    local procedure OnBeforeHandleSalesLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; WhseShptHeader: Record "Warehouse Shipment Header"; var ModifyLine: Boolean; var IsHandled: Boolean; WhsePostParameters: Record "Whse. Post Parameters")
    begin
        //<<HEI.14
        SalesLine.SETCURRENTKEY("Document Type", "Document No.");
        //>>HEI.14
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Whse. Post Shipment", OnHandleSalesLineOnSourceDocumentSalesOrderOnBeforeModifyLine, '', false, false)]
    local procedure OnHandleSalesLineOnSourceDocumentSalesOrderOnBeforeModifyLine(var SalesLine: Record "Sales Line"; WhseShptLine: Record "Warehouse Shipment Line"; WhsePostParameters: Record "Whse. Post Parameters")
    var
        WhseShptHeader: Record "Warehouse Shipment Header";
    begin
        if WhseShptHeader.Get(WhseShptLine."No.") then; //BC UPGRADE KUMARR78 Adding to Get Header.
        SalesLine."Posted Whse. Shpmnt No. FND" := WhseShptHeader."Shipping No.";
    end;

    //BC UPGRADE KUMARR78 >> Need to move this event into DTW Ext.
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Transfer Whse. Post Shipment", OnPostSourceDocumentOnBeforePrintTransferShipment, '', false, false)]
    // local procedure OnPostSourceDocumentOnBeforePrintTransferShipment(var TransferHeader: Record "Transfer Header"; var IsHandled: Boolean)
    // begin
    //     SendICTransferOrder();
    // end;
    // LOCAL procedure SendICTransferOrder()
    // var
    //     ICTransferOrderWS: Codeunit "IC Transfer Order WS";
    // begin
    //     //HEI.12>>
    //     IF WarehouseShipmentLineBuffer."Source Document" = WarehouseShipmentLineBuffer."Source Document"::"Outbound Transfer" THEN
    //         IF TransferHeader.GET(WarehouseShipmentLineBuffer."Source No.") THEN
    //             IF TransferHeader."IC Document" THEN
    //                 IF IsTransferVirtualLocation(TransferHeader."Transfer-to Code") THEN
    //                     ICTransferOrderWS.ExportTransferOrderIC(WarehouseShipmentLineBuffer);
    //     IF WarehouseShipmentHeaderBuffer.FINDFIRST THEN
    //         WarehouseShipmentHeaderBuffer.DELETEALL;
    //     IF WarehouseShipmentLineBuffer.FINDFIRST THEN
    //         WarehouseShipmentLineBuffer.DELETEALL;
    //     //HEI.12<<
    // end;
    // LOCAL procedure IsTransferVirtualLocation(TransferToCode: Code[10]): Boolean
    // var
    //     Location: Record Location;
    // begin
    //     //HEI.12>>
    //     Location.RESET;
    //     IF Location.GET(TransferToCode) THEN
    //         EXIT(NOT Location."Bin Mandatory" AND
    //            NOT Location."Require Shipment" AND
    //            NOT Location."Require Receive")
    //     ELSE
    //         EXIT(FALSE);
    //     //HEI.12<<
    // end;
    //BC UPGRADE KUMARR78 << Need to move this event into DTW Ext.

    LOCAL procedure SetWarehouseShipment(WarehouseShipmentHeader: Record "Warehouse Shipment Header"; WarehouseShipmentLine: Record "Warehouse Shipment Line")
    var

    begin
        //HEI.12>>
        IF WarehouseShipmentHeaderBuffer.FINDFIRST THEN
            WarehouseShipmentHeaderBuffer.DELETEALL;
        IF WarehouseShipmentLineBuffer.FINDFIRST THEN
            WarehouseShipmentLineBuffer.DELETEALL;

        WarehouseShipmentHeaderBuffer.INIT;
        WarehouseShipmentHeaderBuffer := WarehouseShipmentHeader;
        WarehouseShipmentHeaderBuffer.INSERT;

        WarehouseShipmentLineBuffer.INIT;
        WarehouseShipmentLineBuffer := WarehouseShipmentLine;
        WarehouseShipmentLineBuffer.INSERT;
        //HEI.12<<
    end;

    local procedure InitPostedWhseShipmentNo(WhseShipmentNo: Code[20])
    var
        WarehouseShipLine: Record "Warehouse Shipment Line";
        WarehouseShipHeader: Record "Warehouse Shipment Header";
        SalesReturnOrder: Record "Sales Header";
        SalesReturnOrderLine: Record "Sales Line";
    begin
        //HEI.01 IBM PATHAA02 function Migrated from Helilite 2.0 231117>>

        WarehouseShipLine.RESET;
        WarehouseShipLine.SETRANGE(WarehouseShipLine."No.", WhseShipmentNo);
        IF WarehouseShipLine.FINDSET THEN
            REPEAT
                IF WarehouseShipLine."Source Type" = 37 THEN BEGIN
                    SalesHeader.RESET;
                    SalesHeader.SETRANGE("Document Type", WarehouseShipLine."Source Subtype");
                    SalesHeader.SETRANGE("No.", WarehouseShipLine."Source No.");
                    IF SalesHeader.FINDFIRST THEN BEGIN
                        WarehouseShipHeader.GET(WarehouseShipLine."No.");
                        IF SalesHeader."Posted Warehouse Ship. No. FND" <> WarehouseShipHeader."Shipping No." THEN BEGIN
                            SalesHeader."Posted Warehouse Ship. No. FND" := WarehouseShipHeader."Shipping No.";
                            // SalesHeader."Whse. Shipment No." := WhseShptHeader."No.";//BC UPGRADE KUMARR78 Blocking to Change WhseShptHeader."No."; to WhseShipmentNo.
                            SalesHeader."Whse. Shipment No. FND" := WhseShipmentNo; //BC UPGRADE KUMARR78 Adding to Change WhseShptHeader."No."; to WhseShipmentNo.
                            SalesHeader.MODIFY;
                            SalesReturnOrder.SETRANGE("Document Type", SalesReturnOrder."Document Type"::"Return Order");
                            // SalesReturnOrder.SETRANGE("Link Sales Document No.", SalesHeader."No.");//BC UPGRADE KUMARR78 Blocking DIT Variable
                            IF SalesReturnOrder.FINDSET THEN
                                REPEAT
                                    SalesReturnOrder."Posted Warehouse Ship. No. FND" := WarehouseShipHeader."Shipping No.";
                                    SalesReturnOrder.MODIFY;
                                    SalesReturnOrderLine.SETRANGE("Document Type", SalesReturnOrder."Document Type"::"Return Order");
                                    SalesReturnOrderLine.SETRANGE("Document No.", SalesReturnOrder."No.");
                                    IF SalesReturnOrderLine.FINDSET THEN
                                        REPEAT
                                            SalesReturnOrderLine."Posted Whse. Shpmnt No. FND" := WarehouseShipHeader."Shipping No.";
                                            SalesReturnOrderLine.MODIFY;
                                        UNTIL SalesReturnOrderLine.NEXT = 0;
                                UNTIL SalesReturnOrder.NEXT = 0;

                            // COMMIT;   // BC Upgrade SHUKLP03 << Blocked beacause not required
                        END;
                    END;
                END;

            UNTIL WarehouseShipLine.NEXT = 0;
        SalesHeader.RESET;
        //HEI.01 IBM PATHAA02 function Migrated from Helilite 2.0 231117<<
    end;

    local procedure CheckShipmentDateMandatory(WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
        SalesHeader: Record "Sales Header";
    begin
        //HEI.21>>
        if not SalesSetup."Shipment Date Mandatory FND" then
            exit;
        if WarehouseShipmentHeader."Source Document Type FND" <> WarehouseShipmentHeader."Source Document Type FND"::"Sales Order" then
            exit;
        if not SalesHeader.Get(SalesHeader."Document Type"::Order, WarehouseShipmentHeader."Source No. FND") then
            exit;
        if (SalesHeader."Source System Identifier FND" <> '') then
            exit;
        WarehouseShipmentHeader.TestField("Shipment Date");
        //HEI.21<<

    end;

    local procedure AllowedEmptyUnitCostOnWhseShipment(var WarehouseShipmentLine: Record "Warehouse Shipment Line") Post: Boolean
    var
        InventorySetupL: Record "Inventory Setup";
        StockkeepingUnitL: Record "Stockkeeping Unit";
        SKUNotExistL: Boolean;
        DimensionFiltersL: Query "Dimension Filters";
        Text000L: TextConst ENU = 'Unit Cost of an Item %1 is 0.00. Please contact Controlling Team immediately, in order to set correct Unit Cost in the system. In case you proceed with this transaction as is, accounting transactions posted will be wrong. Would you like to proceed?';
    begin
        //HEI.16>>
        Post := true;
        InventorySetupL.Get();
        if not InventorySetupL."Activate UnitCost Warn.Msg FND" then
            exit;
        //HEI.17>>
        //IF WarehouseShipmentLine.FINDFIRST THEN BEGIN

        // BC Upgrade MISHRS14 >>
        //Blocked with statement to remove warning.
        //with WarehouseShipmentLine do begin
        //HEI.17<<
        Clear(SKUNotExistL);
        if not StockkeepingUnitL.Get(WarehouseShipmentLine."Location Code", WarehouseShipmentLine."Item No.", WarehouseShipmentLine."Variant Code") then
            SKUNotExistL := true;
        if (StockkeepingUnitL."Unit Cost" = 0) or SKUNotExistL then begin
            DimensionFiltersL.SetRange(No, WarehouseShipmentLine."Item No.");
            if InventorySetupL."Exclude CMG Dime. Value FND" <> '' then
                DimensionFiltersL.SetFilter(Dimension_Value_Code, '<>%1', InventorySetupL."Exclude CMG Dime. Value FND");
            DimensionFiltersL.Open();
            if DimensionFiltersL.Read() then begin
                if not Confirm(Text000L, false, WarehouseShipmentLine."Item No.") then begin
                    //HEI.17>>
                    DimensionFiltersL.Close();
                    //HEI.17<<
                    exit(false);
                    //HEI.17>>
                end;
                //HEI.17<<
            end;
            //HEI.17>>
            DimensionFiltersL.Close();
            //HEI.17<<
        end;
        //end;
        // BC Upgrade MISHRS14 <<

    end;
    //HEI.16<<

    LOCAL procedure PrintLoadListShipment(WhseShptLine: Record "Warehouse Shipment Line")
    var
        PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header";

    begin
        //HEI.02>>
        CLEAR(ReportSelection);
        PostedWhseShipmentHeader.SETRANGE("Whse. Shipment No.", WhseShptLine."No.");
        IF PostedWhseShipmentHeader.FINDFIRST THEN BEGIN
            ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"Load List (Pst. Whse. Shipment)");
            IF ReportSelection.FINDFIRST THEN
                REPORT.RUNMODAL(ReportSelection."Report ID", FALSE, FALSE, PostedWhseShipmentHeader);
        END;
        //HEI.02<<
    end;


    //BC UPGRADE KUMARR78 >> Need to move this event into INTERFACE Ext.
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", OnAfterSetCurrentKeyForWhseShptLine, '', false, false)]
    // local procedure OnAfterSetCurrentKeyForWhseShptLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line");
    // var
    //     OrtecKStoreInterfaceSetup: Record "Ortec & KStore Interface Setup INT";
    // begin
    //     IF OrtecKStoreInterfaceSetup.GET THEN BEGIN
    //         IF OrtecKStoreInterfaceSetup."SO/SRO Interface Request" = '' THEN
    //             WarehouseShipmentLine.SETCURRENTKEY("No.", "Source Type", "Source Subtype", "Source No.", "Source Line No.")
    //         ELSE IF OrtecKStoreInterfaceSetup."SO/SRO Interface Request" <> '' THEN
    //             WarehouseShipmentLine.SETCURRENTKEY("No.", "Source Type", "Source Subtype", "Source No.", "Source Line No.", "Sequence No.");
    //     END;
    // end;
    //BC UPGRADE KUMARR78 << Need to move this event into INTERFACE Ext.

    LOCAL procedure CheckCostByDistanceDocShipCost(VAR WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
        // DocumentShippingCost: Record "Document Shipping Cost"; //BC UPGRADE KUMARR78 Blocking DIT Variable
        Text50000: TextConst ENU = 'Some ship lines remain.';
    begin
        //BC UPGRADE KUMARR78 >> Blocking Due to DIT Variable
        // DocumentShippingCost.SETRANGE("Source Type", DATABASE::"Warehouse Shipment Header");
        // DocumentShippingCost.SETRANGE("Source No.", WarehouseShipmentHeader."No.");
        // DocumentShippingCost.SETRANGE("Sub Type", 0);
        // IF DocumentShippingCost.FINDFIRST THEN
        //     IF DocumentShippingCost."Cost By Distance" = TRUE THEN
        //         IF DocumentShippingCost.Distance = 0 THEN
        //             ERROR(Text50000)
        //BC UPGRADE KUMARR78 << Blocking Due to DIT Variable
    end;


    procedure PrintDeliveryNoteWhseShip(SalesShipmentNo: Code[20]; DocSubtypeCode: Code[10])
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        //BC UPGRADE SHUKLP03 >> Document Subtype code
        //HEI.09>>
        SalesShipmentHeader.RESET();
        SalesShipmentHeader.SETRANGE("No.", SalesShipmentNo);
        IF SalesShipmentHeader.FINDFIRST() THEN BEGIN
            ReportSelection.RESET();
            ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"Delivery Note(Whse Ship)");
            ReportSelection.SETRANGE("Document Subtype Code FND", DocSubtypeCode);
            IF ReportSelection.FINDSET() THEN
                REPEAT
                    REPORT.RUNMODAL(ReportSelection."Report ID", FALSE, FALSE, SalesShipmentHeader);
                UNTIL ReportSelection.NEXT() = 0;
        END;
        //HEI.09<<
        //BC UPGRADE KUMARR78 << Document Subtype code
    end;


    procedure PrintDeliveryNoteSalesInv(SalesInvoiceHeaderNo: Code[20]; DocSubtypeCode: Code[10]) // BC Upgrade RD03 Sales Invoice Related
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        //HEI.09>>
        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETRANGE("No.", SalesInvoiceHeaderNo);
        IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
            ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"Delivery Note(Sales Invoice)");
            ReportSelection.SETRANGE("Document Subtype Code FND", DocSubtypeCode); //BC UPGRADE SHUKLP03
            IF ReportSelection.FINDSET THEN
                REPEAT
                    REPORT.RUNMODAL(ReportSelection."Report ID", FALSE, FALSE, SalesInvoiceHeader);
                UNTIL ReportSelection.NEXT = 0;
        END;
        //HEI.09<<
    end;

    // BC Upgrade SHUKLP03 >> Added procedure.
    procedure PrintDeliveryNote2(SalesInvoiceHeaderNo: Code[20]; DocSubtypeCode: Code[10]; VAR DeliveryNoteSetup: Boolean)
    SIH: Record "Sales Invoice Header";
    begin
        //HEI.05>>
        SIH.RESET();
        SIH.SETRANGE(SIH."No.", SalesInvoiceHeaderNo);
        IF SIH.FINDFIRST() THEN BEGIN
            ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"Delivery Note(Sales Invoice)");//HEI.09
            ReportSelection.SETRANGE("Document Subtype Code FND", DocSubtypeCode);
            IF ReportSelection.FINDSET() THEN BEGIN
                DeliveryNoteSetup := TRUE;
                REPEAT
                    REPORT.RUNMODAL(ReportSelection."Report ID", FALSE, FALSE, SIH);
                UNTIL ReportSelection.NEXT() = 0;
            END;
        END;
        //HEI.05<<
    end;
    // BC Upgrade SHUKLP03 << Added procedure.

    var
        SalesSetup: Record "Sales & Receivables Setup";
        SalesHeader: Record "Sales Header";
        ReportSelection: Record "Report Selections";
        WarehouseShipmentHeaderBuffer: Record "Warehouse Shipment Header" temporary;
        WarehouseShipmentLineBuffer: Record "Warehouse Shipment Line" temporary;
        TransferHeader1: Record "Transfer Header";
}
