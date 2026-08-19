codeunit 58008 "Interface Framework Mgt. VIP"
{
    // Heilite Navision Old Id - 50086

    // version HEI.43,HEI.44

    // HEI.01 HT1010 IBM NASTAA02 28.11.2019 # Maraki dedicated Job Queue - CHG2039961
    //   # New Codeunit created
    // HEI.02 FDD-HT604 IBM.COSTES02 09.12.2019 # WMS integration Heilite BASE and Reflex
    // 
    // HEI.03 FDD-HT604 IBM GAVANM01 09.12.2019 # WMS integration Heilite BASE and Reflex
    // HEI.04 CHG2043663 FDD-HT604 IBM.COSTES02 16.12.2019 # WMS integration Heilite BASE and Reflex
    // HEI.05 CHG2043663 FDD-HT604 IBM GAVANM01 16.01.2020 # WMS integration - Transfer Shipment interface
    // HEI.06 CHG2072524 FDD-HT604 IBM GAVANM01 18.01.2020 # WMS integration - Transfer Receipt interface
    // HEI.08 CHG2068423 IBM KUMARN15 01.07.2020
    // # Code added in functions ProcessSingleInboundEntry, created function GetEBMInterfaceSetup
    // HEI.09 CHG2069321 GAVANM01 IBM 13.10.2020 #PowerApps Integration
    //   # code added
    // HEI.10 FDD-HB1268 - CHG2068666 IBM NASTAA02 26.10.2020 # DMS Integration Ivory Coast
    //   # Code added
    //   # New Subscribers created
    // HEI.11 FDD-HB899 - CHG2044703 IBM GAVANM01 13.12.2020 # New POS System Required for OPCO
    //   # New Subscribers created
    // HEI.12 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # code added
    // HEI.13 CHG2095187 IBM SAXENA03 08.02.2021
    //   # Code written for optimizaiton
    //   # Added RESET, SetCurrentKey and AutoCalcfield function in LogInterfaceEntries().
    //   # Added RESET & SetCurrentKey function in GetOutboundInterface()
    // HEI.14 FDD-HB1234 - CHG2053453 IBM NASTAA02 15.02.2021 # B2B Order Status
    //   # New Subscribers created for B2B Interfaces
    // HEI.15 FDD-HB899 - CHG2093869 IBM NASTAA02 23.02.2021 # LSR - Transfer and Stock
    //   # New Functions created for LSR Transfers
    // HEI.16 CHG2093869 GAVANM01 05.03.2021 #Transfer and Stock adjustments interfaces Bahamas LS Retail
    //   # New Subscribers created: LSROnBeforeReopenTransferOrder, LSRT5740OnBeforeValidateTransferFromCode, LSRT5740OnBeforeValidateTransferToCode, LSROnAfterTransferOrderPostShipment
    //   # code added
    // HEI.17 INC3545614 - CHG2115232 IBM NASTAA02 18.06.2021 # HeiLite Order status is not sent correctly to B2B
    //   # Extra condition added to "OnBeforeDeleteAPISalesOrder"
    // HEI.18 CHG2094470 HB1870 IBM.GUNERE01 13.07.2021 # ProcessSingleInboundEntry func. modified
    // HEI.19 CHG2115040 HB2342 IBM GAVANM01 16.08.2021 #SEM Customer Integration
    //   # New Subscribers created
    // HEI.20 CHG2132531 INC3788002 IBM GAVANM01 22.10.2021 #B2B flag issue
    //   # code changes
    //   # New Subscriber created: SEMOnAfterDeleteB2BCustIncluded
    // HEI.21 FDD-HB2155 CHG2128694 IBM NANDIS01 11.11.2021 WMS PO
    //   # New functions - WMSCreatePORequest,CheckIfPurchaseLineExists created for WMS process
    // HEI.22 CHG2129985 IBM.LS      21.02.2022
    //   # Added Code to call function
    // HEI.23 HB2615 - CHG2139668 IBM NASTAA02 13.01.2022 # New Order Status in the existing Order Status API
    //   # New Subscribers created
    // HEI.24 HB2156CHG2107450 IBM GAVANM01 27.01.2022 # WMS Phase 2 - Transportation cost
    //   # code changes
    // HEI.25 HB2155 CHG2128694 IBM GAVANM01 02.02.2022 WMS - SRO Warehouse Receipt creation
    //   # new code added to process the warehouse receipt for sales return order
    // HEI.26 HB2156 CHG2107450 IBM GAVANM01 16.02.2022 # WMS Phase 2 - Transportation cost
    //   # new code added to process the Transfer warehouse shipment
    // HEI.27 CHG2107450 HB2156 IBM BHANDS01 23.03.2022 # WMS Phase 2 - Transportation cost
    //   # new condition added for handling old logic and new logic together
    // HEI.28 CHG2147859 SAHAL01 21.03.2023 Material Master data interface HeiLite - WMS Astro
    //   # Added Code to call function for Astro
    //   # Created New Function - PostProcessUpdate_Astro
    // HEI.29 CHG2154370 SAHAL01 05.09.2022
    //   # Added Code to call InboundCloseProductionOrder function for Astro
    // HEI.30 CHG2149734 SAHAL01 10.03.2023 Astro - I/F Production - ProductionOrderSync
    //   # Added Code in Function - PostProcessUpdate_Astro
    //   # Added Code in Function - SetInterfaceProcessed
    // HEI.31 CHG2172693 IBM SAMANR01 09.09.2022
    //   # Code adjusts for run all category of job queue with super user
    // HEI.32 CHG2154367 SAHAL01 21.03.2023 Astro - I/F Production - ProductionOrderReceive
    //   # Added Code to call InboundOutputProductionOrder function for Astro
    //   # Added Code in Function - PostProcessUpdate_Astro
    // HEI.33 CHG2154382 SAHAL01 23.09.2022
    //   # Added Code to call InboundInventoryBalanceList function for Astro
    // HEI.34 CHG2154364 SAHAL01 15.03.2023 Astro - I/F Production - ProductionOrderOperationLinePick
    //   # Added Code to call InboundProductionOrderLinePick function for Astro
    //   # Added Code in Function - PostProcessUpdate_Astro
    // HEI.35 CHG2154372 SAHAL01 15.12.2022 Astro - I/F Inventory Management - BalanceChange
    //   # Added Code to call InboundInventoryBalanceChange function for Astro
    //   # Added Code in Function - PostProcessesUpdate_Astro
    // HEI.36 CHG21f1260 HB2788 BHANDS01 30.12.2022 # Burundi Fiscal Invoice
    //   # Created New Function - GetEBMSInterfaceSetup
    // HEI.37 CHG2174146 SAHAL01 09.03.2023 Assembly Order Outbound and Inbound interfaces HeiLite -- Astro WMS
    //   # Added Code in Function - PostProcessesUpdate_Astro
    //   # Added Code to call InboundAssemblyOrderLinePick function for Astro
    //   # Added Code to call InboundAssemblyOrderOutput function for Astro
    // HEI.39 CHG2174235 COSTES04 11.07.2023 Prices and Taxes
    //   # Skip sending order status for Sales Quote
    // HEI.38 CHG2198781 SAHAL01 10.04.2023 Astro Account Zone Mapping
    //   # Added Code in Function - PostProcessUpdate_Astro
    // HEI.40 CHG2194603 HB3289 COSTES04 19.10.2023 Electronic invoice interface
    //   # Add PAC Electronic Invoice Response
    // HEI.41 CHG2210794 SAHAL01 15.10.2024 Zycus - BASE HL Integration Master Dimension, PO and GR Transaction
    //   # Added Code to call InboundProcessPurchaseOrder function for Zycus
    //   # Added Code to call InboundProcessGoodsReceiptOfPurchaseOrder function for Zycus
    //   # Added Code to call InboundProcessGoodsReceiptCancellationOfPurchaseOrder function for Zycus
    //   # Added Code to call InboundProcessGoodsReceiptOfLimitPurchaseOrder function for Zycus
    //   # Added Code to call InboundProcessGoodsReceiptCancellationOfLimitPurchaseOrder function for Zycus
    //   # Created New Function - PostProcessUpdate_Zycus
    // HEI.42 CHG2210794 VERMAA03 14.06.2024 Zycus - BASE integration with POSM GR
    //   # Added Code to call InboundPOSMGRConfirmation_Zycus function for Zycus
    // HEI.43 CHG2249376 COSTES04 30.09.2024 CNET Integration for Sales Order Management
    //   # Add CNET Interface
    // HEI.44 CHG2275722 HB3977 IBM BHANDS01 27.02.2025 Panama-Integration to be built between POP
    //   # Added Code for New Inbound Interface POP for DLOCAL Payouts

    //BC Upgrade VAMSIU01 - Added New Procedure for Getoutboundinterface() for Saas Compatible and blocked old procedure.

    // BC Upgrade PATELP08>>
    // Changed name of table from "B2B Customer Included/Excluded" to "B2B Cust Inc/Exc FND"
    // BC Upgrade PATELP08<<

    trigger OnRun();
    begin
    end;

    var
        NotFoundErr: Label 'Cannot find a value for field %1 of table %2 in table %3.', Comment = '%1 - field caption, %2 - table caption, %3 - table caption';
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        //SRMInterfaceManagement : Codeunit "SRM Interface Management";  // BC Upgrade NANDIS03 - No use
        // MaximoInterfaceManagement: Codeunit "Maximo Interface Management";  // BC Upgrade NANDIS03 - No use
        GeneralInterfaceSetupRead: Boolean;
        // PeparriInterfaceManagement: Codeunit "Peparri Interface Management";  // BC Upgrade NANDIS03 - No use
        SimulateMode: Boolean;
        SimulateModeErr: Label 'Simulate Mode';
        InterfaceNotSetUpErr: Label 'Interface %1 is not set up.';
        CashVanSalesInterfaceSetupRead: Boolean;
        CashVanSalesInterfaceSetup: Record "Cash Van Sales Interf. Stp INT";
        // CashVanSalesInterfaceManag: Codeunit "Cash Van Sales Interface Manag";  // BC Upgrade NANDIS03 - No use
        FuturMasterInterfaceSetup: Record "FuturMaster Interf. Setup INT";
        FuturMasterInterfaceSetupRead: Boolean;
        // FMInterfaceManagement: Codeunit "FM Interface Management";  // BC Upgrade NANDIS03 - No use
        EskerInterfaceSetup: Record "Esker Interface Setup INT";
        // EskerInterfaceManag: Codeunit "ESKER Interface Manag";  // BC Upgrade NANDIS03 - No use
        EskerlInterfaceSetupRead: Boolean;
        // EBMInterfaceSetup: Record "EBM Interface Setup INT";  // BC Upgrade NANDIS03 - No need for BC
        // EBMInterfaceManagement: Codeunit "EBM Interface Management";  // BC Upgrade NANDIS03 - No need for BC
        // EBMInterfaceSetupRead: Boolean;  // BC Upgrade NANDIS03 - No need for BC
        CounterpointInterfaceSetupRead: Boolean;
        CounterpointInterfaceSetup: Record "Counterpoint Interf. Stp INT";
        // CounterpointInterfaceMgmt: Codeunit "Counterpoint Interface Mgmt.";  // BC Upgrade NANDIS03 - No use
        FM2InterfaceSetupRead: Boolean;
        FM2InterfaceSetup: Record "FuturMaster Interf Setup_2 INT";
        OrtecInterfaceSetupRead: Boolean;
        OrtecInterfaceSetup: Record "Ortec & KStore Interf. Stp INT";
        // OrtecInterfaceManagement: Codeunit "Ortec & KStore Interface Mgmt.";  // BC Upgrade NANDIS03 - No use
        MarakiInterfaceSetupRead: Boolean;
        MarakiInterfaceSetup: Record "Maraki Interface Setup INT";
        MarakiInterfaceManagement: Codeunit "Maraki Interface Management";
        BankConnectivityInterfaceSetupRead: Boolean;
        BankConnInterfaceSetup: Record "Bank Conn. Interface Setup INT";
        // BankConnectivityInterfaceManagement: Codeunit "BC Interface Management";  // BC Upgrade NANDIS03 - No use
        EDIInterfaceSetupRead: Boolean;
        EDIInterfaceSetup: Record "EDI Interface Setup INT";
        // EDIInterfaceManagement: Codeunit "EDI Interface Mgmt.";  // BC Upgrade NANDIS03 - No use
        WMSInterfaceSetupRead: Boolean;
        WMSInterfaceSetup: Record "WMS Interface Setup INT";
        WMSInterfaceManagement: Codeunit "WMS Interface Management";
        PowerAppsInterfaceSetup: Record "PowerApps Interface Setup INT";
        PowerAppsInterfaceSetupRead: Boolean;
        PowerAppsInterfaceManagement: Codeunit "PowerApps Interface Mgmt.";
        APIInterfaceSetupRead: Boolean;
        APIInterfaceSetup: Record "API Interface Setup2 INT";
        DMSInterfaceMgmt: Codeunit "DMS Interface Mgmt.";
        DMSInterfaceSetup: Record "DMS Interface Setup INT";
        // APIPaymentInterfaceMgmt: Codeunit "API Payment Interface Mgmt.";  // BC Upgrade NANDIS03 - No use
        LSRInterfaceMgmt: Codeunit "LSR Interface Mgmt.";
        LSRInterfaceSetup: Record "LSR Interface Setup INT";
        LSRInterfaceSetupRead: Boolean;
        B2BOrderDeletionConfirm: Label 'You are about to delete B2B Order No. %1. Do you want to proceed?';
        APIOrderStatusNotifMgmt: Codeunit "API Order Status Notif Mgmt.";
        EBMSInterfaceSetup: Record "EBMS Interface Setup INT";
        EBMSInterfaceSetupRead: Boolean;
        EBMSInterfaceManagement: Codeunit "EBMS Interface Management";
        AstroInterfaceSetupRead: Boolean;
        // AstroInterfaceSetup: Record "Astro Interface Setup";  // BC Upgrade NANDIS03 - Astro will not be part of BC
        // PACElectronicInvoicingSetup: Record "PAC Electronic Invoicing Setup";  // BC Upgrade NANDIS03 - PAC will not be part of BC
        // PACElectronicInvoicingSetupRead: Boolean;  // BC Upgrade NANDIS03 - PAC will not be part of BC
        // PACElectronicInvoiceMgt: Codeunit "PAC Electronic Invoice Mgt.";  // BC Upgrade NANDIS03 - Blocked as PAC is not in scope
        ZycusInterfaceSetup: Record "Zycus Interface Setup INT";
        ZycusInterfaceSetupRead: Boolean;
    // CNETInterfaceSetup: Record "CNET Interface Setup";  // BC Upgrade NANDIS03 - No use
    // CNETInterfaceSetupRead: Boolean;  // BC Upgrade NANDIS03 - No use
    // POPInterfaceSetup: Record "POP Interface Setup";  // BC Upgrade NANDIS03 - No use
    // POPInterfaceSetupRead: Boolean;  // BC Upgrade NANDIS03 - No use

    procedure ProcessSingleInboundEntry(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT") ReturnValue: Text;
    var
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        // AstroInterfaceManagementL: Codeunit "Astro Interface Management";  // BC Upgrade NANDIS03 - Astro will not be part of BC
        ZycusInterfaceManagementL: Codeunit "Zycus Interface Management";
    // CNETInterfaceMgt: Codeunit "CNET Interface Mgt.";  // BC Upgrade NANDIS03 - No use  
    // POPInterfaceMgt: Codeunit "POP Interface Mgt.";  // BC Upgrade NANDIS03 - No use  >>
    begin
        GetGeneralInterfaceSetup();
        GetMarakiInterfaceSetup();
        // GetEBMInterfaceSetup; //HEI.08  // BC Upgrade NANDIS03 - EBM will not be part of BC
        GetWMSSetup(); //HEI.02
        GetPowerAppsSetup();  //HEI.09
        GetAPIInterfaceSetup(); //HEI.10
        GetLSRSetup(); //HEI.12
        GetEBMSInterfaceSetup(); //HEI.36
        //HEI.28>>
        // GetAstroInterfaceSetup;  // BC Upgrade NANDIS03 - Astro will not be part of BC
        //HEI.28<<
        // GetPACElectronicInvoiceSetup;//HEI.40  // BC Upgrade NANDIS03 - PAC will not be part of BC
        //HEI.41>>
        GetZycusInterfaceSetup_Zycus();
        //HEI.41<<
        // GetCNETInterfaceSetup;//HEI.43  // BC Upgrade NANDIS03 - No use
        // GetPOPInterfaceSetup; //HEI.44  // BC Upgrade NANDIS03 - No use

        case InterfaceEntryHeaderVIP."Interface Code" of
            /*EBMInterfaceSetup."Status Update Interface":
              EBMInterfaceManagement.ProcessStatusUpdate(InterfaceEntryHeader);
            EBMInterfaceSetup."Sales Confirmation Response":
              EBMInterfaceManagement.ProcessSalesConfirmationResponse(InterfaceEntryHeader);*/

            MarakiInterfaceSetup."Sales Confirmation Response":
                MarakiInterfaceManagement.ProcessSalesConfirmationResponse(InterfaceEntryHeaderVIP);
            MarakiInterfaceSetup."Status Update Interface":
                MarakiInterfaceManagement.ProcessStatusUpdate(InterfaceEntryHeaderVIP);
            //>>HEI.02
            WMSInterfaceSetup."Warehouse Shipment Interface":
                //WMSInterfaceManagement.ProcessWhsShpmntRequest(InterfaceEntryHeaderVIP);  //commented by HEI.05
                //<<HEI.02
                //>>HEI.05>
                begin
                    case InterfaceEntryHeaderVIP."External Document No." of
                        '010':
                            //HEI.27>>
                            begin

                                if not WMSInterfaceSetup."Enable New WMS TC" then
                                    WMSInterfaceManagement.ProcessWhsShpmntRequest(InterfaceEntryHeaderVIP)
                                else
                                    WMSInterfaceManagement.ProcessWhsShpmntRequestTC(InterfaceEntryHeaderVIP);  //HEI.24

                            end;
                        //HEI.27<<
                        '030':
                            //HEI.27>>
                            begin
                                if not WMSInterfaceSetup."Enable New WMS TC" then
                                    WMSInterfaceManagement.ProcessTransferWhsShpmntRequest(InterfaceEntryHeaderVIP)
                                else
                                    WMSInterfaceManagement.ProcessTransferWhsShpmntRequestTC(InterfaceEntryHeaderVIP); //HEI.26
                            end;
                    //HEI.27<<
                    end;
                end;
            //<<HEI.05
            //HEI.26<<
            WMSInterfaceSetup."Warehouse TS Interface":
                begin
                    case InterfaceEntryHeaderVIP."External Document No." of
                        '010':
                            //HEI.27>>
                            begin
                                if not WMSInterfaceSetup."Enable New WMS TC" then
                                    WMSInterfaceManagement.ProcessWhsShpmntRequest(InterfaceEntryHeaderVIP)
                                else
                                    WMSInterfaceManagement.ProcessWhsShpmntRequestTC(InterfaceEntryHeaderVIP);
                            end;
                        //HEI.27<<
                        '030':
                            //HEI.27>>
                            begin
                                if not WMSInterfaceSetup."Enable New WMS TC" then
                                    WMSInterfaceManagement.ProcessTransferWhsShpmntRequest(InterfaceEntryHeaderVIP)
                                else
                                    WMSInterfaceManagement.ProcessTransferWhsShpmntRequestTC(InterfaceEntryHeaderVIP); //HEI.26
                            end;
                    //HEI.27>>
                    end;
                end;
            //HEI.26>>
            //>>HEI.03
            WMSInterfaceSetup."Item Request Interface":
                WMSInterfaceManagement.ProcessItemRequest(InterfaceEntryHeaderVIP);
            WMSInterfaceSetup."Customer Request Interface":
                WMSInterfaceManagement.ProcessCustomerRequest(InterfaceEntryHeaderVIP);
            //<<HEI.03
            //>>HEI.04
            WMSInterfaceSetup."Stock Adjustment Interface":
                WMSInterfaceManagement.ProcessStockAdjustmentRequest(InterfaceEntryHeaderVIP);
            WMSInterfaceSetup."Warehouse Movement Interface":
                WMSInterfaceManagement.ProcessWarehouseMovementRequest(InterfaceEntryHeaderVIP);
            //<<HEI.04
            //>>HEI.06
            WMSInterfaceSetup."Warehouse RE Interface":
                begin
                    //HEI.21>>
                    //IF InterfaceEntryHeaderVIP."External Document No." = '030' THEN
                    //  WMSInterfaceManagement.ProcessTransferWhsReceipt(InterfaceEntryHeaderVIP);

                    case InterfaceEntryHeaderVIP."External Document No." of
                        '010':
                            WMSInterfaceManagement.WMSProcessPurchaseWhsReceipt(InterfaceEntryHeaderVIP);
                        //HEI.25<
                        '020':
                            WMSInterfaceManagement.ProcessSROWhsReceipt(InterfaceEntryHeaderVIP);
                        //HEI.25>>
                        '030':
                            WMSInterfaceManagement.ProcessTransferWhsReceipt(InterfaceEntryHeaderVIP);
                    end;
                    //HEI.21<<
                end;
            //<<HEI.06
            //HEI.22>>

            WMSInterfaceSetup."Prod. Order Output Interface":
                WMSInterfaceManagement.ReleasedProductionOrderOutput(InterfaceEntryHeaderVIP);

            //HEI.22<<
            //HEI.08>>
            // // BC Upgrade NANDIS03 - No need for BC Upgrade  >>
            // EBMInterfaceSetup."Status Update Interface":
            //     EBMInterfaceManagement.ProcessStatusUpdate(InterfaceEntryHeaderVIP);
            // EBMInterfaceSetup."Sales Confirmation Response":
            //     EBMInterfaceManagement.ProcessSalesConfirmationResponse(InterfaceEntryHeaderVIP);
            // // BC Upgrade NANDIS03 - No need for BC Upgrade  <<
            //HEI.08<<
            //HEI.09>>
            PowerAppsInterfaceSetup."Approval Interface Response":
                PowerAppsInterfaceManagement.ProcessApprovalResponse(InterfaceEntryHeaderVIP);
            //HEI.09<<
            //>> HEI.18
            PowerAppsInterfaceSetup."PO Approval Interface Response":
                PowerAppsInterfaceManagement.ProcessPOApprovalResponse(InterfaceEntryHeaderVIP);
            //<< HEI.18
            //HEI.12>>
            LSRInterfaceSetup."PO Inbound Interface":
                LSRInterfaceMgmt.ProcessLSRPurchOrder(InterfaceEntryHeaderVIP);
            LSRInterfaceSetup."PR Interface":
                LSRInterfaceMgmt.ProcessLSRPurchaseReceipt(InterfaceEntryHeaderVIP);
            LSRInterfaceSetup."Payout Interface":
                LSRInterfaceMgmt.ProcessPayments(InterfaceEntryHeaderVIP);
            //HEI.12<<
            //HEI.15>>
            LSRInterfaceSetup."Transfer Shipment Interface":
                LSRInterfaceMgmt.ProcessLSRTransferShipmentInbound(InterfaceEntryHeaderVIP);
            LSRInterfaceSetup."Transfer Receipt Interface":
                LSRInterfaceMgmt.ProcessLSRTransferReceiptInbound(InterfaceEntryHeaderVIP);
            LSRInterfaceSetup."Stock Adjustment Interface":
                LSRInterfaceMgmt.ProcessLSRStockAdjustment(InterfaceEntryHeaderVIP);
            //HEI.15<<
            //HEI.16>>
            LSRInterfaceSetup."Transfer Order Interface":
                LSRInterfaceMgmt.ProcessLSRTransferOrderInbound(InterfaceEntryHeaderVIP);
            LSRInterfaceSetup."Transfer Order Del. Interface":
                LSRInterfaceMgmt.ProcessLSRTransferOrderDeletionInbound(InterfaceEntryHeaderVIP);
            //HEI.16<<

            // BC Upgrade NANDIS03 - Astro will not be part of BC >>
            // //HEI.29>>
            // AstroInterfaceSetup."Prod. Order Close Interface":
            //     AstroInterfaceManagementL.InboundCloseProductionOrder_Astro(InterfaceEntryHeaderVIP);
            // //HEI.29<<
            // //HEI.32>>
            // AstroInterfaceSetup."Prod. Order Output Interface":
            //     AstroInterfaceManagementL.InboundOutputProductionOrder_Astro(InterfaceEntryHeaderVIP);
            // //HEI.32<<
            // //HEI.33>>
            // AstroInterfaceSetup."Balance List Interface":
            //     AstroInterfaceManagementL.InboundInventoryBalanceList_Astro(InterfaceEntryHeaderVIP);
            // //HEI.33<<
            // //HEI.34>>
            // AstroInterfaceSetup."Prod. Order LinePick Interface":
            //     AstroInterfaceManagementL.InboundProductionOrderLinePick_Astro(InterfaceEntryHeaderVIP);
            // //HEI.34<<
            // //HEI.35>>
            // AstroInterfaceSetup."Balance Change Interface":
            //     AstroInterfaceManagementL.InboundInventoryBalanceChange_Astro(InterfaceEntryHeaderVIP);
            // //HEI.35<< 
            // BC Upgrade NANDIS03 - Astro will not be part of BC <<
            //HEI.36>>
            EBMSInterfaceSetup."Sales Confirmation Interface":
                EBMSInterfaceManagement.ProcessSalesConfirmationResponse(InterfaceEntryHeaderVIP);
            //HEI.36<<
            //HEI.37>>
            // BC Upgrade NANDIS03 - Astro will not be part of BC >>
            // AstroInterfaceSetup."Asmbl Order LinePick Interface":
            //     AstroInterfaceManagementL.InboundAssemblyOrderLinePick_Astro(InterfaceEntryHeaderVIP);
            // AstroInterfaceSetup."Asmbly Order Output Interface":
            //     AstroInterfaceManagementL.InboundAssemblyOrderOutput_Astro(InterfaceEntryHeaderVIP);
            // BC Upgrade NANDIS03 - Astro will not be part of BC <<
            //HEI.37<<
            //HEI.40>>
            // BC Upgrade NANDIS03 - Blocked as PAC is not in scope >>
            // PACElectronicInvoicingSetup."Sales Posting Interface Res.":
            //     PACElectronicInvoiceMgt.ProcessSalesDocumentResponse(InterfaceEntryHeaderVIP);
            // PACElectronicInvoicingSetup."Generate PDF Response":
            //     PACElectronicInvoiceMgt.ProcessDownloadPDFResponse(InterfaceEntryHeaderVIP);
            // PACElectronicInvoicingSetup."Generate XML Response":
            //     PACElectronicInvoiceMgt.ProcessDownloadXMLResponse(InterfaceEntryHeaderVIP);
            // BC Upgrade NANDIS03 - Blocked as PAC is not in scope <<
            //HEI.40<<
            //HEI.41>>
            ZycusInterfaceSetup."Zycus PO Creation Interface":
                ZycusInterfaceManagementL.InboundProcessPurchaseOrder_Zycus(InterfaceEntryHeaderVIP);
            ZycusInterfaceSetup."Zycus GR Creation Interface":
                ZycusInterfaceManagementL.InboundProcessGoodsReceiptOfPurchaseOrder_Zycus(InterfaceEntryHeaderVIP);
            ZycusInterfaceSetup."Zycus GR Cancel Interface":
                ZycusInterfaceManagementL.InboundProcessGoodsReceiptCancellationOfPurchaseOrder_Zycus(InterfaceEntryHeaderVIP);
            ZycusInterfaceSetup."Zycus LPO GR CreationInterface":
                ZycusInterfaceManagementL.InboundProcessGoodsReceiptOfLimitPurchaseOrder_Zycus(InterfaceEntryHeaderVIP);
            ZycusInterfaceSetup."Zycus LPO GR Cancel Interface":
                ZycusInterfaceManagementL.InboundProcessGoodsReceiptCancellationOfLimitPurchaseOrder_Zycus(InterfaceEntryHeaderVIP);
            //HEI.41<<
            //HEI.42>>
            ZycusInterfaceSetup."POSM GR Confirmation Interface":
                ZycusInterfaceManagementL.InboundPOSMGRConfirmation_Zycus(InterfaceEntryHeaderVIP);
            //HEI.42<<
            // BC Upgrade NANDIS03 - No use  >>
            //HEI.43>>
            // CNETInterfaceSetup."Sales Order Interface":
            //     CNETInterfaceMgt.ProcessSalesOrderReq(InterfaceEntryHeaderVIP);
            // //HEI.43<<
            // //HEI.44>>
            // POPInterfaceSetup."DLOCAL Payout Interface":
            //     POPInterfaceMgt.ProcessPOPDLocalPayout(InterfaceEntryHeaderVIP);
            // //HEI.44<<
            // BC Upgrade NANDIS03 - No use  <<
            else
                ERROR(InterfaceNotSetUpErr, InterfaceEntryHeaderVIP."Interface Code");
        end;

        //HEI.41>>
        CLEAR(ZycusInterfaceSetupRead);
        CLEAR(ZycusInterfaceSetup);
        //HEI.41<<

    end;

    procedure SetFieldValue(var FieldRef: FieldRef; Value: Text[250]);
    var
        ConfigValidateManagement: Codeunit "Config. Validate Management";
        ErrorText: Text;
    begin
        TruncateValueToFieldLength(FieldRef, Value);
        ErrorText := ConfigValidateManagement.EvaluateValueWithValidate(FieldRef, Value, true);
        if ErrorText <> '' then
            ERROR(ErrorText);
    end;

    // BC Upgrade VAMSIU01 - Not use anywhere >>
    // procedure SetBlobFieldValue(var FieldRef: FieldRef; var TempBlob: Record TempBlob);
    // procedure SetBlobFieldValue(var FieldRef: FieldRef; var TempBlob: Codeunit "Temp Blob");
    // var
    //     InputStream: InStream;
    //     OutputStream: OutStream;
    // begin
    //     // FieldRef.VALUE := TempBlob.Blob;  
    // end;
    // BC Upgrade VAMSIU01 - Not use anywhere  <<

    local procedure TruncateValueToFieldLength(FieldRef: FieldRef; var Value: Text[250]);
    var
        "Field": Record "Field";
    begin
        EVALUATE(Field.Type, FORMAT(FieldRef.TYPE));
        if Field.Type in [Field.Type::Code, Field.Type::Text] then
            Value := COPYSTR(Value, 1, FieldRef.LENGTH);
    end;

    // BC Upgrade VAMSIU01 >>
    // [TryFunction]
    // BC Upgrade NANDIS03 - Blocked as Temoblob is obsolete >>
    // procedure SaveXMLToTempBlob(var TempBlob: Record TempBlob; var XMLBuffer: Record "XML Buffer");
    // procedure SaveXMLToTempBlob(var TempBlob: Codeunit "Temp Blob"; var XMLBuffer: Record "XML Buffer");
    // BC Upgrade NANDIS03 - Blocked as Temoblob is obsolete <<
    // var
    //     TempXMLBuffer: Record "XML Buffer" temporary;
    //     TempAttributeXMLBuffer: Record "XML Buffer" temporary;
    //     XMLDOMManagement: Codeunit "XML DOM Management";
    //     // XmlDocument: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";  // BC Upgrade NANDIS03 - temporarily
    //     // RootElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";  // BC Upgrade NANDIS03 - temporarily
    //     DefaultNamespace: Text;
    //     Header: Text;
    //     OutputStream: OutStream;
    // begin
    // TempXMLBuffer.CopyImportFrom(XMLBuffer);
    // XMLBuffer.SETCURRENTKEY("Parent Entry No.", Type, "Node Number");
    // XMLBuffer.FINDFIRST();
    // TempXMLBuffer := XMLBuffer;
    // TempXMLBuffer.SETCURRENTKEY("Parent Entry No.", Type, "Node Number");

    // Header := '<?xml version="1.0" encoding="UTF-8"?>' +
    //   '<' + TempXMLBuffer.GetElementName() + ' ';

    // DefaultNamespace := TempXMLBuffer.GetAttributeValue('xmlns');
    // if TempXMLBuffer.FindAttributes(TempAttributeXMLBuffer) then
    //     repeat
    //         Header += TempAttributeXMLBuffer.Name + '="' + TempAttributeXMLBuffer.Value + '" ';
    //     until TempAttributeXMLBuffer.NEXT() = 0;
    // Header += '/>';


    // XMLDOMManagement.LoadXMLDocumentFromText(Header, XmlDocument);
    // RootElement := XmlDocument.DocumentElement;

    // SaveChildElements(TempXMLBuffer, RootElement, XmlDocument, DefaultNamespace);

    // TempBlob.Blob.CREATEOUTSTREAM(OutputStream);
    // XmlDocument.Save(OutputStream);
    // end;


    // local procedure SaveChildElements(var TempParentElementXMLBuffer: Record "XML Buffer" temporary; XMLCurrElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; XmlDocument: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; DefaultNamespace: Text);
    // var
    //     TempElementXMLBuffer: Record "XML Buffer" temporary;
    //     // ChildElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";  // BC Upgrade NANDIS03 - blocked temporarily
    //     Namespace: Text;
    // begin
    //     if TempParentElementXMLBuffer.FindChildElements(TempElementXMLBuffer) then
    //         repeat
    //             if TempElementXMLBuffer.Namespace = '' then
    //                 Namespace := DefaultNamespace
    //             else
    //                 Namespace := TempElementXMLBuffer.Namespace;
    //             ChildElement := XmlDocument.CreateNode('element', TempElementXMLBuffer.GetElementName, Namespace);
    //             if TempElementXMLBuffer.Value <> '' then
    //                 ChildElement.InnerText := TempElementXMLBuffer.Value;
    //             XMLCurrElement.AppendChild(ChildElement);
    //             SaveAttributes(TempElementXMLBuffer, ChildElement, XmlDocument);
    //             SaveChildElements(TempElementXMLBuffer, ChildElement, XmlDocument, DefaultNamespace);
    //         until TempElementXMLBuffer.NEXT = 0;
    // end;

    // local procedure SaveAttributes(var TempParentElementXMLBuffer: Record "XML Buffer" temporary; XMLCurrElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; XmlDocument: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument");
    // var
    //     TempAttributeXMLBuffer: Record "XML Buffer" temporary;
    //     Attribute: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlAttribute";
    // begin
    //     if TempParentElementXMLBuffer.FindAttributes(TempAttributeXMLBuffer) then
    //         repeat
    //             Attribute := XmlDocument.CreateAttribute(TempAttributeXMLBuffer.Name);
    //             Attribute.InnerText := TempAttributeXMLBuffer.Value;
    //             XMLCurrElement.Attributes.SetNamedItem(Attribute);
    //         until TempAttributeXMLBuffer.NEXT = 0;
    // end;
    // BC Upgrade VAMSIU01 <<

    //BC Upgrade VAMSIU01 Begin>>
    //Creating the Procedure for TempBlob Save into XML Buffer temporarily
    procedure SaveXMLBufferToTempBlob(var TempBlob: Codeunit "Temp Blob"; var TempXMLBuffer: Record "XML Buffer" temporary)
    var
        OutStr: OutStream;
    begin
        TempBlob.CreateOutStream(OutStr);
        TempXMLBuffer.Save(TempBlob);
    end;
    //BC Upgrade VAMSIU01 End<<

    procedure SetSimulateMode(NewSimulateMode: Boolean);
    begin
        SimulateMode := NewSimulateMode;
    end;

    procedure SetInterfaceSourceNo(InterfaceEntryHeaderToProcess: Record "Interface Entry Header VIP INT"; SourceNo: Code[20]);
    var
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
    begin
        InterfaceEntryHeaderVIP.GET(InterfaceEntryHeaderToProcess."Entry No.");
        InterfaceEntryHeaderVIP."Source No." := SourceNo;
        InterfaceEntryHeaderVIP.MODIFY();
    end;

    procedure SetInterfaceProcessed(InterfaceEntryHeaderToProcess: Record "Interface Entry Header VIP INT");
    var
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
    begin
        if not InterfaceEntryHeaderVIP.GET(InterfaceEntryHeaderToProcess."Entry No.") then
            exit;
        //HEI.30>>
        if InterfaceEntryHeaderVIP.Status = InterfaceEntryHeaderVIP.Status::Processed then begin
            //HEI.30<<
            InterfaceEntryHeaderVIP.Status := InterfaceEntryHeaderVIP.Status::Processed;
            InterfaceEntryHeaderVIP.MODIFY();
            //HEI.30>>
        end;
        //HEI.30<<
        //HEI.28>>
        // PostProcessUpdate_Astro(InterfaceEntryHeaderVIP);  // BC Upgrade NANDIS03 - Astro will not be part of BC
        //HEI.28<<
    end;

    procedure SetInterfaceError(InterfaceEntryHeaderToError: Record "Interface Entry Header VIP INT"; ErrorMessage: Text);
    var
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
    begin
        if not InterfaceEntryHeaderVIP.GET(InterfaceEntryHeaderToError."Entry No.") then
            exit;

        InterfaceEntryHeaderVIP.Status := InterfaceEntryHeaderVIP.Status::Error;
        InterfaceEntryHeaderVIP."Error Message" := COPYSTR(ErrorMessage, 1, MAXSTRLEN(InterfaceEntryHeaderVIP."Error Message"));
        InterfaceEntryHeaderVIP.MODIFY();

        OnAfterSetInterfaceError(InterfaceEntryHeaderVIP);
    end;

    procedure LogInterfaceEntries(InterfaceEntryHeaderToLog: Record "Interface Entry Header VIP INT");
    var
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        InterfaceLogHeaderVIP: Record "Interface Log Header VIP INT";
        InterfaceLogLineVIP: Record "Interface Log Line VIP INT";
    begin
        if not InterfaceEntryHeaderVIP.GET(InterfaceEntryHeaderToLog."Entry No.") then
            exit;

        if InterfaceEntryHeaderVIP.Status <> InterfaceEntryHeaderVIP.Status::Error then
            InterfaceEntryHeaderVIP.Status := InterfaceEntryHeaderVIP.Status::Processed;
        InterfaceEntryHeaderVIP."Archive Date" := CURRENTDATETIME;
        InterfaceEntryHeaderVIP.MODIFY();

        InterfaceLogHeaderVIP.LOCKTABLE();
        CLEAR(InterfaceLogHeaderVIP);
        InterfaceEntryHeaderVIP.CALCFIELDS(Notes);
        InterfaceLogHeaderVIP.TRANSFERFIELDS(InterfaceEntryHeaderVIP, false);
        InterfaceLogHeaderVIP."Interface Entry No." := InterfaceEntryHeaderVIP."Entry No.";
        InterfaceLogHeaderVIP.INSERT();
        //<<HEI.13
        InterfaceEntryLineVIP.RESET();
        InterfaceEntryLineVIP.SETCURRENTKEY("Header Entry No.");
        //>>HEI.13
        InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        //<<HEI.13
        InterfaceEntryLineVIP.SETAUTOCALCFIELDS(InterfaceEntryLineVIP.Notes);
        //>>HEI.13
        if InterfaceEntryLineVIP.findset() then
            repeat
                CLEAR(InterfaceLogLineVIP);
                //<<HEI.13
                //InterfaceEntryLineVIP.CALCFIELDS(Notes);
                //>>HEI.13
                InterfaceLogLineVIP.TRANSFERFIELDS(InterfaceEntryLineVIP);
                InterfaceLogLineVIP."Header Entry No." := InterfaceLogHeaderVIP."Entry No.";
                InterfaceLogLineVIP.INSERT();
            until InterfaceEntryLineVIP.NEXT() = 0;
        //<<HEI.13
        InterfaceEntryLineVIP.SETAUTOCALCFIELDS();
        //>>HEI.13
        //HEI.41>>
        PostProcessUpdate_Zycus(InterfaceEntryHeaderVIP);
        //HEI.41<<
    end;

    procedure LogErrorInterfaceEntries(var InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    begin
        if InterfaceEntryHeaderVIP.findset() then
            repeat
                LogInterfaceEntries(InterfaceEntryHeaderVIP);
                DeleteInterfaceEntries(InterfaceEntryHeaderVIP);
            until InterfaceEntryHeaderVIP.NEXT() = 0;
    end;

    procedure DeleteInterfaceEntries(InterfaceEntryHeaderToDelete: Record "Interface Entry Header VIP INT");
    var
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
    begin
        if not InterfaceEntryHeaderVIP.GET(InterfaceEntryHeaderToDelete."Entry No.") then
            exit;

        InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        InterfaceEntryLineVIP.DELETEALL();

        InterfaceEntryHeaderVIP.DELETE();
    end;

    procedure ReprocessLogInterfaceEntries(var InterfaceLogHeaderVIP: Record "Interface Log Header VIP INT");
    begin
        if InterfaceLogHeaderVIP.findset() then
            repeat
                ReprocessInterfaceEntries(InterfaceLogHeaderVIP);
            until InterfaceLogHeaderVIP.NEXT() = 0;
    end;

    procedure ReprocessInterfaceEntries(InterfaceLogHeaderToOutbound: Record "Interface Log Header VIP INT");
    var
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        InterfaceLogHeaderVIP: Record "Interface Log Header VIP INT";
        InterfaceLogLineVIP: Record "Interface Log Line VIP INT";
        DateFilterCalcL: Codeunit "DateFilter-Calc";
        NowL: DateTime;
    begin
        InterfaceLogHeaderVIP.GET(InterfaceLogHeaderToOutbound."Entry No.");
        InterfaceEntryHeaderVIP.LOCKTABLE();
        CLEAR(InterfaceEntryHeaderVIP);
        InterfaceLogHeaderVIP.CALCFIELDS(Notes);
        InterfaceEntryHeaderVIP.TRANSFERFIELDS(InterfaceLogHeaderVIP, false);
        InterfaceEntryHeaderVIP."Sync. Date" := CURRENTDATETIME;
        //HEI.28>>
        NowL := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
        InterfaceEntryHeaderVIP."Last Parked Date (Local)" := DT2DATE(NowL);
        InterfaceEntryHeaderVIP."Last Parked Time (Local)" := DT2TIME(NowL);
        //HEI.28<<
        InterfaceEntryHeaderVIP.Status := InterfaceEntryHeaderVIP.Status::Pending;
        CLEAR(InterfaceEntryHeaderVIP."Archive Date");
        InterfaceEntryHeaderVIP.INSERT();

        InterfaceLogLineVIP.SETRANGE("Header Entry No.", InterfaceLogHeaderVIP."Entry No.");
        if InterfaceLogLineVIP.findset() then
            repeat
                CLEAR(InterfaceEntryLineVIP);
                InterfaceLogLineVIP.CALCFIELDS(Notes);
                InterfaceEntryLineVIP.TRANSFERFIELDS(InterfaceLogLineVIP);
                InterfaceEntryLineVIP."Header Entry No." := InterfaceEntryHeaderVIP."Entry No.";
                InterfaceEntryLineVIP.INSERT();
            until InterfaceLogLineVIP.NEXT() = 0;
    end;

    procedure GetUnitOfMeasureISOCode(UnitOfMeasureCode: Code[10]): Code[10];
    var
        UnitofMeasure: Record "Unit of Measure";
    begin
        if UnitofMeasure.GET(UnitOfMeasureCode) then
            if UnitofMeasure."International Standard Code" <> '' then
                exit(UnitofMeasure."International Standard Code");

        exit(UnitOfMeasureCode);
    end;

    procedure GetISOCodeUnitOfMeasure(ISOCode: Code[10]): Code[10];
    var
        UnitofMeasure: Record "Unit of Measure";
    begin
        UnitofMeasure.SETRANGE("International Standard Code", ISOCode);
        if UnitofMeasure.FINDFIRST() then
            exit(UnitofMeasure.Code);

        exit(ISOCode);
    end;

    procedure GetUnitOfMeasureCommercialISOCode(UnitOfMeasureCode: Code[10]): Code[10];
    var
        UnitofMeasure: Record "Unit of Measure";
    begin
        if UnitofMeasure.GET(UnitOfMeasureCode) then
            if UnitofMeasure."Commercial ISO Code FND" <> '' then
                exit(UnitofMeasure."Commercial ISO Code FND");

        exit(UnitOfMeasureCode);
    end;

    procedure GetCommercialISOCodeUnitOfMeasure(ISOCode: Code[10]): Code[10];
    var
        UnitofMeasure: Record "Unit of Measure";
    begin
        UnitofMeasure.SETRANGE("Commercial ISO Code FND", ISOCode);
        if UnitofMeasure.FINDFIRST() then
            exit(UnitofMeasure.Code);

        exit(ISOCode);
    end;

    procedure CheckPermissionSet(CheckUserID: Code[50]; RoleID: Code[20]; CheckForSuper: Boolean): Boolean;
    var
        User: Record User;
        AccessControl: Record "Access Control";
    begin
        if (RoleID = '') and (not CheckForSuper) then
            exit(true);

        User.SETRANGE("User Name", USERID);
        if not User.FINDFIRST() then
            exit(false);

        AccessControl.SETRANGE("User Security ID", User."User Security ID");
        if CheckForSuper then
            AccessControl.SETRANGE("Role ID", 'SUPER')
        else
            AccessControl.SETRANGE("Role ID", RoleID);
        AccessControl.SETFILTER("Company Name", '''''|' + COMPANYNAME);
        if not AccessControl.ISEMPTY then
            exit(true);

        exit(false);
    end;

    [EventSubscriber(ObjectType::Table, 472, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyJobQueueEntry(var Rec: Record "Job Queue Entry"; var xRec: Record "Job Queue Entry"; RunTrigger: Boolean);
    begin
        GetGeneralInterfaceSetup();
        //HEI.31>>
        /*
        IF (Rec."Job Queue Category Code" = 'VIP_INTERF') AND
           (GeneralInterfaceSetup."Interface Job Queue User ID" <> '')
        */
        if (GeneralInterfaceSetup."Interface Job Queue User ID" <> '') then
            //HEI.31<<
            Rec."User ID" := GeneralInterfaceSetup."Interface Job Queue User ID";

    end;


    //[EventSubscriber(ObjectType::Table, 2000000175, 'OnBeforeInsertEvent', '', false, false)]//BC Upgrade VAMMSIU01
    [EventSubscriber(ObjectType::Table, Database::"Scheduled Task", 'OnBeforeInsertEvent', '', false, false)] //BC Upgrade VAMSIU01 - added table name in place of ID
    local procedure OnBeforeInsertScheduledTask(var Rec: Record "Scheduled Task"; RunTrigger: Boolean);
    var
        User: Record User;
        JobQueueEntry: Record "Job Queue Entry";
        RecRef: RecordRef;
    begin
        GetGeneralInterfaceSetup();
        if RecRef.GET(Rec.Record) then;//Bc Upgrade SHARMP16 GAPFitChanges
        if RecRef.NUMBER = DATABASE::"Job Queue Entry" then begin
            RecRef.SETRECFILTER();
            JobQueueEntry.SETVIEW(RecRef.GETVIEW());
            if JobQueueEntry.FINDFIRST() then
                //HEI.31>>
                /*
                  IF (JobQueueEntry."Job Queue Category Code" = 'VIP_INTERF') AND   // HEI.08
                     (GeneralInterfaceSetup."Interface Job Queue User ID" <> '')
                */
           if (GeneralInterfaceSetup."Interface Job Queue User ID" <> '') then begin
                    //HEI.31<<
                    User.SETRANGE("User Name", GeneralInterfaceSetup."Interface Job Queue User ID");
                    if User.FINDFIRST() then begin
                        Rec."User ID" := User."User Security ID";
                        Rec."User Name" := User."User Name";
                    end;
                end;
        end;

    end;

    //BC Upgrade VAMSIU01 >>
    procedure GetOutboundInterface(InterfaceSetup: Record "Interface Setup INT"; var OutboundInterface: Record "Outbound Interface INT")
    var
        EnvInfo: Codeunit "Environment Information";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        ActiveSession: Record "Active Session";
        SessionEvent: Record "Session Event";
        EnvironmentCode: Option D,P;
        DatabaseName: Text;
    begin

        // Get current session
        ActiveSession.Get(Database.ServiceInstanceId(), Database.SessionId());

        // Get Environment Name (Sandbox / Production)
        if EnvInfo.IsSandbox() then
            EnvironmentCode := EnvironmentCode::D
        else
            EnvironmentCode := EnvironmentCode::P;

        // Get company mapping
        GeneralInterfaceSetup.Get();
        GeneralInterfaceSetup.TestField("Company Code ID");

        // Apply filters to Outbound Interface
        OutboundInterface.Reset();
        //OutboundInterface.SetRange("Environment Code", EnvironmentCode); //BC Upgrade VAMSIU01 - Blocked
        OutboundInterface.SetRange("New Environment Code", EnvironmentCode); //BC Upgrade VAMSIU01 - Added
        OutboundInterface.SetRange("Legal Entity Code", GeneralInterfaceSetup."Company Code ID");
        OutboundInterface.SetRange("Interface Code", InterfaceSetup.Code);

        SessionEvent.RESET();
        SessionEvent.SETCURRENTKEY("User ID", "Server Instance ID");
        SessionEvent.SETRANGE("User SID", USERSECURITYID());
        SessionEvent.SETRANGE("Server Instance ID", ActiveSession."Server Instance ID");
        if SessionEvent.FINDLAST() then
            // Database name filter (case-insensitive)
            //BC Upgrade VAMSIU01 - Blocking Database Name filter>>
            // if SessionEvent."Database Name" <> '' then
            //     OutboundInterface.SETFILTER("Database Name", '%1', '@' + SessionEvent."Database Name");
            //BC Upgrade VAMSIU01 - Blocking Database Name filter <<

            // Company filter
            OutboundInterface.SETFILTER("Company Name", '%1', '@' + COMPANYNAME);

        // Find matching setup
        if OutboundInterface.FindFirst() then;
    end;
    //BC Upgrade VAMSIU01 <<

    //BC Upgrade VAMSIU01 >>
    // procedure GetOutboundInterface(InterfaceSetup: Record "Interface Setup INT"; var OutboundInterface: Record "Outbound Interface INT");
    // var
    //     // ServerInstance: Record "Server Instance";  // BC Upgrade NANDIS03 - blocked temporarily >>
    //     ServerInstanceDetail: Record "Server Instance Detail";
    //     GeneralInterfaceSetup: Record "General Interface Setup INT";
    //     User: Record User;
    //     SessionEvent: Record "Session Event";
    //     ActiveSession: Record "Active Session";  // BC Upgrade VAMSIU01 - Added
    // begin
    //     // ServerInstance.GET(SERVICEINSTANCEID);  // BC Upgrade NANDIS03
    //     ActiveSession.Get(Database.ServiceInstanceId(), Database.SessionId());  // BC Upgrade VAMSIU01 - Added
    //     //<<HEI.13
    //     ServerInstanceDetail.RESET();
    //     ServerInstanceDetail.SETCURRENTKEY("Server Computer Name", "Server Instance Name");
    //     //>>HEI.13
    //     // BC Upgrade NANDIS03 >>
    //     // ServerInstanceDetail.SETRANGE("Server Computer Name", ServerInstance."Server Computer Name");
    //     // ServerInstanceDetail.SETRANGE("Server Instance Name", ServerInstance."Server Instance Name");
    //     // BC Upgrade NANDIS03 <<
    //     ServerInstanceDetail.SETRANGE("Server Computer Name", ActiveSession."Server Computer Name"); // BC Upgrade VAMSIU01 - Added
    //     ServerInstanceDetail.SETRANGE("Server Instance Name", ActiveSession."Server Instance Name"); // BC Upgrade VAMSIU01 - Added
    //     if ServerInstanceDetail.FINDFIRST() then begin
    //         GeneralInterfaceSetup.GET();
    //         GeneralInterfaceSetup.TESTFIELD("Company Code ID");
    //         OutboundInterface.SETRANGE("Environment Code", ServerInstanceDetail."Environment Code");
    //         OutboundInterface.SETRANGE("Legal Entity Code", GeneralInterfaceSetup."Company Code ID");
    //         OutboundInterface.SETRANGE("Interface Code", InterfaceSetup.Code);
    //         SessionEvent.SETRANGE("User SID", USERSECURITYID);// BC Upgrade VAMSIU01 - Added
    //         SessionEvent.SETRANGE("Server Instance ID", ActiveSession."Server Instance ID");// BC Upgrade VAMSIU01 - Added
    //         //<<HEI.13
    //         SessionEvent.RESET();
    //         SessionEvent.SETCURRENTKEY("User ID", "Server Instance ID");
    //         //>>HEI.13
    //         SessionEvent.SETRANGE("User SID", USERSECURITYID());
    //         // SessionEvent.SETRANGE("Server Instance ID", ServerInstance."Server Instance ID");  // BC Upgrade NANDIS03
    //         if SessionEvent.FINDLAST() then
    //             OutboundInterface.SETFILTER("Database Name", '%1', '@' + SessionEvent."Database Name");
    //         OutboundInterface.SETFILTER("Company Name", '%1', '@' + COMPANYNAME);
    //         if OutboundInterface.FINDFIRST() then;
    //     end;
    // end;
    //BC Upgrade VAMSIU01 <<

    local procedure GetGeneralInterfaceSetup();
    begin
        if not GeneralInterfaceSetupRead then
            if GeneralInterfaceSetup.GET() then; // Guarded GeneralInterfaceSetup.GET() with IF..THEN to prevent error during BC 28.1 version upgrade. OnBeforeInsertScheduledTask fires on company open; bare GET() failed in companies with no setup record (e.g. CRONUS FR) -BCU KAIRAR01
        GeneralInterfaceSetupRead := true;
    end;

    // BC Upgrade NANDIS03 - EBM Interface is out of scope >>
    // local procedure GetEBMInterfaceSetup();
    // begin
    //     //HEI.08>>
    //     if not EBMInterfaceSetupRead then
    //         if EBMInterfaceSetup.GET then;
    //     EBMInterfaceSetupRead := true;
    //     //HEI.08<<
    // end;
    // BC Upgrade NANDIS03 - EBM Interface is out of scope <<

    local procedure GetMarakiInterfaceSetup();
    begin
        //HEI.20>>
        if not MarakiInterfaceSetupRead then
            if MarakiInterfaceSetup.GET() then;
        MarakiInterfaceSetupRead := true;
        //HEI.20<<
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetInterfaceError(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    begin
    end;

    local procedure GetWMSSetup();
    begin
        //>>HEI.02
        if not WMSInterfaceSetupRead then
            if WMSInterfaceSetup.GET() then;

        WMSInterfaceSetupRead := true;
        //<<HEI.02
    end;

    local procedure GetPowerAppsSetup();
    begin
        //>>HEI.09
        if not PowerAppsInterfaceSetupRead then
            if PowerAppsInterfaceSetup.GET() then
                PowerAppsInterfaceSetupRead := true;
        //<<HEI.09
    end;

    local procedure GetAPIInterfaceSetup();
    begin
        //HEI.10>>
        if not APIInterfaceSetupRead then
            if APIInterfaceSetup.GET() then;
        APIInterfaceSetupRead := true;
        //HEI.10<<
    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertDMSCustomer(var Rec: Record Customer; RunTrigger: Boolean);
    begin
        //HEI.10>>
        if Rec.ISTEMPORARY then
            exit;

        if not DMSInterfaceSetup.GET() then
            exit;

        if not DMSInterfaceSetup."Enable DMS Interfaces" then
            exit;

        DMSInterfaceMgmt.ProcessDMSCustomerResponse(Rec);
        //HEI.10<<
    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterValidateEvent', 'Name', false, false)]
    local procedure OnAfterValidateDMSCustomerName(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer);
    begin
        //HEI.10>>
        if Rec.ISTEMPORARY then
            exit;

        if not DMSInterfaceSetup.GET() then
            exit;

        if not DMSInterfaceSetup."Enable DMS Interfaces" then
            exit;

        DMSInterfaceMgmt.ProcessDMSCustomerResponse(Rec);
        //HEI.10<<
    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterValidateEvent', 'Blocked', false, false)]
    local procedure OnAfterValidateDMSCustomerBlocked(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer);
    begin
        //HEI.10>>
        if Rec.ISTEMPORARY then
            exit;

        if not DMSInterfaceSetup.GET() then
            exit;

        if not DMSInterfaceSetup."Enable DMS Interfaces" then
            exit;

        DMSInterfaceMgmt.ProcessDMSCustomerResponse(Rec);
        //HEI.10<<
    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterValidateEvent', 'Phone No.', false, false)]
    local procedure OnAfterValidateDMSCustomerPhoneNo(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer);
    begin
        //HEI.10>>
        if Rec.ISTEMPORARY then
            exit;

        if not DMSInterfaceSetup.GET() then
            exit;

        if not DMSInterfaceSetup."Enable DMS Interfaces" then
            exit;

        DMSInterfaceMgmt.ProcessDMSCustomerResponse(Rec);
        //HEI.10<<
    end;

    [EventSubscriber(ObjectType::Table, 27, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertDMSItem(var Rec: Record Item; RunTrigger: Boolean);
    begin
        //HEI.10>>
        if Rec.ISTEMPORARY then
            exit;

        if not DMSInterfaceSetup.GET() then
            exit;

        if not DMSInterfaceSetup."Enable DMS Interfaces" then
            exit;

        DMSInterfaceMgmt.ProcessDMSItemResponse(Rec);
        //HEI.10<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Interface Log Comp. Detail INT", 'OnAfterInsertEvent', '', false, false)]

    // [EventSubscriber(ObjectType::Table, 50013, 'OnAfterInsertEvent', '', false, false)]   // BC Upgrade NANDIS03 - Blocked table id in code
    local procedure OnAfterInsertDMSItemFromMendix(var Rec: Record "Interface Log Comp. Detail INT"; RunTrigger: Boolean);
    var
        Item: Record Item;
    begin
        //HEI.10>>
        if Rec.ISTEMPORARY then
            exit;

        if not DMSInterfaceSetup.GET() then
            exit;

        if not DMSInterfaceSetup."Enable DMS Interfaces" then
            exit;

        if Rec."Table ID" <> 27 then
            exit;

        if Rec."Field ID" <> 2 then
            exit;

        Item.SETRANGE("No. 2", Rec.Value);
        if Item.FINDFIRST() then
            DMSInterfaceMgmt.ProcessDMSItemResponse(Item);
        //HEI.10<<
    end;

    [EventSubscriber(ObjectType::Table, 27, 'OnAfterValidateEvent', 'Description', false, false)]
    local procedure OnAfterValidateDMSItemDescription(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer);
    begin
        //HEI.10>>
        if Rec.ISTEMPORARY then
            exit;

        if not DMSInterfaceSetup.GET() then
            exit;

        if not DMSInterfaceSetup."Enable DMS Interfaces" then
            exit;

        DMSInterfaceMgmt.ProcessDMSItemResponse(Rec);
        //HEI.10<<
    end;

    [EventSubscriber(ObjectType::Table, 27, 'OnAfterValidateEvent', 'Sales Unit of Measure', false, false)]
    local procedure OnAfterValidateDMSItemSalesUoM(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer);
    begin
        //HEI.10>>
        if Rec.ISTEMPORARY then
            exit;

        if not DMSInterfaceSetup.GET() then
            exit;

        if not DMSInterfaceSetup."Enable DMS Interfaces" then
            exit;

        DMSInterfaceMgmt.ProcessDMSItemResponse(Rec);
        //HEI.10<<
    end;

    // BC Upgrade NANDIS03 - Dependency on DIT table - Code blocked >>
    // [EventSubscriber(ObjectType::Table, 2013610, 'OnAfterInsertEvent', '', false, false)]
    // local procedure OnAfterInsertDMSDepositItem(var Rec: Record "Sales Deposit Item Charge"; RunTrigger: Boolean);
    // begin
    //     //HEI.10>>
    //     if Rec.ISTEMPORARY then
    //         exit;

    //     if not DMSInterfaceSetup.GET then
    //         exit;

    //     if not DMSInterfaceSetup."Enable DMS Interfaces" then
    //         exit;

    //     DMSInterfaceMgmt.ProcessDMSDepositItemResponse(Rec);
    //     //HEI.10<<
    // end;

    // [EventSubscriber(ObjectType::Table, 2013610, 'OnAfterValidateEvent', 'Source No.', false, false)]
    // local procedure OnAfterInsertDMSDepositItemSourceNo(var Rec: Record "Sales Deposit Item Charge"; var xRec: Record "Sales Deposit Item Charge"; CurrFieldNo: Integer);
    // begin
    //     //HEI.10>>
    //     if Rec.ISTEMPORARY then
    //         exit;

    //     if not DMSInterfaceSetup.GET then
    //         exit;

    //     if not DMSInterfaceSetup."Enable DMS Interfaces" then
    //         exit;

    //     DMSInterfaceMgmt.ProcessDMSDepositItemResponse(Rec);
    //     //HEI.10<<
    // end;

    // [EventSubscriber(ObjectType::Table, 2013610, 'OnAfterValidateEvent', 'Unit of Measure Code', false, false)]
    // local procedure OnAfterInsertDMSDepositItemUoM(var Rec: Record "Sales Deposit Item Charge"; var xRec: Record "Sales Deposit Item Charge"; CurrFieldNo: Integer);
    // begin
    //     //HEI.10>>
    //     if Rec.ISTEMPORARY then
    //         exit;

    //     if not DMSInterfaceSetup.GET then
    //         exit;

    //     if not DMSInterfaceSetup."Enable DMS Interfaces" then
    //         exit;

    //     DMSInterfaceMgmt.ProcessDMSDepositItemResponse(Rec);
    //     //HEI.10<<
    // end;

    // [EventSubscriber(ObjectType::Table, 2013610, 'OnAfterValidateEvent', 'Quantity per', false, false)]
    // local procedure OnAfterInsertDMSDepositItemQtyPer(var Rec: Record "Sales Deposit Item Charge"; var xRec: Record "Sales Deposit Item Charge"; CurrFieldNo: Integer);
    // begin
    //     //HEI.10>>
    //     if Rec.ISTEMPORARY then
    //         exit;

    //     if not DMSInterfaceSetup.GET then
    //         exit;

    //     if not DMSInterfaceSetup."Enable DMS Interfaces" then
    //         exit;

    //     DMSInterfaceMgmt.ProcessDMSDepositItemResponse(Rec);
    //     //HEI.10<<
    // end;
    // BC Upgrade NANDIS03 - Dependency on DIT table - Code blocked <<

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostDMSSalesDocument(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]);
    var
        DDEInterfaceSetup: Record "DDE Interface Setup INT";
        SalesShipmentHeader: Record "Sales Shipment Header";
        ReturnReceiptHeader: Record "Return Receipt Header";
    // DDEInterfaceMgmt: Codeunit "DDE Interface Mgmt.";  // BC Upgrade NANDIS03 - blocked temporarily >>
    begin
        //HEI.10>>
        if SalesHeader.ISTEMPORARY then
            exit;

        if not DMSInterfaceSetup.GET() then
            exit;

        if not DMSInterfaceSetup."Enable DMS Interfaces" then
            exit;

        if (SalesShptHdrNo = '') and (RetRcpHdrNo = '') then
            exit;

        //Create Outbound Interface for Shipment posted
        if SalesShptHdrNo <> '' then begin
            SalesShipmentHeader.GET(SalesShptHdrNo);
            DMSInterfaceMgmt.ProcessDMSShipmentResponse(SalesShipmentHeader);
        end;
        //HEI.10<<
    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyLSRCustomer(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean);
    var
        BillToCustomer: Record Customer;
    begin
        //HEI.11<<
        if not RunTrigger then
            exit;

        if Rec.ISTEMPORARY then
            exit;

        if not LSRInterfaceSetup.GET() or not LSRInterfaceSetup."Enable LSR Interface" then
            exit;

        //IF NOT GUIALLOWED THEN
        //  EXIT;

        LSRInterfaceMgmt.ProcessLSRCustomerOutbound(Rec, Rec, xRec, true, false);

        BillToCustomer.RESET();
        BillToCustomer.SETRANGE("Bill-to Customer No.", Rec."No.");
        if BillToCustomer.FINDFIRST() then
            repeat
                LSRInterfaceMgmt.ProcessLSRCustomerOutbound(BillToCustomer, Rec, xRec, true, true);
            until BillToCustomer.NEXT() = 0;
        //HEI.11>>
    end;

    [EventSubscriber(ObjectType::Table, 23, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyLSRVendor(var Rec: Record Vendor; var xRec: Record Vendor; RunTrigger: Boolean);
    begin
        //HEI.11<<
        if not RunTrigger then
            exit;

        if Rec.ISTEMPORARY then
            exit;

        if not LSRInterfaceSetup.GET() or not LSRInterfaceSetup."Enable LSR Interface" then
            exit;

        //IF NOT GUIALLOWED THEN
        //  EXIT;

        LSRInterfaceMgmt.ProcessLSRVendorOutbound(Rec, xRec, true);
        //HEI.11>>
    end;

    [EventSubscriber(ObjectType::Table, 27, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyLSRItem(var Rec: Record Item; var xRec: Record Item; RunTrigger: Boolean);
    begin
        //HEI.11<<
        if not RunTrigger then
            exit;

        if Rec.ISTEMPORARY then
            exit;

        if not LSRInterfaceSetup.GET() or not LSRInterfaceSetup."Enable LSR Interface" then
            exit;

        //IF NOT GUIALLOWED THEN
        //  EXIT;

        LSRInterfaceMgmt.ProcessLSRItemOutbound(Rec, xRec, true);
        //HEI.11>>
    end;

    // BC Upgrade NANDIS03 - Blocked as Item Cross Reference table is obsolete >>
    // [EventSubscriber(ObjectType::Table, 5717, 'OnAfterRenameEvent', '', false, false)]  
    // local procedure OnAfterRenameLSRItemCrossRef(var Rec: Record "Item Cross Reference"; var xRec: Record "Item Cross Reference"; RunTrigger: Boolean);  
    [EventSubscriber(ObjectType::Table, Database::"Item Reference", 'OnAfterRenameEvent', '', false, false)]
    local procedure OnAfterRenameLSRItemCrossRef(var Rec: Record "Item Reference"; var xRec: Record "Item Reference"; RunTrigger: Boolean);  // BC Upgrade NANDIS03 - Added as Item Cross Reference table is obsolete
    var
        Item: Record Item;
    begin
        //HEI.11<<
        if not RunTrigger then
            exit;

        if Rec.ISTEMPORARY then
            exit;

        if not LSRInterfaceSetup.GET() or not LSRInterfaceSetup."Enable LSR Interface" then
            exit;

        if not Item.GET(Rec."Item No.") then
            exit;

        // BC Upgrade NANDIS03 - Item Cross Reference table is obsolete >>
        // if (Rec."Unit of Measure" <> xRec."Unit of Measure") or (Rec."Cross-Reference No." <> xRec."Cross-Reference No.") then begin
        if (Rec."Unit of Measure" <> xRec."Unit of Measure") or (Rec."Reference No." <> xRec."Reference No.") then begin
            // BC Upgrade NANDIS03 - Item Cross Reference table is obsolete <<
            if (Rec."Unit of Measure" in [Item."Base Unit of Measure", Item."Sales Unit of Measure", Item."Purch. Unit of Measure"]) or
              (xRec."Unit of Measure" in [Item."Base Unit of Measure", Item."Sales Unit of Measure", Item."Purch. Unit of Measure"]) then
                LSRInterfaceMgmt.ProcessLSRItemOutbound(Item, Item, false);
        end;
        //HEI.11>>
    end;

    // BC Upgrade NANDIS03 - Item Cross Reference table is obsolete >>
    // [EventSubscriber(ObjectType::Table, 5717, 'OnAfterInsertEvent', '', false, false)]
    // local procedure OnAfterInsertLSRItemCrossRef(var Rec: Record "Item Cross Reference"; RunTrigger: Boolean);
    [EventSubscriber(ObjectType::Table, Database::"Item Reference", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertLSRItemCrossRef(var Rec: Record "Item Reference"; RunTrigger: Boolean);
    // BC Upgrade NANDIS03 - Item Cross Reference table is obsolete <<
    var
        Item: Record Item;
    begin
        //HEI.11<<
        if not RunTrigger then
            exit;

        if Rec.ISTEMPORARY then
            exit;

        if not LSRInterfaceSetup.GET() or not LSRInterfaceSetup."Enable LSR Interface" then
            exit;

        if not Item.GET(Rec."Item No.") then
            exit;

        if Rec."Unit of Measure" in [Item."Base Unit of Measure", Item."Sales Unit of Measure", Item."Purch. Unit of Measure"] then
            LSRInterfaceMgmt.ProcessLSRItemOutbound(Item, Item, false);

        //HEI.11>>
    end;

    [EventSubscriber(ObjectType::Table, 5404, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyLSRItemUOM(var Rec: Record "Item Unit of Measure"; var xRec: Record "Item Unit of Measure"; RunTrigger: Boolean);
    var
        Item: Record Item;
    begin
        //HEI.11<<
        if not RunTrigger then
            exit;

        if Rec.ISTEMPORARY then
            exit;

        if not LSRInterfaceSetup.GET() or not LSRInterfaceSetup."Enable LSR Interface" then
            exit;

        if Rec."Qty. per Unit of Measure" = xRec."Qty. per Unit of Measure" then
            exit;

        if not Item.GET(Rec."Item No.") then
            exit;

        if Rec.Code in [Item."Base Unit of Measure", Item."Sales Unit of Measure", Item."Purch. Unit of Measure"] then
            LSRInterfaceMgmt.ProcessLSRItemOutbound(Item, Item, false);

        //HEI.11>>
    end;

    // BC Upgrade NANDIS03 - Comented as CU name is used in stead of id  - new cu id is 58000>>
    //[EventSubscriber(ObjectType::Codeunit, 50000, 'OnAfterSetInterfaceProcessed', '', false, false)]
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Interface Framework Mgt.", 'OnAfterSetInterfaceProcessed', '', false, false)]
    // BC Upgrade NANDIS03 - Comented as CU name is used in stead of id  <<
    local procedure MendixInterface_OnAfterProcessed(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        Item: Record Item;
        InterLine: Record "Interface Entry Line INT";
        InterComp: Record "Interface Entry Component INT";
        InterCompDetails: Record "Interface Entry Comp.DetailINT";
        GenInterfaceSetup: Record "General Interface Setup INT";
        CustomerDescription: Text;
    begin
        //HEI.11<<
        if InterfaceEntryHeader.ISTEMPORARY then
            exit;

        if not LSRInterfaceSetup.GET() or not LSRInterfaceSetup."Enable LSR Interface" then
            exit;

        if not GeneralInterfaceSetup.GET() then
            exit;

        case InterfaceEntryHeader."Interface Code" of
            GeneralInterfaceSetup."Customer Interface":
                begin
                    InterLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                    if InterLine.FINDFIRST() then
                        repeat
                            InterComp.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                            InterComp.SETRANGE("Line Entry No.", InterLine."Entry No.");
                            InterComp.SETRANGE("Table ID", 18);
                            /*IF InterComp.FINDFIRST AND InterCompDetails.GET(InterfaceEntryHeader."Entry No.",InterLine."Entry No.",18, InterComp.Code,1) THEN BEGIN
                              Customer.SETRANGE("No.",InterCompDetails."Incoming Value");
                              IF Customer.FINDLAST THEN
                                LSRInterfaceMgmt.ProcessLSRCustomerOutbound(Customer,Customer,Customer,FALSE,FALSE);
                            END;*/
                            if InterComp.FINDFIRST() then begin
                                if InterCompDetails.GET(InterfaceEntryHeader."Entry No.", InterLine."Entry No.", 18, InterComp.Code, 1) and (InterCompDetails."Incoming Value" <> '') then begin
                                    Customer.SETRANGE("No.", InterCompDetails."Incoming Value");
                                    if Customer.FINDLAST() then
                                        LSRInterfaceMgmt.ProcessLSRCustomerOutbound(Customer, Customer, Customer, false, false);
                                end else if InterCompDetails.GET(InterfaceEntryHeader."Entry No.", InterLine."Entry No.", 18, InterComp.Code, 50036) then begin
                                    Customer.SETRANGE("Customer Description FND", InterCompDetails."Incoming Value");
                                    if Customer.FINDLAST() then
                                        LSRInterfaceMgmt.ProcessLSRCustomerOutbound(Customer, Customer, Customer, false, false);
                                end;
                            end;
                        until InterLine.NEXT() = 0;
                end;
            GeneralInterfaceSetup."Vendor Interface":
                begin
                    InterLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                    if InterLine.FINDFIRST() then
                        repeat
                            InterComp.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                            InterComp.SETRANGE("Line Entry No.", InterLine."Entry No.");
                            InterComp.SETRANGE("Table ID", 23);
                            if InterComp.FINDFIRST() and InterCompDetails.GET(InterfaceEntryHeader."Entry No.", InterLine."Entry No.", 23, InterComp.Code, 50006) then begin
                                Vendor.SETRANGE("Global Vendor Number FND", InterCompDetails."Incoming Value");
                                if Vendor.FINDFIRST() then
                                    LSRInterfaceMgmt.ProcessLSRVendorOutbound(Vendor, Vendor, false);
                            end;
                        until InterLine.NEXT() = 0;
                end;
            GeneralInterfaceSetup."Material Interface":
                begin
                    InterLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                    if InterLine.FINDFIRST() then
                        repeat
                            InterComp.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                            InterComp.SETRANGE("Line Entry No.", InterLine."Entry No.");
                            InterComp.SETRANGE("Table ID", 27);
                            if InterComp.FINDFIRST() and InterCompDetails.GET(InterfaceEntryHeader."Entry No.", InterLine."Entry No.", 27, InterComp.Code, 2) then begin
                                Item.SETRANGE("No. 2", InterCompDetails."Incoming Value");
                                if Item.FINDFIRST() then
                                    LSRInterfaceMgmt.ProcessLSRItemOutbound(Item, Item, false);
                            end;
                        until InterLine.NEXT() = 0;
                end;
        end;
        //HEI.11>>

    end;

    local procedure GetLSRSetup();
    begin
        //HEI.12<<
        if not LSRInterfaceSetupRead then
            if LSRInterfaceSetup.GET() then;

        LSRInterfaceSetupRead := true;
        //HEI.12>>
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Status', false, false)]
    local procedure OnAfterValidateStatuSalesOrder(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer);
    var
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
    begin
        //HEI.14>>
        if Rec.ISTEMPORARY then
            exit;

        if (Rec.Status = Rec.Status::"Pending Approval") and
           (Rec."Approval Status FND" = Rec."Approval Status FND"::Rejected)
        then
            Rec."Approval Status FND" := Rec."Approval Status FND"::" ";
        //HEI.14<<
    end;

    [EventSubscriber(ObjectType::Codeunit, 415, 'OnAfterReleasePurchaseDoc', '', false, false)]
    local procedure OnAfterReleaseLSRPurchOrder(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean);
    var
        Location: Record Location;
        LSRInterfaceMgmt: Codeunit "LSR Interface Mgmt.";
        InterfaceSetup: Record "Interface Setup INT";
        LinkedPO: Record "Purchase Header";
        BaseLSROrderNo: Code[20];
        CountLSROrderNo: Integer;
        POAdditional: Record "Purchase Header Additional FND";
    begin
        //HEI.12<<
        if not LSRInterfaceSetup.GET() or not LSRInterfaceSetup."Enable LSR Interface" then
            exit;

        if not InterfaceSetup.GET(LSRInterfaceSetup."PO Outbound Interface") or not InterfaceSetup.Enabled then
            exit;

        if not GeneralInterfaceSetup.GET() then
            exit;

        if not Location.GET(PurchaseHeader."Location Code") or not Location."Store FND" then
            exit;

        if PreviewMode or (PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order) then
            exit;

        PurchaseHeader.CALCFIELDS("LSR Order No. INT");
        if PurchaseHeader."LSR Order No. INT" <> '' then begin
            if STRPOS(PurchaseHeader."LSR Order No. INT", '_') > 0 then
                BaseLSROrderNo := DELSTR(PurchaseHeader."LSR Order No. INT", STRPOS(PurchaseHeader."LSR Order No. INT", '_'))
            else
                BaseLSROrderNo := PurchaseHeader."LSR Order No. INT";

            LinkedPO.RESET();
            LinkedPO.SETAUTOCALCFIELDS("LSR Order No. INT");
            LinkedPO.SETRANGE("Document Type", LinkedPO."Document Type"::Order);
            LinkedPO.SETFILTER("No.", '<>%1', PurchaseHeader."No.");
            LinkedPO.SETFILTER("LSR Order No. INT", '%1', BaseLSROrderNo + '*');
            CountLSROrderNo := LinkedPO.COUNT;
            LinkedPO.SETFILTER(Status, '<>%1', LinkedPO.Status::Released);
            if LinkedPO.COUNT <> 0 then
                exit;

            LSRInterfaceMgmt.SendPurchOrderToLSR(PurchaseHeader);
            if CountLSROrderNo > 0 then begin
                LinkedPO.SETFILTER(Status, '%1', LinkedPO.Status::Released);
                if LinkedPO.FINDFIRST() then
                    repeat
                        LSRInterfaceMgmt.SendPurchOrderToLSR(LinkedPO);
                    until LinkedPO.NEXT() = 0;
            end;
        end else
            LSRInterfaceMgmt.SendPurchOrderToLSR(PurchaseHeader);

        if PurchaseHeader."LSR Order No. INT" = '' then begin
            POAdditional.RESET();
            if POAdditional.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") then begin
                POAdditional."LSR Order No INT" := POAdditional."No.";
                POAdditional.MODIFY();
            end;
        end;
        //HEI.12>>
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeleteLSRPurchOrder(var Rec: Record "Purchase Header"; RunTrigger: Boolean);
    var
        Location: Record Location;
        LSRInterfaceMgmt: Codeunit "LSR Interface Mgmt.";
        InterfaceSetup: Record "Interface Setup INT";
        LinkedPO: Record "Purchase Header";
        BaseLSROrderNo: Code[20];
        CountLSROrderNo: Integer;
    begin
        //HEI.12<<
        if not LSRInterfaceSetup.GET() or not LSRInterfaceSetup."Enable LSR Interface" then
            exit;

        if not InterfaceSetup.GET(LSRInterfaceSetup."PO Outbound Interface") or not InterfaceSetup.Enabled then
            exit;

        if not GeneralInterfaceSetup.GET() then
            exit;

        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;

        Rec.CALCFIELDS("LSR Order No. INT");
        if Rec."LSR Order No. INT" = '' then
            exit;

        if STRPOS(Rec."LSR Order No. INT", '_') > 0 then
            BaseLSROrderNo := DELSTR(Rec."LSR Order No. INT", STRPOS(Rec."LSR Order No. INT", '_'))
        else
            BaseLSROrderNo := Rec."LSR Order No. INT";

        LinkedPO.RESET();
        LinkedPO.SETAUTOCALCFIELDS("LSR Order No. INT");
        LinkedPO.SETRANGE("Document Type", LinkedPO."Document Type"::Order);
        LinkedPO.SETFILTER("No.", '<>%1', Rec."No.");
        LinkedPO.SETFILTER("LSR Order No. INT", '%1', BaseLSROrderNo + '*');
        CountLSROrderNo := LinkedPO.COUNT;
        LinkedPO.SETFILTER(Status, '<>%1', LinkedPO.Status::Released);
        if LinkedPO.COUNT <> 0 then
            exit;

        if CountLSROrderNo > 0 then begin
            LinkedPO.SETFILTER(Status, '%1', LinkedPO.Status::Released);
            if LinkedPO.FINDFIRST() then
                repeat
                    LSRInterfaceMgmt.SendPurchOrderToLSR(LinkedPO);
                until LinkedPO.NEXT() = 0;
        end;
        //HEI.12>>
    end;

    [EventSubscriber(ObjectType::Codeunit, 414, 'OnAfterReleaseSalesDoc', '', false, false)]
    local procedure OnAfterReleaseAPISalesOrder(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean);
    var
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
    begin
        //HEI.14>>
        if PreviewMode then
            exit;

        if SalesHeader.ISTEMPORARY then
            exit;

        if not SourceSystemIdentifierAPI.GET(SalesHeader."Source System Identifier FND") or not SourceSystemIdentifierAPI."Enable SO Notifications" then
            exit;

        if SourceSystemIdentifierAPI."Stop Sales RO Status" then
            if SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" then
                exit;

        APIOrderStatusNotifMgmt.ProcessAPIOrderStatusReleased(SalesHeader);
        //HEI.14<<
    end;

    [EventSubscriber(ObjectType::Codeunit, 414, 'OnAfterReopenSalesDoc', '', false, false)]
    local procedure OnAfterReopenAPISalesOrder(var SalesHeader: Record "Sales Header");
    var
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        ApprovalEntry: Record "Approval Entry";
    begin
        //HEI.14>>
        if SalesHeader.ISTEMPORARY then
            exit;

        if not SourceSystemIdentifierAPI.GET(SalesHeader."Source System Identifier FND") or not SourceSystemIdentifierAPI."Enable SO Notifications" then
            exit;

        if SourceSystemIdentifierAPI."Stop Sales RO Status" then
            if SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" then
                exit;

        //When Approval Entry Status = Approved => Reopen is enabled
        //When Approval Entry Status = Canceled => Document was reopen
        ApprovalEntry.RESET();
        ApprovalEntry.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Sequence No.", "Record ID to Approve");
        ApprovalEntry.SETRANGE("Table ID", 36);
        ApprovalEntry.SETRANGE("Document Type", SalesHeader."Document Type");
        ApprovalEntry.SETRANGE("Document No.", SalesHeader."No.");
        ApprovalEntry.SETFILTER(Status, '<>%1', ApprovalEntry.Status::Rejected);
        if ApprovalEntry.FINDLAST() then
            APIOrderStatusNotifMgmt.ProcessAPIOrderReopen(SalesHeader);
        //HEI.14<<
        //HEI.14<<
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Status', false, false)]
    local procedure OnAfterValidateStatuAPISalesOrder(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer);
    var
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
    begin
        //HEI.14>>
        if Rec.ISTEMPORARY then
            exit;

        if not SourceSystemIdentifierAPI.GET(Rec."Source System Identifier FND") or not SourceSystemIdentifierAPI."Enable SO Notifications" then
            exit;

        if SourceSystemIdentifierAPI."Stop Sales RO Status" then
            if Rec."Document Type" = Rec."Document Type"::"Return Order" then
                exit;

        if (Rec.Status = Rec.Status::"Pending Approval") and (Rec."Approval Status FND" = Rec."Approval Status FND"::" ") then
            APIOrderStatusNotifMgmt.ProcessAPIOrderStatusPendingApproval(Rec);
        //HEI.14<<
    end;

    // BC Upgrade NANDIS03 >>
    // [EventSubscriber(ObjectType::Table, 50186, 'OnAfterValidateEvent', 'Status', false, false)]
    [EventSubscriber(ObjectType::Table, Database::"API Interface Log2 INT", 'OnAfterValidateEvent', 'Status', false, false)]
    // BC Upgrade NANDIS03 <<
    local procedure OnAfterValidateAPILogStatus(var Rec: Record "API Interface Log2 INT"; var xRec: Record "API Interface Log2 INT"; CurrFieldNo: Integer);
    var
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
    begin
        //HEI.14>>
        if Rec.ISTEMPORARY then
            exit;

        if not SourceSystemIdentifierAPI.GET(Rec."Source System Identifier") or not SourceSystemIdentifierAPI."Enable SO Notifications" then
            exit;

        if SourceSystemIdentifierAPI."Stop Sales RO Status" then
            if Rec."Source Subtype" = Rec."Source Subtype"::"5" then
                exit;

        if Rec.Status <> Rec.Status::Error then
            exit;

        APIOrderStatusNotifMgmt.ProcessAPIOrderNotCreated(Rec);
        //HEI.14<<
    end;

    [EventSubscriber(ObjectType::Codeunit, CODEUNIT::"Heineken BC Upgrade", 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnAfterRejectAPISalesOrderApprEntry(var ApprovalEntry: Record "Approval Entry");
    var
        SalesHeader: Record "Sales Header";
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
    begin
        //HEI.14>>
        if not SalesHeader.GET(ApprovalEntry."Document Type", ApprovalEntry."Document No.") then
            exit;

        if SalesHeader.ISTEMPORARY then
            exit;

        if not SourceSystemIdentifierAPI.GET(SalesHeader."Source System Identifier FND") or not SourceSystemIdentifierAPI."Enable SO Notifications" then
            exit;

        if SourceSystemIdentifierAPI."Stop Sales RO Status" then
            if SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" then
                exit;

        if (SalesHeader.Status = SalesHeader.Status::"Pending Approval") and (SalesHeader."Approval Status FND" = SalesHeader."Approval Status FND"::" ") then // BC Upgrade SHUKLP03 << Changed condition because where status is modifying that procedure is for on -prem only now.
            APIOrderStatusNotifMgmt.ProcessAPIOrderRejected(SalesHeader);
        //HEI.14<<
    end;

    // BC Upgrade SHUKLP03 - >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Heineken BC Upgrade", 'OnAfterCreateWhseShipment', '', false, false)]
    local procedure OnAfterInsertAPIWhseShipment(var SalesHeader: Record "Sales Header");
    var
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        B2BInterfaceSetup: Record "B2B Interface Setup INT";
    begin
        //HEI.14>>
        if B2BInterfaceSetup.GET() then;

        if SalesHeader.ISTEMPORARY then
            exit;

        if not SourceSystemIdentifierAPI.GET(SalesHeader."Source System Identifier FND") or not SourceSystemIdentifierAPI."Enable SO Notifications" then
            exit;

        if SalesHeader."Shipment Method Code" <> B2BInterfaceSetup."Pick-up Shipment Method" then
            exit;

        SalesHeader."Ready for Pick-up FND" := true;
        SalesHeader.MODIFY();

        APIOrderStatusNotifMgmt.ProcessAPIWhseShipCreated(SalesHeader);
        //HEI.14<<
    end;
    // // BC Upgrade SHUKLP03 - <<

    [EventSubscriber(ObjectType::Table, 7320, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeleteAPIPickUpWhseShipment(var Rec: Record "Warehouse Shipment Header"; RunTrigger: Boolean);
    var
        SalesHeader: Record "Sales Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
        B2BInterfaceSetup: Record "B2B Interface Setup INT";
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
    begin
        //HEI.14>>
        if B2BInterfaceSetup.GET() then;

        if not SalesHeader.GET(Rec."Source Document Type FND", Rec."Source No. FND") then
            exit;

        if SalesHeader.ISTEMPORARY then
            exit;

        if not SourceSystemIdentifierAPI.GET(SalesHeader."Source System Identifier FND") or not SourceSystemIdentifierAPI."Enable SO Notifications" then
            exit;

        if (SalesHeader."Shipment Method Code" <> B2BInterfaceSetup."Pick-up Shipment Method") and
           (Rec."Shipment Method Code" <> B2BInterfaceSetup."Pick-up Shipment Method") //HEI.23
        then
            exit;

        SalesShipmentHeader.SETRANGE("Whse. Shipment No. FND", Rec."No.");
        if SalesShipmentHeader.FINDFIRST() then
            exit;

        SalesHeader."Ready for Pick-up FND" := false;
        SalesHeader.MODIFY();

        APIOrderStatusNotifMgmt.ProcessAPIOrderStatusReleased(SalesHeader);
        //HEI.14>>
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostAPIWhseShipment(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]);
    var
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
    begin
        //HEI.14>>
        if SalesHeader.ISTEMPORARY then
            exit;

        if not SourceSystemIdentifierAPI.GET(SalesHeader."Source System Identifier FND") or not SourceSystemIdentifierAPI."Enable SO Notifications" then
            exit;

        if SalesShptHdrNo = '' then
            exit
        else
            APIOrderStatusNotifMgmt.ProcessAPIWhseShipPosted(SalesHeader);
        //HEI.14<<
    end;

    [EventSubscriber(ObjectType::Table, 110, 'OnAfterValidateEvent', 'Actual Delivery Date FND', false, false)]
    local procedure OnAfterValidateAPIActualDeliveryDate(var Rec: Record "Sales Shipment Header"; var xRec: Record "Sales Shipment Header"; CurrFieldNo: Integer);
    var
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        B2BInterfaceSetup: Record "B2B Interface Setup INT";
    begin
        //HEI.14>>
        if B2BInterfaceSetup.GET() then;

        if Rec.ISTEMPORARY then
            exit;

        if not SourceSystemIdentifierAPI.GET(Rec."Source System Identifier FND") or not SourceSystemIdentifierAPI."Enable SO Notifications" then
            exit;

        if Rec."Shipment Method Code" = B2BInterfaceSetup."Pick-up Shipment Method" then
            exit;

        if Rec."Actual Delivery Date FND" <> 0D then
            APIOrderStatusNotifMgmt.ProcessAPIWhseShipCompleted(Rec)
        else
            APIOrderStatusNotifMgmt.ProcessAPIWhseShipUnCompleted(Rec);
        //HEI.14<<
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnBeforeDeleteAPISalesOrder(var Rec: Record "Sales Header"; RunTrigger: Boolean);
    var
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        //HEI.14>>
        if Rec.ISTEMPORARY then
            exit;

        if not SourceSystemIdentifierAPI.GET(Rec."Source System Identifier FND") or not SourceSystemIdentifierAPI."Enable SO Notifications" then
            exit;

        if SourceSystemIdentifierAPI."Stop Sales RO Status" then
            if Rec."Document Type" = Rec."Document Type"::"Return Order" then
                exit;

        //HEI.39>>
        if SourceSystemIdentifierAPI."Skip Sales Quote Status" then
            if Rec."Document Type" = Rec."Document Type"::Quote then
                exit;
        //HEI.39<<

        //HEI.17>>
        SalesInvoiceHeader.SETRANGE("Order No.", Rec."No.");
        if SalesInvoiceHeader.FINDFIRST() then
            exit;

        SalesCrMemoHeader.SETRANGE("Return Order No.", Rec."No.");
        if SalesCrMemoHeader.FINDFIRST() then
            exit;
        //HEI.17<<

        if not CONFIRM(STRSUBSTNO(B2BOrderDeletionConfirm, Rec."No.")) then
            ERROR('')
        else
            APIOrderStatusNotifMgmt.ProcessAPIOrderDeleted(Rec);
        //HEI.14<<
    end;


    //[EventSubscriber(ObjectType::Codeunit, 5705, 'OnAfterTransferOderPostReceipt', '', false, false)]//Bc Upgrade VAMSIU01 - Event Name changed
    [EventSubscriber(ObjectType::Codeunit, 5705, OnAfterTransferOrderPostReceipt, '', false, false)]
    local procedure OnAfterPostLSRTransferReceipt(var TransferHeader: Record "Transfer Header");
    var
        LSRInterfaceSetup: Record "LSR Interface Setup INT";
        LSRInterfaceMgmt: Codeunit "LSR Interface Mgmt.";
        TransferReceiptHeader: Record "Transfer Receipt Header";
        LocationFrom: Record Location;
        LocationTo: Record Location;
    begin
        //HEI.15>>
        if TransferHeader.ISTEMPORARY then
            exit;

        if not LSRInterfaceSetup.GET or not LSRInterfaceSetup."Enable LSR Interface" then
            exit;

        LocationFrom.GET(TransferHeader."Transfer-from Code");
        if not LocationFrom."Store FND" then
            exit;

        LocationTo.GET(TransferHeader."Transfer-to Code");
        if LocationTo."Store FND" then
            exit;

        TransferReceiptHeader.SETRANGE("Transfer Order No.", TransferHeader."No.");
        if TransferReceiptHeader.FINDFIRST then
            LSRInterfaceMgmt.ProcessLSRTransferReceiptOutbound(TransferReceiptHeader);
        //HEI.15<<
    end;


    [EventSubscriber(ObjectType::Codeunit, 5708, 'OnBeforeReopenTransferDoc', '', false, false)]
    local procedure LSROnBeforeReopenTransferOrder(var TransferHeader: Record "Transfer Header");
    var
        LSRInterfaceSetup: Record "LSR Interface Setup INT";
        LSRText001: Label 'It is not allowed to reopen an LSR order.';
    begin
        //HEI.16<<
        if TransferHeader.ISTEMPORARY then
            exit;
        if not GUIALLOWED then
            exit;
        if TransferHeader."LSR Order No FND" <> '' then
            ERROR(LSRText001);
        //HEI.16>>
    end;

    [EventSubscriber(ObjectType::Table, 5740, 'OnBeforeValidateEvent', 'Transfer-from Code', false, false)]
    local procedure LSRT5740OnBeforeValidateTransferFromCode(var Rec: Record "Transfer Header"; var xRec: Record "Transfer Header"; CurrFieldNo: Integer);
    var
        Location: Record Location;
        LSRText001: Label 'It is not allowed to select a Store location.';
    begin
        //HEI.16<<
        if Rec.ISTEMPORARY then
            exit;
        if not GUIALLOWED then
            exit;
        if Rec."LSR Order No FND" = '' then
            exit;
        if Rec."Transfer-from Code" <> xRec."Transfer-from Code" then
            if Location.GET(Rec."Transfer-from Code") and Location."Store FND" then
                ERROR(LSRText001);
        //HEI.16>>
    end;

    [EventSubscriber(ObjectType::Table, 5740, 'OnBeforeValidateEvent', 'Transfer-to Code', false, false)]
    local procedure LSRT5740OnBeforeValidateTransferToCode(var Rec: Record "Transfer Header"; var xRec: Record "Transfer Header"; CurrFieldNo: Integer);
    var
        Location: Record Location;
        LSRText001: Label 'It is not allowed to select a Store location.';
    begin
        //HEI.16<<
        if Rec.ISTEMPORARY then
            exit;
        if not GUIALLOWED then
            exit;
        if Rec."LSR Order No FND" = '' then
            exit;
        if Rec."Transfer-to Code" <> xRec."Transfer-to Code" then
            if Location.GET(Rec."Transfer-to Code") and Location."Store FND" then
                ERROR(LSRText001);
        //HEI.16>>
    end;

    [EventSubscriber(ObjectType::Codeunit, 5704, 'OnAfterTransferOrderPostShipment', '', false, false)]
    local procedure LSROnAfterTransferOrderPostShipment(var TransferHeader: Record "Transfer Header");
    var
        LSRInterfaceSetup: Record "LSR Interface Setup INT";
        LSRInterfaceMgmt: Codeunit "LSR Interface Mgmt.";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        LocationTo: Record Location;
    begin
        //HEI.16>>
        if TransferHeader.ISTEMPORARY then
            exit;

        if not LSRInterfaceSetup.GET() or not LSRInterfaceSetup."Enable LSR Interface" then
            exit;

        LocationTo.GET(TransferHeader."Transfer-to Code");
        if not LocationTo."Store FND" then
            exit;

        if GUIALLOWED then begin
            TransferShipmentHeader.SETRANGE("Transfer Order No.", TransferHeader."No.");
            if TransferShipmentHeader.FINDLAST() then
                LSRInterfaceMgmt.ProcessLSRTransferShipmentOutbound(TransferShipmentHeader);
        end;
        //HEI.16<<
    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterModifyEvent', '', false, false)]
    local procedure SEMOnAfterModifyCustomer(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean);
    var
        SEMInterfaceSetup: Record "SEM Interface Setup INT";
        SEMInterfaceMgmt: Codeunit "SEM Interface Mgmt.";
    begin
        //HEI.19<<
        if not RunTrigger then
            exit;
        if Rec.ISTEMPORARY then
            exit;
        if not SEMInterfaceSetup.GET() or not SEMInterfaceSetup."Enable SEM Interface" then
            exit;

        SEMInterfaceMgmt.ProcessSEMCustomerOutbound(Rec, Rec, xRec, true);
        //HEI.19>>
    end;


    //[EventSubscriber(ObjectType::Codeunit, 50000, 'OnAfterSetInterfaceProcessed', '', false, false)]
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Interface Framework Mgt.", 'OnAfterSetInterfaceProcessed', '', false, false)]
    local procedure SEMMendixOnAfterProcessed(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        Customer: Record Customer;
        InterLine: Record "Interface Entry Line INT";
        InterComp: Record "Interface Entry Component INT";
        InterCompDetails: Record "Interface Entry Comp.DetailINT";
        GenInterfaceSetup: Record "General Interface Setup INT";
        SEMInterfaceSetup: Record "SEM Interface Setup INT";
        SEMInterfaceMgmt: Codeunit "SEM Interface Mgmt.";
    begin
        //HEI.19<<
        if InterfaceEntryHeader.ISTEMPORARY then
            exit;

        if not SEMInterfaceSetup.GET or not SEMInterfaceSetup."Enable SEM Interface" then
            exit;

        if not GeneralInterfaceSetup.GET then
            exit;

        if InterfaceEntryHeader."Interface Code" = GeneralInterfaceSetup."Customer Interface" then begin
            InterLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
            if InterLine.FINDFIRST then
                repeat
                    InterComp.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                    InterComp.SETRANGE("Line Entry No.", InterLine."Entry No.");
                    InterComp.SETRANGE("Table ID", 18);
                    if InterComp.FINDFIRST then begin
                        if InterCompDetails.GET(InterfaceEntryHeader."Entry No.", InterLine."Entry No.", 18, InterComp.Code, 1) and (InterCompDetails."Incoming Value" <> '') then begin
                            Customer.SETRANGE("No.", InterCompDetails."Incoming Value");
                            if Customer.FINDLAST then
                                SEMInterfaceMgmt.ProcessSEMCustomerOutbound(Customer, Customer, Customer, false);
                        end else if InterCompDetails.GET(InterfaceEntryHeader."Entry No.", InterLine."Entry No.", 18, InterComp.Code, 50036) then begin
                            Customer.SETRANGE("Customer Description FND", InterCompDetails."Incoming Value");
                            if Customer.FINDLAST then
                                SEMInterfaceMgmt.ProcessSEMCustomerOutbound(Customer, Customer, Customer, false);
                        end;
                    end;
                until InterLine.NEXT = 0;
        end;
        //HEI.19>>
    end;

    [EventSubscriber(ObjectType::Table, 50072, 'OnAfterModifyEvent', '', false, false)]
    local procedure SEMOnAfterModifyCustomerAttributes(var Rec: Record "Customer Attributes FND"; var xRec: Record "Customer Attributes FND"; RunTrigger: Boolean);
    var
        SEMInterfaceSetup: Record "SEM Interface Setup INT";
        SEMInterfaceMgmt: Codeunit "SEM Interface Mgmt.";
        Customer: Record Customer;
    begin
        //HEI.19<<
        if not RunTrigger then
            exit;
        if Rec.ISTEMPORARY then
            exit;
        if not SEMInterfaceSetup.GET() or not SEMInterfaceSetup."Enable SEM Interface" then
            exit;

        if (Rec."Name 3" <> xRec."Name 3") or
          (Rec."Name 4" <> xRec."Name 4") or
          (Rec."Street 3" <> xRec."Street 3") or
          (Rec."Street 4" <> xRec."Street 4") or
          (Rec."Street 5" <> xRec."Street 5") or
          (Rec."House No. 1" <> xRec."House No. 1") or
          (Rec."House Supplement 2" <> xRec."House Supplement 2") or
          (Rec."License No." <> xRec."License No.") or
          (Rec."Business Segment" <> xRec."Business Segment") or
          (Rec."Business OrganizationalSegment" <> xRec."Business OrganizationalSegment") or
          (Rec."Customer Type" <> xRec."Customer Type") or
          (Rec."Customer Sub-Type" <> xRec."Customer Sub-Type") or
          (Rec."Local Customer Sub-Type" <> xRec."Local Customer Sub-Type") or
          (Rec.Classification <> xRec.Classification) or
          (Rec."Flag for Deletion" <> xRec."Flag for Deletion") then
            if Customer.GET(Rec."Customer No.") then;
        SEMInterfaceMgmt.ProcessSEMCustomerOutbound(Customer, Customer, Customer, false);
        //HEI.19>>
    end;


    // BC Upgrade NANDIS03 >>
    // [EventSubscriber(ObjectType::Table, 50206, 'OnAfterModifyEvent', '', false, false)]
    [EventSubscriber(ObjectType::Table, Database::"B2B Cust Inc/Exc FND", 'OnAfterModifyEvent', '', false, false)]
    // BC Upgrade NANDIS03 <<
    local procedure SEMOnAfterModifyB2BCustIncluded(var Rec: Record "B2B Cust Inc/Exc FND"; var xRec: Record "B2B Cust Inc/Exc FND"; RunTrigger: Boolean);
    var
        SEMInterfaceSetup: Record "SEM Interface Setup INT";
        SEMInterfaceMgmt: Codeunit "SEM Interface Mgmt.";
        Customer: Record Customer;
    begin
        //HEI.19<<
        if not RunTrigger then
            exit;
        if Rec.ISTEMPORARY then
            exit;
        if not SEMInterfaceSetup.GET() or not SEMInterfaceSetup."Enable SEM Interface" then
            exit;

        /*//commented by HEI.20<<
        IF Rec.Included <> xRec.Included THEN
          IF Customer.GET(Rec.Code) THEN
            SEMInterfaceMgmt.ProcessSEMCustomerOutbound(Customer,Customer,Customer,FALSE);
        *///commented by HEI.20>>
          //HEI.20<<
        if Rec.Included <> xRec.Included then begin
            Customer.SETRANGE("Bill-to Customer No.", Rec.Code);
            if Customer.FINDFIRST() then
                repeat
                    SEMInterfaceMgmt.ProcessSEMCustomerOutbound(Customer, Customer, Customer, false);
                until Customer.NEXT() = 0
        end;
        //HEI.20>>

        //HEI.19>>

    end;

    // BC Upgrade NANDIS03 >>
    // [EventSubscriber(ObjectType::Table, 50206, 'OnAfterDeleteEvent', '', false, false)]
    [EventSubscriber(ObjectType::Table, Database::"B2B Cust Inc/Exc FND", 'OnAfterDeleteEvent', '', false, false)]
    // BC Upgrade NANDIS03 <<
    local procedure SEMOnAfterDeleteB2BCustIncluded(var Rec: Record "B2B Cust Inc/Exc FND"; RunTrigger: Boolean);
    var
        SEMInterfaceSetup: Record "SEM Interface Setup INT";
        SEMInterfaceMgmt: Codeunit "SEM Interface Mgmt.";
        Customer: Record Customer;
    begin
        //HEI.20<<
        if not RunTrigger then
            exit;
        if Rec.ISTEMPORARY then
            exit;
        if not SEMInterfaceSetup.GET() or not SEMInterfaceSetup."Enable SEM Interface" then
            exit;

        Customer.SETRANGE("Bill-to Customer No.", Rec.Code);
        if Customer.FINDFIRST() then
            repeat
                SEMInterfaceMgmt.ProcessSEMCustomerOutbound(Customer, Customer, Customer, false);
            until Customer.NEXT() = 0
        //HEI.20>>
    end;

    [EventSubscriber(ObjectType::Table, 7320, 'OnAfterValidateEvent', 'Shipment Method Code', false, false)]
    local procedure OnAfterValidateShipMethodAPIWhseShip(var Rec: Record "Warehouse Shipment Header"; var xRec: Record "Warehouse Shipment Header"; CurrFieldNo: Integer);
    var
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        B2BInterfaceSetup: Record "B2B Interface Setup INT";
        SalesHeader: Record "Sales Header";
    begin
        //HEI.23>>
        if B2BInterfaceSetup.GET() then;

        if Rec.ISTEMPORARY then
            exit;

        if not SalesHeader.GET(SalesHeader."Document Type"::Order, Rec."Source No. FND") then
            exit;

        if not SourceSystemIdentifierAPI.GET(SalesHeader."Source System Identifier FND") or
           not SourceSystemIdentifierAPI."Enable SO Notifications"
        then
            exit;

        if Rec."Shipment Method Code" <> B2BInterfaceSetup."Pick-up Shipment Method" then begin
            if SalesHeader."Ready for Pick-up FND" then begin
                SalesHeader."Ready for Pick-up FND" := false;
                SalesHeader.MODIFY();
            end;

            APIOrderStatusNotifMgmt.ProcessAPIOrderStatusReleased(SalesHeader);
        end else
            if Rec."Shipment Method Code" <> xRec."Shipment Method Code" then begin

                if not SalesHeader."Ready for Pick-up FND" then begin
                    SalesHeader."Ready for Pick-up FND" := true;
                    SalesHeader.MODIFY();
                end;

                APIOrderStatusNotifMgmt.ProcessAPIWhseShipShipMethodModified(Rec);
            end;
        //HEI.23<<
    end;


    // BC Upgrade SHUKLP03 >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Process Sales API", 'OnAfterCreateSalesDocument', '', false, false)] // SHUKLP03
    local procedure OnAfterCreateAPISalesOrder(SalesHeader: Record "Sales Header");
    var
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
    begin
        //HEI.23>>
        if SalesHeader.ISTEMPORARY then
            exit;

        if not SourceSystemIdentifierAPI.GET(SalesHeader."Source System Identifier FND") or
           not SourceSystemIdentifierAPI."Enable SO Notifications"
        then
            exit;

        if SourceSystemIdentifierAPI."Stop Sales RO Status" then
            if SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" then
                exit;

        APIOrderStatusNotifMgmt.ProcessAPIOrderCreated(SalesHeader);
        //HEI.23<<
    end;
    // BC Upgrade SHUKLP03 <<

    local procedure GetEBMSInterfaceSetup();
    begin
        //HEI.36>>
        if not EBMSInterfaceSetupRead then
            if EBMSInterfaceSetup.GET() then;
        EBMSInterfaceSetupRead := true;
        //HEI.36<<
    end;

    // BC Upgrade NANDIS03 - Astro will not be part of BC >>
    // local procedure GetAstroInterfaceSetup();
    // begin
    //     //HEI.28>>
    //     if not AstroInterfaceSetupRead then begin
    //         if AstroInterfaceSetup.GET and AstroInterfaceSetup."Enabled Astro Integration" then;
    //         AstroInterfaceSetupRead := true;
    //     end;
    //     //HEI.28<<
    // end;
    // BC Upgrade NANDIS03 - Astro will not be part of BC <<

    // BC Upgrade NANDIS03 - Astro will not be part of BC >>
    // local procedure PostProcessUpdate_Astro(var InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    // var
    //     ItemL: Record Item;
    //     ProdOrderL: Record "Production Order";
    //     InterfaceEntryLineVIPL: Record "Interface Entry Line VIP INT";
    //     DateFilterCalcL: Codeunit "DateFilter-Calc";
    //     NowL: DateTime;
    //     AssemHeaderL: Record "Assembly Header";
    // begin
    //     //HEI.28>>
    //     GetAstroInterfaceSetup;
    //     if AstroInterfaceSetupRead then begin
    //         case InterfaceEntryHeaderVIP."Interface Code" of
    //             AstroInterfaceSetup."Item Create/Update Interface":
    //                 begin
    //                     if AstroInterfaceSetup."Activate Material Master" then begin
    //                         if (InterfaceEntryHeaderVIP."Source Type" = DATABASE::Item) and
    //                           (InterfaceEntryHeaderVIP."Source Subtype" = InterfaceEntryHeaderVIP."Source Subtype"::"7") then begin
    //                             if ItemL.GET(InterfaceEntryHeaderVIP."Source No.") then begin
    //                                 ItemL."Item Interface Code for Astro" := AstroInterfaceSetup."Item Create/Update Interface";
    //                                 case InterfaceEntryHeaderVIP.Status of
    //                                     InterfaceEntryHeaderVIP.Status::Processed:
    //                                         ItemL."Item Parked for Astro" := true;
    //                                     //HEI.38>>
    //                                     InterfaceEntryHeaderVIP.Status::Error:
    //                                         ItemL."Item Parked for Astro" := false;
    //                                 //HEI.38<<
    //                                 end;
    //                                 NowL := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
    //                                 ItemL."Last Parked Date for Astro" := DT2DATE(NowL);
    //                                 ItemL."Last Parked Time for Astro" := DT2TIME(NowL);
    //                                 ItemL.MODIFY(false);
    //                             end;
    //                         end;
    //                     end;
    //                 end;
    //             //HEI.30>>
    //             AstroInterfaceSetup."Prod. Order Interface":
    //                 begin
    //                     if AstroInterfaceSetup."Activate Prod. Order" then begin
    //                         if (InterfaceEntryHeaderVIP."Source Type" = DATABASE::"Production Order") and
    //                           (InterfaceEntryHeaderVIP."Source Subtype" = InterfaceEntryHeaderVIP."Source Subtype"::"7") then begin
    //                             if ProdOrderL.GET(ProdOrderL.Status::Released, InterfaceEntryHeaderVIP."Source No.") then begin
    //                                 ProdOrderL."Prod. ORDER Interface Astro" := AstroInterfaceSetup."Prod. Order Interface";
    //                                 case InterfaceEntryHeaderVIP.Status of
    //                                     InterfaceEntryHeaderVIP.Status::Processed:
    //                                         ProdOrderL."Parked ORDER Astro" := true;
    //                                     //HEI.32>>
    //                                     InterfaceEntryHeaderVIP.Status::Error:
    //                                         //HEI.38>>
    //                                         if not (ProdOrderL."Posted LINEPICK Astro" and ProdOrderL."Posted OUTPUT Astro") then
    //                                             //HEI.38<<
    //                                             ProdOrderL."Parked ORDER Astro" := false;
    //                                 //HEI.32<<
    //                                 end;
    //                                 NowL := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
    //                                 ProdOrderL."Last Parked Date ORDER Astro" := DT2DATE(NowL);
    //                                 ProdOrderL."Last Parked Time ORDER Astro" := DT2TIME(NowL);
    //                                 ProdOrderL."Last Date Modified" := DT2DATE(NowL);
    //                                 ProdOrderL.MODIFY(false);
    //                             end;
    //                         end;
    //                     end;
    //                 end;
    //             //HEI.30<<
    //             //HEI.32>>
    //             AstroInterfaceSetup."Prod. Order Output Interface":
    //                 begin
    //                     if AstroInterfaceSetup."Activate Prod. Order" then begin
    //                         if InterfaceEntryHeaderVIP.Direction = InterfaceEntryHeaderVIP.Direction::Inbound then begin
    //                             if ProdOrderL.GET(ProdOrderL.Status::Released, InterfaceEntryHeaderVIP."Source No.") then begin
    //                                 ProdOrderL."Prod. OUTPUT Interface Astro" := AstroInterfaceSetup."Prod. Order Output Interface";
    //                                 case InterfaceEntryHeaderVIP.Status of
    //                                     InterfaceEntryHeaderVIP.Status::Processed:
    //                                         ProdOrderL."Parked OUTPUT Astro" := true;
    //                                     InterfaceEntryHeaderVIP.Status::Error:
    //                                         //HEI.38>>
    //                                         if not ProdOrderL."Posted OUTPUT Astro" then
    //                                             //HEI.38<<
    //                                             ProdOrderL."Parked OUTPUT Astro" := false;
    //                                 end;
    //                                 NowL := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
    //                                 ProdOrderL."Last Parked Date OUTPUT Astro" := DT2DATE(NowL);
    //                                 ProdOrderL."Last Parked Time OUTPUT Astro" := DT2TIME(NowL);
    //                                 ProdOrderL."Last Date Modified" := DT2DATE(NowL);
    //                                 ProdOrderL.MODIFY(false);
    //                             end;
    //                         end;
    //                     end;
    //                 end;
    //             //HEI.32<<
    //             //HEI.34>>
    //             AstroInterfaceSetup."Prod. Order LinePick Interface":
    //                 begin
    //                     if AstroInterfaceSetup."Activate Prod. Order" then begin
    //                         if InterfaceEntryHeaderVIP.Direction = InterfaceEntryHeaderVIP.Direction::Inbound then begin
    //                             if ProdOrderL.GET(ProdOrderL.Status::Released, InterfaceEntryHeaderVIP."Source No.") then begin
    //                                 ProdOrderL."Prod. LINEPICK Interface Astro" := AstroInterfaceSetup."Prod. Order LinePick Interface";
    //                                 case InterfaceEntryHeaderVIP.Status of
    //                                     InterfaceEntryHeaderVIP.Status::Processed:
    //                                         ProdOrderL."Parked LINEPICK Astro" := true;
    //                                     //HEI.32>>
    //                                     InterfaceEntryHeaderVIP.Status::Error:
    //                                         //HEI.38>>
    //                                         if not ProdOrderL."Posted LINEPICK Astro" then
    //                                             //HEI.38<<
    //                                             ProdOrderL."Parked LINEPICK Astro" := false;
    //                                 //HEI.32<<
    //                                 end;
    //                                 NowL := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
    //                                 ProdOrderL."Last Parked Date LINEPICKAstro" := DT2DATE(NowL);
    //                                 ProdOrderL."Last Parked Time LINEPICKAstro" := DT2TIME(NowL);
    //                                 ProdOrderL."Last Date Modified" := DT2DATE(NowL);
    //                                 ProdOrderL.MODIFY(false);
    //                             end;
    //                         end;
    //                     end;
    //                 end;
    //             //HEI.34<<
    //             //HEI.38>>
    //             AstroInterfaceSetup."Prod. Order Close Interface":
    //                 begin
    //                     if (AstroInterfaceSetup."Activate Prod. Order") and (InterfaceEntryHeaderVIP.Status = InterfaceEntryHeaderVIP.Status::Error) then begin
    //                         if (InterfaceEntryHeaderVIP."Source Type" = DATABASE::"Production Order") and
    //                           (InterfaceEntryHeaderVIP."Source Subtype" = InterfaceEntryHeaderVIP."Source Subtype"::"7") then begin
    //                             ProdOrderL.SETFILTER(Status, '%1|%2', ProdOrderL.Status::"Firm Planned", ProdOrderL.Status::Released);
    //                             ProdOrderL.SETRANGE("No.", InterfaceEntryHeaderVIP."Source No.");
    //                             if ProdOrderL.FINDFIRST then begin
    //                                 ProdOrderL."Prod. CLOSE Interface Astro" := AstroInterfaceSetup."Prod. Order Close Interface";
    //                                 NowL := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
    //                                 ProdOrderL."Last Parked Date CLOSE Astro" := DT2DATE(NowL);
    //                                 ProdOrderL."Last Parked Time CLOSE Astro" := DT2TIME(NowL);
    //                                 ProdOrderL.MODIFY(false);
    //                             end;
    //                         end;
    //                     end;
    //                 end;
    //             //HEI.38<<
    //             //HEI.35>>
    //             AstroInterfaceSetup."Balance Change Interface":
    //                 begin
    //                     if AstroInterfaceSetup."Activate Inventory Balance" then begin
    //                         if InterfaceEntryHeaderVIP.Direction = InterfaceEntryHeaderVIP.Direction::Inbound then begin
    //                             //HEI.32>>
    //                             InterfaceEntryLineVIPL.SETCURRENTKEY("Header Entry No.", "Prod. Order No.", "Telex No.", Name);
    //                             InterfaceEntryLineVIPL.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
    //                             InterfaceEntryLineVIPL.SETFILTER("Prod. Order No.", '<>%1', '');
    //                             InterfaceEntryLineVIPL.SETRANGE("Telex No.", '43');
    //                             if InterfaceEntryLineVIPL.FINDFIRST then begin
    //                                 if ProdOrderL.GET(ProdOrderL.Status::Released, InterfaceEntryLineVIPL."Prod. Order No.") then begin
    //                                     ProdOrderL."OUTPUT Revers Interface Astro" := AstroInterfaceSetup."Balance Change Interface";
    //                                     case InterfaceEntryHeaderVIP.Status of
    //                                         InterfaceEntryHeaderVIP.Status::Processed:
    //                                             ProdOrderL."Parked OUTPUT Revers Astro" := true;
    //                                         InterfaceEntryHeaderVIP.Status::Error:
    //                                             //HEI.38>>
    //                                             if not ProdOrderL."Posted OUTPUT Revers Astro" then
    //                                                 //HEI.38<<
    //                                                 ProdOrderL."Parked OUTPUT Revers Astro" := false;
    //                                     end;
    //                                     NowL := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
    //                                     ProdOrderL."Last Parked Date OUTPUTR Astro" := DT2DATE(NowL);
    //                                     ProdOrderL."Last Parked Time OUTPUTR Astro" := DT2TIME(NowL);
    //                                     ProdOrderL."Last Date Modified" := DT2DATE(NowL);
    //                                     ProdOrderL.MODIFY(false);
    //                                 end;
    //                             end else begin
    //                                 InterfaceEntryLineVIPL.SETRANGE("Telex No.", '0');
    //                                 InterfaceEntryLineVIPL.SETRANGE(Name, '50');
    //                                 if InterfaceEntryLineVIPL.FINDFIRST then begin
    //                                     if ProdOrderL.GET(ProdOrderL.Status::Released, InterfaceEntryLineVIPL."Prod. Order No.") then begin
    //                                         ProdOrderL."Prod. OUTPUT Interface Astro" := AstroInterfaceSetup."Balance Change Interface";
    //                                         case InterfaceEntryHeaderVIP.Status of
    //                                             InterfaceEntryHeaderVIP.Status::Processed:
    //                                                 ProdOrderL."Parked OUTPUT Astro" := true;
    //                                             InterfaceEntryHeaderVIP.Status::Error:
    //                                                 //HEI.38>>
    //                                                 if not ProdOrderL."Posted OUTPUT Astro" then
    //                                                     //HEI.38<<
    //                                                     ProdOrderL."Parked OUTPUT Astro" := false;
    //                                         end;
    //                                         NowL := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
    //                                         ProdOrderL."Last Parked Date OUTPUT Astro" := DT2DATE(NowL);
    //                                         ProdOrderL."Last Parked Time OUTPUT Astro" := DT2TIME(NowL);
    //                                         ProdOrderL."Last Date Modified" := DT2DATE(NowL);
    //                                         ProdOrderL.MODIFY(false);
    //                                     end;
    //                                 end;
    //                             end;
    //                             //HEI.32<<
    //                         end;
    //                     end;
    //                 end;
    //             //HEI.35<<
    //             //HEI.37>>
    //             AstroInterfaceSetup."Assembly Order Interface":
    //                 begin
    //                     if AstroInterfaceSetup."Activate Assembly Order" then begin
    //                         if (InterfaceEntryHeaderVIP."Source Type" = DATABASE::"Assembly Header") and
    //                           (InterfaceEntryHeaderVIP."Source Subtype" = InterfaceEntryHeaderVIP."Source Subtype"::"7") then begin
    //                             if AssemHeaderL.GET(AssemHeaderL."Document Type"::Order, InterfaceEntryHeaderVIP."Source No.") then begin
    //                                 AssemHeaderL.TESTFIELD(Status, AssemHeaderL.Status::Released);
    //                                 AssemHeaderL."Assembly ORDER Interface Astro" := AstroInterfaceSetup."Assembly Order Interface";
    //                                 AssemHeaderL."Parked ORDER Astro" := true;
    //                                 NowL := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
    //                                 AssemHeaderL."Last Parked Date ORDER Astro" := DT2DATE(NowL);
    //                                 AssemHeaderL."Last Parked Time ORDER Astro" := DT2TIME(NowL);
    //                                 AssemHeaderL."Last Date Modified" := DT2DATE(NowL);
    //                                 AssemHeaderL.MODIFY(false);
    //                             end;
    //                         end;
    //                     end;
    //                 end;
    //             AstroInterfaceSetup."Asmbl Order LinePick Interface":
    //                 begin
    //                     if AstroInterfaceSetup."Activate Assembly Order" then begin
    //                         if InterfaceEntryHeaderVIP.Direction = InterfaceEntryHeaderVIP.Direction::Inbound then begin
    //                             if AssemHeaderL.GET(AssemHeaderL."Document Type"::Order, InterfaceEntryHeaderVIP."Source No.") then begin
    //                                 AssemHeaderL.TESTFIELD(Status, AssemHeaderL.Status::Released);
    //                                 AssemHeaderL."Asmbl LINEPICK Interface Astro" := AstroInterfaceSetup."Asmbl Order LinePick Interface";
    //                                 AssemHeaderL."Parked LINEPICK Astro" := true;
    //                                 NowL := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
    //                                 AssemHeaderL."Last Parked Date LINEPICKAstro" := DT2DATE(NowL);
    //                                 AssemHeaderL."Last Parked Time LINEPICKAstro" := DT2TIME(NowL);
    //                                 AssemHeaderL."Last Date Modified" := DT2DATE(NowL);
    //                                 AssemHeaderL.MODIFY(false);
    //                             end;
    //                         end;
    //                     end;
    //                 end;
    //             AstroInterfaceSetup."Asmbly Order Output Interface":
    //                 begin
    //                     if AstroInterfaceSetup."Activate Assembly Order" then begin
    //                         if InterfaceEntryHeaderVIP.Direction = InterfaceEntryHeaderVIP.Direction::Inbound then begin
    //                             if AssemHeaderL.GET(AssemHeaderL."Document Type"::Order, InterfaceEntryHeaderVIP."Source No.") then begin
    //                                 AssemHeaderL.TESTFIELD(Status, AssemHeaderL.Status::Released);
    //                                 AssemHeaderL."Asmbly OUTPUT Interface Astro" := AstroInterfaceSetup."Asmbly Order Output Interface";
    //                                 AssemHeaderL."Parked OUTPUT Astro" := true;
    //                                 NowL := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
    //                                 AssemHeaderL."Last Parked Date OUTPUT Astro" := DT2DATE(NowL);
    //                                 AssemHeaderL."Last Parked Time OUTPUT Astro" := DT2TIME(NowL);
    //                                 AssemHeaderL."Last Date Modified" := DT2DATE(NowL);
    //                                 AssemHeaderL.MODIFY(false);
    //                             end;
    //                         end;
    //                     end;
    //                 end;
    //         //HEI.37<<
    //         end;
    //     end;
    //     //HEI.28<<
    // end;
    // BC Upgrade NANDIS03 - Astro will not be part of BC <<

    // BC Upgrade NANDIS03 - PAC will not be part of BC >>
    // local procedure GetPACElectronicInvoiceSetup();
    // begin
    //     //HEI.40>>
    //     if not PACElectronicInvoicingSetupRead then
    //         if PACElectronicInvoicingSetup.GET then;

    //     PACElectronicInvoicingSetupRead := true;
    //     //HEI.40<<
    // end;
    // BC Upgrade NANDIS03 - PAC will not be part of BC <<

    local procedure GetZycusInterfaceSetup_Zycus();
    begin
        //HEI.41>>
        if not ZycusInterfaceSetupRead then begin
            if ZycusInterfaceSetup.GET() and ZycusInterfaceSetup."Enabled Zycus Integration" then
                ZycusInterfaceSetupRead := true;
        end;
        //HEI.41<<
    end;

    local procedure PostProcessUpdate_Zycus(var InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        PurchaseHeaderL: Record "Purchase Header";
        ZycusInterfaceManagementL: Codeunit "Zycus Interface Management";
        NowL: DateTime;
    begin
        //HEI.41>>
        GetZycusInterfaceSetup_Zycus();
        if ZycusInterfaceSetupRead then begin
            case InterfaceEntryHeaderVIP."Interface Code" of
                ZycusInterfaceSetup."Zycus PO Creation Interface":
                    begin
                        if ZycusInterfaceSetup."Activate PO Interface" then begin
                            if InterfaceEntryHeaderVIP.Direction = InterfaceEntryHeaderVIP.Direction::Inbound then begin
                                case InterfaceEntryHeaderVIP.Status of
                                    InterfaceEntryHeaderVIP.Status::Processed:
                                        begin
                                            ZycusInterfaceManagementL.OutboundPurchaseOrderConfirmation_Zycus(InterfaceEntryHeaderVIP."Entry No.",
                                                                                                              InterfaceEntryHeaderVIP."External Order No.");
                                            NowL := ZycusInterfaceManagementL.GetLocalCurrentDateTime_Zycus();
                                        end;
                                end;
                            end;
                        end;
                    end;
                ZycusInterfaceSetup."Zycus GR Creation Interface":
                    begin
                        if ZycusInterfaceSetup."Activate GR Interface" then begin
                            if InterfaceEntryHeaderVIP.Direction = InterfaceEntryHeaderVIP.Direction::Inbound then begin
                                case InterfaceEntryHeaderVIP.Status of
                                    InterfaceEntryHeaderVIP.Status::Processed:
                                        begin
                                            if InterfaceEntryHeaderVIP.Name6 = FORMAT(ZycusInterfaceSetup."Zycus GR CreationMovement Type") then
                                                ZycusInterfaceManagementL.OutboundGoodsReceiptOfPurchaseOrderConfirmation_Zycus(InterfaceEntryHeaderVIP."Entry No.",
                                                                                                                                InterfaceEntryHeaderVIP."External Order No.",
                                                                                                                                ZycusInterfaceSetup."Zycus GR CreationMovement Type");
                                            if InterfaceEntryHeaderVIP.Name7 = FORMAT(ZycusInterfaceSetup."Zycus RD CreationMovement Type") then
                                                ZycusInterfaceManagementL.OutboundGoodsReceiptOfPurchaseOrderConfirmation_Zycus(InterfaceEntryHeaderVIP."Entry No.",
                                                                                                                                InterfaceEntryHeaderVIP."External Order No.",
                                                                                                                                ZycusInterfaceSetup."Zycus RD CreationMovement Type");
                                            NowL := ZycusInterfaceManagementL.GetLocalCurrentDateTime_Zycus();
                                        end;
                                end;
                            end;
                        end;
                    end;
                ZycusInterfaceSetup."Zycus GR Cancel Interface":
                    begin
                        if ZycusInterfaceSetup."Activate GR Interface" then begin
                            if InterfaceEntryHeaderVIP.Direction = InterfaceEntryHeaderVIP.Direction::Inbound then begin
                                case InterfaceEntryHeaderVIP.Status of
                                    InterfaceEntryHeaderVIP.Status::Processed:
                                        begin
                                            if InterfaceEntryHeaderVIP.Name8 = FORMAT(ZycusInterfaceSetup."Zycus GR Cancel Movement Type") then
                                                ZycusInterfaceManagementL.OutboundGoodsReceiptCancellationOfPurchaseOrderConfirmation_Zycus(InterfaceEntryHeaderVIP."Entry No.",
                                                                                                                                            InterfaceEntryHeaderVIP."Source No.",
                                                                                                                                            ZycusInterfaceSetup."Zycus GR Cancel Movement Type");
                                            if InterfaceEntryHeaderVIP.Name9 = FORMAT(ZycusInterfaceSetup."Zycus RD Cancel Movement Type") then
                                                ZycusInterfaceManagementL.OutboundGoodsReceiptCancellationOfPurchaseOrderConfirmation_Zycus(InterfaceEntryHeaderVIP."Entry No.",
                                                                                                                                            InterfaceEntryHeaderVIP."Source No.",
                                                                                                                                            ZycusInterfaceSetup."Zycus RD Cancel Movement Type");
                                            NowL := ZycusInterfaceManagementL.GetLocalCurrentDateTime_Zycus();
                                        end;
                                end;
                            end;
                        end;
                    end;
                ZycusInterfaceSetup."Zycus LPO GR CreationInterface":
                    begin
                        if ZycusInterfaceSetup."Activate GR Interface" then begin
                            if InterfaceEntryHeaderVIP.Direction = InterfaceEntryHeaderVIP.Direction::Inbound then begin
                                case InterfaceEntryHeaderVIP.Status of
                                    InterfaceEntryHeaderVIP.Status::Processed:
                                        begin
                                            if (InterfaceEntryHeaderVIP.Name6 = '') and (InterfaceEntryHeaderVIP.Name7 = '') then
                                                ZycusInterfaceManagementL.OutboundGoodsReceiptOfLimitPurchaseOrderConfirmation_Zycus(InterfaceEntryHeaderVIP."Entry No.",
                                                                                                                                     InterfaceEntryHeaderVIP."External Order No.",
                                                                                                                                     0);
                                            NowL := ZycusInterfaceManagementL.GetLocalCurrentDateTime_Zycus();
                                        end;
                                end;
                            end;
                        end;
                    end;
                ZycusInterfaceSetup."Zycus LPO GR Cancel Interface":
                    begin
                        if ZycusInterfaceSetup."Activate GR Interface" then begin
                            if InterfaceEntryHeaderVIP.Direction = InterfaceEntryHeaderVIP.Direction::Inbound then begin
                                case InterfaceEntryHeaderVIP.Status of
                                    InterfaceEntryHeaderVIP.Status::Processed:
                                        begin
                                            if (InterfaceEntryHeaderVIP.Name8 = '') and (InterfaceEntryHeaderVIP.Name9 = '') then
                                                ZycusInterfaceManagementL.OutboundGoodsReceiptCancellationOfLimitPurchaseOrderConfirmation_Zycus(InterfaceEntryHeaderVIP."Entry No.",
                                                                                                                                                 InterfaceEntryHeaderVIP."External Order No.",
                                                                                                                                                 0,
                                                                                                                                                 InterfaceEntryHeaderVIP.Name4);
                                            NowL := ZycusInterfaceManagementL.GetLocalCurrentDateTime_Zycus();
                                        end;
                                end;
                            end;
                        end;
                    end;
            end;
            CLEAR(ZycusInterfaceManagementL);
            CLEAR(ZycusInterfaceSetupRead);
            CLEAR(ZycusInterfaceSetup);
        end;
        //HEI.41<<
    end;

    // BC Upgrade NANDIS03 - No use  >>
    // local procedure GetCNETInterfaceSetup();
    // begin
    //     //HEI.43>>
    //     if not CNETInterfaceSetupRead then
    //         if CNETInterfaceSetup.GET then;

    //     CNETInterfaceSetupRead := true;
    //     //HEI.43<<
    // end;

    // local procedure GetPOPInterfaceSetup();
    // begin
    //     //HEI.44>>
    //     if not POPInterfaceSetupRead then
    //         if POPInterfaceSetup.GET then;

    //     POPInterfaceSetupRead := true;
    //     //HEI.44<<
    // end;
    // BC Upgrade NANDIS03 - No use  <<
}

