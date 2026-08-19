codeunit 51035 "Heineken BC Upgrade CBN"
{
    // -------------------------------------------------------------------------------------------------
    // Purpose:
    // This codeunit contains Event Subscribers that were migrated from the Foundation Extension
    // Foundation codeunit 50280 "Heineken BC Upgrade" into the Common Business Extension.
    // -------------------------------------------------------------------------------------------------
    // Reference:
    // Original Source Codeunit : 50280 "Heineken BC Upgrade"
    // Migrated To              : 51035 "Heineken BC Upgrade CBN"
    // -------------------------------------------------------------------------------------------------
    // Note for Developers:
    // - Check Foundation extension before adding duplicate subscribers.
    // - Keep only Common Business related subscriber logic in this codeunit.
    // - Use this codeunit as the primary location for migrated CBN-specific event subscribers.
    // -------------------------------------------------------------------------------------------------

    Permissions = tabledata "Approval Entry" = rimd,//BC Upgrade SHARMP16 PurchProcesschanges
    tabledata "Bank Account Ledger Entry" = rimd,
    tabledata "Check Ledger Entry" = rimd,
    tabledata "Cust. Ledger Entry" = rimd,
    tabledata "Vendor Ledger Entry" = rimd,
    tabledata "Employee Ledger Entry" = rimd,
    tabledata "Dimension Set Entry" = rim;//BC Upgrade SHARMP16 GAPFitchanges

    [EventSubscriber(ObjectType::Page, Page::"Purchases & Payables Setup", OnOpenPageEvent, '', false, false)]
    local procedure MyProcedure(var Rec: Record "Purchases & Payables Setup")
    var
        MemoReader: InStream;
        MemoReader_1: InStream;
        PoLegalText: BigText;
        PoLegatTextInternational: BigText;
        FooterText: BigText;
        FooterTextInternational: BigText;
    begin
        //HEI.20>>
        Rec.CALCFIELDS(Rec."PO Legal Text FND", Rec."PO Legal Txt International FND");
        if Rec."PO Legal Text FND".HASVALUE then begin
            Rec."PO Legal Text FND".CREATEINSTREAM(MemoReader);
            PoLegalText.READ(MemoReader);
        end;
        if Rec."PO Legal Txt International FND".HASVALUE then begin
            Rec."PO Legal Txt International FND".CREATEINSTREAM(MemoReader);
            PoLegatTextInternational.READ(MemoReader);
        end;
        //HEI.20<<

        //HEI.22 >>
        Rec.CALCFIELDS(Rec."Footer Text FND", Rec."Footer Text International FND");
        if Rec."Footer Text FND".HASVALUE then begin
            Rec."Footer Text FND".CREATEINSTREAM(MemoReader_1);
            FooterText.READ(MemoReader_1);
        end;
        if Rec."Footer Text International FND".HASVALUE then begin
            Rec."Footer Text International FND".CREATEINSTREAM(MemoReader_1);
            FooterTextInternational.READ(MemoReader_1);
        end;
        //HEI.22 <<
    end;

    //HEI.61 >> Code from 81 table triggers
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnAfterDeleteEvent, '', false, false)]
    procedure OnAfterDeleteCheckBlockedTemplate(var Rec: Record "Gen. Journal Line")
    var
        GenJnlTemplate: Record "Gen. Journal Template";
        lText50000: TextConst ENU = 'General journal template %1 is blocked. Please contact administrator for assistance.';
    begin
        IF GenJnlTemplate.Get(Rec."Journal Template Name") THEN
            IF GenJnlTemplate."Blocked FND" THEN
                ERROR(lText50000, Rec."Journal Template Name");
        rec.SetAutoCalcFields();
        if not rec."System-Created Entry" then;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnAfterInsertEvent, '', false, false)]
    procedure OnAfterInsertCheckBlockedTemplate(var Rec: Record "Gen. Journal Line")
    var
        GenJnlTemplate: Record "Gen. Journal Template";
        lText50000: TextConst ENU = 'General journal template %1 is blocked. Please contact administrator for assistance.';
    begin
        IF GenJnlTemplate.Get(Rec."Journal Template Name") THEN
            IF GenJnlTemplate."Blocked FND" THEN
                ERROR(lText50000, Rec."Journal Template Name");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnAfterModifyEvent, '', false, false)]
    procedure OnAfterMOdifyCheckBlockedTemplate(var Rec: Record "Gen. Journal Line")
    var
        GenJnlTemplate: Record "Gen. Journal Template";
        lText50000: TextConst ENU = 'General journal template %1 is blocked. Please contact administrator for assistance.';
    begin
        IF GenJnlTemplate.GET(Rec."Journal Template Name") THEN
            IF GenJnlTemplate."Blocked FND" THEN
                ERROR(lText50000, Rec."Journal Template Name");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnAfterRenameEvent, '', false, false)]
    procedure OnAfterRenameCheckBlockedTemplate(var Rec: Record "Gen. Journal Line")
    var
        GenJnlTemplate: Record "Gen. Journal Template";
        lText50000: TextConst ENU = 'General journal template %1 is blocked. Please contact administrator for assistance.';
    begin
        IF GenJnlTemplate.GET(Rec."Journal Template Name") THEN
            IF GenJnlTemplate."Blocked FND" THEN
                ERROR(lText50000, Rec."Journal Template Name");
    end;
    //HEI.61 << Code from 81 table triggers

    // [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterOnInsert', '', false, false)]
    // local procedure InsertInCustAttributes()
    // var
    //     SalesSetup: Record "Sales & Receivables Setup";
    // begin
    //     //HEI.22>>
    //     "Risk Category" := SalesSetup."Default Risk Grade";
    //     "Risk Score" := SalesSetup."Default Risk Score";
    //     //HEI.22<<
    // end;

    [EventSubscriber(ObjectType::Table, Database::Vendor, OnBeforeCheckBlockedVend, '', true, true)]
    local procedure CheckBlockedVendOnDocs()
    begin
        //HEI.02>>
        //  PurchasesUtils.OnCheckBlockedVendOnDocs(Vend2);//sharmp16 blocked this code because this is seprate cu needs to compile.
        //HEI.02<<
    end;

    [EventSubscriber(ObjectType::Table, Database::Vendor, OnBeforeCheckBlockedVend, '', true, true)]
    local procedure CheckBlockedVendOnJnls(DocType: Option Payment; Source: Option; Transaction: Boolean; var IsHandled: Boolean; Vendor: Record Vendor)
    var
        Text50002: Label 'You cannot create this type of document when sensitive payment block is enable for Vendor %1';
    begin
        //HEI.08>>
        IF (DocType = DocType::Payment) AND (Vendor."Sensitive Payment Block FND") THEN
            ERROR(Text50002, Vendor.Name);
        //HEI.08<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnValidateAccountNoOnBeforeAssignValue, '', false, false)]
    local procedure OnValidateAccountNoOnBeforeAssignValue(var GenJournalLine: Record "Gen. Journal Line"; var xGenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine.UpdateBankAcc(GenJournalLine, xGenJournalLine);
        GenJournalLine.GetDerogatorySetup();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnBeforeValidateDocumentDateFromPostingDate, '', false, false)]
    local procedure OnBeforeValidateDocumentDateFromPostingDate(var GenJournalLine: Record "Gen. Journal Line"; xGenJournalLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    begin
    end;


    [EventSubscriber(ObjectType::Table, Database::Item, OnBeforeTestNoOpenEntriesExist, '', false, false)]
    local procedure Item_OnBeforeTestNoOpenEntriesExist(Item: Record Item; var ItemLedgerEntry: Record "Item Ledger Entry"; CurrentFieldName: Text[100]; var IsHandled: Boolean)
    var
        Text019: Label 'You cannot change %1 because there are one or more open ledger entries for this item.';
        xRec: Record Item;
    begin
        IsHandled := true;
        If xRec."Base Unit of Measure" <> '' then BEGIN
            ItemLedgerEntry.SETCURRENTKEY("Item No.", Open);
            ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
            ItemLedgerEntry.SETRANGE(Open, TRUE);
            IF NOT ItemLedgerEntry.ISEMPTY THEN
                IF item."Base Unit of Measure" <> xRec."Base Unit of Measure" THEN
                    ERROR(Text019, CurrentFieldName);
        END;
        xRec := Item;
        //HEi.19, HEI.22
        //BC Upgrade PATHAA02 -xRec needs to be addressed.
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, OnBeforeTestNoItemLedgEntiesExist, '', false, false)]
    local procedure Item_OnBeforeTestNoItemLedgEntiesExist(var Item: Record Item; CurrentFieldName: Text[100]; var IsHandled: Boolean)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        xRec: Record Item;
        Text007: Label 'You cannot change %1 because there are one or more ledger entries for this item.';
    begin
        IsHandled := true;
        If xRec."No." <> '' then BEGIN
            ItemLedgEntry.SetCurrentKey("Item No.");
            ItemLedgEntry.SetRange("Item No.", Item."No.");
            if not ItemLedgEntry.IsEmpty() then
                IF (Item."Costing Method" <> xRec."Costing Method") OR (Item."Unit Cost" <> xRec."Unit Cost") OR (Item."Item Tracking Code" <> xRec."Item Tracking Code") THEN
                    Error(Text007, CurrentFieldName);
        END;
        xRec := Item;
        //HEI.20,HEI.22
        //BC Upgrade PATHAA02-xRec needs to be addressed.
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, OnBeforeTestNoPurchLinesExist, '', false, false)]
    local procedure Item_OnBeforeTestNoPurchLinesExist(Item: Record Item; CurrentFieldName: Text[100]; var IsHandled: Boolean)
    var
        PurchaseLine: Record "Purchase Line";
        Text50000: Label 'There are outstanding orders for the item. If you change Strength Method it may affect new orders. Please run the report - Update Strength Specification Code manually.';
    begin
        IsHandled := true;
        PurchaseLine.SetCurrentKey("Document Type", Type, "No.");
        PurchaseLine.SetFilter("Document Type", '%1|%2', PurchaseLine."Document Type"::Order, PurchaseLine."Document Type"::"Return Order");
        PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
        PurchaseLine.SetRange("No.", Item."No.");
        if PurchaseLine.FindFirst() then
            Message(Text50000);
        //HEI.23
        //BC Upgrade PATHAA02
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnCreateDimOnBeforeUpdateLines, '', false, false)]
    local procedure OnCreateDimOnBeforeUpdateLines(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header")
    begin
        //HEI.51>>
        PurchaseHeader.CALCFIELDS("License Code FND");
        IF PurchaseHeader."License Code FND" <> '' THEN;
        // PurchasesUtils.UpdateLicenseCodeDimension(PurchaseHeader."License Code", PurchaseHeader."Dimension Set ID");//BC UPGRADE SHARMP16 Code commented because Codeunit will be compiled differently.
        //HEI.51<<

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnAfterCopyPayToVendorFieldsFromVendor, '', false, false)]
    local procedure OnAfterCopyPayToVendorFieldsFromVendor(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; xPurchaseHeader: Record "Purchase Header")
    begin
        //HEI.54>>
        //"Shipment Method Code" := Vend."Shipment Method Code";
        PurchaseHeader.VALIDATE("Shipment Method Code", Vendor."Shipment Method Code");
        //HEI.54<<

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnCreateDimOnBeforeUpdateLines', '', false, false)]
    local procedure OnCreateDimOnBeforeUpdateLinesHandler(CurrentFieldNo: Integer; DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; OldDimSetID: Integer; var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header")
    var
    //PurchasesUtils: Codeunit CU;//BC UPGRADE SHARMP16 Codeunit will be compiled differently.
    begin
        PurchaseHeader.CalcFields("License Code FND");
        if PurchaseHeader."License Code FND" <> '' then;
        // PurchasesUtils.UpdateLicenseCodeDimension(PurchaseHeader."License Code", PurchaseHeader."Dimension Set ID");//BC UPGRADE SHARMP16 Codeunit will be compiled differently.
    end;

    // BC Upgrade SHARMP16 >>
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInitPostingNoSeries', '', false, false)]
    local procedure PurchaseHeaderOnAfterInitPostingNoSeries(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header")
    var
        PurchSetup: Record "Purchases & Payables Setup";
    //NoSeriesMgt: Codeunit NoSeriesManagement;  // BC Upgrade SHARMP16 - Need to redesign
    begin
        // HEI.19 >>
        // PurchSetup.Get();

        // if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice then begin
        //     //BC UPGRADE SHARMP16 DRINK-IT Field Logic used
        //     PurchSetup.TestField("Expense Claim Subdocument Type");
        //     // if PurchaseHeader."Document Subtype Code" = PurchSetup."Expense Claim CM Subdoc Type" then begin
        //     //     if PurchSetup."Expense Claim Invoices Nos" <> '' then
        //     //         if NoSeriesMgt.IsAutomatic(PurchSetup."Expense Claim Invoices Nos") then
        //     //             PurchaseHeader."Posting No. Series" := PurchSetup."Expense Claim Invoices Nos";
        //     // end else begin
        //     if (PurchaseHeader."No. Series" <> '') AND (PurchSetup."Invoice Nos." = PurchSetup."Posted Invoice Nos.") then
        //         PurchaseHeader."Posting No. Series" := PurchaseHeader."No. Series"
        //     //HEI.47>>
        //     //ELSE
        //     //  NoSeriesMgt.SetDefaultSeries("Posting No. Series",PurchSetup."Posted Invoice Nos.");
        //     ELSE BEGIN
        //         IF (PurchSetup."GR IR Invoice Write off No." <> '') AND (PurchSetup."Posted GRIR Invoice Wrt off No" <> '') THEN BEGIN
        //             IF (PurchaseHeader."No. Series" <> '') AND (PurchaseHeader."No. Series" = PurchSetup."GR IR Invoice Write off No.") THEN
        //                 NoSeriesMgt.SetDefaultSeries(PurchaseHeader."Posting No. Series", PurchSetup."Posted GRIR Invoice Wrt off No")
        //             ELSE
        //                 NoSeriesMgt.SetDefaultSeries(PurchaseHeader."Posting No. Series", PurchSetup."Posted Invoice Nos.");
        //         END ELSE
        //             NoSeriesMgt.SetDefaultSeries(PurchaseHeader."Posting No. Series", PurchSetup."Posted Invoice Nos.");
        //     END;

        //     //HEI.47<<
        //     // HEI.19 <<

        //     //BC UPGRADE SHARMP16 DRINK-IT Field Logic used
        //     if (PurchSetup."Receipt on Invoice") AND (PurchSetup."Posted Receipt Nos." <> '') then
        //         NoSeriesMgt.SetDefaultSeries(PurchaseHeader."Receiving No. Series", PurchSetup."Posted Receipt Nos.");
        //     //HEI.01
        // end;
        // if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo" then begin
        //     //hei.19>>
        //     PurchSetup.TESTFIELD("Expense Claim CM Subdoc Type");
        //     // IF PurchaseHeader."Document Subtype Code" = PurchSetup."Expense Claim CM Subdoc Type" THEN BEGIN
        //     //     NoSeriesMgt.SetDefaultSeries(PurchaseHeader."Posting No. Series", PurchSetup."Expense claim credit memos Nos");
        //     // END ELSE BEGIN//hei.19<<//BC UPGRADE SHARMP16 DRINK-IT Field Logic used
        //     IF (PurchaseHeader."No. Series" <> '') AND
        //        (PurchSetup."Credit Memo Nos." = PurchSetup."Posted Credit Memo Nos.")
        //     THEN
        //         PurchaseHeader."Posting No. Series" := PurchaseHeader."No. Series"
        //     ELSE
        //         NoSeriesMgt.SetDefaultSeries(PurchaseHeader."Posting No. Series", PurchSetup."Posted Credit Memo Nos.");
        //     // END;//hei.19//BC UPGRADE SHARMP16 DRINK-IT Field Logic used
        // end;  // // BC Upgrade SHARMP16 - Blocked due to No SeriesManagement
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnAfterTestNoSeries, '', false, false)]
    local procedure OnAfterTestNoSeriesDocType(PurchSetup: Record "Purchases & Payables Setup"; var PurchHeader: Record "Purchase Header")
    begin
        //HEI.13>>
        if PurchHeader."Document Type" = PurchHeader."Document Type"::Order then begin
            //BC UPGRADE SHARMP16 DRINK-IT Field Logic used
            // if PurchHeader."Document Subtype Code" in [PurchSetup."NPO Prepayment request subtype", PurchSetup."PO Prepayment request Subtype"] then
            //     PurchSetup.TestField("Prepayment Request Nos.")
            // else
            //BC UPGRADE SHARMP16 DRINK-IT Field Logic used
            PurchSetup.TestField("Order Nos.");
        end;
        //HEI.13<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnAfterGetNoSeriesCode, '', false, false)]
    local procedure OnAfterGetNoSeriesCodeDocType(PurchSetup: Record "Purchases & Payables Setup"; var NoSeriesCode: Code[20]; var PurchHeader: Record "Purchase Header")
    begin

        if PurchHeader."Document Type" = PurchHeader."Document Type"::Invoice then begin
            NoSeriesCode := PurchSetup."Invoice Nos.";
            //hei.19>>
            // IF PurchHeader."Document Subtype Code" = PurchSetup."Expense Claim Subdocument Type" THEN BEGIN
            //     PurchSetup.TESTFIELD("Expense Claim Invoices Nos");
            //     NoSeriesCode := PurchSetup."Expense Claim Invoices Nos";
            // END;
            //hei.19<<  //BC UPGRADE SHARMP16 DRINK-IT Field Logic used
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnBeforeValidatePostingDate, '', false, false)]
    local procedure OnBeforeValidatePostingDate(CallingFieldNo: Integer; var IsHandled: Boolean; var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header")
    var
        GLSetup: Record "General Ledger Setup";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        //>>HEI.37
        //BC UPGRADE SHARMP16 Bypass the base logic <<
        // PurchaseHeader.TestField("Posting Date");
        // PurchaseHeader.TestNoSeriesDate(
        //   PurchaseHeader."Posting No.", PurchaseHeader."Posting No. Series",
        //   PurchaseHeader.FieldCaption("Posting No."), PurchaseHeader.FieldCaption("Posting No. Series"));
        // PurchaseHeader.TestNoSeriesDate(
        //   PurchaseHeader."Prepayment No.", PurchaseHeader."Prepayment No. Series",
        //   PurchaseHeader.FieldCaption("Prepayment No."), PurchaseHeader.FieldCaption("Prepayment No. Series"));
        // PurchaseHeader.TestNoSeriesDate(
        //   PurchaseHeader."Prepmt. Cr. Memo No.", PurchaseHeader."Prepmt. Cr. Memo No. Series",
        //   PurchaseHeader.FieldCaption("Prepmt. Cr. Memo No."), PurchaseHeader.FieldCaption("Prepmt. Cr. Memo No. Series"));

        // GLSetup.Get();
        // GLSetup.UpdateVATDate(PurchaseHeader."Posting Date", Enum::"VAT Reporting Date"::"Posting Date", PurchaseHeader."VAT Reporting Date");
        // PurchaseHeader.Validate("VAT Reporting Date");

        // PurchasesPayablesSetup.SetLoadFields("Link Doc. Date To Posting Date");
        // PurchasesPayablesSetup.GetRecordOnce();
        // if PurchaseHeader."Posting Date" <> xPurchaseHeader."Posting Date" then
        // //     if PurchaseHeader.DeferralHeadersExist() then
        // //         PurchaseHeader.ConfirmUpdateDeferralDate();

        // // if PurchaseHeader.PurchLinesExist() then
        // //     PurchaseHeader.JobUpdatePurchLines(SkipJobCurrFactorUpdate);
        // IsHandled := true;
        //BC UPGRADE SHARMP16 Bypass the base logic >>
        //>>HEI.37<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnUpdateCurrencyFactorOnAfterCurrencyDateSet, '', false, false)]
    local procedure OnUpdateCurrencyFactorOnAfterCurrencyDateSet(CurrentFieldNo: Integer; var CurrencyDate: Date; var PurchaseHeader: Record "Purchase Header")
    begin
        //  HEI.37>>
        if PurchaseHeader."Document Date" <> 0D then
            CurrencyDate := PurchaseHeader."Document Date"
        else
            CurrencyDate := WorkDate();
    end;
    //HEI.37<<
    //38 table end>>
    //39 table begin<<
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnAfterShowDimensions, '', false, false)]
    local procedure OnAfterShowDimensions(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line")
    var
    //   CommonItemChrgMgt:Codeunit common 
    begin
        //  CommonItemChrgMgt.UpdateDimFromPurchLine(Rec, "Dimension Set ID", xRec."Dimension Set ID"); //HEI.73 //BC UPGRADE SHARMP16 Code commented because codeunit will be compiled differently.
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnValidateNoOnCopyFromTempPurchLine, '', false, false)]
    local procedure OnValidateNoOnCopyFromTempPurchLinemanualInsert(TempPurchaseLine: Record "Purchase Line" temporary; var IsHandled: Boolean; var PurchLine: Record "Purchase Line"; xPurchLine: Record "Purchase Line")
    begin
        PurchLine."Manual Insert FND" := TempPurchaseLine."Manual Insert FND";//HEI.14
        PurchLine."Astro Unique ID FND" := TempPurchaseLine."Astro Unique ID FND";  //HEI.62
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnAfterGetFAPostingGroup, '', false, false)]
    local procedure OnAfterGetFAPostingGroupDepBook(var PurchaseLine: Record "Purchase Line")
    var
        DepreciationBook: Record "Depreciation Book";
    begin
        //HEI.16>>
        DepreciationBook.RESET();
        DepreciationBook.SETFILTER(Code, '<>%1', PurchaseLine."Depreciation Book Code");
        DepreciationBook.SETRANGE("Part of Duplication List", TRUE);
        IF DepreciationBook.FINDFIRST() THEN BEGIN
            PurchaseLine.VALIDATE("Use Duplication List", DepreciationBook."Part of Duplication List");
        END ELSE
            PurchaseLine.VALIDATE("Use Duplication List", FALSE);
        IF DepreciationBook.GET(PurchaseLine."Depreciation Book Code") THEN;
        //HEI.16<<

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnBeforeUpdatePrepmtSetupFields, '', false, false)]
    local procedure OnBeforeUpdatePrepmtSetupFields(var IsHandled: Boolean; var PurchaseLine: Record "Purchase Line")
    var
        GenPostingSetup: Record "General Posting Setup";  // BC Upgrade sharmp16
        GLAcc2: Record "G/L Account";  // BC Upgrade sharmp16
        VATPostingSetup: Record "VAT Posting Setup";  // BC Upgrade sharmp16
        Text50003: Label 'The Document Type should be Order or Blanket Order';
    begin
        //>>HEI.28
        // IF (PurchaseLine."Document Type" <> PurchaseLine."Document Type"::Order) AND (PurchaseLine."Document Type" <> PurchaseLine."Document Type"::"Blanket Order") THEN
        //     ERROR(Text50003);
        //<<HEI.28
        //BCUpgrade sharmp16--PurchaseProcesstestchanges>>
        //>>HEI.28
        IF (PurchaseLine."Prepayment %" <> 0) AND (PurchaseLine.Type <> PurchaseLine.Type::" ") THEN BEGIN
            IF (PurchaseLine."Document Type" <> PurchaseLine."Document Type"::Order) AND (PurchaseLine."Document Type" <> PurchaseLine."Document Type"::"Blanket Order") THEN
                ERROR(Text50003);
            //<<HEI.28
            PurchaseLine.TESTFIELD("No.");
            IF GenPostingSetup."Purch. Prepayments Account" <> '' THEN BEGIN
                //HEI.17>>
                //GLAcc.GET(GenPostingSetup."Purch. Prepayments Account");
                GLAcc2.GET(GenPostingSetup."Purch. Prepayments Account");
                //HEI.17<<
                // IF NOT VATPostingSetup.GET(PurchaseLine."VAT Bus. Posting Group", GLAcc2."VAT Prod. Posting Group") THEN//HEI.29
                //     ERROR(Text2014410, VATPostingSetup.TABLECAPTION, PurchaseLine."VAT Bus. Posting Group", GLAcc."VAT Prod. Posting Group", Type, "No.");//Sharmp16--Drink-It code.

            end;
            VATPostingSetup.TESTFIELD("VAT Calculation Type", PurchaseLine."VAT Calculation Type");
        END ELSE
            CLEAR(VATPostingSetup);
        PurchaseLine."Prepayment VAT %" := VATPostingSetup."VAT %";
        PurchaseLine."Prepmt. VAT Calc. Type" := VATPostingSetup."VAT Calculation Type";
        PurchaseLine."Prepayment VAT Identifier" := VATPostingSetup."VAT Identifier";
        IF PurchaseLine."Prepmt. VAT Calc. Type" IN
           [PurchaseLine."Prepmt. VAT Calc. Type"::"Reverse Charge VAT", PurchaseLine."Prepmt. VAT Calc. Type"::"Sales Tax"]
        THEN
            PurchaseLine."Prepayment VAT %" := 0;
        PurchaseLine."Prepayment Tax Group Code" := GLAcc."Tax Group Code";
        IsHandled := true;
        //BCUpgrade sharmp16--PurchaseProcesstestchanges<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnInitOutstandingOnBeforeInitOutstandingAmount, '', false, false)]
    local procedure OnInitOutstandingOnBeforeInitOutstandingAmount(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line")
    begin
        //<<HEI.33
        IF PurchaseLine."Completely Received" = TRUE THEN
            IF PurchaseLine."Document Type" <> PurchaseLine."Document Type"::"Blanket Order" THEN //HEI.35
                PurchaseLine."Delivery Finalized FND" := TRUE;
        //>>HEI.33

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnBeforeUpdateItemReference, '', false, false)]
    local procedure OnBeforeUpdateItemReference(var IsHandled: Boolean; var Rec: Record "Purchase Line"; xRec: Record "Purchase Line")
    begin
        // Rec.updateitemCrossRef; //HEI.34
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnAfterInitOutstandingQty, '', false, false)]
    local procedure OnAfterInitOutstandingQty(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line")
    var
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        //>>HEI.37
        PurchSetup.GET();
        IF PurchSetup."Archive Orders" THEN BEGIN
            IF ((PurchaseLine.Quantity - PurchaseLine."Quantity Received") <= PurchaseLine."Tolerance Received Under % FND") AND
                (PurchaseLine."Tolerance Received Under % FND" <> 0) THEN BEGIN
                PurchaseLine."Completely Received" := TRUE;
                PurchaseLine."Delivery Finalized FND" := TRUE;
            END;
        END ELSE begin
            PurchaseLine."Completely Received" := (PurchaseLine.Quantity <> 0) AND (PurchaseLine."Outstanding Quantity" = 0);
        end;
        //SP
        //<<HEI.37

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnCreateDimOnBeforeUpdateGlobalDimFromDimSetID, '', false, false)]
    local procedure OnCreateDimOnBeforeUpdateGlobalDimFromDimSetID(var PurchaseLine: Record "Purchase Line")
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        //HEI.54>>
        IF PurchaseLine."Document Type" IN [PurchaseLine."Document Type"::Order, PurchaseLine."Document Type"::Invoice, PurchaseLine."Document Type"::"Return Order", PurchaseLine."Document Type"::Quote] THEN;//HEI.55
                                                                                                                                                                                                                //IF ("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::"Return Order") OR ("Document Type" = "Document Type"::Quote) OR ("Document Type" = "Document Type"::Invoice) THEN BEGIN//Old Code commented//HEI.55
                                                                                                                                                                                                                //  DimMgt.GetItemNoAndLocation("No.", "Location Code");//BC UPGRADE SHARMP16                                                                                                                                                                                                               //HEI.54<<

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnAfterValidateNoPurchaseLine, '', false, false)]
    local procedure OnAfterValidateNoPurchaseLine(PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; var TempPurchaseLine: Record "Purchase Line" temporary; var xPurchaseLine: Record "Purchase Line")
    var
        PaymentTerms: Record "Payment Terms";
    begin
        //HEI.66>>
        PurchaseLine."Due Date FND" := PurchaseHeader."Due Date";
        IF (PurchaseHeader."Payment Terms Code" <> '') AND (PurchaseLine."Expected Receipt Date" <> 0D) THEN BEGIN
            PaymentTerms.GET(PurchaseHeader."Payment Terms Code");
            PurchaseLine."Estimated Pmt. Due Date FND" := CALCDATE(PaymentTerms."Due Date Calculation", PurchaseLine."Expected Receipt Date");
        END;
        //HEI.66<<

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnBeforeBlanketOrderLookup, '', false, false)]
    local procedure OnBeforeBlanketOrderLookup(CallingFieldNo: Integer; var IsHandled: Boolean; var PurchaseLine: Record "Purchase Line")
    var
        PurchLine2: Record "Purchase Line";
        lPurchLineTmp: Record "Purchase Line" temporary;
        PurchHeader2: Record "Purchase Header";
        lGLSetup: Record "General Ledger Setup";
        lDimensionSetEntry: Record "Dimension Set Entry";
        lDimensionValueCode: Code[20];
        lDimensionValueID: Integer;
        lCurrLineDimensionSetID: Integer;
        lSameBPOLineFound: Boolean;
        lPurchHeader3: Record "Purchase Header";
        lPurchBlanketOrdHdr: Record "Purchase Header";
        lPurchLine2: Record "Purchase Line";
        lPurchLine2Qty: Decimal;
        lText50001: Label 'Do you want to add a new line type: %1 No.: %2 to BPO No. %3?';
        LineNo: Integer;
        lBlanketPurchOrdLines: Record "Purchase Line";
    begin
        //HEI.26>>
        IF PurchaseLine."Blanket Order Line No." <> 0 THEN BEGIN
            PurchLine2.RESET();
            PurchLine2.SETCURRENTKEY("Document Type", Type, "No.");
            PurchLine2.SETRANGE("Document Type", PurchLine2."Document Type"::"Blanket Order");
            IF PurchaseLine."Blanket Order No." <> '' THEN
                PurchLine2.SETRANGE("Document No.", PurchaseLine."Blanket Order No.");
            PurchLine2.SETRANGE("Line No.", PurchaseLine."Blanket Order Line No.");
            IF PurchLine2.FINDFIRST() THEN
                REPEAT
                    lPurchLineTmp.TRANSFERFIELDS(PurchLine2);
                    IF lPurchLineTmp.INSERT() THEN;
                UNTIL PurchLine2.NEXT() = 0;

            IF PAGE.RUNMODAL(PAGE::"Purchase Lines", lPurchLineTmp) = ACTION::LookupOK THEN BEGIN
                lPurchLineTmp.TESTFIELD("Document Type", PurchaseLine."Document Type"::"Blanket Order");
                PurchaseLine."Blanket Order No." := lPurchLineTmp."Document No.";
                PurchaseLine.VALIDATE("Blanket Order Line No.", lPurchLineTmp."Line No.");
            END;
        END;

        IF PurchaseLine."Blanket Order Line No." = 0 THEN BEGIN
            //HEI.26<<
            PurchLine2.RESET();
            PurchLine2.SETCURRENTKEY("Document Type", Type, "No.");
            PurchLine2.SETRANGE("Document Type", PurchaseLine."Document Type"::"Blanket Order");
            //HEI.01>>
            IF PurchaseLine."Blanket Order No." <> '' THEN
                PurchLine2.SETRANGE("Document No.", PurchaseLine."Blanket Order No.");
            //HEI.01<<
            //HEI.26>>
            //PurchLine2.SETRANGE(Type,Type);
            //PurchLine2.SETRANGE("No.","No.");
            //HEI.26<<
            PurchLine2.SETRANGE("Pay-to Vendor No.", PurchaseLine."Pay-to Vendor No.");
            PurchLine2.SETRANGE("Buy-from Vendor No.", PurchaseLine."Buy-from Vendor No.");
            //HEI.10>>
            PurchLine2.SETRANGE("Block Line Ordering FND", PurchaseLine."Block Line Ordering FND"::" ");
            PurchLine2.CALCFIELDS("Valid From FND", "Valid To FND");
            PurchHeader2.GET(PurchaseLine."Document Type", PurchaseLine."Document No.");
            PurchLine2.SETFILTER("Valid From FND", '<=%1', PurchHeader2."Document Date");
            PurchLine2.SETFILTER("Valid To FND", '%1|>=%2', 0D, PurchHeader2."Document Date");
            //HEI.26>>
            PurchLine2.SETRANGE("Currency Code", PurchaseLine."Currency Code");
            //HEI.26<<
            //HEI.10<<
            //HEI.26>>
            // {
            // IF PAGE.RUNMODAL(PAGE::"Purchase Lines", PurchLine2) = ACTION::LookupOK THEN BEGIN
            //             PurchLine2.TESTFIELD("Document Type", "Document Type"::"Blanket Order");
            //             "Blanket Order No." := PurchLine2."Document No.";
            //             VALIDATE("Blanket Order Line No.", PurchLine2."Line No.");
            //         END;
            // }

            lGLSetup.GET();
            lDimensionSetEntry.RESET();
            lDimensionValueCode := '';
            lDimensionValueID := 0;

            lCurrLineDimensionSetID := PurchaseLine."Dimension Set ID";

            lDimensionSetEntry.RESET();
            lDimensionSetEntry.SETRANGE("Dimension Set ID", lCurrLineDimensionSetID);
            lDimensionSetEntry.SETRANGE("Dimension Code", lGLSetup."Shortcut Dimension 5 Code");
            IF lDimensionSetEntry.FINDFIRST() THEN BEGIN
                lDimensionValueCode := lDimensionSetEntry."Dimension Value Code";
                lDimensionValueID := lDimensionSetEntry."Dimension Value ID";
            END;

            lSameBPOLineFound := FALSE;
            IF PurchLine2.FINDFIRST() THEN
                REPEAT
                    lPurchHeader3.GET(PurchLine2."Document Type", PurchLine2."Document No.");
                    IF ((lPurchHeader3."Document Type" = lPurchHeader3."Document Type"::"Blanket Order") AND (NOT lPurchHeader3."Closed FND")) THEN BEGIN //HEI.57
                        lDimensionSetEntry.RESET();
                        IF lDimensionSetEntry.GET(PurchLine2."Dimension Set ID", lGLSetup."Shortcut Dimension 5 Code") THEN
                            IF lDimensionSetEntry."Dimension Value Code" = lDimensionValueCode THEN
                                IF lPurchHeader3."Channel FND" = 'D' THEN BEGIN
                                    lPurchLineTmp.TRANSFERFIELDS(PurchLine2);
                                    IF lCurrLineDimensionSetID <> 0 THEN
                                        IF lPurchLineTmp.INSERT() THEN
                                            IF ((lPurchLineTmp.Type = PurchaseLine.Type) AND (lPurchLineTmp."No." = PurchaseLine."No.")) THEN
                                                lSameBPOLineFound := TRUE;
                                END;
                    END;//HEI.57
                UNTIL PurchLine2.NEXT() = 0;

            IF lSameBPOLineFound = TRUE THEN BEGIN
                lPurchLineTmp.RESET();
                lPurchLineTmp.SETFILTER(Type, '<>%1', PurchaseLine.Type);
                IF lPurchLineTmp.FINDFIRST() THEN
                    lPurchLineTmp.DELETEALL();

                lPurchLineTmp.RESET();
                lPurchLineTmp.SETFILTER(Type, '%1', PurchaseLine.Type);
                lPurchLineTmp.SETFILTER("No.", '<>%1', PurchaseLine."No.");
                lPurchLineTmp.DELETEALL();
            END;

            //HEI.56>>
            COMMIT();
            //HEI.56<<
            lPurchLineTmp.RESET();
            IF PAGE.RUNMODAL(PAGE::"Purchase Lines", lPurchLineTmp) = ACTION::LookupOK THEN BEGIN
                lPurchLineTmp.TESTFIELD("Document Type", PurchaseLine."Document Type"::"Blanket Order");
                lPurchBlanketOrdHdr.GET(lPurchBlanketOrdHdr."Document Type"::"Blanket Order", lPurchLineTmp."Document No.");
                IF ((lPurchLineTmp.Type = PurchaseLine.Type) AND (lPurchLineTmp."No." = PurchaseLine."No.")) THEN BEGIN
                    //lPurchLineTmp.TESTFIELD("Document Type","Document Type"::"Blanket Order");
                    //lPurchBlanketOrdHdr.GET(lPurchBlanketOrdHdr."Document Type"::"Blanket Order",lPurchLineTmp."Document No.");
                    PurchaseLine."Blanket Order No." := lPurchLineTmp."Document No.";
                    PurchaseLine.VALIDATE("Blanket Order Line No.", lPurchLineTmp."Line No.");
                    //HEI.85>>
                    PurchaseLine.MODIFY();
                    //HEI.85<<

                    lPurchLine2.RESET();
                    IF lPurchLine2.GET(lPurchLineTmp."Document Type", lPurchLineTmp."Document No.", lPurchLineTmp."Line No.") THEN BEGIN
                        lPurchLine2Qty := lPurchLineTmp.Quantity;
                        lPurchLine2.VALIDATE(Quantity, lPurchLine2Qty + PurchaseLine.Quantity);
                        lPurchLine2.MODIFY();
                    END;

                    IF PurchaseLine."SRM Contract No. FND" = '' THEN
                        IF (lPurchLineTmp."SRM Contract No. FND" <> '') THEN
                            PurchaseLine."SRM Contract No. FND" := lPurchLineTmp."SRM Contract No. FND"
                        ELSE
                            PurchaseLine."SRM Contract No. FND" := lPurchBlanketOrdHdr."SRM Contract No. FND";
                    IF PurchaseLine."SRM Contract Line No. FND" = '' THEN
                        PurchaseLine."SRM Contract Line No. FND" := lPurchLineTmp."SRM Contract Line No. FND";
                END
                ELSE IF CONFIRM(STRSUBSTNO(lText50001, PurchaseLine.Type, PurchaseLine."No.", lPurchLineTmp."Document No.")) THEN BEGIN
                    LineNo := 10000;
                    lBlanketPurchOrdLines.RESET();
                    lBlanketPurchOrdLines.SETRANGE("Document Type", lBlanketPurchOrdLines."Document Type"::"Blanket Order");
                    lBlanketPurchOrdLines.SETRANGE("Document No.", lPurchBlanketOrdHdr."No.");
                    IF lBlanketPurchOrdLines.FINDLAST() THEN
                        LineNo := lBlanketPurchOrdLines."Line No." + 10000;

                    lBlanketPurchOrdLines.RESET();
                    lBlanketPurchOrdLines.TRANSFERFIELDS(lPurchLineTmp);


                    lBlanketPurchOrdLines."Line No." := LineNo;
                    lBlanketPurchOrdLines.Type := PurchaseLine.Type;
                    lBlanketPurchOrdLines."No." := PurchaseLine."No.";
                    lBlanketPurchOrdLines."Direct Unit Cost" := 0;
                    //HEI.60>>
                    lBlanketPurchOrdLines."Direct Unit Cost" := 0;
                    lBlanketPurchOrdLines."Unit Cost (LCY)" := 0;
                    lBlanketPurchOrdLines."Line Discount %" := 0;
                    lBlanketPurchOrdLines."Line Discount Amount" := 0;
                    lBlanketPurchOrdLines.Amount := 0;
                    lBlanketPurchOrdLines."Amount Including VAT" := 0;
                    lBlanketPurchOrdLines."Unit Price (LCY)" := 0;
                    lBlanketPurchOrdLines."Outstanding Amount" := 0;
                    lBlanketPurchOrdLines."Qty. Rcd. Not Invoiced" := 0;
                    lBlanketPurchOrdLines."Amt. Rcd. Not Invoiced" := 0;
                    lBlanketPurchOrdLines."Quantity Received" := 0;
                    lBlanketPurchOrdLines."Quantity Invoiced" := 0;
                    lBlanketPurchOrdLines."Outstanding Amount (LCY)" := 0;
                    lBlanketPurchOrdLines."Amt. Rcd. Not Invoiced (LCY)" := 0;
                    lBlanketPurchOrdLines."VAT Base Amount" := 0;
                    lBlanketPurchOrdLines."Unit Cost" := 0;
                    lBlanketPurchOrdLines."Line Discount Amount" := 0;
                    lBlanketPurchOrdLines."VAT Difference" := 0;
                    lBlanketPurchOrdLines."Qty. Rcd. Not Invoiced" := 0;
                    lBlanketPurchOrdLines."Line Amount" := 0;
                    lBlanketPurchOrdLines."VAT Difference" := 0;
                    lBlanketPurchOrdLines."Inv. Disc. Amount to Invoice" := 0;
                    lBlanketPurchOrdLines."Outstanding Amt. Ex. VAT (LCY)" := 0;
                    lBlanketPurchOrdLines."A. Rcd. Not Inv. Ex. VAT (LCY)" := 0;
                    lBlanketPurchOrdLines."Bin Code" := '';
                    lBlanketPurchOrdLines."Qty. to Receive" := 0;
                    lBlanketPurchOrdLines."Qty. to Invoice" := 0;
                    lBlanketPurchOrdLines."Qty. to Receive (Base)" := 0;
                    lBlanketPurchOrdLines."Qty. to Invoice (Base)" := 0;
                    lBlanketPurchOrdLines."Qty. Received (Base)" := 0;
                    lBlanketPurchOrdLines."Qty. Rcd. Not Invoiced (Base)" := 0;
                    lBlanketPurchOrdLines."Qty. Received (Base)" := 0;
                    lBlanketPurchOrdLines."Qty. Invoiced (Base)" := 0;
                    lBlanketPurchOrdLines."Invoiced Amount FND" := 0;
                    lBlanketPurchOrdLines."Depreciation Book Code" := PurchaseLine."Depreciation Book Code";
                    lBlanketPurchOrdLines."Unit of Measure Code" := PurchaseLine."Unit of Measure Code";
                    lBlanketPurchOrdLines."Qty. per Unit of Measure" := PurchaseLine."Qty. per Unit of Measure";
                    lBlanketPurchOrdLines."Completely Received" := FALSE;
                    //HEI.60<<
                    //HEi.53 >>
                    //lBlanketPurchOrdLines.Quantity := Quantity + 1;
                    lBlanketPurchOrdLines.VALIDATE(Quantity, PurchaseLine.Quantity + 1);
                    //HEI.53  <<
                    //HEI.60>>
                    lBlanketPurchOrdLines.VALIDATE("Qty. to Receive", lBlanketPurchOrdLines.Quantity);
                    lBlanketPurchOrdLines."Qty. to Receive" := lBlanketPurchOrdLines.Quantity;
                    lBlanketPurchOrdLines."Qty. to Receive (Base)" := lBlanketPurchOrdLines."Quantity (Base)";
                    lBlanketPurchOrdLines.VALIDATE("Qty. to Invoice", lBlanketPurchOrdLines.Quantity);
                    lBlanketPurchOrdLines."Qty. to Invoice" := lBlanketPurchOrdLines.Quantity;
                    lBlanketPurchOrdLines."Qty. to Invoice (Base)" := lBlanketPurchOrdLines."Quantity (Base)";
                    //HEI.60<<
                    IF lBlanketPurchOrdLines.INSERT() THEN;

                    PurchaseLine."Blanket Order No." := lBlanketPurchOrdLines."Document No.";
                    PurchaseLine.VALIDATE("Blanket Order Line No.", lBlanketPurchOrdLines."Line No.");
                    IF PurchaseLine."SRM Contract No. FND" = '' THEN
                        IF (lBlanketPurchOrdLines."SRM Contract No. FND" <> '') THEN
                            PurchaseLine."SRM Contract No. FND" := lBlanketPurchOrdLines."SRM Contract No. FND"
                        ELSE
                            PurchaseLine."SRM Contract No. FND" := lPurchBlanketOrdHdr."SRM Contract No. FND";
                    IF PurchaseLine."SRM Contract Line No. FND" = '' THEN
                        PurchaseLine."SRM Contract Line No. FND" := lBlanketPurchOrdLines."SRM Contract Line No. FND";
                END;
            END;
        END;
        //HEI.26<<
        IsHandled := true;
    end;
    //BC Upgrade SHARMP16 PurchProcesstesting BEGIN>>
    // [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnAfterUpdateAmounts, '', false, false)]
    // local procedure OnAfterUpdateAmounts(CurrFieldNo: Integer; var PurchLine: Record "Purchase Line"; var xPurchLine: Record "Purchase Line")
    // var
    //     Currency: Record Currency;
    // begin
    //     Currency.get(PurchLine."Currency Code");
    //     //HEI.67>>
    //     IF PurchLine."H&S Levy Tax %" <> 0 THEN
    //         PurchLine."Line Amount" :=
    //       ROUND(PurchLine.Quantity * PurchLine."Direct Unit Cost" + PurchLine."H&S Levy Tax Amount", Currency."Amount Rounding Precision") - PurchLine."Line Discount Amount"
    //     //HEI.67<<
    // end;
    // [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnBeforeUpdateLineAmount, '', false, false)]
    // local procedure OnBeforeUpdateLineAmount(Currency: Record Currency; var LineAmountChanged: Boolean; var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; sender: Record "Purchase Line"; var IsHandled: Boolean)
    // var
    //     NonDeductibleVAT: Codeunit "Non-Deductible VAT";
    // begin
    //     if PurchaseLine."Line Amount" <> xPurchaseLine."Line Amount" then begin
    //         PurchaseLine."VAT Difference" := 0;
    //         NonDeductibleVAT.InitNonDeductibleVATDiff(PurchaseLine);
    //         LineAmountChanged := true;
    //     end;
    //     if PurchaseLine."Line Amount" <> Round(PurchaseLine.Quantity * PurchaseLine."Direct Unit Cost", Currency."Amount Rounding Precision") - PurchaseLine."Line Discount Amount" then begin
    //         //HEI.67>>
    //         IF PurchaseLine."H&S Levy Tax % FND" <> 0 THEN
    //             PurchaseLine."Line Amount" :=
    //           ROUND(PurchaseLine.Quantity * PurchaseLine."Direct Unit Cost" + PurchaseLine."H&S Levy Tax Amount FND", Currency."Amount Rounding Precision") - PurchaseLine."Line Discount Amount"
    //         ELSE//HEI.67<<
    //             PurchaseLine."Line Amount" :=
    //               Round(PurchaseLine.Quantity * PurchaseLine."Direct Unit Cost", Currency."Amount Rounding Precision") - PurchaseLine."Line Discount Amount";
    //         PurchaseLine."VAT Difference" := 0;
    //         NonDeductibleVAT.InitNonDeductibleVATDiff(PurchaseLine);
    //         LineAmountChanged := true;
    //     end;
    //     IsHandled := true;
    // end;
    //BC Upgrade SHARMP16 PurchProcesstesting END<<
    // [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnCalcVATAmountLinesOnAfterCalcLineTotals, '', false, false)]
    // local procedure OnCalcVATAmountLinesOnAfterCalcLineTotals(Currency: Record Currency; PurchaseHeader: Record "Purchase Header"; PurchaseLine: Record "Purchase Line"; QtyType: Option; var TotalVATAmount: Decimal)
    // var
    //     PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    // //VATAmountLine: Record "VAT Amount Line";
    // begin
    //     //HEI.67>>
    //     IF (PurchaseLine."Document Type" = PurchaseLine."Document Type"::Invoice) OR (PurchaseLine."Document Type" = PurchaseLine."Document Type"::"Credit Memo") THEN BEGIN
    //         PurchasesPayablesSetup.GET();
    //         IF PurchasesPayablesSetup."H&S Levy Tax FND" THEN;
    //         // VATAmountLine.UpdateLevyTaxAmount("H&S Levy Tax Amount", "H&S Levy Tax %");//BC UPGRADE SHARMP16
    //     END;
    //     //HEI.67<<
    // end;//Bc upgrade YADAVM09 code added in Levy custom codeunit<<

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnBeforeTestStatusOpen, '', false, false)]
    local procedure OnBeforeTestStatusOpen(CallingFieldNo: Integer; var IsHandled: Boolean; var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line")
    begin
        if PurchaseLine."CAD Line FND" = true then
            exit;//BC Upgrade SHARMP16 CAD
        //HEI.83>>
        IF (PurchaseLine.Type IN [PurchaseLine.Type::Item, PurchaseLine.Type::"Fixed Asset", PurchaseLine.Type::"Charge (Item)"]) OR
          ((PurchaseLine.Type = PurchaseLine.Type::"G/L Account") AND
           (CallingFieldNo <> 0)) THEN
            //HEI.83<<
            //PurchHeader.TESTFIELD(Status,PurchHeader.Status::Open);//HEI.39
            //HEI.39>>
            IF (PurchaseLine."Expected Receipt Date" <> xPurchaseLine."Expected Receipt Date") OR (PurchaseLine."Requested Receipt Date" <> xPurchaseLine."Requested Receipt Date") OR (PurchaseLine."Planned Receipt Date" <> xPurchaseLine."Planned Receipt Date") THEN //HEI.39 >>
                EXIT
            //HEI.83>>
            //HEI.83>>
            // {
            // //>>HEI.65
            // ELSE IF ((Rec."Prepayment %" <> xRec."Prepayment %") OR (CurrFieldNo = FIELDNO("Prepayment %")) OR (PurchHeader."Prepayment %" = Rec."Prepayment %")) THEN
            //     EXIT
            // //<<HEI.65
            // }
            ELSE IF ((PurchaseLine."Prepayment %" <> xPurchaseLine."Prepayment %") OR (PurchaseHeader."Prepayment %" <> PurchaseLine."Prepayment %")) THEN
                EXIT
            //HEI.83<<
            ELSE
                PurchaseHeader.TESTFIELD(Status, PurchaseHeader.Status::Open);
        //HEI.39 <<
    end;
    // BC Upgrade SHARMP16 <<
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnBeforeCopyFromItem, '', false, false)]
    local procedure "Purchase Line_OnBeforeCopyFromItem"(var PurchaseLine: Record "Purchase Line"; var Item: Record Item; var IsHandled: Boolean)
    begin
        // 
        Item.BlockedSKU(PurchaseLine."Location Code", PurchaseLine."Variant Code", TRUE);
        //  DITW110.00.11 SFI BL#30569
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnValidateLocationCodeOnBeforeSetInboundWhseHandlingTime, '', false, false)]
    local procedure "Purchase Line_OnValidateLocationCodeOnBeforeSetInboundWhseHandlingTime"(CurrFieldNo: Integer; var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        Item: Record Item;
    begin
        // 
        IF (PurchaseLine.Type = PurchaseLine.Type::Item) THEN BEGIN
            PurchaseLine.GetItem();
            Item.BlockedSKU(PurchaseLine."Location Code", PurchaseLine."Variant Code", TRUE);
        END;
        // DITW110.00.11 SFI BL#30569
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnBeforeUpdateLeadTimeFields, '', false, false)]
    local procedure "Purchase Line_OnBeforeUpdateLeadTimeFields"(var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        Item: Record Item;
    begin
        // 
        IF (PurchaseLine.Type = PurchaseLine.Type::Item) THEN BEGIN
            PurchaseLine.GetItem();
            Item.BlockedSKU(PurchaseLine."Location Code", PurchaseLine."Variant Code", TRUE);
        END;
        //  DITW110.00.11 SFI BL#30569
    end;

    //BC Upgrade GUNREM01 Blocked SKU GAP12_DTW <<

    //--------------------------------------------------BC Upgrade SHARMP16 Table VAT AMount LINE END<<------------------------------------------
    // BC Upgrade BHARDA11 >> ---In the Purchase Line table, there is a function called UpdateVATOnLines.HEI has written CADAmount-related custom code inside this function.That is the reason we have subscribed to this event.--- For "Purchase Line"
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnUpdateVATOnLinesOnBeforeCalcNotFullVATAmount, '', false, false)]
    local procedure OnUpdateVATOnLinesOnBeforeCalcNotFullVATAmount(var PurchaseLine: Record "Purchase Line"; PurchaseHeader: Record "Purchase Header"; var Currency: record Currency; var VATAmountLine: Record "VAT Amount Line"; var TempVATAmountLineRemainder: Record "VAT Amount Line"; NewVATBaseAmount: decimal; VATAmount: decimal; var IsHandled: Boolean)
    begin
        //HEI.51>>
        IF VATPostingSetup2.GET(PurchaseLine."VAT Bus. Posting Group", PurchaseLine."VAT Prod. Posting Group") THEN
            CADAmount := ROUND((VATPostingSetup2."CAD % FND" / 100) * VATAmount, Currency."Amount Rounding Precision");
        //HEI.51<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnUpdateVATOnLinesOnAfterCalculateNewAmount, '', false, false)]
    local procedure OnUpdateVATOnLinesOnAfterCalculateNewAmountPurchase(var PurchaseLine: Record "Purchase Line"; PurchaseHeader: Record "Purchase Header"; VATAmountLine: Record "VAT Amount Line"; VATAmountLineReminder: Record "VAT Amount Line"; var NewAmountIncludingVAT: Decimal; VATAmount: Decimal; var NewAmount: Decimal; var NewVATBaseAmount: Decimal; var CurrentPurchaseLine: Record "Purchase Line")
    var
        Currency: Record Currency;
    begin
        if Currency.Get(PurchaseHeader."Currency Code") then;//Bc Upgrade SHARMP16 GAPFitChanges
        //HEI.51>>
        IF VATPostingSetup2.GET(PurchaseLine."VAT Bus. Posting Group", PurchaseLine."VAT Prod. Posting Group") THEN
            CADAmount := ROUND((VATPostingSetup2."CAD % FND" / 100) * VATAmount, Currency."Amount Rounding Precision");
        //HEI.51<<
    end;

    // [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnUpdateVATOnLinesOnAfterUpdateBaseAmounts, '', false, false)]
    // local procedure OnUpdateVATOnLinesOnAfterUpdateBaseAmounts(var PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var TempVATAmountLineRemainder: Record "VAT Amount Line" temporary; var VATAmountLine: Record "VAT Amount Line"; Currency: Record Currency)
    // begin
    //     PurchLine."CAD Amount FND" := ROUND(CADAmount, Currency."Amount Rounding Precision"); //HEI.51
    // end;
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnUpdateVATOnLinesOnAfterUpdateBaseAmounts, '', false, false)]
    local procedure OnUpdateVATOnLinesOnAfterUpdateBaseAmounts(var PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var TempVATAmountLineRemainder: Record "VAT Amount Line" temporary; var VATAmountLine: Record "VAT Amount Line"; Currency: Record Currency)
    var
        GLSetup: Record "General Ledger Setup";
    begin
        //PurchLine."CAD Amount" := ROUND(CADAmount, Currency."Amount Rounding Precision"); //HEI.51
        //HEI.51 — fix: recompute CAD from this line, never blank a CAD line on release
        GLSetup.Get();
        if not GLSetup."Enable CAD FND" then
            exit;
        if VATPostingSetup2.Get(PurchLine."VAT Bus. Posting Group", PurchLine."VAT Prod. Posting Group") and
           (VATPostingSetup2."CAD % FND" <> 0) and (PurchLine."VAT %" <> 0)
        then
            PurchLine."CAD Amount FND" := Round((VATPostingSetup2."CAD % FND" / 100) * ((PurchLine."VAT %" / 100) * PurchLine."VAT Base Amount"), Currency."Amount Rounding Precision");
        // CAD% = 0 / VAT% = 0 → leave the existing CAD Amount as-is, don't overwrite with a stale global
        //BC Upgrade SHARMP16 CAD
    end;
    // BC Upgrade BHARDA11 << ---In the Purchase Line table, there is a function called UpdateVATOnLines.HEI has written CADAmount-related custom code inside this function.That is the reason we have subscribed to this event.
    // BC Upgrade BHARDA11 >> ---In the Purchase Line table, there is a function called CalcVATAmountLines.HEI has written CADAmount-related custom code inside this function.That is the reason we have subscribed to this event.
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnCalcVATAmountLinesOnAfterCalcLineTotals, '', false, false)]
    local procedure OnCalcVATAmountLinesOnAfterCalcLineTotals1(var VATAmountLine: Record "VAT Amount Line"; PurchaseHeader: Record "Purchase Header"; PurchaseLine: Record "Purchase Line"; Currency: Record Currency; QtyType: Option General,Invoicing,Shipping; var TotalVATAmount: Decimal)
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        //HEI.51>>
        GeneralLedgerSetup.GET();
        IF GeneralLedgerSetup."Enable CAD FND" AND (VATAmountLine."VAT Identifier" <> '') AND (PurchaseLine."CAD Amount FND" <> 0) THEN BEGIN
            IF VATPostingSetup2.GET(PurchaseLine."VAT Bus. Posting Group", PurchaseLine."VAT Prod. Posting Group") THEN;
            VATAmountLine.UpdateCADAmount(PurchaseLine."CAD Amount FND", VATPostingSetup2."CAD % FND", 2);
        END;
    end;
    // BC Upgrade BHARDA11 << ----In the Purchase Line table, there is a function called CalcVATAmountLines.HEI has written CADAmount-related custom code inside this function.That is the reason we have subscribed to this event. --- For "Purchase Line"
    // BC Upgrade BHARDA11 >> ---- These Events are using for CAD Amount Calculation in UpdateVATOnLines function. There are some HEI Code in the function UpdateVATOnLines. --"For Sales Line"
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnUpdateVATOnLinesOnBeforeCalculateNewAmount, '', false, false)]
    local procedure OnUpdateVATOnLinesOnBeforeCalculateNewAmount(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; VATAmountLine: Record "VAT Amount Line"; VATAmountLineReminder: Record "VAT Amount Line"; var NewAmount: Decimal; var VATAmount: Decimal)
    var
        Currency: Record Currency;
    begin
        // Currency.get(SalesHeader."Currency Code");//BC UPGRADE KUMARR78 --
        if Currency.get(SalesHeader."Currency Code") then; //BC UPGRADE KUMARR78 ++
        //HEI.32>>
        IF VATPostingSetup2.GET(SalesLine."VAT Bus. Posting Group", SalesLine."VAT Prod. Posting Group") THEN
            CADAmount1 := ROUND((VATPostingSetup2."CAD % FND" / 100) * VATAmount, Currency."Amount Rounding Precision");
        //HEI.32<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnUpdateVATOnLinesOnAfterCalculateNewAmount, '', false, false)]
    local procedure OnUpdateVATOnLinesOnAfterCalculateNewAmount(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; VATAmountLine: Record "VAT Amount Line"; VATAmountLineReminder: Record "VAT Amount Line"; var NewAmountIncludingVAT: Decimal; VATAmount: Decimal; var NewAmount: Decimal; var NewVATBaseAmount: Decimal)
    var
        Currency: Record Currency;
    begin
        // Currency.get(SalesHeader."Currency Code");//BC UPGRADE KUMARR78 --
        if Currency.get(SalesHeader."Currency Code") then; //BC UPGRADE KUMARR78 ++
        //HEI.32>>
        IF VATPostingSetup2.GET(SalesLine."VAT Bus. Posting Group", SalesLine."VAT Prod. Posting Group") THEN
            CADAmount1 := ROUND((VATPostingSetup2."CAD % FND" / 100) * VATAmount, Currency."Amount Rounding Precision");
        //HEI.32<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnUpdateVATOnLinesOnBeforeModifySalesLine, '', false, false)]
    local procedure OnUpdateVATOnLinesOnBeforeModifySalesLine(var SalesLine: Record "Sales Line"; VATAmount: Decimal)
    var
        Currency: Record Currency;
    begin
        // Currency.Get(SalesLine."Currency Code");//BC UPGRADE KUMARR78 --
        if Currency.Get(SalesLine."Currency Code") then;//BC UPGRADE KUMARR78 ++
        //HEI.32>>
        //"Amount Including VAT" := ROUND(NewAmountIncludingVAT,Currency."Amount Rounding Precision");
        SalesLine."CAD Amount FND" := ROUND(CADAmount1, Currency."Amount Rounding Precision");
        //HEI.32<<
    end;
    // BC Upgrade BHARDA11 << ----These Events are using for CAD Amount Calculation in UpdateVATOnLines function. There are some HEI Code in the function UpdateVATOnLines.

    // BC Upgrade BHARDA11 >> ----These Events are using for CAD Amount Calculation in CalcVATAmountLines function. There are some HEI Code in the function CalcVATAmountLines.
    /* Vat Amount Line Table not Migrated yet. There are some dependency in this Event. 
    For Now we put on Hold only one line code.
    */
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnCalcVATAmountLinesOnAfterCalcLineTotals, '', false, false)]

    local procedure OnCalcVATAmountLinesOnAfterCalcLineTotals2(var VATAmountLine: Record "VAT Amount Line"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; Currency: Record Currency; QtyType: Option General,Invoicing,Shipping; var TotalVATAmount: Decimal; QtyToHandle: Decimal)
    begin
        //HEI.32>>
        IF (VATAmountLine."VAT Identifier" <> '') AND (SalesLine."CAD Amount FND" <> 0) THEN BEGIN
            TotalVATAmount += SalesLine.Amount * SalesLine."VAT %" / 100;
            IF VATPostingSetup2.GET(SalesLine."VAT Bus. Posting Group", SalesLine."VAT Prod. Posting Group") THEN;
            //HEI.35>>
            VATAmountLine.UpdateCADAmount(SalesLine."CAD Amount FND", VATPostingSetup2."CAD % FND", 1); // BC Upgrade BHARDA11 
            //HEI.35<<
        END ELSE
            //HEI.032<<
            TotalVATAmount += SalesLine."Amount Including VAT" - SalesLine.Amount;
    end;
    // BC Upgrade BHARDA11 >> ----These Events are using for CAD Amount Calculation in CalcVATAmountLines function. There are some HEI Code in the function CalcVATAmountLines. --"For Sales Line"
    //-----------------//Bc Upgrade SHARMP16 GAPFitChanges begin<<------------------------------
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'Location Code', false, false)]
    local procedure OnAfterValidateLocationCode(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        Text0041: Label 'Do you want to change %1 on lines ?';
    begin
        if Rec."Location Code" = xRec."Location Code" then
            exit;
        PurchLine.Reset();
        PurchLine.SetRange("Document Type", Rec."Document Type");
        PurchLine.SetRange("Document No.", Rec."No.");
        PurchLine.SetFilter(Type, '<>%1', PurchLine.Type::" ");
        PurchLine.SetFilter("No.", '<>%1', '');
        if not PurchLine.FindFirst() then
            exit;
        if not Confirm(Text0041, false, Rec.FieldCaption("Location Code")) then
            exit;
        if PurchLine.FindSet() then
            repeat
                PurchLine.Validate("Location Code", Rec."Location Code");
                PurchLine.Modify(true);
            until PurchLine.Next() = 0;
    end;
    //-----------------//Bc Upgrade SHARMP16 GAPFitChanges end>>------------------------------

    // Codeunit 427 ICInboxOutboxMgt >>

    // HEI.01 CHG2317685 SAHAL01 17.10.2025 Block Functionality Enhancement for Vendors
    //   # Added Code

    // BC Upgrade PATELS08 >>
    // # Added Tag HEI.01 and related code, made event subscriber for OnBeforeCreateOutboxPurchDocTrans
    // BC Upgrade PATELS08 <<

    // BC Upgrade PATELS08 >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnBeforeCreateOutboxPurchDocTrans', '', false, false)]
    local procedure OnBeforeCreateOutboxPurchDocTrans(PurchaseHeader: Record "Purchase Header"; Rejection: Boolean; Post: Boolean)
    var
        Vendor: Record Vendor;
        PurchasesUtilsL: Codeunit "Purchases-Utils";
    begin
        Vendor.GET(PurchaseHeader."Buy-from Vendor No.");
        //HEI.01>>
        PurchasesUtilsL.CheckBlockedVendorOnDocuments(Vendor, PurchaseHeader);
        //HEI.01<<
    end;
    // BC Upgrade PATELS08 <<


    // Codeunit 427 ICInboxOutboxMgt <<
    var
        GLAcc: Record "G/L Account";
        VATPostingSetup2: Record "VAT Posting Setup";
        CADAmount: Decimal;
        CADAmount1: Decimal;
}