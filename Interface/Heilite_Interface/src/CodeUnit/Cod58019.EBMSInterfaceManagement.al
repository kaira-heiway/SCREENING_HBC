codeunit 58019 "EBMS Interface Management"
{
    // version HEI.08

    // HEI.01 CHG2151260-HB2788 COSTES04 23.12.2022 Object created
    // HEI.02 CHG2151260 HB2788 BHANDS01 30.12.2022 # Burundi Fiscal Invoice
    //   # Bug Fixes
    // HEI.03 CHG2151260 HB2788 COSTES04 03.01.2023 # Burundi Fiscal Invoice
    //   # Bug Fixes
    // HEI.04 CHG2151260 HB2788 BHANDS01 03.01.2023 # Burundi Fiscal Invoice
    //   # Bug Fixes
    // HEI.05 CHG2151260 HB2788 BHANDS01 04.01.2023 # Burundi Fiscal Invoice
    //   # Bug Fixes for Dates
    // HEI.06 CHG2151260 HB2788 COSTES04 13.01.2023 # Burundi Fiscal Invoice
    //   # Bug Fixes
    // HEI.07 CHG2151260 HB2788 COSTES04 27.01.2023 # Burundi Fiscal Invoice
    //   # Add invoice type
    // HEI.08 CHG2151260 HB2788 BHANDS01 16.02.2023 # Burundi Fiscal Invoice
    //   # Change field mapping
    // HEI.09 CHG2306485 HB4312 IBM ADHIKG01 09.07.2025 EBMS Interface error solution
    // # Added the Item Category filter from EBMS Setup in the CreateInvoiceRequest and CreateCrMemoRequest functions
    // # Created functions IsValidSalesInvLineEmpty,IsValidSalesCrMemoLineEmpty to skip creating outbound entries
    // when no lines match the Item Category filter defined in EBMS Setup


    // BC Upgrade PATELP08  >> 
    // # Added HEI.09 documentation from NAV object as it was missing in Business central object
    // # Added 2 functions - IsValidSalesInvLineEmpty and IsValidSalesCrMemoLineEmpty as per HEI.09 Documentation
    // # Added HEI.09 implementation-(Skip EBMS invoice creation) in procedure ProcessSalesInvoicePosting
    // # Added HEI.09 implementation-(Skip EBMS credit memo creation) in procedure ProcessSalesCrMemoPosting
    // # Added the Item Category filter from EBMS Setup in the CreateInvoiceRequest and CreateCrMemoRequest functions
    // BC Upgrade PATELP08  <<


    // BC Upgrade MISHRS14 >>
    // Changed table name to "EBMS Document Status FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<


    // BC Upgrade PATELP08>>
    // Changed name of table from "EBM Item Charge" to "EBM Item Charge FND"
    // Changed name of table from "EBMS Document Type" to "EBMS Document Type FND"
    // BC Upgrade PATELP08<<


    Permissions = TableData "Sales Invoice Header" = rm,
                  TableData "Sales Cr.Memo Header" = rm;

    trigger OnRun();
    begin
    end;

    var
        GLSetup: Record "General Ledger Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        EBMSInterfaceSetup: Record "EBMS Interface Setup INT";
        CompInfo: Record "Company Information";
        InterfaceFrameworkMgtVIP: Codeunit "Interface Framework Mgt. VIP";
        GLSetupRead: Boolean;
        SalesSetupRead: Boolean;
        GeneralInterfaceSetupRead: Boolean;
        EBMInterfaceSetupRead: Boolean;
        ReceivedInHeiLiteTxt: Label 'Received in HeiLite';
        SentToMiddlewareTxt: Label 'Sent to middleware';
        NotSentToMiddlewareTxt: Label 'Not sent to middleware.\ Error message: %1.';
        IncorrectFormatErr: Label '%1 has an incorrect format. Current value is %2.';
        EBMSDocumentStatus: Record "EBMS Document Status FND";

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]);
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        EBMSDocumentStatus: Record "EBMS Document Status FND";
    begin
        GetSalesSetup();
        if not SalesSetup."Enable EBMS Interface FND" then
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
    // BC Upgrade PATELP08  >> 
    // Added 2 functions - IsValidSalesInvLineEmpty and IsValidSalesCrMemoLineEmpty for HEI.09 Documentation
    local procedure IsValidSalesInvLineEmpty(SalesInvoiceHeader: Record "Sales Invoice Header"): Boolean
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        GetEBMInterfaceSetup();
        SalesInvoiceLine.Reset();
        SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
        SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
        SalesInvoiceLine.SetFilter("Item Category Code", EBMSInterfaceSetup."Item Category Code Filter");
        exit(SalesInvoiceLine.IsEmpty());
    end;

    local procedure IsValidSalesCrMemoLineEmpty(SalesCrMemoHeader: Record "Sales Cr.Memo Header"): Boolean
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
    begin
        GetEBMInterfaceSetup();
        SalesCrMemoLine.Reset();
        SalesCrMemoLine.SetRange("Document No.", SalesCrMemoHeader."No.");
        SalesCrMemoLine.SetRange(Type, SalesCrMemoLine.Type::Item);
        SalesCrMemoLine.SetFilter("Item Category Code", EBMSInterfaceSetup."Item Category Code Filter");
        exit(SalesCrMemoLine.IsEmpty());
    end;
    //BC Upgrade PATELP08  <<

    procedure ManualSalesInvoicePosting(SalesInvoiceHeader: Record "Sales Invoice Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        EBMSDocumentStatus: Record "EBMS Document Status FND";
    begin
        GetSalesSetup();
        if not SalesSetup."Enable EBMS Interface FND" then
            exit;

        InitDocInfo(SalesInvoiceHeader."No.", 1, EBMSDocumentStatus);
        GetEBMInterfaceSetup();
        EBMSInterfaceSetup.TESTFIELD("Send Invoice Interface");
        InterfaceSetup.GET(EBMSInterfaceSetup."Send Invoice Interface");
        if not InterfaceSetup.Enabled then
            exit;

        if EBMSDocumentStatus."Invoice Details Outbnd Status" = EBMSDocumentStatus."Invoice Details Outbnd Status"::"Not Sent" then
            InterfaceEntryHeaderVIP.SETRANGE("Interface Code", EBMSInterfaceSetup."Send Invoice Interface")
        else
            InterfaceEntryHeaderVIP.SETRANGE("Interface Code", EBMSInterfaceSetup."Sales Confirmation Interface");
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
                if EBMSDocumentStatus."Invoice Details Outbnd Status" = EBMSDocumentStatus."Invoice Details Outbnd Status"::"Not Sent" then
                    ProcessSalesInvoicePosting(SalesInvoiceHeader)
                else
                    ProcessSalesInvoiceConfRequest(SalesInvoiceHeader);
        end;
    end;

    procedure ManualSalesCrMemoPosting(SalesCrMemoHeader: Record "Sales Cr.Memo Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
    begin
        GetSalesSetup();
        if not SalesSetup."Enable EBMS Interface FND" then
            exit;

        GetEBMInterfaceSetup();
        EBMSInterfaceSetup.TESTFIELD("Send Invoice Interface");
        InterfaceSetup.GET(EBMSInterfaceSetup."Send Invoice Interface");
        if not InterfaceSetup.Enabled then
            exit;

        if SalesCrMemoHeader."Fiscal Printer Status FND" <= SalesCrMemoHeader."Fiscal Printer Status FND"::"Not Sent to Fiscal Printer" then
            InterfaceEntryHeaderVIP.SETRANGE("Interface Code", EBMSInterfaceSetup."Send Invoice Interface")
        else
            InterfaceEntryHeaderVIP.SETRANGE("Interface Code", EBMSInterfaceSetup."Sales Confirmation Interface");
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
                    ProcessSalesCrMemoPosting(SalesCrMemoHeader)
                else
                    ProcessSalesCrMemoConfRequest(SalesCrMemoHeader);
        end;
    end;

    // BC Upgrade PATELP08  >> Added HEI.09 Documentation implementation
    procedure ProcessSalesInvoicePosting(var SalesInvoiceHeader: Record "Sales Invoice Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
    begin
        GetSalesSetup();
        if not SalesSetup."Enable EBMS Interface FND" then
            exit;
        // BC Upgrade SHUKLP03 - Blocked as Document Subtype Code is DIT table >>
        if not IsEBMDocumentType(2, SalesInvoiceHeader."Document Subtype Code FND") then
            exit;
        // BC Upgrade SHUKLP03 - Blocked as Document Subtype Code is DIT table <<
        if SalesInvoiceHeader."Fiscal Printer Status FND" = SalesInvoiceHeader."Fiscal Printer Status FND"::"Received in Fiscal Printer" then //HEI.04
            exit;

        GetGLSetup();
        GetGeneralInterfaceSetup();
        GetEBMInterfaceSetup();
        EBMSInterfaceSetup.TESTFIELD("Send Invoice Interface");
        EBMSInterfaceSetup.TESTFIELD("Taxpayer System ID");
        InterfaceSetup.GET(EBMSInterfaceSetup."Send Invoice Interface");
        if not InterfaceSetup.Enabled then
            exit;
        // BC Upgrade PATELP08  >> Skip EBMS invoice creation if no sales lines match Item Category filter from EBMS Setup
        // HEI.09 >>
        if IsValidSalesInvLineEmpty(SalesInvoiceHeader) then
            exit;
        // HEI.09 <<
        // BC Upgrade PATELP08  <<
        InterfaceFrameworkMgtVIP.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CreateInvoiceRequest(SalesInvoiceHeader, InterfaceEntryHeaderVIP, true);
        ProcessOutboundInvoiceEntry(SalesInvoiceHeader, InterfaceEntryHeaderVIP);
    end;
    // BC Upgrade PATELP08  <<

    // BC Upgrade PATELP08  >> Added HEI.09 Documentation implementation
    procedure ProcessSalesCrMemoPosting(SalesCrMemoHeader: Record "Sales Cr.Memo Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
    begin
        // BC Upgrade SHUKLP03 - Blocked as Document Subtype Code is DIT table >>
        if not IsEBMDocumentType(3, SalesCrMemoHeader."Document Subtype Code FND") then
            exit;
        // BC Upgrade SHUKLP03 - Blocked as Document Subtype Code is DIT table <<
        if SalesCrMemoHeader."Fiscal Printer Status FND" > SalesCrMemoHeader."Fiscal Printer Status FND"::"Received in Fiscal Printer" then //HEI.04
            exit;

        GetGLSetup();
        GetGeneralInterfaceSetup();
        GetEBMInterfaceSetup();
        EBMSInterfaceSetup.TESTFIELD("Send Invoice Interface");
        InterfaceSetup.GET(EBMSInterfaceSetup."Send Invoice Interface");
        if not InterfaceSetup.Enabled then
            exit;
        // BC Upgrade PATELP08  >> Skip EBMS credit memo creation if no sales lines match Item Category filter from EBMS Setup
        // HEI.09 
        if IsValidSalesCrMemoLineEmpty(SalesCrMemoHeader) then
            exit;
        // HEI.09
        // BC Upgrade PATELP08  <<
        InterfaceFrameworkMgtVIP.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CreateCrMemoRequest(SalesCrMemoHeader, InterfaceEntryHeaderVIP, true);
        ProcessOutboundCrMemoEntry(SalesCrMemoHeader, InterfaceEntryHeaderVIP);
    end;
    // BC Upgrade PATELP08  << 

    local procedure ProcessSalesInvoiceConfRequest(SalesInvoiceHeader: Record "Sales Invoice Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        SalesHeader: Record "Sales Header";
    begin
        if SalesInvoiceHeader."Fiscal Printer Status FND" = SalesInvoiceHeader."Fiscal Printer Status FND"::"Fiscal Printer No. Received" then
            exit;

        GetGLSetup();
        GetGeneralInterfaceSetup();
        GetEBMInterfaceSetup();
        EBMSInterfaceSetup.TESTFIELD("Sales Confirmation Interface");
        InterfaceSetup.GET(EBMSInterfaceSetup."Sales Confirmation Interface");
        if not InterfaceSetup.Enabled then
            exit;

        if (not GUIALLOWED) and
           (EBMSInterfaceSetup."No. of Confirmation Attempts" > 0) and
           (GetNoOfAttemptsPerInterfaceAndSource(EBMSInterfaceSetup."Sales Confirmation Interface",
                                                 DATABASE::"Sales Invoice Header",
                                                 SalesHeader."Document Type"::Invoice.AsInteger(),
                                                 SalesInvoiceHeader."No.") >= EBMSInterfaceSetup."No. of Confirmation Attempts")
        then
            exit;

        InterfaceFrameworkMgtVIP.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CreateInvoiceRequest(SalesInvoiceHeader, InterfaceEntryHeaderVIP, false);
    end;

    local procedure ProcessSalesCrMemoConfRequest(SalesCrMemoHeader: Record "Sales Cr.Memo Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        SalesHeader: Record "Sales Header";
    begin
        if SalesCrMemoHeader."Fiscal Printer Status FND" = SalesCrMemoHeader."Fiscal Printer Status FND"::"Fiscal Printer No. Received" then
            exit;

        GetGLSetup();
        GetGeneralInterfaceSetup();
        GetEBMInterfaceSetup();
        EBMSInterfaceSetup.TESTFIELD("Sales Confirmation Interface");
        InterfaceSetup.GET(EBMSInterfaceSetup."Sales Confirmation Interface");
        if not InterfaceSetup.Enabled then
            exit;

        if (not GUIALLOWED) and
           (EBMSInterfaceSetup."No. of Confirmation Attempts" > 0) and
           (GetNoOfAttemptsPerInterfaceAndSource(EBMSInterfaceSetup."Sales Confirmation Interface",
                                                 DATABASE::"Sales Cr.Memo Header",
                                                 SalesHeader."Document Type"::"Credit Memo".AsInteger(),
                                                 SalesCrMemoHeader."Applies-to Doc. No.") >= EBMSInterfaceSetup."No. of Confirmation Attempts")
        then
            exit;

        InterfaceFrameworkMgtVIP.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CreateCrMemoRequest(SalesCrMemoHeader, InterfaceEntryHeaderVIP, false);
    end;

    procedure ProcessSalesConfirmationResponse(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT") ReturnValue: Text;
    var
        InterfaceSetup: Record "Interface Setup INT";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        InterfaceEntryHeaderVIPOut: Record "Interface Entry Header VIP INT";
        NewLine: Boolean;
    begin
        GetGeneralInterfaceSetup();
        GetEBMInterfaceSetup();
        EBMSInterfaceSetup.TESTFIELD("Sales Confirmation Interface");
        InterfaceSetup.GET(EBMSInterfaceSetup."Sales Confirmation Interface");
        if not InterfaceSetup.Enabled then
            exit;

        //HEI.02>>
        SalesCrMemoHeader.RESET();
        if SalesCrMemoHeader.GET(InterfaceEntryHeaderVIP."Source No.") then begin
            if InterfaceEntryHeaderVIP.Closed then begin
                SalesCrMemoHeader."Fiscal Printer Status FND" := SalesCrMemoHeader."Fiscal Printer Status FND"::"Received in Fiscal Printer";
                SalesCrMemoHeader.MODIFY();
                EBMSDocumentStatus.SETRANGE("Document Type", EBMSDocumentStatus."Document Type"::"Credit Memo");
                EBMSDocumentStatus.SETRANGE("Document No.", InterfaceEntryHeaderVIP."Source No.");
                if EBMSDocumentStatus.FINDFIRST() then begin
                    EBMSDocumentStatus."Invoice Fields rcvd from EBMS" := true;
                    EBMSDocumentStatus."Invoice Details Inbound Status" := EBMSDocumentStatus."Invoice Details Inbound Status"::Processed;
                end;
            end else begin
                SalesCrMemoHeader."Fiscal Printer Status FND" := SalesCrMemoHeader."Fiscal Printer Status FND"::"Error in Fiscal Printer or RRA";
                SalesCrMemoHeader.MODIFY();
                EBMSDocumentStatus.SETRANGE("Document Type", EBMSDocumentStatus."Document Type"::"Credit Memo");
                EBMSDocumentStatus.SETRANGE("Document No.", InterfaceEntryHeaderVIP."Source No.");
                if EBMSDocumentStatus.FINDFIRST() then begin
                    EBMSDocumentStatus."Invoice Details Inbound Status" := EBMSDocumentStatus."Invoice Details Inbound Status"::Error;
                    EBMSDocumentStatus."Invoice Fields rcvd from EBMS" := false;
                end;
            end;
            EBMSDocumentStatus."Last Updated" := CURRENTDATETIME;
            EBMSDocumentStatus.MODIFY();
        end else begin
            if SalesInvoiceHeader.GET(InterfaceEntryHeaderVIP."Source No.") then begin
                if InterfaceEntryHeaderVIP.Closed then begin
                    SalesInvoiceHeader."Fiscal Printer Status FND" := SalesInvoiceHeader."Fiscal Printer Status FND"::"Received in Fiscal Printer";
                    SalesInvoiceHeader.MODIFY();
                    EBMSDocumentStatus.SETRANGE("Document Type", EBMSDocumentStatus."Document Type"::Invoice);
                    EBMSDocumentStatus.SETRANGE("Document No.", InterfaceEntryHeaderVIP."Source No.");
                    if EBMSDocumentStatus.FINDFIRST() then begin
                        EBMSDocumentStatus."Invoice Fields rcvd from EBMS" := true;
                        EBMSDocumentStatus."Invoice Details Inbound Status" := EBMSDocumentStatus."Invoice Details Inbound Status"::Processed;
                    end;
                end else begin
                    SalesInvoiceHeader."Fiscal Printer Status FND" := SalesInvoiceHeader."Fiscal Printer Status FND"::"Error in Fiscal Printer or RRA";
                    SalesInvoiceHeader.MODIFY();
                    EBMSDocumentStatus.SETRANGE("Document Type", EBMSDocumentStatus."Document Type"::Invoice);
                    EBMSDocumentStatus.SETRANGE("Document No.", InterfaceEntryHeaderVIP."Source No.");
                    if EBMSDocumentStatus.FINDFIRST() then begin
                        EBMSDocumentStatus."Invoice Details Inbound Status" := EBMSDocumentStatus."Invoice Details Inbound Status"::Error;
                        EBMSDocumentStatus."Invoice Fields rcvd from EBMS" := false;
                    end;
                end;
                EBMSDocumentStatus."Last Updated" := CURRENTDATETIME;
                EBMSDocumentStatus.MODIFY();
            end;
        end;

        //HEI.02<<
    end;
    // BC Upgrade PATELP08 >> Added HEI.09 Documentation Implementation
    local procedure CreateInvoiceRequest(SalesInvoiceHeader: Record "Sales Invoice Header"; var InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT"; WithLines: Boolean);
    var
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        SalesHeader: Record "Sales Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
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
        LineAmountCT: Decimal;
        LineAmountLT: Decimal;
        ShipCostAmount: Decimal;
        UnitPriceLCY: Decimal;
    begin
        CLEAR(InterfaceEntryHeaderVIP);
        CompInfo.GET(); //HEI.02
        if SalesInvoiceHeader."Fiscal Printer Status FND" <= SalesInvoiceHeader."Fiscal Printer Status FND"::"Not Sent to Fiscal Printer" then
            InterfaceEntryHeaderVIP."Interface Code" := EBMSInterfaceSetup."Send Invoice Interface"
        else
            InterfaceEntryHeaderVIP."Interface Code" := EBMSInterfaceSetup."Sales Confirmation Interface";
        InterfaceEntryHeaderVIP.Direction := InterfaceEntryHeaderVIP.Direction::Outbound;
        InterfaceEntryHeaderVIP."Type ID" := 'INVOICE';
        if STRPOS(USERID, '\') = 0 then
            InterfaceEntryHeaderVIP."Your Reference" := USERID
        else
            InterfaceEntryHeaderVIP."Your Reference" := COPYSTR(USERID, STRPOS(USERID, '\') + 1, STRLEN(USERID) - STRPOS(USERID, '\'));
        InterfaceEntryHeaderVIP."Source Type" := DATABASE::"Sales Invoice Header";
        InterfaceEntryHeaderVIP."Source Subtype" := SalesHeader."Document Type"::Invoice.AsInteger();
        InterfaceEntryHeaderVIP."Source No." := SalesInvoiceHeader."No.";
        InterfaceEntryHeaderVIP."Global No." := SalesInvoiceHeader."VAT Registration No.";
        //HEI.05>>
        // InterfaceEntryHeaderVIP."Posting Date" := SalesInvoiceHeader."Posting Date";
        InterfaceEntryHeaderVIP."Pay-to Vendor No." := FORMAT(SalesInvoiceHeader."Posting Date", 0, '<Year4>-<Month,2>-<Day,2>') + ' ' + FORMAT(TIME, 0, '<Hours24>:<Minutes,2>:<Seconds,2>');
        //HEI.05<<
        InterfaceEntryHeaderVIP."Sell-to Customer No." := SalesInvoiceHeader."Sell-to Customer No.";
        InterfaceEntryHeaderVIP.Name := CompInfo.Name;
        InterfaceEntryHeaderVIP."Global No." := CompInfo."VAT Registration No.";
        InterfaceEntryHeaderVIP."External Document No." := CompInfo."Registration No.";
        InterfaceEntryHeaderVIP."Delivery Method" := CompInfo."Post Code";
        InterfaceEntryHeaderVIP."Phone No." := CompInfo."Phone No.";
        InterfaceEntryHeaderVIP.Description := CompInfo.Address;
        InterfaceEntryHeaderVIP."Your Reference" := '2';
        InterfaceEntryHeaderVIP.Name5 := SalesInvoiceHeader."Payment Method Code";
        InterfaceEntryHeaderVIP.Name2 := SalesInvoiceHeader."Bill-to Name";
        InterfaceEntryHeaderVIP.Name3 := SalesInvoiceHeader."VAT Registration No.";
        InterfaceEntryHeaderVIP.Address := SalesInvoiceHeader."Bill-to Address";
        InterfaceEntryHeaderVIP."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderVIP.Name5 := GetPaymentTermsCode(SalesInvoiceHeader."Payment Terms Code");
        InterfaceEntryHeaderVIP.County := UPPERCASE(COMPANYNAME);
        InterfaceEntryHeaderVIP."Currency Factor" := 1;
        InterfaceEntryHeaderVIP.Comment := STRSUBSTNO('%1/%2/%3/%4', CompInfo."VAT Registration No.", EBMSInterfaceSetup."Taxpayer System ID",
          (FORMAT(SalesInvoiceHeader."Posting Date", 0, '<Year4><Month,2><Day,2>') + FORMAT(TIME, 0, '<Hours24><Minutes,2><Seconds,2>')), SalesInvoiceHeader."No."); //HEI.05
        InterfaceEntryHeaderVIP."Buy-from Vendor No." := FORMAT(SalesInvoiceHeader."Posting Date", 0, '<Year4>-<Month,2>-<Day,2>') + ' ' + FORMAT(TIME, 0, '<Hours24>:<Minutes,2>:<Seconds,2>');  //HEI.05  //HEI.08
        // InterfaceEntryHeaderVIP."Legal Form" := CompInfo."Legal Form";//HEI.03  // BC Upgrade NANDIS03 - Blocked as FR localization field
        InterfaceEntryHeaderVIP."Legal Form" := CompInfo."Legal Form FND";//BC UPGRADE KUMARR78 ++ 18-06-2026  

        InterfaceEntryHeaderVIP."Bill-to Customer No." := 'FN';//HEI.07  //HEI.08
        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
        InterfaceEntryHeaderVIP.INSERT(true);

        if WithLines then begin
            SalesInvoiceLine.SETFILTER("No.", '<>%1', '');
            SalesInvoiceLine.SETFILTER(Quantity, '<>%1', 0);
            // BC Upgrade PATELP08 >> Added Item Category filter from EBMS Setup to include only EBMS relevant lines in invoice request
            // HEI.09 >>
            SalesInvoiceLine.SETFILTER("Item Category Code",
                                       EBMSInterfaceSetup."Item Category Code Filter");
            // HEI.09 <<
            // BC Upgrade PATELP08 <<
            if SalesInvoiceLine.findset() then
                repeat
                    if SalesInvoiceHeader."Prices Including VAT" then begin
                        UnitPrice := ROUND(SalesInvoiceLine."Unit Price" / InterfaceEntryHeaderVIP."Currency Factor", GLSetup."Unit-Amount Rounding Precision");
                        LineDiscountAmount := -ROUND(SalesInvoiceLine."Line Discount Amount" / InterfaceEntryHeaderVIP."Currency Factor", GLSetup."Amount Rounding Precision");
                        LineAmount := ROUND(SalesInvoiceLine.Quantity * SalesInvoiceLine."Unit Price" / InterfaceEntryHeaderVIP."Currency Factor",
                                            GLSetup."Amount Rounding Precision");
                        LineAmountExclVAT := ROUND(LineAmount / (1 + SalesInvoiceLine."VAT %" / 100) / InterfaceEntryHeaderVIP."Currency Factor", GLSetup."Unit-Amount Rounding Precision");
                        LineVATAmount := LineAmount - LineAmountExclVAT;
                    end else begin
                        UnitPrice := ROUND((SalesInvoiceLine."Unit Price" + SalesInvoiceLine."Unit Price" * (SalesInvoiceLine."VAT %" / 100)) / InterfaceEntryHeaderVIP."Currency Factor",
                                           GLSetup."Unit-Amount Rounding Precision");
                        LineDiscountAmount := -ROUND((SalesInvoiceLine."Line Discount Amount" +
                                                        SalesInvoiceLine."Line Discount Amount" * (SalesInvoiceLine."VAT %" / 100)) / InterfaceEntryHeaderVIP."Currency Factor",
                                                       GLSetup."Amount Rounding Precision");
                        LineAmountExclVAT := ROUND(SalesInvoiceLine.Quantity * SalesInvoiceLine."Unit Price" / InterfaceEntryHeaderVIP."Currency Factor", GLSetup."Amount Rounding Precision");
                        LineVATAmount := ROUND(LineAmountExclVAT * (SalesInvoiceLine."VAT %" / 100) / InterfaceEntryHeaderVIP."Currency Factor", GLSetup."Amount Rounding Precision");
                        LineAmount := LineAmountExclVAT + LineVATAmount;
                    end;
                    //HEI.03>>
                    LineAmountCT := ROUND(GetItemCTAmount(0, SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.") / InterfaceEntryHeaderVIP."Currency Factor", GLSetup."Unit-Amount Rounding Precision");
                    LineAmountLT := ROUND(GetItemTLAmount(0, SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.") / InterfaceEntryHeaderVIP."Currency Factor", GLSetup."Unit-Amount Rounding Precision") +
                      ROUND(GetItemTVACLAmount(0, SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.") / InterfaceEntryHeaderVIP."Currency Factor", GLSetup."Unit-Amount Rounding Precision");
                    //HEI.03<<
                    //HEI.06>>
                    ShipCostAmount := ROUND(GetItemShippingChargersAmount(0, SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.") / InterfaceEntryHeaderVIP."Currency Factor", GLSetup."Unit-Amount Rounding Precision");
                    UnitPriceLCY := ROUND(SalesInvoiceLine."Unit Price" / InterfaceEntryHeaderVIP."Currency Factor", GLSetup."Unit-Amount Rounding Precision");
                    //HEI.06<<
                    if SalesInvoiceLine.Type <> SalesInvoiceLine.Type::"Charge (Item)" then begin
                        TempSalesInvoiceLine.RESET();
                        TempSalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type);
                        TempSalesInvoiceLine.SETRANGE("No.", SalesInvoiceLine."No.");
                        TempSalesInvoiceLine.SETRANGE("Unit Price", SalesInvoiceLine."Unit Price");
                        if TempSalesInvoiceLine.FINDFIRST() then begin
                            TempSalesInvoiceLine.Quantity := TempSalesInvoiceLine.Quantity + SalesInvoiceLine.Quantity;
                            TempSalesInvoiceLine.Amount := TempSalesInvoiceLine.Amount + LineAmountExclVAT;
                            TempSalesInvoiceLine."Amount Including VAT" := TempSalesInvoiceLine."Amount Including VAT" + LineAmount;
                            TempSalesInvoiceLine."Line Discount Amount" := TempSalesInvoiceLine."Line Discount Amount" + LineDiscountAmount;
                            TempSalesInvoiceLine."Line Amount" := TempSalesInvoiceLine."Line Amount" + LineAmountCT;//HEI.03
                            TempSalesInvoiceLine."VAT Base Amount" := TempSalesInvoiceLine."VAT Base Amount" + LineAmountLT;//HEI.03
                            TempSalesInvoiceLine."Unit Cost (LCY)" := UnitPriceLCY + ShipCostAmount;//HEI.06>>
                            TempSalesInvoiceLine.MODIFY();
                            CLEAR(ItemLineBuffer);
                            ItemLineBuffer."Line No." := TempSalesInvoiceLine."Line No.";
                            ItemLineBuffer."Field No." := SalesInvoiceLine."Line No.";
                            ItemLineBuffer.INSERT();
                        end else begin
                            CLEAR(TempSalesInvoiceLine);
                            TempSalesInvoiceLine := SalesInvoiceLine;
                            TempSalesInvoiceLine.Amount := LineAmountExclVAT;
                            TempSalesInvoiceLine."Amount Including VAT" := LineAmount;
                            TempSalesInvoiceLine."Line Discount Amount" := LineDiscountAmount;
                            TempSalesInvoiceLine."Line Amount" := LineAmountCT;//HEI.03
                            TempSalesInvoiceLine."VAT Base Amount" := LineAmountLT;//HEI.03
                            TempSalesInvoiceLine."Unit Cost (LCY)" := UnitPriceLCY + ShipCostAmount;//HEI.06
                            TempSalesInvoiceLine.INSERT();
                            CLEAR(ItemLineBuffer);
                            ItemLineBuffer."Line No." := TempSalesInvoiceLine."Line No.";
                            ItemLineBuffer."Field No." := TempSalesInvoiceLine."Line No.";
                            ItemLineBuffer.INSERT();
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
                    InterfaceEntryLineVIP.Quantity := TempSalesInvoiceLine.Quantity;
                    InterfaceEntryLineVIP."VAT %" := TempSalesInvoiceLine."VAT %";
                    InterfaceEntryLineVIP."VAT Amount" := TempSalesInvoiceLine."Amount Including VAT" - TempSalesInvoiceLine.Amount;
                    InterfaceEntryLineVIP."Line Amount" := TempSalesInvoiceLine.Amount + TempSalesInvoiceLine."Line Amount";//HEI.03
                    InterfaceEntryLineVIP."Direct Unit Cost Multiplier" := ROUND(TempSalesInvoiceLine."Line Discount Amount" / InterfaceEntryLineVIP.Quantity,
                                                                              GLSetup."Unit-Amount Rounding Precision");
                    //HEI.03>
                    //IF InterfaceEntryLineVIP.Quantity = 0 THEN
                    //  InterfaceEntryLineVIP."Unit Amount" := InterfaceEntryLineVIP."Line Amount"
                    //ELSE
                    //  InterfaceEntryLineVIP."Unit Amount" := ROUND(InterfaceEntryLineVIP."Line Amount" / InterfaceEntryLineVIP.Quantity,
                    //                                            GLSetup."Unit-Amount Rounding Precision");
                    InterfaceEntryLineVIP."Unit Amount" := TempSalesInvoiceLine."Unit Cost (LCY)";//item_price
                    InterfaceEntryLineVIP."Length Reflex 1st" := TempSalesInvoiceLine."Line Amount" * TempSalesInvoiceLine.Quantity;//item_ct
                    InterfaceEntryLineVIP."Length Reflex 2rd" := TempSalesInvoiceLine."VAT Base Amount" * TempSalesInvoiceLine.Quantity;//item_tl
                    InterfaceEntryLineVIP."Line Amount" := (TempSalesInvoiceLine."Unit Cost (LCY)" + TempSalesInvoiceLine."Line Amount") * TempSalesInvoiceLine.Quantity;//item_price_nvat
                    InterfaceEntryLineVIP."VAT Amount" := ROUND(((TempSalesInvoiceLine."Unit Cost (LCY)" + TempSalesInvoiceLine."Line Amount") * TempSalesInvoiceLine.Quantity * TempSalesInvoiceLine."VAT %" / 100), GLSetup."Unit-Amount Rounding Precision");//vat amount
                    InterfaceEntryLineVIP."Amount Incl. VAT" := InterfaceEntryLineVIP."Line Amount" + InterfaceEntryLineVIP."VAT Amount";//item_price_wvat
                    InterfaceEntryLineVIP."Planned Quantity" := InterfaceEntryLineVIP."Line Amount" + InterfaceEntryLineVIP."VAT Amount" + InterfaceEntryLineVIP."Length Reflex 2rd";//item_total_amount
                                                                                                                                                                                     //HEI.03<<
                    InterfaceEntryLineVIP.INSERT();

                    DocAmountInclVAT := DocAmountInclVAT + InterfaceEntryLineVIP."Line Amount";
                    DocVATAmount := DocVATAmount + InterfaceEntryLineVIP."VAT Amount";
                until TempSalesInvoiceLine.NEXT() = 0;
            InterfaceEntryHeaderVIP.MODIFY();
        end;
    end;
    // BC Upgrade PATELP08 <<

    // BC Upgrade PATELP08 >> Added HEI.09 Documentation Implementation
    local procedure CreateCrMemoRequest(SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT"; WithLines: Boolean);
    var
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        SalesHeader: Record "Sales Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
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
        LineAmountCT: Decimal;
        LineAmountLT: Decimal;
        ShipCostAmount: Decimal;
        UnitPriceLCY: Decimal;
    begin
        CLEAR(InterfaceEntryHeaderVIP);
        //HEI.03>>
        CompInfo.GET();
        // CompInfo.TESTFIELD("Legal Form");  // BC Upgrade NANDIS03 - Blocked as FR localization field
        CompInfo.TESTFIELD("Legal Form FND");  // BC Upgrade KUMARR78 18-06-2026++

        //HEI.03<<
        if SalesCrMemoHeader."Fiscal Printer Status FND" <= SalesCrMemoHeader."Fiscal Printer Status FND"::"Not Sent to Fiscal Printer" then
            InterfaceEntryHeaderVIP."Interface Code" := EBMSInterfaceSetup."Send Invoice Interface"
        else
            InterfaceEntryHeaderVIP."Interface Code" := EBMSInterfaceSetup."Sales Confirmation Interface";
        InterfaceEntryHeaderVIP.Direction := InterfaceEntryHeaderVIP.Direction::Outbound;
        InterfaceEntryHeaderVIP."Type ID" := 'REFUND';
        if STRPOS(USERID, '\') = 0 then
            InterfaceEntryHeaderVIP."Your Reference" := USERID
        else
            InterfaceEntryHeaderVIP."Your Reference" := COPYSTR(USERID, STRPOS(USERID, '\') + 1, STRLEN(USERID) - STRPOS(USERID, '\'));
        InterfaceEntryHeaderVIP."Source Type" := DATABASE::"Sales Cr.Memo Header";
        InterfaceEntryHeaderVIP."Source Subtype" := SalesHeader."Document Type"::"Credit Memo".AsInteger();
        InterfaceEntryHeaderVIP."Source No." := SalesCrMemoHeader."No.";
        InterfaceEntryHeaderVIP."Global No." := CompInfo."VAT Registration No.";
        //HEI.05>>
        // InterfaceEntryHeaderVIP."Posting Date" := SalesCrMemoHeader."Posting Date";
        InterfaceEntryHeaderVIP."Pay-to Vendor No." := FORMAT(SalesCrMemoHeader."Posting Date", 0, '<Year4>-<Month,2>-<Day,2>') + ' ' + FORMAT(TIME, 0, '<Hours24>:<Minutes,2>:<Seconds,2>');
        //HEI.05<<
        InterfaceEntryHeaderVIP."Sell-to Customer No." := SalesCrMemoHeader."Sell-to Customer No.";
        InterfaceEntryHeaderVIP.Name := CompInfo.Name;
        InterfaceEntryHeaderVIP."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderVIP."Currency Code" := GLSetup."LCY Code";
        //HEI.03>>
        InterfaceEntryHeaderVIP."External Document No." := CompInfo."Registration No.";
        InterfaceEntryHeaderVIP."Delivery Method" := CompInfo."Post Code";
        InterfaceEntryHeaderVIP."Phone No." := CompInfo."Phone No.";
        InterfaceEntryHeaderVIP.Description := CompInfo.Address;
        InterfaceEntryHeaderVIP."Your Reference" := '2';
        InterfaceEntryHeaderVIP.Name5 := GetPaymentTermsCode(SalesCrMemoHeader."Payment Method Code");
        InterfaceEntryHeaderVIP.Name2 := SalesCrMemoHeader."Bill-to Name";
        InterfaceEntryHeaderVIP.Name3 := SalesCrMemoHeader."VAT Registration No.";
        InterfaceEntryHeaderVIP.Address := SalesCrMemoHeader."Bill-to Address";
        InterfaceEntryHeaderVIP."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderVIP.County := UPPERCASE(COMPANYNAME);
        InterfaceEntryHeaderVIP."Currency Factor" := 1;
        InterfaceEntryHeaderVIP.Comment := STRSUBSTNO('%1/%2/%3/%4', CompInfo."VAT Registration No.", EBMSInterfaceSetup."Taxpayer System ID",
          (FORMAT(SalesCrMemoHeader."Posting Date", 0, '<Year4><Month,2><Day,2>') + FORMAT(TIME, 0, '<Hours24><Minutes,2><Seconds,2>')), SalesCrMemoHeader."No."); //HEI.05
        InterfaceEntryHeaderVIP."Buy-from Vendor No." := FORMAT(SalesCrMemoHeader."Posting Date", 0, '<Year4>-<Month,2>-<Day,2>') + ' ' + FORMAT(TIME, 0, '<Hours24>:<Minutes,2>:<Seconds,2>'); //HEI.05 //HEI.08
        // InterfaceEntryHeaderVIP."Legal Form" := CompInfo."Legal Form";  // BC Upgrade NANDIS03 - Blocked as FR localization field
        InterfaceEntryHeaderVIP."Legal Form" := CompInfo."Legal Form FND";  // BC Upgrade KUMARR78 18-06-2026++

        //HEI.03<<
        if SalesCrMemoHeader."Currency Factor" <> 0 then
            InterfaceEntryHeaderVIP."Currency Factor" := SalesCrMemoHeader."Currency Factor"
        else
            InterfaceEntryHeaderVIP."Currency Factor" := 1;
        InterfaceEntryHeaderVIP."External Document No." := SalesCrMemoHeader."No.";
        InterfaceEntryHeaderVIP."Bill-to Customer No." := 'FA';//HEI.07 //HEI.08
        InterfaceEntryHeaderVIP.INSERT(true);
        SalesCrMemoLine.SETRANGE("Document No.", SalesCrMemoHeader."No.");
        SalesCrMemoLine.SETRANGE(Type, SalesCrMemoLine.Type::Item);//HEI.03
        if WithLines then begin
            SalesCrMemoLine.SETFILTER("No.", '<>%1', '');
            SalesCrMemoLine.SETFILTER(Quantity, '<>%1', 0);
            // BC Upgrade PATELP08 >> Added Item Category filter from EBMS Setup to include only EBMS relevant lines in credit memo request
            // HEI.09 >>
            SalesCrMemoLine.SETFILTER("Item Category Code",
                                      EBMSInterfaceSetup."Item Category Code Filter");
            // HEI.09 <<
            // BC Upgrade PATELP08 <<
            if SalesCrMemoLine.findset() then
                repeat
                    if SalesCrMemoHeader."Prices Including VAT" then begin
                        UnitPrice := ROUND(SalesCrMemoLine."Unit Price" / InterfaceEntryHeaderVIP."Currency Factor", GLSetup."Unit-Amount Rounding Precision");
                        LineDiscountAmount := -ROUND(SalesCrMemoLine."Line Discount Amount" / InterfaceEntryHeaderVIP."Currency Factor", GLSetup."Amount Rounding Precision");
                        LineAmount := ROUND(SalesCrMemoLine.Quantity * SalesCrMemoLine."Unit Price" / InterfaceEntryHeaderVIP."Currency Factor", GLSetup."Amount Rounding Precision");
                        LineAmountExclVAT := ROUND(LineAmount / (1 + SalesCrMemoLine."VAT %" / 100) / InterfaceEntryHeaderVIP."Currency Factor", GLSetup."Unit-Amount Rounding Precision");
                        LineVATAmount := LineAmount - LineAmountExclVAT;
                    end else begin
                        UnitPrice := ROUND((SalesCrMemoLine."Unit Price" + SalesCrMemoLine."Unit Price" * (SalesCrMemoLine."VAT %" / 100)) / InterfaceEntryHeaderVIP."Currency Factor",
                                           GLSetup."Unit-Amount Rounding Precision");
                        LineDiscountAmount := -ROUND((SalesCrMemoLine."Line Discount Amount" +
                                                        SalesCrMemoLine."Line Discount Amount" * (SalesCrMemoLine."VAT %" / 100)) / InterfaceEntryHeaderVIP."Currency Factor",
                                                       GLSetup."Amount Rounding Precision");
                        LineAmountExclVAT := ROUND(SalesCrMemoLine.Quantity * SalesCrMemoLine."Unit Price" / InterfaceEntryHeaderVIP."Currency Factor", GLSetup."Amount Rounding Precision");
                        LineVATAmount := ROUND(LineAmountExclVAT * (SalesCrMemoLine."VAT %" / 100) / InterfaceEntryHeaderVIP."Currency Factor", GLSetup."Amount Rounding Precision");
                        LineAmount := LineAmountExclVAT + LineVATAmount;
                    end;
                    //HEI.03>>
                    LineAmountCT := ROUND(GetItemCTAmount(1, SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.") / InterfaceEntryHeaderVIP."Currency Factor", GLSetup."Unit-Amount Rounding Precision");
                    LineAmountLT := ROUND(GetItemTLAmount(1, SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.") / InterfaceEntryHeaderVIP."Currency Factor", GLSetup."Unit-Amount Rounding Precision") +
                      ROUND(GetItemTVACLAmount(1, SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.") / InterfaceEntryHeaderVIP."Currency Factor", GLSetup."Unit-Amount Rounding Precision");
                    //HEI.03<<
                    //HEI.06>>
                    ShipCostAmount := ROUND(GetItemShippingChargersAmount(1, SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.") / InterfaceEntryHeaderVIP."Currency Factor", GLSetup."Unit-Amount Rounding Precision");
                    UnitPriceLCY := ROUND(SalesCrMemoLine."Unit Price" / InterfaceEntryHeaderVIP."Currency Factor", GLSetup."Unit-Amount Rounding Precision");
                    //HEI.06<<
                    if SalesCrMemoLine.Type <> SalesCrMemoLine.Type::"Charge (Item)" then begin
                        TempSalesCrMemoLine.RESET();
                        TempSalesCrMemoLine.SETRANGE(Type, SalesCrMemoLine.Type);
                        TempSalesCrMemoLine.SETRANGE("No.", SalesCrMemoLine."No.");
                        TempSalesCrMemoLine.SETRANGE("Unit Price", SalesCrMemoLine."Unit Price");
                        if TempSalesCrMemoLine.FINDFIRST() then begin
                            TempSalesCrMemoLine.Quantity := TempSalesCrMemoLine.Quantity + SalesCrMemoLine.Quantity;
                            TempSalesCrMemoLine.Amount := TempSalesCrMemoLine.Amount + LineAmountExclVAT;
                            TempSalesCrMemoLine."Amount Including VAT" := TempSalesCrMemoLine."Amount Including VAT" + LineAmount;
                            TempSalesCrMemoLine."Line Discount Amount" := TempSalesCrMemoLine."Line Discount Amount" + LineDiscountAmount;
                            TempSalesCrMemoLine."Line Amount" := TempSalesCrMemoLine."Line Amount" + LineAmountCT;//HEI.03
                            TempSalesCrMemoLine."VAT Base Amount" := TempSalesCrMemoLine."VAT Base Amount" + LineAmountLT;//HEI.03
                            TempSalesCrMemoLine."Unit Cost (LCY)" := UnitPriceLCY + ShipCostAmount;//HEI.06
                            TempSalesCrMemoLine.MODIFY();
                            CLEAR(ItemLineBuffer);
                            ItemLineBuffer."Line No." := TempSalesCrMemoLine."Line No.";
                            ItemLineBuffer."Field No." := SalesCrMemoLine."Line No.";
                            ItemLineBuffer.INSERT();
                        end else begin
                            CLEAR(TempSalesCrMemoLine);
                            TempSalesCrMemoLine := SalesCrMemoLine;
                            TempSalesCrMemoLine.Amount := LineAmountExclVAT;
                            TempSalesCrMemoLine."Amount Including VAT" := LineAmount;
                            TempSalesCrMemoLine."Line Discount Amount" := LineDiscountAmount;
                            TempSalesCrMemoLine."Line Amount" := LineAmountCT;//HEI.03
                            TempSalesCrMemoLine."VAT Base Amount" := LineAmountLT;//HEI.03
                            TempSalesCrMemoLine."Unit Cost (LCY)" := UnitPriceLCY + ShipCostAmount;//HEI.06
                            TempSalesCrMemoLine.INSERT();
                            CLEAR(ItemLineBuffer);
                            ItemLineBuffer."Line No." := TempSalesCrMemoLine."Line No.";
                            ItemLineBuffer."Field No." := TempSalesCrMemoLine."Line No.";
                            ItemLineBuffer.INSERT();
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
                    InterfaceEntryLineVIP.Quantity := TempSalesCrMemoLine.Quantity;
                    InterfaceEntryLineVIP."VAT %" := TempSalesCrMemoLine."VAT %";
                    InterfaceEntryLineVIP."VAT Amount" := TempSalesCrMemoLine."Amount Including VAT" - TempSalesCrMemoLine.Amount;
                    InterfaceEntryLineVIP."Line Amount" := TempSalesCrMemoLine.Amount + TempSalesCrMemoLine."Line Amount";//HEI.03
                    InterfaceEntryLineVIP."Direct Unit Cost Multiplier" := ROUND(TempSalesCrMemoLine."Line Discount Amount" / InterfaceEntryLineVIP.Quantity,
                                                                              GLSetup."Unit-Amount Rounding Precision");
                    //HEI.03>>
                    //IF InterfaceEntryLineVIP.Quantity = 0 THEN
                    //  InterfaceEntryLineVIP."Unit Amount" := InterfaceEntryLineVIP."Line Amount"
                    //ELSE
                    //  InterfaceEntryLineVIP."Unit Amount" := ROUND(InterfaceEntryLineVIP."Line Amount" / InterfaceEntryLineVIP.Quantity,
                    //                                            GLSetup."Unit-Amount Rounding Precision");

                    InterfaceEntryLineVIP."Unit Amount" := TempSalesCrMemoLine."Unit Cost (LCY)";//item_price
                    InterfaceEntryLineVIP."Length Reflex 1st" := TempSalesCrMemoLine."Line Amount" * TempSalesCrMemoLine.Quantity;//item_ct
                    InterfaceEntryLineVIP."Length Reflex 2rd" := TempSalesCrMemoLine."VAT Base Amount" * TempSalesCrMemoLine.Quantity;//item_tl
                    InterfaceEntryLineVIP."Line Amount" := (TempSalesCrMemoLine."Unit Cost (LCY)" + TempSalesCrMemoLine."Line Amount") * TempSalesCrMemoLine.Quantity;//item_price_nvat
                    InterfaceEntryLineVIP."VAT Amount" := ROUND(((TempSalesCrMemoLine."Unit Cost (LCY)" + TempSalesCrMemoLine."Line Amount") * TempSalesCrMemoLine.Quantity * TempSalesCrMemoLine."VAT %" / 100), GLSetup."Unit-Amount Rounding Precision");//vat amount
                    InterfaceEntryLineVIP."Amount Incl. VAT" := InterfaceEntryLineVIP."Line Amount" + InterfaceEntryLineVIP."VAT Amount";//item_price_wvat
                    InterfaceEntryLineVIP."Planned Quantity" := InterfaceEntryLineVIP."Line Amount" + InterfaceEntryLineVIP."VAT Amount" + InterfaceEntryLineVIP."Length Reflex 2rd";//item_total_amount
                                                                                                                                                                                     //HEI.03<<
                                                                                                                                                                                     //HEI.03<<
                    InterfaceEntryLineVIP.INSERT();

                    DocAmountInclVAT := DocAmountInclVAT + InterfaceEntryLineVIP."Line Amount";
                    DocVATAmount := DocVATAmount + InterfaceEntryLineVIP."VAT Amount";
                until TempSalesCrMemoLine.NEXT() = 0;

            InterfaceEntryHeaderVIP.Amount := DocAmountInclVAT - DocVATAmount;
            InterfaceEntryHeaderVIP."VAT Amount" := DocVATAmount;
            InterfaceEntryHeaderVIP."Amount Including VAT" := DocAmountInclVAT;
            InterfaceEntryHeaderVIP."Version No." := FORMAT(TempSalesCrMemoLine.COUNT);
            InterfaceEntryHeaderVIP.MODIFY();
        end;
    end;
    // BC Upgrade PATELP08 <<

    local procedure ProcessOutboundInvoiceEntry(var SalesInvoiceHeader: Record "Sales Invoice Header"; InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    begin
        COMMIT();
        GetEBMInterfaceSetup();
        if CODEUNIT.RUN(CODEUNIT::"Outbound Interface Process VIP", InterfaceEntryHeaderVIP) then begin
            InterfaceFrameworkMgtVIP.SetInterfaceProcessed(InterfaceEntryHeaderVIP);
            InterfaceFrameworkMgtVIP.LogInterfaceEntries(InterfaceEntryHeaderVIP);
            InterfaceFrameworkMgtVIP.DeleteInterfaceEntries(InterfaceEntryHeaderVIP);
            SalesInvoiceHeader."Fiscal Printer Status FND" := SalesInvoiceHeader."Fiscal Printer Status FND"::"Sent to Middleware";
            SalesInvoiceHeader.MODIFY();
            //HEI.02>>
            CLEAR(EBMSDocumentStatus);
            //HEI.04>>
            EBMSDocumentStatus.SETRANGE("Document Type", EBMSDocumentStatus."Document Type"::Invoice);
            EBMSDocumentStatus.SETRANGE("Document No.", SalesInvoiceHeader."No.");
            if EBMSDocumentStatus.ISEMPTY then begin
                //HEI.04<<
                EBMSDocumentStatus.INIT();
                EBMSDocumentStatus."Document Type" := EBMSDocumentStatus."Document Type"::Invoice;
                EBMSDocumentStatus."Document No." := SalesInvoiceHeader."No.";
                EBMSDocumentStatus.INSERT();
            end;  //HEI.04
            if EBMSDocumentStatus.FINDFIRST() then; //HEI.04
            EBMSDocumentStatus."Invoice Details Created" := TODAY;
            EBMSDocumentStatus."Invoice Details Outbnd Status" := EBMSDocumentStatus."Invoice Details Outbnd Status"::Processed;
            EBMSDocumentStatus."Invoice Details Sent to EBMS" := true;
            EBMSDocumentStatus."Last Updated" := CURRENTDATETIME;
            EBMSDocumentStatus.MODIFY();  //HEI.04
                                          //HEI.02<<
            if InterfaceEntryHeaderVIP."Interface Code" = EBMSInterfaceSetup."Send Invoice Interface" then
                if GUIALLOWED then
                    MESSAGE(SentToMiddlewareTxt);
        end else begin
            InterfaceFrameworkMgtVIP.SetInterfaceError(InterfaceEntryHeaderVIP, GETLASTERRORTEXT);
            SalesInvoiceHeader."Fiscal Printer Status FND" := SalesInvoiceHeader."Fiscal Printer Status FND"::"Not Sent to Middleware";
            SalesInvoiceHeader.MODIFY();
            //HEI.02>>
            CLEAR(EBMSDocumentStatus);
            //HEI.04>>
            EBMSDocumentStatus.SETRANGE("Document Type", EBMSDocumentStatus."Document Type"::Invoice);
            EBMSDocumentStatus.SETRANGE("Document No.", SalesInvoiceHeader."No.");
            if EBMSDocumentStatus.ISEMPTY then begin
                //HEI.04<<
                EBMSDocumentStatus.INIT();
                EBMSDocumentStatus."Document Type" := EBMSDocumentStatus."Document Type"::Invoice;
                EBMSDocumentStatus."Document No." := SalesInvoiceHeader."No.";
                EBMSDocumentStatus.INSERT();
            end;  //HEI.04
            if EBMSDocumentStatus.FINDFIRST() then; //HEI.04
            EBMSDocumentStatus."Invoice Details Created" := TODAY;
            EBMSDocumentStatus."Invoice Details Outbnd Status" := EBMSDocumentStatus."Invoice Details Outbnd Status"::Error;
            EBMSDocumentStatus."Invoice Details Sent to EBMS" := false;
            EBMSDocumentStatus."Last Updated" := CURRENTDATETIME;
            EBMSDocumentStatus.MODIFY();  //HEI.04
                                          //HEI.02<<
            if InterfaceEntryHeaderVIP."Interface Code" = EBMSInterfaceSetup."Send Invoice Interface" then
                if GUIALLOWED then
                    MESSAGE(STRSUBSTNO(NotSentToMiddlewareTxt, GETLASTERRORTEXT));
        end;
    end;

    local procedure ProcessOutboundCrMemoEntry(SalesCrMemoHeader: Record "Sales Cr.Memo Header"; InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    begin
        COMMIT();
        GetEBMInterfaceSetup();
        if CODEUNIT.RUN(CODEUNIT::"Outbound Interface Process VIP", InterfaceEntryHeaderVIP) then begin
            InterfaceFrameworkMgtVIP.SetInterfaceProcessed(InterfaceEntryHeaderVIP);
            InterfaceFrameworkMgtVIP.LogInterfaceEntries(InterfaceEntryHeaderVIP);
            InterfaceFrameworkMgtVIP.DeleteInterfaceEntries(InterfaceEntryHeaderVIP);
            SalesCrMemoHeader."Fiscal Printer Status FND" := SalesCrMemoHeader."Fiscal Printer Status FND"::"Sent to Middleware";
            SalesCrMemoHeader.MODIFY();
            //HEI.02>>
            CLEAR(EBMSDocumentStatus);
            //HEI.04>>
            EBMSDocumentStatus.SETRANGE("Document Type", EBMSDocumentStatus."Document Type"::"Credit Memo");
            EBMSDocumentStatus.SETRANGE("Document No.", SalesCrMemoHeader."No.");
            if EBMSDocumentStatus.ISEMPTY then begin
                //HEI.04<<
                EBMSDocumentStatus.INIT();
                EBMSDocumentStatus."Document Type" := EBMSDocumentStatus."Document Type"::"Credit Memo";
                EBMSDocumentStatus."Document No." := SalesCrMemoHeader."No.";
                EBMSDocumentStatus.INSERT();
            end;  //HEI.04
            if EBMSDocumentStatus.FINDFIRST() then; //HEI.04
            EBMSDocumentStatus."Invoice Details Created" := TODAY;
            EBMSDocumentStatus."Invoice Details Outbnd Status" := EBMSDocumentStatus."Invoice Details Outbnd Status"::Processed;
            EBMSDocumentStatus."Invoice Details Sent to EBMS" := true;
            EBMSDocumentStatus."Last Updated" := CURRENTDATETIME;
            EBMSDocumentStatus.MODIFY();  //HEI.04
                                          //HEI.02<<
            if InterfaceEntryHeaderVIP."Interface Code" = EBMSInterfaceSetup."Send Invoice Interface" then
                if GUIALLOWED then
                    MESSAGE(SentToMiddlewareTxt);
        end else begin
            InterfaceFrameworkMgtVIP.SetInterfaceError(InterfaceEntryHeaderVIP, GETLASTERRORTEXT);
            SalesCrMemoHeader."Fiscal Printer Status FND" := SalesCrMemoHeader."Fiscal Printer Status FND"::"Not Sent to Middleware";
            SalesCrMemoHeader.MODIFY();
            //HEI.02>>
            CLEAR(EBMSDocumentStatus);
            //HEI.04>>
            EBMSDocumentStatus.SETRANGE("Document Type", EBMSDocumentStatus."Document Type"::"Credit Memo");
            EBMSDocumentStatus.SETRANGE("Document No.", SalesCrMemoHeader."No.");
            if EBMSDocumentStatus.ISEMPTY then begin
                //HEI.04<<
                EBMSDocumentStatus.INIT();
                EBMSDocumentStatus."Document Type" := EBMSDocumentStatus."Document Type"::"Credit Memo";
                EBMSDocumentStatus."Document No." := SalesCrMemoHeader."No.";
                EBMSDocumentStatus.INSERT();
            end;  //HEI.04
            if EBMSDocumentStatus.FINDFIRST() then; //HEI.04
            EBMSDocumentStatus."Invoice Details Created" := TODAY;
            EBMSDocumentStatus."Invoice Details Outbnd Status" := EBMSDocumentStatus."Invoice Details Outbnd Status"::Error;
            EBMSDocumentStatus."Invoice Details Sent to EBMS" := false;
            EBMSDocumentStatus."Last Updated" := CURRENTDATETIME;
            EBMSDocumentStatus.MODIFY();  //HEI.04
                                          //HEI.02<<
            if InterfaceEntryHeaderVIP."Interface Code" = EBMSInterfaceSetup."Send Invoice Interface" then
                if GUIALLOWED then
                    MESSAGE(STRSUBSTNO(NotSentToMiddlewareTxt, GETLASTERRORTEXT));
        end;
    end;

    procedure IsEBMDocumentType(DocumentType: Integer; DocumentSubTypeCode: Code[10]): Boolean;
    var
        EBMDocumentType: Record "EBMS Document Type FND";
    begin
        EBMDocumentType.SETRANGE("Document Type", DocumentType);
        EBMDocumentType.SETFILTER("Document Subtype Code", '%1|%2', '', DocumentSubTypeCode);
        if EBMDocumentType.FINDFIRST() then
            exit(true);
        exit(false);
    end;

    local procedure CheckSalesHeader(SalesHeader: Record "Sales Header");
    var
        SalesLine: Record "Sales Line";
        VATRegNo: Integer;
        InterfaceLogHeaderVIP: Record "Interface Log Header VIP INT";
    begin
        GetEBMInterfaceSetup();
        SalesHeader.TESTFIELD("Sell-to Customer Name");
        SalesHeader.TESTFIELD("VAT Registration No.");
        InterfaceLogHeaderVIP.SETRANGE("Interface Code", EBMSInterfaceSetup."Send Invoice Interface");
        InterfaceLogHeaderVIP.SETRANGE("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
        if InterfaceLogHeaderVIP.FINDLAST() then
            SalesHeader.TESTFIELD("Sell-to Customer Name", InterfaceLogHeaderVIP.Name);
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

    local procedure GetGLSetup();
    begin
        if not GLSetupRead then
            GLSetup.GET();
        GLSetupRead := true;
    end;

    local procedure GetSalesSetup();
    begin
        if not SalesSetupRead then
            SalesSetup.GET();
        SalesSetupRead := true;
    end;

    local procedure GetGeneralInterfaceSetup();
    begin
        if not GeneralInterfaceSetupRead then
            GeneralInterfaceSetup.GET();
        GeneralInterfaceSetupRead := true;
    end;

    local procedure GetEBMInterfaceSetup();
    begin
        if not EBMInterfaceSetupRead then
            if EBMSInterfaceSetup.GET() then;
        EBMInterfaceSetupRead := true;
    end;

    local procedure InitDocInfo(DocNo: Code[20]; DocType: Integer; EBMSDocumentStatus: Record "EBMS Document Status FND");
    begin
        if EBMSDocumentStatus.GET(DocType, DocNo) then
            exit;

        EBMSDocumentStatus."Document Type" := DocType;
        EBMSDocumentStatus."Document No." := DocNo;
        EBMSDocumentStatus.INSERT();
    end;

    local procedure GetPaymentTermsCode(PaymentTermsCode: Code[20]): Code[10];
    begin
        case PaymentTermsCode of
            'CASH ORDER':
                exit('1');
            'BANK CON':
                exit('2');
            'CHEQUE':
                exit('3');
            else
                exit('4');
        end;
    end;

    local procedure GetItemCTAmount(DocumentType: Option Invoice,"Credit Memo"; DocumentNo: Code[20]; LineNo: Integer): Decimal;
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        //HEI.03
        if EBMSInterfaceSetup."CT Gen. Prod. Posting Gr." = '' then
            exit(0);
        case DocumentType of
            DocumentType::"Credit Memo":
                begin
                    SalesCrMemoLine.SETRANGE("Document No.", DocumentNo);
                    SalesCrMemoLine.SETRANGE("Attached to Line No.", LineNo);
                    SalesCrMemoLine.SETRANGE("Gen. Prod. Posting Group", EBMSInterfaceSetup."CT Gen. Prod. Posting Gr.");
                    if SalesCrMemoLine.FINDFIRST() then
                        exit(SalesCrMemoLine."Unit Price")
                    else
                        exit(0);
                end;
            DocumentType::Invoice:
                begin
                    SalesInvoiceLine.SETRANGE("Document No.", DocumentNo);
                    SalesInvoiceLine.SETRANGE("Attached to Line No.", LineNo);
                    SalesInvoiceLine.SETRANGE("Gen. Prod. Posting Group", EBMSInterfaceSetup."CT Gen. Prod. Posting Gr.");
                    if SalesInvoiceLine.FINDFIRST() then
                        exit(SalesInvoiceLine."Unit Price")
                    else
                        exit(0);
                end;
        end;
    end;

    local procedure GetItemTLAmount(DocumentType: Option Invoice,"Credit Memo"; DocumentNo: Code[20]; LineNo: Integer): Decimal;
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        //HEI.03
        if EBMSInterfaceSetup."TL Gen. Prod. Posting Gr." = '' then
            exit(0);
        case DocumentType of
            DocumentType::"Credit Memo":
                begin
                    SalesCrMemoLine.SETRANGE("Document No.", DocumentNo);
                    SalesCrMemoLine.SETRANGE("Attached to Line No.", LineNo);
                    SalesCrMemoLine.SETRANGE("Gen. Prod. Posting Group", EBMSInterfaceSetup."TL Gen. Prod. Posting Gr.");
                    if SalesCrMemoLine.FINDFIRST() then
                        exit(SalesCrMemoLine."Unit Price")
                    else
                        exit(0);
                end;
            DocumentType::Invoice:
                begin
                    SalesInvoiceLine.SETRANGE("Document No.", DocumentNo);
                    SalesInvoiceLine.SETRANGE("Attached to Line No.", LineNo);
                    SalesInvoiceLine.SETRANGE("Gen. Prod. Posting Group", EBMSInterfaceSetup."TL Gen. Prod. Posting Gr.");
                    if SalesInvoiceLine.FINDFIRST() then
                        exit(SalesInvoiceLine."Unit Price")
                    else
                        exit(0);
                end;
        end;
    end;

    local procedure GetItemShippingChargersAmount(DocumentType: Option Invoice,"Credit Memo"; DocumentNo: Code[20]; LineNo: Integer): Decimal;
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        //HEI.06
        if EBMSInterfaceSetup."Shipping Cost Item Charge No." = '' then
            exit(0);
        case DocumentType of
            DocumentType::"Credit Memo":
                begin
                    SalesCrMemoLine.SETRANGE("Document No.", DocumentNo);
                    SalesCrMemoLine.SETRANGE("Attached to Line No.", LineNo);
                    SalesCrMemoLine.SETRANGE(Type, SalesInvoiceLine.Type::"Charge (Item)");
                    SalesCrMemoLine.SETRANGE("No.", EBMSInterfaceSetup."Shipping Cost Item Charge No.");
                    if SalesCrMemoLine.FINDFIRST() then
                        exit(SalesCrMemoLine."Unit Price")
                    else
                        exit(0);
                end;
            DocumentType::Invoice:
                begin
                    SalesInvoiceLine.SETRANGE("Document No.", DocumentNo);
                    SalesInvoiceLine.SETRANGE("Attached to Line No.", LineNo);
                    SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::"Charge (Item)");
                    SalesInvoiceLine.SETRANGE("No.", EBMSInterfaceSetup."Shipping Cost Item Charge No.");
                    if SalesInvoiceLine.FINDFIRST() then
                        exit(SalesInvoiceLine."Unit Price")
                    else
                        exit(0);
                end;
        end;
    end;

    local procedure GetItemTVACLAmount(DocumentType: Option Invoice,"Credit Memo"; DocumentNo: Code[20]; LineNo: Integer): Decimal;
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        //HEI.06
        if EBMSInterfaceSetup."VAT Cust. Gen. Prod. P. Gr." = '' then
            exit(0);
        case DocumentType of
            DocumentType::"Credit Memo":
                begin
                    SalesCrMemoLine.SETRANGE("Document No.", DocumentNo);
                    SalesCrMemoLine.SETRANGE("Attached to Line No.", LineNo);
                    SalesCrMemoLine.SETRANGE("Gen. Prod. Posting Group", EBMSInterfaceSetup."VAT Cust. Gen. Prod. P. Gr.");
                    if SalesCrMemoLine.FINDFIRST() then
                        exit(SalesCrMemoLine."Unit Price")
                    else
                        exit(0);
                end;
            DocumentType::Invoice:
                begin
                    SalesInvoiceLine.SETRANGE("Document No.", DocumentNo);
                    SalesInvoiceLine.SETRANGE("Attached to Line No.", LineNo);
                    SalesInvoiceLine.SETRANGE("Gen. Prod. Posting Group", EBMSInterfaceSetup."VAT Cust. Gen. Prod. P. Gr.");
                    if SalesInvoiceLine.FINDFIRST() then
                        exit(SalesInvoiceLine."Unit Price")
                    else
                        exit(0);
                end;
        end;
    end;
}

