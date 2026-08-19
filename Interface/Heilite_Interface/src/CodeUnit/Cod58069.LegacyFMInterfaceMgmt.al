codeunit 58069 "Legacy FM Interface Mgmt."
{
    //BC upgrade GUNREM01 Old ID-50112
    // version HEI.09

    // HEI.01 FDD-HT610 IBM NASTAA02 11.12.2019 # La Reunion Futur Master
    //   # New Codeunit created for Legacy Futur Master Interface Setup
    // HEI.02 HT1338 IBM NASTAA02 30.03.2020 # Futurmaster reaquest to run interfaces manually in HL BASE
    //   # Added functionality to run the FM Interfaces in the past
    // HEI.03 INC3037222 IBM NASTAA02 02.09.2020 # FM PO Interface
    //   # Changed FORMAT for Quantity and Quantity Base for Purchase Order export interface
    // HEI.04 INC3036514 IBM NASTAA02 07/09/2020 # Heilite Interface FuturMaster Discount not being proccessed fully
    //   # Code added for all interfaces to update the value of the Field "Processing Flag"
    // HEI.05 CHG2106084 IBM SAMANR01 04/12/2021
    //   # code fix for apply the item category filter on Daily/Weekly/Monthly report
    // HEI.06 CHG2093033 IBM.LS      21.04.2021
    //   # Added Code
    // HEI.07 CHG2113047 HB2232 IBM GAVANM01 20.07.2021 # FM interfaces files
    //   # Code added for customer interface to update the value of the variable TerritoryCode
    //   # new fields added
    // HEI.08 CHG2113047 INC IBM GAVANM01 17.11.2021 # FM interfaces files
    //   # Code added for customer interface to update the value of the variable TerritoryCode
    // HEI.09 CHG2156586 HB2661 IBM NANDIS01 08.12.2022 FuturMaster update Open Purchase Orders for La Reunion
    //   # New functio CheckImportPO created abd modified existing function - CreatePurchaseOrderResponse to consider import po
    //*******************************************************************************************************************************
    //HEI.10 BC UPGRADE PATHAA02-16.03.26;CU50112-Legacy FM Interface Mgmt. #InventoryUOM Functionality is added
    //# DIT field "Inventory Unit of Measure" is used in Function-interfacesCreateMRPStockExportResponse

    // BC Upgrade MISHRS14 >>
    // Changed table name from "FM Discount Charges" to "FM Discount Charges FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    trigger OnRun();
    begin
    end;

    var
        InterfaceSetup: Record "Interface Setup INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        LegacyFuturMasterIntSetup: Record "Legacy Futur Mster Int Stp INT";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        GeneralInterfaceSetupRead: Boolean;
        LegacyFMInterfaceSetupRead: Boolean;
        Text009: Label 'Invalid Product Code. Length should be less than 15 characters.';
        EndDateError: Label 'End Date must be after %1.';
        EndDateError2: Label 'End Date %1 must be after Start Date %2.';
        StartDateError: Label 'Start Date cannot be empty for Customer %1 Item %2.';
        LineDiscountErr: Label 'Line Discount should have a value on Interface Entry Line No. %1 if Min Qty is %2.';
        FMDiscountError: Label 'FM Discount Charge already exist for Item No. %1.';

    procedure ProcessCustomerMaster(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        Customer: Record Customer;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        OutboundInterface: Record "Outbound Interface INT";
    begin
        GetGeneralInterfaceSetup();
        GetLegacyFMInterfaceSetup();
        LegacyFuturMasterIntSetup.TESTFIELD("Client Master Interface");
        LegacyFuturMasterIntSetup.TESTFIELD("Customer Subtype Exporter");
        InterfaceSetup.GET(LegacyFuturMasterIntSetup."Client Master Interface");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CreateCustomerMasterResponse(InterfaceEntryHeader, InterfaceEntryHeaderOut);
        ProcessOutboundEntry(InterfaceEntryHeaderOut);
    end;

    procedure ProcessActualSalesDailyExport(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        Customer: Record Customer;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        OutboundInterface: Record "Outbound Interface INT";
    begin
        GetGeneralInterfaceSetup();
        GetLegacyFMInterfaceSetup();
        LegacyFuturMasterIntSetup.TESTFIELD("Actual Sales Daily Exp BB");
        LegacyFuturMasterIntSetup.TESTFIELD("Item Category Code Filter");
        InterfaceSetup.GET(LegacyFuturMasterIntSetup."Actual Sales Daily Exp BB");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CreateActualSalesDailyExportResponse(InterfaceEntryHeader, InterfaceEntryHeaderOut);
        ProcessOutboundEntry(InterfaceEntryHeaderOut);
    end;

    procedure ProcessDRPStockExport(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        Customer: Record Customer;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        OutboundInterface: Record "Outbound Interface INT";
    begin
        GetGeneralInterfaceSetup();
        GetLegacyFMInterfaceSetup();
        LegacyFuturMasterIntSetup.TESTFIELD("DRP Stock Export");
        LegacyFuturMasterIntSetup.TESTFIELD("Item Category Code Filter2");
        InterfaceSetup.GET(LegacyFuturMasterIntSetup."DRP Stock Export");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CreateDRPStockExportResponse(InterfaceEntryHeader, InterfaceEntryHeaderOut);
        ProcessOutboundEntry(InterfaceEntryHeaderOut);
    end;

    procedure ProcessMPSStockExport(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        Customer: Record Customer;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        OutboundInterface: Record "Outbound Interface INT";
    begin
        GetGeneralInterfaceSetup();
        GetLegacyFMInterfaceSetup();
        LegacyFuturMasterIntSetup.TESTFIELD("MPS Stock Export");
        LegacyFuturMasterIntSetup.TESTFIELD("Item Category Code Filter3");
        InterfaceSetup.GET(LegacyFuturMasterIntSetup."MPS Stock Export");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CreateMPSStockExportResponse(InterfaceEntryHeader, InterfaceEntryHeaderOut);
        ProcessOutboundEntry(InterfaceEntryHeaderOut);
    end;

    procedure ProcessActualSalesWeeklyExport(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        Customer: Record Customer;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        OutboundInterface: Record "Outbound Interface INT";
    begin
        GetGeneralInterfaceSetup();
        GetLegacyFMInterfaceSetup();
        LegacyFuturMasterIntSetup.TESTFIELD("Actual Sales Weekly Exp BB");
        LegacyFuturMasterIntSetup.TESTFIELD("Item Category Code Filter4");
        InterfaceSetup.GET(LegacyFuturMasterIntSetup."Actual Sales Weekly Exp BB");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CreateActualSalesWeeklyExportResp(InterfaceEntryHeader, InterfaceEntryHeaderOut);
        ProcessOutboundEntry(InterfaceEntryHeaderOut);
    end;

    procedure ProcessActualSalesMonthlyExport(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        Customer: Record Customer;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        OutboundInterface: Record "Outbound Interface INT";
    begin
        GetGeneralInterfaceSetup();
        GetLegacyFMInterfaceSetup();
        LegacyFuturMasterIntSetup.TESTFIELD("Actual Sales Monthly Exp BB");
        LegacyFuturMasterIntSetup.TESTFIELD("Item Category Code Filter5");
        InterfaceSetup.GET(LegacyFuturMasterIntSetup."Actual Sales Monthly Exp BB");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CreateActualSalesMonthlyExportResp(InterfaceEntryHeader, InterfaceEntryHeaderOut);
        ProcessOutboundEntry(InterfaceEntryHeaderOut);
    end;

    procedure ProcessMRPStockExport(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        Customer: Record Customer;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        OutboundInterface: Record "Outbound Interface INT";
    begin
        GetGeneralInterfaceSetup();
        GetLegacyFMInterfaceSetup();
        LegacyFuturMasterIntSetup.TESTFIELD("MRP Stock Export BB Exp");
        LegacyFuturMasterIntSetup.TESTFIELD("Item Category Code Filter6");
        InterfaceSetup.GET(LegacyFuturMasterIntSetup."MRP Stock Export BB Exp");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CreateMRPStockExportResponse(InterfaceEntryHeader, InterfaceEntryHeaderOut);
        ProcessOutboundEntry(InterfaceEntryHeaderOut);
    end;

    procedure ProcessPurchaseOrder(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        Customer: Record Customer;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        OutboundInterface: Record "Outbound Interface INT";
    begin
        GetGeneralInterfaceSetup();
        GetLegacyFMInterfaceSetup();
        LegacyFuturMasterIntSetup.TESTFIELD("Purchase Order Export Exp");
        LegacyFuturMasterIntSetup.TESTFIELD("Item Category Code Filter7");
        InterfaceSetup.GET(LegacyFuturMasterIntSetup."Purchase Order Export Exp");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CreatePurchaseOrderResponse(InterfaceEntryHeader, InterfaceEntryHeaderOut);
        ProcessOutboundEntry(InterfaceEntryHeaderOut);
    end;

    procedure ProcessFMProductGlobal(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        Customer: Record Customer;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        OutboundInterface: Record "Outbound Interface INT";
    begin
        GetGeneralInterfaceSetup();
        GetLegacyFMInterfaceSetup();
        LegacyFuturMasterIntSetup.TESTFIELD("Product FM Global Exp");
        LegacyFuturMasterIntSetup.TESTFIELD("Item Category Code Filter8");
        InterfaceSetup.GET(LegacyFuturMasterIntSetup."Product FM Global Exp");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CreateFMProductGlobalResponse(InterfaceEntryHeader, InterfaceEntryHeaderOut);
        ProcessOutboundEntry(InterfaceEntryHeaderOut);
    end;

    procedure ProcessCustomerDiscounts(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        InterfaceEntryLine: Record "Interface Entry Line INT";
        Customer: Record Customer;
        Item: Record Item;
        FMDiscountCharges: Record "FM Discount Charges FND";
        //BC Upgrade GUNREM01 -DIT Table >>
        // SalesDiscountItemCharge: Record "Sales Discount Item Charge";
        // SalesDiscountItemCharge2: Record "Sales Discount Item Charge";
        //BC Upgrade GUNREM01 -DIT Table <<
        ItemChargeNo: Code[20];
    begin
        GetGeneralInterfaceSetup();
        GetLegacyFMInterfaceSetup();

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET() then
            repeat
                InterfaceEntryLine.TESTFIELD(Description, 'Customer');
                Customer.GET(InterfaceEntryLine."Sell-to Customer No.");
                Item.GET(InterfaceEntryLine."Item No.");
                if InterfaceEntryLine."Document Date" <= WORKDATE() then
                    ERROR(EndDateError, WORKDATE());
                if InterfaceEntryLine."Document Date" < InterfaceEntryLine."Posting Date" then
                    ERROR(EndDateError2, InterfaceEntryLine."Document Date", InterfaceEntryLine."Posting Date");
                if InterfaceEntryLine."Posting Date" = 0D then
                    ERROR(StartDateError, InterfaceEntryLine."Sell-to Customer No.", InterfaceEntryLine."Item No.");
                //InterfaceEntryLine.TESTFIELD(Quantity,0);
                if (InterfaceEntryLine."Discount %" = 0) and (InterfaceEntryLine.Quantity <> 0) then
                    ERROR(LineDiscountErr, InterfaceEntryLine."Entry No.", InterfaceEntryLine.Quantity);
                FMDiscountCharges.SETRANGE("Item No.", InterfaceEntryLine."Item No.");
                if not FMDiscountCharges.FINDFIRST() then
                    ERROR(FMDiscountError, InterfaceEntryLine."Item No.");
                ItemChargeNo := '';
                FMDiscountCharges.SETRANGE("Item No.", InterfaceEntryLine."Item No.");
                if FMDiscountCharges.FINDFIRST() then
                    ItemChargeNo := FMDiscountCharges."Item Charge No.";
            //BC Upgrade GUNREM01 -DIT code >>
            // CLEAR(SalesDiscountItemCharge);
            // SalesDiscountItemCharge.SETRANGE("Calculate per", SalesDiscountItemCharge."Calculate per"::Item);
            // SalesDiscountItemCharge.SETRANGE("Sales Type", SalesDiscountItemCharge."Sales Type"::Customer);
            // SalesDiscountItemCharge.SETRANGE("Sales Code", InterfaceEntryLine."Sell-to Customer No.");
            // SalesDiscountItemCharge.SETRANGE("Source Type", SalesDiscountItemCharge."Source Type"::Item);
            // SalesDiscountItemCharge.SETRANGE("Source No.", InterfaceEntryLine."Item No.");
            // SalesDiscountItemCharge.SETRANGE("Starting Date", InterfaceEntryLine."Posting Date");
            // SalesDiscountItemCharge.SETRANGE("FM Discount", true);
            // if SalesDiscountItemCharge.FINDFIRST then begin
            //     //Deletion
            //     if ((InterfaceEntryLine."Discount %" = 0) or (FORMAT(InterfaceEntryLine."Discount %") = '')) and
            //        ((InterfaceEntryLine.Quantity = 0) or (FORMAT(InterfaceEntryLine.Quantity) = ''))
            //     then
            //         SalesDiscountItemCharge.DELETE(true)
            //     else begin
            //         //Modification
            //         if SalesDiscountItemCharge."Minimum Quantity" <> InterfaceEntryLine.Quantity then
            //             SalesDiscountItemCharge.VALIDATE("Minimum Quantity", InterfaceEntryLine.Quantity);
            //         if ItemChargeNo <> '' then
            //             SalesDiscountItemCharge.VALIDATE("No.", ItemChargeNo);
            //         if SalesDiscountItemCharge."Ending Date" <> InterfaceEntryLine."Document Date" then
            //             SalesDiscountItemCharge.VALIDATE("Ending Date", InterfaceEntryLine."Document Date");
            //         if SalesDiscountItemCharge."Unit of Measure Code" <> InterfaceEntryLine."Unit of Measure Code" then
            //             SalesDiscountItemCharge.VALIDATE("Unit of Measure Code", InterfaceEntryLine."Unit of Measure Code");
            //         if SalesDiscountItemCharge.Percentage <> InterfaceEntryLine."Discount %" then
            //             SalesDiscountItemCharge.VALIDATE(Percentage, InterfaceEntryLine."Discount %");
            //         SalesDiscountItemCharge.MODIFY(true);
            //     end;
            // end else
            //     if not (((InterfaceEntryLine."Discount %" = 0) or (FORMAT(InterfaceEntryLine."Discount %") = '')) and
            //        ((InterfaceEntryLine.Quantity = 0) or (FORMAT(InterfaceEntryLine.Quantity) = '')))
            //     then begin
            //         //Creation
            //         SalesDiscountItemCharge2.INIT;
            //         SalesDiscountItemCharge2.VALIDATE("Calculate per", SalesDiscountItemCharge2."Calculate per"::Item);
            //         SalesDiscountItemCharge2.VALIDATE("Sales Type", SalesDiscountItemCharge2."Sales Type"::Customer);
            //         SalesDiscountItemCharge2.VALIDATE("Sales Code", InterfaceEntryLine."Sell-to Customer No.");
            //         SalesDiscountItemCharge2.VALIDATE("Source Type", SalesDiscountItemCharge2."Source Type"::Item);
            //         SalesDiscountItemCharge2.VALIDATE("Source No.", InterfaceEntryLine."Item No.");
            //         SalesDiscountItemCharge2.VALIDATE("Starting Date", InterfaceEntryLine."Posting Date");
            //         SalesDiscountItemCharge2.VALIDATE("Ending Date", InterfaceEntryLine."Document Date");
            //         SalesDiscountItemCharge2.VALIDATE("Minimum Quantity", InterfaceEntryLine.Quantity);
            //         SalesDiscountItemCharge2.VALIDATE("Unit of Measure Code", InterfaceEntryLine."Unit of Measure Code");
            //         SalesDiscountItemCharge2.VALIDATE(Type, SalesDiscountItemCharge2.Type::"Charge (Item)");
            //         if ItemChargeNo <> '' then
            //             SalesDiscountItemCharge2.VALIDATE("No.", ItemChargeNo);
            //         SalesDiscountItemCharge2.VALIDATE("Extra Charge Type", SalesDiscountItemCharge2."Extra Charge Type"::"Price %");
            //         SalesDiscountItemCharge2.VALIDATE(Percentage, InterfaceEntryLine."Discount %");
            //         SalesDiscountItemCharge2.VALIDATE("FM Discount", true);
            //         SalesDiscountItemCharge2."Using Qty. (Base)" := false;
            //         SalesDiscountItemCharge2.INSERT(true);
            //     end;
            //BC Upgrade GUNREM01 -DIT code <<
            until InterfaceEntryLine.NEXT() = 0;
    end;

    local procedure CreateCustomerMasterResponse(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceEntryHeader2: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        Customer: Record Customer;
        CustomerAttributes: Record "Customer Attributes FND";
        DefaultDimension_Channel: Record "Default Dimension";
        CustomerSubType: Record "Customer Sub-Type FND";
        BusinessSegment: Record "Business Segment FND";
        EntryNo: Integer;
        TerritoryCode: Code[30];
        Marche: Code[20];
    begin
        CLEAR(InterfaceEntryHeaderOut);

        InterfaceEntryHeader2.FINDLAST();
        InterfaceEntryHeaderOut."Entry No." := InterfaceEntryHeader2."Entry No." + 1;
        InterfaceEntryHeaderOut."Interface Code" := LegacyFuturMasterIntSetup."Client Master Interface";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Inbound Interface Entry No." := InterfaceEntryHeader."Entry No.";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET() then
            repeat
                Customer.RESET();
                Customer.SETFILTER("Account Group FND", LegacyFuturMasterIntSetup."Account Group Filter");
                Customer.SETFILTER("No.", InterfaceEntryLine."Sell-to Customer No.");
                if Customer.FINDSET() then begin
                    repeat
                        if GetDefaultDimension(Customer."No.") then begin
                            CLEAR(InterfaceEntryLineOut);
                            Marche := '';
                            EntryNo := EntryNo + 1;
                            CustomerAttributes.GET(Customer."No.");

                            //commented by HEI.07<<
                            /*IF (CustomerAttributes."Customer Sub-Type" <> '') AND
                               (CustomerAttributes."Customer Sub-Type" = LegacyFuturMasterIntSetup."Customer Subtype Exporter")
                            THEN BEGIN
                              IF CustomerSubType.GET(CustomerAttributes."Customer Sub-Type") THEN
                                TerritoryCode := CustomerSubType.Name;
                            END ELSE BEGIN
                              CustomerAttributes.TESTFIELD("Business Segment");
                              BusinessSegment.GET(CustomerAttributes."Business Segment");
                              IF CustomerAttributes."Business Segment" = '02' THEN
                                TerritoryCode := 'ON'
                              ELSE
                                IF CustomerAttributes."Business Segment" = '99' THEN
                                  TerritoryCode := 'NA';

                              IF CustomerAttributes."Name 4" <> '' THEN BEGIN
                                IF (CustomerAttributes."Business Segment" = '01') OR
                                   (CustomerAttributes."Business Segment" = '03')
                                THEN
                                  TerritoryCode := 'E-' + CustomerAttributes."Name 4";
                              END ELSE BEGIN
                                IF CustomerAttributes."Business Segment" = '01' THEN
                                  TerritoryCode := 'OFF'
                                ELSE IF CustomerAttributes."Business Segment" = '03' THEN
                                  TerritoryCode := 'MIX';
                              END;
                            END;
                            */
                            //commented by HEI.07>>
                            //HEI.07<<
                            TerritoryCode := '';
                            case CustomerAttributes."Business Segment" of
                                '99':
                                    TerritoryCode := 'NA';
                                '02':
                                    /*//commented by HEI.08<<
                                    IF CustomerSubType.GET(CustomerAttributes."Customer Sub-Type") THEN
                                      TerritoryCode := CustomerSubType.Name;
                                    *///commented by HEI.08>>
                                    TerritoryCode := CustomerAttributes."Customer Sub-Type";    //HEI.08
                                '01', '03':
                                    if CustomerSubType.GET(CustomerAttributes."Customer Sub-Type") then
                                        if (CustomerSubType.Code = LegacyFuturMasterIntSetup."Cust. Subtype Tr/Kiosk") or (CustomerAttributes."Name 4" = '') then
                                            //TerritoryCode := CustomerSubType.Name   //commented by HEI.08
                                            TerritoryCode := CustomerAttributes."Customer Sub-Type"    //HEI.08
                                        else
                                            TerritoryCode := 'E-' + CustomerAttributes."Name 4";
                            end;
                            //HEI.07<<

                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            InterfaceEntryLineOut.INSERT();

                            InterfaceEntryLineOut."Sell-to Customer No." := Customer."No.";
                            InterfaceEntryLineOut."Ship-to Name" := Customer.Name;
                            if Customer.Blocked = Customer.Blocked::All then
                                InterfaceEntryLineOut.Description := 'Y'
                            else
                                InterfaceEntryLineOut.Description := 'N';
                            InterfaceEntryLineOut."Shipping Agent Code" := Marche;
                            InterfaceEntryLineOut."Bill-to Customer No." := Customer."Bill-to Customer No.";
                            if DefaultDimension_Channel.GET(DATABASE::Customer, Customer."No.", 'CHANNEL') then
                                InterfaceEntryLineOut."CMG Code" := DefaultDimension_Channel."Dimension Value Code";
                            /*//HEI.07<<
                            IF InterfaceEntryLineOut."CMG Code" = '020401' THEN
                              InterfaceEntryLineOut."Ship-to Address" := 'OFF'
                            ELSE*/
                            //HEI.07>>
                            InterfaceEntryLineOut."Ship-to Address" := TerritoryCode;
                            InterfaceEntryLineOut."Ship-to Address 2" := CustomerAttributes."Name 4";
                            InterfaceEntryLineOut."Location Code" := Customer."Location Code";
                            InterfaceEntryLineOut."SalesPers./Purch. Code" := Customer."Sales Routes FND";
                            InterfaceEntryLineOut."Zone Code" := Customer."Service Zone Code";

                            //HEI.07<<
                            InterfaceEntryLineOut."External Order Line No." := '';
                            InterfaceEntryLineOut."Cost Center Code" := CustomerAttributes."Business Segment";
                            InterfaceEntryLineOut."Project Code" := CustomerAttributes."Business OrganizationalSegment";
                            InterfaceEntryLineOut."Ship-to Post Code" := CustomerAttributes."Local Customer Sub-Type";
                            InterfaceEntryLineOut."Unit of Measure Code" := CustomerAttributes.Classification;
                            //HEI.07>>

                            InterfaceEntryLineOut.MODIFY();
                        end;
                    until Customer.NEXT() = 0;
                    //HEI.04>>
                    if InterfaceSetup."Enable Processing Flag" then begin
                        InterfaceEntryHeaderOut."Processing Flag" := true;
                        InterfaceEntryHeaderOut.MODIFY(true);
                    end;
                    //HEI.04<<
                end;
            until InterfaceEntryLine.NEXT() = 0;

    end;

    local procedure CreateActualSalesDailyExportResponse(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceEntryHeader2: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        WarehouseEntry: Record "Warehouse Entry";
        WarehouseEntry2: Record "Warehouse Entry";
        WarehouseEntryBuffer: Record "Warehouse Entry" temporary;
        Item: Record Item;
        Item2: Record Item;
        Item3: Record Item;
        EntryNo: Integer;
        WE_EntryNo: Integer;
        QuantityHL: Decimal;
        CampaignNo: Code[20];
        CustomerNo: Code[20];
        CustomerNo2: Code[20];
        CustomerNo3: Code[20];
        LegacyFuturMasterIntSetupL: Record "Legacy Futur Mster Int Stp INT";
        UnitofMeasureL: Record "Unit of Measure";
        UnitofMeasure1L: Record "Unit of Measure";
        GeneralInterfaceSetupL: Record "General Interface Setup INT";
        DimensionL: Record Dimension;
        DimensionValueL: Record "Dimension Value";
        DefaultDimensionL: Record "Default Dimension";
        ItemUnitofMeasureL: Record "Item Unit of Measure";
        ItemUnitofMeasure1L: Record "Item Unit of Measure";
        QtyCalculatedL: Boolean;
    begin
        CLEAR(InterfaceEntryHeaderOut);
        CampaignNo := '';

        InterfaceEntryHeader2.FINDLAST();
        InterfaceEntryHeaderOut."Entry No." := InterfaceEntryHeader2."Entry No." + 1;
        InterfaceEntryHeaderOut."Interface Code" := LegacyFuturMasterIntSetup."Actual Sales Daily Exp BB";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Inbound Interface Entry No." := InterfaceEntryHeader."Entry No.";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET() then
            repeat
                if Item3.GET(InterfaceEntryLine."No.") then
                    WarehouseEntry.SETRANGE("Item No.", InterfaceEntryLine."No.");
                WarehouseEntry.SETFILTER("Source Document", '%1|%2', WarehouseEntry."Source Document"::"S. Order", WarehouseEntry."Source Document"::"S. Return Order");
                //HEI.02>>
                if InterfaceEntryHeader."Posting Date" <> 0D then
                    WarehouseEntry.SETFILTER("Registering Date", '%1..%2', InterfaceEntryHeader."Posting Date" - 6, InterfaceEntryHeader."Posting Date")
                else
                    //HEI.02<<
                    WarehouseEntry.SETFILTER("Registering Date", '%1..%2', WORKDATE() - 6, WORKDATE());
                if LegacyFuturMasterIntSetup."Location Code Filter" <> '' then
                    WarehouseEntry.SETFILTER("Location Code", LegacyFuturMasterIntSetup."Location Code Filter");
                if LegacyFuturMasterIntSetup."Bin Filter" <> '' then
                    WarehouseEntry.SETFILTER("Bin Code", LegacyFuturMasterIntSetup."Bin Filter");
                if WarehouseEntry.FINDSET() then begin
                    repeat  // >>HEI.05
                        Item.SETRANGE("No.", WarehouseEntry."Item No.");
                        Item.SETFILTER("Item Category Code", LegacyFuturMasterIntSetup."Item Category Code Filter");
                        if Item.FINDFIRST() then begin // >>HEI.05
                                                       //REPEAT  // >>HEI.05
                            QuantityHL := 0;
                            CustomerNo := '';
                            CustomerNo2 := '';
                            //HEI.06>>
                            CLEAR(QtyCalculatedL);
                            //HEI.06<<
                            CustomerNo := GetCustomerNo(WarehouseEntry."Source Document", WarehouseEntry."Source No.");

                            if WarehouseEntryBuffer.FINDLAST() then
                                WE_EntryNo := WarehouseEntryBuffer."Entry No." + 1
                            else
                                WE_EntryNo := 1;
                            WarehouseEntryBuffer.RESET();

                            if CustomerNo <> CustomerNo2 then begin
                                WarehouseEntryBuffer.SETRANGE("Item No.", WarehouseEntry."Item No.");
                                WarehouseEntryBuffer.SETRANGE("Registering Date", WarehouseEntry."Registering Date");
                                WarehouseEntryBuffer.SETRANGE("Source Code", CustomerNo);
                                if not WarehouseEntryBuffer.FINDFIRST() then begin

                                    WarehouseEntryBuffer.INIT();
                                    WarehouseEntryBuffer."Source Document" := WarehouseEntry."Source Document";
                                    WarehouseEntryBuffer."Source No." := WarehouseEntry."Source No.";
                                    CustomerNo2 := GetCustomerNo(WarehouseEntryBuffer."Source Document", WarehouseEntryBuffer."Source No.");
                                    WarehouseEntryBuffer."Entry No." := WE_EntryNo;
                                    WarehouseEntryBuffer."Item No." := WarehouseEntry."Item No.";
                                    WarehouseEntryBuffer."Registering Date" := WarehouseEntry."Registering Date";
                                    WarehouseEntryBuffer."Source Code" := CustomerNo2;

                                    WarehouseEntry2.RESET();
                                    WarehouseEntry2.SETRANGE("Item No.", WarehouseEntry."Item No.");
                                    WarehouseEntry2.SETFILTER("Source Document", '%1|%2', WarehouseEntry2."Source Document"::"S. Order", WarehouseEntry2."Source Document"::"S. Return Order");
                                    WarehouseEntry2.SETRANGE("Registering Date", WarehouseEntry."Registering Date");
                                    if LegacyFuturMasterIntSetup."Location Code Filter" <> '' then
                                        WarehouseEntry2.SETFILTER("Location Code", LegacyFuturMasterIntSetup."Location Code Filter");
                                    if LegacyFuturMasterIntSetup."Bin Filter" <> '' then
                                        WarehouseEntry2.SETFILTER("Bin Code", LegacyFuturMasterIntSetup."Bin Filter");
                                    if WarehouseEntry2.FINDSET() then
                                        repeat
                                            CustomerNo3 := GetCustomerNo(WarehouseEntry2."Source Document", WarehouseEntry2."Source No.");
                                            Item2.GET(WarehouseEntry2."Item No.");
                                            //HEI.06>>
                                            //IF CustomerNo2 = CustomerNo3 THEN
                                            //QuantityHL += -WarehouseEntry2.Quantity * Item2."Unit Volume HL";
                                            if CustomerNo2 = CustomerNo3 then begin
                                                GeneralInterfaceSetupL.GET();
                                                if GeneralInterfaceSetupL."Primary Pack Type Dim. Code" <> '' then begin
                                                    DimensionL.GET(GeneralInterfaceSetupL."Primary Pack Type Dim. Code");
                                                    LegacyFuturMasterIntSetupL.GET();
                                                    if (LegacyFuturMasterIntSetupL."ELP Unit of Measure" <> '') and (LegacyFuturMasterIntSetupL."ELP Primary Pack Type" <> '') then begin
                                                        CLEAR(UnitofMeasureL);
                                                        CLEAR(UnitofMeasure1L);
                                                        UnitofMeasureL.GET(LegacyFuturMasterIntSetupL."ELP Unit of Measure");
                                                        UnitofMeasure1L.GET(LegacyFuturMasterIntSetupL."Content UoM");
                                                        DimensionValueL.GET(GeneralInterfaceSetupL."Primary Pack Type Dim. Code", LegacyFuturMasterIntSetupL."ELP Primary Pack Type");
                                                        DefaultDimensionL.RESET();
                                                        DefaultDimensionL.SETCURRENTKEY("Table ID", "No.", "Dimension Code", "Dimension Value Code");
                                                        DefaultDimensionL.SETRANGE("Table ID", 27);
                                                        DefaultDimensionL.SETRANGE("No.", Item2."No.");
                                                        DefaultDimensionL.SETRANGE("Dimension Code", DimensionL.Code);
                                                        DefaultDimensionL.SETRANGE("Dimension Value Code", DimensionValueL.Code);
                                                        if DefaultDimensionL.FINDFIRST() then begin
                                                            ItemUnitofMeasureL.RESET();
                                                            ItemUnitofMeasureL.SETRANGE("Item No.", Item2."No.");
                                                            ItemUnitofMeasureL.SETRANGE(Code, UnitofMeasureL.Code);
                                                            if ItemUnitofMeasureL.FINDFIRST() and (ItemUnitofMeasureL."Qty. per Unit of Measure" <> 0) then begin
                                                                ItemUnitofMeasure1L.RESET();
                                                                ItemUnitofMeasure1L.SETRANGE("Item No.", Item."No.");
                                                                ItemUnitofMeasure1L.SETRANGE(Code, UnitofMeasure1L.Code);
                                                                if ItemUnitofMeasure1L.FINDFIRST() then begin
                                                                    QuantityHL += -(((WarehouseEntry2.Quantity * Item2."Unit Volume") / ItemUnitofMeasureL."Qty. per Unit of Measure") * ItemUnitofMeasure1L."Qty. per Unit of Measure"); //BC Upgrade SHUKLP03 -DIT code 
                                                                    QtyCalculatedL := true;
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                                //BC Upgrade SHUKLP03 >>
                                                if not QtyCalculatedL then
                                                    QuantityHL += -WarehouseEntry2.Quantity * Item2."Unit Volume";
                                                //BC Upgrade SHUKLP03 >>
                                            end;
                                        //HEI.06<<
                                        until WarehouseEntry2.NEXT() = 0;

                                    //HEI.06>>
                                    //WarehouseEntryBuffer.Quantity := QuantityHL;
                                    WarehouseEntryBuffer.Quantity := ROUND(QuantityHL, 0.0001, '=');
                                    //HEI.06<<
                                    WarehouseEntryBuffer.INSERT();
                                end else
                                    WarehouseEntryBuffer.RESET();
                            end;  // >>HEI.05
                        end;
                    until WarehouseEntry.NEXT() = 0;

                    WarehouseEntryBuffer.RESET();
                    if WarehouseEntryBuffer.FINDSET() then
                        repeat
                            CLEAR(InterfaceEntryLineOut);
                            EntryNo := EntryNo + 1;

                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            InterfaceEntryLineOut.INSERT();

                            InterfaceEntryLineOut."No." := WarehouseEntryBuffer."Item No.";
                            InterfaceEntryLineOut."Sell-to Customer No." := WarehouseEntryBuffer."Source Code";
                            InterfaceEntryLineOut."External Document No." := CampaignNo;
                            InterfaceEntryLineOut."External Contract No." := FORMAT(WarehouseEntryBuffer."Registering Date", 0, '<Year4>');
                            InterfaceEntryLineOut."External Order No." := FORMAT(WarehouseEntryBuffer."Registering Date", 0, '<Month,2>');
                            InterfaceEntryLineOut."External Requisition No." := FORMAT(WarehouseEntryBuffer."Registering Date", 0, '<Day,2>');
                            InterfaceEntryLineOut."Posting Date" := WarehouseEntryBuffer."Registering Date";
                            InterfaceEntryLineOut.Quantity := WarehouseEntryBuffer.Quantity;
                            InterfaceEntryLineOut.MODIFY();
                        until WarehouseEntryBuffer.NEXT() = 0;
                    //HEI.04>>
                    if InterfaceSetup."Enable Processing Flag" then begin
                        InterfaceEntryHeaderOut."Processing Flag" := true;
                        InterfaceEntryHeaderOut.MODIFY(true);
                    end;
                    //HEI.04<<
                end;

            until InterfaceEntryLine.NEXT() = 0;
    end;

    local procedure CreateDRPStockExportResponse(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceEntryHeader2: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        WarehouseEntry: Record "Warehouse Entry";
        Item: Record Item;
        Item2: Record Item;
        SKU: Record "Stockkeeping Unit";
        Location: Record Location;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        EntryNo: Integer;
        Stock: Decimal;
        Blank: Code[20];
    begin
        CLEAR(InterfaceEntryHeaderOut);

        InterfaceEntryHeader2.FINDLAST();
        InterfaceEntryHeaderOut."Entry No." := InterfaceEntryHeader2."Entry No." + 1;
        InterfaceEntryHeaderOut."Interface Code" := LegacyFuturMasterIntSetup."DRP Stock Export";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Inbound Interface Entry No." := InterfaceEntryHeader."Entry No.";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET() then
            repeat
                Item.SETFILTER("Item Category Code", LegacyFuturMasterIntSetup."Item Category Code Filter2");
                if Item.FINDSET() then begin //HEI.04
                    repeat
                        if LegacyFuturMasterIntSetup."Location Code Filter2" <> '' then
                            Location.SETFILTER(Code, LegacyFuturMasterIntSetup."Location Code Filter2");
                        if Location.FINDSET() then
                            repeat
                                Stock := 0;
                                Blank := '';
                                CLEAR(InterfaceEntryLineOut);
                                EntryNo := EntryNo + 1;

                                WarehouseEntry.SETRANGE("Item No.", Item."No.");
                                WarehouseEntry.SETRANGE("Location Code", Location.Code);
                                if LegacyFuturMasterIntSetup."Bin Filter2" <> '' then
                                    WarehouseEntry.SETFILTER("Bin Code", LegacyFuturMasterIntSetup."Bin Filter2");
                                //HEI.02>>
                                if InterfaceEntryHeader."Posting Date" <> 0D then
                                    WarehouseEntry.SETFILTER("Registering Date", '..%1', CALCDATE('<CW>', InterfaceEntryHeader."Posting Date"))
                                else
                                    //HEI.02<<
                                    WarehouseEntry.SETFILTER("Registering Date", '..%1', CALCDATE('<CW>', WORKDATE()));
                                if WarehouseEntry.FINDSET() then
                                    repeat
                                        if ItemUnitofMeasure.GET(Item."No.", LegacyFuturMasterIntSetup."PUM Unit of Measure") then
                                            Stock += WarehouseEntry.Quantity / ItemUnitofMeasure."Qty. per Unit of Measure";
                                    until WarehouseEntry.NEXT() = 0;

                                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                InterfaceEntryLineOut."Entry No." := EntryNo;
                                InterfaceEntryLineOut.INSERT();

                                InterfaceEntryLineOut."No." := Item."No.";
                                InterfaceEntryLineOut."Location Code" := Location.Code;
                                InterfaceEntryLineOut.Description := Blank;
                                //HEI.02>>
                                if InterfaceEntryHeader."Posting Date" <> 0D then
                                    InterfaceEntryLineOut."Description 2" := FORMAT(CALCDATE('<2D>', InterfaceEntryHeader."Posting Date"), 0, '<Year4><Week,2>')
                                else
                                    //HEI.02<<
                                    InterfaceEntryLineOut."Description 2" := FORMAT(CALCDATE('<2D>', TODAY), 0, '<Year4><Week,2>');
                                Stock := ROUND(Stock, 1);
                                InterfaceEntryLineOut."Ship-to Name" := FORMAT(Stock, 0, '<Sign><Integer>');
                                InterfaceEntryLineOut.MODIFY();
                            until Location.NEXT() = 0;
                    until Item.NEXT() = 0;
                    //HEI.04>>
                    if InterfaceSetup."Enable Processing Flag" then begin
                        InterfaceEntryHeaderOut."Processing Flag" := true;
                        InterfaceEntryHeaderOut.MODIFY(true);
                    end;
                end;
            //HEI.04<<
            until InterfaceEntryLine.NEXT() = 0;
    end;

    local procedure CreateMPSStockExportResponse(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceEntryHeader2: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        WarehouseEntry: Record "Warehouse Entry";
        Item: Record Item;
        Item2: Record Item;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        EntryNo: Integer;
        Stock: Decimal;
        Blank: Code[20];
        Blank2: Code[20];
    begin
        CLEAR(InterfaceEntryHeaderOut);

        InterfaceEntryHeader2.FINDLAST();
        InterfaceEntryHeaderOut."Entry No." := InterfaceEntryHeader2."Entry No." + 1;
        InterfaceEntryHeaderOut."Interface Code" := LegacyFuturMasterIntSetup."MPS Stock Export";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Inbound Interface Entry No." := InterfaceEntryHeader."Entry No.";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET() then
            repeat
                Item.SETFILTER("Item Category Code", LegacyFuturMasterIntSetup."Item Category Code Filter3");
                if Item.FINDSET() then begin //HEI.04
                    repeat
                        Stock := 0;
                        Blank := '';
                        Blank2 := '';
                        CLEAR(InterfaceEntryLineOut);
                        EntryNo := EntryNo + 1;

                        WarehouseEntry.SETRANGE("Item No.", Item."No.");
                        if LegacyFuturMasterIntSetup."Location Code Filter3" <> '' then
                            WarehouseEntry.SETFILTER("Location Code", LegacyFuturMasterIntSetup."Location Code Filter3");
                        if LegacyFuturMasterIntSetup."Bin Filter3" <> '' then
                            WarehouseEntry.SETFILTER("Bin Code", LegacyFuturMasterIntSetup."Bin Filter3");
                        //HEI.02>>
                        if InterfaceEntryHeader."Posting Date" <> 0D then
                            WarehouseEntry.SETFILTER("Registering Date", '..%1', CALCDATE('<CW>', InterfaceEntryHeader."Posting Date"))
                        else
                            //HEI.02<<
                            WarehouseEntry.SETFILTER("Registering Date", '..%1', CALCDATE('<CW>', WORKDATE()));
                        if WarehouseEntry.FINDSET() then
                            repeat
                                if ItemUnitofMeasure.GET(Item."No.", LegacyFuturMasterIntSetup."PUM Unit of Measure") then
                                    Stock += WarehouseEntry.Quantity / ItemUnitofMeasure."Qty. per Unit of Measure";
                            until WarehouseEntry.NEXT() = 0;

                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        InterfaceEntryLineOut."Entry No." := EntryNo;
                        InterfaceEntryLineOut.INSERT();

                        InterfaceEntryLineOut."No." := Item."No.";
                        InterfaceEntryLineOut.Description := Blank;
                        InterfaceEntryLineOut."Description 2" := Blank2;
                        //HEI.02>>
                        if InterfaceEntryHeader."Posting Date" <> 0D then
                            InterfaceEntryLineOut.Contact := FORMAT(CALCDATE('<2D>', InterfaceEntryHeader."Posting Date"), 0, '<Year4><Week,2>')
                        else
                            //HEI.02<<
                            InterfaceEntryLineOut.Contact := FORMAT(CALCDATE('<2D>', TODAY), 0, '<Year4><Week,2>');
                        Stock := ROUND(Stock, 1);
                        InterfaceEntryLineOut."Ship-to Name" := FORMAT(Stock, 0, '<Sign><Integer>');
                        InterfaceEntryLineOut.MODIFY();
                    until Item.NEXT() = 0;
                    //HEI.04>>
                    if InterfaceSetup."Enable Processing Flag" then begin
                        InterfaceEntryHeaderOut."Processing Flag" := true;
                        InterfaceEntryHeaderOut.MODIFY(true);
                    end;
                end;
            //HEI.04<<
            until InterfaceEntryLine.NEXT() = 0;
    end;

    local procedure CreateActualSalesWeeklyExportResp(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceEntryHeader2: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        WarehouseEntry: Record "Warehouse Entry";
        WarehouseEntry2: Record "Warehouse Entry";
        WarehouseEntryBuffer: Record "Warehouse Entry" temporary;
        Item: Record Item;
        Item2: Record Item;
        Item3: Record Item;
        EntryNo: Integer;
        WE_EntryNo: Integer;
        QuantityHL: Decimal;
        CustomerNo: Code[20];
        CustomerNo2: Code[20];
        CustomerNo3: Code[20];
        LegacyFuturMasterIntSetupL: Record "Legacy Futur Mster Int Stp INT";
        UnitofMeasureL: Record "Unit of Measure";
        UnitofMeasure1L: Record "Unit of Measure";
        GeneralInterfaceSetupL: Record "General Interface Setup INT";
        DimensionL: Record Dimension;
        DimensionValueL: Record "Dimension Value";
        DefaultDimensionL: Record "Default Dimension";
        ItemUnitofMeasureL: Record "Item Unit of Measure";
        ItemUnitofMeasure1L: Record "Item Unit of Measure";
        QtyCalculatedL: Boolean;
    begin
        CLEAR(InterfaceEntryHeaderOut);

        InterfaceEntryHeader2.FINDLAST();
        InterfaceEntryHeaderOut."Entry No." := InterfaceEntryHeader2."Entry No." + 1;
        InterfaceEntryHeaderOut."Interface Code" := LegacyFuturMasterIntSetup."Actual Sales Weekly Exp BB";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Inbound Interface Entry No." := InterfaceEntryHeader."Entry No.";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET() then
            repeat
                if Item3.GET(InterfaceEntryLine."No.") then
                    WarehouseEntry.SETRANGE("Item No.", InterfaceEntryLine."No.");
                WarehouseEntry.SETFILTER("Source Document", '%1|%2', WarehouseEntry."Source Document"::"S. Order", WarehouseEntry."Source Document"::"S. Return Order");
                //HEI.02>>
                if InterfaceEntryHeader."Posting Date" <> 0D then
                    WarehouseEntry.SETFILTER("Registering Date", '%1..%2', CALCDATE('<-CW>', InterfaceEntryHeader."Posting Date"), InterfaceEntryHeader."Posting Date")
                else
                    //HEI.02<<
                    WarehouseEntry.SETFILTER("Registering Date", '%1..%2', CALCDATE('<-CW>', WORKDATE()), WORKDATE());
                if LegacyFuturMasterIntSetup."Location Code Filter4" <> '' then
                    WarehouseEntry.SETFILTER("Location Code", LegacyFuturMasterIntSetup."Location Code Filter4");
                if LegacyFuturMasterIntSetup."Bin Filter4" <> '' then
                    WarehouseEntry.SETFILTER("Bin Code", LegacyFuturMasterIntSetup."Bin Filter4");
                if WarehouseEntry.FINDSET() then begin
                    repeat // >>HEI.05
                        Item.SETRANGE("No.", WarehouseEntry."Item No.");
                        Item.SETFILTER("Item Category Code", LegacyFuturMasterIntSetup."Item Category Code Filter4");
                        if Item.FINDFIRST() then begin // >>HEI.05
                                                       //REPEAT //>>HEI.05
                            QuantityHL := 0;
                            CustomerNo := '';
                            CustomerNo2 := '';
                            //HEI.06>>
                            CLEAR(QtyCalculatedL);
                            //HEI.06<<
                            CustomerNo := GetCustomerNo(WarehouseEntry."Source Document", WarehouseEntry."Source No.");

                            if WarehouseEntryBuffer.FINDLAST() then
                                WE_EntryNo := WarehouseEntryBuffer."Entry No." + 1
                            else
                                WE_EntryNo := 1;
                            WarehouseEntryBuffer.RESET();

                            if CustomerNo <> CustomerNo2 then begin
                                WarehouseEntryBuffer.SETRANGE("Item No.", WarehouseEntry."Item No.");
                                //HEI.02>>
                                if InterfaceEntryHeader."Posting Date" <> 0D then
                                    WarehouseEntryBuffer.SETFILTER("Registering Date", '%1..%2', CALCDATE('<-CW>', InterfaceEntryHeader."Posting Date"), InterfaceEntryHeader."Posting Date")
                                else
                                    //HEI.02<<
                                    WarehouseEntryBuffer.SETFILTER("Registering Date", '%1..%2', CALCDATE('<-CW>', WORKDATE()), WORKDATE());
                                WarehouseEntryBuffer.SETRANGE("Source Code", CustomerNo);
                                if not WarehouseEntryBuffer.FINDFIRST() then begin

                                    WarehouseEntryBuffer.INIT();
                                    WarehouseEntryBuffer."Source Document" := WarehouseEntry."Source Document";
                                    WarehouseEntryBuffer."Source No." := WarehouseEntry."Source No.";
                                    CustomerNo2 := GetCustomerNo(WarehouseEntryBuffer."Source Document", WarehouseEntryBuffer."Source No.");
                                    WarehouseEntryBuffer."Entry No." := WE_EntryNo;
                                    WarehouseEntryBuffer."Item No." := WarehouseEntry."Item No.";
                                    WarehouseEntryBuffer."Registering Date" := WarehouseEntry."Registering Date";
                                    WarehouseEntryBuffer."Source Code" := CustomerNo2;
                                    WarehouseEntryBuffer."Location Code" := WarehouseEntry."Location Code";
                                    WarehouseEntryBuffer."Bin Code" := WarehouseEntry."Bin Code";

                                    WarehouseEntry2.RESET();
                                    WarehouseEntry2.SETRANGE("Item No.", WarehouseEntry."Item No.");
                                    WarehouseEntry2.SETFILTER("Source Document", '%1|%2', WarehouseEntry2."Source Document"::"S. Order", WarehouseEntry2."Source Document"::"S. Return Order");
                                    //HEI.02>>
                                    if InterfaceEntryHeader."Posting Date" <> 0D then
                                        WarehouseEntry2.SETFILTER("Registering Date", '%1..%2', CALCDATE('<-CW>', InterfaceEntryHeader."Posting Date"), InterfaceEntryHeader."Posting Date")
                                    else
                                        //HEI.02<<
                                        WarehouseEntry2.SETFILTER("Registering Date", '%1..%2', CALCDATE('<-CW>', WORKDATE()), WORKDATE());
                                    if LegacyFuturMasterIntSetup."Location Code Filter4" <> '' then
                                        WarehouseEntry2.SETFILTER("Location Code", LegacyFuturMasterIntSetup."Location Code Filter4");
                                    if LegacyFuturMasterIntSetup."Bin Filter4" <> '' then
                                        WarehouseEntry2.SETFILTER("Bin Code", LegacyFuturMasterIntSetup."Bin Filter4");
                                    if WarehouseEntry2.FINDSET() then
                                        repeat
                                            CustomerNo3 := GetCustomerNo(WarehouseEntry2."Source Document", WarehouseEntry2."Source No.");
                                            Item2.GET(WarehouseEntry2."Item No.");
                                            //HEI.06>>
                                            //IF CustomerNo2 = CustomerNo3 THEN
                                            //IF Item2."Unit Volume HL" > 0 THEN
                                            //QuantityHL += -WarehouseEntry2.Quantity * Item2."Unit Volume HL"
                                            //ELSE
                                            //QuantityHL += -WarehouseEntry2.Quantity;
                                            if CustomerNo2 = CustomerNo3 then begin
                                                GeneralInterfaceSetupL.GET();
                                                if GeneralInterfaceSetupL."Primary Pack Type Dim. Code" <> '' then begin
                                                    DimensionL.GET(GeneralInterfaceSetupL."Primary Pack Type Dim. Code");
                                                    LegacyFuturMasterIntSetupL.GET();
                                                    if (LegacyFuturMasterIntSetupL."ELP Unit of Measure" <> '') and (LegacyFuturMasterIntSetupL."ELP Primary Pack Type" <> '') then begin
                                                        CLEAR(UnitofMeasureL);
                                                        CLEAR(UnitofMeasure1L);
                                                        UnitofMeasureL.GET(LegacyFuturMasterIntSetupL."ELP Unit of Measure");
                                                        UnitofMeasure1L.GET(LegacyFuturMasterIntSetupL."Content UoM");
                                                        DimensionValueL.GET(GeneralInterfaceSetupL."Primary Pack Type Dim. Code", LegacyFuturMasterIntSetupL."ELP Primary Pack Type");
                                                        DefaultDimensionL.RESET();
                                                        DefaultDimensionL.SETCURRENTKEY("Table ID", "No.", "Dimension Code", "Dimension Value Code");
                                                        DefaultDimensionL.SETRANGE("Table ID", 27);
                                                        DefaultDimensionL.SETRANGE("No.", Item2."No.");
                                                        DefaultDimensionL.SETRANGE("Dimension Code", DimensionL.Code);
                                                        DefaultDimensionL.SETRANGE("Dimension Value Code", DimensionValueL.Code);
                                                        if DefaultDimensionL.FINDFIRST() then begin
                                                            ItemUnitofMeasureL.RESET();
                                                            ItemUnitofMeasureL.SETRANGE("Item No.", Item2."No.");
                                                            ItemUnitofMeasureL.SETRANGE(Code, UnitofMeasureL.Code);
                                                            if ItemUnitofMeasureL.FINDFIRST() and (ItemUnitofMeasureL."Qty. per Unit of Measure" <> 0) then begin
                                                                ItemUnitofMeasure1L.RESET();
                                                                ItemUnitofMeasure1L.SETRANGE("Item No.", Item."No.");
                                                                ItemUnitofMeasure1L.SETRANGE(Code, UnitofMeasure1L.Code);
                                                                if ItemUnitofMeasure1L.FINDFIRST() then begin
                                                                    QuantityHL += -(((WarehouseEntry2.Quantity * Item2."Unit Volume") / ItemUnitofMeasureL."Qty. per Unit of Measure") * ItemUnitofMeasure1L."Qty. per Unit of Measure"); //BC Upgrade SHUKLP03 >>
                                                                    QtyCalculatedL := true;
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                                //BC Upgrade SHUKLP03 >>
                                                if not QtyCalculatedL then
                                                    if Item2."Unit Volume" > 0 then
                                                        QuantityHL += -WarehouseEntry2.Quantity * Item2."Unit Volume"
                                                    else
                                                        QuantityHL += -WarehouseEntry2.Quantity;
                                                //BC Upgrade SHUKLP03 <<
                                            end;
                                        //HEI.06<<
                                        until WarehouseEntry2.NEXT() = 0;

                                    //HEI.06>>
                                    //WarehouseEntryBuffer.Quantity := QuantityHL;
                                    WarehouseEntryBuffer.Quantity := ROUND(QuantityHL, 0.0001, '=');
                                    //HEI.06<<
                                    WarehouseEntryBuffer.INSERT();
                                end else
                                    WarehouseEntryBuffer.RESET();
                            end;
                        end; // >>HEI.05
                    until WarehouseEntry.NEXT() = 0;

                    WarehouseEntryBuffer.RESET();
                    WarehouseEntryBuffer.SETFILTER(Quantity, '<>%1', 0);
                    if WarehouseEntryBuffer.FINDSET() then
                        repeat
                            CLEAR(InterfaceEntryLineOut);
                            EntryNo := EntryNo + 1;

                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            InterfaceEntryLineOut.INSERT();

                            InterfaceEntryLineOut."No." := WarehouseEntryBuffer."Item No.";
                            InterfaceEntryLineOut."Sell-to Customer No." := WarehouseEntryBuffer."Source Code";
                            InterfaceEntryLineOut."Location Code" := WarehouseEntryBuffer."Location Code";
                            InterfaceEntryLineOut."Posting Date" := WarehouseEntryBuffer."Registering Date";
                            //HEI.02>>
                            if InterfaceEntryHeader."Posting Date" <> 0D then
                                InterfaceEntryLineOut.Description := FORMAT(InterfaceEntryHeader."Posting Date", 0, '<Year4><Week,2>')
                            else
                                //HEI.02<<
                                InterfaceEntryLineOut.Description := FORMAT(TODAY, 0, '<Year4><Week,2>');
                            InterfaceEntryLineOut.Quantity := WarehouseEntryBuffer.Quantity;
                            InterfaceEntryLineOut."Ship-to Address" := WarehouseEntryBuffer."Bin Code";
                            InterfaceEntryLineOut.MODIFY();
                        until WarehouseEntryBuffer.NEXT() = 0;
                    //HEI.04>>
                    if InterfaceSetup."Enable Processing Flag" then begin
                        InterfaceEntryHeaderOut."Processing Flag" := true;
                        InterfaceEntryHeaderOut.MODIFY(true);
                    end;
                    //HEI.04<<
                end;

            until InterfaceEntryLine.NEXT() = 0;
    end;

    local procedure CreateActualSalesMonthlyExportResp(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceEntryHeader2: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        WarehouseEntry: Record "Warehouse Entry";
        WarehouseEntry2: Record "Warehouse Entry";
        WarehouseEntryBuffer: Record "Warehouse Entry" temporary;
        Item: Record Item;
        Item2: Record Item;
        Item3: Record Item;
        EntryNo: Integer;
        WE_EntryNo: Integer;
        QuantityHL: Decimal;
        CustomerNo: Code[20];
        CustomerNo2: Code[20];
        CustomerNo3: Code[20];
        LegacyFuturMasterIntSetupL: Record "Legacy Futur Mster Int Stp INT";
        UnitofMeasureL: Record "Unit of Measure";
        UnitofMeasure1L: Record "Unit of Measure";
        GeneralInterfaceSetupL: Record "General Interface Setup INT";
        DimensionL: Record Dimension;
        DimensionValueL: Record "Dimension Value";
        DefaultDimensionL: Record "Default Dimension";
        ItemUnitofMeasureL: Record "Item Unit of Measure";
        ItemUnitofMeasure1L: Record "Item Unit of Measure";
        QtyCalculatedL: Boolean;
    begin
        CLEAR(InterfaceEntryHeaderOut);

        InterfaceEntryHeader2.FINDLAST();
        InterfaceEntryHeaderOut."Entry No." := InterfaceEntryHeader2."Entry No." + 1;
        InterfaceEntryHeaderOut."Interface Code" := LegacyFuturMasterIntSetup."Actual Sales Monthly Exp BB";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Inbound Interface Entry No." := InterfaceEntryHeader."Entry No.";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET() then
            repeat
                if Item3.GET(InterfaceEntryLine."No.") then
                    WarehouseEntry.SETRANGE("Item No.", InterfaceEntryLine."No.");
                WarehouseEntry.SETFILTER("Source Document", '%1|%2', WarehouseEntry."Source Document"::"S. Order", WarehouseEntry."Source Document"::"S. Return Order");
                //HEI.02>>
                if InterfaceEntryHeader."Posting Date" <> 0D then
                    WarehouseEntry.SETFILTER("Registering Date", '%1..%2', CALCDATE('<-CM>', InterfaceEntryHeader."Posting Date"), CALCDATE('<CM>', InterfaceEntryHeader."Posting Date"))
                else
                    //HEI.02<<
                    WarehouseEntry.SETFILTER("Registering Date", '%1..%2', CALCDATE('<-CM>', WORKDATE()), CALCDATE('<CM>', WORKDATE()));
                if LegacyFuturMasterIntSetup."Location Code Filter5" <> '' then
                    WarehouseEntry.SETFILTER("Location Code", LegacyFuturMasterIntSetup."Location Code Filter5");
                if LegacyFuturMasterIntSetup."Bin Filter5" <> '' then
                    WarehouseEntry.SETFILTER("Bin Code", LegacyFuturMasterIntSetup."Bin Filter5");
                if WarehouseEntry.FINDSET() then begin
                    repeat // >>HEI.05
                        Item.SETRANGE("No.", WarehouseEntry."Item No.");
                        Item.SETFILTER("Item Category Code", LegacyFuturMasterIntSetup."Item Category Code Filter5");
                        if Item.FINDFIRST() then begin // >>HEI.05
                                                       //REPEAT  // >>HEI.05
                            QuantityHL := 0;
                            CustomerNo := '';
                            CustomerNo2 := '';
                            //HEI.06>>
                            CLEAR(QtyCalculatedL);
                            //HEI.06<<
                            CustomerNo := GetCustomerNo(WarehouseEntry."Source Document", WarehouseEntry."Source No.");

                            if WarehouseEntryBuffer.FINDLAST() then
                                WE_EntryNo := WarehouseEntryBuffer."Entry No." + 1
                            else
                                WE_EntryNo := 1;
                            WarehouseEntryBuffer.RESET();

                            if CustomerNo <> CustomerNo2 then begin
                                WarehouseEntryBuffer.SETRANGE("Item No.", WarehouseEntry."Item No.");
                                //HEI.02>>
                                if InterfaceEntryHeader."Posting Date" <> 0D then
                                    WarehouseEntryBuffer.SETFILTER("Registering Date", '%1..%2', CALCDATE('<-CM>', InterfaceEntryHeader."Posting Date"), CALCDATE('<CM>', InterfaceEntryHeader."Posting Date"))
                                else
                                    //HEI.02<<
                                    WarehouseEntryBuffer.SETFILTER("Registering Date", '%1..%2', CALCDATE('<-CM>', WORKDATE()), CALCDATE('<CM>', WORKDATE()));
                                WarehouseEntryBuffer.SETRANGE("Source Code", CustomerNo);
                                if not WarehouseEntryBuffer.FINDFIRST() then begin

                                    WarehouseEntryBuffer.INIT();
                                    WarehouseEntryBuffer."Source Document" := WarehouseEntry."Source Document";
                                    WarehouseEntryBuffer."Source No." := WarehouseEntry."Source No.";
                                    CustomerNo2 := GetCustomerNo(WarehouseEntryBuffer."Source Document", WarehouseEntryBuffer."Source No.");
                                    WarehouseEntryBuffer."Entry No." := WE_EntryNo;
                                    WarehouseEntryBuffer."Item No." := WarehouseEntry."Item No.";
                                    WarehouseEntryBuffer."Registering Date" := WarehouseEntry."Registering Date";
                                    WarehouseEntryBuffer."Source Code" := CustomerNo2;
                                    WarehouseEntryBuffer."Location Code" := WarehouseEntry."Location Code";
                                    WarehouseEntryBuffer."Bin Code" := WarehouseEntry."Bin Code";

                                    WarehouseEntry2.RESET();
                                    WarehouseEntry2.SETRANGE("Item No.", WarehouseEntry."Item No.");
                                    WarehouseEntry2.SETFILTER("Source Document", '%1|%2', WarehouseEntry2."Source Document"::"S. Order", WarehouseEntry2."Source Document"::"S. Return Order");
                                    //HEI.02>>
                                    if InterfaceEntryHeader."Posting Date" <> 0D then
                                        WarehouseEntry2.SETFILTER("Registering Date", '%1..%2', CALCDATE('<-CM>', InterfaceEntryHeader."Posting Date"), CALCDATE('<CM>', InterfaceEntryHeader."Posting Date"))
                                    else
                                        //HEI.02<<
                                        WarehouseEntry2.SETFILTER("Registering Date", '%1..%2', CALCDATE('<-CM>', WORKDATE()), CALCDATE('<CM>', WORKDATE()));
                                    if LegacyFuturMasterIntSetup."Location Code Filter5" <> '' then
                                        WarehouseEntry2.SETFILTER("Location Code", LegacyFuturMasterIntSetup."Location Code Filter5");
                                    if LegacyFuturMasterIntSetup."Bin Filter5" <> '' then
                                        WarehouseEntry2.SETFILTER("Bin Code", LegacyFuturMasterIntSetup."Bin Filter5");
                                    if WarehouseEntry2.FINDSET() then
                                        repeat
                                            CustomerNo3 := GetCustomerNo(WarehouseEntry2."Source Document", WarehouseEntry2."Source No.");
                                            Item2.GET(WarehouseEntry2."Item No.");
                                            //HEI.06>>
                                            //IF CustomerNo2 = CustomerNo3 THEN
                                            //IF Item2."Unit Volume HL" > 0 THEN
                                            //QuantityHL += -WarehouseEntry2.Quantity * Item2."Unit Volume HL"
                                            //ELSE
                                            //QuantityHL += -WarehouseEntry2.Quantity;
                                            if CustomerNo2 = CustomerNo3 then begin
                                                GeneralInterfaceSetupL.GET();
                                                if GeneralInterfaceSetupL."Primary Pack Type Dim. Code" <> '' then begin
                                                    DimensionL.GET(GeneralInterfaceSetupL."Primary Pack Type Dim. Code");
                                                    LegacyFuturMasterIntSetupL.GET();
                                                    if (LegacyFuturMasterIntSetupL."ELP Unit of Measure" <> '') and (LegacyFuturMasterIntSetupL."ELP Primary Pack Type" <> '') then begin
                                                        CLEAR(UnitofMeasureL);
                                                        CLEAR(UnitofMeasure1L);
                                                        UnitofMeasureL.GET(LegacyFuturMasterIntSetupL."ELP Unit of Measure");
                                                        UnitofMeasure1L.GET(LegacyFuturMasterIntSetupL."Content UoM");
                                                        DimensionValueL.GET(GeneralInterfaceSetupL."Primary Pack Type Dim. Code", LegacyFuturMasterIntSetupL."ELP Primary Pack Type");
                                                        DefaultDimensionL.RESET();
                                                        DefaultDimensionL.SETCURRENTKEY("Table ID", "No.", "Dimension Code", "Dimension Value Code");
                                                        DefaultDimensionL.SETRANGE("Table ID", 27);
                                                        DefaultDimensionL.SETRANGE("No.", Item2."No.");
                                                        DefaultDimensionL.SETRANGE("Dimension Code", DimensionL.Code);
                                                        DefaultDimensionL.SETRANGE("Dimension Value Code", DimensionValueL.Code);
                                                        if DefaultDimensionL.FINDFIRST() then begin
                                                            ItemUnitofMeasureL.RESET();
                                                            ItemUnitofMeasureL.SETRANGE("Item No.", Item2."No.");
                                                            ItemUnitofMeasureL.SETRANGE(Code, UnitofMeasureL.Code);
                                                            if ItemUnitofMeasureL.FINDFIRST() and (ItemUnitofMeasureL."Qty. per Unit of Measure" <> 0) then begin
                                                                ItemUnitofMeasure1L.RESET();
                                                                ItemUnitofMeasure1L.SETRANGE("Item No.", Item."No.");
                                                                ItemUnitofMeasure1L.SETRANGE(Code, UnitofMeasure1L.Code);
                                                                if ItemUnitofMeasure1L.FINDFIRST() then begin
                                                                    QuantityHL += -(((WarehouseEntry2.Quantity * Item2."Unit Volume") / ItemUnitofMeasureL."Qty. per Unit of Measure") * ItemUnitofMeasure1L."Qty. per Unit of Measure"); //BC Upgrade SHUKLP03 
                                                                    QtyCalculatedL := true;
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                                //BC Upgrade SHUKLP03 >>
                                                if not QtyCalculatedL then begin
                                                    if Item2."Unit Volume" > 0 then
                                                        QuantityHL += -WarehouseEntry2.Quantity * Item2."Unit Volume"
                                                    else
                                                        QuantityHL += -WarehouseEntry2.Quantity;
                                                end;
                                                //BC Upgrade SHUKLP03 <<
                                            end;
                                        //HEI.06<<
                                        until WarehouseEntry2.NEXT() = 0;

                                    //HEI.06>>
                                    //WarehouseEntryBuffer.Quantity := QuantityHL;
                                    WarehouseEntryBuffer.Quantity := ROUND(QuantityHL, 0.0001, '=');
                                    //HEI.06<<
                                    WarehouseEntryBuffer.INSERT();
                                end else
                                    WarehouseEntryBuffer.RESET();
                                //HEI.04>>
                                if InterfaceSetup."Enable Processing Flag" then begin
                                    InterfaceEntryHeaderOut."Processing Flag" := true;
                                    InterfaceEntryHeaderOut.MODIFY(true);
                                end;
                                //HEI.04<<
                            end;
                        end;  // >>HEI.05
                    until WarehouseEntry.NEXT() = 0;

                    WarehouseEntryBuffer.RESET();
                    WarehouseEntryBuffer.SETFILTER(Quantity, '<>%1', 0);
                    if WarehouseEntryBuffer.FINDSET() then
                        repeat
                            CLEAR(InterfaceEntryLineOut);
                            EntryNo := EntryNo + 1;

                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            InterfaceEntryLineOut.INSERT();

                            InterfaceEntryLineOut."No." := WarehouseEntryBuffer."Item No.";
                            InterfaceEntryLineOut."Sell-to Customer No." := WarehouseEntryBuffer."Source Code";
                            InterfaceEntryLineOut."Location Code" := WarehouseEntryBuffer."Location Code";
                            InterfaceEntryLineOut."Posting Date" := WarehouseEntryBuffer."Registering Date";
                            //HEI.02>>
                            if InterfaceEntryHeader."Posting Date" <> 0D then
                                InterfaceEntryLineOut.Description := FORMAT(InterfaceEntryHeader."Posting Date", 0, '<Year4><Month,2>')
                            else
                                //HEI.02<<
                                InterfaceEntryLineOut.Description := FORMAT(TODAY, 0, '<Year4><Month,2>');
                            InterfaceEntryLineOut.Quantity := WarehouseEntryBuffer.Quantity;
                            InterfaceEntryLineOut."Ship-to Address" := WarehouseEntryBuffer."Bin Code";
                            InterfaceEntryLineOut.MODIFY();
                        until WarehouseEntryBuffer.NEXT() = 0;
                end;

            until InterfaceEntryLine.NEXT() = 0;
    end;

    local procedure CreateMRPStockExportResponse(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceEntryHeader2: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        WarehouseEntry: Record "Warehouse Entry";
        Item: Record Item;
        Item2: Record Item;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        EntryNo: Integer;
        Stock: Decimal;
        Blank: Code[20];
        Blank2: Code[20];
        StockString: Text;
        StockString2: Text;
    begin
        CLEAR(InterfaceEntryHeaderOut);

        InterfaceEntryHeader2.FINDLAST();
        InterfaceEntryHeaderOut."Entry No." := InterfaceEntryHeader2."Entry No." + 1;
        InterfaceEntryHeaderOut."Interface Code" := LegacyFuturMasterIntSetup."MRP Stock Export BB Exp";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Inbound Interface Entry No." := InterfaceEntryHeader."Entry No.";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET() then
            repeat
                Item.SETFILTER("Item Category Code", LegacyFuturMasterIntSetup."Item Category Code Filter6");
                if Item.FINDSET() then begin //HEI.04
                    repeat
                        Stock := 0;
                        Blank := '';
                        Blank2 := '';
                        CLEAR(InterfaceEntryLineOut);
                        EntryNo := EntryNo + 1;

                        WarehouseEntry.SETRANGE("Item No.", Item."No.");
                        if LegacyFuturMasterIntSetup."Location Code Filter6" <> '' then
                            WarehouseEntry.SETFILTER("Location Code", LegacyFuturMasterIntSetup."Location Code Filter6");
                        if LegacyFuturMasterIntSetup."Bin Filter6" <> '' then
                            WarehouseEntry.SETFILTER("Bin Code", LegacyFuturMasterIntSetup."Bin Filter6");
                        //HEI.02>>
                        if InterfaceEntryHeader."Posting Date" <> 0D then
                            WarehouseEntry.SETFILTER("Registering Date", '..%1', CALCDATE('<CW>', InterfaceEntryHeader."Posting Date"))
                        else
                            //HEI.02<<
                            WarehouseEntry.SETFILTER("Registering Date", '..%1', CALCDATE('<CW>', WORKDATE()));
                        if WarehouseEntry.FINDSET() then
                            repeat
                                // IF ItemUnitofMeasure.GET(Item."No.", LegacyFuturMasterIntSetup."PUM Unit of Measure") THEN                                    
                                if ItemUnitofMeasure.GET(Item."No.", Item."Inventory Unit of Measure FND") then //HEI.10 BC UPGRADE PATHAA02
                                    Stock += WarehouseEntry.Quantity / ItemUnitofMeasure."Qty. per Unit of Measure";
                            until WarehouseEntry.NEXT() = 0;

                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        InterfaceEntryLineOut."Entry No." := EntryNo;
                        InterfaceEntryLineOut.INSERT();

                        InterfaceEntryLineOut."No." := Item."No.";
                        InterfaceEntryLineOut.Description := Blank;
                        InterfaceEntryLineOut."Description 2" := Blank2;
                        //HEI.02>>
                        if InterfaceEntryHeader."Posting Date" <> 0D then
                            InterfaceEntryLineOut.Contact := FORMAT(CALCDATE('<2D>', InterfaceEntryHeader."Posting Date"), 0, '<Year4><Week,2>')
                        else
                            //HEI.02<<
                            InterfaceEntryLineOut.Contact := FORMAT(CALCDATE('<2D>', TODAY), 0, '<Year4><Week,2>'); //FORMAT(TODAY,0,'<Year4><Week,2>');
                        Stock := ROUND(Stock, 1);
                        StockString := FORMAT(Stock);
                        StockString2 := DELCHR(StockString, '=', ',');
                        InterfaceEntryLineOut."Ship-to Name" := StockString2;
                        InterfaceEntryLineOut.MODIFY();
                    until Item.NEXT() = 0;
                    //HEI.04>>
                    if InterfaceSetup."Enable Processing Flag" then begin
                        InterfaceEntryHeaderOut."Processing Flag" := true;
                        InterfaceEntryHeaderOut.MODIFY(true);
                    end;
                end;
            //HEI.04<<
            until InterfaceEntryLine.NEXT() = 0;
    end;

    local procedure CreatePurchaseOrderResponse(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceEntryHeader2: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        Item: Record Item;
        EntryNo: Integer;
        Blank: Code[20];
        Qty: Decimal;
        QtyBase: Decimal;
    begin
        CLEAR(InterfaceEntryHeaderOut);

        InterfaceEntryHeader2.FINDLAST();
        InterfaceEntryHeaderOut."Entry No." := InterfaceEntryHeader2."Entry No." + 1;
        InterfaceEntryHeaderOut."Interface Code" := LegacyFuturMasterIntSetup."Purchase Order Export Exp";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Inbound Interface Entry No." := InterfaceEntryHeader."Entry No.";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET() then
            repeat
                PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
                PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
                //HEI.02>>
                if InterfaceEntryHeader."Posting Date" <> 0D then
                    //PurchaseLine.SETRANGE("Promised Receipt Date",InterfaceEntryHeader."Posting Date",InterfaceEntryHeader."Posting Date" + LegacyFuturMasterIntSetup."Age of Plan Rcpt Days")
                    PurchaseLine.SETRANGE("Expected Receipt Date", InterfaceEntryHeader."Posting Date", InterfaceEntryHeader."Posting Date" + LegacyFuturMasterIntSetup."Age of Plan Rcpt Days")
                else
                    //HEI.02<<
                    PurchaseLine.SETRANGE("Expected Receipt Date", WORKDATE(), WORKDATE() + LegacyFuturMasterIntSetup."Age of Plan Rcpt Days");
                PurchaseLine.SETRANGE("Delivery Finalized FND", false);
                if LegacyFuturMasterIntSetup."Location Code Filter7" <> '' then
                    PurchaseLine.SETFILTER("Location Code", LegacyFuturMasterIntSetup."Location Code Filter7");
                if PurchaseLine.FINDSET() then begin //HEI.04
                    repeat
                        CLEAR(InterfaceEntryLineOut);
                        //HEI.03>>
                        Qty := 0;
                        QtyBase := 0;
                        //HEI.03<<

                        Item.SETRANGE("No.", PurchaseLine."No.");
                        Item.SETFILTER("Item Category Code", LegacyFuturMasterIntSetup."Item Category Code Filter7");
                        if Item.FINDFIRST() then begin
                            PurchaseHeader.GET(PurchaseLine."Document Type", PurchaseLine."Document No.");
                            Blank := '';
                            EntryNo := EntryNo + 1;

                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            InterfaceEntryLineOut.INSERT();

                            //ItemUnitofMeasure.GET(Item."No.",LegacyFuturMasterIntSetup."PUM Unit of Measure"); //ERROR if PUM doesnt exist

                            InterfaceEntryLineOut."Buy-from Vendor No." := '"' + PurchaseLine."No." + '"';
                            InterfaceEntryLineOut."Location Code" := PurchaseLine."Location Code";
                            InterfaceEntryLineOut."External Document No." := '"' + PurchaseHeader."Quote No." + '"';
                            InterfaceEntryLineOut."No." := '"' + PurchaseLine."Document No." + '"';
                            InterfaceEntryLine."External Order No." := Blank;
                            if ItemUnitofMeasure.GET(Item."No.", LegacyFuturMasterIntSetup."PUM Unit of Measure") then begin
                                //HEI.03>>
                                //InterfaceEntryLineOut.Quantity := ROUND(PurchaseLine."Quantity (Base)" / ItemUnitofMeasure."Qty. per Unit of Measure",0.01,'=');
                                //InterfaceEntryLineOut."Qty. per Unit of Measure" := ROUND(PurchaseLine."Outstanding Qty. (Base)" / ItemUnitofMeasure."Qty. per Unit of Measure",0.01,'=');
                                Qty := ROUND(PurchaseLine."Quantity (Base)" / ItemUnitofMeasure."Qty. per Unit of Measure", 0.01, '=');
                                QtyBase := ROUND(PurchaseLine."Outstanding Qty. (Base)" / ItemUnitofMeasure."Qty. per Unit of Measure", 0.01, '=');
                                //HEI.03<<
                            end else begin
                                //HEI.03>>
                                //InterfaceEntryLineOut.Quantity := ROUND(PurchaseLine."Quantity (Base)" / 1,0.01,'=');
                                //InterfaceEntryLineOut."Qty. per Unit of Measure" := ROUND(PurchaseLine."Outstanding Qty. (Base)" / 1,0.01,'=');
                                Qty := ROUND(PurchaseLine."Quantity (Base)" / 1, 0.01, '=');
                                QtyBase := ROUND(PurchaseLine."Outstanding Qty. (Base)" / 1, 0.01, '=');
                                //HEI.03<<
                            end;
                            //HEI.03>>
                            InterfaceEntryLineOut.Contact := FORMAT(Qty, 0, '<Sign><Integer><Decimals><Comma,,>');
                            InterfaceEntryLineOut."Machine Reference No." := FORMAT(QtyBase, 0, '<Sign><Integer><Decimals><Comma,,>');
                            //HEI.03<<

                            if PurchaseLine."Requested Receipt Date" <> 0D then begin
                                InterfaceEntryLineOut.Description := FORMAT(DATE2DMY(PurchaseLine."Requested Receipt Date", 3)); //Year
                                InterfaceEntryLineOut."Description 2" := FORMAT(DATE2DMY(PurchaseLine."Requested Receipt Date", 2)); //Month
                                InterfaceEntryLineOut."Ship-to Name" := FORMAT(DATE2DMY(PurchaseLine."Requested Receipt Date", 1)); //Day
                            end else begin
                                InterfaceEntryLineOut.Description := '';
                                InterfaceEntryLineOut."Description 2" := '';
                                InterfaceEntryLineOut."Ship-to Name" := '';
                            end;

                            if (STRLEN(InterfaceEntryLineOut."Description 2") = 1) and (InterfaceEntryLineOut."Description 2" <> '') then
                                InterfaceEntryLineOut."Description 2" := '0' + InterfaceEntryLineOut."Description 2";

                            //IF PurchaseLine."Expected Receipt Date" <> 0D THEN BEGIN
                            //InterfaceEntryLineOut."Ship-to Address" := FORMAT(DATE2DMY(PurchaseLine."Expected Receipt Date",3));
                            //InterfaceEntryLineOut."Ship-to Address 2" := FORMAT(DATE2DMY(PurchaseLine."Expected Receipt Date",2));
                            //InterfaceEntryLineOut."Ship-to City" := FORMAT(DATE2DMY(PurchaseLine."Expected Receipt Date",1));

                            //HEI.09>>
                            //IF PurchaseLine."Promised Receipt Date" <> 0D THEN BEGIN
                            //  InterfaceEntryLineOut."Ship-to Address" := FORMAT(DATE2DMY(PurchaseLine."Promised Receipt Date",3));
                            //  InterfaceEntryLineOut."Ship-to Address 2" := FORMAT(DATE2DMY(PurchaseLine."Promised Receipt Date",2));
                            //  InterfaceEntryLineOut."Ship-to City" := FORMAT(DATE2DMY(PurchaseLine."Promised Receipt Date",1));
                            if CheckImportPO(PurchaseHeader) then begin
                                if PurchaseLine."Exp Physical Del Date(Imp) FND" <> 0D then begin
                                    InterfaceEntryLineOut."Ship-to Address" := FORMAT(DATE2DMY(PurchaseLine."Exp Physical Del Date(Imp) FND", 3));
                                    InterfaceEntryLineOut."Ship-to Address 2" := FORMAT(DATE2DMY(PurchaseLine."Exp Physical Del Date(Imp) FND", 2));
                                    InterfaceEntryLineOut."Ship-to City" := FORMAT(DATE2DMY(PurchaseLine."Exp Physical Del Date(Imp) FND", 1));
                                end else begin
                                    InterfaceEntryLineOut."Ship-to Address" := '';
                                    InterfaceEntryLineOut."Ship-to Address 2" := '';
                                    InterfaceEntryLineOut."Ship-to City" := '';
                                end;
                            end else begin
                                if PurchaseLine."Expected Receipt Date" <> 0D then begin
                                    InterfaceEntryLineOut."Ship-to Address" := FORMAT(DATE2DMY(PurchaseLine."Expected Receipt Date", 3));
                                    InterfaceEntryLineOut."Ship-to Address 2" := FORMAT(DATE2DMY(PurchaseLine."Expected Receipt Date", 2));
                                    InterfaceEntryLineOut."Ship-to City" := FORMAT(DATE2DMY(PurchaseLine."Expected Receipt Date", 1));
                                    //HEI.09<<
                                end else begin
                                    InterfaceEntryLineOut."Ship-to Address" := '';
                                    InterfaceEntryLineOut."Ship-to Address 2" := '';
                                    InterfaceEntryLineOut."Ship-to City" := '';
                                end;
                            end;  //HEI.09

                            if (STRLEN(InterfaceEntryLineOut."Ship-to Address 2") = 1) and (InterfaceEntryLineOut."Ship-to Address 2" <> '') then
                                InterfaceEntryLineOut."Ship-to Address 2" := '0' + InterfaceEntryLineOut."Ship-to Address 2";

                            InterfaceEntryLineOut.MODIFY();
                        end;
                    until PurchaseLine.NEXT() = 0;
                    //HEI.04>>
                    if InterfaceSetup."Enable Processing Flag" then begin
                        InterfaceEntryHeaderOut."Processing Flag" := true;
                        InterfaceEntryHeaderOut.MODIFY(true);
                    end;
                end;
            //HEI.04<<
            until InterfaceEntryLine.NEXT() = 0;
    end;

    local procedure CreateFMProductGlobalResponse(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceEntryHeader2: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        Item: Record Item;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        ItemUnitofMeasure2: Record "Item Unit of Measure";
        ItemUnitofMeasure3: Record "Item Unit of Measure";
        ItemUnitofMeasure4: Record "Item Unit of Measure";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DefaultDimension: Record "Default Dimension";
        EntryNo: Integer;
        LegacyFuturMasterIntSetupL: Record "Legacy Futur Mster Int Stp INT";
        UnitofMeasureL: Record "Unit of Measure";
        GeneralInterfaceSetupL: Record "General Interface Setup INT";
        DimensionL: Record Dimension;
        DimensionValueL: Record "Dimension Value";
        DefaultDimensionL: Record "Default Dimension";
        ItemUnitofMeasureL: Record "Item Unit of Measure";
        QtyCalculatedL: Boolean;
    begin
        CLEAR(InterfaceEntryHeaderOut);
        GeneralLedgerSetup.GET();

        InterfaceEntryHeader2.FINDLAST();
        InterfaceEntryHeaderOut."Entry No." := InterfaceEntryHeader2."Entry No." + 1;
        InterfaceEntryHeaderOut."Interface Code" := LegacyFuturMasterIntSetup."Product FM Global Exp";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Inbound Interface Entry No." := InterfaceEntryHeader."Entry No.";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET() then
            repeat
                Item.SETFILTER("Item Category Code", LegacyFuturMasterIntSetup."Item Category Code Filter8");
                if Item.FINDSET() then begin //HEI.04
                    repeat
                        CLEAR(InterfaceEntryLineOut);
                        EntryNo := EntryNo + 1;

                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        InterfaceEntryLineOut."Entry No." := EntryNo;
                        InterfaceEntryLineOut.INSERT();

                        if ItemUnitofMeasure3.GET(Item."No.", LegacyFuturMasterIntSetup."PUM Unit of Measure") then;
                        if STRLEN(Item."No.") > 15 then
                            ERROR(Text009);

                        InterfaceEntryLineOut."Item No." := Item."No.";
                        InterfaceEntryLineOut.Description := Item.Description;
                        InterfaceEntryLineOut."Currency Code" := '';
                        InterfaceEntryLineOut."Buy-from Vendor No." := '';
                        InterfaceEntryLineOut."Shortcut Dimension 1 Code" := '';
                        InterfaceEntryLineOut."Shortcut Dimension 2 Code" := '';
                        InterfaceEntryLineOut."Global No." := '';
                        InterfaceEntryLineOut."External Document No." := 'HL';
                        //HLByCol = PUM / HL
                        //HEI.06>>
                        CLEAR(QtyCalculatedL);
                        GeneralInterfaceSetupL.GET();
                        if GeneralInterfaceSetupL."Primary Pack Type Dim. Code" <> '' then begin
                            DimensionL.GET(GeneralInterfaceSetupL."Primary Pack Type Dim. Code");
                            LegacyFuturMasterIntSetupL.GET();
                            if (LegacyFuturMasterIntSetupL."ELP Unit of Measure" <> '') and (LegacyFuturMasterIntSetupL."ELP Primary Pack Type" <> '') then begin
                                CLEAR(UnitofMeasureL);
                                CLEAR(DimensionValueL);
                                UnitofMeasureL.GET(LegacyFuturMasterIntSetupL."ELP Unit of Measure");
                                DimensionValueL.GET(GeneralInterfaceSetupL."Primary Pack Type Dim. Code", LegacyFuturMasterIntSetupL."ELP Primary Pack Type");
                                DefaultDimensionL.RESET();
                                DefaultDimensionL.SETCURRENTKEY("Table ID", "No.", "Dimension Code", "Dimension Value Code");
                                DefaultDimensionL.SETRANGE("Table ID", 27);
                                DefaultDimensionL.SETRANGE("No.", Item."No.");
                                DefaultDimensionL.SETRANGE("Dimension Code", DimensionL.Code);
                                DefaultDimensionL.SETRANGE("Dimension Value Code", DimensionValueL.Code);
                                if DefaultDimensionL.FINDFIRST() then begin
                                    ItemUnitofMeasureL.RESET();
                                    ItemUnitofMeasureL.SETRANGE("Item No.", Item."No.");
                                    ItemUnitofMeasureL.SETRANGE(Code, UnitofMeasureL.Code);
                                    if ItemUnitofMeasureL.FINDFIRST() and (ItemUnitofMeasureL."Qty. per Unit of Measure" <> 0) then begin
                                        InterfaceEntryLineOut."Qty. per Unit of Measure" := ROUND((ItemUnitofMeasure3."Qty. per Unit of Measure" / ItemUnitofMeasureL."Qty. per Unit of Measure") / 100, 0.0001, '=');
                                        QtyCalculatedL := true;
                                    end;
                                end;
                            end;
                        end;

                        if not QtyCalculatedL then begin
                            //HEI.06<<
                            ItemUnitofMeasure2.RESET();
                            if ItemUnitofMeasure2.GET(Item."No.", LegacyFuturMasterIntSetup."HL Unit of Measure") and
                               (ItemUnitofMeasure2."Qty. per Unit of Measure" <> 0)
                            then
                                InterfaceEntryLineOut."Qty. per Unit of Measure" := ROUND(ItemUnitofMeasure3."Qty. per Unit of Measure" / ItemUnitofMeasure2."Qty. per Unit of Measure", 0.00001, '=');
                            //HEI.06>>
                        end;
                        //HEI.06<<
                        InterfaceEntryLineOut."Cross Reference No." := 'COLIS';
                        //ColbyPallet = Pallet / PUM
                        ItemUnitofMeasure2.RESET();
                        if ItemUnitofMeasure2.GET(Item."No.", LegacyFuturMasterIntSetup."Pallet Unit of Measure") and
                           (ItemUnitofMeasure2."Qty. per Unit of Measure" <> 0)
                        then
                            InterfaceEntryLineOut.Quantity := ROUND(ItemUnitofMeasure2."Qty. per Unit of Measure" / ItemUnitofMeasure3."Qty. per Unit of Measure", 0.00001, '=');
                        InterfaceEntryLineOut."Blanket Order No." := 'PAL';
                        //HLByPal = Pallet / HL
                        //HEI.06>>
                        CLEAR(QtyCalculatedL);
                        GeneralInterfaceSetupL.GET();
                        if GeneralInterfaceSetupL."Primary Pack Type Dim. Code" <> '' then begin
                            DimensionL.GET(GeneralInterfaceSetupL."Primary Pack Type Dim. Code");
                            LegacyFuturMasterIntSetupL.GET();
                            if (LegacyFuturMasterIntSetupL."ELP Unit of Measure" <> '') and (LegacyFuturMasterIntSetupL."ELP Primary Pack Type" <> '') then begin
                                CLEAR(UnitofMeasureL);
                                CLEAR(DimensionValueL);
                                UnitofMeasureL.GET(LegacyFuturMasterIntSetupL."ELP Unit of Measure");
                                DimensionValueL.GET(GeneralInterfaceSetupL."Primary Pack Type Dim. Code", LegacyFuturMasterIntSetupL."ELP Primary Pack Type");
                                DefaultDimensionL.RESET();
                                DefaultDimensionL.SETCURRENTKEY("Table ID", "No.", "Dimension Code", "Dimension Value Code");
                                DefaultDimensionL.SETRANGE("Table ID", 27);
                                DefaultDimensionL.SETRANGE("No.", Item."No.");
                                DefaultDimensionL.SETRANGE("Dimension Code", DimensionL.Code);
                                DefaultDimensionL.SETRANGE("Dimension Value Code", DimensionValueL.Code);
                                if DefaultDimensionL.FINDFIRST() then begin
                                    ItemUnitofMeasureL.RESET();
                                    ItemUnitofMeasureL.SETRANGE("Item No.", Item."No.");
                                    ItemUnitofMeasureL.SETRANGE(Code, UnitofMeasureL.Code);
                                    if ItemUnitofMeasureL.FINDFIRST() and (ItemUnitofMeasureL."Qty. per Unit of Measure" <> 0) then begin
                                        InterfaceEntryLineOut."Line Amount" := ROUND((ItemUnitofMeasure2."Qty. per Unit of Measure" / ItemUnitofMeasureL."Qty. per Unit of Measure") / 100, 0.0001, '=');
                                        QtyCalculatedL := true;
                                    end;
                                end;
                            end;
                        end;

                        if not QtyCalculatedL then begin
                            //HEI.06<<
                            ItemUnitofMeasure2.RESET();
                            if ItemUnitofMeasure2.GET(Item."No.", LegacyFuturMasterIntSetup."Pallet Unit of Measure") and
                               (ItemUnitofMeasure2."Qty. per Unit of Measure" <> 0) and
                               ItemUnitofMeasure4.GET(Item."No.", LegacyFuturMasterIntSetup."HL Unit of Measure") and
                               (ItemUnitofMeasure4."Qty. per Unit of Measure" <> 0)
                            then
                                InterfaceEntryLineOut."Line Amount" := ROUND(ItemUnitofMeasure2."Qty. per Unit of Measure" / ItemUnitofMeasure4."Qty. per Unit of Measure", 0.00001, '=');
                            //HEI.06>>
                        end;
                        //HEI.06<<
                        InterfaceEntryLineOut."Order No." := 'PAL';
                        if Item.Blocked then
                            InterfaceEntryLineOut."Source Line No." := 1;
                        InterfaceEntryLineOut."Zone Code" := '';
                        if DefaultDimension.GET(DATABASE::Item, Item."No.", GeneralLedgerSetup."Primary Pack Type Dim FND") then
                            InterfaceEntryLineOut."E-Mail 2" := DefaultDimension."Dimension Value Code";
                        InterfaceEntryLineOut."New Location Code" := '';

                        if Item."Base Unit of Measure" = 'BRL' then
                            InterfaceEntryLineOut."Description 2" := ''
                        else
                            if ItemUnitofMeasure.GET(Item."No.", LegacyFuturMasterIntSetup."Content UoM") then
                                InterfaceEntryLineOut."Description 2" := FORMAT(ROUND(((1 / ItemUnitofMeasure."Qty. per Unit of Measure")), 0.01, '='));

                        InterfaceEntryLineOut."New Zone Code" := '';
                        InterfaceEntryLineOut."Legal Entity" := '';
                        InterfaceEntryLineOut."External Contract No." := '';
                        InterfaceEntryLineOut."CMG Code" := '';
                        InterfaceEntryLineOut."Cost Center Code" := '';
                        InterfaceEntryLineOut."Project Code" := '';
                        InterfaceEntryLineOut."External Order No." := '';

                        InterfaceEntryLineOut.MODIFY();
                    until Item.NEXT() = 0;
                    //HEI.04>>
                    if InterfaceSetup."Enable Processing Flag" then begin
                        InterfaceEntryHeaderOut."Processing Flag" := true;
                        InterfaceEntryHeaderOut.MODIFY(true);
                    end;
                end;
            //HEI.04<<
            until InterfaceEntryLine.NEXT() = 0;
    end;

    local procedure ProcessOutboundEntry(InterfaceEntryHeader: Record "Interface Entry Header INT");
    begin
        COMMIT();
        GetLegacyFMInterfaceSetup();
        if CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeader) then begin
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
        end else
            InterfaceFrameworkMgt.SetInterfaceError(InterfaceEntryHeader, GETLASTERRORTEXT);
    end;

    local procedure GetGeneralInterfaceSetup();
    begin
        if not GeneralInterfaceSetupRead then
            GeneralInterfaceSetup.GET();
        GeneralInterfaceSetupRead := true;
    end;

    local procedure GetLegacyFMInterfaceSetup();
    begin
        if not LegacyFMInterfaceSetupRead then
            LegacyFuturMasterIntSetup.GET();
        LegacyFMInterfaceSetupRead := true;
    end;

    local procedure GetDefaultDimension(CustomerNo: Code[20]): Boolean;
    var
        DefaultDimension: Record "Default Dimension";
        DefaultDimension2: Record "Default Dimension";
    begin
        DefaultDimension.SETRANGE("Table ID", DATABASE::Customer);
        DefaultDimension.SETRANGE("No.", CustomerNo);
        DefaultDimension.SETFILTER("Dimension Code", LegacyFuturMasterIntSetup."Filter Dimension 1 Code");
        DefaultDimension.SETFILTER("Dimension Value Code", LegacyFuturMasterIntSetup."Filter Dimension 1 Value Code");
        if not DefaultDimension.FINDFIRST() then
            exit(false)
        else begin
            DefaultDimension2.SETRANGE("Table ID", DATABASE::Customer);
            DefaultDimension2.SETRANGE("No.", CustomerNo);
            DefaultDimension2.SETFILTER("Dimension Code", LegacyFuturMasterIntSetup."Filter Dimension 2 Code");
            DefaultDimension2.SETFILTER("Dimension Value Code", LegacyFuturMasterIntSetup."Filter Dimension 2 Value Code");
            if not DefaultDimension2.FINDFIRST() then
                exit(false)
            else
                exit(true);
        end;
    end;

    // local procedure GetCustomerNo(SourceDocument: Option "S. Order","S. Invoice","S. Credit Memo","S. Return Order","P. Order","P. Invoice","P. Credit Memo","P. Return Order","Inb. Transfer","Outb. Transfer","Prod. Consumption","Item Jnl.","Phys. Invt. Jnl.","Reclass. Jnl.","Consumption Jnl.","Output Jnl.","BOM Jnl.","Serv. Order","Job Jnl.","Assembly Consumption","Assembly Order"; SourceNo: Code[20]): Code[20];
    // Enum "Warehouse Journal Source Document" 
    local procedure GetCustomerNo(SourceDocument: Enum "Warehouse Journal Source Document"; SourceNo: Code[20]): Code[20]; // SHUKLP03 << Changed option to enum.
    var
        SalesHeader: Record "Sales Header";
        SalesHeaderArchive: Record "Sales Header Archive";
    begin
        if SourceDocument = SourceDocument::"S. Order" then
            if SalesHeader.GET(SalesHeader."Document Type"::Order, SourceNo) then
                exit(SalesHeader."Sell-to Customer No.")
            else begin
                SalesHeaderArchive.SETRANGE("Document Type", SalesHeaderArchive."Document Type"::Order);
                SalesHeaderArchive.SETRANGE("No.", SourceNo);
                if SalesHeaderArchive.FINDFIRST() then
                    exit(SalesHeaderArchive."Sell-to Customer No.");
            end;

        if SourceDocument = SourceDocument::"S. Return Order" then
            if SalesHeader.GET(SalesHeader."Document Type"::"Return Order", SourceNo) then
                exit(SalesHeader."Sell-to Customer No.")
            else begin
                SalesHeaderArchive.SETRANGE("Document Type", SalesHeaderArchive."Document Type"::"Return Order");
                SalesHeaderArchive.SETRANGE("No.", SourceNo);
                if SalesHeaderArchive.FINDFIRST() then
                    exit(SalesHeaderArchive."Sell-to Customer No.");
            end;
    end;

    //  [EventSubscriber(ObjectType::Codeunit, 50000, 'OnAfterSetInterfaceError', '', false, false)]
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Interface Framework Mgt.", 'OnAfterSetInterfaceError', '', false, false)]

    local procedure InterfaceFrameworkMgt_OnAfterSetInterfaceError(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        // SMTPMail: Codeunit "SMTP Mail"; //BC Upgrade GUNREM01 
        MessageText: Text;
        MailSubjectTxt: Text[100];
    begin
        if LegacyFuturMasterIntSetup.GET() then begin
            if (InterfaceEntryHeader."Interface Code" = LegacyFuturMasterIntSetup."Actual Sales Daily Exp BB Req") or
               (InterfaceEntryHeader."Interface Code" = LegacyFuturMasterIntSetup."Actual Sales Daily Exp BB") or
               (InterfaceEntryHeader."Interface Code" = LegacyFuturMasterIntSetup."Actual Sales Weekly Exp BB Req") or
               (InterfaceEntryHeader."Interface Code" = LegacyFuturMasterIntSetup."Actual Sales Weekly Exp BB") or
               (InterfaceEntryHeader."Interface Code" = LegacyFuturMasterIntSetup."Actual Sales Monthly Exp BB R") or
               (InterfaceEntryHeader."Interface Code" = LegacyFuturMasterIntSetup."Actual Sales Monthly Exp BB") or
               (InterfaceEntryHeader."Interface Code" = LegacyFuturMasterIntSetup."DRP Stock Export Req") or
               (InterfaceEntryHeader."Interface Code" = LegacyFuturMasterIntSetup."DRP Stock Export") or
               (InterfaceEntryHeader."Interface Code" = LegacyFuturMasterIntSetup."MPS Stock Export Req") or
               (InterfaceEntryHeader."Interface Code" = LegacyFuturMasterIntSetup."MPS Stock Export") or
               (InterfaceEntryHeader."Interface Code" = LegacyFuturMasterIntSetup."MRP Stock Export BB Request") or
               (InterfaceEntryHeader."Interface Code" = LegacyFuturMasterIntSetup."MRP Stock Export BB Exp") or
               (InterfaceEntryHeader."Interface Code" = LegacyFuturMasterIntSetup."Purchase Order Export Req") or
               (InterfaceEntryHeader."Interface Code" = LegacyFuturMasterIntSetup."Purchase Order Export Exp") or
               (InterfaceEntryHeader."Interface Code" = LegacyFuturMasterIntSetup."Product FM Global Req") or
               (InterfaceEntryHeader."Interface Code" = LegacyFuturMasterIntSetup."Product FM Global Exp") or
               (InterfaceEntryHeader."Interface Code" = LegacyFuturMasterIntSetup."Client Master Interface Req") or
               (InterfaceEntryHeader."Interface Code" = LegacyFuturMasterIntSetup."Client Master Interface") or
               (InterfaceEntryHeader."Interface Code" = LegacyFuturMasterIntSetup."Customer Discount Req")
            then;
            //BC Upgrade GUNREM01 SMTP blocked >>
            // if LegacyFuturMasterIntSetup."Error E-mail Address" <> '' then begin
            //     MailSubjectTxt := 'Error FM Interface';
            //     MessageText := 'Error: ' + InterfaceEntryHeader."Interface Code" + ': ' + InterfaceEntryHeader."Error Message";
            //     SMTPMail.CreateMessage('Heilite FM Interfaces', 'NAV_ERROR@heineken.com', LegacyFuturMasterIntSetup."Error E-mail Address",
            //                            MailSubjectTxt, MessageText, true);
            //     SMTPMail.Send;
            // end;
            //BC Upgrade GUNREM01 SMTP blocked <<
        end;
    end;

    local procedure CheckImportPO(PurchaseHdr: Record "Purchase Header"): Boolean;
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        //HEI.09>>
        if PurchaseHeaderAdditional.GET(PurchaseHdr."Document Type"::Order, PurchaseHdr."No.") then begin
            if PurchaseHeaderAdditional."Import Identifier" then
                exit(true)
            else
                exit(false);
        end else
            exit(false);
        //HEI.09<<
    end;
}

