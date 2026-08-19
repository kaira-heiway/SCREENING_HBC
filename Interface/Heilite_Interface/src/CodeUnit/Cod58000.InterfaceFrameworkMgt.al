codeunit 58000 "Interface Framework Mgt."
{
    // Heilite Navision Old Id - 50000

    // version FM,HEI.59

    // HEI.23 CHG2026335 HT653 FDD_La Reunion_EDI_EDI Order IBM GAVANM01 04.10.2019 - #new functions
    // HEI.26 FDD-HT610 IBM NASTAA02 13.12.2019 # La Reunion Futur Master
    //   # New functions created for Legacy Futur Master
    // HEI.28 CHG2026335 IBM GAVANM01 09.01.2020 # function modified
    // HEI.29 CHG2041871 IBM PANDES01 24-01-2020
    //    # Modified Code related to SRM.
    // HEI.31 CHG2010375 IBM KUMARN15 29.04.2020
    //   # Code added in function OnAfterModifyJobQueueEntry, OnBeforeInsertScheduledTask
    // HEI.32 CHG2043663 FDD-HT604 IBM.GAVANM01 30.04.2020 # WMS integration Heilite BASE and Reflex
    //    - #new function OnAfterSetInterfaceProcessed
    // HEI.33 FDD-HT1139A IBM NASTAA02 12.05.2020 # DRC - BVM Interface
    //   # New Subscribers created for BVM Interfaces
    // HEI.34 CHG2068423 IBM KUMARN15 01.07.2020
    //   # Code commented in functions ProcessSingleInboundEntry
    // HEI.35 CHG2095189 IBM SAXENA03 27.01.2021
    //   # Code written for Sales Order optimizaiton
    //   # Added RESET, SetCurrentKey and AutoCalcfield function in LogInterfaceEntries().
    //   # Added RESET & SetCurrentKey function in GetOutboundInterface()
    // HEI.36 CHG2095187 IBM SAXENA03 11.03.2021
    //   # Code written for Parallel Request
    //   # Remove Error() from CASE ELSE Part of PorcessSingleInboundEntry() function.
    // HEI.38 CHG2107657 IBM.GUNERE01 04.29.2021 # ProcessMasterData func. modified, CheckVendBankAccMarkforDeletion func. created
    // HEI.39 FDD-HB1195 CHG2070051 IBM NANDIS01 Import Purchasing & Receiving process HeiLite-Maximo integration
    //   New function - ProcessTransferShipmentReceipt for processing of auto shipment and receipt of TOs
    // HEI.40 FDD-HB2174 - CHG2104952 IBM NANDIS01 30.06.2021 # Raw & Pack interface HL-Ibecor
    //   # Code added for Ibecor PFI Interface process
    // HEI.41 FDD - HB1797 CHG2086227 IBM NANDIS01 24.08.2021 - LOG_GR Acknowledgement Message to Global Maximo (aka req.2 of HB1688)
    //   # Change the Maximo Purch Rcpt to Sync from Async
    // HEI.43 CHG2144425 IBM POENAB02 15.06.2022 HeiLite Vendor Invoice Status| Automation for Caribbean OpCo™s SSC
    //   # New function: GetHeiFlowInterfaceSetup
    //   # Modified function: ProcessSingleInboundEntry
    // HEI.44 CHG2172693 IBM SAMANR01 09.09.2022
    //   # Code adjusts for run all category of job queue with super user
    // HEI.42 CHG2161901 SAHAL01 10.06.2022 # Added Code as suggested by Mimikos to improve performance where it disables
    //   temporarily Cost Objects & Cost Center Alignment Dimension for the Master Data Processing in the interfaces for the Simulation Mode.
    // HEI.45 CHG2162715 HB3020 NORRIQ KOROLA04 19.12.2022 - Adding Production location in Purchase orders
    //   #ProcessMasterDataSingleInboundEntry() - modified
    // HEI.48 CHG2196883 HB3387 IBM BHANDS01 26.04.2023 # Mendix Interface Enhancement for multiple City Names for single Post code
    //   # Code added for validating City Name after Post Code
    // HEI.49 CHG2190299 FDD-HB3316 IBM NANDIS01 24.05.2023 # POSM eshop SRM- HL interface
    //   # New interface POSM GR Confirmation
    // HEI.50 CHG2190299 FDD-HB3316 IBM NANDIS01 07.08.2023 # POSM eshop SRM- HL interface
    //   # Interface code should be POSM GR Confirmation
    // HEI.51 CHG2207158 PATHAA02 29.08.2023 #S&OP FM-Production Plan Inbound Interface Enhancement
    //   # Calling new Function-ProcessPlannedProductionOrders # Tracking and skipping the Planned Production Orders with Errros sent via FuturMaster to Heilite
    // HEI.58 CHG2255708 SAHAL01 15.10.2024 Ibecor PFI Acknowledgment Interface
    //   # Created New Functions - GetIbecorInterfaceSetup_Ibecor
    //                           - PostProcessUpdate_Ibecor
    //   # Added Code
    // HEI.55 CHG2210794 MAJUMS03 21.03.2024 Zycus - BASE HL Integration Master Vendor and GL Account.
    //   # Code added to Update Zycus Master Timestamp for Vendor at the time of modification of Vendor record coming from Mendix.
    // HEI.56 CHG2210794 MAJUMS03 16.05.2024 Zycus - BASE HL Integration - Vendor GL Account Development Rework.
    //   # Code added.
    // HEI.57 CHG2210794 MAJUMS03 16.05.2024 Zycus - BASE HL Integration - Vendor development finetuning
    //   # Code added.
    // HEI.59 CHG2277688 COSTES04 20.11.2024 System is not calculating and updating the location codes for new or updated customers.
    //   # Process customer interface

    // BC Upgrade SHUKLP03 >> Unblocked code of RA payment journal and RA sales order.

    trigger OnRun();
    begin
    end;

    var
        NotFoundErr: Label 'Cannot find a value for field %1 of table %2 in table %3.', Comment = '%1 - field caption, %2 - table caption, %3 - table caption';
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        SRMInterfaceManagement: Codeunit "SRM Interface Management";
        MaximoInterfaceManagement: Codeunit "Maximo Interface Management";
        GeneralInterfaceSetupRead: Boolean;
        // PeparriInterfaceManagement: Codeunit "Peparri Interface Management";  // BC Upgrade NANDIS03 - Peppari blocked temporarily
        SimulateMode: Boolean;
        SimulateModeErr: Label 'Simulate Mode';
        InterfaceNotSetUpErr: Label 'Interface %1 is not set up.';
        FuturMasterInterfaceSetup: Record "FuturMaster Interf. Setup INT";
        FuturMasterInterfaceSetupRead: Boolean;
        EskerInterfaceSetup: Record "Esker Interface Setup INT";
        EskerInterfaceManag: Codeunit "ESKER Interface Manag";
        EskerlInterfaceSetupRead: Boolean;
        EBMInterfaceSetup: Record "EBM Interface Setup INT";
        //EBMInterfaceManagement: Codeunit "EBM Interface Management";  // BC Upgrade NANDIS03 - EBM blocked temporarily
        EBMInterfaceSetupRead: Boolean;
        CounterpointInterfaceSetupRead: Boolean;
        CounterpointInterfaceSetup: Record "Counterpoint Interf. Stp INT";
        CounterpointInterfaceMgmt: Codeunit "Counterpoint Interface Mgmt.";
        CashVanSalesInterfaceSetupRead: Boolean;
        CashVanSalesInterfaceSetup: Record "Cash Van Sales Interf. Stp INT";
        CashVanSalesInterfaceManag: Codeunit "Cash Van Sales Interface Manag";
        FM2InterfaceSetup: Record "FuturMaster Interf Setup_2 INT";
        FMInterfaceManagement: Codeunit "FM Interface Management";
        FM2InterfaceSetupRead: Boolean;
        OrtecInterfaceSetupRead: Boolean;
        OrtecInterfaceSetup: Record "Ortec & KStore Interf. Stp INT";
        OrtecInterfaceManagement: Codeunit "Ortec & KStore Interface Mgmt.";  // BC Upgrade SHUKLP03
        MarakiInterfaceSetup: Record "Maraki Interface Setup INT";
        MarakiInterfaceManagement: Codeunit "Maraki Interface Management";
        MarakiInterfaceSetupRead: Boolean;
        BankConnInterfaceSetup: Record "Bank Conn. Interface Setup INT";
        BankConnectivityInterfaceSetupRead: Boolean;
        // BankConnectivityInterfaceManagement: Codeunit "BC Interface Management";  // BC Upgrade NANDIS03 - BC Interface blocked temporarily
        EDIInterfaceSetupRead: Boolean;
        EDIInterfaceSetup: Record "EDI Interface Setup INT";
        EDIInterfaceManagement: Codeunit "EDI Interface Mgmt.";
        LegacyFuturMasterIntSetupRead: Boolean;
        LegacyFuturMasterIntSetup: Record "Legacy Futur Mster Int Stp INT";
        LegacyFMInterfaceMgmt: Codeunit "Legacy FM Interface Mgmt.";
        SRMInterfaceSetup: Record "SRM Interface Setup INT";
        SRMInterfaceSetupRead: Boolean;
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        // BVMInterfaceMgmt: Codeunit "BVM Interface Mgmt.";  // BC Upgrade NANDIS03 - BVM blocked temporarily
        IbecorInterfaceSetupRead: Boolean;
        IbecorInterfaceSetup: Record "Ibecor Interface Setup INT";
        IbecorProcessor: Codeunit "Process Purchase API";
        HeiFlowInterfaceSetupRead: Boolean;
        HeiFLOWInterfaceSetup: Record "HeiFLOW Interface Setup INT";
        HeiFlowInterfaceManagement: Codeunit "HeiFlow Interface Management";

    procedure ProcessSingleInboundEntry(InterfaceEntryHeader: Record "Interface Entry Header INT") ReturnValue: Text;
    var
        InterfaceEntryLine: Record "Interface Entry Line INT";
        EntryNo1: Integer;
    begin
        GetGeneralInterfaceSetup();
        GetGeneralInterfaceOPCOSetup();//HEI.04
        GetEskerInterfaceSetup();//HEI.06
        // GetEBMInterfaceSetup;//HEI.07  //HEI.34
        GetCounterpointInterfaceSetup(); //HEI.08
        GetFM2InterfaceSetup(); //HEI.14
        GetOrtecInterfaceSetup();//HEI.18
        GetBankConnectivityInterfaceSetup(); //HEI.21
        GetEDIInterfaceSetup();//HEI.23
        GetLegacyFuturMasterIntSetup(); //HEI.26
        GetSRMInterfaceSetup(); //HEI.29
        //HEI.58>>
        //GetIbecorInterfaceSetup;//HEI.40
        GetIbecorInterfaceSetup_Ibecor();
        //HEI.58<<
        GetHeiFlowInterfaceSetup();//HEI.43


        case InterfaceEntryHeader."Interface Code" of
            GeneralInterfaceSetup."Material Interface",//HEI.11
          GeneralInterfaceSetup."Vendor Interface",//HEI.13
          GeneralInterfaceSetup."Items Global Interface",
          GeneralInterfaceSetup."Items Local Finance Interface",
          GeneralInterfaceSetup."Items Local Planning Interface",
          GeneralInterfaceSetup."Items Local Site Interface",
          GeneralInterfaceSetup."Vendors Global Interface",
          GeneralInterfaceSetup."Vendor Bank Interface",
          GeneralInterfaceSetup."Vend. Local Finance Interface",
          GeneralInterfaceSetup."Customer Interface",//HEI.09
          GeneralInterfaceSetup."Vend. Local Purch. Interface":
                ReturnValue := ProcessMasterDataSingleInboundEntry(InterfaceEntryHeader);
            //HEI.29>>
            SRMInterfaceSetup."SRM Vendor Request Interface":
                SRMInterfaceManagement.ProcessVendorRequest(InterfaceEntryHeader);
            SRMInterfaceSetup."Contract Creation Interface":
                SRMInterfaceManagement.ProcessContractCreation(InterfaceEntryHeader);
            SRMInterfaceSetup."PO Validation Req. Interface":
                SRMInterfaceManagement.ProcessPOValidationRequest(InterfaceEntryHeader);
            SRMInterfaceSetup."PO Creation Interface":
                SRMInterfaceManagement.ProcessPOCreation(InterfaceEntryHeader);
            //HEI.47>>
            SRMInterfaceSetup."GR Validation Req Interface":
                SRMInterfaceManagement.ProcessGRValidationRequest(InterfaceEntryHeader);
            //HEI.47<<
            SRMInterfaceSetup."GR Creation Interface":
                //HEI.29<<
                SRMInterfaceManagement.ProcessGRCreation(InterfaceEntryHeader);
            //HEI.49>>
            //SRMInterfaceSetup."POSM GR Creation" :   //HEI.50
            SRMInterfaceSetup."POSM GR Confirmation":  //HEI.50
                SRMInterfaceManagement.POSMGRConfirmation(InterfaceEntryHeader);
            //HEI.49<<

            GeneralInterfaceSetup."Maximo PR Interface":
                MaximoInterfaceManagement.ProcessPRCreation(InterfaceEntryHeader);
            GeneralInterfaceSetup."Maximo Purch. Rcpt. Interface":
                //HEI.41>>
                //BEGIN
                //  InterfaceEntryLine.SETRANGE("Header Entry No.",InterfaceEntryHeader."Entry No.");
                //  InterfaceEntryLine.FINDFIRST;
                // CASE InterfaceEntryLine."Description 2" OF
                //  'Receipt':
                //      MaximoInterfaceManagement.ProcessPurchaseReceipt(InterfaceEntryHeader);
                //  'SHIPRECEIPT':
                //      MaximoInterfaceManagement.ProcessTransferReceipt(InterfaceEntryHeader);//HEI.03
                //  'Return',
                //  'VoidReceipt':
                //      MaximoInterfaceManagement.ProcessPurchaseCancelReceipt(InterfaceEntryHeader);//HEI.12
                //   //HEI.39>>
                //   'Transfer':
                //    MaximoInterfaceManagement.ProcessTransferShipmentReceipt(InterfaceEntryHeader);
                //   //HEI.39<<
                //  END;
                //END;
                MaximoInterfaceManagement.ProcessMaximoPurchaseReceipt(InterfaceEntryHeader);

            //HEI.41<<
            GeneralInterfaceSetup."Maximo Stock Adjmt. Interface":
                MaximoInterfaceManagement.ProcessStockAdjmt(InterfaceEntryHeader);
            GeneralInterfaceSetup."Maximo Goods Issue Interface":
                MaximoInterfaceManagement.ProcessGoodsIssue(InterfaceEntryHeader);
            GeneralInterfaceSetup."Maximo Goods Transf. Interface":
                MaximoInterfaceManagement.ProcessGoodsTransfer(InterfaceEntryHeader);

            //<< HEI.02 FDD-HNK LOGGAP002 09/02/2018 IBM.CHAUHB01
            // BC Upgrade NANDIS03 - Peppari blocked temporarily >>
            // GeneralInterfaceSetup."Peperi SO Interface":
            //     PeparriInterfaceManagement.ProcessPepperiSalesData(InterfaceEntryHeader);
            // BC Upgrade NANDIS03 - Peppari blocked temporarily <<
            //>> HEI.02 FDD-HNK LOGGAP002 09/02/2018 IBM.CHAUHB01
            //HEI.04>>

            CashVanSalesInterfaceSetup."CVS Transfer Order Interf":
                CashVanSalesInterfaceManag.CreateTransferOrder(InterfaceEntryHeader);
            CashVanSalesInterfaceSetup."CVS Sales Orders Interface":
                CashVanSalesInterfaceManag.CreateSalesOrders(InterfaceEntryHeader);
            CashVanSalesInterfaceSetup."CVS Cash Receipt Interf":
                CashVanSalesInterfaceManag.CreateCashReceipt(InterfaceEntryHeader);

            //HEI.04
            //HEI.14>>
            FM2InterfaceSetup."Purch. Requisitions Interface":
                FMInterfaceManagement.ProcessPurchaseRequisition(InterfaceEntryHeader);

            /*
            FM2InterfaceSetup."Production Orders Interface":
            //ReturnValue := FMInterfaceManagement.ProcessSalesActualMthRequest(InterfaceEntryHeader);
            */
            //HEI.14<<

            //HEI.15>>

            FM2InterfaceSetup."Production Orders Interface":
                //FMInterfaceManagement.ProcessProductionOrders(InterfaceEntryHeader); //HEI.51
                FMInterfaceManagement.ProcessPlannedProductionOrders(InterfaceEntryHeader); //HEI.51

            //HEI.15<<


            //HEI.21>>
            // BC Upgrade NANDIS03 - BC Interface blocked temporarily >>
            // BankConnInterfaceSetup."CAMT053 Inbound Interface":
            //     BankConnectivityInterfaceManagement.ProcessBankStatementCAMT053(InterfaceEntryHeader);
            // BankConnInterfaceSetup."MT940 Inbound Interface":
            //     BankConnectivityInterfaceManagement.ProcessBankStatementMT940(InterfaceEntryHeader);
            // BC Upgrade NANDIS03 - BC Interface blocked temporarily <<
            //HEI.21<<

            //HEI.06>>
            EskerInterfaceSetup."Esker InvPosting Interf":
                EskerInterfaceManag.CreatePurchInvoice(InterfaceEntryHeader);

            //HEI.06<<
            //HEI.34>>
            //  //HEI.07>>
            //  EBMInterfaceSetup."Status Update Interface":
            //    EBMInterfaceManagement.ProcessStatusUpdate(InterfaceEntryHeader);
            //  EBMInterfaceSetup."Sales Confirmation Response":
            //    EBMInterfaceManagement.ProcessSalesConfirmationResponse(InterfaceEntryHeader);
            //  //HEI.07<<
            //HEI.34<<
            //HEI.08>>
            CounterpointInterfaceSetup."Sales Interface":
                CounterpointInterfaceMgmt.ProcessSales(InterfaceEntryHeader);
            CounterpointInterfaceSetup."Payments Interface":
                CounterpointInterfaceMgmt.ProcessPayments(InterfaceEntryHeader);
            CounterpointInterfaceSetup."Payouts Interface":
                CounterpointInterfaceMgmt.ProcessPayouts(InterfaceEntryHeader);
            CounterpointInterfaceSetup."Stock Adjustments Interface":
                CounterpointInterfaceMgmt.ProcessStockAdjmt(InterfaceEntryHeader);
            CounterpointInterfaceSetup."Stock Transfers Interface":
                CounterpointInterfaceMgmt.ProcessTransferAdjmt(InterfaceEntryHeader);
            CounterpointInterfaceSetup."Receipts Non Core Interface":
                CounterpointInterfaceMgmt.ProcessReceipts(InterfaceEntryHeader);
            CounterpointInterfaceSetup."RTV Non Core Interface":
                CounterpointInterfaceMgmt.ProcessRTV(InterfaceEntryHeader);

            //HEI.08<<

            //HEI.18>>
            // BC Upgrade NANDIS03 - Ortec blocked temporarily >>
            // OrtecInterfaceSetup."SO Update Interface":
            //     OrtecInterfaceManagement.UpdateSO(InterfaceEntryHeader);
            // //HEI.18<<
            // //HEI.19>>
            // OrtecInterfaceSetup."SO/SRO Interface Request":
            //     OrtecInterfaceManagement.ProcessSalesOrder(InterfaceEntryHeader);
            // BC Upgrade NANDIS03 - Ortec blocked temporarily <<
            //HEI.19<<
            //HEI.23>>

            EDIInterfaceSetup."SO/SRO Interface Request":
                //EDIInterfaceManagement.ProcessSalesOrder(InterfaceEntryHeader);  // commented by HEI.28
                EDIInterfaceManagement.ProcessSalesOrder(InterfaceEntryHeader, true);  // HEI.28
                                                                                       //HEI.23<<

            //>> HEI.24

            // BC Upgrade SHUKLP03 >>
            OrtecInterfaceSetup."RA SO/SRO Interface Request":
                OrtecInterfaceManagement.ProcessRASalesOrder(InterfaceEntryHeader);
            OrtecInterfaceSetup."RA Payment/Refund Request":
                OrtecInterfaceManagement.CreateRAPaymentJournal(InterfaceEntryHeader);
            // BC Upgrade SHUKLP03 <<
            //<< HEI.24
            //HEI.26>>

            LegacyFuturMasterIntSetup."Client Master Interface Req":
                LegacyFMInterfaceMgmt.ProcessCustomerMaster(InterfaceEntryHeader);
            LegacyFuturMasterIntSetup."Actual Sales Daily Exp BB Req":
                LegacyFMInterfaceMgmt.ProcessActualSalesDailyExport(InterfaceEntryHeader);
            LegacyFuturMasterIntSetup."DRP Stock Export Req":
                LegacyFMInterfaceMgmt.ProcessDRPStockExport(InterfaceEntryHeader);
            LegacyFuturMasterIntSetup."MPS Stock Export Req":
                LegacyFMInterfaceMgmt.ProcessMPSStockExport(InterfaceEntryHeader);
            LegacyFuturMasterIntSetup."Actual Sales Weekly Exp BB Req":
                LegacyFMInterfaceMgmt.ProcessActualSalesWeeklyExport(InterfaceEntryHeader);
            LegacyFuturMasterIntSetup."Actual Sales Monthly Exp BB R":
                LegacyFMInterfaceMgmt.ProcessActualSalesMonthlyExport(InterfaceEntryHeader);
            LegacyFuturMasterIntSetup."MRP Stock Export BB Request":
                LegacyFMInterfaceMgmt.ProcessMRPStockExport(InterfaceEntryHeader);
            LegacyFuturMasterIntSetup."Purchase Order Export Req":
                LegacyFMInterfaceMgmt.ProcessPurchaseOrder(InterfaceEntryHeader);
            LegacyFuturMasterIntSetup."Product FM Global Req":
                LegacyFMInterfaceMgmt.ProcessFMProductGlobal(InterfaceEntryHeader);
            LegacyFuturMasterIntSetup."Customer Discount Req":
                LegacyFMInterfaceMgmt.ProcessCustomerDiscounts(InterfaceEntryHeader);

            //HEI.26<<
            //<<HEI.36
            /*
            ELSE
              ERROR(InterfaceNotSetUpErr,InterfaceEntryHeader."Interface Code");
            */
            //>>HEI.36
            //HEI.40>>
            IbecorInterfaceSetup."IBECOR PFI":
                IbecorProcessor.ProcessPFICreation(InterfaceEntryHeader);
            //HEI.40<<
            //HEI.43>>
            HeiFLOWInterfaceSetup."HeiFlow Vend. Inv. Request":
                HeiFlowInterfaceManagement.ProcessVendorInvRequest(InterfaceEntryHeader);
        //HEI.43<<
        end;

    end;

    local procedure ProcessMasterDataSingleInboundEntry(InterfaceEntryHeader: Record "Interface Entry Header INT") ReturnValue: Text;
    begin
        case InterfaceEntryHeader."Source Type" of
            DATABASE::Item,
          DATABASE::"Item Unit of Measure",
          DATABASE::"Item Translation",
          //DATABASE::"Item Cross Reference",  // BC Upgrade NANDIS03 - Blocked as Item Cross Referenceis obsolete
          DATABASE::"Stockkeeping Unit",
          DATABASE::"Item Attribute Value Mapping":
                ReturnValue := ProcessMasterData(InterfaceEntryHeader);
            DATABASE::Vendor,
          DATABASE::"Vendor Bank Account":
                ReturnValue := ProcessMasterData(InterfaceEntryHeader);
            DATABASE::"Default Dimension":
                ReturnValue := ProcessMasterData(InterfaceEntryHeader);
            //HEI.09>>
            DATABASE::Customer:
                ReturnValue := ProcessMasterData(InterfaceEntryHeader);
            //HEI.09<<
            //HEI.45>>
            DATABASE::"Vendor SPL Relation FND":
                ReturnValue := ProcessMasterData(InterfaceEntryHeader);
        //HEI.45<<
        //other tables here
        end;
    end;

    local procedure ProcessMasterData(InterfaceEntryHeader: Record "Interface Entry Header INT") ReturnValue: Text;
    var
        InterfaceEntryHeader2: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        InterfaceEntryCompDetail: Record "Interface Entry Comp.DetailINT";
        SessionGlobals: Codeunit "Session Globals";
        RecRef: RecordRef;
        FldRef: FieldRef;
        "Key": KeyRef;
        i: Integer;
        HeinekenGlobal: Codeunit "Heineken Global";
        InterfaceEntryCompDetail2: Record "Interface Entry Comp.DetailINT";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        ItemNo: Code[20];
        ItemNoFieldRef: FieldRef;
        VendorNo: Code[10];
        VendorNoFieldRef: FieldRef;
        BankAccCode: Code[10];
        BankAccCodeFieldRef: FieldRef;
        isBlank: Integer;
        VendorBankAccount: Record "Vendor Bank Account";
        MarkForDeletionFieldRef: FieldRef;
        MarkForDeletion: Boolean;
        recCAS: Record "Cost Accounting Setup";
        vAlignCostCenterDimension: Integer;
        vAlignCostObjectDimension: Integer;
        InterfaceEntryComponent2: Record "Interface Entry Component INT";
        InterfaceEntryCompDetail3: Record "Interface Entry Comp.DetailINT";
        CityNameVar: Variant;
        CityName: Text[35];
        VendorCodeFieldRef: FieldRef;
        VendorCode: Code[20];
        ZycusMasterTimestamp: Record "Zycus Master Timestamp FND";
        VendorGlobalDeleteFieldRef: FieldRef;
        VendorGlobalDelete: Boolean;
        HeinekenInterfaceBCUpgrade: Codeunit "Heineken Interface BC Upgrade";  // BC Upgrade NANDIS03
    begin
        SessionGlobals.SetHideValidationDialog(true);

        //MV disable Cost Center Auto Aligmemt in SimulateMode
        //HEI.42>>
        if SimulateMode and recCAS.GET() then begin
            vAlignCostCenterDimension := recCAS."Align Cost Center Dimension";
            vAlignCostObjectDimension := recCAS."Align Cost Object Dimension";
            recCAS."Align Cost Center Dimension" := recCAS."Align Cost Center Dimension"::"No Alignment";
            recCAS."Align Cost Object Dimension" := recCAS."Align Cost Object Dimension"::"No Alignment";
            recCAS.MODIFY(false);
        end;
        //HEI.42<<

        InterfaceEntryComponent.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryComponent.findset() then
            repeat
                CLEAR(RecRef);
                RecRef.OPEN(InterfaceEntryComponent."Table ID");
                RecRef.LOCKTABLE();
                InterfaceEntryCompDetail.SETCURRENTKEY("Header Entry No.", "Line Entry No.", "Table ID", Code, "Validate Priority", "Field ID");
                InterfaceEntryCompDetail.SETRANGE("Header Entry No.", InterfaceEntryComponent."Header Entry No.");
                InterfaceEntryCompDetail.SETRANGE("Line Entry No.", InterfaceEntryComponent."Line Entry No.");
                InterfaceEntryCompDetail.SETRANGE("Table ID", InterfaceEntryComponent."Table ID");
                InterfaceEntryCompDetail.SETRANGE(Code, InterfaceEntryComponent.Code);
                InterfaceEntryCompDetail.SETRANGE("Is Primary Key", true);
                if InterfaceEntryCompDetail.findset() then
                    repeat
                        FldRef := RecRef.FIELD(InterfaceEntryCompDetail."Field ID");
                        if InterfaceEntryCompDetail.Value <> '' then
                            FldRef.SETRANGE(InterfaceEntryCompDetail.Value)
                        else
                            if InterfaceEntryCompDetail."Is Master Table Related" then
                                FldRef.SETRANGE(ReturnValue);
                    until InterfaceEntryCompDetail.NEXT() = 0;

                if RecRef.HASFILTER then begin
                    if not RecRef.FINDFIRST() then
                        if InterfaceEntryCompDetail.findset() then begin
                            repeat
                                FldRef := RecRef.FIELD(InterfaceEntryCompDetail."Field ID");
                                if InterfaceEntryCompDetail.Value <> '' then
                                    SetFieldValue(FldRef, InterfaceEntryCompDetail.Value)
                                else
                                    if InterfaceEntryCompDetail."Is Master Table Related" then
                                        SetFieldValue(FldRef, ReturnValue);
                            until InterfaceEntryCompDetail.NEXT() = 0;

                            //>> HEI.38
                            if InterfaceEntryHeader."Interface Code" = GeneralInterfaceSetup."Vendor Bank Interface" then
                                if CheckVendBankAccMarkforDeletion(InterfaceEntryCompDetail, InterfaceEntryComponent) then begin
                                    MarkForDeletionFieldRef := RecRef.FIELD(50011);
                                    MarkForDeletionFieldRef.VALUE(true);
                                end;
                            //<< HEI.38
                            RecRef.INSERT(true);
                        end;
                end else begin
                    RecRef.INSERT(true);
                    //Hei.11>>
                    if InterfaceEntryHeader."Interface Code" = GeneralInterfaceSetup."Material Interface" then begin
                        CLEAR(ItemNo);
                        ItemNoFieldRef := RecRef.FIELD(1);
                        ItemNo := ItemNoFieldRef.VALUE;
                    end;
                    ////Hei.11<<
                    if InterfaceEntryComponent."Table Is Master Data" then begin
                        Key := RecRef.KEYINDEX(1);
                        if Key.FIELDCOUNT = 1 then begin
                            FldRef := Key.FIELDINDEX(1);
                            ReturnValue := FldRef.VALUE;
                        end;
                    end;
                end;

                InterfaceEntryCompDetail.SETRANGE("Is Primary Key", false);
                if InterfaceEntryCompDetail.findset() then begin
                    repeat
                        //HEI.11>>
                        if InterfaceEntryHeader."Interface Code" = GeneralInterfaceSetup."Material Interface" then begin
                            if (InterfaceEntryCompDetail."Table ID" = DATABASE::Item) and (InterfaceEntryCompDetail."Field ID" in [5425, 5426, 2014426, 2014427]) then begin
                                if (InterfaceEntryCompDetail.Value <> '') and (ItemNo <> '') then
                                    if not ItemUnitofMeasure.GET(ItemNo, InterfaceEntryCompDetail.Value) then begin
                                        ItemUnitofMeasure.INIT();
                                        ItemUnitofMeasure.VALIDATE("Item No.", ItemNo);
                                        ItemUnitofMeasure.VALIDATE(Code, InterfaceEntryCompDetail.Value);
                                        ItemUnitofMeasure.INSERT(true);
                                    end;
                            end;
                        end;
                        //HEI.11<<
                        //>> HEI.38
                        if InterfaceEntryHeader."Interface Code" = GeneralInterfaceSetup."Vendor Bank Interface" then
                            if CheckVendBankAccMarkforDeletion(InterfaceEntryCompDetail, InterfaceEntryComponent) then begin
                                MarkForDeletionFieldRef := RecRef.FIELD(50011);
                                MarkForDeletionFieldRef.VALUE(true);
                            end;
                        //<< HEI.38
                        FldRef := RecRef.FIELD(InterfaceEntryCompDetail."Field ID");
                        SetFieldValue(FldRef, InterfaceEntryCompDetail.Value);
                    //HEI.57>>
                    /*
                    //HEI.55>>
                    IF InterfaceEntryCompDetail."Table ID"=23 THEN BEGIN
                      VendorCodeFieldRef:=RecRef.FIELD(1);
                      VendorCode:=VendorCodeFieldRef.VALUE;
                      //ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::Vendor,VendorCode,FALSE,); //HEI.56
                      VendorGlobalDeleteFieldRef := RecRef.FIELD(50007); //HEI.56
                      VendorGlobalDelete := VendorGlobalDeleteFieldRef.VALUE; //HEI.56
                      ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::Vendor,VendorCode,FALSE,VendorGlobalDelete); //HEI.56
                    END;
                    //HEI.55<<
                    */
                    //<<HEI.57
                    until InterfaceEntryCompDetail.NEXT() = 0;
                    //HEI.57>>
                    if InterfaceEntryComponent."Table ID" = 23 then begin
                        VendorCodeFieldRef := RecRef.FIELD(1);
                        VendorCode := VendorCodeFieldRef.VALUE;
                        VendorGlobalDeleteFieldRef := RecRef.FIELD(50007);
                        VendorGlobalDelete := VendorGlobalDeleteFieldRef.VALUE;
                        ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::Vendor, VendorCode, false, VendorGlobalDelete);
                    end;
                    //HEI.57<<
                    RecRef.MODIFY(true);
                end;
                //HEI.48>>
                if InterfaceEntryHeader."Interface Code" = GeneralInterfaceSetup."Customer Interface" then begin
                    InterfaceEntryComponent2.RESET();
                    InterfaceEntryComponent2.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                    if InterfaceEntryComponent2.FINDFIRST() then begin
                        if RecRef.NUMBER = InterfaceEntryComponent2."Table ID" then begin
                            InterfaceEntryCompDetail3.RESET();
                            InterfaceEntryCompDetail3.SETRANGE("Header Entry No.", InterfaceEntryComponent2."Header Entry No.");
                            InterfaceEntryCompDetail3.SETRANGE("Line Entry No.", InterfaceEntryComponent2."Line Entry No.");
                            InterfaceEntryCompDetail3.SETRANGE("Table ID", InterfaceEntryComponent2."Table ID");
                            InterfaceEntryCompDetail3.SETRANGE(Code, InterfaceEntryComponent2.Code);
                            InterfaceEntryCompDetail3.SETRANGE("Field ID", 7);
                            if InterfaceEntryCompDetail3.FINDFIRST() then begin
                                FldRef := RecRef.FIELD(InterfaceEntryCompDetail3."Field ID");
                                CLEAR(CityNameVar);
                                CLEAR(CityName);
                                CityNameVar := FldRef.VALUE;
                                CityName := CityNameVar;
                                if InterfaceEntryCompDetail3.Value <> CityName then begin
                                    SetFieldValue(FldRef, InterfaceEntryCompDetail3.Value);
                                    RecRef.MODIFY(true);
                                end;
                            end;
                        end;
                    end;
                end;
            //HEI.48<<
            until InterfaceEntryComponent.NEXT() = 0;

        //HEI.09>>

        if SimulateMode and (InterfaceEntryHeader."Interface Code" = GeneralInterfaceSetup."Customer Interface") then begin
            InterfaceEntryCompDetail2.RESET();
            InterfaceEntryCompDetail2.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
            if InterfaceEntryCompDetail2.findset() then
                repeat
                    //HeinekenGlobal.T50012OnAfterInsert(InterfaceEntryCompDetail2);  // BC Upgrade NANDIS03
                    HeinekenInterfaceBCUpgrade.T50012OnAfterInsert(InterfaceEntryCompDetail2);  // BC Upgrade NANDIS03 - Added as this function is now available in Inerface extension under CU "HeinekenInterfaceBCUpgrade"
                until InterfaceEntryCompDetail2.NEXT() = 0;
        end;
        //HEI.09<<

        //MV disable Cost Center Auto Aligmemt in SimulateMode
        //HEI.42>>
        if SimulateMode and recCAS.GET() then begin
            recCAS."Align Cost Center Dimension" := vAlignCostCenterDimension;
            recCAS."Align Cost Object Dimension" := vAlignCostObjectDimension;
            recCAS.MODIFY(false);
        end;
        //HEI.42<<

        if SimulateMode then
            ERROR(SimulateModeErr);

    end;

    procedure CreateManualInterfaceEntries(var TempInterfaceEntryCompDetail: Record "Interface Entry Comp.DetailINT"; InterfaceCode: Code[20]);
    var
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        InterfaceEntryCompDetail: Record "Interface Entry Comp.DetailINT";
        TempKeyFldId: Record "Integer" temporary;
        InboundInterfaceProcessing: Codeunit "Inbound Interface Processing";
        RecRef: RecordRef;
        FldRef: FieldRef;
        "Key": KeyRef;
        i: Integer;
    begin
        TempInterfaceEntryCompDetail.RESET();
        if TempInterfaceEntryCompDetail.findset() then begin
            CLEAR(RecRef);
            CLEAR(FldRef);
            CLEAR(Key);
            TempKeyFldId.RESET();
            TempKeyFldId.DELETEALL();
            RecRef.OPEN(TempInterfaceEntryCompDetail."Table ID");
            Key := RecRef.KEYINDEX(1);
            for i := 1 to Key.FIELDCOUNT do begin
                FldRef := Key.FIELDINDEX(i);
                CLEAR(TempKeyFldId);
                TempKeyFldId.Number := FldRef.NUMBER;
                TempKeyFldId.INSERT();
            end;
            RecRef.CLOSE();

            CLEAR(InterfaceEntryHeader);
            InterfaceEntryHeader."Interface Code" := InterfaceCode;
            InterfaceEntryHeader.Direction := InterfaceEntryHeader.Direction::Inbound;
            InterfaceEntryHeader."Sync. Date" := CURRENTDATETIME;
            InterfaceEntryHeader.Status := InterfaceEntryHeader.Status::Pending;
            InterfaceEntryHeader."Source Type" := TempInterfaceEntryCompDetail."Table ID";
            InterfaceEntryHeader."Source No." := TempInterfaceEntryCompDetail.Value;
            InterfaceEntryHeader.INSERT();

            CLEAR(InterfaceEntryLine);
            InterfaceEntryLine."Header Entry No." := InterfaceEntryHeader."Entry No.";
            InterfaceEntryLine."Entry No." := 1;
            InterfaceEntryLine.INSERT();

            CLEAR(InterfaceEntryComponent);
            InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
            InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
            InterfaceEntryComponent."Table ID" := TempInterfaceEntryCompDetail."Table ID";
            InterfaceEntryComponent.Code := '1';
            InterfaceEntryComponent.INSERT();

            repeat
                CLEAR(InterfaceEntryCompDetail);
                InterfaceEntryCompDetail."Header Entry No." := InterfaceEntryComponent."Header Entry No.";
                InterfaceEntryCompDetail."Line Entry No." := InterfaceEntryComponent."Line Entry No.";
                InterfaceEntryCompDetail."Table ID" := InterfaceEntryComponent."Table ID";
                InterfaceEntryCompDetail.Code := InterfaceEntryComponent.Code;
                InterfaceEntryCompDetail."Field ID" := TempInterfaceEntryCompDetail."Field ID";
                InterfaceEntryCompDetail."Record No." := 1;
                InterfaceEntryCompDetail.Value := TempInterfaceEntryCompDetail.Value;
                InterfaceEntryCompDetail."Validate Only" := TempInterfaceEntryCompDetail."Validate Only";
                if TempKeyFldId.GET(InterfaceEntryCompDetail."Field ID") then
                    InterfaceEntryCompDetail."Is Primary Key" := true;
                InterfaceEntryCompDetail.INSERT();
            until TempInterfaceEntryCompDetail.NEXT() = 0;

            InboundInterfaceProcessing.RUN(InterfaceEntryHeader);
            SetInterfaceProcessed(InterfaceEntryHeader);
            LogInterfaceEntries(InterfaceEntryHeader);
            DeleteInterfaceEntries(InterfaceEntryHeader);
        end;
    end;

    procedure CreateErrorResponseEntry(InterfaceEntryHeaderIn: Record "Interface Entry Header INT"; ErrorMessage: Text);
    begin
        GetGeneralInterfaceSetup();
        GetSRMInterfaceSetup(); //HEI.29
        case InterfaceEntryHeaderIn."Interface Code" of
            //HEI.29>>
            SRMInterfaceSetup."Contract Confirm. Interface":
                SRMInterfaceManagement.CreateInterfaceConfirmationError(InterfaceEntryHeaderIn, ErrorMessage, SRMInterfaceSetup."Contract Call-Off Interface");
            SRMInterfaceSetup."PO Creation Interface":
                SRMInterfaceManagement.CreateInterfaceConfirmationError(InterfaceEntryHeaderIn, ErrorMessage, SRMInterfaceSetup."PO Confirmation Interface");
            SRMInterfaceSetup."GR Creation Interface":
                SRMInterfaceManagement.CreateInterfaceConfirmationError(InterfaceEntryHeaderIn, ErrorMessage, SRMInterfaceSetup."GR Confirmation Interface");
        //HEI.29<<
        end;
        //HEI.06>>
        GetEskerInterfaceSetup();

        case InterfaceEntryHeaderIn."Interface Code" of
            EskerInterfaceSetup."Esker InvPosting Interf":
                EskerInterfaceManag.CreateInterfaceConfirmationError(InterfaceEntryHeaderIn, ErrorMessage, EskerInterfaceSetup."Esker InvConfirm Interf");
        end;

        //HEI.06<<
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

    // BC Upgrade NANDIS03 - Blocked the parameter as Temp Blob is now of Codeunit  >>
    //procedure SetBlobFieldValue(var FieldRef: FieldRef; var TempBlob: Record TempBlob);
    procedure SetBlobFieldValue(var FieldRef: FieldRef; var TempBlob: Codeunit "Temp Blob");
    // BC Upgrade NANDIS03 - Blocked the parameter as Temp Blob is now of Codeunit <<
    var
        InputStream: InStream;
        OutputStream: OutStream;
    begin
        // BC Upgrade NANDIS03 - Blocked as TempBlob CU functionalities to be used >>
        //FieldRef.VALUE := TempBlob.Blob;
        FieldRef.VALUE := TempBlob.HasValue();
        // BC Upgrade NANDIS03 - Blocked as TempBlob CU functionalities to be used <<
    end;

    local procedure TruncateValueToFieldLength(FieldRef: FieldRef; var Value: Text[250]);
    var
        "Field": Record "Field";
    begin
        EVALUATE(Field.Type, FORMAT(FieldRef.TYPE));
        if Field.Type in [Field.Type::Code, Field.Type::Text] then
            Value := COPYSTR(Value, 1, FieldRef.LENGTH);
    end;

    local procedure GetValue(var InterfaceEntryCompDetail: Record "Interface Entry Comp.DetailINT"; RecRef: RecordRef; FieldID: Integer; FieldName: Text): Text[250];
    var
        Value: Text[250];
    begin
        TryGetValue(InterfaceEntryCompDetail, RecRef, FieldID, FieldName, Value);

        exit(Value);
    end;

    [TryFunction]
    local procedure TryGetValue(var InterfaceEntryCompDetail: Record "Interface Entry Comp.DetailINT"; RecRef: RecordRef; FieldID: Integer; FieldName: Text; var Value: Text[250]);
    begin
        Value := '';
        InterfaceEntryCompDetail.SETRANGE("Field ID", FieldID);

        if not InterfaceEntryCompDetail.FINDFIRST() then
            ERROR(NotFoundErr, FieldName, RecRef.CAPTION, InterfaceEntryCompDetail.TABLECAPTION);

        Value := InterfaceEntryCompDetail.Value;
    end;

    // BC Upgrade NANDIS03 - restructured >>
    procedure SaveXMLToTempBlob(var TempBlobCU: Codeunit "Temp Blob"; var XMLBuffer: Record "XML Buffer")
    var
        TempXMLBuffer: Record "XML Buffer" temporary;
        TempAttributeXMLBuffer: Record "XML Buffer" temporary;
        XmlDoc: XmlDocument;
        RootElement: XmlElement;
        OutputStream: OutStream;
    begin
        // Copy the XML buffer to a temporary record
        TempXMLBuffer.CopyImportFrom(XMLBuffer);

        // Create the XML document and root element
        XmlDoc := XmlDocument.Create();
        RootElement := XmlElement.Create(TempXMLBuffer.GetElementName());
        XmlDoc.Add(RootElement);

        // Add attributes to the root element
        if TempXMLBuffer.FindAttributes(TempAttributeXMLBuffer) then
            repeat
                RootElement.SetAttribute(TempAttributeXMLBuffer.Name, TempAttributeXMLBuffer.Value);
            until TempAttributeXMLBuffer.Next() = 0;

        // Add child elements recursively
        SaveChildElements(TempXMLBuffer, RootElement);

        // Create OutStream using Temp Blob codeunit
        TempBlobCU.CreateOutStream(OutputStream);
        XmlDoc.WriteTo(OutputStream);
    end;

    procedure SaveChildElements(var TempParentElementXMLBuffer: Record "XML Buffer" temporary; ParentElement: XmlElement)
    var
        TempElementXMLBuffer: Record "XML Buffer" temporary;
        ChildElement: XmlElement;
    begin
        if TempParentElementXMLBuffer.FindChildElements(TempElementXMLBuffer) then
            repeat
                ChildElement := XmlElement.Create(TempElementXMLBuffer.GetElementName());
                if TempElementXMLBuffer.Value <> '' then
                    ChildElement.Add(XmlText.Create(TempElementXMLBuffer.Value));
                ParentElement.Add(ChildElement);
                SaveAttributes(TempElementXMLBuffer, ChildElement);
                SaveChildElements(TempElementXMLBuffer, ChildElement);
            until TempElementXMLBuffer.Next() = 0;
    end;

    procedure SaveAttributes(var TempParentElementXMLBuffer: Record "XML Buffer" temporary; Element: XmlElement)
    var
        TempAttributeXMLBuffer: Record "XML Buffer" temporary;
    begin
        if TempParentElementXMLBuffer.FindAttributes(TempAttributeXMLBuffer) then
            repeat
                Element.SetAttribute(TempAttributeXMLBuffer.Name, TempAttributeXMLBuffer.Value);
            until TempAttributeXMLBuffer.Next() = 0;
    end;
    // BC Upgrade NANDIS03 - SaveAttributes restructured <<

    //>>BC Upgrade VAMSIU01 Begin
    //Creating the Procedure
    procedure SaveXMLBufferToTempBlob(var TempBlob: Codeunit "Temp Blob"; var TempXMLBuffer: Record "XML Buffer" temporary)
    var
        OutStr: OutStream;
    begin
        TempBlob.CreateOutStream(OutStr);
        TempXMLBuffer.Save(TempBlob);
    end;

    //<<BC Upgrade VAMSIU01 End

    procedure SetSimulateMode(NewSimulateMode: Boolean);
    begin
        SimulateMode := NewSimulateMode;
    end;

    procedure SetInterfaceSourceNo(InterfaceEntryHeaderToProcess: Record "Interface Entry Header INT"; SourceNo: Code[20]);
    var
        InterfaceEntryHeader: Record "Interface Entry Header INT";
    begin
        InterfaceEntryHeader.GET(InterfaceEntryHeaderToProcess."Entry No.");
        InterfaceEntryHeader."Source No." := SourceNo;
        InterfaceEntryHeader.MODIFY();
    end;

    procedure SetInterfaceProcessed(InterfaceEntryHeaderToProcess: Record "Interface Entry Header INT");
    var
        InterfaceEntryHeader: Record "Interface Entry Header INT";
    begin
        //<< HEI.22
        // InterfaceEntryHeader.GET(InterfaceEntryHeaderToProcess."Entry No.");
        if not InterfaceEntryHeader.GET(InterfaceEntryHeaderToProcess."Entry No.") then
            exit;
        //>> HEI.22
        InterfaceEntryHeader.Status := InterfaceEntryHeader.Status::Processed;
        InterfaceEntryHeader.MODIFY();

        OnAfterSetInterfaceProcessed(InterfaceEntryHeader);  //HEI.32
    end;

    procedure SetInterfaceError(InterfaceEntryHeaderToError: Record "Interface Entry Header INT"; ErrorMessage: Text);
    var
        InterfaceEntryHeader: Record "Interface Entry Header INT";
    begin
        //<< HEI.22
        // InterfaceEntryHeader.GET(InterfaceEntryHeaderToError."Entry No.");
        if not InterfaceEntryHeader.GET(InterfaceEntryHeaderToError."Entry No.") then
            exit;
        //>> HEI.22

        InterfaceEntryHeader.Status := InterfaceEntryHeader.Status::Error;
        InterfaceEntryHeader."Error Message" := COPYSTR(ErrorMessage, 1, MAXSTRLEN(InterfaceEntryHeader."Error Message"));
        InterfaceEntryHeader.MODIFY();

        OnAfterSetInterfaceError(InterfaceEntryHeader);  //HEI.23
    end;

    procedure LogInterfaceEntries(InterfaceEntryHeaderToLog: Record "Interface Entry Header INT");
    var
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        InterfaceEntryCompDetail: Record "Interface Entry Comp.DetailINT";
        InterfaceLogHeader: Record "Interface Log Header INT";
        InterfaceLogLine: Record "Interface Log Line INT";
        InterfaceLogComponent: Record "Interface Log Component INT";
        InterfaceLogCompDetail: Record "Interface Log Comp. Detail INT";
    //PACElectronicInvoiceMgt: Codeunit "PAC Electronic Invoice Mgt.";  // BC Upgrade NANDIS03 - PAC Interface is out of scope
    begin
        //<< HEI.22
        // InterfaceEntryHeader.GET(InterfaceEntryHeaderToLog."Entry No.");
        if not InterfaceEntryHeader.GET(InterfaceEntryHeaderToLog."Entry No.") then
            exit;
        //>> HEI.22
        if InterfaceEntryHeader.Status <> InterfaceEntryHeader.Status::Error then
            InterfaceEntryHeader.Status := InterfaceEntryHeader.Status::Processed;
        InterfaceEntryHeader."Archive Date" := CURRENTDATETIME;
        InterfaceEntryHeader.MODIFY();

        InterfaceLogHeader.LOCKTABLE();
        CLEAR(InterfaceLogHeader);
        InterfaceEntryHeader.CALCFIELDS(Notes);
        InterfaceLogHeader.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceLogHeader."Interface Entry No." := InterfaceEntryHeader."Entry No.";
        InterfaceLogHeader.INSERT();

        //<<HEI.35
        InterfaceEntryLine.RESET();
        InterfaceEntryLine.SETCURRENTKEY("Header Entry No.");
        //>>HEI.35
        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        //<<HEI.35
        InterfaceEntryLine.SETAUTOCALCFIELDS(InterfaceEntryLine.Notes);
        //>>HEI.35
        if InterfaceEntryLine.findset() then
            repeat
                CLEAR(InterfaceLogLine);
                //<<HEI.35
                //InterfaceEntryLine.CALCFIELDS(Notes);
                //>>HEI.35
                InterfaceLogLine.TRANSFERFIELDS(InterfaceEntryLine);
                InterfaceLogLine."Header Entry No." := InterfaceLogHeader."Entry No.";
                InterfaceLogLine.INSERT();
            until InterfaceEntryLine.NEXT() = 0;
        //<<HEI.35
        InterfaceEntryLine.SETAUTOCALCFIELDS();
        //>>HEI.35

        //<<HEI.35
        InterfaceEntryComponent.RESET();
        InterfaceEntryComponent.SETCURRENTKEY("Header Entry No.");
        //>>HEI.35
        InterfaceEntryComponent.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryComponent.findset() then
            repeat
                CLEAR(InterfaceLogComponent);
                InterfaceLogComponent.TRANSFERFIELDS(InterfaceEntryComponent);
                InterfaceLogComponent."Header Entry No." := InterfaceLogHeader."Entry No.";
                InterfaceLogComponent.INSERT();
            until InterfaceEntryComponent.NEXT() = 0;

        //<<HEI.35
        InterfaceEntryCompDetail.RESET();
        InterfaceEntryCompDetail.SETCURRENTKEY("Header Entry No.");
        //>>HEI.35
        InterfaceEntryCompDetail.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryCompDetail.findset() then
            repeat
                CLEAR(InterfaceLogCompDetail);
                InterfaceLogCompDetail.TRANSFERFIELDS(InterfaceEntryCompDetail);
                InterfaceLogCompDetail."Header Entry No." := InterfaceLogHeader."Entry No.";
                InterfaceLogCompDetail.INSERT();
            until InterfaceEntryCompDetail.NEXT() = 0;
        //HEI.58>>
        PostProcessUpdate_Ibecor(InterfaceEntryHeader);
        //HEI.58<<
        //PACElectronicInvoiceMgt.ProcessMendixCustomer(InterfaceLogHeader);//HEI.59  // BC Upgrade NANDIS03 - PAC Interface is out of scope
    end;

    procedure LogErrorInterfaceEntries(var InterfaceEntryHeader: Record "Interface Entry Header INT");
    begin
        if InterfaceEntryHeader.findset() then
            repeat
                LogInterfaceEntries(InterfaceEntryHeader);
                DeleteInterfaceEntries(InterfaceEntryHeader);
            until InterfaceEntryHeader.NEXT() = 0;
    end;

    procedure DeleteInterfaceEntries(InterfaceEntryHeaderToDelete: Record "Interface Entry Header INT");
    var
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        InterfaceEntryCompDetail: Record "Interface Entry Comp.DetailINT";
    begin
        //<< HEI.22
        // InterfaceEntryHeader.GET(InterfaceEntryHeaderToDelete."Entry No.");
        if not InterfaceEntryHeader.GET(InterfaceEntryHeaderToDelete."Entry No.") then
            exit;
        //>> HEI.22

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        InterfaceEntryLine.DELETEALL();

        InterfaceEntryComponent.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        InterfaceEntryComponent.DELETEALL();

        InterfaceEntryCompDetail.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        InterfaceEntryCompDetail.DELETEALL();

        InterfaceEntryHeader.DELETE();
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

    [EventSubscriber(ObjectType::Table, Database::"Interface Log Header INT", 'OnAfterInsertEvent', '', false, false)]
    local procedure DeleteReferenceData(var Rec: Record "Interface Log Header INT"; RunTrigger: Boolean);
    var
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceEntryCompDetail: Record "Interface Entry Comp.DetailINT";
        InterfaceEntryCompDetail2: Record "Interface Entry Comp.DetailINT";
        DefaultDimension: Record "Default Dimension";
        DefaultDimension2: Record "Default Dimension";
        OrderAddress: Record "Order Address";
        OrderAddress2: Record "Order Address";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        ItemUnitofMeasure2: Record "Item Unit of Measure";
        ItemTranslation: Record "Item Translation";
        ItemTranslation2: Record "Item Translation";
        // BC Upgrade NANDIS03 - Item Cross Reference is now replaced with Item Reference table in BC >>
        // ItemCrossReference: Record "Item Cross Reference";
        // ItemCrossReference2: Record "Item Cross Reference";
        ItemCrossReference: Record "Item Reference";
        ItemCrossReference2: Record "Item Reference";
        // BC Upgrade NANDIS03 - Item Cross Reference is now replaced with Item Reference table in BC <<
        StockkeepingUnit: Record "Stockkeeping Unit";
        StockkeepingUnit2: Record "Stockkeeping Unit";
        MarkToDelete: Boolean;
    begin
        GetGeneralInterfaceSetup();
        if not (Rec."Interface Code" in [GeneralInterfaceSetup."Vendors Global Interface",
                                         GeneralInterfaceSetup."Vend. Local Purch. Interface",
                                         GeneralInterfaceSetup."Items Global Interface",
                                         GeneralInterfaceSetup."Items Local Site Interface",
                                         GeneralInterfaceSetup."Material Interface",//HEI.11
                                         GeneralInterfaceSetup."Vendor Interface"])//HEI.13)
        then
            exit;

        if Rec."Source No." = '' then
            exit;

        case Rec."Interface Code" of
            GeneralInterfaceSetup."Vendors Global Interface",
            GeneralInterfaceSetup."Vendor Interface"://HEI.13
                begin
                    InterfaceEntryHeader.SETRANGE("Interface Code", Rec."Interface Code");
                    InterfaceEntryHeader.SETRANGE("Source No.", Rec."Source No.");
                    InterfaceEntryHeader.FINDLAST();
                    InterfaceEntryCompDetail.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                    InterfaceEntryCompDetail.SETRANGE("Table ID", DATABASE::"Default Dimension");
                    DefaultDimension.LOCKTABLE();
                    DefaultDimension.SETRANGE("Table ID", DATABASE::Vendor);
                    DefaultDimension.SETRANGE("No.", Rec."Source No.");
                    DefaultDimension.SETRANGE("Dimension Code", GeneralInterfaceSetup."Trading Partner Dim. Code");
                    if DefaultDimension.findset() then
                        repeat
                            MarkToDelete := false;
                            InterfaceEntryCompDetail.SETRANGE("Field ID", DefaultDimension.FIELDNO("Dimension Code"));
                            InterfaceEntryCompDetail.SETRANGE(Value, DefaultDimension."Dimension Code");
                            if InterfaceEntryCompDetail.ISEMPTY then
                                MarkToDelete := true
                            else begin
                                if InterfaceEntryCompDetail.findset() then
                                    repeat
                                        InterfaceEntryCompDetail2.COPYFILTERS(InterfaceEntryCompDetail);
                                        InterfaceEntryCompDetail2.SETRANGE(Code, InterfaceEntryCompDetail.Code);
                                        InterfaceEntryCompDetail2.SETRANGE("Field ID", DefaultDimension.FIELDNO("Dimension Value Code"));
                                        InterfaceEntryCompDetail2.SETRANGE(Value, DefaultDimension."Dimension Value Code");
                                        if InterfaceEntryCompDetail2.ISEMPTY then
                                            MarkToDelete := true
                                        else
                                            MarkToDelete := false;
                                    until (InterfaceEntryCompDetail.NEXT() = 0) or (not MarkToDelete);
                            end;
                            if MarkToDelete then begin
                                if DefaultDimension2.GET(DefaultDimension."Table ID", DefaultDimension."No.", DefaultDimension."Dimension Code") then
                                    DefaultDimension2.DELETE(true);
                            end;
                        until DefaultDimension.NEXT() = 0;
                    //HEI.13>>
                    case Rec."Interface Code" of
                        GeneralInterfaceSetup."Vendor Interface":
                            begin
                                InterfaceEntryHeader.SETRANGE("Interface Code", Rec."Interface Code");
                                InterfaceEntryHeader.SETRANGE("Source No.", Rec."Source No.");
                                InterfaceEntryHeader.FINDLAST();
                                InterfaceEntryCompDetail.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                                InterfaceEntryCompDetail.SETRANGE("Table ID", DATABASE::"Order Address");
                                InterfaceEntryCompDetail.SETRANGE("Field ID", OrderAddress.FIELDNO(Code));
                                OrderAddress.LOCKTABLE();
                                OrderAddress.SETRANGE("Vendor No.", Rec."Source No.");
                                if OrderAddress.findset() then
                                    repeat
                                        InterfaceEntryCompDetail.SETRANGE(Value, OrderAddress.Code);
                                        if InterfaceEntryCompDetail.ISEMPTY then begin
                                            if OrderAddress2.GET(OrderAddress."Vendor No.", OrderAddress.Code) then
                                                OrderAddress2.DELETE(true);
                                        end;
                                    until OrderAddress.NEXT() = 0;
                            end;
                    end;
                    //HEI.13<<
                end;
            GeneralInterfaceSetup."Vend. Local Purch. Interface":
                begin
                    InterfaceEntryHeader.SETRANGE("Interface Code", Rec."Interface Code");
                    InterfaceEntryHeader.SETRANGE("Source No.", Rec."Source No.");
                    InterfaceEntryHeader.FINDLAST();
                    InterfaceEntryCompDetail.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                    InterfaceEntryCompDetail.SETRANGE("Table ID", DATABASE::"Order Address");
                    InterfaceEntryCompDetail.SETRANGE("Field ID", OrderAddress.FIELDNO(Code));
                    OrderAddress.LOCKTABLE();
                    OrderAddress.SETRANGE("Vendor No.", Rec."Source No.");
                    if OrderAddress.findset() then
                        repeat
                            InterfaceEntryCompDetail.SETRANGE(Value, OrderAddress.Code);
                            if InterfaceEntryCompDetail.ISEMPTY then begin
                                if OrderAddress2.GET(OrderAddress."Vendor No.", OrderAddress.Code) then
                                    OrderAddress2.DELETE(true);
                            end;
                        until OrderAddress.NEXT() = 0;
                end;
            GeneralInterfaceSetup."Items Global Interface",
            GeneralInterfaceSetup."Material Interface"://HEI.11
                begin
                    InterfaceEntryHeader.SETRANGE("Interface Code", Rec."Interface Code");
                    InterfaceEntryHeader.SETRANGE("Source No.", Rec."Source No.");
                    InterfaceEntryHeader.FINDLAST();
                    //item UoM
                    InterfaceEntryCompDetail.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                    InterfaceEntryCompDetail.SETRANGE("Table ID", DATABASE::"Item Unit of Measure");
                    InterfaceEntryCompDetail.SETRANGE("Field ID", ItemUnitofMeasure.FIELDNO(Code));
                    ItemUnitofMeasure.LOCKTABLE();
                    ItemUnitofMeasure.SETRANGE("Item No.", Rec."Source No.");
                    if ItemUnitofMeasure.findset() then
                        repeat
                            InterfaceEntryCompDetail.SETRANGE(Value, ItemUnitofMeasure.Code);
                            if InterfaceEntryCompDetail.ISEMPTY then begin
                                if ItemUnitofMeasure2.GET(ItemUnitofMeasure."Item No.", ItemUnitofMeasure.Code) then
                                    ItemUnitofMeasure2.DELETE(true);
                            end;
                        until ItemUnitofMeasure.NEXT() = 0;
                    //item translations
                    InterfaceEntryCompDetail.RESET();
                    InterfaceEntryCompDetail.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                    InterfaceEntryCompDetail.SETRANGE("Table ID", DATABASE::"Item Translation");
                    InterfaceEntryCompDetail.SETRANGE("Field ID", ItemTranslation.FIELDNO("Language Code"));
                    ItemTranslation.LOCKTABLE();
                    ItemTranslation.SETRANGE("Item No.", Rec."Source No.");
                    if ItemTranslation.findset() then
                        repeat
                            InterfaceEntryCompDetail.SETRANGE(Value, ItemTranslation."Language Code");
                            if InterfaceEntryCompDetail.ISEMPTY then begin
                                if ItemTranslation2.GET(ItemTranslation."Item No.", ItemTranslation."Variant Code", ItemTranslation."Language Code") then
                                    ItemTranslation2.DELETE(true);
                            end;
                        until ItemTranslation.NEXT() = 0;
                    //item cross references
                    InterfaceEntryCompDetail.RESET();
                    InterfaceEntryCompDetail.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                    // BC Upgrade NANDIS03 >>
                    //InterfaceEntryCompDetail.SETRANGE("Table ID", DATABASE::"Item Cross Reference");
                    InterfaceEntryCompDetail.SETRANGE("Table ID", DATABASE::"Item Reference");
                    // BC Upgrade NANDIS03 <<
                    ItemCrossReference.LOCKTABLE();
                    ItemCrossReference.SETRANGE("Item No.", Rec."Source No.");
                    if ItemCrossReference.findset() then
                        repeat
                            MarkToDelete := false;
                            InterfaceEntryCompDetail.SETRANGE("Field ID", ItemCrossReference.FIELDNO("Unit of Measure"));
                            InterfaceEntryCompDetail.SETRANGE(Value, ItemCrossReference."Unit of Measure");
                            if InterfaceEntryCompDetail.ISEMPTY then
                                MarkToDelete := true
                            else begin
                                if InterfaceEntryCompDetail.findset() then
                                    repeat
                                        InterfaceEntryCompDetail2.COPYFILTERS(InterfaceEntryCompDetail);
                                        InterfaceEntryCompDetail2.SETRANGE(Code, InterfaceEntryCompDetail.Code);
                                        // BC Upgrade NANDIS03 - Blocked as fields names changed in BC compared to Navision >>
                                        // InterfaceEntryCompDetail2.SETRANGE("Field ID", ItemCrossReference.FIELDNO("Cross-Reference No."));
                                        // InterfaceEntryCompDetail2.SETRANGE(Value, ItemCrossReference."Cross-Reference No.");
                                        InterfaceEntryCompDetail2.SETRANGE("Field ID", ItemCrossReference.FIELDNO("Reference No."));
                                        InterfaceEntryCompDetail2.SETRANGE(Value, ItemCrossReference."Reference No.");
                                        // BC Upgrade NANDIS03 - Blocked as fields names changed in BC compared to Navision <<
                                        if InterfaceEntryCompDetail2.ISEMPTY then
                                            MarkToDelete := true
                                        else
                                            MarkToDelete := false;
                                    until (InterfaceEntryCompDetail.NEXT() = 0) or (not MarkToDelete);
                            end;
                            if MarkToDelete then begin
                                // BC Upgrade NANDIS03 - Blocked as fields names changed in BC compared to Navision >>
                                // if ItemCrossReference2.GET(ItemCrossReference."Item No.", ItemCrossReference."Variant Code",
                                //                            ItemCrossReference."Unit of Measure", ItemCrossReference."Cross-Reference Type",
                                //                            ItemCrossReference."Cross-Reference Type No.", ItemCrossReference."Cross-Reference No.")
                                if ItemCrossReference2.GET(ItemCrossReference."Item No.", ItemCrossReference."Variant Code",
                                                           ItemCrossReference."Unit of Measure", ItemCrossReference."Reference Type",
                                                           ItemCrossReference."Reference Type No.", ItemCrossReference."Reference No.")
                                // BC Upgrade NANDIS03 - Blocked as fields names changed in BC compared to Navision <<
                                then
                                    ItemCrossReference2.DELETE(true);
                            end;
                        until ItemCrossReference.NEXT() = 0;
                    //HEI.11>>
                    case Rec."Interface Code" of
                        GeneralInterfaceSetup."Material Interface":
                            begin
                                InterfaceEntryHeader.SETRANGE("Interface Code", Rec."Interface Code");
                                InterfaceEntryHeader.SETRANGE("Source No.", Rec."Source No.");
                                InterfaceEntryHeader.FINDLAST();
                                InterfaceEntryCompDetail.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                                InterfaceEntryCompDetail.SETRANGE("Table ID", DATABASE::"Stockkeeping Unit");
                                InterfaceEntryCompDetail.SETRANGE("Field ID", StockkeepingUnit.FIELDNO("Item No."));
                                if not InterfaceEntryCompDetail.FINDFIRST() then
                                    exit;
                                StockkeepingUnit.LOCKTABLE();
                                StockkeepingUnit.SETRANGE("Item No.", InterfaceEntryCompDetail.Value);
                                InterfaceEntryCompDetail.SETRANGE("Field ID", StockkeepingUnit.FIELDNO("Location Code"));
                                if StockkeepingUnit.findset() then
                                    repeat
                                        InterfaceEntryCompDetail.SETRANGE(Value, StockkeepingUnit."Location Code");
                                        if InterfaceEntryCompDetail.ISEMPTY then begin
                                            if StockkeepingUnit2.GET(StockkeepingUnit."Location Code", StockkeepingUnit."Item No.", StockkeepingUnit."Variant Code") then
                                                StockkeepingUnit2.DELETE(true);
                                        end;
                                    until StockkeepingUnit.NEXT() = 0;
                            end;
                    end;
                    //HEI.11<<
                end;
            GeneralInterfaceSetup."Items Local Site Interface":
                begin
                    InterfaceEntryHeader.SETRANGE("Interface Code", Rec."Interface Code");
                    InterfaceEntryHeader.SETRANGE("Source No.", Rec."Source No.");
                    InterfaceEntryHeader.FINDLAST();
                    InterfaceEntryCompDetail.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                    InterfaceEntryCompDetail.SETRANGE("Table ID", DATABASE::"Stockkeeping Unit");
                    InterfaceEntryCompDetail.SETRANGE("Field ID", StockkeepingUnit.FIELDNO("Item No."));
                    if not InterfaceEntryCompDetail.FINDFIRST() then
                        exit;
                    StockkeepingUnit.LOCKTABLE();
                    StockkeepingUnit.SETRANGE("Item No.", InterfaceEntryCompDetail.Value);
                    InterfaceEntryCompDetail.SETRANGE("Field ID", StockkeepingUnit.FIELDNO("Location Code"));
                    if StockkeepingUnit.findset() then
                        repeat
                            InterfaceEntryCompDetail.SETRANGE(Value, StockkeepingUnit."Location Code");
                            if InterfaceEntryCompDetail.ISEMPTY then begin
                                if StockkeepingUnit2.GET(StockkeepingUnit."Location Code", StockkeepingUnit."Item No.", StockkeepingUnit."Variant Code") then
                                    StockkeepingUnit2.DELETE(true);
                            end;
                        until StockkeepingUnit.NEXT() = 0;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 472, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyJobQueueEntry(var Rec: Record "Job Queue Entry"; var xRec: Record "Job Queue Entry"; RunTrigger: Boolean);
    var
        ScheduledTask: Record "Scheduled Task";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        GetGeneralInterfaceSetup();
        //HEI.44>>
        /*
        IF (Rec."Job Queue Category Code" = GeneralInterfaceSetup."Interface Job Queue Category") AND
           (GeneralInterfaceSetup."Interface Job Queue User ID" <> '')
        THEN
          Rec."User ID" := GeneralInterfaceSetup."Interface Job Queue User ID";
        */
        if (GeneralInterfaceSetup."Interface Job Queue User ID" <> '') then
            Rec."User ID" := GeneralInterfaceSetup."Interface Job Queue User ID";
        //HEI.44<<

        //>> HEI.31
        SalesReceivablesSetup.GET();
        if (Rec."Job Queue Category Code" = SalesReceivablesSetup."Job Queue Category Code") and
           (SalesReceivablesSetup."OTC Billing Auto JQ UserID FND" <> '')
        then
            Rec."User ID" := SalesReceivablesSetup."OTC Billing Auto JQ UserID FND";
        //<< HEI.31

        //>> HEI.27
        if Rec."Object Type to Run" = Rec."Object Type to Run"::Codeunit then begin
            if (Rec."Object ID to Run" = GeneralInterfaceSetup."Processing Codeunit ID") or //HEI 30
               (Rec."Object ID to Run" = GeneralInterfaceSetup."Outbound Process Cdu ID.") then //HEI.30
                if ScheduledTask.GET(Rec."System Task ID") then
                    if ScheduledTask."User Format ID" <> 1033 then begin
                        ScheduledTask."User Format ID" := 1033;
                        ScheduledTask.MODIFY();
                    end;
        end;
        //<< HEI.27

    end;


    [EventSubscriber(ObjectType::Table, 2000000175, 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertScheduledTask(var Rec: Record "Scheduled Task"; RunTrigger: Boolean);
    var
        User: Record User;
        JobQueueEntry: Record "Job Queue Entry";
        RecRef: RecordRef;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        GetGeneralInterfaceSetup();
        SalesReceivablesSetup.GET();  // HEI.31
        if RecRef.GET(Rec.Record) then;//Bc Upgrade SHARMP16 GAPFitChanges
        if RecRef.NUMBER = DATABASE::"Job Queue Entry" then begin
            RecRef.SETRECFILTER();
            JobQueueEntry.SETVIEW(RecRef.GETVIEW());
            if JobQueueEntry.FINDFIRST() then begin // HEI.31
                                                    //HEI.44>>
                                                    /*
                                                    IF (JobQueueEntry."Job Queue Category Code" = GeneralInterfaceSetup."Interface Job Queue Category") AND
                                                       (GeneralInterfaceSetup."Interface Job Queue User ID" <> '')
                                                    THEN BEGIN
                                                    */
                if (GeneralInterfaceSetup."Interface Job Queue User ID" <> '') then begin
                    //HEI.44<<
                    User.SETRANGE("User Name", GeneralInterfaceSetup."Interface Job Queue User ID");
                    if User.FINDFIRST() then begin
                        Rec."User ID" := User."User Security ID";
                        Rec."User Name" := User."User Name";
                    end;
                end;
                //>> HEI.31
                if (JobQueueEntry."Job Queue Category Code" = SalesReceivablesSetup."Job Queue Category Code") and
                   (SalesReceivablesSetup."OTC Billing Auto JQ UserID FND" <> '')
                then begin
                    User.SETRANGE("User Name", SalesReceivablesSetup."OTC Billing Auto JQ UserID FND");
                    if User.FINDFIRST() then begin
                        Rec."User ID" := User."User Security ID";
                        Rec."User Name" := User."User Name";
                    end;
                end;
                //<< HEI.31
            end;  // HEI.31
        end;

    end;

    //BC Upgrade VAMSIU01 - New Procedure>>
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
    //BC Upgrade VAMSIU01 - New procedure <<

    //BC Upgrade VAMSIU01 >>
    // procedure GetOutboundInterface(InterfaceSetup: Record "Interface Setup INT"; var OutboundInterface: Record "Outbound Interface INT");
    // var
    //     //ServerInstance: Record "Server Instance";  // BC Upgrade NANDIS03 - Blocked as this table is not applicable in SaaS
    //     ServerInstanceDetail: Record "Server Instance Detail";
    //     GeneralInterfaceSetup: Record "General Interface Setup INT";
    //     User: Record User;
    //     SessionEvent: Record "Session Event";
    //     ActiveSession: Record "Active Session";  // BC Upgrade NANDIS03 - Added
    //     envir: Codeunit "Environment Information";
    // begin

    //     //ServerInstance.GET(SERVICEINSTANCEID);  // BC Upgrade NANDIS03 - Blocked
    //     ActiveSession.Get(Database.ServiceInstanceId(), Database.SessionId());  // BC Upgrade NANDIS03 - Added
    //     //<<HEI.35
    //     ServerInstanceDetail.RESET();
    //     ServerInstanceDetail.SETCURRENTKEY("Server Computer Name", "Server Instance Name");
    //     //>>HEI.35
    //     // BC Upgrade NANDIS03 - Adjust code for Server Instance table >>
    //     // ServerInstanceDetail.SETRANGE("Server Computer Name", ServerInstance."Server Computer Name");
    //     // ServerInstanceDetail.SETRANGE("Server Instance Name", ServerInstance."Server Instance Name");
    //     ServerInstanceDetail.SETRANGE("Server Computer Name", ActiveSession."Server Computer Name");
    //     ServerInstanceDetail.SETRANGE("Server Instance Name", ActiveSession."Server Instance Name");
    //     // BC Upgrade NANDIS03 - Adjust code for Server Instance table <<
    //     if ServerInstanceDetail.FINDFIRST() then begin
    //         GeneralInterfaceSetup.GET();
    //         GeneralInterfaceSetup.TESTFIELD("Company Code ID");
    //         OutboundInterface.SETRANGE("Environment Code", ServerInstanceDetail."Environment Code");
    //         OutboundInterface.SETRANGE("Legal Entity Code", GeneralInterfaceSetup."Company Code ID");
    //         OutboundInterface.SETRANGE("Interface Code", InterfaceSetup.Code);
    //         SessionEvent.SETRANGE("User SID", USERSECURITYID());
    //         // BC Upgrade NANDIS03 - Adjust code for Server Instance table >>
    //         // SessionEvent.SETRANGE("Server Instance ID", ServerInstance."Server Instance ID");
    //         SessionEvent.SETRANGE("Server Instance ID", ActiveSession."Server Instance ID");
    //         // BC Upgrade NANDIS03 - Adjust code for Server Instance table <<
    //         //<<HEI.35
    //         SessionEvent.RESET();
    //         SessionEvent.SETCURRENTKEY("User ID", "Server Instance ID");
    //         //>>HEI.35
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

    local procedure GetEskerInterfaceSetup();
    begin
        //HEI.06<<
        if not EskerlInterfaceSetupRead then
            if EskerInterfaceSetup.GET() then;
        EskerlInterfaceSetupRead := true;
        //HEI.06<<
    end;

    local procedure GetEBMInterfaceSetup();
    begin
        //HEI.07>>
        if not EBMInterfaceSetupRead then
            if EBMInterfaceSetup.GET() then;
        EBMInterfaceSetupRead := true;
        //HEI.07<<
    end;

    local procedure GetCounterpointInterfaceSetup();
    begin
        //HEI.08>>
        if not CounterpointInterfaceSetupRead then
            if CounterpointInterfaceSetup.GET() then;
        CounterpointInterfaceSetupRead := true;
        //HEI.08<<
    end;

    local procedure GetFM2InterfaceSetup();
    begin
        //HEI.14>>
        if not FM2InterfaceSetupRead then
            if FM2InterfaceSetup.GET() then;
        FM2InterfaceSetupRead := true;
        //HEI.14<<
    end;

    local procedure GetGeneralInterfaceOPCOSetup();
    begin
        if not CashVanSalesInterfaceSetupRead then
            if CashVanSalesInterfaceSetup.GET() then;
        CashVanSalesInterfaceSetupRead := true;
    end;

    procedure ReprocessLogInterfaceEntries(var InterfaceLogHeader: Record "Interface Log Header INT");
    begin
        //HEI.16>>
        if InterfaceLogHeader.findset() then
            repeat
                ReprocessInterfaceEntries(InterfaceLogHeader);
            until InterfaceLogHeader.NEXT() = 0;
        //HEI.16<<
    end;

    procedure ReprocessInterfaceEntries(InterfaceLogHeaderToOutbound: Record "Interface Log Header INT");
    var
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        InterfaceEntryCompDetail: Record "Interface Entry Comp.DetailINT";
        InterfaceLogHeader: Record "Interface Log Header INT";
        InterfaceLogLine: Record "Interface Log Line INT";
        InterfaceLogComponent: Record "Interface Log Component INT";
        InterfaceLogCompDetail: Record "Interface Log Comp. Detail INT";
    begin
        //HEI.16>>

        InterfaceLogHeader.GET(InterfaceLogHeaderToOutbound."Entry No.");
        InterfaceEntryHeader.LOCKTABLE();
        CLEAR(InterfaceEntryHeader);
        InterfaceLogHeader.CALCFIELDS(Notes);
        InterfaceEntryHeader.TRANSFERFIELDS(InterfaceLogHeader, false);
        InterfaceEntryHeader."Sync. Date" := CURRENTDATETIME;
        InterfaceEntryHeader.Status := InterfaceEntryHeader.Status::Pending;
        CLEAR(InterfaceEntryHeader."Archive Date");
        InterfaceEntryHeader.INSERT();

        InterfaceLogLine.SETRANGE("Header Entry No.", InterfaceLogHeader."Entry No.");
        if InterfaceLogLine.findset() then
            repeat
                CLEAR(InterfaceEntryLine);
                InterfaceLogLine.CALCFIELDS(Notes);
                InterfaceEntryLine.TRANSFERFIELDS(InterfaceLogLine);
                InterfaceEntryLine."Header Entry No." := InterfaceEntryHeader."Entry No.";
                InterfaceEntryLine.INSERT();
            until InterfaceLogLine.NEXT() = 0;

        InterfaceLogComponent.SETRANGE("Header Entry No.", InterfaceLogHeader."Entry No.");
        if InterfaceLogComponent.findset() then
            repeat
                CLEAR(InterfaceLogComponent);
                InterfaceEntryComponent.TRANSFERFIELDS(InterfaceLogComponent);
                InterfaceEntryComponent."Header Entry No." := InterfaceEntryHeader."Entry No.";
                InterfaceEntryComponent.INSERT();
            until InterfaceLogComponent.NEXT() = 0;

        InterfaceLogCompDetail.SETRANGE("Header Entry No.", InterfaceLogHeader."Entry No.");
        if InterfaceLogCompDetail.findset() then
            repeat
                CLEAR(InterfaceEntryCompDetail);
                InterfaceEntryCompDetail.TRANSFERFIELDS(InterfaceLogCompDetail);
                InterfaceEntryCompDetail."Header Entry No." := InterfaceEntryHeader."Entry No.";
                InterfaceEntryCompDetail.INSERT();
            until InterfaceLogCompDetail.NEXT() = 0;
        //HEI.16<<
    end;

    local procedure GetBankConnectivityInterfaceSetup();
    begin
        //HEI.21>>
        if not BankConnectivityInterfaceSetupRead then
            if BankConnInterfaceSetup.GET() then;
        BankConnectivityInterfaceSetupRead := true;
        //HEI.21<<
    end;

    local procedure GetOrtecInterfaceSetup();
    begin
        //HEI.18>>
        if not OrtecInterfaceSetupRead then
            if OrtecInterfaceSetup.GET() then;
        OrtecInterfaceSetupRead := true;
        //HEI.18<<
    end;

    local procedure GetEDIInterfaceSetup();
    begin
        //HEI.23>>
        if not EDIInterfaceSetupRead then
            if EDIInterfaceSetup.GET() then;
        EDIInterfaceSetupRead := true;
        //HEI.23<<
    end;

    local procedure GetLegacyFuturMasterIntSetup();
    begin
        //HEI.26>>
        if not LegacyFuturMasterIntSetupRead then
            if LegacyFuturMasterIntSetup.GET() then;
        LegacyFuturMasterIntSetupRead := true;
        //HEI.26<<
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetInterfaceError(InterfaceEntryHeader: Record "Interface Entry Header INT");
    begin
        //HEI.23<<
    end;

    local procedure GetSRMInterfaceSetup();
    begin
        //HEI.29
        if not SRMInterfaceSetupRead then
            if SRMInterfaceSetup.GET() then
                SRMInterfaceSetupRead := true;
        //HEI.29
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetInterfaceProcessed(InterfaceEntryHeader: Record "Interface Entry Header INT");
    begin
        //HEI.32<<
    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertBVMCustomer(var Rec: Record Customer; RunTrigger: Boolean);
    begin
        //HEI.33>>
        if Rec.ISTEMPORARY then
            exit;

        GeneralOpCoSetup.GET();
        if not GeneralOpCoSetup."Enable BVM Integration" then
            exit;

        // BVMInterfaceMgmt.ProcessBVMCustomerResponse(Rec);  // BC Upgrade NANDIS03 - BVM blocked temporarily
        //HEI.33<<
    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterValidateEvent', 'Name', false, false)]
    local procedure OnAfterValidateBVMCustomerName(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer);
    begin
        //HEI.33>>
        if Rec.ISTEMPORARY then
            exit;

        GeneralOpCoSetup.GET();
        if not GeneralOpCoSetup."Enable BVM Integration" then
            exit;

        // BVMInterfaceMgmt.ProcessBVMCustomerResponse(Rec);  // BC Upgrade NANDIS03 - BVM blocked temporarily
        //HEI.33<<
    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterValidateEvent', 'Address', false, false)]
    local procedure OnAfterValidateBVMCustomerAddress(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer);
    begin
        //HEI.33>>
        if Rec.ISTEMPORARY then
            exit;

        GeneralOpCoSetup.GET();
        if not GeneralOpCoSetup."Enable BVM Integration" then
            exit;

        // BVMInterfaceMgmt.ProcessBVMCustomerResponse(Rec);  // BC Upgrade NANDIS03 - BVM blocked temporarily
        //HEI.33<<
    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterValidateEvent', 'Phone No.', false, false)]
    local procedure OnAfterValidateBVMCustomerPhoneNo(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer);
    begin
        //HEI.33>>
        if Rec.ISTEMPORARY then
            exit;

        GeneralOpCoSetup.GET();
        if not GeneralOpCoSetup."Enable BVM Integration" then
            exit;

        // BVMInterfaceMgmt.ProcessBVMCustomerResponse(Rec);  // BC Upgrade NANDIS03 - BVM blocked temporarily
        //HEI.33<<
    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterValidateEvent', 'Location Code', false, false)]
    local procedure OnAfterValidateBVMCustomerLocationCode(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer);
    begin
        //HEI.33>>
        if Rec.ISTEMPORARY then
            exit;

        GeneralOpCoSetup.GET();
        if not GeneralOpCoSetup."Enable BVM Integration" then
            exit;

        // BVMInterfaceMgmt.ProcessBVMCustomerResponse(Rec);  // BC Upgrade NANDIS03 - BVM blocked temporarily
        //HEI.33<<
    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterValidateEvent', 'Service Zone Code', false, false)]
    local procedure OnAfterValidateBVMCustomerServiceZoneCode(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer);
    begin
        //HEI.33>>
        if Rec.ISTEMPORARY then
            exit;

        GeneralOpCoSetup.GET();
        if not GeneralOpCoSetup."Enable BVM Integration" then
            exit;

        // BVMInterfaceMgmt.ProcessBVMCustomerResponse(Rec);  // BC Upgrade NANDIS03 - BVM blocked temporarily
        //HEI.33<<
    end;

    [EventSubscriber(ObjectType::Table, 27, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertBVMItem(var Rec: Record Item; RunTrigger: Boolean);
    begin
        //HEI.33>>
        if Rec.ISTEMPORARY then
            exit;

        GeneralOpCoSetup.GET();
        if not GeneralOpCoSetup."Enable BVM Integration" then
            exit;

        // BVMInterfaceMgmt.ProcessBVMItemResponse(Rec);  // BC Upgrade NANDIS03 - BVM blocked temporarily
        //HEI.33<<
    end;

    [EventSubscriber(ObjectType::Table, 27, 'OnAfterValidateEvent', 'Description', false, false)]
    local procedure OnAfterValidateBVMItemDescription(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer);
    begin
        //HEI.33>>
        if Rec.ISTEMPORARY then
            exit;

        GeneralOpCoSetup.GET();
        if not GeneralOpCoSetup."Enable BVM Integration" then
            exit;

        // BVMInterfaceMgmt.ProcessBVMItemResponse(Rec);  // BC Upgrade NANDIS03 - BVM blocked temporarily
        //HEI.33<<
    end;

    [EventSubscriber(ObjectType::Table, 27, 'OnAfterValidateEvent', 'Item Category Code', false, false)]
    local procedure OnAfterValidateBVMItemType(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer);
    begin
        //HEI.33>>
        if Rec.ISTEMPORARY then
            exit;

        GeneralOpCoSetup.GET();
        if not GeneralOpCoSetup."Enable BVM Integration" then
            exit;

        // BVMInterfaceMgmt.ProcessBVMItemResponse(Rec);  // BC Upgrade NANDIS03 - BVM blocked temporarily
        //HEI.33<<
    end;

    [EventSubscriber(ObjectType::Table, 27, 'OnAfterValidateEvent', 'Sales Unit of Measure', false, false)]
    local procedure OnAfterValidateBVMItemUoM(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer);
    begin
        //HEI.33>>
        if Rec.ISTEMPORARY then
            exit;

        GeneralOpCoSetup.GET();
        if not GeneralOpCoSetup."Enable BVM Integration" then
            exit;

        // BVMInterfaceMgmt.ProcessBVMItemResponse(Rec);  // BC Upgrade NANDIS03 - BVM blocked temporarily
        //HEI.33<<
    end;

    local procedure CheckVendBankAccMarkforDeletion(InterfaceEntryCompDetail: Record "Interface Entry Comp.DetailINT"; var InterfaceEntryComponent: Record "Interface Entry Component INT"): Boolean;
    var
        locInterfaceEntryCompDetail: Record "Interface Entry Comp.DetailINT";
        MarkforDelete: Boolean;
    begin
        //>> HEI.38
        locInterfaceEntryCompDetail.SETRANGE("Header Entry No.", InterfaceEntryComponent."Header Entry No.");
        locInterfaceEntryCompDetail.SETRANGE("Line Entry No.", InterfaceEntryComponent."Line Entry No.");
        locInterfaceEntryCompDetail.SETRANGE("Table ID", InterfaceEntryComponent."Table ID");
        locInterfaceEntryCompDetail.SETRANGE(Code, InterfaceEntryComponent.Code);
        locInterfaceEntryCompDetail.SETFILTER("Field ID", '%1|%2|%3', 13, 14, 24);
        if locInterfaceEntryCompDetail.findset() then
            repeat
                if locInterfaceEntryCompDetail.Value = '' then
                    MarkforDelete := true
                else
                    MarkforDelete := false;
            until locInterfaceEntryCompDetail.NEXT() = 0;

        exit(MarkforDelete);
        //<< HEI.38
    end;

    local procedure GetIbecorInterfaceSetup();
    begin
        //HEI.40
        if not IbecorInterfaceSetupRead then
            if IbecorInterfaceSetup.GET() then;
        IbecorInterfaceSetupRead := true;
        //HEI.40
    end;

    local procedure GetHeiFlowInterfaceSetup();
    begin
        //HEI.43>>
        if not HeiFlowInterfaceSetupRead then
            if HeiFLOWInterfaceSetup.GET() then;
        HeiFlowInterfaceSetupRead := true;
        //HEI.43<<
    end;

    local procedure GetIbecorInterfaceSetup_Ibecor();
    begin
        //HEI.58>>
        if not IbecorInterfaceSetupRead then begin
            if IbecorInterfaceSetup.GET() and IbecorInterfaceSetup."Interface Enable/Disable" then
                IbecorInterfaceSetupRead := true;
        end;
        //HEI.58<<
    end;

    local procedure PostProcessUpdate_Ibecor(var InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        IbecorInterfaceManagementL: Codeunit "Ibecor Interface Management";
    begin
        //HEI.58>>
        GetIbecorInterfaceSetup_Ibecor;
        if not IbecorInterfaceSetupRead then begin
            CLEAR(IbecorInterfaceSetup);
            exit;
        end;
        if IbecorInterfaceSetup."IBECOR PFI Confmtion Interface" = '' then
            exit;
        if IbecorInterfaceSetupRead then begin
            case InterfaceEntryHeader."Interface Code" of
                IbecorInterfaceSetup."IBECOR PFI":
                    begin
                        if InterfaceEntryHeader.Direction = InterfaceEntryHeader.Direction::Inbound then begin
                            case InterfaceEntryHeader.Status of
                                InterfaceEntryHeader.Status::Processed:
                                    begin
                                        IbecorInterfaceManagementL.OutboundPurchaseOrderPFIConfirmation_Ibecor(InterfaceEntryHeader."Entry No.", InterfaceEntryHeader."Source No.");
                                    end;
                            end;
                        end;
                    end;
            end;
            CLEAR(IbecorInterfaceManagementL);
            CLEAR(IbecorInterfaceSetup);
            CLEAR(IbecorInterfaceSetupRead);
            CLEAR(GeneralInterfaceSetup);
            CLEAR(GeneralInterfaceSetupRead);
        end;
        //HEI.58<<
    end;
}

