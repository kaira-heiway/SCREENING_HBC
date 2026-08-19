codeunit 58115 "Checking Sales API"
{
    // version HEI.03

    // HEI.01 CHG2188870 DEBUSD01 03.02.2023 Sales Order API Performance change flow
    // HEI.02 CHG2188870 DEBUSD01 08.02.2023 Sales Order API Performance change flow
    //   # Fix check and skip process if SO api interface log entry is status 'error'
    // HEI.03 CHG2205042 IBM BHANDS01 17.05.2023 Deadlock Issue
    //   # Code Optimization

    // BC Upgrade VAMSIU01 >>

    // # Old id 50159
    // # Blocked Dotnet variables and new Saas Compatible variables
    // # Replaced TempXmlNode.InnerText with TempXmlNode.AsXmlElement().Innertext()
    // # Blocked and added new Procedure for GetNodeByXPath with Saas compatible code 
    // # Blocked some code as dependent on Drinkit fields.
    // BC Upgrade VAMSIU01 <<
    // BC Upgare SHUKLP03 >> modified code for inbound, also replaced some DIT fields.


    TableNo = "API Interface Log2 INT";

    trigger OnRun();
    begin
        APIInterfaceLog2 := Rec;
        case APIInterfaceLog2.Entity of
            'SALES':
                begin
                    case APIInterfaceLog2.Operation of
                        'CREATE':
                            begin
                                CheckSales;
                            end;
                    end;
                end;
        end;
        Rec := APIInterfaceLog2;
    end;

    var
        APIInterfaceLog2: Record "API Interface Log2 INT";
        LastCodeStatusSkipErr: Label '#SKIPSTATUS#';
        BadNodeValueErr: Label '"%1 node has bad data tyoe value from XML "';
        MissingNodeErr: Label '%1 node missing from XML';
        TextMissingErr: Label 'Text missing for node %1 in XML';
        NothingToApproveErr: Label 'There is nothing to approve.';
        AmountValidationFailedErr: Label 'Total Amount including VAT for Document No. %1 in %2 does not match with Total Amount including VAT in Heilite. Please check.';
        PastDateErr: Label '%1 shouldn''t be a date in past';
        OrderAlreadyExistsErr: Label 'Sales Order %1 already exists.';
        ReturnOrderAlreadyExistsErr: Label 'Sales %1 %2 already exists.';
        ShipmentAlreadyExistsErr: Label 'Sales Shipment for Order %1 is already posted';
        ReceiptAlreadyExistsErr: Label 'Sales Receipt for Return Order %1 is already posted';
        OrderAlreadyExists2Err: Label 'Sales Order with External Document No. %1 already exists.';
        ShipmentAlreadyExists2Err: Label 'Sales Shipment with External Document No. %1 is already posted.';
        ReceiptAlreadyExists2Err: Label 'Sales Receipt with External Document No. %1 is already posted.';
        CCCDimensionCode: Code[20];
        CCCDimensionValue: Code[20];
        ReturnOrderLinkedSoExistsErr: Label 'Sales Retun Order %1 Linked to Sales Order No. %2 already exists.';

    local procedure CheckSales();
    var
        RequestInStream: InStream;
        //BC Upgrade VAMSIU01 >>
        // RequestXmlDocument : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        // OrderXmlNode : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // TempXmlNode : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // LinesXmlNodeList : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeList";
        // LineXmlNode : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        RequestXmlDocument: XmlDocument;
        OrderXmlNode: XmlNode;
        TempXmlNode: XmlNode;
        LinesXmlNodeList: XmlNodeList;
        LineXmlNode: XmlNode;
        //BC Upgrade VAMSIU01 <<
        APIInterfaceSetup2: Record "API Interface Setup2 INT";
        TSalesHeader: Record "Sales Header" temporary;
        Sequence: Integer;
        SequenceFound: Boolean;
        TSalesLine: array[2] of Record "Sales Line" temporary;
        TempDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        TempDate: Date;
        TempType: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        TempDecimal: Decimal;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ReleaseSalesDocument: Codeunit "Release Sales Document";
        CreatedSalesHeader: Record "Sales Header";
        PostedShipment: Record "Sales Shipment Header";
        PostedReceipt: Record "Return Receipt Header";
        IsGift: Boolean;
        CreatedSalesRetOrderNo: Code[20];
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        TempUnitPrice: Decimal;
        TempVATPerc: Decimal;
        TempAttachedToLineNo: Integer;
        ItemCharge: Record "Item Charge";
        VATPostingSetup: Record "VAT Posting Setup";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        DimensionManagement: Codeunit DimensionManagement;
        DefaultDimension: Record "Default Dimension";
        Route: Record Route107FDW; // BC Upgrade SHUKLP03 - Blocked as Drinkit dependent table.
        OrderDate: Date;
        LinkedSalesDocNo: Code[20];
        LinkedSalesOrderNo: Code[20];
        SalesHeader2: Record "Sales Header";
        SalesHeader3: Record "Sales Header";
        SalesHeaderArchive: Record "Sales Header Archive";
        LinkedSOExists: Boolean;
        MaxOrderDiffAmt: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        Currency: Record Currency;
        APIInterfaceLogTest: Record "API Interface Log2 INT";
    begin
        APIInterfaceLog2.CALCFIELDS("Request File");
        APIInterfaceLog2."Request File".CREATEINSTREAM(RequestInStream);

        // BC Upgrade VAMSIU01 >>
        // RequestXmlDocument := RequestXmlDocument.XmlDocument;
        // RequestXmlDocument.Load(RequestInStream);
        //RequestXmlDocument := XmlDocument.Create(RequestInStream); // BC Upgrade SHUKLP03 <<
        RequestXmlDocument := XmlDocument.Create(); // BC Upgrade SHUKLP03 <<
        XmlDocument.ReadFrom(RequestInStream, RequestXmlDocument);
        // BC Upgrade VAMSIU01 <<

        APIInterfaceLog2.TESTFIELD("Source System Identifier");
        SourceSystemIdentifierAPI.GET(APIInterfaceLog2."Source System Identifier");

        // BC Upgrade VAMSIU01 >>
        // OrderXmlNode := RequestXmlDocument.SelectSingleNode('/msg/payload/order');
        // if ISNULL(OrderXmlNode) then
        //   ERROR(MissingNodeErr, 'order');
        if not RequestXmlDocument.SelectSingleNode('/msg/payload/order', OrderXmlNode) then
            ERROR(MissingNodeErr, 'order');
        // BC Upgrade VAMSIU01 <<

        TSalesHeader.SetHideValidationDialog(true);
        //TSalesHeader.SetHasBeenShown(); // BC Upgrade VAMSIU01
        TSalesHeader.INIT;
        TSalesHeader.SETAUTOCALCFIELDS(); //HEI.03

        // BC Upgrade VAMSIU01 >>
        // TempXmlNode := OrderXmlNode.SelectSingleNode('documentType');
        // if not ISNULL(TempXmlNode) then begin
        //   if TempXmlNode.InnerText <> '' then begin
        //     if not EVALUATE(TempDocumentType,TempXmlNode.InnerText) then
        //       ERROR(BadNodeValueErr,'documentType');
        //     TSalesHeader."Document Type" := TempDocumentType;
        //   end else begin
        //     TSalesHeader."Document Type" := TSalesHeader."Document Type"::Order;
        //   end;
        // end else begin
        //   TSalesHeader."Document Type" := TSalesHeader."Document Type"::Order;
        // end;
        if OrderXmlNode.SelectSingleNode('documentType', TempXmlNode) then begin
            if TempXmlNode.AsXmlElement().InnerText() <> '' then begin
                if not EVALUATE(TempDocumentType, TempXmlNode.AsXmlElement().InnerText()) then
                    ERROR(BadNodeValueErr, 'documentType');
                TSalesHeader."Document Type" := TempDocumentType;
            end else begin
                TSalesHeader."Document Type" := TSalesHeader."Document Type"::Order;
            end;
        end else begin
            TSalesHeader."Document Type" := TSalesHeader."Document Type"::Order;
        end;

        // BC Upgrade VAMSIU01 <<

        APIInterfaceSetup2.GET;
        APIInterfaceSetup2.TESTFIELD("Default Document Subtype Code");
        TSalesHeader.VALIDATE("Document Subtype Code FND", APIInterfaceSetup2."Default Document Subtype Code");  // BC Upgrade SHUKLP03 << 

        // Update fields on API Log
        // BC Upgrade VAMSIU01 >>
        // TempXmlNode := OrderXmlNode.SelectSingleNode('id');
        //   if not ISNULL(TempXmlNode) then
        //     if TempXmlNode.InnerText <> '' then
        //       APIInterfaceLog2."Order ID" := TempXmlNode.InnerText;
        if OrderXmlNode.SelectSingleNode('id', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                APIInterfaceLog2."Order ID" := TempXmlNode.AsXmlElement().InnerText();
        // BC Upgrade VAMSIU01 <<
        GetNodeByXPath('documentNo', 'documentNo', OrderXmlNode, TempXmlNode);

        // Update fields on API Log
        APIInterfaceLog2."Source Type" := DATABASE::"Sales Header";
        APIInterfaceLog2."Source Subtype" := TSalesHeader."Document Type".AsInteger();
        if not SourceSystemIdentifierAPI."Use Default S. Order Nos" then
            //APIInterfaceLog2."Source No.":= TempXmlNode.InnerText;  // BC Upgrade VAMSIU01
            APIInterfaceLog2."Source No." := TempXmlNode.AsXmlElement().InnerText();  // BC Upgrade VAMSIU01
        APIInterfaceLog2.MODIFY;
        COMMIT; // NOTE: NO DB WRITE BEFORE THIS COMMIT, EXCEPT ON API INTERFACE LOG

        if SourceSystemIdentifierAPI."Use Default S. Order Nos" then begin
            // Duplicate Validation based on External Document No.
            CreatedSalesHeader.SETAUTOCALCFIELDS(); //HEI.03
            CreatedSalesHeader.SETRANGE("Document Type", TSalesHeader."Document Type");
            //CreatedSalesHeader.SETRANGE("External Document No.",TempXmlNode.InnerText); // BC Upgrade VAMSIU01
            CreatedSalesHeader.SETRANGE("External Document No.", TempXmlNode.AsXmlElement().InnerText()); // BC Upgrade VAMSIU01
            if not CreatedSalesHeader.ISEMPTY then
                //ERROR(ReturnOrderAlreadyExistsErr,TSalesHeader."Document Type",TempXmlNode.InnerText); // BC Upgrade VAMSIU01
                ERROR(ReturnOrderAlreadyExistsErr, TSalesHeader."Document Type", TempXmlNode.AsXmlElement().InnerText()); // BC Upgrade VAMSIU01

            if TSalesHeader."Document Type" = TSalesHeader."Document Type"::Order then begin
                PostedShipment.SETAUTOCALCFIELDS(); //HEI.03
                //PostedShipment.SETRANGE("External Document No.", TempXmlNode.InnerText); // BC Upgrade VAMSIU01
                PostedShipment.SETRANGE("External Document No.", TempXmlNode.AsXmlElement().InnerText()); // BC Upgrade VAMSIU01
                if not PostedShipment.ISEMPTY then
                    //ERROR(ShipmentAlreadyExists2Err, TempXmlNode.InnerText); // BC Upgrade VAMSIU01
                    ERROR(ShipmentAlreadyExists2Err, TempXmlNode.AsXmlElement().InnerText()); // BC Upgrade VAMSIU01
            end else if TSalesHeader."Document Type" = TSalesHeader."Document Type"::"Return Order" then begin
                PostedReceipt.SETAUTOCALCFIELDS();  //HEI.03
                //PostedReceipt.SETRANGE("External Document No.", TempXmlNode.InnerText); // BC Upgrade VAMSIU01
                PostedReceipt.SETRANGE("External Document No.", TempXmlNode.AsXmlElement().InnerText()); // BC Upgrade VAMSIU01
                if not PostedReceipt.ISEMPTY then
                    //ERROR(ReceiptAlreadyExists2Err, TempXmlNode.InnerText); // BC Upgrade VAMSIU01
                    ERROR(ReceiptAlreadyExists2Err, TempXmlNode.AsXmlElement().InnerText()); // BC Upgrade VAMSIU01
            end;
        end else begin
            // Duplicate Validation
            CreatedSalesHeader.SETAUTOCALCFIELDS(); //HEI.03
            CreatedSalesHeader.SETRANGE("Document Type", TSalesHeader."Document Type");
            //CreatedSalesHeader.SETRANGE("No.", TempXmlNode.InnerText); // BC Upgrade VAMSIU01
            CreatedSalesHeader.SETRANGE("No.", TempXmlNode.AsXmlElement().InnerText()); // BC Upgrade VAMSIU01
            if not CreatedSalesHeader.ISEMPTY then
                //ERROR(ReturnOrderAlreadyExistsErr, TSalesHeader."Document Type", TempXmlNode.InnerText); // BC Upgrade VAMSIU01
                ERROR(ReturnOrderAlreadyExistsErr, TSalesHeader."Document Type", TempXmlNode.AsXmlElement().InnerText()); // BC Upgrade VAMSIU01

            if TSalesHeader."Document Type" = TSalesHeader."Document Type"::Order then begin
                PostedShipment.SETAUTOCALCFIELDS(); //HEI.03
                //PostedShipment.SETRANGE("Order No.", TempXmlNode.InnerText); // BC Upgrade VAMSIU01
                PostedShipment.SETRANGE("Order No.", TempXmlNode.AsXmlElement().InnerText()); // BC Upgrade VAMSIU01
                if not PostedShipment.ISEMPTY then
                    //ERROR(ShipmentAlreadyExistsErr, TempXmlNode.InnerText); // BC Upgrade VAMSIU01
                    ERROR(ShipmentAlreadyExistsErr, TempXmlNode.AsXmlElement().InnerText()); // BC Upgrade VAMSIU01
            end else if TSalesHeader."Document Type" = TSalesHeader."Document Type"::"Return Order" then begin
                PostedReceipt.SETAUTOCALCFIELDS();  //HEI.03
                //PostedReceipt.SETRANGE("Return Order No.", TempXmlNode.InnerText); // BC Upgrade VAMSIU01
                PostedReceipt.SETRANGE("Return Order No.", TempXmlNode.AsXmlElement().InnerText()); // BC Upgrade VAMSIU01
                if not PostedReceipt.ISEMPTY then
                    //ERROR(ReceiptAlreadyExistsErr, TempXmlNode.InnerText); // BC Upgrade VAMSIU01
                    ERROR(ReceiptAlreadyExistsErr, TempXmlNode.AsXmlElement().InnerText()); // BC Upgrade VAMSIU01
            end;
        end;

        if not SourceSystemIdentifierAPI."Use Default S. Order Nos" then begin
            // BC Upgrade VAMSIU01 >>
            //     if TempXmlNode.InnerText <> '' then
            //         TSalesHeader.VALIDATE("No.", TempXmlNode.InnerText);
            // end else
            //     TSalesHeader.VALIDATE("External Document No.", TempXmlNode.InnerText);
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                TSalesHeader.Validate("No.", TempXmlNode.AsXmlElement().InnerText());
        end else
            TSalesHeader.VALIDATE("External Document No.", TempXmlNode.AsXmlElement().InnerText());
        // BC Upgrade VAMSIU01 <<

        if TSalesHeader."No." = '' then
            TSalesHeader."No." := '#TEMP#';

        // Check duplicate SRO based on Linked Sales Document No.
        // BC Upgrade VAMSIU01 >>
        // TempXmlNode := OrderXmlNode.SelectSingleNode('LinkedSalesDocNo');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then
        //     LinkedSalesDocNo := TempXmlNode.InnerText;
        if OrderXmlNode.SelectSingleNode('LinkedSalesDocNo', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                LinkedSalesDocNo := TempXmlNode.AsXmlElement().InnerText();
        // BC Upgrade VAMSIU01 <<

        if (TSalesHeader."Document Type" = TSalesHeader."Document Type"::"Return Order") and
           (LinkedSalesDocNo <> '')
        then begin
            //Duplicate check
            SalesHeader3.RESET;
            SalesHeader3.SETAUTOCALCFIELDS(); //HEI.03
            SalesHeader3.SETRANGE("Document Type", SalesHeader3."Document Type"::"Return Order");
            SalesHeader3.SETRANGE("No.", LinkedSalesDocNo); // BC Upgrade VAMSIU01 - Blocked as Drinkit dependent field - Link Sales Document No.
            if SalesHeader3.FINDFIRST then
                ERROR(ReturnOrderLinkedSoExistsErr, SalesHeader3."No.", LinkedSalesDocNo);

            //Check if SO exists
            SalesHeader2.SETAUTOCALCFIELDS(); //HEI.03
            SalesHeader2.SETRANGE("Document Type", SalesHeader2."Document Type"::Order);
            SalesHeader2.SETRANGE("No.", LinkedSalesDocNo);
            SalesHeaderArchive.SETAUTOCALCFIELDS(); //HEI.03
            SalesHeaderArchive.SETRANGE("Document Type", SalesHeaderArchive."Document Type"::Order);
            SalesHeaderArchive.SETRANGE("No.", LinkedSalesDocNo);
            if SalesHeader2.FINDFIRST or SalesHeaderArchive.FINDFIRST then begin
                if SourceSystemIdentifierAPI."Use Default S. Order Nos" then
                    TSalesHeader.VALIDATE("No.", LinkedSalesDocNo);
                LinkedSOExists := true;
                LinkedSalesOrderNo := LinkedSalesDocNo;
            end else begin
                SalesHeader2.SETRANGE("No.");
                SalesHeader2.SETRANGE("External Document No.", LinkedSalesDocNo);
                SalesHeaderArchive.SETRANGE("No.");
                SalesHeaderArchive.SETRANGE("External Document No.", LinkedSalesDocNo);
                if SalesHeader2.FINDFIRST or SalesHeaderArchive.FINDFIRST then begin
                    if SourceSystemIdentifierAPI."Use Default S. Order Nos" then
                        if SalesHeader2."No." <> '' then
                            TSalesHeader.VALIDATE("No.", SalesHeader2."No.")
                        else if SalesHeaderArchive."No." <> '' then
                            TSalesHeader.VALIDATE("No.", SalesHeaderArchive."No.");
                    LinkedSOExists := true;
                    LinkedSalesOrderNo := TSalesHeader."No.";
                end;
            end;

            //HEI.02
        end;

        TSalesHeader.INSERT(false);

        if SourceSystemIdentifierAPI."Use Default S. Order Nos" then begin
            APIInterfaceLog2."Source No." := TSalesHeader."No.";
            APIInterfaceLog2.MODIFY;
        end;

        if (TSalesHeader."Document Type" = TSalesHeader."Document Type"::"Return Order") and
           (LinkedSalesDocNo <> '') and LinkedSOExists
        then begin
            // BC Upgrade VAMSIU01 - Blocked as Drinkit dependent field - Link Sales Document Type and No.
            //   TSalesHeader.VALIDATE("Link Sales Document Type",TSalesHeader."Link Sales Document Type"::Order);
            //   TSalesHeader."Link Sales Document No." := LinkedSalesOrderNo;
            // BC Upgrade VAMSIU01 - Blocked as Drinkit dependent field - Link Sales Document Type and No.
        end;

        GetNodeByXPath('customerId', 'customerId', OrderXmlNode, TempXmlNode);
        // BC Upgrade VAMSIU01 >>
        // TSalesHeader.VALIDATE("Sell-to Customer No.",TempXmlNode.InnerText);  // Block validation 
        TSalesHeader.VALIDATE("Sell-to Customer No.", TempXmlNode.AsXmlElement().InnerText());
        // BC Upgrade VAMSIU01 <<
        GetNodeByXPath('orderDate', 'orderDate', OrderXmlNode, TempXmlNode);
        // BC Upgrade VAMSIU01 >>
        // if not EVALUATE(TempDate,TempXmlNode.InnerText,9) then
        if not EVALUATE(TempDate, TempXmlNode.AsXmlElement().InnerText(), 9) then
            // BC Upgrade VAMSIU01 <<
            ERROR(BadNodeValueErr, 'orderDate');
        OrderDate := TempDate;
        TSalesHeader.VALIDATE("Order Date", TempDate);
        TSalesHeader.VALIDATE("Posting Date", TempDate);
        TSalesHeader.VALIDATE("Document Date", TempDate);

        // BC Upgrade VAMSIU01 >>
        // TempXmlNode := OrderXmlNode.SelectSingleNode('currencyCode');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then
        //     TSalesHeader.VALIDATE("Currency Code",TempXmlNode.InnerText);

        // TempXmlNode := OrderXmlNode.SelectSingleNode('paymentTerms');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then
        //     TSalesHeader.VALIDATE("Payment Terms Code",TempXmlNode.InnerText);

        // TempXmlNode := OrderXmlNode.SelectSingleNode('salesperson');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then
        //     TSalesHeader.VALIDATE("Salesperson Code",TempXmlNode.InnerText);

        // TempXmlNode := OrderXmlNode.SelectSingleNode('locationCode');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then
        //     TSalesHeader.VALIDATE("Location Code",TempXmlNode.InnerText);

        if OrderXmlNode.SelectSingleNode('currencyCode', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                TSalesHeader.VALIDATE("Currency Code", TempXmlNode.AsXmlElement().InnerText());

        if OrderXmlNode.SelectSingleNode('paymentTerms', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                TSalesHeader.VALIDATE("Payment Terms Code", TempXmlNode.AsXmlElement().InnerText());

        if OrderXmlNode.SelectSingleNode('salesperson', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                TSalesHeader.VALIDATE("Salesperson Code", TempXmlNode.AsXmlElement().InnerText());

        if OrderXmlNode.SelectSingleNode('locationCode', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                TSalesHeader.VALIDATE("Location Code", TempXmlNode.AsXmlElement().InnerText());
        // BC Upgrade VAMSIU01 >>

        // BC Upgrade SHUKLP03 - Blocked as Drinkit dependent table is used i.e Route >>
        if SourceSystemIdentifierAPI."Automatic SO Posting" then
            if TSalesHeader."Route 107FDW" <> '' then begin
                Route.GET(TSalesHeader."Route 107FDW");
                if Route."Shipping Location" <> TempXmlNode.AsXmlElement().InnerText() then begin // Replaced location code field by shipping location field from route table as part of drinkit changes
                    TSalesHeader.VALIDATE("Route 107FDW", '');
                    TSalesHeader.VALIDATE("Location Code", TempXmlNode.AsXmlElement().InnerText());
                end;
            end;
        // BC Upgrade SHUKLP03 - Blocked as Drinkit dependent table is used i.e Route <<

        // BC Upgrade VAMSIU01 >>
        // TempXmlNode := OrderXmlNode.SelectSingleNode('requestedDeliveryDate');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then begin
        //     if not EVALUATE(TempDate,TempXmlNode.InnerText, 9) then
        //       ERROR(BadNodeValueErr,'requestedDeliveryDate');
        //     if TempDate < WORKDATE then  // past date validation
        //       ERROR(PastDateErr,'requestedDeliveryDate');
        //     TSalesHeader.VALIDATE("Requested Delivery Date",TempDate);
        //   end;
        if OrderXmlNode.SelectSingleNode('requestedDeliveryDate', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then begin
                if not EVALUATE(TempDate, TempXmlNode.AsXmlElement().InnerText(), 9) then
                    ERROR(BadNodeValueErr, 'requestedDeliveryDate');
                if TempDate < WORKDATE then  // past date validation
                    ERROR(PastDateErr, 'requestedDeliveryDate');
                TSalesHeader.VALIDATE("Requested Delivery Date", TempDate);
            end;
        //BC Upgrade VAMSIU01 <<

        // BC Upgrade VAMSIU01 >>
        // TempXmlNode := OrderXmlNode.SelectSingleNode('promisedDeliveryDate');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then begin
        //     if not EVALUATE(TempDate,TempXmlNode.InnerText,9) then
        //       ERROR(BadNodeValueErr,'promisedDeliveryDate');
        //     if TempDate < WORKDATE then  // past date validation
        //       ERROR(PastDateErr,'promisedDeliveryDate');
        //     TSalesHeader.VALIDATE("Promised Delivery Date",TempDate);
        //   end;
        if OrderXmlNode.SelectSingleNode('promisedDeliveryDate', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then begin

                if not Evaluate(TempDate,
                    TempXmlNode.AsXmlElement().InnerText(), 9) then
                    Error(BadNodeValueErr, 'promisedDeliveryDate');

                // Past date validation
                if TempDate < WorkDate() then
                    Error(PastDateErr, 'promisedDeliveryDate');

                TSalesHeader.Validate("Promised Delivery Date", TempDate);
            end;
        // BC Upgrade VAMSIU01 <<

        // BC Upgrade VAMSIU01 >>
        // TempXmlNode := OrderXmlNode.SelectSingleNode('externalDocNo');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then
        //     TSalesHeader."External Document No." := TempXmlNode.InnerText;

        // TempXmlNode := OrderXmlNode.SelectSingleNode('paymentMethod');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then
        //     TSalesHeader.VALIDATE("Payment Method Code", TempXmlNode.InnerText);

        // TempXmlNode := OrderXmlNode.SelectSingleNode('shipmentMethod');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then
        //     TSalesHeader.VALIDATE("Shipment Method Code",TempXmlNode.InnerText);

        // TempXmlNode := OrderXmlNode.SelectSingleNode('totalAmountIncludingVAT');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then begin
        //     if not EVALUATE(TempDecimal,TempXmlNode.InnerText,9) then
        //       ERROR(BadNodeValueErr,'totalAmountIncludingVAT');
        //     TSalesHeader."Doc. Amount Incl. VAT" := TempDecimal;
        //   end;

        // TempXmlNode := OrderXmlNode.SelectSingleNode('totalVatAmount');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then begin
        //     if not EVALUATE(TempDecimal,TempXmlNode.InnerText,9) then
        //       ERROR(BadNodeValueErr,'totalVatAmount');
        //     TSalesHeader."Doc. Amount VAT" := TempDecimal;
        //   end;
        if OrderXmlNode.SelectSingleNode('externalDocNo', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                TSalesHeader."External Document No." := TempXmlNode.AsXmlElement().InnerText();

        if OrderXmlNode.SelectSingleNode('paymentMethod', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                TSalesHeader.VALIDATE("Payment Method Code", TempXmlNode.AsXmlElement().InnerText());

        if OrderXmlNode.SelectSingleNode('shipmentMethod', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                TSalesHeader.VALIDATE("Shipment Method Code", TempXmlNode.AsXmlElement().InnerText());

        if OrderXmlNode.SelectSingleNode('totalAmountIncludingVAT', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then begin
                if not EVALUATE(TempDecimal, TempXmlNode.AsXmlElement().InnerText(), 9) then
                    ERROR(BadNodeValueErr, 'totalAmountIncludingVAT');
                TSalesHeader."Doc. Amount Incl. VAT FND" := TempDecimal;
            end;

        if OrderXmlNode.SelectSingleNode('totalVatAmount', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then begin
                if not EVALUATE(TempDecimal, TempXmlNode.AsXmlElement().InnerText(), 9) then
                    ERROR(BadNodeValueErr, 'totalVatAmount');
                TSalesHeader."Doc. Amount VAT FND" := TempDecimal;
            end;
        // BC Upgrade VAMSIU01 <<

        //Update CCC Dimension from Counterpoint Location Mapping
        if SourceSystemIdentifierAPI."Use Location - Dim Mapping" then begin
            CLEAR(TempDimensionSetEntry);
            DimensionManagement.GetDimensionSet(TempDimensionSetEntry, TSalesHeader."Dimension Set ID");
            GetDimensionLocationMapping(TSalesHeader."Location Code");
            TempDimensionSetEntry.SETRANGE("Dimension Code", CCCDimensionCode);
            if TempDimensionSetEntry.FINDFIRST and (TempDimensionSetEntry."Dimension Value Code" <> CCCDimensionValue) then
                TempDimensionSetEntry.DELETE;
            if (CCCDimensionCode <> '') or (CCCDimensionValue <> '') then begin
                TempDimensionSetEntry.INIT;
                TempDimensionSetEntry.VALIDATE("Dimension Code", CCCDimensionCode);
                TempDimensionSetEntry.VALIDATE("Dimension Value Code", CCCDimensionValue);
                if TempDimensionSetEntry.INSERT(true) then;
            end;
            // TSalesHeader.VALIDATE("Dimension Set ID",DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
            TSalesHeader."Dimension Set ID" := DimensionManagement.GetDimensionSetID(TempDimensionSetEntry);
        end;
        //BC Upgrade VAMSIU01 >>
        // TempXmlNode := OrderXmlNode.SelectSingleNode('PaymentDocumentNo');
        // if not ISNULL(TempXmlNode) then
        //     if TempXmlNode.InnerText <> '' then begin
        if OrderXmlNode.SelectSingleNode('PaymentDocumentNo', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then begin
                //BC Upgrade VAMSIU01 <<
                //HEI.03>>
                //    TSalesHeader.VALIDATE("Applies-to Doc. Type",TSalesHeader."Applies-to Doc. Type"::Payment);
                //    TSalesHeader.VALIDATE("Applies-to Doc. No.",TempXmlNode.InnerText);
                TSalesHeader."Applies-to Doc. Type" := TSalesHeader."Applies-to Doc. Type"::Payment;
                //BC Upgrade VAMSIU01 >>
                //TSalesHeader."Applies-to Doc. No.":=TempXmlNode.InnerText;
                TSalesHeader."Applies-to Doc. No." := TempXmlNode.AsXmlElement().InnerText();
                //BC Upgrade VAMSIU01 <<
                //HEI.03<<
            end;

        TSalesHeader.MODIFY(false);


        if TSalesHeader."Currency Code" <> '' then
            Currency.GET(TSalesHeader."Currency Code")
        else
            Currency.InitRoundingPrecision();

        // BC Upgrade VAMSIU01 >>
        // LinesXmlNodeList := OrderXmlNode.SelectNodes('lines/line');
        // if ISNULL(LinesXmlNodeList) then
        //   ERROR(MissingNodeErr,'line');
        if not OrderXmlNode.SelectNodes('lines/line', LinesXmlNodeList) then
            if LinesXmlNodeList.Count() = 0 then
                ERROR(MissingNodeErr, 'line');
        // BC Upgrade VAMSIU01 <<

        foreach LineXmlNode in LinesXmlNodeList do begin
            IsGift := false;
            // BC Upgrade VAMSIU01 <<
            //   TempXmlNode := LineXmlNode.SelectSingleNode('isGift');
            //   if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //       if not EVALUATE(IsGift,TempXmlNode.InnerText,9) then
            //         ERROR(BadNodeValueErr,'isGift');
            //   if SourceSystemIdentifierAPI."Apply Sales Condit Interface" or not IsGift then begin
            //     TempXmlNode := LineXmlNode.SelectSingleNode('sequence');
            //     if not ISNULL(TempXmlNode) then begin
            //       if TempXmlNode.InnerText <> '' then begin
            //         if not EVALUATE(Sequence,TempXmlNode.InnerText) then
            //           ERROR(BadNodeValueErr,'sequence');
            //         SequenceFound := true;
            //       end else begin
            //         SequenceFound := false;
            //       end;
            //     end else begin
            //       SequenceFound := false;
            //     end;
            if LineXmlNode.SelectSingleNode('isGift', TempXmlNode) then
                if TempXmlNode.AsXmlElement().InnerText() <> '' then
                    if not EVALUATE(IsGift, TempXmlNode.AsXmlElement().InnerText(), 9) then
                        ERROR(BadNodeValueErr, 'isGift');
            if SourceSystemIdentifierAPI."Apply Sales Condit Interface" or not IsGift then begin
                if LineXmlNode.SelectSingleNode('sequence', TempXmlNode) then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then begin
                        if EVALUATE(Sequence, TempXmlNode.AsXmlElement().InnerText()) then
                            ERROR(BadNodeValueErr, 'sequence');
                        SequenceFound := true;
                    end else begin
                        SequenceFound := false
                    end;
            end else begin
                SequenceFound := false;
            end;
            // BC Upgrade VAMSIU01 <<

            if not SequenceFound then begin
                if Sequence = 0 then begin
                    // LastSalesLine.SETRANGE("Document Type",TSalesHeader."Document Type");
                    // LastSalesLine.SETRANGE("Document No.",TSalesHeader."No.");
                    // IF LastSalesLine.FINDLAST THEN
                    //   Sequence := LastSalesLine."Line No."
                end;
                Sequence += 10000;
            end;

            //HEI.03>>
            TSalesLine[1].SETAUTOCALCFIELDS();
            TSalesLine[2].SETAUTOCALCFIELDS();
            //HEI.03<<
            TSalesLine[1].SetSalesHeader(TSalesHeader);
            TSalesLine[1].SetHideValidationDialog(true);
            TSalesLine[1].SetHasBeenShown();
            //TSalesLine[1].SetBatchInsertCheck(true); // BC Upgrade VAMSIU01 - Blocked
            TSalesLine[1].INIT;
            TSalesLine[1]."Document Type" := TSalesHeader."Document Type";
            TSalesLine[1]."Document No." := TSalesHeader."No.";
            TSalesLine[1]."Line No." := Sequence;
            TSalesLine[1].INSERT(false);

            // BC Upgrade VAMSIU01 >>
            //     TempXmlNode := LineXmlNode.SelectSingleNode('lineType');
            //     if not ISNULL(TempXmlNode) then begin
            //       if TempXmlNode.InnerText <> '' then begin
            //         if not EVALUATE(TempType,TempXmlNode.InnerText) then
            //           ERROR(BadNodeValueErr,'lineType');
            //         TSalesLine[1].Type := TempType;
            //       end else begin
            //         TSalesLine[1].Type := TSalesLine[1].Type::Item;
            //       end;
            //     end else begin
            //       TSalesLine[1].Type := TSalesLine[1].Type::Item;
            //     end;
            if LineXmlNode.SelectSingleNode('lineType', TempXmlNode) then begin
                if TempXmlNode.AsXmlElement().InnerText() <> '' then begin
                    if not EVALUATE(TempType, TempXmlNode.AsXmlElement().InnerText()) then
                        ERROR(BadNodeValueErr, 'lineType');
                    TSalesLine[1].Type := TempType;
                end else begin
                    TSalesLine[1].Type := TSalesLine[1].Type::Item;
                end;
            end else begin
                TSalesLine[1].Type := TSalesLine[1].Type::Item;
            end;
            // BC Upgrade VAMSIU01 <<

            GetNodeByXPath('itemId', 'itemId', LineXmlNode, TempXmlNode);  // Block validation

            // BC Upgrade VAMSIU01 <<
            // TSalesLine[1].VALIDATE("No.",TempXmlNode.InnerText);
            TSalesLine[1].VALIDATE("No.", TempXmlNode.AsXmlElement().InnerText());
            // BC Upgrade VAMSIU01 <<

            // BC Upgrade VAMSIU01 >>
            //     TempXmlNode := LineXmlNode.SelectSingleNode('unitOfMeasure');
            //     if not ISNULL(TempXmlNode) then
            //       if TempXmlNode.InnerText <> '' then
            //         TSalesLine[1].VALIDATE("Unit of Measure Code",TempXmlNode.InnerText);

            //     GetNodeByXPath('quantity','quantity',LineXmlNode,TempXmlNode);
            //     if not EVALUATE(TempDecimal,TempXmlNode.InnerText,9) then
            //       ERROR(BadNodeValueErr,'quantity');
            //     TSalesLine[1].VALIDATE(Quantity, TempDecimal);

            //     if TSalesHeader."Document Type" = TSalesHeader."Document Type"::"Return Order" then begin
            //       TempXmlNode := LineXmlNode.SelectSingleNode('returnReasonCode');
            //       if not ISNULL(TempXmlNode) then
            //         if TempXmlNode.InnerText <> '' then
            //           TSalesLine[1].VALIDATE("Return Reason Code",TempXmlNode.InnerText);
            //     end;
            if LineXmlNode.SelectSingleNode('unitOfMeasure', TempXmlNode) then
                if TempXmlNode.AsXmlElement().InnerText() <> '' then
                    TSalesLine[1].VALIDATE("Unit of Measure Code", TempXmlNode.AsXmlElement().InnerText());

            GetNodeByXPath('quantity', 'quantity', LineXmlNode, TempXmlNode);
            if not EVALUATE(TempDecimal, TempXmlNode.AsXmlElement().InnerText(), 9) then
                ERROR(BadNodeValueErr, 'quantity');
            TSalesLine[1].VALIDATE(Quantity, TempDecimal);
        end;

        if TSalesHeader."Document Type" = TSalesHeader."Document Type"::"Return Order" then begin
            if LineXmlNode.SelectSingleNode('returnReasonCode', TempXmlNode) then
                if TempXmlNode.AsXmlElement().InnerText() <> '' then
                    TSalesLine[1].VALIDATE("Return Reason Code", TempXmlNode.AsXmlElement().InnerText());
        end;
        // BC Upgrade VAMSIU01 <<

        // BC Upgrade VAMSIU01 >>
        // TempXmlNode := LineXmlNode.SelectSingleNode('AttachedToLineNo');
        // if not ISNULL(TempXmlNode) then
        //     if TempXmlNode.InnerText <> '' then begin
        //         if not EVALUATE(TempAttachedToLineNo, TempXmlNode.InnerText) then
        if LineXmlNode.SelectSingleNode('AttachedToLineNo', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then begin
                if not EVALUATE(TempAttachedToLineNo, TempXmlNode.AsXmlElement().InnerText()) then
                    // BC Upgrade VAMSIU01 <<
                    ERROR(BadNodeValueErr, 'AttachedToLineNo');
                if TempAttachedToLineNo <> 0 then begin
                    TSalesLine[1].VALIDATE("Attached to Line No.", TempAttachedToLineNo);
                    TSalesLine[2].GET(TSalesLine[1]."Document Type", TSalesLine[1]."Document No.", TempAttachedToLineNo);

                    if TSalesLine[1].Type = TSalesLine[1].Type::"Charge (Item)" then begin
                        ItemCharge.GET(TSalesLine[1]."No.");
                        //BC Upgrade VAMSIU01 - Blocked as Drinkit dependent field
                        // if ItemCharge."Item Charge Type" = ItemCharge."Item Charge Type"::Discount then
                        //     TSalesLine[1].VALIDATE(Quantity, -ABS(TSalesLine[1].Quantity));
                        //BC Upgrade VAMSIU01 - Blocked as Drinkit dependent field
                        //Dimensions
                        TSalesLine[1]."Dimension Set ID" := TSalesLine[2]."Dimension Set ID";
                        CLEAR(TempDimensionSetEntry);
                        DimensionManagement.GetDimensionSet(TempDimensionSetEntry, TSalesLine[1]."Dimension Set ID");
                        DefaultDimension.SETRANGE("Table ID", DATABASE::"Item Charge");
                        DefaultDimension.SETRANGE("No.", TSalesLine[1]."No.");
                        //HEI.03>>
                        // IF DefaultDimension.FINDSET THEN
                        if DefaultDimension.FindSet(false) then
                            //HEI.03<<
                            repeat
                                TempDimensionSetEntry.INIT;
                                TempDimensionSetEntry."Dimension Code" := DefaultDimension."Dimension Code";
                                TempDimensionSetEntry."Dimension Value Code" := DefaultDimension."Dimension Value Code";
                                if TempDimensionSetEntry.INSERT(true) then;
                            until DefaultDimension.NEXT = 0;
                        // TSalesLine[1].VALIDATE("Dimension Set ID",DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                        TSalesLine[1]."Dimension Set ID" := DimensionManagement.GetDimensionSetID(TempDimensionSetEntry);

                        //Insert Item Charge Assignment Sales
                        // n.a.

                    end else
                        if IsGift then begin
                            // n.a.
                        end;
                end;
            end;

        if SourceSystemIdentifierAPI."Apply Sales Condit Interface" then begin
            //BC upgrade VAMSIU01 >>
            // TempXmlNode := LineXmlNode.SelectSingleNode('VATPercentage');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then begin
            //         if not EVALUATE(TempVATPerc, TempXmlNode.InnerText, 9) then
            if LineXmlNode.SelectSingleNode('VATPercentage', TempXmlNode) then
                if TempXmlNode.AsXmlElement().InnerText() <> '' then begin
                    if not EVALUATE(TempVATPerc, TempXmlNode.AsXmlElement().InnerText(), 9) then
                        //BC upgrade VAMSIU01 <<
                        ERROR(BadNodeValueErr, 'VATPercentage');
                    TSalesLine[1].VALIDATE("VAT %", TempVATPerc);
                    VATPostingSetup.RESET;
                    VATPostingSetup.SETRANGE("VAT %", TempVATPerc);
                    VATPostingSetup.SETRANGE("VAT Bus. Posting Group", TSalesLine[1]."VAT Bus. Posting Group");
                    if VATPostingSetup.FINDFIRST then
                        TSalesLine[1]."VAT Identifier" := VATPostingSetup."VAT Identifier"
                    else
                        TSalesLine[1]."VAT Identifier" += '2';
                end;

            GetNodeByXPath('UnitPrice', 'UnitPrice', LineXmlNode, TempXmlNode);
            //BC upgrade VAMSIU01 >>
            //if not EVALUATE(TempUnitPrice, TempXmlNode.InnerText, 9) then 
            if not EVALUATE(TempUnitPrice, TempXmlNode.AsXmlElement().InnerText(), 9) then
                //BC upgrade VAMSIU01 <<
                ERROR(BadNodeValueErr, 'UnitPrice');
            TSalesLine[1]."Unit Price" := TempUnitPrice;
            //TSalesLine[1]."Item Charge Value" := TSalesLine[1]."Unit Price"; // BC Upgrade VAMSIU01 - Blocked as Drinkit dependent field. // BC Upgrade SHUKLO03 << Obsolete
            if IsGift then begin
                TSalesLine[1].Amount := 0;
                TSalesLine[1]."Amount Including VAT" := 0;
                TSalesLine[1].VALIDATE("Outstanding Amount", 0);
                TSalesLine[1]."VAT Base Amount" := 0;
                TSalesLine[1]."Line Amount" := 0;
                TSalesLine[1]."Line Discount Amount" := TSalesLine[1]."Unit Price" * TSalesLine[1].Quantity;
            end else begin
                TSalesLine[1].Amount := TSalesLine[1]."Unit Price" * TSalesLine[1].Quantity;
                TSalesLine[1]."Amount Including VAT" := TSalesLine[1].Amount + TSalesLine[1].Amount * (TSalesLine[1]."VAT %" / 100);
                TSalesLine[1].VALIDATE("Outstanding Amount", TSalesLine[1]."Amount Including VAT");
                TSalesLine[1]."VAT Base Amount" := TSalesLine[1].Amount;
                TSalesLine[1]."Line Amount" := TSalesLine[1].Amount;
            end;

            //     if (TSalesLine[1].Type = TSalesLine[1].Type::"Charge (Item)") and
            //         (TSalesLine[1]."Item Charge Type" = TSalesLine[1]."Item Charge Type"::Discount)
            //     then
            //         TSalesLine[1]."DDiscount Base Amount" := TSalesLine[1]."Unit Price";
        end;

        TSalesLine[1].MODIFY(false);



        if SourceSystemIdentifierAPI."Order Value Validation" then begin
            TSalesHeader.CALCFIELDS("Amount Including VAT");
            if (TSalesHeader."Doc. Amount Incl. VAT FND" <> 0) or (TSalesHeader."Amount Including VAT" <> 0) then begin
                MaxOrderDiffAmt := SourceSystemIdentifierAPI."Order Val. Tolerance Amt";
                if TSalesHeader."Currency Code" <> '' then
                    MaxOrderDiffAmt :=
                       CurrExchRate.ExchangeAmtLCYToFCY(TSalesHeader."Posting Date", TSalesHeader."Currency Code", SourceSystemIdentifierAPI."Order Val. Tolerance Amt", TSalesHeader."Currency Factor");
                //check from InsertDifferenceGLAccLine()
                if ROUND(ABS((TSalesHeader."Doc. Amount Incl. VAT FND" - TSalesHeader."Amount Including VAT")), Currency."Amount Rounding Precision") > 0 then
                    if ROUND(ABS((TSalesHeader."Doc. Amount Incl. VAT FND" - TSalesHeader."Amount Including VAT")), Currency."Amount Rounding Precision") > MaxOrderDiffAmt then
                        ERROR(AmountValidationFailedErr, TSalesHeader."No.", TSalesHeader."Source System Identifier FND");
            end;
        end;

        // Release / Approval
        if SourceSystemIdentifierAPI."Automatic SO Posting" then begin
            //Save lines before Release
            // n.a.

        end else
            if APIInterfaceSetup2."Automatic Release/SendApproval" then begin
                //IF NOT TSalesHeader.SalesLinesExist THEN
                TSalesLine[1].RESET;
                TSalesLine[1].SETRANGE("Document Type", TSalesHeader."Document Type");
                TSalesLine[1].SETRANGE("Document No.", TSalesHeader."No.");
                if TSalesLine[1].ISEMPTY then
                    ERROR(NothingToApproveErr);
                // n.a.
            end;

        if SourceSystemIdentifierAPI."Post Diff to G/L Account" then begin
            SourceSystemIdentifierAPI.TESTFIELD("G/L Difference Account");
            TSalesHeader.TESTFIELD(Status, TSalesHeader.Status::Released);
            InsertDifferenceGLAccLine(TSalesHeader, TSalesLine[1], SourceSystemIdentifierAPI."Order Val. Tolerance Amt", SourceSystemIdentifierAPI."G/L Difference Account");
            TSalesHeader.FIND;
            // n.a.
        end;

        if SourceSystemIdentifierAPI."Automatic SO Posting" then begin
            // n.a.
        end;

        //HEI.02>>
        //postpone process on SRO because SO not created yet
        if not LinkedSOExists then begin
            APIInterfaceLogTest.SETCURRENTKEY("Interface Code", "Source System Identifier", "Message ID");
            APIInterfaceLogTest.SETRANGE("Interface Code", APIInterfaceLog2."Interface Code");
            APIInterfaceLogTest.SETRANGE("Source System Identifier", APIInterfaceLog2."Source System Identifier");
            APIInterfaceLogTest.SETRANGE("Message ID", APIInterfaceLog2."Message ID");
            APIInterfaceLogTest.SETRANGE(Status, APIInterfaceLog2.Status::Error);
            if not APIInterfaceLogTest.ISEMPTY then
                ERROR(LastCodeStatusSkipErr);
        end;
        //HEI.02<<

        CLEAR(RequestXmlDocument);
        CLEAR(OrderXmlNode);
        CLEAR(TempXmlNode);
        CLEAR(LinesXmlNodeList);
        CLEAR(LineXmlNode);
        CLEAR(RequestInStream);
    end;

    //BC Upgrade VAMSIU01 - Blocked and added new with Saas compatible >>
    // local procedure GetNodeByXPath(XPath : Text;NodeName : Text;var ParentXmlNode : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";var XmlNode : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode");
    // begin
    //     XmlNode := ParentXmlNode.SelectSingleNode(XPath); // Mandatory
    //     if ISNULL(XmlNode) then
    //       ERROR(MissingNodeErr,NodeName);
    //     if XmlNode.InnerText = '' then
    //       ERROR(TextMissingErr,NodeName);
    // end;
    local procedure GetNodeByXPath(XPath: Text; NodeName: Text; var ParentXmlNode: XmlNode; var ResultXmlNode: XmlNode)
    begin

        if ParentXmlNode.SelectSingleNode(XPath, ResultXmlNode) then
            if not ResultXmlNode.IsXmlElement() then
                Error(MissingNodeErr, NodeName);

        if ResultXmlNode.AsXmlElement().InnerText() = '' then
            Error(TextMissingErr, NodeName);
    end;
    //BC Upgrade VAMSIU01 - Blocked and added new with Saas compatible >>

    local procedure InsertDifferenceGLAccLine(var TSalesHeader: Record "Sales Header" temporary; var TSalesLine: Record "Sales Line" temporary; MaxDiffAmount: Decimal; DiffGLAccount: Code[20]);
    var
        ReleaseSalesDocument: Codeunit "Release Sales Document";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        MaxOrderDiffAmtFCY: Decimal;
        DiffUnitPrice: Decimal;
        Error001: Label 'The Difference between the Doc. Amount Incl VAT %1 and Total Amount incl VAT %2 is bigger than the allowed limit %3!';
        Currency: Record Currency;
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        if TSalesHeader."Currency Code" <> '' then begin
            MaxOrderDiffAmtFCY :=
              CurrencyExchangeRate.ExchangeAmtLCYToFCY(TSalesHeader."Posting Date", TSalesHeader."Currency Code", MaxDiffAmount, TSalesHeader."Currency Factor");
        end else
            MaxOrderDiffAmtFCY := MaxDiffAmount;

        GeneralLedgerSetup.GET;
        if TSalesHeader."Currency Code" <> '' then
            Currency.GET(TSalesHeader."Currency Code")
        else
            Currency.GET(GeneralLedgerSetup."LCY Code");

        if (TSalesHeader."Doc. Amount Incl. VAT FND" <> 0) and (TSalesHeader."Doc. Amount VAT FND" <> 0) then begin
            TSalesHeader.CALCFIELDS("Amount Including VAT", Amount);
            if ROUND(ABS((TSalesHeader."Doc. Amount Incl. VAT FND" - TSalesHeader."Amount Including VAT")), Currency."Amount Rounding Precision") > 0 then
                if ROUND(ABS((TSalesHeader."Doc. Amount Incl. VAT FND" - TSalesHeader."Amount Including VAT")), Currency."Amount Rounding Precision") <= MaxOrderDiffAmtFCY then begin
                    TSalesLine.SETAUTOCALCFIELDS(); //HEI.03
                    TSalesLine.SetSalesHeader(TSalesHeader);
                    TSalesLine.INIT;
                    TSalesLine.VALIDATE("Document Type", TSalesHeader."Document Type");
                    TSalesLine.VALIDATE("Document No.", TSalesHeader."No.");
                    TSalesLine.VALIDATE("Line No.", 1);
                    TSalesLine.VALIDATE(Type, TSalesLine.Type::"G/L Account");
                    TSalesLine.VALIDATE("No.", DiffGLAccount);
                    TSalesLine.INSERT(false);
                end else
                    ERROR(AmountValidationFailedErr, TSalesHeader."No.", TSalesHeader."Source System Identifier FND");
        end;
    end;

    local procedure GetAditionalAmountExclAmt(AmountInclVAT: Decimal; VATBusPostGroup: Code[10]; DiffGLAccount: Code[20]): Decimal;
    var
        GLAccount: Record "G/L Account";
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        GLAccount.GET(DiffGLAccount);
        if VATPostingSetup.GET(VATBusPostGroup, GLAccount."VAT Prod. Posting Group") then
            exit(AmountInclVAT / (1 + (VATPostingSetup."VAT %" / 100)))
        else
            exit(AmountInclVAT);
    end;

    local procedure GetDimensionLocationMapping(LocationCode: Code[10]);
    var
        LocationMappingCP: Record "Location Mapping CP FND";
    begin
        CLEAR(CCCDimensionCode);
        CLEAR(CCCDimensionValue);

        LocationMappingCP.SETRANGE("Location Code", LocationCode);
        if LocationMappingCP.FINDFIRST then begin
            CCCDimensionCode := LocationMappingCP."CCC Dimension";
            CCCDimensionValue := LocationMappingCP."CCC Dimension Value";
        end;
    end;
}

