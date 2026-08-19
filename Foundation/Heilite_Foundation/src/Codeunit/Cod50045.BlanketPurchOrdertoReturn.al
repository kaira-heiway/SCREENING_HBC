codeunit 50045 "Blanket Purch. Order to Return"
{
    // version NAVW110.0.00.15052,DITW110.00.09,HEI.01
    // DITW15.00.00.23 DDR 08/08/2008 Drink-it Item Charges functionnalities
    //                                Added call to function SetBatchInsertCheck() when insert/modify Purch line
    //                                Correction (Temporary) from NAVW15.00.01 (SP1)
    // DITW15.00.00.28 DDR 28/11/2008 Bugfix to assign item charges and disc/promo per order
    // DITW15.00.00.36 DDR 27/11/2009 issue 796 auto syggest assignment for other item charge types (G/L account)
    // DITW16.00.00.42 DDR 01/03/2013 DIT-715 #572 Added "Tax Date"
    //                                             Added functions GetOldChargeLines()
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0014.1
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0083.1
    //                             Correct calculation of "Approved Line Amount" when creating order from blanket order
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0112.1
    //                             Disables doulbe functionality for approved line amount, is already calculated in quantity validation
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.05 YHE 06/11/2014 DIT-770 #961 : fill "Approved Dimension set ID" on PurchOrderLine from PurchBlanketOrderLine
    // DITW18.00.07 VSC 23/06/2016 DIT-770 #2058 Set Route No. when creating order
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // 
    // HEI.01 HLSRM03 IBM LAZARE02 02.08.2017
    //   # New event publishers: OnBeforeMakeOrder, OnAfterMakeOrderHeader, OnAfterValidateDirectUnitCost, OnBeforeModifyBlanketOrderLine,
    //                           OnAfterMakeOrder, OnAfterInitPurchLine
    //   # Use workdate as Posting Date, Document Date, Expected Receipt Date
    // 
    // HEI.02 HLSRM03 IBM LAZARE02 23.11.2017
    //   # Duplicate codeunit 97 in order to implement return order creation
    //   # Adapt existing code to return order
    // 
    // HEI.03 Defect #1960 IBM NASTAA02 04.05.2018 # NAV_Purchase Return Order_Create Warehouse Shipment_Error
    //   # Reset "Qty. to Receive", "Qty. to Receive (Base)", "Qty. to Return" and ""Qty. to Return (Base)" values
    // HEI.04 CHG0246348 IBM.AB 23.03.2019
    //   # Code added to flow Purch. Reason Code
    // HEI.05 CHG2317685 SAHAL01 17.10.2025 Block Functionality Enhancement for Vendors
    //   # Added Code

    // BC Upgrade MISHRS14 >>
    // Added HEI.05 tag - calling the function "CheckBlockedVendorOnDocuments"
    // BC Upgrade MISHRS14 << 



    TableNo = "Purchase Header";

    trigger OnRun();
    var
        TempItemChrgAssgnPurch: Record "Item Charge Assignment (Purch)" temporary;
        //  TransferTaxCharges: Codeunit "Tax Item Charges Mgt.";
        //   CommonItemChrgMgt: Codeunit "Common Item Charges Mgt.";
        // SRMInterfaceManagement: Codeunit "SRM Interface Management";//BC Upgrade SHARMP16-- Interface Code.
        TempPurchChargeLine: Record "Purchase Line" temporary;
        Vend: Record Vendor;
        PrepmtMgt: Codeunit "Prepayment Mgt.";
        lcduReleasePurchDoc: Codeunit "Release Purchase Document";
        ShouldRedistributeInvoiceAmount: Boolean;
        NextLineNo: Integer;

        //BC Upgrade MISHRS14 >>
        // HEI.05
        PurchasesUtilsL: Codeunit "Purchases-Utils";
    //BC Upgrade MISHRS14 <<

    begin
        rec.TESTFIELD("Document Type", Rec."Document Type"::"Blanket Order");
        ShouldRedistributeInvoiceAmount := PurchCalcDiscByType.ShouldRedistributeInvoiceDiscountAmount(Rec);

        Vend.GET(Rec."Buy-from Vendor No.");
        Vend.CheckBlockedVendOnDocs(Vend, false);

        if QtyToReturnIsZero(Rec) then
            ERROR(Text002);

        //HEI.01>>
        OnBeforeMakeOrder(Rec);
        //HEI.01<<

        PurchSetup.GET();

        PurchOrderHeader := Rec;
        PurchOrderHeader."Document Type" := PurchOrderHeader."Document Type"::"Return Order";
        PurchOrderHeader."No. Printed" := 0;
        PurchOrderHeader.Status := PurchOrderHeader.Status::Open;
        PurchOrderHeader."No." := '';

        //<< DITW18.00.07 VSC 23/06/2016 DIT-770 #2058
        // PurchOrderHeader.SetRoute(Vend, PurchSetup);//BC Upgrade SHARMP16 -- Drink-IT code

        //>> DITW18.00.07 VSC DIT-770 #2058

        //BC Upgrade MISHRS14 >>
        //HEI.05>>
        PurchasesUtilsL.CheckBlockedVendorOnDocuments(Vend, PurchOrderHeader);
        //HEI.05<<
        // BC Upgrade MISHRS14 <<

        PurchOrderLine.LOCKTABLE();
        PurchOrderHeader.INSERT(true);

        //HEI.01>>
        /*old code:
        IF "Order Date" = 0D THEN
          PurchOrderHeader."Order Date" := WORKDATE
        else
          PurchOrderHeader."Order Date" := "Order Date";
        IF "Posting Date" <> 0D THEN
          PurchOrderHeader."Posting Date" := "Posting Date";
        PurchOrderHeader."Document Date" := "Document Date";
        PurchOrderHeader."Expected Receipt Date" := "Expected Receipt Date";
        */
        PurchOrderHeader.TESTFIELD("Consumption Date FND");
        PurchOrderHeader."Order Date" := rec."Consumption Date FND";
        PurchOrderHeader."Posting Date" := rec."Consumption Date FND";
        PurchOrderHeader."Document Date" := rec."Consumption Date FND";
        PurchOrderHeader."Expected Receipt Date" := rec."Consumption Date FND";
        PurchOrderHeader."Blanket Order No. FND" := rec."No.";
        //HEI.01<<
        //BC Upgrade SHARMP16 Begin>> --- Drink-IT fields
        // <<DITW16.00.00.42 DDR 01/03/2013 DIT-715 #574
        // if "Tax Date" = 0D then begin
        //     case PurchSetup."Default Tax Date" of
        //         PurchSetup."Default Tax Date"::OrderDate:
        //             PurchOrderHeader."Tax Date" := PurchOrderHeader."Order Date";
        //         PurchSetup."Default Tax Date"::ShipRecvDate:
        //             PurchOrderHeader."Tax Date" := PurchOrderHeader."Expected Receipt Date";
        //     end;
        // end;
        // >>DITW16.00.00.42 DDR DIT-715 #574
        //BC Upgrade SHARMP16 End<< --- Drink-IT fields
        PurchOrderHeader."Shortcut Dimension 1 Code" := rec."Shortcut Dimension 1 Code";
        PurchOrderHeader."Shortcut Dimension 2 Code" := rec."Shortcut Dimension 2 Code";
        PurchOrderHeader."Dimension Set ID" := rec."Dimension Set ID";
        PurchOrderHeader."Inbound Whse. Handling Time" := rec."Inbound Whse. Handling Time";
        PurchOrderHeader."Location Code" := rec."Location Code";
        PurchOrderHeader."Ship-to Name" := rec."Ship-to Name";
        PurchOrderHeader."Ship-to Name 2" := rec."Ship-to Name 2";
        PurchOrderHeader."Ship-to Address" := rec."Ship-to Address";
        PurchOrderHeader."Ship-to Address 2" := rec."Ship-to Address 2";
        PurchOrderHeader."Ship-to City" := rec."Ship-to City";
        PurchOrderHeader."Ship-to Post Code" := rec."Ship-to Post Code";
        PurchOrderHeader."Ship-to County" := rec."Ship-to County";
        PurchOrderHeader."Ship-to Country/Region Code" := rec."Ship-to Country/Region Code";
        PurchOrderHeader."Ship-to Contact" := rec."Ship-to Contact";

        PurchOrderHeader."Prepayment %" := Vend."Prepayment %";
        if PurchOrderHeader."Posting Date" = 0D then
            PurchOrderHeader."Posting Date" := WORKDATE();

        // <<DITW15.00.00.28 DDR 28/11/2008
        //PurchOrderHeader."Disc.Promo. Order Calculated" := true;//BC Upgrade SHARMP16-- Drink-IT code
        // >>DITW15.00.00.28 DDR
        //HEI.04>>
        PurchOrderHeader."Purch. Reason Code FND" := rec."Purch. Reason Code FND";
        //HEI.04<<
        PurchOrderHeader.MODIFY();

        //HEI.01>>
        OnAfterMakeOrderHeader(Rec, PurchOrderHeader);
        //HEI.01<<
        // BC Upgrade BHARDA11 >>
        InitPurchaseReturnLines(Rec, PurchOrderHeader); // BC Upgrade BHARDA11 -- 17June2026
        // BC Upgrade BHARDA11 <<

        // <<DITW15.00.00.23 DDR 08/08/2008
        // PurchBlanketOrderLine.SetBatchInsertCheck(true);//BC Upgrade SHARMP16 -- Drink-IT code
        // PurchOrderLine.SetBatchInsertCheck(true);//BC Upgrade SHARMP16 -- Drink-IT code
        // >>DITW15.00.00.23 DDR

        //BC Upgrade SHARMP-16 begin>>---- Interface code
        // PurchBlanketOrderLine.RESET;
        // PurchBlanketOrderLine.SETRANGE("Document Type", rec."Document Type");
        // PurchBlanketOrderLine.SETRANGE("Document No.", rec."No.");

        // //BC Upgrade SHARMP16 BEGIN>> --- Drink-IT code
        // // <<DITW16.00.00.42 DDR 01/03/2013 DIT-715 #572
        // // if PurchOrderHeader."Tax Date" <> "Tax Date" then
        // //     PurchBlanketOrderLine.SETFILTER("Item Charge Type", '<>%1', PurchBlanketOrderLine."Item Charge Type"::Tax);
        // // if PurchOrderHeader."Order Date" <> "Order Date" then
        // //     PurchBlanketOrderLine.SETRANGE("Is Item Charge", false);
        // // >>DITW16.00.00.42 DDR DIT-715 #572
        // //BC Upgrade SHARMP16 end<< --- Drink-IT code
        // if PurchBlanketOrderLine.findset then
        //     repeat
        //         if (PurchBlanketOrderLine.Type = PurchBlanketOrderLine.Type::" ") or
        //            (PurchBlanketOrderLine."Qty. to Return" <> 0)
        //         then begin
        //             PurchLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        //             PurchLine.SETRANGE("Blanket Order No.", PurchBlanketOrderLine."Document No.");
        //             PurchLine.SETRANGE("Blanket Order Line No.", PurchBlanketOrderLine."Line No.");
        //             QuantityOnOrders := 0;
        //             if PurchLine.findset then
        //                 repeat
        //                     if (PurchLine."Document Type" = PurchLine."Document Type"::"Return Order") or
        //                        ((PurchLine."Document Type" = PurchLine."Document Type"::"Credit Memo") and
        //                         (PurchLine."Return Shipment No." = ''))
        //                     then
        //                         QuantityOnOrders := QuantityOnOrders - PurchLine."Outstanding Qty. (Base)"
        //                     else
        //                         if (PurchLine."Document Type" = PurchLine."Document Type"::Order) or
        //                            ((PurchLine."Document Type" = PurchLine."Document Type"::Invoice) and
        //                             (PurchLine."Receipt No." = ''))
        //                         then
        //                             QuantityOnOrders := QuantityOnOrders + PurchLine."Outstanding Qty. (Base)";
        //                 until PurchLine.NEXT = 0;
        //             if (ABS(PurchBlanketOrderLine."Qty. to Return (Base)") > ABS(PurchBlanketOrderLine."Qty. Received (Base)")) or
        //                (PurchBlanketOrderLine."Quantity (Base)" * PurchBlanketOrderLine."Outstanding Qty. (Base)" < 0)
        //             then
        //                 ERROR(
        //                   QuantityCheckErr,
        //                   PurchBlanketOrderLine.FIELDCAPTION("Qty. to Return (Base)"),
        //                   PurchBlanketOrderLine."Qty. to Return (Base)",
        //                   PurchBlanketOrderLine.Type, PurchBlanketOrderLine."No.",
        //                   PurchBlanketOrderLine.FIELDCAPTION("Line No."), PurchBlanketOrderLine."Line No.",
        //                   PurchBlanketOrderLine.FIELDCAPTION("Qty. Received (Base)"),
        //                   PurchBlanketOrderLine."Qty. Received (Base)");

        //             PurchOrderLine := PurchBlanketOrderLine;
        //             //HEI.01>>
        //             OnAfterInitPurchLine(PurchBlanketOrderLine, PurchOrderLine);
        //             //HEI.01<<
        //             ResetQuantityFields(PurchOrderLine);
        //             PurchOrderLine."Document Type" := PurchOrderHeader."Document Type";
        //             PurchOrderLine."Document No." := PurchOrderHeader."No.";
        //             PurchOrderLine."Blanket Order No." := rec."No.";
        //             PurchOrderLine."Blanket Order Line No." := PurchBlanketOrderLine."Line No.";

        //             if (PurchOrderLine."No." <> '') and (PurchOrderLine.Type <> 0) then begin
        //                 PurchOrderLine.Amount := 0;
        //                 PurchOrderLine."Amount Including VAT" := 0;
        //                 PurchOrderLine.VALIDATE(Quantity, PurchBlanketOrderLine."Qty. to Return");
        //                 //HEI.01>>
        //                 /*old code:
        //                 IF PurchBlanketOrderLine."Expected Receipt Date" <> 0D THEN
        //                   PurchOrderLine.VALIDATE("Expected Receipt Date",PurchBlanketOrderLine."Expected Receipt Date")
        //                 else
        //                   PurchOrderLine.VALIDATE("Order Date",PurchOrderHeader."Order Date");
        //                 PurchOrderLine.VALIDATE("Direct Unit Cost",PurchBlanketOrderLine."Direct Unit Cost");
        //                 // <<DITW15.00.00.28 DDR 28/11/2008
        //                 PurchOrderLine."Item Charge Value" := PurchBlanketOrderLine."Item Charge Value";
        //                 // >>DITW15.00.00.28 DDR
        //                 */
        //                 PurchOrderLine.VALIDATE("Order Date", PurchOrderHeader."Order Date");
        //                 // PurchOrderLine.VALIDATE("Document Date", PurchOrderHeader."Document Date");//BC Upgrade SHARMP16-- Drink-IT field
        //                 // if SRMInterfaceManagement.IsSRMPurchaseBlanketOrderLine(PurchBlanketOrderLine) then//BC Upgrade SHARMP16-- Interface Code
        //                 //     SRMInterfaceManagement.GetBlanketOrderPurchPrice(PurchBlanketOrderLine, PurchOrderLine, true)//BC Upgrade SHARMP16-- Interface Code
        //                 //else begin//BC Upgrade SHARMP16-- Interface Code
        //                 PurchOrderLine.VALIDATE("Direct Unit Cost", PurchBlanketOrderLine."Direct Unit Cost");
        //                 // <<DITW15.00.00.28 DDR 28/11/2008
        //                 //  PurchOrderLine."Item Charge Value" := PurchBlanketOrderLine."Item Charge Value";//BC Upgrade SHARMP16 Begin>> ---- Drink-IT code
        //                 // >>DITW15.00.00.28 DDR
        //                 //end;//BC Upgrade SHARMP16-- Interface Code
        //                 //HEI.01<<
        //                 PurchOrderLine.VALIDATE("Line Discount %", PurchBlanketOrderLine."Line Discount %");
        //                 if PurchOrderLine.Quantity <> 0 then
        //                     PurchOrderLine.VALIDATE("Inv. Discount Amount", PurchBlanketOrderLine."Inv. Discount Amount");
        //                 PurchBlanketOrderLine.CALCFIELDS("Reserved Qty. (Base)");
        //                 if PurchBlanketOrderLine."Reserved Qty. (Base)" <> 0 then
        //                     ReservePurchLine.TransferPurchLineToPurchLine(
        //                       PurchBlanketOrderLine, PurchOrderLine, -PurchBlanketOrderLine."Qty. to Return (Base)");
        //             end;

        //             if Vend."Prepayment %" <> 0 then
        //                 PurchOrderLine."Prepayment %" := Vend."Prepayment %";
        //             PrepmtMgt.SetPurchPrepaymentPct(PurchOrderLine, PurchOrderHeader."Posting Date");
        //             PurchOrderLine.VALIDATE("Prepayment %");

        //             PurchOrderLine."Shortcut Dimension 1 Code" := PurchBlanketOrderLine."Shortcut Dimension 1 Code";
        //             PurchOrderLine."Shortcut Dimension 2 Code" := PurchBlanketOrderLine."Shortcut Dimension 2 Code";
        //             PurchOrderLine."Dimension Set ID" := PurchBlanketOrderLine."Dimension Set ID";
        //             //<<DITW17.00.02 TEC1 10/09/2013 DIT-770 #144
        //             // PurchOrderLine."App. Prod. Posting Group" := PurchBlanketOrderLine."App. Prod. Posting Group";//BC Upgrade SHARMP16 ---- Drink-IT code
        //             //>>DITW17.00.02 TEC1 DIT-770 #144
        //             //<< DITW17.00.05 YHE 06/11/2014 DIT-770 #961
        //             // PurchOrderLine."Approved Dimension set ID" := PurchBlanketOrderLine."Approved Dimension set ID";//BC Upgrade SHARMP16 ---- Drink-IT code
        //             //>>DITW17.00.05 YHE 06/11/2014 DIT-770 #961
        //             PurchOrderLine.DefaultDeferralCode;
        //             if IsPurchOrderLineToBeInserted(PurchOrderLine) then
        //                 PurchOrderLine.INSERT;
        //             //BC Upgrade SHARMP16 Begin>> ---- Drink-IT code
        //             // <<DITW15.00.00.23 DDR 08/08/2008 - DITW15.00.00.28 DDR 28/11/2008 - DITW15.00.00.36 DDR 27/11/2009
        //             // if PurchOrderLine."Is Item Charge" and
        //             //   (PurchOrderLine.Type <> PurchOrderLine.Type::Item)
        //             // then
        //             //     PurchOrderLine.AutoSuggestItemChargeAssgnt(PurchOrderLine.GetItemChargeAssgntType());
        //             // >>DITW15.00.00.36 DDR
        //             //BC Upgrade SHARMP16 End<< ---- Drink-IT code
        //             //HEI.01>>
        //             OnBeforeModifyBlanketOrderLine(PurchBlanketOrderLine);
        //             //HEI.01<<
        //             if PurchBlanketOrderLine."Qty. to Return" <> 0 then begin
        //                 PurchBlanketOrderLine.VALIDATE("Qty. to Return", 0);
        //                 PurchBlanketOrderLine.MODIFY;
        //             end;
        //         end;
        //     until PurchBlanketOrderLine.NEXT = 0;

        //BC Upgrade SHARMP-16 end<<---- Interface code


        //BC Upgrade SHARMP16 Begin>> ---- Drink-IT code
        // <<DITW16.00.00.42 DDR 01/03/2013 DIT-715 #572
        // if (PurchOrderHeader."Tax Date" <> "Tax Date") or (PurchOrderHeader."Order Date" <> "Order Date") then begin
        //     CLEAR(PurchOrderLine);
        //     PurchOrderLine.SETRANGE("Document Type", PurchOrderHeader."Document Type");
        //     PurchOrderLine.SETRANGE("Document No.", PurchOrderHeader."No.");
        //     PurchOrderLine.SETRANGE(Type, PurchOrderLine.Type::Item);
        //     PurchOrderLine.SETRANGE("Is Item Charge", false);
        //     if PurchOrderLine.findset(true) then
        //         repeat
        //             if PurchOrderHeader."Order Date" <> "Order Date" then begin
        //                 if PurchOrderLine.InsertCharges4(0, false) then
        //                     PurchOrderLine.MODIFY(true);
        //             end else
        //                 if PurchOrderHeader."Tax Date" <> "Tax Date" then begin
        //                     if TransferTaxCharges.PurchCheckIfAny(PurchOrderHeader, PurchOrderLine, false, 0) then begin
        //                         TransferTaxCharges.SuspendStatusCheck(true);
        //                         TransferTaxCharges.TempInsertPurch(PurchOrderLine, TempPurchChargeLine);
        //                         if TransferTaxCharges.MakeUpdate then begin
        //                             TempPurchChargeLine.FINDLAST;
        //                             NextLineNo := TempPurchChargeLine."Line No." + 1;
        //                             GetOldChargeLines(PurchOrderLine, TempPurchChargeLine, NextLineNo);
        //                             CLEAR(CommonItemChrgMgt);
        //                             CommonItemChrgMgt.InsertChrgPurchLines(
        //                               PurchOrderHeader, PurchOrderLine,
        //                               TempPurchChargeLine, TempItemChrgAssgnPurch, true, true, false);
        //                             if TransferTaxCharges.CalcDirectUnitPurchLine2(
        //                               TempPurchChargeLine, PurchOrderHeader, PurchOrderLine, 0, true, 0)
        //                             then
        //                                 PurchOrderLine.UpdateAmounts();
        //                             PurchOrderLine.MODIFY(true);
        //                             if PurchOrderLine."Is Item Charge" and
        //                               (PurchOrderLine.Type <> PurchOrderLine.Type::Item)
        //                             then
        //                                 PurchOrderLine.AutoSuggestItemChargeAssgnt(PurchOrderLine.GetItemChargeAssgntType());
        //                         end;
        //                     end;
        //                 end;
        //         until PurchOrderLine.NEXT = 0;
        // end;
        // >>DITW16.00.00.42 DDR DIT-715 #572
        //BC Upgrade SHARMP16 ENd<< ---- Drink-IT code
        if PurchSetup."Default Posting Date" = PurchSetup."Default Posting Date"::"No Date" then begin
            PurchOrderHeader."Posting Date" := 0D;
            PurchOrderHeader.MODIFY();
        end;

        CopyCommentsFromBlanketToOrder(Rec);

        if not ShouldRedistributeInvoiceAmount then
            PurchCalcDiscByType.ResetRecalculateInvoiceDisc(PurchOrderHeader);

        //HEI.01>>
        OnAfterMakeOrder(PurchOrderHeader);
        //HEI.01<<

        COMMIT();

        //HEI.01>>
        if PurchSetup."Auto Release Purch. Order FND" then;
        //HEI.01<<

        // <<DITW15.00.00.28 DDR 28/11/2008
        //lcduReleasePurchDoc.RUN(PurchOrderHeader);//BC Upgrade SHARMP16-- Drink-IT codes
        // >>DITW15.00.00.28 DDR

    end;

    var
        PurchCommentLine: Record "Purch. Comment Line";
        PurchCommentLine2: Record "Purch. Comment Line";
        PurchOrderHeader: Record "Purchase Header";
        PurchBlanketOrderLine: Record "Purchase Line";
        PurchLine: Record "Purchase Line";
        PurchOrderLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
        QuantityOnOrders: Decimal;
        QuantityCheckErr: TextConst Comment = '%1: FIELDCAPTION("Qty. to Receive (Base)"); %2: Field(Type); %3: Field(No.); %4: FIELDCAPTION("Line No."); %5: Field(Line No.); %6: Decimal Qty Difference; %7: Text001; %8: Field(Outstanding Qty. (Base)); %9: Decimal Quantity On Orders', ENU = '%1 = %2 of %3 %4 in %5 %6 cannot be more than %7 = %8.', ESP = '%1 = %2 of %3 %4 en %5 %6 no puede ser superior a %7 = %8.', FRA = '%1 = %2 of %3 %4 dans %5 %6 ne peut pas être supérieur à %7 = %8.';
        Text001: TextConst ENU = '%1 - Unposted %1 = Possible %2', ESP = '%1 - No registrado %1 = Posible %2', FRA = '%1 - %1 non validé = %2 possible';
        Text002: TextConst ENU = 'There is nothing to create.', ESP = 'No hay nada que crear.', FRA = 'Il n''y a rien à créer.';
    //BC Upgrade SHARMP16 begin>>--- code commented used in Interface related code
    // local procedure ResetQuantityFields(var TempPurchLine: Record "Purchase Line");
    // begin
    //     TempPurchLine.Quantity := 0;
    //     TempPurchLine."Quantity (Base)" := 0;
    //     TempPurchLine."Qty. Rcd. Not Invoiced" := 0;
    //     TempPurchLine."Quantity Received" := 0;
    //     TempPurchLine."Quantity Invoiced" := 0;
    //     TempPurchLine."Qty. Rcd. Not Invoiced (Base)" := 0;
    //     TempPurchLine."Qty. Received (Base)" := 0;
    //     TempPurchLine."Qty. Invoiced (Base)" := 0;
    //     //HEI.03>>
    //     TempPurchLine."Qty. to Receive" := 0;
    //     TempPurchLine."Qty. to Receive (Base)" := 0;
    //     TempPurchLine."Qty. to Return" := 0;
    //     TempPurchLine."Qty. to Return (Base)" := 0;
    //     //HEI.03<<
    // end;
    //BC Upgrade SHARMP16 end<<--- code commented used in Interface related code
    procedure GetPurchOrderHeader(var PurchHeader: Record "Purchase Header");
    begin
        PurchHeader := PurchOrderHeader;
    end;
    //BC Upgrade SHARMP16 begin>>--- code commented used in Interface related code
    // local procedure IsPurchOrderLineToBeInserted(PurchOrderLine: Record "Purchase Line"): Boolean;
    // var
    //     AttachedToPurchaseLine: Record "Purchase Line";
    // begin
    //     if PurchOrderLine."Attached to Line No." = 0 then
    //         exit(true);
    //     exit(
    //       AttachedToPurchaseLine.GET(
    //         PurchOrderLine."Document Type", PurchOrderLine."Document No.", PurchOrderLine."Attached to Line No."));
    // end;
    //BC Upgrade SHARMP16 end<<--- code commented used in Interface related code
    local procedure CopyCommentsFromBlanketToOrder(BlanketOrderPurchaseHeader: Record "Purchase Header");
    var
        RecordLinkManagement: Codeunit "Record Link Management";
    begin
        if PurchSetup."Copy Comments Blanket to Order" then begin
            PurchCommentLine.SETRANGE("Document Type", PurchCommentLine."Document Type"::"Blanket Order");
            PurchCommentLine.SETRANGE("No.", BlanketOrderPurchaseHeader."No.");
            if PurchCommentLine.findset() then
                repeat
                    PurchCommentLine2 := PurchCommentLine;
                    PurchCommentLine2."Document Type" := PurchOrderHeader."Document Type";
                    PurchCommentLine2."No." := PurchOrderHeader."No.";
                    PurchCommentLine2.INSERT();
                until PurchCommentLine.NEXT() = 0;
            RecordLinkManagement.CopyLinks(BlanketOrderPurchaseHeader, PurchOrderHeader);
        end;
    end;

    local procedure GetOldChargeLines(OldPurchOrderLine: Record "Purchase Line"; var OldTempPurchLine: Record "Purchase Line"; var NextLineNo: Integer);
    begin
        //BC Upgrade SHARMP16 Begin>>--- Drink-IT code
        // <<DITW16.00.00.42 DDR 01/03/2013 DIT-715 #572
        // with OldPurchOrderLine do begin
        //     RESET;
        //     SETRANGE("Document Type", "Document Type");
        //     SETRANGE("Document No.", "Document No.");
        //     SETRANGE("Is Item Charge", true);
        //     SETRANGE("Attached to Line No.", "Line No.");
        //     if FINDSET then begin
        //         repeat
        //             if (Type = Type::Item) and ("Attached to Line No." <> 0) then
        //                 GetOldChargeLines(OldPurchOrderLine, OldTempPurchLine, NextLineNo)
        //             else begin
        //                 NextLineNo += 1;
        //                 OldTempPurchLine := OldPurchOrderLine;
        //                 OldTempPurchLine."Line No." := NextLineNo;
        //                 OldTempPurchLine.INSERT;
        //             end;
        //         until NEXT = 0;
        //     end;
        // end;
        //BC Upgrade SHARMP16 End<<--- Drink-IT code

    end;

    procedure QtyToReturnIsZero(BlanketOrderPurchaseHeader: Record "Purchase Header"): Boolean;
    var
        BlanketOrderPurchaseLine: Record "Purchase Line";
    begin
        BlanketOrderPurchaseLine.RESET();
        BlanketOrderPurchaseLine.SETRANGE("Document Type", BlanketOrderPurchaseHeader."Document Type");
        BlanketOrderPurchaseLine.SETRANGE("Document No.", BlanketOrderPurchaseHeader."No.");
        BlanketOrderPurchaseLine.SETFILTER("Qty. to Return FND", '<>0');
        exit(BlanketOrderPurchaseLine.ISEMPTY);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeMakeOrder(var PurchBlanketOrder: Record "Purchase Header");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterMakeOrderHeader(PurchBlanketOrder: Record "Purchase Header"; var PurchOrder: Record "Purchase Header");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateDirectUnitCost(var PurchBlanketOrderLine: Record "Purchase Line"; var PurchOrderLine: Record "Purchase Line");
    begin
    end;
    //BC Upgrade SHARMP16 -- code commented used in Interface related code.
    // [IntegrationEvent(false, false)]
    // local procedure OnBeforeModifyBlanketOrderLine(var PurchBlanketOrderLine: Record "Purchase Line");
    // begin
    // end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterMakeOrder(var PurchOrderHeader: Record "Purchase Header");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInitPurchLine(var PurchBlanketOrderLine: Record "Purchase Line"; var PurchOrderLine: Record "Purchase Line");
    begin
    end;
    // BC Upgrade BHARDA11 >>
    [IntegrationEvent(false, false)]
    procedure InitPurchaseReturnLines(PurchaseOrderHeader: Record "Purchase Header"; PurchReturnOrder1: Record "Purchase Header")
    begin
    end;
    // BC Upgrade BHARAD11 <<
}

