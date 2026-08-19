codeunit 52004 HeinekenBCUpgrade_STP
{

    // BC Upgrade SHUKLP03 >> 97 Codeunit

    // HEI.01 HLSRM03 IBM LAZARE02 02.08.2017
    // # New event publishers: OnBeforeMakeOrder, OnAfterMakeOrderHeader, OnAfterValidateDirectUnitCost, OnBeforeModifyBlanketOrderLine,
    //                       OnAfterMakeOrder, OnAfterInitPurchLine
    // # Use workdate as Posting Date, Document Date, Expected Receipt Date
    // HEI.02 FDD Ethiopia prepayment IBM POSTOI01 04.07.2019 
    // # modify OnRun to update the Document Subtype for Purchase Orders created from Blanket Purch. Order
    // # there are also updated the header fields: "Prepayment %", "Prepmt. Payment Terms Code", "Compress Prepayment","Prepmt. Payment Discount %"

    // HEI.03 FDD-HT1075 CHG2039144 IBM.GUNERE01 15.01.2020 # OnRun func. modified 

    // HEI.04 FDD-HB1076 CHG2046174 IBM SHANKJ03 20.03.2020
    //HEI.05 CHG2317685 SAHAL01 17.10.2025 Block Functionality Enhancement for Vendors # Added Code

    // BC Upgrade PATELP08 >> 
    // # Added HEI.05 Documentation as it was missing when compared to NAV object
    // # Added Block Functionality Enhancement for Vendors as per HEI.05 documentation
    // BC Upgrade PATELP08 <<

    // BC Upgrade SHUKLP03 >>
    // # HEI.01Nav => OnBeforeMakeOrder BC => OnBeforeRun
    // Nav => OnAfterMakeOrderHeader BC => OnBeforePurchOrderHeaderModify
    // Nav custom event OnAfterValidateDirectUnitCost is not added in Nav code.
    // Nav => OnBeforeModifyBlanketOrderLine BC => OnAfterPurchOrderLineInsert
    // Nav => OnAfterMakeOrder BC => OnRunOnBeforeCommit
    // Nav => OnAfterInitPurchLine BC => OnRunOnAfterInitPurchOrderLineFromBlanketOrderLine
    // # HEI.01 => All new event publishers are already present in Business central.
    // # HEI.01 => event OnBeforeUpdatePurchOrderLineDirectUnitCost is subscribed in new codeunit and shared with Sakshi because that code was related to codeunit "SRM Interface Management".
    // # HEI.02 => Code blocked because DrinkIT "Document Subtype Code FND" field is used.
    // # HEI.03 => code is not added because DrinkIT fields "Shipping Agent Code", "Shipping Agent Service Code" and procedure "CreateShippingCost" is used.
    // # HEI.04 => Subscribed event OnBeforeInsertPurchOrderLine.
    // BC Upgrade SHUKLP03 >>

    // BC Upgrade MISHRS14 >>
    // Blocked with statement and prefixed variable with GenJnlLine in procedure - PostUndoFaGlEntry_1
    // Blocked with statement and prefixed variable with GenJnlLine in procedure - PostUndoFaGlEntry_2
    // Blocked with statement and prefixed variable with GenJnlLine in procedure - PostUndoFaGlEntry_3
    // Blocked with statement and prefixed variable with GenJnlLine in procedure - PostUndoFaGlEntry_4
    // Removed false from FINDSET as its being depreceted in procedure - PreviewPostGLOnUndoFixedAssets
    // Chnaged data type from option to enum to remove implicit warning of Global var - GenJnlLineDocType
    // Changed data type from option to enum of parameter DocType due to warning in procedure - PostUndoFaGlEntry_4
    // Changed data type from option to enum of parameter DocType due to warning in procedure - PostUndoFaGlEntry_3
    // Changed data type from option to enum of parameter DocType due to warning in procedure - PostUndoFaGlEntry_2
    // Changed data type from option to enum of parameter DocType due to warning in procedure - PostUndoFaGlEntry_1
    // BC Upgrade MISHRS14 <<
    //-------------------------------BC UPgrade SHARMP16 CU 90----------------------------------
    //Changes in procedures for UndoGRIR and UndoFA case related to testscript changes testing completed.
    //OnBeforeCheckPurchRcptLine,PostUndoFaGlEntry_1,PostUndoFaGlEntry_2,PostUndoFaGlEntry_3,PostUndoFaGlEntry_4,UndoGRIRAccountPayable,SetAllEntries
    //BC UPGRADE ATHUKUS01 FDDSTP_007>>
    //1. Subscribed event OnBeforeOnQueryClosePage of Get Receipt Lines page to handle the logic when user clicks on "OK" or "Lookup OK" button on the page.
    //2. Subscribed event OnBeforeCheckDocumentTotalAmounts for checking document total amounts.
    //BC UPGRADE ATHUKUS01 FDDSTP_007<< 
    //BC UPGRADE ATHUKUS01 FDDSTP_GAP11>>
    //1.Subscribed event OnAfterCreateWhseReceiptHeaderFromWhseRequest of Codeunit "Get Source Doc. Inbound" to update the "Warehouse Rcpt/Shpt No." from the WHS Request.
    //BC UPGRADE ATHUKUS01 FDDSTP_GAP11<<
    // BC Upgrade - RD03 subscribed event to copy and insert the attachments to archive table
    // BC Upgrade - RD03 subscribed event to open the attached attachments from our custom page
    Permissions = tabledata "Purch. Inv. Header" = rimd; // BC Upgrade BHARDA11 ---We added this permission because while posting the prepayment invoice, a permission error was occurring. This error was due to the addition of code related to the Document Subtype Code. We added this code in the OnAfterPurchInvHeaderInsert event:PurchInvHeader.Modify();So, to handle this issue, we added the required permissions.
    [EventSubscriber(ObjectType::Codeunit, 97, OnCreatePurchHeaderOnAfterPurchOrderHeaderInsert, '', false, false)]
    local procedure OnCreatePurchHOnAfterPurchOrderHIns(PurchHeader: Record "Purchase Header"; var PurchOrderHeader: Record "Purchase Header")
    begin
        //HEI.01>>
        PurchOrderHeader.TESTFIELD("Consumption Date FND");
        PurchOrderHeader."Order Date" := PurchHeader."Consumption Date FND";
        PurchOrderHeader."Posting Date" := PurchHeader."Consumption Date FND";
        PurchOrderHeader."Document Date" := PurchHeader."Consumption Date FND";
        PurchOrderHeader."Expected Receipt Date" := PurchHeader."Consumption Date FND";
        PurchOrderHeader."Blanket Order No. FND" := PurchHeader."No.";
        //HEI.01<<
    End;

    [EventSubscriber(ObjectType::Codeunit, 97, OnBeforeInsertPurchOrderLine, '', false, false)]
    local procedure OnBeforeInsertPurchOrderLine_97(var PurchOrderLine: Record "Purchase Line"; PurchOrderHeader: Record "Purchase Header")
    begin
        //HEI.04 >>
        IF (PurchOrderHeader."Consumption Date FND" <> 0D) AND (FORMAT(PurchOrderHeader."Lead Time Calculation") <> '') THEN BEGIN
            PurchOrderLine."Requested Receipt Date" := CALCDATE(PurchOrderHeader."Lead Time Calculation", PurchOrderHeader."Consumption Date FND");
        END;
        //HEI.04 <<
    end;

    [EventSubscriber(ObjectType::Codeunit, 97, OnAfterInsertAllPurchOrderLines, '', false, false)]
    local procedure OnAfterInsertAllPurchOrderLines_97(BlanketOrderPurchHeader: Record "Purchase Header"; OrderPurchHeader: Record "Purchase Header")
    begin
        //>>HEI.02
        // BC Upgrade VAMSIU01 >> Code added for "Document Subtype Code FND" field.
        IF BlanketOrderPurchHeader."Prepayment %" <> 0 then begin
            OrderPurchHeader."Document Subtype Code FND" := PurchSetup."PO Subtype Code FND";
        end;
        OrderPurchHeader."Prepayment %" := BlanketOrderPurchHeader."Prepayment %";
        OrderPurchHeader."Compress Prepayment" := BlanketOrderPurchHeader."Compress Prepayment";
        OrderPurchHeader."Prepmt. Payment Terms Code" := BlanketOrderPurchHeader."Prepmt. Payment Terms Code";
        OrderPurchHeader."Prepmt. Payment Discount %" := BlanketOrderPurchHeader."Prepmt. Payment Discount %";
        OrderPurchHeader.MODIFY();
        //<<HEI.02
    end;

    [EventSubscriber(ObjectType::Codeunit, 97, OnAfterRun, '', false, false)]
    local procedure OnAfterRun_97()
    var
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        //HEI.01>>
        PurchSetup.GET();
        IF PurchSetup."Auto Release Purch. Order FND" THEN;
        //HEI.01<<
    end;

    //BC Upgrade PATELP08 >>
    [EventSubscriber(ObjectType::Codeunit, 97, OnCreatePurchHeaderOnBeforePurchOrderHeaderInitRecord, '', false, false)]
    local procedure CheckBlockedVendorOnDocuments(var PurchOrderHeader: Record "Purchase Header"; var PurchHeader: Record "Purchase Header")
    var
        Vend: Record vendor;
    begin
        Vend.Get(PurchHeader."Buy-from Vendor No.");
        //BC Upgrade PATELP08 >> Added Block Functionality Enhancement for Vendors as per HEI.05 Documentation
        //HEI.05>>
        PurchasesUtils.CheckBlockedVendorOnDocuments(Vend, PurchOrderHeader);
        //HEI.05<<
        //BC Upgrade PATELP08 <<
    end;
    //BC Upgrade PATELP08 <<


    // BC Upgrade SHUKLP03 >> 97 Codeunit

    //BC UPGRADE ATHUKUS01 FDDSTP_007>>
    [EventSubscriber(ObjectType::Page, Page::"Get Receipt Lines", OnBeforeOnQueryClosePage, '', false, false)]
    local procedure OnBeforeOnQueryClosePage(CloseAction: Action; var Result: Boolean; var IsHandled: Boolean)
    var
        PurchRcptLineRec: Record "Purch. Rcpt. Line";
        PaytCode: Code[30];
    begin
        IsHandled := true;
    end;
    //BC UPGRADE ATHUKUS01 FDDSTP_007<<

    //BC UPGRADE ATHUKUS01 FDDSTP_007>> 90 Codeunit
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforeCheckDocumentTotalAmounts, '', false, false)]
    local procedure PurchPost_OnBeforeCheckDocumentTotalAmounts(var Sender: Codeunit "Purch.-Post"; PurchHeader: Record "Purchase Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    var
        PurchSetup: Record "Purchases & Payables Setup";
        TotalPurchaseLine2: Record "Purchase Line";
        VPS: Record "VAT Posting Setup";
        rcVat: Decimal;
        decInvRoundAmount: Decimal;
        Currency: Record Currency;
        InlVATErr: label 'Total amount (%1) is not equal to total of lines (%2)';
        VatErr: Label '%1 (%2) is not equal to total of VAT on lines (%3)';

    begin
        //<<FINXL7.00.001 RBE 06/08/2013 - FINXL10.00 AKH 24/03/2017 NRQ#0
        PurchSetup.Get();
        IF
   (NOT PurchSetup."Check Doc. Total Amounts") OR
   (NOT PurchHeader.Invoice) OR
   (NOT (PurchHeader."Document Type" IN [PurchHeader."Document Type"::Invoice, PurchHeader."Document Type"::"Credit Memo"])) THEN
            EXIT;
        PurchHeader.TESTFIELD(Status, PurchHeader.Status::Released);


        PurchHeader.CALCFIELDS(Amount, "Amount Including VAT");
        //soicad>>
        TotalPurchaseLine2.SETRANGE("Document Type", PurchHeader."Document Type");
        TotalPurchaseLine2.SETRANGE("Document No.", PurchHeader."No.");
        TotalPurchaseLine2.SETRANGE("VAT Calculation Type", TotalPurchaseLine2."VAT Calculation Type"::"Reverse Charge VAT");
        IF TotalPurchaseLine2.FINDSET THEN
            REPEAT
                IF VPS.GET(TotalPurchaseLine2."VAT Bus. Posting Group", TotalPurchaseLine2."VAT Prod. Posting Group") THEN
                    IF VPS."Reverse Charge VAT % FND" <> 0 THEN
                        rcVat += ROUND(ROUND(TotalPurchaseLine2.Amount * VPS."VAT %" / 100)
                           - ROUND(ROUND(TotalPurchaseLine2.Amount * VPS."VAT %" / 100)) * VPS."Reverse Charge VAT % FND" / 100, 0.01);
            UNTIL TotalPurchaseLine2.NEXT = 0;
        PurchHeader."Amount Including VAT" += rcVat;
        //soicad<<
        //VATAmount := TotalPurchaseLine."Amount Including VAT" - TotalPurchaseLine.Amount + rcVat ;
        //TotalPurchaseLine."Amount Including VAT" += rcVat;//soicad
        //soicad<<
        //<< FINXL9.00.000.01 AKH 11/01/2017
        IF PurchHeader."Currency Code" = '' THEN
            Currency.InitRoundingPrecision
        ELSE
            Currency.GET(PurchHeader."Currency Code");

        Currency.TESTFIELD("Invoice Rounding Precision");
        decInvRoundAmount :=
            -ROUND(
              PurchHeader."Amount Including VAT" -
              ROUND(
              PurchHeader."Amount Including VAT",
              Currency."Invoice Rounding Precision",
              Currency.InvoiceRoundingDirection),
              Currency."Amount Rounding Precision");
        IF (PurchHeader."Amount Including VAT" + decInvRoundAmount) <> PurchHeader."Doc. Amount Incl. VAT IBM FND" THEN
            //<< FINXL9.00.000.01 AKH 11/01/2017
            ERROR(InlVATErr, FORMAT(PurchHeader."Doc. Amount Incl. VAT IBM FND"), FORMAT(PurchHeader."Amount Including VAT"));
        IF (PurchHeader."Amount Including VAT" - PurchHeader.Amount) <> PurchHeader."Doc. Amount VAT IBM FND" THEN
            ERROR(
              VatErr, PurchHeader.FIELDCAPTION("Doc. Amount VAT IBM FND"),
              PurchHeader."Doc. Amount VAT IBM FND", PurchHeader."Amount Including VAT" - PurchHeader.Amount);
        //>>FINXL7.00.001 RBE 06/08/2013 - FINXL10.00 AKH 24/03/2017 NRQ#0
        IsHandled := true;
    end;
    //BC Upgrade ATHUKUS01 FDDSTP_007<< 90 Codeunit




    // BC Upgrade SHUKLP03 >> 74 Codeunit

    // HEI.01 FDD-HT594 IBM NASTAA02 07.10.2019 # La Reunion FA Requirements Vendor
    // # New function "CheckFAAcquisition" created 
    // HEI.02 FDD-HB1034 CHG2042112 IBM SHANKJ03 02.07.2020
    // # New Function added PayTermsUpdate
    // HEI.03 FDD-HT2159 - CHG2105031 IBM NASTAA02 05.08.2021 # VAT Centime - Part 2 - Purchases
    // # Code added on 'OnRun'
    // HEI.04 CHG2217161 SAHAL01 02.11.2023 SPL for Returns and GR cancellations

    // BC Upgrade SHUKLP03 >>
    // HEI.01 => function "CheckFAAcquisition" is not found in Navision.
    // HEI.01 => Subscribed events OnBeforeCreateInvLines, OnCreateInvLinesOnBeforeInsertLineIteration and OnAfterInsertLines.
    // HEI.02 => Subscribed event OnBeforeTransferLineToPurchaseDoc.
    // HEI.03 => Subscribed events OnAfterInsertInvoiceLineFromReceiptLine, OnAfterPurchRcptLineSetFilters.
    // HEI.04 => Subscribed event OnAfterInsertInvoiceLineFromReceiptLine to add Code to flow SPL details
    // BC Upgrade SHUKLP03 <<

    var
        FALine: Integer;
        Line2: Integer;

    LOCAL procedure PayTermsUpdate(VAR PurchRcptHdrRec: Record "Purch. Rcpt. Header"; VAR PurchHdrRec_M: Record "Purchase Header")
    var
        PurchaseHdrRec: Record "Purchase Header";
        PurchInvHdrRec: Record "Purchase Header";
        PayTCode: Code[30];
    begin
        // HEI.02 >>
        PurchaseHdrRec.RESET();
        IF PurchaseHdrRec.GET(1, PurchRcptHdrRec."Order No.") THEN BEGIN
            PurchInvHdrRec.RESET();
            IF PurchInvHdrRec.GET(2, PurchHdrRec_M."No.") THEN BEGIN
                PurchInvHdrRec.VALIDATE("Payment Terms Code", PurchaseHdrRec."Payment Terms Code");
                PurchInvHdrRec.MODIFY();
            END;
        END;
        // HEI.02 <<
    end;

    [EventSubscriber(ObjectType::Codeunit, 74, OnBeforeCreateInvLines, '', false, false)]
    local procedure OnBeforeCreateInvLines(var IsHandled: Boolean; var PurchRcptLine: Record "Purch. Rcpt. Line"; var TransferLine: Boolean)
    begin
        //HEI.01>>
        FALine := 0;
        Line2 := 0;
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Codeunit, 74, OnCreateInvLinesOnBeforeInsertLineIteration, '', false, false)]
    local procedure MyProcedure(var PurchRcptLine2: Record "Purch. Rcpt. Line")
    begin
        //HEI.01>>
        IF PurchRcptLine2.Type = PurchRcptLine2.Type::"Fixed Asset" THEN
            FALine += 1
        ELSE
            Line2 += 1;
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Codeunit, 74, OnBeforeTransferLineToPurchaseDoc, '', false, false)]
    local procedure OnBeforeTransferLineToPurchaseDoc(PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchaseHeader: Record "Purchase Header"; var TransferLine: Boolean)
    begin
        // HEI.02 >>
        PayTermsUpdate(PurchRcptHeader, PurchaseHeader);
        // HEI.02 <<
    end;

    [EventSubscriber(ObjectType::Codeunit, 74, OnAfterInsertInvoiceLineFromReceiptLine, '', false, false)]
    local procedure OnAfterInsertInvoiceLineFromReceiptLine(PurchRcptLine2: Record "Purch. Rcpt. Line"; var PurchLine: Record "Purchase Line"; var PurchRcptLine: Record "Purch. Rcpt. Line")
    var
        PurchaseLine: Record "Purchase Line";
    begin
        //HEI.03>>
        IF PurchLine."CAD Attached to Line No. FND" <> 0 THEN BEGIN
            PurchaseLine.SETRANGE("Document Type", PurchLine."Document Type");
            PurchaseLine.SETRANGE("Document No.", PurchLine."Document No.");
            PurchaseLine.SETRANGE("CAD Amount FND", PurchLine."Direct Unit Cost");
            IF PurchaseLine.FINDFIRST() THEN
                IF PurchLine."CAD Attached to Line No. FND" <> PurchaseLine."Line No." THEN BEGIN
                    PurchLine."CAD Attached to Line No. FND" := PurchaseLine."Line No.";
                    PurchLine.MODIFY();
                END;
        END;
        //HEI.03<<
        //HEI.04>>
        PurchLine."SPL Code FND" := PurchRcptLine2."SPL Code FND";
        PurchLine."SPL Name FND" := PurchRcptLine2."SPL Name FND";
        PurchLine.MODIFY(FALSE);
        //HEI.04<<
    end;

    [EventSubscriber(ObjectType::Codeunit, 74, OnAfterInsertLines, '', false, false)]
    local procedure OnAfterInsertLines(var PurchHeader: Record "Purchase Header")
    var
        PurchSetup: Record "Purchases & Payables Setup";
        PurchaseHeader2: Record "Purchase Header";
        FATypeError: TextConst ENU = 'Not all lines have Type Fixed Asset';
    begin
        //HEI.01>>
        IF PurchSetup."Enable FA Vendor Req. FND" THEN BEGIN
            IF (FALine > 0) AND (Line2 > 0) THEN
                ERROR(FATypeError)
            ELSE
                IF FALine > 0 THEN
                    IF PurchaseHeader2.GET(PurchHeader."Document Type", PurchHeader."No.") THEN BEGIN
                        PurchaseHeader2."Fixed Asset Acquisition FND" := TRUE;
                        PurchaseHeader2.MODIFY();
                    END;
        END;
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Codeunit, 74, OnAfterPurchRcptLineSetFilters, '', false, false)]
    local procedure OnAfterPurchRcptLineSetFilters(PurchaseHeader: Record "Purchase Header")
    var
        FinancialUtils: Codeunit "Financial-Utils";
    begin
        FinancialUtils.UpdatePurchaseHeaderAdditional(PurchaseHeader); //HEI.03

    end;

    // BC Upgrade SHUKLP03 << 74 Codeunit



    // BC Upgrade SHUKLP03 >> 96 Codeunit

    // HEI.01 HLSRM03 IBM LAZARE02 03.10.2017 # New event publisher OnAfterMakeOrder
    // HEI.02 FDD-PURGAP027 IBM NASTAA02 12.06.2019 # Maximo POs Approval Flow
    // # Code added to update also Addition Purchase Fields
    // HEI.04 FDD-HT1075 CHG2039144 IBM.GUNERE01 15.01.2020 # OnRun func. modified
    // HEI.05 FDD-HB1076 CHG2046174 IBM SHANKJ03 20.03.2020
    // HEI.06 FDD HT1136 CHG2055070 IBM Shankj03 29.07.2020
    // # Flowing License Code from Quote to Order.
    // HEI.07 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    // # Code added to update LSR Order No
    // HEI.08 CHG2096764 IBM. PANDES01  26.03.2021
    // # Added code for Requesters ID.
    // HEI.10 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # VAT Centime - part 2 - Purchases
    // # Code added
    // HEI.11 CHG2128790 IBM NANDIS01 01.10.2021 - PO Import process issue
    // #Moving the code for HEI.09(missed in A and P)
    // HEI.12 INC3807811 - CHG2133559  IBM NASTAA02 04.11.2021 #CAD calculation on PQ for Maximo
    // # Commented usage of Function "InsertCADAmountLine"
    // HEI.13 CHG2193435 CC CHG2193435 IBM NANDIS01 19.02.2023 # Import PO is incorrectly being interfaced from MAXIMO to Heilite due to a new import process
    // # Bug fix, as system is not taking correct location for import po once its processing via JQ.
    // HEI.14 CHG2227390 HB3558 SRIVAS07 IBM 19.12.2023 # Role-StP call off handler not to create PO from PQ.
    // # Code added in OnRun Trigger()
    // HEI.15 CHG2227390 HB3558 SRIVAS07 IBM 21.12.2023 # Role-StP call off handler not to create PO from PQ.
    // # Code added in OnRun Trigger()
    // HEI.16 CHG2200245 HB3430 SRIVAS07 IBM 02.01.2024 # To block users not to release PQ with no value - Development
    // # Code added in OnRun Trigger()
    // HEI.17 CHG2317685 SAHAL01 17.10.2025 Block Functionality Enhancement for Vendors
    //   # Added Code

    // BC Upgrade SHUKLP03 >>
    // HEI.01 => Nav- OnAfterMakeOrder BC -OnAfterRun
    // HEI.08 code is not added because DrinkIT field "Requester ID" is used.
    // HEI.04 code is not added because DrinkIT fields "Shipping Agent Code","Shipping Agent Service Code" and proceduer CreateShippingCost() are used.
    // BC Upgrade SHUKLP03 <<

    // BC Upgrade PATELS08 >>
    //  # Replaced ID - 96 with 'Codeunit::"Purch.-Quote to Order"' in EventSubscriber attribute for procedures 'OnBeforeRun', 'OnBeforeInsertPurchOrderLine96', 'OnBeforeInsertPurchOrderLine'
    //  # Added Tag HEI.17 to documentation and a new event subscriber 'OnCreatePurchHeaderOnBeforeInitRecord' for the code originally in OnRun() trigger
    //  # Added a local variable 'Vend' in event subscriber 'OnCreatePurchHeaderOnBeforeInitRecord'
    // BC Upgrade PATELS08 <<


    var
        UpdateLines: Boolean;
        PurchSetup: Record "Purchases & Payables Setup";
        FinancialUtils: Codeunit "Financial-Utils";
        UserSetup: Record "User Setup";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        PurchasesUtils: Codeunit "Purchases-Utils";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchaseHeaderAdditionalQuote: Record "Purchase Header Additional FND";
        PQPOError: TextConst ENU = 'You are not allowed to convert Quotation into Order.';
        PQwithNoValue: TextConst ENU = 'There is some line with no value in PQ, its cannot be converted into PO.';


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", OnBeforeRun, '', false, false)]
    local procedure OnBeforeRun(var PurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader.TESTFIELD("Document Type", PurchaseHeader."Document Type"::Quote);
        //HEI.16>>
        IF NOT PurchasesUtils.PQtoPOConditionCheck(PurchaseHeader) OR NOT (PurchaseHeader.PurchLinesExist()) THEN
            ERROR(PQwithNoValue);
        //HEI.16<<
        //HEI.14>>
        PurchasesPayablesSetup.GET();
        IF PurchasesPayablesSetup."Enable PQ to PO check FND" THEN BEGIN
            UserSetup.GET(USERID);
            //HEI.15>>
            //IF UserSetup."Make PQ to PO" THEN
            IF NOT UserSetup."Make PQ to PO FND" THEN
                //HEI.15<<
                ERROR(PQPOError);
        END;
        //HEI.14<<
    end;
    // //BC UPG Moved to interface
    //     [EventSubscriber(ObjectType::Codeunit, 96, OnCreatePurchHeaderOnAfterPurchOrderHeaderInsert, '', false, false)]
    //     local procedure OnCreatePurchHeaderOnAfterPurchOrderHeaderInsert(BlanketOrderPurchHeader: Record "Purchase Header"; var PurchOrderHeader: Record "Purchase Header")
    //     begin
    //         //HEI.02>>
    //         IF PurchaseHeaderAdditional.GET(PurchOrderHeader."Document Type", PurchOrderHeader."No.") THEN BEGIN
    //             //Rec.CALCFIELDS("House Number");  //Commented by HEI.07
    //             //HEI.07<<
    //             BlanketOrderPurchHeader.CALCFIELDS("House Number", "PQ Approver", "LSR Order No.");
    //             PurchaseHeaderAdditional."LSR Order No" := BlanketOrderPurchHeader."LSR Order No.";
    //             //HEI.07>>
    //             PurchaseHeaderAdditional."PQ Approver" := BlanketOrderPurchHeader."PQ Approver";
    //             //HEI.06 >>
    //             BlanketOrderPurchHeader.CALCFIELDS("License Code", "House Number");
    //             PurchaseHeaderAdditional."License Code" := BlanketOrderPurchHeader."License Code";
    //             PurchaseHeaderAdditional."House Number" := BlanketOrderPurchHeader."House Number";
    //             //HEI.06 <<
    //             //HEI.10>>
    //             IF PurchaseHeaderAdditionalQuote.GET(BlanketOrderPurchHeader."Document Type", BlanketOrderPurchHeader."No.") THEN
    //                 PurchaseHeaderAdditional."Region Code" := PurchaseHeaderAdditionalQuote."Region Code";
    //             //HEI.10<<
    //             PurchaseHeaderAdditional.MODIFY(TRUE);
    //         END;
    //         //HEI.02<<

    //         //HEI.11>>
    //         //>>HEI.09
    //         IF PurchaseHeaderAdditional."Import Identifier" = TRUE THEN BEGIN
    //             //IF GUIALLOWED THEN BEGIN  //HEI.13
    //             UpdateLines := TRUE
    //             //END;  //HEI.13
    //         END;
    //         //<<HEI.09
    //         //HEI.11<<
    //     end;
    // //BC UPG Moved to interface
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", OnBeforeInsertPurchOrderLine, '', false, false)]
    local procedure OnBeforeInsertPurchOrderLine96(var PurchOrderLine: Record "Purchase Line"; PurchOrderHeader: Record "Purchase Header")
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";//BC Upgrade SHARMP16--ProcessChanges
    begin
        PurchSetup.get();
        //HEI.11>>
        //>> HEI.09
        if PurchaseHeaderAdditional.get(PurchOrderHeader."Document Type", PurchOrderHeader."No.") then begin //BC Upgrade SHARMP16--BugFix

            IF PurchaseHeaderAdditional."Import Identifier" = TRUE THEN BEGIN
                // IF UpdateLines THEN//BC Upgrade SHARMP16--ProcessChanges
                IF PurchOrderLine.Type = PurchOrderLine.Type::Item THEN
                    PurchOrderLine."Location Code" := PurchSetup."Location Code Imp Proc. FND";
            END;
            //<< HEI.09
            //HEI.11<<
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", OnBeforeInsertPurchOrderLine, '', false, false)]
    local procedure OnBeforeInsertPurchOrderLine(PurchOrderHeader: Record "Purchase Header"; var PurchOrderLine: Record "Purchase Line")
    begin
        //HEI.05 >>
        IF (PurchOrderHeader."Order Date" <> 0D) AND (FORMAT(PurchOrderHeader."Lead Time Calculation") <> '') THEN BEGIN
            PurchOrderLine."Requested Receipt Date" := CALCDATE(PurchOrderHeader."Lead Time Calculation", PurchOrderHeader."Order Date");
        END;
        //HEI.05 <<
    end;

    // BC Upgrade PATELS08 >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", OnCreatePurchHeaderOnBeforeInitRecord, '', false, false)]
    local procedure OnCreatePurchHeaderOnBeforeInitRecord(var PurchOrderHeader: Record "Purchase Header"; var PurchHeader: Record "Purchase Header")
    var
        Vend: Record Vendor; // BC Upgrade PATELS08
    begin
        Vend.GET(PurchOrderHeader."Buy-from Vendor No."); // BC Upgrade PATELS08
        // HEI.17 >> 
        PurchasesUtils.CheckBlockedVendorOnDocuments(Vend, PurchOrderHeader);
        // HEI.17 << 
    end;
    // BC Upgrade PATELS08 <<

    // BC Upgrade SHUKLP03 << 96 Codeunit

    // BC Upgrade SHUKLP03 >> The function OnApproveApprovalRequests, originally from Codeunit 1535 – Approvals Mgmt., is written in the Heineken STP extension under Codeunit 52004 – HeinekenBCUpgrade_STP.
    //All custom code is generally written in HeinekenBCUpgrade Codeunit in Heineken_General extension, but this function is written here only due to PurchasesUtils Codeunit dependency.
    var
        g_CU_PurchasesUtils: Codeunit "Purchases-Utils";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnApproveApprovalRequest, '', false, false)]
    local procedure OnApproveApprovalRequests(var ApprovalEntry: Record "Approval Entry")
    var
        lrec_PurchHdr: Record "Purchase Header";
    begin
        //HEI.15>>
        IF (ApprovalEntry."Table ID" = 38) AND (ApprovalEntry."Document Type" IN [ApprovalEntry."Document Type"::Order]) THEN BEGIN
            IF lrec_PurchHdr.GET(ApprovalEntry."Document Type"::Order, ApprovalEntry."Document No.") THEN
                g_CU_PurchasesUtils.ManageTOfromPO(lrec_PurchHdr);
        END;
        //HEI.15<<
    end;
    // BC Upgrade SHUKLP03 >> The function OnApproveApprovalRequests, originally from Codeunit 1535 – Approvals Mgmt., is written in the Heineken STP extension under Codeunit 52004 – HeinekenBCUpgrade_STP.
    //All custom code is generally written in HeinekenBCUpgrade Codeunit in Heineken_General extension, but this function is written here only due to PurchasesUtils Codeunit dependency.

    //BC Upgrade GUNREM01 >> Codeunit -5813- "Undo Purchase Receipt Line'

    //     DITW15.00.00.16 DDR 27/03/2008 Added Drink-it Undo Item Charges functionnalities
    //                                added function UndoItemChargeAssgnt(),CountPurchItemChargeAssgntLine()
    // DITW15.00.00.23 DDR 22/07/2008 Include undo of Discount/Promotion and any Charge type Lines
    //                     12/08/2008 Certification Rules
    //                                  Remove local variable lrPurchRcptLine2 (function UndoItemChargeAssgnt)
    // DITW15.00.00.24 DDR 19/09/2008 Include all item charge types attached to main item
    // DITW15.00.00.28 DDR 28/11/2008 Avoid undo when AAD document has been created.
    // DITW15.00.00.33 DDR 08/05/2009 Added field "Duty Suspended"
    // DITW15.00.00.34 DDR 10/06/2009 Added field "Periodic Disc.-Promo Entry No."
    // DITW15.00.00.35 DDR 29/07/2009 Added fields
    //                                  "Gen. Prod. Posting Free Group","Free Item Posting Type","Free Item",
    //                                  "Free Calculation Type","Include Free Qty. in Minimum";
    //                     07/08/2009 issue 756 Added undo (due) tax item charges posted into G/L entries when duty point shipment
    //                                          Added check if AAD is already created (printed)
    //                                          Added fields "Tax Formula","tariff no.";
    // DITW15.00.00.37 DDR 01/03/2010 issue 1089 Bugfix Invoiced qty item charges after the undo.
    //                                           Bugfix item (promotion) with quantity zero
    //                                           Bugfix the quantity assigned is not undone for exise item charges into Order documents.
    //                                           Bugfix insert new undo item charge lines (per order)
    // DITW15.00.00.38 DDR 11/10/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                           Added to reverse "Unsatisfactory Quantity"
    //                     19/10/2010 issue 1237 Bugfix undo lines when an item line has more one item tracking line
    //                     19/11/2010 issue 1139 SSCC Functionnalities
    //                                           Added codeunit 'Permissions' property for
    //                                             table2035045 SSCC Entry Relation
    //                                             table2035047 Whse. SSCC Entry Relation
    //                     03/12/2010 issue 1229 Added to undo the posted due taxes
    //                     17/12/2010 issue 703 Added fields "Tax Item No."
    // DITW15.00.00.39 DDR 23/06/2011 issue 1350 Bugfix to undo (free) item as item charge lines
    //                                           Bugfix merge function InsertNewReceiptLine()
    //                     28/06/2011 issue 1375 Allowed to undo item promotion (posted seperately of linked item
    //                                           Bugfix to skip check item entries with shipment lines when quantity zero
    // DITW15.00.00.40 DDR 17/11/2011 issue 1463 Modified text constant Text001 (NLB caption)
    // DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 Added field "Allow VAT Calculation (Free)"
    //                     11/05/2012 DIT-715 #344 Bugfix to call function UpdateItemChargeAssgnt()
    // DITW16.00.00.43 DDR 08/11/2013 DIT-715 #752 Extended SSCC non-Specific
    //                 DDR 13/11/2013 DIT-715 #753 Bugfix to insert the full undo item lines and charges (if more than 10 attached lines)
    //                 DDR 18/11/2013 DIT-715 #752 Bugfix to undo item charge with item/sscc tracking

    // DITW17.00.02 DDR 08/11/2013 DIT-715 #752 Merge
    //              DDR 13/11/2013 DIT-715 #753 Merge
    // DITW17.00.02 DDR 18/11/2013 DIT-715 #752 Merge
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.05 DDR 19/08/2014 DIT-770 #776 Added Deposit point functionality
    // DITW19.00.07 MVN 30/12/2015 DIT-770 #001 Upgrade - Added Global Codeunit ItemJnlPostLIne

    // DITW110.00.09 DDR 10/04/2017 NRQ#13065 Fix EMCS undo EDI outbox IE818
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.10 MSF 08/06/2017 NRQ#18228 Impossible to do UNDO Shipment
    // DITW110.00.10 MSF 27/06/2017 NRQ#18228 Undo Purchase receipt line Create too much values entries
    //                                        Rename variable Saleshipmentline to FromPurchRcptLine in Function GetLineValueEntries

    // HEI.01 HLSRM05 IBM LAZARE02 31.08.2017 # Enable undo receipt for G/L accounts and item charges
    // HEI.02 DefectID 442 HORTOC01 24.10.2017 # code added
    // FINXL11.00 HBA 03/05/2018 NRQ#69018 : Added event publisher OnBeforeUndoPurchReceiptLine(), OnAfterUndoPurchReceiptLine()
    // DITW111.00.13A NLAB 25/06/2019 NRQ#113801 : Merge NRQ#69018
    // HEI.03 CHG2201773 HB3442 SRIVAS07 IBM 27/11/23 - Development - Undoing a Goods Receipt for Fixed Asset
    //    Code added to those functions which listed below -
    //      #OnRun
    //      #Code
    //    Created new fucntions
    //      #PostGLOnUndoFixedAssets
    //      #PostUndoFaGlEntry_1
    //      #PostUndoFaGlEntry_2
    //      #PostUndoFaGlEntry_3
    //      #PostUndoFaGlEntry_4
    //      #GetFaLedgerEntryCost
    //      #GetFABatch
    //      #GetFATemplate
    //      #GetLastLineNo
    //      #GetFABatch2
    //      #GetFATemplate2
    //      #UndoGRIRAccountPayable
    //      #SetAllEntries
    //      #TransferGLEntry
    // HEI.04 CHG2201773 HB3442 SRIVAS07 IBM 06/12/23 - Development - Undoing a Goods Receipt for Fixed Asset
    //      # Added code in InsertNewReceiptLine()
    //      # Added code in PostGLOnUndoFixedAssets()
    //      # Added code in PostUndoFaGlEntry_1
    //      # Added code in PostUndoFaGlEntry_2
    //      # Added code in PostUndoFaGlEntry_3
    //      # Added code in PostUndoFaGlEntry_4
    // HEI.05 CHG2201773 HB3442 SRIVAS07 IBM 08/12/23 - Development - Undoing a Goods Receipt for Fixed Asset
    //      # Added code in InsertNewReceiptLine()
    // HEI.06 CHG2201773 HB3442 SRIVAS07 IBM 18/03/24 # Development - Undoing a Goods Receipt for Fixed Asset
    //      # Created a new function SetPreviewUndo()
    //      # Created a new function PreviewPostGLOnUndoFixedAssets()
    //      # Added code in Code()
    // HEI.07 CHG2201773 HB3442 SRIVAS07 IBM 20/03/24 # Development - Undoing a Goods Receipt for Fixed Asset
    //      # Added Code in PostGLOnUndoFixedAssets().
    // HEI.08 CHG2210794 SAHAL01 23.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Modified Property of this Function - PreviewPostGLOnUndoFixedAssets from Local to Global.
    // HEI.09 CHG2251877 MAJUMS03 03.07.2024 Warehouse Receipt Lines creation issue
    //   # Code added under "UpdateOrderLine" function to proper update of "Delivery Finalized" field in Purchase Line table during Undo
    //     Purchase Receipt Line operation.
    // HEI.10 CHG2251877 MAJUMS03 17.07.2024 Warehouse Receipt Lines creation issue.
    //   # Code commented done against HEI.09.
    // HEI.11 CHG2210794 SAHAL01 15.10.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added Code
    // HEI.12 CHG2278614 SAHAL01 27.11.2024 E2E test for Zycus HL integration
    //   # Added Code
    // HEI.13 CHG2278883 IBM ADHIKG01 18.03.2025 Create Document Shipping Cost table - Static performance
    //   # Aptean Fix
    //   # NRQ#251610 DDR 07/03/2025 Add undo shipping costs
    //     

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", OnBeforeOnRun, '', false, false)]
    procedure UndoPurchaseonbeforerun(var PurchRcptLine: Record "Purch. Rcpt. Line"; var IsHandled: Boolean; var SkipTypeCheck: Boolean; var HideDialog: Boolean)
    begin
        //HEI.01>>
        //old code: SETRANGE(Type,Type::Item);
        //HEI.03>>
        //SETFILTER(Type,'%1|%2|%3',Type::Item,Type::"G/L Account",Type::"Charge (Item)");
        PurchRcptLine.SETFILTER(Type, '%1|%2|%3|%4', PurchRcptLine.Type::Item, PurchRcptLine.Type::"G/L Account", PurchRcptLine.Type::"Charge (Item)", PurchRcptLine.Type::"Fixed Asset");
        //HEI.03<<
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", OnBeforeCheckPurchRcptLine, '', false, false)]
    procedure OnBeforeCheckPurchRcptLine(var PurchRcptLine: Record "Purch. Rcpt. Line"; var TempItemLedgerEntry: Record "Item Ledger Entry" temporary; var IsHandled: Boolean)
    var
        Text004: Label 'This receipt has already been invoiced. Undo Receipt can be applied only to posted, but not invoiced receipts.';
        FADepBook: Record "FA Depreciation Book";
        DepBook: Record "Depreciation Book";
        PurchLineCopy: Record "Purch. Rcpt. Line";
        ReturnAmtLCY: Decimal;
        PurchRcptHeader: Record "Purch. Rcpt. Header";
    begin

        //HEI.01>>
        IF PurchRcptLine.Type IN [PurchRcptLine.Type::"G/L Account", PurchRcptLine.Type::"Charge (Item)"] THEN BEGIN
            IF PurchRcptLine."Qty. Rcd. Not Invoiced" <> PurchRcptLine.Quantity THEN
                ERROR(Text004)
        END ELSE
            //HEI.03>>

            IF PurchRcptLine.Type = PurchRcptLine.Type::"Fixed Asset" THEN BEGIN
                Clear(ReturnAmtLCY);
                IF PurchRcptLine."Qty. Rcd. Not Invoiced" <> PurchRcptLine.Quantity THEN
                    ERROR(Text004);
                ReturnAmtLCY := PurchRcptLine.Quantity * PurchRcptLine."Unit Cost (LCY)";
                DepBook.RESET;
                IF DepBook.FINDFIRST THEN BEGIN

                    //HEI.12>>
                    FADepBook.SETCURRENTKEY("FA No.", "Depreciation Book Code");
                    FADepBook.SETRANGE("FA No.", PurchRcptLine."No.");
                    FADepBook.SETRANGE("Depreciation Book Code", DepBook.Code);
                    IF FADepBook.FINDFIRST THEN BEGIN
                        FADepBook.CalcFields("Book Value");
                        if FADepBook."Book Value" < ReturnAmtLCY then
                            Error('For fixed asset %1 and depr book code %2. The current book value is %3 which is lesser than return amount %4', FADepBook."FA No.", FADepBook."Depreciation Book Code", FADepBook."Book Value", ReturnAmtLCY);
                    end;
                end;
            end;


        //HEI.03<<
        //HEI.01<<





    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", OnAfterInsertNewReceiptLine, '', false, false)]
    local procedure OnAfterInsertNewReceiptLine(PostedWhseReceiptLine: Record "Posted Whse. Receipt Line"; var PostedWhseRcptLine: Record "Posted Whse. Receipt Line"; var PostedWhseRcptLineFound: Boolean; var PurchRcptLine: Record "Purch. Rcpt. Line")
    begin
        IF PurchRcptLine.Type = PurchRcptLine.Type::"Fixed Asset" THEN BEGIN
            IF UndoPreviewGR THEN //HEI.06
                // PreviewPostGLOnUndoFixedAssets(PurchRcptLine) //HEI.06
                                PreviewPostGLOnUndoFixedAssets(PurchRcptLine)//BC Upgrade SHARMP16--ProcessChanges
            ELSE begin//HEI.06
                PostGLOnUndoFixedAssets(PurchRcptLine);//BC Upgrade SHARMP16
                //UndoGRIRAccountPayable(PurchRcptLine);//HEI.04 //BC Upgrade SHARMP16 move logic to different event
            end;

        end;
    end;
    //BC Upgrade SHARMP16 BEGIN<<
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", OnAfterCode, '', false, false)]
    local procedure OnAfterCode(var PurchRcptLine: Record "Purch. Rcpt. Line"; var UndoPostingManagement: Codeunit "Undo Posting Management")
    var
        PurchRcptLine2: Record "Purch. Rcpt. Line";
    begin
        PurchRcptLine2.Reset();
        PurchRcptLine2.SetRange("Document No.", PurchRcptLine."Document No.");
        PurchRcptLine2.SetRange(Type, PurchRcptLine.Type::"Fixed Asset");
        PurchRcptLine2.SetRange(Correction, true);
        PurchRcptLine2.SetFilter(Quantity, '>%1', 0);
        if PurchRcptLine2.FindFirst() then begin
            repeat
                //BC  Upgrade SHARMP16
                if GLEntryApplicationBuffer.FindFirst() then
                    GLEntryApplicationBuffer.DeleteAll();
                //BC  Upgrade SHARMP16
                UndoGRIRAccountPayable(PurchRcptLine2);
            until PurchRcptLine2.Next() = 0;
        end;
    end;
    //BC Upgrade SHARMP16 END>>
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", OnAfterNewPurchRcptLineInsert, '', false, false)]
    // local procedure OnAfterNewPurchRcptLineInsert(OldPurchRcptLine: Record "Purch. Rcpt. Line"; var NewPurchRcptLine: Record "Purch. Rcpt. Line"; var SkipInsertItemEntryRelation: Boolean; var TempGlobalItemEntryRelation: Record "Item Entry Relation" temporary)
    // begin
    //     IF (NewPurchRcptLine.Type = NewPurchRcptLine.Type::"Fixed Asset") and (NewPurchRcptLine.Quantity <> 0) THEN //HEI.05
    //         UndoGRIRAccountPayable(OldPurchRcptLine);//HEI.04
    // END;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", OnUpdateOrderLineOnBeforeUpdatePurchLine, '', false, false)]
    local procedure "Undo Purchase Receipt Line_OnUpdateOrderLineOnBeforeUpdatePurchLine"(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchaseLine: Record "Purchase Line")
    var
        PurchLine: Record "Purchase Line";
        PurchaseHeaderAddL: Record "Purchase Header Additional FND";
    begin
        //HEI.02>>
        IF (PurchLine."SRM Order Line No. FND" <> '') AND (PurchLine."SRM Order No. FND" <> '') AND
           (PurchLine."Document Type" = PurchLine."Document Type"::Order)
        THEN
            //HEI.11>>
            PurchaseHeaderAddL.GET(PurchLine."Document Type", PurchLine."Document No.");
        IF PurchaseHeaderAddL."Limit PO" THEN;
        //HEI.11<<
        //   PurchLine."Remaining Amount" := PurchLine."Remaining Amount" + PurchRcptLine."Line Amount"; //BC Upgrade GUNREM01 Line Amount Field is DIT Field.
        //HEI.02<<
        //HEI.10>>
        //   {
        //   //HEI.09>>
        //   IF PurchLine.Type <> PurchLine.Type::"Charge (Item)" THEN BEGIN
        //     PurchLine."Delivery Finalized" := TRUE;
        //     PurchLine.MODIFY;
        //   END;
        //   //HEI.09<<
        //   }
        //HEI.10<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", OnCodeOnBeforeLoopPurchRcptLine, '', false, false)]
    procedure OnCodeOnBeforeLoopPurchRcptLine(var PurchRcptLine: Record "Purch. Rcpt. Line")
    var

    begin
        IF UndoPreviewGR = FALSE THEN BEGIN //HEI.06
            PurchRcptLine.FIND('-');
        end;
    end;

    LOCAL procedure PostGLOnUndoFixedAssets(VAR PurchRcptLine: Record "Purch. Rcpt. Line")
    var
        GenJournalLine: Record "Gen. Journal Line";
        FAJnlSetup: Record "FA Journal Setup";
        DeprBook: Record "Depreciation Book";
        PurchRcptHeader2: Record "Purch. Rcpt. Header";
        PurchReceiptHeader: Record "Purch. Rcpt. Header";
        TotalPurchLine: Record "Purchase Line";
        TotalPurchLineLCY: Record "Purchase Line";
        SrcCodeCode: Code[10];
        TotalFAPurchLine: Record "Purchase Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        SourceCodeSetup: Record "Source Code Setup";
        GenJnlLine: Record "Gen. Journal Line";
        FADepreciationBookL: Record "FA Depreciation Book";
    begin
        //HEI.04>>
        DeprBook.RESET;
        DeprBook.SETRANGE("Part of Duplication List", TRUE);
        IF DeprBook.FINDFIRST THEN BEGIN
            GenJnlLine.RESET;
            GenJnlLine.SETRANGE("Document Type", GenJnlLine."Document Type"::"Purchase Receipt");
            GenJnlLine.SETRANGE("Document No.", PurchRcptLine."Document No.");
            GenJnlLine.SETRANGE("Undo FA Receipt FND", TRUE);
            GenJnlLine.SETFILTER("Journal Template Name", '<>%1', GetFATemplate2(DeprBook.Code));
            GenJnlLine.SETFILTER("Journal Batch Name", '<>%1', GetFABatch2(DeprBook.Code));
            IF GenJnlLine.FINDSET THEN
                GenJnlLine.DELETEALL; //Deleting un-posted local book line
        END;
        //HEI.04<<
        //HEI.03>>

        TotalPurchLine.GET(TotalPurchLine."Document Type"::Order, PurchRcptLine."Order No.", PurchRcptLine."Order Line No.");
        PurchReceiptHeader.GET(PurchRcptLine."Document No.");
        GenJnlLineDocType := GenJournalLine."Document Type"::"Purchase Receipt";
        GenJnlLineDocNo := PurchRcptLine."Document No.";
        GenJnlLineExtDocNo := PurchReceiptHeader."Vendor Order No.";
        PostUndoFaGlEntry_1(
            PurchReceiptHeader, PurchRcptLine, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, PurchReceiptHeader."Source Code", TotalFAPurchLine);
        PostUndoFaGlEntry_2(
            PurchReceiptHeader, PurchRcptLine, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, PurchReceiptHeader."Source Code", TotalFAPurchLine);

        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", GetFATemplate(PurchRcptLine."Depreciation Book Code"));
        GenJournalLine.SETRANGE("Journal Batch Name", GetFABatch(PurchRcptLine."Depreciation Book Code"));
        GenJournalLine.SETRANGE("Document Type", GenJournalLine."Document Type"::"Purchase Receipt");
        GenJournalLine.SETRANGE("Document No.", PurchRcptLine."Document No.");
        GenJournalLine.FINDSET;
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);

        //------------------------------------------------------Local Close

        DeprBook.RESET;
        DeprBook.SETRANGE("Part of Duplication List", TRUE);
        IF DeprBook.FINDFIRST THEN BEGIN
            //HEI.12>>
            FADepreciationBookL.SETCURRENTKEY("FA No.", "Depreciation Book Code");
            FADepreciationBookL.SETRANGE("FA No.", PurchRcptLine."No.");
            FADepreciationBookL.SETRANGE("Depreciation Book Code", DeprBook.Code);
            IF FADepreciationBookL.FINDFIRST THEN BEGIN
                //HEI.12<<
                //Source
                SourceCodeSetup.GET;
                PostUndoFaGlEntry_3(
                  PurchReceiptHeader, PurchRcptLine, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, SourceCodeSetup."Fixed Asset G/L Journal", TotalFAPurchLine, DeprBook.Code);
                PostUndoFaGlEntry_4(
                  PurchReceiptHeader, PurchRcptLine, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, SourceCodeSetup."Fixed Asset G/L Journal", TotalFAPurchLine, DeprBook.Code);

                FAJnlSetup.RESET;
                FAJnlSetup.SETFILTER("Depreciation Book Code", DeprBook.Code);
                FAJnlSetup.SETRANGE("User ID", USERID);
                IF FAJnlSetup.FINDFIRST THEN BEGIN
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name", GetFATemplate2(DeprBook.Code));
                    GenJournalLine.SETRANGE("Journal Batch Name", GetFABatch2(DeprBook.Code));
                    GenJournalLine.SETRANGE("Document No.", PurchReceiptHeader."No.");
                    GenJournalLine.SETRANGE("Posting Date", TODAY);
                    IF GenJournalLine.FINDSET THEN BEGIN
                        GenJournalLine."Reference Number FND" := PurchReceiptHeader."Your Reference";

                        IF PurchReceiptHeader."Order No." <> '' THEN
                            GenJournalLine."PO Number FND" := PurchReceiptHeader."Order No.";

                        GenJournalLine."Source Type" := GenJournalLine."Source Type"::Vendor;
                        GenJournalLine."Source No." := PurchReceiptHeader."Buy-from Vendor No.";
                        GenJournalLine.MODIFY;

                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine); //HEI.04
                    END;
                END;
                //HEI.12>>
            END;
            //HEI.12<<
        END;
        //HEI.03<<
    end;

    // BC Upgrade MISHRS14 >>
    // Chnaged data type of DocType from option to enum to remove implicit warning
    LOCAL procedure PostUndoFaGlEntry_1(PurchReceptHeader: Record "Purch. Rcpt. Header"; TotalPurchReceipt: Record "Purch. Rcpt. Line"; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20];
                                                                                                                                                     ExtDocNo: Code[35];
                                                                                                                                                     SourceCode: Code[10];
                                                                                                                                                     TotalFAPurchLine: Record "Purchase Line")
    // BC Upgrade MISHRS14 <<

    var
        GenJnlLine: Record "Gen. Journal Line";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        FAPurchaseLine: Record "Purchase Line";
        FASetup: Record "FA Setup";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        PurchHeader: Record "Purchase Header";
    begin
        //HEI.03>>
        FASetup.GET;
        FASetup.TESTFIELD("Payable Acc.Purch. Receipt FND");
        IF FASetup."Post GL on Purchase Return FND" THEN
            FASetup.TESTFIELD("Payable Acc. Purch. Return FND");
        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with GenJnlLine
        GenJnlLine.InitNewLine(Today, PurchReceptHeader."Document Date", 0D, PurchReceptHeader."Posting Description", TotalPurchReceipt."Shortcut Dimension 1 Code", TotalPurchReceipt."Shortcut Dimension 2 Code", TotalPurchReceipt."Dimension Set ID", PurchReceptHeader."Reason Code");
        // GenJnlLine.InitNewLine(TODAY, PurchReceptHeader."Document Date", PurchReceptHeader."Posting Description",
        //   TotalPurchReceipt."Shortcut Dimension 1 Code", TotalPurchReceipt."Shortcut Dimension 2 Code",
        //   TotalPurchReceipt."Dimension Set ID", PurchReceptHeader."Reason Code");
        GenJnlLine."Journal Template Name" := GetFATemplate(TotalPurchReceipt."Depreciation Book Code");
        GenJnlLine."Journal Batch Name" := GetFABatch(TotalPurchReceipt."Depreciation Book Code");
        GenJnlLine."Line No." := GetLastLineNo(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Fixed Asset";
        GenJnlLine."Account No." := TotalPurchReceipt."No.";
        GenJnlLine."FA Posting Type" := GenJnlLine."FA Posting Type"::"Acquisition Cost";
        GenJnlLine."Depreciation Book Code" := TotalPurchReceipt."Depreciation Book Code";

        GenJnlLine.CopyDocumentFields(DocType, DocNo, ExtDocNo, SourceCode, '');

        GenJnlLine."System-Created Entry" := TRUE;

        GenJnlLine."Pmt. Discount Date" := 0D;

        GenJnlLine.Amount := -GetFaLedgerEntryCost(TotalPurchReceipt);
        GenJnlLine."Amount (LCY)" := GenJnlLine.Amount;

        GenJnlLine."Reference Number FND" := PurchReceptHeader."Your Reference";

        IF PurchReceptHeader."Order No." <> '' THEN
            GenJnlLine."PO Number FND" := PurchReceptHeader."Order No.";

        GenJnlLine."Source Type" := GenJnlLine."Source Type"::Vendor;
        GenJnlLine."Source No." := PurchReceptHeader."Buy-from Vendor No.";
        GenJnlLine."Undo FA Receipt FND" := TRUE;//HEI.04
        GenJnlLine."FA Receipt Line No. FND" := TotalPurchReceipt."Line No.";
        GenJnlLine.INSERT;
        // //HEI.03<<

        // BC Upgrade MISHRS14 <<

        //HEI.03<<
    end;

    // BC Upgrade MISHRS14 >>
    // Chnaged data type of DocType from option to enum to remove implicit warning
    LOCAL procedure PostUndoFaGlEntry_2(PurchReceptHeader: Record "Purch. Rcpt. Header"; TotalPurchReceipt: Record "Purch. Rcpt. Line"; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20];
                                                                                                                                                     ExtDocNo: Code[35];
                                                                                                                                                     SourceCode: Code[10];
                                                                                                                                                     TotalFAPurchLine: Record "Purchase Line")
    // BC Upgrade MISHRS14 <<

    var
        GenJnlLine: Record "Gen. Journal Line";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        FAPurchaseLine: Record "Purchase Line";
        FASetup: Record "FA Setup";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        PurchHeader: Record "Purchase Header";
    begin
        //HEI.03>>
        FASetup.GET;
        FASetup.TESTFIELD("Payable Acc.Purch. Receipt FND");
        IF FASetup."Post GL on Purchase Return FND" THEN
            FASetup.TESTFIELD("Payable Acc. Purch. Return FND");
        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with GenJnlLine
        GenJnlLine.InitNewLine(
  TODAY, PurchReceptHeader."Document Date", 0D, PurchReceptHeader."Posting Description",
  PurchReceptHeader."Shortcut Dimension 1 Code", PurchReceptHeader."Shortcut Dimension 2 Code",
  PurchReceptHeader."Dimension Set ID", PurchReceptHeader."Reason Code");

        GenJnlLine."Journal Template Name" := GetFATemplate(TotalPurchReceipt."Depreciation Book Code");
        GenJnlLine."Journal Batch Name" := GetFABatch(TotalPurchReceipt."Depreciation Book Code");
        GenJnlLine."Line No." := GetLastLineNo(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
        GenJnlLine."Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Account No." := FASetup."Payable Acc.Purch. Receipt FND";

        GenJnlLine.CopyDocumentFields(DocType, DocNo, ExtDocNo, SourceCode, '');

        GenJnlLine."System-Created Entry" := TRUE;

        GenJnlLine."Pmt. Discount Date" := 0D;

        GenJnlLine.Amount := GetFaLedgerEntryCost(TotalPurchReceipt);
        GenJnlLine."Amount (LCY)" := GenJnlLine.Amount;

        GenJnlLine."Reference Number FND" := PurchReceptHeader."Your Reference";

        IF PurchReceptHeader."Order No." <> '' THEN
            GenJnlLine."PO Number FND" := PurchReceptHeader."Order No.";

        GenJnlLine."Source Type" := GenJnlLine."Source Type"::Vendor;
        GenJnlLine."Source No." := PurchReceptHeader."Buy-from Vendor No.";
        GenJnlLine."Undo FA Receipt FND" := TRUE;//HEI.04
        GenJnlLine."FA Receipt Line No. FND" := TotalPurchReceipt."Line No.";
        GenJnlLine.INSERT;
        // //HEI.03<<

        //WITH GenJnlLine DO BEGIN
        // GenJnlLine.InitNewLine(
        //   TODAY, PurchReceptHeader."Document Date", 0D, PurchReceptHeader."Posting Description",
        //   PurchReceptHeader."Shortcut Dimension 1 Code", PurchReceptHeader."Shortcut Dimension 2 Code",
        //   PurchReceptHeader."Dimension Set ID", PurchReceptHeader."Reason Code");

        // GenJnlLine."Journal Template Name" := GetFATemplate(TotalPurchReceipt."Depreciation Book Code");
        // GenJnlLine."Journal Batch Name" := GetFABatch(TotalPurchReceipt."Depreciation Book Code");
        // GenJnlLine."Line No." := GetLastLineNo(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
        // GenJnlLine."Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        // GenJnlLine."Account No." := FASetup."Payable Acc. Purchase Receipt";

        // GenJnlLine.CopyDocumentFields(DocType, DocNo, ExtDocNo, SourceCode, '');

        // GenJnlLine."System-Created Entry" := TRUE;

        // GenJnlLine."Pmt. Discount Date" := 0D;

        // GenJnlLine.Amount := GetFaLedgerEntryCost(TotalPurchReceipt);
        // GenJnlLine."Amount (LCY)" := GenJnlLine.Amount;

        // GenJnlLine."Reference Number FND" := PurchReceptHeader."Your Reference";

        // IF PurchReceptHeader."Order No." <> '' THEN
        //     GenJnlLine."PO Number FND" := PurchReceptHeader."Order No.";

        // GenJnlLine."Source Type" := GenJnlLine."Source Type"::Vendor;
        // GenJnlLine."Source No." := PurchReceptHeader."Buy-from Vendor No.";
        // GenJnlLine."Undo FA Receipt FND" := TRUE;//HEI.04
        // GenJnlLine.INSERT;
        //END;
        // BC Upgrade MISHRS14 <<

    end;

    // BC Upgrade MISHRS14 >>
    // Chnaged data type of DocType from option to enum to remove implicit warning
    LOCAL procedure PostUndoFaGlEntry_3(PurchReceptHeader: Record "Purch. Rcpt. Header"; TotalPurchReceipt: Record "Purch. Rcpt. Line"; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20];
                                                                                                                                                     ExtDocNo: Code[35];
                                                                                                                                                     SourceCode: Code[10];
                                                                                                                                                     TotalFAPurchLine: Record "Purchase Line";
                                                                                                                                                     DeperBookCode: Code[10])
    // BC Upgrade MISHRS14 <<

    var
        GenJnlLine: Record "Gen. Journal Line";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        FAPurchaseLine: Record "Purchase Line";
        FASetup: Record "FA Setup";
        PurchHeader: Record "Purchase Header";
    begin
        //HEI.03>>
        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with GenJnlLine
        GenJnlLine.InitNewLine(
  TODAY, PurchReceptHeader."Document Date", 0D, PurchReceptHeader."Posting Description",
  TotalPurchReceipt."Shortcut Dimension 1 Code", TotalPurchReceipt."Shortcut Dimension 2 Code",
  TotalPurchReceipt."Dimension Set ID", PurchReceptHeader."Reason Code");

        GenJnlLine."Journal Template Name" := GetFATemplate2(DeperBookCode);
        GenJnlLine."Journal Batch Name" := GetFABatch2(DeperBookCode);
        GenJnlLine."Line No." := GetLastLineNo(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Fixed Asset";
        GenJnlLine.VALIDATE("Account No.", TotalPurchReceipt."No.");
        GenJnlLine."FA Posting Type" := GenJnlLine."FA Posting Type"::"Acquisition Cost";
        GenJnlLine.VALIDATE("Depreciation Book Code", DeperBookCode);

        GenJnlLine.CopyDocumentFields(DocType, DocNo, ExtDocNo, SourceCode, '');

        GenJnlLine."Pmt. Discount Date" := 0D;

        GenJnlLine.VALIDATE(Amount, -GetFaLedgerEntryCost(TotalPurchReceipt));

        GenJnlLine."Reference Number FND" := PurchReceptHeader."Your Reference";
        GenJnlLine."PO Number FND" := '';
        GenJnlLine."Source Type" := GenJnlLine."Source Type"::" ";
        GenJnlLine."Source No." := '';
        GenJnlLine."Shortcut Dimension 1 Code" := TotalPurchReceipt."Shortcut Dimension 1 Code";
        GenJnlLine."Shortcut Dimension 2 Code" := TotalPurchReceipt."Shortcut Dimension 2 Code";
        GenJnlLine."Dimension Set ID" := TotalPurchReceipt."Dimension Set ID";
        //  GenJnlLine.Description := TotalPurchReceipt.Description;//sharmp16--
        GenJnlLine."Undo FA Receipt FND" := TRUE;//HEI.04
        GenJnlLine.INSERT;
        // //HEI.03<<
        //WITH GenJnlLine DO BEGIN
        // GenJnlLine.InitNewLine(
        //   TODAY, PurchReceptHeader."Document Date", 0D, PurchReceptHeader."Posting Description",
        //   TotalPurchReceipt."Shortcut Dimension 1 Code", TotalPurchReceipt."Shortcut Dimension 2 Code",
        //   TotalPurchReceipt."Dimension Set ID", PurchReceptHeader."Reason Code");

        // GenJnlLine."Journal Template Name" := GetFATemplate2(DeperBookCode);
        // GenJnlLine."Journal Batch Name" := GetFABatch2(DeperBookCode);
        // GenJnlLine."Line No." := GetLastLineNo(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
        // GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Fixed Asset";
        // GenJnlLine.VALIDATE("Account No.", TotalPurchReceipt."No.");
        // GenJnlLine."FA Posting Type" := GenJnlLine."FA Posting Type"::"Acquisition Cost";
        // GenJnlLine.VALIDATE("Depreciation Book Code", DeperBookCode);

        // GenJnlLine.CopyDocumentFields(DocType, DocNo, ExtDocNo, SourceCode, '');

        // GenJnlLine."Pmt. Discount Date" := 0D;

        // GenJnlLine.VALIDATE(Amount, -GetFaLedgerEntryCost(TotalPurchReceipt));

        // GenJnlLine."Reference Number FND" := PurchReceptHeader."Your Reference";
        // GenJnlLine."PO Number FND" := '';
        // GenJnlLine."Source Type" := GenJnlLine."Source Type"::" ";
        // GenJnlLine."Source No." := '';
        // GenJnlLine."Shortcut Dimension 1 Code" := TotalPurchReceipt."Shortcut Dimension 1 Code";
        // GenJnlLine."Shortcut Dimension 2 Code" := TotalPurchReceipt."Shortcut Dimension 2 Code";
        // GenJnlLine."Dimension Set ID" := TotalPurchReceipt."Dimension Set ID";
        // GenJnlLine.Description := TotalPurchReceipt.Description;
        // GenJnlLine."Undo FA Receipt FND" := TRUE;//HEI.04
        // GenJnlLine.INSERT;
        //END;
        // BC Upgrade MISHRS14 <<

        //HEI.03<<


    end;

    // BC Upgrade MISHRS14 >>
    // Chnaged data type of DocType from option to enum to remove implicit warning
    LOCAL procedure PostUndoFaGlEntry_4(PurchReceptHeader: Record "Purch. Rcpt. Header"; TotalPurchReceipt: Record "Purch. Rcpt. Line"; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20];
                                                                                                                                                     ExtDocNo: Code[35];
                                                                                                                                                     SourceCode: Code[10];
                                                                                                                                                     TotalFAPurchLine: Record "Purchase Line";
                                                                                                                                                     DeperBookCode: Code[10])
    // BC Upgrade MISHRS14 <<

    var
        GenJnlLine: Record "Gen. Journal Line";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        FAPurchaseLine: Record "Purchase Line";
        FASetup: Record "FA Setup";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        PurchHeader: Record "Purchase Header";
        FAPostingGroup: Record "FA Posting Group";
        DepreBookLine: Record "FA Depreciation Book";
    begin
        //HEI.03>>
        DepreBookLine.GET(TotalPurchReceipt."No.", DeperBookCode);
        FAPostingGroup.GET(DepreBookLine."FA Posting Group");
        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with GenJnlLine
        GenJnlLine.InitNewLine(
     TODAY, PurchReceptHeader."Document Date", 0D, PurchReceptHeader."Posting Description",
     TotalPurchReceipt."Shortcut Dimension 1 Code", TotalPurchReceipt."Shortcut Dimension 2 Code",
     TotalPurchReceipt."Dimension Set ID", PurchReceptHeader."Reason Code");


        GenJnlLine."Journal Template Name" := GetFATemplate2(DeperBookCode);
        GenJnlLine."Journal Batch Name" := GetFABatch2(DeperBookCode);
        GenJnlLine."Line No." := GetLastLineNo(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine.VALIDATE("Account No.", FAPostingGroup."Acquisition Cost Bal. Acc.");

        GenJnlLine.CopyDocumentFields(DocType, DocNo, ExtDocNo, SourceCode, '');

        GenJnlLine."Pmt. Discount Date" := 0D;

        GenJnlLine.VALIDATE(Amount, GetFaLedgerEntryCost(TotalPurchReceipt));
        GenJnlLine."Reference Number FND" := PurchReceptHeader."Your Reference";
        GenJnlLine."PO Number FND" := '';
        GenJnlLine."Source Type" := GenJnlLine."Source Type"::" ";
        GenJnlLine."Source No." := '';
        GenJnlLine."Shortcut Dimension 1 Code" := TotalPurchReceipt."Shortcut Dimension 1 Code";
        GenJnlLine."Shortcut Dimension 2 Code" := TotalPurchReceipt."Shortcut Dimension 2 Code";
        GenJnlLine."Dimension Set ID" := TotalPurchReceipt."Dimension Set ID";
        //  GenJnlLine.Description := TotalPurchReceipt.Description;//sharmp16--
        GenJnlLine."Undo FA Receipt FND" := TRUE;//HEI.04
        GenJnlLine.INSERT;
        //HEI.03<<

        //WITH GenJnlLine DO BEGIN
        // GenJnlLine.InitNewLine(
        //      TODAY, PurchReceptHeader."Document Date", 0D, PurchReceptHeader."Posting Description",
        //      TotalPurchReceipt."Shortcut Dimension 1 Code", TotalPurchReceipt."Shortcut Dimension 2 Code",
        //      TotalPurchReceipt."Dimension Set ID", PurchReceptHeader."Reason Code");


        // GenJnlLine."Journal Template Name" := GetFATemplate2(DeperBookCode);
        // GenJnlLine."Journal Batch Name" := GetFABatch2(DeperBookCode);
        // GenJnlLine."Line No." := GetLastLineNo(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
        // GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        // GenJnlLine.VALIDATE("Account No.", FAPostingGroup."Acquisition Cost Bal. Acc.");

        // GenJnlLine.CopyDocumentFields(DocType, DocNo, ExtDocNo, SourceCode, '');

        // GenJnlLine."Pmt. Discount Date" := 0D;

        // GenJnlLine.VALIDATE(Amount, GetFaLedgerEntryCost(TotalPurchReceipt));
        // GenJnlLine."Reference Number FND" := PurchReceptHeader."Your Reference";
        // GenJnlLine."PO Number FND" := '';
        // GenJnlLine."Source Type" := GenJnlLine."Source Type"::" ";
        // GenJnlLine."Source No." := '';
        // GenJnlLine."Shortcut Dimension 1 Code" := TotalPurchReceipt."Shortcut Dimension 1 Code";
        // GenJnlLine."Shortcut Dimension 2 Code" := TotalPurchReceipt."Shortcut Dimension 2 Code";
        // GenJnlLine."Dimension Set ID" := TotalPurchReceipt."Dimension Set ID";
        // GenJnlLine.Description := TotalPurchReceipt.Description;
        // GenJnlLine."Undo FA Receipt FND" := TRUE;//HEI.04
        // GenJnlLine.INSERT;
        //END;
        // BC Upgrade MISHRS14 <<

    end;

    LOCAL procedure GetFaLedgerEntryCost(PurchLineReceipt: Record "Purch. Rcpt. Line"): Decimal
    var
        FALedgerEntry: Record "FA Ledger Entry";
    begin
        //HEI.03>>
        FALedgerEntry.RESET;
        FALedgerEntry.SETRANGE("Document Type", FALedgerEntry."Document Type"::"Purchase Receipt");
        FALedgerEntry.SETRANGE("Document No.", PurchLineReceipt."Document No.");
        FALedgerEntry.SETRANGE("Purchase Receipt Line No. FND", PurchLineReceipt."Line No.");
        IF FALedgerEntry.FINDFIRST THEN
            EXIT(FALedgerEntry.Amount);
        //HEI.03<<
    end;

    LOCAL procedure GetFABatch(DeprBookCode: Code[10]): Code[10]
    var
        FAJnlSetup: Record "FA Journal Setup";
    begin
        //HEI.03>>
        FAJnlSetup.GET(DeprBookCode, '');

        EXIT(FAJnlSetup."Gen. Jnl. Batch Name");
        //HEI.03<<
    end;

    LOCAL procedure GetFATemplate(DeprBookCode: Code[10]): Code[10]
    var
        FAJnlSetup: Record "FA Journal Setup";
    begin
        //HEI.03>>
        FAJnlSetup.GET(DeprBookCode, '');
        EXIT(FAJnlSetup."Gen. Jnl. Template Name");
    end;
    //HEI.03<<
    LOCAL procedure GetLastLineNo(GenJouTemplate: Code[10]; GenJouBatch: Code[10]): Integer
    var
        GenJouLine: Record "Gen. Journal Line";
    begin
        //HEI.03>>
        GenJouLine.RESET;
        GenJouLine.SETRANGE("Journal Template Name", GenJouTemplate);
        GenJouLine.SETRANGE("Journal Batch Name", GenJouBatch);
        IF GenJouLine.FINDLAST THEN
            EXIT(GenJouLine."Line No." + 10000);

        EXIT(10000);
        //HEI.03<<
    end;

    LOCAL procedure GetFABatch2(DeprBookCode: Code[10]): Code[10]
    var
        FAJnlSetup: Record "FA Journal Setup";
    begin


        //HEI.03>>
        IF FAJnlSetup.GET(DeprBookCode, USERID) THEN
            EXIT(FAJnlSetup."Gen. Jnl. Batch Name")
        ELSE
            EXIT(GetFABatch(DeprBookCode));
        //HEI.03<<
    end;

    LOCAL procedure GetFATemplate2(DeprBookCode: Code[10]): Code[10]
    var
        FAJnlSetup: Record "FA Journal Setup";
    begin
        //HEI.03>>
        IF FAJnlSetup.GET(DeprBookCode, USERID) THEN
            EXIT(FAJnlSetup."Gen. Jnl. Template Name")
        ELSE
            EXIT(GetFATemplate(DeprBookCode));
        //HEI.03<<
    end;

    procedure UndoGRIRAccountPayable(PurchReceiptLine: Record "Purch. Rcpt. Line")
    var

        PurchRecptHdr: Record "Purch. Rcpt. Header";
        GLEntry: Record "G/L Entry";
        FASetup: Record "FA Setup";
        GLEntryToApply: Record "G/L Entry Application Bffr FND" temporary;
        GLEntryFinded: Boolean;
        PositiveAmount: Boolean;
        NoSeqApplyToID: Integer;
        GLEntryToModify: Record "G/L Entry Application Bffr FND" temporary;
        GLItemLedgerRelation: Record "G/L - Item Ledger Relation";
        ValueEntry: Record "Value Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
        ValueEntry2: Record "Value Entry";
        GLEntry2: Record "G/L Entry";
        TempGLEntry: Record "G/L Entry" temporary;
        lop: Integer;
        lopRelation: Integer;
        PostedPurchaseLine: Record "Purch. Inv. Line";
        GLEntry3: Record "G/L Entry";
        GRIRAutomaticClearing: Codeunit "GR/IR Automatic clearing CBN";
        G_TempGLEntryBuf: Record "G/L Entry Application Bffr FND" temporary;
        TotalNo: Integer;
        i: Integer;
        PostedCrPurchaseLine: Record "Purch. Cr. Memo Line";
        GLAcc: Record "G/L Account";
    begin
        //HEI.03>>
        //HEI.03>>
        PurchRecptHdr.GET(PurchReceiptLine."Document No.");
        FASetup.GET;
        FASetup.TESTFIELD("Payable Acc.Purch. Receipt FND");
        GLAcc.GET(FASetup."Payable Acc.Purch. Receipt FND");
        SetAllEntries(GLAcc."No.", PurchReceiptLine);
        GRIRAutomaticClearing.UpdateAllowpartial(TRUE);
        NoSeqApplyToID := 0;
        GLEntryApplicationBuffer.SETCURRENTKEY("Applies-to ID");
        GLEntryApplicationBuffer.SETFILTER("Applies-to ID", '''''');
        IF GLEntryApplicationBuffer.FINDFIRST THEN
            REPEAT
                GLEntry3.RESET;
                GLEntry3.SETCURRENTKEY("Document Type", "Document No.");
                GLEntry3.SETRANGE("Document Type", GLEntry3."Document Type"::"Purchase Receipt");
                GLEntry3.SETRANGE("Document No.", PurchReceiptLine."Document No.");
                GLEntry3.SETRANGE("G/L Account No.", GLEntryApplicationBuffer."G/L Account No.");
                //      GLEntry3.SETFILTER(Amount, '>%1', 0);//BC  Upgrade SHARMP16
                GLEntry3.SETRANGE("Open FND", TRUE);
                GLEntry3.SETRANGE(Reversed, FALSE);
                GLEntry3.SETRANGE("Applies-to ID FND", '');
                GLEntry3.SetRange("FA Receipt Line No. FND", PurchReceiptLine."Line No.");//BC  Upgrade SHARMP16
                IF GLEntry3.FINDFIRST THEN
                    REPEAT

                        NoSeqApplyToID += 1;
                        GLEntryToApply.COPY(GLEntryApplicationBuffer, TRUE);//BC  Upgrade SHARMP16
                        IF (GLEntryApplicationBuffer."Entry No." <> GLEntry3."Entry No.") AND GLEntryToApply.GET(GLEntry3."Entry No.")
                        AND (GLEntryToApply.Open = TRUE) AND (GLEntryToApply."Applies-to ID" = '') THEN BEGIN
                            GLEntryToModify.COPY(GLEntryApplicationBuffer, TRUE);//BC  Upgrade SHARMP16
                            GLEntryToModify.GET(GLEntryApplicationBuffer."Entry No.");
                            GLEntryToModify."Applies-to ID" := FORMAT(GLEntryToModify."G/L Account No.") + '-' + FORMAT(NoSeqApplyToID);
                            GLEntryToModify.MODIFY;
                            GLEntryToApply."Applies-to ID" := FORMAT(GLEntryToModify."G/L Account No.") + '-' + FORMAT(NoSeqApplyToID);
                            GLEntryToApply.MODIFY;
                        END;
                    UNTIL GLEntry3.NEXT = 0;
                //Applied Entries
                G_TempGLEntryBuf.COPY(GLEntryApplicationBuffer, true);//BC Upgrade SHARMP16
                GRIRAutomaticClearing.UpdateAllowpartial(TRUE);
                G_TempGLEntryBuf.RESET;
                G_TempGLEntryBuf.SETCURRENTKEY("Entry No.");
                G_TempGLEntryBuf.SETFILTER("Applies-to ID", '<>%1', '');
                G_TempGLEntryBuf.SETRANGE(Open, TRUE);
                TotalNo := G_TempGLEntryBuf.COUNT;
                IF G_TempGLEntryBuf.FIND('-') THEN BEGIN //HEI.07
                    GRIRAutomaticClearing.Setundoflag(TRUE); //HEI.07
                    GRIRAutomaticClearing.Apply(G_TempGLEntryBuf);
                END; //HEI.07
                IF TotalNo MOD 2 <> 0 THEN
                    TotalNo += 1;
                FOR i := 1 TO (TotalNo / 2) DO BEGIN
                    G_TempGLEntryBuf.RESET;
                    G_TempGLEntryBuf.SETFILTER("Applies-to ID", '<>%1', '');
                    G_TempGLEntryBuf.SETRANGE(Open, TRUE);
                    IF G_TempGLEntryBuf.FIND('-') THEN BEGIN //HEI.07
                        GRIRAutomaticClearing.Setundoflag(TRUE); //HEI.07
                        GRIRAutomaticClearing.Apply(G_TempGLEntryBuf);
                    END; //HEI.07
                END;

            UNTIL GLEntryApplicationBuffer.NEXT = 0;
        //HEI.03<<
    end;

    procedure SetAllEntries(GLAccNo: Code[20];
                PurchReceiptLine: Record "Purch. Rcpt. Line")
    var
        GLEntry: Record "G/L Entry";

    begin
        //HEI.03>>
        GLEntry.SETCURRENTKEY("G/L Account No.");
        GLEntry.SETRANGE("G/L Account No.", GLAccNo);
        GLEntry.SETRANGE("Document Type", GLEntry."Document Type"::"Purchase Receipt");
        GLEntry.SETRANGE("Document No.", PurchReceiptLine."Document No.");
        GLEntry.SETRANGE(Reversed, FALSE);
        GLEntry.SETRANGE("Open FND", TRUE);
        GLEntry.SetRange("FA Receipt Line No. FND", PurchReceiptLine."Line No.");//BC Upgrade SHARMP16
        IF GLEntry.FINDSET THEN
            REPEAT
                TransferGLEntry(GLEntryApplicationBuffer, GLEntry);
            UNTIL GLEntry.NEXT = 0;
        //HEI.03<<
    end;

    LOCAL procedure TransferGLEntry(VAR GLEntryBuf: Record "G/L Entry Application Bffr FND"; GLEntry: Record "G/L Entry")
    begin
        //HEI.03>>
        GLEntryBuf.TRANSFERFIELDS(GLEntry);
        GLEntryBuf.Positive := GLEntry.Amount > 0;
        GLEntryBuf.INSERT;
        //HEI.03<<
    end;

    procedure SetPreviewUndo(PreviewUndo: Boolean)
    begin
        UndoPreviewGR := PreviewUndo; //HEI.06
    end;

    procedure PreviewPostGLOnUndoFixedAssets(VAR PurchRcptLine: Record "Purch. Rcpt. Line")
    var
        GenJournalLine: Record "Gen. Journal Line";
        FAJnlSetup: Record "FA Journal Setup";
        DeprBook: Record "Depreciation Book";
        PurchRcptHeader2: Record "Purch. Rcpt. Header";
        PurchReceiptHeader: Record "Purch. Rcpt. Header";
        TotalPurchLine: Record "Purchase Line";
        TotalPurchLineLCY: Record "Purchase Line";
        SrcCode: Code[10];
        TotalFAPurchLine: Record "Purchase Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        SourceCodeSetup: Record "Source Code Setup";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        FADepreciationBookL: Record "FA Depreciation Book";

    begin
        //HEI.06>>
        DeprBook.RESET;
        DeprBook.SETRANGE("Part of Duplication List", TRUE);
        IF DeprBook.FINDFIRST THEN BEGIN
            GenJnlLine.RESET;
            GenJnlLine.SETRANGE("Document Type", GenJnlLine."Document Type"::"Purchase Receipt");
            GenJnlLine.SETRANGE("Document No.", PurchRcptLine."Document No.");
            GenJnlLine.SETRANGE("Undo FA Receipt FND", TRUE);
            GenJnlLine.SETFILTER("Journal Template Name", '<>%1', GetFATemplate2(DeprBook.Code));
            GenJnlLine.SETFILTER("Journal Batch Name", '<>%1', GetFABatch2(DeprBook.Code));
            IF GenJnlLine.FINDSET THEN
                GenJnlLine.DELETEALL; //Deleting un-posted local book line
        END;
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Document Type", GenJnlLine."Document Type"::"Purchase Receipt");
        GenJnlLine.SETRANGE("Document No.", PurchRcptLine."Document No.");
        GenJnlLine.SETRANGE("Undo FA Receipt FND", TRUE);
        GenJnlLine.SETFILTER("Journal Template Name", '%1', GetFATemplate(PurchRcptLine."Depreciation Book Code"));
        GenJnlLine.SETFILTER("Journal Batch Name", '%1', GetFABatch(PurchRcptLine."Depreciation Book Code"));
        IF GenJnlLine.FINDSET THEN
            GenJnlLine.DELETEALL; //Deleting un-posted local book line

        TotalPurchLine.GET(TotalPurchLine."Document Type"::Order, PurchRcptLine."Order No.", PurchRcptLine."Order Line No.");
        PurchReceiptHeader.GET(PurchRcptLine."Document No.");
        GenJnlLineDocType := GenJournalLine."Document Type"::"Purchase Receipt";
        GenJnlLineDocNo := PurchRcptLine."Document No.";
        GenJnlLineExtDocNo := PurchReceiptHeader."Vendor Order No.";
        PostUndoFaGlEntry_1(
            PurchReceiptHeader, PurchRcptLine, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, PurchReceiptHeader."Source Code", TotalFAPurchLine);
        PostUndoFaGlEntry_2(
            PurchReceiptHeader, PurchRcptLine, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, PurchReceiptHeader."Source Code", TotalFAPurchLine);

        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", GetFATemplate(PurchRcptLine."Depreciation Book Code"));
        GenJournalLine.SETRANGE("Journal Batch Name", GetFABatch(PurchRcptLine."Depreciation Book Code"));
        GenJournalLine.SETRANGE("Document Type", GenJournalLine."Document Type"::"Purchase Receipt");
        GenJournalLine.SETRANGE("Document No.", PurchRcptLine."Document No.");
        GenJournalLine.FINDSET;

        COMMIT;
        // GenJnlPost.PreviewSRM(GenJournalLine);
        // PreviewSRM(GenJnlLine); // BC Upgrade BHARAD11 --PRPending 20April2026 --Change variable
        PreviewSRM(GenJournalLine); // BC Upgrade BHARAD11 --PRPending 20April2026 --Change variable


        //  PreviewSRM(GenJnlLine);

        //------------------------------------------------------Local Close

        DeprBook.RESET;
        DeprBook.SETRANGE("Part of Duplication List", TRUE);
        IF DeprBook.FINDFIRST THEN BEGIN
            //HEI.12>>
            FADepreciationBookL.SETCURRENTKEY("FA No.", "Depreciation Book Code");
            FADepreciationBookL.SETRANGE("FA No.", PurchRcptLine."No.");
            FADepreciationBookL.SETRANGE("Depreciation Book Code", DeprBook.Code);
            IF FADepreciationBookL.FINDFIRST THEN BEGIN
                //HEI.12<<
                //Source
                SourceCodeSetup.GET;
                PostUndoFaGlEntry_3(
                  PurchReceiptHeader, PurchRcptLine, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, SourceCodeSetup."Fixed Asset G/L Journal", TotalFAPurchLine, DeprBook.Code);
                PostUndoFaGlEntry_4(
                  PurchReceiptHeader, PurchRcptLine, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, SourceCodeSetup."Fixed Asset G/L Journal", TotalFAPurchLine, DeprBook.Code);

                FAJnlSetup.RESET;
                FAJnlSetup.SETFILTER("Depreciation Book Code", DeprBook.Code);
                FAJnlSetup.SETRANGE("User ID", USERID);
                IF FAJnlSetup.FINDFIRST THEN BEGIN
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name", GetFATemplate2(DeprBook.Code));
                    GenJournalLine.SETRANGE("Journal Batch Name", GetFABatch2(DeprBook.Code));
                    GenJournalLine.SETRANGE("Document No.", PurchReceiptHeader."No.");
                    GenJournalLine.SETRANGE("Posting Date", TODAY);

                    // BC Upgrade MISHRS14 >>
                    // Removed false from FINDSET as it being depreceted
                    //IF GenJournalLine.FINDSET(TRUE, FALSE) THEN BEGIN
                    IF GenJournalLine.FINDSET(TRUE) THEN BEGIN
                        // BC Upgrade MISHRS14 <<

                        GenJournalLine."Reference Number FND" := PurchReceiptHeader."Your Reference";

                        IF PurchReceiptHeader."Order No." <> '' THEN
                            GenJournalLine."PO Number FND" := PurchReceiptHeader."Order No.";

                        GenJournalLine."Source Type" := GenJournalLine."Source Type"::Vendor;
                        GenJournalLine."Source No." := PurchReceiptHeader."Buy-from Vendor No.";
                        GenJournalLine.MODIFY;
                        COMMIT;
                        //  GenJnlPost.PreviewSRM(GenJournalLine);
                        // PreviewSRM(GenJnlLine);
                        PreviewSRM(GenJournalLine); // BC Upgrade BHARAD11  --Change variable
                        // PreviewSRM(GenJnlLine);
                    END;
                END;
                //HEI.12>>
            END;
            //HEI.12<<
        END;
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Document Type", GenJnlLine."Document Type"::"Purchase Receipt");
        GenJnlLine.SETRANGE("Document No.", PurchRcptLine."Document No.");
        GenJnlLine.SETRANGE("Undo FA Receipt FND", TRUE);
        IF GenJnlLine.FINDSET THEN
            GenJnlLine.DELETEALL; //Deleting un-posted local book line
        COMMIT;
        //HEI.06<<
    end;

    //BC Upgrade GUNREM01 >> added Integration Events and subscribed this events in interface codeunit 
    // [IntegrationEvent(false, false)] // BC Upgrade BHARDA11 ---PRPending 20April2026 
    local procedure PreviewSRM(VAR GenJournalLineSource: Record "Gen. Journal Line")
    var
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";

    begin
        //HEI.01>>
        BINDSUBSCRIPTION(GenJnlPost);
        PreviewSRMInterface(GenJnlPost, GenJournalLineSource);
        //HEI.01<<
    end;

    // [IntegrationEvent(false, false)] // BC Upgrade BHARDA11 ---PRPending 20April2026 
    local procedure PreviewSRMInterface(Subscriber: Variant; RecVar: Variant)
    var
        SubscriberTypeErr: Label 'Invalid Subscriber type. The type must be CODEUNIT.';
        RecVarTypeErr: Label 'Invalid RecVar type. The type must be RECORD.';
        PostingPreviewEventHandler: Codeunit 20;
        RunResult: Boolean;
        genJournalPostPr: Codeunit "Gen. Jnl.-Post Preview";
        PreviewExitStateErr: Label 'The posting preview has stopped because of a state that is not valid.';
        PreviewModeErr: Label 'Preview mode.';
        HeinekenBCUpgrade: Codeunit "Heineken BC Upgrade";
    begin
        //HEI.01>>

        IF NOT Subscriber.ISCODEUNIT THEN
            ERROR(SubscriberTypeErr);

        IF NOT RecVar.ISRECORD THEN
            ERROR(RecVarTypeErr);

        BINDSUBSCRIPTION(PostingPreviewEventHandler);
        // genJournalPostPr.
        // RunResult := RunPreview(Subscriber, RecVar); // Need to check
        RunResult := HeinekenBCUpgrade.RunPreview(Subscriber, RecVar);
        UNBINDSUBSCRIPTION(PostingPreviewEventHandler);

        // The OnRunPreview event expects subscriber following template: Result := <Codeunit>.RUN

        // So we assume RunPreview returns FALSE with the error.

        // To prevent return FALSE without thrown error we check error call stack.
        // BC Upgrade BHARAD11 >> -- TempBlocked 20April2026
        // IF RunResult OR (GETLASTERRORCALLSTACK = '') THEN
        //     ERROR(PreviewExitStateErr);

        // IF GETLASTERRORTEXT <> PreviewModeErr THEN
        //     ERROR(GETLASTERRORTEXT);
        // BC Upgrade BHARAD11 << -- TempBlocked 20April2026
        //HEI.01<<


    end;
    //BC Upgrade GUNREM01 << added Integration Events and subscribed this events in interface codeunit 
    //BC Upgrade GUNREM01 << Codeunit -5813- "Undo Purchase Receipt Line'


    var
        myInt: Integer;
        //BC Upgrade GUNREM01 >> added variable
        UndoPreviewGR: Boolean;
        GLEntryApplicationBuffer: record "G/L Entry Application Bffr FND" temporary;//BC Upgrade SHARMP16

        // BC Upgrade MISHRS14 >>
        // Chnaged data type from option to enum to remove implicit warning 
        GenJnlLineDocType: Enum "Gen. Journal Document Type";
        // BC Upgrade MISHRS14 <<

        GenJnlLineDocNo: Code[20];
        GenJnlLineExtDocNo: Code[35];
    //BC Upgrade GUNREM01 << added variable

    // BC Upgrade VAMSIU01 Codeunit 444 "Purchase-Post Prepayments" >>
    // Navision old Documentation start >>
    // DITW15.00.00.39 DDR 10/05/2011 issue 1330 Added to insert DIT item charges per order before prepayment posting
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.03 MSF 28/05/2014 DIT-770 #715 Upgrade W1 Rollup 6 ChangeLog.W1.36366 file 474255

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-PTPGAP067 IBM ISYED01 30.10.2017
    //   # Added code to validate the NPO, PO document sub type from paurchpayble setup.
    // HEI.02 FDD-PTPGAP067 IBM SOICAD01
    // HEI.03 FDD-PURGAP027 IBM NASTAA02 12.06.2019 # Maximo POs Approval Flow
    //   # Code added to update also Addition Purchase Fields
    // HEI.04 FDD_HT627 IBM BULIMC01 11.09.2019 #automatically release PO when the Prepayment Invoice is created/paid
    // HEI.06 CHG2111855 IBM SHIVAS05 20/05/2021
    //   #Insert Posted purch. inv. No. in Purch. Inv. Header Additional and Posted Purc. cr. memo No. in Purch. Cr. Memo Hdr. Addition
    // HEI.07 CHG2317685 SAHAL01 17.10.2025 Block Functionality Enhancement for Vendors
    //   # Added Code

    // # BC - New Documentation
    // # Added logic from the local function Code() (NAV), implemented in Business Central using the events OnAfterPurchInvHeaderInsert and OnAfterPurchCrMemoHeaderInsert.
    // # Added logic from the function PostVendorEntry (NAV), implemented in Business Central using the evens OnBeforePostVendorEntry.
    // # Added Logic from the Functions InsertPurchInvHeader and InsertPurchCrMemoHeader.

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purchase-Post Prepayments", OnAfterPurchInvHeaderInsert, '', false, false)]
    local procedure PurchasePostPrepaymentsOnAfterPurchInvHeaderInsert(var PurchInvHeader: Record "Purch. Inv. Header"; PurchHeader: Record "Purchase Header"; CommitIsSupressed: Boolean)
    var
        PostingDescription: Text[100];
        DocumentType: Option Invoice,"Credit Memo";
        Text50001: Label 'Prepayment invoice, Prep. Request %1';
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchInvHeaderAdditional: Record "Purch. Inv. Header Add FND";

    begin
        if (PurchHeader."Document Subtype Code FND" <> '') then
            if DocumentType = DocumentType::Invoice then
                PostingDescription := STRSUBSTNO(Text50001, PurchHeader."No.");

        PurchInvHeader."Posting Description" := PostingDescription;

        //HEI.01>>
        PurchasesPayablesSetup.GET();
        PurchasesPayablesSetup.TESTFIELD("NPO Prepayment req.subtype FND");
        PurchasesPayablesSetup.TESTFIELD("PO Prepayment req. Subtype FND");
        IF PurchHeader."Document Subtype Code FND" = PurchasesPayablesSetup."NPO Prepayment req.subtype FND" THEN BEGIN
            PurchasesPayablesSetup.TESTFIELD("NPO Prepayment inv.subtype FND");
            PurchInvHeader."Document Subtype Code FND" := PurchasesPayablesSetup."NPO Prepayment inv.subtype FND"
        END;
        IF PurchHeader."Document Subtype Code FND" = PurchasesPayablesSetup."PO Prepayment req. Subtype FND" THEN BEGIN
            PurchasesPayablesSetup.TESTFIELD("PO Prepayment inv. subtype FND");
            PurchInvHeader."Document Subtype Code FND" := PurchasesPayablesSetup."PO Prepayment inv. subtype FND"
        END;
        //HEI.01<<
        //HEI.03>>
        IF PurchaseHeaderAdditional.GET(PurchHeader."Document Type", PurchHeader."No.") THEN BEGIN
            PurchInvHeaderAdditional.INIT;
            PurchInvHeaderAdditional.TRANSFERFIELDS(PurchaseHeaderAdditional);
            //HEI.06>>
            PurchInvHeaderAdditional."No." := PurchInvHeader."No.";
            //HEI.06<<
            PurchInvHeaderAdditional.INSERT;
        END;
        //HEI.03<<
        PurchInvHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purchase-Post Prepayments", OnAfterPurchCrMemoHeaderInsert, '', false, false)]
    local procedure PurchasePosPrepaymentsOnAfterPurchCrMemoHeaderInsert(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; PurchHeader: Record "Purchase Header"; CommitIsSupressed: Boolean)
    var
        PostingDescription: Text[100];
        DocumentType: Option Invoice,"Credit Memo";
        Text50002: Label 'Prepayment cr memo, Prep. Request %1';
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchCrMemoHdrAddition: Record "Purch. Cr. Memo Hdr. Add FND";
    begin
        if (PurchHeader."Document Subtype Code FND" <> '') then
            if DocumentType = DocumentType::"Credit Memo" then
                PostingDescription := STRSUBSTNO(Text50002, PurchHeader."No.");

        PurchCrMemoHdr."Posting Description" := PostingDescription;

        //HEI.01>>
        PurchasesPayablesSetup.GET();
        PurchasesPayablesSetup.TESTFIELD("NPO Prepayment req.subtype FND");
        PurchasesPayablesSetup.TESTFIELD("PO Prepayment req. Subtype FND");
        IF PurchHeader."Document Subtype Code FND" = PurchasesPayablesSetup."NPO Prepayment req.subtype FND" THEN BEGIN
            PurchasesPayablesSetup.TESTFIELD("NPOPrepaymentCrdMemosubtyp FND");
            PurchCrMemoHdr."Document Subtype Code FND" := PurchasesPayablesSetup."NPOPrepaymentCrdMemosubtyp FND";
        END;
        IF PurchHeader."Document Subtype Code FND" = PurchasesPayablesSetup."PO Prepayment req. Subtype FND" THEN BEGIN
            PurchasesPayablesSetup.TESTFIELD("POPrepaymentCrdMemosubtype FND");
            PurchCrMemoHdr."Document Subtype Code FND" := PurchasesPayablesSetup."POPrepaymentCrdMemosubtype FND"
        END;
        //HEI.01<<

        //HEI.03>>
        IF PurchaseHeaderAdditional.GET(PurchHeader."Document Type", PurchHeader."No.") THEN BEGIN
            PurchCrMemoHdrAddition.INIT;
            PurchCrMemoHdrAddition.TRANSFERFIELDS(PurchaseHeaderAdditional);
            //HEI.06>>
            PurchCrMemoHdrAddition."No." := PurchCrMemoHdr."No.";
            //HEI.06<<
            PurchCrMemoHdrAddition.INSERT;
        END;
        //HEI.03<<
        PurchCrMemoHdr.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purchase-Post Prepayments", OnBeforePostVendorEntry, '', false, false)]
    local procedure PurchasePostPrepaymentsOnBeforePostVendorEntry(var GenJnlLine: Record "Gen. Journal Line"; TotalPrepmtInvLineBuffer: Record "Prepayment Inv. Line Buffer"; TotalPrepmtInvLineBufferLCY: Record "Prepayment Inv. Line Buffer"; CommitIsSupressed: Boolean; PurchaseHeader: Record "Purchase Header"; DocumentType: Option Invoice,"Credit Memo")
    begin
        //HEI.01>>
        GenJnlLine."Payment Method Code" := PurchaseHeader."Payment Method Code";
        PurchasesPayablesSetup.GET();
        IF (DocumentType = DocumentType::Invoice) AND (PurchaseHeader."Document Subtype Code FND" <> '') THEN BEGIN
            PurchasesPayablesSetup.TESTFIELD("NPO Prepayment req.subtype FND");
            PurchasesPayablesSetup.TESTFIELD("PO Prepayment req. Subtype FND");
            IF PurchaseHeader."Document Subtype Code FND" = PurchasesPayablesSetup."NPO Prepayment req.subtype FND" THEN BEGIN
                PurchasesPayablesSetup.TESTFIELD("NPO Prepayment inv.subtype FND");
                GenJnlLine."Document Subtype Code FND" := PurchasesPayablesSetup."NPO Prepayment inv.subtype FND"
            END;
            IF PurchaseHeader."Document Subtype Code FND" = PurchasesPayablesSetup."PO Prepayment req. Subtype FND" THEN BEGIN
                PurchasesPayablesSetup.TESTFIELD("PO Prepayment inv. subtype FND");
                GenJnlLine."Document Subtype Code FND" := PurchasesPayablesSetup."PO Prepayment inv. subtype FND"
            END;
        END;
        IF (DocumentType = DocumentType::"Credit Memo") AND (PurchaseHeader."Document Subtype Code FND" <> '') THEN BEGIN
            PurchasesPayablesSetup.TESTFIELD("NPO Prepayment req.subtype FND");
            PurchasesPayablesSetup.TESTFIELD("PO Prepayment req. Subtype FND");
            IF PurchaseHeader."Document Subtype Code FND" = PurchasesPayablesSetup."NPO Prepayment req.subtype FND" THEN BEGIN
                PurchasesPayablesSetup.TESTFIELD("NPOPrepaymentCrdMemosubtyp FND");
                GenJnlLine."Document Subtype Code FND" := PurchasesPayablesSetup."NPOPrepaymentCrdMemosubtyp FND";
            END;
            IF PurchaseHeader."Document Subtype Code FND" = PurchasesPayablesSetup."PO Prepayment req. Subtype FND" THEN BEGIN
                PurchasesPayablesSetup.TESTFIELD("POPrepaymentCrdMemosubtype FND");
                GenJnlLine."Document Subtype Code FND" := PurchasesPayablesSetup."POPrepaymentCrdMemosubtype FND";
            END;
        END;
        //HEI.01<<

        //HEI.02>>
        IF (GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Credit Memo") AND (PurchaseHeader."Prep. to reverse FND" <> '') THEN BEGIN
            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
            GenJnlLine."Applies-to Doc. No." := PurchaseHeader."Prep. to reverse FND";
        END;
        //HEI.02<<
    end;

    // BC Upgrade VAMSIU01 Codeunit 444 "Purchase-Post Prepayments" <<

    // BC Upgrade VAMSIU01 Codeunit 92 "Purch.-Post + Print" >>
    // # The logic written in the PrintReceive procedure in Navision has been implemented using the OnBeforePrintReceive Event.
    // # The logic written in the PrintInvoice procedure in Navision has been implemented using the OnBeforePrintInvoice Event.
    // # The logic written in the PrintShip procedure in Navision has been implemented using the OnBeforePrintShip Event.
    // # The logic written in the PrintCrMemo procedure in Navision has been implemented using the OnBeforePrintCrMemo Event.

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post + Print", OnBeforePrintReceive, '', false, false)]
    local procedure "Purch.-Post + Print_OnBeforePrintReceive"(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
    begin
        IsHandled := true;

        PurchRcptHeader."No." := PurchaseHeader."Last Receiving No.";
        PurchRcptHeader.SetRecFilter();
        PurchRcptHeader."Document Subtype Code FND" := PurchaseHeader."Document Subtype Code FND";
        PurchRcptHeader.PrintRecords(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post + Print", OnBeforePrintInvoice, '', false, false)]
    local procedure "Purch.-Post + Print_OnBeforePrintInvoice"(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        IsHandled := true;

        if PurchaseHeader."Last Posting No." = '' then
            PurchInvHeader."No." := PurchaseHeader."No."
        else
            PurchInvHeader."No." := PurchaseHeader."Last Posting No.";
        PurchInvHeader.SetRecFilter();
        PurchInvHeader."Document Subtype Code FND" := PurchaseHeader."Document Subtype Code FND";
        PurchInvHeader.PrintRecords(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post + Print", OnBeforePrintShip, '', false, false)]
    local procedure "Purch.-Post + Print_OnBeforePrintShip"(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        ReturnShptHeader: Record "Return Shipment Header";
    begin
        IsHandled := true;

        ReturnShptHeader."No." := PurchaseHeader."Last Return Shipment No.";
        ReturnShptHeader.SetRecFilter();
        ReturnShptHeader."Document Subtype Code FND" := PurchaseHeader."Document Subtype Code FND";
        ReturnShptHeader.PrintRecords(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post + Print", OnBeforePrintCrMemo, '', false, false)]
    local procedure "Purch.-Post + Print_OnBeforePrintCrMemo"(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
    begin
        IsHandled := true;

        if PurchaseHeader."Last Posting No." = '' then
            PurchCrMemoHdr."No." := PurchaseHeader."No."
        else
            PurchCrMemoHdr."No." := PurchaseHeader."Last Posting No.";
        PurchCrMemoHdr.SetRecFilter();
        PurchCrMemoHdr."Document Subtype Code FND" := PurchaseHeader."Document Subtype Code FND";
        PurchCrMemoHdr.PrintRecords(false);
    end;

    // BC Upgrade VAMSIU01 Codeunit 92 "Purch.-Post + Print" <<
    // BC Upgrade BHARDA11 << --FDD STP 004
    // FDD STP 004
    [EventSubscriber(ObjectType::Table, Database::Currency, 'OnAfterInitRoundingPrecision', '', false, false)]
    local procedure OnAfterInitRoundingPrecision(var Currency: Record Currency; var xCurrency: Record Currency; var GeneralLedgerSetup: Record "General Ledger Setup")
    var
        TaxManagementSetup: Record "TaxManagementSetup102FDW"; // For this we need to add dependency Aptean Beverage Tax Management for Drink-IT Edition
        TransferLine: Record "Transfer Shipment Line";
        PurLine: Record "Purchase Line";
    begin
        // 
        IF TaxManagementSetup."Amount Rnd. Prec. 102FDW" <> 0 THEN
            Currency."Tax Amount Rounding Prec.1 FND" := TaxManagementSetup."Amount Rnd. Prec. 102FDW"
        ELSE
            Currency."Tax Amount Rounding Prec.1 FND" := 0.01;
        IF TaxManagementSetup."Unit Amt Rnd Prec. 102FDW" <> 0 THEN
            Currency."Tax UnitAmt Rounding Prec1 FND" := TaxManagementSetup."Unit Amt Rnd Prec. 102FDW"
        ELSE
            Currency."Tax UnitAmt Rounding Prec1 FND" := 0.00001;
        // 

        // DITW15.00.00.24 DDR
    end;
    // FDD STP 004
    // BC Upgrade BHARDA11 >>
    [EventSubscriber(ObjectType::Table, Database::"Vendor Bank Account", OnBeforeDeleteEvent, '', false, false)]
    local procedure OnBeforeDeleteVendorBankAccount(var Rec: Record "Vendor Bank Account"; RunTrigger: Boolean)
    var
        Vendor: Record Vendor;
        VendBankAcc: Record "Vendor Bank Account";
        RemainingBankAcc: Record "Vendor Bank Account";
        cnt: Integer;
    begin
        if RunTrigger = false then
            exit;

        // Count remaining bank accounts (excluding the one being deleted)
        VendBankAcc.Reset();
        VendBankAcc.SetRange("Vendor No.", Rec."Vendor No.");
        VendBankAcc.SetFilter(Code, '<>%1', Rec.Code);

        cnt := 0;
        if VendBankAcc.FindSet() then
            repeat
                cnt := cnt + 1;
            until VendBankAcc.Next() = 0;

        // Now update Vendor's Preferred Bank Account
        if Vendor.Get(Rec."Vendor No.") then begin
            if cnt = 1 then begin
                // Exactly 1 remaining → set that as preferred
                VendBankAcc.Reset();
                VendBankAcc.SetRange("Vendor No.", Rec."Vendor No.");
                VendBankAcc.SetFilter(Code, '<>%1', Rec.Code);
                if VendBankAcc.FindFirst() then
                    Vendor."Preferred Bank Account Code" := VendBankAcc.Code;
            end else begin
                // 0 or more than 1 remaining → blank it
                Vendor."Preferred Bank Account Code" := '';
            end;
            Vendor.Modify();
            Vendor.Validate("Payment Method Code");
        end;
    end;
    // BC Upgrade BHARDA11 <<

    // BC Upgrade - RD03 subscribed event to copy and insert the attachments to archive table ------------------- >>

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnAfterStorePurchDocument', '', false, false)]
    local procedure OnAfterStorePurchDocument(
        var PurchaseHeader: Record "Purchase Header";
        var PurchaseHeaderArchive: Record "Purchase Header Archive")
    begin
        CopyAttachmentsToPurchArchive(PurchaseHeader, PurchaseHeaderArchive);
    end;

    local procedure CopyAttachmentsToPurchArchive(
    PurchaseHeader: Record "Purchase Header";
    PurchaseHeaderArchive: Record "Purchase Header Archive")
    var
        DocumentAttachment: Record "Document Attachment";
        NewDocumentAttachment: Record "Document Attachment";
    begin
        DocumentAttachment.SetRange("Table ID", Database::"Purchase Header");
        DocumentAttachment.SetRange("No.", PurchaseHeader."No.");

        if DocumentAttachment.FindSet() then
            repeat
                NewDocumentAttachment.Init();
                NewDocumentAttachment := DocumentAttachment;
                NewDocumentAttachment."Table ID" := Database::"Purchase Header Archive";

                NewDocumentAttachment."No." := PurchaseHeaderArchive."No.";
                if not NewDocumentAttachment.Insert(true) then;
            until DocumentAttachment.Next() = 0;
    end;
    // BC Upgrade - RD03 subscribed event to copy and insert the attachments to archive table ------------------- <<

    // BC Upgrade - RD03 subscribed event to open the attached attachments from our custom page ------------------- >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", OnAfterSetDocumentAttachmentFiltersForRecRefInternal, '', false, false)]
    local procedure OnAfterSetDocumentAttachmentFiltersForRecRefInternal(var DocumentAttachment: Record "Document Attachment"; RecordRef: RecordRef; GetRelatedAttachments: Boolean)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        if ((not GetRelatedAttachments) and (RecordRef.Number = Database::"Purchase Header Archive")) then begin

            DocumentAttachment.SetRange("Table ID", RecordRef.Number());

            FieldRef := RecordRef.Field(3);
            RecNo := FieldRef.Value();
            DocumentAttachment.SetRange("No.", RecNo);
        end;
    end;
    // BC Upgrade - RD03 subscribed event to open the attached attachments from our custom page ------------------- <<
    //BC UPGRADE ATHUKS01 FDDSTP_GAP11 >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Get Source Doc. Inbound", OnAfterCreateWhseReceiptHeaderFromWhseRequest, '', false, false)]
    local procedure GetSourceDocInbound_OnAfterCreateWhseReceiptHeaderFromWhseRequest(var WhseReceiptHeader: Record "Warehouse Receipt Header"; var WarehouseRequest: Record "Warehouse Request"; var GetSourceDocuments: Report "Get Source Documents")
    var
        WhseRecptLine: Record "Warehouse Receipt Line";
        WhRequest: Record "Warehouse Request";
    begin
        WhseRecptLine.SetRange("No.", WhseReceiptHeader."No.");
        if WhseRecptLine.FindFirst() then
            repeat
                WhRequest.SetRange("Source Document", WhseRecptLine."Source Document");
                WhRequest.SetRange("Source Type", WhseRecptLine."Source Type");
                WhRequest.SetRange("Source Subtype", WhseRecptLine."Source Subtype");
                WhRequest.SetRange("Source No.", WhseRecptLine."Source No.");
                if not WhRequest.IsEmpty then begin
                    WhRequest.FindFirst();
                    WhRequest."Warehouse Rcpt/Shpt No. FND" := WhseRecptLine."No.";
                    WhRequest.Modify();
                end else
                    exit;
            until WhseRecptLine.Next() = 0;
    end;
    //BC UPGRADE ATHUKS01 FDDSTP_GAP11 <<

    // BC UPGRADE PATELS08 << ----------- Codeunit 1255 Match Bank Payments   
    // BC Upgrade ATHUKS01 >>
    //1. Copy Vendor Bank Account, On Hold Date and On Hold UserId from Purch. Inv. Header/Purch. Cr. Memo Hdr. to Vendor Ledger Entry during SuggestVedorPayments.
    //2. By pass Esker Validation for Esker Invoice Process based on RUID in Purchase Header.
    //BC Upgrade ATHUKS01<<

    //BC Upgrade ATHUKS01>>
    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", OnAfterCopyVendLedgerEntryFromGenJnlLine, '', false, false)]
    local procedure CopyFromGenJnlLineVLE2(GenJournalLine: Record "Gen. Journal Line"; var VendorLedgerEntry: Record "Vendor Ledger Entry")
    var
        PurInvHeader: Record "Purch. Inv. Header";
        PurchCrHeader: Record "Purch. Cr. Memo Hdr.";
        VendorBankAccount: Record "Vendor Bank Account";
    begin
        if VendorLedgerEntry."Document Type" = VendorLedgerEntry."Document Type"::Invoice then begin
            IF PurInvHeader.Get(VendorLedgerEntry."Document No.") then;
            VendorLedgerEntry."Vendor Bank Account FND" := PurInvHeader."Vendor Bank Account FND";
            VendorLedgerEntry."On Hold Date FND" := PurInvHeader."On Hold Date FND";
            VendorLedgerEntry."On Hold UserId FND" := PurInvHeader."On Hold UserId FND";
        end else if VendorLedgerEntry."Document Type" = VendorLedgerEntry."Document Type"::"Credit Memo" then begin
            if PurchCrHeader.Get(VendorLedgerEntry."Document No.") then;
            VendorLedgerEntry."Vendor Bank Account FND" := PurchCrHeader."Vendor Bank Account FND";
            VendorLedgerEntry."On Hold Date FND" := PurchCrHeader."On Hold Date FND";
            VendorLedgerEntry."On Hold UserId FND" := PurchCrHeader."On Hold UserId FND";
        end;
    end;

    //By pass Esker Validation//
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnBeforeCheckLineAmount, '', false, false)]
    local procedure "PurchaseLine_OnBeforeCheckLineAmount"(var PurchaseLine: Record "Purchase Line"; MaxLineAmount: Decimal; var IsHandled: Boolean; CalledByFieldNo: Integer)
    var
        PurchHeader: Record "Purchase Header";
    begin
        if PurchHeader.get(PurchaseLine."Document Type", PurchaseLine."Document No.") then begin
            if PurchHeader."RUID FND" <> '' then
                IsHandled := true;
        end;
    end;

    // By pass Esker Validation//
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnBeforeUpdateLineDiscPct, '', false, false)]
    local procedure "Purchase Line_OnBeforeUpdateLineDiscPct"(var PurchaseLine: Record "Purchase Line"; Currency: Record Currency; var IsHandled: Boolean; CurrentFiledNo: Integer)
    var
        PurchHeader: Record "Purchase Header";
        LineDiscountPct: Decimal;
    begin
        if PurchHeader.get(PurchaseLine."Document Type", PurchaseLine."Document No.") then begin
            if PurchHeader."RUID FND" <> '' then begin

                if Round(PurchaseLine.Quantity * PurchaseLine."Direct Unit Cost", Currency."Amount Rounding Precision") <> 0 then begin
                    LineDiscountPct := Round(
                        PurchaseLine."Line Discount Amount" / Round(PurchaseLine.Quantity * PurchaseLine."Direct Unit Cost", Currency."Amount Rounding Precision") * 100,
                        0.00001);

                    PurchaseLine."Line Discount %" := LineDiscountPct;
                end else
                    PurchaseLine."Line Discount %" := 0;
                IsHandled := true;
            end;

        end;
    end;
    //BC Upgrade ATHUKS01<<
    //BC Upgrade SHARMP16 BEGIN<<==Importchanges
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header Additional FND", OnAfterInsertEvent, '', false, false)]
    local procedure OnAfterInsertPurchHeaderAdd(RunTrigger: Boolean; var Rec: Record "Purchase Header Additional FND")
    var
        PurchasespayableSetup: Record "Purchases & Payables Setup";
        PurchaseHeaderAdditionaTest: Record "Purchase Header Additional FND";//BC Upgrade SHARMP16--
        PurchaseHeader: Record "Purchase Header";
    begin
        if (Rec."Import Identifier" = false) and (Rec."Document Type" = Rec."Document Type"::Order) then begin

            PurchasespayableSetup.Get();
            if PurchaseHeader.GET(Rec."Document Type", Rec."No.") then begin
                if not CheckShippingMethod(PurchasespayableSetup, PurchaseHeader) then
                    Rec."Import Identifier" := true
                else
                    Rec."Import Identifier" := false;
                if PurchaseHeader."Shipment Method Code" = '' then
                    rec."Import Identifier" := false;
                rec.MODIFY();
            end;
        end;

    end;



    procedure CheckShippingMethod(PurchasesPayablesSetup: Record "Purchases & Payables Setup"; var PurchaseHeader: Record "Purchase Header"): Boolean;
    var
        ShipmentMethod: Record "Shipment Method";
        PurchasePayableSetup: Record "Purchases & Payables Setup";
    begin
        //>> HEI.59
        PurchasePayableSetup.Get();
        //HEI.152>>
        if PurchasePayableSetup."Excluded Countries Imp PO FND" <> '' then
            if STRPOS(PurchasePayableSetup."Excluded Countries Imp PO FND", PurchaseHeader."Buy-from Country/Region Code") <> 0 then
                exit(true);
        //HEI.152<<
        ShipmentMethod.RESET();
        ShipmentMethod.SETFILTER(Code, PurchasePayableSetup."Excluded Incoterms FND");
        if ShipmentMethod.findset() then begin
            repeat
                if (PurchaseHeader."Shipment Method Code" = ShipmentMethod.Code) or (PurchaseHeader."Shipment Method Code" = '') then
                    exit(true);
            until ShipmentMethod.NEXT() = 0;
        end;
        exit(false);
        //<< HEI.59
    end;
    //BC Upgrade SHARMP16 END>>

    // BC Upgrade BHARDA11 >> -- While Doing MakeOrder Process Purchase Quote to Purchase Order and Blanket Purchase Order To Purchase Order. Flow Document Subtype Code 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", OnCreatePurchHeaderOnAfterPurchOrderHeaderInsert, '', false, false)]
    local procedure OnCreatePurchHeaderOnAfterPurchOrderHeaderInsert(var PurchOrderHeader: Record "Purchase Header"; BlanketOrderPurchHeader: Record "Purchase Header")
    var
        PurchPaySetup: Record "Purchases & Payables Setup";
    begin
        PurchPaySetup.Get();
        PurchOrderHeader."Document Subtype Code FND" := PurchPaySetup."PO Subtype Code FND";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Purch. Order to Order", OnCreatePurchHeaderOnAfterPurchOrderHeaderInsert, '', false, false)]

    local procedure POOnCreatePurchHeaderOnAfterPurchOrderHeaderInsert(PurchHeader: Record "Purchase Header"; var PurchOrderHeader: Record "Purchase Header")
    var
        PurchPaySetup: Record "Purchases & Payables Setup";
    begin
        PurchPaySetup.Get();
        PurchOrderHeader."Document Subtype Code FND" := PurchPaySetup."PO Subtype Code FND";
    end;
    // BC Upgrade BHARDA11 <<

}