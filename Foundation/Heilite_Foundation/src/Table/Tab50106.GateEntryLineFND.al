table 50106 "Gate Entry Line FND"
{
    // version HEI.03

    // HEI:EDD001:1:1 12/11/14 TECTURA-HKH
    //   # New Table Created for Gate Entry
    // 
    // HEI:EDD151:1:1 13/11/14 TECTURA-HKH
    //   # Gate Control
    //   # Added new field 80000 'Location Code' [Code 20]
    //   # Added code to update Qty on basis of Location Code
    //   # Added new options in field "Refrence Document" for posted Sale, Purchae and Transfer documents
    //   # Added code in "Quantity on Departure - OnValidate()" trigger to update posted inbound and outbound quantity
    // 
    // FDD-HNK-BRA-0036 - 06/01/2017 - CiprianH
    //   -add new field(55500 - Quantity Shipment)
    // 
    // HEI:CHG0229242:1:1 05/08/2018 IBM.AK
    // # Added code on Location Code-On Validate()
    // 
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Copied Table 80051 - Gate Entry Line from HEI2.0
    // HEI.02 Defect #3268 IBM NASTAA02 17.10.2018 # Missing field zone on gate entry forms
    //   # Added Field "Zone Code"
    // HEI.03 Bugfixing RW IBM NASTAA02 17.10.2018 # Bugfixing Gate Entry RW
    //   # "Zone Code" should inherit the value from header and be non-editable
    //   # "Location Code" should inherit the value from header and be non-editable
    // HEI.04 FDD-CHG2024489 Gate Control IBM SAXENS01  06.11.2019
    //   made field 80000 and 80001 field editable

    DrillDownPageID = "Gate Entry Line Lists";
    LookupPageID = "Gate Entry Line Lists";

    fields
    {
        field(1; "Gate Entry Document No."; Code[20])
        {
            CaptionML = ENU = 'Gate Entry Document No.',
                        FRA = 'Gate Entry Document No.';
            TableRelation = "Gate Entry Header FND";
        }
        field(2; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.',
                        FRA = 'Line No.';
        }
        field(3; Type; Option)
        {
            CaptionML = ENU = 'Type',
                        FRA = 'Type';
            OptionCaption = '" ,Item,Fixed Asset,Service Item"';
            OptionMembers = " ",Item,"Fixed Asset","Service Item";
        }
        field(4; "No."; Code[20])
        {
            CaptionML = ENU = 'No.',
                        FRA = 'No.';
            TableRelation = IF (Type = FILTER(Item)) Item."No."
            else IF (Type = FILTER("Fixed Asset")) "Fixed Asset"."No."
            else IF (Type = FILTER("Service Item")) "Service Item"."No.";

            trigger OnValidate();
            begin
                if Type = Type::Item then
                    if Item.GET("No.") then begin
                        Item.TESTFIELD(Blocked, false);
                        Item.TESTFIELD("Inventory Posting Group");
                        Item.TESTFIELD("Gen. Prod. Posting Group");
                        Description := COPYSTR(Item.Description, 1, 30);
                        ;
                        "Unit Of Measure Code" := Item."Sales Unit of Measure";
                    end;
                if Type = Type::"Fixed Asset" then
                    if FixedAsset.GET("No.") then begin
                        FixedAsset.TESTFIELD(Inactive, false);
                        FixedAsset.TESTFIELD(Blocked, false);
                        GetFAPostingGroup();
                        Description := FixedAsset.Description;
                    end;
                if Type = Type::"Service Item" then
                    if ServiceItem.GET("No.") then begin
                        //   ServiceItem.TESTFIELD(Blocked, false);//BC Upgrade SHARMP16--- Drink-It field
                        Description := ServiceItem.Description;
                        "Unit Of Measure Code" := ServiceItem."Unit of Measure Code";
                    end;
            end;
        }
        field(5; "Unit Of Measure Code"; Code[10])
        {
            CaptionML = ENU = 'Unit Of Measure Code',
                        FRA = 'Unit Of Measure Code';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code where("Item No." = FIELD("No."))
            else
            "Unit of Measure".Code;
        }
        field(6; Description; Text[30])
        {
            CaptionML = ENU = 'Description',
                        FRA = 'Description';
        }
        field(7; "Quantity on Arrival"; Decimal)
        {
            CaptionML = ENU = 'Quantity on Arrival',
                        FRA = 'Quantity on Arrival';

            trigger OnValidate();
            begin
                //FDD-HNK-BRA-0036>>
                WhseSetup.GET();
                if WhseSetup."Allow Collect Lines FND" then begin
                    if "Quantity Shipment" <> 0 then
                        if "Quantity on Arrival" > "Quantity Shipment" then
                            MESSAGE('Quantity on arrival must be less or equal with %1', "Quantity Shipment");
                end;
                //FDD-HNK-BRA-0036<<
            end;
        }
        field(8; "Quantity on Departure"; Decimal)
        {
            CaptionML = ENU = 'Quantity on Departure',
                        FRA = 'Quantity on Departure';

            trigger OnValidate();
            var
                GateCommentLine: Record "Gate Comment Line FND";
                GateEntryHeader: Record "Gate Entry Header FND";
                PostedWhseRcptHeader: Record "Posted Whse. Receipt Header";
                PostedWhseRcptLine: Record "Posted Whse. Receipt Line";
                PostedWhseShipHeader: Record "Posted Whse. Shipment Header";
                PostedWhseShipLine: Record "Posted Whse. Shipment Line";
                PurchRcptHeader: Record "Purch. Rcpt. Header";
                PurchRcptLine: Record "Purch. Rcpt. Line";
                ReturnRcptHeader: Record "Return Receipt Header";
                ReturnRcptLine: Record "Return Receipt Line";
                ReturnShptHeader: Record "Return Shipment Header";
                ReturnShptLine: Record "Return Shipment Line";
                SalesShipmentHeader: Record "Sales Shipment Header";
                SalesShipmentLine: Record "Sales Shipment Line";
                TransRcptHeader: Record "Transfer Receipt Header";
                TransRcptLine: Record "Transfer Receipt Line";
                TransShptHeader: Record "Transfer Shipment Header";
                TransShptLine: Record "Transfer Shipment Line";
                DuplicateQty: Boolean;
            begin
                //>>HEI:EDD151:1:1
                GateEntryHeader.GET("Gate Entry Document No.");
                if GateEntryHeader."Reference No." <> '' then begin
                    "Reference Document" := GateEntryHeader."Reference Document";
                    "Reference No." := GateEntryHeader."Reference No.";
                end;

                if ("Posted Quantity Inbound" = 0) or ("Posted Quantity Inbound" <> xRec."Posted Quantity Inbound") then begin
                    "Posted Quantity Inbound" := 0;

                    if GateEntryHeader."Reference Document" = GateEntryHeader."Reference Document"::"Posted Receipt" then begin
                        PurchRcptHeader.RESET();
                        PurchRcptHeader.SETCURRENTKEY("Gate Entry No. FND");
                        PurchRcptHeader.SETRANGE("Gate Entry No. FND", "Gate Entry Document No.");
                        if PurchRcptHeader.findset() then
                            repeat
                                PurchRcptLine.RESET();
                                PurchRcptLine.SETCURRENTKEY("Document No.", Type, "Unit of Measure Code", "Location Code");
                                PurchRcptLine.SETRANGE("Document No.", PurchRcptHeader."No.");
                                PurchRcptLine.SETRANGE(Type, PurchRcptLine.Type::Item);
                                PurchRcptLine.SETRANGE("Unit of Measure Code", "Unit Of Measure Code");
                                PurchRcptLine.SETRANGE("Location Code", "Location Code");
                                PurchRcptLine.SETFILTER(Quantity, '<>%1', 0);
                                if PurchRcptLine.findset() then
                                    repeat
                                        "Posted Quantity Inbound" += PurchRcptLine.Quantity;
                                    until PurchRcptLine.NEXT() = 0;
                            until PurchRcptHeader.NEXT() = 0;
                    end;

                    if GateEntryHeader."Reference Document" = GateEntryHeader."Reference Document"::"Posted Return Receipt" then begin
                        ReturnRcptHeader.RESET();
                        ReturnRcptHeader.SETCURRENTKEY("Gate Entry No. FND");
                        ReturnRcptHeader.SETRANGE("Gate Entry No. FND", "Gate Entry Document No.");
                        if ReturnRcptHeader.findset() then
                            repeat
                                ReturnRcptLine.RESET();
                                ReturnRcptLine.SETCURRENTKEY("Document No.", Type, "Unit of Measure Code", "Location Code");
                                ReturnRcptLine.SETRANGE("Document No.", ReturnRcptHeader."No.");
                                ReturnRcptLine.SETRANGE(Type, ReturnRcptLine.Type::Item);
                                ReturnRcptLine.SETRANGE("Unit of Measure Code", "Unit Of Measure Code");
                                ReturnRcptLine.SETRANGE("Location Code", "Location Code");
                                ReturnRcptLine.SETFILTER(Quantity, '<>%1', 0);
                                if ReturnRcptLine.findset() then
                                    repeat
                                        DuplicateQty := false;
                                        if Item.GET(ReturnRcptLine."No.") then begin
                                            // Item.CALCFIELDS("Empty Good");//BC Upgrade SHARMP16 -- Drink-It field
                                            // if not Item."Empty Good" then begin
                                            //   if (ReturnRcptLine."BOM Item No." <> '') and (ReturnRcptLine."BOM Item No." = Item."Full BOM Counterpart") then//BC Upgrade SHARMP16 -- Drink-It field
                                            DuplicateQty := true;
                                            //end;//BC Upgrade SHARMP16 -- Drink-It field
                                        end;
                                        if not DuplicateQty then
                                            "Posted Quantity Inbound" += ReturnRcptLine.Quantity;
                                    until ReturnRcptLine.NEXT() = 0;
                            until ReturnRcptHeader.NEXT() = 0;
                    end;

                    if GateEntryHeader."Reference Document" = GateEntryHeader."Reference Document"::"Posted Transfer Receipt" then begin
                        TransRcptHeader.RESET();
                        TransRcptHeader.SETCURRENTKEY("To Gate Entry No. FND");
                        TransRcptHeader.SETRANGE("To Gate Entry No. FND", "Gate Entry Document No.");
                        if TransRcptHeader.findset() then
                            repeat
                                TransRcptLine.RESET();
                                TransRcptLine.SETCURRENTKEY("Document No.", "Unit of Measure Code", "In-Transit Code");
                                TransRcptLine.SETRANGE("Document No.", TransRcptHeader."No.");
                                TransRcptLine.SETRANGE("Unit of Measure Code", "Unit Of Measure Code");
                                TransRcptLine.SETRANGE("In-Transit Code", "Location Code");
                                TransRcptLine.SETFILTER(Quantity, '<>%1', 0);
                                if TransRcptLine.findset() then
                                    repeat
                                        "Posted Quantity Inbound" += TransRcptLine.Quantity;
                                    until TransRcptLine.NEXT() = 0;
                            until TransRcptHeader.NEXT() = 0;
                    end;

                    if GateEntryHeader."Reference Document" = GateEntryHeader."Reference Document"::"Posted Warehouse Receipt" then begin
                        PostedWhseRcptHeader.RESET();
                        PostedWhseRcptHeader.SETCURRENTKEY("Gate Entry No. FND");
                        PostedWhseRcptHeader.SETRANGE("Gate Entry No. FND", "Gate Entry Document No.");
                        if PostedWhseRcptHeader.findset() then
                            repeat
                                PostedWhseRcptLine.RESET();
                                PostedWhseRcptLine.SETCURRENTKEY("No.", "Unit of Measure Code", "Location Code");
                                PostedWhseRcptLine.SETRANGE("No.", PostedWhseRcptHeader."No.");
                                PostedWhseRcptLine.SETRANGE("Unit of Measure Code", "Unit Of Measure Code");
                                PostedWhseRcptLine.SETRANGE("Location Code", "Location Code");
                                PostedWhseRcptLine.SETFILTER(Quantity, '<>%1', 0);
                                if PostedWhseRcptLine.findset() then
                                    repeat
                                        DuplicateQty := false;
                                        if PostedWhseRcptLine."Source Document" = PostedWhseRcptLine."Source Document"::"Sales Return Order" then begin
                                            ReturnRcptLine.RESET();
                                            ReturnRcptLine.SETRANGE("Return Order No.", PostedWhseRcptLine."Source No.");
                                            ReturnRcptLine.SETRANGE("Return Order Line No.", PostedWhseRcptLine."Source Line No.");
                                            if ReturnRcptLine.FINDFIRST() then begin
                                                if Item.GET(ReturnRcptLine."No.") then begin
                                                    // Item.CALCFIELDS("Empty Good");//BC Upgrade SHARMP16 -- Drink-It field
                                                    // if not Item."Empty Good" then begin//BC Upgrade SHARMP16 -- Drink-It field
                                                    // if (ReturnRcptLine."BOM Item No." <> '') and (ReturnRcptLine."BOM Item No." = Item."Full BOM Counterpart") then //BC Upgrade SHARMP16 -- Drink-It field
                                                    DuplicateQty := true;
                                                    // end;//BC Upgrade SHARMP16 -- Drink-It field
                                                end;
                                            end;
                                        end;
                                        if not DuplicateQty then
                                            "Posted Quantity Inbound" += PostedWhseRcptLine.Quantity;
                                    until PostedWhseRcptLine.NEXT() = 0;
                            until PostedWhseRcptHeader.NEXT() = 0;
                    end;

                end;

                if ("Posted Quantity Outbound" = 0) or ("Posted Quantity Outbound" <> xRec."Posted Quantity Outbound") then begin
                    "Posted Quantity Outbound" := 0;

                    if GateEntryHeader."Reference Document" = GateEntryHeader."Reference Document"::"Posted Shipment" then begin
                        SalesShipmentHeader.RESET();
                        SalesShipmentHeader.SETCURRENTKEY("Gate Entry No. FND");
                        SalesShipmentHeader.SETRANGE("Gate Entry No. FND", "Gate Entry Document No.");
                        if SalesShipmentHeader.findset() then
                            repeat
                                SalesShipmentLine.RESET();
                                SalesShipmentLine.SETCURRENTKEY("Document No.", Type, "Unit of Measure Code", "Location Code");
                                SalesShipmentLine.SETRANGE("Document No.", SalesShipmentHeader."No.");
                                SalesShipmentLine.SETRANGE(Type, SalesShipmentLine.Type::Item);
                                SalesShipmentLine.SETRANGE("Unit of Measure Code", "Unit Of Measure Code");
                                SalesShipmentLine.SETRANGE("Location Code", "Location Code");
                                if (Type = Type::Item) and ("No." <> '') then
                                    SalesShipmentLine.SETRANGE("No.", "No.");
                                SalesShipmentLine.SETFILTER(Quantity, '<>%1', 0);
                                if SalesShipmentLine.findset() then
                                    repeat
                                        DuplicateQty := false;
                                        if Item.GET(SalesShipmentLine."No.") then begin
                                            // Item.CALCFIELDS("Empty Good");//BC Upgrade SHARMP16 -- Drink-It field
                                            // if not Item."Empty Good" then begin//BC Upgrade SHARMP16 -- Drink-It field
                                            // if (SalesShipmentLine. <> '') and (SalesShipmentLine."BOM Item No." = Item."Full BOM Counterpart") then//BC Upgrade SHARMP16 -- Drink-It field
                                            DuplicateQty := true;
                                            // end;//BC Upgrade SHARMP16 -- Drink-It field
                                        end;
                                        if not DuplicateQty then
                                            "Posted Quantity Outbound" += SalesShipmentLine.Quantity;
                                    until SalesShipmentLine.NEXT() = 0;
                            until SalesShipmentHeader.NEXT() = 0;
                    end;

                    if GateEntryHeader."Reference Document" = GateEntryHeader."Reference Document"::"Posted Return Shipment" then begin
                        ReturnShptHeader.RESET();
                        ReturnShptHeader.SETCURRENTKEY("Gate Entry No. FND");
                        ReturnShptHeader.SETRANGE("Gate Entry No. FND", "Gate Entry Document No.");
                        if ReturnShptHeader.findset() then
                            repeat
                                ReturnShptLine.RESET();
                                ReturnShptLine.SETCURRENTKEY("Document No.", Type, "Unit of Measure Code", "Location Code");
                                ReturnShptLine.SETRANGE("Document No.", ReturnShptHeader."No.");
                                ReturnShptLine.SETRANGE(Type, ReturnShptLine.Type::Item);
                                ReturnShptLine.SETRANGE("Unit of Measure Code", "Unit Of Measure Code");
                                ReturnShptLine.SETRANGE("Location Code", "Location Code");
                                ReturnShptLine.SETFILTER(Quantity, '<>%1', 0);
                                if ReturnShptLine.findset() then
                                    repeat
                                        "Posted Quantity Outbound" += ReturnShptLine.Quantity;
                                    until ReturnShptLine.NEXT() = 0;
                            until ReturnShptHeader.NEXT() = 0;
                    end;

                    if GateEntryHeader."Reference Document" = GateEntryHeader."Reference Document"::"Posted Transfer Shipment" then begin
                        TransShptHeader.RESET();
                        TransShptHeader.SETCURRENTKEY("From Gate Entry No. FND");
                        TransShptHeader.SETRANGE("From Gate Entry No. FND", "Gate Entry Document No.");
                        if TransShptHeader.findset() then
                            repeat
                                TransShptLine.RESET();
                                TransShptLine.SETCURRENTKEY("Document No.", "Unit of Measure Code", "In-Transit Code");
                                TransShptLine.SETRANGE("Document No.", TransShptHeader."No.");
                                TransShptLine.SETRANGE("Unit of Measure Code", "Unit Of Measure Code");
                                TransShptLine.SETRANGE("In-Transit Code", "Location Code");
                                TransShptLine.SETFILTER(Quantity, '<>%1', 0);
                                if TransShptLine.findset() then
                                    repeat
                                        "Posted Quantity Outbound" += TransShptLine.Quantity;
                                    until TransShptLine.NEXT() = 0;
                            until TransShptHeader.NEXT() = 0;
                    end;

                    if GateEntryHeader."Reference Document" = GateEntryHeader."Reference Document"::"Posted Warehouse Shipment" then begin
                        PostedWhseShipHeader.RESET();
                        PostedWhseShipHeader.SETCURRENTKEY("Gate Entry No. FND");
                        PostedWhseShipHeader.SETRANGE("Gate Entry No. FND", "Gate Entry Document No.");
                        if PostedWhseShipHeader.findset() then
                            repeat
                                PostedWhseShipLine.RESET();
                                PostedWhseShipLine.SETCURRENTKEY("No.", "Unit of Measure Code", "Location Code");
                                PostedWhseShipLine.SETRANGE("No.", PostedWhseShipHeader."No.");
                                PostedWhseShipLine.SETRANGE("Unit of Measure Code", "Unit Of Measure Code");
                                PostedWhseShipLine.SETRANGE("Location Code", "Location Code");
                                PostedWhseShipLine.SETFILTER(Quantity, '<>%1', 0);
                                if PostedWhseShipLine.findset() then
                                    repeat
                                        DuplicateQty := false;
                                        if PostedWhseShipLine."Source Document" = PostedWhseShipLine."Source Document"::"Sales Order" then begin
                                            SalesShipmentLine.RESET();
                                            SalesShipmentLine.SETRANGE("Order No.", PostedWhseShipLine."Source No.");
                                            SalesShipmentLine.SETRANGE("Order Line No.", PostedWhseShipLine."Source Line No.");
                                            if SalesShipmentLine.FINDFIRST() then begin
                                                if Item.GET(SalesShipmentLine."No.") then begin
                                                    // Item.CALCFIELDS("Empty Good");//BC Upgrade SHARMP16 -- Drink-It field
                                                    // if not Item."Empty Good" then begin//BC Upgrade SHARMP16 -- Drink-It field
                                                    //   if (SalesShipmentLine."BOM Item No." <> '') and (SalesShipmentLine."BOM Item No." = Item."Full BOM Counterpart") then//BC Upgrade SHARMP16 -- Drink-It field
                                                    DuplicateQty := true;
                                                    // end;//BC Upgrade SHARMP16 -- Drink-It field
                                                end;
                                            end;
                                        end;
                                        //IF NOT DuplicateQty THEN BEGIN
                                        if DuplicateQty then begin
                                            "Posted Quantity Outbound" += PostedWhseShipLine.Quantity;
                                        end;
                                    until PostedWhseShipLine.NEXT() = 0;
                            until PostedWhseShipHeader.NEXT() = 0;
                    end;
                end;
                //<<HEI:EDD151:1:1


                //FDD-HNK-BRA-0036>>
                GateEntryHeader.GET("Gate Entry Document No.");
                if GateEntryHeader."Gate Entry Type" = GateEntryHeader."Gate Entry Type"::Outbound then begin
                    WhseSetup.GET();
                    if WhseSetup."Allow Collect Lines FND" then begin
                        if "Quantity on Departure" <> "Quantity Shipment" then
                            MESSAGE('Quantity on departure must be %1 on line no: %2', "Quantity Shipment", "Line No.");
                    end;
                end;
                //FDD-HNK-BRA-0036<<
            end;
        }
        field(9; "Posted Quantity Inbound"; Decimal)
        {
            CaptionML = ENU = 'Posted Quantity Inbound',
                        FRA = 'Posted Quantity Inbound';
            Editable = false;
        }
        field(10; "Posted Quantity Outbound"; Decimal)
        {
            CaptionML = ENU = 'Posted Quantity Outbound',
                        FRA = 'Posted Quantity Outbound';
            Editable = false;
        }
        field(60; "Reference Document"; Option)
        {
            CaptionML = ENU = 'Reference Document',
                        FRA = 'Document référence';
            Editable = false;
            OptionCaptionML = ENU = ' ,Posted Warehouse Shipment,Posted Warehouse Receipt,Posted Shipment,Posted Receipt,Posted Return Receipt,Posted Return Shipment,Posted Transfer Shipment,Posted Transfer Receipt',
                              FRA = ' ,Posted Warehouse Shipment,Posted Warehouse Receipt,Posted Shipment,Posted Receipt,Posted Return Receipt,Posted Return Shipment,Posted Transfer Shipment,Posted Transfer Receipt';
            OptionMembers = " ","Posted Warehouse Shipment","Posted Warehouse Receipt","Posted Shipment","Posted Receipt","Posted Return Receipt","Posted Return Shipment","Posted Transfer Shipment","Posted Transfer Receipt";
        }
        field(61; "Reference No."; Code[20])
        {
            CaptionML = ENU = 'Reference No.',
                        FRA = 'N° référence';
            Editable = false;
        }
        field(55500; "Quantity Shipment"; Decimal)
        {
            Caption = 'Quantity Shipment';
            Description = 'FDD-HNK-BRA-0036';
        }
        field(80000; "Location Code"; Code[10])
        {
            CaptionML = ENU = 'Location Code',
                        FRA = 'Location Code';
            TableRelation = Location;

            trigger OnValidate();
            begin
                if not LocationIsAllowed("Location Code") then
                    if "Location Code" <> '' then
                        ERROR(Text80013, "Location Code");

                //HEI:CHG0229242:1:1 05/08/2018 IBM.AK >>
                /*PPsetup.GET;
                IF NOT PPsetup."Enable Physical Loc Group Code" THEN BEGIN
                  IF NOT LocationIsAllowed("Location Code") THEN
                    IF "Location Code" <> '' THEN
                      ERROR(Text80013,"Location Code");
                end;
                //HEI:CHG0229242:1:1 05/08/2018 IBM.AK >>
                */

            end;
        }
        field(80001; "Zone Code"; Code[10])
        {
            Description = 'HEI.02';
            TableRelation = Zone.Code;
        }
    }

    keys
    {
        key(Key1; "Gate Entry Document No.", "Line No.")
        {
            SumIndexFields = "Quantity on Arrival", "Quantity on Departure", "Posted Quantity Inbound", "Posted Quantity Outbound";
        }
        key(Key2; "Gate Entry Document No.", "Quantity on Arrival")
        {
            SumIndexFields = "Quantity on Arrival", "Quantity on Departure";
        }
        key(Key3; "Gate Entry Document No.", "Quantity on Departure")
        {
            SumIndexFields = "Quantity on Arrival", "Quantity on Departure";
        }
        key(Key4; "Gate Entry Document No.", "Unit Of Measure Code", "Location Code")
        {
            SumIndexFields = "Quantity on Arrival", "Quantity on Departure", "Posted Quantity Inbound", "Posted Quantity Outbound";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        GateCommentLine.SETRANGE("No.", "Gate Entry Document No.");
        GateCommentLine.SETRANGE("Document Line No.", "Line No.");
        if not GateCommentLine.ISEMPTY then
            GateCommentLine.DELETEALL();
    end;

    trigger OnInsert();
    var
        GateEntryHeader: Record "Gate Entry Header FND";
    begin
        //HEI.03>>
        GateEntryHeader.GET("Gate Entry Document No.");
        "Zone Code" := GateEntryHeader."Zone Code";
        "Location Code" := GateEntryHeader."Location Code";
        //HEI.03<<
    end;

    var
        FixedAsset: Record "Fixed Asset";
        GateCommentLine: Record "Gate Comment Line FND";
        Item: Record Item;
        PPsetup: Record "Purchases & Payables Setup";
        ServiceItem: Record "Service Item";
        WhseSetup: Record "Warehouse Setup";
        Text80013: TextConst ENU = 'You are not allowed to use location code %1.', FRA = 'Vous n''êtes pas autorisé à utiliser le code magasin %1.';

    procedure UpdateOutboundGateEntry(GateEntryNo: Code[20]; OutboundQuantity: Decimal; ItemNo: Code[20]; OutboundWeight: Decimal; UnitOfMeasure: Code[20]);
    var
        GateEntryHeader: Record "Gate Entry Header FND";
        GateEntryLine: Record "Gate Entry Line FND";
    begin
        GateEntryLine.RESET();
        GateEntryLine.SETRANGE("Gate Entry Document No.", GateEntryNo);
        GateEntryLine.SETRANGE("Unit Of Measure Code", UnitOfMeasure);
        if GateEntryLine.FINDFIRST() then begin
            GateEntryLine."Posted Quantity Outbound" += OutboundQuantity;
            GateEntryLine.MODIFY();
        end;
        if GateEntryHeader.GET(GateEntryNo) then begin
            GateEntryHeader."Posted Weight Outbound" += OutboundWeight;
            GateEntryHeader.MODIFY();
        end;
    end;

    procedure UpdateInboundGateEntry(GateEntryNo: Code[20]; InboundQuantity: Decimal; ItemNo: Code[20]; InboundWeight: Decimal; UnitOfMeasure: Code[20]);
    var
        GateEntryHeader: Record "Gate Entry Header FND";
        GateEntryLine: Record "Gate Entry Line FND";
    begin
        GateEntryLine.RESET();
        GateEntryLine.SETRANGE("Gate Entry Document No.", GateEntryNo);
        GateEntryLine.SETRANGE("Unit Of Measure Code", UnitOfMeasure);
        if GateEntryLine.FINDFIRST() then begin
            GateEntryLine."Posted Quantity Inbound" += InboundQuantity;
            GateEntryLine.MODIFY();
        end;
        if GateEntryHeader.GET(GateEntryNo) then begin
            GateEntryHeader."Posted Weight Inbound" += InboundWeight;
            GateEntryHeader.MODIFY();
        end;
    end;

    local procedure GetFAPostingGroup();
    var
        DepreciationBook: Record "Depreciation Book";
        FADeprBook: Record "FA Depreciation Book";
        FAPostingGr: Record "FA Posting Group";
        FASetup: Record "FA Setup";
        LocalGLAcc: Record "G/L Account";
    begin
        if (Type <> Type::"Fixed Asset") or ("No." = '') then
            exit;
        FADeprBook.TESTFIELD("FA Posting Group");
        FAPostingGr.GET(FADeprBook."FA Posting Group");
        FAPostingGr.TESTFIELD("Acq. Cost Acc. on Disposal");
        LocalGLAcc.GET(FAPostingGr."Acq. Cost Acc. on Disposal");
        LocalGLAcc.CheckGLAcc();
        LocalGLAcc.TESTFIELD("Gen. Prod. Posting Group");
    end;

    procedure LocationIsAllowed(LocationCode: Code[10]): Boolean;
    var
        // WhseEmployee: Record "Warehouse Employee";//BC UPGRADE KUMARR78 Replacing Stnd Table with Custamised Table
        WhseEmployee: Record "Warehouse Employee_DTW FND";//BC UPGRADE KUMARR78 Replacing Stnd Table with Custamised Table

    begin
        //HEI.03>>
        WhseEmployee.SETRANGE("User ID", USERID);
        WhseEmployee.SETRANGE("Location Code", LocationCode);
        if WhseEmployee.FINDFIRST() or
        //HEI.03<<
           (USERID = '')
        then
            exit(true)
        else
            exit(false);
    end;
}

