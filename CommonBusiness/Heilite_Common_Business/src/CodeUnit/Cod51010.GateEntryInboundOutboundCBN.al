codeunit 51010 "Gate Entry In/Out CBN"
{
    // version HEI.01

    // FDD-HNK-BRA-0036 - 06/01/2017 CiprianH
    //   -new CU
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Codeunit copied from HEI2.0
    // HEI.02 Bugfixing RW IBM NASTAA02 22.10.2018 # Bugfixing Gate Entry RW
    //   # "Create Gate Entry Outbound" from a Warehouse Shipment should create also the lines
    // HEI.03 Bugfixing RW IBM NASTAA02 02.11.2018 # Bugfixing Gate Entry RW
    //   # "Posted Quantity Inbound" will be filled-in when "Collect Lines" for Inbound Gate Entries


    trigger OnRun();
    begin
    end;

    procedure GetOutboundLines(WhseNo: Code[20]; GateOutNo: Code[20]);
    var
        GateEntryLine: Record "Gate Entry Line FND";
        OutboundBuffer: Record "Lot Bin Buffer" temporary;
        PostedWhseShipHeader: Record "Posted Whse. Shipment Header";
        PostedWhseShipLine: Record "Posted Whse. Shipment Line";
        WhseSetup: Record "Warehouse Setup";
        PostedDocNo: Code[20];
        LineNo: Integer;
    begin
        if WhseNo = '' then
            ERROR('Document No must have a value into Gate Outbount No %1', GateOutNo);
        WhseSetup.GET();
        OutboundBuffer.DELETEALL();
        OutboundBuffer.RESET();
        PostedWhseShipHeader.RESET();
        PostedWhseShipHeader.SETRANGE(PostedWhseShipHeader."Whse. Shipment No.", WhseNo);
        if PostedWhseShipHeader.FINDFIRST() then
            PostedDocNo := PostedWhseShipHeader."No."
        else
            ERROR('There is no posted warehouse shipment for warehouse shipment %1', WhseNo);
        PostedWhseShipLine.RESET();
        PostedWhseShipLine.SETRANGE(PostedWhseShipLine."No.", PostedDocNo);
        if PostedWhseShipLine.findset() then
            repeat
                OutboundBuffer.RESET();
                OutboundBuffer.SETRANGE(OutboundBuffer."Item No.", PostedWhseShipLine."Item No.");
                OutboundBuffer.SETRANGE(OutboundBuffer."Variant Code", PostedWhseShipLine."Unit of Measure Code");
                if OutboundBuffer.FINDFIRST() then begin
                    OutboundBuffer."Qty. (Base)" += PostedWhseShipLine.Quantity;
                    OutboundBuffer.MODIFY();
                end else begin
                    OutboundBuffer.INIT();
                    OutboundBuffer."Item No." := PostedWhseShipLine."Item No.";
                    OutboundBuffer."Variant Code" := PostedWhseShipLine."Unit of Measure Code";
                    OutboundBuffer."Location Code" := PostedWhseShipLine."Location Code";
                    OutboundBuffer."Qty. (Base)" := PostedWhseShipLine.Quantity;
                    OutboundBuffer.INSERT();
                end;
            until PostedWhseShipLine.NEXT() = 0;
        LineNo := 10000;
        OutboundBuffer.RESET();
        if OutboundBuffer.findset() then
            repeat
                GateEntryLine.INIT();
                GateEntryLine.VALIDATE("Gate Entry Document No.", GateOutNo);
                GateEntryLine.VALIDATE("Line No.", LineNo);
                GateEntryLine.INSERT(true);
                GateEntryLine.VALIDATE(Type, GateEntryLine.Type::Item);
                GateEntryLine.VALIDATE("No.", OutboundBuffer."Item No.");
                GateEntryLine.VALIDATE(GateEntryLine."Unit Of Measure Code", OutboundBuffer."Variant Code");
                GateEntryLine.VALIDATE("Location Code", OutboundBuffer."Location Code");
                GateEntryLine.VALIDATE("Quantity Shipment", OutboundBuffer."Qty. (Base)");
                if WhseSetup."Auto Insert Qty.CollectLin FND" then
                    GateEntryLine.VALIDATE("Quantity on Departure", OutboundBuffer."Qty. (Base)");
                GateEntryLine.MODIFY();
                LineNo += 10000;
            until OutboundBuffer.NEXT() = 0;
    end;

    procedure GetInboundLines(WhseNo: Code[20]; GateOutNo: Code[20]; GateInNo: Code[20]);
    var
        PostedDocBuffer: Record "Aging Band Buffer";
        GateEntryHeader: Record "Gate Entry Header FND";
        GateEntryLine: Record "Gate Entry Line FND";
        Item: Record Item;
        InboundBuffer: Record "Lot Bin Buffer" temporary;
        InboundBuffer2: Record "Lot Bin Buffer" temporary;
        PostedWhseRecLine: Record "Posted Whse. Receipt Line";
        PostedWhseShipHeader: Record "Posted Whse. Shipment Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        ReturnRcptHeader: Record "Return Receipt Header";
        ReturnReceiptLine: Record "Return Receipt Line";
        WhseSetup: Record "Warehouse Setup";
        LastShipNo: Code[20];
        ReferenceNo: Code[20];
        PostedQtyInbound: Decimal;
        LineNo: Integer;
        ReferenceDoc: Option " ","Posted Warehouse Shipment","Posted Warehouse Receipt","Posted Shipment","Posted Receipt","Posted Return Receipt","Posted Return Shipment","Posted Transfer Shipment","Posted Transfer Receipt";
    begin
        InboundBuffer.DELETEALL();
        InboundBuffer.RESET();
        PostedDocBuffer.DELETEALL();
        PostedDocBuffer.RESET();
        WhseSetup.GET();

        PostedWhseRecLine.RESET();
        PostedWhseRecLine.SETRANGE(PostedWhseRecLine."Gate Entry No. FND", GateInNo);
        if PostedWhseRecLine.findset() then
            repeat
                if not PostedDocBuffer.GET(PostedWhseRecLine."Posted Source No.") then begin
                    PostedDocBuffer.INIT();
                    PostedDocBuffer."Currency Code" := PostedWhseRecLine."Posted Source No.";
                    PostedDocBuffer.INSERT();
                end;
            until PostedWhseRecLine.NEXT() = 0;

        PostedDocBuffer.RESET();
        if PostedDocBuffer.ISEMPTY then
            ERROR('There are no posted warehouse shipment lines related to Gate Outbound No %1', GateOutNo)
        else
            repeat
                ReturnReceiptLine.RESET();
                ReturnReceiptLine.SETRANGE("Document No.", PostedDocBuffer."Currency Code");
                ReturnReceiptLine.SETRANGE(Type, ReturnReceiptLine.Type::Item);
                if ReturnReceiptLine.findset() then
                    repeat
                        InboundBuffer.RESET();
                        InboundBuffer2.RESET(); //HEI.03
                        InboundBuffer.SETRANGE("Item No.", ReturnReceiptLine."No.");
                        InboundBuffer.SETRANGE("Variant Code", ReturnReceiptLine."Unit of Measure Code");
                        if InboundBuffer.FINDFIRST() then begin
                            InboundBuffer."Qty. (Base)" += ReturnReceiptLine.Quantity;
                            InboundBuffer2."Qty. (Base)" += ReturnReceiptLine.Quantity; //HEI.03
                            InboundBuffer.MODIFY();
                            InboundBuffer2.MODIFY(); //HEI.03
                        end else begin
                            InboundBuffer.INIT();
                            InboundBuffer."Item No." := ReturnReceiptLine."No.";
                            InboundBuffer."Variant Code" := ReturnReceiptLine."Unit of Measure Code";
                            InboundBuffer."Location Code" := ReturnReceiptLine."Location Code";
                            //HEI.03>>
                            InboundBuffer2 := InboundBuffer;
                            ReturnRcptHeader.GET(ReturnReceiptLine."Document No.");
                            ReferenceDoc := ReferenceDoc::"Posted Return Receipt";
                            ReferenceNo := ReturnRcptHeader."No.";
                            PostedQtyInbound += ReturnReceiptLine.Quantity;
                            //HEI.03<<
                            InboundBuffer.INSERT();
                            InboundBuffer2.INSERT(); //HEI.03
                        end;
                    until ReturnReceiptLine.NEXT() = 0;

                //HEI.03>>
                PurchRcptLine.RESET();
                PurchRcptLine.SETRANGE("Document No.", PostedDocBuffer."Currency Code");
                PurchRcptLine.SETRANGE(Type, PurchRcptLine.Type::Item);
                if PurchRcptLine.findset() then
                    repeat
                        InboundBuffer.RESET();
                        InboundBuffer2.RESET(); //HEI.03
                        InboundBuffer.SETRANGE("Item No.", PurchRcptLine."No.");
                        InboundBuffer.SETRANGE("Variant Code", PurchRcptLine."Unit of Measure Code");
                        if InboundBuffer.FINDFIRST() then begin
                            InboundBuffer."Qty. (Base)" += PurchRcptLine.Quantity;
                            InboundBuffer2."Qty. (Base)" += PurchRcptLine.Quantity; //HEI.03
                            InboundBuffer.MODIFY();
                            InboundBuffer2.MODIFY(); //HEI.03
                        end else begin
                            InboundBuffer.INIT();
                            InboundBuffer."Item No." := PurchRcptLine."No.";
                            InboundBuffer."Variant Code" := PurchRcptLine."Unit of Measure Code";
                            InboundBuffer."Location Code" := PurchRcptLine."Location Code";
                            InboundBuffer."Qty. (Base)" := PurchRcptLine.Quantity;
                            //HEI.03>>
                            InboundBuffer2 := InboundBuffer;
                            PurchRcptHeader.GET(PurchRcptLine."Document No.");
                            ReferenceDoc := ReferenceDoc::"Posted Receipt";
                            ReferenceNo := PurchRcptHeader."No.";
                            InboundBuffer2."Qty. (Base)" := PurchRcptLine.Quantity;
                            //HEI.03<<
                            InboundBuffer.INSERT();
                            InboundBuffer2.INSERT(); //HEI.03
                        end;
                    until PurchRcptLine.NEXT() = 0;
            //HEI.03<<
            until PostedDocBuffer.NEXT() = 0;

        LineNo := 10000;
        InboundBuffer.RESET();
        if InboundBuffer.findset() and InboundBuffer2.findset //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03() //HEI.03
        then
            repeat
                GateEntryLine.INIT();
                GateEntryLine.VALIDATE("Gate Entry Document No.", GateInNo);
                GateEntryLine.VALIDATE("Line No.", LineNo);
                GateEntryLine.INSERT(true);
                //HEI.03>>
                GateEntryLine."Reference Document" := ReferenceDoc;
                GateEntryLine."Posted Quantity Inbound" := InboundBuffer2."Qty. (Base)";
                GateEntryLine."Reference No." := ReferenceNo;
                //HEI.03<<
                GateEntryLine.VALIDATE(Type, GateEntryLine.Type::Item);
                GateEntryLine.VALIDATE("No.", InboundBuffer."Item No.");
                GateEntryLine.VALIDATE(GateEntryLine."Unit Of Measure Code", InboundBuffer."Variant Code");
                GateEntryLine.VALIDATE("Location Code", InboundBuffer."Location Code");
                GateEntryLine.VALIDATE("Quantity Shipment", InboundBuffer."Qty. (Base)");
                if WhseSetup."Auto Insert Qty.CollectLin FND" then
                    GateEntryLine.VALIDATE("Quantity on Arrival", InboundBuffer."Qty. (Base)");

                GateEntryLine.MODIFY();
                LineNo += 10000;
            until (InboundBuffer.NEXT() = 0) and (InboundBuffer2.NEXT() = 0);

        //HEI.03>>
        GateEntryHeader.GET(GateEntryLine."Gate Entry Document No.");
        GateEntryHeader.VALIDATE("Document No.", ReferenceNo);
        GateEntryHeader.MODIFY();
        //HEI.03<<
    end;

    procedure TestQtyWhseReceipt(GateEntryNo: Code[20]; WhseHeaderNo: Code[20]);
    var
        GateEntryLines: Record "Gate Entry Line FND";
        Location: Record Location;
        InboundBuffer: Record "Lot Bin Buffer" temporary;
        OutboundBuffer: Record "Lot Bin Buffer" temporary;
        WarehouseReceiptH: Record "Warehouse Receipt Header";
        WarehouseReceipt: Record "Warehouse Receipt Line";
        Error001: Label 'The quantity for item no. %1 must be %2.Check the quantity on gate inbound %3';
    begin
        WarehouseReceiptH.GET(WhseHeaderNo);
        if Location.GET(WarehouseReceiptH."Location Code") then;

        if Location."Purchase Gate Entry Mandat FND" then begin
            OutboundBuffer.DELETEALL();
            OutboundBuffer.RESET();

            WarehouseReceipt.RESET();
            WarehouseReceipt.SETRANGE(WarehouseReceipt."No.", WhseHeaderNo);
            if WarehouseReceipt.findset() then
                repeat
                    OutboundBuffer.RESET();
                    OutboundBuffer.SETRANGE(OutboundBuffer."Item No.", WarehouseReceipt."Item No.");
                    OutboundBuffer.SETRANGE(OutboundBuffer."Variant Code", WarehouseReceipt."Unit of Measure Code");
                    if OutboundBuffer.FINDFIRST() then begin
                        OutboundBuffer."Qty. (Base)" += WarehouseReceipt.Quantity;
                        OutboundBuffer.MODIFY();
                    end else begin
                        OutboundBuffer.INIT();
                        OutboundBuffer."Item No." := WarehouseReceipt."Item No.";
                        OutboundBuffer."Variant Code" := WarehouseReceipt."Unit of Measure Code";
                        OutboundBuffer."Location Code" := WarehouseReceipt."Location Code";
                        OutboundBuffer."Qty. (Base)" := WarehouseReceipt.Quantity;
                        OutboundBuffer.INSERT();
                    end;

                until WarehouseReceipt.NEXT() = 0;
            OutboundBuffer.RESET();
            GateEntryLines.RESET();
            GateEntryLines.SETRANGE(GateEntryLines."Gate Entry Document No.", GateEntryNo);
            if GateEntryLines.findset() then
                repeat
                    OutboundBuffer.RESET();
                    OutboundBuffer.SETRANGE(OutboundBuffer."Item No.", GateEntryLines."No.");
                    OutboundBuffer.SETRANGE(OutboundBuffer."Variant Code", GateEntryLines."Unit Of Measure Code");
                    if OutboundBuffer.FINDFIRST() then
                        if GateEntryLines."Quantity Shipment" <> OutboundBuffer."Qty. (Base)" then
                            ERROR(Error001, OutboundBuffer."Item No.", OutboundBuffer."Qty. (Base)", GateEntryLines."Gate Entry Document No.");
                until GateEntryLines.NEXT() = 0;
        end else begin
            // ERROR('Gate entry no must have a value into warehouse receipt no %1',WhseHeaderNo);
        end;
    end;

    procedure CreateGateEntryOutbound(WhseShipment: Record "Warehouse Shipment Header");
    var
        GateEntryHeader: Record "Gate Entry Header FND";
        GateEntryHeader2: Record "Gate Entry Header FND";
        GateEntryLine: Record "Gate Entry Line FND";
        WhseSetup: Record "Warehouse Setup";
        WhseShip: Record "Warehouse Shipment Header";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        // NoSeriesMgt: Codeunit NoSeriesManagement;  // BC Upgrade NANDIS03
        NoSeries: Codeunit "No. Series";  // BC Upgrade NANDIS03
        LineNo: Integer;
    begin
        WhseSetup.GET();
        if WhseSetup."Allow Collect Lines FND" then begin
            // WhseShipment.TESTFIELD(WhseShipment."Driver Code");//BC Upgrade SHARMP16-- Drink-IT fields used
            // WhseShipment.TESTFIELD(WhseShipment."Truck Code");//BC Upgrade SHARMP16-- Drink-IT fields used
            //BC UPGRADE KUMARR78 >> FDD-MTC-007
            WhseShipment.TESTFIELD(WhseShipment."Log Driver 107FDW");
            WhseShipment.TESTFIELD(WhseShipment."Vehicle Code 101FDW");
            //BC UPGRADE KUMARR78 << FDD-MTC-007

            GateEntryHeader.Init();
            WhseSetup.TestField("Gate Entry Nos. FND");
            GateEntryHeader."Gate Entry Document No." :=
                NoSeries.GetNextNo(WhseSetup."Gate Entry Nos. FND", WorkDate(), true);
            GateEntryHeader."No. Series" := WhseSetup."Gate Entry Nos. FND";
            GateEntryHeader.Insert(true);

            GateEntryHeader.VALIDATE("Gate Entry Type", GateEntryHeader."Gate Entry Type"::Outbound);
            GateEntryHeader.VALIDATE(GateEntryHeader."Document Type", GateEntryHeader."Document Type"::"Warehouse Shipment");
            GateEntryHeader.VALIDATE(GateEntryHeader."Document No.", WhseShipment."No.");
            //  GateEntryHeader.VALIDATE(GateEntryHeader."Vehicle No.", WhseShipment."Truck Code");//BC Upgrade SHARMP16-- Drink-IT fields used
            GateEntryHeader.VALIDATE(GateEntryHeader."Vehicle No.", WhseShipment."Vehicle Code 101FDW");//BC UPGRADE KUMARR78 FDD-MTC-007

            GateEntryHeader.VALIDATE(GateEntryHeader."Location Code", WhseShipment."Location Code");
            GateEntryHeader.VALIDATE("Zone Code", WhseShipment."Zone Code"); //HEI.02

            // GateEntryHeader.VALIDATE(GateEntryHeader."Driver Code", WhseShipment."Driver Code");//BC Upgrade SHARMP16-- Drink-IT fields used
            GateEntryHeader.VALIDATE(GateEntryHeader."Driver Code", WhseShipment."Log Driver 107FDW");//BC UPGRADE KUMARR78 FDD-MTC-007

            GateEntryHeader."Date In" := WORKDATE();
            GateEntryHeader."Time In" := TIME;

            GateEntryHeader.MODIFY(true);
            //HEI.02>>
            LineNo := 10000;
            WarehouseShipmentLine.SETRANGE("No.", WhseShipment."No.");
            if WarehouseShipmentLine.findset() then
                repeat
                    GateEntryLine.INIT();
                    GateEntryLine.VALIDATE("Gate Entry Document No.", GateEntryHeader."Gate Entry Document No.");
                    GateEntryLine.VALIDATE("Line No.", LineNo);
                    GateEntryLine.INSERT(true);

                    GateEntryLine.VALIDATE(Type, GateEntryLine.Type::Item);
                    GateEntryLine.VALIDATE("No.", WarehouseShipmentLine."Item No.");
                    GateEntryLine.VALIDATE("Unit Of Measure Code", WarehouseShipmentLine."Unit of Measure Code");
                    GateEntryLine.VALIDATE("Location Code", WhseShipment."Location Code");
                    GateEntryLine.VALIDATE("Zone Code", WhseShipment."Zone Code");
                    GateEntryLine.VALIDATE("Quantity Shipment", WarehouseShipmentLine.Quantity); //HEI.02
                    if WhseSetup."Auto Insert Qty.CollectLin FND" then
                        GateEntryLine.VALIDATE("Quantity on Departure", WarehouseShipmentLine.Quantity);
                    GateEntryLine.MODIFY();
                    LineNo += 10000;
                until WarehouseShipmentLine.NEXT() = 0;
            //HEI.02<<
            MESSAGE('The Gate Entry Outbount with no %1 was created!', GateEntryHeader."Gate Entry Document No.");
            GateEntryHeader.ReleaseGateEntry();
            COMMIT();
            PAGE.RUNMODAL(53010, GateEntryHeader);
            if WhseShip.GET(WhseShipment."No.") then begin
                WhseShip.VALIDATE("Gate Entry No. FND", GateEntryHeader."Gate Entry Document No.");
                WhseShip.MODIFY();
            end;

        end else begin
            MESSAGE('Nothing to create!Please check the warehouse setup!');
        end;
    end;

}

