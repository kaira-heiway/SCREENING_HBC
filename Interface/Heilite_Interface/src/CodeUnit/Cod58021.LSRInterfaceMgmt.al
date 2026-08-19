codeunit 58021 "LSR Interface Mgmt."
{
    // Heilite Navision Old Id - 50137

    // version HEI.10

    // HEI.01 FDD-HB899 - CHG2044703 IBM GAVANM01 13.12.2020 # New POS System Required for OPCO
    //   # New object created for LSR Interfaces
    // HEI.02 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New functions:  ProcessPayments, GetAccountReceivablesNo, GetDimensionLocationMappingCP, GetPaymentGLAccount,
    //                     ProcessLSRPurchaseReceipt, SendPurchOrderToLSR, ProcessLSRPurchOrder
    // HEI.03 FDD-HB899 - CHG2093869 IBM NASTAA02 23.02.2021 # LSR - Transfer and Stock
    //   # New Functions created: "ProcessLSRTransferShipmentInbound", "ProcessLSRTransferReceiptInbound", "ProcessLSRTransferReceiptOutbound", "CreateLSRTransferReceiptResponse",
    //                            "ProcessLSRStockAdjustment", "ProcessLSRStockImageHeader", "ProcessLSRStockImageLine", "CreateReservationEntry"
    // HEI.04 CHG2093869 GAVANM01 05.03.2021 #Transfer and Stock adjustments interfaces Bahamas LS Retail
    //         # New Functions created: ProcessLSRTransferOrderInbound, ProcessLSRTransferOrderDeletionInbound, ProcessLSRTransferShipmentOutbound
    // HEI.05 INC3797825 - CHG2132587 IBM NASTAA02 28.10.2021 # Transfer Order not processed in VIP inbound for LS Retail
    //   # Whse Receipt Lines not received from the interface should not be created/posted
    // HEI.06 INC3797838 - CHG2132591 IBM NASTAA02 05.11.2021 # Transfer Order is unable to be processed
    //   # Reclass Item Jnl should be re-processed in case of failure
    // HEI.07 INC3954814 - CHG2145179 IBM NASTAA02 03.02.2022 # VIP Error Log Entry 6411 - The Location does not exist. Identification fields and values: Code=''
    //   # 'LocationTo' and 'LocationFrom' are obsolete. Commented the GET functions for them
    // HEI.08 CHG2218784 IMB SISUM01 28/09/2023 HB3460 - LSR- Transfer Shipment to Automatically Link- Bahamas
    //   # create function CheckNotExistsBinContent and CheckAndCreateBinContent
    // HEI.09 CHG2216722 IBM SISUM01 03.10.2023 Request for email functionality for Transfer Order Creation
    //   # Add send emails for LSR transfers
    // HEI.10 CHG2227143 IBM COSTE04 18.03.2024 Item Reclass to Support LSR Integrations-Dev
    //   # New functions: OpenItemReclassJournal, CreateItemReclassJournalFromWhseReceipt, PostItemReclessJournal
    // HEI.11 CHG2290087 IBM COSTE04 07.04.2025-HB3894-Payouts Posting from LSR
    //   # Add Balance account from setup
    // HEI.12 CHG2285564 HB4207 IBM BHANDS01 01.07.2025 LSR Release Upgrade from V16 to V25
    //   # Added new tags in the ProcessLSRTransferOrderInbound LSR-TO request XML structure "ShippingAgentCode", "ShippingAgentService"

    //BC Upgrade SHIKHD02>>
    //Missing HEI.11 code added
    //Added missing variables "CashRcptBalGLAccount" and "BalAccount" in procedure ProcessPayments() to align as per NAV HEI.11 
    //Added code for Selecting the correct journal and balance account based on Location and Payment Method in procedure ProcessPayments() to align as per NAV HEI.11  
    //Blocked LSRInterfaceSetup validation and added and added GenJournalBatch validation in procedure ProcessPayments() to align as per NAV HEI.11 
    //Blocked Cross-Ref based if-condition and added if-else logic using BalAccount in procedure ProcessPayments() to align with NAV HEI.11
    //BC Upgrade SHIKHD02<<

    // BC UPGRADE PATELS08 >>
    // # Table name changed from "LSR Master Included/Excluded" to "LSR Master Inc/Exc FND"
    // # HEI.11 and HEI.12 Tags added to documentation.
    // # Added Code related to HEI.12, Code related to HEI.11 alread present.
    // BC UPGRADE PATELS08 <<
    // BC Upgrade PATELP08>>
    // Changed name of table from "Cash Rcpt Bal G/L Account" to "Cash Rcpt Bal G/L Account FND"
    // BC Upgrade PATELP08<<

    trigger OnRun();
    begin
        TryCreateItemReclassJournalFromWhseReceipt();//HEI.10
    end;

    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        GeneralInterfaceSetupRead: Boolean;
        LSRInterfaceSetup: Record "LSR Interface Setup INT";
        LSRInterfaceSetupRead: Boolean;
        InterfaceFrameworkMgtVIP: Codeunit "Interface Framework Mgt. VIP";
        CCCDimensionCode: Code[20];
        CCCDimensionValue: Code[20];
        TODoesntExistErr: Label 'LSR Transfer Order %1 doesn''t exist.';
        TSDoesntExistErr: Label 'Shipment for LSR Transfer Order %1 doesn''t exist.';
        WhseReceiptHeader: Record "Warehouse Receipt Header";
        ItemReclassErr: Label 'Item Reclassification Entries are not posted successfully, please process them manually!';

    procedure ProcessLSRCustomerOutbound(CustomerToSend: Record Customer; CustomerNew: Record Customer; CustomerOld: Record Customer; CheckFields: Boolean; IsBillToCust: Boolean);
    var
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
    begin
        //check the setup
        if not LSRInterfaceSetup.GET() or not LSRInterfaceSetup."Enable LSR Interface" then
            exit;
        LSRInterfaceSetup.TESTFIELD("LSR Customer Interface");
        InterfaceSetup.GET(LSRInterfaceSetup."LSR Customer Interface");
        if not InterfaceSetup.Enabled then
            exit;

        if CustomerIsValid(CustomerToSend, CustomerNew, CustomerOld, CheckFields, IsBillToCust) then begin
            InterfaceFrameworkMgtVIP.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CreateLSRCustomerOutbound(CustomerToSend);
        end;
    end;

    local procedure CreateLSRCustomerOutbound(Customer: Record Customer);
    var
        InterfaceEntryHeaderVIPOut: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIPOut: Record "Interface Entry Line VIP INT";
        EntryNo: Integer;
        BillToCustomer: Record Customer;
    begin
        CLEAR(InterfaceEntryHeaderVIPOut);
        CLEAR(InterfaceEntryLineVIPOut);
        EntryNo := 0;

        if InterfaceEntryHeaderVIP.FINDLAST() then
            InterfaceEntryHeaderVIPOut."Entry No." := InterfaceEntryHeaderVIP."Entry No." + 1
        else
            InterfaceEntryHeaderVIPOut."Entry No." := 1;

        InterfaceEntryHeaderVIPOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderVIPOut."Interface Code" := LSRInterfaceSetup."LSR Customer Interface";
        InterfaceEntryHeaderVIPOut.Direction := InterfaceEntryHeaderVIPOut.Direction::Outbound;
        InterfaceEntryHeaderVIPOut."Source Type" := DATABASE::Customer;
        InterfaceEntryHeaderVIPOut."Source No." := Customer."No.";
        InterfaceEntryHeaderVIPOut.INSERT(true);

        InterfaceEntryLineVIPOut."Header Entry No." := InterfaceEntryHeaderVIPOut."Entry No.";
        InterfaceEntryLineVIPOut."Entry No." := 1;
        InterfaceEntryLineVIPOut.INSERT(true);

        InterfaceEntryLineVIPOut."No." := Customer."No.";
        InterfaceEntryLineVIPOut.Description := Customer.Name;
        InterfaceEntryLineVIPOut."Search Name" := Customer."Search Name";
        InterfaceEntryLineVIPOut."Name 2" := Customer."Name 2";
        InterfaceEntryLineVIPOut.Address := Customer.Address;
        InterfaceEntryLineVIPOut."Address 2" := Customer."Address 2";
        InterfaceEntryLineVIPOut.City := Customer.City;
        InterfaceEntryLineVIPOut."Post Code" := Customer."Post Code";
        InterfaceEntryLineVIPOut."Country Code" := Customer."Country/Region Code";
        InterfaceEntryLineVIPOut."Phone No." := Customer."Phone No.";

        BillToCustomer.RESET();
        if BillToCustomer.GET(Customer."Bill-to Customer No.") then begin
            InterfaceEntryLineVIPOut."Cust/Vend. Posting Group" := BillToCustomer."Customer Posting Group";
            InterfaceEntryLineVIPOut."Gen. Bus. Posting Group" := BillToCustomer."Gen. Bus. Posting Group";
            InterfaceEntryLineVIPOut."VAT Bus. Posting Group" := BillToCustomer."VAT Bus. Posting Group";
            InterfaceEntryLineVIPOut."Currency Code" := BillToCustomer."Currency Code";
            InterfaceEntryLineVIPOut."Payment Method Code" := BillToCustomer."Payment Method Code";
            InterfaceEntryLineVIPOut."Payment Terms Code" := BillToCustomer."Payment Terms Code";
            InterfaceEntryLineVIPOut."VAT Registration No" := BillToCustomer."VAT Registration No.";
        end else begin
            InterfaceEntryLineVIPOut."Cust/Vend. Posting Group" := Customer."Customer Posting Group";
            InterfaceEntryLineVIPOut."Gen. Bus. Posting Group" := Customer."Gen. Bus. Posting Group";
            InterfaceEntryLineVIPOut."VAT Bus. Posting Group" := Customer."VAT Bus. Posting Group";
            InterfaceEntryLineVIPOut."Currency Code" := Customer."Currency Code";
            InterfaceEntryLineVIPOut."Payment Method Code" := Customer."Payment Method Code";
            InterfaceEntryLineVIPOut."Payment Terms Code" := Customer."Payment Terms Code";
            InterfaceEntryLineVIPOut."VAT Registration No" := Customer."VAT Registration No.";
        end;

        InterfaceEntryLineVIPOut."Shipment Method Code" := Customer."Shipment Method Code";
        //InterfaceEntryLineVIPOut."Block reason" := Customer.Blocked;
        if Customer.Blocked = Customer.Blocked::All then
            InterfaceEntryLineVIPOut."Block reason" := 1;

        InterfaceEntryLineVIPOut."Location Code" := Customer."Location Code";

        InterfaceEntryLineVIPOut.MODIFY(true);
    end;

    procedure CustomerIsValid(CustomerToSend: Record Customer; CustomerNew: Record Customer; CustomerOld: Record Customer; CheckFields: Boolean; IsBillToCust: Boolean): Boolean;
    var
        Customer: Record Customer;
        CustomersIncludeExclude: Record "LSR Master Inc/Exc FND";
    begin
        CustomersIncludeExclude.RESET();
        Customer.RESET();

        Customer.SETRANGE("No.", CustomerToSend."No.");
        Customer.SETRANGE("Flag for Deletion FND", false);
        if not CustomersIncludeExclude.GET(CustomersIncludeExclude.Type::Customer, CustomerToSend."No.") then
            Customer.SETFILTER("Account Group FND", LSRInterfaceSetup."Customer Acc Group Filter");
        if Customer.FINDFIRST() then begin
            if CustomersIncludeExclude.Code <> '' then
                if CustomersIncludeExclude.Excluded then
                    exit(false);
        end else
            exit(false);

        if CheckFields then
            if not IsBillToCust then begin
                if (CustomerNew.Name = CustomerOld.Name) and
                (CustomerNew."Search Name" = CustomerOld."Search Name") and
                (CustomerNew."Name 2" = CustomerOld."Name 2") and
                (CustomerNew.Address = CustomerOld.Address) and
                (CustomerNew."Address 2" = CustomerOld."Address 2") and
                (CustomerNew.City = CustomerOld.City) and
                (CustomerNew."Post Code" = CustomerOld."Post Code") and
                (CustomerNew."Country/Region Code" = CustomerOld."Country/Region Code") and
                (CustomerNew."Phone No." = CustomerOld."Phone No.") and
                (CustomerNew."Shipment Method Code" = CustomerOld."Shipment Method Code") and
                (CustomerNew.Blocked = CustomerOld.Blocked) and
                (CustomerNew."Location Code" = CustomerOld."Location Code") and
                ((CustomerNew."Bill-to Customer No." <> '') or
                  (CustomerNew."Customer Posting Group" = CustomerOld."Customer Posting Group") and
                  (CustomerNew."Gen. Bus. Posting Group" = CustomerOld."Gen. Bus. Posting Group") and
                  (CustomerNew."VAT Bus. Posting Group" = CustomerOld."VAT Bus. Posting Group") and
                  (CustomerNew."Currency Code" = CustomerOld."Currency Code") and
                  (CustomerNew."Payment Method Code" = CustomerOld."Payment Method Code") and
                  (CustomerNew."Payment Terms Code" = CustomerOld."Payment Terms Code") and
                  (CustomerNew."VAT Registration No." = CustomerOld."VAT Registration No.")) then
                    exit(false);
            end else begin
                if (CustomerNew."Customer Posting Group" = CustomerOld."Customer Posting Group") and
                  (CustomerNew."Gen. Bus. Posting Group" = CustomerOld."Gen. Bus. Posting Group") and
                  (CustomerNew."VAT Bus. Posting Group" = CustomerOld."VAT Bus. Posting Group") and
                  (CustomerNew."Currency Code" = CustomerOld."Currency Code") and
                  (CustomerNew."Payment Method Code" = CustomerOld."Payment Method Code") and
                  (CustomerNew."Payment Terms Code" = CustomerOld."Payment Terms Code") and
                  (CustomerNew."VAT Registration No." = CustomerOld."VAT Registration No.") then
                    exit(false);
            end;

        exit(true);
    end;

    procedure ProcessLSRVendorOutbound(VendorNew: Record Vendor; VendorOld: Record Vendor; CheckFields: Boolean);
    var
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
    begin
        //check the setup
        if not LSRInterfaceSetup.GET() or not LSRInterfaceSetup."Enable LSR Interface" then
            exit;
        LSRInterfaceSetup.TESTFIELD("LSR Vendor Interface");
        InterfaceSetup.GET(LSRInterfaceSetup."LSR Vendor Interface");
        if not InterfaceSetup.Enabled then
            exit;

        if VendorIsValid(VendorNew, VendorOld, CheckFields) then begin
            InterfaceFrameworkMgtVIP.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CreateLSRVendorOutbound(VendorNew);
        end;
    end;

    local procedure CreateLSRVendorOutbound(Vendor: Record Vendor);
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

        InterfaceEntryHeaderVIPOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderVIPOut."Interface Code" := LSRInterfaceSetup."LSR Vendor Interface";
        InterfaceEntryHeaderVIPOut.Direction := InterfaceEntryHeaderVIPOut.Direction::Outbound;
        InterfaceEntryHeaderVIPOut."Source Type" := DATABASE::Vendor;
        InterfaceEntryHeaderVIPOut."Source No." := Vendor."No.";
        InterfaceEntryHeaderVIPOut.INSERT(true);

        InterfaceEntryLineVIPOut."Header Entry No." := InterfaceEntryHeaderVIPOut."Entry No.";
        InterfaceEntryLineVIPOut."Entry No." := 1;
        InterfaceEntryLineVIPOut.INSERT(true);

        InterfaceEntryLineVIPOut."No." := Vendor."No.";
        InterfaceEntryLineVIPOut.Description := Vendor.Name;
        InterfaceEntryLineVIPOut."Search Name" := Vendor."Search Name";
        InterfaceEntryLineVIPOut."Name 2" := Vendor."Name 2";
        InterfaceEntryLineVIPOut.Address := Vendor.Address;
        InterfaceEntryLineVIPOut."Address 2" := Vendor."Address 2";
        InterfaceEntryLineVIPOut.City := Vendor.City;
        InterfaceEntryLineVIPOut."Post Code" := Vendor."Post Code";
        InterfaceEntryLineVIPOut."Country Code" := Vendor."Country/Region Code";
        InterfaceEntryLineVIPOut.Contact := Vendor.Contact;
        InterfaceEntryLineVIPOut."Phone No." := Vendor."Phone No.";
        InterfaceEntryLineVIPOut."Telex No." := Vendor."Telex No.";
        InterfaceEntryLineVIPOut."Cust/Vend. Posting Group" := Vendor."Vendor Posting Group";
        InterfaceEntryLineVIPOut."Gen. Bus. Posting Group" := Vendor."Gen. Bus. Posting Group";
        InterfaceEntryLineVIPOut."VAT Bus. Posting Group" := Vendor."VAT Bus. Posting Group";
        InterfaceEntryLineVIPOut."Currency Code" := Vendor."Currency Code";
        InterfaceEntryLineVIPOut."Payment Terms Code" := Vendor."Payment Terms Code";
        InterfaceEntryLineVIPOut."Block reason" := Vendor.Blocked.AsInteger();
        InterfaceEntryLineVIPOut."Pay-to Vendor No." := Vendor."Pay-to Vendor No.";
        InterfaceEntryLineVIPOut."Payment Method Code" := Vendor."Payment Method Code";
        InterfaceEntryLineVIPOut."Fax No." := Vendor."Fax No.";
        InterfaceEntryLineVIPOut."VAT Registration No" := Vendor."VAT Registration No.";
        InterfaceEntryLineVIPOut."E-mail" := Vendor."E-Mail";
        InterfaceEntryLineVIPOut."Home Page" := Vendor."Home Page";
        InterfaceEntryLineVIPOut.MODIFY(true);
    end;

    procedure VendorIsValid(VendorNew: Record Vendor; VendorOld: Record Vendor; CheckFields: Boolean): Boolean;
    var
        Vendor: Record Vendor;
        VendorsIncludeExclude: Record "LSR Master Inc/Exc FND";
    begin
        VendorsIncludeExclude.RESET();
        Vendor.RESET();

        Vendor.SETRANGE("No.", VendorNew."No.");
        if not VendorsIncludeExclude.GET(VendorsIncludeExclude.Type::Vendor, VendorNew."No.") then
            Vendor.SETFILTER("Vendor Type FND", LSRInterfaceSetup."Vendor Acc Group Filter");
        if Vendor.FINDFIRST() then begin
            if VendorsIncludeExclude.Code <> '' then
                if VendorsIncludeExclude.Excluded then
                    exit(false);
        end else
            exit(false);

        if CheckFields and (VendorNew.Name = VendorOld.Name) and
          (VendorNew."Search Name" = VendorOld."Search Name") and
          (VendorNew."Name 2" = VendorOld."Name 2") and
          (VendorNew.Address = VendorOld.Address) and
          (VendorNew."Address 2" = VendorOld."Address 2") and
          (VendorNew.City = VendorOld.City) and
          (VendorNew."Post Code" = VendorOld."Post Code") and
          (VendorNew."Country/Region Code" = VendorOld."Country/Region Code") and
          (VendorNew.Contact = VendorOld.Contact) and
          (VendorNew."Phone No." = VendorOld."Phone No.") and
          (VendorNew."Telex No." = VendorOld."Telex No.") and
          (VendorNew."Vendor Posting Group" = VendorOld."Vendor Posting Group") and
          (VendorNew."Gen. Bus. Posting Group" = VendorOld."Gen. Bus. Posting Group") and
          (VendorNew."VAT Bus. Posting Group" = VendorOld."VAT Bus. Posting Group") and
          (VendorNew."Currency Code" = VendorOld."Currency Code") and
          (VendorNew."Payment Terms Code" = VendorOld."Payment Terms Code") and
          (VendorNew.Blocked = VendorOld.Blocked) and
          (VendorNew."Pay-to Vendor No." = VendorOld."Pay-to Vendor No.") and
          (VendorNew."Payment Method Code" = VendorOld."Payment Method Code") and
          (VendorNew."Fax No." = VendorOld."Fax No.") and
          (VendorNew."VAT Registration No." = VendorOld."VAT Registration No.") and
          (VendorNew."E-Mail" = VendorOld."E-Mail") and
          (VendorNew."Home Page" = VendorOld."Home Page") then
            exit(false);

        exit(true);
    end;

    procedure ProcessLSRItemOutbound(ItemNew: Record Item; ItemOld: Record Item; CheckFields: Boolean);
    var
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
    begin
        //check the setup
        if not LSRInterfaceSetup.GET() or not LSRInterfaceSetup."Enable LSR Interface" then
            exit;
        LSRInterfaceSetup.TESTFIELD("LSR Item Interface");
        InterfaceSetup.GET(LSRInterfaceSetup."LSR Item Interface");
        if not InterfaceSetup.Enabled then
            exit;

        if ItemIsValid(ItemNew, ItemOld, CheckFields) then begin
            InterfaceFrameworkMgtVIP.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CreateLSRItemOutbound(ItemNew);
        end;
    end;

    local procedure CreateLSRItemOutbound(Item: Record Item);
    var
        InterfaceEntryHeaderVIPOut: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIPOut: Record "Interface Entry Line VIP INT";
        DrintItFoundationSetup: Record FoundationSetup101FDW; //BC Interface KUMBHS03 added
        EntryNo: Integer;
        ItemUOM: Record "Item Unit of Measure";
        // ItemCrossRef: Record "Item Cross Reference";  // BC Upgrade NANDIS03 - Blocked as table "Item Cross Reference" is obsolete
        ItemCrossRef: Record "Item Reference";  // BC Upgrade NANDIS03 - Added as table "Item Cross Reference" is obsolete
        InventorySetup: Record "Inventory Setup";
    begin
        CLEAR(InterfaceEntryHeaderVIPOut);
        CLEAR(InterfaceEntryLineVIPOut);
        EntryNo := 0;

        if InterfaceEntryHeaderVIP.FINDLAST() then
            InterfaceEntryHeaderVIPOut."Entry No." := InterfaceEntryHeaderVIP."Entry No." + 1
        else
            InterfaceEntryHeaderVIPOut."Entry No." := 1;

        InterfaceEntryHeaderVIPOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderVIPOut."Interface Code" := LSRInterfaceSetup."LSR Item Interface";
        InterfaceEntryHeaderVIPOut.Direction := InterfaceEntryHeaderVIPOut.Direction::Outbound;
        InterfaceEntryHeaderVIPOut."Source Type" := DATABASE::Item;
        InterfaceEntryHeaderVIPOut."Source No." := Item."No.";
        InterfaceEntryHeaderVIPOut.INSERT(true);

        InterfaceEntryLineVIPOut."Header Entry No." := InterfaceEntryHeaderVIPOut."Entry No.";
        InterfaceEntryLineVIPOut."Entry No." := 1;
        InterfaceEntryLineVIPOut.INSERT(true);

        InterfaceEntryLineVIPOut."No." := Item."No.";
        InterfaceEntryLineVIPOut."No. 2" := Item."No. 2";
        InterfaceEntryLineVIPOut.Description := Item.Description;
        InterfaceEntryLineVIPOut."Search Name" := Item."Search Description";
        InterfaceEntryLineVIPOut."Description 2" := Item."Description 2";
        if Item."Base Unit of Measure" <> '' then begin
            InterfaceEntryLineVIPOut."Base UOM" := Item."Base Unit of Measure";

            ItemUOM.RESET();
            if ItemUOM.GET(Item."No.", Item."Base Unit of Measure") then
                InterfaceEntryLineVIPOut."Qty per Base UOM" := ItemUOM."Qty. per Unit of Measure";

            ItemCrossRef.RESET();
            ItemCrossRef.SETRANGE("Item No.", Item."No.");
            ItemCrossRef.SETRANGE("Unit of Measure", Item."Base Unit of Measure");
            if ItemCrossRef.FINDFIRST() then
                // InterfaceEntryLineVIPOut."EAN for Base UOM" := ItemCrossRef."Cross-Reference No.";  // BC Upgrade NANDIS03 - Cross-Reference field is not available
                InterfaceEntryLineVIPOut."EAN for Base UOM" := ItemCrossRef."Reference No.";  // BC Upgrade NANDIS03 - Cross-Reference field is not available
        end;

        InterfaceEntryLineVIPOut."Item Type" := Item.Type.AsInteger();
        InterfaceEntryLineVIPOut."Inventory Posting Group" := Item."Inventory Posting Group";
        InterfaceEntryLineVIPOut."Costing Method" := Item."Costing Method".AsInteger();
        InterfaceEntryLineVIPOut."Unit Cost" := Item."Unit Cost";
        InterfaceEntryLineVIPOut."Standard Cost" := Item."Standard Cost";
        InterfaceEntryLineVIPOut.Blocked := Item.Blocked;
        InterfaceEntryLineVIPOut."Gen. Bus. Posting Group" := Item."Gen. Prod. Posting Group";
        InterfaceEntryLineVIPOut."VAT Bus. Posting Group" := Item."VAT Prod. Posting Group";
        InterfaceEntryLineVIPOut."Inventory Value Zero" := Item."Inventory Value Zero";
        InterfaceEntryLineVIPOut."Block reason" := Item."Replenishment System".AsInteger();
        InterfaceEntryLineVIPOut."Rounding Precision" := Item."Rounding Precision";
        InterfaceEntryLineVIPOut."Sales UOM" := Item."Sales Unit of Measure";

        if Item."Sales Unit of Measure" <> '' then begin
            ItemUOM.RESET();
            if ItemUOM.GET(Item."No.", Item."Sales Unit of Measure") then
                InterfaceEntryLineVIPOut."Qty per Sales UOM" := ItemUOM."Qty. per Unit of Measure";

            ItemCrossRef.RESET();
            ItemCrossRef.SETRANGE("Item No.", Item."No.");
            ItemCrossRef.SETRANGE("Unit of Measure", Item."Sales Unit of Measure");
            if ItemCrossRef.FINDFIRST() then
                // InterfaceEntryLineVIPOut."EAN for Sales UOM" := ItemCrossRef."Cross-Reference No.";  // BC Upgrade NANDIS03 - Blocked as table "Item Cross Reference" is obsolete
                                InterfaceEntryLineVIPOut."EAN for Sales UOM" := ItemCrossRef."Reference No.";  // BC Upgrade NANDIS03 - Blocked as table "Item Cross Reference" is obsolete
        end;

        if Item."Purch. Unit of Measure" <> '' then begin
            InterfaceEntryLineVIPOut."Purch. UOM" := Item."Purch. Unit of Measure";
            ItemUOM.RESET();
            if ItemUOM.GET(Item."No.", Item."Purch. Unit of Measure") then
                InterfaceEntryLineVIPOut."Qty per Purch. UOM" := ItemUOM."Qty. per Unit of Measure";

            ItemCrossRef.RESET();
            ItemCrossRef.SETRANGE("Item No.", Item."No.");
            ItemCrossRef.SETRANGE("Unit of Measure", Item."Purch. Unit of Measure");
            if ItemCrossRef.FINDFIRST() then
                // InterfaceEntryLineVIPOut."EAN for Purch. UOM" := ItemCrossRef."Cross-Reference No.";  // BC Upgrade NANDIS03 - Blocked as table "Item Cross Reference" is obsolete
                InterfaceEntryLineVIPOut."EAN for Purch. UOM" := ItemCrossRef."Reference No.";  // BC Upgrade NANDIS03 - Blocked as table "Item Cross Reference" is obsolete
        end;

        InterfaceEntryLineVIPOut."Item Category Code" := Item."Item Category Code";
        // InterfaceEntryLineVIPOut."Product Group Code" := Item."Product Group Code";  // BC Upgrade NANDIS03 - Blocked as Product Group COde field is now obsolete

        // BC Upgrade NANDIS03 - Blocked as dependency on DIT field >>
        // if InventorySetup.GET and (InventorySetup.Pallet <> '') then begin
        //     ItemUOM.RESET;
        //     if ItemUOM.GET(Item."No.", InventorySetup.Pallet) then
        //         InterfaceEntryLineVIPOut."Net Weight Reflex 3rd" := ItemUOM."Qty. per Unit of Measure";

        //     ItemCrossRef.RESET;
        //     ItemCrossRef.SETRANGE("Item No.", Item."No.");
        //     ItemCrossRef.SETRANGE("Unit of Measure", InventorySetup.Pallet);
        //     if ItemCrossRef.FINDFIRST then
        //         // InterfaceEntryLineVIPOut."Item Shorctcut Dim1" := ItemCrossRef."Cross-Reference No.";  // BC Upgrade NANDIS03 - Blocked as table "Item Cross Reference" is obsolete
        //         InterfaceEntryLineVIPOut."Item Shorctcut Dim1" := ItemCrossRef."Reference No.";  // BC Upgrade NANDIS03 - Blocked as table "Item Cross Reference" is obsolete
        // end;
        // BC Upgrade NANDIS03 - Blocked as dependency on DIT field <<

        // BC Interface KUMBHS03- mapped product group code and DIT field >>
        InterfaceEntryLineVIPOut."Product Group Code" := Item."Product Group Code FND";
        if DrintItFoundationSetup.GET() and (DrintItFoundationSetup."Pallet Unit Of Measure" <> '') then begin
            ItemUOM.RESET();
            if ItemUOM.GET(Item."No.", DrintItFoundationSetup."Pallet Unit Of Measure") then
                InterfaceEntryLineVIPOut."Net Weight Reflex 3rd" := ItemUOM."Qty. per Unit of Measure";

            ItemCrossRef.RESET();
            ItemCrossRef.SETRANGE("Item No.", Item."No.");
            ItemCrossRef.SETRANGE("Unit of Measure", DrintItFoundationSetup."Pallet Unit Of Measure");
            if ItemCrossRef.FINDFIRST() then
                InterfaceEntryLineVIPOut."Item Shorctcut Dim1" := ItemCrossRef."Reference No.";
        end;
        // BC Interface KUMBHS03- mapped product group code and DIT field <<
        InterfaceEntryLineVIPOut.MODIFY(true);
    end;

    procedure ItemIsValid(ItemNew: Record Item; ItemOld: Record Item; CheckFields: Boolean): Boolean;
    var
        Item: Record Item;
        ItemsIncludeExclude: Record "LSR Master Inc/Exc FND";
    begin
        ItemsIncludeExclude.RESET();
        Item.RESET();

        Item.SETRANGE("No.", ItemNew."No.");
        Item.SETRANGE(Blocked, false);
        if not ItemsIncludeExclude.GET(ItemsIncludeExclude.Type::Item, ItemNew."No.") then
            Item.SETFILTER("Item Category Code", LSRInterfaceSetup."Item Category Filter");
        if Item.FINDFIRST() then begin
            if ItemsIncludeExclude.Code <> '' then
                if ItemsIncludeExclude.Excluded then
                    exit(false);
        end else
            exit(false);

        if CheckFields and
          (ItemNew."No. 2" = ItemOld."No. 2") and
          (ItemNew.Description = ItemOld.Description) and
          (ItemNew."Search Description" = ItemOld."Search Description") and
          (ItemNew."Description 2" = ItemOld."Description 2") and
          (ItemNew."Base Unit of Measure" = ItemOld."Base Unit of Measure") and
          (ItemNew.Type = ItemOld.Type) and
          (ItemNew."Inventory Posting Group" = ItemOld."Inventory Posting Group") and
          (ItemNew."Costing Method" = ItemOld."Costing Method") and
          (ItemNew."Unit Cost" = ItemOld."Unit Cost") and
          (ItemNew."Standard Cost" = ItemOld."Standard Cost") and
          (ItemNew.Blocked = ItemOld.Blocked) and
          (ItemNew."Gen. Prod. Posting Group" = ItemOld."Gen. Prod. Posting Group") and
          (ItemNew."VAT Prod. Posting Group" = ItemOld."VAT Prod. Posting Group") and
          (ItemNew."Inventory Value Zero" = ItemOld."Inventory Value Zero") and
          (ItemNew."Rounding Precision" = ItemOld."Rounding Precision") and
          (ItemNew."Sales Unit of Measure" = ItemOld."Sales Unit of Measure") and
          (ItemNew."Purch. Unit of Measure" = ItemOld."Purch. Unit of Measure") and
        // // BC Upgrade NANDIS03 - Dependency on obsolete field "Product Group Code" >>
        //   (ItemNew."Item Category Code" = ItemOld."Item Category Code") and
        //   (ItemNew."Product Group Code" = ItemOld."Product Group Code") then
        (ItemNew."Item Category Code" = ItemOld."Item Category Code") then
            // // BC Upgrade NANDIS03 - Dependency on obsolete field "Product Group Code" <<
            exit(false);

        exit(true);
    end;

    procedure ProcessPayments(InterfaceEntryHeader: Record "Interface Entry Header VIP INT");
    var
        DimensionManagement: Codeunit DimensionManagement;
        SourceCodeSetup: Record "Source Code Setup";
        InterfaceEntryLine: Record "Interface Entry Line VIP INT";
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLine2: Record "Gen. Journal Line";
        GenJournalLine3: Record "Gen. Journal Line";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        GenJournalBatch: Record "Gen. Journal Batch";
        DocumentNo: Code[20];
        LineNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        //PaymentsNoSeriesMgt: Codeunit NoSeriesManagement;  // BC Upgrade SHUKLP03 << Removed from Business central.
        PaymentNoSeriesL: Codeunit "No. Series"; // BC Upgrade SHUKLP03 << 
        GLSetup: Record "General Ledger Setup";
        //BC UPGRADE SHIKHD02>>
        //Added missing variables "CashRcptBalGLAccount" and "BalAccount" in BC as per NAV HEI.11 implementation
        CashRcptBalGLAccount: Record "Cash Rcpt Bal G/L Account FND";
        BalAccount: Code[20];
    //BC UPGRADE SHIKHD02<<
    begin
        //HEI.02<<
        SourceCodeSetup.GET();
        GLSetup.GET();
        LSRInterfaceSetup.GET();
        LSRInterfaceSetup.TESTFIELD("Enable LSR Interface", true);
        LSRInterfaceSetup.TESTFIELD("Payout Interface");
        InterfaceSetup.GET(LSRInterfaceSetup."Payout Interface");
        InterfaceSetup.TESTFIELD(Enabled, true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.findset() then begin
            CLEAR(GenJournalLine);
            //BC UPGRADE SHIKHD02>>
            //Added lookup logic based on Location Code and Payment Method to align with NAV HEI.11 (missing in BC)
            CLEAR(BalAccount);
            CashRcptBalGLAccount.SETRANGE("Location Code", InterfaceEntryHeader."Location Code");
            CashRcptBalGLAccount.SETRANGE("Payment Method", LSRInterfaceSetup."Payouts Payment Method");
            if CashRcptBalGLAccount.FINDFIRST then begin
                GenJournalBatch.GET(CashRcptBalGLAccount."Cash Journal Template", CashRcptBalGLAccount."Cash Journal Batch");
                BalAccount := CashRcptBalGLAccount."Balance G/L Account";
            end else
                //BC UPGRADE SHIKHD02<<
                GenJournalBatch.GET(LSRInterfaceSetup."Payouts Gen. Journal Template", LSRInterfaceSetup."Payouts Gen. Journal Batch");
            // DocumentNo := NoSeriesManagement.GetNextNo(GenJournalBatch."No. Series", InterfaceEntryLine."Posting Date", false);   // BC Upgrade SHUKLP03 << Replaced NoSeriesManagement with "No. Series" codeunit.
            DocumentNo := PaymentNoSeriesL.GetNextNo(GenJournalBatch."No. Series", InterfaceEntryLine."Posting Date", false);   // BC Upgrade SHUKLP03 << Replaced NoSeriesManagement with "No. Series" codeunit.

            //Delete existing empty lines
            GenJournalLine3.SETRANGE("Journal Template Name", LSRInterfaceSetup."Payouts Gen. Journal Template");
            GenJournalLine3.SETRANGE("Journal Batch Name", LSRInterfaceSetup."Payouts Gen. Journal Batch");
            if GenJournalLine3.FINDFIRST() then
                GenJournalLine3.DELETEALL();

            repeat
                // Account Receivables - Location (-)
                GenJournalLine.INIT();
                //BC UPGRADE SHIKHD02>>
                //Blocked LSRInterfaceSetup validation and added and added GenJournalBatch validation
                //as per NAV HEI.11 implementation (missing in BC)
                //GenJournalLine.VALIDATE("Journal Template Name", LSRInterfaceSetup."Payouts Gen. Journal Template");
                //GenJournalLine.VALIDATE("Journal Batch Name", LSRInterfaceSetup."Payouts Gen. Journal Batch");
                GenJournalLine.VALIDATE("Journal Template Name", GenJournalBatch."Journal Template Name");
                GenJournalLine.VALIDATE("Journal Batch Name", GenJournalBatch.Name);
                //BC UPGRADE SHIKHD02<<
                GenJournalLine2.RESET();
                GenJournalLine2.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
                GenJournalLine2.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
                if GenJournalLine2.FINDLAST() then
                    LineNo := GenJournalLine2."Line No." + 10000
                else
                    LineNo := 10000;
                GenJournalLine.VALIDATE("Line No.", LineNo);
                GenJournalLine.INSERT(true);

                GenJournalLine.VALIDATE("Interface Code FND", InterfaceEntryHeader."Interface Code");
                GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Payment);
                //GenJournalLine.VALIDATE("Document No.",DocumentNo);
                GenJournalLine.VALIDATE("Document No.", InterfaceEntryLine."No.");
                GenJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Document No.");
                GenJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Posting Date");
                GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                GenJournalLine.VALIDATE("Account No.", InterfaceEntryLine."Cross-Ref. No. Reflex 1st");
                GenJournalLine.VALIDATE("Source Code", SourceCodeSetup."Payment Journal");
                GenJournalLine.VALIDATE("Currency Code", InterfaceEntryLine."Currency Code");
                GenJournalLine.VALIDATE(Amount, InterfaceEntryLine."Line Amount");
                GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Account Type"::"G/L Account");
                //BC UPGRADE SHIKHD02>>
                //Blocked Cross-Ref based if-condition and added if-else logic using BalAccount 
                //to align with NAV HEI.11 (previously missing in BC)
                //if InterfaceEntryLine."Cross-Ref. No. Reflex 2rd" <> '' then
                //  GenJournalLine.VALIDATE("Bal. Account No.", InterfaceEntryLine."Cross-Ref. No. Reflex 2rd")
                // else
                if BalAccount <> '' then
                    GenJournalLine.VALIDATE("Bal. Account No.", BalAccount)
                else
                    //BC UPGRADE SHIKHD02<<
                    GenJournalLine.VALIDATE("Bal. Account No.", GenJournalBatch."Bal. Account No.");

                //Dimensions
                DimensionManagement.GetDimensionSet(TempDimensionSetEntry, GenJournalLine."Dimension Set ID");
                GetDimensionLocationMappingCP(InterfaceEntryHeader."Location Code");
                TempDimensionSetEntry.SETRANGE("Dimension Code", GLSetup."Shortcut Dimension 2 Code");
                if not TempDimensionSetEntry.FINDFIRST() then begin
                    TempDimensionSetEntry.INIT();
                    if InterfaceEntryLine."Item Shorctcut Dim2" = '' then begin
                        TempDimensionSetEntry."Dimension Code" := CCCDimensionCode;
                        TempDimensionSetEntry."Dimension Value Code" := CCCDimensionValue;
                    end else begin
                        TempDimensionSetEntry."Dimension Code" := GLSetup."Shortcut Dimension 2 Code";
                        TempDimensionSetEntry."Dimension Value Code" := InterfaceEntryLine."Item Shorctcut Dim2";
                    end;
                    if TempDimensionSetEntry.INSERT(true) then;
                end else begin
                    if InterfaceEntryLine."Item Shorctcut Dim2" = '' then begin
                        TempDimensionSetEntry."Dimension Code" := CCCDimensionCode;
                        TempDimensionSetEntry."Dimension Value Code" := CCCDimensionValue;
                    end else begin
                        TempDimensionSetEntry."Dimension Code" := GLSetup."Shortcut Dimension 2 Code";
                        TempDimensionSetEntry."Dimension Value Code" := InterfaceEntryLine."Item Shorctcut Dim2";
                    end;
                    if TempDimensionSetEntry.MODIFY(true) then;
                end;

                GenJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                GenJournalLine.MODIFY();
            until InterfaceEntryLine.NEXT() = 0;

            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);

        end;
        //HEI.02>>
    end;

    local procedure GetAccountReceivablesNo(LocationNo: Code[20]; Payout: Boolean): Code[20];
    var
        LocationMappingCP: Record "Location Mapping CP FND";
    begin
        //HEI.02<<
        LocationMappingCP.SETRANGE("CP Store Code", LocationNo);
        if LocationMappingCP.FINDFIRST() then
            if Payout then
                exit(LocationMappingCP."Payouts Bank Account")
            else
                exit(LocationMappingCP."Accounts Receivables");
        //HEI.02>>
    end;

    local procedure GetDimensionLocationMappingCP(LocationCode: Code[10]);
    var
        LocationMappingCP: Record "Location Mapping CP FND";
    begin
        //HEI.02<<
        CLEAR(CCCDimensionCode);
        CLEAR(CCCDimensionValue);

        LocationMappingCP.SETRANGE("Location Code", LocationCode);
        if LocationMappingCP.FINDFIRST() then begin
            CCCDimensionCode := LocationMappingCP."CCC Dimension";
            CCCDimensionValue := LocationMappingCP."CCC Dimension Value";
        end;
        //HEI.02>>
    end;

    local procedure GetPaymentGLAccount(CPCode: Code[20]; LocationCode: Code[20]): Code[20];
    var
        PaymentMethodMappingCP: Record "Payment Method Mapping CP FND";
    begin
        //HEI.02>>
        if PaymentMethodMappingCP.GET(CPCode, LocationCode) then
            exit(PaymentMethodMappingCP."Payment GL Account");
        //HEI.02>>
    end;

    procedure SendPurchOrderToLSR(PurchaseHeader: Record "Purchase Header");
    var
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        PurchaseLine: Record "Purchase Line";
        NextEntryNo: Integer;
        lGLAcc: Record "G/L Account";
        lCMGMapping: Record "CMG Mapping FND";
        CompanyInformation: Record "Company Information";
        POAdditional: Record "Purchase Header Additional FND";
        GLSetup: Record "General Ledger Setup";
        InterfaceSetup: Record "Interface Setup INT";
    begin
        //HEI.02<<
        if not LSRInterfaceSetup.GET() or not LSRInterfaceSetup."Enable LSR Interface" then
            exit;
        LSRInterfaceSetup.TESTFIELD("PO Outbound Interface");
        InterfaceSetup.GET(LSRInterfaceSetup."PO Outbound Interface");
        if not InterfaceSetup.Enabled then
            exit;

        CompanyInformation.GET();
        GLSetup.GET();
        //insert header
        PurchaseHeader.CALCFIELDS("LSR Order No. INT");
        CLEAR(InterfaceEntryHeaderVIP);
        InterfaceEntryHeaderVIP."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderVIP."Interface Code" := LSRInterfaceSetup."PO Outbound Interface";
        InterfaceEntryHeaderVIP.Direction := InterfaceEntryHeaderVIP.Direction::Outbound;
        InterfaceEntryHeaderVIP.Status := InterfaceEntryHeaderVIP.Status::Pending;
        InterfaceEntryHeaderVIP."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderVIP."Source Type" := PurchaseHeader."Document Type".AsInteger();
        InterfaceEntryHeaderVIP."Source No." := PurchaseHeader."No.";
        if PurchaseHeader."LSR Order No. INT" <> '' then
            InterfaceEntryHeaderVIP."External Document No." := PurchaseHeader."LSR Order No. INT"
        else
            InterfaceEntryHeaderVIP."External Document No." := PurchaseHeader."No.";
        InterfaceEntryHeaderVIP."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
        InterfaceEntryHeaderVIP."Your Reference" := PurchaseHeader."Your Reference";
        InterfaceEntryHeaderVIP.Description := PurchaseHeader."Pay-to Name";
        InterfaceEntryHeaderVIP."Document Date" := PurchaseHeader."Order Date";
        InterfaceEntryHeaderVIP."Expected Receipt Date" := PurchaseHeader."Expected Receipt Date";
        InterfaceEntryHeaderVIP."Requested Receipt Date" := PurchaseHeader."Requested Receipt Date";
        InterfaceEntryHeaderVIP."Payment Terms Code" := PurchaseHeader."Payment Terms Code";
        InterfaceEntryHeaderVIP."Location Code" := PurchaseHeader."Location Code";
        //IF "Currency Code" <> '' THEN
        InterfaceEntryHeaderVIP."Currency Code" := PurchaseHeader."Currency Code";
        //ELSE
        //InterfaceEntryHeaderVIP."Currency Code" := GLSetup."LCY Code";
        InterfaceEntryHeaderVIP."Shipment Method Code" := PurchaseHeader."Shipment Method Code";
        InterfaceEntryHeaderVIP.INSERT(true);

        //insert lines
        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        if PurchaseLine.findset() then
            repeat
                CLEAR(InterfaceEntryLineVIP);
                InterfaceEntryLineVIP."Header Entry No." := InterfaceEntryHeaderVIP."Entry No.";
                NextEntryNo := NextEntryNo + 1;
                InterfaceEntryLineVIP."Entry No." := NextEntryNo;
                InterfaceEntryLineVIP."Source Line No." := PurchaseLine."Line No.";
                InterfaceEntryLineVIP.Type := PurchaseLine.Type.AsInteger();
                InterfaceEntryLineVIP."No." := PurchaseLine."No.";
                InterfaceEntryLineVIP.Flag := PurchaseLine."Unit of Measure";


                InterfaceEntryLineVIP.Quantity := PurchaseLine.Quantity;
                //InterfaceEntryLineVIP."Unit of Measure Code" := InterfaceFrameworkMgt.GetUnitOfMeasureCommercialISOCode(PurchaseLine."Unit of Measure Code");
                InterfaceEntryLineVIP."Unit of Measure Code" := PurchaseLine."Unit of Measure Code";
                InterfaceEntryLineVIP."Unit Amount" := PurchaseLine."Direct Unit Cost";
                InterfaceEntryLineVIP."Unit Cost" := PurchaseLine."Unit Cost";   //PurchaseLine."Unit Cost (LCY)";
                InterfaceEntryLineVIP."Expected Delivery Date" := PurchaseLine."Expected Receipt Date";
                InterfaceEntryLineVIP."Posting Date" := PurchaseLine."Requested Receipt Date";
                InterfaceEntryLineVIP.INSERT();
            until PurchaseLine.NEXT() = 0;
        //HEI.02>>
    end;

    procedure ProcessLSRPurchOrder(InterfaceEntryHeader: Record "Interface Entry Header VIP INT");
    var
        InterfaceEntryLine: Record "Interface Entry Line VIP INT";
        InterfaceSetup: Record "Interface Setup INT";
        BlanketOrderLine: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
        PurchaseOrderLine: Record "Purchase Line";
        POAlreadyCreatedForPRErr: Label 'LSR Order No. %1 line no. %2 has already been processed to PO %3.';
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        GLSetup: Record "General Ledger Setup";
        UserFromInterface: Text;
        DomainName: Text;
        Position: Integer;
        TempPurchHeader: Record "Purchase Header" temporary;
        PurchaseLine: Record "Purchase Line";
        CCCDimenssionErr: Label 'PR %1 creation CCC code dimension cannot be empty.';
        PoLineAlreadyCreated: Label 'PO line no %1 already exists.';
        CounterLSROrderNo: Integer;
        DimensionManagement: Codeunit DimensionManagement;
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        TempDimensionSetEntryHeader: Record "Dimension Set Entry" temporary;
    begin
        //HEI.02>>
        LSRInterfaceSetup.GET();
        LSRInterfaceSetup.TESTFIELD("Enable LSR Interface", true);
        LSRInterfaceSetup.TESTFIELD("PO Inbound Interface");
        InterfaceSetup.GET(LSRInterfaceSetup."PO Inbound Interface");
        InterfaceSetup.TESTFIELD(Enabled, true);
        GLSetup.GET();

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.findset() then
            repeat
                PurchaseHeaderAdditional.SETRANGE("LSR Order No INT", InterfaceEntryHeader."Source No.");
                if PurchaseHeaderAdditional.FINDFIRST() then
                    repeat
                        PurchaseOrderLine.SETRANGE("Document No.", PurchaseHeaderAdditional."No.");
                        PurchaseOrderLine.SETRANGE("Line No.", InterfaceEntryLine."Source Line No.");
                        PurchaseOrderLine.SETFILTER("Document Type", '%1|%2', PurchaseOrderLine."Document Type"::Order, PurchaseOrderLine."Document Type"::Quote);
                        if PurchaseOrderLine.FINDFIRST() then
                            ERROR(POAlreadyCreatedForPRErr, PurchaseHeaderAdditional."LSR Order No INT",
                                                           InterfaceEntryLine."Source Line No.",
                                                           PurchaseOrderLine."Document No.");

                    until PurchaseHeaderAdditional.NEXT() = 0;

                PurchaseHeader.RESET();
                PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Quote);
                PurchaseHeader.SETRANGE("LSR Order No. INT", InterfaceEntryHeader."Source No.");
                PurchaseHeader.SETRANGE("Buy-from Vendor No.", InterfaceEntryHeader."Buy-from Vendor No.");
                PurchaseHeader.SETAUTOCALCFIELDS("LSR Order No. INT");

                CLEAR(BlanketOrderLine);
                BlanketOrderLine.SETRANGE("Document Type", BlanketOrderLine."Document Type"::"Blanket Order");
                BlanketOrderLine.SETRANGE("Buy-from Vendor No.", InterfaceEntryHeader."Buy-from Vendor No.");
                BlanketOrderLine.SETRANGE(Type, InterfaceEntryLine.Type);
                BlanketOrderLine.SETRANGE("No.", InterfaceEntryLine."No.");
                if InterfaceEntryHeader."Currency Code" <> GLSetup."LCY Code" then
                    BlanketOrderLine.SETRANGE("Currency Code", InterfaceEntryHeader."Currency Code")
                else
                    BlanketOrderLine.SETFILTER("Currency Code", '=%1', '');
                BlanketOrderLine.SETFILTER("Valid From FND", '<=%1', InterfaceEntryHeader."Document Date");
                BlanketOrderLine.SETFILTER("Valid To FND", '%1|>=%2', 0D, InterfaceEntryHeader."Document Date");
                BlanketOrderLine.SETFILTER("Location Code", '%1|%2', InterfaceEntryHeader."Location Code", '');
                BlanketOrderLine.SETFILTER("Block Line Ordering FND", '<>%1', BlanketOrderLine."Block Line Ordering FND"::B);
                BlanketOrderLine.SETAUTOCALCFIELDS("Valid From FND", "Valid To FND");
                if BlanketOrderLine.FINDFIRST() then;

                //Purchase Header creation
                PurchaseHeader.SETRANGE("Blanket Order No. FND", BlanketOrderLine."Document No.");
                if not PurchaseHeader.FINDFIRST() then begin
                    CLEAR(PurchaseHeader);
                    if not GUIALLOWED then
                        PurchaseHeader.SetHideValidationDialog(true);
                    PurchaseHeader.VALIDATE("Document Type", PurchaseHeader."Document Type"::Quote);
                    PurchaseHeader.INSERT(true);
                    PurchaseHeader.VALIDATE("Buy-from Vendor No.", InterfaceEntryHeader."Buy-from Vendor No.");
                    PurchaseHeader.VALIDATE("Document Date", InterfaceEntryHeader."Document Date");
                    PurchaseHeader.VALIDATE("Order Date", InterfaceEntryHeader."Document Date");
                    if InterfaceEntryHeader."Currency Code" <> GLSetup."LCY Code" then
                        PurchaseHeader.VALIDATE("Currency Code", InterfaceEntryHeader."Currency Code")
                    else
                        PurchaseHeader.VALIDATE("Currency Code", '');
                    if BlanketOrderLine."Document No." <> '' then
                        PurchaseHeader.VALIDATE("Blanket Order No. FND", BlanketOrderLine."Document No.");
                    if (InterfaceEntryHeader."Requested Receipt Date" <> 0D) and (InterfaceEntryHeader."Requested Receipt Date" <> 20010101D) then
                        PurchaseHeader.VALIDATE("Requested Receipt Date", InterfaceEntryHeader."Requested Receipt Date");
                    if (InterfaceEntryHeader."Expected Receipt Date" <> 0D) and
                       (InterfaceEntryHeader."Expected Receipt Date" <> 20010101D) and
                       (PurchaseHeader."Expected Receipt Date" = 0D)
                    then
                        PurchaseHeader.VALIDATE("Expected Receipt Date", InterfaceEntryHeader."Expected Receipt Date");

                    PurchaseHeader.VALIDATE("Your Reference", InterfaceEntryHeader."Your Reference");
                    PurchaseHeader.VALIDATE("Payment Terms Code", InterfaceEntryHeader."Payment Terms Code");
                    PurchaseHeader.VALIDATE("Shipment Method Code", InterfaceEntryHeader."Shipment Method Code");
                    PurchaseHeader.VALIDATE("Location Code", InterfaceEntryHeader."Location Code");

                    GetDimensionLocationMappingCP(PurchaseHeader."Location Code");
                    PurchaseHeader.VALIDATE("Shortcut Dimension 2 Code", CCCDimensionValue);

                    UserFromInterface := InterfaceEntryHeader.ApproverID;
                    DomainName := 'HEIWAY\';
                    Position := STRPOS(UserFromInterface, DomainName);

                    if PurchaseHeaderAdditional.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") then begin
                        if Position = 0 then
                            PurchaseHeaderAdditional.VALIDATE("PQ Approver", DomainName + InterfaceEntryHeader.ApproverID)
                        else
                            PurchaseHeaderAdditional.VALIDATE("PQ Approver", InterfaceEntryHeader.ApproverID);

                        PurchaseHeaderAdditional.VALIDATE("LSR Order No INT", InterfaceEntryHeader."Source No.");
                        PurchaseHeaderAdditional.MODIFY(true);

                        PurchaseHeader.MODIFY(true);
                    end else
                        exit;

                    CLEAR(TempPurchHeader);
                    TempPurchHeader := PurchaseHeader;
                    TempPurchHeader.INSERT();
                end;

                //Purchase Lines creation
                PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                PurchaseLine.SETRANGE("Line No.", InterfaceEntryLine."Source Line No.");
                if not PurchaseLine.FINDFIRST() then begin
                    CLEAR(PurchaseLine);
                    if not GUIALLOWED then
                        // PurchaseLine.SetHideValidationDialog(true);  // BC Upgrade NANDIS03 - Blocked temporarily
                    PurchaseLine.VALIDATE("Document Type", PurchaseHeader."Document Type");
                    PurchaseLine.VALIDATE("Document No.", PurchaseHeader."No.");
                    PurchaseLine."Line No." := InterfaceEntryLine."Source Line No.";
                    PurchaseLine.VALIDATE(Type, InterfaceEntryLine.Type);
                    PurchaseLine.VALIDATE("No.", InterfaceEntryLine."No.");
                    PurchaseLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                    PurchaseLine.VALIDATE("Unit of Measure", InterfaceEntryLine.Flag);
                    PurchaseLine.VALIDATE("Unit of Measure Code", InterfaceEntryLine."Unit of Measure Code");
                    if PurchaseLine."Direct Unit Cost" = 0 then begin
                        // PurchaseLine."Item Charge Value" := InterfaceEntryLine."Unit Cost";  // BC Upgrade NANDIS03 - Dependency on DIT field
                        PurchaseLine.VALIDATE("Direct Unit Cost", InterfaceEntryLine."Unit Cost");
                    end;

                    GetDimensionLocationMappingCP(PurchaseHeader."Location Code");
                    if InterfaceEntryLine."Item Shorctcut Dim2" <> '' then begin
                        PurchaseLine.VALIDATE("Shortcut Dimension 2 Code", InterfaceEntryLine."Item Shorctcut Dim2");
                        if PurchaseHeader."Shortcut Dimension 2 Code" = CCCDimensionValue then begin
                            //PurchaseHeader.VALIDATE("Shortcut Dimension 2 Code",InterfaceEntryLine."Item Shorctcut Dim2" );
                            PurchaseHeader."Shortcut Dimension 2 Code" := InterfaceEntryLine."Item Shorctcut Dim2";
                            DimensionManagement.ValidateShortcutDimValues(2, InterfaceEntryLine."Item Shorctcut Dim2", PurchaseHeader."Dimension Set ID");
                            PurchaseHeader.MODIFY(true);
                        end;
                    end else
                        PurchaseLine.VALIDATE("Shortcut Dimension 2 Code", CCCDimensionValue);

                    //Dimensions on the lines
                    /*DimensionManagement.GetDimensionSet(TempDimensionSetEntry,PurchaseLine."Dimension Set ID");
                     GetDimensionLocationMappingCP(PurchaseHeader."Location Code");
                     TempDimensionSetEntry.SETRANGE("Dimension Code",GLSetup."Shortcut Dimension 2 Code");
                     IF NOT TempDimensionSetEntry.FINDFIRST THEN BEGIN
                       TempDimensionSetEntry.INIT;
                       IF InterfaceEntryLine."Item Shorctcut Dim2" = '' THEN BEGIN
                         TempDimensionSetEntry."Dimension Code" := CCCDimensionCode;
                         TempDimensionSetEntry."Dimension Value Code" := CCCDimensionValue;
                       END ELSE BEGIN
                         TempDimensionSetEntry."Dimension Code" := GLSetup."Shortcut Dimension 2 Code";
                         TempDimensionSetEntry."Dimension Value Code" := InterfaceEntryLine."Item Shorctcut Dim2";
                       END;
                       TempDimensionSetEntry.INSERT(TRUE);
                       PurchaseLine.VALIDATE("Dimension Set ID",DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                     END ELSE BEGIN
                       IF InterfaceEntryLine."Item Shorctcut Dim2" = '' THEN
                         TempDimensionSetEntry."Dimension Value Code" := CCCDimensionValue
                       ELSE
                         TempDimensionSetEntry."Dimension Value Code" := InterfaceEntryLine."Item Shorctcut Dim2";
                       TempDimensionSetEntry.MODIFY(TRUE);
                       PurchaseLine.VALIDATE("Dimension Set ID",DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                     END;*/

                    //Dimensions on the header
                    /*DimensionManagement.GetDimensionSet(TempDimensionSetEntryHeader, PurchaseHeader."Dimension Set ID");
                    TempDimensionSetEntryHeader.SETRANGE("Dimension Code",GLSetup."Shortcut Dimension 2 Code");
                    IF NOT TempDimensionSetEntryHeader.FINDFIRST THEN BEGIN
                      TempDimensionSetEntryHeader.INIT;
                      TempDimensionSetEntryHeader."Dimension Code" := GLSetup."Shortcut Dimension 2 Code";
                      IF InterfaceEntryLine."Item Shorctcut Dim2" = '' THEN
                        TempDimensionSetEntryHeader."Dimension Value Code" := CCCDimensionValue
                      ELSE
                        TempDimensionSetEntryHeader."Dimension Value Code" := InterfaceEntryLine."Item Shorctcut Dim2";
                      TempDimensionSetEntryHeader.INSERT(TRUE);

                      PurchaseHeader.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntryHeader));
                      PurchaseHeader.MODIFY(TRUE);
                    END ELSE
                      IF (InterfaceEntryLine."Item Shorctcut Dim2" <> '') AND (TempDimensionSetEntryHeader."Dimension Value Code" = CCCDimensionValue) THEN BEGIN
                        TempDimensionSetEntryHeader."Dimension Value Code" := InterfaceEntryLine."Item Shorctcut Dim2";
                        TempDimensionSetEntryHeader.MODIFY(TRUE);

                        PurchaseHeader.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntryHeader));
                        PurchaseHeader.MODIFY(TRUE);
                    END;*/

                    if BlanketOrderLine."Document No." <> '' then begin
                        PurchaseLine."Blanket Order No." := BlanketOrderLine."Document No.";
                        PurchaseLine.VALIDATE("Blanket Order Line No.", BlanketOrderLine."Line No.");
                    end;
                    if (InterfaceEntryLine."Posting Date" <> 0D) and (InterfaceEntryLine."Posting Date" <> 20010101D) then
                        PurchaseLine.VALIDATE("Requested Receipt Date", InterfaceEntryLine."Posting Date");
                    if (InterfaceEntryLine."Expected Delivery Date" <> 0D) and (InterfaceEntryLine."Expected Delivery Date" <> 20010101D) then
                        PurchaseLine.VALIDATE("Expected Receipt Date", InterfaceEntryLine."Expected Delivery Date");

                    PurchaseLine.INSERT(true);
                end else
                    ERROR(PoLineAlreadyCreated, InterfaceEntryLine."Source Line No.");

            until InterfaceEntryLine.NEXT() = 0;

        CLEAR(CounterLSROrderNo);
        TempPurchHeader.RESET();
        if TempPurchHeader.findset() then
            repeat
                PurchaseHeader.GET(TempPurchHeader."Document Type", TempPurchHeader."No.");
                PurchaseHeaderAdditional.GET(PurchaseHeader."Document Type", PurchaseHeader."No.");

                if CounterLSROrderNo > 0 then begin
                    PurchaseHeaderAdditional.VALIDATE("LSR Order No INT", InterfaceEntryHeader."Source No." + '_' + FORMAT(CounterLSROrderNo));
                    PurchaseHeaderAdditional.MODIFY(true);
                end;
                CounterLSROrderNo += 1;

                if TempPurchHeader."Blanket Order No. FND" <> '' then
                    CODEUNIT.RUN(CODEUNIT::"Purch.-Quote to Order", PurchaseHeader)
                else
                    CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeader);
            until TempPurchHeader.NEXT() = 0;
        //HEI.02>>

    end;

    procedure ProcessLSRPurchaseReceipt(InterfaceEntryHeader: Record "Interface Entry Header VIP INT");
    var
        InterfaceEntryLine: Record "Interface Entry Line VIP INT";
        InterfaceSetup: Record "Interface Setup INT";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        WhseReceiptHeader: Record "Warehouse Receipt Header";
        WhseReceiptLine: Record "Warehouse Receipt Line";
        Location: Record Location;
        ReleasePurchaseDocument: Codeunit "Release Purchase Document";
        Item: Record Item;
        WarehouseRequest: Record "Warehouse Request";
        WhseCreateSourceDocument: Codeunit "Whse.-Create Source Document";
        Zone: Record Zone;
        Bin: Record Bin;
        PostWhseReceiptLine: Boolean;
        PostPO: Boolean;
        ItemTrackingCode: Record "Item Tracking Code";
    begin
        //HEI.02>>
        LSRInterfaceSetup.GET();
        LSRInterfaceSetup.TESTFIELD("Enable LSR Interface", true);
        LSRInterfaceSetup.TESTFIELD("PR Interface");
        InterfaceSetup.GET(LSRInterfaceSetup."PR Interface");
        InterfaceSetup.TESTFIELD(Enabled, true);

        PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
        PurchaseHeader.SETRANGE("LSR Order No. INT", InterfaceEntryHeader."External Document No.");
        PurchaseHeader.FINDFIRST();

        InterfaceEntryLine.RESET();
        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        InterfaceEntryLine.SETFILTER("No.", '<>%1', '');
        if InterfaceEntryLine.findset() then begin
            PurchaseLine.RESET();
            PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            if PurchaseLine.findset() then
                repeat
                    PurchaseLine.VALIDATE("Qty. to Receive", 0);
                    PurchaseLine.VALIDATE("Qty. to Invoice", 0);
                    PurchaseLine.MODIFY();
                    if Location.GET(PurchaseLine."Location Code") and Location."Require Receive" then begin
                        WhseReceiptLine.SETRANGE("Source Type", DATABASE::"Purchase Line");
                        WhseReceiptLine.SETRANGE("Source Subtype", PurchaseLine."Document Type");
                        WhseReceiptLine.SETRANGE("Source No.", PurchaseLine."Document No.");
                        WhseReceiptLine.SETRANGE("Source Line No.", PurchaseLine."Line No.");
                        if WhseReceiptLine.findset() then
                            repeat
                                WhseReceiptLine.VALIDATE("Qty. to Receive", 0);
                                WhseReceiptLine.MODIFY();
                            until WhseReceiptLine.NEXT() = 0;
                        WhseReceiptLine.RESET();
                    end else begin
                        PurchaseLine.VALIDATE("Qty. to Receive", 0);
                        PurchaseLine.MODIFY();
                    end;
                until PurchaseLine.NEXT() = 0;
        end;

        InterfaceEntryLine.RESET();
        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        InterfaceEntryLine.SETFILTER("No.", '<>%1', '');
        if InterfaceEntryLine.findset() then begin
            if (InterfaceEntryHeader."Posting Date" <> PurchaseHeader."Posting Date") or
                (InterfaceEntryHeader."Vendor Shipment No." <> PurchaseHeader."Vendor Shipment No.")
            then begin
                //ReleasePurchaseDocument.Reopen(PurchaseHeader);
                PurchaseHeader.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
                PurchaseHeader.VALIDATE("Vendor Shipment No.", InterfaceEntryHeader."Vendor Shipment No.");
                //CODEUNIT.RUN(CODEUNIT::"Release Purchase Document",PurchaseHeader);
            end;

            repeat
                Item.GET(InterfaceEntryLine."No.");
                PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                PurchaseLine.SETRANGE("Line No.", InterfaceEntryLine."Source Line No.");
                PurchaseLine.SETRANGE(Type, InterfaceEntryLine.Type);
                PurchaseLine.SETRANGE("No.", InterfaceEntryLine."No.");
                PurchaseLine.FINDFIRST();
                Location.GET(PurchaseLine."Location Code");
                if Location."Require Receive" then begin
                    WhseReceiptLine.RESET();
                    // BC Upgrade NANDIS03 - Blocked the code as dependency on DIT fields >>
                    // PurchaseLine.CALCFIELDS("Whse. Receipt No. (Open)");
                    // if PurchaseLine."Whse. Receipt No. (Open)" <> '' then begin
                    //     if WhseReceiptHeader.GET(PurchaseLine."Whse. Receipt No. (Open)") then begin
                    //         WhseReceiptHeader.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
                    //         WhseReceiptHeader."LSR Order No." := PurchaseHeader."LSR Order No. INT";
                    //         WhseReceiptHeader."LSR Receipt No." := InterfaceEntryHeader."Source No.";
                    //         WhseReceiptHeader.MODIFY
                    //     end;
                    //     WhseReceiptLine.SETRANGE("No.", WhseReceiptHeader."No.");
                    //     WhseReceiptLine.SETRANGE("Source Type", DATABASE::"Purchase Line");
                    //     WhseReceiptLine.SETRANGE("Source Subtype", PurchaseLine."Document Type");
                    //     WhseReceiptLine.SETRANGE("Source No.", PurchaseLine."Document No.");
                    //     WhseReceiptLine.SETRANGE("Source Line No.", PurchaseLine."Line No.");
                    //     WhseReceiptLine.FINDFIRST;
                    // end else begin
                    //     WarehouseRequest.SETRANGE(Type, WarehouseRequest.Type::Inbound);
                    //     WarehouseRequest.SETRANGE("Location Code", PurchaseLine."Location Code");
                    //     WarehouseRequest.SETRANGE("Source Type", DATABASE::"Purchase Line");
                    //     WarehouseRequest.SETRANGE("Source Subtype", PurchaseLine."Document Type");
                    //     WarehouseRequest.SETRANGE("Source No.", PurchaseLine."Document No.");
                    //     if WarehouseRequest.FINDFIRST then begin
                    //         if WarehouseRequest."Warehouse Rcpt/Shpt No." <> '' then
                    //             WhseReceiptHeader.GET(WarehouseRequest."Warehouse Rcpt/Shpt No.")
                    //         else begin
                    //             CLEAR(WhseReceiptHeader);
                    //             WhseReceiptHeader.INSERT(true);
                    //             WhseReceiptHeader.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
                    //             WhseReceiptHeader.VALIDATE("Vendor Shipment No.", InterfaceEntryHeader."Vendor Shipment No.");
                    //             WhseReceiptHeader."LSR Order No." := PurchaseHeader."LSR Order No. INT";
                    //             WhseReceiptHeader."LSR Receipt No." := InterfaceEntryHeader."Source No.";
                    //             WhseReceiptHeader.MODIFY;
                    //         end;
                    //     end else begin
                    //         CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeader);
                    //         CLEAR(WhseReceiptHeader);
                    //         WhseReceiptHeader.INSERT(true);
                    //         WhseReceiptHeader.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
                    //         WhseReceiptHeader.VALIDATE("Vendor Shipment No.", InterfaceEntryHeader."Vendor Shipment No.");
                    //         WhseReceiptHeader."LSR Order No. INT" := PurchaseHeader."LSR Order No.";
                    //         WhseReceiptHeader."LSR Receipt No." := InterfaceEntryHeader."Source No.";
                    //         WhseReceiptHeader.MODIFY;
                    //     end;

                    //     WhseCreateSourceDocument.PurchLine2ReceiptLine(WhseReceiptHeader, PurchaseLine);

                    //     WhseReceiptLine.SETRANGE("No.", WhseReceiptHeader."No.");
                    //     WhseReceiptLine.SETRANGE("Source No.", PurchaseLine."Document No.");
                    //     WhseReceiptLine.SETRANGE("Source Line No.", PurchaseLine."Line No.");
                    //     if WhseReceiptLine.FINDFIRST then begin
                    //         WhseReceiptLine.VALIDATE("Qty. to Receive", 0);
                    //         WhseReceiptLine.MODIFY;
                    //     end;
                    //     WhseReceiptLine.RESET;
                    // end;
                    // BC Upgrade NANDIS03 - Blocked the code as dependency on DIT fields <<
                    WhseReceiptLine.SETRANGE("No.", WhseReceiptHeader."No.");
                    WhseReceiptLine.SETRANGE("Source No.", PurchaseLine."Document No.");
                    WhseReceiptLine.SETRANGE("Source Line No.", PurchaseLine."Line No.");
                    WhseReceiptLine.FINDFIRST();

                    WhseReceiptLine.VALIDATE("Qty. to Receive", InterfaceEntryLine.Quantity);

                    Bin.RESET();
                    if InterfaceEntryLine."Item Code" <> '' then
                        Bin.GET(InterfaceEntryHeader."Location Code", InterfaceEntryLine."Item Code")
                    else begin
                        Bin.SETRANGE("Location Code", InterfaceEntryHeader."Location Code");
                        Bin.SETRANGE("Unavailable Stock FND", false);
                        Bin.FINDFIRST();
                    end;

                    WhseReceiptLine.VALIDATE("Zone Code", Bin."Zone Code");
                    WhseReceiptLine.VALIDATE("Bin Code", Bin.Code);

                    WhseReceiptLine.MODIFY(true);
                    Item.GET(WhseReceiptLine."Item No.");
                    if (WhseReceiptLine."Qty. to Receive" <> 0) and ItemTrackingCode.GET(Item."Item Tracking Code") and ItemTrackingCode."Lot Specific Tracking" then
                        CreateReservEntryForDummyLotAssign(PurchaseLine."Document No.", PurchaseLine."Line No.");

                    if not PostWhseReceiptLine then
                        PostWhseReceiptLine := WhseReceiptLine."Qty. to Receive" <> 0;
                end else begin
                    PurchaseLine.VALIDATE("Qty. to Receive", PurchaseLine."Qty. to Receive" + InterfaceEntryLine.Quantity);
                    PurchaseLine.VALIDATE("Qty. to Invoice", 0);
                    PurchaseLine.MODIFY();
                    PostPO := PurchaseLine."Qty. to Receive" <> 0;
                end;
            until InterfaceEntryLine.NEXT() = 0;

            if PostWhseReceiptLine then begin
                WhseReceiptLine.RESET();
                WhseReceiptLine.SETRANGE("Source Type", DATABASE::"Purchase Line");
                WhseReceiptLine.SETRANGE("Source Subtype", PurchaseLine."Document Type");
                WhseReceiptLine.SETRANGE("Source No.", PurchaseLine."Document No.");
                WhseReceiptLine.SETFILTER("Qty. to Receive", '<>%1', 0);
                if WhseReceiptLine.findset() then
                    repeat
                        CODEUNIT.RUN(CODEUNIT::"Whse.-Post Receipt", WhseReceiptLine);
                    until WhseReceiptLine.NEXT() = 0;
            end;
            if PostPO then begin
                CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeader);
                PurchaseHeader.Receive := true;
                PurchaseHeader.Invoice := false;
                CODEUNIT.RUN(CODEUNIT::"Purch.-Post", PurchaseHeader);
            end;
        end;
        //HEI.02>>
    end;

    procedure CreateReservEntryForDummyLotAssign(DocumentNo: Code[20]; LineNo: Integer);
    var
        ReservationEntry: Record "Reservation Entry";
        LastEntryNo: Integer;
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        LSRInterfaceSetup: Record "LSR Interface Setup INT";
    begin
        //HEI.02<<
        ReservationEntry.RESET();
        ReservationEntry.SETRANGE("Source Type", DATABASE::"Purchase Line");
        ReservationEntry.SETRANGE("Source Subtype", ReservationEntry."Source Subtype"::"1");
        ReservationEntry.SETRANGE("Source ID", DocumentNo);
        ReservationEntry.SETRANGE("Source Ref. No.", LineNo);
        ReservationEntry.DELETEALL();

        ReservationEntry.RESET();
        if ReservationEntry.FINDLAST() then
            LastEntryNo := ReservationEntry."Entry No.";
        if LSRInterfaceSetup.GET() then;

        WarehouseReceiptLine.SETRANGE("Source No.", DocumentNo);
        //WarehouseReceiptLine.SETFILTER("Qty. to Receive",'<>%1',0);
        WarehouseReceiptLine.SETRANGE("Source Line No.", LineNo);
        if WarehouseReceiptLine.findset() then
            repeat
                ReservationEntry.INIT();
                ReservationEntry."Entry No." := LastEntryNo + 1;
                ReservationEntry.Positive := WarehouseReceiptLine.Quantity > 0;
                ReservationEntry."Source Type" := DATABASE::"Purchase Line";
                ReservationEntry."Source Subtype" := ReservationEntry."Source Subtype"::"1";
                ReservationEntry."Source ID" := DocumentNo;
                ReservationEntry."Source Ref. No." := WarehouseReceiptLine."Source Line No.";
                ReservationEntry."Created By" := USERID;
                ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Lot No.";
                ReservationEntry.VALIDATE("Item No.", WarehouseReceiptLine."Item No.");
                ReservationEntry.VALIDATE("Location Code", WarehouseReceiptLine."Location Code");
                // ReservationEntry.VALIDATE("Bin Code", WarehouseReceiptLine."Bin Code");  // BC Upgrade NANDIS03 - Blocked as DIT field
                ReservationEntry.VALIDATE("Reservation Status", ReservationEntry."Reservation Status"::Surplus);
                ReservationEntry.VALIDATE("Lot No.", LSRInterfaceSetup."Fixed Lot No.");
                ReservationEntry.VALIDATE(Quantity, WarehouseReceiptLine.Quantity);
                ReservationEntry.VALIDATE("Quantity (Base)", WarehouseReceiptLine."Qty. (Base)");
                ReservationEntry.VALIDATE("Qty. to Handle (Base)", ReservationEntry."Quantity (Base)");
                ReservationEntry.INSERT();
                LastEntryNo += 1;
            until WarehouseReceiptLine.NEXT() = 0;
        //HEI.02>>
    end;

    procedure ProcessLSRTransferShipmentInbound(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        InterfaceSetup: Record "Interface Setup INT";
        TransferHeader: Record "Transfer Header";
        LocationFrom: Record Location;
        LocationTo: Record Location;
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        WarehouseShipmentHeader2: Record "Warehouse Shipment Header";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        WarehouseShipmentLine2: Record "Warehouse Shipment Line";
        WarehouseShipmentLine3: Record "Warehouse Shipment Line";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
        Bin: Record Bin;
        WhsePostShipment: Codeunit "Whse.-Post Shipment";
        WarehouseShipNo: Code[20];
        GenfunctionAptean: Codeunit GenFunctions108FDW; //BC Upgrade VAMSIU01 Added
    begin
        //HEI.03>>
        if not LSRInterfaceSetup.GET() or not LSRInterfaceSetup."Enable LSR Interface" then
            exit;

        LSRInterfaceSetup.TESTFIELD("Transfer Shipment Interface");
        InterfaceSetup.GET(LSRInterfaceSetup."Transfer Shipment Interface");
        if not InterfaceSetup.Enabled then
            exit;

        TransferHeader.SETRANGE("LSR Order No FND", InterfaceEntryHeaderVIP."Source No.");
        if not TransferHeader.FINDFIRST() then
            ERROR(TODoesntExistErr, InterfaceEntryHeaderVIP."Source No.");

        //LocationFrom.GET(TransferHeader."Transfer-from Code"); //HEI.07
        //LocationFrom.TESTFIELD(Store,TRUE);

        //LocationTo.GET(TransferHeader."Transfer-to Code"); //HEI.07
        //LocationTo.TESTFIELD(Store,FALSE);

        WarehouseShipNo := '';

        //Check if Whse Ship is created. If created then delete it
        WarehouseShipmentHeader2.SETRANGE("Source Document Type FND", WarehouseShipmentHeader2."Source Document Type FND"::"Outbound Transfer");
        WarehouseShipmentHeader2.SETRANGE("Source No. FND", TransferHeader."No.");
        if WarehouseShipmentHeader2.FINDFIRST() then
            WarehouseShipmentHeader2.DELETE(true);

        //Create Whse Shipment
        GetSourceDocOutbound.CreateFromOutbndTransferOrderHideDialog(TransferHeader);

        //Update Whse Shpt Header
        WarehouseShipmentHeader.SETRANGE("Source Document Type FND", WarehouseShipmentHeader."Source Document Type FND"::"Outbound Transfer");
        WarehouseShipmentHeader.SETRANGE("Source No. FND", TransferHeader."No.");
        if WarehouseShipmentHeader.FINDFIRST() then begin
            WarehouseShipNo := WarehouseShipmentHeader."No.";
            WarehouseShipmentHeader."External Document No." := InterfaceEntryHeaderVIP."External Document No.";
            if WarehouseShipmentHeader."Location Code" <> InterfaceEntryHeaderVIP."Location Code" then
                WarehouseShipmentHeader.VALIDATE("Location Code", InterfaceEntryHeaderVIP."Location Code");
            if WarehouseShipmentHeader."Posting Date" <> InterfaceEntryHeaderVIP."Posting Date" then
                WarehouseShipmentHeader.VALIDATE("Posting Date", InterfaceEntryHeaderVIP."Posting Date");
            WarehouseShipmentHeader.MODIFY(true);

            InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
            if InterfaceEntryLineVIP.findset() then
                repeat
                    WarehouseShipmentLine.SETRANGE("No.", WarehouseShipmentHeader."No.");
                    WarehouseShipmentLine.SETRANGE("Source Line No.", InterfaceEntryLineVIP."Source Line No.");
                    if WarehouseShipmentLine.FINDFIRST() then
                        if InterfaceEntryLineVIP.Quantity <> 0 then begin
                            //Update Whse Shpt Lines
                            if WarehouseShipmentLine.Quantity <> InterfaceEntryLineVIP.Quantity then
                                WarehouseShipmentLine.VALIDATE(Quantity, InterfaceEntryLineVIP.Quantity);
                            if WarehouseShipmentLine."Unit of Measure Code" <> InterfaceEntryLineVIP."Unit of Measure Code" then
                                WarehouseShipmentLine.VALIDATE("Unit of Measure Code", InterfaceEntryLineVIP."Unit of Measure Code");

                            if InterfaceEntryLineVIP."Customer Code" <> '' then begin
                                Bin.GET(InterfaceEntryHeaderVIP."Location Code", InterfaceEntryLineVIP."Customer Code");
                                if WarehouseShipmentLine."Zone Code" <> Bin."Zone Code" then
                                    WarehouseShipmentLine.VALIDATE("Zone Code", Bin."Zone Code");
                                if WarehouseShipmentLine."Bin Code" <> InterfaceEntryLineVIP."Customer Code" then
                                    WarehouseShipmentLine.VALIDATE("Bin Code", InterfaceEntryLineVIP."Customer Code");
                            end else begin
                                Bin.SETRANGE("Location Code", InterfaceEntryHeaderVIP."Location Code");
                                Bin.FINDFIRST();
                                WarehouseShipmentLine.VALIDATE("Zone Code", Bin."Zone Code");
                                WarehouseShipmentLine.VALIDATE("Bin Code", Bin.Code);
                            end;

                            WarehouseShipmentLine.MODIFY(true);
                        end else
                            WarehouseShipmentLine.DELETE(true);
                until InterfaceEntryLineVIP.NEXT() = 0;

            //AutoFEFO
            // WarehouseShipmentHeader.FEFOTrackingShipment;  // BC Upgrade NANDIS03 - Blocked as DIT function called here
        end;

        //AutoFEFO - for missing stock
        //WarehouseShipmentHeader.FEFOTrackingShipment;

        //Post the Shipment
        WarehouseShipmentLine2.SETRANGE("No.", WarehouseShipNo);
        if WarehouseShipmentLine2.FINDFIRST() then begin
            GenfunctionAptean.AssignFEFOTracking(WarehouseShipmentLine2); // BC Upgrade VAMSIU01 Added FEFOTracking
            WhsePostShipment.SetPostingSettings(true);
            WhsePostShipment.SetPrint(false);
            WhsePostShipment.RUN(WarehouseShipmentLine2);
            CLEAR(WhsePostShipment);
        end;
        //HEI.03<<
    end;

    procedure ProcessLSRTransferReceiptInbound(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        InterfaceSetup: Record "Interface Setup INT";
        TransferHeader: Record "Transfer Header";
        LocationFrom: Record Location;
        LocationTo: Record Location;
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
        WarehouseReceiptHeader2: Record "Warehouse Receipt Header";
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        WarehouseReceiptLine2: Record "Warehouse Receipt Line";
        WarehouseReceiptLine3: Record "Warehouse Receipt Line";
        Bin: Record Bin;
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry2: Record "Reservation Entry";
        ReservationEntry3: Record "Reservation Entry";
        ReservationEntry4: Record "Reservation Entry";
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalLine2: Record "Item Journal Line";
        ItemJournalLine3: Record "Item Journal Line";
        ItemJournalLine4: Record "Item Journal Line";
        SourceCodeSetup: Record "Source Code Setup";
        LotNoInformation: Record "Lot No. Information";
        WhsePostReceipt: Codeunit "Whse.-Post Receipt";
        WarehouseReceiptNo: Code[20];
        TransferReceiptHeader: Record "Transfer Receipt Header";
        TransferReceiptNo: Code[20];
        TransferShipmentLine: Record "Transfer Shipment Line";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        TransferReceiptHeader2: Record "Transfer Receipt Header";
        ItemReclassificationPosted: Boolean;
        ReservedQty: Decimal;
        TotalQty: Decimal;
        ReclassQty: Decimal;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        CallFrom: Option TransferHeader,ItemJnlLine;
    begin
        //HEI.03>>
        if not LSRInterfaceSetup.GET() or not LSRInterfaceSetup."Enable LSR Interface" then
            exit;

        LSRInterfaceSetup.TESTFIELD("Transfer Receipt Interface");
        InterfaceSetup.GET(LSRInterfaceSetup."Transfer Receipt Interface");
        if not InterfaceSetup.Enabled then
            exit;

        //HEI.06>>
        ItemReclassificationPosted := false;
        TransferReceiptHeader2.SETRANGE("LSR Order No FND", InterfaceEntryHeaderVIP."Source No.");
        if TransferReceiptHeader2.FINDFIRST() then begin
            UpdateItemReclassification(TransferReceiptHeader2, InterfaceEntryHeaderVIP);
            ItemReclassificationPosted := true;
        end;
        //HEI.06<<

        TransferHeader.SETRANGE("LSR Order No FND", InterfaceEntryHeaderVIP."Source No.");
        //HEI.06>>
        //IF NOT TransferHeader.FINDFIRST THEN
        if not TransferHeader.FINDFIRST() and not ItemReclassificationPosted then
            //HEI.06<<
            ERROR(TODoesntExistErr, InterfaceEntryHeaderVIP."Source No.");

        TransferShipmentHeader.SETRANGE("LSR Order No FND", InterfaceEntryHeaderVIP."Source No.");
        if not TransferShipmentHeader.FINDFIRST() then
            ERROR(TSDoesntExistErr, InterfaceEntryHeaderVIP."Source No.");

        //LocationTo.GET(TransferHeader."Transfer-to Code"); //HEI.07
        //LocationTo.TESTFIELD(Store,TRUE);

        //LocationFrom.GET(TransferHeader."Transfer-from Code"); //HEI.07
        //LocationFrom.TESTFIELD(Store,FALSE);

        WarehouseReceiptNo := '';

        CheckAndCreateBinContent(TransferHeader, CallFrom::TransferHeader, '', '', '');//HEI.08>>

        if not ItemReclassificationPosted then begin //HEI.06
                                                     //Check if Whse Rcpt is created
            WarehouseReceiptHeader2.SETRANGE("Source Document Type FND", WarehouseReceiptHeader2."Source Document Type FND"::"Inbound Transfer");
            WarehouseReceiptHeader2.SETRANGE("Source No. FND", TransferHeader."No.");
            if WarehouseReceiptHeader2.FINDFIRST() then
                WarehouseReceiptHeader2.DELETE(true);

            ItemJournalLine4.SETRANGE("Journal Template Name", LSRInterfaceSetup."Item Reclass. Jnl. Template");
            ItemJournalLine4.SETRANGE("Journal Batch Name", LSRInterfaceSetup."Item Reclass. Jnl. Batch");
            ItemJournalLine4.SETRANGE("Document No.", TransferHeader."No.");
            if ItemJournalLine4.findset() then
                repeat
                    ReservationEntry4.SETRANGE("Source ID", ItemJournalLine4."Journal Template Name");
                    ReservationEntry4.VALIDATE("Source Batch Name", ItemJournalLine4."Journal Batch Name");
                    ReservationEntry4.VALIDATE("Source Prod. Order Line", 0);
                    ReservationEntry4.VALIDATE("Source Ref. No.", ItemJournalLine4."Line No.");
                    if ReservationEntry4.findset() then
                        repeat
                            ReservationEntry4.DELETE();
                        until ReservationEntry4.NEXT() = 0;

                    ItemJournalLine4.DELETE(true);
                until ItemJournalLine4.NEXT() = 0;

            //Create Whse Receipt
            GetSourceDocInbound.CreateFromInbndTransferOrderHideDialog(TransferHeader);

            //Update Whse Receipt Header
            WarehouseReceiptHeader.SETRANGE("Source Document Type FND", WarehouseReceiptHeader."Source Document Type FND"::"Inbound Transfer");
            WarehouseReceiptHeader.SETRANGE("Source No. FND", TransferHeader."No.");
            if WarehouseReceiptHeader.FINDFIRST() then begin
                WarehouseReceiptNo := WarehouseReceiptHeader."No.";
                WarehouseReceiptHeader."LSR Receipt No. FND" := InterfaceEntryHeaderVIP."External Document No.";
                WarehouseReceiptHeader."LSR Order No. FND" := InterfaceEntryHeaderVIP."Source No.";
                if WarehouseReceiptHeader."Location Code" <> InterfaceEntryHeaderVIP."Location Code" then
                    WarehouseReceiptHeader.VALIDATE("Location Code", InterfaceEntryHeaderVIP."Location Code");
                if WarehouseReceiptHeader."Posting Date" <> InterfaceEntryHeaderVIP."Posting Date" then
                    WarehouseReceiptHeader.VALIDATE("Posting Date", InterfaceEntryHeaderVIP."Posting Date");
                WarehouseReceiptHeader.MODIFY(true);

                //HEI.05>>
                //Make Qty to Receive = 0 for all Whse Receipts Lines
                WarehouseReceiptLine3.RESET();
                WarehouseReceiptLine3.SETRANGE("No.", WarehouseReceiptHeader."No.");
                if WarehouseReceiptLine3.findset() then
                    WarehouseReceiptLine3.MODIFYALL("Qty. to Receive", 0);
                //HEI.05<<

                InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
                if InterfaceEntryLineVIP.findset() then
                    repeat
                        WarehouseReceiptLine.SETRANGE("No.", WarehouseReceiptHeader."No.");
                        WarehouseReceiptLine.SETRANGE("Source Line No.", InterfaceEntryLineVIP."Source Line No.");
                        if WarehouseReceiptLine.FINDFIRST() then begin
                            if InterfaceEntryLineVIP.Quantity <> 0 then begin
                                //Update Whse Rcpt Lines
                                //IF WarehouseReceiptLine.Quantity <> InterfaceEntryLineVIP.Quantity THEN //HEI.05
                                //WarehouseReceiptLine.VALIDATE(Quantity,InterfaceEntryLineVIP.Quantity);
                                WarehouseReceiptLine.VALIDATE("Qty. to Receive", InterfaceEntryLineVIP.Quantity);
                                if WarehouseReceiptLine."Unit of Measure Code" <> InterfaceEntryLineVIP."Unit of Measure Code" then
                                    WarehouseReceiptLine.VALIDATE("Unit of Measure Code", InterfaceEntryLineVIP."Unit of Measure Code");

                                if InterfaceEntryLineVIP."Customer Code" <> '' then begin
                                    Bin.GET(InterfaceEntryHeaderVIP."Location Code", InterfaceEntryLineVIP."Customer Code");
                                    if WarehouseReceiptLine."Zone Code" <> Bin."Zone Code" then begin //HEI.06
                                        WarehouseReceiptLine.VALIDATE("Bin Code", ''); //HEI.06
                                        WarehouseReceiptLine.VALIDATE("Zone Code", Bin."Zone Code");
                                    end; //HEI.06
                                    if WarehouseReceiptLine."Bin Code" <> InterfaceEntryLineVIP."Customer Code" then
                                        WarehouseReceiptLine.VALIDATE("Bin Code", InterfaceEntryLineVIP."Customer Code");
                                end else begin
                                    Bin.SETRANGE("Location Code", InterfaceEntryHeaderVIP."Location Code");
                                    Bin.FINDFIRST();
                                    WarehouseReceiptLine.VALIDATE("Zone Code", Bin."Zone Code");
                                    WarehouseReceiptLine.VALIDATE("Bin Code", Bin.Code);
                                end;
                                WarehouseReceiptLine.MODIFY(true);

                                //Check Reservation Entries
                                Item.GET(InterfaceEntryLineVIP."No.");

                                //HEI.07>>
                                ReservedQty := 0;
                                if ItemUnitofMeasure.GET(InterfaceEntryLineVIP."No.", InterfaceEntryLineVIP."Unit of Measure Code") then
                                    TotalQty := InterfaceEntryLineVIP.Quantity * ItemUnitofMeasure."Qty. per Unit of Measure"
                                else
                                    TotalQty := InterfaceEntryLineVIP.Quantity;
                                //HEI.07<<

                                if ItemTrackingCode.GET(Item."Item Tracking Code") and ItemTrackingCode."Lot Specific Tracking" //AND
                                                                                                                                //(LocationTo.Store OR LocationFrom.Store)
                                then begin
                                    ReservationEntry.RESET();
                                    ReservationEntry.SETRANGE("Source Type", 5741);
                                    ReservationEntry.SETRANGE("Source Subtype", ReservationEntry."Source Subtype"::"1");
                                    ReservationEntry.SETRANGE("Source ID", TransferHeader."No.");
                                    ReservationEntry.SETRANGE("Location Code", InterfaceEntryHeaderVIP."Location Code");
                                    ReservationEntry.SETRANGE("Source Prod. Order Line", InterfaceEntryLineVIP."Source Line No.");
                                    if ReservationEntry.findset() then
                                        repeat
                                            if ReservationEntry."Lot No." <> LSRInterfaceSetup."Fixed Lot No." then begin
                                                //Create Item Reclassification Journal lines
                                                /*//Check if the Item Jnl Line is already inserted
                                                ItemJournalLine3.RESET;
                                                ItemJournalLine3.SETRANGE("Journal Template Name",LSRInterfaceSetup."Item Reclass. Jnl. Template");
                                                ItemJournalLine3.SETRANGE("Journal Batch Name",LSRInterfaceSetup."Item Reclass. Jnl. Batch");
                                                ItemJournalLine3.SETRANGE("Item No.",WarehouseReceiptLine."Item No.");
                                                */

                                                //HEI.07>>
                                                ReclassQty := 0;
                                                if ReservationEntry."Quantity (Base)" <= TotalQty - ReservedQty then
                                                    ReclassQty := ReservationEntry."Quantity (Base)"
                                                else
                                                    ReclassQty := TotalQty - ReservedQty;

                                                ReservedQty += ReclassQty;

                                                if ReclassQty > 0 then begin
                                                    //HEI.07<<

                                                    //HEI.08>>
                                                    CheckAndCreateBinContent(TransferHeader, CallFrom::ItemJnlLine, InterfaceEntryHeaderVIP."Location Code", Bin.Code, InterfaceEntryLineVIP."No.");
                                                    //HEI.08<<

                                                    ItemJournalLine.INIT();
                                                    ItemJournalLine.VALIDATE("Journal Template Name", LSRInterfaceSetup."Item Reclass. Jnl. Template");
                                                    ItemJournalLine.VALIDATE("Journal Batch Name", LSRInterfaceSetup."Item Reclass. Jnl. Batch");

                                                    ItemJournalLine2.SETRANGE("Journal Template Name", LSRInterfaceSetup."Item Reclass. Jnl. Template");
                                                    ItemJournalLine2.SETRANGE("Journal Batch Name", LSRInterfaceSetup."Item Reclass. Jnl. Batch");
                                                    if ItemJournalLine2.FINDLAST() then
                                                        ItemJournalLine.VALIDATE("Line No.", ItemJournalLine2."Line No." + 10000)
                                                    else
                                                        ItemJournalLine.VALIDATE("Line No.", 10000);
                                                    ItemJournalLine.INSERT(true);

                                                    SourceCodeSetup.GET();
                                                    ItemJournalLine.VALIDATE("Source Code", SourceCodeSetup."Item Reclass. Journal");
                                                    ItemJournalLine.VALIDATE("Entry Type", ItemJournalLine."Entry Type"::Transfer);
                                                    ItemJournalLine.VALIDATE("Document No.", TransferHeader."No.");
                                                    ItemJournalLine.VALIDATE("Posting Date", InterfaceEntryHeaderVIP."Posting Date");
                                                    ItemJournalLine.VALIDATE("Item No.", InterfaceEntryLineVIP."No.");

                                                    //ItemJournalLine.VALIDATE(Quantity,InterfaceEntryLineVIP.Quantity);
                                                    //HEI.05>>
                                                    //ItemJournalLine.VALIDATE(Quantity,ReservationEntry.Quantity);
                                                    //ItemJournalLine.VALIDATE(Quantity,ReservationEntry."Qty. per Unit of Measure" * InterfaceEntryLineVIP.Quantity); //HEI.07
                                                    //HEI.05<<
                                                    ItemJournalLine.VALIDATE(Quantity, ReclassQty); //HEI.07

                                                    //ItemJournalLine.VALIDATE("Unit of Measure Code",InterfaceEntryLineVIP."Unit of Measure Code");
                                                    ItemJournalLine.VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
                                                    ItemJournalLine.VALIDATE("Location Code", InterfaceEntryHeaderVIP."Location Code");
                                                    ItemJournalLine.VALIDATE("New Location Code", InterfaceEntryHeaderVIP."Location Code");
                                                    ItemJournalLine.VALIDATE("Zone Code FND", Bin."Zone Code");
                                                    ItemJournalLine.VALIDATE("New Zone Code FND", Bin."Zone Code");
                                                    ItemJournalLine.VALIDATE("Bin Code", Bin.Code);
                                                    ItemJournalLine.VALIDATE("New Bin Code", Bin.Code);
                                                    ItemJournalLine.MODIFY();

                                                    //Create Item Tracking
                                                    ReservationEntry3.INIT();
                                                    ReservationEntry3.COPY(ReservationEntry);
                                                    if ReservationEntry2.FINDLAST() then
                                                        ReservationEntry3.VALIDATE("Entry No.", ReservationEntry2."Entry No." + 1)
                                                    else
                                                        ReservationEntry3.VALIDATE("Entry No.", 1);
                                                    ReservationEntry3.VALIDATE("Source Type", 83);
                                                    ReservationEntry3.VALIDATE("Source Subtype", ReservationEntry3."Source Subtype"::"4");
                                                    ReservationEntry3.VALIDATE("Source ID", ItemJournalLine."Journal Template Name");
                                                    ReservationEntry3.VALIDATE("Source Batch Name", ItemJournalLine."Journal Batch Name");
                                                    ReservationEntry3.VALIDATE("Source Prod. Order Line", 0);
                                                    ReservationEntry3.VALIDATE("Source Ref. No.", ItemJournalLine."Line No.");

                                                    //HEI.06>>
                                                    ReservationEntry3.VALIDATE("Reservation Status", ReservationEntry3."Reservation Status"::Prospect);
                                                    ReservationEntry3.VALIDATE("Shipment Date", ReservationEntry."Expected Receipt Date");
                                                    ReservationEntry3."Expected Receipt Date" := 0D;
                                                    ReservationEntry3.Positive := ReservationEntry3.Quantity > 0;
                                                    //HEI.06<<

                                                    //HEI.05>>
                                                    //ReservationEntry3.VALIDATE(Quantity,-ReservationEntry.Quantity);
                                                    //ReservationEntry3."Quantity (Base)" := -ReservationEntry."Quantity (Base)";
                                                    //ReservationEntry3."Qty. to Handle (Base)" := -ReservationEntry."Quantity (Base)";
                                                    //ReservationEntry3."Qty. to Invoice (Base)" := -ReservationEntry."Quantity (Base)";
                                                    //HEI.07>>
                                                    //ReservationEntry3.VALIDATE(Quantity,-ReservationEntry."Qty. per Unit of Measure" * InterfaceEntryLineVIP.Quantity);
                                                    ReservationEntry3.VALIDATE(Quantity, -ReclassQty);
                                                    //HEI.07<<

                                                    ReservationEntry3."Quantity (Base)" := ReservationEntry3.Quantity;
                                                    ReservationEntry3."Qty. to Handle (Base)" := ReservationEntry3."Quantity (Base)";
                                                    ReservationEntry3."Qty. to Invoice (Base)" := ReservationEntry3."Quantity (Base)";
                                                    //HEI.05<<

                                                    ReservationEntry3.VALIDATE("New Lot No.", LSRInterfaceSetup."Fixed Lot No.");
                                                    if ItemTrackingCode."Man. Expir. Date Entry Reqd." then
                                                        ReservationEntry3.VALIDATE("New Expiration Date", 99991231D);
                                                    ReservationEntry3.INSERT();
                                                end;
                                            end; //HEI.07
                                        until ReservationEntry.NEXT() = 0;
                                end;
                            end else
                                WarehouseReceiptLine.DELETE(true);
                        end;
                    until InterfaceEntryLineVIP.NEXT() = 0;
            end;

            //Post the Receipt
            WarehouseReceiptLine2.SETRANGE("No.", WarehouseReceiptNo);
            WarehouseReceiptLine2.SETFILTER("Qty. to Receive", '<>%1', 0); //HEI.06
            if WarehouseReceiptLine2.FINDFIRST() then begin
                WhsePostReceipt.RUN(WarehouseReceiptLine2);
                CLEAR(WhsePostReceipt);
            end;

            //Update Document No. in Item Reclass Journal
            TransferReceiptNo := '';
            TransferReceiptHeader.SETRANGE("Transfer Order No.", TransferHeader."No.");
            if TransferReceiptHeader.FINDLAST() then
                TransferReceiptNo := TransferReceiptHeader."No.";

            ItemJournalLine2.RESET();
            CLEAR(ItemJournalLine2);
            ItemJournalLine2.SETRANGE("Journal Template Name", LSRInterfaceSetup."Item Reclass. Jnl. Template");
            ItemJournalLine2.SETRANGE("Journal Batch Name", LSRInterfaceSetup."Item Reclass. Jnl. Batch");
            ItemJournalLine2.SETRANGE("Document No.", TransferHeader."No.");
            if ItemJournalLine2.findset() then
                repeat
                    ItemJournalLine2."Document No." := TransferReceiptNo;
                    ItemJournalLine2.MODIFY();
                until ItemJournalLine2.NEXT() = 0;

            //Post the Item Reclassification Journal
            ItemJournalLine2.RESET();
            CLEAR(ItemJournalLine2);
            ItemJournalLine2.SETRANGE("Journal Template Name", LSRInterfaceSetup."Item Reclass. Jnl. Template");
            ItemJournalLine2.SETRANGE("Journal Batch Name", LSRInterfaceSetup."Item Reclass. Jnl. Batch");
            ItemJournalLine2.SETRANGE("Document No.", TransferReceiptNo);
            ItemJournalLine2.SETFILTER("Item No.", '<>%1', ''); //HEI.06
            if ItemJournalLine2.FINDFIRST() then
                CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Batch", ItemJournalLine2);

            //Clear Journal
            ItemJournalLine2.RESET();
            CLEAR(ItemJournalLine2);
            ItemJournalLine2.SETRANGE("Journal Template Name", LSRInterfaceSetup."Item Reclass. Jnl. Template");
            ItemJournalLine2.SETRANGE("Journal Batch Name", LSRInterfaceSetup."Item Reclass. Jnl. Batch");
            ItemJournalLine2.SETRANGE("Document No.", TransferReceiptNo);
            ItemJournalLine2.SETRANGE("Item No.", '');
            if ItemJournalLine2.FINDFIRST() then
                ItemJournalLine2.DELETEALL();
        end; //HEI.06
        //HEI.03<<

    end;

    procedure ProcessLSRTransferReceiptOutbound(TransferReceiptHeader: Record "Transfer Receipt Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceFrameworkMgtVIP: Codeunit "Interface Framework Mgt. VIP";
        OutboundInterface: Record "Outbound Interface INT";
    begin
        //HEI.03>>
        if not LSRInterfaceSetup.GET() and not LSRInterfaceSetup."Enable LSR Interface" then
            exit;

        LSRInterfaceSetup.TESTFIELD("Transfer Receipt Interface Out");
        InterfaceSetup.GET(LSRInterfaceSetup."Transfer Receipt Interface Out");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgtVIP.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CreateLSRTransferReceiptResponse(TransferReceiptHeader);
        //HEI.03<<
    end;

    local procedure CreateLSRTransferReceiptResponse(TransferReceiptHeader: Record "Transfer Receipt Header");
    var
        InterfaceEntryHeaderVIPOut: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIPOut: Record "Interface Entry Line VIP INT";
        EntryNo: Integer;
        TransferReceiptLine: Record "Transfer Receipt Line";
    begin
        //HEI.03>>
        CLEAR(InterfaceEntryHeaderVIPOut);
        CLEAR(InterfaceEntryLineVIPOut);

        InterfaceEntryHeaderVIPOut.INIT();
        InterfaceEntryHeaderVIPOut."Interface Code" := LSRInterfaceSetup."Transfer Receipt Interface Out";
        InterfaceEntryHeaderVIPOut.Direction := InterfaceEntryHeaderVIPOut.Direction::Outbound;
        InterfaceEntryHeaderVIPOut.INSERT(true);

        InterfaceEntryHeaderVIPOut."Source No." := TransferReceiptHeader."No.";
        InterfaceEntryHeaderVIPOut."Location Code" := TransferReceiptHeader."Transfer-from Code";
        InterfaceEntryHeaderVIPOut.Name := TransferReceiptHeader."Transfer-from Name";
        InterfaceEntryHeaderVIPOut."Payment Terms Code" := TransferReceiptHeader."Transfer-to Code";
        InterfaceEntryHeaderVIPOut.Description := TransferReceiptHeader."Transfer-to Name";
        InterfaceEntryHeaderVIPOut."Posting Date" := TransferReceiptHeader."Posting Date";
        InterfaceEntryHeaderVIPOut."Global No." := TransferReceiptHeader."Transfer Order No.";
        InterfaceEntryHeaderVIPOut."External Document No." := TransferReceiptHeader."LSR Order No FND";
        InterfaceEntryHeaderVIPOut."Shipment Method Code" := TransferReceiptHeader."In-Transit Code";
        InterfaceEntryHeaderVIPOut.MODIFY(true);

        EntryNo := 1;
        TransferReceiptLine.SETRANGE("Document No.", TransferReceiptHeader."No.");
        if TransferReceiptLine.findset() then
            repeat
                InterfaceEntryLineVIPOut.INIT();
                InterfaceEntryLineVIPOut."Header Entry No." := InterfaceEntryHeaderVIPOut."Entry No.";
                InterfaceEntryLineVIPOut."Entry No." := EntryNo;
                InterfaceEntryLineVIPOut.INSERT(true);
                EntryNo += 1;

                InterfaceEntryLineVIPOut."Source Line No." := TransferReceiptLine."Line No.";
                InterfaceEntryLineVIPOut."No." := TransferReceiptLine."Item No.";
                InterfaceEntryLineVIPOut.Quantity := TransferReceiptLine.Quantity;
                InterfaceEntryLineVIPOut."Unit of Measure Code" := TransferReceiptLine."Unit of Measure Code";
                InterfaceEntryLineVIPOut.MODIFY(true);
            until TransferReceiptLine.NEXT() = 0;
        //HEI.03<<
    end;

    procedure ProcessLSRStockAdjustment(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        Location: Record Location;
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalLine2: Record "Item Journal Line";
        SourceCodeSetup: Record "Source Code Setup";
        Bin: Record Bin;
        GeneralLedgerSetup: Record "General Ledger Setup";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        DimensionManagement: Codeunit DimensionManagement;
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
    begin
        //HEI.03>>
        if not LSRInterfaceSetup.GET() or not LSRInterfaceSetup."Enable LSR Interface" then
            exit;

        LSRInterfaceSetup.TESTFIELD("Stock Adjustment Interface");
        InterfaceSetup.GET(LSRInterfaceSetup."Stock Adjustment Interface");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        if InterfaceEntryLineVIP.findset() then begin
            repeat
                Location.GET(InterfaceEntryLineVIP."Location Code");
                if not Location."Store FND" then
                    exit;
                //Create Item Journal lines
                ItemJournalLine.INIT();
                ItemJournalLine.VALIDATE("Journal Template Name", InterfaceEntryLineVIP.Address);
                ItemJournalLine.VALIDATE("Journal Batch Name", InterfaceEntryLineVIP."Address 2");
                ItemJournalLine.VALIDATE("Line No.", InterfaceEntryLineVIP."Source Line No.");
                ItemJournalLine.INSERT(true);

                SourceCodeSetup.GET();
                ItemJournalLine.VALIDATE("Source Code", SourceCodeSetup."Item Journal");
                ItemJournalLine.VALIDATE("Posting Date", InterfaceEntryLineVIP."Posting Date");
                ItemJournalLine.VALIDATE("Entry Type", InterfaceEntryLineVIP."Entry Type");
                ItemJournalLine.VALIDATE("Document No.", InterfaceEntryLineVIP."External Contract No.");
                ItemJournalLine.VALIDATE("External Document No.", InterfaceEntryLineVIP."External Document No.");
                ItemJournalLine.VALIDATE("Item No.", InterfaceEntryLineVIP."No.");
                if InterfaceEntryLineVIP.Description <> '' then
                    ItemJournalLine.VALIDATE(Description, InterfaceEntryLineVIP.Description);
                ItemJournalLine.VALIDATE("Location Code", InterfaceEntryLineVIP."Location Code");

                if InterfaceEntryLineVIP."Customer Code" <> '' then begin
                    Bin.GET(InterfaceEntryLineVIP."Location Code", InterfaceEntryLineVIP."Customer Code");
                    if ItemJournalLine."Zone Code FND" <> Bin."Zone Code" then
                        ItemJournalLine.VALIDATE("Zone Code FND", Bin."Zone Code");
                    if ItemJournalLine."Bin Code" <> InterfaceEntryLineVIP."Customer Code" then
                        ItemJournalLine.VALIDATE("Bin Code", InterfaceEntryLineVIP."Customer Code");
                end else begin
                    Bin.SETRANGE("Location Code", InterfaceEntryLineVIP."Location Code");
                    Bin.SETRANGE("Unavailable Stock FND", false);
                    if Bin.FINDFIRST() then begin
                        if ItemJournalLine."Zone Code FND" <> Bin."Zone Code" then
                            ItemJournalLine.VALIDATE("Zone Code FND", Bin."Zone Code");
                        if ItemJournalLine."Bin Code" <> Bin.Code then
                            ItemJournalLine.VALIDATE("Bin Code", Bin.Code);
                    end;
                end;

                ItemJournalLine.VALIDATE(Quantity, InterfaceEntryLineVIP.Quantity);
                ItemJournalLine.VALIDATE("Unit of Measure Code", InterfaceEntryLineVIP."Unit of Measure Code");
                ItemJournalLine.VALIDATE("Reason Code", InterfaceEntryLineVIP."Payment Method Code");

                //Assign CCC Dimension
                GeneralLedgerSetup.GET();
                if InterfaceEntryLineVIP."Item Dim. Value Code1" <> '' then begin
                    CLEAR(TempDimensionSetEntry);
                    DimensionManagement.GetDimensionSet(TempDimensionSetEntry, ItemJournalLine."Dimension Set ID");
                    TempDimensionSetEntry.SETRANGE("Dimension Code", GeneralLedgerSetup."Cost Center Dimension Code FND");
                    if TempDimensionSetEntry.FINDFIRST() and (TempDimensionSetEntry."Dimension Value Code" <> InterfaceEntryLineVIP."Item Dim. Value Code1") then
                        TempDimensionSetEntry.DELETE();

                    TempDimensionSetEntry.INIT();
                    TempDimensionSetEntry."Dimension Code" := GeneralLedgerSetup."Cost Center Dimension Code FND";
                    TempDimensionSetEntry."Dimension Value Code" := InterfaceEntryLineVIP."Item Dim. Value Code1";
                    if TempDimensionSetEntry.INSERT(true) then;
                    ItemJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                end;
                ItemJournalLine.MODIFY(true);

                //Item Tracking Assignment
                Item.GET(ItemJournalLine."Item No.");
                if ItemTrackingCode.GET(Item."Item Tracking Code") and ItemTrackingCode."Lot Specific Tracking" then
                    CreateReservationEntry(ItemJournalLine, LSRInterfaceSetup."Fixed Lot No.");

            until InterfaceEntryLineVIP.NEXT() = 0;

            //Post Item Journal
            ItemJournalLine2.RESET();
            CLEAR(ItemJournalLine2);
            ItemJournalLine2.SETRANGE("Journal Template Name", InterfaceEntryLineVIP.Address);
            ItemJournalLine2.SETRANGE("Journal Batch Name", InterfaceEntryLineVIP."Address 2");
            ItemJournalLine2.SETRANGE("Document No.", InterfaceEntryLineVIP."External Contract No.");
            if ItemJournalLine2.FINDFIRST() then
                CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Batch", ItemJournalLine);

            //Clear Journal
            ItemJournalLine2.RESET();
            CLEAR(ItemJournalLine2);
            ItemJournalLine2.SETRANGE("Journal Template Name", InterfaceEntryLineVIP.Address);
            ItemJournalLine2.SETRANGE("Journal Batch Name", InterfaceEntryLineVIP."Address 2");
            ItemJournalLine2.SETRANGE("Document No.", InterfaceEntryLineVIP."External Contract No.");
            ItemJournalLine2.SETRANGE("Item No.", '');
            if ItemJournalLine2.FINDFIRST() then
                ItemJournalLine2.DELETEALL();
        end;
        //HEI.03<<
    end;

    local procedure CreateReservationEntry(ItemJournalLine: Record "Item Journal Line"; LotNo: Code[20]);
    var
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry2: Record "Reservation Entry";
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
    begin
        //HEI.03<<
        ReservationEntry.RESET();
        ReservationEntry.INIT();
        if ReservationEntry2.FINDLAST() then
            ReservationEntry.VALIDATE("Entry No.", ReservationEntry2."Entry No." + 1);

        ReservationEntry."Source Type" := DATABASE::"Item Journal Line";
        ReservationEntry."Source Subtype" := ItemJournalLine."Entry Type".AsInteger();
        ReservationEntry."Source ID" := ItemJournalLine."Journal Template Name";
        ReservationEntry."Source Batch Name" := ItemJournalLine."Journal Batch Name";
        ReservationEntry."Source Ref. No." := ItemJournalLine."Line No.";
        ReservationEntry."Creation Date" := ItemJournalLine."Posting Date";
        ReservationEntry."Created By" := USERID;
        ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Lot No.";
        ReservationEntry.VALIDATE("Item No.", ItemJournalLine."Item No.");
        ReservationEntry.VALIDATE("Location Code", ItemJournalLine."Location Code");
        // ReservationEntry.VALIDATE("Bin Code", ItemJournalLine."Bin Code");  // BC Upgrade NANDIS03 - Blocked as DIT field
        ReservationEntry.VALIDATE("Reservation Status", ReservationEntry."Reservation Status"::Prospect);
        ReservationEntry.VALIDATE("Lot No.", LotNo);
        Item.GET(ItemJournalLine."Item No.");
        if ItemTrackingCode.GET(Item."Item Tracking Code") then
            if ItemTrackingCode."Man. Expir. Date Entry Reqd." then begin
                ReservationEntry."Expiration Date" := 99991231D;
            end;
        if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Positive Adjmt." then begin
            ReservationEntry.VALIDATE("Expected Receipt Date", ItemJournalLine."Posting Date");
            ReservationEntry.VALIDATE(Quantity, ItemJournalLine.Quantity);
            ReservationEntry."Quantity (Base)" := ItemJournalLine."Quantity (Base)";
        end else if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Negative Adjmt." then begin
            ReservationEntry.VALIDATE("Shipment Date", ItemJournalLine."Posting Date");
            ReservationEntry.VALIDATE(Quantity, -ItemJournalLine.Quantity);
            ReservationEntry."Quantity (Base)" := -ItemJournalLine."Quantity (Base)";
        end;
        ReservationEntry."Qty. to Handle (Base)" := ReservationEntry."Quantity (Base)";
        ReservationEntry."Qty. to Invoice (Base)" := ReservationEntry."Quantity (Base)";
        ReservationEntry."Qty. per Unit of Measure" := ItemJournalLine."Qty. per Unit of Measure";
        ReservationEntry.Positive := ReservationEntry.Quantity > 0;
        ReservationEntry.INSERT(true);
        //HEI.03>>
    end;

    procedure ProcessLSRTransferOrderInbound(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        InterfaceSetup: Record "Interface Setup INT";
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        LSRText001: Label 'There are %1 transfer orders in the system with same LSR Order No. %2 .';
        TransferCounts: Integer;
        ReleaseTransferDocument: Codeunit "Release Transfer Document";
    begin
        //HEI.04>>
        if not LSRInterfaceSetup.GET() or not LSRInterfaceSetup."Enable LSR Interface" then
            exit;
        LSRInterfaceSetup.TESTFIELD("Transfer Order Interface");
        InterfaceSetup.GET(LSRInterfaceSetup."Transfer Order Interface");
        if not InterfaceSetup.Enabled then
            exit;

        TransferHeader.SETRANGE("LSR Order No FND", InterfaceEntryHeaderVIP."Source No.");
        TransferCounts := TransferHeader.COUNT;

        if TransferCounts > 1 then
            ERROR(LSRText001, TransferCounts, InterfaceEntryHeaderVIP."Source No.");

        if TransferCounts = 0 then begin
            TransferHeader.RESET();
            TransferHeader.INSERT(true);
        end else begin
            TransferHeader.FINDFIRST();
            ReleaseTransferDocument.Reopen(TransferHeader);

            TransferLine.SETRANGE("Document No.", TransferHeader."No.");
            TransferLine.DELETEALL(true);
        end;

        TransferHeader.VALIDATE("Transfer-from Code", InterfaceEntryHeaderVIP."Location Code");
        TransferHeader.VALIDATE("Transfer-to Code", InterfaceEntryHeaderVIP."Payment Terms Code");
        TransferHeader.VALIDATE("Posting Date", InterfaceEntryHeaderVIP."Posting Date");
        TransferHeader."External Document No." := InterfaceEntryHeaderVIP."Source No.";
        TransferHeader."LSR Order No FND" := InterfaceEntryHeaderVIP."Source No.";
        // BC UPGRADE PATELS08 >>
        //HEI.12>>
        TransferHeader.VALIDATE("Shipping Agent Code", InterfaceEntryHeaderVIP.EAN);
        TransferHeader.VALIDATE("Shipping Agent Service Code", InterfaceEntryHeaderVIP."External Contract No.");
        //HEI.12<<
        // BC UPGRADE PATELS08 <<
        TransferHeader.MODIFY(true);

        //create lines
        InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        if InterfaceEntryLineVIP.findset() then
            repeat
                TransferLine.VALIDATE("Document No.", TransferHeader."No.");
                TransferLine.VALIDATE("Line No.", InterfaceEntryLineVIP."Source Line No.");
                TransferLine.VALIDATE("Item No.", InterfaceEntryLineVIP."No.");
                TransferLine.VALIDATE(Quantity, InterfaceEntryLineVIP.Quantity);
                TransferLine.VALIDATE("Unit of Measure Code", InterfaceEntryLineVIP."Unit of Measure Code");
                TransferLine.INSERT(true);
            until InterfaceEntryLineVIP.NEXT() = 0;

        ReleaseTransferDocument.RUN(TransferHeader);
        //HEI.04<<

        SendEmail(InterfaceEntryHeaderVIP); //HEI.09
    end;

    procedure ProcessLSRTransferOrderDeletionInbound(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        InterfaceSetup: Record "Interface Setup INT";
        TransferHeader: Record "Transfer Header";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        ReleaseTransferDocument: Codeunit "Release Transfer Document";
        LSRText001: Label 'LSR Transfer Order %1 not found!';
    begin
        //HEI.04>>
        if not LSRInterfaceSetup.GET() or not LSRInterfaceSetup."Enable LSR Interface" then
            exit;
        LSRInterfaceSetup.TESTFIELD("Transfer Order Del. Interface");
        InterfaceSetup.GET(LSRInterfaceSetup."Transfer Order Del. Interface");
        if not InterfaceSetup.Enabled then
            exit;

        TransferHeader.SETRANGE("LSR Order No FND", InterfaceEntryHeaderVIP."Source No.");
        if not TransferHeader.FINDFIRST() then
            ERROR(LSRText001, InterfaceEntryHeaderVIP."Source No.")
        else
            repeat
                if TransferHeader.Status = TransferHeader.Status::Released then
                    ReleaseTransferDocument.Reopen(TransferHeader);
                TransferHeader.DELETE(true);
            until TransferHeader.NEXT() = 0;
        //HEI.04<<
    end;

    procedure ProcessLSRTransferShipmentOutbound(TransferShipmentHeader: Record "Transfer Shipment Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        InterfaceFrameworkMgtVIP: Codeunit "Interface Framework Mgt. VIP";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        EntryNo: Integer;
        TransferShipmentLine: Record "Transfer Shipment Line";
    begin
        //HEI.04>>
        if not LSRInterfaceSetup.GET() or not LSRInterfaceSetup."Enable LSR Interface" then
            exit;

        LSRInterfaceSetup.TESTFIELD("Transfer Shipment Out. Interf.");
        InterfaceSetup.GET(LSRInterfaceSetup."Transfer Shipment Out. Interf.");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgtVIP.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderVIP);
        CLEAR(InterfaceEntryLineVIP);

        InterfaceEntryHeaderVIP.INIT();
        InterfaceEntryHeaderVIP."Interface Code" := LSRInterfaceSetup."Transfer Shipment Out. Interf.";
        InterfaceEntryHeaderVIP.Direction := InterfaceEntryHeaderVIP.Direction::Outbound;
        InterfaceEntryHeaderVIP.INSERT(true);

        InterfaceEntryHeaderVIP."Source No." := TransferShipmentHeader."No.";
        InterfaceEntryHeaderVIP."Location Code" := TransferShipmentHeader."Transfer-from Code";
        InterfaceEntryHeaderVIP.Name := TransferShipmentHeader."Transfer-from Name";
        InterfaceEntryHeaderVIP."Payment Terms Code" := TransferShipmentHeader."Transfer-to Code";
        InterfaceEntryHeaderVIP.Description := TransferShipmentHeader."Transfer-to Name";
        InterfaceEntryHeaderVIP."Posting Date" := TransferShipmentHeader."Posting Date";
        InterfaceEntryHeaderVIP."Global No." := TransferShipmentHeader."Transfer Order No.";
        InterfaceEntryHeaderVIP."External Document No." := TransferShipmentHeader."LSR Order No FND";
        InterfaceEntryHeaderVIP.MODIFY(true);

        EntryNo := 1;
        TransferShipmentLine.SETRANGE("Document No.", TransferShipmentHeader."No.");
        if TransferShipmentLine.findset() then
            repeat
                InterfaceEntryLineVIP.INIT();
                InterfaceEntryLineVIP."Header Entry No." := InterfaceEntryHeaderVIP."Entry No.";
                InterfaceEntryLineVIP."Entry No." := EntryNo;
                InterfaceEntryLineVIP.INSERT(true);
                EntryNo += 1;

                InterfaceEntryLineVIP."Source Line No." := TransferShipmentLine."Line No.";
                InterfaceEntryLineVIP."No." := TransferShipmentLine."Item No.";
                InterfaceEntryLineVIP.Quantity := TransferShipmentLine.Quantity;
                InterfaceEntryLineVIP."Unit of Measure Code" := TransferShipmentLine."Unit of Measure Code";
                InterfaceEntryLineVIP.MODIFY(true);
            until TransferShipmentLine.NEXT() = 0;
        //HEI.04<<

        SendEmail(InterfaceEntryHeaderVIP); //HEI.09
    end;

    local procedure UpdateItemReclassification(TransferReceiptHeader: Record "Transfer Receipt Header"; InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        TransferReceiptLine: Record "Transfer Receipt Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemLedgerEntry2: Record "Item Ledger Entry";
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalLine2: Record "Item Journal Line";
        ItemReclassJnlLineCreated: Boolean;
    begin
        //HEI.06>>
        //Check if Transfer Receipt is posted
        ItemReclassJnlLineCreated := false;

        InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        if InterfaceEntryLineVIP.findset() then
            repeat
                TransferReceiptLine.RESET();
                TransferReceiptLine.SETRANGE("Transfer Order No.", TransferReceiptHeader."Transfer Order No.");
                TransferReceiptLine.SETRANGE("Line No.", InterfaceEntryLineVIP."Source Line No.");
                TransferReceiptLine.SETRANGE(Quantity, InterfaceEntryLineVIP.Quantity);
                if TransferReceiptLine.findset() then
                    repeat
                        //Check if Item Reclass is posted
                        ItemLedgerEntry.RESET();
                        ItemLedgerEntry.SETRANGE("Document Type", ItemLedgerEntry."Document Type"::" ");
                        ItemLedgerEntry.SETRANGE("Document No.", TransferReceiptLine."Document No.");
                        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                        ItemLedgerEntry.SETRANGE("Item No.", TransferReceiptLine."Item No.");
                        ItemLedgerEntry.SETRANGE("Location Code", InterfaceEntryHeaderVIP."Location Code");
                        ItemLedgerEntry.SETRANGE("Invoiced Quantity", TransferReceiptLine."Quantity (Base)");
                        ItemLedgerEntry.SETRANGE("Lot No.", LSRInterfaceSetup."Fixed Lot No.");
                        if not ItemLedgerEntry.FINDFIRST() then begin
                            //Check if Item Reclass is created
                            ItemJournalLine.SETRANGE("Journal Template Name", LSRInterfaceSetup."Item Reclass. Jnl. Template");
                            ItemJournalLine.SETRANGE("Journal Batch Name", LSRInterfaceSetup."Item Reclass. Jnl. Batch");
                            ItemJournalLine.SETRANGE("Document No.", TransferReceiptHeader."Transfer Order No.");
                            ItemJournalLine.SETRANGE("Item No.", TransferReceiptLine."Item No.");
                            ItemJournalLine.SETRANGE(Quantity, TransferReceiptLine."Quantity (Base)");
                            if ItemJournalLine.FINDFIRST() then begin
                                //Update Document No.
                                ItemJournalLine."Document No." := TransferReceiptLine."Document No.";
                                ItemJournalLine.MODIFY();
                                ItemReclassJnlLineCreated := true;
                            end else begin
                                //Create Item Reclass Journal Line
                                ItemLedgerEntry2.RESET();
                                ItemLedgerEntry2.SETRANGE("Document Type", ItemLedgerEntry2."Document Type"::"Transfer Receipt");
                                ItemLedgerEntry2.SETRANGE("Document No.", TransferReceiptLine."Document No.");
                                ItemLedgerEntry2.SETRANGE("Document Line No.", TransferReceiptLine."Line No.");
                                ItemLedgerEntry2.SETRANGE("Location Code", InterfaceEntryHeaderVIP."Location Code");
                                ItemLedgerEntry2.SETRANGE("Item No.", TransferReceiptLine."Item No.");
                                ItemLedgerEntry2.SETRANGE("Invoiced Quantity", TransferReceiptLine."Quantity (Base)");
                                ItemLedgerEntry2.SETFILTER("Lot No.", '<>%1&<>%2', LSRInterfaceSetup."Fixed Lot No.", '');
                                if ItemLedgerEntry2.findset() then
                                    repeat
                                        CreateItemReclassJournal(ItemLedgerEntry2);
                                        ItemReclassJnlLineCreated := true;
                                    until ItemLedgerEntry2.NEXT() = 0;
                            end;
                        end;
                    until TransferReceiptLine.NEXT() = 0;
            until InterfaceEntryLineVIP.NEXT() = 0;

        //Post Item Reclass Journal
        if ItemReclassJnlLineCreated then begin
            ItemJournalLine2.SETRANGE("Journal Template Name", LSRInterfaceSetup."Item Reclass. Jnl. Template");
            ItemJournalLine2.SETRANGE("Journal Batch Name", LSRInterfaceSetup."Item Reclass. Jnl. Batch");
            ItemJournalLine2.SETRANGE("Document No.", TransferReceiptHeader."No.");
            if ItemJournalLine2.FINDFIRST() then
                CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Batch", ItemJournalLine2);

            //Clear Journal
            ItemJournalLine2.RESET();
            CLEAR(ItemJournalLine2);
            ItemJournalLine2.SETRANGE("Journal Template Name", LSRInterfaceSetup."Item Reclass. Jnl. Template");
            ItemJournalLine2.SETRANGE("Journal Batch Name", LSRInterfaceSetup."Item Reclass. Jnl. Batch");
            ItemJournalLine2.SETRANGE("Document No.", TransferReceiptHeader."No.");
            ItemJournalLine2.SETRANGE("Item No.", '');
            if ItemJournalLine2.FINDFIRST() then
                ItemJournalLine2.DELETEALL();
        end;
        //HEI.06<<
    end;

    local procedure CreateItemReclassJournal(ItemLedgerEntry: Record "Item Ledger Entry");
    var
        SourceCodeSetup: Record "Source Code Setup";
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalLine2: Record "Item Journal Line";
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry2: Record "Reservation Entry";
        ItemTrackingCode: Record "Item Tracking Code";
        Item: Record Item;
        Bin: Record Bin;
    begin
        //HEI.06>>
        SourceCodeSetup.GET();
        Item.GET(ItemLedgerEntry."Item No.");
        ItemTrackingCode.GET(Item."Item Tracking Code");

        ItemJournalLine.INIT();
        ItemJournalLine.VALIDATE("Journal Template Name", LSRInterfaceSetup."Item Reclass. Jnl. Template");
        ItemJournalLine.VALIDATE("Journal Batch Name", LSRInterfaceSetup."Item Reclass. Jnl. Batch");

        ItemJournalLine2.SETRANGE("Journal Template Name", LSRInterfaceSetup."Item Reclass. Jnl. Template");
        ItemJournalLine2.SETRANGE("Journal Batch Name", LSRInterfaceSetup."Item Reclass. Jnl. Batch");
        if ItemJournalLine2.FINDLAST() then
            ItemJournalLine.VALIDATE("Line No.", ItemJournalLine2."Line No." + 10000)
        else
            ItemJournalLine.VALIDATE("Line No.", 10000);
        ItemJournalLine.INSERT(true);

        ItemJournalLine.VALIDATE("Source Code", SourceCodeSetup."Item Reclass. Journal");
        ItemJournalLine.VALIDATE("Entry Type", ItemJournalLine."Entry Type"::Transfer);

        ItemJournalLine.VALIDATE("Document No.", ItemLedgerEntry."Document No.");
        ItemJournalLine.VALIDATE("Posting Date", ItemLedgerEntry."Posting Date");
        ItemJournalLine.VALIDATE("Item No.", ItemLedgerEntry."Item No.");
        ItemJournalLine.VALIDATE(Quantity, ABS(ItemLedgerEntry.Quantity));
        ItemJournalLine.VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
        ItemJournalLine.VALIDATE("Location Code", ItemLedgerEntry."Location Code");
        ItemJournalLine.VALIDATE("New Location Code", ItemLedgerEntry."Location Code");
        Bin.SETRANGE("Location Code", ItemLedgerEntry."Location Code");
        Bin.FINDFIRST();
        ItemJournalLine.VALIDATE("Zone Code FND", Bin."Zone Code");
        ItemJournalLine.VALIDATE("New Zone Code FND", Bin."Zone Code");
        ItemJournalLine.VALIDATE("Bin Code", Bin.Code);
        ItemJournalLine.VALIDATE("New Bin Code", Bin.Code);
        ItemJournalLine.MODIFY();

        //Create Reservation Entry
        ReservationEntry.INIT();
        if ReservationEntry2.FINDLAST() then
            ReservationEntry.VALIDATE("Entry No.", ReservationEntry2."Entry No." + 1)
        else
            ReservationEntry.VALIDATE("Entry No.", 1);
        ReservationEntry.VALIDATE("Source Type", 83);
        ReservationEntry.VALIDATE("Source Subtype", ReservationEntry."Source Subtype"::"4");
        ReservationEntry.VALIDATE("Source ID", ItemJournalLine."Journal Template Name");
        ReservationEntry.VALIDATE("Source Batch Name", ItemJournalLine."Journal Batch Name");
        ReservationEntry.VALIDATE("Source Prod. Order Line", 0);
        ReservationEntry.VALIDATE("Source Ref. No.", ItemJournalLine."Line No.");
        ReservationEntry.VALIDATE("Location Code", ItemLedgerEntry."Location Code");
        // ReservationEntry.VALIDATE("Bin Code", Bin.Code);  // BC Upgrade NANDIS03 - Blocked as DIT field
        ReservationEntry.VALIDATE("Created By", USERID);
        ReservationEntry.VALIDATE("Creation Date", ItemLedgerEntry."Posting Date");
        ReservationEntry.VALIDATE("Item No.", ItemLedgerEntry."Item No.");
        ReservationEntry.VALIDATE("Reservation Status", ReservationEntry."Reservation Status"::Prospect);
        ReservationEntry.VALIDATE("Shipment Date", ItemLedgerEntry."Posting Date");
        ReservationEntry.VALIDATE(Quantity, -ABS(ItemLedgerEntry.Quantity));
        ReservationEntry."Quantity (Base)" := -ABS(ItemLedgerEntry.Quantity);
        ReservationEntry."Qty. to Handle (Base)" := -ABS(ItemLedgerEntry.Quantity);
        ReservationEntry."Qty. to Invoice (Base)" := -ABS(ItemLedgerEntry.Quantity);
        ReservationEntry."Qty. per Unit of Measure" := ItemLedgerEntry."Qty. per Unit of Measure";
        ReservationEntry.Positive := ReservationEntry.Quantity > 0;
        ReservationEntry.VALIDATE("Item Tracking", ReservationEntry."Item Tracking"::"Lot No.");
        ReservationEntry.VALIDATE("Lot No.", ItemLedgerEntry."Lot No.");
        ReservationEntry.VALIDATE("New Lot No.", LSRInterfaceSetup."Fixed Lot No.");
        if ItemTrackingCode."Man. Expir. Date Entry Reqd." then
            ReservationEntry.VALIDATE("New Expiration Date", 99991231D);
        ReservationEntry.INSERT();
        //HEI.06<<
    end;

    local procedure CheckExistsBinContent(LocationCode: Code[20]; BinCode: Code[20]; ItemNo: Code[20]): Boolean;
    var
        BinContent: Record "Bin Content";
    begin
        //HEI.08>>
        BinContent.SETRANGE("Location Code", LocationCode);
        BinContent.SETRANGE("Bin Code", BinCode);
        BinContent.SETRANGE("Item No.", ItemNo);
        exit(not BinContent.ISEMPTY);
        //HEI.08<<
    end;

    local procedure CheckAndCreateBinContent(TransferHeader: Record "Transfer Header"; CallFrom: Option TransferHeader,ItemJnlLine; InterfVIPLocationCode: Code[20]; InterfVIPBinCode: Code[20]; InterfVIPItemNo: Code[20]);
    var
        TransferLine: Record "Transfer Line";
        BinContent: Record "Bin Content";
    begin
        //HEI.08>>
        case CallFrom of
            CallFrom::TransferHeader:
                begin
                    TransferLine.SETRANGE("Document No.", TransferHeader."No.");
                    TransferLine.SETRANGE("Derived From Line No.", 0);
                    if TransferLine.findset(false) then
                        repeat
                            if (TransferLine."Transfer-To Bin Code" <> '') and
                              (not CheckExistsBinContent(TransferLine."Transfer-to Code", TransferLine."Transfer-To Bin Code", TransferLine."Item No."))
                            then begin
                                InsertBinContent(TransferLine."Transfer-to Code", TransferLine."Transfer-To Bin Code", TransferLine."Item No.");
                            end;
                        until TransferLine.NEXT() = 0;
                end;
            CallFrom::ItemJnlLine:
                begin
                    if (InterfVIPBinCode <> '') and (not CheckExistsBinContent(InterfVIPLocationCode, InterfVIPBinCode, InterfVIPItemNo)) then
                        InsertBinContent(InterfVIPLocationCode, InterfVIPBinCode, InterfVIPItemNo);
                end;
        end;
        //HEI.08<<
    end;

    local procedure InsertBinContent(LocationCode: Code[20]; BinCode: Code[20]; ItemNo: Code[20]);
    var
        BinContent: Record "Bin Content";
    begin
        //HEI.08>>
        BinContent.INIT();
        BinContent."Location Code" := LocationCode;
        BinContent."Bin Code" := BinCode;
        BinContent.SetUpNewLine();
        BinContent.Fixed := true;
        BinContent.Default := true;
        BinContent.VALIDATE("Item No.", ItemNo);
        if BinContent.INSERT(true) then;
        //HEI.08<<
    end;

    local procedure SendEmail(Rec: Record "Interface Entry Header VIP INT");
    var
        LSRInterfaceSetup: Record "LSR Interface Setup INT";
        SendEmailConfirmation: Codeunit InterfaceEmailFunctionalityINT;
        SendEmailWhen: Option LSRTransferOrderIn,LSRTransferShipmentOut;
    //SendEmailConfirmation: Codeunit "Send Email Confirmation CBN";

    begin
        //HEI.40>>
        LSRInterfaceSetup.GET();
        if (((LSRInterfaceSetup."Enable Email LSR-TO") and (LSRInterfaceSetup."Transfer Order Interface" = Rec."Interface Code"))
          or
          ((LSRInterfaceSetup."Enable Email LSR-TS-OUT") and (LSRInterfaceSetup."Transfer Shipment Out. Interf." = Rec."Interface Code")))
        then
            case Rec."Interface Code" of
                LSRInterfaceSetup."Transfer Order Interface":
                    SendEmailConfirmation.LSRSendEmail(SendEmailWhen::LSRTransferOrderIn, Rec."Payment Terms Code", Rec."Source No.");
                LSRInterfaceSetup."Transfer Shipment Out. Interf.":
                    SendEmailConfirmation.LSRSendEmail(SendEmailWhen::LSRTransferShipmentOut, Rec."Payment Terms Code", Rec."External Document No.");
            end;
        //HEI.40<<
    end;

    local procedure GetLSRInterfaceSetup();
    begin
        if not LSRInterfaceSetupRead then
            if LSRInterfaceSetup.GET() then;

        LSRInterfaceSetupRead := true;
    end;

    procedure OpenItemReclassJournal(var WarehouseReceiptHeader: Record "Warehouse Receipt Header");
    var
        ItemJournalLine: Record "Item Journal Line";
    begin
        //HEI.10>>
        GetLSRInterfaceSetup();

        ItemJournalLine.SETRANGE("Journal Template Name", LSRInterfaceSetup."Item Reclass. Jnl. Template");
        ItemJournalLine.SETRANGE("Journal Batch Name", LSRInterfaceSetup."Item Reclass. Jnl. Batch");
        ItemJournalLine.SETRANGE("Document No.", WarehouseReceiptHeader."Source No. FND");

        ItemJournalLine.SETFILTER("Posting Date", '<>%1', WORKDATE());
        if ItemJournalLine.findset() then
            repeat
                //add modify date
                ItemJournalLine.VALIDATE("Posting Date", WORKDATE());
                ItemJournalLine.MODIFY();
            until ItemJournalLine.NEXT() = 0;

        PAGE.RUN(PAGE::"Item Reclass. Journal", ItemJournalLine);
        //HEI.10<<
    end;

    procedure TryCreateItemReclassJournalFromWhseReceipt();
    var
        ItemReclassErr: Label 'Item Reclassification Entries are not created successfully, please process them manually!';
    begin
        //HEI.10>>
        GetLSRInterfaceSetup();
        if not LSRInterfaceSetup."Enable LSR Interface" then
            exit;

        if WhseReceiptHeader."Source Document Type FND" <> WhseReceiptHeader."Source Document Type FND"::"Inbound Transfer" then
            exit;

        if WhseReceiptHeader."Source No. FND" = '' then
            exit;

        CreateItemReclassJournalFromWhseReceipt(WhseReceiptHeader);
        //HEI.10<<
    end;

    procedure CreateItemReclassJournalFromWhseReceipt(var WarehouseReceiptHeader: Record "Warehouse Receipt Header");
    var
        TransferHeader: Record "Transfer Header";
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalLine2: Record "Item Journal Line";
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry2: Record "Reservation Entry";
        ReservationEntry3: Record "Reservation Entry";
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        Bin: Record Bin;
        SourceCodeSetup: Record "Source Code Setup";
        Location: Record Location;
        TransferReceiptHeader: Record "Transfer Receipt Header";
        TransferReceiptNo: Code[20];
        ReservedQty: Decimal;
        TotalQty: Decimal;
        ReclassQty: Decimal;
        CallFrom: Option TransferHeader,ItemJnlLine;
    begin
        //HEI.10>>
        if WarehouseReceiptHeader."Source Document Type FND" <> WarehouseReceiptHeader."Source Document Type FND"::"Inbound Transfer" then
            exit;

        GetLSRInterfaceSetup();
        if not LSRInterfaceSetup."Enable LSR Interface" then
            exit;

        if not TransferHeader.GET(WarehouseReceiptHeader."Source No. FND") then
            exit;

        Location.GET(TransferHeader."Transfer-to Code");

        if not Location."Store FND" then
            exit;
        ItemJournalLine.SETRANGE("Journal Template Name", LSRInterfaceSetup."Item Reclass. Jnl. Template");
        ItemJournalLine.SETRANGE("Journal Batch Name", LSRInterfaceSetup."Item Reclass. Jnl. Batch");
        ItemJournalLine.SETRANGE("Document No.", WarehouseReceiptHeader."Source No. FND");
        if ItemJournalLine.findset(true) then begin
            repeat
                //add modify date
                ItemJournalLine.VALIDATE("Posting Date", WORKDATE());
                ItemJournalLine.MODIFY();
            until ItemJournalLine.NEXT() = 0;
            //Entries already created by interface
        end else begin

            Bin.SETRANGE("Location Code", WarehouseReceiptHeader."Location Code");
            if not Bin.FINDFIRST() then
                exit;
            WarehouseReceiptLine.RESET();
            WarehouseReceiptLine.SETRANGE("No.", WarehouseReceiptHeader."No.");
            WarehouseReceiptLine.SETFILTER("Qty. to Receive", '<>%1', 0);
            if WarehouseReceiptLine.findset(false) then
                repeat
                    Item.GET(WarehouseReceiptLine."Item No.");
                    if ItemTrackingCode.GET(Item."Item Tracking Code") and ItemTrackingCode."Lot Specific Tracking" and
                      IsItemTrackingCodeIncluded(ItemTrackingCode.Code) then begin
                        //Check Reservation Entries
                        ReservedQty := 0;
                        if ItemUnitofMeasure.GET(WarehouseReceiptLine."Item No.", WarehouseReceiptLine."Unit of Measure Code") then
                            TotalQty := WarehouseReceiptLine."Qty. to Receive" * ItemUnitofMeasure."Qty. per Unit of Measure"
                        else
                            TotalQty := WarehouseReceiptLine."Qty. to Receive";

                        ReservationEntry.RESET();
                        ReservationEntry.SETRANGE("Source Type", 5741);
                        ReservationEntry.SETRANGE("Source Subtype", ReservationEntry."Source Subtype"::"1");
                        ReservationEntry.SETRANGE("Source ID", WarehouseReceiptLine."Source No.");
                        ReservationEntry.SETRANGE("Location Code", WarehouseReceiptLine."Location Code");
                        ReservationEntry.SETRANGE("Source Prod. Order Line", WarehouseReceiptLine."Source Line No.");
                        ReservationEntry.SETFILTER("Lot No.", '<>%1', LSRInterfaceSetup."Fixed Lot No.");
                        if ReservationEntry.findset(false) then
                            repeat
                                ReclassQty := 0;
                                if ReservationEntry."Quantity (Base)" <= TotalQty - ReservedQty then
                                    ReclassQty := ReservationEntry."Quantity (Base)"
                                else
                                    ReclassQty := TotalQty - ReservedQty;

                                ReservedQty += ReclassQty;


                                if ReclassQty > 0 then begin
                                    CheckAndCreateBinContent(TransferHeader, CallFrom::TransferHeader, WarehouseReceiptLine."Location Code", Bin.Code, WarehouseReceiptLine."Item No.");

                                    ItemJournalLine.INIT();
                                    ItemJournalLine.VALIDATE("Journal Template Name", LSRInterfaceSetup."Item Reclass. Jnl. Template");
                                    ItemJournalLine.VALIDATE("Journal Batch Name", LSRInterfaceSetup."Item Reclass. Jnl. Batch");

                                    ItemJournalLine2.SETRANGE("Journal Template Name", LSRInterfaceSetup."Item Reclass. Jnl. Template");
                                    ItemJournalLine2.SETRANGE("Journal Batch Name", LSRInterfaceSetup."Item Reclass. Jnl. Batch");
                                    if ItemJournalLine2.FINDLAST() then
                                        ItemJournalLine.VALIDATE("Line No.", ItemJournalLine2."Line No." + 10000)
                                    else
                                        ItemJournalLine.VALIDATE("Line No.", 10000);

                                    ItemJournalLine.INSERT(true);

                                    SourceCodeSetup.GET();
                                    ItemJournalLine.VALIDATE("Source Code", SourceCodeSetup."Item Reclass. Journal");
                                    ItemJournalLine.VALIDATE("Entry Type", ItemJournalLine."Entry Type"::Transfer);
                                    ItemJournalLine.VALIDATE("Document No.", TransferHeader."No.");
                                    ItemJournalLine.VALIDATE("Posting Date", WORKDATE());
                                    ItemJournalLine.VALIDATE("Item No.", WarehouseReceiptLine."Item No.");


                                    ItemJournalLine.VALIDATE(Quantity, ReclassQty);

                                    ItemJournalLine.VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
                                    ItemJournalLine.VALIDATE("Location Code", WarehouseReceiptLine."Location Code");
                                    ItemJournalLine.VALIDATE("New Location Code", WarehouseReceiptLine."Location Code");
                                    ItemJournalLine.VALIDATE("Zone Code FND", Bin."Zone Code");
                                    ItemJournalLine.VALIDATE("New Zone Code FND", Bin."Zone Code");
                                    ItemJournalLine.VALIDATE("Bin Code", Bin.Code);
                                    ItemJournalLine.VALIDATE("New Bin Code", Bin.Code);
                                    ItemJournalLine.MODIFY();

                                    //Create Item Tracking
                                    ReservationEntry3.INIT();
                                    ReservationEntry3.COPY(ReservationEntry);
                                    if ReservationEntry2.FINDLAST() then
                                        ReservationEntry3.VALIDATE("Entry No.", ReservationEntry2."Entry No." + 1)
                                    else
                                        ReservationEntry3.VALIDATE("Entry No.", 1);
                                    ReservationEntry3.VALIDATE("Source Type", 83);
                                    ReservationEntry3.VALIDATE("Source Subtype", ReservationEntry3."Source Subtype"::"4");
                                    ReservationEntry3.VALIDATE("Source ID", ItemJournalLine."Journal Template Name");
                                    ReservationEntry3.VALIDATE("Source Batch Name", ItemJournalLine."Journal Batch Name");
                                    ReservationEntry3.VALIDATE("Source Prod. Order Line", 0);
                                    ReservationEntry3.VALIDATE("Source Ref. No.", ItemJournalLine."Line No.");

                                    ReservationEntry3.VALIDATE("Reservation Status", ReservationEntry3."Reservation Status"::Prospect);
                                    ReservationEntry3.VALIDATE("Shipment Date", ReservationEntry."Expected Receipt Date");
                                    ReservationEntry3."Expected Receipt Date" := 0D;
                                    ReservationEntry3.Positive := ReservationEntry3.Quantity > 0;
                                    ReservationEntry3.VALIDATE(Quantity, -ReclassQty);
                                    ReservationEntry3."Quantity (Base)" := ReservationEntry3.Quantity;
                                    ReservationEntry3."Qty. to Handle (Base)" := ReservationEntry3."Quantity (Base)";
                                    ReservationEntry3."Qty. to Invoice (Base)" := ReservationEntry3."Quantity (Base)";

                                    ReservationEntry3.VALIDATE("New Lot No.", LSRInterfaceSetup."Fixed Lot No.");
                                    if ItemTrackingCode."Man. Expir. Date Entry Reqd." then
                                        ReservationEntry3.VALIDATE("New Expiration Date", 99991231D);

                                    ReservationEntry3.INSERT();
                                end;
                            until ReservationEntry.NEXT() = 0;
                    end;
                until WarehouseReceiptLine.NEXT() = 0;
        end;
        //HEI.10<<
    end;

    procedure PostItemReclessJournal(var WarehouseReceiptHeader: Record "Warehouse Receipt Header");
    var
        TransferReceiptHeader: Record "Transfer Receipt Header";
        ItemJournalLine2: Record "Item Journal Line";
        Location: Record Location;
        TransferReceiptNo: Code[20];
    begin
        //HEI.10>>
        if WarehouseReceiptHeader."Source Document Type FND" <> WarehouseReceiptHeader."Source Document Type FND"::"Inbound Transfer" then
            exit;

        GetLSRInterfaceSetup();
        if not LSRInterfaceSetup."Enable LSR Interface" then
            exit;

        ItemJournalLine2.RESET();
        CLEAR(ItemJournalLine2);
        ItemJournalLine2.SETRANGE("Journal Template Name", LSRInterfaceSetup."Item Reclass. Jnl. Template");
        ItemJournalLine2.SETRANGE("Journal Batch Name", LSRInterfaceSetup."Item Reclass. Jnl. Batch");
        ItemJournalLine2.SETRANGE("Document No.", WarehouseReceiptHeader."Source No. FND");
        if ItemJournalLine2.ISEMPTY then
            exit;

        //Update Document No. in Item Reclass Journal
        TransferReceiptNo := '';
        TransferReceiptHeader.SETRANGE("Transfer Order No.", WarehouseReceiptHeader."Source No. FND");
        if TransferReceiptHeader.FINDLAST() then
            TransferReceiptNo := TransferReceiptHeader."No.";

        Location.GET(TransferReceiptHeader."Transfer-to Code");
        if not Location."Store FND" then
            exit;

        if ItemJournalLine2.findset(true) then
            repeat
                ItemJournalLine2."Document No." := TransferReceiptNo;
                ItemJournalLine2.MODIFY();
            until ItemJournalLine2.NEXT() = 0;

        //Post the Item Reclassification Journal
        ItemJournalLine2.RESET();
        CLEAR(ItemJournalLine2);
        ItemJournalLine2.SETRANGE("Journal Template Name", LSRInterfaceSetup."Item Reclass. Jnl. Template");
        ItemJournalLine2.SETRANGE("Journal Batch Name", LSRInterfaceSetup."Item Reclass. Jnl. Batch");
        ItemJournalLine2.SETRANGE("Document No.", TransferReceiptNo);
        ItemJournalLine2.SETFILTER("Item No.", '<>%1', '');
        if ItemJournalLine2.FINDFIRST() then begin
            COMMIT();

            if not CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Batch", ItemJournalLine2) then
                MESSAGE(ItemReclassErr);
        end;
        //HEI.10<<
    end;

    local procedure IsItemTrackingCodeIncluded(ItemTrackingCode: Code[20]): Boolean;
    var
        ItemTracking: Record "Item Tracking Code";
    begin
        //HEI.10>>
        GetLSRInterfaceSetup();

        ItemTracking.SETFILTER(Code, LSRInterfaceSetup."Item Reclass. Tracking Code");
        if ItemTracking.findset() then
            repeat
                if ItemTracking.Code = ItemTrackingCode then
                    exit(true);
            until ItemTracking.NEXT() = 0;

        exit(false);
        //HEI.10<<
    end;

    procedure SetWarehouseReceiptHeader(var WhseRcptHeader: Record "Warehouse Receipt Header");
    begin
        //HEI.10>>
        WhseReceiptHeader := WhseRcptHeader;
    end;
}

