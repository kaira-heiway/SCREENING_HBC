codeunit 50015 "Heineken Global"
{
    // version HEI.125

    // 
    // HEI.01 FDD-OTCGAP064 IBM.NAIKH01 10.0.2017 One unit of measure to be defined on the SKU level only
    //   # Created New Function "CheckUOM" to Check if the Item UOM Exist in Item UOM Table.
    // 
    // HEI.02 FDD-OTCGAP029 IBM.ISYED01 11/07/2017
    //   #Created new function StatusOpenOnce to check if any dispute case is open at least once for any customer ledger entry if yes raise exception.
    // 
    // HEI.03 FDD-OTCGAP015a IBM.ISYED01 11/07/2017
    //   #Created new function to block customer based on risk indicator
    // 
    // HEI.04 FDD-HNK-HeiliteBASE-FDD-OTCGAP016b IBM ISYED01 10/07/2017
    //   # added code blocked reason code is selected without a block on the customer, the user will receive an error.
    //   # When a customer is blocked ( so a value in the blocked field is selected) the user cannot close the page until selecting a reason code.
    // 
    // HEI.05 FDD-GAPID003 - One component split into multiple lots IBM.NAIKH01 21/07/2017
    //   # Created a new Function "UpdateConsumptionEntryByLot"
    // 
    // HEI.06 FDD-PTPGAP029 IBM.ISYED01 31/07/2017
    //   # Created a new Function UpdatePaymentProposal with Batch name + Today.
    //   # Added code on funnction "ValidatePaymentProposalLines"
    // 
    // HEI.07 FDD-PTPGAP013 and PTPGAP022 IBM.PATHAA02 03/08/2017
    //   # Added code on funnction "ValidatePaymentProposalLines"
    //   # Removed "OK for payment" code line in function 'ValidatePaymentProposalLines' //29.09.17
    // 
    // HEI.08 FDD PTPGAP026 IBM.NAIKH01 03/08/2017
    //   # Added code on funnction "ValidatePaymentProposalLines"
    // 
    // HEI.09 FDD-PRDGAP044 - Stocks from Heaven (over consumption) IBM.NAIKH01 05/08/2017
    //   # Created a new function "ValidateNegativeConsumptionQty" and added code to handle the Negetive consumption in the Production Journal.
    // 
    // HEI.10 FDD-PTPGAP009 - Esker Migration IBM.CHAUHB01 18/08/2017
    //   # Create new function ApplyDiscountOnPurchDocument
    // 
    // HEI.11 FDD-PTPGAP041 IBM.PATHAA02 20/08/2017
    //   # Created new function-updatevendorledgerentry
    //   # changes made on function -updatevendorledgerentry//29.09.17
    // 
    // HEI.12 FDD-PTPGAP068 IBM COSTES02 21.08.2017
    //   # Create new function SuggestPaymentVendorInsertGenJnlLine,SuggestPaymentVendorCreatePaymentBuffer,AutoArchiveGenJournalLine
    // 
    // HEI.13 FDD-PTPGAP007 IBM PATHAA02 25.08.2017
    //   # Created new function CheckBankDetails
    // 
    // HEI.14 ISSUE ID-294 - IBM.NAIKH01, 28.09.2017
    //   # Created a new function "CheckProdOrdBackwardFlushing" to skip  the Flusing Method BAckward.
    // 
    // HEI.15 FDD-AL-OTCGAP01a IBM HORTOC01 29.09.2017
    //   # New functions
    // 
    // HEI.16 FDD-PTPGAP068 IBM COSTES02 03.10.2017
    //   # Modify function SuggestPaymentVendorInsertGenJnlLine
    // 
    // HEI.17 FDD_PTPGAP007 IBM PATHAA02 04.10.17
    // # New Function UpdatePreferredBankAccountCode
    // # New function updatevendbank 26.10.2017
    // # New function updatVendebankfordel 26.10.17
    // 
    // HEI.18 FDD_KDDOTCGAP003 IBM ISYED01 09.10.17
    //   # Function CheckRPMReturns created
    // 
    // HEI.19 FDD KDDOTCGAP007 IBM.NAIKH01 10.10.17
    //   # Added Code in Function "CheckRPMReturns"
    // 
    // HEI.20 Defect 626 IBM.HORTOC01 18.10.2017
    //   # Code "Changed FND"
    // 
    // HEI.21 Defect 726, Defect 728 IBM NASTAA02 23.10.2017
    //   # Amount should not be a Sum in TempPaymentBuffer2
    // 
    // HEI.22 FDD-PTPGAP067 IBM SOICAD01
    // 
    // HEI.23 FDD PRDGAP36C IBM.ISYED01 11.11.17
    //   # Created new function "ItemLifecyclestatus" and "OnAfterModify_ItemLifecyclestatus"
    // 
    // HEI.24 FDD-RTRGAP060 IBM.HORTOC01 18.12.2017
    //   # function moved from table 50084
    // 
    // HEI.25 Defect#1337 IBM.CHAUHB01 20/12/2017
    //   # New function added "ValidateVendBankAccFields"
    // 
    // HEI.26 FDD_PTPGAP007 LAZARE02 14.02.2018
    //   # Modify vendor only if exists
    // 
    // HEI.27 GAPLOF007 HORTOC01
    //   # new function to print delivery note
    // 
    // HEI.28 FDDPTPGAP080 IBM HORTOC01 19.03.2018
    //   #new function to update VLE
    // HEI.29 PTPGAP085 - IBM HORTOC01 20.03.2018
    //   # new function
    // HEI.30 PTPGAP077 - IBM HORTOC01 23.03.2018
    //   #new function
    // 
    // HEI.31 PRDGAP045 - IBM ISYED01 02.04.2018 - INC2142955
    //   #New function for NegativeConsumptionCatgryCode
    // HEI.33 Defect #1773 IBM HORTOC01 10.05.2018 - new functions
    // HEI.34 FDD PTPGAP078 IBM POSTOI01 26.05.2018
    //   # add code AutoArchiveGenJournalLine to save in Gen. Journal Archive Lines the HNK Check No. for Bank Payment Type = Manual Check
    // HEI.36 Defect #2429 IBM NASTAA02 07.08.2018 # Manual blocking / Unblocking solution not working properly
    //   # New Event Subscriber created to update On Hold, On Hold User ID and On Hold Date when Reason Code is filled-in on a Posted Purchase Invoice
    // 
    // HEI.39 FDD-SLSGAP020 IBM HORTOC01 25.10.2018 # new function
    // HEI.42 FDD-BA-PURGAP03- Bottle Recycling Centre - V2.6 IBM NAIKH01 22.11.2018
    //   # Created a new function "UpdateBRCLocation" and "UpdateBRCLocOnValidateOfVendor" to update the Location code for BRC POs
    // 
    // HEI.43 FDD-PRDGAP061 - Planning nonBOM items v0.2,  IBM.NAIKH01 - 18.12.2018
    //   # Created new function "UpdateBlanketOrderInReqWorksheet" & "UpdateBlanketOrderInReqWorksheet_Modify"
    // 
    // HEI.44 S&OP IBM POSTOI01 21.10.2018
    //   # New subscriber T50001OnAfterModifySendEmailOnError for Future Master
    // HEI.45 FDD-PURGAP030 - Send updated PO to supplier with specified  changes_V1.1, IBM.NAIKH01 , 22.01.2019
    //   # Created new Function "CreatePODocumentLogOnModify_ItemNo", "CreatePODocumentLogOnModify_Qty" ,"CreatePODocumentLogOnModify_UOM"
    //     "CreatePODocumentLogOnModify_ExpectedRecieptDate", "CreatePODocumentLogOnModify_DirectUnitCost","CreatePODocumentLogOnModify_Address",
    //     "InsertPODocumentLog","CreatePODocumentLogOnInsert","CreatePODocumentLogOnDelete",GetMax,"CreatePODocumentLogOnModify_Address2,
    //     "CreatePODocumentLogOnModify_PostCode","CreatePODocumentLogOnModify_City","CreatePODocumentLogOnModify_CountryRegion",
    //     "CreatePODocumentLogOnModify_Contact",CheckNewPurchLine
    // 
    // HEI.46 CHG0270593 - IBM ISYED01 2.15.2019
    //   # When more than one Lot No is found for the same one line/ 1 Prod. Order description “Multiple” should be displayed
    // 
    // HEI.49 FDD_CHG2003754 IBM ISYED01 03.19.2019
    //  #Added New functions for
    //   Added code to get the binCode from BOM component LookupBOMBinCode
    //   Added code to get the ZoneCode from BOM component LookupBomZonCode
    //   Added code to split lins on produciton journal SplitPordOrderItemJNL
    // 
    // HEI.49 CHG0270634 - IBM ISYED01 25.04.2019
    //   # Added new function to Check mandatory dimensions in Purchase  documents
    // HEI.52 FDD-SLSGAP023 IBM BULIMC01 12.06.2019 #Free Reason Codes Dimensions on Promotions
    // HEI.53 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    //   # New Subscriber created after validate No. on Sales Line
    // HEI.56 Defect #4156 IBM NASTAA02 25.07.2019 # Blocking and unblockin manually a Credit note is not working correctly
    // HEI.57 FDD-HT620 IBM BULIMC01 05.08.2019 #new code for Tolerance Limits for Consumption
    //                                           #new function "CheckConsumptionLines" to check partial posting
    // HEI.58 Defect #4195 IBM NASTAA02 30.07.2019 # Wrong number series of the document
    //   # New Subscriber created to update "Posting No. Series" for CTS Documents
    // HEI.59 FDD-HT627 IBM BULIMC01 13.09.2019 #automatically release PO after a Prepayment Invoice is paid
    // HEI.60 FDD-HT658 IBM.GUNERE01 18.09.2019 # OnBeforePostSalesDoc, CheckDistanceOnSalesDocFromDocShippingCosts,
    //                                            OnBeforeReleaseSalesDoc, CheckMandatoryFieldsForRoute,
    //                                            OnBeforeTransferOderPostReceipt, OnBeforeTransferOrderPostShipment,
    //                                            CheckDistanceOnTransferOrderFromDocShippingCosts, CheckMandatoryFieldsForRouteOnTransferOrder funcs. added
    // 
    // 
    // HEI.61 INC2415757 IBM HORTOC01 04.10.2019 #bug fix for customer mendix interface
    // HEI.62 FDD-HT594 IBM NASTAA02 07.10.2019 # La Reunion FA Requirements Vendor
    //   # Code added on function "SuggestPaymentVendorInsertGenJnlLine"
    // HEI.63 Defect CHG2070322/INC2916348 IBM.AK 06.07.20 # "Changed FND" orders of zone code and bin code in SplitPordOrderItemJNL function.
    // HEI.64 FDD-HT658 CHG2024493 IBM.GUNERE01 22.10.2019 # OnBeforeValidateT38VendorNo,OnBeforeValidateT36CustNo funcs. added
    // HEI.65 FDD-HT923 CHG2034529 IBM GUNERE01 30.10.2019 # T23OnBeforeInsertShared,T23OnAfterValidateVendorGlobNoShared funcs. added
    // HEI.66 FDDHT88 IBM BULIMC01 25/10/2019 #code "Changed FND" for RPM Breakages
    // HEI.67 CHG2013123 IBM GAVANM01 01/11/2019 #new function GetStrengthSpecValue
    // HEI.68 FDD-HT923 CHG2034529 IBM GUNERE01 04.11.2019 # T23OnBeforeInsertShared func. modified, T23OnAfterValidateGlobalDeleteShared func. added
    // HEI.69 FDD-HT788 IBM BULIMC01 13.10.2019 #new functions added
    // HEI.70 PRDGAP045 IBM GAVANM01 14/11/2019 #code added
    // HEI.72 FDD-HT657 IBM NASTAA02 16.12.2019 # Ethiopia Intercompany Automation
    //   # Added conditions on function "UpdateBlanketOrderInReqWorksheet"
    // HEI.73 FDD-HT620 CHG2024484 IBM BULIMC01 17.12.2019 #corrections to function "CheckConsumptionLines"
    // HEI.74 CHG2040699 IBM POSTOI01 14.01.2020 Ivory Coast - WHT at the moment of payment
    //   # new function SuggestPaymentVendorInsertGenJnlLineWHT
    // HEI.75 FDD-HT587 IBM BULIMC01 31.01.2020 # New subscriber created
    // HEI.76 Defect 5247 IBM TUDOSG01 02.03.2020
    //   # corrections to function CheckConsumptionLines
    // HEI.77 FDD-HT1346 BULIMC01 IBM 20.05.2020 #new subscribers created:
    //    # "T10866OnAfterInsertPaymentLine" - fill in the MVMT dim and trasaction code when inserting a new line
    //    # "T10865OnAfterInsertPaymentHeader" - fill in the MVMT dim and trasaction code when creating a new payment slip
    //    # "T10866OnAfterValidateAccountNo" - fill in the Account Name
    // HEI.78 CC-CHG2069946 IBM.LS 30.06.2020
    //   # New functions created.
    // HEI.79 FDD-HT1398 CHG2065738 IBM.GUNERE01 21.07.2020 # T23OnBeforeInsertShared,T23OnAfterValidateVendorGlobNoShared,
    //                                                        T23OnAfterValidateGlobalDeleteShared funcs modified,
    //                                                        GetCommonSourceSharingSetup, NoSeriesWebRequest funcs. created
    // HEI.80 FDD-HT1304 IBM NASTAA02 06.07.2020 # IC Transfer Order Automation
    //   # New Subscribers created: "T5740OnafterValidateTransferToCode", "T5740OnBeforeValidateTransferToCode", "T5740OnBeforeValidateTransferToCode" and "T5740OnBeforeValidateInTransitCode"
    // HEI.81 FDD-HT678 IBM NASTAA02 25.08.2020 # DMS / DDE Integration
    //   # New Subscribers created: "OnAfterReleaseSalesDocument" and "OnAfterPostSalesDocument"
    // HEI.82 CHG2076758 IBM.GUNERE01 27.08.2020 # T23OnAfterValidateVendorGlobNoShared,T23OnAfterValidateGlobalDeleteShared funcs. modified
    // HEI.83 CHG2073467 HB1369 IBM GAVANM01 17.08.2020  Enhancements to the Intercompany automation functionality
    //   # new function ICLogEntryOnAfterModify
    // HEI.85 CHG2070663 IBM BULIMC01 30.10.2020 Role Centre Production Bottling Role Centre - code added to the subscriber "T5405OnAfterInsert"
    // HEI.86 CHG2079354 HB1685 IBM GAVANM01 02.11.2020 # EAN13 Barcode
    //   # New functions: EAN13_10String, InitEAN13Structure
    // HEI.87 CC-CHG2083152 IBM.LS 18.11.2020
    //   # Code added and code commented.
    // HEI.88 CC-CHG2078852 IBM.LS 30.11.2020
    //   # Code added.
    // HEI.89 CHG2089956 IBM POENAB02 Issue with "Recipient Bank Account" in Payment Journal Tree
    //  # Modified functions SuggestPaymentVendorInsertGenJnlLineWHT, SuggestPaymentVendorInsertGenJnlLine
    // HEI.90 CC-CHG2078852 IBM.LS 22.12.2020
    //   # Code added.
    // HEI.91 CHG2093562 IBM GAVANM01 25/01/2021 Corrective Change
    //   # function ICLogEntryOnAfterModify is OBSOLETE
    // HEI.92 CHG2096435 HT1805 IBM GAVANM01 12.02.2021 - Invoice Layout
    //   # New Subscriber created: T270OnAfterValidate_BankForInvoiceLayout
    // HEI.93 CHG2095415 IBM BULIMC01 24.03.2021#new function created:"OnAfterModifyT50211"
    // HEI.94 CHG2098327 IBM.LS      29.04.2021
    //   # Added Code
    // HEI.95 CHG2109621 HT2170 IBM GAVANM01 10.06.2021 - Posting Setup for Sales Tax (Timbre), transport, free products
    //   # New Subscribers created: T37OnAfterInsert_Timbre, T37OnAfterDelete_Timbre
    // HEI.96 CHG2119178 IBM.AS 30.06.2021
    //   # HeiLite Base Stability Changes for Posting functions at JOB NAS
    //   # Adding GUIAllowed function added in Functions OnBeforePostPaymentJournalTreeJournal(),
    //     CheckConsumptionLines(),
    //     T5740OnBeforeValidateTransferToCode(),
    //     T5740OnBeforeValidateTransferFromCode(),
    //     T5740OnBeforeValidateInTransitCode(),
    //     UpdateConsumptionEntryByLot(),
    //     InsertRPMCustomerDifferences()
    //   for JOB Execution to avoid any manual intervention
    // HEI.97 CHG2120255 IBM.LS      29.07.2021
    //   # Added Code
    // HEI.98 CHG2129828 DefectID 6507 IBM GAVANM01 10.10.2021 - #Location for Timbre Electronique is not updating with change of location
    //   # New Subscriber created: T37OnAfterValidate_Location_Timbre
    // HEI.99 CHG2134178 INC3809690 IBM GAVANM01 09.11.2021 - #Timbre blocking change of customer in sales order
    //   # new global function: SetAllowTimbreDeletion
    //   # new global var: AllowTimbreDeletion
    //   # code changes in function T37OnBeforeDelete_Timbre
    // HEI.100 HB2487 - CHG2123592 IBM NASTAA02 15.11.2021 # Cash Application where 92% of Customer pay in advance
    //   # New Functions created: 'CheckCustLimitBeforeReleaseSO' and 'CalcAmtWithoutDeposits'
    // HEI.101 CHG2136303 INC3842374 IBM GAVANM01 23.11.2021 - #Incident Timbre Free Goods
    //   # code added in function T37OnAfterValidate_Location_Timbre
    // HEI.102 CHG2132177 BULIMC01 IBM 29/11/2021 # Own Fleet Allocation  - new code added to function "OnAfterModifyT50211"
    // HEI.103 CHG2123219 IBM.BHATTA09 05.01.2022
    //   # Functions added to get SKU CCC Dimension Code in Sales Documents
    // 
    // HEI.104 CHG2143788/INC3938587 IBM SURYAS01
    //   # Fix for "DRC IC Transfer Order Interface Issue"
    // HEI.108 CHG2140693 SAHAL01      30.03.2022
    //   # Added Code to skip the error message based on CMG values which are defined in the Manufacturing Setup
    // HEI.109 CHG2255465 IBM YADAVM09 19/06/2024 # Change required in HeiMatch sign values in COA
    // new subscriber created "T15OnAfterValidateHeiMatchCode"
    // HEI.110 INC4122240 - CHG2159877 IBM NASTAA02 27/05/2022 # Please stop sending C2S allocation for previous periods to archived table
    //   # New Function created 'OnAfterModifyJobQueueEntry' to update the Job Queue User ID based on Category
    // HEI.111 CHG2162842 IBM SAMANR01 21/06/2022 #C2S optimazation
    //   # Add code for "Processed By User ID" bug fix
    // HEI.112 CHG2117381 HB2376 IBM BHANDS01 20.07.2022 # Tolerance Payment Application Panama
    //   # Added permissions read/modify for Cust. Ledger Entry
    //   # New function OnAfterPostSalesDocApplyPmtTol for Payment Tolerance after Sales Invoice Post
    // HEI.113 CHG2172693 IBM SAMANR01 09.09.2022
    //   # Code adjusts for run all category of job queue with super user
    // HEI.114 CHG2117381 HB2376 IBM BHANDS01 21.10.2022 # Tolerance Payment Application Panama
    //   # Code Modified in OnAfterPostSalesDocApplyPmtTol
    //  HEI.115 CHG2178914 HB3228 IBM NANDIS01 04.11.2021 # IBAN validation enhancement in Vendor Bank Account fields
    //   # IBAN should be mandatory only if Country/Regoin allows on "IBAN Country/Region"
    // HEI.116 CHG2178940 IBM COSTES04  16.01.2023 # Add Required Freshness field on Customer Card
    //   # New subscriber T37OnAfterValidate_ShipmentDate, GetFreshnessDate
    // HEI.117 CHG2171687 IBM SISUM01 06/03/2023 #change how to get Ebf Combination. Now the definition in EBF Matrix is with range
    // HEI.105 CHG2119830 IBM BHATTA09 04.02.2022
    //   # Code added in UpdateBlanketOrderInReqWorksheet_Modify to update Requisition Line with respect to Blanket Order
    //   # New subscriber for Requisition Line table T246UpdateOnBlanketOrderNo is created
    // HEI.107 CHG2119830 IBM NANDIS01 16.03.2022 Implement S&OP Core Purchase Requisition Interface
    //   # Location filter should consider BLANK as well to fetch contract in Req worksheet
    //   # Currency code should populate in Req worksheet and diret unit cost also either from Item card or from Contract's price
    //   # Block function - T246UpdateOnBlanketOrderNo
    // HEI.118 CHG2174235 IBM COSTES04 22.03.2023 Interface Order Simulation
    //   # New subscriber CU414OnBeforeReopenSalesDoc
    // HEI.119 CHG2171687 IBM SISUM01 19/05/2023 HB3907 EBF Matrix
    //   # test if New EBF version is enable
    // HEI.120 CHG2119830 IBM NANDIS01 09.06.2023 Implement S&OP Core Purchase Requisition Interface
    //   # vendor Name populated in Req worksheet
    // HEI.121 CHG2212548 IBM BHANDS01 21.07.2023 Mendix Duplicate customer validation enhancement
    //   # Increased the dimension value of local variable distance to 250 in function ComputeLevDistance()
    // HEI.122 CHG2249480 IBM COSTES04 21.06.2024 Burundi-shipment to DDE – sending all distributors related shipments to DDE
    //   # Send DDE Request for all distributors
    // HEI.123 CHG2236702 IBM COSTES04 26.06.2024 Column Data Availability of WH Shipment & WH Receipt No
    //   # check shipment date mandatory
    // HEI.124 CHG2262865 SHARMP16 21.08.2024 Disable Vendor Bank Address Check
    //   # Bypass the validation of Vendor bank account address
    // HEI.125 CHG2260099 COSTES04 18.09.2024 Automatic Archiving of Gate Entry Outbound While Undoing Sales Shipment.
    //   # New event CU5815OnAfterUndoSalesShipmentLine
    // HEI.126 CHG2261624 SAHAL01 11.11.2024 S&OP Fit import purchase requisitions
    //   # Added Code
    // HEI.127 CHG2244491 IBM COSTES02 12.11.2024 Gate Control relation to having Zone and Bin Codes mandator
    //  # New functions: WhseRcptIsTransferImportIdentifier,WhseShpmtIsTransferImportIdentifier

    // BC Upgrade PATELS08 >>
    // # HEI.125 - 'CU5815OnAfterUndoSalesShipmentLine' event subscriber could not be unblocked as 'OnAfterUndoSalesShipmentLine' event does not exists in base codeunit.
    // # Tag HEI.127 was missing in documentation, added it
    // # HEI.127 - Procedure 'WhseShpmtIsTransferImportIdentifier' was there but 'WhseRcptIsTransferImportIdentifier' was missing, added the procedure
    // BC Upgrade PATELS08 <<

    // BC Upgrade MISHRS14 >>
    // Blocked with statement and prefixed variables with GenJournalLine in procedure - SuggestPaymentVendorInsertGenJnlLine.
    // Blocked with statement and prefixed variables with GenJournalLine in procedure - InitGenJnlLine.
    // Blocked with statement and prefixed variables with GenJournalLine in procedure - GetOpenSales.
    // Blocked with statement and prefixed variables with GenJournalLine in procedure - InsertPurchHeaderExtFromPO.
    // Blocked with statement and prefixed variables with GenJournalLine in procedure - FormatAddrLocation.
    // Blocked with statement and prefixed variables with GenJournalLine in procedure - SuggestPaymentVendorInsertGenJnlLineWHT
    // BC Upgrade MISHRS14 <<

    Permissions = TableData "Cust. Ledger Entry" = rm,
                  TableData "Vendor Ledger Entry" = rm,
                  TableData "Sales Shipment Header" = rm,
                  TableData "Sales Invoice Header" = rm,
                  TableData "Sales Cr.Memo Header" = rm,
                  TableData "Purch. Cr. Memo Hdr." = rm;
    SingleInstance = true;

    trigger OnRun();
    begin
    end;

    var
        BlockedReason: Record "Blocked Reason FND";
        //WarehouseTransportMgt : Codeunit "Warehouse & Transport Mgt.";  // BC Upgrade NANDIS03 - DIT Codeunit
        CommonSourceSharingSetup: Record "Common Src Sharing Setup FND";
        Customer1: Record Customer;
        DisputeCase1: Record "Dispute Case FND";
        EbfCombination: Record "Ebf Combination FND";
        GLAccount_G: Record "G/L Account";
        GeneralPostingSetup: Record "General Posting Setup";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        ProdOrderComponent: Record "Prod. Order Component";
        PurchaseDocumentLog: Record "Purchase Document Log FND";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesLine_G: Record "Sales Line";
        StockkeepingUnit: Record "Stockkeeping Unit";
        VendorLedgerEntry_G: Record "Vendor Ledger Entry";
        AllowJNLPosting: Boolean;
        AllowTimbreDeletion: Boolean;
        BlockCustomer: Boolean;
        CheckPCVNBalanceTrue: Boolean;
        CommonSourceSharingSetupGot: Boolean;
        PurchSetupRead: Boolean;
        SalesSetupRead: Boolean;
        //GeneralInterfaceSetup: Record "General Interface Setup";  // BC Upgrade NANDIS03
        //GeneralInterfaceSetupRead: Boolean;  // BC Upgrade NANDIS03
        WhseSetupShortcutUomCode: array[3] of Code[10];
        CCCfromSKU: Code[20];
        UnitOfMeasureCode: Code[20];
        ItemJNLtotalQty: Decimal;
        CountWhseLine: Integer;
        DimValID: Integer;
        NextLineNo: Integer;
        Error001: Label 'Blocked Reason code must have a value in Customer No. %1';
        Error002: Label 'Blocked must not be blank in Customer No. %1';
        Error003: Label 'Return order cannot be posted. The customer is not allowed to return more RPM than what he had ordered';
        Error004: Label 'Sales Order cannot be released. The customer is out of FFE Balance.';
        Error005: Label 'Return RPM order not covering fully customer RPM balance';
        Error006: Label 'Packaging Credit Value Exceeded';
        Error007: Label 'Sales Order Cannot be Released';
        Error008: Label 'This item is blocked for Procurement';
        Error009: Label 'You cannot post production journal with negative consumption for the item category code %1';
        Error010: Label 'For the Line No. %1 must have a valid CCC code to Proceed.';
        Error011: Label 'The interface %1, %2 is Enabled and cannot be modified!';
        Error012: Label 'For the Line No. %4 GLAccount %1 with Dimension code %2 and Dimension Value %3 is Restricted.';
        Error0122: Label 'For the Line No. %4 GLAccount %1 with Dimension code %2 and Dimension Value %3 is Restricted.';
        Text001: Label 'You cannot create more than one unit of measure for item No. %1 , unit of measure "%2" already exists.';
        Text002: Label 'You cannot create more than one unit of measure for item No. %1';
        Text003: Label 'You cannot create more than one open dispute case for a customer ledger entry %1.';
        Text004: Label 'Item Ledger Entries already exists for the Order No. %1 and Item No. %2';
        Text005: Label 'Cust Diff RPM has already created and Posted for the document %1.';
        Text012: Label 'The application was successfully posted.';
        Text013: Label 'The %1 entered must not be before the %1 on the %2.';
        Text019: Label 'Post application process has been canceled.';
        Text020: Label 'Do you want to post the applied entries %1.';
        Text101: Label 'Barcode must be %1 chars length.';
        Text102: Label 'Wrong barcode.';
        Text104: Label 'CheckSum in barcode is wrong.';
        TransferOrderReceivedConfirm: Label 'Transfer Order is linked to an IC Transfer Order. Undo changes?';
        TransferOrderSentConfirm: Label '"Transfer Order has been already sent. Undo changes? "';
        PostedWhseShipmentList: Text;
        Text0021: TextConst ENU = 'There are no lines to move.', FRA = 'Il n''y a pas de ligne à déplacer.';
        ReversalEntryNo: Integer; //BC Upgrade SIVA   

    procedure CheckUOM(ItemNo: Code[20]; BaseUOM: Code[20]; Type: Integer);
    begin
        /*   Commented the code as per the defect List ID #47 & #48
        //<< HEI.01 NAIKH01
        IF Type = 1  THEN BEGIN
          ItemUnitOfMeasure.RESET;
          ItemUnitOfMeasure.SETRANGE(ItemUnitOfMeasure."Item No.",ItemNo);
          IF ItemUnitOfMeasure.FINDFIRST  THEN BEGIN
            UnitOfMeasureCode := ItemUnitOfMeasure.Code;
              IF NOT (BaseUOM = '') THEN BEGIN
                IF NOT (BaseUOM = UnitOfMeasureCode) THEN
                  ERROR(Text001,ItemNo,UnitOfMeasureCode);
              end;
          end;
        end else BEGIN
          ItemUnitOfMeasure.RESET;
          ItemUnitOfMeasure.SETRANGE(ItemUnitOfMeasure."Item No.",ItemNo);
          IF ItemUnitOfMeasure.FINDFIRST  THEN
              ERROR(Text002,ItemNo);
        end;
        //>> HEI.01 NAIKH01
        */

    end;

    procedure StatusOpenOnce(DisputeCase: Record "Dispute Case FND");
    var
        ConfirmValidate: Boolean;
        OpenEntryCount: Integer;
    begin
        //HEI.02>>
        if (DisputeCase.Status = DisputeCase.Status::Open) then begin
            DisputeCase1.RESET();
            DisputeCase1.SETRANGE(DisputeCase1."Cust. Ledger Entry No.", DisputeCase."Cust. Ledger Entry No.");
            DisputeCase1.SETRANGE(DisputeCase1.Status, DisputeCase.Status::Open);
            if DisputeCase1.FINDFIRST() then
                ERROR(Text003, DisputeCase."Cust. Ledger Entry No.");
        end;
        //HEI.02<<
    end;

    [EventSubscriber(ObjectType::Table, 50011, 'OnAfterModifyEvent', '', false, false)]
    procedure StatusOpenOnceOnModify(var Rec: Record "Dispute Case FND"; var xRec: Record "Dispute Case FND"; RunTrigger: Boolean);
    var
        ConfirmValidate: Boolean;
        OpenEntryCount: Integer;
    begin
        //HEI.02>>
        if Rec.Status <> xRec.Status then begin
            if (Rec.Status = Rec.Status::Open) then begin
                DisputeCase1.RESET();
                DisputeCase1.SETRANGE(DisputeCase1."Cust. Ledger Entry No.", Rec."Cust. Ledger Entry No.");
                DisputeCase1.SETRANGE(DisputeCase1.Status, Rec.Status::Open);
                if DisputeCase1.FINDFIRST() then
                    ERROR(Text003, Rec."Cust. Ledger Entry No.");
            end;
        end;
        //HEI.02<<
    end;

    [EventSubscriber(ObjectType::Page, Page::"Customer Card", 'OnQueryClosePageEvent', '', false, false)]
    //procedure "ValidateBlockCustomer&ReasonCode"("No.": Code[20]);  // BC Upgrade NANDIS03
    procedure "ValidateBlockCustomer&ReasonCode"(var Rec: Record Customer; var Allowclose: Boolean);  // BC Upgrade NANDIS03
    begin
        //HEI.04>>
        Customer1.RESET();
        //Customer1.SETRANGE("No.", "No.");  // BC Upgrade NANDIS03
        Customer1.SETRANGE("No.", Rec."No.");  // BC Upgrade NANDIS03
        if Customer1.FINDFIRST() then begin
            if Customer1.Blocked <> Customer1.Blocked::" " then begin
                if Customer1."Blocked Reason Code FND" = '' then
                    ERROR(Error001, Rec."No.");  // BC Upgrade NANDIS03
            end;

            if Customer1."Blocked Reason Code FND" <> '' then begin
                if Customer1.Blocked = Customer1.Blocked::" " then
                    ERROR(Error002, Customer1."No.");
            end;
        end;
        //HEI.04<<
    end;

    // BC Upgrade NANDIS03 - Refacoring the complete below logic of blocking GL Account>>
    // [EventSubscriber(ObjectType::Page, Page::"G/L Account Card", 'OnAfterGetRecordEvent', '', false, false)]
    // //procedure ValidateNBlockGLAccount(GLAccount_L: RecordRef);  // BC Upgrade NANDIS03
    // procedure ValidateNBlockGLAccount(var Rec: Record "G/L Account");  // BC Upgrade NANDIS03
    // begin
    //     GLAccount_G.RESET();
    //     //if GLAccount_G.GET(GLAccount_L) then begin  // BC Upgrade NANDIS03
    //     if GLAccount_G.GET(Rec."No.") then begin  // BC Upgrade NANDIS03
    //         //IF GLAccount_G.FINDFIRST THEN BEGIN
    //         if GLAccount_G.Name = '' then
    //             GLAccount_G.Blocked := true

    //         else if GLAccount_G."Account Category" = GLAccount_G."Account Category"::" " then
    //             GLAccount_G.Blocked := true
    //         /*else IF GLAccount_G."Income/Balance" =  THEN
    //             GLAccount_G.Blocked := TRUE
    //         else IF GLAccount_G."Debit/Credit" = GLAccount_G."Debit/Credit":: THEN
    //             GLAccount_G.Blocked := TRUE*/
    //         else if GLAccount_G."No. 2" = '' then
    //             GLAccount_G.Blocked := true
    //         else if GLAccount_G."Direct Posting" = false then
    //             GLAccount_G.Blocked := true
    //         else if GLAccount_G."Gen. Bus. Posting Group" = '' then
    //             GLAccount_G.Blocked := true
    //         else if GLAccount_G."Gen. Prod. Posting Group" = '' then
    //             GLAccount_G.Blocked := true
    //         else if GLAccount_G."VAT Bus. Posting Group" = '' then
    //             GLAccount_G.Blocked := true
    //         else if GLAccount_G."VAT Prod. Posting Group" = '' then
    //             GLAccount_G.Blocked := true
    //         else if GLAccount_G."Cost Type No." = '' then
    //             GLAccount_G.Blocked := true;

    //         GLAccount_G.MODIFY();
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Table, Database::"G/L Account", OnBeforeModifyEvent, '', false, false)]
    // local procedure EnforceGLAccountBlocking(var Rec: Record "G/L Account"; var xRec: Record "G/L Account"; RunTrigger: Boolean)
    // begin
    //     if (xRec.Blocked = true) and (Rec.Blocked = false) then
    //         exit;
    //     if ShouldAutoBlockGLAccount(Rec) then
    //         Rec.Blocked := true;
    // end;

    // local procedure ShouldAutoBlockGLAccount(GLAcc: Record "G/L Account"): Boolean
    // begin
    //     if GLAcc.Name = '' then
    //         exit(true);

    //     if GLAcc."Account Category" = GLAcc."Account Category"::" " then
    //         exit(true);

    //     if GLAcc."No. 2" = '' then
    //         exit(true);

    //     if not GLAcc."Direct Posting" then
    //         exit(true);

    //     if GLAcc."Gen. Bus. Posting Group" = '' then
    //         exit(true);

    //     if GLAcc."Gen. Prod. Posting Group" = '' then
    //         exit(true);

    //     if GLAcc."VAT Bus. Posting Group" = '' then
    //         exit(true);

    //     if GLAcc."VAT Prod. Posting Group" = '' then
    //         exit(true);

    //     if GLAcc."Cost Type No." = '' then
    //         exit(true);

    //     exit(false);
    // end;
    // BC Upgrade NANDIS03 - Refacoring the complete below logic of blocking GL Account <<
    procedure UpdatePaymentProposal(VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJnlBatchNo: Code[10]);
    var
        foundRec: Boolean;
    begin
        //HEI.06>>
        //IF GenJournalLine.findset THEN BEGIN
        VendorLedgerEntry_G.SETRANGE("Document No.", VendorLedgerEntry."Document No.");
        if VendorLedgerEntry_G.findset() then begin
            repeat
                if VendorLedgerEntry_G.Open then begin
                    VendorLedgerEntry_G."Batch payment name FND" := GenJnlBatchNo + '/' + FORMAT(TODAY);
                    foundRec := true;
                    VendorLedgerEntry_G.MODIFY();
                end;
            until VendorLedgerEntry_G.NEXT() = 0;
        end;
        //HEI.06<<
    end;

    procedure UpdatePaymentProposal4MGenJnlLine(GenJournalLine: Record "Gen. Journal Line");
    var
        foundRec: Boolean;
    begin
        //HEI.06>>
        if GenJournalLine.findset() then
            if GenJournalLine."Applies-to Doc. No." <> '' then
                VendorLedgerEntry_G.SETRANGE("Document No.", GenJournalLine."Applies-to Doc. No.")
            else
                VendorLedgerEntry_G.SETRANGE("Document No.", GenJournalLine."Document No.");
        if VendorLedgerEntry_G.findset() then begin
            repeat
                VendorLedgerEntry_G.VALIDATE("Batch payment name FND", '');
                foundRec := true;
            until VendorLedgerEntry_G.NEXT() = 0;
        end;
        if foundRec then
            VendorLedgerEntry_G.MODIFY();
        //HEI.06<<
    end;

    procedure UpdateConsumptionEntryByLot(ReservationEntry: Record "Reservation Entry");
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ProdOrderComp: Record "Prod. Order Component";
        ProdOrderComponent: Record "Prod. Order Component";
        ProdOrderComponent1: Record "Prod. Order Component";
        ProductionOrder: Record "Production Order";
        ReservEntry: Record "Reservation Entry";
        ReservEntry1: Record "Reservation Entry";
        TempReservationEntry: Record "Reservation Entry" temporary;
        LotNo: Code[20];
        XRecItemNo: Code[20];
        XRecLotNo: Code[20];
        XRecSourceID: Code[20];
        ExpQty: Decimal;
        ProductionOrder_Qty: Decimal;
        Qty_Base: Decimal;
        RemQty: Decimal;
        LastLineNo: Integer;
        ReservEntryCount: Integer;
        ReservEntryCount1: Integer;
        ReservEntryCount2: Integer;
        XRecSourceRefNo: Integer;
        XRecSourceType: Integer;
        Text001: Label 'TOTAL COUNT IS %1 & Lot No. IS %2';
    begin


        //HEI.05>> NAIKH01 FDD PRDGAP003
        ReservEntry.RESET();
        ReservEntry.SETCURRENTKEY("Source ID", "Item No.", "Source Prod. Order Line", "Source Ref. No.", "Source Type", "Source Subtype", "Lot No.");
        ReservEntry.SETRANGE("Source ID", ReservationEntry."Source ID");
        ReservEntry.SETRANGE("Item No.", ReservationEntry."Item No.");
        ReservEntry.SETRANGE("Source Prod. Order Line", ReservationEntry."Source Prod. Order Line");
        ReservEntry.SETRANGE("Source Ref. No.", ReservationEntry."Source Ref. No.");
        ReservEntry.SETRANGE("Source Type", 5407);
        ReservEntry.SETRANGE("Source Subtype", 3);
        ReservEntry.SETFILTER("Lot No.", '<>%1', '');

        LotNo := ''; //Latest Code NAikh01 Issue ID #121
        if ReservEntry.findset() then
            //Check if the ILE already exist for the Item and Prod Order no.
            ItemLedgerEntry.RESET();
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", ReservEntry."Item No.");
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document No.", ReservEntry."Source ID");
        if ItemLedgerEntry.FINDFIRST() then
            //<<HEI.96
            if GUIALLOWED then
                //>>HEI.96
                // ERROR(Text004,ItemLedgerEntry."Document No.",ItemLedgerEntry."Item No.");
                MESSAGE(Text004, ItemLedgerEntry."Document No.", ItemLedgerEntry."Item No.");

        ReservEntryCount1 := ReservEntry.COUNT;
        ReservEntryCount2 := ReservEntry.COUNT;
        repeat

            if LotNo <> ReservEntry."Lot No." then begin      //Latest Code NAIKH01  Issue ID #121
                if ReservEntryCount1 = ReservEntryCount2 then begin
                    ProdOrderComponent.RESET();
                    ProdOrderComponent.SETCURRENTKEY("Prod. Order No.", "Item No.", "Prod. Order Line No.", "Line No.");
                    ProdOrderComponent.SETRANGE("Prod. Order No.", ReservEntry."Source ID");
                    ProdOrderComponent.SETRANGE("Item No.", ReservEntry."Item No.");
                    ProdOrderComponent.SETRANGE("Prod. Order Line No.", ReservEntry."Source Prod. Order Line");
                    ProdOrderComponent.SETRANGE("Line No.", ReservEntry."Source Ref. No.");
                    if ProdOrderComponent.FINDFIRST() then begin
                        //<< ISSUE ID 194
                        ProductionOrder.RESET();
                        ProductionOrder.SETRANGE(ProductionOrder."No.", ProdOrderComponent."Prod. Order No.");
                        if ProductionOrder.FINDFIRST() then
                            ProductionOrder_Qty := ProductionOrder.Quantity;

                        ProdOrderComponent.Quantity := (ABS(ReservEntry.Quantity) / ProductionOrder_Qty);
                        ProdOrderComponent."Quantity per" := (ABS(ReservEntry.Quantity) / ProductionOrder_Qty);
                        ProdOrderComponent."Quantity (Base)" := (ABS(ReservEntry.Quantity) / ProductionOrder_Qty);
                        //>> ISSUE ID 194

                        ProdOrderComponent."Expected Quantity" := ABS(ReservEntry.Quantity);
                        ProdOrderComponent."Remaining Quantity" := ABS(ReservEntry.Quantity);
                        ProdOrderComponent."Remaining Qty. (Base)" := ABS(ReservEntry.Quantity);
                        ProdOrderComponent."Expected Qty. (Base)" := ABS(ReservEntry.Quantity);

                        //>>ISSUE ID 194
                        ProdOrderComponent."Cost Amount" := (ProdOrderComponent."Expected Quantity" * ProdOrderComponent."Unit Cost");
                        ProdOrderComponent."Direct Cost Amount" := (ProdOrderComponent."Expected Quantity" * ProdOrderComponent."Direct Unit Cost");
                        //>>ISSUE ID 194

                        ProdOrderComponent.MODIFY();

                        ReservEntryCount1 := ReservEntryCount1 - 1;
                        LotNo := ReservEntry."Lot No."; //LATEST Code Naikh01 Issue ID #121
                        LastLineNo := ProdOrderComponent."Line No.";  //LATEST Code Naikh01 Issue ID #121
                    end;
                end else begin
                    ProdOrderComponent1.RESET();
                    ProdOrderComponent1.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
                    ProdOrderComponent1.SETRANGE("Prod. Order No.", ReservEntry."Source ID");
                    ProdOrderComponent1.SETRANGE("Prod. Order Line No.", ReservEntry."Source Prod. Order Line");
                    if ProdOrderComponent1.FINDLAST() then begin
                        LastLineNo := ProdOrderComponent1."Line No.";

                        LastLineNo := LastLineNo + 10000;
                    end;

                    ProdOrderComponent.GET(ProdOrderComponent.Status::Released, ReservEntry."Source ID",
                    ReservEntry."Source Prod. Order Line", ReservEntry."Source Ref. No.");

                    //<< ISSUE ID 194
                    ProductionOrder.RESET();
                    ProductionOrder.SETRANGE(ProductionOrder."No.", ProdOrderComponent."Prod. Order No.");
                    if ProductionOrder.FINDFIRST() then
                        ProductionOrder_Qty := ProductionOrder.Quantity;
                    //>>ISSUE ID 194

                    ProdOrderComp.INIT();
                    ProdOrderComp.TRANSFERFIELDS(ProdOrderComponent);
                    ProdOrderComp."Line No." := LastLineNo;
                    ProdOrderComp."Expected Quantity" := ABS(ReservEntry.Quantity);
                    ProdOrderComp."Remaining Quantity" := ABS(ReservEntry.Quantity);
                    ProdOrderComp."Remaining Qty. (Base)" := ABS(ReservEntry.Quantity);
                    ProdOrderComp."Expected Qty. (Base)" := ABS(ReservEntry.Quantity);

                    //<<ISSUE ID 194
                    ProdOrderComp.Quantity := (ABS(ReservEntry.Quantity) / ProductionOrder_Qty);
                    ProdOrderComp."Quantity per" := (ABS(ReservEntry.Quantity) / ProductionOrder_Qty);
                    ProdOrderComp."Quantity (Base)" := (ABS(ReservEntry.Quantity) / ProductionOrder_Qty);

                    ProdOrderComp."Cost Amount" := (ProdOrderComp."Expected Quantity" * ProdOrderComponent."Unit Cost");
                    ProdOrderComp."Direct Cost Amount" := (ProdOrderComp."Expected Quantity" * ProdOrderComponent."Direct Unit Cost");

                    //>> ISSUE ID 194


                    ProdOrderComp.INSERT();

                    LotNo := ReservEntry."Lot No."; //LATEST Code Naikh01 Issue ID #121

                    ReservEntry1.RESET();
                    ReservEntry1.SETCURRENTKEY("Entry No.");
                    ReservEntry1.SETRANGE("Entry No.", ReservEntry."Entry No.");

                    if ReservEntry1.FINDFIRST() then begin
                        ReservEntry1."Source Ref. No." := LastLineNo;
                        ReservEntry1.MODIFY();
                    end;
                end;

            end else begin   //LAttest Code NAIKH01 Issue ID 121
                ProdOrderComponent.RESET();
                ProdOrderComponent.SETCURRENTKEY("Prod. Order No.", "Item No.", "Prod. Order Line No.", "Line No.");
                ProdOrderComponent.SETRANGE("Prod. Order No.", ReservEntry."Source ID");
                ProdOrderComponent.SETRANGE("Item No.", ReservEntry."Item No.");
                ProdOrderComponent.SETRANGE("Prod. Order Line No.", ReservEntry."Source Prod. Order Line");
                ProdOrderComponent.SETRANGE("Line No.", LastLineNo);//ReservEntry."Source Ref. No.");
                                                                    //ProdOrderComponent.SETRANGE("Lot No.",ReservEntry."Lot No.");   //Latest Code Issue 121

                if ProdOrderComponent.FINDFIRST() then begin

                    //<< ISSUE ID 194
                    ProductionOrder.RESET();
                    ProductionOrder.SETRANGE(ProductionOrder."No.", ProdOrderComponent."Prod. Order No.");
                    if ProductionOrder.FINDFIRST() then
                        ProductionOrder_Qty := ProductionOrder.Quantity;
                    //>> ISSUE ID 194


                    // LATEST Code NAIKH01 Added (+) Issue ID #121
                    ProdOrderComponent."Expected Quantity" += ABS(ReservEntry.Quantity);
                    ProdOrderComponent."Remaining Quantity" += ABS(ReservEntry.Quantity);
                    ProdOrderComponent."Remaining Qty. (Base)" += ABS(ReservEntry.Quantity);
                    ProdOrderComponent."Expected Qty. (Base)" += ABS(ReservEntry.Quantity);

                    //<< ISSUE ID 194
                    ProdOrderComponent.Quantity := ((ProdOrderComponent."Expected Quantity") / ProductionOrder_Qty);
                    ProdOrderComponent."Quantity per" := ((ProdOrderComponent."Expected Quantity") / ProductionOrder_Qty);
                    ProdOrderComponent."Quantity (Base)" := ((ProdOrderComponent."Expected Quantity") / ProductionOrder_Qty);

                    ProdOrderComponent."Cost Amount" := (ProdOrderComponent."Expected Quantity" * ProdOrderComponent."Unit Cost");
                    ProdOrderComponent."Direct Cost Amount" := (ProdOrderComponent."Expected Quantity" * ProdOrderComponent."Direct Unit Cost");
                    //>> ISSUE ID 194

                    ProdOrderComponent.MODIFY();

                    //ReservEntryCount1 := ReservEntryCount1-1;
                    LotNo := ReservEntry."Lot No."; //LATEST Code Naikh01 Issue ID #121
                end;


                ReservEntry1.RESET();
                ReservEntry1.SETCURRENTKEY("Entry No.");
                ReservEntry1.SETRANGE("Entry No.", ReservEntry."Entry No.");

                if ReservEntry1.FINDFIRST() then begin
                    ReservEntry1."Source Ref. No." := LastLineNo;
                    ReservEntry1.MODIFY();
                end;


            end;  //LATEST Code NAIKH01 Issue ID #121
        until ReservEntry.NEXT() = 0;
        // HEI.05 NAIKH01
    end;

    procedure ValidatePaymentProposalLines(VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line") Return: Boolean;
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        paymentmethod: Record "Payment Method";
        PurchInvHeader: Record "Purch. Inv. Header";
        vend: Record Vendor;
        CheckReturnValue: Integer;
        CheckConstant: Label 'INCLUDED IN PAYMENT PROPOSAL';
    begin
        //HEI.06>>
        Return := false;
        CheckReturnValue := 0;

        if VendorLedgerEntry."Batch payment name FND" = '' then
            CheckReturnValue := 1;
        //HEI.06<<

        //HEI.07>>  FDD-PTPGAP013 & PTPGAP041 IBM.PATHAA02
        //SOICAD01 begin delete
        /*
        IF PurchInvHeader.GET(VendorLedgerEntry."Document No.") THEN
          IF (PurchInvHeader."Payment Status" = PurchInvHeader."Payment Status"::"Payment Approved") THEN
              CheckReturnValue += 1 ;*/
        //end delete
        //soicad>>
        if VendorLedgerEntry."Payment Status FND" = VendorLedgerEntry."Payment Status FND"::"Payment Approved" then
            CheckReturnValue += 1;
        //soicad<<
        //HEI.07<<


        //HEI.08 IBM.NAIKH01
        GenJournalBatch.GET(GenJournalLine."Journal Template Name", GenJournalLine."Journal Batch Name");
        if (VendorLedgerEntry."Payment Method Code" = GenJournalBatch."Payment Method Code FND") then
            CheckReturnValue += 1;
        //>>

        if CheckReturnValue = 3 then
            Return := true
        else
            Return := false;

        //>>

    end;

    // procedure ValidateNegativeConsumptionQty(ItemJournallLine : Record "Item Journal Line");
    // var
    //     ItemJrlLine : Record "Item Journal Line";
    //     Qty : Decimal;
    //     ILE : Record "Item Ledger Entry";
    //     Error001 : Label 'Negative consumption is more than posted consumption(s) value in the Item Ledger Entries of item %1, Lot Number %2 on production order %3';
    //     LotNo1 : Code[20];
    //     QualityManagement : Codeunit "Quality Management";
    //     ReservEntry : Record "Reservation Entry";
    //     TempReserveEntryLotNo : Code[20];
    //     TempReserveEntryQty : Decimal;
    //     Cnt : Integer;
    //     ReservEntry1 : Record "Reservation Entry";
    //     Error002 : Label 'You cannot post a correction on Lot No. %1 as the consumption is posted for a different Lot No.';
    // begin
    //     //>> HEI.09
    //     ItemJrlLine.RESET;
    //     ItemJrlLine.SETCURRENTKEY("Entry Type","Document No.","Posting Date");
    //     ItemJrlLine.SETRANGE(ItemJrlLine."Entry Type",ItemJournallLine."Entry Type"::Consumption);
    //     ItemJrlLine.SETRANGE(ItemJrlLine."Document No.",ItemJournallLine."Document No.");
    //     ItemJrlLine.SETRANGE(ItemJrlLine."Posting Date",ItemJournallLine."Posting Date");

    //     if ItemJrlLine.findset then
    //       repeat
    //         LotNo1 := QualityManagement.GetItemJnlLineLotNo(ItemJrlLine);
    //         if (ItemJrlLine.Quantity < 0) then begin
    //           if (LotNo1 = 'MULTIPLE') then begin
    //               ReservEntry.RESET;
    //               ReservEntry.SETCURRENTKEY("Source ID","Source Ref. No.","Item No.","Source Batch Name","Creation Date","Location Code","Source Type","Source Subtype","Lot No.");
    //               ReservEntry.SETRANGE("Source ID",ItemJrlLine."Journal Template Name");
    //               ReservEntry.SETRANGE("Source Ref. No.", ItemJrlLine."Line No.");
    //               ReservEntry.SETRANGE("Item No.", ItemJrlLine."Item No.");
    //               ReservEntry.SETRANGE("Source Batch Name",ItemJrlLine."Journal Batch Name");
    //               ReservEntry.SETRANGE("Creation Date", ItemJrlLine."Posting Date");
    //               ReservEntry.SETRANGE("Location Code",ItemJrlLine."Location Code");
    //               ReservEntry.SETRANGE("Source Type",83);
    //               ReservEntry.SETRANGE("Source Subtype",5);
    //               ReservEntry.SETFILTER("Lot No.",'<>%1','');
    //               if ReservEntry.findset then
    //                 repeat
    //                   TempReserveEntryLotNo := '';
    //                   TempReserveEntryQty := 0;

    //                   ReservEntry1.RESET;
    //                   ReservEntry1.SETCURRENTKEY("Source ID","Source Ref. No.","Item No.","Source Batch Name","Creation Date","Location Code","Source Type","Source Subtype","Lot No.");
    //                   ReservEntry1.SETRANGE("Source ID",ReservEntry."Source ID");
    //                   ReservEntry1.SETRANGE("Source Ref. No.", ReservEntry."Source Ref. No.");
    //                   ReservEntry1.SETRANGE("Item No.", ReservEntry."Item No.");
    //                   ReservEntry1.SETRANGE("Source Batch Name",ReservEntry."Source Batch Name");
    //                   ReservEntry1.SETRANGE("Creation Date", ReservEntry."Creation Date");
    //                   ReservEntry1.SETRANGE("Location Code",ReservEntry."Location Code");
    //                   ReservEntry1.SETRANGE("Source Type",83);
    //                   ReservEntry1.SETRANGE("Source Subtype",5);
    //                   ReservEntry1.SETRANGE("Lot No.",ReservEntry."Lot No.");
    //                   if ReservEntry1.findset then
    //                     begin
    //                     repeat
    //                       TempReserveEntryLotNo := ReservEntry."Lot No.";
    //                       TempReserveEntryQty += ReservEntry."Quantity (Base)";
    //                     until ReservEntry1.NEXT = 0;

    //                       Qty :=0;
    //                       ILE.RESET;
    //                       ILE.SETCURRENTKEY("Entry Type","Document No.","Item No.","Lot No.","Location Code");
    //                       ILE.SETRANGE(ILE."Entry Type", ItemJrlLine."Entry Type"::Consumption);
    //                       ILE.SETRANGE(ILE."Document No.",ItemJrlLine."Document No.");
    //                       ILE.SETRANGE(ILE."Item No.",ItemJrlLine."Item No.");
    //                       ILE.SETRANGE(ILE."Lot No.",TempReserveEntryLotNo);
    //                       ILE.SETRANGE(ILE."Location Code",ItemJrlLine."Location Code");
    //                       if ILE.findset then
    //                        repeat
    //                         Qty += ILE.Quantity;
    //                        until ILE.NEXT= 0;
    //                         //IF (ABS(ItemJrlLine.Quantity) > ABS(TempReserveEntryQty)) THEN
    //                         if (ABS(TempReserveEntryQty) > ABS(Qty)) then
    //                           ERROR(Error001,ILE."Item No.",ILE."Lot No.",ILE."Document No.");
    //                      end;
    //                   until ReservEntry.NEXT =0;

    //           end else
    //           begin
    //             Qty :=0;

    //             //1. IF the item @ ILE Exists and item same lot number found in ILE should be allowed to post.
    //             //2. IF the item with different lot number found in ILE should'nt allowed to post.
    //             //3. IF the item not found in the ILE shoudl be allowed to post.

    //             ILE.RESET;
    //             ILE.SETCURRENTKEY("Entry Type","Document No.","Item No.","Lot No.","Location Code");
    //             ILE.SETRANGE(ILE."Entry Type", ItemJrlLine."Entry Type"::Consumption);
    //             ILE.SETRANGE(ILE."Document No.",ItemJrlLine."Document No.");
    //             ILE.SETRANGE(ILE."Item No.",ItemJrlLine."Item No.");
    //             // Issue 720 fix isyed01 IBM>>
    //             //ILE.SETRANGE(ILE."Lot No.",LotNo1);
    //             // Issue 720 fix isyed01 IBM<<
    //             ILE.SETRANGE(ILE."Location Code",ItemJrlLine."Location Code");
    //             if ILE.findset then
    //             begin
    //             repeat
    //               Qty += ILE.Quantity;
    //             until ILE.NEXT= 0;
    //             if (ABS(ItemJrlLine.Quantity) > ABS(Qty)) then
    //                 ERROR(Error001,ILE."Item No.",ILE."Lot No.",ILE."Document No.");
    //             // Issue 720 fix isyed01 IBM>> //2. code below will take care of Senaroi 1,2.
    //              if LotNo1 <> ILE."Lot No." then
    //               ERROR(Error002,LotNo1);
    //             // Issue 720 fix isyed01 IBM<<

    //             end; //else  //Latest Code Added #113
    //             //out side of this condition code will take care of Senaroi 3.

    //              //Isyed01 #627>> - Commented by syed Since if there is no consumption available in ILE there user should be able to post the Prod Jounral.
    //              //>>Latest Code Added #113
    //              /*BEGIN
    //                ERROR(Error002,LotNo1);
    //                end;*/
    //              //<<Latest Code Added #113
    //            end;
    //           end;
    //         until ItemJrlLine.NEXT = 0;
    //     //<< HEI.09

    // end;  // BC Upgrade NANDIS03

    procedure ApplyDiscountOnPurchDocument(var PurchHdr: Record "Purchase Header"; TotalDiscAmount: Decimal);
    var
        PurchLine: Record "Purchase Line";
        DiscPerc: Decimal;
        DocAmount: Decimal;
        LineAppliedDiscount: Decimal;
        RemainingDiscount: Decimal;
        TotalAppliedDiscount: Decimal;
        TotalLinesAmt: Decimal;
        AmountFromLines: Integer;
    begin
        // << HEI.10
        if TotalDiscAmount = 0 then
            exit;
        CLEAR(PurchLine);
        PurchLine.SETRANGE("Document Type", PurchHdr."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHdr."No.");
        //PurchLine.SETRANGE("Free Item",false);  // BC Upgrade NANDIS03
        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
        if PurchLine.findset() then
            repeat
                TotalLinesAmt += PurchLine."Line Amount";
            until PurchLine.NEXT() = 0;

        CLEAR(PurchLine);
        PurchLine.SETRANGE("Document Type", PurchHdr."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHdr."No.");
        //PurchLine.SETRANGE("Free Item",false);  // BC Upgrade NANDIS03
        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
        if PurchLine.findset() then
            repeat
                LineAppliedDiscount := ROUND(TotalDiscAmount * PurchLine."Line Amount" / TotalLinesAmt, 0.01);
                PurchLine.VALIDATE("Inv. Discount Amount", LineAppliedDiscount);
                PurchLine.MODIFY(true);
            until PurchLine.NEXT() = 0;
    end;

    procedure UpdateVendorLedgerEntry(var purchinvheader: Record "Purch. Inv. Header");
    var
        vendledgerentry: Record "Vendor Ledger Entry";
    begin
        //>> HEI.11 PATHAA02 IBM PATHAA02 PTPGAP041
        vendledgerentry.RESET();
        vendledgerentry.SETRANGE("Document No.", purchinvheader."No.");
        vendledgerentry.SETRANGE("Posting Date", purchinvheader."Posting Date");
        if vendledgerentry.FINDFIRST() then begin
            vendledgerentry."Payment Status FND" := purchinvheader."Payment Status FND";
            vendledgerentry."Reason Code" := purchinvheader."Reason Code";
            vendledgerentry."Status Date FND" := purchinvheader."Status Date FND";
            vendledgerentry."Payment User FND" := purchinvheader."Payment User FND";
            vendledgerentry.MODIFY();
        end;
        //<< HEI.11 PATHAA02 IBM PATHAA02 PTPGAP041
    end;

    //procedure SuggestPaymentVendorInsertGenJnlLine(var TempPaymentBuffer : Record "Payment Buffer" temporary;var TempPaymentBuffer2 : Record "Payment Buffer" temporary;var LastLineNo : Integer;JournalTemplate : Code[10];JournalBatch : Code[10];ArchiveDocumentNo : Code[20]);  // Blocked as "Payment Buffer" is obsolete  - BC Upgrade NANDIS03
    procedure SuggestPaymentVendorInsertGenJnlLine(var TempPaymentBuffer: Record "Vendor Payment Buffer" temporary; var TempPaymentBuffer2: Record "Vendor Payment Buffer" temporary; var LastLineNo: Integer; JournalTemplate: Code[10]; JournalBatch: Code[10]; ArchiveDocumentNo: Code[20]);  // Used "Vendor Payment Buffer" as "Payment Buffer" is obsolete  - BC Upgrade NANDIS03
    var
        GenJournalLine: Record "Gen. Journal Line";
        lGenJournalLine: Record "Gen. Journal Line";
        lPurchInvHeader: Record "Purch. Inv. Header";
        WHTEntry: Record "WHT Entry FND";
        ParentLineNo: Integer;
        PaymentOfTxt: Label 'Payment of %1 %2';
    begin
        //HEI.12>>
        ParentLineNo := LastLineNo;

        TempPaymentBuffer.SETRANGE("Vendor No.", TempPaymentBuffer2."Vendor No.");
        TempPaymentBuffer.SETRANGE("Currency Code", TempPaymentBuffer2."Currency Code");
        TempPaymentBuffer.SETRANGE("Dimension Entry No.", TempPaymentBuffer2."Dimension Entry No.");
        TempPaymentBuffer.SETRANGE("Vendor Bank Account FND", TempPaymentBuffer2."Vendor Bank Account FND");
        if TempPaymentBuffer.findset() then
            repeat

                // BC Upgrade MISHRS14 >>
                // Blocked with statement and prefixed variables with GenJournalLine.
                //with GenJournalLine do begin
                GenJournalLine.INIT();
                LastLineNo := LastLineNo + 10000;
                GenJournalLine."Journal Batch Name" := JournalBatch;
                GenJournalLine."Journal Template Name" := JournalTemplate;
                GenJournalLine."Line No." := LastLineNo;
                GenJournalLine."Document Type" := GenJournalLine."Document Type"::Payment;
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                GenJournalLine.SetHideValidation(true);
                GenJournalLine.VALIDATE("Account No.", TempPaymentBuffer."Vendor No.");
                GenJournalLine.VALIDATE("Currency Code", TempPaymentBuffer."Currency Code");
                GenJournalLine.Description :=
                  STRSUBSTNO(
                    PaymentOfTxt,
                    TempPaymentBuffer."Vendor Ledg. Entry Doc. Type",
                    TempPaymentBuffer."Vendor Ledg. Entry Doc. No.");
                GenJournalLine."Source Line No." := TempPaymentBuffer."Vendor Ledg. Entry No.";
                GenJournalLine."Shortcut Dimension 1 Code" := TempPaymentBuffer."Global Dimension 1 Code";
                GenJournalLine."Shortcut Dimension 2 Code" := TempPaymentBuffer."Global Dimension 2 Code";
                GenJournalLine."Dimension Set ID" := TempPaymentBuffer."Dimension Set ID";
                //HEI.16>>
                //VALIDATE(Amount,TempPaymentBuffer.Amount);
                GenJournalLine.Amount := TempPaymentBuffer.Amount;
                //HEI.16<<
                GenJournalLine."Applies-to Doc. Type" := TempPaymentBuffer."Vendor Ledg. Entry Doc. Type";
                GenJournalLine."Applies-to Doc. No." := TempPaymentBuffer."Vendor Ledg. Entry Doc. No.";
                GenJournalLine."Payment Method Code" := TempPaymentBuffer."Payment Method Code";
                GenJournalLine."Creditor No." := TempPaymentBuffer."Creditor No.";
                GenJournalLine."Payment Reference" := TempPaymentBuffer."Payment Reference";
                GenJournalLine."Exported to Payment File" := TempPaymentBuffer."Exported to Payment File";
                GenJournalLine."Applies-to Ext. Doc. No." := TempPaymentBuffer."Applies-to Ext. Doc. No.";
                // "Contract Type" := TempPaymentBuffer."Contract Type";  // BC Upgrade NANDIS03 - Blocked as DIT field
                // "Service Contract Line No." := TempPaymentBuffer."Service Contract Line No.";  // BC Upgrade NANDIS03 - Blocked as DIT field
                // "DIT Sub-Contract Type" := TempPaymentBuffer."DIT Sub-Contract Type";  // BC Upgrade NANDIS03 - Blocked as DIT field
                // "Service Contract No." := TempPaymentBuffer."Service Contract No.";  // BC Upgrade NANDIS03 - Blocked as DIT field
                // "Building No." := TempPaymentBuffer."Building No.";  // BC Upgrade NANDIS03 - Blocked as DIT field
                // "Contract Group Code" := TempPaymentBuffer."Contract Group Code";  // BC Upgrade NANDIS03 - Blocked as DIT field
                // "Posting Group" := TempPaymentBuffer."Posting Group";  // BC Upgrade NANDIS03 - Blocked as DIT field
                GenJournalLine."Vendor Bank Account FND" := TempPaymentBuffer."Vendor Bank Account FND";
                GenJournalLine."Dimension Set ID" := TempPaymentBuffer."Dimension Set ID";
                GenJournalLine."Fixed Asset Acquisition FND" := TempPaymentBuffer."Fixed Asset Acquisition FND"; //HEI.62
                GenJournalLine."Parent Line No. FND" := ParentLineNo;
                GenJournalLine."Tree Level FND" := 1;
                GenJournalLine."Archive Document No. FND" := ArchiveDocumentNo;
                //HEI.89>>
                lGenJournalLine.RESET();
                if lGenJournalLine.GET(GenJournalLine."Journal Template Name", GenJournalLine."Journal Batch Name", GenJournalLine."Parent Line No. FND") then begin
                    if lGenJournalLine."Recipient Bank Account" <> '' then
                        GenJournalLine."Recipient Bank Account" := lGenJournalLine."Recipient Bank Account";
                    if lGenJournalLine."Recipient Bank Account" = '' then
                        if GenJournalLine."Applies-to Doc. Type" = GenJournalLine."Applies-to Doc. Type"::Invoice then
                            if lPurchInvHeader.GET(GenJournalLine."Applies-to Doc. No.") then
                                GenJournalLine."Recipient Bank Account" := lPurchInvHeader."Vendor Bank Account FND";
                end;
                //HEI.89<<
                GenJournalLine.INSERT();
            //end;
            // BC Upgrade MISHRS14<<

            until TempPaymentBuffer.NEXT() = 0;
        //HEI.12<<
    end;

    //procedure SuggestPaymentVendorCreatePaymentBuffer(TempPaymentBuffer : Record "Payment Buffer" temporary;var TempPaymentBuffer2 : Record "Payment Buffer" temporary;VendorLedgerEntry : Record "Vendor Ledger Entry";Amount : Decimal);  // Blocked as "Payment Buffer" is obsolete  - BC Upgrade NANDIS03
    procedure SuggestPaymentVendorCreatePaymentBuffer(TempPaymentBuffer: Record "Vendor Payment Buffer" temporary; var TempPaymentBuffer2: Record "Vendor Payment Buffer" temporary; VendorLedgerEntry: Record "Vendor Ledger Entry"; Amount: Decimal);  // Blocked as "Payment Buffer" is obsolete  - BC Upgrade NANDIS03
    var
        GenJournalLine: Record "Gen. Journal Line";
        ParentLineNo: Integer;
        PaymentOfTxt: Label 'Payment of %1 %2';
    begin
        //HEI.12>>
        TempPaymentBuffer2.INIT();
        TempPaymentBuffer2.TRANSFERFIELDS(TempPaymentBuffer);
        TempPaymentBuffer2."Vendor Ledg. Entry Doc. Type" := VendorLedgerEntry."Document Type";
        TempPaymentBuffer2."Vendor Ledg. Entry Doc. No." := VendorLedgerEntry."Document No.";
        TempPaymentBuffer2."Global Dimension 1 Code" := VendorLedgerEntry."Global Dimension 1 Code";
        TempPaymentBuffer2."Global Dimension 2 Code" := VendorLedgerEntry."Global Dimension 2 Code";
        TempPaymentBuffer2."Dimension Set ID" := VendorLedgerEntry."Dimension Set ID";
        TempPaymentBuffer2."Vendor Ledg. Entry No." := VendorLedgerEntry."Entry No.";
        //HEI.20>>
        //HEI.21>>
        //TempPaymentBuffer2.Amount += Amount;
        TempPaymentBuffer2.Amount := Amount;
        //HEI.21<<
        if not TempPaymentBuffer2.INSERT() then
            TempPaymentBuffer2.MODIFY();
        //HEI.20<<
        //HEI.12<<


        //HEI.11 PATHAA02 IBM PATHAA02 PTPGAP041>>
    end;

    procedure AutoArchiveGenJournalLine(var GenJournalLine: Record "Gen. Journal Line");
    var
        BankAccount: Record "Bank Account";
        GenJournalLine2: Record "Gen. Journal Line";
        GenJournalLineArchive: Record "Gen. Journal Line Archive FND";
        PaymentMethod: Record "Payment Method";
        LastCheckNo: Code[20];
        VersionNo: Integer;
    begin
        //HEI.12>>
        GenJournalLine2.COPYFILTERS(GenJournalLine);

        GenJournalLineArchive.LOCKTABLE();
        GenJournalLineArchive.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
        GenJournalLineArchive.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
        GenJournalLineArchive.SETRANGE("Archive Document No.", GenJournalLine."Archive Document No. FND");
        if GenJournalLineArchive.FINDLAST() then
            VersionNo := GenJournalLineArchive."Version No." + 1
        else
            VersionNo := 1;

        if GenJournalLine2.findset() then
            repeat
                GenJournalLineArchive.INIT();
                GenJournalLineArchive.TRANSFERFIELDS(GenJournalLine2);
                GenJournalLineArchive."Archived By" := USERID;
                GenJournalLineArchive."Date Archived" := WORKDATE();
                GenJournalLineArchive."Time Archived" := TIME;
                GenJournalLineArchive."Version No." := VersionNo;
                //HEI.34>>
                if PaymentMethod.GET(GenJournalLineArchive."Payment Method Code") then;

                //for Computer Check
                if (GenJournalLineArchive."Bank Payment Type" = GenJournalLineArchive."Bank Payment Type"::"Computer Check") and (PaymentMethod."Cheque FND") and (GenJournalLineArchive."Tree Level" = 0) then begin
                    GenJournalLineArchive.TESTFIELD("HNK Bank Account");
                    GenJournalLineArchive.TESTFIELD("HNK Check No.");
                    GenJournalLineArchive.TESTFIELD("Check Printed", true);
                end;

                //for Manual Check
                if (GenJournalLineArchive."Bank Payment Type" = GenJournalLineArchive."Bank Payment Type"::"Manual Check") and
                   (GenJournalLineArchive."HNK Bank Account" <> '') and (PaymentMethod."Cheque FND") and (GenJournalLineArchive."Tree Level" = 0) and
                   (GenJournalLine2."HNK Check No. FND" = '') then begin
                    if BankAccount.GET(GenJournalLineArchive."HNK Bank Account") then begin
                        LastCheckNo := BankAccount."Last Check No.";

                        if LastCheckNo <> '' then
                            LastCheckNo := INCSTR(LastCheckNo)
                        else
                            LastCheckNo := '1';

                        GenJournalLineArchive."HNK Check No." := LastCheckNo;
                        BankAccount."Last Check No." := LastCheckNo;
                        BankAccount.MODIFY();
                        GenJournalLine2."HNK Check No. FND" := LastCheckNo;
                        GenJournalLine2.MODIFY();
                    end;
                end;
                //HEI.34<<
                GenJournalLineArchive.INSERT();
            until GenJournalLine2.NEXT() = 0;
        //HEI.12<<
    end;

    procedure OnAfterDeleteGenJournalLine(var GenJournalLine: Record "Gen. Journal Line");
    var
        GenJournalLine2: Record "Gen. Journal Line";
        GenJournalLine3: Record "Gen. Journal Line";
    begin
        //HEI.12>>
        GenJournalLine2.COPYFILTERS(GenJournalLine);
        GenJournalLine2.SETFILTER("Line No.", '>%1', 0);
        GenJournalLine2.SETFILTER("Tree Level FND", '%1', 0);
        if GenJournalLine2.findset() then
            repeat
                GenJournalLine3.SETRANGE("Journal Batch Name", GenJournalLine2."Journal Batch Name");
                GenJournalLine3.SETRANGE("Journal Template Name", GenJournalLine2."Journal Template Name");
                GenJournalLine3.SETRANGE("Parent Line No. FND", GenJournalLine2."Line No.");
                GenJournalLine3.DELETEALL();
            until GenJournalLine2.NEXT() = 0;
        //HEI.12<<
    end;

    procedure DeleteReservationEntryRec(ProdOrderComponent: Record "Prod. Order Component");
    var
        ReservEntry: Record "Reservation Entry";
    begin
        //NAIKH01
        ReservEntry.RESET();
        ReservEntry.SETRANGE("Source ID", ProdOrderComponent."Prod. Order No.");
        ReservEntry.SETRANGE("Item No.", ProdOrderComponent."Item No.");
        ReservEntry.SETRANGE("Source Type", 5407);
        ReservEntry.SETRANGE("Source Subtype", 3);
        ReservEntry.SETRANGE("Source Ref. No.", ProdOrderComponent."Prod. Order Line No.");
        ReservEntry.SETRANGE("Source Prod. Order Line", ProdOrderComponent."Line No.");
        if ReservEntry.findset() then begin
            repeat
                ReservEntry.DELETE();

            until ReservEntry.NEXT() = 0;
        end;
    end;

    procedure CheckBankDetails(VendNo: Code[20]; "code": Code[20]): Boolean;
    var
        VendorBankAccount: Record "Vendor Bank Account";
        Pass: Boolean;
    begin

        //HEI.13 FDD-PTPGAP007 IBM PATHAA02 25.08.2017>>

        if VendorBankAccount.GET(VendNo, code) then begin
            Pass := true;
            if ((VendorBankAccount.Name = '') or
            (VendorBankAccount.Address = '') or
            (VendorBankAccount."Country/Region Code" = '') or
             (VendorBankAccount."Bank Branch No." = '') or
             (VendorBankAccount."SWIFT Code" = '') or
             (VendorBankAccount."Bank Account No." = '') or
             (VendorBankAccount.IBAN = '')) then
                Pass := false;
        end;
        exit(Pass);

        //HEI.13 FDD-PTPGAP007 IBM PATHAA02 25.08.2017<<
    end;

    procedure CheckProdOrdBackwardFlushing(TrackingSpecification: Record "Tracking Specification"): Boolean;
    var
        ItemJrnlLine: Record "Item Journal Line";
    begin
        //HEI.14
        if (TrackingSpecification."Source Type" = 83) and (TrackingSpecification."Source Subtype" = 5) then begin
            ItemJrnlLine.RESET();
            ItemJrnlLine.SETRANGE(ItemJrnlLine."Journal Template Name", TrackingSpecification."Source ID");
            ItemJrnlLine.SETRANGE(ItemJrnlLine."Line No.", TrackingSpecification."Source Ref. No.");
            ItemJrnlLine.SETRANGE(ItemJrnlLine."Item No.", TrackingSpecification."Item No.");
            ItemJrnlLine.SETRANGE(ItemJrnlLine."Journal Batch Name", TrackingSpecification."Source Batch Name");
            ItemJrnlLine.SETRANGE(ItemJrnlLine."Location Code", TrackingSpecification."Location Code");
            if ItemJrnlLine.FINDFIRST() then begin
                if ItemJrnlLine."Flushing Method" = ItemJrnlLine."Flushing Method"::Backward then
                    exit(true);
            end;
        end;
        //>> HEI.14
    end;

    procedure AmountInLetter(var strprix: Text[250]; prix: Decimal);
    var
        decimal: Integer;
        entiere: Integer;
        j: Integer;
        nbre: Integer;
        nbre1: Integer;
        cent: Text[250];
        mille: Text[250];
        million: Text[250];
    begin
        //HEI.15>>
        entiere := ROUND(prix, 1, '<');
        decimal := ROUND((prix - entiere) * 100, 1, '<');

        nbre := entiere;
        //Chèque.FormatNumTexte(strprix,nbre);

        million := '';
        mille := '';
        cent := '';

        nbre1 := nbre div 1000000;
        if nbre1 <> 0 then begin
            Centaine(million, nbre1);
            million := million + ' million';
        end;

        nbre := nbre mod 1000000;
        nbre1 := nbre div 1000;
        if nbre1 <> 0 then begin
            Centaine(mille, nbre1);
            if mille <> 'un' then
                mille := mille + ' mille'
            else
                mille := 'mille'
        end;

        nbre := nbre mod 1000;

        if nbre <> 0 then begin
            Centaine(cent, nbre);
        end;

        if million <> '' then
            strprix := million;
        if ((mille <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + mille
        else
            strprix := strprix + mille;
        if ((cent <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + cent
        else
            strprix := strprix + cent;

        if entiere > 1 then
            strprix := strprix + ' Dinars Algérien';
        if entiere = 1 then
            strprix := strprix + ' Dinar Algérien';

        cent := '';
        if decimal <> 0 then begin
            Centaine(cent, decimal);
            if strprix <> '' then
                strprix := strprix + ' ' + cent
            else
                strprix := strprix + cent;
            if decimal = 1 then
                strprix := strprix + ' centime'
            else
                strprix := strprix + ' centimes';
        end;

        strprix := UPPERCASE(strprix);
        //HEI.15<<
    end;

    procedure Centaine(var chaine: Text[250]; i: Integer);
    var
        k: Integer;
    begin
        //HEI.15>>
        k := i div 100;
        chaine := '';
        case k of
            1:
                chaine := 'cent';
            2:
                chaine := 'deux cent';
            3:
                chaine := 'trois cent';
            4:
                chaine := 'quatre cent';
            5:
                chaine := 'cinq cent';
            6:
                chaine := 'six cent';
            7:
                chaine := 'sept cent';
            8:
                chaine := 'huit cent';
            9:
                chaine := 'neuf cent';
        end;
        k := i mod 100;
        Dizaine(chaine, k);
        //HEI.15<<
    end;

    procedure Dizaine(var chaine: Text[250]; i: Integer);
    var
        k: Integer;
        l: Integer;
        chaine1: Text[30];
    begin
        //HEI.15>>
        if i > 16 then begin
            k := i div 10;
            chaine1 := '';
            case k of
                1:
                    chaine1 := 'dix';
                2:
                    chaine1 := 'vingt';
                3:
                    chaine1 := 'trente';
                4:
                    chaine1 := 'quarante';
                5:
                    chaine1 := 'cinquante';
                6:
                    chaine1 := 'soixante';
                7:
                    chaine1 := 'soixante';
                8:
                    chaine1 := 'quatre vingt';
                9:
                    chaine1 := 'quatre vingt';
            end;
            if ((chaine1 <> '') and (chaine <> '')) then
                chaine1 := ' ' + chaine1;
            chaine := chaine + chaine1;
            l := k;
            if ((k = 7) or (k = 9)) then
                k := (i mod 10) + 10
            else
                k := (i mod 10);
        end
        else
            k := i;

        if ((l <> 8) and (l <> 0) and ((k = 1) or (k = 11))) then
            chaine := chaine + ' et';
        if (((k = 0) or (k > 16)) and ((l = 7) or (l = 9))) then begin
            chaine := chaine + ' dix';
            if k > 16 then
                k := k - 10;
        end;

        Unité(chaine, k);
        //HEI.15<<
    end;

    procedure "Unité"(var chaine: Text[250]; i: Integer);
    var
        chaine1: Text[30];
    begin
        //HEI.15>>
        chaine1 := '';
        case i of
            1:
                chaine1 := 'un';
            2:
                chaine1 := 'deux';
            3:
                chaine1 := 'trois';
            4:
                chaine1 := 'quatre';
            5:
                chaine1 := 'cinq';
            6:
                chaine1 := 'six';
            7:
                chaine1 := 'sept';
            8:
                chaine1 := 'huit';
            9:
                chaine1 := 'neuf';
            10:
                chaine1 := 'dix';
            11:
                chaine1 := 'onze';
            12:
                chaine1 := 'douze';
            13:
                chaine1 := 'treize';
            14:
                chaine1 := 'quatorze';
            15:
                chaine1 := 'quinze';
            16:
                chaine1 := 'seize';
        end;
        if ((chaine1 <> '') and (chaine <> '')) then
            chaine1 := ' ' + chaine1;
        chaine := chaine + chaine1;
        //HEI.15<<
    end;

    procedure UpdatePreferredBankAccountCode(var VendorBank: Record "Vendor Bank Account");
    var
        Vendor: Record Vendor;
        VendBankAcc: Record "Vendor Bank Account";
        cnt: Integer;
    begin
        //HEI.17 >>
        cnt := 0;
        VendBankAcc.RESET();
        VendBankAcc.SETRANGE("Vendor No.", VendorBank."Vendor No.");
        if not VendBankAcc.ISEMPTY then begin
            if VendBankAcc.findset() then begin
                repeat
                    cnt += 1;
                until VendBankAcc.NEXT() = 0;
                if Vendor.GET(VendorBank."Vendor No.") then begin
                    if cnt = 1 then begin
                        Vendor."Preferred Bank Account Code" := VendorBank.Code
                    end else
                        Vendor."Preferred Bank Account Code" := '';
                    //HEI.26>>
                    Vendor.MODIFY();
                    //HEI.26<<
                end;
            end;
            //HEI.26 comment line: Vendor.MODIFY;
            Vendor.VALIDATE("Payment Method Code");
        end;
        // else BEGIN
        //Vendor.VALIDATE("Payment Method Code");
        //end;
        //HEI.17<<
    end;

    procedure CheckRPMReturns(SalesHeader: Record "Sales Header");
    var
        SalesLine: Record "Sales Line";
        SalesLnAmt: Decimal;
        //BC UPGRADE KUMARR78 ++15-07-2026
        RecEmptyGoodLedger: Record LedgerEntry104FDW;
        RecAmt: Decimal;
    //BC UPGRADE KUMARR78 ++15-07-2026
    begin
        //HEI.18>>
        Customer1.RESET();
        Customer1.GET(SalesHeader."Sell-to Customer No.");
        //Customer1.CALCFIELDS("Deposit Item Balance (LCY)");  // BC Upgrade NANDIS03 - DIT field

        SalesLine.RESET();
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        //SalesLine.SETRANGE(Type,SalesLine.Type::Item);
        // SalesLine.SETFILTER(Type, '%1|%2', SalesLine.Type::Item, SalesLine.Type::"Charge (Item)");//BC UPGRADE KUMARR78 --16-07-2026
        SalesLine.SETFILTER(Type, '%1|%2', SalesLine.Type::Item, SalesLine.Type::"G/L Account");//BC UPGRADE KUMARR78 ++16-07-2026

        //SalesLine.SETFILTER("RPM Type",'<>%1','');
        //SalesLine.SETRANGE("Item Charge Type",SalesLine."Item Charge Type"::Deposit);
        // if not SalesLine.ISEMPTY then begin //BC UPGRADE KUMARR78 --16-07-2026
        if SalesLine.findset() then
            repeat
                //BC UPGRADE KUMARR78 ++16-07-2026
                case SalesLine.Type of
                    SalesLine.Type::Item:
                        SalesLnAmt += SalesLine."Return Qty. to Receive" * SalesLine."Unit Price";

                    SalesLine.Type::"G/L Account":
                        if SalesLine."Attached Line Type 101FDW" =
                           SalesLine."Attached Line Type 101FDW"::"EGM 104FDW"
                        then
                            SalesLnAmt += SalesLine."Return Qty. to Receive" * SalesLine."Unit Price";
                end;
            //BC UPGRADE KUMARR78 ++16-07-2026
            until SalesLine.NEXT() = 0;
        // end; //BC UPGRADE KUMARR78 --16-07-2026

        // if not Customer1."Additional RPM Return" then begin
        //     if SalesLnAmt > Customer1."Deposit Item Balance (LCY)" then
        //         ERROR(Error003);
        // end;  // BC Upgrade NANDIS03 - Blocked as DIT field used
        //HEI.18<<
        //BC UPGRADE KUMARR78 ++15-07-2026
        Clear(RecAmt);
        RecEmptyGoodLedger.Reset();
        RecEmptyGoodLedger.SetRange("Source Type", RecEmptyGoodLedger."Source Type"::Customer);
        RecEmptyGoodLedger.SetRange("Source No.", Customer1."No.");
        if RecEmptyGoodLedger.FindSet() then
            repeat

                //BC UPGRADE KUMARR78 ++27-07-2026
                if RecEmptyGoodLedger."Deposit Amount" < 0 then
                    RecEmptyGoodLedger."Deposit Amount" := RecEmptyGoodLedger."Deposit Amount" * -1
                else
                    RecEmptyGoodLedger."Deposit Amount" := RecEmptyGoodLedger."Deposit Amount" * -1;
                //BC UPGRADE KUMARR78 ++27-07-2026
                RecAmt += RecEmptyGoodLedger."Deposit Amount";
            until RecEmptyGoodLedger.next() = 0;

        if not Customer1."Additional RPM Return FND" then begin
            if SalesLnAmt > RecAmt then
                ERROR(Error003);
        end;
        //BC UPGRADE KUMARR78 ++15-07-2026
    end;

    procedure CheckPCVNBalance(SalesHeader: Record "Sales Header");
    var
        SalesLine: Record "Sales Line";
        FFEBalance: Decimal;
    begin
        //HEI.18>>
        //Customer1.RESET;

        Customer1.GET(SalesHeader."Bill-to Customer No.");
        Customer1.CALCFIELDS("FFE Security Amount FND");
        CheckPCVNBalanceTrue := false;

        SalesLine.RESET();
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        //SalesLine.SETFILTER("RPM Type",'<>%1','');
        SalesLine.SETFILTER(Type, '%1|%2', SalesLine.Type::Item, SalesLine.Type::"Charge (Item)");
        SalesLine.SETFILTER("RPM Solution FND", '%1|%2', SalesLine."RPM Solution FND"::"Full-for Empty without revenue impact (FFE w/o revenue)", SalesLine."RPM Solution FND"::"Full-for-Empty with revenue impact (FFE with revenue)");
        //SalesLine.SETRANGE("Item Charge Type",SalesLine."Item Charge Type"::Deposit);
        if not SalesLine.ISEMPTY then begin
            if SalesLine.findset() then
                repeat
                    //      IF (SalesLine."Item Charge Type" = SalesLine."Item Charge Type"::Deposit) AND (SalesLine."Empty Goods Item No." <> '') THEN BEGIN
                    //FFEBalance += (SalesLine.Quantity * SalesLine."Unit Price");
                    CheckPCVNBalanceTrue := true;
                //      end
                until SalesLine.NEXT() = 0;
        end;

        if CheckPCVNBalanceTrue then begin
            //    IF (Customer1."RPM Exposure FND" > 0) AND (Customer1."Packaging Credit Value (PCV)" = 0) THEN
            //      ERROR(Error004);

            if (Customer1."FFE Security Amount FND" = 0) and (FFEBalance > 0) then
                ERROR(Error004);

            if Customer1."Check Bal/FFE security Amt FND" then begin
                if (FFEBalance > Customer1."FFE Security Amount FND") then
                    ERROR(Error004);
            end;

            //HEI.18<<

            //>>HEI.19
            if not (Customer1."Packaging Credit Value PCV FND" = 0) and (Customer1."RPM Exposure FND" = 0) then
                ERROR(Error007);

            if (Customer1."Packaging Credit Value PCV FND" = 0) and (Customer1."RPM Exposure FND" > 0) then
                ERROR(Error007);

            //>DS_001 temporary fix
            if (Customer1."Packaging Credit Value PCV FND" < Customer1."RPM Exposure FND") then
                //IF  (Customer1."Packaging Credit Value (PCV)" > Customer1."RPM Exposure FND") THEN
                ERROR(Error006);
            //<DS_001

            if Customer1."Check Bal/FFE security Amt FND" then begin
                if Customer1."RPM Exposure FND" > Customer1."FFE Security Amount FND" then
                    ERROR(Error005);
            end;
        end;
        //<<HEI.19
    end;

    procedure updatevendBank(var VendorBank: Record "Vendor Bank Account");
    var
        Vendor: Record Vendor;
        VendBankAcc: Record "Vendor Bank Account";
        cnt: Integer;
    begin
        //HEI.17>>
        cnt := 0;

        VendBankAcc.RESET();
        VendBankAcc.SETRANGE("Vendor No.", VendorBank."Vendor No.");
        if not VendBankAcc.ISEMPTY then begin
            if VendBankAcc.findset() then
                repeat
                    cnt := cnt + 1;
                until VendBankAcc.NEXT() = 0
        end;

        if Vendor.GET(VendorBank."Vendor No.") then begin
            if cnt = 0 then
                Vendor."Preferred Bank Account Code" := VendorBank.Code
            else
                Vendor."Preferred Bank Account Code" := '';
            //HEI.26>>
            Vendor.MODIFY();
            //HEI.26<<
        end;
        //HEI.26 comment line: Vendor.MODIFY;
        //Vendor.VALIDATE("Payment Method Code"); NAIKH01
        //HEI.17<<
    end;

    procedure updatVendebankfordel(var VendorBank: Record "Vendor Bank Account");
    var
        Vendor: Record Vendor;
        VendBankAcc: Record "Vendor Bank Account";
        cnt: Integer;
    begin
        //HEI.17>>
        cnt := 0;
        VendBankAcc.RESET();
        VendBankAcc.SETRANGE("Vendor No.", VendorBank."Vendor No.");
        VendBankAcc.SETFILTER(Code, '<>%1', VendorBank.Code);
        if not VendBankAcc.ISEMPTY then begin
            if VendBankAcc.findset() then
                repeat
                    cnt := cnt + 1;
                until VendBankAcc.NEXT() = 0
        end;

        if Vendor.GET(VendorBank."Vendor No.") then begin
            if cnt = 1 then
                Vendor."Preferred Bank Account Code" := VendBankAcc.Code
            else
                Vendor."Preferred Bank Account Code" := '';
            //HEI.26>>
            Vendor.MODIFY();
            //HEI.26<<
        end;
        //HEI.26 comment line: Vendor.MODIFY;
        Vendor.VALIDATE("Payment Method Code");
        //HEI.17<<
    end;

    procedure ReversePrepaymentInvoice(var GenJnl: Record "Gen. Journal Line");
    var
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchInvLine: Record "Purch. Inv. Line";
        PurchaseHeader: Record "Purchase Header";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
        PurchPostPrepmt: Codeunit "Purchase-Post Prepayments";
    begin
        //HEI.22>>
        if GenJnl."Applies-to Doc. No." <> '' then begin
            VendorLedgerEntry.RESET();
            VendorLedgerEntry.SETCURRENTKEY("Document No.");
            VendorLedgerEntry.SETRANGE("Document No.", GenJnl."Applies-to Doc. No.");
            VendorLedgerEntry.SETRANGE(Prepayment, true);
            if VendorLedgerEntry.FINDFIRST() then begin
                if VendorLedgerEntry.Open then begin
                    if PurchInvHeader.GET(VendorLedgerEntry."Document No.") then begin
                        PurchaseHeader.SETRANGE("No.", PurchInvHeader."Prepayment Order No.");
                        if PurchaseHeader.FINDFIRST() then begin
                            VendorLedgerEntry.CALCFIELDS("Remaining Amount"); //hei.59
                            if (GenJnl.Amount = ABS(VendorLedgerEntry."Remaining Amount")) then //hei.59
                                CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeader); //hei.59
                            if not CMExist(PurchaseHeader) then begin
                                PurchaseHeader."Vendor Cr. Memo No." := 'CM ' + PurchaseHeader."Vendor Invoice No.";
                                PurchaseHeader."Prep. to reverse FND" := GenJnl."Applies-to Doc. No.";
                                GenJnl."Applies-to Doc. No." := '';
                                GenJnl."Applies-to Doc. Type" := GenJnl."Applies-to Doc. Type"::" ";
                                GenJnl.MODIFY(true);
                                PurchPostPrepmt.CreditMemo(PurchaseHeader);
                            end;
                        end;
                    end;
                end;
            end;
        end else begin
            VendorLedgerEntry.RESET();
            VendorLedgerEntry.SETCURRENTKEY("Vendor No.", "Applies-to ID");
            VendorLedgerEntry.SETRANGE("Applies-to ID", GenJnl."Document No.");
            VendorLedgerEntry.SETRANGE("Vendor No.", GenJnl."Account No.");
            VendorLedgerEntry.SETRANGE(Prepayment, true);
            if VendorLedgerEntry.FINDFIRST() then
                repeat

                    if PurchInvHeader.GET(VendorLedgerEntry."Document No.") then begin
                        PurchaseHeader.SETRANGE("No.", PurchInvHeader."Prepayment Order No.");
                        if PurchaseHeader.FINDFIRST() then begin
                            CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeader); //hei.59
                            if not CMExist(PurchaseHeader) then begin
                                PurchaseHeader."Vendor Cr. Memo No." := 'CM ' + PurchaseHeader."Vendor Invoice No.";
                                PurchaseHeader."Prep. to reverse FND" := VendorLedgerEntry."Document No.";
                                VendorLedgerEntry."Applies-to ID" := '';
                                VendorLedgerEntry.MODIFY();
                                PurchPostPrepmt.CreditMemo(PurchaseHeader);
                            end;
                        end;
                    end;
                until VendorLedgerEntry.NEXT() = 0;
        end;
        //HEI.2<<
    end;

    local procedure CMExist(var PurchaseHdr: Record "Purchase Header"): Boolean;
    var
        PurchCrMemo: Record "Purch. Cr. Memo Hdr.";
    begin
        PurchCrMemo.SETRANGE("Prepayment Order No.", PurchaseHdr."No.");

        exit(not PurchCrMemo.ISEMPTY);
    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeleteGenJournalLineEvent(var Rec: Record "Gen. Journal Line"; RunTrigger: Boolean);
    begin
        //HEI.06>>
        if Rec.ISTEMPORARY then
            exit;
        if Rec."Applies-to Doc. No." <> '' then begin
            CLEAR(VendorLedgerEntry_G);
            VendorLedgerEntry_G.SETCURRENTKEY("Document No.");
            VendorLedgerEntry_G.SETRANGE("Vendor No.", Rec."Account No.");
            VendorLedgerEntry_G.SETRANGE("Document No.", Rec."Applies-to Doc. No.");
            //added on 12/11/2017 Isyed01 >>
            //up on posting from payment journal to avoide clearing Batch payment Name added filter on open filed true
            VendorLedgerEntry_G.SETRANGE(Open, true);
            //added on 12/11/2017 Isyed01 <<
            if VendorLedgerEntry_G.findset() then begin
                repeat
                    VendorLedgerEntry_G."Batch payment name FND" := '';
                    VendorLedgerEntry_G.MODIFY();
                until VendorLedgerEntry_G.NEXT() = 0;
            end;
        end;
        //HEI.06<<
    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterValidateEvent', 'Applies-to Doc. No.', false, false)]
    local procedure EventOnafterValidateVendorBatch(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; CurrFieldNo: Integer);
    begin
        //HEI.06>>
        if Rec.ISTEMPORARY then
            exit;
        if (xRec."Applies-to Doc. No." <> '') and (Rec."Applies-to Doc. No." = '') or (xRec."Applies-to Doc. No." <> Rec."Applies-to Doc. No.") then begin
            CLEAR(VendorLedgerEntry_G);
            VendorLedgerEntry_G.SETCURRENTKEY("Document No.");
            VendorLedgerEntry_G.SETRANGE("Vendor No.", xRec."Account No.");
            VendorLedgerEntry_G.SETRANGE("Document No.", Rec."Applies-to Doc. No.");
            if VendorLedgerEntry_G.findset() then
                repeat
                    VendorLedgerEntry_G."Batch payment name FND" := '';
                    VendorLedgerEntry_G.MODIFY();
                until VendorLedgerEntry_G.NEXT() = 0;
        end;
        //HEI.06<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure OnAfterValidateEvent_ItemLifecyclestatus(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    begin
        if Rec.ISTEMPORARY then
            exit;
        //HEI.23>>
        if Rec.Type = Rec.Type::Item then begin
            StockkeepingUnit.SETRANGE("Item No.", Rec."No.");
            StockkeepingUnit.SETRANGE("Location Code", Rec."Location Code");
            StockkeepingUnit.SETRANGE("Plant Spec.Material Status FND", StockkeepingUnit."Plant Spec.Material Status FND"::"Local Inact/ No Procurement");
            if StockkeepingUnit.FINDFIRST() then
                ERROR(Error008, Rec."No.", Rec."Location Code");
        end;
        //HEI.23<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifyEvent_ItemLifecyclestatus(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; RunTrigger: Boolean);
    begin
        if Rec.ISTEMPORARY then
            exit;
        //HEI.23>>
        if Rec.Type = Rec.Type::Item then begin
            StockkeepingUnit.SETRANGE("Item No.", Rec."No.");
            StockkeepingUnit.SETRANGE("Location Code", Rec."Location Code");
            StockkeepingUnit.SETRANGE("Plant Spec.Material Status FND", StockkeepingUnit."Plant Spec.Material Status FND"::"Local Inact/ No Procurement");
            if StockkeepingUnit.FINDFIRST() then
                ERROR(Error008, Rec."No.", Rec."Location Code");
        end;
        //HEI.23<<
    end;

    procedure SuggestSales(DateFilter: Option CM,CQ,CP; Period: Text);
    begin
        //HEI.24>>
        case DateFilter of
            DateFilter::CM:
                begin
                    GetSalesForCM();
                end;
            DateFilter::CQ:
                begin
                    //GetSalesForCM;
                    GetSalesForCQ();
                end;
            DateFilter::CP:
                begin
                    GetSalesForCP(Period);
                end;
        end;
        //HEI.24<<
    end;

    procedure SuggestSalesForLastQuarter();
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        EndDate: Date;
        StartDate: Date;
    begin
        //HEI.24>>
        GeneralLedgerSetup.GET();
        SalesReceivablesSetup.GET();
        SalesReceivablesSetup.TESTFIELD("Know - How Fee % FND");
        EndDate := CALCDATE('CQ - 3M', WORKDATE());
        StartDate := CALCDATE('CQ - 6M + 2D', WORKDATE());
        GetPostedSalesInv(StartDate, EndDate, 10000);
        //HEI.24<<
    end;

    local procedure GetSalesForCM();
    var
        Currency: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        Customer: Record Customer;
        DimensionSetEntry: Record "Dimension Set Entry";
        GeneralLedgerSetup: Record "General Ledger Setup";
        RoyaltyFeeSetup: Record "Royalty Fee Setup FND";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        SalesForecast: Record "Sales Forecast FND";
        SalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesLine: Record "Sales Line";
        EndDate: Date;
        StartDate: Date;
        LineAmount: Decimal;
        LineNo: Integer;
        SalesForecastLineNo: Integer;
    begin
        //HEI.24>>
        GeneralLedgerSetup.GET();
        SalesReceivablesSetup.GET();
        SalesReceivablesSetup.TESTFIELD("Know - How Fee % FND");

        StartDate := CALCDATE('-CM', WORKDATE());
        EndDate := CALCDATE('CM - 6D', WORKDATE());
        SalesForecastLineNo := GetPostedSalesInv(StartDate, EndDate, 10000);
        SalesForecastLineNo := GetPostedSalesCrMemo(StartDate, EndDate, SalesForecastLineNo);
        SalesForecastLineNo := GetOpenSales(EndDate, CALCDATE('CM', WORKDATE()), SalesForecastLineNo);
        //HEI.24<<
    end;

    local procedure GetSalesForCQ();
    var
        Currency: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        DimensionSetEntry: Record "Dimension Set Entry";
        GeneralLedgerSetup: Record "General Ledger Setup";
        RoyaltyFeeSetup: Record "Royalty Fee Setup FND";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        SalesForecast: Record "Sales Forecast FND";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        EndDate: Date;
        StartDate: Date;
        LineAmount: Decimal;
        LineNo: Integer;
        SalesForecastLineNo: Integer;
    begin
        //HEI.24>>
        SalesReceivablesSetup.GET();
        SalesReceivablesSetup.TESTFIELD("Know - How Fee % FND");

        //CQ>>
        StartDate := CALCDATE('CQ - 3M + 1D', WORKDATE());
        EndDate := CALCDATE('-CM - 1D', WORKDATE());
        SalesForecastLineNo := GetPostedSalesInv(StartDate, EndDate, 10000);
        SalesForecastLineNo := GetPostedSalesCrMemo(StartDate, EndDate, SalesForecastLineNo);
        //CQ<<

        //CM>>
        StartDate := CALCDATE('-CM', WORKDATE());
        EndDate := CALCDATE('CM - 6D', WORKDATE());
        SalesForecastLineNo := GetPostedSalesInv(StartDate, EndDate, SalesForecastLineNo);
        SalesForecastLineNo := GetPostedSalesCrMemo(StartDate, EndDate, SalesForecastLineNo);
        SalesForecastLineNo := GetOpenSales(EndDate, CALCDATE('CM', WORKDATE()), SalesForecastLineNo);
        //CM<<
        //HEI.24<<
    end;

    procedure GenerateAccountingNotes(PostEntries: Boolean);
    var
        TempSalesForecastBuffer: Record "Aging Band Buffer" temporary;
        GenJournalLine: Record "Gen. Journal Line";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        SalesForecast: Record "Sales Forecast FND";
        TotalKnowHow: Decimal;
        LineNo: Integer;
    begin
        //HEI.24>>
        SalesReceivablesSetup.GET();
        SalesReceivablesSetup.TESTFIELD("Journal BatchName Forecast FND");
        SalesReceivablesSetup.TESTFIELD("Jnl Template Name Forecast FND");
        SalesReceivablesSetup.TESTFIELD("Accrual Account Forecast FND");
        SalesReceivablesSetup.TESTFIELD("Royalty Account Forecast FND");
        SalesReceivablesSetup.TESTFIELD("Know-How Account Forecast FND");
        //check GenJnlLine
        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Batch Name", SalesReceivablesSetup."Journal BatchName Forecast FND");
        GenJournalLine.SETRANGE("Journal Template Name", SalesReceivablesSetup."Jnl Template Name Forecast FND");
        GenJournalLine.DELETEALL();

        //search for Royalty
        TempSalesForecastBuffer.RESET();
        TempSalesForecastBuffer.DELETEALL();
        SalesForecast.RESET();
        SalesForecast.SETRANGE("Accounting Notes Generated", false);
        SalesForecast.SETFILTER("Brand Code", '<>%1', '');
        SalesForecast.SETFILTER("Royalty Amount EUR", '<>%1', 0);
        if SalesForecast.findset() then
            repeat
                if TempSalesForecastBuffer.GET(SalesForecast."Brand Code") then begin
                    TempSalesForecastBuffer."Column 1 Amt." += SalesForecast."Royalty Amount EUR";
                    TempSalesForecastBuffer.MODIFY();
                end else begin
                    TempSalesForecastBuffer.INIT();
                    TempSalesForecastBuffer."Currency Code" := SalesForecast."Brand Code";
                    TempSalesForecastBuffer."Column 1 Amt." := SalesForecast."Royalty Amount EUR";
                    TempSalesForecastBuffer.INSERT();
                end;
            until SalesForecast.NEXT() = 0;

        //royalty line
        TempSalesForecastBuffer.RESET();
        if TempSalesForecastBuffer.findset() then
            repeat
                LineNo += 1000;
                InitGenJnlLine(SalesReceivablesSetup."Accrual Account Forecast FND", SalesReceivablesSetup."Royalty Account Forecast FND", TempSalesForecastBuffer."Column 1 Amt.", LineNo, PostEntries, TempSalesForecastBuffer."Currency Code", false);
            until TempSalesForecastBuffer.NEXT() = 0;

        //know how line
        SalesForecast.RESET();
        SalesForecast.SETRANGE("Accounting Notes Generated", false);
        SalesForecast.CALCSUMS("Know-How Amount EUR");
        LineNo += 1000;
        InitGenJnlLine(SalesReceivablesSetup."Accrual Account Forecast FND", SalesReceivablesSetup."Know-How Account Forecast FND", SalesForecast."Know-How Amount EUR", LineNo, PostEntries, TempSalesForecastBuffer."Currency Code", true);

        //change "Accounting Notes Generated" flag
        SalesForecast.RESET();
        SalesForecast.SETRANGE(Year, DATE2DMY(WORKDATE(), 3));
        SalesForecast.SETRANGE(Month, DATE2DMY(WORKDATE(), 2));
        SalesForecast.MODIFYALL("Accounting Notes Generated", true);
        //HEI.24<<
    end;

    local procedure InitGenJnlLine(AccNo: Code[20]; BalAccNo: Code[20]; SalesAmount: Decimal; GenJnlLineNo: Integer; PostLine: Boolean; BrandCodeDim: Code[20]; KnowHowLine: Boolean);
    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLine2: Record "Gen. Journal Line";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    begin
        //HEI.24>>
        SalesReceivablesSetup.GET();

        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variables with GenJournalLine.
        //with GenJournalLine do begin
        GenJournalLine.INIT();
        GenJournalLine."Journal Batch Name" := SalesReceivablesSetup."Journal BatchName Forecast FND";//review
        GenJournalLine."Journal Template Name" := SalesReceivablesSetup."Journal BatchName Forecast FND";//review
        GenJournalLine."Line No." := GenJnlLineNo;
        GenJournalLine.VALIDATE("Posting Date", CALCDATE('CM - 6D'));
        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::" ");//HEI.02
                                                                                      //VALIDATE("Document No.",'SF_' + FORMAT(DATE2DWY(TODAY,3)) + FORMAT(DATE2DWY(TODAY,2)));//review
        GenJournalLine.VALIDATE("Document No.", BalAccNo);
        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
        GenJournalLine.VALIDATE("Account No.", BalAccNo);//review
        GenJournalLine.VALIDATE("Currency Code", 'EUR');
        GenJournalLine.VALIDATE(Amount, SalesAmount);
        GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
        GenJournalLine.VALIDATE("Bal. Account No.", AccNo);
        GenJournalLine."Forecast Key FND" := FORMAT(DATE2DMY(WORKDATE(), 3)) + FORMAT(DATE2DMY(WORKDATE(), 2));
        GenJournalLine."Forecast Line FND" := true;
        if not KnowHowLine then
            GenJournalLine.ValidateShortcutDimCode(1, BrandCodeDim);
        if PostLine then
            GenJnlPostLine.RunWithCheck(GenJournalLine)
        else
            GenJournalLine.INSERT();

        //end;
        // BC Upgrade MISHRS14<<

        //negative line
        GenJournalLine2.INIT();
        GenJournalLine2.TRANSFERFIELDS(GenJournalLine);
        GenJournalLine2.VALIDATE(Amount, -GenJournalLine.Amount);
        GenJournalLine2.VALIDATE("Line No.", GenJnlLineNo + 10);
        GenJournalLine2.VALIDATE("Posting Date", CALCDATE('CM + 1D', WORKDATE()));
        if not KnowHowLine then
            GenJournalLine2.ValidateShortcutDimCode(1, BrandCodeDim);
        if PostLine then
            GenJnlPostLine.RunWithCheck(GenJournalLine2)
        else
            GenJournalLine2.INSERT();

        //GenJnlPostLine.RunWithCheck(GenJnlLine)
        //HEI.24<<
    end;

    local procedure GetPostedSalesInv(StartDate: Date; EndDate: Date; LineNo: Integer): Integer;
    var
        Currency: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        DimensionSetEntry: Record "Dimension Set Entry";
        GeneralLedgerSetup: Record "General Ledger Setup";
        RoyaltyFeeSetup: Record "Royalty Fee Setup FND";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        SalesForecast: Record "Sales Forecast FND";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        LineAmount: Decimal;
    begin
        //HEI.24>>
        GeneralLedgerSetup.GET();
        SalesReceivablesSetup.GET();

        SalesInvoiceLine.RESET();
        SalesInvoiceLine.SETRANGE("Posting Date", StartDate, EndDate);
        SalesInvoiceLine.SETFILTER(Type, '%1|%2', SalesInvoiceLine.Type::Item, SalesInvoiceLine.Type::"G/L Account");//1.11
        SalesInvoiceLine.SETFILTER(Quantity, '<>%1', 0);//13/10
        if SalesInvoiceLine.findset() then
            repeat
                LineNo += 1000;
                SalesForecast.INIT();
                SalesForecast.Year := DATE2DWY(WORKDATE(), 3);
                SalesForecast.Month := DATE2DMY(WORKDATE(), 2);
                SalesForecast."Line No." := LineNo;
                SalesForecast."Document Type" := SalesForecast."Document Type"::"Posted Sales Invoice";
                SalesForecast."Document No." := SalesInvoiceLine."Document No.";
                SalesInvoiceHeader.GET(SalesInvoiceLine."Document No.");
                SalesForecast."Document Date" := SalesInvoiceHeader."Document Date";
                SalesForecast."Due Date" := SalesInvoiceHeader."Due Date";
                SalesForecast."Customer No." := SalesInvoiceLine."Sell-to Customer No.";
                //SalesInvoiceLine.CALCFIELDS("Sell-to Customer Name");  // BC Upgrade NANDIS03 - blocked as DIT field

                //SalesForecast."Customer Name" := SalesInvoiceLine."Sell-to Customer Name";  // BC Upgrade NANDIS03 - blocked as DIT field
                case SalesInvoiceLine.Type of
                    SalesInvoiceLine.Type::Item:
                        begin
                            DimensionSetEntry.RESET();
                            DimensionSetEntry.SETRANGE("Dimension Set ID", SalesInvoiceLine."Dimension Set ID");
                            DimensionSetEntry.SETRANGE("Dimension Code", GeneralLedgerSetup."Brand Dimension Code FND");
                            if DimensionSetEntry.FINDFIRST() then begin
                                SalesForecast."Brand Code" := DimensionSetEntry."Dimension Value Code";
                                DimensionSetEntry.CALCFIELDS("Dimension Value Name");
                                SalesForecast."Brand Code Name" := DimensionSetEntry."Dimension Value Name";
                            end;
                            //SalesForecast.Volume := SalesInvoiceLine.Quantity * SalesInvoiceLine."Unit Volume HL";  // BC Upgrade NANDIS03 - blocked as DIT field
                            LineAmount := SalesInvoiceLine.Quantity * SalesInvoiceLine."Unit Price";
                            if SalesInvoiceHeader."Prices Including VAT" then begin
                                SalesForecast."Sales Price (WithOut VAT)" := ROUND(LineAmount - (LineAmount * (SalesInvoiceLine."VAT %" / 100)), 2);
                            end else begin
                                SalesForecast."Sales Price (WithOut VAT)" := LineAmount;
                            end;
                            if RoyaltyFeeSetup.GET(SalesForecast."Brand Code") then begin
                                //SalesForecast."Royalty Amount LCY" := ROUND(SalesForecast."Sales Price (WithOut VAT)" * (RoyaltyFeeSetup."Royalty %" / 100) * SalesInvoiceLine.Quantity,2);
                                //SalesForecast."Know-How Amount LCY" := ROUND(SalesForecast."Sales Price (WithOut VAT)" * (SalesReceivablesSetup."Know - How Fee % FND" / 100) * SalesInvoiceLine.Quantity,2);
                                SalesForecast."Royalty Amount LCY" := ROUND(SalesForecast."Sales Price (WithOut VAT)" * (RoyaltyFeeSetup."Royalty %" / 100), 2);
                                SalesForecast."Know-How Amount LCY" := ROUND(SalesForecast."Sales Price (WithOut VAT)" * (SalesReceivablesSetup."Know - How Fee % FND" / 100), 2);
                            end;
                            SalesForecast."Currency Code" := 'EUR';
                            CurrencyExchangeRate.RESET();
                            CurrencyExchangeRate.SETFILTER("Currency Code", 'EUR');
                            CurrencyExchangeRate.SETFILTER("Starting Date", '<=%1', TODAY);
                            if CurrencyExchangeRate.FINDLAST() then begin
                                //IF CurrencyExchangeRate.GET('EUR',TODAY) THEN BEGIN
                                Currency.GET('EUR');
                                SalesForecast."Royalty Amount EUR" := ROUND(SalesForecast."Royalty Amount LCY" / CurrencyExchangeRate."Relational Exch. Rate Amount", Currency."Unit-Amount Rounding Precision");
                                SalesForecast."Know-How Amount EUR" := ROUND(SalesForecast."Know-How Amount LCY" / CurrencyExchangeRate."Relational Exch. Rate Amount", Currency."Unit-Amount Rounding Precision");
                            end;
                        end;
                    SalesInvoiceLine.Type::"G/L Account":
                        begin
                            //SalesForecast.Volume := SalesInvoiceLine.Quantity * SalesInvoiceLine."Unit Volume HL";  // BC Upgrade NANDIS03 - blocked as DIT field
                            LineAmount := SalesInvoiceLine.Quantity * SalesInvoiceLine."Unit Price";
                            if SalesInvoiceHeader."Prices Including VAT" then begin
                                SalesForecast."Sales Price (WithOut VAT)" := ROUND(LineAmount - (LineAmount * (SalesInvoiceLine."VAT %" / 100)), 2);
                            end else begin
                                SalesForecast."Sales Price (WithOut VAT)" := LineAmount;
                            end;
                            RoyaltyFeeSetup.RESET();
                            if RoyaltyFeeSetup.FINDFIRST() then begin
                                SalesForecast."Know-How Amount LCY" := ROUND(SalesForecast."Sales Price (WithOut VAT)" * (SalesReceivablesSetup."Know - How Fee % FND" / 100), 2);
                            end;
                            SalesForecast."Currency Code" := 'EUR';
                            CurrencyExchangeRate.RESET();
                            CurrencyExchangeRate.SETFILTER("Currency Code", 'EUR');
                            CurrencyExchangeRate.SETFILTER("Starting Date", '<=%1', TODAY);
                            if CurrencyExchangeRate.FINDLAST() then begin
                                //IF CurrencyExchangeRate.GET('EUR',TODAY) THEN BEGIN
                                Currency.GET('EUR');
                                SalesForecast."Know-How Amount EUR" := ROUND(SalesForecast."Know-How Amount LCY" / CurrencyExchangeRate."Relational Exch. Rate Amount", Currency."Unit-Amount Rounding Precision");
                            end;
                        end;
                end;
                SalesForecast.INSERT();
            until SalesInvoiceLine.NEXT() = 0;

        exit(LineNo);
        //HEI.24<<
    end;

    local procedure GetPostedSalesCrMemo(StartDate: Date; EndDate: Date; LineNo: Integer): Integer;
    var
        Currency: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        DimensionSetEntry: Record "Dimension Set Entry";
        GeneralLedgerSetup: Record "General Ledger Setup";
        RoyaltyFeeSetup: Record "Royalty Fee Setup FND";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SalesForecast: Record "Sales Forecast FND";
        LineAmount: Decimal;
    begin
        //HEI.24>>
        SalesCrMemoLine.RESET();
        SalesCrMemoLine.SETRANGE("Posting Date", StartDate, EndDate);
        SalesCrMemoLine.SETFILTER(Type, '%1|%2', SalesCrMemoLine.Type::Item, SalesCrMemoLine.Type::"G/L Account");//1.11
        SalesCrMemoLine.SETFILTER(Quantity, '<>%1', 0);//13/10
        if SalesCrMemoLine.findset() then
            repeat
                LineNo += 1000;
                SalesForecast.INIT();
                SalesForecast.Year := DATE2DWY(WORKDATE(), 3);
                SalesForecast.Month := DATE2DMY(WORKDATE(), 2);
                SalesForecast."Line No." := LineNo;
                SalesForecast."Document Type" := SalesForecast."Document Type"::"Posted Sales Invoice";
                SalesForecast."Document No." := SalesCrMemoLine."Document No.";
                SalesCrMemoHeader.GET(SalesCrMemoLine."Document No.");
                SalesForecast."Document Date" := SalesCrMemoHeader."Document Date";
                SalesForecast."Due Date" := SalesCrMemoHeader."Due Date";
                SalesForecast."Customer No." := SalesCrMemoLine."Sell-to Customer No.";
                //SalesCrMemoLine.CALCFIELDS("Sell-to Customer Name");  // BC Upgrade NANDIS03 - blocked as DIT field
                //SalesForecast."Customer Name" := SalesCrMemoLine."Sell-to Customer Name";  // BC Upgrade NANDIS03 - blocked as DIT field
                case SalesCrMemoLine.Type of
                    SalesCrMemoLine.Type::Item:
                        begin
                            DimensionSetEntry.RESET();
                            DimensionSetEntry.SETRANGE("Dimension Set ID", SalesCrMemoLine."Dimension Set ID");
                            DimensionSetEntry.SETRANGE("Dimension Code", GeneralLedgerSetup."Brand Dimension Code FND");
                            if DimensionSetEntry.FINDFIRST() then begin
                                SalesForecast."Brand Code" := DimensionSetEntry."Dimension Value Code";
                                DimensionSetEntry.CALCFIELDS("Dimension Value Name");
                                SalesForecast."Brand Code Name" := DimensionSetEntry."Dimension Value Name";
                            end;
                            //SalesForecast.Volume := SalesCrMemoLine.Quantity * SalesCrMemoLine."Unit Volume HL";  // BC Upgrade NANDIS03 - blocked as DIT field
                            LineAmount := SalesCrMemoLine.Quantity * SalesCrMemoLine."Unit Price";
                            if SalesCrMemoHeader."Prices Including VAT" then begin
                                SalesForecast."Sales Price (WithOut VAT)" := ROUND(LineAmount - (LineAmount * (SalesCrMemoLine."VAT %" / 100)), 2);
                            end else begin
                                SalesForecast."Sales Price (WithOut VAT)" := LineAmount;
                            end;
                            if RoyaltyFeeSetup.GET(SalesForecast."Brand Code") then begin
                                //SalesForecast."Royalty Amount LCY" := ROUND(SalesForecast."Sales Price (WithOut VAT)" * (RoyaltyFeeSetup."Royalty %" / 100) * SalesCrMemoLine.Quantity,2);
                                //SalesForecast."Know-How Amount LCY" := ROUND(SalesForecast."Sales Price (WithOut VAT)" * (SalesReceivablesSetup."Know - How Fee % FND" / 100) * SalesCrMemoLine.Quantity,2);
                                SalesForecast."Royalty Amount LCY" := ROUND(SalesForecast."Sales Price (WithOut VAT)" * (RoyaltyFeeSetup."Royalty %" / 100), 2);
                                SalesForecast."Know-How Amount LCY" := ROUND(SalesForecast."Sales Price (WithOut VAT)" * (SalesReceivablesSetup."Know - How Fee % FND" / 100), 2);
                            end;
                            SalesForecast."Currency Code" := 'EUR';
                            CurrencyExchangeRate.RESET();
                            CurrencyExchangeRate.SETFILTER("Currency Code", 'EUR');
                            CurrencyExchangeRate.SETFILTER("Starting Date", '<=%1', TODAY);
                            if CurrencyExchangeRate.FINDLAST() then begin
                                //IF CurrencyExchangeRate.GET('EUR',TODAY) THEN BEGIN
                                Currency.GET('EUR');
                                SalesForecast."Royalty Amount EUR" := ROUND(SalesForecast."Royalty Amount LCY" / CurrencyExchangeRate."Relational Exch. Rate Amount", Currency."Unit-Amount Rounding Precision");
                                SalesForecast."Know-How Amount EUR" := ROUND(SalesForecast."Know-How Amount LCY" / CurrencyExchangeRate."Relational Exch. Rate Amount", Currency."Unit-Amount Rounding Precision");
                            end;
                        end;
                    SalesCrMemoLine.Type::"G/L Account":
                        begin
                            //SalesForecast.Volume := SalesCrMemoLine.Quantity * SalesCrMemoLine."Unit Volume HL";  // BC Upgrade NANDIS03 - blocked as DIT field
                            LineAmount := SalesCrMemoLine.Quantity * SalesCrMemoLine."Unit Price";
                            if SalesCrMemoHeader."Prices Including VAT" then begin
                                SalesForecast."Sales Price (WithOut VAT)" := ROUND(LineAmount - (LineAmount * (SalesCrMemoLine."VAT %" / 100)), 2);
                            end else begin
                                SalesForecast."Sales Price (WithOut VAT)" := LineAmount;
                            end;
                            RoyaltyFeeSetup.RESET();
                            if RoyaltyFeeSetup.FINDFIRST() then begin
                                SalesForecast."Know-How Amount LCY" := ROUND(SalesForecast."Sales Price (WithOut VAT)" * (SalesReceivablesSetup."Know - How Fee % FND" / 100), 2);
                            end;
                            SalesForecast."Currency Code" := 'EUR';
                            CurrencyExchangeRate.RESET();
                            CurrencyExchangeRate.SETFILTER("Currency Code", 'EUR');
                            CurrencyExchangeRate.SETFILTER("Starting Date", '<=%1', TODAY);
                            if CurrencyExchangeRate.FINDLAST() then begin
                                //IF CurrencyExchangeRate.GET('EUR',TODAY) THEN BEGIN
                                Currency.GET('EUR');
                                SalesForecast."Know-How Amount EUR" := ROUND(SalesForecast."Know-How Amount LCY" / CurrencyExchangeRate."Relational Exch. Rate Amount", Currency."Unit-Amount Rounding Precision");
                            end;
                        end;
                end;
                SalesForecast.INSERT();
            until SalesCrMemoLine.NEXT() = 0;

        exit(LineNo);
        //HEI.24<<
    end;

    local procedure GetOpenSales(StartDate: Date; EndDate: Date; LineNo: Integer): Integer;
    var
        Currency: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        Customer: Record Customer;
        DimensionSetEntry: Record "Dimension Set Entry";
        GeneralLedgerSetup: Record "General Ledger Setup";
        RoyaltyFeeSetup: Record "Royalty Fee Setup FND";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        SalesForecast: Record "Sales Forecast FND";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LineAmount: Decimal;
    begin
        //HEI.24>>
        SalesLine.RESET();
        SalesLine.SETRANGE("Forecasted Shipment Date FND", StartDate, EndDate);
        SalesLine.SETFILTER("Document Type", '%1|%2', SalesLine."Document Type"::Order, SalesLine."Document Type"::Invoice);//1.11
        SalesLine.SETFILTER(Type, '%1|%2', SalesLine.Type::Item, SalesLine.Type::"G/L Account");//1.11

        if SalesLine.findset() then
            repeat

                // BC Upgrade MISHRS14 >>
                // Blocked with statement and prefixed variables with SalesForecast.
                //with SalesForecast do begin
                if SalesLine.Quantity - SalesLine."Quantity Invoiced" <> 0 then begin
                    LineNo += 1000;
                    SalesForecast.INIT();
                    SalesForecast.Year := DATE2DMY(WORKDATE(), 3);
                    SalesForecast.Month := DATE2DMY(WORKDATE(), 2);
                    SalesForecast."Line No." := LineNo;
                    if SalesLine."Document Type" = SalesLine."Document Type"::Order then
                        SalesForecast."Document Type" := SalesForecast."Document Type"::"Sales Order"
                    else
                        SalesForecast."Document Type" := SalesForecast."Document Type"::"Sales Invoice";
                    SalesForecast."Document No." := SalesLine."Document No.";
                    SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.");
                    SalesForecast."Due Date" := SalesHeader."Due Date";
                    SalesForecast."Document Date" := SalesHeader."Document Date";
                    SalesForecast."Customer No." := SalesLine."Sell-to Customer No.";
                    Customer.GET(SalesLine."Sell-to Customer No.");
                    SalesForecast."Customer Name" := Customer.Name;
                    case SalesLine.Type of
                        SalesLine.Type::Item:
                            begin
                                DimensionSetEntry.RESET();
                                DimensionSetEntry.SETRANGE("Dimension Set ID", SalesLine."Dimension Set ID");
                                DimensionSetEntry.SETRANGE("Dimension Code", GeneralLedgerSetup."Brand Dimension Code FND");
                                if DimensionSetEntry.FINDFIRST() then begin
                                    SalesForecast."Brand Code" := DimensionSetEntry."Dimension Value Code";
                                    DimensionSetEntry.CALCFIELDS("Dimension Value Name");
                                    SalesForecast."Brand Code Name" := DimensionSetEntry."Dimension Value Name";
                                end;
                                //SalesForecast.Volume := (SalesLine.Quantity - SalesLine."Quantity Invoiced") * SalesLine."Unit Volume HL";  // BC Upgrade NANDIS03 - blocked as DIT field
                                LineAmount := (SalesLine.Quantity - SalesLine."Quantity Invoiced") * SalesLine."Unit Price";
                                if SalesHeader."Prices Including VAT" then begin
                                    SalesForecast."Sales Price (WithOut VAT)" := ROUND(LineAmount - (LineAmount * (SalesLine."VAT %" / 100)), 2);
                                end else begin
                                    SalesForecast."Sales Price (WithOut VAT)" := LineAmount;
                                end;
                                if RoyaltyFeeSetup.GET(SalesForecast."Brand Code") then begin
                                    //SalesForecast."Royalty Amount LCY" := ROUND(SalesForecast."Sales Price (WithOut VAT)" * (RoyaltyFeeSetup."Royalty %" / 100) * (SalesLine.Quantity - SalesLine."Quantity Invoiced"),2);;
                                    // SalesForecast."Know-How Amount LCY" := ROUND(SalesForecast."Sales Price (WithOut VAT)" * (SalesReceivablesSetup."Know - How Fee % FND" / 100) * (SalesLine.Quantity - SalesLine."Quantity Invoiced"),2);
                                    SalesForecast."Royalty Amount LCY" := ROUND(SalesForecast."Sales Price (WithOut VAT)" * (RoyaltyFeeSetup."Royalty %" / 100), 2);
                                    ;
                                    SalesForecast."Know-How Amount LCY" := ROUND(SalesForecast."Sales Price (WithOut VAT)" * (SalesReceivablesSetup."Know - How Fee % FND" / 100), 2);
                                end;
                                SalesForecast."Currency Code" := 'EUR';
                                CurrencyExchangeRate.RESET();
                                CurrencyExchangeRate.SETFILTER("Currency Code", 'EUR');
                                CurrencyExchangeRate.SETFILTER("Starting Date", '<=%1', TODAY);
                                if CurrencyExchangeRate.FINDLAST() then begin
                                    //IF CurrencyExchangeRate.GET('EUR',TODAY) THEN BEGIN
                                    Currency.GET('EUR');
                                    SalesForecast."Royalty Amount EUR" := ROUND(SalesForecast."Royalty Amount LCY" / CurrencyExchangeRate."Relational Exch. Rate Amount", Currency."Unit-Amount Rounding Precision");
                                    SalesForecast."Know-How Amount EUR" := ROUND(SalesForecast."Know-How Amount LCY" / CurrencyExchangeRate."Relational Exch. Rate Amount", Currency."Unit-Amount Rounding Precision");
                                end;
                            end;
                        SalesLine.Type::"G/L Account":
                            begin
                                //SalesForecast.Volume := (SalesLine.Quantity - SalesLine."Quantity Invoiced") * SalesLine."Unit Volume HL";  // BC Upgrade NANDIS03 - blocked as DIT field
                                LineAmount := (SalesLine.Quantity - SalesLine."Quantity Invoiced") * SalesLine."Unit Price";
                                if SalesHeader."Prices Including VAT" then begin
                                    SalesForecast."Sales Price (WithOut VAT)" := ROUND(LineAmount - (LineAmount * (SalesLine."VAT %" / 100)), 2);
                                end else begin
                                    SalesForecast."Sales Price (WithOut VAT)" := LineAmount;
                                end;
                                RoyaltyFeeSetup.RESET();
                                if RoyaltyFeeSetup.FINDFIRST() then begin
                                    SalesForecast."Know-How Amount LCY" := ROUND(SalesForecast."Sales Price (WithOut VAT)" * (SalesReceivablesSetup."Know - How Fee % FND" / 100), 2);
                                end;
                                SalesForecast."Currency Code" := 'EUR';
                                CurrencyExchangeRate.RESET();
                                CurrencyExchangeRate.SETFILTER("Currency Code", 'EUR');
                                CurrencyExchangeRate.SETFILTER("Starting Date", '<=%1', TODAY);
                                if CurrencyExchangeRate.FINDLAST() then begin
                                    Currency.GET('EUR');
                                    SalesForecast."Know-How Amount EUR" := ROUND(SalesForecast."Know-How Amount LCY" / CurrencyExchangeRate."Relational Exch. Rate Amount", Currency."Unit-Amount Rounding Precision");
                                end;
                            end;
                    end;
                    SalesForecast.INSERT();
                end;
            //end;
            // BC Upgrade MISHRS14<<

            until SalesLine.NEXT() = 0;
        //HEI.24<<
        if LineNo <> 0 then
            exit(LineNo);
    end;

    local procedure GetSalesForCP(Period: Text);
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        SalesForecast: Record "Sales Forecast FND";
        DateFilter: Date;
        EndDate: Date;
        StartDate: Date;
        SalesForecastLineNo: Integer;
    begin
        //HEI.24>>
        GeneralLedgerSetup.GET();
        SalesReceivablesSetup.GET();
        SalesReceivablesSetup.TESTFIELD("Know - How Fee % FND");
        SalesForecast.SETFILTER("Due Date", Period);
        DateFilter := SalesForecast.GETRANGEMIN("Due Date");

        StartDate := CALCDATE('-CM', DateFilter);
        EndDate := CALCDATE('CM - 6D', DateFilter);
        SalesForecastLineNo := GetPostedSalesInv(StartDate, EndDate, 10000);
        SalesForecastLineNo := GetPostedSalesCrMemo(StartDate, EndDate, SalesForecastLineNo);
        SalesForecastLineNo := GetOpenSales(EndDate, CALCDATE('CM', DateFilter), SalesForecastLineNo);
        //HEI.24<<
    end;

    procedure ValidateVendBankAccFields(VendorNo: Code[20]; VendBankAccNo: Code[20]);
    var
        CountryRegion: Record "Country/Region";
        VendorBankAccount: Record "Vendor Bank Account";
    begin
        // HEI.25>>
        if VendorBankAccount.GET(VendorNo, VendBankAccNo) then begin
            VendorBankAccount.TESTFIELD(Code);
            VendorBankAccount.TESTFIELD(Name);
            //HEI.124>>
            PurchasesPayablesSetup.GET();
            if PurchasesPayablesSetup."Disable VendorBankAddCheck FND" = false then
                //HEI.124<<
                VendorBankAccount.TESTFIELD(Address);
            VendorBankAccount.TESTFIELD("Country/Region Code");
            //HEI.115>>
            if CountryRegion.GET(VendorBankAccount."Country/Region Code") then begin
                if CountryRegion."IBAN Country/Region FND" then begin
                    //HEI.115<<
                    VendorBankAccount.TESTFIELD(IBAN);
                    VendorBankAccount.TESTFIELD("SWIFT Code");
                    VendorBankAccount.TESTFIELD("Bank Branch No.");
                    VendorBankAccount.TESTFIELD("Bank Account No.");
                    //HEI.115>>
                end;
            end;
            //HEI.115<<
        end;
        // HEI.25<<
    end;  // BC Upgrade NANDIS03

    procedure CustomerAddressFormat(Customer: Record Customer; var CustAddr: array[4] of Text): Text;
    var
        CountryRegion: Record "Country/Region";
        CustomerAttributes: Record "Customer Attributes FND";
        i: Integer;
    begin
        CustomerAttributes.GET(Customer."No.");
        if CountryRegion.GET(Customer."Country/Region Code") then;
        CustAddr[1] := Customer.Name;
        CustAddr[2] := CustomerAttributes."House No. 1" + ' ' + CustomerAttributes."House Supplement 2" + ' ' + CustomerAttributes."Street 3";
        CustAddr[3] := Customer."Address 2" + ' ' + Customer.Address + ' ' + CustomerAttributes."Street 4" + ' ' + CustomerAttributes."Street 5";
        CustAddr[4] := Customer."Post Code" + ' ' + CustomerAttributes.District + ' ' + CountryRegion.Name;
    end;

    procedure VendorAddressFormat(Vendor: Record Vendor; var VendAddr: array[4] of Text): Text;
    var
        CountryRegion: Record "Country/Region";
    begin
        CountryRegion.GET(Vendor."Country/Region Code");
        VendAddr[1] := Vendor.Name;
        VendAddr[2] := Vendor."House Number FND" + ' ' + Vendor."House Number Supplement FND" + ' ' + Vendor."Street 3 FND";
        VendAddr[3] := Vendor."Address 2" + ' ' + Vendor.Address + ' ' + Vendor."Street 3 FND" + ' ' + Vendor."Street 5 FND";
        VendAddr[4] := Vendor."Post Code" + ' ' + Vendor."District FND" + ' ' + CountryRegion.Name;
    end;

    // procedure PrintDeliveryNoteFromRoutePlanning(RouteNo : Code[20]);
    // var
    //     RoutePlanningRequest : Record "Route Planning Request";
    //     SalesInvHeader : Record "Sales Invoice Header";
    //     SIH : Record "Sales Invoice Header";
    //     SalesHeader : Record "Sales Header";
    // begin
    //     //HEI.27>>
    //     CLEAR(PostedWhseShipmentList);
    //     RoutePlanningRequest.RESET;
    //     RoutePlanningRequest.SETRANGE("Route Planning No.",RouteNo);
    //     if RoutePlanningRequest.findset then
    //       repeat
    //         case RoutePlanningRequest."Source Document Type" of
    //           RoutePlanningRequest."Source Document Type"::"S.Order":
    //             begin
    //               if SalesHeader.GET(SalesHeader."Document Type"::Order,RoutePlanningRequest."Source No.") then
    //                 if SalesHeader."Posted Warehouse Shipment No." <> '' then
    //                   SetPostedWhseShipmentFilter(SalesHeader."Posted Warehouse Shipment No.");
    //             end;
    //            RoutePlanningRequest."Source Document Type"::"S.Return Order":
    //             begin
    //               if SalesHeader.GET(SalesHeader."Document Type"::"Return Order",RoutePlanningRequest."Source No.") then
    //                 if SalesHeader."Posted Warehouse Shipment No." <> '' then
    //                   SetPostedWhseShipmentFilter(SalesHeader."Posted Warehouse Shipment No.");
    //             end;
    //         end;

    //       until RoutePlanningRequest.NEXT = 0;

    //     SalesInvHeader.RESET;
    //     SalesInvHeader.SETFILTER(SalesInvHeader."Posted Warehouse Shipment No.",PostedWhseShipmentList);
    //     if SalesInvHeader.findset then
    //       repeat
    //         SIH.SETRANGE(SIH."No.",SalesInvHeader."No.");
    //         REPORT.RUN(REPORT::"Delivery Note PAN",true,false,SIH)
    //       until SalesInvHeader.NEXT = 0;
    //     //HEI.27<<
    // end;  // BC Upgrade NANDIS03 - blocked as dependency on DIT

    local procedure SetPostedWhseShipmentFilter(PostedWhseShipmentNo: Code[20]);
    var
        TempAgingBandBuffer: Record "Aging Band Buffer" temporary;
    begin
        //HEI.27>>
        if not TempAgingBandBuffer.GET(PostedWhseShipmentNo) then begin
            TempAgingBandBuffer.INIT();
            TempAgingBandBuffer."Currency Code" := PostedWhseShipmentNo;
            TempAgingBandBuffer.INSERT();

            if PostedWhseShipmentList = '' then begin
                PostedWhseShipmentList += PostedWhseShipmentNo;
            end else begin
                PostedWhseShipmentList += '|' + PostedWhseShipmentNo;
            end;
        end;
        //HEI.27<
    end;

    procedure UpdateVendorLedgerEntry2(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.");
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        //HEI.28>>
        VendorLedgerEntry.RESET();
        VendorLedgerEntry.SETRANGE("Document No.", PurchCrMemoHdr."No.");
        VendorLedgerEntry.SETRANGE("Posting Date", PurchCrMemoHdr."Posting Date");
        if VendorLedgerEntry.FINDFIRST() then begin
            VendorLedgerEntry."Payment Status FND" := PurchCrMemoHdr."Payment Status FND";
            VendorLedgerEntry."Reason Code" := PurchCrMemoHdr."Reason Code";
            VendorLedgerEntry."Status Date FND" := PurchCrMemoHdr."Status Date FND";
            VendorLedgerEntry."Payment User FND" := PurchCrMemoHdr."Payment User FND";
            VendorLedgerEntry.MODIFY();
        end;
        //HEI.28<<
    end;

    [EventSubscriber(ObjectType::Table, 124, 'OnAfterValidateEvent', 'Payment Status FND', false, false)]
    local procedure T124OnAfterValidatePaymentStatus(var Rec: Record "Purch. Cr. Memo Hdr."; var xRec: Record "Purch. Cr. Memo Hdr."; CurrFieldNo: Integer);
    begin
        //HEI.28>>
        if Rec."Payment Status FND" <> xRec."Payment Status FND" then begin
            CLEAR(Rec."Reason Code");
            Rec.VALIDATE("Status Date FND", TODAY);
            Rec.VALIDATE("Payment User FND", USERID);
            UpdateVendorLedgerEntry2(Rec);
        end;
        //HEI.28<<
    end;

    procedure InsertPurchaseHeaderExt(DocType: Option "Posted Invoice","Posted Cr. Memo","Posted Receipt"; DocNo: Code[20]; OnholdUserId: Code[50]; OnHoldDate: Date);
    var
        PurchaseHeaderExtension: Record "Purchase Additional Fields FND";
    begin
        //HEI.29>>
        PurchaseHeaderExtension.INIT();
        case DocType of
            DocType::"Posted Cr. Memo":
                begin
                    PurchaseHeaderExtension.TableID := 124;
                    PurchaseHeaderExtension."Document Type" := PurchaseHeaderExtension."Document Type"::"Posted Cr. Memo";
                end;
            DocType::"Posted Invoice":
                begin
                    PurchaseHeaderExtension.TableID := 122;
                    PurchaseHeaderExtension."Document Type" := PurchaseHeaderExtension."Document Type"::"Posted Invoice";
                end;
            DocType::"Posted Receipt":
                begin
                    PurchaseHeaderExtension.TableID := 120;
                    PurchaseHeaderExtension."Document Type" := PurchaseHeaderExtension."Document Type"::"Posted Receipt";
                end;
        end;

        PurchaseHeaderExtension."Document No." := DocNo;
        PurchaseHeaderExtension."On Hold Date" := OnHoldDate;
        PurchaseHeaderExtension."On Hold UserID" := OnholdUserId;
        PurchaseHeaderExtension.INSERT();
        //HEI.29<<
    end;

    procedure DeletePurchHeaderExt(TableID: Integer; PurchaseHeader: Record "Purchase Header");
    var
        PurchaseHeaderExtension: Record "Purchase Additional Fields FND";
    begin
        //HEI.29>>
        PurchaseHeaderExtension.SETRANGE(TableID, 38);
        PurchaseHeaderExtension.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchaseHeaderExtension.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseHeaderExtension.DELETEALL();
        //HEI.29<<
    end;

    procedure InsertPurchHeaderExtFromPO(PurchaseHeader: Record "Purchase Header"; OnHoldUserID: Code[50]; OnHoldDate: Date);
    var
        PurchaseHeaderExtension: Record "Purchase Additional Fields FND";
    begin
        //HEI.29>>
        PurchaseHeaderExtension.RESET();
        if not PurchaseHeaderExtension.GET(38, PurchaseHeader."Document Type", PurchaseHeader."No.") then begin

            // BC Upgrade MISHRS14 >>
            // Blocked with statement and prefixed variables with PurchaseHeaderExtension.
            //with PurchaseHeaderExtension do begin
            PurchaseHeaderExtension.INIT();
            PurchaseHeaderExtension.TableID := 38;
            PurchaseHeaderExtension."Document Type" := PurchaseHeader."Document Type".AsInteger();
            PurchaseHeaderExtension."Document No." := PurchaseHeader."No.";
            PurchaseHeaderExtension."On Hold Date" := OnHoldDate;
            PurchaseHeaderExtension."On Hold UserID" := OnHoldUserID;
            PurchaseHeaderExtension.INSERT();

            //end;
        end else begin
            //with PurchaseHeaderExtension do begin
            PurchaseHeaderExtension."On Hold Date" := OnHoldDate;
            PurchaseHeaderExtension."On Hold UserID" := OnHoldUserID;
            PurchaseHeaderExtension.MODIFY();
            //end;
            // BC Upgrade MISHRS14<<

        end;


        //HEI.29<<
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Reason Code', false, false)]
    procedure OnAfterValidateReasonCodePurchaseHeader(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    begin
        //HEI.29>>
        if Rec."Reason Code" <> '' then begin
            Rec."On Hold" := 'HLD';
            InsertPurchHeaderExtFromPO(Rec, USERID, TODAY);

        end else begin
            Rec."On Hold" := '';
            InsertPurchHeaderExtFromPO(Rec, '', 0D);
        end;
        Rec.CALCFIELDS("On Hold Date FND", "On Hold UserID FND");
        //HEI.29<<
    end;

    procedure OnAfterCopyDocumentPurchaseHeader(var Rec: Record "Purchase Header");
    begin
        //HEI.29>>
        if Rec."Reason Code" <> '' then begin
            Rec."On Hold" := 'HLD';
            InsertPurchHeaderExtFromPO(Rec, USERID, TODAY);

        end else begin
            Rec."On Hold" := '';
            InsertPurchHeaderExtFromPO(Rec, '', 0D);
        end;
        Rec.CALCFIELDS("On Hold Date FND", "On Hold UserID FND");
        //HEI.29<<
    end;

    [EventSubscriber(ObjectType::Table, 25, 'OnAfterValidateEvent', 'Reason Code', false, false)]
    procedure OnAfterValidateReasonCodeVendLedgEntry(var Rec: Record "Vendor Ledger Entry"; var xRec: Record "Vendor Ledger Entry"; CurrFieldNo: Integer);
    begin
        //HEI.29>>
        //>DS_001 09/04/18 Temporary patch. Dragos to review it
        //Rec.TESTFIELD("Batch payment name",'');
        //<DS_001
        if Rec."Reason Code" <> '' then begin
            Rec."On Hold" := 'HLD';
            Rec."On Hold Date FND" := TODAY;
            Rec."On Hold UserID FND" := USERID;
        end else begin
            Rec."On Hold" := '';
            Rec."On Hold Date FND" := 0D;
            Rec."On Hold UserID FND" := '';
        end;
        //HEI.29<<
    end;

    procedure OnBeforePostPaymentJournalTreeJournal(var GenJournalLine: Record "Gen. Journal Line");
    var
        OldPostingDate: Date;
        Text001: Label 'Do you want to update the posting date with current date?';
    begin
        //HEI.30>>
        OldPostingDate := GenJournalLine."Posting Date";
        //<<HEI.96
        if GUIALLOWED then begin
            //>>HEI.96
            if CONFIRM(Text001) then begin
                GenJournalLine.MODIFYALL("Posting Date", TODAY, false);
                GenJournalLine.MODIFYALL("Document Date", OldPostingDate, false);
            end else
                exit;
            //HEI.30<<
            //<<HEI.96
        end else begin
            GenJournalLine.MODIFYALL("Posting Date", TODAY, false);
            GenJournalLine.MODIFYALL("Document Date", OldPostingDate, false);
        end;
        //>>HEI.96
    end;

    procedure CheckPaymentJouralTreeLines(GenJournalLine: Record "Gen. Journal Line");
    var
        GenJournalLine2: Record "Gen. Journal Line";
        Error1: Label 'Suggest Vendor Payment action is blocked.Delete the lines and try again!';
    begin
        //HEI.30>>
        GenJournalLine2.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
        GenJournalLine2.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
        if not GenJournalLine2.ISEMPTY then
            ERROR(Error1);
        //HEI.30<<
    end;

    // procedure ValidateNegativeConsumptionQty_New(ItemJournallLine : Record "Item Journal Line");
    // var
    //     ItemJrlLine : Record "Item Journal Line";
    //     Qty : Decimal;
    //     ILE : Record "Item Ledger Entry";
    //     Error001 : Label 'Negative consumption is more than posted consumption(s) value in the Item Ledger Entries of item %1, Lot Number %2 on production order %3';
    //     LotNo1 : Code[20];
    //     QualityManagement : Codeunit "Quality Management";
    //     ReservEntry : Record "Reservation Entry";
    //     TempReserveEntryLotNo : Code[20];
    //     TempReserveEntryQty : Decimal;
    //     Cnt : Integer;
    //     ReservEntry1 : Record "Reservation Entry";
    //     Error002 : Label 'You cannot post a correction on Lot No. %1 as the consumption is posted for a different Lot No.';
    // begin
    //     //>> HEI.09
    //     ItemJrlLine.RESET;
    //     ItemJrlLine.SETCURRENTKEY("Entry Type","Document No.","Posting Date");
    //     ItemJrlLine.SETRANGE(ItemJrlLine."Entry Type",ItemJournallLine."Entry Type"::Consumption);
    //     ItemJrlLine.SETRANGE(ItemJrlLine."Document No.",ItemJournallLine."Document No.");
    //     ItemJrlLine.SETRANGE(ItemJrlLine."Posting Date",ItemJournallLine."Posting Date");

    //     if ItemJrlLine.findset then
    //       repeat
    //         LotNo1 := QualityManagement.GetItemJnlLineLotNo(ItemJrlLine);
    //         if (ItemJrlLine.Quantity < 0) then begin
    //           if (LotNo1 = 'MULTIPLE') then begin
    //               ReservEntry.RESET;
    //               ReservEntry.SETCURRENTKEY("Source ID","Source Ref. No.","Item No.","Source Batch Name","Creation Date","Location Code","Source Type","Source Subtype","Lot No.");
    //               ReservEntry.SETRANGE("Source ID",ItemJrlLine."Journal Template Name");
    //               ReservEntry.SETRANGE("Source Ref. No.", ItemJrlLine."Line No.");
    //               ReservEntry.SETRANGE("Item No.", ItemJrlLine."Item No.");
    //               ReservEntry.SETRANGE("Source Batch Name",ItemJrlLine."Journal Batch Name");
    //               ReservEntry.SETRANGE("Creation Date", ItemJrlLine."Posting Date");
    //               ReservEntry.SETRANGE("Location Code",ItemJrlLine."Location Code");
    //               ReservEntry.SETRANGE("Source Type",83);
    //               ReservEntry.SETRANGE("Source Subtype",5);
    //               ReservEntry.SETFILTER("Lot No.",'<>%1','');
    //               if ReservEntry.findset then
    //                 repeat
    //                   TempReserveEntryLotNo := '';
    //                   TempReserveEntryQty := 0;

    //                   ReservEntry1.RESET;
    //                   ReservEntry1.SETCURRENTKEY("Source ID","Source Ref. No.","Item No.","Source Batch Name","Creation Date","Location Code","Source Type","Source Subtype","Lot No.");
    //                   ReservEntry1.SETRANGE("Source ID",ReservEntry."Source ID");
    //                   ReservEntry1.SETRANGE("Source Ref. No.", ReservEntry."Source Ref. No.");
    //                   ReservEntry1.SETRANGE("Item No.", ReservEntry."Item No.");
    //                   ReservEntry1.SETRANGE("Source Batch Name",ReservEntry."Source Batch Name");
    //                   ReservEntry1.SETRANGE("Creation Date", ReservEntry."Creation Date");
    //                   ReservEntry1.SETRANGE("Location Code",ReservEntry."Location Code");
    //                   ReservEntry1.SETRANGE("Source Type",83);
    //                   ReservEntry1.SETRANGE("Source Subtype",5);
    //                   ReservEntry1.SETRANGE("Lot No.",ReservEntry."Lot No.");
    //                   if ReservEntry1.findset then
    //                     begin
    //                     repeat
    //                       TempReserveEntryLotNo := ReservEntry."Lot No.";
    //                       TempReserveEntryQty += ReservEntry."Quantity (Base)";
    //                     until ReservEntry1.NEXT = 0;

    //                       Qty :=0;
    //                       ILE.RESET;
    //                       ILE.SETCURRENTKEY("Entry Type","Document No.","Item No.","Lot No.","Location Code");
    //                       ILE.SETRANGE(ILE."Entry Type", ItemJrlLine."Entry Type"::Consumption);
    //                       ILE.SETRANGE(ILE."Document No.",ItemJrlLine."Document No.");
    //                       ILE.SETRANGE(ILE."Item No.",ItemJrlLine."Item No.");
    //                       ILE.SETRANGE(ILE."Lot No.",TempReserveEntryLotNo);
    //                       ILE.SETRANGE(ILE."Location Code",ItemJrlLine."Location Code");
    //                       if ILE.findset then
    //                        repeat
    //                         Qty += ILE.Quantity;
    //                        until ILE.NEXT= 0;
    //                         //IF (ABS(ItemJrlLine.Quantity) > ABS(TempReserveEntryQty)) THEN
    //                         if (ABS(TempReserveEntryQty) > ABS(Qty)) then
    //                           ERROR(Error001,ILE."Item No.",ILE."Lot No.",ILE."Document No.");
    //                      end;
    //                   until ReservEntry.NEXT =0;

    //           end else
    //           begin
    //             Qty :=0;

    //             //1. IF the item @ ILE Exists and item same lot number found in ILE should be allowed to post.
    //             //2. IF the item with different lot number found in ILE should'nt allowed to post.
    //             //3. IF the item not found in the ILE shoudl be allowed to post.

    //             ILE.RESET;
    //             ILE.SETCURRENTKEY("Entry Type","Document No.","Item No.","Lot No.","Location Code");
    //             ILE.SETRANGE(ILE."Entry Type", ItemJrlLine."Entry Type"::Consumption);
    //             ILE.SETRANGE(ILE."Document No.",ItemJrlLine."Document No.");
    //             ILE.SETRANGE(ILE."Item No.",ItemJrlLine."Item No.");
    //             // Issue 720 fix isyed01 IBM>>
    //             ILE.SETRANGE(ILE."Lot No.",LotNo1);   //Commented Removed for Defect 1931
    //             // Issue 720 fix isyed01 IBM<<
    //             ILE.SETRANGE(ILE."Location Code",ItemJrlLine."Location Code");
    //             if ILE.findset then
    //             begin
    //             repeat
    //               Qty += ILE.Quantity;
    //             until ILE.NEXT= 0;
    //             if (ABS(ItemJrlLine.Quantity) > ABS(Qty)) then
    //                 ERROR(Error001,ILE."Item No.",ILE."Lot No.",ILE."Document No.");
    //             // Issue 720 fix isyed01 IBM>> //2. code below will take care of Senaroi 1,2.
    //             // IF LotNo1 <> ILE."Lot No." THEN
    //             //  ERROR(Error002,LotNo1);
    //             // Issue 720 fix isyed01 IBM<<

    //             end else  //Latest Code Added #113
    //             //out side of this condition code will take care of Senaroi 3.

    //              //Isyed01 #627>> - Commented by syed Since if there is no consumption available in ILE there user should be able to post the Prod Jounral.
    //              //>>Latest Code Added #113
    //              begin
    //                 ILE.RESET;
    //                 ILE.SETCURRENTKEY("Entry Type","Document No.","Item No.","Lot No.","Location Code");

    //                 ILE.SETRANGE(ILE."Entry Type", ItemJrlLine."Entry Type"::Consumption);
    //                 ILE.SETRANGE(ILE."Document No.",ItemJrlLine."Document No.");
    //                 ILE.SETRANGE(ILE."Item No.",ItemJrlLine."Item No.");
    //                 ILE.SETRANGE(ILE."Location Code",ItemJrlLine."Location Code");
    //                 if ILE.FINDFIRST then begin
    //                   if LotNo1 <> ILE."Lot No." then
    //                      ERROR(Error002,LotNo1);
    //                end;
    //                end;
    //              //<<Latest Code Added #113
    //            end;
    //           end;
    //         until ItemJrlLine.NEXT = 0;
    //     //<< HEI.09
    // end;  // BC Upgrade NANDIS03 - blocked as dependency on DIT

    procedure NegativeConsumptionCatgryCode(ItemJrlLine: Record "Item Journal Line") AllowJNLPosting: Boolean;
    var
        Item: Record Item;
        ItemLedgerEntry: Record "Item Ledger Entry";
        ILERecNotFound: Boolean;
    begin
        //HEI.31<<
        ItemJrlLine.RESET();
        ItemJrlLine.SETCURRENTKEY("Entry Type", "Document No.", "Posting Date");
        ItemJrlLine.SETRANGE(ItemJrlLine."Entry Type", ItemJrlLine."Entry Type"::Consumption);
        ItemJrlLine.SETRANGE(ItemJrlLine."Document No.", ItemJrlLine."Document No.");
        ItemJrlLine.SETRANGE(ItemJrlLine."Posting Date", ItemJrlLine."Posting Date");
        ILERecNotFound := true;
        if ItemJrlLine.findset() then begin
            repeat
                if ItemJrlLine.Quantity < 0 then begin  //HEI.70
                    ItemLedgerEntry.RESET();
                    ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Document No.", "Item No.", "Lot No.", "Location Code");
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemJrlLine."Entry Type"::Consumption);
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document No.", ItemJrlLine."Document No.");
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", ItemJrlLine."Item No.");
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Location Code", ItemJrlLine."Location Code");
                    if not ItemLedgerEntry.findset() then begin
                        repeat

                            ILERecNotFound := false

                  until ItemLedgerEntry.NEXT() = 0;
                    end;
                    if not ILERecNotFound then begin
                        if ItemJrlLine.Quantity < 0 then begin
                            if Item.GET(ItemJrlLine."Item No.") then begin
                                if not ((Item."Item Category Code" = '05') or (Item."Item Category Code" = '08') or (Item."Item Category Code" = '10')) then
                                    ERROR(Error009, Item."Item Category Code")
                                else if ((Item."Item Category Code" = '05') or (Item."Item Category Code" = '08') or (Item."Item Category Code" = '10')) then
                                    AllowJNLPosting := true;
                            end
                        end
                    end
                end;  //HEI.70

            until ItemJrlLine.NEXT() = 0;
        end
        //HEI.31<<
    end;

    procedure FormatAddrLocation(var AddrArray: array[8] of Text[60]; var Location: Record Location);
    var
        FormatAddress: Codeunit "Format Address";
    begin
        //CH

        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variables with Location.
        //with Location do
        FormatAddress.FormatAddr(
          AddrArray, Location.Name, Location."Name 2", Location.Contact, Location.Address, Location."Address 2",
          Location.City, Location."Post Code", Location.County, Location."Country/Region Code");

        // BC Upgrade MISHRS14 <<     

    end;

    // [EventSubscriber(ObjectType::Table, 472, 'OnBeforeModifyEvent', '', false, false)]
    // local procedure OnBeforeModifyJobQueueEntry(var Rec: Record "Job Queue Entry"; var xRec: Record "Job Queue Entry"; RunTrigger: Boolean);
    // begin
    //     //HEI.33>>
    //     GetGeneralInterfaceSetup;
    //     //HEI.113>>
    //     /*
    //     IF (Rec."Job Queue Category Code" = 'NOTIFYNOW') AND
    //        (GeneralInterfaceSetup."Interface Job Queue User ID" <> '')
    //     */
    //     if (GeneralInterfaceSetup."Interface Job Queue User ID" <> '')
    //     //HEI.113<<
    //     then
    //         Rec."User ID" := GeneralInterfaceSetup."Interface Job Queue User ID";
    //     //HEI.33<<
    // end;  // BC Upgrade NANDIS03 - Function moved to Interface extension

    // [EventSubscriber(ObjectType::Table, 2000000175, 'OnBeforeInsertEvent', '', false, false)]
    // local procedure OnBeforeInsertScheduledTask(var Rec: Record "Scheduled Task"; RunTrigger: Boolean);
    // var
    //     User: Record User;
    //     JobQueueEntry: Record "Job Queue Entry";
    //     RecRef: RecordRef;
    // begin
    //     //HEI.33>>
    //     GetGeneralInterfaceSetup;
    //     RecRef.GET(Rec.Record);
    //     if RecRef.NUMBER = DATABASE::"Job Queue Entry" then begin
    //         RecRef.SETRECFILTER;
    //         JobQueueEntry.SETVIEW(RecRef.GETVIEW);
    //         if JobQueueEntry.FINDFIRST then
    //             //HEI.113>>
    //             /*
    //             IF (JobQueueEntry."Job Queue Category Code" = 'NOTIFYNOW') AND
    //                (GeneralInterfaceSetup."Interface Job Queue User ID" <> '')
    //             */
    //         if (GeneralInterfaceSetup."Interface Job Queue User ID" <> '') then begin
    //                 //HEI.113<<
    //                 User.SETRANGE("User Name", GeneralInterfaceSetup."Interface Job Queue User ID");
    //                 if User.FINDFIRST then begin
    //                     Rec."User ID" := User."User Security ID";
    //                     Rec."User Name" := User."User Name";
    //                 end;
    //             end;
    //     end;
    //     //HEI.33<<
    // end;  // BC Upgrade NANDIS03 - Function moved to Interface extension

    // local procedure GetGeneralInterfaceSetup();
    // begin
    //     //HEI.33>>
    //     if not GeneralInterfaceSetupRead then
    //         GeneralInterfaceSetup.GET;
    //     GeneralInterfaceSetupRead := true;
    //     //HEI.33<<
    // end;  // BC Upgrade NANDIS03 - Function moved to Interface extension

    [EventSubscriber(ObjectType::Table, 122, 'OnAfterValidateEvent', 'Reason Code', false, false)]
    procedure OnAfterValidateReasonCodePurchaseInvoiceHeader(var Rec: Record "Purch. Inv. Header"; var xRec: Record "Purch. Inv. Header"; CurrFieldNo: Integer);
    var
        PurchaseHeaderExtension: Record "Purchase Additional Fields FND";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        DocType: Option "Posted Invoice","Posted Cr. Memo","Posted Receipt";
        DocTypeExt: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Posted Receipt","Posted Invoice","Posted Cr. Memo";
    begin
        //HEI.36>>
        if Rec."Reason Code" <> '' then begin
            Rec."On Hold" := 'HLD';
            if PurchaseHeaderExtension.GET(122, DocTypeExt::"Posted Invoice", Rec."No.") then begin
                PurchaseHeaderExtension."On Hold UserID" := USERID;
                PurchaseHeaderExtension."On Hold Date" := TODAY;
                PurchaseHeaderExtension.MODIFY();
            end else
                InsertPurchaseHeaderExt(DocType::"Posted Invoice", Rec."No.", USERID, TODAY);
        end else begin
            Rec."On Hold" := '';
            if PurchaseHeaderExtension.GET(122, DocTypeExt::"Posted Invoice", Rec."No.") then begin
                PurchaseHeaderExtension."On Hold UserID" := '';
                PurchaseHeaderExtension."On Hold Date" := 0D;
                PurchaseHeaderExtension.MODIFY();
            end else
                InsertPurchaseHeaderExt(DocType::"Posted Invoice", Rec."No.", '', 0D);
        end;

        Rec.CALCFIELDS("On Hold Date FND", "On Hold UserID FND");

        VendorLedgerEntry.SETRANGE("Document No.", Rec."No.");
        VendorLedgerEntry.SETRANGE("Posting Date", Rec."Posting Date");
        if VendorLedgerEntry.FINDFIRST() then begin
            VendorLedgerEntry."On Hold" := Rec."On Hold";
            VendorLedgerEntry."On Hold UserID FND" := Rec."On Hold UserID FND";
            VendorLedgerEntry."On Hold Date FND" := Rec."On Hold Date FND";
            VendorLedgerEntry.MODIFY();
        end;
        //HEI.36<<
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnBeforeValidateEvent', 'Shipment Date', false, false)]
    local procedure T36OnBeforeValidateShipmentDate(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer);
    begin
        //HEI.123>>
        if Rec.ISTEMPORARY then
            exit;

        GetSalesSetup();

        if (Rec."Document Type" = Rec."Document Type"::Order) and (Rec."Source System Identifier FND" = '') and
          (Rec.Status = Rec.Status::Released) and SalesSetup."Shipment Date Mandatory FND" then
            Rec.TESTFIELD("Shipment Date");
        //HEI.123<<
    end;

    // [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Route', false, false)]
    // local procedure T36OnAfterValidateRoute(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer);
    // var
    //     Route: Record Route;
    // begin
    //     //HEI.37>>
    //     if Rec.ISTEMPORARY then
    //         exit;
    //     if Route.GET(Rec.Route) then begin
    //         if Route."Salesperson/Purchaser Code" <> '' then
    //             Rec.VALIDATE("Salesperson Code", Route."Salesperson/Purchaser Code");
    //         if Route."Van Sales Route" then
    //             Rec.VALIDATE("Vans Sales Route", Route."Van Sales Route");
    //     end;
    //     //HEI.37<<
    // end;  // BC Upgrade NANDIS03 - Blocked as dependent on DIT

    // [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Route', false, false)]
    // local procedure T38OnAfterValidateRoute(var Rec : Record "Purchase Header";var xRec : Record "Purchase Header";CurrFieldNo : Integer);
    // var
    //     Route : Record Route;
    // begin
    //     //HEI.37>>
    //     if Rec.ISTEMPORARY then
    //       exit;
    //     if Route.GET(Rec.Route) then
    //       if Route."Salesperson/Purchaser Code" <> '' then
    //         Rec.VALIDATE("Purchaser Code",Route."Salesperson/Purchaser Code");
    //     //HEI.37<<
    // end;  // BC Upgrade NANDIS03 - Blocked as dependent on DIT

    // procedure PutWhseReceiptLines(var FromWhseRcptLine : Record "Warehouse Receipt Line");
    // var
    //     FromWhseRcptHeader : Record "Warehouse Receipt Header";
    //     ToWhseRcptHeader : Record "Warehouse Receipt Header";
    //     ToWhseRcptLine : Record "Warehouse Receipt Line";
    //     FromWhseRequest : Record "Warehouse Request";
    //     CustomerDifferencesRPM : Record "Customer Differences RPM FND";
    //     SalesHeader : Record "Sales Header";
    //     Item : Record Item;
    //     WhseSetup : Record "Warehouse Setup";
    //     NoSeriesMgt : Codeunit NoSeriesManagement;
    //     CustomerDifferencesRPMPage : Page "Customer Differences (RPM)";
    //     SalesDepositItemCharge : Record "Sales Deposit Item Charge";
    //     SalesLine : Record "Sales Line";
    // begin
    //     //HEI.47>>
    //     if FromWhseRcptLine.findset then
    //     begin
    //       repeat
    //         CustomerDifferencesRPM.RESET;
    //         CustomerDifferencesRPM.SETRANGE("Item No.",FromWhseRcptLine."Item No.");
    //         CustomerDifferencesRPM.SETRANGE("Sales return order no.",FromWhseRcptLine."No.");
    //         CustomerDifferencesRPM.SETRANGE("Line No.",FromWhseRcptLine."Line No.");
    //         if not CustomerDifferencesRPM.findset then
    //         begin
    //             CustomerDifferencesRPM."Sales return order no.":= FromWhseRcptLine."Source No.";
    //             CustomerDifferencesRPM."Line No." := FromWhseRcptLine."Line No.";
    //             SalesHeader.SETRANGE("Document Type",SalesHeader."Document Type"::"Return Order");
    //             SalesHeader.SETRANGE("No.",FromWhseRcptLine."Source No.");
    //             if SalesHeader.FINDFIRST then
    //             begin
    //               CustomerDifferencesRPM."Sell-to customer no.":= SalesHeader."Sell-to Customer No.";
    //               CustomerDifferencesRPM."Sell-to Customer Name" := SalesHeader."Sell-to Customer Name";
    //               SalesLine.SETRANGE("Document No.", SalesHeader."No.");
    //               if SalesLine.FINDFIRST then
    //                 SalesDepositItemCharge.SETRANGE("Source No.", SalesLine."No.");
    //                 //IF SalesDepositItemCharge.FINDFIRST THEN
    //                  // CustomerDifferencesRPM."Deposit Price" := SalesDepositItemCharge."Unit Price";
    //             end;

    //             CustomerDifferencesRPM."Item No." := FromWhseRcptLine."Item No.";
    //             if Item.GET(FromWhseRcptLine."Item No.") then
    //               begin
    //               CustomerDifferencesRPM."Item Description" := Item.Description;
    //              // CustomerDifferencesRPM."Deposit Price" := Item."Unit Price"; //commented HEI.c
    //               end;

    //             CustomerDifferencesRPM."UOM Code" := FromWhseRcptLine."Unit of Measure Code";
    //             CustomerDifferencesRPM.INSERT;
    //           end
    //         until FromWhseRcptLine.NEXT=0;
    //     end;

    //     //HEI.47>>
    // end;  // BC Upgrade NANDIS03 - Need to move to MtC extension as dependent on table 50218 

    [EventSubscriber(ObjectType::Table, 50072, 'OnAfterValidateEvent', 'Tax Number 1', false, false)]
    local procedure T50072OnAfterValidateTaxNumber1(var Rec: Record "Customer Attributes FND"; var xRec: Record "Customer Attributes FND"; CurrFieldNo: Integer);
    begin
        /*
        //HEI.39>>
        IF Rec."Tax Number 1" = '' THEN
          EXIT;
        CheckCustAttributes(47,Rec."Tax Number 1",Rec.FIELDCAPTION("Tax Number 1"),Rec."Customer No.");
        //HEI.39<<
        */

    end;

    [EventSubscriber(ObjectType::Table, 50072, 'OnAfterValidateEvent', 'Tax Number 2', false, false)]
    local procedure T50072OnAfterValidateTaxNumber2(var Rec: Record "Customer Attributes FND"; var xRec: Record "Customer Attributes FND"; CurrFieldNo: Integer);
    begin
        /*
        //HEI.39>>
        IF Rec."Tax Number 2" = '' THEN
          EXIT;
        CheckCustAttributes(30,Rec."Tax Number 2",Rec.FIELDCAPTION("Tax Number 2"),Rec."Customer No.");
        //HEI.39<<
        */

    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterValidateEvent', 'Customer Description FND', false, false)]
    local procedure T18OnAfterValidateCustomerDescrition(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer);
    var
        Customer: Record Customer;
        ErrorCheckCust: TextConst ENU = 'This %1 has already been entered for the following customers:\ %2', FRA = 'Ce n° identif. intracomm. a déjà été entré pour le client suivant : \%1';
    begin
        /*
        //HEI.39>>
        Customer.SETCURRENTKEY("Customer Description FND");
        Customer.SETFILTER("No.",'<>%1',Rec."No.");
        Customer.SETFILTER("Customer Description FND",'<>%1','');
        IF Customer.findset THEN
          REPEAT
            IF DamerauLevenshtein(Rec."Customer Description FND",Customer."Customer Description FND") = 0 THEN
              ERROR(ErrorCheckCust,Rec.FIELDCAPTION("Customer Description FND"),Customer."No.")
          UNTIL Customer.NEXT = 0;
        //HEI.39<<
        */
    end;

    local procedure CheckCustAttributes(FieldlID: Integer; FieldValue: Text[20]; FieldCaption: Text; Number: Code[20]);
    var
        CustAttributes: Record "Customer Attributes FND";
        Check: Boolean;
        Finish: Boolean;
        t: Text[250];
        ErrorCheckCust: TextConst ENU = 'This %1 has already been entered for the following customers:\ %2', FRA = 'Ce n° identif. intracomm. a déjà été entré pour le client suivant : \%1';
    begin
        //HEI.39>>
        Check := true;
        t := '';
        case FieldlID of
            //FieldlID::"47":  // BC Upgrade NANDIS03
            47:
                begin
                    CustAttributes.SETCURRENTKEY("Tax Number 1");
                    CustAttributes.SETRANGE("Tax Number 1", FieldValue);
                end;
            //FieldlID::"30":  // BC Upgrade NANDIS03
            30:
                begin
                    CustAttributes.SETCURRENTKEY("Tax Number 2");
                    CustAttributes.SETRANGE("Tax Number 2", FieldValue);
                end;
        end;
        CustAttributes.SETFILTER("Customer No.", '<>%1', Number);
        if CustAttributes.FIND('-') then begin
            Check := false;
            Finish := false;
            repeat
                if CustAttributes."Customer No." <> Number then
                    if t = '' then
                        t := CustAttributes."Customer No."
                    else
                        if STRLEN(t) + STRLEN(CustAttributes."Customer No.") + 5 <= MAXSTRLEN(t) then
                            t := t + ', ' + CustAttributes."Customer No."
                        else begin
                            t := t + '...';
                            Finish := true;
                        end;
            until (CustAttributes.NEXT() = 0) or Finish;
        end;
        if Check = false then
            ERROR(ErrorCheckCust, FieldCaption, t);
        //HEI.39<<
    end;  // BC Upgrade NANDIS03

    procedure DamerauLevenshtein(String1: Code[250]; String2: Code[250]): Decimal;
    var
        IsInit: Boolean;
        cost: Decimal;
        Distance: array[1000, 1000] of Decimal;
        i: Integer;
        j: Integer;
    begin
        //HEI.39>>
        String1 := COPYSTR(String1, 1, ARRAYLEN(Distance[1]));
        String2 := COPYSTR(String2, 1, ARRAYLEN(Distance[2]));
        CLEAR(Distance);
        for i := 1 to ARRAYLEN(Distance[1]) do
            Distance[i] [1] := i;
        for j := 1 to ARRAYLEN(Distance[2]) do
            Distance[1] [j] := j;

        for i := 2 to STRLEN(String1) + 1 do begin
            for j := 2 to STRLEN(String2) + 1 do begin
                if String1[i - 1] = String2[j - 1] then
                    cost := 0
                else
                    cost := 1;
                Distance[i] [j] := min(
                  Distance[i - 1] [j] + 1,
                  Distance[i] [j - 1] + 1,
                  Distance[i - 1] [j - 1] + cost);
                if ((i > 3) and (j > 3)) and
                  ((String1[i] = String2[j - 1]) or (String1[i - 1] = String2[j])) then
                    Distance[i] [j] := min(
                      Distance[i] [j],
                      Distance[i - 2, j - 2] + cost,
                      99999);
            end;
        end;

        exit(Distance[STRLEN(String1) + 1] [STRLEN(String2) + 1] - 1);
        //HEI.39<<
    end;

    local procedure "min"(Value1: Decimal; Value2: Decimal; Value3: Decimal): Integer;
    begin
        //HEI.39>>
        if (Value1 <= Value2) and (Value1 <= Value3) then
            exit(Value1);
        if (Value2 <= Value1) and (Value2 <= Value3) then
            exit(Value2);
        exit(Value3);
        //HEI.39<<
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterInsertEvent', '', false, false)]
    local procedure UpdateBRCLocation(var Rec: Record "Purchase Header"; RunTrigger: Boolean);
    var
        GeneralOpCoSetup: Record "General OpCo Setup FND";
    begin
        //HEI.42>>
        if Rec."BRC Purchase Order FND" then begin
            GeneralOpCoSetup.GET();
            GeneralOpCoSetup.TESTFIELD("BRC Location Code");
            Rec."Location Code" := GeneralOpCoSetup."BRC Location Code";
            Rec.MODIFY();
        end;
        //HEI.42<<
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Buy-from Vendor No.', false, false)]
    local procedure UpdateBRCLocOnValidateOfVendor(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    var
        GeneralOpCoSetup: Record "General OpCo Setup FND";
    begin
        //HEI.42>>
        if Rec."BRC Purchase Order FND" then begin
            GeneralOpCoSetup.GET();
            GeneralOpCoSetup.TESTFIELD("BRC Location Code");
            Rec."Location Code" := GeneralOpCoSetup."BRC Location Code";
            Rec.MODIFY();
        end;
        //HEI.42<<
    end;

    [EventSubscriber(ObjectType::Table, 246, 'OnAfterInsertEvent', '', false, false)]
    procedure UpdateBlanketOrderInReqWorksheet(var Rec: Record "Requisition Line"; RunTrigger: Boolean);
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        PurchLine: Record "Purchase Line";
        tempPurchaseLine: Record "Purchase Line" temporary;
        RequisitionLine: Record "Requisition Line";
        Vend1: Record Vendor;
        MaxValidFromDate_Changed: Boolean;
        MinValidToDate_Changed: Boolean;
        P_DocNo: Code[30];
        P_VendNo: Code[30];
        MaxValidFromDate: Date;
        MinValidToDate: Date;
        QtyOnOrders: Decimal;
        P_LineNo: Integer;
    begin
        //AfterInsert  of Req Worksheet
        //HEI.126>>
        if Rec.ISTEMPORARY then
            exit;
        //HEI.126<<
        //<< HEI.43
        PurchaseLine.RESET();
        //HEI.126>>
        PurchaseLine.SETCURRENTKEY("Document Type", "No.", "Block Line Ordering FND", "Unit of Measure Code", "Location Code", "Valid From FND", "Valid To FND", "Blanket Order No.");
        //HEI.126<<
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::"Blanket Order");
        PurchaseLine.SETRANGE("No.", Rec."No.");
        PurchaseLine.SETRANGE("Block Line Ordering FND", PurchaseLine."Block Line Ordering FND"::" ");
        //HEI.126>>
        PurchaseLine.SETRANGE("Unit of Measure Code", Rec."Unit of Measure Code");
        PurchaseLine.SETFILTER("Location Code", '%1|%2', '', Rec."Location Code");
        //HEI.126<<
        PurchaseLine.CALCFIELDS("Valid From FND", "Valid To FND");
        PurchaseLine.SETFILTER("Valid From FND", '<=%1', Rec."Due Date");
        //PurchaseLine.SETFILTER("Valid To FND",'>=%1',Rec."Due Date");
        //HEI.126>>
        //PurchaseLine.SETFILTER("Valid To FND",'>=%1|=%2',Rec."Due Date",0D);
        PurchaseLine.SETFILTER("Valid To FND", '%1|>=%2', 0D, WORKDATE());
        //PurchaseLine.SETRANGE("Location Code",Rec."Location Code");
        //IF PurchaseLine.findset THEN BEGIN
        //PurchaseLine.SETRANGE("Blanket Order No.", Rec."Blanket Order No.");  // BC Upgrade NANDIS03 - field is of DIT
        if PurchaseLine.findset(false) then begin
            //HEI.126<<
            repeat
                //>>NAIKH01 new 27th May
                PurchaseHeader.RESET();
                //HEI.126>>
                PurchaseHeader.SETCURRENTKEY("Document Type", "No.", "Channel FND");
                //HEI.126<<
                PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::"Blanket Order");
                PurchaseHeader.SETRANGE("No.", PurchaseLine."Document No.");
                PurchaseHeader.SETRANGE("Channel FND", 'A');
                if PurchaseHeader.FINDFIRST() then begin
                    //<< NAIKH01 new 27th May
                    //HEI.126>>
                    PurchLine.SETCURRENTKEY("Document Type", "No.", "Blanket Order No.");
                    //HEI.126<<
                    PurchLine.SETFILTER("Document Type", '%1|%2', PurchLine."Document Type"::Order, PurchLine."Document Type"::"Return Order");
                    PurchLine.SETRANGE("No.", PurchaseLine."No.");
                    PurchLine.SETRANGE("Blanket Order No.", PurchaseLine."Document No.");
                    //HEI.126>>
                    //IF PurchLine.findset THEN
                    if PurchLine.findset(false) then
                        //HEI.126<<
                        repeat
                            if PurchLine."Document Type" = PurchLine."Document Type"::Order then
                                QtyOnOrders := QtyOnOrders + PurchLine."Outstanding Qty. (Base)"
                            else
                                if PurchLine."Document Type" = PurchLine."Document Type"::"Return Order" then
                                    QtyOnOrders := QtyOnOrders - PurchLine."Outstanding Qty. (Base)"
                until PurchLine.NEXT() = 0;

                    if Rec.Quantity < (PurchaseLine."Outstanding Qty. (Base)" - QtyOnOrders) then begin
                        tempPurchaseLine.INIT();
                        tempPurchaseLine.COPY(PurchaseLine);
                        tempPurchaseLine.INSERT();
                    end;
                end;
            until PurchaseLine.NEXT() = 0;
        end;

        if tempPurchaseLine.COUNT = 1 then begin
            //Rec."Blanket Order No." := tempPurchaseLine."Document No.";  // BC Upgrade NANDIS03 - field is of DIT
            //Rec."Blanket Order Line No." := tempPurchaseLine."Line No.";  // BC Upgrade NANDIS03 - field is of DIT
            Rec."Vendor No." := tempPurchaseLine."Buy-from Vendor No.";
            Rec.MODIFY();
        end else begin
            //NAIKH01 March 6th    6/21/2019  -- 11/22/2017 | 10/1/2017
            MinValidToDate := 0D;
            if tempPurchaseLine.findset() then
                repeat
                    tempPurchaseLine.CALCFIELDS("Valid To FND");
                    if (tempPurchaseLine."Valid To FND" <> 0D) and ((MinValidToDate = 0D) and
                                                               (MinValidToDate < tempPurchaseLine."Valid To FND")) then begin
                        P_DocNo := tempPurchaseLine."Document No.";
                        P_LineNo := tempPurchaseLine."Line No.";
                        P_VendNo := tempPurchaseLine."Buy-from Vendor No.";
                        if MinValidToDate <> 0D then
                            MinValidToDate_Changed := true;
                        MinValidToDate := tempPurchaseLine."Valid To FND";
                    end else
                        if (MinValidToDate > tempPurchaseLine."Valid To FND") then begin
                            P_DocNo := tempPurchaseLine."Document No.";
                            P_LineNo := tempPurchaseLine."Line No.";
                            P_VendNo := tempPurchaseLine."Buy-from Vendor No.";
                            MinValidToDate_Changed := true;
                            MinValidToDate := tempPurchaseLine."Valid To FND";
                        end;
                until tempPurchaseLine.NEXT() = 0;

            if not MinValidToDate_Changed then begin
                MaxValidFromDate := 0D;
                if tempPurchaseLine.findset() then
                    repeat
                        tempPurchaseLine.CALCFIELDS("Valid From FND");
                        if (tempPurchaseLine."Valid From FND" <> 0D) and ((MaxValidFromDate = 0D) and
                                                                   (MaxValidFromDate < tempPurchaseLine."Valid From FND")) then begin
                            P_DocNo := tempPurchaseLine."Document No.";
                            P_LineNo := tempPurchaseLine."Line No.";
                            P_VendNo := tempPurchaseLine."Buy-from Vendor No.";
                            if MaxValidFromDate <> 0D then
                                MaxValidFromDate_Changed := true;
                            MaxValidFromDate := tempPurchaseLine."Valid From FND";
                        end else   //  11/22/2017 < 10/1/2017
                            if (MaxValidFromDate > tempPurchaseLine."Valid From FND") then begin
                                P_DocNo := tempPurchaseLine."Document No.";
                                P_LineNo := tempPurchaseLine."Line No.";
                                P_VendNo := tempPurchaseLine."Buy-from Vendor No.";
                                MaxValidFromDate_Changed := true;
                                MaxValidFromDate := tempPurchaseLine."Valid From FND";
                            end;
                    until tempPurchaseLine.NEXT() = 0;
            end;


            if not MinValidToDate_Changed then
                if not MaxValidFromDate_Changed then begin
                    tempPurchaseLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                    if tempPurchaseLine.FINDLAST() then begin
                        P_DocNo := tempPurchaseLine."Document No.";
                        P_LineNo := tempPurchaseLine."Line No.";
                        P_VendNo := tempPurchaseLine."Buy-from Vendor No.";
                    end;
                end;
            if Vend1.GET(P_VendNo) then;

            // if P_DocNo <> '' then //HEI.72
            //     Rec."Blanket Order No." := P_DocNo;  // BC Upgrade NANDIS03 - field is of DIT
            // if P_LineNo <> 0 then //HEI.72
            //     Rec."Blanket Order Line No." := P_LineNo;  // BC Upgrade NANDIS03 - field is of DIT
            if P_VendNo <> '' then //HEI.72
                Rec."Vendor No." := P_VendNo;
            if Vend1."Currency Code" <> '' then //HEI.72
                Rec.VALIDATE("Currency Code", Vend1."Currency Code");
            if (P_DocNo <> '') or (P_LineNo <> 0) or (P_VendNo <> '') or (Vend1."Currency Code" <> '') then //HEI.72
                Rec.MODIFY();

        end;

        tempPurchaseLine.DELETEALL();
        //HEI.43>>
    end;

    procedure UpdateBlanketOrderInReqWorksheet_Modify(var Rec: Record "Requisition Line");
    var
        lrec_Item: Record Item;
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        PurchLine: Record "Purchase Line";
        tempPurchaseLine: Record "Purchase Line" temporary;
        RequisitionLine: Record "Requisition Line";
        Vend1: Record Vendor;
        MaxValidFromDate_Changed: Boolean;
        MinValidToDate_Changed: Boolean;
        P_DocNo: Code[30];
        P_VendNo: Code[30];
        MaxValidFromDate: Date;
        MinValidToDate: Date;
        QtyOnOrders: Decimal;
        P_LineNo: Integer;
    begin
        //AfterInsert  of Req Worksheet
        //HEI.126>>
        if Rec.ISTEMPORARY then
            exit;
        //HEI.126<<
        //HEI.107>>
        if lrec_Item.GET(Rec."No.") then begin
            if (Rec."Unit of Measure Code" <> lrec_Item."Base Unit of Measure") then begin
                Rec."Unit of Measure Code" := lrec_Item."Base Unit of Measure";
                Rec.MODIFY();
            end;
        end;
        //HEI.107<<
        //<< HEI.43
        PurchaseLine.RESET();
        //HEI.126>>
        PurchaseLine.SETCURRENTKEY("Document Type", "No.", "Block Line Ordering FND", "Unit of Measure Code", "Location Code", "Valid From FND", "Valid To FND", "Blanket Order No.");
        //HEI.126<<
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::"Blanket Order");
        PurchaseLine.SETRANGE("No.", Rec."No.");
        PurchaseLine.SETRANGE("Block Line Ordering FND", PurchaseLine."Block Line Ordering FND"::" ");
        //HEI.126>>
        PurchaseLine.SETRANGE("Unit of Measure Code", Rec."Unit of Measure Code");
        PurchaseLine.SETFILTER("Location Code", '%1|%2', '', Rec."Location Code");
        //HEI.126<<
        PurchaseLine.CALCFIELDS("Valid From FND", "Valid To FND");
        PurchaseLine.SETFILTER("Valid From FND", '<=%1', Rec."Due Date");
        //PurchaseLine.SETFILTER("Valid To FND",'>=%1',Rec."Due Date");
        //HEI.126>>
        //PurchaseLine.SETFILTER("Valid To FND",'>=%1|=%2',Rec."Due Date",0D);
        PurchaseLine.SETFILTER("Valid To FND", '%1|>=%2', 0D, WORKDATE());
        //HEI.107>>
        //PurchaseLine.SETRANGE("Location Code",Rec."Location Code");
        //PurchaseLine.SETFILTER("Location Code",'%1|%2',Rec."Location Code",'');
        //HEI.107<<
        //IF PurchaseLine.findset THEN BEGIN
        //PurchaseLine.SETRANGE("Blanket Order No.",Rec."Blanket Order No.");  // BC Upgrade NANDIS03 - field is of DIT
        if PurchaseLine.findset(false) then begin
            //HEI.126<<
            repeat
                //>>NAIKH01 new 27th May
                //HEI.107>>
                if CheckUoMOfContracttoItemBaseUoM(PurchaseLine) then begin
                    //HEI.107<<
                    PurchaseHeader.RESET();
                    //HEI.126>>
                    PurchaseHeader.SETCURRENTKEY("Document Type", "No.", "Channel FND");
                    //HEI.126<<
                    PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::"Blanket Order");
                    PurchaseHeader.SETRANGE("No.", PurchaseLine."Document No.");
                    PurchaseHeader.SETRANGE("Channel FND", 'A');
                    if PurchaseHeader.FINDFIRST() then begin
                        //<< NAIKH01 new 27th May
                        //HEI.126>>
                        PurchLine.SETCURRENTKEY("Document Type", "No.", "Blanket Order No.");
                        //HEI.126<<
                        PurchLine.SETFILTER("Document Type", '%1|%2', PurchLine."Document Type"::Order, PurchLine."Document Type"::"Return Order");
                        PurchLine.SETRANGE("No.", PurchaseLine."No.");
                        PurchLine.SETRANGE("Blanket Order No.", PurchaseLine."Document No.");
                        //HEI.126>>
                        //IF PurchLine.findset THEN
                        if PurchLine.findset(false) then
                            //HEI.126<<
                            repeat
                                if PurchLine."Document Type" = PurchLine."Document Type"::Order then
                                    QtyOnOrders := QtyOnOrders + PurchLine."Outstanding Qty. (Base)"
                                else
                                    if PurchLine."Document Type" = PurchLine."Document Type"::"Return Order" then
                                        QtyOnOrders := QtyOnOrders - PurchLine."Outstanding Qty. (Base)"
                  until PurchLine.NEXT() = 0;

                        if Rec.Quantity < (PurchaseLine."Outstanding Qty. (Base)" - QtyOnOrders) then begin
                            tempPurchaseLine.INIT();
                            tempPurchaseLine.COPY(PurchaseLine);
                            tempPurchaseLine.INSERT();
                        end;
                    end;
                    //HEI.107>>
                end;
            //HEI.107<<
            until PurchaseLine.NEXT() = 0;
        end;

        if tempPurchaseLine.COUNT = 1 then begin
            // Rec."Blanket Order No." := tempPurchaseLine."Document No.";  // BC Upgrade NANDIS03 - field is of DIT
            // Rec."Blanket Order Line No." := tempPurchaseLine."Line No.";  // BC Upgrade NANDIS03 - field is of DIT
            Rec."Vendor No." := tempPurchaseLine."Buy-from Vendor No.";
            //HEI.120>>
            if (tempPurchaseLine."Buy-from Vendor No." <> '') then begin
                if Vend1.GET(tempPurchaseLine."Buy-from Vendor No.") then
                    Rec."Vendor Name FND" := Vend1.Name;
            end;
            //HEI.120<<
            //HEI.107>>
            Rec."Currency Code" := tempPurchaseLine."Currency Code";
            UpdatePricefromBlanketOrder(Rec);
            //HEI.107<<
            Rec.MODIFY();
        end else begin
            //NAIKH01 March 6th    6/21/2019  -- 11/22/2017 | 10/1/2017
            MinValidToDate := 0D;
            if tempPurchaseLine.findset() then
                repeat
                    tempPurchaseLine.CALCFIELDS("Valid To FND");
                    if (tempPurchaseLine."Valid To FND" <> 0D) and ((MinValidToDate = 0D) and
                                                               (MinValidToDate < tempPurchaseLine."Valid To FND")) then begin
                        P_DocNo := tempPurchaseLine."Document No.";
                        P_LineNo := tempPurchaseLine."Line No.";
                        P_VendNo := tempPurchaseLine."Buy-from Vendor No.";
                        if MinValidToDate <> 0D then
                            MinValidToDate_Changed := true;
                        MinValidToDate := tempPurchaseLine."Valid To FND";
                    end else
                        if (MinValidToDate > tempPurchaseLine."Valid To FND") then begin
                            P_DocNo := tempPurchaseLine."Document No.";
                            P_LineNo := tempPurchaseLine."Line No.";
                            P_VendNo := tempPurchaseLine."Buy-from Vendor No.";
                            MinValidToDate_Changed := true;
                            MinValidToDate := tempPurchaseLine."Valid To FND";
                        end;
                until tempPurchaseLine.NEXT() = 0;

            if not MinValidToDate_Changed then begin
                MaxValidFromDate := 0D;
                if tempPurchaseLine.findset() then
                    repeat
                        tempPurchaseLine.CALCFIELDS("Valid From FND");
                        if (tempPurchaseLine."Valid From FND" <> 0D) and ((MaxValidFromDate = 0D) and
                                                                   (MaxValidFromDate < tempPurchaseLine."Valid From FND")) then begin
                            P_DocNo := tempPurchaseLine."Document No.";
                            P_LineNo := tempPurchaseLine."Line No.";
                            P_VendNo := tempPurchaseLine."Buy-from Vendor No.";
                            if MaxValidFromDate <> 0D then
                                MaxValidFromDate_Changed := true;
                            MaxValidFromDate := tempPurchaseLine."Valid From FND";
                        end else   //  11/22/2017 < 10/1/2017
                            if (MaxValidFromDate > tempPurchaseLine."Valid From FND") then begin
                                P_DocNo := tempPurchaseLine."Document No.";
                                P_LineNo := tempPurchaseLine."Line No.";
                                P_VendNo := tempPurchaseLine."Buy-from Vendor No.";
                                MaxValidFromDate_Changed := true;
                                MaxValidFromDate := tempPurchaseLine."Valid From FND";
                            end;
                    until tempPurchaseLine.NEXT() = 0;
            end;


            if not MinValidToDate_Changed then
                if not MaxValidFromDate_Changed then begin
                    tempPurchaseLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                    if tempPurchaseLine.FINDLAST() then begin
                        P_DocNo := tempPurchaseLine."Document No.";
                        P_LineNo := tempPurchaseLine."Line No.";
                        P_VendNo := tempPurchaseLine."Buy-from Vendor No.";
                    end;
                end;
            if Vend1.GET(P_VendNo) then;
            //HEI.105>>
            /*Rec."Blanket Order No." := P_DocNo;
            Rec."Blanket Order Line No." := P_LineNo;
            Rec."Vendor No." := P_VendNo;
            Rec.VALIDATE("Currency Code",Vend1."Currency Code");
            Rec.MODIFY;*///Old code commented
                         //HEI.105<<
        end;
        tempPurchaseLine.DELETEALL();
        //HEI.43>>
    end;

    // [EventSubscriber(ObjectType::Table, 50001, 'OnAfterModifyEvent', '', false, false)]
    // local procedure T50001OnAfterModifySendEmailOnError(var Rec : Record "Interface Entry Header";var xRec : Record "Interface Entry Header";RunTrigger : Boolean);
    // var
    //     TempUser : Record "User Setup" temporary;
    //     UserSetup : Record "User Setup";
    //     FromUserSetup : Record "User Setup";
    //     SMTPMail : Codeunit "SMTP Mail";
    //     MailSubjectTxt : Text[100];
    //     Msg : Text[1000];
    //     FMInterfaceSetup : Record "FuturMaster Interface Setup INT";
    //     FMInterfaceSetup_2 : Record "FuturMaster Interf Setup_2 INT";
    //     FldRef : FieldRef;
    //     RecRef : RecordRef;
    //     FMInterface : Boolean;
    //     i : Integer;
    // begin
    //     //>>HEI.44

    //     if (Rec."Your Reference" <> 'EMail_Sent') and (Rec.Status = Rec.Status::Error) and (Rec.Description = 'Scheduled') then begin
    //       FMInterface:= false;
    //       RecRef.OPEN(50068);
    //       if RecRef.FINDFIRST then begin
    //        for i := 1 to RecRef.FIELDCOUNT do begin
    //          FldRef := RecRef.FIELDINDEX(i);
    //          if FORMAT(FldRef.VALUE) = Rec."Interface Code" then
    //              FMInterface := true;
    //          end;
    //       end;

    //       RecRef.CLOSE;
    //       RecRef.OPEN(50111);

    //       if RecRef.FINDFIRST then begin
    //        for i := 1 to RecRef.FIELDCOUNT do begin
    //          FldRef := RecRef.FIELDINDEX(i);
    //          if FORMAT(FldRef.VALUE) = Rec."Interface Code" then
    //              FMInterface := true;
    //          end;
    //       end;
    //       RecRef.CLOSE;

    //       if FMInterface then begin
    //         // Create list of users to receive the notification
    //       //GeneralInterfaceSetup.GET;
    //       FMInterfaceSetup_2.GET;
    //       if FMInterfaceSetup_2."Notify User ID 1" <> '' then
    //         if UserSetup.GET(FMInterfaceSetup_2."Notify User ID 1") then begin
    //           TempUser := UserSetup;
    //           if TempUser.INSERT then;
    //         end;
    //       if FMInterfaceSetup_2."Notify User ID 2" <> '' then
    //         if UserSetup.GET(FMInterfaceSetup_2."Notify User ID 2") then begin
    //           TempUser := UserSetup;
    //           if TempUser.INSERT then;
    //         end;
    //       //FromUserSetup.GET(GeneralInterfaceSetup."Interface Job Queue User ID");

    //       // Send mail to users
    //       if TempUser.FIND('-') then begin
    //         repeat
    //           if TempUser."E-Mail" <> '' then begin
    //             MailSubjectTxt := 'Error processing interface ' + Rec."Interface Code";
    //             Msg := Rec."Error Message";
    //             //SMTPMail.CreateMessage('HeiLite BASE Interfaces',FromUserSetup."E-Mail",TempUser."E-Mail",MailSubjectTxt,Msg,TRUE);
    //             SMTPMail.CreateMessage('HeiLite FM Interfaces', TempUser."E-Mail", TempUser."E-Mail", MailSubjectTxt, Msg, true);
    //             SMTPMail.Send;
    //             Rec."Your Reference" := 'EMail_Sent';
    //             Rec.MODIFY;
    //           end;
    //         until TempUser.NEXT = 0;
    //       end;

    //         end;
    //     end;
    //     //<<HEI.44
    // end;  // BC Upgrade NANDIS03 - this function to be moved to InterfaceFramework

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure CreatePODocumentLogOnModify_ItemNo(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        PurchaseHeader: Record "Purchase Header";
        FieldNum: Integer;
    begin

        //<<HEI.45
        if CheckNewPurchLine(Rec) then
            exit;

        if (Rec."No." <> xRec."No.") then // AND (Rec.Type = Rec.Type::Item) THEN
        begin
            PurchaseHeader.RESET();
            PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
            PurchaseHeader.SETRANGE(Status, PurchaseHeader.Status::Open);
            PurchaseHeader.SETRANGE("No.", Rec."Document No.");
            PurchaseHeader.SETFILTER("No. Printed", '>=1');
            if PurchaseHeader.FINDFIRST() then begin
                FieldNum := Rec.FIELDNO("No.");
                InsertPODocumentLog(Rec, xRec."No.", Rec."No.", FieldNum, 'No.');
            end;
        end;
        //>>HEI.45
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Quantity', false, false)]
    local procedure CreatePODocumentLogOnModify_Qty(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        PurchaseDocumentLog: Record "Purchase Document Log FND";
        PurchaseHeader: Record "Purchase Header";
        FieldNum: Integer;
    begin

        //<<HEI.45
        if CheckNewPurchLine(Rec) then
            exit;

        if Rec.Quantity <> xRec.Quantity then begin
            PurchaseHeader.RESET();
            PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
            PurchaseHeader.SETRANGE(Status, PurchaseHeader.Status::Open);
            PurchaseHeader.SETRANGE("No.", Rec."Document No.");
            PurchaseHeader.SETFILTER("No. Printed", '>=1');
            if PurchaseHeader.FINDFIRST() then begin
                FieldNum := Rec.FIELDNO(Quantity);
                InsertPODocumentLog(Rec, FORMAT(xRec.Quantity), FORMAT(Rec.Quantity), FieldNum, 'Quantity');
            end;
        end;
        //>>HEI.45
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Unit of Measure', false, false)]
    local procedure CreatePODocumentLogOnModify_UOM(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        PurchaseHeader: Record "Purchase Header";
        FieldNum: Integer;
    begin

        //>>HEI.45
        if CheckNewPurchLine(Rec) then
            exit;

        if Rec."Unit of Measure" <> xRec."Unit of Measure" then begin
            PurchaseHeader.RESET();
            PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
            PurchaseHeader.SETRANGE(Status, PurchaseHeader.Status::Open);
            PurchaseHeader.SETRANGE("No.", Rec."Document No.");
            PurchaseHeader.SETFILTER("No. Printed", '>=1');
            if PurchaseHeader.FINDFIRST() then begin
                FieldNum := Rec.FIELDNO("Unit of Measure");
                InsertPODocumentLog(Rec, xRec."Unit of Measure", Rec."Unit of Measure", FieldNum, 'Unit of Measure');
            end;
        end;
        //<<HEI.45
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Expected Receipt Date', false, false)]
    local procedure CreatePODocumentLogOnModify_ExpectedRecieptDate(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        PurchaseHeader: Record "Purchase Header";
        FieldNum: Integer;
    begin

        //>>HEI.45
        if CheckNewPurchLine(Rec) then
            exit;

        if Rec."Expected Receipt Date" <> xRec."Expected Receipt Date" then begin
            PurchaseHeader.RESET();
            PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
            PurchaseHeader.SETRANGE(Status, PurchaseHeader.Status::Open);
            PurchaseHeader.SETRANGE("No.", Rec."Document No.");
            PurchaseHeader.SETFILTER("No. Printed", '>=1');
            if PurchaseHeader.FINDFIRST() then begin
                FieldNum := Rec.FIELDNO("Expected Receipt Date");
                InsertPODocumentLog(Rec, FORMAT(xRec."Expected Receipt Date"), FORMAT(Rec."Expected Receipt Date"), FieldNum, 'Expected Receipt Date');
                PurchaseHeader."Changed FND" := true;
                PurchaseHeader.MODIFY();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Direct Unit Cost', false, false)]
    local procedure CreatePODocumentLogOnModify_DirectUnitCost(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        PurchaseHeader: Record "Purchase Header";
        FieldNum: Integer;
    begin

        //>>HEI.45
        if CheckNewPurchLine(Rec) then
            exit;

        if Rec."Direct Unit Cost" <> xRec."Direct Unit Cost" then begin
            PurchaseHeader.RESET();
            PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
            PurchaseHeader.SETRANGE(Status, PurchaseHeader.Status::Open);
            PurchaseHeader.SETRANGE("No.", Rec."Document No.");
            PurchaseHeader.SETFILTER("No. Printed", '>=1');
            if PurchaseHeader.FINDFIRST() then begin
                FieldNum := Rec.FIELDNO("Direct Unit Cost");
                InsertPODocumentLog(Rec, FORMAT(xRec."Direct Unit Cost"), FORMAT(Rec."Direct Unit Cost"), FieldNum, 'Direct Unit Cost');
            end;
        end;
    end;

    local procedure InsertPODocumentLog(PurchaseLine: Record "Purchase Line"; Oldval: Text; NewVal: Text; FieldNum: Integer; FieldCaption: Text);
    var
        PurchaseDocumentLog: Record "Purchase Document Log FND";
        EntryNo: Integer;
    begin

        //<<Hei.45
        EntryNo := GetMax();
        EntryNo := EntryNo + 1;

        PurchaseDocumentLog.INIT();
        PurchaseDocumentLog."Document Type" := PurchaseLine."Document Type";
        PurchaseDocumentLog."Document No." := PurchaseLine."Document No.";
        if PurchaseLine."Line No." <> 0 then
            PurchaseDocumentLog."Line No." := PurchaseLine."Line No."
        else
            exit;
        PurchaseDocumentLog."Entry No." := EntryNo;
        PurchaseDocumentLog."User ID" := USERID;
        PurchaseDocumentLog."Creation Datetime" := CURRENTDATETIME;
        PurchaseDocumentLog."Old Value" := Oldval;
        PurchaseDocumentLog."New Value" := NewVal;
        PurchaseDocumentLog."Field No." := FieldNum;
        PurchaseDocumentLog.Comment := 'Modified Field' + '-' + FieldCaption;
        PurchaseDocumentLog.INSERT();
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Ship-to Address', false, false)]
    local procedure CreatePODocumentLogOnModify_Address(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    var
        PurchaseDocumentLog: Record "Purchase Document Log FND";
        PurchaseLine: Record "Purchase Line";
        EntryNo: Integer;
    begin
        //<<Hei.45
        if (Rec."Document Type" = Rec."Document Type"::Order) and
            (Rec."No. Printed" >= 1) then begin
            EntryNo := GetMax();
            EntryNo := EntryNo + 1;
            PurchaseDocumentLog.INIT();
            PurchaseDocumentLog."Document Type" := Rec."Document Type";
            PurchaseDocumentLog."Document No." := Rec."No.";
            PurchaseDocumentLog."Line No." := 0;
            PurchaseDocumentLog."Entry No." := EntryNo;
            PurchaseDocumentLog."User ID" := USERID;
            PurchaseDocumentLog."Creation Datetime" := CURRENTDATETIME;
            PurchaseDocumentLog."Old Value" := xRec."Ship-to Address";
            PurchaseDocumentLog."New Value" := Rec."Ship-to Address";
            PurchaseDocumentLog."Field No." := Rec.FIELDNO("Ship-to Address");
            PurchaseDocumentLog.Comment := 'Modified Field' + '-' + 'Address';
            PurchaseDocumentLog.INSERT();
            Rec."Changed FND" := true;
            Rec.MODIFY();
        end;
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Ship-to Address 2', false, false)]
    local procedure CreatePODocumentLogOnModify_Address2(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    var
        PurchaseDocumentLog: Record "Purchase Document Log FND";
        PurchaseLine: Record "Purchase Line";
        EntryNo: Integer;
    begin
        //<<Hei.45
        if (Rec."Document Type" = Rec."Document Type"::Order) and
            (Rec."No. Printed" >= 1) then begin
            EntryNo := GetMax();
            EntryNo := EntryNo + 1;
            PurchaseDocumentLog.INIT();
            PurchaseDocumentLog."Document Type" := Rec."Document Type";
            PurchaseDocumentLog."Document No." := Rec."No.";
            PurchaseDocumentLog."Line No." := 0;
            PurchaseDocumentLog."Entry No." := EntryNo;
            PurchaseDocumentLog."User ID" := USERID;
            PurchaseDocumentLog."Creation Datetime" := CURRENTDATETIME;
            PurchaseDocumentLog."Old Value" := xRec."Ship-to Address 2";
            PurchaseDocumentLog."New Value" := Rec."Ship-to Address 2";
            PurchaseDocumentLog."Field No." := Rec.FIELDNO("Ship-to Address 2");
            PurchaseDocumentLog.Comment := 'Modified Field' + '-' + 'Address 2';
            PurchaseDocumentLog.INSERT();
            Rec."Changed FND" := true;
            Rec.MODIFY();
        end;
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Ship-to Post Code', false, false)]
    local procedure CreatePODocumentLogOnModify_PostCode(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    var
        PurchaseDocumentLog: Record "Purchase Document Log FND";
        PurchaseLine: Record "Purchase Line";
        EntryNo: Integer;
    begin
        //<<Hei.45
        if (Rec."Document Type" = Rec."Document Type"::Order) and
            (Rec."No. Printed" >= 1) then begin

            EntryNo := GetMax();
            EntryNo := EntryNo + 1;

            PurchaseDocumentLog.INIT();
            PurchaseDocumentLog."Document Type" := Rec."Document Type";
            PurchaseDocumentLog."Document No." := Rec."No.";
            PurchaseDocumentLog."Line No." := 0;
            PurchaseDocumentLog."Entry No." := EntryNo;
            PurchaseDocumentLog."User ID" := USERID;
            PurchaseDocumentLog."Creation Datetime" := CURRENTDATETIME;
            PurchaseDocumentLog."Old Value" := xRec."Ship-to Post Code";
            PurchaseDocumentLog."New Value" := Rec."Ship-to Post Code";
            PurchaseDocumentLog."Field No." := Rec.FIELDNO("Ship-to Post Code");
            PurchaseDocumentLog.Comment := 'Modified Field' + '-' + 'PostCode';
            PurchaseDocumentLog.INSERT();

            Rec."Changed FND" := true;
            Rec.MODIFY();

        end;
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Ship-to City', false, false)]
    local procedure CreatePODocumentLogOnModify_City(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    var
        PurchaseDocumentLog: Record "Purchase Document Log FND";
        PurchaseLine: Record "Purchase Line";
        EntryNo: Integer;
    begin
        //<<Hei.45
        if (Rec."Document Type" = Rec."Document Type"::Order) and
            (Rec."No. Printed" >= 1) then begin

            EntryNo := GetMax();
            EntryNo := EntryNo + 1;

            PurchaseDocumentLog.INIT();
            PurchaseDocumentLog."Document Type" := Rec."Document Type";
            PurchaseDocumentLog."Document No." := Rec."No.";
            PurchaseDocumentLog."Line No." := 0;
            PurchaseDocumentLog."Entry No." := EntryNo;
            PurchaseDocumentLog."User ID" := USERID;
            PurchaseDocumentLog."Creation Datetime" := CURRENTDATETIME;
            PurchaseDocumentLog."Old Value" := xRec."Ship-to City";
            PurchaseDocumentLog."New Value" := Rec."Ship-to City";
            PurchaseDocumentLog."Field No." := Rec.FIELDNO("Ship-to City");
            PurchaseDocumentLog.Comment := 'Modified Field' + '-' + 'City';
            PurchaseDocumentLog.INSERT();

            Rec."Changed FND" := true;
            Rec.MODIFY();

        end;
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Ship-to Country/Region Code', false, false)]
    local procedure CreatePODocumentLogOnModify_CountryRegion(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    var
        PurchaseDocumentLog: Record "Purchase Document Log FND";
        PurchaseLine: Record "Purchase Line";
        EntryNo: Integer;
    begin

        //<<Hei.45
        if (Rec."Document Type" = Rec."Document Type"::Order) and
            (Rec."No. Printed" >= 1) then begin
            EntryNo := GetMax();
            EntryNo := EntryNo + 1;
            PurchaseDocumentLog.INIT();
            PurchaseDocumentLog."Document Type" := Rec."Document Type";
            PurchaseDocumentLog."Document No." := Rec."No.";
            PurchaseDocumentLog."Line No." := 0;
            PurchaseDocumentLog."Entry No." := EntryNo;
            PurchaseDocumentLog."User ID" := USERID;
            PurchaseDocumentLog."Creation Datetime" := CURRENTDATETIME;
            PurchaseDocumentLog."Old Value" := xRec."Ship-to Country/Region Code";
            PurchaseDocumentLog."New Value" := Rec."Ship-to Country/Region Code";
            PurchaseDocumentLog."Field No." := Rec.FIELDNO("Ship-to Country/Region Code");
            PurchaseDocumentLog.Comment := 'Modified Field' + '-' + 'Country/Region Code';
            PurchaseDocumentLog.INSERT();
            Rec."Changed FND" := true;
            Rec.MODIFY();
        end;
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Ship-to Contact', false, false)]
    local procedure CreatePODocumentLogOnModify_Contact(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    var
        PurchaseDocumentLog: Record "Purchase Document Log FND";
        PurchaseLine: Record "Purchase Line";
        EntryNo: Integer;
    begin
        //<<Hei.45
        if (Rec."Document Type" = Rec."Document Type"::Order) and
            (Rec."No. Printed" >= 1) then begin
            EntryNo := GetMax();
            EntryNo := EntryNo + 1;
            PurchaseDocumentLog.INIT();
            PurchaseDocumentLog."Document Type" := Rec."Document Type";
            PurchaseDocumentLog."Document No." := Rec."No.";
            PurchaseDocumentLog."Line No." := 0;
            PurchaseDocumentLog."Entry No." := EntryNo;
            PurchaseDocumentLog."User ID" := USERID;
            PurchaseDocumentLog."Creation Datetime" := CURRENTDATETIME;
            PurchaseDocumentLog."Old Value" := xRec."Ship-to Contact";
            PurchaseDocumentLog."New Value" := Rec."Ship-to Contact";
            PurchaseDocumentLog."Field No." := Rec.FIELDNO("Ship-to Contact");
            PurchaseDocumentLog.Comment := 'Modified Field' + '-' + 'Contact';
            PurchaseDocumentLog.INSERT();
            Rec."Changed FND" := true;
            Rec.MODIFY();
        end;
    end;

    procedure CheckNewPurchLine(PurchaseLine1: Record "Purchase Line"): Boolean;
    begin
        //<<Hei.45
        PurchaseDocumentLog.RESET();
        PurchaseDocumentLog.SETRANGE("Document Type", PurchaseLine1."Document Type"::Order);
        PurchaseDocumentLog.SETRANGE("Document No.", PurchaseLine1."Document No.");
        PurchaseDocumentLog.SETRANGE("Line No.", PurchaseLine1."Line No.");
        PurchaseDocumentLog.SETRANGE(Comment, 'New Line Added');
        PurchaseDocumentLog.SETRANGE(Printed, false);
        if PurchaseDocumentLog.FINDFIRST() then
            exit(true)
        else
            exit(false);
    end;

    procedure GetLotItemTracking(OrderNo: Code[20]) LotNumOMul: Code[20];
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        PreviousLotNo: Code[20];
        CountLedger: Integer;
        Multipletxt: Label 'Multiple';
    begin
        //HEI.46>>
        CLEAR(CountLedger);
        ItemLedgerEntry.RESET();
        ItemLedgerEntry.SETRANGE("Order No.", OrderNo);
        ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Output);
        if ItemLedgerEntry.findset() then begin
            repeat
                CountLedger += 1;
                if CountLedger = 1 then
                    LotNumOMul := ItemLedgerEntry."Lot No."
                else
                    if PreviousLotNo <> ItemLedgerEntry."Lot No." then
                        LotNumOMul := Multipletxt;
                PreviousLotNo := ItemLedgerEntry."Lot No.";
            until ItemLedgerEntry.NEXT() = 0;
        end
        //HEI.46<<
    end;

    // procedure InsertRPMCustomerDifferences(var Rec : Record "Sales Line");
    // var
    //     salesheader : Record "Sales Header";
    //     CustomerDifferencesRPM : Record "Customer Differences RPM FND";
    //     Item : Record Item;
    //     LastLineNo : Integer;
    //     salesline : Record "Sales Line";
    //     CustomerDifferencesRPMPage : Page "Customer Differences (RPM)";
    //     DrinkDepositGroup : Record "Drink Deposit Group";
    //     PostedCustomerDiffRPM : Record "Posted Customer Diff RPM FND";
    //     SalesDepositItemCharge : Record "Sales Deposit Item Charge";
    //     SalesLine1 : Record "Sales Line";
    //     SalesHeader1 : Record "Sales Header";
    //     CustomerDifferencesRPM1 : Record "Customer Differences RPM FND";
    //     LineNo : Boolean;
    //     SalesLine2 : Record "Sales Line";
    // begin
    //     //HEI.47>>
    //     PostedCustomerDiffRPM.SETFILTER("Sales return order no.",Rec."Document No.");
    //     if PostedCustomerDiffRPM.FINDFIRST then begin
    //       //<<HEI.96
    //       if GUIALLOWED then
    //       //>>HEI.96
    //         MESSAGE(Text005,Rec."Document No.");
    //       exit;
    //       end;

    //     //HEI.66>>
    //     salesheader.SETRANGE("No.",Rec."Document No.");
    //     salesheader.SETFILTER("Document Type",'%1',salesheader."Document Type"::"Return Order");
    //     if salesheader.FINDFIRST then
    //       if Rec."Document Type"= Rec."Document Type"::"Return Order" then begin
    //          salesline.SETFILTER("Document No.",Rec."Document No.");
    //          salesline.SETFILTER("Document Type",'%1',salesline."Document Type"::"Return Order");
    //          if salesline.findset then
    //            repeat
    //              if salesline.Type = salesline.Type::Item then begin
    //                if Item.GET(salesline."No.") then
    //                  if Item."Replenishment System" <> Item."Replenishment System"::Assembly then begin
    //                    CLEAR(LineNo);
    //                    CustomerDifferencesRPM.RESET;
    //                     if CustomerDifferencesRPM.FINDLAST then begin
    //                       LastLineNo := CustomerDifferencesRPM."Line No.";
    //                       LastLineNo := LastLineNo + 10000;
    //                     end else
    //                       LastLineNo := LastLineNo + 10000;

    //                     CustomerDifferencesRPM.SETRANGE("Item No.",salesline."No.");
    //                     CustomerDifferencesRPM.SETRANGE("Sales return order no.",salesline."Document No.");
    //                     CustomerDifferencesRPM.SETRANGE("Line No.",salesline."Line No.");
    //                     if not CustomerDifferencesRPM.FINDFIRST then begin
    //                       CustomerDifferencesRPM.INIT;
    //                       CustomerDifferencesRPM."Sales return order no." :=  salesline."Document No.";
    //                       CustomerDifferencesRPM."Sell-to customer no."   :=  salesline."Sell-to Customer No.";
    //                       CustomerDifferencesRPM."Sell-to Customer Name"  :=  salesheader."Sell-to Customer Name";
    //                       CustomerDifferencesRPM."Bill-to Customer No."   :=  salesline."Bill-to Customer No.";
    //                       CustomerDifferencesRPM."Bill-to Customer name"  :=  salesheader."Bill-to Name";
    //                       CustomerDifferencesRPM."Line No."               :=  salesline."Line No.";
    //                       CustomerDifferencesRPM."Item No."               :=  salesline."No.";

    //                       if Customer1.GET(Rec."Sell-to Customer No.") then
    //                       CustomerDifferencesRPM."Compensation RPM Diff." := Customer1."Compensate RPM Differences";

    //                       if Item.GET(salesline."No.") then begin
    //                         CustomerDifferencesRPM."Item Description"       :=  Item.Description;
    //                         CustomerDifferencesRPM."UOM Code"               :=  Item."Sales Unit of Measure";
    //                       end;

    //                       CustomerDifferencesRPM.INSERT;
    //                     end;
    //                     end;
    //                     end else if (salesline.Type = salesline.Type::"Charge (Item)") and (salesline."Item Charge Type" = salesline."Item Charge Type"::Deposit) then begin
    //                         CustomerDifferencesRPM.SETRANGE("Sales return order no.",salesline."Document No.");
    //                         CustomerDifferencesRPM.SETRANGE("Line No.",salesline."Attached to Line No.");
    //                         if CustomerDifferencesRPM.FINDFIRST then begin
    //                           if LineNo = false then
    //                             CustomerDifferencesRPM."Deposit Price" := salesline."Unit Price"
    //                           else
    //                             CustomerDifferencesRPM."Deposit Price" :=0;
    //                           CustomerDifferencesRPM.MODIFY;
    //                           LineNo :=true;
    //                         end;
    //                      end;
    //                   until salesline.NEXT=0;

    //       end;
    //     //HEI.66<<
    //     CustomerDifferencesRPM.RESET;
    //     CustomerDifferencesRPM.SETRANGE("Sales return order no.",salesheader."No.");
    //     if CustomerDifferencesRPM.FINDFIRST then  begin
    //       CustomerDifferencesRPMPage.SETTABLEVIEW(CustomerDifferencesRPM);
    //       CustomerDifferencesRPMPage.SETRECORD(CustomerDifferencesRPM);
    //       CustomerDifferencesRPMPage.RUN;
    //     end
    //     else begin
    //       CustomerDifferencesRPMPage.SETTABLEVIEW(CustomerDifferencesRPM);
    //       CustomerDifferencesRPMPage.RUN;
    //     end;
    //     //HEI.47<<
    // end;  // BC Upgrade NANDIS03 - Need to move to MtC extension as dependent on table 50218 

    procedure CheckCCCDimenssion(PurchaseHeader: Record "Purchase Header");
    var
        DefaultDimension: Record "Default Dimension";
        DimensionSetEntry: Record "Dimension Set Entry";
        GLAccount: Record "G/L Account";
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseLine: Record "Purchase Line";
        FinancialUtils: Codeunit "Financial-Utils";
        CCCode: Boolean;
        StartPosNoDigits: array[4] of Integer;
        FilterOperator: Text;
    begin
        //HEI.49>>
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

                if DefaultDimension.GET(DATABASE::"G/L Account", GLAccount."No.", GeneralLedgerSetup."Cost Center Dimension Code FND") then
                    case DefaultDimension."Value Posting" of
                        DefaultDimension."Value Posting"::"Code Mandatory":
                            begin
                                if (not DimensionSetEntry.GET(PurchaseLine."Dimension Set ID", GeneralLedgerSetup."Cost Center Dimension Code FND")) or
                                  (DimensionSetEntry."Dimension Value Code" = '')
                                then
                                    ERROR(Error010, PurchaseLine."Line No.");
                            end;
                        DefaultDimension."Value Posting"::"Same Code":
                            begin
                                if DefaultDimension."Dimension Value Code" <> '' then begin
                                    if (not DimensionSetEntry.GET(PurchaseLine."Dimension Set ID", GeneralLedgerSetup."Cost Center Dimension Code FND")) or
                                      (DimensionSetEntry."Dimension Value Code" <> DefaultDimension."Dimension Value Code")
                                    then
                                        ERROR(Error010, PurchaseLine."Line No.");
                                end else begin
                                    if (not DimensionSetEntry.GET(PurchaseLine."Dimension Set ID", GeneralLedgerSetup."Cost Center Dimension Code FND")) or
                                      (DimensionSetEntry."Dimension Value Code" = '')
                                    then
                                        ERROR(Error010, PurchaseLine."Line No.");
                                end;
                            end;
                        DefaultDimension."Value Posting"::"No Code":
                            begin
                                if DimensionSetEntry.GET(PurchaseLine."Dimension Set ID", GeneralLedgerSetup."Cost Center Dimension Code FND") then
                                    ERROR(Error011, PurchaseLine."Line No.");
                            end;
                    end;

                FinancialUtils.GetEBFFilterPattern(StartPosNoDigits, FilterOperator); //HEI.117
                DimensionSetEntry.SETRANGE("Dimension Set ID", PurchaseLine."Dimension Set ID");
                if DimensionSetEntry.findset() then
                    repeat
                        //HEI.119>>
                        if not EbfCombination.CheckNewEBFMatrixIsActive() then begin
                            if EbfCombination.GET(GLAccount."No.", DimensionSetEntry."Dimension Code", DimensionSetEntry."Dimension Value Code") and
                              (EbfCombination."Combination Restriction" = EbfCombination."Combination Restriction"::"Not Allowed")
                            then
                                ERROR(Error012, PurchaseLine."No.", DimensionSetEntry."Dimension Code", DimensionSetEntry."Dimension Value Code", PurchaseLine."Line No.");
                        end else begin //HEI.119<<
                                       //HEI.117>>
                                       /*
                                       IF EbfCombination.GET(GLAccount."No.",DimensionSetEntry."Dimension Code",DimensionSetEntry."Dimension Value Code") AND
                                         (EbfCombination."Combination Restriction" = EbfCombination."Combination Restriction"::"Not Allowed")
                                       */
                            EbfCombination.SETFILTER("GL Account No.", COPYSTR(GLAccount."No.", StartPosNoDigits[1], StartPosNoDigits[2]) + FilterOperator);
                            EbfCombination.SETRANGE("Dimension Code", DimensionSetEntry."Dimension Code");
                            EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionSetEntry."Dimension Value Code", StartPosNoDigits[3], StartPosNoDigits[4]) + FilterOperator);
                            if (EbfCombination.FINDFIRST()) and
                              (EbfCombination."Combination Restriction" = EbfCombination."Combination Restriction"::"Not Allowed")
                              and (GLAccount."No." <> '') and (DimensionSetEntry."Dimension Value Code" <> '') //HEI.117
                                                                                                               //HEI.117<<
                            then
                                ERROR(Error012, PurchaseLine."No.", DimensionSetEntry."Dimension Code", DimensionSetEntry."Dimension Value Code", PurchaseLine."Line No.");
                        end; //HEI.119
                    until DimensionSetEntry.NEXT() = 0;
            until PurchaseLine.NEXT() = 0;
        //HEI.49<<
    end;

    procedure UpdatePostedCustDiff(SalesHeader: Record "Sales Header");
    var
        PostedCustomerDiffRPM: Record "Posted Customer Diff RPM FND";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesLine: Record "Sales Line";
    begin
        //HEI.48>>
        SalesCrMemoHeader.SETRANGE("Pre-Assigned No.", SalesHeader."No."); //HEI.66
        if SalesCrMemoHeader.FINDFIRST() then begin //HEI.66
                                                    //SalesLine.SETRANGE("Document No.",SalesHeader."No."); //commented HEI.66
                                                    //SalesLine.SETRANGE("Document Type",SalesLine."Document Type"::"Credit Memo"); //commented HEI.66
                                                    //SalesLine.SETRANGE(Type,SalesLine.Type::Resource); //commented HEI.66
                                                    //IF SalesLine.FINDFIRST THEN BEGIN
            PostedCustomerDiffRPM.RESET();
            PostedCustomerDiffRPM.SETRANGE("RPM comp.Sales Credit memo No.", SalesCrMemoHeader."Pre-Assigned No."); //HEI.66
            PostedCustomerDiffRPM.SETRANGE("Bill-to Customer No.", SalesCrMemoHeader."Bill-to Customer No.");  //HEI.66
                                                                                                               // PostedCustomerDiffRPM.SETRANGE("Sales return order no.",SalesLine."Order No."); //commented HEI.66
            if PostedCustomerDiffRPM.findset() then begin
                repeat
                    PostedCustomerDiffRPM.Closed := true;
                    PostedCustomerDiffRPM."Closed By Document No." := SalesCrMemoHeader."No."; //HEI.66
                    PostedCustomerDiffRPM."Closed By Posting Date" := SalesCrMemoHeader."Posting Date"; //HEI.66
                    PostedCustomerDiffRPM."Closed on Date" := TODAY;
                    PostedCustomerDiffRPM."Closed By User Id" := USERID;
                    PostedCustomerDiffRPM.MODIFY(true);
                until PostedCustomerDiffRPM.NEXT() = 0;
            end;
        end;
        //HEI.48>>
    end;

    [EventSubscriber(ObjectType::Codeunit, 414, 'OnAfterReleaseSalesDoc', '', false, false)]
    local procedure CU414OnAfterRelease(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean);
    var
        DefaultDimension: Record "Default Dimension";
        SalesLine: Record "Sales Line";
    begin
        //HEI.52>>
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) or (SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order") then begin
            SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
            SalesLine.SETRANGE("Document No.", SalesHeader."No.");
            if SalesLine.findset() then
                repeat
                    //if SalesLine."Free Reason Code" <> '' then begin  // BC Upgrade NANDIS03 - BLocked as DIT field
                    SalesLine.VALIDATE("Dimension Set ID", GetDimSetId(SalesLine));
                    SalesLine.MODIFY();
                // end;  // BC Upgrade NANDIS03 - BLocked as DIT field
                until SalesLine.NEXT() = 0;
        end;
        //HEI.52<<
    end;

    local procedure GetDimSetId(SalesLine: Record "Sales Line"): Integer;
    var
        DefaultDimension: Record "Default Dimension";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        TempDimensionSetEntry2: Record "Dimension Set Entry" temporary;
        DimensionValue: Record "Dimension Value";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionManagement: Codeunit DimensionManagement;
        dimsetid: Integer;
        dimsetid1: Integer;
    begin
        //HEI.52>>
        GeneralLedgerSetup.GET();
        DimensionManagement.GetDimensionSet(TempDimensionSetEntry, SalesLine."Dimension Set ID");

        // DefaultDimension.SETRANGE("Table ID", DATABASE::"Free Reason Code");  // BC Upgrade NANDIS03 - Blocked due to DIT fields
        // DefaultDimension.SETRANGE("No.", SalesLine."Free Reason Code");  // BC Upgrade NANDIS03 - Blocked due to DIT fields
        if DefaultDimension.FINDFIRST() then begin
            TempDimensionSetEntry.RESET();
            TempDimensionSetEntry.SETRANGE("Dimension Code", DefaultDimension."Dimension Code");
            TempDimensionSetEntry.DELETEALL();
            dimsetid := DimensionManagement.GetDimensionSetID(TempDimensionSetEntry);
            DimensionManagement.GetDimensionSet(TempDimensionSetEntry2, dimsetid);
            DimensionValue.GET(DefaultDimension."Dimension Code", DefaultDimension."Dimension Value Code");
            TempDimensionSetEntry2.RESET();
            TempDimensionSetEntry2."Dimension Code" := DefaultDimension."Dimension Code";
            TempDimensionSetEntry2."Dimension Value Code" := DefaultDimension."Dimension Value Code";
            TempDimensionSetEntry2."Dimension Value ID" := DimensionValue."Dimension Value ID";
            TempDimensionSetEntry2.INSERT();
            dimsetid := 0;

            dimsetid := DimensionManagement.GetDimensionSetID(TempDimensionSetEntry2);
            exit(dimsetid);
        end else
            exit(SalesLine."Dimension Set ID");
        //HEI.52<<
    end;

    // [EventSubscriber(ObjectType::Table, 37, 'OnAfterValidateEvent', 'No.', false, false)]
    // local procedure T37OnAfterValidateNo(var Rec : Record "Sales Line";var xRec : Record "Sales Line";CurrFieldNo : Integer);
    // var
    //     MarakiSuppressValues : Record "Maraki Suppress Values";
    //     CashVanSalesInterfaceSetup : Record "Cash Van Sales Interface Setup INT";
    //     GeneralOpCoSetup : Record "General OpCo Setup";
    // begin
    //     //HEI.53>>
    //     GeneralOpCoSetup.GET;
    //     if GeneralOpCoSetup."Enable Send to Maraki" then begin
    //       MarakiSuppressValues.SETRANGE("No.",Rec."No.");
    //       if Rec.Type = Rec.Type::Item then
    //         MarakiSuppressValues.SETRANGE(Type,MarakiSuppressValues.Type::Item)
    //       else if Rec.Type = Rec.Type::"Charge (Item)" then
    //         MarakiSuppressValues.SETRANGE(Type,MarakiSuppressValues.Type::"Item Charge");
    //       if MarakiSuppressValues.FINDFIRST then
    //         Rec."Suppress POS Interface" := true;
    //     end;
    //     //HEI.53<<
    //     Rec."Freshness Date (min)" := GetFreshnessDate(Rec);//HEI.116
    // end;  // BC Upgrade NANDIS03 - moved to interface framework interface

    procedure CheckToallowJNLPosting4CatCodes(ItemJrlLine: Record "Item Journal Line") AllowJNLPosting: Boolean;
    var
        Item: Record Item;
        ItemLedgerEntry: Record "Item Ledger Entry";
        ILERecNotFound: Boolean;
    begin
        //HEI.31<<
        ItemJrlLine.RESET();
        ItemJrlLine.SETCURRENTKEY("Entry Type", "Document No.", "Posting Date");
        ItemJrlLine.SETRANGE(ItemJrlLine."Entry Type", ItemJrlLine."Entry Type"::Consumption);
        ItemJrlLine.SETRANGE(ItemJrlLine."Document No.", ItemJrlLine."Document No.");
        ItemJrlLine.SETRANGE(ItemJrlLine."Posting Date", ItemJrlLine."Posting Date");
        if ItemJrlLine.findset() then begin
            repeat
                if ItemJrlLine.Quantity < 0 then begin
                    if Item.GET(ItemJrlLine."Item No.") then begin
                        if ((Item."Item Category Code" = '05') or (Item."Item Category Code" = '08') or (Item."Item Category Code" = '10')) then
                            AllowJNLPosting := true;
                    end
                end
            until ItemJrlLine.NEXT() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 124, 'OnAfterValidateEvent', 'Reason Code', false, false)]
    procedure OnAfterValidateReasonCodePurchaseCrMemoHeader(var Rec: Record "Purch. Cr. Memo Hdr."; var xRec: Record "Purch. Cr. Memo Hdr."; CurrFieldNo: Integer);
    var
        PurchaseHeaderExtension: Record "Purchase Additional Fields FND";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        DocType: Option "Posted Invoice","Posted Cr. Memo","Posted Receipt";
        DocTypeExt: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Posted Receipt","Posted Invoice","Posted Cr. Memo";
    begin
        //HEI.56>>
        if Rec."Reason Code" <> '' then begin
            Rec."On Hold" := 'HLD';
            if PurchaseHeaderExtension.GET(124, DocTypeExt::"Posted Cr. Memo", Rec."No.") then begin
                PurchaseHeaderExtension."On Hold UserID" := USERID;
                PurchaseHeaderExtension."On Hold Date" := TODAY;
                PurchaseHeaderExtension.MODIFY();
            end else
                InsertPurchaseHeaderExt(DocType::"Posted Cr. Memo", Rec."No.", USERID, TODAY);
        end else begin
            Rec."On Hold" := '';
            if PurchaseHeaderExtension.GET(124, DocTypeExt::"Posted Cr. Memo", Rec."No.") then begin
                PurchaseHeaderExtension."On Hold UserID" := '';
                PurchaseHeaderExtension."On Hold Date" := 0D;
                PurchaseHeaderExtension.MODIFY();
            end else
                InsertPurchaseHeaderExt(DocType::"Posted Cr. Memo", Rec."No.", '', 0D);
        end;

        Rec.CALCFIELDS("On Hold Date FND", "On Hold UserID FND");

        VendorLedgerEntry.SETRANGE("Document No.", Rec."No.");
        VendorLedgerEntry.SETRANGE("Posting Date", Rec."Posting Date");
        if VendorLedgerEntry.FINDFIRST() then begin
            VendorLedgerEntry."On Hold" := Rec."On Hold";
            VendorLedgerEntry."On Hold UserID FND" := Rec."On Hold UserID FND";
            VendorLedgerEntry."On Hold Date FND" := Rec."On Hold Date FND";
            VendorLedgerEntry.MODIFY();
        end;
        //HEI.56<<
    end;

    // procedure T50012OnAfterInsert(var Rec : Record "Interface Entry Comp. Detail");
    // var
    //     InterfaceEntryHeader : Record "Interface Entry Header";
    //     GeneralLedgerSetup : Record "General Ledger Setup";
    // begin
    //     //HEI.41>>
    //     GeneralLedgerSetup.GET;
    //     case Rec."Table ID" of
    //        DATABASE::"Customer Attributes FND":
    //         begin
    //           InterfaceEntryHeader.GET(Rec."Header Entry No.");
    //           case Rec."Field ID" of
    //             1:
    //               CreateCustDefaultDim(InterfaceEntryHeader."Source No.",GeneralLedgerSetup."Customer Dimension Code",Rec.Value);
    //             2:
    //               CreateCustDefaultDim(InterfaceEntryHeader."Source No.",'CUST TYPE',Rec.Value);
    //             5:
    //               CreateCustDefaultDim(InterfaceEntryHeader."Source No.",GeneralLedgerSetup."Business Type Dimension Code",Rec.Value);
    //             6:
    //               CreateCustDefaultDim(InterfaceEntryHeader."Source No.",'ORG_SEG',Rec.Value);
    //             7:
    //               CreateCustDefaultDim(InterfaceEntryHeader."Source No.",'"Channel FND"',Rec.Value);
    //             43:
    //               CreateCustDefaultDim(InterfaceEntryHeader."Source No.",'KEY ACCOUNT',Rec.Value);
    //             46:
    //               CreateCustDefaultDim(InterfaceEntryHeader."Source No.",GeneralLedgerSetup."OPCO Dimension Code",Rec.Value);
    //             53:
    //               CreateCustDefaultDim(InterfaceEntryHeader."Source No.",'MARKET',Rec.Value);
    //           end;
    //         end;
    //        DATABASE::Customer:
    //         begin
    //           case Rec."Field ID" of
    //             35:
    //               CreateCustDefaultDim(InterfaceEntryHeader."Source No.",'COUNTRY_REGION CODE',Rec.Value);
    //        2014067:
    //               CreateCustDefaultDim(InterfaceEntryHeader."Source No.",'DIR_INDIR',Rec.Value);
    //           end;
    //         end;
    //     end;
    //     //HEI.41<<
    // end;  // BC Upgrade NANDIS03 - to be moved to InterfaceFramework

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Sell-to Customer No.', false, false)]
    local procedure OnAfterValidateCustomerNoOnSalesDoc(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer);
    var
        DocumentSubtypeCodeSetup: Record "Doc Subtype Code Setup FND";
        DocumentSubtypeCode: Record "Document Subtype Code FND";
    begin
        //HEI.58>>
        DocumentSubtypeCodeSetup.GET();
        if DocumentSubtypeCode.GET(DocumentSubtypeCodeSetup."CTS Order") and
            (Rec."Document Subtype Code FND" = DocumentSubtypeCodeSetup."CTS Order")
        then
            if (Rec."Document Type" = Rec."Document Type"::Invoice) or (Rec."Document Type" = Rec."Document Type"::Order) then
                Rec."Posting No. Series" := DocumentSubtypeCode."Posted Invoice Nos."
            else if (Rec."Document Type" = Rec."Document Type"::"Credit Memo") or (Rec."Document Type" = Rec."Document Type"::"Return Order") then
                Rec."Posting No. Series" := DocumentSubtypeCode."Posted CM. Nos.";
        //HEI.58<<
    end;  // BC Upgrade SHUKLP03 <<

    // BC Upgrade NANDIS03 - Blocked function CreateCustDefaultDim and moved to Interafce extension >>
    // local procedure CreateCustDefaultDim(CustomerNo: Code[20]; DimCode: Code[20]; DimCodeValue: Code[20]);
    // var
    //     DefaultDimension: Record "Default Dimension";
    //     GeneralLedgerSetup: Record "General Ledger Setup";
    // begin
    //     if not DefaultDimension.GET(DATABASE::Customer, CustomerNo, DimCode) then begin
    //         if DimCodeValue <> '' then begin
    //             DefaultDimension.INIT;
    //             DefaultDimension.VALIDATE("Table ID", DATABASE::Customer);
    //             DefaultDimension.VALIDATE("No.", CustomerNo);
    //             DefaultDimension.VALIDATE("Dimension Code", DimCode);
    //             DefaultDimension.VALIDATE("Dimension Value Code", DimCodeValue);
    //             DefaultDimension.INSERT(true);
    //         end;
    //     end else begin
    //         //HEI.61>>
    //         GeneralLedgerSetup.GET;
    //         if DimCode <> GeneralLedgerSetup."Customer Dimension Code" then begin
    //             DefaultDimension.VALIDATE("Dimension Value Code", DimCodeValue);
    //             DefaultDimension.MODIFY(true);
    //         end;
    //     end;
    //     //HEI.61<<
    // end;
    // BC Upgrade NANDIS03 - Blocked function CreateCustDefaultDim and moved to Interafce extension <<

    procedure CheckSimilarities(Source: Text; Target: Text; DistanceLimit: Decimal): Decimal;
    var
        done: Boolean;
        last: Boolean;
        singleWordWeighting: Decimal;
        weighting: Decimal;
        compareWord: Text;
        String1: Text;
        String2: Text;
        wordString: Text;
    begin
        //HEI.39>>
        String1 := LOWERCASE(Target);
        String2 := LOWERCASE(Source);
        wordString := String1;
        weighting := CalcSimilarities(String1, String2) * 100;
        done := false;
        last := false;
        if (weighting > DistanceLimit) then begin
            exit(weighting);
        end else
            repeat
                if STRPOS(wordString, ' ') > 0 then begin
                    compareWord := COPYSTR(wordString, 1, STRPOS(wordString, ' ') - 1);
                    wordString := DELSTR(wordString, 1, STRPOS(wordString, ' '));
                end else begin
                    compareWord := wordString;
                    wordString := '';
                end;
                singleWordWeighting := CalcSimilarities(wordString, String2) * 100;
                if singleWordWeighting > 90 then
                    exit(singleWordWeighting);
            until (wordString = '');
        exit(0);
        //HEI.39<<
    end;

    local procedure CalcSimilarities(var Source: Text; var Target: Text): Decimal;
    var
        MaxVal: Integer;
        sourceWordCount: Integer;
        stepsToSame: Integer;
        targetWordCount: Integer;
    begin
        //HEI.39>>
        if (Source = '') or (Target = '') then
            exit(0.0);

        if (Source = Target) then
            exit(1.0);


        sourceWordCount := STRLEN(Source);
        targetWordCount := STRLEN(Target);
        if sourceWordCount > targetWordCount then
            MaxVal := sourceWordCount
        else
            MaxVal := targetWordCount;

        stepsToSame := ComputeLevDistance(Source, Target);
        exit(1.0 - (stepsToSame / MaxVal));
        //HEI.39<<
    end;

    local procedure ComputeLevDistance(var Source: Text; var Target: Text): Integer;
    var
        cost: Integer;
        distance: array[250, 250] of Integer;
        i: Integer;
        j: Integer;
        minVal: Integer;
        sourceWordCount: Integer;
        targetWordCount: Integer;
    begin
        //HEI.39>>
        // Compute Levenshtein Distance
        if (Source = '') or (Target = '') then
            exit(0);

        sourceWordCount := STRLEN(Source);
        targetWordCount := STRLEN(Target);

        if Source = Target then
            exit(sourceWordCount);


        // Step 1
        if (sourceWordCount = 0) then
            exit(targetWordCount);

        if (targetWordCount = 0) then
            exit(sourceWordCount);

        for i := 1 to 51 do
            for j := 1 to 51 do
                distance[i, j] := 0;

        // Step 2
        for i := 1 to sourceWordCount do
            distance[i, 1] := i;


        for j := 1 to targetWordCount do
            distance[1, j] := j;

        for i := 2 to sourceWordCount do
            for j := 2 to targetWordCount do begin
                // Step 3
                if (Target[j - 1] = Source[i - 1]) then
                    cost := 0
                else
                    cost := 1;
                // Step 4
                if distance[i - 1, j] + 1 > distance[i, j - 1] + 1 then
                    minVal := distance[i, j - 1] + 1
                else
                    minVal := distance[i - 1, j] + 1;

                if distance[i - 1, j - 1] + cost > minVal then
                    distance[i, j] := minVal
                else
                    distance[i, j] := distance[i - 1, j - 1] + cost;
            end;

        exit(distance[sourceWordCount, targetWordCount]);
        //HEI.39<<
    end;

    procedure CreatePODocumentLogOnInsert(PurchaseLine: Record "Purchase Line");
    var
        PurchaseDocumentLog: Record "Purchase Document Log FND";
        PurchaseHeader: Record "Purchase Header";
        EntryNo: Integer;
    begin

        //<<Hei.45
        PurchaseHeader.RESET();
        PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
        PurchaseHeader.SETRANGE(Status, PurchaseHeader.Status::Open);
        PurchaseHeader.SETRANGE("No.", PurchaseLine."Document No.");
        if PurchaseHeader.FINDFIRST() then begin
            if not (PurchaseHeader."No. Printed" >= 1) then
                exit;
        end;

        if PurchaseLine."Document Type" <> PurchaseLine."Document Type"::Order then
            exit;

        EntryNo := GetMax();
        EntryNo := EntryNo + 1;

        PurchaseDocumentLog.INIT();
        PurchaseDocumentLog."Document Type" := PurchaseLine."Document Type";
        PurchaseDocumentLog."Document No." := PurchaseLine."Document No.";
        PurchaseDocumentLog."Line No." := PurchaseLine."Line No.";
        PurchaseDocumentLog."Entry No." := EntryNo;
        PurchaseDocumentLog."User ID" := USERID;
        PurchaseDocumentLog."Creation Datetime" := CURRENTDATETIME;
        //PurchaseDocumentLog."Old Value" := Oldval;
        //PurchaseDocumentLog."New Value" := NewVal;
        //PurchaseDocumentLog."Field No." := FieldNum;
        PurchaseDocumentLog.Comment := 'New Line Added';
        PurchaseDocumentLog.INSERT();
    end;

    local procedure GetMax(): Integer;
    var
        PurchaseDocumentLog: Record "Purchase Document Log FND";
    begin

        //<<Hei.45
        PurchaseDocumentLog.SETCURRENTKEY("Entry No.");
        if PurchaseDocumentLog.FIND('+') then
            exit(PurchaseDocumentLog."Entry No.");
    end;

    procedure CreatePODocumentLogOnDelete(Rec: Record "Purchase Line");
    var
        PurchaseDocumentLog: Record "Purchase Document Log FND";
        PurchaseHeader: Record "Purchase Header";
        EntryNo: Integer;
    begin
        //<<Hei.45
        PurchaseHeader.RESET();
        PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
        PurchaseHeader.SETRANGE(Status, PurchaseHeader.Status::Open);
        PurchaseHeader.SETRANGE("No.", Rec."Document No.");
        if PurchaseHeader.FINDFIRST() then begin
            if not (PurchaseHeader."No. Printed" >= 1) then
                exit;
        end;

        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;

        EntryNo := GetMax();
        EntryNo := EntryNo + 1;

        PurchaseDocumentLog.INIT();
        PurchaseDocumentLog."Document Type" := Rec."Document Type";
        PurchaseDocumentLog."Document No." := Rec."Document No.";
        PurchaseDocumentLog."Line No." := Rec."Line No.";
        PurchaseDocumentLog."Entry No." := EntryNo;
        PurchaseDocumentLog."User ID" := USERID;
        PurchaseDocumentLog."Creation Datetime" := CURRENTDATETIME;
        PurchaseDocumentLog."No." := Rec."No.";
        PurchaseDocumentLog.Description := Rec.Description;
        PurchaseDocumentLog.Quantity := Rec.Quantity;
        PurchaseDocumentLog."Unit of Measure" := Rec."Unit of Measure";
        PurchaseDocumentLog."Direct Unit Cost" := Rec."Direct Unit Cost";
        PurchaseDocumentLog."Line Amount" := Rec."Line Amount";
        //<<New
        PurchaseDocumentLog.Comment := 'Line Deleted';
        PurchaseDocumentLog.INSERT();

        PurchaseHeader.RESET();
        PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
        PurchaseHeader.SETRANGE(Status, PurchaseHeader.Status::Open);
        PurchaseHeader.SETRANGE("No.", Rec."Document No.");
        PurchaseHeader.SETFILTER("No. Printed", '>=1');
        if PurchaseHeader.FINDFIRST() then begin
            PurchaseHeader."Changed FND" := true;
            PurchaseHeader.MODIFY();
        end;
    end;

    procedure SplitPordOrderItemJNL(RecItemJournalLine: Record "Item Journal Line"; Xrec: Record "Item Journal Line");
    var
        Item: Record Item;
        ItemJnlLine: Record "Item Journal Line";
        ProdOrderComponent: Record "Prod. Order Component";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        ProductionJournalMgtL: Codeunit "Production Journal Mgt";
        CccCodeL: Code[20];
        ProdOrderSplitQty: Decimal;
        NextItemJnlLineNo: Integer;
    begin
        //HEI.48>>

        Item.GET(RecItemJournalLine."Item No.");

        ItemJnlLine.SETRANGE("Journal Template Name", RecItemJournalLine."Journal Template Name");
        ItemJnlLine.SETRANGE("Journal Batch Name", RecItemJournalLine."Journal Batch Name");
        ItemJnlLine.SETRANGE("Document No.", RecItemJournalLine."Document No.");
        if ItemJnlLine.FINDLAST() then
            NextItemJnlLineNo := ItemJnlLine."Line No." + 10000
        else
            NextItemJnlLineNo := 10000;

        CLEAR(ItemJNLtotalQty);
        ItemJnlLine.SETRANGE("Journal Template Name", RecItemJournalLine."Journal Template Name");
        ItemJnlLine.SETRANGE("Journal Batch Name", RecItemJournalLine."Journal Batch Name");
        ItemJnlLine.SETRANGE("Document No.", RecItemJournalLine."Document No.");
        ItemJnlLine.SETRANGE("Prod. Order Comp. Line No.", RecItemJournalLine."Prod. Order Comp. Line No.");
        if ItemJnlLine.findset() then begin
            repeat
                ItemJNLtotalQty += ItemJnlLine.Quantity;
            until ItemJnlLine.NEXT() = 0;
        end;


        ItemJnlLine.INIT();
        ItemJnlLine.VALIDATE("Journal Template Name", RecItemJournalLine."Journal Template Name");
        ItemJnlLine.VALIDATE("Journal Batch Name", RecItemJournalLine."Journal Batch Name");
        ItemJnlLine.VALIDATE("Entry Type", ItemJnlLine."Entry Type"::Consumption);
        ItemJnlLine.VALIDATE("Posting Date", RecItemJournalLine."Posting Date");
        ItemJnlLine."Order Type" := ItemJnlLine."Order Type"::Production;
        ItemJnlLine."Order No." := RecItemJournalLine."Order No.";
        ItemJnlLine."Source No." := RecItemJournalLine."Item No.";
        ItemJnlLine."Source Type" := ItemJnlLine."Source Type"::Item;
        ItemJnlLine."Order Line No." := RecItemJournalLine."Order Line No.";
        ItemJnlLine."Document No." := RecItemJournalLine."Document No.";
        ItemJnlLine.VALIDATE("Item No.", RecItemJournalLine."Item No.");
        ItemJnlLine.VALIDATE("Line No.", NextItemJnlLineNo);
        if ItemJnlLine."Unit of Measure Code" <> RecItemJournalLine."Unit of Measure Code" then
            ItemJnlLine.VALIDATE("Unit of Measure Code", RecItemJournalLine."Unit of Measure Code");
        ItemJnlLine."Qty. per Unit of Measure" := RecItemJournalLine."Qty. per Unit of Measure";
        ItemJnlLine.Description := RecItemJournalLine.Description;

        ProdOrderComponent.RESET();
        ProdOrderComponent.SETFILTER("Prod. Order No.", RecItemJournalLine."Document No.");
        ProdOrderComponent.SETRANGE("Line No.", RecItemJournalLine."Prod. Order Comp. Line No.");
        ProdOrderComponent.SETFILTER("Item No.", RecItemJournalLine."Item No.");
        if ProdOrderComponent.FINDFIRST() then
            ProdOrderSplitQty := ProdOrderComponent."Expected Quantity" - (ItemJNLtotalQty);

        if ProdOrderSplitQty < 0 then
            ProdOrderSplitQty := 0
        else
            ProdOrderSplitQty := ProdOrderSplitQty;

        ItemJnlLine.VALIDATE(Quantity, ProdOrderSplitQty);
        ItemJnlLine.VALIDATE("Unit Cost", RecItemJournalLine."Unit Cost");
        ItemJnlLine."Location Code" := RecItemJournalLine."Location Code";
        //<< HEI.63 IBM.AK 06.07.2020
        ItemJnlLine."Zone Code FND" := RecItemJournalLine."Zone Code FND";
        ItemJnlLine.VALIDATE("Bin Code", RecItemJournalLine."Bin Code");
        //>> HEI.63 IBM.AK 06.07.2020
        ItemJnlLine."Variant Code" := RecItemJournalLine."Variant Code";
        ItemJnlLine."Source Code" := RecItemJournalLine."Source Code";
        ItemJnlLine."Gen. Bus. Posting Group" := RecItemJournalLine."Gen. Bus. Posting Group";
        ItemJnlLine."Gen. Prod. Posting Group" := RecItemJournalLine."Gen. Prod. Posting Group";
        ItemJnlLine.Amount := RecItemJournalLine.Amount;
        ItemJnlLine."Routing No." := RecItemJournalLine."Routing No.";
        ItemJnlLine."Routing Reference No." := RecItemJournalLine."Routing Reference No.";
        ItemJnlLine."Prod. Order Comp. Line No." := RecItemJournalLine."Prod. Order Comp. Line No.";
        //ItemJnlLine."Item Charge Value" :=  RecItemJournalLine."Item Charge Value";  // BC Upgrade NANDIS03 - Blocked as DIT field
        ItemJnlLine."Dimension Set ID" := RecItemJournalLine."Dimension Set ID";
        ItemJnlLine."Unit Amount" := RecItemJournalLine."Unit Amount";
        ItemJnlLine."Unit Cost" := RecItemJournalLine."Unit Cost";
        //ItemJnlLine."Lot No." :=  'REQUIRED';
        if Item."Item Tracking Code" <> '' then
            ItemTrackingMgt.CopyItemTracking(ItemJnlLine.RowID1(), RecItemJournalLine.RowID1(), false);
        //HEI.97>>
        CLEAR(CccCodeL);
        if (ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Consumption) and
          (ItemJnlLine."Order Type" = ItemJnlLine."Order Type"::Production) then
            // if ProductionJournalMgtL.UpdateCccCode(ItemJnlLine,CccCodeL) then  // BC Upgrade NANDIS03 - CU 5510 yet to be compiled
            //   ItemJnlLine.VALIDATE("Shortcut Dimension 2 Code",CccCodeL);  // BC Upgrade NANDIS03 - CU 5510 yet to be compiled
            //HEI.97<<
            ItemJnlLine.INSERT(true);
        //HEI.48<<
    end;

    // [EventSubscriber(ObjectType::Table, 50013, 'OnAfterInsertEvent', '', false, false)]
    // local procedure T50006OnAfterInsert(var Rec : Record "Interface Log Comp. Detail";RunTrigger : Boolean);
    // var
    //     InterfaceLogHeader : Record "Interface Log Header";
    //     GeneralLedgerSetup : Record "General Ledger Setup";
    //     InterfaceLogCompDetail : Record "Interface Log Comp. Detail";
    //     Customer : Record Customer;
    // begin
    //     //HEI.61>>
    //     //HEI.41>>

    //     GeneralLedgerSetup.GET;
    //     case Rec."Table ID" of
    //        DATABASE::"Customer Attributes FND":
    //         begin
    //           InterfaceLogHeader.GET(Rec."Header Entry No.");

    //           if InterfaceLogHeader."Source No." = '' then
    //             if InterfaceLogCompDetail.GET(Rec."Header Entry No.",1,18,1,50036) then begin
    //               Customer.RESET;
    //               Customer.SETRANGE("Customer Description FND",InterfaceLogCompDetail.Value);
    //               if Customer.FINDFIRST then
    //                 InterfaceLogHeader."Source No." := Customer."No.";
    //             end;
    //           case Rec."Field ID" of
    //             1:
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",GeneralLedgerSetup."Customer Dimension Code",Rec.Value);
    //             2:
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",'CUST TYPE',Rec.Value);
    //             5:
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",GeneralLedgerSetup."Business Type Dimension Code",Rec.Value);
    //             6:
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",'ORG_SEG',Rec.Value);
    //             7:
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",'"Channel FND"',Rec.Value);
    //             43:
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",'KEY ACCOUNT',Rec.Value);
    //             46:
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",GeneralLedgerSetup."OPCO Dimension Code",Rec.Value);
    //             53:
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",'MARKET',Rec.Value);
    //           end;
    //         end;
    //        DATABASE::Customer:
    //         begin
    //           /*
    //           InterfaceLogHeader.GET(Rec."Header Entry No.");

    //           IF InterfaceLogHeader."Source No." = '' THEN
    //             IF InterfaceLogCompDetail.GET(Rec."Header Entry No.",1,18,1,50036) THEN BEGIN
    //               Customer.RESET;
    //               Customer.SETRANGE("Customer Description FND",InterfaceLogCompDetail.Value);
    //               IF Customer.FINDFIRST THEN
    //                 InterfaceLogHeader."Source No." := Customer."No.";
    //             end;
    //           */
    //           case Rec."Field ID" of
    //          50036:
    //            begin
    //              InterfaceLogHeader.GET(Rec."Header Entry No.");

    //              if InterfaceLogHeader."Source No." = '' then begin
    //                 Customer.RESET;
    //                 Customer.SETRANGE("Customer Description FND",Rec.Value);
    //                 if Customer.FINDFIRST then
    //                   InterfaceLogHeader."Source No." := Customer."No.";
    //              end;
    //              if InterfaceLogCompDetail.GET(Rec."Header Entry No.",1,18,1,35) then
    //                CreateCustDefaultDim(InterfaceLogHeader."Source No.",'COUNTRY_REGION CODE',InterfaceLogCompDetail.Value);
    //              if InterfaceLogCompDetail.GET(Rec."Header Entry No.",1,18,1,2014067) then
    //                CreateCustDefaultDim(InterfaceLogHeader."Source No.",'DIR_INDIR',InterfaceLogCompDetail.Value);
    //              if InterfaceLogCompDetail.GET(Rec."Header Entry No.",1,18,1,5900) then
    //                CreateCustDefaultDim(InterfaceLogHeader."Source No.",'SERVICE ZONE',InterfaceLogCompDetail.Value);
    //            end;
    //            2014067:
    //             begin
    //               InterfaceLogHeader.GET(Rec."Header Entry No.");

    //                if InterfaceLogHeader."Source No." = '' then
    //                  if InterfaceLogCompDetail.GET(Rec."Header Entry No.",1,18,1,50036) then begin
    //                    Customer.RESET;
    //                    Customer.SETRANGE("Customer Description FND",InterfaceLogCompDetail.Value);
    //                    if Customer.FINDFIRST then
    //                      InterfaceLogHeader."Source No." := Customer."No.";
    //                  end;
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",'DIR_INDIR',Rec.Value);
    //             end;
    //             /*
    //             35:
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",'COUNTRY_REGION CODE',Rec.Value);
    //        2014067:
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",'DIR_INDIR',Rec.Value);
    //           5900:
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",'SERVICE ZONE',Rec.Value);
    //             */
    //           end;
    //         end;
    //     end;
    //     //HEI.41<<
    //     //HEI.61<<
    // end;  // BC Upgrade NANDIS03 - moved ro Interface Framework extension

    // [EventSubscriber(ObjectType::Table, 23, 'OnBeforeInsertEvent', '', false, false)]
    // local procedure T23OnBeforeInsertShared(var Rec : Record Vendor;RunTrigger : Boolean);
    // var
    //     CommonSourceSharingSetup : Record "Common Src Sharing Setup FND";
    //     GlobalNoSeries : Record "Global No. Series FND";
    //     GlobalNoSeriesManagement : Codeunit GlobalNoSeriesManagement;
    //     GlobalSharedSource : Record "Global Shared Source FND";
    //     SessionGlobals : Codeunit "Session Globals";
    //     ErrorTxt : Label 'Vendor with Global Id: %1, Local Id: %2 already exists in Company: %3 !';
    //     GenericWebServiceClient : Codeunit "Generic Web Service Client";
    //     GeneralInterfaceSetup : Record "General Interface Setup";
    //     Read : Boolean;
    //     GenericWebServiceClient2 : Codeunit "Generic Web Service Client";
    //     GenericWebServiceClient3 : Codeunit "Generic Web Service Client";
    // begin
    //     //>> HEI.65
    //     if (Rec.ISTEMPORARY) or (SessionGlobals.GetVendorGlobalNo = '') then //HEI.79
    //       exit;
    //     //>> HEI.68
    //     if CommonSourceSharingSetup.GET then begin
    //       if not CommonSourceSharingSetup."Database Level Sharing" then begin //HEI.79
    //         if CommonSourceSharingSetup."Enable Common Vendor Sharing" then begin
    //           GlobalSharedSource.RESET;
    //           GlobalSharedSource.SETRANGE("Source Type",GlobalSharedSource."Source Type"::Vendor);
    //           GlobalSharedSource.SETRANGE("Global ID",SessionGlobals.GetVendorGlobalNo);
    //           GlobalSharedSource.SETRANGE(Blocked,false);
    //           if GlobalSharedSource.FINDFIRST then begin
    //             Rec."No." := GlobalSharedSource."Local ID";
    //           end else
    //             begin
    //               CommonSourceSharingSetup.TESTFIELD("Global Vendor No. Series");
    //               if GlobalNoSeries.GET(CommonSourceSharingSetup."Global Vendor No. Series") then
    //                 GlobalNoSeriesManagement.InitGlobalSeries(GlobalNoSeries.Code,Rec."No. Series",
    //                                                           0D,Rec."No.",Rec."No. Series");
    //             end;
    //       end else
    //       exit;
    //     //<< HEI.68
    //     end else begin
    //         //>>HEI.79
    //         GeneralInterfaceSetup.GET;
    //         GenericWebServiceClient.CONNECT(CommonSourceSharingSetup."WS Link");
    //         GenericWebServiceClient.INIT;
    //         GenericWebServiceClient.SETFILTER('Source_Type','Vendor');
    //         GenericWebServiceClient.SETFILTER('Global_ID',SessionGlobals.GetVendorGlobalNo);
    //         GenericWebServiceClient.SETFILTER('Blocked','false');
    //         if GenericWebServiceClient.READMULTIPLE then
    //           Rec."No." := GenericWebServiceClient.GETVALUE('Local_ID')
    //         else
    //           begin
    //             GenericWebServiceClient2.CONNECT(CommonSourceSharingSetup."Source Sharing Setup WS Link");
    //             GenericWebServiceClient2.SETFILTER('Database_Level_Sharing','true');
    //             if GenericWebServiceClient2.READMULTIPLE then
    //               if GenericWebServiceClient2.GETVALUE('Global_Vendor_No_Series') <> '' then begin
    //                 GenericWebServiceClient3.CONNECT(CommonSourceSharingSetup."Global No. Series WS Link");
    //                 GenericWebServiceClient3.SETFILTER('Code',GenericWebServiceClient2.GETVALUE('Global_Vendor_No_Series'));
    //                 if GenericWebServiceClient3.READMULTIPLE then begin
    //                   NoSeriesWebRequest(GenericWebServiceClient2.GETVALUE('Global_Vendor_No_Series'),Rec."No. Series",
    //                                      TODAY,Rec."No.",Rec."No.");
    //                   Rec.VALIDATE("No.",GenericWebServiceClient3.GETVALUE('LastNoUsed'));
    //                 end;
    //               end;
    //               GenericWebServiceClient.RESET;
    //               GenericWebServiceClient2.RESET;
    //               GenericWebServiceClient3.RESET;
    //             end;
    //           end;
    //       end;
    //       //<<HEI.79
    //     //<< HEI.65
    // end;  // BC Upgrade NANDIS03 - moved ro Interface Framework extension

    // [EventSubscriber(ObjectType::Table, 23, 'OnAfterValidateEvent', 'Global Vendor Number', false, false)]
    // local procedure T23OnAfterValidateVendorGlobNoShared(var Rec : Record Vendor;var xRec : Record Vendor;CurrFieldNo : Integer);
    // var
    //     GlobalSharedSource : Record "Global Shared Source FND";
    //     CommonSourceSharingSetup : Record "Common Src Sharing Setup FND";
    //     GenericWebServiceClient : Codeunit "Generic Web Service Client";
    //     Vendor : Record Vendor;
    // begin
    //     //>> HEI.65
    //     if Rec.ISTEMPORARY then
    //       exit;

    //     //>> HEI.68
    //     if CommonSourceSharingSetup.GET then
    //       if not CommonSourceSharingSetup."Database Level Sharing" then begin //HEI.79
    //         if not CommonSourceSharingSetup."Enable Common Vendor Sharing" then
    //           exit;
    //     //<< HEI.68

    //       if (Rec."Global Vendor Number" = xRec."Global Vendor Number") or (Rec."Global Vendor Number" = '') then
    //         exit;

    //       GlobalSharedSource.INIT;
    //       GlobalSharedSource."Source Type" := GlobalSharedSource."Source Type"::Vendor;
    //       GlobalSharedSource."Global ID" := Rec."Global Vendor Number";
    //       GlobalSharedSource."Local ID" := Rec."No.";
    //       GlobalSharedSource."Company ID" := COMPANYNAME;
    //       GlobalSharedSource.Blocked := false;
    //       GlobalSharedSource.INSERT;
    //     //>> HEI.79
    //       end else
    //         begin
    //           if (Rec."Global Vendor Number" = xRec."Global Vendor Number") or (Rec."Global Vendor Number" = '') then
    //             exit;

    //         Vendor.SETRANGE("Global Vendor Number",Rec."Global Vendor Number");
    //         if not Vendor.FINDFIRST then begin
    //           if CommonSourceSharingSetup."Database Level Sharing" = true then begin //HEI.82
    //             GenericWebServiceClient.CONNECT(CommonSourceSharingSetup."WS Link");
    //             GenericWebServiceClient.SETFILTER('Global_ID',Rec."Global Vendor Number");
    //             GenericWebServiceClient.SETFILTER('Local_ID',Rec."No.");
    //             GenericWebServiceClient.SETFILTER('Company_ID',COMPANYNAME);
    //             GenericWebServiceClient.SETFILTER('Blocked','false');
    //             if GenericWebServiceClient.READMULTIPLE then
    //               GenericWebServiceClient.DELETE;
    //           end; //HEI.82
    //         end;
    //           GenericWebServiceClient.CONNECT(CommonSourceSharingSetup."WS Link");
    //           GenericWebServiceClient.INIT;
    //           GenericWebServiceClient.SETVALUE('Source_Type','Vendor');
    //           GenericWebServiceClient.SETVALUE('Global_ID',Rec."Global Vendor Number");
    //           GenericWebServiceClient.SETVALUE('Local_ID',Rec."No.");
    //           GenericWebServiceClient.SETVALUE('Company_ID',COMPANYNAME);
    //           GenericWebServiceClient.SETVALUE('Blocked',false);
    //           GenericWebServiceClient.CREATE;
    //       end;
    //       //GenericWebServiceClient.RESET; // HEI.82
    //     //<< HEI.79
    //     //<< HEI.65
    // end;  // BC Upgrade NANDIS03 - moved to Interface Framework extension

    // [EventSubscriber(ObjectType::Table, 23, 'OnAfterValidateEvent', 'Global Delete', false, false)]
    // local procedure T23OnAfterValidateGlobalDeleteShared(var Rec : Record Vendor;var xRec : Record Vendor;CurrFieldNo : Integer);
    // var
    //     GlobalSharedSource : Record "Global Shared Source FND";
    //     CommonSourceSharingSetup : Record "Common Src Sharing Setup FND";
    //     GenericWebServiceClient : Codeunit "Generic Web Service Client";
    // begin
    //     //>> HEI.68
    //     if Rec.ISTEMPORARY then
    //       exit;

    //     if CommonSourceSharingSetup.GET then
    //         if not CommonSourceSharingSetup."Database Level Sharing" then begin //HEI.79
    //           if not CommonSourceSharingSetup."Enable Common Vendor Sharing" then
    //             exit;

    //         if Rec."Global Delete" = true then begin
    //           GlobalSharedSource.RESET;
    //           GlobalSharedSource.SETRANGE("Source Type",GlobalSharedSource."Source Type"::Vendor);
    //           GlobalSharedSource.SETRANGE("Global ID",Rec."Global Vendor Number");
    //           GlobalSharedSource.SETRANGE("Local ID",Rec."No.");
    //           GlobalSharedSource.SETRANGE("Company ID",COMPANYNAME);
    //           GlobalSharedSource.SETRANGE(Blocked,false);
    //           if GlobalSharedSource.FINDFIRST then begin
    //             GlobalSharedSource.RENAME(GlobalSharedSource."Global ID",GlobalSharedSource."Local ID",GlobalSharedSource."Company ID",Rec."Global Delete");
    //           end;
    //         end;
    //         end else
    //         begin
    //         //>> HEI.79
    //           GenericWebServiceClient.CONNECT(CommonSourceSharingSetup."WS Link");
    //           if Rec."Global Delete" = true then begin
    //             GenericWebServiceClient.SETFILTER('Global_ID',Rec."Global Vendor Number");
    //             GenericWebServiceClient.SETFILTER('Local_ID',Rec."No.");
    //             GenericWebServiceClient.SETFILTER('Company_ID',COMPANYNAME);
    //             GenericWebServiceClient.SETFILTER('Blocked','false');
    //             if GenericWebServiceClient.READMULTIPLE then begin
    //               GenericWebServiceClient.SETVALUE('Global_ID',GenericWebServiceClient.GETVALUE('Global_ID'));
    //               GenericWebServiceClient.SETVALUE('Local_ID',GenericWebServiceClient.GETVALUE('Local_ID'));
    //               GenericWebServiceClient.SETVALUE('Company_ID',GenericWebServiceClient.GETVALUE('Company_ID'));
    //               GenericWebServiceClient.SETVALUE('Blocked',Rec."Global Delete");
    //               GenericWebServiceClient.UPDATE;
    //             end;
    //           end;
    //           GenericWebServiceClient.RESET; //HEI.82
    //         end;
    //       //GenericWebServiceClient.RESET; //HEI.82
    //       //<< HEI.79

    //     //<< HEI.68
    // end;  // BC Upgrade NANDIS03 - moved to Interface Framework extension

    // [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostSalesDoc', '', false, false)]
    // local procedure OnBeforePostSalesDoc(var SalesHeader : Record "Sales Header");
    // var
    //     locRoute : Record Route;
    // begin
    //     //>> HEI.60 FDD-HT658 IBM.GUNERE01 18.09.2019
    //     if SalesHeader.ISTEMPORARY then
    //       exit;

    //     if SalesHeader.Route <> '' then
    //      CheckMandatoryFieldsForRouteOnSalesDoc(SalesHeader);
    //     //<< HEI.60 FDD-HT658 IBM.GUNERE01 18.09.2019
    // end;  // BC Upgrade NANDIS03 - BLocked due to dependencies in DIT table

    // local procedure CheckDistanceOnSalesDocFromDocShippingCosts(var SalesHeader : Record "Sales Header") : Boolean;
    // var
    //     DocumentShippingCost : Record "Document Shipping Cost";
    // begin
    //     //>> HEI.60 FDD-HT658 IBM.GUNERE01 18.09.2019
    //     DocumentShippingCost.RESET;
    //     DocumentShippingCost.SETRANGE("Source Type",DATABASE::"Sales Header");
    //     DocumentShippingCost.SETRANGE("Source No.",SalesHeader."No.");
    //     DocumentShippingCost.SETRANGE("Sub Type",SalesHeader."Document Type");
    //     DocumentShippingCost.SETRANGE("Cost By Distance",true);
    //     if DocumentShippingCost.FINDFIRST then
    //       if SalesHeader.Distance = 0 then
    //         exit(false)
    //       else
    //         exit(true)
    //     else
    //       exit(true);
    //     //<< HEI.60 FDD-HT658 IBM.GUNERE01 18.09.2019
    // end;  // BC Upgrade NANDIS03 - BLocked due to dependencies in DIT table

    // [EventSubscriber(ObjectType::Codeunit, 414, 'OnBeforeReleaseSalesDoc', '', false, false)]
    // local procedure OnBeforeReleaseSalesDoc(var SalesHeader : Record "Sales Header";PreviewMode : Boolean);
    // begin
    //     //>> HEI.60 FDD-HT658 IBM.GUNERE01 18.09.2019
    //     if SalesHeader.ISTEMPORARY then
    //       exit;

    //     GetSalesSetup;//HEI.123

    //     if SalesHeader.Route <> '' then
    //       CheckMandatoryFieldsForRouteOnSalesDoc(SalesHeader);

    //     //HEI.123>>
    //     if (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) and (SalesHeader."Source System Identifier" = '') and
    //       SalesSetup."Shipment Date Mandatory" then
    //       SalesHeader.TESTFIELD("Shipment Date");
    //     //HEI.123<<
    //     //<< HEI.60 FDD-HT658 IBM.GUNERE01 18.09.2019
    // end;  // BC Upgrade NANDIS03 - BLocked due to dependencies in DIT table's field

    // local procedure CheckMandatoryFieldsForRouteOnSalesDoc(var SalesHeader : Record "Sales Header");
    // var
    //     locRoute : Record Route;
    //     ErrorText01 : Label 'Distance cannot be zero if Document Shipping Cost is Cost By Distance!';
    // begin
    //     //>> HEI.60 FDD-HT658 IBM.GUNERE01 18.09.2019
    //     if not CheckDistanceOnSalesDocFromDocShippingCosts(SalesHeader) then
    //       ERROR(ErrorText01);
    //     //<< HEI.60 FDD-HT658 IBM.GUNERE01 18.09.2019
    // end;  // BC Upgrade NANDIS03 - BLocked due to dependencies in DIT table's field

    // [EventSubscriber(ObjectType::Codeunit, 5705, 'OnBeforeTransferOderPostReceipt', '', false, false)]
    // local procedure OnBeforeTransferOderPostReceipt(var TransferHeader : Record "Transfer Header");
    // begin
    //     //>> HEI.60 FDD-HT658 IBM.GUNERE01 18.09.2019
    //     if TransferHeader.ISTEMPORARY then
    //       exit;

    //     if TransferHeader.Route <> '' then
    //       CheckMandatoryFieldsForRouteOnTransferOrder(TransferHeader);
    //     //<< HEI.60 FDD-HT658 IBM.GUNERE01 18.09.2019
    // end;  // BC Upgrade NANDIS03 - BLocked due to dependencies in DIT table's field

    // [EventSubscriber(ObjectType::Codeunit, 5704, 'OnBeforeTransferOrderPostShipment', '', false, false)]
    // local procedure OnBeforeTransferOrderPostShipment(var TransferHeader : Record "Transfer Header");
    // begin
    //     //>> HEI.60 FDD-HT658 IBM.GUNERE01 18.09.2019
    //     if TransferHeader.ISTEMPORARY then
    //       exit;

    //     if TransferHeader.Route <> '' then
    //       CheckMandatoryFieldsForRouteOnTransferOrder(TransferHeader);
    //     //<< HEI.60 FDD-HT658 IBM.GUNERE01 18.09.2019
    // end;  // BC Upgrade NANDIS03 - BLocked due to dependencies in DIT table's field

    // local procedure CheckDistanceOnTransferOrderFromDocShippingCosts(var TransferHeader : Record "Transfer Header") : Boolean;
    // var
    //     DocumentShippingCost : Record "Document Shipping Cost";
    // begin
    //     //>> HEI.60 FDD-HT658 IBM.GUNERE01 18.09.2019
    //     DocumentShippingCost.RESET;
    //     DocumentShippingCost.SETRANGE("Source Type",DATABASE::"Transfer Header");
    //     DocumentShippingCost.SETRANGE("Source No.",TransferHeader."No.");
    //     DocumentShippingCost.SETRANGE("Cost By Distance",true);
    //     if DocumentShippingCost.FINDFIRST then
    //       if TransferHeader.Distance = 0 then
    //         exit(false)
    //       else
    //         exit(true)
    //     else
    //       exit(true);
    //     //<< HEI.60 FDD-HT658 IBM.GUNERE01 18.09.2019
    // end;  // BC Upgrade NANDIS03 - BLocked due to dependencies in DIT table's field

    // local procedure CheckMandatoryFieldsForRouteOnTransferOrder(var TransferHeader : Record "Transfer Header");
    // var
    //     locRoute : Record Route;
    //     ErrorText01 : Label 'Distance cannot be zero if Document Shipping Cost is Cost By Distance!';
    // begin
    //     if not CheckDistanceOnTransferOrderFromDocShippingCosts(TransferHeader) then
    //       ERROR(ErrorText01);
    // end;  // // BC Upgrade NANDIS03 - BLocked due to dependencies in DIT table's field

    procedure CheckConsumptionLines(var ItemJournalLine: Record "Item Journal Line") Post: Boolean;
    var
        DefaultDimensionL: Record "Default Dimension";
        DimensionValueL: Record "Dimension Value";
        ItemJnlLine: Record "Item Journal Line";
        ItemJournalLine1: Record "Item Journal Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        Location: Record Location;
        ManufacturingSetup: Record "Manufacturing Setup";
        ProdOrderComponent: Record "Prod. Order Component";
        ProdOrderLine: Record "Prod. Order Line";
        UserSetup: Record "User Setup";
        Print: Boolean;
        ActualConOutput: Decimal;
        ConsmpQtyL: Decimal;
        MaxValue: Decimal;
        MinValue: Decimal;
        PostedQty: Decimal;
        "Count": Integer;
        ErrorConsumption: Label 'Consumption Quantity %1 of Item %2 is out of Target range %3 to %4.';
        Text001L: Label 'There is added incorrect "Dimention Value" on "CMG Values for Negative Consmp" in "Manufacturing Setup".';
        Text022: Label 'Consump. Tolerance Limit% from %1 location code is null.';
        Text023: Label '"Setup for “Consump. Tolerance Limit” is disabled. "';
        Text024: Label 'Posting has been cancelled.';
        WarningConsumption: Label 'Consumption Quantity %1 of Item %2 is out of Target range %3 to %4. Would you like to continue?';
    begin
        //HEI.57<<
        Post := true;
        UserSetup.GET(USERID);
        ManufacturingSetup.GET();
        if ManufacturingSetup."Consump. Tolerance Limit FND" then begin
            //HEI.88>>
            ItemJournalLine1.SETCURRENTKEY("Journal Batch Name", "Journal Template Name", "Order No.", "Order Line No.", "Entry Type", Quantity);
            //HEI.88<<
            ItemJournalLine1.SETRANGE("Journal Batch Name", ItemJournalLine."Journal Batch Name");
            ItemJournalLine1.SETRANGE("Journal Template Name", ItemJournalLine."Journal Template Name");
            ItemJournalLine1.SETRANGE("Order No.", ItemJournalLine."Order No.");
            ItemJournalLine1.SETRANGE("Order Line No.", ItemJournalLine."Order Line No.");
            ItemJournalLine1.SETRANGE("Entry Type", ItemJournalLine."Entry Type"::Output);
            ItemJournalLine1.SETFILTER(Quantity, '<>%1', 0);
            if ItemJournalLine1.FINDFIRST() then begin
                Location.GET(ItemJournalLine1."Location Code");
                if Location."Consump. Tolerance Limit % FND" <> 0 then begin
                    //HEI.73<<
                    CLEAR(ActualConOutput);
                    ItemLedgerEntry.RESET();
                    //HEI.88>>
                    ItemLedgerEntry.SETCURRENTKEY("Item No.", "Order No.", "Prod. Order Comp. Line No.");
                    //HEI.88<<
                    ItemLedgerEntry.SETRANGE("Item No.", ItemJournalLine1."Item No.");
                    ItemLedgerEntry.SETRANGE("Order No.", ItemJournalLine1."Order No.");
                    ItemLedgerEntry.SETRANGE("Prod. Order Comp. Line No.", ItemJournalLine1."Prod. Order Comp. Line No.");
                    if ItemLedgerEntry.findset() then
                        repeat
                            //ActualConOutput += ItemLedgerEntry.Quantity; //HEI.76 commented
                            ActualConOutput += ItemLedgerEntry.Quantity / ItemLedgerEntry."Qty. per Unit of Measure"; //HEI.76
                        until ItemLedgerEntry.NEXT() = 0;
                    //HEI.73>>
                    //HEI.88>>
                    ProdOrderLine.SETCURRENTKEY(Status, "Prod. Order No.", "Line No.");
                    //HEI.88<<
                    ProdOrderLine.SETRANGE(Status, ProdOrderLine.Status::Released);
                    ProdOrderLine.SETRANGE("Prod. Order No.", ItemJournalLine1."Order No.");
                    ProdOrderLine.SETRANGE("Line No.", ItemJournalLine1."Order Line No.");
                    if ProdOrderLine.FINDFIRST() then begin
                        //HEI.88>>
                        ProdOrderComponent.SETCURRENTKEY(Status, "Prod. Order No.", "Prod. Order Line No.");
                        //HEI.88<<
                        ProdOrderComponent.SETRANGE(Status, ProdOrderComponent.Status::Released);
                        ProdOrderComponent.SETRANGE("Prod. Order No.", ItemJournalLine1."Order No.");
                        ProdOrderComponent.SETRANGE("Prod. Order Line No.", ItemJournalLine1."Order Line No.");
                        if ProdOrderComponent.findset() then
                            repeat
                                //HEI.88>>
                                CLEAR(PostedQty);
                                CLEAR(MinValue);
                                CLEAR(MaxValue);
                                //HEI.90>>
                                CLEAR(ConsmpQtyL);
                                //HEI.90<<
                                ItemJnlLine.RESET();
                                ItemJnlLine.SETCURRENTKEY("Journal Batch Name", "Journal Template Name", "Order No.", "Order Line No.", "Prod. Order Comp. Line No.", "Item No.");
                                //HEI.88<<
                                ItemJnlLine.SETRANGE("Journal Batch Name", ItemJournalLine1."Journal Batch Name");
                                ItemJnlLine.SETRANGE("Journal Template Name", ItemJournalLine1."Journal Template Name");
                                ItemJnlLine.SETRANGE("Order No.", ItemJournalLine1."Order No.");
                                ItemJnlLine.SETRANGE("Order Line No.", ItemJournalLine1."Order Line No.");
                                ItemJnlLine.SETRANGE("Prod. Order Comp. Line No.", ProdOrderComponent."Line No.");
                                ItemJnlLine.SETRANGE("Item No.", ProdOrderComponent."Item No.");
                                //HEI.88>>
                                if ItemJnlLine.COUNT <= 1 then begin
                                    //HEI.88<<
                                    if ItemJnlLine.FINDFIRST() then begin
                                        //HEI.108>>
                                        if (ManufacturingSetup."CMG Dimension Code FND" <> '') and (ManufacturingSetup."CMG Values for Neg Consmp FND" <> '') then begin
                                            DimensionValueL.RESET();
                                            DimensionValueL.SETCURRENTKEY("Dimension Code", Code);
                                            DimensionValueL.SETRANGE("Dimension Code", ManufacturingSetup."CMG Dimension Code FND");
                                            DimensionValueL.SETFILTER(Code, ManufacturingSetup."CMG Values for Neg Consmp FND");
                                            if DimensionValueL.ISEMPTY then
                                                ERROR(Text001L)
                                            else begin
                                                Post := false;
                                                DefaultDimensionL.RESET();
                                                DefaultDimensionL.SETCURRENTKEY("Table ID", "No.", "Dimension Code", "Dimension Value Code");
                                                DefaultDimensionL.SETRANGE("Table ID", DATABASE::Item);
                                                DefaultDimensionL.SETRANGE("No.", ItemJnlLine."Item No.");
                                                DefaultDimensionL.SETRANGE("Dimension Code", ManufacturingSetup."CMG Dimension Code FND");
                                                DefaultDimensionL.SETFILTER("Dimension Value Code", ManufacturingSetup."CMG Values for Neg Consmp FND");
                                                if DefaultDimensionL.FINDFIRST() then begin
                                                    Post := true;
                                                    exit(Post);
                                                end else
                                                    Post := true;
                                            end;
                                        end;
                                        //HEI.108<<
                                        if (ProdOrderComponent."Remaining Quantity" <> ItemJnlLine.Quantity) then begin
                                            //MinValue := (1 - (Location."Consump. Tolerance Limit % FND" / 100)) * ProdOrderComponent."Expected Quantity" * ((ItemJournalLine1."Output Quantity (Base)" + ActualConOutput) / ProdOrderLine.Quantity); //HEI.73 //HEI.76 commented
                                            //MaxValue := (1 + (Location."Consump. Tolerance Limit % FND" / 100)) * ProdOrderComponent."Expected Quantity" * ((ItemJournalLine1."Output Quantity (Base)" + ActualConOutput)  / ProdOrderLine.Quantity);//HEI.73 //HEI.76 commented
                                            MinValue := (1 - (Location."Consump. Tolerance Limit % FND" / 100)) * ProdOrderComponent."Expected Quantity" * ((ItemJournalLine1."Output Quantity" + ActualConOutput) / ProdOrderLine.Quantity); //HEI.76
                                            MaxValue := (1 + (Location."Consump. Tolerance Limit % FND" / 100)) * ProdOrderComponent."Expected Quantity" * ((ItemJournalLine1."Output Quantity" + ActualConOutput) / ProdOrderLine.Quantity); //HEI.76
                                            PostedQty := ProdOrderComponent."Expected Quantity" - ProdOrderComponent."Remaining Quantity" + ItemJnlLine.Quantity;
                                            //IF (ABS(PostedQty) <> ABS(ItemJournalLine1."Output Quantity")) THEN //HEI.73 commented
                                            //IF (ABS(PostedQty) <> ABS(ItemJournalLine1."Output Quantity")) THEN //HEI.76 commented
                                            if (ABS(PostedQty) < ABS(MinValue)) or (ABS(PostedQty) > ABS(MaxValue)) then //HEI.76
                                                if (UserSetup."Consump. Tolerance Warning FND" = false) then
                                                    ERROR(ErrorConsumption, PostedQty, ProdOrderComponent."Item No.", MinValue, MaxValue)
                                                else
                                                  //<<HEI.96
                                                  begin
                                                    if GUIALLOWED then begin
                                                        //>>HEI.96
                                                        if CONFIRM(WarningConsumption, true, PostedQty, ProdOrderComponent."Item No.", MinValue, MaxValue) then
                                                            Post := true
                                                        else
                                                            Post := false;
                                                        //<<HEI.96
                                                    end else
                                                        Post := true;
                                                end;
                                            //>>HEI.96

                                        end;
                                    end else begin
                                        //MinValue := (1 - (Location."Consump. Tolerance Limit % FND" / 100)) * ProdOrderComponent."Expected Quantity" * ((ItemJournalLine1."Output Quantity (Base)" + ActualConOutput) / ProdOrderLine.Quantity); //HEI.73 //HEI.76 commented
                                        //MaxValue := (1 + (Location."Consump. Tolerance Limit % FND" / 100)) * ProdOrderComponent."Expected Quantity" * ((ItemJournalLine1."Output Quantity (Base)" + ActualConOutput)  / ProdOrderLine.Quantity);//HEI.73 //HEI.76 commented
                                        MinValue := (1 - (Location."Consump. Tolerance Limit % FND" / 100)) * ProdOrderComponent."Expected Quantity" * ((ItemJournalLine1."Output Quantity" + ActualConOutput) / ProdOrderLine.Quantity); //HEI.76
                                        MaxValue := (1 + (Location."Consump. Tolerance Limit % FND" / 100)) * ProdOrderComponent."Expected Quantity" * ((ItemJournalLine1."Output Quantity" + ActualConOutput) / ProdOrderLine.Quantity); //HEI.76
                                        PostedQty := ProdOrderComponent."Expected Quantity" - ProdOrderComponent."Remaining Quantity";
                                        if (ABS(PostedQty) < ABS(MinValue)) or (ABS(PostedQty) > ABS(MaxValue)) then
                                            //IF (ABS(PostedQty) <> ABS(ItemJournalLine1."Output Quantity")) THEN //HEI.73 commented
                                            if (UserSetup."Consump. Tolerance Warning FND" = false) then
                                                ERROR(ErrorConsumption, PostedQty, ProdOrderComponent."Item No.", MinValue, MaxValue)
                                            else
                                //<<HEI.96
                                begin
                                                if GUIALLOWED then begin
                                                    //>>HEI.96
                                                    if CONFIRM(WarningConsumption, true, PostedQty, ProdOrderComponent."Item No.", MinValue, MaxValue) then
                                                        Post := true
                                                    else
                                                        Post := false;
                                                    //<<HEI.96
                                                end else
                                                    Post := true;
                                            end;
                                        //>>HEI.96

                                    end;
                                    //HEI.88>>
                                end else if ItemJnlLine.COUNT > 1 then begin
                                    if ItemJnlLine.findset() then begin
                                        //HEI.108>>
                                        if (ManufacturingSetup."CMG Dimension Code FND" <> '') and (ManufacturingSetup."CMG Values for Neg Consmp FND" <> '') then begin
                                            DimensionValueL.RESET();
                                            DimensionValueL.SETCURRENTKEY("Dimension Code", Code);
                                            DimensionValueL.SETRANGE("Dimension Code", ManufacturingSetup."CMG Dimension Code FND");
                                            DimensionValueL.SETFILTER(Code, ManufacturingSetup."CMG Values for Neg Consmp FND");
                                            if DimensionValueL.ISEMPTY then
                                                ERROR(Text001L)
                                            else begin
                                                Post := false;
                                                DefaultDimensionL.RESET();
                                                DefaultDimensionL.SETCURRENTKEY("Table ID", "No.", "Dimension Code", "Dimension Value Code");
                                                DefaultDimensionL.SETRANGE("Table ID", DATABASE::Item);
                                                DefaultDimensionL.SETRANGE("No.", ItemJnlLine."Item No.");
                                                DefaultDimensionL.SETRANGE("Dimension Code", ManufacturingSetup."CMG Dimension Code FND");
                                                DefaultDimensionL.SETFILTER("Dimension Value Code", ManufacturingSetup."CMG Values for Neg Consmp FND");
                                                if DefaultDimensionL.FINDFIRST() then begin
                                                    Post := true;
                                                    exit(Post);
                                                end else
                                                    Post := true;
                                            end;
                                        end;
                                        //HEI.108<<
                                        //HEI.90>>
                                        //IF (ProdOrderComponent."Remaining Quantity" <> ItemJnlLine.Quantity) THEN BEGIN
                                        //HEI.90<<
                                        MinValue := (1 - (Location."Consump. Tolerance Limit % FND" / 100)) * ProdOrderComponent."Expected Quantity" * ((ItemJournalLine1."Output Quantity" + ActualConOutput) / ProdOrderLine.Quantity); //HEI.76
                                        MaxValue := (1 + (Location."Consump. Tolerance Limit % FND" / 100)) * ProdOrderComponent."Expected Quantity" * ((ItemJournalLine1."Output Quantity" + ActualConOutput) / ProdOrderLine.Quantity); //HEI.76
                                        repeat
                                            PostedQty := PostedQty + (ProdOrderComponent."Expected Quantity" - ProdOrderComponent."Remaining Quantity" + ItemJnlLine.Quantity);
                                            //HEI.90>>
                                            ConsmpQtyL := ConsmpQtyL + ItemJnlLine.Quantity;
                                        //HEI.90<<
                                        until ItemJnlLine.NEXT() = 0;
                                        //HEI.90>>
                                        if (ProdOrderComponent."Remaining Quantity" <> ConsmpQtyL) then begin
                                            //HEI.90<<
                                            if (ABS(PostedQty) < ABS(MinValue)) or (ABS(PostedQty) > ABS(MaxValue)) then //HEI.76
                                                if UserSetup."Consump. Tolerance Warning FND" = false then
                                                    ERROR(ErrorConsumption, PostedQty, ProdOrderComponent."Item No.", MinValue, MaxValue)
                                                else
                                                  //<<HEI.96
                                                  begin
                                                    if GUIALLOWED then begin
                                                        //>>HEI.96
                                                        if CONFIRM(WarningConsumption, true, PostedQty, ProdOrderComponent."Item No.", MinValue, MaxValue) then
                                                            Post := true
                                                        else
                                                            Post := false;
                                                        //<<HEI.96
                                                    end else
                                                        Post := true;
                                                end;
                                            //>>HEI.96

                                        end;
                                    end;
                                end;
                            //HEI.88<<
                            until ProdOrderComponent.NEXT() = 0;
                    end;
                end;
            end;
        end;
        //HEI.57<<
    end;

    // [EventSubscriber(ObjectType::Table, 38, 'OnBeforeValidateEvent', 'Buy-from Vendor No.', false, false)]
    // local procedure OnBeforeValidateT38VendorNo(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    // begin
    //     //>> HEI.64
    //     if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
    //         if xRec."Buy-from Vendor No." <> '' then begin
    //             if (xRec."Shipping Agent Code" <> '') and (xRec."Shipping Agent Service Code" <> '') then
    //                 WarehouseTransportMgt.DeletePurchShippingCost(xRec, false)
    //             else
    //                 WarehouseTransportMgt.DeletePurchShippingCost(xRec, true);
    //         end else
    //             WarehouseTransportMgt.DeletePurchShippingCost(xRec, true);
    //     //<< HEI.64
    // end;  // BC Upgrade NANDIS03 - Dependencies on DIT fields

    // [EventSubscriber(ObjectType::Table, 36, 'OnBeforeValidateEvent', 'Sell-to Customer No.', false, false)]
    // local procedure OnBeforeValidateT36CustNo(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer);
    // begin
    //     //>> HEI.64
    //     if Rec."Sell-to Customer No." <> xRec."Sell-to Customer No." then
    //         if xRec."Sell-to Customer No." <> '' then begin
    //             if (xRec."Shipping Agent Code" <> '') and (xRec."Shipping Agent Service Code" <> '') then
    //                 WarehouseTransportMgt.DeleteSalesShippingCost(xRec, false)
    //             else
    //                 WarehouseTransportMgt.DeleteSalesShippingCost(xRec, true);
    //         end else
    //             WarehouseTransportMgt.DeleteSalesShippingCost(xRec, true);
    //     //<< HEI.64
    // end;  // BC Upgrade NANDIS03 - Dependencies on DIT fields

    // procedure GetStrengthSpecValue(OrderNo: Code[20]) StrengthSpecValue: Code[10];
    // var
    //     ILE: Record "Item Ledger Entry";
    //     CountLedger: Integer;
    //     StrengthSpecValueTemp: Decimal;
    //     Multipletxt: Label 'VARIABLE';
    // begin
    //     //HEI.67>>
    //     CLEAR(CountLedger);
    //     ILE.RESET;
    //     ILE.SETCURRENTKEY("Order No.");
    //     ILE.SETRANGE("Order No.", OrderNo);
    //     ILE.SETRANGE("Order Type", ILE."Order Type"::Production);
    //     ILE.SETRANGE("Entry Type", ILE."Entry Type"::Output);
    //     if ILE.findset then begin
    //         repeat
    //             CountLedger += 1;
    //             //HEI.87>>
    //             ILE.CALCFIELDS("Strength Spec. Value");
    //             //HEI.87<<
    //             if CountLedger = 1 then
    //                 StrengthSpecValueTemp := ILE."Strength Spec. Value"
    //             else if StrengthSpecValueTemp <> ILE."Strength Spec. Value" then begin
    //                 StrengthSpecValue := Multipletxt;
    //                 //HEI.87>>
    //                 //BREAK;
    //                 //HEI.87<<
    //             end;
    //         //HEI.87>>
    //         //UNTIL ILE.NEXT = 0;
    //         until (ILE.NEXT = 0) or (StrengthSpecValue <> '');
    //         //HEI.87<<
    //     end;
    //     if StrengthSpecValue = '' then
    //         StrengthSpecValue := FORMAT(StrengthSpecValueTemp);
    //     //HEI.67<<
    // end;  // BC Upgrade NANDIS03 - Dependencies on DIT fields

    [EventSubscriber(ObjectType::Table, 18, 'OnBeforeInsertEvent', '', false, false)]
    local procedure T18OnBeforeInsertCodeSharing(var Rec: Record Customer; RunTrigger: Boolean);
    var
        CommonCustomerNumbers: Record "Common Customer Numbers FND";
        CommonSourceSharingSetup: Record "Common Src Sharing Setup FND";
        GlobalNoSeries: Record "Global No. Series FND";
        GlobalNoSeriesManagement: Codeunit GlobalNoSeriesManagement;
        SessionGlobals: Codeunit "Session Globals";
        ErrorTxt: Label 'Customer with Global Id: %1, Local Id: %2 already exists in Company: %3 !';
    begin
        //HEI.69>>
        if (Rec.ISTEMPORARY) then
            exit;

        if CommonSourceSharingSetup.GET() then begin
            if CommonSourceSharingSetup."Enable Common Customer Sharing" then begin
                CommonCustomerNumbers.RESET();
                CommonCustomerNumbers.SETRANGE("Global ID", SessionGlobals.GetCustomerGlobalNo());
                CommonCustomerNumbers.SETRANGE(Blocked, false);
                if CommonCustomerNumbers.FINDFIRST() then begin
                    Rec."No." := CommonCustomerNumbers."Local ID";
                end else begin
                    CommonSourceSharingSetup.TESTFIELD("Global Customer No. Series");
                    if GlobalNoSeries.GET(CommonSourceSharingSetup."Global Customer No. Series") then
                        GlobalNoSeriesManagement.InitGlobalSeries(GlobalNoSeries.Code, Rec."No. Series",
                                                                  0D, Rec."No.", Rec."No. Series");
                end;
            end else
                exit;
        end;
        //HEI.69<<
    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterValidateEvent', 'Customer Description FND', false, false)]
    local procedure T18OnAfterValidateCustomerGlobNoShared(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer);
    var
        CommonCustomerNumbers: Record "Common Customer Numbers FND";
        CommonSourceSharingSetup: Record "Common Src Sharing Setup FND";
        SessionGlobals: Codeunit "Session Globals";
    begin
        //>> HEI.69
        if Rec.ISTEMPORARY then
            exit;

        if CommonSourceSharingSetup.GET() then
            if CommonSourceSharingSetup."Enable Common Customer Sharing" then begin
                if (Rec."Customer Description FND" <> xRec."Customer Description FND") and (Rec."Customer Description FND" <> '') then begin
                    CommonCustomerNumbers.INIT();
                    CommonCustomerNumbers."Global ID" := Rec."Customer Description FND";
                    CommonCustomerNumbers."Local ID" := Rec."No.";
                    CommonCustomerNumbers."Company ID" := COMPANYNAME;
                    CommonCustomerNumbers.Blocked := false;
                    CommonCustomerNumbers.INSERT();
                end else if Rec."Customer Description FND" = SessionGlobals.GetCustomerGlobalNo() then
                        exit;
            end;
        //HEI.69>>
    end;

    [EventSubscriber(ObjectType::Table, 50072, 'OnAfterValidateEvent', 'Flag for Deletion', false, false)]
    local procedure T18OnAfterValidateGlobalDeleteShared(var Rec: Record "Customer Attributes FND"; var xRec: Record "Customer Attributes FND"; CurrFieldNo: Integer);
    var
        CommonCustomerNumbers: Record "Common Customer Numbers FND";
        CommonSourceSharingSetup: Record "Common Src Sharing Setup FND";
        Customer: Record Customer;
    begin
        //HEI.69<<
        if Rec.ISTEMPORARY then
            exit;

        if CommonSourceSharingSetup.GET() then
            if CommonSourceSharingSetup."Enable Common Customer Sharing" then begin
                if Customer.GET(Rec."Customer No.") then
                    if Rec."Flag for Deletion" = true then begin
                        CommonCustomerNumbers.RESET();
                        CommonCustomerNumbers.SETRANGE("Global ID", Customer."Customer Description FND");
                        CommonCustomerNumbers.SETRANGE("Local ID", Customer."No.");
                        CommonCustomerNumbers.SETRANGE("Company ID", COMPANYNAME);
                        CommonCustomerNumbers.SETRANGE(Blocked, false);
                        if CommonCustomerNumbers.FINDFIRST() then
                            CommonCustomerNumbers.RENAME(CommonCustomerNumbers."Company ID", CommonCustomerNumbers."Global ID", CommonCustomerNumbers."Local ID", Rec."Flag for Deletion");
                    end;
            end;
        //HEI.69>>
    end;

    //procedure SuggestPaymentVendorInsertGenJnlLineWHT(var TempPaymentBuffer : Record "Payment Buffer" temporary;var TempPaymentBuffer2 : Record "Payment Buffer" temporary;var LastLineNo : Integer;JournalTemplate : Code[10];JournalBatch : Code[10];ArchiveDocumentNo : Code[20];WHTBusPostGr : Code[10];WHTProdPostGr : Code[10]);  // BC Upgrade NANDIS03 - blocked as Payment Buffer table is now Vendor Payment Buffer
    procedure SuggestPaymentVendorInsertGenJnlLineWHT(var TempPaymentBuffer: Record "Vendor Payment Buffer" temporary; var TempPaymentBuffer2: Record "Vendor Payment Buffer" temporary; var LastLineNo: Integer; JournalTemplate: Code[10]; JournalBatch: Code[10]; ArchiveDocumentNo: Code[20]; WHTBusPostGr: Code[10]; WHTProdPostGr: Code[10]);  // BC Upgrade NANDIS03 - blocked as Payment Buffer table is now Vendor Payment Buffer
    var
        GenJournalLine: Record "Gen. Journal Line";
        lGenJournalLine: Record "Gen. Journal Line";
        lPurchInvHeader: Record "Purch. Inv. Header";
        WHTEntry: Record "WHT Entry FND";
        ParentLineNo: Integer;
        PaymentOfTxt: Label 'Payment of %1 %2';
    begin
        //HEI.74>>
        ParentLineNo := LastLineNo;
        WHTEntry.RESET();
        WHTEntry.SETCURRENTKEY("Document Type", "Document No.");

        TempPaymentBuffer.SETRANGE("Vendor No.", TempPaymentBuffer2."Vendor No.");
        TempPaymentBuffer.SETRANGE("Currency Code", TempPaymentBuffer2."Currency Code");
        TempPaymentBuffer.SETRANGE("Dimension Entry No.", TempPaymentBuffer2."Dimension Entry No.");
        TempPaymentBuffer.SETRANGE("Vendor Bank Account FND", TempPaymentBuffer2."Vendor Bank Account FND");
        TempPaymentBuffer.SETRANGE("Document No.", TempPaymentBuffer2."Document No."); //ipo
        if TempPaymentBuffer.findset() then
            repeat

                // BC Upgrade MISHRS14 >>
                // Blocked with statement and prefixed variables with GenJournalLine.
                //with GenJournalLine do begin
                GenJournalLine.INIT();
                LastLineNo := LastLineNo + 10000;
                GenJournalLine."Journal Batch Name" := JournalBatch;
                GenJournalLine."Journal Template Name" := JournalTemplate;
                GenJournalLine."Line No." := LastLineNo;
                GenJournalLine."Document Type" := GenJournalLine."Document Type"::Payment;
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                GenJournalLine.SetHideValidation(true);
                GenJournalLine.VALIDATE("Account No.", TempPaymentBuffer."Vendor No.");
                GenJournalLine.VALIDATE("Currency Code", TempPaymentBuffer."Currency Code");
                GenJournalLine.Description :=
                  STRSUBSTNO(
                    PaymentOfTxt,
                    TempPaymentBuffer."Vendor Ledg. Entry Doc. Type",
                    TempPaymentBuffer."Vendor Ledg. Entry Doc. No.");
                GenJournalLine."Source Line No." := TempPaymentBuffer."Vendor Ledg. Entry No.";
                GenJournalLine."Shortcut Dimension 1 Code" := TempPaymentBuffer."Global Dimension 1 Code";
                GenJournalLine."Shortcut Dimension 2 Code" := TempPaymentBuffer."Global Dimension 2 Code";
                GenJournalLine."Dimension Set ID" := TempPaymentBuffer."Dimension Set ID";
                //HEI.16>>
                //VALIDATE(Amount,TempPaymentBuffer.Amount);
                GenJournalLine.Amount := TempPaymentBuffer.Amount;

                //HEI.16<<
                GenJournalLine."Applies-to Doc. Type" := TempPaymentBuffer."Vendor Ledg. Entry Doc. Type";
                GenJournalLine."Applies-to Doc. No." := TempPaymentBuffer."Vendor Ledg. Entry Doc. No.";
                GenJournalLine."Payment Method Code" := TempPaymentBuffer."Payment Method Code";
                GenJournalLine."Creditor No." := TempPaymentBuffer."Creditor No.";
                GenJournalLine."Payment Reference" := TempPaymentBuffer."Payment Reference";
                GenJournalLine."Exported to Payment File" := TempPaymentBuffer."Exported to Payment File";
                GenJournalLine."Applies-to Ext. Doc. No." := TempPaymentBuffer."Applies-to Ext. Doc. No.";
                //   "Contract Type" := TempPaymentBuffer."Contract Type";  // BC Upgrade NANDIS03 - Blocked due to DIT field
                //   "Service Contract Line No." := TempPaymentBuffer."Service Contract Line No.";  // BC Upgrade NANDIS03 - Blocked due to DIT field
                //   "DIT Sub-Contract Type" := TempPaymentBuffer."DIT Sub-Contract Type";  // BC Upgrade NANDIS03 - Blocked due to DIT field
                //   "Service Contract No." := TempPaymentBuffer."Service Contract No.";  // BC Upgrade NANDIS03 - Blocked due to DIT field
                //   "Building No." := TempPaymentBuffer."Building No.";  // BC Upgrade NANDIS03 - Blocked due to DIT field
                //   "Contract Group Code" := TempPaymentBuffer."Contract Group Code"; // BC Upgrade NANDIS03 - Blocked due to DIT field
                //   "Posting Group" := TempPaymentBuffer."Posting Group";  // BC Upgrade NANDIS03 - Blocked due to DIT field
                GenJournalLine."Vendor Bank Account FND" := TempPaymentBuffer."Vendor Bank Account FND";
                GenJournalLine."Dimension Set ID" := TempPaymentBuffer."Dimension Set ID";
                GenJournalLine."Fixed Asset Acquisition FND" := TempPaymentBuffer."Fixed Asset Acquisition FND"; //HEI.62
                GenJournalLine."Parent Line No. FND" := ParentLineNo;
                GenJournalLine."Tree Level FND" := 1;
                GenJournalLine."Archive Document No. FND" := ArchiveDocumentNo;


                //WHTEntry.SETRANGE("Document Type", "Applies-to Doc. Type");
                //WHTEntry.SETRANGE("Document No.", "Applies-to Doc. No.");
                //IF WHTEntry.FINDFIRST THEN BEGIN
                GenJournalLine.VALIDATE("WHT Business Posting Group FND", WHTBusPostGr);
                GenJournalLine.VALIDATE("WHT Product Posting Group FND", WHTProdPostGr);
                //end;
                //HEI.89>>
                lGenJournalLine.RESET();
                if lGenJournalLine.GET(GenJournalLine."Journal Template Name", GenJournalLine."Journal Batch Name", GenJournalLine."Parent Line No. FND") then begin
                    if lGenJournalLine."Recipient Bank Account" <> '' then
                        GenJournalLine."Recipient Bank Account" := lGenJournalLine."Recipient Bank Account";
                    if lGenJournalLine."Recipient Bank Account" = '' then
                        if GenJournalLine."Applies-to Doc. Type" = GenJournalLine."Applies-to Doc. Type"::Invoice then
                            if lPurchInvHeader.GET(GenJournalLine."Applies-to Doc. No.") then
                                GenJournalLine."Recipient Bank Account" := lPurchInvHeader."Vendor Bank Account FND";
                end;
                //HEI.89<<
                GenJournalLine.INSERT();
            //end;
            // BC Upgrade MISHRS14 <<

            until TempPaymentBuffer.NEXT() = 0;
        //HEI.74<<
    end;

    [EventSubscriber(ObjectType::Table, 50072, 'OnAfterValidateEvent', 'Classification', false, false)]
    local procedure T50072OnAfterValidateClassification(var Rec: Record "Customer Attributes FND"; var xRec: Record "Customer Attributes FND"; CurrFieldNo: Integer);
    var
        AccountGroup: Record "Account Group FND";
        Customer: Record Customer;
        Text001: Label 'You cannot modify the field %1 because the %2 on the Account Group %3 is not enabled.';
    begin
        //HEI.75<<
        if (Rec.Classification <> xRec.Classification) and (Rec.Classification <> '') then
            if Customer.GET(Rec."Customer No.") then
                if AccountGroup.GET(Customer."Account Group FND") then
                    if not AccountGroup."Customer Classification" then
                        ERROR(Text001, Rec.FIELDCAPTION(Classification), AccountGroup.FIELDCAPTION("Customer Classification"), Customer."Account Group FND");
        //HEI.75>>
    end;

    // [EventSubscriber(ObjectType::Table, 10866, 'OnAfterValidateEvent', 'Account No.', false, false)]
    // local procedure T10866OnAfterValidateAccountNo(var Rec : Record "Payment Line";var xRec : Record "Payment Line";CurrFieldNo : Integer);
    // var
    //     Vendor : Record Vendor;
    //     Customer : Record Customer;
    //     FixedAsset : Record "Fixed Asset";
    //     GLAccount : Record "G/L Account";
    //     BankAccount : Record "Bank Account";
    //     DimSetEntry : Record "Dimension Set Entry";
    //     PaymentClass : Record "Payment Class";
    //     PaymentLine : Record "Payment Line";
    //     PaymentHeader : Record "Payment Header";
    //     TempDimSetEntry : Record "Dimension Set Entry" temporary;
    //     DimensionManagement : Codeunit DimensionManagement;
    // begin
    //     //HEI.77<<
    //     if Rec."Account Type" = Rec."Account Type"::Vendor then
    //       if Vendor.GET(Rec."Account No.") then
    //         Rec."Account Name" := Vendor.Name;

    //     if Rec."Account Type" = Rec."Account Type"::Customer then
    //       if Customer.GET(Rec."Account No.") then
    //         Rec."Account Name" := Customer.Name;

    //     if Rec."Account Type" = Rec."Account Type"::"G/L Account" then
    //       if GLAccount.GET(Rec."Account No.") then
    //         Rec."Account Name" := GLAccount.Name;

    //     if Rec."Account Type" = Rec."Account Type"::"Bank Account"  then
    //       if BankAccount.GET(Rec."Account No.") then
    //         Rec."Account Name" := BankAccount.Name;

    //     if Rec."Account Type" = Rec."Account Type"::"Fixed Asset" then
    //       if FixedAsset.GET(Rec."Account No.") then
    //         Rec."Account Name" := FixedAsset.Description;

    //     //HEI.77>>
    // end;  // BC Upgrade NANDIS03 - Dependency on FR localization

    // [EventSubscriber(ObjectType::Table, 10865, 'OnAfterInsertEvent', '', false, false)]
    // local procedure T10865OnAfterInsertPaymentHeader(var Rec : Record "Payment Header";RunTrigger : Boolean);
    // var
    //     DimSetEntry : Record "Dimension Set Entry";
    //     PaymentClass : Record "Payment Class";
    //     PaymentLine : Record "Payment Line";
    //     PaymentHeader : Record "Payment Header";
    //     TempDimSetEntry : Record "Dimension Set Entry" temporary;
    //     DimensionManagement : Codeunit DimensionManagement;
    // begin
    //     //HEI.77<<
    //     if PaymentClass.GET(Rec."Payment Class") then begin
    //       TempDimSetEntry.RESET;
    //       TempDimSetEntry.VALIDATE("Dimension Code",'MVMT');
    //       TempDimSetEntry.VALIDATE("Dimension Value Code",PaymentClass."Movement Type");
    //       TempDimSetEntry.INSERT;
    //       if TempDimSetEntry.FINDFIRST then
    //         Rec."Dimension Set ID" := DimensionManagement.GetDimensionSetID(TempDimSetEntry);
    //       Rec."Transaction Code" := PaymentClass."Transaction Code";
    //       Rec.MODIFY;
    //     end;
    //     //HEI.77>>
    // end;  // BC Upgrade NANDIS03 - Dependency on FR localization

    // [EventSubscriber(ObjectType::Table, 10866, 'OnAfterInsertEvent', '', false, false)]
    // local procedure T10866OnAfterInsertPaymentLine(var Rec : Record "Payment Line";RunTrigger : Boolean);
    // var
    //     DimensionSetEntry : Record "Dimension Set Entry";
    //     PaymentClass : Record "Payment Class";
    //     PaymentLine : Record "Payment Line";
    //     PaymentHeader : Record "Payment Header";
    //     TempDimSetEntry : Record "Dimension Set Entry" temporary;
    //     DimensionManagement : Codeunit DimensionManagement;
    //     DimSetEntry : Record "Dimension Set Entry";
    // begin
    //     //HEI.77<<
    //     if PaymentHeader.GET(Rec."No.") then
    //       if PaymentClass.GET(PaymentHeader."Payment Class") then begin

    //         DimensionSetEntry.SETRANGE("Dimension Set ID",Rec."Dimension Set ID");
    //         DimensionSetEntry.SETFILTER("Dimension Code",'<>%1','MVMT');
    //         if DimensionSetEntry.findset then
    //           repeat
    //             TempDimSetEntry := DimensionSetEntry;
    //             TempDimSetEntry."Dimension Set ID" := 0;

    //             if not TempDimSetEntry.MODIFY then
    //               TempDimSetEntry.INSERT;
    //             until DimensionSetEntry.NEXT = 0;

    //         TempDimSetEntry.SETRANGE("Dimension Code",'MVMT');
    //         TempDimSetEntry.SETRANGE("Dimension Value Code",PaymentClass."Movement Type");
    //         if not TempDimSetEntry.FINDFIRST then begin
    //           TempDimSetEntry.VALIDATE("Dimension Code",'MVMT');
    //           TempDimSetEntry.VALIDATE("Dimension Value Code",PaymentClass."Movement Type");
    //           TempDimSetEntry."Dimension Set ID" := 0;
    //           if not TempDimSetEntry.MODIFY then
    //             TempDimSetEntry.INSERT;
    //         end;

    //         Rec."Dimension Set ID" := DimensionManagement.GetDimensionSetID(TempDimSetEntry);
    //         Rec."Transaction Code" := PaymentClass."Transaction Code";
    //         Rec.MODIFY;
    //        end;
    //     //HEI.77>>
    // end;  // BC Upgrade NANDIS03 - Dependency on FR localization

    procedure NegativeConsumptionCatgryCodeNew(var ItemJrlLine: Record "Item Journal Line");
    var
        DefaultDimensionL: Record "Default Dimension";
        DimensionL: Record Dimension;
        DimensionValueL: Record "Dimension Value";
        ItemL: Record Item;
        ItemJrlLineL: Record "Item Journal Line";
        //QualityManagementL : Codeunit "Quality Management"; // //BC Upgrade KAMNAY01 DITW
        ManufacturingSetupL: Record "Manufacturing Setup";
        FoundCMGValueL: Boolean;
        FoundItemCMGValueL: Boolean;
        LotNoL: Code[20];
        Text001L: Label 'There is added incorrect "Dimention Value" on "CMG Values for Negative Consmp" in "Manufacturing Setup".';
    begin
        //HEI.78>>
        ItemJrlLineL.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Entry Type",
          "Document No.", "Posting Date", "Item No.", "Item Category Code", Quantity);
        ItemJrlLineL.SETRANGE("Journal Template Name", ItemJrlLine."Journal Template Name");
        ItemJrlLineL.SETRANGE("Journal Batch Name", ItemJrlLine."Journal Batch Name");
        ItemJrlLineL.SETRANGE("Entry Type", ItemJrlLineL."Entry Type"::Consumption);
        ItemJrlLineL.SETRANGE("Document No.", ItemJrlLine."Document No.");
        ItemJrlLineL.SETRANGE("Posting Date", ItemJrlLine."Posting Date");
        ItemJrlLineL.SETFILTER("Item No.", '<>%1', '');
        //HEI.94>>
        //ItemJrlLineL.SETFILTER("Item Category Code",'<>%1&<>%2&<>%3','05','08','10');
        //HEI.94<<
        ItemJrlLineL.SETFILTER(Quantity, '<%1', 0);
        if ItemJrlLineL.findset() then begin
            //HEI.94>>
            ManufacturingSetupL.GET();
            if (ManufacturingSetupL."CMG Dimension Code FND" <> '') and (ManufacturingSetupL."CMG Values for Neg Consmp FND" <> '') then begin
                DimensionL.GET(ManufacturingSetupL."CMG Dimension Code FND");
                DimensionValueL.SETRANGE("Dimension Code", ManufacturingSetupL."CMG Dimension Code FND");
                DimensionValueL.SETFILTER(Code, ManufacturingSetupL."CMG Values for Neg Consmp FND");
                if not DimensionValueL.FIND('-') then begin
                    repeat
                        ERROR(Text001L);
                    until DimensionValueL.NEXT() = 0;
                end else
                    FoundCMGValueL := true;
            end;
            //HEI.94<<
            repeat
                CLEAR(LotNoL);
                //CLEAR(QualityManagementL);  //BC Upgrade KAMNAY01 DITW - Dependency on Aptean
                ItemL.GET(ItemJrlLineL."Item No.");
                //HEI.94>>
                CLEAR(FoundItemCMGValueL);
                if FoundCMGValueL then begin
                    DefaultDimensionL.RESET();
                    DefaultDimensionL.SETCURRENTKEY("Table ID", "No.", "Dimension Code", "Dimension Value Code");
                    DefaultDimensionL.SETRANGE("Table ID", DATABASE::Item);
                    DefaultDimensionL.SETRANGE("No.", ItemL."No.");
                    DefaultDimensionL.SETRANGE("Dimension Code", ManufacturingSetupL."CMG Dimension Code FND");
                    DefaultDimensionL.SETFILTER("Dimension Value Code", ManufacturingSetupL."CMG Values for Neg Consmp FND");
                    if DefaultDimensionL.FINDFIRST() then
                        FoundItemCMGValueL := true;
                end;
                if not FoundItemCMGValueL then begin
                    //HEI.94<<
                    //LotNoL := QualityManagementL.GetItemJnlLineLotNo(ItemJrlLineL);  //BC Upgrade KAMNAY01 DITW - Dependency on Aptean
                    if LotNoL = 'REQUIRED' then
                        exit;
                    if LotNoL = 'MULTIPLE' then
                        ValidateNegativeConsumptionQtyNew(ItemJrlLineL)
                    else
                        ValidateILELotNoQtyNew(ItemJrlLineL, LotNoL, ItemJrlLineL.Quantity);
                    //HEI.94>>
                end;
            //HEI.94<<
            until ItemJrlLineL.NEXT() = 0;
        end;
        //HEI.78<<
    end;

    local procedure ValidateNegativeConsumptionQtyNew(var ItemJournallLine: Record "Item Journal Line");
    var
        ReservEntryL: Record "Reservation Entry";
        ReservEntryL1: Record "Reservation Entry";
        FoundRELotL: Boolean;
        FoundRENewLotL: Boolean;
        RELotNoL: array[20] of Code[20];
        ReserveEntryLotNoL: Code[20];
        ReserveEntryQtyL: Decimal;
        iL: Integer;
        jL: Integer;
    begin
        //HEI.78>>
        ReservEntryL.SETCURRENTKEY("Source Type", "Source Subtype", "Source ID", "Source Batch Name",
          "Source Ref. No.", "Item No.", "Creation Date", "Location Code", "Item Tracking", "Lot No.");
        ReservEntryL.SETRANGE("Source Type", DATABASE::"Item Journal Line");
        ReservEntryL.SETRANGE("Source Subtype", 5);
        ReservEntryL.SETRANGE("Source ID", ItemJournallLine."Journal Template Name");
        ReservEntryL.SETRANGE("Source Batch Name", ItemJournallLine."Journal Batch Name");
        ReservEntryL.SETRANGE("Source Ref. No.", ItemJournallLine."Line No.");
        ReservEntryL.SETRANGE("Item No.", ItemJournallLine."Item No.");
        ReservEntryL.SETRANGE("Creation Date", ItemJournallLine."Posting Date");
        ReservEntryL.SETRANGE("Location Code", ItemJournallLine."Location Code");
        ReservEntryL.SETRANGE("Item Tracking", ReservEntryL."Item Tracking"::"Lot No.");
        ReservEntryL.SETFILTER("Lot No.", '<>%1', '');
        if ReservEntryL.findset() then begin
            repeat
                CLEAR(FoundRELotL);
                CLEAR(FoundRENewLotL);
                CLEAR(ReserveEntryLotNoL);
                CLEAR(ReserveEntryQtyL);
                iL += 1;
                jL := 1;
                for jL := 1 to iL do begin
                    if not (FoundRELotL or FoundRENewLotL) then begin
                        if jL = iL then begin
                            FoundRENewLotL := true;
                            RELotNoL[iL] := ReservEntryL."Lot No.";
                        end else begin
                            if jL < iL then begin
                                if RELotNoL[jL] = ReservEntryL."Lot No." then begin
                                    FoundRELotL := true;
                                    FoundRENewLotL := false;
                                    iL -= 1;
                                end;
                            end;
                        end;
                    end;
                end;

                if FoundRENewLotL then begin
                    ReservEntryL1.RESET();
                    ReservEntryL1.COPYFILTERS(ReservEntryL);
                    ReservEntryL1.SETRANGE("Lot No.", ReservEntryL."Lot No.");
                    if ReservEntryL1.findset() then begin
                        repeat
                            ReserveEntryLotNoL := ReservEntryL1."Lot No.";
                            ReserveEntryQtyL += ReservEntryL1."Quantity (Base)";
                        until ReservEntryL1.NEXT() = 0;
                        ValidateILELotNoQtyNew(ItemJournallLine, ReserveEntryLotNoL, ReserveEntryQtyL);
                    end;
                end;
            until ReservEntryL.NEXT() = 0;
        end;
        //HEI.78<<
    end;

    local procedure ValidateILELotNoQtyNew(var ItemJrlLine: Record "Item Journal Line"; var LotNo: Code[20]; var Qty: Decimal);
    var
        ItemLedgerEntryL: Record "Item Ledger Entry";
        LotNoL: Code[20];
        ReservationEntry: Record "Reservation Entry";
        ItemLedgerEntryL1: Record "Item Ledger Entry";
        FoundILEL: Boolean;
        ILEQtyL: Decimal;
        Text000L: Label 'Negative Consumption Quantity (%1) cannot be posted with Lot No. %2, as the previous Consumption Quantity posted has a different Lot No. %3 for Item No. %4 in the Production Order %5.';
        Text001L: Label 'Negative Consumption Quantity (%1) cannot be less than previously posted Consumption Quantity (%2) for Item No. %3, Lot No. %4 in the Production Order %5.';
        Text002L: Label 'There is no posted Consumption found to post Negative Consumption for Item %1 on Production Order %2 in "Item Ledger Entries".';
    begin
        //BC upgrade kamnay01 -- Bug fix of reverse negative consumption >> 30-04-2026
        ReservationEntry.RESET;
        ReservationEntry.SETRANGE("Source Type", 83);
        ReservationEntry.SETRANGE("Source Subtype", 5);
        ReservationEntry.SETRANGE("Source ID", ItemJrlLine."Journal Template Name");
        ReservationEntry.SETRANGE("Source Batch Name", ItemJrlLine."Journal Batch Name");
        ReservationEntry.SETRANGE("Source Prod. Order Line", 0);
        ReservationEntry.SETRANGE("Source Ref. No.", ItemJrlLine."Line No.");
        ReservationEntry.SETFILTER("Lot No.", '<>%1', '');
        if ReservationEntry.FindFirst() then
            LotNoL := ReservationEntry."Lot No.";
        //BC upgrade kamnay01 -- Bug fix of reverse negative consumption <<30-04-2026


        //HEI.78>>
        ItemLedgerEntryL.SETCURRENTKEY("Entry Type", "Document No.", "Source Type", "Source No.", "Item No.",
          "Prod. Order Comp. Line No.", "Location Code");
        ItemLedgerEntryL.SETRANGE("Entry Type", ItemLedgerEntryL."Entry Type"::Consumption);
        ItemLedgerEntryL.SETRANGE("Document No.", ItemJrlLine."Document No.");
        ItemLedgerEntryL.SETRANGE("Source Type", ItemLedgerEntryL."Source Type"::Item);
        ItemLedgerEntryL.SETRANGE("Source No.", ItemJrlLine."Source No.");
        ItemLedgerEntryL.SETRANGE("Item No.", ItemJrlLine."Item No.");
        ItemLedgerEntryL.SETRANGE("Prod. Order Comp. Line No.", ItemJrlLine."Prod. Order Comp. Line No.");
        ItemLedgerEntryL.SETRANGE("Location Code", ItemJrlLine."Location Code");
        if ItemLedgerEntryL.findset() then begin
            repeat
                ItemLedgerEntryL1.RESET();
                ItemLedgerEntryL1.SETRANGE("Entry No.", ItemLedgerEntryL."Entry No.");
                ItemLedgerEntryL1.SETRANGE("Lot No.", LotNoL);      //BC upgrade kamnay01 -- Bug fix of reverse negative consumption >> 30-04-2026
                if ItemLedgerEntryL1.FINDFIRST() then begin
                    ILEQtyL += ItemLedgerEntryL1.Quantity;
                    FoundILEL := true;
                end;
            until ItemLedgerEntryL.NEXT() = 0;
            if not FoundILEL then
                ERROR(Text000L, Qty, LotNoL, ItemLedgerEntryL."Lot No.", ItemJrlLine."Item No.", ItemJrlLine."Document No.");//BC upgrade kamnay01 -- Bug fix of reverse negative consumption >> 30-04-2026
            if FoundILEL and (ILEQtyL > Qty) then
                ERROR(Text001L, Qty, (-ILEQtyL), ItemJrlLine."Item No.", LotNoL, ItemJrlLine."Document No.");//BC upgrade kamnay01 -- Bug fix of reverse negative consumption >> 30-04-2026
        end else
            ERROR(Text002L, ItemJrlLine."Item No.", ItemJrlLine."Document No.");
        //HEI.78<<
    end;

    // local procedure NoSeriesWebRequest(NoSeriesCode : Code[10];ItemNoSeriesCode : Code[10];StartingDate : Date;ItemNo : Code[20];NewNo : Code[20]);
    // var
    //     HttpWebRequest : DotNet "'System, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Net.HttpWebRequest";
    //     NetCredential : DotNet "'System, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Net.NetworkCredential";
    //     XmlDoc : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
    //     BodyXmlNode : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     string : Text;
    //     RequestOutStream : OutStream;
    //     HttpStatusCode : DotNet "'System, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Net.HttpStatusCode";
    //     ResponseHeaders : DotNet "'System, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Collections.Specialized.NameValueCollection";
    //     HttpWebResponse : DotNet "'System, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Net.HttpWebResponse";
    //     ResponseInStream : InStream;
    //     varDate : Date;
    //     value : Text;
    //     TempBlob : Record TempBlob temporary;
    // begin
    //     //>> HEI.79
    //     GetCommonSourceSharingSetup;
    //     HttpWebRequest := HttpWebRequest.Create(CommonSourceSharingSetup."Global No. Series Mgt. WS Link");
    //     HttpWebRequest.Method := 'POST';
    //     NetCredential := NetCredential.NetworkCredential(CommonSourceSharingSetup."WS Username",CommonSourceSharingSetup."WS Password");
    //     HttpWebRequest.Credentials := NetCredential;
    //     HttpWebRequest.Headers.Add('SOAPAction','');
    //     HttpWebRequest.ContentType := 'text/xml;charset=utf-8';

    //     value := FORMAT(StartingDate);
    //     EVALUATE(varDate,value);
    //     string := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:glob="urn:microsoft-dynamics-schemas/codeunit/GlobalNoSeriesManagement">' +
    //               '<soapenv:Header/>' +
    //               '<soapenv:Body>' +
    //               '<glob:InitGlobalSeries>' +
    //               '<glob:defaultGlobalNoSeriesCode>' + NoSeriesCode + '</glob:defaultGlobalNoSeriesCode>' +
    //               '<glob:globalOldNoSeriesCode>' + ItemNoSeriesCode + '</glob:globalOldNoSeriesCode>' +
    //               '<glob:newDate>' + FORMAT(varDate,10,'<Year4>-<Month,2>-<Day,2>') + '</glob:newDate>' +
    //               '<glob:newNo>' + NewNo + '</glob:newNo>' +
    //               '<glob:newNoSeriesCode>' + ItemNo + '</glob:newNoSeriesCode>' +
    //               '</glob:InitGlobalSeries>' +
    //               '</soapenv:Body>' +
    //               '</soapenv:Envelope>';

    //     XmlDoc := XmlDoc.XmlDocument;
    //     XmlDoc.LoadXml(string);
    //     RequestOutStream := HttpWebRequest.GetRequestStream;
    //     TempBlob.Blob.CREATEINSTREAM(ResponseInStream);
    //     XmlDoc.Save(RequestOutStream);
    //     HttpWebResponse := HttpWebRequest.GetResponse;
    //     HttpWebResponse.GetResponseStream.CopyTo(ResponseInStream);
    //     HttpStatusCode := HttpWebResponse.StatusCode;
    //     ResponseHeaders := HttpWebResponse.Headers;
    //     //<< HEI.79
    // end;  // BC Upgrade NANDIS03 - blocked as DotNet components are not getting compiled

    local procedure GetCommonSourceSharingSetup();
    begin
        //>> HEI.79
        if not CommonSourceSharingSetupGot then
            if CommonSourceSharingSetup.GET() then;
        CommonSourceSharingSetupGot := true
        //<< HEI.79
    end;

    [EventSubscriber(ObjectType::Table, 5740, 'OnAfterValidateEvent', 'Transfer-to Code', false, false)]
    local procedure T5740OnafterValidateTransferToCode(var Rec: Record "Transfer Header"; var xRec: Record "Transfer Header"; CurrFieldNo: Integer);
    var
        Location: Record Location;
    begin
        //HEI.80>>
        if Rec.ISTEMPORARY then
            exit;
        Rec.LOCKTABLE(true); //HEI.104
        Location.GET(Rec."Transfer-to Code");
        //Rec."IC Document" := Location."IC Partner Code" <> ''; //HEI.104
        //HEI.80<<

        //HEI.104>>
        if Location."IC Partner Code FND" <> '' then
            Rec."IC Document FND" := true
        else
            Rec."IC Document FND" := false;
        //HEI.104<<
    end;

    // [EventSubscriber(ObjectType::Table, 5740, 'OnBeforeValidateEvent', 'Transfer-to Code', false, false)]
    // local procedure T5740OnBeforeValidateTransferToCode(var Rec: Record "Transfer Header"; var xRec: Record "Transfer Header"; CurrFieldNo: Integer);
    // var
    //     TransferOrderICLogEntry: Record "Transfer Order IC Log Entry";
    // begin
    //     //HEI.80>>
    //     if Rec.ISTEMPORARY then
    //         exit;

    //     if not Rec."IC Document" then
    //         exit;

    //     if (Rec."Transfer-to Code" <> xRec."Transfer-to Code") and (xRec."Transfer-to Code" <> '') then begin
    //         //Receiving Company
    //         TransferOrderICLogEntry.RESET;
    //         TransferOrderICLogEntry.SETRANGE("Source Type", TransferOrderICLogEntry."Source Type"::Transfer);
    //         TransferOrderICLogEntry.SETRANGE("Document Type", TransferOrderICLogEntry."Document Type"::"Transfer Order");
    //         TransferOrderICLogEntry.SETRANGE("Created Document No.", Rec."No.");
    //         TransferOrderICLogEntry.SETRANGE(Status, TransferOrderICLogEntry.Status::"Posting info. Exported");
    //         //<<HEI.96
    //         //IF TransferOrderICLogEntry.FINDFIRST THEN BEGIN
    //         if (TransferOrderICLogEntry.FINDFIRST) and (GUIALLOWED) then begin
    //             //>>HEI.96
    //             if CONFIRM(TransferOrderReceivedConfirm) then
    //                 ERROR('');
    //             exit;
    //         end;
    //     end;
    //     //HEI.80>>
    // end;  // BC Upgrade NANDIS03 - to be moved to DTW extension later

    // [EventSubscriber(ObjectType::Table, 5740, 'OnBeforeValidateEvent', 'Transfer-from Code', false, false)]
    // local procedure T5740OnBeforeValidateTransferFromCode(var Rec : Record "Transfer Header";var xRec : Record "Transfer Header";CurrFieldNo : Integer);
    // var
    //     TransferOrderICLogEntry : Record "Transfer Order IC Log Entry";
    // begin
    //     //HEI.80>>
    //     if Rec.ISTEMPORARY then
    //       exit;

    //     if not Rec."IC Document" then
    //       exit;

    //     if (Rec."Transfer-from Code" <> xRec."Transfer-from Code") and (xRec."Transfer-from Code" <> '') then begin
    //       //Receiving Company
    //       TransferOrderICLogEntry.RESET;
    //       TransferOrderICLogEntry.SETRANGE("Source Type",TransferOrderICLogEntry."Source Type"::Transfer);
    //       TransferOrderICLogEntry.SETRANGE("Document Type",TransferOrderICLogEntry."Document Type"::"Transfer Order");
    //       TransferOrderICLogEntry.SETRANGE("Created Document No.",Rec."No.");
    //       TransferOrderICLogEntry.SETRANGE(Status,TransferOrderICLogEntry.Status::"Posting info. Exported");
    //       //<<HEI.96
    //       //IF TransferOrderICLogEntry.FINDFIRST THEN BEGIN
    //       if (TransferOrderICLogEntry.FINDFIRST) and (GUIALLOWED) then begin
    //       //>>HEI.96
    //         if CONFIRM(TransferOrderReceivedConfirm) then
    //           ERROR('');
    //         exit;
    //       end;
    //     end;
    //     //HEI.80>>
    // end;  // BC Upgrade NANDIS03 - to be moved to DTW extension later

    // [EventSubscriber(ObjectType::Table, 5740, 'OnBeforeValidateEvent', 'In-Transit Code', false, false)]
    // local procedure T5740OnBeforeValidateInTransitCode(var Rec : Record "Transfer Header";var xRec : Record "Transfer Header";CurrFieldNo : Integer);
    // var
    //     TransferOrderICLogEntry : Record "Transfer Order IC Log Entry";
    // begin
    //     //HEI.80>>
    //     if Rec.ISTEMPORARY then
    //       exit;

    //     if not Rec."IC Document" then
    //       exit;

    //     if (Rec."In-Transit Code" <> xRec."In-Transit Code") and (xRec."In-Transit Code" <> '') then begin
    //       //Receiving Company
    //       TransferOrderICLogEntry.RESET;
    //       TransferOrderICLogEntry.SETRANGE("Source Type",TransferOrderICLogEntry."Source Type"::Transfer);
    //       TransferOrderICLogEntry.SETRANGE("Document Type",TransferOrderICLogEntry."Document Type"::"Transfer Order");
    //       TransferOrderICLogEntry.SETRANGE("Created Document No.",Rec."No.");
    //       TransferOrderICLogEntry.SETRANGE(Status,TransferOrderICLogEntry.Status::"Posting info. Exported");
    //       //<<HEI.96
    //       //IF TransferOrderICLogEntry.FINDFIRST THEN BEGIN
    //       if (TransferOrderICLogEntry.FINDFIRST) and (GUIALLOWED) then begin
    //       //>>HEI.96
    //         if CONFIRM(TransferOrderReceivedConfirm) then
    //           ERROR('');
    //         exit;
    //       end;
    //     end;
    //     //HEI.80>>
    // end;  // BC Upgrade NANDIS03 - to be moved to DTW extension later

    // [EventSubscriber(ObjectType::Codeunit, 414, 'OnAfterReleaseSalesDoc', '', false, false)]
    // local procedure OnAfterReleaseSalesDocument(var SalesHeader : Record "Sales Header";PreviewMode : Boolean);
    // var
    //     DDEInterfaceMgmt : Codeunit "DDE Interface Mgmt.";
    // begin
    //     //HEI.81>>
    //     if SalesHeader.ISTEMPORARY then
    //       exit;

    //     if SalesHeader."Source System Identifier" <> 'DDE' then
    //       exit;

    //     if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then
    //       exit;

    //     DDEInterfaceMgmt.CreateEmailNotificationOnAfterRelease(SalesHeader);
    //     //HEI.81<<
    // end;  // BC Upgrade NANDIS03 - moved to InterfaceFramework extension

    // [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    // local procedure OnAfterPostSalesDocument(var SalesHeader : Record "Sales Header";var GenJnlPostLine : Codeunit "Gen. Jnl.-Post Line";SalesShptHdrNo : Code[20];RetRcpHdrNo : Code[20];SalesInvHdrNo : Code[20];SalesCrMemoHdrNo : Code[20]);
    // var
    //     DDEInterfaceSetup : Record "DDE Interface Setup INT";
    //     SalesShipmentHeader : Record "Sales Shipment Header";
    //     ReturnReceiptHeader : Record "Return Receipt Header";
    //     DDEInterfaceMgmt : Codeunit "DDE Interface Mgmt.";
    // begin
    //     //HEI.81>>
    //     //HEI.122>>
    //     //IF SalesHeader."Source System Identifier" <> 'DDE' THEN
    //     //  EXIT;
    //     //HEI.122<<

    //     if not DDEInterfaceSetup.GET then
    //       exit;

    //     if not DDEInterfaceSetup."Enable DDE Ship Interface" then
    //       exit;

    //     if (SalesShptHdrNo = '') and (RetRcpHdrNo = '') then
    //       exit;

    //     //HEI.122>>
    //     if SalesHeader."Source System Identifier" <> 'DDE' then
    //       if not DDEInterfaceMgmt.IsManualDDEShipmentEnabled(SalesHeader."Sell-to Customer No.") then
    //         exit;
    //     //HEI.122<<

    //     //Create Outbound Interface for Shipment posted
    //     if SalesShptHdrNo <> '' then begin
    //       SalesShipmentHeader.GET(SalesShptHdrNo);
    //       DDEInterfaceMgmt.CreateDDEShipmentInterface(SalesShipmentHeader,SalesHeader."Order Id");
    //       DDEInterfaceMgmt.CreateEmailNotificationOnAfterPostShip(SalesShipmentHeader);
    //       //HEI.122>>
    //       if SalesShipmentHeader."Source System Identifier" <> 'DDE' then begin
    //         SalesShipmentHeader."Source System Identifier" := 'DDE';
    //         SalesShipmentHeader.MODIFY;
    //       end;
    //       //HEI.122<<
    //     end;

    //     //Create E-mail Notification for Receipt posted
    //     if RetRcpHdrNo <> '' then begin
    //       ReturnReceiptHeader.GET(RetRcpHdrNo);
    //       DDEInterfaceMgmt.CreateEmailNotificationOnAfterPostRcpt(ReturnReceiptHeader);
    //     end;
    //     //HEI.81<<
    // end;  // BC Upgrade NANDIS03 - moved to InterfaceFramework extension


    // [EventSubscriber(ObjectType::Table, 2029748, 'OnAfterModifyEvent', '', true, true)]
    // local procedure ICLogEntryOnAfterModify(var Rec : Record "IC Log Entry";var xRec : Record "IC Log Entry";RunTrigger : Boolean);
    // var
    //     POAdditional : Record "Purchase Header Additional";
    //     SO : Record "Sales Header";
    //     ICWebSetup : Record "IC Web Service Setup";
    // begin
    //     exit; //HEI.91 OBSOLETE
    //     //<<HEI.83
    //     if Rec.ISTEMPORARY then exit;

    //     if ((Rec."Document Type" = Rec."Document Type"::Order) or (Rec."Document Type" = Rec."Document Type"::"Return Order")) and (Rec."Created Document No." <> '') then begin
    //       case Rec."Source Type" of
    //         Rec."Source Type"::Purchase:
    //           begin
    //             POAdditional.CHANGECOMPANY(Rec."From Company");
    //             if POAdditional.GET(Rec."Document Type", Rec."Document No.") and (POAdditional."IC Order No." = '') then begin
    //               POAdditional."IC Order No." := Rec."Created Document No.";
    //               POAdditional.MODIFY;
    //             end;
    //           end;
    //         Rec."Source Type"::Sales:
    //           begin
    //             SO.CHANGECOMPANY(Rec."From Company");
    //             if SO.GET(Rec."Document Type", Rec."Document No.") and (SO."IC Order No." = '') then begin
    //               SO."IC Order No." := Rec."Created Document No.";
    //               SO.MODIFY;
    //             end;
    //           end;
    //       end;
    //     end;
    //     //>>HEI.83
    // end;  // BC Upgrade NANDIS03 - Blocked as dependency on DIT table

    [EventSubscriber(ObjectType::Table, 5405, 'OnAfterInsertEvent', '', false, false)]
    local procedure T5405OnAfterInsert(var Rec: Record "Production Order"; RunTrigger: Boolean);
    var
        lDimensionSetEntry: Record "Dimension Set Entry";
        ProductionOrder: Record "Production Order";
        lRoleCenterTileSetup: Record "Role Center Tile Setup FND";
        lProdOrderNo: Code[20];
        lStatus: Option Simulated,Planned,"Firm Planned",Released,Finished;
        RoleCenterFilter: Text;
    begin
        //HEI.85<<
        if Rec."Role Centre Tile Code FND" = '' then begin
            RoleCenterFilter := Rec.GETFILTER("Role Centre Tile Code FND");
            if STRPOS(RoleCenterFilter, '|') <> 0 then
                Rec."Role Centre Tile Code FND" := COPYSTR(RoleCenterFilter, 1, (STRPOS(RoleCenterFilter, '|') - 1))
            else
                Rec."Role Centre Tile Code FND" := RoleCenterFilter;
            Rec.MODIFY();
        end;
        //HEI.85>>
    end;  // BC Upgrade NANDIS03

    procedure EAN13_10String(InputBarcode: Code[20]): Text;
    var
        BarcodeWithCheckSum: Code[13];
        CheckDigit: Integer;
        "Count": Integer;
        NumberEval: Integer;
        StructureIndex: Integer;
        CurrentBarcode: Text;
        EncodedBarcode: Text;
        LRSeparator: Text[3];
        CSeparator: Text[6];
        LeftStructure: Text[6];
        Structure: array[10] of Text[6];
        Encoding: array[10, 3] of Text[7];
        Weight: Text[12];
    begin
        //HEI.86<<
        // In Separators '2' is used to identify line length for nicer look'n'feel
        LRSeparator := '202';
        CSeparator := '02020';
        Weight := '131313131313';

        // If barcode is already with Checksum digit at the end
        if STRLEN(InputBarcode) = 13 then begin
            EVALUATE(CheckDigit, COPYSTR(InputBarcode, 13, 1));
            CurrentBarcode := COPYSTR(InputBarcode, 1, 12);
            //Comparing checkdigit
            if CheckDigit <> STRCHECKSUM(CurrentBarcode, Weight, 10) then begin
                ERROR(Text104);
            end;
        end else begin
            if STRLEN(InputBarcode) <> 12 then
                ERROR(Text101, 12);
            CurrentBarcode := InputBarcode;
        end;

        for Count := 1 to STRLEN(CurrentBarcode) do begin
            //Checking if barcode constructed only of digits
            if not (CurrentBarcode[Count] in ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']) then
                ERROR(Text102);
        end;

        //Initializing EAN13 structure
        InitEAN13Structure(Structure, Encoding);

        //Checkdigit again
        CheckDigit := STRCHECKSUM(CurrentBarcode, Weight, 10);

        //Barcode to encode with checksum
        BarcodeWithCheckSum := COPYSTR(CurrentBarcode, 2, STRLEN(CurrentBarcode)) + FORMAT(CheckDigit);

        //Structure to use (Left Part)
        EVALUATE(StructureIndex, FORMAT(CurrentBarcode[1]));
        StructureIndex := StructureIndex + 1;
        LeftStructure := Structure[StructureIndex];

        //Add Beginning lines
        EncodedBarcode := EncodedBarcode + LRSeparator;

        for Count := 1 to STRLEN(BarcodeWithCheckSum) do begin
            //Add Middle Lines
            if Count = 7 then begin
                EncodedBarcode := EncodedBarcode + CSeparator;
            end;
            //Getting Barcode digit by index
            EVALUATE(NumberEval, FORMAT(BarcodeWithCheckSum[Count]));

            if Count <= 6 then begin
                //Left Part
                case LeftStructure[Count] of
                    'L':
                        EncodedBarcode := EncodedBarcode + Encoding[NumberEval + 1] [1];
                    'G':
                        EncodedBarcode := EncodedBarcode + Encoding[NumberEval + 1] [2];
                end;
            end else begin
                //Right Part
                EncodedBarcode := EncodedBarcode + Encoding[NumberEval + 1] [3];
            end;

        end;

        //Ending Lines
        EncodedBarcode := EncodedBarcode + LRSeparator;

        exit(EncodedBarcode);
        //HEI.86>>
    end;

    local procedure InitEAN13Structure(var Structures: array[10] of Text[6]; var Encodings: array[10, 3] of Text[7]);
    begin

        //HEI.86<<
        Structures[1] := 'LLLLLL';
        Structures[2] := 'LLGLGG';
        Structures[3] := 'LLGGLG';
        Structures[4] := 'LLGGGL';
        Structures[5] := 'LGLLGG';
        Structures[6] := 'LGGLLG';
        Structures[7] := 'LGGGLL';
        Structures[8] := 'LGLGLG';
        Structures[9] := 'LGLGGL';
        Structures[10] := 'LGGLGL';

        Encodings[1] [1] := '0001101';
        Encodings[1] [2] := '0100111';
        Encodings[1] [3] := '1110010';
        Encodings[2] [1] := '0011001';
        Encodings[2] [2] := '0110011';
        Encodings[2] [3] := '1100110';
        Encodings[3] [1] := '0010011';
        Encodings[3] [2] := '0011011';
        Encodings[3] [3] := '1101100';
        Encodings[4] [1] := '0111101';
        Encodings[4] [2] := '0100001';
        Encodings[4] [3] := '1000010';
        Encodings[5] [1] := '0100011';
        Encodings[5] [2] := '0011101';
        Encodings[5] [3] := '1011100';
        Encodings[6] [1] := '0110001';
        Encodings[6] [2] := '0111001';
        Encodings[6] [3] := '1001110';
        Encodings[7] [1] := '0101111';
        Encodings[7] [2] := '0000101';
        Encodings[7] [3] := '1010000';
        Encodings[8] [1] := '0111011';
        Encodings[8] [2] := '0010001';
        Encodings[8] [3] := '1000100';
        Encodings[9] [1] := '0110111';
        Encodings[9] [2] := '0001001';
        Encodings[9] [3] := '1001000';
        Encodings[10] [1] := '0001011';
        Encodings[10] [2] := '0010111';
        Encodings[10] [3] := '1110100';
        //HEI.86>>
    end;

    [EventSubscriber(ObjectType::Table, 270, 'OnAfterModifyEvent', '', false, false)]
    local procedure T270OnAfterValidate_BankForInvoiceLayout(var Rec: Record "Bank Account"; var xRec: Record "Bank Account"; RunTrigger: Boolean);
    var
        BankAccount: Record "Bank Account";
        ErrorBankCurr: Label 'Bank no. %1 already selected for the currency %2.';
        ErrorBankLocalCurr: Label 'Bank no. %1 already selected for the local currency';
    begin
        //HEI.92<<
        if Rec.ISTEMPORARY then exit;
        if Rec."Bank for invoice layout FND" then begin
            BankAccount.RESET();
            BankAccount.SETRANGE("Currency Code", Rec."Currency Code");
            BankAccount.SETRANGE("Bank for invoice layout FND", true);
            BankAccount.SETFILTER("No.", '<>%1', Rec."No.");
            if BankAccount.FINDFIRST() then
                if BankAccount."Currency Code" <> '' then
                    ERROR(ErrorBankCurr, BankAccount."No.", BankAccount."Currency Code")
                else
                    ERROR(ErrorBankLocalCurr, BankAccount."No.");
        end;
        //HEI.92>>
    end;

    [EventSubscriber(ObjectType::Table, 50211, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyT50211(var Rec: Record "Whse. Cost Alloc Setup FND"; var xRec: Record "Whse. Cost Alloc Setup FND"; RunTrigger: Boolean);
    var
        WhseCostAllocSetup: Record "Whse. Cost Alloc Setup FND";
        Text001: Label 'Allocation Type for %1 cannot be different than %2.';
        Text002: Label 'Allocation Type must be blank for %1.';
        Text003: Label 'Allocation % must be filled in only for Own Fleet.';
        Text004: Label 'Total Allocation % must be 100%.';
    begin
        //HEI.93<<
        if Rec."Allocation Type" <> Rec."Allocation Type"::" " then begin
            WhseCostAllocSetup.RESET();
            WhseCostAllocSetup.SETCURRENTKEY("C2S Name", "Allocation Type");
            WhseCostAllocSetup.SETRANGE("C2S Name", Rec."C2S Name");
            WhseCostAllocSetup.SETFILTER("Allocation Type", '<>%1', Rec."Allocation Type");
            if WhseCostAllocSetup.FINDFIRST() then
                if WhseCostAllocSetup."Allocation Type" <> WhseCostAllocSetup."Allocation Type"::" " then
                    ERROR(Text001, Rec."C2S Name", WhseCostAllocSetup."Allocation Type");
        end;
        //HEI.93>>

        //HEI.102
        if Rec."C2S Name" in [Rec."C2S Name"::"Delivery To Customers", Rec."C2S Name"::"Own Fleet"] then
            if Rec."Allocation Type" <> Rec."Allocation Type"::" " then
                ERROR(Text002, Rec."C2S Name");

        if Rec."C2S Name" <> Rec."C2S Name"::"Own Fleet" then begin
            if (Rec."Distance Allocation %" <> 0) or (Rec."Net Weight Allocation %" <> 0) or (Rec."No. of Drops Allocation %" <> 0) then
                ERROR(Text003)
        end else if ((Rec."Distance Allocation %" + Rec."Net Weight Allocation %" + Rec."No. of Drops Allocation %") <> 100) then
                ERROR(Text004);
        //HEI.102
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterInsertEvent', '', false, false)]
    local procedure T37OnAfterInsert_Timbre(var Rec: Record "Sales Line"; RunTrigger: Boolean);
    var
        DimensionSetEntry: Record "Dimension Set Entry";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        GenProdPostingGroup: Record "Gen. Product Posting Group";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesLine: Record "Sales Line";
        SalesLineTimbre: Record "Sales Line";
        SalesLineTimbreApplied: Record "Sales Line";
        DimensionManagement: Codeunit DimensionManagement;
        LineNo: Integer;
    begin
        //HEI.95<<
        if not RunTrigger then
            exit;
        if not SalesSetup.GET() or not SalesSetup."Timbre Electronique FND" or (SalesSetup."Timbre Resource Code FND" = '') then
            exit;
        if not GenProdPostingGroup.GET(Rec."Gen. Prod. Posting Group") or not GenProdPostingGroup."Include Timbre FND" then
            exit;
        if Rec."No." = SalesSetup."Timbre Resource Code FND" then
            exit;
        if not (Rec.Type in [Rec.Type::"G/L Account", Rec.Type::Item, Rec.Type::Resource, Rec.Type::"Fixed Asset"]) then
            exit;

        LineNo := 0;
        SalesLineTimbre.RESET();
        SalesLineTimbre.SETRANGE("Document Type", Rec."Document Type");
        SalesLineTimbre.SETRANGE("Document No.", Rec."Document No.");
        if SalesLineTimbre.FINDLAST() then
            LineNo := ROUND(SalesLineTimbre."Line No." + 1, 10000, '>');

        SalesLineTimbreApplied.RESET();
        SalesLineTimbreApplied.SETRANGE("Document Type", Rec."Document Type");
        SalesLineTimbreApplied.SETRANGE("Document No.", Rec."Document No.");
        SalesLineTimbreApplied.SETRANGE("Timbre applied FND", true);
        if SalesLineTimbreApplied.FINDFIRST() then begin
            //   if SalesLineTimbreApplied."Free Item" and (SalesLineTimbreApplied."Free Reason Code" <> '') and not Rec."Free Item" and (Rec."Free Reason Code" = '') then begin
            //     SalesLineTimbreApplied."Timbre applied" := false;
            //     SalesLineTimbreApplied.MODIFY;

            //     SalesLineTimbre.RESET;
            //     SalesLineTimbre.SETRANGE("Document Type",Rec."Document Type");
            //     SalesLineTimbre.SETRANGE("Document No.",Rec."Document No.");
            //     SalesLineTimbre.SETRANGE(Type,SalesLineTimbre.Type::Resource);
            //     SalesLineTimbre.SETRANGE("No.",SalesSetup."Timbre Resource Code FND");
            //     if SalesLineTimbre.FINDFIRST then begin
            //       LineNo := SalesLineTimbre."Line No.";
            //       SalesLineTimbre.DELETE;
            //     end;

            //     SalesLineTimbre.RESET;
            //     SalesLineTimbre.INIT;
            //     SalesLineTimbre.VALIDATE("Document Type",Rec."Document Type");
            //     SalesLineTimbre.VALIDATE("Document No.",Rec."Document No.");
            //     SalesLineTimbre.VALIDATE("Sell-to Customer No.",Rec."Sell-to Customer No.");
            //     SalesLineTimbre.VALIDATE("Line No.",LineNo);
            //     SalesLineTimbre.VALIDATE(Type,SalesLineTimbre.Type::Resource);
            //     SalesLineTimbre.VALIDATE("No.",SalesSetup."Timbre Resource Code FND");
            //     SalesLineTimbre.VALIDATE(Quantity,1);

            //     CLEAR(TempDimensionSetEntry);
            //     DimensionManagement.GetDimensionSet(TempDimensionSetEntry,SalesLineTimbre."Dimension Set ID");
            //     TempDimensionSetEntry.DELETEALL;

            //     DimensionSetEntry.RESET;
            //     DimensionSetEntry.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
            //     if DimensionSetEntry.FINDFIRST then
            //       repeat
            //         TempDimensionSetEntry.INIT;
            //         TempDimensionSetEntry."Dimension Code" := DimensionSetEntry."Dimension Code";
            //         TempDimensionSetEntry."Dimension Value Code" := DimensionSetEntry."Dimension Value Code";
            //         if TempDimensionSetEntry.INSERT(true) then;
            //       until DimensionSetEntry.NEXT = 0;

            //     SalesLineTimbre.VALIDATE("Dimension Set ID",DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
            //     SalesLineTimbre.INSERT(true);

            //     Rec."Timbre applied" := true;
            //     Rec.MODIFY;
            //   end;  // BC Upgrade NANDIS03 - Blocked as dependency on DIT field
        end else begin
            SalesLineTimbre.RESET();
            SalesLineTimbre.INIT();
            SalesLineTimbre.VALIDATE("Document Type", Rec."Document Type");
            SalesLineTimbre.VALIDATE("Document No.", Rec."Document No.");
            SalesLineTimbre.VALIDATE("Sell-to Customer No.", Rec."Sell-to Customer No.");
            SalesLineTimbre.VALIDATE("Line No.", LineNo);
            SalesLineTimbre.VALIDATE(Type, SalesLineTimbre.Type::Resource);
            SalesLineTimbre.VALIDATE("No.", SalesSetup."Timbre Resource Code FND");
            SalesLineTimbre.VALIDATE(Quantity, 1);
            // if Rec."Free Item" and (Rec."Free Reason Code" <> '') then begin
            //     SalesLineTimbre.VALIDATE("Line Discount %", Rec."Line Discount %");
            //     SalesLineTimbre.VALIDATE("Free Reason Code", Rec."Free Reason Code");
            //     SalesLineTimbre.VALIDATE("Gen. Bus. Posting Group", Rec."Gen. Bus. Posting Group");
            // end;  // BC Upgrade NANDIS03 - Blocked as dependency on DIT field

            CLEAR(TempDimensionSetEntry);
            DimensionManagement.GetDimensionSet(TempDimensionSetEntry, SalesLineTimbre."Dimension Set ID");
            TempDimensionSetEntry.DELETEALL();

            DimensionSetEntry.RESET();
            DimensionSetEntry.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
            if DimensionSetEntry.FINDFIRST() then
                repeat
                    TempDimensionSetEntry.INIT();
                    TempDimensionSetEntry."Dimension Code" := DimensionSetEntry."Dimension Code";
                    TempDimensionSetEntry."Dimension Value Code" := DimensionSetEntry."Dimension Value Code";
                    if TempDimensionSetEntry.INSERT(true) then;
                until DimensionSetEntry.NEXT() = 0;

            SalesLineTimbre.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
            SalesLineTimbre.INSERT(true);

            Rec."Timbre applied FND" := true;
            Rec.MODIFY();
        end;
        //HEI.95>>
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterDeleteEvent', '', false, false)]
    local procedure T37OnAfterDelete_Timbre(var Rec: Record "Sales Line"; RunTrigger: Boolean);
    var
        DimensionSetEntry: Record "Dimension Set Entry";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        GenProdPostingGroup: Record "Gen. Product Posting Group";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesLineTimbre: Record "Sales Line";
        SalesLineTimbreApplied: Record "Sales Line";
        DimensionManagement: Codeunit DimensionManagement;
        LineNo: Integer;
    begin
        //HEI.95<<
        if not RunTrigger then
            exit;
        if not SalesSetup.GET() or not SalesSetup."Timbre Electronique FND" or (SalesSetup."Timbre Resource Code FND" = '') then
            exit;
        if Rec."No." = SalesSetup."Timbre Resource Code FND" then begin
            SalesLineTimbreApplied.RESET();
            SalesLineTimbreApplied.SETRANGE("Document Type", Rec."Document Type");
            SalesLineTimbreApplied.SETRANGE("Document No.", Rec."Document No.");
            SalesLineTimbreApplied.SETRANGE("Timbre applied FND", true);
            if SalesLineTimbreApplied.FINDFIRST() then begin
                SalesLineTimbreApplied."Timbre applied FND" := false;
                SalesLineTimbreApplied.MODIFY();
            end;
            exit;
        end;

        LineNo := 0;
        SalesLineTimbre.RESET();
        SalesLineTimbre.SETRANGE("Document Type", Rec."Document Type");
        SalesLineTimbre.SETRANGE("Document No.", Rec."Document No.");
        if SalesLineTimbre.FINDLAST() then
            LineNo := ROUND(SalesLineTimbre."Line No." + 1, 10000, '>');

        if Rec."Timbre applied FND" then begin
            SalesLineTimbre.RESET();
            SalesLineTimbre.SETRANGE("Document Type", Rec."Document Type");
            SalesLineTimbre.SETRANGE("Document No.", Rec."Document No.");
            SalesLineTimbre.SETRANGE(Type, SalesLineTimbre.Type::Resource);
            SalesLineTimbre.SETRANGE("No.", SalesSetup."Timbre Resource Code FND");
            if SalesLineTimbre.FINDFIRST() then begin
                LineNo := SalesLineTimbre."Line No.";
                SalesLineTimbre.DELETE();
            end;

            SalesLineTimbreApplied.RESET();
            SalesLineTimbreApplied.SETRANGE("Document Type", Rec."Document Type");
            SalesLineTimbreApplied.SETRANGE("Document No.", Rec."Document No.");
            // SalesLineTimbreApplied.SETRANGE("Free Item", false);  // BC Upgrade NANDIS03 - dependency on DIT
            // SalesLineTimbreApplied.SETFILTER("Free Reason Code", '=%1', '');  // BC Upgrade NANDIS03 - dependency on DIT
            if SalesLineTimbreApplied.FINDFIRST() then
                repeat
                    if GenProdPostingGroup.GET(SalesLineTimbreApplied."Gen. Prod. Posting Group") and GenProdPostingGroup."Include Timbre FND" then begin
                        SalesLineTimbre.RESET();
                        SalesLineTimbre.INIT();
                        SalesLineTimbre.VALIDATE("Document Type", SalesLineTimbreApplied."Document Type");
                        SalesLineTimbre.VALIDATE("Document No.", SalesLineTimbreApplied."Document No.");
                        SalesLineTimbre.VALIDATE("Sell-to Customer No.", SalesLineTimbreApplied."Sell-to Customer No.");
                        SalesLineTimbre.VALIDATE("Line No.", LineNo);
                        SalesLineTimbre.VALIDATE(Type, SalesLineTimbre.Type::Resource);
                        SalesLineTimbre.VALIDATE("No.", SalesSetup."Timbre Resource Code FND");
                        SalesLineTimbre.VALIDATE(Quantity, 1);

                        CLEAR(TempDimensionSetEntry);
                        DimensionManagement.GetDimensionSet(TempDimensionSetEntry, SalesLineTimbre."Dimension Set ID");
                        TempDimensionSetEntry.DELETEALL();

                        DimensionSetEntry.RESET();
                        DimensionSetEntry.SETRANGE("Dimension Set ID", SalesLineTimbreApplied."Dimension Set ID");
                        if DimensionSetEntry.FINDFIRST() then
                            repeat
                                TempDimensionSetEntry.INIT();
                                TempDimensionSetEntry."Dimension Code" := DimensionSetEntry."Dimension Code";
                                TempDimensionSetEntry."Dimension Value Code" := DimensionSetEntry."Dimension Value Code";
                                if TempDimensionSetEntry.INSERT(true) then;
                            until DimensionSetEntry.NEXT() = 0;

                        SalesLineTimbre.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                        SalesLineTimbre.INSERT(true);

                        SalesLineTimbreApplied."Timbre applied FND" := true;
                        SalesLineTimbreApplied.MODIFY();
                        exit;
                    end;
                until SalesLineTimbreApplied.NEXT() = 0;

            SalesLineTimbreApplied.RESET();
            SalesLineTimbreApplied.SETRANGE("Document Type", Rec."Document Type");
            SalesLineTimbreApplied.SETRANGE("Document No.", Rec."Document No.");
            // SalesLineTimbreApplied.SETRANGE("Free Item", true);  // BC Upgrade NANDIS03 - dependency on DIT
            // SalesLineTimbreApplied.SETFILTER("Free Reason Code", '<>%1', '');  // BC Upgrade NANDIS03 - dependency on DIT
            if SalesLineTimbreApplied.FINDFIRST() then
                repeat
                    if GenProdPostingGroup.GET(SalesLineTimbreApplied."Gen. Prod. Posting Group") and GenProdPostingGroup."Include Timbre FND" then begin
                        SalesLineTimbre.RESET();
                        SalesLineTimbre.INIT();
                        SalesLineTimbre.VALIDATE("Document Type", SalesLineTimbreApplied."Document Type");
                        SalesLineTimbre.VALIDATE("Document No.", SalesLineTimbreApplied."Document No.");
                        SalesLineTimbre.VALIDATE("Sell-to Customer No.", SalesLineTimbreApplied."Sell-to Customer No.");
                        SalesLineTimbre.VALIDATE("Line No.", LineNo);
                        SalesLineTimbre.VALIDATE(Type, SalesLineTimbre.Type::Resource);
                        SalesLineTimbre.VALIDATE("No.", SalesSetup."Timbre Resource Code FND");
                        SalesLineTimbre.VALIDATE(Quantity, 1);
                        SalesLineTimbre.VALIDATE("Line Discount %", SalesLineTimbreApplied."Line Discount %");
                        // SalesLineTimbre.VALIDATE("Free Reason Code", SalesLineTimbreApplied."Free Reason Code");  // BC Upgrade NANDIS03 - dependency on DIT
                        SalesLineTimbre.VALIDATE("Gen. Bus. Posting Group", SalesLineTimbreApplied."Gen. Bus. Posting Group");

                        CLEAR(TempDimensionSetEntry);
                        DimensionManagement.GetDimensionSet(TempDimensionSetEntry, SalesLineTimbre."Dimension Set ID");
                        TempDimensionSetEntry.DELETEALL();

                        DimensionSetEntry.RESET();
                        DimensionSetEntry.SETRANGE("Dimension Set ID", SalesLineTimbreApplied."Dimension Set ID");
                        if DimensionSetEntry.FINDFIRST() then
                            repeat
                                TempDimensionSetEntry.INIT();
                                TempDimensionSetEntry."Dimension Code" := DimensionSetEntry."Dimension Code";
                                TempDimensionSetEntry."Dimension Value Code" := DimensionSetEntry."Dimension Value Code";
                                if TempDimensionSetEntry.INSERT(true) then;
                            until DimensionSetEntry.NEXT() = 0;

                        SalesLineTimbre.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                        SalesLineTimbre.INSERT(true);

                        SalesLineTimbreApplied."Timbre applied FND" := true;
                        SalesLineTimbreApplied.MODIFY();
                        exit;
                    end;
                until SalesLineTimbreApplied.NEXT() = 0;
        end;
        //HEI.95>>
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure T37OnBeforeDelete_Timbre(var Rec: Record "Sales Line"; RunTrigger: Boolean);
    var
        GenProdPostingGroup: Record "Gen. Product Posting Group";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesLineTimbre: Record "Sales Line";
        SalesLineTimbreApplied: Record "Sales Line";
        Error001: Label 'The Timbre line cannot be modified/deleted.';
    begin
        //HEI.95<<
        if not RunTrigger then
            exit;
        if not SalesSetup.GET() or not SalesSetup."Timbre Electronique FND" or (SalesSetup."Timbre Resource Code FND" = '') then
            exit;
        if (Rec."No." = SalesSetup."Timbre Resource Code FND") and not SalesSetup."Editable Timbre Docs. FND" then begin
            if AllowTimbreDeletion then exit; //HEI.99
            SalesLineTimbre.RESET();
            SalesLineTimbre.SETRANGE("Document Type", Rec."Document Type");
            SalesLineTimbre.SETRANGE("Document No.", Rec."Document No.");
            SalesLineTimbre.SETRANGE("Timbre applied FND", true);
            if SalesLineTimbre.FINDFIRST() then
                ERROR(Error001);
        end;
        //HEI.95>>
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnBeforeModifyEvent', '', false, false)]
    local procedure T37OnBeforeModify_Timbre(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; RunTrigger: Boolean);
    var
        GenProdPostingGroup: Record "Gen. Product Posting Group";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesLineTimbre: Record "Sales Line";
        SalesLineTimbreApplied: Record "Sales Line";
        Error001: Label 'The Timbre line cannot be modified/deleted.';
    begin
        //HEI.95<<
        if not RunTrigger then
            exit;
        if not SalesSetup.GET() or not SalesSetup."Timbre Electronique FND" or (SalesSetup."Timbre Resource Code FND" = '') then
            exit;
        // if (Rec."No." = SalesSetup."Timbre Resource Code FND") and not SalesSetup."Editable Timbre Docs. FND" and not Rec.Get_bln"Changed FND"fromHeader then
        //     ERROR(Error001);  // BC Upgrade NANDIS03 - function not defined in 37 extension
        //HEI.95>>
    end;

    // [EventSubscriber(ObjectType::Table, 37, 'OnAfterValidateEvent', 'Free Reason Code', false, false)]
    // local procedure T37OnAfterValidate_FreeReasonCode_Timbre(var Rec : Record "Sales Line";var xRec : Record "Sales Line";CurrFieldNo : Integer);
    // var
    //     SalesLineTimbreApplied : Record "Sales Line";
    //     GenProdPostingGroup : Record "Gen. Product Posting Group";
    //     SalesSetup : Record "Sales & Receivables Setup";
    //     SalesLineTimbre : Record "Sales Line";
    //     LineNo : Integer;
    //     SalesLine : Record "Sales Line";
    //     TempDimensionSetEntry : Record "Dimension Set Entry" temporary;
    //     DimensionSetEntry : Record "Dimension Set Entry";
    //     DimensionManagement : Codeunit DimensionManagement;
    // begin
    //     //HEI.95<<
    //     if not SalesSetup.GET or not SalesSetup."Timbre Electronique FND" or (SalesSetup."Timbre Resource Code FND" = '') then
    //       exit;
    //     if Rec."No." = SalesSetup."Timbre Resource Code FND" then
    //       exit;
    //     if not (Rec.Type in [Rec.Type::"G/L Account",Rec.Type::Item,Rec.Type::Resource,Rec.Type::"Fixed Asset"]) then
    //       exit;
    //     if not GenProdPostingGroup.GET(Rec."Gen. Prod. Posting Group") or not GenProdPostingGroup."Include Timbre" then
    //       exit;

    //     if (Rec."Free Reason Code" <> '') and (Rec."Free Reason Code" <> xRec."Free Reason Code") then begin//(xRec."Free Reason Code" = '') THEN BEGIN
    //       if Rec."Timbre applied" then begin
    //         LineNo := 0;
    //         SalesLineTimbre.RESET;
    //         SalesLineTimbre.SETRANGE("Document Type",Rec."Document Type");
    //         SalesLineTimbre.SETRANGE("Document No.",Rec."Document No.");
    //         if SalesLineTimbre.FINDLAST then
    //           LineNo := ROUND(SalesLineTimbre."Line No." + 1,10000,'>');

    //         SalesLineTimbreApplied.RESET;
    //         SalesLineTimbreApplied.SETRANGE("Document Type",Rec."Document Type");
    //         SalesLineTimbreApplied.SETRANGE("Document No.",Rec."Document No.");
    //         SalesLineTimbreApplied.SETRANGE("Free Item",false);
    //         SalesLineTimbreApplied.SETFILTER("Free Reason Code",'=%1','');
    //         SalesLineTimbreApplied.SETFILTER("Line No.",'<>%1',Rec."Line No.");
    //         SalesLineTimbreApplied.SETFILTER(Type,'<>%1', Rec.Type::"Charge (Item)");
    //         if SalesLineTimbreApplied.FINDFIRST then repeat
    //           if GenProdPostingGroup.GET(SalesLineTimbreApplied."Gen. Prod. Posting Group") and GenProdPostingGroup."Include Timbre" then begin
    //             SalesLineTimbre.RESET;
    //             SalesLineTimbre.SETRANGE("Document Type",Rec."Document Type");
    //             SalesLineTimbre.SETRANGE("Document No.",Rec."Document No.");
    //             SalesLineTimbre.SETRANGE(Type,SalesLineTimbre.Type::Resource);
    //             SalesLineTimbre.SETRANGE("No.",SalesSetup."Timbre Resource Code FND");
    //             if SalesLineTimbre.FINDFIRST then begin
    //               LineNo := SalesLineTimbre."Line No.";
    //               SalesLineTimbre.DELETE;
    //             end;

    //             SalesLineTimbre.RESET;
    //             SalesLineTimbre.INIT;
    //             SalesLineTimbre.VALIDATE("Document Type",SalesLineTimbreApplied."Document Type");
    //             SalesLineTimbre.VALIDATE("Document No.",SalesLineTimbreApplied."Document No.");
    //             SalesLineTimbre.VALIDATE("Sell-to Customer No.",SalesLineTimbreApplied."Sell-to Customer No.");
    //             SalesLineTimbre.VALIDATE("Line No.",LineNo);
    //             SalesLineTimbre.VALIDATE(Type,SalesLineTimbre.Type::Resource);
    //             SalesLineTimbre.VALIDATE("No.",SalesSetup."Timbre Resource Code FND");
    //             SalesLineTimbre.VALIDATE(Quantity,1);

    //             CLEAR(TempDimensionSetEntry);
    //             DimensionManagement.GetDimensionSet(TempDimensionSetEntry,SalesLineTimbre."Dimension Set ID");
    //             TempDimensionSetEntry.DELETEALL;

    //             DimensionSetEntry.RESET;
    //             DimensionSetEntry.SETRANGE("Dimension Set ID", SalesLineTimbreApplied."Dimension Set ID");
    //             if DimensionSetEntry.FINDFIRST then
    //               repeat
    //                 TempDimensionSetEntry.INIT;
    //                 TempDimensionSetEntry."Dimension Code" := DimensionSetEntry."Dimension Code";
    //                 TempDimensionSetEntry."Dimension Value Code" := DimensionSetEntry."Dimension Value Code";
    //                 if TempDimensionSetEntry.INSERT(true) then;
    //               until DimensionSetEntry.NEXT = 0;

    //             SalesLineTimbre.VALIDATE("Dimension Set ID",DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
    //             SalesLineTimbre.INSERT(true);

    //             SalesLineTimbreApplied."Timbre applied" := true;
    //             SalesLineTimbreApplied.MODIFY;
    //             exit;
    //           end;
    //         until SalesLineTimbreApplied.NEXT = 0;

    //         SalesLineTimbre.RESET;
    //         SalesLineTimbre.SETRANGE("Document Type",Rec."Document Type");
    //         SalesLineTimbre.SETRANGE("Document No.",Rec."Document No.");
    //         SalesLineTimbre.SETRANGE(Type,SalesLineTimbre.Type::Resource);
    //         SalesLineTimbre.SETRANGE("No.",SalesSetup."Timbre Resource Code FND");
    //         if SalesLineTimbre.FINDFIRST then begin
    //           SalesLineTimbre.VALIDATE("Line Discount %",Rec."Line Discount %");
    //           SalesLineTimbre.VALIDATE("Free Reason Code",Rec."Free Reason Code");
    //           SalesLineTimbre.VALIDATE("Gen. Bus. Posting Group",Rec."Gen. Bus. Posting Group");
    //           SalesLineTimbre.MODIFY;
    //         end;
    //       end;
    //       exit;
    //     end;

    //     if (Rec."Free Reason Code" = '') and (xRec."Free Reason Code" <> '') then begin
    //       if Rec."Timbre applied" then begin
    //         SalesLineTimbre.RESET;
    //         SalesLineTimbre.SETRANGE("Document Type",Rec."Document Type");
    //         SalesLineTimbre.SETRANGE("Document No.",Rec."Document No.");
    //         SalesLineTimbre.SETRANGE(Type,SalesLineTimbre.Type::Resource);
    //         SalesLineTimbre.SETRANGE("No.",SalesSetup."Timbre Resource Code FND");
    //         if SalesLineTimbre.FINDFIRST then begin
    //           SalesLineTimbre.VALIDATE("Line Discount %",Rec."Line Discount %");
    //           SalesLineTimbre.VALIDATE("Free Reason Code",Rec."Free Reason Code");
    //           SalesLineTimbre.VALIDATE("Gen. Bus. Posting Group",Rec."Gen. Bus. Posting Group");
    //           SalesLineTimbre.MODIFY;
    //         end;
    //       end else begin
    //         SalesLineTimbre.RESET;
    //         SalesLineTimbre.SETRANGE("Document Type",Rec."Document Type");
    //         SalesLineTimbre.SETRANGE("Document No.",Rec."Document No.");
    //         SalesLineTimbre.SETRANGE(Type,SalesLineTimbre.Type::Resource);
    //         SalesLineTimbre.SETRANGE("No.",SalesSetup."Timbre Resource Code FND");
    //         SalesLineTimbre.SETFILTER("Free Reason Code", '<>%1','');
    //         if SalesLineTimbre.FINDFIRST then begin
    //           LineNo := SalesLineTimbre."Line No.";
    //           SalesLineTimbre.DELETE;
    //         end;

    //         SalesLineTimbre.RESET;
    //         SalesLineTimbre.INIT;
    //         SalesLineTimbre.VALIDATE("Document Type",Rec."Document Type");
    //         SalesLineTimbre.VALIDATE("Document No.",Rec."Document No.");
    //         SalesLineTimbre.VALIDATE("Sell-to Customer No.",Rec."Sell-to Customer No.");
    //         SalesLineTimbre.VALIDATE("Line No.",LineNo);
    //         SalesLineTimbre.VALIDATE(Type,SalesLineTimbre.Type::Resource);
    //         SalesLineTimbre.VALIDATE("No.",SalesSetup."Timbre Resource Code FND");
    //         SalesLineTimbre.VALIDATE(Quantity,1);

    //         CLEAR(TempDimensionSetEntry);
    //         DimensionManagement.GetDimensionSet(TempDimensionSetEntry,SalesLineTimbre."Dimension Set ID");
    //         TempDimensionSetEntry.DELETEALL;

    //         DimensionSetEntry.RESET;
    //         DimensionSetEntry.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
    //         if DimensionSetEntry.FINDFIRST then
    //           repeat
    //             TempDimensionSetEntry.INIT;
    //             TempDimensionSetEntry."Dimension Code" := DimensionSetEntry."Dimension Code";
    //             TempDimensionSetEntry."Dimension Value Code" := DimensionSetEntry."Dimension Value Code";
    //             if TempDimensionSetEntry.INSERT(true) then;
    //           until DimensionSetEntry.NEXT = 0;

    //         SalesLineTimbre.VALIDATE("Dimension Set ID",DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
    //         SalesLineTimbre.INSERT(true);

    //         Rec."Timbre applied" := true;
    //         Rec.MODIFY;
    //       end;
    //       exit;
    //     end;
    //     //HEI.95>>
    // end;  // BC Upgrade NANDIS03 - dependency on DIT

    // [EventSubscriber(ObjectType::Table, 37, 'OnAfterValidateEvent', 'No.', false, false)]
    // local procedure T37OnAfterValidat_No_Timbre(var Rec : Record "Sales Line";var xRec : Record "Sales Line";CurrFieldNo : Integer);
    // var
    //     SalesLineTimbreApplied : Record "Sales Line";
    //     GenProdPostingGroup : Record "Gen. Product Posting Group";
    //     SalesSetup : Record "Sales & Receivables Setup";
    //     SalesLineTimbre : Record "Sales Line";
    //     LineNo : Integer;
    //     SalesLine : Record "Sales Line";
    //     TempDimensionSetEntry : Record "Dimension Set Entry" temporary;
    //     DimensionSetEntry : Record "Dimension Set Entry";
    //     DimensionManagement : Codeunit DimensionManagement;
    // begin
    //     //HEI.95<<
    //     if not SalesSetup.GET or not SalesSetup."Timbre Electronique FND" or (SalesSetup."Timbre Resource Code FND" = '') then
    //       exit;
    //     if Rec."No." = SalesSetup."Timbre Resource Code FND" then
    //       exit;
    //     if not (Rec.Type in [Rec.Type::"G/L Account",Rec.Type::Item,Rec.Type::Resource,Rec.Type::"Fixed Asset"]) then
    //       exit;

    //     SalesLineTimbre.RESET;
    //     SalesLineTimbre.SETRANGE("Document Type",Rec."Document Type");
    //     SalesLineTimbre.SETRANGE("Document No.",Rec."Document No.");
    //     SalesLineTimbre.SETRANGE("Line No.",Rec."Line No.");
    //     if not SalesLineTimbre.FINDFIRST then
    //       exit;

    //     if not Rec."Timbre applied" then begin
    //       if GenProdPostingGroup.GET(Rec."Gen. Prod. Posting Group") and GenProdPostingGroup."Include Timbre" then begin
    //         LineNo := 0;
    //         SalesLineTimbre.RESET;
    //         SalesLineTimbre.SETRANGE("Document Type",Rec."Document Type");
    //         SalesLineTimbre.SETRANGE("Document No.",Rec."Document No.");
    //         if SalesLineTimbre.FINDLAST then
    //           LineNo := ROUND(SalesLineTimbre."Line No." + 1,10000,'>');

    //         if xRec."Timbre applied" then begin
    //           SalesLineTimbre.RESET;
    //           SalesLineTimbre.SETRANGE("Document Type",Rec."Document Type");
    //           SalesLineTimbre.SETRANGE("Document No.",Rec."Document No.");
    //           SalesLineTimbre.SETRANGE(Type,SalesLineTimbre.Type::Resource);
    //           SalesLineTimbre.SETRANGE("No.",SalesSetup."Timbre Resource Code FND");
    //           if SalesLineTimbre.FINDFIRST then begin
    //             LineNo := SalesLineTimbre."Line No.";
    //             SalesLineTimbre.DELETE;
    //           end;
    //         end;

    //         SalesLineTimbreApplied.RESET;
    //         SalesLineTimbreApplied.SETRANGE("Document Type",Rec."Document Type");
    //         SalesLineTimbreApplied.SETRANGE("Document No.",Rec."Document No.");
    //         SalesLineTimbreApplied.SETRANGE("Timbre applied",true);
    //         SalesLineTimbreApplied.SETFILTER("Line No.", '<>%1', Rec."Line No.");
    //         if SalesLineTimbreApplied.FINDFIRST then begin
    //           if SalesLineTimbreApplied."Free Item" and (SalesLineTimbreApplied."Free Reason Code" <> '') and not Rec."Free Item" and (Rec."Free Reason Code" = '') then begin
    //             SalesLineTimbreApplied."Timbre applied" := false;
    //             SalesLineTimbreApplied.MODIFY;

    //             SalesLineTimbre.RESET;
    //             SalesLineTimbre.SETRANGE("Document Type",Rec."Document Type");
    //             SalesLineTimbre.SETRANGE("Document No.",Rec."Document No.");
    //             SalesLineTimbre.SETRANGE(Type,SalesLineTimbre.Type::Resource);
    //             SalesLineTimbre.SETRANGE("No.",SalesSetup."Timbre Resource Code FND");
    //             if SalesLineTimbre.FINDFIRST then begin
    //               LineNo := SalesLineTimbre."Line No.";
    //               SalesLineTimbre.DELETE;
    //             end;

    //             SalesLineTimbre.RESET;
    //             SalesLineTimbre.INIT;
    //             SalesLineTimbre.VALIDATE("Document Type",Rec."Document Type");
    //             SalesLineTimbre.VALIDATE("Document No.",Rec."Document No.");
    //             SalesLineTimbre.VALIDATE("Sell-to Customer No.",Rec."Sell-to Customer No.");
    //             SalesLineTimbre.VALIDATE("Line No.",LineNo);
    //             SalesLineTimbre.VALIDATE(Type,SalesLineTimbre.Type::Resource);
    //             SalesLineTimbre.VALIDATE("No.",SalesSetup."Timbre Resource Code FND");
    //             SalesLineTimbre.VALIDATE(Quantity,1);

    //             CLEAR(TempDimensionSetEntry);
    //             DimensionManagement.GetDimensionSet(TempDimensionSetEntry,SalesLineTimbre."Dimension Set ID");
    //             TempDimensionSetEntry.DELETEALL;

    //             DimensionSetEntry.RESET;
    //             DimensionSetEntry.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
    //             if DimensionSetEntry.FINDFIRST then
    //               repeat
    //                 TempDimensionSetEntry.INIT;
    //                 TempDimensionSetEntry."Dimension Code" := DimensionSetEntry."Dimension Code";
    //                 TempDimensionSetEntry."Dimension Value Code" := DimensionSetEntry."Dimension Value Code";
    //                 if TempDimensionSetEntry.INSERT(true) then;
    //               until DimensionSetEntry.NEXT = 0;

    //             SalesLineTimbre.VALIDATE("Dimension Set ID",DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
    //             SalesLineTimbre.INSERT(true);

    //             Rec."Timbre applied" := true;
    //             Rec.MODIFY;
    //           end;
    //         end else begin
    //           SalesLineTimbre.RESET;
    //           SalesLineTimbre.INIT;
    //           SalesLineTimbre.VALIDATE("Document Type",Rec."Document Type");
    //           SalesLineTimbre.VALIDATE("Document No.",Rec."Document No.");
    //           SalesLineTimbre.VALIDATE("Sell-to Customer No.",Rec."Sell-to Customer No.");
    //           SalesLineTimbre.VALIDATE("Line No.",LineNo);
    //           SalesLineTimbre.VALIDATE(Type,SalesLineTimbre.Type::Resource);
    //           SalesLineTimbre.VALIDATE("No.",SalesSetup."Timbre Resource Code FND");
    //           SalesLineTimbre.VALIDATE(Quantity,1);
    //           if Rec."Free Item" and (Rec."Free Reason Code" <> '') then begin
    //             SalesLineTimbre.VALIDATE("Line Discount %",Rec."Line Discount %");
    //             SalesLineTimbre.VALIDATE("Free Reason Code",Rec."Free Reason Code");
    //             SalesLineTimbre.VALIDATE("Gen. Bus. Posting Group",Rec."Gen. Bus. Posting Group");
    //           end;

    //           CLEAR(TempDimensionSetEntry);
    //           DimensionManagement.GetDimensionSet(TempDimensionSetEntry,SalesLineTimbre."Dimension Set ID");
    //           TempDimensionSetEntry.DELETEALL;

    //           DimensionSetEntry.RESET;
    //           DimensionSetEntry.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
    //           if DimensionSetEntry.FINDFIRST then
    //             repeat
    //               TempDimensionSetEntry.INIT;
    //               TempDimensionSetEntry."Dimension Code" := DimensionSetEntry."Dimension Code";
    //               TempDimensionSetEntry."Dimension Value Code" := DimensionSetEntry."Dimension Value Code";
    //               if TempDimensionSetEntry.INSERT(true) then;
    //             until DimensionSetEntry.NEXT = 0;

    //           SalesLineTimbre.VALIDATE("Dimension Set ID",DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
    //           SalesLineTimbre.INSERT(true);

    //           Rec."Timbre applied" := true;
    //           Rec.MODIFY;
    //         end;
    //       end;
    //     end else begin
    //       if GenProdPostingGroup.GET(Rec."Gen. Prod. Posting Group") and not GenProdPostingGroup."Include Timbre" then begin
    //         LineNo := 0;
    //         SalesLineTimbre.RESET;
    //         SalesLineTimbre.SETRANGE("Document Type",Rec."Document Type");
    //         SalesLineTimbre.SETRANGE("Document No.",Rec."Document No.");
    //         if SalesLineTimbre.FINDLAST then
    //           LineNo := ROUND(SalesLineTimbre."Line No." + 1,10000,'>');

    //         SalesLineTimbre.RESET;
    //         SalesLineTimbre.SETRANGE("Document Type",Rec."Document Type");
    //         SalesLineTimbre.SETRANGE("Document No.",Rec."Document No.");
    //         SalesLineTimbre.SETRANGE(Type,SalesLineTimbre.Type::Resource);
    //         SalesLineTimbre.SETRANGE("No.",SalesSetup."Timbre Resource Code FND");
    //         if SalesLineTimbre.FINDFIRST then begin
    //           LineNo := SalesLineTimbre."Line No.";
    //           SalesLineTimbre.DELETE;
    //         end;

    //         SalesLineTimbreApplied.RESET;
    //         SalesLineTimbreApplied.SETRANGE("Document Type",Rec."Document Type");
    //         SalesLineTimbreApplied.SETRANGE("Document No.",Rec."Document No.");
    //         SalesLineTimbreApplied.SETRANGE("Free Item",false);
    //         SalesLineTimbreApplied.SETFILTER("Line No.",'<>%1',Rec."Line No.");
    //         SalesLineTimbreApplied.SETFILTER("Free Reason Code",'=%1','');
    //         if SalesLineTimbreApplied.FINDFIRST then repeat
    //           if GenProdPostingGroup.GET(SalesLineTimbreApplied."Gen. Prod. Posting Group") and GenProdPostingGroup."Include Timbre" then begin
    //             SalesLineTimbre.RESET;
    //             SalesLineTimbre.INIT;
    //             SalesLineTimbre.VALIDATE("Document Type",SalesLineTimbreApplied."Document Type");
    //             SalesLineTimbre.VALIDATE("Document No.",SalesLineTimbreApplied."Document No.");
    //             SalesLineTimbre.VALIDATE("Sell-to Customer No.",SalesLineTimbreApplied."Sell-to Customer No.");
    //             SalesLineTimbre.VALIDATE("Line No.",LineNo);
    //             SalesLineTimbre.VALIDATE(Type,SalesLineTimbre.Type::Resource);
    //             SalesLineTimbre.VALIDATE("No.",SalesSetup."Timbre Resource Code FND");
    //             SalesLineTimbre.VALIDATE(Quantity,1);

    //             CLEAR(TempDimensionSetEntry);
    //             DimensionManagement.GetDimensionSet(TempDimensionSetEntry,SalesLineTimbre."Dimension Set ID");
    //             TempDimensionSetEntry.DELETEALL;

    //             DimensionSetEntry.RESET;
    //             DimensionSetEntry.SETRANGE("Dimension Set ID", SalesLineTimbreApplied."Dimension Set ID");
    //             if DimensionSetEntry.FINDFIRST then
    //               repeat
    //                 TempDimensionSetEntry.INIT;
    //                 TempDimensionSetEntry."Dimension Code" := DimensionSetEntry."Dimension Code";
    //                 TempDimensionSetEntry."Dimension Value Code" := DimensionSetEntry."Dimension Value Code";
    //                 if TempDimensionSetEntry.INSERT(true) then;
    //               until DimensionSetEntry.NEXT = 0;

    //             SalesLineTimbre.VALIDATE("Dimension Set ID",DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
    //             SalesLineTimbre.INSERT(true);

    //             SalesLineTimbreApplied."Timbre applied" := true;
    //             SalesLineTimbreApplied.MODIFY;
    //             exit;
    //           end;
    //         until SalesLineTimbreApplied.NEXT = 0;

    //         SalesLineTimbreApplied.RESET;
    //         SalesLineTimbreApplied.SETRANGE("Document Type",Rec."Document Type");
    //         SalesLineTimbreApplied.SETRANGE("Document No.",Rec."Document No.");
    //         SalesLineTimbreApplied.SETRANGE("Free Item",true);
    //         SalesLineTimbreApplied.SETFILTER("Line No.",'<>%1',Rec."Line No.");
    //         SalesLineTimbreApplied.SETFILTER("Free Reason Code",'<>%1','');
    //         if SalesLineTimbreApplied.FINDFIRST then repeat
    //           if GenProdPostingGroup.GET(SalesLineTimbreApplied."Gen. Prod. Posting Group") and GenProdPostingGroup."Include Timbre" then begin
    //             SalesLineTimbre.RESET;
    //             SalesLineTimbre.INIT;
    //             SalesLineTimbre.VALIDATE("Document Type",SalesLineTimbreApplied."Document Type");
    //             SalesLineTimbre.VALIDATE("Document No.",SalesLineTimbreApplied."Document No.");
    //             SalesLineTimbre.VALIDATE("Sell-to Customer No.",SalesLineTimbreApplied."Sell-to Customer No.");
    //             SalesLineTimbre.VALIDATE("Line No.",LineNo);
    //             SalesLineTimbre.VALIDATE(Type,SalesLineTimbre.Type::Resource);
    //             SalesLineTimbre.VALIDATE("No.",SalesSetup."Timbre Resource Code FND");
    //             SalesLineTimbre.VALIDATE(Quantity,1);
    //             SalesLineTimbre."Line Discount %" := 100;
    //             SalesLineTimbre.VALIDATE("Line Discount %",SalesLineTimbreApplied."Line Discount %");
    //             SalesLineTimbre.VALIDATE("Free Reason Code",SalesLineTimbreApplied."Free Reason Code");
    //             SalesLineTimbre.VALIDATE("Gen. Bus. Posting Group",SalesLineTimbreApplied."Gen. Bus. Posting Group");

    //             CLEAR(TempDimensionSetEntry);
    //             DimensionManagement.GetDimensionSet(TempDimensionSetEntry,SalesLineTimbre."Dimension Set ID");
    //             TempDimensionSetEntry.DELETEALL;

    //             DimensionSetEntry.RESET;
    //             DimensionSetEntry.SETRANGE("Dimension Set ID", SalesLineTimbreApplied."Dimension Set ID");
    //             if DimensionSetEntry.FINDFIRST then
    //               repeat
    //                 TempDimensionSetEntry.INIT;
    //                 TempDimensionSetEntry."Dimension Code" := DimensionSetEntry."Dimension Code";
    //                 TempDimensionSetEntry."Dimension Value Code" := DimensionSetEntry."Dimension Value Code";
    //                 if TempDimensionSetEntry.INSERT(true) then;
    //               until DimensionSetEntry.NEXT = 0;

    //             SalesLineTimbre.VALIDATE("Dimension Set ID",DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
    //             SalesLineTimbre.INSERT(true);

    //             SalesLineTimbreApplied."Timbre applied" := true;
    //             SalesLineTimbreApplied.MODIFY;
    //             exit;
    //           end;
    //         until SalesLineTimbreApplied.NEXT = 0;
    //       end;
    //     end;
    //     //HEI.95>>
    // end;  // BC Upgrade NANDIS03 - dependency on DIT

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterValidateEvent', 'Location Code', false, false)]
    local procedure T37OnAfterValidate_Location_Timbre(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer);
    var
        DimensionSetEntry: Record "Dimension Set Entry";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        GenProdPostingGroup: Record "Gen. Product Posting Group";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesLine: Record "Sales Line";
        SalesLineTimbre: Record "Sales Line";
        SalesLineTimbreApplied: Record "Sales Line";
        DimensionManagement: Codeunit DimensionManagement;
        LineNo: Integer;
    begin
        //HEI.98<<
        if not SalesSetup.GET() or not SalesSetup."Timbre Electronique FND" or (SalesSetup."Timbre Resource Code FND" = '') then
            exit;
        if Rec."No." = SalesSetup."Timbre Resource Code FND" then
            exit;
        if not (Rec.Type in [Rec.Type::"G/L Account", Rec.Type::Item, Rec.Type::Resource, Rec.Type::"Fixed Asset"]) then
            exit;
        if not GenProdPostingGroup.GET(Rec."Gen. Prod. Posting Group") or not GenProdPostingGroup."Include Timbre FND" then
            exit;

        if Rec."Timbre applied FND" and (Rec."Location Code" <> xRec."Location Code") then begin
            SalesLineTimbre.RESET();
            SalesLineTimbre.SETRANGE("Document Type", Rec."Document Type");
            SalesLineTimbre.SETRANGE("Document No.", Rec."Document No.");
            SalesLineTimbre.SETRANGE(Type, SalesLineTimbre.Type::Resource);
            SalesLineTimbre.SETRANGE("No.", SalesSetup."Timbre Resource Code FND");
            if SalesLineTimbre.FINDFIRST() then begin
                SalesLineTimbre.VALIDATE("Location Code", Rec."Location Code");

                //HEI.101<<
                SalesLineTimbreApplied.RESET();
                SalesLineTimbreApplied.SETRANGE("Document Type", Rec."Document Type");
                SalesLineTimbreApplied.SETRANGE("Document No.", Rec."Document No.");
                SalesLineTimbreApplied.SETRANGE("Timbre applied FND", true);
                if SalesLineTimbreApplied.FINDFIRST() then begin
                    CLEAR(TempDimensionSetEntry);
                    DimensionManagement.GetDimensionSet(TempDimensionSetEntry, SalesLineTimbre."Dimension Set ID");
                    TempDimensionSetEntry.DELETEALL();

                    DimensionSetEntry.RESET();
                    DimensionSetEntry.SETRANGE("Dimension Set ID", SalesLineTimbreApplied."Dimension Set ID");
                    if DimensionSetEntry.FINDFIRST() then
                        repeat
                            TempDimensionSetEntry.INIT();
                            TempDimensionSetEntry."Dimension Code" := DimensionSetEntry."Dimension Code";
                            TempDimensionSetEntry."Dimension Value Code" := DimensionSetEntry."Dimension Value Code";
                            if TempDimensionSetEntry.INSERT(true) then;
                        until DimensionSetEntry.NEXT() = 0;

                    SalesLineTimbre.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                end;
                //HEI.101>>

                SalesLineTimbre.MODIFY();
            end;
        end;
        //HEI.98>>
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterValidateEvent', 'Shipment Date', false, false)]
    local procedure T37OnAfterValidate_ShipmentDate(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer);
    begin
        //HEI.116>>
        if Rec.ISTEMPORARY then
            exit;
        Rec."Freshness Date (min) FND" := GetFreshnessDate(Rec);
        //HEI.116<<
    end;

    procedure SetAllowTimbreDeletion(Flag: Boolean);
    begin
        //HEI.99
        AllowTimbreDeletion := Flag;
    end;

    procedure CheckCustLimitBeforeReleaseSO(SalesHeader: Record "Sales Header");
    var
        Customer: Record Customer;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        AppliesToDocNoMandatoryErr: Label 'Payment Application is mandatory. Applies-to Doc. No. cannot be empty.';
    begin
        //HEI.100>>
        SalesReceivablesSetup.GET();

        if SalesHeader.ISTEMPORARY then
            exit;

        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then
            exit;

        if not SalesReceivablesSetup."SO Mandatory For Cash Cust FND" or
           (SalesReceivablesSetup."Ref Value for Cash Cust. FND" = 0)
        then
            exit;

        if Customer.GET(SalesHeader."Bill-to Customer No.") then
            if CalcAmtWithoutDeposits(SalesHeader) > 0 then
                if Customer."Credit Limit (LCY)" < SalesReceivablesSetup."Ref Value for Cash Cust. FND" then begin
                    if (SalesHeader."Applies-to Doc. Type" = SalesHeader."Applies-to Doc. Type"::" ") or
                       (SalesHeader."Applies-to Doc. No." = '')
                    then
                        ERROR(AppliesToDocNoMandatoryErr);
                end;
        //HEI.100<<
    end;

    local procedure CalcAmtWithoutDeposits(Rec: Record "Sales Header"): Decimal;
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        TempSalesLine: Record "Sales Line" temporary;
        TotalSalesLine: array[3] of Record "Sales Line";
        TotalSalesLineCharge: array[3, 6] of Record "Sales Line";
        TotalSalesLineChargeLCY: array[3, 6] of Record "Sales Line";
        TotalSalesLineLCY: array[3] of Record "Sales Line";
        TempVATAmountLine1: Record "VAT Amount Line" temporary;
        TempVATAmountLine2: Record "VAT Amount Line" temporary;
        TempVATAmountLine3: Record "VAT Amount Line" temporary;
        TempVATAmountLineCharge1: Record "VAT Amount Line" temporary;
        TempVATAmountLineCharge2: Record "VAT Amount Line" temporary;
        TempVATAmountLineCharge3: Record "VAT Amount Line" temporary;
        TempVATAmountLineCharge4: Record "VAT Amount Line" temporary;
        TempVATAmountLineCharge6: Record "VAT Amount Line" temporary;
        SalesPost: Codeunit "Sales-Post";
        AdjProfitLCY: array[3] of Decimal;
        AdjProfitPct: array[3] of Decimal;
        ProfitLCY: array[3] of Decimal;
        ProfitPct: array[3] of Decimal;
        TotalAdjCostLCY: array[3] of Decimal;
        TotalAmount1: array[3] of Decimal;
        TotalAmount2: array[3] of Decimal;
        TotalAmountCharge1: array[3, 6] of Decimal;
        TotalAmountCharge2: array[3, 6] of Decimal;
        VATAmount: array[3] of Decimal;
        VATAmountCharge: array[3, 6] of Decimal;
        i: Integer;
        j: Integer;
        VATAmountText: array[3] of Text[30];
        VATAmountTextCharge: array[3, 6] of Text[30];
    begin
        //HEI.100>>
        SalesHeader := Rec;
        CLEAR(SalesLine);
        CLEAR(TotalSalesLine);
        CLEAR(TotalSalesLineLCY);
        CLEAR(TotalSalesLineCharge);
        CLEAR(TotalSalesLineChargeLCY);

        for i := 1 to 3 do begin
            CLEAR(TempSalesLine);
            TempSalesLine.DELETEALL();
            CLEAR(SalesPost);
            SalesPost.GetSalesLines(Rec, TempSalesLine, i - 1);
            CLEAR(SalesPost);
            case i of
                1:
                    SalesLine.CalcVATAmountLines(0, Rec, TempSalesLine, TempVATAmountLine1);
                2:
                    SalesLine.CalcVATAmountLines(0, Rec, TempSalesLine, TempVATAmountLine2);
                3:
                    SalesLine.CalcVATAmountLines(0, Rec, TempSalesLine, TempVATAmountLine3);
            end;

            SalesPost.SumSalesLinesTemp(
              Rec, TempSalesLine, i - 1, TotalSalesLine[i], TotalSalesLineLCY[i],
              VATAmount[i], VATAmountText[i], ProfitLCY[i], ProfitPct[i], TotalAdjCostLCY[i]);

            // with SalesLine do
            //     for "Item Charge Type" := "Item Charge Type"::Tax to "Item Charge Type"::ShippingCost do begin
            //         SalesHeader.SETRANGE("Item Charge Type Filter", "Item Charge Type");
            //         TempSalesLine.RESET;
            //         TempSalesLine.SETRANGE("Item Charge Type", "Item Charge Type");
            //         if i = 1 then begin
            //             case "Item Charge Type" of
            //                 "Item Charge Type"::Tax:
            //                     SalesLine.CalcChargeVATAmountLines(SalesHeader, TempSalesLine, TempVATAmountLineCharge1);
            //                 "Item Charge Type"::Deposit:
            //                     SalesLine.CalcChargeVATAmountLines(SalesHeader, TempSalesLine, TempVATAmountLineCharge2);
            //                 "Item Charge Type"::Discount:
            //                     SalesLine.CalcChargeVATAmountLines(SalesHeader, TempSalesLine, TempVATAmountLineCharge3);
            //                 "Item Charge Type"::Promotion:
            //                     SalesLine.CalcChargeVATAmountLines(SalesHeader, TempSalesLine, TempVATAmountLineCharge4);
            //                 "Item Charge Type"::ShippingCost:
            //                     SalesLine.CalcChargeVATAmountLines(SalesHeader, TempSalesLine, TempVATAmountLineCharge6);
            //             end;
            //         end;
            //         EVALUATE(j, FORMAT("Item Charge Type", 0, 2));
            //         CLEAR(SalesPost);
            //         SalesPost.SumChargeSalesLinesTemp(
            //           SalesHeader, TempSalesLine, i - 1, TotalSalesLineCharge[i, j], TotalSalesLineChargeLCY[i, j],
            //           VATAmountCharge[i, j], VATAmountTextCharge[i, j]);

            //         if Rec."Prices Including VAT" then begin
            //             TotalAmountCharge2[i, j] := TotalSalesLineCharge[i, j].Amount;
            //             TotalAmountCharge1[i, j] := TotalAmountCharge2[i, j] + VATAmountCharge[i, j];
            //             TotalSalesLineCharge[i, j]."Line Amount" := TotalAmountCharge1[i, j] + TotalSalesLineCharge[i, j]."Inv. Discount Amount";
            //         end else begin
            //             TotalAmountCharge1[i, j] := TotalSalesLineCharge[i, j].Amount;
            //             TotalAmountCharge2[i, j] := TotalSalesLineCharge[i, j]."Amount Including VAT";
            //         end;
            //     end;

            // CLEAR(TempSalesLine);
            // CLEAR(SalesLine);  // BC Upgrade NANDIS03 - Blocked whole for loop  as dependency on DIT

            if i = 3 then
                TotalAdjCostLCY[i] := TotalSalesLineLCY[i]."Unit Cost (LCY)";

            AdjProfitLCY[i] := TotalSalesLineLCY[i].Amount - TotalAdjCostLCY[i];
            if TotalSalesLineLCY[i].Amount <> 0 then
                AdjProfitPct[i] := ROUND(AdjProfitLCY[i] / TotalSalesLineLCY[i].Amount * 100, 0.1);

            if Rec."Prices Including VAT" then begin
                TotalAmount2[i] := TotalSalesLine[i].Amount;
                TotalAmount1[i] := TotalAmount2[i] + VATAmount[i];
                TotalSalesLine[i]."Line Amount" := TotalAmount1[i] + TotalSalesLine[i]."Inv. Discount Amount";
            end else begin
                TotalAmount1[i] := TotalSalesLine[i].Amount;
                TotalAmount2[i] := TotalSalesLine[i]."Amount Including VAT";
            end;
        end;
        exit(TotalSalesLine[1]."Line Amount" - TotalSalesLineCharge[1, 2]."Line Amount");
        //HEI.100<<
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterInsertEvent', '', false, false)]
    local procedure CCCDimforT37OnInsert(var Rec: Record "Sales Line"; RunTrigger: Boolean);
    var
        lDimSetEntry: Record "Dimension Set Entry";
        lDimSetEntry2: Record "Dimension Set Entry";
        lDimVal: Record "Dimension Value";
        lGLSetUp: Record "General Ledger Setup";
        lSKU: Record "Stockkeeping Unit";
    begin
        //HEI.103>>
        if Rec.ISTEMPORARY then
            exit;
        if (Rec."Document Type" = Rec."Document Type"::Order) or (Rec."Document Type" = Rec."Document Type"::"Return Order") or (Rec."Document Type" = Rec."Document Type"::Quote) or (Rec."Document Type" = Rec."Document Type"::Invoice) then begin
            lGLSetUp.GET();
            lSKU.RESET();
            lSKU.SETRANGE("Item No.", Rec."No.");
            lSKU.SETRANGE("Location Code", Rec."Location Code");
            if lSKU.FINDFIRST() then
                CCCfromSKU := lSKU."CCC Dim. Code FND";

            lDimVal.RESET();
            lDimVal.SETRANGE("Dimension Code", lGLSetUp."Shortcut Dimension 2 Code");
            lDimVal.SETRANGE(Code, CCCfromSKU);
            if lDimVal.FINDFIRST() then
                DimValID := lDimVal."Dimension Value ID";
            lDimSetEntry.RESET();
            lDimSetEntry.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
            lDimSetEntry.SETRANGE("Dimension Code", lGLSetUp."Global Dimension 2 Code");
            if not lDimSetEntry.FINDFIRST() then begin
                Rec.VALIDATE("Dimension Set ID", fGetDimSetId(Rec));
                Rec.MODIFY();
            end;
        end;
        //HEI.103<<
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterModifyEvent', '', false, false)]
    local procedure CCCDimforT37OnModify(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; RunTrigger: Boolean);
    var
        lDimSetEntry: Record "Dimension Set Entry";
        lDimSetEntry2: Record "Dimension Set Entry";
        lDimVal: Record "Dimension Value";
        lGLSetUp: Record "General Ledger Setup";
        lSKU: Record "Stockkeeping Unit";
    begin
        //HEI.103>>
        if Rec.ISTEMPORARY then
            exit;
        if (Rec."Location Code" <> '') and (Rec."Location Code" <> xRec."Location Code") then begin
            if (Rec."Document Type" = Rec."Document Type"::Order) or (Rec."Document Type" = Rec."Document Type"::"Return Order") or (Rec."Document Type" = Rec."Document Type"::Quote) or (Rec."Document Type" = Rec."Document Type"::Invoice) then begin
                lGLSetUp.GET();
                lSKU.RESET();
                lSKU.SETRANGE("Item No.", Rec."No.");
                lSKU.SETRANGE("Location Code", Rec."Location Code");
                if lSKU.FINDFIRST() then
                    CCCfromSKU := lSKU."CCC Dim. Code FND";
                if CCCfromSKU <> '' then begin
                    lDimVal.RESET();
                    lDimVal.SETRANGE("Dimension Code", lGLSetUp."Shortcut Dimension 2 Code");
                    lDimVal.SETRANGE(Code, CCCfromSKU);
                    if lDimVal.FINDFIRST() then
                        DimValID := lDimVal."Dimension Value ID";
                    lDimSetEntry.RESET();
                    lDimSetEntry.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
                    lDimSetEntry.SETRANGE("Dimension Code", lGLSetUp."Global Dimension 2 Code");
                    if not lDimSetEntry.FINDFIRST() then begin
                        Rec.VALIDATE("Dimension Set ID", fGetDimSetId(Rec));
                        Rec.MODIFY();
                    end
                    else begin
                        Rec.VALIDATE("Dimension Set ID", fGetDimSetId2(Rec));
                        Rec.MODIFY();
                    end;
                end;
            end;
        end;

        if (Rec."No." <> '') and (Rec."No." <> xRec."No.") then begin
            if (Rec."Document Type" = Rec."Document Type"::Order) or (Rec."Document Type" = Rec."Document Type"::"Return Order") or (Rec."Document Type" = Rec."Document Type"::Quote) or (Rec."Document Type" = Rec."Document Type"::Invoice) then begin
                lGLSetUp.GET();
                lSKU.RESET();
                lSKU.SETRANGE("Item No.", Rec."No.");
                lSKU.SETRANGE("Location Code", Rec."Location Code");
                if lSKU.FINDFIRST() then
                    CCCfromSKU := lSKU."CCC Dim. Code FND";
                if CCCfromSKU <> '' then begin
                    lDimVal.RESET();
                    lDimVal.SETRANGE("Dimension Code", lGLSetUp."Shortcut Dimension 2 Code");
                    lDimVal.SETRANGE(Code, CCCfromSKU);
                    if lDimVal.FINDFIRST() then
                        DimValID := lDimVal."Dimension Value ID";
                    lDimSetEntry.RESET();
                    lDimSetEntry.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
                    lDimSetEntry.SETRANGE("Dimension Code", lGLSetUp."Global Dimension 2 Code");
                    if not lDimSetEntry.FINDFIRST() then begin
                        Rec.VALIDATE("Dimension Set ID", fGetDimSetId(Rec));
                        Rec.MODIFY();
                    end
                    else begin
                        Rec.VALIDATE("Dimension Set ID", fGetDimSetId2(Rec));
                        Rec.MODIFY();
                    end;
                end;
            end;
        end;
        //HEI.103<<
    end;

    local procedure fGetDimSetId(SalesLine: Record "Sales Line"): Integer;
    var
        DefaultDimension: Record "Default Dimension";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        TempDimensionSetEntry2: Record "Dimension Set Entry" temporary;
        DimensionValue: Record "Dimension Value";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionManagement: Codeunit DimensionManagement;
        dimsetid: Integer;
        dimsetid1: Integer;
    begin
        //HEI.103>>
        GeneralLedgerSetup.GET();
        TempDimensionSetEntry.DELETEALL();
        DimensionManagement.GetDimensionSet(TempDimensionSetEntry, SalesLine."Dimension Set ID");
        //TempDimensionSetEntry.DELETEALL;
        //dimsetid := DimensionManagement.GetDimensionSetID(TempDimensionSetEntry);
        //DimensionManagement.GetDimensionSet(TempDimensionSetEntry2,dimsetid);
        //TempDimensionSetEntry2.RESET;
        TempDimensionSetEntry."Dimension Code" := GeneralLedgerSetup."Shortcut Dimension 2 Code";
        TempDimensionSetEntry."Dimension Value Code" := CCCfromSKU;
        TempDimensionSetEntry."Dimension Value ID" := DimValID;
        TempDimensionSetEntry.INSERT();
        dimsetid := 0;
        dimsetid := DimensionManagement.GetDimensionSetID(TempDimensionSetEntry);
        exit(dimsetid);
        //HEI.103<<
    end;

    local procedure fGetDimSetId2(SalesLine: Record "Sales Line"): Integer;
    var
        DefaultDimension: Record "Default Dimension";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        TempDimensionSetEntry2: Record "Dimension Set Entry" temporary;
        DimensionValue: Record "Dimension Value";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionManagement: Codeunit DimensionManagement;
        dimsetid: Integer;
        dimsetid1: Integer;
    begin
        //HEI.103>>
        GeneralLedgerSetup.GET();
        TempDimensionSetEntry.DELETEALL();
        DimensionManagement.GetDimensionSet(TempDimensionSetEntry, SalesLine."Dimension Set ID");
        //TempDimensionSetEntry.DELETEALL;
        //dimsetid := DimensionManagement.GetDimensionSetID(TempDimensionSetEntry);
        //DimensionManagement.GetDimensionSet(TempDimensionSetEntry2,dimsetid);
        //TempDimensionSetEntry2.RESET;
        TempDimensionSetEntry.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        if TempDimensionSetEntry.FINDFIRST() then begin
            TempDimensionSetEntry."Dimension Value Code" := CCCfromSKU;
            TempDimensionSetEntry."Dimension Value ID" := DimValID;
            TempDimensionSetEntry.MODIFY();
            dimsetid := 0;
            dimsetid := DimensionManagement.GetDimensionSetID(TempDimensionSetEntry);
        end;
        exit(dimsetid);
        //HEI.103<<
    end;

    // [EventSubscriber(ObjectType::Table, 472, 'OnAfterModifyEvent', '', false, false)]
    // local procedure OnAfterModifyJobQueueEntry(var Rec: Record "Job Queue Entry"; var xRec: Record "Job Queue Entry"; RunTrigger: Boolean);
    // var
    //     WarehouseSetup: Record "Warehouse Setup";
    // begin
    //     //HEI.110>>
    //     GetGeneralInterfaceSetup;
    //     WarehouseSetup.GET;
    //     if (Rec."Job Queue Category Code" = WarehouseSetup."C2S COGS Job Queue Cat Code") and
    //        (GeneralInterfaceSetup."Interface Job Queue User ID" <> '')
    //     then
    //         Rec."User ID" := GeneralInterfaceSetup."Interface Job Queue User ID";
    //     //HEI.110<<
    // end;  // BC Upgrade NANDIS03 - Function moved to Interface extension

    // [EventSubscriber(ObjectType::Table, 2000000175, 'OnBeforeInsertEvent', '', false, false)]
    // local procedure OnBeforeInsertScheduledTask_RTR(var Rec: Record "Scheduled Task"; RunTrigger: Boolean);
    // var
    //     WarehouseSetup: Record "Warehouse Setup";
    //     RecRef: RecordRef;
    //     JobQueueEntry: Record "Job Queue Entry";
    //     User: Record User;
    // begin
    //     //HEI.111>>
    //     GetGeneralInterfaceSetup;
    //     WarehouseSetup.GET;
    //     RecRef.GET(Rec.Record);
    //     if RecRef.NUMBER = DATABASE::"Job Queue Entry" then begin
    //         RecRef.SETRECFILTER;
    //         JobQueueEntry.SETVIEW(RecRef.GETVIEW);
    //         if JobQueueEntry.FINDFIRST then
    //             if (JobQueueEntry."Job Queue Category Code" = WarehouseSetup."C2S COGS Job Queue Cat Code") and
    //                (GeneralInterfaceSetup."Interface Job Queue Category" <> '')
    //             then begin
    //                 User.SETRANGE("User Name", GeneralInterfaceSetup."Interface Job Queue User ID");
    //                 if User.FINDFIRST then begin
    //                     Rec."User ID" := User."User Security ID";
    //                     Rec."User Name" := User."User Name";
    //                 end;
    //             end;
    //     end;
    //     //HEI.111<<
    // end;  // BC Upgrade NANDIS03 - Function moved to Interface extension

    local procedure GetFreshnessDate(var SalesLine: Record "Sales Line"): Date;
    var
        Customer: Record Customer;
        Item: Record Item;
        EmptyDateFormula: DateFormula;
        NoOfDays: Integer;
    begin
        //HEI.116>>
        if SalesLine.Type <> SalesLine.Type::Item then
            exit(0D);
        if SalesLine."No." = '' then
            exit(0D);
        if SalesLine."Shipment Date" = 0D then
            exit(0D);
        if not Customer.GET(SalesLine."Sell-to Customer No.") then
            exit(0D);
        if Customer."Required Freshness FND" = 0 then
            exit(0D);
        Item.GET(SalesLine."No.");
        if Item."Expiration Calculation" = EmptyDateFormula then
            exit(0D);

        NoOfDays := CALCDATE(Item."Expiration Calculation", SalesLine."Shipment Date") - SalesLine."Shipment Date";
        NoOfDays := ROUND(Customer."Required Freshness FND" * NoOfDays / 100, 1);
        exit(CALCDATE(STRSUBSTNO('<%1D>', NoOfDays), SalesLine."Shipment Date"));
        //HEI.116<<
    end;

    [EventSubscriber(ObjectType::Table, 246, 'OnAfterModifyEvent', '', false, false)]
    local procedure T246UpdateOnBlanketOrderNo(var Rec: Record "Requisition Line"; var xRec: Record "Requisition Line"; RunTrigger: Boolean);
    var
        lPurchHeader: Record "Purchase Header";
        lPurchLine: Record "Purchase Line";
        lPurchPrice: Record "Purchase Line Price FND";
    begin
        //HEI.107>>
        //HEI.105>>
        // IF Rec.ISTEMPORARY THEN
        //  EXIT;
        //
        // IF (Rec."Blanket Order No." <> '') AND (Rec."Blanket Order No." <> xRec."Blanket Order No.") THEN BEGIN
        // IF lPurchHeader.GET(lPurchHeader."Document Type"::"Blanket Order",Rec."Blanket Order No.") THEN BEGIN
        //   Rec."Currency Code" := lPurchHeader."Currency Code";
        //   Rec.MODIFY;
        // end
        // end;
        //
        // IF (Rec."Blanket Order Line No." <> 0) AND (Rec."Blanket Order Line No." <> xRec."Blanket Order Line No.") THEN BEGIN
        //  IF lPurchLine.GET(lPurchLine."Document Type"::"Blanket Order",Rec."Blanket Order No.",Rec."Blanket Order Line No.") THEN BEGIN
        //    Rec."Unit of Measure Code" := lPurchLine."Unit of Measure Code";
        //    Rec.MODIFY;
        //  end;
        //  lPurchPrice.RESET;
        //  lPurchPrice.SETRANGE(lPurchPrice."Document Type",lPurchPrice."Document Type"::"Blanket Order");
        //  lPurchPrice.SETRANGE("Document No.",Rec."Blanket Order No.");
        //  lPurchPrice.SETRANGE("Document Line No.",Rec."Blanket Order Line No.");
        //  lPurchPrice.SETRANGE("Location Code",Rec."Location Code");
        //  lPurchPrice.SETFILTER("Starting Date",'>=%1',Rec."Order Date");
        //  lPurchPrice.SETFILTER("Ending Date",'<=%1',Rec."Order Date");
        //  lPurchPrice.SETFILTER("Minimum Quantity",'>=%1',Rec.Quantity);
        //  IF lPurchPrice.FINDFIRST THEN BEGIN
        //    Rec."Direct Unit Cost" := lPurchPrice."Direct Unit Cost";
        //    Rec.MODIFY
        //  end;
        // end;
        // //HEI.105<<
        //HEI.107<<
    end;

    local procedure CheckUoMOfContracttoItemBaseUoM(p_PurchLn: Record "Purchase Line"): Boolean;
    var
        lrec_Item: Record Item;
    begin
        //HEI.107>>
        if lrec_Item.GET(p_PurchLn."No.") then begin
            if (lrec_Item."Base Unit of Measure" <> p_PurchLn."Unit of Measure Code") then
                exit(false);
        end;
        exit(true);
        //HEI.107<<
    end;

    local procedure UpdatePricefromBlanketOrder(var prec_ReqLn: Record "Requisition Line");
    var
        lrecItem: Record Item;
        lPurchPrice: Record "Purchase Line Price FND";
    begin
        //HEI.107>>
        lPurchPrice.RESET();
        lPurchPrice.SETRANGE(lPurchPrice."Document Type", lPurchPrice."Document Type"::"Blanket Order");
        // lPurchPrice.SETRANGE("Document No.", prec_ReqLn."Blanket Order No.");  // BC Upgrade NANDIS03 - Blocked due to DIT field
        // lPurchPrice.SETRANGE("Document Line No.", prec_ReqLn."Blanket Order Line No.");  // BC Upgrade NANDIS03 - Blocked due to DIT field
        lPurchPrice.SETFILTER("Location Code", '%1|%2', prec_ReqLn."Location Code", '');
        lPurchPrice.SETFILTER("Starting Date", '..%1', prec_ReqLn."Order Date");
        lPurchPrice.SETFILTER("Ending Date", '%1|>=%2', 0D, prec_ReqLn."Order Date");
        lPurchPrice.SETRANGE("Currency Code", prec_ReqLn."Currency Code");
        lPurchPrice.SETFILTER("Minimum Quantity", '<=%1', prec_ReqLn.Quantity);
        lPurchPrice.SETFILTER("Unit of Measure Code", '%1|%2', prec_ReqLn."Unit of Measure Code", '');
        if lPurchPrice.FINDFIRST() then begin
            prec_ReqLn."Direct Unit Cost" := lPurchPrice."Direct Unit Cost";
        end else begin
            if lrecItem.GET(prec_ReqLn."No.") then begin
                prec_ReqLn."Direct Unit Cost" := lrecItem."Last Direct Cost";
            end;
        end;
        //HEI.107<<
    end;

    [EventSubscriber(ObjectType::Table, 15, 'OnAfterValidateEvent', 'HeiMatch Code FND', false, false)]
    local procedure T15OnAfterValidateHeiMatchCode(var Rec: Record "G/L Account"; var xRec: Record "G/L Account"; CurrFieldNo: Integer);
    begin
        //HEI.109<<
        if Rec."HeiMatch Code FND" = '' then begin
            Rec."Heimatch Sign FND" := Rec."Heimatch Sign FND"::" ";
            Rec.MODIFY();
        end;
        //HEI.109>>
    end;

    // [EventSubscriber(ObjectType::Codeunit, 414, 'OnBeforeReopenSalesDoc', '', false, false)]
    // local procedure CU414OnBeforeReopenSalesDoc(var SalesHeader : Record "Sales Header");
    // var
    //     B2BInterfaceSetup : Record "B2B Interface Setup INT";
    //     ReopenErr : Label 'You are not allowed to reopen a Sales Quote created from B2B interface.';
    // begin
    //     //HEI.118>>
    //     if (SalesHeader."Document Type" = SalesHeader."Document Type"::Quote) then begin
    //       if GUIALLOWED then begin //allow to reopen quote from Job "Delete B2B Sales Quote"
    //         B2BInterfaceSetup.GET;
    //         if (B2BInterfaceSetup."Default Souce System Ident." <> '')  and (B2BInterfaceSetup."Default Souce System Ident." = SalesHeader."Source System Identifier") then
    //           ERROR(ReopenErr);
    //       end;
    //     end;
    //     //HEI.118<<
    // end;  // BC Upgrade NANDIS03 - Moved to InterfaceFramework extemsion

    // [EventSubscriber(ObjectType::Codeunit, 5815, 'OnAfterUndoSalesShipmentLine', '', false, false)]
    // BC Upgrade PATELS08 >>
    //  HEI.127 - Codeunit::"Undo Sales Shipment Line" 5815 - Event 'OnAfterUndoSalesShipmentLine' - Custom Event - does not exists
    // BC Upgrade PATELS08 <<
    // local procedure CU5815OnAfterUndoSalesShipmentLine(var precSalesShipmentLine: Record "Sales Shipment Line");
    // var
    //     SalesShipmentHeader: Record "Sales Shipment Header";
    //     GateEntryHeader: Record "Gate Entry Header";
    // begin
    //     //HEI.125>>
    //     GetSalesSetup;
    //     if SalesSetup."Gate Entry Archived Required" then begin
    //         if SalesShipmentHeader.GET(precSalesShipmentLine."Document No.") then begin
    //             if GateEntryHeader.GET(SalesShipmentHeader."Gate Entry No.") then begin
    //                 GateEntryHeader.Blocked := true;
    //                 GateEntryHeader.MODIFY;

    //                 SalesShipmentHeader."Gate Entry Archived" := true;
    //                 SalesShipmentHeader.MODIFY;
    //             end;
    //         end;
    //     end;
    //     //HEI.125<<
    // end;  // BC Upgrade NANDIS03 - function to be moved to MtC

    local procedure GetSalesSetup();
    begin
        //HEI.123>>
        if not SalesSetupRead then
            if SalesSetup.GET() then;

        SalesSetupRead := true;
        //HEI.123<<
    end;

    //BC UPGRADE SIVA >>
    //1.WhseShpmtIsTransferImportIdentifier Procedure for use in Codeunit::"Whse.-Shipment Release", Event Subscriber OnBeforeRelease
    //in Codeunit "Heineken BC Upgrade"   
    PROCEDURE WhseShpmtIsTransferImportIdentifier(DocNo: Code[20]): Boolean;
    VAR
        WarehouseShipmentLine: Record 7321;
        TransferHeader: Record 5740;
    BEGIN
        //HEI.127>>
        WarehouseShipmentLine.SETRANGE("No.", DocNo);
        WarehouseShipmentLine.SETRANGE("Source Document", WarehouseShipmentLine."Source Document"::"Outbound Transfer");
        IF WarehouseShipmentLine.FINDSET(FALSE) THEN
            REPEAT
                IF TransferHeader.GET(WarehouseShipmentLine."Source No.") THEN BEGIN
                    TransferHeader.CALCFIELDS("Import Identifier FND");
                    IF TransferHeader."Import Identifier FND" THEN
                        EXIT(TRUE);
                END;
            UNTIL WarehouseShipmentLine.NEXT() = 0;

        EXIT(FALSE);
        //HEI.127<<
    END;
    //BC UPGRADE SIVA<<

    // BC UPGRADE PATELS08 >> Added Procedure 'WhseRcptIsTransferImportIdentifier' 
    // HEI.127 >>
    PROCEDURE WhseRcptIsTransferImportIdentifier(DocNo: Code[20]): Boolean;
    VAR
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        TransferHeader: Record "Transfer Header";
    begin
        WarehouseReceiptLine.SETRANGE("No.", DocNo);
        WarehouseReceiptLine.SETRANGE("Source Document", WarehouseReceiptLine."Source Document"::"Inbound Transfer");
        IF WarehouseReceiptLine.FINDSET(FALSE) THEN
            REPEAT
                IF TransferHeader.GET(WarehouseReceiptLine."Source No.") THEN BEGIN
                    TransferHeader.CALCFIELDS("Import Identifier FND");
                    IF TransferHeader."Import Identifier FND" THEN
                        EXIT(TRUE);
                END;
            UNTIL WarehouseReceiptLine.NEXT() = 0;
        EXIT(FALSE);
    end;
    // HEI.127 <<
    // BC UPGRADE PATELS08 <<

    //BC UPGRDE SIVA  Codeunit 17_Gen. Jnl.-Post Reverse >>
    //1. Created new procedure SetRevesalEntry for Set Revesal entry no dynamically while event is hit by process and help of single insatnce  codeunit due to Codeunit 17 "Gen. Jnl.-Post Reverse not suppoted events to get 
    //revesal entry no 
    //2. GetReverseEntryNo Procedure helps to Update posting Date in  Codeunit 17 "Gen. Jnl.-Post Reverse" ReverseCustLedgEntry, ReversevendLedgEntry, ReverseBankLedEntry    
    //BC UPGRADE SIVA >>  
    procedure SetReverseEntryNo(EntryNo: Integer)
    begin
        ReversalEntryNo := EntryNo;
    end;

    procedure GetReverseEntryNo(): Integer
    begin
        exit(ReversalEntryNo);

    end;
    //BC UPGRADE SIVA  Codeunit 17_Gen. Jnl.-Post Reverse <<

    // BC Upgrade BHARDA11 >> 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforePurchRcptLineInsert, '', false, false)]
    local procedure OnBeforePurchRcptLineInsert(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchLine: Record "Purchase Line"; CommitIsSupressed: Boolean; PostedWhseRcptLine: Record "Posted Whse. Receipt Line"; var IsHandled: Boolean; ItemLedgShptEntryNo: Integer)
    begin
        PurchRcptLine."Amount Heilite FND" := PurchRcptLine.Quantity * PurchRcptLine."Unit Cost";
        PurchRcptLine."Amount LCY Heilite FND" := PurchRcptLine.Quantity * PurchRcptLine."Unit Cost (LCY)";
    end;
    // BC Upgrade BHARDA11 << 
    // BC Upgrade BHARDA11 >> ---Undo Amount Negative 20April2026
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", OnBeforeNewPurchRcptLineInsert, '', false, false)]
    local procedure OnBeforeNewPurchRcptLineInsert(var NewPurchRcptLine: Record "Purch. Rcpt. Line"; OldPurchRcptLine: Record "Purch. Rcpt. Line")
    begin
        NewPurchRcptLine."Amount Heilite FND" := -OldPurchRcptLine."Amount Heilite FND";
    end;
    // BC Upgrade BHARDA11 << ---Undo Amount Negative 20April2026
}

