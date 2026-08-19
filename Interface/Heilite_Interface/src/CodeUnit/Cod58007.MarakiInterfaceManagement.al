codeunit 58007 "Maraki Interface Management"
{
    // Heilite Navision Old Id - 50082

    // version HEI.02

    // HEI.01 FDD-ET-MARAKI POS Interface IBM NASTAA02 24.06.2018 # Maraki POS Interface
    //   # New Codeunit created for Maraki Interface
    // HEI.02 FDD-ET-MARAKI POS Interface IBM POSTOI01 # Maraki POS Interface
    //   # modify CreateInvoiceRequest and CreateCrMemoRequest. Correct the Unit price calculation and the Item Discount Amount.
    //   The Unit Price value should not include the VAT
    // HEI.03 HT1010 IBM NASTAA02 03.12.2019 # Maraki dedicated Job Queue - CHG2039961
    //   # Used VIP Interface Objects for Maraki

    // BC Upgrade PATELP08>>
    // Changed name of table from "EBM Item Charge" to "EBM Item Charge FND"
    // Changed name of table from "EBM Log" to "EBM Log FND"
    // BC Upgrade PATELP08<<

    // BC UPGRADE PATELS08 >>
    // # Table name changed from "Maraki Suppress Values" to "Maraki Suppress Values FND"
    // BC UPGRADE PATELS08 <<

    Permissions = TableData "Sales Invoice Header" = rm,
                  TableData "Sales Cr.Memo Header" = rm;

    trigger OnRun();
    begin
    end;

    var
        GLSetup: Record "General Ledger Setup";
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        MarakiInterfaceSetup: Record "Maraki Interface Setup INT";
        InterfaceFrameworkMgtVIP: Codeunit "Interface Framework Mgt. VIP";
        GLSetupRead: Boolean;
        GeneralOpCoSetupRead: Boolean;
        GeneralInterfaceSetupRead: Boolean;
        MarakiInterfaceSetupRead: Boolean;
        ReceivedInHeiLiteTxt: Label 'Received in HeiLite';
        SentToMiddlewareTxt: Label 'Sent to middleware';
        NotSentToMiddlewareTxt: Label 'Not sent to middleware.\ Error message: %1.';
        IncorrectFormatErr: Label '%1 has an incorrect format. Current value is %2.';

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header");
    begin
        GetGeneralOpCoSetup();
        if not GeneralOpCoSetup."Enable Send to Maraki" then
            exit;

        CheckSalesHeader(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]);
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        GetGeneralOpCoSetup();
        if not GeneralOpCoSetup."Enable Send to Maraki" then
            exit;

        if SalesInvHdrNo <> '' then begin
            SalesInvoiceHeader.GET(SalesInvHdrNo);
            ProcessSalesInvoicePosting(SalesInvoiceHeader);
        end else
            if SalesCrMemoHdrNo <> '' then begin
                SalesCrMemoHeader.GET(SalesCrMemoHdrNo);
                ProcessSalesCrMemoPosting(SalesCrMemoHeader);
            end;
    end;

    procedure ManualSalesInvoicePosting(SalesInvoiceHeader: Record "Sales Invoice Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        EBMLog: Record "EBM Log FND";
    begin
        GetGeneralOpCoSetup();
        if not GeneralOpCoSetup."Enable Send to Maraki" then
            exit;
        GetMarakiInterfaceSetup();
        MarakiInterfaceSetup.TESTFIELD("Sales Posting Interface");
        InterfaceSetup.GET(MarakiInterfaceSetup."Sales Posting Interface");
        if not InterfaceSetup.Enabled then
            exit;

        if SalesInvoiceHeader."Suppress POS Interface FND" then begin
            EBMLog.SETRANGE("Document Type", EBMLog."Document Type"::Invoice);
            EBMLog.SETRANGE("Document No.", SalesInvoiceHeader."No.");
            if not EBMLog.FINDFIRST() then begin
                CLEAR(EBMLog);
                EBMLog.INIT();
                EBMLog."Document Type" := EBMLog."Document Type"::Invoice;
                EBMLog."Document No." := SalesInvoiceHeader."No.";
                EBMLog.INSERT();
            end;
            EBMLog."Maraki Supress Value" := SalesInvoiceHeader."Suppress POS Interface FND";
            EBMLog.MODIFY();
            exit;
        end;

        if SalesInvoiceHeader."Fiscal Printer Status FND" <= SalesInvoiceHeader."Fiscal Printer Status FND"::"Not Sent to Fiscal Printer" then
            InterfaceEntryHeaderVIP.SETRANGE("Interface Code", MarakiInterfaceSetup."Sales Posting Interface");
        InterfaceEntryHeaderVIP.SETRANGE(Direction, InterfaceEntryHeaderVIP.Direction::Outbound);
        InterfaceEntryHeaderVIP.SETRANGE(Status, InterfaceEntryHeaderVIP.Status::Error);
        InterfaceEntryHeaderVIP.SETRANGE("Source No.", SalesInvoiceHeader."No.");
        if InterfaceEntryHeaderVIP.FINDLAST() then begin
            InterfaceEntryHeaderVIP.ClearError();
            ProcessOutboundInvoiceEntry(SalesInvoiceHeader, InterfaceEntryHeaderVIP);
        end else begin
            InterfaceEntryHeaderVIP.SETRANGE(Status, InterfaceEntryHeaderVIP.Status::Pending);
            if InterfaceEntryHeaderVIP.FINDLAST() then
                ProcessOutboundInvoiceEntry(SalesInvoiceHeader, InterfaceEntryHeaderVIP)
            else
                if SalesInvoiceHeader."Fiscal Printer Status FND" <= SalesInvoiceHeader."Fiscal Printer Status FND"::"Not Sent to Fiscal Printer" then
                    ProcessSalesInvoicePosting(SalesInvoiceHeader);
        end;
    end;

    procedure ManualSalesCrMemoPosting(SalesCrMemoHeader: Record "Sales Cr.Memo Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        EBMLog: Record "EBM Log FND";
    begin
        GetGeneralOpCoSetup();
        if not GeneralOpCoSetup."Enable Send to Maraki" then
            exit;
        GetMarakiInterfaceSetup();
        MarakiInterfaceSetup.TESTFIELD("Sales Posting Interface");
        InterfaceSetup.GET(MarakiInterfaceSetup."Sales Posting Interface");
        if not InterfaceSetup.Enabled then
            exit;
        if SalesCrMemoHeader."Suppress POS Interface FND" then begin
            EBMLog.SETRANGE("Document Type", EBMLog."Document Type"::"Credit Memo");
            EBMLog.SETRANGE("Document No.", SalesCrMemoHeader."No.");
            if not EBMLog.FINDFIRST() then begin
                CLEAR(EBMLog);
                EBMLog.INIT();
                EBMLog."Document Type" := EBMLog."Document Type"::"Credit Memo";
                EBMLog."Document No." := SalesCrMemoHeader."No.";
                EBMLog.INSERT();
            end;
            EBMLog."Maraki Supress Value" := SalesCrMemoHeader."Suppress POS Interface FND";
            EBMLog.MODIFY();
            exit;
        end;

        if SalesCrMemoHeader."Fiscal Printer Status FND" <= SalesCrMemoHeader."Fiscal Printer Status FND"::"Not Sent to Fiscal Printer" then
            InterfaceEntryHeaderVIP.SETRANGE("Interface Code", MarakiInterfaceSetup."Sales Posting Interface");
        InterfaceEntryHeaderVIP.SETRANGE(Direction, InterfaceEntryHeaderVIP.Direction::Outbound);
        InterfaceEntryHeaderVIP.SETRANGE(Status, InterfaceEntryHeaderVIP.Status::Error);
        InterfaceEntryHeaderVIP.SETRANGE("Source No.", SalesCrMemoHeader."No.");
        if InterfaceEntryHeaderVIP.FINDLAST() then begin
            InterfaceEntryHeaderVIP.ClearError();
            ProcessOutboundCrMemoEntry(SalesCrMemoHeader, InterfaceEntryHeaderVIP);
        end else begin
            InterfaceEntryHeaderVIP.SETRANGE(Status, InterfaceEntryHeaderVIP.Status::Pending);
            if InterfaceEntryHeaderVIP.FINDLAST() then
                ProcessOutboundCrMemoEntry(SalesCrMemoHeader, InterfaceEntryHeaderVIP)
            else
                if SalesCrMemoHeader."Fiscal Printer Status FND" <= SalesCrMemoHeader."Fiscal Printer Status FND"::"Not Sent to Fiscal Printer" then
                    ProcessSalesCrMemoPosting(SalesCrMemoHeader);
        end;
    end;

    procedure ProcessSalesConfirmationResponse(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT") ReturnValue: Text;
    var
        InterfaceSetup: Record "Interface Setup INT";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        EBMLog: Record "EBM Log FND";
        InterfaceEntryHeaderOut: Record "Interface Entry Header VIP INT";
        NewLine: Boolean;
    begin
        GetGeneralInterfaceSetup();
        GetMarakiInterfaceSetup();
        MarakiInterfaceSetup.TESTFIELD("Sales Confirmation Response");
        InterfaceSetup.GET(MarakiInterfaceSetup."Sales Confirmation Response");
        if not InterfaceSetup.Enabled then
            exit;

        //SalesCrMemoHeader.SETRANGE("Applies-to Doc. No.",InterfaceEntryHeader."Source No.");
        //SalesCrMemoHeader.SETFILTER("Fiscal Printer Status",'%1|%2',SalesCrMemoHeader."Fiscal Printer Status FND"::"Received in Fiscal Printer",SalesCrMemoHeader."Fiscal Printer Status FND"::"Error in Fiscal Printer or RRA");
        if SalesCrMemoHeader.GET(InterfaceEntryHeaderVIP."Source No.") then begin
            SalesCrMemoHeader."Fiscal Printer Status FND" := SalesCrMemoHeader."Fiscal Printer Status FND"::"Fiscal Printer No. Received";
            SalesCrMemoHeader.MODIFY();
            EBMLog.SETRANGE("Document Type", EBMLog."Document Type"::"Credit Memo");
            EBMLog.SETRANGE("Document No.", InterfaceEntryHeaderVIP."Source No.");
            if not EBMLog.FINDFIRST() then begin
                NewLine := true;
                CLEAR(EBMLog);
                EBMLog."Document Type" := EBMLog."Document Type"::"Credit Memo";
                EBMLog."Document No." := SalesCrMemoHeader."No.";
            end;
        end else
            if SalesInvoiceHeader.GET(InterfaceEntryHeaderVIP."Source No.") then begin
                SalesInvoiceHeader."Fiscal Printer Status FND" := SalesInvoiceHeader."Fiscal Printer Status FND"::"Fiscal Printer No. Received";
                SalesInvoiceHeader.MODIFY();
                EBMLog.SETRANGE("Document Type", EBMLog."Document Type"::Invoice);
                EBMLog.SETRANGE("Document No.", InterfaceEntryHeaderVIP."Source No.");
                if not EBMLog.FINDFIRST() then begin
                    NewLine := true;
                    CLEAR(EBMLog);
                    EBMLog."Document Type" := EBMLog."Document Type"::Invoice;
                    EBMLog."Document No." := SalesInvoiceHeader."No.";
                end;
            end;

        EBMLog."Maraki Fiscal No." := InterfaceEntryHeaderVIP.County;
        EBMLog."Maraki Posted Date" := InterfaceEntryHeaderVIP."Posting Date";
        EBMLog."Maraki Machine No." := InterfaceEntryHeaderVIP."Buy-from Vendor No.";
        if NewLine then
            EBMLog.INSERT()
        else
            EBMLog.MODIFY();
    end;

    procedure ProcessStatusUpdate(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT") ReturnValue: Text;
    var
        InterfaceSetup: Record "Interface Setup INT";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        GetGeneralInterfaceSetup();
        GetMarakiInterfaceSetup();
        MarakiInterfaceSetup.TESTFIELD("Status Update Interface");
        InterfaceSetup.GET(MarakiInterfaceSetup."Status Update Interface");
        if not InterfaceSetup.Enabled then
            exit;

        //SalesCrMemoHeader.SETRANGE("Applies-to Doc. No.",InterfaceEntryHeader."Source No.");
        //SalesCrMemoHeader.SETFILTER("Fiscal Printer Status",'%1|%2|%3',SalesCrMemoHeader."Fiscal Printer Status"::"Sent to Middleware",
        //SalesCrMemoHeader."Fiscal Printer Status"::"Received in Fiscal Printer",
        //SalesCrMemoHeader."Fiscal Printer Status"::"Error in Fiscal Printer or RRA");
        if SalesCrMemoHeader.GET(InterfaceEntryHeaderVIP."Source No.") then begin
            EVALUATE(SalesCrMemoHeader."Fiscal Printer Status FND", InterfaceEntryHeaderVIP."Pay-to Vendor No.");
            SalesCrMemoHeader.MODIFY();
        end else
            if SalesInvoiceHeader.GET(InterfaceEntryHeaderVIP."Source No.") then begin
                EVALUATE(SalesInvoiceHeader."Fiscal Printer Status FND", InterfaceEntryHeaderVIP."Pay-to Vendor No.");
                SalesInvoiceHeader.MODIFY();
            end;
    end;

    local procedure ProcessSalesInvoicePosting(SalesInvoiceHeader: Record "Sales Invoice Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        EBMLog: Record "EBM Log FND";
    begin
        if SalesInvoiceHeader."Fiscal Printer Status FND" > SalesInvoiceHeader."Fiscal Printer Status FND"::"Not Sent to Fiscal Printer" then
            exit;
        if SalesInvoiceHeader."Suppress POS Interface FND" then begin
            EBMLog.SETRANGE("Document Type", EBMLog."Document Type"::Invoice);
            EBMLog.SETRANGE("Document No.", SalesInvoiceHeader."No.");
            if not EBMLog.FINDFIRST() then begin
                CLEAR(EBMLog);
                EBMLog.INIT();
                EBMLog."Document Type" := EBMLog."Document Type"::Invoice;
                EBMLog."Document No." := SalesInvoiceHeader."No.";
                EBMLog.INSERT();
            end;
            EBMLog."Maraki Supress Value" := SalesInvoiceHeader."Suppress POS Interface FND";
            EBMLog.MODIFY();
            exit;
        end;

        GetGLSetup();
        GetGeneralInterfaceSetup();
        GetMarakiInterfaceSetup();

        MarakiInterfaceSetup.TESTFIELD("Sales Posting Interface");
        InterfaceSetup.GET(MarakiInterfaceSetup."Sales Posting Interface");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgtVIP.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CreateInvoiceRequest(SalesInvoiceHeader, InterfaceEntryHeaderVIP, true);

        ProcessOutboundInvoiceEntry(SalesInvoiceHeader, InterfaceEntryHeaderVIP);
    end;

    local procedure ProcessSalesCrMemoPosting(SalesCrMemoHeader: Record "Sales Cr.Memo Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        EBMLog: Record "EBM Log FND";
    begin
        //IF SalesCrMemoHeader."Applies-to Doc. No." = '' THEN
        // EXIT;?
        if SalesCrMemoHeader."Fiscal Printer Status FND" > SalesCrMemoHeader."Fiscal Printer Status FND"::"Not Sent to Fiscal Printer" then
            exit;
        if SalesCrMemoHeader."Suppress POS Interface FND" then begin
            EBMLog.SETRANGE("Document Type", EBMLog."Document Type"::"Credit Memo");
            EBMLog.SETRANGE("Document No.", SalesCrMemoHeader."No.");
            if not EBMLog.FINDFIRST() then begin
                CLEAR(EBMLog);
                EBMLog.INIT();
                EBMLog."Document Type" := EBMLog."Document Type"::"Credit Memo";
                EBMLog."Document No." := SalesCrMemoHeader."No.";
                EBMLog.INSERT();
            end;
            EBMLog."Maraki Supress Value" := SalesCrMemoHeader."Suppress POS Interface FND";
            EBMLog.MODIFY();

            exit;
        end;

        GetGLSetup();
        GetGeneralInterfaceSetup();
        GetMarakiInterfaceSetup();
        MarakiInterfaceSetup.TESTFIELD("Sales Posting Interface");
        InterfaceSetup.GET(MarakiInterfaceSetup."Sales Posting Interface");
        if not InterfaceSetup.Enabled then
            exit;
        InterfaceFrameworkMgtVIP.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CreateCrMemoRequest(SalesCrMemoHeader, InterfaceEntryHeaderVIP, true);

        ProcessOutboundCrMemoEntry(SalesCrMemoHeader, InterfaceEntryHeaderVIP);
    end;

    local procedure CreateInvoiceRequest(SalesInvoiceHeader: Record "Sales Invoice Header"; var InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT"; WithLines: Boolean);
    var
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        SalesHeader: Record "Sales Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesInvoiceLine2: Record "Sales Invoice Line";
        SalesInvoiceLine3: Record "Sales Invoice Line";
        ParentSalesInvoiceLine: Record "Sales Invoice Line";
        TempSalesInvoiceLine: Record "Sales Invoice Line" temporary;
        ItemCharge: Record "Item Charge";
        EBMItemCharge: Record "EBM Item Charge FND";
        ItemLineBuffer: Record "CSV Buffer" temporary;
        UnitPrice: Decimal;
        LineDiscountAmount: Decimal;
        LineAmountExclVAT: Decimal;
        LineVATAmount: Decimal;
        LineAmount: Decimal;
        DocVATAmount: Decimal;
        DocAmountInclVAT: Decimal;
        EntryNo: Integer;
        Customer: Record Customer;
        PaymentMethod: Record "Payment Method";
        MarakiSuppressValues: Record "Maraki Suppress Values FND";
        ItemDiscAmt: Decimal;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
    begin
        CLEAR(InterfaceEntryHeaderVIP);
        if SalesInvoiceHeader."Fiscal Printer Status FND" <= SalesInvoiceHeader."Fiscal Printer Status FND"::"Not Sent to Fiscal Printer" then
            InterfaceEntryHeaderVIP."Interface Code" := MarakiInterfaceSetup."Sales Posting Interface";
        InterfaceEntryHeaderVIP.Direction := InterfaceEntryHeaderVIP.Direction::Outbound;
        InterfaceEntryHeaderVIP."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderVIP."Pay-to Vendor No." := 'INVOICE';
        InterfaceEntryHeaderVIP."Source Type" := DATABASE::"Sales Invoice Header";
        InterfaceEntryHeaderVIP."Source Subtype" := SalesHeader."Document Type"::Invoice.AsInteger();
        InterfaceEntryHeaderVIP."Source No." := SalesInvoiceHeader."No.";
        InterfaceEntryHeaderVIP."Posting Date" := SalesInvoiceHeader."Posting Date";
        InterfaceEntryHeaderVIP."Sell-to Customer No." := SalesInvoiceHeader."Bill-to Customer No.";
        InterfaceEntryHeaderVIP.Name := SalesInvoiceHeader."Bill-to Name";
        InterfaceEntryHeaderVIP.Address := COMPANYNAME;
        if InterfaceEntryHeaderVIP."Location Code" <> '' then
            InterfaceEntryHeaderVIP."Location Code" := SalesInvoiceHeader."Location Code"
        else begin
            SalesInvoiceLine2.SETRANGE("Document No.", SalesInvoiceHeader."No.");
            if SalesInvoiceLine2.FINDFIRST() then
                InterfaceEntryHeaderVIP."Location Code" := SalesInvoiceLine2."Location Code";
        end;
        Customer.GET(SalesInvoiceHeader."Bill-to Customer No.");
        // InterfaceEntryHeaderVIP."Global No." := Customer."Tax Registration No.";  // BC Upgrade NANDIS03 - Blocked as field "Tax Registration No." is of DIT
        if PaymentMethod.GET(SalesInvoiceHeader."Payment Method Code") then
            // BC Upgrade NANDIS03 - Blocked as field "Cash Payment" of Payment Method is of DIT field >>
            //     if PaymentMethod."Cash Payment" then
            //         InterfaceEntryHeaderVIP."Payment Terms Code" := 'CASH'
            //     else
            //         InterfaceEntryHeaderVIP."Payment Terms Code" := 'CREDIT'
            // else
            // BC Upgrade NANDIS03 - Blocked as field "Cash Payment" of Payment Method is of DIT field <<
            InterfaceEntryHeaderVIP."Payment Terms Code" := '';

        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
        InterfaceEntryHeaderVIP.INSERT(true);

        if WithLines then begin
            SalesInvoiceLine.SETFILTER("No.", '<>%1', '');
            SalesInvoiceLine.SETFILTER(Quantity, '<>%1', 0);
            // SalesInvoiceLine.SETFILTER("Item Charge Type", '<>%1', SalesInvoiceLine."Item Charge Type"::Discount);  // BC Upgrade NANDIS03 - Blocked as dependency on DIT
            if SalesInvoiceLine.findset() then
                repeat
                    MarakiSuppressValues.SETRANGE("No.", SalesInvoiceLine."No.");
                    if not MarakiSuppressValues.FINDFIRST() then begin
                        if SalesInvoiceHeader."Prices Including VAT" then begin
                            //HEI.02 comment line UnitPrice := ROUND(SalesInvoiceLine."Unit Price",GLSetup."Amount Rounding Precision");

                            //HEI.02>>
                            UnitPrice := ROUND(SalesInvoiceLine."Unit Price" / (1 + SalesInvoiceLine."VAT %" / 100), GLSetup."Amount Rounding Precision");
                            //HEI.02<<
                            LineAmount := ROUND(SalesInvoiceLine.Quantity * SalesInvoiceLine."Unit Price", GLSetup."Amount Rounding Precision");
                            LineAmountExclVAT := ROUND(LineAmount / (1 + SalesInvoiceLine."VAT %" / 100), GLSetup."Amount Rounding Precision");
                            LineVATAmount := LineAmount - LineAmountExclVAT;

                        end else begin
                            //HEI.02 comment line UnitPrice := ROUND((SalesInvoiceLine."Unit Price" + SalesInvoiceLine."Unit Price" * (SalesInvoiceLine."VAT %" / 100)),
                            //GLSetup."Amount Rounding Precision");
                            //HEI.02>>
                            UnitPrice := ROUND(SalesInvoiceLine."Unit Price", GLSetup."Amount Rounding Precision");
                            //HEI.02<<
                            LineAmountExclVAT := ROUND(SalesInvoiceLine.Quantity * SalesInvoiceLine."Unit Price", GLSetup."Amount Rounding Precision");
                            LineVATAmount := ROUND(LineAmountExclVAT * (SalesInvoiceLine."VAT %" / 100), GLSetup."Amount Rounding Precision");
                            LineAmount := LineAmountExclVAT + LineVATAmount;
                        end;

                        ItemDiscAmt := 0;
                        SalesInvoiceLine3.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
                        SalesInvoiceLine3.SETRANGE("Attached to Line No.", SalesInvoiceLine."Line No.");
                        // SalesInvoiceLine3.SETRANGE("Item Charge Type", SalesInvoiceLine3."Item Charge Type"::Discount);  // BC Upgrade NANDIS03 - Blocked as dependency on DIT
                        if SalesInvoiceLine3.findset() then
                            repeat
                                //HEI.02 ItemDiscAmt += ABS(ROUND(SalesInvoiceLine3."Unit Price" * SalesInvoiceLine3.Quantity,GLSetup."Amount Rounding Precision"));
                                //HEI.02>>
                                if SalesInvoiceHeader."Prices Including VAT" then
                                    ItemDiscAmt += ABS(ROUND((SalesInvoiceLine3."Unit Price" / (1 + SalesInvoiceLine3."VAT %" / 100)) * SalesInvoiceLine3.Quantity, GLSetup."Amount Rounding Precision"))
                                else
                                    ItemDiscAmt += ABS(ROUND(SalesInvoiceLine3."Unit Price" * SalesInvoiceLine3.Quantity, GLSetup."Amount Rounding Precision"));
                            //HEI.02<<
                            until SalesInvoiceLine3.NEXT() = 0;

                        TempSalesInvoiceLine.RESET();
                        TempSalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type);
                        TempSalesInvoiceLine.SETRANGE("No.", SalesInvoiceLine."No.");
                        TempSalesInvoiceLine.SETRANGE("Unit Price", SalesInvoiceLine."Unit Price");
                        if TempSalesInvoiceLine.FINDFIRST() then begin
                            TempSalesInvoiceLine.Quantity := TempSalesInvoiceLine.Quantity + SalesInvoiceLine.Quantity;
                            TempSalesInvoiceLine."Unit Price" := UnitPrice;
                            TempSalesInvoiceLine.Amount := TempSalesInvoiceLine.Amount + LineAmountExclVAT;
                            TempSalesInvoiceLine."Amount Including VAT" := TempSalesInvoiceLine."Amount Including VAT" + LineAmount;
                            TempSalesInvoiceLine."Line Discount Amount" := ItemDiscAmt;
                            TempSalesInvoiceLine.MODIFY();
                        end else begin
                            CLEAR(TempSalesInvoiceLine);
                            TempSalesInvoiceLine := SalesInvoiceLine;
                            TempSalesInvoiceLine."Unit Price" := UnitPrice;
                            TempSalesInvoiceLine.Amount := LineAmountExclVAT;
                            TempSalesInvoiceLine."Amount Including VAT" := LineAmount;
                            TempSalesInvoiceLine."Line Discount Amount" := ItemDiscAmt;
                            TempSalesInvoiceLine.INSERT();
                        end;
                    end;
                until SalesInvoiceLine.NEXT() = 0;

            TempSalesInvoiceLine.RESET();
            if TempSalesInvoiceLine.findset() then
                repeat
                    CLEAR(InterfaceEntryLineVIP);
                    InterfaceEntryLineVIP."Header Entry No." := InterfaceEntryHeaderVIP."Entry No.";
                    EntryNo := EntryNo + 1;
                    InterfaceEntryLineVIP."Entry No." := EntryNo;
                    InterfaceEntryLineVIP."Source Line No." := TempSalesInvoiceLine."Line No.";
                    InterfaceEntryLineVIP.Type := TempSalesInvoiceLine.Type.AsInteger();
                    InterfaceEntryLineVIP."No." := TempSalesInvoiceLine."No.";
                    InterfaceEntryLineVIP.Description := TempSalesInvoiceLine.Description;
                    InterfaceEntryLineVIP."Description 2" := TempSalesInvoiceLine."Description 2";
                    InterfaceEntryLineVIP."Location Code" := TempSalesInvoiceLine."Location Code";
                    InterfaceEntryLineVIP."Unit of Measure Code" := TempSalesInvoiceLine."Unit of Measure Code";
                    InterfaceEntryLineVIP."Currency Code" := InterfaceEntryHeaderVIP."Currency Code";
                    // BC Upgrade NANDIS03 - Blocked as dependency on DIT >>
                    // if TempSalesInvoiceLine."Item Charge Type" = TempSalesInvoiceLine."Item Charge Type"::Discount then
                    //     InterfaceEntryLineVIP.Quantity := ABS(TempSalesInvoiceLine.Quantity)
                    // else
                    //     InterfaceEntryLineVIP.Quantity := TempSalesInvoiceLine.Quantity;
                    // BC Upgrade NANDIS03 - Blocked as dependency on DIT <<
                    InterfaceEntryLineVIP."VAT %" := TempSalesInvoiceLine."VAT %";
                    //InterfaceEntryLine."VAT Amount" := TempSalesInvoiceLine."Amount Including VAT" - TempSalesInvoiceLine.Amount;
                    InterfaceEntryLineVIP."VAT Amount" := 0;
                    InterfaceEntryLineVIP."Line Amount" := TempSalesInvoiceLine."Amount Including VAT";

                    CurrencyExchangeRate.SETRANGE("Currency Code", Customer."Currency Code");
                    CurrencyExchangeRate.SETFILTER("Starting Date", '<=%1', InterfaceEntryHeaderVIP."Posting Date");
                    if CurrencyExchangeRate.FINDLAST() then begin
                        InterfaceEntryLineVIP."Discount %" := ROUND(TempSalesInvoiceLine."Line Discount Amount" * CurrencyExchangeRate."Relational Exch. Rate Amount", GLSetup."Amount Rounding Precision");
                        InterfaceEntryLineVIP."Unit Amount" := ROUND(TempSalesInvoiceLine."Unit Price" * CurrencyExchangeRate."Relational Exch. Rate Amount", GLSetup."Amount Rounding Precision");
                    end else begin
                        InterfaceEntryLineVIP."Discount %" := ROUND(TempSalesInvoiceLine."Line Discount Amount", GLSetup."Amount Rounding Precision");
                        InterfaceEntryLineVIP."Unit Amount" := ROUND(TempSalesInvoiceLine."Unit Price", GLSetup."Amount Rounding Precision");
                    end;

                    InterfaceEntryLineVIP.INSERT();

                    DocAmountInclVAT := DocAmountInclVAT + InterfaceEntryLineVIP."Line Amount";
                    DocVATAmount := DocVATAmount + InterfaceEntryLineVIP."VAT Amount";
                until TempSalesInvoiceLine.NEXT() = 0;

            //InterfaceEntryHeader.Amount := DocAmountInclVAT - DocVATAmount;
            InterfaceEntryHeaderVIP.Amount := 0;
            //InterfaceEntryHeader."VAT Amount" := DocVATAmount;
            InterfaceEntryHeaderVIP."VAT Amount" := 0;
            InterfaceEntryHeaderVIP."Amount Including VAT" := DocAmountInclVAT;
            //InterfaceEntryHeaderVIP."Invoice Discount Amount" := SalesInvoiceHeader."Invoice Discount Amount"; ++
            InterfaceEntryHeaderVIP.MODIFY();
        end;
    end;

    local procedure CreateCrMemoRequest(SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT"; WithLines: Boolean);
    var
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        SalesHeader: Record "Sales Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SalesCrMemoLine2: Record "Sales Cr.Memo Line";
        SalesCrMemoLine3: Record "Sales Cr.Memo Line";
        ParentSalesCrMemoLine: Record "Sales Cr.Memo Line";
        TempSalesCrMemoLine: Record "Sales Cr.Memo Line" temporary;
        ItemCharge: Record "Item Charge";
        EBMItemCharge: Record "EBM Item Charge FND";
        ItemLineBuffer: Record "CSV Buffer" temporary;
        UnitPrice: Decimal;
        LineDiscountAmount: Decimal;
        LineAmountExclVAT: Decimal;
        LineVATAmount: Decimal;
        LineAmount: Decimal;
        DocVATAmount: Decimal;
        DocAmountInclVAT: Decimal;
        EntryNo: Integer;
        Customer: Record Customer;
        PaymentMethod: Record "Payment Method";
        MarakiSuppressValues: Record "Maraki Suppress Values FND";
        ItemDiscountAmount: Decimal;
        ItemDiscAmt: Decimal;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
    begin
        CLEAR(InterfaceEntryHeaderVIP);
        if SalesCrMemoHeader."Fiscal Printer Status FND" <= SalesCrMemoHeader."Fiscal Printer Status FND"::"Not Sent to Fiscal Printer" then
            InterfaceEntryHeaderVIP."Interface Code" := MarakiInterfaceSetup."Sales Posting Interface";
        InterfaceEntryHeaderVIP.Direction := InterfaceEntryHeaderVIP.Direction::Outbound;
        InterfaceEntryHeaderVIP."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderVIP."Pay-to Vendor No." := 'CREDIT MEMO';
        InterfaceEntryHeaderVIP."Source Type" := DATABASE::"Sales Cr.Memo Header";
        InterfaceEntryHeaderVIP."Source Subtype" := SalesHeader."Document Type"::"Credit Memo".AsInteger();
        InterfaceEntryHeaderVIP."Source No." := SalesCrMemoHeader."No.";
        InterfaceEntryHeaderVIP."Posting Date" := SalesCrMemoHeader."Posting Date";
        InterfaceEntryHeaderVIP."Sell-to Customer No." := SalesCrMemoHeader."Bill-to Customer No.";
        InterfaceEntryHeaderVIP.Name := SalesCrMemoHeader."Bill-to Name";
        InterfaceEntryHeaderVIP.Address := COMPANYNAME;
        if SalesCrMemoHeader."Location Code" <> '' then
            InterfaceEntryHeaderVIP."Location Code" := SalesCrMemoHeader."Location Code"
        else begin
            SalesCrMemoLine2.SETRANGE("Document No.", SalesCrMemoHeader."No.");
            if SalesCrMemoLine2.FINDFIRST() then
                InterfaceEntryHeaderVIP."Location Code" := SalesCrMemoLine2."Location Code";
        end;
        Customer.GET(SalesCrMemoHeader."Bill-to Customer No.");
        // InterfaceEntryHeaderVIP."Global No." := Customer."Tax Registration No.";  // BC Upgrade NANDIS03 - Blocked as dependency on DIT - "Tax Registration No." field is DIT field added in Table Customer >>
        // BC Upgrade NANDIS03 - Blocked as dependency on DIT - "Cash Payment" field is DIT field added in Table Payment Method >>
        // if PaymentMethod.GET(SalesCrMemoHeader."Payment Method Code") then
        //   if PaymentMethod."Cash Payment" then
        //     InterfaceEntryHeaderVIP."Payment Terms Code" := 'CASH'
        //   else
        //     InterfaceEntryHeaderVIP."Payment Terms Code" := 'CREDIT'
        // else
        //   InterfaceEntryHeaderVIP."Payment Terms Code" := '';
        // BC Upgrade NANDIS03 - Blocked as dependency on DIT - "Cash Payment" field is DIT field added in Table Payment Method >><<

        SalesCrMemoLine.SETRANGE("Document No.", SalesCrMemoHeader."No.");
        InterfaceEntryHeaderVIP."External Document No." := SalesCrMemoHeader."No.";
        InterfaceEntryHeaderVIP.INSERT(true);

        if WithLines then begin
            SalesCrMemoLine.SETFILTER("No.", '<>%1', '');
            SalesCrMemoLine.SETFILTER(Quantity, '<>%1', 0);
            // SalesCrMemoLine.SETFILTER("Item Charge Type", '<>%1', SalesCrMemoLine."Item Charge Type"::Discount);  // BC Upgrade NANDIS03 - Blocked as dependency on DIT
            if SalesCrMemoLine.findset() then
                repeat
                    //MarakiSuppressValues.SETRANGE(Type,SalesCrMemoLine.Type);
                    MarakiSuppressValues.SETRANGE("No.", SalesCrMemoLine."No.");
                    if not MarakiSuppressValues.FINDFIRST() then begin
                        if SalesCrMemoHeader."Prices Including VAT" then begin
                            //HEI.02 comment line UnitPrice := ROUND(SalesCrMemoLine."Unit Price",GLSetup."Amount Rounding Precision");
                            //HEI.02>>
                            UnitPrice := ROUND(SalesCrMemoLine."Unit Price" / (1 + SalesCrMemoLine."VAT %" / 100), GLSetup."Amount Rounding Precision");
                            //HEI.02<<
                            LineAmount := ROUND(SalesCrMemoLine.Quantity * SalesCrMemoLine."Unit Price", GLSetup."Amount Rounding Precision");
                            LineAmountExclVAT := ROUND(LineAmount / (1 + SalesCrMemoLine."VAT %" / 100), GLSetup."Amount Rounding Precision");
                            LineVATAmount := LineAmount - LineAmountExclVAT;

                        end else begin
                            //HEI.02 comment line UnitPrice := ROUND((SalesCrMemoLine."Unit Price" + SalesCrMemoLine."Unit Price" * (SalesCrMemoLine."VAT %" / 100)),
                            // GLSetup."Amount Rounding Precision");
                            //HEI.02>>
                            UnitPrice := ROUND(SalesCrMemoLine."Unit Price", GLSetup."Amount Rounding Precision");
                            //HEI.02<<
                            LineAmountExclVAT := ROUND(SalesCrMemoLine.Quantity * SalesCrMemoLine."Unit Price", GLSetup."Amount Rounding Precision");
                            LineVATAmount := ROUND(LineAmountExclVAT * (SalesCrMemoLine."VAT %" / 100), GLSetup."Amount Rounding Precision");
                            LineAmount := LineAmountExclVAT + LineVATAmount;
                        end;

                        ItemDiscAmt := 0;
                        SalesCrMemoLine3.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
                        SalesCrMemoLine3.SETRANGE("Attached to Line No.", SalesCrMemoLine."Line No.");
                        // SalesCrMemoLine3.SETRANGE("Item Charge Type", SalesCrMemoLine."Item Charge Type"::Discount);  // BC Upgrade NANDIS03 - Blocked as dependency on DIT
                        if SalesCrMemoLine3.findset() then
                            repeat
                                //HEI.02 comment line ItemDiscAmt += ABS(ROUND(SalesCrMemoLine3."Unit Price" * SalesCrMemoLine3.Quantity,GLSetup."Amount Rounding Precision"));
                                //HEI.02>>
                                if SalesCrMemoHeader."Prices Including VAT" then
                                    ItemDiscAmt += ABS(ROUND((SalesCrMemoLine3."Unit Price" / (1 + SalesCrMemoLine3."VAT %" / 100)) * SalesCrMemoLine3.Quantity, GLSetup."Amount Rounding Precision"))
                                else
                                    ItemDiscAmt += ABS(ROUND(SalesCrMemoLine3."Unit Price" * SalesCrMemoLine3.Quantity, GLSetup."Amount Rounding Precision"));
                            //HEI.02<<
                            until SalesCrMemoLine3.NEXT() = 0;

                        TempSalesCrMemoLine.RESET();
                        TempSalesCrMemoLine.SETRANGE(Type, SalesCrMemoLine.Type);
                        TempSalesCrMemoLine.SETRANGE("No.", SalesCrMemoLine."No.");
                        TempSalesCrMemoLine.SETRANGE("Unit Price", SalesCrMemoLine."Unit Price");
                        if TempSalesCrMemoLine.FINDFIRST() then begin
                            TempSalesCrMemoLine.Quantity := TempSalesCrMemoLine.Quantity + SalesCrMemoLine.Quantity;
                            TempSalesCrMemoLine."Unit Price" := UnitPrice;
                            TempSalesCrMemoLine.Amount := TempSalesCrMemoLine.Amount + LineAmountExclVAT;
                            TempSalesCrMemoLine."Amount Including VAT" := TempSalesCrMemoLine."Amount Including VAT" + LineAmount;
                            TempSalesCrMemoLine."Line Discount Amount" := ItemDiscAmt;
                            TempSalesCrMemoLine.MODIFY();
                        end else begin
                            CLEAR(TempSalesCrMemoLine);
                            TempSalesCrMemoLine := SalesCrMemoLine;
                            TempSalesCrMemoLine."Unit Price" := UnitPrice;
                            TempSalesCrMemoLine.Amount := LineAmountExclVAT;
                            TempSalesCrMemoLine."Amount Including VAT" := LineAmount;
                            TempSalesCrMemoLine."Line Discount Amount" := ItemDiscAmt;
                            TempSalesCrMemoLine.INSERT();
                        end;
                    end;
                until SalesCrMemoLine.NEXT() = 0;

            TempSalesCrMemoLine.RESET();
            if TempSalesCrMemoLine.findset() then
                repeat
                    CLEAR(InterfaceEntryLineVIP);
                    InterfaceEntryLineVIP."Header Entry No." := InterfaceEntryHeaderVIP."Entry No.";
                    EntryNo := EntryNo + 1;
                    InterfaceEntryLineVIP."Entry No." := EntryNo;
                    InterfaceEntryLineVIP."Source Line No." := TempSalesCrMemoLine."Line No.";
                    InterfaceEntryLineVIP.Type := TempSalesCrMemoLine.Type.AsInteger();
                    InterfaceEntryLineVIP."No." := TempSalesCrMemoLine."No.";
                    InterfaceEntryLineVIP.Description := TempSalesCrMemoLine.Description;
                    InterfaceEntryLineVIP."Description 2" := TempSalesCrMemoLine."Description 2";
                    InterfaceEntryLineVIP."Location Code" := TempSalesCrMemoLine."Location Code";
                    InterfaceEntryLineVIP."Unit of Measure Code" := TempSalesCrMemoLine."Unit of Measure Code";
                    InterfaceEntryLineVIP."Currency Code" := InterfaceEntryHeaderVIP."Currency Code";
                    // BC Upgrade NANDIS03 - Blocked as dependency on DIT >>
                    // if TempSalesCrMemoLine."Item Charge Type" = TempSalesCrMemoLine."Item Charge Type"::Discount then
                    //     InterfaceEntryLineVIP.Quantity := ABS(TempSalesCrMemoLine.Quantity)
                    // else
                    //     InterfaceEntryLineVIP.Quantity := TempSalesCrMemoLine.Quantity;
                    // BC Upgrade NANDIS03 - Blocked as dependency on DIT <<
                    InterfaceEntryLineVIP."VAT %" := TempSalesCrMemoLine."VAT %";
                    //InterfaceEntryLine."VAT Amount" := TempSalesCrMemoLine."Amount Including VAT" - TempSalesCrMemoLine.Amount;
                    InterfaceEntryLineVIP."VAT Amount" := 0;
                    InterfaceEntryLineVIP."Line Amount" := TempSalesCrMemoLine."Amount Including VAT";

                    CurrencyExchangeRate.SETRANGE("Currency Code", Customer."Currency Code");
                    CurrencyExchangeRate.SETFILTER("Starting Date", '<=%1', InterfaceEntryHeaderVIP."Posting Date");
                    if CurrencyExchangeRate.FINDLAST() then begin
                        InterfaceEntryLineVIP."Discount %" := ROUND(TempSalesCrMemoLine."Line Discount Amount" * CurrencyExchangeRate."Relational Exch. Rate Amount", GLSetup."Amount Rounding Precision");
                        InterfaceEntryLineVIP."Unit Amount" := ROUND(TempSalesCrMemoLine."Unit Price" * CurrencyExchangeRate."Relational Exch. Rate Amount", GLSetup."Amount Rounding Precision");
                    end else begin
                        InterfaceEntryLineVIP."Discount %" := ROUND(TempSalesCrMemoLine."Line Discount Amount", GLSetup."Amount Rounding Precision");
                        InterfaceEntryLineVIP."Unit Amount" := ROUND(TempSalesCrMemoLine."Unit Price", GLSetup."Amount Rounding Precision");
                    end;

                    InterfaceEntryLineVIP.INSERT();

                    DocAmountInclVAT := DocAmountInclVAT + InterfaceEntryLineVIP."Line Amount";
                    DocVATAmount := DocVATAmount + InterfaceEntryLineVIP."VAT Amount";
                until TempSalesCrMemoLine.NEXT() = 0;

            //InterfaceEntryHeader.Amount := DocAmountInclVAT - DocVATAmount;
            InterfaceEntryHeaderVIP.Amount := 0;
            //InterfaceEntryHeader."VAT Amount" := DocVATAmount;
            InterfaceEntryHeaderVIP."Amount Including VAT" := DocAmountInclVAT;
            InterfaceEntryHeaderVIP."Amount Including VAT" := 0;
            //InterfaceEntryHeaderVIP."Invoice Discount Amount" := SalesCrMemoHeader."Invoice Discount Amount"; ++
            InterfaceEntryHeaderVIP.MODIFY();
        end;
    end;

    local procedure ProcessOutboundInvoiceEntry(SalesInvoiceHeader: Record "Sales Invoice Header"; InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    begin
        COMMIT();
        GetMarakiInterfaceSetup();
        if CODEUNIT.RUN(CODEUNIT::"Outbound Interface Process VIP", InterfaceEntryHeaderVIP) then begin
            InterfaceFrameworkMgtVIP.SetInterfaceProcessed(InterfaceEntryHeaderVIP);
            InterfaceFrameworkMgtVIP.LogInterfaceEntries(InterfaceEntryHeaderVIP);
            InterfaceFrameworkMgtVIP.DeleteInterfaceEntries(InterfaceEntryHeaderVIP);
            SalesInvoiceHeader."Fiscal Printer Status FND" := SalesInvoiceHeader."Fiscal Printer Status FND"::"Sent to Middleware";
            SalesInvoiceHeader.MODIFY();
            if InterfaceEntryHeaderVIP."Interface Code" = MarakiInterfaceSetup."Sales Posting Interface" then
                if GUIALLOWED then
                    MESSAGE(SentToMiddlewareTxt);
        end else begin
            InterfaceFrameworkMgtVIP.SetInterfaceError(InterfaceEntryHeaderVIP, GETLASTERRORTEXT);
            SalesInvoiceHeader."Fiscal Printer Status FND" := SalesInvoiceHeader."Fiscal Printer Status FND"::"Not Sent to Middleware";
            SalesInvoiceHeader.MODIFY();
            if InterfaceEntryHeaderVIP."Interface Code" = MarakiInterfaceSetup."Sales Posting Interface" then
                if GUIALLOWED then
                    MESSAGE(STRSUBSTNO(NotSentToMiddlewareTxt, GETLASTERRORTEXT));
        end;
    end;

    local procedure ProcessOutboundCrMemoEntry(SalesCrMemoHeader: Record "Sales Cr.Memo Header"; InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    begin
        COMMIT();
        GetMarakiInterfaceSetup();
        if CODEUNIT.RUN(CODEUNIT::"Outbound Interface Process VIP", InterfaceEntryHeaderVIP) then begin
            InterfaceFrameworkMgtVIP.SetInterfaceProcessed(InterfaceEntryHeaderVIP);
            InterfaceFrameworkMgtVIP.LogInterfaceEntries(InterfaceEntryHeaderVIP);
            InterfaceFrameworkMgtVIP.DeleteInterfaceEntries(InterfaceEntryHeaderVIP);
            SalesCrMemoHeader."Fiscal Printer Status FND" := SalesCrMemoHeader."Fiscal Printer Status FND"::"Sent to Middleware";
            SalesCrMemoHeader.MODIFY();
            if InterfaceEntryHeaderVIP."Interface Code" = MarakiInterfaceSetup."Sales Posting Interface" then
                if GUIALLOWED then
                    MESSAGE(SentToMiddlewareTxt);
        end else begin
            InterfaceFrameworkMgtVIP.SetInterfaceError(InterfaceEntryHeaderVIP, GETLASTERRORTEXT);
            SalesCrMemoHeader."Fiscal Printer Status FND" := SalesCrMemoHeader."Fiscal Printer Status FND"::"Not Sent to Middleware";
            SalesCrMemoHeader.MODIFY();
            if InterfaceEntryHeaderVIP."Interface Code" = MarakiInterfaceSetup."Sales Posting Interface" then
                if GUIALLOWED then
                    MESSAGE(STRSUBSTNO(NotSentToMiddlewareTxt, GETLASTERRORTEXT));
        end;
    end;

    local procedure GetGLSetup();
    begin
        if not GLSetupRead then
            GLSetup.GET();
        GLSetupRead := true;
    end;

    local procedure GetGeneralOpCoSetup();
    begin
        if not GeneralOpCoSetupRead then
            GeneralOpCoSetup.GET();
        GeneralOpCoSetupRead := true;
    end;

    local procedure GetGeneralInterfaceSetup();
    begin
        if not GeneralInterfaceSetupRead then
            GeneralInterfaceSetup.GET();
        GeneralInterfaceSetupRead := true;
    end;

    local procedure GetMarakiInterfaceSetup();
    begin
        if not MarakiInterfaceSetupRead then
            if MarakiInterfaceSetup.GET() then;
        MarakiInterfaceSetupRead := true;
    end;

    local procedure GetNoOfAttemptsPerInterfaceAndSource(InterfaceCode: Code[20]; SourceType: Integer; SourceSubtype: Integer; SourceNo: Code[20]): Integer;
    var
        InterfaceLogHeaderVIP: Record "Interface Log Header VIP INT";
    begin
        InterfaceLogHeaderVIP.SETRANGE("Interface Code", InterfaceCode);
        InterfaceLogHeaderVIP.SETRANGE("Source Type", SourceType);
        InterfaceLogHeaderVIP.SETRANGE("Source Subtype", SourceSubtype);
        InterfaceLogHeaderVIP.SETRANGE("Source No.", SourceNo);
        exit(InterfaceLogHeaderVIP.COUNT);
    end;

    local procedure CheckSalesHeader(SalesHeader: Record "Sales Header");
    var
        SalesLine: Record "Sales Line";
        InterfaceLogHeaderVIP: Record "Interface Log Header VIP INT";
        VATRegNo: Integer;
    begin
        GetMarakiInterfaceSetup();
        //SalesHeader.TESTFIELD("Bill-to Name");
        InterfaceLogHeaderVIP.SETRANGE("Interface Code", MarakiInterfaceSetup."Sales Posting Interface");
        InterfaceLogHeaderVIP.SETRANGE("Sell-to Customer No.", SalesHeader."Bill-to Customer No.");
        if InterfaceLogHeaderVIP.FINDLAST() then
            SalesHeader.TESTFIELD("Bill-to Name", InterfaceLogHeaderVIP.Name);
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETFILTER("No.", '<>%1', '');
        SalesLine.SETFILTER(Quantity, '<>%1', 0);
        if SalesLine.findset() then
            repeat
                SalesLine.TESTFIELD(Description);
                if SalesLine."Unit Price" < 0 then
                    SalesLine.FIELDERROR("Unit Price");
            until SalesLine.NEXT() = 0;
    end;

    // BC Upgrade NANDIS03 - 50067 is EBM Log tabel, and EBM is out of scope >>
    // [EventSubscriber(ObjectType::Table, 50067, 'OnAfterValidateEvent', 'Maraki Fiscal No.', false, false)]
    // local procedure OnAfterValidateMarakiFiscalNo(var Rec: Record "EBM Log"; var xRec: Record "EBM Log"; CurrFieldNo: Integer);
    // var
    //     SalesInvoiceHeader: Record "Sales Invoice Header";
    //     SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    // begin
    //     if not Rec."Maraki Supress Value" then
    //         exit;

    //     if (Rec."Document Type" = Rec."Document Type"::Invoice) and
    //        SalesInvoiceHeader.GET(Rec."Document No.") and
    //        (SalesInvoiceHeader."Fiscal Printer Status" = SalesInvoiceHeader."Fiscal Printer Status"::"Fiscal Printer No. Received")
    //     then
    //         exit
    //     else if
    //       (Rec."Document Type" = Rec."Document Type"::"Credit Memo") and
    //       SalesCrMemoHeader.GET(Rec."Document No.") and
    //       (SalesCrMemoHeader."Fiscal Printer Status" = SalesCrMemoHeader."Fiscal Printer Status"::"Fiscal Printer No. Received")
    //     then
    //         exit;

    //     if (Rec."Maraki Fiscal No." <> '') and
    //        (Rec."Maraki Posted Date" <> 0D) and
    //        (Rec."Maraki Machine No." <> '')
    //     then
    //         if Rec."Document Type" = Rec."Document Type"::Invoice then begin
    //             if SalesInvoiceHeader.GET(Rec."Document No.") then begin
    //                 SalesInvoiceHeader."Fiscal Printer Status" := SalesInvoiceHeader."Fiscal Printer Status"::"Fiscal Printer No. Received";
    //                 SalesInvoiceHeader.MODIFY;
    //             end;
    //         end else begin
    //             if Rec."Document Type" = Rec."Document Type"::"Credit Memo" then
    //                 if SalesCrMemoHeader.GET(Rec."Document No.") then begin
    //                     SalesCrMemoHeader."Fiscal Printer Status" := SalesCrMemoHeader."Fiscal Printer Status"::"Fiscal Printer No. Received";
    //                     SalesCrMemoHeader.MODIFY;
    //                 end;
    //         end;
    // end;

    // [EventSubscriber(ObjectType::Table, 50067, 'OnAfterValidateEvent', 'Maraki Posted Date', false, false)]
    // local procedure OnAfterValidateMarakiPostedDate(var Rec: Record "EBM Log"; var xRec: Record "EBM Log"; CurrFieldNo: Integer);
    // var
    //     SalesInvoiceHeader: Record "Sales Invoice Header";
    //     SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    // begin
    //     if not Rec."Maraki Supress Value" then
    //         exit;
    //     if (Rec."Document Type" = Rec."Document Type"::Invoice) and
    //        SalesInvoiceHeader.GET(Rec."Document No.") and
    //        (SalesInvoiceHeader."Fiscal Printer Status" = SalesInvoiceHeader."Fiscal Printer Status"::"Fiscal Printer No. Received")
    //     then
    //         exit
    //     else if
    //       (Rec."Document Type" = Rec."Document Type"::"Credit Memo") and
    //       SalesCrMemoHeader.GET(Rec."Document No.") and
    //       (SalesCrMemoHeader."Fiscal Printer Status" = SalesCrMemoHeader."Fiscal Printer Status"::"Fiscal Printer No. Received")
    //     then
    //         exit;

    //     if (Rec."Maraki Fiscal No." <> '') and
    //        (Rec."Maraki Posted Date" <> 0D) and
    //        (Rec."Maraki Machine No." <> '')
    //     then
    //         if Rec."Document Type" = Rec."Document Type"::Invoice then begin
    //             if SalesInvoiceHeader.GET(Rec."Document No.") then begin
    //                 SalesInvoiceHeader."Fiscal Printer Status" := SalesInvoiceHeader."Fiscal Printer Status"::"Fiscal Printer No. Received";
    //                 SalesInvoiceHeader.MODIFY;
    //             end;
    //         end else begin
    //             if Rec."Document Type" = Rec."Document Type"::"Credit Memo" then
    //                 if SalesCrMemoHeader.GET(Rec."Document No.") then begin
    //                     SalesCrMemoHeader."Fiscal Printer Status" := SalesCrMemoHeader."Fiscal Printer Status"::"Fiscal Printer No. Received";
    //                     SalesCrMemoHeader.MODIFY;
    //                 end;
    //         end;
    // end;

    // [EventSubscriber(ObjectType::Table, 50067, 'OnAfterValidateEvent', 'Maraki Machine No.', false, false)]
    // local procedure OnAfterValidateMarakiMachineNo(var Rec: Record "EBM Log"; var xRec: Record "EBM Log"; CurrFieldNo: Integer);
    // var
    //     SalesInvoiceHeader: Record "Sales Invoice Header";
    //     SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    // begin
    //     if not Rec."Maraki Supress Value" then
    //         exit;
    //     if (Rec."Document Type" = Rec."Document Type"::Invoice) and
    //        SalesInvoiceHeader.GET(Rec."Document No.") and
    //        (SalesInvoiceHeader."Fiscal Printer Status" = SalesInvoiceHeader."Fiscal Printer Status"::"Fiscal Printer No. Received")
    //     then
    //         exit
    //     else if
    //       (Rec."Document Type" = Rec."Document Type"::"Credit Memo") and
    //       SalesCrMemoHeader.GET(Rec."Document No.") and
    //       (SalesCrMemoHeader."Fiscal Printer Status" = SalesCrMemoHeader."Fiscal Printer Status"::"Fiscal Printer No. Received")
    //     then
    //         exit;

    //     if (Rec."Maraki Fiscal No." <> '') and
    //        (Rec."Maraki Posted Date" <> 0D) and
    //        (Rec."Maraki Machine No." <> '')
    //     then
    //         if Rec."Document Type" = Rec."Document Type"::Invoice then begin
    //             if SalesInvoiceHeader.GET(Rec."Document No.") then begin
    //                 SalesInvoiceHeader."Fiscal Printer Status" := SalesInvoiceHeader."Fiscal Printer Status"::"Fiscal Printer No. Received";
    //                 SalesInvoiceHeader.MODIFY;
    //             end;
    //         end else begin
    //             if Rec."Document Type" = Rec."Document Type"::"Credit Memo" then
    //                 if SalesCrMemoHeader.GET(Rec."Document No.") then begin
    //                     SalesCrMemoHeader."Fiscal Printer Status" := SalesCrMemoHeader."Fiscal Printer Status"::"Fiscal Printer No. Received";
    //                     SalesCrMemoHeader.MODIFY;
    //                 end;
    //         end;
    // end;
    // BC Upgrade NANDIS03 - 50067 is EBM Log tabel, and EBM is out of scope <<
}

