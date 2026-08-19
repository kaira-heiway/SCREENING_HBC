
codeunit 50007 "Purchases-Utils"
{
    // version HEI.162

    // HEI.01 FDD-PTPGAP005 IBM SOICAD01 27.06.2017 Purchase to Pay – 3-way matching
    //  #new codeunit created
    // HEI.02 FDD–PURGAP05 IBM LAZARE02 11.07.2017 # Added function OnBeforeValidatePurchHeaderBuyFromVendorNo
    // HEI.03 FDD-PURGAP09 IBM LAZARE02 05.09.2017 # Added functions: OnBeforeReleasePurchaseDoc, OnSendPurchaseDocForApproval
    // HEI.04 FDD-HLSRM03 IBM LAZARE02 08.09.2017
    //   # Added functions: T39OnBeforeValidateDirectUnitCost, T39OnAfterValidateBlanketOrderLocationCode, T39OnBeforeValidateBlanketOrderConsLocationCode,
    //                      T39OnAfterValidatePlannedReceiptDate, T39OnAfterValidateExpectedReceiptDate, C90OnAfterPostPurchaseDoc,
    //                      C97OnBeforeMakeOrder, C97OnAfterMakeOrder, C97OnAfterInitPurchLine, C50045OnBeforeMakeOrder,
    //                      T39OnBeforeValidateBlanetOrderQuantity, T39OnAfterValidateNo,
    //                      T39OnBeforeValidatePurchaseQuantity, T39OnBeforeValidatePurchaseQtyToReceive, T7317OnBeforeValidateQtyToReceive,
    //                      T38OnAfterValidateBlanketOrderNo, T39OnAfterValidateBlanketOrderLineNo,
    //                      T39OnAfterValidateQuantity, C90OnBeforePostPurchaseDoc
    // HEI.05 FDD–PURGAP05 IBM LAZARE02 09.10.2017
    //   # Added functions: T23OnAfterModify, T38OnAfterValidateDocumentDate
    // HEI.06 HLSRM02-05,FDD-PURGAPINT002 IBM LAZARE02 04.12.2017
    //   # New subscriber T38OnAfterTransferSavedFields
    // HEI.07 FDD–PURGAP05 IBM LAZARE02 14.12.2017 # New function T23OnAfterValidateGlobalVendorNo
    // HEI.08 IBM SoicaD01
    // HEI.09 Defect #1438 IBM POSTOI01 26.01.2018
    //   #New subscriber: T25OnAfterValidatePaymentStatus
    // HEI.10 FDDPTPGAP011 INM HORTOC01 30.01.2018
    //  #new function
    // HEI.11 Defect #1320 IBM POSTOI01 25.01.2018
    //   #New subscriber :CU415OnbeforeReleasepurchDoc, new function CalculateAmountFALedgEntry, new text constant Text006
    // HEI.12 Defect #1438 IBM POSTOI01 26.01.2018
    //   #New subscriber: T25OnAfterValidateReasonCode
    // HEI.13 Defect #1518 IBM LAZARE02 14.02.2018
    //   # New subscriber P45OnAfterValidateEvent
    // HEI.14 INC0773005 IBM LAZARE02 08.05.2018
    //   # New subscriber C1535OnSendPurchaseDocForApproval
    // HEI.15 FDD-AL-PTPGAP02 IBM HORTOC01 16.05.2018 - new functions
    // HEI.16 IBM HORTOC01 06.08.2018 - bug fix
    // HEI.17 defect #2452 IBM POSTOI01 08.08.2018
    //   # create 3 subscribers : add restriction for already proposed documents to any further application
    // HEI.18 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # New Subscribers created to Insert and Delete Purchase Header Additional
    //   # New Subscribers created to Insert and Delete Purch. Rcpt. Header Additional
    //   # New Subscribers created to Insert and Delete Purch. Invoice Header Additional
    //   # New Subscribers created to Insert and Delete Purch. Cr. Memo Header Additional
    //   # New Subscribers created to Insert and Delete Purchase Header Archive Additional
    // HEI.19 FDD_HT629 IBM HORTOC01 28.06.2019# new function + code change
    // HEI.21 RFC-CHG0270634 IBM.NK 24.07.2019
    //   # New Subscribers created for CCC functionality
    // HEI.22 FDD-HB622 IBM NASTAA02 12.08.2019 # Customer ledger entries automatic application credit notes
    //   # Subscriber created to update "Applies to Doc. Type" and "Applies to Doc. No" Fields
    // HEI.23 Defect #4261 IBM NASTAA02 14.08.2019 # PO exceeding budget was not blocked
    //   # Code added to function 'CheckBudgetOK. All G/L Budgets need to be filtered when "Check When Posting Purch Doc" is ticked
    // HEI.24 Defect #4340 IBM NASTAA02 19.08.2019 # Location field mandatory on Blanket Order for Return Order
    //   # New subscriber created "C50045OnAfterInitPurchLine"
    // HEI.25 New Subscriber "C22OnBeforeInsertValueEntry" created
    // HEI.26 FDD-HT658 IBM.GUNERE01 18.09.2019 # OnBeforePostPurchDoc, OnBeforeReleasePurchDoc funcs. modified
    //                                            CheckDistanceOnPurchDocFromDocShippingCosts, CheckMandatoryFieldsForRoute funcs. added
    // HEI.27 FDD-CHG2024552 IBM.PATHAA02 19.09.2019
    //  # Added new Subscriber OnInsertPurchLine
    // HEI.29 FDD-HT594 IBM NASTAA02 07.10.2019 # La Reunion FA Requirements Vendor
    //   # New Subscriber "T39OnAfterValidateType" created to updated Field "Fixed Asset Acquisition FND" from Purchase Header
    //   # New Subscriber "T39OnAfterValidateFANo" created to updated Field "Fixed Asset Acquisition FND" from Purchase Header
    //   # New Subscriber "T39OnDeleteFALine" created to clear value of "Fixed Asset Acquisition FND" Field from Purchase Header
    //   # New Subscriber "C90OnBeforePost" created to check if all lines have Type = 'Fixed Asset'
    //   # New Subscriber "OnSendPurchaseDocumentForApproval" created to check if all lines have Type = 'Fixed Asset'
    // HEI.31 FDD-HT923 CHG2034529 IBM GUNERE01 08.11.2019 # T23OnAfterValidateGlobalVendorNo func. modified
    // HEI.32 CHG2022325 FDD-HT630 IBM.GUNERE01 20.11.2019 # T39OnBeforeValidateToleranceRecOver func. created
    // HEI.33 CHG2040699 FDD-HT971 IBM POSTOI01 15.01.2020
    //   # T81OnAfterValidateAmount new subscriber
    //   # T81OnAfterValidateAmountLCY new subscriber
    //   # T81OnAftherValidateAmountLCY new subscriber
    //   # T81OnAfterValidateWHTBusPostGroup new subscriber
    //   # T81OnBeforeInsertRec new subscriber
    //   # T81OnAfterValidateApplyToDoc new substcriber
    //   # add code to T81OnBeforeModifyRecApplyDoc subscriber
    //   # new function CalcWHTAmount
    //   # T50077OnBeforeRenameWHTPostingSetup - to disable rename for WHT combination with open entries
    //   # T50077OnBeforeRenameWHTPostingSetup - to disable delete for WHT combination with open entries
    //   # new text constant Text007
    // HEI.34 CHG2027215 FDD-HB858 IBM SHANKJ03 24.01.2020
    //   # T38OnAfterValidateVendorNo new subscriber
    //   # T122OnAfterInsertPurchInvHdr
    //   # T124OnAfterInsertPurchCrMemoHdr
    // HEI.35 CHG2030247 IBM SAXENS01 30/01/2020
    //   # T39OnInsertLine New Subscriber
    //   # T39OnTypeValidate New Subscriber
    // HEI.36 Defect #5156 CHG2071290 IBM.GUNERE01 29.01.2020 # T39OnBeforeValidateToleranceRecOver func. modified
    // HEI.37 FDD- HT821 IBM SHANKJ03 11.02.2020
    //   # T50140OnAfterValidateMaximoStatus New Subscriber
    // HEI.38 FDD- HT1141 IBM PANDES01
    //         # Added code for enable standard texts in PO which created from SRM.
    // HEI.39 CHG2054594 Defect # 5080 IBM GUNERE01 06.03.2020 # CU415OnbeforeReleasepurchDoc func. modified
    // HEI.40 CHG2042209 IBM SHANKJ03 12.03.2020
    //   # T38OnAfterPaytermValidate to check Payment Terms Code with receipt line
    // HEI.41 FDD-HB1076 CHG2046174 IBM SHANKJ03 20.03.2020
    //   # T39OnAfterPurchLineInsert
    // HEI.43 Defect id 5401 IBM SHANKJ03 01.04.2020
    //   # Added New function CheckToleranceCrMemo
    // HEI.44 CHG2048419 FDD-HB1138 IBM SHANKJ03
    //   # Added new function SendEmailWithAtachment
    //   # Added new function T38OnAfterValidateStatus
    // HEI.45 CHG2038388 HB1005 IBM.GUNERE01 16.04.2020 # OnAfterInsertPurchHeader func. modified
    // HEI.46 FDD-HB1076 CHG2069312 IBM SHANKJ03 25.06.2020
    //   # T39OnAfterPurchLineInsert Commented
    // HEI.47 CHG2008438 IBM.GUNERE01 # 12.08.2020 # CalculateAmountFALedgEntry func. modified
    // HEI.48 FDD-HT1398 CHG2065738 IBM.GUNERE01 21.07.2020 # T23OnAfterValidateGlobalVendorNo func. modified
    // HEI.49 CHG2076758 IBM.GUNERE01 25.08.2020 # T23OnAfterValidateGlobalVendorNo func. modified
    // HEI.50 CHG2081091 IBM SHANKj03  29.09.2020
    //   # Modified Function SendEmailWithAtachment
    // HEI.51 FDD HT1136 CHG2055070 IBM Shankj03
    //   # Added New Function C90OnAfterPurchDocPost
    //   # Modified Function OnAfterDeletePurchHeader
    // HEI.52 CHG2083064 IBM.GUNERE01 21.10.2020 # ReleasePurchCheck, SendEmailWithAtachment funcs. modified.
    //                                             CheckRequesterPO, FindRequesterEmailPO funcs. created.
    // HEI.53 HT1136 CHG2084917 IBM.GUNERE01 11.04.2020 # P480OnDeleteEvent,P480OnModifyEvent,
    //                                                    P480OnInsertEvent,GenLedgSetupGot funcs. added
    // HEI.54 CHG2087501 INC3165665 IBM GAVANM01 13.11.2020
    //   #new function T39OnBeforePurchLineInsert
    //   #function T38OnAfterLeadTimeValidate renamed to T39OnAfterLeadTimeValidate,  new code added
    //   #new code added in function T38OnAfterOrderDateValidate
    // HEI.55 CHG2989363 INC3195074 IBM NANDIS01 01.12.2020
    //   # Code sync in A-P as per Q env - A line of code was blocked in Q env without mentioning any change number and any version tag
    // HEI.56 CHG2081323 HB1619 IBM.GUNERE01 20.01.2021 # OnAfterInsertPurchHeader func. modified
    // HEI.57 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   #new function T7316LSROnBeforeInsert
    // HEI.58 FDD-HB1886 IBM NASTAA02 30.03.2021 # Specific Invoice Tolerances
    //   # Code added on functions "CheckTolerance" and "CheckToleranceMemo"
    // HEI.59 FDD-HB1195 CHG2070051 IBM GUNERE01 04.02.2021 # CheckShippingMethod,T38OnAfterInsertShippingMethodCode,T38OnAfterModifyShippingMethodCode,
    //                                                        T38OnAfterDeleteShippingMethodCode,T38OnAfterInsert funcs. added
    // HEI.60 CHG2098629 HB2014 IBM NANDIS01 08.04.2021 - LOG_Automatic creation of Transfer Order for Import PO
    //   # Created a new function
    // HEI.61 CHG2100218 IBM SAXENA03 25.03.2021
    //   # Added new peice of code to EXIT from Function If record is Temporary.
    // HEI.62 CHG2100199 IBM BHATTA09 30.05.2021
    //   # Code modified under "T39OnBeforeValidatePurchaseQtyToReceive" to update Quantity and Quantity to Receive in case of Blanket Order
    // HEI.63 FDD-HB2174 CHG2104952 IBM NANDIS01 31.05.2021 Ibecor - PO API
    //   # New function created - IbecorCreatePORequest,T38OnDeletePurchHeader,CompareIbecorStagedData and TriggerAPINotification
    // HEI.64 CHG2129884 IBM BULIMC01 09/06/2021# Capex budget incorrectly blocked
    //   #fixes done in functions CU415OnbeforeReleasepurchDoc and CalculateAmountFALedgEntry
    // HEI.66 CHG2116845 IBM SHIVAS05 01/07/2021
    //   # Code modified because the tolerance calculation is wrong with negative direct unit cost in CheckTolerance function.
    // HEI.67 CHG2119178 IBM.AS 30.06.2021
    //  # HeiLite Base Stability Changes for Posting functions at JOB NAS
    //  # Adding GUIAllowed function added in Functions ManageTOfromPO()
    // HEI.68 CHG2115759 IBM.AB 08.07.2021
    //   # Below Subscribers are added
    //       T38OnBeforeDeleteForPOandReturnPO
    //       T39OnBeforeDeleteForPOandReturnPO
    //       T38OnBeforeDeleteForBPO
    //       T39OnBeforeDeleteForBPO
    // HEI.69 CHG2120013 IBM NANDIS01 27.07.2021 Issue on TO item Unit on Measure different of the one of PO
    //   #Validate UOM in Transfer Order Line from the value of respective Purchase Line only - function CreteTOLn
    // HEI.70 CHG2119682 IBM SHIVAS05 03.08.2021 If the Invoice exceeds the lower tolerance limit against the PO value,
    //        for either the % or the absolute amount , Heilite should only give a pop-up warning.
    // HEI.71 FDD-HT2159 - CHG2105031 IBM NASTAA02 05.08.2021 # VAT Centime - Part 2 - Purchases
    //   # Code added on 'OnAfterInsertPurchHeaderArchive'
    // HEI.72 CHG2119725 FDD-HB2359 IBM.GUNERE01 09.08.2021 # T39OnInsertLine func. modified
    // HEI.73 INC3686699 - CHG2124206 IBM NASTAA02 30.08.2021 # Purchase Order Released without approval
    //   # New Subscriber created
    // HEI.74 CHG2121745 BHATTA09 24.08.2021
    //   # Code added in 'OnAfterInsertPurchHeader' to flow "Shopping Card Creation Date" field from Interface Entry Header table to Purchase Header Additional table
    //   # Code added in 'OnAfterInsertPurchHeaderArchive' to flow "Shopping Card Creation Date" field from Purchase Header Additional table to Purchase Header Archive Addit table
    // HEI.75 CHG2124965 IBM NANDIS01 02.09.2021 Retrieve CCC during auto-generation of TO from INCBL from corresponding Import PO
    //   # Dimension Set used in TO Line same as PO Line for Import PO process at time of creation of TO from PO under
    //     function - CreteTOLn,ManageTOfromPO and CreateTOHdr
    // HEI.77 CHG2124608 IBM NANDIS01 08.09.2021 Shipment method code on blanket PO - Sept1st-2021-4:51PM
    //   # When shipment method code gets changed to non import PO process then location code should be updated with the location of Blanket Order
    // HEI.78 Defect #6462 IBM NASTAA02 08.09.2021 # Defect on invoice - License code
    //   # New Subscriber created to update the License Code
    // HEI.79 CHG2125585 IBM SHANKJ03 09.09.2021
    //   # Revoking CHG2125255 & CHG2124206
    // HEI.80 CHG2119725 IBM BHATTA09 13.09.2021
    //   # Subscriber event added to update Fixed Asset Acquisition field in Purchase Invoice while using Get Receipt Line
    // HEI.84 FDD-HB2482 CHG2123206 IBM NANDIS01 09.11.2021 - Improvement of multiple HeiLite reports for StP  Procurement users
    //   # Added new function - UpdatePONoinPostedInvoice to be called from CU-90
    //   # Permission added Purch. Inv. Line - read and modify
    // HEI.85 CHG2134347- INC3809226 IBM SHankj03 11.11.2021
    //   # Modified code in functions
    // HEI.86 CHG2127747 IBM BHATTA09 07.12.2021
    //   # Created new subscriber to update Assigned User ID in Purch. Order after posting receipts
    // HEI.87 CHG2132608 IBM BHATTA09 08.12.2021
    //   # Code modified to remove Restriction for Blanket PO for FA while linking it from a PO
    //   # Code commented added for Tolerance Received Over % field update
    // HEI.88 CHG2123219 IBM.BHATTA09 05.01.2022
    //   # Functions added to get SKU CCC Dimension Code
    // HEI.82 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # Code modified under function - TriggerAPINotification and IbecorCreatePORequest
    // HEI.89 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # Ibecor process will trigger only for PFI, not for normal POs
    // HEI.90 FDD-HB2060 CHG2103752 IBM NANDIS01 21-02-2022 - Final delivery and PO closure HL  Global Maximo
    //   # Maximo Status in PO Header will be updated at time of PO Invoice Posting - New function created - T123OnAfterInsert
    // HEI.91 FDD-HB2060 CHG2103752 IBM NANDIS01 02-03-2022 - Final delivery and PO closure HL  Global Maximo
    //   # Create Outbound entry for MAXIMO-PO interface once status changed to PendClose for Maximo Status in PO
    // HEI.92 FDD-HB2174 CHG2129099 IBM NANDIS01 02.03.2022 Ibecor integration interface INT03 and INT04
    //   # Amount for Ibecor should be showing including Document SHipping Cost along with PO Amount
    // HEI.94 FDD-HB2060 CHG2103752 IBM NANDIS01 17-03-2022 - Final delivery and PO closure HL  Global Maximo
    //   # New function - T39OnAfterModifyDelFinal created to update - Delivery Finalized field
    // HEI.95 CHG2153119 INC4015040 IBM MAJUMS03 06.04.2022
    //   # Code Modified in T39OnBeforePurchLineInsert[EventSubscriber] to avoid Expected Delivery Date update for SRM PO in Heilite.
    // HEI.96 CHG2153119 INC4015040 IBM MAJUMS03 11.04.2022
    //   # Code Modified in T39OnBeforePurchLineInsert[EventSubscriber] to update Requested Receipt Date for SRM PO in Heilite, same as Expected Delivery Date in PO Line.
    //   Additionally also corrected the Lead Time Calculation checking introduced against HEI.54 by another developer.
    // HEI.97 CHG2161190 IBM SHIVAS05 30.06.2022
    //   # Use Purchase recept header Currency code in place of Purchase recept line currency code due to flow filed
    //     and use FINDSET(FALSE,FALSE) in place of FINDSET
    // HEI.98 CHG2160301 IBM SHIVAS05 04.07.2022
    //   # add Created by and PQ approver email ID in CC, SendEmailWithAtachment funcs. modified.
    //   # FindPQApproerEmail, FindCreaterEmail funcs. created.
    // HEI.99 CHG2160301 IBM SHIVAS05 12.07.2022
    //   # PurchaseHeader."PQ Approver" is flowfield so Using PurchaseHeaderAdditional."PQ Approver" in place of PurchaseHeader."PQ Approver
    //     In FindPQApproerEmail function
    // HEI.100 CHG2160301 IBM SHIVAS05 29.07.2022
    //   # Adding one more validation when adding CC to 'Created by' and 'PQ approver', SendEmailWithAtachment funcs. modified.
    // HEI.107 CHG2155847 HB2821 IBM NANDIS01 14.10.2022 - Issue related with deployment of HB2060
    //   # Move only those PO which are having Maximo PR Req no
    // HEI.108 CHG2170293 HB3102 IBM MAJUMS03 18.10.2022 - Payment Method Code to be populated from Master Data during Credit Memo Processing
    //   # Code Added under T38OnAfterValidateVendorNo() - function to populate "Payment Method Code" automatically.
    // HEI.101 CHG2155847 HB2821 IBM NANDIS01 11.08.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Control on deletion of whse recpt
    // HEI.102 CHG2155847 HB2821 IBM NANDIS01 08.09.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Blocked the code against HEI.101
    //   # control over deleting PO and PO lines
    // HEI.103 CHG2155847 HB2821 IBM NANDIS01 12.09.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Control with user setup on deleting Astro POs also control on exp rcpt date; new function T39OnAfterModifyExpctdRcptDt,
    // HEI.104 CHG2155847 HB2821 IBM NANDIS01 26.09.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Control on Expected Receipt Date for Astro WMS orders
    // HEI.105 CHG2155847 HB2821 IBM NANDIS01 28.09.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Fix on Expected Receipt Date for Astro WMS orders
    // HEI.106 CHG2161266 HB3003 NORRIQ KOROLA04 06.10.2022
    //   # T38OnBeforeDeleteForPOandReturnPO() - function changed
    // HEI.107 CHG2155847 HB2821 IBM NANDIS01 14.10.2022 - Issue related with deployment of HB2060
    //   # Move only those PO which are having Maximo PR Req no
    // HEI.108 CHG2170293 HB3102 IBM MAJUMS03 18.10.2022 - Payment Method Code to be populated from Master Data during Credit Memo Processing
    //   # Code Added under T38OnAfterValidateVendorNo() - function to populate "Payment Method Code" automatically.
    // HEI.109 CHG2161266 HB3003 NORRIQ KOROLA04 20.10.2022
    //   # T38OnBeforeDeleteForPOandReturnPO() - function changed
    // HEI.110 CHG2162715 HB3020 NORRIQ KOROLA04 07.11.2022
    //   # T39OnAfterInsertLine() - function modified
    //   $ T39OnAfterModifyPurchaseLine() - function created
    // HEI.113 CHG2162715 HB3020 NORRIQ KOROLA04 19.12.2022 - Adding Production location in Purchase orders
    //   # T39OnAfterInsertLine() - modified
    //   # T39OnAfterModifyPurchaseLine() - modified
    // HEI.116 CHG2167376 HB3082 NORRIQ KOROLA 27.11.2022
    //   # T39OnBeforeModifyPurchaseLine() - modified
    // HEI.117 CHG2162715 HB3020 NORRIQ KOROLA 28.11.2022
    //   # CheckVendorSPL() - function created
    //   # OnSendPurchaseDocumentForApproval() - function changed
    // HEI.118 CHG2162715 HB3020 NORRIQ KOROLA 30.11.2022
    //   # OnSendPurchaseDocumentForApproval(), C97OnBeforeMakeOrder() - function changed
    //   # OnBeforeReleasePurchaseDoc() - function changed
    // HEI.119 CHG2162715 HB3020 NORRIQ KOROLA 01.12.2022
    //   # OnSendPurchaseDocumentForApproval() - function changed
    // HEI.120 CHG2162715 HB3020 NORRIQ KOROLA 07.12.2022
    //   # OnBeforeReleasePurchaseDoc(), T39OnBeforeModifyPurchaseLine() - changed
    // HEI.121 CHG2162715 HB3020 NORRIQ KOROLA04 19.12.2022 - Adding Production location in Purchase orders
    //   #just documentation part for HEI.113 fixed
    // HEI.125 CHG2177512 IBM NANDIS01 07.02.2023 - HB3207 Maintaining the reversal on Item change POs
    //   # PO Deletion will depend on new field created - "Deletion From Doc Shipping" to bypass the event
    // HEI.115 CHG2155847 HB2821 IBM NANDIS01 24.11.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Control on purchase line modification for Astro and function name changed to T39OnAfterModifyAstroLine from T39OnAfterModifyExpctdRcptDt
    // HEI.124 CHG2155847 HB2821 IBM NANDIS01 06.02.2023 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Control on purchase return line modification for Astro and function name changed to T39OnAfterModifyAstroLine from T39OnAfterModifyExpctdRcptDt
    // HEI.126 CHG2155847 HB2821 IBM NANDIS01 24.02.2023 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Control on warehouse receipt lines modification; new function created - T7317OnAfterModifyAstroLineh
    //   # New event created on codeunit 5760
    // HEI.123 CHG2188365 HB3301 IBM NANDIS01 03.02.2023 # Limit PO in PO Archive
    //   # Code modified to show the records in Page correctly
    // HEI.127 CHG2132418 FDD-HB2311 IBM NANDIS01 10.03.2023 # Development Correct posting invoicing FA
    //   # Posting Desc should be flown as per standard release functionality
    // HEI.111 CHG2167376 HB3082 NORRIQ KOROLA 11.11.2022
    //   # IbecorCreatePORequest() - function modified
    //   # CU415_OnAfterReleasePurchDoc(), T50140OnAfterModify() - event subscriber created
    // HEI.112 CHG2167376 HB3082 NORRIQ KOROLA 16.11.2022
    //   # TriggerAPINotification() - modified
    // HEI.113 CHG2167376 HB3082 NORRIQ KOROLA 21.11.2022
    //   # T39OnAfterInsertLine() - modified
    //   # T39OnAfterModifyPurchaseLine() - modified
    // HEI.114 CHG2167376 HB3082 NORRIQ KOROLA 22.11.2022
    //   # T50140OnAfterModify() - modified
    // HEI.122 CHG2167376 HB3082 IBM NANDIS01 01.02.2023 # Ibecor-HL Integration, adding Import license and inspection codes in POs
    //   # fields flown - "License Required" and "Credit Info Required" to table Ibecor Staged Data
    // HEI.128 CHG2195261 IBM NANDIS01 16.03.2023 # Ibecor Retrofit DCR
    //   # Changed the code as primary key of the table "Interface Location Matrix" has changed
    // HEI.129 CHG2167376 HB3082 IBM NANDIS01 05.04.2023 # Ibecor-HL Integration, adding Import license and inspection codes in POs
    //   # Fucntion - T50140OnAfterModify modified from OnBeforeModifyEvent to OnAfterModifyEvent
    // HEI.130 CHG2202968 CC IBM NANDIS01 02.05.2023 #BASE POs received several times
    //   # comparison of opco code blocked as its creating "REQINFO" triggered automatically while setup in location matrix changed
    // HEI.131 CHG2202968 CC IBM NANDIS01 05.05.2023 #BASE POs received several times
    //   # comparison of credit infos will be done if boolean is enabled
    // HEI.132 CHG2202968 CC IBM NANDIS01 09.05.2023 #BASE POs received several times
    //   # Stopped triggering Credit Info details for the first time
    // HEI.136 CHG2214459 IBM SRIVAS07 01.08.2023 - to amend the logic to get the license Number from the dimension license code
    //   # Added Code in IbecorCreatePORequest() - License Number is Dimension Value Name now
    //   # CompareIbecorStagedData - For "Postind Date" and "Delivery Date", Comparision should not work.
    // HEI.137 CHG2215561 IBM SRIVAS07 21.08.2023 - Message not transferred to Ibecor
    //   # Added Code in T50140OnAfterModify()
    //   # Created New Function IbecorComparePORequest()
    // HEI.138 CHG2218129 CC-INC4787163 IBM MAJUMS03 04.09.2023 # Auto billing not passing Location from Order
    //   # Code added under function T38OnAfterInsertShippingMethodCode to fix the bug for Non Import Inter Company PO. Location Code of the purchase line in the
    //   Non Import Inter Company PO is updated as blank, and as per the standard check Location Code cannot be updated manually as the PO is Special Order  as
    //   created from SO.
    // HEI.139 CHG2190299 HB3316 IBM SRIVAS07 12.09.2023 - Development -POSM eShop for BASE OpCos
    //   # Code added for GR Cancellation under OnAfterUndoReceipt Function
    //   # Change the Text Constant POSMWarningMessage in OnBeforeUndoReceipt Function
    // HEI.140 CHG2218301 HB3550 IBM SRIVAS07 18.10.2023 - Reduce the manual Purchase Order deletion Development
    //   # Added new function TODeletionRestriction()
    // HEI.141 CHG2218301 HB3550 IBM SRIVAS07 02.11.2023 - Reduce the manual Purchase Order deletion Development
    //   # Added new function TODeletionRestriction()
    // HEI.144 CHG2228266 IBM SRIVAS07 14.11.2023 - INT03 triggering as total PO value will not match with PFI value
    //   # Added Code to CompareIbecorStagedData()
    // HEI.146 CHG2217938 HB3565 SRIVAS07 IBM 28.11.23 - Provide an overview of future commitment payments based on open released Purchase Orders
    //   # Added function T38OnAfterValidateExpectedReceiptDate
    //   # Added function T38OnAfterValidatePaymentTermCode
    //   # Added function T38OnAfterValidateDueDate
    // HEI.147 CHG2217938 HB3565 SRIVAS07 IBM 29.11.23 - Provide an overview of future commitment payments based on open released Purchase Orders
    //   # Added code in function T38OnAfterValidateExpectedReceiptDate
    //   # Added code in function T38OnAfterValidatePaymentTermCode
    //   # Added code in function T38OnAfterValidateDueDate
    // HEI.148 CHG2200245 HB3430 SRIVAS07 IBM 02.01.2024 # To block users not to release PQ with no value - Development
    //   # Created new function for PQ value checking PQtoPOConditionCheck Trigger()
    // HEI.149 CHG2237828 SRIVAS07 IBM 01.02.2024 - Expected Receipt date field ‘31-12-9999’, so Expected Payment Due date cannot add days to calculate the same
    //   # Added one more Control.
    // HEI.133 CHG2190299 FDD-HB3316 IBM NANDIS01 24.05.2023 # POSM eshop SRM- HL interface
    //   # Modified function - C90OnBeforePostPurchaseDoc to control SRM PO posting for tem types
    // HEI.134 CHG2190299 FDD-HB3316 IBM NANDIS01 26.07.2023 # POSM eshop SRM- HL interface
    //   # Control added before undo receipt of POSM order
    // HEI.135 CHG2190299 FDD-HB3316 IBM NANDIS01 31.07.2023 # POSM eshop SRM- HL interface
    //   # Warning message added before undo receipt of POSM order
    // 
    // HEI.142 CHG2190299 HB3316 IBM SRIVAS07 13.11.2023 - Finetuning- POSM eShop for BASE OpCos
    //   # Added few code in function C90OnBeforePostPurchaseDoc()
    // HEI.143 CHG2190299 HB3316 IBM SRIVAS07 14.11.2023 - Finetuning- POSM eShop for BASE OpCos
    //   # Added few code in function C90OnBeforePostPurchaseDoc()
    // HEI.144 CHG2228266 IBM SRIVAS07 14.11.2023 - INT03 triggering as total PO value will not match with PFI value
    //   # Added Code to CompareIbecorStagedData()
    // HEI.145 CHG2190299 HB3316 IBM SRIVAS07 22.11.2023 - Finetuning- POSM eShop for BASE OpCos
    //   # Added few code in function C90OnBeforePostPurchaseDoc()
    // HEI.150 CHG2241947 SRIVAS07 IBM 04.03.2024 # Ibecor Integration - Error Log
    //   # Added code in CompareIbecorStagedData()
    //   # Added Code in IbecorComparePORequest()
    // HEI.151 CHG2241947 SRIVAS07 IBM 19.03.2024 # Ibecor Integration - Error Log
    //   # Added code in CompareIbecorStagedData().
    //   # Added Code in T50140OnAfterModify().
    // HEI.153 CHG2241947 SRIVAS07 IBM 04.04.2024 # Ibecor Integration - Error Log
    //   # Added code in CompareIbecorStagedData().
    // HEI.152 CHG2238024 HB3817 IBM SRIVAS07 27.03.2024 # Development Receipt process for materials from South Africa to Mozambique.
    //   # Added few code CheckShippingMethod()
    //   # Added new function T38OnAfterModifyCountryCode()
    // HEI.156 CHG2229933 HB3689 IBM SRIVAS07 03.05.2024 # SRM Reference Document Mapping - Development
    //   # Added code in C90OnAfterPostPurchaseDoc() - Vendor shipment no should remove after posting.
    // HEI.155 CHG2244737 HB3873 IBM SRIVAS07 30.04.2024 # Development- Ibecor integration - check whether amount on PO is equal to amount on PFI before releasing PO
    //   # Created new function -PFIAmountCheck()
    //   # Added code to OnBeforeReleasePurchaseDoc()
    // HEI.157 CHG2244737 HB3873 IBM SRIVAS07 21.05.2024 # Development- Ibecor integration - check whether amount on PO is equal to amount on PFI before releasing PO
    //   # Added code in the function -PFIAmountCheck()
    // HEI.154 CHG2221624 HB3614 IBM SRIVAS07 04.04.2024 # Block Payment for Invoices with Price Difference higher than the tolerance
    //   # Code Added to CheckTolerance()
    //   # Code Added to C90OnBeforePostPurchaseDoc()
    //   # Created new function CheckToleranceForEsker()
    //   # Created new function CheckToleranceWarning()
    //   # Created new function SupressToleranceWaring()
    // HEI.155 CHG2244737 HB3873 IBM SRIVAS07 30.04.2024 # Development- Ibecor integration - check whether amount on PO is equal to amount on PFI before releasing PO
    //   # Created new function -PFIAmountCheck()
    //   # Added code to OnBeforeReleasePurchaseDoc()
    // HEI.156 CHG2229933 HB3689 IBM SRIVAS07 03.05.2024 # SRM Reference Document Mapping - Development
    //   # Added code in C90OnAfterPostPurchaseDoc() - Vendor shipment no should remove after posting.
    // HEI.157 CHG2244737 HB3873 IBM SRIVAS07 21.05.2024 # Development- Ibecor integration - check whether amount on PO is equal to amount on PFI before releasing PO
    //   # Added code in the function -PFIAmountCheck()
    // HEI.158 CHG2210794 SAHAL01 06.06.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added Code
    // HEI.159 CHG2210794 VERMAA03 14.06.2024 Zycus -BASE integration with POSM GR Cancellation
    //   # Added code in the function -OnAfterUndoReceipt()
    //   # Created new function -OnAfterUndoReceipt_Zycus()
    // HEI.160 CHG2210794 SAHAL01 08.11.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added Code
    // HEI.161 CHG2210794 VERMAA03 27.06.2024 Zycus -BASE integration with POSM GR Cancellation
    //   # Created new function -OnBeforeUndoReceipt_Zycus() - Partial GR Cancellation is not allowed in Zycus.
    //   # Code changes in the function -OnAfterUndoReceipt() - Since Partial GR Cancellation is not allowed in Zycus, all eligible lines of Receipt document is filtered.
    // HEI.162 CHG2261624 IBM SRIVAS07 12.08.2024 # S&OP Fit import purchase requisitions-Development
    //   # Code added to T38OnAfterInsertShippingMethodCode()
    //   # Code added to T38OnAfterModifyShippingMethodCode()
    // HEI.163 CHG2210794 SAHAL01 03.09.2024 Zycus - BASE HL Integration with Transaction POSM GR
    //   # Added Code
    // HEI.164 CHG2317685 SAHAL01 17.10.2025 Block Functionality Enhancement for Vendors
    //   # Created New Function - CheckBlockedVendorOnDocuments
    //   # Added Code

    // BC Upgrade SHUKLP03 >> procedure IbecorComparePORequest(), event OnBeforePostPurchaseDoc, OnBeforePurchRcptLineModify,OnAfterValidateEvent,OnAfterValidateEvent,OnAfterInsertEvent and OnBeforePostPurchaseDoc added in codeunit "InterfacePurchCode" of interface extension.

    // BC Upgrade PATELP08 >>
    // Tag HEI.164 added to documentation and changes - created new function 'CheckBlockedVendorOnDocuments'
    // Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
    // BC Upgrade PATELP08 <<

    //BC Upgrade ATHUKS01<<
    //1.Un comment the function 'ReleasePurchCheck' and its call from OnRun function.
    //2. Old code commented due to NAV SMTP tables are not supported in BC. 
    //Modified code in the function SendEmailWithAttachment() & related to BC Temp Blob. 
    //BC Upgrade ATHUKS01>>

    // BC Upgrade MISHRS14 >>
    // Changed table name to "PFI Approval FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    Permissions = TableData "Purch. Rcpt. Header" = rm,
                  TableData "Purch. Inv. Header" = rm,
                  TableData "Purch. Inv. Line" = rm,
                  TableData "Dimension Set Entry" = rimd;

    trigger OnRun();
    begin
        //HEi.44>>
        ReleasePurchCheck() //BC Upgrade ATHUKS01
        //HEi.44
    end;

    var
        CompanyInformation: Record "Company Information";
        GeneralLedgerSetup: Record "General Ledger Setup";
        grec_InventorySetup: Record "Inventory Setup";
        NoSeries: Record "No. Series";
        PurchLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        grec_TransHdr: Record "Transfer Header";
        grec_TransHdrChk: Record "Transfer Header";
        grec_TransHdrChkDel: Record "Transfer Header";
        grec_TransLn: Record "Transfer Line";
        grec_TransShpmntHdr: Record "Transfer Shipment Header";
        gRecUserSetUp: Record "User Setup";
        Vendor: Record Vendor;
        //NoSeriesMgt: Codeunit NoSeriesManagement;  // BC Upgrade NANDIS03
        NoSeriesCU: Codeunit "No. Series";  // BC Upgrade NANDIS03
        CU_ReleaseTransDoc: Codeunit "Release Transfer Document";
        GenLedgSetupGot: Boolean;
        //   AstroInterfaceSetup: Record "Astro Interface Setup";//BC UPgrade SHARMP16-- Interface Code
        HideToleranceWarning: Boolean;
        MakeTO: Boolean;
        PurchSetupRetrieved: Boolean;
        //ZycusInterfaceSetup: Record "Zycus Interface Setup INT";//BC UPgrade SHARMP16-- Interface Code
        ZycusInterfaceSetupRead: Boolean;
        NewToHdrNo: Code[10];
        //  grec_GeneralInterfaceSetup : Record "General Interface Setup";//BC UPgrade SHARMP16-- Interface Code
        // grec_InterfaceSetup : Record "Interface Setup";//BC UPgrade SHARMP16-- Interface Code        InterfaceFrameworkMgt : Codeunit "Interface Framework Mgt.";
        // InterfaceSetup : Record "Interface Setup";//BC UPgrade SHARMP16-- Interface Code
        // InterfaceEntryHeaderOut : Record "Interface Entry Header";//BC UPgrade SHARMP16-- Interface Code
        //OutboundInterface : Record "Outbound Interface INT";//BC UPgrade SHARMP16-- Interface Code
        CCCfromSKU: Code[20];
        DimValID: Integer;
        BlanketOrderQtyUpdateQst: Label '"You are over consuming the contract quantity. Update the blanket order quantity from %1 to %2? "';
        CannotAssignToBlanketErr: Label 'You are not allowed to make this operation from this page.';
        CannotCreateCallOffErr: Label 'You are not allowed to create %1 %2 call-off from this page.';
        ChannelPriceChangeErr: Label 'You are not allowed to modify %1 for channel %2.';
        DateMustNotBeBeforeDateErr: Label '%1 must not be before %2.';
        FATypeError: Label 'Line No. %1 doesn''t have Type Fixed Asset.';
        GlobalVendorNoExistsErr: Label 'Global vendor no. %1 already exists as local no. %2.';
        InsertPOLineSRM: Label 'You are not allowed to enter Purchase Line manually for the PO created from Blanket Order through SRM.';
        InvoiceIsProposed: Label 'The %1 document is already present on proposal in journal %2';
        POStatusErr: Label 'Status must be Released or Pending Prepayment';
        PrintOrderError: Label 'This Order should be printed only from SRM';
        ReceiveNotAllowedErr: Label 'Receive is not allowed for orders that are imported from SRM.';
        SalesReturnOrderPostErr: Label 'The Field Link Sales Document No. contains a value. Sales Invoice must be posted with this Sales Order No. before Sales Credit Memo is posted from the Sales Return Order.';
        SRMOrderSendToApprovalErr: Label 'You are not allowed to send SRM order to approval.';
        Text001: Label 'Upper limit percent exceded on line %1 with amount of %2';
        Text0001: Label '"License code can only be added from the document header! "';
        Text002: Label 'Upper limit amount exceded on line %1 with amount of %2';
        Text0002: Label '"License code can only be modified from the document header! "';
        Text003: Label 'Lower limit percent exceded on line %1 with amount of %2';
        Text0003: Label '"License code can only be deleted from the document header! "';
        Text004: Label 'Lower limit amount exceded on line %1 with amount of %2';
        Text0004: Label 'Shipment method code is relevant for Import process. By changing to this code system will adjust the Location code in the lines. Do you want to update Location code in the lines?';
        Text005: Label 'You must not specify Direct Unit Cost when Purchase Order No. is empty';
        Text0005: Label 'You need to re-open the document before modifying Shipment Method Code.';
        Text006: Label 'Budget %3 amount %1 is exceeded by the total realesed documents amount %2 for Depreciation Book Code %4';
        Text0006: Label 'Location Code %1 cannot be used for Import PO.';
        Text007: Label 'There are open entries with the current WHT groups : WHT Bus. posting Group %1, WHT Product Posting Group %2. Operation "Cancelled FND"!';
        Text0007: Label 'You need to re-open the document before modifying Location Code.';
        Text008: Label '" Are you sure you want to continue?"';
        Text0008: Label 'Location Code %1 cannot be used for non-Import PO.';
        Text021: Label 'Zycus';
        Text022: Label 'Receive is not allowed for PO %1 that is interfaced from %2.';
        Text50000: Label '"Item %1 cannot be used in %2. Item''s Inventory Value Zero value must be true, Item Tracking Code must be FA Related and Service Item Group must have Create Fixed Asset value true! "';
        UnauthorizedDeletionOfBPO: Label 'You are not allowed to delete the Blanket Purchase Order %1';
        UnauthorizedDeletionOfBPOLines: Label 'You are not allowed to delete any Lines in the Blanket Purchase Order %1';
        UnauthorizedDeletionOfPO: Label 'You are not allowed to delete the Purchase Order %1';
        UnauthorizedDeletionOfPOLines: Label 'You are not allowed to delete any Lines in the Purchase Order %1';
        UnauthorizedUser: Label 'User Setup does not exist for your User ID %1';
        VendBankAccErr: Label 'You are not allow to change the Vendor Bank Account field.';
        VendorIsBlockedErr: Label 'Vendor no. %1 is blocked for %2.';
        AmtOverConsNotAllowedErr: TextConst ENU = 'Amount over consumption is not allowed for %1 = %2.';
        AmtOverConsOverToleranceErr: TextConst ENU = 'Amount is over accepted tolerance %1 %2 for %3 = %4.';
        AmtUnderConsUnderToleranceErr: TextConst ENU = 'Amount is under accepted tolerance %1 %2 for %3 = %4.';
        InvalidEmailAddressErr: TextConst ENU = 'The email address "%1" is not valid.', FRA = 'L''adresse e-mail « %1 » n''est pas valide.';
        QtyOverConsNotAllowedErr: TextConst ENU = 'Quantity over consumption is not allowed for %1 = %2.';
        QtyOverConsOverToleranceErr: TextConst ENU = 'Quantity is over accepted tolerance %1 %2 for %3 = %4.';
        QtyUnderConsUnderToleranceErr: TextConst ENU = 'Quantity is under accepted tolerance %1 %2 for %3 = %4.';

    procedure OnBeforePostPurchLine(var PurchLine: Record "Purchase Line");
    begin
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases.
        // with PurchLine do begin
        //     if "Document Type" = "Document Type"::Invoice then
        //         CheckTolerance(PurchLine)
        //     // HEI.43 >>
        //     else if ("Document Type" = "Document Type"::"Credit Memo") then
        //         CheckToleranceMemo(PurchLine);
        //     // HEI.43 <<
        // end;
        if PurchLine."Document Type" = PurchLine."Document Type"::Invoice then
            CheckTolerance(PurchLine)
        // HEI.43 >>
        else if (PurchLine."Document Type" = PurchLine."Document Type"::"Credit Memo") then
            CheckToleranceMemo(PurchLine);
        // HEI.43 <<
        // BC Upgrade PATELP08 <<
    end;

    procedure GetPurchSetup(); // BC Upgrade SHUKLP03 << Made this procedure global, so that can call in Interface codeunit InterfacePurchCode.
    begin
        if not PurchSetupRetrieved then
            PurchSetup.GET();
        PurchSetupRetrieved := true;
    end;

    local procedure CheckTolerance(var PurchLine: Record "Purchase Line");
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
        ToleranceExceptions: Record "Tolerance Exceptions FND";
        ToleranceExceptionFound: Boolean;
        LowerAmt: Decimal;
        LowerPercAmt: Decimal;
        UpperAmt: Decimal;
        UpperPercAmt: Decimal;
    begin
        GetPurchSetup();
        if not PurchSetup."Invoice Toler.CheckEnabled FND" then
            exit;
        //HEI.154>>
        if PurchSetup."Check Tolerance Approval FND" then
            exit;
        //HEI.154<<
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases.
        // with PurchLine do begin
        //     if "Receipt No." <> '' then begin
        //         PurchRcptLine.GET("Receipt No.", "Receipt Line No.");
        //         //HEI.58>>
        //         ToleranceExceptionFound := false;
        //         ToleranceExceptions.SETRANGE("Vendor No.", PurchLine."Buy-from Vendor No.");
        //         ToleranceExceptions.SETRANGE(Type, PurchLine.Type);
        //         if ToleranceExceptions.FINDFIRST() then
        //             ToleranceExceptionFound := true
        //         else begin
        //             ToleranceExceptions.SETRANGE("Vendor No.", '');
        //             if ToleranceExceptions.FINDFIRST() then
        //                 ToleranceExceptionFound := true;
        //         end;

        //         if not ToleranceExceptionFound then
        //             //HEI.58<<
        //             UpperPercAmt := PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * (100 + PurchSetup."Upper % Tolerance") / 100
        //         //HEI.58>>
        //         else
        //             UpperPercAmt := PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * (100 + ToleranceExceptions."Upper % Tolerance") / 100;
        //         //HEI.58<<
        //         //HEI.66
        //         //IF PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" > UpperPercAmt THEN
        //         if ABS(PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") > ABS(UpperPercAmt) then
        //             //HEI.66
        //             ERROR(Text001, PurchLine."Line No.", PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" - UpperPercAmt);

        //         if not ToleranceExceptionFound then begin//HEI.58
        //             if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" > PurchRcptLine."Direct Unit Cost" *
        //                PurchLine."Qty. to Invoice" + PurchSetup."Upper Amount Tolerance" then
        //                 ERROR(Text002, PurchLine."Line No.", PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice"
        //                - (PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" + PurchSetup."Upper Amount Tolerance"))
        //             //HEI.58>>
        //         end else
        //             if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" > PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" +
        //                ToleranceExceptions."Upper Amount Tolerance"
        //             then
        //                 ERROR(Text002, PurchLine."Line No.", PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" -
        //                      (PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" + ToleranceExceptions."Upper Amount Tolerance"));

        //         if not ToleranceExceptionFound then
        //             //HEI.58<<
        //             LowerPercAmt := PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * PurchSetup."Lower % Tolerance" / 100
        //         //HEI.58>>
        //         else
        //             LowerPercAmt := PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * ToleranceExceptions."Lower % Tolerance" / 100;
        //         //HEI.58<<
        //         //HEI.66
        //         //IF PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" <  PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice"  - LowerPercAmt THEN
        //         if ABS(PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") < ABS(PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" - LowerPercAmt) then
        //             //HEI.66
        //             //HEI.70 <<
        //             //        ERROR(Text003,PurchLine."Line No.",PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice"  - LowerPercAmt -
        //             //        PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice");
        //             if GUIALLOWED then begin
        //                 if not CONFIRM(Text003 + Text008, true, PurchLine."Line No.", PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" - LowerPercAmt -
        //                 PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") then
        //                     ERROR('');
        //             end;
        //         //Hei.70 >>
        //         if not ToleranceExceptionFound then begin //HEI.58
        //             if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" < PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice"
        //                 - PurchSetup."Lower Amount Tolerance" then
        //                 //Hei.70 <<
        //                 //            ERROR(Text004,PurchLine."Line No.",PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice"   - PurchSetup."Lower Amount Tolerance"
        //                 //            - PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice")
        //                 if GUIALLOWED then begin
        //                     if not CONFIRM(Text004 + Text008, true, PurchLine."Line No.", PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" - PurchSetup."Lower Amount Tolerance"
        //                     - PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") then
        //                         ERROR('');
        //                 end;
        //             //HEI.70 >>
        //             //HEI.58>>
        //         end else
        //             if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" < PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" -
        //                ToleranceExceptions."Lower Amount Tolerance"
        //             then
        //                 //HEI.70 <<
        //                 //        ERROR(Text004,PurchLine."Line No.",PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice"   - ToleranceExceptions."Lower Amount Tolerance" -
        //                 //          PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice");
        //                 if GUIALLOWED then begin
        //                     if not CONFIRM(Text004 + Text008, true, PurchLine."Line No.", PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" - ToleranceExceptions."Lower Amount Tolerance" -
        //                       PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") then
        //                         ERROR('');
        //                 end;
        //         //HEI.70 >>
        //         //HEI.58<<
        //     end;
        // end;
        if PurchLine."Receipt No." <> '' then begin
            PurchRcptLine.GET(PurchLine."Receipt No.", PurchLine."Receipt Line No.");
            //HEI.58>>
            ToleranceExceptionFound := false;
            ToleranceExceptions.SETRANGE("Vendor No.", PurchLine."Buy-from Vendor No.");
            ToleranceExceptions.SETRANGE(Type, PurchLine.Type);
            if ToleranceExceptions.FINDFIRST() then
                ToleranceExceptionFound := true
            else begin
                ToleranceExceptions.SETRANGE("Vendor No.", '');
                if ToleranceExceptions.FINDFIRST() then
                    ToleranceExceptionFound := true;
            end;

            if not ToleranceExceptionFound then
                //HEI.58<<
                UpperPercAmt := PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * (100 + PurchSetup."Upper % Tolerance FND") / 100
            //HEI.58>>
            else
                UpperPercAmt := PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * (100 + ToleranceExceptions."Upper % Tolerance") / 100;
            //HEI.58<<
            //HEI.66
            //IF PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" > UpperPercAmt THEN
            if ABS(PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") > ABS(UpperPercAmt) then
                //HEI.66
                ERROR(Text001, PurchLine."Line No.", PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" - UpperPercAmt);

            if not ToleranceExceptionFound then begin//HEI.58
                if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" > PurchRcptLine."Direct Unit Cost" *
                    PurchLine."Qty. to Invoice" + PurchSetup."Upper Amount Tolerance FND" then
                    ERROR(Text002, PurchLine."Line No.", PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice"
                    - (PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" + PurchSetup."Upper Amount Tolerance FND"))
                //HEI.58>>
            end else
                if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" > PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" +
                    ToleranceExceptions."Upper Amount Tolerance"
                then
                    ERROR(Text002, PurchLine."Line No.", PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" -
                            (PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" + ToleranceExceptions."Upper Amount Tolerance"));

            if not ToleranceExceptionFound then
                //HEI.58<<
                LowerPercAmt := PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * PurchSetup."Lower % Tolerance FND" / 100
            //HEI.58>>
            else
                LowerPercAmt := PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * ToleranceExceptions."Lower % Tolerance" / 100;
            //HEI.58<<
            //HEI.66
            //IF PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" <  PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice"  - LowerPercAmt THEN
            if ABS(PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") < ABS(PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" - LowerPercAmt) then
                //HEI.66
                //HEI.70 <<
                //        ERROR(Text003,PurchLine."Line No.",PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice"  - LowerPercAmt -
                //        PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice");
                if GUIALLOWED then begin
                    if not CONFIRM(Text003 + Text008, true, PurchLine."Line No.", PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" - LowerPercAmt -
                    PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") then
                        ERROR('');
                end;
            //Hei.70 >>
            if not ToleranceExceptionFound then begin //HEI.58
                if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" < PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice"
                    - PurchSetup."Lower Amount Tolerance FND" then
                    //Hei.70 <<
                    //            ERROR(Text004,PurchLine."Line No.",PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice"   - PurchSetup."Lower Amount Tolerance"
                    //            - PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice")
                    if GUIALLOWED then begin
                        if not CONFIRM(Text004 + Text008, true, PurchLine."Line No.", PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" - PurchSetup."Lower Amount Tolerance FND"
                        - PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") then
                            ERROR('');
                    end;
                //HEI.70 >>
                //HEI.58>>
            end else
                if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" < PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" -
                    ToleranceExceptions."Lower Amount Tolerance"
                then
                    //HEI.70 <<
                    //        ERROR(Text004,PurchLine."Line No.",PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice"   - ToleranceExceptions."Lower Amount Tolerance" -
                    //          PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice");
                    if GUIALLOWED then begin
                        if not CONFIRM(Text004 + Text008, true, PurchLine."Line No.", PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" - ToleranceExceptions."Lower Amount Tolerance" -
                            PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") then
                            ERROR('');
                    end;
            //HEI.70 >>
            //HEI.58<<
        end;
        // BC Upgrade PATELP08 <<
    end;

    local procedure CheckToleranceOLD(var PurchLine: Record "Purchase Line");
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
        LowerAmt: Decimal;
        LowerPercAmt: Decimal;
        UpperAmt: Decimal;
        UpperPercAmt: Decimal;
    begin
        GetPurchSetup();
        if not PurchSetup."Invoice Toler.CheckEnabled FND" then
            exit;
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases.
        // with PurchLine do begin
        //     if "Receipt No." <> '' then begin
        //         PurchRcptLine.GET("Receipt No.", "Receipt Line No.");
        //         UpperPercAmt := PurchRcptLine."Direct Unit Cost" * (100 + PurchSetup."Upper % Tolerance") / 100;
        //         if PurchLine."Direct Unit Cost" > UpperPercAmt then
        //             ERROR(Text001, PurchLine."Line No.", PurchLine."Direct Unit Cost" - UpperPercAmt);
        //         if PurchLine."Direct Unit Cost" > PurchRcptLine."Direct Unit Cost" + PurchSetup."Upper Amount Tolerance" then
        //             ERROR(Text002, PurchLine."Line No.", PurchLine."Direct Unit Cost" - (PurchRcptLine."Direct Unit Cost" + PurchSetup."Upper Amount Tolerance"));
        //         LowerPercAmt := PurchRcptLine."Direct Unit Cost" * PurchSetup."Lower % Tolerance" / 100;
        //         if PurchLine."Direct Unit Cost" < PurchRcptLine."Direct Unit Cost" - LowerPercAmt then
        //             ERROR(Text003, PurchLine."Line No.", PurchRcptLine."Direct Unit Cost" - LowerPercAmt - PurchLine."Direct Unit Cost");
        //         if PurchLine."Direct Unit Cost" < PurchRcptLine."Direct Unit Cost" - PurchSetup."Lower Amount Tolerance" then
        //             ERROR(Text004, PurchLine."Line No.", PurchRcptLine."Direct Unit Cost" - PurchSetup."Lower Amount Tolerance" - PurchLine."Direct Unit Cost");

        //     end;
        // end;
        if PurchLine."Receipt No." <> '' then begin
            PurchRcptLine.GET(PurchLine."Receipt No.", PurchLine."Receipt Line No.");
            UpperPercAmt := PurchRcptLine."Direct Unit Cost" * (100 + PurchSetup."Upper % Tolerance FND") / 100;
            if PurchLine."Direct Unit Cost" > UpperPercAmt then
                ERROR(Text001, PurchLine."Line No.", PurchLine."Direct Unit Cost" - UpperPercAmt);
            if PurchLine."Direct Unit Cost" > PurchRcptLine."Direct Unit Cost" + PurchSetup."Upper Amount Tolerance FND" then
                ERROR(Text002, PurchLine."Line No.", PurchLine."Direct Unit Cost" - (PurchRcptLine."Direct Unit Cost" + PurchSetup."Upper Amount Tolerance FND"));
            LowerPercAmt := PurchRcptLine."Direct Unit Cost" * PurchSetup."Lower % Tolerance FND" / 100;
            if PurchLine."Direct Unit Cost" < PurchRcptLine."Direct Unit Cost" - LowerPercAmt then
                ERROR(Text003, PurchLine."Line No.", PurchRcptLine."Direct Unit Cost" - LowerPercAmt - PurchLine."Direct Unit Cost");
            if PurchLine."Direct Unit Cost" < PurchRcptLine."Direct Unit Cost" - PurchSetup."Lower Amount Tolerance FND" then
                ERROR(Text004, PurchLine."Line No.", PurchRcptLine."Direct Unit Cost" - PurchSetup."Lower Amount Tolerance FND" - PurchLine."Direct Unit Cost");
        end;
        // BC Upgrade PATELP08 <<
    end;

    procedure UpdateBankAcc(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line");
    var
        Vendor: Record Vendor;
    begin
        //HEI.16>>
        if (Rec."Account Type" = Rec."Account Type"::Vendor) and (Rec."Document Type" = Rec."Document Type"::Invoice) then begin
            if Vendor.GET(Rec."Account No.") then
                Rec.VALIDATE("Vendor Bank Account FND", Vendor."Preferred Bank Account Code")
            else
                Rec."Vendor Bank Account FND" := '';
            exit;
        end;
        //HEI.16<<
        //Rec."Vendor Bank Account" := '';//HEI.16
    end;

    procedure CopyFromPurchHeader(var Rec: Record "Gen. Journal Line"; var PurchaseHeader: Record "Purchase Header");
    begin
        Rec."Vendor Bank Account FND" := PurchaseHeader."Vendor Bank Account FND";
    end;

    procedure OnAfterValidatePurchaseHeaderPaytoVendorNo(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    begin
        /*IF Rec."Pay-to Vendor No." <> xRec."Pay-to Vendor No." THEN
         Rec.VALIDATE("Vendor Bank Account",'');
        */
        //Commented by Ashfaq on 29.08.17
        //Since the above line creating problem while creating a new Purchase order for fdd-ptpgap007(PATHAA02) has
        //The above line is triggering code in OnValidate of "Vendor bank Account", in result we are getting error on creating a new PO.

    end;

    procedure OnCheckBlockedVendOnDocs(var Vendor: Record Vendor);
    begin
        //HEI.02>>
        if Vendor.Blocked = Vendor.Blocked::Order then
            ERROR(VendorIsBlockedErr, Vendor."No.", Vendor.Blocked);
        //HEI.02<<
    end;
    //BC Upgrade SHARMP16 Begin>>---- Interface Code PFIAmountCheck function used.
    // [EventSubscriber(ObjectType::Codeunit, 415, 'OnBeforeReleasePurchaseDoc', '', false, false)]
    // local procedure OnBeforeReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean);
    // var
    //     PurchaseLine: Record "Purchase Line";
    //     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    // begin
    //     //HEI.117 >>
    //     //HEI.120 >>
    //     PurchSetup.GET;
    //     if PurchSetup."SPL Active FND" then
    //         if PurchaseHeader.Status = PurchaseHeader.Status::Open then//HEI.119
    //             if PurchaseHeader."Document Type" in [PurchaseHeader."Document Type"::Quote, PurchaseHeader."Document Type"::Order] then begin //HEI.118
    //                 if not ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then
    //                     CheckVendorSPL(PurchaseHeader);
    //             end;
    //     //HEI.120 <<
    //     //HEI.117 <<

    //     //HEI.127>>
    //     if (PurchaseHeader."Posting Description" = '') then
    //         PurchaseHeader."Posting Description" := FORMAT(PurchaseHeader."Document Type") + ' ' + PurchaseHeader."No.";
    //     //HEI.127<<

    //     //HEI.03>>
    //     if not (PurchaseHeader."Document Type" in [PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::Order]) then
    //         exit;

    //     PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
    //     PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
    //     PurchaseLine.SETFILTER(Type, '<>%1', PurchaseLine.Type::" ");
    //     if PurchaseLine.findset then
    //         repeat
    //             PurchaseLine.TESTFIELD("Planned Receipt Date");
    //             PurchaseLine.TESTFIELD("Expected Receipt Date");
    //         until PurchaseLine.NEXT = 0;
    //     //HEI.03<<

    //     //>> HEI.26 FDD-HT658 IBM.GUNERE01 18.09.2019
    //     // if PurchaseHeader.Route <> '' then//BC Upgrade SHARMP16 -- Drink_IT field
    //     CheckMandatoryFieldsForRoute(PurchaseHeader);
    //     //<< HEI.26 FDD-HT658 IBM.GUNERE01 18.09.2019

    //     PFIAmountCheck(PurchaseHeader);//HEI.155
    // end;
    //BC Upgrade SHARMP16 end<<---- Interface Code PFIAmountCheck function used.
    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSendPurchaseDocForApproval', '', false, false)]
    local procedure OnSendPurchaseDocForApproval(var PurchaseHeader: Record "Purchase Header");
    var
        PurchaseLine: Record "Purchase Line";
    begin
        //HEI.03>>
        if not (PurchaseHeader."Document Type" in [PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::Order]) then
            exit;

        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETFILTER(Type, '<>%1', PurchaseLine.Type::" ");
        if PurchaseLine.findset() then
            repeat
                PurchaseLine.TESTFIELD("Planned Receipt Date");
                PurchaseLine.TESTFIELD("Expected Receipt Date");
            until PurchaseLine.NEXT() = 0;
        //HEI.03<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Planned Receipt Date', false, false)]
    local procedure T39OnAfterValidatePlannedReceiptDate(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        //HEI.04>>
        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;

        PurchaseHeader.GET(Rec."Document Type", Rec."Document No.");
        if (CurrFieldNo = Rec.FIELDNO("Planned Receipt Date")) and (Rec."Planned Receipt Date" < PurchaseHeader."Document Date") then
            ERROR(DateMustNotBeBeforeDateErr, Rec.FIELDCAPTION("Planned Receipt Date"), PurchaseHeader."Document Date");
        //HEI.04<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Expected Receipt Date', false, false)]
    local procedure T39OnAfterValidateExpectedReceiptDate(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        //HEI.04>>
        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;

        PurchaseHeader.GET(Rec."Document Type", Rec."Document No.");
        if (CurrFieldNo = Rec.FIELDNO("Expected Receipt Date")) and (Rec."Expected Receipt Date" < PurchaseHeader."Document Date") then
            ERROR(DateMustNotBeBeforeDateErr, Rec.FIELDCAPTION("Expected Receipt Date"), PurchaseHeader."Document Date");
        //HEI.04<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnBeforeValidateEvent', 'Direct Unit Cost', false, false)]
    local procedure T39OnBeforeValidateDirectUnitCost(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        Channel: Record "Channel FND";
        PurchaseHeader: Record "Purchase Header";
    begin
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases.
        //HEI.04>>
        // with Rec do begin
        //     if "Direct Unit Cost" = xRec."Direct Unit Cost" then
        //         exit;

        //     if "Document Type" <> "Document Type"::Order then
        //         exit;

        //     if CurrFieldNo <> FIELDNO("Direct Unit Cost") then
        //         exit;

        //     PurchaseHeader.GET("Document Type", "Document No.");
        //     if Channel.GET(PurchaseHeader.Channel) then
        //         if not Channel."Allow Purch. Price Change" then
        //             ERROR(ChannelPriceChangeErr, FIELDCAPTION("Direct Unit Cost"), Channel.Code);

        // end;
        //HEI.04<<
        if Rec."Direct Unit Cost" = xRec."Direct Unit Cost" then
            exit;

        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;

        if CurrFieldNo <> Rec.FIELDNO("Direct Unit Cost") then
            exit;

        PurchaseHeader.GET(Rec."Document Type", Rec."Document No.");
        if Channel.GET(PurchaseHeader."Channel FND") then
            if not Channel."Allow Purch. Price Change" then
                ERROR(ChannelPriceChangeErr, Rec.FIELDCAPTION("Direct Unit Cost"), Channel.Code);
        // BC Upgrade PATELP08 <<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Location Code', false, false)]
    local procedure T39OnAfterValidateBlanketOrderLocationCode(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    begin
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases.
        // //HEI.04>>
        // with Rec do begin
        //     if "Document Type" <> "Document Type"::"Blanket Order" then
        //         exit;

        //     VALIDATE("Consumption Location Code FND", "Location Code");
        // end;
        // //HEI.04<<
        if Rec."Document Type" <> Rec."Document Type"::"Blanket Order" then
            exit;

        Rec.VALIDATE("Consumption Location Code FND", Rec."Location Code");
        // BC Upgrade PATELP08 <<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnBeforeValidateEvent', 'Consumption Location Code FND', false, false)]
    local procedure T39OnBeforeValidateBlanketOrderConsLocationCode(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    begin
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases.
        // //HEI.04>>
        // with Rec do begin
        //     if "Document Type" <> "Document Type"::"Blanket Order" then
        //         exit;

        //     if "Location Code" <> '' then
        //         TESTFIELD("Consumption Location Code FND", "Location Code");
        // end;
        // //HEI.04<<
        if Rec."Document Type" <> Rec."Document Type"::"Blanket Order" then
            exit;

        if Rec."Location Code" <> '' then
            Rec.TESTFIELD("Consumption Location Code FND", Rec."Location Code");
        // BC Upgrade PATELP08 <<
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterPostPurchaseDoc', '', false, false)]
    local procedure C90OnAfterPostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]);
    var
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        PurchInvLine: Record "Purch. Inv. Line";
        BlanketOrderLine: Record "Purchase Line";
        Lrec_PurchaseLine: Record "Purchase Line";
    begin
        //HEI.04>>
        if PurchInvHdrNo <> '' then begin
            PurchInvLine.SETRANGE("Document No.", PurchInvHdrNo);
            PurchInvLine.SETFILTER(Type, '<>%1', PurchInvLine.Type::" ");
            if PurchInvLine.findset() then
                repeat
                    if BlanketOrderLine.GET(BlanketOrderLine."Document Type"::"Blanket Order",
                                            PurchInvLine."Blanket Order No.", PurchInvLine."Blanket Order Line No.")
                    then begin
                        BlanketOrderLine."Invoiced Amount FND" := BlanketOrderLine."Invoiced Amount FND" + PurchInvLine.Amount;
                        BlanketOrderLine.MODIFY();
                    end;
                until PurchInvLine.NEXT() = 0;
        end;
        if PurchCrMemoHdrNo <> '' then begin
            PurchCrMemoLine.SETRANGE("Document No.", PurchCrMemoHdrNo);
            PurchCrMemoLine.SETFILTER(Type, '<>%1', PurchInvLine.Type::" ");
            if PurchCrMemoLine.findset() then
                repeat
                    if BlanketOrderLine.GET(BlanketOrderLine."Document Type"::"Blanket Order",
                                            PurchCrMemoLine."Blanket Order No.", PurchCrMemoLine."Blanket Order Line No.")
                    then begin
                        BlanketOrderLine."Invoiced Amount FND" := BlanketOrderLine."Invoiced Amount FND" - PurchCrMemoLine.Amount;
                        BlanketOrderLine.MODIFY();
                    end;
                until PurchCrMemoLine.NEXT() = 0;
        end;
        //HEI.04<<
        //HEI.156>>
        if PurchRcpHdrNo <> '' then begin
            if PurchaseHeader."SRM Order No. FND" = '' then
                exit;

            Lrec_PurchaseLine.RESET();
            Lrec_PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            Lrec_PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            if Lrec_PurchaseLine.findset(true) then
                Lrec_PurchaseLine.MODIFYALL("Vendor Shipment No. FND", '');

            PurchaseHeader."Vendor Shipment No." := '';
            PurchaseHeader.MODIFY();
        end;
        //HEI.156<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Purch. Order to Order", 'OnBeforePurchOrderHeaderModify', '', false, false)]
    local procedure C97OnBeforeMakeOrder(BlanketOrderPurchHeader: Record "Purchase Header"; var PurchOrderHeader: Record "Purchase Header");
    var
        Channel: Record "Channel FND";
        PurchaseLine: Record "Purchase Line";
    begin
        //HEI.04>>
        Channel.GET(BlanketOrderPurchHeader."Channel FND");
        if Channel."Contract Type" = Channel."Contract Type"::"Value Line" then begin
            PurchaseLine.SETRANGE("Document Type", BlanketOrderPurchHeader."Document Type");
            PurchaseLine.SETRANGE("Document No.", BlanketOrderPurchHeader."No.");
            PurchaseLine.SETRANGE(Type, PurchaseLine.Type::"G/L Account");
            PurchaseLine.SETFILTER("Qty. to Receive", '<>%1', 0);
            if PurchaseLine.FINDFIRST() then
                ERROR(CannotCreateCallOffErr, Channel."Contract Type", PurchaseLine.Type);
        end;
        //HEI.04<<
        CheckVendorSPL(BlanketOrderPurchHeader); //HEI.118
    end;

    //BC Upgrade SHARMP16 begin>>---------------- Interface code 
    // [EventSubscriber(ObjectType::Codeunit, codeunit::"Blanket Purch. Order to Order", 'OnAfterMakeOrder', '', false, false)]
    // local procedure C97OnAfterMakeOrder(var PurchOrderHeader: Record "Purchase Header");
    // var
    //     Channel: Record Channel;
    //     SRMContractType: Record "SRM Contract Type FND";
    //     PurchOrderLine: Record "Purchase Line";
    //     PurchaseLine: Record "Purchase Line";
    //     BlanketOrderLine: Record "Purchase Line";
    //     ConsumedAmount: Decimal;
    // begin
    //     //HEI.04>>
    //     if (PurchOrderHeader."Document Type" <> PurchOrderHeader."Document Type"::Order) or
    //        (PurchOrderHeader."SRM Contract No. FND" = '')
    //     then
    //         exit;

    //     if Channel.GET(PurchOrderHeader.Channel) then
    //         if Channel."Contract Type" <> Channel."Contract Type"::"Value Line" then
    //             exit;

    //     GetPurchSetup;
    //     SRMContractType.GET(PurchOrderHeader."SRM Contract Type FND");
    //     PurchOrderLine.SETRANGE("Document Type", PurchOrderHeader."Document Type");
    //     PurchOrderLine.SETRANGE("Document No.", PurchOrderHeader."No.");
    //     PurchOrderLine.SETFILTER("SRM Contract Line No. FND", '<>%1', '');
    //     if PurchOrderLine.findset then
    //         repeat
    //             BlanketOrderLine.GET(BlanketOrderLine."Document Type"::"Blanket Order", PurchOrderLine."Blanket Order No.", PurchOrderLine."Blanket Order Line No.");
    //             ConsumedAmount := BlanketOrderLine."Invoiced Amount FND";

    //             PurchaseLine.SETFILTER("Document Type", '%1|%2', PurchaseLine."Document Type"::Order, PurchaseLine."Document Type"::"Return Order");
    //             PurchaseLine.SETRANGE("SRM Contract No. FND", PurchOrderLine."SRM Contract No. FND");
    //             PurchaseLine.SETRANGE("SRM Contract Line No. FND", PurchOrderLine."SRM Contract Line No. FND");
    //             if PurchaseLine.findset then
    //                 repeat
    //                     if PurchaseLine."Document Type" = PurchaseLine."Document Type"::Order then
    //                         ConsumedAmount := ConsumedAmount + PurchaseLine."Outstanding Amount"
    //                     else
    //                         if PurchaseLine."Document Type" = PurchaseLine."Document Type"::"Return Order" then
    //                             ConsumedAmount := ConsumedAmount - PurchaseLine."Outstanding Amount"
    //                 until PurchaseLine.NEXT = 0;

    //             if ConsumedAmount > PurchOrderLine."Target Value Amount" then
    //                 if SRMContractType."Allow Over Consumption on Amt." = SRMContractType."Allow Over Consumption on Amt."::Never then
    //                     ERROR(STRSUBSTNO(AmtOverConsNotAllowedErr, PurchOrderLine.FIELDCAPTION("SRM Contract Line No. FND"), PurchOrderLine."SRM Contract Line No. FND"))
    //                 else
    //                     if (SRMContractType."Allow Over Consumption on Amt." = SRMContractType."Allow Over Consumption on Amt."::"Setup Dependant") and
    //                         (not PurchSetup."Allow Over Consumption on Amt.")
    //                     then
    //                         ERROR(STRSUBSTNO(AmtOverConsNotAllowedErr, PurchOrderLine.FIELDCAPTION("SRM Contract Line No. FND"), PurchOrderLine."SRM Contract Line No. FND"));
    //         until PurchOrderLine.NEXT = 0;
    //     //HEI.04<<
    // end;
    //BC Upgrade SHARMP16 end<<---------------- Interface code 

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Blanket Purch. Order to Order", 'OnAfterPurchOrderLineInsert', '', false, false)]
    local procedure C97OnAfterInitPurchLine(var BlanketOrderPurchLine: Record "Purchase Line"; var PurchaseLine: Record "Purchase Line");
    begin
        //HEI.04>>
        if BlanketOrderPurchLine."Document Type" <> BlanketOrderPurchLine."Document Type"::"Blanket Order" then
            exit;

        if BlanketOrderPurchLine."SRM Contract No. FND" = '' then
            exit;

        BlanketOrderPurchLine.TESTFIELD("Consumption Location Code FND");
        BlanketOrderPurchLine."Location Code" := BlanketOrderPurchLine."Consumption Location Code FND";
        PurchaseLine."Initial Quantity FND" := BlanketOrderPurchLine."Qty. to Receive";
        //HEI.04<<
    end;

    //BC Upgrade SHARMP16 Begin>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Purch. Order to Return", 'OnBeforeMakeOrder', '', false, false)]
    local procedure C50045OnBeforeMakeOrder(var PurchBlanketOrder: Record "Purchase Header");
    var
        Channel: Record "Channel FND";
    begin
        //HEI.04>>
        Channel.GET(PurchBlanketOrder."Channel FND");
        if Channel."Contract Type" = Channel."Contract Type"::"Value Line" then
            ERROR(CannotCreateCallOffErr, Channel."Contract Type");
        //HEI.04<<
    end;
    //BC Upgrade SHARMP16 End<<
    [EventSubscriber(ObjectType::Table, 39, 'OnBeforeValidateEvent', 'Location Code', false, false)]
    local procedure T39OnBeforeValidateOrderLocationCode(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    begin
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases.
        // //HEI.04>>
        // with Rec do begin
        //     if "Document Type" <> "Document Type"::Order then
        //         exit;

        //     if "SRM Contract No. FND" = '' then
        //         exit;

        //     TESTFIELD("Location Code", xRec."Location Code");
        // end;
        // //HEI.04<<
        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;

        if Rec."SRM Contract No. FND" = '' then
            exit;

        Rec.TESTFIELD("Location Code", xRec."Location Code");
        // BC Upgrade PATELP08 <<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnBeforeValidateEvent', 'Quantity', false, false)]
    local procedure T39OnBeforeValidatePurchaseQuantity(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        BlanketOrderLine: Record "Purchase Line";
        PurchaseLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        SRMContractType: Record "SRM Contract Type FND";
        QtyOnOrders: Decimal;
    begin
        //HEI.04>>
        if not GUIALLOWED then
            exit;
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases.
        // with Rec do begin
        //     if (not ("Document Type" in ["Document Type"::"Blanket Order", "Document Type"::Order])) or
        //        ("SRM Contract No. FND" = '') or
        //        (CurrFieldNo <> FIELDNO(Quantity))
        //     then
        //         exit;

        //     PurchSetup.GET();
        //     CALCFIELDS("SRM Contract Type FND");
        //     SRMContractType.GET("SRM Contract Type FND");
        //     if "Document Type" = "Document Type"::"Blanket Order" then begin
        //         if Quantity > "Initial Quantity FND" then
        //             if SRMContractType."Allow Over Consumption on Qty." = SRMContractType."Allow Over Consumption on Qty."::Never then
        //                 ERROR(STRSUBSTNO(QtyOverConsNotAllowedErr, FIELDCAPTION("SRM Contract Line No. FND"), "SRM Contract Line No. FND"))
        //             else
        //                 if (SRMContractType."Allow Over Consumption on Qty." = SRMContractType."Allow Over Consumption on Qty."::"Setup Dependant") and
        //                     (not PurchSetup."Allow Over Consumption on Qty.")
        //                 then
        //                     ERROR(STRSUBSTNO(QtyOverConsNotAllowedErr, FIELDCAPTION("SRM Contract Line No. FND"), "SRM Contract Line No. FND"));
        //     end else begin
        //         if not BlanketOrderLine.GET(BlanketOrderLine."Document Type"::"Blanket Order", "Blanket Order No.", "Blanket Order Line No.") then
        //             exit;
        //         PurchaseLine.SETFILTER("Document Type", '%1|%2', PurchaseLine."Document Type"::Order, PurchaseLine."Document Type"::"Return Order");
        //         PurchaseLine.SETRANGE("SRM Contract No. FND", "SRM Contract No. FND");
        //         PurchaseLine.SETRANGE("SRM Contract Line No. FND", "SRM Contract Line No. FND");
        //         PurchaseLine.SETRANGE("Blanket Order Line No.", "Blanket Order Line No.");
        //         if PurchaseLine.findset() then
        //             repeat
        //                 if PurchaseLine."Document Type" = PurchaseLine."Document Type"::Order then
        //                     QtyOnOrders := QtyOnOrders + PurchaseLine."Outstanding Quantity"
        //                 else
        //                     if PurchaseLine."Document Type" = PurchaseLine."Document Type"::"Return Order" then
        //                         QtyOnOrders := QtyOnOrders - PurchaseLine."Outstanding Quantity"
        //             until PurchaseLine.NEXT() = 0;
        //         if (BlanketOrderLine."Quantity Received" + QtyOnOrders - xRec.Quantity + Quantity) > BlanketOrderLine."Initial Quantity FND" then begin
        //             if SRMContractType."Allow Over Consumption on Qty." = SRMContractType."Allow Over Consumption on Qty."::Never then
        //                 ERROR(STRSUBSTNO(QtyOverConsNotAllowedErr, FIELDCAPTION("SRM Contract Line No. FND"), "SRM Contract Line No. FND"))
        //             else
        //                 if (SRMContractType."Allow Over Consumption on Qty." = SRMContractType."Allow Over Consumption on Qty."::"Setup Dependant") and
        //                     (not PurchSetup."Allow Over Consumption on Qty.")
        //                 then
        //                     ERROR(STRSUBSTNO(QtyOverConsNotAllowedErr, FIELDCAPTION("SRM Contract Line No. FND"), "SRM Contract Line No. FND"));
        //             BlanketOrderLine.VALIDATE(Quantity, BlanketOrderLine."Quantity Received" + QtyOnOrders - xRec.Quantity + Quantity);
        //             BlanketOrderLine.MODIFY();
        //         end else begin
        //             BlanketOrderLine.VALIDATE(Quantity, BlanketOrderLine."Initial Quantity FND");
        //             BlanketOrderLine.MODIFY();
        //         end;
        //     end;
        // end;
        //HEI.04<<
        if (not (Rec."Document Type" in [Rec."Document Type"::"Blanket Order", Rec."Document Type"::Order])) or
            (Rec."SRM Contract No. FND" = '') or
            (CurrFieldNo <> Rec.FIELDNO(Quantity))
        then
            exit;

        PurchSetup.GET();
        Rec.CALCFIELDS("SRM Contract Type FND");
        SRMContractType.GET(Rec."SRM Contract Type FND");
        if Rec."Document Type" = Rec."Document Type"::"Blanket Order" then begin
            if Rec.Quantity > Rec."Initial Quantity FND" then
                if SRMContractType."Allow Over Consumption on Qty." = SRMContractType."Allow Over Consumption on Qty."::Never then
                    ERROR(STRSUBSTNO(QtyOverConsNotAllowedErr, Rec.FIELDCAPTION("SRM Contract Line No. FND"), Rec."SRM Contract Line No. FND"))
                else
                    if (SRMContractType."Allow Over Consumption on Qty." = SRMContractType."Allow Over Consumption on Qty."::"Setup Dependant") and
                        (not PurchSetup."Allow OverConsumption Qty. FND")
                    then
                        ERROR(STRSUBSTNO(QtyOverConsNotAllowedErr, Rec.FIELDCAPTION("SRM Contract Line No. FND"), Rec."SRM Contract Line No. FND"));
        end else begin
            if not BlanketOrderLine.GET(BlanketOrderLine."Document Type"::"Blanket Order", Rec."Blanket Order No.", Rec."Blanket Order Line No.") then
                exit;
            PurchaseLine.SETFILTER("Document Type", '%1|%2', PurchaseLine."Document Type"::Order, PurchaseLine."Document Type"::"Return Order");
            PurchaseLine.SETRANGE("SRM Contract No. FND", Rec."SRM Contract No. FND");
            PurchaseLine.SETRANGE("SRM Contract Line No. FND", Rec."SRM Contract Line No. FND");
            PurchaseLine.SETRANGE("Blanket Order Line No.", Rec."Blanket Order Line No.");
            if PurchaseLine.findset() then
                repeat
                    if PurchaseLine."Document Type" = PurchaseLine."Document Type"::Order then
                        QtyOnOrders := QtyOnOrders + PurchaseLine."Outstanding Quantity"
                    else
                        if PurchaseLine."Document Type" = PurchaseLine."Document Type"::"Return Order" then
                            QtyOnOrders := QtyOnOrders - PurchaseLine."Outstanding Quantity"
                until PurchaseLine.NEXT() = 0;
            if (BlanketOrderLine."Quantity Received" + QtyOnOrders - xRec.Quantity + Rec.Quantity) > BlanketOrderLine."Initial Quantity FND" then begin
                if SRMContractType."Allow Over Consumption on Qty." = SRMContractType."Allow Over Consumption on Qty."::Never then
                    ERROR(STRSUBSTNO(QtyOverConsNotAllowedErr, Rec.FIELDCAPTION("SRM Contract Line No. FND"), Rec."SRM Contract Line No. FND"))
                else
                    if (SRMContractType."Allow Over Consumption on Qty." = SRMContractType."Allow Over Consumption on Qty."::"Setup Dependant") and
                        (not PurchSetup."Allow OverConsumption Qty. FND")
                    then
                        ERROR(STRSUBSTNO(QtyOverConsNotAllowedErr, Rec.FIELDCAPTION("SRM Contract Line No. FND"), Rec."SRM Contract Line No. FND"));
                BlanketOrderLine.VALIDATE(Quantity, BlanketOrderLine."Quantity Received" + QtyOnOrders - xRec.Quantity + Rec.Quantity);
                BlanketOrderLine.MODIFY();
            end else begin
                BlanketOrderLine.VALIDATE(Quantity, BlanketOrderLine."Initial Quantity FND");
                BlanketOrderLine.MODIFY();
            end;
        end;
        // BC Upgrade PATELP08 <<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnBeforeValidateEvent', 'Qty. to Receive', false, false)]
    local procedure T39OnBeforeValidatePurchaseQtyToReceive(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        PurchaseLine: Record "Purchase Line";
        SRMContractType: Record "SRM Contract Type FND";
        QtyOnOrders: Decimal;
        QtyOnPurchOrders: Decimal;
        QtyToReceive: Decimal;
    begin
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases.
        //HEI.04>>
        // with Rec do begin
        //     if ("SRM Contract No. FND" = '') or
        //        (CurrFieldNo <> FIELDNO("Qty. to Receive"))
        //     then
        //         exit;

        //     PurchSetup.GET();
        //     CALCFIELDS("SRM Contract Type FND");
        //     SRMContractType.GET("SRM Contract Type FND");
        //     if "Document Type" = "Document Type"::"Blanket Order" then begin
        //         PurchaseLine.SETFILTER("Document Type", '%1|%2', PurchaseLine."Document Type"::Order, PurchaseLine."Document Type"::"Return Order");
        //         PurchaseLine.SETRANGE("SRM Contract No. FND", "SRM Contract No. FND");
        //         PurchaseLine.SETRANGE("SRM Contract Line No. FND", "SRM Contract Line No. FND");
        //         PurchaseLine.SETRANGE("Blanket Order Line No.", "Line No.");
        //         if PurchaseLine.findset() then
        //             repeat
        //                 if PurchaseLine."Document Type" = PurchaseLine."Document Type"::Order then begin
        //                     QtyOnOrders := QtyOnOrders + PurchaseLine."Outstanding Quantity";
        //                     QtyOnPurchOrders := QtyOnPurchOrders + PurchaseLine."Outstanding Quantity";
        //                 end else
        //                     if PurchaseLine."Document Type" = PurchaseLine."Document Type"::"Return Order" then
        //                         QtyOnOrders := QtyOnOrders - PurchaseLine."Outstanding Quantity"
        //             until PurchaseLine.NEXT() = 0;
        //         if ("Quantity Received" + QtyOnOrders + "Qty. to Receive") > "Initial Quantity FND" then begin
        //             if SRMContractType."Allow Over Consumption on Qty." = SRMContractType."Allow Over Consumption on Qty."::Never then
        //                 ERROR(STRSUBSTNO(QtyOverConsNotAllowedErr, FIELDCAPTION("SRM Contract Line No. FND"), "SRM Contract Line No. FND"))
        //             else
        //                 if (SRMContractType."Allow Over Consumption on Qty." = SRMContractType."Allow Over Consumption on Qty."::"Setup Dependant") and
        //                     (not PurchSetup."Allow Over Consumption on Qty.")
        //                 then
        //                     ERROR(STRSUBSTNO(QtyOverConsNotAllowedErr, FIELDCAPTION("SRM Contract Line No. FND"), "SRM Contract Line No. FND"));
        //         end;
        //         if "Qty. to Receive" <> 0 then begin //HEI.62
        //                                              //IF "Quantity Received" + QtyOnPurchOrders + "Qty. to Receive" > Quantity THEN BEGIN //HEI.62
        //             QtyToReceive := "Qty. to Receive";
        //             if "Initial Quantity FND" < ("Quantity Received" + "Qty. to Receive" + QtyOnPurchOrders) then
        //                 VALIDATE(Quantity, "Quantity Received" + "Qty. to Receive" + QtyOnPurchOrders) //- xRec."Qty. to Receive");
        //             else
        //                 VALIDATE(Quantity, "Initial Quantity FND"); //- xRec."Qty. to Receive");
        //                                                         //VALIDATE(Quantity,QtyOnPurchOrders + Quantity + "Qty. to Receive");
        //                                                         //HEI.55>>
        //                                                         //VALIDATE("Qty. to Receive",QtyToReceive);  // It would have run the Loop Recursively
        //                                                         //HEI.55<<
        //             MODIFY();
        //             //end//HEI.62
        //             //>>HEI.62
        //         end
        //         else begin
        //             if "Initial Quantity FND" < ("Quantity Received" + "Qty. to Receive" + QtyOnPurchOrders) then
        //                 VALIDATE(Quantity, "Quantity Received" + "Qty. to Receive" + QtyOnPurchOrders) //- xRec."Qty. to Receive");
        //             else
        //                 VALIDATE(Quantity, "Initial Quantity FND"); //- xRec."Qty. to Receive");
        //             MODIFY();
        //         end;
        //         //<<HEI.62


        //     end else
        //         if "Document Type" = "Document Type"::Order then begin
        //             if ("Quantity Received" + "Qty. to Receive") > Quantity then begin
        //                 if ("Quantity Received" + "Qty. to Receive") > Quantity + (Quantity * "Tolerance Received Over % FND" / 100) then
        //                     ERROR(QtyOverConsOverToleranceErr, "Tolerance Received Over % FND", '%', FIELDCAPTION("SRM Contract No. FND"), "SRM Contract No. FND");

        //                 QtyToReceive := "Qty. to Receive";
        //                 VALIDATE(Quantity, "Quantity Received" + "Qty. to Receive");
        //                 VALIDATE("Qty. to Receive", QtyToReceive);
        //                 MODIFY();
        //             end;
        //         end;
        // end;
        //HEI.04<<
        if (Rec."SRM Contract No. FND" = '') or
            (CurrFieldNo <> Rec.FIELDNO("Qty. to Receive"))
        then
            exit;

        PurchSetup.GET();
        Rec.CALCFIELDS("SRM Contract Type FND");
        SRMContractType.GET(Rec."SRM Contract Type FND");
        if Rec."Document Type" = Rec."Document Type"::"Blanket Order" then begin
            PurchaseLine.SETFILTER("Document Type", '%1|%2', PurchaseLine."Document Type"::Order, PurchaseLine."Document Type"::"Return Order");
            PurchaseLine.SETRANGE("SRM Contract No. FND", Rec."SRM Contract No. FND");
            PurchaseLine.SETRANGE("SRM Contract Line No. FND", Rec."SRM Contract Line No. FND");
            PurchaseLine.SETRANGE("Blanket Order Line No.", Rec."Line No.");
            if PurchaseLine.findset() then
                repeat
                    if PurchaseLine."Document Type" = PurchaseLine."Document Type"::Order then begin
                        QtyOnOrders := QtyOnOrders + PurchaseLine."Outstanding Quantity";
                        QtyOnPurchOrders := QtyOnPurchOrders + PurchaseLine."Outstanding Quantity";
                    end else
                        if PurchaseLine."Document Type" = PurchaseLine."Document Type"::"Return Order" then
                            QtyOnOrders := QtyOnOrders - PurchaseLine."Outstanding Quantity"
                until PurchaseLine.NEXT() = 0;
            if (Rec."Quantity Received" + QtyOnOrders + Rec."Qty. to Receive") > Rec."Initial Quantity FND" then begin
                if SRMContractType."Allow Over Consumption on Qty." = SRMContractType."Allow Over Consumption on Qty."::Never then
                    ERROR(STRSUBSTNO(QtyOverConsNotAllowedErr, Rec.FIELDCAPTION("SRM Contract Line No. FND"), Rec."SRM Contract Line No. FND"))
                else
                    if (SRMContractType."Allow Over Consumption on Qty." = SRMContractType."Allow Over Consumption on Qty."::"Setup Dependant") and
                        (not PurchSetup."Allow OverConsumption Qty. FND")
                    then
                        ERROR(STRSUBSTNO(QtyOverConsNotAllowedErr, Rec.FIELDCAPTION("SRM Contract Line No. FND"), Rec."SRM Contract Line No. FND"));
            end;
            if Rec."Qty. to Receive" <> 0 then begin //HEI.62
                                                     //IF "Quantity Received" + QtyOnPurchOrders + "Qty. to Receive" > Quantity THEN BEGIN //HEI.62
                QtyToReceive := Rec."Qty. to Receive";
                if Rec."Initial Quantity FND" < (Rec."Quantity Received" + Rec."Qty. to Receive" + QtyOnPurchOrders) then
                    Rec.VALIDATE(Quantity, Rec."Quantity Received" + Rec."Qty. to Receive" + QtyOnPurchOrders) //- xRec."Qty. to Receive");
                else
                    Rec.VALIDATE(Quantity, Rec."Initial Quantity FND"); //- xRec."Qty. to Receive");
                                                                        //VALIDATE(Quantity,QtyOnPurchOrders + Quantity + "Qty. to Receive");
                                                                        //HEI.55>>
                                                                        //VALIDATE("Qty. to Receive",QtyToReceive);  // It would have run the Loop Recursively
                                                                        //HEI.55<<
                Rec.MODIFY();
                //end//HEI.62
                //>>HEI.62
            end
            else begin
                if Rec."Initial Quantity FND" < (Rec."Quantity Received" + Rec."Qty. to Receive" + QtyOnPurchOrders) then
                    Rec.VALIDATE(Quantity, Rec."Quantity Received" + Rec."Qty. to Receive" + QtyOnPurchOrders) //- xRec."Qty. to Receive");
                else
                    Rec.VALIDATE(Quantity, Rec."Initial Quantity FND"); //- xRec."Qty. to Receive");
                Rec.MODIFY();
            end;
            //<<HEI.62


        end else
            if Rec."Document Type" = Rec."Document Type"::Order then begin
                if (Rec."Quantity Received" + Rec."Qty. to Receive") > Rec.Quantity then begin
                    if (Rec."Quantity Received" + Rec."Qty. to Receive") > Rec.Quantity + (Rec.Quantity * Rec."Tolerance Received Over % FND" / 100) then
                        ERROR(QtyOverConsOverToleranceErr, Rec."Tolerance Received Over % FND", '%', Rec.FIELDCAPTION("SRM Contract No. FND"), Rec."SRM Contract No. FND");

                    QtyToReceive := Rec."Qty. to Receive";
                    Rec.VALIDATE(Quantity, Rec."Quantity Received" + Rec."Qty. to Receive");
                    Rec.VALIDATE("Qty. to Receive", QtyToReceive);
                    Rec.MODIFY();
                end;
            end;
        // BC Upgrade PATELP08 <<
    end;

    [EventSubscriber(ObjectType::Table, 7317, 'OnBeforeValidateEvent', 'Qty. to Receive', false, false)]
    local procedure T7317OnBeforeValidateQtyToReceive(var Rec: Record "Warehouse Receipt Line"; var xRec: Record "Warehouse Receipt Line"; CurrFieldNo: Integer);
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        ReleasePurchDoc: Codeunit "Release Purchase Document";
        QtyToReceive: Decimal;
    begin
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases.
        //HEI.04>>
        // with Rec do begin
        //     if ("Source Type" <> DATABASE::"Purchase Line") or
        //        (CurrFieldNo <> FIELDNO("Qty. to Receive"))
        //     then
        //         exit;

        //     if not PurchaseLine.GET("Source Subtype", "Source No.", "Source Line No.") then
        //         exit;

        //     if (PurchaseLine."Document Type" <> PurchaseLine."Document Type"::Order) or
        //        (PurchaseLine."SRM Contract No. FND" = '')
        //     then
        //         exit;

        //     if "Qty. to Receive" > Quantity then begin
        //         if ("Qty. to Receive" + "Qty. Received") >
        //            (PurchaseLine."Initial Quantity FND" + PurchaseLine."Initial Quantity FND" * PurchaseLine."Tolerance Received Over % FND" / 100)
        //         then
        //             ERROR(QtyOverConsOverToleranceErr, PurchaseLine."Tolerance Received Over % FND", '%',
        //                                               PurchaseLine.FIELDCAPTION("SRM Contract No. FND"), PurchaseLine."SRM Contract No. FND");
        //         // PurchaseLine.fctSetChangedFromWarehouseRcpt(true);//BC Upgrade SHARMP16 -- Drink-IT code
        //         PurchaseHeader.GET(PurchaseLine."Document Type", PurchaseLine."Document No.");
        //         ReleasePurchDoc.Reopen(PurchaseHeader);
        //         QtyToReceive := PurchaseLine."Qty. to Receive";
        //         PurchaseLine.VALIDATE(Quantity, PurchaseLine.Quantity + "Qty. to Receive" - Quantity);
        //         PurchaseLine.VALIDATE("Qty. to Receive", QtyToReceive);
        //         PurchaseLine.MODIFY(true);

        //         QtyToReceive := "Qty. to Receive";
        //         VALIDATE(Quantity, "Qty. to Receive");
        //         VALIDATE("Qty. to Receive", QtyToReceive);
        //         MODIFY();

        //         CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeader);
        //     end;
        // end;
        //HEI.04<<
        if (Rec."Source Type" <> DATABASE::"Purchase Line") or
            (CurrFieldNo <> Rec.FIELDNO("Qty. to Receive"))
        then
            exit;

        if not PurchaseLine.GET(Rec."Source Subtype", Rec."Source No.", Rec."Source Line No.") then
            exit;

        if (PurchaseLine."Document Type" <> PurchaseLine."Document Type"::Order) or
            (PurchaseLine."SRM Contract No. FND" = '')
        then
            exit;

        if Rec."Qty. to Receive" > Rec.Quantity then begin
            if (Rec."Qty. to Receive" + Rec."Qty. Received") >
                (PurchaseLine."Initial Quantity FND" + PurchaseLine."Initial Quantity FND" * PurchaseLine."Tolerance Received Over % FND" / 100)
            then
                ERROR(QtyOverConsOverToleranceErr, PurchaseLine."Tolerance Received Over % FND", '%',
                                                    PurchaseLine.FIELDCAPTION("SRM Contract No. FND"), PurchaseLine."SRM Contract No. FND");
            // PurchaseLine.fctSetChangedFromWarehouseRcpt(true);//BC Upgrade SHARMP16 -- Drink-IT code
            PurchaseHeader.GET(PurchaseLine."Document Type", PurchaseLine."Document No.");
            ReleasePurchDoc.Reopen(PurchaseHeader);
            QtyToReceive := PurchaseLine."Qty. to Receive";
            PurchaseLine.VALIDATE(Quantity, PurchaseLine.Quantity + Rec."Qty. to Receive" - Rec.Quantity);
            PurchaseLine.VALIDATE("Qty. to Receive", QtyToReceive);
            PurchaseLine.MODIFY(true);

            QtyToReceive := Rec."Qty. to Receive";
            Rec.VALIDATE(Quantity, Rec."Qty. to Receive");
            Rec.VALIDATE("Qty. to Receive", QtyToReceive);
            Rec.MODIFY();

            CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeader);
        end;
        // BC Upgrade PATELP08 <<
    end;
    //BC Upgrade SHARMP16 begin>> ------------- Interface code
    // [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Blanket Order No.', false, false)]
    // local procedure T38OnAfterValidateBlanketOrderNo(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    // var
    //     PurchaseLine: Record "Purchase Line";
    // //   SRMInterfaceManagement: Codeunit "SRM Interface Management";//BC Upgrade SHARMP16-- Interface code
    // begin
    //     //HEI.04>>
    //     with Rec do begin
    //         if ("Document Type" <> "Document Type"::Quote) and
    //            ("Document Type" <> "Document Type"::Order) and
    //            ("Document Type" <> "Document Type"::"Return Order")
    //         then
    //             exit;

    //         if "Blanket Order No." <> xRec."Blanket Order No." then;
    //         //  SRMInterfaceManagement.UpdateSRMHeaderFromBlanketOrder(Rec);//BC Upgrade SHARMP16-- Interface code
    //     end;
    //     //HEI.04<<
    // end;

    // [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Blanket Order Line No.', false, false)]
    // local procedure T39OnAfterValidateBlanketOrderLineNo(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    // var
    //     PurchHeader: Record "Purchase Header";
    //     PurchLine: Record "Purchase Line";
    //     BlanketOrderLine: Record "Purchase Line";
    //     //   SRMInterfaceManagement: Codeunit "SRM Interface Management";//BC Upgrade SHARMP16-- Interface code
    //     PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
    // begin
    //     //HEI.04>>
    //     with Rec do begin
    //         if ("Document Type" <> "Document Type"::Quote) and
    //            ("Document Type" <> "Document Type"::Order) and
    //            ("Document Type" <> "Document Type"::"Return Order")
    //         then
    //             exit;

    //         if ("Blanket Order No." <> xRec."Blanket Order No.") or
    //            ("Blanket Order Line No." <> xRec."Blanket Order Line No.")
    //         then begin
    //             //  SRMInterfaceManagement.UpdateSRMLineFromBlanketOrderLine(Rec, xRec);//BC Upgrade SHARMP16-- Interface code
    //             if "Blanket Order Line No." = 0 then
    //                 "Blanket Order No." := ''
    //             else begin
    //                 PurchLine.SETRANGE("Document Type", "Document Type");
    //                 PurchLine.SETRANGE("Document No.", "Document No.");
    //                 PurchLine.SETFILTER("Line No.", '<>%1', "Line No.");
    //                 PurchLine.SETFILTER("Blanket Order Line No.", '<>%1', 0);
    //                 if PurchLine.findset then
    //                     repeat
    //                         if PurchLine."Blanket Order No." = '' then begin
    //                             PurchLine.VALIDATE("Blanket Order No.", "Blanket Order No.");
    //                             PurchLine.MODIFY;
    //                         end else
    //                             TESTFIELD("Blanket Order No.", PurchLine."Blanket Order No.");
    //                     until PurchLine.NEXT = 0;
    //             end;
    //             PurchHeader.GET("Document Type", "Document No.");
    //             if PurchHeader."Blanket Order No." <> "Blanket Order No." then begin
    //                 PurchHeader.VALIDATE("Blanket Order No.", "Blanket Order No.");
    //                 PurchHeader.MODIFY;
    //             end;
    //             //if PurchHeader."Link Purch. Document No." = '' then begin//BC Upgrade SHARMp16-- Drink-IT field
    //             PurchPriceCalcMgt.FindPurchLinePrice(PurchHeader, Rec, CurrFieldNo);
    //             VALIDATE("Direct Unit Cost");
    //             //end;
    //         end;
    //     end;
    //     //HEI.04<<
    // end;
    //BC Upgrade SHARMP16 end<< ------------- Interface code
    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure T39OnAfterValidateNo(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        //HEI.04>>
        if Rec.ISTEMPORARY then
            exit;
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases.
        // with Rec do begin
        //     PurchaseHeader.GET("Document Type", "Document No.");
        //     if PurchaseHeader."Blanket Order No." = '' then
        //         exit;

        //     //VALIDATE("Blanket Order No.",PurchaseHeader."Blanket Order No.");
        // end;
        //HEI.04<<
        PurchaseHeader.GET(Rec."Document Type", Rec."Document No.");
        if PurchaseHeader."Blanket Order No. FND" = '' then
            exit;

        //VALIDATE("Blanket Order No.",PurchaseHeader."Blanket Order No.");
        // BC Upgrade PATELP08 <<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Quantity', false, false)]
    local procedure T39OnAfterValidateQuantity(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    begin
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases.
        // with Rec do begin
        //     if ("Document Type" <> "Document Type"::Order) or
        //        ("SRM Contract No. FND" = '') or
        //        (CurrFieldNo <> FIELDNO(Quantity))
        //     then
        //         exit;

        //     "Initial Quantity FND" := Quantity;
        // end;
        if (Rec."Document Type" <> Rec."Document Type"::Order) or
            (Rec."SRM Contract No. FND" = '') or
            (CurrFieldNo <> Rec.FIELDNO(Quantity))
        then
            exit;

        Rec."Initial Quantity FND" := Rec.Quantity;
        // BC Upgrade PATELP08 <<
    end;

    // BC Upgrade SHUKLP03 >> Added in the interface ext.
    // [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePostPurchaseDoc', '', false, false)]
    // local procedure C90OnBeforePostPurchaseDoc(var PurchaseHeader: Record "Purchase Header");
    // var
    //     PurchaseLine: Record "Purchase Line";
    //     SRMPOwithMaterial: Boolean;
    //     PurchaseAdditional: Record "Purchase Header Additional FND";

    //     ApprovalsMgmt: Codeunit "Approvals Mgmt.";


    //     WorkflowNotFoundError: Label 'Purchase Invoice %1 have upper tolerance restriction and "tolerance approval" is mandatory in" Purchases & Payable setup" but workflow is not enabled for the same.';
    //     PurchaseAdditionalL: Record "Purchase Header Additional FND";
    //     PurchaseLineL: Record "Purchase Line";
    //     ZycusOrderNoL: Code[20];
    // begin
    //     //HEI.154>>
    //     GetPurchSetup();
    //     if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice) and PurchSetup."Check Tolerance Approval" then begin
    //         PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
    //         PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
    //         PurchaseLine.SETFILTER(Type, '<>%1', PurchaseLine.Type::" ");
    //         if PurchaseLine.FINDSET then
    //             repeat
    //                 CheckToleranceWarning(PurchaseLine);
    //             until PurchaseLine.NEXT = 0;
    //         //----------------------------------
    //         PurchaseLine.RESET;
    //         PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
    //         PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
    //         PurchaseLine.SETFILTER(Type, '<>%1', PurchaseLine.Type::" ");
    //         PurchaseLine.SETRANGE("Tolerance Exceeded FND", true);
    //         if PurchaseLine.FINDSET(true, false) then
    //             if (PurchaseHeader.Status = PurchaseHeader.Status::Open) and not ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) then
    //                 ERROR(WorkflowNotFoundError, PurchaseHeader."No.");

    //         ApprovalsMgmt.PrePostApprovalCheckPurch(PurchaseHeader);
    //     end;
    //     //HEI.154<<
    //     //HEI.04>>
    //     if PurchaseHeader."SRM Order No. FND" = '' then
    //         exit;
    //     //HEI.133>>
    //     SRMPOwithMaterial := false;
    //     //HEI.143>>
    //     if (PurchaseAdditional.GET(PurchaseHeader."Document Type", PurchaseHeader."No.")) and (PurchaseAdditional."Shopping Card No." <> '') then begin
    //         PurchaseLine.RESET;
    //         PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
    //         PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
    //         //PurchaseLine.SETFILTER(Type,'%1|%2|%3',PurchaseLine.Type::"G/L Account",PurchaseLine.Type::"Fixed Asset",PurchaseLine.Type::Item); //HEI.145
    //         PurchaseLine.SETFILTER(Type, '%1|%2', PurchaseLine.Type::"G/L Account", PurchaseLine.Type::"Fixed Asset"); //HEI.145
    //         PurchaseLine.SETFILTER("Qty. to Receive", '<>%1', 0);
    //         if PurchaseLine.ISEMPTY then
    //             SRMPOwithMaterial := true;
    //     end else begin
    //         PurchaseLine.RESET;
    //         PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
    //         PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
    //         //HEI.142>>
    //         PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
    //         //PurchaseLine.SETFILTER(Type,'%1|%2',PurchaseLine.Type::"G/L Account",PurchaseLine.Type::"Charge (Item)");
    //         //PurchaseLine.SETFILTER("Qty. to Receive",'<>%1',0);
    //         //HEI.142<<
    //         if not PurchaseLine.ISEMPTY then
    //             SRMPOwithMaterial := true;
    //     end;
    //     //HEI.143<<
    //     //HEI.133<<
    //     //HEI.158>>
    //     if PurchaseAdditionalL.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") then begin
    //         if PurchaseAdditionalL."Zycus Order No." <> '' then begin
    //             CLEAR(SRMPOwithMaterial);
    //             ZycusOrderNoL := PurchaseAdditionalL."Zycus Order No.";
    //             PurchaseLine.RESET;
    //             PurchaseLine.SETCURRENTKEY("Document Type", "Document No.", Type, "Qty. to Receive");
    //             PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
    //             PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
    //             PurchaseLine.SETFILTER(Type, '%1|%2', PurchaseLine.Type::"G/L Account", PurchaseLine.Type::"Fixed Asset");
    //             PurchaseLine.SETFILTER("Qty. to Receive", '<>0');
    //             if PurchaseLine.ISEMPTY then begin
    //                 SRMPOwithMaterial := true;
    //             end else begin
    //                 PurchaseLine.RESET;
    //                 PurchaseLine.SETCURRENTKEY("Document Type", "Document No.", Type);
    //                 PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
    //                 PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
    //                 PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
    //                 if not PurchaseLine.ISEMPTY then begin
    //                     PurchaseLineL.RESET;
    //                     PurchaseLineL.COPYFILTERS(PurchaseLine);
    //                     PurchaseLineL.SETFILTER(Type, '%1|%2', PurchaseLineL.Type::"G/L Account", PurchaseLineL.Type::"Fixed Asset");
    //                     if PurchaseLineL.ISEMPTY then
    //                         SRMPOwithMaterial := true;
    //                 end;
    //             end;
    //         end;
    //     end;
    //     //HEI.158<<
    //     //IF PurchaseHeader.Receive AND GUIALLOWED THEN   //HEI.133
    //     if PurchaseHeader.Receive and (GUIALLOWED and not SRMPOwithMaterial) then   //HEI.133
    //                                                                                 //HEI.158>>
    //         if ZycusOrderNoL <> '' then
    //             ERROR(Text022, ZycusOrderNoL, Text021)
    //         else
    //             //HEI.158<<
    //             ERROR(ReceiveNotAllowedErr);
    //     //HEI.04<<
    // end;
    // BC Upgrade SHUKLP03 << Added in the interface ext.

    [EventSubscriber(ObjectType::Table, 23, 'OnAfterModifyEvent', '', false, false)]
    local procedure T23OnAfterModify(var Rec: Record Vendor; var xRec: Record Vendor; RunTrigger: Boolean);
    var
        OrderAddress: Record "Order Address";
    begin
        //HEI.05>>
        Rec.CALCFIELDS("Supplying Plant of Vendor FND");
        if Rec."Supplying Plant of Vendor FND" then begin
            OrderAddress.SETRANGE("Supplying Plant Vndor Num. FND", Rec."No.");
            if OrderAddress.findset() then
                repeat
                    OrderAddress.VALIDATE(Name, Rec.Name);
                    OrderAddress.VALIDATE("Name 2", Rec."Name 2");
                    OrderAddress.VALIDATE(Address, Rec.Address);
                    OrderAddress.VALIDATE("Address 2", Rec."Address 2");
                    OrderAddress.VALIDATE("Post Code", Rec."Post Code");
                    OrderAddress.VALIDATE(City, Rec.City);
                    OrderAddress.VALIDATE(County, Rec.County);
                    OrderAddress.VALIDATE("Country/Region Code", Rec."Country/Region Code");
                    OrderAddress.VALIDATE(Contact, Rec.Contact);
                    OrderAddress.VALIDATE("Phone No.", Rec."Phone No.");
                    OrderAddress.VALIDATE("Fax No.", Rec."Fax No.");
                    OrderAddress.VALIDATE("Telex No.", Rec."Telex No.");
                    OrderAddress.VALIDATE("Telex Answer Back", Rec."Telex Answer Back");
                    OrderAddress.VALIDATE("E-Mail", Rec."E-Mail");
                    OrderAddress.VALIDATE("Home Page", Rec."Home Page");
                    OrderAddress.MODIFY(true);
                until OrderAddress.NEXT() = 0;
        end;
        //HEI.05<<
    end;

    [EventSubscriber(ObjectType::Codeunit, 415, 'OnBeforeReleasePurchaseDoc', '', false, false)]
    local procedure OnBeforeReleasePurchaseDocument(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean);
    begin
        if PreviewMode then
            exit;
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases.
        // with PurchaseHeader do begin
        //     if not ("Document Type" in ["Document Type"::Order, "Document Type"::Invoice]) then
        //         exit;

        // end;
        if not (PurchaseHeader."Document Type" in [PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::Invoice]) then
            exit;

        // BC Upgrade PATELP08 <<
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Document Date', false, false)]
    local procedure T38OnAfterValidateDocumentDate(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    begin
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases.
        //HEI.05>>
        // with Rec do begin
        //     if "Document Type" <> "Document Type"::"Blanket Order" then
        //         exit;

        //     if ("Document Date" <> 0D) and ("Consumption Date" = 0D) then
        //         VALIDATE("Consumption Date", "Document Date");
        // end;
        //HEI.05<<
        if Rec."Document Type" <> Rec."Document Type"::"Blanket Order" then
            exit;

        if (Rec."Document Date" <> 0D) and (Rec."Consumption Date FND" = 0D) then
            Rec.VALIDATE("Consumption Date FND", Rec."Document Date");
        // BC Upgrade PATELP08 <<
    end;

    [EventSubscriber(ObjectType::Page, 509, 'OnAfterGetCurrRecordEvent', '', false, false)]
    local procedure P509OnAfterGetCurrRecord(var Rec: Record "Purchase Header");
    begin
        //HEI.05>>
        Rec.VALIDATE("Consumption Date FND", WORKDATE());
        //HEI.05<<
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterTransferSavedFields', '', false, false)]
    local procedure T38OnAfterTransferSavedFields(var DestinationPurchaseLine: Record "Purchase Line"; SourcePurchaseLine: Record "Purchase Line");
    begin
        //HEI.06>>
        DestinationPurchaseLine.VALIDATE("Location Code", SourcePurchaseLine."Location Code");
        DestinationPurchaseLine.VALIDATE("Zone Code FND", SourcePurchaseLine."Zone Code FND");
        DestinationPurchaseLine.VALIDATE("SRM Contract No. FND", SourcePurchaseLine."SRM Contract No. FND");
        DestinationPurchaseLine.VALIDATE("SRM Contract Line No. FND", SourcePurchaseLine."SRM Contract Line No. FND");
        DestinationPurchaseLine.VALIDATE("Type ID FND", SourcePurchaseLine."Type ID FND");
        DestinationPurchaseLine.VALIDATE("CMG Code FND", SourcePurchaseLine."CMG Code FND");
        DestinationPurchaseLine.VALIDATE("Block Line Ordering FND", SourcePurchaseLine."Block Line Ordering FND");
        DestinationPurchaseLine.VALIDATE("Delivery Finalized FND", SourcePurchaseLine."Delivery Finalized FND");
        DestinationPurchaseLine.VALIDATE("Tolerance Received Over % FND", SourcePurchaseLine."Tolerance Received Over % FND");
        DestinationPurchaseLine.VALIDATE("Tolerance Received Under % FND", SourcePurchaseLine."Tolerance Received Under % FND");
        DestinationPurchaseLine.VALIDATE("Consumption Location Code FND", SourcePurchaseLine."Consumption Location Code FND");
        DestinationPurchaseLine.VALIDATE("Initial Quantity FND", SourcePurchaseLine."Initial Quantity FND");
        DestinationPurchaseLine.VALIDATE("Cancelled FND", SourcePurchaseLine."Cancelled FND");
        DestinationPurchaseLine.VALIDATE("SRM Order No. FND", SourcePurchaseLine."SRM Order No. FND");
        DestinationPurchaseLine.VALIDATE("SRM Order Line No. FND", SourcePurchaseLine."SRM Order Line No. FND");
        DestinationPurchaseLine.VALIDATE("Last Changed Date/Time FND", SourcePurchaseLine."Last Changed Date/Time FND");
        DestinationPurchaseLine.VALIDATE("Target Value Currency FND", SourcePurchaseLine."Target Value Currency FND");
        DestinationPurchaseLine.VALIDATE("Target Value Amount FND", SourcePurchaseLine."Target Value Amount FND");
        DestinationPurchaseLine.VALIDATE("Initial Amount FND", SourcePurchaseLine."Initial Amount FND");
        DestinationPurchaseLine.VALIDATE("Invoiced Amount FND", SourcePurchaseLine."Invoiced Amount FND");
        DestinationPurchaseLine.VALIDATE("Remaining Amount FND", SourcePurchaseLine."Remaining Amount FND");
        DestinationPurchaseLine.VALIDATE("Maximo Requisition No. FND", SourcePurchaseLine."Maximo Requisition No. FND");
        DestinationPurchaseLine.VALIDATE("Maximo Requisition No. FND", SourcePurchaseLine."Maximo Requisition No. FND");
        //HEI.06<<
    end;
    //BC Upgrade SHARMP16 begin<<--- Generic Web Service Client codeunit will compile later.
    // [EventSubscriber(ObjectType::Table, 23, 'OnAfterValidateEvent', 'Global Vendor Number', false, false)]
    // local procedure T23OnAfterValidateGlobalVendorNo(var Rec: Record Vendor; var xRec: Record Vendor; CurrFieldNo: Integer);
    // var
    //     Vendor: Record Vendor;
    //     CommonSourceSharingSetup: Record "Common Src Sharing Setup FND";
    //     GlobalSharedSource: Record "Global Shared Source FND";
    //     GenericWebServiceClient: Codeunit "Generic Web Service Client";
    // begin
    //     //HEI.07>>
    //     if Rec."Global Vendor Number" = xRec."Global Vendor Number" then
    //         exit;

    //     //>> HEI.31

    //     if CommonSourceSharingSetup.GET then begin
    //         //>> HEI.48
    //         Vendor.SETRANGE("Global Vendor Number", Rec."Global Vendor Number");
    //         if not Vendor.FINDFIRST then begin
    //             if CommonSourceSharingSetup."Database Level Sharing" = true then begin // HEI.49
    //                 GenericWebServiceClient.CONNECT(CommonSourceSharingSetup."WS Link");
    //                 GenericWebServiceClient.SETFILTER('Global_ID', Rec."Global Vendor Number");
    //                 GenericWebServiceClient.SETFILTER('Local_ID', Rec."No.");
    //                 GenericWebServiceClient.SETFILTER('Company_ID', COMPANYNAME);
    //                 GenericWebServiceClient.SETFILTER('Blocked', 'false');
    //                 if GenericWebServiceClient.READMULTIPLE then
    //                     GenericWebServiceClient.DELETE;
    //             end; //HEI.49
    //         end;
    //         //<< HEI.48
    //         if CommonSourceSharingSetup."Enable Common Vendor Sharing" then begin
    //             GlobalSharedSource.RESET;
    //             GlobalSharedSource.SETRANGE("Source Type", GlobalSharedSource."Source Type"::Vendor);
    //             GlobalSharedSource.SETRANGE("Global ID", Rec."Global Vendor Number");
    //             GlobalSharedSource.SETRANGE("Local ID", Rec."No.");
    //             GlobalSharedSource.SETRANGE("Company ID", COMPANYNAME);
    //             GlobalSharedSource.SETRANGE(Blocked, false);
    //             if GlobalSharedSource.FINDFIRST then
    //                 ERROR(GlobalVendorNoExistsErr, Vendor."Global Vendor Number", Vendor."No.")
    //             else
    //                 exit;
    //         end;
    //     end; // HEI.48
    //     //<< HEI.31

    //     Vendor.SETRANGE("Global Vendor Number", Rec."Global Vendor Number");
    //     if Vendor.FINDFIRST then
    //         ERROR(GlobalVendorNoExistsErr, Vendor."Global Vendor Number", Vendor."No.");
    //     //HEI.07<<
    // end;

    //BC Upgrade SHARMP16 end>>--- Generic Web Service Client codeunit will compile later.

    local procedure CheckBudgetOK(var PurchaseOrder: Record "Purchase Header"; var ExcededAmt: Decimal);
    var
        DimSetEntry: Record "Dimension Set Entry";
        GLBudgetEntry: Record "G/L Budget Entry";
        GLBudgetName: Record "G/L Budget Name";
        //DimBuffer: Record "Invoice Post. Buffer";
        DimBuffer: Record "Invoice Posting Buffer";
        PurchLine: Record "Purchase Line";
        FirstDayMonth: Date;
        LastDayMonth: Date;
    begin
        FirstDayMonth := CALCDATE('<-CM>', PurchaseOrder."Posting Date");
        LastDayMonth := CALCDATE('<CM>', PurchaseOrder."Posting Date");
        GLBudgetName.SETRANGE("Chk. When Pstg. Purch Doc FND", true);
        if GLBudgetName.findset() then begin
            repeat //HEI.23
                GLBudgetEntry.SETRANGE("Budget Name", GLBudgetName.Name);
                GLBudgetEntry.SETRANGE(Date, FirstDayMonth);
                if GLBudgetEntry.FINDFIRST() then
                    repeat
                        CLEAR(DimSetEntry);
                        DimSetEntry.SETRANGE("Dimension Set ID", GLBudgetEntry."Dimension Set ID");
                        if DimSetEntry.findset() then
                            repeat
                                DimBuffer.SETRANGE("G/L Account", DimSetEntry."Dimension Code");
                                DimBuffer.SETRANGE("Job No.", DimSetEntry."Dimension Value Code");
                                if DimBuffer.FINDFIRST() then begin
                                    DimBuffer.Amount += GLBudgetEntry.Amount;
                                    DimBuffer.MODIFY()
                                end else begin
                                    DimBuffer.SETRANGE("G/L Account", DimSetEntry."Dimension Code");
                                    DimBuffer.SETRANGE("Job No.", DimSetEntry."Dimension Value Code");
                                    DimBuffer.Amount := GLBudgetEntry.Amount;
                                    DimBuffer.INSERT();
                                end;
                            until DimSetEntry.NEXT() = 0;
                    //DimBuffer.SETRANGE(DimBuffer."G/L Account"
                    until GLBudgetEntry.NEXT() = 0;
                PurchLine.SETRANGE("Document Type", PurchaseOrder."Document Type");
                PurchLine.SETRANGE("Document No.", PurchaseOrder."No.");
            //  PurchLine
            until GLBudgetName.NEXT() = 0; //HEI.23
        end;
        //UNTIL GLBudgetName.NEXT = 0;
        /*
        IF PurchLine.findset THEN REPEAT
          CLEAR(DimSetEntry);
          DimSetEntry.SETRANGE("Dimension Set ID",PurchLine."Dimension Set ID");
          IF DimSetEntry.FINDFIRST
        UNTIL PurchLine.NEXT = 0;
        */

    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnBeforeValidateEvent', 'Direct Unit Cost', false, false)]
    local procedure PurchaseLineBeforeValidateDirectUnitCost(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        PurchHeader: Record "Purchase Header";
    begin
        //HEI.08>>
        if Rec.ISTEMPORARY then
            exit;
        GetPurchSetup();
        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        if PurchHeader."Document Subtype Code FND" = PurchSetup."PO Prepayment req. Subtype FND" then begin //BC Upgrade SHUKLP03 
            if Rec."Direct Unit Cost" <> 0 then
                PurchHeader.TESTFIELD("Purchase Order No. FND");
        end;
        //HEI.08<<
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnBeforeValidateEvent', 'Purchase Order No. FND', false, false)]
    local procedure PurchaseHeaderBeforeValidatePurchaseOrderNo(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    var
        PurchaseLine: Record "Purchase Line";
    begin
        if Rec.ISTEMPORARY then
            exit;
        GetPurchSetup();
        if (Rec."Document Subtype Code FND" = PurchSetup."PO Prepayment req. Subtype FND") and (Rec."Purchase Order No. FND" = '') and (xRec."Purchase Order No. FND" <> '') then begin //BC Upgrade SHUKLP03
            PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
            PurchaseLine.SETRANGE("Document No.", Rec."No.");
            if PurchaseLine.findset() then
                repeat
                    if PurchaseLine."Direct Unit Cost" <> 0 then
                        ERROR(Text005);
                until PurchaseLine.NEXT() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure OnBeforePostPurchaseDoc(var PurchaseHeader: Record "Purchase Header");
    var
        PurchaseLine: Record "Purchase Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        //HEI.10>>
        PurchasesPayablesSetup.GET();
        if PurchaseHeader."Document Subtype Code FND" = PurchasesPayablesSetup."PO Subtype Code FND" then begin //BC Upgrade SHUKLP03
            PurchaseLine.RESET();
            PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            PurchaseLine.SETRANGE("Manual Insert FND", true);
            if PurchaseLine.FINDFIRST() then
                PurchaseHeader.VALIDATE("Payment Status FND", PurchaseHeader."Payment Status FND"::"Pending Review");
        end;
        //HEI.10<<

        //>> HEI.26 FDD-HT658 IBM.GUNERE01 18.09.2019
        // if PurchaseHeader.Route <> '' then//BC Upgrade SHARP16-- Drink-IT field
        //CheckMandatoryFieldsForRoute(PurchaseHeader);//BCUpgrade sharmp16--PurchaseProcesstestchanges
        //<< HEI.26 FDD-HT658 IBM.GUNERE01 18.09.2019
    end;

    local procedure CalculateAmountFALedgEntry(FANo: Code[20]; PostingDate: Date; DimCode: Code[20]; DimValueCode: Code[20]; PurchLineLineNo: Integer; PurchaseDocNo: Code[20]; GLAccNo: Code[20]): Decimal;
    var
        CurrExchRate: Record "Currency Exchange Rate";
        DimSetEntry: Record "Dimension Set Entry";
        FADeprBookCode: Record "FA Depreciation Book";
        FALedgEntry: Record "FA Ledger Entry";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PurchHeader: Record "Purchase Header";
        PurchLines: Record "Purchase Line";
        DuplDeprBookCode: Code[10];
        FAPostingGroup: Code[10];
        CurrAmt: Decimal;
        totalAmount: Decimal;
    begin
        //HEI.11>>
        totalAmount := 0;
        FALedgEntry.RESET();
        FALedgEntry.SETRANGE("FA Posting Type", FALedgEntry."FA Posting Type"::"Acquisition Cost");
        FALedgEntry.SETFILTER("Posting Date", '<=%1', PostingDate);
        if FALedgEntry.findset() then
            repeat
                if GLAccNo = GetFADeprBookCodeGLAcc(FALedgEntry."FA No.", FALedgEntry."Depreciation Book Code") then begin
                    DimSetEntry.RESET();
                    DimSetEntry.SETRANGE("Dimension Set ID", FALedgEntry."Dimension Set ID");
                    DimSetEntry.SETRANGE("Dimension Code", DimCode);
                    DimSetEntry.SETRANGE("Dimension Value Code", DimValueCode);

                    if DimSetEntry.FINDFIRST() then
                        totalAmount += FALedgEntry."Amount (LCY)";

                end;
            until FALedgEntry.NEXT() = 0;



        //add also the purchase order lines which are released
        PurchLines.RESET();
        PurchLines.SETRANGE("Document Type", PurchLines."Document Type"::Order);
        PurchLines.SETRANGE(Type, PurchLines.Type::"Fixed Asset");
        if PurchLines.findset() then
            repeat
                if PurchHeader.GET(PurchLines."Document Type", PurchLines."Document No.") then begin
                    if PurchHeader.Status = PurchHeader.Status::Released then begin
                        DuplDeprBookCode := GetDuplicateDeprBook(PurchLines."Depreciation Book Code", PurchLines."Use Duplication List", PurchLines."Duplicate in Depreciation Book");
                        if (GLAccNo = GetFADeprBookCodeGLAcc(PurchLines."No.", PurchLines."Depreciation Book Code")) or
                           (GLAccNo = GetFADeprBookCodeGLAcc(PurchLines."No.", DuplDeprBookCode)) then begin
                            //check the dimensions
                            DimSetEntry.RESET();
                            DimSetEntry.SETRANGE("Dimension Set ID", PurchLines."Dimension Set ID");
                            DimSetEntry.SETRANGE("Dimension Code", DimCode);
                            DimSetEntry.SETRANGE("Dimension Value Code", DimValueCode);
                            if DimSetEntry.FINDFIRST() then begin
                                //HEI.64 commented>>
                                /*IF PurchHeader."Currency Code" <> '' THEN
                                  CurrAmt :=
                                      ABS(ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                        //PurchHeader."Posting Date", PurchHeader."Currency Code", PurchLines."Amount Including VAT",
                                        PurchHeader."Posting Date", PurchHeader."Currency Code", PurchLines."Amount Including VAT",
                                        CurrExchRate.ExchangeRate(PurchHeader."Posting Date", PurchHeader."Currency Code"))))
                                else */
                                //HEI.64 commented<<
                                CurrAmt := PurchLines."Outstanding Amt. Ex. VAT (LCY)"; //HEI.64
                                                                                        //>> HEI.47
                                                                                        //CurrAmt := PurchLines."Amount Including VAT";
                                                                                        //CurrAmt := PurchLines.Amount; //HEI.64 commented
                                                                                        //<< HEI.47

                            end;
                            totalAmount += CurrAmt;
                            CLEAR(CurrAmt);
                        end;


                    end;
                end;
            until PurchLines.NEXT() = 0;


        //HEI.64<<
        //add also the purchase invoice lines which are released
        PurchLines.RESET();
        PurchLines.SETRANGE("Document Type", PurchLines."Document Type"::Invoice);
        PurchLines.SETRANGE(Type, PurchLines.Type::"Fixed Asset");
        if PurchLines.findset() then
            repeat
                if PurchHeader.GET(PurchLines."Document Type", PurchLines."Document No.") then begin
                    if PurchHeader.Status = PurchHeader.Status::Released then begin
                        DuplDeprBookCode := GetDuplicateDeprBook(PurchLines."Depreciation Book Code", PurchLines."Use Duplication List", PurchLines."Duplicate in Depreciation Book");
                        if (GLAccNo = GetFADeprBookCodeGLAcc(PurchLines."No.", PurchLines."Depreciation Book Code")) or
                           (GLAccNo = GetFADeprBookCodeGLAcc(PurchLines."No.", DuplDeprBookCode)) then begin
                            //check the dimensions
                            DimSetEntry.RESET();
                            DimSetEntry.SETRANGE("Dimension Set ID", PurchLines."Dimension Set ID");
                            DimSetEntry.SETRANGE("Dimension Code", DimCode);
                            DimSetEntry.SETRANGE("Dimension Value Code", DimValueCode);
                            if DimSetEntry.FINDFIRST() then begin
                                if PurchLines."Order No." = '' then
                                    CurrAmt := PurchLines."Outstanding Amt. Ex. VAT (LCY)"
                                else if PurchRcptLine.GET(PurchLines."Receipt No.", PurchLines."Receipt Line No.") then
                                    if PurchRcptLine."Currency Code" <> '' then
                                        //BC Upgarde SHARMP16 Drink-It filed used-- Line Amount begin>>
                                        CurrAmt :=
                        ABS(ROUND(PurchLines."Outstanding Amt. Ex. VAT (LCY)" -
                        CurrExchRate.ExchangeAmtFCYToLCY(
                        // PurchRcptLine."Posting Date", PurchRcptLine."Currency Code", PurchRcptLine."Line Amount", //BC Upgrade SHARMP16
                        PurchRcptLine."Posting Date", PurchRcptLine."Currency Code", PurchRcptLine."Amount Heilite FND", //BC Upgrade SHARMP16 // Bc Upgrade BHARDA11 << --30April2026 --Replace Line Amount with Amount heilite --30April2026
                        CurrExchRate.ExchangeRate(PurchRcptLine."Posting Date", PurchRcptLine."Currency Code"))))
                                    else
                                        // CurrAmt := PurchLines."Outstanding Amt. Ex. VAT (LCY)" - PurchRcptLine."Line Amount";
                                        CurrAmt := PurchLines."Outstanding Amt. Ex. VAT (LCY)" - PurchRcptLine."Amount Heilite FND"; // Bc Upgrade BHARDA11 << --30April2026
                                //BC Upgarde SHARMP16 Drink-It filed used-- Line Amount end<<
                            end;
                            totalAmount += CurrAmt;
                            CLEAR(CurrAmt);
                        end;
                    end;
                end;
            until PurchLines.NEXT() = 0;
        //HEI.64>>

        //HEI.64 commented<<
        //lines from current document
        //add also the purchase order lines which are released
        /*PurchLines.RESET;
        PurchLines.SETRANGE("Document Type", PurchLines."Document Type"::Order);
        PurchLines.SETRANGE("Document No.", PurchaseDocNo);
        PurchLines.SETFILTER("Line No.", '<>%1', PurchLineLineNo);
        PurchLines.SETRANGE(Type, PurchLines.Type::"Fixed Asset");
        IF PurchLines.findset THEN
          REPEAT
            IF PurchHeader.GET(PurchLines."Document Type", PurchLines."Document No.") THEN BEGIN
              DuplDeprBookCode := GetDuplicateDeprBook(PurchLines."Depreciation Book Code", PurchLines."Use Duplication List", PurchLines."Duplicate in Depreciation Book");
              IF (GLAccNo = GetFADeprBookCodeGLAcc(PurchLines."No.", PurchLines."Depreciation Book Code")) OR
                 (GLAccNo = GetFADeprBookCodeGLAcc(PurchLines."No.", DuplDeprBookCode)) THEN BEGIN
               //check the dimensions
                DimSetEntry.RESET;
                DimSetEntry.SETRANGE("Dimension Set ID", PurchLines."Dimension Set ID");
                DimSetEntry.SETRANGE("Dimension Code", DimCode);
                DimSetEntry.SETRANGE("Dimension Value Code",DimValueCode);
                IF DimSetEntry.FINDFIRST THEN BEGIN
                   IF PurchHeader."Currency Code" <> '' THEN
                    CurrAmt :=
                        ABS(ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          PurchHeader."Posting Date", PurchHeader."Currency Code", PurchLines."Amount Including VAT",
                          CurrExchRate.ExchangeRate(PurchHeader."Posting Date", PurchHeader."Currency Code"))))
                  else
                    //>> HEI.47
                    //CurrAmt := PurchLines."Amount Including VAT";
                    CurrAmt := PurchLines.Amount;
                    //<< HEI.47
        
                end;
                totalAmount += CurrAmt;
                CLEAR(CurrAmt);
             end;
            end;
          UNTIL PurchLines.NEXT = 0;*/
        //HEI.64 commented>>

        exit(totalAmount);

    end;

    [EventSubscriber(ObjectType::Table, 25, 'OnAfterValidateEvent', 'Payment Status FND', false, false)]
    local procedure T25OnAfterValidatePaymentStatus(var Rec: Record "Vendor Ledger Entry"; var xRec: Record "Vendor Ledger Entry"; CurrFieldNo: Integer);
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        //HEI.09>>
        if Rec."Payment Status FND" = xRec."Payment Status FND" then
            exit;

        if Rec."Document Type" = Rec."Document Type"::Invoice then begin
            if PurchInvHeader.GET(Rec."Document No.") then begin
                PurchInvHeader.VALIDATE("Payment Status FND", Rec."Payment Status FND");
                PurchInvHeader.MODIFY();
            end;
        end;
        //HEI.09<<
    end;

    [EventSubscriber(ObjectType::Table, 25, 'OnAfterValidateEvent', 'Reason Code', false, false)]
    local procedure T25OnAfterValidateReasonCode(var Rec: Record "Vendor Ledger Entry"; var xRec: Record "Vendor Ledger Entry"; CurrFieldNo: Integer);
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        //HEI.12>>
        if Rec."Reason Code" = xRec."Reason Code" then
            exit;

        if Rec."Document Type" = Rec."Document Type"::Invoice then begin
            if PurchInvHeader.GET(Rec."Document No.") then begin
                PurchInvHeader.VALIDATE("Reason Code", Rec."Reason Code");
                PurchInvHeader.MODIFY();
            end;
        end;
        //HEI.12<<
    end;

    [EventSubscriber(ObjectType::Codeunit, 415, 'OnBeforeReleasePurchaseDoc', '', false, false)]
    local procedure CU415OnbeforeReleasepurchDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean);
    var
        DimBuffer: Record "Budget Buffer" temporary;
        CurrExchRate: Record "Currency Exchange Rate";
        DimSetEntry: Record "Dimension Set Entry";
        FALedgEntry: Record "FA Ledger Entry";
        FAPostingGroup: Record "FA Posting Group";
        GLBudgetEntry: Record "G/L Budget Entry";
        GLBudgetName: Record "G/L Budget Name";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PurchLine: Record "Purchase Line";
        DuplDeprBookCode: Code[10];
        GLAccNo: Code[20];
        FirstDayMonth: Date;
        FirstYearDate: Date;
        LastDayMonth: Date;
        LastYearDate: Date;
        PurchHeaderDate: Date;
        TotalAmt: Decimal;
        CurrentYear: Integer;
    begin
        //HEI.11>>
        if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) or (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice) then begin

            if PurchaseHeader."Posting Date" <> 0D then begin
                PurchHeaderDate := PurchaseHeader."Posting Date";
                CurrentYear := DATE2DMY(PurchaseHeader."Posting Date", 3);
                FirstYearDate := DMY2DATE(1, 1, CurrentYear);
                LastYearDate := DMY2DATE(31, 12, CurrentYear);
            end else begin
                if PurchaseHeader."Document Date" <> 0D then begin
                    PurchHeaderDate := PurchaseHeader."Document Date";
                    CurrentYear := DATE2DMY(PurchaseHeader."Document Date", 3);
                    FirstYearDate := DMY2DATE(1, 1, CurrentYear);
                    LastYearDate := DMY2DATE(31, 12, CurrentYear);
                end;
            end;

            // make Budget Entry total amount for Dimension Set ID combination
            GLBudgetName.SETRANGE("Chk. When Pstg. Purch Doc FND", true);
            if GLBudgetName.FINDFIRST() then begin
                repeat //HEI.39
                    TotalAmt := 0; //HEI.64
                    GLBudgetEntry.RESET();
                    GLBudgetEntry.SETRANGE("Budget Name", GLBudgetName.Name);
                    GLBudgetEntry.SETRANGE(Date, FirstYearDate, LastYearDate);
                    if GLBudgetEntry.FINDFIRST() then
                        repeat

                            DimBuffer.RESET();
                            DimBuffer.SETRANGE("G/L Account No.", GLBudgetName."Budget Dimension 1 Code");
                            DimBuffer.SETRANGE("Dimension Value Code 1", GLBudgetEntry."Budget Dimension 1 Code");
                            DimBuffer.SETRANGE("Dimension Value Code 2", GLBudgetEntry."G/L Account No."); // for g/l account
                            if DimBuffer.FINDFIRST() then begin
                                DimBuffer.Amount += GLBudgetEntry.Amount;
                                DimBuffer.MODIFY()
                            end else begin
                                DimBuffer.INIT();
                                DimBuffer."G/L Account No." := GLBudgetName."Budget Dimension 1 Code";
                                DimBuffer."Dimension Value Code 1" := GLBudgetEntry."Budget Dimension 1 Code";
                                DimBuffer."Dimension Value Code 2" := GLBudgetEntry."G/L Account No.";
                                DimBuffer.Amount := GLBudgetEntry.Amount;
                                DimBuffer.INSERT();
                            end;

                        until GLBudgetEntry.NEXT() = 0;
                    //end; //HEI.39

                    //test if budget amount < released documents amount FOR principal DEPRECIATION BOOK
                    //HEI.97>>
                    PurchLine.RESET();
                    PurchLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                    PurchLine.SETRANGE("Document No.", PurchaseHeader."No.");
                    PurchLine.SETRANGE(Type, PurchLine.Type::"Fixed Asset");
                    if PurchLine.FINDFIRST() then
                        if PurchRcptHeader.GET(PurchLine."Receipt No.") then;
                    //HEI.97<<
                    PurchLine.RESET();
                    PurchLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                    PurchLine.SETRANGE("Document No.", PurchaseHeader."No.");
                    PurchLine.SETRANGE(Type, PurchLine.Type::"Fixed Asset");
                    //IF PurchLine.findset THEN BEGIN //HEI.97
                    if PurchLine.findset(false) then begin//HEI.97
                        repeat
                            GLAccNo := GetFADeprBookCodeGLAcc(PurchLine."No.", PurchLine."Depreciation Book Code");
                            DimSetEntry.RESET();
                            DimSetEntry.SETRANGE("Dimension Set ID", PurchLine."Dimension Set ID");
                            //IF DimSetEntry.findset THEN //HEI.97
                            if DimSetEntry.findset(false) then//HEI.97
                                repeat

                                    DimBuffer.SETRANGE("G/L Account No.", DimSetEntry."Dimension Code");
                                    DimBuffer.SETRANGE("Dimension Value Code 1", DimSetEntry."Dimension Value Code");
                                    DimBuffer.SETRANGE("Dimension Value Code 2", GLAccNo);
                                    if DimBuffer.FINDFIRST() then begin
                                        //if FCY then convert line amount in LCY
                                        //HEI.64 commented<<
                                        /* IF PurchaseHeader."Currency Code" <> '' THEN
                                           TotalAmt :=
                                             ABS(ROUND(
                                             CurrExchRate.ExchangeAmtFCYToLCY(
                                               PurchaseHeader."Posting Date", PurchaseHeader."Currency Code", PurchLine.Amount,
                                               CurrExchRate.ExchangeRate(PurchHeaderDate, PurchaseHeader."Currency Code"))))
                                         else
                                           TotalAmt := PurchLine.Amount; */
                                        //HEI.64 commented<<

                                        //HEI.64<<
                                        if (PurchLine."Receipt No." <> '') and PurchRcptLine.GET(PurchLine."Receipt No.", PurchLine."Receipt Line No.") then begin
                                            //HEI.97>>
                                            //IF PurchRcptLine."Currency Code" <> '' THEN
                                            //  TotalAmt :=
                                            //      ABS(PurchLine."Outstanding Amt. Ex. VAT (LCY)" - ROUND(
                                            //      CurrExchRate.ExchangeAmtFCYToLCY(
                                            //        PurchRcptLine."Posting Date", PurchRcptLine."Currency Code", PurchRcptLine."Line Amount",
                                            //        CurrExchRate.ExchangeRate(PurchRcptLine."Posting Date", PurchRcptLine."Currency Code"))))
                                            if PurchRcptHeader."Currency Code" <> '' then
                                                //BC Upgrade SHARMP16 -- Drink-IT field used Line Amount begin>>
                                                TotalAmt :=
                                               ABS(PurchLine."Outstanding Amt. Ex. VAT (LCY)" - ROUND(
                                               CurrExchRate.ExchangeAmtFCYToLCY(
                                                 //   PurchRcptLine."Posting Date", PurchRcptHeader."Currency Code", PurchRcptLine."Line Amount",
                                                 PurchRcptLine."Posting Date", PurchRcptHeader."Currency Code", PurchRcptLine."Amount Heilite FND", // BC Upgrade BHARDA11 --Replace Line amout with Amount Heilite  --30April2026
                                                 CurrExchRate.ExchangeRate(PurchRcptLine."Posting Date", PurchRcptHeader."Currency Code"))))
                                            //HEI.97<<
                                            else
                                                // TotalAmt := PurchLine."Outstanding Amt. Ex. VAT (LCY)" - PurchRcptLine."Line Amount";
                                                TotalAmt := PurchLine."Outstanding Amt. Ex. VAT (LCY)" - PurchRcptLine."Amount Heilite FND"; // BC Upgrade BHARDA11 -- Replace Line Amount with Amount Heilite --30April2026
                                            //BC Upgrade SHARMP16 -- Drink-IT field used Line Amount end<<
                                        end else
                                            TotalAmt := PurchLine."Outstanding Amt. Ex. VAT (LCY)";
                                        //HEI.64<<

                                        TotalAmt := TotalAmt + CalculateAmountFALedgEntry(PurchLine."No.", PurchHeaderDate, DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code",
                                                                                          PurchLine."Line No.", PurchLine."Document No.", GLAccNo);
                                        if DimBuffer.Amount < TotalAmt then
                                            ERROR(Text006, DimBuffer.Amount, TotalAmt, GLBudgetName.Name, PurchLine."Depreciation Book Code");
                                    end;
                                until DimSetEntry.NEXT() = 0;

                        until PurchLine.NEXT() = 0;

                    end;


                    //for DUPLICATE Depr Book
                    //test if budget amount < released documents amount FOR DUPLICATE DEPRECIATION BOOK

                    PurchLine.RESET();
                    PurchLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                    PurchLine.SETRANGE("Document No.", PurchaseHeader."No.");
                    PurchLine.SETRANGE(Type, PurchLine.Type::"Fixed Asset");
                    //IF PurchLine.findset THEN BEGIN//HEI.97
                    if PurchLine.findset(false) then begin//HEI.97
                        repeat
                            //IF FAPostingGroup.GET(PurchLine."Posting Group") THEN;
                            DuplDeprBookCode := GetDuplicateDeprBook(PurchLine."Depreciation Book Code", PurchLine."Use Duplication List", PurchLine."Duplicate in Depreciation Book");
                            if DuplDeprBookCode <> '' then begin
                                GLAccNo := GetFADeprBookCodeGLAcc(PurchLine."No.", DuplDeprBookCode);
                                DimSetEntry.RESET();
                                DimSetEntry.SETRANGE("Dimension Set ID", PurchLine."Dimension Set ID");
                                if DimSetEntry.findset() then
                                    repeat
                                        DimBuffer.SETRANGE("G/L Account No.", DimSetEntry."Dimension Code");
                                        DimBuffer.SETRANGE("Dimension Value Code 1", DimSetEntry."Dimension Value Code");
                                        DimBuffer.SETRANGE("Dimension Value Code 2", GLAccNo);
                                        if DimBuffer.FINDFIRST() then begin

                                            //if FCY then convert line amount in LCY
                                            //HEI.64 commented<<
                                            /* IF PurchaseHeader."Currency Code" <> '' THEN
                                              TotalAmt :=
                                                ABS(ROUND(
                                                CurrExchRate.ExchangeAmtFCYToLCY(
                                                  PurchaseHeader."Posting Date", PurchaseHeader."Currency Code", PurchLine.Amount,
                                                  CurrExchRate.ExchangeRate(PurchHeaderDate, PurchaseHeader."Currency Code"))))
                                            else
                                              TotalAmt := PurchLine.Amount; */
                                            //HEI.64 commented<<

                                            //HEI.64<<
                                            if (PurchLine."Receipt No." <> '') and PurchRcptLine.GET(PurchLine."Receipt No.", PurchLine."Receipt Line No.") then begin
                                                //HEI.97>>
                                                //IF PurchRcptLine."Currency Code" <> '' THEN
                                                //  TotalAmt :=
                                                //      ABS(PurchLine."Outstanding Amt. Ex. VAT (LCY)" - ROUND(
                                                //      CurrExchRate.ExchangeAmtFCYToLCY(
                                                //        PurchRcptLine."Posting Date", PurchRcptLine."Currency Code", PurchRcptLine."Line Amount",
                                                //        CurrExchRate.ExchangeRate(PurchRcptLine."Posting Date", PurchRcptLine."Currency Code"))))
                                                if PurchRcptHeader."Currency Code" <> '' then
                                                    //BC Upgrade SHARMP16 -- Drink-IT field used Line Amount begin>>
                                                    TotalAmt :=
                                                        ABS(PurchLine."Outstanding Amt. Ex. VAT (LCY)" - ROUND(
                                                        CurrExchRate.ExchangeAmtFCYToLCY(
                                                          //   PurchRcptLine."Posting Date", PurchRcptHeader."Currency Code", PurchRcptLine."Line Amount",
                                                          PurchRcptLine."Posting Date", PurchRcptHeader."Currency Code", PurchRcptLine."Amount Heilite FND", // BC Upgrade BHARDA11 --30April2026
                                                          CurrExchRate.ExchangeRate(PurchRcptLine."Posting Date", PurchRcptHeader."Currency Code"))))
                                                // //HEI.97<<
                                                else
                                                    // TotalAmt := PurchLine."Outstanding Amt. Ex. VAT (LCY)" - PurchRcptLine."Line Amount";// BC Upgrade BHARDA11 --30April2026
                                                    TotalAmt := PurchLine."Outstanding Amt. Ex. VAT (LCY)" - PurchRcptLine."Amount Heilite FND";// BC Upgrade BHARDA11 --30April2026
                                                //BC Upgrade SHARMP16 -- Drink-IT field used Line Amount end>>
                                            end else
                                                TotalAmt := PurchLine."Outstanding Amt. Ex. VAT (LCY)";
                                            //HEI.64<<

                                            TotalAmt := TotalAmt + CalculateAmountFALedgEntry(PurchLine."No.", PurchHeaderDate, DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code",
                                                                                              PurchLine."Line No.", PurchLine."Document No.", GLAccNo);
                                            if DimBuffer.Amount < TotalAmt then
                                                ERROR(Text006, DimBuffer.Amount, TotalAmt, GLBudgetName.Name, DuplDeprBookCode);
                                        end;
                                    until DimSetEntry.NEXT() = 0;
                            end;
                        until PurchLine.NEXT() = 0;

                    end;
                until GLBudgetName.NEXT() = 0; //HEI.39
            end; //HEI.39
        end;

    end;

    [EventSubscriber(ObjectType::Page, 54, 'OnAfterValidateEvent', 'Blanket Order Line No.', false, false)]
    local procedure P45OnAfterValidateEvent(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line");
    begin
        //HEI.13>>
        if Rec."Maximo Requisition No. FND" <> '' then
            exit;

        ERROR(CannotAssignToBlanketErr);
        //HEI.13<<
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSendPurchaseDocForApproval', '', false, false)]
    local procedure C1535OnSendPurchaseDocForApproval(var PurchaseHeader: Record "Purchase Header");
    begin
        //HEI.14>>
        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then
            exit;

        if PurchaseHeader."SRM Order No. FND" <> '' then
            ERROR(SRMOrderSendToApprovalErr);
        //HEI.14<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnBeforeValidateEvent', 'VAT Prod. Posting Group', false, false)]
    local procedure T39OnBeforeValidateVatProdPostingGroup(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    begin
        if (Rec."SRM Order No. FND" <> '') or (Rec."SRM Contract No. FND" <> '') and (Rec."Document Type" = Rec."Document Type"::Order) then
            Rec.SuspendStatusCheck(true);//HEI.15
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'VAT Prod. Posting Group', false, false)]
    local procedure T39OnAfterValidateVatProdPostingGroup(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    begin
        if (Rec."SRM Order No. FND" <> '') or (Rec."SRM Contract No. FND" <> '') and (Rec."Document Type" = Rec."Document Type"::Order) then
            Rec.SuspendStatusCheck(false);//HEI.15
    end;
    //BC Upgrade SHARMP16 begin>>---------------- Drink-IT action Action82 used
    // [EventSubscriber(ObjectType::Page, page::"Purchase Order", 'OnBeforeActionEvent', 'Action82', false, false)]
    // local procedure P50OnBeforePrintOrder(var Rec: Record "Purchase Header");
    // var
    //     PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    // begin
    //     //HEI.15>>
    //     if (Rec."SRM Order No. FND" <> '') then begin
    //         PurchasesPayablesSetup.GET;
    //         if PurchasesPayablesSetup."Allow printing C&TP PO" = false then
    //             ERROR(PrintOrderError);
    //     end;

    //     if (Rec."Document Type" = Rec."Document Type"::Order) then
    //         //HEI.19>>
    //         //Rec.TESTFIELD(Status,Rec.Status::Released);
    //         if (Rec.Status <> Rec.Status::Released) and (Rec.Status <> Rec.Status::"Pending Prepayment") then
    //             ERROR(POStatusErr);
    //     ////HEI.19<<
    //     //HEI.15<<
    // end;
    //BC Upgrade SHARMP16 end<<---------------- Drink-IT action Action82 used

    //BC Upgrade SHARMP16 begin>>---------------- Drink-IT action Action1100076001 used
    // [EventSubscriber(ObjectType::Page, page::"Purchase Order List", 'OnBeforeActionEvent', 'Action1100076001', false, false)]
    // local procedure P9307OnBeforePrintOrder(var Rec: Record "Purchase Header");
    // var
    //     PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    // begin
    //     //HEI.15>>
    //     if (Rec."SRM Order No. FND" <> '') then begin
    //         PurchasesPayablesSetup.GET;
    //         if PurchasesPayablesSetup."Allow printing C&TP PO" = false then
    //             ERROR(PrintOrderError);
    //     end;
    //     if (Rec."Document Type" = Rec."Document Type"::Order) then
    //         //HEI.19>>
    //         //Rec.TESTFIELD(Status,Rec.Status::Released);
    //         if (Rec.Status <> Rec.Status::Released) and (Rec.Status <> Rec.Status::"Pending Prepayment") then
    //             ERROR(POStatusErr);
    //     ////HEI.19<<
    //     //HEI.15<<
    // end;
    //BC Upgrade SHARMP16 end<<---------------- Drink-IT action Action1100076001 used

    local procedure GetFADeprBookCodeGLAcc(FA: Code[20]; DeprBookCode: Code[10]): Code[20];
    var
        FADeprBookCode: Record "FA Depreciation Book";
        FAPostingGroup: Record "FA Posting Group";
    begin
        //HEI.11
        if FADeprBookCode.GET(FA, DeprBookCode) then
            if FAPostingGroup.GET(FADeprBookCode."FA Posting Group") then begin
                exit(FAPostingGroup."Acquisition Cost Account");
            end;
    end;

    local procedure CheckGLAccNo();
    begin
    end;

    local procedure GetDuplicateDeprBook(DeprBookCode: Code[10]; UseDuplList: Boolean; DuplDeprBookCode: Code[10]): Code[10];
    var
        DepreciationBook: Record "Depreciation Book";
    begin
        //HEI.11
        if DuplDeprBookCode <> '' then
            exit(DuplDeprBookCode)
        else
            if UseDuplList then begin
                DepreciationBook.RESET();
                DepreciationBook.SETFILTER(Code, '<>%1', DeprBookCode);
                DepreciationBook.SETRANGE("Part of Duplication List", true);
                if DepreciationBook.FINDFIRST() then
                    exit(DepreciationBook.Code);
            end;

        exit('');
    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnBeforeValidateEvent', 'Vendor Bank Account FND', false, false)]
    local procedure T81OnBeforeValidateVendorBankAccount(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; CurrFieldNo: Integer);
    begin
        //HEI.16>>
        if not (Rec."Document Type" in [Rec."Document Type"::"Credit Memo", Rec."Document Type"::Invoice]) and (Rec."Account Type" = Rec."Account Type"::Vendor) then begin
            //IF xRec."Vendor Bank Account" <> '' THEN
            ERROR(VendBankAccErr)
        end;
        //HEI.16<<
    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnBeforeValidateEvent', 'Document Type', false, false)]
    local procedure T81OnBeforeValidateDocType(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; CurrFieldNo: Integer);
    begin
        //HEI.16>>
        if Rec."Document Type" = Rec."Document Type"::Invoice then
            UpdateBankAcc(Rec, xRec);
        //HEI.16<<
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnBeforeModifyEvent', '', false, false)]
    local procedure T38OnBeforeModifyRecApplyDoc(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; RunTrigger: Boolean);
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        //HEI.17>>
        VendLedgEntry.SETCURRENTKEY("Document No.", "Document Type");
        VendLedgEntry.SETRANGE("Document No.", Rec."Applies-to Doc. No.");
        VendLedgEntry.SETRANGE("Document Type", Rec."Applies-to Doc. Type");
        if VendLedgEntry.FINDFIRST() then
            if VendLedgEntry."Batch payment name FND" <> '' then
                ERROR(InvoiceIsProposed, Rec."Applies-to Doc. No.", VendLedgEntry."Batch payment name FND");
        //HEI.17<<
    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnBeforeModifyEvent', '', false, false)]
    local procedure T81OnBeforeModifyRecApplyDoc(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; RunTrigger: Boolean);
    var
        GenLedgerSetup: Record "General Ledger Setup";
        VendLedgEntry: Record "Vendor Ledger Entry";
        WHTPostingSetup: Record "WHT Posting Setup FND";
    begin
        //HEI.17>>

        VendLedgEntry.SETCURRENTKEY("Document No.", "Document Type");
        VendLedgEntry.SETRANGE("Document No.", Rec."Applies-to Doc. No.");
        VendLedgEntry.SETRANGE("Document Type", Rec."Applies-to Doc. Type");
        if VendLedgEntry.FINDFIRST() then
            if VendLedgEntry."Batch payment name FND" <> '' then
                ERROR(InvoiceIsProposed, Rec."Applies-to Doc. No.", VendLedgEntry."Batch payment name FND");

        //HEI.17<<

        //HEI.33>>
        GenLedgerSetup.GET();
        Rec."WHT Amount FND" := 0;
        Rec."WHT Amount (LCY) FND" := 0;
        if GenLedgerSetup."Enable WHT FND" then
            if not Rec."Skip WHT FND" then
                CalcWHTAmount(Rec, Rec."WHT Amount FND", Rec."WHT Amount (LCY) FND");
        //WHT comb
        /*
         IF WHTPostingSetup.GET(Rec."WHT Business Posting Group FND", Rec."WHT Product Posting Group") THEN
           IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN BEGIN
           Rec."WHT Amount FND"         := ROUND(Rec.Amount * WHTPostingSetup."WHT %" / 100);
           Rec."WHT Amount (LCY) FND"   := ROUND(Rec."Amount (LCY)" * WHTPostingSetup."WHT %" / 100);
           end;
       */
        //HEI.33<<

    end;

    [EventSubscriber(ObjectType::Table, 25, 'OnBeforeValidateEvent', 'Applies-to ID', false, false)]
    local procedure T25OnBeforeValidateApplyToID(var Rec: Record "Vendor Ledger Entry"; var xRec: Record "Vendor Ledger Entry"; CurrFieldNo: Integer);
    begin
        //HEI.17>>
        if (Rec."Batch payment name FND" <> '') and (Rec."Applies-to ID" <> '') and (xRec."Applies-to ID" <> Rec."Applies-to ID") then
            ERROR(InvoiceIsProposed, Rec."Document No.", Rec."Batch payment name FND");
        //HEI.17<<
    end;
    //BC Upgrade SHARMP16 begin>>---------------- Interface code 
    // [EventSubscriber(ObjectType::Table, 38, 'OnAfterInsertEvent', '', false, false)]
    // local procedure OnAfterInsertPurchHeader(var Rec: Record "Purchase Header"; RunTrigger: Boolean);
    // var
    //     PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    //     InterfaceEntryHeader: Record "Interface Entry Header";
    //     SRMInterfaceSetup: Record "SRM Interface Setup INT";
    //     InterfaceEntryLine: Record "Interface Entry Line";
    //     ShopCardCrDateTime: Text[30];
    //     ShopCardCrDateOnly: Text[30];
    //     ShopCardCrDateinDateFormat: Date;
    // begin
    //     //HEI.18>>
    //     if not PurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") then begin
    //         PurchaseHeaderAdditional.INIT;
    //         PurchaseHeaderAdditional.VALIDATE("Document Type", Rec."Document Type");
    //         PurchaseHeaderAdditional.VALIDATE("No.", Rec."No.");
    //         //>> HEI.45
    //         SRMInterfaceSetup.GET;
    //         InterfaceEntryHeader.SETRANGE("Source Subtype", Rec."Document Type");
    //         InterfaceEntryHeader.SETRANGE("External Order No.", Rec."No.");
    //         InterfaceEntryHeader.SETRANGE("Interface Code", SRMInterfaceSetup."PO Creation Interface");
    //         if InterfaceEntryHeader.FINDFIRST then begin //HEI.56
    //             PurchaseHeaderAdditional."Shopping Card No." := InterfaceEntryHeader."Severity Code";
    //             ShopCardCrDateTime := FORMAT(InterfaceEntryHeader."Mod/Post Date");
    //             ShopCardCrDateOnly := COPYSTR(ShopCardCrDateTime, 1, 8);//+COPYSTR(ShopCardCrDateTime,6,2)+COPYSTR(ShopCardCrDateTime,1,4);
    //             EVALUATE(ShopCardCrDateinDateFormat, ShopCardCrDateOnly);
    //             PurchaseHeaderAdditional."Shopping Card Creation Date" := ShopCardCrDateinDateFormat;//HEI.74
    //                                                                                                  //>> HEI.56
    //             InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
    //             InterfaceEntryLine.SETFILTER("Direct Cost Per Mult. Limit PO", '<>%1', 0);
    //             if InterfaceEntryLine.FINDFIRST then
    //                 PurchaseHeaderAdditional."Limit PO" := true;
    //         end;
    //         //<< HEI.56
    //         //<< HEI.45
    //         PurchaseHeaderAdditional.INSERT(true);
    //     end;
    //     //HEI.18<<
    // end;
    //BC Upgrade SHARMP16 end<<---------------- Interface code 

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeletePurchHeader(var Rec: Record "Purchase Header"; RunTrigger: Boolean);
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        TransferHeader: Record "Transfer Header";
    begin
        //HEI.18>>
        if PurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") then begin
            //PurchaseHeaderAdditional.DELETE;//HEI.51
            //HEI.51 >>
            if PurchaseHeaderAdditional."Document Type" in [PurchaseHeaderAdditional."Document Type"::"Blanket Order", PurchaseHeaderAdditional."Document Type"::Quote,
              PurchaseHeaderAdditional."Document Type"::"Return Order"] then
                //IF (PurchaseHeaderAdditional."Document Type" <> PurchaseHeaderAdditional."Document Type"::Invoice) OR (PurchaseHeaderAdditional."Document Type" <> PurchaseHeaderAdditional."Document Type"::"Credit Memo")  THEN
                PurchaseHeaderAdditional.DELETE();
            //HEI.51 <<
        end;
        //HEI.18<<
        //HEI.109 >>
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            TransferHeader.SETRANGE("PO Reference FND", Rec."No.");
            if TransferHeader.FINDFIRST() then
                TransferHeader.DELETE(true);
        end;
        //HEI.109 <<
    end;

    [EventSubscriber(ObjectType::Table, 120, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeletePurchRcptHeader(var Rec: Record "Purch. Rcpt. Header"; RunTrigger: Boolean);
    var
        PurchRcptHeaderAdditional: Record "Purch. Rcpt. Header Add FND";
    begin
        //HEI.18>>
        if PurchRcptHeaderAdditional.GET(Rec."No.") then
            PurchRcptHeaderAdditional.DELETE();
        //HEI.18<<
    end;

    [EventSubscriber(ObjectType::Table, 110, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeleteSalesShipHeader(var Rec: Record "Sales Shipment Header"; RunTrigger: Boolean);
    var
        PurchRcptHeaderAdditional: Record "Purch. Rcpt. Header Add FND";
    begin
        //HEI.18>>
        //IF PurchRcptHeaderAdditional.GET(Rec."No.") THEN
        //PurchRcptHeaderAdditional.DELETE;
        //HEI.18<<
    end;

    [EventSubscriber(ObjectType::Table, 122, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeletePurchInvHeader(var Rec: Record "Purch. Inv. Header"; RunTrigger: Boolean);
    var
        PurchInvHeaderAdditional: Record "Purch. Inv. Header Add FND";
    begin
        //HEI.18>>
        if PurchInvHeaderAdditional.GET(Rec."No.") then
            PurchInvHeaderAdditional.DELETE();
        //HEI.18<<
    end;

    [EventSubscriber(ObjectType::Table, 124, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeletePurchCrMemoHeader(var Rec: Record "Purch. Cr. Memo Hdr."; RunTrigger: Boolean);
    var
        PurchCrMemoHdrAddition: Record "Purch. Cr. Memo Hdr. Add FND";
    begin
        //HEI.18>>
        if PurchCrMemoHdrAddition.GET(Rec."No.") then
            PurchCrMemoHdrAddition.DELETE();
        //HEI.18<<
    end;

    // BC Upgrade SHUKLP03 >> Added in the interface ext.
    // [EventSubscriber(ObjectType::Table, 5109, 'OnAfterInsertEvent', '', false, false)]
    // local procedure OnAfterInsertPurchHeaderArchive(var Rec: Record "Purchase Header Archive"; RunTrigger: Boolean);
    // var
    //     PurchaseHeaderArchiveAddit: Record "Purchase Header Arch Addit FND";
    //     PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    // begin
    //     //HEI.18>>
    //     if not PurchaseHeaderArchiveAddit.GET(Rec."Document Type", Rec."No.", Rec."Doc. No. Occurrence", Rec."Version No.") then begin
    //         PurchaseHeaderArchiveAddit.INIT;
    //         PurchaseHeaderArchiveAddit.VALIDATE("Document Type", Rec."Document Type");
    //         PurchaseHeaderArchiveAddit.VALIDATE("No.", Rec."No.");
    //         PurchaseHeaderArchiveAddit.VALIDATE("Doc. No. Occurrence", Rec."Doc. No. Occurrence");
    //         PurchaseHeaderArchiveAddit.VALIDATE("Version No.", Rec."Version No.");
    //         //HEI.71>>
    //         if PurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") then begin //HEI.74 (begin added)
    //             PurchaseHeaderArchiveAddit.VALIDATE("Region Code", PurchaseHeaderAdditional."Region Code");
    //             //HEI.71<<
    //             PurchaseHeaderArchiveAddit.VALIDATE("Shopping Card Creation Date", PurchaseHeaderAdditional."Shopping Card Creation Date");//HEI.74
    //                                                                                                                                        //HEI.123>>
    //             PurchaseHeaderArchiveAddit.VALIDATE("Limit PO", PurchaseHeaderAdditional."Limit PO");
    //             PurchaseHeaderArchiveAddit.VALIDATE("PFI Document No.", PurchaseHeaderAdditional."PFI Document No.");
    //             PurchaseHeaderArchiveAddit.VALIDATE("WMS Export", PurchaseHeaderAdditional."WMS Export");
    //             // PurchaseHeaderArchiveAddit.VALIDATE("Astro WMS PO", PurchaseHeaderAdditional."Astro WMS PO");
    //             //HEI.123>>
    //         end;//HEI.74
    //         PurchaseHeaderArchiveAddit.INSERT(true);
    //     end;
    //     //HEI.18<<
    // end;
    // BC Upgrade SHUKLP03 << Added in the interface ext.

    [EventSubscriber(ObjectType::Table, 5109, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeletePurchHeaderArchive(var Rec: Record "Purchase Header Archive"; RunTrigger: Boolean);
    var
        PurchaseHeaderArchiveAddit: Record "Purchase Header Arch Addit FND";
    begin
        //HEI.18>>
        if PurchaseHeaderArchiveAddit.GET(Rec."Document Type", Rec."No.", Rec."Doc. No. Occurrence", Rec."Version No.") then
            PurchaseHeaderArchiveAddit.DELETE();
        //HEI.18<<
    end;

    [EventSubscriber(ObjectType::Page, 9307, 'OnBeforeActionEvent', 'Send', false, false)]
    local procedure P9307OnBeforeSendOrder(var Rec: Record "Purchase Header");
    begin
        //HEI.19>>
        if (Rec."Document Type" = Rec."Document Type"::Order) then
            if (Rec.Status <> Rec.Status::Released) and (Rec.Status <> Rec.Status::"Pending Prepayment") then
                ERROR(POStatusErr);
        //HEI.19<<
    end;

    [EventSubscriber(ObjectType::Page, 50, 'OnBeforeActionEvent', 'SendCustom', false, false)]
    local procedure P50OnBeforeSendOrder(var Rec: Record "Purchase Header");
    begin
        //HEI.19>>
        if (Rec."Document Type" = Rec."Document Type"::Order) then
            if (Rec.Status <> Rec.Status::Released) and (Rec.Status <> Rec.Status::"Pending Prepayment") then
                ERROR(POStatusErr);
        //HEI.19<<
    end;

    [EventSubscriber(ObjectType::Page, 49, 'OnBeforeActionEvent', 'SendApprovalRequest', false, false)]
    local procedure P49OnBeforeSendApprovalRequest(var Rec: Record "Purchase Header");
    var
        HeinekenGlobal: Codeunit "Heineken Global";
    begin
        //HEI.21>>
        HeinekenGlobal.CheckCCCDimenssion(Rec);
        //HEI.21<<
    end;

    [EventSubscriber(ObjectType::Page, 49, 'OnBeforeActionEvent', 'Release', false, false)]
    local procedure P49OnBeforeRelease(var Rec: Record "Purchase Header");
    var
        HeinekenGlobal: Codeunit "Heineken Global";
    begin
        //HEI.21>>
        HeinekenGlobal.CheckCCCDimenssion(Rec);
        //HEI.21<<
    end;

    [EventSubscriber(ObjectType::Page, 6640, 'OnBeforeActionEvent', 'SendApprovalRequest', false, false)]
    local procedure P6640OnBeforeSendApprovalRequest(var Rec: Record "Purchase Header");
    var
        HeinekenGlobal: Codeunit "Heineken Global";
    begin
        //HEI.21>>
        HeinekenGlobal.CheckCCCDimenssion(Rec);
        //HEI.21<<
    end;

    [EventSubscriber(ObjectType::Page, 6640, 'OnBeforeActionEvent', "Re&lease", false, false)]
    local procedure P6640OnBeforeRelease(var Rec: Record "Purchase Header");
    var
        HeinekenGlobal: Codeunit "Heineken Global";
    begin
        //HEI.21>>
        HeinekenGlobal.CheckCCCDimenssion(Rec);
        //HEI.21<<
    end;

    [EventSubscriber(ObjectType::Page, 9306, 'OnBeforeActionEvent', 'SendApprovalRequest', false, false)]
    local procedure P9306OnBeforeSendApprovalRequest(var Rec: Record "Purchase Header");
    var
        HeinekenGlobal: Codeunit "Heineken Global";
    begin
        //HEI.21>>
        HeinekenGlobal.CheckCCCDimenssion(Rec);
        //HEI.21<<
    end;

    [EventSubscriber(ObjectType::Page, 9306, 'OnBeforeActionEvent', 'Release', false, false)]
    local procedure P9306OnBeforeRelease(var Rec: Record "Purchase Header");
    var
        HeinekenGlobal: Codeunit "Heineken Global";
    begin
        //HEI.21>>
        HeinekenGlobal.CheckCCCDimenssion(Rec);
        //HEI.21<<
    end;

    [EventSubscriber(ObjectType::Page, 9311, 'OnBeforeActionEvent', 'SendApprovalRequest', false, false)]
    local procedure P9311OnBeforeSendApprovalRequest(var Rec: Record "Purchase Header");
    var
        HeinekenGlobal: Codeunit "Heineken Global";
    begin
        //HEI.21>>
        HeinekenGlobal.CheckCCCDimenssion(Rec);
        //HEI.21<<
    end;

    [EventSubscriber(ObjectType::Page, 9311, 'OnBeforeActionEvent', 'Release', false, false)]
    local procedure P9311OnBeforeRelease(var Rec: Record "Purchase Header");
    var
        HeinekenGlobal: Codeunit "Heineken Global";
    begin
        //HEI.21>>
        HeinekenGlobal.CheckCCCDimenssion(Rec);
        //HEI.21<<
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesReturnOrder(var SalesHeader: Record "Sales Header");
    var
        SalesSetup: Record "Sales & Receivables Setup";
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        //HEI.22>>
        SalesSetup.GET();
        if SalesSetup."Enable AutoAppSalesCr Memo FND" then
            // if (SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order") and
            //    (SalesHeader."Link Sales Document No." <> '') and SalesHeader.Invoice
            // then begin// BC upgrade SHARMP16 --Link Sales Document No. Drink-IT field.
            //  SalesInvoiceHeader.SETRANGE("Order No.", SalesHeader."Link Sales Document No.");// BC upgrade SHARMP16 --Link Sales Document No. Drink-IT field.
            if SalesInvoiceHeader.FINDFIRST() then begin
                SalesHeader."Applies-to Doc. Type" := SalesHeader."Applies-to Doc. Type"::Invoice;
                SalesHeader."Applies-to Doc. No." := SalesInvoiceHeader."No.";
            end else
                ERROR(SalesReturnOrderPostErr);
        //  end;
        //HEI.22<<
    end;
    //BC Upgrade SHARMP16 begin<<--- 50045 codeunit will compile later Interface code.
    // [EventSubscriber(ObjectType::Codeunit, 50045, 'OnAfterInitPurchLine', '', false, false)]
    // local procedure C50045OnAfterInitPurchLine(var PurchBlanketOrderLine: Record "Purchase Line"; var PurchOrderLine: Record "Purchase Line");
    // begin
    //     //HEI.24>>
    //     if PurchBlanketOrderLine."Document Type" <> PurchBlanketOrderLine."Document Type"::"Blanket Order" then
    //         exit;

    //     if PurchBlanketOrderLine."SRM Contract No. FND" = '' then
    //         exit;

    //     PurchBlanketOrderLine.TESTFIELD("Consumption Location Code FND");
    //     PurchOrderLine."Location Code" := PurchBlanketOrderLine."Consumption Location Code FND";
    //     PurchOrderLine."Initial Quantity FND" := PurchBlanketOrderLine."Qty. to Receive";
    //     //HEI.24<<
    // end;
    //BC Upgrade SHARMP16 end>>--- 50045 codeunit will compile later Interface code.

    [EventSubscriber(ObjectType::Table, 39, 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnInsertPurchLine(var Rec: Record "Purchase Line"; RunTrigger: Boolean);
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        //>> HEI.27
        if (Rec."Document Type" <> Rec."Document Type"::Order) or not RunTrigger then
            exit;
        PurchaseHeader.GET(Rec."Document Type", Rec."Document No.");
        if (PurchaseHeader."Blanket Order No. FND" <> '') and (PurchaseHeader."SRM Contract No. FND" <> '') and (PurchaseHeader."Channel FND" = 'A')
           //>>HEI.38
           and (Rec.Type <> Rec.Type::" ") then
            //<<HEI.38
            ERROR(InsertPOLineSRM);
        //<< HEI.27
    end;

    local procedure CheckDistanceOnPurchDocFromDocShippingCosts(var PurchaseHeader: Record "Purchase Header"): Boolean;
    var
    // DocumentShippingCost: Record "Document Shipping Cost";// BC Upgrade SHARMP16-- DRINK-IT table used begin<<
    begin
        //>> HEI.26 FDD-HT658 IBM.GUNERE01 18.09.2019
        // DocumentShippingCost.RESET;
        // DocumentShippingCost.SETRANGE("Source Type", DATABASE::"Purchase Header");
        // DocumentShippingCost.SETRANGE("Source No.", PurchaseHeader."No.");
        // DocumentShippingCost.SETRANGE("Sub Type", PurchaseHeader."Document Type");
        // DocumentShippingCost.SETRANGE("Cost By Distance", true);
        // if DocumentShippingCost.FINDFIRST then
        //     if PurchaseHeader.Distance = 0 then
        //         exit(false)
        //     else
        //         exit(true)
        // else
        //     exit(true);

        //<< HEI.26 FDD-HT658 IBM.GUNERE01 18.09.2019
        // DocumentShippingCost: Record "Document Shipping Cost";// BC Upgrade SHARMP16-- DRINK-IT table used end>>
    end;

    local procedure CheckMandatoryFieldsForRoute(var PurchaseHeader: Record "Purchase Header");
    var
        //  locRoute: Record Route;    // DocumentShippingCost: Record "Document Shipping Cost";// BC Upgrade SHARMP16-- DRINK-IT table used begin<<
        ErrorText01: Label 'Distance cannot be zero if Document Shipping Cost is Cost By Distance!';
    begin
        //>> HEI.26 FDD-HT658 IBM.GUNERE01 18.09.2019
        if not CheckDistanceOnPurchDocFromDocShippingCosts(PurchaseHeader) then
            ERROR(ErrorText01);
        //<< HEI.26 FDD-HT658 IBM.GUNERE01 18.09.2019
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Type', false, false)]
    local procedure T39OnAfterValidateType(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine2: Record "Purchase Line";
    begin
        //HEI.29>>
        PurchSetup.GET();
        if PurchSetup."Enable FA Vendor Req. FND" then
            if Rec.Type = Rec.Type::"Fixed Asset" then begin
                PurchaseHeader.GET(Rec."Document Type", Rec."Document No.");
                PurchaseHeader."Fixed Asset Acquisition FND" := true;
                PurchaseHeader.MODIFY();
            end else
                if (xRec.Type = xRec.Type::"Fixed Asset") and (Rec.Type <> Rec.Type::"Fixed Asset") then begin
                    PurchaseHeader.GET(Rec."Document Type", Rec."Document No.");
                    if PurchaseHeader."Fixed Asset Acquisition FND" then begin
                        PurchaseLine2.SETRANGE("Document Type", Rec."Document Type");
                        PurchaseLine2.SETRANGE("Document No.", Rec."Document No.");
                        PurchaseLine2.SETRANGE(Type, PurchaseLine2.Type::"Fixed Asset");
                        PurchaseLine2.SETFILTER("Line No.", '<>%1', Rec."Line No.");
                        if not PurchaseLine2.FINDFIRST() then begin
                            PurchaseHeader."Fixed Asset Acquisition FND" := false;
                            PurchaseHeader.MODIFY();
                        end;
                    end;
                end;
        //HEI.29<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure T39OnAfterValidateFANo(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine2: Record "Purchase Line";
    begin
        //HEI.29>>
        PurchSetup.GET();
        if PurchSetup."Enable FA Vendor Req. FND" then
            if Rec.Type = Rec.Type::"Fixed Asset" then begin
                PurchaseHeader.GET(Rec."Document Type", Rec."Document No.");
                if not PurchaseHeader."Fixed Asset Acquisition FND" then begin
                    PurchaseHeader."Fixed Asset Acquisition FND" := true;
                    PurchaseHeader.MODIFY();
                end;
            end else
                if Rec.Type = Rec.Type::Item then
                    PurchaseHeader.GET(Rec."Document Type", Rec."Document No.");
        if not PurchaseHeader."Fixed Asset Acquisition FND" then begin
            if IsRPMItem(Rec) then begin //HEI.72
                PurchaseHeader."Fixed Asset Acquisition FND" := true;
                PurchaseHeader.MODIFY();
            end; //HEI.72
        end;
        //HEI.29<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterDeleteEvent', '', false, false)]
    local procedure T39OnDeleteFALine(var Rec: Record "Purchase Line"; RunTrigger: Boolean);
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
    begin
        //HEI.29>>
        PurchSetup.GET();
        if PurchSetup."Enable FA Vendor Req. FND" then
            //>> HEI.72
            //  IF Rec.Type = Rec.Type::"Fixed Asset" THEN BEGIN
            //    PurchaseLine.SETRANGE("Document Type",Rec."Document Type");
            //    PurchaseLine.SETRANGE("Document No.",Rec."Document No.");
            //    PurchaseLine.SETRANGE(Type,PurchaseLine.Type::"Fixed Asset");
            //    IF NOT PurchaseLine.FINDFIRST THEN
            //<< HEI.72
            if not CheckIfPurchaseLinesValidForFAAcquisition(Rec) then begin // HEI.72
                if PurchaseHeader.GET(Rec."Document Type", Rec."Document No.") then begin
                    PurchaseHeader."Fixed Asset Acquisition FND" := false;
                    PurchaseHeader.MODIFY();
                end;
            end;
        //HEI.29<<
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure C90OnBeforePost(var PurchaseHeader: Record "Purchase Header");
    var
        PurchaseLine: Record "Purchase Line";
    begin
        //HEI.29>>
        PurchSetup.GET();
        if PurchSetup."Enable FA Vendor Req. FND" then
            if PurchaseHeader."Fixed Asset Acquisition FND" then begin
                PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                PurchaseLine.SETFILTER(Type, '<>%1', PurchaseLine.Type::"Fixed Asset");
                if PurchaseLine.FINDFIRST() and (PurchaseLine.Type <> PurchaseLine.Type::" ") then
                    if not IsRPMItem(PurchaseLine) then //HEI.72
                        ERROR(FATypeError, PurchaseLine."Line No.");
            end;
        //HEI.29<<
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSendPurchaseDocForApproval', '', false, false)]
    local procedure OnSendPurchaseDocumentForApproval(var PurchaseHeader: Record "Purchase Header");
    var
        PurchaseLine: Record "Purchase Line";
    begin
        //HEI.29>>
        PurchSetup.GET();
        if PurchSetup."Enable FA Vendor Req. FND" then
            if PurchaseHeader."Fixed Asset Acquisition FND" then begin
                PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                PurchaseLine.SETFILTER(Type, '<>%1', PurchaseLine.Type::"Fixed Asset");
                if PurchaseLine.FINDFIRST() and (PurchaseLine.Type <> PurchaseLine.Type::" ") then
                    if not IsRPMItem(PurchaseLine) then //HEI.72
                        ERROR(FATypeError, PurchaseLine."Line No.");
            end;
        //HEI.29<<

        if PurchaseHeader."Document Type" in [PurchaseHeader."Document Type"::Quote, PurchaseHeader."Document Type"::Order] then //HEI.118
            CheckVendorSPL(PurchaseHeader); //HEI.117
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnBeforeValidateEvent', 'Tolerance Received Over % FND', false, false)]
    local procedure T39OnBeforeValidateToleranceRecOver(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        PurchaseHeader: Record "Purchase Header";
        UserSetup: Record "User Setup";
        Text001: Label 'User %1 has no permissions to edit this field "Tolerance Received Over % FND"';
        Text002: Label 'Tol. Received Over field is only editable for Items!';
        Text003: Label 'Tol. Received Over is not editable for the lines connected to Blanket Order No.!';
    begin
        //>> HEI.32
        if Rec.ISTEMPORARY then
            exit;

        if PurchaseHeader.GET(Rec."Document Type", Rec."Document No.") then
            if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Blanket Order" then
                exit;

        if Rec.Type <> Rec.Type::Item then
            exit;
        //HEI.87>>
        /*
        IF Rec."Blanket Order No." <> '' THEN
          IF Rec."Tolerance Received Over % FND" <> 0 THEN // HEI.36
            ERROR(Text003);
        */
        //HEI.87<<
        if Rec."Tolerance Received Over % FND" <> xRec."Tolerance Received Over % FND" then begin
            if UserSetup.GET(USERID) then
                if UserSetup."Edit PO Tol. Received Over FND" = true then
                    exit
                else
                    ERROR(Text001, USERID);
        end else
            exit;
        //<< HEI.32

    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterValidateEvent', 'Amount', false, false)]
    local procedure T81OnAfterValidateAmount(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; CurrFieldNo: Integer);
    var
        GenLedgerSetup: Record "General Ledger Setup";
        WHTPostingSetup: Record "WHT Posting Setup FND";
    begin
        //HEI.33>>
        Rec."WHT Amount FND" := 0;
        Rec."WHT Amount (LCY) FND" := 0;
        GenLedgerSetup.GET();
        if GenLedgerSetup."Enable WHT FND" then
            if not Rec."Skip WHT FND" then begin
                if (Rec."Applies-to ID" = '') and (Rec."Applies-to Doc. No." = '') then begin
                    if WHTPostingSetup.GET(Rec."WHT Business Posting Group FND", Rec."WHT Product Posting Group FND") then
                        if WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment then begin
                            Rec."WHT Amount FND" := ROUND(Rec.Amount * WHTPostingSetup."WHT %" / 100);
                            Rec."WHT Amount (LCY) FND" := ROUND(Rec."Amount (LCY)" * WHTPostingSetup."WHT %" / 100);
                        end;
                end;
            end;

        //WHT comb
        /*
        IF Rec.Amount <> xRec.Amount THEN
          IF WHTPostingSetup.GET(Rec."WHT Business Posting Group FND", Rec."WHT Product Posting Group") THEN
            IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN BEGIN
            Rec."WHT Amount FND"        := ROUND(Rec.Amount * WHTPostingSetup."WHT %" / 100);
            Rec."WHT Amount (LCY) FND"  := ROUND(Rec."Amount (LCY)" * WHTPostingSetup."WHT %" / 100);
            end;
            */
        //IF Rec.MODIFY THEN;
        //HEI.33<<

    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterValidateEvent', 'Amount (LCY)', false, false)]
    local procedure T81OnAfterValidateAmountLCY(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; CurrFieldNo: Integer);
    var
        GenLedgerSetup: Record "General Ledger Setup";
        WHTPostingSetup: Record "WHT Posting Setup FND";
    begin

        //HEI.33>>
        Rec."WHT Amount FND" := 0;
        Rec."WHT Amount (LCY) FND" := 0;
        GenLedgerSetup.GET();
        if GenLedgerSetup."Enable WHT FND" then
            if not Rec."Skip WHT FND" then begin
                if (Rec."Applies-to ID" = '') and (Rec."Applies-to Doc. No." = '') then begin
                    if WHTPostingSetup.GET(Rec."WHT Business Posting Group FND", Rec."WHT Product Posting Group FND") then
                        if WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment then begin
                            Rec."WHT Amount FND" := ROUND(Rec.Amount * WHTPostingSetup."WHT %" / 100);
                            Rec."WHT Amount (LCY) FND" := ROUND(Rec."Amount (LCY)" * WHTPostingSetup."WHT %" / 100);
                        end;
                end;
            end;
        //WHT comb
        /*
          IF Rec."Amount (LCY)" <> xRec."Amount (LCY)" THEN
            IF WHTPostingSetup.GET(Rec."WHT Business Posting Group FND", Rec."WHT Product Posting Group") THEN
              IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN BEGIN
              Rec."WHT Amount FND"        := ROUND(Rec.Amount * WHTPostingSetup."WHT %" / 100);
              Rec."WHT Amount (LCY) FND"  := ROUND(Rec."Amount (LCY)" * WHTPostingSetup."WHT %" / 100);
             end;
             */
        //IF Rec.MODIFY THEN;
        //HEI.33<<

    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterValidateEvent', 'WHT Business Posting Group FND', false, false)]
    local procedure T81OnAfterValidateWHTBusPostGroup(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; CurrFieldNo: Integer);
    var
        GenLedgerSetup: Record "General Ledger Setup";
        WHTPostingSetup: Record "WHT Posting Setup FND";
    begin
        //HEI.33>>
        Rec."WHT Amount FND" := 0;
        Rec."WHT Amount (LCY) FND" := 0;
        GenLedgerSetup.GET();
        if GenLedgerSetup."Enable WHT FND" then
            if not Rec."Skip WHT FND" then
                CalcWHTAmount(Rec, Rec."WHT Amount FND", Rec."WHT Amount (LCY) FND");
        //WHT comb
        /*
          IF Rec."WHT Business Posting Group FND" <> xRec."WHT Business Posting Group FND" THEN
            IF WHTPostingSetup.GET(Rec."WHT Business Posting Group FND", Rec."WHT Product Posting Group") THEN
              IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN BEGIN
              Rec."WHT Amount FND"        := ROUND(Rec.Amount * WHTPostingSetup."WHT %" / 100);
              Rec."WHT Amount (LCY) FND"  := ROUND(Rec."Amount (LCY)" * WHTPostingSetup."WHT %" / 100);
            end;
        */
        //IF Rec.MODIFY THEN;

        //HEI.33<<

    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterValidateEvent', 'WHT Product Posting Group FND', false, false)]
    local procedure T81OnAfterValidateWHTProdPostGroup(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; CurrFieldNo: Integer);
    var
        GenLedgerSetup: Record "General Ledger Setup";
        WHTPostingSetup: Record "WHT Posting Setup FND";
    begin
        //HEI.33>>
        Rec."WHT Amount FND" := 0;
        Rec."WHT Amount (LCY) FND" := 0;
        GenLedgerSetup.GET();
        if GenLedgerSetup."Enable WHT FND" then
            if not Rec."Skip WHT FND" then
                CalcWHTAmount(Rec, Rec."WHT Amount FND", Rec."WHT Amount (LCY) FND");
        //WHT comb
        /*
          IF Rec."WHT Product Posting Group" <> xRec."WHT Product Posting Group" THEN
            IF WHTPostingSetup.GET(Rec."WHT Business Posting Group FND", Rec."WHT Product Posting Group") THEN
              IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN BEGIN
             Rec."WHT Amount FND"         := ROUND(Rec.Amount * WHTPostingSetup."WHT %" / 100);
             Rec."WHT Amount (LCY) FND"   := ROUND(Rec."Amount (LCY)" * WHTPostingSetup."WHT %" / 100);
            end;
        */
        //IF Rec.MODIFY THEN;

        //HEI.33<<

    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnBeforeInsertEvent', '', false, false)]
    local procedure T81OnBeforeInsertRec(var Rec: Record "Gen. Journal Line"; RunTrigger: Boolean);
    var
        GenLedgerSetup: Record "General Ledger Setup";
        WHTPostingSetup: Record "WHT Posting Setup FND";
    begin
        //HEI.33>>
        Rec."WHT Amount FND" := 0;
        Rec."WHT Amount (LCY) FND" := 0;
        GenLedgerSetup.GET();
        if GenLedgerSetup."Enable WHT FND" then
            if not Rec."Skip WHT FND" then
                CalcWHTAmount(Rec, Rec."WHT Amount FND", Rec."WHT Amount (LCY) FND");
        //WHT comb
        /*
          IF WHTPostingSetup.GET(Rec."WHT Business Posting Group FND", Rec."WHT Product Posting Group") THEN
            IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN BEGIN
            Rec."WHT Amount FND"         := ROUND(Rec.Amount * WHTPostingSetup."WHT %" / 100);
            Rec."WHT Amount (LCY) FND"   := ROUND(Rec."Amount (LCY)" * WHTPostingSetup."WHT %" / 100);
        
          end;
        */
        //HEI.33<<

    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterValidateEvent', 'Applies-to Doc. No.', false, false)]
    local procedure T81OnAfterValidateApplyToDoc(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; CurrFieldNo: Integer);
    var
        GenLedgerSetup: Record "General Ledger Setup";
        WHTEntry: Record "WHT Entry FND";
        WHTPostingSetup: Record "WHT Posting Setup FND";
    begin
        //HEI.33>>
        Rec.VALIDATE(Rec."WHT Business Posting Group FND", '');
        Rec.VALIDATE(Rec."WHT Product Posting Group FND", '');
        GenLedgerSetup.GET();
        if GenLedgerSetup."Enable WHT FND" then
            if Rec."Document Type" = Rec."Document Type"::Payment then begin
                WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::Invoice);
                WHTEntry.SETRANGE("Document No.", Rec."Applies-to Doc. No.");
                if WHTEntry.FINDFIRST() then begin
                    if WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group") then
                        //IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN BEGIN
                        Rec.VALIDATE(Rec."WHT Business Posting Group FND", WHTEntry."WHT Bus. Posting Group");
                    Rec.VALIDATE(Rec."WHT Product Posting Group FND", WHTEntry."WHT Prod. Posting Group");
                    //end;
                end;
            end;
        //HEI.33<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterInsertEvent', '', false, false)]
    local procedure T39OnInsertLine(var Rec: Record "Purchase Line"; RunTrigger: Boolean);
    var
        PurchaseLine: Record "Purchase Line";
        FAError: Label '%1 cannot be inserted with Fixed Asset.';
    begin
        //<<HEI.61
        if Rec.ISTEMPORARY then
            exit;
        //>>HEI.61

        //HEI.35>>
        PurchSetup.GET();
        if PurchSetup."Enable FA Vendor Req. FND" then begin
            PurchaseLine.RESET();
            PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
            PurchaseLine.SETRANGE("Document No.", Rec."Document No.");
            PurchaseLine.SETFILTER("Line No.", '<>%1', Rec."Line No.");
            PurchaseLine.SETFILTER(Type, '<>%1', PurchaseLine.Type::" ");
            if PurchaseLine.findset() then
                repeat
                    if Rec.Type <> Rec.Type::" " then begin
                        //HEI.87>>
                        //IF Rec.Type = Rec.Type::"Fixed Asset" THEN//HEI.87
                        if (Rec."Document Type" <> Rec."Document Type"::"Blanket Order") and (Rec.Type = Rec.Type::"Fixed Asset") then
                            //HEI.87<<
                            if PurchaseLine.Type <> PurchaseLine.Type::"Fixed Asset" then
                                if not IsRPMItem(PurchaseLine) then //HEI.72
                                    ERROR(FAError, PurchaseLine.Type);
                        if Rec.Type <> Rec.Type::"Fixed Asset" then
                            //>> HEI.72
                            CheckRPMItemOnLine(Rec)
                        //          IF PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset" THEN
                        //ERROR(FAError,Rec.Type);
                        //<< HEI.72
                    end;
                until PurchaseLine.NEXT() = 0;
        end;
        //HEI.35<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Type', false, false)]
    local procedure T39OnTypeValidate(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        PurchaseLine: Record "Purchase Line";
        FAError: Label '%1 cannot be inserted with Fixed Asset.';
    begin
        //HEI.35>>
        PurchSetup.GET();
        if PurchSetup."Enable FA Vendor Req. FND" then begin
            PurchaseLine.RESET();
            PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
            PurchaseLine.SETRANGE("Document No.", Rec."Document No.");
            if PurchaseLine.FINDFIRST() then begin
                if (Rec.Type <> Rec.Type::"Fixed Asset") and (xRec.Type = xRec.Type::"Fixed Asset") then
                    if Rec."Line No." <> PurchaseLine."Line No." then;
                // ERROR(FAError,Rec.Type); //HEI.72
            end;
        end;
        //HEI.35<<
    end;

    local procedure CalcWHTAmount(GenJnlLine: Record "Gen. Journal Line"; var WHTAmount: Decimal; var WHTAmountLCY: Decimal);
    var
        CurrExchRate: Record "Currency Exchange Rate";
        GenJnlLine1: Record "Gen. Journal Line";
        GLSetup: Record "General Ledger Setup";
        VendLedgEntry: Record "Vendor Ledger Entry";
        WHTEntry: Record "WHT Entry FND";
        WHTPostingSetup: Record "WHT Posting Setup FND";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        CalcAppliedWHTAmount: Codeunit WHTManagement;
        WHTManagement: Codeunit WHTManagement;
        AmountToApply: Decimal;
        CurrFactor: Decimal;
        TotalUnrealAmount: Decimal;
        TotalUnrealBase: Decimal;
        TotalUnrealBaseAtPaym: Decimal;
    begin
        //HEI.33>>

        //for Apply-to Doc application
        if GenJnlLine."Applies-to Doc. No." <> '' then begin
            GenJnlLine1.RESET();
            GenJnlLine1.COPY(GenJnlLine);
            if GenJnlLine."Applies-to Doc. No." <> '' then
                GenJnlLine1.SETRANGE("Applies-to Doc. No.", GenJnlLine."Applies-to Doc. No.")
            else
                GenJnlLine1.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");

            GenJnlLine1.SETRANGE("Account Type", GenJnlLine."Account Type"::Vendor);
            if (GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor) or
               (GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Vendor) or
               GenJnlLine1.FINDFIRST()
            then begin
                CurrFactor :=
                  CurrExchRate.ExchangeRate(
                    GenJnlLine."Document Date", GenJnlLine."Currency Code");

                GenJnlLine1.VALIDATE(Amount, GenJnlLine1.Amount);//WHTWORK

                if (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Payment) or
                   (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Refund)
                then
                    if WHTPostingSetup.GET(GenJnlLine."WHT Business Posting Group FND", GenJnlLine."WHT Product Posting Group FND")
                    then begin
                        if WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest then begin
                            if GenJnlLine1.FINDFIRST() then
                                WHTManagement.CheckApplicationGenPurchWHT(GenJnlLine1);
                            WHTAmount := ABS(WHTManagement.CalcVendExtraWHTForEarliest(GenJnlLine1));
                            WHTAmountLCY :=
                              CurrExchRate.ExchangeAmtFCYToLCY(
                                GenJnlLine."Document Date", GenJnlLine."Currency Code", WHTAmount, CurrFactor);
                        end;

                        if (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment) and
                           (not GLSetup."Manual Sales WHT Calc. FND")
                        then begin
                            WHTAmount := ABS(WHTManagement.WHTAmountJournal(GenJnlLine1, true));
                            WHTAmountLCY :=
                              CurrExchRate.ExchangeAmtFCYToLCY(
                                GenJnlLine."Document Date", GenJnlLine."Currency Code", WHTAmount, CurrFactor);

                        end;
                    end;

            end;

        end;

        //for Applies-to ID application
        if GenJnlLine."Applies-to ID" <> '' then begin

            GenJnlLine1.RESET();
            GenJnlLine1.COPY(GenJnlLine);
            if GenJnlLine."Applies-to Doc. No." <> '' then
                GenJnlLine1.SETRANGE("Applies-to Doc. No.", GenJnlLine."Applies-to Doc. No.")
            else
                GenJnlLine1.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");

            GenJnlLine1.SETRANGE("Account Type", GenJnlLine."Account Type"::Vendor);
            if (GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor) or
               (GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Vendor) or
               GenJnlLine1.FINDFIRST()
            then begin
                CurrFactor :=
                  CurrExchRate.ExchangeRate(
                    GenJnlLine."Document Date", GenJnlLine."Currency Code");

                GenJnlLine1.VALIDATE(Amount, GenJnlLine1.Amount);//WHTWORK

                if (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Payment) or
                   (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Refund)
                then
                    if WHTPostingSetup.GET(GenJnlLine."WHT Business Posting Group FND", GenJnlLine."WHT Product Posting Group FND")
                    then begin
                        if WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest then begin
                            if GenJnlLine1.FINDFIRST() then
                                WHTManagement.CheckApplicationGenPurchWHT(GenJnlLine1);
                            WHTAmount := ABS(WHTManagement.CalcVendExtraWHTForEarliest(GenJnlLine1));
                            WHTAmountLCY :=
                              CurrExchRate.ExchangeAmtFCYToLCY(
                                GenJnlLine."Document Date", GenJnlLine."Currency Code", WHTAmount, CurrFactor);
                        end;

                        if (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment) and
                           (not GLSetup."Manual Sales WHT Calc. FND")
                        then begin
                            WHTAmount := ABS(WHTManagement.WHTAmountJournal(GenJnlLine1, true));
                            WHTAmountLCY :=
                              CurrExchRate.ExchangeAmtFCYToLCY(
                                GenJnlLine."Document Date", GenJnlLine."Currency Code", WHTAmount, CurrFactor);

                        end;
                    end;

            end;


        end;

        //for no Apply-to Doc or Applies-to ID
        if (GenJnlLine."Applies-to ID" = '') and (GenJnlLine."Applies-to Doc. No." = '') then begin
            if WHTPostingSetup.GET(GenJnlLine."WHT Business Posting Group FND", GenJnlLine."WHT Product Posting Group FND") then
                if WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment then begin
                    WHTAmount := ROUND(GenJnlLine.Amount * WHTPostingSetup."WHT %" / 100);
                    WHTAmountLCY := ROUND(GenJnlLine."Amount (LCY)" * WHTPostingSetup."WHT %" / 100);
                end;
        end;
        //HEI.33<<
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Buy-from Vendor No.', false, false)]
    procedure T38OnAfterValidateVendorNo(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    var
        PurchaseHeaderAddRec: Record "Purchase Header Additional FND";
        PurchPayableSetupRec: Record "Purchases & Payables Setup";
        VendorRec: Record Vendor;
    begin
        //HEI.34>>

        if Rec."Buy-from Vendor No." <> '' then begin
            VendorRec.RESET();
            if VendorRec.GET(Rec."Buy-from Vendor No.") then begin
                PurchaseHeaderAddRec.RESET();
                if PurchaseHeaderAddRec.GET(Rec."Document Type", Rec."No.") then begin
                    PurchaseHeaderAddRec."House Number" := VendorRec."House Number FND";
                    PurchaseHeaderAddRec.MODIFY();
                end;
            end;
        end;
        //HEI.34<<

        //HEI.108>>
        PurchPayableSetupRec.GET();
        //BC Upgrade SHUKLP03 begin>> ---Document Subtype Code

        if ((Rec."Document Type" in [Rec."Document Type"::"Credit Memo"]) and (Rec."Document Subtype Code FND" in [PurchPayableSetupRec."PO Subtype Code FND", PurchPayableSetupRec."NPO Subtype Code FND", PurchPayableSetupRec."Expense ClaimCMSubdoc Type FND"]) and (Rec."Buy-from Vendor No." <> '')) then begin
            if VendorRec.GET(Rec."Buy-from Vendor No.") then begin
                Rec.VALIDATE(Rec."Payment Method Code", VendorRec."Payment Method Code");
            end;
        end;
        //BC Upgrade SHUKLP03 end<< ---Document Subtype Codet
        //HEI.108<<
    end;

    [EventSubscriber(ObjectType::Table, 122, 'OnAfterInsertEvent', '', false, false)]
    procedure T122OnAfterInsertPurchInvHdr(var Rec: Record "Purch. Inv. Header"; RunTrigger: Boolean);
    var
        PurchRcpHdrRec: Record "Purch. Rcpt. Header";
        VendorRec: Record Vendor;
    begin
        //HEI.34>>
        if Rec."Buy-from Vendor No." <> '' then begin
            VendorRec.RESET();
            if VendorRec.GET(Rec."Buy-from Vendor No.") then begin
                PurchRcpHdrRec.RESET();
                if PurchRcpHdrRec.GET(Rec."No.") then begin
                    PurchRcpHdrRec."House Number FND" := VendorRec."House Number FND";
                    PurchRcpHdrRec.MODIFY();
                end;
            end;
        end;
        //HEI.34<<
    end;

    [EventSubscriber(ObjectType::Table, 124, 'OnAfterInsertEvent', '', false, false)]
    procedure T124OnAfterInsertPurchCrMemoHdr(var Rec: Record "Purch. Cr. Memo Hdr."; RunTrigger: Boolean);
    var
        PurchRcpHdrRec: Record "Purch. Rcpt. Header";
        VendorRec: Record Vendor;
    begin
        //HEI.34>>
        if Rec."Buy-from Vendor No." <> '' then begin
            VendorRec.RESET();
            if VendorRec.GET(Rec."Buy-from Vendor No.") then begin
                PurchRcpHdrRec.RESET();
                if PurchRcpHdrRec.GET(Rec."No.") then begin
                    PurchRcpHdrRec."House Number FND" := VendorRec."House Number FND";
                    PurchRcpHdrRec.MODIFY();
                end;
            end;
        end;
        //HEI.34<<
    end;

    // BC Upgrade SHUKLP03 >> Added in the interface ext.
    // [EventSubscriber(ObjectType::Table, 50140, 'OnAfterValidateEvent', 'Maximo Status', false, false)]
    // procedure T50140OnAfterValidateMaximoStatus(var Rec: Record "Purchase Header Additional FND"; var xRec: Record "Purchase Header Additional FND"; CurrFieldNo: Integer);
    // var
    //     ArchiveManagement: Codeunit ArchiveManagement;
    //     PurchaseHdrRec: Record "Purchase Header";

    //     BCUpgrade: Codeunit "Heineken BC Upgrade";
    //     BCCustomFunctions: Codeunit "Heineken BC Custom Functions";
    // begin
    //     // HEI.37 >>
    //     if Rec."Maximo Status" = Rec."Maximo Status"::Canceled then begin
    //         if Rec."Document Type" = Rec."Document Type"::Quote then begin
    //             PurchaseHdrRec.RESET;
    //             PurchaseHdrRec.SETRANGE("Document Type", Rec."Document Type");
    //             PurchaseHdrRec.SETRANGE("No.", Rec."No.");
    //             if PurchaseHdrRec.FINDFIRST then begin
    //                 if PurchaseHdrRec.Status = PurchaseHdrRec.Status::Released then
    //                     BCCustomFunctions.ArchivePurchDocumentOnReopen(PurchaseHdrRec);//BC Upgrade SHARMP16
    //                 ArchiveManagement.AutoArchivePurchDocument(PurchaseHdrRec);
    //                 PurchaseHdrRec.DELETE;
    //             end;
    //         end;
    //     end;
    //     // HEI.37 <<
    // end;
    // BC Upgrade SHUKLP03 << Added in the interface ext.

    [EventSubscriber(ObjectType::Table, 50077, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure T50077OnBeforeDeleteWHTPostingSetup(var Rec: Record "WHT Posting Setup FND"; RunTrigger: Boolean);
    var
        GenLedgerSetup: Record "General Ledger Setup";
        VendLedgEntry: Record "Vendor Ledger Entry";
        WhtEntry: Record "WHT Entry FND";
    begin
        //HEI.33>>
        GenLedgerSetup.GET();
        if GenLedgerSetup."Enable WHT FND" then begin
            WhtEntry.RESET();
            WhtEntry.SETCURRENTKEY("Document Type", "Transaction Type", Settled, "WHT Bus. Posting Group", "WHT Prod. Posting Group", "Posting Date");
            WhtEntry.SETRANGE("WHT Bus. Posting Group", Rec."WHT Business Posting Group");
            WhtEntry.SETRANGE("WHT Prod. Posting Group", Rec."WHT Product Posting Group");

            VendLedgEntry.SETCURRENTKEY(Open, "On Hold");
            VendLedgEntry.SETRANGE(Open, true);
            VendLedgEntry.SETRANGE("On Hold", '');
            if VendLedgEntry.findset() then
                repeat
                    WhtEntry.SETRANGE("Document No.", VendLedgEntry."Document No.");
                    WhtEntry.SETRANGE("Document Type", VendLedgEntry."Document Type");
                    if WhtEntry.FINDFIRST() then
                        ERROR(Text007, Rec."WHT Business Posting Group", Rec."WHT Product Posting Group");
                until VendLedgEntry.NEXT() = 0;
        end;
        //HEI.33<<
    end;

    [EventSubscriber(ObjectType::Table, 50077, 'OnBeforeRenameEvent', '', false, false)]
    local procedure T50077OnBeforeRenameWHTPostingSetup(var Rec: Record "WHT Posting Setup FND"; var xRec: Record "WHT Posting Setup FND"; RunTrigger: Boolean);
    var
        GenLedgerSetup: Record "General Ledger Setup";
        VendLedgEntry: Record "Vendor Ledger Entry";
        WhtEntry: Record "WHT Entry FND";
    begin
        //HEI.33>>
        GenLedgerSetup.GET();
        if GenLedgerSetup."Enable WHT FND" then begin
            WhtEntry.RESET();
            WhtEntry.SETCURRENTKEY("Document Type", "Transaction Type", Settled, "WHT Bus. Posting Group", "WHT Prod. Posting Group", "Posting Date");
            WhtEntry.SETRANGE("WHT Bus. Posting Group", xRec."WHT Business Posting Group");
            WhtEntry.SETRANGE("WHT Prod. Posting Group", xRec."WHT Product Posting Group");

            VendLedgEntry.SETCURRENTKEY(Open, "On Hold");
            VendLedgEntry.SETRANGE(Open, true);
            VendLedgEntry.SETRANGE("On Hold", '');
            if VendLedgEntry.findset() then
                repeat
                    WhtEntry.SETRANGE("Document No.", VendLedgEntry."Document No.");
                    WhtEntry.SETRANGE("Document Type", VendLedgEntry."Document Type");
                    if WhtEntry.FINDFIRST() then
                        ERROR(Text007, xRec."WHT Business Posting Group", xRec."WHT Product Posting Group");
                until VendLedgEntry.NEXT() = 0;
        end;
        //HEI.33<<
    end;

    [EventSubscriber(ObjectType::Page, 51, 'OnAfterValidateEvent', 'Payment Terms Code', false, false)]
    local procedure T38OnAfterPaytermValidate(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header");
    var
        PurchLineRec: Record "Purchase Line";
        Text000: Label 'You cannot change the Payment Terms as purchase line includes values from receipt lines.';
    begin
        //HEI.40 >>
        PurchLineRec.RESET();
        PurchLineRec.SETRANGE("Document Type", Rec."Document Type");
        PurchLineRec.SETRANGE("Document No.", Rec."No.");
        PurchLineRec.SETFILTER("Order No.", '<>%1', '');
        if PurchLineRec.FINDFIRST() then
            ERROR(Text000);
        //HEI.40 <<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterInsertEvent', '', false, false)]
    local procedure T39OnAfterPurchLineInsert(var Rec: Record "Purchase Line"; RunTrigger: Boolean);
    var
        PurchHdrRec: Record "Purchase Header";
        PurchLineRec: Record "Purchase Line";
        ReqRecDate: Date;
    begin
        /*
        // HEI.41 >>
        //HEI.46 >>
        IF Rec."Requested Receipt Date" = 0D THEN BEGIN
        PurchHdrRec.RESET;
        ReqRecDate := 0D;
        {
        IF PurchHdrRec.GET(Rec."Document Type",Rec."Document No.") THEN BEGIN
          IF (PurchHdrRec."Order Date" <> 0D) AND (FORMAT(Rec."Lead Time Calculation") <> '') THEN BEGIN
        }
        IF PurchHdrRec.GET(Rec."Document Type"::Order,Rec."Document No.") THEN BEGIN
          IF (PurchHdrRec."Order Date" <> 0D) AND (FORMAT(Rec."Lead Time Calculation") <> '0D') THEN BEGIN
        
            PurchLineRec.RESET;
            IF PurchLineRec.GET(Rec."Document Type",Rec."Document No.",Rec."Line No.") THEN BEGIN
              ReqRecDate := CALCDATE(Rec."Lead Time Calculation",PurchHdrRec."Order Date");
              IF PurchLineRec."Requested Receipt Date" <> ReqRecDate THEN BEGIN
        //HEI.46 <<
              PurchLineRec."Requested Receipt Date" := CALCDATE(Rec."Lead Time Calculation",PurchHdrRec."Order Date");
              PurchLineRec.MODIFY;
            end;
          end;
        end;
        end;
        end;
        // HEI.41 <<
        */

    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnBeforeInsertEvent', '', false, false)]
    local procedure T39OnBeforePurchLineInsert(var Rec: Record "Purchase Line"; RunTrigger: Boolean);
    var
        PurchHdrRec: Record "Purchase Header";
    begin
        //HEI.54>>
        if (Rec."Requested Receipt Date" = 0D) and (Rec."Document Type" in [Rec."Document Type"::Order, Rec."Document Type"::Quote]) then begin
            PurchHdrRec.RESET();
            if PurchHdrRec.GET(Rec."Document Type", Rec."Document No.") then
                //HEI.96>>
                //HEI.95>>
                //IF PurchHdrRec."SRM Order No. FND" = '' THEN
                //HEI.95<<
                if PurchHdrRec."SRM Order No. FND" = '' then begin
                    //IF (PurchHdrRec."Order Date" <> 0D) AND (FORMAT(Rec."Lead Time Calculation") <> '0D') THEN
                    if (PurchHdrRec."Order Date" <> 0D) and (FORMAT(Rec."Lead Time Calculation") <> '') then
                        //HEI.96<<
                        Rec.VALIDATE("Requested Receipt Date", CALCDATE(Rec."Lead Time Calculation", PurchHdrRec."Order Date"));//HEI.85
                                                                                                                                //Rec."Requested Receipt Date" := CALCDATE(Rec."Lead Time Calculation",PurchHdrRec."Order Date");//HEI.85
                                                                                                                                //Rec.MODIFY;
                                                                                                                                //HEI.96>>
                end else begin
                    if Rec."Expected Receipt Date" <> 0D then
                        Rec.VALIDATE(Rec."Requested Receipt Date", Rec."Expected Receipt Date");
                end;
            //HEI.96<<
        end;
        //HEI.54<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Lead Time Calculation', false, false)]
    local procedure T39OnAfterLeadTimeValidate(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        PurchHdrRec: Record "Purchase Header";
        PurchLineRec: Record "Purchase Line";
        ExpRecDate: Date;
    begin
        /*//HEI.54
        // HEI.41 >>
        ExpRecDate := 0D;
        PurchHdrRec.RESET;
        //HEI.46 >>
        {
        IF PurchHdrRec.GET(Rec."Document Type",Rec."Document No.") THEN BEGIN
          IF (PurchHdrRec."Order Date" <> 0D) AND (FORMAT(Rec."Lead Time Calculation") <> '0D') THEN BEGIN
        }
        IF PurchHdrRec.GET(Rec."Document Type"::Order,Rec."Document No.") THEN BEGIN
          IF (PurchHdrRec."Order Date" <> 0D) AND (FORMAT(Rec."Lead Time Calculation") <> '0D') THEN BEGIN
        //HEI.46 <<
            ExpRecDate := CALCDATE(Rec."Lead Time Calculation",PurchHdrRec."Order Date");
            PurchLineRec.RESET;
            PurchLineRec.SETRANGE("Document No.",Rec."No.");
            IF PurchLineRec.findset THEN
              PurchLineRec.MODIFYALL("Requested Receipt Date",ExpRecDate);;
          end;
        end;
        // HEI.41 <<
        *///HEI.54
        //HEI.54>>
        PurchHdrRec.RESET();
        if PurchHdrRec.GET(Rec."Document Type", Rec."Document No.") then begin
            if (PurchHdrRec."Order Date" <> 0D) and (FORMAT(Rec."Lead Time Calculation") <> '') then
                Rec.VALIDATE("Requested Receipt Date", CALCDATE(Rec."Lead Time Calculation", PurchHdrRec."Order Date"));//HEi.85
            //Rec."Requested Receipt Date" := CALCDATE(Rec."Lead Time Calculation",PurchHdrRec."Order Date");
        end;
        //HEI.54<<

    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Order Date', false, false)]
    local procedure T38OnAfterOrderDateValidate(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    var
        PurchHdrRec: Record "Purchase Header";
        PurchLineRec: Record "Purchase Line";
        ExpRecDate: Date;
    begin
        /*
        // HEI.41 >>
        
        ExpRecDate := 0D;
          IF (Rec."Order Date" <> 0D) AND (FORMAT(Rec."Lead Time Calculation") <> '') THEN BEGIN
            ExpRecDate := CALCDATE(Rec."Lead Time Calculation",Rec."Order Date");
            PurchLineRec.RESET;
            PurchLineRec.SETRANGE("Document No.",Rec."No.");
            IF PurchLineRec.findset THEN
              PurchLineRec.MODIFYALL("Requested Receipt Date",ExpRecDate);;
          end;
        
        // HEI.41 <<
        */
        //HEI.54>>
        if (Rec."Document Type" in [Rec."Document Type"::Quote, Rec."Document Type"::Order]) and (Rec."Order Date" <> 0D) then begin
            PurchLineRec.RESET();
            PurchLineRec.SETRANGE("Document Type", Rec."Document Type");
            PurchLineRec.SETRANGE("Document No.", Rec."No.");
            if PurchLineRec.findset() then
                repeat
                    if FORMAT(PurchLineRec."Lead Time Calculation") <> '' then begin
                        PurchLineRec.VALIDATE("Requested Receipt Date", CALCDATE(PurchLineRec."Lead Time Calculation", Rec."Order Date"));
                        //PurchLineRec."Requested Receipt Date" := CALCDATE(PurchLineRec."Lead Time Calculation",Rec."Order Date");//HEI.85
                        PurchLineRec.MODIFY();
                    end;
                until PurchLineRec.NEXT() = 0;
        end;
        //HEI.54<<

    end;

    local procedure CheckToleranceMemo(var PurchLine: Record "Purchase Line");
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
        ReturnShipLineRec: Record "Return Shipment Line";
        ToleranceExceptions: Record "Tolerance Exceptions FND";
        ToleranceExceptionFound: Boolean;
        LowerAmt: Decimal;
        LowerPercAmt: Decimal;
        UpperAmt: Decimal;
        UpperPercAmt: Decimal;
    begin
        // HEI.43 >>
        GetPurchSetup();
        if not PurchSetup."Invoice Toler.CheckEnabled FND" then
            exit;
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases.
        // with PurchLine do begin
        //     if "Return Shipment No." <> '' then begin
        //         ReturnShipLineRec.GET("Return Shipment No.", "Return Shipment Line No.");
        //         //HEI.58>>
        //         ToleranceExceptionFound := false;
        //         ToleranceExceptions.SETRANGE("Vendor No.", PurchLine."Buy-from Vendor No.");
        //         ToleranceExceptions.SETRANGE(Type, PurchLine.Type);
        //         if ToleranceExceptions.FINDFIRST() then
        //             ToleranceExceptionFound := true
        //         else begin
        //             ToleranceExceptions.SETRANGE("Vendor No.");
        //             if ToleranceExceptions.FINDFIRST() then
        //                 ToleranceExceptionFound := true;
        //         end;

        //         if not ToleranceExceptionFound then
        //             //HEI.58<<
        //             UpperPercAmt := ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" * (100 + PurchSetup."Upper % Tolerance") / 100
        //         else
        //             UpperPercAmt := ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" * (100 + ToleranceExceptions."Upper % Tolerance") / 100;
        //         //HEI.58<<

        //         if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" > UpperPercAmt then
        //             ERROR(Text001, PurchLine."Line No.", PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" - UpperPercAmt);

        //         if not ToleranceExceptionFound then begin//HEI.58
        //             if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" > ReturnShipLineRec."Direct Unit Cost" *
        //               PurchLine."Qty. to Invoice" + PurchSetup."Upper Amount Tolerance" then
        //                 ERROR(Text002, PurchLine."Line No.", PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice"
        //                  - (ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" + PurchSetup."Upper Amount Tolerance"))
        //             //HEI.58>>
        //         end else
        //             if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" > ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" +
        //                ToleranceExceptions."Upper Amount Tolerance"
        //             then
        //                 ERROR(Text002, PurchLine."Line No.", PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" -
        //                   (ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" + ToleranceExceptions."Upper Amount Tolerance"));

        //         if not ToleranceExceptionFound then
        //             //HEI.58<<
        //             LowerPercAmt := ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" * PurchSetup."Lower % Tolerance" / 100
        //         //HEI.58>>
        //         else
        //             LowerPercAmt := ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" * ToleranceExceptions."Lower % Tolerance" / 100;
        //         //HEI.58<<

        //         if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" < ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" - LowerPercAmt then
        //             ERROR(Text003, PurchLine."Line No.", ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" - LowerPercAmt -
        //               PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice");

        //         if not ToleranceExceptionFound then begin//HEI.58
        //             if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" < ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice"
        //               - PurchSetup."Lower Amount Tolerance" then
        //                 ERROR(Text004, PurchLine."Line No.", ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" - PurchSetup."Lower Amount Tolerance"
        //                 - PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice")
        //             //HEI.58>>
        //         end else
        //             if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" < ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" -
        //                ToleranceExceptions."Lower Amount Tolerance"
        //             then
        //                 ERROR(Text004, PurchLine."Line No.", ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" - ToleranceExceptions."Lower Amount Tolerance" -
        //                   PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice");
        //         //HEI.58<<
        //     end;
        // end;
        if PurchLine."Return Shipment No." <> '' then begin
            ReturnShipLineRec.GET(PurchLine."Return Shipment No.", PurchLine."Return Shipment Line No.");
            //HEI.58>>
            ToleranceExceptionFound := false;
            ToleranceExceptions.SETRANGE("Vendor No.", PurchLine."Buy-from Vendor No.");
            ToleranceExceptions.SETRANGE(Type, PurchLine.Type);
            if ToleranceExceptions.FINDFIRST() then
                ToleranceExceptionFound := true
            else begin
                ToleranceExceptions.SETRANGE("Vendor No.");
                if ToleranceExceptions.FINDFIRST() then
                    ToleranceExceptionFound := true;
            end;

            if not ToleranceExceptionFound then
                //HEI.58<<
                UpperPercAmt := ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" * (100 + PurchSetup."Upper % Tolerance FND") / 100
            else
                UpperPercAmt := ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" * (100 + ToleranceExceptions."Upper % Tolerance") / 100;
            //HEI.58<<

            if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" > UpperPercAmt then
                ERROR(Text001, PurchLine."Line No.", PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" - UpperPercAmt);

            if not ToleranceExceptionFound then begin//HEI.58
                if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" > ReturnShipLineRec."Direct Unit Cost" *
                    PurchLine."Qty. to Invoice" + PurchSetup."Upper Amount Tolerance FND" then
                    ERROR(Text002, PurchLine."Line No.", PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice"
                        - (ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" + PurchSetup."Upper Amount Tolerance FND"))
                //HEI.58>>
            end else
                if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" > ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" +
                    ToleranceExceptions."Upper Amount Tolerance"
                then
                    ERROR(Text002, PurchLine."Line No.", PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" -
                        (ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" + ToleranceExceptions."Upper Amount Tolerance"));

            if not ToleranceExceptionFound then
                //HEI.58<<
                LowerPercAmt := ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" * PurchSetup."Lower % Tolerance FND" / 100
            //HEI.58>>
            else
                LowerPercAmt := ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" * ToleranceExceptions."Lower % Tolerance" / 100;
            //HEI.58<<

            if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" < ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" - LowerPercAmt then
                ERROR(Text003, PurchLine."Line No.", ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" - LowerPercAmt -
                    PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice");

            if not ToleranceExceptionFound then begin//HEI.58
                if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" < ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice"
                    - PurchSetup."Lower Amount Tolerance FND" then
                    ERROR(Text004, PurchLine."Line No.", ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" - PurchSetup."Lower Amount Tolerance FND"
                    - PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice")
                //HEI.58>>
            end else
                if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" < ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" -
                    ToleranceExceptions."Lower Amount Tolerance"
                then
                    ERROR(Text004, PurchLine."Line No.", ReturnShipLineRec."Direct Unit Cost" * PurchLine."Qty. to Invoice" - ToleranceExceptions."Lower Amount Tolerance" -
                        PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice");
            //HEI.58<<
        end;
        // BC Upgrade PATELP08 >>
        // HEI.43 <<
    end;
    //BC Upgrade SHARMP16 begin<<---------------- need to rewrite the code as per the Bc standards 
    // local procedure ReleasePurchCheck();
    // var
    //     PurchaseHdrRec: Record "Purchase Header";
    //     PurchaseHdrAddRec: Record "Purchase Header Additional FND";
    // begin
    //     // HEI.44 <<
    //     GetPurchSetup; //HEI.52
    //     PurchaseHdrRec.RESET;
    //     PurchaseHdrRec.SETRANGE("Document Type", PurchaseHdrRec."Document Type"::Order);
    //     PurchaseHdrRec.SETRANGE(Status, PurchaseHdrRec.Status::Released);
    //     PurchaseHdrRec.SETFILTER("SRM Order No. FND", '=%1', '');
    //     // PurchaseHdrRec.SETFILTER("Document Subtype Code FND", '%1|%2', PurchSetup."PO Subtype Code", ''); //HEI.52 //BC Upgrade SHARMP16 --Drink-IT field
    //     PurchaseHdrRec.SETFILTER("Order Date", '>%1', 20200130D);
    //     if PurchaseHdrRec.FINDFIRST then begin
    //         repeat
    //             PurchaseHdrAddRec.RESET;
    //             if PurchaseHdrAddRec.GET(PurchaseHdrRec."Document Type", PurchaseHdrRec."No.") then begin
    //                 if PurchaseHdrAddRec."Mail Sent" = false then begin
    //                     if (PurchaseHdrRec.Changed = false) and (PurchaseHdrRec."No. Printed" = 0) then
    //                         SendEmailWithAtachment(PurchaseHdrRec."No.")
    //                     else if (PurchaseHdrRec.Changed = true) and (PurchaseHdrRec."No. Printed" > 0) then
    //                         SendEmailWithAtachment(PurchaseHdrRec."No.");
    //                 end;
    //             end;
    //         until PurchaseHdrRec.NEXT = 0;
    //     end;
    //     // HEI.44 <<
    // end;
    //BC Upgrade SHARMP16 end>>---------------- need to rewrite the code as per the Bc standards 

    //BC Upgrade SHARMP16 begin<<---------------- need to rewrite the code as per the Bc standards 
    // local procedure SendEmailWithAtachment(var PurchaseHdrNo: Code[20]);
    // var
    //     VendorRec: Record Vendor;
    //     SMTPSeturpRec: Record "SMTP Mail Setup";
    //     SMTP: Codeunit "SMTP Mail";
    //     FileName: Text;
    //     VendEmail: Text;
    //     FileMgmnt: Codeunit "File Management";
    //     ReportSelectionRec: Record "Report Selections";
    //     PurchHdrAddRec: Record "Purchase Header Additional FND";
    //     UsersRec: Record User;
    //     PurchHdrRec: Record "Purchase Header";
    //     TempPurchHdrRec: Record "Purchase Header" temporary;
    //     PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    // begin
    //     // HEI.44 >>
    //     CLEAR(VendEmail);
    //     CLEAR(FileName);
    //     SMTPSeturpRec.RESET;
    //     SMTPSeturpRec.GET;
    //     PurchHdrRec.RESET;
    //     if PurchHdrRec.GET(PurchHdrRec."Document Type"::Order, PurchaseHdrNo) then begin
    //         VendorRec.RESET;
    //         if VendorRec.GET(PurchHdrRec."Buy-from Vendor No.") then
    //             VendEmail := VendorRec."E-Mail";



    //         if VendEmail <> '' then begin
    //             //HEI.50>>
    //             if CheckValidEmailAddress(VendEmail) then begin
    //                 //HEI.50 <<
    //                 FileName := FileMgmnt.ServerTempFileName('pdf');

    //                 TempPurchHdrRec.RESET;
    //                 TempPurchHdrRec.COPY(PurchHdrRec);
    //                 TempPurchHdrRec.INSERT;
    //                 TempPurchHdrRec.SETRECFILTER;

    //                 ReportSelectionRec.RESET;
    //                 ReportSelectionRec.SETRANGE(Usage, ReportSelectionRec.Usage::"P.Order");
    //                 ReportSelectionRec.SETFILTER("Report ID", '<>%1', 0);
    //                 // ReportSelectionRec.SETRANGE("Document Subtype Code FND", PurchHdrRec."Document Subtype Code FND");//BC Upgrade SHARMP16 -- Drink-IT field
    //                 if ReportSelectionRec.FINDFIRST then
    //                     REPORT.SAVEASPDF(ReportSelectionRec."Report ID", FileName, TempPurchHdrRec);

    //                 UsersRec.RESET;
    //                 UsersRec.SETRANGE("User Name", USERID);
    //                 if UsersRec.FINDFIRST then;
    //                 //SMTP.CreateMessage('',UsersRec."Contact Email",VendEmail,'Purchase Order','',TRUE);
    //                 //HEI.50>>
    //                 SMTP.CreateMessage('', 'Donotreply@heineken.com', VendEmail, 'Purchase Order', '', true);
    //                 //>> HEI.52
    //                 if CheckRequesterPO(PurchHdrRec) then
    //                     SMTP.AddCC(FindRequesterEmailPO(PurchHdrRec));
    //                 //<< HEI.52
    //                 //HEI.98>>
    //                 //HEI.100>>
    //                 PurchasesPayablesSetup.GET;
    //                 if PurchasesPayablesSetup."Auto Email to Requestor" = true then begin
    //                     //HEI.100<<
    //                     if (PurchHdrRec."Maximo Requisition No." <> '') and (FindPQApproerEmail(PurchHdrRec) <> '') then
    //                         SMTP.AddCC(FindPQApproerEmail(PurchHdrRec))
    //                     else if
    //                       (PurchHdrRec."Maximo Requisition No." = '') and (FindCreaterEmail(PurchHdrRec) <> '') then
    //                         SMTP.AddCC(FindCreaterEmail(PurchHdrRec));
    //                 end;//HEI.100
    //                     //HEI.98<<
    //                     //HEI.50<<
    //                 SMTP.AddAttachment(FileName, PurchHdrRec."No." + '.pdf');
    //                 SMTP.AppendBody('Hi ' + PurchHdrRec."Buy-from Vendor Name");
    //                 SMTP.AppendBody('<br><br>');
    //                 SMTP.AppendBody('Please find the attachement');
    //                 SMTP.AppendBody('<br><br>');
    //                 SMTP.AppendBody('<HR>');
    //                 SMTP.AppendBody('This is system generated mail. Please do not reply to this EmailID');
    //                 SMTP.Send;
    //                 PurchHdrAddRec.RESET;
    //                 if PurchHdrAddRec.GET(PurchHdrRec."Document Type", PurchHdrRec."No.") then begin
    //                     PurchHdrAddRec."Mail Sent" := true;
    //                     PurchHdrAddRec."Mail Sent Date Time" := CREATEDATETIME(TODAY, TIME);//HEI.50
    //                     PurchHdrAddRec.MODIFY;
    //                 end;
    //             end;
    //         end;
    //     end;
    //     // HEI.44 <<
    // end;
    //BC Upgrade SHARMP16 end>>--------------- need to rewrite the code as per the Bc standards

    //BC Upgrade ATHUKS01>>
    local procedure ReleasePurchCheck();
    var
        PurchaseHdrRec: Record "Purchase Header";
        PurchaseHdrAddRec: Record "Purchase Header Additional FND";
    begin
        // HEI.44 <<
        GetPurchSetup(); //HEI.52
        PurchaseHdrRec.RESET();
        PurchaseHdrRec.SETRANGE("Document Type", PurchaseHdrRec."Document Type"::Order);
        PurchaseHdrRec.SETRANGE(Status, PurchaseHdrRec.Status::Released);
        PurchaseHdrRec.SETFILTER("SRM Order No. FND", '=%1', '');
        PurchaseHdrRec.SETFILTER("Document Subtype Code FND", '%1|%2', PurchSetup."PO Subtype Code FND", ''); //HEI.52 //BC Upgrade SHUKLP03
        PurchaseHdrRec.SETFILTER("Order Date", '>%1', 20200130D);
        if PurchaseHdrRec.FindSet() then
            repeat
                PurchaseHdrAddRec.RESET();
                if PurchaseHdrAddRec.GET(PurchaseHdrRec."Document Type", PurchaseHdrRec."No.") then begin
                    if PurchaseHdrAddRec."Mail Sent" = false then begin
                        if (PurchaseHdrRec."Changed FND" = false) and (PurchaseHdrRec."No. Printed" = 0) then
                            SendEmailWithAttachment(PurchaseHdrRec."No.")
                        else if (PurchaseHdrRec."Changed FND" = true) and (PurchaseHdrRec."No. Printed" > 0) then
                            SendEmailWithAttachment(PurchaseHdrRec."No.");
                    end;
                end;
            until PurchaseHdrRec.NEXT() = 0;
    end;
    //BC Upgrade ATHUKS01<<

    //BC Upgrade ATHUKS01>>
    local procedure SendEmailWithAttachment(PurchaseHdrNo: Code[20])
    var
        PurchHdrRec: Record "Purchase Header";
        TempPurchHdrRec: Record "Purchase Header" temporary;
        PurchHdrAddRec: Record "Purchase Header Additional FND";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        ReportSelectionRec: Record "Report Selections";
        VendorRec: Record Vendor;
        WorkflowRule: Record "Workflow Rule";
        Base64Convert: Codeunit "Base64 Convert";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        FileManagement: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        FileInStream: InStream;
        OutStream: OutStream;
        AttachmentBase64: Text;
        BodyText: Text;
        FileName: Text;
        SubjectText: Text;
        VendorEmail: Text;
        FileNameL: Text[250];
        AllObjWithCaption: Record AllObjWithCaption;
        ReportParameters: Text;
        ReportLbl: Label '<?xml version="1.0" standalone="yes"?><ReportParameters name= "%1" id="%2"><Options><Field name="ArchiveDocument">false</Field><Field name="LogInteraction">true</Field></Options><DataItems><DataItem name="Purchase Header">VERSION(1) SORTING(Field1,Field3) WHERE(Field3=1(%3))</DataItem><DataItem name="Purchase Line">VERSION(1) SORTING(Field1,Field3,Field4)</DataItem><DataItem name="Totals">VERSION(1) SORTING(Field1)</DataItem><DataItem name="VATCounter">VERSION(1) SORTING(Field1)</DataItem><DataItem name="VATCounterLCY">VERSION(1) SORTING(Field1)</DataItem><DataItem name="PrepmtLoop">VERSION(1) SORTING(Field1)</DataItem><DataItem name="PrepmtVATCounter">VERSION(1) SORTING(Field1)</DataItem><DataItem name="LetterText">VERSION(1) SORTING(Field1)</DataItem></DataItems></ReportParameters>';

    begin
        // HEI.44 >>
        Clear(VendorEmail);
        Clear(FileName);
        // Get Purchase Header
        if not PurchHdrRec.Get(PurchHdrRec."Document Type"::Order, PurchaseHdrNo) then
            exit;

        // Get Vendor Email
        if VendorRec.Get(PurchHdrRec."Buy-from Vendor No.") then
            VendorEmail := VendorRec."E-Mail";

        if VendorEmail = '' then
            exit;

        // Optional validation
        if not CheckValidEmailAddress(VendorEmail) then
            exit;
        // Get report selection for Purchase Order
        ReportSelectionRec.Reset();
        ReportSelectionRec.SetRange(Usage, ReportSelectionRec.Usage::"P.Order");
        ReportSelectionRec.SetFilter("Report ID", '<>%1', 0);
        ReportSelectionRec.SETRANGE("Document Subtype Code FND", PurchHdrRec."Document Subtype Code FND");
        if not ReportSelectionRec.FindFirst() then
            exit;

        if AllObjWithCaption.Get(AllObjWithCaption."Object Type"::Report, ReportSelectionRec."Report ID") then;

        ReportParameters := StrSubstNo(ReportLbl, AllObjWithCaption."Object Caption", ReportSelectionRec."Report ID", PurchHdrRec."No.");
        TempBlob.CreateOutStream(OutStream);
        Report.SaveAs(ReportSelectionRec."Report ID", ReportParameters, ReportFormat::Pdf, OutStream);
        TempBlob.CreateInStream(FileInStream);

        SubjectText := StrSubstNo('Purchase Order %1', PurchHdrRec."No.");
        BodyText :=
          'Hi ' + PurchHdrRec."Buy-from Vendor Name" + ',' + '<br><br>' +
          'Please find the attached Purchase Order.' + '<br><br>' +
          '<hr>This is a system-generated email. Please do not reply.';

        // Create and configure email message
        EmailMessage.Create(VendorEmail, SubjectText, BodyText, true);

        // Add attachment
        EmailMessage.AddAttachment(PurchHdrRec."No." + '.pdf', 'application/pdf', FileInStream);

        // Add CC (optional logic)
        PurchasesPayablesSetup.Get();
        if PurchasesPayablesSetup."Auto Email to Requestor FND" then begin
            if (PurchHdrRec."Maximo Requisition No. FND" <> '') and (FindPQApproerEmail(PurchHdrRec) <> '') then
                EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, FindPQApproerEmail(PurchHdrRec))

            else if (PurchHdrRec."Maximo Requisition No. FND" = '') and (FindCreaterEmail(PurchHdrRec) <> '') then
                EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, FindCreaterEmail(PurchHdrRec))

        end;

        // Send the email using the default email account
        Email.Send(EmailMessage, Enum::"Email Scenario"::"Purchase Order");

        // Update "Mail Sent" tracking
        if PurchHdrAddRec.Get(PurchHdrRec."Document Type", PurchHdrRec."No.") then begin
            PurchHdrAddRec."Mail Sent" := true;
            PurchHdrAddRec."Mail Sent Date Time" := CreateDateTime(Today, Time);
            PurchHdrAddRec.Modify();
        end;
        // HEI.44 <<
    end;
    //BC Upgrade ATHUKS01<<

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterModifyEvent', '', false, false)]
    local procedure T38OnAfterValidateStatus(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; RunTrigger: Boolean);
    var
        PurchHdrAddRec: Record "Purchase Header Additional FND";
    begin
        // HEI.44 >>
        if Rec.Status <> Rec.Status::Released then begin
            PurchHdrAddRec.RESET();
            if PurchHdrAddRec.GET(Rec."Document Type", Rec."No.") then begin
                PurchHdrAddRec."Mail Sent" := false;
                PurchHdrAddRec.MODIFY();
            end;
        end;
        // HEI.44 <<
    end;

    procedure CheckValidEmailAddress(EmailAddress: Text): Boolean;
    var
        i: Integer;
        NoOfAtSigns: Integer;
    begin
        //HEi.44 >>
        EmailAddress := DELCHR(EmailAddress, '<>');

        if EmailAddress = '' then
            exit(false);
        //ERROR(InvalidEmailAddressErr,EmailAddress);

        if (EmailAddress[1] = '@') or (EmailAddress[STRLEN(EmailAddress)] = '@') then
            exit(false);
        //ERROR(InvalidEmailAddressErr,EmailAddress);

        for i := 1 to STRLEN(EmailAddress) do begin
            if EmailAddress[i] = '@' then
                NoOfAtSigns := NoOfAtSigns + 1
            else
                if EmailAddress[i] = ' ' then
                    exit(false);
            //ERROR(InvalidEmailAddressErr,EmailAddress);
        end;

        if NoOfAtSigns <> 1 then
            exit(false);
        //ERROR(InvalidEmailAddressErr,EmailAddress);
        exit(true);
        //HEI.44 <<
    end;

    local procedure CheckRequesterPO(var PurchaseHeader: Record "Purchase Header"): Boolean;
    var
        locUserSetup: Record "User Setup";
    begin
        //>> HEI.52
        // locUserSetup.SETRANGE("User ID", PurchaseHeader."Requester ID");//BC UPgrade SHARMP16--Drink-IT field.
        if locUserSetup.FINDFIRST() then
            if locUserSetup."E-Mail" <> '' then
                exit(true)
            else
                exit(false);
        //<< HEI.52
    end;

    local procedure FindRequesterEmailPO(var PurchaseHeader: Record "Purchase Header"): Text[100];
    var
        locUserSetup: Record "User Setup";
    begin
        //>> HEI.52
        //locUserSetup.SETRANGE("User ID", PurchaseHeader."Requester ID");//BC UPgrade SHARMP16--Drink-IT field.
        if locUserSetup.FINDFIRST() then
            if locUserSetup."E-Mail" <> '' then
                exit(locUserSetup."E-Mail");
        //<< HEI.52
    end;

    [EventSubscriber(ObjectType::Page, 480, 'OnDeleteRecordEvent', '', false, false)]
    local procedure P480OnDeleteEvent(var Rec: Record "Dimension Set Entry"; var AllowDelete: Boolean);
    begin
        //>> HEI.53
        GetGenLedgSetup();
        if Rec."Dimension Code" = GeneralLedgerSetup."License Dimension Code FND" then
            ERROR(Text0003);
        //<< HEI.53
    end;

    [EventSubscriber(ObjectType::Page, 480, 'OnModifyRecordEvent', '', false, false)]
    local procedure P480OnModifyEvent(var Rec: Record "Dimension Set Entry"; var xRec: Record "Dimension Set Entry"; var AllowModify: Boolean);
    begin
        //>> HEI.53
        GetGenLedgSetup();
        if Rec."Dimension Code" = GeneralLedgerSetup."License Dimension Code FND" then
            ERROR(Text0002);
        //<< HEI.53
    end;

    [EventSubscriber(ObjectType::Page, 480, 'OnInsertRecordEvent', '', false, false)]
    local procedure P480OnInsertEvent(var Rec: Record "Dimension Set Entry"; BelowxRec: Boolean; var xRec: Record "Dimension Set Entry"; var AllowInsert: Boolean);
    begin
        //>> HEI.53
        GetGenLedgSetup();
        if Rec."Dimension Code" = GeneralLedgerSetup."License Dimension Code FND" then
            ERROR(Text0001);
        //<< HEI.53
    end;

    local procedure GetGenLedgSetup();
    begin
        //>> HEI.53
        if not GenLedgSetupGot then
            GeneralLedgerSetup.GET();
        GenLedgSetupGot := true;
        //<< HEI.53
    end;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnBeforeInsertValueEntry', '', false, false)]
    local procedure C22OnBeforeInsertValueEntry(var ValueEntry: Record "Value Entry"; ItemJournalLine: Record "Item Journal Line");
    var
        Item: Record Item;
    begin
        //HEI.25>>
        Item.GET(ValueEntry."Item No.");

        if (ValueEntry."Document Type" = ValueEntry."Document Type"::"Purchase Receipt") or
           (ValueEntry."Document Type" = ValueEntry."Document Type"::"Purchase Return Shipment")
        then
            if not Item."Inventory Value Zero" then
                ValueEntry."Cost Amount (Purchase) FND" := ItemJournalLine."Unit Cost (ACY)" * ValueEntry."Item Ledger Entry Quantity"
            else
                if (ValueEntry."Document Type" = ValueEntry."Document Type"::"Purchase Invoice") or
                   (ValueEntry."Document Type" = ValueEntry."Document Type"::"Purchase Credit Memo")
                then
                    if not Item."Inventory Value Zero" and
                       (ValueEntry."Entry Type" = ValueEntry."Entry Type"::"Direct Cost")
                    then
                        ValueEntry."Cost Amount (Purchase) FND" := ItemJournalLine."Unit Cost (ACY)" * ItemJournalLine."Invoiced Quantity" * (-1)
                    else
                        ValueEntry."Cost Amount (Purchase) FND" := 0;
        //HEI.25<<
    end;
    //BC Upgrade SHARMP16-- Interface Code begin>>
    // [EventSubscriber(ObjectType::Table, 7316, 'OnBeforeInsertEvent', '', false, false)]
    // local procedure T7316LSROnBeforeInsert(var Rec: Record "Warehouse Receipt Header"; RunTrigger: Boolean);
    // var
    //     //LSRInterfaceSetup: Record "LSR Interface Setup INT"; //BC Upgrade SHARMP16-- Interface Code
    //     PurchOrder: Record "Purchase Header";
    //     LSRText001: Label 'The warehouse receipt must be created in LS Retail.';
    // begin

    //     //HEI.57<<
    //     // if GUIALLOWED then
    //     //     if LSRInterfaceSetup.GET and LSRInterfaceSetup."Enable LSR Interface" then
    //     //         if Rec."Source Document Type" = Rec."Source Document Type"::"Purchase Order" then
    //     //             if PurchOrder.GET(PurchOrder."Document Type"::Order, Rec."Source No.") then begin
    //     //                 PurchOrder.CALCFIELDS("LSR Order No.");
    //     //                 if (PurchOrder."LSR Order No." <> '') then
    //     //                     ERROR(LSRText001);
    //     //             end;
    //     //HEI.57>>


    // end;
    //BC Upgrade SHARMP16-- Interface Code end<<
    [EventSubscriber(ObjectType::Table, 38, 'OnAfterInsertEvent', '', false, false)]
    local procedure T38OnAfterInsert(var Rec: Record "Purchase Header"; RunTrigger: Boolean);
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        ShipmentMethod: Record "Shipment Method";
        Excluded: Boolean;
    begin
        //>> HEI.59
        GetPurchSetup();
        if PurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") then begin
            if not CheckShippingMethod(PurchSetup, Rec) then
                PurchaseHeaderAdditional."Import Identifier" := true
            else
                PurchaseHeaderAdditional."Import Identifier" := false;
            if Rec."Shipment Method Code" = '' then
                PurchaseHeaderAdditional."Import Identifier" := false;
            PurchaseHeaderAdditional.MODIFY();
        end;
        //<< HEI.59
    end;

    procedure CheckShippingMethod(PurchasesPayablesSetup: Record "Purchases & Payables Setup"; var PurchaseHeader: Record "Purchase Header"): Boolean;
    var
        ShipmentMethod: Record "Shipment Method";
    begin
        //>> HEI.59
        GetPurchSetup();
        //HEI.152>>
        if PurchSetup."Excluded Countries Imp PO FND" <> '' then
            if STRPOS(PurchSetup."Excluded Countries Imp PO FND", PurchaseHeader."Buy-from Country/Region Code") <> 0 then
                exit(true);
        //HEI.152<<
        ShipmentMethod.RESET();
        ShipmentMethod.SETFILTER(Code, PurchSetup."Excluded Incoterms FND");
        if ShipmentMethod.findset() then begin
            repeat
                if (PurchaseHeader."Shipment Method Code" = ShipmentMethod.Code) or (PurchaseHeader."Shipment Method Code" = '') then
                    exit(true);
            until ShipmentMethod.NEXT() = 0;
        end;
        exit(false);
        //<< HEI.59
    end;

    // BC Upgrade SHUKLP03 >> Added in the interface ext.
    // [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Shipment Method Code', false, false)]
    // local procedure T38OnAfterInsertShippingMethodCode(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    // var
    //     PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    //     PurchaseLine: Record "Purchase Line";
    //     RequisitionLine: Record "Requisition Line";
    // begin
    //     //>> HEI.59
    //     GetPurchSetup;
    //     PurchaseLine.RESET;
    //     if Rec."Document Type" = Rec."Document Type"::Order then begin
    //         if Rec."Shipment Method Code" <> xRec."Shipment Method Code" then
    //             if Rec.Status = Rec.Status::Released then
    //                 ERROR(Text0005);
    //         if PurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") then begin
    //             if not CheckShippingMethod(PurchSetup, Rec) then begin
    //                 PurchaseHeaderAdditional."Import Identifier" := true;
    //                 PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
    //                 PurchaseLine.SETRANGE("Document No.", Rec."No.");
    //                 PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
    //                 if PurchaseLine.FINDSET then
    //                     PurchaseLine.MODIFYALL("Location Code", PurchSetup."Location Code for Import Proc.");
    //             end else begin
    //                 PurchaseHeaderAdditional."Import Identifier" := false;
    //                 PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
    //                 PurchaseLine.SETRANGE("Document No.", Rec."No.");
    //                 PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
    //                 PurchaseLine.SETRANGE("Special Order Sales No.", ''); //HEI.138
    //                 if PurchaseLine.FINDSET then
    //                     //HEI.160>>
    //                     if PurchaseHeaderAdditional."Zycus Order No." = '' then
    //                 //HEI.160<<
    //                 //HEI.162>>
    //                 begin
    //                         RequisitionLine.RESET;
    //                         // RequisitionLine.SETCURRENTKEY("Action Message", "Blanket Order No.", "Blanket Order Line No.");//BC Upgrade SHARMp16-- Drink-IT field
    //                         // RequisitionLine.SETRANGE("Blanket Order No.", PurchaseLine."Blanket Order No.");//BC Upgrade SHARMp16-- Drink-IT field
    //                         // RequisitionLine.SETRANGE("Blanket Order Line No.", PurchaseLine."Blanket Order Line No.");//BC Upgrade SHARMp16-- Drink-IT field
    //                         if RequisitionLine.ISEMPTY then
    //                             //HEI.162<<
    //                             PurchaseLine.MODIFYALL("Location Code", '');
    //                     end; //HEI.162
    //             end;
    //             if Rec."Shipment Method Code" = '' then
    //                 PurchaseHeaderAdditional."Import Identifier" := false;
    //             PurchaseHeaderAdditional.MODIFY;
    //         end;
    //     end;
    //     //<< HEI.59
    // end;
    // BC Upgrade SHUKLP03 << Added in the interface ext.

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Shipment Method Code', false, false)]
    local procedure T38OnAfterModifyShippingMethodCode(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchaseLine: Record "Purchase Line";
        PurchBlanketLine: Record "Purchase Line";
        RequisitionLine: Record "Requisition Line";
    begin
        //>> HEI.59
        PurchaseLine.RESET();
        GetPurchSetup();
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            if Rec."Shipment Method Code" <> xRec."Shipment Method Code" then
                if Rec.Status = Rec.Status::Released then
                    ERROR(Text0005);
            if PurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") then begin
                if not CheckShippingMethod(PurchSetup, Rec) then begin
                    PurchaseHeaderAdditional."Import Identifier" := true;
                    PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
                    PurchaseLine.SETRANGE("Document No.", Rec."No.");
                    PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
                    if PurchaseLine.findset() then
                        PurchaseLine.MODIFYALL("Location Code", PurchSetup."Location Code Imp Proc. FND");
                end else begin
                    PurchaseHeaderAdditional."Import Identifier" := false;
                    PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
                    PurchaseLine.SETRANGE("Document No.", Rec."No.");
                    PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
                    //HEI.77>>
                    //IF PurchaseLine.findset THEN
                    //  PurchaseLine.MODIFYALL("Location Code",'');
                    if PurchaseLine.findset() then begin
                        if (PurchaseLine."Blanket Order No." <> '') then begin
                            if PurchBlanketLine.GET(PurchBlanketLine."Document Type"::"Blanket Order",
                                      PurchaseLine."Blanket Order No.", PurchaseLine."Blanket Order Line No.") then
                                      //HEI.162>>
                                      begin
                                RequisitionLine.RESET();
                                // RequisitionLine.SETCURRENTKEY("Action Message", "Blanket Order No.", "Blanket Order Line No.");//BC Upgrade SHARMp16-- Drink-IT field
                                // RequisitionLine.SETRANGE("Blanket Order No.", PurchaseLine."Blanket Order No.");//BC Upgrade SHARMp16-- Drink-IT field
                                // RequisitionLine.SETRANGE("Blanket Order Line No.", PurchaseLine."Blanket Order Line No.");//BC Upgrade SHARMp16-- Drink-IT field
                                if RequisitionLine.ISEMPTY then
                                    //HEI.162<<
                                    PurchaseLine.MODIFYALL("Location Code", PurchBlanketLine."Consumption Location Code FND");
                            end; //HEI.162
                        end;
                    end;
                    //HEI.77<<
                end;
                if Rec."Shipment Method Code" = '' then
                    PurchaseHeaderAdditional."Import Identifier" := false;
                PurchaseHeaderAdditional.MODIFY();
            end;
        end;
        //<< HEI.59
        // BC Upgrade BHARDA11 >>
        if Rec."Shipment Method Code" = '' then begin
            PurchaseLine.reset();
            PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
            PurchaseLine.SETRANGE("Document No.", Rec."No.");
            PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
            if PurchaseLine.FindSet() then
                PurchaseLine.ModifyAll("Location Code", '');
        end;
        // BC Upgrade BHARDA11 <<
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Shipment Method Code', false, false)]
    local procedure T38OnAfterDeleteShippingMethodCode(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        //>> HEI.59
        GetPurchSetup();
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            if Rec.Status = Rec.Status::Released then
                ERROR(Text0005);
            if Rec."Shipment Method Code" = '' then begin
                if PurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") then begin
                    PurchaseHeaderAdditional."Import Identifier" := false;
                    PurchaseHeaderAdditional.MODIFY();
                end;
            end;
        end;
        //<< HEI.59
    end;

    procedure ManageTOfromPO(prec_PurchHdr: Record "Purchase Header");
    var
        lrec_PurchHdrAdd: Record "Purchase Header Additional FND";
        lrec_PurchLn: Record "Purchase Line";
        l_Text50000: TextConst ENU = 'For Document Type=Order, Document No - %1; Transfer Order No -%2 is partially shipped/received and must be changed manually';
    begin
        //HEI.60>>
        PurchSetup.GET();
        if (prec_PurchHdr.Status = prec_PurchHdr.Status::Open) then begin
            grec_TransShpmntHdr.RESET();
            grec_TransShpmntHdr.SETRANGE("PO Reference FND", prec_PurchHdr."No.");//BC Upgrade SHARMP16 -- Purchprocesstesting
            if grec_TransShpmntHdr.FINDFIRST() then begin
                //<<HEI.67
                //MESSAGE(l_Text50000, prec_PurchHdr."No.",grec_TransShpmntHdr."No.");
                if GUIALLOWED then
                    MESSAGE(l_Text50000, prec_PurchHdr."No.", grec_TransShpmntHdr."No.");
                //>>HEI.67
                exit;
            end else begin
                grec_TransHdrChkDel.RESET();
                grec_TransHdrChkDel.SETRANGE(grec_TransHdrChkDel."PO Reference FND", prec_PurchHdr."No.");
                if grec_TransHdrChkDel.FINDFIRST() then begin
                    lrec_PurchLn.RESET();
                    lrec_PurchLn.SETRANGE("Document Type", prec_PurchHdr."Document Type");
                    lrec_PurchLn.SETRANGE(lrec_PurchLn."Document No.", prec_PurchHdr."No.");
                    lrec_PurchLn.SETFILTER("TO Reference FND", '<>%1', '');
                    if lrec_PurchLn.findset() then
                        repeat
                            lrec_PurchLn."TO Reference FND" := '';
                            lrec_PurchLn.MODIFY();
                        until lrec_PurchLn.NEXT() = 0;
                    if (grec_TransHdrChkDel.Status = grec_TransHdrChkDel.Status::Released) then
                        CU_ReleaseTransDoc.Reopen(grec_TransHdrChkDel);
                    grec_TransHdrChkDel.DELETE(true);
                end;
            end;
        end else if (prec_PurchHdr.Status = prec_PurchHdr.Status::Released) then begin
            //Create a new TO
            MakeTO := false;
            grec_TransHdrChk.RESET();
            grec_TransHdrChk.SETRANGE(grec_TransHdrChk."PO Reference FND", prec_PurchHdr."No.");
            if grec_TransHdrChk.FINDFIRST() then begin
                exit;
            end;
            if lrec_PurchHdrAdd.GET(lrec_PurchHdrAdd."Document Type"::Order, prec_PurchHdr."No.") then begin
                if lrec_PurchHdrAdd."Import Identifier" then begin
                    lrec_PurchLn.RESET();
                    lrec_PurchLn.SETRANGE("Document Type", prec_PurchHdr."Document Type");
                    lrec_PurchLn.SETRANGE("Document No.", prec_PurchHdr."No.");
                    lrec_PurchLn.SETRANGE(Type, lrec_PurchLn.Type::Item);
                    if lrec_PurchLn.findset() then
                        repeat
                            if (lrec_PurchLn."Location Code" <> PurchSetup."Location Code Imp Proc. FND") then
                                MakeTO := true;
                        until (lrec_PurchLn.NEXT() = 0) or (MakeTO = true)
                    //HEI.75>>
                    else
                        MakeTO := true;
                    //HEI.75<<
                end else
                    MakeTO := true;
            end else
                MakeTO := true;
            if not MakeTO then
                CreateTOHdr(lrec_PurchLn, prec_PurchHdr);
        end;
        //HEI.60<<
    end;

    procedure CreateTOHdr(prec_PurchLn: Record "Purchase Line"; prec_PurchHeader: Record "Purchase Header");
    var
        lrecPurchHdrAdd: Record "Purchase Header Additional FND";
        Location: Record Location; //BC Upgrade SHARMP16
    begin
        CLEAR(grec_TransHdr);
        grec_InventorySetup.GET();
        PurchSetup.GET();
        NewToHdrNo := '';
        NoSeries.GET(grec_InventorySetup."Transfer Order Nos.");
        // NoSeriesMgt.InitSeries(NoSeries.Code, '', WORKDATE, NewToHdrNo, grec_InventorySetup."Transfer Order Nos."); // BC Upgrade NANDIS03
        NoSeriesCU.AreRelated(NoSeries.Code, grec_InventorySetup."Transfer Order Nos.");  // BC Upgrade NANDIS03
        grec_TransHdr.INIT();
        grec_TransHdr."No." := NewToHdrNo;
        grec_TransHdr.INSERT(true);
        grec_TransHdr.VALIDATE("Transfer-from Code", prec_PurchLn."Location Code");
        grec_TransHdr.VALIDATE("Transfer-to Code", prec_PurchHeader."Location Code");
        grec_TransHdr."PO Reference FND" := prec_PurchLn."Document No.";
        if lrecPurchHdrAdd.GET(prec_PurchHeader."Document Type"::Order, prec_PurchHeader."No.") then;
        grec_TransHdr.VALIDATE("Shipment Date", WORKDATE());//doubt
        grec_TransHdr.VALIDATE("Receipt Date", lrecPurchHdrAdd."Exp Physical Del Date(Imp)");
        //HEI.75>>
        grec_TransHdr.VALIDATE("Dimension Set ID", prec_PurchHeader."Dimension Set ID");
        if (prec_PurchHeader."Shortcut Dimension 2 Code" <> '') then
            grec_TransHdr.VALIDATE("Shortcut Dimension 2 Code", prec_PurchHeader."Shortcut Dimension 2 Code");
        //HEI.75<<
        Location.Reset();//BCUpgrade sharmp16--PurchProcesstestchanges
        Location.SetRange("Use As In-Transit", true);//BCUpgrade sharmp16--PurchProcesstestchanges
        if Location.FindFirst() then//BCUpgrade sharmp16--PurchProcesstestchanges
            grec_TransHdr."In-Transit Code" := Location.Code;//BCUpgrade sharmp16--PurchProcesstestchanges
        grec_TransHdr.MODIFY(true);
        CreteTOLn(grec_TransHdr, prec_PurchHeader);
    end;

    procedure CreteTOLn(prec_TrnsHdr: Record "Transfer Header"; prec_PurchHdrTO: Record "Purchase Header");
    var
        DimSetEntry: Record "Dimension Set Entry";
        lrec_Genledgsetup: Record "General Ledger Setup";
        lrecPurchaseLine: Record "Purchase Line";
        vendor: Record Vendor;
        NextLnNo: Integer;
    begin
        CLEAR(grec_TransLn);
        PurchSetup.GET();
        NextLnNo := 0;
        lrecPurchaseLine.RESET();
        lrecPurchaseLine.SETRANGE("Document Type", lrecPurchaseLine."Document Type"::Order);
        lrecPurchaseLine.SETRANGE("Document No.", prec_PurchHdrTO."No.");
        lrecPurchaseLine.SETRANGE(Type, lrecPurchaseLine.Type::Item);
        lrecPurchaseLine.SETRANGE(lrecPurchaseLine."Location Code", PurchSetup."Location Code Imp Proc. FND");
        if lrecPurchaseLine.findset() then
            repeat
                grec_TransLn.INIT();
                grec_TransLn."Document No." := prec_TrnsHdr."No.";
                grec_TransLn.SETRANGE(grec_TransLn."Document No.", prec_TrnsHdr."No.");
                if grec_TransLn.FINDLAST() then
                    NextLnNo := grec_TransLn."Line No." + 10000
                else
                    NextLnNo := 10000;
                grec_TransLn.VALIDATE("Line No.", NextLnNo);
                grec_TransLn.INSERT(true);
                grec_TransLn.VALIDATE("Item No.", lrecPurchaseLine."No.");
                //HEI.69>>
                grec_TransLn.VALIDATE("Unit of Measure Code", lrecPurchaseLine."Unit of Measure Code");
                //HEI.69<<
                grec_TransLn.VALIDATE(Quantity, lrecPurchaseLine.Quantity);
                //HEI.75>>
                grec_TransLn.VALIDATE("Dimension Set ID", lrecPurchaseLine."Dimension Set ID");
                if (lrecPurchaseLine."Shortcut Dimension 2 Code" <> '') then
                    grec_TransLn.VALIDATE("Shortcut Dimension 2 Code", lrecPurchaseLine."Shortcut Dimension 2 Code");
                //HEI.75<<
                grec_TransLn.VALIDATE("Receipt Date", lrecPurchaseLine."Exp Physical Del Date(Imp) FND");
                grec_TransLn.MODIFY(true);
                lrecPurchaseLine."TO Reference FND" := prec_TrnsHdr."No.";
                lrecPurchaseLine.MODIFY();
            until lrecPurchaseLine.NEXT() = 0;

        CODEUNIT.RUN(CODEUNIT::"Release Transfer Document", grec_TransHdr);
    end;

    //BC Upgrade SHARMP16 begin>>---------------- Interface code 
    //[EventSubscriber(ObjectType::Codeunit, 415, 'OnAfterReleasePurchaseDoc', '', false, false)]
    // local procedure CU415OnAfterReleasePurchDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean);
    // begin
    //     //HEI.111 >>
    //     IbecorCreatePORequest(PurchaseHeader, PreviewMode);
    //     //HEI.111 <<
    // end;
    //BC Upgrade SHARMP16 end<<---------------- Interface code 

    //BC UPgrade SHARMP16 begin<<--------------------------------- Interface Code
    // local procedure IbecorCreatePORequest(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean);
    // var
    //     //InterfaceSetup: Record "Interface Setup";//BC Upgrade SHARMP16 -- Interface Code
    //     // InterfaceEntryHeaderOut: Record "Interface Entry Header";//BC Upgrade SHARMP16 -- Interface Code
    //     // InterfaceEntryLineOut: Record "Interface Entry Line";//BC Upgrade SHARMP16 -- Interface Code
    //     lrec_Vend: Record Vendor;
    //     // lrec_IbecorData: Record "Ibecor PO Staging Data";//BC Upgrade SHARMP16-- Interface related table
    //     lrec_PurchLn: Record "Purchase Line";
    //     LineChanged: Boolean;
    //     // lrec_InterfaceLocationMatrix: Record "Interface Location Matrix";//BC Upgrade SHARMP16 -- Interface Code
    //     lrec_CompInfo: Record "Company Information";
    //     // IbecorInterfaceSetup: Record "Ibecor Interface Setup INT";//BC Upgrade SHARMP16 -- Interface Code
    //     GIdfromSetup: Code[20];
    //     // PFIHeader: Record "PFI Header";//BC Upgrade SHARMP16 -- Interface Code
    //     // PFILine: Record "PFI Lines";//BC Upgrade SHARMP16 -- Interface Code
    //     PurchaseHdrAdditional: Record "Purchase Header Additional FND";
    //     // PFIApproval: Record "PFI Approval FND";//BC Upgrade SHARMP16 -- Interface Code
    //     lrecGeneralLedgerSetup: Record "General Ledger Setup";
    //     lrecDimensionValue: Record "Dimension Value";
    //     //DocumentShippingCost: Record "Document Shipping Cost";//BC Upgrade SHARMP16-- Drink-It table.
    //     DocShippingAmount: Decimal;
    // begin
    //     //HEI.63>>
    //     if PurchaseHeader.ISTEMPORARY then
    //         exit;
    //     if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then
    //         exit;
    //     //HEI.89>>
    //     if PurchaseHdrAdditional.GET(PurchaseHeader."Document Type"::Order, PurchaseHeader."No.") then
    //         if (PurchaseHdrAdditional."PFI Document No." = '') then
    //             exit;
    //     //HEI.89<<
    //     //BC Upgrade SHARMP16--Interface Code begin<<
    //     // if not IbecorInterfaceSetup.GET then
    //     //     exit;
    //     // if not IbecorInterfaceSetup."Interface Enable/Disable" then
    //     //     exit;

    //     // if IbecorInterfaceSetup.GET and (IbecorInterfaceSetup."IBECOR API PO Notification" = '') then
    //     //     exit;
    //     // IbecorInterfaceSetup.TESTFIELD("IBECOR Vendor");
    //     // IbecorInterfaceSetup.TESTFIELD("IBECOR API PO Notification");
    //     //BC Upgrade SHARMP16--Interface Code end>>
    //     lrec_Vend.RESET;
    //     //lrec_Vend.SETRANGE("Global Vendor Number", IbecorInterfaceSetup."IBECOR Vendor");//BC Upgrade SHARMP16--Interface Code 
    //     if lrec_Vend.FINDFIRST then begin
    //         if not (PurchaseHeader."Buy-from Vendor No." = lrec_Vend."No.") then
    //             exit;
    //     end else
    //         exit;

    //     //Header insertion/modification
    //     lrec_CompInfo.GET;
    //     //BC Upgrade SHARMP16--Interface Code begin<<
    //     // lrec_IbecorData.RESET;
    //     // lrec_IbecorData.SETRANGE("Document Type", PurchaseHeader."Document Type");
    //     // lrec_IbecorData.SETRANGE("Document No", PurchaseHeader."No.");
    //     // if not lrec_IbecorData.FINDFIRST then begin
    //     //     lrec_IbecorData."Document Type" := PurchaseHeader."Document Type";
    //     //     lrec_IbecorData."Document No" := PurchaseHeader."No.";
    //     //     lrec_IbecorData."Buy from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
    //     //     lrec_IbecorData."Document Date" := PurchaseHeader."Document Date";
    //     //     lrec_IbecorData."Record Type" := lrec_IbecorData."Record Type"::Header;
    //     //     //HEI.128>>
    //     //     if PurchaseHdrAdditional.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") then begin
    //     //         if (PurchaseHdrAdditional."PFI Document No." <> '') then begin
    //     //             if PFIHeader.GET(PurchaseHdrAdditional."PFI Document No.") then begin
    //     //                 if lrec_InterfaceLocationMatrix.GET(IbecorInterfaceSetup."IBECOR Vendor", PurchaseHeader."Location Code", PFIHeader."Brewery ID") then
    //     //                     lrec_IbecorData."Opco Code" := lrec_InterfaceLocationMatrix."IBC Location Code";
    //     //             end;
    //     //         end;
    //     //     end;
    //     //        //BC Upgrade SHARMP16--Interface Code end>>
    //     //IF lrec_InterfaceLocationMatrix.GET(IbecorInterfaceSetup."IBECOR Vendor",PurchaseHeader."Location Code") THEN
    //     //  lrec_IbecorData."Opco Code" := lrec_InterfaceLocationMatrix."IBC Location Code";
    //     //HEI.128<<
    //     // lrec_IbecorData."Bill to Customer GID" := lrec_CompInfo."Legal Entity Code";        //BC Upgrade SHARMP16--Interface Code 
    //     //HEI.82>>
    //     DocShippingAmount := 0;
    //     //BC Upgrade SHARMP16--Drink-IT code begin>>
    //     // DocumentShippingCost.RESET;
    //     // DocumentShippingCost.SETRANGE("Source Type", DATABASE::"Purchase Header");
    //     // DocumentShippingCost.SETRANGE("Source No.", PurchaseHeader."No.");
    //     // DocumentShippingCost.SETRANGE("Sub Type", PurchaseHeader."Document Type");
    //     // if DocumentShippingCost.findset then
    //     //     repeat
    //     //         DocShippingAmount += DocumentShippingCost."Unit Cost";
    //     //     until DocumentShippingCost.NEXT = 0;
    //     //BC Upgrade SHARMP16--Drink-IT code end<<
    //     //HEI.82<<
    //     PurchaseHeader.CALCFIELDS("Amount Including VAT");
    //     //HEI.82>>
    //     //lrec_IbecorData.Amount := PurchaseHeader."Amount Including VAT";
    //     // lrec_IbecorData.Amount := PurchaseHeader."Amount Including VAT" + DocShippingAmount;  //BC Upgrade SHARMP16--Interface Code
    //     //HEI.82<<
    //     //lrec_IbecorData.Amount := PurchaseHeader."Amount Including VAT";//HEI.92
    //     //BC Upgrade SHARMP16--Interface Code begin<<
    //     // lrec_IbecorData."Currency Code" := PurchaseHeader."Currency Code";
    //     // lrec_IbecorData.Approver := PurchaseHeader."Last changed User ID";
    //     // lrec_IbecorData.Requestor := PurchaseHeader."Requester ID";
    //     // lrec_IbecorData."Posting Date" := PurchaseHeader."Posting Date";  //HEI.132
    //     // lrec_IbecorData."Document Date" := PurchaseHeader."Document Date";  //HEI.132
    //     // lrec_IbecorData."Delivery Date" := PurchaseHeader."Expected Receipt Date";
    //     // PFILine.RESET;
    //     // PFILine.SETRANGE("PO Number", PurchaseHeader."No.");
    //     // if PFILine.FINDFIRST then begin
    //     //     if PFIHeader.GET(PFILine."PFI Document No.") then begin
    //     //         lrec_IbecorData."Ibecor Dossier No" := PFIHeader."IBECOR Dossier No.";
    //     //         lrec_IbecorData."Logistics Officer" := PFIHeader."Logistics Officer";

    //     //     end;
    //     // end;
    //     // if PurchaseHdrAdditional.GET(PurchaseHeader."Document Type"::Order, PurchaseHeader."No.") then begin
    //     //     lrec_IbecorData."Ibecor Doc No." := PurchaseHdrAdditional."PFI Document No.";
    //     //     lrec_IbecorData."Credit Info Required" := PurchaseHdrAdditional."Credit Info Required";  //HEI.122
    //     //     lrec_IbecorData."Credit Number" := PurchaseHdrAdditional."Credit Number";
    //     //     lrec_IbecorData."Credit amount Of Supplier" := PurchaseHdrAdditional."Credit Amount Of supplier";
    //     //     lrec_IbecorData."Bank Of Organism Supplier" := PurchaseHdrAdditional."Bank Who Issued Credit";
    //     //     lrec_IbecorData."Last Date Of Shipment" := PurchaseHdrAdditional."Last Date Of Shipment";
    //     //     lrec_IbecorData."Credit Validity Of Supplier" := PurchaseHdrAdditional."Credit Validity Date";
    //     //     //HEI.111 >>
    //     //     lrec_IbecorData."License Required" := PurchaseHdrAdditional."License Required";  //HEI.122
    //     //     lrec_IbecorData."License Expiration Date" := PurchaseHdrAdditional."License Expiration Date";
    //     //     lrec_IbecorData."Bank Of Organism License" := PurchaseHdrAdditional."Bank who issued the License";
    //     //     lrec_IbecorData."Bank Reference Number" := PurchaseHdrAdditional."Bank Reference Number";
    //     //     lrec_IbecorData."CoD/CoC Number" := PurchaseHdrAdditional."CoD/CoC Number";
    //     //     //HEI.111 <<
    //     // end;
    //     // if (PurchaseHdrAdditional."PFI Document No." <> '') then begin
    //     //     PFIApproval.RESET;
    //     //     PFIApproval.SETRANGE(PFIApproval."PFI document No.", PurchaseHdrAdditional."PFI Document No.");
    //     //     if PFIApproval.FINDLAST then begin
    //     //         lrec_IbecorData."Comment with Date" := PFIApproval.Comments;
    //     //     end;
    //     // end;
    //     //BC Upgrade SHARMP16--Interface Code end>>
    //     PurchaseHeader.CALCFIELDS("License Code");
    //     if (PurchaseHeader."License Code" <> '') then begin
    //         //HEI.136>>
    //         //lrec_IbecorData."Licence Number" := PurchaseHeader."License Code";
    //         //  lrec_IbecorData."Licence Number" := PurchaseHdrAdditional."License Name"; //BC Upgrade SHARMP16--Interface Code 
    //         lrecGeneralLedgerSetup.GET;
    //         //HEI.111 >>
    //         //IF lrecDimensionValue.GET(lrecGeneralLedgerSetup."License Dimension Code FND",PurchaseHeader."License Code") THEN BEGIN
    //         //  lrec_IbecorData."License Expiration Date" := lrecDimensionValue."License Expiration Date";
    //         //  lrec_IbecorData."Bank Of Organism License" := lrecDimensionValue."Bank who issued the License";
    //         //end;
    //         //HEI.111 >>
    //     end;
    //     //BC Upgrade SHARMP16 -- Interface begin>>
    //     //     lrec_IbecorData."Movement Status" := lrec_IbecorData."Movement Status"::"Ready to Send";
    //     //     lrec_IbecorData.INSERT(true);
    //     //     TriggerAPINotification(lrec_IbecorData);
    //     // end else begin
    //     //         if CompareIbecorStagedData(lrec_IbecorData, PurchaseHeader) then begin
    //     //             lrec_IbecorData."Posting Date" := PurchaseHeader."Posting Date";
    //     //             lrec_IbecorData."Document Date" := PurchaseHeader."Document Date";
    //     //             lrec_IbecorData."Delivery Date" := PurchaseHeader."Expected Receipt Date";
    //     //             lrec_IbecorData."External Doc No" := PurchaseHeader."Your Reference";
    //     //             PurchaseHeader.CALCFIELDS("License Code");
    //     //             //HEI.136>>
    //     //             //lrec_IbecorData."Licence Number" := PurchaseHeader."License Code";
    //     //             lrec_IbecorData."Licence Number" := PurchaseHdrAdditional."License Name";
    //     //BC Upgrade SHARMP16 -- Interface Code end<<
    //     //HEI.136<<
    //     //HEI.82>>
    //     DocShippingAmount := 0;
    //     //BC Upgrade SHARMP16 -- Drink-IT 
    //     // DocumentShippingCost.RESET;
    //     // DocumentShippingCost.SETRANGE("Source Type", DATABASE::"Purchase Header");
    //     // DocumentShippingCost.SETRANGE("Source No.", PurchaseHeader."No.");
    //     // DocumentShippingCost.SETRANGE("Sub Type", PurchaseHeader."Document Type");
    //     // if DocumentShippingCost.findset then
    //     //     repeat
    //     //         DocShippingAmount += DocumentShippingCost."Unit Cost";
    //     //     until DocumentShippingCost.NEXT = 0;
    //     //BC Upgrade SHARMP16 -- Drink-IT 
    //     //HEI.82<<
    //     PurchaseHeader.CALCFIELDS("Amount Including VAT");
    //     //HEI.92>>
    //     //lrec_IbecorData.Amount := PurchaseHeader."Amount Including VAT";
    //     lrec_IbecorData.Amount := PurchaseHeader."Amount Including VAT" + DocShippingAmount;
    //     //HEI.92<<

    //     //HEI.128>>
    //     if PurchaseHdrAdditional.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") then begin
    //         if (PurchaseHdrAdditional."PFI Document No." <> '') then begin
    //             if PFIHeader.GET(PurchaseHdrAdditional."PFI Document No.") then begin
    //                 if lrec_InterfaceLocationMatrix.GET(IbecorInterfaceSetup."IBECOR Vendor", PurchaseHeader."Location Code", PFIHeader."Brewery ID") then
    //                     lrec_IbecorData."Opco Code" := lrec_InterfaceLocationMatrix."IBC Location Code";
    //             end;
    //         end;
    //     end;
    //     //IF lrec_InterfaceLocationMatrix.GET(IbecorInterfaceSetup."IBECOR Vendor",PurchaseHeader."Location Code") THEN
    //     //  lrec_IbecorData."Opco Code" := lrec_InterfaceLocationMatrix."IBC Location Code";
    //     //HEI.128<<
    //     lrec_IbecorData."Bill to Customer GID" := lrec_CompInfo."Legal Entity Code";
    //     //HEI.111 >>
    //     //IF lrecDimensionValue.GET(lrecGeneralLedgerSetup."License Dimension Code FND",PurchaseHeader."License Code") THEN BEGIN
    //     //  lrec_IbecorData."License Expiration Date" := lrecDimensionValue."License Expiration Date";
    //     //  lrec_IbecorData."Bank Of Organism License" := lrecDimensionValue."Bank who issued the License";
    //     //end;
    //     //HEI.111 <<
    //     if PurchaseHdrAdditional.GET(PurchaseHeader."Document Type"::Order, PurchaseHeader."No.") then begin
    //         lrec_IbecorData."Credit Info Required" := PurchaseHdrAdditional."Credit Info Required";  //HEI.122
    //         lrec_IbecorData."Credit Number" := PurchaseHdrAdditional."Credit Number";
    //         lrec_IbecorData."Credit amount Of Supplier" := PurchaseHdrAdditional."Credit Amount Of supplier";
    //         lrec_IbecorData."Bank Of Organism Supplier" := PurchaseHdrAdditional."Bank Who Issued Credit";
    //         lrec_IbecorData."Last Date Of Shipment" := PurchaseHdrAdditional."Last Date Of Shipment";
    //         lrec_IbecorData."Credit Validity Of Supplier" := PurchaseHdrAdditional."Credit Validity Date";
    //         //HEI.111 >>
    //         lrec_IbecorData."License Required" := PurchaseHdrAdditional."License Required";  //HEI.122
    //         lrec_IbecorData."License Expiration Date" := PurchaseHdrAdditional."License Expiration Date";
    //         lrec_IbecorData."Bank Of Organism License" := PurchaseHdrAdditional."Bank who issued the License";
    //         lrec_IbecorData."Bank Reference Number" := PurchaseHdrAdditional."Bank Reference Number";
    //         lrec_IbecorData."CoD/CoC Number" := PurchaseHdrAdditional."CoD/CoC Number";
    //         //HEI.111 <<
    //     end;
    //     lrec_IbecorData."Movement Status" := lrec_IbecorData."Movement Status"::"Ready to Send";
    //     lrec_IbecorData.MODIFY;
    //     TriggerAPINotification(lrec_IbecorData);
    // end;
    //     end;
    //     //HEI.63<<
    // end;

    //BC UPgrade SHARMP16 end<<--------------------------------- Interface Code


    //BC Upgrade SHARMP16 begin>>---------Interface code

    // local procedure CompareIbecorStagedData(prec_IbecorData: Record "Ibecor PO Staging Data"; prec_PurchaseHeader: Record "Purchase Header"): Boolean;
    // var
    //     lrecDimensionValue: Record "Dimension Value";
    //     StoreLicExpDate: Date;
    //     StoreBankIssueLic: Text[50];
    //     lrecGeneralLedgerSetup: Record "General Ledger Setup";
    //     PurchaseHdrAdditional: Record "Purchase Header Additional FND";
    //     StoreCreditNumber: Code[20];
    //     StoreCreditAmount: Decimal;
    //     StoreBankSupplier: Text[50];
    //     StoreLastDOShipment: Date;
    //     StoreCreditValidityDate: Date;
    //     StoreOpcoCode: Code[20];
    //     lrec_InterfaceLocationMatrix: Record "Interface Location Matrix";
    //     IbecorInterfaceSetup: Record "Ibecor Interface Setup INT";
    //     DocumentShippingCost: Record "Document Shipping Cost";
    //     DocShippingAmount: Decimal;
    //     AmounttoCompare: Decimal;
    //     PurchHeaderRecpt: Record "Purch. Rcpt. Header";
    // begin
    //     //HEI.63>>
    //     /*//HEI.150>>
    //     prec_PurchaseHeader.CALCFIELDS("License Code");
    //     prec_PurchaseHeader.CALCFIELDS("Amount Including VAT");
    //     //HEI.82>>
    //     DocShippingAmount := 0;
    //     DocumentShippingCost.RESET;
    //     DocumentShippingCost.SETRANGE("Source Type",DATABASE::"Purchase Header");
    //     DocumentShippingCost.SETRANGE("Source No.",prec_PurchaseHeader."No.");
    //     DocumentShippingCost.SETRANGE("Sub Type",prec_PurchaseHeader."Document Type");
    //     IF DocumentShippingCost.findset THEN REPEAT
    //       DocShippingAmount += DocumentShippingCost."Unit Cost";
    //     UNTIL DocumentShippingCost.NEXT = 0;
    //     AmounttoCompare := prec_PurchaseHeader."Amount Including VAT" + DocShippingAmount;
    //     //HEI.82<<
    //     lrecGeneralLedgerSetup.GET;
    //     IbecorInterfaceSetup.GET;
    //     IF lrecDimensionValue.GET(lrecGeneralLedgerSetup."License Dimension Code FND",prec_PurchaseHeader."License Code") THEN BEGIN
    //       StoreLicExpDate := lrecDimensionValue."License Expiration Date";
    //       StoreBankIssueLic := lrecDimensionValue."Bank who issued the License";
    //     end;
    //     IF PurchaseHdrAdditional.GET(prec_PurchaseHeader."Document Type"::Order,prec_PurchaseHeader."No.") THEN BEGIN
    //       StoreCreditNumber := PurchaseHdrAdditional."Credit Number";
    //       StoreCreditAmount := PurchaseHdrAdditional."Credit Amount Of supplier";
    //       StoreBankSupplier := PurchaseHdrAdditional."Bank Who Issued Credit";
    //       StoreLastDOShipment := PurchaseHdrAdditional."Last Date Of Shipment";
    //       StoreCreditValidityDate := PurchaseHdrAdditional."Credit Validity Date";
    //     end;
    //     //IF lrec_InterfaceLocationMatrix.GET(IbecorInterfaceSetup."IBECOR Vendor",prec_PurchaseHeader."Location Code") THEN  //HEI.128
    //     IF lrec_InterfaceLocationMatrix.GET(IbecorInterfaceSetup."IBECOR Vendor",prec_PurchaseHeader."Location Code",prec_IbecorData."Opco Code") THEN  //HEI.128
    //       StoreOpcoCode := lrec_InterfaceLocationMatrix."IBC Location Code";

    //     //HEI.144>>
    //       PurchHeaderRecpt.RESET;
    //       PurchHeaderRecpt.SETCURRENTKEY("Order No.");
    //       PurchHeaderRecpt.SETRANGE("Order No.",PurchaseHdrAdditional."No.");
    //       IF PurchHeaderRecpt.ISEMPTY THEN
    //         IF prec_IbecorData.Amount <> AmounttoCompare THEN
    //            EXIT(TRUE);
    //     //HEI.144<<

    //     CASE TRUE OF
    //       //HEI.82>>
    //       //prec_IbecorData.Amount <> prec_PurchaseHeader."Amount Including VAT" : EXIT(TRUE);
    //       //prec_IbecorData.Amount <> AmounttoCompare : EXIT(TRUE); //HEI.144
    //       //HEI.82<<
    //       //prec_IbecorData."Posting Date" <> prec_PurchaseHeader."Posting Date" : EXIT(TRUE);  //HEI.132
    //       //prec_IbecorData."Document Date" <> prec_PurchaseHeader."Document Date" : EXIT(TRUE);  //HEI.132
    //       //prec_IbecorData."Delivery Date" <> prec_PurchaseHeader."Expected Receipt Date" : EXIT(TRUE);  //HEI.132
    //       //(prec_IbecorData."Posting Date" <> 0D) AND (prec_IbecorData."Posting Date" <> prec_PurchaseHeader."Posting Date") : EXIT(TRUE);  //HEI.132 //HEI.136
    //       (prec_IbecorData."Document Date" <> 0D) AND (prec_IbecorData."Document Date" <> prec_PurchaseHeader."Document Date") : EXIT(TRUE);  //HEI.132
    //       //(prec_IbecorData."Delivery Date" <> 0D) AND (prec_IbecorData."Delivery Date" <> prec_PurchaseHeader."Expected Receipt Date") : EXIT(TRUE);  //HEI.132 //HEI.136
    //       prec_IbecorData."External Doc No" <> prec_PurchaseHeader."Your Reference" : EXIT(TRUE);
    //       //HEI.136>>
    //       //prec_IbecorData."Licence Number" <> prec_PurchaseHeader."License Code" : EXIT(TRUE);
    //       prec_IbecorData."Licence Number" <> PurchaseHdrAdditional."License Name" : EXIT(TRUE);
    //       //HEI.136<<
    //       prec_IbecorData."License Expiration Date"<> StoreLicExpDate : EXIT(TRUE);
    //       prec_IbecorData."Bank Of Organism License" <> StoreBankIssueLic : EXIT(TRUE);
    //       //prec_IbecorData."Credit Number" <> StoreCreditNumber : EXIT(TRUE);  //HEI.131
    //       //prec_IbecorData."Credit amount Of Supplier" <> StoreCreditAmount : EXIT(TRUE);  //HEI.131
    //       //prec_IbecorData."Bank Of Organism Supplier" <> StoreBankSupplier : EXIT(TRUE);  //HEI.131
    //       //prec_IbecorData."Last Date Of Shipment" <> StoreLastDOShipment : EXIT(TRUE);  //HEI.131
    //       //prec_IbecorData."Credit Validity Of Supplier" <> StoreCreditValidityDate : EXIT(TRUE);  //HEI.131
    //       (prec_IbecorData."Credit Number" <> StoreCreditNumber) AND (PurchaseHdrAdditional."Credit Info Required") : EXIT(TRUE);  //HEI.131
    //       (prec_IbecorData."Credit amount Of Supplier" <> StoreCreditAmount) AND (PurchaseHdrAdditional."Credit Info Required") : EXIT(TRUE);  //HEI.131
    //       (prec_IbecorData."Bank Of Organism Supplier" <> StoreBankSupplier) AND (PurchaseHdrAdditional."Credit Info Required") : EXIT(TRUE);  //HEI.131
    //       (prec_IbecorData."Last Date Of Shipment" <> StoreLastDOShipment) AND (PurchaseHdrAdditional."Credit Info Required") : EXIT(TRUE);  //HEI.131
    //       (prec_IbecorData."Credit Validity Of Supplier" <> StoreCreditValidityDate) AND (PurchaseHdrAdditional."Credit Info Required") : EXIT(TRUE);  //HEI.131
    //       //prec_IbecorData."Opco Code" <> StoreOpcoCode : EXIT(TRUE);  //HEI.130
    //       //HEI.111 >>
    //       //prec_IbecorData."Bank Reference Number" <> PurchaseHdrAdditional."Bank Reference Number" : EXIT(TRUE);  //HEI.131
    //       (prec_IbecorData."Bank Reference Number" <> PurchaseHdrAdditional."Bank Reference Number") AND (PurchaseHdrAdditional."Credit Info Required") : EXIT(TRUE);  //HEI.131
    //       prec_IbecorData."CoD/CoC Number" <> PurchaseHdrAdditional."CoD/CoC Number" : EXIT(TRUE);
    //       //HEI.111 <<
    //     end;
    //     */
    //     if PurchaseHdrAdditional.GET(prec_PurchaseHeader."Document Type"::Order, prec_PurchaseHeader."No.") then begin
    //         // CASE TRUE OF //HEI.151
    //         //HEI.153>>
    //         if PurchaseHdrAdditional."Credit Info Required" = true then begin
    //             //CASE PurchaseHdrAdditional."Credit Info Required" OF //HEI.151
    //             case true of
    //                 //HEI.153<<
    //                 prec_IbecorData."Credit Info Required" <> PurchaseHdrAdditional."Credit Info Required":
    //                     exit(true);
    //                 prec_IbecorData."Credit Number" <> PurchaseHdrAdditional."Credit Number":
    //                     exit(true);
    //                 prec_IbecorData."Credit amount Of Supplier" <> PurchaseHdrAdditional."Credit Amount Of supplier":
    //                     exit(true);
    //                 prec_IbecorData."Bank Of Organism Supplier" <> PurchaseHdrAdditional."Bank Who Issued Credit":
    //                     exit(true);
    //                 prec_IbecorData."Last Date Of Shipment" <> PurchaseHdrAdditional."Last Date Of Shipment":
    //                     exit(true);
    //                 prec_IbecorData."Credit Validity Of Supplier" <> PurchaseHdrAdditional."Credit Validity Date":
    //                     exit(true);
    //                 prec_IbecorData."Bank Reference Number" <> PurchaseHdrAdditional."Bank Reference Number":
    //                     exit(true); //HEI.151
    //             end; //HEI.151
    //         end; //HEI.153
    //         case true of //HEI.151
    //             prec_IbecorData."License Required" <> PurchaseHdrAdditional."License Required":
    //                 exit(true);
    //             prec_IbecorData."Licence Number" <> PurchaseHdrAdditional."License Name":
    //                 exit(true);
    //             prec_IbecorData."License Expiration Date" <> PurchaseHdrAdditional."License Expiration Date":
    //                 exit(true);
    //             prec_IbecorData."Bank Of Organism License" <> PurchaseHdrAdditional."Bank who issued the License":
    //                 exit(true);
    //             //prec_IbecorData."Bank Reference Number" <> PurchaseHdrAdditional."Bank Reference Number": EXIT(TRUE);
    //             prec_IbecorData."CoD/CoC Number" <> PurchaseHdrAdditional."CoD/CoC Number":
    //                 exit(true);
    //         end;
    //     end;
    //     exit(false);
    //     //HEI.150<<
    //     //HEI.63<<

    // end;

    //BC Upgrade SHARMP16 end<<---------Interface code


    //BC Upgrade SHARMP16 begin>>---------Interface code
    // [EventSubscriber(ObjectType::Table, 38, 'OnAfterDeleteEvent', '', false, false)]
    // local procedure T38OnDeletePurchHeader(var Rec: Record "Purchase Line"; RunTrigger: Boolean);
    // var
    //     PurchaseHeaderAddtnl: Record "Purchase Header Additional FND";
    //     PFILine: Record "PFI Lines";
    // begin
    //     //HEI.63>>
    //     if Rec.ISTEMPORARY then
    //         exit;
    //     if (Rec."Document Type" <> Rec."Document Type"::Order) then
    //         exit;
    //     if PurchaseHeaderAddtnl.GET(Rec."Document Type", Rec."Document No.") then begin
    //         if (PurchaseHeaderAddtnl."PFI Document No." <> '') then begin
    //             PFILine.RESET;
    //             PFILine.SETRANGE("PFI Document No.", PurchaseHeaderAddtnl."PFI Document No.");
    //             PFILine.SETRANGE("PO Number", Rec."Document No.");
    //             if PFILine.findset then
    //                 PFILine.MODIFYALL("PO Number", '');
    //             PurchaseHeaderAddtnl."PFI Document No." := '';
    //             PurchaseHeaderAddtnl.MODIFY;
    //         end else
    //             exit;
    //     end;
    //     //HEI.63<<
    // end;
    //BC Upgrade SHARMP16 end<<---------Interface code

    //BC Upgrade SHARMP16 begin>>---------Interface code
    // local procedure TriggerAPINotification(prec_IbecorStagedData: Record "Ibecor PO Staging Data");
    // var
    //     InterfaceSetup: Record "Interface Setup";
    //     InterfaceEntryHeaderOut: Record "Interface Entry Header";
    //     IbecorIntrfcSetup: Record "Ibecor Interface Setup INT";
    //     CompanyInformation: Record "Company Information";
    //     InterfaceLocationMatrix: Record "Interface Location Matrix";
    //     lrecPurchHdr: Record "Purchase Header";
    //     lrecVend: Record Vendor;
    //     InterLogHeader: Record "Interface Log Header";
    // begin
    //     //HEI.63>>
    //     CompanyInformation.GET;
    //     if not IbecorIntrfcSetup.GET then
    //         exit;
    //     InterfaceSetup.GET(IbecorIntrfcSetup."IBECOR API PO Notification");
    //     if not InterfaceSetup.Enabled then
    //         exit;

    //     CLEAR(InterfaceEntryHeaderOut);
    //     InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
    //     InterfaceEntryHeaderOut."Interface Code" := IbecorIntrfcSetup."IBECOR API PO Notification";
    //     InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
    //     InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
    //     InterfaceEntryHeaderOut."Legal Entity" := CompanyInformation."Legal Entity Code";
    //     InterfaceEntryHeaderOut."Source No." := prec_IbecorStagedData."Document No";
    //     //HEI.82>>
    //     if lrecPurchHdr.GET(lrecPurchHdr."Document Type"::Order, prec_IbecorStagedData."Document No") then
    //         if lrecVend.GET(lrecPurchHdr."Buy-from Vendor No.") then
    //             //IF InterfaceLocationMatrix.GET(lrecVend."Global Vendor Number",lrecPurchHdr."Location Code") THEN BEGIN  //HEI.128
    //             if InterfaceLocationMatrix.GET(lrecVend."Global Vendor Number", lrecPurchHdr."Location Code", prec_IbecorStagedData."Opco Code") then begin  //HEI.128
    //                 InterfaceEntryHeaderOut."Sell-to Customer No." := InterfaceLocationMatrix."Heilite Location Code";
    //                 InterfaceEntryHeaderOut."Pay-to Vendor No." := InterfaceLocationMatrix."IBC Location Code";
    //             end;
    //     //HEI.82<<
    //     InterfaceEntryHeaderOut."External Document No." := 'IBECOR';
    //     InterfaceEntryHeaderOut."Posting Date" := WORKDATE;
    //     //HEI.112 >>
    //     InterfaceEntryHeaderOut."Action Code" := '01';
    //     InterLogHeader.SETRANGE("Interface Code", IbecorIntrfcSetup."IBECOR API PO Notification");
    //     InterLogHeader.SETRANGE(Direction, InterfaceEntryHeaderOut.Direction::Outbound);
    //     InterLogHeader.SETRANGE("Legal Entity", CompanyInformation."Legal Entity Code");
    //     InterLogHeader.SETRANGE("Source No.", prec_IbecorStagedData."Document No");
    //     if not InterLogHeader.ISEMPTY then
    //         InterfaceEntryHeaderOut."Action Code" := '02';
    //     //HEI.112 <<
    //     InterfaceEntryHeaderOut.INSERT(true);
    //     //HEI.63<<
    // end;
    //BC Upgrade SHARMP16 end<<---------Interface code

    [EventSubscriber(ObjectType::Table, 38, 'OnBeforeValidateEvent', 'Location Code', false, false)]
    local procedure T38OnBeforeModifyLocationCode(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchaseLine: Record "Purchase Line";
    begin
        //>> HEI.59
        GetPurchSetup();
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            if PurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") then begin
                if not CheckShippingMethod(PurchSetup, Rec) then begin
                    if Rec.Status = Rec.Status::Released then
                        ERROR(Text0007);
                    if PurchaseHeaderAdditional."Import Identifier" = false then
                        if Rec."Location Code" = PurchSetup."Location Code Imp Proc. FND" then
                            ERROR(Text0006, Rec."Location Code");
                end;
            end;
        end;
        //<< HEI.59
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnBeforeValidateEvent', 'Location Code', false, false)]
    local procedure T39OnBeforeModifyLocationCode(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchaseLine: Record "Purchase Line";
    begin
        //>> HEI.59
        GetPurchSetup();
        if PurchaseHeader.GET(Rec."Document Type", Rec."Document No.") then begin
            if Rec."Document Type" = Rec."Document Type"::Order then begin
                if PurchaseHeaderAdditional.GET(Rec."Document Type", Rec."Document No.") then begin
                    if not CheckShippingMethod(PurchSetup, PurchaseHeader) then begin
                        if PurchaseHeaderAdditional."Import Identifier" = false then
                            if Rec."Location Code" = PurchSetup."Location Code Imp Proc. FND" then
                                ERROR(Text0006, Rec."Location Code");
                    end;
                end;
            end;
        end;
        //<< HEI.59
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Qty. to Receive', false, false)]
    local procedure T39OnBeforeValidateQtyToReceive(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        //>> HEI.59
        GetPurchSetup();
        if PurchaseHeader.GET(Rec."Document Type", Rec."Document No.") then begin
            if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::"Blanket Order" then
                exit;
            if PurchaseHeader."Channel FND" = 'D' then
                exit;
            if not CheckShippingMethod(PurchSetup, PurchaseHeader) then begin
                if Rec."Consumption Location Code FND" <> PurchSetup."Location Code Imp Proc. FND" then
                    ERROR(Text0006, Rec."Consumption Location Code FND")
            end else
                if Rec."Consumption Location Code FND" = PurchSetup."Location Code Imp Proc. FND" then
                    ERROR(Text0008, Rec."Consumption Location Code FND");
        end;
        //<< HEI.59
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure T38OnBeforeDeleteForPOandReturnPO(var Rec: Record "Purchase Header"; RunTrigger: Boolean);
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchLine: Record "Purchase Line";
        TransferHeader: Record "Transfer Header";
        UserSetUp: Record "User Setup";
        PurchHeaderFresh: Record "Purchase Header";
    begin
        //>>HEI.68
        if Rec.ISTEMPORARY then
            exit;

        //HEI.125>>
        if GuiAllowed() and (Rec."Document Type" = Rec."Document Type"::Order) then
            if PurchHeaderFresh.Get(Rec."Document Type", Rec."No.") then
                Rec := PurchHeaderFresh;//BC Upgrade SHARMP16 08072026 defect fix

        if PurchaseHeaderAdditional.GET(Rec."Document Type"::Order, Rec."No.") then begin
            if PurchaseHeaderAdditional."Deletion From Doc Shipping" then
                exit;
        end;
        //HEI.125<<

        if (Rec."Document Type" = Rec."Document Type"::Order) or (Rec."Document Type" = Rec."Document Type"::"Return Order") then begin
            if gRecUserSetUp.GET(USERID) then begin
                if not gRecUserSetUp."Allow Delete/Arc PO/Return FND" then
                    ERROR(UnauthorizedDeletionOfPO, Rec."No.")
            end else
                ERROR(UnauthorizedUser, USERID);
        end;
        //<<HEI.68
        //HEI.106 >>
        //HEI.109 >>
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            Rec.CALCFIELDS("TO Reference FND");
            if Rec."TO Reference FND" <> '' then begin
                PurchLine.SETRANGE("Document Type", Rec."Document Type");
                PurchLine.SETRANGE("Document No.", Rec."No.");
                PurchSetup.FILTERGROUP(-1);
                PurchLine.SETFILTER("Quantity Received", '>0');
                PurchLine.SETFILTER("Quantity Invoiced", '>0');
                if PurchLine.ISEMPTY then
                    Rec.TESTFIELD(Status, Rec.Status::Open);
            end;
        end;
        //HEI.109 >>
        //HEI.106 <<
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure T38OnBeforeDeleteForBPO(var Rec: Record "Purchase Header"; RunTrigger: Boolean);
    var
        UserSetUp: Record "User Setup";
    begin
        //>>HEI.68
        if Rec.ISTEMPORARY then
            exit;
        if Rec."Document Type" = Rec."Document Type"::"Blanket Order" then begin
            ERROR(UnauthorizedDeletionOfBPO, Rec."No.")
        end;
        //<<HEI.68
    end;

    local procedure CheckRPMItemOnLine(var PurchaseLine: Record "Purchase Line");
    var
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        PurchaseHeader: Record "Purchase Header";
        ServiceItemGroup: Record "Service Item Group";
        Text0001: Label '"Item %1 cannot be used in %2. Item''s Inventory Value Zero value must be true, Item Tracking Code must be FA Related and Service Item Group must have Create Fixed Asset value true! "';
    begin
        //>> HEI.72
        if PurchaseLine."No." = '' then
            exit;

        if PurchaseHeader.GET(PurchaseLine."Document Type", PurchaseLine."Document No.") then
            if PurchaseHeader."Fixed Asset Acquisition FND" = true then begin
                if PurchaseLine.Type = PurchaseLine.Type::Item then begin
                    if Item.GET(PurchaseLine."No.") then
                        if Item."Inventory Value Zero" = true then begin
                            if ItemTrackingCode.GET(Item."Item Tracking Code") then begin
                                if ServiceItemGroup.GET(Item."Service Item Group") then;
                                //BC Upgrade SHARMP16 begin>> ---Create Fixed Asset Drink-It field
                                // if (ItemTrackingCode."FA Related" = true) and (ServiceItemGroup."Create Fixed Asset" = true) then
                                //     exit
                                // else
                                // ERROR(Text0001, PurchaseLine."No.", PurchaseLine."Document No.");
                                //BC Upgrade SHARMP16 end<< ---Create Fixed Asset Drink-It field

                            end;
                        end else
                            ERROR(Text0001, PurchaseLine."No.", PurchaseLine."Document No.");
                end;
            end;
        //<< HEI.72
    end;

    local procedure IsRPMItem(var PurchaseLine: Record "Purchase Line"): Boolean;
    var
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        PurchaseHeader: Record "Purchase Header";
        ServiceItemGroup: Record "Service Item Group";
        Text0001: Label '"Item %1 cannot be used in %2. Item''s Inventory Value Zero value must be true, Item Tracking Code must be FA Related and Service Item Group must have Create Fixed Asset value true! "';
    begin
        //>> HEI.72
        if PurchaseLine."No." = '' then
            exit;

        if PurchaseHeader.GET(PurchaseLine."Document Type", PurchaseLine."Document No.") then
            if PurchaseLine.Type = PurchaseLine.Type::Item then begin
                if Item.GET(PurchaseLine."No.") then
                    if Item."Inventory Value Zero" = true then begin
                        if ItemTrackingCode.GET(Item."Item Tracking Code") then begin
                            if ServiceItemGroup.GET(Item."Service Item Group") then;
                            //BC Upgrade SHARMP16 begin>> --Drink-IT field Create Fixed Asset
                            // if (ItemTrackingCode."FA Related" = true) and (ServiceItemGroup."Create Fixed Asset" = true) then
                            //     exit(true)
                            // else
                            //     exit(false);
                            //BC Upgrade SHARMP16 end<<--Drink-IT field Create Fixed Asset
                        end;

                    end;
            end;
        //<< HEI.72
    end;

    local procedure CheckIfPurchaseLinesValidForFAAcquisition(var varPurchaseLine: Record "Purchase Line"): Boolean;
    var
        PurchaseLine: Record "Purchase Line";
    begin
        //>> hei.72
        PurchaseLine.SETRANGE("Document Type", varPurchaseLine."Document Type");
        PurchaseLine.SETRANGE("Document No.", varPurchaseLine."Document No.");
        if PurchaseLine.findset() then begin
            repeat
                if PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset" then begin
                    exit(true);
                end else
                    if PurchaseLine.Type = PurchaseLine.Type::Item then begin
                        if IsRPMItem(PurchaseLine) then
                            exit(true);
                    end else
                        exit(false);
            until PurchaseLine.NEXT() = 0;
        end;
        //<< HEI.72
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure T39OnAfterValidateNoRPM(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        //>> hei.72
        if Rec.ISTEMPORARY then
            exit;

        GetPurchSetup();
        if PurchSetup."Enable FA Vendor Req. FND" then begin
            PurchaseHeader.GET(Rec."Document Type", Rec."Document No.");
            if PurchaseHeader."Fixed Asset Acquisition FND" = true then begin
                CheckRPMItemOnLine(Rec);
            end;
        end;
        //<< hei.72
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnCheckPurchaseReleaseRestrictions', '', false, false)]
    local procedure OnCheckPurchReleaseRestrictions(var Sender: Record "Purchase Header");
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        //Hei.79 >>
        /*
        //HEI.73>>
        IF Sender.ISTEMPORARY THEN
          EXIT;
        
        //INC3697111>>
        //IF Sender."SRM Order No. FND" = '' THEN
        IF (Sender."SRM Order No. FND" = '') AND (Sender."Maximo Requisition No." = '') THEN
        //INC3697111<<
          ApprovalsMgmt.PrePostApprovalCheckPurch(Sender);
        //HEI.73<<
        */
        //Hei.79 <<

    end;

    procedure UpdateLicenseCodeDimension(LicenseCode: Code[20]; var DimensionSetID: Integer);
    var
        DimensionSetEntry: Record "Dimension Set Entry";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionManagement: Codeunit DimensionManagement;
    begin
        //HEI.78>>
        GeneralLedgerSetup.GET();

        if GeneralLedgerSetup."License Dimension Code FND" <> '' then
            if LicenseCode <> '' then begin
                DimensionSetEntry.RESET();
                DimensionSetEntry.SETRANGE("Dimension Set ID", DimensionSetID);
                DimensionSetEntry.SETRANGE("Dimension Code", GeneralLedgerSetup."License Dimension Code FND");
                if not DimensionSetEntry.FINDFIRST() then begin
                    CLEAR(TempDimensionSetEntry);
                    DimensionManagement.GetDimensionSet(TempDimensionSetEntry, DimensionSetID);
                    TempDimensionSetEntry.INIT();
                    TempDimensionSetEntry."Dimension Code" := GeneralLedgerSetup."License Dimension Code FND";
                    TempDimensionSetEntry."Dimension Value Code" := LicenseCode;
                    if TempDimensionSetEntry.INSERT(true) then;
                    DimensionSetID := DimensionManagement.GetDimensionSetID(TempDimensionSetEntry);
                end;
            end;
        //HEI.78<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterInsertEvent', '', false, false)]
    local procedure T39OnAfterInsertLine(var Rec: Record "Purchase Line"; RunTrigger: Boolean);
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine2: Record "Purchase Line";
        VendorSPL: Record "Vendor SPL Relation FND";
    begin
        //HEI.80>>
        PurchSetup.GET();
        if PurchSetup."Enable FA Vendor Req. FND" then
            if Rec."Document Type" <> Rec."Document Type"::"Blanket Order" then begin//HEI.87
                if Rec.Type = Rec.Type::"Fixed Asset" then begin
                    PurchaseHeader.GET(Rec."Document Type", Rec."Document No.");
                    if not PurchaseHeader."Fixed Asset Acquisition FND" then begin
                        PurchaseHeader."Fixed Asset Acquisition FND" := true;
                        PurchaseHeader.MODIFY();
                    end;
                end else
                    if Rec.Type = Rec.Type::Item then
                        PurchaseHeader.GET(Rec."Document Type", Rec."Document No.");
                if not PurchaseHeader."Fixed Asset Acquisition FND" then begin
                    if IsRPMItem(Rec) then begin
                        PurchaseHeader."Fixed Asset Acquisition FND" := true;
                        PurchaseHeader.MODIFY();
                    end;
                end;
            end;//HEI.87
        //HEI.80<<

        //HEI.110 <<
        //HEI.120 >>
        PurchSetup.GET();
        if not Rec.ISTEMPORARY and (Rec.Type = Rec.Type::Item) and PurchSetup."SPL Active FND" then begin //HEI.113
                                                                                                          //HEI.120 <<
                                                                                                          //HEI.118 >>
                                                                                                          //IF (Rec."Document Type" = Rec."Document Type"::"Blanket Order") OR
                                                                                                          //   (Rec."Document Type" = Rec."Document Type"::Quote) THEN BEGIN
                                                                                                          //  Rec.SetDefaultSPLCode();
                                                                                                          //  Rec.MODIFY;
                                                                                                          //end else
                                                                                                          //HEI.118 <<
            if Rec."Document Type" = Rec."Document Type"::Order then begin
                if Rec."Blanket Order No." <> '' then begin
                    PurchaseLine2.RESET();
                    if PurchaseLine2.GET(Rec."Document Type"::"Blanket Order", Rec."Blanket Order No.", Rec."Blanket Order Line No.") then begin
                        //HEI.118 >>
                        if PurchaseLine2."Consumption SPL Code FND" <> '' then
                            if VendorSPL.GET(PurchaseLine2."Buy-from Vendor No.", PurchaseLine2."Consumption SPL Code FND") then begin
                                Rec."SPL Code FND" := PurchaseLine2."Consumption SPL Code FND";
                                Rec."SPL Name FND" := VendorSPL.Name;
                            end;

                        if Rec."SPL Code FND" = '' then
                            if VendorSPL.GET(PurchaseLine2."Buy-from Vendor No.", PurchaseLine2."SPL Code FND") then begin
                                Rec."SPL Code FND" := PurchaseLine2."SPL Code FND";
                                Rec."SPL Name FND" := VendorSPL.Name;
                            end;

                        Rec.MODIFY();
                        //HEI.118<<
                    end;
                    //HEI.113 >>
                end;
                //HEI.118 >>
                //IF Rec."SPL Code FND" = '' THEN
                //  Rec.SetDefaultSPLCode();

                //Rec."Consumption SPL Code FND" := '';
                //Rec.MODIFY;
                //HEI.118 <<
                //end;
                //HEI.113 <<
            end;
        end;
        //HEI.110 <<
    end;

    procedure UpdatePONoinPostedInvoice(PurchHeader: Record "Purchase Header"; PurchInvHeaderNo: Code[20]);
    var
        PurchInvHdr: Record "Purch. Inv. Header";
        PurchInvLn: Record "Purch. Inv. Line";
        PurchRcptHdr: Record "Purch. Rcpt. Header";
    begin
        //HEI.84>>
        if (PurchHeader."Document Type" <> PurchHeader."Document Type"::Invoice) then
            exit;
        if (PurchInvHeaderNo <> '') then begin
            if PurchInvHdr.GET(PurchInvHeaderNo) then begin
                PurchInvLn.SETRANGE("Document No.", PurchInvHdr."No.");
                PurchInvLn.SETFILTER("Receipt No.", '<>%1', '');
                if PurchInvLn.findset() then
                    repeat
                        if PurchRcptHdr.GET(PurchInvLn."Receipt No.") then begin
                            if (PurchRcptHdr."Order No." <> '') then begin
                                PurchInvLn."Purchase Order No. FND" := PurchRcptHdr."Order No.";
                                PurchInvLn.MODIFY();
                            end;
                        end;
                    until PurchInvLn.NEXT() = 0;
            end;
        end;
        //HEI.84<<
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterPostPurchaseDoc', '', false, false)]
    local procedure UpdateAssignUserIDAfterPurchPost(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]);
    begin
        //HEI.86>>
        if not PurchaseHeader.ISTEMPORARY then begin
            if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
                PurchaseHeader."Assigned User ID" := USERID;
                PurchaseHeader.MODIFY();
            end;
        end;
        //HEI.86<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterInsertEvent', '', false, false)]
    local procedure CCCDimforT39OnInsert(var Rec: Record "Purchase Line"; RunTrigger: Boolean);
    var
        lDimSetEntry: Record "Dimension Set Entry";
        lDimSetEntry2: Record "Dimension Set Entry";
        lDimVal: Record "Dimension Value";
        lGLSetUp: Record "General Ledger Setup";
        lSKU: Record "Stockkeeping Unit";
    begin
        //HEI.88>>
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
                Rec.VALIDATE("Dimension Set ID", GetDimSetId(Rec));
                Rec.MODIFY();
            end;
        end;
        //HEI.88<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterModifyEvent', '', false, false)]
    local procedure CCCDimforT39OnModify(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; RunTrigger: Boolean);
    var
        lDimSetEntry: Record "Dimension Set Entry";
        lDimSetEntry2: Record "Dimension Set Entry";
        lDimVal: Record "Dimension Value";
        lGLSetUp: Record "General Ledger Setup";
        lSKU: Record "Stockkeeping Unit";
    begin
        //HEI.88>>
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
                        Rec.VALIDATE("Dimension Set ID", GetDimSetId(Rec));
                        Rec.MODIFY();
                    end
                    else begin
                        Rec.VALIDATE("Dimension Set ID", GetDimSetId2(Rec));
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
                        Rec.VALIDATE("Dimension Set ID", GetDimSetId(Rec));
                        Rec.MODIFY();
                    end
                    else begin
                        Rec.VALIDATE("Dimension Set ID", GetDimSetId2(Rec));
                        Rec.MODIFY();
                    end;
                end;
            end;
        end;
        //HEI.88<<
    end;

    local procedure GetDimSetId(PurchLine: Record "Purchase Line"): Integer;
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
        //HEI.88>>
        GeneralLedgerSetup.GET();
        TempDimensionSetEntry.DELETEALL();
        DimensionManagement.GetDimensionSet(TempDimensionSetEntry, PurchLine."Dimension Set ID");
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
        CLEAR(TempDimensionSetEntry);
        exit(dimsetid);
        //HEI.88<<
    end;

    local procedure GetDimSetId2(PurchLine: Record "Purchase Line"): Integer;
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
        //HEI.88>>
        GeneralLedgerSetup.GET();
        TempDimensionSetEntry.DELETEALL();
        DimensionManagement.GetDimensionSet(TempDimensionSetEntry, PurchLine."Dimension Set ID");
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
        CLEAR(TempDimensionSetEntry);
        exit(dimsetid);
        //HEI.88<<
    end;

    local procedure FindPQApproerEmail(var PurchaseHeader: Record "Purchase Header"): Text[100];
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        UserSetup: Record "User Setup";
    begin
        //HEI.98 >>
        //HEI.99>>
        if PurchaseHeaderAdditional.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") then
            if UserSetup.GET(PurchaseHeaderAdditional."PQ Approver") then
                //IF UserSetup.GET(PurchaseHeader."PQ Approver") THEN
                //HEI.99<<
                if UserSetup."E-Mail" <> '' then
                    exit(UserSetup."E-Mail");
        //HEI.98 <<
    end;

    local procedure FindCreaterEmail(var PurchaseHeader: Record "Purchase Header"): Text[100];
    var
        UserSetup: Record "User Setup";
    begin
        //HEI.98 >>
        if UserSetup.GET(PurchaseHeader."Created By IBM FND") then//Bc Upgrade SHARMP16-- Defect fix
            if UserSetup."E-Mail" <> '' then
                exit(UserSetup."E-Mail");
        //HEI.98 <<
    end;
    //BC Upgrade SHARMP16 begin>>---------------- Interface code 
    // [EventSubscriber(ObjectType::Table, 123, 'OnAfterInsertEvent', '', false, false)]
    // local procedure T123OnAfterInsert(var Rec: Record "Purch. Inv. Line"; RunTrigger: Boolean);
    // var
    //     PurchRcptHeader: Record "Purch. Rcpt. Header";
    //     PurchaseHeader: Record "Purchase Header";
    //     PurchaseLine: Record "Purchase Line";
    //     PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    // begin
    //     //HEI.90>>
    //     if Rec.ISTEMPORARY then
    //         exit;
    //     if (Rec.Quantity = 0) then
    //         exit;
    //     if (Rec."No." <> '') and (Rec."Receipt No." <> '') then
    //         if PurchRcptHeader.GET(Rec."Receipt No.") then
    //             if PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, PurchRcptHeader."Order No.") then begin
    //                 //HEI.107>>
    //                 if (PurchaseHeader."Maximo Requisition No." = '') then
    //                     exit;
    //                 //HEI.107<<
    //                 PurchaseHeader.CALCFIELDS("Maximo Status");
    //                 if (PurchaseHeader."Maximo Status" = PurchaseHeader."Maximo Status"::PendClose) then
    //                     exit
    //                 else begin
    //                     PurchaseLine.RESET;
    //                     PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
    //                     PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
    //                     PurchaseLine.SETFILTER("No.", '<>%1', '');
    //                     PurchaseLine.SETRANGE("Delivery Finalized", false);
    //                     if PurchaseLine.ISEMPTY then begin
    //                         if PurchaseHeaderAdditional.GET(PurchaseHeader."Document Type"::Order, PurchaseHeader."No.") then begin
    //                             PurchaseHeaderAdditional."Maximo Status" := PurchaseHeaderAdditional."Maximo Status"::PendClose;
    //                             PurchaseHeaderAdditional.MODIFY;
    //                         end;
    //                         //HEI.91>>
    //                         //Create Outbound for MAXIMO-PO
    //                         if (PurchaseHeaderAdditional."Maximo Status" = PurchaseHeaderAdditional."Maximo Status"::PendClose) then begin
    //                             CreatePORequest(PurchaseHeader, false, 0);
    //                         end;
    //                         //HEI.91<<
    //                     end
    //                 end;
    //             end;
    //     //HEI.90<<
    // end;
    //BC Upgrade SHARMP16 end<<---------------- Interface code 

    //BC Upgrade SHARMP16 begin>>---------Interface code
    // local procedure CreatePORequest(PurchaseHeader: Record "Purchase Header"; DeleteRecord: Boolean; LineNoToDelete: Integer);
    // var
    //     InterfaceSetup: Record "Interface Setup";
    //     InterfaceEntryHeaderOut: Record "Interface Entry Header";
    //     InterfaceEntryLineOut: Record "Interface Entry Line";
    //     PurchaseLine: Record "Purchase Line";
    //     Vendor: Record Vendor;
    //     Item: Record Item;
    //     NextEntryNo: Integer;
    //     lGLAcc: Record "G/L Account";
    //     lCMGMapping: Record "CMG Mapping";
    //     lText50000: Label 'G/L Account %1 is defined more than once in CMG Mappings!';
    //     PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    // begin
    //     //HEI.91>>
    //     if not grec_GeneralInterfaceSetup.GET then
    //         exit;
    //     GetGenLedgSetup;
    //     CompanyInformation.GET;

    //     if not InterfaceSetup.GET(grec_GeneralInterfaceSetup."Maximo PO Interface") then
    //         exit;
    //     if not InterfaceSetup.Enabled then
    //         exit;

    //     CLEAR(InterfaceEntryHeaderOut);
    //     InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
    //     InterfaceEntryHeaderOut."Interface Code" := grec_GeneralInterfaceSetup."Maximo PO Interface";
    //     InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
    //     InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
    //     InterfaceEntryHeaderOut."Legal Entity" := CompanyInformation."Legal Entity Code";
    //     InterfaceEntryHeaderOut."External Requisition No." := PurchaseHeader."Maximo Requisition No.";
    //     InterfaceEntryHeaderOut."Source Type" := DATABASE::"Purchase Line";
    //     InterfaceEntryHeaderOut."Source No." := PurchaseHeader."No.";
    //     InterfaceEntryHeaderOut."Document Date" := PurchaseHeader."Document Date";
    //     if Vendor.GET(PurchaseHeader."Buy-from Vendor No.") then;
    //     InterfaceEntryHeaderOut."Buy-from Vendor No." := Vendor."No." + '-' + CompanyInformation."Legal Entity Code";
    //     if PurchaseHeader."Currency Code" <> '' then
    //         InterfaceEntryHeaderOut."Currency Code" := PurchaseHeader."Currency Code"
    //     else
    //         InterfaceEntryHeaderOut."Currency Code" := GeneralLedgerSetup."LCY Code";
    //     PurchaseHeader.CALCFIELDS(Amount, "Amount Including VAT");
    //     InterfaceEntryHeaderOut.Amount := PurchaseHeader.Amount;
    //     InterfaceEntryHeaderOut."VAT Amount" := PurchaseHeader."Amount Including VAT" - PurchaseHeader.Amount;
    //     InterfaceEntryHeaderOut."Amount Including VAT" := PurchaseHeader."Amount Including VAT";
    //     InterfaceEntryHeaderOut."Requested Receipt Date" := PurchaseHeader."Requested Receipt Date";
    //     InterfaceEntryHeaderOut."Expected Receipt Date" := PurchaseHeader."Expected Receipt Date";
    //     InterfaceEntryHeaderOut."Source Status" := PurchaseHeader.Status;
    //     InterfaceEntryHeaderOut."Your Reference" := PurchaseHeader."Your Reference";
    //     if PurchaseHeaderAdditional.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") then begin
    //         InterfaceEntryHeaderOut."Simulation Done" := PurchaseHeaderAdditional."Import Identifier";
    //         InterfaceEntryHeaderOut."Location Code" := PurchaseHeader."Shipment Method Code";
    //         InterfaceEntryHeaderOut."Maximo Status" := InterfaceEntryHeaderOut."Maximo Status"::PendClose;
    //     end;
    //     InterfaceEntryHeaderOut."Global No." := PurchaseHeader."Location Code";
    //     if LineNoToDelete = 0 then
    //         InterfaceEntryHeaderOut."Delete Record" := DeleteRecord;
    //     InterfaceEntryHeaderOut.INSERT(true);

    //     PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
    //     PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
    //     PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
    //     if LineNoToDelete <> 0 then
    //         PurchaseLine.SETRANGE("Line No.", LineNoToDelete);
    //     if PurchaseLine.findset then
    //         repeat
    //             CLEAR(InterfaceEntryLineOut);
    //             InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
    //             NextEntryNo := NextEntryNo + 1;
    //             InterfaceEntryLineOut."Entry No." := NextEntryNo;
    //             InterfaceEntryLineOut."Buy-from Vendor No." := PurchaseLine."Buy-from Vendor No." + '-' + CompanyInformation."Legal Entity Code";
    //             InterfaceEntryLineOut."Source Line No." := PurchaseLine."Line No.";
    //             InterfaceEntryLineOut.Type := InterfaceEntryLineOut.Type::Item;
    //             Item.GET(PurchaseLine."No.");
    //             InterfaceEntryLineOut."No." := Item."No." + '-' + CompanyInformation."Legal Entity Code";
    //             InterfaceEntryLineOut.Description := PurchaseLine.Description;
    //             InterfaceEntryLineOut."Description 2" := PurchaseLine."Description 2";
    //             InterfaceEntryLineOut."Location Code" := PurchaseLine."Location Code";
    //             InterfaceEntryLineOut.Quantity := PurchaseLine.Quantity;
    //             InterfaceEntryLineOut."Currency Code" := InterfaceEntryHeaderOut."Currency Code";
    //             InterfaceEntryLineOut."Unit Amount" := PurchaseLine."Direct Unit Cost";
    //             InterfaceEntryLineOut."Unit of Measure Code" := InterfaceFrameworkMgt.GetUnitOfMeasureCommercialISOCode(PurchaseLine."Unit of Measure Code");
    //             InterfaceEntryLineOut."Qty. per Unit of Measure" := PurchaseLine."Qty. per Unit of Measure";
    //             InterfaceEntryLineOut."VAT %" := PurchaseLine."VAT %";
    //             InterfaceEntryLineOut."Document Date" := PurchaseHeader."Document Date";
    //             InterfaceEntryLineOut."Requested Receipt Date" := PurchaseLine."Requested Receipt Date";
    //             InterfaceEntryLineOut."Expected Receipt Date" := PurchaseLine."Expected Receipt Date";
    //             InterfaceEntryLineOut."Shortcut Dimension 1 Code" := PurchaseLine."Shortcut Dimension 1 Code";
    //             InterfaceEntryLineOut."Shortcut Dimension 2 Code" := PurchaseLine."Shortcut Dimension 2 Code";
    //             InterfaceEntryLineOut."External Requisition No." := PurchaseLine."Maximo Requisition No.";
    //             InterfaceEntryLineOut."External Requisition Line No." := PurchaseLine."Maximo Requisition Line No.";
    //             InterfaceEntryLineOut."Legal Entity" := CompanyInformation."Legal Entity Code";
    //             InterfaceEntryLineOut."Delete Record" := DeleteRecord;
    //             InterfaceEntryLineOut."Zone Code" := PurchaseLine."Zone Code";
    //             InterfaceEntryLineOut."Over Percent" := PurchaseLine."Tolerance Received Over % FND";
    //             InterfaceEntryLineOut."Under Percent" := PurchaseLine."Tolerance Received Under % FND";
    //             InterfaceEntryLineOut."Machine Reference No." := PurchaseLine."Machine Reference Number";
    //             PurchaseLine.CALCFIELDS("Import Identifier");
    //             InterfaceEntryLineOut."Cancelled FND" := PurchaseLine."Import Identifier";
    //             InterfaceEntryLineOut.INSERT;
    //         until PurchaseLine.NEXT = 0;

    //     PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
    //     PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
    //     PurchaseLine.SETRANGE(Type, PurchaseLine.Type::"G/L Account");
    //     if LineNoToDelete <> 0 then
    //         PurchaseLine.SETRANGE("Line No.", LineNoToDelete);
    //     if PurchaseLine.findset then
    //         repeat
    //             CLEAR(InterfaceEntryLineOut);
    //             InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
    //             NextEntryNo := NextEntryNo + 1;
    //             InterfaceEntryLineOut."Entry No." := NextEntryNo;
    //             InterfaceEntryLineOut."Buy-from Vendor No." := PurchaseLine."Buy-from Vendor No." + '-' + CompanyInformation."Legal Entity Code";
    //             InterfaceEntryLineOut."Source Line No." := PurchaseLine."Line No.";
    //             InterfaceEntryLineOut.Type := InterfaceEntryLineOut.Type::"G/L Account";
    //             lGLAcc.GET(PurchaseLine."No.");
    //             lCMGMapping.RESET;
    //             lCMGMapping.SETRANGE("G/L Account", lGLAcc."No.");
    //             if lCMGMapping.FINDFIRST then begin
    //                 if lCMGMapping.COUNT > 1 then
    //                     ERROR(lText50000, lCMGMapping."G/L Account");
    //                 InterfaceEntryLineOut."No." := lCMGMapping."Dimension Value Code" + '-' + CompanyInformation."Legal Entity Code";
    //             end;
    //             InterfaceEntryLineOut.Description := PurchaseLine.Description;
    //             InterfaceEntryLineOut."Description 2" := PurchaseLine."Description 2";
    //             InterfaceEntryLineOut."Location Code" := PurchaseLine."Location Code";
    //             InterfaceEntryLineOut.Quantity := PurchaseLine.Quantity;
    //             InterfaceEntryLineOut."Currency Code" := InterfaceEntryHeaderOut."Currency Code";
    //             InterfaceEntryLineOut."Unit Amount" := PurchaseLine."Direct Unit Cost";
    //             InterfaceEntryLineOut."Unit of Measure Code" := InterfaceFrameworkMgt.GetUnitOfMeasureCommercialISOCode(PurchaseLine."Unit of Measure Code");
    //             InterfaceEntryLineOut."Qty. per Unit of Measure" := PurchaseLine."Qty. per Unit of Measure";
    //             InterfaceEntryLineOut."VAT %" := PurchaseLine."VAT %";
    //             InterfaceEntryLineOut."Document Date" := PurchaseHeader."Document Date";
    //             InterfaceEntryLineOut."Requested Receipt Date" := PurchaseLine."Requested Receipt Date";
    //             InterfaceEntryLineOut."Expected Receipt Date" := PurchaseLine."Expected Receipt Date";
    //             InterfaceEntryLineOut."Shortcut Dimension 1 Code" := PurchaseLine."Shortcut Dimension 1 Code";
    //             InterfaceEntryLineOut."Shortcut Dimension 2 Code" := PurchaseLine."Shortcut Dimension 2 Code";
    //             InterfaceEntryLineOut."External Requisition No." := PurchaseLine."Maximo Requisition No.";
    //             InterfaceEntryLineOut."External Requisition Line No." := PurchaseLine."Maximo Requisition Line No.";
    //             InterfaceEntryLineOut."Legal Entity" := CompanyInformation."Legal Entity Code";
    //             InterfaceEntryLineOut."Delete Record" := DeleteRecord;
    //             InterfaceEntryLineOut."Zone Code" := PurchaseLine."Zone Code";
    //             InterfaceEntryLineOut."Over Percent" := PurchaseLine."Tolerance Received Over % FND";
    //             InterfaceEntryLineOut."Under Percent" := PurchaseLine."Tolerance Received Under % FND";
    //             InterfaceEntryLineOut."Machine Reference No." := PurchaseLine."Machine Reference Number";
    //             InterfaceEntryLineOut.INSERT;
    //         until PurchaseLine.NEXT = 0;
    //     //HEI.91<<
    // end;
    //BC Upgrade SHARMP16 end<<---------Interface code

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterModifyEvent', '', false, false)]
    local procedure T39OnAfterModifyDelFinal(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; RunTrigger: Boolean);
    begin
        //HEI.94>>
        if (Rec.Quantity <> 0) then
            if (Rec."Quantity Received" = Rec.Quantity) then
                Rec.VALIDATE("Delivery Finalized FND", true);
        //HEI.94<<
    end;

    [EventSubscriber(ObjectType::Table, 7316, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnAfterDeleteWhseRcptHeader(var Rec: Record "Warehouse Receipt Header"; RunTrigger: Boolean);
    var
        UserSetup: Record "User Setup";
    //  LocText5000: Label 'The warehouse receipt - %1, can not be deleted as the document is created for Astro';
    begin
        //HEI.102>>
        // //HEI.101>>
        // IF Rec.ISTEMPORARY THEN
        //  EXIT;
        //
        // IF NOT Rec."Astro Integration" THEN
        //  EXIT else BEGIN
        //    IF UserSetup.GET(USERID) THEN BEGIN
        //      IF NOT UserSetup."Allow deletion ASTRO Whs Rcpt" THEN
        //        ERROR(LocText5000,Rec."No.");
        //    end;
        //  end;
        // //HEI.101<<
        //HEI.102<<
    end;

    [EventSubscriber(ObjectType::Table, 7317, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnAfterDeleteWhseRcptLine(var Rec: Record "Warehouse Receipt Line"; RunTrigger: Boolean);
    var
        UserSetup: Record "User Setup";
    //  LocText5000: Label 'The warehouse receipt - %1 for Line %2, can not be deleted as the document is created for Astro';
    begin
        //HEI.102>>
        // //HEI.101>>
        // IF Rec.ISTEMPORARY THEN
        //  EXIT;
        //
        // IF NOT Rec."Astro Integration" THEN
        //  EXIT else BEGIN
        //    IF UserSetup.GET(USERID) THEN BEGIN
        //      IF NOT UserSetup."Allow deletion ASTRO Whs Rcpt" THEN
        //        ERROR(LocText5000,Rec."No.",Rec."Line No.");
        //    end;
        //  end;
        // //HEI.101<<
        //HEI.102<<
    end;

    // [EventSubscriber(ObjectType::Table, 38, 'OnBeforeDeleteEvent', '', false, false)]
    // local procedure T38OnDeleteAstroPurchHeader(var Rec: Record "Purchase Header"; RunTrigger: Boolean);
    // var
    //     PurchaseHeaderAddtnl: Record "Purchase Header Additional FND";
    //     AstroText50000: Label 'The Purchase Order %1 can not be deleted as its created from Astro Dispatch Sync report';
    //     PurchaseLine: Record "Purchase Line";
    //     UserSetup: Record "User Setup";
    // begin
    //     //HEI.102>>
    //     if Rec.ISTEMPORARY then
    //         exit;
    //     //IF (Rec."Document Type" <> Rec."Document Type"::Order) THEN  //HEI.124
    //     if (Rec."Document Type" in [Rec."Document Type"::"Blanket Order", Rec."Document Type"::"Credit Memo", Rec."Document Type"::Invoice, Rec."Document Type"::Quote]) then  //HEI.124
    //         exit;
    //     if PurchaseHeaderAddtnl.GET(Rec."Document Type", Rec."No.") then begin
    //         //IF (PurchaseHeaderAddtnl."Astro WMS PO" <> '') THEN BEGIN  //HEI.104
    //         if PurchaseHeaderAddtnl."Astro WMS PO" then begin  //HEI.104
    //             if UserSetup.GET(USERID) then      //HEI.103
    //                 if not UserSetup."Allow deletion ASTRO Whs Rcpt" then   //HEI.103
    //                     ERROR(AstroText50000, PurchaseHeaderAddtnl."No.");
    //         end else
    //             exit;
    //     end;
    //     //HEI.102<<
    // end;

    // [EventSubscriber(ObjectType::Table, 39, 'OnBeforeDeleteEvent', '', false, false)]
    // local procedure T39OnDeleteAstroPurchLines(var Rec: Record "Purchase Line"; RunTrigger: Boolean);
    // var
    //     PurchaseHeaderAddtnl: Record "Purchase Header Additional FND";
    //     AstroText50000: Label 'The line %1 of the PO %2 can not be deleted as its created from Astro Dispatch Sync report';
    //     UserSetup: Record "User Setup";
    // begin
    //     //HEI.102>>
    //     if Rec.ISTEMPORARY then
    //         exit;
    //     //IF (Rec."Document Type" <> Rec."Document Type"::Order) THEN  //HEI.124
    //     if (Rec."Document Type" in [Rec."Document Type"::"Blanket Order", Rec."Document Type"::"Credit Memo", Rec."Document Type"::Invoice, Rec."Document Type"::Quote]) then  //HEI.124
    //         exit;
    //     //HEI.103>>
    //     //IF PurchaseHeaderAddtnl.GET(Rec."Document Type",Rec."No.",Rec."Line No.") THEN BEGIN
    //     // IF (PurchaseHeaderAddtnl."Astro Unique ID" <> '') THEN BEGIN
    //     //    ERROR(AstroText50000,Rec."Line No.",PurchaseHeaderAddtnl."No.");
    //     //  end else
    //     //    EXIT;
    //     //end;
    //     if (Rec."Astro Unique ID" <> '') then begin
    //         if UserSetup.GET(USERID) then
    //             if not UserSetup."Allow deletion ASTRO Whs Rcpt" then
    //                 ERROR(AstroText50000, Rec."Line No.", PurchaseHeaderAddtnl."No.");
    //     end else
    //         exit;
    //     //HEI.103<<
    //     //HEI.102<<
    // end;

    // [EventSubscriber(ObjectType::Table, 39, 'OnAfterModifyEvent', '', false, false)]
    // local procedure T39OnAfterModifyAstroLine(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; RunTrigger: Boolean);
    // var
    //     TextAstroError: Label 'You can not modify the field value of %1 as its connected to Astro interface';
    // begin
    //     //HEI.104>>
    //     if Rec.ISTEMPORARY then
    //         exit;
    //     //IF (Rec."Document Type" <> Rec."Document Type"::Order) THEN  //HEI.124
    //     if (Rec."Document Type" in [Rec."Document Type"::"Blanket Order", Rec."Document Type"::"Credit Memo", Rec."Document Type"::Invoice, Rec."Document Type"::Quote]) then  //HEI.124
    //         exit;

    //     //HEI.126>>
    //     if not AstroInterfaceSetup.GET then
    //         exit;
    //     if AstroInterfaceSetup.GET and (not AstroInterfaceSetup."Enable Dispatch Syncing StP") then
    //         exit;
    //     //HEI.126<<

    //     //HEI.105>>
    //     //IF (Rec."Expected Receipt Date" = xRec."Expected Receipt Date") THEN  //HEI.115
    //     //  EXIT;  //HEI.115
    //     //HEI.105<<

    //     //HEI.115>>
    //     //IF (Rec."Astro Unique ID" <> '')THEN
    //     //  ERROR(TextExpctdRcptDtError,Rec."Line No.")
    //     //else
    //     //  EXIT;
    //     if (Rec."Astro Unique ID" <> '') then begin
    //         if (Rec."No." <> xRec."No.") then
    //             ERROR(TextAstroError, Rec.FIELDCAPTION("No."));
    //         if (Rec.Quantity <> xRec.Quantity) then
    //             ERROR(TextAstroError, Rec.FIELDCAPTION(Quantity));
    //         if (Rec."Expected Receipt Date" <> xRec."Expected Receipt Date") then
    //             ERROR(TextAstroError, Rec.FIELDCAPTION("Expected Receipt Date"));
    //         if (Rec."Location Code" <> xRec."Location Code") then
    //             ERROR(TextAstroError, Rec.FIELDCAPTION("Location Code"));
    //         if (Rec."Direct Unit Cost" <> xRec."Direct Unit Cost") then
    //             ERROR(TextAstroError, Rec.FIELDCAPTION("Direct Unit Cost"));
    //         if (Rec."Delivery Finalized" <> xRec."Delivery Finalized") then
    //             ERROR(TextAstroError, Rec.FIELDCAPTION("Delivery Finalized"));
    //     end else
    //         exit;
    //     //HEI.115<<
    //     //HEI.104<<
    // end;
    //BC Upgrade SHARMP16 end<<---------AstroSetup
    [EventSubscriber(ObjectType::Table, 39, 'OnAfterModifyEvent', '', false, false)]
    local procedure T39OnBeforeModifyPurchaseLine(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; RunTrigger: Boolean);
    var
        PL: Record "Purchase Line";
        VendorSPL: Record "Vendor SPL Relation FND";
    begin
        //HEI.110 >>
        if Rec.ISTEMPORARY then exit;
        //HEI.113 >>
        //HEI.120 >>
        PurchSetup.GET();
        if not PurchSetup."SPL Active FND" or (Rec.Type <> Rec.Type::Item) then exit;
        //HEI.120 <<
        if (Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No.") or (Rec.Type <> xRec.Type) then begin
            //HEI.113 <<
            //HEI.118 >>
            if not VendorSPL.GET(Rec."Buy-from Vendor No.", Rec."SPL Code FND") then
                Rec.VALIDATE("SPL Code FND", '');

            if not VendorSPL.GET(Rec."Buy-from Vendor No.", Rec."Consumption SPL Code FND") then
                Rec."Consumption SPL Code FND" := '';

            //IF Rec."Document Type" IN [Rec."Document Type"::"Blanket Order", Rec."Document Type"::Order, Rec."Document Type"::Quote] THEN
            //  Rec.SetDefaultSPLCode();
            //HEI.118 <<
            //Rec.MODIFY; //HEI.116
        end;
        //HEI.116 >>
        if (Rec."Blanket Order No." <> xRec."Blanket Order No.") or (Rec."Blanket Order Line No." <> xRec."Blanket Order Line No.") then begin
            Rec.VALIDATE("SPL Code FND", '');
            Rec."Consumption SPL Code FND" := '';

            if PL.GET(PL."Document Type"::"Blanket Order", Rec."Blanket Order No.", Rec."Blanket Order Line No.") then begin
                Rec."SPL Code FND" := PL."SPL Code FND";
                Rec."SPL Name FND" := PL."SPL Name FND";
            end;
        end;
        //HEI.116 <<
        //HEI.100 <<
    end;

    //BC Upgrade SHARMP16 begin>>---------------- Interface code
    // [EventSubscriber(ObjectType::Table, 50140, 'OnAfterModifyEvent', '', false, false)]
    // local procedure T50140OnAfterModify(var Rec: Record "Purchase Header Additional FND"; var xRec: Record "Purchase Header Additional FND"; RunTrigger: Boolean);
    // var
    //     PH: Record "Purchase Header";
    // begin
    //     //HEI.110<<
    //     if Rec.ISTEMPORARY then exit;
    //     if Rec."Document Type" <> Rec."Document Type"::Order then exit;
    //     if not PH.GET(Rec."Document Type", Rec."No.") then exit;
    //     //HEI.114 >>
    //     if PH.Status <> PH.Status::Open then
    //         //IF IbecorComparePORequest(Rec,xRec) THEN//HEI.137 //HEI.151
    //         IbecorCreatePORequest(PH, false);
    //     //HEI.114 <<
    //     //HEI.110<<
    // end;
    //BC Upgrade SHARMP16 end<<---------------- Interface code

    local procedure CheckVendorSPL(var Rec: Record "Purchase Header");
    var
        PL: Record "Purchase Line";
        SPL: Record "Vendor SPL Relation FND";
        IsCorrectSPL: Boolean;
        WrgSplIsEmpty: Label 'SPL Code is not defined on some item lines. Do you want to proceed ahead ?';
        WrgConsSplIncorrect: TextConst ENU = 'Consumption SPL Code = %1 is Blocked or incorrect. Do you want to proceed ahead ?';
        WrgSplIncorrect: TextConst ENU = 'SPL Code = %1 is Blocked or incorrect. Do you want to proceed ahead ?';
    begin
        //HEI.120 >>
        PurchSetup.GET();
        if not PurchSetup."SPL Active FND" then exit;
        //HEI.120 <<
        //HEI.117 >>
        if not GUIALLOWED then exit;

        SPL.SETRANGE("Vendor No.", Rec."Buy-from Vendor No.");
        SPL.SETRANGE(Blocked, false);
        SPL.SETRANGE("Marked for Deletion", false);
        if SPL.ISEMPTY then exit;
        SPL.RESET();

        PL.SETRANGE("Document Type", Rec."Document Type");
        PL.SETRANGE("Document No.", Rec."No.");
        PL.SETRANGE(Type, PL.Type::Item);
        PL.SETRANGE("SPL Code FND", '');
        if not PL.ISEMPTY then begin
            if not CONFIRM(WrgSplIsEmpty, false) then
                ERROR('');
        end else begin
            PL.SETRANGE("SPL Code FND");
            if PL.findset() then
                repeat
                    IsCorrectSPL := false;
                    //HEI.118 >>
                    if (PL."Document Type" = PL."Document Type"::"Blanket Order") and (PL."Consumption SPL Code FND" <> '') then begin
                        if SPL.GET(Rec."Buy-from Vendor No.", PL."Consumption SPL Code FND") then
                            if not SPL.Blocked and not SPL."Marked for Deletion" then
                                IsCorrectSPL := true;

                        if not IsCorrectSPL then
                            if not CONFIRM(STRSUBSTNO(WrgConsSplIncorrect, PL."Consumption SPL Code FND"), false) then
                                ERROR('');
                    end else begin
                        if SPL.GET(Rec."Buy-from Vendor No.", PL."SPL Code FND") then
                            if not SPL.Blocked and not SPL."Marked for Deletion" then
                                IsCorrectSPL := true;

                        if not IsCorrectSPL then
                            if not CONFIRM(STRSUBSTNO(WrgSplIncorrect, PL."SPL Code FND"), false) then
                                ERROR('');
                    end;
                //HEI.118 <<
                until not IsCorrectSPL or (PL.NEXT() = 0);
        end;
        //HEI.117 <<
    end;
    //BC Upgrade SHARMP16 begin>>---------------- Astro Setup code 
    // [EventSubscriber(ObjectType::Table, 7317, 'OnAfterModifyEvent', '', false, false)]
    // local procedure T7317OnAfterModifyAstroLine(var Rec: Record "Warehouse Receipt Line"; var xRec: Record "Warehouse Receipt Line"; RunTrigger: Boolean);
    // var
    //     TextAstroError: Label 'You can not modify the field value of %1 as its connected to Astro interface';
    // begin
    //     //HEI.126>>
    //     if Rec.ISTEMPORARY then
    //         exit;

    //     if not AstroInterfaceSetup.GET then
    //         exit;

    //     if AstroInterfaceSetup.GET and (not AstroInterfaceSetup."Enable Dispatch Syncing StP") then
    //         exit;

    //     if (Rec."Source Document" <> Rec."Source Document"::"Purchase Order") then
    //         exit;

    //     if (Rec."Astro Unique ID" = '') then
    //         exit;

    //     if (Rec."No." <> xRec."No.") then
    //         ERROR(TextAstroError, Rec.FIELDCAPTION("No."));
    //     if (Rec.Quantity <> xRec.Quantity) then
    //         ERROR(TextAstroError, Rec.FIELDCAPTION(Quantity));
    //     if (Rec."Location Code" <> xRec."Location Code") then
    //         ERROR(TextAstroError, Rec.FIELDCAPTION("Location Code"));
    //     if (Rec."Zone Code" <> xRec."Zone Code") then
    //         ERROR(TextAstroError, Rec.FIELDCAPTION("Zone Code"));
    //     if (Rec."Bin Code" <> xRec."Bin Code") then
    //         ERROR(TextAstroError, Rec.FIELDCAPTION("Bin Code"));
    //     //HEI.126<<
    // end;
    //BC Upgrade SHARMP16 end<<---------------- AstroSetup code

    //BC Upgrade SHARMP16 begin>>---------------- AstroSetup code
    // [EventSubscriber(ObjectType::Table, 7321, 'OnAfterModifyEvent', '', false, false)]
    // local procedure T7321OnAfterModifyAstroLine(var Rec: Record "Warehouse Shipment Line"; var xRec: Record "Warehouse Shipment Line"; RunTrigger: Boolean);
    // var
    //     TextAstroError: Label 'You can not modify the field value of %1 as its connected to Astro interface';
    //     PurchaseLine: Record "Purchase Line";
    // begin
    //     //HEI.126>>
    //     if Rec.ISTEMPORARY then
    //         exit;

    //     if not AstroInterfaceSetup.GET then
    //         exit;

    //     if AstroInterfaceSetup.GET and (not AstroInterfaceSetup."Enable Purch Return Order Sync") then
    //         exit;

    //     if (Rec."Source Document" <> Rec."Source Document"::"Purchase Return Order") then
    //         exit;

    //     if PurchaseLine.GET(PurchaseLine."Document Type"::"Return Order", Rec."Source No.", Rec."Source Line No.") then begin
    //         if (PurchaseLine."Astro Unique ID" <> '') then begin
    //             if (Rec."No." <> xRec."No.") then
    //                 ERROR(TextAstroError, Rec.FIELDCAPTION("No."));
    //             if (Rec.Quantity <> xRec.Quantity) then
    //                 ERROR(TextAstroError, Rec.FIELDCAPTION(Quantity));
    //             if (Rec."Location Code" <> xRec."Location Code") then
    //                 ERROR(TextAstroError, Rec.FIELDCAPTION("Location Code"));
    //             if (Rec."Zone Code" <> xRec."Zone Code") then
    //                 ERROR(TextAstroError, Rec.FIELDCAPTION("Zone Code"));
    //             if (Rec."Bin Code" <> xRec."Bin Code") then
    //                 ERROR(TextAstroError, Rec.FIELDCAPTION("Bin Code"));
    //         end;
    //     end else
    //         exit;
    //     //HEI.126<<
    // end;
    //BC Upgrade SHARMP16 end<<---------------- AstroSetup code

    // BC Upgrade SHUKLP03 >> Added in the interface ext.
    // [EventSubscriber(ObjectType::Codeunit, codeunit::"Undo Purchase Receipt Line", 'OnBeforePurchRcptLineModify', '', false, false)]
    // local procedure OnBeforeUndoReceipt(var PurchRcptLine: Record "Purch. Rcpt. Line");
    // var
    //     PurchRcptHdr: Record "Purch. Rcpt. Header";
    //     PurchRcptHeaderAdditional: Record "Purch. Rcpt. Header Add FND";
    //     POSMConfirmation: Label 'This is a POSM item line. Do you want to continue?';
    //     POSMItemLine: Label 'This is a document with item lines with SRM order, so undo receipt is not be possible';
    //     POSMWarningMessage: Label 'Undo operation is terminated to respect the warning';
    // //   SRMInterfaceManagement: Codeunit "SRM Interface Management";
    // begin
    //     //HEI.134>>
    //     if PurchRcptLine.ISTEMPORARY then
    //         exit;

    //     if (PurchRcptLine.Type <> PurchRcptLine.Type::Item) then
    //         exit;

    //     if PurchRcptHeaderAdditional.GET(PurchRcptLine."Document No.") then
    //         if (PurchRcptHeaderAdditional."Shopping Card No." = '') then
    //             exit;

    //     //ERROR(POSMItemLine);  //HEI.135
    //     if not CONFIRM(POSMConfirmation, false) then  //HEI.135
    //         ERROR(POSMWarningMessage);  //HEI.135
    //     //HEI.134<<
    // end;
    // BC Upgrade SHUKLP03 << Added in the interface ext.
    //BC Upgrade SHARMp16 Begin>> -- Interface code
    // [EventSubscriber(ObjectType::Codeunit, codeunit::"Undo Purchase Receipt Line", 'OnAfterPurchRcptLineModify', '', false, false)]
    // local procedure OnAfterUndoReceipt(var PurchRcptLine: Record "Purch. Rcpt. Line");
    // var
    //     PurchRcptHdr: Record "Purch. Rcpt. Header";
    //     PurchRcptHeaderAdditional: Record "Purch. Rcpt. Header Add FND";
    // // SRMInterfaceManagement: Codeunit "SRM Interface Management";//BC Upgrade SHARMp16 -- Interface code
    // // ZycusInterfaceManagement: Codeunit "Zycus Interface Management";//BC Upgrade SHARMp16 -- Interface code
    // // InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";//BC Upgrade SHARMp16 -- Interface code
    // begin
    //     //HEI.139>>
    //     if PurchRcptHdr.ISTEMPORARY then
    //         exit;

    //     if (PurchRcptLine.Type <> PurchRcptLine.Type::Item) then
    //         exit;

    //     if PurchRcptHeaderAdditional.GET(PurchRcptLine."Document No.") then
    //         //HEI.159>>
    //         //IF (PurchRcptHeaderAdditional."Shopping Card No." = '') THEN
    //         //  EXIT;
    //         if (PurchRcptHeaderAdditional."Shopping Card No." = '') or (PurchRcptHeaderAdditional."Zycus Order No." <> '') then
    //             exit;
    //     //HEI.159<<

    //     //Original Receipt Line
    //     PurchRcptHdr.GET(PurchRcptLine."Document No.");

    //     //HEI.159>>
    //     //SRMInterfaceManagement.CreateOutboundSRMItemGRCancellation(PurchRcptHdr, precPurchRcptLine."Line No.");
    //     if (PurchRcptHeaderAdditional."Shopping Card No." <> '') and (PurchRcptHeaderAdditional."Zycus Order No." = '') then;
    //     // SRMInterfaceManagement.CreateOutboundSRMItemGRCancellation(PurchRcptHdr, PurchRcptLine."Line No.");//BC Upgrade SHARMp16 -- Interface code
    //     //HEI.159<<

    //     PurchRcptHdr."POSM GR Confirmed" := false;
    //     PurchRcptHdr.MODIFY;
    //     //HEI.139<<
    // end;
    //BC Upgrade SHARMp16 End<< -- Interface code
    // BC Upgrade SHUKLP03 >> Added in the interface ext.  
    // local procedure IbecorComparePORequest(var Rec_PurchaseHeaderAdditional: Record "Purchase Header Additional FND"; var xRec_PurchaseHeaderAdditional: Record "Purchase Header Additional FND"): Boolean;
    // begin
    //     //HEI.137>>
    //     case true of
    //         //License Information
    //         Rec_PurchaseHeaderAdditional."License Required" <> xRec_PurchaseHeaderAdditional."License Required":
    //             exit(true);
    //         //Rec_PurchaseHeaderAdditional."License Name" <> xRec_PurchaseHeaderAdditional."License Code" : EXIT(TRUE); //HEI.150
    //         Rec_PurchaseHeaderAdditional."License Code" <> xRec_PurchaseHeaderAdditional."License Code":
    //             exit(true); //HEI.150
    //         Rec_PurchaseHeaderAdditional."Bank who issued the License" <> xRec_PurchaseHeaderAdditional."Bank who issued the License":
    //             exit(true);
    //         Rec_PurchaseHeaderAdditional."License Expiration Date" <> xRec_PurchaseHeaderAdditional."License Expiration Date":
    //             exit(true);
    //         Rec_PurchaseHeaderAdditional."CoD/CoC Number" <> xRec_PurchaseHeaderAdditional."CoD/CoC Number":
    //             exit(true);
    //         //Letter of Credit Information
    //         Rec_PurchaseHeaderAdditional."Credit Info Required" <> xRec_PurchaseHeaderAdditional."Credit Info Required":
    //             exit(true);
    //         Rec_PurchaseHeaderAdditional."Credit Number" <> xRec_PurchaseHeaderAdditional."Credit Number":
    //             exit(true);
    //         Rec_PurchaseHeaderAdditional."Credit Amount Of supplier" <> xRec_PurchaseHeaderAdditional."Credit Amount Of supplier":
    //             exit(true);
    //         Rec_PurchaseHeaderAdditional."Bank Who Issued Credit" <> xRec_PurchaseHeaderAdditional."Bank Who Issued Credit":
    //             exit(true);
    //         Rec_PurchaseHeaderAdditional."Last Date Of Shipment" <> xRec_PurchaseHeaderAdditional."Last Date Of Shipment":
    //             exit(true);
    //         Rec_PurchaseHeaderAdditional."Bank Reference Number" <> xRec_PurchaseHeaderAdditional."Bank Reference Number":
    //             exit(true);
    //         Rec_PurchaseHeaderAdditional."Credit Validity Date" <> xRec_PurchaseHeaderAdditional."Credit Validity Date":
    //             exit(true);
    //     end;
    //     exit(false);
    //     //HEI.137<<
    // end;
    // BC Upgrade SHUKLP03 << Added in the interface ext.


    procedure TODeletionRestriction(PurchaseHeader: Record "Purchase Header"): Boolean;
    var
        PurchaseHeader_LRec: Record "Purchase Header";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchaseLine: Record "Purchase Line";
        ReceiptExists: TextConst ENU = 'For Document Type=Order, Document No – %1; Purchase receipt exists, so Transfer Order cannot be deleted.';
        ReceiptInvoiceExists: TextConst ENU = 'For Document Type=Order, Document No – %1; Purchase receipt and Purchase Invoice exists, so Transfer Order cannot be deleted.';
    begin
        //HEI.140>>
        PurchaseHeader_LRec := PurchaseHeader;
        //HEI.141>>
        PurchaseHeaderAdditional.GET(PurchaseHeader_LRec."Document Type", PurchaseHeader_LRec."No.");
        if PurchaseHeaderAdditional."Import Identifier" = false then
            exit(false);
        //HEI.141<<

        // Purchase Line Condition -
        PurchaseLine.RESET();
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader_LRec."No.");
        PurchaseLine.SETFILTER("Quantity Received", '<>%1', 0);
        if PurchaseLine.FINDFIRST() then begin
            if PurchaseLine."Quantity Invoiced" = PurchaseLine."Quantity Received" then begin
                //HEI.160>>
                if GUIALLOWED then
                    //HEI.160<<
                    MESSAGE(ReceiptInvoiceExists, PurchaseLine."Document No.");
                exit(false)
            end else begin
                if PurchaseLine."Quantity Invoiced" <> 0 then
                  //HEI.160>>
                  begin
                    if GUIALLOWED then
                        //HEI.160<<
                        MESSAGE(ReceiptInvoiceExists, PurchaseLine."Document No.")
                    //HEI.160>>
                end
                //HEI.160<<
                else
                    //HEI.160>>
                    if GUIALLOWED then
                        //HEI.160<<
                        MESSAGE(ReceiptExists, PurchaseLine."Document No.");

                exit(false)
            end;
        end;

        exit(true);
        //HEI.140<<
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Expected Receipt Date', false, false)]
    local procedure T38OnAfterValidateExpectedReceiptDate(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    var
        PaymentTerms: Record "Payment Terms";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
    begin
        //HEI.146>>
        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;

        PurchaseLine.RESET();
        PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
        PurchaseLine.SETRANGE("Document No.", Rec."No.");
        if PurchaseLine.findset() then
            repeat
                PurchaseLine."Due Date FND" := Rec."Due Date";
                if (PaymentTerms.GET(Rec."Payment Terms Code")) and (PurchaseLine."Expected Receipt Date" <> 0D) and (PurchaseLine."Expected Receipt Date" <> DMY2DATE(31, 12, 9999)) then //HEI.149
                                                                                                                                                                                           //IF (PaymentTerms.GET(Rec."Payment Terms Code")) AND (PurchaseLine."Expected Receipt Date" <> 0D) THEN //HEI.149
                                                                                                                                                                                           //PurchaseLine."Estimated Pmt. Due Date FND" := CALCDATE(PaymentTerms."Due Date Calculation",Rec."Expected Receipt Date")//HEI.147
                    PurchaseLine."Estimated Pmt. Due Date FND" := CALCDATE(PaymentTerms."Due Date Calculation", PurchaseLine."Expected Receipt Date")//HEI.147
                else
                    PurchaseLine."Estimated Pmt. Due Date FND" := 0D;
                PurchaseLine.MODIFY();
            until PurchaseLine.NEXT() = 0;
        //HEI.146<<
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Payment Terms Code', false, false)]
    local procedure T38OnAfterValidatePaymentTermCode(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    var
        PaymentTerms: Record "Payment Terms";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
    begin
        //HEI.146>>
        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;

        PurchaseLine.RESET();
        PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
        PurchaseLine.SETRANGE("Document No.", Rec."No.");
        if PurchaseLine.findset() then
            repeat
                PurchaseLine."Due Date FND" := Rec."Due Date";
                if (PaymentTerms.GET(Rec."Payment Terms Code")) and (PurchaseLine."Expected Receipt Date" <> 0D) and (PurchaseLine."Expected Receipt Date" <> DMY2DATE(31, 12, 9999)) then //HEI.149
                                                                                                                                                                                           //IF (PaymentTerms.GET(Rec."Payment Terms Code")) AND (PurchaseLine."Expected Receipt Date" <> 0D) THEN //HEI.149
                                                                                                                                                                                           //PurchaseLine."Estimated Pmt. Due Date FND" := CALCDATE(PaymentTerms."Due Date Calculation",Rec."Expected Receipt Date")//HEI.147
                    PurchaseLine."Estimated Pmt. Due Date FND" := CALCDATE(PaymentTerms."Due Date Calculation", PurchaseLine."Expected Receipt Date")//HEI.147
                else
                    PurchaseLine."Estimated Pmt. Due Date FND" := 0D;
                PurchaseLine.MODIFY();
            until PurchaseLine.NEXT() = 0;
        //HEI.146<<
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Due Date', false, false)]
    local procedure T38OnAfterValidateDueDate(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    var
        PaymentTerms: Record "Payment Terms";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
    begin
        //HEI.146>>
        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;

        PurchaseLine.RESET();
        PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
        PurchaseLine.SETRANGE("Document No.", Rec."No.");
        if PurchaseLine.findset() then
            repeat
                PurchaseLine."Due Date FND" := Rec."Due Date";
                if (PaymentTerms.GET(Rec."Payment Terms Code")) and (PurchaseLine."Expected Receipt Date" <> 0D) and (PurchaseLine."Expected Receipt Date" <> DMY2DATE(31, 12, 9999)) then //HEI.149
                                                                                                                                                                                           //IF (PaymentTerms.GET(Rec."Payment Terms Code")) AND (PurchaseLine."Expected Receipt Date" <> 0D) THEN //HEI.149
                                                                                                                                                                                           // PurchaseLine."Estimated Pmt. Due Date FND" := CALCDATE(PaymentTerms."Due Date Calculation",Rec."Expected Receipt Date") //HEI.147
                    PurchaseLine."Estimated Pmt. Due Date FND" := CALCDATE(PaymentTerms."Due Date Calculation", PurchaseLine."Expected Receipt Date") //HEI.147
                else
                    PurchaseLine."Estimated Pmt. Due Date FND" := 0D;
                PurchaseLine.MODIFY();
            until PurchaseLine.NEXT() = 0;
        //HEI.146<<
    end;

    procedure PQtoPOConditionCheck(PurchaseHeader: Record "Purchase Header"): Boolean;
    var
        PurchaseLine: Record "Purchase Line";
    begin
        //HEI.148>>
        PurchaseLine.RESET();
        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETFILTER(Type, '<>%1', PurchaseLine.Type::Item);
        PurchaseLine.SETRANGE(Amount, 0);
        if PurchaseLine.ISEMPTY then
            exit(true);

        exit(false);
        //HEI.148<<
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Buy-from Country/Region Code', false, false)]
    local procedure T38OnAfterModifyCountryCode(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchaseLine: Record "Purchase Line";
        PurchBlanketLine: Record "Purchase Line";
    begin
        //HEI.152>>
        PurchaseLine.RESET();
        GetPurchSetup();
        if PurchSetup."Excluded Countries Imp PO FND" = '' then
            exit;
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            if Rec."Buy-from Country/Region Code" <> xRec."Buy-from Country/Region Code" then
                if Rec.Status = Rec.Status::Released then
                    ERROR(Text0005);
            if PurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") then begin
                if not CheckShippingMethod(PurchSetup, Rec) then begin
                    PurchaseHeaderAdditional."Import Identifier" := true;
                    PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
                    PurchaseLine.SETRANGE("Document No.", Rec."No.");
                    PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
                    if PurchaseLine.findset(true) then
                        PurchaseLine.MODIFYALL("Location Code", PurchSetup."Location Code Imp Proc. FND");
                end else begin
                    PurchaseHeaderAdditional."Import Identifier" := false;
                    PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
                    PurchaseLine.SETRANGE("Document No.", Rec."No.");
                    PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
                    if PurchaseLine.findset(true) then begin
                        if (PurchaseLine."Blanket Order No." <> '') then begin
                            if PurchBlanketLine.GET(PurchBlanketLine."Document Type"::"Blanket Order",
                               PurchaseLine."Blanket Order No.", PurchaseLine."Blanket Order Line No.") then
                                PurchaseLine.MODIFYALL("Location Code", PurchBlanketLine."Consumption Location Code FND");
                        end;
                    end;
                end;
                if Rec."Shipment Method Code" = '' then
                    PurchaseHeaderAdditional."Import Identifier" := false;
                PurchaseHeaderAdditional.MODIFY();
            end;
            //HEI.152<<
        end;
    end;
    // BC Upgrade SHARMP16 begin>>-- Interface code
    // local procedure PFIAmountCheck(Prec_PurchaseHeader: Record "Purchase Header");
    // var
    //     DocShippingAmount: Decimal;
    //     // DocumentShippingCost: Record "Document Shipping Cost";// BC Upgrade SHARMP16 -- Drink-IT table used
    //     AmounttoCompare: Decimal;
    //     PurchHeaderRecpt: Record "Purch. Rcpt. Header";
    //     PFIAmountError: Label 'Document cannot be released, PFI Amount not matched PO Amount.';
    //     PurchHeaderAdditional: Record "Purchase Header Additional FND";
    // //PFIHeader: Record "PFI Header";// BC Upgrade SHARMP16-- Interface table
    // begin
    //     //HEI.155>>
    //     if PurchHeaderAdditional.GET(Prec_PurchaseHeader."Document Type", Prec_PurchaseHeader."No.") then
    //         if PurchHeaderAdditional."PFI Document No." = '' then
    //             exit;

    //     Prec_PurchaseHeader.CALCFIELDS("Amount Including VAT");

    //     //HEI.157>>
    //     /*lrec_IbecorData.RESET;
    //     lrec_IbecorData.SETRANGE("Document Type",Prec_PurchaseHeader."Document Type");
    //     lrec_IbecorData.SETRANGE("Document No",Prec_PurchaseHeader."No.");
    //     IF lrec_IbecorData.FINDFIRST THEN BEGIN*/
    //     // if PFIHeader.GET(PurchHeaderAdditional."PFI Document No.") then begin// BC Upgrade SHARMP16 -- Interface table
    //     //HEI.157<<

    //     DocShippingAmount := 0;
    //     AmounttoCompare := 0;
    //     //// BC Upgrade SHARMP16 begin>> --- DRink-IT table used
    //     // DocumentShippingCost.RESET;
    //     // DocumentShippingCost.SETRANGE("Source Type", DATABASE::"Purchase Header");
    //     // DocumentShippingCost.SETRANGE("Source No.", Prec_PurchaseHeader."No.");
    //     // DocumentShippingCost.SETRANGE("Sub Type", Prec_PurchaseHeader."Document Type");
    //     // if DocumentShippingCost.findset then
    //     //     repeat
    //     //         DocShippingAmount += DocumentShippingCost."Unit Cost";
    //     //     until DocumentShippingCost.NEXT = 0;
    //     //// BC Upgrade SHARMP16 end<< --- DRink-IT table used
    //     AmounttoCompare := Prec_PurchaseHeader."Amount Including VAT" + DocShippingAmount;

    //     PurchHeaderRecpt.RESET;
    //     PurchHeaderRecpt.SETCURRENTKEY("Order No.");
    //     PurchHeaderRecpt.SETRANGE("Order No.", Prec_PurchaseHeader."No.");
    //     if PurchHeaderRecpt.ISEMPTY then
    //         //IF lrec_IbecorData.Amount <> AmounttoCompare THEN //HEI.157
    //         //  if PFIHeader."Total Amount(Incl. VAT)" <> AmounttoCompare then //HEI.157// BC Upgrade SHARMP16-- Interface code
    //         ERROR(PFIAmountError);
    //     // end; //HEI.157
    //     //HEI.155<<

    // end;
    // BC Upgrade SHARMP16 end<<-- Interface code
    procedure CheckToleranceForEsker(var PurchLine: Record "Purchase Line");
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
        ToleranceExceptions: Record "Tolerance Exceptions FND";
        ToleranceExceptionFound: Boolean;
        LowerAmt: Decimal;
        LowerPercAmt: Decimal;
        PurchaseInvoiceAmount: Decimal;
        PurchaseReceiptAmount: Decimal;
        PurchaseReceiptAmountTolExcpt: Decimal;
        UpperAmt: Decimal;
        UpperPercAmt: Decimal;
    begin
        //HEI.154>>
        GetPurchSetup();
        PurchaseInvoiceAmount := 0;
        PurchaseReceiptAmount := 0;
        if not PurchSetup."Invoice Toler.CheckEnabled FND" or not PurchSetup."Check Tolerance Approval FND" then
            exit;
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases.
        // with PurchLine do begin
        //     if "Receipt No." <> '' then begin
        //         PurchRcptLine.GET("Receipt No.", "Receipt Line No.");
        //         "Tolerance Exceeded FND" := false;
        //         MODIFY(false);

        //         ToleranceExceptionFound := false;
        //         ToleranceExceptions.SETRANGE("Vendor No.", PurchLine."Buy-from Vendor No.");
        //         ToleranceExceptions.SETRANGE(Type, PurchLine.Type);
        //         if ToleranceExceptions.FINDFIRST() then
        //             ToleranceExceptionFound := true
        //         else begin
        //             ToleranceExceptions.SETRANGE("Vendor No.", '');
        //             if ToleranceExceptions.FINDFIRST() then
        //                 ToleranceExceptionFound := true;
        //         end;

        //         if not ToleranceExceptionFound then
        //             UpperPercAmt := PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * (100 + PurchSetup."Upper % Tolerance") / 100
        //         else
        //             UpperPercAmt := PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * (100 + ToleranceExceptions."Upper % Tolerance") / 100;

        //         PurchaseInvoiceAmount := PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * ((100 - PurchLine."Line Discount %") / 100);

        //         if ABS(PurchaseInvoiceAmount) > ABS(UpperPercAmt) then begin
        //             PurchLine."Tolerance Exceeded FND" := true;
        //             PurchLine.MODIFY(false);
        //             if GUIALLOWED and not HideToleranceWarning then
        //                 MESSAGE(Text001, PurchLine."Line No.", PurchaseInvoiceAmount - UpperPercAmt);
        //         end;

        //         PurchaseReceiptAmount := (PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") + PurchSetup."Upper Amount Tolerance";

        //         PurchaseReceiptAmountTolExcpt := (PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") + ToleranceExceptions."Upper Amount Tolerance";

        //         if not ToleranceExceptionFound then begin
        //             if PurchaseInvoiceAmount > PurchaseReceiptAmount then begin
        //                 PurchLine."Tolerance Exceeded FND" := true;
        //                 PurchLine.MODIFY(false);
        //                 if GUIALLOWED and not HideToleranceWarning then
        //                     MESSAGE(Text002, PurchLine."Line No.", PurchaseInvoiceAmount - PurchaseReceiptAmount);
        //             end;
        //         end else
        //             if PurchaseInvoiceAmount > PurchaseReceiptAmountTolExcpt
        //             then begin
        //                 PurchLine."Tolerance Exceeded FND" := true;
        //                 PurchLine.MODIFY(false);
        //                 if GUIALLOWED and not HideToleranceWarning then
        //                     MESSAGE(Text002, PurchLine."Line No.", PurchaseInvoiceAmount - PurchaseReceiptAmountTolExcpt);
        //             end;
        //     end;
        // end;
        //HEI.154<<
        if PurchLine."Receipt No." <> '' then begin
            PurchRcptLine.GET(PurchLine."Receipt No.", PurchLine."Receipt Line No.");
            PurchLine."Tolerance Exceeded FND" := false;
            PurchLine.MODIFY(false);

            ToleranceExceptionFound := false;
            ToleranceExceptions.SETRANGE("Vendor No.", PurchLine."Buy-from Vendor No.");
            ToleranceExceptions.SETRANGE(Type, PurchLine.Type);
            if ToleranceExceptions.FINDFIRST() then
                ToleranceExceptionFound := true
            else begin
                ToleranceExceptions.SETRANGE("Vendor No.", '');
                if ToleranceExceptions.FINDFIRST() then
                    ToleranceExceptionFound := true;
            end;

            if not ToleranceExceptionFound then
                UpperPercAmt := PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * (100 + PurchSetup."Upper % Tolerance FND") / 100
            else
                UpperPercAmt := PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * (100 + ToleranceExceptions."Upper % Tolerance") / 100;

            PurchaseInvoiceAmount := PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * ((100 - PurchLine."Line Discount %") / 100);

            if ABS(PurchaseInvoiceAmount) > ABS(UpperPercAmt) then begin
                PurchLine."Tolerance Exceeded FND" := true;
                PurchLine.MODIFY(false);
                if GUIALLOWED and not HideToleranceWarning then
                    MESSAGE(Text001, PurchLine."Line No.", PurchaseInvoiceAmount - UpperPercAmt);
            end;

            PurchaseReceiptAmount := (PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") + PurchSetup."Upper Amount Tolerance FND";

            PurchaseReceiptAmountTolExcpt := (PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") + ToleranceExceptions."Upper Amount Tolerance";

            if not ToleranceExceptionFound then begin
                if PurchaseInvoiceAmount > PurchaseReceiptAmount then begin
                    PurchLine."Tolerance Exceeded FND" := true;
                    PurchLine.MODIFY(false);
                    if GUIALLOWED and not HideToleranceWarning then
                        MESSAGE(Text002, PurchLine."Line No.", PurchaseInvoiceAmount - PurchaseReceiptAmount);
                end;
            end else
                if PurchaseInvoiceAmount > PurchaseReceiptAmountTolExcpt
                then begin
                    PurchLine."Tolerance Exceeded FND" := true;
                    PurchLine.MODIFY(false);
                    if GUIALLOWED and not HideToleranceWarning then
                        MESSAGE(Text002, PurchLine."Line No.", PurchaseInvoiceAmount - PurchaseReceiptAmountTolExcpt);
                end;
        end;
        // BC Upgrade PATELP08 <<
    end;

    procedure CheckToleranceWarning(var PurchLine: Record "Purchase Line");// BC Upgrade SHUKLP03 << Made this procedure global, so that can call in Interface codeunit InterfacePurchCode.
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
        ToleranceExceptions: Record "Tolerance Exceptions FND";
        ToleranceExceptionFound: Boolean;
        LowerAmt: Decimal;
        LowerPercAmt: Decimal;
        PurchaseInvoiceAmount: Decimal;
        PurchaseReceiptAmount: Decimal;
        PurchaseReceiptAmountTolExcpt: Decimal;
        UpperAmt: Decimal;
        UpperPercAmt: Decimal;
    begin
        //HEI.154>>
        GetPurchSetup();
        PurchaseInvoiceAmount := 0;
        PurchaseReceiptAmount := 0;
        if not PurchSetup."Invoice Toler.CheckEnabled FND" then
            exit;
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases.
        // with PurchLine do begin
        //     if "Receipt No." <> '' then begin
        //         PurchRcptLine.GET("Receipt No.", "Receipt Line No.");
        //         "Tolerance Exceeded FND" := false;
        //         MODIFY(false);

        //         ToleranceExceptionFound := false;
        //         ToleranceExceptions.SETRANGE("Vendor No.", PurchLine."Buy-from Vendor No.");
        //         ToleranceExceptions.SETRANGE(Type, PurchLine.Type);
        //         if ToleranceExceptions.FINDFIRST() then
        //             ToleranceExceptionFound := true
        //         else begin
        //             ToleranceExceptions.SETRANGE("Vendor No.", '');
        //             if ToleranceExceptions.FINDFIRST() then
        //                 ToleranceExceptionFound := true;
        //         end;

        //         if not ToleranceExceptionFound then
        //             UpperPercAmt := PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * (100 + PurchSetup."Upper % Tolerance") / 100
        //         else
        //             UpperPercAmt := PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * (100 + ToleranceExceptions."Upper % Tolerance") / 100;

        //         PurchaseInvoiceAmount := PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * ((100 - PurchLine."Line Discount %") / 100);

        //         if ABS(PurchaseInvoiceAmount) > ABS(UpperPercAmt) then begin
        //             if not CONFIRM(Text001 + Text008, true, PurchLine."Line No.", PurchaseInvoiceAmount - UpperPercAmt) then
        //                 ERROR('');
        //             PurchLine."Tolerance Exceeded FND" := true;
        //             PurchLine.MODIFY(false);
        //         end;

        //         PurchaseReceiptAmount := (PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") + PurchSetup."Upper Amount Tolerance";
        //         PurchaseReceiptAmountTolExcpt := (PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") + ToleranceExceptions."Upper Amount Tolerance";

        //         if not ToleranceExceptionFound then begin
        //             if PurchaseInvoiceAmount > PurchaseReceiptAmount then begin
        //                 if not CONFIRM(Text002 + Text008, true, PurchLine."Line No.", PurchaseInvoiceAmount - PurchaseReceiptAmount) then
        //                     ERROR('');
        //                 PurchLine."Tolerance Exceeded FND" := true;
        //                 PurchLine.MODIFY(false);
        //             end;
        //         end else
        //             if PurchaseInvoiceAmount > PurchaseReceiptAmountTolExcpt then begin
        //                 if not CONFIRM(Text002 + Text008, true, PurchLine."Line No.", PurchaseInvoiceAmount - PurchaseReceiptAmountTolExcpt) then
        //                     ERROR('');
        //                 PurchLine."Tolerance Exceeded FND" := true;
        //                 PurchLine.MODIFY(false);
        //             end;
        //         if not ToleranceExceptionFound then
        //             LowerPercAmt := PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * PurchSetup."Lower % Tolerance" / 100
        //         else
        //             LowerPercAmt := PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * ToleranceExceptions."Lower % Tolerance" / 100;
        //         if ABS(PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") < ABS(PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" - LowerPercAmt) then
        //             if GUIALLOWED then begin
        //                 if not CONFIRM(Text003 + Text008, true, PurchLine."Line No.", PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" - LowerPercAmt -
        //                 PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") then
        //                     ERROR('');
        //             end;

        //         if not ToleranceExceptionFound then begin
        //             if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" < PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice"
        //                 - PurchSetup."Lower Amount Tolerance" then
        //                 if GUIALLOWED then begin
        //                     if not CONFIRM(Text004 + Text008, true, PurchLine."Line No.", PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" - PurchSetup."Lower Amount Tolerance"
        //                     - PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") then
        //                         ERROR('');
        //                 end;
        //         end else
        //             if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" < PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" -
        //                ToleranceExceptions."Lower Amount Tolerance"
        //             then
        //                 if GUIALLOWED then begin
        //                     if not CONFIRM(Text004 + Text008, true, PurchLine."Line No.", PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" - ToleranceExceptions."Lower Amount Tolerance" -
        //                       PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") then
        //                         ERROR('');
        //                 end;
        //     end;
        // end;
        //HEI.154<<
        if PurchLine."Receipt No." <> '' then begin
            PurchRcptLine.GET(PurchLine."Receipt No.", PurchLine."Receipt Line No.");
            PurchLine."Tolerance Exceeded FND" := false;
            PurchLine.MODIFY(false);

            ToleranceExceptionFound := false;
            ToleranceExceptions.SETRANGE("Vendor No.", PurchLine."Buy-from Vendor No.");
            ToleranceExceptions.SETRANGE(Type, PurchLine.Type);
            if ToleranceExceptions.FINDFIRST() then
                ToleranceExceptionFound := true
            else begin
                ToleranceExceptions.SETRANGE("Vendor No.", '');
                if ToleranceExceptions.FINDFIRST() then
                    ToleranceExceptionFound := true;
            end;

            if not ToleranceExceptionFound then
                UpperPercAmt := PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * (100 + PurchSetup."Upper % Tolerance FND") / 100
            else
                UpperPercAmt := PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * (100 + ToleranceExceptions."Upper % Tolerance") / 100;

            PurchaseInvoiceAmount := PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * ((100 - PurchLine."Line Discount %") / 100);

            if ABS(PurchaseInvoiceAmount) > ABS(UpperPercAmt) then begin
                if not CONFIRM(Text001 + Text008, true, PurchLine."Line No.", PurchaseInvoiceAmount - UpperPercAmt) then
                    ERROR('');
                PurchLine."Tolerance Exceeded FND" := true;
                PurchLine.MODIFY(false);
            end;

            PurchaseReceiptAmount := (PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") + PurchSetup."Upper Amount Tolerance FND";
            PurchaseReceiptAmountTolExcpt := (PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") + ToleranceExceptions."Upper Amount Tolerance";

            if not ToleranceExceptionFound then begin
                if PurchaseInvoiceAmount > PurchaseReceiptAmount then begin
                    if not CONFIRM(Text002 + Text008, true, PurchLine."Line No.", PurchaseInvoiceAmount - PurchaseReceiptAmount) then
                        ERROR('');
                    PurchLine."Tolerance Exceeded FND" := true;
                    PurchLine.MODIFY(false);
                end;
            end else
                if PurchaseInvoiceAmount > PurchaseReceiptAmountTolExcpt then begin
                    if not CONFIRM(Text002 + Text008, true, PurchLine."Line No.", PurchaseInvoiceAmount - PurchaseReceiptAmountTolExcpt) then
                        ERROR('');
                    PurchLine."Tolerance Exceeded FND" := true;
                    PurchLine.MODIFY(false);
                end;
            if not ToleranceExceptionFound then
                LowerPercAmt := PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * PurchSetup."Lower % Tolerance FND" / 100
            else
                LowerPercAmt := PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" * ToleranceExceptions."Lower % Tolerance" / 100;
            if ABS(PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") < ABS(PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" - LowerPercAmt) then
                if GUIALLOWED then begin
                    if not CONFIRM(Text003 + Text008, true, PurchLine."Line No.", PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" - LowerPercAmt -
                    PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") then
                        ERROR('');
                end;

            if not ToleranceExceptionFound then begin
                if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" < PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice"
                    - PurchSetup."Lower Amount Tolerance FND" then
                    if GUIALLOWED then begin
                        if not CONFIRM(Text004 + Text008, true, PurchLine."Line No.", PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" - PurchSetup."Lower Amount Tolerance FND"
                        - PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") then
                            ERROR('');
                    end;
            end else
                if PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" < PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" -
                    ToleranceExceptions."Lower Amount Tolerance"
                then
                    if GUIALLOWED then begin
                        if not CONFIRM(Text004 + Text008, true, PurchLine."Line No.", PurchRcptLine."Direct Unit Cost" * PurchLine."Qty. to Invoice" - ToleranceExceptions."Lower Amount Tolerance" -
                            PurchLine."Direct Unit Cost" * PurchLine."Qty. to Invoice") then
                            ERROR('');
                    end;
        end;
        // BC Upgrade PATELP08 <<
    end;

    procedure SupressToleranceWaring();
    begin
        HideToleranceWarning := true; //HEI.154
    end;
    //BC Upgrade SHARMP16 begin>>---------------- Interface Code
    // [EventSubscriber(ObjectType::Codeunit, 5813, 'OnBeforeUndoPurchReceiptLine', '', false, false)]
    // local procedure OnBeforeUndoReceipt_Zycus(var precPurchRcptLine: Record "Purch. Rcpt. Line");
    // var
    //     PurchRcptHeaderAdditional: Record "Purch. Rcpt. Header Add FND";
    //     SelectedCounts: Integer;
    //     ItemFound: Boolean;
    //     PurchRcptLine: Record "Purch. Rcpt. Line";
    //     POSMGRCountError: Label 'Total line count is %1 while you have selected %2 lines only. Item Receipts is posted against Zycus Order and hence partial cancellation is not allowed. Please select all line and try "Undo receipt".';
    // begin
    //     //HEI.161>>
    //     //HEI.163>>
    //     GetZycusInterfaceSetup_Zycus;
    //     if not ZycusInterfaceSetupRead then begin
    //         CLEAR(ZycusInterfaceSetup);
    //         exit;
    //     end;
    //     if not ZycusInterfaceSetup."Activate POSM GR Interface" then begin
    //         CLEAR(ZycusInterfaceSetup);
    //         CLEAR(ZycusInterfaceSetupRead);
    //         exit;
    //     end;
    //     //HEI.163<<
    //     if not PurchRcptHeaderAdditional.GET(precPurchRcptLine."Document No.") then
    //         exit;
    //     if PurchRcptHeaderAdditional."Zycus Order No." = '' then
    //         exit;
    //     SelectedCounts := 0;
    //     ItemFound := false;
    //     if precPurchRcptLine.findset(false) then begin
    //         repeat
    //             if (precPurchRcptLine.Type = precPurchRcptLine.Type::Item) and (precPurchRcptLine.Quantity > 0) then begin
    //                 SelectedCounts += 1;
    //                 ItemFound := true;
    //             end;
    //         until precPurchRcptLine.NEXT = 0;
    //     end;
    //     precPurchRcptLine.FINDFIRST;
    //     if ItemFound then begin
    //         //Partial GR Cancellation is not allowed in Zycus.
    //         PurchRcptLine.RESET;
    //         PurchRcptLine.SETRANGE("Document No.", precPurchRcptLine."Document No.");
    //         PurchRcptLine.SETFILTER("Zycus Order No.", '<>%1', '');
    //         PurchRcptLine.SETFILTER(Quantity, '>%1', 0);
    //         PurchRcptLine.SETRANGE(Type, PurchRcptLine.Type::Item);
    //         PurchRcptLine.findset(false);
    //         if PurchRcptLine.COUNT <> SelectedCounts then
    //             ERROR(POSMGRCountError, PurchRcptLine.COUNT, SelectedCounts);
    //     end;
    //     //HEI.161<<
    //     //HEI.163>>
    //     CLEAR(ZycusInterfaceSetup);
    //     CLEAR(ZycusInterfaceSetupRead);
    //     //HEI.163<<
    // end;
    //BC Upgrade SHARMP16 end<<---------------- Interface Code

    //BC Upgrade SHARMP16 begin>>---------------- Interface Code
    // [EventSubscriber(ObjectType::Codeunit, 5813, 'OnAfterUndoPurchReceiptLine', '', false, false)]
    // local procedure OnAfterUndoReceipt_Zycus(var precPurchRcptLine: Record "Purch. Rcpt. Line");
    // var
    //     PurchRcptHdr: Record "Purch. Rcpt. Header";
    //     //   ZycusInterfaceManagement: Codeunit "Zycus Interface Management";//BC Upgrade SHARMP16-- Interface changes
    //     //  InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";//BC Upgrade SHARMP16-- Interface changes
    //     PurchRcptLine: Record "Purch. Rcpt. Line";
    // begin
    //     //HEI.159<<
    //     if precPurchRcptLine.ISTEMPORARY then
    //         exit;
    //     //HEI.163>>
    //     GetZycusInterfaceSetup_Zycus;
    //     if not ZycusInterfaceSetupRead then begin
    //         CLEAR(ZycusInterfaceSetup);
    //         exit;
    //     end;
    //     if not ZycusInterfaceSetup."Activate POSM GR Interface" then begin
    //         CLEAR(ZycusInterfaceSetup);
    //         CLEAR(ZycusInterfaceSetupRead);
    //         exit;
    //     end;
    //     //HEI.163<<
    //     //Since Partial GR Cancellation is not allowed in Zycus, all eligible lines of Receipt document is filtered.
    //     //HEI.161>>
    //     PurchRcptLine.RESET;
    //     PurchRcptLine.SETRANGE("Document No.", precPurchRcptLine."Document No.");
    //     PurchRcptLine.SETRANGE(Type, PurchRcptLine.Type::Item);
    //     PurchRcptLine.SETFILTER(Quantity, '>%1', 0);
    //     PurchRcptLine.SETFILTER("Zycus Order No.", '<>%1', '');
    //     if PurchRcptLine.findset(false) then begin
    //         PurchRcptHdr.GET(PurchRcptLine."Document No.");
    //         //HEI.161<<
    //         ZycusInterfaceManagement.CreateOutboundPOSMGRCancellation_Zycus(PurchRcptHdr, InterfaceEntryHeaderVIP);
    //         repeat
    //             if InterfaceEntryHeaderVIP."Entry No." <> 0 then
    //                 //HEI.161>>
    //                 ZycusInterfaceManagement.CreateOutboundLinesPOSMGRCancellation_Zycus(InterfaceEntryHeaderVIP, PurchRcptLine);
    //         until PurchRcptLine.NEXT = 0;
    //         //HEI.161<<
    //         PurchRcptHdr."POSM GR Confirmed" := false;
    //         PurchRcptHdr.MODIFY;
    //     end;
    //     //HEI.159<<
    //     //HEI.163>>
    //     CLEAR(ZycusInterfaceSetup);
    //     CLEAR(ZycusInterfaceSetupRead);
    //     //HEI.163<<
    // end;
    //BC Upgrade SHARMP16 end<<---------------- Interface Code

    //BC Upgrade SHARMP16 begin>>---------------- Interface Code
    // local procedure GetZycusInterfaceSetup_Zycus();
    // begin
    //     //HEI.163>>
    //     if not ZycusInterfaceSetupRead then begin
    //         if ZycusInterfaceSetup.GET and ZycusInterfaceSetup."Enabled Zycus Integration" then
    //             ZycusInterfaceSetupRead := true;
    //     end;
    //     //HEI.163<<
    // end;
    //BC Upgrade SHARMP16 end<<---------------- Interface Code

    // BC Upgrade PATELP08 >>
    //HEI.164>>
    procedure CheckBlockedVendorOnDocuments(VAR Vendor: Record Vendor; VAR PurchaseHeader: Record "Purchase Header")
    begin
        IF Vendor.Blocked = Vendor.Blocked::Order THEN BEGIN
            IF PurchaseHeader."Document Type" IN [PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::"Return Order"] THEN
                ERROR(VendorIsBlockedErr, Vendor."No.", FORMAT(PurchaseHeader."Document Type"));
        END;
    end;
    //HEI.164<<
    // BC Upgrade PATELP08 <<
}



