codeunit 58114 "API Order Status Mgmt."
{
    // version HEI.06

    // HEI.01 FDD-HB1234 - CHG2053453 IBM NASTAA02 11.03.2021 # B2B Order Status
    //   # New Codeunit created for API Order Status
    // HEI.02 INC3545614 - CHG2115232 IBM NASTAA02 18.06.2021 # HeiLite Order status is not sent correctly to B2B
    //   # Code added in "ProcessSalesOrderStatusRequest" function
    // HEI.03 HB2615 - CHG2139668 IBM NASTAA02 13.01.2022 # New Order Status in the existing Order Status API
    //   # Code added in "ProcessSalesOrderStatusRequest" function
    //   # New function created "ApprovalEntryExists"
    // HEI.04 INC3927503 - CHG2142816 IBM NASTAA02 17.01.2022 # Order Status API setting as cancelled shipped+invoiced orders instead on the way
    //   # Code added in "ProcessSalesOrderStatusRequest" function to get exclusive access to the table and read the correct values
    // HEI.05 INC4083000 - CHG2156647 IBM NASTAA02 03.05.2022 # NAS Service consuming high memory
    //   # Clear variables after Webservice call

    // BC Upgrade VAMSIU01 >>

    // # Old id 50148
    // # Blocked Dotnet variables and new Saas Compatible variables
    // # Replaced TempXmlNode.InnerText with TempXmlNode.AsXmlElement().Innertext()
    // # Blocked and added new Procedure for GetNodeByXPath with Saas compatible code 

    // BC Upgrade VAMSIU01 <<

    // BC Upgrade MISHRS14 >>
    // Changed table name to "API Order Status Mapping FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    // BC Upgrade SHUKLP03 >> Modified instream code.


    TableNo = "API Interface Log2 INT";

    trigger OnRun();
    begin
        APIInterfaceLog := Rec;
        case APIInterfaceLog.Entity of
            'SALES':
                begin
                    case APIInterfaceLog.Operation of
                        'READ':
                            begin
                                ProcessSalesOrderStatusRequest;
                            end;
                    end;
                end;
        end;

        Rec := APIInterfaceLog;
    end;

    var
        APIInterfaceLog: Record "API Interface Log2 INT";
        MissingNodeErr: Label '%1 node missing from XML';
        TextMissingErr: Label 'Text missing for node %1 in XML';

    local procedure ProcessSalesOrderStatusRequest();
    var
        APIInterfaceSetup: Record "API Interface Setup2 INT";
        B2BInterfaceSetup: Record "B2B Interface Setup INT";
        RequestInStream: InStream;
        // BC Upgrade VAMSIU01 >>

        // RequestXmlDocument : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        // OrderStatusXmlNode : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // OrderXmlNode : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // TempXmlNode : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // OrderStatusXmlNodeList : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeList";
        RequestXmlDocument: XmlDocument;
        OrderStatusXmlNode: XmlNode;
        OrderXmlNode: XmlNode;
        TempXmlNode: XmlNode;
        OrderStatusXmlNodeList: XmlNodeList;

        // BC Upgrade VAMSIU01 >>
        TempOrderID: Text[50];
        TempSourceSystem: Code[10];
        TempStatus: Text[50];
        SalesShipmentHeader: Record "Sales Shipment Header";
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        SalesHeader: Record "Sales Header";
        APIInterfaceLog2: Record "API Interface Log2 INT";
        SalesHeaderArchive: Record "Sales Header Archive";
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        APIOrderStatusMapping: Record "API Order Status Mapping FND";
        SalesHeaderRecRef: RecordRef;
    begin
        APIInterfaceSetup.GET;
        APIInterfaceLog."Request File".CREATEINSTREAM(RequestInStream);

        // BC Upgrade VAMSIU01 >>
        // RequestXmlDocument := RequestXmlDocument.XmlDocument;
        // RequestXmlDocument.Load(RequestInStream);
        RequestXmlDocument := XmlDocument.Create();  // BC Upgrade SHUKLP03 <<
        XmlDocument.ReadFrom(RequestInStream, RequestXmlDocument);
        // BC Upgrade VAMSIU01 <<

        // BC Upgrade VAMSIU01 >>
        // OrderStatusXmlNode := RequestXmlDocument.SelectSingleNode('/OrderStatus/Order');
        // if ISNULL(OrderStatusXmlNode) then
        //   ERROR(MissingNodeErr,'Order');

        // OrderStatusXmlNodeList := OrderStatusXmlNode.SelectNodes('/OrderStatus/Order');
        // if ISNULL(OrderStatusXmlNodeList) then
        //   ERROR(MissingNodeErr,'Order');

        if not RequestXmlDocument.SelectSingleNode('/OrderStatus/Order', OrderStatusXmlNode) then
            Error(MissingNodeErr, 'Order');

        if not OrderStatusXmlNode.SelectNodes('/OrderStatus/Order', OrderStatusXmlNodeList) then
            Error(MissingNodeErr, 'Order');
        // BC Upgrade VAMSIU01 <<

        foreach OrderXmlNode in OrderStatusXmlNodeList do begin
            TempStatus := '';
            GetNodeByXPath('OrderID', 'OrderID', OrderXmlNode, TempXmlNode);
            //TempOrderID := TempXmlNode.InnerText;// BC Upgrade VAMSIU01
            TempOrderID := TempXmlNode.AsXmlElement().InnerText();// BC Upgrade VAMSIU01

            GetNodeByXPath('SourceSystem', 'SourceSystem', OrderStatusXmlNode, TempXmlNode);
            //TempSourceSystem := TempXmlNode.InnerText;// BC Upgrade VAMSIU01
            TempSourceSystem := TempXmlNode.AsXmlElement().InnerText();// BC Upgrade VAMSIU01

            SourceSystemIdentifierAPI.GET(TempSourceSystem);

            if B2BInterfaceSetup.GET then
                B2BInterfaceSetup.TESTFIELD("Enable B2B Interfaces", true);

            if APIInterfaceLog."Source No." <> '' then
                if B2BInterfaceSetup."Pick-up Shipment Method" <> '' then begin
                    //If order has Shipment and shipment is posted & Actual delivery date is filled: Completed
                    //HEI.04>>
                    SalesShipmentHeader.LOCKTABLE(true);
                    CLEAR(SalesShipmentHeader);
                    //HEI.04<<
                    SalesShipmentHeader.RESET;
                    SalesShipmentHeader.SETRANGE("Order No.", APIInterfaceLog."Source No.");
                    SalesShipmentHeader.SETRANGE("Source System Identifier FND", APIInterfaceLog."Source System Identifier");
                    if SalesShipmentHeader.FINDFIRST then begin
                        if (SalesShipmentHeader."Actual Delivery Date FND" <> 0D) and
                            (SalesShipmentHeader."Shipment Method Code" <> B2BInterfaceSetup."Pick-up Shipment Method")
                        then begin
                            APIOrderStatusMapping.RESET;
                            APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Shipment);
                            APIOrderStatusMapping.SETRANGE("Status Field 1", 'Posted');
                            APIOrderStatusMapping.SETRANGE("Status Field 2", 'Completed');
                            if APIOrderStatusMapping.FINDFIRST then
                                TempStatus := APIOrderStatusMapping.Message;
                        end else begin
                            //If Shipment is posted, but no actual delivery date and shipment method code is not pick-up, then Status: On the way
                            if SalesShipmentHeader."Shipment Method Code" <> B2BInterfaceSetup."Pick-up Shipment Method" then begin
                                APIOrderStatusMapping.RESET;
                                APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Shipment);
                                APIOrderStatusMapping.SETRANGE("Status Field 1", 'Posted');
                                APIOrderStatusMapping.SETRANGE("Status Field 2", 'Blank');
                                if APIOrderStatusMapping.FINDFIRST then
                                    TempStatus := APIOrderStatusMapping.Message;
                            end else begin
                                //If Shipment is posted, but no actual delivery date and shipment method code is pick-up, then Status: Completed
                                APIOrderStatusMapping.RESET;
                                APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Shipment);
                                APIOrderStatusMapping.SETRANGE("Status Field 1", 'Posted');
                                APIOrderStatusMapping.SETRANGE("Status Field 2", 'Completed');
                                if APIOrderStatusMapping.FINDFIRST then
                                    TempStatus := APIOrderStatusMapping.Message;
                            end;
                        end;
                    end else begin
                        //If Shipment is createed (not posted) and shipment method code is Pick-up, then Status is: Ready Pick up
                        WarehouseShipmentHeader.RESET;
                        WarehouseShipmentHeader.SETRANGE("Source Document Type FND", WarehouseShipmentHeader."Source Document Type FND"::"Sales Order");
                        WarehouseShipmentHeader.SETRANGE("Source No. FND", APIInterfaceLog."Source No.");
                        WarehouseShipmentHeader.SETRANGE("Shipment Method Code", B2BInterfaceSetup."Pick-up Shipment Method");
                        if WarehouseShipmentHeader.FINDFIRST then begin
                            APIOrderStatusMapping.RESET;
                            APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Shipment);
                            APIOrderStatusMapping.SETRANGE("Status Field 1", 'Created');
                            APIOrderStatusMapping.SETRANGE("Status Field 2", B2BInterfaceSetup."Pick-up Shipment Method");
                            if APIOrderStatusMapping.FINDFIRST then
                                TempStatus := APIOrderStatusMapping.Message;
                        end else begin
                            //If No Shipment , then check order status
                            //HEI.02>>
                            SalesHeader.LOCKTABLE(true);
                            CLEAR(SalesHeader);
                            SalesHeader.RESET;
                            if SourceSystemIdentifierAPI."Stop Sales RO Status" then
                                SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                            //HEI.02<<
                            SalesHeader.SETRANGE("No.", APIInterfaceLog."Source No.");
                            SalesHeader.SETRANGE("Source System Identifier FND", APIInterfaceLog."Source System Identifier");
                            if SalesHeader.FINDFIRST then begin
                                //If Order status is Released, then Status: Confirmed
                                if SalesHeader.Status = SalesHeader.Status::Released then begin
                                    APIOrderStatusMapping.RESET;
                                    APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Order);
                                    APIOrderStatusMapping.SETRANGE("Status Field 1", 'Released');
                                    APIOrderStatusMapping.SETFILTER("Status Field 2", '%1|%2', 'Not Set', 'Approved');
                                    if APIOrderStatusMapping.FINDFIRST then
                                        TempStatus := APIOrderStatusMapping.Message;
                                end else
                                    //If Order status is Pending Approval, then Status: Pending Approval
                                    if SalesHeader.Status = SalesHeader.Status::"Pending Approval" then begin
                                        APIOrderStatusMapping.RESET;
                                        APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Order);
                                        APIOrderStatusMapping.SETRANGE("Status Field 1", 'Pending Approval');
                                        APIOrderStatusMapping.SETFILTER("Status Field 2", 'Blank');
                                        if APIOrderStatusMapping.FINDFIRST then
                                            TempStatus := APIOrderStatusMapping.Message;
                                    end else
                                        //If Order status is Open, and approval status is Rejected, then Status: Rejected
                                        if (SalesHeader.Status = SalesHeader.Status::Open) and (SalesHeader."Approval Status FND" = SalesHeader."Approval Status FND"::Rejected) then begin
                                            APIOrderStatusMapping.RESET;
                                            APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Order);
                                            APIOrderStatusMapping.SETRANGE("Status Field 1", 'Open');
                                            APIOrderStatusMapping.SETFILTER("Status Field 2", 'Rejected');
                                            if APIOrderStatusMapping.FINDFIRST then
                                                TempStatus := APIOrderStatusMapping.Message;
                                        end else
                                            //If Order is Open and Approval Status is <> Rejected, then Status = Received
                                            if (SalesHeader.Status = SalesHeader.Status::Open) and (SalesHeader."Approval Status FND" <> SalesHeader."Approval Status FND"::Rejected) then begin
                                                //HEI.03>>
                                                //If Order is Open and Approval Status is " ", then Status = Created
                                                if (SalesHeader.Status = SalesHeader.Status::Open) and
                                                   (SalesHeader."Approval Status FND" = SalesHeader."Approval Status FND"::" ") and
                                                   not ApprovalEntryExists(36, SalesHeader."Document Type".AsInteger(), SalesHeader."No.")
                                                then begin
                                                    APIOrderStatusMapping.RESET;
                                                    APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Order);
                                                    APIOrderStatusMapping.SETRANGE("Status Field 1", 'Created');
                                                    APIOrderStatusMapping.SETFILTER("Status Field 2", 'Blank');
                                                    if APIOrderStatusMapping.FINDFIRST then
                                                        TempStatus := APIOrderStatusMapping.Message;
                                                end else begin
                                                    //HEI.03<<
                                                    APIOrderStatusMapping.RESET;
                                                    APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Order);
                                                    APIOrderStatusMapping.SETRANGE("Status Field 1", 'Open');
                                                    APIOrderStatusMapping.SETFILTER("Status Field 2", 'Blank');
                                                    if APIOrderStatusMapping.FINDFIRST then
                                                        TempStatus := APIOrderStatusMapping.Message;
                                                end;
                                            end;
                            end else begin
                                //If Order is not found, then first check the API log for Error, if found then Status: Pending
                                APIInterfaceLog2.RESET; //HEI.02
                                APIInterfaceLog2.SETRANGE("Source No.", APIInterfaceLog."Source No.");
                                APIInterfaceLog2.SETRANGE("Source System Identifier", APIInterfaceLog."Source System Identifier");
                                APIInterfaceLog2.SETRANGE(Entity, 'SALES');
                                APIInterfaceLog2.SETRANGE(Operation, 'CREATE');
                                APIInterfaceLog2.SETRANGE("Source Type", 36);
                                //HEI.02>>
                                if SourceSystemIdentifierAPI."Stop Sales RO Status" then
                                    APIInterfaceLog2.SETRANGE("Source Subtype", 1);
                                //HEI.02<<
                                //APIInterfaceLog2.SETRANGE(Status,APIInterfaceLog2.Status::Error);
                                if APIInterfaceLog2.FINDLAST then
                                    if APIInterfaceLog2.Status = APIInterfaceLog2.Status::Error then begin
                                        APIOrderStatusMapping.RESET;
                                        APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Order);
                                        APIOrderStatusMapping.SETRANGE("Status Field 1", 'Blank');
                                        APIOrderStatusMapping.SETFILTER("Status Field 2", 'Blank');
                                        if APIOrderStatusMapping.FINDFIRST then
                                            TempStatus := APIOrderStatusMapping.Message;
                                    end else begin
                                        //If Order is not found and not in API error Log, then check archive for latest version, then Status: Cancelled
                                        SalesHeaderArchive.RESET; //HEI.02
                                        SalesHeaderArchive.SETRANGE("No.", APIInterfaceLog."Source No.");
                                        SalesHeaderArchive.SETRANGE("Source System Identifier FND", APIInterfaceLog."Source System Identifier");
                                        //HEI.02>>
                                        if SourceSystemIdentifierAPI."Stop Sales RO Status" then
                                            SalesHeaderArchive.SETRANGE("Document Type", SalesHeaderArchive."Document Type"::Order);
                                        //HEI.02<<
                                        if SalesHeaderArchive.FINDLAST then begin
                                            APIOrderStatusMapping.RESET;
                                            APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Order);
                                            APIOrderStatusMapping.SETRANGE("Status Field 1", 'Deleted');
                                            APIOrderStatusMapping.SETFILTER("Status Field 2", 'Blank');
                                            if APIOrderStatusMapping.FINDFIRST then
                                                TempStatus := APIOrderStatusMapping.Message;
                                        end;
                                    end;
                            end;
                        end;
                    end;
                end else
                    TempStatus := 'Order Not received';

            APIInterfaceLog.FIND;
            APIInterfaceLog."Message ID" := TempStatus;
            APIInterfaceLog.MODIFY;
        end;

        //HEI.05>>
        CLEAR(RequestXmlDocument);
        CLEAR(OrderStatusXmlNode);
        CLEAR(OrderXmlNode);
        CLEAR(TempXmlNode);
        CLEAR(OrderStatusXmlNodeList);
        //HEI.05<<
        CLEAR(RequestInStream); //HEI.06
    end;

    //BC Upgrade VAMSIU01 - Blocked and added new with Saas compatible >>
    // local procedure GetNodeByXPath(XPath : Text;NodeName : Text;var ParentXmlNode : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";var XmlNode : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode");
    // begin
    //     XmlNode := ParentXmlNode.SelectSingleNode(XPath);
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
    //BC Upgrade VAMSIU01 - Blocked and added new Procedure with Saas compatible <<

    local procedure ApprovalEntryExists(TableID: Integer; DocumentType: Integer; DocumentNo: Code[20]): Boolean;
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        //HEI.03>>
        ApprovalEntry.SETRANGE("Table ID", TableID);
        ApprovalEntry.SETRANGE("Document Type", DocumentType);
        ApprovalEntry.SETRANGE("Document No.", DocumentNo);

        exit(ApprovalEntry.FINDFIRST);
        //HEI.03<<
    end;
}

