codeunit 58025 "API Order Status Notif Mgmt."
{
    // Heilite Navision Old Id - 50147

    // version HEI.02

    // HEI.01 FDD-HB1234 - CHG2053453 IBM NASTAA02 15.02.2021 # B2B Order Status
    //   # New Codeunit created for B2B Interfaces
    // HEI.02 HB2615 - CHG2139668 IBM NASTAA02 13.01.2022 # New Order Status in the existing Order Status API
    //   # New Functiona created "ProcessAPIOrderCreated" and "ProcessAPIWhseShipShipMethodModified"

    // BC Upgrade MISHRS14 >>
    // Changed table name to "API Order Status Mapping FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    trigger OnRun();
    begin
    end;

    var
        APIInterfaceSetup: Record "API Interface Setup2 INT";
        APIOrderStatusMapping: Record "API Order Status Mapping FND";

    procedure ProcessAPIOrderStatusReleased(SalesHeader: Record "Sales Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
    begin
        //Status = Released -> Confirmed

        if not APIInterfaceSetup.GET() then
            exit;

        APIInterfaceSetup.TESTFIELD("API Order Status Not Interface");
        InterfaceSetup.GET(APIInterfaceSetup."API Order Status Not Interface");
        if not InterfaceSetup.Enabled then
            exit;

        if SalesHeader.Status <> SalesHeader.Status::Released then
            exit;

        APIOrderStatusMapping.RESET();
        APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Order);
        APIOrderStatusMapping.SETRANGE("Status Field 1", 'Released');
        APIOrderStatusMapping.SETFILTER("Status Field 2", '%1|%2', 'Not Set', 'Approved');
        if APIOrderStatusMapping.FINDFIRST() then
            CreateAPIOrderStatusResponse(SalesHeader."Order Id FND", APIOrderStatusMapping.Message, SalesHeader."Source System Identifier FND", 'Order Released');
    end;

    procedure ProcessAPIOrderReopen(SalesHeader: Record "Sales Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
    begin
        //Staus = Open -> Received

        if not APIInterfaceSetup.GET() then
            exit;

        APIInterfaceSetup.TESTFIELD("API Order Status Not Interface");
        InterfaceSetup.GET(APIInterfaceSetup."API Order Status Not Interface");
        if not InterfaceSetup.Enabled then
            exit;

        if SalesHeader.Status <> SalesHeader.Status::Open then
            exit;

        APIOrderStatusMapping.RESET();
        APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Order);
        APIOrderStatusMapping.SETRANGE("Status Field 1", 'Open');
        APIOrderStatusMapping.SETFILTER("Status Field 2", 'Blank');
        if APIOrderStatusMapping.FINDFIRST() then
            CreateAPIOrderStatusResponse(SalesHeader."Order Id FND", APIOrderStatusMapping.Message, SalesHeader."Source System Identifier FND", 'Order Reopen');
    end;

    procedure ProcessAPIOrderStatusPendingApproval(SalesHeader: Record "Sales Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
    begin
        //Status = Pending Approval -> 'Pending Approval'

        if not APIInterfaceSetup.GET() then
            exit;

        APIInterfaceSetup.TESTFIELD("API Order Status Not Interface");
        InterfaceSetup.GET(APIInterfaceSetup."API Order Status Not Interface");
        if not InterfaceSetup.Enabled then
            exit;

        APIOrderStatusMapping.RESET();
        APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Order);
        APIOrderStatusMapping.SETRANGE("Status Field 1", 'Pending Approval');
        APIOrderStatusMapping.SETRANGE("Status Field 2", 'Blank');
        if APIOrderStatusMapping.FINDFIRST() then
            CreateAPIOrderStatusResponse(SalesHeader."Order Id FND", APIOrderStatusMapping.Message, SalesHeader."Source System Identifier FND", 'Sent for Approval');
    end;

    procedure ProcessAPIOrderNotCreated(APIInterfaceLog: Record "API Interface Log2 INT");
    var
        InterfaceSetup: Record "Interface Setup INT";
    begin
        //Order not created -> 'Pending'

        if not APIInterfaceSetup.GET() then
            exit;

        APIInterfaceSetup.TESTFIELD("API Order Status Not Interface");
        InterfaceSetup.GET(APIInterfaceSetup."API Order Status Not Interface");
        if not InterfaceSetup.Enabled then
            exit;

        APIOrderStatusMapping.RESET();
        APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Order);
        APIOrderStatusMapping.SETRANGE("Status Field 1", 'Blank');
        APIOrderStatusMapping.SETRANGE("Status Field 2", 'Blank');
        if APIOrderStatusMapping.FINDFIRST() then
            CreateAPIOrderStatusResponse(APIInterfaceLog."Order Id", APIOrderStatusMapping.Message, APIInterfaceLog."Source System Identifier", 'Order not created');
    end;

    procedure ProcessAPIOrderRejected(SalesHeader: Record "Sales Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
    begin
        //Status = Open + Approval Status = Rejected -> 'Rejected'

        if not APIInterfaceSetup.GET() then
            exit;

        APIInterfaceSetup.TESTFIELD("API Order Status Not Interface");
        InterfaceSetup.GET(APIInterfaceSetup."API Order Status Not Interface");
        if not InterfaceSetup.Enabled then
            exit;

        APIOrderStatusMapping.RESET();
        APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Order);
        APIOrderStatusMapping.SETRANGE("Status Field 1", 'Open');
        APIOrderStatusMapping.SETRANGE("Status Field 2", 'Rejected');
        if APIOrderStatusMapping.FINDFIRST() then
            CreateAPIOrderStatusResponse(SalesHeader."Order Id FND", APIOrderStatusMapping.Message, SalesHeader."Source System Identifier FND", 'Approval Request Rejected');
    end;

    procedure ProcessAPIOrderDeleted(SalesHeader: Record "Sales Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
    begin
        //Order deleted -> 'Cancelled'

        if not APIInterfaceSetup.GET() then
            exit;

        APIInterfaceSetup.TESTFIELD("API Order Status Not Interface");
        InterfaceSetup.GET(APIInterfaceSetup."API Order Status Not Interface");
        if not InterfaceSetup.Enabled then
            exit;

        APIOrderStatusMapping.RESET();
        APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Order);
        APIOrderStatusMapping.SETRANGE("Status Field 1", 'Deleted');
        APIOrderStatusMapping.SETRANGE("Status Field 2", 'Blank');
        if APIOrderStatusMapping.FINDFIRST() then
            CreateAPIOrderStatusResponse(SalesHeader."Order Id FND", APIOrderStatusMapping.Message, SalesHeader."Source System Identifier FND", 'Order Deleted');
    end;

    procedure ProcessAPIWhseShipCreated(SalesHeader: Record "Sales Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        B2BInterfaceSetup: Record "B2B Interface Setup INT";
    begin
        //Whse Shipment created + Shipment Method = EXW -> 'Ready Pick-up'

        if not APIInterfaceSetup.GET() then
            exit;

        APIInterfaceSetup.TESTFIELD("API Order Status Not Interface");
        InterfaceSetup.GET(APIInterfaceSetup."API Order Status Not Interface");
        if not InterfaceSetup.Enabled then
            exit;

        if B2BInterfaceSetup.GET() then
            if SalesHeader."Shipment Method Code" <> B2BInterfaceSetup."Pick-up Shipment Method" then
                exit;

        APIOrderStatusMapping.RESET();
        APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Shipment);
        APIOrderStatusMapping.SETRANGE("Status Field 1", 'Created');
        APIOrderStatusMapping.SETRANGE("Status Field 2", B2BInterfaceSetup."Pick-up Shipment Method");
        if APIOrderStatusMapping.FINDFIRST() then
            CreateAPIOrderStatusResponse(SalesHeader."Order Id FND", APIOrderStatusMapping.Message, SalesHeader."Source System Identifier FND", 'Pick-up Shipment created');
    end;

    procedure ProcessAPIWhseShipPosted(SalesHeader: Record "Sales Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        B2BStatusMapping: Record "API Order Status Mapping FND";
        B2BInterfaceSetup: Record "B2B Interface Setup INT";
    begin
        //Whse Shipment posted + Shipment Method <> 'EXW' -> 'On the Way'
        //Whse Shipment posted + Shipment Method = 'EXW' -> 'Completed'

        if not APIInterfaceSetup.GET() then
            exit;

        APIInterfaceSetup.TESTFIELD("API Order Status Not Interface");
        InterfaceSetup.GET(APIInterfaceSetup."API Order Status Not Interface");
        if not InterfaceSetup.Enabled then
            exit;

        if B2BInterfaceSetup.GET() then;

        APIOrderStatusMapping.RESET();
        APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Shipment);
        APIOrderStatusMapping.SETRANGE("Status Field 1", 'Posted');
        if SalesHeader."Shipment Method Code" <> B2BInterfaceSetup."Pick-up Shipment Method" then
            APIOrderStatusMapping.SETRANGE("Status Field 2", 'Blank')
        else
            APIOrderStatusMapping.SETRANGE("Status Field 2", 'Completed');

        if APIOrderStatusMapping.FINDFIRST() then
            CreateAPIOrderStatusResponse(SalesHeader."Order Id FND", APIOrderStatusMapping.Message, SalesHeader."Source System Identifier FND", 'Delivery Shipment posted');
    end;

    procedure ProcessAPIWhseShipCompleted(SalesShipmentHeader: Record "Sales Shipment Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        APIInterfaceLog: Record "API Interface Log2 INT";
    begin
        //Whse Shipment posted + Shipment Method <> 'EXW' + Actual Delivery Date <> 0D -> 'Completed'

        if not APIInterfaceSetup.GET() then
            exit;

        APIInterfaceSetup.TESTFIELD("API Order Status Not Interface");
        InterfaceSetup.GET(APIInterfaceSetup."API Order Status Not Interface");
        if not InterfaceSetup.Enabled then
            exit;

        APIInterfaceSetup.GET();
        APIInterfaceLog.SETRANGE("Interface Code", APIInterfaceSetup."SO/SRO Interface Request");
        APIInterfaceLog.SETRANGE("Source System Identifier", SalesShipmentHeader."Source System Identifier FND");
        APIInterfaceLog.SETRANGE(Entity, 'SALES');
        APIInterfaceLog.SETRANGE(Operation, 'CREATE');
        APIInterfaceLog.SETRANGE("Source Type", 36);
        APIInterfaceLog.SETRANGE("Source Subtype", APIInterfaceLog."Source Subtype"::"1");
        APIInterfaceLog.SETRANGE("Source No.", SalesShipmentHeader."Order No.");
        if APIInterfaceLog.FINDLAST() then;

        APIOrderStatusMapping.RESET();
        APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Shipment);
        APIOrderStatusMapping.SETRANGE("Status Field 1", 'Posted');
        APIOrderStatusMapping.SETRANGE("Status Field 2", 'Completed');
        if APIOrderStatusMapping.FINDFIRST() then
            CreateAPIOrderStatusResponse(APIInterfaceLog."Order Id", APIOrderStatusMapping.Message, SalesShipmentHeader."Source System Identifier FND", 'Actual Delivery Date added');
    end;

    procedure ProcessAPIWhseShipUnCompleted(SalesShipmentHeader: Record "Sales Shipment Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        APIInterfaceLog: Record "API Interface Log2 INT";
    begin
        //Whse Shipment posted + Shipment Method <> 'EXW' -> 'On the Way'

        if not APIInterfaceSetup.GET() then
            exit;

        APIInterfaceSetup.TESTFIELD("API Order Status Not Interface");
        InterfaceSetup.GET(APIInterfaceSetup."API Order Status Not Interface");
        if not InterfaceSetup.Enabled then
            exit;

        APIInterfaceSetup.GET();
        APIInterfaceLog.SETRANGE("Interface Code", APIInterfaceSetup."SO/SRO Interface Request");
        APIInterfaceLog.SETRANGE("Source System Identifier", SalesShipmentHeader."Source System Identifier FND");
        APIInterfaceLog.SETRANGE(Entity, 'SALES');
        APIInterfaceLog.SETRANGE(Operation, 'CREATE');
        APIInterfaceLog.SETRANGE("Source Type", 36);
        APIInterfaceLog.SETRANGE("Source Subtype", APIInterfaceLog."Source Subtype"::"1");
        APIInterfaceLog.SETRANGE("Source No.", SalesShipmentHeader."Order No.");
        if APIInterfaceLog.FINDLAST() then;

        APIOrderStatusMapping.RESET();
        APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Shipment);
        APIOrderStatusMapping.SETRANGE("Status Field 1", 'Posted');
        APIOrderStatusMapping.SETRANGE("Status Field 2", 'Blank');
        if APIOrderStatusMapping.FINDFIRST() then
            CreateAPIOrderStatusResponse(APIInterfaceLog."Order Id", APIOrderStatusMapping.Message, SalesShipmentHeader."Source System Identifier FND", 'Actual Delivery Date deleted');
    end;

    local procedure CreateAPIOrderStatusResponse(OrderID: Text[50]; OrderStatus: Text[50]; SourceSystemIdentifier: Code[10]; TriggerAction: Text[50]);
    var
        InterfaceEntryHeaderVIPOut: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIPOut: Record "Interface Entry Line VIP INT";
        EntryNo: Integer;
    begin
        CLEAR(InterfaceEntryHeaderVIPOut);
        CLEAR(InterfaceEntryLineVIPOut);
        EntryNo := 0;

        if InterfaceEntryHeaderVIP.FINDLAST() then
            InterfaceEntryHeaderVIPOut."Entry No." := InterfaceEntryHeaderVIP."Entry No." + 1
        else
            InterfaceEntryHeaderVIPOut."Entry No." := 1;

        InterfaceEntryHeaderVIPOut."Interface Code" := APIInterfaceSetup."API Order Status Not Interface";
        InterfaceEntryHeaderVIPOut.Direction := InterfaceEntryHeaderVIPOut.Direction::Outbound;
        InterfaceEntryHeaderVIPOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderVIPOut.Address := OrderID;
        InterfaceEntryHeaderVIPOut.INSERT(true);

        InterfaceEntryLineVIPOut."Header Entry No." := InterfaceEntryHeaderVIPOut."Entry No.";
        InterfaceEntryLineVIPOut."Entry No." := 1;
        InterfaceEntryLineVIPOut.INSERT(true);

        InterfaceEntryLineVIPOut.Address := OrderID;
        InterfaceEntryLineVIPOut.Description := SourceSystemIdentifier;
        InterfaceEntryLineVIPOut."Description 2" := FORMAT(CURRENTDATETIME, 0, 9);

        //Keep info about Status and action performed
        InterfaceEntryLineVIPOut."Address 2" := OrderStatus;
        InterfaceEntryLineVIPOut."Name 2" := TriggerAction;

        InterfaceEntryLineVIPOut.MODIFY(true);
    end;

    procedure ProcessAPIOrderCreated(SalesHeader: Record "Sales Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
    begin
        //HEI.02>>
        //Status = Open + Approval Status = '' -> 'Created'

        if not APIInterfaceSetup.GET() then
            exit;

        APIInterfaceSetup.TESTFIELD("API Order Status Not Interface");
        InterfaceSetup.GET(APIInterfaceSetup."API Order Status Not Interface");
        if not InterfaceSetup.Enabled then
            exit;

        APIOrderStatusMapping.RESET();
        APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Order);
        APIOrderStatusMapping.SETRANGE("Status Field 1", 'Created');
        APIOrderStatusMapping.SETRANGE("Status Field 2", 'Blank');
        if APIOrderStatusMapping.FINDFIRST() then
            CreateAPIOrderStatusResponse(SalesHeader."Order Id FND", APIOrderStatusMapping.Message, SalesHeader."Source System Identifier FND", 'Order Created');
        //HEI.02<<
    end;

    procedure ProcessAPIWhseShipShipMethodModified(WarehouseShipmentHeader: Record "Warehouse Shipment Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        B2BInterfaceSetup: Record "B2B Interface Setup INT";
        SalesHeader: Record "Sales Header";
    begin
        //HEI.02>>
        //Shipment Method = EXW -> 'Ready Pick-up'
        if not APIInterfaceSetup.GET() then
            exit;

        APIInterfaceSetup.TESTFIELD("API Order Status Not Interface");
        InterfaceSetup.GET(APIInterfaceSetup."API Order Status Not Interface");
        if not InterfaceSetup.Enabled then
            exit;

        if B2BInterfaceSetup.GET() then
            if WarehouseShipmentHeader."Shipment Method Code" <> B2BInterfaceSetup."Pick-up Shipment Method" then
                exit;

        SalesHeader.GET(SalesHeader."Document Type"::Order, WarehouseShipmentHeader."Source No. FND");

        APIOrderStatusMapping.RESET();
        APIOrderStatusMapping.SETRANGE(Source, APIOrderStatusMapping.Source::Shipment);
        APIOrderStatusMapping.SETRANGE("Status Field 1", 'Created');
        APIOrderStatusMapping.SETRANGE("Status Field 2", B2BInterfaceSetup."Pick-up Shipment Method");
        if APIOrderStatusMapping.FINDFIRST() then
            CreateAPIOrderStatusResponse(SalesHeader."Order Id FND", APIOrderStatusMapping.Message, SalesHeader."Source System Identifier FND", 'Pick-up Shipment created');
        //HEI.02<<
    end;
}

