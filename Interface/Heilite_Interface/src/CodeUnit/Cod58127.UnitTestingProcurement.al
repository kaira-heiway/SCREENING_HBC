codeunit 58127 "Unit Testing - Procurement"
{

    // HEI.01 RITM2738652 IBM NANDIS01 13.07.2021 # StP Automation Test Script
    //   # New function- PTP010_ProcessPOInvoice created for PTP010 process
    //   # New function- PCN027_CreateCalloff created for PCN027 process
    //   # New function- PTP012_ProcessNPOInvoice created for PTP012 process
    //   # New function- PTP016_ApproveCreditNote created for PTP016 process***** Out of scope
    //   # New function- PTP011_ProcessPOCreditMemo created for PTP011 process
    // HEI.02 RITM2738652 IBM SHIVAS05 26.07.2021 # StP Automation Test Script
    //   # New PCN023_CreatePurchaseOrder function created for PCN023 process as per excel sheet of STP
    //   # New PTP087_CreateNPOPrepayment function created for PTP087 process as per excel sheet of STP
    //   # New PTP015_CreateNPOCreditNote function created for PTP018 process as per excel sheet of STP
    //   # New PTP018_CreatePOInvoice function created for PTP018 process as per excel sheet of STP
    // HEI.03 RITM2738652 IBM BHATTA09 26.07.2021 # StP Automation Test Script
    //   # New SC10_LOG026_Create&ReleaseWarehouseReceipt function created
    //   # New SC10_LOG026_Create&ReleaseWarehouseReceipt function created
    //   # SC10_PCN024_ReleasePO
    //   # SC10_PTP013_ApprovePurchaseInvoice
    //   # SC12_PTP061-CreatePaymentProposal
    //   # SC12_PTP067_Review&SendPaymentProposal
    //   # SC12_PTP069_ApprovePaymentProposalL1
    //   # SC10_PTP084_ProcessManualPayment
    //   # SC12_PTP071_ApprovePaymentProposalL2
    // HEI.04 RITM2738652 IBM SHANKJ03 26.07.2021 # StP Automation Test Script
    //   # New PTP073_ExecutePaymentBankConnectivity function Created
    // HEI.05 RITM2738652 IBM GUNERE01 26.07.2021 # StP Automation Test Script
    //   # New function PCN003_CreateCallOffFromBlanketOrder created
    // HEI.06 RITM2738652 IBM.PANDES01 13/10/2021 # StP Automation Test Script
    //  # PCN017-Create Purchase Quote IBM.PANDES01
    //  # PCN018-Approve Purchase Quote  IBM.PANDES01
    //  # PCN019-Create Purchase Order from Purchase Quote IBM.PANDES01
    //  # PCN020-Update Purchase Quote IBM.PANDES01
    //  # PCN021-Reject Purchase Quote IBM.PANDES01
    //  # PCN026 Sent PO to Approval   IBM.PANDES01
    //  # PCN028 Approve Purchase Order IBM.PANDES01
    //  HEI.07 RITM2738652 IBM SHIVAS05 01.12.2021 # StP Automation Test Script
    //   # New PCN001_ValidateContractHeader function created for PCN001 process
    //   # New PCN002_ValidateContractItems function created for PCN002 process
    //   # New PTP062-CreatePaymentProposal function created for PTP062 process
    //   # New PCN004-PurchaseOrder_SendtoSupplier function created for PCN004 process
    //   # New PTP154-ApproveInvoice_noworkflow function created for PTP154 process
    //   # New PTP157-RejectCreditNote_noworkflow function created for PCN157 process
    //   # New PRD107-GoodsReceipt function created for PRD107 process
    //   # New PTP102-Clearing_of_open_items_on_vendor_accounts function created for PRD102 process
    // 
    // HEI.09 RITM2738652 IBM NANDIS01 06.12.2021 # StP Automation Test Script
    //   # Modified PTP012_ProcessNPOInvoice - Added Approval part for NPO Invoice
    // HEI.10 RITM2738652 IBM SHIVAS05 13.12.2021 # StP Automation Test Script
    //   # New PTP133_Reverse_Rejected_CN function created for PTP133 process
    // HEI.12 RITM2738652 IBM nandis01 16.12.2021 # StP Automation Test Script
    //   # Fix in Script - SC10_PTP010_ProcessPOInvoice and SC10_LOG026_Create&ReleaseWarehouseReceipt
    // HEI.14 RITM2738652 IBM SHIVAS05 22.12.2021 # StP Automation Test Script
    //   # Added 'RT_' in all regression test script function name
    // HEI.15 RITM2738652 IBM NANDIS01 03.01.2022 # StP Automation Test Script
    //   # New function - PCN008_CancelPurchaseOrder
    //   # New function - PCN009_CreateReturnorderfromBlanketOrder
    //   # New function - PCN006_UpdateSpotPOorVLcalloff
    //   # New function - PCN025_UpdatePxQreturncalloff
    //   # New function - PTP024_NPO_InvoiceReversal_Correction
    // HEI.16 RITM2738652 IBM.PANDES01 13/12/2021 # StP Automation Test Script
    //   # PTP055-Negative testing - NPO Invoice
    //   # PCN014 Display Purchase Order
    //   # PTP040 Obsolete invoice
    //   # PTP074 Execute Payment
    // HEI.17 RITM2738652 IBM SHIVAS05 17.01.2022 # StP Automation Test Script
    //   # New PTP155-RejectInvoice_noworkflow function created for PTP155 process
    //   # New PTP156-ApproveCreditNote_noworkflow function created for PCN156 process
    // HEI.18 RITM2738652 IBM SHIVAS05 19.01.2022 # StP Automation Test Script
    //   # New PTP132-ReverseRejectedInvoice function created for PTP132 process
    // HEI.19 RITM2738652 IBM SHIVAS05 27.01.2022 # StP Automation Test Script
    //   # Modified RT_PTP011_ProcessPOCreditMemo - Added shipment bin code
    //   # Modified RT_PTP012_ProcessNPOInvoice - Added CCC Dimension code
    //   # Modified RT_PCN023_CreatePurchaseOrder - Finding EBF warning handler
    //   # Modified RT_PTP018_CreatePOInvoice - Putting VAT Prod. Posting Group"='NO_VAT'
    //                        if vendor is foreign and PurchLines "CAD Amount"<>0
    //   # Modified RT_PCN003_CreateCallOffFromBlanketOrder Adjust Unit testing data AND SCRIPT and adding Import PO validation
    //                        and removing Qty to Receive from extra PO line.
    //   # Modified RT_PCN027_CreateCalloff Removing Dimesion adding one filter for puchase line, adding one consumption location validation
    //                       and removing Qty to Receive from extra PO line
    // HEI.21 RITM2738652 IBM SHIVAS05 17.02.2022 # StP Automation Test Script
    //   # Modified RT_PTP010_ProcessPOInvoice - Rounding "Doc. Amount Incl. VAT" when Inv rounding Precision is 1 and currency is blank
    // HEI.20 RITM2738652 IBM SHIVAS05 16.02.2022 # StP Automation Test Script
    //   # Modified PCN001_ValidateContractHeader - Using FINDLAST in plase of FINDFIRST when finding InterfaceLogHeader
    //                      Adjust Unit testing data
    //   # Modified PCN002_ValidateContractItems - Using FINDLAST in plase of FINDFIRST when finding InterfaceLogHeader
    //                     Adjust Unit testing data
    //                     Modify Error text
    //   # Modified PCN004-PurchaseOrder_SendtoSupplier- Adding error when PO Auto Send functionality is active
    //                     Adding Requester ID
    //   # Modified "PCN020-Update Purchase Quote"-Adding one filter when Reopening the purchase quote
    //   # Modified "PCN021 Reject Purchase Quote"-Adding one filter when Reopening the purchase quote
    //   # Modified "PCN026 Sent PO to Approval"-Adding Workflow enable validation
    //                      Adding Salespers./Purch. Code
    //   # Modified "PCN028 Approve Purchase Order"-Adding Salespers./Purch. Code
    //   # Modified "PTP040 Obsolete invoice"-Adjusting unit testing value,
    //                      Adding invoice comment
    //   # Modified "PTP055 Negativetesting NPO Invoice"-Putting VAT Prod. Posting Group"='NO_VAT'
    //                      if vendor is foreign and PurchLines "CAD Amount"<>0,
    //                      Added CCC Dimension code
    //   # Modified PTP133_Reverse_Rejected_CN - Added CCC and MVMT Dimension code for credit memo and invoice
    //   # Modified Apply_VLE_ModalPageHandler - Remove Payment filter and add "Remaining Amount" filter
    //   # Adding Message handler for PCN018-Approve Purchase Quote, PCN020-Update Purchase Quote, PCN021 Reject Purchase Quote,
    //   # Adding Error when Workflows is Disable for PCN018,PCN020,PCN021,PCN026,PCN028
    //   # Add QuoteConf in ConfirmationHandler function
    // HEI.22 RITM2738652 IBM MAJUMS03 04.03.2022 # StP Automation Test Script
    //   # New function - NewGetRetShipmentLineModalPageHandler
    //   # Add CRMemoQst ConfirmationHandler function
    // HEI.23 RITM2738652 IBM SHIVAS05 09.03.2022 # StP Automation Test Script
    //   # Create PTP053_ProcessNPOInvoice_paymentmethod_otherthanBank
    //   # Create PTP056_Negativetesting_PO_Invoice
    //   # Create GetReceiptLineModalPageHandlerPTP056 function
    //   # Create PTP057_Negative_NPO_CN
    //   # Create PTP082_Process_PtP_Netting
    //   # Create ApplyVendorLedModalPageHandler Function
    //   # Create PTP083_Reverse PtP Netting
    //   # Create SelectGenJnlTemplatePageHandlerPTP082 function
    //   # Create ReverseTransactionModalPageHandler
    //   # Create UnapplyEntriesModalPageHandler
    //   # Create PTP086_Reverse_Refund
    //   # Create AppliedVLEModalPageHandler
    //   # Create PTP103_Unapplying_of_cleared_items
    //   # Create PTP081_Create_Emergency_Payment_Proposal
    //   # Create PTP080_Unblock_invoice_for_payment
    //   # Create PTP079_Block_invoice_for_payment
    //   # Create PTP078_Reverse payment_Rejected_payment
    //   # Create PTP068_Review_and_Undo_Payment_Proposal
    //   # Add UnapplyVLE in ConfirmationHandler function
    // HEI.24 RITM2738652 IBM SHIVAS05 29.03.2022 # StP Automation Test Script
    //   # Putting invisible field data, through table in PCN023,PTP084,PTP015,PTP012
    // HEI.25 RITM2987058 IBM MAJUMS03 07.04.2022 # StP Automation Test Script
    //   # New Function - PTP091_Automatic_clearing_on_GR_or_IR_Account
    //   # New Function - ApplyGLEntryModalPageHandler
    //   # New Function - PTP092_Review_Consolidated_GR_or_IR_report
    //   # New Function - GRIR_ReportHandler
    //   # New Function - PTP136_Reverse_Manual_Payment
    //   # New Function - ReverseModalPageHandler
    //   # New Function - PTP058_Negative_PO_CN
    //   # New Function - NewGetRetShipmentLineModalPageHandler
    //   # ConfirmationHandler is modified
    // HEI.26 RITM2987058 IBM SHIVAS05 28.04.2022 # StP Automation Test Script
    //   # Adding MVMT dimension and Putting invisible field data, through table and alse delete Gen Jou Line if it is alredy exist For PTP136
    //   # Make "Allow Bypass WHT Validation"=true on usersetup for "PTP102-Clearing_of_open_items_on_vendor_accounts" Function
    //   # Make PurchasesPayablesSetup."Exact Cost Reversing Mandatory"=FALSE For PTP011 and PTP058
    //   # Set Dummy User email ID If it is blank for PCN004
    //   # Make WarehouseEmployee.Default=TRUE for PRD107
    //   # Putting invisible field data, through table For PTP133
    //   # Putting invisible field data, through table and closing and reopening the page For PTP018
    //   # Putting invisible field data, through table and danfle Pay to name error For PTP055
    //   # Make Auto E-mail Active=false in Purchase and payables setup for PCN004
    //   # Close Purchase Blanked order for PCN003
    //   # Close General Journal Page for PTP084,PTP091
    //   # Adding MVMT dimension for PTP091
    //   # Make "Default Nos." true if it is false for PTP087
    //   # Make PurchasesPayablesSetup."Ext. Doc. No. Mandatory" true if it is fales for PTP055 and PTP058
    //   # Make purchase and sales Gate Mandatory fale if it is true for PTP011 and PTP058
    //   # Make "Send E-Mail with Attachment" in ready stage if it not for PCN018,PCN019,PCn020,PCN021,PCN026,PCN028
    //   # Adjust filter and add ConfirmationHandler for PTP087
    // HEI.28 RITM2987058 IBM SHIVAS05 05.05.2022 # StP Automation Test Script
    //   # Closing and reopening the page before inserting data on Record Variable for PTP018
    // HEI.29 RITM2987058 IBM NANDIS01 20.05.2022 # StP Automation Test Script
    //   # Inserting Document amount value on purchase Header for PTP053
    //   # Putting invisible field data, through table For PTP053
    //   # Putting Gen. Led. setup Valid From date as Invoice posting date for PTP078
    //   # Add one more filter on PTP078
    //   # Remove one filter in PTP079 and PTP080
    //   # Putting invisible field data, through table and also delete Gen Jou Line if it is alredy exist For PTP082 and PTP083
    //   # Commenting Unapply process which is not required and removing UnapplyEntriesModalPageHandler handler function for PTP083
    //   # Fix for TS - PCN008, PCN009, PCN025, PTP024, PTP027, PTP041, PTP042
    // HEI.30 RITM2987058 IBM SHIVAS05 03.06.2022 # StP Automation Test Script
    //   # add one validation on PTP056_Negativetesting_PO_Invoice_VendorInvError function
    //   # Add one more filter in PTP018 and PTP056
    //   # Rounding Total Amount in PTP056
    //   # Putting invisible field data, through table and closing and reopening the page For PTP057
    //   # Putting some filter in VendorledEntry Table and Removing some filter in VendorledEntry page in PTP086
    // HEI.31 RITM2987058 IBM SHIVAS05 13.06.2022 # StP Automation Test Script
    //   # Fix After June RT
    // HEI.33 RITM2987058 IBM SHIVAS05 04.07.2022 # StP Automation Test Script for Phase III
    //   # CHG2123487_CMGMandatoryonHeiliteBaseSPOTPOforLandedCosts
    // HEI.34 RITM2987058 IBM NANDIS01 05.07.2022 # StP Automation Test Script for Phase II - PCN009_CreateReturnorderfromBlanketOrder
    //   # Redesign PCN009_CreateReturnorderfromBlanketOrder script by blocking the existing one
    // HEI.35 RITM2987058 IBM SHIVAS05 27.07.2022 # StP Automation Test Script
    //   # Removing one filter for PTP082 and PTP083 at the time of virtual deletion
    //     and also, virtually delete general Journal line which is already created by user for PTP084
    // HEI.36 RITM2987058 IBM SHIVAS05 02.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for Algeria Scripts
    // HEI.37 RITM2987058 IBM SHIVAS05 04.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for Boukin Scripts
    // HEI.38 RITM2987058 IBM SHIVAS05 08.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for Lubumbashi Scripts
    // HEI.39 RITM2987058 IBM SHIVAS05 09.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for Bahamas Scripts
    // HEI.40 RITM2987058 IBM SHIVAS05 11.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for Rwanda Scripts
    // HEI.41 RITM2987058 IBM SHIVAS05 16.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for Haiti Scripts
    // HEI.42 RITM2987058 IBM SHIVAS05 16.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for Lareunion Scripts
    // HEI.43 RITM2987058 IBM SHIVAS05 16.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for Congo Scripts
    // HEI.44 RITM2987058 IBM SHIVAS05 17.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for Mozambique Scripts
    // HEI.45 RITM2987058 IBM SHIVAS05 17.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for Congo Scripts
    // HEI.46 RITM2987058 IBM SHIVAS05 18.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for Lebanon Scripts
    // HEI.47 RITM2987058 IBM SHIVAS05 18.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for Speed issue for ptp018 Scripts
    // HEI.48 RITM2987058 IBM SHIVAS05 22.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for p2 Algeria
    // HEI.49 RITM2987058 IBM SHIVAS05 23.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for P2 Haiti
    // HEI.50 RITM2987058 IBM SHIVAS05 23.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for P2 Suriname
    // HEI.51 RITM2987058 IBM SHIVAS05 24.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for P2 Congo
    // HEI.52 RITM2987058 IBM SHIVAS05 24.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for P2 Boukin
    // HEI.53 RITM2987058 IBM SHIVAS05 25.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for P2 Lebanon
    // HEI.54 RITM2987058 IBM SHIVAS05 25.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for P1 Suriname
    // HEI.55 RITM2987058 IBM SHIVAS05 26.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for P2 Rwanda
    // HEI.56 RITM2987058 IBM SHIVAS05 26.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for P2 IvoryCoast
    // HEI.57 RITM2987058 IBM SHIVAS05 29.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for P2 LaReunion
    // HEI.58 RITM2987058 IBM SHIVAS05 29.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for P2 Algeria
    // HEI.59 RITM2987058 IBM SHIVAS05 30.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for P2 Panama
    // HEI.60 RITM2987058 IBM SHIVAS05 30.08.2022 # Automation StP Test Scripts
    //   # Fixes applied for P2 Lubumbashi
    // HEI.61 RITM2987058 IBM SHIVAS05 06.09.2022 # Automation StP Test Scripts
    //   # Fixes applied for P2 Lebanon
    // HEI.62 RITM3145979 IBM SAXENA03 06.09.2022
    //   # Added TS tag in Version List for Test Script related objects
    // HEI.63 RITM2987058 IBM SHIVAS05 07.09.2022 # Automation StP Test Scripts
    //   # Fixes applied for P2 Ethiopia
    // HEI.64 RITM2987058 IBM SHIVAS05 09.09.2022 # Automation StP Test Scripts
    //   # Fixes applied for P2 Kinshasa
    // HEI.65 RITM2987058 IBM SRIVAS06 15.09.2022 # Automation StP Test Scripts
    //   # Fixes applied for P1 Rwanda, Fixes applied for P1 Suriname, Fixes applied for P2 Haiti
    // HEI.66 RITM2987058 IBM NANDIS01 19.09.2022 # Automation StP Test Scripts
    //   # Fixes applied for PCN002_ValidateContractItems
    // HEI.67 RITM2987058 IBM NANDIS01 10.10.2022 # Automation StP Test Scripts
    //   # Fixes applied for PTP102-Clearing_of_open_items_on_vendor_accounts also Read and Modify permission added in codeunit
    // HEI.68 RITM2987058 IBM SRIVAS07 21.10.2022 # Automation StP Test Scripts
    //   # Fixes applied for PCN002_ValidateContractItems
    //   # Fixes applied for RT_PTP087_CreateNPOPrepayment
    // HEI.69 CHG2161266 HB3003 KOROLA04 31.10.2022
    //   #CHG2161266_RemoveReferencedTransferOrder() - function created
    //   #CHG2161266_CreateAloneTransferOrder() - function created
    //   #CHG2161266_POModalPageHandler() - function created
    // HEI.70 CHG2161266 HB3003 KOROLA04 02.11.2022
    //   #CHG2161266_RemoveReferencedTransferOrder() - fixed
    // HEI.71 RITM2987058 IBM SRIVAS07 03.11.2022 # Automation StP Test Scripts
    //   # Fixes applied for PTP082_Process_PtP_Netting
    //   # Fixes applied for PTP083_Reverse PtP Netting
    // HEI.72 CHG2161266 HB3003 KOROLA04 09.11.2022
    //   # all changes from HEI.69 temporary commented
    // HEI.73 RITM2987058 IBM SRIVAS07 02.01.2023 # Automation StP Test Scripts
    //   # Fixes applied for PCN001_ValidateContractHeader
    // HEI.74 RITM2987058 IBM SRIVAS07 05.01.2023 # Automation StP Test Scripts
    //   # Fixes applied for RT_PTP010_ProcessPOInvoice
    //   # Fixes applied for RT_PTP012_ProcessNPOInvoice
    //   # Fixes applied for RT_LOG026_Create&ReleaseWarehouseReceipt
    //   # Fixes applied for RT_PCN024_ReleasePO
    //   # Fixes applied for RT_PTP084_ProcessManualPayment
    //   # Fixes applied for RT_PCN023_CreatePurchaseOrder
    //   # Fixes applied for RT_PTP087_CreateNPOPrepayment
    //   # Fixes applied for PCN018-Approve Purchase Quote
    //   # Fixes applied for PCN019-Create Purchase Order from Purchase Quote
    //   # Fixes applied for PCN020-Update Purchase Quote
    //   # Fixes applied for PCN021 Reject Purchase Quote
    //   # Fixes applied for PCN026 Sent PO to Approval
    //   # Fixes applied for PCN028 Approve Purchase Order
    //   # Fixes applied for PCN004-PurchaseOrder_SendtoSupplier
    //   # Fixes applied for PRD107-GoodsReceipt
    //   # Fixes applied for PTP133_Reverse_Rejected_CN
    //   # Fixes applied for PTP055 Negativetesting NPO Invoice
    //   # Fixes applied for PCN008_CancelPurchaseOrder
    //   # Fixes applied for PCN006_UpdateSpotPOorVLcalloff
    //   # Fixes applied for PCN025_UpdatePxQreturncalloff
    //   # Fixes applied for PTP024_NPO_InvoiceReversal_Correction
    //   # Fixes applied for PTP132-ReverseRejectedInvoice
    //   # Fixes applied for PTP027_ProcessLargeInvoice
    //   # Fixes applied for PTP053_ProcessNPOInvoice_paymentmethod_otherthanBank
    //   # Fixes applied for PTP056_Negativetesting_PO_Invoice_DocDateError
    //   # Fixes applied for PTP082_Process_PtP_Netting
    //   # Fixes applied for PTP083_Reverse PtP Netting
    //   # Fixes applied for PTP058_Negative_PO_CN
    //   # Fixes applied for CHG2123487_CMGMandatoryonHeiliteBaseSPOTPOforLandedCosts
    // HEI.75 RITM2987058 IBM SRIVAS07 09.01.2023 # Automation StP Test Scripts
    //   # Fixes applied for RT_PCN003_CreateCallOffFromBlanketOrder
    //   # Fixes applied for PCN025_UpdatePxQreturncalloff
    // HEI.76 RITM2987058 IBM SRIVAS07 17.01.2023 # Automation StP Test Scripts
    //   # Fixes applied for PTP102-Clearing_of_open_items_on_vendor_accounts
    //   # Fixes applied for Apply_VLE_ModalPageHandler
    // HEI.77 RITM2987058 IBM SRIVAS07 30.01.2023 # Automation StP Test Scripts
    //   # CHG2098629_AutomaticCreationofTransferOrderforImportPO
    //   # WhseShipPageHandler
    //   # CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC1
    //   # CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC2
    //   # CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC3
    //   # CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC4
    //   # CHG2065545_FA_PurchaseOrder
    //   # FASplit_RequestPageHandler
    //   # FASplit_ReportHandler
    //   # FASplit_StrMenuHandler
    //   # FindFixedAsset
    // HEI.78 RITM2987058 IBM SRIVAS07 09.03.2023 # Automation StP Test Scripts
    //   # Fixes applied for RT_PTP010_ProcessPOInvoice()
    //   # Fixes applied for RT_PTP012_ProcessNPOInvoice()
    //   # Fixes applied for RT_PCN023_CreatePurchaseOrder()
    //   # Fixes applied for RT_PTP018_CreatePOInvoice()
    //   # Fixes applied for PRD107-GoodsReceipt()
    //   # Fixes applied for PTP133_Reverse_Rejected_CN()
    //   # Fixes applied for PTP024_NPO_InvoiceReversal_Correction()
    //   # Fixes applied for PTP132-ReverseRejectedInvoice()
    //   # Fixes applied for PTP027_ProcessLargeInvoice()
    //   # Fixes applied for PTP053_ProcessNPOInvoice_paymentmethod_otherthanBank()
    //   # Fixes applied for PTP056_Negativetesting_PO_Invoice_DocDateError()
    //   # Fixes applied for PTP056_Negativetesting_PO_Invoice_VATAmtError()
    //   # Fixes applied for PTP058_Negative_PO_CN()
    //   # Fixes applied for CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC1()
    //   # Fixes applied for CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC2()
    //   # Fixes applied for CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC3()
    // HEI.79 RITM2987058 IBM SRIVAS07 17.03.2023 # Automation StP Test Scripts
    //   # CHG2098629_AutomaticCreationofTransferOrderforImportPO - Few changes has been made
    //   # PTP103_PaymentAlongWithAppliedAndUnappliedEntry - New Script for Unapplied and Applied VLE
    //   # SuggestVendorPayment_RequestPageHandler2 - ned Handler for Payment Journal Tree
    // HEI.80 RITM2987058 IBM SRIVAS07 18.03.2023 # Automation StP Test Scripts
    //   # PTP103_PaymentAlongWithAppliedAndUnappliedEntry - Modified GetReceiptLineModalPageHandler
    // HEI.81 RITM2987058 IBM SRIVAS07 21.03.2023 # Automation StP Test Scripts
    //   # Code Added - FindFixedAsset()
    // HEI.82 RITM2987058 IBM SRIVAS07 28.03.2023 # Automation StP Test Scripts
    //   # Code Added - PaymentPosting
    //   # Code Added - PTP103_Unapplying_of_cleared_items
    //   # Code Added - PTP078_Reverse_payment_Rejected_payment
    //   # Code Added - PTP102-Clearing_of_open_items_on_vendor_accounts
    // HEI.83 RITM2987058 IBM SRIVAS07 28.03.2023 # Automation StP Test Scripts
    //   # PTP103_PaymentAlongWithAppliedAndUnappliedEntry
    //   # Code Added - PaymentPosting
    // HEI.84 RITM2987058 IBM SRIVAS07 29.03.2023 # Automation StP Test Scripts
    //   # Fixes applied for RT_PTP010_ProcessPOInvoice()
    //   # Fixes applied for RT_PTP012_ProcessNPOInvoice()
    //   # Fixes applied for RT_PCN023_CreatePurchaseOrder()
    //   # Fixes applied for RT_PTP018_CreatePOInvoice()
    //   # Fixes applied for PRD107-GoodsReceipt()
    //   # Fixes applied for PTP133_Reverse_Rejected_CN()
    //   # Fixes applied for PTP024_NPO_InvoiceReversal_Correction()
    //   # Fixes applied for PTP132-ReverseRejectedInvoice()
    //   # Fixes applied for PTP027_ProcessLargeInvoice()
    //   # Fixes applied for PTP053_ProcessNPOInvoice_paymentmethod_otherthanBank()
    //   # Fixes applied for PTP056_Negativetesting_PO_Invoice_DocDateError()
    //   # Fixes applied for PTP056_Negativetesting_PO_Invoice_VATAmtError()
    //   # Fixes applied for PTP058_Negative_PO_CN()
    //   # Fixes applied for CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC1()
    //   # Fixes applied for CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC2()
    //   # Fixes applied for CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC3()
    //   # PTP103_PaymentAlongWithAppliedAndUnappliedEntry
    //   # Code Added - PaymentPosting
    // HEI.85 RITM2987058 IBM SRIVAS07 05.04.2023 # Automation StP Test Scripts
    //   # PTP103_PaymentAlongWithAppliedAndUnappliedEntry
    //   # Code Added - PaymentPosting
    //   # Code Added - PTP103_Unapplying_of_cleared_items
    //   # Code Added - PTP078_Reverse_payment_Rejected_payment
    //   # Code Added - PTP102-Clearing_of_open_items_on_vendor_accounts
    // HEI.86 RITM2987058 IBM SRIVAS07 11.04.2023 # Automation StP Test Scripts
    //   # PTP103_PaymentAlongWithAppliedAndUnappliedEntry
    // HEI.87 RITM2987058 IBM NANDIS01 24.04.2023 # Automation StP Test Scripts
    //   # Fixed error on Amount - PTP010_ProcessPOInvoice
    // HEI.88 RITM2987058 IBM SRIVAS07 26.04.2023 # Automation StP Test Scripts
    //   # Modified Script - PTP084_ProcessManualPayment()
    // HEI.89 RITM2987058 IBM SRIVAS07 03.05.2023 # Automation StP Test Scripts
    //   # Fixes applied for CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC2()
    //   # Fixes applied for CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC3()
    // HEI.90 RITM2987058 IBM SRIVAS07 16.05.2023 # Automation StP Test Scripts
    //   # Code Added - PTP136_Reverse_Manual_Payment
    //   # Code Added - PTP086_Reverse_Refund()
    //   # Code Added - SuggestVendorPayment_RequestPageHandler2
    // HEI.91 RITM2987058 IBM SRIVAS07 17.05.2023 # Automation StP Test Scripts
    //   # Code Added - PTP086_Reverse_Refund()
    // HEI.92 CHG2185291 IBM SAXENA03 26.05.2023
    //   # Added code for Consolidation of Test Script objects
    // HEI.93 CHG2206767 IBM SRIVAS07 31.05.2023 # HeiLite BASE Test Script Adjustment and Optimazation
    //   # Code Added - PTP103_PaymentAlongWithAppliedAndUnappliedEntry
    //   # Code Added - PaymentPosting
    // HEI.94 CHG2208369 IBM SRIVAS07 14.06.2023 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Code added - PTP091_Automatic_clearing_on_GR_or_IR_Account
    // HEI.95 CHG2211315 IBM SRIVAS07 05-07-2023 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Created DimensionRestrictionCheck() function
    //   # Added DimensionRestrictionCheck in all the Scripts.
    // HEI.96 CHG2212000 IBM SRIVAS07 12-07-2023 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Added code PTP132-ReverseRejectedInvoice
    //   # Added code PCN001_ValidateContractHeader
    //   # Added code RT_PCN003_CreateCallOffFromBlanketOrder
    //   # Added code PCN025_UpdatePxQreturncalloff
    //   # Added code PTP086_Reverse_Refund
    //   # Added code PTP136_Reverse_Manual_Payment
    // HEI.97 CHG2212895 IBM SRIVAS07 19-07-23 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Added code SelectGenJnlTemplatePageHandler
    //   # Added PTP132-ReverseRejectedInvoice
    //   # Added PTP136_Reverse_Manual_Payment
    //   # Added CHG2161266_RemoveReferencedTransferOrder
    //   # Added CHG2161266_CreateAloneTransferOrder
    //   # Added CHG2161266_POModalPageHandler
    // HEI.98 CHG2213758 IBM SRIVAS07 27-07-23 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Added PTP132-ReverseRejectedInvoice
    //   # Added PTP136_Reverse_Manual_Payment
    //   # Added CHG2161266_RemoveReferencedTransferOrder
    //   # Added CHG2161266_CreateAloneTransferOrder
    //   # Added code PTP086_Reverse_Refund
    // HEI.99 CHG2214608 IBM SRIVAS07 01-08-23 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Added RT_PTP012_ProcessNPOInvoice
    //   # Added PTP055 Negativetesting NPO Invoice
    //   # Added PCN009_CreateReturnorderfromBlanketOrder
    //   # Added PTP053_ProcessNPOInvoice_paymentmethod_otherthanBank
    //   # Added CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC1
    //   # Added CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC4
    // HEI.100 CHG2214608 IBM SRIVAS07 01-08-23 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Added CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC1
    //   # Added CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC2
    //   # Added CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC3
    //   # Added CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC4
    // HEI.101 CHG2217887 IBM SRIVAS07 30-08-23 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Added Code in RT_PCN027_CreateCalloff
    // HEI.102 CHG2227098 IBM SRIVAS07 07-11-23 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Added Code in PTP082_Process_PtP_Netting
    //   # Added Code in PTP083_Reverse PtP Netting
    //   # Added Code in PCN002_ValidateContractItems
    // HEI.103 CHG2235089 IBM SRIVAS07 17-01-2024 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Added code in PCN025_UpdatePxQreturncalloff
    // HEI.104 CHG2237616 IBM SRIVAS07 08-02-2024 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Added Code in RT_PCN027_CreateCalloff()
    // HEI.105 CHG2241233 IBM SRIVAS07 27-02-2024 # HeiLite BASE Test Script Adjustment and Optimizations.
    //   # Added Code in PTP056_Negativetesting_PO_Invoice_DocDateError()
    //   # Added Code in PTP056_Negativetesting_PO_Invoice_VendorInvError()
    //   # Added Code in PTP056_Negativetesting_PO_Invoice_VATAmtError()
    // HEI.106 CHG2247916 IBM SRIVAS07 17-04-2024 # HeiLite BASE Test Script Adjustment and Optimizations
    //   # Added Code in PTP055 Negativetesting NPO Invoice()
    // HEI.107 CHG2253044 IBM SRIVAS07 29-05-25 # WEEK22_2024 | HeiLite BASE Test Script Adjustment and Optimizations
    //   # Added code in RT_PCN003_CreateCallOffFromBlanketOrder()
    //   # Added code in PCN025_UpdatePxQreturncalloff()
    // HEI.108 CHG2275168 SAHAL01 29.11.2024 HeiLite BASE Test Script Adjustment and Optimizations
    //   # Added Code to fix the error in RT_PTP084_ProcessManualPayment.
    // HEI.109 CHG2288704 CHOUDS08 13.02.2025 HeiLite BASE Test Script Adjustment and Optimizations
    //   # Added Code to fix the error in PCN002_ValidateContractItems.
    // HEI.110 CHG2298037 CHOUDS08 07.04.2025 WEEK 15 2025 Test Script Optimsation and BUg fix
    //   # Added Code to fix the error in PCN025_UpdatePxQreturncalloff by modifying Item to be unblocked during execution.
    //   # Added Code to fix PCN002_ValidateContractItems() by converting text values into dates and comparing them to check if Purchase Line Price dates are either expired or invalid.
    // HEI.111 CHG2299696 CHOUDS08 15.04.2025 WEEK 16 2025 Test Script OptimIsation
    //   # Added Code in PCN009_CreateReturnorderfromBlanketOrder to filter with correct Line No.
    //   # Added code tofix the error in PCN025_UpdatePxQreturncalloff by modifying Item to be unblocked during execution, inside a repeat until loop.
    // HEI.112 CHG2307923 SAHAL01 10.07.2025 Test Script - Block Payment for Invoices with Price Difference higher than the tolerance
    //   # Created New Functions - RT_PCN029_ProcessPO-PI_GlobalUpperToleranceLimitPercentage
    //                           - RT_PCN030_ProcessPO-PI_GlobalUpperToleranceLimitAmount
    // HEI.113 CHG2316128 SAHAL01 05.08.2025 Test Script - HeiLite BASE Test Script Adjustment and Optimizations
    //   # Added Code in Functions - PTP056_Negativetesting_PO_Invoice_DocDateError
    //                             - PTP056_Negativetesting_PO_Invoice_VendorInvError
    //                             - PTP056_Negativetesting_PO_Invoice_VATAmtError
    //                             - PTP058_Negative_PO_CN


    //BC UPGRADE KUMARR78 >>
    //1. Page ID Replaced with Page Name – NoSeriesList Handlers
    //   Old Code:
    //     Page 571
    //   New Code:
    //     Page "No. Series"
    //   Reason:
    //   Page ID references replaced with page names for BC SaaS compatibility.
    //2. Removal of "Show Posted Document No." Setup Logic (All Occurrences Consolidated)
    //   Old Code:
    //     PurchasesPayablesSetup."Show Posted Document No."
    //   New Code:
    //     Entire logic removed.
    //   Reason:
    //   DIT customization field not available in Business Central SaaS.
    //3. Removal of Manual Invoice Amount Fields (All Occurrences Consolidated)
    //   Old Code:
    //     "Doc. Amount Incl. VAT"
    //     "Doc. Amount VAT"
    //   New Code:
    //     Entire logic removed.
    //   Reason:
    //   DIT custom fields removed.
    //   BC calculates totals automatically.
    //4. Requester ID Field Removed (All Occurrences Consolidated)
    //   Old Code:
    //     PurchaseOrder."Requester ID"
    //     PurchaseQuote."Requester ID"
    //   New Code:
    //     Field references removed.
    //     In conditional cases → semicolon retained.
    //   Reason:
    //   Custom DIT field not available in BC SaaS.
    //5. Removal of DIT Approval Unlimited Fields (User Setup)
    //   Old Code:
    //     "Unlimited Sales Approval"
    //     "Unlimited Cr. Limit Customer"
    //     "Unlimited Deposit Limit Cust."
    //     "Unlimited Overdue Approval"
    //   New Code:
    //     Removed.
    //   Reason:
    //   DIT approval customization removed in BC.
    //6. Action ID Replaced with Caption-Based Invocation (General Pattern Consolidated)
    //   Old Code Examples:
    //     Action120.INVOKE
    //     Action149.INVOKE
    //     Action35.INVOKE
    //     Action93.INVOKE
    //     Action45.INVOKE
    //     Action25.INVOKE
    //     Action23.INVOKE
    //   New Code Examples:
    //     "Re&lease".Invoke()
    //     "Create &Whse. Receipt".Invoke()
    //     "&Delegate".Invoke()
    //     "Create &Warehouse Shipment".Invoke()
    //     "P&ost Shipment".Invoke()
    //     Dimensions.Invoke()
    //     Receipts.Invoke()
    //   Reason:
    //   Numeric Action IDs are not supported in Business Central SaaS.
    //   Replaced with caption-based action references.
    //7. Post Action Renamed to Extension-Specific Posting
    //   Old Code:
    //     Post.INVOKE
    //   New Code:
    //     Post_Custom.INVOKE
    //     Post_Cust.INVOKE
    //   Reason:
    //   Posting action renamed in upgraded extension architecture.
    //8. Date Literal Format Corrected
    //   Old Code:
    //     100922D / 100921D
    //   New Code:
    //     20220910D / 20210910D
    //   Reason:
    //   NAV date literal format incompatible with BC SaaS.
    //9. SRM Contract Framework Removed (All Related Fields Consolidated)
    //   Removed Fields:
    //     "SRM Contract No."
    //     "SRM Contract Name"
    //     "SRM Contract Type"
    //     "Valid From"
    //     "Target Value Amount"
    //     "Shipment Method Location"
    //   Reason:
    //   DIT-specific SRM contract framework not available in BC.
    //10. Channel-Based Price Validation Removed
    //   Entire Channel pricing validation block removed.
    //   Reason:
    //   DIT-specific pricing logic not supported in standard BC.
    //11. Email Dialog & Sending Options Handlers Removed
    //   Removed:
    //     SelectSendingOptions_ModalPageHandler
    //     EmailDialog_ModalPageHandler
    //   Reason:
    //   Email dialog page 9700 not supported in BC SaaS test automation.
    //12. Document Subtype Code Logic Removed (Report Selections)
    //   Removed:
    //     "Document Subtype Code"
    //   Reason:
    //   DIT Document Subtype framework not available in BC.
    //13. Test Procedures Moved to Integration Extension
    //   Moved Tests:
    //     RT_PTP011_ProcessPOCreditMemo
    //     PCN001
    //     PCN002
    //     PCN014
    //   Reason:
    //   Refactored into INT Extension for modular BC architecture.
    //14. Control ID Usage Removed in Suggest Vendor Payment
    //   Removed:
    //     Control55001
    //     VendorLedgerEntriesFilter control references
    //   Reason:
    //   Control-level manipulation not supported in BC SaaS test pages.
    //15. OnPrem ADDLINK Removed (All Occurrences Consolidated)
    //   Old Code:
    //     ADDLINK(FileMgt.ServerTempFileName(...))
    //   New Code:
    //     Entire logic replaced.
    //   Reason:
    //   File Management ADDLINK is OnPrem-only.
    //16. SaaS Attachment Implementation Added
    //   New Pattern:
    //     Temp Blob
    //     Document Attachment table
    //     ImportStream()
    //     Insert(true)
    //17. Variables Added for SaaS Attachment Handling
    //   Added:
    //     TempBlob
    //     DocumentAttachment
    //     OutStream
    //     InStream
    //18. Custom Amount Error Validation Removed
    //   Removed:
    //     GETLASTERRORTEXT comparison using "Doc. Amount Incl. VAT"
    //   Reason:
    //   Dependent on removed DIT amount fields.
    //   Replaced by standard BC validation behavior.
    //19. Source Documents Custom Action Removed
    //   Removed:
    //     Custom Action1000010005
    //   Reason:
    //   Custom action not available in BC SaaS.
    //BC UPGRADE KUMARR78 <<

    // BC Upgrade MISHRS14 >>
    // Removed false from FINDSET as its being depreceted in procedure - RT_PTP084_ProcessManualPayment
    // Removed false from FINDSET as its being depreceted in procedure - RT_PTP084_ProcessManualPayment
    // Removed false from FINDSET as its being depreceted in procedure - PCN009_CreateReturnorderfromBlanketOrder
    // Removed false from FINDSET as its being depreceted in procedure - PCN025_UpdatePxQreturncalloff
    // Removed false from FINDSET as its being depreceted in procedure - PTP136_Reverse_Manual_Payment
    // Removed false from FINDSET as its being depreceted in procedure - PaymentPosting
    // BC Upgrade MISHRS14 <<

    //BC UPGRADE ATHUKS01 STP_FDD0007 >>
    //1.Before it was Drink IT field "Doc. Amount Incl. VAT",Now Base is provided but some calculation purpose needed to use custom fields
    //"Doc. Amount Incl. VAT IBM" & "Doc. Amount VAT IBM"
    //BC UPGRADE ATHUKS01 STP_FDD0007<

    // BC Upgrade MISHRS14 >>
    // Added HEI.114 and HEI.115 Tag
    // HEI.114 CHG2323181 SAHAL01 17.09.2025 Test Script - HeiLite BASE Test Script Adjustment and Optimizations
    // # Added Code in Functions - PTP056_Negativetesting_PO_Invoice_DocDateError
    //                        - PTP056_Negativetesting_PO_Invoice_VendorInvError
    //                        - PTP056_Negativetesting_PO_Invoice_VATAmtError
    //                        - PTP058_Negative_PO_CN
    // HEI.115 CHG2333634 IBM SAHAL01 08.12.2025 Test Script - HeiLite BASE Test Script Adjustment and Optimizations
    // # Added Code in Function - PCN025_UpdatePxQreturncalloff
    // BC Upgrade MISHRS14 <<

    Permissions = tabledata 25 = rm;
    Subtype = Test;

    trigger OnRun();
    begin
    end;

    var
        EntryNo: integer;
        ApprovalEntry: Record "Approval Entry";
        DefaultDim: Record "Default Dimension";
        DimensionValue: Record "Dimension Value";
        gChartofAccount: Record "G/L Account";
        // gGenJnlBatches: Record "Gen. Journal Batch";
        GenJnlTemplate: Record "Gen. Journal Template";
        PurchaseHeader: Record "Purchase Header";
        PnPSetup: Record "Purchases & Payables Setup";
        SourceCodeSetup: Record "Source Code Setup";
        UnitTestingValue: Record "Unit Testing Value FND";
        UnitTestingValues: Record "Unit Testing Value FND";
        UnitTestingValuesAB: Record "Unit Testing Value FND";
        gVendor: Record Vendor;
        VendLedgEntry: Record "Vendor Ledger Entry";
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
        // Workflow: Record Workflow;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        AmtCheck: Boolean;
        NotPopulateRec: Boolean;
        RemAmtCheck: Boolean;
        "---------//----------": Char;
        ApplDocNo: Code[10];
        CurrencyCode: Code[10];
        PaymentDocNo1: Code[10];
        ScriptNo: Code[10];
        StorePostedInvNo: Code[10];
        DocNoAB: Code[20];
        GenJouDocNo: Code[20];
        GLAccNo: Code[20];
        GLPaymentDocNo: Code[20];
        InvNo: Code[20];
        MVMTDimension: Code[20];
        PaymentDocNo: Code[20];
        PostedReturnOrderNo: Code[20];
        PurchCrMemoNo: Code[20];
        PurchInvNo: Code[20];
        PurchOrdNo: Code[20];
        PurchRetOrderNo: Code[20];
        ReverseVendNo: Code[20];
        SelectJnlTemplate: Code[20];
        StoreCreditMemoNo: Code[20];
        DocNo: Code[40];
        DueDate: Date;
        StartPosNoDigits: array[4] of Integer;
        Text000: Label 'Tolerance Exceeded not found.';
        GenJnlAccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        DocType: Option Payment,Invoice;
        BlanketPurchaseOrder: TestPage "Blanket Purchase Order";
        BlanketPurchaseOrderSubform: TestPage "Blanket Purchase Order Subform";
        GenJnl: TestPage "General Journal";
        CMGDimension: Text;
        CrNo: Text;
        EBFWarnConf: Text;
        FilterOperator: Text;
        GLTransNo: Text;
        LotFilter: Text;
        LotNoFilter: Text;
        LotNoFilterAB: Text;
        RecNo: Text;
        storemessage: Text;
        TransNo: Text;
        VendorNo: Text;
        DateChangeError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''You cannot modify the field- ''Due Date''.  (Select Refresh to discard errors)''';
        PaymentMethodCodeError: TextConst ENU = 'Validation error for Field: Payment Method Code,  Message = ''You cannot modify the field- ''Payment Method Code''.  (Select Refresh to discard errors)''';
        PaymentStatusToSet: Option "Pending Review","Payment Approved","Payment Rejected";
        DocumentIsPosted: Boolean;
        LastError: text;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler,MessageHandler,WhseRcptPageHandler,ItemTrackingLinesModalPageHandler,GetReceiptLineModalPageHandler,DimSetEntriesModalPageHandler')]
    procedure RT_PTP010_ProcessPOInvoice();
    var
        War: Page "Warehouse Receipt";
        WarEmp: Record "Warehouse Employee";
        WarRecHdr: Record "Warehouse Receipt Header";
        PurchaseInvList: TestPage "PO Purchase Invoices";
        Vendor: Record Vendor;
        Item: Record item;
        Location: Record Location;
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        PostedPurchInvHdr: Record "Purch. Inv. Header";
        PostedPurchInv: TestPage "Posted Purchase Invoice";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        UserSetup2: Record "User Setup";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        EbfCombination: Record "Ebf Combination FND";
        PurchaseLine: Record "Purchase Line";
        GeneralPostingSetup: Record "General Posting Setup";
        GLAccount: Record "G/L Account";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DimensionValue1: Record "Dimension Value";
        Bin: Record Bin;
        decInvRoundAmount: Decimal;
        Workflow: Record Workflow;
        RecZone: Record Zone;
        WhseEmpDTW: record 50356;
        WarRecLin: Record "Warehouse Receipt Line";
        WarEmployee: Record "Warehouse Employee";
        WhseDocNo: code[20];
    begin
        // WarRecHdr.PCDToApproveFilterFDW
        //HEI.01>>
        DimensionRestrictionCheck;//HEI.95
        WarehouseReceiptHeader.DELETEALL();//HEI.36
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PTP010', COMPANYNAME, DATABASE::Vendor);
        Vendor.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PTP010', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PTP010', COMPANYNAME, DATABASE::"Vendor Bank Account");
        VendorBankAccount.GET(Vendor."No.", UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PTP010', COMPANYNAME, DATABASE::"Lot No. Information");
        LotNoFilter := UnitTestingValues.Value;

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PTP010', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);
        //HEI.61>>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PTP010', COMPANYNAME, DATABASE::Bin);
        Bin.GET(Location.Code, UnitTestingValues.Value);
        //HEI.61<<
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PTP010', COMPANYNAME, DATABASE::"Dimension Value");
        GeneralLedgerSetup.GET;
        //HEI.95>>
        //IF UnitTestingValues."Value 2" <> '' THEN
        IF UnitTestingValues.Value <> '' THEN
            //HEI.95<<
            DimensionValue.GET(GeneralLedgerSetup."Shortcut Dimension 3 Code", UnitTestingValues.Value);
        //Step 1: Logon to Heilite
        //Create a PO
        //PurchaseOrderList.OPENNEW;
        PurchaseOrder.OPENNEW;
        //PurchaseOrder.NEW;
        PurchaseOrder."No.".ASSISTEDIT;
        PurchaseOrder."Buy-from Vendor No.".SETVALUE(Vendor."No.");
        PurchaseOrder."Vendor Invoice No.".SETVALUE('StP Unit Test PTP010');
        //HEI.43>>
        IF PurchasesPayablesSetup.GET THEN
            IF PurchasesPayablesSetup."Mandatory Region on Header FND" = TRUE THEN
                PurchaseOrder."Location Code".SETVALUE(Location.Code);
        //HEI.43<<
        //HEI.12>>
        PnPSetup.GET;
        //BC UPGRADE KUMARR78 >>DIT Field Removed.
        IF PnPSetup."Requester ID Mandatory FND" THEN // BC Upgrade BHARAD11
            PurchaseOrder."Requester ID".SETVALUE(USERID);
        //BC UPGRADE KUMARR78 << DIT Field Removed.
        //HEI.12<<
        PurchaseOrder.PurchLines.NEW;
        PurchaseOrder.PurchLines.Type.SETVALUE(Type::Item);
        PurchaseOrder.PurchLines."No.".SETVALUE(Item."No.");
        PurchaseOrder.PurchLines."Location Code".SETVALUE(Location.Code);
        PurchaseOrder.PurchLines.Quantity.SETVALUE(1);
        //HEI.44>>
        GeneralLedgerSetup.GET;
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PTP010', COMPANYNAME, DATABASE::"Dimension Value");
        //HEI.95>>
        //IF UnitTestingValues.Value<>'' THEN
        IF UnitTestingValues."Value 2" <> '' THEN
            //HEI.95<<
            DimensionValue1.GET(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues."Value 2");
        EbfCombination.RESET;
        EbfCombination.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue1.Code);
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue1.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SETFILTER("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DELETEALL();
        PurchaseLine.RESET;
        PurchaseLine.SETRANGE("Document No.", PurchaseOrder."No.".VALUE);
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SETRANGE("No.", PurchaseOrder.PurchLines."No.".VALUE);
        IF PurchaseLine.FINDFIRST THEN BEGIN
            PurchaseLine.VALIDATE("Shortcut Dimension 2 Code", DimensionValue1.Code);
            IF UPPERCASE(COMPANYNAME) = UPPERCASE('Almaza') THEN//HEI.63
                PurchaseLine.VALIDATE("Bin Code", Bin.Code);//HEI.61
            PurchaseLine.MODIFY;
        END;
        //HEI.44<<
        PurchaseOrder.PurchLines.Dimensions.INVOKE;
        //Approval Process
        /*//TEMP-AB
        PurchaseHeader.GET(PurchaseHeader."Document Type"::Order,PurchaseOrder."No.".VALUE);
        IF ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) THEN BEGIN
          PurchaseOrder.SendApprovalRequest.INVOKE;
          ApprovalEntries.TRAP;
          PurchaseOrder.Approvals.INVOKE;
          UserSetup.GET(ApprovalEntries."Approver ID".VALUE);
          UserSetup.Substitute := USERID;
          UserSetup."Approval Administrator":=TRUE;
          UserSetup.MODIFY;

          //Update Approval Limit for USERID
          UserSetup2.GET(USERID);
          IF NOT UserSetup2."Unlimited Purchase Approval" OR NOT UserSetup2."Unlimited Request Approval" THEN BEGIN
            UserSetup2."Unlimited Purchase Approval" := TRUE;
            UserSetup2."Unlimited Request Approval" := TRUE;
            //UserSetup2."Approval Administrator":=TRUE;
            UserSetup2.MODIFY;
          END;

          //Delegate Approval Request
          ApprovalEntries.Action35.INVOKE;

          //Approve Approval Entry
          PurchaseOrder.Approve.INVOKE;
        END ELSE
          PurchaseOrder.Release.INVOKE;
        */
        //
        //Approval Process
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".VALUE);
        IF ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) THEN BEGIN
            Workflow.SETRANGE(Enabled, TRUE);
            //HEI.74>>
            IF Workflow.FINDFIRST THEN
                Workflow.MODIFYALL(Enabled, FALSE);
            //IF Workflow.FINDSET THEN
            //REPEAT
            //Workflow.Enabled := FALSE;
            //Workflow.MODIFY;
            //UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        END;
        //HEI.42>>
        IF GeneralPostingSetup.GET(Vendor."Gen. Bus. Posting Group", Item."Gen. Prod. Posting Group") THEN
            IF GLAccount.GET(GeneralPostingSetup."Purchase Variance Account") THEN
                IF GLAccount.Blocked = TRUE THEN BEGIN
                    GLAccount.Blocked := FALSE;
                    GLAccount.MODIFY;
                END;
        //HEI.42<<
        PurchaseOrder.Release.INVOKE;
        // BC Upgrade BHARDA11 >>
        Reczone.reset;
        Reczone.setrange("Location Code", Location.code);
        reczone.findfirst();
        WhseEmpDTW.init();
        WhseEmpDTW."User ID" := userid;
        WhseEmpDTW."location Code" := Location.code;
        WhseEmpDTW."zone Code" := RecZone.Code;
        if WhseEmpDTW.insert() then;
        // error(Reczone.code);
        Bin.reset();
        Bin.SetRange("Zone Code", RecZone.code);
        bin.findfirst();
        WarEmployee.init();
        WarEmployee."User ID" := userid;
        waremployee."location Code" := Location.code;
        if WarEmployee.insert() then;
        // BC Upgrade BHARDA11 <<
        //
        // PurchaseOrder.Action149.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseOrder."Create &Whse. Receipt".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name
        WarehouseReceipt.OPENVIEW;
        WarehouseReceipt.FILTER.SETFILTER("Source No. FND", PurchaseOrder."No.".VALUE);

        //Store the PO No in warehouse receipt
        WhseRcptPONo := WarehouseReceipt."Source No.".VALUE;
        WhseDocNo := WarehouseReceipt."No.".value; // BC Upgrade BHARDA11
                                                   // BC Upgrade BHARDA11 

        WarRecLin.reset();
        WarRecLin.SetRange("No.", WhseDocNo);
        WarRecLin.findset();
        WarRecLin.Validate("Zone Code", RecZone.Code);
        WarRecLin.Validate("Bin Code", Bin.Code);
        WarRecLin.modify();
        // BC Upgrade BHARDA11 
        //Select Item Tracking Code
        WarehouseReceipt.WhseReceiptLines.ItemTrackingLines.INVOKE;

        //Post The warehouse receipt
        WarehouseReceipt."Post Receipt".INVOKE;
        PurchaseOrder.OK.INVOKE;
        //PurchaseOrderList.OK.INVOKE;

        PurchRcptHdr.SETRANGE("Order No.", WhseRcptPONo);
        IF PurchRcptHdr.FINDFIRST THEN
            DocNo := PurchRcptHdr."No.";

        //Step 2: Go to Search and type PO Purchase Invoices
        //PurchaseInvList.OPENNEW;

        //Step 3: Select PO Purchase Invoices from the list
        PurchaseInvoice.OPENNEW;
        //PurchaseInvoice.NEW;

        //Step 4 - AssitEdit to create the Document No. & Add Vendor No. and put vendor invoice No.
        PurchaseInvoice."No.".ASSISTEDIT;
        PurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");
        PurchaseInvoice."Vendor Invoice No.".SETVALUE('PTP010');
        //PurchaseInvoice."Due Date".SETVALUE(WORKDATE);

        //Step 5 - Go to LINES/FUNCTIONS tab and click &quot;Get Receipt Lines&quot;
        PurchaseInvoice.PurchLines.GetReceiptLines.INVOKE;
        GetReceiptLines.OPENVIEW;
        //PurchaseInvoice."Due Date".SETVALUE(WORKDATE);
        IF Vendor."Preferred Bank Account Code" = '' THEN //HEI.31
            PurchaseInvoice."Vendor Bank Account".SETVALUE(VendorBankAccount.Code);

        PurchInvNo := PurchaseInvoice."No.".VALUE;
        //HEI.87>>
        //DocAmount := 0;
        //VATAmount := 0;
        //PurchLn.RESET;
        //PurchLn.SETRANGE("Document Type",PurchLn."Document Type"::Invoice);
        //PurchLn.SETRANGE("Document No.",PurchInvNo);
        //IF PurchLn.FINDSET THEN REPEAT
        //  DocAmount += PurchLn."Amount Including VAT";
        VATAmount += (PurchLn."Amount Including VAT" - PurchLn.Amount);
        //UNTIL PurchLn.NEXT = 0;
        //IF (GeneralLedgerSetup."Inv. Rounding Precision (LCY)"=1) AND (PurchaseInvoice."Currency Code".VALUE='') THEN//HEI.21
        //  PurchaseInvoice."Doc. Amount Incl. VAT".SETVALUE(ROUND(DocAmount,1,'<'))//HEI.21
        //ELSE                                                                     //HEI.21
        //  PurchaseInvoice."Doc. Amount Incl. VAT".SETVALUE(DocAmount);
        //PurchaseInvoice."Doc. Amount VAT".SETVALUE(VATAmount);
        decInvRoundAmount := 0;
        //BC UPGRADE ATHUKS01 STP_FDD0007>>

        PurchaseInvoice."Doc. Amount Incl. VAT IBM".SETVALUE(PurchaseInvoice.PurchLines."Total Amount Incl. VAT".VALUE);
        PurchaseInvoice."Doc. Amount VAT IBM".SETVALUE(PurchaseInvoice.PurchLines."Total VAT Amount".VALUE);
        //BC UPGRADE ATHUKS01 STP_FDD0007<<      

        IF (GeneralLedgerSetup."Inv. Rounding Precision (LCY)" = 1) AND (PurchaseInvoice."Currency Code".VALUE = '') THEN BEGIN
            decInvRoundAmount := -ROUND(PurchaseInvoice.PurchLines."Total Amount Incl. VAT".ASDECIMAL -
                                 ROUND(PurchaseInvoice.PurchLines."Total Amount Incl. VAT".ASDECIMAL, GeneralLedgerSetup."Inv. Rounding Precision (LCY)"),
                                 GeneralLedgerSetup."Amount Rounding Precision");
            ///BC UPGRADE ATHUKS01 STP_FDD0007>>
            PurchaseInvoice."Doc. Amount Incl. VAT IBM".SETVALUE(PurchaseInvoice.PurchLines."Total Amount Incl. VAT".ASDECIMAL + decInvRoundAmount);
            PurchaseInvoice."Doc. Amount VAT IBM".SETVALUE(PurchaseInvoice.PurchLines."Total VAT Amount".VALUE);
            //BC UPGRADE ATHUKS01 STP_FDD0007<<
        END;
        //HEI.87<<
        //HEI.40>>
        GeneralLedgerSetup.GET;
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PTP010', COMPANYNAME, DATABASE::"Dimension Value");
        //HEI.95>>
        //IF UnitTestingValues.Value<>'' THEN
        IF UnitTestingValues."Value 2" <> '' THEN
            //HEI.95<<
            //DimensionValue.GET(GeneralLedgerSetup."Shortcut Dimension 2 Code",UnitTestingValues."Value 2");//HEI.44
            DimensionValue1.GET(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues."Value 2");//HEI.44
        EbfCombination.RESET;
        EbfCombination.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue1.Code);//HEI.44
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue1.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SETFILTER("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DELETEALL();
        PurchaseLine.RESET;
        PurchaseLine.SETRANGE("Document No.", PurchaseInvoice."No.".VALUE);
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Invoice);
        PurchaseLine.SETRANGE("No.", PurchaseInvoice.PurchLines."No.".VALUE);
        IF PurchaseLine.FINDFIRST THEN BEGIN
            //PurchaseLine.VALIDATE("Shortcut Dimension 2 Code",DimensionValue.Code);//HEI.44
            PurchaseLine.VALIDATE("Shortcut Dimension 2 Code", DimensionValue1.Code);//HEI.44
            PurchaseLine.MODIFY;
        END;
        //HEI.40<<
        PurchaseInvoice.Dimensions.INVOKE;//HEi.36
        PurchaseInvoice.Post_Custom.INVOKE;

        PostedPurchInvHdr.SETRANGE("Pre-Assigned No.", PurchInvNo);
        IF PostedPurchInvHdr.FINDFIRST THEN
            StorePostedInvNo := PostedPurchInvHdr."No.";

        PostedPurchInv.OPENVIEW;
        PostedPurchInv.FILTER.SETFILTER("No.", StorePostedInvNo);
        PostedPurchInv."Payment Status".ASSERTEQUALS(paymentstatus::"Payment Approved");
        //HEI.01<<

    end;


    [ModalPageHandler]
    // procedure NoSeriesListModalPageHandler(var NoSeriesList: Page 571; var Response: Action); //BC UPGRADE KUMARR78 Blocking As Page Variable removed.
    procedure NoSeriesListModalPageHandler(var NoSeriesList: Page "No. Series"; var Response: Action);//BC UPGRADE KUMARR78 Adding As Page Variable removed and Using No. Series.

    begin
        Response := Action::LookupOK;
    end;

    [ModalPageHandler]
    procedure GetReceiptLineModalPageHandler(var GetReceiptLines: TestPage "Get Receipt Lines");
    var
        PurchaseReceiptLine: Record "Purch. Rcpt. Line";
        Vendor: Record Vendor;
    begin
        //GetReceiptLines.FINDFIRSTFIELD("Document No.",DocNo);
        GetReceiptLines.Filter.SetFilter("Document No.", DocNo);
        GetReceiptLines.OK().Invoke();
    end;

    [ConfirmHandler]
    procedure ConfirmationHandler(Question: Text[1024]; var Reply: Boolean);
    var
        ApprovalReqstQst: Label 'An approval request has been sent.';
        ArchiveDoc: Label 'Archive Order no.: %1?';
        CreateOrderQst1: Label 'Do you want to convert the quote to an order?';
        CRMemoQst: Label 'Do you want to post the credit memo?';
        DimConf: Label 'You may have changed a dimension.\\Do you want to update the lines?';
        PostInv: Label 'Are you sure you want to post combination of account %1 with dimension %2';
        PrePayment: Label 'Do you want to post the prepayments for %1 %2?';
        QuoteConf: Label 'Shipment method code is relevant for Import process. Do you want to convert the quote to an order?';
        UnapplyVLE: Label 'To unapply these entries, correcting entries will be posted.\Do you want to unapply the entries?';
        CreateOrderQst: TextConst ENU = 'Do you want to create an order from the blanket order?', FRA = 'Souhaitez-vous transformer la commande ouverte en commande ?';
        DocumentNotPostedClosePageQst: TextConst ENU = 'The document has not been posted.\Are you sure you want to exit?', FRA = 'Le document n''a pas été validé.\Voulez-vous vraiment quitter ?';
        LotAssign: TextConst ENU = 'The Lot No. - %1 has an Extract Content [%w/w] Value = 0.00. Would you like to proceed?';
        PostDocumentQst: TextConst ENU = 'Do you want to post the %1?', FRA = 'Souhaitez-vous valider le document %1 ?';
        PostJnlLineQst: TextConst ENU = 'Do you want to post the journal lines?', FRA = 'Souhaitez-vous valider les lignes de la feuille ?';
        PostReceiptQst: TextConst ENU = 'Do you want to post the receipt?', FRA = 'Souhaitez-vous valider cette réception ?';
        ReceiveQst: TextConst ENU = 'Do you want to receive the %1 ?', FRA = 'Voulez-vous réceptionner le %1 ?';
    begin
        if (Question = DocumentNotPostedClosePageQst) or
           (Question = PostReceiptQst) or
           (Question = PostDocumentQst) or
           (Question = PostJnlLineQst) or
           (Question = CreateOrderQst) or
           (Question = ReceiveQst) or
           (Question = ApprovalReqstQst) or
           (Question = PostInv) or
           (Question = LotAssign) or
           (Question = CreateOrderQst1) or
           (Question = ArchiveDoc) or
           (Question = EBFWarnConf) or//HEI.19
                                      //>>HEI.25
                                      //(Question=QuoteConf)//HEI.20
           (Question = QuoteConf) or
           (Question = CRMemoQst) or
           //<<HEI.25
           (Question = UnapplyVLE) or//HEI.23
           (Question = PrePayment)//HEI.26
           or (Question = DimConf)//HEI.36
        then
            Reply := true;
    end;

    [MessageHandler]
    procedure MessageHandler(Message: Text[1024]);
    begin
    end;

    [PageHandler]
    procedure WhseRcptPageHandler(var WarehouseReceipt: Page "Warehouse Receipt");
    begin
    end;

    [ModalPageHandler]
    procedure ItemTrackingLinesModalPageHandler(var ItemTrackingLines: TestPage "Item Tracking Lines");
    var
        TrackingSpecification: Record "Tracking Specification" temporary;
    begin
        ItemTrackingLines."Lot No.".SetValue(LotNoFilter);
        ItemTrackingLines."Quantity (Base)".SetValue(1);
        ItemTrackingLines.OK().Invoke();
    end;

    [MessageHandler]
    procedure MessageHandler_PCN027(Message: Text[1024]);
    var
        StorePONumber: Text;
    begin
        storemessage := Message;
    end;

    [ModalPageHandler]
    procedure DimensionSetEntriesModalPageHandler(var EditDimensionSetEntries: TestPage "Edit Dimension Set Entries");
    begin
        EditDimensionSetEntries.New();
        EditDimensionSetEntries.Filter.SetFilter("Dimension Code", DimensionValue."Dimension Code");
        EditDimensionSetEntries."Dimension Code".AssertEquals(DimensionValue."Dimension Code");
        EditDimensionSetEntries.OK().Invoke();
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler')]
    procedure RT_PTP012_ProcessNPOInvoice();
    var
        DefaultDimension: Record "Default Dimension";
        DimensionValue: Record "Dimension Value";
        DimensionValue1: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        GLAccount: Record "G/L Account";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Location: Record Location;
        PostedPurchInvHdr: Record "Purch. Inv. Header";
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        PurchaseLine: Record "Purchase Line";
        PurchLn: Record "Purchase Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        Vendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        PurchInvNo: Code[20];
        StorePostedInvNo: Code[20];
        WhseRcptPONo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        ApprovalEntries: TestPage "Approval Entries";
        GetReceiptLines: TestPage "Get Receipt Lines";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        PurchaseInvoice: TestPage "NPO Purchase Invoice";
        PurchaseInvList: TestPage "NPO Purchase Invoices";
        PostedPurchInv: TestPage "Posted Purchase Invoice";
        PurchaseOrder: TestPage "Purchase Order";
        PurchaseOrderList: TestPage "Purchase Orders";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        BankAccount: Text;
        DueDate: Text;
        Workflow: Record Workflow;
    begin
        DimensionRestrictionCheck;//HEI.95
        //HEI.01>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP012', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP012', CompanyName, Database::"G/L Account");
        GLAccount.Get(UnitTestingValues.Value);
        //HEI.53>>
        if DefaultDimension.Get(15, GLAccount."No.", 'TRD_PART') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;

        //BC UPGRADE KUMARR78 >>DIT Variable Removed.("Show Posted Document No.")
        // IF PurchasesPayablesSetup.GET THEN
        //     IF PurchasesPayablesSetup."Show Posted Document No." THEN BEGIN
        //         PurchasesPayablesSetup."Show Posted Document No." := FALSE;
        //         PurchasesPayablesSetup.MODIFY;
        //     END;
        //BC UPGRADE KUMARR78 << DIT Variable Removed.("Show Posted Document No.")

        //HEI.53<<
        //HEI.19>>
        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP012', CompanyName, Database::"Dimension Value");
        if UnitTestingValues.Value <> '' then
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);
        //HEI.19<<
        //HEI.40>>
        UnitTestingValues.Get('PTP012', CompanyName, Database::"Dimension Value");
        if UnitTestingValues.Value <> '' then
            DimensionValue1.Get(GeneralLedgerSetup."Shortcut Dimension 1 Code", UnitTestingValues."Value 2");
        //HEI.40<<
        //HEI.43>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP011', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);
        //HEI.43<<
        //HEi.37>>
        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue.Code); //HEI.44
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();
        //HEI.37<<
        PurchaseInvoice.OPENNEW;
        PurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");

        PurchaseInvoice."Vendor Invoice No.".SETVALUE('StP PTP012');
        PurchInvNo := PurchaseInvoice."No.".VALUE;
        //HEI.43>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseInvoice."Location Code".SETVALUE(Location.Code);
        //HEI.43<<
        PurchaseInvoice.PurchLines.NPOType.SETVALUE(Type::"G/L Account");
        PurchaseInvoice.PurchLines."No.".SETVALUE(GLAccount."No.");
        PurchaseInvoice.PurchLines.Quantity.SETVALUE(1);
        //PurchaseInvoice.PurchLines."Direct Unit Cost".SETVALUE(100); //TEMP-AB
        //HEI.24>>
        //PurchaseInvoice.PurchLines."Shortcut Dimension 2 Code".SETVALUE(DimensionValue.Code);//HEI.19
        PurchaseLine.Reset();
        PurchaseLine.SETRANGE("Document No.", PurchaseInvoice."No.".VALUE);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Invoice);
        PurchaseLine.SETRANGE("No.", PurchaseInvoice.PurchLines."No.".VALUE);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Shortcut Dimension 1 Code", DimensionValue1.Code);//HEI.40
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
            PurchaseLine.Modify();
        end;
        //HEI.24<<
        if (PurchaseInvoice."Vendor Bank Account".VALUE <> '') then
            BankAccount := PurchaseInvoice."Vendor Bank Account".VALUE
        else
            BankAccount := '';
        PurchaseInvoice."Vendor Bank Account".ASSERTEQUALS(BankAccount);
        DocAmount := 0;
        VATAmount := 0;
        PurchLn.Reset();
        PurchLn.SetRange("Document Type", PurchLn."Document Type"::Invoice);
        PurchLn.SetRange("Document No.", PurchInvNo);
        if PurchLn.FindSet() then
            repeat
                DocAmount += PurchLn."Amount Including VAT";
                VATAmount += (PurchLn."Amount Including VAT" - PurchLn.Amount);
            until PurchLn.Next() = 0;

        //BC UPGRADE KUMARR78 >> DIT Variable Removed.("Doc. Amount Incl. VAT","Doc. Amount VAT")
        PurchaseInvoice."Doc. Amount Incl. VAT IBM".SETVALUE(DocAmount);
        PurchaseInvoice."Doc. Amount VAT IBM".SETVALUE(VATAmount);
        //BC UPGRADE KUMARR78 << DIT Variable Removed.("Doc. Amount Incl. VAT","Doc. Amount VAT")

        //HEI.09>>
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Approval Process
        //Disable Workflows before Release
        PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, PurchaseInvoice."No.".VALUE);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            //IF Workflow.FINDSET THEN
            //REPEAT
            //Workflow.Enabled := FALSE;
            //Workflow.MODIFY;
            //UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;

        // PurchaseInvoice.Action120.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseInvoice."Re&lease".INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name
        //HEI.09<<
        PurchaseInvoice.Post.INVOKE;

        PostedPurchInvHdr.SetRange("Pre-Assigned No.", PurchInvNo);
        if PostedPurchInvHdr.FindFirst() then
            StorePostedInvNo := PostedPurchInvHdr."No.";

        PostedPurchInv.OpenView();
        PostedPurchInv.Filter.SetFilter("No.", StorePostedInvNo);
        PostedPurchInv."Payment Status".ASSERTEQUALS(paymentstatus::"Pending Review");
        //HEI.01<<
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler,MessageHandler,GetRetShipmentLineModalPageHandler,WhseShipmentPageHandler,ShipInvoiceStrMenuHandler,ItemTrackingLinesModalPageHandler,WhseRcptPageHandler,GetReceiptLineModalPageHandler,DimSetEntriesModalPageHandler')]
    procedure RT_PTP011_ProcessPOCreditMemo();
    var
        Bin: Record Bin;
        BinContent: Record "Bin Content";
        DimensionValue1: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Item: Record Item;
        Location: Record Location;
        PurchaseLine: Record "Purchase Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        RetShipmentHdr: Record "Return Shipment Header";
        Vendor: Record Vendor;
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        Zone: Record Zone;
        WhseShipmentNo: Code[20];
        ItemTrackingQtyBase: Decimal;
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        GetReturnShipmentLines: TestPage "Get Return Shipment Lines";
        PurchaseCrMemo: TestPage "Purchase Credit Memo";
        PurchaseCrMemoList: TestPage "Purchase Credit Memos";
        PurchaseReturnOrder: TestPage "Purchase Return Order";
        PurchaseReturnOrderList: TestPage "Purchase Return Order List";
        WarehouseShipment: TestPage "Warehouse Shipment";
    begin
        DimensionRestrictionCheck;//HEI.95
        WarehouseShipmentHeader.DeleteAll();//HEI.38
        //HEI.01>>
        RT_PTP010_ProcessPOInvoice; //HEI.14
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP011', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP011', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP011', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP011', CompanyName, Database::"Lot No. Information");
        LotNoFilter := UnitTestingValues.Value;
        //create Ret Order against that posted warehse rcpt
        //PurchaseReturnOrderList.OPENNEW;
        //HEI.26>>
        PurchasesPayablesSetup.Get();
        if PurchasesPayablesSetup."Exact Cost Reversing Mandatory" = true then begin
            PurchasesPayablesSetup."Exact Cost Reversing Mandatory" := false;
            PurchasesPayablesSetup.Modify();
        end;
        //HEI.26<<
        PurchaseReturnOrder.OpenNew();
        //PurchaseReturnOrder.NEW;
        PurchaseReturnOrder."No.".AssistEdit();
        PurchaseReturnOrder."Buy-from Vendor Name".SetValue(Vendor."No.");
        PurchaseReturnOrder."Vendor Cr. Memo No.".SetValue('StP PTP011');
        //HEI.43>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseReturnOrder."Location Code".SetValue(Location.Code);
        //HEI.43<<
        PurchaseReturnOrder.PurchLines.New();
        PurchaseReturnOrder.PurchLines.Type.SetValue(Type::Item);
        PurchaseReturnOrder.PurchLines."No.".SetValue(Item."No.");
        PurchaseReturnOrder.PurchLines.Quantity.SetValue(1);
        PurchRetOrderNo := PurchaseReturnOrder."No.".Value;
        PurchaseReturnOrder.PurchLines."Location Code".SetValue(Location.Code);
        //HEI.44>>
        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP010', CompanyName, Database::"Dimension Value");
        if UnitTestingValues.Value <> '' then
            DimensionValue1.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues."Value 2");
        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue1.Code); //HEI.44
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue1.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", PurchaseReturnOrder."No.".Value);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::"Return Order");
        PurchaseLine.SetRange("No.", PurchaseReturnOrder.PurchLines."No.".Value);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue1.Code);
            PurchaseLine.Modify();
        end;
        //HEI.44<<
        // PurchaseReturnOrder.Release.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseReturnOrder."Re&lease".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name


        //Create warehouse shipment
        // PurchaseReturnOrder.Action93.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseReturnOrder."Create &Warehouse Shipment".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

        //Open warehouse shipment page
        WarehouseShipment.OpenView();
        WarehouseShipment.Filter.SetFilter("Source No. FND", PurchaseReturnOrder."No.".Value);
        //HEI.19 >>
        if Location."Receipt Bin Code" = '' then begin
            BinContent.Reset();
            BinContent.SetRange("Item No.", Item."No.");
            BinContent.SetRange("Location Code", Location.Code);
            BinContent.SetFilter(Quantity, '<>%1', 0);
            BinContent.SetRange(Default, true);
            if BinContent.FindFirst() then begin
                //HEI.24>>
                // WarehouseShipment.WhseShptLines."Zone Code".SETVALUE(BinContent."Zone Code");
                // WarehouseShipment.WhseShptLines."Bin Code".SETVALUE(BinContent."Bin Code");
                WarehouseShipmentLine.Reset();
                WarehouseShipmentLine.SetRange("No.", WarehouseShipment."No.".Value);
                WarehouseShipmentLine.SetRange("Item No.", WarehouseShipment.WhseShptLines."Item No.".Value);
                if WarehouseShipmentLine.FindFirst() then begin
                    WarehouseShipmentLine.Validate("Zone Code", BinContent."Zone Code");
                    WarehouseShipmentLine.Validate("Bin Code", BinContent."Bin Code");
                    WarehouseShipmentLine.Modify();
                end;
                //HEI.24<<
            end;
        end
        else begin
            if Bin.Get(Location.Code, Location."Receipt Bin Code") then begin
                //HEI.24
                //WarehouseShipment.WhseShptLines."Zone Code".SETVALUE(Bin."Zone Code");
                //WarehouseShipment.WhseShptLines."Bin Code".SETVALUE(Bin.Code);
                WarehouseShipmentLine.Reset();
                WarehouseShipmentLine.SetRange("No.", WarehouseShipment."No.".Value);
                WarehouseShipmentLine.SetRange("Item No.", WarehouseShipment.WhseShptLines."Item No.".Value);
                if WarehouseShipmentLine.FindFirst() then begin
                    WarehouseShipmentLine.Validate("Zone Code", Bin."Zone Code");
                    WarehouseShipmentLine.Validate("Bin Code", Bin.Code);
                    WarehouseShipmentLine.Modify();
                end;
                //HEI.24<<
            end;
        end;
        //HEI.19 <<
        //Store the PO No in warehouse receipt
        WhseShipmentNo := WarehouseShipment."Source No.".Value;
        //HEI.26>>
        if Location."Purchase Gate Entry Mandat FND" = true then begin
            Location."Purchase Gate Entry Mandat FND" := false;
            Location.Modify();
        end;
        if Zone.Get(Location.Code, Location."Shipment Bin Code") then
            if Zone."Sales Gate Entry Mandatory FND" = true then begin
                Zone."Sales Gate Entry Mandatory FND" := false;
                Zone.Modify();
            end;
        //HEI.26<<
        //
        //Step 4 - Create Warehouse Shipment document and fill all required information
        // WarehouseShipment.TRAP;
        // PurchaseReturnOrder.Action93.INVOKE;
        // WarehouseShipment.Action1100076703.INVOKE; //Auto FEFO
        ItemTrackingQtyBase := 1;
        WarehouseShipment.WhseShptLines.ItemTrackingLines.Invoke();

        // WarehouseShipment.Action45.INVOKE;//BC UPGRADE KUMARR78 Blocking to Change Action.
        WarehouseShipment."Re&lease".Invoke();//BC UPGRADE KUMARR78 Adding with Changed Action Name

        //Post The warehouse receipt

        // WarehouseShipment.Action25.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changes From Action25 To "P&ost Shipment"
        WarehouseShipment."P&ost Shipment".Invoke();//BC UPGRADE KUMARR78 Adding As Action Name Changes From Action25 To "P&ost Shipment"

        //Get the posted Ret Order No.
        RetShipmentHdr.Reset();
        RetShipmentHdr.SetRange("Return Order No.", PurchRetOrderNo);
        if RetShipmentHdr.FindFirst() then
            PostedReturnOrderNo := RetShipmentHdr."No.";

        //For Credit Memo processing
        //PurchaseCrMemoList.OPENNEW;
        PurchaseCrMemo.OpenNew();
        //PurchaseCrMemo.NEW;
        PurchaseCrMemo."No.".AssistEdit();
        PurchaseCrMemo."Buy-from Vendor Name".SetValue(Vendor."No.");
        PurchaseCrMemo."Vendor Cr. Memo No.".SetValue('StP PTP011');
        PurchCrMemoNo := PurchaseCrMemo."No.".Value;

        //Go to Lines/Functions tab and click Get Return Shipment Line
        PurchaseCrMemo.PurchLines.GetReturnShipmentLines.Invoke();
        PurchaseCrMemo.OK().Invoke();
        //HEI.01<<
    end;

    [ModalPageHandler]
    procedure GetRetShipmentLineModalPageHandler(var GetReturnShipmentLines: TestPage "Get Return Shipment Lines");
    var
        PurchaseReceiptLine: Record "Purch. Rcpt. Line";
        Vendor: Record Vendor;
    begin
        //GetReturnShipmentLines.FINDFIRSTFIELD("Document No.",PostedReturnOrderNo);
        GetReturnShipmentLines.Filter.SetFilter("Document No.", PostedReturnOrderNo);
        GetReturnShipmentLines.OK().Invoke();
    end;

    [StrMenuHandler]
    procedure ShipInvoiceStrMenuHandler(Option: Text[1024]; var Choice: Integer; Instruction: Text[1024]);
    begin
    end;

    [PageHandler]
    procedure WhseShipmentPageHandler(var WarehouseShipment: Page "Warehouse Shipment");
    begin
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler,MessageHandler,WhseRcptPageHandler,ItemTrackingLinesModalPageHandler')]
    procedure "RT_LOG026_Create&ReleaseWarehouseReceipt"();
    var
        Bin: Record Bin;
        DimensionValue1: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Item: Record Item;
        lLocation: Record Location;
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        PurchaseLine: Record "Purchase Line";
        PurchLn: Record "Purchase Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Vendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        lLocationCode: Code[10];
        PurchInvNo: Code[20];
        WhseRcptPONo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        GetReceiptLines: TestPage "Get Receipt Lines";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseInvList: TestPage "PO Purchase Invoices";
        PurchaseOrder: TestPage "Purchase Order";
        PurchaseOrderList: TestPage "Purchase Orders";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        Workflow: Record Workflow;
        RecZone: Record Zone;
        WhseEmpDTW: record 50356;
        WarRecLin: Record "Warehouse Receipt Line";
        WarEmployee: Record "Warehouse Employee";
        WhseDocNo: code[20];
    begin
        DimensionRestrictionCheck;//HEI.95
        WarehouseReceiptHeader.DeleteAll();//HEI.36
        UnitTestingValues.Reset();
        UnitTestingValues.Get('LOG026', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('LOG026', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('LOG026', CompanyName, Database::"Lot No. Information");
        LotNoFilter := UnitTestingValues.Value;

        UnitTestingValues.Reset();
        UnitTestingValues.Get('LOG026', CompanyName, Database::Location);
        lLocation.Get(UnitTestingValues.Value);
        //HEI.61>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('LOG026', CompanyName, Database::Bin);
        Bin.Get(lLocation.Code, UnitTestingValues.Value);
        //HEI.61<<
        //Create a PO
        PurchaseOrderList.OpenNew();
        PurchaseOrder.OpenNew();
        PurchaseOrder.New();
        PurchaseOrder."No.".AssistEdit();
        PurchaseOrder."Buy-from Vendor No.".SetValue(Vendor."No.");
        PurchaseOrder."Vendor Invoice No.".SetValue('StP Unit Test LOG026');
        //HEI.43>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseOrder."Location Code".SetValue(lLocation.Code);
        //HEI.43<<
        //HEI.12>>
        PnPSetup.Get();
        if PnPSetup."Requester ID Mandatory FND" then; //BC UPGRADE KUMARR78 Adding Semicolon(;) to handle the Condition.
        // PurchaseOrder."Requester ID".SETVALUE(USERID);//BC UPGRADE KUMARR78 DIT Field Removed.
        //HEI.12<<
        PurchaseOrder.PurchLines.New();
        PurchaseOrder.PurchLines.Type.SetValue(Type::Item);
        PurchaseOrder.PurchLines."No.".SetValue(Item."No.");
        PurchaseOrder.PurchLines."Location Code".SetValue(lLocation.Code);
        PurchaseOrder.PurchLines.Quantity.SetValue(1);
        //HEI.44>>
        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP010', CompanyName, Database::"Dimension Value");
        if UnitTestingValues."Value 2" <> '' then
            DimensionValue1.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues."Value 2");
        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue1.Code); //HEI.44
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue1.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", PurchaseOrder."No.".Value);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("No.", PurchaseOrder.PurchLines."No.".Value);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue1.Code);
            PurchaseLine.Validate("Bin Code", Bin.Code);//HEI.61
            PurchaseLine.Modify();
        end;
        //HEI.44<<
        //TEMP-AB-130122
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Approval Process
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            // IF Workflow.FINDSET THEN
            // REPEAT
            // Workflow.Enabled := FALSE;
            // Workflow.MODIFY;
            // UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;

        //TEMP-AB-130122
        PurchaseOrder.Release.Invoke();
        // BC Upgrade BHARDA11 >>
        Reczone.reset;
        Reczone.setrange("Location Code", lLocation.code);
        reczone.findfirst();
        WhseEmpDTW.init();
        WhseEmpDTW."User ID" := userid;
        WhseEmpDTW."location Code" := lLocation.code;
        WhseEmpDTW."zone Code" := RecZone.Code;
        if WhseEmpDTW.insert() then;
        // error(Reczone.code);
        //
        Bin.reset();
        Bin.SetRange("Zone Code", RecZone.code);
        bin.findfirst();
        WarEmployee.init();
        WarEmployee."User ID" := userid;
        waremployee."location Code" := lLocation.code;
        if WarEmployee.insert() then;
        // BC Upgrade BHARDA11 <<
        // PurchaseOrder.Action149.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseOrder."Create &Whse. Receipt".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name


        WarehouseReceipt.OpenView();
        WarehouseReceipt.Filter.SetFilter("Source No. FND", PurchaseOrder."No.".Value);

        //Store the PO No in warehouse receipt
        WhseRcptPONo := WarehouseReceipt."Source No.".Value;
        WhseDocNo := WarehouseReceipt."No.".value; // BC Upgrade BHARDA11
                                                   // BC Upgrade BHARDA11 

        WarRecLin.reset();
        WarRecLin.SetRange("No.", WhseDocNo);
        WarRecLin.findset();
        WarRecLin.Validate("Zone Code", RecZone.Code);
        WarRecLin.Validate("Bin Code", Bin.Code);
        WarRecLin.modify();

        // BC Upgrade BHARDA11 
        //Select Item Tracking Code
        WarehouseReceipt.WhseReceiptLines.ItemTrackingLines.Invoke();


        WarehouseReceipt."Post Receipt".Invoke();
        PurchaseOrder.OK().Invoke();
        PurchaseOrderList.OK().Invoke();
    end;

    [ModalPageHandler]

    // procedure NoSeriesListModalPageHandlerAB(var NoSeriesList: Page 571; var Response: Action); //BC UPGRADE KUMARR78 Blocking As Page Variable removed.
    procedure NoSeriesListModalPageHandlerAB(var NoSeriesList: Page "No. Series"; var Response: Action);//BC UPGRADE KUMARR78 Adding As Page Variable removed and Using No. Series.
    begin
        Response := Action::LookupOK;
    end;

    [ModalPageHandler]
    procedure GetReceiptLineModalPageHandlerAB(var GetReceiptLines: TestPage "Get Receipt Lines");
    var
        PurchaseReceiptLine: Record "Purch. Rcpt. Line";
        Vendor: Record Vendor;
    begin
        //GetReceiptLines.FINDFIRSTFIELD("Document No.",DocNo);
        GetReceiptLines.Filter.SetFilter("Document No.", DocNo);
        GetReceiptLines.OK().Invoke();
    end;

    [ConfirmHandler]
    procedure ConfirmationHandlerAB(Question: Text[1024]; var Reply: Boolean);
    var
        CreateOrderQst: TextConst ENU = 'Do you want to create an order from the blanket order?', FRA = 'Souhaitez-vous transformer la commande ouverte en commande ?';
        DocumentNotPostedClosePageQst: TextConst ENU = 'The document has not been posted.\Are you sure you want to exit?', FRA = 'Le document n''a pas été validé.\Voulez-vous vraiment quitter ?';
        PostDocumentQst: TextConst ENU = 'Do you want to post the %1?', FRA = 'Souhaitez-vous valider le document %1 ?';
        PostJnlLineQst: TextConst ENU = 'Do you want to post the journal lines?', FRA = 'Souhaitez-vous valider les lignes de la feuille ?';
        PostReceiptQst: TextConst ENU = 'Do you want to post the receipt?', FRA = 'Souhaitez-vous valider cette réception ?';
        ReceiveQst: TextConst ENU = 'Do you want to receive the %1 ?', FRA = 'Voulez-vous réceptionner le %1 ?';
    begin
        if (Question = DocumentNotPostedClosePageQst) or
           (Question = PostReceiptQst) or
           (Question = PostDocumentQst) or
           (Question = PostJnlLineQst) or
           (Question = CreateOrderQst) or
           (Question = ReceiveQst)
        then
            Reply := true;
    end;

    [MessageHandler]
    procedure MessageHandlerAB(Message: Text[1024]);
    begin
    end;

    [PageHandler]
    procedure WhseRcptPageHandlerAB(var WarehouseReceipt: Page "Warehouse Receipt");
    begin
    end;

    [ModalPageHandler]
    procedure ItemTrackingLinesModalPageHandlerAB(var ItemTrackingLines: TestPage "Item Tracking Lines");
    var
        TrackingSpecification: Record "Tracking Specification" temporary;
    begin
        ItemTrackingLines."Lot No.".SetValue(LotNoFilter);
        ItemTrackingLines."Quantity (Base)".SetValue(1);
        ItemTrackingLines.OK().Invoke();
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler')]//MessageHandler_PCN027
    // [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler,MessageHandler_PCN027')]
    procedure RT_PCN024_ReleasePO();
    var
        Bin: Record Bin;
        Item: Record Item;
        Location: Record Location;
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        PurchaseLine: Record "Purchase Line";
        PurchLn: Record "Purchase Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Vendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        PurchInvNo: Code[20];
        WhseRcptPONo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        GetReceiptLines: TestPage "Get Receipt Lines";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseInvList: TestPage "PO Purchase Invoices";
        PurchaseOrder: TestPage "Purchase Order";
        PurchaseOrderList: TestPage "Purchase Orders";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        Workflow: Record Workflow;
    begin
        DimensionRestrictionCheck;//HEI.95
        //Picking Vendor No.
        UnitTestingValues.Reset();
        UnitTestingValues.Get('LOG026', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        //Picking Item No.
        UnitTestingValues.Reset();
        UnitTestingValues.Get('LOG026', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);

        //HEI.42>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('LOG026', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);
        //HEI.42<<
        //Creation of PO
        ////Header Part
        PurchaseOrderList.OpenNew();
        PurchaseOrder.OpenNew();
        PurchaseOrder.New();
        PurchaseOrder."No.".AssistEdit();
        PurchOrdNo := PurchaseOrder."No.".Value;
        PurchaseOrder."Buy-from Vendor No.".SetValue(Vendor."No.");
        PurchaseOrder."Vendor Invoice No.".SetValue('StP Unit Test PCN024');

        PurchaseOrder."Requester ID".SETVALUE(USERID);//BC UPGRADE KUMARR78 DIT Field Removed. // BC Upgrade BHARDA11
        //HEI.43>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseOrder."Location Code".SetValue(Location.Code);
        //HEI.43<<
        ////Line Part
        PurchaseOrder.PurchLines.New();
        PurchaseOrder.PurchLines.Type.SetValue(Type::Item);
        PurchaseOrder.PurchLines."No.".SetValue(Item."No.");
        PurchaseOrder.PurchLines."Location Code".SetValue(Location.Code);//HEI.42
        PurchaseOrder.PurchLines.Quantity.SetValue(1);
        //Closing PO Document
        PurchaseOrder.OK().Invoke(); //Abhay
        //Closing PO List Page
        PurchaseOrderList.OK().Invoke();
        PurchaseOrderList.OpenView();
        PurchaseOrderList.Filter.SetFilter("No.", PurchOrdNo);
        PurchaseOrder.close();
        PurchaseOrder.OpenEdit(); //Abhay
        PurchaseOrder.Filter.SetFilter("No.", PurchOrdNo);//HEI.42 // BC Upgrade PATELS08
                                                          //
                                                          //TEMP-AB-130122
                                                          // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Approval Process
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            // IF Workflow.FINDSET THEN
            // REPEAT
            // Workflow.Enabled := FALSE;
            // Workflow.MODIFY;
            // UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;

        //TEMP-AB-130122

        //
        PurchaseOrder.Release.Invoke();

        //Closing PO Document
        // PurchaseOrder.OK().Invoke(); // BC UPGRADE PATELS08
        //Closing PO List Page
        PurchaseOrderList.OK().Invoke();
    end;


    [Test]
    [HandlerFunctions('SuggestVendorPayment_RequestPageHandler')]
    procedure "RT_PTP061-CreatePaymentProposal"();
    var
        Item: Record Item;
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        PurchLn: Record "Purchase Line";
        Vendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        PurchInvNo: Code[20];
        WhseRcptPONo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        GetReceiptLines: TestPage "Get Receipt Lines";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        PayJnlTree: TestPage "Payment Journal Tree CBN";
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseInvList: TestPage "PO Purchase Invoices";
        PurchaseOrder: TestPage "Purchase Order";
        PurchaseOrderList: TestPage "Purchase Orders";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        gGenJnlBatches: Record "Gen. Journal Batch";
    begin
        DimensionRestrictionCheck;//HEI.95
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP061', CompanyName, Database::"Gen. Journal Batch"); //Abhay
        gGenJnlBatches.Get(UnitTestingValues.Value, UnitTestingValues."Value 2");

        VendLedgEntry.Reset();
        VendLedgEntry.SetRange("Document Type", VendLedgEntry."Document Type"::Invoice);
        VendLedgEntry.SetRange(Open, true);
        if VendLedgEntry.FindFirst() then begin
            InvNo := VendLedgEntry."Document No.";
        end;

        PayJnlTree.OpenEdit();
        PayJnlTree.CurrentJnlBatchName.SetValue(gGenJnlBatches.Name);
        PayJnlTree.SuggestVendorPayments.Invoke();
    end;

    [Test]
    [HandlerFunctions('SuggestVendorPayment_RequestPageHandler,AVEModalPageHandler,NavigatePageHandler,MessageHandler')]
    procedure "RT_PTP067_Review&SendPaymentProposal"();
    var
        lGenJnlLine: Record "Gen. Journal Line";
        Item: Record Item;
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        PurchLn: Record "Purchase Line";
        Vendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        lVendLedgEntries: Record "Vendor Ledger Entry";
        BlankFilter: Code[10];
        PurchInvNo: Code[20];
        WhseRcptPONo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ApplyVendorEntries: TestPage "Apply Vendor Entries";
        ApprovalEntries: TestPage "Approval Entries";
        GetReceiptLines: TestPage "Get Receipt Lines";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        NavigatePage: TestPage Navigate;
        PayJnlTree: TestPage "Payment Journal Tree CBN";
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseInvList: TestPage "PO Purchase Invoices";
        PostedPI: TestPage "Posted Sales Invoice";
        PurchaseOrder: TestPage "Purchase Order";
        PurchaseOrderList: TestPage "Purchase Orders";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        gGenJnlBatches: Record "Gen. Journal Batch";
    begin
        DimensionRestrictionCheck;//HEI.95
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP067', CompanyName, Database::"Gen. Journal Batch"); //Abhay
        gGenJnlBatches.Get(UnitTestingValues.Value, UnitTestingValues."Value 2");

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP067', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);



        VendLedgEntry.Reset();
        VendLedgEntry.SetRange("Vendor No.", Vendor."No.");
        VendLedgEntry.SetRange("Document Type", VendLedgEntry."Document Type"::Invoice);
        VendLedgEntry.SetRange(Open, true);
        if VendLedgEntry.FindFirst() then begin
            InvNo := VendLedgEntry."Document No.";
        end;

        PayJnlTree.OpenEdit();
        PayJnlTree.CurrentJnlBatchName.SetValue(gGenJnlBatches.Name);
        PayJnlTree.SuggestVendorPayments.Invoke();
        BlankFilter := '';
        lGenJnlLine.Reset();
        lGenJnlLine.SetRange("Journal Template Name", gGenJnlBatches."Journal Template Name");
        lGenJnlLine.SetRange("Journal Batch Name", gGenJnlBatches.Name);
        lGenJnlLine.SetFilter("Applies-to Doc. No.", '<>%1', '');
        if lGenJnlLine.FindFirst() then begin
            ApplDocNo := lGenJnlLine."Applies-to Doc. No.";
            PayJnlTree.Expand(true);
            PayJnlTree.Filter.SetFilter("Applies-to Doc. No.", ApplDocNo);


            //PayJnlTree.NEXT;
            PayJnlTree."Applies-to Doc. No.".Lookup();
            /*ApplyVendorEntries.Navigate.INVOKE;
            NavigatePage.FILTER.SETFILTER("Table ID",'122');
            NavigatePage."No. of Records".ASSISTEDIT;
            PostedPI.OK.INVOKE;
            NavigatePage.OK.INVOKE;
            ApplyVendorEntries.OK.INVOKE;*/
        end;
        //PayJnlTree.SendApprovalRequestJournalBatch.INVOKE;
        //PayJnlTree.Approvals.INVOKE;

    end;

    [Test]
    [HandlerFunctions('SuggestVendorPayment_RequestPageHandler,AVEModalPageHandler,NavigatePageHandler,MessageHandler')]
    procedure RT_PTP069_ApprovePaymentProposalL1();
    var
        lGenJnl: Record "Gen. Journal Line";
        lGenJnlLine: Record "Gen. Journal Line";
        PayTreeGenJnl: Record "Gen. Journal Line";
        Item: Record Item;
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        PurchLn: Record "Purchase Line";
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        Vendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        PurchInvNo: Code[20];
        WhseRcptPONo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ApplyVendorEntries: TestPage "Apply Vendor Entries";
        ApprovalEntries: TestPage "Approval Entries";
        GetReceiptLines: TestPage "Get Receipt Lines";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        NavigatePage: TestPage Navigate;
        PayJnlTree: TestPage "Payment Journal Tree CBN";
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseInvList: TestPage "PO Purchase Invoices";
        PostedPI: TestPage "Posted Sales Invoice";
        PurchaseOrder: TestPage "Purchase Order";
        PurchaseOrderList: TestPage "Purchase Orders";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        gGenJnlBatches: Record "Gen. Journal Batch";
    begin
        DimensionRestrictionCheck;//HEI.95
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP069', CompanyName, Database::"Gen. Journal Batch"); //Abhay
        gGenJnlBatches.Get(UnitTestingValues.Value, UnitTestingValues."Value 2");

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP069', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);



        VendLedgEntry.Reset();
        VendLedgEntry.SetRange("Vendor No.", Vendor."No.");
        VendLedgEntry.SetRange("Document Type", VendLedgEntry."Document Type"::Invoice);
        VendLedgEntry.SetRange(Open, true);
        if VendLedgEntry.FindFirst() then begin
            InvNo := VendLedgEntry."Document No.";
        end;

        PayJnlTree.OpenEdit();
        PayJnlTree.CurrentJnlBatchName.SetValue(gGenJnlBatches.Name);
        PayJnlTree.SuggestVendorPayments.Invoke();
        lGenJnlLine.Reset();
        lGenJnlLine.SetRange("Journal Template Name", gGenJnlBatches."Journal Template Name");
        lGenJnlLine.SetRange("Journal Batch Name", gGenJnlBatches.Name);
        lGenJnlLine.SetFilter("Applies-to Doc. No.", '<>%1', '');
        if lGenJnlLine.FindFirst() then begin
            ApplDocNo := lGenJnlLine."Applies-to Doc. No.";
            PayJnlTree.Expand(true);
            PayJnlTree.Filter.SetFilter("Applies-to Doc. No.", ApplDocNo);


            //PayJnlTree.NEXT;
            PayJnlTree."Applies-to Doc. No.".Lookup();
            /*ApplyVendorEntries.Navigate.INVOKE;
            NavigatePage.FILTER.SETFILTER("Table ID",'122');
            NavigatePage."No. of Records".ASSISTEDIT;
            PostedPI.OK.INVOKE;
            NavigatePage.OK.INVOKE;
            ApplyVendorEntries.OK.INVOKE;*/
        end;


        PayTreeGenJnl.Reset();
        //lGenJnl.SETRANGE("Document Type",PayJnlTree."Document Type");
        PayTreeGenJnl.SetRange("Document No.", PayJnlTree."Document No.".Value);
        //IF ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(lGenJnl) THEN BEGIN
        if ApprovalsMgmt.IsGeneralJournalLineApprovalsWorkflowEnabled(PayTreeGenJnl) then begin
            PayJnlTree.SendApprovalRequestJournalBatch.Invoke();
            ApprovalEntries.Trap();
            PayJnlTree.Approvals.Invoke();

            //Update Substitute for Approver ID = USERID
            UserSetup.Get(ApprovalEntries."Approver ID".Value);
            UserSetup.Substitute := UserId;
            UserSetup.Modify();

            //Update Approval Limit for USERID

            //BC UPGRADE KUMARR78 >> DIT Variable Removed.("Unlimited Deposit Limit Cust.","Unlimited Cr. Limit Customer","Unlimited Overdue Approval")
            // UserSetup2.GET(USERID);
            // IF NOT UserSetup2."Unlimited Sales Approval" OR NOT UserSetup2."Unlimited Cr. Limit Customer" OR
            //    NOT UserSetup2."Unlimited Deposit Limit Cust." OR NOT UserSetup2."Unlimited Overdue Approval"
            // THEN BEGIN
            //     UserSetup2."Unlimited Sales Approval" := TRUE;
            //     UserSetup2."Unlimited Cr. Limit Customer" := TRUE;
            //     UserSetup2."Unlimited Deposit Limit Cust." := TRUE;
            //     UserSetup2."Unlimited Overdue Approval" := TRUE;
            //     UserSetup2.MODIFY;
            // END;
            //BC UPGRADE KUMARR78 << DIT Variable Removed.("Unlimited Deposit Limit Cust.","Unlimited Cr. Limit Customer","Unlimited Overdue Approval")

            //Delegate Approval Request

            // ApprovalEntries.Action35.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
            ApprovalEntries."&Delegate".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

            //Approve Approval Entry
            PayJnlTree.Approve.Invoke();
        end
        //ELSE
        //PayJnlTree.Release.INVOKE;
        /*
        SalesHeader.GET(SalesHeader."Document Type"::Order,SalesOrder."No.".VALUE);
        IF ApprovalsMgmt.IsSalesApprovalsWorkflowEnabled(SalesHeader) THEN BEGIN
          SalesOrder.SendApprovalRequest.INVOKE;
          ApprovalEntries.TRAP;
          SalesOrder.Approvals.INVOKE;

          //Update Substitute for Approver ID = USERID
          UserSetup.GET(ApprovalEntries."Approver ID".VALUE);
          UserSetup.Substitute := USERID;
          UserSetup.MODIFY;

          //Update Approval Limit for USERID
          UserSetup2.GET(USERID);
          IF NOT UserSetup2."Unlimited Sales Approval" OR NOT UserSetup2."Unlimited Cr. Limit Customer" OR
             NOT UserSetup2."Unlimited Deposit Limit Cust." OR NOT UserSetup2."Unlimited Overdue Approval"
          THEN BEGIN
            UserSetup2."Unlimited Sales Approval" := TRUE;
            UserSetup2."Unlimited Cr. Limit Customer" := TRUE;
            UserSetup2."Unlimited Deposit Limit Cust." := TRUE;
            UserSetup2."Unlimited Overdue Approval" := TRUE;
            UserSetup2.MODIFY;
          END;

          //Delegate Approval Request
          ApprovalEntries.Action35.INVOKE;

          //Approve Approval Entry
          SalesOrder.Approve.INVOKE;
        END ELSE
          SalesOrder.Release.INVOKE;
        */

    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,MessageHandler,DimSetEntriesModalPageHandlerPTP133')]
    procedure RT_PTP084_ProcessManualPayment();
    var
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlTable: Record "Gen. Journal Line";
        GenJournalLine: Record "Gen. Journal Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Item: Record Item;
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        PurchLn: Record "Purchase Line";
        RestrictedRecordL: Record "Restricted Record";
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        Vendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        PurchInvNo: Code[20];
        WhseRcptPONo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ApprovalEntries: TestPage "Approval Entries";
        GeneralJournalBatches: TestPage "General Journal Batches";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GetReceiptLines: TestPage "Get Receipt Lines";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseInvList: TestPage "PO Purchase Invoices";
        PurchaseOrder: TestPage "Purchase Order";
        PurchaseOrderList: TestPage "Purchase Orders";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        Workflow: Record Workflow;
        gGenJnlBatches: Record "Gen. Journal Batch";

    begin
        DimensionRestrictionCheck;//HEI.95
        Clear(GenJnlAccType);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP084', CompanyName, Database::Vendor);
        gVendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP084', CompanyName, Database::"G/L Account");
        gChartofAccount.Get(UnitTestingValues.Value);

        //HEI.26>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP084', CompanyName, Database::"Dimension Value");
        GeneralLedgerSetup.Get();
        DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 3 Code", UnitTestingValues.Value);
        Clear(MVMTDimension);
        MVMTDimension := DimensionValue.Code;
        //HEI.26<<
        // DefaultDim.RESET;
        // DefaultDim.SETRANGE("Table ID",15);
        // DefaultDim.SETRANGE("No.",gChartofAccount."No.");
        // DefaultDim.SETRANGE("Value Posting",DefaultDim."Value Posting"::"Code Mandatory");
        // IF DefaultDim.FINDSET THEN
        //  REPEAT
        //    DefaultDim."Value Posting" := DefaultDim."Value Posting"::" ";
        //    DefaultDim.MODIFY;
        //  UNTIL DefaultDim.NEXT = 0;
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP084', CompanyName, Database::"Gen. Journal Batch");
        gGenJnlBatches.Get(UnitTestingValues.Value, UnitTestingValues."Value 2");

        //GenJnlTable.GET(gGenJnlBatches."Journal Template Name",gGenJnlBatches.Name);
        //IF ApprovalsMgmt.IsGeneralJournalLineApprovalsWorkflowEnabled(GenJnlTable) THEN BEGIN
        Workflow.Reset();
        Workflow.SetRange(Enabled, true);
        //HEI.74>>
        //IF Workflow.FINDFIRST THEN //HEI.88
        Workflow.ModifyAll(Enabled, false);
        // IF Workflow.FINDSET THEN
        // REPEAT
        // Workflow.Enabled := FALSE;
        // Workflow.MODIFY;
        // UNTIL Workflow.NEXT = 0;
        //HEI.74<<

        //HEI.35>>
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", gGenJnlBatches."Journal Template Name");

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET as its being depreceted
        // if GenJournalLine.FindSet(false, false) then
        if GenJournalLine.FindSet(false) then
            // BC Upgrade MISHRS14 <<

            GenJournalLine.DeleteAll();
        //HEI.35<<
        //HEi.36>>
        GeneralJournalTemplates.OpenView();
        GeneralJournalBatches.Trap();
        GeneralJournalTemplates.Filter.SetFilter(Name, gGenJnlBatches."Journal Template Name");

        // GeneralJournalTemplates."Page General Journal Batches".INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        GeneralJournalTemplates.Batches.Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

        GeneralJournalBatches.Filter.SetFilter(Name, gGenJnlBatches.Name);
        GenJnl.Trap();
        GeneralJournalBatches.EditJournal.Invoke();
        //GenJnl.OPENEDIT;
        //HEi.36<<
        GenJnl.CurrentJnlBatchName.SetValue(gGenJnlBatches.Name);
        GenJnl."Posting Date".SetValue(Today);
        //GenJnl."Document Date".SETVALUE(TODAY);//HEI.24
        GenJnl."Document Type".SetValue(1);
        //GenJnl."External Document No.".SETVALUE('PTP084');//HEI.24
        GenJnl."Account Type".SetValue(2);
        GenJnl."Account No.".SetValue(gVendor."No.");
        GenJnl.Amount.SetValue('1000.00');
        GenJnl."Bal. Account Type".SetValue(0);
        GenJnl."Bal. Account No.".SetValue(gChartofAccount."No.");
        //HEI.24>>
        if GenJournalLine.Get(gGenJnlBatches."Journal Template Name", gGenJnlBatches.Name, GenJnl."Line No.".Value) then begin
            GenJournalLine.Validate("Document Date", Today);
            GenJournalLine.Validate("External Document No.", 'PTP084');
            GenJournalLine.Modify();
        end;
        //HEI.24<<
        /*
        GenJnlTable.GET(gGenJnlBatches."Journal Template Name",gGenJnlBatches.Name,10000);
        IF ApprovalsMgmt.IsGeneralJournalLineApprovalsWorkflowEnabled(GenJnlTable) THEN BEGIN
          GenJnl.SendApprovalRequestJournalLine.INVOKE;
          ApprovalEntries.TRAP;
          GenJnl.Approvals.INVOKE;

          //Update Substitute for Approver ID = USERID
          UserSetup.GET(ApprovalEntries."Approver ID".VALUE);
          UserSetup.Substitute := USERID;
          UserSetup.MODIFY;

          //Update Approval Limit for USERID
          UserSetup2.GET(USERID);
          IF NOT UserSetup2."Unlimited Sales Approval" OR NOT UserSetup2."Unlimited Cr. Limit Customer" OR
             NOT UserSetup2."Unlimited Deposit Limit Cust." OR NOT UserSetup2."Unlimited Overdue Approval"
          THEN BEGIN
            UserSetup2."Unlimited Sales Approval" := TRUE;
            UserSetup2."Unlimited Cr. Limit Customer" := TRUE;
            UserSetup2."Unlimited Deposit Limit Cust." := TRUE;
            UserSetup2."Unlimited Overdue Approval" := TRUE;
            UserSetup2.MODIFY;
          END;

          //Delegate Approval Request
          ApprovalEntries.Action35.INVOKE;

          //Approve Approval Entry
          GenJnl.Approve.INVOKE;
        END;*/
        //Disable Workflows before Release
        /*GenJnlTable.GET(gGenJnlBatches."Journal Template Name",gGenJnlBatches.Name,10000);
        IF ApprovalsMgmt.IsGeneralJournalLineApprovalsWorkflowEnabled(GenJnlTable) THEN BEGIN
          Workflow.SETRANGE(Enabled,TRUE);
          IF Workflow.FINDSET THEN
            REPEAT
              Workflow.Enabled := FALSE;
              Workflow.MODIFY(TRUE);
            UNTIL Workflow.NEXT = 0;
        END;*/
        /*GenJnlBatch.GET(UnitTestingValues.Value,UnitTestingValues."Value 2");
        IF ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJnlBatch) THEN BEGIN
          Workflow.SETRANGE(Enabled,TRUE);
          IF Workflow.FINDSET THEN
            REPEAT
              Workflow.Enabled := FALSE;
              Workflow.MODIFY;
            UNTIL Workflow.NEXT = 0;
        END;*/
        //HEI.54>>
        //HEI.65>>
        //IF UPPERCASE(COMPANYNAME) = UPPERCASE('10_SURIN_BROUWERIJ') THEN
        //MVMTDimension:='';
        //HEI.65<<
        //HEI.54<<
        //HEI.65>>
        if UpperCase(CompanyName) in [UpperCase('Bralirwa')] then
            MVMTDimension := '';
        //HEI.65<<
        GenJnl.Dimensions.Invoke();//HEI.26

        //HEI.108>>
        RestrictedRecordL.SetCurrentKey("Record ID");
        RestrictedRecordL.SetRange("Record ID", gGenJnlBatches.RecordId);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET as its being depreceted
        //if RestrictedRecordL.FindSet(false, false) then
        if RestrictedRecordL.FindSet(false) then
            // BC Upgrade MISHRS14 <<

            RestrictedRecordL.DeleteAll(true);

        RestrictedRecordL.Reset();
        RestrictedRecordL.SetCurrentKey("Record ID");
        RestrictedRecordL.SetRange("Record ID", GenJournalLine.RecordId);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET as its being depreceted
        //if RestrictedRecordL.FindSet(false, false) then
        if RestrictedRecordL.FindSet(false) then
            // BC Upgrade MISHRS14 <<

            RestrictedRecordL.DeleteAll(true);
        //HEI.108<<

        GenJnl.Post.Invoke();
        GenJnl.Close();//HEI.26

    end;

    [RequestPageHandler]
    procedure SuggestVendorPayment_RequestPageHandler(var SuggestVendorPayment: TestRequestPage "Suggest Vendor Payments");
    var
        Customer: Record Customer;
    begin
        SuggestVendorPayment.LastPaymentDate.SetValue(Today);
        SuggestVendorPayment.PostingDate.SetValue(Today);
        // SuggestVendorPayment.Control55001.SETVALUE(TODAY);//BC UPGRADE KUMARR78 CONF (ExecutionDate)
        SuggestVendorPayment.StartingDocumentNo.SetValue('Test001');
        // SuggestVendorPayment.VendorLedgerEntriesFilter.SETFILTER(SuggestVendorPayment.VendorLedgerEntriesFilter."Document No.", InvNo);//BC UPGRADE KUMARR78 CONF
        SuggestVendorPayment.OK().Invoke();
    end;

    [ModalPageHandler]
    procedure SelectGenJnlTemplatePageHandler(var GenJnlTemplateList: TestPage "General Journal Template List");
    var
        gGenJnlBatches: Record "Gen. Journal Batch";
    begin
        UnitTestingValues.Reset();
        //HEI.97>>
        //UnitTestingValues.GET('PTP084',COMPANYNAME,DATABASE::"Gen. Journal Batch");
        UnitTestingValues.Get('PTP136', CompanyName, Database::"Gen. Journal Batch");
        //HEI.97<<
        gGenJnlBatches.Get(UnitTestingValues.Value, UnitTestingValues."Value 2");
        //GenJnlTemplateList.FINDFIRSTFIELD(Name,UnitTestingValues.Value);
        GenJnlTemplateList.Filter.SetFilter(Name, UnitTestingValues.Value);
        GenJnlTemplateList.OK().Invoke();
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,ItemChargeAssignmentPurchModalPageHandler,PurReceiptLineModalPageHandler,MessageHandler,WhseRcptPageHandler,ItemTrackingLinesModalPageHandler')]
    procedure RT_PCN023_CreatePurchaseOrder();
    var
        Bin: Record Bin;
        DimensionValue: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        GLAccount: Record "G/L Account";
        GeneralLedgerSetup: Record "General Ledger Setup";
        GeneralPostingSetup: Record "General Posting Setup";
        Item: Record Item;
        "Item Charge": Record "Item Charge";
        Location: Record Location;
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PurchaseLine: Record "Purchase Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        UserSetup: Record "User Setup";
        Vendor: Record Vendor;
        WhseRcptPONo: Code[20];
        EBFErrText: Label 'Are you sure you want to post combination of account %1 with dimension %2';
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        EditDimensionSetEntries: TestPage "Edit Dimension Set Entries";
        GetReceiptLines1: TestPage "Get Receipt Lines";
        ItemChargeAssignmentPurch: TestPage "Item Charge Assignment (Purch)";
        GetReceiptLines: TestPage "Purch. Receipt Lines";
        PurchaseOrder: TestPage "Purchase Order";
        PurchaseOrder1: TestPage "Purchase Order";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrderList1: TestPage "Purchase Orders";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        Workflow: Record Workflow;
        RecZone: Record Zone;
        WhseEmpDTW: record 50356;
        WarRecLin: Record "Warehouse Receipt Line";
        WarEmployee: Record "Warehouse Employee";
        WhseDocNo: code[20];
    begin
        DimensionRestrictionCheck;//HEI.95
        //HEI.02
        WarehouseReceiptHeader.DeleteAll();//HEI.36
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::"Item Charge");
        "Item Charge".Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::"User Setup");
        UserSetup.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::Bin);
        Bin.Get(UnitTestingValues."Value 2", UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::"Lot No. Information");
        LotNoFilter := UnitTestingValues.Value;
        //HEI.40
        UnitTestingValues.Get('PCN023', CompanyName, Database::"Dimension Value");
        GeneralLedgerSetup.Get();
        if UnitTestingValues.Value <> '' then
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);
        //HEI.40
        //HEI.19>>
        Clear(EBFWarnConf);
        if GeneralPostingSetup.Get(Vendor."Gen. Bus. Posting Group", "Item Charge"."Gen. Prod. Posting Group") then
            EBFWarnConf := StrSubstNo(EBFErrText, GeneralPostingSetup."Purch. Account", Item."Global Dimension 2 Code");
        //HEI.19<<
        //LotNoFilter:='2C-AR';
        //Create a PO
        //PurchaseOrderList1.OPENNEW;
        PurchaseOrder1.OpenNew();
        //PurchaseOrder1.NEW;
        PurchaseOrder1."Buy-from Vendor No.".SetValue(Vendor."No.");
        PurchaseOrder1."Vendor Invoice No.".SetValue('StP Unit Test PCN023');
        // PurchaseOrder1."Requester ID".SETVALUE(UserSetup."User ID");//BC UPGRADE KUMARR78 DIT Field Removed.
        //HEI.43>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseOrder1."Location Code".SetValue(Location.Code);
        //HEI.43<<
        PurchaseOrder1.PurchLines.Type.SetValue(Type::Item);
        PurchaseOrder1.PurchLines."No.".SetValue(Item."No.");
        PurchaseOrder1.PurchLines.Quantity.SetValue(1);
        PurchaseOrder1.PurchLines."Location Code".SetValue(Location.Code);
        //HEI.24>>
        //PurchaseOrder1.PurchLines."Bin Code".SETVALUE(Bin.Code);
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("Document No.", PurchaseOrder1."No.".Value);
        PurchaseLine.SetRange("No.", PurchaseOrder1.PurchLines."No.".Value);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Bin Code", Bin.Code);
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);//HEI.40
            PurchaseLine.Modify();
        end;
        //HEI.24<<
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder1."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            // IF Workflow.FINDSET THEN
            // REPEAT
            // Workflow.Enabled := FALSE;
            // Workflow.MODIFY;
            // UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;
        //HEI.42>>
        if GeneralPostingSetup.Get(Vendor."Gen. Bus. Posting Group", Item."Gen. Prod. Posting Group") then
            if GLAccount.Get(GeneralPostingSetup."Purchase Variance Account") then
                if GLAccount.Blocked = true then begin
                    GLAccount.Blocked := false;
                    GLAccount.Modify();
                end;
        //HEI.42<<

        PurchaseOrder1.Release.Invoke();
        // BC Upgrade BHARDA11  >>
        Reczone.reset;
        Reczone.setrange("Location Code", Location.code);
        reczone.findfirst();
        WhseEmpDTW.init();
        WhseEmpDTW."User ID" := userid;
        WhseEmpDTW."location Code" := location.code;
        WhseEmpDTW."zone Code" := RecZone.Code;
        if WhseEmpDTW.insert() then;
        // error(Reczone.code);
        Bin.reset();
        Bin.SetRange("Zone Code", RecZone.code);
        bin.findfirst();
        WarEmployee.init();
        WarEmployee."User ID" := userid;
        waremployee."location Code" := location.code;
        if WarEmployee.insert() then;
        // BC Upgrade BHARDA11  <<
        // PurchaseOrder1.Action149.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseOrder1."Create &Whse. Receipt".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

        WarehouseReceipt.OpenView();
        WarehouseReceipt.Filter.SetFilter("Source No. FND", PurchaseOrder1."No.".Value);
        WhseDocNo := WarehouseReceipt."No.".value; // BC Upgrade BHARDA11
        //Store the PO No in warehouse receipt
        WhseRcptPONo := WarehouseReceipt."Source No.".Value;

        WarRecLin.reset();
        WarRecLin.SetRange("No.", WhseDocNo);
        WarRecLin.findset();
        WarRecLin.Validate("Zone Code", RecZone.Code);
        WarRecLin.Validate("Bin Code", Bin.Code);
        WarRecLin.modify();
        // WarRecLin.modifyall("Zone Code", RecZone.Code);
        // WarRecLin.modifyall("Bin Code", Bin.Code);
        // end;
        // WarehouseReceipt.WhseReceiptLines."Zone Code".setvalue(reczone.code);
        // WarehouseReceipt.WhseReceiptLines."Bin Code".setvalue(Bin.code);
        // BC Upgrade BHARDA11 
        //Select Item Tracking Code
        WarehouseReceipt.WhseReceiptLines.ItemTrackingLines.Invoke();

        //Post The warehouse receipt
        WarehouseReceipt."Post Receipt".Invoke();
        PurchaseOrder1.OK().Invoke();
        //PurchaseOrderList1.OK.INVOKE;

        PurchRcptHdr.SetRange("Order No.", WhseRcptPONo);
        if PurchRcptHdr.FindFirst() then
            DocNo := PurchRcptHdr."No.";

        //Step-3 created PO for charge item
        //PurchaseOrderList.OPENNEW;
        PurchaseOrder.OpenNew();
        //PurchaseOrder.NEW;
        PurchaseOrder."Buy-from Vendor No.".SetValue(Vendor."No.");
        PurchaseOrder."Vendor Invoice No.".SetValue('StP Unit Test PCN023');
        //HEI.45>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseOrder."Location Code".SetValue(Location.Code);
        //HEI.45<<
        // PurchaseOrder."Requester ID".SETVALUE(UserSetup."User ID");//BC UPGRADE KUMARR78 DIT Field Removed.
        PurchaseOrder.PurchLines.Type.SetValue(Type::"Charge (Item)");
        PurchaseOrder.PurchLines."No.".SetValue("Item Charge"."No.");
        PurchaseOrder.PurchLines.Quantity.SetValue(1);
        //PurchaseOrder.PurchLines."Qty. to Receive".SETVALUE(1);//HEI.24
        PurchaseOrder.PurchLines."Direct Unit Cost".SetValue(100);
        //HEI.24>>
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("Document No.", PurchaseOrder."No.".Value);
        PurchaseLine.SetRange("No.", PurchaseOrder.PurchLines."No.".Value);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Qty. to Receive", 1);
            PurchaseLine.Modify();
            //HEI.47>>
            if PurchaseLine."Shortcut Dimension 2 Code" <> '' then begin
                EbfCombination.Reset();
                EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
                EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
                //HEI.78>>
                //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue.Code); //HEI.44
                //HEI.84>>
                //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
                //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
                //HEI.84<<
                //HEI.78<<
                EbfCombination.DeleteAll();
            end;
            //HEI.47<<
        end;
        //HEI.24<<
        //PurchaseOrder.PurchLines."Direct Unit Cost".SETVALUE(100);
        //Step-4 Click Line - Item charge Assingment
        PurchaseOrder.PurchLines.ItemChargeAssignment.Invoke();
        //Step-8 Release and post PO
        PurchaseOrder.Release.Invoke();
        PurchaseOrder.Post.Invoke();

        // PurchaseOrder."Page Posted Purchase Receipts".INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseOrder.Receipts.Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

        PurchRcptHeader.SetRange("Order No.", PurchaseOrder."No.".Value);
        if PurchRcptHeader.FindFirst() then
            RecNo := PurchRcptHeader."No.";
        //HEI.02
    end;

    [ModalPageHandler]
    procedure ItemChargeAssignmentPurchModalPageHandler(var ItemChargeAssignmentPurch: TestPage "Item Charge Assignment (Purch)");
    var
        Vendor: Record Vendor;
        GetReceiptLines: TestPage "Purch. Receipt Lines";
    begin
        ItemChargeAssignmentPurch.GetReceiptLines.Invoke();
        GetReceiptLines.OpenView();
        ItemChargeAssignmentPurch.SuggestItemChargeAssignment.Invoke();
        ItemChargeAssignmentPurch.OK().Invoke();
    end;

    [ModalPageHandler]
    procedure ItemTrackingLinesModalPageHandlerSS(var ItemTrackingLines: TestPage "Item Tracking Lines");
    var
        TrackingSpecification: Record "Tracking Specification" temporary;
    begin
        ItemTrackingLines."Assign Lot No.".Invoke();
        ItemTrackingLines."Quantity (Base)".SetValue(1);
        ItemTrackingLines.OK().Invoke();
    end;

    [ModalPageHandler]
    procedure PurReceiptLineModalPageHandler(var GetReceiptLines: TestPage "Purch. Receipt Lines");
    begin
        //GetReceiptLines.FINDFIRSTFIELD("Document No.",DocNo);
        GetReceiptLines.Filter.SetFilter("Document No.", DocNo);
        GetReceiptLines.OK().Invoke();
    end;

    [Test]
    procedure RT_PTP015_CreateNPOCreditNote();
    var
        "G/L Account": Record "G/L Account";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        "VAT Product Posting Group": Record "VAT Product Posting Group";
        Vendor: Record Vendor;
        "WHT Business Posting Group FND": Record "WHT Business Posting Group FND";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        NPOPurchaseCreditMemo: TestPage "NPO Purchase Credit Memo";
        NPOPurchaseCreditMemosList: TestPage "NPO Purchase Credit Memos";
        PostedPurchaseCreditMemos: TestPage "Posted Purchase Credit Memos";
        DocNo: Text;
        PostedCrNo: Text;
        // DateChangeError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''You cannot modify the field- ''Due Date''.  (Select Refresh to discard errors)''';
        DateChangeError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''"You cannot modify the field- ''Due Date''. " (Select Refresh to discard errors)'''; // BC Upgrade BHARDA11
        PaymentMethodCodeError: TextConst ENU = 'Validation error for Field: Payment Method Code,  Message = ''You cannot modify the field- ''Payment Method Code''.  (Select Refresh to discard errors)''';
        // PaymentTermCodeError: TextConst ENU = 'Validation error for Field: Payment Terms Code,  Message = ''You cannot modify the field- ''Payment Terms Code''.  (Select Refresh to discard errors)''';
        PaymentTermCodeError: TextConst ENU = 'Validation error for Field: Payment Terms Code,  Message = ''"You cannot modify the field- ''Payment Terms Code''. " (Select Refresh to discard errors)''';
    begin
        DimensionRestrictionCheck;//HEI.95
        //HEI.02
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP015', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP015', CompanyName, Database::"WHT Business Posting Group FND");
        "WHT Business Posting Group FND".Get(UnitTestingValues.Value);
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP015', CompanyName, Database::"G/L Account");
        "G/L Account".Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP015', CompanyName, Database::"VAT Product Posting Group");
        "VAT Product Posting Group".Get(UnitTestingValues.Value);

        //NPOPurchaseCreditMemosList.OPENNEW;
        NPOPurchaseCreditMemo.OPENNEW;
        //NPOPurchaseCreditMemo.NEW;
        NPOPurchaseCreditMemo."Buy-from Vendor Name".SETVALUE(Vendor.Name);
        NPOPurchaseCreditMemo."Vendor Cr. Memo No.".SETVALUE('PTP015');
        if Vendor."Preferred Bank Account Code" = '' then //HEI.31
            NPOPurchaseCreditMemo."Payment Method Code".SETVALUE(Vendor."Payment Method Code");
        NPOPurchaseCreditMemo."Payment Terms Code".SETVALUE(Vendor."Payment Terms Code");
        NPOPurchaseCreditMemo.PurchLines.Type.SETVALUE(Type::"G/L Account");
        NPOPurchaseCreditMemo.PurchLines."No.".SETVALUE("G/L Account"."No.");
        NPOPurchaseCreditMemo.PurchLines.Quantity.SETVALUE(1);
        NPOPurchaseCreditMemo.PurchLines."Direct Unit Cost".SETVALUE(100);
        //HEI.24>>
        //NPOPurchaseCreditMemo.PurchLines."VAT Prod. Posting Group".SETVALUE("VAT Product Posting Group".Code);
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::"Credit Memo");
        PurchaseLine.SETRANGE("Document No.", NPOPurchaseCreditMemo."No.".VALUE);
        PurchaseLine.SETRANGE("No.", NPOPurchaseCreditMemo.PurchLines."No.".VALUE);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("VAT Prod. Posting Group", "VAT Product Posting Group".Code);
            PurchaseLine.Modify();
        end;
        //HEI.24<<
        NPOPurchaseCreditMemo.PurchLines."WHT Business Posting Group".SETVALUE("WHT Business Posting Group FND".Code);
        ///BC UPGRADE ATHUKS01 STP_FDD0007 >> 
        NPOPurchaseCreditMemo."Doc. Amount Incl. VAT IBM".SETVALUE(NPOPurchaseCreditMemo.PurchLines."Total Amount Incl. VAT".VALUE);
        NPOPurchaseCreditMemo."Doc. Amount VAT IBM".SETVALUE(NPOPurchaseCreditMemo.PurchLines."Total VAT Amount".VALUE);
        ///BC UPGRADE ATHUKS01 STP_FDD0007 <<
        DocNo := NPOPurchaseCreditMemo."No.".VALUE;
        if PurchaseHeader.Get(PurchaseHeader."Document Type"::"Credit Memo", DocNo) then
            PurchaseHeader.AddLink('C:\IBM\Shivendu\TestScript.pdf', 'TestLinkPTP015');

        // ASSERTERROR NPOPurchaseCreditMemo."Due Date".SETVALUE(100922D);//BC UPGRADE KUMARR78 Blocking to Rewritting Date format.
        asserterror NPOPurchaseCreditMemo."Due Date".SETVALUE(20220910D); //BC UPGRADE KUMARR78 Adding As Rewritting Date format.
        LastError := GetLastErrorText;

        if GetLastErrorText <> DateChangeError then
            Error('Unexpected Error: %1', GetLastErrorText); //Abhay

        if Vendor."Preferred Bank Account Code" = '' then begin//HEI.31
            asserterror NPOPurchaseCreditMemo."Payment Method Code".SETVALUE('');
            Clear(LastError);
            LastError := GetLastErrorText;
            if GetLastErrorText <> PaymentMethodCodeError then
                Error('Unexpected Error: %1', GetLastErrorText);
        end;//HEI.31
        asserterror NPOPurchaseCreditMemo."Payment Terms Code".SETVALUE('');
        Clear(LastError);
        LastError := GetLastErrorText;
        if GetLastErrorText <> PaymentTermCodeError then
            Error('Unexpected Error: %1', GetLastErrorText);

        // NPOPurchaseCreditMemo.Post.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        NPOPurchaseCreditMemo.Post_Cust.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name


        PurchCrMemoHdr.SetRange("Pre-Assigned No.", DocNo);
        if PurchCrMemoHdr.FindFirst() then
            PostedCrNo := PurchCrMemoHdr."No.";

        PostedPurchaseCreditMemos.OpenView();
        PostedPurchaseCreditMemos.Filter.SetFilter("Payment Status FND", 'Pending Review');//HEI.40
        PostedPurchaseCreditMemos.Filter.SetFilter("No.", PostedCrNo);
        PostedPurchaseCreditMemos."Payment Status".ASSERTEQUALS(paymentstatus::"Pending Review");
        //HEI.02
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,DimSetEntriesModalPageHandler')]
    procedure RT_PTP087_CreateNPOPrepayment();
    var
        GLAccount: Record "G/L Account";
        GeneralLedgerSetup: Record "General Ledger Setup";
        GeneralPostingSetup: Record "General Posting Setup";
        NoSeries: Record "No. Series";
        NoSeriesLine: Record "No. Series Line";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchaseLine: Record "Purchase Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Vendor: Record Vendor;
        "Vendor Bank Account": Record "Vendor Bank Account";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        NPOPrepaymentRequest: TestPage "NPO Prepayment Request CBN";
        NPOPrepaymentRequestsList: TestPage "NPOPrepayment ReqList CBN";
        VendorLedgerEntries: TestPage "Vendor Ledger Entries";
        DocNo: Text;
        PostInvNo: Text;
        Workflow: Record Workflow;
    begin
        DimensionRestrictionCheck;//HEI.95
        //HEI.02
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP087', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP087', CompanyName, Database::"Vendor Bank Account");
        "Vendor Bank Account".Get(UnitTestingValues."Value 2", UnitTestingValues.Value);
        //Step-4 created NPO Prepayment Requests
        //NPOPrepaymentRequestsList.OPENNEW;
        //HEI.36>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP087', CompanyName, Database::"Dimension Value");
        GeneralLedgerSetup.Get();
        DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 3 Code", UnitTestingValues.Value);
        //HEI.36<<
        //HEI.26>>
        PurchasesPayablesSetup.Get();
        NoSeries.Get(PurchasesPayablesSetup."Prepayment Request Nos. FND");
        if NoSeries."Default Nos." = false then begin
            NoSeries.Validate("Default Nos.", true);
            NoSeries.Modify();
        end;
        //HEI.26<<
        //HEI.68<<
        NoSeries.Get(PurchasesPayablesSetup."Posted Prepmt. Inv. Nos.");
        NoSeriesLine.Reset();
        NoSeriesLine.SetRange("Series Code", NoSeries.Code);
        if NoSeriesLine.FindLast() then begin
            if NoSeriesLine."Last Date Used" > Today then begin
                NoSeriesLine."Last Date Used" := Today;
                NoSeriesLine.Modify();
            end;
        end;
        //HEI.68>>
        NPOPrepaymentRequest.OpenNew();
        //NPOPrepaymentRequest.NEW;
        //Step-5 Select All required field on general tab
        NPOPrepaymentRequest."Buy-from Vendor No.".SetValue(Vendor."No."); //Abhay
        NPOPrepaymentRequest."Vendor Invoice No.".SetValue('StP PTP087');
        //Step-6 Enter Amount in Direct Unit Cost
        NPOPrepaymentRequest.PurchLines."Direct Unit Cost".SetValue(1000);
        // Step 9 Fill in Prepayment Due Date in PRepayment section
        NPOPrepaymentRequest."Due Date".SetValue(Today);
        if NPOPrepaymentRequest."Payment Method Code".Value = 'BANK CON' then
            if Vendor."Preferred Bank Account Code" = '' then //HEI.31
                NPOPrepaymentRequest."Vendor Bank Account".SetValue("Vendor Bank Account".Code);
        DocNo := NPOPrepaymentRequest."No.".Value;
        //Disable Workflows before Release
        //HEI.40>>
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", NPOPrepaymentRequest."No.".Value);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetFilter(Quantity, '<>%1', 0);
        if PurchaseLine.FindFirst() then begin
            if GeneralPostingSetup.Get(PurchaseLine."Gen. Bus. Posting Group", PurchaseLine."Gen. Prod. Posting Group") then
                if GLAccount.Get(GeneralPostingSetup."Purch. Prepayments Account") then
                    if GLAccount.Blocked = true then begin
                        GLAccount.Blocked := false;
                        GLAccount.Modify();
                    end;
        end;
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //HEI.40<<
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, NPOPrepaymentRequest."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            // IF Workflow.FINDSET THEN
            // REPEAT
            // Workflow.Enabled := FALSE;
            // Workflow.MODIFY;
            // UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;

        //Step 10 click Post Prepayment Invoice
        NPOPrepaymentRequest.Dimensions.Invoke();//HEI.36
        NPOPrepaymentRequest.PostPrepaymentInvoice.Invoke();

        //PurchInvHeader.SETRANGE("Pre-Assigned No.",DocNo);//HEI.26
        PurchInvHeader.SetRange("Prepayment Order No.", DocNo);//HEI.26
        if PurchInvHeader.FindFirst() then
            PostInvNo := PurchInvHeader."No.";
        VendorLedgerEntries.OpenView();
        VendorLedgerEntries.Filter.SetFilter("Document No.", PostInvNo);
        VendorLedgerEntries."Payment Status".AssertEquals(paymentstatus::"Pending Review");
        //HEI.02
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,ItemChargeAssignmentPurchModalPageHandler,PurReceiptLineModalPageHandler,MessageHandler,WhseRcptPageHandler,ItemTrackingLinesModalPageHandler,GetReceiptLine2ModalPageHandler,DimSetEntriesModalPageHandlerPTP133')]
    procedure RT_PTP018_CreatePOInvoice();
    var
        CompanyInformation: Record "Company Information";
        DimensionValue: Record "Dimension Value";
        DimensionValueMVMT: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        GeneralLedgerSetup: Record "General Ledger Setup";
        "Item Charge": Record "Item Charge";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        Vendor: Record Vendor;
        "WHT Business Posting Group FND": Record "WHT Business Posting Group FND";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        GetReceiptLines2: TestPage "Get Receipt Lines";
        ItemChargeAssignmentPurch: TestPage "Item Charge Assignment (Purch)";
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseInvList: TestPage "PO Purchase Invoices";
        PostedPurchaseInvoices: TestPage "Posted Purchase Invoices";
        GetReceiptLines: TestPage "Purch. Receipt Lines";
        InvNo: Text;
        PostInvNo: Text;
        VendorNo: Text;
    begin
        DimensionRestrictionCheck();//HEI.95
        //HEI.02
        RT_PCN023_CreatePurchaseOrder(); //HEI.14
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP018', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP018', CompanyName, Database::"WHT Business Posting Group FND");
        "WHT Business Posting Group FND".Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP018', CompanyName, Database::"Dimension Value");
        GeneralLedgerSetup.Get();
        if UnitTestingValues.Value <> '' then //HEI.19
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);
        //HEi.38>>
        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue.Code);//HEI.39 //HEI.47
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();
        //HEI.38<<
        //Step-4 created Purchase invoice
        // PurchaseInvList.OPENNEW;
        PurchaseInvoice.OPENNEW;
        //PurchaseInvoice.NEW;
        //Step-5&6 Select Vendor
        PurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor.Name);
        //Step-7 Fill Vendor Invoice No.
        PurchaseInvoice."Vendor Invoice No.".SETVALUE('StP Script PTP018');
        VendorNo := Vendor."No.";
        //Step-9 Click Get Receipt Lines
        PurchaseInvoice.PurchLines.GetReceiptLines.INVOKE;
        //Step-10 Select the GR line
        GetReceiptLines2.OpenView();
        PurchaseInvoice.PurchLines.FILTER.SETFILTER("Document No.", PurchaseInvoice."No.".VALUE);
        PurchaseInvoice.PurchLines.FILTER.SETFILTER("Line No.", '20000');
        //Step-11&12 click Item Charge Assignment
        PurchaseInvoice.PurchLines.ItemChargeAssignment.INVOKE;
        // PurchaseInvoice.PurchLines."WHT Business Posting Group FND".SETVALUE("WHT Business Posting Group FND".Code);
        //PurchaseInvoice."Due Date".SETVALUE(WORKDATE);
        //HEI.19>>
        CompanyInformation.Get();
        //HEI.26>>
        // IF (PurchaseInvoice.PurchLines."CAD Amount".VALUE<>FORMAT(0)) AND
        //  (CompanyInformation."Country/Region Code"<>Vendor."Country/Region Code") THEN
        //  PurchaseInvoice.PurchLines."VAT Prod. Posting Group".SETVALUE('NO_VAT');
        //HEI.28>>
        Clear(InvNo);
        InvNo := PurchaseInvoice."No.".VALUE;
        PurchaseInvoice.CLOSE;
        PurchaseInvoice.OPENEDIT;
        PurchaseInvoice.FILTER.SETFILTER("No.", InvNo);
        PurchaseInvoice.FILTER.SETFILTER("Document Type", 'Invoice');
        //HEI.28<<
        //HEI.36>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP018', CompanyName, Database::"Dimension Value");
        GeneralLedgerSetup.Get();
        DimensionValueMVMT.Get(GeneralLedgerSetup."Shortcut Dimension 3 Code", UnitTestingValues."Value 2");
        Clear(MVMTDimension);
        MVMTDimension := UnitTestingValues."Value 2";
        PurchaseInvoice.Dimensions.INVOKE;
        //PurchaseInvoice.PurchLines.Action1904974904.INVOKE;
        //HEI.36<<
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Invoice);
        PurchaseLine.SETRANGE("Document No.", PurchaseInvoice."No.".VALUE);
        //PurchaseLine.SETRANGE("No.",PurchaseInvoice.PurchLines."No.".VALUE);//HEI.30
        PurchaseLine.SetFilter(Type, '<>%1', PurchaseLine.Type::" ");//HEI.30
        if PurchaseLine.FindFirst() then begin
            //IF (PurchaseInvoice.PurchLines."CAD Amount".VALUE<>FORMAT(0)) AND//HEI.41
            if (PurchaseLine."CAD Amount FND" <> 0) and//HEI.41
             (CompanyInformation."Country/Region Code" <> Vendor."Country/Region Code") then
                PurchaseLine.Validate("VAT Prod. Posting Group", 'NO_VAT');
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
            PurchaseLine.Modify();
        end;
        //HEI.28>>
        // CLEAR(InvNo);
        // InvNo:=PurchaseInvoice."No.".VALUE;
        // PurchaseInvoice.CLOSE;
        // PurchaseInvoice.OPENEDIT;
        // PurchaseInvoice.FILTER.SETFILTER("No.",InvNo);
        // PurchaseInvoice.FILTER.SETFILTER("Document Type",'Invoice');
        //HEI.28<<
        //HEI.26<<
        //HEI.19<<
        //Step-8 Enter Document Amount Incl. VAT and Doc. Amount VAT

        //BC UPGRADE KUMARR78 >>DIT Variable Removed.("Doc. Amount Incl. VAT","Doc. Amount VAT")
        PurchaseInvoice."Doc. Amount Incl. VAT IBM".SETVALUE(PurchaseInvoice.PurchLines."Total Amount Incl. VAT".VALUE); // BC Upgrade BHARAD11
        PurchaseInvoice."Doc. Amount VAT IBM".SETVALUE(PurchaseInvoice.PurchLines."Total VAT Amount".VALUE); // BC Upgrade BHARDA11
        //BC UPGRADE KUMARR78 <<DIT Variable Removed.("Doc. Amount Incl. VAT","Doc. Amount VAT")

        //HEI.51>>

        //BC UPGRADE KUMARR78 >> DIT Variable Removed.("Doc. Amount Incl. VAT","Doc. Amount VAT")
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('BRASCO') THEN BEGIN
            PurchaseLine.RESET;
            PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Invoice);
            PurchaseLine.SETRANGE("Document No.", PurchaseInvoice."No.".VALUE);
            PurchaseLine.SETFILTER(Type, '<>%1', PurchaseLine.Type::" ");
            IF PurchaseLine.FINDFIRST THEN BEGIN
                PurchaseInvoice."Doc. Amount Incl. VAT IBM".SETVALUE(PurchaseLine."Amount Including VAT");
                PurchaseInvoice."Doc. Amount VAT IBM".SETVALUE(PurchaseLine."Amount Including VAT" - PurchaseLine.Amount);
            END;
        END;
        //BC UPGRADE KUMARR78 << DIT Variable Removed.("Doc. Amount Incl. VAT","Doc. Amount VAT")

        //HEI.51<<
        //PurchaseInvoice.PurchLines.Action1904974904.INVOKE;
        //PurchaseInvoice.PurchLines."Shortcut Dimension 2 Code".SETVALUE('10112401');
        InvNo := PurchaseInvoice."No.".VALUE;
        if PurchaseHeader.Get(PurchaseHeader."Document Type"::Invoice, InvNo) then
            PurchaseHeader.AddLink('C:\IBM\Shivendu\TestScript.pdf', 'TestLinkPTP018');
        //Step-20 post purchase invoice
        // PurchaseInvoice.Post.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseInvoice.Post_Custom.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name

        PurchInvHeader.SetRange("Pre-Assigned No.", InvNo);
        if PurchInvHeader.FindFirst() then
            PostInvNo := PurchInvHeader."No.";

        PostedPurchaseInvoices.OpenView();
        PostedPurchaseInvoices.Filter.SetFilter("No.", PostInvNo);
        PostedPurchaseInvoices."Payment Status".ASSERTEQUALS(paymentstatus::"Payment Approved");
        //HEI.02
    end;

    [ModalPageHandler]
    procedure GetReceiptLine2ModalPageHandler(var GetReceiptLines2: TestPage "Get Receipt Lines");
    begin
        //GetReceiptLines2.FINDFIRSTFIELD("Document No.",RecNo);
        GetReceiptLines2.Filter.SetFilter("Document No.", RecNo);
        GetReceiptLines2.OK().Invoke()
    end;

    [Test]
    [HandlerFunctions('PTP073_SuggestVendorPayment_RequestPageHandler')]
    procedure RT_PTP073_ExecutePaymentBankConnectivity();
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalTemplate: Record "Gen. Journal Template";
        Item: Record Item;
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        PurchLn: Record "Purchase Line";
        Vendor: Record Vendor;
        VendorRec: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        PurchInvNo: Code[20];
        WhseRcptPONo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        GenJnlAccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        GetReceiptLines: TestPage "Get Receipt Lines";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        PayGenJnl: TestPage "Payment Journal Tree CBN";
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseInvList: TestPage "PO Purchase Invoices";
        PurchaseOrder: TestPage "Purchase Order";
        PurchaseOrderList: TestPage "Purchase Orders";
        WarehouseReceipt: TestPage "Warehouse Receipt";
    begin
        DimensionRestrictionCheck;//HEI.95
        //HEI.04 >>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP073', CompanyName, Database::Vendor);//Abhay
        VendorRec.Get(UnitTestingValues.Value);
        Clear(GenJnlAccType);

        PayGenJnl.OpenEdit();
        PayGenJnl.CurrentJnlBatchName.SetValue('BANK-I');
        PayGenJnl.SuggestVendorPayments.Invoke();
        PayGenJnl.ExportPaymentsToFile.Invoke();
        //PayGenJnl.Post.INVOKE;
        //HEI.04 <<
    end;

    [ModalPageHandler]
    procedure PTP073_SelectGenJnlTemplatePageHandler(var GenJnlTemplateList: TestPage "General Journal Template List");
    begin
        //GenJnlTemplateList.FINDFIRSTFIELD(Name,'PTP');
        GenJnlTemplateList.Filter.SetFilter(Name, 'PTP');
        GenJnlTemplateList.OK().Invoke();
    end;

    [RequestPageHandler]
    procedure PTP073_SuggestVendorPayment_RequestPageHandler(var SuggestVendorPayment: TestRequestPage "Suggest Vendor Payments");
    var
        Customer: Record Customer;
    begin
        SuggestVendorPayment.LastPaymentDate.SetValue(Today);
        SuggestVendorPayment.PostingDate.SetValue(Today);
        // SuggestVendorPayment.Control55001.SETVALUE(TODAY);//BC UPGRADE KUMARR78 CONF (ExecutionDate)
        SuggestVendorPayment.StartingDocumentNo.SetValue('Test001');
        // SuggestVendorPayment.VendorLedgerEntriesFilter.SETFILTER(SuggestVendorPayment.VendorLedgerEntriesFilter."Document No.", 'DOC01');//BC UPGRADE KUMARR78 CONF
        SuggestVendorPayment.OK().Invoke();
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,MessageHandler')]
    procedure RT_PCN003_CreateCallOffFromBlanketOrder();
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        hhh: page 250;
    begin
        DimensionRestrictionCheck;//HEI.95
        PurchasesPayablesSetup.Get(); //HEI.96
        //HEI.05>>
        // Step #1 - Open Purchase Blanket Order
        //HEI.19>>
        //IF UnitTestingValue.GET('STP_PCN003',COMPANYNAME,DATABASE::"Purchase Header") THEN;
        UnitTestingValue.Get('STP_PCN003', CompanyName, Database::"Purchase Header");
        PurchaseHeader.Get(PurchaseHeader."Document Type"::"Blanket Order", UnitTestingValue.Value);
        //HEI.19<<
        //HEI.46>>
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::"Blanket Order");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine.SetFilter("Qty. to Receive", '<>%1', 0);
        if PurchaseLine.FindSet() then begin
            repeat
                //HEI.96>>
                //HEI.107>>
                //IF (PurchasesPayablesSetup."Excluded Incoterms" IN['DAP|DDP','DDP|DAP']) AND (PurchasesPayablesSetup."Location Code for Import Proc."<>'') THEN BEGIN
                //IF NOT (PurchaseHeader."Shipment Method Code" IN['DAP','DDP']) THEN BEGIN
                if (PurchasesPayablesSetup."Excluded Incoterms FND" <> '') and (PurchasesPayablesSetup."Location Code Imp Proc. FND" <> '') then begin
                    if StrPos(PurchasesPayablesSetup."Excluded Incoterms FND", BlanketPurchaseOrder."Shipment Method Code".Value) = 0 then begin //HEI.107<<
                        PurchaseLine."Location Code" := '';
                        PurchaseLine."Consumption Location Code FND" := PurchasesPayablesSetup."Location Code Imp Proc. FND";
                    end;
                end;
                //HEI.96<<
                PurchaseLine.Validate("Qty. to Receive", 0);
                PurchaseLine.Modify(true);
            until PurchaseLine.Next() = 0;
        end;
        //HEI.46<<
        BlanketPurchaseOrder.OpenEdit();
        //BlanketPurchaseOrder.FILTER.SETFILTER("No.",UnitTestingValue.Value);//HEI.19
        BlanketPurchaseOrder.Filter.SetFilter("No.", PurchaseHeader."No.");//HEI.19
        BlanketPurchaseOrder.Reopen.Invoke();
        //Step #2 update the line
        UnitTestingValue.SetRange("Test Script Code", 'STP_PCN003');
        UnitTestingValue.SetRange("Table ID", 39);
        if UnitTestingValue.FindSet() then begin
            repeat
                BlanketPurchaseOrder.PurchLines1.Filter.SetFilter("No.", UnitTestingValue."Value 3");
                BlanketPurchaseOrder.PurchLines1.Filter.SetFilter("Block Line Ordering FND", ' ');//HEI.59
                                                                                                  //HEI.19>>
                                                                                                  //BlanketPurchaseOrder.PurchLines."Location Code".SETVALUE(UnitTestingValue."Value 2");

                //HEI.75>>
                //IF (PurchasesPayablesSetup."Excluded Incoterms"='DAP|DDP') AND (PurchasesPayablesSetup."Location Code for Import Proc."<>'') THEN BEGIN
                //IF (PurchasesPayablesSetup."Excluded Incoterms" IN['DAP|DDP','DDP|DAP']) AND (PurchasesPayablesSetup."Location Code for Import Proc."<>'') THEN BEGIN //HEI.107
                if (PurchasesPayablesSetup."Excluded Incoterms FND" <> '') and (PurchasesPayablesSetup."Location Code Imp Proc. FND" <> '') then begin //HEI.107
                                                                                                                                                       //HEI.75<<
                                                                                                                                                       //IF NOT (BlanketPurchaseOrder."Shipment Method Code".VALUE IN['DAP','DDP']) THEN BEGIN //HEI.107
                    if StrPos(PurchasesPayablesSetup."Excluded Incoterms FND", BlanketPurchaseOrder."Shipment Method Code".Value) = 0 then begin //HEI.107
                        BlanketPurchaseOrder.PurchLines1."Location Code".SetValue('');
                        BlanketPurchaseOrder.PurchLines1."Consumption Location Code".SETVALUE(PurchasesPayablesSetup."Location Code Imp Proc. FND");
                    end;
                end;
                //HEI.19<<
                BlanketPurchaseOrder.PurchLines1."Qty. to Receive".SetValue(UnitTestingValue.Value);
            until UnitTestingValue.Next() = 0;
        end;
        //HEI.19>>
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::"Blanket Order");
        PurchaseLine.SetRange("Document No.", BlanketPurchaseOrder."No.".Value);
        PurchaseLine.SetFilter("Qty. to Receive", '<>%1', 0);
        PurchaseLine.SetFilter("No.", '<>%1', BlanketPurchaseOrder.PurchLines1."No.".Value);
        if PurchaseLine.FindSet() then begin
            repeat
                PurchaseLine.Validate("Qty. to Receive", 0);
                PurchaseLine.Modify(true);
            until PurchaseLine.Next() = 0;
        end;
        //HEI.19<<
        //Step #3 Make order
        BlanketPurchaseOrder.MakeOrder.Invoke();
        BlanketPurchaseOrder.Close();//HEI.26
        //HEI.05<<
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,MessageHandler_PCN027')]
    procedure RT_PCN027_CreateCalloff();
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        ItemCharge: Record "Item Charge";
        Location: Record Location;
        PurchHdr: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        Vendor: Record Vendor;
        StoreContractType: Code[10];
        StoreCurrency: Code[10];
        StorePaymentTerms: Code[10];
        StorePurchaserCode: Code[10];
        StoreShipmentMethodCode: Code[10];
        StoreSRMContractLnNo: Code[10];
        BONo: Code[20];
        StoreBlanketOrderNo: Code[20];
        StoreSRMContractNo: Code[20];
        StoreConsumptionDate: Date;
        QtyToReceive: Decimal;
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        PurchBlanketOrders: TestPage "Blanket Purchase Order";
        PurchBlanketOrdersList: TestPage "Blanket Purchase Orders";
        DimensionPage: TestPage "Edit Dimension Set Entries";
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseInvList: TestPage "PO Purchase Invoices";
        PurchaseOrder: TestPage "Purchase Order";
        PurchOrdersList: TestPage "Purchase Order List";
        PurchaseOrderList: TestPage "Purchase Orders";
        BOLineType: Text;
        BOQty: Text;
        StoreBOLineNo: Text;
        StoreDescription: Text;
        StorePONumber: Text;
        StoreValidFrom: Text;
        StoreValidTo: Text;
    begin
        DimensionRestrictionCheck;//HEI.95
        //HEI.01>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN027', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN027', CompanyName, Database::"Item Charge");
        ItemCharge.Get(UnitTestingValues.Value);//Abhay

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN027', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN027', CompanyName, Database::"Purchase Header");
        PurchHdr.Get(PurchHdr."Document Type"::"Blanket Order", UnitTestingValues.Value);
        //HEI.19>>
        // UnitTestingValues.RESET;
        // UnitTestingValues.GET('PCN027',COMPANYNAME,DATABASE::"Dimension Value");
        // GeneralLedgerSetup.GET;
        // DimensionValue.GET(GeneralLedgerSetup."Shortcut Dimension 2 Code",UnitTestingValues.Value);
        //HEI.19<<
        // PurchBlanketOrdersList.OPENVIEW;
        // PurchBlanketOrdersList.FILTER.SETFILTER("No.",PurchHdr."No.");
        PurchBlanketOrders.OpenEdit();
        PurchBlanketOrders.Filter.SetFilter("No.", PurchHdr."No.");
        PurchBlanketOrders.Reopen.Invoke();
        StoreBlanketOrderNo := PurchBlanketOrders."No.".Value;
        StorePurchaserCode := PurchBlanketOrders."Purchaser Code".Value;
        StoreCurrency := PurchBlanketOrders."Currency Code".Value;
        StorePaymentTerms := PurchBlanketOrders."Payment Terms Code".Value;
        StoreContractType := PurchBlanketOrders."SRM Contract Type".VALUE;//BC UPGRADE KUMARR78 >>DIT Variable Removed.("SRM Contract Type") // PR Pending
        StoreShipmentMethodCode := PurchBlanketOrders."Shipment Method Code".Value;
        PurchBlanketOrders.PurchLines1.Filter.SetFilter("No.", ItemCharge."No.");//HEI.19
        PurchBlanketOrders.PurchLines1."Block Line Ordering".SETVALUE(PurchaseLine."Block Line Ordering FND"::" "); //HEI.104
        //HEI.41>>
        //PurchBlanketOrders.PurchLines."Qty. to Receive".SETVALUE(1);
        Clear(QtyToReceive);
        if PurchBlanketOrders.PurchLines1."Qty. to Receive".Value <> '' then //HEI.43
            Evaluate(QtyToReceive, PurchBlanketOrders.PurchLines1."Qty. to Receive".Value);
        //HEI.101>>
        if QtyToReceive = 0 then
            PurchBlanketOrders.PurchLines1."Qty. to Receive".SetValue(QtyToReceive + 1)
        else
            PurchBlanketOrders.PurchLines1."Qty. to Receive".SetValue(QtyToReceive);
        //HEI.101<<
        //HEI.41<<
        PurchBlanketOrders.PurchLines1."Direct Unit Cost".SetValue(100);
        if PurchBlanketOrders.PurchLines1."Consumption Location Code".VALUE = '' then//HEI.19
            PurchBlanketOrders.PurchLines1."Consumption Location Code".SETVALUE(Location.Code);
        PurchBlanketOrders."Consumption Date".SETVALUE(PurchBlanketOrders.PurchLines1."Valid To".VALUE);
        BOLineType := PurchBlanketOrders.PurchLines1.Type.Value;
        BONo := PurchBlanketOrders.PurchLines1."No.".Value;
        BOQty := PurchBlanketOrders.PurchLines1."Qty. to Receive".Value;

        //IF PurchBlanketOrders.PurchLines."Line No.".VISIBLE THEN
        //  StoreBOLineNo := PurchBlanketOrders.PurchLines."Line No.".VALUE;
        StoreDescription := PurchBlanketOrders.PurchLines1.Description.Value;
        StoreSRMContractNo := PurchBlanketOrders.PurchLines1."SRM Contract No.".VALUE;
        if PurchBlanketOrders.PurchLines1."SRM Contract Line No.".VISIBLE then
            StoreSRMContractLnNo := PurchBlanketOrders.PurchLines1."SRM Contract Line No.".VALUE;
        StoreValidFrom := PurchBlanketOrders.PurchLines1."Valid From".VALUE;
        StoreValidTo := PurchBlanketOrders.PurchLines1."Valid To".VALUE;
        //HEI.19>>
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::"Blanket Order");
        PurchaseLine.SetRange("Document No.", PurchBlanketOrders."No.".Value);
        PurchaseLine.SetFilter("Qty. to Receive", '<>%1', 0);
        PurchaseLine.SetFilter("No.", '<>%1', ItemCharge."No.");
        if PurchaseLine.FindSet() then begin
            repeat
                PurchaseLine.Validate("Qty. to Receive", 0);
                PurchaseLine.Modify(true);
            until PurchaseLine.Next() = 0;
        end;
        //HEI.19<<
        PurchBlanketOrders.MakeOrder.Invoke();
        StorePONumber := CopyStr(storemessage, 7, 11);
        PurchBlanketOrders.Close();

        PurchaseOrder.OpenEdit();
        PurchaseOrder.Filter.SetFilter("No.", StorePONumber);
        PurchaseOrder."Purchaser Code".AssertEquals(StorePurchaserCode);
        PurchaseOrder."Currency Code".AssertEquals(StoreCurrency);
        PurchaseOrder."Payment Terms Code".AssertEquals(StorePaymentTerms);

        //BC UPGRADE KUMARR78 >> DIT Variable Removed.("SRM Contract Type")
        PurchaseOrder."SRM Contract Type".ASSERTEQUALS(StoreContractType);
        PurchaseOrder."Valid From".ASSERTEQUALS(StoreValidFrom);
        PurchaseOrder."Valid To".ASSERTEQUALS(StoreValidTo);
        //BC UPGRADE KUMARR78 << DIT Variable Removed.("SRM Contract Type")

        PurchaseOrder."Shipment Method Code".AssertEquals(StoreShipmentMethodCode);
        //PurchaseOrder.Dimensions.INVOKE;//HEI.19

        PurchaseOrder.PurchLines.Type.AssertEquals(BOLineType);
        PurchaseOrder.PurchLines."No.".AssertEquals(BONo);
        PurchaseOrder.PurchLines.Quantity.AssertEquals(BOQty);
        //PurchaseOrder.PurchLines."Direct Unit Cost".ASSERTEQUALS(100); //TEMP-AB
        PurchaseOrder.PurchLines.Description.AssertEquals(StoreDescription);
        //IF PurchaseOrder.PurchLines."Blanket Order No.".VISIBLE THEN
        //  PurchaseOrder.PurchLines."Blanket Order No.".ASSERTEQUALS(StoreBlanketOrderNo);

        //BC UPGRADE KUMARR78 >> DIT Variable Removed.("SRM Contract No.")
        // IF PurchaseOrder.PurchLines."SRM Contract No.".VISIBLE THEN
        //     PurchaseOrder.PurchLines."SRM Contract No.".ASSERTEQUALS(StoreSRMContractNo);
        //BC UPGRADE KUMARR78 << DIT Variable Removed.("SRM Contract No.")

        //IF PurchaseOrder.PurchLines."SRM Order Line No.".VISIBLE THEN
        //  PurchaseOrder.PurchLines."SRM Order Line No.".ASSERTEQUALS(StoreSRMContractLnNo);
        //HEI.01<<
    end;

    [ModalPageHandler]
    procedure ApplyVendEntriesModalPageHandler(var ApplyVendList: Page "Apply Vendor Entries"; var Response: Action);
    var
        lVendLedgEntry: Record "Vendor Ledger Entry";
        ApplyVendorEntries: TestPage "Apply Vendor Entries";
        NavigatePage: TestPage Navigate;
        PostedPI: TestPage "Posted Sales Invoice";
    begin

        /*ApplyVendorEntries.FILTER.SETFILTER("Document No.",InvNo);
        //ApplyVendorEntries.OPENVIEW;
        ApplyVendorEntries.Navigate.INVOKE;
        NavigatePage.FILTER.SETFILTER("Table ID",'122');
        NavigatePage."No. of Records".ASSISTEDIT;
        PostedPI.OK.INVOKE;
        NavigatePage.OK.INVOKE;
        ApplyVendorEntries.OK.INVOKE;

        Response := ACTION::LookupOK;
        */

    end;

    [ModalPageHandler]
    procedure DimSetEntriesModalPageHandler(var EditDimensionSetEntries: TestPage "Edit Dimension Set Entries");
    begin
        EditDimensionSetEntries.New();
        EditDimensionSetEntries."Dimension Code".SetValue(DimensionValue."Dimension Code");
        EditDimensionSetEntries.DimensionValueCode.SetValue(DimensionValue.Code);
        EditDimensionSetEntries.OK().Invoke();
    end;

    [ModalPageHandler]
    [HandlerFunctions('NavigatePageHandler')]
    procedure AVEModalPageHandler(var ApplyVendorEntries: TestPage "Apply Vendor Entries");
    var
        lVendLedgEntry: Record "Vendor Ledger Entry";
        NavigatePage: TestPage Navigate;
        PostedPI: TestPage "Posted Sales Invoice";
    begin
        ApplyVendorEntries.Filter.SetFilter("Document No.", InvNo);
        //ApplyVendorEntries.OPENVIEW;
        ApplyVendorEntries.Navigate.Invoke();
        /*NavigatePage.FILTER.SETFILTER("Table ID",'122');
        NavigatePage."No. of Records".ASSISTEDIT;
        PostedPI.OK.INVOKE;
        NavigatePage.OK.INVOKE;
        */
        ApplyVendorEntries.OK().Invoke();

        //Response := ACTION::LookupOK;

    end;

    [PageHandler]
    [HandlerFunctions('PPIPageHandler')]
    procedure NavigatePageHandler(var NavigatePage: TestPage Navigate);
    var
        PostedPI: TestPage "Posted Sales Invoice";
    begin
        NavigatePage.Filter.SetFilter("Table ID", '122');
        NavigatePage."No. of Records".Drilldown();
        //PostedPI.OK.INVOKE;
        NavigatePage.OK().Invoke();
    end;

    [PageHandler]
    procedure PPIPageHandler(var PostedPI: TestPage "Posted Purchase Invoice");
    begin
        PostedPI.OK().Invoke();
    end;

    [PageHandler]
    procedure AppEntPageHandler(var ApprovalEntries: TestPage "Approval Entries");
    begin
        ApprovalEntries.OK().Invoke();
    end;

    [PageHandler]
    procedure PayJnlTreePageHandler(var PaymentJournalTree: TestPage "Payment Journal Tree CBN");
    begin
        PaymentJournalTree.Approve.Invoke();
        PaymentJournalTree.OK().Invoke();
    end;

    [Test]
    procedure "PCN017-Create Purchase Quote"();
    var
        "Fixed Asset": Record "Fixed Asset";
        Item: Record Item;
        "Item Charge": Record "Item Charge";
        Location: Record Location;
        PurchHdr: Record "Purchase Header";
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        Vendor: Record Vendor;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ApprovalEntries: TestPage "Approval Entries";
        EditDimensionSetEntries: TestPage "Edit Dimension Set Entries";
        ItemChargeAssignmentPurch: TestPage "Item Charge Assignment (Purch)";
        GetReceiptLines: TestPage "Purch. Receipt Lines";
        PurchaseQuote: TestPage "Purchase Quote";
        PurchaseQuoteList: TestPage "Purchase Quotes";
        RequeststoApprove: TestPage "Requests to Approve";
        Workflow: Record Workflow;
    begin
        DimensionRestrictionCheck;//HEI.95
        //HEI.06
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN017', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN017', CompanyName, Database::"Item Charge");
        "Item Charge".Get(UnitTestingValues.Value);
        /*
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PCN017',COMPANYNAME,DATABASE::"Fixed Asset");
        "Fixed Asset".GET(UnitTestingValues.Value);
        */

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN017', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);


        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN017', CompanyName, Database::"User Setup");
        UserSetup.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN017', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);

        //Create a PQ

        //PurchaseQuoteList.OPENNEW;
        PurchaseQuote.OpenNew();
        //PurchaseQuote.NEW;
        PurchaseQuote."Buy-from Vendor Name".SetValue(Vendor.Name);
        PurchaseQuote."Vendor Order No.".SetValue('TEST_PCN017');
        // PurchaseQuote."Requester ID".SETVALUE(UserSetup."User ID");//BC UPGRADE KUMARR78 DIT Field Removed.
        PurchaseQuote.PurchLines.Type.SetValue(Type::Item);
        PurchaseQuote.PurchLines."No.".SetValue(Item."No.");
        PurchaseQuote.PurchLines.Quantity.SetValue(1);
        PurchaseQuote.PurchLines."Location Code".SetValue(Location.Code);

        PurchaseQuote.PurchLines.New();
        PurchaseQuote.PurchLines.Type.SetValue(Type::"Charge (Item)");
        PurchaseQuote.PurchLines."No.".SetValue("Item Charge"."No.");
        PurchaseQuote.PurchLines.Quantity.SetValue(1);
        PurchaseQuote.PurchLines."Location Code".SetValue(Location.Code);

        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>

        //Send for approval

        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchHdr) then
            PurchaseQuote.SendApprovalRequest.Invoke();

    end;

    [Test]
    [HandlerFunctions('MessageHandler')]
    procedure "PCN018-Approve Purchase Quote"();
    var
        "Fixed Asset": Record "Fixed Asset";
        Item: Record Item;
        "Item Charge": Record "Item Charge";
        JobQueueEntry: Record "Job Queue Entry";
        Location: Record Location;
        PurchHdr: Record "Purchase Header";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        Vendor: Record Vendor;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ApprovalEntries: TestPage "Approval Entries";
        EditDimensionSetEntries: TestPage "Edit Dimension Set Entries";
        ItemChargeAssignmentPurch: TestPage "Item Charge Assignment (Purch)";
        GetReceiptLines: TestPage "Purch. Receipt Lines";
        PurchaseQuote: TestPage "Purchase Quote";
        PurchaseQuoteList: TestPage "Purchase Quotes";
        RequeststoApprove: TestPage "Requests to Approve";
        Workflow: Record Workflow;
    begin
        DimensionRestrictionCheck;//HEI.95
        //HEI.06
        UnitTestingValues.Reset();//Abhay
        UnitTestingValues.Get('PCN018', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN018', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);


        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN018', CompanyName, Database::"User Setup");
        UserSetup.Get(UnitTestingValues.Value);


        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN018', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);

        //Create a PQ

        //PurchaseQuoteList.OPENNEW;
        PurchaseQuote.OpenNew();
        //PurchaseQuote.NEW;
        PurchaseQuote."Buy-from Vendor Name".SetValue(Vendor.Name);//Abhay
        PurchaseQuote."Vendor Order No.".SetValue('TEST_PCN018');
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then //Abhay
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseQuote."Location Code".SetValue(Location.Code);
        //HEI.51<<
        // PurchaseQuote."Requester ID".SETVALUE(UserSetup."User ID");//BC UPGRADE KUMARR78 DIT Field Removed.
        PurchaseQuote.PurchLines.Type.SetValue(Type::Item);
        PurchaseQuote.PurchLines."No.".SetValue(Item."No.");
        PurchaseQuote.PurchLines.Quantity.SetValue(1);//Abhay
        PurchaseQuote.PurchLines."Location Code".SetValue(Location.Code);


        //Send for approval and Approve entry
        /*
        IF ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchHdr) THEN BEGIN
          PurchaseQuote.SendApprovalRequest.INVOKE;
          ApprovalEntries.TRAP;
          PurchaseQuote.Approvals.INVOKE;
 
         //Update Substitute for Approver ID = USERID
          UserSetup.GET(ApprovalEntries."Approver ID".VALUE);
          UserSetup.Substitute := USERID;
          UserSetup.MODIFY;
 
        END ELSE
            RequeststoApprove.OPENVIEW;
 
 
          IF RequeststoApprove.FIRST THEN
            RequeststoApprove.Approve.INVOKE;
        */
        //HEI.26>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        // JobQueueEntry.SetRange("Object ID to Run", 50085);
        JobQueueEntry.SetRange("Object ID to Run", 51015); // fix 51015 "Send EMail with Attachment CBN"
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.26<<
        //HEI.27>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        JobQueueEntry.SetRange("Object ID to Run", 1509);
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.27<<
        //HEI.31>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetFilter("Object Type to Run", '%1', JobQueueEntry."Object Type to Run"::Report);
        JobQueueEntry.SetRange("Object ID to Run", 111);
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.31<<
        //HEI.49>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Report);
        // JobQueueEntry.SetRange("Object ID to Run", 50239);
        JobQueueEntry.SetRange("Object ID to Run", 58021); // fix 58021 "Remove Interface Log >60D"
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.49<<
        //HEI.52>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        // JobQueueEntry.SetRange("Object ID to Run", 50125);
        JobQueueEntry.SetRange("Object ID to Run", 58111); // fix 58111 "Error Job Queue Notification"
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.52<<
        //HEI.53>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        //HEI.74>>
        if JobQueueEntry.FindFirst() then
            JobQueueEntry.ModifyAll(Status, JobQueueEntry.Status::Ready);
        // IF JobQueueEntry.FINDSET THEN BEGIN
        // REPEAT
        // JobQueueEntry.Status:=JobQueueEntry.Status::Ready;
        // JobQueueEntry.MODIFY;
        // UNTIL JobQueueEntry.NEXT=0;
        // END;
        //HEI.74<<
        //HEI.53<<
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Quote, PurchaseQuote."No.".Value);

        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            PurchaseQuote.SendApprovalRequest.Invoke();
            ApprovalEntries.Trap();
            PurchaseQuote.Approvals.Invoke();
            UserSetup.Get(ApprovalEntries."Approver ID".Value);
            UserSetup.Substitute := UserId;
            UserSetup."Approval Administrator" := true;
            UserSetup.Modify();

            //Update Approval Limit for USERID
            UserSetup2.Get(UserId);
            if not UserSetup2."Unlimited Purchase Approval" or not UserSetup2."Unlimited Request Approval" then begin
                UserSetup2."Unlimited Purchase Approval" := true;
                UserSetup2."Unlimited Request Approval" := true;
                //UserSetup2."Approval Administrator":=TRUE;
                UserSetup2.Modify();
            end;

            //Delegate Approval Request
            // ApprovalEntries.Action35.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
            ApprovalEntries."&Delegate".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

            //Approve Approval Entry
            PurchaseQuote.Approve.Invoke();
        end
        else//HEI.20
            Error('Workflows is Disable');//HEI.20 //Abhay

    end;


    [Test]
    [HandlerFunctions('ConfirmationHandler,MessageHandler_PCN027')]
    // [HandlerFunctions('ConfirmationHandler')]
    procedure "PCN019-Create Purchase Order from Purchase Quote"();
    var
        "Fixed Asset": Record "Fixed Asset";
        Item: Record Item;
        "Item Charge": Record "Item Charge";
        JobQueueEntry: Record "Job Queue Entry";
        Location: Record Location;
        PaymentTerms: Record "Payment Terms";
        PurchHdr: Record "Purchase Header";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        Vendor: Record Vendor;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        PurchQuoteNo: Code[20];
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ApprovalEntries: TestPage "Approval Entries";
        EditDimensionSetEntries: TestPage "Edit Dimension Set Entries";
        ItemChargeAssignmentPurch: TestPage "Item Charge Assignment (Purch)";
        GetReceiptLines: TestPage "Purch. Receipt Lines";
        PurchaseOrder: TestPage "Purchase Order";
        PurchOrdersList: TestPage "Purchase Order List";
        PurchaseQuote: TestPage "Purchase Quote";
        PurchaseQuoteList: TestPage "Purchase Quotes";
        RequeststoApprove: TestPage "Requests to Approve";
        CapturePONo: Text;
        Purch_Hdr: Record "Purchase Header";
        PurchQuoteToOrder: Codeunit "Purch.-Quote to Order";
        Workflow: Record Workflow;
    begin
        DimensionRestrictionCheck;//HEI.95
        //HEI.06
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN019', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);
        //VendorNo := Vendor."No.";

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN019', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);


        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN019', CompanyName, Database::"User Setup");
        UserSetup.Get(UnitTestingValues.Value);


        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN019', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);


        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN019', CompanyName, Database::"Payment Terms");
        PaymentTerms.Get(UnitTestingValues.Value);



        //Create a PQ

        //PurchaseQuoteList.OPENNEW;
        PurchaseQuote.OpenNew();
        //PurchaseQuote.NEW;
        PurchaseQuote."Buy-from Vendor Name".SetValue(Vendor.Name);//Abhay
        PurchaseQuote."Vendor Order No.".SetValue('TEST_PCN019');
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseQuote."Location Code".SetValue(Location.Code);
        //HEI.51<<
        // PurchaseQuote."Requester ID".SETVALUE(UserSetup."User ID");//BC UPGRADE KUMARR78 DIT Field Removed.
        PurchaseQuote.PurchLines.Type.SetValue(Type::Item);
        PurchaseQuote.PurchLines."No.".SetValue(Item."No.");
        PurchaseQuote.PurchLines.Quantity.SetValue(1);
        PurchaseQuote.PurchLines."Location Code".SetValue(Location.Code);
        //PurchaseQuote.CLOSE;
        PurchQuoteNo := PurchaseQuote."No.".Value;
        //Send for approval and Approve entry

        /*
        IF ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchHdr) THEN BEGIN
          PurchaseQuote.SendApprovalRequest.INVOKE;
          ApprovalEntries.TRAP;
          PurchaseQuote.Approvals.INVOKE;

         //Update Substitute for Approver ID = USERID
          UserSetup.GET(ApprovalEntries."Approver ID".VALUE);
          UserSetup.Substitute := USERID;
          UserSetup.MODIFY;

        END ELSE
            RequeststoApprove.OPENVIEW;


          IF RequeststoApprove.FIRST THEN
            RequeststoApprove.Approve.INVOKE;
        */
        //HEI.26>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        // JobQueueEntry.SetRange("Object ID to Run", 50085);51015
        JobQueueEntry.SetRange("Object ID to Run", 51015); // BC Upgrade BHARDA11
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.26<<
        //HEI.27>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        JobQueueEntry.SetRange("Object ID to Run", 1509);
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.27<<
        //HEI.31>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetFilter("Object Type to Run", '%1', JobQueueEntry."Object Type to Run"::Report);
        JobQueueEntry.SetRange("Object ID to Run", 111);
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.31<<
        //HEI.49>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Report);
        // JobQueueEntry.SetRange("Object ID to Run", 50239);
        JobQueueEntry.SetRange("Object ID to Run", 58021);  // BC Upgrade BHARDA11
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.49<<
        //HEI.52>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        // JobQueueEntry.SetRange("Object ID to Run", 50125);
        JobQueueEntry.SetRange("Object ID to Run", 58111); // BC Upgrade BHARAD11
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.52<<
        //HEI.53>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        //HEI.74>>
        if JobQueueEntry.FindFirst() then
            JobQueueEntry.ModifyAll(Status, JobQueueEntry.Status::Ready);
        // IF JobQueueEntry.FINDSET THEN BEGIN
        // REPEAT
        // JobQueueEntry.Status:=JobQueueEntry.Status::Ready;
        // JobQueueEntry.MODIFY;
        // UNTIL JobQueueEntry.NEXT=0;
        // END;
        //HEI.74<<
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //HEI.53<<
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Quote, PurchaseQuote."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            PurchaseQuote.SendApprovalRequest.Invoke();
            ApprovalEntries.Trap();
            PurchaseQuote.Approvals.Invoke();
            UserSetup.Get(ApprovalEntries."Approver ID".Value);
            UserSetup.Substitute := UserId;
            UserSetup."Approval Administrator" := true;
            UserSetup.Modify();

            //Update Approval Limit for USERID
            UserSetup2.Get(UserId);
            if not UserSetup2."Unlimited Purchase Approval" or not UserSetup2."Unlimited Request Approval" then begin
                UserSetup2."Unlimited Purchase Approval" := true;
                UserSetup2."Unlimited Request Approval" := true;
                //UserSetup2."Approval Administrator":=TRUE;
                UserSetup2.Modify();
            end;

            //Delegate Approval Request

            // ApprovalEntries.Action35.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
            ApprovalEntries."&Delegate".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

            //Approve Approval Entry
            PurchaseQuote.Approve.Invoke();
        end else
            PurchaseQuote.Release.Invoke();

        //Make order from PO

        // PurchaseQuote."Make Order".INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        // PurchaseQuote.MakeOrder.Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name // BC Upgrade BHARDA11 >>
        if Purch_Hdr.get(Purch_Hdr."Document Type"::Quote, PurchaseQuote."No.".Value) then begin
            PurchQuoteToOrder.Run(Purch_Hdr);
        end;
        // BC Upgrade BHARDA11 <<
        /*
        CapturePONo := COPYSTR(storemessage,59,(STRLEN(storemessage)-1));
        //CapturePONo := DELCHR(CapturePONo,'.');
        ERROR(CapturePONo);
        //PurchaseQuote.CLOSE;
        */
        // Search and Update PO by changing the vendor

        //PurchOrdersList.OPENVIEW;
        PurchaseOrder.OpenEdit();
        PurchaseOrder.Filter.SetFilter("Quote No.", PurchQuoteNo);
        //PurchaseOrder.Reopen.INVOKE;
        //ERROR(FORMAT(PurchaseOrder.Status));
        //PurchaseOrder."Buy-from Vendor No.".SETVALUE('0030000128');
        //PurchaseOrder."Buy-from Vendor Name".SETVALUE('DHL International SARL');
        //PurchaseOrder.PurchLines.NEW;
        PurchaseOrder.PurchLines.Type.SetValue(Type::Item);
        PurchaseOrder.PurchLines."No.".SetValue(Item."No.");
        PurchaseOrder.PurchLines.Quantity.SetValue(2);
        PurchaseOrder.PurchLines."Location Code".SetValue(Location.Code);
        PurchaseOrder.PurchLines."Direct Unit Cost".SetValue(200);
        PurchaseOrder.PurchLines."Expected Receipt Date".SetValue(Today);
        PurchaseOrder."Payment Terms Code".SetValue(PaymentTerms.Code);
        PurchaseOrder.OK().Invoke();//Abhay

    end;

    [Test]
    [HandlerFunctions('MessageHandler')]
    procedure "PCN020-Update Purchase Quote"();
    var
        "Fixed Asset": Record "Fixed Asset";
        Item: Record Item;
        "Item Charge": Record "Item Charge";
        JobQueueEntry: Record "Job Queue Entry";
        Location: Record Location;
        PurchHdr: Record "Purchase Header";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        Vendor: Record Vendor;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        PurchQuoteNo: Code[20];
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ApprovalEntries: TestPage "Approval Entries";
        EditDimensionSetEntries: TestPage "Edit Dimension Set Entries";
        ItemChargeAssignmentPurch: TestPage "Item Charge Assignment (Purch)";
        GetReceiptLines: TestPage "Purch. Receipt Lines";
        PurchaseQuote: TestPage "Purchase Quote";
        PurchaseQuoteList: TestPage "Purchase Quotes";
        RequeststoApprove: TestPage "Requests to Approve";
        Workflow: Record Workflow;
    begin
        DimensionRestrictionCheck;//HEI.95
        //HEI.06
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN020', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN020', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);


        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN020', CompanyName, Database::"User Setup");
        UserSetup.Get(UnitTestingValues.Value);


        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN020', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);

        //Create a PQ

        //PurchaseQuoteList.OPENNEW;
        PurchaseQuote.OpenNew();
        PurchaseQuote.New();
        PurchaseQuote."Buy-from Vendor Name".SetValue(Vendor.Name);
        PurchaseQuote."Vendor Order No.".SetValue('TEST_PCN020');
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseQuote."Location Code".SetValue(Location.Code);
        //HEI.51<<
        PurchaseQuote."Requestor ID IBM".SETVALUE(UserSetup."User ID");//BC UPGRADE KUMARR78 DIT Field Removed. // BC Upgrade BHARDA11 -- Add requester ID IBM
        PurchaseQuote.PurchLines.Type.SetValue(Type::Item);
        PurchaseQuote.PurchLines."No.".SetValue(Item."No.");
        PurchaseQuote.PurchLines.Quantity.SetValue(1);
        PurchaseQuote.PurchLines."Location Code".SetValue(Location.Code);
        PurchQuoteNo := PurchaseQuote."No.".Value;
        // BC Upgrade BHARDA11 >>
        if PurchHdr.get(PurchHdr."Document Type"::Quote, PurchQuoteNo) then;
        // BC Upgrade BHARDA11 <<
        //Send for approval and Approve entry
        //HEI.26>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        // JobQueueEntry.SetRange("Object ID to Run", 50085);
        JobQueueEntry.SetRange("Object ID to Run", 51015); // BC Upgrade BHARDA11
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.26<<
        //HEI.27>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        JobQueueEntry.SetRange("Object ID to Run", 1509);
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.27<<
        //HEI.31>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetFilter("Object Type to Run", '%1', JobQueueEntry."Object Type to Run"::Report);
        JobQueueEntry.SetRange("Object ID to Run", 111);
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.31<<
        //HEI.49>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Report);
        // JobQueueEntry.SetRange("Object ID to Run", 50239);
        JobQueueEntry.SetRange("Object ID to Run", 58021);  // BC Upgrade BHARDA11
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.49<<
        //HEI.52>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        // JobQueueEntry.SetRange("Object ID to Run", 50125);
        JobQueueEntry.SetRange("Object ID to Run", 58111); // BC Upgrade BHARDA11
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.52<<
        //HEI.53>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        //HEI.74>>
        if JobQueueEntry.FindFirst() then
            JobQueueEntry.ModifyAll(Status, JobQueueEntry.Status::Ready);
        // IF JobQueueEntry.FINDSET THEN BEGIN
        // REPEAT
        // JobQueueEntry.Status:=JobQueueEntry.Status::Ready;
        // JobQueueEntry.MODIFY;
        // UNTIL JobQueueEntry.NEXT=0;
        // END;
        //HEI.74<<
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //HEI.53<<  
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchHdr) then
            PurchaseQuote.SendApprovalRequest.Invoke();
        //ApprovalEntries.TRAP;
        //PurchaseQuote.Approvals.INVOKE;
        PurchaseQuote.Close();
        /*
        PurchaseHeader.GET(PurchaseHeader."Document Type"::Quote,PurchaseQuote."No.".VALUE);
        IF ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) THEN BEGIN
          PurchaseQuote.SendApprovalRequest.INVOKE;
          ApprovalEntries.TRAP;
          PurchaseQuote.Approvals.INVOKE;
          UserSetup.GET(ApprovalEntries."Approver ID".VALUE);
          UserSetup.Substitute := USERID;
          UserSetup."Approval Administrator":=TRUE;
          UserSetup.MODIFY;

          //Update Approval Limit for USERID
          UserSetup2.GET(USERID);
          IF NOT UserSetup2."Unlimited Purchase Approval" OR NOT UserSetup2."Unlimited Request Approval" THEN BEGIN
            UserSetup2."Unlimited Purchase Approval" := TRUE;
            UserSetup2."Unlimited Request Approval" := TRUE;
            //UserSetup2."Approval Administrator":=TRUE;
            UserSetup2.MODIFY;
          END;

          //Delegate Approval Request
          ApprovalEntries.Action35.INVOKE;

          //Approve Approval Entry
          PurchaseQuote.Approve.INVOKE;
        END;
        */

        // Cancel Approval request
        PurchaseQuoteList.OpenView();
        PurchaseQuoteList.Filter.SetFilter("No.", PurchQuoteNo);
        PurchaseQuote.OpenEdit();
        PurchaseQuote.Filter.SetFilter("No.", PurchQuoteNo);//HEI.20
        PurchaseQuote.CancelApprovalRequest.Invoke(); // BC Upgrade BHARAD11 
        PurchaseQuote.Reopen.Invoke();


        PurchaseQuote.PurchLines.Quantity.SetValue(2);
        PurchaseQuote.PurchLines."Direct Unit Cost".SetValue(200);


        /*IF ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchHdr) THEN
          PurchaseQuote.SendApprovalRequest.INVOKE;
          ApprovalEntries.TRAP;
          PurchaseQuote.Approvals.INVOKE;*/
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Quote, PurchaseQuote."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            PurchaseQuote.SendApprovalRequest.Invoke();
            ApprovalEntries.Trap();
            PurchaseQuote.Approvals.Invoke();
            UserSetup.Get(ApprovalEntries."Approver ID".Value);
            UserSetup.Substitute := UserId;
            UserSetup."Approval Administrator" := true;
            UserSetup.Modify();

            //Update Approval Limit for USERID
            UserSetup2.Get(UserId);
            if not UserSetup2."Unlimited Purchase Approval" or not UserSetup2."Unlimited Request Approval" then begin
                UserSetup2."Unlimited Purchase Approval" := true;
                UserSetup2."Unlimited Request Approval" := true;
                //UserSetup2."Approval Administrator":=TRUE;
                UserSetup2.Modify();
            end;

            //Delegate Approval Request

            // ApprovalEntries.Action35.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
            ApprovalEntries."&Delegate".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

            //Approve Approval Entry
            PurchaseQuote.Approve.Invoke();
        end
        else//HEI.20
            Error('Workflows is Disable');//HEI.20 //Abhay

    end;

    [Test]
    [HandlerFunctions('MessageHandler')]
    procedure "PCN021 Reject Purchase Quote"();
    var
        Vendor: Record Vendor;
        "Item Charge": Record "Item Charge";
        PurchaseQuote: TestPage "Purchase Quote";
        GetReceiptLines: TestPage "Purch. Receipt Lines";
        ItemChargeAssignmentPurch: TestPage "Item Charge Assignment (Purch)";
        EditDimensionSetEntries: TestPage "Edit Dimension Set Entries";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        UserSetup: Record "User Setup";
        Item: Record Item;
        Location: Record Location;
        "Fixed Asset": Record "Fixed Asset";
        RequeststoApprove: TestPage "Requests to Approve";
        ApprovalEntries: TestPage "Approval Entries";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        PurchHdr: Record "Purchase Header";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        PurchQuoteNo: Code[20];
        PurchaseQuoteList: TestPage "Purchase Quotes";
        JobQueueEntry: Record "Job Queue Entry";
        Workflow: Record Workflow;
    begin
        DimensionRestrictionCheck;//HEI.95
        //HEI.06
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN021', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN021', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);


        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN021', CompanyName, Database::"User Setup");
        UserSetup.Get(UnitTestingValues.Value);


        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN021', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);

        //Create a PQ

        //PurchaseQuoteList.OPENNEW;
        PurchaseQuote.OpenNew();
        PurchaseQuote.New();
        PurchaseQuote."Buy-from Vendor Name".SetValue(Vendor.Name);
        PurchaseQuote."Vendor Order No.".SetValue('TEST_PCN021');
        PurchaseQuote."Requestor ID IBM".SETVALUE(UserSetup."User ID");//BC UPGRADE KUMARR78 DIT Field Removed. // BC Upgrade BHARAD11 -- Change requester ID
        PurchaseQuote.PurchLines.Type.SetValue(Type::Item);
        PurchaseQuote.PurchLines."No.".SetValue(Item."No.");
        PurchaseQuote.PurchLines.Quantity.SetValue(1);
        PurchaseQuote.PurchLines."Location Code".SetValue(Location.Code);
        PurchQuoteNo := PurchaseQuote."No.".Value;

        //Send for approval
        //HEI.26>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        // JobQueueEntry.SetRange("Object ID to Run", 50085);
        JobQueueEntry.SetRange("Object ID to Run", 51015); // BC Upgrade BHARDA11
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.26<<
        //HEI.27>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        JobQueueEntry.SetRange("Object ID to Run", 1509);
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.27<<
        //HEI.31>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetFilter("Object Type to Run", '%1', JobQueueEntry."Object Type to Run"::Report);
        JobQueueEntry.SetRange("Object ID to Run", 111);
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.31<<
        //HEI.49>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Report);
        // JobQueueEntry.SetRange("Object ID to Run", 50239);
        JobQueueEntry.SetRange("Object ID to Run", 58021);  // BC Upgrade BHARDA11
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.49<<
        //HEI.52>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        // JobQueueEntry.SetRange("Object ID to Run", 50125);
        JobQueueEntry.SetRange("Object ID to Run", 58111); // BC Upgrade BHARDA11
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.52<<
        //HEI.53>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        //HEI.74>>
        if JobQueueEntry.FindFirst() then
            JobQueueEntry.ModifyAll(Status, JobQueueEntry.Status::Ready);
        // IF JobQueueEntry.FINDSET THEN BEGIN
        // REPEAT
        // JobQueueEntry.Status:=JobQueueEntry.Status::Ready;
        // JobQueueEntry.MODIFY;
        // UNTIL JobQueueEntry.NEXT=0;
        // END;
        //HEI.74<<
        // BC Upgrade BHARDA11 >>
        if PurchHdr.get(PurchHdr."Document Type"::Quote, PurchQuoteNo) then;
        // BC Upgrade BHARDA11 <<
        //HEI.53<<
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchHdr) then
            PurchaseQuote.SendApprovalRequest.Invoke();
        //ApprovalEntries.TRAP;
        //PurchaseQuote.Approvals.INVOKE;
        PurchaseQuote.Close();

        // Cancel Approval request
        PurchaseQuoteList.OpenView();
        PurchaseQuoteList.Filter.SetFilter("No.", PurchQuoteNo);
        PurchaseQuote.OpenEdit();
        PurchaseQuote.Filter.SetFilter("No.", PurchQuoteNo);//HEI.20
        PurchaseQuote.CancelApprovalRequest.Invoke(); // BC Upgrade BHARDA11 -- Swap Both
        PurchaseQuote.Reopen.Invoke(); // BC Upgrade BHARDA11 -- Swap Both


        PurchaseQuote.PurchLines.Quantity.SetValue(2);
        PurchaseQuote.PurchLines."Direct Unit Cost".SetValue(200);

        /*
        IF ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchHdr) THEN BEGIN
          PurchaseQuote.SendApprovalRequest.INVOKE;
          ApprovalEntries.TRAP;
          PurchaseQuote.Approvals.INVOKE;

         //Update Substitute for Approver ID = USERID
          UserSetup.GET(ApprovalEntries."Approver ID".VALUE);
          UserSetup.Substitute := USERID;
          UserSetup.MODIFY;

        END ELSE
            RequeststoApprove.OPENVIEW;
        */
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Quote, PurchaseQuote."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            PurchaseQuote.SendApprovalRequest.Invoke();
            ApprovalEntries.Trap();
            PurchaseQuote.Approvals.Invoke();
            UserSetup.Get(ApprovalEntries."Approver ID".Value);
            UserSetup.Substitute := UserId;
            UserSetup."Approval Administrator" := true;
            UserSetup.Modify();

            //Update Approval Limit for USERID
            UserSetup2.Get(UserId);
            if not UserSetup2."Unlimited Purchase Approval" or not UserSetup2."Unlimited Request Approval" then begin
                UserSetup2."Unlimited Purchase Approval" := true;
                UserSetup2."Unlimited Request Approval" := true;
                //UserSetup2."Approval Administrator":=TRUE;
                UserSetup2.Modify();
            end;

            //Delegate Approval Request

            // ApprovalEntries.Action35.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
            ApprovalEntries."&Delegate".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

            //Approve Approval Entry
            PurchaseQuote.Reject.Invoke();
        end
        else//HEI.20
            Error('Workflows is Disable');//HEI.20//Abhay

    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,MessageHandler')]
    procedure "PCN026 Sent PO to Approval"();
    var
        Vendor: Record Vendor;
        "Item Charge": Record "Item Charge";
        PurchaseQuoteList: TestPage "Purchase Quotes";
        PurchaseOrder: TestPage "Purchase Order";
        GetReceiptLines: TestPage "Purch. Receipt Lines";
        ItemChargeAssignmentPurch: TestPage "Item Charge Assignment (Purch)";
        EditDimensionSetEntries: TestPage "Edit Dimension Set Entries";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        UserSetup: Record "User Setup";
        Item: Record Item;
        Location: Record Location;
        "Fixed Asset": Record "Fixed Asset";
        RequeststoApprove: TestPage "Requests to Approve";
        ApprovalEntries: TestPage "Approval Entries";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        PurchHdr: Record "Purchase Header";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        PONumber: Code[20];
        POStatus: Option Open,Released,"Pending Approval","Pending Prepayment";
        Approvalusersetup: Record "User Setup";
        JobQueueEntry: Record "Job Queue Entry";
        Workflow: Record Workflow;
    begin
        DimensionRestrictionCheck;//HEI.95
        //HEI.06
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN026', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN026', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);


        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN026', CompanyName, Database::"User Setup");
        UserSetup.Get(UnitTestingValues.Value);


        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN026', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);

        //Create a PO

        //PurchaseQuoteList.OPENNEW;
        PurchaseOrder.OpenNew();
        PurchaseOrder.New();
        PurchaseOrder."Buy-from Vendor Name".SetValue(Vendor.Name);
        PurchaseOrder."Vendor Order No.".SetValue('TEST_PCN026');
        // PurchaseOrder."Requester ID".SETVALUE(UserSetup."User ID");//BC UPGRADE KUMARR78 DIT Field Removed.
        PurchaseOrder.PurchLines.Type.SetValue(Type::Item);
        PurchaseOrder.PurchLines."No.".SetValue(Item."No.");
        PurchaseOrder.PurchLines.Quantity.SetValue(1);
        PurchaseOrder.PurchLines."Location Code".SetValue(Location.Code);
        PONumber := PurchaseOrder."No.".Value;
        //HEI.20>>
        //HEI.26>>
        //IF Approvalusersetup.GET(USERID) THEN BEGIN
        Approvalusersetup.Reset();
        Approvalusersetup.SetFilter("Salespers./Purch. Code", '<>%1', '');
        Approvalusersetup.SetRange("Unlimited Purchase Approval", false);
        if Approvalusersetup.FindFirst() then begin
            //HEI.26<<
            //IF PurchaseOrder."Purchaser Code".VALUE='' THEN //HEI.50
            if (PurchaseOrder."Purchaser Code".Value = '') or
              (PurchaseOrder."Purchaser Code".Value <> Approvalusersetup."Salespers./Purch. Code") then//HEI.50
                PurchaseOrder."Purchaser Code".SetValue(Approvalusersetup."Salespers./Purch. Code");
        end else
        //HEI.65>>
        begin
            Approvalusersetup.SetRange("Unlimited Purchase Approval");
            Approvalusersetup.SetRange("Unlimited Purchase Approval", true);
            if Approvalusersetup.FindFirst() then begin
                if (PurchaseOrder."Purchaser Code".Value = '') or
                (PurchaseOrder."Purchaser Code".Value <> Approvalusersetup."Salespers./Purch. Code") then
                    PurchaseOrder."Purchaser Code".SetValue(Approvalusersetup."Salespers./Purch. Code");
            end;
        end;
        //HEI.65<<
        //HEI.20<<
        //HEI.26>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        // JobQueueEntry.SetRange("Object ID to Run", 50085);
        JobQueueEntry.SetRange("Object ID to Run", 51015); // BC Upgrade BHARDA11
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.26<<
        //HEI.27>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        JobQueueEntry.SetRange("Object ID to Run", 1509);
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.27<<
        //HEI.31>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetFilter("Object Type to Run", '%1', JobQueueEntry."Object Type to Run"::Report);
        JobQueueEntry.SetRange("Object ID to Run", 111);
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.31<<
        //HEI.48>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Report);
        // JobQueueEntry.SetRange("Object ID to Run", 50239);
        JobQueueEntry.SetRange("Object ID to Run", 58021);  // BC Upgrade BHARDA11
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.48<<
        //HEI.52>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        // JobQueueEntry.SetRange("Object ID to Run", 50125);
        JobQueueEntry.SetRange("Object ID to Run", 58111); // BC Upgrade BHARDA11
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.52<<
        //HEI.53>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        //HEI.74>>
        if JobQueueEntry.FindFirst() then
            JobQueueEntry.ModifyAll(Status, JobQueueEntry.Status::Ready);
        // IF JobQueueEntry.FINDSET THEN BEGIN
        // REPEAT
        // JobQueueEntry.Status:=JobQueueEntry.Status::Ready;
        // JobQueueEntry.MODIFY;
        // UNTIL JobQueueEntry.NEXT=0;
        // END;
        //HEI.74<<

        //HEI.53<<
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Send for approval
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then
            PurchaseOrder.SendApprovalRequest.Invoke()
        else//HEI.20
            Error('Workflows is Disable');//HEI.20

        //ApprovalEntries.TRAP;
        //PurchaseOrder.Approvals.INVOKE;

        /*
      PurchaseHeader.GET(PurchaseHeader."Document Type"::Order,PurchaseOrder."No.".VALUE);
      IF ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) THEN BEGIN
        PurchaseOrder.SendApprovalRequest.INVOKE;
        ApprovalEntries.TRAP;
        PurchaseOrder.Approvals.INVOKE;
        UserSetup.GET(ApprovalEntries."Approver ID".VALUE);
        UserSetup.Substitute := USERID;
        UserSetup."Approval Administrator":=TRUE;
        UserSetup.MODIFY;

        //Update Approval Limit for USERID
        UserSetup2.GET(USERID);
        IF NOT UserSetup2."Unlimited Purchase Approval" OR NOT UserSetup2."Unlimited Request Approval" THEN BEGIN
          UserSetup2."Unlimited Purchase Approval" := TRUE;
          UserSetup2."Unlimited Request Approval" := TRUE;
          //UserSetup2."Approval Administrator":=TRUE;
          UserSetup2.MODIFY;
        END;

        //Delegate Approval Request
        ApprovalEntries.Action35.INVOKE;

        //Approve Approval Entry
        PurchaseOrder.Approve.INVOKE;
        END;

      */
        //PurchaseOrder.OPENVIEW;
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        PurchaseOrder.Filter.SetFilter("No.", PONumber);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then //HEI.20
            PurchaseOrder.Status.AssertEquals(POStatus::"Pending Approval");

    end;

    [Test]
    // [HandlerFunctions('ConfirmationHandler,MessageHandler')]
    [HandlerFunctions('MessageHandler')] // BC Upgrade PATELS08 - Blocking ConfirmationHandler as it is not required for this test case
    procedure "PCN028 Approve Purchase Order"();
    var
        Vendor: Record Vendor;
        "Item Charge": Record "Item Charge";
        PurchaseQuoteList: TestPage "Purchase Quotes";
        PurchaseOrder: TestPage "Purchase Order";
        GetReceiptLines: TestPage "Purch. Receipt Lines";
        ItemChargeAssignmentPurch: TestPage "Item Charge Assignment (Purch)";
        EditDimensionSetEntries: TestPage "Edit Dimension Set Entries";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        UserSetup: Record "User Setup";
        Item: Record Item;
        Location: Record Location;
        "Fixed Asset": Record "Fixed Asset";
        RequeststoApprove: TestPage "Requests to Approve";
        ApprovalEntries: TestPage "Approval Entries";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        PurchHdr: Record "Purchase Header";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        PONumber: Code[20];
        POStatus: Option Open,Released,"Pending Approval","Pending Prepayment";
        Approvalusersetup: Record "User Setup";
        JobQueueEntry: Record "Job Queue Entry";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Purch_Hdr: Record "Purchase Header";
        ApprovalsMgmtNew: Codeunit "Approvals Mgmt.";
    begin
        DimensionRestrictionCheck;//HEI.95
        //HEI.06
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN028', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN028', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);


        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN028', CompanyName, Database::"User Setup");
        UserSetup.Get(UnitTestingValues.Value);


        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN028', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);

        //Create a PO
        //PurchaseQuoteList.OPENNEW;
        PurchaseOrder.OpenNew();
        PurchaseOrder.New();
        PurchaseOrder."Buy-from Vendor Name".SetValue(Vendor.Name);
        PurchaseOrder."Vendor Order No.".SetValue('TEST_PCN028');
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseOrder."Location Code".SetValue(Location.Code);
        //HEI.51<<
        PurchaseOrder."Requester ID".SETVALUE(UserSetup."User ID");//BC UPGRADE KUMARR78 DIT Field Removed.
        PurchaseOrder.PurchLines.Type.SetValue(Type::Item);
        PurchaseOrder.PurchLines."No.".SetValue(Item."No.");
        PurchaseOrder.PurchLines.Quantity.SetValue(1);
        PurchaseOrder.PurchLines."Location Code".SetValue(Location.Code);
        //PONumber := PurchaseOrder."No.".VALUE;
        //HEI.20>>
        //HEI.26>>
        //IF Approvalusersetup.GET(USERID) THEN BEGIN
        Approvalusersetup.Reset();
        Approvalusersetup.SetFilter("Salespers./Purch. Code", '<>%1', '');
        Approvalusersetup.SetRange("Unlimited Purchase Approval", false);
        if Approvalusersetup.FindFirst() then begin
            //HEI.26<<
            //IF PurchaseOrder."Purchaser Code".VALUE='' THEN//HEI.50
            if (PurchaseOrder."Purchaser Code".Value = '') or //HEI.50
              (PurchaseOrder."Purchaser Code".Value <> Approvalusersetup."Salespers./Purch. Code") then //HEI.50
                PurchaseOrder."Purchaser Code".SetValue(Approvalusersetup."Salespers./Purch. Code");
        end
        //HEI.65<<
        else begin
            Approvalusersetup.SetRange("Unlimited Purchase Approval");
            Approvalusersetup.SetRange("Unlimited Purchase Approval", true);
            if Approvalusersetup.FindFirst() then begin
                if (PurchaseOrder."Purchaser Code".Value = '') or
               (PurchaseOrder."Purchaser Code".Value <> Approvalusersetup."Salespers./Purch. Code") then
                    PurchaseOrder."Purchaser Code".SetValue(Approvalusersetup."Salespers./Purch. Code");
            end
        end;
        //HEI.65>>

        //HEI.20<<
        //HEI.26>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        // JobQueueEntry.SetRange("Object ID to Run", 50085);
        JobQueueEntry.SetRange("Object ID to Run", 51015);
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.26<<
        //HEI.27>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        JobQueueEntry.SetRange("Object ID to Run", 1509);
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.27<<
        //HEI.31>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetFilter("Object Type to Run", '%1', JobQueueEntry."Object Type to Run"::Report);
        JobQueueEntry.SetRange("Object ID to Run", 111);
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.31<<
        //HEI.48>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Report);
        // JobQueueEntry.SetRange("Object ID to Run", 50239);
        JobQueueEntry.SetRange("Object ID to Run", 58021);  // BC Upgrade BHARDA11
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.48<<
        //HEI.52>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        // JobQueueEntry.SetRange("Object ID to Run", 50125);
        JobQueueEntry.SetRange("Object ID to Run", 58111); // BC Upgrade BHARDA11
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        //HEI.52<<
        //HEI.53>>
        JobQueueEntry.Reset();
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        //HEI.74>>
        if JobQueueEntry.FindFirst() then
            JobQueueEntry.ModifyAll(Status, JobQueueEntry.Status::Ready);
        // IF JobQueueEntry.FINDSET THEN BEGIN
        // REPEAT
        // JobQueueEntry.Status:=JobQueueEntry.Status::Ready;
        // JobQueueEntry.MODIFY;
        // UNTIL JobQueueEntry.NEXT=0;
        // END;
        //HEI.74<<

        //HEI.53<<
        //Send for approval and Approve entry
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);//Abhay
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            PurchaseOrder.SendApprovalRequest.Invoke();
            ApprovalEntries.Trap();
            PurchaseOrder.Approvals.Invoke();
            UserSetup.Get(ApprovalEntries."Approver ID".Value);
            UserSetup.Substitute := UserId;
            UserSetup."Approval Administrator" := true;
            UserSetup.Modify();

            //Update Approval Limit for USERID
            UserSetup2.Get(UserId);
            if not UserSetup2."Unlimited Purchase Approval" or not UserSetup2."Unlimited Request Approval" then begin
                UserSetup2."Unlimited Purchase Approval" := true;
                UserSetup2."Unlimited Request Approval" := true;
                //UserSetup2."Approval Administrator":=TRUE;
                UserSetup2.Modify();
            end;

            //Delegate Approval Request

            // ApprovalEntries.Action35.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
            ApprovalEntries."&Delegate".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name
            //Approve Approval Entry
            // BC Upgrade BHARDA11 >>
            ApprovalEntries.Close(); // BC UPGRADE PATELS08 - added code
            PurchaseOrder.Approve.Invoke(); // BC UPGRADE PATELS08
            // if Purch_Hdr.get(Purch_Hdr."Document Type"::Order, PurchaseOrder."No.".Value) then begin
            //     ApprovalsMgmtNew.ApproveRecordApprovalRequest(Purch_Hdr.RecordId);
            // end; // BC UPGRADE PATELS08
            // BC Upgrade BHARDA11 <<
        end
        else//HEI.20
            Error('Workflows is Disable');//HEI.20//Abhay
    end;





    [Test]
    procedure PCN001_ValidateContractHeader();
    var
        InterfaceLogHeader: Record "Interface Log Header INT";
        TestDate: Date;
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseHeader: Record "Purchase Header";
        BlanketPurchaseOrderList: TestPage "Blanket Purchase Orders";
    begin
        DimensionRestrictionCheck;//HEI.95
        //HEI.07 >>
        //HEI.20>>
        // IF UnitTestingValue.GET('PCN001',COMPANYNAME,DATABASE::"Purchase Header") THEN;
        // BlanketPurchaseOrder.OPENVIEW;
        // BlanketPurchaseOrder.FILTER.SETFILTER("No.",UnitTestingValue.Value);
        UnitTestingValue.GET('PCN001', COMPANYNAME, DATABASE::"Purchase Header");
        PurchaseHeader.GET(PurchaseHeader."Document Type"::"Blanket Order", UnitTestingValue.Value);
        //HEI.73>>
        BlanketPurchaseOrderList.OPENVIEW;
        BlanketPurchaseOrderList.FILTER.SETFILTER("No.", PurchaseHeader."No.");
        //HEI.73<<
        BlanketPurchaseOrder.OPENVIEW;
        BlanketPurchaseOrder.FILTER.SETFILTER("No.", PurchaseHeader."No.");
        //HEI.20<<
        InterfaceLogHeader.RESET;
        InterfaceLogHeader.SETRANGE("Source No.", BlanketPurchaseOrder."No.".VALUE);
        InterfaceLogHeader.SETRANGE("Action Code", '02');
        InterfaceLogHeader.SETRANGE(Direction, InterfaceLogHeader.Direction::Inbound);
        //IF InterfaceLogHeader.FINDFIRST THEN BEGIN  //HEI.20
        IF InterfaceLogHeader.FINDLAST THEN BEGIN     //HEI.20
            BlanketPurchaseOrder."Buy-from Vendor No.".ASSERTEQUALS(InterfaceLogHeader."Buy-from Vendor No.");
            //BlanketPurchaseOrder."Purchaser Code".ASSERTEQUALS(InterfaceLogHeader."Salespers./Purch. Code"); //HEI.96
            GeneralLedgerSetup.GET;
            IF InterfaceLogHeader."Currency Code" <> GeneralLedgerSetup."LCY Code" THEN
                BlanketPurchaseOrder."Currency Code".ASSERTEQUALS(InterfaceLogHeader."Currency Code");
            //BlanketPurchaseOrder."Payment Terms Code".ASSERTEQUALS(InterfaceLogHeader."Payment Terms Code");//HEI.63
            BlanketPurchaseOrder."Shipment Method Code".ASSERTEQUALS(InterfaceLogHeader."Shipment Method");

            //BC UPGRADE KUMARR78 >>DIT Variable Removed.("SRM Contract No.","SRM Contract Name","SRM Contract Type","Valid From") // BC Upgrade BHARDA11 >> --Uncomment Code
            BlanketPurchaseOrder."SRM Contract No.".ASSERTEQUALS(InterfaceLogHeader."External Contract No.");
            BlanketPurchaseOrder."SRM Contract Name".ASSERTEQUALS(InterfaceLogHeader."External Contract Name");
            BlanketPurchaseOrder."SRM Contract Type".ASSERTEQUALS(InterfaceLogHeader."Contract Type");
            BlanketPurchaseOrder."Valid From".ASSERTEQUALS(InterfaceLogHeader."Valid From");
            //BC UPGRADE KUMARR78 <<DIT Variable Removed.("SRM Contract No.","SRM Contract Name","SRM Contract Type","Valid From")  // BC Upgrade BHARDA11 << --Uncomment Code

            //BlanketPurchaseOrder."Valid To".ASSERTEQUALS(InterfaceLogHeader."Valid To");//HEI.64
            //BlanketPurchaseOrder.Channel.ASSERTEQUALS(InterfaceLogHeader.Channel);

            //BC UPGRADE KUMARR78 >>DIT Variable Removed.("Target Value Amount")  // BC Upgrade BHARDA11 >> --Uncomment Code
            IF InterfaceLogHeader.Channel = 'A' THEN
                BlanketPurchaseOrder."Target Value Amount".ASSERTEQUALS(0);
            //BC UPGRADE KUMARR78 <<DIT Variable Removed.("Target Value Amount")  // BC Upgrade BHARDA11 << --Uncomment Code

            //  ELSE//HEI.64
            //    BlanketPurchaseOrder."Target Value Amount".ASSERTEQUALS(InterfaceLogHeader.Amount);//HEI.64

            // BlanketPurchaseOrder."Shipment Method Location".ASSERTEQUALS(InterfaceLogHeader."Shipment Method Location");//BC UPGRADE KUMARR78 DIT Variable Removed.("Shipment Method Location")
            BlanketPurchaseOrder.EDIT.INVOKE;
            BlanketPurchaseOrder."Vendor Shipment No.".SETVALUE('PCN001');
        END
        ELSE
            ERROR('Please check the interface log');
        BlanketPurchaseOrder.OK.INVOKE;
        //HEI.07 <<
    end;

    [Test]
    procedure PCN002_ValidateContractItems();
    var
        InterfaceLogHeader: Record "Interface Log Header INT";
        InterfaceLogLine: Record "Interface Log Line INT";
        PurchaseLinePrices: TestPage "Purchase Line Prices CBN";
        GeneralLedgerSetup: Record "General Ledger Setup";
        BlockError: TextConst ENU = 'Validation error for Field: Qty. to Receive,  Message = ''Block Line Ordering must be equal to '' ''  in Purchase Line: Document Type=Blanket Order, Document No.=%1, Line No.=%2. Current value is ''B''.''';
        BlockError1: Text;
        PurchaseHeader: Record "Purchase Header";
        BlanketPurchaseOrder: TestPage "Blanket Purchase Order";
        purchStartDate: Date;
        purchEndDate: Date;
        BlanketStartDate: Date;
        BlanketEndDate: Date;
    begin
        DimensionRestrictionCheck;//HEI.95
        //HEI.07 >>
        //HEI.20
        // IF UnitTestingValue.GET('PCN002',COMPANYNAME,DATABASE::"Purchase Header") THEN;
        // BlanketPurchaseOrder.OPENVIEW;
        // BlanketPurchaseOrder.FILTER.SETFILTER("No.",UnitTestingValue.Value);
        UnitTestingValue.GET('PCN002', COMPANYNAME, DATABASE::"Purchase Header");
        //HEI.109>>
        IF UnitTestingValue.Value = '' THEN
            EXIT;
        //HEI.109<<
        PurchaseHeader.GET(PurchaseHeader."Document Type"::"Blanket Order", UnitTestingValue.Value);
        BlanketPurchaseOrder.OPENVIEW;
        BlanketPurchaseOrder.FILTER.SETFILTER("No.", PurchaseHeader."No.");
        //HEI.20<<
        InterfaceLogHeader.RESET;
        InterfaceLogHeader.SETRANGE("Source No.", BlanketPurchaseOrder."No.".VALUE);
        InterfaceLogHeader.SETRANGE("Action Code", '02');
        InterfaceLogHeader.SETRANGE(Direction, InterfaceLogHeader.Direction::Inbound);
        //IF InterfaceLogHeader.FINDFIRST THEN BEGIN    //HEI.20
        IF InterfaceLogHeader.FINDLAST THEN BEGIN      //HEI.20
            InterfaceLogLine.SETRANGE("Header Entry No.", InterfaceLogHeader."Entry No.");
            InterfaceLogLine.SETRANGE("No.", BlanketPurchaseOrder.PurchLines1."No.".VALUE);//HEI.55
            IF InterfaceLogLine.FINDSET THEN BEGIN
                REPEAT
                    BlanketPurchaseOrder.PurchLines1.FILTER.SETFILTER("No.", InterfaceLogLine."No.");
                    BlanketPurchaseOrder.PurchLines1.FILTER.SETFILTER("SRM Contract Line No. FND", InterfaceLogLine."External Contract Line No.");//HEI.66
                    BlanketPurchaseOrder.PurchLines1.Type.ASSERTEQUALS('Item');
                    BlanketPurchaseOrder.PurchLines1."No.".ASSERTEQUALS(InterfaceLogLine."No.");
                    BlanketPurchaseOrder.PurchLines1."Location Code".ASSERTEQUALS(InterfaceLogLine."Location Code");
                    //BlanketPurchaseOrder.PurchLines.Quantity.ASSERTEQUALS(InterfaceLogLine.Quantity);//HEI.57
                    //BlanketPurchaseOrder.PurchLines."Unit of Measure Code".ASSERTEQUALS(InterfaceLogLine."Unit of Measure Code");
                    //BlanketPurchaseOrder.PurchLines.Control304.ASSERTEQUALS(InterfaceLogLine."CMG Code");
                    BlanketPurchaseOrder.PurchLines1."SRM Contract No.".ASSERTEQUALS(InterfaceLogLine."External Contract No.");
                    BlanketPurchaseOrder.PurchLines1."Tolerance Received Over %".ASSERTEQUALS(InterfaceLogLine."Over Percent");
                    BlanketPurchaseOrder.PurchLines1."Tolerance Received Under %".ASSERTEQUALS(InterfaceLogLine."Under Percent");
                    IF BlanketPurchaseOrder.PurchLines1."Block Line Ordering".VALUE = 'B' THEN BEGIN
                        ASSERTERROR BlanketPurchaseOrder.PurchLines1."Qty. to Receive".SETVALUE(1);
                        //IF GETLASTERRORTEXT<>BlockError THEN //HEI.20
                        //IF GETLASTERRORTEXT<>STRSUBSTNO(BlockError,BlanketPurchaseOrder."No.",BlanketPurchaseOrder.PurchLines."Line No.") THEN   //HEI.20 //HEI.55
                        //  ERROR('Unexpected Error: %1', GETLASTERRORTEXT);//HEI.55
                        EXIT;
                    END;
                    BlanketPurchaseOrder.PurchLines1."SRM Contract Line No.".ASSERTEQUALS(InterfaceLogLine."External Contract Line No.");
                    BlanketPurchaseOrder.PurchLines1."SRM Contract Type".ASSERTEQUALS(InterfaceLogHeader."Contract Type");
                    BlanketPurchaseOrder.PurchLines1."Valid From".ASSERTEQUALS(InterfaceLogHeader."Valid From");
                    BlanketPurchaseOrder.PurchLines1."Valid To".ASSERTEQUALS(InterfaceLogHeader."Valid To");

                    //BC UPGRADE KUMARR78 >> DIT Variable Removed.(Channel) Need to block the Entire Section.
                    IF BlanketPurchaseOrder.Channel.VALUE = 'A' THEN BEGIN
                        BlanketPurchaseOrder.PurchLines1."Page Purchase Line Prices".invoke();
                        PurchaseLinePrices.OPENVIEW;
                        PurchaseLinePrices.FILTER.SETFILTER("SRM Contract No.", InterfaceLogLine."External Contract No.");
                        PurchaseLinePrices.FILTER.SETFILTER("SRM Contract Line No.", InterfaceLogLine."External Contract Line No.");
                        PurchaseLinePrices."SRM Contract No.".ASSERTEQUALS(InterfaceLogLine."External Contract No.");
                        PurchaseLinePrices."SRM Contract Line No.".ASSERTEQUALS(InterfaceLogLine."External Contract Line No.");
                        PurchaseLinePrices.LAST;//HEI.68
                                                //IF (PurchaseLinePrices."Starting Date".VALUE>BlanketPurchaseOrder.PurchLines."Valid From".VALUE) OR//HEI.52
                                                //  (PurchaseLinePrices."Ending Date".VALUE<BlanketPurchaseOrder.PurchLines."Valid To".VALUE) THEN  //HEI.52
                                                //HEI.102>>
                                                //IF UPPERCASE(COMPANYNAME) <> 'BREWCO' THEN BEGIN//HEI.60
                        IF NOT (UPPERCASE(COMPANYNAME) IN ['BREWCO', '10_BUKAVU']) THEN BEGIN
                            //HEI.110>>
                            EVALUATE(purchStartDate, PurchaseLinePrices."Starting Date".VALUE);
                            EVALUATE(purchEndDate, PurchaseLinePrices."Ending Date".VALUE);
                            EVALUATE(BlanketStartDate, BlanketPurchaseOrder.PurchLines."Valid From".VALUE);
                            EVALUATE(BlanketEndDate, BlanketPurchaseOrder.PurchLines."Valid To".VALUE);
                            //HEI.102<<
                            //IF (PurchaseLinePrices."Starting Date".VALUE>BlanketPurchaseOrder.PurchLines."Valid From".VALUE) AND//HEI.52
                            //(PurchaseLinePrices."Ending Date".VALUE<BlanketPurchaseOrder.PurchLines."Valid To".VALUE) THEN  //HEI.52
                            IF ((purchStartDate < TODAY) AND (purchEndDate < TODAY)) OR
                                (purchStartDate > BlanketEndDate) THEN
                                //HEI.110<<
                                ERROR('Price is not in the range');
                        END;//HEI.60
                            //PurchaseLinePrices."Location Code".ASSERTEQUALS('');//HEI.54
                        PurchaseLinePrices."Unit of Measure Code".ASSERTEQUALS(BlanketPurchaseOrder.PurchLines."Unit of Measure Code".VALUE);
                        GeneralLedgerSetup.GET;
                        IF InterfaceLogLine."Currency Code" <> GeneralLedgerSetup."LCY Code" THEN
                            PurchaseLinePrices."Currency Code".ASSERTEQUALS(BlanketPurchaseOrder."Currency Code".VALUE);
                        //       PurchaseLinePrices."Direct Unit Cost Multiplier".ASSERTEQUALS(InterfaceLogLine."Direct Unit Cost Multiplier");//HEI.52
                        //        IF InterfaceLogLine."Direct Cost Per Multiplier"=0 THEN
                        //          PurchaseLinePrices."Direct Cost Per Multiplier".ASSERTEQUALS(1)
                        //        ELSE
                        //          PurchaseLinePrices."Direct Cost Per Multiplier".ASSERTEQUALS(InterfaceLogLine."Direct Cost Per Multiplier");
                        PurchaseLinePrices.CLOSE;
                    END;
                //BC UPGRADE KUMARR78 << DIT Variable Removed.(Channel) Need to block the Entire Section.
                UNTIL InterfaceLogLine.NEXT = 0;
            END;
        END ELSE
            ERROR('Please check the interface log');
        BlanketPurchaseOrder.OK.INVOKE;
        //HEI.07 <<
    end;

    [Test]
    [HandlerFunctions('SuggestVendorPayment_RequestPageHandler')]
    procedure "PTP062-CreatePaymentProposal"();
    var
        PurchaseInvList: TestPage "PO Purchase Invoices";
        Vendor: Record Vendor;
        Item: Record Item;
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        PayJnlTree: TestPage "Payment Journal Tree CBN";
        BatchError: Label 'An approval request already exists.';
        gGenJnlBatches: Record "Gen. Journal Batch";
    begin
        DimensionRestrictionCheck;//HEI.95
        //HEI.07 >>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP062', CompanyName, Database::"Gen. Journal Batch");//Abhay
        gGenJnlBatches.Get(UnitTestingValues.Value, UnitTestingValues."Value 2");

        VendLedgEntry.Reset();
        VendLedgEntry.SetRange("Document Type", VendLedgEntry."Document Type"::Invoice);
        VendLedgEntry.SetRange(Open, true);
        if VendLedgEntry.FindFirst() then begin
            InvNo := VendLedgEntry."Document No.";
        end;

        PayJnlTree.OpenEdit();
        PayJnlTree.CurrentJnlBatchName.SetValue(gGenJnlBatches.Name);
        PayJnlTree.SuggestVendorPayments.Invoke();

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP062', CompanyName, Database::"Gen. Journal Batch");
        gGenJnlBatches.Get(UnitTestingValues.Value, UnitTestingValues."Value 3");

        PayJnlTree.CurrentJnlBatchName.SetValue(gGenJnlBatches.Name);
        asserterror PayJnlTree.SuggestVendorPayments.Invoke();
        if GetLastErrorText <> BatchError then
            Error('Unexpected Error: %1', GetLastErrorText);
        //HEI.07 <<
    end;

    [ModalPageHandler]
    procedure SelectSendingOptionsModalPageHandler(var SelectSendingOptions: TestPage "Select Sending Options");
    begin
        SelectSendingOptions.OK().Invoke();
    end;


    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,EmailDialog_ModalPageHandler')]//BC UPGRADE KUMARR78 Blocking to remove Handler EmailDialog_ModalPageHandler // BC Upgrade BHARDA11 -- Remove comment
    // [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler')]//BC UPGRADE KUMARR78 Adding without Handler EmailDialog_ModalPageHandler,SelectSendingOptions_ModalPageHandler.
    // [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler,SelectSendingOptionsModalPageHandler')]
    procedure "PCN004-PurchaseOrder_SendtoSupplier"();
    var
        Vendor: Record Vendor;
        Item: Record Item;
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        SelectSendingOptions: TestPage "Select Sending Options";
        Location: Record Location;
        UserSetup: Record "User Setup";
        ReportSelections: Record "Report Selections";
        Workflow: Record Workflow;
        Rep5753: report 5753;
    begin
        DimensionRestrictionCheck;//HEI.95
        //HEI.07 >>
        PurchasesPayablesSetup.Get();
        //HEI.26>>
        //IF PurchasesPayablesSetup."Auto E-mail Active"=FALSE THEN BEGIN
        if PurchasesPayablesSetup."Auto E-mail Active FND" = true then begin
            PurchasesPayablesSetup."Auto E-mail Active FND" := false;
            PurchasesPayablesSetup.Modify();
        end;
        //HEI.26<<
        //HEI.59>>
        //BC UPGRADE KUMARR78 >> DIT Variable Removed.("Document Subtype Code")
        // ReportSelections.RESET;
        // ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"P.Order");
        // ReportSelections.SETRANGE("Report ID", 50058);
        // IF ReportSelections.FINDFIRST THEN BEGIN
        //     ReportSelections."Document Subtype Code" := 'PO';
        //     ReportSelections.MODIFY;
        // END;
        //BC UPGRADE KUMARR78 << DIT Variable Removed.("Document Subtype Code")
        //HEI.59<<
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN004', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        //Picking Item No.
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN004', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN004', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);
        //HEI.26>>
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange("E-Mail", '');
        if UserSetup.FindFirst() then begin
            UserSetup."E-Mail" := 'unittesting@heineken.com';
            UserSetup.Modify();
        end;
        //HEI.26<<
        //Creation of PO
        ////Header Part
        PurchaseOrder.OpenNew();
        PurchaseOrder."No.".AssistEdit();
        PurchaseOrder."Buy-from Vendor No.".SetValue(Vendor."No.");
        PurchaseOrder."Vendor Invoice No.".SetValue('StP Unit Test PCN004');
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseOrder."Location Code".SetValue(Location.Code);
        //HEI.51<<
        //HEI.20>>
        PnPSetup.Get();
        if PnPSetup."Requester ID Mandatory FND" then; //BC UPGRADE KUMARR78 Adding Semicolon(;) to handle the Condition.
        // PurchaseOrder."Requester ID".SETVALUE(USERID);//BC UPGRADE KUMARR78 DIT Field Removed.
        //HEI.20<<
        ////Line Part
        PurchaseOrder.PurchLines.Type.SetValue(Type::Item);
        PurchaseOrder.PurchLines."No.".SetValue(Item."No.");
        PurchaseOrder.PurchLines.Quantity.SetValue(1);
        PurchaseOrder.PurchLines."Location Code".SetValue(Location.Code);
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            //IF Workflow.FINDSET THEN
            //REPEAT
            //Workflow.Enabled := FALSE;
            //Workflow.MODIFY;
            //UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;
        PurchaseOrder.Release.Invoke();
        purchaseorder.Email.Invoke(); // BC Upgrade BHARDA11 
        // PurchaseOrder.SendCustom.Invoke(); Email // BC Upgrade BHARDA11 
        //Closing PO Document
        PurchaseOrder.OK.Invoke();
        //HEI.26>>
        //END
        //HEI.20>>
        //ELSE
        //  ERROR('PO Auto Send functionality is active');
        //HEI.26<<
        //HEI.20<<
        //HEI.07  <<
    end;

    //BC UPGRADE KUMARR78 >> Variable Removed in BC and Handler Blocked. // BC Upgrade BHARDA11 -- REmove Comment >>
    [ModalPageHandler]
    [HandlerFunctions('EmailDialog_ModalPageHandler')]
    procedure SelectSendingOptions_ModalPageHandler(var SelectSendingOptions: TestPage "Select Sending Options");
    begin
        //HEI.07 >>
        SelectSendingOptions.Printer.SETVALUE('No');
        SelectSendingOptions."E-Mail".SETVALUE('Yes (Prompt for Settings)');
        SelectSendingOptions.OK.INVOKE;
        //HEI.07 <<
    end;
    //BC UPGRADE KUMARR78 << Variable Removed in BC and Handler Blocked.


    //BC UPGRADE KUMARR78 >> Variable Removed.

    [ModalPageHandler]

    // procedure EmailDialog_ModalPageHandler(var EmailDialog: TestPage 9700);
    procedure EmailDialog_ModalPageHandler(var EmailDialog: TestPage "Email Editor");
    var
        UserSetup: Record "User Setup";
    begin
        //HEI.07 >>
        UserSetup.GET(USERID);
        // EmailDialog.SendTo.SETVALUE(UserSetup."E-Mail");
        // EmailDialog.OutlookEdit.SETVALUE(FALSE);
        EmailDialog.ToField.SETVALUE(UserSetup."E-Mail");
        // EmailDialog.OutlookEdit.SETVALUE(FALSE);
        EmailDialog.Send.Invoke();
        // EmailDialog.OK.INVOKE;
        // EmailDialog.Close();
        //HEI.07 <<
    end;
    //BC UPGRADE KUMARR78 << Variable Removed. // BC Upgrade BHARDA11 -- REmove Comment <<
    [ModalPageHandler]
    procedure ChangePaymentStatusPPIHandler(var ChangePaymentStatusPPI: TestPage "Change Payment Status PPI")
    begin
        ChangePaymentStatusPPI."Payment Status".SetValue(PaymentStatusToSet);
        // ChangePaymentStatusPPI.Close();
    end;

    [Test]
    [HandlerFunctions('ChangePaymentStatusPPIHandler')]
    procedure "PTP154-ApproveInvoice_noworkflow"();
    var
        PostedPurchaseInvoices: TestPage "Posted Purchase Invoices";
        PostedPurchaseInvoice: TestPage "Posted Purchase Invoice";
        PaymentStatusPPI: TestPage "Change Payment Status PPI";
        DocNo: Code[20];
    begin
        PaymentStatusToSet := PaymentStatusToSet::"Payment Approved";
        PostedPurchaseInvoices.OpenView();
        PostedPurchaseInvoices.Filter.SetFilter("Payment Status FND", 'Pending Review');
        PostedPurchaseInvoices.First();
        DocNo := PostedPurchaseInvoices."No.".Value;

        PostedPurchaseInvoice.OpenEdit();
        PostedPurchaseInvoice.Filter.SetFilter("No.", DocNo);
        PostedPurchaseInvoice.First();

        PaymentStatusPPI.Trap();
        PostedPurchaseInvoice."Payment Status".DrillDown();

        PostedPurchaseInvoice.Close();
        PostedPurchaseInvoices.Close();
    end;

    [Test]
    procedure "PTP157-RejectCreditNote_noworkflow"();
    var
        PostedPurchaseCreditMemo: TestPage "Posted Purchase Credit Memo";
    begin
        //HEI.07  >>
        PostedPurchaseCreditMemo.OpenEdit();
        PostedPurchaseCreditMemo.Filter.SetFilter("Payment Status FND", 'Pending Review');
        PostedPurchaseCreditMemo."Payment Status".SETVALUE('Payment Rejected');
        PostedPurchaseCreditMemo.Close();
        //HEI.07  <<
    end;

    [Test]
    // [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler,SourceDocuments_ModalPageHandler,MessageHandler,PRD107ItemTrackingLinesModalPageHandler')]
    // [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler,SourceDocuments_ModalPageHandler,MessageHandler,PRD107ItemTrackingLinesModalPageHandler,WhseRcptPageHandler,ItemTrackingLinesModalPageHandler')] // BC Upgrade BHARDA11
    [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler,MessageHandler,WhseRcptPageHandler,PRD107ItemTrackingLinesModalPageHandler')]
    procedure "PRD107-GoodsReceipt"();
    var
        Vendor: Record Vendor;
        Item: Record Item;
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        Location: Record Location;
        PurchaseHeader: Record "Purchase Header";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        PurchaseLine: Record "Purchase Line";
        WarehouseEmployee: Record "Warehouse Employee";
        EbfCombination: Record "Ebf Combination FND";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Bin: Record Bin;
        Workflow: Record Workflow;
        RecZone: Record Zone;
        WhseEmpDTW: record 50356;
        WarRecLin: Record "Warehouse Receipt Line";
        WarEmployee: Record "Warehouse Employee";
        WhseDocNo: code[20];
        WhseRcptPONo: Code[20];
    begin
        DimensionRestrictionCheck;//HEI.95
        //HEI.07 >>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PRD107', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        //Picking Item No.
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PRD107', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PRD107', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);
        //HEI.61>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PRD107', CompanyName, Database::Bin);
        Bin.Get(Location.Code, UnitTestingValues.Value);
        //HEI.61<<
        UnitTestingValues.Get('PRD107', CompanyName, Database::"Lot No. Information");
        LotFilter := UnitTestingValues.Value;
        //Creation of PO
        ////Header Part
        PurchaseOrder.OpenNew();
        PurchaseOrder."No.".AssistEdit();
        PurchaseOrder."Buy-from Vendor No.".SetValue(Vendor."No.");
        PurchaseOrder."Vendor Invoice No.".SetValue('StP Unit Test PRD107');
        //HEI.53>>

        //BC UPGRADE KUMARR78 >> DIT Field Removed. // BC Upgrade BHARDA11 >> -- Add field
        IF PurchasesPayablesSetup.GET THEN
            IF PurchasesPayablesSetup."Requester ID Mandatory FND" THEN
                PurchaseOrder."Requester ID".SETVALUE(USERID);
        //BC UPGRADE KUMARR78 << DIT Field Removed. // BC Upgrade BHARDA11 << -- Add field
        //HEI.53<<
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseOrder."Location Code".SetValue(Location.Code);
        //HEI.51<<
        ////Line Part
        PurchaseOrder.PurchLines.Type.SetValue(Type::Item);
        PurchaseOrder.PurchLines."No.".SetValue(Item."No.");
        PurchaseOrder.PurchLines.Quantity.SetValue(1);
        PurchaseOrder.PurchLines."Location Code".SetValue(Location.Code);
        //HEI.26>>
        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PRD107', CompanyName, Database::"Dimension Value");
        if UnitTestingValues.Value <> '' then
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);
        //HEI.50>>
        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue.Code);
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();
        //HEI.50<<
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("Document No.", PurchaseOrder."No.".Value);
        PurchaseLine.SetRange("No.", PurchaseOrder.PurchLines."No.".Value);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
            PurchaseLine.Validate("Bin Code", Bin.Code);//HEI.61
            PurchaseLine.Modify();
        end;
        WarehouseEmployee.Reset();
        WarehouseEmployee.SetRange("User ID", UserId);
        WarehouseEmployee.SetRange("Location Code", Location.Code);
        if WarehouseEmployee.FindFirst() then begin
            WarehouseEmployee.Default := true;
            WarehouseEmployee.Modify();
        end;
        //HEI.26<<

        //Disable Workflows before Release
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            //IF Workflow.FINDSET THEN
            //REPEAT
            //Workflow.Enabled := FALSE;
            //Workflow.MODIFY;
            //UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;
        DocNo := PurchaseOrder."No.".Value;
        PurchaseOrder.Release.Invoke();
        //Closing PO Document
        // BC Upgrade BHARDA11 >>
        Reczone.reset;
        Reczone.setrange("Location Code", Location.code);
        reczone.findfirst();
        WhseEmpDTW.init();
        WhseEmpDTW."User ID" := userid;
        WhseEmpDTW."location Code" := Location.code;
        WhseEmpDTW."zone Code" := RecZone.Code;
        if WhseEmpDTW.insert() then;
        // error(Reczone.code);
        Bin.reset();
        Bin.SetRange("Zone Code", RecZone.code);
        bin.findfirst();
        WarEmployee.init();
        WarEmployee."User ID" := userid;
        waremployee."location Code" := Location.code;
        if WarEmployee.insert() then;
        // BC Upgrade BHARDA11 << 
        PurchaseOrder."Create &Whse. Receipt".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name


        WarehouseReceipt.OpenView();
        WarehouseReceipt.Filter.SetFilter("Source No. FND", PurchaseOrder."No.".Value);

        //Store the PO No in warehouse receipt
        WhseRcptPONo := WarehouseReceipt."Source No.".Value;
        WhseDocNo := WarehouseReceipt."No.".value; // BC Upgrade BHARDA11
                                                   // BC Upgrade BHARDA11 

        WarRecLin.reset();
        WarRecLin.SetRange("No.", WhseDocNo);
        WarRecLin.findset();
        WarRecLin.Validate("Zone Code", RecZone.Code);
        WarRecLin.Validate("Bin Code", Bin.Code);
        WarRecLin.modify();
        // WarRecLin.modifyall("Zone Code", RecZone.Code);
        // WarRecLin.modifyall("Bin Code", Bin.Code);
        // end;
        // WarehouseReceipt.WhseReceiptLines."Zone Code".setvalue(reczone.code);
        // WarehouseReceipt.WhseReceiptLines."Bin Code".setvalue(Bin.code);
        // BC Upgrade BHARDA11 
        // BC Upgrade BHARDA11 <<
        // WarehouseReceipt.OpenNew();
        // WarehouseReceipt."No.".AssistEdit();

        // // WarehouseReceipt.Action23.INVOKE;//BC UPGRADE KUMARR78 Replacing Action122 With Action Button Name.
        // WarehouseReceipt."Get Source Documents".Invoke(); //BC UPGRADE KUMARR78 Replacing Action with Name

        WarehouseReceipt.WhseReceiptLines.ItemTrackingLines.Invoke();
        WarehouseReceipt."Post Receipt".Invoke();
        PurchaseOrder.OK.Invoke(); // BC Upgrade BHARDA11
        //HEI.07  <<
    end;

    [ModalPageHandler]
    procedure SourceDocuments_ModalPageHandler(var SourceDocuments: TestPage "Source Documents");
    begin
        //HEI.07  >>
        SourceDocuments.Filter.SetFilter("Source No.", DocNo);
        // SourceDocuments.Action1000010005.INVOKE; //BC UPGRADE KUMARR78 Blocking As Action(Set-To-Applies-ID) Not Available in BC.
        // SourceDocuments.
        SourceDocuments.OK.Invoke();//Abhay
        //HEI.07  <<
    end;

    [ModalPageHandler]
    procedure PRD107ItemTrackingLinesModalPageHandler(var ItemTrackingLines: TestPage "Item Tracking Lines");
    var
        TrackingSpecification: Record "Tracking Specification" temporary;
    begin
        //HEI.07  >>
        ItemTrackingLines."Lot No.".SetValue(LotFilter);
        ItemTrackingLines."Quantity (Base)".SetValue(1);
        ItemTrackingLines."Create Batch Number".Invoke();
        ItemTrackingLines.OK.Invoke();
        //HEI.07  <<
    end;

    [Test]
    [HandlerFunctions('Apply_VLE_ModalPageHandler,PostApplication_ModalPageHandler,MessageHandler,ConfirmationHandler,WhseRcptPageHandler,ItemTrackingLinesModalPageHandler,GetReceiptLineModalPageHandler,SuggestVendorPayment_RequestPageHandler2,UnapplyEntriesModalPageHandler')]
    procedure "PTP102-Clearing_of_open_items_on_vendor_accounts"();
    var
        Vendor: Record Vendor;
        VendorList: TestPage "Vendor List";
        VendorLedgerEntries: TestPage "Vendor Ledger Entries";
        UserSetup: Record "User Setup";
        GeneralLedgerSetup: Record "General Ledger Setup";
        CompanyInformation: Record "Company Information";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        DimensionRestrictionCheck();//HEI.95
        CurrencyCode := ''; //HEI.76
        //HEI.07  >>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::Vendor); //HEI.82
        Vendor.Get(UnitTestingValues.Value);
        //HEI.98>>
        //VendorList.OPENVIEW;
        //VendorList.FILTER.SETFILTER("No.",Vendor."No.");
        //VendorList."Page Vendor Ledger Entries".INVOKE;
        //HEI.98<<
        VendorNo := Vendor."No.";
        //HEI.26>>
        UserSetup.Get(UserId);
        UserSetup."Allow Bypass WHT Valid FND" := true;
        UserSetup.Modify();
        //HEI.26<<
        //HEI.57>>
        if CompanyInformation.Get() then
            if CompanyInformation."Enable French Localization FND" = true then begin
                CompanyInformation."Enable French Localization FND" := false;
                CompanyInformation.Modify();
            end;
        //HEI.57<<
        //HEI.31>>
        GeneralLedgerSetup.Get();
        GeneralLedgerSetup.Validate("Allow Posting From", 0D);
        GeneralLedgerSetup.Modify();
        //HEI.31<<
        //HEI.67>>
        /*VendorLedgerEntry.RESET;
        VendorLedgerEntry.SETRANGE("Vendor No.",Vendor."No.");
        VendorLedgerEntry.MODIFYALL("Applies-to ID",'');*/
        //HEI.67<<
        //HEI.82>>
        //IF COMPANYNAME IN['10_SierraLeone','10_BRARUDI'] THEN
        PTP103_PaymentAlongWithAppliedAndUnappliedEntry;
        //HEI.82<<
        Clear(VendorLedgerEntries);
        VendorLedgerEntries.OpenEdit();
        VendorLedgerEntries.Filter.SetFilter("Vendor No.", VendorNo);
        VendorLedgerEntries.Filter.SetFilter("Document Type", 'Invoice');
        VendorLedgerEntries.Filter.SetFilter("Document No.", InvNo); //HEI.85
        VendorLedgerEntries.Filter.SetFilter(Open, 'Yes');
        //HEI.76>>
        VendorLedgerEntries.First();
        CurrencyCode := VendorLedgerEntries."Currency Code".Value;
        //HEI.76<<
        //HEI.96>>
        VendorLedgerEntry.Reset();
        VendorLedgerEntry.SetRange("Vendor No.", Vendor."No.");
        VendorLedgerEntry.SetRange("Document Type", VendLedgEntry."Document Type"::Payment);
        VendorLedgerEntry.SetRange(Open, true); //HEI.98
        // VendorLedgerEntry.SetFilter("Journal Batch Name", '%1', 'STPTest5');
        VendorLedgerEntry.SetFilter("Journal Batch Name", '%1', 'STPTest' + Format(EntryNo));
        if UpperCase(CompanyName) = '10_LUBUMBASHI' then
            VendorLedgerEntry.SetRange("Closed at Date", 0D);
        if VendorLedgerEntry.FindFirst() then
            //HEI.98>>
            //PaymentEntryNo := VendorLedgerEntry."Entry No.";
            PaymentDocNo1 := VendorLedgerEntry."Document No.";
        //HEI.98<<
        //HEI.96<<
        VendorLedgerEntries.ActionApplyEntries.Invoke();
        //HEI.07  <<

    end;

    [ModalPageHandler]
    [HandlerFunctions('PostApplication_ModalPageHandler')]
    procedure Apply_VLE_ModalPageHandler(var ApplyVendorEntries: TestPage "Apply Vendor Entries");
    begin
        //HEI.07  >>
        ApplyVendorEntries.Filter.SetFilter("Vendor No.", VendorNo);
        ApplyVendorEntries.Filter.SetFilter("Document Type", 'Payment');//HEI.20
        ApplyVendorEntries.Filter.SetFilter("Document No.", GenJouDocNo);//HEI.85
        ApplyVendorEntries.Filter.SetFilter("Remaining Amount", '>1');//HEI.20
        ApplyVendorEntries.Filter.SetFilter("Currency Code", CurrencyCode);//HEI.76
        ApplyVendorEntries.Filter.SetFilter(Open, 'Yes');
        //ApplyVendorEntries.FILTER.SETFILTER("Applies-to ID",'');//HEI.85
        ApplyVendorEntries.First();//HEI.76
        //ApplyVendorEntries."Applies-to ID".SETVALUE('');//HEI.53
        ApplyVendorEntries.ActionSetAppliesToID.Invoke();
        ApplyVendorEntries.ActionPostApplication.Invoke();
        //HEI.07  <<
    end;

    [ModalPageHandler]
    procedure PostApplication_ModalPageHandler(var PostApplication: TestPage "Post Application");
    begin
        //HEI.07  >>
        PostApplication.OK.Invoke();
        //HEI.07  <<
    end;

    [ModalPageHandler]
    procedure ErrorPageHandler(var ErrorMessages: TestPage "Error Messages");
    begin
        ErrorMessages.Close();
    end;

    // [Test]
    // [HandlerFunctions('ConfirmationHandler,CopyPurDocReportHandler,DimSetEntriesModalPageHandlerPTP133')]
    // procedure PTP133_Reverse_Rejected_CN();
    [Test]
    [HandlerFunctions('ConfirmationHandler,CopyPurDocReportHandler,DimSetEntriesModalPageHandlerPTP133')]
    procedure PTP133_Reverse_Rejected_CN();
    var
        NPOPurchaseCreditMemosList: TestPage "NPO Purchase Credit Memos";
        Vendor: Record Vendor;
        NPOPurchaseCreditMemo: TestPage "NPO Purchase Credit Memo";
        "G/L Account": Record "G/L Account";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        "VAT Product Posting Group": Record "VAT Product Posting Group";
        DateChangeError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''"You cannot modify the field- ''Due Date''. " (Select Refresh to discard errors)'''; // BC Upgrade BHARDA11
        // DateChangeError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''You cannot modify the field- ''Due Date''.  (Select Refresh to discard errors)''';
        PaymentMethodCodeError: TextConst ENU = 'Validation error for Field: Payment Method Code,  Message = ''You cannot modify the field- ''Payment Method Code''.  (Select Refresh to discard errors)''';
        DocNo: Text;
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PostedPurchaseCreditMemos: TestPage "Posted Purchase Credit Memos";
        PostedCrNo: Text;
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        PurchaseHeader: Record "Purchase Header";
        "WHT Business Posting Group FND": Record "WHT Business Posting Group FND";
        PaymentTermCodeError: TextConst ENU = 'Validation error for Field: Payment Terms Code,  Message = ''You cannot modify the field- ''Payment Terms Code''.  (Select Refresh to discard errors)''';
        PurchaseInvoice: TestPage "NPO Purchase Invoice";
        CopyPurchaseDocument: Report "Copy Purchase Document";
        PurchLn: Record "Purchase Line";
        DocAmount: Decimal;
        VATAmount: Decimal;
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        EditDimensionSetEntries: TestPage "Edit Dimension Set Entries";
        PostedPurchaseCreditMemo: TestPage "Posted Purchase Credit Memo";
        PurchaseLine: Record "Purchase Line";
        EbfCombination: Record "Ebf Combination FND";
        Location: Record Location;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DefaultDimension: Record "Default Dimension";
        NoSeriesLine: Record "No. Series Line";
        Workflow: Record Workflow;
    begin
        DimensionRestrictionCheck; //HEI.95
        //HEI.59>>
        if PurchasesPayablesSetup.Get() then
            NoSeriesLine.Reset();
        NoSeriesLine.SetRange("Series Code", PurchasesPayablesSetup."Posted Credit Memo Nos.");
        NoSeriesLine.SetFilter("Last Date Used", '>%1', Today);
        if NoSeriesLine.FindFirst() then begin
            NoSeriesLine."Last Date Used" := Today;
            NoSeriesLine.Modify();
        end;
        //HEI.59<<
        //HEI.10 >>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP133', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP133', CompanyName, Database::"WHT Business Posting Group FND");
        "WHT Business Posting Group FND".Get(UnitTestingValues.Value);
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP133', CompanyName, Database::"G/L Account");
        "G/L Account".Get(UnitTestingValues.Value);
        //HEI.53>>
        if DefaultDimension.Get(15, "G/L Account"."No.", 'TRD_PART') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;

        //BC UPGRADE KUMARR78 >> DIT Variable Removed.
        // IF PurchasesPayablesSetup.GET THEN
        //     IF PurchasesPayablesSetup."Show Posted Document No." THEN BEGIN
        //         PurchasesPayablesSetup."Show Posted Document No." := FALSE;
        //         PurchasesPayablesSetup.MODIFY;
        //     END;
        //BC UPGRADE KUMARR78 << DIT Variable Removed.

        //HEI.53<<
        //HEI.55>>
        if DefaultDimension.Get(15, "G/L Account"."No.", 'BRAND') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;
        //HEI.55<<
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP133', CompanyName, Database::"VAT Product Posting Group");
        "VAT Product Posting Group".Get(UnitTestingValues.Value);
        //HEI.20>>
        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP133', CompanyName, Database::"Dimension Value");
        if UnitTestingValues.Value <> '' then
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);
        Clear(MVMTDimension);
        MVMTDimension := UnitTestingValues."Value 2";
        //HEI.20<<
        //HEI.50>>
        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue.Code);
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();
        //HEI.50<<
        //NPOPurchaseCreditMemosList.OPENNEW;
        NPOPurchaseCreditMemo.OPENNEW;
        //NPOPurchaseCreditMemo.NEW;
        NPOPurchaseCreditMemo."Buy-from Vendor Name".SETVALUE(Vendor.Name);
        NPOPurchaseCreditMemo."Vendor Cr. Memo No.".SETVALUE('PTP133');
        //HEI.51>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP133', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                NPOPurchaseCreditMemo."Location Code".SETVALUE(Location.Code);
        //HEI.51<<
        NPOPurchaseCreditMemo."Payment Method Code".SETVALUE(Vendor."Payment Method Code");
        NPOPurchaseCreditMemo."Payment Terms Code".SETVALUE(Vendor."Payment Terms Code");
        NPOPurchaseCreditMemo.PurchLines.Type.SETVALUE(Type::"G/L Account");
        NPOPurchaseCreditMemo.PurchLines."No.".SETVALUE("G/L Account"."No.");
        NPOPurchaseCreditMemo.PurchLines.Quantity.SETVALUE(1);
        NPOPurchaseCreditMemo.PurchLines."Direct Unit Cost".SETVALUE(100);
        //NPOPurchaseCreditMemo.PurchLines."VAT Prod. Posting Group".SETVALUE("VAT Product Posting Group".Code);//HEI.26
        NPOPurchaseCreditMemo.PurchLines."WHT Business Posting Group".SETVALUE("WHT Business Posting Group FND".Code);
        //HEI.20>>
        //NPOPurchaseCreditMemo.PurchLines."Shortcut Dimension 2 Code".SETVALUE(DimensionValue.Code);//HEI.26

        // NPOPurchaseCreditMemo.PurchLines.Action1902740304.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        NPOPurchaseCreditMemo.PurchLines.Dimensions.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name

        //HEI.26>>
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::"Credit Memo");
        PurchaseLine.SETRANGE("Document No.", NPOPurchaseCreditMemo."No.".VALUE);
        PurchaseLine.SETRANGE("No.", NPOPurchaseCreditMemo.PurchLines."No.".VALUE);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("VAT Prod. Posting Group", "VAT Product Posting Group".Code);
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
            PurchaseLine.Modify();
        end;
        //HEI.26<<

        // NPOPurchaseCreditMemo.Action105.INVOKE;//HEI.50//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        NPOPurchaseCreditMemo.Dimensions.INVOKE;//HEI.50//BC UPGRADE KUMARR78 Adding with Change Action Name


        Clear(DocAmount);
        Clear(VATAmount);
        EVALUATE(DocAmount, NPOPurchaseCreditMemo.PurchLines."Total Amount Incl. VAT".VALUE);
        EVALUATE(VATAmount, NPOPurchaseCreditMemo.PurchLines."Total VAT Amount".VALUE);
        //HEI.20<<
        NPOPurchaseCreditMemo."Doc. Amount Incl. VAT IBM".SETVALUE(NPOPurchaseCreditMemo.PurchLines."Total Amount Incl. VAT".VALUE);
        NPOPurchaseCreditMemo."Doc. Amount VAT IBM".SETVALUE(NPOPurchaseCreditMemo.PurchLines."Total VAT Amount".VALUE);
        DocNo := NPOPurchaseCreditMemo."No.".VALUE;

        // NPOPurchaseCreditMemo.Post.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        NPOPurchaseCreditMemo.Post_Cust.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name

        PurchCrMemoHdr.SetRange("Pre-Assigned No.", DocNo);
        if PurchCrMemoHdr.FindFirst() then
            CrNo := PurchCrMemoHdr."No.";
        PostedPurchaseCreditMemo.OpenEdit();
        PostedPurchaseCreditMemo.Filter.SetFilter("No.", CrNo);
        PostedPurchaseCreditMemo."Payment Status".SETVALUE('Payment Rejected');
        PostedPurchaseCreditMemo.Close();
        PurchaseInvoice.OPENNEW;
        PurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");
        PurchaseInvoice."Vendor Invoice No.".SETVALUE('PTP133');
        //HEI.51>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP133', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseInvoice."Location Code".SETVALUE(Location.Code);
        //HEI.51<<
        PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, PurchaseInvoice."No.".VALUE);
        Commit();
        CopyPurchaseDocument.SetPurchHeader(PurchaseHeader);
        CopyPurchaseDocument.RunModal();
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            //IF Workflow.FINDSET THEN
            //REPEAT
            //Workflow.Enabled := FALSE;
            //Workflow.MODIFY;
            //UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;
        PurchaseInvoice.PurchLines.FILTER.SETFILTER(Type, 'G/L Account');//HEI.20
        PurchaseInvoice.PurchLines."Planned Receipt Date".SETVALUE(Today);
        //HEI.20>>
        //HEI.26>>
        //PurchaseInvoice.PurchLines."Shortcut Dimension 2 Code".SETVALUE(DimensionValue.Code);
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Invoice);
        PurchaseLine.SETRANGE("Document No.", PurchaseInvoice."No.".VALUE);
        PurchaseLine.SETRANGE("No.", PurchaseInvoice.PurchLines."No.".VALUE);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
            PurchaseLine.Modify();
        end;
        //HEI.26<<

        // PurchaseInvoice.PurchLines.Action1904974904.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        // PurchaseInvoice.Dimensions.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name
        // PurchaseInvoice.PurchLines.Dimensions.Invoke(); // BC Upgrade BHARDA11
        PurchaseLine.ShowDimensions();

        // PurchLn.RESET;
        // PurchLn.SETRANGE("Document Type",PurchLn."Document Type"::Invoice);
        // PurchLn.SETRANGE("Document No.",PurchaseInvoice."No.".VALUE);
        // IF PurchLn.FINDSET THEN REPEAT
        //  DocAmount += PurchLn."Amount Including VAT";
        //  VATAmount += (PurchLn."Amount Including VAT" - PurchLn.Amount);
        // UNTIL PurchLn.NEXT = 0;
        //HEI.20<<

        //BC UPGRADE KUMARR78 >> DIT Variable Removed.
        PurchaseInvoice."Doc. Amount Incl. VAT IBM".SETVALUE(DocAmount);
        PurchaseInvoice."Doc. Amount VAT IBM".SETVALUE(VATAmount);
        //BC UPGRADE KUMARR78 << DIT Variable Removed.

        // PurchaseInvoice.Action120.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseInvoice."Re&lease".INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name


        PurchaseInvoice.Post.INVOKE;
        //HEI.10 <<
    end;

    [RequestPageHandler]
    procedure CopyPurDocReportHandler(var CopyPurchaseDocument: TestRequestPage "Copy Purchase Document");
    begin
        //HEI.10 >>
        CopyPurchaseDocument.DocumentType.SetValue('Posted Credit Memo');
        CopyPurchaseDocument.DocumentNo.SetValue(CrNo);
        CopyPurchaseDocument.RecalculateLines.SetValue(true);
        CopyPurchaseDocument.OK.Invoke();
        //HEI.10 <<
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler')]
    procedure "PTP055 Negativetesting NPO Invoice"();
    var
        PurchaseInvList: TestPage "NPO Purchase Invoices";
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
        dkjadbjs: TestPage "NPO Purchase Invoices";
        NPOPurchaseInvoice: TestPage "NPO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        DueDate: Text;
        BankAccount: Text;
        PostedPurchInvHdr: Record "Purch. Inv. Header";
        StorePostedInvNo: Code[20];
        PostedPurchInv: TestPage "Posted Purchase Invoice";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        DocumentDateError: TextConst ENU = 'Document Date must have a value in Purchase Header: Document Type=Invoice, No.=';
        DateChangeError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''You cannot modify the field- ''Due Date''.  (Select Refresh to discard errors)''';
        PaymentMethodCodeError: TextConst ENU = 'Validation error for Field: Payment Method Code,  Message = ''You cannot modify the field- ''Payment Method Code''.  (Select Refresh to discard errors)''';
        PaymentTermCodeError: TextConst ENU = 'Validation error for Field: Payment Terms Code,  Message = ''You cannot modify the field- ''Payment Terms Code''.  (Select Refresh to discard errors)''';
        PaytoNameError: TextConst ENU = 'Validation error for Field: Pay-to Name,  Message = ''Name must be filled in. Enter a value. (Select Refresh to discard errors)''';
        DocumentDateError1: Label '. It cannot be zero or empty.';
        VendorInvoiceNoError: TextConst ENU = 'Vendor Invoice No. must have a value in Purchase Header: Document Type=Invoice, No.=';
        VendorInvoiceNoError1: Label '. It cannot be zero or empty.';
        DocumentDateError3: TextConst ENU = ' Document Date must have a value in Purchase Header: Document Type=Invoice, No.=PI00016837. It cannot be zero or empty.';
        CompanyInformation: Record "Company Information";
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseLine: Record "Purchase Line";
        DimensionValue: Record "Dimension Value";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Location: Record Location;
        DefaultDimension: Record "Default Dimension";
        Workflow: Record Workflow;
        Mess: text;
        PurchHdr: record "Purchase Header";
    begin
        "PTP055 Negativetesting NPO Invoice01"();
        "PTP055 Negativetesting NPO Invoice2"();
        "PTP055 Negativetesting NPO Invoice3"();
        // DimensionRestrictionCheck; //HEI.95
        // //HEI.16>>
        // UnitTestingValues.Reset();
        // UnitTestingValues.Get('PTP055', CompanyName, Database::Vendor);
        // Vendor.Get(UnitTestingValues.Value);

        // UnitTestingValues.Reset();
        // UnitTestingValues.Get('PTP055', CompanyName, Database::"G/L Account");
        // GLAccount.Get(UnitTestingValues.Value);
        // //HEI.53>>
        // if DefaultDimension.Get(15, GLAccount."No.", 'TRD_PART') then
        //     if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
        //         DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
        //         DefaultDimension.Modify();
        //     end;

        // //BC UPGRADE KUMARR78 >> DIT Variable Removed.
        // // IF PurchasesPayablesSetup.GET THEN
        // //     IF PurchasesPayablesSetup."Show Posted Document No." THEN BEGIN
        // //         PurchasesPayablesSetup."Show Posted Document No." := FALSE;
        // //         PurchasesPayablesSetup.MODIFY;
        // //     END;
        // //BC UPGRADE KUMARR78 << DIT Variable Removed.

        // //HEI.53<<
        // //HEI.55>>
        // if DefaultDimension.Get(15, GLAccount."No.", 'BRAND') then
        //     if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
        //         DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
        //         DefaultDimension.Modify();
        //     end;
        // //HEI.55<<
        // //HEI.20>>
        // GeneralLedgerSetup.Get();
        // UnitTestingValues.Reset();
        // UnitTestingValues.Get('PTP055', CompanyName, Database::"Dimension Value");
        // if UnitTestingValues.Value <> '' then
        //     DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);
        // //HEI.20<<

        // NPOPurchaseInvoice.OPENNEW;
        // NPOPurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");
        // PurchInvNo := NPOPurchaseInvoice."No.".VALUE;
        // NPOPurchaseInvoice."Document Date".SETVALUE(0D);
        // //HEI.51>>
        // UnitTestingValues.Reset();
        // UnitTestingValues.Get('PTP055', CompanyName, Database::Location);
        // Location.Get(UnitTestingValues.Value);
        // if PurchasesPayablesSetup.Get() then
        //     if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
        //         NPOPurchaseInvoice."Location Code".SETVALUE(Location.Code);
        // //HEI.51<<
        // //222222222222222222222222222222
        // Mess := NPOPurchaseInvoice."No.".Value;
        // asserterror NPOPurchaseInvoice.Post.INVOKE;
        // Mess := NPOPurchaseInvoice."No.".Value;
        // if GetLastErrorText <> (DocumentDateError + NPOPurchaseInvoice."No.".VALUE + DocumentDateError1) then
        //     //IF GETLASTERRORTEXT <> DocumentDateError3 THEN
        //     Error('Unexpected Error: %1', GetLastErrorText);


        // PurchHdr.reset();
        // PurchHdr.get(PurchHdr."Document Type"::Invoice, PurchInvNo);
        // NPOPurchaseInvoice.CLOSE;
        // Clear(NPOPurchaseInvoice);
        // NPOPurchaseInvoice.OpenView();
        // NPOPurchaseInvoice.OPENEDIT; // 1111111111111111111111111111111111111111111111111111
        // NPOPurchaseInvoice.GoToRecord(PurchHdr);
        // NPOPurchaseInvoice.FILTER.SETFILTER("No.", PurchInvNo);
        // NPOPurchaseInvoice."Document Date".SETVALUE(Today);
        // NPOPurchaseInvoice."Posting Date".SETVALUE(Today);//HEI.106
        // NPOPurchaseInvoice.PurchLines.NEW;//HEI.99
        // NPOPurchaseInvoice.PurchLines.NPOType.SETVALUE(Type::"G/L Account");
        // NPOPurchaseInvoice.PurchLines."No.".SETVALUE(GLAccount."No.");
        // NPOPurchaseInvoice.PurchLines.Quantity.SETVALUE(1);
        // NPOPurchaseInvoice.PurchLines."Direct Unit Cost".SETVALUE(100);
        // //HEI.20>>
        // //HEI.26>>
        // // NPOPurchaseInvoice.PurchLines."Shortcut Dimension 2 Code".SETVALUE(DimensionValue.Code);
        // //NPOPurchaseInvoice.PurchLines."VAT Prod. Posting Group".SETVALUE('IMP_VAT');
        // // CompanyInformation.GET;
        // // IF (NPOPurchaseInvoice.PurchLines."CAD Amount".VALUE<>FORMAT(0)) AND
        // //  (CompanyInformation."Country/Region Code"<>Vendor."Country/Region Code") THEN
        // //  NPOPurchaseInvoice.PurchLines."VAT Prod. Posting Group".SETVALUE('NO_VAT');
        // //HEI.20<<
        // PurchaseLine.Reset();
        // PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Invoice);
        // PurchaseLine.SETRANGE("Document No.", NPOPurchaseInvoice."No.".VALUE);
        // PurchaseLine.SETRANGE("No.", NPOPurchaseInvoice.PurchLines."No.".VALUE);
        // if PurchaseLine.FindFirst() then begin
        //     CompanyInformation.Get();
        //     //IF (NPOPurchaseInvoice.PurchLines."CAD Amount".VALUE<>FORMAT(0)) AND//HEI.53
        //     if (PurchaseLine."CAD Amount FND" <> 0) and//HEI.53
        //      (CompanyInformation."Country/Region Code" <> Vendor."Country/Region Code") then
        //         PurchaseLine.Validate("VAT Prod. Posting Group", 'NO_VAT');
        //     PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
        //     PurchaseLine.Modify();
        // end;
        // PurchasesPayablesSetup.Get();
        // if PurchasesPayablesSetup."Ext. Doc. No. Mandatory" = false then begin
        //     PurchasesPayablesSetup."Ext. Doc. No. Mandatory" := true;
        //     PurchasesPayablesSetup.Modify();
        // end;
        // //HEI.26<<
        // //HEI.49>>
        // PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, NPOPurchaseInvoice."No.".VALUE);
        // if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
        //     Workflow.Reset();
        //     Workflow.SetRange(Enabled, true);
        //     //HEI.74>>
        //     if Workflow.FindFirst() then
        //         Workflow.ModifyAll(Enabled, false);
        //     //IF Workflow.FINDSET THEN
        //     //REPEAT
        //     //Workflow.Enabled := FALSE;
        //     //Workflow.MODIFY;
        //     //UNTIL Workflow.NEXT = 0;
        //     //HEI.74<<
        // end;
        // //HEI.49<<
        // //HEI.51>>
        // if PurchasesPayablesSetup.Get() then
        //     if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
        //         NPOPurchaseInvoice."Location Code".SETVALUE(Location.Code);
        // //HEI.51<<
        // asserterror NPOPurchaseInvoice.Post.INVOKE;
        // if GetLastErrorText <> (VendorInvoiceNoError + NPOPurchaseInvoice."No.".VALUE + VendorInvoiceNoError1) then
        //     Error('Unexpected Error: %1', GetLastErrorText);

        // NPOPurchaseInvoice."Vendor Invoice No.".SETVALUE('StP PTP055');


        // // ASSERTERROR NPOPurchaseInvoice."Due Date".SETVALUE(100921D);//BC UPGRADE KUMARR78 Blocking to Rewritting Date format.
        // asserterror NPOPurchaseInvoice."Due Date".SETVALUE(20210910D);//BC UPGRADE KUMARR78 Adding As Rewritting Date format.

        // if GetLastErrorText <> DateChangeError then
        //     Error('Unexpected Error: %1', GetLastErrorText);
        // asserterror NPOPurchaseInvoice."Payment Method Code".SETVALUE('');
        // if GetLastErrorText <> PaymentMethodCodeError then
        //     Error('Unexpected Error: %1', GetLastErrorText);
        // asserterror NPOPurchaseInvoice."Payment Terms Code".SETVALUE('');
        // if GetLastErrorText <> PaymentTermCodeError then
        //     Error('Unexpected Error: %1', GetLastErrorText);

        // asserterror NPOPurchaseInvoice."Pay-to Name".SETVALUE('');
        // if GetLastErrorText <> PaytoNameError then
        //     Error('Unexpected Error: %1', GetLastErrorText);

        // if (NPOPurchaseInvoice."Vendor Bank Account".VALUE <> '') then
        //     BankAccount := NPOPurchaseInvoice."Vendor Bank Account".VALUE
        // else
        //     BankAccount := 'abc';
        // NPOPurchaseInvoice."Vendor Bank Account".ASSERTEQUALS(BankAccount);


        // DocAmount := 0;
        // VATAmount := 0;
        // PurchLn.Reset();
        // PurchLn.SetRange("Document Type", PurchLn."Document Type"::Invoice);
        // PurchLn.SetRange("Document No.", PurchInvNo);
        // if PurchLn.FindSet() then
        //     repeat
        //         DocAmount += PurchLn."Amount Including VAT";
        //         VATAmount += (PurchLn."Amount Including VAT" - PurchLn.Amount);
        //     until PurchLn.Next() = 0;

        // //BC UPGRADE KUMARR78 >> DIT Variable Removed.
        // NPOPurchaseInvoice."Doc. Amount Incl. VAT IBM".SETVALUE('100');
        // NPOPurchaseInvoice."Doc. Amount VAT IBM".SETVALUE('10');
        // //BC UPGRADE KUMARR78 << DIT Variable Removed.

        // NPOPurchaseInvoice.Post.INVOKE;


        //HEI.16<<
    end;

    // [Test]
    [HandlerFunctions('ConfirmationHandler')]
    procedure "PTP055 Negativetesting NPO Invoice01"();
    var
        PurchaseInvList: TestPage "NPO Purchase Invoices";
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
        dkjadbjs: TestPage "NPO Purchase Invoices";
        NPOPurchaseInvoice: TestPage "NPO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        DueDate: Text;
        BankAccount: Text;
        PostedPurchInvHdr: Record "Purch. Inv. Header";
        StorePostedInvNo: Code[20];
        PostedPurchInv: TestPage "Posted Purchase Invoice";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        DocumentDateError: TextConst ENU = 'Document Date must have a value in Purchase Header: Document Type=Invoice, No.=';
        DateChangeError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''You cannot modify the field- ''Due Date''.  (Select Refresh to discard errors)''';
        PaymentMethodCodeError: TextConst ENU = 'Validation error for Field: Payment Method Code,  Message = ''You cannot modify the field- ''Payment Method Code''.  (Select Refresh to discard errors)''';
        PaymentTermCodeError: TextConst ENU = 'Validation error for Field: Payment Terms Code,  Message = ''You cannot modify the field- ''Payment Terms Code''.  (Select Refresh to discard errors)''';
        PaytoNameError: TextConst ENU = 'Validation error for Field: Pay-to Name,  Message = ''Name must be filled in. Enter a value. (Select Refresh to discard errors)''';
        DocumentDateError1: Label '. It cannot be zero or empty.';
        VendorInvoiceNoError: TextConst ENU = 'Vendor Invoice No. must have a value in Purchase Header: Document Type=Invoice, No.=';
        VendorInvoiceNoError1: Label '. It cannot be zero or empty.';
        DocumentDateError3: TextConst ENU = ' Document Date must have a value in Purchase Header: Document Type=Invoice, No.=PI00016837. It cannot be zero or empty.';
        CompanyInformation: Record "Company Information";
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseLine: Record "Purchase Line";
        DimensionValue: Record "Dimension Value";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Location: Record Location;
        DefaultDimension: Record "Default Dimension";
        Workflow: Record Workflow;
        Mess: text;
        PurchHdr: record "Purchase Header";
    begin

        DimensionRestrictionCheck; //HEI.95
        //HEI.16>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP055', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP055', CompanyName, Database::"G/L Account");
        GLAccount.Get(UnitTestingValues.Value);
        //HEI.53>>
        if DefaultDimension.Get(15, GLAccount."No.", 'TRD_PART') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;

        //BC UPGRADE KUMARR78 >> DIT Variable Removed.
        // IF PurchasesPayablesSetup.GET THEN
        //     IF PurchasesPayablesSetup."Show Posted Document No." THEN BEGIN
        //         PurchasesPayablesSetup."Show Posted Document No." := FALSE;
        //         PurchasesPayablesSetup.MODIFY;
        //     END;
        //BC UPGRADE KUMARR78 << DIT Variable Removed.

        //HEI.53<<
        //HEI.55>>
        if DefaultDimension.Get(15, GLAccount."No.", 'BRAND') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;
        //HEI.55<<
        //HEI.20>>
        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP055', CompanyName, Database::"Dimension Value");
        if UnitTestingValues.Value <> '' then
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);
        //HEI.20<<

        NPOPurchaseInvoice.OPENNEW;
        NPOPurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");
        PurchInvNo := NPOPurchaseInvoice."No.".VALUE;
        NPOPurchaseInvoice."Document Date".SETVALUE(0D);
        //HEI.51>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP055', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                NPOPurchaseInvoice."Location Code".SETVALUE(Location.Code);
        //HEI.51<<
        //222222222222222222222222222222
        Mess := NPOPurchaseInvoice."No.".Value;
        asserterror NPOPurchaseInvoice.Post.INVOKE;
        Mess := NPOPurchaseInvoice."No.".Value;
        if GetLastErrorText <> (DocumentDateError + NPOPurchaseInvoice."No.".VALUE + DocumentDateError1) then
            //IF GETLASTERRORTEXT <> DocumentDateError3 THEN
            Error('Unexpected Error: %1', GetLastErrorText);


        // PurchHdr.reset();
        // PurchHdr.get(PurchHdr."Document Type"::Invoice, PurchInvNo);
        // NPOPurchaseInvoice.CLOSE;
        // Clear(NPOPurchaseInvoice);
        // NPOPurchaseInvoice.OpenView();
        // NPOPurchaseInvoice.OPENEDIT; // 1111111111111111111111111111111111111111111111111111
        // NPOPurchaseInvoice.GoToRecord(PurchHdr);
        // NPOPurchaseInvoice.FILTER.SETFILTER("No.", PurchInvNo);
        // NPOPurchaseInvoice."Document Date".SETVALUE(Today);
        // NPOPurchaseInvoice."Posting Date".SETVALUE(Today);//HEI.106
        // NPOPurchaseInvoice.PurchLines.NEW;//HEI.99
        // NPOPurchaseInvoice.PurchLines.NPOType.SETVALUE(Type::"G/L Account");
        // NPOPurchaseInvoice.PurchLines."No.".SETVALUE(GLAccount."No.");
        // NPOPurchaseInvoice.PurchLines.Quantity.SETVALUE(1);
        // NPOPurchaseInvoice.PurchLines."Direct Unit Cost".SETVALUE(100);
        // //HEI.20>>
        // //HEI.26>>
        // // NPOPurchaseInvoice.PurchLines."Shortcut Dimension 2 Code".SETVALUE(DimensionValue.Code);
        // //NPOPurchaseInvoice.PurchLines."VAT Prod. Posting Group".SETVALUE('IMP_VAT');
        // // CompanyInformation.GET;
        // // IF (NPOPurchaseInvoice.PurchLines."CAD Amount".VALUE<>FORMAT(0)) AND
        // //  (CompanyInformation."Country/Region Code"<>Vendor."Country/Region Code") THEN
        // //  NPOPurchaseInvoice.PurchLines."VAT Prod. Posting Group".SETVALUE('NO_VAT');
        // //HEI.20<<
        // PurchaseLine.Reset();
        // PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Invoice);
        // PurchaseLine.SETRANGE("Document No.", NPOPurchaseInvoice."No.".VALUE);
        // PurchaseLine.SETRANGE("No.", NPOPurchaseInvoice.PurchLines."No.".VALUE);
        // if PurchaseLine.FindFirst() then begin
        //     CompanyInformation.Get();
        //     //IF (NPOPurchaseInvoice.PurchLines."CAD Amount".VALUE<>FORMAT(0)) AND//HEI.53
        //     if (PurchaseLine."CAD Amount FND" <> 0) and//HEI.53
        //      (CompanyInformation."Country/Region Code" <> Vendor."Country/Region Code") then
        //         PurchaseLine.Validate("VAT Prod. Posting Group", 'NO_VAT');
        //     PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
        //     PurchaseLine.Modify();
        // end;
        // PurchasesPayablesSetup.Get();
        // if PurchasesPayablesSetup."Ext. Doc. No. Mandatory" = false then begin
        //     PurchasesPayablesSetup."Ext. Doc. No. Mandatory" := true;
        //     PurchasesPayablesSetup.Modify();
        // end;
        // //HEI.26<<
        // //HEI.49>>
        // PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, NPOPurchaseInvoice."No.".VALUE);
        // if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
        //     Workflow.Reset();
        //     Workflow.SetRange(Enabled, true);
        //     //HEI.74>>
        //     if Workflow.FindFirst() then
        //         Workflow.ModifyAll(Enabled, false);
        //     //IF Workflow.FINDSET THEN
        //     //REPEAT
        //     //Workflow.Enabled := FALSE;
        //     //Workflow.MODIFY;
        //     //UNTIL Workflow.NEXT = 0;
        //     //HEI.74<<
        // end;
        // //HEI.49<<
        // //HEI.51>>
        // if PurchasesPayablesSetup.Get() then
        //     if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
        //         NPOPurchaseInvoice."Location Code".SETVALUE(Location.Code);
        // //HEI.51<<
        // asserterror NPOPurchaseInvoice.Post.INVOKE;
        // if GetLastErrorText <> (VendorInvoiceNoError + NPOPurchaseInvoice."No.".VALUE + VendorInvoiceNoError1) then
        //     Error('Unexpected Error: %1', GetLastErrorText);

        // NPOPurchaseInvoice."Vendor Invoice No.".SETVALUE('StP PTP055');


        // // ASSERTERROR NPOPurchaseInvoice."Due Date".SETVALUE(100921D);//BC UPGRADE KUMARR78 Blocking to Rewritting Date format.
        // asserterror NPOPurchaseInvoice."Due Date".SETVALUE(20210910D);//BC UPGRADE KUMARR78 Adding As Rewritting Date format.

        // if GetLastErrorText <> DateChangeError then
        //     Error('Unexpected Error: %1', GetLastErrorText);
        // asserterror NPOPurchaseInvoice."Payment Method Code".SETVALUE('');
        // if GetLastErrorText <> PaymentMethodCodeError then
        //     Error('Unexpected Error: %1', GetLastErrorText);
        // asserterror NPOPurchaseInvoice."Payment Terms Code".SETVALUE('');
        // if GetLastErrorText <> PaymentTermCodeError then
        //     Error('Unexpected Error: %1', GetLastErrorText);

        // asserterror NPOPurchaseInvoice."Pay-to Name".SETVALUE('');
        // if GetLastErrorText <> PaytoNameError then
        //     Error('Unexpected Error: %1', GetLastErrorText);

        // if (NPOPurchaseInvoice."Vendor Bank Account".VALUE <> '') then
        //     BankAccount := NPOPurchaseInvoice."Vendor Bank Account".VALUE
        // else
        //     BankAccount := 'abc';
        // NPOPurchaseInvoice."Vendor Bank Account".ASSERTEQUALS(BankAccount);


        // DocAmount := 0;
        // VATAmount := 0;
        // PurchLn.Reset();
        // PurchLn.SetRange("Document Type", PurchLn."Document Type"::Invoice);
        // PurchLn.SetRange("Document No.", PurchInvNo);
        // if PurchLn.FindSet() then
        //     repeat
        //         DocAmount += PurchLn."Amount Including VAT";
        //         VATAmount += (PurchLn."Amount Including VAT" - PurchLn.Amount);
        //     until PurchLn.Next() = 0;

        // //BC UPGRADE KUMARR78 >> DIT Variable Removed.
        // NPOPurchaseInvoice."Doc. Amount Incl. VAT IBM".SETVALUE('100');
        // NPOPurchaseInvoice."Doc. Amount VAT IBM".SETVALUE('10');
        // //BC UPGRADE KUMARR78 << DIT Variable Removed.

        // NPOPurchaseInvoice.Post.INVOKE;


        //HEI.16<<
    end;

    // [Test]
    [HandlerFunctions('ConfirmationHandler')]
    procedure "PTP055 Negativetesting NPO Invoice2"();
    var
        PurchaseInvList: TestPage "NPO Purchase Invoices";
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
        dkjadbjs: TestPage "NPO Purchase Invoices";
        NPOPurchaseInvoice: TestPage "NPO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        DueDate: Text;
        BankAccount: Text;
        PostedPurchInvHdr: Record "Purch. Inv. Header";
        StorePostedInvNo: Code[20];
        PostedPurchInv: TestPage "Posted Purchase Invoice";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        DocumentDateError: TextConst ENU = 'Document Date must have a value in Purchase Header: Document Type=Invoice, No.=';
        DateChangeError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''You cannot modify the field- ''Due Date''.  (Select Refresh to discard errors)''';
        PaymentMethodCodeError: TextConst ENU = 'Validation error for Field: Payment Method Code,  Message = ''You cannot modify the field- ''Payment Method Code''.  (Select Refresh to discard errors)''';
        PaymentTermCodeError: TextConst ENU = 'Validation error for Field: Payment Terms Code,  Message = ''You cannot modify the field- ''Payment Terms Code''.  (Select Refresh to discard errors)''';
        PaytoNameError: TextConst ENU = 'Validation error for Field: Pay-to Name,  Message = ''Name must be filled in. Enter a value. (Select Refresh to discard errors)''';
        DocumentDateError1: Label '. It cannot be zero or empty.';
        // VendorInvoiceNoError: TextConst ENU = 'Vendor Invoice No. must have a value in Purchase Header: Document Type=Invoice, No.=';
        VendorInvoiceNoError: Label 'You need to enter the document number of the document from the vendor in the Vendor Invoice No. field, so that this document stays linked to the original.';
        VendorInvoiceNoError1: Label '. It cannot be zero or empty.';
        DocumentDateError3: TextConst ENU = ' Document Date must have a value in Purchase Header: Document Type=Invoice, No.=PI00016837. It cannot be zero or empty.';
        CompanyInformation: Record "Company Information";
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseLine: Record "Purchase Line";
        DimensionValue: Record "Dimension Value";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Location: Record Location;
        DefaultDimension: Record "Default Dimension";
        Workflow: Record Workflow;
        Mess: text;
        PurchHdr: record "Purchase Header";
        ErrorMesageHide: Codeunit "Error Message Hide TestScripts";
    begin

        DimensionRestrictionCheck; //HEI.95
        //HEI.16>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP055', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP055', CompanyName, Database::"G/L Account");
        GLAccount.Get(UnitTestingValues.Value);
        //HEI.53>>
        if DefaultDimension.Get(15, GLAccount."No.", 'TRD_PART') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;

        //BC UPGRADE KUMARR78 >> DIT Variable Removed.
        // IF PurchasesPayablesSetup.GET THEN
        //     IF PurchasesPayablesSetup."Show Posted Document No." THEN BEGIN
        //         PurchasesPayablesSetup."Show Posted Document No." := FALSE;
        //         PurchasesPayablesSetup.MODIFY;
        //     END;
        //BC UPGRADE KUMARR78 << DIT Variable Removed.

        //HEI.53<<
        //HEI.55>>
        if DefaultDimension.Get(15, GLAccount."No.", 'BRAND') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;
        //HEI.55<<
        //HEI.20>>
        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP055', CompanyName, Database::"Dimension Value");
        if UnitTestingValues.Value <> '' then
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);
        //HEI.20<<

        NPOPurchaseInvoice.OPENNEW;
        NPOPurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");
        PurchInvNo := NPOPurchaseInvoice."No.".VALUE;
        NPOPurchaseInvoice."Document Date".SETVALUE(0D);
        //HEI.51>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP055', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                NPOPurchaseInvoice."Location Code".SETVALUE(Location.Code);
        //HEI.51<<
        //222222222222222222222222222222
        Mess := NPOPurchaseInvoice."No.".Value;
        // asserterror NPOPurchaseInvoice.Post.INVOKE;
        Mess := NPOPurchaseInvoice."No.".Value;
        // if GetLastErrorText <> (DocumentDateError + NPOPurchaseInvoice."No.".VALUE + DocumentDateError1) then
        //     //IF GETLASTERRORTEXT <> DocumentDateError3 THEN
        //     Error('Unexpected Error: %1', GetLastErrorText);
        // PurchHdr.reset();
        // PurchHdr.get(PurchHdr."Document Type"::Invoice, PurchInvNo);
        // NPOPurchaseInvoice.CLOSE;
        // Clear(NPOPurchaseInvoice);
        // NPOPurchaseInvoice.OpenView();
        // NPOPurchaseInvoice.OPENEDIT; // 1111111111111111111111111111111111111111111111111111
        // NPOPurchaseInvoice.GoToRecord(PurchHdr);
        // NPOPurchaseInvoice.FILTER.SETFILTER("No.", PurchInvNo);
        NPOPurchaseInvoice."Document Date".SETVALUE(Today);
        NPOPurchaseInvoice."Posting Date".SETVALUE(Today);//HEI.106
        NPOPurchaseInvoice.PurchLines.NEW;//HEI.99
        NPOPurchaseInvoice.PurchLines.NPOType.SETVALUE(Type::"G/L Account");
        NPOPurchaseInvoice.PurchLines."No.".SETVALUE(GLAccount."No.");
        NPOPurchaseInvoice.PurchLines.Quantity.SETVALUE(1);
        NPOPurchaseInvoice.PurchLines."Direct Unit Cost".SETVALUE(100);
        //HEI.20>>
        //HEI.26>>
        // NPOPurchaseInvoice.PurchLines."Shortcut Dimension 2 Code".SETVALUE(DimensionValue.Code);
        //NPOPurchaseInvoice.PurchLines."VAT Prod. Posting Group".SETVALUE('IMP_VAT');
        // CompanyInformation.GET;
        // IF (NPOPurchaseInvoice.PurchLines."CAD Amount".VALUE<>FORMAT(0)) AND
        //  (CompanyInformation."Country/Region Code"<>Vendor."Country/Region Code") THEN
        //  NPOPurchaseInvoice.PurchLines."VAT Prod. Posting Group".SETVALUE('NO_VAT');
        //HEI.20<<
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Invoice);
        PurchaseLine.SETRANGE("Document No.", NPOPurchaseInvoice."No.".VALUE);
        PurchaseLine.SETRANGE("No.", NPOPurchaseInvoice.PurchLines."No.".VALUE);
        if PurchaseLine.FindFirst() then begin
            CompanyInformation.Get();
            //IF (NPOPurchaseInvoice.PurchLines."CAD Amount".VALUE<>FORMAT(0)) AND//HEI.53
            if (PurchaseLine."CAD Amount FND" <> 0) and//HEI.53
             (CompanyInformation."Country/Region Code" <> Vendor."Country/Region Code") then
                PurchaseLine.Validate("VAT Prod. Posting Group", 'NO_VAT');
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
            PurchaseLine.Modify();
        end;
        PurchasesPayablesSetup.Get();
        if PurchasesPayablesSetup."Ext. Doc. No. Mandatory" = false then begin
            PurchasesPayablesSetup."Ext. Doc. No. Mandatory" := true;
            PurchasesPayablesSetup.Modify();
        end;
        //HEI.26<<
        //HEI.49>>
        PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, NPOPurchaseInvoice."No.".VALUE);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.Reset();
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            //IF Workflow.FINDSET THEN
            //REPEAT
            //Workflow.Enabled := FALSE;
            //Workflow.MODIFY;
            //UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;
        //HEI.49<<
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                NPOPurchaseInvoice."Location Code".SETVALUE(Location.Code);
        //HEI.51<<
        // asserterror NPOPurchaseInvoice.Post.INVOKE;
        Clear(LastError);
        BindSubscription(ErrorMesageHide);
        NPOPurchaseInvoice.Post.INVOKE;
        ErrorMesageHide.Run();
        LastError := ErrorMesageHide.ErrorMesage();
        UnbindSubscription(ErrorMesageHide);
        // if GetLastErrorText <> (VendorInvoiceNoError + NPOPurchaseInvoice."No.".VALUE + VendorInvoiceNoError1) then
        if LastError <> (VendorInvoiceNoError) then
            Error('Unexpected Error: %1', GetLastErrorText);

        // NPOPurchaseInvoice."Vendor Invoice No.".SETVALUE('StP PTP055');


        // // ASSERTERROR NPOPurchaseInvoice."Due Date".SETVALUE(100921D);//BC UPGRADE KUMARR78 Blocking to Rewritting Date format.
        // asserterror NPOPurchaseInvoice."Due Date".SETVALUE(20210910D);//BC UPGRADE KUMARR78 Adding As Rewritting Date format.

        // if GetLastErrorText <> DateChangeError then
        //     Error('Unexpected Error: %1', GetLastErrorText);
        // asserterror NPOPurchaseInvoice."Payment Method Code".SETVALUE('');
        // if GetLastErrorText <> PaymentMethodCodeError then
        //     Error('Unexpected Error: %1', GetLastErrorText);
        // asserterror NPOPurchaseInvoice."Payment Terms Code".SETVALUE('');
        // if GetLastErrorText <> PaymentTermCodeError then
        //     Error('Unexpected Error: %1', GetLastErrorText);

        // asserterror NPOPurchaseInvoice."Pay-to Name".SETVALUE('');
        // if GetLastErrorText <> PaytoNameError then
        //     Error('Unexpected Error: %1', GetLastErrorText);

        // if (NPOPurchaseInvoice."Vendor Bank Account".VALUE <> '') then
        //     BankAccount := NPOPurchaseInvoice."Vendor Bank Account".VALUE
        // else
        //     BankAccount := 'abc';
        // NPOPurchaseInvoice."Vendor Bank Account".ASSERTEQUALS(BankAccount);


        // DocAmount := 0;
        // VATAmount := 0;
        // PurchLn.Reset();
        // PurchLn.SetRange("Document Type", PurchLn."Document Type"::Invoice);
        // PurchLn.SetRange("Document No.", PurchInvNo);
        // if PurchLn.FindSet() then
        //     repeat
        //         DocAmount += PurchLn."Amount Including VAT";
        //         VATAmount += (PurchLn."Amount Including VAT" - PurchLn.Amount);
        //     until PurchLn.Next() = 0;

        // //BC UPGRADE KUMARR78 >> DIT Variable Removed.
        // NPOPurchaseInvoice."Doc. Amount Incl. VAT IBM".SETVALUE('100');
        // NPOPurchaseInvoice."Doc. Amount VAT IBM".SETVALUE('10');
        // //BC UPGRADE KUMARR78 << DIT Variable Removed.

        // NPOPurchaseInvoice.Post.INVOKE;


        //HEI.16<<
    end;

    [HandlerFunctions('ConfirmationHandler')]
    procedure "PTP055 Negativetesting NPO Invoice3"();
    var
        PurchaseInvList: TestPage "NPO Purchase Invoices";
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
        dkjadbjs: TestPage "NPO Purchase Invoices";
        NPOPurchaseInvoice: TestPage "NPO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        DueDate: Text;
        BankAccount: Text;
        PostedPurchInvHdr: Record "Purch. Inv. Header";
        StorePostedInvNo: Code[20];
        PostedPurchInv: TestPage "Posted Purchase Invoice";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        DocumentDateError: TextConst ENU = 'Document Date must have a value in Purchase Header: Document Type=Invoice, No.=';
        // DateChangeError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''You cannot modify the field- ''Due Date''.  (Select Refresh to discard errors)''';
        DateChangeError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''"You cannot modify the field- ''Due Date''. " (Select Refresh to discard errors)'''; // BC Upgrade BHARDA11'
        // PaymentMethodCodeError: TextConst ENU = 'Validation error for Field: Payment Method Code,  Message = ''You cannot modify the field- ''Payment Method Code''.  (Select Refresh to discard errors)''';
        PaymentMethodCodeError: TextConst ENU = 'Validation error for Field: Payment Method Code,  Message = ''"You cannot modify the field- ''Payment Method Code''. " (Select Refresh to discard errors)''';
        // PaymentTermCodeError: TextConst ENU = 'Validation error for Field: Payment Terms Code,  Message = ''You cannot modify the field- ''Payment Terms Code''.  (Select Refresh to discard errors)''';
        PaymentTermCodeError: TextConst ENU = 'Validation error for Field: Payment Terms Code,  Message = ''"You cannot modify the field- ''Payment Terms Code''. " (Select Refresh to discard errors)''';
        PaytoNameError: TextConst ENU = 'Validation error for Field: Pay-to Name,  Message = ''Name must be filled in. Enter a value. (Select Refresh to discard errors)''';
        DocumentDateError1: Label '. It cannot be zero or empty.';
        VendorInvoiceNoError: TextConst ENU = 'Vendor Invoice No. must have a value in Purchase Header: Document Type=Invoice, No.=';
        VendorInvoiceNoError1: Label '. It cannot be zero or empty.';
        DocumentDateError3: TextConst ENU = ' Document Date must have a value in Purchase Header: Document Type=Invoice, No.=PI00016837. It cannot be zero or empty.';
        CompanyInformation: Record "Company Information";
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseLine: Record "Purchase Line";
        DimensionValue: Record "Dimension Value";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Location: Record Location;
        DefaultDimension: Record "Default Dimension";
        Workflow: Record Workflow;
        Mess, checkError : text;
        PurchHdr: record "Purchase Header";
    begin

        DimensionRestrictionCheck; //HEI.95
        //HEI.16>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP055', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP055', CompanyName, Database::"G/L Account");
        GLAccount.Get(UnitTestingValues.Value);
        //HEI.53>>
        if DefaultDimension.Get(15, GLAccount."No.", 'TRD_PART') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;

        //BC UPGRADE KUMARR78 >> DIT Variable Removed.
        // IF PurchasesPayablesSetup.GET THEN
        //     IF PurchasesPayablesSetup."Show Posted Document No." THEN BEGIN
        //         PurchasesPayablesSetup."Show Posted Document No." := FALSE;
        //         PurchasesPayablesSetup.MODIFY;
        //     END;
        //BC UPGRADE KUMARR78 << DIT Variable Removed.

        //HEI.53<<
        //HEI.55>>
        if DefaultDimension.Get(15, GLAccount."No.", 'BRAND') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;
        //HEI.55<<
        //HEI.20>>
        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP055', CompanyName, Database::"Dimension Value");
        if UnitTestingValues.Value <> '' then
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);
        //HEI.20<<

        NPOPurchaseInvoice.OPENNEW;
        NPOPurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");
        PurchInvNo := NPOPurchaseInvoice."No.".VALUE;
        NPOPurchaseInvoice."Document Date".SETVALUE(0D);
        //HEI.51>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP055', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                NPOPurchaseInvoice."Location Code".SETVALUE(Location.Code);
        //HEI.51<<
        //222222222222222222222222222222
        Mess := NPOPurchaseInvoice."No.".Value;
        // asserterror NPOPurchaseInvoice.Post.INVOKE;
        Mess := NPOPurchaseInvoice."No.".Value;
        // if GetLastErrorText <> (DocumentDateError + NPOPurchaseInvoice."No.".VALUE + DocumentDateError1) then
        //     //IF GETLASTERRORTEXT <> DocumentDateError3 THEN
        //     Error('Unexpected Error: %1', GetLastErrorText);
        // PurchHdr.reset();
        // PurchHdr.get(PurchHdr."Document Type"::Invoice, PurchInvNo);
        // NPOPurchaseInvoice.CLOSE;
        // Clear(NPOPurchaseInvoice);
        // NPOPurchaseInvoice.OpenView();
        // NPOPurchaseInvoice.OPENEDIT; // 1111111111111111111111111111111111111111111111111111
        // NPOPurchaseInvoice.GoToRecord(PurchHdr);
        // NPOPurchaseInvoice.FILTER.SETFILTER("No.", PurchInvNo);
        NPOPurchaseInvoice."Document Date".SETVALUE(Today);
        NPOPurchaseInvoice."Posting Date".SETVALUE(Today);//HEI.106
        NPOPurchaseInvoice.PurchLines.NEW;//HEI.99
        NPOPurchaseInvoice.PurchLines.NPOType.SETVALUE(Type::"G/L Account");
        NPOPurchaseInvoice.PurchLines."No.".SETVALUE(GLAccount."No.");
        NPOPurchaseInvoice.PurchLines.Quantity.SETVALUE(1);
        NPOPurchaseInvoice.PurchLines."Direct Unit Cost".SETVALUE(100);
        //HEI.20>>
        //HEI.26>>
        // NPOPurchaseInvoice.PurchLines."Shortcut Dimension 2 Code".SETVALUE(DimensionValue.Code);
        //NPOPurchaseInvoice.PurchLines."VAT Prod. Posting Group".SETVALUE('IMP_VAT');
        // CompanyInformation.GET;
        // IF (NPOPurchaseInvoice.PurchLines."CAD Amount".VALUE<>FORMAT(0)) AND
        //  (CompanyInformation."Country/Region Code"<>Vendor."Country/Region Code") THEN
        //  NPOPurchaseInvoice.PurchLines."VAT Prod. Posting Group".SETVALUE('NO_VAT');
        //HEI.20<<
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Invoice);
        PurchaseLine.SETRANGE("Document No.", NPOPurchaseInvoice."No.".VALUE);
        PurchaseLine.SETRANGE("No.", NPOPurchaseInvoice.PurchLines."No.".VALUE);
        if PurchaseLine.FindFirst() then begin
            CompanyInformation.Get();
            //IF (NPOPurchaseInvoice.PurchLines."CAD Amount".VALUE<>FORMAT(0)) AND//HEI.53
            if (PurchaseLine."CAD Amount FND" <> 0) and//HEI.53
             (CompanyInformation."Country/Region Code" <> Vendor."Country/Region Code") then
                PurchaseLine.Validate("VAT Prod. Posting Group", 'NO_VAT');
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
            PurchaseLine.Modify();
        end;
        PurchasesPayablesSetup.Get();
        if PurchasesPayablesSetup."Ext. Doc. No. Mandatory" = false then begin
            PurchasesPayablesSetup."Ext. Doc. No. Mandatory" := true;
            PurchasesPayablesSetup.Modify();
        end;
        //HEI.26<<
        //HEI.49>>
        PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, NPOPurchaseInvoice."No.".VALUE);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.Reset();
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            //IF Workflow.FINDSET THEN
            //REPEAT
            //Workflow.Enabled := FALSE;
            //Workflow.MODIFY;
            //UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;
        //HEI.49<<
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                NPOPurchaseInvoice."Location Code".SETVALUE(Location.Code);
        //HEI.51<<
        // asserterror NPOPurchaseInvoice.Post.INVOKE;
        // if GetLastErrorText <> (VendorInvoiceNoError + NPOPurchaseInvoice."No.".VALUE + VendorInvoiceNoError1) then
        //     Error('Unexpected Error: %1', GetLastErrorText);

        NPOPurchaseInvoice."Vendor Invoice No.".SETVALUE('StP PTP055');


        // ASSERTERROR NPOPurchaseInvoice."Due Date".SETVALUE(100921D);//BC UPGRADE KUMARR78 Blocking to Rewritting Date format.
        asserterror NPOPurchaseInvoice."Due Date".SETVALUE(20210910D);//BC UPGRADE KUMARR78 Adding As Rewritting Date format.
        clear(LastError);
        LastError := GetLastErrorText;
        // if GetLastErrorText <> DateChangeError then
        if LastError <> DateChangeError then
            Error('Unexpected Error: %1', GetLastErrorText);
        asserterror NPOPurchaseInvoice."Payment Method Code".SETVALUE('');
        clear(LastError);
        LastError := GetLastErrorText;
        // if GetLastErrorText <> PaymentMethodCodeError then
        Clear(checkError);
        checkError := PaymentMethodCodeError;
        if LastError <> PaymentMethodCodeError then
            Error('Unexpected Error: %1', GetLastErrorText);
        asserterror NPOPurchaseInvoice."Payment Terms Code".SETVALUE('');
        clear(LastError);
        LastError := GetLastErrorText;
        // if GetLastErrorText <> PaymentTermCodeError then
        Clear(checkError);
        checkError := PaymentTermCodeError;
        if LastError <> PaymentTermCodeError then
            Error('Unexpected Error: %1', GetLastErrorText);

        asserterror NPOPurchaseInvoice."Pay-to Name".SETVALUE('');
        clear(LastError);
        LastError := GetLastErrorText;
        // if GetLastErrorText <> PaytoNameError then
        Clear(checkError);
        checkError := PaytoNameError;
        if LastError <> PaytoNameError then
            Error('Unexpected Error: %1', GetLastErrorText);

        if (NPOPurchaseInvoice."Vendor Bank Account".VALUE <> '') then
            BankAccount := NPOPurchaseInvoice."Vendor Bank Account".VALUE
        else
            BankAccount := 'abc';
        NPOPurchaseInvoice."Vendor Bank Account".ASSERTEQUALS(BankAccount);


        DocAmount := 0;
        VATAmount := 0;
        PurchLn.Reset();
        PurchLn.SetRange("Document Type", PurchLn."Document Type"::Invoice);
        PurchLn.SetRange("Document No.", PurchInvNo);
        if PurchLn.FindSet() then
            repeat
                DocAmount += PurchLn."Amount Including VAT";
                VATAmount += (PurchLn."Amount Including VAT" - PurchLn.Amount);
            until PurchLn.Next() = 0;

        //BC UPGRADE KUMARR78 >> DIT Variable Removed.
        NPOPurchaseInvoice."Doc. Amount Incl. VAT IBM".SETVALUE('100');
        NPOPurchaseInvoice."Doc. Amount VAT IBM".SETVALUE('10');
        //BC UPGRADE KUMARR78 << DIT Variable Removed.

        NPOPurchaseInvoice.Post.INVOKE;


        //HEI.16<<
    end;

    // [Test]
    // // [HandlerFunctions('ConfirmationHandler')]MessageHandler // BC Upgrade BHARDA11
    // [HandlerFunctions('ConfirmationHandler,MessageHandler,ErrorPageHandler')]
    // procedure "PTP055 Negativetesting NPO Invoice"();
    // var
    //     PurchaseInvList: TestPage "NPO Purchase Invoices";
    //     Vendor: Record Vendor;
    //     GLAccount: Record "G/L Account";
    //     NPOPurchaseInvoice: TestPage "NPO Purchase Invoice";
    //     PurchaseOrderList: TestPage "Purchase Orders";
    //     PurchaseOrder: TestPage "Purchase Order";
    //     WarehouseReceipt: TestPage "Warehouse Receipt";
    //     GetReceiptLines: TestPage "Get Receipt Lines";
    //     Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
    //     ItemTrackingLines: TestPage "Item Tracking Lines";
    //     WhseRcptPONo: Code[20];
    //     PurchRcptHdr: Record "Purch. Rcpt. Header";
    //     VendorBankAccount: Record "Vendor Bank Account";
    //     PurchLn: Record "Purchase Line";
    //     PurchInvNo: Code[20];
    //     DocAmount: Decimal;
    //     VATAmount: Decimal;
    //     DueDate: Text;
    //     BankAccount: Text;
    //     PostedPurchInvHdr: Record "Purch. Inv. Header";
    //     StorePostedInvNo: Code[20];
    //     PostedPurchInv: TestPage "Posted Purchase Invoice";
    //     paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
    //     DocumentDateError: TextConst ENU = 'Document Date must have a value in Purchase Header: Document Type=Invoice, No.=';
    //     DateChangeError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''You cannot modify the field- ''Due Date''.  (Select Refresh to discard errors)''';
    //     PaymentMethodCodeError: TextConst ENU = 'Validation error for Field: Payment Method Code,  Message = ''You cannot modify the field- ''Payment Method Code''.  (Select Refresh to discard errors)''';
    //     PaymentTermCodeError: TextConst ENU = 'Validation error for Field: Payment Terms Code,  Message = ''You cannot modify the field- ''Payment Terms Code''.  (Select Refresh to discard errors)''';
    //     PaytoNameError: TextConst ENU = 'Validation error for Field: Pay-to Name,  Message = ''Name must be filled in. Enter a value. (Select Refresh to discard errors)''';
    //     DocumentDateError1: Label '. It cannot be zero or empty.';
    //     VendorInvoiceNoError: TextConst ENU = 'Vendor Invoice No. must have a value in Purchase Header: Document Type=Invoice, No.=';
    //     VendorInvoiceNoError1: Label '. It cannot be zero or empty.';
    //     DimensionError: TextConst ENU = 'Select a Dimension Value Code for the Dimension Code ';// %1 for G/L Account %2.';
    //     DimensionError2: TextConst ENU = 'for G/L Account ';// %1 for G/L Account %2.';

    //     DocumentDateError3: TextConst ENU = ' Document Date must have a value in Purchase Header: Document Type=Invoice, No.=PI00016837. It cannot be zero or empty.';
    //     CompanyInformation: Record "Company Information";
    //     GeneralLedgerSetup: Record "General Ledger Setup";
    //     PurchaseLine: Record "Purchase Line";
    //     DimensionValue: Record "Dimension Value";
    //     PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    //     Location: Record Location;
    //     DefaultDimension: Record "Default Dimension";
    //     Workflow: Record Workflow;
    //     Purchase_Line: Record "Purchase Line";
    //     Purch_Hdr, Purch_Hdr2 : Record "Purchase Header";
    //     NoSeries: Codeunit "No. Series";
    //     PurchPYSetup: Record "Purchases & Payables Setup";
    //     UserMgt: Codeunit "User Setup Management";
    //     NoSeriesT: Record "No. Series";
    //     DefDim: Record "Default Dimension";

    // begin
    //     DimensionRestrictionCheck; //HEI.95
    //     //HEI.16>>
    //     UnitTestingValues.Reset();
    //     UnitTestingValues.Get('PTP055', CompanyName, Database::Vendor);
    //     Vendor.Get(UnitTestingValues.Value);

    //     UnitTestingValues.Reset();
    //     UnitTestingValues.Get('PTP055', CompanyName, Database::"G/L Account");
    //     GLAccount.Get(UnitTestingValues.Value);
    //     //HEI.53>>
    //     if DefaultDimension.Get(15, GLAccount."No.", 'TRD_PART') then
    //         if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
    //             DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
    //             DefaultDimension.Modify();
    //         end;

    //     //BC UPGRADE KUMARR78 >> DIT Variable Removed.
    //     // IF PurchasesPayablesSetup.GET THEN
    //     //     IF PurchasesPayablesSetup."Show Posted Document No." THEN BEGIN
    //     //         PurchasesPayablesSetup."Show Posted Document No." := FALSE;
    //     //         PurchasesPayablesSetup.MODIFY;
    //     //     END;
    //     //BC UPGRADE KUMARR78 << DIT Variable Removed.

    //     //HEI.53<<
    //     //HEI.55>>
    //     if DefaultDimension.Get(15, GLAccount."No.", 'BRAND') then
    //         if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
    //             DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
    //             DefaultDimension.Modify();
    //         end;
    //     //HEI.55<<
    //     //HEI.20>>
    //     GeneralLedgerSetup.Get();
    //     UnitTestingValues.Reset();
    //     UnitTestingValues.Get('PTP055', CompanyName, Database::"Dimension Value");
    //     if UnitTestingValues.Value <> '' then
    //         DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);
    //     //HEI.20<<

    //     PurchPYSetup.Get();
    //     if NoSeriesT.get(PurchPYSetup."Invoice Nos.") then begin
    //         if NoSeriesT."Manual Nos." = false then begin
    //             NoSeriesT."Manual Nos." := true;
    //             NoSeriesT.Modify();
    //         end;
    //     end;
    //     PurchInvNo := NoSeries.GetNextNo(PurchPYSetup."Invoice Nos.");
    //     Purch_Hdr.Init();
    //     Purch_Hdr."Document Type" := Purch_Hdr."Document Type"::Invoice;
    //     Purch_Hdr."No." := PurchInvNo;
    //     Purch_Hdr."Buy-from Vendor No." := Vendor."No.";
    //     Purch_Hdr.Insert(true);
    //     NPOPurchaseInvoice.OPENEDIT;
    //     // NPOPurchaseInvoice.GOTORECORD(Purch_Hdr);
    //     NPOPurchaseInvoice.GOTOKEY(Purch_Hdr."Document Type"::Invoice, PurchInvNo);
    //     // NPOPurchaseInvoice.FILTER.SETFILTER("No.", PurchInvNo);
    //     // NPOPurchaseInvoice.
    //     // NPOPurchaseInvoice.OPENNEW;
    //     // NPOPurchaseInvoice."No.".SetValue(NoSeries.GetNextNo(PurchPYSetup."Invoice Nos."));
    //     NPOPurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");
    //     PurchInvNo := NPOPurchaseInvoice."No.".VALUE;
    //     NPOPurchaseInvoice."Document Date".SETVALUE(0D);
    //     //HEI.51>>
    //     UnitTestingValues.Reset();
    //     UnitTestingValues.Get('PTP055', CompanyName, Database::Location);
    //     Location.Get(UnitTestingValues.Value);
    //     if PurchasesPayablesSetup.Get() then
    //         if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
    //             NPOPurchaseInvoice."Location Code".SETVALUE(Location.Code); // BC Upgrade BHARAD11
    //     //HEI.51<<
    //     asserterror NPOPurchaseInvoice.Post.INVOKE;// BC Upgrade BHARAD11
    //     // asserterror NPOPurchInvPost(Purch_Hdr);
    //     if GetLastErrorText <> (DocumentDateError + NPOPurchaseInvoice."No.".VALUE + DocumentDateError1) then // BC Upgrade BHARAD11
    //                                                                                                           // if GetLastErrorText <> (DocumentDateError + Purch_Hdr."No." + DocumentDateError1) then // BC Upgrade BHARAD11
    //                                                                                                           //IF GETLASTERRORTEXT <> DocumentDateError3 THEN
    //         Error('Unexpected Error: %1', GetLastErrorText);
    //     NPOPurchaseInvoice."Document Date".SETVALUE(Today);// BC Upgrade BHARAD11
    //     NPOPurchaseInvoice."Posting Date".SETVALUE(Today);//HEI.106// BC Upgrade BHARAD11

    //     NPOPurchaseInvoice.PurchLines.NEW;//HEI.99
    //     NPOPurchaseInvoice.PurchLines.NPOType.SETVALUE(Type::"G/L Account");
    //     NPOPurchaseInvoice.PurchLines."No.".SETVALUE(GLAccount."No.");
    //     NPOPurchaseInvoice.PurchLines.Quantity.SETVALUE(1);
    //     NPOPurchaseInvoice.PurchLines."Direct Unit Cost".SETVALUE(100);
    //     //HEI.20>>
    //     //HEI.26>>
    //     // NPOPurchaseInvoice.PurchLines."Shortcut Dimension 2 Code".SETVALUE(DimensionValue.Code);
    //     //NPOPurchaseInvoice.PurchLines."VAT Prod. Posting Group".SETVALUE('IMP_VAT');
    //     // CompanyInformation.GET;
    //     // IF (NPOPurchaseInvoice.PurchLines."CAD Amount".VALUE<>FORMAT(0)) AND
    //     //  (CompanyInformation."Country/Region Code"<>Vendor."Country/Region Code") THEN
    //     //  NPOPurchaseInvoice.PurchLines."VAT Prod. Posting Group".SETVALUE('NO_VAT');
    //     //HEI.20<<
    //     PurchaseLine.Reset();
    //     PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Invoice);
    //     PurchaseLine.SETRANGE("Document No.", NPOPurchaseInvoice."No.".VALUE);
    //     PurchaseLine.SETRANGE("No.", NPOPurchaseInvoice.PurchLines."No.".VALUE);

    //     if PurchaseLine.FindFirst() then begin
    //         CompanyInformation.Get();
    //         //IF (NPOPurchaseInvoice.PurchLines."CAD Amount".VALUE<>FORMAT(0)) AND//HEI.53
    //         if (PurchaseLine."CAD Amount FND" <> 0) and//HEI.53
    //          (CompanyInformation."Country/Region Code" <> Vendor."Country/Region Code") then
    //             PurchaseLine.Validate("VAT Prod. Posting Group", 'NO_VAT');
    //         PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
    //         PurchaseLine.Modify();
    //     end;
    //     PurchasesPayablesSetup.Get();
    //     if PurchasesPayablesSetup."Ext. Doc. No. Mandatory" = false then begin
    //         PurchasesPayablesSetup."Ext. Doc. No. Mandatory" := true;
    //         PurchasesPayablesSetup.Modify();
    //     end;
    //     //HEI.26<<
    //     //HEI.49>>
    //     // BC Upgrade BHARDA11 >>
    //     Workflow.Reset();
    //     Workflow.SetRange(Template, false);
    //     Workflow.SetRange(Category, 'PURCHDOC');
    //     Workflow.ModifyAll(Enabled, true);
    //     // BC Upgrade BHARDA11 >>
    //     PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, NPOPurchaseInvoice."No.".VALUE);
    //     // PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, Purch_Hdr."No.");
    //     if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
    //         Workflow.Reset();
    //         Workflow.SetRange(Enabled, true);
    //         //HEI.74>>
    //         if Workflow.FindFirst() then
    //             Workflow.ModifyAll(Enabled, false);
    //         //IF Workflow.FINDSET THEN
    //         //REPEAT
    //         //Workflow.Enabled := FALSE;
    //         //Workflow.MODIFY;
    //         //UNTIL Workflow.NEXT = 0;
    //         //HEI.74<<
    //     end;
    //     //HEI.49<<
    //     //HEI.51>>
    //     if PurchasesPayablesSetup.Get() then
    //         if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
    //             NPOPurchaseInvoice."Location Code".SETVALUE(Location.Code);
    //     //HEI.51<<
    //     // asserterror NPOPurchaseInvoice.Post.INVOKE;
    //     NPOPurchaseInvoice.Post.INVOKE;
    //     // DefaultDimension
    //     if LastError <> (DimensionError + DimensionValue."Dimension Code" + DimensionError2 + GLAccount."No." + '.') then
    //         Error('Unexpected Error: %1', LastError);//Abhay
    //     // asserterror NPOPurchInvPost(Purch_Hdr);
    //     if LastError <> (VendorInvoiceNoError + NPOPurchaseInvoice."No.".VALUE + VendorInvoiceNoError1) then
    //         // if GetLastErrorText <> (VendorInvoiceNoError + Purch_Hdr."No." + VendorInvoiceNoError1) then
    //         Error('Unexpected Error: %1', LastError);//Abhay

    //     NPOPurchaseInvoice."Vendor Invoice No.".SETVALUE('StP PTP055');
    //     // Purch_Hdr.validate("Vendor Invoice No.", 'StP PTP055');

    //     // ASSERTERROR NPOPurchaseInvoice."Due Date".SETVALUE(100921D);//BC UPGRADE KUMARR78 Blocking to Rewritting Date format.
    //     asserterror NPOPurchaseInvoice."Due Date".SETVALUE(20210910D);//BC UPGRADE KUMARR78 Adding As Rewritting Date format.
    //     // asserterror Purch_Hdr.validate("Due Date", 20210910D);
    //     LastError := GetLastErrorText;
    //     if GetLastErrorText <> DateChangeError then
    //         Error('Unexpected Error: %1', GetLastErrorText);
    //     asserterror NPOPurchaseInvoice."Payment Method Code".SETVALUE('');
    //     // asserterror Purch_Hdr.validate("Payment Method Code", '');
    //     if GetLastErrorText <> PaymentMethodCodeError then
    //         Error('Unexpected Error: %1', GetLastErrorText);
    //     asserterror NPOPurchaseInvoice."Payment Terms Code".SETVALUE('');
    //     // asserterror Purch_Hdr.validate("Payment Terms Code", '');
    //     if GetLastErrorText <> PaymentTermCodeError then
    //         Error('Unexpected Error: %1', GetLastErrorText);

    //     asserterror NPOPurchaseInvoice."Pay-to Name".SETVALUE('');
    //     // asserterror Purch_Hdr.validate("Pay-to Name", '');
    //     if GetLastErrorText <> PaytoNameError then
    //         Error('Unexpected Error: %1', GetLastErrorText);
    //     // Purch_Hdr.Modify();
    //     // NPOPurchaseInvoice.OPENVIEW;
    //     // NPOPurchaseInvoice.FILTER.SETFILTER("No.", Purch_Hdr."No.");

    //     if (NPOPurchaseInvoice."Vendor Bank Account".VALUE <> '') then
    //         BankAccount := NPOPurchaseInvoice."Vendor Bank Account".VALUE
    //     else
    //         BankAccount := 'abc';
    //     NPOPurchaseInvoice."Vendor Bank Account".ASSERTEQUALS(BankAccount);


    //     DocAmount := 0;
    //     VATAmount := 0;
    //     PurchLn.Reset();
    //     PurchLn.SetRange("Document Type", PurchLn."Document Type"::Invoice);
    //     PurchLn.SetRange("Document No.", PurchInvNo);
    //     if PurchLn.FindSet() then
    //         repeat
    //             DocAmount += PurchLn."Amount Including VAT";
    //             VATAmount += (PurchLn."Amount Including VAT" - PurchLn.Amount);
    //         until PurchLn.Next() = 0;

    //     //BC UPGRADE KUMARR78 >> DIT Variable Removed. // BC Upgrade BHARDA11 >>
    //     NPOPurchaseInvoice."Doc. Amount Incl. VAT IBM".SETVALUE('100');
    //     NPOPurchaseInvoice."Doc. Amount VAT IBM".SETVALUE('10');
    //     //BC UPGRADE KUMARR78 << DIT Variable Removed.

    //     NPOPurchaseInvoice.Post.INVOKE;


    //     //HEI.16<<
    // end;

    // [test]
    // BC Upgrade BHARDA11 >> ------------------------------------------------------
    // procedure NPOPurchInvPost(Rec: Record "Purchase Header")
    // var
    //     BeforeLimit: Label 'Document date %1 in more than 3 months old than the Posting date %2, Do you want to continue ?';
    //     AfterLimit: Label 'Document date should not be more than the Posting date.';
    // begin
    //     //BC Upgrade GUNREM01 >> Added code
    //     Rec.TESTFIELD("Document Date"); //HEI.10
    //                                     //HEI.08>>
    //     if CALCDATE('-3M', Rec."Posting Date") > Rec."Document Date" then
    //         //HEI.09>>
    //         if not CONFIRM(BeforeLimit, false, Rec."Document Date", Rec."Posting Date") then
    //             exit;
    //     //ERROR(BeforeLimit);

    //     //IF CALCDATE('3M',"Posting Date") < "Document Date" THEN
    //     if rec."Document Date" > Rec."Posting Date" then
    //         ERROR(AfterLimit);

    //     //IF "Posting Date" = "Document Date" THEN
    //     //ERROR(EqualDate);
    //     //HEI.09<<
    //     //HEI.08<<
    //     //BC Upgrade GUNREM01 << Added code
    //     VerifyTotal(Rec);
    //     PostDocument(CODEUNIT::"Purch.-Post (Yes/No)", Rec);
    // end;

    // procedure VerifyTotal(Rec: record "Purchase Header")
    // var
    //     IsHandled: Boolean;
    //     TotalsMismatchErr: Label 'The invoice cannot be posted because the total is different from the total on the related incoming document.';
    // begin
    //     IsHandled := false;
    //     // OnBeforeVerifyTotal(Rec, IsHandled);
    //     if IsHandled then
    //         exit;

    //     if not Rec.IsTotalValid() then
    //         Error(TotalsMismatchErr);
    // end;
    // //BC UPGRADE ATHUKUS01 FDDSTP_007 >>
    // local procedure PostDocument(PostingCodeunitID: Integer; Rec: record "Purchase Header");
    // var
    //     PurchaseHeader: Record "Purchase Header";
    //     PurchInvHeader: Record "Purch. Inv. Header";
    //     LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
    //     InstructionMgt: Codeunit "Instruction Mgt.";
    //     IsOfficeAddin: Boolean;
    //     OfficeMgt: Codeunit "Office Management";
    // begin
    //     //  if DummyApplicationAreaSetup.IsFoundationEnabled then
    //     LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

    //     rec.SendToPosting(PostingCodeunitID);

    //     DocumentIsPosted := not PurchaseHeader.GET(rec."Document Type", rec."No.");

    //     // if rec."Job Queue Status" = rec."Job Queue Status"::"Scheduled for Posting" then
    //     //     CurrPage.CLOSE;
    //     // CurrPage.UPDATE(false);

    //     if PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" then
    //         exit;
    //     IsOfficeAddin := OfficeMgt.IsAvailable();
    //     if IsOfficeAddin then begin
    //         PurchInvHeader.SETRANGE("Pre-Assigned No.", rec."No.");
    //         PurchInvHeader.SETRANGE("Order No.", '');
    //         if PurchInvHeader.FINDFIRST then
    //             PAGE.RUN(PAGE::"Posted Purchase Invoice", PurchInvHeader);
    //     end;// else
    //     ShowPostedConfirmationMessage(Rec);
    //     // Error('You can not ');
    // end;

    // local procedure ShowPostedConfirmationMessage(Rec: record "Purchase Header");
    // var
    //     PurchInvHeader1: Record "Purch. Inv. Header";
    //     InstructionMgt: Codeunit "Instruction Mgt.";
    //     OpenPostedPurchaseInvQst: Label 'The invoice is posted as number %1 and moved to the Posted Purchase Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';
    //     NpoPurchINV: page "NPO Purchase Invoice";
    // begin
    //     PurchInvHeader1.Reset();
    //     PurchInvHeader1.SETRANGE("Pre-Assigned No.", rec."No.");
    //     // PurchInvHeader1.SETRANGE("Order No.", '');
    //     if PurchInvHeader1.FINDFIRST then begin
    //         DocumentIsPosted := true;
    //         if NpoPurchINV.ShowConfirm1(StrSubstNo(OpenPostedPurchaseInvQst, PurchInvHeader1."No."),
    //                         InstructionMgt.ShowPostedConfirmationMessageCode()) then
    //             PAGE.RUN(PAGE::"Posted Purchase Invoice", PurchInvHeader1);
    //     end;
    // end;
    // BC Upgrade BHARDA11 << ------------------------------------------------------

    [Test]
    procedure "PCN014 Display Purchase Order"();
    var
        PurchaseInvList: TestPage "PO Purchase Invoices";
        Vendor: Record Vendor;
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        PurchBlanketOrdersList: TestPage "Blanket Purchase Orders";
        PurchBlanketOrdeRLine: Record "Purchase Line";
        ItemCharge: Record "Item Charge";
        PurchHdr: Record "Purchase Header";
        Location: Record Location;
        StoreConsumptionDate: Date;
        StorePONumber: Text;
        PurchOrdersList: TestPage "Purchase Order List";
        InterfaceLogHeader: Record "Interface Log Header INT";
        TestDate: Date;
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchBlanketOrder: Record "Purchase Header";
        BlanketPurchOrder: Code[20];
        Item: Record Item;
    begin
        //HEI.16>>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PCN014', COMPANYNAME, DATABASE::Vendor);
        Vendor.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PCN014', COMPANYNAME, DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PCN014', COMPANYNAME, DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PCN014', COMPANYNAME, DATABASE::"Purchase Header");
        PurchHdr.GET(PurchHdr."Document Type"::"Blanket Order", UnitTestingValues.Value);


        //PurchaseOrder.OPENVIEW;
        //PurchaseOrder.FILTER.SETFILTER("No.",UnitTestingValues.Value);
        PurchHdr.SETRANGE("No.", UnitTestingValues.Value);
        IF PurchHdr.FINDFIRST THEN
            BlanketPurchOrder := PurchHdr."Blanket Order No. FND";
        PurchaseOrder.OPENVIEW;
        PurchaseOrder.FILTER.SETFILTER("No.", PurchHdr."No.");
        PurchBlanketOrder.RESET;
        PurchBlanketOrder.SETRANGE("No.", BlanketPurchOrder);
        IF PurchBlanketOrder.FINDFIRST THEN BEGIN
            PurchaseOrder."Buy-from Vendor No.".ASSERTEQUALS(PurchBlanketOrder."Buy-from Vendor No.");
            PurchaseOrder."Purchaser Code".ASSERTEQUALS(PurchBlanketOrder."Purchaser Code");
            GeneralLedgerSetup.GET;
            IF PurchBlanketOrder."Currency Code" <> GeneralLedgerSetup."LCY Code" THEN
                PurchaseOrder."Currency Code".ASSERTEQUALS(PurchBlanketOrder."Currency Code");
            PurchaseOrder."Payment Terms Code".ASSERTEQUALS(PurchBlanketOrder."Payment Terms Code");
            //PurchaseOrder."Shipment Method Code".ASSERTEQUALS(PurchBlanketOrder."Shipment Method");

            //BC UPGRADE KUMARR78 >> DIT Variable Removed. // BC Upgrade BHARDA11 >> --Uncomment and change fields
            PurchaseOrder."SRM Contract No.".ASSERTEQUALS(PurchBlanketOrder."SRM Contract No. FND");
            PurchaseOrder."SRM Contract Name".ASSERTEQUALS(PurchBlanketOrder."SRM Contract Type FND");
            PurchaseOrder."SRM Contract Type".ASSERTEQUALS(PurchBlanketOrder."SRM Contract Type FND");
            PurchaseOrder."Valid From".ASSERTEQUALS(PurchBlanketOrder."Valid From FND");
            PurchaseOrder."Valid To".ASSERTEQUALS(PurchBlanketOrder."Valid To FND");
            PurchaseOrder."Shipment Method Location".ASSERTEQUALS(PurchBlanketOrder."Shipment Method Location FND");
            //BC UPGRADE KUMARR78 << DIT Variable Removed. // BC Upgrade BHARDA11 << --Uncomment and change fields

            PurchaseOrder.EDIT.INVOKE;
            PurchaseOrder."Vendor Shipment No.".SETVALUE('PCN014');
            PurchBlanketOrdeRLine.SETRANGE("Document No.", PurchBlanketOrder."No.");
            PurchBlanketOrdeRLine.SETRANGE("Document Type", PurchBlanketOrder."Document Type");
            IF PurchBlanketOrdeRLine.FINDFIRST THEN BEGIN
                PurchaseOrder.PurchLines.Description.ASSERTEQUALS(PurchBlanketOrdeRLine.Description);
                PurchaseOrder.PurchLines.Type.ASSERTEQUALS(PurchBlanketOrdeRLine.Type);
                PurchaseOrder.PurchLines."Unit of Measure".ASSERTEQUALS(PurchBlanketOrdeRLine."Unit of Measure");
                PurchaseOrder.PurchLines."Shortcut Dimension 2 Code".ASSERTEQUALS(PurchBlanketOrdeRLine."Shortcut Dimension 2 Code");
            END;
        END;

        PurchaseOrder.OK.INVOKE;
        //HEI.16<<
    end;

    [Test]
    [HandlerFunctions('ApprovalCommentPageHandler')]
    procedure "PTP040 Obsolete invoice"();
    var
        PurchaseInvList: TestPage "NPO Purchase Invoices";
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
        NPOPurchaseInvoice: TestPage "NPO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        DocAmount: Decimal;
        VATAmount: Decimal;
        DueDate: Text;
        BankAccount: Text;
        PostedPurchInvHdr: Record "Purch. Inv. Header";
        StorePostedInvNo: Code[20];
        PostedPurchInv: TestPage "Posted Purchase Invoice";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        PurchHeader: Record "Purchase Header";
        PONPOEXPPurchInvArchs: TestPage "PO/NPO/EXP Purch. Inv. Archs.";
        PurchCommentSheet: TestPage "Purch. Comment Sheet";
    begin
        //HEI.16>>
        UnitTestingValues.Reset();
        //UnitTestingValues.GET('PTP012',COMPANYNAME,DATABASE::Vendor);//HEI.20
        UnitTestingValues.Get('PTP040', CompanyName, Database::Vendor);//HEI.20
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        //UnitTestingValues.GET('PTP012',COMPANYNAME,DATABASE::"G/L Account");//HEI.20
        UnitTestingValues.Get('PTP040', CompanyName, Database::"G/L Account");//HEI.20
        GLAccount.Get(UnitTestingValues.Value);

        NPOPurchaseInvoice.OPENNEW;
        NPOPurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");

        NPOPurchaseInvoice."Vendor Invoice No.".SETVALUE('StP PTP040');
        PurchInvNo := NPOPurchaseInvoice."No.".VALUE;

        NPOPurchaseInvoice.PurchLines.NPOType.SETVALUE(Type::"G/L Account");
        NPOPurchaseInvoice.PurchLines."No.".SETVALUE(GLAccount."No.");
        NPOPurchaseInvoice.PurchLines.Quantity.SETVALUE(1);
        NPOPurchaseInvoice.PurchLines."Direct Unit Cost".SETVALUE(100);

        DocAmount := 0;
        VATAmount := 0;
        PurchLn.Reset();
        PurchLn.SetRange("Document Type", PurchLn."Document Type"::Invoice);
        PurchLn.SetRange("Document No.", PurchInvNo);
        if PurchLn.FindSet() then
            repeat
                DocAmount += PurchLn."Amount Including VAT";
                VATAmount += (PurchLn."Amount Including VAT" - PurchLn.Amount);
            until PurchLn.Next() = 0;

        //BC UPGRADE KUMARR78 >> DIT Variable Removed.
        // NPOPurchaseInvoice."Doc. Amount Incl. VAT".SETVALUE(DocAmount);
        // NPOPurchaseInvoice."Doc. Amount VAT".SETVALUE(VATAmount);
        //BC UPGRADE KUMARR78 << DIT Variable Removed.

        if PurchaseHeader.Get(PurchaseHeader."Document Type"::Invoice, PurchInvNo) then
            PurchaseHeader.AddLink('D:\smriti\Script\TestScript.pdf', 'TestLinkPTP040');

        NPOPurchaseInvoice.Comment.INVOKE;
        //Hei.20>>
        PurchCommentSheet.OpenEdit();
        PurchCommentSheet.Filter.SetFilter("No.", PurchInvNo);
        PurchCommentSheet.Filter.SetFilter("Document Type", 'Invoice');
        PurchCommentSheet.Comment.SetValue('Test delete comment');
        PurchCommentSheet.OK.Invoke();
        //HEI.20<<
        //Delete trigger is not enabled for Test Pages. So record will be deleted from the table
        PurchHeader.SetRange(PurchHeader."No.", PurchInvNo);
        if PurchHeader.FindFirst() then
            PurchHeader.Delete(true);



        //HEI.16<<
    end;

    [PageHandler]
    procedure CommentPageHandler(var PurchCommentSheet: TestPage "Purch. Comment Sheet");
    begin
        //HEI.16>>
        PurchCommentSheet.Comment.SetValue('Test delete comment');
        PurchCommentSheet.OK.Invoke();
        //HEI.16<<
    end;

    //BC UPGRADE KUMARR78 >> Blocking due to cross dependency and no Usage Need clearification.
    // [RequestPageHandler]
    // procedure CheckPrintReportHandler(var CheckSL: TestRequestPage "Check SL");
    // begin
    //     //HEI.16
    // end;
    //BC UPGRADE KUMARR78 << Blocking due to cross dependency and no Usage Need clearification. 

    [RequestPageHandler]
    procedure SuggestVenPayment_RequestPageHandler(var SuggestVendorPayment: TestRequestPage "Suggest Vendor Payments");
    var
        Customer: Record Customer;
    begin
        //HEI.16>>
        SuggestVendorPayment.LastPaymentDate.SetValue(Today);
        SuggestVendorPayment.PostingDate.SetValue(Today);
        // SuggestVendorPayment.Control55001.SETVALUE(TODAY);//BC UPGRADE KUMARR78 CONF (ExecutionDate)
        SuggestVendorPayment.StartingDocumentNo.SetValue('Test001');
        //SuggestVendorPayment.VendorLedgerEntriesFilter.SETFILTER(SuggestVendorPayment.VendorLedgerEntriesFilter."Document No.",InvNo);
        SuggestVendorPayment.OK.Invoke();
        //HEI.16<<
    end;

    [Test]
    // [HandlerFunctions('SuggestVenPayment_RequestPageHandler,CheckPrintReportHandler')]//BC UPGRADE KUMARR78 Removing Handler as it was not in Use.
    [HandlerFunctions('SuggestVenPayment_RequestPageHandler')] //BC UPGRADE KUMARR78++

    procedure "PTP074 Execute Payment Cheques"();
    var
        PurchaseInvList: TestPage "PO Purchase Invoices";
        Vendor: Record Vendor;
        Item: Record Item;
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        GenJnlAccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        PayJnlTree: TestPage "Payment Journal Tree CBN";
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        VendorRec: Record Vendor;
        PayTreeGenJnl: Record "Gen. Journal Line";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        gGenJnlBatches: Record "Gen. Journal Batch";
    begin
        DimensionRestrictionCheck;//HEI.95
        //HEI.16>>
        VendLedgEntry.Reset();
        VendLedgEntry.SetRange("Document Type", VendLedgEntry."Document Type"::Invoice);
        VendLedgEntry.SetRange(Open, true);
        if VendLedgEntry.FindFirst() then begin
            InvNo := VendLedgEntry."Document No.";
        end;
        //ERROR('Invoice: %1',InvNo);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP074', CompanyName, Database::Vendor);
        VendorRec.Get(UnitTestingValues.Value);
        Clear(GenJnlAccType);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP074', CompanyName, Database::"Gen. Journal Batch");
        gGenJnlBatches.Get(UnitTestingValues.Value, UnitTestingValues."Value 2");

        PayJnlTree.OpenEdit();//Abhay
        PayJnlTree.CurrentJnlBatchName.SetValue(gGenJnlBatches.Name);
        PayJnlTree.SuggestVendorPayments.Invoke();
        //ERROR('Vendor No. is %1',PayJnlTree."Account No.".VALUE);


        PayTreeGenJnl.Reset();
        //lGenJnl.SETRANGE("Document Type",PayJnlTree."Document Type");
        PayTreeGenJnl.SetRange("Document No.", PayJnlTree."Document No.".Value);
        //IF ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(lGenJnl) THEN BEGIN
        /*IF ApprovalsMgmt.IsGeneralJournalLineApprovalsWorkflowEnabled(PayTreeGenJnl) THEN BEGIN
          PayJnlTree.SendApprovalRequestJournalBatch.INVOKE;
          ApprovalEntries.TRAP;
          PayJnlTree.Approvals.INVOKE;
        END;
        */
        //PurchaseHeader.GET(PurchaseHeader."Document Type"::Order,PurchaseOrder."No.".VALUE);
        if ApprovalsMgmt.IsGeneralJournalLineApprovalsWorkflowEnabled(PayTreeGenJnl) then begin
            PayJnlTree.SendApprovalRequestJournalBatch.Invoke();
            ApprovalEntries.Trap();
            PayJnlTree.Approvals.Invoke();


            UserSetup.Get(ApprovalEntries."Approver ID".Value);
            UserSetup.Substitute := UserId;
            UserSetup."Approval Administrator" := true;
            UserSetup.Modify();

            //Update Approval Limit for USERID
            UserSetup2.Get(UserId);
            if not UserSetup2."Unlimited Purchase Approval" or not UserSetup2."Unlimited Request Approval" then begin
                UserSetup2."Unlimited Purchase Approval" := true;
                UserSetup2."Unlimited Request Approval" := true;
                //UserSetup2."Approval Administrator":=TRUE;
                UserSetup2.Modify();
            end;

            //Delegate Approval Request
            // ApprovalEntries.Action35.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
            ApprovalEntries."&Delegate".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

            //Approve Approval Entry
            PayJnlTree.Approve.Invoke();
        end;



        PayJnlTree.PrintCheck.Invoke();
        PayJnlTree.Post.Invoke();
        //HEI.16<<

    end;

    [PageHandler]
    procedure ApprovalCommentPageHandler(var ApprovalComments: TestPage "Approval Comments");
    begin
        //HEI.16>>
        //PurchCommentSheet.Comment.SETVALUE('Test delete comment');
        ApprovalComments.OK.Invoke();
        //HEI.16<<
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler,MessageHandler')]
    procedure PCN008_CancelPurchaseOrder();
    var
        Vendor: Record Vendor;
        Item: Record Item;
        Location: Record Location;
        ReasonCode_Purchase: Record "Reason Code_Purchase FND";
        GeneralLedgerSetup: Record "General Ledger Setup";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchaseOrder: TestPage "Purchase Order";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Workflow: Record Workflow;
    begin
        //HEI.15>>
        //Logon to Heilite with the right user ID and password.
        //Open the previously created PO.
        //1. On the upper ribon, in the 'Home' tab, click on 'Re-Open'.
        //2. Populate a 'Purchase Reason Code' on the header (General tab)
        //3. Click on the Archive button on the ribbon above.
        //4. Release PO again. Finally click on 'Delete' to delete the PO.
        //Pop-up message appears: 'Delete
        //POXXXXXXXX · [supplier name]?': 'Yes or No'.
        //Click on 'Yes'
        //Close application.
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN008', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN008', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN008', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN008', CompanyName, Database::"Reason Code_Purchase FND");
        ReasonCode_Purchase.Get(UnitTestingValues.Value);
        //Step 1: Logon to Heilite

        //Create a PO
        //PurchaseOrderList.OPENNEW;
        PurchaseOrder.OpenNew();
        //PurchaseOrder.NEW;
        PurchaseOrder."No.".AssistEdit();
        PurchaseOrder."Buy-from Vendor No.".SetValue(Vendor."No.");
        PurchaseOrder."Vendor Invoice No.".SetValue('StP Unit Test PCN008');
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseOrder."Location Code".SetValue(Location.Code);
        //HEI.51<<
        PnPSetup.Get();
        if PnPSetup."Requester ID Mandatory FND" then //BC UPGRADE KUMARR78 Adding Semicolon(;) to handle the Condition.
            PurchaseOrder."Requester ID".SETVALUE(USERID);//BC UPGRADE KUMARR78 DIT Field Removed. // BC Upgrade BHARDA11 -- remove semicoln

        PurchaseOrder.PurchLines.New();
        PurchaseOrder.PurchLines.Type.SetValue(Type::Item);
        PurchaseOrder.PurchLines."No.".SetValue(Item."No.");
        PurchaseOrder.PurchLines."Location Code".SetValue(Location.Code);
        PurchaseOrder.PurchLines.Quantity.SetValue(1);
        //PurchaseOrder.PurchLines.Dimensions.INVOKE;
        //HEI.29>>
        //Approval Process
        // PurchaseHeader.GET(PurchaseHeader."Document Type"::Order,PurchaseOrder."No.".VALUE);
        // IF ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) THEN BEGIN
        //  PurchaseOrder.SendApprovalRequest.INVOKE;
        //  ApprovalEntries.TRAP;
        //  PurchaseOrder.Approvals.INVOKE;
        //  UserSetup.GET(ApprovalEntries."Approver ID".VALUE);
        //  UserSetup.Substitute := USERID;
        //  UserSetup."Approval Administrator":=TRUE;
        //  UserSetup.MODIFY;
        //
        //  //Update Approval Limit for USERID
        //  UserSetup2.GET(USERID);
        //  IF NOT UserSetup2."Unlimited Purchase Approval" OR NOT UserSetup2."Unlimited Request Approval" THEN BEGIN
        //    UserSetup2."Unlimited Purchase Approval" := TRUE;
        //    UserSetup2."Unlimited Request Approval" := TRUE;
        //    UserSetup2.MODIFY;
        //  END;
        //
        //  //Delegate Approval Request
        //  ApprovalEntries.Action35.INVOKE;
        //
        //  //Approve Approval Entry
        //  PurchaseOrder.Approve.INVOKE;
        // END ELSE
        //  PurchaseOrder.Release.INVOKE;
        //
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release

        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            //IF Workflow.FINDSET THEN
            //REPEAT
            //Workflow.Enabled := FALSE;
            //Workflow.MODIFY;
            //UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;
        PurchaseOrder.Release.Invoke();
        //HEI.29<<

        PurchaseOrder.Reopen.Invoke();
        PurchaseOrder."Purch. Reason Code".SetValue(ReasonCode_Purchase.Code);
        //HEI.29>>
        if UserSetup.Get(UserId) then begin
            UserSetup."Allow Delete/Arc PO/Return FND" := true;
            UserSetup.Modify();
        end;
        //HEI.29<<
        PurchaseOrder."Archive Document".Invoke();
        //HEI.15<<
    end;//Abhay

    [Test]
    [HandlerFunctions('ConfirmationHandler')]
    procedure PCN009_CreateReturnorderfromBlanketOrder();
    var
        UnitTestingValue: Record "Unit Testing Value FND";
        BlanketPurchaseOrder: TestPage "Blanket Purchase Order";
        BlanketPurchaseOrderSubform: TestPage "Blanket Purchase Order Subform";
        ReasonCode_Purchase: Record "Reason Code_Purchase FND";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        PurchaseLine: Record "Purchase Line";
        StorePONumber: Code[20];
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        WhseRcptPONo: Code[20];
        BinContent: Record "Bin Content";
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        Location: Record Location;
        Bin: Record Bin;
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        //HEI.15>>
        //Open existing  Blanket order
        //In the 'Lines tab', Fill-in quantity to be returned in the field 'Qty. to Return'*
        //*: prerequisite is that quantities have been received already from the contract (Logistics can create the 'Warehouse Receipt').
        //And you cannot return more than what you have received.
        //In the 'Call-off' tab, fill-in:
        //the Consumption Date (= date of the initial call-off for
        //the goods to be returned, so that the system will pick-up the correct price from the Blanket Order/ Contract)
        //the Purchase Reason Code (= the reason why you need to return the goods)
        //On the upper ribbon, in the Home tab, click on 'Make Return Order'
        //Click on 'Yes'
        //Click on 'OK' and close the Blanket PO (press Esc)

        //HEI.29>>
        //Copied from PCN003
        //RT_PCN003_CreateCallOffFromBlanketOrder;
        //HEI.34>>
        // UnitTestingValue.GET('STP_PCN003',COMPANYNAME,DATABASE::"Purchase Header");
        // UnitTestingValues.RESET;
        // UnitTestingValues.GET('PCN009',COMPANYNAME,DATABASE::"Lot No. Information");
        // LotNoFilter := UnitTestingValues.Value;
        //
        // PurchaseHeader.GET(PurchaseHeader."Document Type"::"Blanket Order",UnitTestingValue.Value);
        // BlanketPurchaseOrder.OPENEDIT;
        // BlanketPurchaseOrder.FILTER.SETFILTER("No.",PurchaseHeader."No.");
        // BlanketPurchaseOrder.Reopen.INVOKE;
        // //Step #2 update the line
        // UnitTestingValue.SETRANGE("Test Script Code",'STP_PCN003');
        // UnitTestingValue.SETRANGE("Table ID",39);
        // IF UnitTestingValue.FINDSET THEN BEGIN
        //  REPEAT
        //    BlanketPurchaseOrder.PurchLines.FILTER.SETFILTER("No.",UnitTestingValue."Value 3");
        //    PurchasesPayablesSetup.GET;
        //    IF (PurchasesPayablesSetup."Excluded Incoterms"='DAP|DDP') AND (PurchasesPayablesSetup."Location Code for Import Proc."<>'') THEN BEGIN
        //      IF NOT (BlanketPurchaseOrder."Shipment Method Code".VALUE IN['DAP','DDP']) THEN BEGIN
        //        BlanketPurchaseOrder.PurchLines."Location Code".SETVALUE('');
        //        BlanketPurchaseOrder.PurchLines."Consumption Location Code".SETVALUE(PurchasesPayablesSetup."Location Code for Import Proc.");
        //      END;
        //    END;
        //    BlanketPurchaseOrder.PurchLines."Qty. to Receive".SETVALUE(UnitTestingValue.Value);
        //  UNTIL UnitTestingValue.NEXT=0;
        // END;
        // PurchaseLine.RESET;
        // PurchaseLine.SETRANGE("Document Type",PurchaseLine."Document Type"::"Blanket Order");
        // PurchaseLine.SETRANGE("Document No.",BlanketPurchaseOrder."No.".VALUE);
        // PurchaseLine.SETFILTER("Qty. to Receive",'<>%1',0);
        // PurchaseLine.SETFILTER("No.",'<>%1',BlanketPurchaseOrder.PurchLines."No.".VALUE);
        // IF PurchaseLine.FINDSET THEN BEGIN
        //  REPEAT
        //    PurchaseLine.VALIDATE("Qty. to Receive",0);
        //    PurchaseLine.MODIFY(TRUE);
        //  UNTIL PurchaseLine.NEXT=0;
        // END;
        // //Step #3 Make order
        // BlanketPurchaseOrder.MakeOrder.INVOKE;
        // //Copied from PCN003
        //
        // //New Lines start for completing PO post which created from Make Order of BO
        // StorePONumber := COPYSTR(storemessage,7,11);
        // BlanketPurchaseOrder.CLOSE;
        //
        // PurchaseOrder.OPENEDIT;
        // PurchaseOrder.FILTER.SETFILTER("No.",StorePONumber);
        //
        // IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order,StorePONumber) THEN
        //  IF PurchaseHeaderAdditional.GET(PurchaseHeader."Document Type",StorePONumber) THEN BEGIN
        //    IF PurchaseHeaderAdditional."Import Identifier" THEN BEGIN
        //      Location.RESET;
        //      Location.SETFILTER(Code,'<>%1',PurchasesPayablesSetup."Location Code for Import Proc.");
        //      IF Location.FINDFIRST THEN
        //        PurchaseOrder."Location Code".SETVALUE(Location.Code);
        //      PurchaseOrder."Expctd Physical Delvry Date(Imp)".SETVALUE(TODAY);
        //    END;
        //  END;
        //
        // //Approval Process
        // //Disable Workflows before Release
        // PurchaseHeader.GET(PurchaseHeader."Document Type"::Order,PurchaseOrder."No.".VALUE);
        // IF ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) THEN BEGIN
        //  Workflow.SETRANGE(Enabled,TRUE);
        //  IF Workflow.FINDSET THEN
        //    REPEAT
        //      Workflow.Enabled := FALSE;
        //      Workflow.MODIFY;
        //    UNTIL Workflow.NEXT = 0;
        // END;
        //
        // PurchaseOrder.Release.INVOKE;
        //
        // PurchaseOrder.Action149.INVOKE;
        // WarehouseReceipt.OPENVIEW;
        // WarehouseReceipt.FILTER.SETFILTER("Source No.",PurchaseOrder."No.".VALUE);
        //
        // //Store the PO No in warehouse receipt
        // WhseRcptPONo := WarehouseReceipt."Source No.".VALUE;
        //
        // //
        // WarehouseReceiptLine.RESET;
        // WarehouseReceiptLine.SETRANGE("Source No.",PurchaseOrder."No.".VALUE);
        // WarehouseReceiptLine.SETRANGE("Item No.",PurchaseOrder.PurchLines."No.".VALUE);
        // IF WarehouseReceiptLine.FINDFIRST THEN BEGIN
        //  IF (WarehouseReceiptLine."Location Code" = '') THEN BEGIN
        //    BinContent.RESET;
        //    BinContent.SETRANGE("Item No.",WarehouseReceipt.WhseReceiptLines."Item No.".VALUE);
        //    BinContent.SETRANGE("Location Code",WarehouseReceiptLine."Location Code");
        //    BinContent.SETFILTER(Quantity,'<>%1',0);
        //    BinContent.SETRANGE(Default,TRUE);
        //    IF BinContent.FINDFIRST THEN BEGIN
        //      IF BinContent.FINDFIRST THEN BEGIN
        //        WarehouseReceiptLine.RESET;
        //        WarehouseReceiptLine.SETRANGE("No.",WarehouseReceipt."No.".VALUE);
        //        WarehouseReceiptLine.SETRANGE("Item No.",WarehouseReceipt.WhseReceiptLines."Item No.".VALUE);
        //        IF WarehouseReceiptLine.FINDFIRST THEN BEGIN
        //          WarehouseReceiptLine.VALIDATE("Zone Code",BinContent."Zone Code");
        //          WarehouseReceiptLine.VALIDATE("Bin Code",BinContent."Bin Code");
        //          WarehouseReceiptLine.MODIFY;
        //        END;
        //      END;
        //    END;
        //  END ELSE BEGIN
        //    IF Location.GET(WarehouseReceiptLine."Location Code") THEN
        //      IF Bin.GET(Location.Code,Location."Receipt Bin Code") THEN BEGIN
        //        WarehouseReceiptLine.RESET;
        //        WarehouseReceiptLine.SETRANGE("No.",WarehouseReceipt."No.".VALUE);
        //        WarehouseReceiptLine.SETRANGE("Item No.",WarehouseReceipt.WhseReceiptLines."Item No.".VALUE);
        //        IF WarehouseReceiptLine.FINDFIRST THEN BEGIN
        //          WarehouseReceiptLine.VALIDATE("Zone Code",Bin."Zone Code");
        //          WarehouseReceiptLine.VALIDATE("Bin Code",Bin.Code);
        //          WarehouseReceiptLine.MODIFY;
        //        END;
        //      END ELSE BEGIN
        //        BinContent.RESET;
        //        BinContent.SETRANGE("Item No.",WarehouseReceipt.WhseReceiptLines."Item No.".VALUE);
        //        BinContent.SETRANGE("Location Code",WarehouseReceiptLine."Location Code");
        //        BinContent.SETFILTER(Quantity,'<>%1',0);
        //        BinContent.SETRANGE(Default,TRUE);
        //        IF BinContent.FINDFIRST THEN BEGIN
        //          IF BinContent.FINDFIRST THEN BEGIN
        //            WarehouseReceiptLine.RESET;
        //            WarehouseReceiptLine.SETRANGE("No.",WarehouseReceipt."No.".VALUE);
        //            WarehouseReceiptLine.SETRANGE("Item No.",WarehouseReceipt.WhseReceiptLines."Item No.".VALUE);
        //            IF WarehouseReceiptLine.FINDFIRST THEN BEGIN
        //              WarehouseReceiptLine.VALIDATE("Zone Code",BinContent."Zone Code");
        //              WarehouseReceiptLine.VALIDATE("Bin Code",BinContent."Bin Code");
        //              WarehouseReceiptLine.MODIFY;
        //            END;
        //          END;
        //        END;
        //      END;
        //  END;
        // END;
        // //
        //
        // //Select Item Tracking Code
        // WarehouseReceipt.WhseReceiptLines.ItemTrackingLines.INVOKE;
        //
        // //Post The warehouse receipt
        // WarehouseReceipt."Post Receipt".INVOKE;
        // PurchaseOrder.OK.INVOKE;
        // //New Lines start for completing PO post which created from Make Order of BO
        // //HEI.29<<
        //
        // //HEI.29>>
        // IF UnitTestingValue.GET('STP_PCN003',COMPANYNAME,DATABASE::"Purchase Header") THEN;
        // PurchaseHeader.GET(PurchaseHeader."Document Type"::"Blanket Order",UnitTestingValue.Value);
        // BlanketPurchaseOrder.OPENEDIT;
        // BlanketPurchaseOrder.FILTER.SETFILTER("No.",PurchaseHeader."No.");//HEI.19
        // // IF UnitTestingValue.GET('STP_PCN003',COMPANYNAME,DATABASE::"Purchase Header") THEN;
        // // BlanketPurchaseOrder.OPENEDIT;
        // // BlanketPurchaseOrder.FILTER.SETFILTER("No.",UnitTestingValue.Value);
        // //HEI.29<<
        //
        // BlanketPurchaseOrder.Reopen.INVOKE;
        // UnitTestingValues.RESET;
        // UnitTestingValues.GET('PCN009',COMPANYNAME,DATABASE::"Reason Code_Purchase");
        // ReasonCode_Purchase.GET(UnitTestingValues.Value);
        //
        // BlanketPurchaseOrder."Purch. Reason Code".SETVALUE(UnitTestingValues.Value);
        //
        // UnitTestingValue.SETRANGE("Test Script Code",'STP_PCN003');
        // UnitTestingValue.SETRANGE("Table ID",39);
        // IF UnitTestingValue.FINDSET THEN REPEAT
        //  BlanketPurchaseOrder.PurchLines.FILTER.SETFILTER("No.",UnitTestingValue."Value 3");
        //  BlanketPurchaseOrder.PurchLines."Qty. to Return".SETVALUE(UnitTestingValue.Value);
        // UNTIL UnitTestingValue.NEXT=0;
        //
        // BlanketPurchaseOrder.MakeReturnOrder.INVOKE;
        // //HEI.15<<

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN009', CompanyName, Database::"Lot No. Information");
        LotNoFilter := UnitTestingValues.Value;

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN009', CompanyName, Database::"Reason Code_Purchase FND");
        ReasonCode_Purchase.Get(UnitTestingValues.Value);

        UnitTestingValue.Reset();
        UnitTestingValue.Get('PCN009', CompanyName, Database::"Purchase Header");

        PurchaseHeader.Get(PurchaseHeader."Document Type"::"Blanket Order", UnitTestingValue.Value);//Abhay
        BlanketPurchaseOrder.OpenEdit();
        BlanketPurchaseOrder.Filter.SetFilter("No.", PurchaseHeader."No.");
        BlanketPurchaseOrder."Purch. Reason Code".SetValue(ReasonCode_Purchase.Code);

        UnitTestingValue.SetRange("Test Script Code", 'PCN009');
        UnitTestingValue.SetRange("Table ID", 39);
        if UnitTestingValue.FindSet() then
            repeat
                BlanketPurchaseOrder.PurchLines1.Filter.SetFilter("No.", UnitTestingValue."Value 3");
                //HEI.111>>
                //HEI.110>>
                BlanketPurchaseOrder.PurchLines1.Filter.SetFilter("Line No.", UnitTestingValue."Value 2");
                //HEI.110<<
                //HEI.111<<
                BlanketPurchaseOrder.PurchLines1."Qty. to Return".SETVALUE(UnitTestingValue.Value);
            until UnitTestingValue.Next() = 0;
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::"Blanket Order");
        PurchaseLine.SetRange("Document No.", BlanketPurchaseOrder."No.".Value);
        PurchaseLine.SetFilter("Qty. to Return FND", '<>%1', 0);
        PurchaseLine.SetFilter("No.", '<>%1', BlanketPurchaseOrder.PurchLines1."No.".Value);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET as its being depreceted
        //if PurchaseLine.FindSet(false, false) then
        if PurchaseLine.FindSet(false) then
            // BC Upgrade MISHRS14 <<

            repeat
                PurchaseLine.Validate("Qty. to Return FND", 0);
                PurchaseLine.Modify(true);
            until PurchaseLine.Next() = 0;

        BlanketPurchaseOrder.MakeReturnOrder.Invoke();
        //HEI.34<<
    end;

    [Test]
    // [HandlerFunctions('ConfirmationHandler')]// BC Upgrade BHARDA11 -- Remove because there is no use of CionfirmationHandler 

    procedure PCN006_UpdateSpotPOorVLcalloff();
    var
        UnitTestingValues: Record "Unit Testing Value FND";
        Vendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        Location: Record Location;
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseOrder: TestPage "Purchase Order";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemCharge: Record "Item Charge";
        ReasonCode_Purchase: Record "Reason Code_Purchase FND";
        PurchaseLine: Record "Purchase Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Workflow: Record Workflow;
    begin
        //HEI.15>>
        //Search for the 'Purchase Order' report from the right hand side
        //top search bar, and click on 'Purchase Order' report name.
        //Use the search field to Search for the PO with the PO number, then click on the PO number.
        //On the upper ribbon, in the 'Actions' tab, click on 'Re-Open'
        //In the Header / GENERAL tab, fill-in the 'Purchase reason code' by selecting a value from the drop down.
        //Change the Purchase Order 'Quantity' and/or 'Direct Unit Cost Excl. VAT'.
        //Send the PO for approval

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN006', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN006', CompanyName, Database::"Item Charge");
        ItemCharge.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN006', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN006', CompanyName, Database::"Reason Code_Purchase FND");
        ReasonCode_Purchase.Get(UnitTestingValues.Value);

        //Step-3 created PO for charge item
        PurchaseOrder.OpenNew();
        PurchaseOrder."Buy-from Vendor No.".SetValue(Vendor."No.");
        PurchaseOrder."Vendor Invoice No.".SetValue('StP Unit Test PCN006');
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseOrder."Location Code".SetValue(Location.Code);
        //HEI.51<<
        // PurchaseOrder."Requester ID".SETVALUE(USERID);//BC UPGRADE KUMARR78 DIT Field Removed.
        PurchaseOrder.PurchLines.Type.SetValue(Type::"Charge (Item)");
        PurchaseOrder.PurchLines."No.".SetValue(ItemCharge."No.");
        PurchaseOrder.PurchLines.Quantity.SetValue(1);
        //HEI.31>>
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("Document No.", PurchaseOrder."No.".Value);
        PurchaseLine.SetRange("No.", PurchaseOrder.PurchLines."No.".Value);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Qty. to Receive", 1);
            PurchaseLine.Modify();
        end;
        //PurchaseOrder.PurchLines."Qty. to Receive".SETVALUE(1);
        //HEI.31<<
        PurchaseOrder.PurchLines."Direct Unit Cost".SetValue(100);
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            //IF Workflow.FINDSET THEN
            //REPEAT
            //Workflow.Enabled := FALSE;
            //Workflow.MODIFY;
            //UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;
        PurchaseOrder.Release.Invoke();

        //Start the actual steps of PCN006
        PurchaseOrder.Reopen.Invoke();

        PurchaseOrder."Purch. Reason Code".SetValue(ReasonCode_Purchase.Code);
        PurchaseOrder.PurchLines.Quantity.SetValue(2);
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            //IF Workflow.FINDSET THEN
            //REPEAT
            //Workflow.Enabled := FALSE;
            //Workflow.MODIFY;
            //UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;
        PurchaseOrder.Release.Invoke();
        //HEI.15<<
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,MessageHandler_PCN027')]
    procedure PCN025_UpdatePxQreturncalloff();
    var
        Vendor: Record Vendor;
        Item: Record Item;
        VendorBankAccount: Record "Vendor Bank Account";
        Location: Record Location;
        DimensionValue: Record "Dimension Value";
        GeneralLedgerSetup: Record "General Ledger Setup";
        ReasonCode_Purchase: Record "Reason Code_Purchase FND";
        PurchaseOrder: TestPage "Purchase Order";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        PurchHdr: Record "Purchase Header";
        PurchBlanketOrders: TestPage "Blanket Purchase Order";
        StoreBlanketOrderNo: Code[20];
        BOLineType: Text;
        BONo: Code[20];
        BOQty: Text;
        StoreSRMContractNo: Code[20];
        StoreSRMContractLnNo: Code[10];
        StorePONumber: Text;
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        PurchaseLine: Record "Purchase Line";
        BlanketPurchaseOrder: TestPage "Blanket Purchase Order";
        UnitTestingValues1: Record "Unit Testing Value FND";
        PurchaseHeader1: Record "Purchase Header";
        PurchaseLine1: Record "Purchase Line";
        Item1: Record Item;
        Workflow: Record Workflow;

        // HEI.115 >>
        PurchaseLineL1 : Record "Purchase Line";
        PurchaseLineL2 : Record "Purchase Line";
        ConsumpLocationCodeL : Code[10];
        // HEI.115 <<
    begin
        DimensionRestrictionCheck;//HEI.95
        //HEI.15>>
        //Search Purchase Order from right hand side top search bar.
        //Search the PO with the PO number from HeiLte from Advanced Filter.
        //On the upper ribbon, on the 'Home' tab or 'Action' tab, click on 'Reopen'
        //In the 'General' tab, fill-in a 'Purchase Reason Code' by selecting one of the values from the drop down =>
        //it is the reason why you want to change the PO.
        //Change the Purchase Order line(s) quantity and delivery date
        //If the Price in the SRM contract has been updated and/or you want to update the PO price, then on the upper ribbon in
        //'Home' tab, click on 'Get Blanket Order Price', then click 'Yes'
        //On the upper ribbon, in the 'Home' tab or in the 'Action' tab, click on 'Release'

        //HEI.29>>
        // UnitTestingValues.RESET;
        // UnitTestingValues.GET('PCN025',COMPANYNAME,DATABASE::Vendor);
        // Vendor.GET(UnitTestingValues.Value);
        //
        // UnitTestingValues.RESET;
        // UnitTestingValues.GET('PCN025',COMPANYNAME,DATABASE::Location);
        // Location.GET(UnitTestingValues.Value);
        //
        // UnitTestingValues.RESET;
        // UnitTestingValues.GET('PCN025',COMPANYNAME,DATABASE::"Purchase Header");
        // PurchHdr.GET(PurchHdr."Document Type"::"Blanket Order",UnitTestingValues.Value);
        //
        // UnitTestingValues.RESET;
        // UnitTestingValues.GET('PCN025',COMPANYNAME,DATABASE::"Reason Code_Purchase");
        // ReasonCode_Purchase.GET(UnitTestingValues.Value);
        //
        // // PurchBlanketOrdersList.OPENVIEW;
        // // PurchBlanketOrdersList.FILTER.SETFILTER("No.",PurchHdr."No.");
        // PurchBlanketOrders.OPENEDIT;
        // PurchBlanketOrders.FILTER.SETFILTER("No.",PurchHdr."No.");
        // PurchBlanketOrders.Reopen.INVOKE;
        // StoreBlanketOrderNo := PurchBlanketOrders."No.".VALUE;
        //
        // PurchBlanketOrders.PurchLines."Qty. to Receive".SETVALUE(1);
        // PurchBlanketOrders.PurchLines."Direct Unit Cost".SETVALUE(100);
        // IF (PurchBlanketOrders.PurchLines."Consumption Location Code".VALUE = '') THEN
        //  PurchBlanketOrders.PurchLines."Consumption Location Code".SETVALUE(Location.Code);
        // PurchBlanketOrders."Consumption Date".SETVALUE(PurchBlanketOrders.PurchLines."Valid To".VALUE);
        //
        // StoreSRMContractNo := PurchBlanketOrders.PurchLines."SRM Contract No.".VALUE;
        // IF PurchBlanketOrders.PurchLines."SRM Contract Line No.".VISIBLE THEN
        //  StoreSRMContractLnNo := PurchBlanketOrders.PurchLines."SRM Contract Line No.".VALUE;
        //
        // PurchBlanketOrders.MakeOrder.INVOKE;


        UnitTestingValue.Get('STP_PCN003', CompanyName, Database::"Purchase Header");
        UnitTestingValues.Reset();

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN025', CompanyName, Database::"Reason Code_Purchase FND");
        ReasonCode_Purchase.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN025', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN025', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);
        //HEI.110>>
        UnitTestingValues1.Reset();
        PurchaseHeader1.Reset();
        UnitTestingValues1.Get('PCN025', CompanyName, Database::"Purchase Header");
        PurchaseHeader1.Get(PurchaseHeader."Document Type"::"Blanket Order", UnitTestingValues1.Value);
        //HEI.111>>
        //PurchaseLine1.SETRANGE("Document No.",PurchaseHeader."No.");
        PurchaseLine1.SetRange("Document No.", PurchaseHeader1."No.");
        //HEI.111<<
        PurchaseLine1.SetRange(Type, Type::Item);

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET as its being depreceted
        //if PurchaseLine1.FindSet(false, false) then
        if PurchaseLine1.FindSet(false) then
            // BC Upgrade MISHRS14 <<

            //HEI.111>>
            // BC Upgrade MISHRS14 >>
            // Removed false from FINDSET as its being depreceted
            //if PurchaseLine1.FindSet(false, false) then begin
            if PurchaseLine1.FindSet(false) then begin
                // BC Upgrade MISHRS14 <<

                repeat
                    //HEI.111<<
                    Item1.Reset();
                    Item1.SetRange("No.", PurchaseLine1."No.");
                    if Item1.FindFirst() then begin
                        Item1.Get(PurchaseLine1."No.");
                        if Item1.Blocked then
                            Item1.Blocked := false;
                        Item1.Modify(true);
                    end;
                //HEI.111>>
                until PurchaseLine1.Next() = 0;
                //HEI.111<<
            end;
        //IF UnitTestingValue.Value = '' THEN
        //EXIT;
        //HEI.110<<

        PurchaseHeader.Get(PurchaseHeader."Document Type"::"Blanket Order", UnitTestingValue.Value);
        //HEI.103>>
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::"Blanket Order");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        if PurchaseLine.FindSet(true) then
            repeat
                if PurchaseLine."Initial Quantity FND" < PurchaseLine."Quantity Received" + PurchaseLine."Qty. to Receive" then begin
                    PurchaseLine."Initial Quantity FND" += PurchaseLine."Quantity Received" + PurchaseLine."Qty. to Receive";
                    PurchaseLine.Modify();
                end;
            until PurchaseLine.Next() = 0;
        //HEI.103<<
        BlanketPurchaseOrder.OpenEdit();
        BlanketPurchaseOrder.Filter.SetFilter("No.", PurchaseHeader."No.");
        BlanketPurchaseOrder.Reopen.Invoke();
        //Step #2 update the line
        UnitTestingValue.SetRange("Test Script Code", 'STP_PCN003');
        UnitTestingValue.SetRange("Table ID", 39);
        if UnitTestingValue.FindSet() then
            repeat
                BlanketPurchaseOrder.PurchLines1.Filter.SetFilter("No.", UnitTestingValue."Value 3");
                BlanketPurchaseOrder.PurchLines1.Filter.SetFilter("Block Line Ordering FND", ' ');//HEI.59
                PurchasesPayablesSetup.Get();
                //HEI.75>>
                //IF (PurchasesPayablesSetup."Excluded Incoterms"='DAP|DDP') AND (PurchasesPayablesSetup."Location Code for Import Proc."<>'') THEN BEGIN
                // IF (PurchasesPayablesSetup."Excluded Incoterms" IN['DAP|DDP','DDP|DAP']) AND (PurchasesPayablesSetup."Location Code for Import Proc."<>'') THEN BEGIN //HEI.107
                if (PurchasesPayablesSetup."Excluded Incoterms FND" <> '') and (PurchasesPayablesSetup."Location Code Imp Proc. FND" <> '') then begin //HEI.107
                                                                                                                                                       //HEI.75<<
                                                                                                                                                       //IF NOT (BlanketPurchaseOrder."Shipment Method Code".VALUE IN['DAP','DDP']) THEN BEGIN //HEI.107
                    if StrPos(PurchasesPayablesSetup."Excluded Incoterms FND", BlanketPurchaseOrder."Shipment Method Code".Value) = 0 then begin //HEI.107
                        BlanketPurchaseOrder.PurchLines1."Location Code".SetValue('');
                        BlanketPurchaseOrder.PurchLines1."Consumption Location Code".SETVALUE(PurchasesPayablesSetup."Location Code Imp Proc. FND");
                    end;
                end;
                BlanketPurchaseOrder.PurchLines1."Qty. to Receive".SetValue(UnitTestingValue.Value);
            until UnitTestingValue.Next() = 0;

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::"Blanket Order");
        PurchaseLine.SetRange("Document No.", BlanketPurchaseOrder."No.".Value);
        //PurchaseLine.SETFILTER("Qty. to Receive",'<>%1',0);//HEI.57
        //PurchaseLine.SETFILTER("No.",'<>%1',BlanketPurchaseOrder.PurchLines."No.".VALUE);//HEI.57
        if PurchaseLine.FindSet() then begin
            repeat
                PurchaseLine."Qty. to Receive" := 0;//HEI.59
                                                    //    PurchaseLine."Consumption Location Code":=PurchasesPayablesSetup."Location Code for Import Proc.";//HEI.58//HEI.59
                                                    //    PurchaseLine.VALIDATE("Qty. to Receive",0);//HEI.59
                PurchaseLine.Modify(true);
            until PurchaseLine.Next() = 0;
        end;
        //HEI.56>>
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::"Blanket Order");
        PurchaseLine.SetRange("Document No.", BlanketPurchaseOrder."No.".Value);
        PurchaseLine.SetFilter("No.", '%1', BlanketPurchaseOrder.PurchLines1."No.".Value);
        PurchaseLine.SetRange("Block Line Ordering FND", PurchaseLine."Block Line Ordering FND"::" ");//HEI.59
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Qty. to Receive", PurchaseLine."Qty. to Receive" + 1);
            PurchaseLine.Modify(true);
        end;
        //HEI.56<<
        StoreSRMContractNo := BlanketPurchaseOrder.PurchLines1."SRM Contract No.".VALUE;
        if BlanketPurchaseOrder.PurchLines1."SRM Contract Line No.".VISIBLE then
            StoreSRMContractLnNo := BlanketPurchaseOrder.PurchLines1."SRM Contract Line No.".VALUE;

        // BC Upgrade MISHRS14 >>
        //HEI.115>>
        PurchaseLineL1.SETCURRENTKEY("Document Type","Document No.","Consumption Location Code FND");
        PurchaseLineL1.SETRANGE("Document Type",PurchaseLineL1."Document Type"::"Blanket Order");
        PurchaseLineL1.SETRANGE("Document No.",PurchaseHeader."No.");
        PurchaseLineL1.SETRANGE("Consumption Location Code FND",'');
        IF PurchaseLineL1.FINDSET(TRUE) THEN BEGIN
        PurchaseLineL2.SETCURRENTKEY("Document Type","Document No.","Consumption Location Code FND");
        PurchaseLineL2.SETRANGE("Document Type",PurchaseLineL2."Document Type"::"Blanket Order");
        PurchaseLineL2.SETRANGE("Document No.",PurchaseHeader."No.");
        PurchaseLineL2.SETFILTER("Consumption Location Code FND",'<>%1','');
        IF PurchaseLineL2.FINDFIRST THEN
            ConsumpLocationCodeL := PurchaseLineL2."Consumption Location Code FND";
        REPEAT
            PurchaseLineL1."Consumption Location Code FND" := ConsumpLocationCodeL;
            PurchaseLineL1.MODIFY(FALSE);
        UNTIL PurchaseLineL1.NEXT = 0;
        END;
        //HEI.115<<  
        // BC Upgrade MISHRS14 <<  

        //Step #3 Make order
        BlanketPurchaseOrder.MakeOrder.Invoke();
        //HEI.29<<

        StorePONumber := CopyStr(storemessage, 7, 11);
        BlanketPurchaseOrder.Close();

        PurchaseOrder.OpenEdit();
        PurchaseOrder.Filter.SetFilter("No.", StorePONumber);
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseOrder."Location Code".SetValue(Location.Code);
        //HEI.51<<
        //HEI.29>>
        if PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, StorePONumber) then
            if PurchaseHeaderAdditional.Get(PurchaseHeader."Document Type", StorePONumber) then begin
                if PurchaseHeaderAdditional."Import Identifier" then begin
                    Location.Reset();
                    Location.SetFilter(Code, '<>%1', PurchasesPayablesSetup."Location Code Imp Proc. FND");
                    Location.SetRange("Use As In-Transit", false); //HEI.96
                    if Location.FindFirst() then
                        PurchaseOrder."Location Code".SetValue(Location.Code);
                    PurchaseOrder."Expctd Physical Delvry Date(Imp)".SetValue(Today);
                end;
            end;
        //HEI.29<<
        //HEI.49>>

        //BC UPGRADE KUMARR78 >> DIT Field Removed.
        // PurchasesPayablesSetup.GET;
        // IF PurchasesPayablesSetup."Requester ID Mandatory" THEN
        //     PurchaseOrder."Requester ID".SETVALUE(USERID);
        //BC UPGRADE KUMARR78 << DIT Field Removed.

        //HEI.49<<
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            //IF Workflow.FINDSET THEN
            //REPEAT
            //Workflow.Enabled := FALSE;
            //Workflow.MODIFY;
            //UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;
        PurchaseOrder.Release.Invoke();

        PurchaseOrder.Reopen.Invoke();
        PurchaseOrder."Purch. Reason Code".SetValue(ReasonCode_Purchase.Code);
        PurchaseOrder.PurchLines.Quantity.SetValue(2);
        PurchaseOrder.GetBlanketOrderPrice.Invoke();
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            //IF Workflow.FINDSET THEN
            //REPEAT
            //Workflow.Enabled := FALSE;
            //Workflow.MODIFY;
            //UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;

        PurchaseOrder.Release.Invoke();
        //HEI.15<<
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler,PurchCreditMemoModalPageHandler,DimSetEntriesModalPageHandlerPTP133')]
    procedure PTP024_NPO_InvoiceReversal_Correction();
    var
        PurchaseInvList: TestPage "NPO Purchase Invoices";
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
        PurchaseInvoice: TestPage "NPO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        PurchInvNo: Code[20];
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        DocAmount: Decimal;
        VATAmount: Decimal;
        PurchLn: Record "Purchase Line";
        PostedPurchInvHdr: Record "Purch. Inv. Header";
        PostedPurchInv: TestPage "Posted Purchase Invoice";
        PurchaseCreditMemo: TestPage "Purchase Credit Memo";
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseLine: Record "Purchase Line";
        EBFErrText: Label 'Are you sure you want to post combination of account %1 with dimension %2';
        DimensionValue: Record "Dimension Value";
        DimensionValueMVMT: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        Location: Record Location;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DefaultDimension: Record "Default Dimension";
        Workflow: Record Workflow;
    begin
        DimensionRestrictionCheck; //HEI.95
        //HEI.15>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP024', CompanyName, Database::Vendor);
        if UnitTestingValues.Value <> '' then
            Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP024', CompanyName, Database::"G/L Account");
        if UnitTestingValues.Value <> '' then //HEI.95
            GLAccount.Get(UnitTestingValues.Value);
        //HEI.53>>
        if DefaultDimension.Get(15, GLAccount."No.", 'TRD_PART') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;

        //BC UPGRADE KUMARR78 >> DIT Variable Removed.
        // IF PurchasesPayablesSetup.GET THEN
        //     IF PurchasesPayablesSetup."Show Posted Document No." THEN BEGIN
        //         PurchasesPayablesSetup."Show Posted Document No." := FALSE;
        //         PurchasesPayablesSetup.MODIFY;
        //     END;
        //BC UPGRADE KUMARR78 << DIT Variable Removed.

        //HEI.53<<
        //HEI.55>>
        if DefaultDimension.Get(15, GLAccount."No.", 'BRAND') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;
        //HEI.55<<
        //HEI.29>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP024', CompanyName, Database::"Dimension Value");
        GeneralLedgerSetup.Get();
        if UnitTestingValues.Value <> '' then
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);
        Clear(EBFWarnConf);
        EBFWarnConf := StrSubstNo(EBFErrText, GLAccount."No.", DimensionValue.Code);

        //HEI.29<<
        //HEI.50>>
        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue.Code);
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();
        //HEI.50<<
        //PurchaseInvList.OPENNEW;//HEI.29
        PurchaseInvoice.OPENNEW;
        //PurchaseInvoice.NEW;//HEI.29
        PurchaseInvoice."No.".ASSISTEDIT;
        PurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");
        PurchaseInvoice."Vendor Invoice No.".SETVALUE('StP PTP024');
        PurchInvNo := PurchaseInvoice."No.".VALUE;
        //HEI.51>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP024', CompanyName, Database::Location);
        if UnitTestingValues.Value <> '' then//HEI.95
            Location.Get(UnitTestingValues.Value);
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseInvoice."Location Code".SETVALUE(Location.Code);
        //HEI.51<<
        PurchaseInvoice.PurchLines.NEW;
        PurchaseInvoice.PurchLines.NPOType.SETVALUE(Type::"G/L Account");
        PurchaseInvoice.PurchLines."No.".SETVALUE(GLAccount."No.");
        PurchaseInvoice.PurchLines.Quantity.SETVALUE(1);
        PurchaseInvoice.PurchLines."Direct Unit Cost".SETVALUE(100);

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Invoice);
        PurchaseLine.SETRANGE("Document No.", PurchaseInvoice."No.".VALUE);
        PurchaseLine.SETRANGE("No.", PurchaseInvoice.PurchLines."No.".VALUE);
        if PurchaseLine.FindSet() then
            repeat
                PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
                PurchaseLine.Modify(true);
            until PurchaseLine.Next() = 0;

        //HEI.29>>
        // DocAmount := 0;
        // VATAmount := 0;
        // PurchLn.RESET;
        // PurchLn.SETRANGE("Document Type",PurchLn."Document Type"::Invoice);
        // PurchLn.SETRANGE("Document No.",PurchInvNo);
        // IF PurchLn.FINDSET THEN REPEAT
        // DocAmount += PurchLn."Amount Including VAT";
        // VATAmount += (PurchLn."Amount Including VAT" - PurchLn.Amount);
        // UNTIL PurchLn.NEXT = 0;
        // PurchaseInvoice."Doc. Amount Incl. VAT".SETVALUE(DocAmount);
        // PurchaseInvoice."Doc. Amount VAT".SETVALUE(VATAmount);

        //BC UPGRADE KUMARR78 >> DIT Variable Removed.
        PurchaseInvoice."Doc. Amount Incl. VAT IBM".SETVALUE(PurchaseInvoice.PurchLines."Total Amount Incl. VAT".VALUE); // BC Upgrade BHARDA11 
        PurchaseInvoice."Doc. Amount VAT IBM".SETVALUE(PurchaseInvoice.PurchLines."Total VAT Amount".VALUE); // BC Upgrade BHARDA11 
        //BC UPGRADE KUMARR78 << DIT Variable Removed.

        //HEI.29<<
        //HEI.48>>
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, PurchaseInvoice."No.".VALUE);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.Reset();
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            //IF Workflow.FINDSET THEN
            //REPEAT
            //Workflow.Enabled := FALSE;
            //Workflow.MODIFY;
            //UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;
        //HEI.51>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP024', CompanyName, Database::"Dimension Value");
        //HEI.51<<
        GeneralLedgerSetup.Get();
        //HEI.95>>
        //IF UnitTestingValues."Value" <> '' THEN
        if UnitTestingValues."Value 2" <> '' then
            //HEI.95<<
            DimensionValueMVMT.Get(GeneralLedgerSetup."Shortcut Dimension 3 Code", UnitTestingValues."Value 2");
        Clear(MVMTDimension);
        MVMTDimension := UnitTestingValues."Value 2";
        PurchaseInvoice.Dimensions.INVOKE;
        //HEI.48<<
        PurchaseInvoice.Post.INVOKE;

        PostedPurchInvHdr.SetRange("Pre-Assigned No.", PurchInvNo);
        if PostedPurchInvHdr.FindFirst() then
            StorePostedInvNo := PostedPurchInvHdr."No.";

        PostedPurchInv.OpenView();
        PostedPurchInv.Filter.SetFilter("No.", StorePostedInvNo);

        PostedPurchInv.CreateCreditMemo.Invoke();

        // PurchaseCreditMemo.OPENNEW;
        // PurchaseCreditMemo.FILTER.SETFILTER("Applies-to Doc. No.",StorePostedInvNo);
        // PurchaseCreditMemo."Vendor Cr. Memo No.".SETVALUE('PTP024');
        // StoreCreditMemoNo := PurchaseCreditMemo."No.".VALUE;

        //HEI.29>>
        // DocAmount := 0;
        // VATAmount := 0;
        // PurchLn.RESET;
        // PurchLn.SETRANGE("Document Type",PurchLn."Document Type"::"Credit Memo");
        // PurchLn.SETRANGE("Document No.",StoreCreditMemoNo);
        // IF PurchLn.FINDSET THEN REPEAT
        //  DocAmount += PurchLn."Amount Including VAT";
        //  VATAmount += (PurchLn."Amount Including VAT" - PurchLn.Amount);
        // UNTIL PurchLn.NEXT = 0;
        // PurchaseCreditMemo."Doc. Amount Incl. VAT".SETVALUE(DocAmount);
        // PurchaseCreditMemo."Doc. Amount VAT".SETVALUE(VATAmount);
        //PurchaseCreditMemo."Doc. Amount Incl. VAT".SETVALUE(PurchaseCreditMemo.PurchLines."Total Amount Incl. VAT".VALUE);
        //PurchaseCreditMemo."Doc. Amount VAT".SETVALUE(PurchaseCreditMemo.PurchLines."Total VAT Amount".VALUE);
        //HEI.29<<
        //PurchaseCreditMemo.Post.INVOKE;
        //HEI.15<<
    end;

    [Test]
    [HandlerFunctions('ChangePaymentStatusPPIHandler')]
    procedure "PTP155-RejectInvoice_noworkflow"();
    var
        PostedPurchaseInvoices: TestPage "Posted Purchase Invoices";
        PostedPurchaseInvoice: TestPage "Posted Purchase Invoice";
        PaymentStatusPPI: TestPage "Change Payment Status PPI";
        DocNo: Code[20];
    begin
        PaymentStatusToSet := PaymentStatusToSet::"Payment Rejected";
        PostedPurchaseInvoices.OpenView();
        PostedPurchaseInvoices.Filter.SetFilter("Payment Status FND", 'Pending Review');
        PostedPurchaseInvoices.First();
        DocNo := PostedPurchaseInvoices."No.".Value;

        PostedPurchaseInvoice.OpenEdit();
        PostedPurchaseInvoice.Filter.SetFilter("No.", DocNo);
        PostedPurchaseInvoice.First();

        PaymentStatusPPI.Trap();
        PostedPurchaseInvoice."Payment Status".DrillDown();

        PostedPurchaseInvoice.Close();
        PostedPurchaseInvoices.Close();
    end;


    [Test]
    procedure "PTP156-ApproveCreditNote_noworkflow"();
    var
        PostedPurchaseCreditMemo: TestPage "Posted Purchase Credit Memo";
    begin
        //HEI.17  >>
        PostedPurchaseCreditMemo.OpenEdit();
        PostedPurchaseCreditMemo.Filter.SetFilter("Payment Status FND", 'Pending Review');
        PostedPurchaseCreditMemo."Payment Status".SETVALUE('Payment Approved');
        PostedPurchaseCreditMemo.Close();
        //HEI.17  <<
    end;

    [Test]
    // [HandlerFunctions('ConfirmationHandler,CreditMemoPagehandler')]
    [HandlerFunctions('ConfirmationHandler')] // BC Upgrade BHARDA11
    procedure "PTP132-ReverseRejectedInvoice"();
    var
        PurchaseInvList: TestPage "NPO Purchase Invoices";
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
        PurchaseInvoice: TestPage "NPO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        DueDate: Text;
        PostedPurchInvHdr: Record "Purch. Inv. Header";
        StorePostedInvNo: Code[20];
        PostedPurchInv: TestPage "Posted Purchase Invoice";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        PurchaseCreditMemo: TestPage "Purchase Credit Memo";
        PostedPurchaseCreditMemos: TestPage "Posted Purchase Credit Memos";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PostedCrNo: Code[20];
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseLine: Record "Purchase Line";
        DimensionValueMVMT: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        Location: Record Location;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DefaultDimension: Record "Default Dimension";
        NoSeriesLine: Record "No. Series Line";
        Workflow: Record Workflow;
        Purchase_Line: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
        CorrectPostedPurchInvoice: Codeunit "Correct Posted Purch. Invoice";
    begin
        DimensionRestrictionCheck; //HEI.95
        //HEI.18>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP132', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP132', CompanyName, Database::"G/L Account");
        GLAccount.Get(UnitTestingValues.Value);
        //HEI.53>>
        if DefaultDimension.Get(15, GLAccount."No.", 'TRD_PART') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;

        //BC UPGRADE KUMARR78 >> DIT Variable Removed.
        // IF PurchasesPayablesSetup.GET THEN
        //     IF PurchasesPayablesSetup."Show Posted Document No." THEN BEGIN
        //         PurchasesPayablesSetup."Show Posted Document No." := FALSE;
        //         PurchasesPayablesSetup.MODIFY;
        //     END;
        //BC UPGRADE KUMARR78 << DIT Variable Removed.

        //HEI.53<<
        //HEI.59>>
        NoSeriesLine.Reset();
        NoSeriesLine.SetRange("Series Code", PurchasesPayablesSetup."Posted Credit Memo Nos.");
        NoSeriesLine.SetFilter("Last Date Used", '>%1', Today);
        if NoSeriesLine.FindFirst() then begin
            NoSeriesLine."Last Date Used" := Today;
            NoSeriesLine.Modify();
        end;
        //HEI.59<<
        //HEI.55>>
        if DefaultDimension.Get(15, GLAccount."No.", 'BRAND') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;
        //HEI.55<<
        PurchaseInvoice.OPENNEW;
        PurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");
        Clear(PurchInvNo);
        PurchaseInvoice."Vendor Invoice No.".SETVALUE('StP PTP132');
        PurchInvNo := PurchaseInvoice."No.".VALUE;
        //HEI.51>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP132', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseInvoice."Location Code".SETVALUE(Location.Code);
        //HEI.51<<
        PurchaseInvoice.PurchLines.NPOType.SETVALUE(Type::"G/L Account");
        PurchaseInvoice.PurchLines."No.".SETVALUE(GLAccount."No.");
        PurchaseInvoice.PurchLines.Quantity.SETVALUE(1);
        PurchaseInvoice.PurchLines."Direct Unit Cost".SETVALUE(100);
        // BC Upgrade BHARDA11 >>
        Purchase_Line.Reset();
        Purchase_Line.SetRange("Document Type", Purchase_Line."Document Type"::Invoice);
        Purchase_Line.SetRange("Document No.", PurchInvNo);
        if Purchase_Line.FindSet() then begin
            Purchase_Line.Validate("Direct Unit Cost", 100);
            Purchase_Line.Modify();
        end;
        // BC Upgrade BHARDA11 <<
        DocAmount := 0;
        VATAmount := 0;
        PurchLn.Reset();
        PurchLn.SetRange("Document Type", PurchLn."Document Type"::Invoice);
        PurchLn.SetRange("Document No.", PurchInvNo);
        if PurchLn.FindSet() then
            repeat
                DocAmount += PurchLn."Amount Including VAT";
                VATAmount += (PurchLn."Amount Including VAT" - PurchLn.Amount);
            until PurchLn.Next() = 0;

        //BC UPGRADE KUMARR78 >> DIT Variable Removed. // BC Upgrade BHARDA11 >>
        PurchaseInvoice."Doc. Amount Incl. VAT IBM".SETVALUE(DocAmount);
        PurchaseInvoice."Doc. Amount VAT IBM".SETVALUE(VATAmount);
        //BC UPGRADE KUMARR78 << DIT Variable Removed.  // BC Upgrade BHARDA11 <<

        //HEI.29>>
        GeneralLedgerSetup.Get();
        //HEI.97>>
        /*UnitTestingValues.RESET;
        UnitTestingValues.GET('PTP132',COMPANYNAME,DATABASE::"Dimension Value");
        IF UnitTestingValues.Value<>'' THEN
          DimensionValue.GET(GeneralLedgerSetup."Shortcut Dimension 2 Code",UnitTestingValues.Value);
          */
        //HEI.97<<
        //HEI.50>>
        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue.Code);
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();
        //HEI.50<<
        //HEI.97>>
        /*PurchaseLine.RESET;
        PurchaseLine.SETRANGE("Document No.",PurchaseInvoice."No.".VALUE);
        PurchaseLine.SETRANGE("Document Type",PurchaseLine."Document Type"::Invoice);
        PurchaseLine.SETRANGE("No.",PurchaseInvoice.PurchLines."No.".VALUE);
        IF PurchaseLine.FINDFIRST THEN BEGIN
          PurchaseLine.VALIDATE("Shortcut Dimension 2 Code",DimensionValue.Code);
          PurchaseLine.MODIFY;
        END;*/
        //HEI.97<<
        //HEI.29<<
        //HEI.48>>
        GeneralLedgerSetup.Get();
        //HEI.97>>
        /*IF UnitTestingValues."Value 2" <> '' THEN //HEI.95
        DimensionValueMVMT.GET(GeneralLedgerSetup."Shortcut Dimension 3 Code",UnitTestingValues."Value 2");
        CLEAR(MVMTDimension);
        MVMTDimension:=UnitTestingValues."Value 2";*/
        //HEI.97<<
        //PurchaseInvoice.Dimensions.INVOKE; //HEI.96
        //HEI.48<<
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, PurchaseInvoice."No.".VALUE);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.Reset();
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            //IF Workflow.FINDSET THEN
            //REPEAT
            //Workflow.Enabled := FALSE;
            //Workflow.MODIFY;
            //UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;
        // PurchaseInvoice.Action120.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseInvoice."Re&lease".INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name

        PurchaseInvoice.Post.INVOKE;
        Clear(StorePostedInvNo);
        PostedPurchInvHdr.SetRange("Pre-Assigned No.", PurchInvNo);
        if PostedPurchInvHdr.FindFirst() then
            StorePostedInvNo := PostedPurchInvHdr."No.";

        PostedPurchInv.OpenView();
        PostedPurchInv.Filter.SetFilter("No.", StorePostedInvNo);
        PostedPurchInv."Payment Status".SETVALUE(paymentstatus::"Payment Rejected");
        if CorrectPostedPurchInvoice.CreateCreditMemoCopyDocument(PostedPurchInvHdr, PurchaseHeader) then begin
        end;
        // PostedPurchInv.CreateCreditMemo.Invoke(); // BC Upgrade BHARDA11
        PurchaseCreditMemo.OpenEdit();
        // PurchaseCreditMemo.Filter.SetFilter("No.", CrNo);
        PurchaseCreditMemo.Filter.SetFilter("No.", PurchaseHeader."No.");
        PurchaseCreditMemo."Vendor Cr. Memo No.".SetValue('StP PTP132');
        //BC UPGRADE ATHUKS01 STP_FDD0007 >>
        PurchaseCreditMemo."Doc. Amount Incl. VAT IBM".SetValue(DocAmount);
        PurchaseCreditMemo."Doc. Amount VAT IBM".SetValue(VATAmount);
        ///BC UPGRADE ATHUKS01 STP_FDD0007 <<
        PurchaseCreditMemo.Post.Invoke();
        Clear(PostedCrNo);
        PurchCrMemoHdr.Reset();
        // PurchCrMemoHdr.SetRange("Pre-Assigned No.", CrNo);
        PurchCrMemoHdr.SetRange("Pre-Assigned No.", PurchaseHeader."No."); // BC UPgrade BHARDA11
        if PurchCrMemoHdr.FindFirst() then
            PostedCrNo := PurchCrMemoHdr."No.";

        PostedPurchaseCreditMemos.OpenView();
        PostedPurchaseCreditMemos.Filter.SetFilter("No.", PostedCrNo);
        PostedPurchaseCreditMemos."Amount Including VAT".AssertEquals(DocAmount);
        PostedPurchaseCreditMemos.Close();
        //HEI.18<<

    end;

    [PageHandler]
    procedure CreditMemoPagehandler(var PurchaseCreditMemo: TestPage "Purchase Credit Memo");
    begin
        //HEI.18>>
        Clear(CrNo);
        CrNo := PurchaseCreditMemo."No.".Value;
        //HEI.18<<
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,DimSetEntriesModalPageHandlerPTP133')]
    procedure PTP027_ProcessLargeInvoice();
    var
        PurchaseInvList: TestPage "NPO Purchase Invoices";
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
        PurchaseInvoice: TestPage "NPO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DueDate: Text;
        BankAccount: Text;
        PostedPurchInvHdr: Record "Purch. Inv. Header";
        StorePostedInvNo: Code[20];
        PostedPurchInv: TestPage "Posted Purchase Invoice";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        GeneralLedgerSetup: Record "General Ledger Setup";
        lPurchHdr: Record "Purchase Header";
        FileMgt: Codeunit "File Management";
        PurchaseLine: Record "Purchase Line";
        DimensionValue: Record "Dimension Value";
        DimensionValueMVMT: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        Location: Record Location;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DefaultDimension: Record "Default Dimension";
        Workflow: Record Workflow;
        TempBlob: Codeunit "Temp Blob";
        DocumentAttachment: Record "Document Attachment";
        OutStream: OutStream;
        InStream: InStream;
    begin
        DimensionRestrictionCheck; //HEI.95
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP027', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP027', CompanyName, Database::"G/L Account");
        GLAccount.Get(UnitTestingValues.Value);
        //HEI.53>>
        if DefaultDimension.Get(15, GLAccount."No.", 'TRD_PART') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;

        //BC UPGRADE KUMARR78 >> DIT Variable Removed.
        // IF PurchasesPayablesSetup.GET THEN
        //     IF PurchasesPayablesSetup."Show Posted Document No." THEN BEGIN
        //         PurchasesPayablesSetup."Show Posted Document No." := FALSE;
        //         PurchasesPayablesSetup.MODIFY;
        //     END;
        //BC UPGRADE KUMARR78 << DIT Variable Removed.

        //HEI.53<<
        //HEI.55>>
        if DefaultDimension.Get(15, GLAccount."No.", 'BRAND') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;
        //HEI.55<<
        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP027', CompanyName, Database::"Dimension Value");
        if UnitTestingValues.Value <> '' then
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);
        //HEI.50>>
        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue.Code);
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();
        //HEI.50<<

        PurchaseInvoice.OPENNEW;
        PurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");

        PurchaseInvoice."Vendor Invoice No.".SETVALUE('StP PTP027');
        PurchInvNo := PurchaseInvoice."No.".VALUE;
        //HEI.51>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP027', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseInvoice."Location Code".SETVALUE(Location.Code);
        //HEI.51<<
        PurchaseInvoice.PurchLines.NPOType.SETVALUE(Type::"G/L Account");
        PurchaseInvoice.PurchLines."No.".SETVALUE(GLAccount."No.");
        PurchaseInvoice.PurchLines.Quantity.SETVALUE(1);
        PurchaseInvoice.PurchLines."Direct Unit Cost".SETVALUE(100);
        //HEI.29>>
        //PurchaseInvoice.PurchLines."Shortcut Dimension 2 Code".SETVALUE(DimensionValue.Code);
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Invoice);
        PurchaseLine.SETRANGE("Document No.", PurchaseInvoice."No.".VALUE);
        PurchaseLine.SETRANGE("No.", PurchaseInvoice.PurchLines."No.".VALUE);
        if PurchaseLine.FindSet() then
            repeat
                PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
                PurchaseLine.Modify(true);
            until PurchaseLine.Next() = 0;
        //HEI.29<<
        if (PurchaseInvoice."Vendor Bank Account".VALUE <> '') then
            BankAccount := PurchaseInvoice."Vendor Bank Account".VALUE
        else
            BankAccount := '';
        PurchaseInvoice."Vendor Bank Account".ASSERTEQUALS(BankAccount);
        //HEI.48>>
        GeneralLedgerSetup.Get();
        //HEI.51>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP027', CompanyName, Database::"Dimension Value");
        //HEI.51<<
        //HEI.95>>
        //IF UnitTestingValues."Value" <> '' THEN
        if UnitTestingValues."Value 2" <> '' then
            //HEI.95<<
            DimensionValueMVMT.Get(GeneralLedgerSetup."Shortcut Dimension 3 Code", UnitTestingValues."Value 2");
        Clear(MVMTDimension);
        MVMTDimension := UnitTestingValues."Value 2";
        PurchaseInvoice.Dimensions.INVOKE;
        //HEI.48<<

        //BC UPGRADE KUMARR78 >> DIT Variable Removed.
        PurchaseInvoice."Doc. Amount Incl. VAT IBM".SETVALUE(PurchaseInvoice.PurchLines."Total Amount Incl. VAT".VALUE);
        PurchaseInvoice."Doc. Amount VAT IBM".SETVALUE(PurchaseInvoice.PurchLines."Total VAT Amount".VALUE);

        //Attachment
        IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, PurchaseInvoice."No.".VALUE) THEN begin
            TempBlob.CreateOutStream(OutStream);
            OutStream.WriteText('Test Attachment Content');

            TempBlob.CreateInStream(InStream);

            DocumentAttachment.Init();
            DocumentAttachment.Validate("Table ID", Database::"Purchase Header");
            DocumentAttachment.Validate("No.", PurchaseHeader."No.");
            DocumentAttachment.Validate("File Name", 'TestLinkPTP027.pdf');
            DocumentAttachment.Validate("File Extension", 'pdf');

            DocumentAttachment."Document Reference ID".ImportStream(InStream, 'TestLinkPTP027.pdf');
            DocumentAttachment.Insert(true);
        end;
        // PurchaseHeader.ADDLINK(FileMgt.ServerTempFileName('pdf'), 'TestLinkPTP027'); // BC Upgrade BHARDA11
        //BC UPGRADE KUMARR78 << DIT Variable Removed.

        //Approval Process
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, PurchaseInvoice."No.".VALUE);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            //IF Workflow.FINDSET THEN
            //REPEAT
            //Workflow.Enabled := FALSE;
            //Workflow.MODIFY;
            //UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;
        // PurchaseInvoice.Action120.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseInvoice."Re&lease".INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name

        PurchaseInvoice.Post.INVOKE;

        PostedPurchInvHdr.SetRange("Pre-Assigned No.", PurchInvNo);
        if PostedPurchInvHdr.FindFirst() then
            StorePostedInvNo := PostedPurchInvHdr."No.";

        PostedPurchInv.OpenView();
        PostedPurchInv.Filter.SetFilter("No.", StorePostedInvNo);
        PostedPurchInv."Payment Status".ASSERTEQUALS(paymentstatus::"Pending Review");
    end;

    [Test]
    procedure PTP028_AttachDocAfterPosting();
    var
        VendLedgEntList: TestPage "Vendor Ledger Entries";
        Vendor: Record Vendor;
        FileMgt: Codeunit "File Management";

        //BC UPGRADE KUMARR78 >> Variable Adding
        TempBlob: Codeunit "Temp Blob";
        DocumentAttachment: Record "Document Attachment";
        OutStream: OutStream;
        InStream: InStream;
    //BC UPGRADE KUMARR78 << Variable Adding

    begin
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP028', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);


        VendLedgEntList.OpenView();
        VendLedgEntList.Filter.SetFilter("Vendor No.", Vendor."No.");

        //VendLedgEntry.
        //Attachment
        //HEI.29>>
        //IF VendLedgEntry.GET(VendLedgEntList."Entry No.") THEN

        //BC UPGRADE KUMARR78 >> Blocking to Replace and Make this for Saas Based
        //
        // IF VendLedgEntry.GET(VendLedgEntList."Entry No.".VALUE) THEN
        //     //HEI.29<<
        //     VendLedgEntry.ADDLINK(FileMgt.ServerTempFileName('pdf'), 'TestLinkPTP028');
        //
        //BC UPGRADE KUMARR78 << Blocking to Replace and Make this for Saas Based


        //BC UPGRADE KUMARR78 >> Adding Saas Version in Place of File Managment.
        if VendLedgEntry.Get(VendLedgEntList."Entry No.".Value) then begin
            TempBlob.CreateOutStream(OutStream);
            OutStream.WriteText('Test Attachment Content');
            TempBlob.CreateInStream(InStream);
            DocumentAttachment.Init();
            DocumentAttachment.Validate("Table ID", Database::"Vendor Ledger Entry");
            DocumentAttachment.Validate("No.", Format(VendLedgEntry."Entry No."));
            DocumentAttachment.Validate("File Name", 'TestLinkPTP028.pdf');
            DocumentAttachment.Validate("File Extension", 'pdf');
            DocumentAttachment."Document Reference ID".ImportStream(InStream, 'TestLinkPTP028.pdf');
            DocumentAttachment.Insert(true);
        end;
        //BC UPGRADE KUMARR78 << Adding Saas Version in Place of File Managment.

    end;

    [Test]
    [HandlerFunctions('ApprovalCommentPageHandler')]
    procedure PTP041_ObsoleteCN();
    var
        NPOPurchCrMemoList: TestPage "NPO Purchase Credit Memos";
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
        NPOPurchCrMemo: TestPage "NPO Purchase Credit Memo";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        DueDate: Text;
        BankAccount: Text;
        PostedPurchInvHdr: Record "Purch. Inv. Header";
        StorePostedInvNo: Code[20];
        PostedPurchInv: TestPage "Posted Purchase Invoice";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        GeneralLedgerSetup: Record "General Ledger Setup";
        lPurchHdr: Record "Purchase Header";
        NPOPurchCrMemoArchive: TestPage "NPO Purch. Cr. Memo Archive";
        FileMgt: Codeunit "File Management";
        PurchCommentSheet: TestPage "Purch. Comment Sheet";
        //BC UPGRADE KUMARR78>> Adding Variables
        TempBlob: Codeunit "Temp Blob";
        DocumentAttachment: Record "Document Attachment";
        OutStream: OutStream;
        InStream: InStream;
    //BC UPGRADE KUMARR78<< Adding Variables
    begin

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP041', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP041', CompanyName, Database::"G/L Account");
        GLAccount.Get(UnitTestingValues.Value);


        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP041', CompanyName, Database::"Dimension Value");
        if UnitTestingValues.Value <> '' then
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);


        NPOPurchCrMemo.OPENNEW;
        NPOPurchCrMemo."Buy-from Vendor Name".SETVALUE(Vendor."No.");

        NPOPurchCrMemo."Vendor Cr. Memo No.".SETVALUE('PTP041');
        PurchCrMemoNo := NPOPurchCrMemo."No.".VALUE;

        ///BC UPGRADE ATHUKS01 STP_FDD0007 >>
        NPOPurchCrMemo."Doc. Amount Incl. VAT IBM".SETVALUE(NPOPurchCrMemo.PurchLines."Total Amount Incl. VAT".VALUE);
        NPOPurchCrMemo."Doc. Amount VAT IBM".SETVALUE(NPOPurchCrMemo.PurchLines."Total VAT Amount".VALUE);
        ///BC UPGRADE ATHUKS01 STP_FDD0007 <<
        //Attachment

        //BC UPGRADE KUMARR78>> Blocking as Scope of OnPrem.
        // IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, NPOPurchCrMemo."No.".VALUE) THEN
        //     PurchaseHeader.ADDLINK(FileMgt.ServerTempFileName('pdf'), 'TestLinkPTP027');
        //BC UPGRADE KUMARR78<< Blocking as Scope of OnPrem.


        //BC UPGRADE KUMARR78 >> Saas Based Replacement.
        if PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, NPOPurchCrMemo."No.".VALUE) then begin
            TempBlob.CreateOutStream(OutStream);
            OutStream.WriteText('Test Attachment Content');

            TempBlob.CreateInStream(InStream);

            DocumentAttachment.Init();
            DocumentAttachment.Validate("Table ID", Database::"Purchase Header");
            DocumentAttachment.Validate("No.", PurchaseHeader."No.");
            DocumentAttachment.Validate("File Name", 'TestLinkPTP027.pdf');
            DocumentAttachment.Validate("File Extension", 'pdf');

            DocumentAttachment."Document Reference ID".ImportStream(InStream, 'TestLinkPTP027.pdf');
            DocumentAttachment.Insert(true);
        end;
        //BC UPGRADE KUMARR78 << Saas Based Replacement.


        NPOPurchCrMemo.Comment.INVOKE;
        //HEI.29>>
        PurchCommentSheet.OpenEdit();
        PurchCommentSheet.Filter.SetFilter("No.", PurchCrMemoNo);
        PurchCommentSheet.Filter.SetFilter("Document Type", 'Credit Memo');
        PurchCommentSheet.Comment.SetValue('Test delete comment 041');
        PurchCommentSheet.OK.Invoke();
        //HEI.29<<

        //Delete trigger is not enabled for Test Pages. So record will be deleted from the table
        if PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, NPOPurchCrMemo."No.".VALUE) then
            PurchaseHeader.Delete(true);

        NPOPurchCrMemoArchive.OPENVIEW;
        NPOPurchCrMemoArchive.FILTER.SETFILTER("No.", PurchCrMemoNo);
    end;

    [Test]
    [HandlerFunctions('ApprovalCommentPageHandler')]
    procedure PTP042_CheckOnInvoiceNumberAllocatedTwice();
    var
        NPOPurchCrMemoList: TestPage "NPO Purchase Credit Memos";
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
        NPOPurchCrMemo: TestPage "NPO Purchase Credit Memo";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        DueDate: Text;
        BankAccount: Text;
        PostedPurchInvHdr: Record "Purch. Inv. Header";
        StorePostedInvNo: Code[20];
        PostedPurchInv: TestPage "Posted Purchase Invoice";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        GeneralLedgerSetup: Record "General Ledger Setup";
        lPurchHdr: Record "Purchase Header";
        NPOPurchCrMemoArchive: TestPage "NPO Purch. Cr. Memo Archive";
        FileMgt: Codeunit "File Management";
        PurchCommentSheet: TestPage "Purch. Comment Sheet";
        //BC UPGRADE KUMARR78>> Adding Variables
        TempBlob: Codeunit "Temp Blob";
        DocumentAttachment: Record "Document Attachment";
        OutStream: OutStream;
        InStream: InStream;
    //BC UPGRADE KUMARR78<< Adding Variables


    begin

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP041', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP041', CompanyName, Database::"G/L Account");
        GLAccount.Get(UnitTestingValues.Value);


        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP041', CompanyName, Database::"Dimension Value");
        if UnitTestingValues.Value <> '' then
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);


        NPOPurchCrMemo.OPENNEW;
        NPOPurchCrMemo."Buy-from Vendor Name".SETVALUE(Vendor."No.");

        NPOPurchCrMemo."Vendor Cr. Memo No.".SETVALUE('PTP041');
        PurchCrMemoNo := NPOPurchCrMemo."No.".VALUE;

        ///BC UPGRADE ATHUKS01 STP_FDD0007 >> 
        NPOPurchCrMemo."Doc. Amount Incl. VAT IBM".SETVALUE(NPOPurchCrMemo.PurchLines."Total Amount Incl. VAT".VALUE);
        NPOPurchCrMemo."Doc. Amount VAT IBM".SETVALUE(NPOPurchCrMemo.PurchLines."Total VAT Amount".VALUE);
        ///BC UPGRADE ATHUKS01 STP_FDD0007 << 
        //Attachment

        //BC UPGRADE KUMARR78>> Blocking as Scope of OnPrem.
        // IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, NPOPurchCrMemo."No.".VALUE) THEN
        //     PurchaseHeader.ADDLINK(FileMgt.ServerTempFileName('pdf'), 'TestLinkPTP027');
        //BC UPGRADE KUMARR78<< Blocking as Scope of OnPrem.

        //BC UPGRADE KUMARR78 >> Saas Based Replacement.
        if PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, NPOPurchCrMemo."No.".VALUE) then begin
            TempBlob.CreateOutStream(OutStream);
            OutStream.WriteText('Test Attachment Content');

            TempBlob.CreateInStream(InStream);

            DocumentAttachment.Init();
            DocumentAttachment.Validate("Table ID", Database::"Purchase Header");
            DocumentAttachment.Validate("No.", PurchaseHeader."No.");
            DocumentAttachment.Validate("File Name", 'TestLinkPTP027.pdf');
            DocumentAttachment.Validate("File Extension", 'pdf');

            DocumentAttachment."Document Reference ID".ImportStream(InStream, 'TestLinkPTP027.pdf');
            DocumentAttachment.Insert(true);
        end;
        //BC UPGRADE KUMARR78 << Saas Based Replacement.


        NPOPurchCrMemo.Comment.INVOKE;
        //HEI.29>>
        PurchCommentSheet.OpenEdit();
        PurchCommentSheet.Filter.SetFilter("No.", PurchCrMemoNo);
        PurchCommentSheet.Filter.SetFilter("Document Type", 'Credit Memo');
        PurchCommentSheet.Comment.SetValue('Test delete comment 042');
        PurchCommentSheet.OK.Invoke();
        //HEI.29<<

        //Delete trigger is not enabled for Test Pages. So record will be deleted from the table
        if PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, NPOPurchCrMemo."No.".VALUE) then
            PurchaseHeader.Delete(true);

        NPOPurchCrMemoArchive.OPENVIEW;
        NPOPurchCrMemoArchive.FILTER.SETFILTER("No.", PurchCrMemoNo);
    end;

    [ModalPageHandler]
    procedure DimSetEntriesModalPageHandlerPTP133(var EditDimensionSetEntries: TestPage "Edit Dimension Set Entries");
    begin
        //HEI.20>>
        if EditDimensionSetEntries."Dimension Code".value = '' then begin
            EditDimensionSetEntries.New();
            EditDimensionSetEntries."Dimension Code".SetValue('MVMT');
            if MVMTDimension <> '' then//HEI.54
                EditDimensionSetEntries.DimensionValueCode.SetValue(MVMTDimension);
        end;
        EditDimensionSetEntries.OK.Invoke();
        //HEI.20<<
    end;

    [ModalPageHandler]
    procedure DimSetEntriesModalPageHandler0001(var EditDimensionSetEntries: TestPage "Edit Dimension Set Entries");
    begin
        EditDimensionSetEntries.New();
        EditDimensionSetEntries."Dimension Code".SetValue('CCC');
        if MVMTDimension <> '' then//HEI.54
            EditDimensionSetEntries.DimensionValueCode.SetValue(1010000);
        EditDimensionSetEntries.OK.Invoke();
        //HEI.20<<
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler')]
    procedure PTP053_ProcessNPOInvoice_paymentmethod_otherthanBank();
    var
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
        PurchaseInvoice: TestPage "NPO Purchase Invoice";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        DueDate: Text;
        BankAccount: Text;
        PostedPurchInvHdr: Record "Purch. Inv. Header";
        StorePostedInvNo: Code[20];
        PostedPurchInv: TestPage "Posted Purchase Invoice";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        DimensionValue: Record "Dimension Value";
        GeneralLedgerSetup: Record "General Ledger Setup";
        FileMgt: Codeunit "File Management";
        PurchaseLine: Record "Purchase Line";
        EbfCombination: Record "Ebf Combination FND";
        Location: Record Location;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        PurchaseHeader: Record "Purchase Header";
        DefaultDimension: Record "Default Dimension";
        //BC UPGRADE KUMARR78>> Adding Variables
        TempBlob: Codeunit "Temp Blob";
        DocumentAttachment: Record "Document Attachment";
        OutStream: OutStream;
        InStream: InStream;
        Workflow: Record Workflow;
    //BC UPGRADE KUMARR78<< Adding Variables

    begin
        DimensionRestrictionCheck; //HEI.95
        //HEI.23>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP053', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);
        //HEI.52>>
        if Vendor."Payment Method Code" = 'BANK CON' then begin
            Vendor."Payment Method Code" := '';
            Vendor.Modify();
        end;
        //HEI.52<<
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP053', CompanyName, Database::"G/L Account");
        GLAccount.Get(UnitTestingValues.Value);
        //HEI.53>>
        if DefaultDimension.Get(15, GLAccount."No.", 'TRD_PART') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;

        //BC UPGRADE KUMARR78 >> DIT Variable Removed.
        // IF PurchasesPayablesSetup.GET THEN
        //     IF PurchasesPayablesSetup."Show Posted Document No." THEN BEGIN
        //         PurchasesPayablesSetup."Show Posted Document No." := FALSE;
        //         PurchasesPayablesSetup.MODIFY;
        //     END;
        //BC UPGRADE KUMARR78 << DIT Variable Removed.

        //HEI.53<<
        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP053', CompanyName, Database::"Dimension Value");
        if UnitTestingValues.Value <> '' then
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);
        //HEI.50>>
        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue.Code);
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();
        //HEI.50<<
        PurchaseInvoice.OPENNEW;
        PurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");
        //HEI.51>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP053', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseInvoice."Location Code".SETVALUE(Location.Code);
        //HEI.51<<
        //HEI.55>>
        if DefaultDimension.Get(15, GLAccount."No.", 'BRAND') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;
        //HEI.55<<
        PurchaseInvoice."Vendor Invoice No.".SETVALUE('StP PTP053');
        PurchInvNo := PurchaseInvoice."No.".VALUE;

        PurchaseInvoice.PurchLines.NPOType.SETVALUE(Type::"G/L Account");
        PurchaseInvoice.PurchLines."No.".SETVALUE(GLAccount."No.");
        PurchaseInvoice.PurchLines.Quantity.SETVALUE(1);
        //HEI.29>>
        //PurchaseInvoice.PurchLines."Shortcut Dimension 2 Code".SETVALUE(DimensionValue.Code);
        //PurchaseInvoice."Doc. Amount Incl. VAT".SETVALUE(PurchaseInvoice.PurchLines."Total Amount Incl. VAT");
        //PurchaseInvoice."Doc. Amount VAT".SETVALUE(PurchaseInvoice.PurchLines."Total VAT Amount");
        PurchaseLine.Reset();
        PurchaseLine.SETRANGE("Document No.", PurchaseInvoice."No.".VALUE);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Invoice);
        PurchaseLine.SETRANGE("No.", PurchaseInvoice.PurchLines."No.".VALUE);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
            PurchaseLine.Modify();
        end;

        //BC UPGRADE KUMARR78 >> DIT Variable Removed.
        // PurchaseInvoice."Doc. Amount Incl. VAT".SETVALUE(PurchaseInvoice.PurchLines."Total Amount Incl. VAT".VALUE);
        // PurchaseInvoice."Doc. Amount VAT".SETVALUE(PurchaseInvoice.PurchLines."Total VAT Amount".VALUE);
        //BC UPGRADE KUMARR78 << DIT Variable Removed.

        //HEI.29<<
        PurchaseInvoice."Vendor Bank Account".SETVALUE('');

        //BC UPGRADE KUMARR78>> Blocking as Scope of OnPrem.
        // IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, PurchInvNo) THEN
        //     PurchaseHeader.ADDLINK(FileMgt.ServerTempFileName('pdf'), 'TestLinkPTP053');
        //BC UPGRADE KUMARR78<< Blocking as Scope of OnPrem.


        //BC UPGRADE KUMARR78 >> Saas Based Replacement.
        if PurchaseHeader.Get(PurchaseHeader."Document Type"::Invoice, PurchInvNo) then begin
            TempBlob.CreateOutStream(OutStream);
            OutStream.WriteText('Test Attachment Content');

            TempBlob.CreateInStream(InStream);

            DocumentAttachment.Init();
            DocumentAttachment.Validate("Table ID", Database::"Purchase Header");
            DocumentAttachment.Validate("No.", PurchaseHeader."No.");
            DocumentAttachment.Validate("File Name", 'TestLinkPTP053.pdf');
            DocumentAttachment.Validate("File Extension", 'pdf');

            DocumentAttachment."Document Reference ID".ImportStream(InStream, 'TestLinkPTP053.pdf');
            DocumentAttachment.Insert(true);
        end;
        //BC UPGRADE KUMARR78 << Saas Based Replacement.

        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, PurchaseInvoice."No.".VALUE);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            //IF Workflow.FINDSET THEN
            //REPEAT
            //Workflow.Enabled := FALSE;
            //Workflow.MODIFY;
            //UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;
        // PurchaseInvoice.Action120.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseInvoice."Re&lease".INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name

        PurchaseInvoice.Post.INVOKE;

        PostedPurchInvHdr.SetRange("Pre-Assigned No.", PurchInvNo);
        if PostedPurchInvHdr.FindFirst() then
            StorePostedInvNo := PostedPurchInvHdr."No.";

        PostedPurchInv.OpenView();
        PostedPurchInv.Filter.SetFilter("No.", StorePostedInvNo);
        PostedPurchInv."Payment Status".ASSERTEQUALS(paymentstatus::"Pending Review");
        //HEI.23<<
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler,MessageHandler,WhseRcptPageHandler,ItemTrackingLinesModalPageHandler,GetReceiptLineModalPageHandlerPTP056,DimSetEntriesModalPageHandler')]
    procedure PTP056_Negativetesting_PO_Invoice_DocDateError();
    var
        Vendor: Record Vendor;
        Item: Record Item;
        Location: Record Location;
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        PostedPurchInvHdr: Record "Purch. Inv. Header";
        PostedPurchInv: TestPage "Posted Purchase Invoice";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        UserSetup2: Record "User Setup";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        DocDateError: TextConst ENU = 'Document Date must have a value in Purchase Header: Document Type=Invoice, No.=%1. It cannot be zero or empty.';
        PrevCurrCode: Code[10];
        CurrExChngRate: Record "Currency Exchange Rate";
        VenInvError: TextConst ENU = 'Vendor Invoice No. must have a value in Purchase Header: Document Type=Invoice, No.=%1. It cannot be zero or empty.';
        ItemNoError: TextConst ENU = 'Validation error for Field: No.,  Message = ''Receipt No. must be equal to ''''  in Purchase Line: Document Type=Invoice, Document No.=%1, Line No.=%2. Current value is ''%3''.''';
        RecItem: Record Item;
        RecLocation: Record Location;
        LocationError: TextConst ENU = 'Validation error for Field: Location Code,  Message = ''Receipt No. must be equal to ''''  in Purchase Line: Document Type=Invoice, Document No.=%1, Line No.=%2. Current value is ''%3''.''';
        DueDateError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''You cannot modify the field- ''Due Date''.  (Select Refresh to discard errors)''';
        VATBusinessPostingGroup: Record "VAT Business Posting Group";
        PaymentMethod: Record "Payment Method";
        PayMetError: TextConst ENU = 'Validation error for Field: Payment Method Code,  Message = ''You cannot modify the field- ''Payment Method Code''.  (Select Refresh to discard errors)''';
        PaymentTerms: Record "Payment Terms";
        PayTermError: TextConst ENU = 'Validation error for Field: Payment Terms Code,  Message = ''You cannot modify the field- ''Payment Terms Code''.  (Select Refresh to discard errors)''';
        AmtError: Label 'Total amount (%1) is not equal to total of lines (%2)';
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DimensionValue1: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        Bin: Record Bin;
        PurchaseLine: Record "Purchase Line";
        Workflow: Record Workflow;
        RecZone: Record Zone;
        WhseEmpDTW: record 50356;
        WarRecLin: Record "Warehouse Receipt Line";
        WarEmployee: Record "Warehouse Employee";
        WhseDocNo: code[20];
    begin
        PTP056_Negativetesting_PO_Invoice_DocDateError01();
        PTP056_Negativetesting_PO_Invoice_DocDateError02();
        // DimensionRestrictionCheck(); //HEI.105
        // //HEI.23>>
        // WarehouseReceiptHeader.DeleteAll();//HEI.36
        // UnitTestingValues.Reset();
        // UnitTestingValues.Get('PTP056', CompanyName, Database::Vendor);
        // Vendor.Get(UnitTestingValues.Value);

        // UnitTestingValues.Reset();
        // UnitTestingValues.Get('PTP056', CompanyName, Database::Item);
        // Item.Get(UnitTestingValues.Value);

        // UnitTestingValues.Reset();
        // UnitTestingValues.Get('PTP056', CompanyName, Database::"Vendor Bank Account");
        // VendorBankAccount.Get(Vendor."No.", UnitTestingValues.Value);

        // UnitTestingValues.Reset();
        // UnitTestingValues.Get('PTP056', CompanyName, Database::"Lot No. Information");
        // LotNoFilter := UnitTestingValues.Value;

        // UnitTestingValues.Reset();
        // UnitTestingValues.Get('PTP056', CompanyName, Database::Location);
        // Location.Get(UnitTestingValues.Value);
        // //HEI.61>>
        // UnitTestingValues.Reset();
        // UnitTestingValues.Get('PTP056', CompanyName, Database::Bin);
        // Bin.Get(Location.Code, UnitTestingValues.Value);
        // //HEI.61<<
        // UnitTestingValues.Reset();
        // UnitTestingValues.Get('PTP056', CompanyName, Database::"Dimension Value");
        // GeneralLedgerSetup.Get();
        // if UnitTestingValues.Value <> '' then
        //     DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 3 Code", UnitTestingValues.Value);
        // PurchaseOrder.OpenNew();
        // //PurchaseOrder.NEW;
        // PurchaseOrder."No.".AssistEdit();
        // PurchaseOrder."Buy-from Vendor No.".SetValue(Vendor."No.");
        // //HEI.51>>
        // if PurchasesPayablesSetup.Get() then
        //     if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
        //         PurchaseOrder."Location Code".SetValue(Location.Code);
        // //HEI.51<<
        // PurchaseOrder."Vendor Invoice No.".SetValue('StP Unit Test PTP056');
        // PnPSetup.Get();
        // if PnPSetup."Requester ID Mandatory FND" then; //BC UPGRADE KUMARR78 Adding Semicolon(;) to handle the sentence.
        // PurchaseOrder."Requester ID".SETVALUE(USERID);//BC UPGRADE KUMARR78 DIT Field Removed.
        // PurchaseOrder.PurchLines.New();
        // PurchaseOrder.PurchLines.Type.SetValue(Type::Item);
        // PurchaseOrder.PurchLines."No.".SetValue(Item."No.");
        // PurchaseOrder.PurchLines."Location Code".SetValue(Location.Code);
        // PurchaseOrder.PurchLines.Quantity.SetValue(1);
        // //HEI.61>>
        // PurchaseLine.Reset();
        // PurchaseLine.SetRange("Document No.", PurchaseOrder."No.".Value);
        // PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        // PurchaseLine.SetRange("No.", PurchaseOrder.PurchLines."No.".Value);
        // if PurchaseLine.FindFirst() then begin
        //     PurchaseLine.Validate("Bin Code", Bin.Code);
        //     PurchaseLine.Modify();
        // end;
        // //HEI.61<<
        // //HEI.57>>
        // GeneralLedgerSetup.Get();
        // UnitTestingValues.Reset();
        // UnitTestingValues.Get('PTP056', CompanyName, Database::"Dimension Value");
        // //HEI.95>>
        // //IF UnitTestingValues.Value ,. '' THEN
        // if UnitTestingValues."Value 2" <> '' then
        //     //HEI.95<<
        //     DimensionValue1.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues."Value 2");

        // EbfCombination.Reset();
        // EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        // //HEI.78>>
        // //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue1.Code);
        // //HEI.84>>
        // //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        // //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue1.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        // //HEI.84<<
        // //HEI.78<<
        // EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        // EbfCombination.DeleteAll();
        // PurchaseHeader.Reset();
        // PurchaseHeader.SetRange("No.", PurchaseOrder."No.".Value);
        // PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
        // if PurchaseHeader.FindFirst() then begin
        //     PurchaseHeader.Validate("Shortcut Dimension 2 Code", DimensionValue1.Code);
        //     PurchaseHeader.Modify();
        // end;
        // //HEI.57<<
        // PurchaseOrder.PurchLines.Dimensions.Invoke();
        // // BC Upgrade BHARDA11 >>
        // Workflow.Reset();
        // Workflow.SetRange(Template, false);
        // Workflow.SetRange(Category, 'PURCHDOC');
        // Workflow.ModifyAll(Enabled, true);
        // // BC Upgrade BHARDA11 >>
        // //Disable Workflows before Release
        // PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        // if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
        //     Workflow.SetRange(Enabled, true);
        //     //HEI.74>>
        //     if Workflow.FindFirst() then
        //         Workflow.ModifyAll(Enabled, false);
        //     //IF Workflow.FINDSET THEN
        //     //REPEAT
        //     //Workflow.Enabled := FALSE;
        //     //Workflow.MODIFY;
        //     //UNTIL Workflow.NEXT = 0;
        //     //HEI.74<<
        // end;
        // PurchaseOrder.Release.Invoke();

        // // PurchaseOrder.Action149.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        // PurchaseOrder."Create &Whse. Receipt".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

        // WarehouseReceipt.OpenView();
        // WarehouseReceipt.Filter.SetFilter("Source No. FND", PurchaseOrder."No.".Value);

        // //Store the PO No in warehouse receipt
        // WhseRcptPONo := WarehouseReceipt."Source No.".Value;
        // WhseDocNo := WarehouseReceipt."No.".value; // BC Upgrade BHARDA11
        // // BC Upgrade BHARDA11 
        // Reczone.reset;
        // Reczone.setrange("Location Code", Location.code);
        // reczone.findfirst();
        // WhseEmpDTW.init();
        // WhseEmpDTW."User ID" := userid;
        // WhseEmpDTW."location Code" := Location.code;
        // WhseEmpDTW."zone Code" := RecZone.Code;
        // if WhseEmpDTW.insert() then;
        // // error(Reczone.code);
        // Bin.reset();
        // Bin.SetRange("Zone Code", RecZone.code);
        // bin.findfirst();
        // WarEmployee.init();
        // WarEmployee."User ID" := userid;
        // waremployee."location Code" := Location.code;
        // if WarEmployee.insert() then;
        // WarRecLin.reset();
        // WarRecLin.SetRange("No.", WhseDocNo);
        // WarRecLin.findset();
        // WarRecLin.Validate("Zone Code", RecZone.Code);
        // WarRecLin.Validate("Bin Code", Bin.Code);
        // WarRecLin.modify();

        // // BC Upgrade BHARDA11 
        // //Select Item Tracking Code
        // WarehouseReceipt.WhseReceiptLines.ItemTrackingLines.Invoke();

        // //Post The warehouse receipt
        // WarehouseReceipt."Post Receipt".Invoke();
        // PurchaseOrder.OK.Invoke();
        // //PurchaseOrderList.OK.INVOKE;

        // PurchRcptHdr.SetRange("Order No.", WhseRcptPONo);
        // if PurchRcptHdr.FindFirst() then
        //     DocNo := PurchRcptHdr."No.";

        // PurchaseInvoice.OPENNEW;

        // PurchaseInvoice."No.".ASSISTEDIT;
        // PurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");
        // PurchaseInvoice."Document Date".SETVALUE(0D);
        // //HEI.51>>
        // if PurchasesPayablesSetup.Get() then
        //     if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
        //         PurchaseInvoice."Location Code".SETVALUE(Location.Code);
        // //HEI.51<<
        // ClearLastError();

        // // ASSERTERROR PurchaseInvoice.Post.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        // asserterror PurchaseInvoice.Post_Custom.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name

        // if GetLastErrorText <> STRSUBSTNO(DocDateError, PurchaseInvoice."No.") then
        //     Error('Unexpected Error: %1', GetLastErrorText);
        // PurchaseInvoice."Document Date".SETVALUE(Today);
        // if Vendor."Preferred Bank Account Code" = '' then //HEI.31
        //     PurchaseInvoice."Vendor Bank Account".SETVALUE(VendorBankAccount.Code);
        // PrevCurrCode := '';
        // PrevCurrCode := PurchaseInvoice."Currency Code".VALUE;
        // CurrExChngRate.Reset();
        // CurrExChngRate.SetFilter(CurrExChngRate."Currency Code", '<>%1', PrevCurrCode);
        // CurrExChngRate.SetFilter(CurrExChngRate."Starting Date", '<=%1', Today);
        // //HEI.113>>
        // HEI.114 >> This tag Blocked the below line as in NAV but its already blocked so just putting tag
        // CurrExChngRate.SetFilter("Exchange Rate Amount", '<>0');
        // HEI.114 <<
        // //HEI.113<<

        // BC Upgrade MISHRS14 >>
        // HEI.114
        // if CurrExChngRate.FindLast() then
        IF CurrExChngRate.FINDLAST THEN BEGIN
        IF CurrExChngRate."Exchange Rate Amount" = 0 THEN BEGIN
            CurrExChngRate."Exchange Rate Amount" := 1;
            CurrExChngRate.MODIFY(FALSE);
        END;
        //HEI.114<<
        //     PurchaseInvoice."Currency Code".SETVALUE(CurrExChngRate."Currency Code");
        // HEI.114 >>
        end; 
        // HEI.114 <<
        // PurchaseInvoice.PurchLines.GetReceiptLines.INVOKE;

        // PurchaseInvoice."Currency Code".SETVALUE(PrevCurrCode);
        // PurchaseInvoice.PurchLines.GetReceiptLines.INVOKE;

        // PurchInvNo := PurchaseInvoice."No.".VALUE;

        // PurchaseInvoice.PurchLines.FILTER.SETFILTER("No.", Item."No.");
        // PurchaseInvoice.PurchLines.FILTER.SETFILTER("Type", 'Item');
        // PurchaseInvoice.PurchLines.First();

        // //HEI.29>>
        // PurchLn.Reset();
        // PurchLn.SETRANGE("Document No.", PurchaseInvoice."No.".VALUE);
        // PurchLn.SETRANGE("No.", PurchaseInvoice.PurchLines."No.".VALUE);
        // if PurchLn.FindFirst() then
        //     //HEI.29<<
        //     RecItem.Reset();
        // RecItem.SETFILTER("No.", '<>%1', PurchaseInvoice.PurchLines."No.".VALUE);
        // if RecItem.FindFirst() then begin
        //     ClearLastError();
        //     // Error('%1.', PurchaseInvoice.PurchLines.Type.Value);
        //     PurchaseInvoice.PurchLines.Type.SetValue('Item');
        //     asserterror PurchaseInvoice.PurchLines."No.".SETVALUE(RecItem."No.");
        //     if GetLastErrorText <> STRSUBSTNO(ItemNoError, PurchaseInvoice."No.", PurchLn."Line No.", PurchLn."Receipt No.") then
        //         Error('Unexpected Error: %1', GetLastErrorText);
        // end;

        // RecLocation.Reset();
        // RecLocation.SETFILTER(Code, '<>%1', PurchaseInvoice.PurchLines."Location Code".VALUE);
        // RecLocation.SetFilter("Warning Threshold Days FND", '<>%1', 0);
        // if RecLocation.FindFirst() then begin
        //     asserterror PurchaseInvoice.PurchLines."Location Code".SETVALUE(RecLocation.Code);
        //     if GetLastErrorText <> STRSUBSTNO(LocationError, PurchaseInvoice."No.", PurchLn."Line No.", PurchLn."Receipt No.") then
        //         Error('Unexpected Error: %1', GetLastErrorText);
        // end;
        // asserterror PurchaseInvoice."Due Date".SETVALUE(0D);
        // if GetLastErrorText <> DueDateError then
        //     Error('Unexpected Error: %1', GetLastErrorText);
        // VATBusinessPostingGroup.Reset();
        // VATBusinessPostingGroup.SETFILTER(Code, '<>%1', PurchaseInvoice."VAT Bus. Posting Group".VALUE);
        // if VATBusinessPostingGroup.FindFirst() then
        //     PurchaseInvoice."VAT Bus. Posting Group".SETVALUE(VATBusinessPostingGroup.Code);
        // PaymentTerms.Reset();
        // PaymentTerms.SETFILTER(Code, '<>%1', PurchaseInvoice."Payment Terms Code".VALUE);
        // if PaymentTerms.FindFirst() then begin
        //     asserterror PurchaseInvoice."Payment Terms Code".SETVALUE(PaymentTerms.Code);
        //     if GetLastErrorText <> PayTermError then
        //         Error('Unexpected Error: %1', GetLastErrorText);
        // end;
        // //IF VendorBankAccount."Country/Region Code"<>'' THEN BEGIN//HEI.56  //HEI.57
        // if (VendorBankAccount."Country/Region Code" <> '') and (VendorBankAccount.IBAN <> '') then begin//HEI.57
        //     PaymentMethod.Reset();
        //     PaymentMethod.SETFILTER(Code, '<>%1', PurchaseInvoice."Payment Method Code".VALUE);
        //     if PaymentMethod.FindFirst() then begin
        //         asserterror PurchaseInvoice."Payment Method Code".SETVALUE(PaymentMethod.Code);
        //         if GetLastErrorText <> PayMetError then
        //             Error('Unexpected Error: %1', GetLastErrorText);
        //     end;
        // end;//HEI.56

        //HEI.23<<
    end;

    [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler,MessageHandler,WhseRcptPageHandler,ItemTrackingLinesModalPageHandler,GetReceiptLineModalPageHandlerPTP056,DimSetEntriesModalPageHandler')]
    procedure PTP056_Negativetesting_PO_Invoice_DocDateError01();
    var
        Vendor: Record Vendor;
        Item: Record Item;
        Location: Record Location;
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        PostedPurchInvHdr: Record "Purch. Inv. Header";
        PostedPurchInv: TestPage "Posted Purchase Invoice";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        UserSetup2: Record "User Setup";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        DocDateError: TextConst ENU = 'Document Date must have a value in Purchase Header: Document Type=Invoice, No.=%1. It cannot be zero or empty.';
        PrevCurrCode: Code[10];
        CurrExChngRate: Record "Currency Exchange Rate";
        VenInvError: TextConst ENU = 'Vendor Invoice No. must have a value in Purchase Header: Document Type=Invoice, No.=%1. It cannot be zero or empty.';
        ItemNoError: TextConst ENU = 'Validation error for Field: No.,  Message = ''Receipt No. must be equal to ''''  in Purchase Line: Document Type=Invoice, Document No.=%1, Line No.=%2. Current value is ''%3''.''';
        RecItem: Record Item;
        RecLocation: Record Location;
        LocationError: TextConst ENU = 'Validation error for Field: Location Code,  Message = ''Receipt No. must be equal to ''''  in Purchase Line: Document Type=Invoice, Document No.=%1, Line No.=%2. Current value is ''%3''.''';
        DueDateError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''You cannot modify the field- ''Due Date''.  (Select Refresh to discard errors)''';
        VATBusinessPostingGroup: Record "VAT Business Posting Group";
        PaymentMethod: Record "Payment Method";
        PayMetError: TextConst ENU = 'Validation error for Field: Payment Method Code,  Message = ''You cannot modify the field- ''Payment Method Code''.  (Select Refresh to discard errors)''';
        PaymentTerms: Record "Payment Terms";
        PayTermError: TextConst ENU = 'Validation error for Field: Payment Terms Code,  Message = ''You cannot modify the field- ''Payment Terms Code''.  (Select Refresh to discard errors)''';
        AmtError: Label 'Total amount (%1) is not equal to total of lines (%2)';
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DimensionValue1: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        Bin: Record Bin;
        PurchaseLine: Record "Purchase Line";
        Workflow: Record Workflow;
        RecZone: Record Zone;
        WhseEmpDTW: record 50356;
        WarRecLin: Record "Warehouse Receipt Line";
        WarEmployee: Record "Warehouse Employee";
        WhseDocNo: code[20];
        ErrorMesageHide: Codeunit "Error Message Hide TestScripts";
    begin
        DimensionRestrictionCheck(); //HEI.105
        //HEI.23>>
        WarehouseReceiptHeader.DeleteAll();//HEI.36
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::"Vendor Bank Account");
        VendorBankAccount.Get(Vendor."No.", UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::"Lot No. Information");
        LotNoFilter := UnitTestingValues.Value;

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);
        //HEI.61>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::Bin);
        Bin.Get(Location.Code, UnitTestingValues.Value);
        //HEI.61<<
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::"Dimension Value");
        GeneralLedgerSetup.Get();
        if UnitTestingValues.Value <> '' then
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 3 Code", UnitTestingValues.Value);
        PurchaseOrder.OpenNew();
        //PurchaseOrder.NEW;
        PurchaseOrder."No.".AssistEdit();
        PurchaseOrder."Buy-from Vendor No.".SetValue(Vendor."No.");
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseOrder."Location Code".SetValue(Location.Code);
        //HEI.51<<
        PurchaseOrder."Vendor Invoice No.".SetValue('StP Unit Test PTP056');
        PnPSetup.Get();
        if PnPSetup."Requester ID Mandatory FND" then; //BC UPGRADE KUMARR78 Adding Semicolon(;) to handle the sentence.
        PurchaseOrder."Requester ID".SETVALUE(USERID);//BC UPGRADE KUMARR78 DIT Field Removed.
        PurchaseOrder.PurchLines.New();
        PurchaseOrder.PurchLines.Type.SetValue(Type::Item);
        PurchaseOrder.PurchLines."No.".SetValue(Item."No.");
        PurchaseOrder.PurchLines."Location Code".SetValue(Location.Code);
        PurchaseOrder.PurchLines.Quantity.SetValue(1);
        //HEI.61>>
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", PurchaseOrder."No.".Value);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("No.", PurchaseOrder.PurchLines."No.".Value);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Bin Code", Bin.Code);
            PurchaseLine.Modify();
        end;
        //HEI.61<<
        //HEI.57>>
        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::"Dimension Value");
        //HEI.95>>
        //IF UnitTestingValues.Value ,. '' THEN
        if UnitTestingValues."Value 2" <> '' then
            //HEI.95<<
            DimensionValue1.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues."Value 2");

        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue1.Code);
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue1.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();
        PurchaseHeader.Reset();
        PurchaseHeader.SetRange("No.", PurchaseOrder."No.".Value);
        PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
        if PurchaseHeader.FindFirst() then begin
            PurchaseHeader.Validate("Shortcut Dimension 2 Code", DimensionValue1.Code);
            PurchaseHeader.Modify();
        end;
        //HEI.57<<
        PurchaseOrder.PurchLines.Dimensions.Invoke();
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            //IF Workflow.FINDSET THEN
            //REPEAT
            //Workflow.Enabled := FALSE;
            //Workflow.MODIFY;
            //UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;
        PurchaseOrder.Release.Invoke();
        // BC Upgrade BHARDA11 >>
        Reczone.reset;
        Reczone.setrange("Location Code", Location.code);
        reczone.findfirst();
        WhseEmpDTW.init();
        WhseEmpDTW."User ID" := userid;
        WhseEmpDTW."location Code" := Location.code;
        WhseEmpDTW."zone Code" := RecZone.Code;
        if WhseEmpDTW.insert() then;
        // error(Reczone.code);
        Bin.reset();
        Bin.SetRange("Zone Code", RecZone.code);
        bin.findfirst();
        WarEmployee.init();
        WarEmployee."User ID" := userid;
        waremployee."location Code" := Location.code;
        if WarEmployee.insert() then;
        // BC Upgrade BHARDA11 <<
        // PurchaseOrder.Action149.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseOrder."Create &Whse. Receipt".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

        WarehouseReceipt.OpenView();
        WarehouseReceipt.Filter.SetFilter("Source No. FND", PurchaseOrder."No.".Value);

        //Store the PO No in warehouse receipt
        WhseRcptPONo := WarehouseReceipt."Source No.".Value;
        WhseDocNo := WarehouseReceipt."No.".value; // BC Upgrade BHARDA11

        WarRecLin.reset();
        WarRecLin.SetRange("No.", WhseDocNo);
        WarRecLin.findset();
        WarRecLin.Validate("Zone Code", RecZone.Code);
        WarRecLin.Validate("Bin Code", Bin.Code);
        WarRecLin.modify();

        // BC Upgrade BHARDA11 
        //Select Item Tracking Code
        WarehouseReceipt.WhseReceiptLines.ItemTrackingLines.Invoke();

        //Post The warehouse receipt
        WarehouseReceipt."Post Receipt".Invoke();
        PurchaseOrder.OK.Invoke();
        //PurchaseOrderList.OK.INVOKE;

        PurchRcptHdr.SetRange("Order No.", WhseRcptPONo);
        if PurchRcptHdr.FindFirst() then
            DocNo := PurchRcptHdr."No.";

        PurchaseInvoice.OPENNEW;

        PurchaseInvoice."No.".ASSISTEDIT;
        PurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");
        PurchaseInvoice."Document Date".SETVALUE(0D);
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseInvoice."Location Code".SETVALUE(Location.Code);
        //HEI.51<<
        ClearLastError();

        // ASSERTERROR PurchaseInvoice.Post.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        // asserterror PurchaseInvoice.Post_Custom.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name
        // Clear(ErrorMesageHide);
        // Clear(LastError);
        // BindSubscription(ErrorMesageHide);
        asserterror PurchaseInvoice.Post_Custom.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name
        // ErrorMesageHide.Run();
        // LastError := ErrorMesageHide.ErrorMesage();
        // UnbindSubscription(ErrorMesageHide);

        if GetLastErrorText <> STRSUBSTNO(DocDateError, PurchaseInvoice."No.") then
            // if LastError <> STRSUBSTNO(DocDateError, PurchaseInvoice."No.") then
            Error('Unexpected Error: %1', GetLastErrorText);
        // PurchaseInvoice."Document Date".SETVALUE(Today);
        // if Vendor."Preferred Bank Account Code" = '' then //HEI.31
        //     PurchaseInvoice."Vendor Bank Account".SETVALUE(VendorBankAccount.Code);
        // PrevCurrCode := '';
        // PrevCurrCode := PurchaseInvoice."Currency Code".VALUE;
        // CurrExChngRate.Reset();
        // CurrExChngRate.SetFilter(CurrExChngRate."Currency Code", '<>%1', PrevCurrCode);
        // CurrExChngRate.SetFilter(CurrExChngRate."Starting Date", '<=%1', Today);
        // //HEI.113>>
        // CurrExChngRate.SetFilter("Exchange Rate Amount", '<>0');
        // //HEI.113<<
        // if CurrExChngRate.FindLast() then
        //     PurchaseInvoice."Currency Code".SETVALUE(CurrExChngRate."Currency Code");
        // PurchaseInvoice.PurchLines.GetReceiptLines.INVOKE;

        // PurchaseInvoice."Currency Code".SETVALUE(PrevCurrCode);
        // PurchaseInvoice.PurchLines.GetReceiptLines.INVOKE;

        // PurchInvNo := PurchaseInvoice."No.".VALUE;

        // PurchaseInvoice.PurchLines.FILTER.SETFILTER("No.", Item."No.");
        // PurchaseInvoice.PurchLines.FILTER.SETFILTER("Type", 'Item');
        // PurchaseInvoice.PurchLines.First();

        // //HEI.29>>
        // PurchLn.Reset();
        // PurchLn.SETRANGE("Document No.", PurchaseInvoice."No.".VALUE);
        // PurchLn.SETRANGE("No.", PurchaseInvoice.PurchLines."No.".VALUE);
        // if PurchLn.FindFirst() then
        //     //HEI.29<<
        //     RecItem.Reset();
        // RecItem.SETFILTER("No.", '<>%1', PurchaseInvoice.PurchLines."No.".VALUE);
        // if RecItem.FindFirst() then begin
        //     ClearLastError();
        //     // Error('%1.', PurchaseInvoice.PurchLines.Type.Value);
        //     PurchaseInvoice.PurchLines.Type.SetValue('Item');
        //     asserterror PurchaseInvoice.PurchLines."No.".SETVALUE(RecItem."No.");
        //     if GetLastErrorText <> STRSUBSTNO(ItemNoError, PurchaseInvoice."No.", PurchLn."Line No.", PurchLn."Receipt No.") then
        //         Error('Unexpected Error: %1', GetLastErrorText);
        // end;

        // RecLocation.Reset();
        // RecLocation.SETFILTER(Code, '<>%1', PurchaseInvoice.PurchLines."Location Code".VALUE);
        // RecLocation.SetFilter("Warning Threshold Days FND", '<>%1', 0);
        // if RecLocation.FindFirst() then begin
        //     asserterror PurchaseInvoice.PurchLines."Location Code".SETVALUE(RecLocation.Code);
        //     if GetLastErrorText <> STRSUBSTNO(LocationError, PurchaseInvoice."No.", PurchLn."Line No.", PurchLn."Receipt No.") then
        //         Error('Unexpected Error: %1', GetLastErrorText);
        // end;
        // asserterror PurchaseInvoice."Due Date".SETVALUE(0D);
        // if GetLastErrorText <> DueDateError then
        //     Error('Unexpected Error: %1', GetLastErrorText);
        // VATBusinessPostingGroup.Reset();
        // VATBusinessPostingGroup.SETFILTER(Code, '<>%1', PurchaseInvoice."VAT Bus. Posting Group".VALUE);
        // if VATBusinessPostingGroup.FindFirst() then
        //     PurchaseInvoice."VAT Bus. Posting Group".SETVALUE(VATBusinessPostingGroup.Code);
        // PaymentTerms.Reset();
        // PaymentTerms.SETFILTER(Code, '<>%1', PurchaseInvoice."Payment Terms Code".VALUE);
        // if PaymentTerms.FindFirst() then begin
        //     asserterror PurchaseInvoice."Payment Terms Code".SETVALUE(PaymentTerms.Code);
        //     if GetLastErrorText <> PayTermError then
        //         Error('Unexpected Error: %1', GetLastErrorText);
        // end;
        // //IF VendorBankAccount."Country/Region Code"<>'' THEN BEGIN//HEI.56  //HEI.57
        // if (VendorBankAccount."Country/Region Code" <> '') and (VendorBankAccount.IBAN <> '') then begin//HEI.57
        //     PaymentMethod.Reset();
        //     PaymentMethod.SETFILTER(Code, '<>%1', PurchaseInvoice."Payment Method Code".VALUE);
        //     if PaymentMethod.FindFirst() then begin
        //         asserterror PurchaseInvoice."Payment Method Code".SETVALUE(PaymentMethod.Code);
        //         if GetLastErrorText <> PayMetError then
        //             Error('Unexpected Error: %1', GetLastErrorText);
        //     end;
        // end;//HEI.56

        //HEI.23<<
    end;

    [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler,MessageHandler,WhseRcptPageHandler,ItemTrackingLinesModalPageHandler,GetReceiptLineModalPageHandlerPTP056,DimSetEntriesModalPageHandler')]
    procedure PTP056_Negativetesting_PO_Invoice_DocDateError02();
    var
        Vendor: Record Vendor;
        Item: Record Item;
        Location: Record Location;
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        PostedPurchInvHdr: Record "Purch. Inv. Header";
        PostedPurchInv: TestPage "Posted Purchase Invoice";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        UserSetup2: Record "User Setup";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        DocDateError: TextConst ENU = 'Document Date must have a value in Purchase Header: Document Type=Invoice, No.=%1. It cannot be zero or empty.';
        PrevCurrCode: Code[10];
        CurrExChngRate: Record "Currency Exchange Rate";
        VenInvError: TextConst ENU = 'Vendor Invoice No. must have a value in Purchase Header: Document Type=Invoice, No.=%1. It cannot be zero or empty.';
        // ItemNoError: TextConst ENU = 'Validation error for Field: No.,  Message = ''Receipt No. must be equal to ''''  in Purchase Line: Document Type=Invoice, Document No.=%1, Line No.=%2. Current value is ''%3''.''';
        ItemNoError: TextConst ENU = 'Validation error for Field: No.,  Message = ''Receipt No. must be equal to ''''  in Purchase Line: Document Type=Invoice, Document No.=%1, Line No.=%2. Current value is ''%3''.''';
        RecItem: Record Item;
        RecLocation: Record Location;
        LocationError: TextConst ENU = 'Validation error for Field: Location Code,  Message = ''Receipt No. must be equal to ''''  in Purchase Line: Document Type=Invoice, Document No.=%1, Line No.=%2. Current value is ''%3''.''';
        DueDateError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''"You cannot modify the field- ''Due Date''. " (Select Refresh to discard errors)'''; // BC Upgrade BHARDA11'
        VATBusinessPostingGroup: Record "VAT Business Posting Group";
        PaymentMethod: Record "Payment Method";
        PayMetError: TextConst ENU = 'Validation error for Field: Payment Method Code,  Message = ''"You cannot modify the field- ''Payment Method Code''. " (Select Refresh to discard errors)''';
        PaymentTerms: Record "Payment Terms";
        PayTermError: TextConst ENU = 'Validation error for Field: Payment Terms Code,  Message = ''"You cannot modify the field- ''Payment Terms Code''. " (Select Refresh to discard errors)''';
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DimensionValue1: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        Bin: Record Bin;
        PurchaseLine: Record "Purchase Line";
        Workflow: Record Workflow;
        RecZone: Record Zone;
        WhseEmpDTW: record 50356;
        WarRecLin: Record "Warehouse Receipt Line";
        WarEmployee: Record "Warehouse Employee";
        WhseDocNo: code[20];
        CheckError: text;
    begin
        DimensionRestrictionCheck(); //HEI.105
        //HEI.23>>
        WarehouseReceiptHeader.DeleteAll();//HEI.36
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::"Vendor Bank Account");
        VendorBankAccount.Get(Vendor."No.", UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::"Lot No. Information");
        LotNoFilter := UnitTestingValues.Value;

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);
        //HEI.61>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::Bin);
        Bin.Get(Location.Code, UnitTestingValues.Value);
        //HEI.61<<
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::"Dimension Value");
        GeneralLedgerSetup.Get();
        if UnitTestingValues.Value <> '' then
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 3 Code", UnitTestingValues.Value);
        PurchaseOrder.OpenNew();
        //PurchaseOrder.NEW;
        PurchaseOrder."No.".AssistEdit();
        PurchaseOrder."Buy-from Vendor No.".SetValue(Vendor."No.");
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseOrder."Location Code".SetValue(Location.Code);
        //HEI.51<<
        PurchaseOrder."Vendor Invoice No.".SetValue('StP Unit Test PTP056');
        PnPSetup.Get();
        if PnPSetup."Requester ID Mandatory FND" then; //BC UPGRADE KUMARR78 Adding Semicolon(;) to handle the sentence.
        PurchaseOrder."Requester ID".SETVALUE(USERID);//BC UPGRADE KUMARR78 DIT Field Removed.
        PurchaseOrder.PurchLines.New();
        PurchaseOrder.PurchLines.Type.SetValue(Type::Item);
        PurchaseOrder.PurchLines."No.".SetValue(Item."No.");
        PurchaseOrder.PurchLines."Location Code".SetValue(Location.Code);
        PurchaseOrder.PurchLines.Quantity.SetValue(1);
        //HEI.61>>
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", PurchaseOrder."No.".Value);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("No.", PurchaseOrder.PurchLines."No.".Value);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Bin Code", Bin.Code);
            PurchaseLine.Modify();
        end;
        //HEI.61<<
        //HEI.57>>
        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::"Dimension Value");
        //HEI.95>>
        //IF UnitTestingValues.Value ,. '' THEN
        if UnitTestingValues."Value 2" <> '' then
            //HEI.95<<
            DimensionValue1.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues."Value 2");

        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue1.Code);
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue1.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();
        PurchaseHeader.Reset();
        PurchaseHeader.SetRange("No.", PurchaseOrder."No.".Value);
        PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
        if PurchaseHeader.FindFirst() then begin
            PurchaseHeader.Validate("Shortcut Dimension 2 Code", DimensionValue1.Code);
            PurchaseHeader.Modify();
        end;
        //HEI.57<<
        PurchaseOrder.PurchLines.Dimensions.Invoke();
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            //IF Workflow.FINDSET THEN
            //REPEAT
            //Workflow.Enabled := FALSE;
            //Workflow.MODIFY;
            //UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;
        PurchaseOrder.Release.Invoke();
        // BC Upgrade BHARDA11 >>
        // BC Upgrade BHARDA11 
        Reczone.reset;
        Reczone.setrange("Location Code", Location.code);
        reczone.findfirst();
        WhseEmpDTW.init();
        WhseEmpDTW."User ID" := userid;
        WhseEmpDTW."location Code" := Location.code;
        WhseEmpDTW."zone Code" := RecZone.Code;
        if WhseEmpDTW.insert() then;
        // error(Reczone.code);
        Bin.reset();
        Bin.SetRange("Zone Code", RecZone.code);
        bin.findfirst();
        WarEmployee.init();
        WarEmployee."User ID" := userid;
        waremployee."location Code" := Location.code;
        if WarEmployee.insert() then;
        // BC Upgrade BHARDA11 <<
        // PurchaseOrder.Action149.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseOrder."Create &Whse. Receipt".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

        WarehouseReceipt.OpenView();
        WarehouseReceipt.Filter.SetFilter("Source No. FND", PurchaseOrder."No.".Value);

        //Store the PO No in warehouse receipt
        WhseRcptPONo := WarehouseReceipt."Source No.".Value;
        WhseDocNo := WarehouseReceipt."No.".value; // BC Upgrade BHARDA11

        WarRecLin.reset();
        WarRecLin.SetRange("No.", WhseDocNo);
        WarRecLin.findset();
        WarRecLin.Validate("Zone Code", RecZone.Code);
        WarRecLin.Validate("Bin Code", Bin.Code);
        WarRecLin.modify();

        // BC Upgrade BHARDA11 
        //Select Item Tracking Code
        WarehouseReceipt.WhseReceiptLines.ItemTrackingLines.Invoke();

        //Post The warehouse receipt
        WarehouseReceipt."Post Receipt".Invoke();
        PurchaseOrder.OK.Invoke();
        //PurchaseOrderList.OK.INVOKE;

        PurchRcptHdr.SetRange("Order No.", WhseRcptPONo);
        if PurchRcptHdr.FindFirst() then
            DocNo := PurchRcptHdr."No.";

        PurchaseInvoice.OPENNEW;

        PurchaseInvoice."No.".ASSISTEDIT;
        PurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");
        // PurchaseInvoice."Document Date".SETVALUE(0D);
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseInvoice."Location Code".SETVALUE(Location.Code);
        //HEI.51<<
        ClearLastError();

        // ASSERTERROR PurchaseInvoice.Post.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        // asserterror PurchaseInvoice.Post_Custom.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name

        // if GetLastErrorText <> STRSUBSTNO(DocDateError, PurchaseInvoice."No.") then
        //     Error('Unexpected Error: %1', GetLastErrorText);
        PurchaseInvoice."Document Date".SETVALUE(Today);
        if Vendor."Preferred Bank Account Code" = '' then //HEI.31
            PurchaseInvoice."Vendor Bank Account".SETVALUE(VendorBankAccount.Code);
        PrevCurrCode := '';
        PrevCurrCode := PurchaseInvoice."Currency Code".VALUE;
        CurrExChngRate.Reset();
        CurrExChngRate.SetFilter(CurrExChngRate."Currency Code", '<>%1', PrevCurrCode);
        CurrExChngRate.SetFilter(CurrExChngRate."Starting Date", '<=%1', Today);
        //HEI.113>>
        CurrExChngRate.SetFilter("Exchange Rate Amount", '<>0');
        //HEI.113<<
        if CurrExChngRate.FindLast() then
            PurchaseInvoice."Currency Code".SETVALUE(CurrExChngRate."Currency Code");
        PurchaseInvoice.PurchLines.GetReceiptLines.INVOKE;

        PurchaseInvoice."Currency Code".SETVALUE(PrevCurrCode);
        PurchaseInvoice.PurchLines.GetReceiptLines.INVOKE;

        PurchInvNo := PurchaseInvoice."No.".VALUE;

        PurchaseInvoice.PurchLines.FILTER.SETFILTER("No.", Item."No.");
        //HEI.29>>
        PurchLn.Reset();
        PurchLn.SETRANGE("Document No.", PurchaseInvoice."No.".VALUE);
        PurchLn.SETRANGE("No.", PurchaseInvoice.PurchLines."No.".VALUE);
        if PurchLn.FindFirst() then
            //HEI.29<<
            RecItem.Reset();
        RecItem.SETFILTER("No.", '<>%1', PurchaseInvoice.PurchLines."No.".VALUE);
        if RecItem.FindFirst() then begin
            ClearLastError();
            asserterror PurchaseInvoice.PurchLines."No.".SETVALUE(RecItem."No.");
            Clear(CheckError);
            CheckError := STRSUBSTNO(ItemNoError, PurchaseInvoice."No.", PurchLn."Line No.", PurchLn."Receipt No.");
            Clear(CheckError);
            CheckError := GetLastErrorText;
            if GetLastErrorText <> STRSUBSTNO(ItemNoError, PurchaseInvoice."No.", PurchLn."Line No.", PurchLn."Receipt No.") then
                Error('Unexpected Error: %1', GetLastErrorText);
        end;

        RecLocation.Reset();
        RecLocation.SETFILTER(Code, '<>%1', PurchaseInvoice.PurchLines."Location Code".VALUE);
        RecLocation.SetFilter("Warning Threshold Days FND", '<>%1', 0);
        if RecLocation.FindFirst() then begin
            asserterror PurchaseInvoice.PurchLines."Location Code".SETVALUE(RecLocation.Code);
            Clear(CheckError);
            CheckError := STRSUBSTNO(LocationError, PurchaseInvoice."No.", PurchLn."Line No.", PurchLn."Receipt No.");
            Clear(CheckError);
            CheckError := GetLastErrorText;
            if GetLastErrorText <> STRSUBSTNO(LocationError, PurchaseInvoice."No.", PurchLn."Line No.", PurchLn."Receipt No.") then
                Error('Unexpected Error: %1', GetLastErrorText);
        end;
        asserterror PurchaseInvoice."Due Date".SETVALUE(0D);
        Clear(CheckError);
        CheckError := DueDateError;
        Clear(CheckError);
        CheckError := GetLastErrorText;
        if GetLastErrorText <> DueDateError then
            Error('Unexpected Error: %1', GetLastErrorText);
        VATBusinessPostingGroup.Reset();
        VATBusinessPostingGroup.SETFILTER(Code, '<>%1', PurchaseInvoice."VAT Bus. Posting Group".VALUE);
        if VATBusinessPostingGroup.FindFirst() then
            PurchaseInvoice."VAT Bus. Posting Group".SETVALUE(VATBusinessPostingGroup.Code);
        PaymentTerms.Reset();
        PaymentTerms.SETFILTER(Code, '<>%1', PurchaseInvoice."Payment Terms Code".VALUE);
        if PaymentTerms.FindFirst() then begin
            asserterror PurchaseInvoice."Payment Terms Code".SETVALUE(PaymentTerms.Code);
            Clear(CheckError);
            CheckError := PayTermError;
            Clear(CheckError);
            CheckError := GetLastErrorText;
            if GetLastErrorText <> PayTermError then
                Error('Unexpected Error: %1', GetLastErrorText);
        end;
        //IF VendorBankAccount."Country/Region Code"<>'' THEN BEGIN//HEI.56  //HEI.57
        if (VendorBankAccount."Country/Region Code" <> '') and (VendorBankAccount.IBAN <> '') then begin//HEI.57
            PaymentMethod.Reset();
            PaymentMethod.SETFILTER(Code, '<>%1', PurchaseInvoice."Payment Method Code".VALUE);
            if PaymentMethod.FindFirst() then begin
                asserterror PurchaseInvoice."Payment Method Code".SETVALUE(PaymentMethod.Code);
                Clear(CheckError);
                CheckError := PayMetError;
                Clear(CheckError);
                CheckError := GetLastErrorText;
                if GetLastErrorText <> PayMetError then
                    Error('Unexpected Error: %1', GetLastErrorText);
            end;
        end;//HEI.56

        //HEI.23<<
    end;

    // [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler,MessageHandler,WhseRcptPageHandler,ItemTrackingLinesModalPageHandler,GetReceiptLineModalPageHandlerPTP056,DimSetEntriesModalPageHandler')]
    // procedure PTP056_Negativetesting_PO_Invoice_DocDateError03();
    // var
    //     Vendor: Record Vendor;
    //     Item: Record Item;
    //     Location: Record Location;
    //     GeneralLedgerSetup: Record "General Ledger Setup";
    //     PurchaseInvoice: TestPage "PO Purchase Invoice";
    //     PurchaseOrderList: TestPage "Purchase Orders";
    //     PurchaseOrder: TestPage "Purchase Order";
    //     WarehouseReceipt: TestPage "Warehouse Receipt";
    //     GetReceiptLines: TestPage "Get Receipt Lines";
    //     Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
    //     ItemTrackingLines: TestPage "Item Tracking Lines";
    //     WhseRcptPONo: Code[20];
    //     PurchRcptHdr: Record "Purch. Rcpt. Header";
    //     VendorBankAccount: Record "Vendor Bank Account";
    //     PurchLn: Record "Purchase Line";
    //     PurchInvNo: Code[20];
    //     DocAmount: Decimal;
    //     VATAmount: Decimal;
    //     PostedPurchInvHdr: Record "Purch. Inv. Header";
    //     PostedPurchInv: TestPage "Posted Purchase Invoice";
    //     paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
    //     UserSetup2: Record "User Setup";
    //     ApprovalEntries: TestPage "Approval Entries";
    //     UserSetup: Record "User Setup";
    //     DocDateError: TextConst ENU = 'Document Date must have a value in Purchase Header: Document Type=Invoice, No.=%1. It cannot be zero or empty.';
    //     PrevCurrCode: Code[10];
    //     CurrExChngRate: Record "Currency Exchange Rate";
    //     VenInvError: TextConst ENU = 'Vendor Invoice No. must have a value in Purchase Header: Document Type=Invoice, No.=%1. It cannot be zero or empty.';
    //     ItemNoError: TextConst ENU = 'Validation error for Field: No.,  Message = ''Receipt No. must be equal to ''''  in Purchase Line: Document Type=Invoice, Document No.=%1, Line No.=%2. Current value is ''%3''.''';
    //     RecItem: Record Item;
    //     RecLocation: Record Location;
    //     LocationError: TextConst ENU = 'Validation error for Field: Location Code,  Message = ''Receipt No. must be equal to ''''  in Purchase Line: Document Type=Invoice, Document No.=%1, Line No.=%2. Current value is ''%3''.''';
    //     DueDateError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''You cannot modify the field- ''Due Date''.  (Select Refresh to discard errors)''';
    //     VATBusinessPostingGroup: Record "VAT Business Posting Group";
    //     PaymentMethod: Record "Payment Method";
    //     PayMetError: TextConst ENU = 'Validation error for Field: Payment Method Code,  Message = ''You cannot modify the field- ''Payment Method Code''.  (Select Refresh to discard errors)''';
    //     PaymentTerms: Record "Payment Terms";
    //     PayTermError: TextConst ENU = 'Validation error for Field: Payment Terms Code,  Message = ''You cannot modify the field- ''Payment Terms Code''.  (Select Refresh to discard errors)''';
    //     AmtError: Label 'Total amount (%1) is not equal to total of lines (%2)';
    //     PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    //     DimensionValue1: Record "Dimension Value";
    //     EbfCombination: Record "Ebf Combination FND";
    //     Bin: Record Bin;
    //     PurchaseLine: Record "Purchase Line";
    //     Workflow: Record Workflow;
    //     RecZone: Record Zone;
    //     WhseEmpDTW: record 50356;
    //     WarRecLin: Record "Warehouse Receipt Line";
    //     WarEmployee: Record "Warehouse Employee";
    //     WhseDocNo: code[20];
    // begin
    //     DimensionRestrictionCheck(); //HEI.105
    //     //HEI.23>>
    //     WarehouseReceiptHeader.DeleteAll();//HEI.36
    //     UnitTestingValues.Reset();
    //     UnitTestingValues.Get('PTP056', CompanyName, Database::Vendor);
    //     Vendor.Get(UnitTestingValues.Value);

    //     UnitTestingValues.Reset();
    //     UnitTestingValues.Get('PTP056', CompanyName, Database::Item);
    //     Item.Get(UnitTestingValues.Value);

    //     UnitTestingValues.Reset();
    //     UnitTestingValues.Get('PTP056', CompanyName, Database::"Vendor Bank Account");
    //     VendorBankAccount.Get(Vendor."No.", UnitTestingValues.Value);

    //     UnitTestingValues.Reset();
    //     UnitTestingValues.Get('PTP056', CompanyName, Database::"Lot No. Information");
    //     LotNoFilter := UnitTestingValues.Value;

    //     UnitTestingValues.Reset();
    //     UnitTestingValues.Get('PTP056', CompanyName, Database::Location);
    //     Location.Get(UnitTestingValues.Value);
    //     //HEI.61>>
    //     UnitTestingValues.Reset();
    //     UnitTestingValues.Get('PTP056', CompanyName, Database::Bin);
    //     Bin.Get(Location.Code, UnitTestingValues.Value);
    //     //HEI.61<<
    //     UnitTestingValues.Reset();
    //     UnitTestingValues.Get('PTP056', CompanyName, Database::"Dimension Value");
    //     GeneralLedgerSetup.Get();
    //     if UnitTestingValues.Value <> '' then
    //         DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 3 Code", UnitTestingValues.Value);
    //     PurchaseOrder.OpenNew();
    //     //PurchaseOrder.NEW;
    //     PurchaseOrder."No.".AssistEdit();
    //     PurchaseOrder."Buy-from Vendor No.".SetValue(Vendor."No.");
    //     //HEI.51>>
    //     if PurchasesPayablesSetup.Get() then
    //         if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
    //             PurchaseOrder."Location Code".SetValue(Location.Code);
    //     //HEI.51<<
    //     PurchaseOrder."Vendor Invoice No.".SetValue('StP Unit Test PTP056');
    //     PnPSetup.Get();
    //     if PnPSetup."Requester ID Mandatory FND" then; //BC UPGRADE KUMARR78 Adding Semicolon(;) to handle the sentence.
    //     PurchaseOrder."Requester ID".SETVALUE(USERID);//BC UPGRADE KUMARR78 DIT Field Removed.
    //     PurchaseOrder.PurchLines.New();
    //     PurchaseOrder.PurchLines.Type.SetValue(Type::Item);
    //     PurchaseOrder.PurchLines."No.".SetValue(Item."No.");
    //     PurchaseOrder.PurchLines."Location Code".SetValue(Location.Code);
    //     PurchaseOrder.PurchLines.Quantity.SetValue(1);
    //     //HEI.61>>
    //     PurchaseLine.Reset();
    //     PurchaseLine.SetRange("Document No.", PurchaseOrder."No.".Value);
    //     PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
    //     PurchaseLine.SetRange("No.", PurchaseOrder.PurchLines."No.".Value);
    //     if PurchaseLine.FindFirst() then begin
    //         PurchaseLine.Validate("Bin Code", Bin.Code);
    //         PurchaseLine.Modify();
    //     end;
    //     //HEI.61<<
    //     //HEI.57>>
    //     GeneralLedgerSetup.Get();
    //     UnitTestingValues.Reset();
    //     UnitTestingValues.Get('PTP056', CompanyName, Database::"Dimension Value");
    //     //HEI.95>>
    //     //IF UnitTestingValues.Value ,. '' THEN
    //     if UnitTestingValues."Value 2" <> '' then
    //         //HEI.95<<
    //         DimensionValue1.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues."Value 2");

    //     EbfCombination.Reset();
    //     EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
    //     //HEI.78>>
    //     //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue1.Code);
    //     //HEI.84>>
    //     //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
    //     //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue1.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
    //     //HEI.84<<
    //     //HEI.78<<
    //     EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
    //     EbfCombination.DeleteAll();
    //     PurchaseHeader.Reset();
    //     PurchaseHeader.SetRange("No.", PurchaseOrder."No.".Value);
    //     PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
    //     if PurchaseHeader.FindFirst() then begin
    //         PurchaseHeader.Validate("Shortcut Dimension 2 Code", DimensionValue1.Code);
    //         PurchaseHeader.Modify();
    //     end;
    //     //HEI.57<<
    //     PurchaseOrder.PurchLines.Dimensions.Invoke();
    //     // BC Upgrade BHARDA11 >>
    //     Workflow.Reset();
    //     Workflow.SetRange(Template, false);
    //     Workflow.SetRange(Category, 'PURCHDOC');
    //     Workflow.ModifyAll(Enabled, true);
    //     // BC Upgrade BHARDA11 >>
    //     //Disable Workflows before Release
    //     PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
    //     if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
    //         Workflow.SetRange(Enabled, true);
    //         //HEI.74>>
    //         if Workflow.FindFirst() then
    //             Workflow.ModifyAll(Enabled, false);
    //         //IF Workflow.FINDSET THEN
    //         //REPEAT
    //         //Workflow.Enabled := FALSE;
    //         //Workflow.MODIFY;
    //         //UNTIL Workflow.NEXT = 0;
    //         //HEI.74<<
    //     end;
    //     PurchaseOrder.Release.Invoke();

    //     // PurchaseOrder.Action149.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
    //     PurchaseOrder."Create &Whse. Receipt".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

    //     WarehouseReceipt.OpenView();
    //     WarehouseReceipt.Filter.SetFilter("Source No. FND", PurchaseOrder."No.".Value);

    //     //Store the PO No in warehouse receipt
    //     WhseRcptPONo := WarehouseReceipt."Source No.".Value;
    //     WhseDocNo := WarehouseReceipt."No.".value; // BC Upgrade BHARDA11
    //     // BC Upgrade BHARDA11 
    //     Reczone.reset;
    //     Reczone.setrange("Location Code", Location.code);
    //     reczone.findfirst();
    //     WhseEmpDTW.init();
    //     WhseEmpDTW."User ID" := userid;
    //     WhseEmpDTW."location Code" := Location.code;
    //     WhseEmpDTW."zone Code" := RecZone.Code;
    //     if WhseEmpDTW.insert() then;
    //     // error(Reczone.code);
    //     Bin.reset();
    //     Bin.SetRange("Zone Code", RecZone.code);
    //     bin.findfirst();
    //     WarEmployee.init();
    //     WarEmployee."User ID" := userid;
    //     waremployee."location Code" := Location.code;
    //     if WarEmployee.insert() then;
    //     WarRecLin.reset();
    //     WarRecLin.SetRange("No.", WhseDocNo);
    //     WarRecLin.findset();
    //     WarRecLin.Validate("Zone Code", RecZone.Code);
    //     WarRecLin.Validate("Bin Code", Bin.Code);
    //     WarRecLin.modify();

    //     // BC Upgrade BHARDA11 
    //     //Select Item Tracking Code
    //     WarehouseReceipt.WhseReceiptLines.ItemTrackingLines.Invoke();

    //     //Post The warehouse receipt
    //     WarehouseReceipt."Post Receipt".Invoke();
    //     PurchaseOrder.OK.Invoke();
    //     //PurchaseOrderList.OK.INVOKE;

    //     PurchRcptHdr.SetRange("Order No.", WhseRcptPONo);
    //     if PurchRcptHdr.FindFirst() then
    //         DocNo := PurchRcptHdr."No.";

    //     PurchaseInvoice.OPENNEW;

    //     PurchaseInvoice."No.".ASSISTEDIT;
    //     PurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");
    //     PurchaseInvoice."Document Date".SETVALUE(0D);
    //     //HEI.51>>
    //     if PurchasesPayablesSetup.Get() then
    //         if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
    //             PurchaseInvoice."Location Code".SETVALUE(Location.Code);
    //     //HEI.51<<
    //     ClearLastError();

    //     // ASSERTERROR PurchaseInvoice.Post.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
    //     asserterror PurchaseInvoice.Post_Custom.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name

    //     if GetLastErrorText <> STRSUBSTNO(DocDateError, PurchaseInvoice."No.") then
    //         Error('Unexpected Error: %1', GetLastErrorText);
    //     PurchaseInvoice."Document Date".SETVALUE(Today);
    //     if Vendor."Preferred Bank Account Code" = '' then //HEI.31
    //         PurchaseInvoice."Vendor Bank Account".SETVALUE(VendorBankAccount.Code);
    //     PrevCurrCode := '';
    //     PrevCurrCode := PurchaseInvoice."Currency Code".VALUE;
    //     CurrExChngRate.Reset();
    //     CurrExChngRate.SetFilter(CurrExChngRate."Currency Code", '<>%1', PrevCurrCode);
    //     CurrExChngRate.SetFilter(CurrExChngRate."Starting Date", '<=%1', Today);
    //     //HEI.113>>
    //     CurrExChngRate.SetFilter("Exchange Rate Amount", '<>0');
    //     //HEI.113<<
    //     if CurrExChngRate.FindLast() then
    //         PurchaseInvoice."Currency Code".SETVALUE(CurrExChngRate."Currency Code");
    //     PurchaseInvoice.PurchLines.GetReceiptLines.INVOKE;

    //     PurchaseInvoice."Currency Code".SETVALUE(PrevCurrCode);
    //     PurchaseInvoice.PurchLines.GetReceiptLines.INVOKE;

    //     PurchInvNo := PurchaseInvoice."No.".VALUE;

    //     PurchaseInvoice.PurchLines.FILTER.SETFILTER("No.", Item."No.");
    //     PurchaseInvoice.PurchLines.FILTER.SETFILTER("Type", 'Item');
    //     PurchaseInvoice.PurchLines.First();

    //     //HEI.29>>
    //     PurchLn.Reset();
    //     PurchLn.SETRANGE("Document No.", PurchaseInvoice."No.".VALUE);
    //     PurchLn.SETRANGE("No.", PurchaseInvoice.PurchLines."No.".VALUE);
    //     if PurchLn.FindFirst() then
    //         //HEI.29<<
    //         RecItem.Reset();
    //     RecItem.SETFILTER("No.", '<>%1', PurchaseInvoice.PurchLines."No.".VALUE);
    //     if RecItem.FindFirst() then begin
    //         ClearLastError();
    //         // Error('%1.', PurchaseInvoice.PurchLines.Type.Value);
    //         PurchaseInvoice.PurchLines.Type.SetValue('Item');
    //         asserterror PurchaseInvoice.PurchLines."No.".SETVALUE(RecItem."No.");
    //         if GetLastErrorText <> STRSUBSTNO(ItemNoError, PurchaseInvoice."No.", PurchLn."Line No.", PurchLn."Receipt No.") then
    //             Error('Unexpected Error: %1', GetLastErrorText);
    //     end;

    //     RecLocation.Reset();
    //     RecLocation.SETFILTER(Code, '<>%1', PurchaseInvoice.PurchLines."Location Code".VALUE);
    //     RecLocation.SetFilter("Warning Threshold Days FND", '<>%1', 0);
    //     if RecLocation.FindFirst() then begin
    //         asserterror PurchaseInvoice.PurchLines."Location Code".SETVALUE(RecLocation.Code);
    //         if GetLastErrorText <> STRSUBSTNO(LocationError, PurchaseInvoice."No.", PurchLn."Line No.", PurchLn."Receipt No.") then
    //             Error('Unexpected Error: %1', GetLastErrorText);
    //     end;
    //     asserterror PurchaseInvoice."Due Date".SETVALUE(0D);
    //     if GetLastErrorText <> DueDateError then
    //         Error('Unexpected Error: %1', GetLastErrorText);
    //     VATBusinessPostingGroup.Reset();
    //     VATBusinessPostingGroup.SETFILTER(Code, '<>%1', PurchaseInvoice."VAT Bus. Posting Group".VALUE);
    //     if VATBusinessPostingGroup.FindFirst() then
    //         PurchaseInvoice."VAT Bus. Posting Group".SETVALUE(VATBusinessPostingGroup.Code);
    //     PaymentTerms.Reset();
    //     PaymentTerms.SETFILTER(Code, '<>%1', PurchaseInvoice."Payment Terms Code".VALUE);
    //     if PaymentTerms.FindFirst() then begin
    //         asserterror PurchaseInvoice."Payment Terms Code".SETVALUE(PaymentTerms.Code);
    //         if GetLastErrorText <> PayTermError then
    //             Error('Unexpected Error: %1', GetLastErrorText);
    //     end;
    //     //IF VendorBankAccount."Country/Region Code"<>'' THEN BEGIN//HEI.56  //HEI.57
    //     if (VendorBankAccount."Country/Region Code" <> '') and (VendorBankAccount.IBAN <> '') then begin//HEI.57
    //         PaymentMethod.Reset();
    //         PaymentMethod.SETFILTER(Code, '<>%1', PurchaseInvoice."Payment Method Code".VALUE);
    //         if PaymentMethod.FindFirst() then begin
    //             asserterror PurchaseInvoice."Payment Method Code".SETVALUE(PaymentMethod.Code);
    //             if GetLastErrorText <> PayMetError then
    //                 Error('Unexpected Error: %1', GetLastErrorText);
    //         end;
    //     end;//HEI.56

    //     //HEI.23<<
    // end;

    // [ModalPageHandler]
    // procedure ErrorPageHandler(var ErrorMessages: TestPage "Error Messages");
    // begin
    //     ErrorMessages.Close();
    // end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler,MessageHandler,WhseRcptPageHandler,ItemTrackingLinesModalPageHandler,GetReceiptLineModalPageHandlerPTP056,DimSetEntriesModalPageHandler')]
    procedure PTP056_Negativetesting_PO_Invoice_VendorInvError();
    var
        Vendor: Record Vendor;
        Item: Record Item;
        Location: Record Location;
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        PostedPurchInvHdr: Record "Purch. Inv. Header";
        PostedPurchInv: TestPage "Posted Purchase Invoice";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        UserSetup2: Record "User Setup";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        DocDateError: TextConst ENU = 'Document Date must have a value in Purchase Header: Document Type=Invoice, No.=%1. It cannot be zero or empty.';
        PrevCurrCode: Code[10];
        CurrExChngRate: Record "Currency Exchange Rate";
        // VenInvError: TextConst ENU = 'Vendor Invoice No. must have a value in Purchase Header: Document Type=Invoice, No.=%1. It cannot be zero or empty.';
        VenInvError: label 'You need to enter the document number of the document from the vendor in the Vendor Invoice No. field, so that this document stays linked to the original.';
        ItemNoError: TextConst ENU = 'Validation error for Field: No.,  Message = ''Receipt No. must be equal to ''''  in Purchase Line: Document Type=Invoice, Document No.=%1, Line No.=%2. Current value is ''%3''.''';
        RecItem: Record Item;
        RecLocation: Record Location;
        LocationError: TextConst ENU = 'Validation error for Field: Location Code,  Message = ''Receipt No. must be equal to ''''  in Purchase Line: Document Type=Invoice, Document No.=%1, Line No.=%2. Current value is ''%3''.''';
        DueDateError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''You cannot modify the field- ''Due Date''.  (Select Refresh to discard errors)''';
        VATBusinessPostingGroup: Record "VAT Business Posting Group";
        PaymentMethod: Record "Payment Method";
        PayMetError: TextConst ENU = 'Validation error for Field: Payment Method Code,  Message = ''You cannot modify the field- ''Payment Method Code''.  (Select Refresh to discard errors)''';
        PaymentTerms: Record "Payment Terms";
        PayTermError: TextConst ENU = 'Validation error for Field: Payment Terms Code,  Message = ''You cannot modify the field- ''Payment Terms Code''.  (Select Refresh to discard errors)''';
        AmtError: Label 'Total amount (%1) is not equal to total of lines (%2)';
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DimensionValue1: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        Bin: Record Bin;
        PurchaseLine: Record "Purchase Line";
        Workflow: Record Workflow;
        RecZone: Record Zone;
        WhseEmpDTW: record 50356;
        WarRecLin: Record "Warehouse Receipt Line";
        WarEmployee: Record "Warehouse Employee";
        WhseDocNo: code[20];
        ErrorMesageHide: Codeunit "Error Message Hide TestScripts";
    begin
        DimensionRestrictionCheck(); //HEI.105
        //HEI.23>>
        WarehouseReceiptHeader.DeleteAll();//HEI.36
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::"Vendor Bank Account");
        VendorBankAccount.Get(Vendor."No.", UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::"Lot No. Information");
        LotNoFilter := UnitTestingValues.Value;

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);
        //HEI.61>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::Bin);
        Bin.Get(Location.Code, UnitTestingValues.Value);
        //HEI.61<<
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::"Dimension Value");
        GeneralLedgerSetup.Get();
        if UnitTestingValues.Value <> '' then //HEI.95
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 3 Code", UnitTestingValues.Value);
        PurchaseOrder.OpenNew();
        //PurchaseOrder.NEW;
        PurchaseOrder."No.".AssistEdit();
        PurchaseOrder."Buy-from Vendor No.".SetValue(Vendor."No.");
        PurchaseOrder."Vendor Invoice No.".SetValue('StP Unit Test PTP056');
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseOrder."Location Code".SetValue(Location.Code);
        //HEI.51<<
        PnPSetup.Get();
        if PnPSetup."Requester ID Mandatory FND" then; //BC UPGRADE KUMARR78 Adding Semicolon(;) to handle the sentence.
        // PurchaseOrder."Requester ID".SETVALUE(USERID);//BC UPGRADE KUMARR78 DIT Field Removed.
        PurchaseOrder.PurchLines.New();
        PurchaseOrder.PurchLines.Type.SetValue(Type::Item);
        PurchaseOrder.PurchLines."No.".SetValue(Item."No.");
        PurchaseOrder.PurchLines."Location Code".SetValue(Location.Code);
        PurchaseOrder.PurchLines.Quantity.SetValue(1);
        //HEI.57>>
        //HEI.61>>
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", PurchaseOrder."No.".Value);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("No.", PurchaseOrder.PurchLines."No.".Value);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Bin Code", Bin.Code);
            PurchaseLine.Modify();
        end;
        //HEI.61<<
        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::"Dimension Value");
        //HEI.95>>
        //IF UnitTestingValues.Value<>'' THEN
        if UnitTestingValues."Value 2" <> '' then
            //HEI.95<<
            DimensionValue1.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues."Value 2");
        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue1.Code);
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue1.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();
        PurchaseHeader.Reset();
        PurchaseHeader.SetRange("No.", PurchaseOrder."No.".Value);
        PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
        if PurchaseHeader.FindFirst() then begin
            PurchaseHeader.Validate("Shortcut Dimension 2 Code", DimensionValue1.Code);
            PurchaseHeader.Modify();
        end;
        //HEI.57<<
        PurchaseOrder.PurchLines.Dimensions.Invoke();
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            //IF Workflow.FINDSET THEN
            //REPEAT
            //Workflow.Enabled := FALSE;
            //Workflow.MODIFY;
            //UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;
        PurchaseOrder.Release.Invoke();
        // BC Upgrade BHARDA11 >> 
        Reczone.reset;
        Reczone.setrange("Location Code", Location.code);
        reczone.findfirst();
        WhseEmpDTW.init();
        WhseEmpDTW."User ID" := userid;
        WhseEmpDTW."location Code" := Location.code;
        WhseEmpDTW."zone Code" := RecZone.Code;
        if WhseEmpDTW.insert() then;
        // error(Reczone.code);
        Bin.reset();
        Bin.SetRange("Zone Code", RecZone.code);
        bin.findfirst();
        WarEmployee.init();
        WarEmployee."User ID" := userid;
        waremployee."location Code" := Location.code;
        if WarEmployee.insert() then;
        // BC Upgrade BHARDA11 <<
        // PurchaseOrder.Action149.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseOrder."Create &Whse. Receipt".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name
                                                       // rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
        WarehouseReceipt.OpenView();
        WarehouseReceipt.Filter.SetFilter("Source No. FND", PurchaseOrder."No.".Value);

        //Store the PO No in warehouse receipt
        WhseRcptPONo := WarehouseReceipt."Source No.".Value;
        WhseDocNo := WarehouseReceipt."No.".value; // BC Upgrade BHARDA11

        WarRecLin.reset();
        WarRecLin.SetRange("No.", WhseDocNo);
        WarRecLin.findset();
        WarRecLin.Validate("Zone Code", RecZone.Code);
        WarRecLin.Validate("Bin Code", Bin.Code);
        WarRecLin.modify();

        // BC Upgrade BHARDA11 
        //Select Item Tracking Code
        WarehouseReceipt.WhseReceiptLines.ItemTrackingLines.Invoke();

        //Post The warehouse receipt
        WarehouseReceipt."Post Receipt".Invoke();
        PurchaseOrder.OK.Invoke();
        //PurchaseOrderList.OK.INVOKE;

        PurchRcptHdr.SetRange("Order No.", WhseRcptPONo);
        if PurchRcptHdr.FindFirst() then
            DocNo := PurchRcptHdr."No.";

        PurchaseInvoice.OPENNEW;

        PurchaseInvoice."No.".ASSISTEDIT;
        PurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseInvoice."Location Code".SETVALUE(Location.Code);
        //HEI.51<<
        if Vendor."Preferred Bank Account Code" = '' then //HEI.31
            PurchaseInvoice."Vendor Bank Account".SETVALUE(VendorBankAccount.Code);
        PrevCurrCode := '';
        PrevCurrCode := PurchaseInvoice."Currency Code".VALUE;
        CurrExChngRate.Reset();
        CurrExChngRate.SetFilter(CurrExChngRate."Currency Code", '<>%1', PrevCurrCode);
        CurrExChngRate.SetFilter(CurrExChngRate."Starting Date", '<=%1', Today);
        //HEI.113>>

        // BC Upgrade MISHRS14 >> Added HEI.114 Tag
        // HEI.114 >> Blocked the below line as in NAV
        //CurrExChngRate.SetFilter("Exchange Rate Amount", '<>0');
        // HEI.114 <<

        //HEI.113<<
        //HEI.114>>
        //IF CurrExChngRate.FINDLAST THEN
        IF CurrExChngRate.FINDLAST THEN BEGIN
        IF CurrExChngRate."Exchange Rate Amount" = 0 THEN BEGIN
            CurrExChngRate."Exchange Rate Amount" := 1;
            CurrExChngRate.MODIFY(FALSE);
        END;
        //HEI.114<<
            PurchaseInvoice."Currency Code".SETVALUE(CurrExChngRate."Currency Code");
        // HEI.114
        end;
        // HEI.114
        // BC Upgrade MISHRS14 <<

        PurchaseInvoice.PurchLines.GetReceiptLines.INVOKE;

        PurchaseInvoice."Currency Code".SETVALUE(PrevCurrCode);
        PurchaseInvoice.PurchLines.GetReceiptLines.INVOKE;

        PurchInvNo := PurchaseInvoice."No.".VALUE;
        PurchasesPayablesSetup.Get();//HEI.30
        if PurchasesPayablesSetup."Ext. Doc. No. Mandatory" then begin//HEI.30

            // ASSERTERROR PurchaseInvoice.Post.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
            Clear(LastError);
            BindSubscription(ErrorMesageHide);
            PurchaseInvoice.Post_Custom.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name
            ErrorMesageHide.Run();
            LastError := ErrorMesageHide.ErrorMesage();
            UnbindSubscription(ErrorMesageHide);

            // LastError := GetLastErrorText;
            // if GetLastErrorText <> STRSUBSTNO(VenInvError, PurchaseInvoice."No.") then  // BC Upgrade BHARAD11 
            if LastError <> VenInvError then // BC Upgrade BHARAD11 
                Error('Unexpected Error: %1', GetLastErrorText);
            PurchaseInvoice."Vendor Invoice No.".SETVALUE('PTP056');
        end;//HEI.30
        //HEI.23<<
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler,MessageHandler,WhseRcptPageHandler,ItemTrackingLinesModalPageHandler,GetReceiptLineModalPageHandlerPTP056,DimSetEntriesModalPageHandler')]
    procedure PTP056_Negativetesting_PO_Invoice_VATAmtError();
    var
        Vendor: Record Vendor;
        Item: Record Item;
        Location: Record Location;
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        PostedPurchInvHdr: Record "Purch. Inv. Header";
        PostedPurchInv: TestPage "Posted Purchase Invoice";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        UserSetup2: Record "User Setup";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        DocDateError: TextConst ENU = 'Document Date must have a value in Purchase Header: Document Type=Invoice, No.=%1. It cannot be zero or empty.';
        PrevCurrCode: Code[10];
        CurrExChngRate: Record "Currency Exchange Rate";
        VenInvError: TextConst ENU = 'Vendor Invoice No. must have a value in Purchase Header: Document Type=Invoice, No.=%1. It cannot be zero or empty.';
        ItemNoError: TextConst ENU = 'Validation error for Field: No.,  Message = ''Receipt No. must be equal to ''''  in Purchase Line: Document Type=Invoice, Document No.=%1, Line No.=%2. Current value is ''%3''.''';
        RecItem: Record Item;
        RecLocation: Record Location;
        LocationError: TextConst ENU = 'Validation error for Field: Location Code,  Message = ''Receipt No. must be equal to ''''  in Purchase Line: Document Type=Invoice, Document No.=%1, Line No.=%2. Current value is ''%3''.''';
        DueDateError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''You cannot modify the field- ''Due Date''.  (Select Refresh to discard errors)''';
        VATBusinessPostingGroup: Record "VAT Business Posting Group";
        PaymentMethod: Record "Payment Method";
        PayMetError: TextConst ENU = 'Validation error for Field: Payment Method Code,  Message = ''You cannot modify the field- ''Payment Method Code''.  (Select Refresh to discard errors)''';
        PaymentTerms: Record "Payment Terms";
        PayTermError: TextConst ENU = 'Validation error for Field: Payment Terms Code,  Message = ''You cannot modify the field- ''Payment Terms Code''.  (Select Refresh to discard errors)''';
        AmtError: Label 'Total amount (%1) is not equal to total of lines (%2)';
        PurLineAmt: Decimal;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        PurchaseLine: Record "Purchase Line";
        RoundAmt: Boolean;
        DimensionValue1: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        Bin: Record Bin;
        Workflow: Record Workflow;
        RecZone: Record Zone;
        WhseEmpDTW: record 50356;
        WarRecLin: Record "Warehouse Receipt Line";
        WarEmployee: Record "Warehouse Employee";
        WhseDocNo: code[20];
        ErrorMesageHide: Codeunit "Error Message Hide TestScripts";
        checkLst: text;
    begin
        //mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
        DimensionRestrictionCheck(); //HEI.105
        //HEI.23>>
        WarehouseReceiptHeader.DeleteAll();//HEI.36
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::"Vendor Bank Account");
        VendorBankAccount.Get(Vendor."No.", UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::"Lot No. Information");
        LotNoFilter := UnitTestingValues.Value;

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);
        //HEI.61>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::Bin);
        Bin.Get(Location.Code, UnitTestingValues.Value);
        //HEI.61<<
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::"Dimension Value");
        GeneralLedgerSetup.Get();
        if UnitTestingValues.Value <> '' then //HEI.95
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 3 Code", UnitTestingValues.Value);
        PurchaseOrder.OpenNew();
        //PurchaseOrder.NEW;
        PurchaseOrder."No.".AssistEdit();
        PurchaseOrder."Buy-from Vendor No.".SetValue(Vendor."No.");
        PurchaseOrder."Vendor Invoice No.".SetValue('StP Unit Test PTP056');
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseOrder."Location Code".SetValue(Location.Code);
        //HEI.51<<
        PnPSetup.Get();
        if PnPSetup."Requester ID Mandatory FND" then //BC UPGRADE KUMARR78 Adding Semicolon(;) to handle the sentence.
            PurchaseOrder."Requester ID".SETVALUE(USERID);//BC UPGRADE KUMARR78 DIT Field Removed.

        PurchaseOrder.PurchLines.New();
        PurchaseOrder.PurchLines.Type.SetValue(Type::Item);
        PurchaseOrder.PurchLines."No.".SetValue(Item."No.");
        PurchaseOrder.PurchLines."Location Code".SetValue(Location.Code);
        PurchaseOrder.PurchLines.Quantity.SetValue(1);
        //HEI.31>>
        if PurchaseOrder.PurchLines."Line Amount".Value = '' then
            PurchaseOrder.PurchLines."Direct Unit Cost".SetValue(1);
        //HEI.31<<
        //HEI.57>>
        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP056', CompanyName, Database::"Dimension Value");
        //HEI.95>>
        //IF UnitTestingValues.Value<>'' THEN
        if UnitTestingValues."Value 2" <> '' then
            //HEI.95<<
            DimensionValue1.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues."Value 2");
        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue1.Code);
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue1.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();
        PurchaseHeader.Reset();
        PurchaseHeader.SetRange("No.", PurchaseOrder."No.".Value);
        PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
        if PurchaseHeader.FindFirst() then begin
            PurchaseHeader.Validate("Shortcut Dimension 2 Code", DimensionValue1.Code);
            PurchaseHeader.Modify();
        end;
        //HEI.57<<
        //HEI.61>>
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", PurchaseOrder."No.".Value);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("No.", PurchaseOrder.PurchLines."No.".Value);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Bin Code", Bin.Code);
            PurchaseLine.Modify();
        end;


        //HEI.61<<
        PurchaseOrder.PurchLines.Dimensions.Invoke();
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            //IF Workflow.FINDSET THEN
            //REPEAT
            //Workflow.Enabled := FALSE;
            //Workflow.MODIFY;
            //UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;
        PurchaseOrder.Release.Invoke();
        // BC Upgrade BHARDA11 >>
        // BC Upgrade BHARDA11 
        Reczone.reset;
        Reczone.setrange("Location Code", Location.code);
        reczone.findfirst();
        WhseEmpDTW.init();
        WhseEmpDTW."User ID" := userid;
        WhseEmpDTW."location Code" := Location.code;
        WhseEmpDTW."zone Code" := RecZone.Code;
        if WhseEmpDTW.insert() then;
        // error(Reczone.code);
        Bin.reset();
        Bin.SetRange("Zone Code", RecZone.code);
        bin.findfirst();
        WarEmployee.init();
        WarEmployee."User ID" := userid;
        waremployee."location Code" := Location.code;
        if WarEmployee.insert() then;
        // BC Upgrade BHARAD11 <<
        // PurchaseOrder.Action149.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseOrder."Create &Whse. Receipt".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

        WarehouseReceipt.OpenView();
        WarehouseReceipt.Filter.SetFilter("Source No. FND", PurchaseOrder."No.".Value);

        //Store the PO No in warehouse receipt
        WhseRcptPONo := WarehouseReceipt."Source No.".Value;
        WhseDocNo := WarehouseReceipt."No.".value; // BC Upgrade BHARDA11

        WarRecLin.reset();
        WarRecLin.SetRange("No.", WhseDocNo);
        WarRecLin.findset();
        WarRecLin.Validate("Zone Code", RecZone.Code);
        WarRecLin.Validate("Bin Code", Bin.Code);
        WarRecLin.modify();

        // BC Upgrade BHARDA11 
        //Select Item Tracking Code
        WarehouseReceipt.WhseReceiptLines.ItemTrackingLines.Invoke();

        //Post The warehouse receipt
        WarehouseReceipt."Post Receipt".Invoke();
        PurchaseOrder.OK.Invoke();
        //PurchaseOrderList.OK.INVOKE;

        PurchRcptHdr.SetRange("Order No.", WhseRcptPONo);
        if PurchRcptHdr.FindFirst() then
            DocNo := PurchRcptHdr."No.";

        PurchaseInvoice.OPENNEW;

        PurchaseInvoice."No.".ASSISTEDIT;
        PurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseInvoice."Location Code".SETVALUE(Location.Code);
        //HEI.51<<
        //PurchaseInvoice."Vendor Bank Account".SETVALUE(VendorBankAccount.Code);//HEI.31
        PrevCurrCode := '';
        PrevCurrCode := PurchaseInvoice."Currency Code".VALUE;
        CurrExChngRate.Reset();
        CurrExChngRate.SetFilter(CurrExChngRate."Currency Code", '<>%1', PrevCurrCode);
        CurrExChngRate.SetFilter(CurrExChngRate."Starting Date", '<=%1', Today);
        //HEI.113>>

        // BC Upgrade MISHRS14 >>
        // HEI.114 >> Blocked below line as in NAV
        //CurrExChngRate.SetFilter("Exchange Rate Amount", '<>0');
        // HEI.114 <<
        //HEI.113<<

        //HEI.114>>
        //IF CurrExChngRate.FINDLAST THEN
        IF CurrExChngRate.FINDLAST THEN BEGIN
        IF CurrExChngRate."Exchange Rate Amount" = 0 THEN BEGIN
            CurrExChngRate."Exchange Rate Amount" := 1;
            CurrExChngRate.MODIFY(FALSE);
        END;
        //HEI.114<<
            PurchaseInvoice."Currency Code".SETVALUE(CurrExChngRate."Currency Code");
        // HEI.114 >>
        end;
        // HEI.114 <<
        // BC Upgrade MISHRS14 <<

        PurchaseInvoice.PurchLines.GetReceiptLines.INVOKE;

        PurchaseInvoice."Currency Code".SETVALUE(PrevCurrCode);
        PurchaseInvoice.PurchLines.GetReceiptLines.INVOKE;

        PurchInvNo := PurchaseInvoice."No.".VALUE;

        PurchaseInvoice."Vendor Invoice No.".SETVALUE('PTP056A'); // BC Upgrade BHARAD11

        //BC UPGRADE KUMARR78 >> DIT Variable Removed. // BC Upgrade BHARDA11
        PurchaseInvoice."Doc. Amount Incl. VAT IBM".SETVALUE(0);
        PurchaseInvoice."Doc. Amount VAT IBM".SETVALUE(0);
        //BC UPGRADE KUMARR78 << DIT Variable Removed. / BC Upgrade BHARDA11 

        //HEI.56>>
        RoundAmt := false;
        if CompanyName <> '10_KISANGANI' then
            RoundAmt := true;
        if CompanyName <> '10_BRASSIVOIRE' then
            RoundAmt := true;
        //HEI.56<<
        //HEI.30>>
        GeneralLedgerSetup.Get();
        if (GeneralLedgerSetup."Inv. Rounding Precision (LCY)" = 1) and (PurchaseInvoice."Currency Code".VALUE = '') then begin
            EVALUATE(PurLineAmt, PurchaseInvoice.PurchLines."Total Amount Incl. VAT".VALUE);
            PurLineAmt := Round(PurLineAmt, 1, '<');
            if RoundAmt = false then begin//HEI.56\

                // ASSERTERROR PurchaseInvoice.Post.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
                asserterror PurchaseInvoice.Post_Custom.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name


                //BC UPGRADE KUMARR78 >> DIT Variable Removed.
                IF GETLASTERRORTEXT <> STRSUBSTNO(AmtError, PurchaseInvoice."Doc. Amount Incl. VAT IBM".VALUE, PurLineAmt) THEN // BC Upgrade BHARDA11 --
                    ERROR('Unexpected Error: %1', GETLASTERRORTEXT);
                //BC UPGRADE KUMARR78 << DIT Variable Removed.
            end;//HEI.56
        end else begin
            //HEI.30<<

            // ASSERTERROR PurchaseInvoice.Post.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
            Clear(LastError);
            BindSubscription(ErrorMesageHide);
            // asserterror PurchaseInvoice.Post_Custom.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name
            PurchaseInvoice.Post_Custom.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name
            ErrorMesageHide.Run();
            LastError := ErrorMesageHide.ErrorMesage();
            UnbindSubscription(ErrorMesageHide);

            //BC UPGRADE KUMARR78 >> DIT Variable Removed.
            // Clear(LastError);
            // lasterror := GetLastErrorText;
            // IF GETLASTERRORTEXT <> STRSUBSTNO(AmtError, PurchaseInvoice."Doc. Amount Incl. VAT IBM".VALUE, PurchaseInvoice.PurchLines."Total Amount Incl. VAT") THEN
            checkLst := STRSUBSTNO(AmtError, Format(PurchaseInvoice."Doc. Amount Incl. VAT IBM".VALUE), PurchaseInvoice.PurchLines."Total Amount Incl. VAT");
            if PurchaseInvoice."Doc. Amount Incl. VAT IBM".VALUE = '0.00' then
                IF lasterror <> STRSUBSTNO(AmtError, 0, PurchaseInvoice.PurchLines."Total Amount Incl. VAT") THEN
                    // IF lasterror <> STRSUBSTNO(AmtError, PurchaseInvoice."Doc. Amount Incl. VAT IBM".VALUE, PurchaseInvoice.PurchLines."Total Amount Incl. VAT") THEN
                        ERROR('Unexpected Error: %1', GETLASTERRORTEXT);
            //BC UPGRADE KUMARR78 << DIT Variable Removed.
        end;//HEI.30
        //HEI.23<<
    end;

    [ModalPageHandler]
    procedure GetReceiptLineModalPageHandlerPTP056(var GetReceiptLines: TestPage "Get Receipt Lines");
    var
        Vendor: Record Vendor;
        PurchaseReceiptLine: Record "Purch. Rcpt. Line";
    begin
        //HEI.23>>
        GetReceiptLines.Filter.SetFilter("Document No.", DocNo);
        if GetReceiptLines."Document No.".Value = DocNo then
            GetReceiptLines.OK.Invoke()
        else
            GetReceiptLines.Cancel.Invoke();
        //HEI.23<<
    end;

    [Test]
    // [HandlerFunctions('ConfirmationHandler')] // BC Upgrade BHARAD11 -- No Use
    procedure PTP057_Negative_NPO_CN_DocDateERROR();
    var
        NPOPurchaseCreditMemosList: TestPage "NPO Purchase Credit Memos";
        Vendor: Record Vendor;
        NPOPurchaseCreditMemo: TestPage "NPO Purchase Credit Memo";
        GLAccount: Record "G/L Account";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        VATProductPostingGroup: Record "VAT Product Posting Group";
        // DateChangeError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''You cannot modify the field- ''Due Date''.  (Select Refresh to discard errors)''';
        DateChangeError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''"You cannot modify the field- ''Due Date''. " (Select Refresh to discard errors)'''; // BC Upgrade BHARDA11'
        PaymentMethodCodeError: TextConst ENU = 'Validation error for Field: Payment Method Code,  Message = ''You cannot modify the field- ''Payment Method Code''.  (Select Refresh to discard errors)''';
        DocNo: Text;
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PostedPurchaseCreditMemos: TestPage "Posted Purchase Credit Memos";
        PostedCrNo: Text;
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        PurchaseHeader: Record "Purchase Header";
        WHTBusinessPostingGroup: Record "WHT Business Posting Group FND";
        PaymentTermCodeError: TextConst ENU = 'Validation error for Field: Payment Terms Code,  Message = ''You cannot modify the field- ''Payment Terms Code''.  (Select Refresh to discard errors)''';
        DocDateError: TextConst ENU = 'Document Date must have a value in Purchase Header: Document Type=Credit Memo, No.=%1. It cannot be zero or empty.';
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        PurchaseLine: Record "Purchase Line";
        NPOCRMemoNo: Text;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Location: Record Location;
        ErrorMesageHide: Codeunit "Error Message Hide TestScripts";
    begin
        DimensionRestrictionCheck; //HEI.95
        //HEI.23>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::"WHT Business Posting Group FND");
        WHTBusinessPostingGroup.Get(UnitTestingValues.Value);
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::"G/L Account");
        GLAccount.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::"VAT Product Posting Group");
        VATProductPostingGroup.Get(UnitTestingValues.Value);

        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::"Dimension Value");
        if UnitTestingValues.Value <> '' then
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);

        NPOPurchaseCreditMemo.OPENNEW;
        NPOPurchaseCreditMemo."Buy-from Vendor Name".SETVALUE(Vendor.Name);
        NPOPurchaseCreditMemo."Vendor Cr. Memo No.".SETVALUE('PTP057');
        //HEI.51>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                NPOPurchaseCreditMemo."Location Code".SETVALUE(Location.Code);
        //HEI.51<<
        if Vendor."Preferred Bank Account Code" = '' then //HEI.31
            NPOPurchaseCreditMemo."Payment Method Code".SETVALUE(Vendor."Payment Method Code");
        NPOPurchaseCreditMemo."Payment Terms Code".SETVALUE(Vendor."Payment Terms Code");
        NPOPurchaseCreditMemo."Document Date".SETVALUE(0D);

        // ASSERTERROR NPOPurchaseCreditMemo.Post.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        asserterror NPOPurchaseCreditMemo.Post_Cust.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name

        if GetLastErrorText <> STRSUBSTNO(DocDateError, NPOPurchaseCreditMemo."No.".VALUE) then
            Error('Unexpected Error: %1', GetLastErrorText);
        NPOPurchaseCreditMemo.PurchLines.Type.SETVALUE(Type::"G/L Account");
        NPOPurchaseCreditMemo.PurchLines."No.".SETVALUE(GLAccount."No.");
        NPOPurchaseCreditMemo.PurchLines.Quantity.SETVALUE(1);
        NPOPurchaseCreditMemo.PurchLines."Direct Unit Cost".SETVALUE(100);
        //HEI.30>>
        //NPOPurchaseCreditMemo.PurchLines."VAT Prod. Posting Group".SETVALUE(VATProductPostingGroup.Code);
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::"Credit Memo");
        PurchaseLine.SETRANGE("Document No.", NPOPurchaseCreditMemo."No.".VALUE);
        PurchaseLine.SETRANGE("No.", NPOPurchaseCreditMemo.PurchLines."No.".VALUE);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("VAT Prod. Posting Group", VATProductPostingGroup.Code);
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
            PurchaseLine.Modify();
        end;
        Clear(NPOCRMemoNo);
        NPOCRMemoNo := NPOPurchaseCreditMemo."No.".VALUE;
        NPOPurchaseCreditMemo.CLOSE;
        NPOPurchaseCreditMemo.OPENEDIT;
        NPOPurchaseCreditMemo.FILTER.SETFILTER("No.", NPOCRMemoNo);
        //HEI.30<<
        NPOPurchaseCreditMemo.PurchLines."WHT Business Posting Group".SETVALUE(WHTBusinessPostingGroup.Code);
        //NPOPurchaseCreditMemo.PurchLines."Shortcut Dimension 2 Code".SETVALUE(DimensionValue.Code);//HEI.30
        //BC UPGRADE ATHUKS01 STP_FDD0007 >>
        NPOPurchaseCreditMemo."Doc. Amount Incl. VAT IBM".SETVALUE(NPOPurchaseCreditMemo.PurchLines."Total Amount Incl. VAT".VALUE);
        NPOPurchaseCreditMemo."Doc. Amount VAT IBM".SETVALUE(NPOPurchaseCreditMemo.PurchLines."Total VAT Amount".VALUE);
        ///BC UPGRADE ATHUKS01 STP_FDD0007 <<
        // ASSERTERROR NPOPurchaseCreditMemo."Due Date".SETVALUE(091022D);//BC UPGRADE KUMARR78 Blocking to Rewritting Date forma
        Clear(LastError);
        // BindSubscription(ErrorMesageHide);
        asserterror NPOPurchaseCreditMemo."Due Date".SETVALUE(20220910D);//BC UPGRADE KUMARR78 Adding As Rewritting Date format.                                                              //   PurchaseInvoice.Post_Custom.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name
        // ErrorMesageHide.Run();
        LastError := GetLastErrorText;
        // UnbindSubscription(ErrorMesageHide);
        if GetLastErrorText <> DateChangeError then
            Error('Unexpected Error: %1', GetLastErrorText);//Abhay

        //HEI.23<<
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler')]
    procedure PTP057_Negative_NPO_CN_VendCrNoError();
    var
        NPOPurchaseCreditMemosList: TestPage "NPO Purchase Credit Memos";
        Vendor: Record Vendor;
        NPOPurchaseCreditMemo: TestPage "NPO Purchase Credit Memo";
        GLAccount: Record "G/L Account";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        VATProductPostingGroup: Record "VAT Product Posting Group";
        // DateChangeError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''You cannot modify the field- ''Due Date''.  (Select Refresh to discard errors)''';
        DateChangeError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''"You cannot modify the field- ''Due Date''. " (Select Refresh to discard errors)'''; // BC Upgrade BHARDA11
        PaymentMethodCodeError: TextConst ENU = 'Validation error for Field: Payment Method Code,  Message = ''You cannot modify the field- ''Payment Method Code''.  (Select Refresh to discard errors)''';
        DocNo: Text;
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PostedPurchaseCreditMemos: TestPage "Posted Purchase Credit Memos";
        PostedCrNo: Text;
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        PurchaseHeader: Record "Purchase Header";
        WHTBusinessPostingGroup: Record "WHT Business Posting Group FND";
        PaymentTermCodeError: TextConst ENU = 'Validation error for Field: Payment Terms Code,  Message = ''You cannot modify the field- ''Payment Terms Code''.  (Select Refresh to discard errors)''';
        DocDateError: TextConst ENU = 'Document Date must have a value in Purchase Header: Document Type=Credit Memo, No.=%1. It cannot be zero or empty.';
        // VenCrError: TextConst ENU = 'Vendor Cr. Memo No. must have a value in Purchase Header: Document Type=Credit Memo, No.=%1. It cannot be zero or empty.';
        VenCrError: TextConst ENU = 'You need to enter the document number of the document from the vendor in the Vendor Cr. Memo No. field, so that this document stays linked to the original.';
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        PurchaseLine: Record "Purchase Line";
        NPOCRMemoNo: Text;
        Location: Record Location;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DefaultDimension: Record "Default Dimension";
        ErrorMesageHide: Codeunit "Error Message Hide TestScripts";
        CheckError: text;
    begin
        DimensionRestrictionCheck; //HEI.95
        //HEI.23>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::"WHT Business Posting Group FND");
        WHTBusinessPostingGroup.Get(UnitTestingValues.Value);
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::"G/L Account");
        GLAccount.Get(UnitTestingValues.Value);
        //HEI.53>>
        if DefaultDimension.Get(15, GLAccount."No.", 'TRD_PART') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;
        //HEI.53<<
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::"VAT Product Posting Group");
        if UnitTestingValues.Value <> '' then //HEI.95
            VATProductPostingGroup.Get(UnitTestingValues.Value);

        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::"Dimension Value");
        if UnitTestingValues.Value <> '' then
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);
        //HEI.55>>
        if DefaultDimension.Get(15, GLAccount."No.", 'BRAND') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;
        //HEI.55<<
        NPOPurchaseCreditMemo.OPENNEW;
        NPOPurchaseCreditMemo."Buy-from Vendor Name".SETVALUE(Vendor.Name);
        //HEI.51>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                NPOPurchaseCreditMemo."Location Code".SETVALUE(Location.Code);
        //HEI.51<<
        if Vendor."Preferred Bank Account Code" = '' then //HEI.31
            NPOPurchaseCreditMemo."Payment Method Code".SETVALUE(Vendor."Payment Method Code");
        NPOPurchaseCreditMemo."Payment Terms Code".SETVALUE(Vendor."Payment Terms Code");

        NPOPurchaseCreditMemo."Vendor Cr. Memo No.".SETVALUE('PTP057');
        NPOPurchaseCreditMemo.PurchLines.Type.SETVALUE(Type::"G/L Account");
        NPOPurchaseCreditMemo.PurchLines."No.".SETVALUE(GLAccount."No.");
        NPOPurchaseCreditMemo.PurchLines.Quantity.SETVALUE(1);
        NPOPurchaseCreditMemo.PurchLines."Direct Unit Cost".SETVALUE(100);
        //HEI.30>>
        //NPOPurchaseCreditMemo.PurchLines."VAT Prod. Posting Group".SETVALUE(VATProductPostingGroup.Code);
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::"Credit Memo");
        PurchaseLine.SETRANGE("Document No.", NPOPurchaseCreditMemo."No.".VALUE);
        PurchaseLine.SETRANGE("No.", NPOPurchaseCreditMemo.PurchLines."No.".VALUE);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("VAT Prod. Posting Group", VATProductPostingGroup.Code);
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
            PurchaseLine.Modify();
        end;
        Clear(NPOCRMemoNo);
        NPOCRMemoNo := NPOPurchaseCreditMemo."No.".VALUE;
        NPOPurchaseCreditMemo.CLOSE;
        NPOPurchaseCreditMemo.OPENEDIT; // 1111111111111111111111111111111111111111111111111111
        NPOPurchaseCreditMemo.FILTER.SETFILTER("No.", NPOCRMemoNo);
        //HEI.30<<
        NPOPurchaseCreditMemo.PurchLines."WHT Business Posting Group".SETVALUE(WHTBusinessPostingGroup.Code);
        //NPOPurchaseCreditMemo.PurchLines."Shortcut Dimension 2 Code".SETVALUE(DimensionValue.Code);//HEI.30
        //BC UPGRADE ATHUKS01 STP_FDD0007 >>
        NPOPurchaseCreditMemo."Doc. Amount Incl. VAT IBM".SETVALUE(NPOPurchaseCreditMemo.PurchLines."Total Amount Incl. VAT".VALUE);
        NPOPurchaseCreditMemo."Doc. Amount VAT IBM".SETVALUE(NPOPurchaseCreditMemo.PurchLines."Total VAT Amount".VALUE);
        ///BC UPGRADE ATHUKS01 STP_FDD0007 <<
        NPOPurchaseCreditMemo."Vendor Cr. Memo No.".SETVALUE('');

        // ASSERTERROR NPOPurchaseCreditMemo.Post.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        // asserterror NPOPurchaseCreditMemo.Post_Cust.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name
        Clear(LastError);
        BindSubscription(ErrorMesageHide);
        NPOPurchaseCreditMemo.Post_Cust.INVOKE;
        ErrorMesageHide.Run();
        LastError := ErrorMesageHide.ErrorMesage();
        UnbindSubscription(ErrorMesageHide);
        Clear(CheckError);
        CheckError := STRSUBSTNO(VenCrError, NPOPurchaseCreditMemo."No.".VALUE);
        // if GetLastErrorText <> STRSUBSTNO(VenCrError, NPOPurchaseCreditMemo."No.".VALUE) then
        if LastError <> STRSUBSTNO(VenCrError, NPOPurchaseCreditMemo."No.".VALUE) then
            Error('Unexpected Error: %1', GetLastErrorText);//Abhay
        // ASSERTERROR NPOPurchaseCreditMemo."Due Date".SETVALUE(091022D);//BC UPGRADE KUMARR78 Blocking to Rewritting Date format.
        NPOPurchaseCreditMemo.Reopen.Invoke();
        asserterror NPOPurchaseCreditMemo."Due Date".SETVALUE(20220910D);//BC UPGRADE KUMARR78 Adding As Rewritting Date format.
        Clear(lasterror);
        lasterror := GetLastErrorText;
        if GetLastErrorText <> DateChangeError then
            Error('Unexpected Error: %1', GetLastErrorText);
        //HEI.23<<
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler')]
    procedure PTP057_Negative_NPO_CN_VATAmtError();
    var
        NPOPurchaseCreditMemosList: TestPage "NPO Purchase Credit Memos";
        Vendor: Record Vendor;
        NPOPurchaseCreditMemo: TestPage "NPO Purchase Credit Memo";
        GLAccount: Record "G/L Account";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        VATProductPostingGroup: Record "VAT Product Posting Group";
        DateChangeError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''You cannot modify the field- ''Due Date''.  (Select Refresh to discard errors)''';
        PaymentMethodCodeError: TextConst ENU = 'Validation error for Field: Payment Method Code,  Message = ''You cannot modify the field- ''Payment Method Code''.  (Select Refresh to discard errors)''';
        DocNo: Text;
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PostedPurchaseCreditMemos: TestPage "Posted Purchase Credit Memos";
        PostedCrNo: Text;
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        PurchaseHeader: Record "Purchase Header";
        WHTBusinessPostingGroup: Record "WHT Business Posting Group FND";
        // PaymentTermCodeError: TextConst ENU = 'Validation error for Field: Payment Terms Code,  Message = ''You cannot modify the field- ''Payment Terms Code''.  (Select Refresh to discard errors)''';
        PaymentTermCodeError: TextConst ENU = 'Validation error for Field: Payment Terms Code,  Message = ''"You cannot modify the field- ''Payment Terms Code''. " (Select Refresh to discard errors)''';
        DocDateError: TextConst ENU = 'Document Date must have a value in Purchase Header: Document Type=Credit Memo, No.=%1. It cannot be zero or empty.';
        VATAmtError: Label 'Total amount (%1) is not equal to total of lines (%2)';
        TypeError: TextConst ENU = 'Validation error for Field: Type,  Message = ''You are not allow to insert lines with type Item''';
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        PurchaseLine: Record "Purchase Line";
        NPOCRMemoNo: Text;
        Location: Record Location;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DefaultDimension: Record "Default Dimension";
        NoSeriesLine: Record "No. Series Line";
        ErrorMesageHide: Codeunit "Error Message Hide TestScripts";
        CheckError: text;
    begin
        DimensionRestrictionCheck; //HEI.95
        //HEI.59>>
        if PurchasesPayablesSetup.Get() then
            NoSeriesLine.Reset();
        NoSeriesLine.SetRange("Series Code", PurchasesPayablesSetup."Posted Credit Memo Nos.");
        NoSeriesLine.SetFilter("Last Date Used", '>%1', Today);
        if NoSeriesLine.FindFirst() then begin
            NoSeriesLine."Last Date Used" := Today;
            NoSeriesLine.Modify();
        end;
        //HEI.59<<
        //HEI.23>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::"WHT Business Posting Group FND");
        WHTBusinessPostingGroup.Get(UnitTestingValues.Value);
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::"G/L Account");
        GLAccount.Get(UnitTestingValues.Value);
        //HEI.53>>
        if DefaultDimension.Get(15, GLAccount."No.", 'TRD_PART') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;
        //HEI.53<<
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::"VAT Product Posting Group");
        VATProductPostingGroup.Get(UnitTestingValues.Value);

        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::"Dimension Value");
        if UnitTestingValues.Value <> '' then
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);
        //HEI.55>>
        if DefaultDimension.Get(15, GLAccount."No.", 'BRAND') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;
        //HEI.55<<
        NPOPurchaseCreditMemo.OPENNEW;
        NPOPurchaseCreditMemo."Buy-from Vendor Name".SETVALUE(Vendor.Name);
        NPOPurchaseCreditMemo."Vendor Cr. Memo No.".SETVALUE('PTP057');
        //HEI.51>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                NPOPurchaseCreditMemo."Location Code".SETVALUE(Location.Code);
        //HEI.51<<
        if Vendor."Preferred Bank Account Code" = '' then //HEI.31
            NPOPurchaseCreditMemo."Payment Method Code".SETVALUE(Vendor."Payment Method Code");
        NPOPurchaseCreditMemo."Payment Terms Code".SETVALUE(Vendor."Payment Terms Code");
        NPOPurchaseCreditMemo.PurchLines.Type.SETVALUE(Type::"G/L Account");
        NPOPurchaseCreditMemo.PurchLines."No.".SETVALUE(GLAccount."No.");
        NPOPurchaseCreditMemo.PurchLines.Quantity.SETVALUE(1);
        NPOPurchaseCreditMemo.PurchLines."Direct Unit Cost".SETVALUE(100);
        //HEI.30>>
        //NPOPurchaseCreditMemo.PurchLines."VAT Prod. Posting Group".SETVALUE(VATProductPostingGroup.Code);
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::"Credit Memo");
        PurchaseLine.SETRANGE("Document No.", NPOPurchaseCreditMemo."No.".VALUE);
        PurchaseLine.SETRANGE("No.", NPOPurchaseCreditMemo.PurchLines."No.".VALUE);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("VAT Prod. Posting Group", VATProductPostingGroup.Code);
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
            PurchaseLine.Modify();
        end;
        Clear(NPOCRMemoNo);
        NPOCRMemoNo := NPOPurchaseCreditMemo."No.".VALUE;
        NPOPurchaseCreditMemo.CLOSE;
        NPOPurchaseCreditMemo.OPENEDIT;
        NPOPurchaseCreditMemo.FILTER.SETFILTER("No.", NPOCRMemoNo);
        //HEI.30<<
        NPOPurchaseCreditMemo.PurchLines."WHT Business Posting Group".SETVALUE(WHTBusinessPostingGroup.Code);
        //NPOPurchaseCreditMemo.PurchLines."Shortcut Dimension 2 Code".SETVALUE(DimensionValue.Code);//HEI.30
        //BC UPGRADE ATHUKS01 STP_FDD0007>>
        NPOPurchaseCreditMemo."Doc. Amount Incl. VAT IBM".SETVALUE(0);
        NPOPurchaseCreditMemo."Doc. Amount VAT IBM".SETVALUE(0);
        //BC UPGRADE ATHUKS01 STP_FDD0007<<
        // ASSERTERROR NPOPurchaseCreditMemo.Post.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        // BC Upgrade BHARDA11 >>
        // asserterror NPOPurchaseCreditMemo.Post_Cust.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name
        Clear(LastError);
        BindSubscription(ErrorMesageHide);
        NPOPurchaseCreditMemo.Post_Cust.INVOKE;
        ErrorMesageHide.Run();
        LastError := ErrorMesageHide.ErrorMesage();
        UnbindSubscription(ErrorMesageHide);
        CheckError := STRSUBSTNO(VATAmtError, NPOPurchaseCreditMemo."Doc. Amount Incl. VAT IBM".VALUE, NPOPurchaseCreditMemo.PurchLines."Total Amount Incl. VAT");
        Clear(CheckError);
        CheckError := STRSUBSTNO(VATAmtError, 0, NPOPurchaseCreditMemo.PurchLines."Total Amount Incl. VAT");
        if NPOPurchaseCreditMemo."Doc. Amount Incl. VAT IBM".VALUE = '0.00' then
            // if GetLastErrorText <> STRSUBSTNO(VATAmtError, NPOPurchaseCreditMemo."Doc. Amount Incl. VAT IBM".VALUE, NPOPurchaseCreditMemo.PurchLines."Total Amount Incl. VAT") then
            if LastError <> STRSUBSTNO(VATAmtError, 0, NPOPurchaseCreditMemo.PurchLines."Total Amount Incl. VAT") then
                Error('Unexpected Error: %1', GetLastErrorText);//Abhay
                                                                // BC Upgrade BHARAD11 >>
                                                                // if NPOPurchaseCreditMemo.Status.Value = '1' then
        NPOPurchaseCreditMemo.Reopen.Invoke();

        // BC Upgrade BHARAD11 <<
        NPOPurchaseCreditMemo."Doc. Amount Incl. VAT IBM".SETVALUE(NPOPurchaseCreditMemo.PurchLines."Total Amount Incl. VAT".VALUE);
        NPOPurchaseCreditMemo."Doc. Amount VAT IBM".SETVALUE(NPOPurchaseCreditMemo.PurchLines."Total VAT Amount".VALUE);
        if Vendor."Preferred Bank Account Code" = '' then begin //HEI.31
            asserterror NPOPurchaseCreditMemo."Payment Method Code".SETVALUE('');
            Clear(LastError);
            LastError := GetLastErrorText;
            if GetLastErrorText <> PaymentMethodCodeError then
                Error('Unexpected Error: %1', GetLastErrorText);
        end;//HEI.31
        asserterror NPOPurchaseCreditMemo."Payment Terms Code".SETVALUE('');
        Clear(LastError);
        LastError := GetLastErrorText;
        if GetLastErrorText <> PaymentTermCodeError then
            Error('Unexpected Error: %1', GetLastErrorText);
        //HEI.23<<
    end;

    [Test]
    procedure PTP057_Negative_NPO_CN_LinesError();
    var
        NPOPurchaseCreditMemosList: TestPage "NPO Purchase Credit Memos";
        Vendor: Record Vendor;
        NPOPurchaseCreditMemo: TestPage "NPO Purchase Credit Memo";
        GLAccount: Record "G/L Account";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        VATProductPostingGroup: Record "VAT Product Posting Group";
        DateChangeError: TextConst ENU = 'Validation error for Field: Due Date,  Message = ''You cannot modify the field- ''Due Date''.  (Select Refresh to discard errors)''';
        PaymentMethodCodeError: TextConst ENU = 'Validation error for Field: Payment Method Code,  Message = ''You cannot modify the field- ''Payment Method Code''.  (Select Refresh to discard errors)''';
        DocNo: Text;
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PostedPurchaseCreditMemos: TestPage "Posted Purchase Credit Memos";
        PostedCrNo: Text;
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        PurchaseHeader: Record "Purchase Header";
        WHTBusinessPostingGroup: Record "WHT Business Posting Group FND";
        PaymentTermCodeError: TextConst ENU = 'Validation error for Field: Payment Terms Code,  Message = ''You cannot modify the field- ''Payment Terms Code''.  (Select Refresh to discard errors)''';
        DocDateError: TextConst ENU = 'Document Date must have a value in Purchase Header: Document Type=Credit Memo, No.=%1. It cannot be zero or empty.';
        VATAmtError: Label 'Total amount (%1) is not equal to total of lines (%2)';
        TypeError: TextConst ENU = 'Validation error for Field: Type,  Message = ''You are not allow to insert lines with type Item''';
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        PurchaseLine: Record "Purchase Line";
        NPOCRMemoNo: Text;
    begin
        //HEI.23>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::"WHT Business Posting Group FND");
        WHTBusinessPostingGroup.Get(UnitTestingValues.Value);
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::"G/L Account");
        GLAccount.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::"VAT Product Posting Group");
        VATProductPostingGroup.Get(UnitTestingValues.Value);

        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP057', CompanyName, Database::"Dimension Value");
        if UnitTestingValues.Value <> '' then
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);

        NPOPurchaseCreditMemo.OPENNEW;
        NPOPurchaseCreditMemo."Buy-from Vendor Name".SETVALUE(Vendor.Name);
        NPOPurchaseCreditMemo."Vendor Cr. Memo No.".SETVALUE('PTP057');
        if Vendor."Preferred Bank Account Code" = '' then //HEI.31
            NPOPurchaseCreditMemo."Payment Method Code".SETVALUE(Vendor."Payment Method Code");
        NPOPurchaseCreditMemo."Payment Terms Code".SETVALUE(Vendor."Payment Terms Code");
        NPOPurchaseCreditMemo.PurchLines.Type.SETVALUE(Type::"G/L Account");
        NPOPurchaseCreditMemo.PurchLines."No.".SETVALUE(GLAccount."No.");
        NPOPurchaseCreditMemo.PurchLines.Quantity.SETVALUE(1);
        NPOPurchaseCreditMemo.PurchLines."Direct Unit Cost".SETVALUE(100);
        //HEI.30>>
        //NPOPurchaseCreditMemo.PurchLines."VAT Prod. Posting Group".SETVALUE(VATProductPostingGroup.Code);
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::"Credit Memo");
        PurchaseLine.SETRANGE("Document No.", NPOPurchaseCreditMemo."No.".VALUE);
        PurchaseLine.SETRANGE("No.", NPOPurchaseCreditMemo.PurchLines."No.".VALUE);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("VAT Prod. Posting Group", VATProductPostingGroup.Code);
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
            PurchaseLine.Modify();
        end;
        //HEI.30<<
        NPOPurchaseCreditMemo.PurchLines."WHT Business Posting Group".SETVALUE(WHTBusinessPostingGroup.Code);
        //NPOPurchaseCreditMemo.PurchLines."Shortcut Dimension 2 Code".SETVALUE(DimensionValue.Code);//HEI.30
        //BC UPGRADE ATHUKS01 STP_FDD0007>>
        NPOPurchaseCreditMemo."Doc. Amount Incl. VAT IBM".SETVALUE(NPOPurchaseCreditMemo.PurchLines."Total Amount Incl. VAT".VALUE);
        NPOPurchaseCreditMemo."Doc. Amount VAT IBM".SETVALUE(NPOPurchaseCreditMemo.PurchLines."Total VAT Amount".VALUE);
        //BC UPGRADE ATHUKS01 STP_FDD0007<<

        asserterror NPOPurchaseCreditMemo.PurchLines.Type.SETVALUE(Type::Item);
        if GetLastErrorText <> TypeError then
            Error('Unexpected Error: %1', GetLastErrorText);
        //HEI.23<<
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,MessageHandler,ApplyVendorLedModalPageHandler,DimSetEntriesModalPageHandlerPTP133')]
    procedure PTP082_Process_PtP_Netting();
    var
        Vendor: Record Vendor;
        Item: Record Item;
        GenJnlTable: Record "Gen. Journal Line";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnl: TestPage "General Journal";
        GenJournalLine: Record "Gen. Journal Line";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        Workflow: Record Workflow;
        gGenJnlBatches: Record "Gen. Journal Batch";
    begin
        DimensionRestrictionCheck; //HEI.102
        //HEI.23>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP082', CompanyName, Database::Vendor);
        gVendor.Get(UnitTestingValues.Value);

        //HEI.71>>
        VendorLedgerEntry.Reset();
        VendorLedgerEntry.SetCurrentKey("Vendor No.", Open, Positive, "Due Date", "Currency Code");
        VendorLedgerEntry.SetRange("Vendor No.", gVendor."No.");
        VendorLedgerEntry.SetRange(Open, true);
        if VendorLedgerEntry.FindFirst() then begin
            gVendor."Vendor Posting Group" := VendorLedgerEntry."Vendor Posting Group";
            gVendor.Modify();
        end;
        //HEI.71<<

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP082', CompanyName, Database::"Dimension Value");
        MVMTDimension := UnitTestingValues.Value;


        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP082', CompanyName, Database::"Gen. Journal Batch");
        gGenJnlBatches.Get(UnitTestingValues.Value, UnitTestingValues."Value 2");
        Clear(ScriptNo);
        ScriptNo := UnitTestingValues."Test Script Code";
        Workflow.Reset();
        Workflow.SetRange(Enabled, true);
        //HEI.74>>
        if Workflow.FindFirst() then
            Workflow.ModifyAll(Enabled, false);
        //IF Workflow.FINDSET THEN
        //REPEAT
        //Workflow.Enabled := FALSE;
        //Workflow.MODIFY;
        //UNTIL Workflow.NEXT = 0;
        //HEI.74<<
        //HEI.48>>
        if GLAccount.Get(gGenJnlBatches."Bal. Account No.") then
            if GLAccount.Blocked = true then begin
                GLAccount.Blocked := false;
                GLAccount.Modify();
            end;
        //HEI.48<<
        //HEI.29>>
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", gGenJnlBatches."Journal Template Name");
        //GenJournalLine.SETRANGE("Journal Batch Name",gGenJnlBatches.Name);//HEI.35
        if GenJournalLine.FindSet() then
            GenJournalLine.DeleteAll();
        //HEI.29<<
        //HEi.58>>
        Clear(GeneralJournalBatches);
        GeneralJournalTemplates.OpenView();
        GeneralJournalBatches.Trap();
        GeneralJournalTemplates.Filter.SetFilter(Name, gGenJnlBatches."Journal Template Name");

        // GeneralJournalTemplates."Page General Journal Batches".INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        GeneralJournalTemplates.Batches.Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name
        GeneralJournalBatches.Filter.SetFilter(Name, gGenJnlBatches.Name);
        GenJnl.Trap();
        GeneralJournalBatches.EditJournal.Invoke();
        //GenJnl.OPENEDIT;
        //HEi.58<<
        GenJnl.CurrentJnlBatchName.SetValue(gGenJnlBatches.Name);
        if gGenJnlBatches."No. Series" = '' then
            GenJnl."Document No.".SetValue('PTP082');
        GenJnl."Posting Date".SetValue(Today);
        //GenJnl."Document Date".SETVALUE(TODAY);//HEI.29
        GenJnl."Document Type".SetValue(1);
        //GenJnl."External Document No.".SETVALUE('PTP082');//HEI.29
        GenJnl."Account Type".SetValue(2);
        GenJnl."Account No.".SetValue(gVendor."No.");
        GenJnl."Apply Entries".Invoke();
        GenJnl.Amount.SetValue('1000.00');
        //HEI.29>>
        if GenJournalLine.Get(gGenJnlBatches."Journal Template Name", gGenJnlBatches.Name, GenJnl."Line No.".Value) then begin
            GenJournalLine.Validate("Document Date", Today);
            GenJournalLine.Validate("External Document No.", 'PTP082');
            GenJournalLine.Modify();
        end;
        //HEI.29<<
        //HEI.55>>
        if UpperCase(CompanyName) = UpperCase('Bralirwa') then
            MVMTDimension := '';
        //HEI.55<<
        GenJnl.Dimensions.Invoke();
        GenJnl.Post.Invoke();
        GenJnl.Close();
        //HEI.23<<
    end;

    [ModalPageHandler]
    procedure ApplyVendorLedModalPageHandler(var ApplyVendorEntries: TestPage "Apply Vendor Entries");
    begin
        //HEI.23>>
        ApplyVendorEntries.ActionSetAppliesToID.Invoke();
        ApplyVendorEntries.OK.Invoke();
        //HEI.23<<
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,MessageHandler,ApplyVendorLedModalPageHandler,DimSetEntriesModalPageHandlerPTP133,ReverseTransactionModalPageHandler')]
    procedure "PTP083_Reverse PtP Netting"();
    var
        Vendor: Record Vendor;
        Item: Record Item;
        GenJnlTable: Record "Gen. Journal Line";
        GenJnlBatch: Record "Gen. Journal Batch";
        VendorLedgerEntries: TestPage "Vendor Ledger Entries";
        GenJournalLine: Record "Gen. Journal Line";
        GenJnl: TestPage "General Journal";
        GLAccount: Record "G/L Account";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        Workflow: Record Workflow;
        gGenJnlBatches: Record "Gen. Journal Batch";
    begin
        DimensionRestrictionCheck; //HEI.102
        //HEI.23>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP083', CompanyName, Database::Vendor);
        gVendor.Get(UnitTestingValues.Value);

        //HEI.71>>
        VendorLedgerEntry.Reset();
        VendorLedgerEntry.SetCurrentKey("Vendor No.", Open, Positive, "Due Date", "Currency Code");
        VendorLedgerEntry.SetRange("Vendor No.", gVendor."No.");
        VendorLedgerEntry.SetRange(Open, true);
        if VendorLedgerEntry.FindFirst() then begin
            gVendor."Vendor Posting Group" := VendorLedgerEntry."Vendor Posting Group";
            gVendor.Modify();
        end;
        //HEI.71<<

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP083', CompanyName, Database::"Dimension Value");
        MVMTDimension := UnitTestingValues.Value;
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP083', CompanyName, Database::"Gen. Journal Batch");
        gGenJnlBatches.Get(UnitTestingValues.Value, UnitTestingValues."Value 2");
        Clear(ScriptNo);
        ScriptNo := UnitTestingValues."Test Script Code";
        Workflow.Reset();
        Workflow.SetRange(Enabled, true);
        //HEI.74>>
        if Workflow.FindFirst() then
            Workflow.ModifyAll(Enabled, false);
        //IF Workflow.FINDSET THEN
        //REPEAT
        //Workflow.Enabled := FALSE;
        //Workflow.MODIFY;
        //UNTIL Workflow.NEXT = 0;
        //HEI.74<<
        //HEI.48>>
        if GLAccount.Get(gGenJnlBatches."Bal. Account No.") then
            if GLAccount.Blocked = true then begin
                GLAccount.Blocked := false;
                GLAccount.Modify();
            end;
        //HEI.48<<
        //HEI.29>>
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", gGenJnlBatches."Journal Template Name");
        //GenJournalLine.SETRANGE("Journal Batch Name",gGenJnlBatches.Name);//HEI.35
        if GenJournalLine.FindSet() then
            GenJournalLine.DeleteAll();
        //HEI.29<<
        //HEi.58>>
        GeneralJournalTemplates.OpenView();
        GeneralJournalBatches.Trap();
        GeneralJournalTemplates.Filter.SetFilter(Name, gGenJnlBatches."Journal Template Name");

        // GeneralJournalTemplates."Page General Journal Batches".INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        GeneralJournalTemplates.Batches.Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name
        GeneralJournalBatches.Filter.SetFilter(Name, gGenJnlBatches.Name);
        GenJnl.Trap();
        GeneralJournalBatches.EditJournal.Invoke();
        //GenJnl.OPENEDIT;
        //HEi.58<<
        GenJnl.CurrentJnlBatchName.SetValue(gGenJnlBatches.Name);
        if gGenJnlBatches."No. Series" = '' then
            GenJnl."Document No.".SetValue('PTP082');
        Clear(GenJouDocNo);
        GenJouDocNo := GenJnl."Document No.".Value;
        GenJnl."Posting Date".SetValue(Today);
        //GenJnl."Document Date".SETVALUE(TODAY);//HEI.29
        GenJnl."Document Type".SetValue(1);
        //GenJnl."External Document No.".SETVALUE('PTP083');//HEI.29
        GenJnl."Account Type".SetValue(2);
        GenJnl."Account No.".SetValue(gVendor."No.");
        GenJnl."Apply Entries".Invoke();
        GenJnl.Amount.SetValue('1000.00');
        //HEI.29>>
        if GenJournalLine.Get(gGenJnlBatches."Journal Template Name", gGenJnlBatches.Name, GenJnl."Line No.".Value) then begin
            GenJournalLine.Validate("Document Date", Today);
            GenJournalLine.Validate("External Document No.", 'PTP083');
            GenJournalLine.Modify();
        end;
        //HEI.29<<
        //HEI.55>>
        if UpperCase(CompanyName) = UpperCase('Bralirwa') then
            MVMTDimension := '';
        //HEI.55<<
        GenJnl.Dimensions.Invoke();
        GenJnl.Post.Invoke();
        VendorLedgerEntries.OpenEdit();
        VendorLedgerEntries.Filter.SetFilter("Document No.", GenJouDocNo);
        VendorLedgerEntries.ReverseTransaction.Invoke();
        //VendorLedgerEntries.UnapplyEntries.INVOKE;//HEI.29
        //HEI.23<<
    end;

    [ModalPageHandler]
    procedure SelectGenJnlTemplatePageHandlerPTP082(var GenJnlTemplateList: TestPage "General Journal Template List");
    var
        gGenJnlBatches: Record "Gen. Journal Batch";
    begin
        //HEI.23>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get(ScriptNo, CompanyName, Database::"Gen. Journal Batch");
        gGenJnlBatches.Get(UnitTestingValues.Value, UnitTestingValues."Value 2");
        GenJnlTemplateList.Filter.SetFilter(Name, UnitTestingValues.Value);
        GenJnlTemplateList.OK.Invoke();
        //HEI.23<<
    end;

    [ModalPageHandler]
    // procedure ReverseTransactionModalPageHandler(var ReverseEntries: TestPage 179);//BC UPGRADE KUMARR78 Blocking As Page Variable removed.
    procedure ReverseTransactionModalPageHandler(var ReverseEntries: TestPage "Reverse Transaction Entries");//BC UPGRADE KUMARR78 Adding With New Page Variable.

    begin
        //HEI.23>>
        ReverseEntries.Filter.SetFilter("Document No.", GenJouDocNo);
        ReverseEntries.OK.Invoke();
        //HEI.23<<
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,MessageHandler,UnapplyEntriesModalPageHandler,ReverseTransactionModalPageHandler,WhseRcptPageHandler,ItemTrackingLinesModalPageHandler,GetReceiptLineModalPageHandler,SuggestVendorPayment_RequestPageHandler2')]
    procedure PTP086_Reverse_Refund();
    var
        Vendor: Record Vendor;
        VendorLedgerEntries: TestPage "Vendor Ledger Entries";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        PutVendNo: Codeunit "Error Message Hide TestScripts";
    begin
        DimensionRestrictionCheck();//HEI.95
        //HEI.23>>
        UnitTestingValues.Reset();
        //HEI.90>>
        //UnitTestingValues.GET('PTP086',COMPANYNAME,DATABASE::Vendor);
        UnitTestingValues.Get('PCN023', CompanyName, Database::Vendor);
        //HEI.90<<
        Vendor.Get(UnitTestingValues.Value);
        // PutVendNo.ClearVendInvNo();
        // PutVendNo.PutVendInvNo('StP Script PTP3');
        // PutVendNo.ClearBatchname();
        // PutVendNo.PutBatchName('STPTest3');
        PaymentPosting();//3//HEI.90//1
        //HEI.30>>
        VendorLedgerEntry.Reset();
        VendorLedgerEntry.SetRange("Vendor No.", Vendor."No.");
        VendorLedgerEntry.SetRange("Document Type", VendLedgEntry."Document Type"::Payment);
        VendorLedgerEntry.SetRange(Open, false);
        //VendorLedgerEntry.SETRANGE("Posting Date",TODAY);//HEI.90 //HEI.91
        // VendorLedgerEntry.SetFilter("Journal Batch Name", '%1', 'STPTest3');
        VendorLedgerEntry.SetFilter("Journal Batch Name", '%1', 'STPTest' + Format(EntryNo));
        //HEI.60>>
        if UpperCase(CompanyName) = '10_LUBUMBASHI' then
            VendorLedgerEntry.SetRange("Closed at Date", 0D);
        //HEI.60<<
        if VendorLedgerEntry.FindFirst() then;
        //HEI.30<<
        VendorLedgerEntries.OpenEdit();
        //HEI.30>>
        // VendorLedgerEntries.FILTER.SETFILTER("Vendor No.",Vendor."No.");
        // VendorLedgerEntries.FILTER.SETFILTER("Document Type",'Payment');
        // VendorLedgerEntries.FILTER.SETFILTER(Open,'No');
        VendorLedgerEntries.Filter.SetFilter("Entry No.", Format(VendorLedgerEntry."Entry No."));
        //HEI.30<<
        Clear(GenJouDocNo);
        GenJouDocNo := VendorLedgerEntries."Document No.".Value;

        // VendorLedgerEntries."Page Applied Vendor Entries".INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        VendorLedgerEntries.AppliedEntries.Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name


        VendorLedgerEntries.UnapplyEntries.Invoke();
        VendorLedgerEntries.ReverseTransaction.Invoke();
        //HEI.23<<
    end;

    [ModalPageHandler]
    procedure AppliedVLEModalPageHandler(var AppliedVendorEntries: TestPage "Applied Vendor Entries");
    begin
        //HEI.23>>
        AppliedVendorEntries.OK.Invoke();
        //HEI.23<<
    end;

    [Test]
    [HandlerFunctions('MessageHandler,UnapplyEntriesModalPageHandler,ConfirmationHandler,WhseRcptPageHandler,ItemTrackingLinesModalPageHandler,GetReceiptLineModalPageHandler,SuggestVendorPayment_RequestPageHandler2')]
    procedure PTP103_Unapplying_of_cleared_items();
    var
        Vendor: Record Vendor;
        VendorLedgerEntries: TestPage "Vendor Ledger Entries";
        PutVendNo: Codeunit "Error Message Hide TestScripts";
    begin
        DimensionRestrictionCheck();//HEI.95
        //HEI.23>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);
        //HEI.82>>
        //IF COMPANYNAME IN['10_SierraLeone','10_BRARUDI'] THEN
        PaymentPosting();
        //HEI.82<<
        VendorLedgerEntries.OpenEdit();
        VendorLedgerEntries.Filter.SetFilter("Vendor No.", Vendor."No.");
        VendorLedgerEntries.Filter.SetFilter("Document Type", 'Payment');
        VendorLedgerEntries.Filter.SetFilter(Open, 'No');
        VendorLedgerEntries.Filter.SetFilter(Reversed, 'No');//HEI.31
        Clear(GenJouDocNo);
        GenJouDocNo := VendorLedgerEntries."Document No.".Value;
        VendorLedgerEntries.UnapplyEntries.Invoke();
        VendorLedgerEntries.Close();
        VendorLedgerEntries.OpenView();
        VendorLedgerEntries.Filter.SetFilter("Document No.", GenJouDocNo);
        VendorLedgerEntries.Filter.SetFilter("Document Type", 'Payment');//HEI.29
        //VendorLedgerEntries.Open.ASSERTEQUALS(TRUE);//HEI.55
        VendorLedgerEntries.Close();
        //HEI.23<<
    end;

    [Test]
    [HandlerFunctions('SuggestVendorPayment_RequestPageHandler')]
    procedure PTP081_Create_Emergency_Payment_Proposal();
    var
        PayJnlTree: TestPage "Payment Journal Tree CBN";
        BatchError: Label 'An approval request already exists.';
        VendLedgEntry: Record "Vendor Ledger Entry";
        gGenJnlBatches: Record "Gen. Journal Batch";
    begin
        //HEI.23>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP081', CompanyName, Database::"Gen. Journal Batch");
        gGenJnlBatches.Get(UnitTestingValues.Value, UnitTestingValues."Value 2");

        VendLedgEntry.Reset();
        VendLedgEntry.SetRange("Document Type", VendLedgEntry."Document Type"::Invoice);
        VendLedgEntry.SetRange(Open, true);
        if VendLedgEntry.FindFirst() then begin
            InvNo := VendLedgEntry."Document No.";
        end;

        PayJnlTree.OpenEdit();//Abhay
        PayJnlTree.CurrentJnlBatchName.SetValue(gGenJnlBatches.Name);
        PayJnlTree.SuggestVendorPayments.Invoke();

        //HEI.23<<
    end;

    [Test]
    procedure PTP080_Unblock_invoice_for_payment();
    var
        BatchError: Label 'An approval request already exists.';
        VendLedgEntry: TestPage "Vendor Ledger Entries";
        Vendor: Record Vendor;
        ReasonCode: Record "Reason Code";
        InvNo: Code[20];
    begin
        //HEI.23>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP080', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);
        VendLedgEntry.OpenEdit();
        VendLedgEntry.Filter.SetFilter("Vendor No.", Vendor."No.");
        VendLedgEntry.Filter.SetFilter("Document Type", 'Invoice');
        //VendLedgEntry.FILTER.SETFILTER(Open,'Yes');//HEI.29
        Clear(InvNo);
        InvNo := VendLedgEntry."Document No.".Value;
        ReasonCode.Reset();
        ReasonCode.SetFilter(Code, '<>%1', '');
        if ReasonCode.FindFirst() then
            VendLedgEntry."Reason Code".SetValue(ReasonCode.Code);
        VendLedgEntry.Close();
        VendLedgEntry.OpenEdit();
        VendLedgEntry.Filter.SetFilter("Vendor No.", Vendor."No.");
        VendLedgEntry.Filter.SetFilter("Document Type", 'Invoice');
        //VendLedgEntry.FILTER.SETFILTER(Open,'Yes');//HEI.29
        VendLedgEntry.Filter.SetFilter("Document No.", InvNo);
        VendLedgEntry."Reason Code".SetValue('');
        VendLedgEntry.Close();
        //HEI.23<<
    end;

    [Test]
    procedure PTP079_Block_invoice_for_payment();
    var
        BatchError: Label 'An approval request already exists.';
        VendLedgEntry: TestPage "Vendor Ledger Entries";
        Vendor: Record Vendor;
        ReasonCode: Record "Reason Code";
    begin
        //HEI.23>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP079', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);
        VendLedgEntry.OpenEdit();
        VendLedgEntry.Filter.SetFilter("Vendor No.", Vendor."No.");
        VendLedgEntry.Filter.SetFilter("Document Type", 'Invoice');
        //VendLedgEntry.FILTER.SETFILTER(Open,'Yes');//HEI.29
        ReasonCode.Reset();
        ReasonCode.SetFilter(Code, '<>%1', '');
        if ReasonCode.FindFirst() then
            VendLedgEntry."Reason Code".SetValue(ReasonCode.Code);
        //HEI.23<<
    end;

    [Test]
    [HandlerFunctions('MessageHandler,UnapplyEntriesModalPageHandler,ConfirmationHandler,WhseRcptPageHandler,ItemTrackingLinesModalPageHandler,GetReceiptLineModalPageHandler,SuggestVendorPayment_RequestPageHandler2')]
    procedure PTP078_Reverse_payment_Rejected_payment();
    var
        Vendor: Record Vendor;
        VendorLedgerEntries: TestPage "Vendor Ledger Entries";
        PutVendNo: Codeunit "Error Message Hide TestScripts";
    begin
        DimensionRestrictionCheck();//HEI.95
        //HEI.23>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);
        //HEI.82>>
        //IF COMPANYNAME IN['10_SierraLeone','10_BRARUDI'] THEN
        // PutVendNo.ClearVendInvNo();
        // PutVendNo.PutVendInvNo('StP Script PTP4');
        // PutVendNo.ClearBatchname();
        // PutVendNo.PutBatchName('STPTest4');
        PaymentPosting();//4
        //HEI.82<<
        VendorLedgerEntries.OpenEdit();
        VendorLedgerEntries.Filter.SetFilter("Vendor No.", Vendor."No.");
        VendorLedgerEntries.Filter.SetFilter("Document Type", 'Payment');
        VendorLedgerEntries.Filter.SetFilter(Open, 'No');
        VendorLedgerEntries.Filter.SetFilter("Remaining Amount", '0');//HEI.29
        VendorLedgerEntries.Filter.SetFilter(Reversed, 'No');//HEI.31
        Clear(GenJouDocNo);
        GenJouDocNo := VendorLedgerEntries."Document No.".Value;
        VendorLedgerEntries.UnapplyEntries.Invoke();
        VendorLedgerEntries.Close();
        //HEI.23<<
    end;

    [Test]
    [HandlerFunctions('SuggestVendorPayment_RequestPageHandler,MessageHandler')]
    procedure PTP068_Review_and_Undo_Payment_Proposal();
    var
        PayJnlTree: TestPage "Payment Journal Tree CBN";
        PayTreeGenJnl: Record "Gen. Journal Line";
        DeleteError: Label 'An approval request already exists.';
        WorkflowMessage: Label 'Workflow is not enabled, Payment Proposal is delated successfully';
        gGenJnlBatches: Record "Gen. Journal Batch";
    begin
        //HEI.23>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP068', CompanyName, Database::"Gen. Journal Batch");
        gGenJnlBatches.Get(UnitTestingValues.Value, UnitTestingValues."Value 2");
        Clear(InvNo);
        VendLedgEntry.Reset();
        VendLedgEntry.SetRange("Document Type", VendLedgEntry."Document Type"::Invoice);
        VendLedgEntry.SetRange(Open, true);
        VendLedgEntry.SetRange("Payment Status FND", VendLedgEntry."Payment Status FND"::"Payment Approved");
        if VendLedgEntry.FindFirst() then begin
            InvNo := VendLedgEntry."Document No.";
        end;
        PayJnlTree.OpenEdit();//Abhay
        PayJnlTree.CurrentJnlBatchName.SetValue(gGenJnlBatches.Name);
        PayJnlTree.SuggestVendorPayments.Invoke();
        if ApprovalsMgmt.IsGeneralJournalBatchApprovalsWorkflowEnabled(gGenJnlBatches) then begin
            PayJnlTree.SendApprovalRequestJournalBatch.Invoke();
            asserterror PayJnlTree.DeleteBatch.Invoke();
            if GetLastErrorText <> DeleteError then
                Error('Unexpected Error: %1', GetLastErrorText);
            PayJnlTree.CancelApprovalRequestJournalBatch.Invoke();
            PayJnlTree.DeleteBatch.Invoke();
        end else
            Message(WorkflowMessage)
        //HEI.23<<
    end;

    [Test]
    // [HandlerFunctions('ConfirmationHandler,MessageHandler,SelectGenJnlTemplatePageHandler,ApplyGLEntryModalPageHandler,DimSetEntriesModalPageHandlerPTP133,GeneralLedgerEntriesPageHandler')]
    [HandlerFunctions('SelectGenJnlTemplatePageHandler,ApplyGLEntryModalPageHandler,DimSetEntriesModalPageHandlerPTP133,GeneralLedgerEntriesPageHandler')]
    procedure PTP091_Automatic_clearing_on_GR_or_IR_Account();
    var
        GLAcc: Record "G/L Account";
        COA: TestPage "Chart of Accounts";
        GRIRGLAccNo: Code[20];
        GLEntryList: TestPage "General Ledger Entries";
        GeneralLedgerSetup: Record "General Ledger Setup";
        GenJournalLine: Record "Gen. Journal Line";
        GenJnl: TestPage "General Journal";
        RestrictedRecord: Record "Restricted Record";
        VendorPostingGroup: Record "Vendor Posting Group";
        ErrorMesageHide: Codeunit "Error Message Hide TestScripts";
        gGenJnlBatches: Record "Gen. Journal Batch";
        DefDimension: record "Default Dimension";
    begin
        //HEI.25>>
        Clear(GenJnlAccType);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP091', CompanyName, Database::Vendor);
        gVendor.Get(UnitTestingValues.Value);

        //HEI.94>>
        if gVendor."Vendor Posting Group" <> '' then begin
            VendorPostingGroup.Get(gVendor."Vendor Posting Group");

            gChartofAccount.Reset();
            gChartofAccount.SetRange("No.", VendorPostingGroup."Payables Account");
            if gChartofAccount.FindFirst() then
                gChartofAccount."Automatic application mode FND" := gChartofAccount."Automatic application mode FND"::"GR/IR Accounts Payable";
            gChartofAccount.Modify();

            DefDimension.Reset();
            DefDimension.setrange("Table ID", 15);
            DefDimension.SetRange("No.", gChartofAccount."No.");
            DefDimension.SetRange("Value Posting", DefDimension."Value Posting"::"Code Mandatory");
            if DefDimension.FindSet() then
                DefDimension.modifyall(DefDimension."Value Posting", DefDimension."Value Posting"::" ");
        end;


        Clear(gChartofAccount);
        //HEI.94<<
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP091', CompanyName, Database::"G/L Account");
        gChartofAccount.Get(UnitTestingValues.Value);
        // gChartofAccount."Automatic application mode FND" := gChartofAccount."Automatic application mode FND"::"GR/IR Accounts Payable";
        // gChartofAccount.Modify();//Abhay

        // GLAccNo := gChartofAccount."No.";
        // COA.OpenView();
        // COA.Filter.SetFilter("No.", gChartofAccount."No.");
        // // COA."Page General Ledger Entries".INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        // COA."Ledger E&ntries".Invoke();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP091', CompanyName, Database::"Gen. Journal Batch");
        gGenJnlBatches.Get(UnitTestingValues.Value, UnitTestingValues."Value 2");

        //HEI.26>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP091', CompanyName, Database::"Dimension Value");
        GeneralLedgerSetup.Get();
        DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 3 Code", UnitTestingValues.Value);
        Clear(MVMTDimension);
        MVMTDimension := DimensionValue.Code;
        //HEI.26<<
        // BC Upgrade BHARDA11 >> --Temp Blocked
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", gGenJnlBatches."Journal Template Name");
        GenJournalLine.setrange("Journal Batch Name", gGenJnlBatches.Name);
        if GenJournalLine.findset() then
            GenJournalLine.DeleteAll();
        // BC Upgrade BHARDA11 <<
        GenJnl.OpenEdit();
        GenJnl.CurrentJnlBatchName.SetValue(gGenJnlBatches.Name);
        GenJnl."Posting Date".SetValue(Today);
        //GenJnl."Document Date".SETVALUE(TODAY);//HEI.26
        GenJnl."Document Type".SetValue(1);
        //GenJnl."External Document No.".SETVALUE('PTP091');//HEI.26
        GenJnl."Account Type".SetValue(2);
        GenJnl."Account No.".SetValue(gVendor."No.");
        GenJnl.Amount.SetValue('1000.00');
        GenJnl."Bal. Account Type".SetValue(0);
        GenJnl."Bal. Account No.".SetValue(gChartofAccount."No.");
        Clear(GLPaymentDocNo);
        GLPaymentDocNo := GenJnl."Document No.".Value;
        //HEI.26>>
        if GenJournalLine.Get(gGenJnlBatches."Journal Template Name", gGenJnlBatches.Name, GenJnl."Line No.".Value) then begin
            GenJournalLine.Validate("Document Date", Today);
            GenJournalLine.Validate("External Document No.", 'PTP091');
            GenJournalLine.Modify();
        end;
        //HEI.26<<
        GenJnl.Dimensions.Invoke();//HEI.26
                                   //HEI.31>>
                                   //BC Upgrade BHARDA11 >>
                                   // GLAcc.Reset();
                                   // GLAcc.SetRange(GLAcc."Automatic application mode FND", GLAcc."Automatic application mode FND"::"GR/IR Accounts Payable");
                                   // GLAcc.SetRange(GLAcc."Account Type", GLAcc."Account Type"::Posting);
                                   // if GLAcc.FindFirst() then;
        DefDimension.Reset();
        DefDimension.setrange("Table ID", 15);
        DefDimension.SetRange("No.", gChartofAccount."No.");
        DefDimension.SetRange("Value Posting", DefDimension."Value Posting"::"Code Mandatory");
        if DefDimension.FindSet() then
            DefDimension.modifyall(DefDimension."Value Posting", DefDimension."Value Posting"::" ");
        // BC Upgrade BHARAD11 <<
        RestrictedRecord.Reset();
        if RestrictedRecord.FindSet() then
            RestrictedRecord.DeleteAll();
        if GeneralLedgerSetup."Final Reporting Extracted FND" then begin
            GeneralLedgerSetup."Final Reporting Extracted FND" := false;
            GeneralLedgerSetup.Modify();
        end;
        //HEI.31<<
        // 3333333333333333333333333333
        // Clear(LastError);
        // BindSubscription(ErrorMesageHide);
        // GenJnl.Post.Invoke();
        // ErrorMesageHide.Run();
        // LastError := ErrorMesageHide.ErrorMesage();
        // UnbindSubscription(ErrorMesageHide);
        // if LastError <> '' then
        //     Error(LastError);
        // GenJnl.Close();//HEI.26
        GRIRGLAccNo := '';
        GLAcc.Reset();
        GLAcc.SetRange(GLAcc."Automatic application mode FND", GLAcc."Automatic application mode FND"::"GR/IR Accounts Payable");
        GLAcc.SetRange(GLAcc."Account Type", GLAcc."Account Type"::Posting);

        if GLAcc.FindFirst() then
            GRIRGLAccNo := GLAcc."No.";
        GLAccNo := gChartofAccount."No.";
        COA.OpenView();
        COA.Filter.SetFilter("No.", GLAccNo);

        // COA."Page General Ledger Entries".INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        COA."Ledger E&ntries".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name


        GLEntryList.OpenView();
        GLEntryList.Filter.SetFilter("Document No.", GLPaymentDocNo);
        // GLEntryList.Filter.SetFilter("Document No.", GLAccNo);


        // BC Upgrade BHARDA11 << --Temp Blocked
        // GLEntryList.Action1000000000.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        GLEntryList."Applied Entries CBN".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

        //HEI.25<<
    end;

    [PageHandler]
    Procedure GeneralLedgerEntriesPageHandler(var GeneralLedEntryPage: TestPage "General Ledger Entries")
    begin
        GeneralLedEntryPage.filter.SetFilter("G/L Account No.", GLAccNo);
        GeneralLedEntryPage."Apply Entries".Invoke();
    end;

    [PageHandler]
    procedure ApplyGLEntryModalPageHandler(var ApplyGLEntryPage: TestPage "Apply Gen Ledger Entries CBN");
    begin

        //HEI.25>>
        ApplyGLEntryPage.Filter.SetFilter("G/L Account No.", GLAccNo);
        ApplyGLEntryPage.Filter.SetFilter("Applies-to ID", '');
        ApplyGLEntryPage."<Option>".SetValue(6);
        ApplyGLEntryPage.AllowPartialApplication.SetValue(true);

        // ApplyGLEntryPage.Action1010009.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        ApplyGLEntryPage."Set Applies-to ID".Invoke(); //BC UPGRADE KUMARR78 Adding with Change Action Name

        // ApplyGLEntryPage.Action1100710008.INVOKE; //BC UPGRADE KUMARR78 Blocking As Action Name Changed
        ApplyGLEntryPage."&Automatic application".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

        // ApplyGLEntryPage.Action1010010.INVOKE; //BC UPGRADE KUMARR78 Blocking As Action Name Changed
        ApplyGLEntryPage."Post Application".Invoke(); //BC UPGRADE KUMARR78 Adding with Change Action Name

        //HEI.25<<
    end;

    [Test]
    [HandlerFunctions('GRIR_ReportHandler')]
    procedure PTP092_Review_Consolidated_GR_or_IR_report();
    var
        GRIRClearingReport: Report "GR/IR Clearing Report1 CBN";
    begin
        //HEI.25>>

        //Step 1: Login

        //Step 2 - Open
        GRIRClearingReport.Run();

        //HEI.25<<
    end;

    [ReportHandler]
    procedure GRIR_ReportHandler(var GRIRReport: Report "GR/IR Clearing Report1 CBN");
    begin
        //HEI.25>>
        //HEI.25<<
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,MessageHandler,SelectGenJnlTemplatePageHandler,ReverseModalPageHandler')]
    procedure PTP136_Reverse_Manual_Payment();
    var
        PurchaseInvList: TestPage "PO Purchase Invoices";
        Vendor: Record Vendor;
        Item: Record Item;
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        PayDocNo: Code[20];
        VendList: TestPage "Vendor List";
        VendLedgEntries: TestPage "Vendor Ledger Entries";
        // ReverseEntries: TestPage 179; //BC UPGRADE KUMARR78 Blocking As Variable removed.
        ReverseEntries: TestPage "Reverse Transaction Entries"; //BC UPGRADE KUMARR78 Adding "Reverse Transaction Entries" in Place of Reverse Entries As Variable removed.
        EntryNo: Integer;
        VendLedgEntry: Record "Vendor Ledger Entry";
        GenJournalLine: Record "Gen. Journal Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
        GenJnl: TestPage "General Journal";
        DefaultDimension: Record "Default Dimension";
        RestrictedRecord: Record "Restricted Record";
        EbfCombination: Record "Ebf Combination FND";
        Workflow: Record Workflow;
        gGenJnlBatches: Record "Gen. Journal Batch";
    begin
        //HEI.25>>
        DimensionRestrictionCheck(); //HEI.96
        Clear(GenJnlAccType);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP136', CompanyName, Database::Vendor);
        gVendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP136', CompanyName, Database::"G/L Account");
        gChartofAccount.Get(UnitTestingValues.Value);
        Clear(gGenJnlBatches);
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP136', CompanyName, Database::"Gen. Journal Batch");
        gGenJnlBatches.Get(UnitTestingValues.Value, UnitTestingValues."Value 2");

        //HEI.97>>
        //Disabling Workflow
        Workflow.Reset();
        Workflow.SetRange(Enabled, true);
        if Workflow.FindFirst() then
            Workflow.ModifyAll(Enabled, false);

        //Creating General Journal Entry
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", gGenJnlBatches."Journal Template Name");

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET as its being depreceted
        //if GenJournalLine.FindSet(false, false) then
        if GenJournalLine.FindSet(false) then
            // BC Upgrade MISHRS14 <<

            GenJournalLine.DeleteAll();
        //HEI.97<<
        //HEI.26>>
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", gGenJnlBatches."Journal Template Name");
        GenJournalLine.SetRange("Journal Batch Name", gGenJnlBatches.Name);
        if GenJournalLine.FindSet() then
            GenJournalLine.DeleteAll();
        //HEI.98>>
        /*UnitTestingValues.RESET;
        UnitTestingValues.GET('PTP136',COMPANYNAME,DATABASE::"Dimension Value");
        GeneralLedgerSetup.GET;
        DimensionValue.GET(GeneralLedgerSetup."Shortcut Dimension 3 Code",UnitTestingValues.Value);
        CLEAR(MVMTDimension);
        MVMTDimension:=DimensionValue.Code;

        //HEI.26<<
        //HEI.90>>
        EbfCombination.RESET;
        EbfCombination.SETRANGE("Dimension Code",GeneralLedgerSetup."Shortcut Dimension 2 Code",GeneralLedgerSetup."Shortcut Dimension 3 Code");
        EbfCombination.SETFILTER("Combination Restriction",'<>%1',EbfCombination."Combination Restriction"::" ");
        EbfCombination.DELETEALL();
        //HEI.90<<
        */
        //HEI.98<<
        GenJnl.OpenEdit();
        GenJnl.CurrentJnlBatchName.SetValue(gGenJnlBatches.Name);
        GenJnl."Posting Date".SetValue(Today);
        //HEI.26>>
        //GenJnl."Document Date".SETVALUE(TODAY);
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", gGenJnlBatches."Journal Template Name");
        GenJournalLine.SetRange("Journal Batch Name", gGenJnlBatches.Name);
        if GenJournalLine.FindFirst() then begin
            PayDocNo := GenJournalLine."Document No."; //HEI.98
            GenJournalLine.Validate("Document Date", Today);
            GenJournalLine.Validate("External Document No.", 'PTP136');
            GenJournalLine.Modify();
        end;
        //HEI.26<<
        GenJnl."Document Type".SetValue(1);
        //GenJnl."External Document No.".SETVALUE('PTP136');//HEI.26
        GenJnl."Account Type".SetValue(2);
        GenJnl."Account No.".SetValue(gVendor."No.");
        GenJnl.Amount.SetValue('1000.00');
        GenJnl."Bal. Account Type".SetValue(0);
        GenJnl."Bal. Account No.".SetValue(gChartofAccount."No.");

        //GenJnl.Dimensions.INVOKE;//HEI.26 //HEI.96
        //HEI.31>>
        RestrictedRecord.Reset();
        if RestrictedRecord.FindSet() then
            RestrictedRecord.DeleteAll();
        //HEI.31<<
        GenJnl.Post.Invoke();

        VendList.OpenEdit();
        VendList.Filter.SetFilter("No.", gVendor."No.");

        // VendList."Page Vendor Ledger Entries".INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        VendList."Ledger E&ntries".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name


        VendLedgEntries.OpenView();
        VendLedgEntries.Filter.SetFilter("Vendor No.", gVendor."No.");
        VendLedgEntries.Filter.SetFilter("Document No.", PayDocNo);
        VendLedgEntry.Reset();
        VendLedgEntry.SetRange("Document No.", PaymentDocNo);
        if VendLedgEntry.FindFirst() then
            TransNo := Format(VendLedgEntry."Transaction No.");
        VendLedgEntries.ReverseTransaction.Invoke();
        //HEI.25<<

    end;

    [ModalPageHandler]
    // procedure ReverseModalPageHandler(var ReverseEntriesPage: TestPage 179);//BC UPGRADE KUMARR78 Blockig As variable replaced in BC.
    procedure ReverseModalPageHandler(var ReverseEntriesPage: TestPage "Reverse Transaction Entries");//BC UPGRADE KUMARR78 Adding As variable replaced in BC from Reverse Entries to"Reverse Transaction Entries".

    begin
        //HEI.25>>
        ReverseEntriesPage.Filter.SetFilter("Transaction No.", TransNo);
        ReverseEntriesPage.Filter.SetFilter("Account No.", ReverseVendNo);
        ReverseEntriesPage.Filter.SetFilter("Document No.", PaymentDocNo);
        ReverseEntriesPage.Reverse.Invoke();
        //HEI.25<<
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler,MessageHandler,NewGetRetShipmentLineModalPageHandler,WhseShipmentPageHandler,ShipInvoiceStrMenuHandler,ItemTrackingLinesModalPageHandler,WhseRcptPageHandler,GetReceiptLineModalPageHandler,DimSetEntriesModalPageHandler')]
    procedure PTP058_Negative_PO_CN();
    var
        Vendor: Record Vendor;
        Item: Record Item;
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        PurchaseInvList: TestPage "PO Purchase Invoices";
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        PostedPurchInvHdr: Record "Purch. Inv. Header";
        PostedPurchInv: TestPage "Posted Purchase Invoice";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        UserSetup2: Record "User Setup";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        PurchRetOrder: TestPage "Purchase Return Order";
        PurchaseReturnOrderList: TestPage "Purchase Return Order List";
        PurchaseReturnOrder: TestPage "Purchase Return Order";
        RetShipmentHdr: Record "Return Shipment Header";
        PurchaseCrMemoList: TestPage "PO Purchase Credit Memos";
        PurchaseCrMemo: TestPage "PO Purchase Credit Memo";
        WarehouseShipment: TestPage "Warehouse Shipment";
        WhseShipmentNo: Code[20];
        GetReturnShipmentLines: TestPage "Get Return Shipment Lines";
        Location: Record Location;
        ItemTrackingQtyBase: Decimal;
        BinContent: Record "Bin Content";
        Bin: Record Bin;
        DocDateError: TextConst ENU = 'Document Date must have a value in Purchase Header: Document Type=Credit Memo, No.=%1. It cannot be zero or empty.';
        VendCrMemoNoError: TextConst ENU = 'Vendor Cr. Memo No. must have a value in Purchase Header: Document Type=Credit Memo, No.=%1. It cannot be zero or empty.';
        PurchCrMemoCurr: Record Currency;
        PrevCurrCode: Code[20];
        PurchCrMemoLine: Record "Purchase Line";
        DocAmtInclVAT: Decimal;
        DocVATAmt: Decimal;
        PurchCrMemoHdr: Record "Purchase Header";
        AmtError: Label 'Total amount (%1) is not equal to total of lines (%2)';
        CurrExChngRate: Record "Currency Exchange Rate";
        OthCurrCode: Code[20];
        ReservationEntry: Record "Reservation Entry";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Zone: Record Zone;
        PurchaseLine: Record "Purchase Line";
        DimensionValue1: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        PurchaseHeader: Record "Purchase Header";
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        GeneralPostingSetup: Record "General Posting Setup";
        GLAccount: Record "G/L Account";
        NoSeriesLine: Record "No. Series Line";
        Workflow: Record Workflow;
        RecZone: Record Zone;
        WhseEmpDTW: record 50356;
        WarRecLin: Record "Warehouse Receipt Line";
        WarEmployee: Record "Warehouse Employee";
        WhseDocNo: code[20];
    begin
        //HEI.59>>
        if PurchasesPayablesSetup.Get() then
            NoSeriesLine.Reset();
        NoSeriesLine.SetRange("Series Code", PurchasesPayablesSetup."Posted Credit Memo Nos.");
        NoSeriesLine.SetFilter("Last Date Used", '>%1', Today);
        if NoSeriesLine.FindFirst() then begin
            NoSeriesLine."Last Date Used" := Today;
            NoSeriesLine.Modify();
        end;
        //HEI.59<<
        //HEI.25>>
        WarehouseReceiptHeader.DeleteAll();//HEI.36
        WarehouseShipmentHeader.DeleteAll();//HEI.55
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP058', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP058', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);

        //HEI.57>>
        if GeneralPostingSetup.Get(Vendor."Gen. Bus. Posting Group", Item."Gen. Prod. Posting Group") then
            if GLAccount.Get(GeneralPostingSetup."Purchase Variance Account") then
                if GLAccount.Blocked = true then begin
                    GLAccount.Blocked := false;
                    GLAccount.Modify();
                end;
        //HEI.57<<

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP058', CompanyName, Database::"Vendor Bank Account");
        VendorBankAccount.Get(Vendor."No.", UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP058', CompanyName, Database::"Lot No. Information");
        LotNoFilter := UnitTestingValues.Value;

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP058', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);
        //HEI.61>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP058', CompanyName, Database::Bin);
        Bin.Get(Location.Code, UnitTestingValues.Value);
        //HEI.61<<
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP058', CompanyName, Database::"Dimension Value");
        GeneralLedgerSetup.Get();
        DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 3 Code", UnitTestingValues.Value);
        //HEI.26>>
        PurchasesPayablesSetup.Get();
        if PurchasesPayablesSetup."Exact Cost Reversing Mandatory" = true then begin
            PurchasesPayablesSetup."Exact Cost Reversing Mandatory" := false;
            PurchasesPayablesSetup.Modify();
        end;
        PurchasesPayablesSetup.Get();
        if PurchasesPayablesSetup."Ext. Doc. No. Mandatory" = false then begin
            PurchasesPayablesSetup."Ext. Doc. No. Mandatory" := true;
            PurchasesPayablesSetup.Modify();
        end;
        //HEI.26<<
        //Logon to Heilite

        //Create a PO
        PurchaseOrder.OpenNew();
        PurchaseOrder."No.".AssistEdit();
        PurchaseOrder."Buy-from Vendor No.".SetValue(Vendor."No.");
        PurchaseOrder."Vendor Invoice No.".SetValue('StP Unit Test PTP010');
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseOrder."Location Code".SetValue(Location.Code);
        //HEI.51<<
        PnPSetup.Get();
        if PnPSetup."Requester ID Mandatory FND" then //BC UPGRADE KUMARR78 Adding Semicolon(;) to handle the sentence.
            PurchaseOrder."Requester ID".SETVALUE(USERID);//BC UPGRADE KUMARR78 DIT Field Removed.

        PurchaseOrder.PurchLines.Type.SetValue(Type::Item);
        PurchaseOrder.PurchLines."No.".SetValue(Item."No.");
        PurchaseOrder.PurchLines."Location Code".SetValue(Location.Code);
        PurchaseOrder.PurchLines.Quantity.SetValue(1);
        //HEI.57>>
        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP058', CompanyName, Database::"Dimension Value");
        if UnitTestingValues.Value <> '' then
            DimensionValue1.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues."Value 2");
        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue1.Code);
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue1.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();
        PurchaseHeader.Reset();
        PurchaseHeader.SetRange("No.", PurchaseOrder."No.".Value);
        PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
        if PurchaseHeader.FindFirst() then begin
            PurchaseHeader.Validate("Shortcut Dimension 2 Code", DimensionValue1.Code);
            PurchaseHeader.Modify();
        end;
        //HEI.57<<
        //HEI.61>>
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", PurchaseOrder."No.".Value);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("No.", PurchaseOrder.PurchLines."No.".Value);
        if PurchaseLine.FindFirst() then begin
            if UpperCase(CompanyName) = UpperCase('Almaza') then//HEI.63
                PurchaseLine.Validate("Bin Code", Bin.Code);
            PurchaseLine.Modify();
        end;
        //HEI.61<<
        PurchaseOrder.PurchLines.Dimensions.Invoke();
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Approval
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            //IF Workflow.FINDSET THEN
            //REPEAT
            //Workflow.Enabled := FALSE;
            //Workflow.MODIFY;
            //UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;

        PurchaseOrder.Release.Invoke();
        // BC Upgrade BHARAD11 >>
        Reczone.reset;
        Reczone.setrange("Location Code", Location.code);
        reczone.findfirst();
        WhseEmpDTW.init();
        WhseEmpDTW."User ID" := userid;
        WhseEmpDTW."location Code" := Location.code;
        WhseEmpDTW."zone Code" := RecZone.Code;
        if WhseEmpDTW.insert() then;
        // error(Reczone.code);
        Bin.reset();
        Bin.SetRange("Zone Code", RecZone.code);
        bin.findfirst();
        WarEmployee.init();
        WarEmployee."User ID" := userid;
        waremployee."location Code" := Location.code;
        if WarEmployee.insert() then;
        // BC Upgrade BHARAD11 <<
        // PurchaseOrder.Action149.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseOrder."Create &Whse. Receipt".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

        WarehouseReceipt.OpenView();
        WarehouseReceipt.Filter.SetFilter("Source No. FND", PurchaseOrder."No.".Value);

        //Store the PO No in Warehouse Receipt
        WhseRcptPONo := WarehouseReceipt."Source No.".Value;
        WhseDocNo := WarehouseReceipt."No.".value; // BC Upgrade BHARDA11
                                                   // BC Upgrade BHARDA11 

        WarRecLin.reset();
        WarRecLin.SetRange("No.", WhseDocNo);
        WarRecLin.findset();
        WarRecLin.Validate("Zone Code", RecZone.Code);
        WarRecLin.Validate("Bin Code", Bin.Code);
        WarRecLin.modify();

        // BC Upgrade BHARDA11 
        //Select Item Tracking Code
        WarehouseReceipt.WhseReceiptLines.ItemTrackingLines.Invoke();

        //Post The warehouse receipt
        WarehouseReceipt."Post Receipt".Invoke();
        PurchaseOrder.OK.Invoke();

        PurchRcptHdr.SetRange("Order No.", WhseRcptPONo);
        if PurchRcptHdr.FindFirst() then
            DocNo := PurchRcptHdr."No.";

        // Select PO Purchase Invoices from the list
        PurchaseInvoice.OPENNEW;

        //AssitEdit to create the Document No. & Add Vendor No. and put vendor invoice No.
        PurchaseInvoice."No.".ASSISTEDIT;
        PurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");
        PurchaseInvoice."Vendor Invoice No.".SETVALUE('PTP058');
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseInvoice."Location Code".SETVALUE(Location.Code);
        //HEI.51<<
        //Go to LINES/FUNCTIONS tab and click &Quot;Get Receipt Lines&quot;
        PurchaseInvoice.PurchLines.GetReceiptLines.INVOKE;
        GetReceiptLines.OpenView();
        if Vendor."Preferred Bank Account Code" = '' then //HEI.31
            PurchaseInvoice."Vendor Bank Account".SETVALUE(VendorBankAccount.Code);

        //Calculation of Doc Amt and VAT amt
        PurchInvNo := PurchaseInvoice."No.".VALUE;
        DocAmount := 0;
        VATAmount := 0;
        PurchLn.Reset();
        PurchLn.SetRange("Document Type", PurchLn."Document Type"::Invoice);
        PurchLn.SetRange("Document No.", PurchInvNo);
        if PurchLn.FindSet() then
            repeat
                DocAmount += PurchLn."Amount Including VAT";
                VATAmount += (PurchLn."Amount Including VAT" - PurchLn.Amount);
            until PurchLn.Next() = 0;
        //HEI.55>>
        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP058', CompanyName, Database::"Dimension Value");
        if UnitTestingValues.Value <> '' then
            DimensionValue1.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues."Value 2");
        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue1.Code);
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue1.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();
        PurchaseHeader.Reset();
        PurchaseHeader.SETRANGE("No.", PurchaseInvoice."No.".VALUE);
        PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Invoice);
        if PurchaseHeader.FindFirst() then begin
            PurchaseHeader.Validate("Shortcut Dimension 2 Code", DimensionValue1.Code);
            PurchaseHeader.Modify();
        end;
        //HEI.55<<
        DocAmtInclVAT := 0;
        DocVATAmt := 0;

        if (GeneralLedgerSetup."Inv. Rounding Precision (LCY)" = 1) and (PurchaseInvoice."Currency Code".VALUE = '') then begin
            PurchaseInvoice."Doc. Amount Incl. VAT IBM".SETVALUE(ROUND(DocAmount, 1, '<'));//BC UPGRADE KUMARR78 >>DIT Variable Removed.
            DocAmtInclVAT := Round(DocAmount, 1, '<');
        end else begin
            PurchaseInvoice."Doc. Amount Incl. VAT IBM".SETVALUE(DocAmount);//BC UPGRADE KUMARR78 >>DIT Variable Removed. // BC Upgrade BHARDA11
            DocAmtInclVAT := DocAmount;
        end;
        // PurchaseInvoice."Doc. Amount VAT".SETVALUE(VATAmount);//BC UPGRADE KUMARR78 >>DIT Variable Removed.
        DocVATAmt := VATAmount;
        PurchaseInvoice.Dimensions.INVOKE;//HEI.54

        // PurchaseInvoice.Post.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseInvoice.Post_Custom.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name


        PostedPurchInvHdr.SetRange("Pre-Assigned No.", PurchInvNo);
        if PostedPurchInvHdr.FindFirst() then
            StorePostedInvNo := PostedPurchInvHdr."No.";

        //Create Ret Order against that posted warehse rcpt
        PurchaseReturnOrder.OpenNew();
        PurchaseReturnOrder."No.".AssistEdit();
        PurchaseReturnOrder."Buy-from Vendor Name".SetValue(Vendor."No.");
        PurchaseReturnOrder."Vendor Cr. Memo No.".SetValue('StP PTP058');
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseReturnOrder."Location Code".SetValue(Location.Code);
        //HEI.51<<
        PurchaseReturnOrder.PurchLines.New();
        PurchaseReturnOrder.PurchLines.Type.SetValue(Type::Item);
        PurchaseReturnOrder.PurchLines."No.".SetValue(Item."No.");
        PurchaseReturnOrder.PurchLines.Quantity.SetValue(1);
        PurchRetOrderNo := PurchaseReturnOrder."No.".Value;
        PurchaseReturnOrder.PurchLines."Location Code".SetValue(Location.Code);
        //HEI.57>>
        PurchaseHeader.SetRange("No.", PurchaseReturnOrder."No.".Value);
        PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::"Return Order");
        if PurchaseHeader.FindFirst() then begin
            PurchaseHeader.Validate("Shortcut Dimension 2 Code", DimensionValue1.Code);
            PurchaseHeader.Modify();
        end;
        //HEI.57<<

        //PurchaseReturnOrder.Release.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseReturnOrder."Re&lease".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

        //Create warehouse shipment
        // PurchaseReturnOrder.Action93.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseReturnOrder."Create &Warehouse Shipment".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name


        //Open warehouse shipment page
        WarehouseShipment.OpenView();
        WarehouseShipment.Filter.SetFilter("Source No. FND", PurchaseReturnOrder."No.".Value);

        if Location."Receipt Bin Code" = '' then begin
            BinContent.Reset();
            BinContent.SetRange("Item No.", Item."No.");
            BinContent.SetRange("Location Code", Location.Code);
            BinContent.SetFilter(Quantity, '<>%1', 0);
            BinContent.SetRange(Default, true);
            if BinContent.FindFirst() then begin
                WarehouseShipmentLine.Reset();
                WarehouseShipmentLine.SetRange("No.", WarehouseShipment."No.".Value);
                WarehouseShipmentLine.SetRange("Item No.", WarehouseShipment.WhseShptLines."Item No.".Value);
                if WarehouseShipmentLine.FindFirst() then begin
                    WarehouseShipmentLine.Validate("Zone Code", BinContent."Zone Code");
                    WarehouseShipmentLine.Validate("Bin Code", BinContent."Bin Code");
                    WarehouseShipmentLine.Modify();
                end;
            end;
        end
        else begin
            if Bin.Get(Location.Code, Location."Receipt Bin Code") then begin
                WarehouseShipmentLine.Reset();
                WarehouseShipmentLine.SetRange("No.", WarehouseShipment."No.".Value);
                WarehouseShipmentLine.SetRange("Item No.", WarehouseShipment.WhseShptLines."Item No.".Value);
                if WarehouseShipmentLine.FindFirst() then begin
                    WarehouseShipmentLine.Validate("Zone Code", Bin."Zone Code");
                    WarehouseShipmentLine.Validate("Bin Code", Bin.Code);
                    WarehouseShipmentLine.Modify();
                end;
            end;
        end;
        //Store the PO No in Warehouse Receipt
        WhseShipmentNo := WarehouseShipment."Source No.".Value;
        //HEI.26>>
        if Location."Purchase Gate Entry Mandat FND" = true then begin
            Location."Purchase Gate Entry Mandat FND" := false;
            Location.Modify();
        end;
        if Zone.Get(Location.Code, Location."Shipment Bin Code") then
            if Zone."Sales Gate Entry Mandatory FND" = true then begin
                Zone."Sales Gate Entry Mandatory FND" := false;
                Zone.Modify();
            end;
        //HEI.26<<
        //Create Warehouse Shipment document and fill all required information

        ItemUnitofMeasure.SetRange(Code, Item."Purch. Unit of Measure");
        ItemUnitofMeasure.SetRange("Item No.", Item."No.");
        if ItemUnitofMeasure.FindFirst() then
            ItemTrackingQtyBase := WarehouseShipment.WhseShptLines."Qty. to Ship".AsDecimal() * ItemUnitofMeasure."Qty. per Unit of Measure"
        else
            ItemTrackingQtyBase := 1;

        WarehouseShipment.WhseShptLines.ItemTrackingLines.Invoke();

        // WarehouseShipment.Action45.INVOKE;//BC UPGRADE KUMARR78 Blocking to Change Action.
        WarehouseShipment."Re&lease".Invoke();//BC UPGRADE KUMARR78 Adding with Changed Action Name

        //Post The warehouse receipt
        // WarehouseShipment.Action25.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changes From Action25 To "P&ost Shipment"
        WarehouseShipment."P&ost Shipment".Invoke();//BC UPGRADE KUMARR78 Adding As Action Name Changes From Action25 To "P&ost Shipment"

        //Get the posted Ret Order No.

        RetShipmentHdr.Reset();
        RetShipmentHdr.SetRange("Return Order No.", PurchRetOrderNo);
        if RetShipmentHdr.FindFirst() then
            PostedReturnOrderNo := RetShipmentHdr."No.";

        //For Credit Memo processing
        PurchaseCrMemo.OPENNEW;
        PurchaseCrMemo."No.".ASSISTEDIT;
        PurchaseCrMemo."Buy-from Vendor Name".SETVALUE(Vendor."No.");
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseCrMemo."Location Code".SETVALUE(Location.Code);
        //HEI.51<<
        PurchaseCrMemo."Document Date".SETVALUE(0D);

        // ASSERTERROR PurchaseCrMemo.Post.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        asserterror PurchaseCrMemo.Post_Custom.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name


        if GetLastErrorText <> STRSUBSTNO(DocDateError, PurchaseCrMemo."No.") then
            Error('Unexpected Error: %1', GetLastErrorText);

        PurchaseCrMemo."Document Date".SETVALUE(Today);

        PrevCurrCode := '';
        PrevCurrCode := PurchaseCrMemo."Currency Code".VALUE;
        PurchCrMemoNo := PurchaseCrMemo."No.".VALUE;

        NotPopulateRec := false;
        //Go to Lines/Functions tab and click Get Return Shipment Line
        PurchaseCrMemo.PurchLines.GetReturnShipmentLines.INVOKE;




        ReservationEntry.Reset();
        ReservationEntry.SetRange(ReservationEntry."Item No.", Item."No.");
        ReservationEntry.SetRange(ReservationEntry."Source ID", PurchCrMemoNo);
        ReservationEntry.SetRange(ReservationEntry."Source Type", Database::"Purchase Line");
        ReservationEntry.SetRange(ReservationEntry."Source Subtype", 3);
        ReservationEntry.SetRange(ReservationEntry."Location Code", Location.Code);
        ReservationEntry.SetRange(ReservationEntry."Creation Date", Today);
        ReservationEntry.DeleteAll();

        PurchCrMemoLine.Reset();
        PurchCrMemoLine.SetRange(PurchCrMemoLine."Document Type", PurchCrMemoLine."Document Type"::"Credit Memo");
        PurchCrMemoLine.SetRange(PurchCrMemoLine."Document No.", PurchCrMemoNo);
        PurchCrMemoLine.DeleteAll();



        //Currency Checking
        OthCurrCode := '';
        CurrExChngRate.Reset();
        CurrExChngRate.SetFilter(CurrExChngRate."Currency Code", '<>%1', PrevCurrCode);
        CurrExChngRate.SetFilter(CurrExChngRate."Starting Date", '<=%1', Today);
        //HEI.113>>

        // BC Upgrade MISHRS14 >>
        // HEI.114 >> Blocked below line as in NAV
        //CurrExChngRate.SetFilter("Exchange Rate Amount", '<>0');
        // HEI.114 <<

        //HEI.113<<

        // HEI.114 >>
        //IF CurrExChngRate.FINDLAST THEN
        IF CurrExChngRate.FINDLAST THEN BEGIN
        IF CurrExChngRate."Exchange Rate Amount" = 0 THEN BEGIN
            CurrExChngRate."Exchange Rate Amount" := 1;
            CurrExChngRate.MODIFY(FALSE);
        END;
        //HEI.114<<
            OthCurrCode := CurrExChngRate."Currency Code";
        // HEI.114 >>
        end;
        // HEI.114 <<
        // BC Upgrade MISHRS14 <<    

        PurchaseCrMemo."Currency Code".SETVALUE(OthCurrCode);
        NotPopulateRec := true;


        PurchaseCrMemo.PurchLines.GetReturnShipmentLines.INVOKE;
        NotPopulateRec := false;
        PurchaseCrMemo."Currency Code".SETVALUE(PrevCurrCode);
        PurchaseCrMemo.PurchLines.GetReturnShipmentLines.INVOKE;

        //BC UPGRADE ATHUKS01 STP_FDD0007>>
        PurchaseCrMemo."Doc. Amount Incl. VAT IBM".SETVALUE(-1);
        PurchaseCrMemo."Doc. Amount VAT IBM".SETVALUE(-1);
        //BC UPGRADE ATHUKS01 STP_FDD0007<<

        PurchaseCrMemo."Vendor Cr. Memo No.".SETVALUE('StP PTP058');
        //HEI.51>>
        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseCrMemo."Location Code".SETVALUE(Location.Code);
        //HEI.51<<
        // ASSERTERROR PurchaseCrMemo.Post.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        asserterror PurchaseCrMemo.Post_Custom.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name

        //IF GETLASTERRORTEXT <> STRSUBSTNO(AmtError,PurchaseCrMemo."Doc. Amount Incl. VAT".VALUE,DocAmtInclVAT) THEN
        //BC UPGRADE ATHUKS01 STP_FDD0007>>
        if GetLastErrorText <> STRSUBSTNO(AmtError, PurchaseCrMemo."Doc. Amount Incl. VAT IBM".VALUE, PurchaseCrMemo.PurchLines."Total Amount Incl. VAT") then
            Error('Unexpected Error: %1', GetLastErrorText);

        PurchaseCrMemo."Vendor Cr. Memo No.".SETVALUE('');

        // ASSERTERROR PurchaseCrMemo.Post.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        asserterror PurchaseCrMemo.Post_Custom.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name

        if GetLastErrorText <> STRSUBSTNO(VendCrMemoNoError, PurchaseCrMemo."No.") then
            Error('Unexpected Error: %1', GetLastErrorText);
        //HEI.25<<
    end;

    [ModalPageHandler]
    procedure NewGetRetShipmentLineModalPageHandler(var GetReturnShipmentLines: TestPage "Get Return Shipment Lines");
    begin
        //HEI.25>>
        GetReturnShipmentLines.Filter.SetFilter("Document No.", PostedReturnOrderNo);
        if NotPopulateRec then
            GetReturnShipmentLines.Cancel.Invoke()
        else
            GetReturnShipmentLines.OK.Invoke();
        //HEI.25<<
    end;

    [PageHandler]
    procedure PurchCreditMemoModalPageHandler(var PurchaseCreditMemo: TestPage "Purchase Credit Memo");
    var
        PurchLn: Record "Purchase Line";
        DocAmount: Decimal;
        VATAmount: Decimal;
    begin
        //HEI.29>>
        PurchaseCreditMemo.Filter.SetFilter("Applies-to Doc. No.", StorePostedInvNo);
        PurchaseCreditMemo."Vendor Cr. Memo No.".SetValue('STP CRMemo PTP024');
        StoreCreditMemoNo := PurchaseCreditMemo."No.".Value;

        //PurchaseCreditMemo."Doc. Amount Incl. VAT".SetValue(PurchaseCreditMemo.PurchLines."Total Amount Incl. VAT".Value);
        //PurchaseCreditMemo."Doc. Amount VAT".SetValue(PurchaseCreditMemo.PurchLines."Total VAT Amount".Value);
        //HEI.29<<
    end;

    [Test]
    [HandlerFunctions('DimSetEntriesModalPageHandlerCMG,MessageHandler,ConfirmationHandler,ItemChargeAssignmentPurchModalPageHandler,PurReceiptLineModalPageHandler,DocShippingCostsDialogBoxModelPageHandler')]
    procedure CHG2123487_CMGMandatoryonHeiliteBaseSPOTPOforLandedCosts();
    var
        Vendor: Record Vendor;
        ItemCharge: Record "Item Charge";
        PurchaseQuote: TestPage "Purchase Quote";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        UserSetup: Record "User Setup";
        Location: Record Location;
        RequeststoApprove: TestPage "Requests to Approve";
        ApprovalEntries: TestPage "Approval Entries";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        PurchHdr: Record "Purchase Header";
        PurchQuoteNo: Code[20];
        JobQueueEntry: Record "Job Queue Entry";
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseLine: Record "Purchase Line";
        UserSetup2: Record "User Setup";
        PurchaseOrder: TestPage "Purchase Order";
        PurchOrderNo: Text;
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        ReceptNo: Code[10];
        Workflow: Record Workflow;
    // CreateDocumentShippingCost: TestPage 50161; //BC UPGRADE KUMARR78 >>DIT Variable Removed.
    begin
        //HEI.33>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2123487', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2123487', CompanyName, Database::"Item Charge");
        ItemCharge.Get(UnitTestingValues.Value);


        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2123487', CompanyName, Database::"User Setup");
        UserSetup.Get(UnitTestingValues.Value);


        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2123487', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);


        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2123487', CompanyName, Database::"Dimension Value");
        GeneralLedgerSetup.Get();
        if UnitTestingValues.Value <> '' then
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);
        Clear(CMGDimension);
        CMGDimension := UnitTestingValues."Value 2";
        //PQ Process
        PurchaseQuote.OpenNew();
        PurchaseQuote."Buy-from Vendor Name".SetValue(Vendor.Name);
        PurchaseQuote."Vendor Order No.".SetValue('TEST_CHG2123487');
        // PurchaseQuote."Requester ID".SETVALUE(UserSetup."User ID");//BC UPGRADE KUMARR78 DIT Field Removed.
        PurchaseQuote.PurchLines.Type.SetValue(Type::"Charge (Item)");
        PurchaseQuote.PurchLines."No.".SetValue(ItemCharge."No.");
        PurchaseQuote.PurchLines.Quantity.SetValue(1);
        PurchaseQuote.PurchLines."Location Code".SetValue(Location.Code);
        Clear(PurchQuoteNo);
        PurchQuoteNo := PurchaseQuote."No.".Value;
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        // JobQueueEntry.SetRange("Object ID to Run", 50085);
        JobQueueEntry.SetRange("Object ID to Run", 51015); // BC Upgrade BHARDA11
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        JobQueueEntry.SetRange("Object ID to Run", 1509);
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        JobQueueEntry.Reset();
        JobQueueEntry.SetFilter("Object Type to Run", '%1', JobQueueEntry."Object Type to Run"::Report);
        JobQueueEntry.SetRange("Object ID to Run", 111);
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;

        // PurchaseQuote.PurchLines.Action1901033504.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseQuote.PurchLines.Dimensions.Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name


        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", PurchaseQuote."No.".Value);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Quote);
        PurchaseLine.SetRange("No.", PurchaseQuote.PurchLines."No.".Value);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
            PurchaseLine.Modify();
        end;
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        PurchHdr.Get(PurchHdr."Document Type"::Quote, PurchQuoteNo);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchHdr) then begin
            PurchaseQuote.SendApprovalRequest.Invoke();
            ApprovalEntries.Trap();
            PurchaseQuote.Approvals.Invoke();
            UserSetup.Get(ApprovalEntries."Approver ID".Value);
            UserSetup.Substitute := UserId;
            UserSetup."Approval Administrator" := true;
            UserSetup.Modify();
            UserSetup2.Get(UserId);
            if not UserSetup2."Unlimited Purchase Approval" or not UserSetup2."Unlimited Request Approval" then begin
                UserSetup2."Unlimited Purchase Approval" := true;
                UserSetup2."Unlimited Request Approval" := true;
                UserSetup2.Modify();
            end;
            // ApprovalEntries.Action35.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
            ApprovalEntries."&Delegate".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name
            PurchaseQuote.Approve.Invoke();
        end;
        // PurchaseQuote."Make Order".INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseQuote.MakeOrder.Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

        PurchaseOrder.OpenView();
        PurchaseOrder.Filter.SetFilter("Quote No.", PurchQuoteNo);
        PurchaseOrder.Dimensions.Invoke();
        PurchaseOrder.Close();
        //PO Process
        PurchaseOrder.OpenNew();
        PurchaseOrder."Buy-from Vendor Name".SetValue(Vendor.Name);
        PurchaseOrder."Vendor Order No.".SetValue('TEST_CHG2123487');
        // PurchaseOrder."Requester ID".SETVALUE(UserSetup."User ID");//BC UPGRADE KUMARR78 DIT Field Removed.
        PurchaseOrder.PurchLines.Type.SetValue(Type::"Charge (Item)");
        PurchaseOrder.PurchLines."No.".SetValue(ItemCharge."No.");
        PurchaseOrder.PurchLines.Quantity.SetValue(1);
        PurchaseOrder.PurchLines."Location Code".SetValue(Location.Code);
        Clear(PurchOrderNo);
        PurchOrderNo := PurchaseOrder."No.".Value;
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        // JobQueueEntry.SetRange("Object ID to Run", 50085);
        JobQueueEntry.SetRange("Object ID to Run", 51015); // BC Upgrade BHARDA11
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        JobQueueEntry.SetRange("Object ID to Run", 1509);
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;
        JobQueueEntry.Reset();
        JobQueueEntry.SetFilter("Object Type to Run", '%1', JobQueueEntry."Object Type to Run"::Report);
        JobQueueEntry.SetRange("Object ID to Run", 111);
        JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::Ready);
        if JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry.Modify();
        end;

        PurchaseOrder.PurchLines.Dimensions.Invoke();
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", PurchaseOrder."No.".Value);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("No.", PurchaseOrder.PurchLines."No.".Value);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
            PurchaseLine.Modify();
        end;
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        PurchHdr.Get(PurchHdr."Document Type"::Order, PurchOrderNo);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchHdr) then
            PurchaseOrder.SendApprovalRequest.Invoke();
        PurchaseOrder.Close();



        //Creeate Document Shipping Cost
        PurchaseOrder.OpenNew();
        PurchaseOrder."Buy-from Vendor Name".SetValue(Vendor.Name);
        PurchaseOrder."Vendor Order No.".SetValue('CHG2123487');
        // PurchaseOrder."Requester ID".SETVALUE(UserSetup."User ID");//BC UPGRADE KUMARR78 DIT Field Removed.
        PurchaseOrder.PurchLines.Type.SetValue(Type::"Charge (Item)");
        PurchaseOrder.PurchLines."No.".SetValue(ItemCharge."No.");
        PurchaseOrder.PurchLines.Quantity.SetValue(1);
        PurchaseOrder.PurchLines."Location Code".SetValue(Location.Code);
        PurchaseOrder.PurchLines."Direct Unit Cost".SetValue(100);
        PurchaseOrder.PurchLines.Dimensions.Invoke();
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("Document No.", PurchaseOrder."No.".Value);
        PurchaseLine.SetRange("No.", PurchaseOrder.PurchLines."No.".Value);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Qty. to Receive", 1);
            PurchaseLine.Modify();
        end;
        PurchaseOrder.PurchLines.ItemChargeAssignment.Invoke();
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            //HEI.74>>
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            //IF Workflow.FINDSET THEN
            //REPEAT
            //Workflow.Enabled := FALSE;
            //Workflow.MODIFY;
            //UNTIL Workflow.NEXT = 0;
            //HEI.74<<
        end;
        PurchaseOrder.Release.Invoke();
        PurchaseOrder.Post.Invoke();

        // PurchaseOrder."Page Posted Purchase Receipts".INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseOrder.Receipts.Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

        Clear(ReceptNo);
        PurchRcptHeader.SetRange("Order No.", PurchaseOrder."No.".Value);
        if PurchRcptHeader.FindFirst() then
            ReceptNo := PurchRcptHeader."No.";
        PurchaseOrder.Close();

        //BC UPGRADE KUMARR78 >>DIT Variable Removed.
        // CreateDocumentShippingCost.OPENEDIT;
        // CreateDocumentShippingCost.FILTER.SETFILTER("Source No.", ReceptNo);
        // CreateDocumentShippingCost."Create Orders".INVOKE;
        //BC UPGRADE KUMARR78 <<DIT Variable Removed.
        //HEI.33<<
    end;

    [ModalPageHandler]
    procedure DimSetEntriesModalPageHandlerCMG(var EditDimensionSetEntries: TestPage "Edit Dimension Set Entries");
    begin
        //HEI.33>>
        EditDimensionSetEntries.New();
        EditDimensionSetEntries."Dimension Code".SetValue('CMG');
        EditDimensionSetEntries.DimensionValueCode.SetValue(CMGDimension);
        EditDimensionSetEntries.OK.Invoke();
        //HEI.33<<
    end;

    [ModalPageHandler]
    procedure DocShippingCostsDialogBoxModelPageHandler(var DocShippingCostsDialogBox: TestPage "Doc.ShipCostDialogBox CBN");
    begin
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,MessageHandler_PCN027')]
    procedure CHG2161266_RemoveReferencedTransferOrder();
    var
        PurchaseOrder: TestPage "Purchase Order";
        Vendor: Record Vendor;
        PL: Record "Purchase Line";
        Location: Record Location;
        TransferHeader: Record "Transfer Header";
        TransferOrderNo: Code[20];
        ErrTransferOrderExists: Label 'Related Transfer Order has not been deleted.';
        ShipmentMethod: Record "Shipment Method";
        Item: Record Item;
        ShipMethodFilter: Text[250];
        PurchaseReason: Record "Reason Code_Purchase FND";
        PurchLineRec: Record "Purchase Line";
        Workflow: Record Workflow;
    begin
        //HEI.69 >>
        //HEI.72 >>
        /*
        PnPSetup.GET;
        //HEI.70 >>
        ShipMethodFilter := STRSUBSTNO('<>%1', PnPSetup."Excluded Incoterms");
        Vendor.SETFILTER("Shipment Method Code", ShipMethodFilter);
        //HEI.70 <<
        Vendor.FILTERGROUP(2);
        Vendor.SETFILTER("Shipment Method Code", '<>%1', '');
        Vendor.FINDFIRST;

        Item.FINDFIRST;
        Location.FINDFIRST;

        ShipmentMethod.SETFILTER(Code, PnPSetup."Excluded Incoterms");
        ShipmentMethod.FINDFIRST;
        //HEI.97>>
        */
        PnPSetup.Get();

        ShipMethodFilter := StrSubstNo('<>%1', PnPSetup."Excluded Incoterms FND");

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2098629', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2098629', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2098629', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2098629', CompanyName, Database::"Lot No. Information");
        LotNoFilter := UnitTestingValues.Value;

        //HEI.79>>
        //ShipmentMethod.SETFILTER(Code,'<>%1',PnPSetup."Excluded Incoterms");
        ShipmentMethod.SetFilter(Code, ShipMethodFilter);
        //HEI.79<<
        ShipmentMethod.FindFirst();

        PurchaseReason.FindFirst();

        //Create PO
        PurchaseOrder.OpenNew();
        PurchaseOrder."Buy-from Vendor No.".SetValue(Vendor."No.");
        PurchaseOrder."Vendor Order No.".SetValue('CHG2161266');
        // PurchaseOrder."Requester ID".SETVALUE(USERID);//BC UPGRADE KUMARR78 DIT Field Removed.
        PurchaseOrder."Location Code".SetValue(Location.Code);
        PurchaseOrder."Shipment Method Code".SetValue(ShipmentMethod.Code);
        PurchaseOrder."Expctd Physical Delvry Date(Imp)".SetValue(Today);

        PurchaseOrder.PurchLines.Type.SetValue(PL.Type::Item);
        PurchaseOrder.PurchLines."No.".SetValue(Item."No.");
        PurchaseOrder.PurchLines.Quantity.SetValue(1);
        PurchaseOrder.PurchLines."Location Code".SetValue(PnPSetup."Location Code Imp Proc. FND");
        PurchaseOrder.PurchLines."Direct Unit Cost".SetValue(100);
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
            /*IF Workflow.FINDSET THEN
              REPEAT
                Workflow.Enabled := FALSE;
                Workflow.MODIFY;
              UNTIL Workflow.NEXT = 0;*/
        end;

        PurchLineRec.Reset();
        PurchLineRec.SetRange("Document Type", PurchLineRec."Document Type"::Order);
        PurchLineRec.SetRange("Document No.", PurchaseOrder."No.".Value);
        PurchLineRec.SetRange(Type, PurchLineRec.Type::Item);
        if PurchLineRec.FindSet() then
            repeat
                PurchLineRec.Validate("Exp Physical Del Date(Imp) FND", Today);
                PurchLineRec."Location Code" := PnPSetup."Location Code Imp Proc. FND";
                PurchLineRec.Modify();
            until PurchLineRec.Next() = 0;

        //To Release the Purchase Order
        PurchaseOrder.Release.Invoke();

        PurchaseHeader.CalcFields("TO Reference FND");
        PurchaseHeader.TestField("TO Reference FND");

        TransferOrderNo := PurchaseHeader."TO Reference FND";
        TransferHeader.Get(TransferOrderNo);
        TransferHeader.TestField("PO Reference FND", PurchaseHeader."No.");
        TransferHeader.TestField(Status, TransferHeader.Status::Released);

        PurchaseOrder.Reopen.Invoke();
        if TransferHeader.Get(TransferOrderNo) then
            Error(ErrTransferOrderExists);
        //HEI.69 <<
        //HEI.70 >>
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        PurchaseHeader.CalcFields("TO Reference FND");
        PurchaseHeader.TestField("TO Reference FND", '');
        //HEI.70 <<
        //HEI.72 <<
        //HEI.97<<

    end;

    [Test]
    [HandlerFunctions('POListModalPageHandler')]
    procedure CHG2161266_CreateAloneTransferOrder();
    var
        TransferOrder: TestPage "Transfer Order";
        Location: Record Location;
        TransferHeader: Record "Transfer Header";
        TransferOrderNo: Code[20];
        PurchaseHeader: Record "Purchase Header";
    begin
        //HEI.69 >>
        //HEI.72 >>
        //HEI.97>>
        //Location.FINDFIRST;
        PnPSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2098629', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);

        TransferOrder.OpenNew();
        TransferOrder."Transfer-from Code".SetValue(Location.Code);
        //HEI.98>>
        //TransferOrder."PO Reference".LOOKUP;
        TransferOrder."PO Reference".AssistEdit();
        //HEI.98<<
        TransferOrderNo := TransferOrder."No.".Value;
        TransferOrder.OK.Invoke();
        //HEI.98>>
        TransferHeader.Get(TransferOrderNo);
        TransferHeader.TestField("PO Reference FND");

        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, TransferHeader."PO Reference FND");
        PurchaseHeader.CalcFields("Import Identifier FND", "TO Reference FND");
        PurchaseHeader.TestField("Import Identifier FND", false);
        PurchaseHeader.TestField("TO Reference FND", '');
        //HEI.98<<
        //HEI.97<<
        //HEI.72 <<
        //HEI.69 <<
    end;

    [ModalPageHandler]
    procedure CHG2161266_POModalPageHandler(var PurchaseOrderList: TestPage "Purchase Order List");
    begin
        //HEI.69 >>
        //HEI.72 >>
        //HEI.97>>
        PurchaseOrderList.First();
        PurchaseOrderList.OK.Invoke();
        //HEI.97<<
        //HEI.72 <<
        //HEI.69 <<
    end;

    [ModalPageHandler]
    procedure POListModalPageHandler(var PurchaseOrderList: Page "Purchase Order List"; var Response: Action);
    begin
        //HEI.98
        Response := Action::LookupOK;
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,MessageHandler_PCN027,WhseRcptPageHandler,WhseShipPageHandler,ItemTrackingLinesModalPageHandler')]
    procedure CHG2098629_AutomaticCreationofTransferOrderforImportPO();
    var
        PurchaseQuote: TestPage "Purchase Quote";
        PurchaseOrder: TestPage "Purchase Order";
        Vendor: Record Vendor;
        PL: Record "Purchase Line";
        Location: Record Location;
        TransferHeader: Record "Transfer Header";
        TransferOrderNo: Code[20];
        ShipmentMethod: Record "Shipment Method";
        Item: Record Item;
        ShipMethodFilter: Text[250];
        ErrTransferOrderExists: Label 'Transfer Order Should not Exist';
        PurchQuoteNo: Code[30];
        TransferOrder: TestPage "Transfer Order";
        PurchaseReason: Record "Reason Code_Purchase FND";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        WarehouseShipment: TestPage "Warehouse Shipment";
        Workflow: Record Workflow;
    begin
        //HEI.77>>
        PnPSetup.Get();

        ShipMethodFilter := StrSubstNo('<>%1', PnPSetup."Excluded Incoterms FND");

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2098629', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2098629', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2098629', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2098629', CompanyName, Database::"Lot No. Information");
        LotNoFilter := UnitTestingValues.Value;

        //HEI.79>>
        //ShipmentMethod.SETFILTER(Code,'<>%1',PnPSetup."Excluded Incoterms");
        ShipmentMethod.SetFilter(Code, ShipMethodFilter);
        //HEI.79<<
        ShipmentMethod.FindFirst();

        PurchaseReason.FindFirst();

        //PQ Process
        PurchaseQuote.OpenNew();
        PurchaseQuote."Buy-from Vendor Name".SetValue(Vendor.Name);
        PurchaseQuote."Vendor Order No.".SetValue('TEST_CHG2098629');
        // PurchaseQuote."Requester ID".SETVALUE(USERID);//BC UPGRADE KUMARR78 DIT Field Removed.
        PurchaseQuote."Location Code".SetValue(Location.Code);
        PurchaseQuote."Shipment Method Code".SetValue(ShipmentMethod.Code);
        PurchaseQuote.PurchLines.Type.SetValue(PL.Type::Item);
        PurchaseQuote.PurchLines."No.".SetValue(Item."No.");
        PurchaseQuote.PurchLines.Quantity.SetValue(2);
        PurchaseQuote.PurchLines."Location Code".SetValue(PnPSetup."Location Code Imp Proc. FND");

        Clear(PurchQuoteNo);
        PurchQuoteNo := PurchaseQuote."No.".Value;
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Quote, PurchaseQuote."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
        end;

        PurchaseQuote.Release.Invoke();

        // PurchaseQuote."Make Order".INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseQuote.MakeOrder.Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name//Abhay
        //Opening Created PO
        PurchaseOrder.OpenEdit();
        PurchaseOrder.Filter.SetFilter("Quote No.", PurchQuoteNo);
        PurchaseOrder."Shipment Method Code".SetValue(ShipmentMethod.Code);
        PurchaseOrder."Expctd Physical Delvry Date(Imp)".SetValue(CalcDate('<4D>', Today));
        //HEI.79>>
        PurchaseOrder.PurchLines.First();
        PurchaseOrder.PurchLines."Location Code".SetValue(PnPSetup."Location Code Imp Proc. FND");
        //HEI.79<<
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);

        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
        end;

        //First Release and check that Transfer Order has been created or not.
        PurchaseOrder.Release.Invoke();
        PurchaseHeader.CalcFields("Import Identifier FND");
        PurchaseHeader.TestField("Import Identifier FND", true);
        PurchaseHeader.CalcFields("TO Reference FND");
        PurchaseHeader.TestField("TO Reference FND");

        TransferOrderNo := PurchaseHeader."TO Reference FND";
        TransferHeader.Get(TransferOrderNo);
        TransferHeader.TestField("PO Reference FND", PurchaseHeader."No.");
        TransferHeader.TestField(Status, TransferHeader.Status::Released);

        //Reopen the Order to check wether system has deleted the TO or not.
        PurchaseOrder.Reopen.Invoke();
        if TransferHeader.Get(TransferOrderNo) then
            Error(ErrTransferOrderExists);

        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        PurchaseHeader.CalcFields("TO Reference FND");
        PurchaseHeader.TestField("TO Reference FND", '');

        //Change the Qty and Unit Cost;
        PurchaseOrder."Purch. Reason Code".SetValue(PurchaseReason.Code);
        PurchaseOrder.PurchLines.First();
        PurchaseOrder.PurchLines.Quantity.SetValue(1);
        PurchaseOrder.PurchLines."Direct Unit Cost".SetValue(100);

        //Again release
        PurchaseOrder.Release.Invoke();

        PurchaseHeader.CalcFields("TO Reference FND");
        PurchaseHeader.TestField("TO Reference FND");

        // PurchaseOrder.Action149.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseOrder."Create &Whse. Receipt".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

        WarehouseReceipt.OpenView();
        WarehouseReceipt.Filter.SetFilter("Source No. FND", PurchaseOrder."No.".Value);

        //Store the PO No in warehouse receipt
        WhseRcptPONo := WarehouseReceipt."Source No.".Value;

        //Select Item Tracking Code
        WarehouseReceipt.WhseReceiptLines.ItemTrackingLines.Invoke();

        //Post The warehouse receipt
        WarehouseReceipt."Post Receipt".Invoke();
        PurchaseOrder.OK.Invoke();

        PurchRcptHdr.SetRange("Order No.", WhseRcptPONo);
        if PurchRcptHdr.FindFirst() then
            DocNo := PurchRcptHdr."No.";

        TransferOrderNo := PurchaseHeader."TO Reference FND";
        TransferHeader.Get(TransferOrderNo);
        TransferHeader.TestField("PO Reference FND", PurchaseHeader."No.");
        TransferHeader.TestField(Status, TransferHeader.Status::Released);

        TransferOrder.OpenEdit();
        TransferOrder.Filter.SetFilter("No.", TransferOrderNo);

        // TransferOrder.Action5778.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        TransferOrder."Create Whse. S&hipment".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name


        WarehouseShipment.OpenEdit();
        WarehouseShipment.Filter.SetFilter("Source No. FND", TransferOrder."No.".Value);
        WarehouseShipment.OK.Invoke();
    end;

    [PageHandler]
    procedure WhseShipPageHandler(var WarehouseShipment: Page "Warehouse Shipment");
    begin
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler')]
    procedure CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC1();
    var
        PurchaseInvList: TestPage "NPO Purchase Invoices";
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
        PurchaseInvoice: TestPage "NPO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        DueDate: Text;
        BankAccount: Text;
        PostedPurchInvHdr: Record "Purch. Inv. Header";
        StorePostedInvNo: Code[20];
        PostedPurchInv: TestPage "Posted Purchase Invoice";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        DimensionValue: Record "Dimension Value";
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseLine: Record "Purchase Line";
        EbfCombination: Record "Ebf Combination FND";
        DimensionValue1: Record "Dimension Value";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Location: Record Location;
        DefaultDimension: Record "Default Dimension";
        Workflow: Record Workflow;
    begin

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2095531', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2095531', CompanyName, Database::"G/L Account");
        GLAccount.Get(UnitTestingValues.Value);

        if DefaultDimension.Get(15, GLAccount."No.", 'TRD_PART') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;

        //BC UPGRADE KUMARR78 >>DIT Variable Removed.
        // IF PurchasesPayablesSetup.GET THEN
        //     IF PurchasesPayablesSetup."Show Posted Document No." THEN BEGIN
        //         PurchasesPayablesSetup."Show Posted Document No." := FALSE;
        //         PurchasesPayablesSetup.MODIFY;
        //     END;
        //BC UPGRADE KUMARR78 <<DIT Variable Removed.

        GeneralLedgerSetup.Get();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2095531', CompanyName, Database::"Dimension Value");
        if UnitTestingValues.Value <> '' then
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);

        UnitTestingValues.Get('CHG2095531', CompanyName, Database::"Dimension Value");
        if UnitTestingValues.Value <> '' then
            DimensionValue1.Get(GeneralLedgerSetup."Shortcut Dimension 1 Code", UnitTestingValues."Value 2");

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2095531', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);

        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue.Code);
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();

        PurchaseInvoice.OPENNEW;
        PurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");

        PurchaseInvoice."Vendor Invoice No.".SETVALUE('StP CHG2095531');
        PurchInvNo := PurchaseInvoice."No.".VALUE;

        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseInvoice."Location Code".SETVALUE(Location.Code);

        PurchaseInvoice.PurchLines.NPOType.SETVALUE(Type::"G/L Account");
        PurchaseInvoice.PurchLines."No.".SETVALUE(GLAccount."No.");
        PurchaseInvoice.PurchLines.Quantity.SETVALUE(1);

        PurchaseLine.Reset();
        PurchaseLine.SETRANGE("Document No.", PurchaseInvoice."No.".VALUE);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Invoice);
        PurchaseLine.SETRANGE("No.", PurchaseInvoice.PurchLines."No.".VALUE);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Shortcut Dimension 1 Code", DimensionValue1.Code);
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
            PurchaseLine.Modify();
        end;

        if (PurchaseInvoice."Vendor Bank Account".VALUE <> '') then
            BankAccount := PurchaseInvoice."Vendor Bank Account".VALUE
        else
            BankAccount := '';
        PurchaseInvoice."Vendor Bank Account".ASSERTEQUALS(BankAccount);
        DocAmount := 0;
        VATAmount := 0;
        PurchLn.Reset();
        PurchLn.SetRange("Document Type", PurchLn."Document Type"::Invoice);
        PurchLn.SetRange("Document No.", PurchInvNo);
        if PurchLn.FindSet() then
            repeat
                DocAmount += PurchLn."Amount Including VAT";
                VATAmount += (PurchLn."Amount Including VAT" - PurchLn.Amount);
            until PurchLn.Next() = 0;

        //BC UPGRADE KUMARR78 >>DIT Variable Removed.
        // PurchaseInvoice."Doc. Amount Incl. VAT".SETVALUE(DocAmount);
        // PurchaseInvoice."Doc. Amount VAT".SETVALUE(VATAmount);
        //BC UPGRADE KUMARR78 <<DIT Variable Removed.

        //Approval Process
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, PurchaseInvoice."No.".VALUE);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
        end;

        // PurchaseInvoice.Action120.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseInvoice."Re&lease".INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name

        PurchaseInvoice.Post.INVOKE;

        PostedPurchInvHdr.SetRange("Pre-Assigned No.", PurchInvNo);
        if PostedPurchInvHdr.FindFirst() then
            StorePostedInvNo := PostedPurchInvHdr."No.";

        PostedPurchInv.OpenView();
        PostedPurchInv.Filter.SetFilter("No.", StorePostedInvNo);
        PostedPurchInv."Payment Status".ASSERTEQUALS(paymentstatus::"Pending Review");
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,MessageHandler,WhseRcptPageHandler,ItemTrackingLinesModalPageHandler,GetReceiptLineModalPageHandler')]
    procedure CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC2();
    var
        PurchaseInvList: TestPage "PO Purchase Invoices";
        Vendor: Record Vendor;
        Item: Record Item;
        Location: Record Location;
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseQuote: TestPage "Purchase Quote";
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        PostedPurchInvHdr: Record "Purch. Inv. Header";
        PostedPurchInv: TestPage "Posted Purchase Invoice";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        UserSetup2: Record "User Setup";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        EbfCombination: Record "Ebf Combination FND";
        PurchaseLine: Record "Purchase Line";
        GeneralPostingSetup: Record "General Posting Setup";
        GLAccount: Record "G/L Account";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DimensionValue1: Record "Dimension Value";
        Bin: Record Bin;
        PurchQuoteNo: Code[20];
        DefaultDimension: Record "Default Dimension";
        MVMTDimensionValue: Record "Dimension Value";
        Workflow: Record Workflow;
    begin

        WarehouseReceiptHeader.DeleteAll();

        GeneralLedgerSetup.Get();
        if UserSetup.Get(UserId) then begin
            UserSetup."Allow Delete/Arc PO/Return FND" := true;
            UserSetup.Modify();
        end;

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2095531', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2095531', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2095531', CompanyName, Database::"Vendor Bank Account");
        VendorBankAccount.Get(Vendor."No.", UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2095531', CompanyName, Database::"Lot No. Information");
        LotNoFilter := UnitTestingValues.Value;

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2095531', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2095531', CompanyName, Database::Bin);
        Bin.Get(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2095531', CompanyName, Database::"Dimension Value");
        GeneralLedgerSetup.Get();
        if DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value) then;
        if DimensionValue1.Get(GeneralLedgerSetup."Shortcut Dimension 1 Code", UnitTestingValues."Value 2") then;
        //HEI.89>>
        MVMTDimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 3 Code", UnitTestingValues."Value 3");
        Clear(MVMTDimension);
        MVMTDimension := DimensionValue.Code;
        DefaultDimension.Reset();
        DefaultDimension.SetFilter("Value Posting", '<>%1', DefaultDimension."Value Posting"::" ");
        DefaultDimension.ModifyAll("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.89<<
        //PQ Process
        PurchaseQuote.OpenNew();
        PurchaseQuote."Buy-from Vendor Name".SetValue(Vendor.Name);
        PurchaseQuote."Vendor Order No.".SetValue('TEST_CHG2095531');
        // PurchaseQuote."Requester ID".SETVALUE(USERID);//BC UPGRADE KUMARR78 DIT Field Removed.
        PurchaseQuote."Location Code".SetValue(Location.Code);
        PurchaseQuote.PurchLines.Type.SetValue(PurchaseLine.Type::Item);
        PurchaseQuote.PurchLines."No.".SetValue(Item."No.");
        PurchaseQuote.PurchLines.Quantity.SetValue(1);
        PurchaseQuote.PurchLines."Location Code".SetValue(Location.Code);

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", PurchaseQuote."No.".Value);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Quote);
        PurchaseLine.SetRange("No.", PurchaseQuote.PurchLines."No.".Value);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Shortcut Dimension 1 Code", DimensionValue1.Code);
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
            PurchaseLine.Modify();
        end;

        Clear(PurchQuoteNo);
        PurchQuoteNo := PurchaseQuote."No.".Value;
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Quote, PurchaseQuote."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
        end;

        PurchaseQuote.Release.Invoke();

        // PurchaseQuote."Make Order".INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseQuote.MakeOrder.Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name
        //Opening Created PO
        PurchaseOrder.OpenEdit();
        PurchaseOrder.Filter.SetFilter("Quote No.", PurchQuoteNo);
        PurchaseOrder."Expctd Physical Delvry Date(Imp)".SetValue(CalcDate('<4D>', Today));

        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseOrder."Location Code".SetValue(Location.Code);

        PnPSetup.Get();
        if PnPSetup."Requester ID Mandatory FND" then; //BC UPGRADE KUMARR78 Adding Semicolon(;) to handle the sentence.
        // PurchaseOrder."Requester ID".SETVALUE(USERID);//BC UPGRADE KUMARR78 DIT Field Removed.


        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 1 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue1.Code);
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue1.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<

        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();

        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue.Code);
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", PurchaseOrder."No.".Value);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("No.", PurchaseOrder.PurchLines."No.".Value);
        if PurchaseLine.FindFirst() then begin
            if UpperCase(CompanyName) = UpperCase('Almaza') then
                PurchaseLine.Validate("Bin Code", Bin.Code);
            PurchaseLine.Modify();
        end;

        //PurchaseOrder.PurchLines.Dimensions.INVOKE;

        //Approval Process
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
        end;

        if GeneralPostingSetup.Get(Vendor."Gen. Bus. Posting Group", Item."Gen. Prod. Posting Group") then
            if GLAccount.Get(GeneralPostingSetup."Purchase Variance Account") then
                if GLAccount.Blocked = true then begin
                    GLAccount.Blocked := false;
                    GLAccount.Modify();
                end;

        Clear(GLAccount);
        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2095531', CompanyName, Database::"G/L Account");
        GLAccount.Get(UnitTestingValues.Value);

        if DefaultDimension.Get(15, GLAccount."No.", 'TRD_PART') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;

        //BC UPGRADE KUMARR78 >>DIT Variable Removed.
        // IF PurchasesPayablesSetup.GET THEN
        //     IF PurchasesPayablesSetup."Show Posted Document No." THEN BEGIN
        //         PurchasesPayablesSetup."Show Posted Document No." := FALSE;
        //         PurchasesPayablesSetup.MODIFY;
        //     END;
        //BC UPGRADE KUMARR78 <<DIT Variable Removed.

        PurchaseOrder.Release.Invoke();

        //Create Warehouse Receipt from PO

        // PurchaseOrder.Action149.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseOrder."Create &Whse. Receipt".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

        WarehouseReceipt.OpenView();
        WarehouseReceipt.Filter.SetFilter("Source No. FND", PurchaseOrder."No.".Value);

        //Store the PO No in warehouse receipt
        WhseRcptPONo := WarehouseReceipt."Source No.".Value;

        //Select Item Tracking Code
        WarehouseReceipt.WhseReceiptLines.ItemTrackingLines.Invoke();

        //Post The warehouse receipt
        WarehouseReceipt."Post Receipt".Invoke();
        PurchaseOrder.OK.Invoke();

        PurchRcptHdr.SetRange("Order No.", WhseRcptPONo);
        if PurchRcptHdr.FindFirst() then
            DocNo := PurchRcptHdr."No.";


        //Select PO Purchase Invoices from the list
        PurchaseInvoice.OPENNEW;
        PurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");

        PurchaseInvoice."Vendor Invoice No.".SETVALUE('StPCHG2095531');
        PurchInvNo := PurchaseInvoice."No.".VALUE;

        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseInvoice."Location Code".SETVALUE(Location.Code);

        PurchaseInvoice.PurchLines.Type.SETVALUE(Type::"G/L Account");
        PurchaseInvoice.PurchLines."No.".SETVALUE(GLAccount."No.");
        PurchaseInvoice.PurchLines.Quantity.SETVALUE(1);
        PurchaseInvoice.PurchLines."Direct Unit Cost".SETVALUE(10);

        PurchaseLine.Reset();
        PurchaseLine.SETRANGE("Document No.", PurchaseInvoice."No.".VALUE);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Invoice);
        PurchaseLine.SETRANGE("No.", PurchaseInvoice.PurchLines."No.".VALUE);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Shortcut Dimension 1 Code", DimensionValue1.Code);
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
            PurchaseLine.Modify();
        end;

        //GetReceipt line getting into Purchase Line
        PurchaseInvoice.PurchLines.GetReceiptLines.INVOKE;
        GetReceiptLines.OpenView();

        PurchaseInvoice."Vendor Bank Account".ASSERTEQUALS(PurchaseInvoice."Vendor Bank Account".VALUE);

        DocAmount := 0;
        VATAmount := 0;
        PurchLn.Reset();
        PurchLn.SetRange("Document Type", PurchLn."Document Type"::Invoice);
        PurchLn.SetRange("Document No.", PurchInvNo);
        if PurchLn.FindSet() then
            repeat
                DocAmount += PurchLn."Amount Including VAT";
                VATAmount += (PurchLn."Amount Including VAT" - PurchLn.Amount);
            until PurchLn.Next() = 0;

        //BC UPGRADE KUMARR78 >>DIT Variable Removed.
        // PurchaseInvoice."Doc. Amount Incl. VAT".SETVALUE(DocAmount);
        // PurchaseInvoice."Doc. Amount VAT".SETVALUE(VATAmount);
        //BC UPGRADE KUMARR78 <<DIT Variable Removed.

        //Approval Process
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, PurchaseInvoice."No.".VALUE);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
        end;

        // PurchaseInvoice.Action120.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseInvoice."Re&lease".INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name


        //  PurchaseInvoice.Post.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseInvoice.Post_Custom.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name

        PostedPurchInvHdr.SetRange("Pre-Assigned No.", PurchInvNo);
        if PostedPurchInvHdr.FindFirst() then
            StorePostedInvNo := PostedPurchInvHdr."No.";

        PostedPurchInv.OpenView();
        PostedPurchInv.Filter.SetFilter("No.", StorePostedInvNo);
        PostedPurchInv."Payment Status".ASSERTEQUALS(paymentstatus::"Pending Review");
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,MessageHandler,WhseRcptPageHandler,ItemTrackingLinesModalPageHandler,GetReceiptLineModalPageHandler')]
    procedure CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC3();
    var
        PurchaseInvList: TestPage "PO Purchase Invoices";
        Vendor: Record Vendor;
        Item: Record Item;
        Location: Record Location;
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseQuote: TestPage "Purchase Quote";
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        PostedPurchInvHdr: Record "Purch. Inv. Header";
        PostedPurchInv: TestPage "Posted Purchase Invoice";
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        UserSetup2: Record "User Setup";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        EbfCombination: Record "Ebf Combination FND";
        PurchaseLine: Record "Purchase Line";
        GeneralPostingSetup: Record "General Posting Setup";
        GLAccount: Record "G/L Account";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DimensionValue1: Record "Dimension Value";
        Bin: Record Bin;
        PurchQuoteNo: Code[20];
        DefaultDimension: Record "Default Dimension";
        MVMTDimensionValue: Record "Dimension Value";
        Workflow: Record Workflow;
    begin

        WarehouseReceiptHeader.DeleteAll();

        GeneralLedgerSetup.Get();
        if UserSetup.Get(UserId) then begin
            UserSetup."Allow Delete/Arc PO/Return FND" := true;
            UserSetup.Modify();
        end;

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2095531', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2095531', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2095531', CompanyName, Database::"Vendor Bank Account");
        VendorBankAccount.Get(Vendor."No.", UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2095531', CompanyName, Database::"Lot No. Information");
        LotNoFilter := UnitTestingValues.Value;

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2095531', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2095531', CompanyName, Database::Bin);
        Bin.Get(Location.Code, UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2095531', CompanyName, Database::"Dimension Value");
        GeneralLedgerSetup.Get();
        if DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value) then;
        if DimensionValue1.Get(GeneralLedgerSetup."Shortcut Dimension 1 Code", UnitTestingValues."Value 2") then;
        //HEI.89>>
        MVMTDimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 3 Code", UnitTestingValues."Value 3");
        Clear(MVMTDimension);
        MVMTDimension := DimensionValue.Code;
        DefaultDimension.Reset();
        DefaultDimension.SetFilter("Value Posting", '<>%1', DefaultDimension."Value Posting"::" ");
        DefaultDimension.ModifyAll("Value Posting", DefaultDimension."Value Posting"::" ");
        //HEI.89<<
        //1st PQ Process
        PurchaseQuote.OpenNew();
        PurchaseQuote."Buy-from Vendor Name".SetValue(Vendor.Name);
        PurchaseQuote."Vendor Order No.".SetValue('TEST_CHG2095531');
        // PurchaseQuote."Requester ID".SETVALUE(USERID);//BC UPGRADE KUMARR78 DIT Field Removed.
        PurchaseQuote."Location Code".SetValue(Location.Code);
        PurchaseQuote.PurchLines.Type.SetValue(PurchaseLine.Type::Item);
        PurchaseQuote.PurchLines."No.".SetValue(Item."No.");
        PurchaseQuote.PurchLines.Quantity.SetValue(1);
        PurchaseQuote.PurchLines."Location Code".SetValue(Location.Code);

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", PurchaseQuote."No.".Value);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Quote);
        PurchaseLine.SetRange("No.", PurchaseQuote.PurchLines."No.".Value);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Shortcut Dimension 1 Code", DimensionValue1.Code);
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
            PurchaseLine.Modify();
        end;

        Clear(PurchQuoteNo);
        PurchQuoteNo := PurchaseQuote."No.".Value;
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Quote, PurchaseQuote."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
        end;

        PurchaseQuote.Release.Invoke();

        // PurchaseQuote."Make Order".INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseQuote.MakeOrder.Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name
        //Opening Created PO
        PurchaseOrder.OpenEdit();
        PurchaseOrder.Filter.SetFilter("Quote No.", PurchQuoteNo);
        PurchaseOrder."Expctd Physical Delvry Date(Imp)".SetValue(CalcDate('<4D>', Today));

        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseOrder."Location Code".SetValue(Location.Code);

        PnPSetup.Get();
        if PnPSetup."Requester ID Mandatory FND" then; //BC UPGRADE KUMARR78 Adding Semicolon(;) to handle the sentence.
        // PurchaseOrder."Requester ID".SETVALUE(USERID);//BC UPGRADE KUMARR78 DIT Field Removed.


        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 1 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue1.Code);
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue1.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();

        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue.Code);
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", PurchaseOrder."No.".Value);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("No.", PurchaseOrder.PurchLines."No.".Value);
        if PurchaseLine.FindFirst() then begin
            if UpperCase(CompanyName) = UpperCase('Almaza') then
                PurchaseLine.Validate("Bin Code", Bin.Code);
            PurchaseLine.Modify();
        end;

        //PurchaseOrder.PurchLines.Dimensions.INVOKE;

        //Approval Process
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
        end;

        if GeneralPostingSetup.Get(Vendor."Gen. Bus. Posting Group", Item."Gen. Prod. Posting Group") then
            if GLAccount.Get(GeneralPostingSetup."Purchase Variance Account") then
                if GLAccount.Blocked = true then begin
                    GLAccount.Blocked := false;
                    GLAccount.Modify();
                end;

        Clear(GLAccount);
        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2095531', CompanyName, Database::"G/L Account");
        GLAccount.Get(UnitTestingValues.Value);

        if DefaultDimension.Get(15, GLAccount."No.", 'TRD_PART') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;

        //BC UPGRADE KUMARR78 >>DIT Variable Removed.
        // IF PurchasesPayablesSetup.GET THEN
        //     IF PurchasesPayablesSetup."Show Posted Document No." THEN BEGIN
        //         PurchasesPayablesSetup."Show Posted Document No." := FALSE;
        //         PurchasesPayablesSetup.MODIFY;
        //     END;
        //BC UPGRADE KUMARR78 <<DIT Variable Removed.

        PurchaseOrder.Release.Invoke();

        //Create Warehouse Receipt from PO

        // PurchaseOrder.Action149.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseOrder."Create &Whse. Receipt".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name
        WarehouseReceipt.OpenView();
        WarehouseReceipt.Filter.SetFilter("Source No. FND", PurchaseOrder."No.".Value);

        //Store the PO No in warehouse receipt
        WhseRcptPONo := WarehouseReceipt."Source No.".Value;

        //Select Item Tracking Code
        WarehouseReceipt.WhseReceiptLines.ItemTrackingLines.Invoke();

        //Post The warehouse receipt
        WarehouseReceipt."Post Receipt".Invoke();
        PurchaseOrder.OK.Invoke();

        PurchRcptHdr.SetRange("Order No.", WhseRcptPONo);
        if PurchRcptHdr.FindFirst() then
            DocNo := PurchRcptHdr."No.";
        // 1st PQ Close till GRN

        //2st PQ Process
        PurchaseQuote.OpenNew();
        PurchaseQuote."Buy-from Vendor Name".SetValue(Vendor.Name);
        PurchaseQuote."Vendor Order No.".SetValue('TEST_CHG2095531_2');
        // PurchaseQuote."Requester ID".SETVALUE(USERID);//BC UPGRADE KUMARR78 DIT Field Removed.
        PurchaseQuote."Location Code".SetValue(Location.Code);
        PurchaseQuote.PurchLines.Type.SetValue(PurchaseLine.Type::Item);
        PurchaseQuote.PurchLines."No.".SetValue(Item."No.");
        PurchaseQuote.PurchLines.Quantity.SetValue(1);
        PurchaseQuote.PurchLines."Location Code".SetValue(Location.Code);

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", PurchaseQuote."No.".Value);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Quote);
        PurchaseLine.SetRange("No.", PurchaseQuote.PurchLines."No.".Value);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Shortcut Dimension 1 Code", DimensionValue1.Code);
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
            PurchaseLine.Modify();
        end;

        Clear(PurchQuoteNo);
        PurchQuoteNo := PurchaseQuote."No.".Value;
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Quote, PurchaseQuote."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
        end;

        PurchaseQuote.Release.Invoke();

        // PurchaseQuote."Make Order".INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseQuote.MakeOrder.Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name
        //Opening Created PO
        PurchaseOrder.OpenEdit();
        PurchaseOrder.Filter.SetFilter("Quote No.", PurchQuoteNo);
        PurchaseOrder."Expctd Physical Delvry Date(Imp)".SetValue(CalcDate('<4D>', Today));

        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseOrder."Location Code".SetValue(Location.Code);

        PnPSetup.Get();
        if PnPSetup."Requester ID Mandatory FND" then; //BC UPGRADE KUMARR78 Adding Semicolon(;) to handle the sentence.
        // PurchaseOrder."Requester ID".SETVALUE(USERID);//BC UPGRADE KUMARR78 DIT Field Removed.


        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 1 Code");
        //HEI.78>>
        //EbfCombination.SETRANGE("Dimension Value Code",DimensionValue1.Code);
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue1.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        //HEI.78<<
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", PurchaseOrder."No.".Value);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("No.", PurchaseOrder.PurchLines."No.".Value);
        if PurchaseLine.FindFirst() then begin
            if UpperCase(CompanyName) = UpperCase('Almaza') then
                PurchaseLine.Validate("Bin Code", Bin.Code);
            PurchaseLine.Modify();
        end;

        //PurchaseOrder.PurchLines.Dimensions.INVOKE;

        //Approval Process
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);

        end;

        if GeneralPostingSetup.Get(Vendor."Gen. Bus. Posting Group", Item."Gen. Prod. Posting Group") then
            if GLAccount.Get(GeneralPostingSetup."Purchase Variance Account") then
                if GLAccount.Blocked = true then begin
                    GLAccount.Blocked := false;
                    GLAccount.Modify();
                end;

        Clear(GLAccount);
        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2095531', CompanyName, Database::"G/L Account");
        GLAccount.Get(UnitTestingValues.Value);

        if DefaultDimension.Get(15, GLAccount."No.", 'TRD_PART') then
            if DefaultDimension."Value Posting" <> DefaultDimension."Value Posting"::" " then begin
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" ";
                DefaultDimension.Modify();
            end;

        //BC UPGRADE KUMARR78 >>DIT Variable Removed.
        // IF PurchasesPayablesSetup.GET THEN
        //     IF PurchasesPayablesSetup."Show Posted Document No." THEN BEGIN
        //         PurchasesPayablesSetup."Show Posted Document No." := FALSE;
        //         PurchasesPayablesSetup.MODIFY;
        //     END;
        //BC UPGRADE KUMARR78 <<DIT Variable Removed.

        PurchaseOrder.Release.Invoke();

        //Create Warehouse Receipt from PO
        // PurchaseOrder.Action149.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseOrder."Create &Whse. Receipt".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name

        WarehouseReceipt.OpenView();
        WarehouseReceipt.Filter.SetFilter("Source No. FND", PurchaseOrder."No.".Value);

        //Store the PO No in warehouse receipt
        Clear(WhseRcptPONo);
        WhseRcptPONo := WarehouseReceipt."Source No.".Value;

        //Select Item Tracking Code
        WarehouseReceipt.WhseReceiptLines.ItemTrackingLines.Invoke();

        //Post The warehouse receipt
        WarehouseReceipt."Post Receipt".Invoke();
        PurchaseOrder.OK.Invoke();

        PurchRcptHdr.SetRange("Order No.", WhseRcptPONo);
        if PurchRcptHdr.FindFirst() then
            DocNo += '|' + PurchRcptHdr."No.";
        // 2st PQ Close till GRN


        //Select PO Purchase Invoices from the list
        PurchaseInvoice.OPENNEW;
        PurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor."No.");

        PurchaseInvoice."Vendor Invoice No.".SETVALUE('StP CHG2095531');
        PurchInvNo := PurchaseInvoice."No.".VALUE;

        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseInvoice."Location Code".SETVALUE(Location.Code);

        //GetReceipt line getting into Purchase Line
        PurchaseInvoice.PurchLines.GetReceiptLines.INVOKE;
        GetReceiptLines.OpenView();

        PurchaseInvoice."Vendor Bank Account".ASSERTEQUALS(PurchaseInvoice."Vendor Bank Account".VALUE);

        DocAmount := 0;
        VATAmount := 0;
        PurchLn.Reset();
        PurchLn.SetRange("Document Type", PurchLn."Document Type"::Invoice);
        PurchLn.SetRange("Document No.", PurchInvNo);
        if PurchLn.FindSet() then
            repeat
                DocAmount += PurchLn."Amount Including VAT";
                VATAmount += (PurchLn."Amount Including VAT" - PurchLn.Amount);
            until PurchLn.Next() = 0;

        //BC UPGRADE KUMARR78 >>DIT Variable Removed.
        // PurchaseInvoice."Doc. Amount Incl. VAT".SETVALUE(DocAmount);
        // PurchaseInvoice."Doc. Amount VAT".SETVALUE(VATAmount);
        //BC UPGRADE KUMARR78 <<DIT Variable Removed.

        //Approval Process
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice, PurchaseInvoice."No.".VALUE);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);

        end;

        // PurchaseInvoice.Action120.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseInvoice."Re&lease".INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name

        //  PurchaseInvoice.Post.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseInvoice.Post_Custom.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name


        PostedPurchInvHdr.SetRange("Pre-Assigned No.", PurchInvNo);
        if PostedPurchInvHdr.FindFirst() then
            StorePostedInvNo := PostedPurchInvHdr."No.";

        PostedPurchInv.OpenView();
        PostedPurchInv.Filter.SetFilter("No.", StorePostedInvNo);
        PostedPurchInv."Payment Status".ASSERTEQUALS(paymentstatus::"Payment Approved");
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,MessageHandler')]
    procedure CHG2095531_CorrectlyCalculatePaymentTermsOnVendorInvoices_TC4();
    var
        PurchaseLine: Record "Purchase Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        PurchaseHeader: Record "Purchase Header";
    begin

        UnitTestingValue.Get('CHG2095531', CompanyName, Database::"Purchase Header");
        PurchaseHeader.Get(PurchaseHeader."Document Type"::"Blanket Order", UnitTestingValue.Value);

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::"Blanket Order");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine.SetFilter("Qty. to Receive", '<>%1', 0);
        if PurchaseLine.FindSet() then begin
            repeat
                PurchaseLine.Validate("Qty. to Receive", 0);
                PurchaseLine.Modify(true);
            until PurchaseLine.Next() = 0;
        end;

        BlanketPurchaseOrder.OpenEdit();
        BlanketPurchaseOrder.Filter.SetFilter("No.", PurchaseHeader."No.");
        BlanketPurchaseOrder.Reopen.Invoke();
        //Step #2 update the line
        UnitTestingValue.SetRange("Test Script Code", 'CHG2095531');
        UnitTestingValue.SetRange("Table ID", 39);
        if UnitTestingValue.FindSet() then begin
            repeat
                BlanketPurchaseOrder.PurchLines.Filter.SetFilter("No.", UnitTestingValue."Value 3");
                BlanketPurchaseOrder.PurchLines.Filter.SetFilter("Block Line Ordering FND", ' ');

                PurchasesPayablesSetup.Get();
                if (PurchasesPayablesSetup."Excluded Incoterms FND" in ['DAP|DDP', 'DDP|DAP']) and (PurchasesPayablesSetup."Location Code Imp Proc. FND" <> '') then begin
                    if not (BlanketPurchaseOrder."Shipment Method Code".Value in ['DAP', 'DDP']) then begin
                        BlanketPurchaseOrder.PurchLines."Location Code".SetValue('');
                        BlanketPurchaseOrder.PurchLines."Consumption Location Code".SETVALUE(PurchasesPayablesSetup."Location Code Imp Proc. FND");
                    end;
                end;

                BlanketPurchaseOrder.PurchLines."Qty. to Receive".SetValue(UnitTestingValue.Value);
            until UnitTestingValue.Next() = 0;
        end;

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::"Blanket Order");
        PurchaseLine.SetRange("Document No.", BlanketPurchaseOrder."No.".Value);
        PurchaseLine.SetFilter("Qty. to Receive", '<>%1', 0);
        PurchaseLine.SetFilter("No.", '<>%1', BlanketPurchaseOrder.PurchLines."No.".Value);
        if PurchaseLine.FindSet() then begin
            repeat
                PurchaseLine.Validate("Qty. to Receive", 0);
                PurchaseLine.Modify(true);
            until PurchaseLine.Next() = 0;
        end;

        BlanketPurchaseOrder.MakeOrder.Invoke();
        BlanketPurchaseOrder.Close();
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler,FASplit_RequestPageHandler,FASplit_StrMenuHandler')]
    procedure CHG2065545_FA_PurchaseOrder();
    var
        PurchaseInvList: TestPage "PO Purchase Invoices";
        Vendor: Record Vendor;
        Item: Record Item;
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        GetReceiptLines: TestPage "Get Receipt Lines";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        Location: Record Location;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Bin: Record Bin;
        PurchaseLine: Record "Purchase Line";
        FASplitReport: Report "CTS Procure Add Cost V1 CBN";
        fixedAssets: Record "Fixed Asset";
        Workflow: Record Workflow;
    begin
        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2065545', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('CHG2065545', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);

        //Creation of PO
        PurchaseOrder.OpenNew();
        PurchaseOrder."No.".AssistEdit();
        PurchOrdNo := PurchaseOrder."No.".Value;
        PurchaseOrder."Buy-from Vendor No.".SetValue(Vendor."No.");
        PurchaseOrder."Vendor Invoice No.".SetValue('StP Unit Test CHG2065545');
        // PurchaseOrder."Requester ID".SETVALUE(USERID);//BC UPGRADE KUMARR78 DIT Field Removed.

        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseOrder."Location Code".SetValue(Location.Code);

        PurchaseOrder.OK.Invoke();

        PurchaseOrderList.OpenView();
        PurchaseOrderList.Filter.SetFilter("No.", PurchOrdNo);
        PurchaseOrder.OpenEdit();
        PurchaseOrder.Filter.SetFilter("No.", PurchOrdNo);
        Commit();
        //Line Part
        PurchaseOrder.PurchLines."Additional costs for FA".Invoke();

        //Closing PO Document
        PurchaseOrder.OK.Invoke();
        //Closing PO List Page
        PurchaseOrderList.OK.Invoke();

        PurchaseOrderList.OpenView();
        PurchaseOrderList.Filter.SetFilter("No.", PurchOrdNo);
        PurchaseOrder.OpenEdit();
        PurchaseOrder.Filter.SetFilter("No.", PurchOrdNo);

        //Approval Process
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);
        end;

        //Release Order
        PurchaseOrder.Release.Invoke();
        //Closing PO Document
        PurchaseOrder.OK.Invoke();
        //Closing PO List Page
        PurchaseOrderList.OK.Invoke();
    end;

    [RequestPageHandler]
    [HandlerFunctions('ConfirmationHandler')]
    procedure FASplit_RequestPageHandler(var "FA Split Report": TestRequestPage "CTS Procure Add Cost V1 CBN");
    begin

        "FA Split Report"."Total Amount".SetValue(1000);
        "FA Split Report"."Fixed Asset".SetFilter("No.", FindFixedAsset());
        "FA Split Report".OK.Invoke();
    end;

    [ReportHandler]
    [HandlerFunctions('ConfirmationHandler')]
    procedure FASplit_ReportHandler(var "FA Split Report": Report "CTS Procure Add Cost V1 CBN");
    begin
    end;

    [StrMenuHandler]
    procedure FASplit_StrMenuHandler(Option: Text[1024]; var Choice: Integer; Instruction: Text[1024]);
    begin
    end;

    local procedure FindFixedAsset(): Text[100];
    var
        FixedAsset: Record "Fixed Asset";
        FAFilter: Text[100];
        i: Integer;
    begin
        FAFilter := '';
        i := 0;
        FixedAsset.Reset();
        FixedAsset.SetRange(Blocked, false);
        if FixedAsset.FindFirst() then
            repeat
                i += 1;
                if FAFilter = '' then
                    FAFilter := FixedAsset."No."
                else
                    //HEI.81>>
                    FAFilter += '|' + FixedAsset."No.";

                if i = 5 then
                    exit(FAFilter);
            //  EXIT(FAFilter+'..'+FixedAsset."No.");
            //HEI.81<<
            until FixedAsset.Next() = 0;

        //HEI.77<<
    end;

    procedure GetEBFFilterPattern(var StartPosNoDigits: array[4] of Integer; var FilterOperator: Text);
    var
        GeneralOpCoSetup: Record "General OpCo Setup FND";
    begin
        //HEI.84>>
        /*
        //HEI.78>>
        GeneralOpCoSetup.GET();
        //HEI.79>>
        //IF GeneralOpCoSetup."EBF SCOA Range Digit Nos." = 0 THEN
        //  StartPosNoDigits[1] := 1
        //ELSE
        //  StartPosNoDigits[1] := GeneralOpCoSetup."EBF SCOA Range Digit Nos.";

        IF GeneralOpCoSetup."EBF SCOA Range Start Position" = 0 THEN
          StartPosNoDigits[1] := 1
        ELSE
          StartPosNoDigits[1] := GeneralOpCoSetup."EBF SCOA Range Start Position";
        //HEI.79<<

        IF GeneralOpCoSetup."EBF SCOA Range Digit Nos." = 0 THEN
          StartPosNoDigits[2] := 5
        ELSE
          StartPosNoDigits[2] := GeneralOpCoSetup."EBF SCOA Range Digit Nos.";

        IF GeneralOpCoSetup."EBF Dim Filter Start Position" = 0 THEN
          StartPosNoDigits[3] := 3
        ELSE
          StartPosNoDigits[3] := GeneralOpCoSetup."EBF Dim Filter Start Position";

        IF GeneralOpCoSetup."EBF Dim Filter Digit Nos." = 0 THEN
          StartPosNoDigits[4] := 4
        ELSE
          StartPosNoDigits[4] := GeneralOpCoSetup."EBF Dim Filter Digit Nos." ;

        IF GeneralOpCoSetup."EBF Operator Filter" = '' THEN
          FilterOperator := '*'
        ELSE
          FilterOperator := GeneralOpCoSetup."EBF Operator Filter" ;
        //HEI.78<<

        //HEI.79>>
        */
        //HEI.84<<

    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,MessageHandler,WhseRcptPageHandler,ItemTrackingLinesModalPageHandler,GetReceiptLineModalPageHandler,SuggestVendorPayment_RequestPageHandler2,UnapplyEntriesModalPageHandler')]
    procedure PTP103_PaymentAlongWithAppliedAndUnappliedEntry();
    var
        PurchaseInvList: TestPage "PO Purchase Invoices";
        Vendor: Record Vendor;
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        "Item Charge": Record "Item Charge";
        GetReceiptLines: TestPage "Purch. Receipt Lines";
        ItemChargeAssignmentPurch: TestPage "Item Charge Assignment (Purch)";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        GetReceiptLines2: TestPage "Get Receipt Lines";
        PurchInvHeader: Record "Purch. Inv. Header";
        PostedPurchaseInvoices: TestPage "Posted Purchase Invoices";
        PostInvNo: Text;
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        PurchaseHeader: Record "Purchase Header";
        "WHT Business Posting Group FND": Record "WHT Business Posting Group FND";
        GeneralLedgerSetup: Record "General Ledger Setup";
        CompanyInformation: Record "Company Information";
        PurchaseLine: Record "Purchase Line";
        DimensionValue: Record "Dimension Value";
        DimensionValueMVMT: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        Item: Record Item;
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder1: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        GenJnlTable: Record "Gen. Journal Line";
        GenJnlBatch: Record "Gen. Journal Batch";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        GenJournalLine: Record "Gen. Journal Line";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        VendorLedgerEntries: TestPage "Vendor Ledger Entries";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        PayJnlTree: TestPage "Payment Journal Tree CBN";
        Bin: Record Bin;
        Location: Record Location;
        GeneralPostingSetup: Record "General Posting Setup";
        EBFErrText: Label 'Are you sure you want to post combination of account %1 with dimension %2';
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        GLAccount: Record "G/L Account";
        TestGenJournalBatch: Record "Gen. Journal Batch";
        GenJournalTemplate: Record "Gen. Journal Template";
        decInvRoundAmount: Decimal;
        PutVendNo: Codeunit "Error Message Hide TestScripts";
    begin
        DimensionRestrictionCheck();//HEI.95
        WarehouseReceiptHeader.DeleteAll();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);
        Vendor."E-Mail 2 FND" := 'unittesting@heineken.com';
        Vendor.Modify();

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::"User Setup");
        UserSetup.Get(UnitTestingValues.Value);

        UserSetup."E-Mail" := 'unittesting@heineken.com';
        UserSetup.Modify();

        CompanyInformation.Get();
        CompanyInformation."E-Mail" := 'unittesting@heineken.com';
        CompanyInformation.Modify();
        //HEI.98>>
        /*
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PCN023',COMPANYNAME,DATABASE::Item);
        Item.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PCN023',COMPANYNAME,DATABASE::Bin);
        Bin.GET(UnitTestingValues."Value 2",UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PCN023',COMPANYNAME,DATABASE::Location);
        Location.GET(UnitTestingValues.Value);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PCN023',COMPANYNAME,DATABASE::"Lot No. Information");
        LotNoFilter := UnitTestingValues.Value;

        UnitTestingValues.GET('PCN023',COMPANYNAME,DATABASE::"Dimension Value");
        GeneralLedgerSetup.GET;
        IF UnitTestingValues.Value<>'' THEN
          DimensionValue.GET(GeneralLedgerSetup."Shortcut Dimension 2 Code",UnitTestingValues.Value);

        CLEAR(EBFWarnConf);
        IF GeneralPostingSetup.GET(Vendor."Gen. Bus. Posting Group","Item Charge"."Gen. Prod. Posting Group") THEN
          EBFWarnConf:=STRSUBSTNO(EBFErrText,GeneralPostingSetup."Purch. Account",Item."Global Dimension 2 Code");

        PurchaseOrder1.OPENNEW;
        PurchaseOrder1."Buy-from Vendor No.".SETVALUE(Vendor."No.");
        PurchaseOrder1."Vendor Invoice No.".SETVALUE('StP Unit Test PCN0XX');
        PurchaseOrder1."Requester ID".SETVALUE(UserSetup."User ID");

        IF PurchasesPayablesSetup.GET THEN
          IF PurchasesPayablesSetup."Mandatory Region on Header"=TRUE THEN
            PurchaseOrder1."Location Code".SETVALUE(Location.Code);

        PurchaseOrder1.PurchLines.Type.SETVALUE(Type::Item);
        PurchaseOrder1.PurchLines."No.".SETVALUE(Item."No.");
        PurchaseOrder1.PurchLines.Quantity.SETVALUE(1);
        PurchaseOrder1.PurchLines."Location Code".SETVALUE(Location.Code);

        PurchaseLine.RESET;
        PurchaseLine.SETRANGE("Document Type",PurchaseLine."Document Type"::Order);
        PurchaseLine.SETRANGE("Document No.",PurchaseOrder1."No.".VALUE);
        PurchaseLine.SETRANGE("No.",PurchaseOrder1.PurchLines."No.".VALUE);
        IF PurchaseLine.FINDFIRST THEN BEGIN
          PurchaseLine.VALIDATE("Bin Code",Bin.Code);
          PurchaseLine.VALIDATE("Shortcut Dimension 2 Code",DimensionValue.Code);//HEI.40
          PurchaseLine.MODIFY;
        END;

        //Disable Workflows before Release
        PurchaseHeader.GET(PurchaseHeader."Document Type"::Order,PurchaseOrder1."No.".VALUE);
        IF ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) THEN BEGIN
          Workflow.SETRANGE(Enabled,TRUE);
          IF Workflow.FINDFIRST THEN
          Workflow.MODIFYALL(Enabled,FALSE);

        END;

        IF GeneralPostingSetup.GET(Vendor."Gen. Bus. Posting Group",Item."Gen. Prod. Posting Group") THEN
          IF GLAccount.GET(GeneralPostingSetup."Purchase Variance Account") THEN
            IF GLAccount.Blocked=TRUE THEN BEGIN
              GLAccount.Blocked:=FALSE;
              GLAccount.MODIFY;
            END;

        PurchaseOrder1.Release.INVOKE;
        PurchaseOrder1.Action149.INVOKE;
        WarehouseReceipt.OPENVIEW;
        WarehouseReceipt.FILTER.SETFILTER("Source No.",PurchaseOrder1."No.".VALUE);

        //Store the PO No in warehouse receipt
        WhseRcptPONo := WarehouseReceipt."Source No.".VALUE;

        //Select Item Tracking Code
        WarehouseReceipt.WhseReceiptLines.ItemTrackingLines.INVOKE;

        //Post The warehouse receipt
        WarehouseReceipt."Post Receipt".INVOKE;
        PurchaseOrder1.OK.INVOKE;

        PurchRcptHdr.SETRANGE("Order No.",WhseRcptPONo);
        IF PurchRcptHdr.FINDFIRST THEN
          DocNo := PurchRcptHdr."No.";

        //Purchase Invoice Posting

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PTP018',COMPANYNAME,DATABASE::"WHT Business Posting Group FND");
        "WHT Business Posting Group FND".GET(UnitTestingValues.Value);

        GeneralLedgerSetup.GET;

        EbfCombination.RESET;
        EbfCombination.SETRANGE("Dimension Code",GeneralLedgerSetup."Shortcut Dimension 2 Code",GeneralLedgerSetup."Shortcut Dimension 3 Code"); //HEI.85
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        EbfCombination.SETFILTER("Combination Restriction",'<>%1',EbfCombination."Combination Restriction"::" ");
        EbfCombination.DELETEALL();

        PurchaseInvoice.OPENNEW;
        PurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor.Name);
        PurchaseInvoice."Vendor Invoice No.".SETVALUE('StP Script PTP');
        VendorNo:=Vendor."No.";
        PurchaseInvoice.PurchLines.GetReceiptLines.INVOKE;
        CompanyInformation.GET;
        CLEAR(InvNo);
        InvNo:=PurchaseInvoice."No.".VALUE;

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PTP018',COMPANYNAME,DATABASE::"Dimension Value");
        GeneralLedgerSetup.GET;
        DimensionValueMVMT.GET(GeneralLedgerSetup."Shortcut Dimension 3 Code",UnitTestingValues."Value 2");
        CLEAR(MVMTDimension);
        MVMTDimension:=UnitTestingValues."Value 2";
        PurchaseInvoice.Dimensions.INVOKE;
        //HEI.93>>
        {PurchaseLine.RESET;
        PurchaseLine.SETRANGE("Document Type",PurchaseLine."Document Type"::Invoice);
        PurchaseLine.SETRANGE("Document No.",PurchaseInvoice."No.".VALUE);
        PurchaseLine.SETFILTER(Type,'<>%1',PurchaseLine.Type::" ");
        IF PurchaseLine.FINDFIRST THEN BEGIN
          IF (PurchaseLine."CAD Amount"<>0) AND
           (CompanyInformation."Country/Region Code"<>Vendor."Country/Region Code") THEN
           PurchaseLine.VALIDATE("VAT Prod. Posting Group",'NO_VAT');
          PurchaseLine.VALIDATE("Shortcut Dimension 2 Code",DimensionValue.Code);
          PurchaseLine.MODIFY;
        END;
        PurchaseInvoice."Doc. Amount Incl. VAT".SETVALUE(PurchaseInvoice.PurchLines."Total Amount Incl. VAT".VALUE);
        PurchaseInvoice."Doc. Amount VAT".SETVALUE(PurchaseInvoice.PurchLines."Total VAT Amount".VALUE);
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('BRASCO') THEN BEGIN
          PurchaseLine.RESET;
          PurchaseLine.SETRANGE("Document Type",PurchaseLine."Document Type"::Invoice);
          PurchaseLine.SETRANGE("Document No.",PurchaseInvoice."No.".VALUE);
          PurchaseLine.SETFILTER(Type,'<>%1',PurchaseLine.Type::" ");
          IF PurchaseLine.FINDFIRST THEN BEGIN
            PurchaseInvoice."Doc. Amount Incl. VAT".SETVALUE(PurchaseLine."Amount Including VAT");
            PurchaseInvoice."Doc. Amount VAT".SETVALUE(PurchaseLine."Amount Including VAT"-PurchaseLine.Amount);
          END;
        END;}

        VATAmount += (PurchLn."Amount Including VAT" - PurchLn.Amount);
        decInvRoundAmount := 0;
        PurchaseInvoice."Doc. Amount Incl. VAT".SETVALUE(PurchaseInvoice.PurchLines."Total Amount Incl. VAT".VALUE);
        PurchaseInvoice."Doc. Amount VAT".SETVALUE(PurchaseInvoice.PurchLines."Total VAT Amount".VALUE);

        IF (GeneralLedgerSetup."Inv. Rounding Precision (LCY)" = 1) AND (PurchaseInvoice."Currency Code".VALUE = '') THEN BEGIN
          decInvRoundAmount := -ROUND(PurchaseInvoice.PurchLines."Total Amount Incl. VAT".ASDECIMAL -
                               ROUND(PurchaseInvoice.PurchLines."Total Amount Incl. VAT".ASDECIMAL,GeneralLedgerSetup."Inv. Rounding Precision (LCY)"),
                               GeneralLedgerSetup."Amount Rounding Precision");
          PurchaseInvoice."Doc. Amount Incl. VAT".SETVALUE(PurchaseInvoice.PurchLines."Total Amount Incl. VAT".ASDECIMAL + decInvRoundAmount);
          PurchaseInvoice."Doc. Amount VAT".SETVALUE(PurchaseInvoice.PurchLines."Total VAT Amount".VALUE);
        END;

        //HEI.93<<

        IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice,InvNo) THEN
          PurchaseHeader.ADDLINK('C:\IBM\Suraj\TestScript.pdf','TestLinkPTP018');
        PurchaseInvoice.Post.INVOKE;

        PurchInvHeader.SETRANGE("Pre-Assigned No.",InvNo);
        //HEI.98>>
        //IF PurchInvHeader.FINDFIRST THEN BEGIN
        PurchInvHeader.FINDFIRST;
          PostInvNo := PurchInvHeader."No.";
          DueDate := PurchInvHeader."Due Date"+1; //HEI.85
          //END;
        //HEI.98<<
        InvNo := PostInvNo;

        PostedPurchaseInvoices.OPENVIEW;
        PostedPurchaseInvoices.FILTER.SETFILTER("No.",PostInvNo);
        PostedPurchaseInvoices."Payment Status".ASSERTEQUALS(paymentstatus::"Payment Approved");

        PostedPurchaseInvoices.OK.INVOKE;

        //Payment posting through
        //HEI.83>>
        //HEI.85>>
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PCN023',COMPANYNAME,80);
        GenJournalTemplate.GET(UnitTestingValues.Value);
        UnitTestingValues.RESET;
        UnitTestingValues.GET('PCN023',COMPANYNAME,DATABASE::"Gen. Journal Batch");
        TestGenJournalBatch.GET(GenJournalTemplate.Name,UnitTestingValues.Value);
        //HEI.85<<
        //HEI.84>>
        gGenJnlBatches.INIT;
        gGenJnlBatches.TRANSFERFIELDS(TestGenJournalBatch);
        gGenJnlBatches.Name := 'STPTest';
        gGenJnlBatches.INSERT;
        //HEI.84<<
        //gGenJnlBatches.RESET;
        //gGenJnlBatches.SETRANGE("Journal Template Name",'PAYMENTS');
        //IF gGenJnlBatches.FINDFIRST THEN;
        //HEI.83<<

        //Disabling Workflow
        Workflow.RESET;
        Workflow.SETRANGE(Enabled,TRUE);
          IF Workflow.FINDFIRST THEN
          Workflow.MODIFYALL(Enabled,FALSE);

        //Creating General Journal Entry
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name",gGenJnlBatches."Journal Template Name");
        IF GenJournalLine.FINDSET(FALSE,FALSE) THEN
          GenJournalLine.DELETEALL;

        //HEI.85>>
        GenJournalTemplate.RESET;
        GenJournalTemplate.SETFILTER(Name,'<>%1',gGenJnlBatches."Journal Template Name");
        IF GenJournalTemplate.FINDSET(FALSE,FALSE) THEN
          GenJournalTemplate.DELETEALL;
        //HEI.85<<

        PayJnlTree.OPENEDIT;
        PayJnlTree.CurrentJnlBatchName.SETVALUE(gGenJnlBatches.Name);
        COMMIT;
        PayJnlTree.SuggestVendorPayments.INVOKE;

        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name",gGenJnlBatches."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name",gGenJnlBatches.Name);
        //GenJournalLine.SETFILTER("Applies-to Doc. No.",'<>%1','');
        IF GenJournalLine.FINDFIRST THEN BEGIN
          //GenJournalLine.MODIFYALL("Posting Date",TODAY);
          ApplDocNo := GenJournalLine."Applies-to Doc. No.";
          DocNo := GenJournalLine."Document No.";
          END;

        PayJnlTree.Post.INVOKE;
        PayJnlTree.OK.INVOKE;
        */
        //HEI.98<<
        /*
        //Applied Entry
        {CurrencyCode :='';
        UnitTestingValues.RESET;

        UserSetup.GET(USERID);
        UserSetup."Allow Bypass WHT Validation":=TRUE;
        UserSetup.MODIFY;

        IF CompanyInformation.GET THEN
          IF CompanyInformation."Enable French Localization"=TRUE THEN BEGIN
            CompanyInformation."Enable French Localization":=FALSE;
            CompanyInformation.MODIFY;
          END;

        GeneralLedgerSetup.GET;
        GeneralLedgerSetup.VALIDATE("Allow Posting From",0D);
        GeneralLedgerSetup.MODIFY;

        VendorLedgerEntry.RESET;
        VendorLedgerEntry.SETRANGE("Vendor No.",Vendor."No.");
        VendorLedgerEntry.MODIFYALL("Applies-to ID",'');

        VendorLedgerEntries.OPENEDIT;
        VendorLedgerEntries.FILTER.SETFILTER("Vendor No.",VendorNo);
        VendorLedgerEntries.FILTER.SETFILTER("Document No.",PostInvNo);
        VendorLedgerEntries.FILTER.SETFILTER("Document Type",'Invoice');
        VendorLedgerEntries.FILTER.SETFILTER(Open,'Yes');
        //HEI.76>>
        VendorLedgerEntries.FIRST;
        CurrencyCode := VendorLedgerEntries."Currency Code".VALUE;
        //HEI.76<<
        VendorLedgerEntries.ActionApplyEntries.INVOKE;
        VendorLedgerEntries.OK.INVOKE;
        //HEI.07  <<
        }
        // Posting payment
        {CLEAR(GenJnlAccType);

        UnitTestingValues.RESET;
        UnitTestingValues.GET('PTP084',COMPANYNAME,DATABASE::"Gen. Journal Batch");
        gGenJnlBatches.GET(UnitTestingValues.Value,UnitTestingValues."Value 2");

        //Disabling Workflow
        Workflow.RESET;
        Workflow.SETRANGE(Enabled,TRUE);
          IF Workflow.FINDFIRST THEN
          Workflow.MODIFYALL(Enabled,FALSE);

        //Creating General Journal Entry
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name",gGenJnlBatches."Journal Template Name");
        IF GenJournalLine.FINDSET(FALSE,FALSE) THEN
          GenJournalLine.DELETEALL;

        GeneralJournalTemplates.OPENVIEW;
        GeneralJournalBatches.TRAP;
        GeneralJournalTemplates.FILTER.SETFILTER(Name,gGenJnlBatches."Journal Template Name");
        GeneralJournalTemplates."Page General Journal Batches".INVOKE;
        GeneralJournalBatches.FILTER.SETFILTER(Name,gGenJnlBatches.Name);
        GenJnl.TRAP;
        GeneralJournalBatches.EditJournal.INVOKE;
        GenJnl.CurrentJnlBatchName.SETVALUE(gGenJnlBatches.Name);
        GenJnl."Posting Date".SETVALUE(TODAY);
        GenJnl."Document Type".SETVALUE(1);
        GenJnl."Account Type".SETVALUE(2);
        GenJnl."Account No.".SETVALUE(gVendor."No.");
        GenJnl.Amount.SETVALUE('1000.00');
        GenJnl."Bal. Account Type".SETVALUE(0);
        GenJnl."Bal. Account No.".SETVALUE(gChartofAccount."No.");
        IF GenJournalLine.GET(gGenJnlBatches."Journal Template Name",gGenJnlBatches.Name,GenJnl."Line No.".VALUE) THEN BEGIN
          GenJournalLine.VALIDATE("Document Date",TODAY);
          GenJournalLine.VALIDATE("External Document No.",'PTP103 New Script');
          GenJournalLine.MODIFY;
        END;

        IF UPPERCASE(COMPANYNAME) IN  [UPPERCASE('Bralirwa')] THEN
          MVMTDimension:='';
        GenJnl.Dimensions.INVOKE;
        GenJnl.Post.INVOKE;
        GenJnl.CLOSE;
        }
        */
        //HEI.86>>
        /*VendorLedgerEntry.RESET;
        VendorLedgerEntry.SETRANGE("Vendor No.",Vendor."No.");
        VendorLedgerEntry.SETRANGE("Document Type",VendorLedgerEntry."Document Type"::Invoice);
        VendorLedgerEntry.SETRANGE("Document No.",InvNo);
        IF VendorLedgerEntry.FINDFIRST THEN
        VendorLedgerEntry.TESTFIELD(Open,FALSE);*/
        //HEI.86<<
        //HEI.98>>
        // PutVendNo.ClearVendInvNo();
        // PutVendNo.PutVendInvNo('StP Script PTP5');
        PaymentPosting();//5
        //HEI.98<<
        //HEI.96>>
        //HEI.98>>
        /*VendorLedgerEntry.RESET;
        VendorLedgerEntry.SETRANGE("Vendor No.",Vendor."No.");
        VendorLedgerEntry.SETRANGE("Document Type",VendLedgEntry."Document Type"::Payment);
        VendorLedgerEntry.SETRANGE(Open,FALSE);
        //VendorLedgerEntry.SETRANGE("Posting Date",TODAY);//HEI.90 //HEI.91
        VendorLedgerEntry.SETFILTER("Journal Batch Name",'%1','STPTest'); //HEI.96
        //HEI.60>>
        IF UPPERCASE(COMPANYNAME) = '10_LUBUMBASHI' THEN
          VendorLedgerEntry.SETRANGE("Closed at Date",0D);
        //HEI.60<<
        IF VendorLedgerEntry.FINDFIRST THEN;*/
        //HEI.98<<
        //HEI.96<<
        // Unapply the Entry
        VendorLedgerEntries.OpenEdit();
        VendorLedgerEntries.Filter.SetFilter("Vendor No.", Vendor."No.");
        //HEI.96>>
        VendorLedgerEntries.Filter.SetFilter("Document Type", 'Payment');//HEI.96
        //VendorLedgerEntries.FILTER.SETFILTER("Document No.",InvNo);//HEI.85
        VendorLedgerEntries.Filter.SetFilter("Document No.", DocNo); //HEI.98
        //VendorLedgerEntries.FILTER.SETFILTER("Document No.",VendorLedgerEntry."Document No.");
        //HEI.96<<
        VendorLedgerEntries.Filter.SetFilter(Open, 'No');
        VendorLedgerEntries.Filter.SetFilter(Reversed, 'No');
        Clear(GenJouDocNo);
        GenJouDocNo := VendorLedgerEntries."Document No.".Value;
        VendorLedgerEntries.UnapplyEntries.Invoke();
        VendorLedgerEntries.Close();
        VendorLedgerEntries.OpenView();
        VendorLedgerEntries.Filter.SetFilter("Document No.", GenJouDocNo);
        VendorLedgerEntries.Filter.SetFilter("Document Type", 'Payment');
        VendorLedgerEntries.Close();

    end;

    [RequestPageHandler]
    procedure SuggestVendorPayment_RequestPageHandler2(var SuggestVendorPayment: TestRequestPage "Suggest Vendor Payments Hei");
    var
        Customer: Record Customer;
    begin
        SuggestVendorPayment.LastPaymentDate.SetValue(DueDate);
        //HEI.90>>
        //SuggestVendorPayment.PostingDate.SETVALUE(DueDate);
        SuggestVendorPayment.PostingDate.SetValue(Today);
        //HEI.90<<
        SuggestVendorPayment.UseDueDateAsPostingDate.SETVALUE(DueDate);//BC UPGRADE KUMARR78 CONF (ExecutionDate)

        //SuggestVendorPayment.StartingDocumentNo.SETVALUE(Test010); //HEI.85
        SuggestVendorPayment.VendorLedgerEntriesFilter.SETFILTER(SuggestVendorPayment.VendorLedgerEntriesFilter."Document No.", InvNo);//BC UPGRADE KUMARR78 CONF (VendorLedgerEntriesFilter DataitemName)
        SuggestVendorPayment.OK.Invoke();
        //HEI.79<<
    end;

    [Test]
    [HandlerFunctions('ConfirmationHandler,MessageHandler,WhseRcptPageHandler,ItemTrackingLinesModalPageHandler,GetReceiptLineModalPageHandler,SuggestVendorPayment_RequestPageHandler2')]
    procedure PaymentPosting();//5
    var
        PurchaseInvList: TestPage "PO Purchase Invoices";
        Vendor: Record Vendor;
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        "Item Charge": Record "Item Charge";
        GetReceiptLines: TestPage "Purch. Receipt Lines";
        ItemChargeAssignmentPurch: TestPage "Item Charge Assignment (Purch)";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        GetReceiptLines2: TestPage "Get Receipt Lines";
        PurchInvHeader: Record "Purch. Inv. Header";
        PostedPurchaseInvoices: TestPage "Posted Purchase Invoices";
        PostInvNo: Text;
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        PurchaseHeader: Record "Purchase Header";
        "WHT Business Posting Group FND": Record "WHT Business Posting Group FND";
        GeneralLedgerSetup: Record "General Ledger Setup";
        CompanyInformation: Record "Company Information";
        PurchaseLine: Record "Purchase Line";
        DimensionValue: Record "Dimension Value";
        DimensionValueMVMT: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        Item: Record Item;
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder1: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        GenJnlTable: Record "Gen. Journal Line";
        GenJnlBatch: Record "Gen. Journal Batch";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        GenJournalLine: Record "Gen. Journal Line";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        VendorLedgerEntries: TestPage "Vendor Ledger Entries";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        PayJnlTree: TestPage "Payment Journal Tree CBN";
        Bin: Record Bin;
        Location: Record Location;
        GeneralPostingSetup: Record "General Posting Setup";
        EBFErrText: Label 'Are you sure you want to post combination of account %1 with dimension %2';
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        GLAccount: Record "G/L Account";
        TestGenJournalBatch: Record "Gen. Journal Batch";
        GenJournalTemplate: Record "Gen. Journal Template";
        decInvRoundAmount: Decimal;
        Workflow: Record Workflow;
        RecZone: Record Zone;
        WhseEmpDTW: record 50356;
        WarRecLin: Record "Warehouse Receipt Line";
        WarEmployee: Record "Warehouse Employee";
        WhseDocNo: code[20];
        GetVendInvNo: Codeunit "Error Message Hide TestScripts";
        gGenJnlBatches: Record "Gen. Journal Batch";
        GenJournalTemplateTemp: Record "Gen. Journal Template" temporary;
        GenJnlTemp: Record "Gen. Journal Template";
    begin
        //    clear(VendInvNo);// := '';
        DimensionRestrictionCheck();//HEI.95
        //HEI.82>>
        WarehouseReceiptHeader.DeleteAll();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);
        //HEI.85>>
        Vendor."E-Mail 2 FND" := 'unittesting@heineken.com';
        Vendor.Modify();
        //HEI.85<<
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::"User Setup");
        UserSetup.Get(UnitTestingValues.Value);
        //HEI.85>>
        UserSetup."E-Mail" := 'unittesting@heineken.com';
        UserSetup.Modify();

        CompanyInformation.Get();
        CompanyInformation."E-Mail" := 'unittesting@heineken.com';
        CompanyInformation.Modify();
        //HEI.85<<

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::Bin);
        Bin.Get(UnitTestingValues."Value 2", UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::"Lot No. Information");
        LotNoFilter := UnitTestingValues.Value;

        UnitTestingValues.Get('PCN023', CompanyName, Database::"Dimension Value");
        GeneralLedgerSetup.Get();
        if UnitTestingValues.Value <> '' then
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);

        Clear(EBFWarnConf);
        if GeneralPostingSetup.Get(Vendor."Gen. Bus. Posting Group", "Item Charge"."Gen. Prod. Posting Group") then
            EBFWarnConf := StrSubstNo(EBFErrText, GeneralPostingSetup."Purch. Account", Item."Global Dimension 2 Code");

        PurchaseOrder1.OpenNew();
        PurchaseOrder1."Buy-from Vendor No.".SetValue(Vendor."No.");
        PurchaseOrder1."Vendor Invoice No.".SetValue('StP Unit Test PCN0XX');
        // PurchaseOrder1."Requester ID".SETVALUE(UserSetup."User ID");//BC UPGRADE KUMARR78 DIT Field Removed.

        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseOrder1."Location Code".SetValue(Location.Code);

        PurchaseOrder1.PurchLines.Type.SetValue(Type::Item);
        PurchaseOrder1.PurchLines."No.".SetValue(Item."No.");
        PurchaseOrder1.PurchLines.Quantity.SetValue(1);
        PurchaseOrder1.PurchLines."Location Code".SetValue(Location.Code);

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("Document No.", PurchaseOrder1."No.".Value);
        PurchaseLine.SetRange("No.", PurchaseOrder1.PurchLines."No.".Value);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Bin Code", Bin.Code);
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);//HEI.40
            PurchaseLine.Modify();
        end;
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder1."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);

        end;

        if GeneralPostingSetup.Get(Vendor."Gen. Bus. Posting Group", Item."Gen. Prod. Posting Group") then
            if GLAccount.Get(GeneralPostingSetup."Purchase Variance Account") then
                if GLAccount.Blocked = true then begin
                    GLAccount.Blocked := false;
                    GLAccount.Modify();
                end;
        PurchaseOrder1."Due Date".SetValue(Today);//HEI.98

        PurchaseOrder1.Release.Invoke();
        // BC Upgrade BHARAD11 >>
        Reczone.reset;
        Reczone.setrange("Location Code", Location.code);
        reczone.findfirst();
        WhseEmpDTW.init();
        WhseEmpDTW."User ID" := userid;
        WhseEmpDTW."location Code" := Location.code;
        WhseEmpDTW."zone Code" := RecZone.Code;
        if WhseEmpDTW.insert() then;
        // error(Reczone.code);
        Bin.reset();
        Bin.SetRange("Zone Code", RecZone.code);
        bin.findfirst();
        WarEmployee.init();
        WarEmployee."User ID" := userid;
        waremployee."location Code" := Location.code;
        if WarEmployee.insert() then;
        // BC Upgrade BHARAD11 <<
        // PurchaseOrder1.Action149.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseOrder1."Create &Whse. Receipt".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action NamePurchaseOrder1.Action149.INVOKE;
        WarehouseReceipt.OpenView();
        WarehouseReceipt.Filter.SetFilter("Source No. FND", PurchaseOrder1."No.".Value);

        //Store the PO No in warehouse receipt
        WhseRcptPONo := WarehouseReceipt."Source No.".Value;
        WhseDocNo := WarehouseReceipt."No.".value; // BC Upgrade BHARDA11
                                                   // BC Upgrade BHARDA11 
                                                   // BC Upgrade BHARDA11 >>
        WarRecLin.reset();
        WarRecLin.SetRange("No.", WhseDocNo);
        WarRecLin.findset();
        WarRecLin.Validate("Zone Code", RecZone.Code);
        WarRecLin.Validate("Bin Code", Bin.Code);
        WarRecLin.modify();

        // BC Upgrade BHARDA11 <<
        //Select Item Tracking Code
        WarehouseReceipt.WhseReceiptLines.ItemTrackingLines.Invoke();

        //Post The warehouse receipt
        WarehouseReceipt."Post Receipt".Invoke();
        PurchaseOrder1.OK.Invoke();

        PurchRcptHdr.SetRange("Order No.", WhseRcptPONo);
        if PurchRcptHdr.FindFirst() then
            DocNo := PurchRcptHdr."No.";

        //Purchase Invoice Posting

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP018', CompanyName, Database::"WHT Business Posting Group FND");
        "WHT Business Posting Group FND".Get(UnitTestingValues.Value);

        GeneralLedgerSetup.Get();

        EbfCombination.Reset();
        EbfCombination.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code", GeneralLedgerSetup."Shortcut Dimension 3 Code"); //HEI.85
        //HEI.84>>
        //GetEBFFilterPattern(StartPosNoDigits,FilterOperator);
        //EbfCombination.SETFILTER("Dimension Value Code", FilterOperator + COPYSTR(DimensionValue.Code,StartPosNoDigits[3],StartPosNoDigits[4]) + FilterOperator);
        //HEI.84<<
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DeleteAll();
        EntryNo := EntryNo + 1;
        PurchaseInvoice.OPENNEW;
        PurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor.Name);
        // if GetVendInvNo.GetVendInvNo() = '' then begin
        PurchaseInvoice."Vendor Invoice No.".SETVALUE('StP Script PTP' + format(EntryNo));
        // end else begin
        // PurchaseInvoice."Vendor Invoice No.".SETVALUE(GetVendInvNo.GetVendInvNo());
        // end;
        // GetVendInvNo.ClearVendInvNo();

        // if VendInvNo = '' then
        //     PurchaseInvoice."Vendor Invoice No.".SETVALUE('StP Script PTP');
        // if VendInvNo = '2' then
        //     PurchaseInvoice."Vendor Invoice No.".SETVALUE('StP Script PTP2');
        // if VendInvNo = '3' then
        //     PurchaseInvoice."Vendor Invoice No.".SETVALUE('StP Script PTP3');
        // if VendInvNo = '4' then
        //     PurchaseInvoice."Vendor Invoice No.".SETVALUE('StP Script PTP4');
        // if VendInvNo = '5' then
        //     PurchaseInvoice."Vendor Invoice No.".SETVALUE('StP Script PTP5');
        // Clear(VendInvNo);
        VendorNo := Vendor."No.";
        PurchaseInvoice.PurchLines.GetReceiptLines.INVOKE;
        CompanyInformation.Get();
        Clear(InvNo);
        InvNo := PurchaseInvoice."No.".VALUE;
        //HEI.98>>
        /*UnitTestingValues.RESET;
        UnitTestingValues.GET('PTP018',COMPANYNAME,DATABASE::"Dimension Value");
        GeneralLedgerSetup.GET;
        DimensionValueMVMT.GET(GeneralLedgerSetup."Shortcut Dimension 3 Code",UnitTestingValues."Value 2");
        CLEAR(MVMTDimension);
        MVMTDimension:=UnitTestingValues."Value 2";
        PurchaseInvoice.Dimensions.INVOKE;*///HEI.98<<
        //HEI.93>>
        /*PurchaseLine.RESET;
        PurchaseLine.SETRANGE("Document Type",PurchaseLine."Document Type"::Invoice);
        PurchaseLine.SETRANGE("Document No.",PurchaseInvoice."No.".VALUE);
        PurchaseLine.SETFILTER(Type,'<>%1',PurchaseLine.Type::" ");
        IF PurchaseLine.FINDFIRST THEN BEGIN
          IF (PurchaseLine."CAD Amount"<>0) AND
           (CompanyInformation."Country/Region Code"<>Vendor."Country/Region Code") THEN
           PurchaseLine.VALIDATE("VAT Prod. Posting Group",'NO_VAT');
          PurchaseLine.VALIDATE("Shortcut Dimension 2 Code",DimensionValue.Code);
          PurchaseLine.MODIFY;
        END;
        PurchaseInvoice."Doc. Amount Incl. VAT".SETVALUE(PurchaseInvoice.PurchLines."Total Amount Incl. VAT".VALUE);
        PurchaseInvoice."Doc. Amount VAT".SETVALUE(PurchaseInvoice.PurchLines."Total VAT Amount".VALUE);
        IF UPPERCASE(COMPANYNAME) = UPPERCASE('BRASCO') THEN BEGIN
          PurchaseLine.RESET;
          PurchaseLine.SETRANGE("Document Type",PurchaseLine."Document Type"::Invoice);
          PurchaseLine.SETRANGE("Document No.",PurchaseInvoice."No.".VALUE);
          PurchaseLine.SETFILTER(Type,'<>%1',PurchaseLine.Type::" ");
          IF PurchaseLine.FINDFIRST THEN BEGIN
            PurchaseInvoice."Doc. Amount Incl. VAT".SETVALUE(PurchaseLine."Amount Including VAT");
            PurchaseInvoice."Doc. Amount VAT".SETVALUE(PurchaseLine."Amount Including VAT"-PurchaseLine.Amount);
          END;
        END;*/
        VATAmount += (PurchLn."Amount Including VAT" - PurchLn.Amount);
        decInvRoundAmount := 0;

        //BC UPGRADE KUMARR78 >> DIT Variable Removed.
        PurchaseInvoice."Doc. Amount Incl. VAT IBM".SETVALUE(PurchaseInvoice.PurchLines."Total Amount Incl. VAT".VALUE);
        PurchaseInvoice."Doc. Amount VAT IBM".SETVALUE(PurchaseInvoice.PurchLines."Total VAT Amount".VALUE);
        //BC UPGRADE KUMARR78 << DIT Variable Removed.

        if (GeneralLedgerSetup."Inv. Rounding Precision (LCY)" = 1) and (PurchaseInvoice."Currency Code".VALUE = '') then begin
            decInvRoundAmount := -ROUND(PurchaseInvoice.PurchLines."Total Amount Incl. VAT".ASDECIMAL -
                                 ROUND(PurchaseInvoice.PurchLines."Total Amount Incl. VAT".ASDECIMAL, GeneralLedgerSetup."Inv. Rounding Precision (LCY)"),
                                 GeneralLedgerSetup."Amount Rounding Precision");

            //BC UPGRADE KUMARR78 >> DIT Variable Removed.
            PurchaseInvoice."Doc. Amount Incl. VAT IBM".SETVALUE(PurchaseInvoice.PurchLines."Total Amount Incl. VAT".ASDECIMAL + decInvRoundAmount);
            PurchaseInvoice."Doc. Amount VAT IBM".SETVALUE(PurchaseInvoice.PurchLines."Total VAT Amount".VALUE);
            //BC UPGRADE KUMARR78 << DIT Variable Removed.

        end;

        //HEI.93<<


        if PurchaseHeader.Get(PurchaseHeader."Document Type"::Invoice, InvNo) then
            PurchaseHeader.AddLink('C:\IBM\Suraj\TestScript.pdf', 'TestLinkPTP018');

        //  PurchaseInvoice.Post.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseInvoice.Post_Custom.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name


        PurchInvHeader.SetRange("Pre-Assigned No.", InvNo);
        if PurchInvHeader.FindFirst() then begin
            PostInvNo := PurchInvHeader."No.";
            DueDate := PurchInvHeader."Due Date" + 1; //HEI.85
        end;

        InvNo := PostInvNo;

        PostedPurchaseInvoices.OpenView();
        PostedPurchaseInvoices.Filter.SetFilter("No.", PostInvNo);
        PostedPurchaseInvoices."Payment Status".ASSERTEQUALS(paymentstatus::"Payment Approved");

        PostedPurchaseInvoices.OK.Invoke();

        //Payment posting through
        //HEI.83>>
        //HEI.85>>
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, 80);
        GenJournalTemplate.Get(UnitTestingValues.Value);
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::"Gen. Journal Batch");
        TestGenJournalBatch.Get(GenJournalTemplate.Name, UnitTestingValues.Value);
        //HEI.85<<
        //HEI.84>>
        gGenJnlBatches.Init();
        gGenJnlBatches.TransferFields(TestGenJournalBatch);
        // if GetVendInvNo.GetBatchName() = '' then begin
        gGenJnlBatches.Name := 'STPTest' + Format(EntryNo);
        // end else begin
        //     gGenJnlBatches.Name := GetVendInvNo.GetBatchName();
        // end;
        // GetVendInvNo.ClearBatchname();

        gGenJnlBatches."Payment Method Code FND" := Vendor."Payment Method Code";//HEI.98
        gGenJnlBatches.Insert();
        //HEI.84<<
        //gGenJnlBatches.RESET;
        //gGenJnlBatches.SETRANGE("Journal Template Name",'PAYMENTS');
        //IF gGenJnlBatches.FINDFIRST THEN;
        //HEI.83<<

        //Disabling Workflow
        Workflow.Reset();
        Workflow.SetRange(Enabled, true);
        if Workflow.FindFirst() then
            Workflow.ModifyAll(Enabled, false);

        //Creating General Journal Entry
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", gGenJnlBatches."Journal Template Name");

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET as its being depreceted
        //if GenJournalLine.FindSet(false, false) then
        if GenJournalLine.FindSet(false) then
            // BC Upgrade MISHRS14 <<
                GenJournalLine.DeleteAll();


        //HEI.85>>
        GenJournalTemplate.Reset();
        GenJournalTemplate.SetFilter(Name, '<>%1', gGenJnlBatches."Journal Template Name");

        // BC Upgrade MISHRS14 >>
        // Removed false from FINDSET as its being depreceted
        //if GenJournalTemplate.FindSet(false, false) then
        if GenJournalTemplate.FindSet(false) then begin
            begin
                repeat
                    GenJournalTemplateTemp.init();
                    GenJournalTemplateTemp.TransferFields(GenJournalTemplate);
                    GenJournalTemplateTemp.Insert();
                    GenJournalTemplate.Delete();
                until GenJournalTemplate.Next() = 0;
            end;

        end;
        // BC Upgrade MISHRS14 <<

        // GenJournalTemplate.DeleteAll();
        // //HEI.85<<

        PayJnlTree.OpenEdit();
        PayJnlTree.CurrentJnlBatchName.SetValue(gGenJnlBatches.Name);
        Commit();
        PayJnlTree.SuggestVendorPayments.Invoke();

        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", gGenJnlBatches."Journal Template Name");
        GenJournalLine.SetRange("Journal Batch Name", gGenJnlBatches.Name);
        //GenJournalLine.SETFILTER("Applies-to Doc. No.",'<>%1','');
        if GenJournalLine.FindFirst() then begin
            //GenJournalLine.MODIFYALL("Posting Date",TODAY);
            ApplDocNo := GenJournalLine."Applies-to Doc. No.";
            DocNo := GenJournalLine."Document No.";
        end;

        PayJnlTree.Post.Invoke();
        PayJnlTree.OK.Invoke();
        //HEI.82
        //HEI.98>>
        Commit();
        VendLedgEntry.Reset();
        VendLedgEntry.SetRange("Document Type", VendLedgEntry."Document Type"::Invoice);
        VendLedgEntry.SetRange("Document No.", PostInvNo);
        if VendLedgEntry.FindFirst() then
            VendLedgEntry.TestField(Open, false);
        //HEI.98<<
        if GenJournalTemplateTemp.FindSet() then begin
            repeat
                GenJnlTemp.Init();
                GenJnlTemp.TransferFields(GenJournalTemplateTemp);
                GenJnlTemp.Insert();
            until GenJournalTemplateTemp.next = 0;
        end
    end;



    [Test]
    procedure DimensionRestrictionCheck();
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        DefaultDimension: Record "Default Dimension";
        EbfCombination: Record "Ebf Combination FND";
    begin
        //HEI.95>>
        GeneralLedgerSetup.Get();
        DefaultDim.Reset();
        DefaultDim.SetCurrentKey("Table ID", "No.", "Dimension Code");
        DefaultDim.SetRange("Table ID", 15);
        DefaultDim.SetRange("Value Posting", DefaultDim."Value Posting"::"Code Mandatory");
        DefaultDim.ModifyAll(DefaultDim."Value Posting", DefaultDim."Value Posting"::" ");

        EbfCombination.Reset();
        EbfCombination.SetCurrentKey("GL Account No.", "Dimension Code", "Dimension Value Code");
        EbfCombination.SetFilter("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.ModifyAll(EbfCombination."Combination Restriction", EbfCombination."Combination Restriction"::" ");
        //HEI.95<<
    end;

    [ModalPageHandler]
    procedure UnapplyEntriesModalPageHandler(var UnapplyVendorEntries: TestPage "Unapply Vendor Entries");
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        //HEI.23>>
        //HEI.29>>
        //UnapplyVendorEntries.FILTER.SETFILTER("Document No.",GenJouDocNo);
        GeneralLedgerSetup.Get();
        Evaluate(GeneralLedgerSetup."Allow Posting From", UnapplyVendorEntries."Posting Date".Value);
        GeneralLedgerSetup.Modify();
        //HEI.29<<
        UnapplyVendorEntries.Unapply.Invoke();
        //HEI.23<<
    end;


    [Test]
    [HandlerFunctions('ConfirmationHandler,MessageHandler,WhseRcptPageHandler,ItemTrackingLinesModalPageHandler,GetReceiptLineModalPageHandler')]
    procedure "CHG2119682_Invoice Posting threshold Heilite"();
    var
        PurchaseInvList: TestPage "PO Purchase Invoices";
        Vendor: Record Vendor;
        PurchaseInvoice: TestPage "PO Purchase Invoice";
        "Item Charge": Record "Item Charge";
        GetReceiptLines: TestPage "Purch. Receipt Lines";
        ItemChargeAssignmentPurch: TestPage "Item Charge Assignment (Purch)";
        Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        GetReceiptLines2: TestPage "Get Receipt Lines";
        PurchInvHeader: Record "Purch. Inv. Header";
        PostedPurchaseInvoices: TestPage "Posted Purchase Invoices";
        PostInvNo: Text;
        paymentstatus: Option "Pending Review","Payment Approved","Payment Rejected";
        PurchaseHeader: Record "Purchase Header";
        "WHT Business Posting Group FND": Record "WHT Business Posting Group FND";
        VendorNo: Text;
        GeneralLedgerSetup: Record "General Ledger Setup";
        CompanyInformation: Record "Company Information";
        PurchaseLine: Record "Purchase Line";
        DimensionValue: Record "Dimension Value";
        DimensionValueMVMT: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        Item: Record Item;
        PurchaseOrderList: TestPage "Purchase Orders";
        PurchaseOrder1: TestPage "Purchase Order";
        WarehouseReceipt: TestPage "Warehouse Receipt";
        ItemTrackingLines: TestPage "Item Tracking Lines";
        WhseRcptPONo: Code[20];
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        VendorBankAccount: Record "Vendor Bank Account";
        PurchLn: Record "Purchase Line";
        PurchInvNo: Code[20];
        DocAmount: Decimal;
        VATAmount: Decimal;
        GenJnlTable: Record "Gen. Journal Line";
        GenJnlBatch: Record "Gen. Journal Batch";
        ApprovalEntries: TestPage "Approval Entries";
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        GenJournalLine: Record "Gen. Journal Line";
        GeneralJournalTemplates: TestPage "General Journal Templates";
        GeneralJournalBatches: TestPage "General Journal Batches";
        VendorLedgerEntries: TestPage "Vendor Ledger Entries";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        PayJnlTree: TestPage "Payment Journal Tree CBN";
        Bin: Record Bin;
        Location: Record Location;
        GeneralPostingSetup: Record "General Posting Setup";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        GLAccount: Record "G/L Account";
        TestGenJournalBatch: Record "Gen. Journal Batch";
        GenJournalTemplate: Record "Gen. Journal Template";
        EBFErrText: Label 'Are you sure you want to post combination of account %1 with dimension %2';
        Workflow: Record Workflow;
    begin
        //HEI.98>>
        DimensionRestrictionCheck();
        PurchasesPayablesSetup.Get();
        PurchasesPayablesSetup.TestField("Lower % Tolerance FND");
        PurchasesPayablesSetup.TestField("Lower Amount Tolerance FND");

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::Vendor);
        Vendor.Get(UnitTestingValues.Value);
        Vendor."E-Mail 2 FND" := 'unittesting@heineken.com';
        Vendor.Modify();
        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::"User Setup");
        UserSetup.Get(UnitTestingValues.Value);
        UserSetup."E-Mail" := 'unittesting@heineken.com';
        UserSetup.Modify();

        CompanyInformation.Get();
        CompanyInformation."E-Mail" := 'unittesting@heineken.com';
        CompanyInformation.Modify();

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::Item);
        Item.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::Bin);
        Bin.Get(UnitTestingValues."Value 2", UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::Location);
        Location.Get(UnitTestingValues.Value);

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PCN023', CompanyName, Database::"Lot No. Information");
        LotNoFilter := UnitTestingValues.Value;

        UnitTestingValues.Get('PCN023', CompanyName, Database::"Dimension Value");
        GeneralLedgerSetup.Get();
        if UnitTestingValues.Value <> '' then
            DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", UnitTestingValues.Value);

        Clear(EBFWarnConf);
        if GeneralPostingSetup.Get(Vendor."Gen. Bus. Posting Group", "Item Charge"."Gen. Prod. Posting Group") then
            EBFWarnConf := StrSubstNo(EBFErrText, GeneralPostingSetup."Purch. Account", Item."Global Dimension 2 Code");

        PurchaseOrder1.OpenNew();
        PurchaseOrder1."Buy-from Vendor No.".SetValue(Vendor."No.");
        PurchaseOrder1."Vendor Invoice No.".SetValue('StP Unit Test PCN0XX');
        // PurchaseOrder1."Requester ID".SETVALUE(UserSetup."User ID");//BC UPGRADE KUMARR78 DIT Field Removed.

        if PurchasesPayablesSetup.Get() then
            if PurchasesPayablesSetup."Mandatory Region on Header FND" = true then
                PurchaseOrder1."Location Code".SetValue(Location.Code);

        PurchaseOrder1.PurchLines.Type.SetValue(Type::Item);
        PurchaseOrder1.PurchLines."No.".SetValue(Item."No.");
        PurchaseOrder1.PurchLines.Quantity.SetValue(1);
        PurchaseOrder1.PurchLines."Location Code".SetValue(Location.Code);

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("Document No.", PurchaseOrder1."No.".Value);
        PurchaseLine.SetRange("No.", PurchaseOrder1.PurchLines."No.".Value);
        if PurchaseLine.FindFirst() then begin
            PurchaseLine.Validate("Bin Code", Bin.Code);
            PurchaseLine.Validate("Shortcut Dimension 2 Code", DimensionValue.Code);
            PurchaseLine.Modify();
        end;
        // BC Upgrade BHARDA11 >>
        Workflow.Reset();
        Workflow.SetRange(Template, false);
        Workflow.SetRange(Category, 'PURCHDOC');
        Workflow.ModifyAll(Enabled, true);
        // BC Upgrade BHARDA11 >>
        //Disable Workflows before Release
        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrder1."No.".Value);
        if ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then begin
            Workflow.SetRange(Enabled, true);
            if Workflow.FindFirst() then
                Workflow.ModifyAll(Enabled, false);

        end;

        if GeneralPostingSetup.Get(Vendor."Gen. Bus. Posting Group", Item."Gen. Prod. Posting Group") then
            if GLAccount.Get(GeneralPostingSetup."Purchase Variance Account") then
                if GLAccount.Blocked = true then begin
                    GLAccount.Blocked := false;
                    GLAccount.Modify();
                end;

        PurchaseOrder1.Release.Invoke();
        // PurchaseOrder1.Action149.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseOrder1."Create &Whse. Receipt".Invoke();//BC UPGRADE KUMARR78 Adding with Change Action Name
        WarehouseReceipt.OpenView();
        WarehouseReceipt.Filter.SetFilter("Source No. FND", PurchaseOrder1."No.".Value);

        //Store the PO No in warehouse receipt
        WhseRcptPONo := WarehouseReceipt."Source No.".Value;

        //Select Item Tracking Code
        WarehouseReceipt.WhseReceiptLines.ItemTrackingLines.Invoke();

        //Post The warehouse receipt
        WarehouseReceipt."Post Receipt".Invoke();
        PurchaseOrder1.OK.Invoke();


        PurchRcptHdr.SetRange("Order No.", WhseRcptPONo);
        if PurchRcptHdr.FindFirst() then
            DocNo := PurchRcptHdr."No.";

        //Purchase Invoice Posting

        UnitTestingValues.Reset();
        UnitTestingValues.Get('PTP018', CompanyName, Database::"WHT Business Posting Group FND");
        if UnitTestingValues.Value <> '' then
            "WHT Business Posting Group FND".Get(UnitTestingValues.Value);

        GeneralLedgerSetup.Get();

        PurchaseInvoice.OPENNEW;
        PurchaseInvoice."Buy-from Vendor Name".SETVALUE(Vendor.Name);
        PurchaseInvoice."Vendor Invoice No.".SETVALUE('StP Script PTP');
        VendorNo := Vendor."No.";
        PurchaseInvoice.PurchLines.GetReceiptLines.INVOKE;
        CompanyInformation.Get();
        Clear(InvNo);
        InvNo := PurchaseInvoice."No.".VALUE;

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Invoice);
        PurchaseLine.SETRANGE("Document No.", PurchaseInvoice."No.".VALUE);
        PurchaseLine.SetFilter(Type, '<>%1', PurchaseLine.Type::" ");
        if PurchaseLine.FindFirst() then begin
            if (PurchaseLine."CAD Amount FND" <> 0) and
             (CompanyInformation."Country/Region Code" <> Vendor."Country/Region Code") then
                PurchaseLine.Validate("VAT Prod. Posting Group", 'NO_VAT');
            PurchaseLine.Modify();
        end;

        //BC UPGRADE KUMARR78 >> DIT Variable Removed.
        // PurchaseInvoice."Doc. Amount Incl. VAT".SETVALUE(PurchaseInvoice.PurchLines."Total Amount Incl. VAT".VALUE);
        // PurchaseInvoice."Doc. Amount VAT".SETVALUE(PurchaseInvoice.PurchLines."Total VAT Amount".VALUE);
        //BC UPGRADE KUMARR78 << DIT Variable Removed.

        //BC UPGRADE KUMARR78 >> DIT Variable Removed.
        // IF UPPERCASE(COMPANYNAME) = UPPERCASE('BRASCO') THEN BEGIN
        //     PurchaseLine.RESET;
        //     PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Invoice);
        //     PurchaseLine.SETRANGE("Document No.", PurchaseInvoice."No.".VALUE);
        //     PurchaseLine.SETFILTER(Type, '<>%1', PurchaseLine.Type::" ");
        //     IF PurchaseLine.FINDFIRST THEN BEGIN
        //         PurchaseInvoice."Doc. Amount Incl. VAT".SETVALUE(PurchaseLine."Amount Including VAT");
        //         PurchaseInvoice."Doc. Amount VAT".SETVALUE(PurchaseLine."Amount Including VAT" - PurchaseLine.Amount);
        //     END;
        // END;
        //BC UPGRADE KUMARR78 << DIT Variable Removed.

        if PurchaseHeader.Get(PurchaseHeader."Document Type"::Invoice, InvNo) then
            PurchaseHeader.AddLink('C:\IBM\Suraj\TestScript.pdf', 'TestLinkPTP018');

        //  PurchaseInvoice.Post.INVOKE;//BC UPGRADE KUMARR78 Blocking As Action Name Changed
        PurchaseInvoice.Post_Custom.INVOKE;//BC UPGRADE KUMARR78 Adding with Change Action Name


        PurchInvHeader.SetRange("Pre-Assigned No.", InvNo);
        if PurchInvHeader.FindFirst() then begin
            PostInvNo := PurchInvHeader."No.";
            DueDate := PurchInvHeader."Due Date" + 1;
        end;

        InvNo := PostInvNo;

        PostedPurchaseInvoices.OpenView();
        PostedPurchaseInvoices.Filter.SetFilter("No.", PostInvNo);
        PostedPurchaseInvoices."Payment Status".ASSERTEQUALS(paymentstatus::"Payment Approved");

        PostedPurchaseInvoices.OK.Invoke();
        //HEI.98<<
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler,MessageHandler,GetReceiptLineModalPageHandler')]
    procedure "RT_PCN029_ProcessPO-PI_GlobalUpperToleranceLimitPercentage"();
    var
        PurchasesPayablesSetupL: Record "Purchases & Payables Setup";
        GeneralLedgerSetupL: Record "General Ledger Setup";
        UnitTestingValuesL: Record "Unit Testing Value FND";
        VendorL: Record Vendor;
        GLAccountL: Record "G/L Account";
        LocationL: Record Location;
        PurchaseOrderL: TestPage "Purchase Order";
        PurchaseInvoiceL: TestPage "PO Purchase Invoice";
        GetReceiptLinesL: TestPage "Get Receipt Lines";
        PurchInvNoL: Code[20];
        TypeL: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        PurchRcptHdrL: Record "Purch. Rcpt. Header";
        PurchRcptLineL: Record "Purch. Rcpt. Line";
        PurchRcptNoL: Code[20];
        PurchaseHeaderL: Record "Purchase Header";
        PurchaseLineL: Record "Purchase Line";
        PONoL: Code[20];
        ApprovalsMgmtL: Codeunit "Approvals Mgmt.";
        WorkflowL: Record Workflow;
        Workflow: Record Workflow;
    begin
        //HEI.112>>
        if PurchasesPayablesSetupL.Get() then begin
            GeneralLedgerSetupL.Get();
            UnitTestingValuesL.Reset();
            UnitTestingValuesL.Get('PCN029', CompanyName, Database::Vendor);
            VendorL.Get(UnitTestingValuesL.Value);

            UnitTestingValuesL.Reset();
            UnitTestingValuesL.Get('PCN029', CompanyName, Database::"G/L Account");
            GLAccountL.Get(UnitTestingValuesL.Value);

            UnitTestingValuesL.Reset();
            UnitTestingValuesL.Get('PCN029', CompanyName, Database::Location);
            LocationL.Get(UnitTestingValuesL.Value);

            //Step 1: Create a PO
            PurchaseOrderL.OpenNew();
            PurchaseOrderL."No.".AssistEdit();
            PurchaseOrderL."Buy-from Vendor No.".SetValue(VendorL."No.");
            PurchaseOrderL."Vendor Invoice No.".SetValue('StP TS PCN029');
            PurchaseOrderL."Location Code".SetValue(LocationL.Code);

            //BC UPGRADE KUMARR78>> DIT Field Removed.
            // IF PurchasesPayablesSetupL."Requester ID Mandatory" THEN
            //     PurchaseOrderL."Requester ID".SETVALUE(USERID);
            //BC UPGRADE KUMARR78 << DIT Field Removed.

            PurchaseOrderL.PurchLines.New();
            PurchaseOrderL.PurchLines.Type.SetValue(TypeL::"G/L Account");
            PurchaseOrderL.PurchLines."No.".SetValue(GLAccountL."No.");
            PurchaseOrderL.PurchLines."Location Code".SetValue(LocationL.Code);
            PurchaseOrderL.PurchLines.Quantity.SetValue(1);
            PurchaseOrderL.PurchLines."Direct Unit Cost".SetValue(100);
            // BC Upgrade BHARDA11 >>
            Workflow.Reset();
            Workflow.SetRange(Template, false);
            Workflow.SetRange(Category, 'PURCHDOC');
            Workflow.ModifyAll(Enabled, true);
            // BC Upgrade BHARDA11 >>
            //Approval Process
            PurchaseHeaderL.Get(PurchaseHeaderL."Document Type"::Order, PurchaseOrderL."No.".Value);
            if ApprovalsMgmtL.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeaderL) then begin
                WorkflowL.SetCurrentKey(Enabled, Template, Category);
                WorkflowL.SetRange(Enabled, true);
                WorkflowL.SetRange(Template, false);
                WorkflowL.SetRange(Category, 'PURCHDOC');
                WorkflowL.ModifyAll(Enabled, false);
            end;

            PurchaseOrderL.Release.Invoke();
            PurchaseOrderL.Post.Invoke();
            PONoL := PurchaseOrderL."No.".Value;

            PurchRcptHdrL.SetRange("Order No.", PONoL);
            if PurchRcptHdrL.FindLast() then begin
                PurchRcptLineL.SetRange("Document No.", PurchRcptHdrL."No.");
                if PurchRcptLineL.FindFirst() then
                    DocNo := PurchRcptHdrL."No.";
            end;

            //Step 2: Go to Search and type PO Purchase Invoices

            //Step 3: Select PO Purchase Invoices from the list
            PurchaseInvoiceL.OPENNEW;

            //Step 4 - AssitEdit to create the Document No. & Add Vendor No. and put vendor invoice No.
            PurchaseInvoiceL."No.".ASSISTEDIT;
            PurchaseInvoiceL."Buy-from Vendor Name".SETVALUE(VendorL."No.");
            PurchaseInvoiceL."Vendor Invoice No.".SETVALUE('StP TS PCN029');
            PurchaseInvoiceL."Posting Date".SETVALUE(Today);
            PurchaseInvoiceL."Purchaser Code".SETVALUE('');

            //Step 5 - Go to LINES/FUNCTIONS tab and click Get Receipt Lines;
            PurchaseInvoiceL.PurchLines.GetReceiptLines.INVOKE;
            GetReceiptLinesL.OpenView();
            PurchInvNoL := PurchaseInvoiceL."No.".VALUE;

            PurchaseLineL.Reset();
            PurchaseLineL.SetCurrentKey("Document No.", "Document Type", Type);
            PurchaseLineL.SETRANGE("Document No.", PurchaseInvoiceL."No.".VALUE);
            PurchaseLineL.SetRange("Document Type", PurchaseLineL."Document Type"::Invoice);
            PurchaseLineL.SetRange(Type, PurchaseLineL.Type::"G/L Account");
            if PurchaseLineL.FindFirst() then begin
                PurchaseLineL.Validate("Direct Unit Cost",
                (PurchaseLineL."Direct Unit Cost" + (PurchaseLineL."Direct Unit Cost" * PurchasesPayablesSetupL."Upper % Tolerance FND" * 0.01) + 1));
                PurchaseLineL.Modify(false);
            end;

            //BC UPGRADE KUMARR78 >> DIT Variable Removed.
            // PurchaseInvoiceL."Doc. Amount Incl. VAT".SETVALUE(PurchaseInvoiceL.PurchLines."Total Amount Incl. VAT".VALUE);
            // PurchaseInvoiceL."Doc. Amount VAT".SETVALUE(PurchaseInvoiceL.PurchLines."Total VAT Amount".VALUE);
            //BC UPGRADE KUMARR78 << DIT Variable Removed.

            //Approval Process
            PurchaseHeaderL.GET(PurchaseHeaderL."Document Type"::Invoice, PurchaseInvoiceL."No.".VALUE);
            WorkflowL.Reset();
            WorkflowL.SetCurrentKey(Enabled, Template, Category);
            WorkflowL.SetRange(Enabled, false);
            WorkflowL.SetRange(Template, false);
            WorkflowL.SetRange(Category, 'PURCHDOC');
            WorkflowL.ModifyAll(Enabled, true);

            PurchaseInvoiceL.SendApprovalRequest.INVOKE;//Abhay

            PurchaseLineL.Reset();
            PurchaseLineL.SetCurrentKey("Document No.", "Document Type", Type);
            PurchaseLineL.SETRANGE("Document No.", PurchaseInvoiceL."No.".VALUE);
            PurchaseLineL.SetRange("Document Type", PurchaseLineL."Document Type"::Invoice);
            PurchaseLineL.SetRange(Type, PurchaseLineL.Type::"G/L Account");
            if PurchaseLineL.FindFirst() then begin
                if not PurchaseLineL."Tolerance Exceeded FND" then
                    Error(Text000);
            end;
        end;
        //HEI.112<<
    end;

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,ConfirmationHandler,MessageHandler,GetReceiptLineModalPageHandler')]
    procedure "RT_PCN030_ProcessPO-PI_GlobalUpperToleranceLimitAmount"();
    var
        PurchasesPayablesSetupL: Record "Purchases & Payables Setup";
        GeneralLedgerSetupL: Record "General Ledger Setup";
        UnitTestingValuesL: Record "Unit Testing Value FND";
        VendorL: Record Vendor;
        GLAccountL: Record "G/L Account";
        LocationL: Record Location;
        PurchaseOrderL: TestPage "Purchase Order";
        PurchaseInvoiceL: TestPage "PO Purchase Invoice";
        GetReceiptLinesL: TestPage "Get Receipt Lines";
        PurchInvNoL: Code[20];
        TypeL: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        PurchRcptHdrL: Record "Purch. Rcpt. Header";
        PurchRcptLineL: Record "Purch. Rcpt. Line";
        PurchRcptNoL: Code[20];
        PurchaseHeaderL: Record "Purchase Header";
        PurchaseLineL: Record "Purchase Line";
        PONoL: Code[20];
        ApprovalsMgmtL: Codeunit "Approvals Mgmt.";
        WorkflowL: Record Workflow;
        Workflow: Record Workflow;
    begin
        //HEI.112>>
        if PurchasesPayablesSetupL.Get() then begin
            GeneralLedgerSetupL.Get();
            UnitTestingValuesL.Reset();
            UnitTestingValuesL.Get('PCN030', CompanyName, Database::Vendor);
            VendorL.Get(UnitTestingValuesL.Value);

            UnitTestingValuesL.Reset();
            UnitTestingValuesL.Get('PCN030', CompanyName, Database::"G/L Account");
            GLAccountL.Get(UnitTestingValuesL.Value);

            UnitTestingValuesL.Reset();
            UnitTestingValuesL.Get('PCN030', CompanyName, Database::Location);
            LocationL.Get(UnitTestingValuesL.Value);

            //Step 1: Create a PO
            PurchaseOrderL.OpenNew();
            PurchaseOrderL."No.".AssistEdit();
            PurchaseOrderL."Buy-from Vendor No.".SetValue(VendorL."No.");
            PurchaseOrderL."Vendor Invoice No.".SetValue('StP TS PCN030');
            PurchaseOrderL."Location Code".SetValue(LocationL.Code);

            //BC UPGRADE KUMARR78 >> DIT Field Removed.
            // IF PurchasesPayablesSetupL."Requester ID Mandatory" THEN
            //     PurchaseOrderL."Requester ID".SETVALUE(USERID);
            //BC UPGRADE KUMARR78 << DIT Field Removed.

            PurchaseOrderL.PurchLines.New();
            PurchaseOrderL.PurchLines.Type.SetValue(TypeL::"G/L Account");
            PurchaseOrderL.PurchLines."No.".SetValue(GLAccountL."No.");
            PurchaseOrderL.PurchLines."Location Code".SetValue(LocationL.Code);
            PurchaseOrderL.PurchLines.Quantity.SetValue(1);
            PurchaseOrderL.PurchLines."Direct Unit Cost".SetValue(100);
            // BC Upgrade BHARDA11 >>
            Workflow.Reset();
            Workflow.SetRange(Template, false);
            Workflow.SetRange(Category, 'PURCHDOC');
            Workflow.ModifyAll(Enabled, true);
            // BC Upgrade BHARDA11 >>
            //Approval Process
            PurchaseHeaderL.Get(PurchaseHeaderL."Document Type"::Order, PurchaseOrderL."No.".Value);
            if ApprovalsMgmtL.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeaderL) then begin
                WorkflowL.SetCurrentKey(Enabled, Template, Category);
                WorkflowL.SetRange(Enabled, true);
                WorkflowL.SetRange(Template, false);
                WorkflowL.SetRange(Category, 'PURCHDOC');
                WorkflowL.ModifyAll(Enabled, false);
            end;

            PurchaseOrderL.Release.Invoke();
            PurchaseOrderL.Post.Invoke();
            PONoL := PurchaseOrderL."No.".Value;

            PurchRcptHdrL.SetRange("Order No.", PONoL);
            if PurchRcptHdrL.FindLast() then begin
                PurchRcptLineL.SetRange("Document No.", PurchRcptHdrL."No.");
                if PurchRcptLineL.FindFirst() then
                    DocNo := PurchRcptHdrL."No.";
            end;

            //Step 2: Go to Search and type PO Purchase Invoices

            //Step 3: Select PO Purchase Invoices from the list
            PurchaseInvoiceL.OPENNEW;

            //Step 4 - AssitEdit to create the Document No. & Add Vendor No. and put vendor invoice No.
            PurchaseInvoiceL."No.".ASSISTEDIT;
            PurchaseInvoiceL."Buy-from Vendor Name".SETVALUE(VendorL."No.");
            PurchaseInvoiceL."Vendor Invoice No.".SETVALUE('StP TS PCN030');
            PurchaseInvoiceL."Posting Date".SETVALUE(Today);
            PurchaseInvoiceL."Purchaser Code".SETVALUE('');

            //Step 5 - Go to LINES/FUNCTIONS tab and click Get Receipt Lines;
            PurchaseInvoiceL.PurchLines.GetReceiptLines.INVOKE;
            GetReceiptLinesL.OpenView();
            PurchInvNoL := PurchaseInvoiceL."No.".VALUE;

            PurchaseLineL.Reset();
            PurchaseLineL.SetCurrentKey("Document No.", "Document Type", Type);
            PurchaseLineL.SETRANGE("Document No.", PurchaseInvoiceL."No.".VALUE);
            PurchaseLineL.SetRange("Document Type", PurchaseLineL."Document Type"::Invoice);
            PurchaseLineL.SetRange(Type, PurchaseLineL.Type::"G/L Account");
            if PurchaseLineL.FindFirst() then begin
                PurchaseLineL.Validate("Direct Unit Cost",
                (PurchaseLineL."Direct Unit Cost" + (PurchaseLineL."Direct Unit Cost" * PurchasesPayablesSetupL."Upper Amount Tolerance FND") + 1));
                PurchaseLineL.Modify(false);
            end;

            //BC UPGRADE KUMARR78 >> DIT Variable Removed.
            // PurchaseInvoiceL."Doc. Amount Incl. VAT".SETVALUE(PurchaseInvoiceL.PurchLines."Total Amount Incl. VAT".VALUE);
            // PurchaseInvoiceL."Doc. Amount VAT".SETVALUE(PurchaseInvoiceL.PurchLines."Total VAT Amount".VALUE);
            //BC UPGRADE KUMARR78 << DIT Variable Removed.

            //Approval Process
            PurchaseHeaderL.GET(PurchaseHeaderL."Document Type"::Invoice, PurchaseInvoiceL."No.".VALUE);
            WorkflowL.Reset();
            WorkflowL.SetCurrentKey(Enabled, Template, Category);
            WorkflowL.SetRange(Enabled, false);
            WorkflowL.SetRange(Template, false);
            WorkflowL.SetRange(Category, 'PURCHDOC');
            WorkflowL.ModifyAll(Enabled, true);

            PurchaseInvoiceL.SendApprovalRequest.INVOKE;//Abhay

            PurchaseLineL.Reset();
            PurchaseLineL.SetCurrentKey("Document No.", "Document Type", Type);
            PurchaseLineL.SETRANGE("Document No.", PurchaseInvoiceL."No.".VALUE);
            PurchaseLineL.SetRange("Document Type", PurchaseLineL."Document Type"::Invoice);
            PurchaseLineL.SetRange(Type, PurchaseLineL.Type::"G/L Account");
            if PurchaseLineL.FindFirst() then begin
                if not PurchaseLineL."Tolerance Exceeded FND" then
                    Error(Text000);
            end;
        end;
        //HEI.112<<
    end;
}

