codeunit 58054 "WMS Interface Web Service"
{
    //BC Upgrade GUNREM01 old-50108
    // version HEI.06

    // HEI.01 FDD-HT318 BULIMC01 IBM 4.12.2019
    //   # New Codeunit created for WMS Interface
    // 
    // HEI.02 FDD-HT604 IBM.COSTES02 09.12.2019 # WMS integration Heilite BASE and Reflex
    //   # New functions added for Sales Order, Sales Order Deletion and Warehouse shpmnt interface
    // HEI.03 CHG2043663 FDD-HT604 IBM.GAVANM01 20.01.2019 # WMS integration Heilite BASE and Reflex
    //   # New function Warehouse Receipt interface
    // HEI.04 CHG2043663 FDD-HT604 IBM.COSTES02 20.01.2020 # WMS integration Heilite BASE and Reflex
    //   # New functions added for stock adjustment and warehouse movement interface
    // HEI.05 CHG2129985 SAHAL01      14.04.2022
    //   # Created New Function - SendRPOOutput
    // HEI.06 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables


    trigger OnRun();
    begin
        //test.ADDTEXT('<ItemRequest><ItemNo>*</ItemNo></ItemRequest>');
        //SendItemRequest(test);

        //test.ADDTEXT('<CustomerRequest><CustomerNo>*</CustomerNo></CustomerRequest>');
        //SendCustomerRequest(test);
        test.ADDTEXT('<WarehouseShipment><WarehouseShipmentList><LocationCode>RE01</LocationCode><DocumentNo>SO00000437</DocumentNo>');
        test.ADDTEXT('<ShippingAgentCode>06 IBAO</ShippingAgentCode><TruckCode>1-LDG 06</TruckCode><WhsShptLine><LineNo>0010000</LineNo>');
        test.ADDTEXT('<ItemCode>0020000408</ItemCode><UOM>30</UOM><QtyToShip>0000840</QtyToShip><BatchNumber>TEST2</BatchNumber>');
        test.ADDTEXT('<BinCode>FPWH0101</BinCode><ZoneCode>FPWH01</ZoneCode></WhsShptLine><WhsShptLine><LineNo>0020000</LineNo>');
        test.ADDTEXT('<ItemCode>0020000500</ItemCode><UOM>30</UOM><QtyToShip>0000072</QtyToShip><BatchNumber>TESTAM</BatchNumber>');
        test.ADDTEXT('<BinCode>FPWH0101</BinCode><ZoneCode>FPWH01</ZoneCode></WhsShptLine></WarehouseShipmentList></WarehouseShipment>');
        SendWarehouseShipmnetRequest(test);
        MESSAGE('done');
        /* <WhsShptLine>
           <LineNo>0030000</LineNo>
           <ItemCode>0020000419</ItemCode>
           <UOM>30</UOM>
           <QtyToShip>0000840</QtyToShip>
           <BatchNumber>TEST4</BatchNumber>
           <BinCode>FPWH0101</BinCode>
           <ZoneCode>FPWH01</ZoneCode>
         </WhsShptLine>*/

    end;

    var
        InterfaceNotEnabledErr: Label 'Interface %1 is not enabled.';
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        InterfaceSetup: Record "Interface Setup INT";
        WMSInterfaceSetup: Record "WMS Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping VIP";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        //  ResponseXML : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC Upgrade GUNREM01 replaced DotNet variable with XMLdocument 
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt. VIP";
        // WMSInterfaceMgt: Codeunit "WMS Interface Management"; //BC Upgrade 
        InterfaceEntryHeaderOut: Record "Interface Entry Header VIP INT";
        test: BigText;

    procedure SendCustomerRequest(var Request: BigText) ErrorMsg: Text;
    var
        InterfaceSetup: Record "Interface Setup INT";
        WMSInterfaceSetup: Record "WMS Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        OutputStream: OutStream;
        Customer: Record Customer;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping VIP";
    begin
        WMSInterfaceSetup.GET;
        WMSInterfaceSetup.TESTFIELD("Customer Request Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."Customer Request Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'WMSCustomerRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
        end;
        exit(ErrorMessage);

        /*InterfaceEntryHeaderVIP.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeaderVIP.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeaderVIP.SETRANGE(Direction,InterfaceEntryHeaderVIP.Direction::Inbound);
        IF InterfaceEntryHeaderVIP.FINDSET THEN
          REPEAT
            WMSInterfaceMgt.ProcessCustomerEntry(Customer,InterfaceEntryHeaderVIP);
            CODEUNIT.RUN(CODEUNIT::"Outbound Interface Process VIP",InterfaceEntryHeaderOut);
        
            DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
            DataExch2.GET(DataExch."Parent Data Exch. No.");
            DataExch2.CALCFIELDS("File Content");
            DataExch2."File Content".CREATEINSTREAM(InputStream);
            ResponseXML := ResponseXML.XmlDocument;
            ResponseXML.Load(InputStream);
            CLEAR(Request);
            Request.ADDTEXT(ResponseXML.InnerXml);
        
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
          UNTIL InterfaceEntryHeaderVIP.NEXT = 0;*/

        //HEI.06>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.06<<

    end;

    procedure SendItemRequest(var Request: BigText) ErrorMsg: Text;
    var
        InterfaceSetup: Record "Interface Setup INT";
        WMSInterfaceSetup: Record "WMS Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping VIP";
        OutputStream: OutStream;
        InputStream: InStream;
        SenderBusinessSystemID: Variant;
        ReceiverBusinessSystemID: Variant;
        DataExch: Record "Data Exch.";
        DataExch2: Record "Data Exch.";
        // ResponseXML: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXML: XmlDocument; //BC Upgrade GUNREM01 replaced DotNet variable with XMLdocument 
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt. VIP";
        WMSInterfaceMgt: Codeunit "WMS Interface Management";
        InterfaceEntryHeaderOut: Record "Interface Entry Header VIP INT";
    begin
        WMSInterfaceSetup.GET;
        WMSInterfaceSetup.TESTFIELD("Item Request Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."Item Request Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'WMSItemRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
        end;
        exit(ErrorMessage);

        /*
        InterfaceEntryHeaderVIP.SETFILTER("Entry No.",'>%1',InboundInterfaceMapping.GetLastExistingEntry);
        InterfaceEntryHeaderVIP.SETRANGE("Interface Code",InterfaceSetup.Code);
        InterfaceEntryHeaderVIP.SETRANGE(Direction,InterfaceEntryHeaderVIP.Direction::Inbound);
        IF InterfaceEntryHeaderVIP.FINDSET THEN
          REPEAT
            WMSInterfaceMgt.ProcessItemRequest(InterfaceEntryHeaderVIP,InterfaceEntryHeaderOut);
            CODEUNIT.RUN(CODEUNIT::"Outbound Interface Process VIP",InterfaceEntryHeaderOut);
        
            DataExch.GET(InterfaceEntryHeaderOut."Data Exch. Entry No.");
            DataExch2.GET(DataExch."Parent Data Exch. No.");
            DataExch2.CALCFIELDS("File Content");
            DataExch2."File Content".CREATEINSTREAM(InputStream);
            ResponseXML := ResponseXML.XmlDocument;
            ResponseXML.Load(InputStream);
            CLEAR(Request);
            Request.ADDTEXT(ResponseXML.InnerXml);
        
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeaderOut);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeaderOut);
          UNTIL InterfaceEntryHeaderVIP.NEXT = 0;
        EXIT(ErrorMessage);*/

        //HEI.06>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.06<<

    end;

    procedure SendSalesOrderRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        WMSInterfaceSetup: Record "WMS Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
    begin
        WMSInterfaceSetup.GET;
        //WMSInterfaceSetup.TESTFIELD("Sales Order Req. Interface");
        //InterfaceSetup.GET(WMSInterfaceSetup."Sales Order Req. Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'WMSSORequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.06>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.06<<
    end;

    procedure SendWarehouseShipmnetRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        WMSInterfaceSetup: Record "WMS Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
    begin
        //>>HEI.02
        WMSInterfaceSetup.GET;
        WMSInterfaceSetup.TESTFIELD("Warehouse Shipment Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."Warehouse Shipment Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'WMSWHSShpmntRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);
        //<<HEI.02

        //HEI.06>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.06<<
    end;

    procedure SendStockAdjustmentRequest(var Request: BigText) ErrorMessage: Text;
    var
        InterfaceSetup: Record "Interface Setup INT";
        WMSInterfaceSetup: Record "WMS Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
    begin
        //>>HEI.04
        WMSInterfaceSetup.GET;
        WMSInterfaceSetup.TESTFIELD("Stock Adjustment Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."Stock Adjustment Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'WMSStockAdjustment';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
        end;

        //HEI.06>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.06<<

        exit(ErrorMessage);
        //<<HEI.04
    end;

    procedure SendWarehouseMovementRequest(var Request: BigText) ErrorMessage: Text;
    var
        InterfaceSetup: Record "Interface Setup INT";
        WMSInterfaceSetup: Record "WMS Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
    begin
        //>>HEI.04
        WMSInterfaceSetup.GET;
        WMSInterfaceSetup.TESTFIELD("Warehouse Movement Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."Warehouse Movement Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'WarehouseMovementRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;

        if not InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment) then begin
            ErrorOccurred := true;
            ErrorMessage := GETLASTERRORTEXT;
        end;

        //HEI.06>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.06<<

        exit(ErrorMessage);
        //<<HEI.04
    end;

    procedure SendWarehouseReceiptRequest(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        WMSInterfaceSetup: Record "WMS Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
    begin
        //>>HEI.03
        WMSInterfaceSetup.GET;
        WMSInterfaceSetup.TESTFIELD("Warehouse RE Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."Warehouse RE Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'WMSWHSRcptRequest';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);
        //<<HEI.03

        //HEI.06>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.06<<
    end;

    procedure SendRPOOutput(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        WMSInterfaceSetup: Record "WMS Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
    begin
        //HEI.05>>
        if WMSInterfaceSetup.GET then;
        if not WMSInterfaceSetup."Activate LogoPak Interface" then
            exit;
        WMSInterfaceSetup.TESTFIELD("Prod. Order Output Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."Prod. Order Output Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'LogoPakRPOOutput';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);
        //HEI.05<<

        //HEI.06>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.06<<
    end;

    //event ResponseXML(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event ResponseXML(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event ResponseXML(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event ResponseXML(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event ResponseXML(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event ResponseXML(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;
}

