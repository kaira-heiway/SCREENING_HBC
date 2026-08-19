codeunit 50283 "PurchPost-CAD Extension"
{

    Permissions = tabledata "Value Entry" = RIMD,
                  tabledata "Item Ledger Entry" = RIMD,
                  tabledata "Item Register" = RIMD,
                  tabledata "Purch. Inv. Line" = rimd,
                  tabledata "Purch. Cr. Memo Line" = rimd,
                  tabledata "Purchase Line" = rimd;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post",
        'OnBeforeDivideAmount', '', false, false)]
    local procedure OnBeforeDivideAmount_CAD(
        var PurchHeader: Record "Purchase Header";
        var PurchLine: Record "Purchase Line";
        QtyType: Option;
        var PurchLineQty: Decimal;
        var TempVATAmountLine: Record "VAT Amount Line" temporary;
        var TempVATAmountLineRemainder: Record "VAT Amount Line" temporary;
        var IsHandled: Boolean)
    var
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        Vendor: Record Vendor;
        UpdateAmtInclCAD: Boolean;
    begin
        if IsHandled then
            exit;
        if PurchLine."CAD Amount FND" = 0 then
            exit;

        GLSetup.Get();
        if not GLSetup."Enable CAD FND" then
            exit;
        //HEI.28>>
        CompanyInfo.Get();
        If Vendor.Get(PurchLine."Buy-from Vendor No.") then
            UpdateAmtInclCAD :=
                (CompanyInfo."Country/Region Code" <> Vendor."Country/Region Code") and
                (PurchLine.Type = PurchLine.Type::"Charge (Item)") and
                (PurchLine."CAD Amount FND" <> 0);
        //HEI.28<<
        if UpdateAmtInclCAD then
            //BC Upgrade SHARMP16
            //HEI.28>>
            PurchLine."Line Amount" := PurchLine.GetLineAmountToHandle(PurchLineQty) + GetPrepmtDiffToLineAmount(PurchLine) + PurchLine."CAD Amount FND";   //HEI.28<<
    end;

    LOCAL procedure GetPrepmtDiffToLineAmount(PurchLine: Record "Purchase Line"): Decimal
    var
        TempPrepmtDeductLCYPurchLine: Record "Purchase Line";
    begin
        WITH TempPrepmtDeductLCYPurchLine DO
            IF PurchLine."Prepayment %" = 100 THEN
                IF GET(PurchLine."Document Type", PurchLine."Document No.", PurchLine."Line No.") THEN
                    EXIT("Prepmt Amt to Deduct" - "Line Amount");
        EXIT(0);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post",
        'OnAfterDivideAmount', '', false, false)]
    local procedure OnAfterDivideAmount_CAD(
        PurchHeader: Record "Purchase Header";
        var PurchLine: Record "Purchase Line";
        QtyType: Option;
        PurchLineQty: Decimal;
        var TempVATAmountLine: Record "VAT Amount Line" temporary;
        var TempVATAmountLineRemainder: Record "VAT Amount Line" temporary)
    var
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        Vendor: Record Vendor;
        Currency: Record Currency;
        UpdateAmtInclCAD: Boolean;
    begin
        if PurchLine."CAD Amount FND" = 0 then
            exit;

        GLSetup.Get();
        if not GLSetup."Enable CAD FND" then
            exit;

        if CompanyInfo.Get() and Vendor.Get(PurchLine."Buy-from Vendor No.") then
            UpdateAmtInclCAD :=
                (CompanyInfo."Country/Region Code" <> Vendor."Country/Region Code") and
                (PurchLine.Type = PurchLine.Type::"Charge (Item)") and
                (PurchLine."CAD Amount FND" <> 0);

        if not UpdateAmtInclCAD then
            exit;
        //only cases of charge item
        if (not PurchHeader."Prices Including VAT") and
           (PurchLine."VAT Calculation Type" <> PurchLine."VAT Calculation Type"::"Full VAT")
        then begin
            Currency.InitRoundingPrecision();
            if PurchHeader."Currency Code" <> '' then
                Currency.Get(PurchHeader."Currency Code");
            //HEI.28>>
            PurchLine."VAT Base Amount" :=
                Round(
                    (PurchLine."Line Amount" - PurchLine."Inv. Discount Amount" - PurchLine."CAD Amount FND") *
                    (1 - PurchHeader."VAT Base Discount %" / 100),
                    Currency."Amount Rounding Precision");
        end;
        //HEI.28<<
        if TempVATAmountLineRemainder.Get(
                PurchLine."VAT Identifier", PurchLine."VAT Calculation Type",
                PurchLine."Tax Group Code", PurchLine."Use Tax",
                PurchLine."Line Amount" >= 0)
        then begin    //HEI.28>>
            TempVATAmountLineRemainder."CAD % FND" := TempVATAmountLine."CAD % FND";
            TempVATAmountLineRemainder."CAD Amount FND" := TempVATAmountLine."CAD Amount FND";
            TempVATAmountLineRemainder.Modify();
        end;    //HEI.28>>
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post",
        'OnAfterIncrAmount', '', false, false)]
    local procedure OnAfterIncrAmount_CAD(
        var TotalPurchLine: Record "Purchase Line";
        PurchLine: Record "Purchase Line")
    var
        GLSetup: Record "General Ledger Setup";
    begin
        //HEI.28>>
        GLSetup.Get();

        if GLSetup."Enable CAD FND" and
           (PurchLine.Type in [PurchLine.Type::Item, PurchLine.Type::"Charge (Item)"])
        then
            TotalPurchLine."CAD Amount FND" += PurchLine."CAD Amount FND";
        //HEI.28<<
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events",
    'OnAfterInitGenJnlLineAmountFieldsFromTotalLines', '', false, false)]
    local procedure OnBeforeInitGenJnlLineAmountFields_CAD(
    var GenJnlLine: Record "Gen. Journal Line";
    var PurchHeader: Record "Purchase Header";
    var TotalPurchLine: Record "Purchase Line";
    var TotalPurchLineLCY: Record "Purchase Line")
    var
        GLSetup: Record "General Ledger Setup";
        PurchaseLine: Record "Purchase Line";
        CurrExchRate: Record "Currency Exchange Rate";
        Vendor: Record Vendor;
        CompanyInfo: Record "Company Information";
        TotalWHTLCY: Decimal;
        WHTAmount: Decimal;
        CADAmtFCY: Decimal;
        CADAmtLCY: Decimal;
        UseDate: Date;
        IsForeignVendor: Boolean;
        GenJnlLineq: Codeunit "Gen. Jnl.-Post Line";
    begin


        GLSetup.Get();
        if not GLSetup."Enable CAD FND" then
            exit;

        if TotalPurchLine."CAD Amount FND" = 0 then
            exit;

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchHeader."No.");
        PurchaseLine.SetFilter("CAD Attached to Line No. FND", '<>%1', 0);
        if not PurchaseLine.FindFirst() then begin

            if PurchHeader."Document Type" in
               [PurchHeader."Document Type"::Order,
                PurchHeader."Document Type"::Invoice]
            then begin
                TotalWHTLCY := 0;//wht customization
                if TotalWHTLCY <> 0 then begin//bc upgrade sharmp16 WHT pending
                    GenJnlLine.Amount :=
                        -(TotalPurchLine."Amount Including VAT" +
                          CADAmtFCY - WHTAmount);
                    GenJnlLine."Source Currency Amount" := GenJnlLine.Amount;
                    if PurchHeader."Currency Code" <> '' then
                        TotalWHTLCY :=
                            Round(
                                CurrExchRate.ExchangeAmtFCYToLCY(
                                    UseDate,
                                    PurchHeader."Currency Code",
                                    WHTAmount,
                                    PurchHeader."Currency Factor"));
                    GenJnlLine."Amount (LCY)" :=
                        -(TotalPurchLineLCY."Amount Including VAT" +
                          CADAmtLCY - TotalWHTLCY);
                end else begin
                    //HEI.30>>
                    GenJnlLine.Amount :=
                        -TotalPurchLine."Amount Including VAT" -
                        TotalPurchLine."CAD Amount FND";
                    GenJnlLine."Source Currency Amount" := -TotalPurchLine."Amount Including VAT" - TotalPurchLine."CAD Amount FND";
                    GenJnlLine."Amount (LCY)" :=
                        -TotalPurchLineLCY."Amount Including VAT" - TotalPurchLineLCY."CAD Amount FND";
                end;//HEI.30




                if PurchHeader."Document Type" in
                   [PurchHeader."Document Type"::"Return Order",
                    PurchHeader."Document Type"::"Credit Memo"]
                //only case of cad it will work....

                then begin
                    GenJnlLine.Amount :=
                        Abs(TotalPurchLine."Amount Including VAT" - TotalPurchLine."CAD Amount FND");
                    GenJnlLine."Source Currency Amount" := ABS(TotalPurchLine."Amount Including VAT" - TotalPurchLine."CAD Amount FND");
                    GenJnlLine."Amount (LCY)" :=
                        ABS(TotalPurchLineLCY."Amount Including VAT" - TotalPurchLineLCY."CAD Amount FND");

                end;
            end;
        end;
    end;
    //HEI.28<<
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post",
        'OnAfterCheckAndUpdate', '', false, false)]
    local procedure OnAfterCheckAndUpdate_CAD(CommitIsSuppressed: Boolean; PreviewMode: Boolean; var PurchaseHeader: Record "Purchase Header")
    var
        FinancialUtils: Codeunit "Financial-Utils";
    //FinancialUtilsCAD: Codeunit "Financial Utils CAD";
    begin
        //HEI.28>>
        FinancialUtils.OnAfterReleasePurchHeaderBeforePost(PurchaseHeader);
        // FinancialUtilsCAD.InsertAdditionalCADLineTest(PurchaseHeader); // HEI.33
        //HEI.28<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post",
    'OnBeforePostLines', '', false, false)]
    local procedure OnBeforePostLines_InsertCADLine(CommitIsSupressed: Boolean; PreviewMode: Boolean;
    PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var TempPurchLineGlobal: Record "Purchase Line" temporary)
    var
    //  FinancialUtilsCAD: Codeunit "Financial Utils CAD";
    begin
        InsertAdditionalCADLineTest(PurchHeader, TempPurchLineGlobal);
    end;

    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post",
    //    'OnBeforePostPurchaseDoc', '', false, false)]
    // local procedure OnBeforePostLines_Release(CommitIsSupressed: Boolean; PreviewMode: Boolean; sender: Codeunit "Purch.-Post";
    // var HideProgressWindow: Boolean; var IsHandled: Boolean; var PurchaseHeader: Record "Purchase Header")
    // var
    //     FinancialUtilsCAD: Codeunit "Financial Utils CAD";
    //     ReleasePurchOrder: Codeunit "Release Purchase Document";
    // begin
    //     // if PurchaseHeader.Status = PurchaseHeader.Status::Released then
    //     //     ReleasePurchOrder.Reopen(PurchaseHeader);//BC Upgrade SHARMP16
    //                                                  // FinancialUtilsCAD.InsertAdditionalCADLineTest(PurchHeader, TempPurchLineGlobal);

    //    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post",
        'OnAfterFinalizePostingOnBeforeCommit', '', false, false)]
    local procedure OnAfterFinalizePosting_CAD(CommitIsSupressed: Boolean; PreviewMode: Boolean;
    var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
    var PurchHeader: Record "Purchase Header"; var PurchInvHeader: Record "Purch. Inv. Header";
    var PurchRcptHeader: Record "Purch. Rcpt. Header"; var ReturnShptHeader: Record "Return Shipment Header")
    var
    //FinancialUtils: Codeunit "Financial Utils CAD";
    begin
        CreateCADVarianceValueEntry(
            PurchHeader,
            PurchInvHeader."No.",
            PurchCrMemoHdr."No."); //HEI.28
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events",
        'OnPostLedgerEntryOnAfterGenJnlPostLine', '', false, false)]
    local procedure OnPostLedgerEntryAfter_PostCADDebit(
        var GenJnlLine: Record "Gen. Journal Line";
        var PurchHeader: Record "Purchase Header";
        var TotalPurchLine: Record "Purchase Line";
        var TotalPurchLineLCY: Record "Purchase Line";
        PreviewMode: Boolean;
        SuppressCommit: Boolean;
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        GLSetup: Record "General Ledger Setup";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
    begin
        GLSetup.Get();
        if not GLSetup."Enable CAD FND" then
            exit;
        if TotalPurchLine."CAD Amount FND" = 0 then
            exit;
        if GenJnlLine."Account Type" <> GenJnlLine."Account Type"::Vendor then
            exit;
        //HEI.28<<
        case PurchHeader."Document Type" of
            PurchHeader."Document Type"::Order,
            PurchHeader."Document Type"::Invoice:
                if PurchInvHeader.Get(GenJnlLine."Document No.") then
                    PostCADGLDebitsFromInvoice(PurchHeader, PurchInvHeader, GenJnlPostLine);//BC Upgrade SHARMp16
            PurchHeader."Document Type"::"Return Order",
            PurchHeader."Document Type"::"Credit Memo":
                if PurchCrMemoHdr.Get(GenJnlLine."Document No.") then
                    PostCADGLDebitsFromCrMemo(PurchHeader, PurchCrMemoHdr, GenJnlPostLine);//BC Upgrade SHARMp16
        end;
    end;

    local procedure PostCADGLDebitsFromInvoice(
        PurchHeader: Record "Purchase Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        PurchInvLine: Record "Purch. Inv. Line";
        CADAttachedLine: Record "Purch. Inv. Line";
        TempPurchLine: Record "Purchase Line" temporary;
    begin

        CADAttachedLine.SetRange("Document No.", PurchInvHeader."No.");
        CADAttachedLine.SetFilter("CAD Attached to Line No. FND", '<>%1', 0);
        if not CADAttachedLine.IsEmpty() then
            exit;
        PurchInvLine.Reset();
        PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
        PurchInvLine.SetFilter(Type, '%1|%2',
            PurchInvLine.Type::Item, PurchInvLine.Type::"Charge (Item)");
        PurchInvLine.SetFilter("CAD Amount FND", '<>%1', 0);
        PurchInvLine.SetRange("CAD Attached to Line No. FND", 0); // never post for an attached line
        if PurchInvLine.FindSet() then
            repeat
                Clear(TempPurchLine);
                TempPurchLine.Init();
                TempPurchLine.TransferFields(PurchInvLine);
                TempPurchLine."Document Type" := TempPurchLine."Document Type"::Invoice;
                TempPurchLine.Insert();
                // TempPurchLine."Document No." := PurchInvLine."Document No.";
                // TempPurchLine."Line No." := PurchInvLine."Line No.";
                // TempPurchLine.Type := PurchInvLine.Type;
                // TempPurchLine."No." := PurchInvLine."No.";
                // TempPurchLine."Location Code" := PurchInvLine."Location Code";
                // TempPurchLine."Gen. Bus. Posting Group" := PurchInvLine."Gen. Bus. Posting Group";
                // TempPurchLine."Gen. Prod. Posting Group" := PurchInvLine."Gen. Prod. Posting Group";
                // TempPurchLine."VAT Bus. Posting Group" := PurchInvLine."VAT Bus. Posting Group";
                // TempPurchLine."VAT Prod. Posting Group" := PurchInvLine."VAT Prod. Posting Group";
                // TempPurchLine."Dimension Set ID" := PurchInvLine."Dimension Set ID";
                // TempPurchLine."CAD Amount FND" := PurchInvLine."CAD Amount FND";
                PostCADEntry(PurchHeader, TempPurchLine, GenJnlPostLine,
                             PurchInvHeader."No.", '');//only for invpice
            until PurchInvLine.Next() = 0;
    end;

    local procedure PostCADGLDebitsFromCrMemo(
        PurchHeader: Record "Purchase Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        CADAttachedLine: Record "Purch. Cr. Memo Line";
        TempPurchLine: Record "Purchase Line" temporary;
    begin
        CADAttachedLine.SetRange("Document No.", PurchCrMemoHdr."No.");
        CADAttachedLine.SetFilter("CAD Attached to Line No. FND", '<>%1', 0);
        if not CADAttachedLine.IsEmpty() then
            exit;
        PurchCrMemoLine.Reset();
        PurchCrMemoLine.SetRange("Document No.", PurchCrMemoHdr."No.");
        PurchCrMemoLine.SetFilter(Type, '%1|%2',
            PurchCrMemoLine.Type::Item, PurchCrMemoLine.Type::"Charge (Item)");
        PurchCrMemoLine.SetFilter("CAD Amount FND", '<>%1', 0);
        PurchCrMemoLine.SetRange("CAD Attached to Line No. FND", 0);
        if PurchCrMemoLine.FindSet() then
            repeat
                Clear(TempPurchLine);
                TempPurchLine.Init();
                TempPurchLine.TransferFields(PurchCrMemoLine);
                TempPurchLine."Document Type" := TempPurchLine."Document Type"::"Credit Memo";
                TempPurchLine.Insert();
                // TempPurchLine."Document Type" := TempPurchLine."Document Type"::"Credit Memo";
                // TempPurchLine."Document No." := PurchCrMemoLine."Document No.";
                // TempPurchLine."Line No." := PurchCrMemoLine."Line No.";
                // TempPurchLine.Type := PurchCrMemoLine.Type;
                // TempPurchLine."No." := PurchCrMemoLine."No.";
                // TempPurchLine."Location Code" := PurchCrMemoLine."Location Code";
                // TempPurchLine."Gen. Bus. Posting Group" := PurchCrMemoLine."Gen. Bus. Posting Group";
                // TempPurchLine."Gen. Prod. Posting Group" := PurchCrMemoLine."Gen. Prod. Posting Group";
                // TempPurchLine."VAT Bus. Posting Group" := PurchCrMemoLine."VAT Bus. Posting Group";
                // TempPurchLine."VAT Prod. Posting Group" := PurchCrMemoLine."VAT Prod. Posting Group";
                // TempPurchLine."Dimension Set ID" := PurchCrMemoLine."Dimension Set ID";
                // TempPurchLine."CAD Amount FND" := PurchCrMemoLine."CAD Amount FND";
                PostCADEntry(PurchHeader, TempPurchLine, GenJnlPostLine,
                             '', PurchCrMemoHdr."No.");//only for cr memo
            until PurchCrMemoLine.Next() = 0;
    end;

    local procedure PostCADEntry(
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        PurchInvHdrNo: Code[20];
        PurchCrMemoHdrNo: Code[20])
    var
        VATPostingSetup: Record "VAT Posting Setup";
        Vendor: Record Vendor;
        CompanyInfo: Record "Company Information";
        GeneralPostingSetup: Record "General Posting Setup";
        InventoryPostingSetup: Record "Inventory Posting Setup";
        VendorPostingGroup: Record "Vendor Posting Group";
        Item2: Record Item;
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        GenJnlLine: Record "Gen. Journal Line";
        CADAmount: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        UseDate: Date;
    begin
        IF PurchHeader."Posting Date" = 0D THEN
            UseDate := WORKDATE
        ELSE
            UseDate := PurchHeader."Posting Date";
        //BC Upgrade SHARMP16 added as per NAV logic
        if PurchInvHdrNo <> '' then
            if not PurchInvHeader.Get(PurchInvHdrNo) then
                Clear(PurchInvHeader);
        if PurchCrMemoHdrNo <> '' then
            if not PurchCrMemoHeader.Get(PurchCrMemoHdrNo) then
                Clear(PurchCrMemoHeader);

        VATPostingSetup.Get(
            PurchLine."VAT Bus. Posting Group",
            PurchLine."VAT Prod. Posting Group");

        if VATPostingSetup."CAD % FND" = 0 then
            exit;

        Vendor.Get(PurchHeader."Buy-from Vendor No.");
        CompanyInfo.Get();
        if (Vendor."Country/Region Code" <> CompanyInfo."Country/Region Code") and
           (PurchLine.Type = PurchLine.Type::"Charge (Item)")
        then
            exit;

        GeneralPostingSetup.Get(
            PurchLine."Gen. Bus. Posting Group",
            PurchLine."Gen. Prod. Posting Group");
        GeneralPostingSetup.TestField("Purchase Variance Account");
        GeneralPostingSetup.TestField("Purch. Account");

        if PurchLine.Type = PurchLine.Type::Item then begin
            Item2.Get(PurchLine."No.");
            InventoryPostingSetup.Get(
                PurchLine."Location Code",
                Item2."Inventory Posting Group");
            InventoryPostingSetup.TestField("Inventory Account");
        end;

        VendorPostingGroup.Get(Vendor."Vendor Posting Group");
        VendorPostingGroup.TestField("Payables Account");
        //GL Entry CAD +
        GenJnlLine.InitNewLine(
            PurchHeader."Posting Date",
            PurchHeader."Document Date",
            0D,//--vatdate need to ask parvez
            PurchHeader."Posting Description",
            PurchHeader."Shortcut Dimension 1 Code",
            PurchHeader."Shortcut Dimension 2 Code",
            PurchLine."Dimension Set ID",
            PurchHeader."Reason Code");

        GenJnlLine.CopyFromPurchHeader(PurchHeader);
        GenJnlLine.CopyFromPurchHeaderPayment(PurchHeader);

        CADAmount := PurchLine."CAD Amount FND";
        CADAmount :=
          ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              UseDate, PurchHeader."Currency Code",
              PurchLine."CAD Amount FND", PurchHeader."Currency Factor"));
        if Item2.Get(PurchLine."No.") then begin
            if Item2."Inventory Value Zero" then begin
                if PurchHeader."Document Type" in
                   [PurchHeader."Document Type"::Order,
                    PurchHeader."Document Type"::Invoice]
                then
                    CreateCADJnlLine(
                        GenJnlLine, PurchLine,
                        PurchInvHeader, PurchCrMemoHeader,
                        GeneralPostingSetup."Purch. Account", CADAmount)
                else
                    CreateCADJnlLine(
                        GenJnlLine, PurchLine,
                        PurchInvHeader, PurchCrMemoHeader,
                        GeneralPostingSetup."Purch. Account", -CADAmount);

            end else
                if Item2."Costing Method" = Item2."Costing Method"::Average then begin
                    // Average cost → Inventory Account
                    if PurchHeader."Document Type" in
                       [PurchHeader."Document Type"::Order,
                        PurchHeader."Document Type"::Invoice]
                    then
                        CreateCADJnlLine(
                            GenJnlLine, PurchLine,
                            PurchInvHeader, PurchCrMemoHeader,
                            InventoryPostingSetup."Inventory Account", CADAmount)
                    else
                        CreateCADJnlLine(
                            GenJnlLine, PurchLine,
                            PurchInvHeader, PurchCrMemoHeader,
                            InventoryPostingSetup."Inventory Account", -CADAmount);

                end else begin
                    if PurchHeader."Document Type" in
                       [PurchHeader."Document Type"::Order,
                        PurchHeader."Document Type"::Invoice]
                    then
                        CreateCADJnlLine(
                            GenJnlLine, PurchLine,
                            PurchInvHeader, PurchCrMemoHeader,
                            GeneralPostingSetup."Purchase Variance Account", CADAmount)
                    else
                        CreateCADJnlLine(
                            GenJnlLine, PurchLine,
                            PurchInvHeader, PurchCrMemoHeader,
                            GeneralPostingSetup."Purchase Variance Account", -CADAmount);
                end;
        end;

        GenJnlPostLine.RunWithCheck(GenJnlLine);
        //GL Entry CAD -
        // {GenJnlLine.InitNewLine(
        //     PurchHeader."Posting Date", PurchHeader."Document Date", PurchHeader."Posting Description",
        //     PurchHeader."Shortcut Dimension 1 Code", PurchHeader."Shortcut Dimension 2 Code",
        //     PurchLine."Dimension Set ID", PurchHeader."Reason Code");

        //         GenJnlLine.CopyFromPurchHeader(PurchHeader);
        //         GenJnlLine.CopyFromPurchHeaderPayment(PurchHeader);
        //         //CreateCADJnlLine(GenJnlLine,PurchLine,InventoryPostingSetup."Inventory Account",-PurchLine."CAD Amount FND");
        //         CreateCADJnlLine(GenJnlLine, PurchLine, VendorPostingGroup."Payables Account", -PurchLine."CAD Amount FND");
        //         GenJnlPostLine.RunWithCheck(GenJnlLine);}
        //HEI.28<<

    end;

    local procedure CreateCADJnlLine(
        var GenJnlLine: Record "Gen. Journal Line";
        PurchLine: Record "Purchase Line";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        AccountNo: Code[20];
        CADAmount: Decimal)
    begin
        GenJnlLine."System-Created Entry" := true;
        GenJnlLine."Additional Description FND" := PurchLine."Additional Description FND";
        GenJnlLine."Pmt. Discount Date" := 0D;
        GenJnlLine."Source Type" := GenJnlLine."Source Type"::" ";
        GenJnlLine.Validate("Source No.", '');
        GenJnlLine."Dimension Set ID" := PurchLine."Dimension Set ID";

        case PurchLine."Document Type" of
            PurchLine."Document Type"::Invoice:
                begin
                    GenJnlLine."Document No." := PurchInvHeader."No.";
                    GenJnlLine."External Document No." :=
                        PurchInvHeader."Vendor Invoice No.";
                end;
            PurchLine."Document Type"::"Credit Memo":
                begin
                    GenJnlLine."Document No." := PurchCrMemoHeader."No.";
                    GenJnlLine."External Document No." :=
                        PurchCrMemoHeader."Vendor Cr. Memo No.";
                end;
        end;

        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := AccountNo;
        GenJnlLine.Validate(Amount, CADAmount);
    end;
    // 2 new events to check the CAD amount is flow or not 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post",
     'OnAfterPurchInvLineInsert', '', false, false)]
    local procedure OnAfterPurchInvLineInsert_CopyCADAmount(
     var PurchInvLine: Record "Purch. Inv. Line";
     PurchInvHeader: Record "Purch. Inv. Header";
     PurchLine: Record "Purchase Line";      // ← this IS xPurchLine at runtime
     ItemLedgShptEntryNo: Integer;
     WhseShip: Boolean;
     WhseReceive: Boolean;
     CommitIsSupressed: Boolean;
     PurchHeader: Record "Purchase Header";
     PurchRcptHeader: Record "Purch. Rcpt. Header";
     TempWhseRcptHeader: Record "Warehouse Receipt Header";
     var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line")
    var
        OriginalPurchLine: Record "Purchase Line";
    begin

        if not OriginalPurchLine.Get(
            PurchLine."Document Type",
            PurchLine."Document No.",
            PurchLine."Line No.")
        then
            OriginalPurchLine := PurchLine;

        if OriginalPurchLine."CAD Amount FND" = 0 then
            exit;

        PurchInvLine."CAD Amount FND" := OriginalPurchLine."CAD Amount FND";
        PurchInvLine.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post",
        'OnBeforePostItemTrackingLineOnPostPurchLine', '', false, false)]
    local procedure OnBeforePostItemTrackingLineOnPostPurchLine_SkipCAD(PurchaseHeader: Record "Purchase Header"; PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean; TempTrackingSpecification: Record "Tracking Specification" temporary; PurchInvHeader: Record "Purch. Inv. Header"; PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var RemQtyToBeInvoiced: Decimal; var RemQtyToBeInvoicedBase: Decimal)
    begin
        // Only the synthetic CAD lines: marked as CAD, system-created, and never an Item line.
        if (PurchaseLine."CAD Attached to Line No. FND" <> 0) and
           PurchaseLine."System-Created Entry" and
           (PurchaseLine.Type in [PurchaseLine.Type::"G/L Account", PurchaseLine.Type::"Fixed Asset"])
        and (PurchaseLine."CAD Line FND" = true)
        then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post",
        'OnAfterPurchCrMemoLineInsert', '', false, false)]
    local procedure OnAfterPurchCrMemoLineInsert_CopyCADAmount(
        CommitIsSupressed: Boolean;
        GenJnlLineDocNo: Code[20];
        RoundingLineInserted: Boolean;
        var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        var PurchaseHeader: Record "Purchase Header";
        var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        var PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        var PurchLine: Record "Purchase Line")
    var
        OriginalPurchLine: Record "Purchase Line";
    begin
        if not OriginalPurchLine.Get(
            PurchLine."Document Type",
            PurchLine."Document No.",
            PurchLine."Line No.")
        then
            OriginalPurchLine := PurchLine;

        if OriginalPurchLine."CAD Amount FND" = 0 then
            exit;

        PurchCrMemoLine."CAD Amount FND" := OriginalPurchLine."CAD Amount FND";
        PurchCrMemoLine.Modify();
    end;

    procedure CreateCADVarianceValueEntry(
   PurchaseHeader: Record "Purchase Header";
   PurchInvHdrNo: Code[20];
   PurchCrMemoHdrNo: Code[20])
    var
        CompanyInfo: Record "Company Information";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Item: Record Item;
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchInvLine: Record "Purch. Inv. Line";
        ValueEntry: Record "Value Entry";
        Vendor: Record Vendor;
        IsForeignVendor: Boolean;
        LastValueEntryNo: Integer;
    begin
        IF PurchaseHeader.ISTEMPORARY THEN
            EXIT;
        CompanyInfo.Get();
        GeneralLedgerSetup.Get();
        if not GeneralLedgerSetup."Enable CAD FND" then
            exit;

        if (PurchInvHdrNo = '') and (PurchCrMemoHdrNo = '') then
            exit;

        ValueEntry.LockTable();//bc upgrade sharmp16
        if ValueEntry.FindLast() then
            LastValueEntryNo := ValueEntry."Entry No.";

        if PurchInvHdrNo <> '' then begin
            PurchInvHeader.Get(PurchInvHdrNo);
            Vendor.Get(PurchInvHeader."Buy-from Vendor No.");
            IsForeignVendor :=
                CompanyInfo."Country/Region Code" <> Vendor."Country/Region Code";

            PurchInvLine.SetRange("Document No.", PurchInvHdrNo);

            if IsForeignVendor then
                PurchInvLine.SetRange(Type, PurchInvLine.Type::Item)
            else
                PurchInvLine.SetFilter(Type, '%1|%2',
                    PurchInvLine.Type::Item,
                    PurchInvLine.Type::"Charge (Item)");

            if PurchInvLine.FindSet() then
                repeat
                    if PurchInvLine."CAD Amount FND" <> 0 then begin
                        Clear(Item);
                        if Item.Get(PurchInvLine."No.") then
                            if not Item."Inventory Value Zero" then begin
                                LastValueEntryNo += 1;
                                InsertCADValueEntry(
                                    LastValueEntryNo,
                                    PurchInvHeader."Posting Date",
                                    PurchInvHeader."Document Date",
                                    PurchInvHdrNo,
                                    PurchInvHeader."Vendor Invoice No.",
                                    PurchInvHeader."Buy-from Vendor No.",
                                    PurchInvLine."Location Code",
                                    PurchInvLine."Dimension Set ID",
                                    PurchInvLine."Gen. Bus. Posting Group",
                                    PurchInvLine."Gen. Prod. Posting Group",
                                    PurchInvLine."Line No.",
                                    PurchInvLine.Type,
                                    PurchInvLine."No.",
                                    -PurchInvLine."CAD Amount FND",
                                    PurchInvLine.Quantity);
                            end;
                    end;
                until PurchInvLine.Next() = 0;
        end;

        if PurchCrMemoHdrNo <> '' then begin
            PurchCrMemoHdr.Get(PurchCrMemoHdrNo);
            Vendor.Get(PurchCrMemoHdr."Buy-from Vendor No.");
            IsForeignVendor :=
                CompanyInfo."Country/Region Code" <> Vendor."Country/Region Code";

            PurchCrMemoLine.SetRange("Document No.", PurchCrMemoHdrNo);
            if IsForeignVendor then
                PurchCrMemoLine.SetRange(Type, PurchCrMemoLine.Type::Item)
            else
                PurchCrMemoLine.SetFilter(Type, '%1|%2',
                    PurchCrMemoLine.Type::Item,
                    PurchCrMemoLine.Type::"Charge (Item)");

            if PurchCrMemoLine.FindSet(false) then
                repeat
                    if PurchCrMemoLine."CAD Amount FND" <> 0 then begin
                        Clear(Item);
                        if Item.Get(PurchCrMemoLine."No.") then
                            if not Item."Inventory Value Zero" then begin
                                LastValueEntryNo += 1;
                                InsertCADValueEntry(
                                    LastValueEntryNo,
                                    PurchCrMemoHdr."Posting Date",
                                    PurchCrMemoHdr."Document Date",
                                    PurchCrMemoHdrNo,
                                    PurchCrMemoHdr."Vendor Cr. Memo No.",
                                    PurchCrMemoHdr."Buy-from Vendor No.",
                                    PurchCrMemoLine."Location Code",
                                    PurchCrMemoLine."Dimension Set ID",
                                    PurchCrMemoLine."Gen. Bus. Posting Group",
                                    PurchCrMemoLine."Gen. Prod. Posting Group",
                                    PurchCrMemoLine."Line No.",
                                    PurchCrMemoLine.Type,
                                    PurchCrMemoLine."No.",
                                    -PurchCrMemoLine."CAD Amount FND",
                                    -PurchCrMemoLine.Quantity);
                            end;
                    end;
                until PurchCrMemoLine.Next() = 0;
        end;
    end;




    local procedure InsertCADValueEntry(
        EntryNo: Integer;
        PostingDate: Date;
        DocDate: Date;
        DocumentNo: Code[20];
        ExternalDocNo: Code[35];
        VendorNo: Code[20];
        LocationCode: Code[10];
        DimensionSetID: Integer;
        GenBusPostGr: Code[20];
        GenProdPostGr: Code[20];
        LineNo: Integer;
        AccType: Enum "Purchase Line Type";
        ItemNo: Code[20];
        CADAmount: Decimal;
        ValuedQty: Decimal)
    var
        ValueEntry: Record "Value Entry";
        ValueEntry2: Record "Value Entry";
        Item: Record Item;
        SourceCodeSetup: Record "Source Code Setup";
        ValueEntry3: Record "Value Entry";
    begin
        SourceCodeSetup.Get();

        WITH ValueEntry DO BEGIN
            INIT;
            "Entry No." := EntryNo;
            VALIDATE("Posting Date", PostingDate);
            VALIDATE("Document Date", DocDate);
            VALIDATE("Document No.", DocumentNo);
            VALIDATE("External Document No.", ExternalDocNo);
            VALIDATE("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Purchase);
            VALIDATE("Source Type", ValueEntry."Source Type"::Vendor);
            VALIDATE("Source No.", VendorNo);
            VALIDATE("Location Code", LocationCode);
            VALIDATE("Gen. Bus. Posting Group", GenBusPostGr);
            VALIDATE("Gen. Prod. Posting Group", GenProdPostGr);
            VALIDATE("Dimension Set ID", DimensionSetID);
            VALIDATE("User ID", USERID);
            VALIDATE("Valuation Date", WORKDATE);
            VALIDATE("Document Line No.", LineNo);
            IF ValuedQty > 0 THEN
                VALIDATE("Document Type", ValueEntry."Document Type"::"Purchase Invoice")
            ELSE
                VALIDATE("Document Type", ValueEntry."Document Type"::"Purchase Credit Memo");
            VALIDATE("Valued Quantity", ValuedQty);
            SourceCodeSetup.GET;
            VALIDATE("Source Code", SourceCodeSetup.Purchases);
            // VALIDATE("Item Charge Value", ABS(CADAmount));

            IF AccType = AccType::Item THEN BEGIN
                VALIDATE("Item No.", ItemNo);
                Item.GET(ItemNo);
            END;
            IF AccType = AccType::"Charge (Item)" THEN
                VALIDATE("Item Charge No.", ItemNo);

            IF Item."Costing Method" = Item."Costing Method"::Average THEN BEGIN
                VALIDATE("Entry Type", ValueEntry."Entry Type"::"Direct Cost");
                VALIDATE("Variance Type", "Variance Type"::" ");
                VALIDATE("Cost Amount (Actual)", ABS(CADAmount));
                VALIDATE("Cost Posted to G/L", ABS(CADAmount));
                VALIDATE("Cost per Unit", ABS(CADAmount / ValuedQty));
                VALIDATE("Purchase Amount (Actual)", ABS(CADAmount));
            END ELSE BEGIN
                VALIDATE("Entry Type", ValueEntry."Entry Type"::Variance);
                VALIDATE("Variance Type", "Variance Type"::Purchase);
                VALIDATE("Cost Amount (Actual)", CADAmount);
                VALIDATE("Cost Posted to G/L", CADAmount);
                VALIDATE("Cost per Unit", CADAmount / ValuedQty);
            END;

            //Find Item Ledger Entry No.
            ValueEntry2.SETRANGE("Document Type", ValueEntry."Document Type");
            ValueEntry2.SETRANGE("Document No.", DocumentNo);
            IF AccType = AccType::Item THEN
                ValueEntry2.SETRANGE("Item No.", ItemNo);
            IF AccType = AccType::"Charge (Item)" THEN
                ValueEntry2.SETRANGE("Item Charge No.", ItemNo);
            IF ValueEntry2.FINDFIRST THEN BEGIN
                // "Item Ledger Entry Source Type" := ValueEntry2."Item Ledger Entry Source Type";
                "Item Ledger Entry No." := ValueEntry2."Item Ledger Entry No.";
                "Zone Code FND" := ValueEntry2."Zone Code FND";
                "Bin Code FND" := ValueEntry2."Bin Code FND";
                "Inventory Posting Group" := ValueEntry2."Inventory Posting Group";
                // "Src. Deposit Group Code" := ValueEntry2."Src. Deposit Group Code";//BC Upgrade SHARMP16-->>Drink-IT fields
                "Source Posting Group" := ValueEntry2."Source Posting Group";
                Inventoriable := ValueEntry2.Inventoriable;
                // "Unit of Measure Code" := ValueEntry2."Unit of Measure Code";//BC Upgrade SHARMP16-->>Drink-IT fields
                // "Initial Entry Due Date" := ValueEntry2."Initial Entry Due Date";//BC Upgrade SHARMP16-->>Drink-IT fields
                // "Strength Spec. Code" := ValueEntry2."Strength Spec. Code";//BC Upgrade SHARMP16-->>Drink-IT fields
                // "Tax Date" := ValueEntry2."Tax Date";//BC Upgrade SHARMP16-->>Drink-IT fields
                // "Qty. per Unit of Measure" := ValueEntry2."Qty. per Unit of Measure";//BC Upgrade SHARMP16-->>Drink-IT fields
                // "Last Price Calculated Date" := ValueEntry2."Last Price Calculated Date";//BC Upgrade SHARMP16-->>Drink-IT fields
            END;

            //Update Value Entry for Direct Cost
            ValueEntry3.RESET;
            ValueEntry3.SETRANGE("Entry Type", ValueEntry3."Entry Type"::"Direct Cost");
            ValueEntry3.SETRANGE("Document Type", ValueEntry."Document Type");
            ValueEntry3.SETRANGE("Document No.", ValueEntry."Document No.");
            IF AccType = AccType::Item THEN
                ValueEntry3.SETRANGE("Item No.", ItemNo);
            IF AccType = AccType::"Charge (Item)" THEN
                ValueEntry3.SETRANGE("Item Charge No.", ItemNo);
            IF ValueEntry3.FINDFIRST THEN BEGIN
                ValueEntry3."Cost Amount (Actual)" := ValueEntry3."Cost Amount (Actual)" + ABS(CADAmount);
                ValueEntry3."Cost Posted to G/L" := ValueEntry3."Cost Amount (Actual)";
                ValueEntry3."Purchase Amount (Actual)" := ValueEntry3."Cost Amount (Actual)";
                ValueEntry3."Purchase Amount (Expected)" := -ValueEntry3."Cost Amount (Actual)";
                ValueEntry3."Cost per Unit" := ValueEntry3."Cost Amount (Actual)" / ValuedQty;
                ValueEntry3.MODIFY;
            END;

            INSERT(TRUE);
        END;
    end;

    procedure InsertAdditionalCADLineTest(PurchaseHeader: Record "Purchase Header"; var TempPurchLine: Record "Purchase Line" temporary);
    var
        CompanyInformation: Record "Company Information";
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseLine: Record "Purchase Line";
        PurchaseLine4: Record "Purchase Line";
        Vendor: Record Vendor;
        WHTPostingSetup: Record "WHT Posting Setup FND";
        NextLineNo: Integer;
        ReleasePurchOrder: Codeunit "Release Purchase Document";
        PurchHeader2: Record "Purchase Header";
    begin
        //HEI.33>>
        GeneralLedgerSetup.Get();
        CompanyInformation.Get();
        Vendor.Get(PurchaseHeader."Buy-from Vendor No.");

        if not GeneralLedgerSetup."Enable CAD FND" then
            exit;

        if not (PurchaseHeader."Document Type" in [PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::"Credit Memo"]) then
            exit;
        // if PurchHeader2.get(PurchaseHeader."Document Type", PurchaseHeader."No.") then begin//BC Upgrade SHARMP16-->>Drink-IT fields
        //     if PurchHeader2.Status = PurchHeader2.Status::Released then//BC Upgrade SHARMP16-->>Drink-IT fields
        //         ReleasePurchOrder.Reopen(PurchHeader2);//BC Upgrade SHARMP16
        // end;

        // Base next line no. from the TEMP posting buffer (computed once, so multiple CAD lines don't collide)
        TempPurchLine.Reset();
        TempPurchLine.SetRange("Document Type", PurchaseHeader."Document Type");
        TempPurchLine.SetRange("Document No.", PurchaseHeader."No.");
        TempPurchLine.SetFilter(Type, '<>%1&<>%2', TempPurchLine.Type::"Charge (Item)", TempPurchLine.Type::" ");
        if TempPurchLine.FindLast() then
            NextLineNo := TempPurchLine."Line No."
        else
            NextLineNo := 0;
        TempPurchLine.Reset();

        PurchaseLine4.Reset();
        PurchaseLine4.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine4.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine4.SetRange("CAD Attached to Line No. FND", 0);
        PurchaseLine4.SetFilter(Type, '%1|%2', PurchaseLine4.Type::"G/L Account", PurchaseLine4.Type::"Fixed Asset");
        //HEI.34>>
        PurchaseLine4.SetFilter("VAT %", '<>%1', 0);
        PurchaseLine4.SetFilter("CAD Amount FND", '<>%1', 0);
        //HEI.34<<
        if PurchaseLine4.FindSet() then
            repeat
                //Setup Next Line No.
                NextLineNo := NextLineNo + 10000;

                //Insert CAD Line
                PurchaseLine.Init();
                PurchaseLine.Copy(PurchaseLine4);
                PurchaseLine."Line No." := NextLineNo;
                PurchaseLine."CAD Line FND" := true;//BC Upgrade SHARMP16
                PurchaseLine."CAD Attached to Line No. FND" := PurchaseLine4."Line No.";
                PurchaseLine."CAD Amount FND" := 0;
                if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice then begin
                    PurchaseLine."Receipt No." := '';
                    PurchaseLine."Receipt Line No." := 0;
                end else if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo" then begin
                    PurchaseLine."Return Shipment No." := '';
                    PurchaseLine."Return Shipment Line No." := 0;
                end;

                if PurchaseLine4.Type = PurchaseLine4.Type::"G/L Account" then
                    if Vendor."Country/Region Code" <> CompanyInformation."Country/Region Code" then
                        if GeneralLedgerSetup."Enable WHT FND" then begin
                            if WHTPostingSetup.Get(PurchaseLine4."WHT Product Posting Group FND", PurchaseLine4."WHT Product Posting Group FND") and
                               (WHTPostingSetup."WHT %" <> 0)
                            then begin
                                WHTPostingSetup.TestField("CAD Account");
                                PurchaseLine."No." := WHTPostingSetup."CAD Account";
                            end;
                        end;

                if StrLen(PurchaseLine4.Description) + 4 > 50 then
                    PurchaseLine.Description := DelStr(PurchaseLine4.Description, StrLen(PurchaseLine4.Description) - 3) + '_CAD'
                else
                    PurchaseLine.Description := PurchaseLine4.Description + '_CAD';
                PurchaseLine."System-Created Entry" := true;//BC Upgrade SHARMP16
                                                            // PurchaseLine."VAT Prod. Posting Group" := 'NO_VAT';
                PurchaseLine.Validate("VAT Prod. Posting Group", 'NO_VAT');
                PurchaseLine.Validate(Quantity, 1);

                if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice then begin
                    PurchaseLine.Validate("Qty. to Receive", 1);
                    PurchaseLine."Quantity Received" := 1;
                end else if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo" then begin
                    PurchaseLine.Validate("Return Qty. to Ship", 1);
                    PurchaseLine."Return Qty. Shipped" := 1;
                end;
                PurchaseLine.Validate("Direct Unit Cost", PurchaseLine4."CAD Amount FND");

                //bc upgrade sharmp16 Insert into the TEMP posting buffer --(posts to G/L + posted invoice; never touches the real document)
                TempPurchLine := PurchaseLine;
                TempPurchLine."Line No." := NextLineNo;
                TempPurchLine.Insert();
            until PurchaseLine4.Next() = 0;
        //HEI.33<<
    end;


}