codeunit 54006 "TransferOrder-Post Receipt-HNK"
{
    // BC Upgrade SHUKLP03 >> Codeunit 5705 "TransferOrder-Post Receipt"

    //     HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Code added for checking mandatory Gate Entry
    //   # Added code for updating posted Gate Entry Details
    // HEI.02 FDD-HT658 IBM.GUNERE01 02.09.2019 # PostShippingCosts func. modified
    //                               24.09.2019 # PostShippingCosts,UpdatePostedShippingCost funcs. added
    // HEI.03 FDD-HT658 IBM.GUNERE01 29.10.2019 # PostShippingCosts func. modified
    // HEI.04 FDD-HT658 IBM.GUNERE01 05.11.2019 # OnRun func. modified
    // HEI.05 CHG2039144 FDD-HT949 IBM.GUNERE01 12.02.2019 # GetWarehouseSetup, CalcTotalPerUOMShippingCosts funcs. added
    //                                                     # PostShippingCosts, UpdatePostedShippingCost funcs. modified
    // DITW111.00.13 DDR 09/01/2019 NRQ#97823 Fix missing calculation posted weight & cubage in transfer receipt

    // HEI.06 FDD-HT1075 CHG2039144 IBM.GUNERE01 15.01.2020 # PostShippingCosts func. modified
    // HEI.07 CHG2069113 IBM.GUNERE01 18.06.2020 #PostShippingCosts, CalcTotalPerUOMShippingCosts funcs modified
    // HEI.08 FDD-HT1304 IBM NASTAA02 14.07.2020 # IC Transfer Order Automation
    //   # Code added to update "IC Receipt Adjusted" Field
    // HEI.09 FDD-HB1438 CHG2065311 IBM SHANKJ03 30.07.2020
    //   # code added to update "PO Reference"
    // CHG2104608:DITW111.00.13 ISL 18/12/2018 NRQ#96024 Updated code (Deleted field "Prod. BOM Version Code")
    // HEI.11 CHG2100218 IBM SAXENA03 25.03.2021
    //   # Replaced FINDSET with FINDSET(false,false) of function OnRun()
    //   # Replaced FIND('-') with FINDFIRST of function OnRun()
    //   # Replaced FIND('-') with FINDFIRST of function WriteDownDerivedLines()
    //   # Added SETCURRENTKEY() in WriteDownDerivedLines()
    // NRQ201791 HMAH 12/11/2021: Fix partial receipt error
    // HEI.13 CHG2200434 IBM COSTES04 19.05.2023 Column Data Availability of WH Shipment & WH Receipt No
    //   # Populate Whse No. in source document
    // HEI.14 CHG2253923 IBM POENAB02 04.12.2024 HB3943 Stock in transit - enablement of updating standard cost
    //   # Code added in OnRun
    //   # New function created - StockInTransit
    // HEI.15 CHG2282709 IBM COSTES02 17.04.2025 Gate Control relation to having Zone and Bin Codes mandator
    //   # update condition from IsTransferGateEntryMandatory
    // HEI.16 CHG2302652 IBM COSTES04 07.05.2025 Excluding Sales Invoice and Sales Credit Memo to the Change
    //   # skip gate control


    // BC Upgrade SHUKLP03 >>
    // HEI.01 => Not added procedure UpdateInboundGateEntry() because it is not being in use of any objects also it is dummy procedure discussed with Ashfaq.
    // HEI.01 => Subscribed event OnBeforeTransRcptHeaderInsert to add code also added Procedures IsTransGateEntryMandatory() 
    // HEI.11 => Below code of HEI.11 which is on OnRun() trigger and procedure WriteDownDerivedLines() is not added.
    //   # Replaced FINDSET with FINDSET(false,false) of function OnRun()
    //   # Replaced FIND('-') with FINDFIRST of function OnRun()
    //   # Replaced FIND('-') with FINDFIRST of function WriteDownDerivedLines()
    // HEI.05, HEI.07 => Procedure CalcTotalPerUOMShippingCosts() is not added because it has DrinkIT Parameter "Posted Document Shipping Cost".
    // HEI.02 => Procedure PostShippingCosts() is not added as it dependent on DIT fields and record "Document Shipping Cost" and "Posted Document Shipping Cost" also Ashfaq is saying same. Procedure UpdatePostedShippingCost() is not added because it has DrinkIT parameter.
    // HEI.05 => Added procedure GetWarehouseSetup().
    // HEI.08 => Subscribed event OnBeforeInsertTransRcptLine
    // HEI.09 => Subscribed event OnBeforeTransRcptHeaderInsert
    // HEI.11 => Subscribed event OnBeforeWriteDownDerivedLines
    // HEI.12 => Subscribed event OnBeforeTransRcptHeaderInsert and Shared in interface extension because of field "LSR Order No".
    // HEI.13 => Subscribed event OnBeforeTransRcptHeaderInsert
    // HEI.14 => Subscribed event OnBeforeTransRcptHeaderInsert and OnRunOnBeforeCommit. Added procedure StockInTransit
    // HEI.15 => Subscribed event OnBeforeTransRcptHeaderInsert.
    // Some code part of Procedure StockInTransit() is blocked because of DrinkIT fields.
    // BC Upgrade SHUKLP03 <<

    var
        TransRcptHeaderNo: Code[20];
        TransRcptHeaderToLocation: Code[10];
        TransRcptHeaderFromLocation: Code[10];
        WarehouseSetup: Record "Warehouse Setup";
        WarehouseSetupGot: Boolean;
        PostedWhseRcptLine: Record "Posted Whse. Receipt Line";
        PostedWhseRcptHeaderG: Record "Posted Whse. Receipt Header";
        WhseRcptHeader: Record "Warehouse Receipt Header";

    [EventSubscriber(ObjectType::Codeunit, codeunit::"TransferOrder-Post Receipt", OnBeforeTransRcptHeaderInsert, '', false, false)]
    local procedure OnBeforeTransRcptHeaderInsert(TransferHeader: Record "Transfer Header"; var TransferReceiptHeader: Record "Transfer Receipt Header")
    var
        WhseRcptHeader: Record "Warehouse Receipt Header";
        WhseRcptLine: Record "Warehouse Receipt Line";
        GateEntryLoc: Code[20];
        GateEntryZone: Code[20];
        WhseReceive: Boolean;

    begin

        // BC Upgrade SHUKLP03 >> Added code to get WhseRcptHeader.
        WhseRcptLine.SetRange("Source Type", Database::"Transfer Line");
        WhseRcptLine.SetRange("Source Subtype", 1); // 1 = Outbound
        WhseRcptLine.SetRange("Source No.", TransferHeader."No.");
        if WhseRcptLine.FindFirst() then begin
            if WhseRcptHeader.Get(WhseRcptLine."No.") then begin
                // BC Upgrade SHUKLP03 << Added code to get WhseRcptHeader.

                //HEI.01>>
                TransferReceiptHeader."To Gate Entry No. FND" := WhseRcptHeader."Gate Entry No. FND";
                GateEntryLoc := TransferHeader."In-Transit Code";
                WhseReceive := WhseRcptHeader.FindFirst(); // BC Upgrade SHUKLP03 << Set variable WhseReceive value.
                IF WhseReceive THEN BEGIN
                    GateEntryLoc := WhseRcptHeader."Location Code";
                    GateEntryZone := WhseRcptHeader."Zone Code";
                END;
                TransferHeader.CALCFIELDS("Import Identifier FND");//HEI.15
                IF (NOT TransferHeader."Import Identifier FND") AND WhseReceive THEN//HEI.15//HEI.16
                    IF IsTransGateEntryMandatory(GateEntryLoc, GateEntryZone) THEN
                        TransferReceiptHeader.TESTFIELD("To Gate Entry No. FND");
                //HEI.01<<
            end;
        end;         // BC Upgrade SHUKLP03 >> Added code to get WhseRcptHeader.


        // HEI.09 >>
        TransferReceiptHeader."PO Reference FND" := TransferHeader."PO Reference FND";
        TransferReceiptHeader."Extra PO Reference FND" := TransferHeader."Extra PO Reference FND";
        // HEI.09 <<
        //TransferReceiptHeader."LSR Order No" := TransferHeader."LSR Order No";  //HEI.12  // BC Upgrade SHUKLP03 << Shared in interface extension.
        TransferReceiptHeader."Posted Whse. Receipt No. FND" := TransferHeader."Posted Whse. Receipt No. FND"; //HEI.13

        //HEI.14>>
        TransRcptHeaderNo := TransferReceiptHeader."No.";
        TransRcptHeaderToLocation := TransferHeader."Transfer-to Code";
        TransRcptHeaderFromLocation := TransferHeader."Transfer-from Code";
        //HEI.14<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnBeforeInsertTransRcptLine, '', false, false)]
    local procedure OnBeforeInsertTransRcptLine(var TransRcptLine: Record "Transfer Receipt Line"; TransLine: Record "Transfer Line")
    var
        TranHeader: Record "Transfer Header";
    begin
        IF TranHeader.GET(TransLine."Document No.") Then // BC Upgrade SHUKLP03 << Added code to get TranHeader.
            TransRcptLine."IC Receipt Adjusted FND" := TranHeader."IC Document FND"; //HEI.08  
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnRunOnBeforeCommit, '', false, false)]
    local procedure OnRunOnBeforeCommit(var TransHeader: Record "Transfer Header"; PostedWhseRcptHeader: Record "Posted Whse. Receipt Header"; var SuppressCommit: Boolean; var TransRcptHeader: Record "Transfer Receipt Header")
    begin
        StockInTransit(TransRcptHeaderNo, TransRcptHeaderToLocation, TransRcptHeaderFromLocation); //HEI.14
    end;

    procedure IsTransGateEntryMandatory(LocationCode: Code[20]; ZoneCode: Code[20]): Boolean
    var
        LocationRec: Record Location;
        ZoneRec: Record Zone;
    begin
        //HEI.01>>
        //>>HEI:EDD001:1:1
        //HEI.15>>
        //IF LocationRec.GET(LocationCode) AND ZoneRec.GET(LocationCode,ZoneCode) THEN BEGIN
        //  IF LocationRec."Transfer Gate Entry Mandatory" OR ZoneRec."Transfer Gate Entry Mandatory" THEN
        IF (ZoneCode <> '') AND ZoneRec.GET(LocationCode, ZoneCode) THEN
            EXIT(ZoneRec."Transf.Gate EntryMandatory FND");

        IF LocationRec.GET(LocationCode) THEN BEGIN
            IF LocationRec."Transfer Gate Entry Mandat FND" THEN
                //HEI.15<<
                EXIT(TRUE)
            ELSE
                EXIT(FALSE);
        END ELSE
            EXIT(FALSE);
        //<<HEI:EDD001:1:1
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnBeforeWriteDownDerivedLines, '', false, false)]
    local procedure OnBeforeWriteDownDerivedLines(var TransferLine2: Record "Transfer Line")
    begin
        //<<HEI.11
        TransferLine2.SETCURRENTKEY("Derived From Line No.", "Item No.");
        //>>HEI.11
    end;

    LOCAL procedure GetWarehouseSetup()
    begin
        //>> HEI.05
        IF NOT WarehouseSetupGot THEN
            IF WarehouseSetup.GET() THEN;
        WarehouseSetupGot := TRUE
        //<< HEI.05
    end;

    LOCAL procedure StockInTransit(RcptHeaderNo: Code[20]; ToLocation: Code[10]; FromLocation: Code[10])
    var
        lVECostPerUnit: Decimal;
        lItemLedgEntry: Record "Item Ledger Entry";
        lItem: Record Item;
        lValueEntry: Record "Value Entry";
        lEntryNo: Integer;
        lTransRcptLogsStdCost: Record "Trans Rcpt Logs (Std Cost) FND";
        CostDifferenceFound: Boolean;
        lDocNo: Code[20];
        lText50000: TextConst ENU = 'You have received stock from Location %1 to Location %2 with Document No. %3 for which SKU standard cost is different than Item standard cost. Please notify Supply Chain Business Controller to update standard cost immediately. No movements should be done for this stock before updating standard cost';
    begin
        //HEI.14>>
        CostDifferenceFound := FALSE;
        lDocNo := '';
        WarehouseSetup.GET();
        IF NOT WarehouseSetup."En Stock in Trans. Funct FND" THEN
            EXIT;

        lItemLedgEntry.RESET();
        lItemLedgEntry.SETCURRENTKEY("Document No.", "Document Type", "Document Line No.");
        lItemLedgEntry.SETRANGE("Document No.", RcptHeaderNo);
        lItemLedgEntry.SETRANGE("Document Type", lItemLedgEntry."Document Type"::"Transfer Receipt");
        lItemLedgEntry.SETRANGE("Location Code", ToLocation);
        IF lItemLedgEntry.FINDSET(FALSE) THEN
            REPEAT
                CLEAR(lTransRcptLogsStdCost);
                IF lDocNo = '' THEN
                    lDocNo := lItemLedgEntry."Document No.";
                lVECostPerUnit := 0;
                IF lItem.GET(lItemLedgEntry."Item No.") THEN
                    IF lItem."Costing Method" = lItem."Costing Method"::Standard THEN BEGIN
                        lValueEntry.RESET();
                        //lValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Entry Type", "Item Charge Type");  // BC Upgrade SHUKLP03 << Blocked code because of DrinkIT field "Item Charge Type".
                        lValueEntry.SETRANGE("Item Ledger Entry No.", lItemLedgEntry."Entry No.");
                        IF lValueEntry.FINDSET(FALSE) THEN
                            REPEAT
                                lVECostPerUnit += lValueEntry."Cost per Unit";
                            UNTIL lValueEntry.NEXT() = 0;

                        IF lItem."Standard Cost" <> lVECostPerUnit THEN BEGIN
                            lTransRcptLogsStdCost.RESET;
                            IF lTransRcptLogsStdCost.FINDLAST THEN
                                lEntryNo := lTransRcptLogsStdCost."Entry No." + 1
                            ELSE
                                lEntryNo := 1;

                            lTransRcptLogsStdCost.RESET;
                            lTransRcptLogsStdCost."Entry No." := lEntryNo;
                            lTransRcptLogsStdCost."Document No." := RcptHeaderNo;
                            lTransRcptLogsStdCost."Creation Date" := TODAY;
                            lTransRcptLogsStdCost."Posting Date" := lItemLedgEntry."Posting Date";
                            lTransRcptLogsStdCost."Item No." := lItemLedgEntry."Item No.";
                            lTransRcptLogsStdCost."Qty." := ABS(lItemLedgEntry.Quantity);
                            lTransRcptLogsStdCost."Receiving Location" := lItemLedgEntry."Location Code";
                            lTransRcptLogsStdCost."Unit Cost (Receipt)" := ABS(ROUND(lVECostPerUnit, 0.01, '='));
                            lTransRcptLogsStdCost."Standatd Cost (Item)" := ABS(ROUND(lItem."Standard Cost", 0.01, '='));
                            lTransRcptLogsStdCost."Difference (Per Unit)" := ABS(ROUND(lTransRcptLogsStdCost."Standatd Cost (Item)" - lTransRcptLogsStdCost."Unit Cost (Receipt)", 0.01, '='));
                            lTransRcptLogsStdCost."Total Difference" := ABS(ROUND(lTransRcptLogsStdCost."Difference (Per Unit)" * lTransRcptLogsStdCost."Qty.", 0.01, '='));
                            lTransRcptLogsStdCost."Document Line No." := lItemLedgEntry."Document Line No.";
                            IF (lTransRcptLogsStdCost."Difference (Per Unit)") <> 0 THEN BEGIN
                                lTransRcptLogsStdCost.INSERT;
                                CostDifferenceFound := TRUE;
                            END;
                        END;
                    END;
            UNTIL lItemLedgEntry.NEXT() = 0;

        IF GUIALLOWED THEN
            IF CostDifferenceFound THEN
                MESSAGE(lText50000, FromLocation, ToLocation, lDocNo);
        //HEI.14<<
    end;

    // BC Upgrade SHUKLP03 << Codeunit 5705 "TransferOrder-Post Receipt"

}