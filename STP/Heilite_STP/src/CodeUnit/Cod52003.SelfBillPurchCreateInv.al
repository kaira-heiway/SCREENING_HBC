codeunit 52003 "Self-Bill PurchCreateInv"
{
    // version SB,HEI.02
    //BC upgrade Kamnay01 Original(Heilite) Cu id 50106
    // HEI.01 FDD-HD-545 IBM POSTOI01 11.10.2019 # Self-Billing
    // # new object
    // HEI.02 FDD-HD-545 IBM POSTOI01 27.11.2019 # Self-Billing
    //     #define global variable PurchPaySetup
    //     #add the Document SubType code to the Purchase Header
    // HEI.03 defect # 5081 IBM POSTOI01 18.02.2020 # Self-Billing
    //     #the Payment Status for the purchase invoice should "Payment Approved"

    Permissions = TableData "Purch. Rcpt. Line" = rm;
    TableNo = "Purch. Rcpt. Line";

    trigger OnRun();
    begin
        CLEAR(PurchHeader);
        PurchHeader.INIT();
        PurchHeader."Document Type" := PurchHeader."Document Type"::Invoice;
        PurchHeader."No. Printed" := 0;
        PurchHeader.Status := PurchHeader.Status::Open;
        PurchHeader."No." := '';
        PurchHeader.LOCKTABLE();
        PurchHeader.INSERT(true);
        PurchHeader."Vendor Invoice No." := PurchHeader."No.";
        PurchHeader.VALIDATE("Buy-from Vendor No.", Rec."Buy-from Vendor No.");
        VendorBankAcc.RESET();
        VendorBankAcc.SETRANGE("Vendor No.", Rec."Buy-from Vendor No.");
        if VendorBankAcc.FINDFIRST() then
            PurchHeader."Vendor Bank Account FND" := VendorBankAcc.Code;
        //HEI.02>>
        PurchPaySetup.GET();
        PurchHeader."Document Subtype Code FND" := PurchPaySetup."PO Subtype Code FND";//BC Upgrade SHUKLP03.
        //HEi.02<<
        PurchHeader.MODIFY();



        Purch_GetReceipts.SetPurchHeader(PurchHeader);
        Purch_GetReceipts.CreateInvLines(Rec);


        //make the totals
        TotDocWithVAT := 0;
        TotDocWithoutVAT := 0;
        LPurchLine.RESET();
        LPurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        LPurchLine.SETRANGE("Document No.", PurchHeader."No.");
        if LPurchLine.FINDSET() then
            repeat
                TotDocWithVAT += LPurchLine."Amount Including VAT";
                TotDocWithoutVAT += LPurchLine.Amount;
            until LPurchLine.NEXT() = 0;
        PurchHeader."Doc. Amount Incl. VAT IBM FND" := TotDocWithVAT;
        PurchHeader."Doc. Amount VAT IBM FND" := TotDocWithVAT - TotDocWithoutVAT;
        PurchHeader."Job Queue Status" := PurchHeader."Job Queue Status"::Posting;
        //HEI.03>>
        PurchHeader."Payment Status FND" := PurchHeader."Payment Status FND"::"Payment Approved";
        //HEI.03<<
        PurchHeader.MODIFY();
        Rec."Self_Billing Inv. No. FND" := PurchHeader."No.";
        Rec.MODIFY();
    end;

    var
        PurchHeader: Record "Purchase Header";
        Purch_GetReceipts: Codeunit "Purch.-Get Receipt";
        VendorBankAcc: Record "Vendor Bank Account";
        TotDocWithVAT: Decimal;
        TotDocWithoutVAT: Decimal;
        LPurchLine: Record "Purchase Line";
        PurchPaySetup: Record "Purchases & Payables Setup";

    procedure SetPurchHeader(lPurchHeader: Record "Purchase Header");
    begin
        PurchHeader.GET(lPurchHeader."Document Type", lPurchHeader."No.")
    end;
}

