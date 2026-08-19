codeunit 58121 "Req. Wksh.-Special Ret. Order"
{
    // version NAVW110.0.00.16996,FINXL10.00,MANXL7.00.001,DITW110.00.10,FM

    // DITW15.00.00.37 DDR 05/05/2010 issue 1136 Added to skip DIT item charges while creating purchase order lines
    // DITW16.00.00.39 DDR 02/12/2011 DIT-715 #182 Bugfix function InsertPurchOrderLine() to skip all DIT charges
    //                     21/05/2012 DIT-715 #182 Review item charge workflow when Purchase order linked to Prod. order (subcontract
    // 
    // MANXL7.00.001 DAT 05/03/2014 #18: Add code to fill "Blanket Order No." + "Blanket Order Line No." + "Requester ID"
    // MANXL7.00.001 WSA 11/07/2014 #87: Added code MANXL security
    // FINXL8.00.001 BSA 05/06/2015 #182: Create Emergency Orders + Add info on lines if checked
    // 
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.05  AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.07 AKH 29/02/2016 DIT-770 #1425 Automatic Drop Shipments and Special orders: Added functions GetPurchHeaderCounter(),CarryOutBatchActionTemp()
    //                                                                                        Added temporary DIT-770 #1399
    // DITW18.00.07 AKH 01/03/2016 DIT-770 #1425 Adjusted code
    // DITW18.00.07 VSC 17/03/2016 DIT-770 #2054 Suspend Status Check
    // DITW18.00.07 VSC 16/03/2016 DIT-770 #1228 Append and Update to Existing Purchase Order.
    // DITW18.00.07 VSC 20/03/2016 DIT-770 #1228 Check Item Exclusivity;
    // DITW18.00.07 VSC 23/06/2016 DIT-770 #1228 Remove standard nav commit. to prevent partial purch. docs on error
    // DITW18.00.07 VSC 30/06/2016 DIT-770 #1228 Testfield Quantity on Append mode must be on SalesLine.Quantity not Outstanding Quantity
    // DITW19.00.08 AKH 14/10/2016 BL#9753 (DIT-770 #1399) BugFix on automatic item charges for Purch. Orders (Dop Ship./Special ord.) created via Requisition Worksheet
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // 
    // DITW110.00.10 DDR 12/05/2017 NRQ#26354 fix auto-create drop shipment when multi-vendors
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.10 SFI 20/06/2017 BL#15657 (DIT-770 #934) Changes for Backorders
    // 
    // HEI.01 FDD-PRDGAP061 - Planning nonBOM items v0.2,  IBM.NAIKH01 - 19.12.2018
    //   # Added code in Function "InsertPurchOrderLine" to restrict the creation of PO if the Blanket Order No is Blank and
    //     add Blanket Order Details in New purch Line.
    //   # Added code in Function "InsertHeader"
    // 
    // HEI.02 S&OP Core interfaces IBM POSTOI01 20.05.2019
    //   # new global variable ReleasePurchDoc
    //   # add code to Code, the Purchase Order should becreated with Realeased Status, not Open
    // 
    // HEI.03 S&OP Core interfaces IBM POSTOI01 15.07.2019 Purchase requision interface
    //   # modify InsertPurchOrderLine and InsertHeader functions to update the SRM Contract Type field
    //   # direct unit cost
    // HEI.04 FDD-HT657 IBM NASTAA02 16.12.2019 # Ethiopia Intercompany Automation
    //   # Restriction on Blanket Order No. should not be checked for Drop Shipments on function "InsertPurchOrderLine"
    // HEI.05 CHG2033409 S&OP Core interfaces IBM POSTOI01 Purchase requisition
    //   # Restriction on Blanket Order No. should not be checked for IC Partener Code (vendor card) <> '' on function "InsertPurchOrderLine"
    // HEI.06 IBM Shankj03 03.11.2020
    //  # Added code to bypass Blanket Order No. check on function "InsertPurchOrderLine"
    // HEI.07 CHG2073467 HB1369 IBM GAVANM01 17.08.2020  Enhancements to the Intercompany automation functionality
    //   # new global var PurchaseOrdersNos
    //   # new function GetPurchaseOrdersNos
    // HEI.08 CHG2073468 HB1369 IBM GAVANM01 04.01.2021 Enhancements to Intercompany Part 3
    //   # code added to copy the "Sales Order No" into "Special Order No." in Purch Additional Header
    //   # code for Special Return Order functionality

    //Bc Upgrade YADAVM09 Drink it code blocked.
    //Bc Upgrade YADAVM09 Migrated.

    Permissions = TableData "Sales Line" = m;
    TableNo = "Requisition Line";

    trigger OnRun();
    begin
        if PlanningResiliency then
            rec.LOCKTABLE;

        CarryOutReqLineAction(Rec);
    end;

    var
        Text000: TextConst ENU = 'Worksheet Name                     #1##########\\', FRA = 'Nom demande achat                        #1##########\\';
        Text001: TextConst ENU = 'Checking worksheet lines           #2######\', FRA = 'Vérification des lignes demande achat    #2######\';
        Text002: TextConst ENU = 'Creating purchase orders           #3######\', FRA = 'Création des commandes achat             #3######\';
        Text003: TextConst ENU = 'Creating purchase lines            #4######\', FRA = 'Création des lignes achat                #4######\';
        Text004: TextConst ENU = 'Updating worksheet lines           #5######', FRA = 'Mise à jour des lignes demande achat     #5######';
        Text005: TextConst ENU = 'Deleting worksheet lines           #5######', FRA = 'Suppression des lignes demande achat     #5######';
        Text006: TextConst ENU = '%1 on sales order %2 is already associated with purchase order %3.', FRA = '%1 sur la commande vente %2 est déjà associé à la commande achat %3.';
        Text007: TextConst ENU = '<Month Text>', FRA = '<Month Text>';
        Text008: TextConst ENU = 'The combination of dimensions used in %1 %2, %3, %4 is blocked. %5', FRA = 'La combinaison analytique utilisée dans %1 %2, %3, %4 a provoqué une erreur. %5';
        Text009: TextConst ENU = 'A dimension used in %1 %2, %3, %4 has caused an error. %5', FRA = 'L''axe analytique utilisé dans %1 %2, %3, %4 a provoqué une erreur. %5';
        ReservEntry: Record "Reservation Entry";
        PurchSetup: Record "Purchases & Payables Setup";
        ReqTemplate: Record "Req. Wksh. Template";
        ReqWkshName: Record "Requisition Wksh. Name";
        PurchOrderHeader: Record "Purchase Header";
        PurchOrderLine: Record "Purchase Line";
        SalesOrderHeader: Record "Sales Header";
        SalesOrderLine: Record "Sales Line";
        TransHeader: Record "Transfer Header";
        AccountingPeriod: Record "Accounting Period";
        TempFailedReqLine: Record "Requisition Line" temporary;
        PurchasingCode: Record Purchasing;
        ReqWkshMakeOrders: Codeunit "Req. Wksh.-Special Ret. Order";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        ReserveReqLine: Codeunit "Req. Line-Reserve";
        DimMgt: Codeunit DimensionManagement;
        Window: Dialog;
        OrderDateReq: Date;
        PostingDateReq: Date;
        ReceiveDateReq: Date;
        EndOrderDate: Date;
        PlanningResiliency: Boolean;
        PrintPurchOrders: Boolean;
        ReferenceReq: Text[35];
        MonthText: Text[30];
        OrderCounter: Integer;
        LineCount: Integer;
        OrderLineCounter: Integer;
        StartLineNo: Integer;
        NextLineNo: Integer;
        Day: Integer;
        Week: Integer;
        Month: Integer;
        CounterFailed: Integer;
        PrevPurchCode: Code[10];
        PrevShipToCode: Code[10];
        Text010: TextConst ENU = 'must match %1 on Sales Order %2, Line %3', FRA = 'doit correspondre à la valeur %1 de la commande vente %2, ligne %3';
        PrevChangedDocOrderType: Option;
        PrevChangedDocOrderNo: Code[20];
        PurchOrderCounter: Integer;
        TempRecords: Boolean;
        NameAddressDetails: Text;
        //rMANXLSetup : Record "Manufacturing XL Setup";//Bc Upgrade YADAVM09 Dink it object<<
        CreateReservationOnTracking: Boolean;
        Err001: TextConst ENU = 'PO cannot be created. Blanket Order No. is Blank for WorkSheet template Name= %1, Journal Batch Name= %2,Line No.= %3';
        ReleasePurchDoc: Codeunit "Release Purchase Document";
        PurchaseOrdersNos: Text;

    procedure CarryOutBatchAction(var ReqLine2: Record "Requisition Line");
    var
        ReqLine: Record "Requisition Line";
    begin
        ReqLine.COPY(ReqLine2);
        ReqLine.SETRANGE("Accept Action Message", true);
        Code(ReqLine);
        ReqLine2 := ReqLine;
    end;

    procedure Set(NewPurchOrderHeader: Record "Purchase Header"; NewEndingOrderDate: Date; NewPrintPurchOrder: Boolean);
    begin
        PurchOrderHeader := NewPurchOrderHeader;
        EndOrderDate := NewEndingOrderDate;
        PrintPurchOrders := NewPrintPurchOrder;
        OrderDateReq := PurchOrderHeader."Order Date";
        PostingDateReq := PurchOrderHeader."Posting Date";
        ReceiveDateReq := PurchOrderHeader."Expected Receipt Date";
        ReferenceReq := PurchOrderHeader."Your Reference";
    end;

    local procedure "Code"(var ReqLine: Record "Requisition Line");
    var
        ReqLine2: Record "Requisition Line";
        ReqLine3: Record "Requisition Line";
    begin
        InitShipReceiveDetails;
        CLEAR(PurchOrderHeader);

        ReqLine.SETRANGE("Worksheet Template Name", ReqLine."Worksheet Template Name");
        ReqLine.SETRANGE("Journal Batch Name", ReqLine."Journal Batch Name");
        if not PlanningResiliency then
            ReqLine.LOCKTABLE;
        //Bc Upgrade YADAVM09>>
        // if ("Planning Line Origin" <> "Planning Line Origin"::"Order Planning")
        // //<< DITW18.00.07 AKH 01/03/2016 DIT-770 #1425
        // and (not TempRecords)
        // //>> DITW18.00.07 AKH DIT-770 #1425
        // then
        //   //<< DITW18.00.07 AKH 01/03/2016 DIT-770 #1425
        //   begin
        //     //>> DITW18.00.07 AKH DIT-770 #1425
        //     ReqTemplate.GET("Worksheet Template Name");
        //     if ReqTemplate.Recurring then begin
        //         SETRANGE("Order Date", 0D, EndOrderDate);
        //         SETFILTER("Expiration Date", '%1 | %2..', 0D, WORKDATE);
        //     end;
        //     //<< DITW18.00.07 AKH 01/03/2016 DIT-770 #1425
        // end;
        // //>> DITW18.00.07 AKH DIT-770 #1425
        //Bc Upgrade YADAVM09<<
        if not ReqLine.FIND('=><') then begin
            ReqLine."Line No." := 0;
            COMMIT;
            exit;
        end;
        //Bc Upgrade YADAVM09>>
        // if ReqTemplate.Recurring
        // //<< DITW18.00.07 AKH 01/03/2016 DIT-770 #1425
        // and (not TempRecords)
        // //>> DITW18.00.07 AKH DIT-770 #1425
        // then
        //     Window.OPEN(
        //       Text000 +
        //       Text001 +
        //       Text002 +
        //       Text003 +
        //       Text004)
        // else
        //     Window.OPEN(
        //       Text000 +
        //       Text001 +
        //       Text002 +
        //       Text003 +
        //       Text005);
        // Window.UPDATE(1, "Journal Batch Name");
        //Bc Upgrade YADAVM09<<
        // Check lines
        LineCount := 0;
        StartLineNo := ReqLine."Line No.";
        repeat
            LineCount := LineCount + 1;
            Window.UPDATE(2, LineCount);
            CheckRecurringLine(ReqLine);
            CheckReqWkshLine(ReqLine);
            if ReqLine.NEXT = 0 then
                ReqLine.FIND('-');
        until ReqLine."Line No." = StartLineNo;
        // Create lines
        LineCount := 0;
        OrderCounter := 0;
        OrderLineCounter := 0;
        //<< DITW18.00.07 AKH 29/02/2016 DIT-770 #1425
        // PurchOrderCounter := 0;//Bc upgrade YADAVM09 Drink it code<<
        //>> DITW18.00.07 AKH DIT-770 #1425
        PurchaseOrdersNos := '';
        //HEI.07
        CLEAR(PurchOrderHeader);
        SetPurchOrderHeader;
        ReqLine.SETCURRENTKEY(
          "Worksheet Template Name", "Journal Batch Name", "Vendor No.",
          "Sell-to Customer No.", "Ship-to Code", "Order Address Code", "Currency Code",
          "Ref. Order Type", "Ref. Order Status", "Ref. Order No.",
          "Location Code", "Transfer-from Code");

        if ReqLine.FIND('-') then
            repeat
                if PlanningResiliency then begin
                    if not TryCarryOutReqLineAction(ReqLine) then begin
                        SetFailedReqLine(ReqLine);
                        CounterFailed := CounterFailed + 1;
                    end;
                end else
                    CarryOutReqLineAction(ReqLine);
            until ReqLine.NEXT = 0;

        if PrintPurchOrders then
            PrintTransOrder(TransHeader);

        if PurchOrderHeader."Buy-from Vendor No." <> '' then
            FinalizeOrderHeader(PurchOrderHeader, ReqLine);

        if PrevChangedDocOrderNo <> '' then
            PrintChangedDocument(PrevChangedDocOrderType, PrevChangedDocOrderNo);
        //HEI.02
        // ReleasePurchDoc.DocStatusRelease(PurchOrderHeader, PurchOrderHeader);//Bc Upgrade YADAVM09 Drink it function<<
        //HEI.02
        // Copy number of created orders and current journal batch name to requisition worksheet
        ReqLine.INIT;
        ReqLine."Line No." := OrderCounter;
        //<< DITW18.00.07 AKH 29/02/2016 DIT-770 #1425
        //IF OrderCounter <> 0 THEN
        //if (OrderCounter <> 0) and not TempRecords then//Bc upgrade YADAVM09 Drink it code<<
        //>> DITW18.00.07 AKH DIT-770 #1425
        if not ReqTemplate.Recurring then begin
            // Not a recurring journal
            ReqLine2.COPY(ReqLine);
            ReqLine2.SETFILTER("Vendor No.", '<>%1', '');
            if ReqLine2.FINDFIRST then;
                // Remember the last line
            if ReqLine.FIND('-') then
                repeat
                    TempFailedReqLine := ReqLine;
                    if not TempFailedReqLine.FIND then
                        ReqLine.DELETE(true);
                until ReqLine.NEXT = 0;

            ReqLine3.SETRANGE("Worksheet Template Name", ReqLine."Worksheet Template Name");
            ReqLine3.SETRANGE("Journal Batch Name", ReqLine."Journal Batch Name");
            if not ReqLine3.FINDLAST then
                if INCSTR(ReqLine."Journal Batch Name") <> '' then begin
                    ReqWkshName.GET(ReqLine."Worksheet Template Name", ReqLine."Journal Batch Name");
                    ReqWkshName.DELETE;
                    ReqWkshName.Name := INCSTR(ReqLine."Journal Batch Name");
                    if ReqWkshName.INSERT then;
                    ReqLine."Journal Batch Name" := ReqWkshName.Name;
                end;
        end;
    end;

    local procedure CheckReqWkshLine(var ReqLine2: Record "Requisition Line");
    var
        SalesLine: Record "Sales Line";
        Purchasing: Record Purchasing;
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        if (ReqLine2."No." <> '') or (ReqLine2."Vendor No." <> '') or (ReqLine2.Quantity <> 0) then begin
            ReqLine2.TESTFIELD("No.");
            if ReqLine2."Action Message" <> ReqLine2."Action Message"::Cancel then
                ReqLine2.TESTFIELD(Quantity);
            if (ReqLine2."Action Message" = ReqLine2."Action Message"::" ") or
               (ReqLine2."Action Message" = ReqLine2."Action Message"::New)
            then
                if ReqLine2."Replenishment System" = ReqLine2."Replenishment System"::Purchase then begin
                    if ReqLine2."Planning Line Origin" = ReqLine2."Planning Line Origin"::"Order Planning" then
                        ReqLine2.TESTFIELD("Supply From");
                    ReqLine2.TESTFIELD("Vendor No.")
                end else
                    if ReqLine2."Replenishment System" = ReqLine2."Replenishment System"::Transfer then begin
                        ReqLine2.TESTFIELD("Location Code");
                        if ReqLine2."Planning Line Origin" = ReqLine2."Planning Line Origin"::"Order Planning" then
                            ReqLine2.TESTFIELD("Supply From");
                        ReqLine2.TESTFIELD("Transfer-from Code");
                    end;
        end;

        if not DimMgt.CheckDimIDComb(ReqLine2."Dimension Set ID") then
            ERROR(
              Text008,
              ReqLine2.TABLECAPTION, ReqLine2."Worksheet Template Name", ReqLine2."Journal Batch Name", ReqLine2."Line No.",
              DimMgt.GetDimCombErr);
        //TableID[1] := DimMgt.TypeToTableID3(Type);
        TableID[1] := DimMgt.PurchLineTypeToTableID(ReqLine2.Type);//Bc Upgrade YADAVM09 function name change in Bc<<
        No[1] := ReqLine2."No.";
        if not DimMgt.CheckDimValuePosting(TableID, No, ReqLine2."Dimension Set ID") then
            if ReqLine2."Line No." <> 0 then
                ERROR(
                  Text009,
                  ReqLine2.TABLECAPTION, ReqLine2."Worksheet Template Name", ReqLine2."Journal Batch Name", ReqLine2."Line No.",
                  DimMgt.GetDimValuePostingErr)
            else
                ERROR(DimMgt.GetDimValuePostingErr);
        //IF SalesLine.GET(SalesLine."Document Type"::Order,"Sales Order No.","Sales Order Line No.") AND  //commented by HEI.08
        if SalesLine.GET(SalesLine."Document Type"::"Return Order", ReqLine2."Sales Order No.", ReqLine2."Sales Order Line No.") and
           //HEI.08
           (SalesLine."Unit of Measure Code" <> ReqLine2."Unit of Measure Code")
        then
            if SalesLine."Drop Shipment" or
               (PurchasingCode.GET(ReqLine2."Purchasing Code") and PurchasingCode."Drop Shipment")
            then
                ReqLine2.FIELDERROR(
                  "Unit of Measure Code",
                  STRSUBSTNO(
                    Text010,
                    SalesLine.FIELDCAPTION("Unit of Measure Code"),
                    SalesLine."Document No.",
                    SalesLine."Line No."));

        if Purchasing.GET(ReqLine2."Purchasing Code") then
            if Purchasing."Drop Shipment" or Purchasing."Special Order" then begin
                //SalesLine.GET(SalesLine."Document Type"::Order,"Sales Order No.","Sales Order Line No.");         //commented by HEI.08
                SalesLine.GET(SalesLine."Document Type"::"Return Order", ReqLine2."Sales Order No.", ReqLine2."Sales Order Line No.");
                // HEI.08
                CheckLocation(ReqLine2);
                if (Purchasing."Drop Shipment" <> SalesLine."Drop Shipment") or
                   (Purchasing."Special Order" <> SalesLine."Special Order")
                then
                    ReqLine2.FIELDERROR(
                      "Purchasing Code",
                      STRSUBSTNO(
                        Text010,
                        SalesLine.FIELDCAPTION("Purchasing Code"),
                        SalesLine."Document No.",
                        SalesLine."Line No."));
            end;
    end;

    local procedure CarryOutReqLineAction(var ReqLine: Record "Requisition Line");
    var
        CarryOutAction: Codeunit "Carry Out Action";
        SalesLine: Record "Sales Line";
        ReleasePurchDoc: Codeunit "Release Purchase Document";
    begin
        case ReqLine."Replenishment System" of
            ReqLine."Replenishment System"::Transfer:
                case ReqLine."Action Message" of
                    ReqLine."Action Message"::Cancel:
                        begin
                            CarryOutAction.DeleteOrderLines(ReqLine);
                            OrderCounter := OrderCounter + 1;
                        end;
                    ReqLine."Action Message"::"Change Qty.", ReqLine."Action Message"::Reschedule, ReqLine."Action Message"::"Resched. & Chg. Qty.":
                        begin
                            if (PrevChangedDocOrderNo <> '') and
                               ((ReqLine."Ref. Order Type".AsInteger() <> PrevChangedDocOrderType) or (ReqLine."Ref. Order No." <> PrevChangedDocOrderNo))
                            then
                                PrintChangedDocument(PrevChangedDocOrderType, PrevChangedDocOrderNo);
                            CarryOutAction.SetPrintOrder(false);
                            CarryOutAction.TransOrderChgAndReshedule(ReqLine);
                            PrevChangedDocOrderType := ReqLine."Ref. Order Type".AsInteger();
                            PrevChangedDocOrderNo := ReqLine."Ref. Order No.";
                            OrderCounter := OrderCounter + 1;
                        end;
                    ReqLine."Action Message"::New, ReqLine."Action Message"::" ":
                        begin
                            CarryOutAction.SetPrintOrder(PrintPurchOrders);
                            CarryOutAction.InsertTransLine(ReqLine, TransHeader);
                            OrderCounter := OrderCounter + 1;
                        end;
                end;
            ReqLine."Replenishment System"::Purchase, ReqLine."Replenishment System"::"Prod. Order":
                case ReqLine."Action Message" of
                    ReqLine."Action Message"::Cancel:
                        begin
                            CarryOutAction.DeleteOrderLines(ReqLine);
                            OrderCounter := OrderCounter + 1;
                        end;
                    ReqLine."Action Message"::"Change Qty.", ReqLine."Action Message"::Reschedule, ReqLine."Action Message"::"Resched. & Chg. Qty.":
                        begin
                            if (PrevChangedDocOrderNo <> '') and
                               ((ReqLine."Ref. Order Type".AsInteger() <> PrevChangedDocOrderType) or (ReqLine."Ref. Order No." <> PrevChangedDocOrderNo))
                            then
                                PrintChangedDocument(PrevChangedDocOrderType, PrevChangedDocOrderNo);
                            CarryOutAction.SetPrintOrder(false);
                            CarryOutAction.PurchOrderChgAndReshedule(ReqLine);
                            PrevChangedDocOrderType := ReqLine."Ref. Order Type".AsInteger();
                            PrevChangedDocOrderNo := ReqLine."Ref. Order No.";
                            OrderCounter := OrderCounter + 1;
                        end;
                //Bc upgrade YADAVM09 Drink it code>>
                //<< DITW18.00.07 VSC 16/06/2016 DIT-770 #1228
                // "Action Message"::New, "Action Message"::" ", "Action Message"::Append:
                //     begin
                //         if "Action Message" = "Action Message"::Append then begin
                //             SalesLine.RESET;
                //             //SalesLine.SETRANGE("Document Type",SalesLine."Document Type"::Order);  //commented by HEI.08
                //             SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::"Return Order");   //HEI.08
                //             SalesLine.SETRANGE("Document No.", "Sales Order No.");
                //             // <<DITW110.00.10 DDR 12/05/2017 NRQ#26354
                //             SalesLine.SETRANGE("Line No.", "Sales Order Line No.");
                //             // >>DITW110.00.10 DDR NRQ#26354
                //             SalesLine.SETFILTER("Purchase Order No.", '<>%1', '');
                //             SalesLine.SETRANGE("Purchasing Code", ReqLine."Purchasing Code");
                //             if SalesLine.FINDFIRST then begin
                //                 //IF PurchOrderHeader.GET(PurchOrderHeader."Document Type"::Order,SalesLine."Purchase Order No.") THEN BEGIN    //commented by HEI.08
                //                 if PurchOrderHeader.GET(PurchOrderHeader."Document Type"::"Return Order", SalesLine."Purchase Order No.") then begin  //HEI.08
                //                     PrevPurchCode := SalesLine."Purchasing Code";
                //                     OrderCounter := OrderCounter + 1;
                //                     //<< DITW18.00.07 VSC 20/06/2016 DIT-770 #1228
                //                     if PurchOrderHeader.Status = PurchOrderHeader.Status::Released then begin
                //                         ReleasePurchDoc.PerformManualReopen(PurchOrderHeader);
                //                     end;
                //                     //>> DITW18.00.07 VSC DIT-770 #1228
                //                 end else
                //                     PurchOrderHeader.INIT;
                //Bc upgrade YADAVM09 Drink it code<<
                end;
        end;
        //>> DITW18.00.07 VSC DIT-770 #1228

        if (PurchOrderHeader."Buy-from Vendor No." <> '') and
           CheckInsertFinalizePurchaseOrderHeader(ReqLine, PurchOrderHeader)
        then begin
            FinalizeOrderHeader(PurchOrderHeader, ReqLine);
            PurchOrderLine.RESET;
            PurchOrderLine.SETRANGE("Document Type", PurchOrderHeader."Document Type");
            PurchOrderLine.SETRANGE("Document No.", PurchOrderHeader."No.");
            PurchOrderLine.SETFILTER("Special Order Sales Line No.", '<> 0');
            if PurchOrderLine.FIND('-') then
                repeat
                    //<<HEI.08
                    //SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,PurchOrderLine."Special Order Sales No.",
                    //  PurchOrderLine."Special Order Sales Line No.");
                    //>>HEI.08
                    //<<HEI.08
                    SalesOrderLine.GET(SalesOrderLine."Document Type"::"Return Order", PurchOrderLine."Special Order Sales No.",
                      PurchOrderLine."Special Order Sales Line No.");
                //>>HEI.08
                until PurchOrderLine.NEXT = 0;
        end;
        MakeRecurringTexts(ReqLine);
        InsertPurchOrderLine(ReqLine, PurchOrderHeader);
    end;
    //end;
    // end;
    //end;

    local procedure TryCarryOutReqLineAction(var ReqLine: Record "Requisition Line"): Boolean;
    begin
        ReqWkshMakeOrders.Set(PurchOrderHeader, EndOrderDate, PrintPurchOrders);
        ReqWkshMakeOrders.SetTryParam(
          ReqTemplate,
          LineCount,
          NextLineNo,
          PrevPurchCode,
          PrevShipToCode,
          OrderCounter,
          OrderLineCounter,
          TempFailedReqLine);
        if ReqWkshMakeOrders.RUN(ReqLine) then begin
            ReqWkshMakeOrders.GetTryParam(
              PurchOrderHeader,
              LineCount,
              NextLineNo,
              PrevPurchCode,
              PrevShipToCode,
              OrderCounter,
              OrderLineCounter);

            Window.UPDATE(3, OrderCounter);
            Window.UPDATE(4, LineCount);
            Window.UPDATE(5, OrderLineCounter);
            exit(true);
        end;
        exit(false)
    end;

    local procedure InsertPurchOrderLine(var ReqLine2: Record "Requisition Line"; var PurchOrderHeader: Record "Purchase Header");
    var
        PurchOrderLine2: Record "Purchase Line";
        AddOnIntegrMgt: Codeunit AddOnIntegrManagement;
        DimensionSetIDArr: array[10] of Integer;
        SalesLine: Record "Sales Line";
        AddNewLine: Boolean;
        //ItemExcluCheckAvail: Codeunit "Item Exclusivity-Check";//Bc Upgrade YADAVM09 Drink it object
        PurchaseLine1: Record "Purchase Line";
        PurchaseLinePrice: Record "Purchase Line Price FND";
        SalesHeader: Record "Sales Header";
        Vendor: Record Vendor;
    begin
        if (ReqLine2."No." = '') or (ReqLine2."Vendor No." = '') or (ReqLine2.Quantity = 0) then
            exit;
        //HEI.05>>
        if Vendor.GET(ReqLine2."Vendor No.") then;
        //HEI.05<<
        if Vendor."IC Partner Code" <> '' then begin
            //HEI.05
            //HEI.04>>
            //SalesHeader.GET(SalesHeader."Document Type"::Order, ReqLine2."Sales Order No.");  //commented by HEI.08
            SalesHeader.GET(SalesHeader."Document Type"::"Return Order", ReqLine2."Sales Order No.");
            //HEI.08
            //if not SalesHeader."Special Order" then//Bc upgrade YADAVM09 Drink it code<<
            //HEI.04<<
            //<<HEI.01
            //Bc upgrade YADAVM09 Drink it code>>
            // if "Blanket order Exist" = true then begin //HEI.06 >>
            //     if "Blanket Order No." = '' then
            //         ERROR(Err001, "Worksheet Template Name", "Journal Batch Name", "Line No.");
            // end; //HEI.06 <<
            //HEI.01>>
            //HEI.05>>
            // end else begin
            // if "Blanket order Exist" = true then begin //HEI.06 >>
            //     if "Blanket Order No." = '' then
            //         ERROR(Err001, "Worksheet Template Name", "Journal Batch Name", "Line No.");
            // end;
            //end; //HEI.06 <<
            //HEI.05<<
            //Bc upgrade YADAVM09 Drink it code<<
            if CheckInsertFinalizePurchaseOrderHeader(ReqLine2, PurchOrderHeader) then begin
                InsertHeader(ReqLine2);
                LineCount := 0;
                NextLineNo := 0;
                PrevPurchCode := ReqLine2."Purchasing Code";
                PrevShipToCode := ReqLine2."Ship-to Code";
            end;

            LineCount := LineCount + 1;
            if not PlanningResiliency then
                Window.UPDATE(4, LineCount);

            ReqLine2.TESTFIELD("Currency Code", PurchOrderHeader."Currency Code");
            //<< DITW18.00.07 VSC 16/06/2016 DIT-770 #1228
            //PurchOrderLine.INIT;
            AddNewLine := true;
            // if ReqLine2."Action Message" = ReqLine2."Action Message"::append then begin//Bc Upgrade YADAVM09 Drink it Field Dependency<<
            //HEI.08<<
            //  IF SalesLine.GET(SalesLine."Document Type"::Order,ReqLine2."Sales Order No.",ReqLine2."Sales Order Line No.") THEN
            //    AddNewLine := NOT PurchOrderLine.GET(PurchOrderLine."Document Type"::Order,SalesLine."Purchase Order No.",SalesLine."Purch. Order Line No.");
            //HEI.08>>
            //HEI.08<<
            if SalesLine.GET(SalesLine."Document Type"::"Return Order", ReqLine2."Sales Order No.", ReqLine2."Sales Order Line No.") then
                AddNewLine := not PurchOrderLine.GET(PurchOrderLine."Document Type"::"Return Order", SalesLine."Purchase Order No.", SalesLine."Purch. Order Line No.");
            //HEI.08>>
            //end;//Bc Upgrade YADAVM09 Drink it Field Dependency<<
            if AddNewLine then begin
                PurchOrderLine2.SETRANGE("Document Type", PurchOrderHeader."Document Type");
                PurchOrderLine2.SETRANGE("Document No.", PurchOrderHeader."No.");
                if (PurchOrderLine2."Document Type" <> PurchOrderHeader."Document Type") or
                  (PurchOrderLine2."Document No." <> PurchOrderHeader."No.") then begin
                    PurchOrderLine2.RESET;
                    PurchOrderLine2.SETRANGE("Document Type", PurchOrderHeader."Document Type");
                    PurchOrderLine2.SETRANGE("Document No.", PurchOrderHeader."No.");
                    if PurchOrderLine2.FINDLAST then
                        NextLineNo := PurchOrderLine2."Line No.";
                    NextLineNo := NextLineNo div 10000;
                    NextLineNo := NextLineNo * 10000;
                end;
                PurchOrderLine.INIT;
            end;
            //PurchOrderLine.SuspendDropSpecialCheck(true);//Bc upgrade YADAVM09 Drink it code<<
            //>> DITW18.00.07 VSC DIT-770 #1228
            // <<DITW16.00.00.39 DDR 02/12/2011 DIT-715 #182
            //PurchOrderLine.SetBatchInsertCheck(true);//Bc upgrade YADAVM09 Drink it code<<
            // >>DITW16.00.00.39 DDR DIT-715 #182
            PurchOrderLine.BlockDynamicTracking(true);
            //PurchOrderLine."Document Type" := PurchOrderLine."Document Type"::Order;        //commented by HEI.08
            PurchOrderLine."Document Type" := PurchOrderLine."Document Type"::"Return Order";
            //HEI.08
            PurchOrderLine."Buy-from Vendor No." := ReqLine2."Vendor No.";
            PurchOrderLine."Document No." := PurchOrderHeader."No.";
            //<< DITW18.00.07 VSC 16/06/2016 DIT-770 #1228
            if AddNewLine then begin
                //>> DITW18.00.07 VSC DIT-770 #1228
                NextLineNo := NextLineNo + 10000;
                PurchOrderLine."Line No." := NextLineNo;
                PurchOrderLine.VALIDATE(Type, ReqLine2.Type);
                PurchOrderLine.VALIDATE("No.", ReqLine2."No.");
                PurchOrderLine."Variant Code" := ReqLine2."Variant Code";
                PurchOrderLine.VALIDATE("Location Code", ReqLine2."Location Code");
                PurchOrderLine.VALIDATE("Unit of Measure Code", ReqLine2."Unit of Measure Code");
                PurchOrderLine."Qty. per Unit of Measure" := ReqLine2."Qty. per Unit of Measure";
                PurchOrderLine."Prod. Order No." := ReqLine2."Prod. Order No.";
                PurchOrderLine."Prod. Order Line No." := ReqLine2."Prod. Order Line No.";
                //<< DITW18.00.07 VSC 16/06/2016 DIT-770 #1228
            end;
            //>> DITW18.00.07 VSC DIT-770 #1228
            PurchOrderLine.VALIDATE(Quantity, ReqLine2.Quantity);
            if PurchOrderHeader."Prices Including VAT" then
                PurchOrderLine.VALIDATE("Direct Unit Cost", ReqLine2."Direct Unit Cost" * (1 + PurchOrderLine."VAT %" / 100))
            else
                PurchOrderLine.VALIDATE("Direct Unit Cost", ReqLine2."Direct Unit Cost");

            PurchOrderLine.VALIDATE("Line Discount %", ReqLine2."Line Discount %");
            PurchOrderLine."Vendor Item No." := ReqLine2."Vendor Item No.";

            PurchOrderLine.Description := ReqLine2.Description;
            PurchOrderLine."Description 2" := ReqLine2."Description 2";
            PurchOrderLine."Sales Order No." := ReqLine2."Sales Order No.";
            PurchOrderLine."Sales Order Line No." := ReqLine2."Sales Order Line No.";
            PurchOrderLine."Prod. Order No." := ReqLine2."Prod. Order No.";
            PurchOrderLine."Bin Code" := ReqLine2."Bin Code";
            PurchOrderLine."Item Category Code" := ReqLine2."Item Category Code";
            PurchOrderLine.Nonstock := ReqLine2.Nonstock;
            PurchOrderLine.VALIDATE("Planning Flexibility", ReqLine2."Planning Flexibility");
            PurchOrderLine.VALIDATE("Purchasing Code", ReqLine2."Purchasing Code");
            // PurchOrderLine."Product Group Code" := "Product Group Code";//Bc upgrade YADAVM09 Drink it code<<
            if ReqLine2."Due Date" <> 0D then begin
                PurchOrderLine.VALIDATE("Expected Receipt Date", ReqLine2."Due Date");
                PurchOrderLine."Requested Receipt Date" := PurchOrderLine."Planned Receipt Date";
            end;
            //>>HEI.03
            //PurchOrderLine."Document Date" := PurchOrderHeader."Document Date";//Bc upgrade YADAVM09 Drink it code<<
            //<<HEI.03
            //<<MANXL7.00.001 WSA 11/07/2014 #87
            //if rMANXLSetup.READPERMISSION then begin//Bc upgrade YADAVM09 Drink it code<<
            //>>MANXL7.00.001 WSA 11/07/2014 #87
            //<<MANXL7.00.001 DAT 05/03/2014 #18
            //Bc upgrade YADAVM09 Drink it code>>
            // PurchOrderLine."Blanket Order No." := ReqLine2."Blanket Order No.";
            // PurchOrderLine."Blanket Order Line No." := ReqLine2."Blanket Order Line No.";
            // PurchOrderLine."Requester ID" := ReqLine2."Requester ID";
            //Bc upgrade YADAVM09 Drink it code<<
            //>>MANXL7.00.001 DAT 05/03/2014 #18
            //<<MANXL7.00.001 WSA 11/07/2014 #87
        end;
        //>>MANXL7.00.001 WSA 11/07/2014 #87
        //<<FINXL8.00.001 BSA 08/06/2015 #182
        //Bc upgrade YADAVM09 Drink it code>>
        // PurchOrderLine."Emergency Order" := ReqLine2.Emergency;
        // if ReqLine2.Emergency then begin
        //     PurchOrderHeader."Emergency Order" := true;
        //     PurchOrderHeader.MODIFY;
        // end;
        //Bc upgrade YADAVM09 Drink it code<<
        //>>FINXL8.00.001 BSA 08/06/2015 #182
        AddOnIntegrMgt.TransferFromReqLineToPurchLine(PurchOrderLine, ReqLine2);

        PurchOrderLine."Drop Shipment" := ReqLine2."Sales Order Line No." <> 0;

        if PurchasingCode.GET(ReqLine2."Purchasing Code") then
            if PurchasingCode."Special Order" then begin
                PurchOrderLine."Special Order Sales No." := ReqLine2."Sales Order No.";
                PurchOrderLine."Special Order Sales Line No." := ReqLine2."Sales Order Line No.";
                PurchOrderLine."Special Order" := true;
                PurchOrderLine."Drop Shipment" := false;
                PurchOrderLine."Sales Order No." := '';
                PurchOrderLine."Sales Order Line No." := 0;
                PurchOrderLine."Special Order" := true;
                PurchOrderLine.UpdateUnitCost;
            end;
        // << DITW110.00.10 SFI 20/06/2017 BL#15657
        // ReserveReqLine.SetCreateReservationOnTracking(CreateReservationOnTracking);//Bc upgrade YADAVM09 Drink it code<<
        // >> DITW110.00.10 SFI BL#15657
        ReserveReqLine.TransferReqLineToPurchLine(ReqLine2, PurchOrderLine, ReqLine2."Quantity (Base)", false);
        DimensionSetIDArr[1] := PurchOrderLine."Dimension Set ID";
        DimensionSetIDArr[2] := ReqLine2."Dimension Set ID";
        PurchOrderLine."Dimension Set ID" :=
          DimMgt.GetCombinedDimensionSetID(
            DimensionSetIDArr, PurchOrderLine."Shortcut Dimension 1 Code", PurchOrderLine."Shortcut Dimension 2 Code");
        //<< DITW18.00.07 VSC 16/03/2016 DIT-770 #1228
        //PurchOrderLine.INSERT;
        //>> DITW18.00.07 VSC DIT-770 #1228
        // <<DITW16.00.00.40 DDR 21/05/2012 DIT-715 #182
        // PurchOrderLine.UpdateAADInfo();//Bc upgrade YADAVM09 Drink it code<<
        // >>DITW16.00.00.40 DDR DIT-715 #182
        //>>Hei.01
        PurchaseLine1.RESET;
        PurchaseLine1.SETRANGE("Document Type", PurchaseLine1."Document Type"::"Blanket Order");
        // PurchaseLine1.SETRANGE("Document No.", ReqLine2."Blanket Order No.");//Bc Upgrade YADAVM09 Drink it field <<
        // PurchaseLine1.SETRANGE("Line No.", ReqLine2."Blanket Order Line No.");//Bc Upgrade YADAVM09 Drink it field <<
        if PurchaseLine1.FINDFIRST then begin
            PurchOrderLine."Location Code" := PurchaseLine1."Location Code";
            PurchOrderLine."Description 2" := PurchaseLine1."Description 2";
            //PurchOrderLine."Direct Unit Cost excl. VAT" := PurchaseLine1."Direct Unit Cost";
            //The Direct Unit Cost is picked from the table 50035 - "Purchase Line Price" Else from the table 39 - "Purchase Line"
            PurchaseLinePrice.RESET;
            PurchaseLinePrice.SETRANGE("Document Type", PurchaseLinePrice."Document Type"::"Blanket Order");
            // PurchaseLinePrice.SETRANGE("Document No.", ReqLine2."Blanket Order No.");//Bc Upgrade YADAVM09 Drink it field <<
            // PurchaseLinePrice.SETRANGE("Document Line No.", ReqLine2."Blanket Order Line No.");//Bc Upgrade YADAVM09 Drink it field<<
            PurchaseLinePrice.SETRANGE("Unit of Measure Code", ReqLine2."Unit of Measure Code");
            PurchaseLinePrice.SETFILTER("Location Code", '=%1|=%2', ReqLine2."Location Code", '');
            if PurchaseLinePrice.FINDFIRST then begin
                //HEI.03
                //HEI.03 comment line PurchOrderLine."Direct Unit Cost" := PurchaseLinePrice."Direct Unit Cost"
                //>>HEI.03
                PurchOrderLine."Direct Unit Cost" := PurchaseLinePrice."Direct Unit Cost";
                // PurchOrderLine."Item Charge Value" := PurchaseLinePrice."Direct Unit Cost";//Bc Upgrade YADAVM09 Drink it field <<
                PurchOrderLine.VALIDATE("Direct Unit Cost", PurchaseLinePrice."Direct Unit Cost");
                //<<HEI.03
            end else begin
                //HEI.03
                //HEI.03 comment line PurchOrderLine."Direct Unit Cost" := PurchaseLine1."Direct Unit Cost";
                //>>HEI.03
                PurchOrderLine.VALIDATE("Direct Unit Cost", PurchaseLine1."Direct Unit Cost");
                //PurchOrderLine."Item Charge Value" := PurchaseLine1."Item Charge Value";//Bc Upgrade YADAVM09 Drink it field <<
                //<<HEI.03
            end;
            //HEI.03
            //HEI.03 comment line PurchOrderLine."Unit Cost" := PurchaseLine1."Unit Cost";
            //>>HEI.03
            PurchOrderLine.VALIDATE("Line Discount %", PurchaseLine1."Line Discount %");
            if PurchOrderLine.Quantity <> 0 then
                PurchOrderLine.VALIDATE("Inv. Discount Amount", PurchaseLine1."Inv. Discount Amount");
            //<<HEI.03
            PurchOrderLine."Vendor Item No." := PurchaseLine1."Vendor Item No.";
            PurchOrderLine."Dimension Set ID" := PurchaseLine1."Dimension Set ID";
            PurchOrderLine."Requested Receipt Date" := PurchaseLine1."Requested Receipt Date";
            PurchOrderLine."SRM Contract No. FND" := PurchaseLine1."SRM Contract No. FND";
            //PurchOrderLine."SRM Contract Name
            // PurchOrderLine."Contract Type" := PurchaseLine1."Contract Type";//Bc Upgrade YADAVM09 Drink it field <<
            //>>HEI.03
            PurchOrderLine."SRM Contract Type FND" := PurchaseLine1."SRM Contract Type FND";
            PurchOrderLine."SRM Contract Type FND" := PurchaseLine1."SRM Contract Type FND";
            PurchOrderLine."SRM Contract Line No. FND" := PurchaseLine1."SRM Contract Line No. FND";
            PurchOrderLine."Responsibility Center" := PurchaseLine1."Responsibility Center";
            PurchOrderLine."Lead Time Calculation" := PurchaseLine1."Lead Time Calculation";
            PurchOrderLine."Initial Quantity FND" := PurchaseLine1."Initial Quantity FND";
            //PurchOrderLine."Original Quantity" := PurchaseLine1."Original Quantity";//Bc Upgrade YADAVM09 Drink it field <<
            PurchOrderLine."Last Changed Date/Time FND" := PurchaseLine1."Last Changed Date/Time FND";
            PurchOrderLine."Recalculate Invoice Disc." := false;
            //<<HEI.03
            PurchOrderLine."Valid From FND" := PurchaseLine1."Valid From FND";
            PurchOrderLine."Valid To FND" := PurchaseLine1."Valid To FND";
            PurchOrderLine."CMG Code FND" := PurchaseLine1."CMG Code FND";
            PurchOrderLine."Consumption Location Code FND" := PurchaseLine1."Consumption Location Code FND";
            PurchOrderLine."Target Value Currency FND" := PurchaseLine1."Target Value Currency FND";
            PurchOrderLine."Target Value Amount FND" := PurchaseLine1."Target Value Amount FND";
            // PurchOrderLine."Company Tax Registration No." := PurchaseLine1."Company Tax Registration No.";//Bc Upgrade YADAVM09 Drink it field <<
            // PurchOrderLine.Weight := PurchaseLine1.Weight;//Bc Upgrade YADAVM09 Drink it field <<
        end;
        //<<Hei.01
        //<< DITW18.00.07 VSC 16/03/2016 DIT-770 #1228
        if AddNewLine then
            PurchOrderLine.INSERT
        else
            PurchOrderLine.MODIFY;
        //>> DITW18.00.07 VSC DIT-770 #1228
        if ReqLine2.Reserve then
            ReserveBindingOrderToPurch(PurchOrderLine, ReqLine2);

        if PurchOrderLine."Drop Shipment" or PurchOrderLine."Special Order" then begin
            SalesOrderLine.LOCKTABLE;
            SalesOrderHeader.LOCKTABLE;
            //SalesOrderHeader.GET(SalesOrderHeader."Document Type"::Order,"Sales Order No.");   //commented by HEI.08
            SalesOrderHeader.GET(SalesOrderHeader."Document Type"::"Return Order", ReqLine2."Sales Order No.");
            //HEI.08
            if not PurchOrderLine."Special Order" then
                ReqLine2.TESTFIELD("Ship-to Code", SalesOrderHeader."Ship-to Code");
            // SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,"Sales Order No.","Sales Order Line No.");         //commented by HEI.08
            SalesOrderLine.GET(SalesOrderLine."Document Type"::"Return Order", ReqLine2."Sales Order No.", ReqLine2."Sales Order Line No.");
            //HEI.08
            //<< DITW18.00.07 AKH 29/02/2016 DIT-770 #1425
            if PurchasingCode.Code <> SalesOrderLine."Purchasing Code" then
                PurchasingCode.GET(SalesOrderLine."Purchasing Code");
            //>> DITW18.00.07 AKH DIT-770 #1425
            SalesOrderLine.TESTFIELD(Type, SalesOrderLine.Type::Item);
            //<< DITW18.00.07 VSC 16/06/2016 DIT-770 #1228
            if AddNewLine then begin
                //>> DITW18.00.07 VSC DIT-770 #1228
                if SalesOrderLine."Purch. Order Line No." <> 0 then
                    ERROR(Text006, SalesOrderLine."No.", SalesOrderLine."Document No.", SalesOrderLine."Purchase Order No.");
                if SalesOrderLine."Special Order Purchase No." <> '' then
                    ERROR(Text006, SalesOrderLine."No.", SalesOrderLine."Document No.", SalesOrderLine."Special Order Purchase No.");
                //<< DITW18.00.07 VSC 16/06/2016 DIT-770 #1228
            end;
            //>> DITW18.00.07 VSC DIT-770 #1228
            if not PurchOrderLine."Special Order" then
                ReqLine2.TESTFIELD("Sell-to Customer No.", SalesOrderLine."Sell-to Customer No.");
            ReqLine2.TESTFIELD(Type, SalesOrderLine.Type);
            //<< DITW18.00.07 VSC 30/06/2016 DIT-770 #1228
            if AddNewLine then begin
                //>> DITW18.00.07 VSC DIT-770 #1228
                ReqLine2.TESTFIELD(
                  Quantity,
                  ROUND(
                    SalesOrderLine."Outstanding Quantity" *
                    SalesOrderLine."Qty. per Unit of Measure" /
                    ReqLine2."Qty. per Unit of Measure",
                    0.00001));
                //<< DITW18.00.07 VSC 30/06/2016 DIT-770 #1228
            end else begin
                ReqLine2.TESTFIELD(
                  Quantity,
                  ROUND(
                    SalesOrderLine.Quantity *
                    SalesOrderLine."Qty. per Unit of Measure" /
                    ReqLine2."Qty. per Unit of Measure",
                    0.00001));
            end;
            //>> DITW18.00.07 VSC DIT-770 #1228
            ReqLine2.TESTFIELD("No.", SalesOrderLine."No.");
            ReqLine2.TESTFIELD("Location Code", SalesOrderLine."Location Code");
            ReqLine2.TESTFIELD("Variant Code", SalesOrderLine."Variant Code");
            ReqLine2.TESTFIELD("Bin Code", SalesOrderLine."Bin Code");
            ReqLine2.TESTFIELD("Prod. Order No.", '');
            ReqLine2.TESTFIELD("Qty. per Unit of Measure", ReqLine2."Qty. per Unit of Measure");
            SalesOrderLine.VALIDATE("Unit Cost (LCY)");

            if SalesOrderLine."Special Order" then begin
                SalesOrderLine."Special Order Purchase No." := PurchOrderLine."Document No.";
                SalesOrderLine."Special Order Purch. Line No." := PurchOrderLine."Line No.";
            end else begin
                SalesOrderLine."Purchase Order No." := PurchOrderLine."Document No.";
                SalesOrderLine."Purch. Order Line No." := PurchOrderLine."Line No.";
            end;
            SalesOrderLine.MODIFY;
        end;
        //Bc upgrade YADAVM09 Drink it code<<
        //<< DITW18.00.07 VSC 30/06/2016 DIT-770 #1228
        // if AddNewLine then begin
        //     //>> DITW18.00.07 VSC 30/06/2016 DIT-770 #1228
        //     if TransferExtendedText.PurchCheckIfAnyExtText(PurchOrderLine, false) then begin
        //         TransferExtendedText.InsertPurchExtText(PurchOrderLine);
        //         PurchOrderLine2.SETRANGE("Document Type", PurchOrderHeader."Document Type");
        //         PurchOrderLine2.SETRANGE("Document No.", PurchOrderHeader."No.");
        //         if PurchOrderLine2.FINDLAST then
        //             NextLineNo := PurchOrderLine2."Line No.";
        //     end;
        //<< DITW18.00.07 AKH 29/02/2016 DIT-770 #1425
        //         PurchOrderLine.SetBatchInsertCheck(true);
        //         if (PurchOrderLine.Type = PurchOrderLine.Type::Item) then begin
        //             if PurchOrderLine.InsertCharges4(0, false) then begin
        //                 //<< DITW19.00.08 AKH 14/10/2016 BL#9753
        //                 PurchOrderLine.MODIFY(true);
        //                 //>> DITW19.00.08 AKH BL#9753
        //                 PurchOrderLine2.SETRANGE("Document Type", PurchOrderHeader."Document Type");
        //                 PurchOrderLine2.SETRANGE("Document No.", PurchOrderHeader."No.");
        //                 if PurchOrderLine2.FINDLAST then begin
        //                     PurchOrderLine2.RoundThousandLineNo();
        //                     NextLineNo := PurchOrderLine2."Line No.";
        //                 end;
        //                 NextLineNo := NextLineNo + 10000;
        //             end;
        //         end;
        //         //>> DITW18.00.07 AKH DIT-770 #1425
        //Bc Upgrade YADAVM09 Drink it code <<
        //>> DITW18.00.07 VSC DIT-770 #1228
    end;
    //end;//Bc upgrade YADAVM09 Drink it code<<

    local procedure InsertHeader(var ReqLine2: Record "Requisition Line");
    var
        SalesHeader: Record "Sales Header";
        Vendor: Record Vendor;
        SpecialOrder: Boolean;
        PurchaseHeader1: Record "Purchase Header";
        PurchHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        OrderCounter := OrderCounter + 1;
        if not PlanningResiliency then
            Window.UPDATE(3, OrderCounter);

        PurchSetup.GET;
        PurchSetup.TESTFIELD("Order Nos.");
        CLEAR(PurchOrderHeader);
        //<< DITW18.00.07 VSC 16/06/2016 DIT-770 #1228
        PurchOrderHeader.SuspendStatusCheck(true);
        //>> DITW18.00.07 VSC 16/06/2016 DIT-770 #1228
        PurchOrderHeader.INIT;
        //PurchOrderHeader."Document Type" := PurchOrderHeader."Document Type"::Order;        //commented by HEI08
        PurchOrderHeader."Document Type" := PurchOrderHeader."Document Type"::"Return Order";
        //HEI.08
        PurchOrderHeader."No." := '';
        PurchOrderHeader."Posting Date" := PostingDateReq;

        PurchOrderHeader.INSERT(true);
        PurchOrderHeader."Your Reference" := ReferenceReq;
        PurchOrderHeader."Order Date" := OrderDateReq;
        PurchOrderHeader."Expected Receipt Date" := ReceiveDateReq;
        //<<FINXL8.00.001 BSA 05/06/2015 #182
        // PurchOrderHeader."Emergency Order" := Emergency;//Bc upgrade YADAVM09 Drink it code<<
        // PurchOrderHeader.fctSetblnfromWorksheet(true);//Bc upgrade YADAVM09 Drink it code<<
        //>>FINXL8.00.001 BSA 05/06/2015 #182
        PurchOrderHeader.VALIDATE("Buy-from Vendor No.", ReqLine2."Vendor No.");
        if ReqLine2."Order Address Code" <> '' then
            PurchOrderHeader.VALIDATE("Order Address Code", ReqLine2."Order Address Code");

        if ReqLine2."Sell-to Customer No." <> '' then
            PurchOrderHeader.VALIDATE("Sell-to Customer No.", ReqLine2."Sell-to Customer No.");

        PurchOrderHeader.VALIDATE("Currency Code", ReqLine2."Currency Code");

        if PurchasingCode.GET(ReqLine2."Purchasing Code") then
            if PurchasingCode."Special Order" then
                SpecialOrder := true;

        if not SpecialOrder then begin
            if ReqLine2."Ship-to Code" <> '' then
                PurchOrderHeader.VALIDATE("Ship-to Code", ReqLine2."Ship-to Code")
            else
                PurchOrderHeader.VALIDATE("Location Code", ReqLine2."Location Code");
        end else begin
            PurchOrderHeader.VALIDATE("Location Code", ReqLine2."Location Code");
            PurchOrderHeader.SetShipToForSpecOrder;
            if Vendor.GET(PurchOrderHeader."Buy-from Vendor No.") then
                PurchOrderHeader.VALIDATE("Shipment Method Code", Vendor."Shipment Method Code");
            //HEI.08<<
            if PurchHeaderAdditional.GET(PurchOrderHeader."Document Type", PurchOrderHeader."No.") then begin
                PurchHeaderAdditional."Special Order No." := ReqLine2."Sales Order No.";
                PurchHeaderAdditional.MODIFY;
            end;
            //HEI.08>>
        end;
        if not SpecialOrder then
            if SalesHeader.GET(SalesHeader."Document Type"::Order, ReqLine2."Sales Order No.") then begin
                PurchOrderHeader."Ship-to Name" := SalesHeader."Ship-to Name";
                PurchOrderHeader."Ship-to Name 2" := SalesHeader."Ship-to Name 2";
                PurchOrderHeader."Ship-to Address" := SalesHeader."Ship-to Address";
                PurchOrderHeader."Ship-to Address 2" := SalesHeader."Ship-to Address 2";
                PurchOrderHeader."Ship-to Post Code" := SalesHeader."Ship-to Post Code";
                PurchOrderHeader."Ship-to City" := SalesHeader."Ship-to City";
                PurchOrderHeader."Ship-to Contact" := SalesHeader."Ship-to Contact";
            end;
        if SpecialOrder then
            if Vendor.GET(PurchOrderHeader."Buy-from Vendor No.") then
                PurchOrderHeader."Shipment Method Code" := Vendor."Shipment Method Code";
        //>>Hei.01
        PurchaseHeader1.RESET;
        PurchaseHeader1.SETRANGE("Document Type", PurchaseHeader1."Document Type"::"Blanket Order");
        //PurchaseHeader1.SETRANGE("No.", "Blanket Order No.");//Bc upgrade YADAVM09 Drink it code<<
        if PurchaseHeader1.FINDFIRST then begin
            PurchOrderHeader."Payment Terms Code" := PurchaseHeader1."Payment Terms Code";
            PurchOrderHeader."Due Date" := PurchaseHeader1."Due Date";
            PurchOrderHeader."Shipment Method Code" := PurchaseHeader1."Shipment Method Code";
            PurchOrderHeader."Shipment Method Location FND" := PurchaseHeader1."Shipment Method Location FND";
            PurchOrderHeader."Currency Code" := PurchaseHeader1."Currency Code";
            PurchOrderHeader."Purchaser Code" := PurchaseHeader1."Purchaser Code";
            PurchOrderHeader."Recalculate Invoice Disc." := PurchaseHeader1."Recalculate Invoice Disc.";
            //PurchOrderHeader.Prepayment Payment Terms Code
            PurchOrderHeader."SRM Contract No. FND" := PurchaseHeader1."SRM Contract No. FND";
            PurchOrderHeader."SRM Contract Name FND" := PurchaseHeader1."SRM Contract Name FND";
            //PurchOrderHeader."Contract Type" := PurchaseHeader1."Contract Type";//Bc upgrade YADAVM09 Drink it code<<
            //>>HEI.03
            PurchOrderHeader."SRM Contract Type FND" := PurchaseHeader1."SRM Contract Type FND";
            //<<HEI.03
            PurchOrderHeader."Valid From FND" := PurchaseHeader1."Valid From FND";
            PurchOrderHeader."Valid To FND" := PurchaseHeader1."Valid To FND";
            PurchOrderHeader."Channel FND" := PurchaseHeader1."Channel FND";
            PurchOrderHeader."Consumption Date FND" := PurchaseHeader1."Consumption Date FND";
            PurchOrderHeader."Target Value Currency FND" := PurchaseHeader1."Target Value Currency FND";
            PurchOrderHeader."Target Value Amount FND" := PurchaseHeader1."Target Value Amount FND";
            //PurchOrderHeader."Blanket Order No." := "Blanket Order No.";//Bc upgrade YADAVM09 Drink it code<<
        end;
        //<<Hei.01
        PurchOrderHeader.MODIFY;
        //<< DITW18.00.07 VSC 23/06/2016 DIT-770 #1228
        //COMMIT;
        //>> DITW18.00.07 VSC DIT-770 #1228
        ReqLine2.LOCKTABLE;
        PurchOrderHeader.MARK(true);
        //<< DITW18.00.07 AKH 29/02/2016 DIT-770 #1425
        //PurchOrderCounter := PurchOrderCounter + 1;//Bc Upgrade YADAVM09 Drink it code<<
        //>> DITW18.00.07 AKH DIT-770 #1425
        //HEI.07>>
        if PurchaseOrdersNos <> '' then
            PurchaseOrdersNos += ',' + PurchOrderHeader."No."
        else
            PurchaseOrdersNos := PurchOrderHeader."No.";
            //HEI.07<<
    end;

    local procedure FinalizeOrderHeader(PurchOrderHeader: Record "Purchase Header"; var ReqLine: Record "Requisition Line");
    var
        ReqLine2: Record "Requisition Line";
        CarryOutAction: Codeunit "Carry Out Action";
    begin
        if ReqTemplate.Recurring then begin
            // Recurring journal
            ReqLine2.COPY(ReqLine);
            ReqLine2.SETRANGE("Vendor No.", PurchOrderHeader."Buy-from Vendor No.");
            ReqLine2.SETRANGE("Sell-to Customer No.", PurchOrderHeader."Sell-to Customer No.");
            ReqLine2.SETRANGE("Ship-to Code", PurchOrderHeader."Ship-to Code");
            ReqLine2.SETRANGE("Order Address Code", PurchOrderHeader."Order Address Code");
            ReqLine2.SETRANGE("Currency Code", PurchOrderHeader."Currency Code");
            ReqLine2.FIND('-');
            repeat
                OrderLineCounter := OrderLineCounter + 1;
                if not PlanningResiliency then
                    Window.UPDATE(5, OrderLineCounter);
                if ReqLine2."Order Date" <> 0D then begin
                    ReqLine2.VALIDATE(
                      "Order Date",
                      CALCDATE(ReqLine2."Recurring Frequency", ReqLine2."Order Date"));
                    ReqLine2.VALIDATE("Currency Code", PurchOrderHeader."Currency Code");
                end;
                if (ReqLine2."Recurring Method" = ReqLine2."Recurring Method"::Variable) and
                   (ReqLine2."No." <> '')
                then begin
                    ReqLine2.Quantity := 0;
                    ReqLine2."Line Discount %" := 0;
                end;
                ReqLine2.MODIFY;
            until ReqLine2.NEXT = 0;
        end else begin
            // Not a recurring journal
            OrderLineCounter := OrderLineCounter + LineCount;
            if not PlanningResiliency then
                Window.UPDATE(5, OrderLineCounter);
            ReqLine2.COPY(ReqLine);
            ReqLine2.SETRANGE("Vendor No.", PurchOrderHeader."Buy-from Vendor No.");
            ReqLine2.SETRANGE("Sell-to Customer No.", PurchOrderHeader."Sell-to Customer No.");
            ReqLine2.SETRANGE("Ship-to Code", PurchOrderHeader."Ship-to Code");
            ReqLine2.SETRANGE("Order Address Code", PurchOrderHeader."Order Address Code");
            ReqLine2.SETRANGE("Currency Code", PurchOrderHeader."Currency Code");
            ReqLine2.SETRANGE("Location Code", PurchOrderHeader."Location Code");
            ReqLine2.SETRANGE("Purchasing Code", PrevPurchCode);
            if ReqLine2.FIND('-') then begin
                ReqLine2.BlockDynamicTracking(true);
                ReservEntry.SETCURRENTKEY(
                  "Source ID", "Source Ref. No.", "Source Type", "Source Subtype",
                  "Source Batch Name", "Source Prod. Order Line");
                repeat
                    TempFailedReqLine := ReqLine2;
                    if not TempFailedReqLine.FIND then begin
                        //  ReserveReqLine.FilterReservFor(ReservEntry, ReqLine2);//Bc Upgrade YADAVM09 Function removed in Bc27 vesion<<
                        ReqLine2.SetReservationFilters(ReservEntry);//Bc Upgrade YADAVM09<<
                        ReservEntry.DELETEALL(true);
                        ReqLine2.DELETE(true);
                    end;
                until ReqLine2.NEXT = 0;
            end;
        end;
        //<< DITW18.00.07 VSC 23/06/2016 DIT-770 #1228
        //COMMIT;
        //>> DITW18.00.07 VSC DIT-770 #1228

        CarryOutAction.SetPrintOrder(PrintPurchOrders);
        CarryOutAction.PrintPurchaseOrder(PurchOrderHeader);
    end;

    local procedure CheckRecurringLine(var ReqLine2: Record "Requisition Line");
    var
        DummyDateFormula: DateFormula;
    begin
        if ReqLine2."No." <> '' then
            if ReqTemplate.Recurring then begin
                ReqLine2.TESTFIELD("Recurring Method");
                ReqLine2.TESTFIELD("Recurring Frequency");
                if ReqLine2."Recurring Method" = ReqLine2."Recurring Method"::Variable then
                    ReqLine2.TESTFIELD(Quantity);
            end else begin
                ReqLine2.TESTFIELD("Recurring Method", 0);
                ReqLine2.TESTFIELD("Recurring Frequency", DummyDateFormula);
            end;
    end;

    local procedure MakeRecurringTexts(var ReqLine2: Record "Requisition Line");
    begin
        if (ReqLine2."No." <> '') and (ReqLine2."Recurring Method" <> 0) and (ReqLine2."Order Date" <> 0D) then begin
            Day := DATE2DMY(ReqLine2."Order Date", 1);
            Week := DATE2DWY(ReqLine2."Order Date", 2);
            Month := DATE2DMY(ReqLine2."Order Date", 2);
            MonthText := FORMAT(ReqLine2."Order Date", 0, Text007);
            AccountingPeriod.SETRANGE("Starting Date", 0D, ReqLine2."Order Date");
            if not AccountingPeriod.FINDLAST then
                AccountingPeriod.Name := '';
            ReqLine2.Description :=
              DELCHR(
                PADSTR(
                  STRSUBSTNO(ReqLine2.Description, Day, Week, Month, MonthText, AccountingPeriod.Name),
                  MAXSTRLEN(ReqLine2.Description)),
                '>');
            ReqLine2.MODIFY;
        end;
    end;

    local procedure ReserveBindingOrderToPurch(var PurchLine: Record "Purchase Line"; var ReqLine: Record "Requisition Line");
    var
        ProdOrderComp: Record "Prod. Order Component";
        SalesLine: Record "Sales Line";
        ServLine: Record "Service Line";
        JobPlanningLine: Record "Job Planning Line";
        AsmLine: Record "Assembly Line";
        TrackingSpecification: Record "Tracking Specification"; // BC FR Upgrade KAIRAR01 -Version 28.1.49322.0 Compatibility Fix
        ProdOrderCompReserve: Codeunit "Prod. Order Comp.-Reserve";
        SalesLineReserve: Codeunit "Sales Line-Reserve";
        ServLineReserve: Codeunit "Service Line-Reserve";
        JobPlanningLineReserve: Codeunit "Job Planning Line-Reserve";
        AsmLineReserve: Codeunit "Assembly Line-Reserve";
        ReservQty: Decimal;
        ReservQtyBase: Decimal;
    begin
        PurchLine.CALCFIELDS("Reserved Quantity", "Reserved Qty. (Base)");
        if (PurchLine."Quantity (Base)" - PurchLine."Reserved Qty. (Base)") > ReqLine."Demand Quantity (Base)" then begin
            ReservQty := ReqLine."Demand Quantity";
            ReservQtyBase := ReqLine."Demand Quantity (Base)";
        end else begin
            ReservQty := PurchLine.Quantity - PurchLine."Reserved Quantity";
            ReservQtyBase := PurchLine."Quantity (Base)" - PurchLine."Reserved Qty. (Base)";
        end;

        case ReqLine."Demand Type" of
            DATABASE::"Prod. Order Component":
                begin
                    ProdOrderComp.GET(ReqLine."Demand Subtype", ReqLine."Demand Order No.", ReqLine."Demand Line No.", ReqLine."Demand Ref. No.");
                    // BC FR Upgrade KAIRAR01 -Version 28.1.49322.0 Compatibility Fix >>
                    // ProdOrderCompReserve.BindToPurchase(ProdOrderComp, PurchLine, ReservQty, ReservQtyBase);
                    TrackingSpecification.InitTrackingSpecification(Database::Microsoft.Purchases.Document."Purchase Line", PurchLine."Document Type".AsInteger(), PurchLine."Document No.", '', 0, PurchLine."Line No.",
                    PurchLine."Variant Code", PurchLine."Location Code", PurchLine."Qty. per Unit of Measure");
                    ProdOrderCompReserve.BindToTracking(ProdOrderComp, TrackingSpecification, PurchLine.Description, PurchLine."Expected Receipt Date", ReservQty, ReservQtyBase);
                    // BC FR Upgrade KAIRAR01 -Version 28.1.49322.0 Compatibility Fix <<
                end;
            DATABASE::"Sales Line":
                begin
                    SalesLine.GET(ReqLine."Demand Subtype", ReqLine."Demand Order No.", ReqLine."Demand Line No.");
                    // BC FR Upgrade KAIRAR01 -Version 28.1.49322.0 Compatibility Fix >>
                    // SalesLineReserve.BindToPurchase(SalesLine, PurchLine, ReservQty, ReservQtyBase);
                    TrackingSpecification.InitTrackingSpecification(Database::Microsoft.Purchases.Document."Purchase Line", PurchLine."Document Type".AsInteger(), PurchLine."Document No.", '', 0, PurchLine."Line No.",
                    PurchLine."Variant Code", PurchLine."Location Code", PurchLine."Qty. per Unit of Measure");
                    SalesLineReserve.BindToTracking(SalesLine, TrackingSpecification, PurchLine.Description, PurchLine."Expected Receipt Date", ReservQty, ReservQtyBase);
                    // BC FR Upgrade KAIRAR01 -Version 28.1.49322.0 Compatibility Fix <<
                    if SalesLine.Reserve = SalesLine.Reserve::Never then begin
                        SalesLine.Reserve := SalesLine.Reserve::Optional;
                        SalesLine.MODIFY();
                    end;
                end;
            DATABASE::"Service Line":
                begin
                    ServLine.GET(ReqLine."Demand Subtype", ReqLine."Demand Order No.", ReqLine."Demand Line No.");
                    // BC FR Upgrade KAIRAR01 -Version 28.1.49322.0 Compatibility Fix >>
                    // ServLineReserve.BindToPurchase(ServLine, PurchLine, ReservQty, ReservQtyBase);
                    TrackingSpecification.InitTrackingSpecification(Database::Microsoft.Purchases.Document."Purchase Line", PurchLine."Document Type".AsInteger(), PurchLine."Document No.", '', 0, PurchLine."Line No.",
                    PurchLine."Variant Code", PurchLine."Location Code", PurchLine."Qty. per Unit of Measure");
                    ServLineReserve.BindToTracking(ServLine, TrackingSpecification, PurchLine.Description, PurchLine."Expected Receipt Date", ReservQty, ReservQtyBase);
                    // BC FR Upgrade KAIRAR01 -Version 28.1.49322.0 Compatibility Fix <<
                    if ServLine.Reserve = ServLine.Reserve::Never then begin
                        ServLine.Reserve := ServLine.Reserve::Optional;
                        ServLine.MODIFY();
                    end;
                end;
            DATABASE::"Job Planning Line":
                begin
                    JobPlanningLine.SETRANGE("Job Contract Entry No.", ReqLine."Demand Line No.");
                    JobPlanningLine.FINDFIRST();
                    // BC FR Upgrade KAIRAR01 -Version 28.1.49322.0 Compatibility Fix >>
                    // JobPlanningLineReserve.BindToPurchase(JobPlanningLine, PurchLine, ReservQty, ReservQtyBase);
                    TrackingSpecification.InitTrackingSpecification(Database::Microsoft.Purchases.Document."Purchase Line", PurchLine."Document Type".AsInteger(), PurchLine."Document No.", '', 0, PurchLine."Line No.",
                    PurchLine."Variant Code", PurchLine."Location Code", PurchLine."Qty. per Unit of Measure");
                    JobPlanningLineReserve.BindToTracking(JobPlanningLine, TrackingSpecification, PurchLine.Description, PurchLine."Expected Receipt Date", ReservQty, ReservQtyBase);
                    // BC FR Upgrade KAIRAR01 -Version 28.1.49322.0 Compatibility Fix <<
                    if JobPlanningLine.Reserve = JobPlanningLine.Reserve::Never then begin
                        JobPlanningLine.Reserve := JobPlanningLine.Reserve::Optional;
                        JobPlanningLine.MODIFY();
                    end;
                end;
            DATABASE::"Assembly Line":
                begin
                    AsmLine.GET(ReqLine."Demand Subtype", ReqLine."Demand Order No.", ReqLine."Demand Line No.");
                    // BC FR Upgrade KAIRAR01 -Version 28.1.49322.0 Compatibility Fix >>
                    // AsmLineReserve.BindToPurchase(AsmLine, PurchLine, ReservQty, ReservQtyBase);
                    TrackingSpecification.InitTrackingSpecification(Database::Microsoft.Purchases.Document."Purchase Line", PurchLine."Document Type".AsInteger(), PurchLine."Document No.", '', 0, PurchLine."Line No.",
                    PurchLine."Variant Code", PurchLine."Location Code", PurchLine."Qty. per Unit of Measure");
                    AsmLineReserve.BindToTracking(AsmLine, TrackingSpecification, PurchLine.Description, PurchLine."Expected Receipt Date", ReservQty, ReservQtyBase);
                    // BC FR Upgrade KAIRAR01 -Version 28.1.49322.0 Compatibility Fix <<
                    if AsmLine.Reserve = AsmLine.Reserve::Never then begin
                        AsmLine.Reserve := AsmLine.Reserve::Optional;
                        AsmLine.MODIFY();
                    end;
                end;
        end;
        PurchLine.MODIFY();
    end;

    procedure SetTryParam(TryReqTemplate: Record "Req. Wksh. Template"; TryLineCount: Integer; TryNextLineNo: Integer; TryPrevPurchCode: Code[10]; TryPrevShipToCode: Code[10]; TryOrderCounter: Integer; TryOrderLineCounter: Integer; var TryFailedReqLine: Record "Requisition Line");
    begin
        SetPlanningResiliency;
        ReqTemplate := TryReqTemplate;
        LineCount := TryLineCount;
        NextLineNo := TryNextLineNo;
        PrevPurchCode := TryPrevPurchCode;
        PrevShipToCode := TryPrevShipToCode;
        OrderCounter := TryOrderCounter;
        OrderLineCounter := TryOrderLineCounter;
        if TryFailedReqLine.FIND('-') then
            repeat
                TempFailedReqLine := TryFailedReqLine;
                if TempFailedReqLine.INSERT then;
            until TryFailedReqLine.NEXT = 0;
    end;

    procedure GetTryParam(var TryPurchOrderHeader: Record "Purchase Header"; var TryLineCount: Integer; var TryNextLineNo: Integer; var TryPrevPurchCode: Code[10]; var TryPrevShipToCode: Code[10]; var TryOrderCounter: Integer; var TryOrderLineCounter: Integer);
    begin
        TryPurchOrderHeader.COPY(PurchOrderHeader);
        TryLineCount := LineCount;
        TryNextLineNo := NextLineNo;
        TryPrevPurchCode := PrevPurchCode;
        TryPrevShipToCode := PrevShipToCode;
        TryOrderCounter := OrderCounter;
        TryOrderLineCounter := OrderLineCounter;
    end;

    procedure SetFailedReqLine(var TryFailedReqLine: Record "Requisition Line");
    begin
        TempFailedReqLine := TryFailedReqLine;
        TempFailedReqLine.INSERT;
    end;

    procedure SetPlanningResiliency();
    begin
        PlanningResiliency := true;
    end;

    procedure GetFailedCounter(): Integer;
    begin
        exit(CounterFailed);
    end;

    local procedure PrintTransOrder(TransferHeader: Record "Transfer Header");
    var
        CarryOutAction: Codeunit "Carry Out Action";
    begin
        if TransferHeader."No." <> '' then begin
            CarryOutAction.SetPrintOrder(PrintPurchOrders);
            CarryOutAction.PrintTransferOrder(TransferHeader);
        end;
    end;

    local procedure PrintChangedDocument(OrderType: Option; var OrderNo: Code[20]);
    var
        DummyReqLine: Record "Requisition Line";
        TransferHeader: Record "Transfer Header";
        PurchaseHeader: Record "Purchase Header";
        CarryOutAction: Codeunit "Carry Out Action";
    begin
        CarryOutAction.SetPrintOrder(PrintPurchOrders);
        case OrderType of
            DummyReqLine."Ref. Order Type"::Transfer.AsInteger():
                begin
                    TransferHeader.GET(OrderNo);
                    PrintTransOrder(TransferHeader);
                end;
            DummyReqLine."Ref. Order Type"::Purchase.AsInteger():
                begin
                    PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, OrderNo);
                    PrintPurchOrder(PurchaseHeader);
                end;
        end;
        OrderNo := '';
    end;

    local procedure PrintPurchOrder(PurchHeader: Record "Purchase Header");
    var
        CarryOutAction: Codeunit "Carry Out Action";
    begin
        if PurchHeader."No." <> '' then begin
            CarryOutAction.SetPrintOrder(PrintPurchOrders);
            CarryOutAction.PrintPurchaseOrder(PurchHeader);
        end;
    end;

    local procedure SetPurchOrderHeader();
    begin
        PurchOrderHeader."Order Date" := OrderDateReq;
        PurchOrderHeader."Posting Date" := PostingDateReq;
        PurchOrderHeader."Expected Receipt Date" := ReceiveDateReq;
        PurchOrderHeader."Your Reference" := ReferenceReq;
    end;

    local procedure CheckAddressDetails(SalesOrderNo: Code[20]; SalesLineNo: Integer) Result: Boolean;
    var
        SalesLine: Record "Sales Line";
        Purchasing: Record Purchasing;
    begin
        //IF SalesLine.GET(SalesLine."Document Type"::Order,SalesOrderNo,SalesLineNo) THEN      //commented by HEI.08
        if SalesLine.GET(SalesLine."Document Type"::"Return Order", SalesOrderNo, SalesLineNo) then  //HEI.08
            if Purchasing.GET(SalesLine."Purchasing Code") then
                case true of
                    Purchasing."Drop Shipment":
                        Result :=
                          not CheckDropShptAddressDetails(SalesOrderNo);
                    Purchasing."Special Order":
                        Result :=
                          not CheckSpecOrderAddressDetails(SalesLine."Location Code");
                end;
    end;

    local procedure CheckLocation(RequisitionLine: Record "Requisition Line");
    var
        InventorySetup: Record "Inventory Setup";
    begin
        InventorySetup.GET;
        if InventorySetup."Location Mandatory" then
            RequisitionLine.TESTFIELD("Location Code");
    end;

    procedure GetPurchHeaderCounter(): Integer;
    begin
        //<< DITW18.00.07 AKH 29/02/2016 DIT-770 #1425
        exit(PurchOrderCounter);
    end;

    procedure CarryOutBatchActionTemp(var ReqLine2: Record "Requisition Line" temporary);
    var
        ReqLine: Record "Requisition Line";
    begin
        //<< DITW18.00.07 AKH 29/02/2016 DIT-770 #1425
        TempRecords := true;
        ReqLine.COPY(ReqLine2);
        ReqLine2.SETRANGE("Accept Action Message", true);
        Code(ReqLine2);
        ReqLine2.COPY(ReqLine);
    end;

    local procedure CheckInsertFinalizePurchaseOrderHeader(RequisitionLine: Record "Requisition Line"; var PurchOrderHeader: Record "Purchase Header") Result: Boolean;
    begin
        Result :=
  (PurchOrderHeader."Buy-from Vendor No." <> RequisitionLine."Vendor No.") or
  (PurchOrderHeader."Sell-to Customer No." <> RequisitionLine."Sell-to Customer No.") or
  (PrevShipToCode <> RequisitionLine."Ship-to Code") or
  (PurchOrderHeader."Order Address Code" <> RequisitionLine."Order Address Code") or
  (PurchOrderHeader."Currency Code" <> RequisitionLine."Currency Code") or
  (PrevPurchCode <> RequisitionLine."Purchasing Code") or
  (PurchOrderHeader."Location Code" <> RequisitionLine."Location Code") or
  CheckAddressDetails(RequisitionLine."Sales Order No.", RequisitionLine."Sales Order Line No.");
    end;

    local procedure CheckDropShptAddressDetails(SalesNo: Code[20]): Boolean;
    var
        SalesHeader: Record "Sales Header";
        DropShptNameAddressDetails: Text;
    begin
        SalesHeader.GET(SalesHeader."Document Type"::Order, SalesNo);
        DropShptNameAddressDetails :=
          SalesHeader."Ship-to Name" + SalesHeader."Ship-to Name 2" +
          SalesHeader."Ship-to Address" + SalesHeader."Ship-to Address 2" +
          SalesHeader."Ship-to Post Code" + SalesHeader."Ship-to City" +
          SalesHeader."Ship-to Contact";
        if NameAddressDetails = '' then
            NameAddressDetails := DropShptNameAddressDetails;
        exit(NameAddressDetails = DropShptNameAddressDetails);
    end;

    local procedure CheckSpecOrderAddressDetails(LocationCode: Code[10]): Boolean;
    var
        Location: Record Location;
        CompanyInfo: Record "Company Information";
        SpecOrderNameAddressDetails: Text;
    begin
        if Location.GET(LocationCode) then
            SpecOrderNameAddressDetails :=
              Location.Name + Location."Name 2" +
              Location.Address + Location."Address 2" +
              Location."Post Code" + Location.City +
              Location.Contact
        else begin
            CompanyInfo.GET;
            SpecOrderNameAddressDetails :=
              CompanyInfo."Ship-to Name" + CompanyInfo."Ship-to Name 2" +
              CompanyInfo."Ship-to Address" + CompanyInfo."Ship-to Address 2" +
              CompanyInfo."Ship-to Post Code" + CompanyInfo."Ship-to City" +
              CompanyInfo."Ship-to Contact";
        end;
        if NameAddressDetails = '' then
            NameAddressDetails := SpecOrderNameAddressDetails;
        exit(NameAddressDetails = SpecOrderNameAddressDetails);
    end;

    local procedure InitShipReceiveDetails();
    begin
        PrevShipToCode := '';
        PrevPurchCode := '';
        NameAddressDetails := '';
    end;

    procedure SetCreateReservationOnTracking(NewCreateReservationOnTracking: Boolean);
    begin
        // << DITW110.00.10 SFI 20/06/2017 BL#15657
        CreateReservationOnTracking := NewCreateReservationOnTracking;
    end;

    procedure GetPurchaseOrdersNos(): Text;
    begin
        //HEI.07
        exit(PurchaseOrdersNos);
    end;
}

