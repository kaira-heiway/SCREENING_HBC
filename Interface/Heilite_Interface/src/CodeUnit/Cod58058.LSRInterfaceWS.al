codeunit 58058 "LSR Interface WS"
{
    // Heilite Navision Old Id - 50136

    // version HEI.05

    // HEI.01 FDD-HB899 - CHG2044703 IBM GAVANM01 13.12.2020 # New POS System Required for OPCO
    //   # New object created for LSR Interfaces
    // HEI.02 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New functions: SendPayments, SendPurchaseOrder, SendPurchaseReceipt
    // HEI.03 FDD-HB899 - CHG2093869 IBM NASTAA02 23.02.2021 # LSR - Transfer and Stock
    //   # New Functions created: 'SendTransferShipments', 'SendTransferReceipt', 'SendStockAdjustment'
    // HEI.04 CHG2093869 GAVANM01 05.03.2021 #Transfer and Stock adjustments interfaces Bahamas LS Retail
    //   # New Functions created: 'SendTransferOrder', 'SendTransferOrderDeletion'
    // HEI.05 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables


    trigger OnRun();
    var
        test: BigText;
    begin
        test.ADDTEXT('<PurchaseRequest>');
        test.ADDTEXT('<PurchaseHeader>');
        test.ADDTEXT('<No>1234test</No>');
        test.ADDTEXT('<BuyFromVendorNo>0030000997</BuyFromVendorNo>');
        test.ADDTEXT('<PayToName>test</PayToName>');
        test.ADDTEXT('<YourReference>YourReference</YourReference>');
        test.ADDTEXT('<OrderDate>2021-02-24</OrderDate>');
        test.ADDTEXT('<ExpectedReceiptDate>2021-02-30</ExpectedReceiptDate>');
        test.ADDTEXT('<RequestedReceiptDate>2021-02-30</RequestedReceiptDate>');
        test.ADDTEXT('<PaymentTermsCode>V025</PaymentTermsCode>');
        test.ADDTEXT('<ShipmentMethodCode>CIF</ShipmentMethodCode>');
        test.ADDTEXT('<LocationCode>BS01</LocationCode>');
        test.ADDTEXT('<CurrencyCode>BSD</CurrencyCode>');
        test.ADDTEXT('<ApproverID>GAVANM01</ApproverID>');
        test.ADDTEXT('<PurchaseLines>');
        test.ADDTEXT('<LineNo>10000</LineNo>');
        test.ADDTEXT('<Type>2</Type>');
        test.ADDTEXT('<No>0020004279</No>');
        test.ADDTEXT('<UoM>Items</UoM>');
        test.ADDTEXT('<Quantity>50</Quantity>');
        test.ADDTEXT('<UoMCode>PC</UoMCode>');
        test.ADDTEXT('<UnitCost>0.2</UnitCost>');
        test.ADDTEXT('<CostCenterCode>10100000</CostCenterCode>');
        test.ADDTEXT('<ExpectedReceiptDate>2021-02-30</ExpectedReceiptDate>');
        test.ADDTEXT('<RequestedReceiptDate>2021-02-30</RequestedReceiptDate>');
        test.ADDTEXT('</PurchaseLines>');
        test.ADDTEXT('</PurchaseHeader>');
        test.ADDTEXT('</PurchaseRequest>');

        SendPurchaseOrder(test);
        MESSAGE('done');
    end;

    var
        InterfaceNotEnabledErr: Label 'Interface %1 is not enabled.';

    procedure SendPayments(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        LSRInterfaceSetup: Record "LSR Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        VIPInterfaceEntryHeaderOut: Record "Interface Entry Header VIP INT";
        VIPInboundInterfaceMapping: Codeunit "Inbound Interface Mapping VIP";
        VIPInterfaceFrameworkMgt: Codeunit "Interface Framework Mgt. VIP";
        LSRInterfaceMgmt: Codeunit "LSR Interface Mgmt.";
        OutputStream: OutStream;
    begin
        //HEI.02<<
        LSRInterfaceSetup.GET;
        LSRInterfaceSetup.TESTFIELD("Payout Interface");
        InterfaceSetup.GET(LSRInterfaceSetup."Payout Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendPaymentsEntries';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        VIPInboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);
        //HEI.02>>

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(VIPInboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.05<<
    end;

    procedure SendPurchaseOrder(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        LSRInterfaceSetup: Record "LSR Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        VIPInterfaceEntryHeaderOut: Record "Interface Entry Header VIP INT";
        VIPInboundInterfaceMapping: Codeunit "Inbound Interface Mapping VIP";
        VIPInterfaceFrameworkMgt: Codeunit "Interface Framework Mgt. VIP";
        LSRInterfaceMgmt: Codeunit "LSR Interface Mgmt.";
        OutputStream: OutStream;
    begin
        //HEI.02<<
        LSRInterfaceSetup.GET;
        LSRInterfaceSetup.TESTFIELD("PO Inbound Interface");
        InterfaceSetup.GET(LSRInterfaceSetup."PO Inbound Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendPurchaseOrder';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        VIPInboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);
        //HEI.02>>

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(VIPInboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.05<<
    end;

    procedure SendPurchaseReceipt(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        LSRInterfaceSetup: Record "LSR Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        VIPInterfaceEntryHeaderOut: Record "Interface Entry Header VIP INT";
        VIPInboundInterfaceMapping: Codeunit "Inbound Interface Mapping VIP";
        VIPInterfaceFrameworkMgt: Codeunit "Interface Framework Mgt. VIP";
        LSRInterfaceMgmt: Codeunit "LSR Interface Mgmt.";
        OutputStream: OutStream;
    begin
        //HEI.02<<
        LSRInterfaceSetup.GET;
        LSRInterfaceSetup.TESTFIELD("PR Interface");
        InterfaceSetup.GET(LSRInterfaceSetup."PR Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendPurchaseReceipt';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        VIPInboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);
        //HEI.02>>

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(VIPInboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.05<<
    end;

    procedure SendTransferShipments(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        LSRInterfaceSetup: Record "LSR Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        VIPInterfaceEntryHeaderOut: Record "Interface Entry Header VIP INT";
        VIPInboundInterfaceMapping: Codeunit "Inbound Interface Mapping VIP";
        VIPInterfaceFrameworkMgt: Codeunit "Interface Framework Mgt. VIP";
        LSRInterfaceMgmt: Codeunit "LSR Interface Mgmt.";
        OutputStream: OutStream;
    begin
        //HEI.03>>
        LSRInterfaceSetup.GET;
        LSRInterfaceSetup.TESTFIELD("Transfer Shipment Interface");
        InterfaceSetup.GET(LSRInterfaceSetup."Transfer Shipment Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendTransferShipments';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        VIPInboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);
        //HEI.03<<

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(VIPInboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.05<<
    end;

    procedure SendTransferReceipts(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        LSRInterfaceSetup: Record "LSR Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        VIPInterfaceEntryHeaderOut: Record "Interface Entry Header VIP INT";
        VIPInboundInterfaceMapping: Codeunit "Inbound Interface Mapping VIP";
        VIPInterfaceFrameworkMgt: Codeunit "Interface Framework Mgt. VIP";
        LSRInterfaceMgmt: Codeunit "LSR Interface Mgmt.";
        OutputStream: OutStream;
    begin
        //HEI.03>>
        LSRInterfaceSetup.GET;
        LSRInterfaceSetup.TESTFIELD("Transfer Receipt Interface");
        InterfaceSetup.GET(LSRInterfaceSetup."Transfer Receipt Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendTransferReceipts';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        VIPInboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);
        //HEI.03<<

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(VIPInboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.05<<
    end;

    procedure SendStockAdjustment(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        LSRInterfaceSetup: Record "LSR Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        VIPInterfaceEntryHeaderOut: Record "Interface Entry Header VIP INT";
        VIPInboundInterfaceMapping: Codeunit "Inbound Interface Mapping VIP";
        VIPInterfaceFrameworkMgt: Codeunit "Interface Framework Mgt. VIP";
        LSRInterfaceMgmt: Codeunit "LSR Interface Mgmt.";
        OutputStream: OutStream;
    begin
        //HEI.03>>
        LSRInterfaceSetup.GET;
        LSRInterfaceSetup.TESTFIELD("Stock Adjustment Interface");
        InterfaceSetup.GET(LSRInterfaceSetup."Stock Adjustment Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendStockAdjustment';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        VIPInboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);
        //HEI.03<<

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(VIPInboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.05<<
    end;

    procedure SendTransferOrder(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        LSRInterfaceSetup: Record "LSR Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        VIPInterfaceEntryHeaderOut: Record "Interface Entry Header VIP INT";
        VIPInboundInterfaceMapping: Codeunit "Inbound Interface Mapping VIP";
        VIPInterfaceFrameworkMgt: Codeunit "Interface Framework Mgt. VIP";
        LSRInterfaceMgmt: Codeunit "LSR Interface Mgmt.";
        OutputStream: OutStream;
    begin
        //HEI.04>>
        LSRInterfaceSetup.GET;
        LSRInterfaceSetup.TESTFIELD("Transfer Order Interface");
        InterfaceSetup.GET(LSRInterfaceSetup."Transfer Order Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendTransferOrder';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        VIPInboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);
        //HEI.04<<

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(VIPInboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.05<<
    end;

    procedure SendTransferOrderDeletion(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        LSRInterfaceSetup: Record "LSR Interface Setup INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        VIPInterfaceEntryHeaderOut: Record "Interface Entry Header VIP INT";
        VIPInboundInterfaceMapping: Codeunit "Inbound Interface Mapping VIP";
        VIPInterfaceFrameworkMgt: Codeunit "Interface Framework Mgt. VIP";
        LSRInterfaceMgmt: Codeunit "LSR Interface Mgmt.";
        OutputStream: OutStream;
    begin
        //HEI.04>>
        LSRInterfaceSetup.GET;
        LSRInterfaceSetup.TESTFIELD("Transfer Order Del. Interface");
        InterfaceSetup.GET(LSRInterfaceSetup."Transfer Order Del. Interface");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendTransferOrderDeletion';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        VIPInboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);
        //HEI.04<<

        //HEI.05>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(VIPInboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.05<<
    end;
}

