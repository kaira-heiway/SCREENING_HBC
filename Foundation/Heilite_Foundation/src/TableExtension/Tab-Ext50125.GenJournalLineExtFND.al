tableextension 50125 GenJournalLineExtFND extends "Gen. Journal Line"
{
    // version NAVW110.0.00.16996,FINXL10.01,DITW110.00.11,HEI.61
    // DITW15.00.00.01 DDR 27/12/2007 added fields
    //                                  2034647 "Drink Tax Group Code"
    // DITW15.00.00.01 DDR 02/01/2008 rename field
    //                                  2034647 "Cust/Vendor DTax Group Code" + Filter to the source table
    // DITW15.00.00.01 DDR 04/01/2008 added field
    //                                  2013610 "Cust/Vend DepositChrg.Gr. Code"
    // DITW15.00.00.01 DDR 06/02/2008 various captions
    //                                rename field
    //                                  2013610 "Cust/Vendor Deposit Group Code"
    // DITW15.00.00.01 DDR 08/02/2008 Added Drink-It Periodic Discounts & Promotions functionnalities
    //                                added function
    //                                  TestPeriodicWkshtLine
    //                                added fields + keys
    //                                  2013783 "Applies-to D/P Line No."
    // DITW15.00.00.01 DDR 18/02/2008 bugfix function TestPeriodicWkshtLine() with SetupNewLine()
    //                                added fields + key
    //                                  2013784 "Applies-to D/P Line Type"
    //                                added function GetDimBufToJnlLineDim() to read the current buffer created for current line
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.20 DDR 11/06/2008 Certification rules
    // DITW15.00.00.24 DDR 14/08/2008 Delete Detailed Shipping Provision Lines when delete a journal line.
    // DITW15.00.00.25 DDR 16/10/2008 Added fields
    //                                  2014077 Truck Code
    //                                  2014078 Driver Code
    // DITW15.00.00.26 DDR 21/11/2008 Added key
    //                                 "Journal Template Name,Journal Batch Name,Driver Code,Truck Code,Document No.,Document Date"
    // DITW15.00.00.34 DDR 10/06/2009 Added fields + key
    //                                 2013822 Applies-to D/P Source Table
    // DITW15.00.00.35 DDR 21/04/2009 Added fields
    //                                  2034872 Contract Group Code
    //                     28/08/2009 Fill in field "Contract Group Code" when use field "Applies-to Doc. No."
    //                     22/09/2009 issue 813 Added to use "Contract Cust. Posting Group" or "Contract Vend. Posting Group" (from card)
    //                                           with contract groups
    //                     23/09/2009 issue 814 Split customer posting group per contract type
    //                                Added fields
    //                                  2034850 DIT Sub-Contract Type
    //                                  2034915 Service Contract No.
    //                     26/10/2009 issue 857 Modified Apply per Contract group code mandatory (blank as value)
    // DITW15.00.00.37 DDR 27/01/2010 issue 1053 Bugfix Standard into function ValidateApplyRequirements()
    //                     28/01/2010 issue 879 Added fields
    //                                  2034840 Building No.
    //                                Added new argument Type6,No6 into function CreateDim()
    //                     11/02/2010 issue 857 Added checking between contract group of journal line & already applied lines
    //                     10/05/2010 issue 857 Bugfix skip contract group filters when not mandatory
    //                                          Added property tablerelation for field2034872 Contract group code
    //                                          Removed function ValidateApplyReqContract()
    //                                          Added function SetApplyFields()
    //                     20/05/2010 issue 929 Modified option caption field2034850 DIT Sub-Contract Type
    //                     01/06/2010 issue 857 Bugfix to set the field "posting group" when use field "DIT Sub-contract type"
    //                                          Reviewed security tests when change DIT contract fields
    // DITW15.00.00.38 DDR 10/12/2010 issue 1173 Bugfix to check "DIT Sub-Contract Type","Contract Group Code" after marked entries
    // DITW15.00.00.38 DDR 10/12/2010 issue 1221 Added fields
    //                                  2013726 Customer Tax Registration No.
    //                                  2014271 Customer Tax Warehouse Ref.
    // DITW15.00.00.39 DDR 09/05/2011 issue 1328 Shop (iPos) Functionnalities
    //                                  Added fields
    //                                    2013969 Pos System-Created Entry
    //                                Added function DeleteLinkPosPayEntries()
    //                     01/07/2011 issue 730 Added to delete link to Periodic Purchase Discount/Promotion
    // DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297 Plant Maintenance Functionnality
    //                                             Added 'PlantMaintenance' option field2034850 "DIT Sub-Contract Type"
    // DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392
    //                                Added fields
    //                                  2014310 Service Contract Line No.
    //                                  2014311 Service Contract Type
    //                                Modified 'TableRelation' property field2034872 Contract Group Code
    //                                Added functions SetFilterSubContractPostType()
    //                                Modified 'TableRelation' property field4, field11 (Bal.) Account no.
    //                                Added 'Type7,No7' paramerters functions CreateDim()
    //                  AHU 13/08/2012 DIT-715 #327 Renamed Captions fields2034915,2034310,2014311
    //                                              Added default value field2014311 "Service Contract Type"
    //                                              Keep value field2034850 "DIT Sub-Contract Type" while modifying "Service contract type"
    //                  AHU 31/08/2012 DIT-715 #327 Bugfix function CreateDim()
    //                  AHU 20/09/2012 DIT-715 #327 Added functions GetSourceType()
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields
    //                                               2013695 Item Charge Type
    //                                             Added GL Setup field "Appln. per Source reference"
    //                 DDR 11/12/2012 DIT-715 #370 Bugfix to copy and filter on applied field "item Charge Type"
    //                 AHU 18/12/2012 DIT-715 #327 Removed clear all contract fields when changing Balance Account
    //                                             Modified 'TableRelation' property field2034915 Service contract no.
    //                 DDR 28/02/2013 DIT-715 #567 Bugfix missing "Posting Group" when applying any document before Dit sub-contract type
    // DITW16.00.00.43 DDR 02/05/2013 DIT-715 #575 Modified allow "Contract Group Code" when applying any contract document.
    //                 DDR 13/05/2013 DIT-715 #567 Modified functions SetApplyFields()
    //                 DDR 10/06/2013 DIT-715 #641 Modified workflow to select "Service Contract No." before "DIT Sub-Contract Type"
    //                                             Added fields
    //                                               2014313 DIT Sub-Contract Type Filter
    //                 DDR 17/06/2013 DIT-715 #610 Modified TableRelation field2034915, remove "Status" filter
    //                                             Added fields
    //                                               2014314 Source Type Filter
    //                                               2014315 Source No. Filter
    //                                             Added functions UpdateSourceFilter()
    //                 FBL 11/07/2013 DIT-715 #620 Remove bill-to customer no. from tablerelation filter of field "Service Contract No."
    //                 DDR 14/08/2013 DIT-715 #678 Added fields
    //                                               2013611 Deposit Amount
    //                                               2013612 Deposit Amount (LCY)
    //                 DDR 14/11/2013 DIT-715 #827 Bugfix wrong "Posting Group" while selecting Contract
    //                 DDR 15/11/2013 DIT-715 #827 Modified 'TableRelation' field2034915

    // FINXL7.00 RBE 20/03/2013 : Advanced application
    //                                 Created field 2029611
    //                                 Extended Description from 50 to 80
    //                                 Created new field 2029610 OGM
    // FINXL7.00 WSA 05/07/2014 : Added function parameter (after merge Rollup8)
    // FINXL8.00.001 BSA 25/05/2015 #174: Check Journal template and Batch for "Auto. Acc. Group"
    // FINXL9.00.001 DAT 19/02/2016 : Adjust Advanced application

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 DDR 02/05/2013 DIT-715 #575
    //                  13/05/2013 DIT-715 #567
    //                  10/06/2013 DIT-715 #641
    //                  17/06/2013 DIT-715 #641
    //              FBL 11/07/2013 DIT-715 #620 merge
    //              DDR 19/08/2013 DIT-715 #678 merge

    // DITW17.00.02 SR 10/09/2013 DIT-770 #137 : Add options 'Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back' to "Document Type"
    //                                         : Add options 'Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back' to "Applies-to Doc. Type"
    //                                         : New Field "Payment Type" "2014316" added
    // DITW17.00.02 DDR 14/11/2013 DIT-715 #827 merge
    // DITW17.00.02 DDR 18/11/2013 DIT-715 #827 Merge
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 AT  17/12/2013 DIT-770 #163 : Validation to Posting Group
    // DITW17.00.02 SR 19/12/2013 DIT-770 #163  : New Code Added to Block the Testfield of "DIT Sub-Contract Type"
    //                                          : New Code Added
    //                                          : Remove the "DIT Sub-Contract Type" filter in "Service Contract No." field
    // DITW17.00.02 AT 22/01/2014 DIT-770 #163  : Remove check in general that only GL accounts can be selected with DIT Contract type filled, if a Contract no is filled in
    // DITW17.10.03 AT  05/02/2014 DIT-770 #340 : Posting group to be copied from Applied Entry
    //                                          :  Fix Bug on Selecting Document Type
    // DITW17.10.03 MSF 17/03/2014 DIT-715 #340 : Posting group to be copied from Applied Entry
    // DITW17.10.03 MSF 08/04/2014 DIT-770 #340 :DIT-770 340 Variable customer posting group  (Point 12 Remove Bank chagre cust. posting group)
    // DITW17.00.03 DDR 14/04/2014 DIT-770 #634 :Workaround NAV2013(R1) modified optionstring-captions fields
    //                                             2014312 DIT Sub-Contr.Pst. Type Filter
    //                                             2014313 DIT Sub-Contract Type Filter
    //                                           Bugfix tablerelation filters field4 Account No.
    // DITW17.10.03 DDR 13/05/2014 DIT-770 #231 Bugfix while validating "service contract no." with G/L account = fixed asset
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.03 MSF 28/05/2014 DIT-770 #715 Upgrade W1 Rollup 6 ChangeLog.W1.36366 file 474255
    // DITW17.10.03 DDR 07/07/2014 DIT-770 #231 Bugfix to reset "DIT Sub-Contr.Pst. Type Filter" flowfilte
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.05 YHE 28/08/2014 DIT-770 #756 : Added field (2014317-"Create from DIT Contract"),(2014318-"Contract Posting Date")
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 10/04/2015 DIT-770 #1326 Error on Create Loan Pay Back Journal: (The Customer does not exist...... No. = ")
    // DITW18.00.06 MSF 12/05/2015 DIT-770 #1375 wrong check/init contract type
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Modify DIT Contract by Financial Contract
    //                                           Rename field 2014317 "Create from DIT Contract" to "Create from Financial Contract"
    //                                           Rename "Contract No." to "Service Contract No."
    //                                           Added field 2014319  "Financial Contract No."
    //                                           Added function GetContractNo
    //                                           Change ID of field Contract Type to Foundation layer 2035393
    //                                           Added blank Option to Contract Type
    //                                           Rename option Service contract,DIT contract to Service,Financial
    // DITW18.00.06 DDR 07/08/2015 DIT-770 #1368 Various adjustments
    // DITW18.00.06 10/09/2015 DIT-770 #1566 Error message on Create Loan Payback Journal when Loan Cust. Entry (Payback) has a value
    // DITW18.00.06 13/10/2015 DIT-770 #1566 Move Function pickupDocument in Trigger Apply to doc No after reset Dit fields
    // DITW18.00.07 AKH 07/01/2016 DIT-770 #1473 Contract management - Loan pay back additions: Merge WGR-001 #410
    // DITW18.10.07 WSA 21/04/2016 DIT-770 #1723 Added Field "Invoice List Document No."
    // DITW18.10.07 VSC 01/06/2016 DIT-770 #2005 Posting group not set from Applied Vendor ledger entry in Journal line
    // DITW18.10.07 VSC 15/06/2016 DIT-770 #2005 Set Posting Group using Lookup
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.09 AKH 29/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.10 AKH 28/07/2017 NRQ#17189 Added Payment Method Code to function GetPaymentChargeType()
    // DITW110.00.11 MSF 25/08/2017 NRQ#17902 Route settlement - Order Payments, Suggest customer and vendor payments
    //                                  2014109 Route Planning No.
    //                                  2014421 Document Subtype Code

    // HEI.01 SOICAD01 new field CV Detailed Entry No.
    // HEI.02 PTPGAP066 IBM SOICAD01 29.06.2017 Purchase to Pay– Bank account for payment
    //   # New field Vendor Bank Account
    //   # Code for handling Vendor Bank Account
    // HEI.04 PTPGAP068 IBM COSTES02 18.08.2017 Payment Proposal grouping/archiving
    //   # New fields Tree Level, Archive Document No.,Parent Line No.
    // HEI.05 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # New fields for MDM integration
    // HEI.06 FDD-RTRGAP056 IBM HORTOC01 25.08.2017
    //   # New fields added
    //     Add new option to "Document type" field - "Purchase Receipt"
    // HEI.07 FDD-RTRGAP060 IBM HORTOC01 1.09.2017
    //   # New field
    // HEI.08 FDD-SLSGAP001 IBM NASTAA02 08.09.2017 # MDM Customer Card
    //   # Increased "Cust/Vendor DTax Group Code" field length from 10 to 20 characters
    // HEI.09 PTPGAP067 IBM ISYED01 08/09/2017 Purchase To Pay downPayment
    //   # Added options Prepayment Invoice,Prepayment Credit Memo to Field Document Type
    // HEI.10 FDD-KDD0TC002 IBM HORTOC01 04.10.2017 - new option on "Document type" field - "Interest Rate Credit"
    // HEI.11 FDD-KDD0TC004 IBM NASTAA02 13.10.2017 # OTC - Returnable Packaging Material - RPM
    //   # New option "RPM Damage or Loss" added on "Document Type" field
    //   # New field "RPM Original Sales Amount" created
    //   # New functions created "InsertDifferenceRPMAmtLine", "InsertFAGLJnlLine" to insert RPM lines
    // HEI.12 FDD-KDDOTC007 IBM.NAIKH01 RPM Full-For-Empty Customer.
    //   # New option "FFE Security Payment" added on "Document Type" field
    // HEI.13 FDD-PTPGAP029 IBM.ISYED01 31/07/2017
    //   # Added code to clear Batch payment name field.
    // HEI.14 PTPGAP083 IBM NASTAA02 05.03.2018 # Mark Reversed Rejected Payments
    //   # New Field created: 50029 - Reversed
    // HEI.15 PTPGAP085 - IBM HORTOC01 20.03.2018
    //   # new fields
    // HEI.16 PTPGAP077 - IBM HORTOC01 23.03.2018
    //   # new fields
    // HEI.17 FDD PTPGAP078 IBM POSTOI01 18.05.2018
    //   # new field 50043 HNK Bank Account; Code20
    //   # new field 50044 HNK Check No; code 20
    // HEI.18 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //   # New Field created: 50046 - "TIN No."
    // HEI.19 BA-RTRGAP01 IBM NASTAA02 08.10.2018 # Bahamas VAT
    //   # "VAT Prod. Posting Group" should be replaced by "VAT Prod. Posting Group by Location" depending on TIN by Location when
    //     "Acount No." is filled in or when "VAT Prod. Posting Group is manually filled-in
    // HEI.20 FDD-BA-SLSGAP01 IBM NASTAA02 19.12.2018 # Counterpoint Interface
    //   # New Fields created: 50047 - Interface Code
    //                         50048 - CP Vendor Invoice No.
    // HEI.21 V1.05 HT84 IBM POENAB02 03.04.2019
    //   # New fields for Bank Connectivity interface
    //     # 50049 Instruction Priority
    //     # 50050 Code Expenses
    //     # 50051 Export Protocol Code
    //     # 50052 WS Posting Allowed
    //   # New function: GetExportProtocol
    // HEI.22 FDD-ET-HT695 IBM NASTAA02 05.07.2019 # RPM Payment Reconciliation and Offset
    //   # New Fields created: 50053 - Empties Item No.
    //                         50054 - Deposit Quantity
    // HEI.23 FDD-HT665 - Ethiopia Customize FA Ledger Entries IBM NASTAA02 09.07.2019 # Ethiopia Customize FA Ledger Entries
    //   # New Field created: 50055 - Reference Number
    //                        50056 - PO Number
    // HEI.24 FDD-CHG2022328 IBM POENAB02 01.08.2019 # External document No. duplication in journal
    //   #Code added in External Document No. - OnValidate

    // HEI.26 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New fields:
    //     # 10801 Bank Account Name
    //     # 10810 Entry Type
    //     # 10860 Entry No.
    //     # 10861 Derogatory Line FR LOC
    //     # 10862 Delayed Unrealized VAT
    //     # 10863 Realize VAT
    //     # 10864 Created from No.
    // HEI.27 CHG2030722 IBM.LS 19.09.2019
    //   # New field created:50061 - "Debit Amount (LCY)"
    //   # New field created:50062 - "Credit Amount (LCY)"
    //   # Code added to fetch the value.
    // HEI.25 FDD-HT584 IBM NASTAA02 02.09.2019 # La Reunion FA Derogatory Depreciation
    //   # Added new option 'Derogatory' to "FA Posting Type" Field
    //   # New Field created 10861 - Derogatory Line
    //   # New function created "GetDerogatorySetup"
    // HEI.28 FDD-HT594 IBM NASTAA02 07.10.2019 # La Reunion FA Requirements Vendor
    //   # New Field created: 50063 - Fixed Asset Acquisition
    // HEI.29 CHG2034492 Display Local
    //   # Add new field 50064 - "No. 2"
    // HEI.30 FDD-HT626 IBM SURYAS01 16-12-2019 Bank Connection Setup_La Réunion
    //   # Created New Field : "Transaction Code"
    // HEI.31 FDD-HT771 IBM SURYAS01 10-jan-2020 - "To calculate Currency Factor when changing the Document Date instead of changing the Posting Date"
    //  #Added Code in Document Date Onvalidate Trigger and commented code in Posting Date Onvalidate trigger.
    //  #Modified code in "Currency Code" onvalidate Trigger
    // HEI.32 FDD-HT971 IBM POSTOI01 14.01.2020 WHT for payments
    //   # new fields 50066 WHT Amount , 50067 WHT Amount(LCY)
    // HEI.33  defect 4888 SURYAS01 11-12-2019  (CU-25 patch)
    //     #Modified the code in Function ="IsOpenedFromBatch()"
    // HEI.34 CHG2040699 IBM POSTOI01 27.01.2020 Ivory Coast - WHT at the moment of payment
    //   # modify LookUpAppliesToDocVend procedure for WHT posting group updates
    // HEI.35 CHG2040699 IBM POSTOI01 14.02.2020 Ivory Coast - WHT at the moment of payment
    //   # modify LookUpAppliesToDocVend procedure for WHT posting group updates
    // HEI.36 FDD-HT1103 IBM SURYAS01  13-04-2020
    //   #Modified code in "GetVendorBalAccount" Function
    //   #Created New Function "UpdateHNKBankAccount"
    // HEI.39 CHG2065153 IBM KUMARN15 23.06.2020
    //   # Added field "Source System Identifier", code added on function CopyFromSalesHeader
    // HEI.40 FDD-CD-HT1350 IBM BULIMC01 13.07.2020
    //     #2 new fields added: 50070 - "Sales/Archived Order type", 50071 - "Related Sales Order"
    //     #new function created: "RelatedSalesNoLookUp()"
    //     #code added to the following OnValidate() triggers: Account No., Bal. Account No., Sales/Archived sales Orders
    // HEI.41 CHG2056569 IBM SURYAS01  17.07.2020
    //   #Created New Field : "50072"
    // HEI.42 FDD-CD-HT1350 IBM BULIMC01 18.08.2020
    //     #modify function  "RelatedSalesNoLookUp()"
    //     #new function created "RelatedSalesNoValidate()" and added to the trigger Related Sales Order - OnValidate()
    // HEI.43 FDD-HB1609 CHG2074002 IBM BULIMC01 03.09.2020 # new primary keys added:
    //  #"Journal Template Name,Journal Batch Name,Posting Date,Document No.,Gen. Bus. Posting Group,Gen. Prod. Posting Group"
    //  #"Journal Template Name,Journal Batch Name,Posting Date,Document No.,VAT Bus. Posting Group,VAT Prod. Posting Group"
    // HEI.45 CHG2086827 IBM POENAB02 Bank Connectivity DRC  complementing BRD HT84
    //  # New field: 50073 Amount LCY DRC
    // HEI.46 CHG2089956 IBM POENAB02 Issue with "Recipient Bank Account" in Payment Journal Tree
    //  # Modified functions GetVendorAccount, GetVendorBalAccount
    // HEI.47 CHG2090912 HB1641 IBM NANDIS01 01.02.2021 General Ledger Entries Description
    //  # Added a new field 50074 - "Additional Description"
    //  # Code added under function - CopyFromInvoicePostBuffer
    // HEI.48 FDD-HT1330 IBM BULIMC01 11.02.2021#new field added: 55002 - "Maison des Vins Dim. Code"
    // HEI.49 HT1812 IBM BULIMC01 24.02.2021#  #modified function "GetDimCaptionClass"
    //   #CaptionClass property of the field "Maison des Vins Dim. Code" changed to "GetDimCaptionClass(1)"
    // HEI.50 CHG2119178 IBM.AS 30.06.2021
    //   # HeiLite Base Stability Changes for Posting functions at JOB NAS
    //   # Adding GUIAllowed function added in Functions GetCustLedgerEntry(),
    //     GetVendLedgerEntry(),
    //     ExportPaymentFile(),
    //     CheckModifyCurrencyCode(),
    //     GetCustomerAccount(),
    //     GetCustomerBalAccount(),
    //     GetVendorAccount(),
    //     GetVendorBalAccount(),
    //     SetApplyFields()
    //  for JOB Execution to avoid any manual intervention
    // HEI.51 FDD-HT2159 - CHG2105031 IBM NASTAA02 23.08.2021 # Centime - additional tax on VAT
    //   # New Field created 50075 - CAD Amount
    // HEI.52 CHG2119679 IBM BHATTA09 08/09/2021
    //   # Commented HEI.27 and corrected it
    // HEI.53 CHG2190168 IBM POENAB02 25.01.2023 HB2330 BKT-EFT Citi bank payment file update for DRC
    //   # New field 50077 Value of Payment Method
    //   # 25.01.2023 Old CHG CHG2117475 was replaced with CHG2190168. Initial change was on 13.12.2021.
    // HEI.54 CHG2131424 IBM SISUM01 01/05/2023 HB2520 Dimension Validation HeiLite
    //   # New Field 50078 Created By Source Code
    // HEI.55 FDD-HB2311 CHG2200648 IBM NANDIS01 12-06-2023 #Correct posting flow FA invoicing (credit notes)
    //   # New Option String added - "Purchase Shipment" under field "Document Type"
    // HEI.56 CHG2187702 SAHAL01 18.09.2023 Revaluation journal items in error
    //   # Created New Fields: 50101 - Rev. Jnl. Error Log
    //                         50102 - Item Journal Template Name
    //                         50103 - Item Journal Batch Name
    //                         50104 - Item Journal Line No.
    // HEI.57 CHG2201773 HB3442 SRIVAS07 IBM 06/12/23 - Development - Undoing a Goods Receipt for Fixed Asset
    //   # Added new Field - Undo FA Receipt
    // HEI.58 CHG2224401 HB3624 YADAVM09 04.04.2024 Health and Security Levy Tax
    //   # New Field created
    //                       #"H&S Levy Tax Amount"
    //                       #"Total HS Tax Amount"
    //                       #"HS Posting Group"
    // HEI.59 CHG2246789 IBM KAPOOV01 22.04.2024 Code Optimization for Journal Posting
    //   # Modified Trigger OnDelete()
    // HEI.60 CHG2254359 SRIVAS07 IBM 18/06/24 - Increase to 35 characters the length of General Journal Line Reference No. field into General Journal Table
    //   # Reference No. - Increased 20 to 35 char
    // HEI.61 CHG2271823 IBM KAPOOV01 08.11.2024 Field to Block/Unblock General Journal templates
    //   #Added new functions-EnableActionIfTemplateNtBlock(),CheckBlockedTemplate()
    //   #Modified Trigger/Function-OnInsert(),OnModify(),OnDelete(),OnRename()

    // BC Upgrade SHUKLP03 >> Added Document subtype code field id 50090.
    //-------------------------------BC UPgrade SHARMP16 CU 90----------------------------------
    //Created New fields for FA posting cases in Purchase..
    //BC UPGRADE KUMARR78 >>
    // Changing for (FDD OTC 091/090)
    //Adding Field and Table Relation for Vehical and Driver Code. 
    //BC UPGARDE KUMARR78 <<
    fields
    {
        modify("Journal Template Name")
        {
            CaptionML = ENU = 'Journal Template Name', FRA = 'Nom modèle feuille';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify("Account Type")
        {
            CaptionML = ENU = 'Account Type', FRA = 'Type compte';
            //OptionCaptionML = ENU = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner', FRA = 'Général,Client,Fournisseur,Banque,Immobilisation,Partenaire IC';  // BC Upgrade NANDIS03

            // BC Upgrade NANDIS03 >>
            trigger OnAfterValidate()
            begin
                //>>HEI.11
                IF ("Document Type" = "Document Type"::"RPM Damage or Loss") AND
                   NOT ("Account Type" IN ["Account Type"::Customer, "Account Type"::"Fixed Asset", "Account Type"::"G/L Account"])
                THEN
                    ERROR(AccTypeNotInLineWithDocTypeErr, FIELDCAPTION("Account Type"), "Account Type", FIELDCAPTION("Document Type"), "Document Type");
                //<<HEI.11
                //PurchasesUtils.UpdateBankAcc(Rec, xRec);//HEI.02 PTPGAP066 new line  // BC Upgrade NANDIS03 - function moved from Purchase Utilities to this table extension
                UpdateBankAcc(Rec, xRec);  // BC Upgrade NANDIS03
            end;
            // BC Upgrade NANDIS03 <<
        }
        modify("Account No.")
        {
            //Unsupported feature: Change TableRelation on ""Account No."(Field 4)". Please convert manually.
            CaptionML = ENU = 'Account No.', FRA = 'N° compte';
            // BC Upgrade NANDIS03 >>
            trigger OnAfterValidate()
            begin
                UpdateBankAcc(Rec, xRec);
                GetDerogatorySetup();
            end;
            // BC Upgrade NANDIS03 <<
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            // OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back,Purchase Receipt,Interest Rate Credit,RPM Damage / Loss,FFE Security Payment,Purchase Shipment', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement,,,,,Banque inverse,Charge bancaire,Paiment prêt,Rembousement prêt,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment,Purchase Shipment';

            //Unsupported feature: Change OptionString on ""Document Type"(Field 6)". Please convert manually.


            //Unsupported feature: Change Description on ""Document Type"(Field 6)". Please convert manually.
            // BC Upgrade NANDIS03 >>
            trigger OnAfterValidate()
            begin
                //>>HEI.11
                IF ("Document Type" = "Document Type"::"RPM Damage or Loss") AND
                   NOT ("Account Type" IN ["Account Type"::Customer, "Account Type"::"Fixed Asset", "Account Type"::"G/L Account"])
                THEN
                    ERROR(AccTypeNotInLineWithDocTypeErr, FIELDCAPTION("Document Type"), "Document Type", FIELDCAPTION("Account Type"), "Account Type");
                //<<HEI.11
            end;
            // BC Upgrade NANDIS03 <<
        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("VAT %")
        {
            CaptionML = ENU = 'VAT %', FRA = '% TVA';
        }
        modify("Bal. Account No.")
        {

            //Unsupported feature: Change TableRelation on ""Bal. Account No."(Field 11)". Please convert manually.

            CaptionML = ENU = 'Bal. Account No.', FRA = 'N° compte contrepartie';
            trigger OnAfterValidate()
            begin
                //HEI.40>>
                IF Rec."Bal. Account No." <> xRec."Bal. Account No." THEN
                    VALIDATE("Related Sales Order FND", '');
                //HEI.40<<
            end;
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
            trigger OnAfterValidate()
            begin
                Rec.GetDerogatorySetup(); //HEI.25
                //HEI.27>>
                // IF "Amount (LCY)" > 0 THEN
                //                     "Debit Amount (LCY)" := "Amount (LCY)"
                //                 else
                //                     IF "Amount (LCY)" < 0 THEN
                //                         "Credit Amount (LCY)" := "Amount (LCY)"
                //                     else BEGIN
                //                         CLEAR("Debit Amount (LCY)");
                //                         CLEAR("Credit Amount (LCY)");
                //                     end;
                //HEI.27<<
                //>>HEI.52
                IF "Amount (LCY)" <> 0 THEN BEGIN
                    IF "Amount (LCY)" > 0 THEN BEGIN
                        "Debit Amount (LCY) FND" := "Amount (LCY)";
                        "Credit Amount (LCY) FND" := 0;
                    end else BEGIN
                        IF "Amount (LCY)" < 0 THEN
                            "Credit Amount (LCY) FND" := ABS("Amount (LCY)");
                        "Debit Amount (LCY) FND" := 0;
                    end;
                end else BEGIN
                    CLEAR("Debit Amount (LCY) FND");
                    CLEAR("Credit Amount (LCY) FND");
                end;
                //<<HEI.52
            end;
        }
        modify("Debit Amount")
        {
            CaptionML = ENU = 'Debit Amount', FRA = 'Montant débit';
        }
        modify("Credit Amount")
        {
            CaptionML = ENU = 'Credit Amount', FRA = 'Montant crédit';
        }
        modify("Amount (LCY)")
        {
            CaptionML = ENU = 'Amount (LCY)', FRA = 'Montant DS';
            trigger OnAfterValidate()
            begin
                //HEI.27>>
                // IF "Amount (LCY)" > 0 THEN
                //                     "Debit Amount (LCY)" := "Amount (LCY)"
                //                 else
                //                     IF "Amount (LCY)" < 0 THEN
                //                         "Credit Amount (LCY)" := "Amount (LCY)"
                //                     else BEGIN
                //                         CLEAR("Debit Amount (LCY)");
                //                         CLEAR("Credit Amount (LCY)");
                //                     end;
                //HEI.27<<
                //>>HEI.52
                IF "Amount (LCY)" <> 0 THEN BEGIN
                    IF "Amount (LCY)" > 0 THEN BEGIN
                        "Debit Amount (LCY) FND" := "Amount (LCY)";
                        "Credit Amount (LCY) FND" := 0
                    end else BEGIN
                        IF "Amount (LCY)" < 0 THEN
                            "Credit Amount (LCY) FND" := ABS("Amount (LCY)");
                        "Debit Amount (LCY) FND" := 0
                    end;
                end else BEGIN
                    CLEAR("Debit Amount (LCY) FND");
                    CLEAR("Credit Amount (LCY) FND");
                end;
                //<<HEI.52
            end;
        }
        modify("Balance (LCY)")
        {
            CaptionML = ENU = 'Balance (LCY)', FRA = 'Solde DS';
        }
        modify("Currency Factor")
        {
            CaptionML = ENU = 'Currency Factor', FRA = 'Facteur devise';
        }
        modify("Sales/Purch. (LCY)")
        {
            CaptionML = ENU = 'Sales/Purch. (LCY)', FRA = 'Ventes/Achats DS';
        }
        modify("Profit (LCY)")
        {
            CaptionML = ENU = 'Profit (LCY)', FRA = 'Marge DS';
        }
        modify("Inv. Discount (LCY)")
        {
            CaptionML = ENU = 'Inv. Discount (LCY)', FRA = 'Remise facture DS';
        }
        modify("Bill-to/Pay-to No.")
        {

            //Unsupported feature: Change TableRelation on ""Bill-to/Pay-to No."(Field 22)". Please convert manually.

            CaptionML = ENU = 'Bill-to/Pay-to No.', FRA = 'N° client facturé/personne à payer';
            trigger OnAfterValidate()
            begin
                Rec.UpdateBankAcc(Rec, xRec);  //HEI.02 PTPGAP066 new line  // BAC Upgrade NANDIS03
            end;
        }
        modify("Posting Group")
        {

            //Unsupported feature: Change TableRelation on ""Posting Group"(Field 23)". Please convert manually.

            CaptionML = ENU = 'Posting Group', FRA = 'Groupe comptabilisation';

            //Unsupported feature: Change Editable on ""Posting Group"(Field 23)". Please convert manually.

        }
        modify("Shortcut Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Shortcut Dimension 1 Code"(Field 24)". Please convert manually.

            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Shortcut Dimension 2 Code"(Field 25)". Please convert manually.

            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Salespers./Purch. Code")
        {

            //Unsupported feature: Change TableRelation on ""Salespers./Purch. Code"(Field 26)". Please convert manually.

            CaptionML = ENU = 'Salespers./Purch. Code', FRA = 'Code vendeur/acheteur';
        }
        modify("Source Code")
        {
            CaptionML = ENU = 'Source Code', FRA = 'Code journal';
        }
        modify("System-Created Entry")
        {
            CaptionML = ENU = 'System-Created Entry', FRA = 'Écriture système';
        }
        modify("On Hold")
        {
            CaptionML = ENU = 'On Hold', FRA = 'En attente';
        }
        modify("Applies-to Doc. Type")
        {
            CaptionML = ENU = 'Applies-to Doc. Type', FRA = 'Type doc. lettrage';
            // OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement';

            //Unsupported feature: Change OptionString on ""Applies-to Doc. Type"(Field 35)". Please convert manually.

        }
        modify("Applies-to Doc. No.")
        {
            CaptionML = ENU = 'Applies-to Doc. No.', FRA = 'N° doc. lettrage';
        }
        modify("Due Date")
        {
            CaptionML = ENU = 'Due Date', FRA = 'Date d''échéance';
        }
        modify("Pmt. Discount Date")
        {
            CaptionML = ENU = 'Pmt. Discount Date', FRA = 'Date d''escompte';
        }
        modify("Payment Discount %")
        {
            CaptionML = ENU = 'Payment Discount %', FRA = '% escompte';
        }
        modify("Job No.")
        {
            CaptionML = ENU = 'Job No.', FRA = 'N° projet';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("VAT Amount")
        {
            CaptionML = ENU = 'VAT Amount', FRA = 'Montant TVA';
        }
        modify("VAT Posting")
        {
            CaptionML = ENU = 'VAT Posting', FRA = 'Comptabilisation TVA';
            OptionCaptionML = ENU = 'Automatic VAT Entry,Manual VAT Entry', FRA = 'Automatique,Manuel';
        }
        modify("Payment Terms Code")
        {
            CaptionML = ENU = 'Payment Terms Code', FRA = 'Code condition paiement';
        }
        modify("Applies-to ID")
        {
            CaptionML = ENU = 'Applies-to ID', FRA = 'ID lettrage';
        }
        modify("Business Unit Code")
        {
            CaptionML = ENU = 'Business Unit Code', FRA = 'Code centre de profit';
        }
        modify("Journal Batch Name")
        {

            //Unsupported feature: Change TableRelation on ""Journal Batch Name"(Field 51)". Please convert manually.

            CaptionML = ENU = 'Journal Batch Name', FRA = 'Nom feuille';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
        }
        modify("Recurring Method")
        {
            CaptionML = ENU = 'Recurring Method', FRA = 'Mode abonnement';
            // OptionCaptionML = ENU = ' ,F  Fixed,V  Variable,B  Balance,RF Reversing Fixed,RV Reversing Variable,RB Reversing Balance', FRA = ' ,F Fixe,V Variable,S Solde,FI Fixe inverse,VI Variable inverse,SI Solde inverse';
        }
        modify("Expiration Date")
        {
            CaptionML = ENU = 'Expiration Date', FRA = 'Date d''expiration';
        }
        modify("Recurring Frequency")
        {
            CaptionML = ENU = 'Recurring Frequency', FRA = 'Périodicité abonnement';
        }
        modify("Allocated Amt. (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Allocated Amt. (LCY)"(Field 56)". Please convert manually.

            CaptionML = ENU = 'Allocated Amt. (LCY)', FRA = 'Montant imputé DS';
        }
        modify("Gen. Posting Type")
        {
            CaptionML = ENU = 'Gen. Posting Type', FRA = 'Type compta. TVA';
            // OptionCaptionML = ENU = ' ,Purchase,Sale,Settlement', FRA = ' ,Achat,Vente,Règlement';
        }
        modify("Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marché';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        modify("VAT Calculation Type")
        {
            CaptionML = ENU = 'VAT Calculation Type', FRA = 'Mode calcul TVA';
            // OptionCaptionML = ENU = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax', FRA = 'Normal,Intracomm.,Correctif,Sales Tax';
        }
        modify("EU 3-Party Trade")
        {
            CaptionML = ENU = 'EU 3-Party Trade', FRA = 'Trans. tripartite UE';
        }
        modify("Allow Application")
        {

            //Unsupported feature: Change InitValue on ""Allow Application"(Field 62)". Please convert manually.

            CaptionML = ENU = 'Allow Application', FRA = 'Lettrable';
        }
        modify("Bal. Account Type")
        {
            CaptionML = ENU = 'Bal. Account Type', FRA = 'Type compte contrepartie';
            // OptionCaptionML = ENU = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner', FRA = 'Général,Client,Fournisseur,Banque,Immobilisation,Partenaire IC';
            trigger OnAfterValidate()
            begin
                Rec.UpdateBankAcc(Rec, xRec);  //HEI.02 PTPGAP066 new line  // BC Upgrade NANDIS03 
            end;
        }
        modify("Bal. Gen. Posting Type")
        {
            CaptionML = ENU = 'Bal. Gen. Posting Type', FRA = 'Type compta. contrepartie';
            // OptionCaptionML = ENU = ' ,Purchase,Sale,Settlement', FRA = ' ,Achat,Vente,Règlement';
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Bal. Gen. Bus. Posting Group', FRA = 'Groupe compta. marché contr.';
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Bal. Gen. Prod. Posting Group', FRA = 'Groupe compta. produit contr.';
        }
        modify("Bal. VAT Calculation Type")
        {
            CaptionML = ENU = 'Bal. VAT Calculation Type', FRA = 'Mode calcul TVA contrepartie';
            // OptionCaptionML = ENU = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax', FRA = 'Normal,Intracomm.,Correctif,Sales Tax';
        }
        modify("Bal. VAT %")
        {
            CaptionML = ENU = 'Bal. VAT %', FRA = '% TVA contrepartie';
        }
        modify("Bal. VAT Amount")
        {
            CaptionML = ENU = 'Bal. VAT Amount', FRA = 'Montant TVA contrepartie';
        }
        modify("Bank Payment Type")
        {
            CaptionML = ENU = 'Bank Payment Type', FRA = 'Mode émission paiement';
            // OptionCaptionML = ENU = ' ,Computer Check,Manual Check', FRA = ' ,Informatique,Manuel';
        }
        modify("VAT Base Amount")
        {
            CaptionML = ENU = 'VAT Base Amount', FRA = 'Montant base TVA';
        }
        modify("Bal. VAT Base Amount")
        {
            CaptionML = ENU = 'Bal. VAT Base Amount', FRA = 'Montant base TVA contrepartie';
        }
        modify(Correction)
        {
            CaptionML = ENU = 'Correction', FRA = 'Correction';
        }
        modify("Check Printed")
        {
            CaptionML = ENU = 'Check Printed', FRA = 'Chèque imprimé';
        }
        modify("Document Date")
        {
            CaptionML = ENU = 'Document Date', FRA = 'Date document';
            trigger OnAfterValidate()
            begin
                Validate("Currency Code");  //HEI.31  // BC Upgrade NANDIS03
            end;
        }
        // modify("External Document No.")
        // {
        //     CaptionML = ENU = 'External Document No.', FRA = 'N° doc. externe';
        //     trigger OnAfterValidate()
        //     var
        //         lGenJnlTemplate: Record "Gen. Journal Template";
        //         lGLSetup: Record "General Ledger Setup";
        //         lGenJournalLine: Record "Gen. Journal Line";
        //         lGLEntry: Record "G/L Entry";
        //         lText50000: TextConst ENU = 'External Document No. %1 in already available in Line No. %2 with Template Name %3 & Batch Name %4';
        //         lText50001: TextConst ENU = 'External Document No. %1 is already available in posted entries';
        //     begin
        //         //HEI.24>>
        //         IF lGenJnlTemplate.GET("Journal Template Name") THEN;
        //         lGLSetup.GET;
        //         IF ((lGLSetup."Restrt Duplicate Extrnl Doc" = TRUE) AND (lGenJnlTemplate."Restrct Duplicate Extrn Doc" = TRUE)) THEN
        //             IF ("External Document No." <> '') THEN BEGIN
        //                 lGLEntry.RESET;
        //                 lGLEntry.SETRANGE("Document Type", lGLEntry."Document Type"::Payment);
        //                 lGLEntry.SETRANGE("External Document No.", "External Document No.");
        //                 IF lGLEntry.FINDFIRST THEN
        //                     ERROR(lText50001, "External Document No.");

        //                 lGenJournalLine.RESET;
        //                 lGenJournalLine.SETRANGE("Journal Template Name", "Journal Template Name");
        //                 lGenJournalLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
        //                 lGenJournalLine.SETFILTER("Line No.", '<>%1', "Line No.");
        //                 lGenJournalLine.SETRANGE("External Document No.", "External Document No.");
        //                 IF lGenJournalLine.FINDFIRST THEN
        //                     ERROR(lText50000, "External Document No.", lGenJournalLine."Line No.", lGenJournalLine."Journal Template Name", lGenJournalLine."Journal Batch Name");

        //                 lGenJournalLine.RESET;
        //                 lGenJournalLine.SETFILTER("Journal Template Name", '<>%1', "Journal Template Name");
        //                 lGenJournalLine.SETFILTER("Journal Batch Name", '<>%1', "Journal Batch Name");
        //                 lGenJournalLine.SETRANGE("External Document No.", "External Document No.");
        //                 IF lGenJournalLine.FINDFIRST THEN
        //                     ERROR(lText50000, "External Document No.", lGenJournalLine."Line No.", lGenJournalLine."Journal Template Name", lGenJournalLine."Journal Batch Name");

        //                 lGenJournalLine.RESET;
        //                 lGenJournalLine.SETRANGE("Journal Template Name", "Journal Template Name");
        //                 lGenJournalLine.SETFILTER("Journal Batch Name", '<>%1', "Journal Batch Name");
        //                 lGenJournalLine.SETRANGE("External Document No.", "External Document No.");
        //                 IF lGenJournalLine.FINDFIRST THEN
        //                     ERROR(lText50000, "External Document No.", lGenJournalLine."Line No.", lGenJournalLine."Journal Template Name", lGenJournalLine."Journal Batch Name");

        //                 lGenJournalLine.RESET;
        //                 lGenJournalLine.SETFILTER("Journal Template Name", '<>%1', "Journal Template Name");
        //                 lGenJournalLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
        //                 lGenJournalLine.SETRANGE("External Document No.", "External Document No.");
        //                 IF lGenJournalLine.FINDFIRST THEN
        //                     ERROR(lText50000, "External Document No.", lGenJournalLine."Line No.", lGenJournalLine."Journal Template Name", lGenJournalLine."Journal Batch Name");
        //             end;
        //         //HEI.24<<
        //     end;
        // }  // BC Upgrade NANDIS03 - Blocked temporarily
        modify("Source Type")
        {
            CaptionML = ENU = 'Source Type', FRA = 'Type origine';
            // OptionCaptionML = ENU = ' ,Customer,Vendor,Bank Account,Fixed Asset', FRA = ' ,Client,Fournisseur,Banque,Immobilisation';
        }
        modify("Source No.")
        {

            //Unsupported feature: Change TableRelation on ""Source No."(Field 79)". Please convert manually.

            CaptionML = ENU = 'Source No.', FRA = 'N° origine';
        }
        modify("Posting No. Series")
        {
            CaptionML = ENU = 'Posting No. Series', FRA = 'Souches de n° validation';
        }
        modify("Tax Area Code")
        {
            CaptionML = ENU = 'Tax Area Code', FRA = 'Code zone recouvrement';
        }
        modify("Tax Liable")
        {
            CaptionML = ENU = 'Tax Liable', FRA = 'Soumis à recouvrement';
        }
        modify("Tax Group Code")
        {
            CaptionML = ENU = 'Tax Group Code', FRA = 'Code groupe taxes';
        }
        modify("Use Tax")
        {
            CaptionML = ENU = 'Use Tax', FRA = 'Use Tax';
        }
        modify("Bal. Tax Area Code")
        {
            CaptionML = ENU = 'Bal. Tax Area Code', FRA = 'Code zone recouvrement contr.';
        }
        modify("Bal. Tax Liable")
        {
            CaptionML = ENU = 'Bal. Tax Liable', FRA = 'Soumis à recouvrement contr.';
        }
        modify("Bal. Tax Group Code")
        {
            CaptionML = ENU = 'Bal. Tax Group Code', FRA = 'Code groupe taxes contrepartie';
        }
        modify("Bal. Use Tax")
        {
            CaptionML = ENU = 'Bal. Use Tax', FRA = 'Use Tax contrepartie';
        }
        modify("VAT Bus. Posting Group")
        {
            CaptionML = ENU = 'VAT Bus. Posting Group', FRA = 'Groupe compta. marché TVA';
        }
        modify("VAT Prod. Posting Group")
        {
            CaptionML = ENU = 'VAT Prod. Posting Group', FRA = 'Groupe compta. produit TVA';
        }
        modify("Bal. VAT Bus. Posting Group")
        {
            CaptionML = ENU = 'Bal. VAT Bus. Posting Group', FRA = 'Gpe compta. marché TVA contr.';
        }
        modify("Bal. VAT Prod. Posting Group")
        {
            CaptionML = ENU = 'Bal. VAT Prod. Posting Group', FRA = 'Gpe compta. produit TVA contr.';
        }
        modify("Additional-Currency Posting")
        {
            CaptionML = ENU = 'Additional-Currency Posting', FRA = 'Comptabilisation devise report';
            OptionCaptionML = ENU = 'None,Amount Only,Additional-Currency Amount Only', FRA = 'Aucun,Montant seulement,Montant DR seulement';
        }
        modify("FA Add.-Currency Factor")
        {
            CaptionML = ENU = 'FA Add.-Currency Factor', FRA = 'Facteur devise immo.';
        }
        modify("Source Currency Code")
        {
            CaptionML = ENU = 'Source Currency Code', FRA = 'Code devise origine';
        }
        modify("Source Currency Amount")
        {
            CaptionML = ENU = 'Source Currency Amount', FRA = 'Montant devise origine';
        }
        modify("Source Curr. VAT Base Amount")
        {
            CaptionML = ENU = 'Source Curr. VAT Base Amount', FRA = 'Montant base TVA devise origine';
        }
        modify("Source Curr. VAT Amount")
        {
            CaptionML = ENU = 'Source Curr. VAT Amount', FRA = 'Montant TVA devise origine';
        }
        modify("VAT Base Discount %")
        {
            CaptionML = ENU = 'VAT Base Discount %', FRA = '% remise base TVA';
        }
        modify("VAT Amount (LCY)")
        {
            CaptionML = ENU = 'VAT Amount (LCY)', FRA = 'Montant TVA DS';
        }
        modify("VAT Base Amount (LCY)")
        {
            CaptionML = ENU = 'VAT Base Amount (LCY)', FRA = 'Montant base TVA DS';
        }
        modify("Bal. VAT Amount (LCY)")
        {
            CaptionML = ENU = 'Bal. VAT Amount (LCY)', FRA = 'Montant TVA contr. DS';
        }
        modify("Bal. VAT Base Amount (LCY)")
        {
            CaptionML = ENU = 'Bal. VAT Base Amount (LCY)', FRA = 'Mont. base TVA contr. DS';
        }
        modify("Reversing Entry")
        {
            CaptionML = ENU = 'Reversing Entry', FRA = 'Ecriture opposée';
        }
        modify("Allow Zero-Amount Posting")
        {
            CaptionML = ENU = 'Allow Zero-Amount Posting', FRA = 'Autoriser compta. montant nul';
        }
        modify("Ship-to/Order Address Code")
        {

            //Unsupported feature: Change TableRelation on ""Ship-to/Order Address Code"(Field 110)". Please convert manually.

            CaptionML = ENU = 'Ship-to/Order Address Code', FRA = 'Code adresse destinataire/adresse de commande';
        }
        modify("VAT Difference")
        {
            CaptionML = ENU = 'VAT Difference', FRA = 'Différence TVA';
        }
        modify("Bal. VAT Difference")
        {
            CaptionML = ENU = 'Bal. VAT Difference', FRA = 'Différence TVA contrepartie';
        }
        modify("IC Partner Code")
        {
            CaptionML = ENU = 'IC Partner Code', FRA = 'Code du partenaire IC';
        }
        modify("IC Direction")
        {
            CaptionML = ENU = 'IC Direction', FRA = 'Direction IC';
            //OptionCaptionML = ENU = 'Outgoing,Incoming', FRA = 'Sortant,Entrant';
        }
        // modify("IC Partner G/L Acc. No.")
        // {
        //     CaptionML = ENU='IC Partner G/L Acc. No.',FRA='N° cpte gén partenaire IC';
        // }  // BC Upgrade NANDIS03

        modify("IC Partner Transaction No.")
        {
            CaptionML = ENU = 'IC Partner Transaction No.', FRA = 'N° transaction partenaire IC';
        }
        modify("Sell-to/Buy-from No.")
        {

            //Unsupported feature: Change TableRelation on ""Sell-to/Buy-from No."(Field 118)". Please convert manually.

            CaptionML = ENU = 'Sell-to/Buy-from No.', FRA = 'N° donneur d''ordre/fournisseur';
        }
        modify("VAT Registration No.")
        {
            CaptionML = ENU = 'VAT Registration No.', FRA = 'N° identif. intracomm.';
        }
        modify("Country/Region Code")
        {

            //Unsupported feature: Change TableRelation on ""Country/Region Code"(Field 120)". Please convert manually.

            CaptionML = ENU = 'Country/Region Code', FRA = 'Code pays/région';
        }
        modify(Prepayment)
        {
            CaptionML = ENU = 'Prepayment', FRA = 'Acompte';
        }
        modify("Financial Void")
        {
            CaptionML = ENU = 'Financial Void', FRA = 'Annulation financière';
        }
        modify("Incoming Document Entry No.")
        {
            CaptionML = ENU = 'Incoming Document Entry No.', FRA = 'N° de séquence du document entrant';
        }
        modify("Creditor No.")
        {
            CaptionML = ENU = 'Creditor No.', FRA = 'N° créditeur';
        }
        modify("Payment Reference")
        {
            CaptionML = ENU = 'Payment Reference', FRA = 'Référence paiement';
        }
        modify("Payment Method Code")
        {
            CaptionML = ENU = 'Payment Method Code', FRA = 'Code mode de règlement';
        }
        modify("Applies-to Ext. Doc. No.")
        {
            CaptionML = ENU = 'Applies-to Ext. Doc. No.', FRA = 'N° ligne doc. ext. lettrage';
        }
        modify("Recipient Bank Account")
        {
            CaptionML = ENU = 'Recipient Bank Account', FRA = 'Cpte bancaire destinataire';
            //Unsupported feature: Change TableRelation on ""Recipient Bank Account"(Field 288)". Please convert manually.
            trigger OnAfterValidate()
            var
                CompanyInfo: Record "Company Information";
                CustBankAcc: Record "Customer Bank Account";
                myInt: Integer;
            begin
                //HEI.26>>
                // CompanyInfo.GET;
                // IF CompanyInfo."Enable French Localization" THEN BEGIN
                //     IF "Account Type" = "Account Type"::Customer THEN
                //         IF CustBankAcc.GET("Account No.", "Recipient Bank Account") THEN
                //             "Bank Account Name" := CustBankAcc.Name
                //         else
                //             "Bank Account Name" := '';
                //     IF "Account Type" = "Account Type"::Vendor THEN
                //         IF VendBankAcc.GET("Account No.", "Recipient Bank Account") THEN
                //             "Bank Account Name" := VendBankAcc.Name
                //         else
                //             "Bank Account Name" := '';
                // end;  // BC Upgrade NANDIS03 - Dependency on FR localization
                //HEI.26<<
            end;
        }
        modify("Message to Recipient")
        {
            CaptionML = ENU = 'Message to Recipient', FRA = 'Message au destinataire';
        }
        modify("Exported to Payment File")
        {
            CaptionML = ENU = 'Exported to Payment File', FRA = 'Exporté dans fichier paiement';
        }
        modify("Has Payment Export Error")
        {

            //Unsupported feature: Change CalcFormula on ""Has Payment Export Error"(Field 291)". Please convert manually.

            CaptionML = ENU = 'Has Payment Export Error', FRA = 'Présente erreur exportation paiement';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        // modify("Credit Card No.")
        // {
        //     CaptionML = ENU='Credit Card No.',FRA='N° de carte de crédit';
        // }  // BC Upgrade NANDIS03
        modify("Job Task No.")
        {

            //Unsupported feature: Change TableRelation on ""Job Task No."(Field 1001)". Please convert manually.

            CaptionML = ENU = 'Job Task No.', FRA = 'N° tâche projet';
        }
        modify("Job Unit Price (LCY)")
        {
            CaptionML = ENU = 'Job Unit Price (LCY)', FRA = 'Prix unitaire projet DS';
        }
        modify("Job Total Price (LCY)")
        {
            CaptionML = ENU = 'Job Total Price (LCY)', FRA = 'Prix total projet DS';
        }
        modify("Job Quantity")
        {
            CaptionML = ENU = 'Job Quantity', FRA = 'Quantité projet';
        }
        modify("Job Unit Cost (LCY)")
        {
            CaptionML = ENU = 'Job Unit Cost (LCY)', FRA = 'Coût unitaire projet DS';
        }
        modify("Job Line Discount %")
        {
            CaptionML = ENU = 'Job Line Discount %', FRA = '% remise ligne projet';
        }
        modify("Job Line Disc. Amount (LCY)")
        {
            CaptionML = ENU = 'Job Line Disc. Amount (LCY)', FRA = 'Montant remise ligne projet DS';
        }
        modify("Job Unit Of Measure Code")
        {
            CaptionML = ENU = 'Job Unit Of Measure Code', FRA = 'Code unité projet';
        }
        modify("Job Line Type")
        {
            CaptionML = ENU = 'Job Line Type', FRA = 'Type ligne projet';
            //OptionCaptionML = ENU = ' ,Budget,Billable,Both Budget and Billable', FRA = ' ,Budget,Facturable,Budget et Facturable';
        }
        modify("Job Unit Price")
        {
            CaptionML = ENU = 'Job Unit Price', FRA = 'Prix unitaire projet';
        }
        modify("Job Total Price")
        {
            CaptionML = ENU = 'Job Total Price', FRA = 'Prix total projet';
        }
        modify("Job Unit Cost")
        {
            CaptionML = ENU = 'Job Unit Cost', FRA = 'Coût unitaire projet';
        }
        modify("Job Total Cost")
        {
            CaptionML = ENU = 'Job Total Cost', FRA = 'Coût total projet';
        }
        modify("Job Line Discount Amount")
        {
            CaptionML = ENU = 'Job Line Discount Amount', FRA = 'Montant remise ligne projet';
        }
        modify("Job Line Amount")
        {
            CaptionML = ENU = 'Job Line Amount', FRA = 'Montant ligne projet';
        }
        modify("Job Total Cost (LCY)")
        {
            CaptionML = ENU = 'Job Total Cost (LCY)', FRA = 'Coût total projet DS';
        }
        modify("Job Line Amount (LCY)")
        {
            CaptionML = ENU = 'Job Line Amount (LCY)', FRA = 'Montant ligne projet DS';
        }
        modify("Job Currency Factor")
        {
            CaptionML = ENU = 'Job Currency Factor', FRA = 'Facteur devise projet';
        }
        modify("Job Currency Code")
        {
            CaptionML = ENU = 'Job Currency Code', FRA = 'Code devise projet';
        }
        modify("Job Planning Line No.")
        {
            CaptionML = ENU = 'Job Planning Line No.', FRA = 'N° ligne planning projet';
        }
        modify("Job Remaining Qty.")
        {
            CaptionML = ENU = 'Job Remaining Qty.', FRA = 'Quantité travail à accomplir';
        }
        modify("Direct Debit Mandate ID")
        {

            //Unsupported feature: Change TableRelation on ""Direct Debit Mandate ID"(Field 1200)". Please convert manually.

            CaptionML = ENU = 'Direct Debit Mandate ID', FRA = 'ID mandat domiciliation européenne';
        }
        modify("Data Exch. Entry No.")
        {
            CaptionML = ENU = 'Data Exch. Entry No.', FRA = 'N° écriture échange données';
        }
        modify("Payer Information")
        {
            CaptionML = ENU = 'Payer Information', FRA = 'Informations payeur';
        }
        modify("Transaction Information")
        {
            CaptionML = ENU = 'Transaction Information', FRA = 'Informations transaction';
        }
        modify("Data Exch. Line No.")
        {
            CaptionML = ENU = 'Data Exch. Line No.', FRA = 'N° ligne échange données';
        }
        modify("Applied Automatically")
        {
            CaptionML = ENU = 'Applied Automatically', FRA = 'Lettré automatiquement';
        }
        modify("Deferral Code")
        {
            CaptionML = ENU = 'Deferral Code', FRA = 'Code échelonnement';
        }
        modify("Deferral Line No.")
        {
            CaptionML = ENU = 'Deferral Line No.', FRA = 'N° ligne échelonnement';
        }
        modify("Campaign No.")
        {
            CaptionML = ENU = 'Campaign No.', FRA = 'N° campagne';
        }
        modify("Prod. Order No.")
        {
            CaptionML = ENU = 'Prod. Order No.', FRA = 'N° ordre de fabrication';
        }
        modify("FA Posting Date")
        {
            CaptionML = ENU = 'FA Posting Date', FRA = 'Date compta. immo.';
        }
        modify("FA Posting Type")
        {
            CaptionML = ENU = 'FA Posting Type', FRA = 'Type compta. immo.';
            //OptionCaptionML = ENU = ' ,Acquisition Cost,Depreciation,Write-Down,Appreciation,Custom 1,Custom 2,Disposal,Maintenance,,,,,Derogatory', FRA = ' ,Coût acquisition,Amortissement,Dépréciation,Réévaluation,Param. 1,Param. 2,Cession,Maintenance,,,,,Dérogatoire';

            //Unsupported feature: Change OptionString on ""FA Posting Type"(Field 5601)". Please convert manually.


            //Unsupported feature: Change Description on ""FA Posting Type"(Field 5601)". Please convert manually.
            // BC Upgrade NANDIS03 >>
            trigger OnAfterValidate()
            begin
                Rec.GetDerogatorySetup();
            end;
            // BC Upgrade NANDIS03 <<
        }
        modify("Depreciation Book Code")
        {
            CaptionML = ENU = 'Depreciation Book Code', FRA = 'Code loi d''amortissement';
            // BC Upgrade NANDIS03 >>
            trigger OnAfterValidate()
            begin
                Rec.GetDerogatorySetup();
            end;
            // BC Upgrade NANDIS03 <<
        }
        modify("Salvage Value")
        {
            CaptionML = ENU = 'Salvage Value', FRA = 'Valeur résiduelle';
        }
        modify("No. of Depreciation Days")
        {
            CaptionML = ENU = 'No. of Depreciation Days', FRA = 'Nbre jours amort.';
        }
        modify("Depr. until FA Posting Date")
        {
            CaptionML = ENU = 'Depr. until FA Posting Date', FRA = 'Amort. jusqu''à date compta.';
        }
        modify("Depr. Acquisition Cost")
        {
            CaptionML = ENU = 'Depr. Acquisition Cost', FRA = 'Amortir coût acquisition';
        }
        modify("Maintenance Code")
        {
            CaptionML = ENU = 'Maintenance Code', FRA = 'Code maintenance';
        }
        modify("Insurance No.")
        {
            CaptionML = ENU = 'Insurance No.', FRA = 'N° assurance';
        }
        modify("Budgeted FA No.")
        {
            CaptionML = ENU = 'Budgeted FA No.', FRA = 'N° immo. budgétée';
        }
        modify("Duplicate in Depreciation Book")
        {
            CaptionML = ENU = 'Duplicate in Depreciation Book', FRA = 'Dupliquer dans journaux amort.';
        }
        modify("Use Duplication List")
        {
            CaptionML = ENU = 'Use Duplication List', FRA = 'Utiliser liste duplication';
        }
        modify("FA Reclassification Entry")
        {
            CaptionML = ENU = 'FA Reclassification Entry', FRA = 'Ecriture reclass. immo.';
        }
        modify("FA Error Entry No.")
        {
            CaptionML = ENU = 'FA Error Entry No.', FRA = 'N° séquence erreur immo.';
        }
        modify("Index Entry")
        {
            CaptionML = ENU = 'Index Entry', FRA = 'Ecriture réévaluation';
        }
        modify("Source Line No.")
        {
            CaptionML = ENU = 'Source Line No.', FRA = 'N° ligne origine';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comment', FRA = 'Commentaire';
        }

        //Unsupported feature: CodeModification on ""Account Type"(Field 3).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Fixed Asset",
                               "Account Type"::"IC Partner"]) AND
           ("Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Fixed Asset",
                                    "Bal. Account Type"::"IC Partner"])
        THEN
          ERROR(
            Text000,
            FIELDCAPTION("Account Type"),FIELDCAPTION("Bal. Account Type"));
        VALIDATE("Account No.",'');
        VALIDATE(Description,'');
        VALIDATE("IC Partner G/L Acc. No.",'');
        IF "Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account"] THEN BEGIN
          VALIDATE("Gen. Posting Type","Gen. Posting Type"::" ");
          VALIDATE("Gen. Bus. Posting Group",'');
          VALIDATE("Gen. Prod. Posting Group",'');
        end else
          IF "Bal. Account Type" IN [
                                     "Bal. Account Type"::"G/L Account","Account Type"::"Bank Account","Bal. Account Type"::"Fixed Asset"]
          THEN
            VALIDATE("Payment Terms Code",'');
        UpdateSource;

        IF ("Account Type" <> "Account Type"::"Fixed Asset") AND
           ("Bal. Account Type" <> "Bal. Account Type"::"Fixed Asset")
        THEN BEGIN
          "Depreciation Book Code" := '';
          VALIDATE("FA Posting Type","FA Posting Type"::" ");
        end;
        IF xRec."Account Type" IN
           [xRec."Account Type"::Customer,xRec."Account Type"::Vendor]
        THEN BEGIN
          "Bill-to/Pay-to No." := '';
          "Ship-to/Order Address Code" := '';
          "Sell-to/Buy-from No." := '';
          "VAT Registration No." := '';
        end;

        IF "Journal Template Name" <> '' THEN
          IF "Account Type" = "Account Type"::"IC Partner" THEN BEGIN
            GetTemplate;
            IF GenJnlTemplate.Type <> GenJnlTemplate.Type::Intercompany THEN
              FIELDERROR("Account Type");
          end;
        IF "Account Type" <> "Account Type"::Customer THEN
          VALIDATE("Credit Card No.",'');

        VALIDATE("Deferral Code",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //>>HEI.11
        if ("Document Type" = "Document Type"::"RPM Damage or Loss") and
           not ("Account Type" in["Account Type"::Customer,"Account Type"::"Fixed Asset","Account Type"::"G/L Account"])
        then
          ERROR(AccTypeNotInLineWithDocTypeErr,FIELDCAPTION("Account Type"),"Account Type",FIELDCAPTION("Document Type"),"Document Type");
        //<<HEI.11

        // <<DITW15.00.00.01 DDR 08/02/2008
        TestPeriodicWkshtLine();
        // >>DITW15.00.00.01 DDR

        if ("Account Type" in ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Fixed Asset",
                               "Account Type"::"IC Partner"]) and
           ("Bal. Account Type" in ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Fixed Asset",
                                    "Bal. Account Type"::"IC Partner"])
        then
        #6..11
        if "Account Type" in ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account"] then begin
        #13..15
        end else
          if "Bal. Account Type" in [
                                     "Bal. Account Type"::"G/L Account","Account Type"::"Bank Account","Bal. Account Type"::"Fixed Asset"]
          then
        #20..22
        if ("Account Type" <> "Account Type"::"Fixed Asset") and
           ("Bal. Account Type" <> "Bal. Account Type"::"Fixed Asset")
        then begin
          "Depreciation Book Code" := '';
          VALIDATE("FA Posting Type","FA Posting Type"::" ");
        end;
        if xRec."Account Type" in
           [xRec."Account Type"::Customer,xRec."Account Type"::Vendor]
        then begin
        #32..35
        end;

        if "Journal Template Name" <> '' then
          if "Account Type" = "Account Type"::"IC Partner" then begin
            GetTemplate;
            if GenJnlTemplate.Type <> GenJnlTemplate.Type::Intercompany then
              FIELDERROR("Account Type");
          end;
        if "Account Type" <> "Account Type"::Customer then
        #45..47

        // <<DITW17.10.03 DDR 07/07/2014 DIT-770 #231
        SETRANGE("DIT Sub-Contr.Pst. Type Filter");
        // >>DITW17.10.03 DDR DIT-770 #231
        PurchasesUtils.UpdateBankAcc(Rec,xRec);//HEI.02 PTPGAP066 new line
        */
        //end;


        //Unsupported feature: CodeModification on ""Account No."(Field 4).OnValidate". Please convert manually.

        //trigger "(Field 4)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Account No." <> xRec."Account No." THEN BEGIN
          ClearAppliedAutomatically;
          VALIDATE("Job No.",'');
        end;

        IF xRec."Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"IC Partner"] THEN
          "IC Partner Code" := '';

        IF "Account No." = '' THEN BEGIN
          CleanLine;
          EXIT;
        end;

        CASE "Account Type" OF
          "Account Type"::"G/L Account":
            GetGLAccount;
          "Account Type"::Customer:
            GetCustomerAccount;
          "Account Type"::Vendor:
            GetVendorAccount;
          "Account Type"::"Bank Account":
            GetBankAccount;
          "Account Type"::"Fixed Asset":
            GetFAAccount;
          "Account Type"::"IC Partner":
            GetICPartnerAccount;
        end;

        VALIDATE("Currency Code");
        VALIDATE("VAT Prod. Posting Group");
        UpdateLineBalance;
        UpdateSource;
        CreateDim(
          DimMgt.TypeToTableID1("Account Type"),"Account No.",
          DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
          DATABASE::Job,"Job No.",
          DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
          DATABASE::Campaign,"Campaign No.");

        VALIDATE("IC Partner G/L Acc. No.",GetDefaultICPartnerGLAccNo);
        ValidateApplyRequirements(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.01 DDR 08/02/2008
        TestPeriodicWkshtLine();
        // >>DITW15.00.00.01 DDR

        if "Account No." <> xRec."Account No." then begin
          ClearAppliedAutomatically;
          VALIDATE("Job No.",'');
          VALIDATE("Related Sales Order", ''); //HEI.40
        end;

        if xRec."Account Type" in ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"IC Partner"] then
          "IC Partner Code" := '';

        if "Account No." = '' then begin
          CleanLine;
          PurchasesUtils.UpdateBankAcc(Rec,xRec);//HEI.02 PTPGAP066 new line
          GetDerogatorySetup; //HEI.25
          exit;
        end;

        case "Account Type" of
        #15..26
        end;

        // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
        SetFilterSubContractPostType;
        // >>DITW16.00.00.41 AHU DIT-715 #327
        #29..37
          DATABASE::Campaign,"Campaign No.",
          // <<DITW15.00.00.37 DDR 28/01/2010
          DATABASE::Building,"Building No.",
          // >>DITW15.00.00.37 DDR
          // <<DITW16.00.00.41 AHU 06/08/2012 20/09/2012 DIT-715 #327
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          DimMgt.TypeToTableID2034932(GetSourceType(),"Contract Type"),GetContractNo());
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          // >>DITW16.00.00.41 AHU DIT-715 #327
        #39..41
        */
        //end;


        //Unsupported feature: CodeModification on ""Posting Date"(Field 5).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Document Date","Posting Date");
        VALIDATE("Currency Code");

        IF ("Posting Date" <> xRec."Posting Date") AND (Amount <> 0) THEN
          PaymentToleranceMgt.PmtTolGenJnl(Rec);

        ValidateApplyRequirements(Rec);

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine;
          UpdatePricesFromJobJnlLine;
        end;

        IF "Deferral Code" <> '' THEN
          VALIDATE("Deferral Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //VALIDATE("Document Date","Posting Date"); //HEI.31
        //VALIDATE("Currency Code"); //HEI.31

        if ("Posting Date" <> xRec."Posting Date") and (Amount <> 0) then
        #5..8
        if JobTaskIsSet then begin
          CreateTempJobJnlLine;
          UpdatePricesFromJobJnlLine;
        end;

        if "Deferral Code" <> '' then
          VALIDATE("Deferral Code");
        */
        //end;


        //Unsupported feature: CodeModification on ""Document Type"(Field 6).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Payment Terms Code");
        IF "Account No." <> '' THEN
          CASE "Account Type" OF
            "Account Type"::Customer:
              BEGIN
                Cust.GET("Account No.");
                Cust.CheckBlockedCustOnJnls(Cust,"Document Type",FALSE);
              end;
            "Account Type"::Vendor:
              BEGIN
                Vend.GET("Account No.");
                Vend.CheckBlockedVendOnJnls(Vend,"Document Type",FALSE);
              end;
          end;
        IF "Bal. Account No." <> '' THEN
          CASE "Bal. Account Type" OF
            "Account Type"::Customer:
              BEGIN
                Cust.GET("Bal. Account No.");
                Cust.CheckBlockedCustOnJnls(Cust,"Document Type",FALSE);
              end;
            "Account Type"::Vendor:
              BEGIN
                Vend.GET("Bal. Account No.");
                Vend.CheckBlockedVendOnJnls(Vend,"Document Type",FALSE);
              end;
          end;
        UpdateSalesPurchLCY;
        ValidateApplyRequirements(Rec);
        IF NOT ("Document Type" IN ["Document Type"::Payment,"Document Type"::Refund]) THEN
          VALIDATE("Credit Card No.",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //>>HEI.11
        if ("Document Type" = "Document Type"::"RPM Damage or Loss") and
           not ("Account Type" in["Account Type"::Customer,"Account Type"::"Fixed Asset","Account Type"::"G/L Account"])
        then
          ERROR(AccTypeNotInLineWithDocTypeErr,FIELDCAPTION("Document Type"),"Document Type",FIELDCAPTION("Account Type"),"Account Type");
        //<<HEI.11
        VALIDATE("Payment Terms Code");
        if "Account No." <> '' then
          case "Account Type" of
            "Account Type"::Customer:
              begin
                Cust.GET("Account No.");
                Cust.CheckBlockedCustOnJnls(Cust,"Document Type",false);
              end;
            "Account Type"::Vendor:
              begin
                Vend.GET("Account No.");
                Vend.CheckBlockedVendOnJnls(Vend,"Document Type",false);
              end;
          end;
        if "Bal. Account No." <> '' then
          case "Bal. Account Type" of
            "Account Type"::Customer:
              begin
                Cust.GET("Bal. Account No.");
                Cust.CheckBlockedCustOnJnls(Cust,"Document Type",false);
              end;
            "Account Type"::Vendor:
              begin
                Vend.GET("Bal. Account No.");
                Vend.CheckBlockedVendOnJnls(Vend,"Document Type",false);
              end;
          end;
        UpdateSalesPurchLCY;
        ValidateApplyRequirements(Rec);
        //<<DITW17.10.03 AT  05/02/2014 DIT-770 #340
        if "Account No." <> '' then
        //>>DITW17.10.03 AT  05/02/2014 DIT-770 #340
          //<<DITW17.00.02 SR 19/12/2013 DIT-770 #163
          VALIDATE("DIT Sub-Contract Type");
          //>>DITW17.00.02 SR 19/12/2013 DIT-770 #163
        if not ("Document Type" in ["Document Type"::Payment,"Document Type"::Refund]) then
          VALIDATE("Credit Card No.",'');
        */
        //end;


        //Unsupported feature: CodeModification on ""VAT %"(Field 10).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetCurrency;
        CASE "VAT Calculation Type" OF
          "VAT Calculation Type"::"Normal VAT",
          "VAT Calculation Type"::"Reverse Charge VAT":
            BEGIN
              "VAT Amount" :=
                ROUND(Amount * "VAT %" / (100 + "VAT %"),Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
              "VAT Base Amount" :=
                ROUND(Amount - "VAT Amount",Currency."Amount Rounding Precision");
            end;
          "VAT Calculation Type"::"Full VAT":
            "VAT Amount" := Amount;
          "VAT Calculation Type"::"Sales Tax":
            IF ("Gen. Posting Type" = "Gen. Posting Type"::Purchase) AND
               "Use Tax"
            THEN BEGIN
              "VAT Amount" := 0;
              "VAT %" := 0;
            end else BEGIN
              "VAT Amount" :=
                Amount -
                SalesTaxCalculate.ReverseCalculateTax(
                  "Tax Area Code","Tax Group Code","Tax Liable",
                  "Posting Date",Amount,Quantity,"Currency Factor");
              IF Amount - "VAT Amount" <> 0 THEN
                "VAT %" := ROUND(100 * "VAT Amount" / (Amount - "VAT Amount"),0.00001)
              else
                "VAT %" := 0;
              "VAT Amount" :=
                ROUND("VAT Amount",Currency."Amount Rounding Precision");
            end;
        end;
        "VAT Base Amount" := Amount - "VAT Amount";
        "VAT Difference" := 0;

        IF "Currency Code" = '' THEN
          "VAT Amount (LCY)" := "VAT Amount"
        else
          "VAT Amount (LCY)" :=
            ROUND(
              CurrExchRate.ExchangeAmtFCYToLCY(
        #42..44

        UpdateSalesPurchLCY;

        IF "Deferral Code" <> '' THEN
          VALIDATE("Deferral Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetCurrency;
        case "VAT Calculation Type" of
          "VAT Calculation Type"::"Normal VAT",
          "VAT Calculation Type"::"Reverse Charge VAT":
            begin
        #6..9
            end;
        #11..13
            if ("Gen. Posting Type" = "Gen. Posting Type"::Purchase) and
               "Use Tax"
            then begin
              "VAT Amount" := 0;
              "VAT %" := 0;
            end else begin
        #20..24
              if Amount - "VAT Amount" <> 0 then
                "VAT %" := ROUND(100 * "VAT Amount" / (Amount - "VAT Amount"),0.00001)
              else
        #28..30
            end;
        end;
        #33..35
        if "Currency Code" = '' then
          "VAT Amount (LCY)" := "VAT Amount"
        else
        #39..47
        if "Deferral Code" <> '' then
          VALIDATE("Deferral Code");
        */
        //end;


        //Unsupported feature: CodeModification on ""Bal. Account No."(Field 11).OnValidate". Please convert manually.

        //trigger  Account No();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Job No.",'');

        IF xRec."Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,
                                        "Bal. Account Type"::"IC Partner"]
        THEN
          "IC Partner Code" := '';

        IF "Bal. Account No." = '' THEN BEGIN
          UpdateLineBalance;
          UpdateSource;
          CreateDim(
            DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
            DimMgt.TypeToTableID1("Account Type"),"Account No.",
            DATABASE::Job,"Job No.",
            DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
            DATABASE::Campaign,"Campaign No.");
          IF NOT ("Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor]) THEN
            "Recipient Bank Account" := '';
          IF xRec."Bal. Account No." <> '' THEN BEGIN
            ClearBalancePostingGroups;
            "Bal. Tax Area Code" := '';
            "Bal. Tax Liable" := FALSE;
            "Bal. Tax Group Code" := '';
          end;
          EXIT;
        end;

        CASE "Bal. Account Type" OF
          "Bal. Account Type"::"G/L Account":
            GetGLBalAccount;
          "Bal. Account Type"::Customer:
            GetCustomerBalAccount;
          "Bal. Account Type"::Vendor:
            GetVendorBalAccount;
          "Bal. Account Type"::"Bank Account":
            GetBankBalAccount;
          "Bal. Account Type"::"Fixed Asset":
            GetFABalAccount;
          "Bal. Account Type"::"IC Partner":
            GetICPartnerBalAccount;
        end;

        VALIDATE("Currency Code");
        VALIDATE("Bal. VAT Prod. Posting Group");
        UpdateLineBalance;
        UpdateSource;
        CreateDim(
          DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
          DimMgt.TypeToTableID1("Account Type"),"Account No.",
          DATABASE::Job,"Job No.",
          DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
          DATABASE::Campaign,"Campaign No.");

        VALIDATE("IC Partner G/L Acc. No.",GetDefaultICPartnerGLAccNo);
        ValidateApplyRequirements(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.01 DDR 08/02/2008
        TestPeriodicWkshtLine();
        // >>DITW15.00.00.01 DDR
        VALIDATE("Job No.",'');
        //HEI.40<<
        if Rec."Bal. Account No." <> xRec."Bal. Account No." then
          VALIDATE("Related Sales Order", '');
        //HEI.40>>

        if xRec."Bal. Account Type" in ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,
                                        "Bal. Account Type"::"IC Partner"]
        then
          "IC Partner Code" := '';

        if "Bal. Account No." = '' then begin
        #9..15
            DATABASE::Campaign,"Campaign No.",
            // <<DITW15.00.00.37 DDR 28/01/2010
            DATABASE::Building,"Building No.",
            // >>DITW15.00.00.37 DDR
            // <<DITW16.00.00.41 AHU 06/08/2012 20/09/2012 DIT-715 #327
            //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
            DimMgt.TypeToTableID2034932(GetSourceType(),"Contract Type"),GetContractNo());
            //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
            // >>DITW16.00.00.41 AHU DIT-715 #327

          if not ("Account Type" in ["Account Type"::Customer,"Account Type"::Vendor]) then
            "Recipient Bank Account" := '';
          if xRec."Bal. Account No." <> '' then begin
            ClearBalancePostingGroups;
            "Bal. Tax Area Code" := '';
            "Bal. Tax Liable" := false;
            "Bal. Tax Group Code" := '';
          end;
          exit;
        end;

        case "Bal. Account Type" of
        #29..40
        end;

        // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
        SetFilterSubContractPostType;
        // >>DITW16.00.00.41 AHU DIT-715 #327
        #43..51
          DATABASE::Campaign,"Campaign No.",
          // <<DITW15.00.00.37 DDR 28/01/2010
          DATABASE::Building,"Building No.",
          // >>DITW15.00.00.37 DDR
          // <<DITW16.00.00.41 AHU 06/08/2012 20/09/2012 DIT-715 #327
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          DimMgt.TypeToTableID2034932(GetSourceType(),"Contract Type"),GetContractNo());
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          // >>DITW16.00.00.41 AHU DIT-715 #327
        #53..55
        */
        //end;


        //Unsupported feature: CodeModification on ""Currency Code"(Field 12).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bal. Account Type" = "Bal. Account Type"::"Bank Account" THEN BEGIN
          IF BankAcc.GET("Bal. Account No.") AND (BankAcc."Currency Code" <> '')THEN
            BankAcc.TESTFIELD("Currency Code","Currency Code");
        end;
        IF "Account Type" = "Account Type"::"Bank Account" THEN BEGIN
          IF BankAcc.GET("Account No.") AND (BankAcc."Currency Code" <> '') THEN
            BankAcc.TESTFIELD("Currency Code","Currency Code");
        end;
        IF ("Recurring Method" IN
            ["Recurring Method"::"B  Balance","Recurring Method"::"RB Reversing Balance"]) AND
           ("Currency Code" <> '')
        THEN
          ERROR(
            Text001,
            FIELDCAPTION("Currency Code"),FIELDCAPTION("Recurring Method"),"Recurring Method");

        IF "Currency Code" <> '' THEN BEGIN
          GetCurrency;
          IF ("Currency Code" <> xRec."Currency Code") OR
             ("Posting Date" <> xRec."Posting Date") OR
             (CurrFieldNo = FIELDNO("Currency Code")) OR
             ("Currency Factor" = 0)
          THEN
            "Currency Factor" :=
              CurrExchRate.ExchangeRate("Posting Date","Currency Code");
        end else
          "Currency Factor" := 0;
        VALIDATE("Currency Factor");

        IF NOT CustVendAccountNosModified THEN
          IF ("Currency Code" <> xRec."Currency Code") AND (Amount <> 0) THEN
            PaymentToleranceMgt.PmtTolGenJnl(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Bal. Account Type" = "Bal. Account Type"::"Bank Account" then begin
          if BankAcc.GET("Bal. Account No.") and (BankAcc."Currency Code" <> '')then
            BankAcc.TESTFIELD("Currency Code","Currency Code");
        end;
        if "Account Type" = "Account Type"::"Bank Account" then begin
          if BankAcc.GET("Account No.") and (BankAcc."Currency Code" <> '') then
            BankAcc.TESTFIELD("Currency Code","Currency Code");
        end;
        if ("Recurring Method" in
            ["Recurring Method"::"B  Balance","Recurring Method"::"RB Reversing Balance"]) and
           ("Currency Code" <> '')
        then
        #13..16
        if "Currency Code" <> '' then begin
          GetCurrency;
          if ("Currency Code" <> xRec."Currency Code") or
             //("Posting Date" <> xRec."Posting Date") OR //HEI.31
             ("Document Date" <> xRec."Document Date") or //HEI.31
             (CurrFieldNo = FIELDNO("Currency Code")) or
             ("Currency Factor" = 0)
          then
            "Currency Factor" :=
              //CurrExchRate.ExchangeRate("Posting Date","Currency Code"); //HEI.31
              CurrExchRate.ExchangeRate("Document Date","Currency Code"); //HEI.31
        end else
        #27..29
        if not CustVendAccountNosModified then
          if ("Currency Code" <> xRec."Currency Code") and (Amount <> 0) then
            PaymentToleranceMgt.PmtTolGenJnl(Rec);
        */
        //end;


        //Unsupported feature: CodeModification on "Amount(Field 13).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetCurrency;
        IF "Currency Code" = '' THEN
          "Amount (LCY)" := Amount
        else
          "Amount (LCY)" := ROUND(
              CurrExchRate.ExchangeAmtFCYToLCY(
                "Posting Date","Currency Code",
                Amount,"Currency Factor"));

        Amount := ROUND(Amount,Currency."Amount Rounding Precision");
        IF (CurrFieldNo <> 0) AND
           (CurrFieldNo <> FIELDNO("Applies-to Doc. No.")) AND
           ((("Account Type" = "Account Type"::Customer) AND
             ("Account No." <> '') AND (Amount > 0) AND
             (CurrFieldNo <> FIELDNO("Bal. Account No."))) OR
            (("Bal. Account Type" = "Bal. Account Type"::Customer) AND
             ("Bal. Account No." <> '') AND (Amount < 0) AND
             (CurrFieldNo <> FIELDNO("Account No."))))
        THEN
          CustCheckCreditLimit.GenJnlLineCheck(Rec);

        VALIDATE("VAT %");
        VALIDATE("Bal. VAT %");
        UpdateLineBalance;
        IF "Deferral Code" <> '' THEN
          VALIDATE("Deferral Code");

        IF Amount <> xRec.Amount THEN BEGIN
          IF ("Applies-to Doc. No." <> '') OR ("Applies-to ID" <> '') THEN
            SetApplyToAmount;
          PaymentToleranceMgt.PmtTolGenJnl(Rec);
        end;

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine;
          UpdatePricesFromJobJnlLine;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.01 DDR 08/02/2008
        TestPeriodicWkshtLine();
        // >>DITW15.00.00.01 DDR
        GetCurrency;
        if "Currency Code" = '' then
          "Amount (LCY)" := Amount
        else
        #5..10
        if (CurrFieldNo <> 0) and
           (CurrFieldNo <> FIELDNO("Applies-to Doc. No.")) and
           ((("Account Type" = "Account Type"::Customer) and
             ("Account No." <> '') and (Amount > 0) and
             (CurrFieldNo <> FIELDNO("Bal. Account No."))) or
            (("Bal. Account Type" = "Bal. Account Type"::Customer) and
             ("Bal. Account No." <> '') and (Amount < 0) and
             (CurrFieldNo <> FIELDNO("Account No."))))
        then
        #20..24
        if "Deferral Code" <> '' then
          VALIDATE("Deferral Code");

        if Amount <> xRec.Amount then begin
          if ("Applies-to Doc. No." <> '') or ("Applies-to ID" <> '') then
            SetApplyToAmount;
          PaymentToleranceMgt.PmtTolGenJnl(Rec);
        end;

        if JobTaskIsSet then begin
          CreateTempJobJnlLine;
          UpdatePricesFromJobJnlLine;
        end;

        GetDerogatorySetup; //HEI.25

        //HEI.27>>
        {IF "Amount (LCY)" > 0 THEN
           "Debit Amount (LCY)" := "Amount (LCY)"
        else
          IF "Amount (LCY)" < 0 THEN
            "Credit Amount (LCY)" := "Amount (LCY)"
          else BEGIN
            CLEAR("Debit Amount (LCY)");
            CLEAR("Credit Amount (LCY)");
          end;
        }
        //HEI.27<<
        //>>HEI.52
        if "Amount (LCY)" <> 0 then begin
          if "Amount (LCY)" > 0 then begin
             "Debit Amount (LCY)" := "Amount (LCY)";
             "Credit Amount (LCY)" := 0;
          end else begin
            if "Amount (LCY)" < 0 then
              "Credit Amount (LCY)" := ABS("Amount (LCY)");
              "Debit Amount (LCY)" := 0;
            end;
        end else begin
         CLEAR("Debit Amount (LCY)");
         CLEAR("Credit Amount (LCY)");
        end;
        //<<HEI.52
        */
        //end;


        //Unsupported feature: CodeModification on ""Amount (LCY)"(Field 16).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Currency Code" = '' THEN BEGIN
          Amount := "Amount (LCY)";
          VALIDATE(Amount);
        end else BEGIN
          IF CheckFixedCurrency THEN BEGIN
            GetCurrency;
            Amount := ROUND(
                CurrExchRate.ExchangeAmtLCYToFCY(
                  "Posting Date","Currency Code",
                  "Amount (LCY)","Currency Factor"),
                Currency."Amount Rounding Precision")
          end else BEGIN
            TESTFIELD("Amount (LCY)");
            TESTFIELD(Amount);
            "Currency Factor" := Amount / "Amount (LCY)";
          end;

          VALIDATE("VAT %");
          VALIDATE("Bal. VAT %");
          UpdateLineBalance;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.01 DDR 08/02/2008
        TestPeriodicWkshtLine();
        // >>DITW15.00.00.01 DDR
        if "Currency Code" = '' then begin
          Amount := "Amount (LCY)";
          VALIDATE(Amount);
        end else begin
          if CheckFixedCurrency then begin
        #6..11
          end else begin
        #13..15
          end;
        #17..20
        end;



        //HEI.27>>
        {
        IF "Amount (LCY)" > 0 THEN
          "Debit Amount (LCY)" := "Amount (LCY)"
        else
          IF "Amount (LCY)" < 0 THEN
            "Credit Amount (LCY)" := "Amount (LCY)"
          else BEGIN
            CLEAR("Debit Amount (LCY)");
            CLEAR("Credit Amount (LCY)");
          end;
        }
        //HEI.27<<
        //>>HEI.52
        if "Amount (LCY)" <> 0 then begin
          if "Amount (LCY)" > 0 then begin
            "Debit Amount (LCY)" := "Amount (LCY)";
            "Credit Amount (LCY)" := 0
          end else begin
            if "Amount (LCY)" < 0 then
              "Credit Amount (LCY)" := ABS("Amount (LCY)");
              "Debit Amount (LCY)" := 0
          end;
        end else begin
           CLEAR("Debit Amount (LCY)");
           CLEAR("Credit Amount (LCY)");
        end;
        //<<HEI.52
        */
        //end;


        //Unsupported feature: CodeModification on ""Currency Factor"(Field 18).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Currency Code" = '') AND ("Currency Factor" <> 0) THEN
          FIELDERROR("Currency Factor",STRSUBSTNO(Text002,FIELDCAPTION("Currency Code")));
        VALIDATE(Amount);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Currency Code" = '') and ("Currency Factor" <> 0) then
          FIELDERROR("Currency Factor",STRSUBSTNO(Text002,FIELDCAPTION("Currency Code")));
        VALIDATE(Amount);
        */
        //end;


        //Unsupported feature: CodeModification on ""Bill-to/Pay-to No."(Field 22).OnValidate". Please convert manually.

        //trigger "(Field 22)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bill-to/Pay-to No." <> xRec."Bill-to/Pay-to No." THEN
          "Ship-to/Order Address Code" := '';
        ReadGLSetup;
        IF GLSetup."Bill-to/Sell-to VAT Calc." = GLSetup."Bill-to/Sell-to VAT Calc."::"Bill-to/Pay-to No." THEN
          UpdateCountryCodeAndVATRegNo("Bill-to/Pay-to No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Bill-to/Pay-to No." <> xRec."Bill-to/Pay-to No." then
          "Ship-to/Order Address Code" := '';
        ReadGLSetup;
        if GLSetup."Bill-to/Sell-to VAT Calc." = GLSetup."Bill-to/Sell-to VAT Calc."::"Bill-to/Pay-to No." then
          UpdateCountryCodeAndVATRegNo("Bill-to/Pay-to No.");
        PurchasesUtils.UpdateBankAcc(Rec,xRec);//HEI.02 PTPGAP066 new line
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Posting Group"(Field 23)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<<DITW17.00.02 TEC1 17/12/2013 DIT-770 #163
        if not ("DIT Sub-Contract Type" = "DIT Sub-Contract Type"::" ") then
          ERROR(Text2034840);
        //>>DITW17.00.02 TEC1 DIT-770 #163
        //<<DITW17.10.03 MSF 17/03/2014 DIT-715 #340
        if "Applies-to Doc. No."<>''then
         ERROR(Text2034841,FIELDCAPTION("Posting Group"),FIELDCAPTION("Applies-to Doc. No."));
        //>>DITW17.10.03 MSF 17/03/2014 DIT-715 #340
        //<< DITW18.10.07 VSC 01/06/2016 DIT-770 #2005
        if ("Applies-to ID"<>'' )then
         ERROR(Text2034841,FIELDCAPTION("Posting Group"),FIELDCAPTION("Applies-to ID"));
        //>> DITW18.10.07 VSC DIT-770 #2005
        */
        //end;


        //Unsupported feature: CodeModification on ""Salespers./Purch. Code"(Field 26).OnValidate". Please convert manually.

        //trigger /Purch();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CreateDim(
          DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
          DimMgt.TypeToTableID1("Account Type"),"Account No.",
          DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
          DATABASE::Job,"Job No.",
          DATABASE::Campaign,"Campaign No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
          DATABASE::Campaign,"Campaign No.",
          // <<DITW15.00.00.37 DDR 28/01/2010
          DATABASE::Building,"Building No.",
          // >>DITW15.00.00.37 DDR
          // <<DITW16.00.00.41 AHU 06/08/2012 20/09/2012 DIT-715 #327
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          DimMgt.TypeToTableID2034932(GetSourceType(),"Contract Type"),GetContractNo());
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          // >>DITW16.00.00.41 AHU DIT-715 #327
        */
        //end;


        //Unsupported feature: CodeModification on ""Applies-to Doc. Type"(Field 35).OnValidate". Please convert manually.

        //trigger  Type"(Field 35)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Applies-to Doc. Type" <> xRec."Applies-to Doc. Type" THEN
          VALIDATE("Applies-to Doc. No.",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Applies-to Doc. Type" <> xRec."Applies-to Doc. Type" then
          VALIDATE("Applies-to Doc. No.",'');
        */
        //end;


        //Unsupported feature: CodeModification on ""Applies-to Doc. No."(Field 36).OnLookup". Please convert manually.

        //trigger  No();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        xRec.Amount := Amount;
        xRec."Currency Code" := "Currency Code";
        xRec."Posting Date" := "Posting Date";
        #4..16
        IF xRec.Amount <> 0 THEN
          IF NOT PaymentToleranceMgt.PmtTolGenJnl(Rec) THEN
            EXIT;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<FINXL7.00 RBE 20/03/2013
        if recFinXLSetup.READPERMISSION then
         PickupDocument(false);
        //>>FINXL7.00 RBE 20/03/2013

        /// DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 - DITW110.00.08 DDR 02/01/2017 NRQ#0

        //<<FINXL7.00 RBE 20/03/2013
        {
        //>>FINXL7.00 RBE 20/03/2013
        #1..19
        //<<FINXL7.00 RBE 20/03/2013
        }
        //>>FINXL7.00 RBE 20/03/2013
        */
        //end;


        //Unsupported feature: CodeModification on ""Applies-to Doc. No."(Field 36).OnValidate". Please convert manually.

        //trigger  No();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Applies-to Doc. No." <> xRec."Applies-to Doc. No." THEN
          ClearCustVendApplnEntry;

        IF ("Applies-to Doc. No." = '') AND (xRec."Applies-to Doc. No." <> '') THEN BEGIN
          PaymentToleranceMgt.DelPmtTolApllnDocNo(Rec,xRec."Applies-to Doc. No.");

          TempGenJnlLine := Rec;
          IF (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Customer) OR
             (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Vendor)
          THEN
            CODEUNIT.RUN(CODEUNIT::"Exchange Acc. G/L Journal Line",TempGenJnlLine);

          IF TempGenJnlLine."Account Type" = TempGenJnlLine."Account Type"::Customer THEN BEGIN
            CustLedgEntry.SETCURRENTKEY("Document No.");
            CustLedgEntry.SETRANGE("Document No.",xRec."Applies-to Doc. No.");
            IF NOT (xRec."Applies-to Doc. Type" = "Document Type"::" ") THEN
              CustLedgEntry.SETRANGE("Document Type",xRec."Applies-to Doc. Type");
            CustLedgEntry.SETRANGE("Customer No.",TempGenJnlLine."Account No.");
            CustLedgEntry.SETRANGE(Open,TRUE);
            IF CustLedgEntry.FINDFIRST THEN BEGIN
              IF CustLedgEntry."Amount to Apply" <> 0 THEN  BEGIN
                CustLedgEntry."Amount to Apply" := 0;
                CODEUNIT.RUN(CODEUNIT::"Cust. Entry-Edit",CustLedgEntry);
              end;
              "Exported to Payment File" := CustLedgEntry."Exported to Payment File";
              "Applies-to Ext. Doc. No." := '';
            end;
          end else
            IF TempGenJnlLine."Account Type" = TempGenJnlLine."Account Type"::Vendor THEN BEGIN
              VendLedgEntry.SETCURRENTKEY("Document No.");
              VendLedgEntry.SETRANGE("Document No.",xRec."Applies-to Doc. No.");
              IF NOT (xRec."Applies-to Doc. Type" = "Document Type"::" ") THEN
                VendLedgEntry.SETRANGE("Document Type",xRec."Applies-to Doc. Type");
              VendLedgEntry.SETRANGE("Vendor No.",TempGenJnlLine."Account No.");
              VendLedgEntry.SETRANGE(Open,TRUE);
              IF VendLedgEntry.FINDFIRST THEN BEGIN
                IF VendLedgEntry."Amount to Apply" <> 0 THEN  BEGIN
                  VendLedgEntry."Amount to Apply" := 0;
                  CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit",VendLedgEntry);
                end;
                "Exported to Payment File" := VendLedgEntry."Exported to Payment File";
              end;
              "Applies-to Ext. Doc. No." := '';
            end;
        end;

        IF ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") AND (Amount <> 0) THEN BEGIN
          IF xRec."Applies-to Doc. No." <> '' THEN
            PaymentToleranceMgt.DelPmtTolApllnDocNo(Rec,xRec."Applies-to Doc. No.");
          SetApplyToAmount;
          PaymentToleranceMgt.PmtTolGenJnl(Rec);
          xRec.ClearAppliedGenJnlLine;
        end;

        CASE "Account Type" OF
          "Account Type"::Customer:
            GetCustLedgerEntry;
          "Account Type"::Vendor:
            GetVendLedgerEntry;
        end;

        ValidateApplyRequirements(Rec);
        SetJournalLineFieldsFromApplication;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<FINXL7.00 RBE 20/03/2013
        if recFinXLSetup.READPERMISSION then
          PickupDocument(true);
        //>>FINXL7.00 RBE 20/03/2013

        // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
        GLSetup.GET;
        // >>DITW16.00.00.42 DDR DIT-715 #370

        if "Applies-to Doc. No." <> xRec."Applies-to Doc. No." then
          ClearCustVendApplnEntry;

        if ("Applies-to Doc. No." = '') and (xRec."Applies-to Doc. No." <> '') then begin
          PaymentToleranceMgt.DelPmtTolApllnDocNo(Rec,xRec."Applies-to Doc. No.");

          //<<DITW17.10.03 MSF 17/03/2014 DIT-715 #340
          "Contract Group Code":='';
          "DIT Sub-Contract Type" := "DIT Sub-Contract Type"::" ";
          "Service Contract No.":='';
           //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          "Financial Contract No." :='';
           //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          //>>DITW17.10.03 MSF 17/03/2014 DIT-715 #340

          //<<FINXL7.00.001 RBE 20/03/2013
          PickupDocument(true);
          //>>FINXL7.00.001 RBE 20/03/2013

          TempGenJnlLine := Rec;
          if (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Customer) or
             (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Vendor)
          then
            CODEUNIT.RUN(CODEUNIT::"Exchange Acc. G/L Journal Line",TempGenJnlLine);

          if TempGenJnlLine."Account Type" = TempGenJnlLine."Account Type"::Customer then begin
            CustLedgEntry.SETCURRENTKEY("Document No.");
            CustLedgEntry.SETRANGE("Document No.",xRec."Applies-to Doc. No.");
            if not (xRec."Applies-to Doc. Type" = "Document Type"::" ") then
              CustLedgEntry.SETRANGE("Document Type",xRec."Applies-to Doc. Type");
            CustLedgEntry.SETRANGE("Customer No.",TempGenJnlLine."Account No.");
            CustLedgEntry.SETRANGE(Open,true);
            if CustLedgEntry.FINDFIRST then begin
              if CustLedgEntry."Amount to Apply" <> 0 then  begin
                CustLedgEntry."Amount to Apply" := 0;
                CODEUNIT.RUN(CODEUNIT::"Cust. Entry-Edit",CustLedgEntry);
              end;
              "Exported to Payment File" := CustLedgEntry."Exported to Payment File";
              "Applies-to Ext. Doc. No." := '';
            end;
          end else
            if TempGenJnlLine."Account Type" = TempGenJnlLine."Account Type"::Vendor then begin
              VendLedgEntry.SETCURRENTKEY("Document No.");
              VendLedgEntry.SETRANGE("Document No.",xRec."Applies-to Doc. No.");
              if not (xRec."Applies-to Doc. Type" = "Document Type"::" ") then
                VendLedgEntry.SETRANGE("Document Type",xRec."Applies-to Doc. Type");
              VendLedgEntry.SETRANGE("Vendor No.",TempGenJnlLine."Account No.");
              VendLedgEntry.SETRANGE(Open,true);
              if VendLedgEntry.FINDFIRST then begin
                if VendLedgEntry."Amount to Apply" <> 0 then  begin
                  VendLedgEntry."Amount to Apply" := 0;
                  CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit",VendLedgEntry);
                end;
                "Exported to Payment File" := VendLedgEntry."Exported to Payment File";
              end;
              "Applies-to Ext. Doc. No." := '';
            end;
        end;

        // <<DITW15.00.00.37 DDR 10/05/2010
        if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and ("Applies-to Doc. No." <> '') then
          SetApplyFields;
        // >>DITW15.00.00.37 DDR

        if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and (Amount <> 0) then begin
          if xRec."Applies-to Doc. No." <> '' then
        #49..52
        end;

        case "Account Type" of
        #56..59
        end;
        #61..63
        */
        //end;


        //Unsupported feature: CodeModification on ""Job No."(Field 42).OnValidate". Please convert manually.

        //trigger "(Field 42)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Job No." = xRec."Job No." THEN
          EXIT;

        SourceCodeSetup.GET;
        IF "Source Code" <> SourceCodeSetup."Job G/L WIP" THEN
          VALIDATE("Job Task No.",'');
        IF "Job No." = '' THEN BEGIN
          CreateDim(
            DATABASE::Job,"Job No.",
            DimMgt.TypeToTableID1("Account Type"),"Account No.",
            DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
            DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
            DATABASE::Campaign,"Campaign No.");
          EXIT;
        end;

        TESTFIELD("Account Type","Account Type"::"G/L Account");

        IF "Bal. Account No." <> '' THEN
          IF NOT ("Bal. Account Type" IN ["Bal. Account Type"::"G/L Account","Bal. Account Type"::"Bank Account"]) THEN
            ERROR(Text016,FIELDCAPTION("Bal. Account Type"));

        Job.GET("Job No.");
        #24..28
          DimMgt.TypeToTableID1("Account Type"),"Account No.",
          DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
          DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
          DATABASE::Campaign,"Campaign No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Job No." = xRec."Job No." then
          exit;

        SourceCodeSetup.GET;
        if "Source Code" <> SourceCodeSetup."Job G/L WIP" then
          VALIDATE("Job Task No.",'');
        if "Job No." = '' then begin
        #8..12
            DATABASE::Campaign,"Campaign No.",
            // <<DITW15.00.00.37 DDR 28/01/2010
            DATABASE::Building,"Building No.",
            // >>DITW15.00.00.37 DDR
            // <<DITW16.00.00.41 AHU 06/08/2012 20/09/2012 DIT-715 #327
            //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
            DimMgt.TypeToTableID2034932(GetSourceType(),"Contract Type"),GetContractNo());
            //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
            // >>DITW16.00.00.41 AHU DIT-715 #327
          exit;
        end;
        #16..18
        if "Bal. Account No." <> '' then
          if not ("Bal. Account Type" in ["Bal. Account Type"::"G/L Account","Bal. Account Type"::"Bank Account"]) then
        #21..31
          DATABASE::Campaign,"Campaign No.",
          // <<DITW15.00.00.37 DDR 28/01/2010
          DATABASE::Building,"Building No.",
          // >>DITW15.00.00.37 DDR
          // <<DITW16.00.00.41 AHU 06/08/2012 20/09/2012 DIT-715 #327
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          DimMgt.TypeToTableID2034932(GetSourceType(),"Contract Type"),GetContractNo());
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          // >>DITW16.00.00.41 AHU DIT-715 #327
        */
        //end;


        //Unsupported feature: CodeModification on ""VAT Amount"(Field 44).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
        GenJnlBatch.TESTFIELD("Allow VAT Difference",TRUE);
        IF NOT ("VAT Calculation Type" IN
                ["VAT Calculation Type"::"Normal VAT","VAT Calculation Type"::"Reverse Charge VAT"])
        THEN
          ERROR(
            Text010,FIELDCAPTION("VAT Calculation Type"),
            "VAT Calculation Type"::"Normal VAT","VAT Calculation Type"::"Reverse Charge VAT");
        IF "VAT Amount" <> 0 THEN BEGIN
          TESTFIELD("VAT %");
          TESTFIELD(Amount);
        end;

        GetCurrency;
        "VAT Amount" := ROUND("VAT Amount",Currency."Amount Rounding Precision",Currency.VATRoundingDirection);

        IF "VAT Amount" * Amount < 0 THEN
          IF "VAT Amount" > 0 THEN
            ERROR(Text011,FIELDCAPTION("VAT Amount"))
          else
            ERROR(Text012,FIELDCAPTION("VAT Amount"));

        "VAT Base Amount" := Amount - "VAT Amount";
        #24..26
          ROUND(
            Amount * "VAT %" / (100 + "VAT %"),
            Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
        IF ABS("VAT Difference") > Currency."Max. VAT Difference Allowed" THEN
          ERROR(Text013,FIELDCAPTION("VAT Difference"),Currency."Max. VAT Difference Allowed");

        IF "Currency Code" = '' THEN
          "VAT Amount (LCY)" := "VAT Amount"
        else
          "VAT Amount (LCY)" :=
            ROUND(
              CurrExchRate.ExchangeAmtFCYToLCY(
        #39..41

        UpdateSalesPurchLCY;

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine;
          UpdatePricesFromJobJnlLine;
        end;

        IF "Deferral Code" <> '' THEN
          VALIDATE("Deferral Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
        GenJnlBatch.TESTFIELD("Allow VAT Difference",true);
        if not ("VAT Calculation Type" in
                ["VAT Calculation Type"::"Normal VAT","VAT Calculation Type"::"Reverse Charge VAT"])
        then
        #6..8
        if "VAT Amount" <> 0 then begin
          TESTFIELD("VAT %");
          TESTFIELD(Amount);
        end;
        #13..16
        if "VAT Amount" * Amount < 0 then
          if "VAT Amount" > 0 then
            ERROR(Text011,FIELDCAPTION("VAT Amount"))
          else
        #21..29
        if ABS("VAT Difference") > Currency."Max. VAT Difference Allowed" then
          ERROR(Text013,FIELDCAPTION("VAT Difference"),Currency."Max. VAT Difference Allowed");

        if "Currency Code" = '' then
          "VAT Amount (LCY)" := "VAT Amount"
        else
        #36..44
        if JobTaskIsSet then begin
          CreateTempJobJnlLine;
          UpdatePricesFromJobJnlLine;
        end;

        if "Deferral Code" <> '' then
          VALIDATE("Deferral Code");
        */
        //end;


        //Unsupported feature: CodeModification on ""Payment Terms Code"(Field 47).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Due Date" := 0D;
        "Pmt. Discount Date" := 0D;
        "Payment Discount %" := 0;
        IF ("Account Type" <> "Account Type"::"G/L Account") OR
           ("Bal. Account Type" <> "Bal. Account Type"::"G/L Account")
        THEN
          CASE "Document Type" OF
            "Document Type"::Invoice:
              IF ("Payment Terms Code" <> '') AND ("Document Date" <> 0D) THEN BEGIN
                PaymentTerms.GET("Payment Terms Code");
                "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation","Document Date");
                "Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation","Document Date");
                "Payment Discount %" := PaymentTerms."Discount %";
              end;
            "Document Type"::"Credit Memo":
              IF ("Payment Terms Code" <> '') AND ("Document Date" <> 0D) THEN BEGIN
                PaymentTerms.GET("Payment Terms Code");
                IF PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" THEN BEGIN
                  "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation","Document Date");
                  "Pmt. Discount Date" :=
                    CALCDATE(PaymentTerms."Discount Date Calculation","Document Date");
                  "Payment Discount %" := PaymentTerms."Discount %";
                end else
                  "Due Date" := "Document Date";
              end;
            else
              "Due Date" := "Document Date";
          end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        if ("Account Type" <> "Account Type"::"G/L Account") or
           ("Bal. Account Type" <> "Bal. Account Type"::"G/L Account")
        then
          case "Document Type" of
            "Document Type"::Invoice:
              if ("Payment Terms Code" <> '') and ("Document Date" <> 0D) then begin
        #10..13
              end;
            "Document Type"::"Credit Memo":
              if ("Payment Terms Code" <> '') and ("Document Date" <> 0D) then begin
                PaymentTerms.GET("Payment Terms Code");
                if PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then begin
        #19..22
                end else
                  "Due Date" := "Document Date";
              end;
            else
              "Due Date" := "Document Date";
          end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Applies-to ID"(Field 48).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Applies-to ID" <> xRec."Applies-to ID") AND (xRec."Applies-to ID" <> '') THEN
          ClearCustVendApplnEntry;
        SetJournalLineFieldsFromApplication;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Applies-to ID" <> xRec."Applies-to ID") and (xRec."Applies-to ID" <> '') then
          ClearCustVendApplnEntry;
        SetJournalLineFieldsFromApplication;
        */
        //end;


        //Unsupported feature: CodeModification on ""Recurring Method"(Field 53).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Recurring Method" IN
           ["Recurring Method"::"B  Balance","Recurring Method"::"RB Reversing Balance"]
        THEN
          TESTFIELD("Currency Code",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Recurring Method" in
           ["Recurring Method"::"B  Balance","Recurring Method"::"RB Reversing Balance"]
        then
          TESTFIELD("Currency Code",'');
        */
        //end;


        //Unsupported feature: CodeModification on ""Gen. Posting Type"(Field 57).OnValidate". Please convert manually.

        //trigger  Posting Type"(Field 57)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account"] THEN
          TESTFIELD("Gen. Posting Type","Gen. Posting Type"::" ");
        IF ("Gen. Posting Type" = "Gen. Posting Type"::Settlement) AND (CurrFieldNo <> 0) THEN
          ERROR(Text006,"Gen. Posting Type");
        CheckVATInAlloc;
        IF "Gen. Posting Type" > 0 THEN
          VALIDATE("VAT Prod. Posting Group");
        IF "Gen. Posting Type" <> "Gen. Posting Type"::Purchase THEN
          VALIDATE("Use Tax",FALSE)
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Account Type" in ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account"] then
          TESTFIELD("Gen. Posting Type","Gen. Posting Type"::" ");
        if ("Gen. Posting Type" = "Gen. Posting Type"::Settlement) and (CurrFieldNo <> 0) then
          ERROR(Text006,"Gen. Posting Type");
        CheckVATInAlloc;
        if "Gen. Posting Type" > 0 then
          VALIDATE("VAT Prod. Posting Group");
        if "Gen. Posting Type" <> "Gen. Posting Type"::Purchase then
          VALIDATE("Use Tax",false)
        */
        //end;


        //Unsupported feature: CodeModification on ""Gen. Bus. Posting Group"(Field 58).OnValidate". Please convert manually.

        //trigger  Bus();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account"] THEN
          TESTFIELD("Gen. Bus. Posting Group",'');
        IF xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" THEN
          IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") THEN
            VALIDATE("VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Account Type" in ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account"] then
          TESTFIELD("Gen. Bus. Posting Group",'');
        if xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then
          if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") then
            VALIDATE("VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");
        */
        //end;


        //Unsupported feature: CodeModification on ""Gen. Prod. Posting Group"(Field 59).OnValidate". Please convert manually.

        //trigger  Prod();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account"] THEN
          TESTFIELD("Gen. Prod. Posting Group",'');
        IF xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" THEN
          IF GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Gen. Prod. Posting Group") THEN
            VALIDATE("VAT Prod. Posting Group",GenProdPostingGrp."Def. VAT Prod. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Account Type" in ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account"] then
          TESTFIELD("Gen. Prod. Posting Group",'');
        if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then
          if GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Gen. Prod. Posting Group") then
            VALIDATE("VAT Prod. Posting Group",GenProdPostingGrp."Def. VAT Prod. Posting Group");
        */
        //end;


        //Unsupported feature: CodeModification on ""Bal. Account Type"(Field 63).OnValidate". Please convert manually.

        //trigger  Account Type"(Field 63)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Fixed Asset",
                               "Account Type"::"IC Partner"]) AND
           ("Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Fixed Asset",
                                    "Bal. Account Type"::"IC Partner"])
        THEN
          ERROR(
            Text000,
            FIELDCAPTION("Account Type"),FIELDCAPTION("Bal. Account Type"));
        VALIDATE("Bal. Account No.",'');
        VALIDATE("IC Partner G/L Acc. No.",'');
        IF "Bal. Account Type" IN
           ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Bank Account"]
        THEN BEGIN
          VALIDATE("Bal. Gen. Posting Type","Bal. Gen. Posting Type"::" ");
          VALIDATE("Bal. Gen. Bus. Posting Group",'');
          VALIDATE("Bal. Gen. Prod. Posting Group",'');
        end else
          IF "Account Type" IN [
                                "Bal. Account Type"::"G/L Account","Account Type"::"Bank Account","Account Type"::"Fixed Asset"]
          THEN
            VALIDATE("Payment Terms Code",'');
        UpdateSource;
        IF ("Account Type" <> "Account Type"::"Fixed Asset") AND
           ("Bal. Account Type" <> "Bal. Account Type"::"Fixed Asset")
        THEN BEGIN
          "Depreciation Book Code" := '';
          VALIDATE("FA Posting Type","FA Posting Type"::" ");
        end;
        IF xRec."Bal. Account Type" IN
           [xRec."Bal. Account Type"::Customer,xRec."Bal. Account Type"::Vendor]
        THEN BEGIN
          "Bill-to/Pay-to No." := '';
          "Ship-to/Order Address Code" := '';
          "Sell-to/Buy-from No." := '';
          "VAT Registration No." := '';
        end;
        IF ("Account Type" IN [
                               "Account Type"::"G/L Account","Account Type"::"Bank Account","Account Type"::"Fixed Asset"]) AND
           ("Bal. Account Type" IN [
                                    "Bal. Account Type"::"G/L Account","Bal. Account Type"::"Bank Account","Bal. Account Type"::"Fixed Asset"])
        THEN
          VALIDATE("Payment Terms Code",'');

        IF "Bal. Account Type" = "Bal. Account Type"::"IC Partner" THEN BEGIN
          GetTemplate;
          IF GenJnlTemplate.Type <> GenJnlTemplate.Type::Intercompany THEN
            FIELDERROR("Bal. Account Type");
        end;
        IF "Bal. Account Type" <> "Bal. Account Type"::"Bank Account" THEN
          VALIDATE("Credit Card No.",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Account Type" in ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Fixed Asset",
                               "Account Type"::"IC Partner"]) and
           ("Bal. Account Type" in ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Fixed Asset",
                                    "Bal. Account Type"::"IC Partner"])
        then
        #6..10
        if "Bal. Account Type" in
           ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Bank Account"]
        then begin
        #14..16
        end else
          if "Account Type" in [
                                "Bal. Account Type"::"G/L Account","Account Type"::"Bank Account","Account Type"::"Fixed Asset"]
          then
            VALIDATE("Payment Terms Code",'');
        UpdateSource;
        if ("Account Type" <> "Account Type"::"Fixed Asset") and
           ("Bal. Account Type" <> "Bal. Account Type"::"Fixed Asset")
        then begin
          "Depreciation Book Code" := '';
          VALIDATE("FA Posting Type","FA Posting Type"::" ");
        end;
        if xRec."Bal. Account Type" in
           [xRec."Bal. Account Type"::Customer,xRec."Bal. Account Type"::Vendor]
        then begin
        #32..35
        end;
        if ("Account Type" in [
                               "Account Type"::"G/L Account","Account Type"::"Bank Account","Account Type"::"Fixed Asset"]) and
           ("Bal. Account Type" in [
                                    "Bal. Account Type"::"G/L Account","Bal. Account Type"::"Bank Account","Bal. Account Type"::"Fixed Asset"])
        then
          VALIDATE("Payment Terms Code",'');

        if "Bal. Account Type" = "Bal. Account Type"::"IC Partner" then begin
          GetTemplate;
          if GenJnlTemplate.Type <> GenJnlTemplate.Type::Intercompany then
            FIELDERROR("Bal. Account Type");
        end;
        if "Bal. Account Type" <> "Bal. Account Type"::"Bank Account" then
          VALIDATE("Credit Card No.",'');
        PurchasesUtils.UpdateBankAcc(Rec,xRec);//HEI.02 PTPGAP066 new line
        */
        //end;


        //Unsupported feature: CodeModification on ""Bal. Gen. Posting Type"(Field 64).OnValidate". Please convert manually.

        //trigger  Gen();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Bank Account"] THEN
          TESTFIELD("Bal. Gen. Posting Type","Bal. Gen. Posting Type"::" ");
        IF ("Bal. Gen. Posting Type" = "Gen. Posting Type"::Settlement) AND (CurrFieldNo <> 0) THEN
          ERROR(Text006,"Bal. Gen. Posting Type");
        IF "Bal. Gen. Posting Type" > 0 THEN
          VALIDATE("Bal. VAT Prod. Posting Group");

        IF ("Account Type" <> "Account Type"::"Fixed Asset") AND
           ("Bal. Account Type" <> "Bal. Account Type"::"Fixed Asset")
        THEN BEGIN
          "Depreciation Book Code" := '';
          VALIDATE("FA Posting Type","FA Posting Type"::" ");
        end;
        IF "Bal. Gen. Posting Type" <> "Bal. Gen. Posting Type"::Purchase THEN
          VALIDATE("Bal. Use Tax",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Bal. Account Type" in ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Bank Account"] then
          TESTFIELD("Bal. Gen. Posting Type","Bal. Gen. Posting Type"::" ");
        if ("Bal. Gen. Posting Type" = "Gen. Posting Type"::Settlement) and (CurrFieldNo <> 0) then
          ERROR(Text006,"Bal. Gen. Posting Type");
        if "Bal. Gen. Posting Type" > 0 then
          VALIDATE("Bal. VAT Prod. Posting Group");

        if ("Account Type" <> "Account Type"::"Fixed Asset") and
           ("Bal. Account Type" <> "Bal. Account Type"::"Fixed Asset")
        then begin
          "Depreciation Book Code" := '';
          VALIDATE("FA Posting Type","FA Posting Type"::" ");
        end;
        if "Bal. Gen. Posting Type" <> "Bal. Gen. Posting Type"::Purchase then
          VALIDATE("Bal. Use Tax",false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Bal. Gen. Bus. Posting Group"(Field 65).OnValidate". Please convert manually.

        //trigger  Gen();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Bank Account"] THEN
          TESTFIELD("Bal. Gen. Bus. Posting Group",'');
        IF xRec."Bal. Gen. Bus. Posting Group" <> "Bal. Gen. Bus. Posting Group" THEN
          IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Bal. Gen. Bus. Posting Group") THEN
            VALIDATE("Bal. VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Bal. Account Type" in ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Bank Account"] then
          TESTFIELD("Bal. Gen. Bus. Posting Group",'');
        if xRec."Bal. Gen. Bus. Posting Group" <> "Bal. Gen. Bus. Posting Group" then
          if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Bal. Gen. Bus. Posting Group") then
            VALIDATE("Bal. VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");
        */
        //end;


        //Unsupported feature: CodeModification on ""Bal. Gen. Prod. Posting Group"(Field 66).OnValidate". Please convert manually.

        //trigger  Gen();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Bank Account"] THEN
          TESTFIELD("Bal. Gen. Prod. Posting Group",'');
        IF xRec."Bal. Gen. Prod. Posting Group" <> "Bal. Gen. Prod. Posting Group" THEN
          IF GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Bal. Gen. Prod. Posting Group") THEN
            VALIDATE("Bal. VAT Prod. Posting Group",GenProdPostingGrp."Def. VAT Prod. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Bal. Account Type" in ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Bank Account"] then
          TESTFIELD("Bal. Gen. Prod. Posting Group",'');
        if xRec."Bal. Gen. Prod. Posting Group" <> "Bal. Gen. Prod. Posting Group" then
          if GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Bal. Gen. Prod. Posting Group") then
            VALIDATE("Bal. VAT Prod. Posting Group",GenProdPostingGrp."Def. VAT Prod. Posting Group");
        */
        //end;


        //Unsupported feature: CodeModification on ""Bal. VAT %"(Field 68).OnValidate". Please convert manually.

        //trigger  VAT %"(Field 68)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetCurrency;
        CASE "Bal. VAT Calculation Type" OF
          "Bal. VAT Calculation Type"::"Normal VAT",
          "Bal. VAT Calculation Type"::"Reverse Charge VAT":
            BEGIN
              "Bal. VAT Amount" :=
                ROUND(-Amount * "Bal. VAT %" / (100 + "Bal. VAT %"),Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
              "Bal. VAT Base Amount" :=
                ROUND(-Amount - "Bal. VAT Amount",Currency."Amount Rounding Precision");
            end;
          "Bal. VAT Calculation Type"::"Full VAT":
            "Bal. VAT Amount" := -Amount;
          "Bal. VAT Calculation Type"::"Sales Tax":
            IF ("Bal. Gen. Posting Type" = "Bal. Gen. Posting Type"::Purchase) AND
               "Bal. Use Tax"
            THEN BEGIN
              "Bal. VAT Amount" := 0;
              "Bal. VAT %" := 0;
            end else BEGIN
              "Bal. VAT Amount" :=
                -(Amount -
                  SalesTaxCalculate.ReverseCalculateTax(
                    "Bal. Tax Area Code","Bal. Tax Group Code","Bal. Tax Liable",
                    "Posting Date",Amount,Quantity,"Currency Factor"));
              IF Amount + "Bal. VAT Amount" <> 0 THEN
                "Bal. VAT %" := ROUND(100 * -"Bal. VAT Amount" / (Amount + "Bal. VAT Amount"),0.00001)
              else
                "Bal. VAT %" := 0;
              "Bal. VAT Amount" :=
                ROUND("Bal. VAT Amount",Currency."Amount Rounding Precision");
            end;
        end;
        "Bal. VAT Base Amount" := -(Amount + "Bal. VAT Amount");
        "Bal. VAT Difference" := 0;

        IF "Currency Code" = '' THEN
          "Bal. VAT Amount (LCY)" := "Bal. VAT Amount"
        else
          "Bal. VAT Amount (LCY)" :=
            ROUND(
              CurrExchRate.ExchangeAmtFCYToLCY(
                "Posting Date","Currency Code",
                "Bal. VAT Amount","Currency Factor"));
        "Bal. VAT Base Amount (LCY)" := -("Amount (LCY)" + "Bal. VAT Amount (LCY)");

        UpdateSalesPurchLCY;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetCurrency;
        case "Bal. VAT Calculation Type" of
          "Bal. VAT Calculation Type"::"Normal VAT",
          "Bal. VAT Calculation Type"::"Reverse Charge VAT":
            begin
        #6..9
            end;
        #11..13
            if ("Bal. Gen. Posting Type" = "Bal. Gen. Posting Type"::Purchase) and
               "Bal. Use Tax"
            then begin
              "Bal. VAT Amount" := 0;
              "Bal. VAT %" := 0;
            end else begin
        #20..24
              if Amount + "Bal. VAT Amount" <> 0 then
                "Bal. VAT %" := ROUND(100 * -"Bal. VAT Amount" / (Amount + "Bal. VAT Amount"),0.00001)
              else
        #28..30
            end;
        end;
        #33..35
        if "Currency Code" = '' then
          "Bal. VAT Amount (LCY)" := "Bal. VAT Amount"
        else
        #39..46
        */
        //end;


        //Unsupported feature: CodeModification on ""Bal. VAT Amount"(Field 69).OnValidate". Please convert manually.

        //trigger  VAT Amount"(Field 69)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
        GenJnlBatch.TESTFIELD("Allow VAT Difference",TRUE);
        IF NOT ("Bal. VAT Calculation Type" IN
                ["Bal. VAT Calculation Type"::"Normal VAT","Bal. VAT Calculation Type"::"Reverse Charge VAT"])
        THEN
          ERROR(
            Text010,FIELDCAPTION("Bal. VAT Calculation Type"),
            "Bal. VAT Calculation Type"::"Normal VAT","Bal. VAT Calculation Type"::"Reverse Charge VAT");
        IF "Bal. VAT Amount" <> 0 THEN BEGIN
          TESTFIELD("Bal. VAT %");
          TESTFIELD(Amount);
        end;

        GetCurrency;
        "Bal. VAT Amount" :=
          ROUND("Bal. VAT Amount",Currency."Amount Rounding Precision",Currency.VATRoundingDirection);

        IF "Bal. VAT Amount" * Amount > 0 THEN
          IF "Bal. VAT Amount" > 0 THEN
            ERROR(Text011,FIELDCAPTION("Bal. VAT Amount"))
          else
            ERROR(Text012,FIELDCAPTION("Bal. VAT Amount"));

        "Bal. VAT Base Amount" := -(Amount + "Bal. VAT Amount");
        #25..27
          ROUND(
            -Amount * "Bal. VAT %" / (100 + "Bal. VAT %"),
            Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
        IF ABS("Bal. VAT Difference") > Currency."Max. VAT Difference Allowed" THEN
          ERROR(
            Text013,FIELDCAPTION("Bal. VAT Difference"),Currency."Max. VAT Difference Allowed");

        IF "Currency Code" = '' THEN
          "Bal. VAT Amount (LCY)" := "Bal. VAT Amount"
        else
          "Bal. VAT Amount (LCY)" :=
            ROUND(
              CurrExchRate.ExchangeAmtFCYToLCY(
                "Posting Date","Currency Code",
                "Bal. VAT Amount","Currency Factor"));
        "Bal. VAT Base Amount (LCY)" := -("Amount (LCY)" + "Bal. VAT Amount (LCY)");

        UpdateSalesPurchLCY;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
        GenJnlBatch.TESTFIELD("Allow VAT Difference",true);
        if not ("Bal. VAT Calculation Type" in
                ["Bal. VAT Calculation Type"::"Normal VAT","Bal. VAT Calculation Type"::"Reverse Charge VAT"])
        then
        #6..8
        if "Bal. VAT Amount" <> 0 then begin
          TESTFIELD("Bal. VAT %");
          TESTFIELD(Amount);
        end;
        #13..17
        if "Bal. VAT Amount" * Amount > 0 then
          if "Bal. VAT Amount" > 0 then
            ERROR(Text011,FIELDCAPTION("Bal. VAT Amount"))
          else
        #22..30
        if ABS("Bal. VAT Difference") > Currency."Max. VAT Difference Allowed" then
        #32..34
        if "Currency Code" = '' then
          "Bal. VAT Amount (LCY)" := "Bal. VAT Amount"
        else
        #38..45
        */
        //end;


        //Unsupported feature: CodeModification on ""Bank Payment Type"(Field 70).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Bank Payment Type" <> "Bank Payment Type"::" ") AND
           ("Account Type" <> "Account Type"::"Bank Account") AND
           ("Bal. Account Type" <> "Bal. Account Type"::"Bank Account")
        THEN
          ERROR(
            Text007,
            FIELDCAPTION("Account Type"),FIELDCAPTION("Bal. Account Type"));
        IF ("Account Type" = "Account Type"::"Fixed Asset") AND
           ("Bank Payment Type" <> "Bank Payment Type"::" ")
        THEN
          FIELDERROR("Account Type");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Bank Payment Type" <> "Bank Payment Type"::" ") and
           ("Account Type" <> "Account Type"::"Bank Account") and
           ("Bal. Account Type" <> "Bal. Account Type"::"Bank Account")
        then
        #5..7
        if ("Account Type" = "Account Type"::"Fixed Asset") and
           ("Bank Payment Type" <> "Bank Payment Type"::" ")
        then
          FIELDERROR("Account Type");
        */
        //end;


        //Unsupported feature: CodeModification on ""VAT Base Amount"(Field 71).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetCurrency;
        "VAT Base Amount" := ROUND("VAT Base Amount",Currency."Amount Rounding Precision");
        CASE "VAT Calculation Type" OF
          "VAT Calculation Type"::"Normal VAT",
          "VAT Calculation Type"::"Reverse Charge VAT":
            Amount :=
              ROUND(
                "VAT Base Amount" * (1 + "VAT %" / 100),
                Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
          "VAT Calculation Type"::"Full VAT":
            IF "VAT Base Amount" <> 0 THEN
              FIELDERROR(
                "VAT Base Amount",
                STRSUBSTNO(
                  Text008,FIELDCAPTION("VAT Calculation Type"),
                  "VAT Calculation Type"));
          "VAT Calculation Type"::"Sales Tax":
            IF ("Gen. Posting Type" = "Gen. Posting Type"::Purchase) AND
               "Use Tax"
            THEN BEGIN
              "VAT Amount" := 0;
              "VAT %" := 0;
              Amount := "VAT Base Amount" + "VAT Amount";
            end else BEGIN
              "VAT Amount" :=
                SalesTaxCalculate.CalculateTax(
                  "Tax Area Code","Tax Group Code","Tax Liable","Posting Date",
                  "VAT Base Amount",Quantity,"Currency Factor");
              IF "VAT Base Amount" <> 0 THEN
                "VAT %" := ROUND(100 * "VAT Amount" / "VAT Base Amount",0.00001)
              else
                "VAT %" := 0;
              "VAT Amount" :=
                ROUND("VAT Amount",Currency."Amount Rounding Precision");
              Amount := "VAT Base Amount" + "VAT Amount";
            end;
        end;
        VALIDATE(Amount);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetCurrency;
        "VAT Base Amount" := ROUND("VAT Base Amount",Currency."Amount Rounding Precision");
        case "VAT Calculation Type" of
        #4..10
            if "VAT Base Amount" <> 0 then
        #12..17
            if ("Gen. Posting Type" = "Gen. Posting Type"::Purchase) and
               "Use Tax"
            then begin
        #21..23
            end else begin
        #25..28
              if "VAT Base Amount" <> 0 then
                "VAT %" := ROUND(100 * "VAT Amount" / "VAT Base Amount",0.00001)
              else
        #32..35
            end;
        end;
        VALIDATE(Amount);
        */
        //end;


        //Unsupported feature: CodeModification on ""Bal. VAT Base Amount"(Field 72).OnValidate". Please convert manually.

        //trigger  VAT Base Amount"(Field 72)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetCurrency;
        "Bal. VAT Base Amount" := ROUND("Bal. VAT Base Amount",Currency."Amount Rounding Precision");
        CASE "Bal. VAT Calculation Type" OF
          "Bal. VAT Calculation Type"::"Normal VAT",
          "Bal. VAT Calculation Type"::"Reverse Charge VAT":
            Amount :=
              ROUND(
                -"Bal. VAT Base Amount" * (1 + "Bal. VAT %" / 100),
                Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
          "Bal. VAT Calculation Type"::"Full VAT":
            IF "Bal. VAT Base Amount" <> 0 THEN
              FIELDERROR(
                "Bal. VAT Base Amount",
                STRSUBSTNO(
                  Text008,FIELDCAPTION("Bal. VAT Calculation Type"),
                  "Bal. VAT Calculation Type"));
          "Bal. VAT Calculation Type"::"Sales Tax":
            IF ("Bal. Gen. Posting Type" = "Bal. Gen. Posting Type"::Purchase) AND
               "Bal. Use Tax"
            THEN BEGIN
              "Bal. VAT Amount" := 0;
              "Bal. VAT %" := 0;
              Amount := -"Bal. VAT Base Amount" - "Bal. VAT Amount";
            end else BEGIN
              "Bal. VAT Amount" :=
                SalesTaxCalculate.CalculateTax(
                  "Bal. Tax Area Code","Bal. Tax Group Code","Bal. Tax Liable",
                  "Posting Date","Bal. VAT Base Amount",Quantity,"Currency Factor");
              IF "Bal. VAT Base Amount" <> 0 THEN
                "Bal. VAT %" := ROUND(100 * "Bal. VAT Amount" / "Bal. VAT Base Amount",0.00001)
              else
                "Bal. VAT %" := 0;
              "Bal. VAT Amount" :=
                ROUND("Bal. VAT Amount",Currency."Amount Rounding Precision");
              Amount := -"Bal. VAT Base Amount" - "Bal. VAT Amount";
            end;
        end;
        VALIDATE(Amount);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetCurrency;
        "Bal. VAT Base Amount" := ROUND("Bal. VAT Base Amount",Currency."Amount Rounding Precision");
        case "Bal. VAT Calculation Type" of
        #4..10
            if "Bal. VAT Base Amount" <> 0 then
        #12..17
            if ("Bal. Gen. Posting Type" = "Bal. Gen. Posting Type"::Purchase) and
               "Bal. Use Tax"
            then begin
        #21..23
            end else begin
        #25..28
              if "Bal. VAT Base Amount" <> 0 then
                "Bal. VAT %" := ROUND(100 * "Bal. VAT Amount" / "Bal. VAT Base Amount",0.00001)
              else
        #32..35
            end;
        end;
        VALIDATE(Amount);
        */
        //end;


        //Unsupported feature: CodeModification on ""Document Date"(Field 76).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Payment Terms Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        VALIDATE("Payment Terms Code");
        VALIDATE("Currency Code"); //HEI.31
        */
        //end;


        //Unsupported feature: CodeInsertion on ""External Document No."(Field 77)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        // var
        //     lGenJnlTemplate: Record "Gen. Journal Template";
        //     lGLSetup: Record "General Ledger Setup";
        //     lGenJournalLine: Record "Gen. Journal Line";
        //     lText50000: Label 'External Document No. %1 in already available in Line No. %2 with Template Name %3 & Batch Name %4';
        //     lText50001: Label 'External Document No. %1 is already available in posted entries';
        //     lGLEntry: Record "G/L Entry";
        //begin
        /*
        //HEI.24>>
        if lGenJnlTemplate.GET("Journal Template Name") then;
        lGLSetup.GET;
        if ((lGLSetup."Restrt Duplicate Extrnl Doc" = true) and (lGenJnlTemplate."Restrct Duplicate Extrn Doc" = true)) then
          if ("External Document No." <> '') then
            begin
              lGLEntry.RESET;
              lGLEntry.SETRANGE("Document Type",lGLEntry."Document Type"::Payment);
              lGLEntry.SETRANGE("External Document No.","External Document No.");
              if lGLEntry.FINDFIRST then
                ERROR(lText50001,"External Document No.");

              lGenJournalLine.RESET;
              lGenJournalLine.SETRANGE("Journal Template Name","Journal Template Name");
              lGenJournalLine.SETRANGE("Journal Batch Name","Journal Batch Name");
              lGenJournalLine.SETFILTER("Line No.",'<>%1',"Line No.");
              lGenJournalLine.SETRANGE("External Document No.","External Document No.");
              if lGenJournalLine.FINDFIRST then
                ERROR(lText50000,"External Document No.",lGenJournalLine."Line No.",lGenJournalLine."Journal Template Name",lGenJournalLine."Journal Batch Name");

              lGenJournalLine.RESET;
              lGenJournalLine.SETFILTER("Journal Template Name",'<>%1',"Journal Template Name");
              lGenJournalLine.SETFILTER("Journal Batch Name",'<>%1',"Journal Batch Name");
              lGenJournalLine.SETRANGE("External Document No.","External Document No.");
              if lGenJournalLine.FINDFIRST then
                ERROR(lText50000,"External Document No.",lGenJournalLine."Line No.",lGenJournalLine."Journal Template Name",lGenJournalLine."Journal Batch Name");

              lGenJournalLine.RESET;
              lGenJournalLine.SETRANGE("Journal Template Name","Journal Template Name");
              lGenJournalLine.SETFILTER("Journal Batch Name",'<>%1',"Journal Batch Name");
              lGenJournalLine.SETRANGE("External Document No.","External Document No.");
              if lGenJournalLine.FINDFIRST then
                ERROR(lText50000,"External Document No.",lGenJournalLine."Line No.",lGenJournalLine."Journal Template Name",lGenJournalLine."Journal Batch Name");

              lGenJournalLine.RESET;
              lGenJournalLine.SETFILTER("Journal Template Name",'<>%1',"Journal Template Name");
              lGenJournalLine.SETRANGE("Journal Batch Name","Journal Batch Name");
              lGenJournalLine.SETRANGE("External Document No.","External Document No.");
              if lGenJournalLine.FINDFIRST then
                ERROR(lText50000,"External Document No.",lGenJournalLine."Line No.",lGenJournalLine."Journal Template Name",lGenJournalLine."Journal Batch Name");
            end;
        //HEI.24<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Source Type"(Field 78).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Account Type" <> "Account Type"::"G/L Account") AND ("Account No." <> '') OR
           ("Bal. Account Type" <> "Bal. Account Type"::"G/L Account") AND ("Bal. Account No." <> '')
        THEN
          UpdateSource
        else
          "Source No." := '';
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Account Type" <> "Account Type"::"G/L Account") and ("Account No." <> '') or
           ("Bal. Account Type" <> "Bal. Account Type"::"G/L Account") and ("Bal. Account No." <> '')
        then
          UpdateSource
        else
          "Source No." := '';
        */
        //end;


        //Unsupported feature: CodeModification on ""Source No."(Field 79).OnValidate". Please convert manually.

        //trigger "(Field 79)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Account Type" <> "Account Type"::"G/L Account") AND ("Account No." <> '') OR
           ("Bal. Account Type" <> "Bal. Account Type"::"G/L Account") AND ("Bal. Account No." <> '')
        THEN
          UpdateSource;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Account Type" <> "Account Type"::"G/L Account") and ("Account No." <> '') or
           ("Bal. Account Type" <> "Bal. Account Type"::"G/L Account") and ("Bal. Account No." <> '')
        then
          UpdateSource;
        */
        //end;


        //Unsupported feature: CodeModification on ""Use Tax"(Field 85).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT "Use Tax" THEN
          EXIT;
        TESTFIELD("Gen. Posting Type","Gen. Posting Type"::Purchase);
        VALIDATE("VAT %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not "Use Tax" then
          exit;
        TESTFIELD("Gen. Posting Type","Gen. Posting Type"::Purchase);
        VALIDATE("VAT %");
        */
        //end;


        //Unsupported feature: CodeModification on ""Bal. Use Tax"(Field 89).OnValidate". Please convert manually.

        //trigger  Use Tax"(Field 89)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT "Bal. Use Tax" THEN
          EXIT;
        TESTFIELD("Bal. Gen. Posting Type","Bal. Gen. Posting Type"::Purchase);
        VALIDATE("Bal. VAT %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not "Bal. Use Tax" then
          exit;
        TESTFIELD("Bal. Gen. Posting Type","Bal. Gen. Posting Type"::Purchase);
        VALIDATE("Bal. VAT %");
        */
        //end;


        //Unsupported feature: CodeModification on ""VAT Bus. Posting Group"(Field 90).OnValidate". Please convert manually.

        //trigger  Posting Group"(Field 90)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account"] THEN
          TESTFIELD("VAT Bus. Posting Group",'');

        VALIDATE("VAT Prod. Posting Group");

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine;
          UpdatePricesFromJobJnlLine;
        end
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Account Type" in ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account"] then
        #2..5
        if JobTaskIsSet then begin
          CreateTempJobJnlLine;
          UpdatePricesFromJobJnlLine;
        end
        */
        //end;


        //Unsupported feature: CodeModification on ""VAT Prod. Posting Group"(Field 91).OnValidate". Please convert manually.

        //trigger  Posting Group"(Field 91)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account"] THEN
          TESTFIELD("VAT Prod. Posting Group",'');

        CheckVATInAlloc;

        "VAT %" := 0;
        "VAT Calculation Type" := "VAT Calculation Type"::"Normal VAT";
        IF "Gen. Posting Type" <> 0 THEN BEGIN
          IF NOT VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group") THEN
            VATPostingSetup.INIT;
          "VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
          CASE "VAT Calculation Type" OF
            "VAT Calculation Type"::"Normal VAT":
              "VAT %" := VATPostingSetup."VAT %";
            "VAT Calculation Type"::"Full VAT":
              CASE "Gen. Posting Type" OF
                "Gen. Posting Type"::Sale:
                  BEGIN
                    VATPostingSetup.TESTFIELD("Sales VAT Account");
                    TESTFIELD("Account No.",VATPostingSetup."Sales VAT Account");
                  end;
                "Gen. Posting Type"::Purchase:
                  BEGIN
                    VATPostingSetup.TESTFIELD("Purchase VAT Account");
                    TESTFIELD("Account No.",VATPostingSetup."Purchase VAT Account");
                  end;
              end;
          end;
        end;
        VALIDATE("VAT %");

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine;
          UpdatePricesFromJobJnlLine;
        end
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UpdateVATProdPostGroup; //HEI.19

        if "Account Type" in ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account"] then
        #2..7
        if "Gen. Posting Type" <> 0 then begin
          if not VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group") then
            VATPostingSetup.INIT;
          "VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
          case "VAT Calculation Type" of
        #13..15
              case "Gen. Posting Type" of
                "Gen. Posting Type"::Sale:
                  begin
                    VATPostingSetup.TESTFIELD("Sales VAT Account");
                    TESTFIELD("Account No.",VATPostingSetup."Sales VAT Account");
                  end;
                "Gen. Posting Type"::Purchase:
                  begin
                    VATPostingSetup.TESTFIELD("Purchase VAT Account");
                    TESTFIELD("Account No.",VATPostingSetup."Purchase VAT Account");
                  end;
              end;
          end;
        end;
        VALIDATE("VAT %");

        if JobTaskIsSet then begin
          CreateTempJobJnlLine;
          UpdatePricesFromJobJnlLine;
        end
        */
        //end;


        //Unsupported feature: CodeModification on ""Bal. VAT Bus. Posting Group"(Field 92).OnValidate". Please convert manually.

        //trigger  VAT Bus();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bal. Account Type" IN
           ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Bank Account"]
        THEN
          TESTFIELD("Bal. VAT Bus. Posting Group",'');

        VALIDATE("Bal. VAT Prod. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Bal. Account Type" in
           ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Bank Account"]
        then
        #4..6
        */
        //end;


        //Unsupported feature: CodeModification on ""Bal. VAT Prod. Posting Group"(Field 93).OnValidate". Please convert manually.

        //trigger  VAT Prod();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bal. Account Type" IN
           ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Bank Account"]
        THEN
          TESTFIELD("Bal. VAT Prod. Posting Group",'');

        "Bal. VAT %" := 0;
        "Bal. VAT Calculation Type" := "Bal. VAT Calculation Type"::"Normal VAT";
        IF "Bal. Gen. Posting Type" <> 0 THEN BEGIN
          IF NOT VATPostingSetup.GET("Bal. VAT Bus. Posting Group","Bal. VAT Prod. Posting Group") THEN
            VATPostingSetup.INIT;
          "Bal. VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
          CASE "Bal. VAT Calculation Type" OF
            "Bal. VAT Calculation Type"::"Normal VAT":
              "Bal. VAT %" := VATPostingSetup."VAT %";
            "Bal. VAT Calculation Type"::"Full VAT":
              CASE "Bal. Gen. Posting Type" OF
                "Bal. Gen. Posting Type"::Sale:
                  BEGIN
                    VATPostingSetup.TESTFIELD("Sales VAT Account");
                    TESTFIELD("Bal. Account No.",VATPostingSetup."Sales VAT Account");
                  end;
                "Bal. Gen. Posting Type"::Purchase:
                  BEGIN
                    VATPostingSetup.TESTFIELD("Purchase VAT Account");
                    TESTFIELD("Bal. Account No.",VATPostingSetup."Purchase VAT Account");
                  end;
              end;
          end;
        end;
        VALIDATE("Bal. VAT %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Bal. Account Type" in
           ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Bank Account"]
        then
        #4..7
        if "Bal. Gen. Posting Type" <> 0 then begin
          if not VATPostingSetup.GET("Bal. VAT Bus. Posting Group","Bal. VAT Prod. Posting Group") then
            VATPostingSetup.INIT;
          "Bal. VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
          case "Bal. VAT Calculation Type" of
        #13..15
              case "Bal. Gen. Posting Type" of
                "Bal. Gen. Posting Type"::Sale:
                  begin
                    VATPostingSetup.TESTFIELD("Sales VAT Account");
                    TESTFIELD("Bal. Account No.",VATPostingSetup."Sales VAT Account");
                  end;
                "Bal. Gen. Posting Type"::Purchase:
                  begin
                    VATPostingSetup.TESTFIELD("Purchase VAT Account");
                    TESTFIELD("Bal. Account No.",VATPostingSetup."Purchase VAT Account");
                  end;
              end;
          end;
        end;
        VALIDATE("Bal. VAT %");
        */
        //end;


        //Unsupported feature: CodeModification on ""IC Partner G/L Acc. No."(Field 116).OnValidate". Please convert manually.

        //trigger  No();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Journal Template Name" <> '' THEN
          IF "IC Partner G/L Acc. No." <> '' THEN BEGIN
            GetTemplate;
            GenJnlTemplate.TESTFIELD(Type,GenJnlTemplate.Type::Intercompany);
            IF ICGLAccount.GET("IC Partner G/L Acc. No.") THEN
              ICGLAccount.TESTFIELD(Blocked,FALSE);
          end
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Journal Template Name" <> '' then
          if "IC Partner G/L Acc. No." <> '' then begin
            GetTemplate;
            GenJnlTemplate.TESTFIELD(Type,GenJnlTemplate.Type::Intercompany);
            if ICGLAccount.GET("IC Partner G/L Acc. No.") then
              ICGLAccount.TESTFIELD(Blocked,false);
          end
        */
        //end;


        //Unsupported feature: CodeModification on ""Sell-to/Buy-from No."(Field 118).OnValidate". Please convert manually.

        //trigger "(Field 118)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReadGLSetup;
        IF GLSetup."Bill-to/Sell-to VAT Calc." = GLSetup."Bill-to/Sell-to VAT Calc."::"Sell-to/Buy-from No." THEN
          UpdateCountryCodeAndVATRegNo("Sell-to/Buy-from No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ReadGLSetup;
        if GLSetup."Bill-to/Sell-to VAT Calc." = GLSetup."Bill-to/Sell-to VAT Calc."::"Sell-to/Buy-from No." then
          UpdateCountryCodeAndVATRegNo("Sell-to/Buy-from No.");
        */
        //end;


        //Unsupported feature: CodeModification on ""Incoming Document Entry No."(Field 165).OnValidate". Please convert manually.

        //trigger "(Field 165)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Description = '' THEN
          Description := COPYSTR(IncomingDocument.Description,1,MAXSTRLEN(Description));
        IF "Incoming Document Entry No." = xRec."Incoming Document Entry No." THEN
          EXIT;

        IF "Incoming Document Entry No." = 0 THEN
          IncomingDocument.RemoveReferenceToWorkingDocument(xRec."Incoming Document Entry No.")
        else
          IncomingDocument.SetGenJournalLine(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Description = '' then
          Description := COPYSTR(IncomingDocument.Description,1,MAXSTRLEN(Description));
        if "Incoming Document Entry No." = xRec."Incoming Document Entry No." then
          exit;

        if "Incoming Document Entry No." = 0 then
          IncomingDocument.RemoveReferenceToWorkingDocument(xRec."Incoming Document Entry No.")
        else
          IncomingDocument.SetGenJournalLine(Rec);
        */
        //end;


        //Unsupported feature: CodeModification on ""Payment Reference"(Field 171).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Payment Reference" <> '' THEN
          TESTFIELD("Creditor No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Payment Reference" <> '' then
          TESTFIELD("Creditor No.");
        */
        //end;


        //Unsupported feature: CodeModification on ""Recipient Bank Account"(Field 288).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Recipient Bank Account" = '' THEN
          EXIT;
        IF ("Document Type" = "Document Type"::Invoice) AND
           (("Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor]) OR
            ("Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor]))
        THEN
          "Recipient Bank Account" := '';
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.26>>
        CompanyInfo.GET;
        if CompanyInfo."Enable French Localization" then
          begin
            if "Account Type" = "Account Type"::Customer then
              if CustBankAcc.GET("Account No.","Recipient Bank Account") then
                "Bank Account Name" := CustBankAcc.Name
              else
                "Bank Account Name" := '';
            if "Account Type" = "Account Type"::Vendor then
              if VendBankAcc.GET("Account No.","Recipient Bank Account") then
                "Bank Account Name" := VendBankAcc.Name
              else
                "Bank Account Name" := '';
          end;
        //HEI.26<<

        if "Recipient Bank Account" = '' then
          exit;
        if ("Document Type" = "Document Type"::Invoice) and
           (("Account Type" in ["Account Type"::Customer,"Account Type"::Vendor]) or
            ("Bal. Account Type" in ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor]))
        then
          "Recipient Bank Account" := '';
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Task No."(Field 1001).OnValidate". Please convert manually.

        //trigger "(Field 1001)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Job Task No." <> xRec."Job Task No." THEN
          VALIDATE("Job Planning Line No.",0);
        IF "Job Task No." = '' THEN BEGIN
          "Job Quantity" := 0;
          "Job Currency Factor" := 0;
          "Job Currency Code" := '';
        #7..17
          "Job Line Disc. Amount (LCY)" := 0;
          "Job Unit Cost (LCY)" := 0;
          "Job Total Cost (LCY)" := 0;
          EXIT;
        end;

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine;
          CopyDimensionsFromJobTaskLine;
          UpdatePricesFromJobJnlLine;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Job Task No." <> xRec."Job Task No." then
          VALIDATE("Job Planning Line No.",0);
        if "Job Task No." = '' then begin
        #4..20
          exit;
        end;

        if JobTaskIsSet then begin
        #25..27
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Quantity"(Field 1004).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF JobTaskIsSet THEN BEGIN
          IF "Job Planning Line No." <> 0 THEN
            VALIDATE("Job Planning Line No.");
          CreateTempJobJnlLine;
          UpdatePricesFromJobJnlLine;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if JobTaskIsSet then begin
          if "Job Planning Line No." <> 0 then
        #3..5
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Line Discount %"(Field 1006).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine;
          TempJobJnlLine.VALIDATE("Line Discount %","Job Line Discount %");
          UpdatePricesFromJobJnlLine;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if JobTaskIsSet then begin
        #2..4
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Line Disc. Amount (LCY)"(Field 1007).OnValidate". Please convert manually.

        //trigger  Amount (LCY)"(Field 1007)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine;
          TempJobJnlLine.VALIDATE("Line Discount Amount (LCY)","Job Line Disc. Amount (LCY)");
          UpdatePricesFromJobJnlLine;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if JobTaskIsSet then begin
        #2..4
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Line Type"(Field 1009).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Job Planning Line No." <> 0 THEN
          ERROR(Text019,FIELDCAPTION("Job Line Type"),FIELDCAPTION("Job Planning Line No."));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Job Planning Line No." <> 0 then
          ERROR(Text019,FIELDCAPTION("Job Line Type"),FIELDCAPTION("Job Planning Line No."));
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Unit Price"(Field 1010).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine;
          TempJobJnlLine.VALIDATE("Unit Price","Job Unit Price");
          UpdatePricesFromJobJnlLine;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if JobTaskIsSet then begin
        #2..4
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Line Discount Amount"(Field 1014).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine;
          TempJobJnlLine.VALIDATE("Line Discount Amount","Job Line Discount Amount");
          UpdatePricesFromJobJnlLine;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if JobTaskIsSet then begin
        #2..4
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Line Amount"(Field 1015).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine;
          TempJobJnlLine.VALIDATE("Line Amount","Job Line Amount");
          UpdatePricesFromJobJnlLine;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if JobTaskIsSet then begin
        #2..4
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Line Amount (LCY)"(Field 1017).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine;
          TempJobJnlLine.VALIDATE("Line Amount (LCY)","Job Line Amount (LCY)");
          UpdatePricesFromJobJnlLine;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if JobTaskIsSet then begin
        #2..4
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Currency Code"(Field 1019).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Job Currency Code" <> xRec."Job Currency Code") OR ("Job Currency Code" <> '') THEN
          IF JobTaskIsSet THEN BEGIN
            CreateTempJobJnlLine;
            UpdatePricesFromJobJnlLine;
          end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Job Currency Code" <> xRec."Job Currency Code") or ("Job Currency Code" <> '') then
          if JobTaskIsSet then begin
            CreateTempJobJnlLine;
            UpdatePricesFromJobJnlLine;
          end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Planning Line No."(Field 1020).OnLookup". Please convert manually.

        //trigger "(Field 1020)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        JobPlanningLine.SETRANGE("Job No.","Job No.");
        JobPlanningLine.SETRANGE("Job Task No.","Job Task No.");
        JobPlanningLine.SETRANGE(Type,JobPlanningLine.Type::"G/L Account");
        JobPlanningLine.SETRANGE("No.","Account No.");
        JobPlanningLine.SETRANGE("Usage Link",TRUE);
        JobPlanningLine.SETRANGE("System-Created Entry",FALSE);

        IF PAGE.RUNMODAL(0,JobPlanningLine) = ACTION::LookupOK THEN
          VALIDATE("Job Planning Line No.",JobPlanningLine."Line No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        JobPlanningLine.SETRANGE("Usage Link",true);
        JobPlanningLine.SETRANGE("System-Created Entry",false);

        if PAGE.RUNMODAL(0,JobPlanningLine) = ACTION::LookupOK then
          VALIDATE("Job Planning Line No.",JobPlanningLine."Line No.");
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Planning Line No."(Field 1020).OnValidate". Please convert manually.

        //trigger "(Field 1020)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Job Planning Line No." <> 0 THEN BEGIN
          JobPlanningLine.GET("Job No.","Job Task No.","Job Planning Line No.");
          JobPlanningLine.TESTFIELD("Job No.","Job No.");
          JobPlanningLine.TESTFIELD("Job Task No.","Job Task No.");
          JobPlanningLine.TESTFIELD(Type,JobPlanningLine.Type::"G/L Account");
          JobPlanningLine.TESTFIELD("No.","Account No.");
          JobPlanningLine.TESTFIELD("Usage Link",TRUE);
          JobPlanningLine.TESTFIELD("System-Created Entry",FALSE);
          "Job Line Type" := JobPlanningLine."Line Type" + 1;
          VALIDATE("Job Remaining Qty.",JobPlanningLine."Remaining Qty." - "Job Quantity");
        end else
          VALIDATE("Job Remaining Qty.",0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Job Planning Line No." <> 0 then begin
        #2..6
          JobPlanningLine.TESTFIELD("Usage Link",true);
          JobPlanningLine.TESTFIELD("System-Created Entry",false);
          "Job Line Type" := JobPlanningLine."Line Type" + 1;
          VALIDATE("Job Remaining Qty.",JobPlanningLine."Remaining Qty." - "Job Quantity");
        end else
          VALIDATE("Job Remaining Qty.",0);
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Remaining Qty."(Field 1030).OnValidate". Please convert manually.

        //trigger "(Field 1030)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Job Remaining Qty." <> 0) AND ("Job Planning Line No." = 0) THEN
          ERROR(Text018,FIELDCAPTION("Job Remaining Qty."),FIELDCAPTION("Job Planning Line No."));

        IF "Job Planning Line No." <> 0 THEN BEGIN
          JobPlanningLine.GET("Job No.","Job Task No.","Job Planning Line No.");
          IF JobPlanningLine.Quantity >= 0 THEN BEGIN
            IF "Job Remaining Qty." < 0 THEN
              "Job Remaining Qty." := 0;
          end else BEGIN
            IF "Job Remaining Qty." > 0 THEN
              "Job Remaining Qty." := 0;
          end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Job Remaining Qty." <> 0) and ("Job Planning Line No." = 0) then
          ERROR(Text018,FIELDCAPTION("Job Remaining Qty."),FIELDCAPTION("Job Planning Line No."));

        if "Job Planning Line No." <> 0 then begin
          JobPlanningLine.GET("Job No.","Job Task No.","Job Planning Line No.");
          if JobPlanningLine.Quantity >= 0 then begin
            if "Job Remaining Qty." < 0 then
              "Job Remaining Qty." := 0;
          end else begin
            if "Job Remaining Qty." > 0 then
              "Job Remaining Qty." := 0;
          end;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Direct Debit Mandate ID"(Field 1200).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Direct Debit Mandate ID" = '' THEN
          EXIT;
        TESTFIELD("Account Type","Account Type"::Customer);
        SEPADirectDebitMandate.GET("Direct Debit Mandate ID");
        SEPADirectDebitMandate.TESTFIELD("Customer No.","Account No.");
        "Recipient Bank Account" := SEPADirectDebitMandate."Customer Bank Account Code";
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Direct Debit Mandate ID" = '' then
          exit;
        #3..6
        */
        //end;


        //Unsupported feature: CodeModification on ""Deferral Code"(Field 1700).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Deferral Code" <> '' THEN
          TESTFIELD("Account Type","Account Type"::"G/L Account");

        DeferralUtilities.DeferralCodeOnValidate("Deferral Code",DeferralDocType::"G/L","Journal Template Name","Journal Batch Name",
          0,'',"Line No.",GetDeferralAmount,"Posting Date",Description,"Currency Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Deferral Code" <> '' then
        #2..5
        */
        //end;


        //Unsupported feature: CodeModification on ""Campaign No."(Field 5050).OnValidate". Please convert manually.

        //trigger "(Field 5050)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CreateDim(
          DATABASE::Campaign,"Campaign No.",
          DimMgt.TypeToTableID1("Account Type"),"Account No.",
          DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
          DATABASE::Job,"Job No.",
          DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
          DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
          // <<DITW15.00.00.37 DDR 28/01/2010
          DATABASE::Building,"Building No.",
          // >>DITW15.00.00.37 DDR
          // <<DITW16.00.00.41 AHU 06/08/2012 20/09/2012 DIT-715 #327
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          DimMgt.TypeToTableID2034932(GetSourceType(),"Contract Type"),GetContractNo());
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          // >>DITW16.00.00.41 AHU DIT-715 #327
        */
        //end;


        //Unsupported feature: CodeModification on ""FA Posting Type"(Field 5601).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF  NOT (("Account Type" = "Account Type"::"Fixed Asset") OR
                 ("Bal. Account Type" = "Bal. Account Type"::"Fixed Asset")) AND
           ("FA Posting Type" = "FA Posting Type"::" ")
        THEN BEGIN
          "FA Posting Date" := 0D;
          "Salvage Value" := 0;
          "No. of Depreciation Days" := 0;
          "Depr. until FA Posting Date" := FALSE;
          "Depr. Acquisition Cost" := FALSE;
          "Maintenance Code" := '';
          "Insurance No." := '';
          "Budgeted FA No." := '';
          "Duplicate in Depreciation Book" := '';
          "Use Duplication List" := FALSE;
          "FA Reclassification Entry" := FALSE;
          "FA Error Entry No." := 0;
        end;

        IF "FA Posting Type" <> "FA Posting Type"::"Acquisition Cost" THEN
          TESTFIELD("Insurance No.",'');
        IF "FA Posting Type" <> "FA Posting Type"::Maintenance THEN
          TESTFIELD("Maintenance Code",'');
        GetFAVATSetup;
        GetFAAddCurrExchRate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if  not (("Account Type" = "Account Type"::"Fixed Asset") or
                 ("Bal. Account Type" = "Bal. Account Type"::"Fixed Asset")) and
           ("FA Posting Type" = "FA Posting Type"::" ")
        then begin
        #5..7
          "Depr. until FA Posting Date" := false;
          "Depr. Acquisition Cost" := false;
        #10..13
          "Use Duplication List" := false;
          "FA Reclassification Entry" := false;
          "FA Error Entry No." := 0;
        end;

        if "FA Posting Type" <> "FA Posting Type"::"Acquisition Cost" then
          TESTFIELD("Insurance No.",'');
        if "FA Posting Type" <> "FA Posting Type"::Maintenance then
        #22..24
        GetDerogatorySetup; //HEI.25
        */
        //end;


        //Unsupported feature: CodeModification on ""Depreciation Book Code"(Field 5602).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Depreciation Book Code" = '' THEN
          EXIT;

        IF ("Account No." <> '') AND
           ("Account Type" = "Account Type"::"Fixed Asset")
        THEN BEGIN
          FADeprBook.GET("Account No.","Depreciation Book Code");
          "Posting Group" := FADeprBook."FA Posting Group";
        end;

        IF ("Bal. Account No." <> '') AND
           ("Bal. Account Type" = "Bal. Account Type"::"Fixed Asset")
        THEN BEGIN
          FADeprBook.GET("Bal. Account No.","Depreciation Book Code");
          "Posting Group" := FADeprBook."FA Posting Group";
        end;
        GetFAVATSetup;
        GetFAAddCurrExchRate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetDerogatorySetup; //HEI.25
        if "Depreciation Book Code" = '' then
          exit;

        if ("Account No." <> '') and
           ("Account Type" = "Account Type"::"Fixed Asset")
        then begin
          FADeprBook.GET("Account No.","Depreciation Book Code");
          "Posting Group" := FADeprBook."FA Posting Group";
        end;

        if ("Bal. Account No." <> '') and
           ("Bal. Account Type" = "Bal. Account Type"::"Fixed Asset")
        then begin
          FADeprBook.GET("Bal. Account No.","Depreciation Book Code");
          "Posting Group" := FADeprBook."FA Posting Group";
        end;
        GetFAVATSetup;
        GetFAAddCurrExchRate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Maintenance Code"(Field 5609).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Maintenance Code" <> '' THEN
          TESTFIELD("FA Posting Type","FA Posting Type"::Maintenance);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Maintenance Code" <> '' then
          TESTFIELD("FA Posting Type","FA Posting Type"::Maintenance);
        */
        //end;


        //Unsupported feature: CodeModification on ""Insurance No."(Field 5610).OnValidate". Please convert manually.

        //trigger "(Field 5610)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Insurance No." <> '' THEN
          TESTFIELD("FA Posting Type","FA Posting Type"::"Acquisition Cost");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Insurance No." <> '' then
          TESTFIELD("FA Posting Type","FA Posting Type"::"Acquisition Cost");
        */
        //end;


        //Unsupported feature: CodeModification on ""Budgeted FA No."(Field 5611).OnValidate". Please convert manually.

        //trigger "(Field 5611)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Budgeted FA No." <> '' THEN BEGIN
          FA.GET("Budgeted FA No.");
          FA.TESTFIELD("Budgeted Asset",TRUE);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Budgeted FA No." <> '' then begin
          FA.GET("Budgeted FA No.");
          FA.TESTFIELD("Budgeted Asset",true);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Duplicate in Depreciation Book"(Field 5612).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Use Duplication List" := FALSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        "Use Duplication List" := false;
        */
        //end;
        // field(10801; "Bank Account Name";
        // Text[50])
        // {
        //     CaptionML = ENU = 'Bank Account Name',
        //                 FRA = 'Nom compte bancaire';
        //     Description = 'HEI.26';
        // }
        // field(10810; "Entry Type"; Option)
        // {
        //     CaptionML = ENU = 'Entry Type',
        //                 FRA = 'Type écriture';
        //     Description = 'HEI.26';
        //     OptionCaptionML = ENU = 'Definitive,Simulation',
        //                       FRA = 'Définitive,Simulation';
        //     OptionMembers = Definitive,Simulation;
        // }
        // field(10860; "Entry No."; Integer)
        // {
        //     CaptionML = ENU = 'Entry No.',
        //                 FRA = 'N° séquence';
        //     Description = 'HEI.26';
        //     Editable = false;
        // }
        // field(10861; "Derogatory Line"; Boolean)
        // {
        //     CaptionML = ENU = 'Derogatory Line',
        //                 FRA = 'Ligne dérogatoire';
        //     Description = 'HEI.25';
        //     Editable = false;
        // }
        // field(10862; "Delayed Unrealized VAT"; Boolean)
        // {
        //     CaptionML = ENU = 'Delayed Unrealized VAT',
        //                 FRA = 'TVA sur encaissement différée';
        //     Description = 'HEI.26';
        // }
        // field(10863; "Realize VAT"; Boolean)
        // {
        //     CaptionML = ENU = 'Realize VAT',
        //                 FRA = 'Réaliser TVA';
        //     Description = 'HEI.26';
        // }
        // field(10864; "Created from No."; Code[20])
        // {
        //     CaptionML = ENU = 'Created from No.',
        //                 FRA = 'Créé à partir du n°';
        //     Description = 'HEI.26';
        // }  // BC Upgrade NANDIS03
        field(50000; "CV Detailed Entry No. FND"; Integer)
        {
            caption = 'CV Detailed Entry No.';
            Description = 'HEI.01';
        }
        field(50001; "Vendor Bank Account FND"; Code[10])
        {
            Caption = 'Vendor Bank Account';
            Description = 'HEI.02 PTPGAP066';
            TableRelation = IF ("Account Type" = FILTER(Vendor)) "Vendor Bank Account".Code where("Vendor No." = FIELD("Account No."));
        }
        field(50002; "Adj. Exchange Rate Type FND"; Option)
        {
            caption = 'Adj. Exchange Rate Type ';
            Description = 'HEI.01';
            OptionMembers = " ",Bank,Customer,Vendor;
        }
        field(50003; "Batch payment name FND"; Code[30])
        {
            caption = 'Batch payment name';
            Description = 'HEI.03';
        }
        field(50004; "Tree Level FND"; Integer)
        {
            Caption = 'Tree Level';
            Description = 'HEI.04';
        }
        field(50005; "Archive Document No. FND"; Code[20])
        {
            Caption = 'Archive Document No.';
            Description = 'HEI.04';
        }
        field(50006; "Parent Line No. FND"; Integer)
        {
            Caption = 'Parent Line No.';
            Description = 'HEI.04';
        }
        field(50007; "Bank Branch No. FND"; Text[20])
        {
            Caption = 'Bank Branch No.';
            Description = 'HEI.05';
        }
        field(50008; "Bank Account No. FND"; Text[30])
        {
            Caption = 'Bank Account No.';
            Description = 'HEI.05';
        }
        field(50009; "Customer/Vendor Bank FND"; Code[10])
        {
            Caption = 'Customer/Vendor Bank';
            Description = 'HEI.05';
            TableRelation = IF ("Account Type" = CONST(Customer)) "Customer Bank Account".Code where("Customer No." = FIELD("Account No."))
            else IF ("Account Type" = CONST(Vendor)) "Vendor Bank Account".Code where("Vendor No." = FIELD("Account No."));
        }
        field(50010; "WHT Business Posting Group FND"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            Description = 'HEI.05';
            TableRelation = "WHT Business Posting Group FND".Code;
        }
        field(50011; "WHT Product Posting Group FND"; Code[10])
        {
            Caption = 'WHT Product Posting Group';
            Description = 'HEI.05';
            TableRelation = "WHT Product Posting Group FND".Code;
        }
        field(50012; "WHT Absorb Base FND"; Decimal)
        {
            Caption = 'WHT Absorb Base';
            Description = 'HEI.05';
        }
        field(50013; "WHT Entry No. FND"; Integer)
        {
            caption = 'WHT Entry No.';
            Description = 'HEI.05';
        }
        field(50014; "WHT Report Line No. FND"; Code[10])
        {
            Caption = 'WHT Report Line No.';
            Description = 'HEI.05';
        }
        field(50015; "Skip WHT FND"; Boolean)
        {
            Caption = 'Skip WHT';
            Description = 'HEI.05';
        }
        field(50016; "Certificate Printed FND"; Boolean)
        {
            Caption = 'Certificate Printed';
            Description = 'HEI.05';
        }
        field(50017; "WHT Payment FND"; Boolean)
        {
            Caption = 'WHT Payment';
            Description = 'HEI.05';
        }
        field(50018; "Actual Vendor No. FND"; Code[20])
        {
            Caption = 'Actual Vendor No.';
            Description = 'HEI.05';
        }
        field(50019; "Is WHT FND"; Boolean)
        {
            Caption = 'Is WHT';
            Description = 'HEI.05';
        }
        field(50020; "Purchase Receipt Line No. FND"; Integer)
        {
            Caption = 'Purchase Receipt Line No.';
            Description = 'HEI.06';
        }
        field(50021; "Purchase Receipt Amount FND"; Decimal)
        {
            caption = 'Purchase Receipt Amount';
            Description = 'HEI.06';
        }
        field(50022; "IBAN FND"; Code[50])
        {
            caption = 'IBAN';
            CalcFormula = Lookup("Vendor Bank Account".IBAN where("Vendor No." = FIELD("Account No."),
                                                                   Code = FIELD("Vendor Bank Account FND")));
            Description = 'HEI.01 PTPGAP066';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50023; "Forecast Line FND"; Boolean)
        {
            Caption = 'Forecast Line';
            Description = 'HEI.07';
        }
        field(50024; "Forecast Key FND"; Text[30])
        {
            caption = 'Forecast Key';
            Description = 'HEI.07';
        }
        field(50025; "RPM Original Sales Amount FND"; Decimal)
        {
            Caption = 'RPM Original Sales Amount';
            Description = 'HEI.11';
            Editable = false;
        }
        field(50026; "Prepayment Doc Type FND"; Option)
        {
            caption = 'Prepayment Doc Type';
            OptionMembers = " ","Prepayment Invoice","Prepayment Credit Memo";
        }
        field(50027; "Payment Status FND"; Option)
        {
            caption = 'Payment Status';
            Description = 'HEI.03 PTPGAP041';
            OptionCaption = 'Pending Review,Payment Approved,Payment Rejected';
            OptionMembers = "Pending Review","Payment Approved","Payment Rejected";
        }
        field(50028; "Full WHT FND"; Boolean)
        {
            caption = 'Full WHT';
        }
        field(50029; "Reversed FND"; Boolean)
        {
            Caption = 'Reversed';
            Description = 'HEI.14';
            Editable = false;
        }
        field(50030; "On Hold UserID FND"; Code[50])
        {
            Caption = 'On Hold UserID';
            Description = 'HEI.15';
        }
        field(50031; "On Hold Date FND"; Date)
        {
            Caption = 'On Hold Date';
            Description = 'HEI.15';
        }
        field(50032; "Total No. Of Parent Lines FND"; Integer)
        {
            CalcFormula = Count("Gen. Journal Line" where("Parent Line No. FND" = FILTER(0),
                                                           "Journal Template Name" = FIELD("Journal Template Name"),
                                                           "Journal Batch Name" = FIELD("Journal Batch Name")));
            Caption = 'Total No. Of Parent Lines';
            Description = 'HEI.16';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50033; "Total No. Of Child Lines FND"; Integer)
        {
            CalcFormula = Count("Gen. Journal Line" where("Parent Line No. FND" = FILTER(<> 0),
                                                           "Journal Template Name" = FIELD("Journal Template Name"),
                                                           "Journal Batch Name" = FIELD("Journal Batch Name")));
            Caption = 'Total No. Of Children Lines';
            Description = 'HEI.16';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50034; "Vendor Name FND"; Text[100])
        {
            CalcFormula = Lookup(Vendor.Name where("No." = FIELD("Account No.")));
            Caption = 'Vendor Name';
            Description = 'HEI.16';
            FieldClass = FlowField;
        }
        field(50035; "Vendor Bank Acc. Name FND"; Text[100])
        {
            CalcFormula = Lookup("Vendor Bank Account".Name where(Code = FIELD("Vendor Bank Account FND"),
                                                                   "Vendor No." = FIELD("Account No.")));
            Caption = 'Vendor Bank Acc. Name';
            Description = 'HEI.16';
            FieldClass = FlowField;
        }
        field(50036; "Vendor Bank Acc.BranchNo. FND"; Text[20])
        {
            CalcFormula = Lookup("Vendor Bank Account"."Bank Branch No." where("Vendor No." = FIELD("Account No."),
                                                                                Code = FIELD("Vendor Bank Account FND")));
            Caption = 'Vendor Bank Acc. Branch No.';
            Description = 'HEI.16';
            FieldClass = FlowField;
        }
        field(50037; "Vendor Bank Acc. No. FND"; Text[30])
        {
            CalcFormula = Lookup("Vendor Bank Account"."Bank Account No." where("Vendor No." = FIELD("Account No."),
                                                                                 Code = FIELD("Vendor Bank Account FND")));
            Caption = 'Vendor Bank Acc. No.';
            Description = 'HEI.16';
            FieldClass = FlowField;
        }
        field(50038; "Vandor Bank Acc. SwiftCode FND"; Code[20])
        {
            CalcFormula = Lookup("Vendor Bank Account"."SWIFT Code" where("Vendor No." = FIELD("Account No."),
                                                                           Code = FIELD("Vendor Bank Account FND")));
            Caption = 'Vandor Bank Acc. Swift Code';
            Description = 'HEI.16';
            FieldClass = FlowField;
        }
        field(50039; "Execution Date FND"; Date)
        {
            Caption = 'Execution Date';
            Description = 'HEI.16';
        }
        field(50040; "Real VAT Base FND"; Decimal)
        {
            caption = 'Real VAT Base';
        }
        field(50041; "Real VAT Amount FND"; Decimal)
        {
            caption = 'Real VAT Amount';
        }
        field(50042; "Only VAT FND"; Boolean)
        {
            caption = 'Only VAT';
        }
        field(50043; "HNK Bank Account FND"; Code[20])
        {
            caption = 'HNK Bank Account';
            Description = 'HEI.17';
            TableRelation = "Bank Account";
        }
        field(50044; "HNK Check No. FND"; Code[20])
        {
            caption = 'HNK Check No.';
            Description = 'HEI.17';
        }
        field(50045; "Payment File Created FND"; Boolean)
        {
            caption = 'Payment File Created';
        }
        field(50046; "TIN No. FND"; Text[20])
        {
            CalcFormula = Lookup("VAT Product Posting Group"."TIN No. FND" where(Code = FIELD("VAT Prod. Posting Group")));
            Caption = 'TIN No.';
            Description = 'HEI.18';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50047; "Interface Code FND"; Code[20])
        {
            Caption = 'Interface Code';
            Description = 'HEI.20';
            //TableRelation = "Interface Setup";  // BC Upgrade NANDIS03 - Blocked as "Interface Setup" table moved in Interface Extension 
        }
        field(50048; "CP Vendor Invoice No. FND"; Code[20])
        {
            caption = 'CP Vendor Invoice No.';
            Description = 'HEI.20';
        }
        field(50049; "Instruction Priority FND"; Option)
        {
            Caption = 'Instruction Priority';
            Description = 'HEI.21';
            OptionCaption = 'Normal,High';
            OptionMembers = Normal,High;
        }
        field(50050; "Code Expenses FND"; Option)
        {
            CaptionML = ENU = 'Code Expenses',
                        FRB = 'Code frais',
                        NLB = 'Kostencode';
            Description = 'HEI.21';
            OptionCaptionML = ENU = ' ,SHA,BEN,OUR',
                              FRB = ' ,SHA,BEN,OUR',
                              NLB = ' ,SHA,BEN,OUR';
            OptionMembers = " ",SHA,BEN,OUR;
        }
        field(50051; "Export Protocol Code FND"; Code[20])
        {
            CaptionML = ENU = 'Export Protocol Code',
                        FRB = 'Code du protocole d''exportation',
                        NLB = 'Exportprotocolcode';
            Description = 'HEI.21';
            TableRelation = "Export Protocol FND".Code;

            trigger OnValidate();
            begin
                //HEI.21>>
                GetExportProtocol();
                "Code Expenses FND" := ExportProtocol."Code Expenses";
                //HEI.21<<
            end;
        }
        field(50052; "WS Posting Allowed FND"; Boolean)
        {
            Caption = 'WS Posting Allowed';
            Description = 'HEI.21';
        }
        field(50053; "Empties Item No. FND"; Code[20])
        {
            Caption = 'Empties Item No.';
            Description = 'HEI.22';
            TableRelation = Item where("Item Category Code" = FILTER(05));
        }
        field(50054; "Deposit Quantity FND"; Decimal)
        {
            caption = 'Deposit Quantity';
            DecimalPlaces = 0 : 2;
            Description = 'HEI.22';
        }
        field(50055; "Reference Number FND"; Code[35])
        {
            Caption = 'Reference Number';
            Description = 'HEI.60';
        }
        field(50056; "PO Number FND"; Code[20])
        {
            Caption = 'PO Number';
            Description = 'HEI.23';
        }
        field(50060; "Source System Identifier FND"; Code[10])
        {
            Caption = 'Source System Identifier';
            Description = 'HEI.39';
            Editable = false;
            TableRelation = "Source Sys Identifier API FND";
        }
        field(50061; "Debit Amount (LCY) FND"; Decimal)
        {
            caption = 'Debit Amount (LCY)';
            AutoFormatType = 1;
            Description = 'HEI.27';
            Editable = false;
        }
        field(50062; "Credit Amount (LCY) FND"; Decimal)
        {
            caption = 'Credit Amount (LCY)';
            AutoFormatType = 1;
            Description = 'HEI.27';
            Editable = false;
        }
        field(50063; "Fixed Asset Acquisition FND"; Boolean)
        {
            Caption = 'Fixed Asset Acquisition';
            Description = 'HEI.28';
        }
        field(50064; "G/L Acc. No. 2 FND"; Code[20])
        {
            CaptionML = ENU = 'G/L Acc. No. 2',
                        ESM = 'No. Cuenta 2',
                        ENC = 'G/L Acc. No. 2';
            Description = 'HEI.29';
        }
        field(50066; "WHT Amount FND"; Decimal)
        {
            Caption = 'WHT Amount';
            Description = 'HEI.32';
            Editable = false;
        }
        field(50067; "WHT Amount (LCY) FND"; Decimal)
        {
            Caption = 'WHT Amount (LCY)';
            Description = 'HEi.32';
            Editable = false;
        }
        field(50069; "Check Status FND"; Boolean)
        {
            caption = 'Check Status';
            DataClassification = ToBeClassified;
            Description = 'HEI.38';
        }
        field(50070; "Sales/Archived Order Type FND"; Option)
        {
            Caption = 'Sales/Archived Order Type';
            Description = 'HEI.40';
            OptionMembers = "Sales Order","Archived Sales Order";

            trigger OnValidate();
            begin
                "Related Sales Order FND" := ''; //HEI.40
            end;
        }
        field(50071; "Related Sales Order FND"; Code[20])
        {
            Caption = 'Related Sales Order';
            Description = 'HEI.40';

            trigger OnLookup();
            begin
                RelatedSalesNoLookUp(); //HEI.40
            end;

            trigger OnValidate();
            begin
                RelatedSalesNoValidate(); //HEI.42
            end;
        }
        field(50072; "Auto_Cust FND"; Code[20])
        {
            caption = 'Auto_Cust';
            Description = '//HEI.41';
            TableRelation = "Dimension Value".Code where("Dimension Code" = FILTER('AUTO_CUST'));
        }
        field(50073; "Amount LCY DRC FND"; Decimal)
        {
            Caption = 'Amount LCY DRC';
            Description = 'HEI.45';
        }
        field(50074; "Additional Description FND"; Text[100])
        {
            caption = 'Additional Description';
            DataClassification = ToBeClassified;
            Description = 'HEI.47';
        }
        field(50075; "CAD Amount FND"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'CAD Amount',
                        FRA = 'CAD Montant';
            DataClassification = ToBeClassified;
            Description = 'HEI.51';
            Editable = false;
        }
        field(50077; "Value of Payment Method FND"; Code[10])
        {
            Caption = 'Value of Payment Method';
            DataClassification = ToBeClassified;
        }
        field(50078; "Created By Source Code FND"; Code[10])
        {
            caption = 'Created By Source Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.54';
        }
        field(50079; "Undo FA Receipt FND"; Boolean)
        {
            caption = 'Undo FA Receipt';
            DataClassification = ToBeClassified;
            Description = 'HEI.57';
        }
        field(50080; "H&S Levy Tax % FND"; Decimal)
        {
            caption = 'H&S Levy Tax %';
            DataClassification = ToBeClassified;
            Description = 'HEI.58';
            TableRelation = "H&S Tax Posting Group FND";
        }
        field(50081; "H&S Levy Tax Amount FND"; Decimal)
        {
            caption = 'H&S Levy Tax Amount';
            DataClassification = ToBeClassified;
            Description = 'HEI.58';
        }
        field(50082; "HS Posting Group FND"; Code[10])
        {
            caption = 'HS Posting Group';
            DataClassification = ToBeClassified;
            Description = 'HEI.58';
            TableRelation = "H&S Tax Posting Group FND";
        }
        field(50101; "Rev. Jnl. Error Log FND"; Boolean)
        {
            Caption = 'Rev. Jnl. Error Log';
            Description = 'HEI.56';
        }
        field(50102; "Item Journal Template Name FND"; Code[10])
        {
            Caption = 'Item Journal Template Name';
            Description = 'HEI.56';
        }
        field(50103; "Item Journal Batch Name FND"; Code[10])
        {
            Caption = 'Item Journal Batch Name';
            Description = 'HEI.56';
        }
        field(50104; "Item Journal Line No. FND"; Integer)
        {
            Caption = 'Item Journal Line No.';
            Description = 'HEI.56';
        }
        field(55000; "Transaction Code FND"; Code[20])
        {
            caption = 'Transaction Code';
            Description = 'HEI.30';
            TableRelation = "Transaction Codes FND";
        }
        field(55001; "Free Goods Accounting FND"; Boolean)
        {
            caption = 'Free Goods Accounting';
            DataClassification = ToBeClassified;
            Description = 'HEI.44';
        }
        field(55002; "Maison des Vins Value Code FND"; Code[20])
        {
            //CaptionClass = GetDimCaptionClass(1);  // BC Upgrade NANDIS03 - Caption Class function needs to be updated
            caption = 'Maison des Vins Value Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.48';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(15), Blocked = CONST(false));

            trigger OnValidate();
            var
                DimSetEntry: Record "Dimension Set Entry";
                TempDimSetEntry: Record "Dimension Set Entry" temporary;
                GLSetup: Record "General Ledger Setup";  // BC Upgrade NANDIS03
                DimensionManagement: Codeunit DimensionManagement;
            begin
                //HEI.48<<
                GLSetup.GET();

                DimSetEntry.RESET();
                DimSetEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");
                if DimSetEntry.findset() then
                    repeat
                        TempDimSetEntry.INIT();
                        TempDimSetEntry.TRANSFERFIELDS(DimSetEntry);
                        TempDimSetEntry."Dimension Set ID" := 0;
                        TempDimSetEntry.INSERT();
                    until DimSetEntry.NEXT() = 0;

                TempDimSetEntry.RESET();
                if not TempDimSetEntry.GET(0, GLSetup."Maison des Vins Dim. Code FND") then begin
                    TempDimSetEntry.VALIDATE("Dimension Code", GLSetup."Maison des Vins Dim. Code FND");
                    TempDimSetEntry.VALIDATE("Dimension Value Code", "Maison des Vins Value Code FND");
                    TempDimSetEntry.INSERT();
                end else begin
                    TempDimSetEntry.VALIDATE("Dimension Value Code", "Maison des Vins Value Code FND");
                    TempDimSetEntry.MODIFY();
                end;

                TempDimSetEntry.RESET();
                if TempDimSetEntry.FINDFIRST() then
                    "Dimension Set ID" := DimensionManagement.GetDimensionSetID(TempDimSetEntry);
                //HEI.48>>
            end;
        }
        // BC UPgrade SHARMP16 CU 90
        field(55003; "BCGenJnlPosting FND"; Boolean)
        {
            caption = 'BCGenJnlPosting';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(55004; "BCDuplicateInGenJnl FND"; Boolean)
        {
            caption = 'BCDuplicateInGenJnl';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(55005; "FA Receipt Line No. FND"; Integer)
        {
            caption = 'FA Receipt Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        // BC UPgrade SHARMP16 CU 90
        // field(2013610;"Cust/Vendor Deposit Group Code";Code[10])
        // {
        //     CaptionML = ENU='Cust/Vend DepositChrg.Gr. Code',
        //                 FRA='Code groupe coût consigne Client/Fourn.';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Deposit Group".Code WHERE ("Source Type"=FIELD("Source Type"));
        // }
        // field(2013611;"Deposit Amount";Decimal)
        // {
        //     AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 1;
        //     CaptionML = ENU='Deposit Amount',
        //                 FRA='Montant consigne';
        //     Description = 'DITW16.00.00.43 DIT-715 #678';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.43 DDR 14/08/2013 DIT-715 #678
        //         GetCurrency;
        //         if "Currency Code" = '' then
        //           "Deposit Amount (LCY)" := "Deposit Amount"
        //         else
        //           "Deposit Amount (LCY)" := ROUND(
        //             CurrExchRate.ExchangeAmtFCYToLCY(
        //               "Posting Date","Currency Code",
        //               "Deposit Amount","Currency Factor"));

        //         "Deposit Amount" := ROUND("Deposit Amount",Currency."Amount Rounding Precision");

        //         if ((Rec."Deposit Amount" <> xRec."Deposit Amount"))  then begin
        //           if ("Applies-to Doc. No." <> '') or ("Applies-to ID" <> '') then
        //             SetApplyToAmount;
        //           PaymentToleranceMgt.PmtTolGenJnl(Rec);
        //         end;
        //     end;
        // }
        // field(2013612;"Deposit Amount (LCY)";Decimal)
        // {
        //     AutoFormatType = 1;
        //     CaptionML = ENU='Deposit Amount (LCY)',
        //                 FRA='Montant de la caution DS';
        //     Description = 'DITW16.00.00.43 DIT-715 #678';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.43 DDR 14/08/2013 DIT-715 #678
        //         if "Currency Code" = '' then begin
        //           "Deposit Amount" := "Deposit Amount (LCY)";
        //           VALIDATE("Deposit Amount");
        //         end else begin
        //           if CheckFixedCurrency then begin
        //             GetCurrency;
        //             "Deposit Amount" := ROUND(
        //               CurrExchRate.ExchangeAmtLCYToFCY(
        //                 "Posting Date","Currency Code",
        //                 "Deposit Amount (LCY)","Currency Factor"),
        //                 Currency."Amount Rounding Precision")
        //           end else begin
        //             TESTFIELD("Deposit Amount (LCY)");
        //             TESTFIELD("Deposit Amount");
        //             "Currency Factor" := "Deposit Amount" / "Deposit Amount (LCY)";
        //           end;
        //         end;
        //     end;
        // }
        // field(2013667;"Cust/Vendor DTax Group Code";Code[20])
        // {
        //     CaptionML = ENU='Cust/Vendor Tax Group Code',
        //                 FRA='Code groupe taxe Client/Fourn.';
        //     Description = 'DITW15.00.00.01,HEI.08';
        //     TableRelation = "Drink Tax Group".Code WHERE ("Source Type"=FIELD("Source Type"));
        // }
        // field(2013695;"Item Charge Type";Option)
        // {
        //     CaptionML = ENU='Item Charge Type',
        //                 FRA='Type frais annexes';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     OptionCaptionML = ENU=' ,,Deposit',
        //                       FRA=' ,,Consigne';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        // }
        // field(2013726;"Cust/Vend Tax Registration No.";Text[20])
        // {
        //     CaptionML = ENU='Cust/Vendor Tax Registration No.',
        //                 FRA='N° ident. accise Client/Fourn.';
        //     Description = 'DITW15.00.00.38 #1221';
        // }
        // field(2013783;"Applies-to D/P Line No.";Integer)
        // {
        //     CaptionML = ENU='Applies-to D/P Line No.',
        //                 FRA='N° ligne lettrage C/P';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Sales Disc. & Promo. Worksheet"."Line No." WHERE ("Entry Type"=FIELD("Applies-to D/P Line Type"));
        // }
        // field(2013784;"Applies-to D/P Line Type";Option)
        // {
        //     CaptionML = ENU='Applies-to D/P Line Type',
        //                 FRA='Type ligne lettrage C/P';
        //     Description = 'DITW15.00.00.01';
        //     OptionCaptionML = ENU=' ,Discount,Promotion',
        //                       FRA=' ,Remise,Promotion';
        //     OptionMembers = " ",Discount,Promotion;
        //     TableRelation = "Sales Disc. & Promo. Worksheet"."Entry Type";
        // }
        // field(2013822;"Applies-to D/P Source Table";Option)
        // {
        //     CaptionML = ENU='Applies-to D/P Source Table',
        //                 FRA='Table source lettrage C/P';
        //     Description = 'DITW15.00.00.34';
        //     OptionCaptionML = ENU=' ,Sales,Purchase',
        //                       FRA=' ,Vente,Achat';
        //     OptionMembers = " ",Sales,Purchase;
        // }
        // field(2013969;"Pos System-Created Entry";Boolean)
        // {
        //     CaptionML = ENU='POS System-Created Entry',
        //                 FRA='Ecriture système POS';
        //     Description = 'DITW15.00.00.39 #1328';
        //     Editable = false;
        // }
        // field(2014077;"Truck Code";Code[10])
        // {
        //     CaptionML = ENU='Truck Code',
        //                 FRA='Code camion';
        //     Description = 'DITW15.00.00.25';
        //     TableRelation = "Whse. Shipping Truck";
        // }
        // field(2014078;"Driver Code";Code[10])
        // {
        //     CaptionML = ENU='Driver Code',
        //                 FRA='Code chauffeur';
        //     Description = 'DITW15.00.00.25';
        //     TableRelation = "Whse. Shipping Driver";
        // }
        // field(2014109;"Route Planning No.";Code[20])
        // {
        //     Caption = 'Route Planning No.';
        //     Description = 'NRQ17902';
        //     TableRelation = "Route Planning Worksheet";
        // }
        // field(2014271;"Cust/Vend Tax Warehouse Ref.";Text[20])
        // {
        //     CaptionML = ENU='Cust/Vendor Tax Warehouse Reference',
        //                 FRA='Entrepôt fiscal de référence Client/Fourn.';
        //     Description = 'DITW15.00.00.38 #1221';
        // }
        // field(2014310;"Service Contract Line No.";Integer)
        // {
        //     CaptionML = ENU='Contract Line No.',
        //                 FRA='N° ligne contrat';
        //     Description = 'DIT-715 #392';
        // }
        // field(2014312;"DIT Sub-Contr.Pst. Type Filter";Option)
        // {
        //     CaptionML = ENU='Financial Contract Posting Type Filter',
        //                 FRA='Filtre Type Imputation contrat DIT';
        //     Description = 'DITW16.00.00.41 DIT-715 #327';
        //     FieldClass = FlowFilter;
        //     OptionCaptionML = ENU=' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance,,,,,All',
        //                       FRA=' ,Location,Prêt,Mise à disposition,Maintenance,Divers,Maintenance Usine,,,,,Tous';
        //     OptionMembers = " ",Rent,Loan,"Loan in use",Maintenance,Other,PlantMaintenance,,,,,All;
        // }
        // field(2014313;"DIT Sub-Contract Type Filter";Option)
        // {
        //     CaptionML = ENU='DIT Sub-Contract Type Filter',
        //                 FRA='Filtre type sous-contrat DIT';
        //     Description = 'DITW16.00.00.43 DIT-715 #641';
        //     FieldClass = FlowFilter;
        //     OptionCaptionML = ENU=' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance,,,,,All',
        //                       FRA=' ,Location,Prêt,Mise à disposition,Maintenance,Divers,Maintenance Usine,,,,,Tous';
        //     OptionMembers = " ",Rent,Loan,"Loan in use",Maintenance,Other,PlantMaintenance,,,,,All;
        // }
        // field(2014314;"Source Type Filter";Option)
        // {
        //     CaptionML = ENU='Source Type Filter',
        //                 FRA='Filtre type origine';
        //     Description = 'DITW16.00.00.43 DIT-715 #641';
        //     FieldClass = FlowFilter;
        //     OptionCaptionML = ENU=' ,Customer,Vendor,Bank Account,Fixed Asset',
        //                       FRA=' ,Client,Fournisseur,Banque,Immobilisation';
        //     OptionMembers = " ",Customer,Vendor,"Bank Account","Fixed Asset";
        // }
        // field(2014315;"Source No. Filter";Code[20])
        // {
        //     CaptionML = ENU='Source No. Filter',
        //                 FRA='Filtre n° origine';
        //     Description = 'DITW16.00.00.43 DIT-715 #641';
        //     FieldClass = FlowFilter;
        //     TableRelation = IF ("Source Type"=CONST(Customer)) Customer
        //                     else IF ("Source Type"=CONST(Vendor)) Vendor
        //                     else IF ("Source Type"=CONST("Bank Account")) "Bank Account"
        //                     else IF ("Source Type"=CONST("Fixed Asset")) "Fixed Asset";
        //     ValidateTableRelation = false;
        // }
        // field(2014316;"Payment Type";Option)
        // {
        //     CaptionML = ENU='Payment Type',
        //                 FRA='Type de règlement';
        //     OptionCaptionML = ENU=' ,collection,,,direct debiting',
        //                       FRA=' ,collecte,,,débit direct';
        //     OptionMembers = " ",collection,,,"direct debiting";
        // }
        // field(2014317;"Create from Financial Contract";Boolean)
        // {
        //     CaptionML = ENU='Create from Financial Contract',
        //                 FRA='Créé à partir du contrat financier';
        //     Description = 'DITW17.10.05 - DIT-770 #756';
        // }
        // field(2014318;"Contract Posting Date";Date)
        // {
        //     CaptionML = ENU='Contract Posting Date',
        //                 FRA='Date comptabilisation du contrat';
        //     Description = 'DITW17.10.05 - DIT-770 #756';
        // }
        // field(2014319;"Financial Contract No.";Code[20])
        // {
        //     CaptionML = ENU='Financial Contract No.',
        //                 FRA='N° Contrat Financier';
        //     Description = 'DITW18.00.06 DIT-770 #1368';
        //     TableRelation = IF ("DIT Sub-Contract Type"=CONST(" ")) "Financial Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract))
        //                     else IF ("DIT Sub-Contract Type"=FILTER(<>" ")) "Financial Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract),
        //                                                                                                                       "DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));

        //     trigger OnValidate();
        //     var
        //         FA2 : Record "Fixed Asset";
        //     begin
        //         //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //         if "Financial Contract No." <> '' then begin
        //           //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           "Contract Type" := "Contract Type"::Financial;
        //           TESTFIELD("Service Contract No.",'');
        //           //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           if (CurrFieldNo = FIELDNO("Financial Contract No.")) and
        //             (xRec."Financial Contract No." <> "Financial Contract No.")
        //           then begin
        //             "Service Contract Line No." := 0;
        //             "Contract Group Code" := '';
        //             "Building No." := '';
        //           end;
        //           if "Account Type" = "Account Type"::"Fixed Asset" then begin
        //             TESTFIELD("Account No.");
        //             FA2.GET("Account No.");
        //           end else
        //             if "Bal. Account Type" = "Bal. Account Type"::"Fixed Asset" then begin
        //               TESTFIELD("Bal. Account No.");
        //               FA2.GET("Bal. Account No.");
        //             end;
        //           if FA2."Financial Contract No." <> '' then
        //             TESTFIELD("Financial Contract No.",FA2."Financial Contract No.");

        //           ContractDIT.GET(ContractDIT."Contract Type"::Contract,"Financial Contract No.");
        //           //<< DITW18.00.07 AKH 07/01/2016 DIT-770 #1473
        //           VALIDATE("Payment Terms Code", ContractDIT."Payment Terms Code");
        //           VALIDATE("Payment Method Code",ContractDIT."Payment Method Code");
        //           //>> DITW18.00.07 AKH DIT-770 #1473
        //           if ("DIT Sub-Contract Type" <> 0) or
        //             ((xRec."DIT Sub-Contract Type" <> 0) and ("DIT Sub-Contract Type" = 0) and
        //             (xRec."Financial Contract No." = "Financial Contract No."))
        //           then
        //             TESTFIELD("DIT Sub-Contract Type",ContractDIT."DIT Sub-Contract Type")
        //           else
        //             "DIT Sub-Contract Type" := ContractDIT."DIT Sub-Contract Type";
        //           if ("Contract Group Code" <> '') or
        //             ((xRec."Contract Group Code" <> '') and ("Contract Group Code" = '') and
        //             (xRec."Financial Contract No." = "Financial Contract No."))
        //           then
        //             TESTFIELD("Contract Group Code",ContractDIT."Contract Group Code")
        //           else
        //             "Contract Group Code" := ContractDIT."Contract Group Code";
        //           "Building No." := ContractDIT."Building No.";
        //         end else begin
        //           //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           "Contract Type" := "Contract Type"::" ";
        //           "Contract Group Code" := '';
        //           //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           "Service Contract Line No." := 0;
        //         end;

        //         if (CurrFieldNo = FIELDNO("Financial Contract No.")) and
        //           (("Applies-to Doc. No." <> '') or ("Applies-to ID" <> ''))
        //         then
        //           ValidateApplyRequirements(Rec);

        //         CreateDim(
        //           DimMgt.TypeToTableID2034932(GetSourceType(),"Contract Type"),"Financial Contract No.",
        //           DimMgt.TypeToTableID1("Account Type"),"Account No.",
        //           DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
        //           DATABASE::Job,"Job No.",
        //           DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
        //           DATABASE::Campaign,"Campaign No.",
        //           DATABASE::Building,"Building No.");

        //         SetFilterSubContractPostType;
        //         if CurrFieldNo = FIELDNO("Financial Contract No.") then
        //           VALIDATE("DIT Sub-Contract Type");
        //     end;
        // }
        field(50090; "Document Subtype Code FND"; Code[10])
        {
            Caption = 'Document Subtype Code';
            Description = 'NRQ17902';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales | "Fin.Contract"));
        }
        //BC UPGRADE KUMARR78 >> Field Adding for (Truck/Vehicle) Code
        field(50091; "Vehicle Code HNK FND"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vehicle Code';
            //TableRelation = Vehicle101FDW;
        }
        //BC UPGRADE KUMARR78 << Field Adding for Truck/Vehicle Code
        //BC UPGRADE KUMARR78 >> Field Adding for (Driver) Code
        field(50092; "Driver Code HNK FND"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Driver';
            //TableRelation = Vehicle101FDW;
        }
        //BC UPGRADE KUMARR78 << Field Adding for (Driver) Code

        // field(2014497;"Invoice List Document No.";Code[20])
        // {
        //     CaptionML = ENU='Invoice List Document No.',
        //                 FRA='N° document liste facture';
        //     Description = 'DITW18.10.07 DIT-770 #1723';
        //     Editable = false;
        //     TableRelation = "Invoice List";
        // }
        // field(2029610;OGM;Text[30])
        // {
        //     CaptionML = ENU='OGM',
        //                 FRA='OGM';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2029611;"Auto. Acc. Group";Code[10])
        // {
        //     CaptionML = ENU='Auto. Acc. Group',
        //                 FRA='Groupe compte autom.';
        //     Description = 'FINXL7.00';
        //     TableRelation = "Automatic Acc. Header";

        //     trigger OnValidate();
        //     var
        //         lrecGeneralLedgerSetup : Record "General Ledger Setup";
        //     begin
        //         if recFinXLSetup.READPERMISSION then TESTFIELD("Account Type","Account Type"::"G/L Account");  //FINXL7.00.001 RBE 06/08/2013
        //         //<<FINXL8.00.001 BSA 25/05/2015 #174
        //         if recFinXLSetup.READPERMISSION then begin
        //           lrecGeneralLedgerSetup.GET;
        //           lrecGeneralLedgerSetup.TESTFIELD("Jnl. Template Name (Aut. Acc.)");
        //           lrecGeneralLedgerSetup.TESTFIELD("Jnl. Batch Name (Aut. Acc.)");
        //         end;
        //         //>>FINXL8.00.001 BSA 25/05/2015 #174
        //     end;
        // }
        // field(2034840;"Building No.";Code[20])
        // {
        //     CaptionML = ENU='Building No.',
        //                 FRA='N° immeuble';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = Building;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 28/01/2010
        //         if "Building No." <> '' then begin
        //           Building.GET("Building No.");
        //           Building.TESTFIELD(Blocked,false);
        //         end else begin
        //           // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327 - DITW17.00.01 DDR 13/02/2013 DIT-770 #001
        //           "Shortcut Dimension 1 Code" := '';
        //           "Shortcut Dimension 2 Code" := '';
        //           // >>DITW16.00.00.41 AHU DIT-715 #327 - DITW17.00.01 DDR DIT-770 #001
        //         end;

        //         // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
        //         if "Service Contract No." <> '' then
        //           VALIDATE("Service Contract No.");
        //         // >>DITW16.00.00.41 AHU DIT-715 #327
        //         //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //         if "Financial Contract No." <> '' then
        //           VALIDATE("Financial Contract No.");
        //         //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //         // <<DITW16.00.00.43 DDR 02/05/2013 DIT-715 #575
        //         if (CurrFieldNo <> 0) and (("Applies-to Doc. No." <> '') or ("Applies-to ID" <> '')) then
        //           ValidateApplyRequirements(Rec);
        //         // >>DITW16.00.00.43 DDR DIT-715 #575

        //         CreateDim(
        //           DATABASE::Building,"Building No.",
        //           DimMgt.TypeToTableID1("Account Type"),"Account No.",
        //           DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
        //           DATABASE::Job,"Job No.",
        //           DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
        //           DATABASE::Campaign,"Campaign No.",
        //           // <<DITW16.00.00.41 AHU 06/08/2012 20/09/2012 DIT-715 #327
        //           //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //           DimMgt.TypeToTableID2034932(GetSourceType(),"Contract Type"),GetContractNo());
        //           //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //           // >>DITW16.00.00.41 AHU DIT-715 #327
        //     end;
        // }
        // field(2034850;"DIT Sub-Contract Type";Option)
        // {
        //     CaptionML = ENU='Sub Contract Type',
        //                 FRA='Sous type contrat';
        //     Description = 'DITW15.00.00.35- DIT-715 #297';
        //     OptionCaptionML = ENU=' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA=' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,"Loan in use",Maintenance,Other,PlantMaintenance;

        //     trigger OnValidate();
        //     var
        //         TempGenJnlLine : Record "Gen. Journal Line";
        //         GLAcc : Record "G/L Account";
        //         Cust : Record Customer;
        //         Vend : Record Vendor;
        //         FA : Record "Fixed Asset";
        //     begin
        //         // <<DITW15.00.00.37 DDR 10/05/2010 - 01/06/2010
        //         if (xRec."DIT Sub-Contract Type" <> "DIT Sub-Contract Type") and
        //           (CurrFieldNo = FIELDNO("DIT Sub-Contract Type"))
        //         then begin
        //           // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327 - DITW16.00.00.43 DDR 02/05/2013 DIT-715 #575
        //           //<<DITW17.00.02 SR 19/12/2013 DIT-770 #163
        //           //<<DITW17.10.03 MSF 17/03/2014 DIT-715 #340
        //           if "Applies-to Doc. No." <> '' then
        //             ERROR(Text2034841,FIELDCAPTION("DIT Sub-Contract Type"),FIELDCAPTION("Applies-to Doc. No."));
        //           //>>DITW17.10.03 MSF 17/03/2014 DIT-715 #340
        //           //>>DITW17.00.02 SR DIT-770 #163
        //           // >>DITW16.00.00.41 AHU DIT-715 #327 - DITW16.00.00.43 DDR DIT-715 #575
        //           // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
        //           if "Account No." <> '' then
        //             case "Account Type" of
        //               "Account Type"::"G/L Account":
        //                 begin
        //                   GLAcc.GET("Account No.");
        //                   if not (GLAcc."DIT Sub-Contract Posting Type" in
        //                     [GLAcc."DIT Sub-Contract Posting Type"::" ",
        //                      GLAcc."DIT Sub-Contract Posting Type"::All])
        //                   then
        //                     VALIDATE("Account No.",'');
        //                 end;
        //               "Account Type"::"Fixed Asset":
        //                 begin
        //                   FA.GET("Account No.");
        //                 end;
        //             end;
        //           // >>DITW16.00.00.41 AHU DIT-715 #327
        //           //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           if "Service Contract No." <> '' then begin
        //             ServContract.GET(ServContract."Contract Type"::Contract,"Service Contract No.");
        //             TESTFIELD("DIT Sub-Contract Type",ServContract."DIT Sub-Contract Type");
        //           end;
        //           if "Financial Contract No." <> '' then begin
        //             ContractDIT.GET(ContractDIT."Contract Type"::Contract,"Financial Contract No.");
        //             TESTFIELD("DIT Sub-Contract Type",ContractDIT."DIT Sub-Contract Type");
        //           end;
        //           //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //         end;
        //         // >>DITW15.00.00.37 DDR

        //         // <<DITW16.00.00.43 DDR 02/05/2013 DIT-715 #575
        //         if (CurrFieldNo = FIELDNO("DIT Sub-Contract Type")) and
        //           (("Applies-to Doc. No." <> '') or ("Applies-to ID" <> ''))
        //         then
        //           ValidateApplyRequirements(Rec);
        //         // >>DITW16.00.00.43 DDR DIT-715 #575

        //         // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
        //         SetFilterSubContractPostType;
        //         // >>DITW16.00.00.41 AHU DIT-715 #327

        //         // <<DITW16.00.00.42 DDR 28/02/2013 DIT-715 #567
        //         TempGenJnlLine := Rec;
        //         if (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Customer) or
        //           (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Vendor)
        //         then
        //           CODEUNIT.RUN(CODEUNIT::"Exchange Acc. G/L Journal Line",TempGenJnlLine);

        //         case TempGenJnlLine."Account Type" of
        //           TempGenJnlLine."Account Type"::Customer:
        //             begin
        //               "Posting Group" := '';
        //               Cust.GET(TempGenJnlLine."Account No.");
        //              //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //               if (GetContractNo() <> '') or ("Contract Group Code" <> '') or
        //              //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //                 ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ")
        //               then
        //                 "Posting Group" := ServPostJnl.GetSourcePostGroupService(Cust."No.","DIT Sub-Contract Type");
        //               if "Posting Group" = '' then begin
        //                 Cust.TESTFIELD("Customer Posting Group");
        //                 "Posting Group" := Cust."Customer Posting Group";
        //               end;
        //             end;
        //           TempGenJnlLine."Account Type"::Vendor:
        //             begin
        //               "Posting Group" := '';
        //               Vend.GET(TempGenJnlLine."Account No.");
        //              //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //               if (GetContractNo() <> '') or ("Contract Group Code" <> '') or
        //              //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //                 ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ")
        //               then
        //                 "Posting Group" := ServPurchPostJnl.GetSourcePostGroupService(Vend."No.","DIT Sub-Contract Type");
        //               if "Posting Group" = '' then begin
        //                 Vend.TESTFIELD("Vendor Posting Group");
        //                 "Posting Group" := Vend."Vendor Posting Group";
        //               end;
        //             end;
        //         end;
        //         // >>DITW16.00.00.42 DDR DIT-715 #567
        //     end;
        // }
        // field(2034872;"Contract Group Code";Code[10])
        // {
        //     CaptionML = ENU='Contract Group Code',
        //                 FRA='Code groupe contrat';
        //     Description = 'DITW15.00.00.35-.37';
        //     TableRelation = IF ("Contract Type"=CONST(Service),
        //                         "DIT Sub-Contract Type"=FILTER(<>" ")) "Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"))
        //                         else IF ("Contract Type"=CONST(Service),
        //                                  "DIT Sub-Contract Type"=CONST(" ")) "Contract Group".Code
        //                                  else IF ("Contract Type"=CONST(Financial),
        //                                           "DIT Sub-Contract Type"=FILTER(<>" ")) "Financial Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"))
        //                                           else IF ("Contract Type"=CONST(Financial),
        //                                                    "DIT Sub-Contract Type"=CONST(" ")) "Financial Contract Group".Code;

        //     trigger OnValidate();
        //     var
        //         GLAcc : Record "G/L Account";
        //         Cust : Record Customer;
        //         Vend : Record Vendor;
        //         FA : Record "Fixed Asset";
        //     begin
        //         // <<DITW15.00.00.35 DDR 28/08/2009 - 22/09/2009 - DITW15.00.00.37 DDR 10/05/2010 - 21/05/2010
        //         if "Contract Group Code" <> '' then begin
        //             // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
        //             case "Contract Type" of
        //               "Contract Type"::Service:
        //                 begin
        //                  if ContractGroup.Code <> "Contract Group Code" then
        //                    ContractGroup.GET("Contract Group Code");
        //                  "DIT Sub-Contract Type" := ContractGroup."DIT Sub-Contract Type";
        //                 end;
        //               "Contract Type"::Financial:
        //                 begin
        //                  if ContractGroupDIT.Code <> "Contract Group Code" then
        //                    ContractGroupDIT.GET("Contract Group Code");
        //                  "DIT Sub-Contract Type" := ContractGroupDIT."DIT Sub-Contract Type";
        //                 end;
        //             end;
        //             // >>DITW16.00.00.41 AHU DIT-715 #327
        //         end else begin
        //           CLEAR(ContractGroup);
        //           // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
        //           CLEAR(ContractGroupDIT);
        //           // >>DITW16.00.00.41 AHU DIT-715 #327
        //         end;

        //         // <<DITW16.00.00.43 DDR 02/05/2013 DIT-715 #575
        //         if (CurrFieldNo = FIELDNO("Contract Group Code")) and
        //           (("Applies-to Doc. No." <> '') or ("Applies-to ID" <> ''))
        //         then begin
        //           ValidateApplyRequirements(Rec);
        //           if "Service Contract No." <> '' then
        //             VALIDATE("Service Contract No.");
        //            //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //            if "Financial Contract No." <> '' then
        //             VALIDATE("Financial Contract No.");
        //             //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //         end;
        //         // >>DITW16.00.00.43 DDR DIT-715 #575
        //         case true of
        //           ("Account Type" = "Account Type"::Customer),
        //           ("Bal. Account Type" = "Bal. Account Type"::Customer):
        //             begin
        //               CLEAR(Cust);
        //               if "Account Type" = "Account Type"::Customer then
        //                 Cust.GET("Account No.")
        //               else
        //                 if "Bal. Account Type" = "Bal. Account Type"::Customer then
        //                   Cust.GET("Bal. Account No.");

        //               // <<DITW16.00.00.43 DDR 02/05/2013 DIT-715 #575
        //               if DITServMgtSetup.READPERMISSION then begin
        //                 DITServMgtSetup.GET;
        //                 if DITServMgtSetup."Contract Group Mandatory" and
        //                   (("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ") or
        //                   //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //                   (GetContractNo() <> '') or ("Building No." <> ''))
        //                    //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //                 then
        //                   TESTFIELD("Contract Group Code");
        //               end;
        //               // >>DITW16.00.00.43 DDR DIT-715 #575

        //               if Cust."No." <> '' then begin
        //                 "Posting Group" := '';
        //                 // <<DITW15.00.00.37 DDR 01/06/2010
        //                 //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //                 if (GetContractNo() <> '') or ("Contract Group Code" <> '') or
        //                 //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //                   ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ")
        //                 then
        //                   "Posting Group" := ServPostJnl.GetSourcePostGroupService(Cust."No.","DIT Sub-Contract Type");
        //                 // >>DITW15.00.00.37 DDR
        //                 if "Posting Group" = '' then begin
        //                   Cust.TESTFIELD("Customer Posting Group");
        //                   "Posting Group" := Cust."Customer Posting Group";
        //                 end;
        //               end;
        //             end;
        //           ("Account Type" = "Account Type"::Vendor),
        //           ("Bal. Account Type" = "Bal. Account Type"::Vendor):
        //             begin
        //               CLEAR(Vend);
        //               if "Account Type" = "Account Type"::Vendor then
        //                 Vend.GET("Account No.")
        //               else
        //                 if "Bal. Account Type" = "Bal. Account Type"::Vendor then
        //                   Vend.GET("Bal. Account No.");

        //               // <<DITW16.00.00.43 DDR 02/05/2013 DIT-715 #575
        //               if DITPurchServMgtSetup.READPERMISSION then begin
        //                 DITPurchServMgtSetup.GET;
        //                 if DITPurchServMgtSetup."Contract Group Mandatory" and
        //                   (("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ") or
        //                    //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //                   (GetContractNo() <> '') or ("Building No." <> ''))
        //                   //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //                 then
        //                   TESTFIELD("Contract Group Code");
        //               end;
        //               // >>DITW16.00.00.43 DDR DIT-715 #575

        //               if Vend."No." <> '' then begin
        //                 "Posting Group" := '';
        //                 // <<DITW15.00.00.37 DDR 01/06/2010
        //                 //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //                 if (GetContractNo() <> '') or ("Contract Group Code" <> '') or
        //                 //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //                   ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ")
        //                 then
        //                   "Posting Group" := ServPurchPostJnl.GetSourcePostGroupService(Vend."No.","DIT Sub-Contract Type");
        //                 // >>DITW15.00.00.37 DDR
        //                 if "Posting Group" = '' then begin
        //                   Vend.TESTFIELD("Vendor Posting Group");
        //                   "Posting Group" := Vend."Vendor Posting Group";
        //                 end;
        //               end;
        //             end;
        //         end;
        //         // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
        //         SetFilterSubContractPostType;
        //         // >>DITW16.00.00.41 AHU DIT-715 #327
        //     end;
        // }
        // field(2034915;"Service Contract No.";Code[20])
        // {
        //     CaptionML = ENU='Service Contract No.',
        //                 FRA='N° contrat de service';
        //     Description = 'DITW15.00.00.35 -DIT-770 #1368';
        //     TableRelation = IF ("Contract Type"=CONST(Service),
        //                         "Source Type"=CONST(Customer)) "Service Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract),
        //                                                                                                        "DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type Filter"),
        //                                                                                                        "Customer No."=FIELD("Source No. Filter"),
        //                                                                                                        Status=FILTER(Signed))
        //                                                                                                        else IF ("Contract Type"=CONST(Service),
        //                                                                                                                 "Source Type"=CONST(Vendor)) "Service Purch. Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract),
        //                                                                                                                                                                                                     "DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type Filter"),
        //                                                                                                                                                                                                     "Vendor No."=FIELD("Source No. Filter"),
        //                                                                                                                                                                                                     Status=FILTER(Signed));

        //     trigger OnValidate();
        //     var
        //         FA2 : Record "Fixed Asset";
        //     begin
        //         // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
        //         if "Service Contract No." <> '' then begin
        //           //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           "Contract Type" := "Contract Type"::Service;
        //           TESTFIELD("Financial Contract No.",'');
        //           //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           if (CurrFieldNo = FIELDNO("Service Contract No.")) and
        //             (xRec."Service Contract No." <> "Service Contract No.")
        //           then begin
        //             "Service Contract Line No." := 0;
        //             "Contract Group Code" := '';
        //             "Building No." := '';
        //           end;
        //           ServContract.GET(ServContract."Contract Type"::Contract,"Service Contract No.");
        //           //<< DITW18.00.07 AKH 07/01/2016 DIT-770 #1473
        //            "Payment Terms Code" := ServContract."Payment Terms Code";
        //           //>> DITW18.00.07 AKH DIT-770 #1473
        //           if ("DIT Sub-Contract Type" <> 0) or
        //             ((xRec."DIT Sub-Contract Type" <> 0) and ("DIT Sub-Contract Type" = 0) and
        //             (xRec."Service Contract No." = "Service Contract No."))
        //           then
        //             TESTFIELD("DIT Sub-Contract Type",ServContract."DIT Sub-Contract Type")
        //           else
        //             "DIT Sub-Contract Type" := ServContract."DIT Sub-Contract Type";
        //           if ("Contract Group Code" <> '') or
        //             ((xRec."Contract Group Code" <> '') and ("Contract Group Code" = '') and
        //             (xRec."Service Contract No." = "Service Contract No."))
        //           then
        //             TESTFIELD("Contract Group Code",ServContract."Contract Group Code")
        //           else
        //             "Contract Group Code" := ServContract."Contract Group Code";
        //           if ("Building No." <> '') or
        //             ((xRec."Building No." <> '') and ("Building No." = '') and
        //             (xRec."Service Contract No." = "Service Contract No."))
        //           then
        //             TESTFIELD("Building No.",ServContract."Building No.")
        //           else
        //             "Building No." := ServContract."Building No.";
        //         end else begin
        //           //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           "Contract Type" := "Contract Type"::" ";
        //           "Contract Group Code" := '';
        //           //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           "Service Contract Line No." := 0;
        //         end;

        //         // <<DITW16.00.00.43 DDR 02/05/2013 DIT-715 #575
        //         if (CurrFieldNo = FIELDNO("Service Contract No.")) and
        //           (("Applies-to Doc. No." <> '') or ("Applies-to ID" <> ''))
        //         then
        //           ValidateApplyRequirements(Rec);
        //         // >>DITW16.00.00.43 DDR DIT-715 #575

        //         CreateDim(
        //           // <<DITW16.00.00.41 AHU 20/09/2012 DIT-715 #327
        //           DimMgt.TypeToTableID2034932(GetSourceType(),"Contract Type"),"Service Contract No.",
        //           // >>DITW16.00.00.41 AHU DIT-715 #327
        //           DimMgt.TypeToTableID1("Account Type"),"Account No.",
        //           DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
        //           DATABASE::Job,"Job No.",
        //           DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
        //           DATABASE::Campaign,"Campaign No.",
        //           // <<DITW15.00.00.37 DDR 28/01/2010
        //           DATABASE::Building,"Building No.");
        //           // >>DITW15.00.00.37 DDR

        //         SetFilterSubContractPostType;
        //         // >>DITW16.00.00.41 AHU DIT-715 #327
        //         // <<DITW16.00.00.43 DDR 14/11/2013 DIT-715 #827
        //         if CurrFieldNo = FIELDNO("Service Contract No.") then
        //           VALIDATE("DIT Sub-Contract Type");
        //         // >>DITW16.00.00.43 DDR DIT-715 #827
        //     end;
        // }
        // field(2035393;"Contract Type";Option)
        // {
        //     CaptionML = ENU='Contract Type',
        //                 FRA='Type contrat';
        //     Description = 'DIT-715 #392 - DIT-770 690 - DIT-770 #1368';
        //     OptionCaptionML = ENU=' ,Service,Financial',
        //                       FRA=' ,Service,Financier';
        //     OptionMembers = " ",Service,Financial;

        //     trigger OnValidate();
        //     begin
        //         //<<DITW17.10.05 MSF 16/07/2014 DIT-770 #690
        //         //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //         if rPropertyServiceMgtSetup.READPERMISSION  or
        //            rPropertyPurchServMgtSetup.READPERMISSION or
        //            ContractDIT.READPERMISSION
        //         then begin
        //         //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           //>>DITW17.10.05 MSF 16/07/2014 DIT-770 #690
        //           // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
        //           //<<DITW18.00.06 10/09/2015 DIT-770 #1566
        //           if ("Contract Type" <> xRec."Contract Type") and (xRec."Contract Type"<> xRec."Contract Type"::" ")then begin
        //           //>>DITW18.00.06 10/09/2015 DIT-770 #1566
        //             "Building No." := '';
        //             //<<DITW17.10.03 MSF 17/03/2014 DIT-715 #340
        //             if "Applies-to Doc. No."<>''then
        //               ERROR(Text2034841,FIELDCAPTION("Contract Type"),FIELDCAPTION("Applies-to Doc. No."));
        //             //>>DITW17.10.03 MSF 17/03/2014 DIT-715 #340
        //             "Contract Group Code" := '';
        //              "Service Contract Line No." := 0;
        //              //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //              if "Service Contract No." <> '' then
        //                VALIDATE("Service Contract No.",'');
        //              if "Financial Contract No." <> '' then
        //                VALIDATE("Financial Contract No.",'');
        //              //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           end;
        //           SetFilterSubContractPostType;
        //           // >>DITW16.00.00.41 AHU DIT-715 #327
        //         end;
        //         //>>DITW17.10.05 MSF 16/07/2014 DIT-770 #690
        //     end;
        // }  // BC Upgrade NANDIS03
    }
    keys
    {
        // key(Key1; "Applies-to D/P Source Table", "Applies-to D/P Line Type", "Applies-to D/P Line No.")
        // {
        // }
        // key(Key2; "Journal Template Name", "Journal Batch Name", "Driver Code", "Truck Code", "Document No.", "Document Date")
        // {
        //     SumIndexFields = "Amount (LCY)";
        // }  // BC Upgrade NANDIS03
        // key(Key3; "Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.", "Gen. Bus. Posting Group", "Gen. Prod. Posting Group")
        // {
        // } // BC Upgrade NANDIS03 - Blocked as Key3 is already used in standard
        key(Key12; "Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.", "Gen. Bus. Posting Group", "Gen. Prod. Posting Group")
        {
        }  // BC Upgrade NANDIS03 - Opened as Key3 is already used in standard
        // key(Key4; "Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.", "VAT Bus. Posting Group", "VAT Prod. Posting Group")
        // {
        // }  // BC Upgrade NANDIS03 - Blocked as Key4 is already used in standard
        key(Key13; "Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.", "VAT Bus. Posting Group", "VAT Prod. Posting Group")
        {
        }  // BC Upgrade NANDIS03 - Opened as Key4 is already used in standard
    }
    local procedure GetExportProtocol()

    begin
        //HEI.21>>
        IF "Export Protocol Code FND" <> '' THEN BEGIN
            IF "Export Protocol Code FND" <> ExportProtocol.Code THEN
                ExportProtocol.GET("Export Protocol Code FND");
        end else
            CLEAR(ExportProtocol);
        //HEI.21<<
    end;

    local procedure RelatedSalesNoLookUp()
    var
        SalesHeader: Record "Sales Header";
        SalesHeaderArchive: Record "Sales Header Archive";
        SalesHeaderArchive2: Record "Sales Header Archive";
        TempSalesHeaderArchive: Record "Sales Header Archive";
        SalesOrderArchivesPage: Page "Sales Order Archive";
        SalesOrderPage: Page "Sales Order List";
    begin
        //HEI.40<<
        IF (("Account Type" = "Account Type"::Customer) AND ("Bal. Account Type" = "Bal. Account Type"::"G/L Account")) OR
            (("Account Type" = "Account Type"::"G/L Account") AND ("Bal. Account Type" = "Bal. Account Type"::Customer)) THEN BEGIN
            IF "Sales/Archived Order Type FND" = "Sales/Archived Order Type FND"::"Archived Sales Order" THEN BEGIN
                SalesHeaderArchive.RESET();
                SalesHeaderArchive.SETCURRENTKEY("Document Type", "Bill-to Customer No.");
                SalesHeaderArchive.SETRANGE("Document Type", SalesHeaderArchive."Document Type"::Order);
                IF ("Account Type" = "Account Type"::Customer) AND ("Account No." <> '') THEN
                    SalesHeaderArchive.SETRANGE("Bill-to Customer No.", "Account No.")
                else IF ("Bal. Account Type" = "Bal. Account Type"::Customer) AND ("Bal. Account No." <> '') THEN
                    SalesHeaderArchive.SETRANGE("Bill-to Customer No.", "Bal. Account No.");
                IF SalesHeaderArchive.findset() THEN
                    REPEAT
                        SalesHeaderArchive2.RESET();
                        SalesHeaderArchive2.SETCURRENTKEY("Document Type", "Bill-to Customer No.", "No.");
                        SalesHeaderArchive2.SETRANGE("Document Type", SalesHeaderArchive."Document Type"::Order);
                        SalesHeaderArchive2.SETRANGE("Bill-to Customer No.", SalesHeaderArchive."Bill-to Customer No.");
                        SalesHeaderArchive2.SETRANGE("No.", SalesHeaderArchive."No.");
                        IF SalesHeaderArchive2.FINDLAST() THEN
                            TempSalesHeaderArchive.RESET();
                        TempSalesHeaderArchive.SETRANGE("Document Type", SalesHeaderArchive2."Document Type");
                        TempSalesHeaderArchive.SETRANGE("No.", SalesHeaderArchive2."No.");
                        TempSalesHeaderArchive.SETRANGE("Bill-to Customer No.", SalesHeaderArchive2."Bill-to Customer No.");
                        IF NOT TempSalesHeaderArchive.FINDFIRST() THEN BEGIN
                            TempSalesHeaderArchive.TRANSFERFIELDS(SalesHeaderArchive2);
                            TempSalesHeaderArchive.INSERT();
                        end;
                    UNTIL SalesHeaderArchive.NEXT() = 0;
                CLEAR(TempSalesHeaderArchive);
                IF PAGE.RUNMODAL(PAGE::"Sales Order Archives", TempSalesHeaderArchive) = ACTION::LookupOK THEN
                    VALIDATE("Related Sales Order FND", TempSalesHeaderArchive."No.");
            end else IF "Sales/Archived Order Type FND" = "Sales/Archived Order Type FND"::"Sales Order" THEN BEGIN
                SalesHeader.RESET();
                SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                IF ("Account Type" = "Account Type"::Customer) AND ("Account No." <> '') THEN
                    SalesHeader.SETRANGE("Bill-to Customer No.", "Account No.")
                else IF ("Bal. Account Type" = "Bal. Account Type"::Customer) AND ("Bal. Account No." <> '') THEN
                    SalesHeader.SETRANGE("Bill-to Customer No.", "Bal. Account No.");
                // SalesHeader.SETRANGE(Status,SalesHeader.Status::Open); //HEI.42 commented
                IF PAGE.RUNMODAL(PAGE::"Sales Order List", SalesHeader) = ACTION::LookupOK THEN
                    VALIDATE("Related Sales Order FND", SalesHeader."No.");
            end;
        end;
        //HEI.40>>
    end;

    local procedure RelatedSalesNoValidate()
    var
        SalesHeader: Record "Sales Header";
        SalesHeaderArchive: Record "Sales Header Archive";
        SalesHeaderArchive2: Record "Sales Header Archive";
        TempSalesHeaderArchive: Record "Sales Header Archive";
        SalesOrderArchivesPage: Page "Sales Order Archive";
        SalesOrderPage: Page "Sales Order List";
    begin
        //HEI.42<<
        IF "Related Sales Order FND" <> '' THEN BEGIN
            IF (("Account Type" = "Account Type"::Customer) AND ("Bal. Account Type" = "Bal. Account Type"::"G/L Account")) OR
                (("Account Type" = "Account Type"::"G/L Account") AND ("Bal. Account Type" = "Bal. Account Type"::Customer)) THEN BEGIN
                IF "Sales/Archived Order Type FND" = "Sales/Archived Order Type FND"::"Archived Sales Order" THEN BEGIN
                    SalesHeaderArchive.RESET();
                    SalesHeaderArchive.SETCURRENTKEY("Document Type", "Bill-to Customer No.");
                    SalesHeaderArchive.SETRANGE("Document Type", SalesHeaderArchive."Document Type"::Order);
                    IF ("Account Type" = "Account Type"::Customer) AND ("Account No." <> '') THEN
                        SalesHeaderArchive.SETRANGE("Bill-to Customer No.", "Account No.")
                    else IF ("Bal. Account Type" = "Bal. Account Type"::Customer) AND ("Bal. Account No." <> '') THEN
                        SalesHeaderArchive.SETRANGE("Bill-to Customer No.", "Bal. Account No.");
                    IF SalesHeaderArchive.findset() THEN
                        REPEAT
                            SalesHeaderArchive2.RESET();
                            SalesHeaderArchive2.SETCURRENTKEY("Document Type", "Bill-to Customer No.", "No.");
                            SalesHeaderArchive2.SETRANGE("Document Type", SalesHeaderArchive."Document Type"::Order);
                            SalesHeaderArchive2.SETRANGE("Bill-to Customer No.", SalesHeaderArchive."Bill-to Customer No.");
                            SalesHeaderArchive2.SETRANGE("No.", SalesHeaderArchive."No.");
                            IF SalesHeaderArchive2.FINDLAST() THEN
                                TempSalesHeaderArchive.RESET();
                            TempSalesHeaderArchive.SETRANGE("Document Type", SalesHeaderArchive2."Document Type");
                            TempSalesHeaderArchive.SETRANGE("No.", SalesHeaderArchive2."No.");
                            TempSalesHeaderArchive.SETRANGE("Bill-to Customer No.", SalesHeaderArchive2."Bill-to Customer No.");
                            IF NOT TempSalesHeaderArchive.FINDFIRST() THEN BEGIN
                                TempSalesHeaderArchive.TRANSFERFIELDS(SalesHeaderArchive2);
                                TempSalesHeaderArchive.INSERT();
                            end;
                        UNTIL SalesHeaderArchive.NEXT() = 0;
                    CLEAR(TempSalesHeaderArchive);
                    TempSalesHeaderArchive.SETRANGE("No.", "Related Sales Order FND");
                    IF NOT TempSalesHeaderArchive.FINDFIRST() THEN
                        ERROR(Text023, Rec.FIELDCAPTION("Related Sales Order FND"), Rec."Related Sales Order FND", 'Sales Header Archive');
                end else IF "Sales/Archived Order Type FND" = "Sales/Archived Order Type FND"::"Sales Order" THEN BEGIN
                    SalesHeader.RESET();
                    SalesHeader.SETRANGE("No.", "Related Sales Order FND");
                    SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                    IF ("Account Type" = "Account Type"::Customer) AND ("Account No." <> '') THEN
                        SalesHeader.SETRANGE("Bill-to Customer No.", "Account No.")
                    else IF ("Bal. Account Type" = "Bal. Account Type"::Customer) AND ("Bal. Account No." <> '') THEN
                        SalesHeader.SETRANGE("Bill-to Customer No.", "Bal. Account No.");
                    IF NOT SalesHeader.FINDFIRST() THEN
                        ERROR(Text023, Rec.FIELDCAPTION("Related Sales Order FND"), "Related Sales Order FND", 'Sales Header');
                end;
            end;
        end;
        //HEI.42>>
    end;

    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: lrShippingDtldJnlLine)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ApprovalsMgmt.OnCancelGeneralJournalLineApprovalRequest(Rec);

    TESTFIELD("Check Printed",FALSE);

    ClearCustVendApplnEntry;
    ClearAppliedGenJnlLine;
    DeletePaymentFileErrors;
    ClearDataExchangeEntries(FALSE);

    GenJnlAlloc.SETRANGE("Journal Template Name","Journal Template Name");
    GenJnlAlloc.SETRANGE("Journal Batch Name","Journal Batch Name");
    GenJnlAlloc.SETRANGE("Journal Line No.","Line No.");
    GenJnlAlloc.DELETEALL;

    DeferralUtilities.DeferralCodeOnDelete(
      DeferralDocType::"G/L",
      "Journal Template Name",
      "Journal Batch Name",0,'',"Line No.");

    VALIDATE("Incoming Document Entry No.",0);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CheckBlockedTemplate;  //HEI.61
    //HEI.59>>
    SETAUTOCALCFIELDS();
    if not Rec."System-Created Entry" then
    //HEI.59<<
    ApprovalsMgmt.OnCancelGeneralJournalLineApprovalRequest(Rec);


    TESTFIELD("Check Printed",false);
    #4..7

    if "Data Exch. Entry No." <> 0 then //HEI.59
    ClearDataExchangeEntries(false);
    #9..13
    //HEI.59>>
    {
    #15..18
    }
    //HEI.59<<
    VALIDATE("Incoming Document Entry No.",0);

    //HEI.59>>
    // <<DITW15.00.00.01 DDR 08/02/2008
    if "Applies-to D/P Line No." <> 0 then begin
    //HEI.59<<
    DiscPromoPostLine.ReopenFromGenJnlLine(Rec);
    // >>DITW15.00.00.01 DDR
    // <<DITW15.00.00.39 DDR 01/07/2011 #730
    PurchDiscPromoPostLine.ReopenFromGenJnlLine(Rec);
    // >>DITW15.00.00.39 DDR #730
    //HEI.59>>
    end;
    //HEI.59<<

    // <<DITW15.00.00.24 DDR 14/08/2008
    //HEI.59>>
    {
    lrShippingDtldJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
    lrShippingDtldJnlLine.SETRANGE("Journal Batch Name","Journal Batch Name");
    lrShippingDtldJnlLine.SETRANGE("Journal Line No.","Line No.");
    lrShippingDtldJnlLine.DELETEALL;
    // >>DITW15.00.00.24 DDR

    // <<DITW15.00.00.39 DDR 09/05/2011 #1328
    DeleteLinkPosPayEntries();
    }
    //HEI.59<<
    // >>DITW15.00.00.39 DDR #1328

    //HEI.07>>
    ReopenSalesForecastEntries;
    //HEI.07<<
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GenJnlAlloc.LOCKTABLE;
    LOCKTABLE;
    GenJnlTemplate.GET("Journal Template Name");
    GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
    "Posting No. Series" := GenJnlBatch."Posting No. Series";
    "Check Printed" := FALSE;

    ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
    ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CheckBlockedTemplate;  //HEI.61
    #1..5
    "Check Printed" := false;
    #7..9
    */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD("Check Printed",FALSE);
    IF ("Applies-to ID" = '') AND (xRec."Applies-to ID" <> '') THEN
      ClearCustVendApplnEntry;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CheckBlockedTemplate;  //HEI.61
    TESTFIELD("Check Printed",false);
    if ("Applies-to ID" = '') and (xRec."Applies-to ID" <> '') then
      ClearCustVendApplnEntry;
    //DITW17.00.02 SR 19/12/2013 DIT-770 #163
    if "Document Type" = "Document Type"::"Bank Charge" then
     VALIDATE("DIT Sub-Contract Type","DIT Sub-Contract Type"::" ");
    //DITW17.00.02 SR DIT-770 #163
    */
    //end;


    //Unsupported feature: CodeModification on "OnRename". Please convert manually.

    //trigger OnRename();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ApprovalsMgmt.RenameApprovalEntries(xRec.RECORDID,RECORDID);

    TESTFIELD("Check Printed",FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CheckBlockedTemplate;  //HEI.61
    ApprovalsMgmt.RenameApprovalEntries(xRec.RECORDID,RECORDID);

    TESTFIELD("Check Printed",false);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    // var
    //     lrShippingDtldJnlLine: Record "Shipping Dtld. Jnl. Line";  // BC Upgrade NANDIS03

    // var
    //     lblnlookup: Boolean;  // BC Upgrade NANDIS03

    var
        GenLedgerSetup: Record "General Ledger Setup";
        WHTEntry: Record "WHT Entry FND";
        WHTPostingSetup: Record "WHT Posting Setup FND";
        lblnlookup: Boolean;

    var
        PurchPost: Codeunit "Purch.-Post";

    var
        SalesPost: Codeunit "Sales-Post";


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : @@@="%1=Account Type,%2=Balance Account Type";ENU=%1 or %2 must be a G/L Account or Bank Account.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : @@@="%1=Account Type,%2=Balance Account Type";ENU=%1 or %2 must be a G/L Account or Bank Account.;FRA=%1 ou %2 doit être un compte général ou un compte bancaire.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You must not specify %1 when %2 is %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You must not specify %1 when %2 is %3.;FRA=Vous ne devez pas spécifier %1 quand %2 est %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=cannot be specified without %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=cannot be specified without %1;FRA=ne peut pas être spécifié(e) sans %1;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : @@@="%1=Caption of Currency Code field, %2=Caption of table Gen Journal, %3=FromCurrencyCode, %4=ToCurrencyCode";ENU=The %1 in the %2 will be changed from %3 to %4.\\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : @@@="%1=Caption of Currency Code field, %2=Caption of table Gen Journal, %3=FromCurrencyCode, %4=ToCurrencyCode";ENU=The %1 in the %2 will be changed from %3 to %4.\\Do you want to continue?;FRA=Le %1 dans le %2 va passer de %3 à %4.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=The update has been interrupted to respect the warning.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=The update has been interrupted to respect the warning.;FRA=La mise à jour a été interrompue pour respecter l'alerte.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=The %1 option can only be used internally in the system.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=The %1 option can only be used internally in the system.;FRA=L'option %1 ne peut être utilisée qu'en interne par le système.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : @@@="%1=Account Type,%2=Balance Account Type";ENU=%1 or %2 must be a bank account.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : @@@="%1=Account Type,%2=Balance Account Type";ENU=%1 or %2 must be a bank account.;FRA=%1 ou %2 doit être un compte bancaire.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=" must be 0 when %1 is %2.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=" must be 0 when %1 is %2.";FRA=" doit être 0 quand %1 est %2.";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text009(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU=LCY;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : ENU=LCY;FRA=DS;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text010(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text010 : ENU=%1 must be %2 or %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text010 : ENU=%1 must be %2 or %3.;FRA=%1 doit être %2 ou %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text011(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text011 : ENU=%1 must be negative.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text011 : ENU=%1 must be negative.;FRA=%1 doit être négatif/ve.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text012(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text012 : ENU=%1 must be positive.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text012 : ENU=%1 must be positive.;FRA=%1 doit être positif/ve.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text013(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text013 : ENU=The %1 must not be more than %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text013 : ENU=The %1 must not be more than %2.;FRA=%1 ne doit pas être supérieur(e) à %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text014(Variable 1054)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text014 : @@@="%1=Caption of Table Customer, %2=Customer No, %3=Caption of field Bill-to Customer No, %4=Value of Bill-to customer no.";ENU=The %1 %2 has a %3 %4.\\Do you still want to use %1 %2 in this journal line?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text014 : @@@="%1=Caption of Table Customer, %2=Customer No, %3=Caption of field Bill-to Customer No, %4=Value of Bill-to customer no.";ENU=The %1 %2 has a %3 %4.\\Do you still want to use %1 %2 in this journal line?;FRA=La %2 %1 a un %3 %4.\\Souhaitez-vous quand même utiliser %2 %1 dans cette ligne feuille ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text015(Variable 1058)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text015 : ENU=You are not allowed to apply and post an entry to an entry with an earlier posting date.\\Instead, post %1 %2 and then apply it to %3 %4.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text015 : ENU=You are not allowed to apply and post an entry to an entry with an earlier posting date.\\Instead, post %1 %2 and then apply it to %3 %4.;FRA=Vous n'êtes pas autorisé à lettrer et à enregistrer une écriture dans une écriture disposant d'une date de comptabilisation antérieure.\\Enregistrez plutôt %1 %2, puis lettrez-la dans %3 %4.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text016(Variable 1062)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text016 : ENU=%1 must be G/L Account or Bank Account.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text016 : ENU=%1 must be G/L Account or Bank Account.;FRA=%1 doit être un compte général ou un compte bancaire.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text018(Variable 1066)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text018 : ENU=%1 can only be set when %2 is set.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text018 : ENU=%1 can only be set when %2 is set.;FRA=%1 ne peut être déterminé que si %2 est défini.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text019(Variable 1067)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text019 : ENU=%1 cannot be changed when %2 is set.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text019 : ENU=%1 cannot be changed when %2 is set.;FRA=%1 ne peut pas être modifié si %2 est défini.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ExportAgainQst(Variable 1038)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ExportAgainQst : ENU=One or more of the selected lines have already been exported. Do you want to export them again?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ExportAgainQst : ENU=One or more of the selected lines have already been exported. Do you want to export them again?;FRA=Une ou plusieurs des lignes sélectionnées ont déjà été exportées. Souhaitez-vous les exporter à nouveau ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "NothingToExportErr(Variable 1021)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //NothingToExportErr : ENU=There is nothing to export.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NothingToExportErr : ENU=There is nothing to export.;FRA=Il n'y a rien à exporter.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "NotExistErr(Variable 1068)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //NotExistErr : @@@="%1=Document number";ENU=Document number %1 does not exist or is already closed.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NotExistErr : @@@="%1=Document number";ENU=Document number %1 does not exist or is already closed.;FRA=Le numéro de document %1 n'existe pas ou est déjà fermé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "DocNoFilterErr(Variable 1047)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DocNoFilterErr : ENU=The document numbers cannot be renumbered while there is an active filter on the Document No. field.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DocNoFilterErr : ENU=The document numbers cannot be renumbered while there is an active filter on the Document No. field.;FRA=Les numéros de document ne peuvent pas être modifiés lorsqu'un filtre est actif sur le champ N° document.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "DueDateMsg(Variable 1150)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DueDateMsg : ENU=This posting date will cause an overdue payment.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DueDateMsg : ENU=This posting date will cause an overdue payment.;FRA=Cette date comptabilisation va entraîner un règlement dû.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CalcPostDateMsg(Variable 1169)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CalcPostDateMsg : ENU=Processing payment journal lines #1##########;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CalcPostDateMsg : ENU=Processing payment journal lines #1##########;FRA=Traitement lignes feuille paiement #1##########;
    //Variable type has not been exported.

    var
        Text021: Label '%1 cannot be %2 when %3 is %4.';

    var
        CompanyInfo: Record "Company Information";
        //DiscPromoPostLine : Codeunit "Sales Disc. & Promo.-Post Line";  // BC Upgrade NANDIS03
        //PurchDiscPromoPostLine : Codeunit "Purch.Disc. & Promo.-Post Line";  // BC Upgrade NANDIS03
        //ServPostJnl : Codeunit "Serv-Posting Journals Mgt.";  // BC Upgrade NANDIS03
        //ServPurchPostJnl : Codeunit "Serv Purch.-Post Journals Mgt.";  // BC Upgrade NANDIS03
        ContractGroup: Record "Contract Group";
        Cust: Record Customer;
        CustBankAcc: Record "Customer Bank Account";
        DerogDeprBook: Record "Depreciation Book";
        ExportProtocol: Record "Export Protocol FND";
        DerogFADeprBook: Record "FA Depreciation Book";
        GenJnlTemplate: Record "Gen. Journal Template"; // BC Upgrade NANDIS03
        Generalledgersetup: Record "General Ledger Setup";
        VendBankAcc: Record "Vendor Bank Account";
        VendorBankAccount: Record "Vendor Bank Account";
        //recFinXLSetup : Record "Finance XL Setup";  // BC Upgrade NANDIS03
        //PurchasesUtils: Codeunit "Purchases-Utils";  // BC Upgrade NANDIS03 - Need to uncomment once Purch Utilities is compiled
        HeinekenGlobal: Codeunit "Heineken Global";
        //rPropertyServiceMgtSetup : Record "Property Service Mgt. Setup";  // BC Upgrade NANDIS03
        //rPropertyPurchServMgtSetup : Record "Property Purch Serv Mgt. Setup";  // BC Upgrade NANDIS03
        blnCalledFromValidate: Boolean;
        Var_HNKBank: Code[20];
        AccTypeNotInLineWithDocTypeErr: Label '%1 cannot be %2 when %3 is %4.';
        CheckConstant: Label 'INCLUDED IN PAYMENT PROPOSAL';
        Text022: Label '%1, %2 has different WHT posting group combinations on lines.';
        Text023: Label 'The field %1 contains a value (%2) that cannot be found in the related table (%3).';
        AccTypeNotSupportedErr: TextConst ENU = 'You cannot specify a deferral code for this type of account.', FRA = 'Vous ne pouvez pas spécifier un code échelonnement pour ce type de compte.';
        //Building: Record Building;  // BC Upgrade NANDIS03
        //DITServMgtSetup: Record "Property Service Mgt. Setup";  // BC Upgrade NANDIS03
        //DITPurchServMgtSetup: Record "Property Purch Serv Mgt. Setup";  // BC Upgrade NANDIS03
        //ServContract: Record "Service Contract Header";  // BC Upgrade NANDIS03
        //ContractDIT: Record "Financial Contract Header";  // BC Upgrade NANDIS03
        //ContractGroupDIT: Record "Financial Contract Group";  // BC Upgrade NANDIS03
        Text2034840: TextConst ENU = 'You may not change the Posting group if the Sub Contract type is filled.', FRA = 'Vous ne pouvez pas changer le groupe comptable si le type sous-contrat est saisi';
        Text2034841: TextConst ENU = 'You may not change %1 when %2 is filled', FRA = 'vous ne pouvez pas modifier %1 quand %2 est rempli';

    // BC Upgrade NANDIS03 >>
    //HEI.07>>
    trigger OnAfterDelete()
    var
        myInt: Integer;
    begin
        ReopenSalesForecastEntries();
    end;

    local procedure ReopenSalesForecastEntries()
    var
        SalesForecast: Record "Sales Forecast FND";
        MonthInt: Integer;
        YearInt: Integer;
        Month: Text;
        Year: Text;

    begin
        //HEI.07>>
        IF "Forecast Key FND" <> '' THEN BEGIN
            Year := COPYSTR("Forecast Key FND", 1, 4);
            Month := COPYSTR("Forecast Key FND", 5, STRLEN("Forecast Key FND"));
            EVALUATE(YearInt, Year);
            EVALUATE(MonthInt, Month);
            SalesForecast.RESET();
            SalesForecast.SETRANGE(Year, YearInt);
            SalesForecast.SETRANGE(Month, MonthInt);
            SalesForecast.MODIFYALL("Accounting Notes Generated", FALSE);
        end;
        //HEI.07<<
    end;
    //HEI.07<<

    procedure UpdateBankAcc(var Rec: Record "Gen. Journal Line"; var xrec: Record "Gen. Journal Line")
    var
        Vendor: Record Vendor;
    begin
        //HEI.16>>
        IF (Rec."Account Type" = Rec."Account Type"::Vendor) AND (Rec."Document Type" = Rec."Document Type"::Invoice) THEN BEGIN
            IF Vendor.GET(Rec."Account No.") THEN
                Rec.VALIDATE("Vendor Bank Account FND", Vendor."Preferred Bank Account Code")
            else
                Rec."Vendor Bank Account FND" := '';
            EXIT;
        end;
        //HEI.16<<
        //Rec."Vendor Bank Account" := '';//HEI.16
    end;
    // BC Upgrade NANDIS03 <<

    procedure GetDerogatorySetup()
    var
        CompanyInfo: Record "Company Information";
    begin
        //HEI.25>>
        CompanyInfo.GET();
        IF CompanyInfo."Enable French Localization FND" THEN BEGIN
            // "Derogatory Line" := FALSE;
            // IF ("Account Type" = "Account Type"::"Fixed Asset") AND
            //    ("Account No." <> '') AND
            //    ("Depreciation Book Code" <> '')
            // THEN BEGIN
            //     DerogDeprBook.SETRANGE("Derogatory Calculation", "Depreciation Book Code");
            //     IF DerogDeprBook.FINDFIRST THEN
            //         IF DerogFADeprBook.GET("Account No.", DerogDeprBook.Code) THEN
            //             "Derogatory Line" := TRUE;
            // end;  // BC Upgrade NANDIS03 - Dependency on FR localization
        end;
        //HEI.25<<
    end;

    procedure EnableActionIfTemplateNtBlock(): Boolean;
    begin
        //HEI.61>>
        IF GenJnlTemplate.GET("Journal Template Name") THEN BEGIN
            IF GenJnlTemplate."Blocked FND" THEN
                EXIT(FALSE)
            else
                EXIT(TRUE);
            EXIT(TRUE);
        end;
        //HEI.61<<
    end;

    // BC Upgrade NANDIS03 >>
    trigger OnInsert()
    begin
        CheckBlockedTemplate();
    end;

    trigger OnModify()
    begin
        CheckBlockedTemplate();
    end;

    trigger OnDelete()
    begin
        CheckBlockedTemplate();
    end;

    trigger OnRename()
    begin
        CheckBlockedTemplate();
    end;
    // BC Upgrade NANDIS03 <<
    local procedure CheckBlockedTemplate()
    var
        lText50000: TextConst ENU = 'General journal template %1 is blocked. Please contact administrator for assistance.';
    begin
        //HEI.61>>
        IF GenJnlTemplate.GET("Journal Template Name") THEN
            IF GenJnlTemplate."Blocked FND" THEN
                ERROR(lText50000, "Journal Template Name");
        //HEI.61<<
    end;

    procedure UpdateHNKBankAccount(HNKBank: Code[20])
    var
        myInt: Integer;
    begin
        //HEI.36<<
        Var_HNKBank := HNKBank;
        //HEI.36>>
    end;

    local procedure UpdateVATProdPostGroup()
    var
        TINByLocation: Record "TIN by Location FND";
    begin
        //HEI.19>>
        GeneralLedgerSetup.GET();
        IF GeneralLedgerSetup."Enable TIN By Location FND" THEN
            IF "VAT Prod. Posting Group" <> '' THEN BEGIN
                TINByLocation.GET("VAT Prod. Posting Group", '');
                "VAT Prod. Posting Group" := TINByLocation."VAT Prod. Posting Group by Loc";
                TINByLocation.CALCFIELDS("TIN No.");
                "TIN No. FND" := TINByLocation."TIN No.";
            end;
        //HEI.19<<
    end;

    procedure CheckTINNoMandatory()
    var
        myInt: Integer;
    begin
        //HEI.18>>
        GeneralLedgerSetup.GET();
        IF GeneralLedgerSetup."Enable TIN By Location FND" AND
           ("VAT Prod. Posting Group" <> '')
        THEN
            TESTFIELD("TIN No. FND");
        //HEI.18<<
    end;

    procedure InsertRPMDifferenceLine()
    var
        FAGLJnlLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        SalesSetup: Record "Sales & Receivables Setup";
        DifferenceAmount: Decimal;
    begin
        //HEI.11>>
        SalesSetup.GET();
        GenJnlLine2.SETRANGE("Journal Template Name", SalesSetup."RPM Damage/Loss Jnl. Templ FND");
        GenJnlLine2.SETRANGE("Journal Batch Name", SalesSetup."RPM Damage/Loss Jnl. Batch FND");
        GenJnlLine2.SETRANGE("Document Type", GenJnlLine2."Document Type"::"RPM Damage or Loss");
        GenJnlLine2.SETRANGE("Account Type", GenJnlLine2."Account Type"::"Fixed Asset");
        //HEI.14>>
        IF GenJnlLine2.findset() THEN
            REPEAT
                IF GenJnlLine2."RPM Original Sales Amount FND" < ABS(GenJnlLine2."Amount (LCY)") THEN BEGIN
                    DifferenceAmount := -(ABS(GenJnlLine2."Amount (LCY)") - GenJnlLine2."RPM Original Sales Amount FND");
                    GenJnlLine2.Amount := -GenJnlLine2."RPM Original Sales Amount FND";
                    GenJnlLine2."Amount (LCY)" := -GenJnlLine2."RPM Original Sales Amount FND";
                    GenJnlLine2.MODIFY();

                    InsertFAGLJnlLine(FAGLJnlLine, FAGLJnlLine."Account Type"::"G/L Account".AsInteger(), SalesSetup."RPM Loss G/L Account FND",
                      DifferenceAmount, FAGLJnlLine."FA Posting Type"::" ", GenJnlLine2."External Document No.", GenJnlLine2."Posting Date",
                      GenJnlLine2."Document Date", GenJnlLine2."Document No.", FALSE);
                end;
            UNTIL GenJnlLine2.NEXT() = 0;
        //HEI.14<<
        //HEI.11<<
    end;

    local procedure FindLastFAGLJnlLineNo(GenJnlTemplate: Code[10]; GenJnlBatch: Code[10]): Integer
    var
        FAGLJnlLine: Record "Gen. Journal Line";
        bbjbh: Codeunit "Gen. Jnl.-Post+Print";
    begin
        //>>HEI.11
        FAGLJnlLine.SETRANGE("Journal Template Name", GenJnlTemplate);
        FAGLJnlLine.SETRANGE("Journal Batch Name", GenJnlBatch);
        IF FAGLJnlLine.FINDLAST() THEN
            EXIT(FAGLJnlLine."Line No." + 10000)
        else
            EXIT(10000);
        //<<HEI.11
    end;

    procedure InsertFAGLJnlLine(VAR FAGLJnlLine: Record "Gen. Journal Line"; AccountType: Option; AccountNo: Code[20]; Amt: Decimal; FAPostingType: Option; ExternalDocNo: Code[20]; PostingDate: Date; DocumentDate: Date; DocumentNo: Code[20]; InsertRPMAmount: Boolean)
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        //>>HEI.11
        SalesSetup.GET();
        FAGLJnlLine.INIT();
        FAGLJnlLine.VALIDATE("Journal Template Name", SalesSetup."RPM Damage/Loss Jnl. Templ FND");
        FAGLJnlLine.VALIDATE("Journal Batch Name", SalesSetup."RPM Damage/Loss Jnl. Batch FND");
        FAGLJnlLine.VALIDATE("Line No.", FindLastFAGLJnlLineNo(FAGLJnlLine."Journal Template Name", FAGLJnlLine."Journal Batch Name"));
        FAGLJnlLine.INSERT(TRUE);
        FAGLJnlLine.VALIDATE("Document Type", FAGLJnlLine."Document Type"::"RPM Damage or Loss");
        FAGLJnlLine.VALIDATE("Account Type", AccountType);
        FAGLJnlLine.VALIDATE("Account No.", AccountNo);
        FAGLJnlLine.VALIDATE(Amount, Amt);
        IF InsertRPMAmount THEN
            FAGLJnlLine.VALIDATE("RPM Original Sales Amount FND", ABS(Amt));
        FAGLJnlLine.VALIDATE("FA Posting Type", FAPostingType);
        FAGLJnlLine.VALIDATE("External Document No.", ExternalDocNo);
        FAGLJnlLine.VALIDATE("Posting Date", PostingDate);
        FAGLJnlLine.VALIDATE("Document Date", DocumentDate);
        FAGLJnlLine.VALIDATE("Document No.", DocumentNo);
        FAGLJnlLine.MODIFY(TRUE);
        //<<HEI.11
    end;

}

