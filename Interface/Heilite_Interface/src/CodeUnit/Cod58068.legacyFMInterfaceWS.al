codeunit 58068 "Legacy FM Interface WS"
{
    //BC Upgrade GUNREM01 Old ID-50111
    // version HEI.02

    // HEI.01 FDD-HT610 IBM NASTAA02 11.12.2019 # La Reunion Futur Master
    //   # New Codeunit created for Legacy Futur Master Interface Setup
    // HEI.02 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables


    trigger OnRun();
    begin
    end;

    var
        InterfaceNotEnabledErr: Label 'Interface %1 is not enabled.';

    procedure SendFMCustomerMaster(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        LegacyFuturMasterIntSetup: Record "Legacy Futur Mster Int Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        LegacyFMInterfaceMgmt: Codeunit "Legacy FM Interface Mgmt.";
        OutputStream: OutStream;
    begin
        LegacyFuturMasterIntSetup.GET;
        LegacyFuturMasterIntSetup.TESTFIELD("Client Master Interface Req");
        InterfaceSetup.GET(LegacyFuturMasterIntSetup."Client Master Interface Req");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendCustomerMaster';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.02>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.02<<
    end;

    procedure SendFMActualSalesDailyExport(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        LegacyFuturMasterIntSetup: Record "Legacy Futur Mster Int Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        LegacyFMInterfaceMgmt: Codeunit "Legacy FM Interface Mgmt.";
        OutputStream: OutStream;
    begin
        LegacyFuturMasterIntSetup.GET;
        LegacyFuturMasterIntSetup.TESTFIELD("Actual Sales Daily Exp BB Req");
        InterfaceSetup.GET(LegacyFuturMasterIntSetup."Actual Sales Daily Exp BB Req");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendActualSalesDailyExport';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.02>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.02<<
    end;

    procedure SendFMDRPStockExport(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        LegacyFuturMasterIntSetup: Record "Legacy Futur Mster Int Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        LegacyFMInterfaceMgmt: Codeunit "Legacy FM Interface Mgmt.";
        OutputStream: OutStream;
    begin
        LegacyFuturMasterIntSetup.GET;
        LegacyFuturMasterIntSetup.TESTFIELD("DRP Stock Export Req");
        InterfaceSetup.GET(LegacyFuturMasterIntSetup."DRP Stock Export Req");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendDRPStockExport';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.02>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.02<<
    end;

    procedure SendFMMPSStockExport(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        LegacyFuturMasterIntSetup: Record "Legacy Futur Mster Int Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        LegacyFMInterfaceMgmt: Codeunit "Legacy FM Interface Mgmt.";
        OutputStream: OutStream;
    begin
        LegacyFuturMasterIntSetup.GET;
        LegacyFuturMasterIntSetup.TESTFIELD("MPS Stock Export Req");
        InterfaceSetup.GET(LegacyFuturMasterIntSetup."MPS Stock Export Req");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendMPSStockExport';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.02>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.02<<
    end;

    procedure SendFMActualSalesWeeklyExport(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        LegacyFuturMasterIntSetup: Record "Legacy Futur Mster Int Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        LegacyFMInterfaceMgmt: Codeunit "Legacy FM Interface Mgmt.";
        OutputStream: OutStream;
    begin
        LegacyFuturMasterIntSetup.GET;
        LegacyFuturMasterIntSetup.TESTFIELD("Actual Sales Weekly Exp BB Req");
        InterfaceSetup.GET(LegacyFuturMasterIntSetup."Actual Sales Weekly Exp BB Req");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendActualSalesWeeklyExport';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.02>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.02<<
    end;

    procedure SendFMActualSalesMonthlyExport(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        LegacyFuturMasterIntSetup: Record "Legacy Futur Mster Int Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        LegacyFMInterfaceMgmt: Codeunit "Legacy FM Interface Mgmt.";
        OutputStream: OutStream;
    begin
        LegacyFuturMasterIntSetup.GET;
        LegacyFuturMasterIntSetup.TESTFIELD("Actual Sales Monthly Exp BB R");
        InterfaceSetup.GET(LegacyFuturMasterIntSetup."Actual Sales Monthly Exp BB R");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendActualSalesMonthlyExport';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.02>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.02<<
    end;

    procedure SendFMMRPStockExport(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        LegacyFuturMasterIntSetup: Record "Legacy Futur Mster Int Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        LegacyFMInterfaceMgmt: Codeunit "Legacy FM Interface Mgmt.";
        OutputStream: OutStream;
    begin
        LegacyFuturMasterIntSetup.GET;
        LegacyFuturMasterIntSetup.TESTFIELD("MRP Stock Export BB Request");
        InterfaceSetup.GET(LegacyFuturMasterIntSetup."MRP Stock Export BB Request");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendMRPStockExport';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.02>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.02<<
    end;

    procedure SendFMPurchaseOrder(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        LegacyFuturMasterIntSetup: Record "Legacy Futur Mster Int Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        LegacyFMInterfaceMgmt: Codeunit "Legacy FM Interface Mgmt.";
        OutputStream: OutStream;
    begin
        LegacyFuturMasterIntSetup.GET;
        LegacyFuturMasterIntSetup.TESTFIELD("Purchase Order Export Req");
        InterfaceSetup.GET(LegacyFuturMasterIntSetup."Purchase Order Export Req");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendPurchaseOrderExport';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.02>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.02<<
    end;

    procedure SendFMProductGlobal(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        LegacyFuturMasterIntSetup: Record "Legacy Futur Mster Int Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        LegacyFMInterfaceMgmt: Codeunit "Legacy FM Interface Mgmt.";
        OutputStream: OutStream;
    begin
        LegacyFuturMasterIntSetup.GET;
        LegacyFuturMasterIntSetup.TESTFIELD("Product FM Global Req");
        InterfaceSetup.GET(LegacyFuturMasterIntSetup."Product FM Global Req");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendFMProductGlobal';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.02>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.02<<
    end;

    procedure SendFMCustomerDiscounts(var Request: BigText);
    var
        InterfaceSetup: Record "Interface Setup INT";
        LegacyFuturMasterIntSetup: Record "Legacy Futur Mster Int Stp INT";
        TempIncomingDocumentAttachment: Record "Incoming Document Attachment" temporary;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InboundInterfaceMapping: Codeunit "Inbound Interface Mapping";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        LegacyFMInterfaceMgmt: Codeunit "Legacy FM Interface Mgmt.";
        OutputStream: OutStream;
    begin
        LegacyFuturMasterIntSetup.GET;
        LegacyFuturMasterIntSetup.TESTFIELD("Customer Discount Req");
        InterfaceSetup.GET(LegacyFuturMasterIntSetup."Customer Discount Req");
        if not InterfaceSetup.Enabled then
            ERROR(InterfaceNotEnabledErr, InterfaceSetup.Code);

        CLEAR(TempIncomingDocumentAttachment);
        TempIncomingDocumentAttachment."Incoming Document Entry No." := 1;
        TempIncomingDocumentAttachment."Line No." := 1;
        TempIncomingDocumentAttachment.Name := 'SendCustomerDiscounts';
        TempIncomingDocumentAttachment.Type := TempIncomingDocumentAttachment.Type::XML;
        TempIncomingDocumentAttachment."Document No." := InterfaceSetup.Code;
        TempIncomingDocumentAttachment.Content.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempIncomingDocumentAttachment.INSERT;
        InboundInterfaceMapping.RUN(TempIncomingDocumentAttachment);

        //HEI.02>>
        CLEAR(TempIncomingDocumentAttachment);
        CLEAR(InboundInterfaceMapping);
        CLEAR(OutputStream);
        //HEI.02<<
    end;
}

