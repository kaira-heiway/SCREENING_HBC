codeunit 58018 "DMS Interface Mgmt."
{
    // Heilite Navision Old Id - 50134

    // version HEI.09

    // HEI.01 FDD-HB1268 - CHG2068666 IBM NASTAA02 26.10.2020 # DMS Integration Ivory Coast
    //   # New Codeunit created for DMS Interfaces
    // HEI.02 INC3292787 - CHG2096181 IBM NASTAA02 29.01.2020 # Exclude lines with Qty zero in DMS Shipment interface
    //   # Excluded Sales Shipment Lines with Quantity <= 0
    // HEI.03 INC3340882 - CHG2100040 IBM NASTAA02 25.02.2021 #Incorrect Sequence ID's
    //   # Sequence ID for Shipment interface changed
    // HEI.04 HB2300 - CHG2113543 IBM NASTAA02 02.09.2021 # DMS DRC
    //   # Added Sales Order No. to Shipment Interface
    // HEI.05 INC3957557 - CHG2145449 IBM NASTAA02 07.02.2021 # We have noticed that the shipment file that we were receiving from the base end was having wrong Received date. Comparing to the previous shipments the Receivin
    //   # Dates used for DMS-Shipment should have the format 'yyyy-mm-dd'
    // HEI.06 CHG2167559-HB3063 IBM BHANDS01 24.11.2022 # La Réunion BASE - DMS integration
    //   # Addition of 2 fields : Truck Code & Driver Code in DMS Shipment Interface
    // HEI.07 CHG2221799 IBM SISUM01 19.12.2023 HB3600 La Reunion DMS - Best Before Date
    //   # add lot and expiration date to Shipment outbound
    // HEI.08 CHG2221799 IBM SISUM01 05.01.2024 HB3600 La Reunion DMS - Best Before Date
    //   # add new parameters to function CreateDMSShipmentLinesWithLot
    // HEI.09 CHG2221799 IBM BHANDS01 13.05.2024 HB3600 La Reunion DMS - Best Before Date
    //   # change in the date format of Best Before Date same as Order Date and Delivery Date

    // BC Upgrade MISHRS14 >>
    // Changed table name from "DMS Items Incl. Excl." to "DMS Items Incl. Excl. FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    // BC Upgrade SHUKLP03 << Restructured DIT fields related code of DMS Item Interface.

    trigger OnRun();
    begin
    end;

    var
        InterfaceFrameworkMgtVIP: Codeunit "Interface Framework Mgt.";
        DMSInterfaceSetup: Record "DMS Interface Setup INT";

    procedure ProcessDMSCustomerResponse(Customer: Record Customer);
    var
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        Customer2: Record Customer;
    begin
        if not DMSInterfaceSetup.GET() then
            exit;

        if not DMSInterfaceSetup."Enable DMS Interfaces" then
            exit;

        DMSInterfaceSetup.TESTFIELD("DMS Customer Interface");
        InterfaceSetup.GET(DMSInterfaceSetup."DMS Customer Interface");
        if not InterfaceSetup.Enabled then
            exit;

        Customer2.RESET();
        Customer2.SETRANGE("No.", Customer."No.");
        Customer2.SETFILTER("Account Group FND", DMSInterfaceSetup."Customer Acc Group Filter");
        Customer2.SETRANGE("Flag for Deletion FND", false);
        if Customer2.FINDFIRST() then begin
            InterfaceFrameworkMgtVIP.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CreateDMSCustomerResponse(Customer);
        end;
    end;

    local procedure CreateDMSCustomerResponse(Customer: Record Customer);
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

        InterfaceEntryHeaderVIPOut."Interface Code" := DMSInterfaceSetup."DMS Customer Interface";
        InterfaceEntryHeaderVIPOut.Direction := InterfaceEntryHeaderVIPOut.Direction::Outbound;
        InterfaceEntryHeaderVIPOut.INSERT(true);

        InterfaceEntryLineVIPOut."Header Entry No." := InterfaceEntryHeaderVIPOut."Entry No.";
        InterfaceEntryLineVIPOut."Entry No." := 1;
        InterfaceEntryLineVIPOut.INSERT(true);

        InterfaceEntryLineVIPOut."Unit of Measure Code" := DMSInterfaceSetup."Facility Type";
        InterfaceEntryLineVIPOut.Description := Customer.Name;
        InterfaceEntryLineVIPOut."No." := Customer."No.";
        InterfaceEntryLineVIPOut."Description 2" := DMSInterfaceSetup."Branch Server ID";
        InterfaceEntryLineVIPOut.Name := DMSInterfaceSetup."Tax Loc Hierarchy Server ID";
        InterfaceEntryLineVIPOut."Posting Date" := Customer."Last Date Modified";
        if Customer.Blocked = Customer.Blocked::" " then
            InterfaceEntryLineVIPOut."Name 2" := 'INFY_FACILITY_ACTIVE'
        else
            InterfaceEntryLineVIPOut."Name 2" := 'INFY_FACILITY_INACTIVE';
        InterfaceEntryLineVIPOut."Phone No." := Customer."Phone No.";
        //HEI.04>>
        InterfaceEntryLineVIPOut."Country Name" := UPPERCASE(TENANTID());
        InterfaceEntryLineVIPOut."Item Designation" := UPPERCASE(COMPANYNAME);
        //HEI.04<<
        InterfaceEntryLineVIPOut.MODIFY(true);
    end;

    procedure ProcessDMSItemResponse(Item: Record Item);
    var
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        Item2: Record Item;
        DMSItemsInclExcl: Record "DMS Items Incl. Excl. FND";
        ItemExcluded: Boolean;
    // SalesDepositItemCharge: Record "Sales Deposit Item Charge";  // BC Upgrade NANDIS03
    begin
        if not DMSInterfaceSetup.GET() then
            exit;

        if not DMSInterfaceSetup."Enable DMS Interfaces" then
            exit;

        DMSInterfaceSetup.TESTFIELD("DMS Item Interface");
        InterfaceSetup.GET(DMSInterfaceSetup."DMS Item Interface");
        if not InterfaceSetup.Enabled then
            exit;

        Item2.RESET();
        DMSItemsInclExcl.RESET();

        Item2.SETRANGE("No.", Item."No.");
        Item2.SETFILTER("Item Category Code", DMSInterfaceSetup."Item Category Filter");
        Item2.SETRANGE(Blocked, false);
        if Item2.FINDFIRST() then begin
            ItemExcluded := false;
            if DMSItemsInclExcl.GET(Item."No.") then begin
                if DMSItemsInclExcl.Excluded then
                    ItemExcluded := true;
            end;

            if not ItemExcluded then begin
                InterfaceFrameworkMgtVIP.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CreateDMSItemResponse(Item);

                //Variant 2>>
                /*IF Item."Empty Good" THEN BEGIN
                  SalesDepositItemCharge.RESET;
                  SalesDepositItemCharge.SETRANGE("Empty Goods Item No.",Item."No.");
                  SalesDepositItemCharge.SETFILTER("Source No.",'<>%1','');
                  IF SalesDepositItemCharge.FINDSET THEN
                    REPEAT
                      CreateDMSItemResponse(Item,'Y',SalesDepositItemCharge."Source No.",SalesDepositItemCharge."Unit of Measure Code",SalesDepositItemCharge."Quantity per");
                    UNTIL SalesDepositItemCharge.NEXT = 0;
                END ELSE
                  CreateDMSItemResponse(Item,'N','','',0);*/
                //Varinat 2<<
            end;
        end;

    end;

    // BC Upgrade SHUKLP03 >> Table "Sales Deposit Item Charge" is of DIT >>
    procedure ProcessDMSDepositItemResponse(SalesDepositItemCharge: Record ItemClassification104FDW);
    var
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        Item: Record Item;
        Item2: Record Item;
        DMSItemsInclExcl: Record "DMS Items Incl. Excl. FND";
        ItemExcluded: Boolean;
    begin
        if not DMSInterfaceSetup.GET() then
            exit;

        if not DMSInterfaceSetup."Enable DMS Interfaces" then
            exit;

        DMSInterfaceSetup.TESTFIELD("DMS Item Interface");
        InterfaceSetup.GET(DMSInterfaceSetup."DMS Item Interface");
        if not InterfaceSetup.Enabled then
            exit;

        // if SalesDepositItemCharge."Source No." = '' then  // BC Upgrade SHUKLP03 << Obsolete.
        //     exit;

        Item.RESET();
        Item2.RESET();
        DMSItemsInclExcl.RESET();

        Item2.SETRANGE("No.", SalesDepositItemCharge."Item No.");
        Item2.SETFILTER("Item Category Code", DMSInterfaceSetup."Item Category Filter");
        Item2.SETFILTER(Blocked, '%1', false);
        if Item2.FINDFIRST() then begin
            ItemExcluded := false;
            if DMSItemsInclExcl.GET(SalesDepositItemCharge."Item No.") then begin
                if DMSItemsInclExcl.Excluded then
                    ItemExcluded := true;
            end;

            if not ItemExcluded then begin
                InterfaceFrameworkMgtVIP.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CreateDMSItemResponse(Item);

                //IF Item.GET(SalesDepositItemCharge."Empty Goods Item No.") THEN
                //CreateDMSItemResponse(Item,'Y',SalesDepositItemCharge."Source No.",SalesDepositItemCharge."Unit of Measure Code",SalesDepositItemCharge."Quantity per");
            end;
        end;
    end;
    // BC Upgrade SHUKLP03 << Replaced Table "Sales Deposit Item Charge" is of DIT <<

    local procedure CreateDMSItemResponse(Item: Record Item);
    var
        InterfaceEntryHeaderVIPOut: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIPOut: Record "Interface Entry Line VIP INT";
        InterfaceEntryLineVIP2: Record "Interface Entry Line VIP INT";
        SalesDepositItemCharge: Record ItemClassification104FDW;  // BC Upgrade SHUKLP03 << DIT table
        ItemSourceNo: record Item;   // BC Upgrade SHUKLP03 <<
        EntryNo: Integer;
        EntryNo2: Integer;
    begin
        CLEAR(InterfaceEntryHeaderVIPOut);
        CLEAR(InterfaceEntryLineVIPOut);
        EntryNo := 0;
        EntryNo2 := 0;

        if InterfaceEntryHeaderVIP.FINDLAST() then
            InterfaceEntryHeaderVIPOut."Entry No." := InterfaceEntryHeaderVIP."Entry No." + 1
        else
            InterfaceEntryHeaderVIPOut."Entry No." := 1;

        InterfaceEntryHeaderVIPOut."Interface Code" := DMSInterfaceSetup."DMS Item Interface";
        InterfaceEntryHeaderVIPOut.Direction := InterfaceEntryHeaderVIPOut.Direction::Outbound;
        InterfaceEntryHeaderVIPOut.INSERT(true);

        InterfaceEntryHeaderVIPOut.County := DELSTR(Item.Description, 18);
        InterfaceEntryHeaderVIPOut."Source No." := Item."No.";
        InterfaceEntryHeaderVIPOut."Your Reference" := DMSInterfaceSetup."Product Hierarchy";
        InterfaceEntryHeaderVIPOut.Description := Item.Description;
        InterfaceEntryHeaderVIPOut."Posting Date" := WORKDATE();
        ;
        //InterfaceEntryHeaderVIPOut."Document Date" := 0D; used default value in DED
        InterfaceEntryHeaderVIPOut.Address := Item.Description;
        InterfaceEntryHeaderVIPOut."External Document No." := Item."Sales Unit of Measure";
        // BC Upgrade NANDIS03 - Blocked as Empty Good is of DIT dependency >>
        // if Item."Empty Good" then
        //     InterfaceEntryHeaderVIPOut."Currency Code" := 'Y'
        // else
        //     InterfaceEntryHeaderVIPOut."Currency Code" := 'N';
        // BC Upgrade NANDIS03 - Blocked as Empty Good is of DIT dependency <<

        //BC Upgrade KUMBHS03 - Added IsEmty for DMS-ITEM Interface >>
        if Item."Is Empty Good 104FDW" then
            InterfaceEntryHeaderVIPOut."Currency Code" := 'Y'
        else
            InterfaceEntryHeaderVIPOut."Currency Code" := 'N';
        // BC Upgrade KUMBHS03 - Added IsEmty for DMS-ITEM Interface <<

        //HEI.04>>
        InterfaceEntryHeaderVIPOut.Name := UPPERCASE(TENANTID());
        InterfaceEntryHeaderVIPOut."Message Name" := UPPERCASE(COMPANYNAME);
        //HEI.04<<
        InterfaceEntryHeaderVIPOut.MODIFY(true);

        // BC Upgrade SHUKLP03 >> Resructured code because table and field mapping has been changed.
        ItemSourceNo.RESET();
        ItemSourceNo.SETFILTER("Code 104FDW", '<>%1', '');
        ItemSourceNo.SetRange("Is Empty Good 104FDW", FALSE);
        IF ItemSourceNo.FindSet() Then
            repeat
                SalesDepositItemCharge.RESET();
                SalesDepositItemCharge.SETRANGE("Item No.", Item."No.");
                // SalesDepositItemCharge.SETFILTER("Source No.", '<>%1&<>%2', '', Item."No.");
                SalesDepositItemCharge.SETRANGE("Empty Goods Code", ItemSourceNo."Code 104FDW");
                if SalesDepositItemCharge.FINDFIRST() then begin
                    InterfaceEntryLineVIP2.RESET();
                    InterfaceEntryLineVIP2.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIPOut."Entry No.");
                    InterfaceEntryLineVIP2.SETRANGE("No.", ItemSourceNo."No.");
                    if not InterfaceEntryLineVIP2.FINDFIRST() then begin
                        EntryNo2 += 1;

                        InterfaceEntryLineVIPOut."Header Entry No." := InterfaceEntryHeaderVIPOut."Entry No.";
                        InterfaceEntryLineVIPOut."Entry No." := EntryNo2;
                        InterfaceEntryLineVIPOut.INSERT(true);

                        InterfaceEntryLineVIPOut."No." := ItemSourceNo."No.";
                        InterfaceEntryLineVIPOut."Unit of Measure Code" := ItemSourceNo."Base Unit of Measure";
                        InterfaceEntryLineVIPOut.Quantity := SalesDepositItemCharge."Qty. Per Base UOM";
                        InterfaceEntryLineVIPOut.MODIFY(true);
                    end;
                END;
            until ItemSourceNo.NEXT() = 0;
        // BC Upgrade SHUKLP03 << Resructured code because table and field mapping has been changed.

        //Variant 2>>
        // InterfaceEntryLineVIPOut."Header Entry No." := InterfaceEntryHeaderVIPOut."Entry No.";
        // InterfaceEntryLineVIPOut."Entry No." := 1;
        // InterfaceEntryLineVIPOut.INSERT(TRUE);
        //
        // InterfaceEntryLineVIPOut.Name := DELSTR(Item.Description,20);
        // InterfaceEntryLineVIPOut."No." := Item."No.";
        // InterfaceEntryLineVIPOut."Country Name" := DMSInterfaceSetup."Product Hierarchy";
        // InterfaceEntryLineVIPOut.Description := Item.Description;
        // InterfaceEntryLineVIPOut."Posting Date" := WORKDATE;
        // //InterfaceEntryLineVIPOut."Expected Delivery Date" := 0D;
        // InterfaceEntryLineVIPOut."Description 2" := Item.Description;
        // InterfaceEntryLineVIPOut."Post Code" := Item."Sales Unit of Measure";
        //
        // InterfaceEntryLineVIPOut."External Contract No." := EmptyItem;
        // InterfaceEntryLineVIPOut."Item Code" := SourceNo;
        // InterfaceEntryLineVIPOut."Unit of Measure Code" := UoM;
        // InterfaceEntryLineVIPOut."Line Amount" := QtyPer;

        //InterfaceEntryLineVIPOut.MODIFY(TRUE);
        //Variant 2<<
    end;

    procedure ProcessDMSShipmentResponse(SalesShipmentHeader: Record "Sales Shipment Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        Customer: Record Customer;
        SalesShipmentLine: Record "Sales Shipment Line";
        Item: Record Item;
        DMSItemsInclExcl: Record "DMS Items Incl. Excl. FND";
        OutboundInterface: Record "Outbound Interface INT";
        ItemIncluded: Boolean;
    begin
        if not DMSInterfaceSetup.GET() then
            exit;

        if not DMSInterfaceSetup."Enable DMS Interfaces" then
            exit;

        DMSInterfaceSetup.TESTFIELD("DMS Shipment Interface");
        InterfaceSetup.GET(DMSInterfaceSetup."DMS Shipment Interface");
        if not InterfaceSetup.Enabled then
            exit;

        Customer.RESET();
        Customer.SETRANGE("No.", SalesShipmentHeader."Sell-to Customer No.");
        Customer.SETFILTER("Account Group FND", DMSInterfaceSetup."Customer Acc Group Filter");
        if not Customer.FINDFIRST() then
            exit;

        SalesShipmentLine.RESET();
        SalesShipmentLine.SETRANGE("Document No.", SalesShipmentHeader."No.");
        SalesShipmentLine.SETRANGE(Type, SalesShipmentLine.Type::Item);
        SalesShipmentLine.SETFILTER(Quantity, '>%1', 0); //HEI.02
        if SalesShipmentLine.findset() then
            repeat
                Item.SETRANGE("No.", SalesShipmentLine."No.");
                Item.SETFILTER("Item Category Code", DMSInterfaceSetup."Item Category Filter");
                if Item.FINDFIRST() then begin
                    ItemIncluded := true;
                    if DMSItemsInclExcl.GET(SalesShipmentLine."No.") then
                        if DMSItemsInclExcl.Excluded then
                            ItemIncluded := false;
                end else
                    if DMSItemsInclExcl.GET(SalesShipmentLine."No.") then
                        if DMSItemsInclExcl.Included then
                            ItemIncluded := true;

            until (SalesShipmentLine.NEXT() = 0) or ItemIncluded;

        if ItemIncluded then begin
            InterfaceFrameworkMgtVIP.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CreateDMSShipmentResponse(SalesShipmentHeader);
        end;
    end;

    local procedure CreateDMSShipmentResponse(SalesShipmentHeader: Record "Sales Shipment Header");
    var
        InterfaceEntryHeaderVIPOut: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIPOut: Record "Interface Entry Line VIP INT";
        SalesShipmentLine: Record "Sales Shipment Line";
        Item: Record Item;
        DMSItemsInclExcl: Record "DMS Items Incl. Excl. FND";
        TotalAmountInclVAT: Decimal;
        LineAmount: Decimal;
        VATAmount: Decimal;
        EntryNo: Integer;
        EntryNo2: Integer;
        ItemExcluded: Boolean;
        ItemIncluded: Boolean;
        ItemFound: Boolean;
        OrderSeqId: Integer;
    begin
        CLEAR(InterfaceEntryHeaderVIPOut);
        CLEAR(InterfaceEntryLineVIPOut);
        EntryNo := 0;
        EntryNo2 := 0;

        if InterfaceEntryHeaderVIP.FINDLAST() then
            InterfaceEntryHeaderVIPOut."Entry No." := InterfaceEntryHeaderVIP."Entry No." + 1
        else
            InterfaceEntryHeaderVIPOut."Entry No." := 1;

        InterfaceEntryHeaderVIPOut."Interface Code" := DMSInterfaceSetup."DMS Shipment Interface";
        InterfaceEntryHeaderVIPOut.Direction := InterfaceEntryHeaderVIPOut.Direction::Outbound;
        InterfaceEntryHeaderVIPOut.INSERT(true);

        InterfaceEntryHeaderVIPOut."Source No." := SalesShipmentHeader."No.";
        InterfaceEntryHeaderVIPOut."External Document No." := DMSInterfaceSetup."Branch Server ID Ship";
        InterfaceEntryHeaderVIPOut."Global No." := DMSInterfaceSetup.OrderType;
        //HEI.05>>
        //InterfaceEntryHeaderVIPOut."Document Date" := SalesShipmentHeader."Order Date";
        InterfaceEntryHeaderVIPOut."Delivery Method" := FORMAT(SalesShipmentHeader."Order Date", 0, '<Year4>-<Month,2>-<Day,2>');
        //HEI.05<<
        InterfaceEntryHeaderVIPOut."Bill-to Customer No." := DMSInterfaceSetup."PO Status";
        InterfaceEntryHeaderVIPOut."Pay-to Vendor No." := DMSInterfaceSetup."PO Type";
        // BC Upgrade NANDIS03 - Blocked as fields are of DIT >>
        // SalesShipmentHeader.CALCFIELDS("Amount Including VAT");
        // InterfaceEntryHeaderVIPOut.Amount := SalesShipmentHeader."Amount Including VAT";
        // BC Upgrade NANDIS03 - Blocked as fields are of DIT <<

        // BC Upgrade KUMBHS03 added code for Amount Including VAT to get outbound entry Amt >>
        Clear(LineAmount);
        Clear(VATAmount);
        Clear(TotalAmountInclVAT);

        SalesShipmentLine.RESET();
        SalesShipmentLine.SETRANGE("Document No.", SalesShipmentHeader."No.");
        SalesShipmentLine.SETRANGE(Type, SalesShipmentLine.Type::Item);
        SalesShipmentLine.SETFILTER(Quantity, '>%1', 0); //HEI.02
        if SalesShipmentLine.findset() then
            repeat
                // Calculate Line Amount (excluding VAT)
                LineAmount := SalesShipmentLine.Quantity * SalesShipmentLine."Unit Price";
                // Calculate VAT Amount
                VATAmount := LineAmount * SalesShipmentLine."VAT %" / 100;
                TotalAmountInclVAT += LineAmount + VATAmount;
            until SalesShipmentLine.Next() = 0;

        InterfaceEntryHeaderVIPOut.Amount := TotalAmountInclVAT;
        // BC Upgrade KUMBHS03 added code for Amount Including VAT to get outbound entry Amt <<

        //HEI.05>>
        //InterfaceEntryHeaderVIPOut."Posting Date":= SalesShipmentHeader."Posting Date";
        InterfaceEntryHeaderVIPOut.Description := FORMAT(SalesShipmentHeader."Posting Date", 0, '<Year4>-<Month,2>-<Day,2>');
        //HEI.05<<
        InterfaceEntryHeaderVIPOut."Buy-from Vendor No." := DMSInterfaceSetup."Vendor ID";
        InterfaceEntryHeaderVIPOut."Sell-to Customer No." := SalesShipmentHeader."Sell-to Customer No.";
        //HEI.04>>
        InterfaceEntryHeaderVIPOut."Vendor Shipment No." := SalesShipmentHeader."Order No.";
        InterfaceEntryHeaderVIPOut.Name := UPPERCASE(TENANTID());
        InterfaceEntryHeaderVIPOut."Message Name" := UPPERCASE(COMPANYNAME);
        //HEI.04<<
        //HEI.06>>
        // BC Upgrade NANDIS03 - Blocked as fields are of DIT >>
        // InterfaceEntryHeaderVIPOut."Type ID" := SalesShipmentHeader."Truck Code";
        // InterfaceEntryHeaderVIPOut."Payment Terms Code" := SalesShipmentHeader."Driver Code";
        // BC Upgrade NANDIS03 - Blocked as fields are of DIT <<

        // BC Upgrade KUMBHS03 - mapped with new fields >>
        InterfaceEntryHeaderVIPOut."Type ID" := SalesShipmentHeader."Vehicle Code 101FDW";
        InterfaceEntryHeaderVIPOut."Payment Terms Code" := SalesShipmentHeader."Log Driver 107FDW";
        // BC Upgrade KUMBHS03 - mapped with new fields <<
        //HEI.06<<
        InterfaceEntryHeaderVIPOut.MODIFY(true);

        SalesShipmentLine.RESET();
        SalesShipmentLine.SETRANGE("Document No.", SalesShipmentHeader."No.");
        SalesShipmentLine.SETRANGE(Type, SalesShipmentLine.Type::Item);
        SalesShipmentLine.SETFILTER(Quantity, '>%1', 0); //HEI.02
        if SalesShipmentLine.findset() then
            repeat
                ItemIncluded := false;
                ItemExcluded := false;
                ItemFound := false;

                Item.SETRANGE("No.", SalesShipmentLine."No.");
                Item.SETFILTER("Item Category Code", DMSInterfaceSetup."Item Category Filter");
                if Item.FINDFIRST() then begin
                    ItemFound := true;
                    if DMSItemsInclExcl.GET(SalesShipmentLine."No.") then
                        if DMSItemsInclExcl.Excluded then
                            ItemExcluded := true;
                end else begin
                    if DMSItemsInclExcl.GET(SalesShipmentLine."No.") then
                        if DMSItemsInclExcl.Included then
                            ItemIncluded := true;
                end;

                if (not ItemExcluded and ItemFound) or ItemIncluded then begin
                    OrderSeqId += 1; //HEI.08

                    //HEI.07>>
                    if (DMSInterfaceSetup."Lot Sent Enable" = true) and (CheckExistDMSShipmentLinesWithLot(SalesShipmentLine) = true) then
                        //HEI.08>>
                        //CreateDMSShipmentLinesWithLot(SalesShipmentLine,InterfaceEntryHeaderVIPOut."Entry No.")
                        CreateDMSShipmentLinesWithLot(SalesShipmentLine, InterfaceEntryHeaderVIPOut."Entry No.", EntryNo2, OrderSeqId)
                    //HEI.08<<
                    else begin
                        //HEI.07<<

                        EntryNo2 += 1;

                        InterfaceEntryLineVIPOut."Header Entry No." := InterfaceEntryHeaderVIPOut."Entry No.";
                        InterfaceEntryLineVIPOut."Entry No." := EntryNo2;
                        InterfaceEntryLineVIPOut.INSERT(true);

                        //HEI.03>>
                        //InterfaceEntryLineVIPOut."Item Code" := DELSTR(FORMAT(SalesShipmentLine."Line No."),2);
                        //InterfaceEntryLineVIPOut."Item Code" := FORMAT(InterfaceEntryLineVIPOut."Entry No."); //HEI.08
                        //HEI.03<<
                        InterfaceEntryLineVIPOut."Item Code" := FORMAT(OrderSeqId); //HEI.08
                        InterfaceEntryLineVIPOut."No." := SalesShipmentLine."No.";
                        InterfaceEntryLineVIPOut.Description := SalesShipmentLine.Description;
                        InterfaceEntryLineVIPOut."Unit of Measure Code" := SalesShipmentLine."Unit of Measure Code";
                        InterfaceEntryLineVIPOut."Unit Amount" := SalesShipmentLine."Unit Price";
                        InterfaceEntryLineVIPOut.Quantity := SalesShipmentLine.Quantity;
                        // InterfaceEntryLineVIPOut."Line Amount" := SalesShipmentLine."Amount Including VAT";  // BC Upgrade NANDIS03 - Blocked as fields are of DIT 

                        // BC Upgrade KUMBHS03 added code for Amount Including VAT at line >>
                        // Calculate Line Amount (excluding VAT)
                        LineAmount := SalesShipmentLine.Quantity * SalesShipmentLine."Unit Price";
                        // Calculate VAT Amount
                        VATAmount := LineAmount * SalesShipmentLine."VAT %" / 100;
                        InterfaceEntryLineVIPOut."Line Amount" := LineAmount + VATAmount;
                        // BC Upgrade KUMBHS03 added code for Amount Including VAT at line <<

                        InterfaceEntryLineVIPOut.MODIFY(true);
                    end;//HEI.07
                end;
            until SalesShipmentLine.NEXT() = 0;
    end;

    procedure ProcessDMSPaymentRequest(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLine2: Record "Gen. Journal Line";
        LineNo: Integer;
        GenJournalBatch: Record "Gen. Journal Batch";
        DocumentNo: Code[20];
        //NoSeriesManagement: Codeunit NoSeriesManagement;  // BC Upgrade SHUKLP03 << Removed from Business central.
        NoSeriesL: Codeunit "No. Series";   // BC Upgrade SHUKLP03 <<
        APIInterfaceSetup: Record "API Interface Setup2 INT";
        DocType: Integer;
    begin
        if not DMSInterfaceSetup.GET() then
            exit;

        if not DMSInterfaceSetup."Enable DMS Interfaces" then
            exit;

        if not APIInterfaceSetup.GET() then
            exit;

        APIInterfaceSetup.TESTFIELD("API Payment Interface");
        InterfaceSetup.GET(APIInterfaceSetup."API Payment Interface");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceEntryLineVIP.RESET();
        InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        if InterfaceEntryLineVIP.findset() then begin
            GenJournalLine2.RESET();
            GenJournalLine2.SETRANGE("Journal Template Name", APIInterfaceSetup."Cash Journal Template");
            GenJournalLine2.SETRANGE("Journal Batch Name", APIInterfaceSetup."Cash Journal Batch");
            if GenJournalLine2.FINDLAST() then
                LineNo := GenJournalLine2."Line No." + 10000;

            GenJournalBatch.GET(APIInterfaceSetup."Cash Journal Template", APIInterfaceSetup."Cash Journal Batch");
            DocumentNo := NoSeriesL.GetNextNo(GenJournalBatch."No. Series", InterfaceEntryLineVIP."Posting Date", false);  // BC Upgrade SHUKLP03 << Replaced NoSeriesManagement with "No. Series" codeunit.

            repeat
                GenJournalLine.INIT();
                GenJournalLine.VALIDATE("Journal Template Name", APIInterfaceSetup."Cash Journal Template");
                GenJournalLine.VALIDATE("Journal Batch Name", APIInterfaceSetup."Cash Journal Batch");
                GenJournalLine.VALIDATE("Line No.", LineNo);
                GenJournalLine.INSERT(true);
                LineNo += 10000;

                GenJournalLine.VALIDATE("Posting Date", InterfaceEntryLineVIP."Posting Date");
                // GenJournalLine.VALIDATE("Document Type", InterfaceEntryLineVIP."Qty. per Unit of Measure");  // BC Upgrade NANDIS03 - need to restructure later
                //BC Upgrade GUNREM01 added case statement to map Document Type >>
                case InterfaceEntryLineVIP."Qty. per Unit of Measure" of
                    1:
                        DocType := "Gen. Journal Document Type"::Payment.AsInteger();
                    2:
                        DocType := "Gen. Journal Document Type"::Invoice.AsInteger();
                    3:
                        DocType := "Gen. Journal Document Type"::"Credit Memo".AsInteger();
                    4:
                        DocType := "Gen. Journal Document Type"::"Finance Charge Memo".AsInteger();
                    5:
                        DocType := "Gen. Journal Document Type"::Reminder.AsInteger();
                    6:
                        DocType := "Gen. Journal Document Type"::Refund.AsInteger();
                    else
                        DocType := "Gen. Journal Document Type"::" ".AsInteger();
                end;
                GenJournalLine.VALIDATE("Document Type", DocType);
                //BC Upgrade GUNREM01 added case statement to map Document Type <<
                GenJournalLine.VALIDATE("Document No.", DocumentNo);
                GenJournalLine.VALIDATE("Bal. Account No.", GenJournalBatch."Bal. Account No.");
                GenJournalLine.VALIDATE("External Document No.", InterfaceEntryLineVIP.Address);
                GenJournalLine.VALIDATE("Account Type", InterfaceEntryLineVIP.Type);
                GenJournalLine.SetHideValidation(true);
                GenJournalLine.VALIDATE("Account No.", InterfaceEntryLineVIP."Customer Code");
                GenJournalLine.VALIDATE(Amount, -InterfaceEntryLineVIP."Line Amount");
                if InterfaceEntryLineVIP."Amount Incl. VAT" <> 0 then
                    GenJournalLine.VALIDATE("Amount (LCY)", -InterfaceEntryLineVIP."Amount Incl. VAT");
                if InterfaceEntryLineVIP."Currency Code" <> '' then
                    GenJournalLine.VALIDATE("Currency Code", InterfaceEntryLineVIP."Currency Code");
                //GenJournalLine.VALIDATE("Item Charge Type", InterfaceEntryLineVIP.Quantity);  // BC Upgrade NANDIS03 - Dependency on DIT field
                GenJournalLine.VALIDATE("Payment Method Code", InterfaceEntryLineVIP."Payment Terms Code");
                GenJournalLine.VALIDATE("Applies-to ID", InterfaceEntryLineVIP.Description);
                GenJournalLine.MODIFY(true);
            until InterfaceEntryLineVIP.NEXT() = 0;
        end;
    end;

    local procedure CreateDMSShipmentLinesWithLot(SalesShipLine: Record "Sales Shipment Line"; VIPHeaderEntryNo: Integer; var VIPLineEntryNo: Integer; OrderSeqId: Integer);
    var
        ItemEntryRelation: Record "Item Entry Relation";
        InterfaceEntryLineVIPOut: Record "Interface Entry Line VIP INT";
        ItemLedgEntry: Record "Item Ledger Entry";
        LineAmount: Decimal;
        VATAmount: Decimal;
    begin
        //HEI.07>>
        ItemEntryRelation.SETCURRENTKEY("Source ID", "Source Type");
        ItemEntryRelation.SETRANGE("Source Type", DATABASE::"Sales Shipment Line");
        ItemEntryRelation.SETRANGE("Source Subtype", 0);
        ItemEntryRelation.SETRANGE("Source ID", SalesShipLine."Document No.");
        ItemEntryRelation.SETRANGE("Source Batch Name", '');
        ItemEntryRelation.SETRANGE("Source Prod. Order Line", 0);
        ItemEntryRelation.SETRANGE("Source Ref. No.", SalesShipLine."Line No.");
        if ItemEntryRelation.findset(false) then
            repeat
                LineAmount := 0;
                VATAmount := 0;
                //HEI.08>>
                //EntryNo += 1;
                VIPLineEntryNo += 1;
                //HEI.08<<

                InterfaceEntryLineVIPOut."Header Entry No." := VIPHeaderEntryNo;

                //HEI.08>>
                /*
                InterfaceEntryLineVIPOut."Entry No." := EntryNo;
                InterfaceEntryLineVIPOut.INSERT(TRUE);
                InterfaceEntryLineVIPOut."Item Code" := FORMAT(InterfaceEntryLineVIPOut."Entry No.");
                */
                InterfaceEntryLineVIPOut."Entry No." := VIPLineEntryNo;
                InterfaceEntryLineVIPOut."Item Code" := FORMAT(OrderSeqId);
                //HEI.08<<
                InterfaceEntryLineVIPOut."No." := SalesShipLine."No.";
                InterfaceEntryLineVIPOut.Description := SalesShipLine.Description;
                InterfaceEntryLineVIPOut."Unit of Measure Code" := SalesShipLine."Unit of Measure Code";
                InterfaceEntryLineVIPOut."Unit Amount" := SalesShipLine."Unit Price";
                InterfaceEntryLineVIPOut.Quantity := SalesShipLine.Quantity;
                // InterfaceEntryLineVIPOut."Line Amount" := SalesShipLine."Amount Including VAT";  // BC Upgrade NANDIS03 - Blocked as fields are of DIT >>

                // BC Upgrade KUMBHS03 added code for Amount Including VAT at line >>
                // Calculate Line Amount (excluding VAT)
                LineAmount := SalesShipLine.Quantity * SalesShipLine."Unit Price";
                // Calculate VAT Amount
                VATAmount := LineAmount * SalesShipLine."VAT %" / 100;
                //TotalAmountInclVAT := LineAmount + VATAmount;
                InterfaceEntryLineVIPOut."Line Amount" := LineAmount + VATAmount;
                // BC Upgrade KUMBHS03 added code for Amount Including VAT at line <<

                InterfaceEntryLineVIPOut."Batch No. (Lot No.)" := ItemEntryRelation."Lot No.";
                ItemLedgEntry.GET(ItemEntryRelation."Item Entry No.");
                //HEI.09>>
                //InterfaceEntryLineVIPOut."Best Before Date" := ItemLedgEntry."Expiration Date";
                InterfaceEntryLineVIPOut."Description 2" := FORMAT(ItemLedgEntry."Expiration Date", 0, '<Year4>-<Month,2>-<Day,2>');
                //HEI.09<<
                //HEI.08>>
                //InterfaceEntryLineVIPOut.MODIFY(TRUE);
                InterfaceEntryLineVIPOut.INSERT(true);
            //HEI.08<<
            until ItemEntryRelation.NEXT() = 0;
        //HEI.07<<

    end;

    local procedure CheckExistDMSShipmentLinesWithLot(SalesShipLine: Record "Sales Shipment Line"): Boolean;
    var
        ItemEntryRelation: Record "Item Entry Relation";
    begin
        //HEI.07>>
        ItemEntryRelation.SETCURRENTKEY("Source ID", "Source Type");
        ItemEntryRelation.SETRANGE("Source Type", DATABASE::"Sales Shipment Line");
        ItemEntryRelation.SETRANGE("Source Subtype", 0);
        ItemEntryRelation.SETRANGE("Source ID", SalesShipLine."Document No.");
        ItemEntryRelation.SETRANGE("Source Batch Name", '');
        ItemEntryRelation.SETRANGE("Source Prod. Order Line", 0);
        ItemEntryRelation.SETRANGE("Source Ref. No.", SalesShipLine."Line No.");
        if ItemEntryRelation.ISEMPTY then
            exit(false);
        exit(true);
        //HEI.07<<
    end;
}

