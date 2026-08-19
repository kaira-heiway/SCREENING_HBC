codeunit 58015 InterfacePurchCode
{
    //BC Upgrade SHARMP16 begin>> ------New CU for Interface related code.
    //HEI.01 BC Upgrade SHARMP16 Interface related Code from Codeunit BlanketPurchOrdertoReturn merge into this Custom CU and used in Purchases-Utils Interface
    //HEI.04,HEI.47 BC Upgrade SHARMP16 PurchPostCode 
    TableNo = "Purchase Header";
    trigger OnRun()
    begin

    end;
    // BC Upgrade BHARDA11 >> --17June2026
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Purch. Order to Return", InitPurchaseReturnLines, '', false, false)]
    local procedure InitPurchaseReturnLines(PurchaseOrderHeader: Record "Purchase Header"; PurchReturnOrder1: Record "Purchase Header")
    begin
        BlanketPurchOrdertoReturnOnRun(PurchaseOrderHeader, PurchReturnOrder1);
    end;

    [EventSubscriber(ObjectType::Codeunit, 58015, 'OnAfterInitPurchLine', '', false, false)]
    local procedure C50045OnAfterInitPurchLine(var PurchBlanketOrderLine: Record "Purchase Line"; var PurchOrderLine: Record "Purchase Line");
    begin
        //HEI.24>>
        if PurchBlanketOrderLine."Document Type" <> PurchBlanketOrderLine."Document Type"::"Blanket Order" then
            exit;

        if PurchBlanketOrderLine."SRM Contract No. FND" = '' then
            exit;

        PurchBlanketOrderLine.TESTFIELD("Consumption Location Code FND");
        PurchOrderLine."Location Code" := PurchBlanketOrderLine."Consumption Location Code FND";
        PurchOrderLine."Initial Quantity FND" := PurchBlanketOrderLine."Qty. to Receive";
        //HEI.24<<
    end;
    // BC Upgrade BHARDA11 << --17June2026

    //--------------------------------------HEI.01 begin>>--------------------------------------------
    procedure BlanketPurchOrdertoReturnOnRun(var rec: Record "Purchase Header"; PurchOrderHeader: Record "Purchase Header")
    begin
        PurchBlanketOrderLine.RESET();
        PurchBlanketOrderLine.SETRANGE("Document Type", rec."Document Type");
        PurchBlanketOrderLine.SETRANGE("Document No.", rec."No.");

        //BC Upgrade SHARMP16 BEGIN>> --- Drink-IT code
        // <<DITW16.00.00.42 DDR 01/03/2013 DIT-715 #572
        // if PurchOrderHeader."Tax Date" <> "Tax Date" then
        //     PurchBlanketOrderLine.SETFILTER("Item Charge Type", '<>%1', PurchBlanketOrderLine."Item Charge Type"::Tax);
        // if PurchOrderHeader."Order Date" <> "Order Date" then
        //     PurchBlanketOrderLine.SETRANGE("Is Item Charge", false);
        // >>DITW16.00.00.42 DDR DIT-715 #572
        //BC Upgrade SHARMP16 END<< --- Drink-IT code
        if PurchBlanketOrderLine.findset() then
            repeat
                if (PurchBlanketOrderLine.Type = PurchBlanketOrderLine.Type::" ") or
                   (PurchBlanketOrderLine."Qty. to Return FND" <> 0)
                then begin
                    PurchLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
                    PurchLine.SETRANGE("Blanket Order No.", PurchBlanketOrderLine."Document No.");
                    PurchLine.SETRANGE("Blanket Order Line No.", PurchBlanketOrderLine."Line No.");
                    QuantityOnOrders := 0;
                    if PurchLine.findset() then
                        repeat
                            if (PurchLine."Document Type" = PurchLine."Document Type"::"Return Order") or
                               ((PurchLine."Document Type" = PurchLine."Document Type"::"Credit Memo") and
                                (PurchLine."Return Shipment No." = ''))
                            then
                                QuantityOnOrders := QuantityOnOrders - PurchLine."Outstanding Qty. (Base)"
                            else
                                if (PurchLine."Document Type" = PurchLine."Document Type"::Order) or
                                   ((PurchLine."Document Type" = PurchLine."Document Type"::Invoice) and
                                    (PurchLine."Receipt No." = ''))
                                then
                                    QuantityOnOrders := QuantityOnOrders + PurchLine."Outstanding Qty. (Base)";
                        until PurchLine.NEXT() = 0;
                    if (ABS(PurchBlanketOrderLine."Qty. to Return (Base) FND") > ABS(PurchBlanketOrderLine."Qty. Received (Base)")) or
                       (PurchBlanketOrderLine."Quantity (Base)" * PurchBlanketOrderLine."Outstanding Qty. (Base)" < 0)
                    then
                        ERROR(
                          QuantityCheckErr,
                          PurchBlanketOrderLine.FIELDCAPTION("Qty. to Return (Base) FND"),
                          PurchBlanketOrderLine."Qty. to Return (Base) FND",
                          PurchBlanketOrderLine.Type, PurchBlanketOrderLine."No.",
                          PurchBlanketOrderLine.FIELDCAPTION("Line No."), PurchBlanketOrderLine."Line No.",
                          PurchBlanketOrderLine.FIELDCAPTION("Qty. Received (Base)"),
                          PurchBlanketOrderLine."Qty. Received (Base)");

                    PurchOrderLine := PurchBlanketOrderLine;
                    //HEI.01>>
                    OnAfterInitPurchLine(PurchBlanketOrderLine, PurchOrderLine);
                    //HEI.01<<
                    ResetQuantityFields(PurchOrderLine);
                    PurchOrderLine."Document Type" := PurchOrderHeader."Document Type";
                    PurchOrderLine."Document No." := PurchOrderHeader."No.";
                    PurchOrderLine."Blanket Order No." := rec."No.";
                    PurchOrderLine."Blanket Order Line No." := PurchBlanketOrderLine."Line No.";

                    if (PurchOrderLine."No." <> '') and (PurchOrderLine.Type.AsInteger() <> 0) then begin
                        PurchOrderLine.Amount := 0;
                        PurchOrderLine."Amount Including VAT" := 0;
                        PurchOrderLine.VALIDATE(Quantity, PurchBlanketOrderLine."Qty. to Return FND");
                        //HEI.01>>
                        /*old code:
                        IF PurchBlanketOrderLine."Expected Receipt Date" <> 0D THEN
                          PurchOrderLine.VALIDATE("Expected Receipt Date",PurchBlanketOrderLine."Expected Receipt Date")
                        ELSE
                          PurchOrderLine.VALIDATE("Order Date",PurchOrderHeader."Order Date");
                        PurchOrderLine.VALIDATE("Direct Unit Cost",PurchBlanketOrderLine."Direct Unit Cost");
                        // <<DITW15.00.00.28 DDR 28/11/2008
                        PurchOrderLine."Item Charge Value" := PurchBlanketOrderLine."Item Charge Value";
                        // >>DITW15.00.00.28 DDR
                        */
                        PurchOrderLine.VALIDATE("Order Date", PurchOrderHeader."Order Date");
                        // PurchOrderLine.VALIDATE("Document Date", PurchOrderHeader."Document Date");//BC Upgrade SHARMP16-- Drink-IT field
                        if SRMInterfaceManagement.IsSRMPurchaseBlanketOrderLine(PurchBlanketOrderLine) then//BC Upgrade SHARMP16-- Interface Code
                            SRMInterfaceManagement.GetBlanketOrderPurchPrice(PurchBlanketOrderLine, PurchOrderLine, true);//BC Upgrade SHARMP16-- Interface Code
                        //else begin//BC Upgrade SHARMP16-- Interface Code
                        PurchOrderLine.VALIDATE("Direct Unit Cost", PurchBlanketOrderLine."Direct Unit Cost");
                        // <<DITW15.00.00.28 DDR 28/11/2008
                        //  PurchOrderLine."Item Charge Value" := PurchBlanketOrderLine."Item Charge Value";//BC Upgrade SHARMP16 Begin>> ---- Drink-IT code
                        // >>DITW15.00.00.28 DDR
                        //end;//BC Upgrade SHARMP16-- Interface Code
                        //HEI.01<<
                        PurchOrderLine.VALIDATE("Line Discount %", PurchBlanketOrderLine."Line Discount %");
                        if PurchOrderLine.Quantity <> 0 then
                            PurchOrderLine.VALIDATE("Inv. Discount Amount", PurchBlanketOrderLine."Inv. Discount Amount");
                        PurchBlanketOrderLine.CALCFIELDS("Reserved Qty. (Base)");
                        if PurchBlanketOrderLine."Reserved Qty. (Base)" <> 0 then
                            ReservePurchLine.TransferPurchLineToPurchLine(
                              PurchBlanketOrderLine, PurchOrderLine, -PurchBlanketOrderLine."Qty. to Return (Base) FND");
                    end;

                    if Vend."Prepayment %" <> 0 then
                        PurchOrderLine."Prepayment %" := Vend."Prepayment %";
                    PrepmtMgt.SetPurchPrepaymentPct(PurchOrderLine, PurchOrderHeader."Posting Date");
                    PurchOrderLine.VALIDATE("Prepayment %");

                    PurchOrderLine."Shortcut Dimension 1 Code" := PurchBlanketOrderLine."Shortcut Dimension 1 Code";
                    PurchOrderLine."Shortcut Dimension 2 Code" := PurchBlanketOrderLine."Shortcut Dimension 2 Code";
                    PurchOrderLine."Dimension Set ID" := PurchBlanketOrderLine."Dimension Set ID";
                    //<<DITW17.00.02 TEC1 10/09/2013 DIT-770 #144
                    // PurchOrderLine."App. Prod. Posting Group" := PurchBlanketOrderLine."App. Prod. Posting Group";//BC Upgrade SHARMP16 ---- Drink-IT code
                    //>>DITW17.00.02 TEC1 DIT-770 #144
                    //<< DITW17.00.05 YHE 06/11/2014 DIT-770 #961
                    // PurchOrderLine."Approved Dimension set ID" := PurchBlanketOrderLine."Approved Dimension set ID";//BC Upgrade SHARMP16 ---- Drink-IT code
                    //>>DITW17.00.05 YHE 06/11/2014 DIT-770 #961
                    PurchOrderLine.DefaultDeferralCode();
                    if IsPurchOrderLineToBeInserted(PurchOrderLine) then
                        PurchOrderLine.INSERT();
                    //BC Upgrade SHARMP16 Begin>> ---- Drink-IT code
                    // <<DITW15.00.00.23 DDR 08/08/2008 - DITW15.00.00.28 DDR 28/11/2008 - DITW15.00.00.36 DDR 27/11/2009
                    // if PurchOrderLine."Is Item Charge" and
                    //   (PurchOrderLine.Type <> PurchOrderLine.Type::Item)
                    // then
                    //     PurchOrderLine.AutoSuggestItemChargeAssgnt(PurchOrderLine.GetItemChargeAssgntType());
                    // >>DITW15.00.00.36 DDR
                    //BC Upgrade SHARMP16 End<< ---- Drink-IT code
                    //HEI.01>>
                    OnBeforeModifyBlanketOrderLine(PurchBlanketOrderLine);
                    //HEI.01<<
                    if PurchBlanketOrderLine."Qty. to Return FND" <> 0 then begin
                        PurchBlanketOrderLine.VALIDATE("Qty. to Return FND", 0);
                        PurchBlanketOrderLine.MODIFY();
                    end;
                end;
            until PurchBlanketOrderLine.NEXT() = 0;
    end;

    var
        PurchOrderHeader: Record "Purchase Header";
        PurchBlanketOrderLine: Record "Purchase Line";
        PurchOrderLine: Record "Purchase Line";
        PurchLine: Record "Purchase Line";
        QuantityOnOrders: Decimal;
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
        Vend: Record Vendor;
        QuantityCheckErr: TextConst Comment = '%1: FIELDCAPTION("Qty. to Receive (Base)"); %2: Field(Type); %3: Field(No.); %4: FIELDCAPTION("Line No."); %5: Field(Line No.); %6: Decimal Qty Difference; %7: Text001; %8: Field(Outstanding Qty. (Base)); %9: Decimal Quantity On Orders', ENU = '%1 = %2 of %3 %4 in %5 %6 cannot be more than %7 = %8.', ESP = '%1 = %2 of %3 %4 en %5 %6 no puede ser superior a %7 = %8.', FRA = '%1 = %2 of %3 %4 dans %5 %6 ne peut pas être supérieur à %7 = %8.';
        PrepmtMgt: Codeunit "Prepayment Mgt.";
        SRMInterfaceManagement: Codeunit "SRM Interface Management";

    local procedure ResetQuantityFields(var TempPurchLine: Record "Purchase Line");
    begin
        TempPurchLine.Quantity := 0;
        TempPurchLine."Quantity (Base)" := 0;
        TempPurchLine."Qty. Rcd. Not Invoiced" := 0;
        TempPurchLine."Quantity Received" := 0;
        TempPurchLine."Quantity Invoiced" := 0;
        TempPurchLine."Qty. Rcd. Not Invoiced (Base)" := 0;
        TempPurchLine."Qty. Received (Base)" := 0;
        TempPurchLine."Qty. Invoiced (Base)" := 0;
        //HEI.03>>
        TempPurchLine."Qty. to Receive" := 0;
        TempPurchLine."Qty. to Receive (Base)" := 0;
        TempPurchLine."Qty. to Return FND" := 0;
        TempPurchLine."Qty. to Return (Base) FND" := 0;
        //HEI.03<<
    end;

    local procedure IsPurchOrderLineToBeInserted(PurchOrderLine: Record "Purchase Line"): Boolean;
    var
        AttachedToPurchaseLine: Record "Purchase Line";
    begin
        if PurchOrderLine."Attached to Line No." = 0 then
            exit(true);
        exit(
          AttachedToPurchaseLine.GET(
            PurchOrderLine."Document Type", PurchOrderLine."Document No.", PurchOrderLine."Attached to Line No."));
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInitPurchLine(var PurchBlanketOrderLine: Record "Purchase Line"; var PurchOrderLine: Record "Purchase Line");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeModifyBlanketOrderLine(var PurchBlanketOrderLine: Record "Purchase Line");
    begin
    end;
    //--------------------------------------HEI.01 end<<--------------------------------------------

    // HEI.01 HLSRM03 IBM LAZARE02 02.08.2017
    // # New event publishers: OnBeforeMakeOrder, OnAfterMakeOrderHeader, OnAfterValidateDirectUnitCost, OnBeforeModifyBlanketOrderLine,
    //                       OnAfterMakeOrder, OnAfterInitPurchLine
    // # Use workdate as Posting Date, Document Date, Expected Receipt Date
    // HEI.02 FDD Ethiopia prepayment IBM POSTOI01 04.07.2019 
    // # modify OnRun to update the Document Subtype for Purchase Orders created from Blanket Purch. Order
    // # there are also updated the header fields: "Prepayment %", "Prepmt. Payment Terms Code", "Compress Prepayment","Prepmt. Payment Discount %"

    // HEI.03 FDD-HT1075 CHG2039144 IBM.GUNERE01 15.01.2020 # OnRun func. modified 

    // HEI.04 FDD-HB1076 CHG2046174 IBM SHANKJ03 20.03.2020
    // HEI.05 CHG2317685 SAHAL01 17.10.2025 Block Functionality Enhancement for Vendors
    //   # Added Code

    // BC Upgrade SHUKLP03 >>
    // HEI.01 => Codeunit "Blanket Purch. Order to Order" event OnBeforeUpdatePurchOrderLineDirectUnitCost is subscribed in this codeunit.
    // HEI.01 => some part of code is blocked because it is DrinkIT code.
    // Added interface code of codeunit "Purchase-Utils".
    // BC Upgrade SHUKLP03 <<

    // BC UPGRADE PATELS08 >>
    // # Added Tag HEI.05 and relvant code.
    // BC UPGRADE PATELS08 <<

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Purch. Order to Order", OnBeforeUpdatePurchOrderLineDirectUnitCost, '', false, false)]
    local procedure OnBeforeUpdatePurchOrderLineDirectUnitCost_97(PurchBlanketOrderLine: Record "Purchase Line"; PurchOrderHeader: Record "Purchase Header"; var PurchOrderLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        SRMInterfaceManagement: Codeunit "SRM Interface Management";
    begin
        //HEI.01>>
        //PurchOrderLine.VALIDATE("Document Date",PurchOrderHeader."Document Date"); // BC Upgrade Priya >> Code blocked because DrinkIT "Document Date" field is used.
        IF SRMInterfaceManagement.IsSRMPurchaseBlanketOrderLine(PurchBlanketOrderLine) THEN
            SRMInterfaceManagement.GetBlanketOrderPurchPrice(PurchBlanketOrderLine, PurchOrderLine, TRUE)
        ELSE BEGIN
            PurchOrderLine.VALIDATE("Direct Unit Cost", PurchBlanketOrderLine."Direct Unit Cost");
            // <<DITW15.00.00.28 DDR 28/11/2008
            // PurchOrderLine."Item Charge Value" := PurchBlanketOrderLine."Item Charge Value"; // BC Upgrade Priya >> Code blocked because DrinkIT "Item Charge Value" field is used.
            // >>DITW15.00.00.28 DDR
        END;
        //HEI.01<<
        IsHandled := true;
    end;

    // BC UPGRADE PATELS08 >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Purch. Order to Order", OnCreatePurchHeaderOnBeforePurchOrderHeaderInitRecord, '', false, false)]
    local procedure OnCreatePurchHeaderOnBeforePurchOrderHeaderInitRecord(var PurchOrderHeader: Record "Purchase Header"; var PurchHeader: Record "Purchase Header")
    var
        PurchasesUtilsL: Codeunit "Purchases-Utils";
        Vend: Record Vendor;
    begin
        Vend.GET(PurchHeader."Buy-from Vendor No.");
        //HEI.05>>
        PurchasesUtilsL.CheckBlockedVendorOnDocuments(Vend, PurchOrderHeader);
        //HEI.05<<
    end;
    // BC UPGRADE PATELS08 <<


    //Priya SRM Code >>
    // BC Upgrade SHUKLP03 << codeunit 91 "Purch.-Post (Yes/No)"
    // HEI.03 CHG2148350 FDD-HB2777 IBM NANDIS01 28.02.2023 # develop confirmation check interface for HL
    // # New function created - PreviewSRMInterface; similar to Preview function to get it called for SRM GR Validation interface only

    var

        PostingPreviewEventHandler: Codeunit "Posting Preview Event Handler";
        NothingToPostMsg: TextConst ENU = 'There is nothing to post.', FRA = 'Il ny a rien à valider.';
        PreviewModeErr: TextConst ENU = 'Preview mode.', FRA = 'Mode Aperçu.';
        SubscriberTypeErr: TextConst ENU = 'Invalid Subscriber type. The type must be CODEUNIT.', FRA = 'Type abonné non valide. Le type doit être CODEUNIT.';
        RecVarTypeErr: TextConst ENU = 'Invalid RecVar type. The type must be RECORD.', FRA = 'Type RecVar non valide. Le type doit être RECORD.';
        PreviewExitStateErr: TextConst ENU = 'The posting preview has stopped because of a state that is not valid.', FRA = 'Laperçu de la validation a cessé en raison dun état non valide.';

    procedure PreviewSRMInterface(VAR PurchaseHeader: Record "Purchase Header")
    var
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
    begin
        //HEI.03>>
        BINDSUBSCRIPTION(PurchPostYesNo);
        // PreviewSRMInterface(PurchPostYesNo, PurchaseHeader);
        PreviewSRMInterface2(PurchaseHeader); // BC Upgrade BHARDA11 --24April26
        //HEI.03<<
    end;

    // BC Upgrade SHUKLP03 << codeunit 91 "Purch.-Post (Yes/No)"


    // BC Upgrade SHUKLP03 >> codeunit 19 "Gen. Jnl.-Post Preview"

    //     HEI.01 CHG2148350 FDD-HB2777 IBM NANDIS01 28.02.2023 # develop confirmation check interface for HL
    //   # New function created - PreviewSRMInterface; similar to Preview function to get it called for SRM GR Validation interface only

    // BC Upgrade SHUKLP03 >>
    // codeunit 19 "Gen. Jnl.-Post Preview" procedure PreviewSRMInterface added.
    // Added procedure RunPreview() in general codeunit.
    // BC Upgrade SHUKLP03 <<
    //BC Upgrade SHARMP16--Interface BEGIN>> // BC Upgrade BHARDA11 
    procedure PreviewSRMInterface2(var PurchaseHeader: Record "Purchase Header")
    var
        PurchPostPreview: Codeunit "Purch.-Post (Yes/No)";
        PurchPost: Codeunit "Purch.-Post";
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
        // PurchHeaderToPost: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        DummyCrMemoNoL: Label 'CHG2210794_CrMemo';
    begin
        // PurchHeaderToPost.Get(PurchaseHeader."Document Type", PurchaseHeader."No.");
        PurchLine.Reset();
        PurchLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchLine.SetRange(Type, PurchLine.Type::"Fixed Asset");
        if PurchLine.FindSet() then
            exit;
        // PurchaseHeader.Invoice := true;
        // PurchaseHeader.Receive := true; //
        // if PurchaseHeader."Vendor Invoice No." = '' then
        //     PurchaseHeader."Vendor Invoice No." := PurchaseHeader."No.";  // or any placeholder
        // if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Return Order" then begin
        //     PurchaseHeader.Invoice := true;
        //     PurchaseHeader."Vendor Cr. Memo No." := DummyCrMemoNoL;
        // end;
        PurchPreview(PurchaseHeader);


        // BindSubscription(PurchPostPreview);
        // BindSubscription(CUTest);
        // //BindSubscription(PurchPostPreview);
        // PurchPostPreview.Preview(PurchaseHeader);
        // //  GenJnlPostPreview.Preview(PurchPostPreview, PurchaseHeader);
        // CUTest.Run();
        // UnbindSubscription(CUTest);
        // PurchPostPreview.Preview(PurchaseHeader);
        //  UnbindSubscription(PurchPost);
    end;

    procedure PurchPreview(var PurchaseHeader: Record "Purchase Header")
    var
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
        LastErrorText: Text;
        POPage: page 50;
        ShowallEntriesManual: Codeunit "GR Validation Hide Entries"; //Bc Upgrade BHARDA11 
        PurchHeaderToPost: Record "Purchase Header";
        DummyCrMemoNoL: Label 'CHG2210794_CrMemo';
    begin
        // Only for GR Validation for SRM
        PurchHeaderToPost.Get(PurchaseHeader."Document Type", PurchaseHeader."No.");
        PurchLine.Reset();
        PurchLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchLine.SetRange(Type, PurchLine.Type::"Fixed Asset");
        if PurchLine.FindSet() then
            exit;
        // BC Upgrade BHARDA11 >>
        PurchHeaderToPost.Invoice := false;
        PurchHeaderToPost.Receive := true; //
        if PurchHeaderToPost."Vendor Invoice No." = '' then
            PurchHeaderToPost."Vendor Invoice No." := PurchHeaderToPost."No.";  // or any placeholder
        if PurchHeaderToPost."Document Type" = PurchHeaderToPost."Document Type"::"Return Order" then begin
            PurchHeaderToPost.Receive := false;
            PurchHeaderToPost.Ship := true;
            PurchHeaderToPost.Invoice := true;
            PurchHeaderToPost."Vendor Cr. Memo No." := DummyCrMemoNoL;
        end;
        // BC Upgrade BHARDA11 << 
        BindSubscription(ShowallEntriesManual);
        PurchPostYesNo.Preview(PurchHeaderToPost);
        ShowallEntriesManual.Run();
        UnbindSubscription(ShowallEntriesManual);
        // BindSubscription(PurchPostYesNo);
        // GenJnlPostPreview.SetContext(PurchPostYesNo, PurchaseHeader);
        // // if not GenJnlPostPreview.Run() then begin
        // GenJnlPostPreview.Run();
        // TryRunPreview(GenJnlPostPreview);
        LastErrorText := GetLastErrorText;
        // if GetLastErrorText <> '' then
        //     Error(LastErrorText);
        //GenJnlPostPreview.Preview(PurchPostYesNo, PurchaseHeader);

        // end;
        // Error('TestFinal%1..%2', GetLastErrorText, LastErrorText);
    end;


    //BC Upgrade SHARMP16--Interface END<< // BC Upgrade BHARDA11 --24April26
    //BC Upgrade SHARMP16--Zycus-D BEGIN>>
    [TryFunction]
    procedure PreviewSRMInterface1(var PurchaseHeader: Record "Purchase Header")
    var
        PurchPostPreview: Codeunit "Purch.-Post (Yes/No)";
        PurchPost: Codeunit "Purch.-Post";
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
        PurchHeaderToPost: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        DummyInvNoL: Label 'CHG2210794_Invoice';
        DummyCrMemoNoL: Label 'CHG2210794_CrMemo';
    begin
        PurchHeaderToPost.Get(PurchaseHeader."Document Type", PurchaseHeader."No.");
        PurchLine.Reset();
        PurchLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchLine.SetRange(Type, PurchLine.Type::"Fixed Asset");
        if PurchLine.FindSet() then
            exit;
        PurchHeaderToPost.Invoice := false;
        PurchHeaderToPost.Receive := true;
        if PurchHeaderToPost."Vendor Invoice No." = '' then
            PurchHeaderToPost."Vendor Invoice No." := DummyInvNoL;
        if PurchHeaderToPost."Document Type" = PurchHeaderToPost."Document Type"::"Return Order" then begin
            PurchHeaderToPost.Invoice := true;
            PurchHeaderToPost."Vendor Cr. Memo No." := DummyCrMemoNoL;
        end;
        PurchPreview2(PurchHeaderToPost);

    end;

    procedure PurchPreview2(var PurchaseHeader: Record "Purchase Header")
    var
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
        LastErrorText: Text;
    begin
        PurchaseHeader.Invoice := false;
        BindSubscription(PurchPostYesNo);
        GenJnlPostPreview.SetContext(PurchPostYesNo, PurchaseHeader);
        if not GenJnlPostPreview.Run() then begin
            LastErrorText := GetLastErrorText;
            if GetLastErrorText <> '' then
                Error(LastErrorText);
        end;
    end;
    //BC Upgrade SHARMP16--Zycus END<<
    procedure PreviewSRMInterface(Subscriber: Variant; RecVar: Variant)
    var
        RunResult: Boolean;
        HeinekenBCUpgrade: Codeunit "Heineken BC Upgrade";
    begin
        //HEI.01>>
        IF NOT Subscriber.ISCODEUNIT THEN
            ERROR(SubscriberTypeErr);
        IF NOT RecVar.ISRECORD THEN
            ERROR(RecVarTypeErr);

        BINDSUBSCRIPTION(PostingPreviewEventHandler);

        RunResult := HeinekenBCUpgrade.RunPreview(Subscriber, RecVar);

        UNBINDSUBSCRIPTION(PostingPreviewEventHandler);

        // The OnRunPreview event expects subscriber following template: Result := <Codeunit>.RUN
        // So we assume RunPreview returns FALSE with the error.
        // To prevent return FALSE without thrown error we check error call stack.
        IF RunResult OR (GETLASTERRORCALLSTACK = '') THEN
            ERROR(PreviewExitStateErr);

        IF GETLASTERRORTEXT <> PreviewModeErr THEN
            ERROR(GETLASTERRORTEXT);
        //HEI.01<<
    end;

    // BC Upgrade SHUKLP03 << codeunit 19 "Gen. Jnl.-Post Preview"

    //BC Upgrade SHARMP16 end<< ------New CU for Interface related code.

    // BC Upgrade SHUKLP03 >> Added interface code of codeunit "Purchase-Utils".

    // BC Upgrade SHUKLP03 >> procedure IbecorComparePORequest(), event OnBeforePurchRcptLineModify,OnAfterValidateEvent,OnAfterValidateEvent,OnAfterInsertEvent and OnBeforePostPurchaseDoc added from codeunit "Purchases-Utils".

    var
        PurchSetup: Record "Purchases & Payables Setup";
    //BC Upgrade SHARMP16--Testscriptchanges140326 BEGIN<<
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document",
    'OnBeforeReleasePurchaseDoc', '', false, false)]
    local procedure CheckToleranceBeforeRelease(var PurchaseHeader: Record "Purchase Header"; var SkipCheckReleaseRestrictions: Boolean; PreviewMode: Boolean)
    var
        PurchaseLine: Record "Purchase Line";
        PurchaseUtils: Codeunit "Purchases-Utils";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        PurchasesPayableSetup: Record "Purchases & Payables Setup";
        WorkflowResp: Record "Workflow Response";
        WorkflowNotFoundError: Label 'Purchase Invoice %1 has upper tolerance restriction and "tolerance approval" is mandatory in Purchases & Payable setup but workflow is not enabled for the same.';
    begin
        // Only check Open documents


        // Skip tolerance if workflow action tells us to skip restrictions
        if ((PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order)
       or (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Return Order")) and
        not GuiAllowed then//BC Upgrade SHARMP16
            PurchaseHeader.CheckPurchaseReleaseRestrictions();

        PurchasesPayableSetup.Get();//BC Upgrade SHARMP16-- Purchprocesstesting 14 March
        if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice) and (PurchaseHeader.Status = PurchaseHeader.Status::Open) and PurchasesPayableSetup."Check Tolerance Approval FND" then begin
            PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            PurchaseLine.SETFILTER(Type, '<>%1', PurchaseLine.Type::" ");
            if PurchaseLine.FINDSET(true) then
                repeat
                    PurchaseUtils.CheckToleranceWarning(PurchaseLine);
                until PurchaseLine.NEXT() = 0;
            //----------------------------------
            PurchaseLine.RESET();
            PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            PurchaseLine.SETFILTER(Type, '<>%1', PurchaseLine.Type::" ");
            PurchaseLine.SETRANGE("Tolerance Exceeded FND", true);

            if PurchaseLine.FINDSET() then
                // Message('%1', PurchaseHeader.Status);
                // if not ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then
                if (PurchaseHeader.Status = PurchaseHeader.Status::Open) and not ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then
                    ERROR(WorkflowNotFoundError, PurchaseHeader."No.");

            ApprovalsMgmt.PrePostApprovalCheckPurch(PurchaseHeader);
        end;
        // //HEI.154<<//BC Upgrade SHARMP16--Testscriptchanges140326
        //HEI.04>>
        // Skip tolerance if workflow action tells us to skip restrictions

    end;

    [EventSubscriber(ObjectType::Page, 50, 'OnBeforeActionEvent', 'OrderCustom', false, false)]
    local procedure P50OnBeforeSendOrder(var Rec: Record "Purchase Header")
    var
        POStatusErr: Label 'Status must be Released or Pending Prepayment';

    begin

        if (Rec."Document Type" = Rec."Document Type"::Order) then
            if (Rec.Status <> Rec.Status::Released) and (Rec.Status <> Rec.Status::"Pending Prepayment") then
                ERROR(POStatusErr);

    end;//BC Upgrade SHARMP16 06072026

    //BC Upgrade SHARMP16--Testscriptchanges140326 END>>
    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure C90OnBeforePostPurchaseDoc(var PurchaseHeader: Record "Purchase Header");
    var
        PurchaseLine: Record "Purchase Line";
        SRMPOwithMaterial: Boolean;
        PurchaseAdditional: Record "Purchase Header Additional FND";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowNotFoundError: Label 'Purchase Invoice %1 have upper tolerance restriction and "tolerance approval" is mandatory in" Purchases & Payable setup" but workflow is not enabled for the same.';
        PurchaseAdditionalL: Record "Purchase Header Additional FND";
        PurchaseLineL: Record "Purchase Line";
        ZycusOrderNoL: Code[20];
        PurchaseUtils: Codeunit "Purchases-Utils";  // BC Upgrade SHUKLP03 << 
        Text021: Label 'Zycus';
        Text022: Label 'Receive is not allowed for PO %1 that is interfaced from %2.';
        ReceiveNotAllowedErr: Label 'Receive is not allowed for orders that are imported from SRM.';
    begin
        //BC Upgrade SHARMP16--Testscriptchanges140326 BEGIN<<-- shift to on before release
        //HEI.154>>
        //   PurchaseUtils.GetPurchSetup();//BC Upgrade SHARMP16-- Purchprocesstesting 
        // GetPurchSetupInt();//BC Upgrade SHARMP16-- Purchprocesstesting 
        // if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice) and PurchSetup."Check Tolerance Approval" then begin
        //     PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        //     PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        //     PurchaseLine.SETFILTER(Type, '<>%1', PurchaseLine.Type::" ");
        //     if PurchaseLine.FINDSET() then
        //         repeat
        //             PurchaseUtils.CheckToleranceWarning(PurchaseLine);
        //         until PurchaseLine.NEXT() = 0;
        //     //----------------------------------
        //     PurchaseLine.RESET();
        //     PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        //     PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        //     PurchaseLine.SETFILTER(Type, '<>%1', PurchaseLine.Type::" ");
        //     PurchaseLine.SETRANGE("Tolerance Exceeded", true);
        //     if PurchaseLine.FINDSET(true, false) then
        //         if (PurchaseHeader.Status = PurchaseHeader.Status::Open) and not ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then
        //             ERROR(WorkflowNotFoundError, PurchaseHeader."No.");

        //     ApprovalsMgmt.PrePostApprovalCheckPurch(PurchaseHeader);
        // end;
        //HEI.154<<
        //HEI.04>>
        //BC Upgrade SHARMP16--Testscriptchanges140326 END>>
        if PurchaseHeader."SRM Order No. FND" = '' then
            exit;
        //HEI.133>>
        SRMPOwithMaterial := false;
        //HEI.143>>
        if (PurchaseAdditional.GET(PurchaseHeader."Document Type", PurchaseHeader."No.")) and (PurchaseAdditional."Shopping Card No." <> '') then begin
            PurchaseLine.RESET();
            PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            //PurchaseLine.SETFILTER(Type,'%1|%2|%3',PurchaseLine.Type::"G/L Account",PurchaseLine.Type::"Fixed Asset",PurchaseLine.Type::Item); //HEI.145
            PurchaseLine.SETFILTER(Type, '%1|%2', PurchaseLine.Type::"G/L Account", PurchaseLine.Type::"Fixed Asset"); //HEI.145
            PurchaseLine.SETFILTER("Qty. to Receive", '<>%1', 0);
            if PurchaseLine.ISEMPTY then
                SRMPOwithMaterial := true;
        end else begin
            PurchaseLine.RESET();
            PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            //HEI.142>>
            PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
            //PurchaseLine.SETFILTER(Type,'%1|%2',PurchaseLine.Type::"G/L Account",PurchaseLine.Type::"Charge (Item)");
            //PurchaseLine.SETFILTER("Qty. to Receive",'<>%1',0);
            //HEI.142<<
            if not PurchaseLine.ISEMPTY then
                SRMPOwithMaterial := true;
        end;
        //HEI.143<<
        //HEI.133<<
        //HEI.158>>
        if PurchaseAdditionalL.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") then begin
            if PurchaseAdditionalL."Zycus Order No. INT" <> '' then begin
                CLEAR(SRMPOwithMaterial);
                ZycusOrderNoL := PurchaseAdditionalL."Zycus Order No. INT";
                PurchaseLine.RESET();
                PurchaseLine.SETCURRENTKEY("Document Type", "Document No.", Type, "Qty. to Receive");
                PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                PurchaseLine.SETFILTER(Type, '%1|%2', PurchaseLine.Type::"G/L Account", PurchaseLine.Type::"Fixed Asset");
                PurchaseLine.SETFILTER("Qty. to Receive", '<>0');
                if PurchaseLine.ISEMPTY then begin
                    SRMPOwithMaterial := true;
                end else begin
                    PurchaseLine.RESET();
                    PurchaseLine.SETCURRENTKEY("Document Type", "Document No.", Type);
                    PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                    PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                    PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
                    if not PurchaseLine.ISEMPTY then begin
                        PurchaseLineL.RESET();
                        PurchaseLineL.COPYFILTERS(PurchaseLine);
                        PurchaseLineL.SETFILTER(Type, '%1|%2', PurchaseLineL.Type::"G/L Account", PurchaseLineL.Type::"Fixed Asset");
                        if PurchaseLineL.ISEMPTY then
                            SRMPOwithMaterial := true;
                    end;
                end;
            end;
        end;
        //HEI.158<<
        //IF PurchaseHeader.Receive AND GUIALLOWED THEN   //HEI.133
        if PurchaseHeader.Receive and (GUIALLOWED and not SRMPOwithMaterial) then   //HEI.133//BC Upgrade SHARMP16--Zycus
                                                                                    //HEI.158>>
                                                                                    // if PurchaseHeader.Receive and not SRMPOwithMaterial then//BC Upgrade SHARMP16--Zycus
            if ZycusOrderNoL <> '' then
                ERROR(Text022, ZycusOrderNoL, Text021)
            else
                //HEI.158<<
                ERROR(ReceiveNotAllowedErr);
        //HEI.04<<
    end;

    [EventSubscriber(ObjectType::Table, 5109, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertPurchHeaderArchive(var Rec: Record "Purchase Header Archive"; RunTrigger: Boolean);
    var
        PurchaseHeaderArchiveAddit: Record "Purchase Header Arch Addit FND";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        //HEI.18>>
        if not PurchaseHeaderArchiveAddit.GET(Rec."Document Type", Rec."No.", Rec."Doc. No. Occurrence", Rec."Version No.") then begin
            PurchaseHeaderArchiveAddit.INIT();
            PurchaseHeaderArchiveAddit.VALIDATE("Document Type", Rec."Document Type");
            PurchaseHeaderArchiveAddit.VALIDATE("No.", Rec."No.");
            PurchaseHeaderArchiveAddit.VALIDATE("Doc. No. Occurrence", Rec."Doc. No. Occurrence");
            PurchaseHeaderArchiveAddit.VALIDATE("Version No.", Rec."Version No.");
            //HEI.71>>
            if PurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") then begin //HEI.74 (begin added)
                PurchaseHeaderArchiveAddit.VALIDATE("Region Code", PurchaseHeaderAdditional."Region Code");
                //HEI.71<<
                PurchaseHeaderArchiveAddit.VALIDATE("Shopping Card Creati Date INT", PurchaseHeaderAdditional."Shopping Card Creation Date");//HEI.74
                                                                                                                                             //HEI.123>>
                PurchaseHeaderArchiveAddit.VALIDATE("Limit PO", PurchaseHeaderAdditional."Limit PO");
                PurchaseHeaderArchiveAddit.VALIDATE("PFI Document No. INT", PurchaseHeaderAdditional."PFI Document No. INT");
                PurchaseHeaderArchiveAddit.VALIDATE("WMS Export INT", PurchaseHeaderAdditional."WMS Export INT");
                // PurchaseHeaderArchiveAddit.VALIDATE("Astro WMS PO", PurchaseHeaderAdditional."Astro WMS PO");
                //HEI.123>>
            end;//HEI.74
            PurchaseHeaderArchiveAddit.INSERT(true);
        end;
        //HEI.18<<
    end;
    //BC Upgrade SHARMP16 begin>>---------------- Interface code 
    [EventSubscriber(ObjectType::Table, 38, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertPurchHeader(var Rec: Record "Purchase Header"; RunTrigger: Boolean);
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        SRMInterfaceSetup: Record "SRM Interface Setup INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        ShopCardCrDateTime: Text[30];
        ShopCardCrDateOnly: Text[30];
        ShopCardCrDateinDateFormat: Date;
    begin
        //HEI.18>>
        if not PurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") then begin
            PurchaseHeaderAdditional.INIT;
            PurchaseHeaderAdditional.VALIDATE("Document Type", Rec."Document Type");
            PurchaseHeaderAdditional.VALIDATE("No.", Rec."No.");
            //>> HEI.45
            SRMInterfaceSetup.GET;
            InterfaceEntryHeader.SETRANGE("Source Subtype", Rec."Document Type");
            InterfaceEntryHeader.SETRANGE("External Order No.", Rec."No.");
            InterfaceEntryHeader.SETRANGE("Interface Code", SRMInterfaceSetup."PO Creation Interface");
            if InterfaceEntryHeader.FINDFIRST then begin //HEI.56
                PurchaseHeaderAdditional."Shopping Card No." := InterfaceEntryHeader."Severity Code";
                ShopCardCrDateTime := FORMAT(InterfaceEntryHeader."Mod/Post Date");
                ShopCardCrDateOnly := COPYSTR(ShopCardCrDateTime, 1, 8);//+COPYSTR(ShopCardCrDateTime,6,2)+COPYSTR(ShopCardCrDateTime,1,4);
                EVALUATE(ShopCardCrDateinDateFormat, ShopCardCrDateOnly);
                PurchaseHeaderAdditional."Shopping Card Creation Date" := ShopCardCrDateinDateFormat;//HEI.74
                                                                                                     //>> HEI.56
                InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                InterfaceEntryLine.SETFILTER("Direct Cost Per Mult. Limit PO", '<>%1', 0);
                if InterfaceEntryLine.FINDFIRST then
                    PurchaseHeaderAdditional."Limit PO" := true;
            end;
            //<< HEI.56
            //<< HEI.45
            PurchaseHeaderAdditional.INSERT(true);
        end;
        //HEI.18<<
    end;
    //BC Upgrade SHARMP16 end<<---------------- Interface code

    [EventSubscriber(ObjectType::Table, 50140, 'OnAfterValidateEvent', 'Maximo Status INT', false, false)]
    procedure T50140OnAfterValidateMaximoStatus(var Rec: Record "Purchase Header Additional FND"; var xRec: Record "Purchase Header Additional FND"; CurrFieldNo: Integer);
    var
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchaseHdrRec: Record "Purchase Header";
        BCUpgrade: Codeunit "Heineken BC Upgrade";
        BCCustomFunctions: Codeunit "Heineken BC Custom Functions";
    begin
        // HEI.37 >>
        if Rec."Maximo Status INT" = Rec."Maximo Status INT"::Canceled then begin
            if Rec."Document Type" = Rec."Document Type"::Quote then begin
                PurchaseHdrRec.RESET();
                PurchaseHdrRec.SETRANGE("Document Type", Rec."Document Type");
                PurchaseHdrRec.SETRANGE("No.", Rec."No.");
                if PurchaseHdrRec.FINDFIRST() then begin
                    if PurchaseHdrRec.Status = PurchaseHdrRec.Status::Released then
                        BCCustomFunctions.ArchivePurchDocumentOnReopen(PurchaseHdrRec);//BC Upgrade SHARMP16
                    ArchiveManagement.AutoArchivePurchDocument(PurchaseHdrRec);
                    PurchaseHdrRec.DELETE();
                end;
            end;
        end;
        // HEI.37 <<
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Shipment Method Code', false, false)]
    local procedure T38OnAfterInsertShippingMethodCode(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchaseLine: Record "Purchase Line";
        RequisitionLine: Record "Requisition Line";
        PurchaseUtils: Codeunit "Purchases-Utils";  // BC Upgrade SHUKLP03 <<
        Text0005: Label 'You need to re-open the document before modifying Shipment Method Code.';
    begin
        //>> HEI.59
        //PurchaseUtils.GetPurchSetup(); // BC Upgrade SHUKLP03 <<//BC Upgrade SHARMP16-- Purchprocesstesting 
        GetPurchSetupInt();//BC Upgrade SHARMP16-- Purchprocesstesting 
        PurchaseLine.RESET();
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            if Rec."Shipment Method Code" <> xRec."Shipment Method Code" then
                if Rec.Status = Rec.Status::Released then
                    ERROR(Text0005);
            if PurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") then begin
                if not PurchaseUtils.CheckShippingMethod(PurchSetup, Rec) then begin   // BC Upgrade SHUKLP03 <<
                    PurchaseHeaderAdditional."Import Identifier" := true;
                    PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
                    PurchaseLine.SETRANGE("Document No.", Rec."No.");
                    PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
                    if PurchaseLine.FINDSET() then
                        PurchaseLine.MODIFYALL("Location Code", PurchSetup."Location Code Imp Proc. FND");
                end else begin
                    PurchaseHeaderAdditional."Import Identifier" := false;
                    PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
                    PurchaseLine.SETRANGE("Document No.", Rec."No.");
                    PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
                    PurchaseLine.SETRANGE("Special Order Sales No.", ''); //HEI.138
                    if PurchaseLine.FINDSET() then
                        //HEI.160>>
                        if PurchaseHeaderAdditional."Zycus Order No. INT" = '' then
                    //HEI.160<<
                    //HEI.162>>
                    begin
                            RequisitionLine.RESET();
                            // RequisitionLine.SETCURRENTKEY("Action Message", "Blanket Order No.", "Blanket Order Line No.");//BC Upgrade SHARMp16-- Drink-IT field
                            // RequisitionLine.SETRANGE("Blanket Order No.", PurchaseLine."Blanket Order No.");//BC Upgrade SHARMp16-- Drink-IT field
                            // RequisitionLine.SETRANGE("Blanket Order Line No.", PurchaseLine."Blanket Order Line No.");//BC Upgrade SHARMp16-- Drink-IT field
                            if RequisitionLine.ISEMPTY then
                                //HEI.162<<
                                PurchaseLine.MODIFYALL("Location Code", '');
                        end; //HEI.162
                end;
                if Rec."Shipment Method Code" = '' then
                    PurchaseHeaderAdditional."Import Identifier" := false;
                PurchaseHeaderAdditional.MODIFY();
            end;
        end;
        //<< HEI.59
    end;

    //BC Upgrade SHARMP16--Zycus  Begin>>-D
    //BC Upgrade SHARMP16 begin>>---------------- Interface Code
    [EventSubscriber(ObjectType::Codeunit, 5813, OnAfterPurchRcptLineModify, '', false, false)]
    local procedure OnAfterUndoReceipt_Zycus(var PurchRcptLine: Record "Purch. Rcpt. Line");
    var

        PurchRcptHdr: Record "Purch. Rcpt. Header";
        ZycusInterfaceManagement: Codeunit "Zycus Interface Management";//BC Upgrade SHARMP16-- Interface changes
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";//BC Upgrade SHARMP16-- Interface changes
        PurchRcptLineREC: Record "Purch. Rcpt. Line";
    begin
        //HEI.159<<
        if PurchRcptLine.ISTEMPORARY then
            exit;
        //HEI.163>>
        GetZycusInterfaceSetup_Zycus;
        if not ZycusInterfaceSetupRead then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        if not ZycusInterfaceSetup."Activate POSM GR Interface" then begin
            CLEAR(ZycusInterfaceSetup);
            CLEAR(ZycusInterfaceSetupRead);
            exit;
        end;
        //HEI.163<<
        //Since Partial GR Cancellation is not allowed in Zycus, all eligible lines of Receipt document is filtered.
        //HEI.161>>
        PurchRcptLineREC.RESET;
        PurchRcptLineREC.SETRANGE("Document No.", PurchRcptLine."Document No.");
        PurchRcptLineREC.SETRANGE(Type, PurchRcptLine.Type::Item);
        PurchRcptLineREC.SETFILTER(Quantity, '>%1', 0);
        PurchRcptLineREC.SETFILTER("Zycus Order No. FND", '<>%1', '');
        if PurchRcptLineREC.findset(false) then begin
            PurchRcptHdr.GET(PurchRcptLineREC."Document No.");
            //HEI.161<<
            ZycusInterfaceManagement.CreateOutboundPOSMGRCancellation_Zycus(PurchRcptHdr, InterfaceEntryHeaderVIP);
            repeat
                if InterfaceEntryHeaderVIP."Entry No." <> 0 then
                    //HEI.161>>
                    ZycusInterfaceManagement.CreateOutboundLinesPOSMGRCancellation_Zycus(InterfaceEntryHeaderVIP, PurchRcptLineREC);
            until PurchRcptLineREC.NEXT = 0;
            //HEI.161<<
            PurchRcptHdr."POSM GR Confirmed FND" := false;
            PurchRcptHdr.MODIFY;
        end;
        //HEI.159<<
        //HEI.163>>
        CLEAR(ZycusInterfaceSetup);
        CLEAR(ZycusInterfaceSetupRead);
        //HEI.163<<
    end;
    //BC Upgrade SHARMP16 end<<---------------- Interface Code
    //BC Upgrade SHARMP16 begin>>---------------- Interface Code


    local procedure GetZycusInterfaceSetup_Zycus();
    begin
        //HEI.163>>
        if not ZycusInterfaceSetupRead then begin
            if ZycusInterfaceSetup.GET and ZycusInterfaceSetup."Enabled Zycus Integration" then
                ZycusInterfaceSetupRead := true;
        end;
        //HEI.163<<
    end;
    //BC Upgrade SHARMP16 end<<---------------- Interface Code
    //BC Upgrade SHARMP16--Zycus  END<<-D
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Undo Purchase Receipt Line", 'OnBeforePurchRcptLineModify', '', false, false)]
    local procedure OnBeforeUndoReceipt(var PurchRcptLine: Record "Purch. Rcpt. Line");
    var
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        PurchRcptHeaderAdditional: Record "Purch. Rcpt. Header Add FND";
        POSMItemLine: Label 'This is a document with item lines with SRM order, so undo receipt is not be possible';
        POSMConfirmation: Label 'This is a POSM item line. Do you want to continue?';
        POSMWarningMessage: Label 'Undo operation is terminated to respect the warning';
    //   SRMInterfaceManagement: Codeunit "SRM Interface Management";
    begin
        //HEI.134>>
        if PurchRcptLine.ISTEMPORARY then
            exit;

        if (PurchRcptLine.Type <> PurchRcptLine.Type::Item) then
            exit;

        if PurchRcptHeaderAdditional.GET(PurchRcptLine."Document No.") then
            if (PurchRcptHeaderAdditional."Shopping Card No. FND" = '') then
                exit;

        //ERROR(POSMItemLine);  //HEI.135
        if not CONFIRM(POSMConfirmation, false) then  //HEI.135
            ERROR(POSMWarningMessage);  //HEI.135
        //HEI.134<<
    end;

    local procedure IbecorComparePORequest(var Rec_PurchaseHeaderAdditional: Record "Purchase Header Additional FND"; var xRec_PurchaseHeaderAdditional: Record "Purchase Header Additional FND"): Boolean;
    begin
        //HEI.137>>
        case true of
            //License Information
            Rec_PurchaseHeaderAdditional."License Required INT" <> xRec_PurchaseHeaderAdditional."License Required INT":
                exit(true);
            //Rec_PurchaseHeaderAdditional."License Name" <> xRec_PurchaseHeaderAdditional."License Code" : EXIT(TRUE); //HEI.150
            Rec_PurchaseHeaderAdditional."License Code" <> xRec_PurchaseHeaderAdditional."License Code":
                exit(true); //HEI.150
            Rec_PurchaseHeaderAdditional."Bank who issued the License" <> xRec_PurchaseHeaderAdditional."Bank who issued the License":
                exit(true);
            Rec_PurchaseHeaderAdditional."License Expiration Date" <> xRec_PurchaseHeaderAdditional."License Expiration Date":
                exit(true);
            Rec_PurchaseHeaderAdditional."CoD/CoC Number" <> xRec_PurchaseHeaderAdditional."CoD/CoC Number":
                exit(true);
            //Letter of Credit Information
            Rec_PurchaseHeaderAdditional."Credit Info Required INT" <> xRec_PurchaseHeaderAdditional."Credit Info Required INT":
                exit(true);
            Rec_PurchaseHeaderAdditional."Credit Number INT" <> xRec_PurchaseHeaderAdditional."Credit Number INT":
                exit(true);
            Rec_PurchaseHeaderAdditional."Credit Amount Of supplier INT" <> xRec_PurchaseHeaderAdditional."Credit Amount Of supplier INT":
                exit(true);
            Rec_PurchaseHeaderAdditional."Bank Who Issued Credit INT" <> xRec_PurchaseHeaderAdditional."Bank Who Issued Credit INT":
                exit(true);
            Rec_PurchaseHeaderAdditional."Last Date Of Shipment INT" <> xRec_PurchaseHeaderAdditional."Last Date Of Shipment INT":
                exit(true);
            Rec_PurchaseHeaderAdditional."Bank Reference Number" <> xRec_PurchaseHeaderAdditional."Bank Reference Number":
                exit(true);
            Rec_PurchaseHeaderAdditional."Credit Validity Date INT" <> xRec_PurchaseHeaderAdditional."Credit Validity Date INT":
                exit(true);
        end;
        exit(false);
        //HEI.137<<
    end;
    // BC Upgrade SHUKLP03 << Added interface code of codeunit "Purchase-Utils".

    //BC Upgrade KAPOOV01 CD-231-HEI.01>>

    // HEI.01 CHG2201773 HB3442 SRIVAS07 IBM 18/03/24 # Development - Undoing a Goods Receipt for Fixed Asset
    //      # Created a new function PreviewSRM()
    //----------------------------------------------------------------------------------------------------------

    //BC Upgrade KAPOOV01 04.12.25 #Created new function-PreviewSRM for CD-231-Gen. Jnl.-Post.

    procedure PreviewSRM(VAR GenJournalLineSource: Record "Gen. Journal Line")
    var
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
    begin
        //HEI.01>>
        BINDSUBSCRIPTION(GenJnlPost);
        //GenJnlPostPreview.PreviewSRMInterface(GenJnlPost, GenJournalLineSource); //BC Upgrade KAPOOV01 calling from Priya's function.
        PreviewSRMInterface(GenJnlPost, GenJournalLineSource);
        //HEI.01<<
    end;

    //BC Upgrade KAPOOV01 CD-231-HEI.01<<
    //BC Upgrade SHARMP16 -- Purchprocesstesting BEGIN>>
    procedure GetPurchSetupInt();
    begin
        if not PurchSetupRetrieved then
            PurchSetup.GET();
        PurchSetupRetrieved := true;
    end;

    var
        PurchSetupRetrieved: Boolean;
    //BC Upgrade SHARMP16 -- Purchprocesstesting END<<

    //BC Upgrade SHARMP16 BEGIN<<---PurchPostCode 90
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterFinalizePostingOnBeforeCommit, '', false, false)]
    local procedure OnAfterFinalizePostingOnBeforeCommit(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchRcptHeader: Record "Purch. Rcpt. Header")
    var

        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        ZycusInterfaceManagement: Codeunit "Zycus Interface Management";

    begin
        //HEI.47>>
        //SRMInterfaceManagement.CreteOutboundSRMItemGR(PurchRcptHeader);  //HEI.41
        IF (PurchRcptHeader."Order No." <> '') THEN BEGIN
            IF PurchaseHeaderAdditional.GET(PurchaseHeaderAdditional."Document Type"::Order, PurchRcptHeader."Order No.") THEN BEGIN
                IF (PurchaseHeaderAdditional."Shopping Card No." <> '') AND (PurchaseHeaderAdditional."Zycus Order No. INT" = '') THEN
                    SRMInterfaceManagement.CreteOutboundSRMItemGR(PurchRcptHeader);
                IF (PurchaseHeaderAdditional."Zycus Order No. INT" <> '') THEN
                    ZycusInterfaceManagement.CreateOutboundPOSMGR_Zycus(PurchRcptHeader);
            END;
        END;
        //HEI.47<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnPostUpdateOrderLineOnPurchHeaderReceive, '', false, false)]
    local procedure OnPostUpdateOrderLineOnPurchHeaderReceive(PurchRcptHeader: Record "Purch. Rcpt. Header"; var TempPurchLine: Record "Purchase Line")
    var
        PurchUtilis: Codeunit "Purchases-Utils";
        PurchaseHeaderAddL: Record "Purchase Header Additional FND";
        Currency: Record Currency;

    begin
        if Currency.get(PurchLine."Currency Code") then;
        //HEI.48>>
        IF PurchaseHeaderAddL.GET(TempPurchLine."Document Type", TempPurchLine."Document No.") THEN;
        //HEI.48<<
        //HEI.04>>
        IF (TempPurchLine."SRM Order No. FND" <> '') AND (TempPurchLine."SRM Order Line No. FND" <> '') THEN
            //HEI.48>>
            IF PurchaseHeaderAddL."Zycus Order No. INT" <> '' THEN BEGIN
                IF PurchaseHeaderAddL."Limit PO" THEN
                    TempPurchLine."Remaining Amount FND" -= ROUND(TempPurchLine."Line Amount" / TempPurchLine.Quantity * TempPurchLine."Qty. to Receive", Currency."Amount Rounding Precision");
            END ELSE
                //HEI.48<<
                TempPurchLine."Remaining Amount FND" -= ROUND(TempPurchLine."Line Amount" / TempPurchLine.Quantity * TempPurchLine."Qty. to Receive", Currency."Amount Rounding Precision");
        //HEI.04<<
    end;
    //BC Upgrade SHARMP16 END>>---PurchPostCode

    //BC UPGRADE SHARMP16 >> 07072026
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforePrintRecords', '', false, false)]
    local procedure OnBeforePrintRecordsOrder(ShowRequestForm: Boolean; var IsHandled: Boolean; var PurchaseHeader: Record "Purchase Header")
    var
        ReportSelection: Record "Report Selections";
        PurchHeader: Record "Purchase Header";
    begin
        ReportSelection.Reset();
        ReportSelection.SetRange(Usage, ReportSelection.Usage::"P.Order");
        ReportSelection.SetRange("Document Subtype Code FND", PurchaseHeader."Document Subtype Code FND");
        if ReportSelection.FindFirst() then begin
            PurchHeader.RESET();
            PurchHeader.SETRANGE(PurchHeader."No.", PurchaseHeader."No.");
            IF PurchHeader.FINDSET() THEN;
            Report.RunModal(ReportSelection."Report ID", true, false, PurchHeader);
        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforePrintRecords', '', false, false)]
    local procedure OnBeforePrintRecordsQuote(ShowRequestForm: Boolean; var IsHandled: Boolean; var PurchaseHeader: Record "Purchase Header")
    var
        ReportSelection: Record "Report Selections";
        PurchHeader: Record "Purchase Header";
    begin
        ReportSelection.Reset();
        ReportSelection.SetRange(Usage, ReportSelection.Usage::"P.Quote");
        ReportSelection.SetRange("Document Subtype Code FND", PurchaseHeader."Document Subtype Code FND");
        if ReportSelection.FindFirst() then begin
            PurchHeader.RESET();
            PurchHeader.SETRANGE(PurchHeader."No.", PurchaseHeader."No.");
            IF PurchHeader.FINDSET() THEN;
            Report.RunModal(ReportSelection."Report ID", true, false, PurchHeader);
        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforePrintRecords', '', false, false)]
    local procedure OnBeforePrintRecordsblanketorder(ShowRequestForm: Boolean; var IsHandled: Boolean; var PurchaseHeader: Record "Purchase Header")
    var
        ReportSelection: Record "Report Selections";
        PurchHeader: Record "Purchase Header";
    begin
        ReportSelection.Reset();
        ReportSelection.SetRange(Usage, ReportSelection.Usage::"P.Blanket");
        ReportSelection.SetRange("Document Subtype Code FND", PurchaseHeader."Document Subtype Code FND");
        if ReportSelection.FindFirst() then begin
            PurchHeader.RESET();
            PurchHeader.SETRANGE(PurchHeader."No.", PurchaseHeader."No.");
            IF PurchHeader.FINDSET() THEN;
            Report.RunModal(ReportSelection."Report ID", true, false, PurchHeader);
        end;
        IsHandled := true;
    end;
    //BC Upgrade SHARMP16>> -- Report Selection
    [EventSubscriber(ObjectType::Table, Database::"Purch. Inv. Header", 'OnBeforePrintRecords', '', false, false)]
    local procedure OnBeforePrintRecordsPurchInvoice(ShowRequestPage: Boolean; var IsHandled: Boolean; var PurchInvHeader: Record "Purch. Inv. Header")
    var
        ReportSelection: Record "Report Selections";
        PurchInvoiceHeader: Record "Purch. Inv. Header";
    begin
        ReportSelection.Reset();
        ReportSelection.SetRange(Usage, ReportSelection.Usage::"P.Invoice");
        ReportSelection.SetRange("Document Subtype Code FND", PurchInvHeader."Document Subtype Code FND");
        if ReportSelection.FindFirst() then begin
            PurchInvoiceHeader.RESET();
            PurchInvoiceHeader.SETRANGE(PurchInvoiceHeader."No.", PurchInvHeader."No.");
            IF PurchInvoiceHeader.FINDSET() THEN;
            Report.RunModal(ReportSelection."Report ID", true, false, PurchInvoiceHeader);
        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purch. Cr. Memo Hdr.", 'OnBeforePrintRecords', '', false, false)]
    local procedure OnBeforePrintRecordsPurchCrMemo(ShowRequestPage: Boolean; var IsHandled: Boolean; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    var
        ReportSelection: Record "Report Selections";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";

    begin
        ReportSelection.Reset();
        ReportSelection.SetRange(Usage, ReportSelection.Usage::"P.Cr.Memo");
        ReportSelection.SetRange("Document Subtype Code FND", PurchCrMemoHdr."Document Subtype Code FND");
        if ReportSelection.FindFirst() then begin
            PurchCrMemoHeader.RESET();
            PurchCrMemoHeader.SETRANGE(PurchCrMemoHeader."No.", PurchCrMemoHdr."No.");
            IF PurchCrMemoHeader.FINDSET() THEN;
            Report.RunModal(ReportSelection."Report ID", true, false, PurchCrMemoHeader);
        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purch. Rcpt. Header", 'OnBeforePrintRecords', '', false, false)]
    local procedure OnBeforePrintRecordsPurchRcpt(ShowRequestPage: Boolean; var IsHandled: Boolean; var PurchRcptHeader: Record "Purch. Rcpt. Header")
    var
        ReportSelection: Record "Report Selections";
        PurchRcptHdr: Record "Purch. Rcpt. Header";

    begin
        ReportSelection.Reset();
        ReportSelection.SetRange(Usage, ReportSelection.Usage::"P.Receipt");
        ReportSelection.SetRange("Document Subtype Code FND", PurchRcptHeader."Document Subtype Code FND");
        if ReportSelection.FindFirst() then begin
            PurchRcptHdr.RESET();
            PurchRcptHdr.SETRANGE(PurchRcptHdr."No.", PurchRcptHeader."No.");
            IF PurchRcptHdr.FINDSET() THEN;
            Report.RunModal(ReportSelection."Report ID", true, false, PurchRcptHdr);
        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Return Shipment Header", 'OnBeforePrintRecords', '', false, false)]
    local procedure OnBeforePrintRecordsReturnShptHeader(ShowRequestForm: Boolean; var IsHandled: Boolean; var ReturnShipmentHeader: Record "Return Shipment Header")
    var
        ReportSelection: Record "Report Selections";
        ReturnShptHeader: Record "Return Shipment Header";
    begin
        ReportSelection.Reset();
        ReportSelection.SetRange(Usage, ReportSelection.Usage::"P.Ret.Shpt.");
        ReportSelection.SetRange("Document Subtype Code FND", ReturnShipmentHeader."Document Subtype Code FND");
        if ReportSelection.FindFirst() then begin
            ReturnShptHeader.RESET();
            ReturnShptHeader.SETRANGE(ReturnShptHeader."No.", ReturnShipmentHeader."No.");
            IF ReturnShptHeader.FINDSET() THEN;
            Report.RunModal(ReportSelection."Report ID", true, false, ReturnShptHeader);
        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforePrintRecords', '', false, false)]
    local procedure OnBeforePrintRecordsReturnOrder(ShowRequestForm: Boolean; var IsHandled: Boolean; var PurchaseHeader: Record "Purchase Header")
    var
        ReportSelection: Record "Report Selections";
        purchHeader: Record "Purchase Header";
    begin
        ReportSelection.Reset();
        ReportSelection.SetRange(Usage, ReportSelection.Usage::"P.Return");
        ReportSelection.SetRange("Document Subtype Code FND", PurchaseHeader."Document Subtype Code FND");
        if ReportSelection.FindFirst() then begin
            purchHeader.RESET();
            purchHeader.SETRANGE(purchHeader."No.", PurchaseHeader."No.");
            IF purchHeader.FINDSET() THEN;
            Report.RunModal(ReportSelection."Report ID", true, false, purchHeader);
        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforePrintRecords', '', false, false)]
    local procedure OnBeforePrintRecordsTestPrepayment(ShowRequestForm: Boolean; var IsHandled: Boolean; var PurchaseHeader: Record "Purchase Header")
    var
        ReportSelection: Record "Report Selections";
        purchHeader: Record "Purchase Header";

    begin
        ReportSelection.Reset();
        ReportSelection.SetRange(Usage, ReportSelection.Usage::"P.Test Prepmt.");
        ReportSelection.SetRange("Document Subtype Code FND", PurchaseHeader."Document Subtype Code FND");
        if ReportSelection.FindFirst() then begin
            purchHeader.RESET();
            purchHeader.SETRANGE(purchHeader."No.", PurchaseHeader."No.");
            IF purchHeader.FINDSET() THEN;
            Report.RunModal(ReportSelection."Report ID", true, false, purchHeader);
        end;
        IsHandled := true;
    end;
    //BC Upgrade SHARMP16<< -- Report Selection
    //BC UPGRADE SHARMP16 >> Prevent vendor change on SRM blanket order
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeValidateEvent', 'Buy-from Vendor No.', false, false)]
    local procedure PreventVendorChangeOnSRMBlanketOrder(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header")
    var
        VendorChangeNotAllowedErr: Label 'You cannot change the %1 because this Blanket Order is linked to SRM Contract No. %2.';
    begin
        if not GuiAllowed then
            exit;

        if Rec."Document Type" <> Rec."Document Type"::"Blanket Order" then
            exit;

        if Rec."SRM Contract No. FND" = '' then
            exit;

        if (Rec."Buy-from Vendor No." = xRec."Buy-from Vendor No.") and
           (Rec."Buy-from Vendor Name" = xRec."Buy-from Vendor Name") then
            exit;

        Error(VendorChangeNotAllowedErr, Rec.FieldCaption("Buy-from Vendor No."), Rec."SRM Contract No. FND");
    end;

    //BC UPGRADE SHARMP16 >> 07072026
    var
        ZycusInterfaceSetup: Record "Zycus Interface Setup INT";//BC Upgrade SHARMP16--Zycus-D
        ZycusInterfaceSetupRead: Boolean;//BC Upgrade SHARMP16--Zycus-D
}