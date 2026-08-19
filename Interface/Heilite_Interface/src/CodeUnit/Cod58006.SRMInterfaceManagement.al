codeunit 58006 "SRM Interface Management"
{
    // Heilite Navision Old Id - 50024

    // version HEI.101

    // HEI.01 FDD-GAPID001 IBM LAZARE02 11.07.2017 # New codeunit for SRM management
    // HEI.02 DefectId 442 IBM HORTOC01 24.10.2017 # Code added
    // HEI.03 FDD-AL-PTPGAP02 IBM HORTOC01/LAZARE02 16.05.2018 # code added.release PO after creation
    // HEI.04 FDD-PURGAP025 IBM LAZARE02 26.07.2018 # Change structure of vendor message
    // HEI.05 FDD-PURGAP031 - Value line call-off modifications, 18.03.2019
    //   # Code Added in C7010OnAfterFindPurchLinePrice
    // HEI.06 FDD-CHG0270634 IBM ISYED01 25.04.2019
    //   # Added code to function Check mandatory dimensions in Purchase  documents
    // HEI.07 IBM HORTOC01 - direct unit cost was not updated in contracts because CurrFieldNo was not setup
    // HEI.08 CHG2024018 IBM NASTAA02 18.07.2019 # Wrong POs Currencies replicated from SRM to Heilite
    //   # Currency Code needs to be update on PO Header from Lines
    // HEI.09 DefectID #4330 IBM HORTOC01 21.08.2019 # validate currency only if is blank
    // HEI.10 DefectID #4382 CHG2032888 IBM GAVANM01 03.10.2019 # validate currency with blank when local currency is received from SRM
    // HEI.15 CHG2021732 FDD-HB755 IBM.GUNERE01 17.01.2020 # CreateGLAccount func. modified
    // HEI.16 CHG2026322 FDD-HT699 IBM.PANDES01 17.01.2020
    //   # Added code for delivery finalized
    // HEI.17 CHG2041871 FDD-HB1031 IBM.PANDES01 21.01.2020 (Only testing purpose)
    //    # Created new function to PO dimension validation.
    //    # Added code for new table SRM interface setup as table General interface setup Fulled.
    //    # Added code UpdatePurchaseorderheader for New Field SRM Default Vendor.
    // HEI.18 CHG2015850 FDD-HB675 IBM.GUNERE01 20.01.2020 # UpdateBlanketOrderLine function modified,
    // HEI.19 CHG2021732 FDD-HB755 IBM.GUNERE01 10.02.2020 # CreateGLAccount func. modified
    // HEI.20 CHG2021732 FDD-HB755 IBM.GUNERE01 10.02.2020 # CreateGLAccount func. modified
    //                                                       UpdateSRMHeaderFromBlanketOrder func. created
    // 
    // HEI.21 CHG2008438 FDD-HB517 IBM.SAXENS01 13.02.2020
    // # UpdatePurchaseOrderLine function modified
    // # CreatePOConfirmationLine function modified
    // HEI.22 FDD- HT1141 IBM PANDES01
    //   # Added code for enable standard texts in PO which created from SRM.
    // HEI.23 FDD-HB1115 CHG2047274 IBM GUNERE01 02.03.2020 # ProcessPOCreation func. modified
    // HEI.24 FDD-HB1080 CHG2044349 IBM GUNERE01 04.03.2020 # ProcessPOCreation func. modified
    // 
    // HEI.26 FDD-HB1115 CHG2047274 IBM GUNERE01 31.03.2020 # UpdatePurchaseOrderLine func. modified
    // HEI.27 FDD-HB1189 CHG2052626 IBM GUNERE01 06.04.2020 # UpdatePurchaseOrderLine func. modified
    // HEI.28 CHG2038388 HB1005 IBM.GUNERE01 16.04.2020 # UpdatePurchaseOrderLine func. modified
    // HEI.29 CHG2052665 HB1131 IBM.GUNERE01 17.04.2020 # UpdatePurchaseOrderHeader func. modified
    //     HEI.30 CHG2061405 FDD-HB1031 IBM.PANDES01 16.04.2020
    //          # Added new Function to fix the Bug for Gen. Prod Posting Group.
    // HEI.31 CHG2067604 IBM.GUNERE01  11.06.2020 # UpdatePurchaseOrderLine, UpdatePurchaseOrderHeader,
    //                                              ProcessGRCreation funcs. modified
    // HEI.32 CHG2069266 IBM.GUNERE01  29.06.2020 # UpdatePurchaseOrderLine, UpdatePurchaseOrderHeader,
    //                                              ProcessGRCreation funcs. modified
    // 
    // HEI.33 CHG2070641 PANDES01 06.07.2020
    //   # Commented code inorder to fix the incident INC2923342.
    //   # Modified condition in Hei.16.
    // HEI.34 CHG2058116 PANDES01  21.08.2020
    //  # Added code on function UpdatePurchaseOrderLine
    // HEI.35  Jagadeesh # 21.08.2020 # UpdatePurchaseOrderLine func. modified
    // HEI.36 CHG2008438 IBM.GUNERE01 # 16.09.2020 # ProcessGRCreation func. modified
    // HEI.37 CHG2081608 IBM.NANDIS01 30.09.2020 Update price of contract line item 23 failed to be distributed in HeiLite BASE
    //   # Code added under function UpdateBlanketOrderLine
    // HEI.38 CHG2081764 IBM.NANDIS01 05.10.2020 CCC codes are not taken over from the item when a blanket order is created from SRM
    //   # Code added under function UpdateBlanketOrderSRMRelatedLines, to update dimension when it has values
    // HEI.39 CHG2088615 IBM.NANDIS01 27.11.2020 SRM investigation in Q and indeed there is an issue when the confirmation is sent from SRM with QTY=0
    //   # Code added under function ProcessGRCreation
    // HEI.40 CHG2082870 IBM SHANKJ03  25.11.2020
    //   # Code added in ProcessGRCreation
    //   # Code added in ProcessPOCreation
    // HEI.41 CHG2091068 IBM.GUNERE01 15.12.2020 # ProcessVendorRequest func. modified
    // HEI.42 CHG2094400 IBM.NANDIS01 18.01.2021 Please release the confirmations done for PO 62077850, in Heilite.
    //   # Commenting all code for CHG2088615(HEI.39), roll back changes for HEI.39
    // HEI.43 CHG2081323 HB1619 IBM.GUNERE01 22.01.2021 # UpdatePurchaseOrderLine func. modified
    // HEI.44 CHG2081323 HB1619 IBM.GUNERE01 19.02.2021 # ProcessGRCreation func. modified, IsLimitPO func added.
    // HEI.45 IBM PANDES01 23.02.2021
    //   # Added Code for new field C&TP CODE.
    // HEI.47 CHG2111351 IBM.GUNERE01 03.03.2021 # IsChangedValue func. created, ProcessPOCreation func. modified
    // HEI.48 CHG2100958 IBM.NANDIS01 08.03.2021 Confirmations created against PO 62077478 are having "Error in Process". The error details are: "You cannot receive more than remaining amount 0" .
    //   # Added code under function ProcessGRCreation - as partial receipt is not working as expected
    // HEI.49 CHG2095187 IBM.GUNERE01 08.03.2021 # ProcessPOValidationRequest func. modified
    // HEI.50 CHG2095081 IBM.PANDES01 14-04-2021
    //  #Added Code for SRM contract call-off.
    // HEI.51 CHG2112230 IBM.GUNERE01 31.05.2021 # UpdatePurchaseOrderLine func. modified
    // HEI.52 CHG2099312 BHATTA09 02.06.2021
    //  # Code added
    // HEI.53 CHG2099313 BHATTA09 02.06.2021
    //  # Code added
    // HEI.54 CHG2113743 IBM.GUNERE01 10.06.2021 # CreateLimitPOLine func. modified
    // HEI.55 FDD-HB2174 - CHG2104952 IBM NANDIS01 10.09.2021 # Raw & Pack interface HL-Ibecor
    //   # Change in function - UpdateSRMHeaderFromBlanketOrder
    // HEI.56 CHG2126909 IBM SHIVAS05 20.09.2021 #CCC dimension code is not populated to limit PO's line
    //   # Change in Function- CreateLimitPOLine
    // HEI.57  CHG2133100 IBM SHANKJ03 14.10.2021
    //   # Updated function POCreation.
    // HEI.58 FDD-HB2560 - CHG2130424 IBM NANDIS01 17.11.2021 # Update SRM contract links on the Limit PO’s confirmation lines
    //   #Modified function - CreateLimitPOLine
    // HEI.59 CHG2135729 - INC3822236 IBM Shankj03 24.11.2021
    //   # Code added in ProcessGRCreation
    // HEI.60 FDD HB2378 - CHG2124414 IBM NANDIS01 01.04.2022 # Maximo HL VL Contract link for CMG items
    //   # Change in function - CreateContractCallOff - If item comes with zero unit price or if item card consists zero unit price, system should allow interface
    // HEI.61 CHG2160869 IBM NANDIS01 02.06.2022 # Limit PO Receipts
    //   # Fix applied for limit po - code blocked in function - CreateLimitPOLine
    // HEI.62 CHG2158169 FDD HB2885 IBM NANDIS01 06.06.2022 # Consumption in HL not updated in SRM Line No
    //   # Line number from HL should not have zeros; changed in functions - CreateContractConfirmationLine, CreatePOConfirmationLine and CreateContractCallOff
    //   # Affected interfaces - SRM-CONTR-CONFIRM, SRM-PO-VALID-RESPONS, SRM-PO-CONFIRM and SRM-CONTR-CALL-OFF
    // HEI.63 CHG2158169 FDD HB2885 IBM NANDIS01 19.07.2022 # Consumption in HL not updated in SRM Line No
    //   # Code added in function - CreateContractCallOff to reflect blanket order line no
    // HEI.64 CHG2162715 HB3020 KOROLA04 28.11.2022
    //   # UpdateBlanketOrderSRMRelatedLines() - changed
    // HEI.69 CHG2132418 FDD-HB2311 IBM NANDIS01 10.03.2023 # Development Correct posting invoicing FA
    //   # Code modified in to show correct posting desc
    // HEI.73 CHG2171687 FCC-HB3907 IBM NANDIS01 09.05.2023 # EBF Matrix(RtR)
    //   # EBF Matrix check has been modified as per new logic
    // HEI.75 CHG2171687 FCC-HB3907 IBM NANDIS01 23.05.2023 # EBF Matrix(RtR)
    //   # New boolean added to keep both the matrix available
    // HEI.77 CHG2206815 FDD-HB3451 IBM NANDIS01 16.06.2023 #Dimensions Brand Code missing when interfacing PO's with SRM
    //   # Dimension validated for shortcut dim 1
    // HEI.65 CHG2148350 FDD-HB2777 IBM NANDIS01 16.02.2023 # develop confirmation check interface for HL
    //   # New function ProcessGRValidationRequest created for new Interface for synchronous GR Validation
    // HEI.66 CHG2148350 FDD-HB2777 IBM NANDIS01 28.02.2023 # develop confirmation check interface for HL
    //   # Changes made on function - CreateGRValidationResponse and previewposting allowed in validation
    // HEI.67 CHG2148350 FDD-HB2777 IBM NANDIS01 01.03.2023 # develop confirmation check interface for HL
    //   # Code added for deleting inbound lines; deleted unwanted blocked codes
    // HEI.68 CHG2148350 FDD-HB2777 IBM NANDIS01 03.03.2023 # develop confirmation check interface for HL
    //   # Code added for validation and other existing checks and posting will continue only for Async process
    // HEI.69 CHG2132418 FDD-HB2311 IBM NANDIS01 10.03.2023 # Development Correct posting invoicing FA
    //   # Code modified in to show correct posting desc
    // HEI.70 CHG2148350 FDD-HB2777 IBM NANDIS01 16.03.2023 # develop confirmation check interface for HL
    //   # Fix on few xml tags
    // HEI.71 CHG2148350 FDD-HB2777 IBM NANDIS01 22.03.2023 # develop confirmation check interface for HL
    //   # Fix on xml tags of Severity code and Status on GRValidationResponse
    // HEI.72 CHG2148350 FDD-HB2777 IBM NANDIS01 27.04.2023 # develop confirmation check interface for HL
    //   # Fix on "vendor Invoice No." which mandatory for preview posting process
    // HEI.73 CHG2171687 FCC-HB3907 IBM NANDIS01 09.05.2023 # EBF Matrix(RtR)
    //   # EBF Matrix check has been modified as per new logic
    // HEI.74 CHG2148350 FDD-HB2777 IBM NANDIS01 12.05.2023 # develop confirmation check interface for HL
    //   # For Purchase receipt preview is not possible, so manual check provided only for FA
    // HEI.75 CHG2171687 FCC-HB3907 IBM NANDIS01 23.05.2023 # EBF Matrix(RtR)
    //   # New boolean added to keep both the matrix available
    // HEI.76 CHG2190299 FDD-HB3316 IBM NANDIS01 24.05.2023 # POSM eshop SRM- HL interface
    //   # New function created - CreteOutboundSRMItemGR
    //   # Changes done in function - UpdatePurchaseOrderLine to accomodate Type Item
    //   # New function - POSMGRConfirmation created for POSM GR confirmation
    // HEI.77 CHG2206815 FDD-HB3451 IBM NANDIS01 16.06.2023 #Dimensions Brand Code missing when interfacing PO's with SRM
    //   # Dimension validated for shortcut dim 1
    // HEI.78 CHG2190299 FDD-HB3316 IBM NANDIS01 17.07.2023 # POSM eshop SRM- HL interface
    //   # CCC Dim is not mandatory for materials
    // HEI.79 CHG2190299 FDD-HB3316 IBM NANDIS01 20.07.2023 # POSM eshop SRM- HL interface
    //   # New values added in staging table for new tags - Currency, Net Value, Receipt No, Item Desc
    // HEI.80 CHG2190299 FDD-HB3316 IBM NANDIS01 21.07.2023 # POSM eshop SRM- HL interface
    //   # Direct Unit cost validation for items for POSM
    // HEI.81 CHG2190299 FDD-HB3316 IBM NANDIS01 25.07.2023 # POSM eshop SRM- HL interface
    //   # Currency Code to be populated in LINE level
    // HEI.82 CHG2190299 FDD-HB3316 IBM NANDIS01 26.07.2023 # POSM eshop SRM- HL interface
    //   # Updated Location in PO Hdr level for POSM
    // HEI.83 CHG2190299 FDD-HB3316 IBM NANDIS01 28.07.2023 # POSM eshop SRM- HL interface
    //   # Considered Shipment Method Code for POSM
    // HEI.84 CHG2190299 FDD-HB3316 IBM NANDIS01 31.07.2023 # POSM eshop SRM- HL interface
    //   # New fields populated - USER ID and Mov Type
    // HEI.85 CHG2190299 FDD-HB3316 IBM NANDIS01 04.08.2023 # POSM eshop SRM- HL interface
    //   # Validation added if both GL and Item received on same line
    // HEI.86 CHG2190299 FDD-HB3316 IBM NANDIS01 07.08.2023 # POSM eshop SRM- HL interface
    //   # Permission added to modify Purch Recpt Header
    // HEI.87 CHG2190299 FDD-HB3316 IBM SRIVAS07 05.09.2023 # POSM E shop, SRM- HL interface
    //   # Added Code in CreteOutboundSRMItemGR()
    // HEI.88 CHG2190299 FDD-HB3316 IBM SRIVAS07 06.09.2023 # POSM E shop, SRM- HL interface
    //   # Added Code in CreteOutboundLinesSRMItemGR()
    // HEI.89 CHG2190299 HB3316 IBM SRIVAS07 12.09.2023 - Development -POSM eShop for BASE OpCos
    //   # New function created - CreateOutboundSRMItemGRCancellation
    //   # New function created - CreateOutboundLinesSRMItemGRCancellation
    // HEI.90 CHG2190299 HB3316 IBM SRIVAS07 24.09.2023 -POSM eShop for BASE OpCos
    //   # Added few code into UpdatePurchaseOrderLine()
    // HEI.91 CHG2190299 HB3316 IBM SRIVAS07 09.10.2023 -POSM eShop for BASE OpCos
    //   # Added few code into UpdatePurchaseOrderLine()
    //   # Added few code into CreateContractLineForSRMCallOff
    // HEI.92 CHG2190299 HB3316 IBM SRIVAS07 21.11.2023 -Finetuning- POSM eShop for BASE OpCos
    //   # Added few code into UpdatePurchaseOrderLine()
    //   # Added few code into CreateContractLineForSRMCallOff
    // HEI.93 CHG2190299 HB3316 IBM SRIVAS07 04.12.2023 -Finetuning- POSM eShop for BASE OpCos
    //   # Added few code into ProcessGRCreation
    // HEI.94 CHG2201773 HB3442 IBM SRIVAS07 05.01.2024 # Development - Undoing a Goods Receipt for Fixed Asset
    //   # Added few code into ProcessGRCreation()
    // HEI.95 CHG2201773 HB3442 IBM SRIVAS07 18.03.2024 # Development - Undoing a Goods Receipt for Fixed Asset
    //   # Added few code into ProcessGRCreation()
    // HEI.96 CHG2229933 HB3689 IBM SRIVAS07 25.04.2024 # SRM Reference Document Mapping - Development
    //   # Added code - ProcessGRCreation()
    // HEI.97 CHG2229933 HB3689 IBM SRIVAS07 30.04.2024 # SRM Reference Document Mapping - Development
    //   # Added code - ProcessGRCreation()
    // HEI.98 CHG2272007 SHARMP16 31.10.2024 # SRM_HL GR interface issue - Development
    //   # Added code - ProcessGRCreation()
    //   # Added code - CreateLimitPOLine()
    // HEI.99 CHG2272007 SHARMP16 14.11.2024 # SRM_HL GR interface issue - Development
    //   # Added few code into ProcessGRCreation()
    // HEI.100 CHG2272007 SHARMP16 09.12.2024 # SRM_HL GR interface issue -Development finetuning
    //   # Commented few code into ProcessGRCreation()
    //   # Added Code - ProcessGRCreation()
    // HEI.101 CHG2272007 SHARMP16 25.02.2025 #SRM_HL GR interface issue - Development finetuning
    //   # Commented code into ProcessGRCreation - RD Movement Type
    //   # Added code - ProcessGRCreation()    
    // HEI.103 CHG2316368 SHARMP16 26.08.2025 CC Fix the bug to delete PO from SRM - Development
    //   #Added Code - DeletePurchaseOrderHeader
    // HEI.104 CHG2316368 SHARMP16 04.09.2025 CC Fix the bug to delete PO from SRM - Development
    //   #Added Code - DeletePurchaseOrderHeader to delete PurchHeaderAdditional
    // HEI.105 CHG2325854 IBM SAHAL01 13.11.2025 Adding PO line number on the Xml message to SAP PO and SRM
    //   # Added Code

    // BC Upgrade SHUKLP03 >>
    // Blocked DrinkIT procedure SetHideValidationDialog() on procedures UpdateBlanketOrderLine(), DeleteBlanketOrderLine(), UpdatePurchaseOrderLine(),CreateContractLineForSRMCallOff and DeletePurchaseOrderLine().
    // Blocked DrinkIT field Amount on procedures ProcessGRCreation(), CreteOutboundLinesSRMItemGR() and CreateOutboundLinesSRMItemGRCancellation().
    // On procedure UpdateBlanketOrderSRMRelatedLines() code is blocked because field "Cross Reference No." is removed from business central.
    // On proceure CheckDimValueOnPOCreation(), procedure name is changed TypeToTableID3() to PurchLineTypeToTableID() because in Business central procedure name is changed.
    // BC Upgrade SHUKLP03 <<

    // BC Upgrade PATELS08 >>
    // # Tag HEI.103 added to the documentation and added 'if-else block' in procedure 'DeletePurchaseOrderHeader'
    // # Tag HEI.104 added to the documentation and added 'if-else block' in procedure 'DeletePurchaseOrderHeader', added variable 'PurchaseHeaderAdditional' in procedure 'DeletePurchaseOrderHeader'
    // # Tag HEI.105 added to the documentation and added code in procedurs 'CreateContractCallOff', 'CreateContractLineCallOff'
    // BC Upgrade PATELS08 <<

    Permissions = TableData "Purch. Rcpt. Header" = rim,
                  TableData "Purch. Rcpt. Line" = rimd;

    trigger OnRun();
    begin
    end;

    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        GLSetup: Record "General Ledger Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        GeneralInterfaceSetupRead: Boolean;
        GLSetupRead: Boolean;
        PurchSetupRead: Boolean;
        SimulateMode: Boolean;
        SimulateModeErr: Label 'Simulate Mode';
        DateNotInPeriodErr: TextConst ENU = '%1=%2 is outside the period %3=%4 - %5=%6';
        QtyRcvdNotInvLessThanQtyErr: TextConst ENU = 'You cannot undo more than %1 %2 for %3 = %4, %5 = %6.';
        NoPurchReceiptLineErr: Label 'There is no purchase receipt line not invoiced with quantity %1.';
        NoReturnShipmentLineErr: Label 'There is no return shipment line not invoiced with quantity %1.';
        POValidationSuccessfullyTxt: Label 'Success';
        POLineValidationSuccessfullyTxt: Label 'PO Line has been successfully checked';
        ContractProcessedTxt: Label 'Contract has been successfully processed';
        POProcessedTxt: Label 'PO has been successfully processed';
        GRProcessedTxt: Label 'GR has been successfully processed';
        NoRemainingAmountOnGRErr: Label 'You cannot receive more than remaining amount %1.';
        ReturnMoreThanInitialAmtErr: Label 'You canno return more than initial amount %1.';
        DimensionNotSetUpErr: Label '%1 is not set up. Please set it up or remove the value %2 from the message.';
        GLAccDimCombinationErr: Label 'Combination of account %1 with dimension %2 is not allowed.';
        CCCDimenssionErr: Label '%1 creation CCC code dimension cant be empty.';
        GeneralPostingSetup: Record "General Posting Setup";
        EbfCombination: Record "Ebf Combination FND";
        Error010: Label 'For the Line No. %1 must have a valid CCC code to Proceed.';
        Error011: Label 'For the Line No. %1 CCC code should not be used.';
        Error012: Label 'For the Line No. %4 GLAccount %1 with Dimension code %2 and Dimension Value %3 is Restricted.';
        LineInvalidDimensionsErr: TextConst Comment = '%1 = Document Type, %2 = Document No, %3 = LineNo., %4 = Error text', ENU = 'The dimensions used in %1 %2, line no.%3 are invalid (Error: %4).', FRA = 'Les axes analytiques utilisés dans %1 %2, ligne n° %3, ne sont pas valides (erreur : %4).';
        SRMInterfaceSetup: Record "SRM Interface Setup INT";
        SRMInterfaceSetupRead: Boolean;
        GRValidationSuccessfullyTxt: Label 'GR has been validated successfully';
        GRLineValidationSuccessfullyTxt: Label 'GR Line has been successfully checked';
        FinancialUtils: Codeunit "Financial-Utils";
        StartPosNoDigits: array[4] of Integer;
        FilterOperator: Text;
        FAReverseError: Label 'Undo Receipt can be performed only for lines of type Item or Discount/Promotion per Order. Please select another line and repeat the procedure.';
        InterfaceSetup: Record "Interface Setup INT";

    procedure CreateMaterialResponse(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT"; InterfaceCode: Code[20]);
    var
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        Item: Record Item;
        StockkeepingUnit: Record "Stockkeeping Unit";
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
    begin
        //SRM material response
        GetGeneralInterfaceSetup();
        InterfaceSetup.GET(InterfaceCode);
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut."Interface Code" := InterfaceCode;
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeader.Direction::Outbound;
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Msg. Sender Business System ID" := InterfaceEntryHeader."Msg. Recv. Business System ID";
        if InterfaceEntryHeaderOut."Msg. Sender Business System ID" = '' then
            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := InterfaceEntryHeader."Msg. Sender Business System ID";
        InterfaceEntryHeaderOut.INSERT(true);
        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.findset() then
            repeat
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut.TRANSFERFIELDS(InterfaceEntryLine, false);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                if InterfaceEntryLineOut."Location Code" = '' then begin
                    if Item.GET(InterfaceEntryLineOut."No.") then begin
                        InterfaceEntryLineOut.Blocked := Item.Blocked;
                        if Item.Blocked then begin
                            InterfaceEntryLineOut.Status := 'O';
                            InterfaceEntryLineOut."Message Type" := 'E';
                            InterfaceEntryLineOut."Message Class" := 'YSRM_CTR';
                        end else begin
                            InterfaceEntryLineOut.Status := 'P';
                            InterfaceEntryLineOut."Message Type" := 'S';
                            InterfaceEntryLineOut."Message Class" := '';
                        end;
                    end else begin
                        InterfaceEntryLineOut."Message Code" := '054';
                        InterfaceEntryLineOut."Message Type" := 'E';
                        InterfaceEntryLineOut."Message Class" := 'YSRM_CTR';
                    end;
                end else begin
                    if StockkeepingUnit.GET(InterfaceEntryLineOut."Location Code", InterfaceEntryLineOut."No.") then begin
                        // BC Upgrade NANDIS03 - Blocked as "Blocked" is a DIT field added in StockKeeping Unit table >>
                        // InterfaceEntryLineOut.Blocked := StockkeepingUnit.Blocked;
                        // if StockkeepingUnit.Blocked then begin
                        //     InterfaceEntryLineOut.Status := 'O';
                        //     InterfaceEntryLineOut."Message Type" := 'E';
                        //     InterfaceEntryLineOut."Message Class" := 'YSRM_CTR';
                        // end else begin
                        //     InterfaceEntryLineOut.Status := 'P';
                        //     InterfaceEntryLineOut."Message Type" := 'S';
                        //     InterfaceEntryLineOut."Message Class" := '';
                        // end;
                        // BC Upgrade NANDIS03 - Blocked as "Blocked" is a DIT field added in StockKeeping Unit table <<
                    end else begin
                        InterfaceEntryLineOut."Message Code" := '052';
                        InterfaceEntryLineOut."Message Type" := 'E';
                        InterfaceEntryLineOut."Message Class" := 'YSRM_CTR';
                    end;
                end;
                InterfaceEntryLineOut.INSERT(true);
            until InterfaceEntryLine.NEXT() = 0;

        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    procedure ProcessVendorRequest(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        Vendor: Record Vendor;
        Language: Record Language;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        ErrorFound: Boolean;
    begin
        //SRM vendor request
        GetGLSetup();
        GetGeneralInterfaceSetup();
        //HEI.17>>
        GetSRMInterfaceSetup();
        //InterfaceSetup.GET(GeneralInterfaceSetup."SRM Vendor Response Interface");
        InterfaceSetup.GET(SRMInterfaceSetup."SRM Vendor Response Interface");
        //HEI.17<<
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Msg. Sender Business System ID" := InterfaceEntryHeader."Msg. Recv. Business System ID";
        if InterfaceEntryHeaderOut."Msg. Sender Business System ID" = '' then
            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := InterfaceEntryHeader."Msg. Sender Business System ID";
        InterfaceEntryHeaderOut."Source System ID" := InterfaceEntryHeader."Source System ID";
        //HEI.17>>
        //InterfaceEntryHeaderOut."Interface Code" := GeneralInterfaceSetup."SRM Vendor Response Interface";
        InterfaceEntryHeaderOut."Interface Code" := SRMInterfaceSetup."SRM Vendor Response Interface";
        //HEI.17<<
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
        //HEI.04>>
        /*
        IF Vendor.GET(InterfaceEntryHeader."Buy-from Vendor No.") THEN BEGIN
          InterfaceEntryHeaderOut."Buy-from Vendor No." := Vendor."No.";
          InterfaceEntryHeaderOut."Source Type" := DATABASE::Vendor;
          InterfaceEntryHeaderOut."Source No." := Vendor."No.";
          IF Vendor."Currency Code" <> '' THEN
            InterfaceEntryHeaderOut."Currency Code" := Vendor."Currency Code"
          ELSE
            InterfaceEntryHeaderOut."Currency Code" := GLSetup."LCY Code";
          InterfaceEntryHeaderOut."Payment Terms Code" := Vendor."Payment Terms Code";
          Language.SETRANGE(Code,Vendor."Language Code");
          IF Language.FINDFIRST THEN
            InterfaceEntryHeaderOut."Language Code" := Language."ISO Language Text";
          InterfaceEntryHeaderOut."E-Mail" := Vendor."E-Mail";
          InterfaceEntryHeaderOut."Shipment Method" := Vendor."Shipment Method Code";
          InterfaceEntryHeaderOut."Shipment Method Location" := Vendor."Shipment Method Location";
          IF Vendor.Blocked <> Vendor.Blocked::" " THEN
            InterfaceEntryHeaderOut.Blocked := TRUE;
        END ELSE BEGIN
          InterfaceEntryHeaderOut."Message Code" := '266';
          InterfaceEntryHeaderOut."Message Type" := 'E';
          InterfaceEntryHeaderOut."Message Class" := 'YSRM_CTR';
        END;
        InterfaceEntryHeaderOut.INSERT(TRUE);
        */
        InterfaceEntryHeaderOut.INSERT(true);
        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.findset() then
            repeat
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut.TRANSFERFIELDS(InterfaceEntryLine, false);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                if Vendor.GET(InterfaceEntryLine."Buy-from Vendor No.") then begin
                    InterfaceEntryLineOut."Buy-from Vendor No." := Vendor."No.";
                    InterfaceEntryLineOut."Source Type" := DATABASE::Vendor;
                    InterfaceEntryLineOut."Source No." := Vendor."No.";
                    if Vendor."Currency Code" <> '' then
                        InterfaceEntryLineOut."Currency Code" := Vendor."Currency Code"
                    else
                        InterfaceEntryLineOut."Currency Code" := GLSetup."LCY Code";
                    InterfaceEntryLineOut."Payment Terms Code" := Vendor."Payment Terms Code";
                    Language.SETRANGE(Code, Vendor."Language Code");
                    // BC Upgrade NANDIS03 - Dependency on DIT field on Language table >>
                    if Language.FINDFIRST then
                        InterfaceEntryLineOut."Language Code" := Language."ISO Language Text1 FND"; // B Upgrade BHARDA11 -- FDD STP 002 Change
                    // BC Upgrade NANDIS03 - Dependency on DIT field on Language table <<
                    InterfaceEntryLineOut."E-Mail" := Vendor."E-Mail";
                    InterfaceEntryLineOut."Shipment Method" := Vendor."Shipment Method Code";
                    InterfaceEntryLineOut."Shipment Method Location" := Vendor."Shipment Method Location FND";
                    //>> HEI.41
                    //      IF Vendor.Blocked <> Vendor.Blocked::" " THEN
                    //        InterfaceEntryLineOut.Blocked := TRUE;
                    if (Vendor.Blocked = Vendor.Blocked::Order) or (Vendor.Blocked = Vendor.Blocked::All) then
                        InterfaceEntryLineOut.Blocked := true
                    else if (Vendor.Blocked = Vendor.Blocked::" ") or (Vendor.Blocked = Vendor.Blocked::Payment) then
                        InterfaceEntryLineOut.Blocked := false;
                    //<< HEI.41
                end else begin
                    ErrorFound := true;
                    InterfaceEntryLineOut."Message Code" := '266';
                    InterfaceEntryLineOut."Message Type" := 'E';
                    InterfaceEntryLineOut."Message Class" := 'YSRM_CTR';
                end;
                InterfaceEntryLineOut.INSERT(true);
            until InterfaceEntryLine.NEXT() = 0;
        if ErrorFound then begin
            InterfaceEntryHeaderOut."Message Code" := '266';
            InterfaceEntryHeaderOut."Message Type" := 'E';
            InterfaceEntryHeaderOut."Message Class" := 'YSRM_CTR';
            InterfaceEntryHeaderOut.MODIFY();
        end;
        //HEI.04<<

    end;

    procedure ProcessContractCreation(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
    begin
        //SRM contract creation
        GetGLSetup();
        GetGeneralInterfaceSetup();
        GetSRMInterfaceSetup(); //HEI.17
        InterfaceEntryHeader.TESTFIELD("Action Code");
        case InterfaceEntryHeader."Action Code" of
            //create contract
            //HEI.17>>
            //GeneralInterfaceSetup."SRM Create Action Code":
            SRMInterfaceSetup."SRM Create Action Code":
                //HEI.17<<
                begin
                    UpdateBlanketOrderHeader(PurchaseHeader, InterfaceEntryHeader, true);
                    CreateContractConfirmationHeader(InterfaceEntryHeader, InterfaceEntryHeaderOut, PurchaseHeader);

                    InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                    InterfaceEntryLine.SETCURRENTKEY("External Contract No.", "External Contract Line No.");
                    if InterfaceEntryLine.findset() then
                        repeat
                            InterfaceEntryLine.TESTFIELD("Action Code");
                            case InterfaceEntryLine."Action Code" of
                                //HEI.17>>
                                //GeneralInterfaceSetup."SRM Create Action Code":
                                SRMInterfaceSetup."SRM Create Action Code":
                                    //HEI.17<<
                                    begin
                                        UpdateBlanketOrderLine(PurchaseHeader, PurchaseLine, InterfaceEntryHeader, InterfaceEntryLine, true);
                                        CreateContractConfirmationLine(InterfaceEntryLine, InterfaceEntryHeaderOut, InterfaceEntryLineOut, PurchaseLine);
                                    end;
                                //HEI.17>>
                                //GeneralInterfaceSetup."SRM Change Action Code":
                                SRMInterfaceSetup."SRM Change Action Code":
                                    //HEI.17<<
                                    begin
                                        UpdateBlanketOrderLine(PurchaseHeader, PurchaseLine, InterfaceEntryHeader, InterfaceEntryLine, false);
                                        CreateContractConfirmationLine(InterfaceEntryLine, InterfaceEntryHeaderOut, InterfaceEntryLineOut, PurchaseLine);
                                    end;
                                //HEI.17>>
                                //GeneralInterfaceSetup."SRM Close Action Code":
                                SRMInterfaceSetup."SRM Close Action Code":
                                    //HEI.17<<
                                    begin
                                        DeleteBlanketOrderLine(PurchaseHeader, PurchaseLine, InterfaceEntryHeader, InterfaceEntryLine);
                                        CreateContractConfirmationLine(InterfaceEntryLine, InterfaceEntryHeaderOut, InterfaceEntryLineOut, PurchaseLine);
                                    end;
                            end;
                        until InterfaceEntryLine.NEXT() = 0;
                end;
            //change contract
            //HEI.17>>
            //GeneralInterfaceSetup."SRM Change Action Code":
            SRMInterfaceSetup."SRM Change Action Code":
                //HEI.17<<
                begin
                    UpdateBlanketOrderHeader(PurchaseHeader, InterfaceEntryHeader, false);
                    CreateContractConfirmationHeader(InterfaceEntryHeader, InterfaceEntryHeaderOut, PurchaseHeader);

                    InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                    if InterfaceEntryLine.findset() then
                        repeat
                            InterfaceEntryLine.TESTFIELD("Action Code");
                            case InterfaceEntryLine."Action Code" of
                                //HEI.17>>
                                //GeneralInterfaceSetup."SRM Create Action Code":
                                SRMInterfaceSetup."SRM Create Action Code":
                                    //HEI.17<<
                                    begin
                                        UpdateBlanketOrderLine(PurchaseHeader, PurchaseLine, InterfaceEntryHeader, InterfaceEntryLine, true);
                                        CreateContractConfirmationLine(InterfaceEntryLine, InterfaceEntryHeaderOut, InterfaceEntryLineOut, PurchaseLine);
                                    end;
                                //HEI.17>>
                                //GeneralInterfaceSetup."SRM Change Action Code":
                                SRMInterfaceSetup."SRM Change Action Code":
                                    //HEI.17<<
                                    begin
                                        UpdateBlanketOrderLine(PurchaseHeader, PurchaseLine, InterfaceEntryHeader, InterfaceEntryLine, false);
                                        CreateContractConfirmationLine(InterfaceEntryLine, InterfaceEntryHeaderOut, InterfaceEntryLineOut, PurchaseLine);
                                    end;
                                //HEI.17>>
                                //GeneralInterfaceSetup."SRM Close Action Code":
                                SRMInterfaceSetup."SRM Close Action Code":
                                    //HEI.17<<
                                    begin
                                        DeleteBlanketOrderLine(PurchaseHeader, PurchaseLine, InterfaceEntryHeader, InterfaceEntryLine);
                                        CreateContractConfirmationLine(InterfaceEntryLine, InterfaceEntryHeaderOut, InterfaceEntryLineOut, PurchaseLine);
                                    end;
                            end;
                        until InterfaceEntryLine.NEXT() = 0;
                end;
            //close contract
            //HEI.17>>
            //GeneralInterfaceSetup."SRM Close Action Code":
            SRMInterfaceSetup."SRM Close Action Code":
                //HEI.17<<
                begin
                    DeleteBlanketOrderHeader(PurchaseHeader, InterfaceEntryHeader);
                    CreateContractConfirmationHeader(InterfaceEntryHeader, InterfaceEntryHeaderOut, PurchaseHeader);

                    InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                    if InterfaceEntryLine.findset() then
                        repeat
                            InterfaceEntryLine.TESTFIELD("Action Code");
                            //HEI.17>>
                            //IF InterfaceEntryLine."Action Code" = GeneralInterfaceSetup."SRM Close Action Code" THEN BEGIN
                            if InterfaceEntryLine."Action Code" = SRMInterfaceSetup."SRM Close Action Code" then begin
                                //HEI.17<<
                                DeleteBlanketOrderLine(PurchaseHeader, PurchaseLine, InterfaceEntryHeader, InterfaceEntryLine);
                                CreateContractConfirmationLine(InterfaceEntryLine, InterfaceEntryHeaderOut, InterfaceEntryLineOut, PurchaseLine);
                            end;
                        until InterfaceEntryLine.NEXT() = 0;
                end;
        end;
    end;

    local procedure UpdateBlanketOrderHeader(var PurchaseHeader: Record "Purchase Header"; InterfaceEntryHeader: Record "Interface Entry Header INT"; WithInsert: Boolean);
    var
        InterfaceEntryLine: Record "Interface Entry Line INT";
        //TempBlob: Record TempBlob temporary;  // BC Upgrade NANDIS03 - Blocked as Temp Blob record is obsolete
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03 - Added as Temp Blob record is obsolete
    begin
        GetGLSetup();
        if WithInsert then begin
            if PurchaseHeader.GET(InterfaceEntryHeader."Source Subtype", InterfaceEntryHeader."Source No.") then
                exit;
            CLEAR(PurchaseHeader);
            if not GUIALLOWED then
                PurchaseHeader.SetHideValidationDialog(true);
            PurchaseHeader.VALIDATE("Document Type", InterfaceEntryHeader."Source Subtype");
            PurchaseHeader.INSERT(true);
        end else begin
            PurchaseHeader.GET(InterfaceEntryHeader."Source Subtype", InterfaceEntryHeader."Source No.");
            if not GUIALLOWED then
                PurchaseHeader.SetHideValidationDialog(true);
        end;

        if InterfaceEntryHeader."Buy-from Vendor No." <> PurchaseHeader."Buy-from Vendor No." then
            PurchaseHeader.VALIDATE("Buy-from Vendor No.", InterfaceEntryHeader."Buy-from Vendor No.");
        if IsChangedValue(PurchaseHeader."Document Date", InterfaceEntryHeader."Document Date") then //HEI.52
            PurchaseHeader.VALIDATE("Document Date", InterfaceEntryHeader."Document Date");

        PurchaseHeader.VALIDATE("SRM Contract Type FND", InterfaceEntryHeader."Contract Type");
        PurchaseHeader.VALIDATE("SRM Contract No. FND", InterfaceEntryHeader."External Contract No.");
        PurchaseHeader.VALIDATE("SRM Contract Name FND", InterfaceEntryHeader."External Contract Name");
        PurchaseHeader.VALIDATE("Valid From FND", InterfaceEntryHeader."Valid From");
        PurchaseHeader.VALIDATE("Valid To FND", InterfaceEntryHeader."Valid To");
        if IsChangedValue(PurchaseHeader."Currency Code", InterfaceEntryHeader."Currency Code") then begin //HEI.52
            if InterfaceEntryHeader."Currency Code" <> GLSetup."LCY Code" then begin
                PurchaseHeader.VALIDATE("Currency Code", InterfaceEntryHeader."Currency Code");
                PurchaseHeader.VALIDATE("Target Value Currency FND", InterfaceEntryHeader."Currency Code");
            end else
                if PurchaseHeader."Currency Code" <> '' then begin
                    PurchaseHeader.VALIDATE("Currency Code", '');
                    PurchaseHeader.VALIDATE("Target Value Currency FND", '');
                end;
        end;//HEI.52
        PurchaseHeader.VALIDATE("Target Value Amount FND", InterfaceEntryHeader.Amount);
        if (InterfaceEntryHeader.Description <> '') then  //HEI.69
            PurchaseHeader.VALIDATE("Posting Description", InterfaceEntryHeader.Description);
        PurchaseHeader.VALIDATE("Closed FND", InterfaceEntryHeader.Closed);
        PurchaseHeader.VALIDATE("Purchaser Code", InterfaceEntryHeader."Salespers./Purch. Code");
        PurchaseHeader.VALIDATE("Shipment Method Code", InterfaceEntryHeader."Shipment Method");
        PurchaseHeader.VALIDATE("Shipment Method Location FND", InterfaceEntryHeader."Shipment Method Location");
        PurchaseHeader.VALIDATE("Payment Terms Code", InterfaceEntryHeader."Payment Terms Code");
        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDFIRST() then
            PurchaseHeader.VALIDATE("Channel FND", GetChannelFromTypeID(InterfaceEntryLine."Type ID"));
        PurchaseHeader.MODIFY(true);

        if InterfaceEntryHeader.Notes.HASVALUE then begin
            CLEAR(TempBlob);
            InterfaceEntryHeader.CALCFIELDS(Notes);
            // TempBlob.Blob := InterfaceEntryHeader.Notes;  // BC Upgrade NANDIS03 - to be opened
            CreateNoteRecordLink(TempBlob, PurchaseHeader.RECORDID, DATABASE::"Purchase Header", PAGE::"Blanket Purchase Order",
                                 FORMAT(PurchaseHeader."Document Type") + ' ' + PurchaseHeader."No.");
        end;
    end;

    local procedure UpdateBlanketOrderLine(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; InterfaceEntryHeader: Record "Interface Entry Header INT"; InterfaceEntryLine: Record "Interface Entry Line INT"; WithInsert: Boolean);
    var
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        InterfaceEntryComponent2: Record "Interface Entry Component INT";
        PurchaseLinePrice: Record "Purchase Line Price FND";
        ItemCharge: Record "Item Charge";
        Item: Record Item;
        //TempBlob: Record TempBlob temporary;  // BC Upgrade NANDIS03 - Blocked
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03 - Added 
        UoMCode: Code[10];
        PurchLineNo: Integer;
        NextLineNo: Integer;
        SkipLine: Boolean;
        InterfaceEntryLine1: Record "Interface Entry Line INT";
        ContractLineNo: Code[20];
    begin
        GetGLSetup();
        if WithInsert then begin
            PurchaseLine.RESET();
            PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            if PurchaseLine.FINDLAST() then
                PurchLineNo := PurchaseLine."Line No.";

            CLEAR(PurchaseLine);
            //if not GUIALLOWED then // BC Upgrade NANDIS03 - Blocking to validate Document Type
            //PurchaseLine.SetHideValidationDialog(true);  // BC Upgrade SHUKLP03 << Blocked because of DrinkIT procedure SetHideValidationDialog(). 
            PurchaseLine.VALIDATE("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.VALIDATE("Document No.", PurchaseHeader."No.");
            PurchLineNo := PurchLineNo + 10000;
            PurchaseLine."Line No." := PurchLineNo;
            //>> HEI.18
            // END ELSE BEGIN
            //  PurchaseLine.RESET;
            //  PurchaseLine.SETRANGE("Document Type",PurchaseHeader."Document Type");
            //  PurchaseLine.SETRANGE("Document No.",PurchaseHeader."No.");
            //  PurchaseLine.SETRANGE("Line No.",InterfaceEntryLine."Source Line No.");
            //  PurchaseLine.FINDFIRST;
            //  IF NOT GUIALLOWED THEN
            //    PurchaseLine.SetHideValidationDialog(TRUE);
            // END;
            //<< HEI.18

            UpdateBlanketOrderSRMRelatedLines(PurchaseLine, InterfaceEntryLine, InterfaceEntryHeader, PurchaseHeader); //HEI.18

            //IF WithInsert THEN BEGIN // HEI.18

            PurchaseLine.INSERT(true);

            if InterfaceEntryLine.Notes.HASVALUE then begin
                CLEAR(TempBlob);
                InterfaceEntryLine.CALCFIELDS(Notes);
                // TempBlob.Blob := InterfaceEntryLine.Notes;  // BC Upgrade NANDIS03 - Blocked which needs to be opened later
                CreateNoteRecordLink(TempBlob, PurchaseLine.RECORDID, DATABASE::"Purchase Line", PAGE::"Purchase Line Notes CBN",
                                     FORMAT(PurchaseLine."Document Type") + ' ' + PurchaseLine."No." + ' ' + FORMAT(PurchaseLine."Line No."));
            end;

            //create line price for new contract
            InterfaceEntryComponent.SETRANGE("Header Entry No.", InterfaceEntryLine."Header Entry No.");
            InterfaceEntryComponent.SETRANGE("Line Entry No.", InterfaceEntryLine."Entry No.");
            if InterfaceEntryComponent.findset() then
                repeat
                    SkipLine := false;
                    if (InterfaceEntryComponent."Scale Currency Code" = '') and
                       (InterfaceEntryComponent."Scale Unit of Measure Code" = '') and
                       (InterfaceEntryComponent."Scale Direct Cost Per Multip." = 0)
                    then begin
                        InterfaceEntryComponent2.SETRANGE("Header Entry No.", InterfaceEntryComponent."Header Entry No.");
                        InterfaceEntryComponent2.SETRANGE("Line Entry No.", InterfaceEntryComponent."Line Entry No.");
                        InterfaceEntryComponent2.SETRANGE("Scale Currency Code", InterfaceEntryComponent."Price Currency Code");
                        InterfaceEntryComponent2.SETRANGE("Scale Unit of Measure Code", InterfaceEntryComponent."Price UoM Code");
                        InterfaceEntryComponent2.SETRANGE("Scale Minimum Quantity", 0);
                        if not InterfaceEntryComponent2.ISEMPTY then
                            SkipLine := true;
                    end;
                    if not SkipLine then begin
                        CLEAR(PurchaseLinePrice);
                        PurchaseLinePrice.VALIDATE("Document Type", PurchaseHeader."Document Type");
                        PurchaseLinePrice.VALIDATE("Document No.", PurchaseHeader."No.");
                        PurchaseLinePrice."Document Line No." := PurchaseLine."Line No.";
                        if InterfaceEntryComponent."Price Location Code" <> '' then
                            PurchaseLinePrice.VALIDATE("Location Code", InterfaceEntryComponent."Price Location Code");
                        PurchaseLinePrice.VALIDATE("Starting Date", InterfaceEntryComponent."Price Starting Date");
                        if InterfaceEntryComponent."Scale Currency Code" <> '' then begin
                            if InterfaceEntryComponent."Scale Currency Code" <> GLSetup."LCY Code" then
                                PurchaseLinePrice.VALIDATE("Currency Code", InterfaceEntryComponent."Scale Currency Code")
                            else
                                PurchaseLinePrice.VALIDATE("Currency Code", '');  //HEI.10
                        end else
                            if InterfaceEntryComponent."Price Currency Code" <> GLSetup."LCY Code" then
                                PurchaseLinePrice.VALIDATE("Currency Code", InterfaceEntryComponent."Price Currency Code")
                            else
                                PurchaseLinePrice.VALIDATE("Currency Code", ''); //HEI.10
                        if Item.GET(PurchaseLine."No.") then begin
                            PurchaseLinePrice.VALIDATE("Item No.", PurchaseLine."No.");
                            if InterfaceEntryComponent."Scale Unit of Measure Code" <> '' then
                                PurchaseLinePrice.VALIDATE("Unit of Measure Code", InterfaceFrameworkMgt.GetISOCodeUnitOfMeasure(InterfaceEntryComponent."Scale Unit of Measure Code"))
                            else
                                PurchaseLinePrice.VALIDATE("Unit of Measure Code", InterfaceFrameworkMgt.GetISOCodeUnitOfMeasure(InterfaceEntryComponent."Price UoM Code"));
                        end;
                        PurchaseLinePrice.VALIDATE("Minimum Quantity", InterfaceEntryComponent."Scale Minimum Quantity");
                        UpdateBlanketOrderLinePrice(PurchaseLinePrice, InterfaceEntryComponent);
                        PurchaseLinePrice.INSERT(true);
                    end;
                until InterfaceEntryComponent.NEXT() = 0;

        end else begin
            //>> HEI.18
            PurchaseLine.RESET();
            PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            //PurchaseLine.SETRANGE("Line No.",InterfaceEntryLine."Source Line No.");
            PurchaseLine.SETRANGE("SRM Contract No. FND", InterfaceEntryLine."External Contract No.");
            PurchaseLine.SETRANGE("SRM Contract Line No. FND", InterfaceEntryLine."External Contract Line No.");
            PurchaseLine.findset();
            repeat
                // if not GUIALLOWED then // BC Upgrade BHARDA11 --11April2026 Block this line of code;
                //PurchaseLine.SetHideValidationDialog(true);   // BC Upgrade SHUKLP03 << Blocked because of DrinkIT procedure SetHideValidationDialog().

                UpdateBlanketOrderSRMRelatedLines(PurchaseLine, InterfaceEntryLine, InterfaceEntryHeader, PurchaseHeader);
                PurchaseLine.MODIFY(true);

                if InterfaceEntryLine.Notes.HASVALUE then begin
                    CLEAR(TempBlob);
                    InterfaceEntryLine.CALCFIELDS(Notes);
                    // TempBlob.Blob := InterfaceEntryLine.Notes;  // BC Upgrade NANDIS03 - Blocked which needs to be opened later
                    CreateNoteRecordLink(TempBlob, PurchaseLine.RECORDID, DATABASE::"Purchase Line", PAGE::"Purchase Line Notes CBN",
                                         FORMAT(PurchaseLine."Document Type") + ' ' + PurchaseLine."No." + ' ' + FORMAT(PurchaseLine."Line No."));
                end;

                //change line price for existing contract
                InterfaceEntryComponent.SETRANGE("Header Entry No.", InterfaceEntryLine."Header Entry No.");
                InterfaceEntryComponent.SETRANGE("Line Entry No.", InterfaceEntryLine."Entry No.");
                if InterfaceEntryComponent.findset() then
                    repeat
                        PurchaseLinePrice.SETRANGE("Document Type", PurchaseHeader."Document Type");
                        PurchaseLinePrice.SETRANGE("Document No.", PurchaseHeader."No.");
                        //HEI.37>>
                        //PurchaseLinePrice.SETRANGE("Document Line No.",InterfaceEntryLine."Source Line No.");
                        PurchaseLinePrice.SETRANGE("SRM Contract Line No.", InterfaceEntryLine."External Contract Line No.");
                        //HEI.37<<
                        PurchaseLinePrice.SETRANGE("Starting Date", InterfaceEntryComponent."Price Starting Date");
                        PurchaseLinePrice.SETRANGE("Location Code", InterfaceEntryComponent."Price Location Code");
                        if InterfaceEntryComponent."Scale Currency Code" <> '' then begin
                            if InterfaceEntryComponent."Scale Currency Code" <> GLSetup."LCY Code" then
                                PurchaseLinePrice.SETRANGE("Currency Code", InterfaceEntryComponent."Scale Currency Code")
                            else
                                PurchaseLinePrice.SETRANGE("Currency Code", ''); //HEI.10
                        end else
                            if InterfaceEntryComponent."Price Currency Code" <> GLSetup."LCY Code" then
                                PurchaseLinePrice.SETRANGE("Currency Code", InterfaceEntryComponent."Price Currency Code")
                            else
                                PurchaseLinePrice.SETRANGE("Currency Code", '');
                        PurchaseLinePrice.VALIDATE("Item No.", PurchaseLine."No.");
                        if InterfaceEntryComponent."Scale Unit of Measure Code" <> '' then
                            PurchaseLinePrice.SETRANGE("Unit of Measure Code", InterfaceFrameworkMgt.GetISOCodeUnitOfMeasure(InterfaceEntryComponent."Scale Unit of Measure Code"))
                        else
                            PurchaseLinePrice.SETRANGE("Unit of Measure Code", InterfaceFrameworkMgt.GetISOCodeUnitOfMeasure(InterfaceEntryComponent."Price UoM Code"));
                        PurchaseLinePrice.SETRANGE("Minimum Quantity", InterfaceEntryComponent."Scale Minimum Quantity");
                        if PurchaseLinePrice.FINDFIRST() then begin
                            UpdateBlanketOrderLinePrice(PurchaseLinePrice, InterfaceEntryComponent);
                            PurchaseLinePrice.MODIFY(true)
                        end else begin
                            CLEAR(PurchaseLinePrice);
                            PurchaseLinePrice.VALIDATE("Document Type", PurchaseHeader."Document Type");
                            PurchaseLinePrice.VALIDATE("Document No.", PurchaseHeader."No.");
                            PurchaseLinePrice."Document Line No." := PurchaseLine."Line No.";
                            if InterfaceEntryComponent."Price Location Code" <> '' then
                                PurchaseLinePrice.VALIDATE("Location Code", InterfaceEntryComponent."Price Location Code");
                            PurchaseLinePrice.VALIDATE("Starting Date", InterfaceEntryComponent."Price Starting Date");
                            if InterfaceEntryComponent."Scale Currency Code" <> '' then begin
                                if InterfaceEntryComponent."Scale Currency Code" <> GLSetup."LCY Code" then
                                    PurchaseLinePrice.VALIDATE("Currency Code", InterfaceEntryComponent."Scale Currency Code")
                                else
                                    PurchaseLinePrice.VALIDATE("Currency Code", '');  //HEI.10
                            end else
                                if InterfaceEntryComponent."Price Currency Code" <> GLSetup."LCY Code" then
                                    PurchaseLinePrice.VALIDATE("Currency Code", InterfaceEntryComponent."Price Currency Code")
                                else
                                    PurchaseLinePrice.VALIDATE("Currency Code", '');  //HEI.10
                            PurchaseLinePrice.VALIDATE("Item No.", PurchaseLine."No.");
                            if InterfaceEntryComponent."Scale Unit of Measure Code" <> '' then
                                PurchaseLinePrice.VALIDATE("Unit of Measure Code", InterfaceFrameworkMgt.GetISOCodeUnitOfMeasure(InterfaceEntryComponent."Scale Unit of Measure Code"))
                            else
                                PurchaseLinePrice.VALIDATE("Unit of Measure Code", InterfaceFrameworkMgt.GetISOCodeUnitOfMeasure(InterfaceEntryComponent."Price UoM Code"));
                            PurchaseLinePrice.VALIDATE("Minimum Quantity", InterfaceEntryComponent."Scale Minimum Quantity");
                            UpdateBlanketOrderLinePrice(PurchaseLinePrice, InterfaceEntryComponent);
                            PurchaseLinePrice.INSERT(true);
                        end;
                    until InterfaceEntryComponent.NEXT() = 0;
            until PurchaseLine.NEXT() = 0;
            //<< HEI.18
        end;
    end;

    local procedure UpdateBlanketOrderLinePrice(var PurchaseLinePrice: Record "Purchase Line Price FND"; InterfaceEntryComponent: Record "Interface Entry Component INT");
    begin
        GetGLSetup();
        PurchaseLinePrice.VALIDATE("Ending Date", InterfaceEntryComponent."Price Ending Date");
        if InterfaceEntryComponent."Scale Direct Unit Cost Multip." <> 0 then
            PurchaseLinePrice.VALIDATE("Direct Unit Cost Multiplier", InterfaceEntryComponent."Scale Direct Unit Cost Multip.")
        else
            if InterfaceEntryComponent."Price Direct Unit Cost Multip." <> 0 then
                PurchaseLinePrice.VALIDATE("Direct Unit Cost Multiplier", InterfaceEntryComponent."Price Direct Unit Cost Multip.");
        if InterfaceEntryComponent."Scale Direct Cost Per Multip." <> 0 then
            PurchaseLinePrice.VALIDATE("Direct Cost Per Multiplier", InterfaceEntryComponent."Scale Direct Cost Per Multip.")
        else
            if InterfaceEntryComponent."Price Direct Cost Per Multip." <> 0 then
                PurchaseLinePrice.VALIDATE("Direct Cost Per Multiplier", InterfaceEntryComponent."Price Direct Cost Per Multip.");
        if PurchaseLinePrice."Direct Unit Cost Multiplier" <> 0 then
            PurchaseLinePrice.VALIDATE("Direct Unit Cost", ROUND(PurchaseLinePrice."Direct Cost Per Multiplier" / PurchaseLinePrice."Direct Unit Cost Multiplier",
                                                                GLSetup."Unit-Amount Rounding Precision"))
        else
            PurchaseLinePrice.VALIDATE("Direct Unit Cost", PurchaseLinePrice."Direct Cost Per Multiplier");
    end;

    local procedure DeleteBlanketOrderHeader(var PurchaseHeader: Record "Purchase Header"; InterfaceEntryHeader: Record "Interface Entry Header INT");
    begin
        PurchaseHeader.GET(InterfaceEntryHeader."Source Subtype", InterfaceEntryHeader."Source No.");
        if not GUIALLOWED then
            PurchaseHeader.SetHideValidationDialog(true);
        if InterfaceEntryHeader.Closed then begin
            PurchaseHeader.VALIDATE("Closed FND", InterfaceEntryHeader.Closed);
            PurchaseHeader.MODIFY(true);
        end;
    end;

    local procedure DeleteBlanketOrderLine(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; InterfaceEntryHeader: Record "Interface Entry Header INT"; InterfaceEntryLine: Record "Interface Entry Line INT");
    begin
        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETRANGE("SRM Contract Line No. FND", InterfaceEntryLine."External Contract Line No.");
        PurchaseLine.FINDFIRST();
        // if not GUIALLOWED then // BC Upgrade BHARDA11 --11April2026 Block this line of code;
        //PurchaseLine.SetHideValidationDialog(true);  // BC Upgrade SHUKLP03 << Blocked because of DrinkIT procedure SetHideValidationDialog().
        if InterfaceEntryLine.Closed or InterfaceEntryHeader.Closed then
            PurchaseLine.VALIDATE("Block Line Ordering FND", PurchaseLine."Block Line Ordering FND"::F)
        else
            if InterfaceEntryLine.Locked then
                PurchaseLine.VALIDATE("Block Line Ordering FND", PurchaseLine."Block Line Ordering FND"::B);
        PurchaseLine.MODIFY(true);
    end;

    local procedure CreateContractConfirmationHeader(InterfaceEntryHeaderIn: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT"; PurchaseHeader: Record "Purchase Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
    begin
        //Contract confirmation header NAV -> SRM
        GetGeneralInterfaceSetup();
        //HEI.17>>
        GetSRMInterfaceSetup();
        //GeneralInterfaceSetup.TESTFIELD("Contract Confirm. Interface");
        SRMInterfaceSetup.TESTFIELD("Contract Confirm. Interface");
        //InterfaceSetup.GET(GeneralInterfaceSetup."Contract Confirm. Interface");
        InterfaceSetup.GET(SRMInterfaceSetup."Contract Confirm. Interface");
        //HEI.17<<
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeaderIn, false);
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Msg. Sender Business System ID" := InterfaceEntryHeaderIn."Msg. Recv. Business System ID";
        if InterfaceEntryHeaderOut."Msg. Sender Business System ID" = '' then
            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := InterfaceEntryHeaderIn."Msg. Sender Business System ID";
        InterfaceEntryHeaderOut."Type ID" := '300';
        InterfaceEntryHeaderOut."Severity Code" := '1';
        InterfaceEntryHeaderOut."Log Message" := ContractProcessedTxt;
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        //HEI.17<<
        //InterfaceEntryHeaderOut."Interface Code" := GeneralInterfaceSetup."Contract Confirm. Interface";
        InterfaceEntryHeaderOut."Interface Code" := SRMInterfaceSetup."Contract Confirm. Interface";
        //HEI.17>>
        InterfaceEntryHeaderOut."Source No." := PurchaseHeader."No.";
        InterfaceEntryHeaderOut.INSERT(true);
    end;

    local procedure CreateContractConfirmationLine(InterfaceEntryLineIn: Record "Interface Entry Line INT"; InterfaceEntryHeaderOut: Record "Interface Entry Header INT"; var InterfaceEntryLineOut: Record "Interface Entry Line INT"; PurchaseLine: Record "Purchase Line");
    begin
        //Contract confirmation line NAV -> SRM
        CLEAR(InterfaceEntryLineOut);
        InterfaceEntryLineOut.TRANSFERFIELDS(InterfaceEntryLineIn, false);
        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
        InterfaceEntryLineOut."Entry No." := InterfaceEntryLineIn."Entry No.";
        //HEI.62>>
        //InterfaceEntryLineOut."Source Line No." := PurchaseLine."Line No.";
        if (PurchaseLine."Line No." <> 0) then
            InterfaceEntryLineOut."Source Line No." := (PurchaseLine."Line No." / 10000);
        //HEI.62<<
        InterfaceEntryLineOut."External Contract No." := PurchaseLine."SRM Contract No. FND";
        InterfaceEntryLineOut.INSERT();
    end;

    procedure IsSRMPurchaseBlanketOrderLine(PurchaseLine: Record "Purchase Line"): Boolean;
    begin
        if (PurchaseLine."SRM Contract No. FND" <> '') and
           (PurchaseLine."SRM Contract Line No. FND" <> '')
        then
            exit(true);
        exit(false);
    end;

    procedure GetBlanketOrderPurchPrice(var PurchBlanketOrderLine: Record "Purchase Line"; var PurchOrderLine: Record "Purchase Line"; ShowPriceError: Boolean);
    var
        PurchaseLinePrice: Record "Purchase Line Price FND";
        UnitPrice: Decimal;
    begin
        if PurchBlanketOrderLine.Type <> PurchBlanketOrderLine.Type::Item then
            exit;

        UnitPrice := PurchaseLinePrice.GetPurchPrice(PurchOrderLine, ShowPriceError);
        if UnitPrice <> 0 then begin
            PurchOrderLine."Direct Unit Cost" := UnitPrice;
            // PurchOrderLine."Item Charge Value" := UnitPrice;  // BC Upgrade NANDIS03 - Dependency on DIT field
            PurchOrderLine.VALIDATE("Direct Unit Cost");
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 7010, 'OnAfterFindPurchLinePrice', '', false, false)]
    // BC Upgrade NANDIS03 - Blocked as the parameters were not matching >>
    //local procedure C7010OnAfterFindPurchLinePrice(var PurchLine: Record "Purchase Line");
    local procedure C7010OnAfterFindPurchLinePrice(var PurchaseLine: Record "Purchase Line"; var PurchaseHeader: Record "Purchase Header"; var PurchasePrice: Record "Purchase Price"; CalledByFieldNo: Integer; PriceInSKU: Boolean; FoundPurchPrice: Boolean)
    // BC Upgrade NANDIS03 - Blocked as the parameters were not matching <<
    var
        PurchBlanketOrderLine: Record "Purchase Line";
        PurchaseLinePrice: Record "Purchase Line Price FND";
        UnitPrice: Decimal;
        PurchBlanketOrderHeader: Record "Purchase Header";
    begin
        if (PurchaseLine.Type <> PurchaseLine.Type::Item) or (PurchaseLine."SRM Contract Line No. FND" = '') then
            exit;

        // if PurchBlanketOrderLine.GET(PurchBlanketOrderLine."Document Type"::"Blanket Order", PurchLine."Blanket Order No.", PurchLine."Blanket Order Line No.") then begin  // BC Upgrade NANDIS03 - blocked to match the parameter
        if PurchBlanketOrderLine.GET(PurchBlanketOrderLine."Document Type"::"Blanket Order", PurchaseLine."Blanket Order No.", PurchaseLine."Blanket Order Line No.") then begin  // BC Upgrade NANDIS03 - added to match the parameter
            //HEI.05>>
            //UnitPrice := PurchaseLinePrice.GetPurchPrice(PurchLine,TRUE);
            if PurchBlanketOrderHeader.GET(PurchBlanketOrderLine."Document Type", PurchBlanketOrderLine."Document No.") then begin
                if PurchBlanketOrderHeader."Channel FND" = 'D' then
                    // UnitPrice := PurchaseLinePrice.GetPurchPrice(PurchLine, false)  // BC Upgrade NANDIS03 - blocked to match the parameter
                    UnitPrice := PurchaseLinePrice.GetPurchPrice(PurchaseLine, false)  // BC Upgrade NANDIS03 - added to match the parameter
                else
                    // UnitPrice := PurchaseLinePrice.GetPurchPrice(PurchLine, true);  // BC Upgrade NANDIS03 - blocked to match the parameter
                    UnitPrice := PurchaseLinePrice.GetPurchPrice(PurchaseLine, true);  // BC Upgrade NANDIS03 - added to match the parameter
            end
            else
                // UnitPrice := PurchaseLinePrice.GetPurchPrice(PurchLine, true);  // BC Upgrade NANDIS03 - blocked to match the parameter
                UnitPrice := PurchaseLinePrice.GetPurchPrice(PurchaseLine, true);  // BC Upgrade NANDIS03 - added to match the parameter
            //HEI.05<<
            if UnitPrice <> 0 then begin
                // BC Upgrade NANDIS03 >>
                // PurchLine."Direct Unit Cost" := UnitPrice;
                // PurchLine."Item Charge Value" := UnitPrice;
                PurchaseLine."Direct Unit Cost" := UnitPrice;
                //PurchaseLine."Item Charge Value" := UnitPrice;  // BC Upgrade NANDIS03 - Blocked as dependency on DIT field
                // BC Upgrade NANDIS03 <<
            end;
        end;
    end;

    // BC Upgrade NANDIS03 - Blocked below code as OnAfterMakeOrderHeader event is obsolete in BC >>
    //[EventSubscriber(ObjectType::Codeunit, 97, 'OnAfterMakeOrderHeader', '', false, false)]
    //local procedure C97OnAfterMakeOrderHeader(PurchBlanketOrder: Record "Purchase Header"; var PurchOrder: Record "Purchase Header");
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Purch. Order to Order", 'OnCreatePurchHeaderOnAfterPurchOrderHeaderInsert', '', false, false)]
    local procedure OnCreatePurchHeaderOnAfterPurchOrderHeaderInsert(PurchHeader: Record "Purchase Header"; var PurchOrderHeader: Record "Purchase Header")
    // BC Upgrade NANDIS03 - Blocked below code as OnAfterMakeOrderHeader event is obsolete in BC <<
    begin
        // BC Upgrade NANDIS03 - Blocked to restructure the parameters >>
        // if (PurchOrder."Document Date" < PurchBlanketOrder."Valid From") or
        //    ((PurchOrder."Document Date" > PurchBlanketOrder."Valid To") and (PurchBlanketOrder."Valid To" <> 0D))
        // then
        //     ERROR(STRSUBSTNO(DateNotInPeriodErr,
        //                      PurchOrder.FIELDCAPTION("Document Date"), PurchOrder."Document Date",
        //                      PurchBlanketOrder.FIELDCAPTION("Valid From"), PurchBlanketOrder."Valid From",
        //                      PurchBlanketOrder.FIELDCAPTION("Valid To"), PurchBlanketOrder."Valid To"));
        if (PurchOrderHeader."Document Date" < PurchHeader."Valid From FND") or
           ((PurchOrderHeader."Document Date" > PurchHeader."Valid To FND") and (PurchHeader."Valid To FND" <> 0D))
        then
            ERROR(STRSUBSTNO(DateNotInPeriodErr,
                             PurchOrderHeader.FIELDCAPTION("Document Date"), PurchOrderHeader."Document Date",
                             PurchHeader.FIELDCAPTION("Valid From FND"), PurchHeader."Valid From FND",
                             PurchHeader.FIELDCAPTION("Valid To FND"), PurchHeader."Valid To FND"));
        // BC Upgrade NANDIS03 - Blocked to restructure the parameters <<
    end;

    // // BC Upgrade NANDIS03 - Blocked to restructure the function >>
    // [EventSubscriber(ObjectType::Codeunit, 97, 'OnBeforeModifyBlanketOrderLine', '', false, false)]
    // local procedure C97OnBeforeModifyBlanketOrderLine(var PurchBlanketOrderLine: Record "Purchase Line");
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Purch. Order to Order", 'OnRunOnBeforeCheckModifyPurchBlanketOrderLine', '', false, false)]
    local procedure OnRunOnBeforeCheckModifyPurchBlanketOrderLine(var PurchOrderLine: Record "Purchase Line"; var PurchBlanketOrderLine: Record "Purchase Line"; var PurchLine: Record "Purchase Line")
    // // BC Upgrade NANDIS03 - Blocked to restructure the function <<
    var
        Channel: Record "Channel FND";
        PurchBlanketOrderHeader: Record "Purchase Header";
    begin
        if (not (PurchBlanketOrderLine.Type in [PurchBlanketOrderLine.Type::"Charge (Item)", PurchBlanketOrderLine.Type::"G/L Account"])) or
                    (PurchBlanketOrderLine."CMG Code FND" = '') then
            exit;
        PurchBlanketOrderHeader.GET(PurchBlanketOrderLine."Document Type", PurchBlanketOrderLine."Document No.");
        if Channel.GET(PurchBlanketOrderHeader."Channel FND") then
            if Channel."Contract Type" = Channel."Contract Type"::"Value Line" then begin
                PurchBlanketOrderLine."Initial Quantity FND" := PurchBlanketOrderLine."Initial Quantity FND" + 1;
                PurchBlanketOrderLine.VALIDATE(Quantity, PurchBlanketOrderLine.Quantity + 1);
            end;
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnBeforeValidateEvent', 'Qty. to Receive', false, false)]
    local procedure T39OnBeforeValidateEventQtyToReceive(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    begin
        if Rec.ISTEMPORARY then
            exit;

        if Rec."Qty. to Receive" > 0 then begin
            if Rec."Document Type" = Rec."Document Type"::"Blanket Order" then
                Rec.TESTFIELD("Block Line Ordering FND", Rec."Block Line Ordering FND"::" ")
            else
                if Rec."Document Type" = Rec."Document Type"::Order then
                    Rec.TESTFIELD("Cancelled FND", false)
        end;
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterDeleteEvent', '', false, false)]
    local procedure T39OnAfterDeletePurchaseLine(var Rec: Record "Purchase Line"; RunTrigger: Boolean);
    var
        PurchaseLinePrice: Record "Purchase Line Price FND";
    begin
        if Rec.ISTEMPORARY then
            exit;

        PurchaseLinePrice.SETRANGE("Document Type", Rec."Document Type");
        PurchaseLinePrice.SETRANGE("Document No.", Rec."Document No.");
        PurchaseLinePrice.SETRANGE("Document Line No.", Rec."Line No.");
        PurchaseLinePrice.DELETEALL();
    end;

    // BC Upgrade NANDIS03 - Blocked below code as OnAfterMakeOrder event is not found in BC >>
    // [EventSubscriber(ObjectType::Codeunit, 96, 'OnAfterMakeOrder', '', false, false)]
    // local procedure C96OnAfterMakeOrder(var PurchOrderHeader: Record "Purchase Header");
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnAfterCreatePurchHeader', '', false, false)]
    local procedure OnAfterCreatePurchHeader(var PurchOrderHeader: Record "Purchase Header"; PurchHeader: Record "Purchase Header")
    // BC Upgrade NANDIS03 - Blocked below code as OnAfterMakeOrder event is not found in BC <<
    begin
        if PurchOrderHeader."SRM Contract No. FND" = '' then
            exit;

        CreateContractCallOff(PurchOrderHeader, 1);
    end;

    // BC Upgrade NANDIS03 - Blocked below code as OnAfterMakeOrderHeader event is obsolete in BC >>
    // [EventSubscriber(ObjectType::Codeunit, 97, 'OnAfterMakeOrder', '', false, false)]
    // local procedure C97OnAfterMakeOrder(var PurchOrderHeader: Record "Purchase Header");
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Purch. Order to Order", 'OnCreatePurchHeaderOnAfterPurchOrderHeaderInsert', '', false, false)]
    local procedure OnCreatePurchHeaderOnAfterPurchOrderHeaderInsert2(PurchHeader: Record "Purchase Header"; var PurchOrderHeader: Record "Purchase Header")
    // BC Upgrade NANDIS03 - Blocked below code as OnAfterMakeOrderHeader event is obsolete in BC <<
    begin
        if PurchOrderHeader."SRM Contract No. FND" = '' then
            exit;

        CreateContractCallOff(PurchOrderHeader, 1);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Purch. Order to Return", 'OnAfterMakeOrder', '', false, false)]
    local procedure C50045OnAfterMakeOrder(var PurchOrderHeader: Record "Purchase Header");
    begin
        if PurchOrderHeader."SRM Contract No. FND" = '' then
            exit;

        CreateContractCallOff(PurchOrderHeader, -1);
    end;

    [EventSubscriber(ObjectType::Codeunit, 415, 'OnAfterReleasePurchaseDoc', '', false, false)]
    local procedure C415OnAfterReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean);
    begin
        if PreviewMode or (PurchaseHeader."SRM Contract No. FND" = '') then
            exit;

        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then
            CreateContractCallOff(PurchaseHeader, 1)
        else
            if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Return Order" then
                CreateContractCallOff(PurchaseHeader, -1);
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure T38OnBeforeDeleteOrder(var Rec: Record "Purchase Header"; RunTrigger: Boolean);
    begin
        if Rec."SRM Contract No. FND" = '' then
            exit;
        /*
        IF Rec."Document Type" = Rec."Document Type"::Order THEN
          CreateContractCallOff(Rec,-1)
        ELSE
          IF Rec."Document Type" = Rec."Document Type"::"Return Order" THEN
            CreateContractCallOff(Rec,1);
        */

    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure T39OnBeforeDeleteOrderLine(var Rec: Record "Purchase Line"; RunTrigger: Boolean);
    begin
        if Rec.ISTEMPORARY or (Rec."SRM Contract No. FND" = '') or (Rec."SRM Contract Line No. FND" = '') then
            exit;

        if Rec."Document Type" = Rec."Document Type"::Order then
            CreateContractLineCallOff(Rec, -1)
        else
            if Rec."Document Type" = Rec."Document Type"::"Return Order" then
                CreateContractLineCallOff(Rec, 1);
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Quantity', false, false)]
    local procedure T39OnAfterValidateQuantity(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    begin
        if Rec.ISTEMPORARY or (Rec."SRM Contract No. FND" = '') or (Rec."SRM Contract Line No. FND" = '') or
           (CurrFieldNo <> Rec.FIELDNO(Quantity))
        then
            exit;

        if Rec.Quantity < xRec.Quantity then begin
            if Rec."Document Type" = Rec."Document Type"::Order then
                CreateContractLineCallOff(Rec, 1)
            else
                if Rec."Document Type" = Rec."Document Type"::"Return Order" then
                    CreateContractLineCallOff(Rec, -1);
        end;
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Direct Unit Cost', false, false)]
    local procedure T39OnAfterValidateDirectUnitCost(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    begin
        if Rec.ISTEMPORARY or (Rec."SRM Contract No. FND" = '') or (Rec."SRM Contract Line No. FND" = '') or
           (CurrFieldNo <> Rec.FIELDNO("Direct Unit Cost"))
        then
            exit;

        if Rec."Direct Unit Cost" < xRec."Direct Unit Cost" then begin
            if Rec."Document Type" = Rec."Document Type"::Order then
                CreateContractLineCallOff(Rec, 1)
            else
                if Rec."Document Type" = Rec."Document Type"::"Return Order" then
                    CreateContractLineCallOff(Rec, -1);
        end;
    end;

    procedure CreateContractCallOff(PurchOrderHeader: Record "Purchase Header"; Sign: Integer);
    var
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceLogHeaderIn: Record "Interface Log Header INT";
        PurchaseLine: Record "Purchase Line";
        BlanketOrderLine: Record "Purchase Line";
        Channel: Record "Channel FND";
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        EntryNo: Integer;
        PurchaseHeaderBO: Record "Purchase Header";
    begin
        GetGLSetup();
        GetGeneralInterfaceSetup();
        //HEI.17>>
        GetSRMInterfaceSetup();
        //GeneralInterfaceSetup.TESTFIELD("Contract Call-Off Interface");
        SRMInterfaceSetup.TESTFIELD("Contract Call-Off Interface");
        //InterfaceSetup.GET(GeneralInterfaceSetup."Contract Call-Off Interface");
        InterfaceSetup.GET(SRMInterfaceSetup."Contract Call-Off Interface");
        //HEI.17<<
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        PurchOrderHeader.TESTFIELD("Closed FND", false);

        InterfaceLogHeaderIn.SETCURRENTKEY("Interface Code", "External Contract No.");
        //HEI.17>>
        //InterfaceLogHeaderIn.SETRANGE("Interface Code",GeneralInterfaceSetup."Contract Creation Interface");
        InterfaceLogHeaderIn.SETRANGE("Interface Code", SRMInterfaceSetup."Contract Creation Interface");
        //HEI.17<<
        InterfaceLogHeaderIn.SETRANGE("External Contract No.", PurchOrderHeader."SRM Contract No. FND");
        if InterfaceLogHeaderIn.FINDLAST() then;

        CLEAR(InterfaceEntryHeader);
        //HEI.17>>
        //InterfaceEntryHeader."Interface Code" := GeneralInterfaceSetup."Contract Call-Off Interface";
        InterfaceEntryHeader."Interface Code" := SRMInterfaceSetup."Contract Call-Off Interface";
        //HEI.17<<
        InterfaceEntryHeader.Direction := InterfaceEntryHeader.Direction::Outbound;
        InterfaceEntryHeader."Source Type" := DATABASE::"Purchase Header";
        InterfaceEntryHeader."Source Subtype" := PurchOrderHeader."Document Type".AsInteger();
        InterfaceEntryHeader."Source No." := PurchOrderHeader."No.";
        InterfaceEntryHeader."Posting Date" := PurchOrderHeader."Posting Date";
        InterfaceEntryHeader."Buy-from Vendor No." := PurchOrderHeader."Buy-from Vendor No.";
        InterfaceEntryHeader."External Contract No." := PurchOrderHeader."SRM Contract No. FND";
        InterfaceEntryHeader."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeader."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        InterfaceEntryHeader."Purchasing Organisation" := InterfaceLogHeaderIn."Purchasing Organisation";
        if PurchOrderHeader."Currency Code" <> '' then
            InterfaceEntryHeader."Currency Code" := PurchOrderHeader."Currency Code"
        else
            InterfaceEntryHeader."Currency Code" := GLSetup."LCY Code";
        if PurchOrderHeader."Currency Factor" <> 0 then
            //HEI.17>>
            //InterfaceEntryHeader."Currency Factor" := ROUND(PurchOrderHeader."Currency Factor",GeneralInterfaceSetup."SRM Exch. Rate Rndg. Precision")
            InterfaceEntryHeader."Currency Factor" := ROUND(PurchOrderHeader."Currency Factor", SRMInterfaceSetup."SRM Exch. Rate Rndg. Precision")
        //HEI.17<<
        else
            InterfaceEntryHeader."Currency Factor" := 1;
        InterfaceEntryHeader.INSERT(true);

        PurchaseLine.SETRANGE("Document Type", PurchOrderHeader."Document Type");
        PurchaseLine.SETRANGE("Document No.", PurchOrderHeader."No.");
        PurchaseLine.SETRANGE("SRM Contract No. FND", PurchOrderHeader."SRM Contract No. FND");//HEI.50
        if PurchaseLine.findset() then
            repeat

                //HEI.16>>
                if (PurchOrderHeader."Document Type" = PurchOrderHeader."Document Type"::Order) and PurchOrderHeader."Completely Received" then
                    PurchaseLine.TESTFIELD("Delivery Finalized FND", true); //HEI.33- Added semicolon
                                                                            //ELSE  //HEI.33
                                                                            //HEI.16<<
                                                                            //PurchaseLine.TESTFIELD("Delivery Finalized",FALSE); //HEI.33
                PurchaseLine.TESTFIELD("Block Line Ordering FND", PurchaseLine."Block Line Ordering FND"::" ");
                if Channel.GET(PurchOrderHeader."Channel FND") then
                    if Channel."Contract Type" = Channel."Contract Type"::PxQ then begin
                        //>>HEI.22
                        if PurchaseLine.Type <> PurchaseLine.Type::" " then begin
                            PurchaseLine.TESTFIELD("Unit of Measure Code");
                            PurchaseLine.TESTFIELD("Location Code");
                        end; //<<HEI.22
                    end;
                //>>HEI.22
                if PurchaseLine.Type <> PurchaseLine.Type::" " then
                    //<<HEI.22
                    //HEI.60>>
                    //PurchaseLine.TESTFIELD("Direct Unit Cost");
                    if not (PurchaseLine."SRM Contract No. FND" <> '') and (PurchaseLine."SRM Contract Line No. FND" <> '') and (PurchaseLine."Blanket Order No." <> '') and
                (PurchaseLine."Maximo Requisition No. FND" <> '') then begin
                        if PurchaseHeaderBO.GET(PurchaseHeaderBO."Document Type"::"Blanket Order", PurchaseLine."Blanket Order No.") then
                            if Channel.GET(PurchaseHeaderBO."Channel FND") then
                                if Channel."Contract Type" = Channel."Contract Type"::"Value Line" then
                                    PurchaseLine.TESTFIELD("Direct Unit Cost");
                    end;
                //HEI.60<<
                CLEAR(InterfaceEntryLine);
                InterfaceEntryLine."Header Entry No." := InterfaceEntryHeader."Entry No.";
                EntryNo := EntryNo + 1;
                InterfaceEntryLine."Entry No." := EntryNo;
                //HEI.62>>
                //InterfaceEntryLine."Source Line No." := PurchaseLine."Line No.";
                if (PurchaseLine."Line No." <> 0) then
                    InterfaceEntryLine."Source Line No." := (PurchaseLine."Line No." / 10000);
                //HEI.62<<
                InterfaceEntryLine.Type := PurchaseLine.Type.AsInteger();
                if (PurchaseLine.Type = PurchaseLine.Type::Item) and (PurchaseLine."No." <> PurchaseLine."CMG Code FND") then
                    InterfaceEntryLine."No." := PurchaseLine."No.";
                InterfaceEntryLine."CMG Code" := PurchaseLine."CMG Code FND";
                InterfaceEntryLine.Description := PurchaseLine.Description;
                InterfaceEntryLine."Description 2" := PurchaseLine."Description 2";
                InterfaceEntryLine."Location Code" := PurchaseLine."Location Code";

                //HEI.50
                if (PurchaseLine.Type = PurchaseLine.Type::"G/L Account") or (PurchaseLine.Type = PurchaseLine.Type::"Charge (Item)") then begin
                    if PurchaseLine."Unit of Measure" = '' then
                        InterfaceEntryLine."Unit of Measure Code" := SRMInterfaceSetup."Default Unit of Measure";
                end else
                    //HEI.50
                    InterfaceEntryLine."Unit of Measure Code" := InterfaceFrameworkMgt.GetUnitOfMeasureISOCode(PurchaseLine."Unit of Measure Code");
                InterfaceEntryLine."Currency Code" := InterfaceEntryHeader."Currency Code";
                InterfaceEntryLine."Unit Amount" := PurchaseLine."Direct Unit Cost";
                if (PurchaseLine."Document Type" = PurchaseLine."Document Type"::Order) and (Sign < 0) then begin
                    InterfaceEntryLine.Cancelled := true;
                    InterfaceEntryLine.Quantity := 0;
                    InterfaceEntryLine."Line Amount" := 0;
                end else begin
                    InterfaceEntryLine.Quantity := Sign * PurchaseLine.Quantity;
                    InterfaceEntryLine."Line Amount" := Sign * PurchaseLine."Line Amount";
                end;
                InterfaceEntryLine."External Contract No." := PurchaseLine."SRM Contract No. FND";
                InterfaceEntryLine."External Contract Line No." := PurchaseLine."SRM Contract Line No. FND";
                InterfaceEntryLine."Blanket Order No." := PurchaseLine."Blanket Order No.";
                if PurchaseLine.Type = PurchaseLine.Type::"G/L Account" then begin
                    BlanketOrderLine.RESET();
                    BlanketOrderLine.SETRANGE("Document Type", BlanketOrderLine."Document Type"::"Blanket Order");
                    BlanketOrderLine.SETRANGE("Document No.", PurchaseLine."Blanket Order No.");
                    BlanketOrderLine.SETRANGE("SRM Contract No. FND", PurchaseLine."SRM Contract No. FND");
                    BlanketOrderLine.SETRANGE("SRM Contract Line No. FND", PurchaseLine."SRM Contract Line No. FND");
                    BlanketOrderLine.SETRANGE(Type, BlanketOrderLine.Type::"G/L Account");
                    //HEI.17>>
                    //BlanketOrderLine.SETRANGE("No.",GeneralInterfaceSetup."Contract Default G/L Acc. No.");
                    BlanketOrderLine.SETRANGE("No.", SRMInterfaceSetup."Contract Default G/L Acc. No.");
                    //HEI.17<<
                    //HEI.63>>
                    //IF BlanketOrderLine.FINDFIRST THEN
                    //  InterfaceEntryLine."Blanket Order Line No." := BlanketOrderLine."Line No."
                    //ELSE
                    //  InterfaceEntryLine."Blanket Order Line No." := PurchaseLine."Blanket Order Line No.";
                    //END ELSE
                    //InterfaceEntryLine."Blanket Order Line No." := PurchaseLine."Blanket Order Line No.";
                    if BlanketOrderLine.FINDFIRST() then begin
                        if (BlanketOrderLine."Line No." <> 0) then
                            InterfaceEntryLine."Blanket Order Line No." := (BlanketOrderLine."Line No." / 10000);
                    end else begin
                        if (PurchaseLine."Blanket Order Line No." <> 0) then
                            InterfaceEntryLine."Blanket Order Line No." := (PurchaseLine."Blanket Order Line No." / 10000);
                    end
                end else begin
                    if (PurchaseLine."Blanket Order Line No." <> 0) then
                        InterfaceEntryLine."Blanket Order Line No." := (PurchaseLine."Blanket Order Line No." / 10000);
                end;
                //HEI.63<<
                InterfaceEntryLine."CMG Code" := PurchaseLine."CMG Code FND";
                InterfaceEntryLine."Last Changed Date/Time" := PurchaseLine."Last Changed Date/Time FND";

                // BC Upgrade PATELS08 >>
                // HEI.105 >>
                InterfaceEntryLine."Order Line No." := PurchaseLine."Line No.";
                // HEI.105 <<
                // BC Upgrade PATELS08 <<

                InterfaceEntryLine.INSERT();
            until PurchaseLine.NEXT() = 0;
    end;

    procedure CreateContractLineCallOff(var PurchOrderLine: Record "Purchase Line"; Sign: Integer);
    var
        PurchOrderHeader: Record "Purchase Header";
        BlanketOrderLine: Record "Purchase Line";
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceLogHeaderIn: Record "Interface Log Header INT";
        Channel: Record "Channel FND";
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        EntryNo: Integer;
    begin
        GetGLSetup();
        GetGeneralInterfaceSetup();
        //HEI.17>>
        GetSRMInterfaceSetup();
        // GeneralInterfaceSetup.TESTFIELD("Contract Call-Off Interface");
        SRMInterfaceSetup.TESTFIELD("Contract Call-Off Interface");
        // InterfaceSetup.GET(GeneralInterfaceSetup."Contract Call-Off Interface");
        InterfaceSetup.GET(SRMInterfaceSetup."Contract Call-Off Interface");
        //HEI.17<<
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        PurchOrderHeader.GET(PurchOrderLine."Document Type", PurchOrderLine."Document No.");
        PurchOrderHeader.TESTFIELD("Closed FND", false);

        InterfaceLogHeaderIn.SETCURRENTKEY("Interface Code", "External Contract No.");
        //HEI.17>>
        //InterfaceLogHeaderIn.SETRANGE("Interface Code",GeneralInterfaceSetup."Contract Creation Interface");
        InterfaceLogHeaderIn.SETRANGE("Interface Code", SRMInterfaceSetup."Contract Creation Interface");
        //HEI.17<<
        InterfaceLogHeaderIn.SETRANGE("External Contract No.", PurchOrderHeader."SRM Contract No. FND");
        if InterfaceLogHeaderIn.FINDLAST() then;

        CLEAR(InterfaceEntryHeader);
        //HEI.17>>
        // InterfaceEntryHeader."Interface Code" := GeneralInterfaceSetup."Contract Call-Off Interface";
        InterfaceEntryHeader."Interface Code" := SRMInterfaceSetup."Contract Call-Off Interface";
        //HEI.17<<
        InterfaceEntryHeader.Direction := InterfaceEntryHeader.Direction::Outbound;
        InterfaceEntryHeader."Source Type" := DATABASE::"Purchase Header";
        InterfaceEntryHeader."Source Subtype" := PurchOrderHeader."Document Type".AsInteger();
        InterfaceEntryHeader."Source No." := PurchOrderHeader."No.";
        InterfaceEntryHeader."Posting Date" := PurchOrderHeader."Posting Date";
        InterfaceEntryHeader."Buy-from Vendor No." := PurchOrderHeader."Buy-from Vendor No.";
        InterfaceEntryHeader."External Contract No." := PurchOrderHeader."SRM Contract No. FND";
        InterfaceEntryHeader."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeader."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        InterfaceEntryHeader."Purchasing Organisation" := InterfaceLogHeaderIn."Purchasing Organisation";
        if PurchOrderHeader."Currency Code" <> '' then
            InterfaceEntryHeader."Currency Code" := PurchOrderHeader."Currency Code"
        else
            InterfaceEntryHeader."Currency Code" := GLSetup."LCY Code";
        if PurchOrderHeader."Currency Factor" <> 0 then
            //HEI.17<<
            //  InterfaceEntryHeader."Currency Factor" := ROUND(PurchOrderHeader."Currency Factor",GeneralInterfaceSetup."SRM Exch. Rate Rndg. Precision")
            InterfaceEntryHeader."Currency Factor" := ROUND(PurchOrderHeader."Currency Factor", SRMInterfaceSetup."SRM Exch. Rate Rndg. Precision")
        //HEI.17>>
        else
            InterfaceEntryHeader."Currency Factor" := 1;
        InterfaceEntryHeader.INSERT(true);
        //HEI.33
        //HEI.16>>
        if (PurchOrderHeader."Document Type" = PurchOrderHeader."Document Type"::Order) and PurchOrderHeader."Completely Received" then
            PurchOrderLine.TESTFIELD("Delivery Finalized FND", true);
        //ELSE
        //HEI.16>>
        //PurchOrderLine.TESTFIELD("Delivery Finalized",FALSE);
        //HEI.33
        PurchOrderLine.TESTFIELD("Block Line Ordering FND", PurchOrderLine."Block Line Ordering FND"::" ");
        if Channel.GET(PurchOrderHeader."Channel FND") then
            if Channel."Contract Type" = Channel."Contract Type"::PxQ then begin
                PurchOrderLine.TESTFIELD("Unit of Measure Code");
                PurchOrderLine.TESTFIELD("Location Code");
            end;
        PurchOrderLine.TESTFIELD("Direct Unit Cost");
        //HEI.50
        PurchOrderLine.SETRANGE("SRM Contract No. FND", PurchOrderHeader."SRM Contract No. FND");
        //PurchOrderLine.SETRANGE("SRM Contract Line No. FND",PurchOrderHeader."SRM Contract Line No. FND");
        //HEI.50
        CLEAR(InterfaceEntryLine);
        InterfaceEntryLine."Header Entry No." := InterfaceEntryHeader."Entry No.";
        EntryNo := EntryNo + 1;
        InterfaceEntryLine."Entry No." := EntryNo;
        InterfaceEntryLine."Source Line No." := PurchOrderLine."Line No.";
        InterfaceEntryLine.Type := PurchOrderLine.Type.AsInteger();
        if (PurchOrderLine.Type = PurchOrderLine.Type::Item) and (PurchOrderLine."No." <> PurchOrderLine."CMG Code FND") then
            InterfaceEntryLine."No." := PurchOrderLine."No.";
        InterfaceEntryLine."CMG Code" := PurchOrderLine."CMG Code FND";
        InterfaceEntryLine.Description := PurchOrderLine.Description;
        InterfaceEntryLine."Description 2" := PurchOrderLine."Description 2";
        InterfaceEntryLine."Location Code" := PurchOrderLine."Location Code";

        //HEI.50
        //SRMInterfaceSetup.GET;
        if (PurchOrderLine.Type = PurchOrderLine.Type::"G/L Account") or (PurchOrderLine.Type = PurchOrderLine.Type::"Charge (Item)") then begin
            if PurchOrderLine."Unit of Measure" = '' then
                InterfaceEntryLine."Unit of Measure Code" := SRMInterfaceSetup."Default Unit of Measure";
        end else
            //HEI.50
            InterfaceEntryLine."Unit of Measure Code" := InterfaceFrameworkMgt.GetUnitOfMeasureISOCode(PurchOrderLine."Unit of Measure Code");
        InterfaceEntryLine."Currency Code" := InterfaceEntryHeader."Currency Code";
        InterfaceEntryLine."Unit Amount" := PurchOrderLine."Direct Unit Cost";
        if (PurchOrderLine."Document Type" = PurchOrderLine."Document Type"::Order) and (Sign < 0) then begin
            InterfaceEntryLine.Cancelled := true;
            InterfaceEntryLine.Quantity := 0;
            InterfaceEntryLine."Line Amount" := 0;
        end else begin
            InterfaceEntryLine.Quantity := Sign * PurchOrderLine.Quantity;
            InterfaceEntryLine."Line Amount" := Sign * PurchOrderLine."Line Amount";
        end;
        InterfaceEntryLine."External Contract No." := PurchOrderLine."SRM Contract No. FND";
        InterfaceEntryLine."External Contract Line No." := PurchOrderLine."SRM Contract Line No. FND";
        InterfaceEntryLine."Blanket Order No." := PurchOrderLine."Blanket Order No.";
        if PurchOrderLine.Type = PurchOrderLine.Type::"G/L Account" then begin
            BlanketOrderLine.RESET();
            BlanketOrderLine.SETRANGE("Document Type", BlanketOrderLine."Document Type"::"Blanket Order");
            BlanketOrderLine.SETRANGE("Document No.", PurchOrderLine."Blanket Order No.");
            BlanketOrderLine.SETRANGE("SRM Contract No. FND", PurchOrderLine."SRM Contract No. FND");
            BlanketOrderLine.SETRANGE("SRM Contract Line No. FND", PurchOrderLine."SRM Contract Line No. FND");
            BlanketOrderLine.SETRANGE(Type, BlanketOrderLine.Type::"G/L Account");
            //HEI.17>>
            //BlanketOrderLine.SETRANGE("No.",GeneralInterfaceSetup."Contract Default G/L Acc. No.");///??????
            BlanketOrderLine.SETRANGE("No.", SRMInterfaceSetup."Contract Default G/L Acc. No.");///??????
            //HEI.17<<
            if BlanketOrderLine.FINDFIRST() then
                InterfaceEntryLine."Blanket Order Line No." := BlanketOrderLine."Line No."
            else
                InterfaceEntryLine."Blanket Order Line No." := PurchOrderLine."Blanket Order Line No.";
        end else
            InterfaceEntryLine."Blanket Order Line No." := PurchOrderLine."Blanket Order Line No.";
        InterfaceEntryLine."CMG Code" := PurchOrderLine."CMG Code FND";
        InterfaceEntryLine."Last Changed Date/Time" := PurchOrderLine."Last Changed Date/Time FND";

        // BC Upgrade PATELS08 >>
        // HEI.105 >>
        InterfaceEntryLine."External Requisition Line No." := PurchOrderLine."Line No.";
        // HEI.105 <<
        // BC Upgrade PATELS08 <<

        InterfaceEntryLine.INSERT();
    end;

    procedure ProcessPOValidationRequest(InterfaceEntryHeader: Record "Interface Entry Header INT");
    begin
        //PO Validation Request
        COMMIT(); // HEI.49
        ProcessPOCreation(InterfaceEntryHeader);
        ERROR(SimulateModeErr);
    end;

    procedure CreatePOValidationResponse(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT"; InterfaceCode: Code[20]; ErrorOccurred: Boolean; ErrorMessage: Text);
    var
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
    begin
        //PO Validation Response
        GetGeneralInterfaceSetup();
        InterfaceSetup.GET(InterfaceCode);
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut."Interface Code" := InterfaceCode;
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeader.Direction::Outbound;
        if ErrorOccurred then begin
            InterfaceEntryHeaderOut."Type ID" := '300';
            InterfaceEntryHeaderOut."Severity Code" := '3';
            InterfaceEntryHeaderOut."Log Message" := COPYSTR(ErrorMessage, 1, MAXSTRLEN(InterfaceEntryHeader."Log Message"));
        end else begin
            InterfaceEntryHeaderOut."Type ID" := '300';
            InterfaceEntryHeaderOut."Severity Code" := '1';
            InterfaceEntryHeaderOut."Log Message" := POValidationSuccessfullyTxt;
        end;
        InterfaceEntryHeaderOut."Message ID" := InterfaceEntryHeader."Message ID";
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Msg. Sender Business System ID" := InterfaceEntryHeader."Msg. Recv. Business System ID";
        if InterfaceEntryHeaderOut."Msg. Sender Business System ID" = '' then
            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := InterfaceEntryHeader."Msg. Sender Business System ID";
        InterfaceEntryHeaderOut.INSERT(true);
        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.findset() then
            repeat
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut.TRANSFERFIELDS(InterfaceEntryLine, false);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                if ErrorOccurred then begin
                    InterfaceEntryLineOut."Type ID" := '300';
                    InterfaceEntryLineOut."Severity Code" := '3';
                    InterfaceEntryLineOut."Log Message" := COPYSTR(ErrorMessage, 1, MAXSTRLEN(InterfaceEntryHeaderOut."Log Message"));
                end else begin
                    InterfaceEntryLineOut."Type ID" := '300';
                    InterfaceEntryLineOut."Severity Code" := '1';
                    InterfaceEntryLineOut."Log Message" := POLineValidationSuccessfullyTxt;
                end;
                InterfaceEntryLineOut.INSERT(true);
            until InterfaceEntryLine.NEXT() = 0;

        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    procedure ProcessPOCreation(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
    begin
        //PO Creation
        GetGeneralInterfaceSetup();
        GetSRMInterfaceSetup(); //HEI.17
        InterfaceEntryHeader.TESTFIELD("Action Code");
        case InterfaceEntryHeader."Action Code" of
            //HEI.17>>
            //GeneralInterfaceSetup."SRM Create Action Code":
            SRMInterfaceSetup."SRM Create Action Code":
                //HEI.17<<
                begin
                    UpdatePurchaseOrderHeader(PurchaseHeader, InterfaceEntryHeader, true);
                    CreatePOConfirmationHeader(InterfaceEntryHeader, InterfaceEntryHeaderOut, PurchaseHeader);

                    InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                    if InterfaceEntryLine.findset() then
                        repeat
                            InterfaceEntryLine.TESTFIELD("Action Code");
                            case InterfaceEntryLine."Action Code" of
                                //HEI.17>>
                                //GeneralInterfaceSetup."SRM Create Action Code":
                                SRMInterfaceSetup."SRM Create Action Code":
                                    //HEI.17<<
                                    begin
                                        //>> HEI.23
                                        PurchaseLine.SETRANGE("SRM Order No. FND", InterfaceEntryHeader."External Order No.");
                                        PurchaseLine.SETRANGE("SRM Order Line No. FND", FORMAT(InterfaceEntryLine."External Order Line No."));
                                        if PurchaseLine.FINDFIRST() then
                                            UpdatePurchaseOrderLine(PurchaseHeader, PurchaseLine, InterfaceEntryHeader, InterfaceEntryLine, false)
                                        else
                                            UpdatePurchaseOrderLine(PurchaseHeader, PurchaseLine, InterfaceEntryHeader, InterfaceEntryLine, true);
                                        //<< HEI.23
                                        //HEI.57>>
                                        //IF NOT (( PurchaseLine."Blanket Order No." = '')AND(PurchaseLine."Blanket Order Line No." =0)) THEN
                                        //HEI.57<<
                                        CreatePOConfirmationLine(InterfaceEntryLine, InterfaceEntryHeaderOut, InterfaceEntryLineOut, PurchaseLine);
                                    end;
                                //HEI.17>>
                                //GeneralInterfaceSetup."SRM Change Action Code":
                                SRMInterfaceSetup."SRM Change Action Code":
                                    //HEI.17<<
                                    begin
                                        //>> HEI.23
                                        PurchaseLine.SETRANGE("SRM Order No. FND", InterfaceEntryHeader."External Order No.");
                                        PurchaseLine.SETRANGE("SRM Order Line No. FND", FORMAT(InterfaceEntryLine."External Order Line No."));
                                        if PurchaseLine.FINDFIRST() then
                                            UpdatePurchaseOrderLine(PurchaseHeader, PurchaseLine, InterfaceEntryHeader, InterfaceEntryLine, false)
                                        else
                                            UpdatePurchaseOrderLine(PurchaseHeader, PurchaseLine, InterfaceEntryHeader, InterfaceEntryLine, true);
                                        //<< HEI.23
                                        //HEI.57>>
                                        //IF NOT (( PurchaseLine."Blanket Order No." = '')AND(PurchaseLine."Blanket Order Line No." =0)) THEN
                                        //HEI.57<<
                                        CreatePOConfirmationLine(InterfaceEntryLine, InterfaceEntryHeaderOut, InterfaceEntryLineOut, PurchaseLine);
                                    end;
                                //HEI.17>>
                                //GeneralInterfaceSetup."SRM Close Action Code":
                                SRMInterfaceSetup."SRM Close Action Code":
                                    //HEI.17<<
                                    begin
                                        DeletePurchaseOrderLine(PurchaseHeader, PurchaseLine, InterfaceEntryHeader, InterfaceEntryLine);
                                        //HEI.57>>
                                        //IF NOT (( PurchaseLine."Blanket Order No." = '')AND(PurchaseLine."Blanket Order Line No." =0)) THEN
                                        //HEI.57<<
                                        CreatePOConfirmationLine(InterfaceEntryLine, InterfaceEntryHeaderOut, InterfaceEntryLineOut, PurchaseLine);
                                    end;
                            end;
                        until InterfaceEntryLine.NEXT() = 0;
                end;
            //HEI.17>>
            //GeneralInterfaceSetup."SRM Change Action Code":
            SRMInterfaceSetup."SRM Change Action Code":
                //HEI.17<<
                begin
                    UpdatePurchaseOrderHeader(PurchaseHeader, InterfaceEntryHeader, false);
                    CreatePOConfirmationHeader(InterfaceEntryHeader, InterfaceEntryHeaderOut, PurchaseHeader);

                    InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                    if InterfaceEntryLine.findset() then
                        repeat
                            InterfaceEntryLine.TESTFIELD("Action Code");
                            case InterfaceEntryLine."Action Code" of
                                //HEI.17<<
                                //GeneralInterfaceSetup."SRM Create Action Code":
                                SRMInterfaceSetup."SRM Create Action Code":
                                    //HEI.17>>
                                    begin
                                        UpdatePurchaseOrderLine(PurchaseHeader, PurchaseLine, InterfaceEntryHeader, InterfaceEntryLine, true);
                                        //HEI.57>>
                                        //  IF NOT (( PurchaseLine."Blanket Order No." = '')AND(PurchaseLine."Blanket Order Line No." =0)) THEN
                                        //HEI.57<<
                                        CreatePOConfirmationLine(InterfaceEntryLine, InterfaceEntryHeaderOut, InterfaceEntryLineOut, PurchaseLine);
                                    end;
                                //HEI.17>>
                                //GeneralInterfaceSetup."SRM Change Action Code":
                                SRMInterfaceSetup."SRM Change Action Code":
                                    //HEI.17<<
                                    begin
                                        UpdatePurchaseOrderLine(PurchaseHeader, PurchaseLine, InterfaceEntryHeader, InterfaceEntryLine, false);
                                        //HEI.57>>
                                        //IF NOT (( PurchaseLine."Blanket Order No." = '')AND(PurchaseLine."Blanket Order Line No." =0)) THEN
                                        //HEI.57<<
                                        CreatePOConfirmationLine(InterfaceEntryLine, InterfaceEntryHeaderOut, InterfaceEntryLineOut, PurchaseLine);
                                    end;
                                //HEI.17>>
                                //GeneralInterfaceSetup."SRM Close Action Code":
                                SRMInterfaceSetup."SRM Close Action Code":
                                    //HEI.17<<
                                    begin
                                        DeletePurchaseOrderLine(PurchaseHeader, PurchaseLine, InterfaceEntryHeader, InterfaceEntryLine);
                                        //HEI.57>>
                                        //IF NOT (( PurchaseLine."Blanket Order No." = '')AND(PurchaseLine."Blanket Order Line No." =0)) THEN
                                        //HEI.57<<
                                        CreatePOConfirmationLine(InterfaceEntryLine, InterfaceEntryHeaderOut, InterfaceEntryLineOut, PurchaseLine);
                                    end;
                            end;
                        until InterfaceEntryLine.NEXT() = 0;
                end;
            //HEI.17>>
            //GeneralInterfaceSetup."SRM Close Action Code":
            SRMInterfaceSetup."SRM Close Action Code":
                //HEI.17<<
                begin
                    DeletePurchaseOrderHeader(PurchaseHeader, InterfaceEntryHeader);
                    CreatePOConfirmationHeader(InterfaceEntryHeader, InterfaceEntryHeaderOut, PurchaseHeader);
                end;
        end;

        //HEI.03>>
        //>> HEI.24
        if PurchaseHeader.GET(InterfaceEntryHeader."Source Subtype", InterfaceEntryHeader."External Order No.") then begin
            PurchaseLine.RESET();
            PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            PurchaseLine.SETFILTER(Quantity, '>%1', 0);
            if PurchaseLine.FINDFIRST() then begin
                InterfaceSetup.GET(InterfaceEntryHeader."Interface Code");
                if InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Asynchronous then
                    CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeader)
            end;
        end;
        //<< HEI.24
        //HEI.03<<
    end;

    local procedure UpdatePurchaseOrderHeader(var PurchaseHeader: Record "Purchase Header"; InterfaceEntryHeader: Record "Interface Entry Header INT"; WithInsert: Boolean);
    var
        // TempBlob: Record TempBlob temporary;  // BC Upgrade NANDIS03 - Blocked as Tempblob Record is obsolete
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03 - Blocked as Tempblob Record is obsolete
        ReleasePurchDoc: Codeunit "Release Purchase Document";
        User: Record User;
        UserSetup: Record "User Setup";
    begin
        //PO Creation - order header
        GetPurchSetup();
        if WithInsert then begin
            if PurchaseHeader.GET(InterfaceEntryHeader."Source Subtype", InterfaceEntryHeader."External Order No.") then
                exit;
            CLEAR(PurchaseHeader);
            if not GUIALLOWED then
                PurchaseHeader.SetHideValidationDialog(true);
            PurchaseHeader.VALIDATE("Document Type", InterfaceEntryHeader."Source Subtype");
            PurchaseHeader.VALIDATE("No.", InterfaceEntryHeader."External Order No.");
            PurchaseHeader.INSERT(true);
        end else begin
            PurchaseHeader.GET(InterfaceEntryHeader."Source Subtype", InterfaceEntryHeader."Source No.");
            if not GUIALLOWED then
                PurchaseHeader.SetHideValidationDialog(true);
            ReleasePurchDoc.Reopen(PurchaseHeader);
        end;

        if InterfaceEntryHeader."Buy-from Vendor No." <> PurchaseHeader."Buy-from Vendor No." then
            PurchaseHeader.VALIDATE("Buy-from Vendor No.", InterfaceEntryHeader."Buy-from Vendor No.");
        //SP
        //>>HEI.17
        //IF InterfaceEntryHeader."Interface Code" = SRMInterfaceSetup."PO Validation Req. Interface" THEN
        if (PurchaseHeader."Buy-from Vendor No." = '') and (SRMInterfaceSetup."SRM Default Vendor" <> '') then
            PurchaseHeader.VALIDATE("Buy-from Vendor No.", SRMInterfaceSetup."SRM Default Vendor");
        //END;

        //<<HEI.17
        //SP

        if IsChangedValue(PurchaseHeader."Posting Date", InterfaceEntryHeader."Posting Date") then //HEI.47
            PurchaseHeader.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
        PurchaseHeader.VALIDATE("SRM Order No. FND", InterfaceEntryHeader."External Order No.");
        PurchaseHeader.VALIDATE("SRM Version No. FND", InterfaceEntryHeader."Version No.");
        if IsChangedValue(PurchaseHeader."Shipment Method Code", InterfaceEntryHeader."Shipment Method") then //HEI.47
            if (InterfaceEntryHeader."Shipment Method" <> '') then  //HEI.83
                PurchaseHeader.VALIDATE("Shipment Method Code", InterfaceEntryHeader."Shipment Method");
        PurchaseHeader.VALIDATE("Shipment Method Location FND", InterfaceEntryHeader."Shipment Method Location");
        if InterfaceEntryHeader."Salespers./Purch. Code" <> PurchaseHeader."Purchaser Code" then
            PurchaseHeader.VALIDATE("Purchaser Code", InterfaceEntryHeader."Salespers./Purch. Code");
        PurchaseHeader.VALIDATE("Payment Terms Code", InterfaceEntryHeader."Payment Terms Code");
        if (InterfaceEntryHeader.Description <> '') then  //HEI.69
            PurchaseHeader.VALIDATE("Posting Description", InterfaceEntryHeader.Description);
        PurchaseHeader.VALIDATE("Document Subtype Code FND", PurchSetup."PO Subtype Code FND");  // BC Upgrade SHUKLP03
        //>> HEI.29
        if InterfaceEntryHeader.Contact <> '' then begin
            // User.SETRANGE("User Name", 'HEIWAY\' + InterfaceEntryHeader.Contact); // HEI.31
            User.SETRANGE("User Name", InterfaceEntryHeader.Contact); // HEI.31
            if not User.FINDFIRST() then begin
                Error('UserID  %1 not Found in user table', InterfaceEntryHeader.Contact);
                // BC Upgrade BHARDA11 >>
                // User.INIT();
                // User."User Security ID" := CREATEGUID();
                // // User.VALIDATE("User Name", 'HEIWAY\' + InterfaceEntryHeader.Contact); //HEI.31
                // User.VALIDATE("User Name", InterfaceEntryHeader.Contact); //HEI.31
                // if User.INSERT() then begin
                //     UserSetup.INIT();
                //     UserSetup.VALIDATE("User ID", User."User Name");
                //     UserSetup.INSERT();
                //     // PurchaseHeader.VALIDATE("Created By", User."User Name");  // BC Upgrade NANDIS03 - Dependency on DIT field
                // end;
                // BC Upgrade BHARDA11 <<
            end else begin
                //>> HEI.32
                UserSetup.SETRANGE("User ID", User."User Name");
                // BC Upgrade NANDIS03 - Dependency on DIT field >>
                // if UserSetup.FINDFIRST then
                //     PurchaseHeader.VALIDATE("Created By", UserSetup."User ID")
                // else begin
                //     UserSetup.INIT;
                //     UserSetup.VALIDATE("User ID", User."User Name");
                //     UserSetup.INSERT;
                //     //PurchaseHeader.VALIDATE("Created By",'HEIWAY\'+InterfaceEntryHeader.Contact); //HEI.31
                //     PurchaseHeader.VALIDATE("Created By", UserSetup."User ID");
                //     //<< HEI.32
                // end;
                // BC Upgrade NANDIS03 - Dependency on DIT field <<
            end;
        end;
        //<< HEI.29
        PurchaseHeader.MODIFY(true);

        if InterfaceEntryHeader.Notes.HASVALUE then begin
            CLEAR(TempBlob);
            InterfaceEntryHeader.CALCFIELDS(Notes);
            //TempBlob.Blob := InterfaceEntryHeader.Notes;  // BC Upgrade NANDIS03 - Temporarily blocked
            CreateNoteRecordLink(TempBlob, PurchaseHeader.RECORDID, DATABASE::"Purchase Header", PAGE::"Blanket Purchase Orders",
                                 FORMAT(PurchaseHeader."Document Type") + ' ' + PurchaseHeader."No.");
        end;
    end;

    local procedure UpdatePurchaseOrderLine(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; InterfaceEntryHeader: Record "Interface Entry Header INT"; InterfaceEntryLine: Record "Interface Entry Line INT"; WithInsert: Boolean);
    var
        PurchBlanketOrderLine: Record "Purchase Line";
        // TempBlob: Record TempBlob temporary; // BC Upgrade NANDIS03 - Blocked as Tempblob record type is obsolete
        TempBlob: Codeunit "Temp Blob"; // BC Upgrade NANDIS03 - Added as Tempblob record type is obsolete
        ReleasePurchDoc: Codeunit "Release Purchase Document";
        PurchLineNo: Integer;
        VATPostingSetup: Record "VAT Posting Setup";
        Text001: TextConst ENU = 'The %1 combination ''%2'' ''%3'' does not exist for %4 %5.', FRA = 'La %1 combinaison %2 %3 n''existe pas pour %4 %5.';
        FixedAsset: Record "Fixed Asset";
        User: Record User;
        UserSetup: Record "User Setup";
        LicenseCodeValue: Code[20];
        DimSetEntryRec: Record "Dimension Set Entry";
        I: Integer;
        PurchLineRec: Record "Purchase Line";
        LicenseCodeValue_1: Code[20];
        DimSetEntryRec_1: Record "Dimension Set Entry";
        PurchaseLineRec: Record "Purchase Line";
        PurchLneRec: Record "Purchase Line";
        GenLedSetRec: Record "General Ledger Setup";
        Text004: Label 'Dimensions Value should be same for all the purchase lines.';
        PurchHdrAddiRec: Record "Purchase Header Additional FND";
        PrevRemainingAmt: Decimal;
        PrevUnitCost: Decimal;
        Item: Record Item;
        Loc_DimensionSetEntry: Record "Dimension Set Entry";
        POSMItemValidation: Label 'The Item %1 does not exist';
        ItemGLTogether: Label 'Both accounting code and item can not be accepted to process the PO, please use Direct Items';
    begin
        //PO Creation - order line
        GetGLSetup();
        if WithInsert then begin
            PurchaseLine.RESET();
            PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            if PurchaseLine.FINDLAST() then
                PurchLineNo := PurchaseLine."Line No.";

            CLEAR(PurchaseLine);
            // if not GUIALLOWED then // BC Upgrade BHARDA11 --11April2026 Block this line of code;
            //PurchaseLine.SetHideValidationDialog(true);   // BC Upgrade SHUKLP03 << Blocked because of DrinkIT procedure SetHideValidationDialog().
            PurchaseLine.VALIDATE("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.VALIDATE("Document No.", PurchaseHeader."No.");
            PurchLineNo := PurchLineNo + 10000;
            PurchaseLine."Line No." := PurchLineNo;
        end else begin
            ReleasePurchDoc.Reopen(PurchaseHeader);
            PurchaseLine.RESET();
            //>> HEI.26
            if InterfaceEntryLine."Action Code" = SRMInterfaceSetup."SRM Create Action Code" then begin
                PurchaseLine.SETRANGE("SRM Order No. FND", InterfaceEntryHeader."External Order No.");
                PurchaseLine.SETRANGE("SRM Order Line No. FND", FORMAT(InterfaceEntryLine."External Order Line No."));
                PurchaseLine.FINDFIRST();
            end else begin
                PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                PurchaseLine.SETRANGE("Line No.", InterfaceEntryLine."Source Line No.");
                PurchaseLine.FINDFIRST();
            end;
            //<< HEI.26

            // BC Upgrade SHUKLP03 >>  Blocked because of DrinkIT procedure SetHideValidationDialog().
            // if not GUIALLOWED then
            //     PurchaseLine.SetHideValidationDialog(true);
            // BC Upgrade SHUKLP03 >>  Blocked because of DrinkIT procedure SetHideValidationDialog().

        end;

        //HEI.85>>
        if (InterfaceEntryLine."Global No." <> '') and (InterfaceEntryLine."No." <> '') then
            //HEI.92>>
            //Forcefully considering as G/L and Removing material ID if both coming together.
            //ERROR(ItemGLTogether);
            InterfaceEntryLine."Global No." := '';
        //HEI.92<<
        //HEI.85<<

        CreateContractLineForSRMCallOff(InterfaceEntryLine, PurchBlanketOrderLine);
        //HEI.21>>
        if InterfaceEntryLine."Project Code" <> '' then begin
            if FixedAsset.GET(InterfaceEntryLine."Project Code") then begin
                if IsChangedValue(PurchaseLine.Type, InterfaceEntryLine.Type) then //HEI.47
                    PurchaseLine.VALIDATE(Type, InterfaceEntryLine.Type::"Fixed Asset");
                if IsChangedValue(PurchaseLine."No.", InterfaceEntryLine."Project Code") then //HEI.47
                    PurchaseLine.VALIDATE("No.", InterfaceEntryLine."Project Code");
            end else begin
                if IsChangedValue(PurchaseLine.Type, InterfaceEntryLine.Type) then //HEI.47
                    PurchaseLine.VALIDATE(Type, InterfaceEntryLine.Type);
                if IsChangedValue(PurchaseLine."No.", InterfaceEntryLine."No.") then //HEI.47
                    PurchaseLine.VALIDATE("No.", InterfaceEntryLine."No.");
            end
        end else begin
            //HEI.76>>
            if (InterfaceEntryLine."Global No." <> '') then begin
                if Item.GET(InterfaceEntryLine."Global No.") then begin
                    PurchaseLine.VALIDATE(Type, PurchaseLine.Type::Item);
                    if IsChangedValue(PurchaseLine."No.", InterfaceEntryLine."Global No.") then
                        PurchaseLine.VALIDATE("No.", InterfaceEntryLine."Global No.");
                end else
                    ERROR(STRSUBSTNO(POSMItemValidation, InterfaceEntryLine."Global No."));  //HEI.78
                                                                                             //ERROR('The Item %1 does not exist',InterfaceEntryLine."Global No."));  //HEI.78
            end else begin
                //HEI.76<<
                //HEI.21<<
                if IsChangedValue(PurchaseLine.Type, InterfaceEntryLine.Type) then //HEI.47
                    PurchaseLine.VALIDATE(Type, InterfaceEntryLine.Type);
                if IsChangedValue(PurchaseLine."No.", InterfaceEntryLine."No.") then //HEI.47
                    PurchaseLine.VALIDATE("No.", InterfaceEntryLine."No.");
                //HEI.03>>
                //HEI.21>>
            end;
        end;  //HEI.76
        //HEI.21<<
        if not VATPostingSetup.GET(PurchaseLine."VAT Bus. Posting Group", PurchaseLine."VAT Prod. Posting Group") then
            ERROR(Text001, VATPostingSetup.TABLECAPTION, PurchaseLine."VAT Bus. Posting Group", PurchaseLine."VAT Prod. Posting Group", PurchaseLine.Type, PurchaseLine."No.");
        //HEI.03<<
        //PurchaseLine.VALIDATE("Cross-Reference No.",InterfaceEntryLine."Cross Reference No.");
        PurchaseLine."Blanket Order No." := PurchBlanketOrderLine."Document No.";
        PurchaseLine."Blanket Order Line No." := PurchBlanketOrderLine."Line No.";
        PurchaseLine.Description := InterfaceEntryLine.Description;
        PurchaseLine."Description 2" := InterfaceEntryLine."Description 2";
        //HEI.82>>
        if (InterfaceEntryLine."Global No." <> '') and (PurchaseHeader."Location Code" = '') then begin
            if (InterfaceEntryLine."Location Code" <> '') then begin
                PurchaseHeader.SetHideValidationDialog(true);
                PurchaseHeader.VALIDATE("Location Code", InterfaceEntryLine."Location Code");
                PurchaseHeader.MODIFY();
            end;
        end;
        //HEI.82<<
        PurchaseLine.VALIDATE("Location Code", InterfaceEntryLine."Location Code");
        if InterfaceEntryLine."Unit of Measure Code" <> '' then begin
            //>> HEI.47
            if IsChangedValue(PurchaseLine."Unit of Measure Code", InterfaceEntryLine."Unit of Measure Code") then
                PurchaseLine.VALIDATE("Unit of Measure Code", InterfaceFrameworkMgt.GetISOCodeUnitOfMeasure(InterfaceEntryLine."Unit of Measure Code"));
        end;
        //<< HEI.47
        if InterfaceEntryLine.Quantity <> 0 then begin
            //>> HEI.47
            if IsChangedValue(PurchaseLine.Quantity, InterfaceEntryLine.Quantity) then
                if not CheckIfPurchRcptExist(PurchaseLine) then // HEI.51
                    PurchaseLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity)
                else if PurchaseLine.Quantity < InterfaceEntryLine.Quantity then
                    PurchaseLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
            //<< HEI.47
        end else
            if not CheckIfPurchRcptExist(PurchaseLine) then // HEI.51
                PurchaseLine.VALIDATE(Quantity, 1);
        //HEI.34>>
        PurchaseLine.VALIDATE("Qty. to Receive", 0);
        //HEI.34<<

        //>>HEI.44
        if IsLimitPO(PurchaseHeader) and (InterfaceEntryLine."Action Code" = SRMInterfaceSetup."SRM Change Action Code") then
            PrevUnitCost := PurchaseLine."Direct Unit Cost";
        //<<HEI.44
        if InterfaceEntryLine."Currency Code" <> '' then begin //HEI.43
            if InterfaceEntryLine."Currency Code" <> GLSetup."LCY Code" then begin //HEI.08
                PurchaseLine.VALIDATE("Currency Code", InterfaceEntryLine."Currency Code");
                //HEI.08>>
                if ((PurchaseHeader."Currency Code" = '') or (PurchaseHeader."Currency Code" <> PurchaseLine."Currency Code")) and (InterfaceEntryLine."Currency Code" <> '') then begin//HEI.09
                    PurchaseHeader.VALIDATE("Currency Code", PurchaseLine."Currency Code");
                    PurchaseHeader.MODIFY();
                end;
            end
            //HEI.08<<
            //HEI.10>>
            else begin
                PurchaseLine.VALIDATE("Currency Code", '');
                //HEI.08>>
                if ((PurchaseHeader."Currency Code" = '') or (PurchaseHeader."Currency Code" <> PurchaseLine."Currency Code")) and (InterfaceEntryLine."Currency Code" <> '') then begin//HEI.09
                    PurchaseHeader.VALIDATE("Currency Code", PurchaseLine."Currency Code");
                    PurchaseHeader.MODIFY();
                end;
            end;
        end; //HEI.43
             //HEI.10<<

        //>> HEI.43
        if InterfaceEntryLine."Currency Code Limit PO" <> '' then begin
            if InterfaceEntryLine."Currency Code Limit PO" <> GLSetup."LCY Code" then begin
                PurchaseLine.VALIDATE("Currency Code", InterfaceEntryLine."Currency Code Limit PO");
                if ((PurchaseHeader."Currency Code" = '') or (PurchaseHeader."Currency Code" <> PurchaseLine."Currency Code")) and (InterfaceEntryLine."Currency Code Limit PO" <> '') then begin
                    PurchaseHeader.VALIDATE("Currency Code", PurchaseLine."Currency Code");
                    PurchaseHeader.MODIFY();
                end;
            end
            else begin
                PurchaseLine.VALIDATE("Currency Code", '');
                if ((PurchaseHeader."Currency Code" = '') or (PurchaseHeader."Currency Code" <> PurchaseLine."Currency Code")) and (InterfaceEntryLine."Currency Code Limit PO" <> '') then begin
                    PurchaseHeader.VALIDATE("Currency Code", PurchaseLine."Currency Code");
                    PurchaseHeader.MODIFY();
                end;
            end;
        end;
        //<< HEI.43
        /*
        IF InterfaceEntryLine."Direct Unit Cost Multiplier" <> 0 THEN
          PurchaseLine.VALIDATE("Direct Unit Cost",ROUND(InterfaceEntryLine."Direct Cost Per Multiplier" / InterfaceEntryLine."Direct Unit Cost Multiplier",
                                                         GLSetup."Unit-Amount Rounding Precision"))
        ELSE BEGIN
          IF InterfaceEntryLine."Direct Cost Per Multiplier" <> 0 THEN
            PurchaseLine.VALIDATE("Direct Unit Cost",InterfaceEntryLine."Direct Cost Per Multiplier")
          ELSE
            PurchaseLine.VALIDATE("Direct Unit Cost",ROUND(InterfaceEntryLine."Line Amount" / PurchaseLine.Quantity,GLSetup."Unit-Amount Rounding Precision"));
        END;
        */
        if InterfaceEntryLine."Direct Cost Per Multiplier" <> 0 then begin
            // BC Upgrade NANDIS03 - Dependency on DIT field >>
            // if (PurchaseLine.Type = PurchaseLine.Type::Item) and (InterfaceEntryLine."Global No." <> '') and (PurchaseLine.Quantity <> 0) then  //HEI.80
            //     PurchaseLine.VALIDATE("Item Charge Value", InterfaceEntryLine."Direct Cost Per Multiplier");  //HEI.80
            // BC Upgrade NANDIS03 - Dependency on DIT field <<
            PurchaseLine.VALIDATE("Direct Unit Cost", InterfaceEntryLine."Direct Cost Per Multiplier")
            //>> HEI.43
        end else if InterfaceEntryLine."Direct Cost Per Mult. Limit PO" <> 0 then
                PurchaseLine.VALIDATE("Direct Unit Cost", InterfaceEntryLine."Direct Cost Per Mult. Limit PO")
        //<< HEI.43
        else
            PurchaseLine.VALIDATE("Direct Unit Cost", ROUND(InterfaceEntryLine."Line Amount" / PurchaseLine.Quantity, GLSetup."Unit-Amount Rounding Precision"));

        //HEI.02>>

        //>> HEI.44
        if IsLimitPO(PurchaseHeader) then begin
            if CheckAdditionalLines(InterfaceEntryLine, PurchaseHeader) then begin
                PurchaseLine.VALIDATE("Direct Unit Cost", PrevUnitCost);
                PurchaseLine.VALIDATE("Remaining Amount FND", InterfaceEntryLine."Direct Cost Per Mult. Limit PO" -
                                     FindLinesUnitCost(InterfaceEntryLine, PurchaseHeader, true) - PrevUnitCost);
                PurchaseLine.VALIDATE("Initial Amount FND", InterfaceEntryLine."Direct Cost Per Mult. Limit PO");
                UpdateLastOpenLine(InterfaceEntryLine, PurchaseHeader, PurchaseLine, PrevUnitCost);
            end else begin
                PurchaseLine.VALIDATE("Initial Amount FND", PurchaseLine."Line Amount");
                PurchaseLine.VALIDATE("Remaining Amount FND", PurchaseLine."Line Amount");
            end
        end else begin
            PurchaseLine.VALIDATE("Initial Amount FND", PurchaseLine."Line Amount");
            PurchaseLine.VALIDATE("Remaining Amount FND", PurchaseLine."Line Amount");
        end;
        //<< HEI.44

        //HEI.02<<
        PurchaseLine.VALIDATE("SRM Order No. FND", InterfaceEntryHeader."External Order No.");
        PurchaseLine.VALIDATE("SRM Order Line No. FND", InterfaceEntryLine."External Order Line No.");
        PurchaseLine.VALIDATE("SRM Contract No. FND", InterfaceEntryLine."External Contract No.");
        PurchaseLine.VALIDATE("SRM Contract Line No. FND", InterfaceEntryLine."External Contract Line No.");
        PurchaseLine.VALIDATE("CMG Code FND", InterfaceEntryLine."CMG Code");
        //PurchaseLine.VALIDATE("Shipment Method Code",InterfaceEntryLine."Shipping Method");
        //PurchaseLine.VALIDATE("Shipping Agent Service Code",InterfaceEntryLine."Shipping Agent Service Code");
        PurchaseLine.VALIDATE("Expected Receipt Date", InterfaceEntryLine."Event Date"); //HEI.27
        PurchaseLine."Dimension Set ID" := GetLineDimensionSetID(InterfaceEntryLine, PurchaseLine."Dimension Set ID");
        //HEI.40 >>
        PurchaseLine."Delivery Finalized FND" := InterfaceEntryLine."Delivery Finalized";
        //HEI.40 <<
        //HEI.35 >>

        GenLedSetRec.RESET();
        GenLedSetRec.GET();
        if GenLedSetRec."License Dimension Code FND" <> '' then begin
            CLEAR(LicenseCodeValue);
            I := 1;
            PurchaseLineRec.RESET();
            PurchaseLineRec.SETRANGE("Document Type", PurchaseLine."Document Type");
            PurchaseLineRec.SETRANGE("Document No.", PurchaseLine."No.");
            if PurchaseLineRec.FINDFIRST() then begin
                DimSetEntryRec.RESET();
                DimSetEntryRec.SETRANGE("Dimension Set ID", PurchaseLineRec."Dimension Set ID");
                DimSetEntryRec.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                if DimSetEntryRec.FINDFIRST() then
                    LicenseCodeValue := DimSetEntryRec."Dimension Value Code"
            end;
            CLEAR(LicenseCodeValue_1);
            PurchLneRec.RESET();
            PurchLneRec.SETRANGE("Document Type", PurchaseLine."Document Type");
            PurchLneRec.SETRANGE("Document No.", PurchaseLine."No.");
            if PurchLneRec.FINDFIRST() then begin
                repeat
                    DimSetEntryRec_1.RESET();
                    DimSetEntryRec_1.SETRANGE("Dimension Set ID", PurchLneRec."Dimension Set ID");
                    DimSetEntryRec_1.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                    if DimSetEntryRec.FINDFIRST() then
                        LicenseCodeValue_1 := DimSetEntryRec."Dimension Value Code";

                    if LicenseCodeValue_1 <> '' then begin
                        if LicenseCodeValue <> LicenseCodeValue_1 then
                            ERROR(Text004);
                    end;
                until PurchLneRec.NEXT() = 0;
                if LicenseCodeValue = LicenseCodeValue_1 then begin
                    PurchHdrAddiRec.RESET();
                    if PurchHdrAddiRec.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") then begin
                        PurchHdrAddiRec."License Code" := LicenseCodeValue_1;
                        PurchHdrAddiRec.MODIFY();
                    end;
                end;
            end;
        end;
        //HEI.35 <<

        //HEI.77>>
        if PurchaseLine."Dimension Set ID" <> 0 then
            if Loc_DimensionSetEntry.GET(PurchaseLine."Dimension Set ID", GenLedSetRec."Global Dimension 1 Code") then
                PurchaseLine."Shortcut Dimension 1 Code" := Loc_DimensionSetEntry."Dimension Value Code";
        //HEI.77<<

        //>> HEI.28
        if InterfaceEntryLine.Contact <> '' then begin
            // User.SETRANGE("User Name", 'HEIWAY\' + InterfaceEntryLine.Contact); //HEI.31
            User.SETRANGE("User Name", InterfaceEntryLine.Contact); //HEI.31
            if not User.FINDFIRST() then begin
                Error('UserID  %1 not Found in user table', InterfaceEntryLine.Contact);
                // BC Upgrade BHARDA11 -- 20April2026 >>
                // User.INIT();
                // User."User Security ID" := CREATEGUID();
                // // User.VALIDATE("User Name", 'HEIWAY\' + InterfaceEntryLine.Contact); //HEI.31
                // User.VALIDATE("User Name", InterfaceEntryLine.Contact); //HEI.31
                // if User.INSERT() then begin
                //     UserSetup.INIT();
                //     UserSetup.VALIDATE("User ID", User."User Name");
                //     UserSetup.INSERT();
                //     // PurchaseHeader.VALIDATE("Requester ID", 'HEIWAY\' + InterfaceEntryLine.Contact); //HEI.31  // BC Upgrade NANDIS03 - Dependency on DIT field 
                //     PurchaseHeader.MODIFY();
                // end;
                // BC Upgrade BHARDA11 -- 20April2026 <<
            end else begin
                //>> HEI.32
                UserSetup.SETRANGE("User ID", User."User Name");
                if UserSetup.FINDFIRST() then begin
                    // PurchaseHeader.VALIDATE("Requester ID", UserSetup."User ID");  // BC Upgrade NANDIS03 - Dependency on DIT field 
                    PurchaseHeader.MODIFY();
                end else begin
                    UserSetup.INIT();
                    UserSetup.VALIDATE("User ID", User."User Name");
                    UserSetup.INSERT();
                    // PurchaseHeader.VALIDATE("Requester ID", UserSetup."User ID");  // BC Upgrade NANDIS03 - Dependency on DIT field >>
                    //PurchaseHeader.VALIDATE("Requester ID",User."User Name");
                    //<< HEI.32
                    PurchaseHeader.MODIFY();
                end;
            end;
        end;
        //<< HEI.28

        if (PurchaseLine.Type <> PurchaseLine.Type::Item) then  //HEI.78
                                                                //HEI.06>>
            if InterfaceEntryLine."Cost Center Code" = '' then
                ERROR(CCCDimenssionErr, PurchaseLine."No.");
        //HEI.06<<
        if InterfaceEntryLine."Global No." = '' then //HEI.90
            PurchaseLine.VALIDATE("Shortcut Dimension 2 Code", InterfaceEntryLine."Cost Center Code");
        //HEI.91>>
        if (InterfaceEntryLine."Global No." <> '') and (InterfaceEntryLine."Cost Center Code" <> '') then
            PurchaseLine.VALIDATE("Shortcut Dimension 2 Code", InterfaceEntryLine."Cost Center Code");

        if (InterfaceEntryLine."Global No." <> '') and (InterfaceEntryLine."CMG Code" <> '') then begin
            PurchaseLine.VALIDATE("CMG Code FND", InterfaceEntryLine."CMG Code");
            PurchaseLine.ValidateShortcutDimCode(5, InterfaceEntryLine."CMG Code");
        end;
        //HEI.91<<
        if (PurchaseLine.Type = PurchaseLine.Type::"G/L Account") or
           (PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset") then begin //>> HEI.17//SP //HEi.36
            CheckEbf(PurchaseLine."No.", PurchaseLine."Dimension Set ID");
            //CheckDimenssionOnPOCreation(PurchaseHeader);//SP //>>HEI.17
            CheckDimValueOnPOCreation(PurchaseLine);//>>HEI.17
            CheckMandatoryFieldsonPOCreation(PurchaseLine); //HEI.30 - Bug fix

        end;//SP//<<HEI.17
        UpdatePurchaseOrderShippingAddress(PurchaseHeader, InterfaceEntryLine);

        if WithInsert then
            PurchaseLine.INSERT(true)
        else
            PurchaseLine.MODIFY(true);

        if InterfaceEntryLine.Notes.HASVALUE then begin
            CLEAR(TempBlob);
            InterfaceEntryLine.CALCFIELDS(Notes);
            // TempBlob.Blob := InterfaceEntryLine.Notes;  // BC Upgrade NANDIS03 - Blocked temporarily
            CreateNoteRecordLink(TempBlob, PurchaseLine.RECORDID, DATABASE::"Purchase Line", PAGE::"Purchase Line Notes CBN",
                                 FORMAT(PurchaseLine."Document Type") + ' ' + PurchaseLine."No." + ' ' + FORMAT(PurchaseLine."Line No."));
        end;

    end;

    local procedure UpdatePurchaseOrderShippingAddress(var PurchaseHeader: Record "Purchase Header"; InterfaceEntryLine: Record "Interface Entry Line INT");
    begin
        PurchaseHeader.VALIDATE("Ship-to Name", InterfaceEntryLine."Ship-to Name");
        PurchaseHeader.VALIDATE("Ship-to Address", InterfaceEntryLine."Ship-to Address");
        PurchaseHeader.VALIDATE("Ship-to Address 2", InterfaceEntryLine."Ship-to Address 2");
        PurchaseHeader.VALIDATE("Ship-to City", InterfaceEntryLine."Ship-to City");
        PurchaseHeader.VALIDATE("Ship-to Post Code", InterfaceEntryLine."Ship-to Post Code");
        PurchaseHeader.VALIDATE("Ship-to Country/Region Code", InterfaceEntryLine."Ship-to Country/Region Code");
    end;

    local procedure CreateContractLineForSRMCallOff(InterfaceEntryLine: Record "Interface Entry Line INT"; var PurchBlanketOrderLine2: Record "Purchase Line");
    var
        PurchBlanketOrderHeader: Record "Purchase Header";
        PurchBlanketOrderLine: Record "Purchase Line";
        PurchLineNo: Integer;
    begin
        if InterfaceEntryLine."External Contract Line No." = '' then
            exit;

        GetGeneralInterfaceSetup();

        PurchBlanketOrderLine.SETRANGE("Document Type", PurchBlanketOrderLine."Document Type"::"Blanket Order");
        //HEI.92>>
        if (InterfaceEntryLine."Global No." <> '') and (InterfaceEntryLine."No." <> '') then
            //Forcefully considering as G/L and Removing material ID if both coming together.
            InterfaceEntryLine."Global No." := '';
        //HEI.92<<
        //HEI.91>>
        if InterfaceEntryLine."Global No." = '' then begin
            //HEI.91<<
            PurchBlanketOrderLine.SETRANGE(Type, InterfaceEntryLine.Type);
            PurchBlanketOrderLine.SETRANGE("No.", InterfaceEntryLine."No.");
            //HEI.91>>
        end else begin
            PurchBlanketOrderLine.SETRANGE(Type, PurchBlanketOrderLine.Type::Item);
            PurchBlanketOrderLine.SETRANGE("No.", InterfaceEntryLine."Global No.");
            PurchBlanketOrderLine.SETRANGE("CMG Code FND", InterfaceEntryLine."CMG Code");
        end;
        //HEI.91<<
        PurchBlanketOrderLine.SETRANGE("SRM Contract No. FND", InterfaceEntryLine."External Contract No.");
        PurchBlanketOrderLine.SETRANGE("SRM Contract Line No. FND", InterfaceEntryLine."External Contract Line No.");
        if PurchBlanketOrderLine.FINDFIRST() then begin
            PurchBlanketOrderLine2.GET(PurchBlanketOrderLine."Document Type", PurchBlanketOrderLine."Document No.", PurchBlanketOrderLine."Line No.");
            if InterfaceEntryLine.Quantity <> 0 then
                PurchBlanketOrderLine2.VALIDATE(Quantity, PurchBlanketOrderLine2.Quantity + InterfaceEntryLine.Quantity)
            else
                PurchBlanketOrderLine2.VALIDATE(Quantity, PurchBlanketOrderLine2.Quantity + 1);
            PurchBlanketOrderLine2.MODIFY();
        end else begin
            PurchBlanketOrderLine.SETRANGE(Type);
            PurchBlanketOrderLine.SETRANGE("No.");
            if PurchBlanketOrderLine.FINDFIRST() then begin
                PurchBlanketOrderLine2.SETRANGE("Document Type", PurchBlanketOrderLine."Document Type");
                PurchBlanketOrderLine2.SETRANGE("Document No.", PurchBlanketOrderLine."Document No.");
                if PurchBlanketOrderLine2.FINDLAST() then
                    PurchLineNo := PurchBlanketOrderLine2."Line No.";

                CLEAR(PurchBlanketOrderLine2);
                // if not GUIALLOWED then // BC Upgrade BHARDA11 --11April2026 Block this line of code;
                //PurchBlanketOrderLine2.SetHideValidationDialog(true);    // BC Upgrade SHUKLP03 << Blocked because of DrinkIT procedure SetHideValidationDialog().
                PurchBlanketOrderLine2.VALIDATE("Document Type", PurchBlanketOrderLine2."Document Type"::"Blanket Order");
                PurchBlanketOrderLine2.VALIDATE("Document No.", PurchBlanketOrderLine."Document No.");
                PurchLineNo := PurchLineNo + 10000;
                PurchBlanketOrderLine2."Line No." := PurchLineNo;
                //HEI.91>>
                if InterfaceEntryLine."Global No." = '' then begin
                    //HEI.91<<
                    PurchBlanketOrderLine2.VALIDATE(Type, InterfaceEntryLine.Type);
                    PurchBlanketOrderLine2.VALIDATE("No.", InterfaceEntryLine."No.");
                    //HEI.91>>
                end else begin
                    PurchBlanketOrderLine2.VALIDATE(Type, PurchBlanketOrderLine2.Type::Item);
                    PurchBlanketOrderLine2.VALIDATE("No.", InterfaceEntryLine."Global No.");
                end;
                //HEI.91<<
                PurchBlanketOrderLine2.Description := PurchBlanketOrderLine.Description;
                PurchBlanketOrderLine2."Description 2" := PurchBlanketOrderLine."Description 2";
                PurchBlanketOrderLine2.VALIDATE("Location Code", PurchBlanketOrderLine."Location Code");
                //HEI.91>>
                if (InterfaceEntryLine."Unit of Measure Code" <> '') and (InterfaceEntryLine."Global No." <> '') then
                    PurchBlanketOrderLine2.VALIDATE("Unit of Measure Code", InterfaceFrameworkMgt.GetISOCodeUnitOfMeasure(InterfaceEntryLine."Unit of Measure Code"))
                else
                    //HEI.91<<
                    PurchBlanketOrderLine2.VALIDATE("Unit of Measure Code", PurchBlanketOrderLine."Unit of Measure Code");

                if InterfaceEntryLine.Quantity <> 0 then begin
                    if InterfaceEntryLine."Global No." = '' then //HEI.91
                        PurchBlanketOrderLine2.VALIDATE(Quantity, InterfaceEntryLine.Quantity)
                    //HEI.91>>
                    else
                        PurchBlanketOrderLine2.VALIDATE(Quantity, InterfaceEntryLine.Quantity + 1);
                end else
                    //HEI.91<<
                    PurchBlanketOrderLine2.VALIDATE(Quantity, 1);
                PurchBlanketOrderLine2.VALIDATE("Direct Unit Cost", PurchBlanketOrderLine."Direct Unit Cost");
                PurchBlanketOrderLine2.VALIDATE("SRM Contract No. FND", PurchBlanketOrderLine."SRM Contract No. FND");
                PurchBlanketOrderLine2.VALIDATE("SRM Contract Line No. FND", PurchBlanketOrderLine."SRM Contract Line No. FND");
                PurchBlanketOrderLine2.VALIDATE("Type ID FND", PurchBlanketOrderLine."Type ID FND");
                //PurchBlanketOrderLine2.VALIDATE("Target Value Currency",PurchBlanketOrderLine."Target Value Currency");
                //PurchBlanketOrderLine2.VALIDATE("Target Value Amount FND",PurchBlanketOrderLine."Target Value Amount FND");
                PurchBlanketOrderLine2.VALIDATE("Block Line Ordering FND", PurchBlanketOrderLine."Block Line Ordering FND");
                PurchBlanketOrderLine2.VALIDATE("CMG Code FND", PurchBlanketOrderLine."CMG Code FND");
                PurchBlanketOrderLine2.VALIDATE("Tolerance Received Under % FND", PurchBlanketOrderLine."Tolerance Received Under % FND");
                PurchBlanketOrderLine2.VALIDATE("Tolerance Received Over % FND", PurchBlanketOrderLine."Tolerance Received Over % FND");
                PurchBlanketOrderLine2.VALIDATE("Last Changed Date/Time FND", PurchBlanketOrderLine."Last Changed Date/Time FND");
                PurchBlanketOrderLine2.VALIDATE("Lead Time Calculation", PurchBlanketOrderLine."Lead Time Calculation");
                PurchBlanketOrderLine2."Initial Quantity FND" := PurchBlanketOrderLine2.Quantity;
                PurchBlanketOrderLine2."Dimension Set ID" := PurchBlanketOrderLine."Dimension Set ID";
                PurchBlanketOrderLine2.INSERT(true);
            end;
        end;
    end;

    local procedure DeletePurchaseOrderHeader(var PurchaseHeader: Record "Purchase Header"; InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        // BC Upgrade PATELS08 >>
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND"; // HEI.104
                                                                           // BC Upgrade PATELS08 <<
    begin
        // BC Upgrade PATELS08 >> # added if-else block
        // HEI.103 >>

        IF InterfaceEntryHeader."Source No." <> '' THEN
            PurchaseHeader.GET(InterfaceEntryHeader."Source Subtype", InterfaceEntryHeader."Source No.")
        ELSE
            PurchaseHeader.GET(InterfaceEntryHeader."Source Subtype", InterfaceEntryHeader."External Order No.");
        //PurchaseHeader.GET(InterfaceEntryHeader."Source Subtype",InterfaceEntryHeader."Source No.");

        // HEI.103 <<
        // BC Upgrade PATELS08 <<

        if not GUIALLOWED then
            PurchaseHeader.SetHideValidationDialog(true);
        PurchaseHeader.DELETE(true);

        // BC Upgrade PATELS08 >> # added if-else block
        //HEI.104>>
        IF InterfaceEntryHeader."Source No." <> '' THEN BEGIN
            IF PurchaseHeaderAdditional.GET(InterfaceEntryHeader."Source Subtype", InterfaceEntryHeader."Source No.") THEN
                PurchaseHeaderAdditional.DELETE(TRUE);
        END ELSE BEGIN
            IF PurchaseHeaderAdditional.GET(InterfaceEntryHeader."Source Subtype", InterfaceEntryHeader."External Order No.") THEN
                PurchaseHeaderAdditional.DELETE(TRUE);
        END;
        //HEI.104<<
        // BC Upgrade PATELS08 <<
    end;

    local procedure DeletePurchaseOrderLine(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; InterfaceEntryHeader: Record "Interface Entry Header INT"; InterfaceEntryLine: Record "Interface Entry Line INT");
    var
        ReleasePurchDoc: Codeunit "Release Purchase Document";
    begin
        ReleasePurchDoc.Reopen(PurchaseHeader);//HEI.03
        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETRANGE("Line No.", InterfaceEntryLine."Source Line No.");
        // if not GUIALLOWED then // BC Upgrade BHARDA11 --11April2026 Block this line of code;
        //PurchaseLine.SetHideValidationDialog(true);   // BC Upgrade SHUKLP03 << Blocked because of DrinkIT procedure SetHideValidationDialog(). 
        PurchaseLine.FINDFIRST();
        PurchaseLine.DELETE(true);
    end;

    local procedure CreatePOConfirmationHeader(InterfaceEntryHeaderIn: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT"; PurchaseHeader: Record "Purchase Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
    begin
        //PO confirmation header NAV -> SRM
        GetGeneralInterfaceSetup();
        //HEI.17>>
        GetSRMInterfaceSetup();
        //InterfaceSetup.GET(GeneralInterfaceSetup."PO Confirmation Interface");
        InterfaceSetup.GET(SRMInterfaceSetup."PO Confirmation Interface");
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        //GeneralInterfaceSetup.TESTFIELD("PO Confirmation Interface");
        SRMInterfaceSetup.TESTFIELD("PO Confirmation Interface");
        //HEI.17<<
        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeaderIn, false);
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Msg. Sender Business System ID" := InterfaceEntryHeaderIn."Msg. Recv. Business System ID";
        if InterfaceEntryHeaderOut."Msg. Sender Business System ID" = '' then
            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := InterfaceEntryHeaderIn."Msg. Sender Business System ID";
        InterfaceEntryHeaderOut."Object Type" := 'PO';
        InterfaceEntryHeaderOut."Type ID" := '300';
        InterfaceEntryHeaderOut."Severity Code" := '1';
        InterfaceEntryHeaderOut."Message Type" := 'S';
        InterfaceEntryHeaderOut."Log Message" := POProcessedTxt;
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        //HEI.17>>
        //InterfaceEntryHeaderOut."Interface Code" := GeneralInterfaceSetup."PO Confirmation Interface";
        InterfaceEntryHeaderOut."Interface Code" := SRMInterfaceSetup."PO Confirmation Interface";
        //HEI.17<<
        InterfaceEntryHeaderOut."Source No." := PurchaseHeader."No.";
        InterfaceEntryHeaderOut.INSERT(true);
    end;

    local procedure CreatePOConfirmationLine(InterfaceEntryLineIn: Record "Interface Entry Line INT"; InterfaceEntryHeaderOut: Record "Interface Entry Header INT"; var InterfaceEntryLineOut: Record "Interface Entry Line INT"; PurchaseLine: Record "Purchase Line");
    begin
        //PO confirmation line NAV -> SRM
        GetGeneralInterfaceSetup();

        CLEAR(InterfaceEntryLineOut);
        InterfaceEntryLineOut.TRANSFERFIELDS(InterfaceEntryLineIn, false);
        //HEI.21>>
        InterfaceEntryLineOut.Type := PurchaseLine.Type.AsInteger();
        InterfaceEntryLineOut."No." := PurchaseLine."No.";
        //HEI.21<<
        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
        InterfaceEntryLineOut."Entry No." := InterfaceEntryLineIn."Entry No.";
        //HEI.62>>
        //InterfaceEntryLineOut."Source Line No." := PurchaseLine."Line No.";
        if (PurchaseLine."Line No." <> 0) then
            InterfaceEntryLineOut."Source Line No." := (PurchaseLine."Line No." / 10000);
        //HEI.62<<
        InterfaceEntryLineOut.INSERT();
    end;

    procedure ProcessGRCreation(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        PurchaseHeader: Record "Purchase Header";
        PurchaseReturnHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        PurchaseReturnLine: Record "Purchase Line";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        ReturnShipmentHeader: Record "Return Shipment Header";
        ReturnShipmentLine: Record "Return Shipment Line";
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        UndoPurchaseReceiptLine: Codeunit "Undo Purchase Receipt Line";
        UndoReturnShipmentLine: Codeunit "Undo Return Shipment Line";
        ReleasePurchDoc: Codeunit "Release Purchase Document";
        // NoSeriesMgt: Codeunit NoSeriesManagement;  // BC Upgrade NANDIS03
        QtyReceivedNotInvoiced: Decimal;
        QtyReturnedNotInvoiced: Decimal;
        PurchDocType: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Receipt","Posted Invoice","Posted Return Shipment","Posted Credit Memo";
        PostReceipt: Boolean;
        PostReturnShipment: Boolean;
        UndoReceipt: Boolean;
        UndoReturnShipment: Boolean;
        User: Record User;
        UserSetup: Record "User Setup";
        PurchaseLineGR: Record "Purchase Line";
        LastPurchaseLine: Record "Purchase Line";
        PurchaseLineLPO: Record "Purchase Line";
        PurchaseLineOriginal: Record "Purchase Line";
        UndoPurchRcptLine: Record "Purch. Rcpt. Line";
        PurchPost: Codeunit "Purch.-Post";
        InterfaceSetup: Record "Interface Setup INT";
        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
        DummyInvNo: Label 'CHG2148350_Inv';
        DummyCrMemoNo: Label 'CHG2148350_CrMemo';
        InterfacePurchCode: Codeunit InterfacePurchCode; // BC Upgrade SHUKLP03 << 
        ItemGRError: Label 'GR of Direct items is not allowed from SRM and can be posted only from Heilite.';
        RecPurchaseLine2: Record "Purchase Line";
        HenekenBCUpgSTP: Codeunit HeinekenBCUpgrade_STP;
        UndoNewCodeun: Codeunit UndoPreviewFACU; // BC Upgrade BHARDA11 
    begin
        //GR Creation
        GetGeneralInterfaceSetup();
        GetSRMInterfaceSetup(); //HEI.17
        InterfaceSetup.GET(InterfaceEntryHeader."Interface Code");  //HEI.68

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.findset() then begin
            PurchaseHeader.RESET(); //HEI.29
            PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
            PurchaseHeader.SETRANGE("No.", InterfaceEntryLine."External Order No.");
            PurchaseHeader.FINDFIRST();

            PurchaseHeader."Vendor Shipment No." := InterfaceEntryHeader."External Document No."; //HEI.97
                                                                                                  //>> HEI.29
                                                                                                  // User.SETRANGE("User Name", 'HEIWAY\' + InterfaceEntryHeader.Contact); //HEI.31
            User.SETRANGE("User Name", InterfaceEntryHeader.Contact); //HEI.31
            if not User.FINDFIRST() then begin
                Error('UserID  %1 not Found in user table', InterfaceEntryHeader.Contact);
                // BC Upgrade BHARDA11 >> --Blocked this code because we can not create users in businesscentral with this senerio
                // User.INIT();
                // User."User Security ID" := CREATEGUID();
                // // User.VALIDATE("User Name", 'HEIWAY\' + InterfaceEntryHeader.Contact); //HEI.31
                // User.VALIDATE("User Name", InterfaceEntryHeader.Contact); //HEI.31
                // if User.INSERT() then begin
                //     UserSetup.INIT();
                //     UserSetup.VALIDATE("User ID", User."User Name");
                //     UserSetup.INSERT();
                //     // PurchaseHeader.VALIDATE("Assigned User ID", 'HEIWAY\' + InterfaceEntryHeader.Contact); //HEI.31
                //     PurchaseHeader.VALIDATE("Assigned User ID", InterfaceEntryHeader.Contact); //HEI.31
                //     PurchaseHeader.MODIFY();
                // end;
                // BC Upgrade BHARDA11 << --Blocked this code because we can not create users in businesscentral with this senerio

            end else begin
                //>> HEI.32
                UserSetup.SETRANGE("User ID", User."User Name");
                if UserSetup.FINDFIRST() then begin
                    PurchaseHeader.VALIDATE("Assigned User ID", UserSetup."User ID");
                    PurchaseHeader.MODIFY();
                end else begin
                    UserSetup.INIT();
                    UserSetup.VALIDATE("User ID", User."User Name");
                    UserSetup.INSERT();
                    //PurchaseHeader.VALIDATE("Assigned User ID",User."User Name");
                    PurchaseHeader.VALIDATE("Assigned User ID", UserSetup."User ID");
                    // << HEI.32
                    PurchaseHeader.MODIFY();
                end;
            end;
            //<< HEI.29

            ////HEI.42>>
            ////Making "Qty. to Receive" field 0 before GR process takes place for all the lines
            //PurchaseLineGR.RESET;
            //PurchaseLineGR.SETRANGE("Document Type",PurchaseHeader."Document Type");
            //PurchaseLineGR.SETRANGE("Document No.",PurchaseHeader."No.");
            //IF PurchaseLineGR.FINDSET THEN REPEAT
            //  PurchaseLineGR.VALIDATE("Qty. to Receive",0);
            //  PurchaseLineGR.MODIFY(TRUE);
            //UNTIL PurchaseLineGR.NEXT = 0;
            ////HEI.42<<

            //HEI.48>>
            //Making "Qty. to Receive" field 0 before GR process takes place for all the lines
            PurchaseLineGR.RESET();
            PurchaseLineGR.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLineGR.SETRANGE("Document No.", PurchaseHeader."No.");
            if PurchaseLineGR.findset() then
                repeat
                    PurchaseLineGR.VALIDATE("Qty. to Receive", 0);
                    PurchaseLineGR.MODIFY(true);
                until PurchaseLineGR.NEXT() = 0;
            //HEI.48<<

            repeat
                CLEAR(UndoPurchaseReceiptLine);
                CLEAR(UndoReturnShipmentLine);
                PurchRcptLine.RESET();
                ReturnShipmentLine.RESET();
                //HEI.42>>
                ////HEI.39>>
                ////Making "Qty. to Receive" field 0 before GR process takes place for all the lines
                //PurchaseLineGR.RESET;
                //PurchaseLineGR.SETRANGE("Document Type",PurchaseHeader."Document Type");
                //PurchaseLineGR.SETRANGE("Document No.",PurchaseHeader."No.");
                //IF PurchaseLineGR.FINDSET THEN REPEAT
                //  PurchaseLineGR.VALIDATE("Qty. to Receive",0);
                //  PurchaseLineGR.MODIFY(TRUE);
                //UNTIL PurchaseLineGR.NEXT = 0;
                ////HEI.39<<
                //HEI.42<<
                PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                PurchaseLine.SETRANGE("SRM Order Line No. FND", InterfaceEntryLine."External Order Line No.");
                PurchaseLine.SETRANGE("Location Code", InterfaceEntryLine."Location Code");
                PurchaseLine.FINDFIRST();
                //HEI.93>>
                if PurchaseLine.Type = PurchaseLine.Type::Item then
                    ERROR(ItemGRError);
                //HEI.93<<
                case InterfaceEntryLine."Movement Type" of
                    //HEI.17>>
                    //GeneralInterfaceSetup."GR Creation Movement Type":
                    SRMInterfaceSetup."GR Creation Movement Type":
                        //HEI.17<<
                        begin
                            //>>HEI.44
                            if not IsLimitPO(PurchaseHeader) then begin
                                PostReceipt := true;
                                //HEI.42>>
                                ////HEI.39>>
                                ////PurchaseLine.VALIDATE("Qty. to Receive",0);
                                ////HEI.39<<
                                //HEI.42<<
                                if InterfaceEntryLine.Quantity <> 0 then
                                    PurchaseLine.VALIDATE("Qty. to Receive", InterfaceEntryLine.Quantity)
                                else begin
                                    ReleasePurchDoc.Reopen(PurchaseHeader);
                                    //HEI.42>>
                                    //HEI.39>>
                                    ////PurchaseLine.VALIDATE(Quantity,PurchaseLine.Quantity + 1);
                                    PurchaseLine.VALIDATE(Quantity, PurchaseLine.Quantity + 1);
                                    ////PurchaseLine.VALIDATE("Qty. to Receive",1);
                                    PurchaseLine.VALIDATE("Qty. to Receive", 1);
                                    //PurchaseLine.VALIDATE("Qty. to Receive",0);
                                    ////HEI.39<<
                                    //HEI.42<<
                                    if InterfaceEntryLine."Line Amount" > PurchaseLine."Remaining Amount FND" then
                                        ERROR(NoRemainingAmountOnGRErr, PurchaseLine."Remaining Amount FND");
                                    PurchaseLine.VALIDATE("Direct Unit Cost", InterfaceEntryLine."Line Amount");
                                    // if PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset" then
                                    //     PurchaseLine.VALIDATE("Qty. to Invoice", InterfaceEntryLine.Quantity)
                                    // else
                                    //     //<< HEI.36
                                    //     PurchaseLine.VALIDATE("Qty. to Invoice", 0);
                                    // PurchaseLine.MODIFY();
                                    // Message('A qty %1', PurchaseLine."Qty. to Invoice");
                                    CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeader);
                                end;
                                if InterfaceEntryLine.Quantity <> 0 then //HEI.96
                                    PurchaseLine."Vendor Shipment No. FND" := InterfaceEntryHeader."External Document No."; //HEI.97
                                                                                                                            //PurchaseLine."Vendor Shipment No." := InterfaceEntryLine."External Document No."; //HEI.96
                                                                                                                            //>> HEI.36
                                if PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset" then
                                    PurchaseLine.VALIDATE("Qty. to Invoice", InterfaceEntryLine.Quantity)
                                else
                                    //<< HEI.36
                                    PurchaseLine.VALIDATE("Qty. to Invoice", 0);
                                if InterfaceEntryLine.Closed then
                                    PurchaseLine.VALIDATE("Block Line Ordering FND", PurchaseLine."Block Line Ordering FND"::F);
                                PurchaseLine.VALIDATE("Delivery Finalized FND", InterfaceEntryLine."Delivery Finalized");
                                // Message('B qty %1', PurchaseLine."Qty. to Invoice");
                                PurchaseLine.MODIFY();
                            end else begin
                                PostReceipt := true;
                                ReleasePurchDoc.Reopen(PurchaseHeader);
                                //LastPurchaseLine.COPYFILTERS(PurchaseLine);//HEI.59
                                //LastPurchaseLine.SETRANGE("SRM Order Line No. FND");//HEI.59
                                PurchaseLineOriginal.COPYFILTERS(PurchaseLine);
                                //LastPurchaseLine.SETRANGE("No.",PurchaseLine."No.");//HEI.59
                                //HEI.59>>
                                LastPurchaseLine.RESET();
                                LastPurchaseLine.SETRANGE("Document Type", LastPurchaseLine."Document Type"::Order);
                                LastPurchaseLine.SETRANGE("Document No.", PurchaseLine."Document No.");

                                //HEI.59<<
                                LastPurchaseLine.FINDLAST();
                                //HEI.98>>
                                if InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Synchronous then begin
                                    //HEI.99>>
                                    if InterfaceEntryLine."Line Amount" > PurchaseLine."Remaining Amount FND" then
                                        ERROR(NoRemainingAmountOnGRErr, PurchaseLine."Remaining Amount FND");
                                    //HEI.99<<
                                    //HEI.100>>
                                    //LastPurchaseLine.VALIDATE(LastPurchaseLine."Qty. to Receive",1);
                                    //LastPurchaseLine.MODIFY;
                                    RecPurchaseLine2.RESET();
                                    RecPurchaseLine2.SETRANGE("Document Type", RecPurchaseLine2."Document Type"::Order);
                                    RecPurchaseLine2.SETRANGE("Document No.", PurchaseLine."Document No.");
                                    RecPurchaseLine2.SETRANGE("SRM Order Line No. FND", InterfaceEntryLine."External Order Line No.");
                                    RecPurchaseLine2.SETFILTER("Outstanding Quantity", '<>%1', 0);
                                    if not RecPurchaseLine2.FINDLAST() then begin
                                        RecPurchaseLine2.SETRANGE("SRM Order Line No. FND", '');
                                        RecPurchaseLine2.SETRANGE("Additional Description FND", InterfaceEntryLine."External Order Line No.");
                                        RecPurchaseLine2.FINDLAST();
                                    end;
                                    RecPurchaseLine2.VALIDATE("Qty. to Receive", 1);
                                    RecPurchaseLine2.MODIFY();
                                    //HEI.100<<
                                end;
                                //HEI.98<<
                                PurchaseLineOriginal.SETRANGE("SRM Order Line No. FND", InterfaceEntryLine."External Order Line No.");
                                if PurchaseLineOriginal.FINDFIRST() then
                                    if PurchaseLineOriginal."Quantity Received" <> 0 then begin
                                        PurchaseLineOriginal.RESET();
                                        PurchaseLineOriginal.COPYFILTERS(PurchaseLine);
                                        PurchaseLineOriginal.SETRANGE("SRM Order Line No. FND");
                                        PurchaseLineOriginal.SETFILTER("Quantity Received", '%1', 0);
                                        PurchaseLineOriginal.SETRANGE("Additional Description FND", InterfaceEntryLine."External Order Line No.");
                                        PurchaseLineOriginal.FINDLAST();
                                    end else
                                        if PurchaseLineOriginal."Direct Unit Cost" = 0 then begin
                                            PurchaseLineOriginal.RESET();
                                            PurchaseLineOriginal.COPYFILTERS(PurchaseLine);
                                            PurchaseLineOriginal.SETRANGE("SRM Order Line No. FND");
                                            PurchaseLineOriginal.SETRANGE("Additional Description FND", InterfaceEntryLine."External Order Line No.");
                                            PurchaseLineOriginal.FINDLAST();
                                        end;
                                CreateLimitPOLine(PurchaseLineOriginal, PurchaseLine, LastPurchaseLine, InterfaceEntryLine);
                                CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeader);
                            end
                            //<< HEI.44
                        end;
                    //HEI.17>>
                    //GeneralInterfaceSetup."GR Cancellation Movement Type":
                    SRMInterfaceSetup."GR Cancellation Movement Type":
                        //HEI.17<<
                        begin
                            //>> HEI.44
                            if IsLimitPO(PurchaseHeader) then begin
                                PurchRcptLine.SETCURRENTKEY("Order No.", "Order Line No.");
                                PurchRcptLine.SETRANGE("Order No.", InterfaceEntryLine."External Order No.");
                                PurchRcptLine.SETFILTER(Quantity, '<>%1', ABS(InterfaceEntryLine.Quantity));
                                PurchRcptLine.SETFILTER("Qty. Rcd. Not Invoiced", '<>%1', ABS(InterfaceEntryLine.Quantity));
                                PurchRcptLine.SETRANGE("Amount Heilite FND", ABS(InterfaceEntryLine."Line Amount"));    // BC Upgrade SHUKLP03 << Blocked because of DrinkIT field Amount.
                                //PurchRcptLine.SETRANGE(Amount, ABS(InterfaceEntryLine."Line Amount"));    // BC Upgrade SHUKLP03 << Blocked because of DrinkIT field Amount.
                                if not PurchRcptLine.FINDFIRST() then
                                    ERROR(NoPurchReceiptLineErr, InterfaceEntryLine.Quantity);
                                //HEI.74>>
                                //HEI.94>>
                                //IF (InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Synchronous) THEN BEGIN
                                // IF (PurchRcptLine.Type = PurchRcptLine.Type::"Fixed Asset") THEN
                                //  ERROR(FAReverseError);
                                //END;
                                //HEI.94<<
                                //HEI.74<<
                                if (InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Asynchronous) then begin  //HEI.68
                                    PurchRcptLine.SETRANGE("Document No.", PurchRcptLine."Document No.");
                                    PurchRcptLine.SETRANGE("Line No.", PurchRcptLine."Line No.");
                                    UndoPurchaseReceiptLine.SetHideDialog(true);
                                    // PurchRcptLine."Preview Undo FA" := false; // BC Upgrade BHARAD11 --20April2026
                                    UndoPurchaseReceiptLine.RUN(PurchRcptLine);
                                    UndoPurchRcptLine := PurchRcptLine; //HEI.47
                                    UndoReceipt := true;
                                    //HEI.100<<
                                    UpdateOriginalLineOnUndo(InterfaceEntryLine, PurchaseHeader, PurchaseLine, PurchRcptLine);
                                    //HEI.100>>
                                    if PurchRcptLine."Delivery Finalized FND" = true then begin
                                        PurchRcptLine."Delivery Finalized FND" := false;
                                        PurchRcptLine.MODIFY();
                                        PurchaseLine.RESET();
                                        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                                        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                                        PurchaseLine.SETRANGE("SRM Order Line No. FND", InterfaceEntryLine."External Order Line No.");
                                        PurchaseLine.SETRANGE("Location Code", InterfaceEntryLine."Location Code");
                                        PurchaseLine.FINDFIRST();
                                        if PurchaseLine."Delivery Finalized FND" = true then begin
                                            PurchaseLine."Delivery Finalized FND" := false;
                                            PurchaseLine.MODIFY();
                                        end;
                                    end;
                                end;  //HEI.68
                            end else
                              //<< HEI.44
                              begin
                                PurchRcptLine.SETCURRENTKEY("Order No.", "Order Line No.");
                                PurchRcptLine.SETRANGE("Order No.", InterfaceEntryLine."External Order No.");
                                PurchRcptLine.SETRANGE("SRM Order Line No. FND", InterfaceEntryLine."External Order Line No.");
                                PurchRcptLine.SETRANGE(Quantity, ABS(InterfaceEntryLine.Quantity));
                                PurchRcptLine.SETRANGE("Qty. Rcd. Not Invoiced", ABS(InterfaceEntryLine.Quantity));
                                if not PurchRcptLine.FINDLAST() then
                                    ERROR(NoPurchReceiptLineErr, InterfaceEntryLine.Quantity);
                                //HEI.74>>
                                //HEI.94>>
                                //IF (InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Synchronous) THEN BEGIN
                                // IF (PurchRcptLine.Type = PurchRcptLine.Type::"Fixed Asset") THEN
                                //  ERROR(FAReverseError);
                                //END;
                                //HEI.94<<
                                //HEI.74<<
                                //HEI.95>>
                                if (InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Synchronous) and (PurchRcptLine.Type = PurchRcptLine.Type::"Fixed Asset") then begin
                                    PurchRcptLine.SETRANGE("Document No.", PurchRcptLine."Document No.");
                                    PurchRcptLine.SETRANGE("Line No.", PurchRcptLine."Line No.");
                                    UndoPurchaseReceiptLine.SetHideDialog(true);
                                    // UndoPurchaseReceiptLine.SetPreviewUndo(true);  // BC Upgrade NANDIS03 - Blocked temporarily
                                    // HenekenBCUpgSTP.SetPreviewUndo(true);  // BC Upgrade NANDIS03 - Blocked temporarily // BC Upgrade BHARAD11 ---PRPending
                                    // PurchRcptLine."Preview Undo FA" := true;
                                    // UndoPurchaseReceiptLine.RUN(PurchRcptLine);
                                    UndoNewCodeun.Run(PurchRcptLine);
                                    UndoPurchRcptLine := PurchRcptLine;
                                    UndoReceipt := true;
                                end;
                                //HEI.95<<
                                if (InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Asynchronous) then begin  //HEI.68
                                    PurchRcptLine.SETRANGE("Document No.", PurchRcptLine."Document No.");
                                    PurchRcptLine.SETRANGE("Line No.", PurchRcptLine."Line No.");
                                    UndoPurchaseReceiptLine.SetHideDialog(true);
                                    UndoPurchaseReceiptLine.RUN(PurchRcptLine);
                                    UndoPurchRcptLine := PurchRcptLine; //HEI.47
                                    UndoReceipt := true;
                                    //HEI.40 >>
                                    PurchRcptLine.RESET();
                                    PurchRcptLine.SETRANGE("Order No.", InterfaceEntryLine."External Order No.");
                                    PurchRcptLine.SETRANGE("SRM Order Line No. FND", InterfaceEntryLine."External Order Line No.");
                                    if PurchRcptLine.FINDLAST() then begin
                                        if PurchRcptLine."Delivery Finalized FND" = true then begin
                                            PurchRcptLine."Delivery Finalized FND" := false;
                                            PurchRcptLine.MODIFY();
                                            PurchaseLine.RESET();
                                            PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                                            PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                                            PurchaseLine.SETRANGE("SRM Order Line No. FND", InterfaceEntryLine."External Order Line No.");
                                            PurchaseLine.SETRANGE("Location Code", InterfaceEntryLine."Location Code");
                                            PurchaseLine.FINDFIRST();
                                            if PurchaseLine."Delivery Finalized FND" = true then begin
                                                PurchaseLine."Delivery Finalized FND" := false;
                                                PurchaseLine.MODIFY();
                                            end;
                                        end;
                                    end;
                                end;  //HEI.68
                            end;
                            //HEI.40 <<
                        end;
                    //HEI.17>>
                    //GeneralInterfaceSetup."RD Movement Type":
                    SRMInterfaceSetup."RD Movement Type":
                        //HEI.17<<
                        begin
                            PurchaseReturnLine.SETRANGE("Document Type", PurchaseReturnLine."Document Type"::"Return Order");
                            PurchaseReturnLine.SETRANGE("Document No.", InterfaceEntryLine."External Order No.");
                            PurchaseReturnLine.SETRANGE("SRM Order Line No. FND", InterfaceEntryLine."External Order Line No.");
                            if not PurchaseReturnHeader.GET(PurchaseReturnHeader."Document Type"::"Return Order", InterfaceEntryLine."External Order No.") then begin
                                GetPurchSetup();
                                CLEAR(PurchaseReturnHeader);
                                PurchaseReturnHeader."Document Type" := PurchaseReturnHeader."Document Type"::"Return Order";
                                PurchaseReturnHeader."No." := PurchaseHeader."No.";
                                PurchaseReturnHeader."No. Series" := '';
                                PurchaseReturnHeader.INSERT(true);
                                CopyDocMgt.SetProperties(true, false, false, false, false, PurchSetup."Exact Cost Reversing Mandatory", false);
                                // CopyDocMgt.SetInterfaceProperties(PurchaseLine."Line No.");  // BC Upgrade NANDIS03 - Blocked temporarily
                                CopyDocMgt.CopyPurchDoc(PurchDocType::Order, PurchaseHeader."No.", PurchaseReturnHeader);
                                PurchaseReturnLine.FINDFIRST();
                                PurchaseReturnLine.VALIDATE(Quantity, 0);
                                PurchaseReturnLine.MODIFY();
                            end;
                            if not PurchaseReturnLine.FINDFIRST() then begin
                                GetPurchSetup();
                                CopyDocMgt.SetProperties(false, false, false, false, false, PurchSetup."Exact Cost Reversing Mandatory", false);
                                // CopyDocMgt.SetInterfaceProperties(PurchaseLine."Line No.");  // BC Upgrade NANDIS03 - Blocked temporarily
                                CopyDocMgt.CopyPurchDoc(PurchDocType::Order, PurchaseHeader."No.", PurchaseReturnHeader);
                                PurchaseReturnLine.FINDFIRST();
                                PurchaseReturnLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                                PurchaseReturnLine.MODIFY();
                            end else begin
                                if PurchaseReturnHeader.Status = PurchaseReturnHeader.Status::Released then
                                    ReleasePurchDoc.Reopen(PurchaseReturnHeader);
                                //HEI.101>>
                                // PurchaseReturnLine.VALIDATE(Quantity,PurchaseReturnLine.Quantity + InterfaceEntryLine.Quantity);
                                PurchaseReturnLine.VALIDATE(Quantity, PurchaseReturnLine."Return Qty. Shipped" + InterfaceEntryLine.Quantity);
                                //HEI.101<<
                                PurchaseReturnLine.MODIFY();
                            end;
                            PostReturnShipment := true;
                            if InterfaceEntryLine.Quantity <> 0 then begin
                                //HEI.101>>
                                if InterfaceSetup."Call Type" <> InterfaceSetup."Call Type"::Synchronous then begin
                                    //HEI.101<<
                                    ReleasePurchDoc.Reopen(PurchaseHeader);
                                    PurchaseLine.VALIDATE(Quantity, PurchaseLine.Quantity + InterfaceEntryLine.Quantity);
                                    PurchaseLine.MODIFY();
                                    CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeader);
                                    //HEI.101>>
                                end;
                                //HEI.101<<
                                PurchaseReturnLine.VALIDATE("Return Qty. to Ship", InterfaceEntryLine.Quantity)
                            end else begin
                                ReleasePurchDoc.Reopen(PurchaseHeader);
                                PurchaseReturnLine.VALIDATE(Quantity, PurchaseReturnLine.Quantity + 1);
                                PurchaseReturnLine.VALIDATE("Return Qty. to Ship", 1);
                                if InterfaceEntryLine."Line Amount" + PurchaseLine."Remaining Amount FND" > PurchaseLine."Initial Amount FND" then
                                    ERROR(ReturnMoreThanInitialAmtErr, PurchaseLine."Initial Amount FND");
                                PurchaseReturnLine.VALIDATE("Direct Unit Cost", InterfaceEntryLine."Line Amount");
                                CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeader);
                            end;
                            // BC Upgrade BHARDA11 >> 
                            if PurchaseReturnLine.Type = PurchaseReturnLine.Type::"Fixed Asset" then
                                PurchaseReturnLine.VALIDATE("Qty. to Invoice", InterfaceEntryLine.Quantity)
                            else
                                //<< HEI.36
                            PurchaseReturnLine.VALIDATE("Qty. to Invoice", 0);
                            // PurchaseReturnLine.VALIDATE("Qty. to Invoice", 0);
                            // BC Upgrade BHARDA11 <<  
                            if InterfaceEntryLine.Closed then
                                PurchaseLine.VALIDATE("Block Line Ordering FND", PurchaseLine."Block Line Ordering FND"::F);
                            PurchaseReturnLine.VALIDATE("Delivery Finalized FND", InterfaceEntryLine."Delivery Finalized");
                            PurchaseReturnLine.MODIFY();
                        end;
                    //HEI.17>>
                    //GeneralInterfaceSetup."RD Cancellation Movement Type":
                    SRMInterfaceSetup."RD Cancellation Movement Type":
                        //HEI.17<<
                        begin
                            ReturnShipmentLine.SETCURRENTKEY("Return Order No.", "Return Order Line No.");
                            ReturnShipmentLine.SETRANGE("Return Order No.", InterfaceEntryLine."External Order No.");

                            // BC Upgrade MISHRS14 >> 
                            // Added FND In "SRM Order Line No. FND"
                            ReturnShipmentLine.SETRANGE("SRM Order Line No. FND", InterfaceEntryLine."External Order Line No.");
                            // BC Upgrade MISHRS14 <<

                            ReturnShipmentLine.SETRANGE(Quantity, ABS(InterfaceEntryLine.Quantity));
                            ReturnShipmentLine.SETRANGE("Return Qty. Shipped Not Invd.", ABS(InterfaceEntryLine.Quantity));
                            if not ReturnShipmentLine.FINDLAST() then
                                ERROR(NoReturnShipmentLineErr, InterfaceEntryLine.Quantity);
                            if (InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Asynchronous) then begin  //HEI.68
                                PurchaseReturnLine.SETRANGE("Document Type", PurchaseReturnLine."Document Type"::"Return Order");
                                PurchaseReturnLine.SETRANGE("Document No.", ReturnShipmentLine."Return Order No.");
                                PurchaseReturnLine.SETRANGE("Line No.", ReturnShipmentLine."Return Order Line No.");
                                PurchaseReturnLine.FINDFIRST();
                                ReturnShipmentLine.SETRANGE("Document No.", ReturnShipmentLine."Document No.");
                                ReturnShipmentLine.SETRANGE("Line No.", ReturnShipmentLine."Line No.");
                                UndoReturnShipmentLine.SetHideDialog(true);
                                UndoReturnShipmentLine.RUN(ReturnShipmentLine);
                                UndoReturnShipment := true;
                                PurchaseReturnLine.FIND();
                                PurchaseReturnHeader.GET(PurchaseReturnLine."Document Type", PurchaseReturnLine."Document No.");
                                ReleasePurchDoc.Reopen(PurchaseReturnHeader);
                                PurchaseReturnLine.VALIDATE(Quantity, PurchaseReturnLine.Quantity - ReturnShipmentLine.Quantity);
                                PurchaseReturnLine.MODIFY();
                                ReleasePurchDoc.Reopen(PurchaseHeader);
                                PurchaseLine.VALIDATE(Quantity, PurchaseLine.Quantity - ReturnShipmentLine.Quantity);
                                PurchaseLine.MODIFY();
                                CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeader);
                            end;  //HEI.68
                        end;
                end;
            until InterfaceEntryLine.NEXT() = 0;

            if PostReceipt then begin
                PurchaseHeader."Posting Date" := InterfaceEntryHeader."Posting Date";
                PurchaseHeader."Your Reference" := InterfaceEntryHeader."Your Reference";
                PurchaseHeader.Receive := true;
                PurchaseHeader.Invoice := false;
                //HEI.66>>
                InterfaceSetup.GET(InterfaceEntryHeader."Interface Code");
                if (InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Synchronous) then begin
                    PurchaseHeader.Invoice := true;
                    PurchaseHeader."Vendor Invoice No." := DummyInvNo;  //HEI.72
                    COMMIT();
                    // InterfacePurchCode.PreviewSRMInterface(PurchaseHeader);  // BC Upgrade SHUKLP03 << Added to call the new codeunit because procedure is in that codeunit.
                    InterfacePurchCode.PurchPreview(PurchaseHeader);  // BC Upgrade SHUKLP03 << Added to call the new codeunit because procedure is in that codeunit.
                end else begin
                    //HEI.66<<
                    PurchaseHeader.Invoice := false; // BC Upgrade BHARDA11 
                    CODEUNIT.RUN(CODEUNIT::"Purch.-Post", PurchaseHeader);
                    CreateGRConfirmationHeader(InterfaceEntryHeader, InterfaceEntryHeaderOut, PurchaseHeader, InterfaceEntryLine."Movement Type", UndoPurchRcptLine); //HEI.47
                end;  //HEI.66
            end else
                if UndoReceipt then begin
                    CreateGRConfirmationHeader(InterfaceEntryHeader, InterfaceEntryHeaderOut, PurchaseHeader, InterfaceEntryLine."Movement Type", UndoPurchRcptLine); //HEI.47
                                                                                                                                                                      //HEI.100>>
                                                                                                                                                                      //>> HEI.44
                                                                                                                                                                      // IF IsLimitPO(PurchaseHeader) THEN
                                                                                                                                                                      //  UpdateOriginalLineOnUndo(InterfaceEntryLine,PurchaseHeader,PurchaseLine,PurchRcptLine);
                                                                                                                                                                      //<<HEI.44
                                                                                                                                                                      //<< HEI.100<<
                end;
            if PostReturnShipment then begin
                PurchaseReturnHeader."Posting Date" := InterfaceEntryHeader."Posting Date";
                PurchaseReturnHeader."Your Reference" := InterfaceEntryHeader."Your Reference";
                PurchaseReturnHeader.Ship := true;
                PurchaseReturnHeader.Invoice := false;
                //HEI.67>>
                InterfaceSetup.GET(InterfaceEntryHeader."Interface Code");
                if (InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Synchronous) then begin
                    PurchaseReturnHeader.Invoice := true;
                    PurchaseReturnHeader."Vendor Cr. Memo No." := DummyCrMemoNo;  //HEI.72
                    COMMIT();
                    InterfacePurchCode.PurchPreview(PurchaseHeader); // 24April2026 // BC Upgrade BHARDA11
                    // InterfacePurchCode.PreviewSRMInterface(PurchaseReturnHeader);   // BC Upgrade SHUKLP03 << Added to call the new codeunit because procedure is in that codeunit.
                end else begin
                    // BC Upgrade BHARAD11 >> -- 23April2026
                    PurchaseReturnHeader.Ship := true;
                    PurchaseReturnHeader.Invoice := false;
                    // BC Upgrade BHARAD11 << -- 23April2026
                    //HEI.67<<
                    CODEUNIT.RUN(CODEUNIT::"Purch.-Post", PurchaseReturnHeader);
                    CreateGRConfirmationHeader(InterfaceEntryHeader, InterfaceEntryHeaderOut, PurchaseReturnHeader, InterfaceEntryLine."Movement Type", PurchRcptLine); //HEI.44
                end;  //HEI.67
            end else
                if UndoReturnShipment then begin
                    CreateGRConfirmationHeader(InterfaceEntryHeader, InterfaceEntryHeaderOut, PurchaseReturnHeader, InterfaceEntryLine."Movement Type", PurchRcptLine); //HEI.44
                    DeleteEmptyPurchaseReturnOrder(PurchaseReturnHeader);
                end;
        end;
    end;

    local procedure CreateGRConfirmationHeader(InterfaceEntryHeaderIn: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT"; var PurchaseHeader: Record "Purchase Header"; MovementType: Code[10]; PurchRcptLine: Record "Purch. Rcpt. Line");
    var
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
    begin
        //GR confirmation header NAV -> SRM
        GetGeneralInterfaceSetup();
        //HEI.17>>
        GetSRMInterfaceSetup();
        // GeneralInterfaceSetup.TESTFIELD("GR Confirmation Interface");
        SRMInterfaceSetup.TESTFIELD("GR Confirmation Interface");
        // InterfaceSetup.GET(GeneralInterfaceSetup."GR Confirmation Interface");
        InterfaceSetup.GET(SRMInterfaceSetup."GR Confirmation Interface");
        //HEI.17<<
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeaderIn, false);
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        if InterfaceEntryHeaderOut."Msg. Sender Business System ID" = '' then
            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."SRM Business System ID";
        InterfaceEntryHeaderOut."Object Type" := 'GR';
        InterfaceEntryHeaderOut."Type ID" := '300';
        InterfaceEntryHeaderOut."Severity Code" := '1';
        InterfaceEntryHeaderOut."Log Message" := GRProcessedTxt;
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        //HEI.17>>
        // InterfaceEntryHeaderOut."Interface Code" := GeneralInterfaceSetup."GR Confirmation Interface";
        InterfaceEntryHeaderOut."Interface Code" := SRMInterfaceSetup."GR Confirmation Interface";
        case MovementType of
            //  GeneralInterfaceSetup."GR Creation Movement Type":
            SRMInterfaceSetup."GR Creation Movement Type":
                InterfaceEntryHeaderOut."Source No." := PurchaseHeader."Last Receiving No.";
            //GeneralInterfaceSetup."GR Cancellation Movement Type":
            SRMInterfaceSetup."GR Cancellation Movement Type":
                //>> HEI.47
                //InterfaceEntryHeaderOut."Source No." := PurchaseHeader."Last Receiving No.";
                InterfaceEntryHeaderOut."Source No." := PurchRcptLine."Document No.";
            //<< HEI.47
            //GeneralInterfaceSetup."RD Movement Type":
            SRMInterfaceSetup."RD Movement Type":
                InterfaceEntryHeaderOut."Source No." := PurchaseHeader."Last Return Shipment No.";
            //GeneralInterfaceSetup."RD Cancellation Movement Type":
            SRMInterfaceSetup."RD Cancellation Movement Type":
                //HEI.17>>
                InterfaceEntryHeaderOut."Source No." := PurchaseHeader."Last Return Shipment No.";
        end;
        InterfaceEntryHeaderOut."Message Type" := 'S';
        InterfaceEntryHeaderOut."Version No." := 'N/A';
        InterfaceEntryHeaderOut.INSERT(true);
        CreateGRConfirmationLine(InterfaceEntryHeaderIn, InterfaceEntryHeaderOut, MovementType, PurchaseHeader);
    end;

    local procedure CreateGRConfirmationLine(InterfaceEntryHeaderIn: Record "Interface Entry Header INT"; InterfaceEntryHeaderOut: Record "Interface Entry Header INT"; MovementType: Code[10]; var PurchHeader: Record "Purchase Header");
    var
        InterfaceEntryLineIn: Record "Interface Entry Line INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        ReturnShipmentLine: Record "Return Shipment Line";
        ReturnOrderLine: Record "Purchase Line";
        EntryNo: Integer;
    begin
        //GR confirmation line NAV -> SRM
        GetGeneralInterfaceSetup();
        //HEI.17>>
        GetSRMInterfaceSetup();
        case MovementType of
            //GeneralInterfaceSetup."GR Creation Movement Type",
            SRMInterfaceSetup."GR Creation Movement Type",
            //GeneralInterfaceSetup."GR Cancellation Movement Type":
            SRMInterfaceSetup."GR Cancellation Movement Type":
                //HEI.17
                begin
                    InterfaceEntryLineIn.SETRANGE("Header Entry No.", InterfaceEntryHeaderIn."Entry No.");
                    if InterfaceEntryLineIn.findset() then
                        repeat
                            //>> HEI.44
                            if not IsLimitPO(PurchHeader) then begin
                                PurchRcptLine.SETRANGE("Document No.", InterfaceEntryHeaderOut."Source No.");
                                PurchRcptLine.SETRANGE("SRM Order Line No. FND", InterfaceEntryLineIn."External Order Line No.");
                                PurchRcptLine.SETFILTER(Quantity, '>%1', 0);
                                if PurchRcptLine.findset() then
                                    repeat
                                        CLEAR(InterfaceEntryLineOut);
                                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                        EntryNo := EntryNo + 1;
                                        InterfaceEntryLineOut."Entry No." := EntryNo;
                                        InterfaceEntryLineOut."Source Line No." := PurchRcptLine."Line No.";
                                        InterfaceEntryLineOut."External Order Line No." := PurchRcptLine."SRM Order Line No. FND";
                                        InterfaceEntryLineOut.INSERT();
                                    until PurchRcptLine.NEXT() = 0;
                            end else begin
                                PurchRcptLine.SETRANGE("Document No.", InterfaceEntryHeaderOut."Source No.");
                                PurchRcptLine.SETRANGE("SRM Order Line No. FND", InterfaceEntryLineIn."External Order Line No.");
                                if PurchRcptLine.FINDFIRST() then begin
                                    CLEAR(InterfaceEntryLineOut);
                                    InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                    EntryNo := EntryNo + 1;
                                    InterfaceEntryLineOut."Entry No." := EntryNo;
                                    InterfaceEntryLineOut."Source Line No." := PurchRcptLine."Line No.";
                                    InterfaceEntryLineOut."External Order Line No." := PurchRcptLine."SRM Order Line No. FND";
                                    InterfaceEntryLineOut.INSERT();
                                end;
                            end;
                        //<< HEI.44
                        until InterfaceEntryLineIn.NEXT() = 0;
                end;
            //HEI.17>>
            //GeneralInterfaceSetup."RD Movement Type",
            SRMInterfaceSetup."RD Movement Type",
            //GeneralInterfaceSetup."RD Cancellation Movement Type":
            SRMInterfaceSetup."RD Cancellation Movement Type":
                //HEI.17<<
                begin
                    InterfaceEntryLineIn.SETRANGE("Header Entry No.", InterfaceEntryHeaderIn."Entry No.");
                    if InterfaceEntryLineIn.findset() then
                        repeat
                            ReturnShipmentLine.SETRANGE("Document No.", InterfaceEntryHeaderOut."Source No.");

                            // BC Upgrade MISHRS14 >> 
                            // Added FND In "SRM Order Line No. FND"
                            ReturnShipmentLine.SETRANGE("SRM Order Line No. FND", InterfaceEntryLineIn."External Order Line No.");
                            // BC Upgrade MISHRS14 <<

                            ReturnShipmentLine.SETFILTER(Quantity, '>%1', 0);
                            if ReturnShipmentLine.findset() then
                                repeat
                                    CLEAR(InterfaceEntryLineOut);
                                    InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                    EntryNo := EntryNo + 1;
                                    InterfaceEntryLineOut."Entry No." := EntryNo;
                                    ReturnOrderLine.GET(ReturnOrderLine."Document Type"::"Return Order",
                                                        ReturnShipmentLine."Return Order No.",
                                                        ReturnShipmentLine."Return Order Line No.");
                                    InterfaceEntryLineOut."Source Line No." := ReturnOrderLine."Order Line No.";

                                    // BC Upgrade MISHRS14 >> 
                                    // Added FND In "SRM Order Line No. FND"
                                    InterfaceEntryLineOut."External Order Line No." := ReturnShipmentLine."SRM Order Line No. FND";
                                    // BC Upgrade MISHRS14 <<

                                    InterfaceEntryLineOut.INSERT();
                                until ReturnShipmentLine.NEXT() = 0;
                        until InterfaceEntryLineIn.NEXT() = 0;
                end;
        end;
    end;

    local procedure DeleteEmptyPurchaseReturnOrder(PurchaseReturnHeader: Record "Purchase Header");
    var
        PurchaseReturnLine: Record "Purchase Line";
    begin
        PurchaseReturnLine.SETRANGE("Document Type", PurchaseReturnHeader."Document Type");
        PurchaseReturnLine.SETRANGE("Document No.", PurchaseReturnHeader."No.");
        if PurchaseReturnLine.findset() then
            repeat
                if PurchaseReturnLine."Outstanding Quantity" = 0 then
                    PurchaseReturnLine.DELETE(true);
            until PurchaseReturnLine.NEXT() = 0;
        if PurchaseReturnLine.ISEMPTY then
            PurchaseReturnHeader.DELETE(true);
    end;

    procedure CreateAccountAssignment();
    var
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        Dimension: Record Dimension;
        DimensionValue: Record "Dimension Value";
        GLAccount: Record "G/L Account";
        User: Record User;
        LineEntryNo: Integer;
    begin
        //Account assignment NAV -> SRM
        GetGeneralInterfaceSetup();
        //HEI.17>>
        GetSRMInterfaceSetup();
        //InterfaceSetup.GET(GeneralInterfaceSetup."Account Assignment Interface");
        InterfaceSetup.GET(SRMInterfaceSetup."Account Assignment Interface");
        //HEI.17<<
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        //HEI.17<<
        //Dimension.SETFILTER(Code,GeneralInterfaceSetup."Account Assgn. Dim. Filter");
        Dimension.SETFILTER(Code, SRMInterfaceSetup."Account Assgn. Dim. Filter");
        //HEI.17>>
        if Dimension.findset() then
            repeat
                CLEAR(InterfaceEntryHeader);
                InterfaceEntryHeader.Direction := InterfaceEntryHeader.Direction::Outbound;
                //HEI.17>>
                //InterfaceEntryHeader."Interface Code" := GeneralInterfaceSetup."Account Assignment Interface";
                InterfaceEntryHeader."Interface Code" := SRMInterfaceSetup."Account Assignment Interface";
                //HEI.17>>
                InterfaceEntryHeader."Message Creation DateTime" := CURRENTDATETIME;
                InterfaceEntryHeader."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeader."Msg. Recv. Business System ID" := OutboundInterface."SRM Business System ID";
                InterfaceEntryHeader."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeader."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                InterfaceEntryHeader.INSERT(true);
                CLEAR(InterfaceEntryLine);
                InterfaceEntryLine."Header Entry No." := InterfaceEntryHeader."Entry No.";
                LineEntryNo := LineEntryNo + 1;
                InterfaceEntryLine."Entry No." := LineEntryNo;
                case Dimension.Code of
                    GeneralInterfaceSetup."Cost Center Dimension Code":
                        //HEI.17>>
                        //InterfaceEntryLine."Type ID" := GeneralInterfaceSetup."SRM Cost Center Object Type";
                        InterfaceEntryLine."Type ID" := SRMInterfaceSetup."SRM Cost Center Object Type";
                    GeneralInterfaceSetup."Project Dimension Code":
                        //InterfaceEntryLine."Type ID" := GeneralInterfaceSetup."SRM Project Object Type";
                        InterfaceEntryLine."Type ID" := SRMInterfaceSetup."SRM Project Object Type";
                //HEI.17<<
                end;
                InterfaceEntryLine.INSERT();

                DimensionValue.SETRANGE("Dimension Code", Dimension.Code);
                DimensionValue.SETRANGE(Blocked, false);
                if DimensionValue.findset() then
                    repeat
                        CLEAR(InterfaceEntryComponent);
                        InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
                        InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
                        InterfaceEntryComponent."Table ID" := DimensionValue."Dimension Value ID";
                        InterfaceEntryComponent.Code := DimensionValue."Dimension Code";
                        InterfaceEntryComponent."Value Code" := DimensionValue.Code;
                        InterfaceEntryComponent.Description := COPYSTR(DimensionValue.Name, 1, 40);
                        if STRPOS(DimensionValue."Approver ID FND", '\') = 0 then
                            InterfaceEntryComponent."Approver ID" := DimensionValue."Approver ID FND"
                        else
                            InterfaceEntryComponent."Approver ID" := COPYSTR(DimensionValue."Approver ID FND", STRPOS(DimensionValue."Approver ID FND", '\') + 1);
                        InterfaceEntryComponent."Approver Name" := DimensionValue."Approver Name FND";
                        InterfaceEntryComponent.INSERT();
                    until DimensionValue.NEXT() = 0;
            until Dimension.NEXT() = 0;
    end;

    procedure CreateGLAccount();
    var
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        GLAccount: Record "G/L Account";
        CMGMapping: Record "CMG Mapping FND";
    begin
        //G/L Account NAV -> SRM
        GetGeneralInterfaceSetup();
        //HEI.17>>
        GetSRMInterfaceSetup();
        //InterfaceSetup.GET(GeneralInterfaceSetup."G/L Account Interface");
        InterfaceSetup.GET(SRMInterfaceSetup."G/L Account Interface");
        //HEI.17<<
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeader);
        InterfaceEntryHeader.Direction := InterfaceEntryHeader.Direction::Outbound;
        //HEI.17>>
        //InterfaceEntryHeader."Interface Code" := GeneralInterfaceSetup."G/L Account Interface";
        InterfaceEntryHeader."Interface Code" := SRMInterfaceSetup."G/L Account Interface";
        //HEI.17<<
        InterfaceEntryHeader."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeader."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        InterfaceEntryHeader."Msg. Recv. Business System ID" := OutboundInterface."SRM Business System ID";
        InterfaceEntryHeader."Source System ID" := OutboundInterface."Logical System ID";
        InterfaceEntryHeader."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
        InterfaceEntryHeader.INSERT(true);

        CLEAR(InterfaceEntryLine);
        InterfaceEntryLine."Header Entry No." := InterfaceEntryHeader."Entry No.";
        InterfaceEntryLine."Entry No." := 1;
        //HEI.17>>
        //InterfaceEntryLine."Type ID" := GeneralInterfaceSetup."SRM G/L Account Object Type";
        InterfaceEntryLine."Type ID" := SRMInterfaceSetup."SRM G/L Account Object Type";
        //HEI.17<<
        InterfaceEntryLine.INSERT();

        //>> HEI.15
        if CMGMapping.findset() then begin
            repeat
                GLAccount.SETRANGE(Blocked, false);
                GLAccount.SETRANGE("Account Type", GLAccount."Account Type"::Posting);
                GLAccount.SETRANGE("Direct Posting", true);
                //GLAccount.SETRANGE("CIL3 Code",CMGMapping."CIL3 Code"); //HEI.19 //HEI.45-Commented
                GLAccount.SETRANGE("C&TP CODE FND", CMGMapping."C&TP CODE"); //HEI.45
                if GLAccount.findset() then
                    repeat
                        //>> HEI.13
                        //>> HEI.20
                        //IF (PurchSetup."SRM G/L Account Position" <> 0) AND (PurchSetup."SRM G/L Account Position Val." <> '') THEN BEGIN
                        //  IF COPYSTR(GLAccount."No.",PurchSetup."SRM G/L Account Position",1) <> PurchSetup."SRM G/L Account Position Val." THEN BEGIN
                        if (SRMInterfaceSetup."SRM G/L Account Position" <> 0) and (SRMInterfaceSetup."SRM G/L Account Position Val." <> '') then begin
                            if COPYSTR(GLAccount."No.", SRMInterfaceSetup."SRM G/L Account Position", 1) <> SRMInterfaceSetup."SRM G/L Account Position Val." then begin
                                //<< HEI.20
                                CLEAR(InterfaceEntryComponent);
                                InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
                                InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
                                InterfaceEntryComponent."Table ID" := DATABASE::"G/L Account";
                                InterfaceEntryComponent.Code := COPYSTR(GLAccount."No." + CMGMapping."Dimension Value Code", 1, 20);
                                InterfaceEntryComponent."Value Code" := GLAccount."No.";
                                InterfaceEntryComponent."Type ID" := CMGMapping."Dimension Value Code";
                                InterfaceEntryComponent.Description := COPYSTR(GLAccount.Name, 1, 40);
                                InterfaceEntryComponent.INSERT();
                            end;
                        end else begin
                            CLEAR(InterfaceEntryComponent);
                            InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
                            InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
                            InterfaceEntryComponent."Table ID" := DATABASE::"G/L Account";
                            InterfaceEntryComponent.Code := GLAccount."No.";
                            InterfaceEntryComponent."Value Code" := GLAccount."No.";
                            InterfaceEntryComponent.Description := COPYSTR(GLAccount.Name, 1, 40);
                            InterfaceEntryComponent.INSERT();
                        end;
                    until GLAccount.NEXT() = 0;
            until CMGMapping.NEXT() = 0;
        end else begin
            GLAccount.SETRANGE(Blocked, false);
            GLAccount.SETRANGE("Account Type", GLAccount."Account Type"::Posting);
            GLAccount.SETRANGE("Direct Posting", true);
            if GLAccount.findset() then begin
                repeat
                    CLEAR(InterfaceEntryComponent);
                    InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
                    InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
                    InterfaceEntryComponent."Table ID" := DATABASE::"G/L Account";
                    InterfaceEntryComponent.Code := GLAccount."No.";
                    InterfaceEntryComponent."Value Code" := GLAccount."No.";
                    InterfaceEntryComponent.Description := COPYSTR(GLAccount.Name, 1, 40);
                    InterfaceEntryComponent.INSERT();
                //<< HEI.13
                until GLAccount.NEXT() = 0;
            end;
        end;
        //<< HEI.15
    end;

    procedure CreateInterfaceConfirmationError(InterfaceEntryHeaderIn: Record "Interface Entry Header INT"; ErrorMessage: Text; ResponseInterfaceCode: Code[20]);
    var
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceEntryLineIn: Record "Interface Entry Line INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        PurchaseHeader: Record "Purchase Header";
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
    begin
        GetGeneralInterfaceSetup();
        GetSRMInterfaceSetup(); //HEI.17
        InterfaceSetup.GET(ResponseInterfaceCode);
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeaderIn, false);
        InterfaceEntryHeaderOut."Interface Code" := ResponseInterfaceCode;
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Msg. Sender Business System ID" := InterfaceEntryHeaderIn."Msg. Recv. Business System ID";
        if InterfaceEntryHeaderOut."Msg. Sender Business System ID" = '' then
            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := InterfaceEntryHeaderIn."Msg. Sender Business System ID";
        case ResponseInterfaceCode of
            //HEI.17>>
            //GeneralInterfaceSetup."PO Confirmation Interface":
            SRMInterfaceSetup."PO Confirmation Interface":
                InterfaceEntryHeaderOut."Object Type" := 'PO';
            //GeneralInterfaceSetup."GR Confirmation Interface":
            SRMInterfaceSetup."GR Confirmation Interface":
                //HEI.17<<
                InterfaceEntryHeaderOut."Object Type" := 'GR';
        end;
        InterfaceEntryHeaderOut."Message Type" := 'E';
        InterfaceEntryHeaderOut."Type ID" := '300';
        InterfaceEntryHeaderOut."Severity Code" := '3';
        InterfaceEntryHeaderOut."Log Message" := COPYSTR(ErrorMessage, 1, MAXSTRLEN(InterfaceEntryHeaderOut."Log Message"));
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLineIn.SETRANGE("Header Entry No.", InterfaceEntryHeaderIn."Entry No.");
        if InterfaceEntryLineIn.findset() then
            repeat
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut.TRANSFERFIELDS(InterfaceEntryLineIn, false);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                InterfaceEntryLineOut."Entry No." := InterfaceEntryLineIn."Entry No.";
                InterfaceEntryLineOut."Type ID" := InterfaceEntryHeaderOut."Type ID";
                InterfaceEntryLineOut."Severity Code" := InterfaceEntryHeaderOut."Severity Code";
                InterfaceEntryLineOut."Log Message" := InterfaceEntryHeaderOut."Log Message";
                InterfaceEntryLineOut.INSERT();
            until InterfaceEntryLineIn.NEXT() = 0;
    end;

    // BC Upgrade NANDIS03 - Temp Blob record is blocked >>
    // local procedure CreateNoteRecordLink(var TempBlob: Record TempBlob; RecID: RecordID; TableID: Integer; PageID: Integer; Description: Text);
    local procedure CreateNoteRecordLink(var TempBlob: Codeunit "Temp Blob"; RecID: RecordID; TableID: Integer; PageID: Integer; Description: Text);
    // BC Upgrade NANDIS03 - Temp Blob record is blocked <<
    var
        RecordLink: Record "Record Link";
        TypeHelper: Codeunit "Type Helper";
        InStr: InStream;
        NoteText: Text;
    begin
        RecordLink.SETRANGE("Record ID", RecID);
        RecordLink.DELETEALL();

        CLEAR(RecordLink);
        RecordLink."Link ID" := 0;
        RecordLink."Record ID" := RecID;
        RecordLink.Description := Description;
        RecordLink.URL1 := GETURL(CLIENTTYPE::Windows, COMPANYNAME, OBJECTTYPE::Page, PageID);
        RecordLink.Type := RecordLink.Type::Note;
        RecordLink.Created := CURRENTDATETIME;
        RecordLink."User ID" := USERID;
        RecordLink.Company := COMPANYNAME;
        // BC Upgrade NANDIS03 >>
        // TempBlob.Blob.CREATEINSTREAM(InStr);
        TempBlob.CreateInStream(InStr);
        // BC Upgrade NANDIS03 <<
        InStr.READTEXT(NoteText);
        // TypeHelper.WriteRecordLinkNote(RecordLink, NoteText);  // BC Upgrade NANDIS03 - Blocked temporarily
        RecordLink.INSERT();
    end;

    procedure UpdateSRMHeaderFromBlanketOrder(var PurchaseHeader: Record "Purchase Header");
    var
        PurchaseBlanketOrder: Record "Purchase Header";
        lrecPurchHdrAddtnl: Record "Purchase Header Additional FND";
    begin
        if PurchaseHeader."Blanket Order No. FND" <> '' then begin
            if PurchaseBlanketOrder.GET(PurchaseBlanketOrder."Document Type"::"Blanket Order", PurchaseHeader."Blanket Order No. FND") then begin
                PurchaseHeader.TESTFIELD("Currency Code", PurchaseBlanketOrder."Currency Code");
                PurchaseHeader.VALIDATE("SRM Contract Type FND", PurchaseBlanketOrder."SRM Contract Type FND");
                PurchaseHeader.VALIDATE("SRM Contract No. FND", PurchaseBlanketOrder."SRM Contract No. FND");
                PurchaseHeader.VALIDATE("SRM Contract Name FND", PurchaseBlanketOrder."SRM Contract Name FND");
                PurchaseHeader.VALIDATE("Valid From FND", PurchaseBlanketOrder."Valid From FND");
                PurchaseHeader.VALIDATE("Valid To FND", PurchaseBlanketOrder."Valid To FND");
                PurchaseHeader.VALIDATE("Target Value Currency FND", PurchaseBlanketOrder."Target Value Currency FND");
                PurchaseHeader.VALIDATE("Target Value Amount FND", PurchaseBlanketOrder."Target Value Amount FND");
                //PurchaseHeader.VALIDATE("Posting Description",PurchaseBlanketOrder."Posting Description");  //HEI.69
                PurchaseHeader.VALIDATE("Closed FND", PurchaseBlanketOrder."Closed FND");
                PurchaseHeader.VALIDATE("Purchaser Code", PurchaseBlanketOrder."Purchaser Code");
                //HEI.55>>
                //IF PurchaseHeader."Shipment Method Code" <> PurchaseBlanketOrder."Shipment Method Code" THEN
                //  PurchaseHeader.VALIDATE("Shipment Method Code",PurchaseBlanketOrder."Shipment Method Code");
                if PurchaseHeader."Shipment Method Code" <> PurchaseBlanketOrder."Shipment Method Code" then begin
                    if lrecPurchHdrAddtnl.GET(PurchaseHeader."Document Type"::Order, PurchaseHeader."No.") then begin
                        if (lrecPurchHdrAddtnl."PFI Document No. INT" = '') then
                            PurchaseHeader.VALIDATE("Shipment Method Code", PurchaseBlanketOrder."Shipment Method Code");
                    end;
                end;
                //HEI.55<<
                PurchaseHeader.VALIDATE("Shipment Method Location FND", PurchaseBlanketOrder."Shipment Method Location FND");
                //HEI.55>>
                //PurchaseHeader.VALIDATE("Payment Terms Code",PurchaseBlanketOrder."Payment Terms Code");
                if lrecPurchHdrAddtnl.GET(PurchaseHeader."Document Type"::Order, PurchaseHeader."No.") then begin
                    if (lrecPurchHdrAddtnl."PFI Document No. INT" = '') then
                        PurchaseHeader.VALIDATE("Payment Terms Code", PurchaseBlanketOrder."Payment Terms Code");
                end;
                //HEI.55<<
                PurchaseHeader.VALIDATE("Channel FND", PurchaseBlanketOrder."Channel FND");
            end;
        end else begin
            PurchaseHeader.VALIDATE("SRM Contract Type FND", '');
            PurchaseHeader.VALIDATE("SRM Contract No. FND", '');
            PurchaseHeader.VALIDATE("SRM Contract Name FND", '');
            PurchaseHeader.VALIDATE("Valid From FND", 0D);
            PurchaseHeader.VALIDATE("Valid To FND", 0D);
            PurchaseHeader.VALIDATE("Currency Code", '');
            PurchaseHeader.VALIDATE("Target Value Currency FND", '');
            PurchaseHeader.VALIDATE("Target Value Amount FND", 0);
            //PurchaseHeader.VALIDATE("Posting Description",'');  //HEI.69
            PurchaseHeader.VALIDATE("Closed FND", false);
            PurchaseHeader.VALIDATE("Purchaser Code", '');
            PurchaseHeader.VALIDATE("Shipment Method Code", '');
            PurchaseHeader.VALIDATE("Shipment Method Location FND", '');
            PurchaseHeader.VALIDATE("Payment Terms Code", '');
            PurchaseHeader.VALIDATE("Channel FND", '');
        end;
    end;

    procedure UpdateSRMLineFromBlanketOrderLine(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line");
    var
        PurchaseBlanketOrderLine: Record "Purchase Line";
    begin
        if PurchaseLine."Blanket Order Line No." <> 0 then begin
            if PurchaseBlanketOrderLine.GET(PurchaseBlanketOrderLine."Document Type"::"Blanket Order",
                                            PurchaseLine."Blanket Order No.",
                                            PurchaseLine."Blanket Order Line No.")
            then begin
                PurchaseLine.VALIDATE("SRM Contract No. FND", PurchaseBlanketOrderLine."SRM Contract No. FND");
                PurchaseLine.VALIDATE("SRM Contract Line No. FND", PurchaseBlanketOrderLine."SRM Contract Line No. FND");
                PurchaseLine.VALIDATE("Type ID FND", PurchaseBlanketOrderLine."Type ID FND");
                PurchaseLine.VALIDATE("Block Line Ordering FND", PurchaseBlanketOrderLine."Block Line Ordering FND");
                PurchaseLine.VALIDATE("CMG Code FND", PurchaseBlanketOrderLine."CMG Code FND");
                PurchaseLine.VALIDATE("Target Value Currency FND", PurchaseBlanketOrderLine."Target Value Currency FND");
                PurchaseLine.VALIDATE("Target Value Amount FND", PurchaseBlanketOrderLine."Target Value Amount FND");
                PurchaseLine.VALIDATE("Tolerance Received Under % FND", PurchaseBlanketOrderLine."Tolerance Received Under % FND");
                PurchaseLine.VALIDATE("Tolerance Received Over % FND", PurchaseBlanketOrderLine."Tolerance Received Over % FND");
                PurchaseLine.VALIDATE("Last Changed Date/Time FND", PurchaseBlanketOrderLine."Last Changed Date/Time FND");

                if (PurchaseLine."Document Type" = PurchaseLine."Document Type"::"Return Order") and
                   (PurchaseLine."SRM Contract No. FND" <> '') and
                   (PurchaseLine."SRM Contract Line No. FND" <> '')
                then begin
                    if (xPurchaseLine."Blanket Order Line No." <> 0) and
                       (xPurchaseLine."SRM Contract No. FND" <> '') and
                       (xPurchaseLine."SRM Contract Line No. FND" <> '')
                    then
                        CreateContractLineCallOff(xPurchaseLine, 1);
                    CreateContractLineCallOff(PurchaseLine, -1);
                end;
            end;
        end else begin
            if (xPurchaseLine."Document Type" = xPurchaseLine."Document Type"::"Return Order") and
               (xPurchaseLine."SRM Contract No. FND" <> '') and
               (xPurchaseLine."SRM Contract Line No. FND" <> '')
            then
                CreateContractLineCallOff(xPurchaseLine, 1);

            PurchaseLine.VALIDATE("SRM Contract No. FND", '');
            PurchaseLine.VALIDATE("SRM Contract Line No. FND", '');
            PurchaseLine.VALIDATE("Type ID FND", '');
            PurchaseLine.VALIDATE("Block Line Ordering FND", PurchaseLine."Block Line Ordering FND"::" ");
            PurchaseLine.VALIDATE("CMG Code FND", '');
            PurchaseLine.VALIDATE("Target Value Currency FND", '');
            PurchaseLine.VALIDATE("Target Value Amount FND", 0);
            PurchaseLine.VALIDATE("Tolerance Received Under % FND", 0);
            PurchaseLine.VALIDATE("Tolerance Received Over % FND", 0);
            PurchaseLine.VALIDATE("Last Changed Date/Time FND", 0DT);
        end;
    end;

    local procedure CheckEbf(GLAccNo: Code[20]; DimSetID: Integer);
    var
        EbfCombination: Record "Ebf Combination FND";
        DimSetEntry: Record "Dimension Set Entry";
    begin
        FinancialUtils.GetEBFFilterPattern(StartPosNoDigits, FilterOperator);  //HEI.73
        DimSetEntry.SETRANGE("Dimension Set ID", DimSetID);
        if DimSetEntry.findset() then
            repeat
                //HEI.73>>
                //CLEAR(EbfCombination);
                //EbfCombination.SETRANGE("GL Account No.",GLAccNo);
                //EbfCombination.SETRANGE("Dimension Code",DimSetEntry."Dimension Code");
                //EbfCombination.SETRANGE("Dimension Value Code",DimSetEntry."Dimension Value Code");
                //IF EbfCombination.FINDFIRST THEN
                //  IF EbfCombination."Combination Restriction" = EbfCombination."Combination Restriction"::"Not Allowed" THEN
                //    ERROR(GLAccDimCombinationErr,GLAccNo,DimSetEntry."Dimension Value Code");
                EbfCombination.SETCURRENTKEY("GL Account No.", "Dimension Code", "Dimension Value Code");  //HEI.75
                if EbfCombination.CheckNewEBFMatrixIsActive() then begin  //HEI.75
                    EbfCombination.SETFILTER("GL Account No.", COPYSTR(GLAccNo, StartPosNoDigits[1], StartPosNoDigits[2]) + FilterOperator);
                    EbfCombination.SETRANGE("Dimension Code", DimSetEntry."Dimension Code");
                    EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimSetEntry."Dimension Value Code", StartPosNoDigits[3], StartPosNoDigits[4]) + FilterOperator);
                    if (EbfCombination.FINDFIRST()) and (EbfCombination."Combination Restriction" = EbfCombination."Combination Restriction"::"Not Allowed")
                                                  and (GLAccNo <> '') and (DimSetEntry."Dimension Value Code" <> '') then
                        ERROR(GLAccDimCombinationErr, GLAccNo, DimSetEntry."Dimension Value Code");
                    //HEI.73<<
                    //HEI.75>>
                end else begin
                    CLEAR(EbfCombination);
                    EbfCombination.SETRANGE("GL Account No.", GLAccNo);
                    EbfCombination.SETRANGE("Dimension Code", DimSetEntry."Dimension Code");
                    EbfCombination.SETRANGE("Dimension Value Code", DimSetEntry."Dimension Value Code");
                    if EbfCombination.FINDFIRST() then
                        if EbfCombination."Combination Restriction" = EbfCombination."Combination Restriction"::"Not Allowed" then
                            ERROR(GLAccDimCombinationErr, GLAccNo, DimSetEntry."Dimension Value Code");
                end;
            //HEI.75<<
            until DimSetEntry.NEXT() = 0;
    end;

    local procedure GetLineDimensionSetID(InterfaceEntryLine: Record "Interface Entry Line INT"; OldDimensionSetID: Integer): Integer;
    var
        DimensionValue: Record "Dimension Value";
        DimensionSetEntry: Record "Dimension Set Entry";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        TempDimensionSetEntryOld: Record "Dimension Set Entry" temporary;
        DimensionManagement: Codeunit DimensionManagement;
    begin
        GetGeneralInterfaceSetup();

        if InterfaceEntryLine."Cost Center Code" <> '' then begin
            if GeneralInterfaceSetup."Cost Center Dimension Code" = '' then
                ERROR(DimensionNotSetUpErr, GeneralInterfaceSetup.FIELDCAPTION("Cost Center Dimension Code"), InterfaceEntryLine."Cost Center Code");
            CLEAR(TempDimensionSetEntry);
            TempDimensionSetEntry."Dimension Set ID" := -1;
            TempDimensionSetEntry."Dimension Code" := GeneralInterfaceSetup."Cost Center Dimension Code";
            TempDimensionSetEntry."Dimension Value Code" := InterfaceEntryLine."Cost Center Code";
            DimensionValue.GET(GeneralInterfaceSetup."Cost Center Dimension Code", InterfaceEntryLine."Cost Center Code");
            TempDimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
            TempDimensionSetEntry.INSERT();
        end;

        if InterfaceEntryLine."CMG Code" <> '' then begin
            if GeneralInterfaceSetup."CMG Dimension Code" = '' then
                ERROR(DimensionNotSetUpErr, GeneralInterfaceSetup.FIELDCAPTION("CMG Dimension Code"), InterfaceEntryLine."CMG Code");
            CLEAR(TempDimensionSetEntry);
            TempDimensionSetEntry."Dimension Set ID" := -1;
            TempDimensionSetEntry."Dimension Code" := GeneralInterfaceSetup."CMG Dimension Code";
            TempDimensionSetEntry."Dimension Value Code" := InterfaceEntryLine."CMG Code";
            DimensionValue.GET(GeneralInterfaceSetup."CMG Dimension Code", InterfaceEntryLine."CMG Code");
            TempDimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
            TempDimensionSetEntry.INSERT();
        end;

        if InterfaceEntryLine."Project Code" <> '' then begin
            if GeneralInterfaceSetup."Project Dimension Code" = '' then
                ERROR(DimensionNotSetUpErr, GeneralInterfaceSetup.FIELDCAPTION("Project Dimension Code"), InterfaceEntryLine."Project Code");
            CLEAR(TempDimensionSetEntry);
            TempDimensionSetEntry."Dimension Set ID" := -1;
            TempDimensionSetEntry."Dimension Code" := GeneralInterfaceSetup."Project Dimension Code";
            TempDimensionSetEntry."Dimension Value Code" := InterfaceEntryLine."Project Code";
            DimensionValue.GET(GeneralInterfaceSetup."Project Dimension Code", InterfaceEntryLine."Project Code");
            TempDimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
            TempDimensionSetEntry.INSERT();

            GetDimensionComponents(TempDimensionSetEntry, GeneralInterfaceSetup."Project Dimension Code", InterfaceEntryLine."Project Code");
        end;

        DimensionManagement.GetDimensionSet(TempDimensionSetEntryOld, OldDimensionSetID);
        if TempDimensionSetEntryOld.findset() then
            repeat
                TempDimensionSetEntry.SETRANGE("Dimension Code", TempDimensionSetEntryOld."Dimension Code");
                if TempDimensionSetEntry.FINDFIRST() then begin
                    TempDimensionSetEntry."Dimension Value Code" := TempDimensionSetEntryOld."Dimension Value Code";
                    TempDimensionSetEntry."Dimension Value ID" := TempDimensionSetEntryOld."Dimension Value ID";
                    TempDimensionSetEntry.MODIFY();
                end else begin
                    CLEAR(TempDimensionSetEntry);
                    TempDimensionSetEntry."Dimension Set ID" := -1;
                    TempDimensionSetEntry."Dimension Code" := TempDimensionSetEntryOld."Dimension Code";
                    TempDimensionSetEntry."Dimension Value Code" := TempDimensionSetEntryOld."Dimension Value Code";
                    TempDimensionSetEntry."Dimension Value ID" := TempDimensionSetEntryOld."Dimension Value ID";
                    TempDimensionSetEntry.INSERT();
                end;
            until TempDimensionSetEntryOld.NEXT() = 0;

        if TempDimensionSetEntry.ISTEMPORARY then
            exit(DimensionSetEntry.GetDimensionSetID(TempDimensionSetEntry));
    end;

    local procedure GetDimensionComponents(var TempDimSetEntry: Record "Dimension Set Entry"; DimCode: Code[20]; DimValueCode: Code[20]);
    var
        DimensionValueComponent: Record "Dimension Value Component FND";
        DimVal2: Record "Dimension Value";
    begin
        DimensionValueComponent.SETRANGE("Dimension 1 Code", DimCode);
        DimensionValueComponent.SETRANGE("Dimension 1 Value Code", DimValueCode);
        if DimensionValueComponent.findset() then
            repeat
                DimVal2.GET(DimensionValueComponent."Dimension 2 Code", DimensionValueComponent."Dimension 2 Value Code");
                if TempDimSetEntry.GET(TempDimSetEntry."Dimension Set ID", DimVal2."Dimension Code") then
                    if TempDimSetEntry."Dimension Value Code" <> DimValueCode then
                        TempDimSetEntry.DELETE();

                TempDimSetEntry."Dimension Code" := DimVal2."Dimension Code";
                TempDimSetEntry."Dimension Value Code" := DimVal2.Code;
                TempDimSetEntry."Dimension Value ID" := DimVal2."Dimension Value ID";
                if TempDimSetEntry.INSERT() then;
            until DimensionValueComponent.NEXT() = 0;
    end;

    local procedure GetChannelFromTypeID(TypeID: Code[10]): Code[20];
    var
        Channel: Record "Channel FND";
    begin
        Channel.SETRANGE("Type ID", TypeID);
        if Channel.FINDFIRST() then
            exit(Channel.Code);
    end;

    local procedure GetGeneralInterfaceSetup();
    begin
        if not GeneralInterfaceSetupRead then
            GeneralInterfaceSetup.GET();
        GeneralInterfaceSetupRead := true;
    end;

    local procedure GetGLSetup();
    begin
        if not GLSetupRead then
            GLSetup.GET();
        GLSetupRead := true;
    end;

    local procedure GetPurchSetup();
    begin
        if not PurchSetupRead then
            PurchSetup.GET();
        PurchSetupRead := true;
    end;

    procedure CheckDimenssionOnPOCreation(PurchaseHeader: Record "Purchase Header");
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseLine: Record "Purchase Line";
        GLAccount: Record "G/L Account";
        DimensionSetEntry: Record "Dimension Set Entry";
        CCCode: Boolean;
        DefaultDimension: Record "Default Dimension";
    begin
        //HEI.17>>
        if not (PurchaseHeader."Document Type" in [PurchaseHeader."Document Type"::Quote, PurchaseHeader."Document Type"::"Return Order"]) then
            exit;

        GeneralLedgerSetup.GET();
        GeneralLedgerSetup.TESTFIELD("Cost Center Dimension Code FND");

        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETFILTER(Type, '%1|%2', PurchaseLine.Type::"G/L Account", PurchaseLine.Type::"Charge (Item)");
        if PurchaseLine.findset() then
            repeat
                case PurchaseLine.Type of
                    PurchaseLine.Type::"G/L Account":
                        begin
                            if not GLAccount.GET(PurchaseLine."No.") then
                                GLAccount.INIT();
                        end;
                    PurchaseLine.Type::"Charge (Item)":
                        begin
                            if not GeneralPostingSetup.GET(PurchaseLine."Gen. Bus. Posting Group", PurchaseLine."Gen. Prod. Posting Group") then
                                GeneralPostingSetup.INIT();
                            if not GLAccount.GET(GeneralPostingSetup."Purchase Variance Account") then
                                GLAccount.INIT();
                        end;
                end;
                DimensionSetEntry.SETRANGE("Dimension Set ID", PurchaseLine."Dimension Set ID");
                if DimensionSetEntry.findset() then
                    repeat
                        if DefaultDimension.GET(DATABASE::"G/L Account", GLAccount."No.", DimensionSetEntry."Dimension Code") then
                            case DefaultDimension."Value Posting" of
                                DefaultDimension."Value Posting"::"Code Mandatory":
                                    begin
                                        if (not DimensionSetEntry.GET(PurchaseLine."Dimension Set ID", DimensionSetEntry."Dimension Code")) or
                                          (DimensionSetEntry."Dimension Value Code" = '')
                                        then
                                            ERROR(Error010, PurchaseLine."Line No.");
                                    end;
                                DefaultDimension."Value Posting"::"Same Code":
                                    begin
                                        if DefaultDimension."Dimension Value Code" <> '' then begin
                                            if (not DimensionSetEntry.GET(PurchaseLine."Dimension Set ID", DimensionSetEntry."Dimension Code")) or
                                              (DimensionSetEntry."Dimension Value Code" <> DefaultDimension."Dimension Value Code")
                                            then
                                                ERROR(Error010, PurchaseLine."Line No.");
                                        end else begin
                                            if (not DimensionSetEntry.GET(PurchaseLine."Dimension Set ID", DimensionSetEntry."Dimension Code")) or
                                              (DimensionSetEntry."Dimension Value Code" = '')
                                            then
                                                ERROR(Error010, PurchaseLine."Line No.");
                                        end;
                                    end;
                                DefaultDimension."Value Posting"::"No Code":
                                    begin
                                        if DimensionSetEntry.GET(PurchaseLine."Dimension Set ID", DimensionSetEntry."Dimension Code") then
                                            ERROR(Error011, PurchaseLine."Line No.");
                                    end;
                            end;
                    until DimensionSetEntry.NEXT() = 0;
                //END;


                DimensionSetEntry.SETRANGE("Dimension Set ID", PurchaseLine."Dimension Set ID");
                if DimensionSetEntry.findset() then
                    repeat
                        if EbfCombination.GET(GLAccount."No.", DimensionSetEntry."Dimension Code", DimensionSetEntry."Dimension Value Code") and
                          (EbfCombination."Combination Restriction" = EbfCombination."Combination Restriction"::"Not Allowed")
                        then
                            ERROR(Error012, PurchaseLine."No.", DimensionSetEntry."Dimension Code", DimensionSetEntry."Dimension Value Code", PurchaseLine."Line No.");
                    until DimensionSetEntry.NEXT() = 0;

            until PurchaseLine.NEXT() = 0;
        //<<HEI.17<<
    end;

    local procedure UpdateBlanketOrderSRMRelatedLines(var PurchaseLine: Record "Purchase Line"; InterfaceEntryLine: Record "Interface Entry Line INT"; InterfaceEntryHeader: Record "Interface Entry Header INT"; PurchaseHeader: Record "Purchase Header");
    var
        ItemCharge: Record "Item Charge";
        Item: Record Item;
        UoMCode: Code[10];
        ChannelInfo: Code[10];
        PurChLineLL: Record "Purchase Line";
        OutstandngQtyL: Decimal;
    begin
        //>> HEI.18
        if InterfaceEntryLine."No." <> '' then begin
            if InterfaceEntryLine."No." <> PurchaseLine."No." then begin
                if IsChangedValue(PurchaseLine.Type, InterfaceEntryLine.Type::Item) then //HEI.47
                    PurchaseLine.VALIDATE(Type, InterfaceEntryLine.Type::Item);
                if IsChangedValue(PurchaseLine."No.", InterfaceEntryLine."No.") then //HEI.47
                    PurchaseLine.VALIDATE("No.", InterfaceEntryLine."No.");
            end;
        end else
            if InterfaceEntryLine."CMG Code" <> '' then begin
                if ItemCharge.GET(InterfaceEntryLine."CMG Code") then begin
                    if InterfaceEntryLine."CMG Code" <> PurchaseLine."No." then begin
                        if IsChangedValue(PurchaseLine.Type, InterfaceEntryLine.Type::"Charge (Item)") then //HEI.47
                            PurchaseLine.VALIDATE(Type, InterfaceEntryLine.Type::"Charge (Item)");
                        if IsChangedValue(PurchaseLine."No.", InterfaceEntryLine."CMG Code") then //HEI.47
                            PurchaseLine.VALIDATE("No.", InterfaceEntryLine."CMG Code");
                    end;
                end else begin
                    //HEI.17>>
                    //GeneralInterfaceSetup.TESTFIELD("Contract Default G/L Acc. No.");
                    SRMInterfaceSetup.TESTFIELD("Contract Default G/L Acc. No.");
                    //IF GeneralInterfaceSetup."Contract Default G/L Acc. No." <> PurchaseLine."No." THEN BEGIN
                    if SRMInterfaceSetup."Contract Default G/L Acc. No." <> PurchaseLine."No." then begin
                        if (IsChangedValue(PurchaseLine.Type, InterfaceEntryLine.Type)) and (InterfaceEntryLine.Type <> InterfaceEntryLine.Type::" ") or (InterfaceEntryLine."Action Code" <> '02') then begin//HEI.52
                            PurchaseLine.VALIDATE(Type, InterfaceEntryLine.Type::"G/L Account");
                            //PurchaseLine.VALIDATE("No.",GeneralInterfaceSetup."Contract Default G/L Acc. No.");
                            if IsChangedValue(PurchaseLine."No.", SRMInterfaceSetup."Contract Default G/L Acc. No.") then //HEI.47
                                PurchaseLine.VALIDATE("No.", SRMInterfaceSetup."Contract Default G/L Acc. No.");
                        end;//HEI.52
                            //HEI.17<<
                    end;
                end;
            end;
        // BC Upgrade SHUKLP03 >> Blocked because field "Cross Reference No." is removed from business central.  
        // if InterfaceEntryLine."Cross Reference No." <> '' then
        //     if IsChangedValue(PurchaseLine."Cross-Reference No.", InterfaceEntryLine."Cross Reference No.") then //HEI.47
        //         PurchaseLine.VALIDATE("Cross-Reference No.", InterfaceEntryLine."Cross Reference No.");
        // BC Upgrade SHUKLP03 << Blocked because field "Cross Reference No." is removed from business central.   

        if InterfaceEntryLine."Currency Code" <> GLSetup."LCY Code" then begin
            if IsChangedValue(PurchaseLine."Currency Code", InterfaceEntryLine."Currency Code") then //HEI.47
                PurchaseLine.VALIDATE("Currency Code", InterfaceEntryLine."Currency Code")
        end else
            PurchaseLine.VALIDATE("Currency Code", '');  //HEI.10
        PurchaseLine.Description := InterfaceEntryLine.Description;
        PurchaseLine."Description 2" := InterfaceEntryLine."Description 2";
        if InterfaceEntryLine."Location Code" <> PurchaseLine."Location Code" then
            if IsChangedValue(PurchaseLine."Location Code", InterfaceEntryLine."Location Code") then //HEI.47
                PurchaseLine.VALIDATE("Location Code", InterfaceEntryLine."Location Code");
        if InterfaceEntryLine."Unit of Measure Code" <> '' then begin
            UoMCode := InterfaceFrameworkMgt.GetISOCodeUnitOfMeasure(InterfaceEntryLine."Unit of Measure Code");
            if UoMCode <> PurchaseLine."Unit of Measure Code" then
                if IsChangedValue(PurchaseLine."Unit of Measure", UoMCode) then //HEI.47
                    PurchaseLine.VALIDATE("Unit of Measure Code", UoMCode);
        end;
        //>>HEI.52
        ChannelInfo := InterfaceEntryHeader.Channel;
        CLEAR(OutstandngQtyL);
        PurChLineLL.RESET();
        PurChLineLL.SETRANGE(PurChLineLL."Blanket Order No.", PurchaseLine."Document No.");
        PurChLineLL.SETRANGE(PurChLineLL."Blanket Order Line No.", PurchaseLine."Line No.");
        if PurChLineLL.findset() then begin
            repeat
                OutstandngQtyL := OutstandngQtyL + PurChLineLL."Outstanding Quantity";
            until
              PurChLineLL.NEXT() = 0;
        end;
        if InterfaceEntryLine.Quantity <> 0 then begin
            //>>HEI.53
            if (InterfaceEntryLine."Action Code" = '02') and ((ChannelInfo <> 'D') or (ChannelInfo <> '')) then begin
                if (InterfaceEntryLine.Quantity > (OutstandngQtyL + PurchaseLine."Quantity Received")) and (InterfaceEntryLine.Quantity > PurchaseLine.Quantity) then
                    PurchaseLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity)
                else
                    PurchaseLine.Quantity := PurchaseLine.Quantity;
            end
            //<<HEI.53
            else begin
                PurchaseLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                PurchaseLine.SetCurrFieldNo(PurchaseLine.FIELDNO("Direct Unit Cost"));//HEI.07
                PurchaseLine.VALIDATE("Direct Unit Cost", ROUND(InterfaceEntryLine."Line Amount" / InterfaceEntryLine.Quantity, GLSetup."Unit-Amount Rounding Precision"));
                PurchaseLine.SetCurrFieldNo(0);//HEI.07
                PurchaseLine."Initial Quantity FND" := InterfaceEntryLine.Quantity;
            end;
        end else begin
            if InterfaceEntryLine."Action Code" <> '02' then begin
                PurchaseLine.VALIDATE(Quantity, 1);
                PurchaseLine."Initial Quantity FND" := 1;
            end;
        end;
        //<<HEI.52
        PurchaseLine.VALIDATE("SRM Contract No. FND", InterfaceEntryHeader."External Contract No.");
        PurchaseLine.VALIDATE("SRM Contract Line No. FND", InterfaceEntryLine."External Contract Line No.");
        PurchaseLine.VALIDATE("Type ID FND", InterfaceEntryLine."Type ID");
        PurchaseLine.VALIDATE("Target Value Currency FND", PurchaseHeader."Currency Code");
        PurchaseLine.VALIDATE("Target Value Amount FND", InterfaceEntryLine."Line Amount");
        if InterfaceEntryLine.Locked then begin
            if InterfaceEntryLine.Closed then
                PurchaseLine.VALIDATE("Block Line Ordering FND", PurchaseLine."Block Line Ordering FND"::F)
            else
                PurchaseLine.VALIDATE("Block Line Ordering FND", PurchaseLine."Block Line Ordering FND"::B)
        end else begin
            if InterfaceEntryLine.Closed then
                PurchaseLine.VALIDATE("Block Line Ordering FND", PurchaseLine."Block Line Ordering FND"::F)
            else
                PurchaseLine.VALIDATE("Block Line Ordering FND", PurchaseLine."Block Line Ordering FND"::" ");
        end;
        PurchaseLine.VALIDATE("CMG Code FND", InterfaceEntryLine."CMG Code");
        PurchaseLine.VALIDATE("Tolerance Received Under % FND", InterfaceEntryLine."Under Percent");
        PurchaseLine.VALIDATE("Tolerance Received Over % FND", InterfaceEntryLine."Over Percent");
        PurchaseLine.VALIDATE("Last Changed Date/Time FND", InterfaceEntryLine."Last Changed Date/Time");
        PurchaseLine.VALIDATE("Lead Time Calculation", InterfaceEntryLine."Lead Time Calculation");
        PurchaseLine."Dimension Set ID" := GetLineDimensionSetID(InterfaceEntryLine, PurchaseLine."Dimension Set ID");
        //HEI.38>>
        if (InterfaceEntryLine."Cost Center Code" <> '') then
            //HEI.38<<
            PurchaseLine.VALIDATE("Shortcut Dimension 2 Code", InterfaceEntryLine."Cost Center Code");
        //<< HEI.18
        PurchaseLine.VALIDATE("SPL Code FND", InterfaceEntryLine.Reference); //HEI.64
    end;

    // BC Upgrade NANDIS03 - Blocked the old logic and opened new >>
    // local procedure CheckDimValueOnPOCreation(PurchLine: Record "Purchase Line");
    // var
    //     DimMgt: Codeunit DimensionManagement;
    //     TableIDArr: array[10] of Integer;
    //     NumberArr: array[10] of Code[20];
    // begin
    //     //HEI.17>>
    //     with PurchLine do begin
    //         // TableIDArr[1] := DimMgt.TypeToTableID3(Type);
    //         TableIDArr[1] := DimMgt.PurchLineTypeToTableID(Type);  // BC Upgrade SHUKLP03 << In Business central procedure name is changed TypeToTableID3() to PurchLineTypeToTableID().
    //         NumberArr[1] := "No.";
    //         if not DimMgt.CheckDimValuePosting(TableIDArr, NumberArr, "Dimension Set ID") then
    //             ERROR(LineInvalidDimensionsErr, "Document Type", "Document No.", "Line No.", DimMgt.GetDimValuePostingErr());
    //     end;
    //     //HEI.17<<
    // end;

    Local procedure CheckDimValueOnPOCreation(PurchLine: Record "Purchase Line")
    var
        DimMgt: Codeunit DimensionManagement;
        TableIDArr: array[10] of Integer;
        NumberArr: array[10] of Code[20];
    begin
        // 1. Convert Purchase Line Type → Table ID (BC SaaS-safe)
        case PurchLine.Type of
            PurchLine.Type::Item:
                TableIDArr[1] := Database::Item;
            PurchLine.Type::"G/L Account":
                TableIDArr[2] := Database::"G/L Account";
            PurchLine.Type::Resource:
                TableIDArr[3] := Database::Resource;
            PurchLine.Type::"Fixed Asset":
                TableIDArr[4] := Database::"Fixed Asset";
            PurchLine.Type::"Charge (Item)":
                TableIDArr[5] := Database::"Item Charge";
            else
                TableIDArr[0] := 0; // Undefined type
        end;
        NumberArr[1] := PurchLine."No.";
        if not DimMgt.CheckDimValuePosting(TableIDArr, NumberArr, PurchLine."Dimension Set ID") then
            ERROR(LineInvalidDimensionsErr, PurchLine."Document Type", PurchLine."Document No.", PurchLine."Line No.", DimMgt.GetDimValuePostingErr());
    end;
    // BC Upgrade NANDIS03 - Blocked the old logic and opened new <<

    local procedure GetSRMInterfaceSetup();
    begin
        //HEI.17>>
        if not SRMInterfaceSetupRead then
            if SRMInterfaceSetup.GET() then
                SRMInterfaceSetupRead := true;
        //HEI.17<<
    end;

    local procedure CheckMandatoryFieldsonPOCreation(PurchLine: Record "Purchase Line");
    var
        DimMgt: Codeunit DimensionManagement;
        TableIDArr: array[10] of Integer;
        NumberArr: array[10] of Code[20];
    begin
        //HEI.30>>
        if PurchLine.Quantity <> 0 then begin
            //TESTFIELD("Gen. Bus. Posting Group");
            PurchLine.TESTFIELD("Gen. Prod. Posting Group");
        end;
        //HEI.30<<
    end;

    local procedure IsLimitPO(PurchaseHeader: Record "Purchase Header"): Boolean;
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        //>> HEI.44
        if PurchaseHeaderAdditional.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") then
            if PurchaseHeaderAdditional."Limit PO" then
                exit(true)
            else
                exit(false);
        //<< HEI.44
    end;

    local procedure IsChangedValue(PurchLineField: Variant; IntEntryLineField: Variant): Boolean;
    var
        RecRefPurch: RecordRef;
        RecRefIntLine: RecordRef;
        varField1: Variant;
        varField2: Variant;
        TextField1: Text;
        TextField2: Text;
    begin
        //>> HEI.47
        TextField1 := FORMAT(PurchLineField);
        TextField2 := FORMAT(IntEntryLineField);

        if TextField1 = TextField2 then
            exit(false)
        else
            exit(true);
        //<< HEI.47
    end;

    local procedure CreateLimitPOLine(var PurchaseLineOriginal: Record "Purchase Line"; var PurchaseLine: Record "Purchase Line"; var LastPurchaseLine: Record "Purchase Line"; InterfaceEntryLine: Record "Interface Entry Line INT");
    var
        PurchaseLineLPO: Record "Purchase Line";
        InitialRemAmt: Decimal;
        InterfaceEntryHeader: Record "Interface Entry Header INT";
    begin
        //HEI.98<<
        if InterfaceEntryHeader.GET(InterfaceEntryLine."Header Entry No.") then
            if InterfaceSetup.GET(InterfaceEntryHeader."Interface Code") then
                if (InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Synchronous) then
                    exit;
        //HEI.98>>
        //>> HEI.44
        PurchaseLineLPO.INIT();
        PurchaseLineLPO."Line No." := LastPurchaseLine."Line No." + 10000;
        PurchaseLineLPO.VALIDATE("Document Type", PurchaseLine."Document Type");
        PurchaseLineLPO.VALIDATE("Document No.", PurchaseLine."Document No.");
        PurchaseLineLPO.VALIDATE(Type, PurchaseLine.Type);
        PurchaseLineLPO.VALIDATE("No.", PurchaseLine."No.");
        PurchaseLineLPO.VALIDATE(Description, PurchaseLine.Description);
        PurchaseLineLPO.VALIDATE("Location Code", PurchaseLine."Location Code");
        PurchaseLineLPO.VALIDATE(Quantity, PurchaseLine.Quantity);
        PurchaseLineLPO.VALIDATE("Additional Description FND", FORMAT(PurchaseLine."SRM Order Line No. FND"));
        //HEI.58>>
        PurchaseLineLPO.VALIDATE("SRM Contract No. FND", PurchaseLine."SRM Contract No. FND");
        PurchaseLineLPO.VALIDATE("SRM Contract Line No. FND", PurchaseLine."SRM Contract Line No. FND");
        //PurchaseLineLPO.VALIDATE("SRM Order No.",PurchaseLine."SRM Order No.");//HEI.61
        //PurchaseLineLPO.VALIDATE("SRM Order Line No. FND",PurchaseLine."SRM Order Line No. FND");//HEI.61
        //HEI.58<<

        if InterfaceEntryLine."Line Amount" > PurchaseLine."Remaining Amount FND" then
            ERROR(NoRemainingAmountOnGRErr, PurchaseLine."Remaining Amount FND");
        if PurchaseLineOriginal."Direct Unit Cost" = 0 then
            InitialRemAmt := PurchaseLineOriginal."Remaining Amount FND"
        else
            InitialRemAmt := PurchaseLine."Remaining Amount FND";
        PurchaseLineOriginal.VALIDATE("Direct Unit Cost", InterfaceEntryLine."Line Amount");
        if (PurchaseLineOriginal."Additional Description FND" <> '') and (InitialRemAmt = InterfaceEntryLine."Line Amount") then
            PurchaseLineOriginal.VALIDATE("Remaining Amount FND", InitialRemAmt - InterfaceEntryLine."Line Amount");
        PurchaseLineLPO.VALIDATE("Direct Unit Cost", InitialRemAmt - InterfaceEntryLine."Line Amount");
        PurchaseLineOriginal.VALIDATE("Qty. to Receive", 1);
        PurchaseLineLPO.VALIDATE("Initial Amount FND", PurchaseLineLPO."Direct Unit Cost");
        PurchaseLineLPO.VALIDATE("Qty. to Receive", 0);
        PurchaseLineLPO.VALIDATE("Expected Receipt Date", PurchaseLine."Expected Receipt Date"); //HEI.54
        PurchaseLineLPO.VALIDATE("Planned Receipt Date", PurchaseLine."Planned Receipt Date"); //HEI.54
        //HEI.56
        //PurchaseLineLPO."Dimension Set ID" := PurchaseLine."Dimension Set ID";
        PurchaseLineLPO.VALIDATE("Dimension Set ID", PurchaseLine."Dimension Set ID");
        if PurchaseLine."Shortcut Dimension 2 Code" <> '' then
            PurchaseLineLPO.VALIDATE("Shortcut Dimension 2 Code", PurchaseLine."Shortcut Dimension 2 Code");
        //HEI.56
        PurchaseLine.VALIDATE("Remaining Amount FND", PurchaseLineLPO."Direct Unit Cost");
        PurchaseLine.MODIFY();
        PurchaseLineOriginal.MODIFY();
        if PurchaseLine."Remaining Amount FND" > 0 then
            PurchaseLineLPO.INSERT();
        //<< HEI.44
    end;

    local procedure FindLinesUnitCost(InterfaceEntryLine: Record "Interface Entry Line INT"; PurchaseHeader: Record "Purchase Header"; Received: Boolean) TotalUnitCost: Decimal;
    var
        ClosedPurchLines: Record "Purchase Line";
    begin
        //>> HEI.44
        ClosedPurchLines.RESET();
        ClosedPurchLines.SETRANGE("Document No.", PurchaseHeader."No.");
        if Received = true then
            ClosedPurchLines.SETFILTER("Quantity Received", '<>%1', 0);
        ClosedPurchLines.SETRANGE("Additional Description FND", InterfaceEntryLine."External Order Line No.");
        if ClosedPurchLines.findset() then
            repeat
                TotalUnitCost := TotalUnitCost + ClosedPurchLines."Direct Unit Cost";
            until ClosedPurchLines.NEXT() = 0;

        exit(TotalUnitCost);
        //<< HEI.44
    end;

    local procedure CheckAdditionalLines(InterfaceEntryLine: Record "Interface Entry Line INT"; PurchaseHeader: Record "Purchase Header"): Boolean;
    var
        ClosedPurchLines: Record "Purchase Line";
    begin
        //>> HEI.44
        ClosedPurchLines.RESET();
        ClosedPurchLines.SETRANGE("Document No.", PurchaseHeader."No.");
        ClosedPurchLines.SETRANGE("Additional Description FND", InterfaceEntryLine."External Order Line No.");
        if ClosedPurchLines.FINDFIRST() then
            exit(true)
        else
            exit(false);
        //<< HEI.44
    end;
    // BC Upgrade BHARAD11 >>
    local procedure CheckAdditionalLinesUndo(InterfaceEntryLine: Record "Interface Entry Line INT"; PurchaseHeader: Record "Purchase Header"): Boolean;
    var
        ClosedPurchLines: Record "Purchase Line";
    begin
        //>> HEI.44
        ClosedPurchLines.RESET();
        ClosedPurchLines.SETRANGE("Document No.", PurchaseHeader."No.");
        ClosedPurchLines.SETRANGE("Additional Description FND", InterfaceEntryLine."External Order Line No.");
        ClosedPurchLines.SetRange("Quantity Received", 0);
        if ClosedPurchLines.FINDFIRST() then
            exit(true)
        else
            exit(false);
        //<< HEI.44
    end;
    // BC Upgrade BHARAD11 <<

    local procedure UpdateLastOpenLine(InterfaceEntryLine: Record "Interface Entry Line INT"; PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; PreUnitCost: Decimal);
    var
        LastPurchaseLine: Record "Purchase Line";
    begin
        //>> HEI.44
        LastPurchaseLine.RESET();
        LastPurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        LastPurchaseLine.SETRANGE("Quantity Received", 0);
        LastPurchaseLine.SETRANGE("Additional Description FND", InterfaceEntryLine."External Order Line No.");
        if LastPurchaseLine.FINDLAST() then begin
            LastPurchaseLine.VALIDATE("Direct Unit Cost", PurchaseLine."Remaining Amount FND");
            LastPurchaseLine.VALIDATE("Remaining Amount FND", PurchaseLine."Remaining Amount FND");
            LastPurchaseLine.MODIFY();
        end;
        //<< HEI.44
    end;

    local procedure UpdateOriginalLineOnUndo(InterfaceEntryLine: Record "Interface Entry Line INT"; PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; var PurchRcptLine: Record "Purch. Rcpt. Line");
    var
        PurchLine: Record "Purchase Line";
        PurchaseLineToUndo: Record "Purchase Line";
        IncomingLineAmt: Decimal;
        ReleasePurchaseDocumentL: Codeunit "Release Purchase Document";
    begin
        ReleasePurchaseDocumentL.Reopen(PurchaseHeader); // BC Upgrade BHARDA11
        // Message('1');
        //>> HEI.44
        PurchLine.RESET();
        PurchLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchLine.SETRANGE(Amount, ABS(InterfaceEntryLine."Line Amount"));
        PurchLine.SETRANGE("Line No.", PurchRcptLine."Order Line No.");
        if PurchLine.FINDFIRST() then begin
            if PurchLine."SRM Order Line No. FND" <> '' then begin
                PurchLine.VALIDATE("Direct Unit Cost", 0);
                PurchLine."Remaining Amount FND" := PurchLine."Remaining Amount FND" + InterfaceEntryLine."Line Amount"; // Add this line 
                PurchLine.MODIFY();
                PurchaseLineToUndo.RESET();
                PurchaseLineToUndo.SETRANGE("Document No.", PurchaseHeader."No.");
                PurchaseLineToUndo.SETRANGE("Quantity Received", 0);
                PurchaseLineToUndo.SETRANGE("Additional Description FND", InterfaceEntryLine."External Order Line No.");
                if PurchaseLineToUndo.FINDLAST() then begin

                    PurchaseLineToUndo.VALIDATE("Direct Unit Cost", PurchLine."Remaining Amount FND");
                    // Message('2..%1', PurchaseLineToUndo."Direct Unit Cost");
                    PurchaseLineToUndo.MODIFY();
                end;
            end else begin
                IncreaseOriginalLineRemAmt(InterfaceEntryLine, PurchaseHeader);
                UpdateLastOpenLineOnUndo(InterfaceEntryLine, PurchaseHeader);
                PurchaseLineToUndo.RESET();
                PurchaseLineToUndo.SETRANGE("Document No.", PurchaseHeader."No.");
                PurchaseLineToUndo.SETRANGE("Line No.", PurchRcptLine."Order Line No.");
                if PurchaseLineToUndo.FINDFIRST() then begin
                    PurchaseLineToUndo.DELETE();
                    // if not CheckAdditionalLines(InterfaceEntryLine, PurchaseHeader) then // BC Upgrade BHARDA11 ::Blocked
                    if not CheckAdditionalLinesUndo(InterfaceEntryLine, PurchaseHeader) then // BC Upgrade BHARDA11 ::Added
                        CreateAdditionalLine(PurchLine, InterfaceEntryLine);
                end;
            end;
        end;
        //<< HEI.44
        ReleasePurchaseDocumentL.ReleasePurchaseHeader(PurchaseHeader, false); // BC Upgrade BHARDA11
    end;

    local procedure IncreaseOriginalLineRemAmt(InterfaceEntryLine: Record "Interface Entry Line INT"; PurchaseHeader: Record "Purchase Header");
    var
        OriginalPurchLine: Record "Purchase Line";
    begin
        //>> HEI.44
        OriginalPurchLine.SETRANGE("Document No.", PurchaseHeader."No.");
        OriginalPurchLine.SETRANGE("SRM Order Line No. FND", InterfaceEntryLine."External Order Line No.");
        if OriginalPurchLine.FINDFIRST() then begin
            OriginalPurchLine.VALIDATE("Remaining Amount FND", OriginalPurchLine."Remaining Amount FND" + ABS(InterfaceEntryLine."Line Amount"));
            OriginalPurchLine.MODIFY();
        end;
        //<< HEI.44
    end;

    local procedure UpdateLastOpenLineOnUndo(InterfaceEntryLine: Record "Interface Entry Line INT"; PurchaseHeader: Record "Purchase Header");
    var
        LastPurchaseLine: Record "Purchase Line";
    begin
        //>> HEI.44
        LastPurchaseLine.RESET();
        LastPurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        LastPurchaseLine.SETRANGE("Quantity Received", 0);
        LastPurchaseLine.SETRANGE("Additional Description FND", InterfaceEntryLine."External Order Line No.");
        if LastPurchaseLine.FINDLAST() then begin
            LastPurchaseLine.VALIDATE("Direct Unit Cost", LastPurchaseLine."Direct Unit Cost" + ABS(InterfaceEntryLine."Line Amount"));
            LastPurchaseLine.VALIDATE("Remaining Amount FND", LastPurchaseLine."Direct Unit Cost");
            LastPurchaseLine.MODIFY();
        end;
        //<< HEI.44
    end;

    local procedure CreateAdditionalLine(PurchaseLine: Record "Purchase Line"; InterfaceEntryLine: Record "Interface Entry Line INT");
    var
        locPurchaseLine: Record "Purchase Line";
        PurchLine3: Record "Purchase Line"; // BC Upgrade BHARDA11
        NewLineNo: Integer; // BC Upgrade BHARDA11
    begin
        //>> HEI.44
        // BC Upgrade BHARDA11 >> --Code Added for LineNo for GR Creation Case 
        PurchLine3.Reset();
        PurchLine3.SetRange("Document Type", PurchaseLine."Document Type");
        PurchLine3.SetRange("Document No.", PurchaseLine."Document No.");
        PurchLine3.SetRange("No.", PurchaseLine."No.");
        PurchLine3.SetRange("Additional Description FND", InterfaceEntryLine."External Order Line No.");
        if PurchLine3.FindLast() then
            NewLineNo := PurchLine3."Line No." + 1000;
        locPurchaseLine.INIT();
        if NewLineNo = 0 then
            locPurchaseLine."Line No." := PurchaseLine."Line No." + 10000
        else
            locPurchaseLine."Line No." := NewLineNo;
        // BC Upgrade BHARDA11 << --Code Added for LineNo for GR Creation Case 
        locPurchaseLine.VALIDATE("Document Type", PurchaseLine."Document Type");
        locPurchaseLine.VALIDATE("Document No.", PurchaseLine."Document No.");
        locPurchaseLine.VALIDATE(Type, PurchaseLine.Type);
        locPurchaseLine.VALIDATE("No.", PurchaseLine."No.");
        locPurchaseLine.VALIDATE(Description, PurchaseLine.Description);
        locPurchaseLine.VALIDATE("Location Code", InterfaceEntryLine."Location Code");
        locPurchaseLine.VALIDATE(Quantity, 1);
        locPurchaseLine.VALIDATE("Direct Unit Cost", ABS(InterfaceEntryLine."Line Amount"));
        locPurchaseLine.VALIDATE("Remaining Amount FND", ABS(InterfaceEntryLine."Line Amount"));
        locPurchaseLine.VALIDATE("Additional Description FND", InterfaceEntryLine."External Order Line No.");
        locPurchaseLine."Dimension Set ID" := PurchaseLine."Dimension Set ID";
        locPurchaseLine.INSERT();
        //<< HEI.44
    end;

    local procedure CheckIfPurchRcptExist(PurchaseLine: Record "Purchase Line"): Boolean;
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        //>> HEI.51
        PurchRcptLine.SETRANGE("Order No.", PurchaseLine."Document No.");
        PurchRcptLine.SETRANGE("Order Line No.", PurchaseLine."Line No.");
        if PurchRcptLine.FINDFIRST() then
            exit(true)
        else
            exit(false);
        //<< HEI.51
    end;

    procedure ProcessGRValidationRequest(InterfaceEntryHeader: Record "Interface Entry Header INT");
    begin
        //HEI.65>>
        //GR Validation Request
        COMMIT();
        ProcessGRCreation(InterfaceEntryHeader);
        ERROR(SimulateModeErr);
        //HEI.65<<
    end;

    procedure CreateGRValidationResponse(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT"; InterfaceCode: Code[20]; ErrorOccurred: Boolean; ErrorMessage: Text);
    var
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
    begin
        //HEI.66>>
        GetGeneralInterfaceSetup();
        InterfaceSetup.GET(InterfaceCode);
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut."Interface Code" := InterfaceCode;
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeader.Direction::Outbound;
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;  //HEI.70
        InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        if InterfaceEntryHeaderOut."Msg. Sender Business System ID" = '' then
            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."SRM Business System ID";
        InterfaceEntryHeaderOut."Object Type" := 'GR';
        InterfaceEntryHeaderOut."Type ID" := '300';
        //InterfaceEntryHeaderOut."Severity Code" := '1';  //HEI.71
        // BC Upgrade BHARDA11 20April2026 >> // 24April2026 revert to original code
        // if ErrorOccurred and (ErrorMessage = '') then begin
        //     InterfaceEntryHeaderOut."Log Message" := GRValidationSuccessfullyTxt;
        //     InterfaceEntryHeaderOut."Message Type" := 'S';
        //     InterfaceEntryHeaderOut."Severity Code" := '1';  //HEI.71
        // end else
        // if ErrorOccurred and (ErrorMessage <> '') then begin
        if ErrorOccurred then begin  //HEI.71
                                     // BC Upgrade BHARDA11 20April2026 <<
            InterfaceEntryHeaderOut."Log Message" := COPYSTR(ErrorMessage, 1, MAXSTRLEN(InterfaceEntryHeader."Log Message"));  //HEI.71
            InterfaceEntryHeaderOut."Message Type" := 'E';  //HEI.71
            InterfaceEntryHeaderOut."Severity Code" := '3';  //HEI.71
        end else begin   //HEI.71
            InterfaceEntryHeaderOut."Log Message" := GRValidationSuccessfullyTxt;
            InterfaceEntryHeaderOut."Message Type" := 'S';
            InterfaceEntryHeaderOut."Severity Code" := '1';  //HEI.71
        end;  //HEI.71
        InterfaceEntryHeaderOut."Version No." := 'N/A';
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.findset() then
            repeat
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut.TRANSFERFIELDS(InterfaceEntryLine, false);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                InterfaceEntryLineOut."Type ID" := InterfaceEntryHeaderOut."Type ID";
                InterfaceEntryLineOut."Severity Code" := InterfaceEntryHeaderOut."Severity Code";
                InterfaceEntryLineOut."Log Message" := InterfaceEntryHeaderOut."Log Message";
                InterfaceEntryLineOut.INSERT();
            until InterfaceEntryLine.NEXT() = 0;
        //HEI.66<<

        //HEI.67>>
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
        //HEI.67<<
    end;

    procedure CreteOutboundSRMItemGR(PurchRcptHeader: Record "Purch. Rcpt. Header");
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        //HEI.76>>
        GetGeneralInterfaceSetup();
        GetSRMInterfaceSetup();
        if (SRMInterfaceSetup."POSM GR Creation" = '') then
            exit;
        if (PurchRcptHeader."Order No." <> '') then begin
            if PurchaseHeaderAdditional.GET(PurchaseHeaderAdditional."Document Type"::Order, PurchRcptHeader."Order No.") then begin
                if (PurchaseHeaderAdditional."Shopping Card No." = '') then
                    exit;
            end;
        end;

        PurchRcptLine.RESET();
        PurchRcptLine.SETRANGE("Document No.", PurchRcptHeader."No.");
        PurchRcptLine.SETRANGE(Type, PurchRcptLine.Type::Item);
        PurchRcptLine.SETFILTER(Quantity, '<>%1', 0);
        if PurchRcptLine.ISEMPTY then
            exit;

        InterfaceSetup.GET(SRMInterfaceSetup."POSM GR Creation");
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        if InterfaceEntryHeaderOut."Msg. Sender Business System ID" = '' then
            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."SRM Business System ID";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := SRMInterfaceSetup."POSM GR Creation";
        InterfaceEntryHeaderOut."External Document No." := PurchRcptHeader."No.";  //HEI.79
        //HEI.87>>
        InterfaceEntryHeaderOut."External Order No." := PurchRcptHeader."Order No.";
        //InterfaceEntryHeaderOut."Source No." := PurchRcptHeader."Order No.";
        InterfaceEntryHeaderOut."Source No." := PurchRcptHeader."No.";
        //InterfaceEntryHeaderOut."External Contract No." := PurchRcptHeader."No.";
        //HEI.87<<
        InterfaceEntryHeaderOut."Posting Date" := PurchRcptHeader."Posting Date";
        InterfaceEntryHeaderOut."Document Date" := PurchRcptHeader."Document Date";
        InterfaceEntryHeaderOut."Currency Code" := PurchRcptHeader."Currency Code";  //HEI.79
        InterfaceEntryHeaderOut."E-Mail" := PurchRcptHeader."User ID"; //HEI.84
        InterfaceEntryHeaderOut.INSERT(true);

        if PurchRcptLine.findset() then
            repeat
                CreteOutboundLinesSRMItemGR(InterfaceEntryHeaderOut, PurchRcptLine);
            until PurchRcptLine.NEXT() = 0;
        //HEI.76<<
    end;

    local procedure CreteOutboundLinesSRMItemGR(InterfaceEntryHeader: Record "Interface Entry Header INT"; PurchRcptLine: Record "Purch. Rcpt. Line");
    var
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        EntryNo: Integer;
        InterfaceEntryLine: Record "Interface Entry Line INT";
    begin
        //HEI.76>>
        CLEAR(InterfaceEntryLineOut);
        SRMInterfaceSetup.GET(); //HEI.84
        InterfaceEntryLine.RESET();
        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDLAST() then
            EntryNo := InterfaceEntryLine."Entry No." + 1
        else
            EntryNo := 1;
        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeader."Entry No.";
        InterfaceEntryLineOut."Entry No." := EntryNo;
        InterfaceEntryLineOut."Source No." := PurchRcptLine."Document No.";
        InterfaceEntryLineOut."Source Line No." := PurchRcptLine."Line No.";
        //HEI.88>>
        //InterfaceEntryLineOut."External Order No." := InterfaceEntryHeader."Source No.";
        InterfaceEntryLineOut."External Order No." := InterfaceEntryHeader."External Order No.";
        //HEI.88<<
        InterfaceEntryLineOut."External Order Line No." := PurchRcptLine."SRM Order Line No. FND";
        InterfaceEntryLineOut."No." := PurchRcptLine."No.";
        InterfaceEntryLineOut.Quantity := PurchRcptLine.Quantity;
        InterfaceEntryLineOut."Unit of Measure Code" := PurchRcptLine."Unit of Measure Code";
        InterfaceEntryLineOut."Global No." := InterfaceFrameworkMgt.GetUnitOfMeasureISOCode(PurchRcptLine."Unit of Measure Code");  //HEI.79
        InterfaceEntryLineOut."Location Code" := PurchRcptLine."Location Code";
        InterfaceEntryLineOut.Description := PurchRcptLine.Description;
        // InterfaceEntryLineOut."Line Amount" := PurchRcptLine.Amount;  //HEI.79  // BC Upgrade SHUKLP03 >> Blocked because of DrinkIT field Amount.
        InterfaceEntryLineOut."Line Amount" := PurchRcptLine."Amount Heilite FND";  //HEI.79  // BC Upgrade SHUKLP03 >> Blocked because of DrinkIT field Amount.
        InterfaceEntryLineOut."Unit Amount" := PurchRcptLine."Unit Cost";  //HEI.79
        InterfaceEntryLineOut."Currency Code" := InterfaceEntryHeader."Currency Code";  //HEI.81
        InterfaceEntryLineOut."Cross Reference No." := SRMInterfaceSetup."GR Creation Movement Type";  //HEI.84
        InterfaceEntryLineOut.INSERT();
        //HEI.76<<
    end;

    procedure POSMGRConfirmation(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        GRConfirmValidation: Label 'This GR %1 does not belong to Heilite Order No. %2';
    begin
        //HEI.76>>
        //Update Purchase Receipt
        GetGeneralInterfaceSetup();
        GetSRMInterfaceSetup();
        PurchRcptHeader.RESET();
        PurchRcptHeader.SETRANGE("No.", InterfaceEntryHeader."Source No.");
        if PurchRcptHeader.FINDFIRST() then begin
            //HEI.85>>
            if (InterfaceEntryHeader."External Order No." <> PurchRcptHeader."Order No.") then
                ERROR(GRConfirmValidation, PurchRcptHeader."No.", InterfaceEntryHeader."External Order No.");
            if (InterfaceEntryHeader."Action Code" = 'YES') then begin
                //HEI.85<<
                PurchRcptHeader."POSM GR Confirmed FND" := true;
                PurchRcptHeader.MODIFY();
            end;  //HEI.85
        end;
        //HEI.76<<
    end;

    procedure CreateOutboundSRMItemGRCancellation(PurchRcptHeader: Record "Purch. Rcpt. Header"; ReceiptLineNo: Integer);
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        //HEI.89>>
        GetGeneralInterfaceSetup();
        GetSRMInterfaceSetup();
        if (SRMInterfaceSetup."POSM GR Creation" = '') then
            exit;
        if (PurchRcptHeader."Order No." <> '') then begin
            if PurchaseHeaderAdditional.GET(PurchaseHeaderAdditional."Document Type"::Order, PurchRcptHeader."Order No.") then begin
                if (PurchaseHeaderAdditional."Shopping Card No." = '') then
                    exit;
            end;
        end;

        PurchRcptLine.RESET();
        PurchRcptLine.SETRANGE("Document No.", PurchRcptHeader."No.");
        PurchRcptLine.SETRANGE(Type, PurchRcptLine.Type::Item);
        PurchRcptLine.SETRANGE("Line No.", ReceiptLineNo);
        if PurchRcptLine.ISEMPTY then
            exit;

        InterfaceSetup.GET(SRMInterfaceSetup."POSM GR Creation");
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        if InterfaceEntryHeaderOut."Msg. Sender Business System ID" = '' then
            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."SRM Business System ID";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := SRMInterfaceSetup."POSM GR Creation";
        InterfaceEntryHeaderOut."External Document No." := PurchRcptHeader."No.";
        InterfaceEntryHeaderOut."External Order No." := PurchRcptHeader."Order No.";
        InterfaceEntryHeaderOut."Source No." := PurchRcptHeader."No.";
        InterfaceEntryHeaderOut."Posting Date" := PurchRcptHeader."Posting Date";
        InterfaceEntryHeaderOut."Document Date" := PurchRcptHeader."Document Date";
        InterfaceEntryHeaderOut."Currency Code" := PurchRcptHeader."Currency Code";
        InterfaceEntryHeaderOut."E-Mail" := PurchRcptHeader."User ID";
        InterfaceEntryHeaderOut.INSERT(true);

        if PurchRcptLine.findset() then
            CreateOutboundLinesSRMItemGRCancellation(InterfaceEntryHeaderOut, PurchRcptLine); //Single Original Receipt Line
        //HEI.89<<
    end;

    local procedure CreateOutboundLinesSRMItemGRCancellation(InterfaceEntryHeader: Record "Interface Entry Header INT"; PurchRcptLine: Record "Purch. Rcpt. Line");
    var
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        EntryNo: Integer;
        InterfaceEntryLine: Record "Interface Entry Line INT";
    begin
        //HEI.89>>
        CLEAR(InterfaceEntryLineOut);
        SRMInterfaceSetup.GET();
        InterfaceEntryLine.RESET();
        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDLAST() then
            EntryNo := InterfaceEntryLine."Entry No." + 1
        else
            EntryNo := 1;
        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeader."Entry No.";
        InterfaceEntryLineOut."Entry No." := EntryNo;
        InterfaceEntryLineOut."Source No." := PurchRcptLine."Document No.";
        //InterfaceEntryLineOut."Source Line No." := PurchRcptLine."Line No.";
        InterfaceEntryLineOut."External Order No." := InterfaceEntryHeader."External Order No.";
        InterfaceEntryLineOut."External Order Line No." := PurchRcptLine."SRM Order Line No. FND";
        InterfaceEntryLineOut."No." := PurchRcptLine."No.";
        InterfaceEntryLineOut.Quantity := -PurchRcptLine.Quantity;
        InterfaceEntryLineOut."Unit of Measure Code" := PurchRcptLine."Unit of Measure Code";
        InterfaceEntryLineOut."Global No." := InterfaceFrameworkMgt.GetUnitOfMeasureISOCode(PurchRcptLine."Unit of Measure Code");
        InterfaceEntryLineOut."Location Code" := PurchRcptLine."Location Code";
        InterfaceEntryLineOut.Description := PurchRcptLine.Description;
        //InterfaceEntryLineOut."Line Amount" := -PurchRcptLine.Amount;  //BC Upgrade SHUKLP03 << Blocked because of DrinkIT field Amount.
        InterfaceEntryLineOut."Line Amount" := -PurchRcptLine."Amount Heilite FND";  //BC Upgrade SHUKLP03 << Blocked because of DrinkIT field Amount.
        InterfaceEntryLineOut."Unit Amount" := PurchRcptLine."Unit Cost";
        InterfaceEntryLineOut."Currency Code" := InterfaceEntryHeader."Currency Code";
        InterfaceEntryLineOut."Cross Reference No." := SRMInterfaceSetup."GR Cancellation Movement Type";
        InterfaceEntryLineOut.INSERT();
        //HEI.89<<
    end;
}

