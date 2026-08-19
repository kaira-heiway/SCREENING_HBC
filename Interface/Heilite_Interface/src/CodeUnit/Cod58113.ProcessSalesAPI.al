codeunit 58113 "Process Sales API"
{
    // version HEI.24

    // HEI.01 CHG2065153 IBM KUMARN15 23.06.2020
    //   # New codeunit created
    // HEI.02 FDD-HT678 IBM NASTAA02 25.08.2020 # DMS / DDE Integration
    //   # Code added to check if 'Linked Sales Document No.' exists
    //   # Create SO and SRO based on Heilite No Series
    //   # New Publisher created "OnAfterCreateSalesDocument"
    // HEI.03 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
    //   # New tags added to the XML structure: "UnitPrice", "VATPercentage" and "AttachedToLineNo"
    //   # Updated code for Free Items
    //   # Update CCC Dimension based on setup
    // HEI.04 FDD-HB1234 - CHG2053453 IBM NASTAA02 15.02.2021 # B2B Order Status
    //   # Code added on function 'CreateSales' to update the 'Order ID' on API Interface Log
    //   # Code added on function 'CreateSalesReturnOrder' to updated 'External Document No.' based on setup
    // HEI.05 INC3683307 - CHG2124094 IBM NASTAA02 27.08.2021 # Problems with orders with free items
    //   # Free Items from B2B should be ignored in HL
    // HEI.07 INC3768359 - CHG2131572 IBM NASTAA02 15.10.2021 # Sales order processed via API for interface Code = LSR requires a review and amendment
    //   # Route should not update Location Code for LSR
    // HEI.08 INC3770544 - CHG2130622 IBM NASTAA02 15.10.2021 # API Entries are unable to be Reprocessed
    //   # Code added to trigger the Auto-Posting when 'Reprocess' is used
    // HEI.09 INC3770558 - CHG2131205 IBM NASTAA02 19.10.2021 # Payment Entries in API for LSR are in Error State due to date mis-match
    //   # Code addded to update Dates using the OrderDate from LSR
    // HEI.10 HB2300 - CHG2113543 IBM NASTAA02 12.11.2021 # DMS DRC
    //   # Code added to update "Link Sales Document No." on Sales Return Orders
    //   # New Text Constant created 'ReturnOrderLinkedSoExistsErr'
    //   # Updated existing Text Constant 'ReturnOrderAlreadyExistsErr'
    // HEI.11 HB2469 - CHG2122312 IBM NASTAA02 17.11.2021 # Payment API with B2B DOT Interface into HL
    //   # Added Field 'PaymentDocNo'
    // HEI.12 INC4083000 - CHG2156647 IBM NASTAA02 03.05.2022 # NAS Service consuming high memory
    //   # Clear variables after Webservice call
    // HEI.13 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables
    // HEI.15 CHG2188870 DEBUSD01 03.02.2023 Sales Order API Performance change flow
    // HEI.16 CHG2188870 DEBUSD01 08.02.2023 Sales Order API Performance change flow
    //   # Fix error if SO not created when exists "Link Sales Document No." on Return Orders (from CHG2113543)
    // HEI.17 CHG2184480 DEBUSD01 14.02.2023 Error Amount Outside Tolerance
    //   # Fix set negative sign for discount per order
    // HEI.19 CHG2193616 IBM BHANDS01 23.02.23 Sales Order API Optimization
    //   # Code optimization
    // HEI.20 CHG2194819 IBM MARTIR52 01.03.2023 #St Lucia - Virtro integration
    //   # Removed the validation on "past date" for delivery dates, as per difference on time zone sometimes the server identifies the date as past one while locally it is the current date.
    // HEI.18 CHG2167559 HB3063 IBM BHANDS01 21.02.2023 #La Reunion BASE - DMS integration
    //   # Added 2 new tags in the request XML structure "TruckCode" and "DriverCode"
    // HEI.21 CHG2174235 IBM COSTES04 15.06.2023 Interface Order Simulation
    //   # New functions CreateSalesSimulation
    // HEI.22 CHG2213548 IBM COSTES04 01.08.2023 HB3548- LSR Interfaced Sales Orders to Restrict HL Trade Promotions- Dev
    //   # Update SO amounts from xml request
    // HEI.23 CHG2223467 IBM COSTES04 26.02.2023 HB3598-Lareunion-Heilite BASE <> WMS Interface Modification for B2B Orders
    //   # Populate Type before inserting Sales Line for generating item charge assignment correctly
    // HEI.24 CHG2249320 IBM COSTES04 26.04.2024 API Return Orders Error
    //   # Populated qty. to assign on item charges assignment

    // BC Upgrade VAMSIU01 >>
    // # old nav ID - 50141
    // # Blocked Dotnet variables and new Saas Compatible variable in CreateSales,CreateSalesSimulation,CreateSalesReturnOrder procedures.
    // # Replaced TempXmlNode.InnerText with TempXmlNode.AsXmlElement().Innertext()
    // # Blocked some code as dependent on Drinkit tables, Code Units and fields.
    // BC Upgrade VAMSIU01 <<   

    // BC Upgrade PATELP08>>
    // Changed name of table from "B2B Item Charges Inc./Exc." to "B2B Item Charges Inc./Exc. FND"
    // BC Upgrade PATELP08<<

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
                                CreateSales;
                            end;
                        //HEI.21>>
                        'REQINFO':
                            CreateSalesSimulation;
                    //HEI.21<<
                    end;
                end;
        end;
        Rec := APIInterfaceLog2;
    end;

    var
        APIInterfaceLog2: Record "API Interface Log2 INT";
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
        ReturnOrderLinkedNotExistsErr: Label 'Linked Sales Order No. %1 does not exist.';
        PriceChanged: Boolean;

    local procedure CreateSales();
    var
        RequestInStream: InStream;
        // BC Upgrade VAMSIU01 >>
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
        RequestOutStream: OutStream;
        RequestXml: Codeunit "Temp Blob";
        // BC Upgrade VAMSIU01 <<
        APIInterfaceSetup2: Record "API Interface Setup2 INT";
        SalesHeader: Record "Sales Header";
        Comments: Text;
        SalesCommentLine: Record "Sales Comment Line";
        LastSalesCommentLine: Record "Sales Comment Line";
        CommentLineNo: Integer;
        Sequence: Integer;
        SequenceFound: Boolean;
        SalesLine: Record "Sales Line";
        LastSalesLine: Record "Sales Line";
        TempDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        TempDate: Date;
        TempType: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        TempDecimal: Decimal;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ReleaseSalesDocument: Codeunit "Release Sales Document";
        HNKBCU: CODEUNIT "Heineken BC Upgrade";
        CreatedSalesHeader: Record "Sales Header";
        PostedShipment: Record "Sales Shipment Header";
        PostedReceipt: Record "Return Receipt Header";
        IsGift: Boolean;
        ApiInterfaceSetupRec: Record "API Interface Setup2 INT";
        //DDEInterfaceMgmt : Codeunit "DDE Interface Mgmt.";
        CreatedSalesRetOrderNo: Code[20];
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        TempUnitPrice: Decimal;
        TempVATPerc: Decimal;
        TempAttachedToLineNo: Integer;
        SalesLine2: Record "Sales Line";
        ItemCharge: Record "Item Charge";
        ItemChargeAssignmentSales: Record "Item Charge Assignment (Sales)";
        VATPostingSetup: Record "VAT Posting Setup";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        DimensionManagement: Codeunit DimensionManagement;
        DefaultDimension: Record "Default Dimension";
        TempSalesLine: Record "Sales Line" temporary;
        SalesLine3: Record "Sales Line";
        SalesLine4: Record "Sales Line";
        Route: Record Route107FDW; //BC Upgrade SHUKLP03 - Drinkit Dependent table(2014072 -Route)
        OrderDate: Date;
        LinkedSalesDocNo: Code[20];
        LinkedSalesOrderNo: Code[20];
        SalesHeader2: Record "Sales Header";
        SalesHeader3: Record "Sales Header";
        SalesHeaderArchive: Record "Sales Header Archive";
        LinkedSOExists: Boolean;
        LastSalesLineItem: Record "Sales Line";
    begin
        //HEI.15>>
        APIInterfaceLog2.CALCFIELDS("Request File");
        //HEI.15<<
        // BC Upgrade VAMSIU01 >>
        // APIInterfaceLog2."Request File".CREATEINSTREAM(RequestInStream);

        // RequestXml.CreateInStream(RequestInStream);
        // APIInterfaceLog2."Request File".CreateOutStream(RequestOutStream);
        // CopyStream(RequestOutStream, RequestInStream);
        // // RequestXmlDocument := RequestXmlDocument.XmlDocument;
        // RequestXmlDocument.Load(RequestInStream);

        APIInterfaceLog2."Request File".CREATEINSTREAM(RequestInStream);
        RequestXmlDocument := XmlDocument.Create();
        XmlDocument.ReadFrom(RequestInStream, RequestXmlDocument);
        //BC Upgrade VAMSIU01 >>

        SourceSystemIdentifierAPI.GET(APIInterfaceLog2."Source System Identifier"); //HEI.02

        // BC Upgrade VAMSIU01 >>
        // OrderXmlNode := RequestXmlDocument.SelectSingleNode('/msg/payload/order');
        // if ISNULL(OrderXmlNode) then
        if not RequestXmlDocument.SelectSingleNode('/msg/payload/order', OrderXmlNode) then
            ERROR(MissingNodeErr, 'order');
        // BC Upgrade VAMSIU01 >>

        // HEI.15>>
        SalesHeader.INIT;
        // HEI.15<<

        // BC Upgrade VAMSIU01 >>
        // TempXmlNode := OrderXmlNode.SelectSingleNode('documentType');
        // if not ISNULL(TempXmlNode) then begin
        //   if TempXmlNode.InnerText <> '' then begin
        if OrderXmlNode.SelectSingleNode('documentType', TempXmlNode) then begin
            if TempXmlNode.AsXmlElement().InnerText() <> '' then begin
                // HEI.15>>
                // if not EVALUATE(TempDocumentType, TempXmlNode.InnerText) then
                if not EVALUATE(TempDocumentType, TempXmlNode.AsXmlElement().InnerText()) then
                    //BC Upgrade VAMSIU01 <<
                    ERROR(BadNodeValueErr, 'documentType');
                // HEI.15<<
                SalesHeader."Document Type" := TempDocumentType;
            end else begin
                SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
            end;
        end else begin
            SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        end;

        APIInterfaceSetup2.GET;
        APIInterfaceSetup2.TESTFIELD("Default Document Subtype Code");
        SalesHeader.VALIDATE("Document Subtype Code FND", APIInterfaceSetup2."Default Document Subtype Code"); // BC Upgrade SHUKLP03

        // Update fields on API Log
        //HEI.04>>
        // BC Upgrade VAMSIU01 >>
        // TempXmlNode := OrderXmlNode.SelectSingleNode('id');
        // if not ISNULL(TempXmlNode) then
        //     if TempXmlNode.InnerText <> '' then
        //         APIInterfaceLog2."Order ID" := TempXmlNode.InnerText;
        if OrderXmlNode.SelectSingleNode('id', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                APIInterfaceLog2."Order ID" := TempXmlNode.AsXmlElement().InnerText();
        // BC Upgrade VAMSIU01 <<
        //HEI.04<<
        GetNodeByXPath('documentNo', 'documentNo', OrderXmlNode, TempXmlNode);

        // Update fields on API Log
        APIInterfaceLog2."Source Type" := DATABASE::"Sales Header";
        APIInterfaceLog2."Source Subtype" := SalesHeader."Document Type".AsInteger();
        if not SourceSystemIdentifierAPI."Use Default S. Order Nos" then //HEI.02

            // BC Upgrade VAMSIU01 >>
            //APIInterfaceLog2."Source No.":= TempXmlNode.InnerText;
            APIInterfaceLog2."Source No." := TempXmlNode.AsXmlElement().InnerText();
        // BC Upgrade VAMSIU01 <<
        APIInterfaceLog2.MODIFY;
        COMMIT; // NOTE: NO DB WRITE BEFORE THIS COMMIT, EXCEPT ON API INTERFACE LOG

        //HEI.02>>
        if SourceSystemIdentifierAPI."Use Default S. Order Nos" then begin
            // Duplicate Validation based on External Document No.
            CreatedSalesHeader.SETRANGE("Document Type", SalesHeader."Document Type");
            // BC Upgrade VAMSIU01 >>
            //CreatedSalesHeader.SETRANGE("External Document No.", TempXmlNode.InnerText);
            CreatedSalesHeader.SETRANGE("External Document No.", TempXmlNode.AsXmlElement().InnerText());
            // BC Upgrade VAMSIU01 <<
            if not CreatedSalesHeader.ISEMPTY then
                //HEI.10>>
                //ERROR(ReturnOrderAlreadyExistsErr,TempXmlNode.InnerText);
                // BC Upgrade VAMSIU01 >>
                //ERROR(ReturnOrderAlreadyExistsErr, SalesHeader."Document Type", TempXmlNode.InnerText);
                ERROR(ReturnOrderAlreadyExistsErr, SalesHeader."Document Type", TempXmlNode.AsXmlElement().InnerText());
            // BC Upgrade VAMSIU01 <<
            //HEI.10<<

            if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
                //PostedShipment.SETRANGE("External Document No.",TempXmlNode.InnerText); // BC Upgrade VAMSIU01
                PostedShipment.SETRANGE("External Document No.", TempXmlNode.AsXmlElement().InnerText()); // BC Upgrade VAMSIU01
                if not PostedShipment.ISEMPTY then
                    //ERROR(ShipmentAlreadyExists2Err,TempXmlNode.InnerText); // BC Upgrade VAMSIU01
                    ERROR(ShipmentAlreadyExists2Err, TempXmlNode.AsXmlElement().InnerText());// BC Upgrade VAMSIU01
            end else if SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" then begin
                //PostedReceipt.SETRANGE("External Document No.",TempXmlNode.InnerText);// BC Upgrade VAMSIU01
                PostedReceipt.SETRANGE("External Document No.", TempXmlNode.AsXmlElement().InnerText());// BC Upgrade VAMSIU01
                if not PostedReceipt.ISEMPTY then
                    //ERROR(ReceiptAlreadyExists2Err,TempXmlNode.InnerText);// BC Upgrade VAMSIU01
                    ERROR(ReceiptAlreadyExists2Err, TempXmlNode.AsXmlElement().InnerText());// BC Upgrade VAMSIU01
            end;
        end else begin
            //HEI.02<<
            // Duplicate Validation
            CreatedSalesHeader.SETRANGE("Document Type", SalesHeader."Document Type");
            //CreatedSalesHeader.SETRANGE("No.", TempXmlNode.InnerText);// BC Upgrade VAMSIU01
            CreatedSalesHeader.SETRANGE("No.", TempXmlNode.AsXmlElement().InnerText());// BC Upgrade VAMSIU01
            if not CreatedSalesHeader.ISEMPTY then
                //HEI.10>>
                //ERROR(ReturnOrderAlreadyExistsErr,TempXmlNode.InnerText);
                //ERROR(ReturnOrderAlreadyExistsErr, SalesHeader."Document Type", TempXmlNode.InnerText);// BC Upgrade VAMSIU01
                ERROR(ReturnOrderAlreadyExistsErr, SalesHeader."Document Type", TempXmlNode.AsXmlElement().InnerText());// BC Upgrade VAMSIU01
            //HEI.10<<

            if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
                //PostedShipment.SETRANGE("Order No.", TempXmlNode.InnerText);// BC Upgrade VAMSIU01
                PostedShipment.SETRANGE("Order No.", TempXmlNode.AsXmlElement().InnerText());// BC Upgrade VAMSIU01
                if not PostedShipment.ISEMPTY then
                    //ERROR(ShipmentAlreadyExistsErr, TempXmlNode.InnerText);// BC Upgrade VAMSIU01
                    ERROR(ShipmentAlreadyExistsErr, TempXmlNode.AsXmlElement().InnerText());// BC Upgrade VAMSIU01
            end else if SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" then begin
                //PostedReceipt.SETRANGE("Return Order No.", TempXmlNode.InnerText);// BC Upgrade VAMSIU01
                PostedReceipt.SETRANGE("Return Order No.", TempXmlNode.AsXmlElement().InnerText());// BC Upgrade VAMSIU01
                if not PostedReceipt.ISEMPTY then
                    //ERROR(ReceiptAlreadyExistsErr, TempXmlNode.InnerText);// BC Upgrade VAMSIU01
                    ERROR(ReceiptAlreadyExistsErr, TempXmlNode.AsXmlElement().InnerText());// BC Upgrade VAMSIU01
            end;
            //HEI.02>>
        end;

        //HEI.10>>
        // CreatedSalesRetOrderNo := CreateSalesReturnOrder;
        // IF CreatedSalesRetOrderNo = '' THEN BEGIN
        //HEI.10<<

        if not SourceSystemIdentifierAPI."Use Default S. Order Nos" then
            //SalesHeader.VALIDATE("No.",TempXmlNode.InnerText)// BC Upgrade VAMSIU01
            SalesHeader.VALIDATE("No.", TempXmlNode.AsXmlElement().InnerText())// BC Upgrade VAMSIU01
        else
            //SalesHeader.VALIDATE("External Document No.",TempXmlNode.InnerText);// BC Upgrade VAMSIU01
            SalesHeader.VALIDATE("External Document No.", TempXmlNode.AsXmlElement().InnerText());// BC Upgrade VAMSIU01
                                                                                                  //HEI.02<<
                                                                                                  //HEI.10>>
                                                                                                  //Check duplicate SRO based on Linked Sales Document No.
                                                                                                  // BC Upgrade VAMSIU01 >>
                                                                                                  // TempXmlNode := OrderXmlNode.SelectSingleNode('LinkedSalesDocNo');
                                                                                                  // if not ISNULL(TempXmlNode) then
                                                                                                  //     if TempXmlNode.InnerText <> '' then
                                                                                                  //         LinkedSalesDocNo := TempXmlNode.InnerText;
        if OrderXmlNode.SelectSingleNode('LinkedSalesDocNo', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                LinkedSalesDocNo := TempXmlNode.AsXmlElement().InnerText();
        // BC Upgrade VAMSIU01 <<

        if (SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order") and
           (LinkedSalesDocNo <> '')
        then begin
            //Duplicate check
            SalesHeader3.RESET;
            SalesHeader3.SETRANGE("Document Type", SalesHeader3."Document Type"::"Return Order");
            SalesHeader3.SETRANGE("No.", LinkedSalesDocNo); // BC Upgrade VAMSIU01 - Blocked as Drinkit dependent field(2013613)
            if SalesHeader3.FINDFIRST then
                ERROR(ReturnOrderLinkedSoExistsErr, SalesHeader3."No.", LinkedSalesDocNo);

            //Check if SO exists
            SalesHeader2.SETRANGE("Document Type", SalesHeader2."Document Type"::Order);
            SalesHeader2.SETRANGE("No.", LinkedSalesDocNo);
            SalesHeaderArchive.SETRANGE("Document Type", SalesHeaderArchive."Document Type"::Order);
            SalesHeaderArchive.SETRANGE("No.", LinkedSalesDocNo);
            if SalesHeader2.FINDFIRST or SalesHeaderArchive.FINDFIRST then begin
                if SourceSystemIdentifierAPI."Use Default S. Order Nos" then
                    SalesHeader.VALIDATE("No.", LinkedSalesDocNo);
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
                            SalesHeader.VALIDATE("No.", SalesHeader2."No.")
                        else if SalesHeaderArchive."No." <> '' then
                            SalesHeader.VALIDATE("No.", SalesHeaderArchive."No.");
                    LinkedSOExists := true;
                    LinkedSalesOrderNo := SalesHeader."No.";
                    //HEI.16>>
                end else
                    LinkedSalesOrderNo := LinkedSalesDocNo;
                //HEI.16<<
            end;
            //HEI.16>>
            if not LinkedSOExists then
                ERROR(ReturnOrderLinkedNotExistsErr, LinkedSalesOrderNo);
            //HEI.16<<
        end;
        //HEI.10<<
        SalesHeader.INSERT(true);
        //HEI.02>>
        if SourceSystemIdentifierAPI."Use Default S. Order Nos" then begin
            APIInterfaceLog2."Source No." := SalesHeader."No.";
            APIInterfaceLog2.MODIFY;
        end;
        //HEI.02<<

        //HEI.10>>
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order") and
           (LinkedSalesDocNo <> '') and LinkedSOExists
        then begin
            // BC Upgrade VAMSIU01 >>
            //  SalesHeader.VALIDATE("Link Sales Document Type",SalesHeader."Link Sales Document Type"::Order);
            //  SalesHeader."Link Sales Document No." := LinkedSalesOrderNo;
            // BC Upgrade VAMSIU01 >>
        end;
        //HEI.10<<

        GetNodeByXPath('customerId', 'customerId', OrderXmlNode, TempXmlNode);
        //SalesHeader.VALIDATE("Sell-to Customer No.",TempXmlNode.InnerText);  // Block validation
        SalesHeader.VALIDATE("Sell-to Customer No.", TempXmlNode.AsXmlElement().InnerText());

        GetNodeByXPath('orderDate', 'orderDate', OrderXmlNode, TempXmlNode);
        //HEI.15>>
        //if not EVALUATE(TempDate,TempXmlNode.InnerText,9) then // BC Upgrade VAMSIU01
        if not EVALUATE(TempDate, TempXmlNode.AsXmlElement().InnerText(), 9) then // BC Upgrade VAMSIU01 
            ERROR(BadNodeValueErr, 'orderDate');
        //HEI.15<<
        OrderDate := TempDate; //HEI.09
        SalesHeader.VALIDATE("Order Date", TempDate);
        SalesHeader.VALIDATE("Posting Date", TempDate);
        SalesHeader.VALIDATE("Document Date", TempDate);

        // BC Upgrade VAMSIU01 >>

        // TempXmlNode := OrderXmlNode.SelectSingleNode('id');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then
        //     SalesHeader."Order Id" := TempXmlNode.InnerText;

        // TempXmlNode := OrderXmlNode.SelectSingleNode('contactFullName');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then
        //     SalesHeader."Sell-to Contact" := TempXmlNode.InnerText;

        // TempXmlNode := OrderXmlNode.SelectSingleNode('currencyCode');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then
        //     SalesHeader.VALIDATE("Currency Code",TempXmlNode.InnerText);

        // TempXmlNode := OrderXmlNode.SelectSingleNode('paymentTerms');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then
        //     SalesHeader.VALIDATE("Payment Terms Code",TempXmlNode.InnerText);

        // TempXmlNode := OrderXmlNode.SelectSingleNode('salesperson');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then
        //     SalesHeader.VALIDATE("Salesperson Code",TempXmlNode.InnerText);

        // TempXmlNode := OrderXmlNode.SelectSingleNode('locationCode');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then
        //     SalesHeader.VALIDATE("Location Code",TempXmlNode.InnerText);

        // id
        if OrderXmlNode.SelectSingleNode('id', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                SalesHeader."Order Id FND" := TempXmlNode.AsXmlElement().InnerText();

        // contactFullName
        if OrderXmlNode.SelectSingleNode('contactFullName', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                SalesHeader."Sell-to Contact" := TempXmlNode.AsXmlElement().InnerText();

        // currencyCode
        if OrderXmlNode.SelectSingleNode('currencyCode', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                SalesHeader.Validate("Currency Code", TempXmlNode.AsXmlElement().InnerText());

        // paymentTerms
        if OrderXmlNode.SelectSingleNode('paymentTerms', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                SalesHeader.Validate("Payment Terms Code", TempXmlNode.AsXmlElement().InnerText());

        // salesperson
        if OrderXmlNode.SelectSingleNode('salesperson', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                SalesHeader.Validate("Salesperson Code", TempXmlNode.AsXmlElement().InnerText());

        // locationCode
        if OrderXmlNode.SelectSingleNode('locationCode', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                SalesHeader.Validate("Location Code", TempXmlNode.AsXmlElement().InnerText());
        // BC Upgrade VAMSIU01 <<

        // BC Upgrade VAMSIU01 >> Drinkit dependent code 
        //HEI.07>>
        if SourceSystemIdentifierAPI."Automatic SO Posting" then
            if SalesHeader."Route 107FDW" <> '' then begin
                Route.GET(SalesHeader."Route 107FDW");
                if Route."Shipping Location" <> TempXmlNode.AsXmlElement().Innertext() then begin // BC Upgrade SHUKLP03 << Replaced location code field with Shipping Location field from Route table
                    SalesHeader.VALIDATE("Route 107FDW", '');
                    SalesHeader.VALIDATE("Location Code", TempXmlNode.AsXmlElement().Innertext());
                end;
            end;
        //HEI.07<<
        // BC Upgrade VAMSIU01 <<

        // BC Upgrade VAMSIU01 >>
        // TempXmlNode := OrderXmlNode.SelectSingleNode('requestedDeliveryDate');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then begin
        //     //HEI.15>>
        //     if not EVALUATE(TempDate,TempXmlNode.InnerText, 9) then
        //       ERROR(BadNodeValueErr,'requestedDeliveryDate');
        //     //HEI.15<<
        //     //HEI.20>>
        //     /*IF TempDate < WORKDATE THEN  // past date validation
        //       ERROR(PastDateErr,'requestedDeliveryDate');*/
        //     //HEI.20<<
        //     SalesHeader.VALIDATE("Requested Delivery Date",TempDate);
        //   end;

        if OrderXmlNode.SelectSingleNode('requestedDeliveryDate', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then begin

                if not Evaluate(TempDate, TempXmlNode.AsXmlElement().InnerText(), 9) then
                    Error(BadNodeValueErr, 'requestedDeliveryDate');

                SalesHeader.Validate("Requested Delivery Date", TempDate);
            end;
        // BC Upgrade VAMSIU01 <<

        // BC Upgrade VAMSIU01 >>
        // TempXmlNode := OrderXmlNode.SelectSingleNode('promisedDeliveryDate');
        // if not ISNULL(TempXmlNode) then
        //     if TempXmlNode.InnerText <> '' then begin
        //         //HEI.15>>
        //         if not EVALUATE(TempDate, TempXmlNode.InnerText, 9) then
        //             ERROR(BadNodeValueErr, 'promisedDeliveryDate');
        //         //HEI.15<<
        //         //HEI.20>>
        //         /*IF TempDate < WORKDATE THEN  // past date validation
        //           ERROR(PastDateErr,'promisedDeliveryDate');*/
        //         //HEI.20<<
        //         SalesHeader.VALIDATE("Promised Delivery Date", TempDate);
        //     end;
        if OrderXmlNode.SelectSingleNode('promisedDeliveryDate', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then begin

                if not Evaluate(TempDate, TempXmlNode.AsXmlElement().InnerText(), 9) then
                    Error(BadNodeValueErr, 'promisedDeliveryDate');

                SalesHeader.Validate("Promised Delivery Date", TempDate);
            end;
        // BC Upgrade VAMSIU01 <<

        // BC Upgrade VAMSIU01 >>
        // TempXmlNode := OrderXmlNode.SelectSingleNode('externalDocNo');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then
        //     SalesHeader."External Document No." := TempXmlNode.InnerText;

        // TempXmlNode := OrderXmlNode.SelectSingleNode('paymentMethod');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then
        //     SalesHeader.VALIDATE("Payment Method Code", TempXmlNode.InnerText);

        // TempXmlNode := OrderXmlNode.SelectSingleNode('shipmentMethod');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then
        //     SalesHeader.VALIDATE("Shipment Method Code",TempXmlNode.InnerText);

        // //HEI.18>>
        // TempXmlNode := OrderXmlNode.SelectSingleNode('TruckCode');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then
        //     SalesHeader.VALIDATE("Truck Code",TempXmlNode.InnerText);

        // TempXmlNode := OrderXmlNode.SelectSingleNode('DriverCode');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then
        //     SalesHeader.VALIDATE("Driver Code",TempXmlNode.InnerText);

        // externalDocNo
        if OrderXmlNode.SelectSingleNode('externalDocNo', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                SalesHeader."External Document No." :=
                    TempXmlNode.AsXmlElement().InnerText();

        // paymentMethod
        if OrderXmlNode.SelectSingleNode('paymentMethod', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                SalesHeader.Validate("Payment Method Code",
                    TempXmlNode.AsXmlElement().InnerText());

        // shipmentMethod
        if OrderXmlNode.SelectSingleNode('shipmentMethod', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                SalesHeader.Validate("Shipment Method Code",
                    TempXmlNode.AsXmlElement().InnerText());

        //BC Upgrade SHUKLP03 - Drinkit dependent field -TruckCode
        if OrderXmlNode.SelectSingleNode('TruckCode', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                SalesHeader.Validate("Vehicle Code 101FDW", TempXmlNode.AsXmlElement().InnerText());

        // BC Upgrade SHUKLP03 - Drinkit dependent field - DriverCode
        if OrderXmlNode.SelectSingleNode('DriverCode', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                SalesHeader.Validate("Log Driver 107FDW", TempXmlNode.AsXmlElement().InnerText());

        //BC Upgrade VAMSIU01 <<
        //HEI.18<<

        SalesHeader."Source System Identifier FND" := APIInterfaceLog2."Source System Identifier";

        //BC Upgrade VAMSIU01 >>
        // TempXmlNode := OrderXmlNode.SelectSingleNode('totalAmountIncludingVAT');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then begin
        //     //HEI.15>>
        //     if not EVALUATE(TempDecimal,TempXmlNode.InnerText,9) then
        //       ERROR(BadNodeValueErr,'totalAmountIncludingVAT');
        //     //HEI.15<<
        //     SalesHeader."Doc. Amount Incl. VAT" := TempDecimal;
        //   end;

        // TempXmlNode := OrderXmlNode.SelectSingleNode('totalVatAmount');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then begin
        //     //HEI.15>>
        //     if not EVALUATE(TempDecimal,TempXmlNode.InnerText,9) then
        //       ERROR(BadNodeValueErr,'totalVatAmount');
        //     //HEI.15<<
        //     SalesHeader."Doc. Amount VAT" := TempDecimal;
        //   end;

        // totalAmountIncludingVAT
        if OrderXmlNode.SelectSingleNode('totalAmountIncludingVAT', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then begin
                if not Evaluate(TempDecimal, TempXmlNode.AsXmlElement().InnerText(), 9) then
                    Error(BadNodeValueErr, 'totalAmountIncludingVAT');
                SalesHeader."Doc. Amount Incl. VAT FND" := TempDecimal;
            end;

        // totalVatAmount
        if OrderXmlNode.SelectSingleNode('totalVatAmount', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then begin
                if not Evaluate(TempDecimal, TempXmlNode.AsXmlElement().InnerText(), 9) then
                    Error(BadNodeValueErr, 'totalVatAmount');
                SalesHeader."Doc. Amount VAT FND" := TempDecimal;
            end;
        //BC Upgrade VAMSIU01 <<

        //HEI.03>>
        //Update CCC Dimension from Counterpoint Location Mapping
        if SourceSystemIdentifierAPI."Use Location - Dim Mapping" then begin
            CLEAR(TempDimensionSetEntry);
            DimensionManagement.GetDimensionSet(TempDimensionSetEntry, SalesHeader."Dimension Set ID");

            GetDimensionLocationMapping(SalesHeader."Location Code");
            TempDimensionSetEntry.SETRANGE("Dimension Code", CCCDimensionCode);
            if TempDimensionSetEntry.FINDFIRST and (TempDimensionSetEntry."Dimension Value Code" <> CCCDimensionValue) then
                TempDimensionSetEntry.DELETE;
            if (CCCDimensionCode <> '') or (CCCDimensionValue <> '') then begin
                TempDimensionSetEntry.INIT;
                TempDimensionSetEntry."Dimension Code" := CCCDimensionCode;
                TempDimensionSetEntry."Dimension Value Code" := CCCDimensionValue;
                if TempDimensionSetEntry.INSERT(true) then;
            end;

            SalesHeader.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
        end;
        //HEI.03<<

        //HEI.11>>
        //BC Upgrade VAMSIU01 >>
        // TempXmlNode := OrderXmlNode.SelectSingleNode('PaymentDocumentNo');
        // if not ISNULL(TempXmlNode) then
        //   if TempXmlNode.InnerText <> '' then begin
        if OrderXmlNode.SelectSingleNode('PaymentDocumentNo', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then begin
                //BC Upgrade VAMSIU01 <<
                SalesHeader.VALIDATE("Applies-to Doc. Type", SalesHeader."Applies-to Doc. Type"::Payment);
                //SalesHeader.VALIDATE("Applies-to Doc. No.", TempXmlNode.InnerText); // BC Upgrade VAMSIU01
                SalesHeader.VALIDATE("Applies-to Doc. No.", TempXmlNode.AsXmlElement().InnerText()); // BC Upgrade VAMSIU01
            end;
        //HEI.11<<
        SalesHeader.MODIFY(FALSE);
        //HEI.19>>
        // SalesHeader.MODIFY(TRUE);
        //BC Upgrade VAMSIU01 - Blocked below two lines for DrinkIt dependent >>
        // SalesHeader.UpdateRoutePlanRqstLines('');
        // SalesHeader.UpdateCustomerAddress;
        //BC Upgrade VAMSIU01 - Blocked below two lines for DrinkIt dependent <<
        // SalesHeader.MODIFY(false);
        //HEI.19<<

        Comments := '';
        //BC Upgrade VAMSIU01 >>
        // TempXmlNode := OrderXmlNode.SelectSingleNode('comments');
        // if not ISNULL(TempXmlNode) then
        //     if TempXmlNode.InnerText <> '' then
        //         Comments := TempXmlNode.InnerText;
        if OrderXmlNode.SelectSingleNode('comments', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                Comments := TempXmlNode.AsXmlElement().InnerText();
        //BC Upgrade VAMSIU01 << 
        if Comments <> '' then begin
            LastSalesCommentLine.SETRANGE("Document Type", SalesHeader."Document Type");
            LastSalesCommentLine.SETRANGE("No.", SalesHeader."No.");
            LastSalesCommentLine.SETRANGE("Document Line No.", 0);
            if LastSalesCommentLine.FINDLAST then
                CommentLineNo := LastSalesCommentLine."Line No."
            else
                CommentLineNo := 0;
        end;
        while Comments <> '' do begin
            SalesCommentLine.INIT;
            SalesCommentLine."Document Type" := SalesHeader."Document Type";
            SalesCommentLine."No." := SalesHeader."No.";
            SalesCommentLine."Document Line No." := 0;
            CommentLineNo += 10000;
            SalesCommentLine."Line No." := CommentLineNo;
            SalesCommentLine.Date := WORKDATE;
            if STRLEN(Comments) > MAXSTRLEN(SalesCommentLine.Comment) then begin
                SalesCommentLine.Comment := COPYSTR(Comments, 1, MAXSTRLEN(SalesCommentLine.Comment));
                Comments := COPYSTR(Comments, MAXSTRLEN(SalesCommentLine.Comment) + 1);
            end else begin
                SalesCommentLine.Comment := Comments;
                Comments := '';
            end;
            SalesCommentLine.INSERT(true);
        end;

        //HEI.10>>
        //HEI.02>>
        // END ELSE BEGIN
        // SalesHeader.RESET;
        // SalesHeader.SETRANGE("Document Type",SalesHeader."Document Type"::"Return Order");
        // SalesHeader.SETRANGE("No.",CreatedSalesRetOrderNo);
        // IF SalesHeader.FINDFIRST THEN;
        // END;
        //HEI.02<<
        //HEI.10<<

        // BC Upgrade VAMSIU01 <<
        // LinesXmlNodeList := OrderXmlNode.SelectNodes('lines/line');
        // if ISNULL(LinesXmlNodeList) then
        //   ERROR(MissingNodeErr,'line');
        if NOT OrderXmlNode.SelectNodes('lines/line', LinesXmlNodeList) then
            Error(MissingNodeErr, 'line');
        //BC Upgrade VAMSIU01 <<

        foreach LineXmlNode in LinesXmlNodeList do begin
            IsGift := false;
            //BC Upgrade VAMSIU01 >>
            // TempXmlNode := LineXmlNode.SelectSingleNode('isGift');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         if not EVALUATE(IsGift, TempXmlNode.InnerText, 9) then
            //HEI.15>>
            if LineXmlNode.SelectSingleNode('isGift', TempXmlNode) then
                if TempXmlNode.AsXmlElement().InnerText() <> '' then
                    if not Evaluate(IsGift, TempXmlNode.AsXmlElement().InnerText(), 9) then
                        //BC Upgrade VAMSIU01 <<
                        ERROR(BadNodeValueErr, 'isGift');
            //HEI.15<<
            //IF NOT IsGift THEN BEGIN //HEI.03

            if SourceSystemIdentifierAPI."Apply Sales Condit Interface" or not IsGift then begin //HEI.05
                                                                                                 //BC Upgrade VAMSIU01 >>
                                                                                                 // TempXmlNode := LineXmlNode.SelectSingleNode('sequence');
                                                                                                 // if not ISNULL(TempXmlNode) then begin
                                                                                                 //     if TempXmlNode.InnerText <> '' then begin
                                                                                                 //         //HEI.15>>
                                                                                                 //         if not EVALUATE(Sequence, TempXmlNode.InnerText) then
                if LineXmlNode.SelectSingleNode('sequence', TempXmlNode) then begin
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then begin
                        if not EVALUATE(Sequence, TempXmlNode.AsXmlElement().InnerText()) then
                            //BC Upgrade VAMSIU01 <<
                            ERROR(BadNodeValueErr, 'sequence');
                        //HEI.15<<
                        SequenceFound := true;
                    end else begin
                        SequenceFound := false;
                    end;
                end else begin
                    SequenceFound := false;
                end;

                if not SequenceFound then begin
                    if Sequence = 0 then begin
                        LastSalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                        LastSalesLine.SETRANGE("Document No.", SalesHeader."No.");
                        if LastSalesLine.FINDLAST then
                            Sequence := LastSalesLine."Line No."
                    end;
                    Sequence += 10000;
                end;

                //HEI.09>>
                SalesLine.SetSalesHeader(SalesHeader);
                //HEI.09<<
                SalesLine.INIT; //HEI.03
                SalesLine."Document Type" := SalesHeader."Document Type";
                SalesLine."Document No." := SalesHeader."No.";
                SalesLine."Line No." := Sequence;

                SalesHeader.SETAUTOCALCFIELDS();  //HEI.19

                //HEI.23>>
                //SalesLine.INSERT(TRUE);
                //HEI.23<<

                //BC Upgrade VAMSIU01 >>
                // TempXmlNode := LineXmlNode.SelectSingleNode('lineType');
                // if not ISNULL(TempXmlNode) then begin
                //     if TempXmlNode.InnerText <> '' then begin
                //         //HEI.15>>
                //         if not EVALUATE(TempType, TempXmlNode.InnerText) then
                if LineXmlNode.SelectSingleNode('lineType', TempXmlNode) then begin
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then begin
                        if not EVALUATE(TempType, TempXmlNode.AsXmlElement().InnerText()) then
                            //BC Upgrade VAMSIU01 <<
                            ERROR(BadNodeValueErr, 'lineType');
                        //HEI.15<<
                        SalesLine.Type := TempType;
                    end else begin
                        SalesLine.Type := SalesLine.Type::Item;
                    end;
                end else begin
                    SalesLine.Type := SalesLine.Type::Item;
                end;

                SalesLine.INSERT(true);//HEI.23

                GetNodeByXPath('itemId', 'itemId', LineXmlNode, TempXmlNode);  // Block validation
                                                                               //SalesLine.VALIDATE("No.",TempXmlNode.InnerText); //BC Upgrade VAMSIU01
                SalesLine.VALIDATE("No.", TempXmlNode.AsXmlElement().InnerText()); //BC Upgrade VAMSIU01

                // BC Upgrade VAMSIU01 >>
                // TempXmlNode := LineXmlNode.SelectSingleNode('unitOfMeasure');
                // if not ISNULL(TempXmlNode) then
                //   if TempXmlNode.InnerText <> '' then
                // SalesLine.VALIDATE("Unit of Measure Code", TempXmlNode.InnerText);
                if LineXmlNode.SelectSingleNode('unitOfMeasure', TempXmlNode) then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then
                        SalesLine.VALIDATE("Unit of Measure Code", TempXmlNode.AsXmlElement().InnerText());
                // BC Upgrade VAMSIU01 <<

                GetNodeByXPath('quantity', 'quantity', LineXmlNode, TempXmlNode);
                //HEI.15>>
                // BC Upgrade VAMSIU01 >>
                //if not EVALUATE(TempDecimal, TempXmlNode.InnerText, 9) then
                if not EVALUATE(TempDecimal, TempXmlNode.AsXmlElement().InnerText(), 9) then
                    ERROR(BadNodeValueErr, 'quantity');
                // BC Upgrade VAMSIU01 >>
                //HEI.15<<
                SalesLine.VALIDATE(Quantity, TempDecimal);

                if SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" then begin
                    // BC Upgrade VAMSIU01 >>
                    // TempXmlNode := LineXmlNode.SelectSingleNode('returnReasonCode');
                    // if not ISNULL(TempXmlNode) then
                    //     if TempXmlNode.InnerText <> '' then
                    //         SalesLine.VALIDATE("Return Reason Code", TempXmlNode.InnerText);
                    if LineXmlNode.SelectSingleNode('returnReasonCode', TempXmlNode) then
                        if TempXmlNode.AsXmlElement().InnerText() <> '' then
                            SalesLine.VALIDATE("Return Reason Code", TempXmlNode.AsXmlElement().InnerText());
                    // BC Upgrade VAMSIU01 <<
                end;

                //HEI.03>>
                // BC Upgrade VAMSIU01 >>
                // TempXmlNode := LineXmlNode.SelectSingleNode('AttachedToLineNo');
                // if not ISNULL(TempXmlNode) then
                //     if TempXmlNode.InnerText <> '' then begin
                //         //HEI.15>>
                //         if not EVALUATE(TempAttachedToLineNo, TempXmlNode.InnerText) then
                if LineXmlNode.SelectSingleNode('AttachedToLineNo', TempXmlNode) then
                    if TempXmlNode.AsXmlElement().InnerText() <> '' then begin
                        if not Evaluate(TempAttachedToLineNo, TempXmlNode.AsXmlElement().InnerText()) then
                            // BC Upgrade VAMSIU01 <<
                            ERROR(BadNodeValueErr, 'AttachedToLineNo');
                        //HEI.15<<
                        //HEI.17>>
                        // BC Upgrade VAMSIU01 -  Blocked as Drinkit dependent field Item charge type >>
                        // if (TempAttachedToLineNo <> 0) or (SalesLine."Item Charge Type" <> SalesLine."Item Charge Type"::" ") then begin // BC Upgrade SHUKLP03 << Obsolete
                        if (TempAttachedToLineNo <> 0) or (SalesLine."Attached to Line No." <> 0) THEN BEGIN // BC Upgrade SHUKLP03 << modified condition
                                                                                                             // HEI.17<<
                            SalesLine.VALIDATE("Attached to Line No.", TempAttachedToLineNo);
                            // HEI.17>>
                            // BC Upgrade VAMSIU01  Blocked as Drinkit dependent field Item charge type <<
                            if SalesLine."Attached to Line No." = 0 then
                                SalesLine2 := LastSalesLineItem
                            else
                                //HEI.17<<
                                //HEI.19>>
                                //            SalesLine2.GET(SalesLine."Document Type",SalesLine."Document No.",TempAttachedToLineNo);
                                SalesLine2.RESET;
                            SalesLine2.SETRANGE("Document Type", SalesLine."Document Type");
                            SalesLine2.SETRANGE("Document No.", SalesLine."Document No.");
                            SalesLine2.SETRANGE("Line No.", TempAttachedToLineNo);
                            SalesLine2.SETAUTOCALCFIELDS();
                            if SalesLine2.FINDFIRST then;
                            //HEI.19<<

                            SalesLine."Allow Invoice Disc." := false;
                            //SalesLine."Allow Item Charge Line Disc." := false; // BC Upgrade VAMSIU01

                            SalesLine."Originally Ordered No." := SalesLine2."No.";
                            SalesLine."Shipment Variance 24 FDW" := SalesLine.Quantity; // BC Upgarde SHUKLP03 <<
                                                                                        // BC Upgrade VAMSIU01 - Blocked as Drinkit dependent fields >> // BC Upgarde SHUKLP03 << Obsolete 
                                                                                        // SalesLine."Using Qty. (Base)" := true;
                                                                                        // BC Upgrade VAMSIU01 - Blocked as Drinkit dependent fields <<



                            if SalesLine.Type = SalesLine.Type::"Charge (Item)" then begin
                                ItemCharge.GET(SalesLine."No.");
                                // BC Upgrade VAMSIU01 - Blocked as Drinkit dependent fields >>
                                if ItemCharge."Excluded for Pay. Disc. 101FDW" = false then // BC Upgrade SHUKLP03 << 
                                    SalesLine.VALIDATE(Quantity, -ABS(SalesLine.Quantity));

                                SalesLine."Has Item Charge 101FDW" := true; // BC Upgrade SHUKLP03 <<
                                                                            // SalesLine."Manual Item Charge" := true;  // BC Upgrade SHUKLP03 << obsolete
                                                                            // SalesLine."Manual Unit Price" := true;   // BC Upgrade SHUKLP03 << obsolete
                                                                            // SalesLine."Item Charge Quantity per" := 1; // BC Upgrade SHUKLP03 << obsolete
                                                                            // SalesLine."Show Item charge on Invoice" := ItemCharge."Show Item charge on Invoice";
                                                                            // SalesLine.Collapse := true;  // BC Upgrade SHUKLP03 << obsolete

                                // HEI.17>>
                                // if SalesLine."Attached to Line No." = 0 then
                                //     SalesLine.Collapse := false;   // BC Upgrade SHUKLP03 << obsolete
                                // // HEI.17<<
                                // SalesLine."Minimum Quantity" := 1;  // BC Upgrade SHUKLP03 << obsolete

                                // BC Upgrade VAMSIU01 - Blocked as Drinkit dependent fields <<

                                //Dimensions
                                SalesLine."Dimension Set ID" := SalesLine2."Dimension Set ID";
                                CLEAR(TempDimensionSetEntry);
                                DimensionManagement.GetDimensionSet(TempDimensionSetEntry, SalesLine."Dimension Set ID");
                                DefaultDimension.SETRANGE("Table ID", DATABASE::"Item Charge");
                                DefaultDimension.SETRANGE("No.", SalesLine."No.");
                                if DefaultDimension.FINDSET then
                                    repeat
                                        TempDimensionSetEntry.INIT;
                                        TempDimensionSetEntry."Dimension Code" := DefaultDimension."Dimension Code";
                                        TempDimensionSetEntry."Dimension Value Code" := DefaultDimension."Dimension Value Code";
                                        if TempDimensionSetEntry.INSERT(true) then;
                                    until DefaultDimension.NEXT = 0;
                                SalesLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));

                                //Insert Item Charge Assignment Sales
                                ItemChargeAssignmentSales.INIT;
                                ItemChargeAssignmentSales.VALIDATE("Document Type", SalesHeader."Document Type");
                                ItemChargeAssignmentSales.VALIDATE("Document No.", SalesHeader."No.");
                                ItemChargeAssignmentSales.VALIDATE("Document Line No.", SalesLine."Line No.");
                                ItemChargeAssignmentSales.VALIDATE("Line No.", SalesLine2."Line No.");
                                ItemChargeAssignmentSales.VALIDATE("Item Charge No.", SalesLine."No.");
                                ItemChargeAssignmentSales.VALIDATE("Applies-to Doc. Type", SalesHeader."Document Type");
                                ItemChargeAssignmentSales.VALIDATE("Applies-to Doc. No.", SalesHeader."No.");
                                //HEI.17>>
                                ItemChargeAssignmentSales.VALIDATE("Applies-to Doc. Line No.", SalesLine2."Line No.");
                                //HEI.17<<
                                ItemChargeAssignmentSales.VALIDATE("Item No.", SalesLine2."No.");
                                ItemChargeAssignmentSales.VALIDATE(Description, SalesLine2.Description);
                                //HEI.24>>
                                if SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" then
                                    ItemChargeAssignmentSales."Qty. to Assign" := SalesLine.Quantity;
                                //HEI.24<<
                                ItemChargeAssignmentSales.INSERT;
                            end else if IsGift then begin
                                // BC Upgrade SHUKLP03 >>
                                ApiInterfaceSetupRec.get();
                                If ApiInterfaceSetupRec."Gift Reason Code" <> '' then
                                    SalesLine."Reason Code 101FDW" := ApiInterfaceSetupRec."Gift Reason Code";
                                // BC Upgrade SHUKLP03 <<

                                // BC Upgrade VAMSIU01 - Blocked as Drinkit dependent fields << 
                                // SalesLine."Extra Charge Type" := SalesLine."Extra Charge Type"::Amount;
                                // SalesLine."Line Discount %" := 100;
                                // SalesLine."Item Charge Discount %" := 100;
                                // SalesLine."Item Charge Type" := SalesLine."Item Charge Type"::Promotion;
                                // SalesLine."Free Item" := true;
                                // SalesLine."Free Quantity" := SalesLine.Quantity;
                                // SalesLine."Multiple Quantity" := SalesLine2.Quantity;
                                // SalesLine."Minimum Quantity" := SalesLine2.Quantity;
                                // SalesLine."Maximum Free Quantity" := SalesLine.Quantity;
                                // SalesLine."Item Charge Quantity per" := SalesLine.Quantity / SalesLine2.Quantity;
                                // BC Upgrade VAMSIU01 - Blocked as Drinkit dependent fields <<
                            end;
                        end;
                    end;

                if SourceSystemIdentifierAPI."Apply Sales Condit Interface" then begin
                    // BC Upgrade VAMSIU01 >>
                    //   TempXmlNode := LineXmlNode.SelectSingleNode('VATPercentage');
                    //   if not ISNULL(TempXmlNode) then
                    //     if TempXmlNode.InnerText <> '' then begin
                    //       //HEI.15>>
                    //       if not EVALUATE(TempVATPerc,TempXmlNode.InnerText,9) then
                    if LineXmlNode.SelectSingleNode('VATPercentage', TempXmlNode) then
                        if TempXmlNode.AsXmlElement().InnerText() <> '' then begin
                            if not Evaluate(TempVATPerc, TempXmlNode.AsXmlElement().InnerText(), 9) then
                                // BC Upgrade VAMSIU01 <<
                                ERROR(BadNodeValueErr, 'VATPercentage');
                            //HEI.15<<
                            SalesLine.VALIDATE("VAT %", TempVATPerc);
                            VATPostingSetup.RESET;
                            VATPostingSetup.SETRANGE("VAT %", TempVATPerc);
                            VATPostingSetup.SETRANGE("VAT Bus. Posting Group", SalesLine."VAT Bus. Posting Group");
                            if VATPostingSetup.FINDFIRST then
                                SalesLine."VAT Identifier" := VATPostingSetup."VAT Identifier"
                            else
                                SalesLine."VAT Identifier" += '2';
                        end;

                    GetNodeByXPath('UnitPrice', 'UnitPrice', LineXmlNode, TempXmlNode);
                    //HEI.15>>
                    //if not EVALUATE(TempUnitPrice, TempXmlNode.InnerText, 9) then // BC Upgrade VAMSIU01
                    if not Evaluate(TempUnitPrice, TempXmlNode.AsXmlElement().InnerText(), 9) then //BC Upgrade VAMSIU01
                        ERROR(BadNodeValueErr, 'UnitPrice');
                    //HEI.15<<
                    SalesLine."Unit Price" := TempUnitPrice;
                    //   SalesLine."Item Charge Value" := SalesLine."Unit Price"; // BC Upgrade VAMSIU01 - Blocked as Drinkit dependent fields- Obsolete
                    if IsGift then begin
                        SalesLine.Amount := 0;
                        SalesLine."Amount Including VAT" := 0;
                        SalesLine.VALIDATE("Outstanding Amount", 0);
                        SalesLine."VAT Base Amount" := 0;
                        SalesLine."Line Amount" := 0;
                        SalesLine."Line Discount Amount" := SalesLine."Unit Price" * SalesLine.Quantity;
                    end else begin
                        SalesLine.Amount := SalesLine."Unit Price" * SalesLine.Quantity;
                        SalesLine."Amount Including VAT" := SalesLine.Amount + SalesLine.Amount * (SalesLine."VAT %" / 100);
                        SalesLine.VALIDATE("Outstanding Amount", SalesLine."Amount Including VAT");
                        SalesLine."VAT Base Amount" := SalesLine.Amount;
                        SalesLine."Line Amount" := SalesLine.Amount;
                    end;
                    // BC Upgrade VAMSIU01 - Blocked as Drinkit dependent fields
                    // if (SalesLine.Type = SalesLine.Type::"Charge (Item)") and
                    //     (SalesLine."Item Charge Type" = SalesLine."Item Charge Type"::Discount)
                    // then
                    //     SalesLine."DDiscount Base Amount" := SalesLine."Unit Price"; // BC Upgrade SHUKLP03 << obsolete
                    // BC Upgrade VAMSIU01 - Blocked as Drinkit dependent fields
                end;
                //HEI.03<<

                SalesLine.MODIFY(true);
                //HEI.17>>
                if SalesLine.Type = SalesLine.Type::Item then
                    LastSalesLineItem := SalesLine;
                //HEI.17<<
            end;
        end;

        // Amount validation
        //IF (APIInterfaceSetup2."Order Value Validation") AND (SalesHeader."Doc. Amount Incl. VAT" <> 0) AND (SalesHeader."Doc. Amount VAT" <> 0) THEN BEGIN //HEI.03
        if SourceSystemIdentifierAPI."Order Value Validation" and (SalesHeader."Doc. Amount Incl. VAT FND" <> 0) and (SalesHeader."Doc. Amount VAT FND" <> 0) then begin //HEI.03
            SalesHeader.CALCFIELDS(Amount, "Amount Including VAT");
            //HEI.03>>
            //IF NOT (((SalesHeader."Doc. Amount Incl. VAT" - APIInterfaceSetup2."Order Val. Tolerance Amt") <= SalesHeader."Amount Including VAT") AND
            //(SalesHeader."Amount Including VAT" <= (SalesHeader."Doc. Amount Incl. VAT" + APIInterfaceSetup2."Order Val. Tolerance Amt")))
            if not (((SalesHeader."Doc. Amount Incl. VAT FND" - SourceSystemIdentifierAPI."Order Val. Tolerance Amt") <= SalesHeader."Amount Including VAT") and
              (SalesHeader."Amount Including VAT" <= (SalesHeader."Doc. Amount Incl. VAT FND" + SourceSystemIdentifierAPI."Order Val. Tolerance Amt")))
            //HEI.03<<
            then
                ERROR(AmountValidationFailedErr, SalesHeader."No.", SalesHeader."Source System Identifier FND");

            //HEI.03>>
            //IF NOT (((SalesHeader."Doc. Amount VAT" - APIInterfaceSetup2."Order Val. Tolerance Amt") <= (SalesHeader."Amount Including VAT" - SalesHeader.Amount)) AND
            //((SalesHeader."Amount Including VAT" - SalesHeader.Amount) <= (SalesHeader."Doc. Amount VAT" + APIInterfaceSetup2."Order Val. Tolerance Amt")))
            if not (((SalesHeader."Doc. Amount VAT FND" - SourceSystemIdentifierAPI."Order Val. Tolerance Amt") <= (SalesHeader."Amount Including VAT" - SalesHeader.Amount)) and
              ((SalesHeader."Amount Including VAT" - SalesHeader.Amount) <= (SalesHeader."Doc. Amount VAT FND" + SourceSystemIdentifierAPI."Order Val. Tolerance Amt")))
            //HEI.03<<
            then
                ERROR(AmountValidationFailedErr, SalesHeader."No.", SalesHeader."Source System Identifier FND");
        end;

        // Release / Approval
        //HEI.03>>
        if SourceSystemIdentifierAPI."Automatic SO Posting" then begin
            //Save lines before Release
            TempSalesLine.RESET;
            SalesLine3.SETRANGE("Document Type", SalesHeader."Document Type");
            SalesLine3.SETRANGE("Document No.", SalesHeader."No.");
            SalesLine3.SETAUTOCALCFIELDS(); //HEI.19
            if SalesLine3.FINDSET then
                repeat
                    TempSalesLine.INIT;
                    TempSalesLine.TRANSFERFIELDS(SalesLine3);
                    TempSalesLine.INSERT;
                until SalesLine3.NEXT = 0;

            // SHUKLP03 >>
            //HEI.04>>

            IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN
                IF SalesHeader."Requested Delivery Date" = 0D THEN
                    SalesHeader.VALIDATE("Requested Delivery Date", SalesHeader."Shipment Date");
            //HEI.04<<
            // SHUKLP03 <<

            //Release

            ReleaseSalesDocument.PerformManualRelease(SalesHeader); //BC Upgrade VAMSIU01 - Blocked as Drinkit dependent Procedure

            //Update lines as before release
            SalesLine4.RESET;
            SalesLine4.SETRANGE("Document Type", SalesHeader."Document Type");
            SalesLine4.SETRANGE("Document No.", SalesHeader."No.");
            SalesLine4.SETAUTOCALCFIELDS(); //HEI.19
            if SalesLine4.FINDSET then
                repeat
                    //HEI.15>>
                    //TempSalesLine.SETRANGE("Line No.",SalesLine4."Line No.");
                    //IF TempSalesLine.FINDFIRST THEN BEGIN
                    if TempSalesLine.GET(SalesLine4."Document Type", SalesLine4."Document No.", SalesLine4."Line No.") then begin
                        //HEI.15<<
                        SalesLine4.Quantity := TempSalesLine.Quantity;
                        SalesLine4."Unit Price" := TempSalesLine."Unit Price";
                        SalesLine4.Amount := TempSalesLine.Amount;
                        SalesLine4."Amount Including VAT" := TempSalesLine."Amount Including VAT";
                        SalesLine4."VAT Base Amount" := TempSalesLine."VAT Base Amount";
                        SalesLine4."Line Amount" := TempSalesLine."Line Amount";
                        SalesLine4."Outstanding Amount" := TempSalesLine."Outstanding Amount";
                        SalesLine4."Outstanding Amount (LCY)" := TempSalesLine."Outstanding Amount (LCY)";
                        SalesLine4.MODIFY;
                    end else
                        SalesLine4.DELETE;
                until SalesLine4.NEXT = 0;
        end else
            //HEI.03<<
            if APIInterfaceSetup2."Automatic Release/SendApproval" then begin
                if not SalesHeader.SalesLinesExist then
                    ERROR(NothingToApproveErr);
                COMMIT; //HEI.19>>
                if not ApprovalsMgmt.IsSalesApprovalsWorkflowEnabled(SalesHeader) then begin
                    //ReleaseSalesDocument.DocStatusRelease(SalesHeader, SalesHeader); //BC Upgrade VAMSIU01 - Blocked as Drinkit dependent Procedure
                end else begin
                    ApprovalsMgmt.OnSendSalesDocForApproval(SalesHeader);
                end;
                COMMIT; //HEI.19>>
            end;

        OnAfterCreateSalesDocument(SalesHeader); //HEI.02

        //HEI.03>>
        if SourceSystemIdentifierAPI."Post Diff to G/L Account" then begin
            if SourceSystemIdentifierAPI."G/L Difference Account" = '' then
                exit;
            SalesHeader.TESTFIELD(Status, SalesHeader.Status::Released);
            InsertDifferenceGLAccLine(SalesHeader, SourceSystemIdentifierAPI."Order Val. Tolerance Amt", SourceSystemIdentifierAPI."G/L Difference Account");
            SalesHeader.FIND;
            if SalesHeader.Status <> SalesHeader.Status::Released then begin
                ReleaseSalesDocument.PerformManualRelease(SalesHeader); //BC Upgrade SHUKLP03

                PriceChanged := true;//HEI.22
            end;
        end;
        //HEI.03<<

        //HEI.09>>

        if SourceSystemIdentifierAPI."Automatic SO Posting" then begin
            if (SalesHeader."Posting Date" <> OrderDate) or (SalesHeader."Shipment Date" <> OrderDate) or (SalesHeader."Requested Delivery Date" <> OrderDate) then begin//HEI.22
                if SalesHeader.Status <> SalesHeader.Status::Open then begin
                    HNKBCU.IsAutomaticReopen(true);

                    ReleaseSalesDocument.Reopen(SalesHeader);
                end;

                SalesHeader.VALIDATE("Requested Delivery Date", OrderDate);
                SalesHeader.VALIDATE("Shipment Date", OrderDate);
                SalesHeader.VALIDATE("Posting Date", OrderDate);

                if SalesHeader.Status <> SalesHeader.Status::Released then
                    ReleaseSalesDocument.PerformManualRelease(SalesHeader); //BC Upgrade SHUKLP03 <<

                PriceChanged := true;//HEI.22
            end;
            //HEI.22>>
            TempSalesLine.RESET;
            if PriceChanged and (not TempSalesLine.ISEMPTY) then begin
                SalesLine4.RESET;
                SalesLine4.SETRANGE("Document Type", SalesHeader."Document Type");
                SalesLine4.SETRANGE("Document No.", SalesHeader."No.");
                SalesLine4.SETFILTER(Type, '%1|%2', SalesLine4.Type::"Charge (Item)", SalesLine4.Type::Item);
                SalesLine4.SETAUTOCALCFIELDS();
                if SalesLine4.FINDSET then
                    repeat
                        if TempSalesLine.GET(SalesLine4."Document Type", SalesLine4."Document No.", SalesLine4."Line No.") then begin
                            SalesLine4.Quantity := TempSalesLine.Quantity;
                            SalesLine4."Unit Price" := TempSalesLine."Unit Price";
                            SalesLine4.Amount := TempSalesLine.Amount;
                            SalesLine4."Amount Including VAT" := TempSalesLine."Amount Including VAT";
                            SalesLine4."VAT Base Amount" := TempSalesLine."VAT Base Amount";
                            SalesLine4."Line Amount" := TempSalesLine."Line Amount";
                            SalesLine4."Outstanding Amount" := TempSalesLine."Outstanding Amount";
                            SalesLine4."Outstanding Amount (LCY)" := TempSalesLine."Outstanding Amount (LCY)";
                            SalesLine4.MODIFY;
                        end else
                            SalesLine4.DELETE;
                    until SalesLine4.NEXT = 0;
            end;
            //HEI.22<<
            //HEI.08>>
            if APIInterfaceLog2.Manual then
                APIInterfaceLog2.ReprocessPosting(true);
            //HEI.08<<
        end;
        //HEI.09

        //HEI.12>>
        CLEAR(RequestXmlDocument);
        CLEAR(OrderXmlNode);
        CLEAR(TempXmlNode);
        CLEAR(LinesXmlNodeList);
        CLEAR(LineXmlNode);
        //HEI.12<<
        CLEAR(RequestInStream); //HEI.13

    end;

    // end;

    local procedure CreateSalesSimulation();
    var
        ApiInterfaceSetup: Record "API Interface Setup2 INT";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Currency: Record Currency;
        APIInterfaceSetup2: Record "API Interface Setup2 INT";
        ReleaseSalesDocument: Codeunit "Release Sales Document";
        RequestInStream: InStream;

        // BC Upgrade VAMSIU01 - Dotnet blocked and added new >>

        // RequestXmlDocument: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        // OrderXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // TempXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // LinesXmlNodeList: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeList";
        // LineXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";

        RequestXmlDocument: XmlDocument;
        OrderXmlNode: XmlNode;
        TempXmlNode: XmlNode;
        LinesXmlNodeList: XmlNodeList;
        LineXmlNode: XmlNode;
        RequestOutStream: OutStream;
        RequestXml: Codeunit "Temp Blob";
        // BC Upgrade VAMSIU01 - Dotnet blocked and added new >>

        Sequence: Integer;
        TempDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        TempDate: Date;
        TempType: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        TempDecimal: Decimal;
        IsGift: Boolean;
        OrderDate: Date;
    begin
        //HEI.21
        APIInterfaceLog2.CALCFIELDS("Request File");
        // BC Upgrade VAMSIU01 - >>
        APIInterfaceLog2."Request File".CREATEINSTREAM(RequestInStream);

        //RequestXml.CreateInStream(RequestInStream);
        //APIInterfaceLog2."Request File".CreateOutStream(RequestOutStream);
        //CopyStream(RequestOutStream, RequestInStream);
        // RequestXmlDocument := RequestXmlDocument.XmlDocument;
        // RequestXmlDocument.Load(RequestInStream);
        RequestXmlDocument := XmlDocument.Create();
        XmlDocument.ReadFrom(RequestInStream, RequestXmlDocument);
        // BC Upgrade VAMSIU01 - <<

        // BC Upgrade VAMSIU01 - >>
        // OrderXmlNode := RequestXmlDocument.SelectSingleNode('/msg/payload/salesOrder');
        // if ISNULL(OrderXmlNode) then
        if not RequestXmlDocument.SelectSingleNode('/msg/payload/salesOrder', OrderXmlNode) then
            ERROR(MissingNodeErr, 'salesOrder');
        // BC Upgrade VAMSIU01 - <<

        SalesHeader.INIT;
        // BC Upgrade VAMSIU01 - >>
        // TempXmlNode := OrderXmlNode.SelectSingleNode('documentType');
        // if not ISNULL(TempXmlNode) then begin
        //     if TempXmlNode.InnerText <> '' then begin
        if OrderXmlNode.SelectSingleNode('documentType', TempXmlNode) then begin
            if TempXmlNode.AsXmlElement().InnerText <> '' then begin
                //if not EVALUATE(TempDocumentType, TempXmlNode.InnerText) then
                if not EVALUATE(TempDocumentType, TempXmlNode.AsXmlElement().InnerText()) then
                    // BC Upgrade VAMSIU01 - <<
                    ERROR(BadNodeValueErr, 'documentType');
                SalesHeader."Document Type" := TempDocumentType;
            end else begin
                SalesHeader."Document Type" := SalesHeader."Document Type"::Quote;
            end;
        end else begin
            SalesHeader."Document Type" := SalesHeader."Document Type"::Quote;
        end;

        APIInterfaceSetup2.GET;
        APIInterfaceSetup2.TESTFIELD("Default Document Subtype Code");
        SalesHeader.VALIDATE("Document Subtype Code FND", APIInterfaceSetup2."Default Document Subtype Code"); //BC Upgrade SHUKLP03
        SalesHeader."Source System Identifier FND" := APIInterfaceLog2."Source System Identifier";

        // BC Upgrade VAMSIU01 - >>
        // TempXmlNode := OrderXmlNode.SelectSingleNode('id');
        // if not ISNULL(TempXmlNode) then
        //     if TempXmlNode.InnerText <> '' then
        //         APIInterfaceLog2."Order ID" := TempXmlNode.InnerText;
        if OrderXmlNode.SelectSingleNode('id', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                APIInterfaceLog2."Order ID" := TempXmlNode.AsXmlElement().InnerText();
        // BC Upgrade VAMSIU01 - >>
        GetNodeByXPath('OrderNo', 'OrderNo', OrderXmlNode, TempXmlNode);

        // Update fields on API Log
        APIInterfaceLog2."Source Type" := DATABASE::"Sales Header";
        APIInterfaceLog2."Source Subtype" := SalesHeader."Document Type".AsInteger();
        APIInterfaceLog2.MODIFY;
        COMMIT; // NOTE: NO DB WRITE BEFORE THIS COMMIT, EXCEPT ON API INTERFACE LOG

        SalesHeader.INSERT(true);


        GetNodeByXPath('CustomerNo', 'CustomerNo', OrderXmlNode, TempXmlNode);
        // BC Upgrade VAMSIU01 >>
        // SalesHeader.VALIDATE("Sell-to Customer No.", TempXmlNode.InnerText);  // Block validation 
        SalesHeader.VALIDATE("Sell-to Customer No.", TempXmlNode.AsXmlElement().InnerText());
        // BC Upgrade VAMSIU01 <<

        APIInterfaceLog2."Source No." := SalesHeader."No.";

        APIInterfaceLog2.MODIFY;

        GetNodeByXPath('deliveryDate', 'deliveryDate', OrderXmlNode, TempXmlNode);

        // BC Upgrade VAMSIU01 >>
        // if not EVALUATE(TempDate, TempXmlNode.InnerText, 9) then
        //     ERROR(BadNodeValueErr, 'deliveryDate');
        if not Evaluate(TempDate, TempXmlNode.AsXmlElement().InnerText()) then
            Error(BadNodeValueErr, 'deliveryDate');
        // BC Upgrade VAMSIU01 <<
        OrderDate := TempDate;
        SalesHeader.VALIDATE("Order Date", TempDate);
        SalesHeader."Posting Date" := TempDate;
        SalesHeader."Document Date" := TempDate;

        // BC Upgrade VAMSIU01 >>
        // TempXmlNode := OrderXmlNode.SelectSingleNode('OrderNo');
        // if not ISNULL(TempXmlNode) then
        //     if TempXmlNode.InnerText <> '' then
        //         SalesHeader."External Document No." := TempXmlNode.InnerText;
        if OrderXmlNode.SelectSingleNode('OrderNo', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                SalesHeader."External Document No." := TempXmlNode.AsXmlElement().InnerText();
        // BC Upgrade VAMSIU01 <<

        SalesHeader.MODIFY(true);

        if SalesHeader."Currency Code" <> '' then
            Currency.GET(SalesHeader."Currency Code")
        else
            Currency.InitRoundingPrecision();

        // BC Upgrade VAMSIU01 >>
        // LinesXmlNodeList := OrderXmlNode.SelectNodes('lines/lineItems');
        // if ISNULL(LinesXmlNodeList) then
        // ERROR(MissingNodeErr, 'line');
        if not OrderXmlNode.SelectNodes('lines/lineItems', LinesXmlNodeList) then
            ERROR(MissingNodeErr, 'line');
        // BC Upgrade VAMSIU01 <<

        foreach LineXmlNode in LinesXmlNodeList do begin
            IsGift := false;
            // BC Upgrade VAMSIU01 >>
            // TempXmlNode := LineXmlNode.SelectSingleNode('isGift');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         if not EVALUATE(IsGift, TempXmlNode.InnerText, 9) then
            //             ERROR(BadNodeValueErr, 'isGift');
            if LineXmlNode.SelectSingleNode('isGift', TempXmlNode) then
                if TempXmlNode.AsXmlElement().InnerText() <> '' then
                    if not Evaluate(IsGift, TempXmlNode.AsXmlElement().InnerText(), 9) then
                        Error(BadNodeValueErr, 'isGift');
            // BC Upgrade VAMSIU01 <<

            Sequence += 10000;
            SalesLine.SetSalesHeader(SalesHeader); //BC Upgrade VAMSIU01 >>
            SalesLine.INIT;
            SalesLine."Document Type" := SalesHeader."Document Type";
            SalesLine."Document No." := SalesHeader."No.";
            SalesLine."Line No." := Sequence;
            SalesLine.INSERT(true);

            SalesLine.Type := SalesLine.Type::Item;
            GetNodeByXPath('materialKey', 'materialKey', LineXmlNode, TempXmlNode);  // Block validation
            //SalesLine.VALIDATE("No.", TempXmlNode.InnerText); // BC Upgrade VAMSIU01
            SalesLine.VALIDATE("No.", TempXmlNode.AsXmlElement().InnerText()); // BC Upgrade VAMSIU01

            // BC Upgrade VAMSIU01 >>
            // TempXmlNode := LineXmlNode.SelectSingleNode('unitOfMeasure');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         if ItemUnitofMeasure.GET(SalesLine."No.", TempXmlNode.InnerText) then
            //             SalesLine.VALIDATE("Unit of Measure Code", TempXmlNode.InnerText);
            if LineXmlNode.SelectSingleNode('unitOfMeasure', TempXmlNode) then
                if TempXmlNode.AsXmlElement().InnerText() <> '' then
                    if ItemUnitofMeasure.Get(SalesLine."No.", TempXmlNode.AsXmlElement().InnerText()) then
                        SalesLine.Validate("Unit of Measure Code", TempXmlNode.AsXmlElement().InnerText());
            // BC Upgrade VAMSIU01 <<

            GetNodeByXPath('quantityOrdered', 'quantityOrdered', LineXmlNode, TempXmlNode);
            //if not EVALUATE(TempDecimal, TempXmlNode.InnerText, 9) then // BC Upgrade VAMSIU01
            if not Evaluate(TempDecimal, TempXmlNode.AsXmlElement().InnerText(), 9) then // BC Upgrade VAMSIU01
                ERROR(BadNodeValueErr, 'quantityOrdered');
            SalesLine.VALIDATE(Quantity, TempDecimal);
            if IsGift then begin
                // BC Upgrade SHUKLP03 >>
                ApiInterfaceSetup.get();
                If ApiInterfaceSetup."Gift Reason Code" <> '' then
                    SalesLine."Reason Code 101FDW" := ApiInterfaceSetup."Gift Reason Code";
                // BC Upgrade SHUKLP03 <<

                // SalesLine."Line Discount %" := 100;
                // BC Upgrade SHUKLP03 >> Obsolete Drinkit fields
                // SalesLine."Extra Charge Type" := SalesLine."Extra Charge Type"::Amount;
                // SalesLine."Item Charge Discount %" := 100;
                // SalesLine."Item Charge Type" := SalesLine."Item Charge Type"::Promotion;
                // SalesLine."Free Item" := true;
                // SalesLine."Free Quantity" := SalesLine.Quantity;
                // SalesLine."Maximum Free Quantity" := SalesLine.Quantity;
                // BC Upgrade SHUKLP03 << Obsolete Drinkit fields
            end;
            SalesLine.MODIFY(true);
        end;

        //SalesHeader.FIND; //BC Upgrade VAMSIU01
        // if SalesHeader.Status <> SalesHeader.Status::Released then //BC Upgrade VAMSIU01
        ReleaseSalesDocument.PerformManualRelease(SalesHeader); //BC Upgrade VAMSIU01 - Blocked as Drinkit Dependent procedure DocStatusRelease.
        CalculateTransportCost(SalesHeader); //BC Upgrade VAMSIU01
        ExcludeItemCharges(SalesHeader); //BC Upgrade VAMSIU01
        CLEAR(RequestXmlDocument);
        CLEAR(OrderXmlNode);
        CLEAR(TempXmlNode);
        CLEAR(LinesXmlNodeList);
        CLEAR(LineXmlNode);
        CLEAR(RequestInStream);
    end;

    //BC Upgrade VAMSIU01 - Blocked and added new with Saas compatible >>
    // local procedure GetNodeByXPath(XPath: Text; NodeName: Text; var ParentXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; var XmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode");
    // begin
    //     XmlNode := ParentXmlNode.SelectSingleNode(XPath); // Mandatory
    //     if ISNULL(XmlNode) then
    //         ERROR(MissingNodeErr, NodeName);
    //     if XmlNode.InnerText = '' then
    //         ERROR(TextMissingErr, NodeName);
    // end;

    local procedure GetNodeByXPath(XPath: Text; NodeName: Text; var ParentXmlNode: XmlNode; var ResultXmlNode: XmlNode)
    begin
        if ParentXmlNode.SelectSingleNode(XPath, ResultXmlNode) then
            if not ResultXmlNode.IsXmlElement() then
                Error(MissingNodeErr, NodeName);

        if ResultXmlNode.AsXmlElement().InnerText() = '' then
            Error(TextMissingErr, NodeName);
    end;
    //BC Upgrade VAMSIU01 - Blocked and added new with Saas compatible <<

    local procedure InsertDifferenceGLAccLine(SalesHeader: Record "Sales Header"; MaxDiffAmount: Decimal; DiffGLAccount: Code[20]);
    var
        ReleaseSalesDocument: Codeunit "Release Sales Document";
        HNKBCU: Codeunit "Heineken BC Upgrade";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        SalesLine: Record "Sales Line";
        MaxOrderDiffAmtLCY: Decimal;
        DiffUnitPrice: Decimal;
        Error001: Label 'The Difference between the Doc. Amount Incl VAT %1 and Total Amount incl VAT %2 is bigger than the allowed limit %3!';
        Currency: Record Currency;
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        //HEI.03>>
        CLEAR(MaxOrderDiffAmtLCY);
        if SalesHeader."Currency Code" <> '' then begin
            CurrencyExchangeRate.RESET;
            CurrencyExchangeRate.SETRANGE("Currency Code", SalesHeader."Currency Code");
            CurrencyExchangeRate.SETFILTER("Starting Date", '<=%1', TODAY);
            if CurrencyExchangeRate.FINDLAST then
                MaxOrderDiffAmtLCY := MaxDiffAmount / CurrencyExchangeRate."Relational Exch. Rate Amount";
        end else
            MaxOrderDiffAmtLCY := MaxDiffAmount;

        GeneralLedgerSetup.GET;
        if SalesHeader."Currency Code" <> '' then
            Currency.GET(SalesHeader."Currency Code")
        else
            Currency.GET(GeneralLedgerSetup."LCY Code");

        if (SalesHeader."Doc. Amount Incl. VAT FND" <> 0) and (SalesHeader."Doc. Amount VAT FND" <> 0) then begin
            SalesHeader.CALCFIELDS("Amount Including VAT", Amount);
            if ROUND(ABS((SalesHeader."Doc. Amount Incl. VAT FND" - SalesHeader."Amount Including VAT")), Currency."Amount Rounding Precision") > 0 then
                if ROUND(ABS((SalesHeader."Doc. Amount Incl. VAT FND" - SalesHeader."Amount Including VAT")), Currency."Amount Rounding Precision") <= MaxOrderDiffAmtLCY then begin
                    DiffUnitPrice := ROUND(GetAditionalAmountExclAmt(SalesHeader."Doc. Amount Incl. VAT FND" - SalesHeader."Amount Including VAT", SalesHeader."VAT Bus. Posting Group", DiffGLAccount), Currency."Amount Rounding Precision");
                    HNKBCU.IsAutomaticReopen(true);
                    ReleaseSalesDocument.Reopen(SalesHeader);
                    SalesLine.INIT;
                    SalesLine.VALIDATE("Document Type", SalesHeader."Document Type");
                    SalesLine.VALIDATE("Document No.", SalesHeader."No.");
                    SalesLine.VALIDATE("Line No.", 1);
                    SalesLine.INSERT(true);
                    SalesLine.VALIDATE(Type, SalesLine.Type::"G/L Account");
                    SalesLine.VALIDATE("No.", DiffGLAccount);
                    SalesLine.VALIDATE(Quantity, 1);
                    SalesLine.VALIDATE("Unit Price", DiffUnitPrice);
                    SalesLine.MODIFY(true);
                end else
                    ERROR(AmountValidationFailedErr, SalesHeader."No.", SalesHeader."Source System Identifier FND");
        end;
        //HEI.03<<
    end;

    local procedure GetAditionalAmountExclAmt(AmountInclVAT: Decimal; VATBusPostGroup: Code[10]; DiffGLAccount: Code[20]): Decimal;
    var
        GLAccount: Record "G/L Account";
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        //HEI.03>>
        GLAccount.GET(DiffGLAccount);
        if VATPostingSetup.GET(VATBusPostGroup, GLAccount."VAT Prod. Posting Group") then
            exit(AmountInclVAT / (1 + (VATPostingSetup."VAT %" / 100)))
        else
            exit(AmountInclVAT);
        //HEI.03<<
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCreateSalesDocument(SalesHeader: Record "Sales Header");
    begin
        //HEI.02>>
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnBeforeValidateEvent', 'Qty. to Ship', false, false)]
    local procedure OnBeforeValidateQtyToShip(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer);
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
    begin
        //HEI.03>>
        if Rec.ISTEMPORARY then
            exit;

        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        if SalesHeader."Source System Identifier FND" = '' then
            exit;

        if SourceSystemIdentifierAPI.GET(SalesHeader."Source System Identifier FND") then begin
            if not SourceSystemIdentifierAPI."Apply Sales Condit Interface" then
                exit;

            if not SourceSystemIdentifierAPI."Automatic SO Posting" then
                exit;

            SalesLine.SETRANGE("Document Type", Rec."Document Type");
            SalesLine.SETRANGE("Document No.", Rec."Document No.");
            SalesLine.SETRANGE("Attached to Line No.", Rec."Line No.");
            if SalesLine.FINDSET then
                repeat
                    if SalesLine."Attached to Line No." = 0 then
                        exit;
                    //BC Upgrade VAMSIU01 - Blocked as Drinkit dependent field(2013662 - Is Item charge) >>
                    if not SalesLine."Has Item Charge 101FDW" then // BC Upgrade SHUKLP03 <<
                        exit;
                    //BC Upgrade VAMSIU01 - Blocked as Drinkit dependent field(2013662 - Is Item charge) <<

                    if SalesLine.Type <> SalesLine.Type::"Charge (Item)" then
                        exit;

                    if SalesLine."Qty. to Ship" <> 0 then
                        exit;

                    if SalesLine."Quantity Shipped" <> 0 then
                        exit;

                    SalesLine.VALIDATE("Qty. to Ship", SalesLine.Quantity);
                    SalesLine.VALIDATE("Qty. to Invoice", SalesLine.Quantity);
                    SalesLine.VALIDATE("Qty. to Assign", SalesLine.Quantity);

                    SalesLine.MODIFY;
                until SalesLine.NEXT = 0;
        end;
        //HEI.03<<
    end;

    procedure CreateSalesReturnOrder(): Code[20];
    var
        RequestInStream: InStream;
        // BC Upgrade VAMSIU01 >>
        // RequestXmlDocument: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        // OrderXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // TempXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        RequestXmlDocument: XmlDocument;
        OrderXmlNode: XmlNode;
        TempXmlNode: XmlNode;
        RequestOutStream: OutStream;
        RequestXml: Codeunit "Temp Blob";
        // BC Upgrade VAMSIU01 <<
        MissingNodeErr: Label '%1 node missing from XML';
        SalesHeader: Record "Sales Header";
        SalesHeader2: Record "Sales Header";
        ToSalesOrderHeader: Record "Sales Header";
        //SalesOrderToReturnOrder: Codeunit "Create Sales Ret.Order"; // BC Upgrade VAMSIU01 - Blocked as Drinkit dependent Codeunit(CU - 2013614)
        SalesShipmentHeader: Record "Sales Shipment Header";
        ReturnReceiptHeader: Record "Return Receipt Header";
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        LinkedSalesDocNo: Code[20];
        DITSalesHook: Codeunit SalesHook101FDW;
    begin
        SourceSystemIdentifierAPI.GET(APIInterfaceLog2."Source System Identifier");

        // BC Upgrade VAMSIU01 >>

        APIInterfaceLog2."Request File".CREATEINSTREAM(RequestInStream); // BC Upgrade SHUKLP03 <<
                                                                         // RequestXmlDocument := RequestXmlDocument.XmlDocument;
                                                                         // RequestXmlDocument.Load(RequestInStream);

        // OrderXmlNode := RequestXmlDocument.SelectSingleNode('/msg/payload/order');
        // if ISNULL(OrderXmlNode) then
        //     ERROR(MissingNodeErr, 'order');

        // TempXmlNode := OrderXmlNode.SelectSingleNode('LinkedSalesDocNo');
        // if not ISNULL(TempXmlNode) then
        //     if TempXmlNode.InnerText <> '' then
        //         LinkedSalesDocNo := TempXmlNode.InnerText;

        // BC Upgrade SHUKLP03 >> Not working
        // RequestXml.CreateInStream(RequestInStream);
        // APIInterfaceLog2."Request File".CreateOutStream(RequestOutStream);
        // CopyStream(RequestOutStream, RequestInStream);
        // BC Upgrade SHUKLP03 << Not working
        RequestXmlDocument := XmlDocument.Create();
        XmlDocument.ReadFrom(RequestInStream, RequestXmlDocument);

        if not RequestXmlDocument.SelectSingleNode('/msg/payload/order', OrderXmlNode) then
            Error(MissingNodeErr, 'order');

        if OrderXmlNode.SelectSingleNode('LinkedSalesDocNo', TempXmlNode) then
            if TempXmlNode.AsXmlElement().InnerText() <> '' then
                LinkedSalesDocNo := TempXmlNode.AsXmlElement().InnerText();
        // BC Upgrade VAMSIU01 <<

        if LinkedSalesDocNo = '' then
            exit('')
        else begin
            SalesHeader.RESET;
            SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
            if not SourceSystemIdentifierAPI."Use Default S. Order Nos" then
                SalesHeader.SETRANGE("No.", LinkedSalesDocNo)
            else
                SalesHeader.SETRANGE("External Document No.", LinkedSalesDocNo);
            if not SalesHeader.FINDFIRST then begin
                if not SourceSystemIdentifierAPI."Use Default S. Order Nos" then
                    SalesShipmentHeader.SETRANGE("Order No.", LinkedSalesDocNo)
                else
                    SalesShipmentHeader.SETRANGE("External Document No.", LinkedSalesDocNo);
                if not SalesShipmentHeader.FINDFIRST then
                    exit('');
            end else begin
                SalesHeader2.RESET;
                SalesHeader2.SETRANGE("Document Type", SalesHeader2."Document Type"::"Return Order");
                // BC Upgrade VAMSIU01 - Blocked as Drinkit dependent field(2013613-Link Sales Document No.) >>
                if not SourceSystemIdentifierAPI."Use Default S. Order Nos" then
                    SalesHeader2.SETRANGE("No.", LinkedSalesDocNo)
                else begin
                    SalesHeader2.SETRANGE("External Document No.", LinkedSalesDocNo);
                    SalesHeader2.SETFILTER("No.", '<>%1', '');
                end;
                // BC Upgrade VAMSIU01 - Blocked as Drinkit dependent field(2013613-Link Sales Document No.) <<
                if SalesHeader2.FINDFIRST then
                    exit('')
                else begin
                    // BC Upgrade VAMSIU01 - Blocked as Drinkit dependent field(2013613-Link Sales Document No.) >>
                    if not SourceSystemIdentifierAPI."Use Default S. Order Nos" then
                        ReturnReceiptHeader.SETRANGE("No.", LinkedSalesDocNo)
                    else begin
                        ReturnReceiptHeader.SETRANGE("External Document No.", LinkedSalesDocNo);
                        ReturnReceiptHeader.SETFILTER("No.", '<>%1', '');
                        // BC Upgrade VAMSIU01 - Blocked as Drinkit dependent field(2013613-Link Sales Document No.) <<
                    end;
                    if ReturnReceiptHeader.FINDFIRST then
                        exit('')
                    else begin
                        //Create Sales Return Order
                        if not SourceSystemIdentifierAPI."Use Default S. Order Nos" then begin
                            APIInterfaceLog2."Source No." := LinkedSalesDocNo;
                            APIInterfaceLog2.MODIFY;
                        end;
                        // BC Upgrade VAMSIU01 - Blocked as Drinkit dependent Codeunit(CU - 2013614) >>
                        // SalesOrderToReturnOrder.RUN(SalesHeader);
                        // SalesOrderToReturnOrder.GetSalesOrderHeader(ToSalesOrderHeader);
                        DITSalesHook.CreateSalesHeader(SalesHeader, ToSalesOrderHeader); // BC Upgrade SHUKLP03 <<
                        // CreateSROLines(SalesHeader);
                        // BC Upgrade VAMSIU01 - Blocked as Drinkit dependent Codeunit(CU - 2013614) >>
                        if ToSalesOrderHeader.FIND then begin
                            if SourceSystemIdentifierAPI."Use Default S. Order Nos" then begin
                                APIInterfaceLog2."Source No." := ToSalesOrderHeader."No.";
                                APIInterfaceLog2.MODIFY;
                            end;
                            if SourceSystemIdentifierAPI."Use Default S. Order Nos" then begin //HEI.04
                                ToSalesOrderHeader."External Document No." := APIInterfaceLog2."Message ID";
                                ToSalesOrderHeader.MODIFY;
                            end; //HEI.04
                            exit(ToSalesOrderHeader."No.");
                        end;
                    end;
                end;
            end;
        end;
    end;

    local procedure GetDimensionLocationMapping(LocationCode: Code[10]);
    var
        LocationMappingCP: Record "Location Mapping CP FND";
    begin
        //HEI.03>>
        CLEAR(CCCDimensionCode);
        CLEAR(CCCDimensionValue);

        LocationMappingCP.SETRANGE("Location Code", LocationCode);
        if LocationMappingCP.FINDFIRST then begin
            CCCDimensionCode := LocationMappingCP."CCC Dimension";
            CCCDimensionValue := LocationMappingCP."CCC Dimension Value";
        end;
        //HEI.03<<
    end;

    local procedure ExcludeItemCharges(var SalesHeader: Record "Sales Header");
    var
        DOTListPrice: Record "B2B Item Charges Inc./Exc. FND";
        SalesLine: Record "Sales Line";
    begin
        //HEI.21
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::"Charge (Item)");
        DOTListPrice.SETRANGE("Exclude from Total Amount", true);
        if DOTListPrice.FINDSET then
            repeat
                SalesLine.SETRANGE("No.", DOTListPrice."Item Charge No.");
                SalesLine.DELETEALL(false);
            until DOTListPrice.NEXT = 0;
    end;

    local procedure CalculateTransportCost(var SalesHeader: Record "Sales Header");
    var
        DOTListPrice: Record "B2B Item Charges Inc./Exc. FND";
        SalesLine: Record "Sales Line";
        TransportAmount: Decimal;
    begin
        //HEI.21
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::"Charge (Item)");
        DOTListPrice.SETRANGE("Include in Transport Amount", true);
        if DOTListPrice.FINDSET(false) then
            repeat
                SalesLine.SETRANGE("No.", DOTListPrice."Item Charge No.");
                if SalesLine.FINDSET(false) then
                    repeat
                        TransportAmount += SalesLine."Amount Including VAT";
                    until SalesLine.NEXT = 0;
            until DOTListPrice.NEXT = 0;
        if TransportAmount > 0 then begin
            SalesHeader."Doc. Amount Incl. VAT FND" := TransportAmount;
            SalesHeader.MODIFY;
        end;
    end;
}

