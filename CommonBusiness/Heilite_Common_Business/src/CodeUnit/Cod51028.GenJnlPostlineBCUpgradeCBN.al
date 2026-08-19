codeunit 51028 "Gen Jnl Post Line CU CBN"
{
    // DITW15.00.00.01 DDR 21/12/2007 Added Drink-it Tax Item Charges functionnalities
    // DITW15.00.00.01 DDR 27/12/2007 Added function CollectGLEntryRelation()
    // DITW15.00.00.01 DDR 04/01/2008 Added Drink-it Deposit Item Charges functionnalities
    // DITW15.00.00.01 DDR 10/01/2008 Skip VAT Settlement when post Tax Settlement
    // DITW15.00.00.01 DDR 21/12/2007 Added Drink-it Discount & Promotion Item Charges functionnalities
    // DITW15.00.00.01 DDR 29/01/2008 Added function SetGLReg()
    // DITW15.00.00.01 DDR 11/02/2008 Added Drink-It Periodic Discounts & Promotions functionnalities
    //                                Added function PostDiscPromo()
    // DITW15.00.00.01 DDR 20/02/2008 remove field2013783 "Applies-to D/P Line No."
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.24 DDR 14/08/2008 Remove/Replace PostDiscPromo()
    //                                Added function SetShippingDtldJnlLine(),GetShippingDltdJnlLine()
    //                                Move Detailed Shipping cost lines to Entries
    // DITW15.00.00.25 DDR 16/10/2008 Added fields "Truck Code","Driver Code" into Cust & Vend ledger entries
    // DITW15.00.00.25.01 DDR 12/01/2009 License problem
    // DITW15.00.00.30-PRODW14.00.00.09 DDR 21/01/2009 merge PRODW14.00.00.08.05A
    // DITW15.00.00.34 DDR 10/06/2009 Added to post Purchase Periodic Provisions
    // DITW15.00.00.35 DDR 07/08/2009 issue 757 bugfix Transaction no. while posting any document
    //                                  Removed function SetGLReg()
    //                     21/04/2009 Added Drink-it Service management
    //                                Transfer field "Contract Group Code" into Customer ledger entries + Detailed
    //                     22/09/2009 issue 813 Added to use "Contract Cust. Posting Group" or "Contract Vend. Posting Group" (from card)
    //                                           with contract groups
    //                     23/09/2009 issue 814 Split customer posting group per contract type
    //                     02/10/2009 issue 792 Added to check dimension value posting with (Sell-to) Customer
    // DITW15.00.00.37 DDR 28/01/2010 issue 879 Added "Building No." into Customer/Vendor ledger entries
    //                     10/05/2010 issue 857 Added "DIT Sub-Contract Type" into Customer/Vendor ledger entries
    //                     01/06/2010 issue 857 Bugfix to set the field "posting group" when use field "DIT Sub-contract type"
    //                                          Copied "DIT Sub-Contract Type" into Detailled Customer/Vendor ledger entries
    // DITW15.00.00.38 DDR 10/12/2010 issue 1221 Added into Customer/Vendor ledger entries
    //                                  "Customer Tax Registration No.","Customer Tax Warehouse Ref."
    // DITW15.00.00.39 DDR 09/05/2011 issue 1328 Shop (iPos) Functionnalities
    //                                           Added function UpdateAssocPosPayEntries()
    // DITW16.00.00.41 AHU 24/07/2012 DIT-715 #327 Added to transfer fields into G/L journal, Customer/Vendor Entries
    //                                               "Service Contract No.","Service Contract Line No.","Service Contract Type "
    //                     16/08/2012 DIT-715 #327 Bugfix transfer fields into G/L Entry
    //                     31/08/2012 DIT-715 #327 Bugfix fields "Service Contract Type" when no GenJnlLine."Service Contract No."
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added to transfer fields "Item Charge Type" into Customer/Vendor Entries + Detailed
    // DITW16.00.00.43 DDR 10/06/2013 DIT-715 #646 Added fields into DtldCVLedgEntryBuf record and filters to apply cust/vend entries
    //                     17/06/2013 DIT-715 #646 Removed apply filters on field "Building No."
    //                     14/08/2013 DIT-715 #678 Added fields "Deposit Amount","Deposit Amount (LCY)" into Customer Ledger Entry
    //                                             Added using Sales setup field "Excl. Deposit Payment Discount"
    //                     21/08/2013 DIT-715 #678 Bugfix deposit payment discount excl. Vat ("Pmt. Disc. Excl. VAT" field)
    //                 DDR 13/11/2013 DIT-715 #753 Bugfix missing "Service Contract Type" in Cust/Vendor entries
    //                 DDR 16/12/2013 DIT-715 #843 Bugfix deposit payment discount incl/excl vat

    // FINXL7.00.001 RBE 19/03/2013 : OGM Functionality
    //                                 "Auto Acc. Group"
    // FINXL8.00.001 BSA 16/06/2015 #124 : OGM Functionality on Vendor Lgr Entries

    // DITW17.00.02 DDR 10/06/2013 DIT-715 #646 merge
    //                  17/06/2013 DIT-715 #646 merge
    //              DDR 19/08/2013 DIT-715 #678 merge
    //              DDR 21/08/2013 DIT-715 #678 merge
    // DITW17.00.02 DDR 14/11/2013 DIT-715 #827 merge

    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade
    //  ? ReverseCustLedgEntry - ReverseVendLedgEntry
    //  ? TransferCustLedgEntry - TransferVendLedgEntry
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000
    // DITW17.00.02 DDR 16/12/2013 DIT-715 #843 merge
    // DITW17.10.03 MSF 28/03/2014 DIT-715 #340 : Added to transfer fields into G/L journal, Customer/Vendor Entries "Posting Group"
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.03 MSF 28/05/2014 DIT-770 #715 Upgrade W1 Rollup 6 ChangeLog.W1.36366 file 474255
    // DITW17.10.05 YHE 20/08/2014 DIT-770 #756 : Added functions UpdateInvAssocContractDit + UpdateInvAssocContractDITLines
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 09/07/2015 DIT-770 #501 Blocking message "Invoice x already exists" when posting - Case: activate split deposit
    //                                          Added parameter to function CheckSalesDocNoIsNotUsed
    //                                                                      CheckPurchDocNoIsNotUsed
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
    //                                           Added field 2014319  "Financial Contract No."
    //                                           Rename Caption Contract No. by Service contract No.
    //                                           Change ID of field Contract Type to Foundation layer 2035393
    //                                           Added blank Option to Contract Type
    // DITW18.00.07 AKH 30/03/2016 DIT-770 #1409 Made check on "External Doc. No. Mandatory" depending on the Customer setup

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL10.00 KSW 02/03/2017 NXL#22838: adjusted code to integrate Auto. Acc. Group with deferral functionality
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.12A MSF 04/07/2018 NRQ#75686 Invoice and credit memo with entry application may give error
    // DITW110.00.12A MSF 05/07/2018 NRQ#75686 Apply Entries depend on one field in General ledger Setup

    // HEI.01 RTRGAP038 02/08/17 IBM.CHAUHB01 Codee Add to update Remaining Amount
    // HEI.02 FDD-RTRGAP056 IBM HORTOC01 25.08.2017 - codd added into function POSTVAT
    // HEI.03 FDD-RTRGAP060 IBM HORTOC01 1.09.2017
    // HEI.04 NAV-BUG-FIX IBM PATHAA02 19.09.17
    // HEI.05 Defect #747 IBM NASTAA02 20.12.2017 # HeiMatch Export Inv. & Balance
    //   # Added code to populate fields in G/L Entry
    // HEI.06 FDD RTRGAP071 IBM POSTOI01 24.04.2018
    //   # Created function FAGAAPPosting(),InitFACommonFields()
    //   # Modified PostFixedAsset() function
    // HEI.07 FDD PTPGAP078 IBM POSTOI01 26.05.2018
    //   # if payment lines come from Payment Journal Tree page, then regardles of Bank Payment Type no Bank Ledger Entry or Check Ledger Entry should be generated
    // HEI.08 Defect #2463 IBM POSTOI01 # consistency error when trying to post Disposal lines for Heineken depreciation book
    //   # modify FAGAAPPosting for disposal postings
    // HEI.10 PRB0115813 IBM HORTOC01 06.12.2018 #preview posting issue. WHT dev changes
    // HEI.12 FDD-BA-SLSGAP01 IBM NASTAA02 19.12.2018 # Counterpoint Interface
    //   # Added code to fill-in Fields "Interface Code" and Reference in function "InitGLEntry"
    // HEI.13 FDD-RTRGAP BRD HT422 IBM BULIMC01 12.04.2019 #showing Invoice Payment Date field from WHT Entry page
    // HEI.15 FDD-HT584 IBM NASTAA02 02.09.2019 # La Reunion FA Derogatory Depreciation
    //   # New function created "MakeDerogFAJnlLine"
    // HEI.16 IBM MATHEJ01 26.09.19 - #CHG2024586 MR Account Field.
    //   # Code added to update MR Code in GL entry table.
    // HEI.17 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New code
    //   # New functions:
    //     # RealizeDelayedUnrealizedVAT
    //     # PostDelayedUnrealizedVAT
    //     # SetTransactionNo
    //     # CheckHeaderNo
    //     # UpdateUnrealCVLedgEntryBuffer
    //     # CreateAndPostDerogatoryEntry
    //     # MakeGenJnlLineOfTypeDerogatory
    //     # CalcPaidAmount
    // HEI.18 HB1048 IBM NASTAA02 28.01.2020 # Customer Ledger issue
    //   # Added code to apply all open Customer Ledger Entries
    // HEI.19 CHG2057437 IBM POENAB02 04.05.2020 # FDD_HT1104_DRC_WHT functionality enhancement
    //   # Modified functions UnapplyWHTEntry, PostGLAcc
    // HEI.20 CHG2052196 IBM PANDES01 08.05.2020
    //  # Fixed issue for Post Payment Journal tree to update status on Check ledger Entry.
    // HEI.21 FDD-HT1346 BULIMC01 IBM 25.05.2020 # code added to "PostBankAcc" function to replace the field "G/L Bank Account No." with "AP Suspense Account No." field
    // HEI.22 FDD-HT1143 SURYAS01  02.07.2020 # To post one additional G/L entries and split the VAT amount when posting the purchase invoice to show Non-dedutible VAT %
    //   # Created two New Functions- "InitGLEntry1","CreateGLentry1"
    //   # Added Code in Function - "PostGLAcc"
    //   # Modified Code in Funciton - "InsertVAT"
    // HEI.23 Defect#5821 BULIMC01 IBM 19.08.2020 #modify functions "InitGLEntry1" and ""InitGLEntry" to correct the Source Currency Amount values when using NonDeductible VAT
    // HEI.25 FDD-HB1609 CHG2074002 IBM BULIMC01 26.10.2020
    //   #new code added for Free Goods Accounting into the function "PostGLAcc"
    //   #new permission added for Table 113- Sales Invoice Line
    // HEI.26 CHG2090912 HB1641 IBM NANDIS01 01.02.2021 General Ledger Entries Description
    //   # Code added in function - PostGlAcc, PostFixedAsset, InitGLEntry
    // HEI.27 CHG2092434 HB1933 IBM GAVANM01 03.02.2021 OTC Payment Tolerance
    //   # payment tolerance issue when WHT is enabled
    // HEI.28 IBM BULIMC01 10/02/2021#adjustments for WHT Bareer functionality - round the GL amounts when the field"Round wht Calc." is enabled
    // HEI.30 Defect 6148 IBM BULIMC01 05/31/2021 #multiple adjustments for function FAAPosting
    // HEI.31 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # Code added on Function "InsertVAT"
    // HEI.32 CHG2146581 IBM BULIMC01 06/30/2021#corrections - amount is rounded when posting a payment without WHT
    // HEI.33 FDD-HB2376 - CHG2117381 IBM GAVANM01 27.09.2021 # Tolerance automatic application Panama
    //   #new function created: SetPmtTolAmtToBeApplied
    //   #code added in function CalcApplication
    //   #global var PmtTolAmtToBeApplied
    // HEI.34 HB2625 - CHG2151908 IBM NASTAA02 02.05.2022 #  Multiple Cash Application to Sales Order
    //   # Code added to apply automatically all Payments assigned to same Related Sales Order No.
    // HEI.35 CHG2117381 HB2376 IBM BHANDS01 25.11.2022 # Tolerance Payment Application Panama
    //   # New functions created: CheckMultiplePaymentsForInvoice and LastPaymentForInvoice
    //   # Global variable PmtTolAmtToBeApplied changed to PmtTolAmtToBeAppliedHNK and in function SetPmtTolAmtToBeApplied
    //   # Global var TolRelatedSONo added
    //   # Code related to Payment Tolerance removed from function CalcApplication() written perviously
    //   # Condition modified in the function PrepareTempCustLedgEntry
    //   # Code added in CalcPmtTolerancePossible()
    //   # Condition changed in PostCust()
    //   # Code added in ApplyCustLedgEntry()
    //   # Code added in function PostApplyCust()
    //   # New Function CalcCurrencyRealizedGainLossHNK
    // HEI.36 CHG2117381 HB2376 IBM DEBUSD01 12.12.2022 # Tolerance Payment Application Panama
    //   # Fix calculation tolerance
    //   # Performance on LastPaymentForInvoice(),CheckMultiplePaymentsForInvoice()
    // HEI.37 CHG2188019 DEBUSD01 10.01.2023 Applies-to ID error with item charge type filter
    //   # Fix conflict with auto SO payment tolerance (CHG2117381)
    // HEI.38 CHG2188908 IBM POENAB02 18.01.2023 Difference in C2S volumes vs PBI/CIL volumes vs Delivery to customer volumes
    //   # Modified function
    // HEI.39 CHG2160321 IBM SISUM01 27/01/2023 #If Source Code has Skip Dimension Control but mandat dimension is blank -> dimension value is get from SourceCodeDimension.
    //   Change in function InitGLEntry before to be checkDim. It's for booking accounting notes directly with CU12
    // HEI.40 FDD-HB2311 CHG2200648 IBM NANDIS01 12-06-2023 #Correct posting flow FA invoicing (credit notes)
    //   # Depending New Option value of - "Purchase Shipment" VAT line skipped
    // HEI.41 CHG2225264 IBM SISUM01 12.01.2024 HB3640_BRD_GT_FX on Working capital payables & receivables (excluding derivatives)
    //   # Call new funtion GetGainLossAccountFX from T4 in GetDtldVendLedgEntryAccNo,  GetDtldCustLedgEntryAccNo functions
    // HEI.42 CHG2224401 HB3624 YADAVM09 06.02.2024 Health and Security Levy Tax
    //   # Add code for levy tax functionality in function PostGLAcc,PostFixedAsset,CreateVendGLEntriesForTotalAmounts,InsertDtldVendLedgEntry
    // HEI.43  CHG2236692 IBM SISUM01 25.02.2024 HB3717_Development to perform revaluation for AR/AP
    //   #Add code for realized/unrealized gain/loss in functions PostDtldCustLedgEntries, PostDtldVendLedgEntries and create new function UpdateUnrealizRealizLossGainInfoInGenJnlLine
    // HEI.44 CHG2224401 HB3624 YADAVM09 04.04.2024 Health and Security Levy Tax
    //   #Code for levy tax functionality in function PostGLAcc
    // HEI.45 CHG2255472 IBM YADAVM09 06.08.2024 HB3976_Journal Template Name and Batch to be populated on Journal Entry
    //   #Code added in function Startposting


    //BC Upgrade GUNREM01 ....>> created new codeunit to subscribe Gen. Jnl.-Post Line events for Heineken BC Upgrade.

    // # In VATentry table extension created one procedure with the same name (SetVATDateFromGenJnlLine) becuase that is linternal procedure we cannt use that procedure in our event subscriber so created one with same name and called that procedure in our event subscriber.
    // # and created multiple procedures what ever the procedure used by HEI tags those are internal procedure. so created procedure with same name and called that procedure in our event subscriber.

    // HEI.01 Subcribed  OnInsertGLEntryOnBeforeAssignTempGLEntryBuf event and OnAfterInitGLEntry
    // HEI.02 OnBeforePostVAT
    // HEI.03 added in OnPostGLAccOnBeforeInsertGLEntry
    // HEI.04 OnAfterGetJournalsSourceCode and OnBeforePostGLAcc and OnAfterCopyGLEntryFromGenJnlLine, OnAfterInitBankAccLedgEntry ,OnAfterInitCustLedgEntry,OnAfterInitVendLedgEntry
    // HEI.05 code not there
    // HEI.06 Subcribed OnPostFixedAssetOnBeforeInitGLEntryFromTempFAGLPostBuf event and also created FAGAAPPosting and InitFACommonFields custom fucntions
    // HEI.07 OnPostBankAccOnCheckingBankAccPostingGrGLAccountNo and created InsertWHTPostingBufferPosted. This function is not created by HEI.07 but we have code in this fucntion 
    // HEI.08 Code added in FAGAAPPosting Function 
    // HEI.09 Tag not there
    // HEI.10 GetAmountLCY  Created this procedure and events are pending 
    // HEI.11 Tag not there
    // HEI.12 added code in OnAfterCopyGLEntryFromGenJnlLine event 
    // HEI.13 code is there in UnapplyWHTEntry . Created fucntion 
    // HEI.14 Not there
    // HEI.15code not required becuase filtering with DIT field
    // HEI.16 code added in OnAfterCopyGLEntryFromGenJnlLine
    // HEI.17 FR Localization Code blocked ,RealizeDelayedUnrealizedVAT fucntion and SetTransactionNo  and CheckHeaderNo and CalcPaidAmount not required because FR and DIT Related
    // HEI.18 No event to writ the code. the code is like in stating the condtion and repet is there and in the last they added until condition.
    // HEI.18 PrepareTempCustLedgEntry no event to write
    // HEI.19 Code added in OnBeforePostGLAcc  event. No correct event found so subcribed this event and block the existing code using ishandled
    // HEI.20 Subcribed OnPostBankAccOnAfterCheckLedgEntrySetFilters this event and Code is there in InsertWHTPostingBufferPosted Function 
    // HEI.21 FR Localization Not required 
    // HEI.22 Subscribed this event OnAfterInsertVATEntry, OnBeforeCreateNormalVATGLEntries and OnInsertVATOnBeforeCreateGLEntryForReverseChargeVATToPurchAcc and some code covered in OnBeforePostGLAcc event
    // HEI.23 code added in this event OnAfterCopyGLEntryFromGenJnlLine and code is added in InitGLEntry1 procedure 
    // HEI.24 Not there
    // HEI.25 Code covered in  OnBeforePostGLAcc
    // HEI.26 subcribed  OnAfterCopyGLEntryFromGenJnlLine ,OnBeforePostGLAcc and OnPostFixedAssetOnBeforeInsertGLEntry events OnPostGLAccOnBeforeInsertGLEntry
    // HEI.27 Code is in CalcGLAccWHT custom fucntion 
    // HEI.28 Code covered in OnBeforePostGLAcc event and subscribed OnPostVendAfterTempDtldCVLedgEntryBufInit event 
    // HEI.29 code commeneted in NAV
    // HEI.30 code is there in custom fucntion and some commented in NAV
    // HEI.31 subscribed OnAfterInsertVATEntry event
    // HEI.32 added in OnPostVendAfterTempDtldCVLedgEntryBufInit Event
    // HEI.33 Created SetPmtTolAmtToBeApplied Function
    // HEI.34 Created CheckRelatedSOIsLinked Function and subscribed this OnPrepareTempCustLedgEntryOnBeforeTestPositive  and added existing and new Hei code also
    // HEI.35 subcribed this event OnBeforeCalcPmtTolerancePossible and stopped existing code holw code written in this event using Ishandled. Because there is no event . NO event found in  PostApply function OnPostApplyOnAfterRecalculateAmounts,
    // HEI.36 Added code in this OnPostApplyOnAfterRecalculateAmounts and code added in custom fucntions
    // HEI.37 code not added its DIT code
    // HEI.38 code added in OnAfterCopyGLEntryFromGenJnlLine event
    // HEI.39 subdcribed OnInitGLEntryOnBeforeCheckGLAccountBlocked event
    // HEI.40 added in OnBeforePostVAT event
    // HEI.40 added in OnBeforePostVAT event
    // HEI.41 subcribed  OnBeforeGetGainLossAccount event 
    // HEI.42 subscribed  OnBeforeInsertVAT and OnMoveGenJournalLine.code is in between DIT tag. Code is there in  CreateVendGLEntriesForTotalAmounts   funtion In Nav but in BC the fucntion is not there
    // HEI.43 Subscribed OnPostDtldCustLedgEntriesOnBeforePostDtldCustLedgEntry,OnPostDtldVendLedgEntriesOnBeforePostDtldVendLedgEntry and OnBeforePostDtldCustLedgEntryUnapply, OnBeforePostDtldVendLedgEntryUnapply
    // HEI.44  added code in OnMoveGenJournalLine and OnMoveGenJournalLine
    // HEI.45 subscribed the event OnAfterInitGLRegister

    // BC Upgrade PATELP08 >> 
    // Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
    // BC Upgrade PATELP08 <<
    //Bc Upgrade YADAVM09 code added on event OnPostFixedAssetOnBeforeInitGLEntryFromTempFAGLPostBuf to fix FA G/l Preview posting issue.
    //-------------------------------BC UPgrade SHARMP16 CU 90----------------------------------
    //OnBeforePostVAT only for FA case ishandled
    //BC UPGRADE ATHUKUS01 FDDSTP_007 >>
    //1.the object merging process invokes the OnBeforeCreateNormalVATGLEntries event subscriber. However, the subscriber is not call as a real variable; subscriber variable added.
    //1.the object merging process invokes the OnInsertVATOnBeforeCreateGLEntryForReverseChargeVATToPurchAcc event subscriber. However, the subscriber is not call as a real variable; subscriber variable added.
    //BC UPGRADE ATHUKUS01 FDDSTP_007 <<

    //POENAB02, 08.07.2026, "MR Code" was not being copied from G/L Account to G/L Entry. Added code in OnAfterCopyGLEntryFromGenJnlLine event to copy the "MR Code" from G/L Account to G/L Entry.
    //Bc upgrade YADAVM09 event OnPostFixedAssetOnBeforeInitGLEntryFromTempFAGLPostBuf code blocked to create additional g/L entry.
    trigger OnRun()
    begin
    end;

    var
        //BC Upgrade GUNREM01 Codeunit 12 "Gen. Jnl.-Post Line" var >>
        GLSetup: record "General Ledger Setup";
        VATPosting: Boolean;
        GenJnlLine: Record "Gen. Journal Line";
        SourceCodeSetup: Record "Source Code Setup";
        GLAccount2: Record "G/L Account";
        GenJnlPostline: Codeunit "Gen. Jnl.-Post Line";
        lDimensionSetEntry: Record "Dimension Set Entry";
        FALedgerEntry: Record "FA Ledger Entry";
        TempGLEntry: Record "G/L Entry";
        GLEntry: Record "G/L Entry";
        // lWHTPostingSetup: record "WHT Posting Setup";
        // WHTPostingSetup: Record "WHT Posting Setup";
        PurchSetup: Record "General Ledger Setup";
        GenJnlLine3: Record "Gen. Journal Line";
        NextEntryNo: Integer;
        BankAccLedgEntry: record "Bank Account Ledger Entry";
        BankAcc: Record "Bank Account";
        BankAccPostingGr: Record "Bank Account Posting Group";

        BankPaymentTypeMustNotBeFilledErr: Label 'Bank Payment Type must not be filled if Currency Code is different in Gen. Journal Line and Bank Account.';
        CheckLedgEntry: Record "Check Ledger Entry";
        NextTransactionNo: Integer;
        CheckLedgEntry2: Record "Check Ledger Entry";

        DocNoMustBeEnteredErr: label 'Document No. must be entered when Bank Payment Type is %1.';
        NextCheckEntryNo: Integer;
        CheckAlreadyExistsErr: Label 'Check %1 already exists for this Bank Account.';
        GenJnlLine1: record "Gen. Journal Line";
        //  WHTManagement: Codeunit WHTManagement;
        CurrExchRate: Record "Currency Exchange Rate";
        // WHTEntry: Record "WHT Entry";
        // NewWHTEntry: Record "WHT Entry";
        PurchInvHeader: record "Purch. Inv. Header";
        // lWHTEntry: Record "WHT Entry";
        NextWHTEntryNo: Integer;
        //  gWHTPostingSetup: record "WHT Posting Setup";
        Source: Option " ";
        // UnrealizedWHTEntry: record "WHT Entry";
        DeprBook: Record "Depreciation Book";
        CurrFactor: Decimal;
        DescriptionMustNotBeBlankErr: label 'When %1 is selected for %2, %3 must have a value.';
        NonDeductiblePer1: Decimal;
        FADimAlreadyChecked: Boolean;
        Text50001: Label 'Type should be G/L Account for WHT Bearer as "OpCo"!';
        DimensionUsedErr: Label 'A dimension used in %1 %2, %3, %4 has caused an error. %5.';
        CompanyInfo: Record "Company Information";
        //    VATEntry2: Record "WHT Entry";
        DepreciationBook: Record "Depreciation Book";
        DerogDepreciationBook: Record "Depreciation Book";
        FAGAAPPostingType: Enum "FA Ledger Entry FA Posting Type";
        FAGAAPLedgerPostingCategory: Enum "FA Ledger Posting Category";
        NonDeductiblePer: Decimal;
        ExchangeAmtLCYToFCY2: Decimal;
        // WHTAmount: Decimal;
        // WHTAmountLCY: Decimal;
        PmtTolAmtToBeAppliedHNK: Decimal;
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        AddCurrGLEntryVATAmt: Decimal;
        HSTaxPostingSetup: Record "H&S Tax Posting Setup FND";
        Text50000: Label 'You can not post reverse charge with percent for foreign currency';
        Balancing: Boolean;
        Cust: Record Customer;
        OldCVLedgEntryBuf: Record "CV Ledger Entry Buffer";
        NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer";
        FirstNewVATEntryNo: Integer;
        CustLedgEntry2: Record "Cust. Ledger Entry";
        CheckRem: Boolean;
        GenJnlLine2: Record "Gen. Journal Line";
        GLSetupRead: Boolean;
        AddCurrencyCode: Code[10];
        AddCurrency: Record Currency;
        NextConnectionNo: Integer;
        NonDeductibleVAT: Codeunit "Non-Deductible VAT";
        VATEntry: Record "VAT Entry";
        FinancialUtils: Codeunit "Financial-Utils";
    //BC Upgrade GUNREM01 Codeunit 12 "Gen. Jnl.-Post Line" var <<


    //BC Upgrade GUNREM01 Codeunit 12 "Gen. Jnl.-Post Line" >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnInsertGLEntryOnBeforeAssignTempGLEntryBuf, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnInsertGLEntryOnBeforeAssignTempGLEntryBuf"(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line"; GLRegister: Record "G/L Register")
    begin
        //<< HEI.01 RTRGAP038 02/08/17
        IF GLEntry."Open FND" THEN
            GLEntry."Remaining Amount FND" := GLEntry.Amount;
        //>> HEI.01 RTRGAP038 02/08/17
        //FinancialUtils.CheckEbfComb(GLEntry);//HEI.01
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforePostVAT, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnBeforePostVAT"(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJnlLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; VATPostingSetup: Record "VAT Posting Setup"; var IsHandled: Boolean; var AddCurrGLEntryVATAmt: Decimal; var NextConnectionNo: Integer; var TaxDetail: Record "Tax Detail")
    begin
        IF (GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Purchase Receipt") OR (GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Purchase Shipment") THEN  //HEI.40
                                                                                                                                                                                 //  EXIT;//HEI.02
            IsHandled := true;//BC Upgrade SHARMP16 -- FAissue
    end;//BC UPgrade SHARMP16 CU 90

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterGetJournalsSourceCode, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnAfterGetJournalsSourceCode"(var Sender: Codeunit "Gen. Jnl.-Post Line"; var JournalsSourceCodesList: List of [Code[10]])
    begin
        VATPosting := FALSE; //HEI.04
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforeInitGLEntry, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnBeforeInitGLEntry"(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJournalLine: Record "Gen. Journal Line"; var GLAccNo: Code[20]; SystemCreatedEntry: Boolean; Amount: Decimal; AmountAddCurr: Decimal; FADimAlreadyChecked: Boolean; var IsHandled: Boolean; var GLEntry: Record "G/L Entry"; UseAmountAddCurr: Boolean; NextEntryNo: Integer; NextTransactionNo: Integer)
    var
        // WHTAmountLCY: Decimal;
        // WHTAmount: Decimal;
        GLAcc: Record "G/L Account";
        VATPostingSetup: Record "VAT Posting Setup";
        //   WHTPostingSetup: Record "WHT Posting Setup";

        lGenJnlLine: Record "Gen. Journal Line";
        lPurchInvHeader: Record "Purch. Inv. Header";
        //  lWHTPostingSetup: Record "WHT Posting Setup";
        lPurchInvLine: Record "Purch. Inv. Line";
        CheckLedgEntry: Record "Check Ledger Entry";
        CheckLedgEntry2: Record "Check Ledger Entry";
        SalesInvoiceLine: Record "Sales Invoice Line";
        Customer: Record Customer;
        GenPostingSetup: Record "General Posting Setup";
        TempPurchInvLine: Record "Purch. Inv. Line";
        //   lWHTEntry: Record "WHT Entry";
        lVendLedgEntry: Record "Vendor Ledger Entry";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchaseLine: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
        HSTaxPostingSetup: Record "H&S Tax Posting Setup FND";
        HSAccountno: Code[20];
        Item: Record Item;
        HSAccountno1: Code[20];
        GenJnl: Record "Gen. Journal Line";
    begin
        //  CalcGLAccWHT(GenJnlLine, WHTPostingSetup, WHTAmountLCY, WHTAmount);
        // G/L entry
        VATPosting := FALSE; //HEI.04
                             //HEI.25<<
        IF GenJournalLine."Free Goods Accounting FND" THEN BEGIN
            SalesInvoiceLine.RESET;
            SalesInvoiceLine.SETRANGE("Document No.", GenJournalLine."Document No.");
            SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::Item);
            // SalesInvoiceLine.SETRANGE("Free Item", TRUE);
            // SalesInvoiceLine.SETFILTER("Free Reason Code", '<>%1', '');
            IF SalesInvoiceLine.FINDSET THEN
                REPEAT
                    IF Customer.GET(SalesInvoiceLine."Sell-to Customer No.") AND (Customer."Free Goods Accounting HNK FND") THEN BEGIN
                        IF GenPostingSetup.GET(SalesInvoiceLine."Gen. Bus. Posting Group", SalesInvoiceLine."Gen. Prod. Posting Group") THEN;
                        IF VATPostingSetup.GET(SalesInvoiceLine."VAT Bus. Posting Group", SalesInvoiceLine."VAT Prod. Posting Group") THEN;
                        IF GenJournalLine."Account No." IN [GenPostingSetup."HNK Free Goods Offset Acc. FND", GenPostingSetup."Cost of Free Goods (HNK) FND", VATPostingSetup."Free Goods VAT (HNK) FND"] THEN BEGIN
                            SalesInvoiceLine."Free Goods Posted FND" := TRUE;
                            SalesInvoiceLine.MODIFY;
                        END;
                    END;
                UNTIL SalesInvoiceLine.NEXT = 0;
        END;
        //HEI.25>>

        //HEI.19>>
        // IF GenJournalLine."Source Code" = SourceCodeSetup."Payment Journal Tree" THEN BEGIN
        //     IF GLSetup."Enable WHT" = TRUE THEN BEGIN
        //         IF lWHTPostingSetup.GET(GenJnlLine."WHT Business Posting Group", GenJnlLine."WHT Product Posting Group") AND
        //           (GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::" ") THEN BEGIN
        //             IF lWHTPostingSetup."WHT Bearer" = lWHTPostingSetup."WHT Bearer"::Vendor THEN
        //                 //HEI.28>>
        //                 IF (GLSetup."Round Amount for WHT Calc") AND (lWHTPostingSetup."WHT %" <> 0) THEN begin
        //                     GenJournalLine."Amount (LCY)" := ROUND((GenJournalLine."Amount (LCY)" + WHTAmountLCY), 1, '<');
        //                     GenJournalLine."Source Currency Amount" := ROUND((GenJournalLine."Source Currency Amount" + WHTAmountLCY), 1, '<')
        //                     // InitGLEntry(GenJnlLine, GLEntry, "Account No.", ROUND(("Amount (LCY)" + WHTAmountLCY), 1, '<'),
        //                     //   ROUND(("Source Currency Amount" + WHTAmountLCY), 1, '<'), TRUE, "System-Created Entry")
        //                 end
        //                 ELSE
        //                     //HEI.28<<
        //                     GenJournalLine."Amount (LCY)" := GenJournalLine."Amount (LCY)" + WHTAmountLCY;
        //             GenJournalLine."Source Currency Amount" := GenJournalLine."Source Currency Amount" + WHTAmountLCY;
        //             //         InitGLEntry(GenJnlLine, GLEntry, "Account No.", "Amount (LCY)" + WHTAmountLCY,
        //             // "Source Currency Amount" + WHTAmountLCY, TRUE, "System-Created Entry");
        //             IF lWHTPostingSetup."WHT Bearer" = lWHTPostingSetup."WHT Bearer"::Opco THEN
        //                 //HEI.28>>
        //                 IF (GLSetup."Round Amount for WHT Calc") AND (lWHTPostingSetup."WHT %" <> 0) THEN begin
        //                     GenJournalLine."Amount (LCY)" := ROUND(GenJournalLine."Amount (LCY)", 1, '<');
        //                     GenJournalLine."Source Currency Amount" := ROUND((GenJournalLine."Source Currency Amount" + WHTAmountLCY), 1, '<');
        //                     // InitGLEntry(GenJnlLine, GLEntry, "Account No.", ROUND("Amount (LCY)", 1, '<'),
        //                     //   ROUND(("Source Currency Amount" + WHTAmountLCY), 1, '<'), TRUE, "System-Created Entry")
        //                 end
        //                 ELSE begin
        //                     //HEI.28<<
        //                     //         InitGLEntry(GenJnlLine, GLEntry, "Account No.", "Amount (LCY)",
        //                     // "Source Currency Amount" + WHTAmountLCY, TRUE, "System-Created Entry");
        //                     GenJournalLine."Amount (LCY)" := GenJournalLine."Amount (LCY)";
        //                     GenJournalLine."Source Currency Amount" := GenJournalLine."Source Currency Amount" + WHTAmountLCY;
        //                 END
        //             ELSE //HEI.28<<
        //                 IF (GLSetup."Round Amount for WHT Calc") AND (lWHTPostingSetup."WHT %" <> 0) THEN begin
        //                     // InitGLEntry(GenJnlLine, GLEntry, "Account No.", ROUND(("Amount (LCY)" + WHTAmountLCY), 1, '<'),
        //                     // ROUND(("Source Currency Amount" + WHTAmountLCY), 1, '<'), TRUE, "System-Created Entry")
        //                     GenJournalLine."Amount (LCY)" := ROUND((GenJournalLine."Amount (LCY)" + WHTAmountLCY), 1, '<');
        //                     GenJournalLine."Source Currency Amount" := ROUND((GenJournalLine."Source Currency Amount" + WHTAmountLCY), 1, '<');
        //                 end
        //                 ELSE //HEI.28>>
        //                     // InitGLEntry(GenJnlLine, GLEntry,
        //                     //   "Account No.", "Amount (LCY)" + WHTAmountLCY,
        //                     //   "Source Currency Amount" + WHTAmountLCY, TRUE, "System-Created Entry");
        //                     GenJournalLine."Amount (LCY)" := GenJournalLine."Amount (LCY)" + WHTAmountLCY;
        //             GenJournalLine."Source Currency Amount" := GenJournalLine."Source Currency Amount" + WHTAmountLCY;
        //         END
        //         ELSE
        //             // InitGLEntry(GenJnlLine, GLEntry,
        //             //   "Account No.", "Amount (LCY)" + WHTAmountLCY,
        //             //   "Source Currency Amount" + WHTAmountLCY, TRUE, "System-Created Entry");
        //             GenJournalLine."Amount (LCY)" := GenJournalLine."Amount (LCY)" + WHTAmountLCY;
        //         GenJournalLine."Source Currency Amount" := GenJournalLine."Source Currency Amount" + WHTAmountLCY;
        //     END
        //     //  ELSE
        //HEI.19<<
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforeCheckGLAccDirectPosting, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnBeforeCheckGLAccDirectPosting"(var GenJournalLine: Record "Gen. Journal Line"; GLAcc: Record "G/L Account"; var IsHandled: Boolean)
    begin
        if not GenJournalLine."System-Created Entry" then
            if GenJournalLine."Posting Date" = NormalDate(GenJournalLine."Posting Date") then
                IF NOT GenJournalLine."Free Goods Accounting FND" THEN //HEI.25
                    GLAcc.TestField("Direct Posting", true);
        isHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPostGLAccOnBeforeInsertGLEntry, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnPostGLAccOnBeforeInsertGLEntry"(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var IsHandled: Boolean; Balancing: Boolean)
    begin
        GLEntry."Forecast Line FND" := GenJournalLine."Forecast Line FND";//HEI.03
                                                                          //HEI.26>>
        GLEntry."Additional Description FND" := GenJournalLine."Additional Description FND";
        //HEI.26<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPostGLAccOnBeforePostJob, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnPostGLAccOnBeforePostJob"(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var IsHandled: Boolean; Balancing: Boolean)
    var
        GLAcc: Record "G/L Account";
        lVendLedgEntry: Record "Vendor Ledger Entry";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchaseLine: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
        HSTaxPostingSetup: Record "H&S Tax Posting Setup FND";
        HSAccountno: Code[20];
        Item: Record Item;
        HSAccountno1: Code[20];
        GenJnl: Record "Gen. Journal Line";
        lPurchInvLine: Record "Purch. Inv. Line";
        TempPurchInvLine: Record "Purch. Inv. Line";

    begin
        //HEI.22<< ----To post one additional G/L entries and split the VAT amount when posting the purchase invoice
        NonDeductiblePer1 := 0;
        GLAcc.RESET;
        IF GLAcc.GET(GenJournalLine."Account No.") THEN BEGIN
            IF GLAcc."Non Deductible VAT % FND" > 0 THEN BEGIN
                NonDeductiblePer1 := (GenJournalLine."VAT Amount" * GLAcc."Non Deductible VAT % FND") / 100;
                CreateGLEntry1(GenJournalLine, GenJournalLine."Account No.", ROUND(NonDeductiblePer1), ROUND(NonDeductiblePer1), TRUE);
            END
        END;
        //HEI.22>>
    end;

    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", OnAfterCopyGLEntryFromGenJnlLine, '', false, false)]

    local procedure "G/L Entry_OnAfterCopyGLEntryFromGenJnlLine"(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line")
    var
        GLAcc: Record "G/L Account";
    begin
        //POENAB02, 08.07.2026>>
        if GLAcc.get(GLEntry."G/L Account No.") then
            //POENAB02, 08.07.2026<<
            GLEntry."MR Code FND" := GLAcc."MR Code FND";  //HEI.16<<
                                                           //HEI.04 IBM PATHAA02 19.09.17>>
        GLEntry.Comment := GenJnlLine.Comment;
        //HEI.04 IBM PATHAA02 19.09.17<<
        //HEI.26>>
        GLEntry."Additional Description FND" := GenJnlLine."Additional Description FND";
        //HEI.26<<
        //HEI.04>>
        // <<HIT0007.1 BGI 14/05/2008
        IF GenJnlLine."Source Currency Code" <> '' THEN BEGIN
            IF GenJnlLine."Account Type" = GenJnlLine."Account Type"::"G/L Account" THEN BEGIN
                IF VATPosting THEN
                    //HEI.23>>
                    IF GLAccount2.GET(GenJnlLine."Account No.") AND (GLAccount2."Non Deductible VAT % FND" <> 0) THEN
                        GLEntry."Source Currency Amount" := GenJnlLine."Source Curr. VAT Amount" * GLAccount2."Non Deductible VAT % FND" / 100
                    ELSE
                        //HEI.23<<
                        GLEntry."Source Currency Amount" := GenJnlLine."Source Curr. VAT Amount"
                ELSE
                    GLEntry."Source Currency Amount" := GenJnlLine."Source Curr. VAT Base Amount";
            END ELSE
                GLEntry."Source Currency Amount" := GenJnlLine."Source Currency Amount";

            IF GLEntry."Source Currency Amount" <> 0 THEN
                GLEntry."Currency Code FND" := GenJnlLine."Source Currency Code";
        END;
        // >>HIT0007.1 BGI 14/05/2008
        //HEI.04<<
        //HEI.12>>
        GLEntry."Interface Code FND" := GenJnlLine."Interface Code FND";
        GLEntry."CP Vendor Invoice No. FND" := GenJnlLine."CP Vendor Invoice No. FND";
        //HEI.02<<
        //HEI.38>>
        GenJnlPostline.GetGLSetup;
        IF GLEntry."Global Dimension 2 Code" = '' THEN
            IF lDimensionSetEntry.GET(GLEntry."Dimension Set ID", GLSetup."Global Dimension 2 Code") THEN
                GLEntry."Global Dimension 2 Code" := lDimensionSetEntry."Dimension Value Code";
        //HEI.38<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterInitBankAccLedgEntry, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnAfterInitBankAccLedgEntry"(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        //HEI.04 IBM PATHAA02 19.09.17>>
        BankAccountLedgerEntry."Comment FND" := GenJnlLine.Comment;
        //HEI.04 IBM PATHAA02 19.09.17<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterInitCustLedgEntry, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnAfterInitCustLedgEntry"(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; var GLRegister: Record "G/L Register")
    begin
        //HEI.04 IBM PATHAA02 19.09.17>>
        CustLedgerEntry."Comment FND" := GenJnlLine.Comment;
        //HEI.04 IBM PATHAA02 19.09.17<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterInitVendLedgEntry, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnAfterInitVendLedgEntry"(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; var GLRegister: Record "G/L Register")
    begin
        //HEI.04 IBM PATHAA02 19.09.17>>
        VendorLedgerEntry."Comments FND" := GenJnlLine.Comment;
        //HEI.04 IBM PATHAA02 19.09.17<<
    end;

    //Bc Upgrade YADAVM09 BCUP0-200>>
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPostFixedAssetOnBeforeInitGLEntryFromTempFAGLPostBuf, '', false, false)]
    // local procedure "Gen. Jnl.-Post Line_OnPostFixedAssetOnBeforeInitGLEntryFromTempFAGLPostBuf"(var GenJournalLine: Record "Gen. Journal Line"; var TempFAGLPostBuf: Record "FA G/L Posting Buffer" temporary)
    // begin
    //     //>>HEI.06
    //     IF FALedgerEntry.GET(TempFAGLPostBuf."FA Entry No.") THEN BEGIN
    //         FAGAAPPosting(GenJournalLine, FALedgerEntry."FA Posting Category", FALedgerEntry.Amount, TempGLEntry, FALedgerEntry."FA Posting Group"
    //         , FALedgerEntry."FA Posting Type", FALedgerEntry."Depreciation Book Code");
    //     END;
    //     //<<HEI.06
    // end;
    //Bc Upgrade YADAVM09 BCUP0-200<<
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPostBankAccOnAfterBankAccLedgEntryInsert, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnPostBankAccOnAfterBankAccLedgEntryInsert"(var Sender: Codeunit "Gen. Jnl.-Post Line"; var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; BankAccount: Record "Bank Account")
    begin
        //HEI.07>>
        SourceCodeSetup.GET;
        IF GenJournalLine."Source Code" <> SourceCodeSetup."Payment Journal Tree FND" THEN; // BEGIN //HEI.07<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPostBankAccOnCheckingBankAccPostingGrGLAccountNo, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnPostBankAccOnCheckingBankAccPostingGrGLAccountNo"(var GenJournalLine: Record "Gen. Journal Line"; BankAccPostingGr: Record "Bank Account Posting Group"; var IsHandled: Boolean)
    begin
        // END
        // ELSE //HEI.07
        //HEI.07>>
        IF GenJournalLine."Source Code" = SourceCodeSetup."Payment Journal Tree FND" THEN BEGIN
            IF GenJournalLine."Bank Payment Type" = "Bank Payment Type"::"Computer Check" THEN
                GenJournalLine.TESTFIELD("Check Printed", TRUE);
        end;
        //HEI.07<<
        //BC Upgrade GUNREM01 FR localization >>
        //HEI.21<<
        // IF PaymentHeader.GET(GenJnlLine."Document No.") THEN
        //     IF PaymentClass.GET(PaymentHeader."Payment Class") THEN;

        // IF PaymentClass."Vendor Payment Process" THEN BEGIN
        //     BankAccPostingGr.TESTFIELD("AP Suspense Account");
        //     CreateGLEntryBalAcc(GenJnlLine, BankAccPostingGr."AP Suspense Account",
        //       "Amount (LCY)" + WHTAmountLCY, "Source Currency Amount" + WHTAmount,
        //       "Bal. Account Type", "Bal. Account No.");
        // END ELSE BEGIN
        //     //HEI.21>>
        // end;
        //BC Upgrade GUNREM01 FR localization >>
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPostBankAccOnAfterCheckLedgEntrySetFilters, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnPostBankAccOnAfterCheckLedgEntrySetFilters"(var Sender: Codeunit "Gen. Jnl.-Post Line"; var CheckLedgEntry: Record "Check Ledger Entry"; GenJnlLine: Record "Gen. Journal Line")
    begin
        //>>HEI.20
        //CheckLedgEntry.SETRANGE("Bank Account No.","Account No.");
        IF GenJnlLine.Amount <= 0 THEN
            IF GenJnlLine."HNK Bank Account FND" = '' THEN
                CheckLedgEntry.SETRANGE("Bank Account No.", GenJnlLine."Account No.")
            ELSE
                CheckLedgEntry.SETRANGE("Bank Account No.", GenJnlLine."HNK Bank Account FND")
        ELSE
            IF GenJnlLine."HNK Bank Account FND" = '' THEN
                CheckLedgEntry.SETRANGE("Bank Account No.", GenJnlLine."Bal. Account No.")
            ELSE
                CheckLedgEntry.SETRANGE("Bank Account No.", GenJnlLine."HNK Bank Account FND");
        CheckLedgEntry.SETRANGE("Entry Status", CheckLedgEntry."Entry Status"::Printed);
        //CheckLedgEntry.SETRANGE("Check No.","Document No.");
        IF GenJnlLine."HNK Bank Account FND" = '' THEN
            CheckLedgEntry.SETRANGE("Check No.", GenJnlLine."Document No.")
        ELSE
            CheckLedgEntry.SETRANGE("Check No.", GenJnlLine."HNK Check No. FND"); //<<HEI.20
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterInsertVATEntry, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnAfterInsertVATEntry"(var Sender: Codeunit "Gen. Jnl.-Post Line"; GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer; var TempGLEntryVATEntryLink: Record "G/L Entry - VAT Entry Link" temporary)
    var
        TaxJurisdiction: Record "Tax Jurisdiction";
        VATAmount: Decimal;
        VATBase: Decimal;
        SrcCurrVATAmount: Decimal;
        SrcCurrVATBase: Decimal;
        VATDifferenceLCY: Decimal;
        SrcCurrVATDifference: Decimal;
        UnrealizedVAT: Boolean;
        GLAcc: Record "G/L Account";
        GeneralLedgerSetup: Record "General Ledger Setup";
        GeneralPostingSetup: Record "General Posting Setup";
        FinancialUtils: Codeunit "Financial-Utils";
        VATPostingSetup: Record "VAT Posting Setup";
        GLEntryVATAmount: Decimal;
        SrcCurrGLEntryVATAmt: Decimal;
        SrcCurrCode: Code[10];
        AddCurrencyCode: Code[10];
    begin
        //HEI.31>>
        GeneralLedgerSetup.GET;
        IF GeneralLedgerSetup."Enable CAD FND" THEN BEGIN
            IF GenJnlLine."Gen. Posting Type" = GenJnlLine."Gen. Posting Type"::Sale THEN BEGIN
                IF (VATPostingSetup."CAD % FND" > 0) AND (VATPostingSetup."Sales CAD Account FND" <> '') AND (GenJnlLine."VAT Amount" <> 0) THEN BEGIN
                    //  GenJnlPostline.InitGLEntry(GenJnlLine, GLEntry, VATPostingSetup."Sales CAD Account", "CAD Amount", "CAD Amount", TRUE, GenJnlLine."System-Created Entry"); //BC upgrade GUNREM01 -Blocked DIT Field
                    GenJnlPostline.InsertGLEntry(GenJnlLine, GLEntry, TRUE);
                    //  FinancialUtils.InsertSalesCADEntry(VATEntry, "CAD Amount");
                END;

                //VAT On Free
                IF ((GenJnlLine."VAT Amount" = 0) AND (GenJnlLine."VAT %" <> 0) AND (GenJnlLine."VAT Base Amount" <> 0)) OR
                   ((GenJnlLine."VAT Amount" <> 0) AND (GenJnlLine."VAT %" <> 0) AND (GenJnlLine."VAT Base Amount" = 0) AND
                   (ABS(GenJnlLine.Amount) = ABS(GenJnlLine."VAT Amount")))
                THEN BEGIN
                    //  GeneralPostingSetup.GET("Gen. Bus. Posting Group", "Gen. Prod. Posting Group");
                    GeneralPostingSetup.TESTFIELD("Cost of Free Goods (HNK) FND"); //BC upgrade GUNREM01 -Blocked DIT Field
                                                                                   //   InitGLEntry(GenJnlLine, GLEntry, GeneralPostingSetup."VAT on Free Expense Account", -"CAD Amount", -"CAD Amount", TRUE, GenJnlLine."System-Created Entry"); //BC upgrade GUNREM01 -Blocked DIT Field
                                                                                   //   InsertGLEntry(GenJnlLine, GLEntry, TRUE);
                END;
            END;
        END;
        //HEI.31<<

        GLAcc.RESET; //HEI.22<<----To post one additional G/L entries and split the VAT amount when posting the purchase invoice
        IF GLAcc.GET(GenJnlLine."Account No.") THEN
            NonDeductiblePer := (GLEntryVATAmount * GLAcc."Non Deductible VAT % FND") / 100;
        // VAT for G / L entry / entries
        IF (GLEntryVATAmount <> 0) OR
           ((SrcCurrGLEntryVATAmt <> 0) AND (SrcCurrCode = AddCurrencyCode))
        THEN;
        // GLAcc.RESET; //HEI.22<<----To post one additional G/L entries and split the VAT amount when posting the purchase invoice //HEI.25 commented
    end;

    //BC UPGRADE ATHUKS01 FDDSTP_007<< Variabel changes 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforeCreateNormalVATGLEntries, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnBeforeCreateNormalVATGLEntries"(GenJournalLine: Record "Gen. Journal Line"; var VATPostingSetup: Record "VAT Posting Setup")
    var
        GLAcc: Record "G/L Account";
        GLEntryVATAmount: Decimal;
        SrcCurrGLEntryVATAmt: Decimal;
        UnrealizedVAT: Boolean;
    begin
        //HEI.22<< ---- Modified the below code
        //   {CreateGLEntry(GenJnlLine, VATPostingSetup.GetPurchAccount(UnrealizedVAT),
        //       GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE);}
        IF GLAcc.GET(GenJournalLine."Account No.") THEN BEGIN
            IF GLAcc."Non Deductible VAT % FND" > 0 THEN
                GenJnlPostline.CreateGLEntry(GenJournalLine, VATPostingSetup.GetPurchAccount(UnrealizedVAT),
                  GLEntryVATAmount - ROUND(NonDeductiblePer), SrcCurrGLEntryVATAmt, TRUE)
            ELSE
                GenJnlPostline.CreateGLEntry(GenJournalLine, VATPostingSetup.GetPurchAccount(UnrealizedVAT),
                   GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE);
        END ELSE
            GenJnlPostline.CreateGLEntry(GenJournalLine, VATPostingSetup.GetPurchAccount(UnrealizedVAT),
              GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE);
        //HEI.22>>
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnInsertVATOnBeforeCreateGLEntryForReverseChargeVATToPurchAcc, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnInsertVATOnBeforeCreateGLEntryForReverseChargeVATToPurchAcc"(var GenJournalLine: Record "Gen. Journal Line"; var VATPostingSetup: Record "VAT Posting Setup"; UnrealizedVAT: Boolean; VATAmount: Decimal; VATAmountAddCurr: Decimal; UseAmountAddCurr: Boolean)
    var
        GLAcc: Record "G/L Account";
        GLEntryVATAmount: Decimal;
        SrcCurrGLEntryVATAmt: Decimal;
        VATEntry: Record "VAT Entry";
    begin
        //HEI.22<< ---- Modified the below code
        // {CreateGLEntry(GenJnlLine,VATPostingSetup.GetPurchAccount(UnrealizedVAT),
        //     GLEntryVATAmount,SrcCurrGLEntryVATAmt,TRUE);}
        IF GLAcc.GET(GenJournalLine."Account No.") THEN BEGIN
            IF GLAcc."Non Deductible VAT % FND" > 0 THEN
                GenJnlPostline.CreateGLEntry(GenJournalLine, VATPostingSetup.GetPurchAccount(UnrealizedVAT),
                GLEntryVATAmount - ROUND(NonDeductiblePer), SrcCurrGLEntryVATAmt, TRUE)
            ELSE
                GenJnlPostline.CreateGLEntry(GenJournalLine, VATPostingSetup.GetPurchAccount(UnrealizedVAT),
                GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE);
        END ELSE
            GenJnlPostline.CreateGLEntry(GenJournalLine, VATPostingSetup.GetPurchAccount(UnrealizedVAT),
            GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE);
        //HEI.22>>
        //soicad>>
        IF GenJournalLine."Only VAT FND" THEN BEGIN
            VATEntry.GET(VATEntry."Entry No.");
            VATEntry."VAT Calculation Type" := VATEntry."VAT Calculation Type"::"Normal VAT";
            VATEntry."VAT Retention Base FND" := TRUE;
            VATEntry.MODIFY;
        END;
        //soicad<<
        //HEI.22<< ---- Modified the below code
        IF NOT GenJournalLine."Only VAT FND" THEN BEGIN//soicad
                                                       // {CreateGLEntry(GenJournalLine, VATPostingSetup.GetRevChargeAccount(UnrealizedVAT),
                                                       //     -GLEntryVATAmount, -SrcCurrGLEntryVATAmt, TRUE);}
            IF GLAcc.GET(GenJournalLine."Account No.") THEN BEGIN
                IF GLAcc."Non Deductible VAT % FND" > 0 THEN
                    GenJnlPostline.CreateGLEntry(GenJournalLine, VATPostingSetup.GetRevChargeAccount(UnrealizedVAT),
                      -GLEntryVATAmount - ROUND(NonDeductiblePer), -SrcCurrGLEntryVATAmt, TRUE)
                ELSE
                    GenJnlPostline.CreateGLEntry(GenJournalLine, VATPostingSetup.GetRevChargeAccount(UnrealizedVAT),
                   -GLEntryVATAmount, -SrcCurrGLEntryVATAmt, TRUE)
            END ELSE
                GenJnlPostline.CreateGLEntry(GenJournalLine, VATPostingSetup.GetRevChargeAccount(UnrealizedVAT),
                -GLEntryVATAmount, -SrcCurrGLEntryVATAmt, TRUE)
        END;
        //HEI.22>>
    end;
    //BC UPGRADE ATHUKS01 FDDSTP_007 >> Variabel changes
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPostFixedAssetOnBeforeInsertGLEntry, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnPostFixedAssetOnBeforeInsertGLEntry"(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var IsHandled: Boolean; var TempFAGLPostBuf: Record "FA G/L Posting Buffer" temporary; GLEntry2: Record "G/L Entry"; NextEntyNo: Integer; var TempGLEntryVATEntryLink: Record "G/L Entry - VAT Entry Link" temporary)
    begin
        //HEI.26>>
        GLEntry."Additional Description FND" := TempFAGLPostBuf."Additional Description FND";
        //HEI.26<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPostVendAfterTempDtldCVLedgEntryBufInit, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnPostVendAfterTempDtldCVLedgEntryBufInit"(var GenJnlLine: Record "Gen. Journal Line"; var TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer" temporary)
    begin
        //HEI.28<<
        // IF (WHTPostingSetup.GET(GenJnlLine."WHT Business Posting Group", GenJnlLine."WHT Product Posting Group")) AND
        //   (WHTPostingSetup."WHT %" <> 0) AND //HEI.32
        //    (GenJnlLine."Source Code" = SourceCodeSetup."Payment Journal Tree") AND (GLSetup."Enable WHT") AND (GLSetup."Round Amount for WHT Calc") THEN BEGIN
        //     TempDtldCVLedgEntryBuf.Amount := ROUND((TempDtldCVLedgEntryBuf.Amount - GenJnlPostline.ExchangeAmtLCYToFCY2(WHTAmount)), 1, '<');
        //     TempDtldCVLedgEntryBuf."Amount (LCY)" := ROUND((TempDtldCVLedgEntryBuf."Amount (LCY)" - WHTAmount), 1, '<');
        //     TempDtldCVLedgEntryBuf."Additional-Currency Amount" := ROUND(GenJnlLine.Amount, 1, '<');
        // END ELSE BEGIN//HEI.28>>
        //     TempDtldCVLedgEntryBuf.Amount := TempDtldCVLedgEntryBuf.Amount - GenJnlPostline.ExchangeAmtLCYToFCY2(WHTAmount);
        //     TempDtldCVLedgEntryBuf."Amount (LCY)" := TempDtldCVLedgEntryBuf."Amount (LCY)" - WHTAmountLCY;
        //     TempDtldCVLedgEntryBuf."Additional-Currency Amount" := GenJnlLine.Amount;
        // END; //HEI.28
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnApplyCustLedgerEntryOnBeforeSetCompleted, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnApplyCustLedgerEntryOnBeforeSetCompleted"(var GenJournalLine: Record "Gen. Journal Line"; var OldCustLedgEntry: Record "Cust. Ledger Entry"; var NewCVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; AppliedAmount: Decimal)
    begin
        //HEI.35>>
        // error mixed post from genJnl vs temp genJnl from salespost
        // exit after 1st payment
        //  IF GenJnlLine."Applies-to Doc. No." <> '' THEN
        IF (GenJnlLine."Applies-to Doc. No." <> '') AND (PmtTolAmtToBeAppliedHNK = 0) THEN;
        //HEI.35<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPrepareTempCustLedgEntryOnBeforeTestPositive, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnPrepareTempCustLedgEntryOnBeforeTestPositive"(var GenJournalLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    var
        OldCustLedgEntry: Record "Cust. Ledger Entry";
        SalesSetup: Record "Sales & Receivables Setup";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        RemainingAmount: Decimal;
        Result: Boolean;
        NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer";
        RelatedSONo: Code[20];
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        if GenJnlLine."Applies-to Doc. No." <> '' then begin
            // Find the entry to be applied to
            OldCustLedgEntry.Reset();
            OldCustLedgEntry.SetLoadFields(Positive, "Posting Date", "Currency Code");
            OldCustLedgEntry.SetCurrentKey("Document No.");
            //HEI.34>>
            CLEAR(RelatedSONo);
            RelatedSONo := CheckRelatedSOIsLinked(GenJnlLine."Applies-to Doc. No.", NewCVLedgEntryBuf."CV No.");
            IF RelatedSONo <> '' THEN
                OldCustLedgEntry.SETRANGE("Related Sales Order No. FND", RelatedSONo)
            ELSE
                //HEI.34<<
                OldCustLedgEntry.SetRange("Document No.", GenJnlLine."Applies-to Doc. No.");
            OldCustLedgEntry.SetRange("Document Type", GenJnlLine."Applies-to Doc. Type");
            OldCustLedgEntry.SetRange("Customer No.", NewCVLedgEntryBuf."CV No.");
            OldCustLedgEntry.SetRange(Open, true);
            OnPrepareTempCustLedgEntryOnAfterSetFilters(OldCustLedgEntry, GenJnlLine, NewCVLedgEntryBuf, NextEntryNo);
            OldCustLedgEntry.FindFirst();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforeCalcPmtTolerancePossible, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnBeforeCalcPmtTolerancePossible"(GenJnlLine: Record "Gen. Journal Line"; PmtDiscountDate: Date; var PmtDiscToleranceDate: Date; var MaxPaymentTolerance: Decimal; var IsHandled: Boolean)
    begin
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
        // WITH GenJnlLine DO
        //     IF "Document Type" IN ["Document Type"::Invoice, "Document Type"::"Credit Memo"] THEN BEGIN
        //         IF PmtDiscountDate <> 0D THEN
        //             PmtDiscToleranceDate :=
        //               CALCDATE(GLSetup."Payment Discount Grace Period", PmtDiscountDate)
        //         ELSE
        //             PmtDiscToleranceDate := PmtDiscountDate;

        //         CASE "Account Type" OF
        //             "Account Type"::Customer:
        //                 PaymentToleranceMgt.CalcMaxPmtTolerance(
        //                   "Document Type", "Currency Code", Amount, "Amount (LCY)", 1, MaxPaymentTolerance);
        //             "Account Type"::Vendor:
        //                 PaymentToleranceMgt.CalcMaxPmtTolerance(
        //                   "Document Type", "Currency Code", Amount, "Amount (LCY)", -1, MaxPaymentTolerance);
        //         END;
        //     END;
        //HEI.35>>
        IF GenJnlLine."Document Type" IN [GenJnlLine."Document Type"::Invoice, GenJnlLine."Document Type"::"Credit Memo"] THEN BEGIN
            IF PmtDiscountDate <> 0D THEN
                PmtDiscToleranceDate :=
                    CALCDATE(GLSetup."Payment Discount Grace Period", PmtDiscountDate)
            ELSE
                PmtDiscToleranceDate := PmtDiscountDate;

            CASE GenJnlLine."Account Type" OF
                GenJnlLine."Account Type"::Customer:
                    PaymentToleranceMgt.CalcMaxPmtTolerance(
                        GenJnlLine."Document Type", GenJnlLine."Currency Code", GenJnlLine.Amount, GenJnlLine."Amount (LCY)", 1, MaxPaymentTolerance);
                GenJnlLine."Account Type"::Vendor:
                    PaymentToleranceMgt.CalcMaxPmtTolerance(
                        GenJnlLine."Document Type", GenJnlLine."Currency Code", GenJnlLine.Amount, GenJnlLine."Amount (LCY)", -1, MaxPaymentTolerance);
            END;
        END;
        // BC Upgrade PATELP08 <<
        IF PmtTolAmtToBeAppliedHNK <> 0 THEN
            // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
            // WITH GenJnlLine DO
            //     CASE "Account Type" OF
            //         "Account Type"::Customer:
            //             MaxPaymentTolerance := PmtTolAmtToBeAppliedHNK;
            //         "Account Type"::Vendor:
            //             MaxPaymentTolerance := -PmtTolAmtToBeAppliedHNK;
            //     END;
            //HEI.35<<
            CASE GenJnlLine."Account Type" OF
                GenJnlLine."Account Type"::Customer:
                    MaxPaymentTolerance := PmtTolAmtToBeAppliedHNK;
                GenJnlLine."Account Type"::Vendor:
                    MaxPaymentTolerance := -PmtTolAmtToBeAppliedHNK;
            END;
        // BC Upgrade PATELP08 <<
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPostApplyOnAfterRecalculateAmounts, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnPostApplyOnAfterRecalculateAmounts"(var Sender: Codeunit "Gen. Jnl.-Post Line"; var OldCVLedgerEntryBuffer2: Record "CV Ledger Entry Buffer"; var OldCVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; var NewCVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; GenJournalLine: Record "Gen. Journal Line"; var DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; AddCurrencyCode: Code[10]; NextTransactionNo: Integer; var NextVATEntryNo: Integer)

    var
        OldCVLedgEntryBuf2: Record "CV Ledger Entry Buffer";
        OldCVLedgEntryBuf3: Record "CV Ledger Entry Buffer";
        OldRemainingAmtBeforeAppln: Decimal;
        ApplnRoundingPrecision: Decimal;
        AppliedAmountLCY: Decimal;
        LastPmtTol: Decimal;
        RunApplicationHNK: Boolean;
        RunLastPaymentHNK: Boolean;
        OldCVLedgEntryBuf9: Record "CV Ledger Entry Buffer";
        NewCVLedgEntryBuf9: Record "CV Ledger Entry Buffer";
        NewCVLedgEntryBuf3: Record "CV Ledger Entry Buffer";
        AppliedAmount2: Decimal;
        AppliedAmountLCY2: Decimal;
        OldAppliedAmount2: Decimal;
        TolRelatedSONo: Code[20];
        PmtTolAmtToBeApplied: Decimal;
        AppliedAmount: Decimal;
        OldAppliedAmount: Decimal;
        AllApplied: Boolean;
    begin
        //HEI.35>>
        IF PmtTolAmtToBeAppliedHNK <> 0 THEN BEGIN
            IF NOT Cust."Block Payment Tolerance" THEN
                //HEI.36>>
                IF CheckMultiplePaymentsForInvoice(OldCVLedgEntryBuf."Entry No.", TolRelatedSONo) THEN BEGIN
                    //HEI.36<<
                    IF PmtTolAmtToBeAppliedHNK <> 0 THEN
                        LastPmtTol := PmtTolAmtToBeAppliedHNK;
                    IF LastPmtTol <> 0 THEN BEGIN
                        //HEI.36>>
                        IF OldCVLedgEntryBuf."Entry No." = LastPaymentForInvoice(TolRelatedSONo) THEN BEGIN
                            //HEI.36<<
                            PmtTolAmtToBeAppliedHNK := LastPmtTol;
                            NewCVLedgEntryBuf."Accepted Payment Tolerance" := PmtTolAmtToBeAppliedHNK;
                            NewCVLedgEntryBuf9 := NewCVLedgEntryBuf;
                            NewCVLedgEntryBuf9.RecalculateAmounts(
                              NewCVLedgEntryBuf9."Currency Code", OldCVLedgEntryBuf."Currency Code", OldCVLedgEntryBuf."Posting Date");
                            NewCVLedgEntryBuf9.RecalculateAmountsHNK(
                              NewCVLedgEntryBuf9."Currency Code", OldCVLedgEntryBuf."Currency Code", OldCVLedgEntryBuf."Posting Date");
                            //HEI.36>>

                            CalcPmtDisc(NewCVLedgEntryBuf, OldCVLedgEntryBuf, OldCVLedgEntryBuf2, DtldCVLedgEntryBuf, GenJnlLine, PmtTolAmtToBeApplied, ApplnRoundingPrecision, NextTransactionNo, FirstNewVATEntryNo);
                            //HEI.36<<
                            RunApplicationHNK := TRUE;
                            RunLastPaymentHNK := TRUE;
                        END ELSE
                            RunApplicationHNK := TRUE;
                    END;
                END ELSE
                    IF PmtTolAmtToBeAppliedHNK <> 0 THEN BEGIN
                        NewCVLedgEntryBuf."Accepted Payment Tolerance" := PmtTolAmtToBeAppliedHNK;
                        NewCVLedgEntryBuf9 := NewCVLedgEntryBuf;
                        NewCVLedgEntryBuf9.RecalculateAmounts(
                           NewCVLedgEntryBuf9."Currency Code", OldCVLedgEntryBuf."Currency Code", OldCVLedgEntryBuf."Posting Date");
                        NewCVLedgEntryBuf9.RecalculateAmountsHNK(
                          NewCVLedgEntryBuf9."Currency Code", OldCVLedgEntryBuf."Currency Code", OldCVLedgEntryBuf."Posting Date");
                        //HEI.36>>
                        CalcPmtTolerance(
                          OldCVLedgEntryBuf, NewCVLedgEntryBuf, NewCVLedgEntryBuf9, DtldCVLedgEntryBuf, GenJnlLine,
                          PmtTolAmtToBeApplied, NextTransactionNo, FirstNewVATEntryNo);
                        //HEI.36<<
                        RunApplicationHNK := TRUE;
                        RunLastPaymentHNK := TRUE;
                    END;
        END ELSE
            IF NOT Cust."Block Payment Tolerance" THEN
                CalcPmtTolerance(
                  NewCVLedgEntryBuf, OldCVLedgEntryBuf, OldCVLedgEntryBuf2, DtldCVLedgEntryBuf, GenJnlLine,
                  PmtTolAmtToBeApplied, NextTransactionNo, FirstNewVATEntryNo);
        //HEI.35<<
        //HEI.35>>
        IF RunApplicationHNK THEN BEGIN
            // (newCV invoice)
            IF RunLastPaymentHNK THEN BEGIN
                IF CustLedgEntry2."Document Type" = CustLedgEntry2."Document Type"::Payment THEN BEGIN
                    IF CheckRem THEN
                        DtldCVLedgEntryBuf.InitDetailedCVLedgEntryBuf(
                          GenJnlLine, NewCVLedgEntryBuf, DtldCVLedgEntryBuf,
                          DtldCVLedgEntryBuf."Entry Type"::"Payment Discount",
                          -NewCVLedgEntryBuf."Remaining Pmt. Disc. Possible",
                          -NewCVLedgEntryBuf."Remaining Pmt. Disc. Possible",
                          -NewCVLedgEntryBuf."Remaining Pmt. Disc. Possible", 0, 0, 0);
                    CalcPmtDisc(
                      OldCVLedgEntryBuf, NewCVLedgEntryBuf, NewCVLedgEntryBuf, DtldCVLedgEntryBuf, GenJnlLine,
                      PmtTolAmtToBeApplied, ApplnRoundingPrecision, NextTransactionNo, FirstNewVATEntryNo);
                    CheckRem := TRUE;
                END ELSE
                    CalcPmtDisc(
                      NewCVLedgEntryBuf, OldCVLedgEntryBuf, OldCVLedgEntryBuf2, DtldCVLedgEntryBuf, GenJnlLine,
                      PmtTolAmtToBeApplied, ApplnRoundingPrecision, NextTransactionNo, FirstNewVATEntryNo);

                IF NOT Cust."Block Payment Tolerance" THEN
                    CalcPmtTolerance(
                      NewCVLedgEntryBuf, OldCVLedgEntryBuf, OldCVLedgEntryBuf2, DtldCVLedgEntryBuf, GenJnlLine,
                      PmtTolAmtToBeApplied, NextTransactionNo, FirstNewVATEntryNo);
            END;

            NewCVLedgEntryBuf9 := NewCVLedgEntryBuf;
            NewCVLedgEntryBuf.COPYFILTER(Positive, NewCVLedgEntryBuf9.Positive);
            ApplnRoundingPrecision := GetApplnRoundPrecision(OldCVLedgEntryBuf, NewCVLedgEntryBuf);

            NewCVLedgEntryBuf9.RecalculateAmounts(
              NewCVLedgEntryBuf9."Currency Code", OldCVLedgEntryBuf."Currency Code", OldCVLedgEntryBuf."Posting Date");
            NewCVLedgEntryBuf9.RecalculateAmountsHNK(
              NewCVLedgEntryBuf9."Currency Code", OldCVLedgEntryBuf."Currency Code", OldCVLedgEntryBuf."Posting Date");

            CalcCurrencyApplnRounding(
              OldCVLedgEntryBuf, NewCVLedgEntryBuf9, DtldCVLedgEntryBuf,
              GenJnlLine, ApplnRoundingPrecision);

            FindAmtForAppln(
              OldCVLedgEntryBuf, NewCVLedgEntryBuf, NewCVLedgEntryBuf9,
              AppliedAmount, AppliedAmountLCY, OldAppliedAmount, ApplnRoundingPrecision, GenJnlLine);

            IF RunLastPaymentHNK THEN BEGIN
                GenJnlPostline.CalcCurrencyUnrealizedGainLoss(
                       OldCVLedgEntryBuf, DtldCVLedgEntryBuf, GenJnlLine, -OldAppliedAmount, OldRemainingAmtBeforeAppln);

                CalcCurrencyRealizedGainLoss(
                      NewCVLedgEntryBuf, DtldCVLedgEntryBuf, GenJnlLine, -OldAppliedAmount, -AppliedAmountLCY);

                CalcCurrencyRealizedGainLoss(
                         OldCVLedgEntryBuf, DtldCVLedgEntryBuf, GenJnlLine, AppliedAmount, AppliedAmountLCY);
            END;

            CalcApplication(
              OldCVLedgEntryBuf, NewCVLedgEntryBuf, DtldCVLedgEntryBuf,
              GenJnlLine, AppliedAmount, AppliedAmountLCY, OldAppliedAmount,
              OldCVLedgEntryBuf3, NewCVLedgEntryBuf3, AllApplied);

            IF RunLastPaymentHNK THEN BEGIN
                FindAmtForAppln(
                  OldCVLedgEntryBuf, NewCVLedgEntryBuf, NewCVLedgEntryBuf9,
                  AppliedAmount, AppliedAmountLCY, OldAppliedAmount, ApplnRoundingPrecision, GenJnlLine);

                GenJnlPostline.CalcCurrencyUnrealizedGainLoss(
                     OldCVLedgEntryBuf, DtldCVLedgEntryBuf, GenJnlLine, -OldAppliedAmount, OldRemainingAmtBeforeAppln);

                NewCVLedgEntryBuf9 := NewCVLedgEntryBuf;
                NewCVLedgEntryBuf9."Entry No." := OldCVLedgEntryBuf."Entry No.";
                CalcCurrencyRealizedGainLossHNK(
                  NewCVLedgEntryBuf9, DtldCVLedgEntryBuf, GenJnlLine, -OldAppliedAmount, -AppliedAmountLCY);

                OldCVLedgEntryBuf9 := OldCVLedgEntryBuf;
                OldCVLedgEntryBuf9."Entry No." := NewCVLedgEntryBuf."Entry No.";
                CalcCurrencyRealizedGainLossHNK(
                  OldCVLedgEntryBuf9, DtldCVLedgEntryBuf, GenJnlLine, AppliedAmount, AppliedAmountLCY);

                PaymentToleranceMgt.CalcRemainingPmtDisc(NewCVLedgEntryBuf, OldCVLedgEntryBuf, OldCVLedgEntryBuf2, GLSetup);
                GenJnlPostline.CalcAmtLCYAdjustment(NewCVLedgEntryBuf, DtldCVLedgEntryBuf, GenJnlLine);
            END;
            EXIT;
        END;
        //HEI.35<<

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnInitGLEntryOnBeforeCheckGLAccountBlocked, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnInitGLEntryOnBeforeCheckGLAccountBlocked"(GenJournalLine: Record "Gen. Journal Line"; GLAccount: Record "G/L Account"; var IsHandled: Boolean)
    var
        FinancialUtils: Codeunit "Financial-Utils";
    begin
        //HEI.39>>
        FinancialUtils.InsertDim2SkipDimCheck4SrcCodeWithSkip(GenJournalLine, GLAccount."No.");
        //HEI.39<<
    end;

    //Bc Upgrade YADAVM09 code added in Levy>>
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforeInsertVAT, '', false, false)]
    // local procedure "Gen. Jnl.-Post Line_OnBeforeInsertVAT"(var GenJournalLine: Record "Gen. Journal Line"; var VATEntry: Record "VAT Entry"; var UnrealizedVAT: Boolean; var AddCurrencyCode: Code[10]; var VATPostingSetup: Record "VAT Posting Setup"; var GLEntryAmount: Decimal; var GLEntryVATAmount: Decimal; var GLEntryBaseAmount: Decimal; var SrcCurrCode: Code[10]; var SrcCurrGLEntryAmt: Decimal; var SrcCurrGLEntryVATAmt: Decimal; var SrcCurrGLEntryBaseAmt: Decimal; var IsHandled: Boolean)
    // begin
    //     //HEI.42>>
    //     PurchasesPayablesSetup.GET;
    //     IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Credit Memo" THEN
    //         GenJournalLine."H&S Levy Tax Amount FND" := -GenJournalLine."H&S Levy Tax Amount FND";
    //     IF PurchasesPayablesSetup."H&S Levy Tax FND" THEN;
    //     //     GenJnlPostline.InsertVAT(
    //     //         GenJnlLine, VATPostingSetup,
    //     //         GLEntry.Amount, GLEntry."VAT Amount", GenJournalLine."VAT Base Amount (LCY)" + GenJournalLine."H&S Levy Tax Amount FND", GenJournalLine."Source Currency Code",
    //     //         GLEntry."Additional-Currency Amount", AddCurrGLEntryVATAmt, GenJournalLine."Source Curr. VAT Base Amount")//HEI.42
    //     // ELSE
    //     //HEI.42<<
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnMoveGenJournalLine, '', false, false)]
    // local procedure "Gen. Jnl.-Post Line_OnMoveGenJournalLine"(var GenJournalLine: Record "Gen. Journal Line"; ToRecordID: RecordId)
    // begin
    //     //HEI.42>>
    //     PurchasesPayablesSetup.GET;
    //     IF PurchasesPayablesSetup."H&S Levy Tax FND" THEN
    //         IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::Invoice THEN BEGIN
    //             IF (GenJournalLine."H&S Levy Tax Amount FND" <> 0) AND (GenJournalLine.Amount <> 0) THEN BEGIN
    //                 HSTaxPostingSetup.GET(GenJnlLine."HS Posting Group FND");//HEI.44
    //                 IF HSTaxPostingSetup."Purchase H&S Tax Account" = '' THEN
    //                     ERROR(Text50000, HSTaxPostingSetup."H&S Tax Posting Group");
    //                 GenJnlPostline.CreateGLEntry(GenJnlLine, HSTaxPostingSetup."Purchase H&S Tax Account", ROUND(GenJournalLine."H&S Levy Tax Amount FND"), ROUND(GenJournalLine."H&S Levy Tax Amount FND"), TRUE);
    //             END;
    //         END ELSE IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Credit Memo" THEN BEGIN
    //             IF (GenJournalLine."H&S Levy Tax Amount FND" <> 0) AND (GenJournalLine.Amount <> 0) THEN BEGIN
    //                 HSTaxPostingSetup.GET(GenJnlLine."HS Posting Group FND");//HEI.44
    //                 IF HSTaxPostingSetup."Purchase H&S Tax Account" = '' THEN
    //                     ERROR(Text50000, HSTaxPostingSetup."H&S Tax Posting Group");
    //                 GenJnlPostline.CreateGLEntry(GenJnlLine, HSTaxPostingSetup."Purchase H&S Tax Account", ROUND(-GenJournalLine."H&S Levy Tax Amount FND"), ROUND(-GenJournalLine."H&S Levy Tax Amount FND"), TRUE);
    //             END;
    //         END;
    //     //HEI.42<<
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterPostVAT, '', false, false)]
    // local procedure "Gen. Jnl.-Post Line_OnAfterPostVAT"(var Sender: Codeunit "Gen. Jnl.-Post Line"; GenJnlLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; VATPostingSetup: Record "VAT Posting Setup"; var TaxDetail: Record "Tax Detail"; var NextConnectionNo: Integer; var AddCurrGLEntryVATAmt: Decimal; AddCurrencyCode: Code[10]; UseCurrFactorOnly: Boolean)
    // begin
    //     //HEI.42>>
    //     PurchasesPayablesSetup.GET;
    //     IF PurchasesPayablesSetup."H&S Levy Tax FND" THEN
    //         IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::Invoice THEN BEGIN
    //             IF (GenJnlLine."H&S Levy Tax Amount FND" <> 0) THEN BEGIN
    //                 HSTaxPostingSetup.GET(GenJnlLine."HS Posting Group FND");//HEI.44
    //                 IF HSTaxPostingSetup."Purchase H&S Tax Account" = '' THEN
    //                     ERROR(Text50000, HSTaxPostingSetup."H&S Tax Posting Group");
    //                 GenJnlPostline.CreateGLEntry(GenJnlLine, HSTaxPostingSetup."Purchase H&S Tax Account", ROUND(GLEntry."H&S Levy Tax Amount FND"), ROUND(GLEntry."H&S Levy Tax Amount FND"), TRUE);
    //             END;
    //         END ELSE IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Credit Memo" THEN BEGIN
    //             IF (GenJnlLine."H&S Levy Tax Amount FND" <> 0) THEN BEGIN
    //                 HSTaxPostingSetup.GET(GenJnlLine."HS Posting Group FND");
    //                 IF HSTaxPostingSetup."Purchase H&S Tax Account" = '' THEN //HEI.44
    //                     ERROR(Text50000, HSTaxPostingSetup."H&S Tax Posting Group");
    //                 GenJnlPostline.CreateGLEntry(GenJnlLine, HSTaxPostingSetup."Purchase H&S Tax Account", ROUND(-GLEntry."H&S Levy Tax Amount FND"), ROUND(-GLEntry."H&S Levy Tax Amount FND"), TRUE);
    //             END;
    //         END;
    //     //HEI.42<<
    // end;
    //Bc Upgrade YADAVM09 code added in Levy<<


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPostDtldCustLedgEntriesOnBeforePostDtldCustLedgEntry, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnPostDtldCustLedgEntriesOnBeforePostDtldCustLedgEntry"(var Sender: Codeunit "Gen. Jnl.-Post Line"; var DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; AddCurrencyCode: Code[10]; var GenJnlLine: Record "Gen. Journal Line"; CustPostingGr: Record "Customer Posting Group"; AdjAmount: array[4] of Decimal; var IsHandled: Boolean; var NextEntryNo: Integer; DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; LedgEntryInserted: Boolean)
    begin
        UpdateUnrealizRealizLossGainInfoInGenJnlLine(GenJnlLine, DtldCVLedgEntryBuf, 2, DetailedCustLedgEntry."Entry No."); //HEI.43

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPostDtldVendLedgEntriesOnBeforePostDtldVendLedgEntry, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnPostDtldVendLedgEntriesOnBeforePostDtldVendLedgEntry"(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJnlLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; VendPostingGr: Record "Vendor Posting Group"; AdjAmount: array[4] of Decimal; var IsHandled: Boolean; LedgEntryInserted: Boolean)
    begin
        UpdateUnrealizRealizLossGainInfoInGenJnlLine(GenJnlLine, DtldCVLedgEntryBuf, 3, DtldCVLedgEntryBuf."Entry No."); //HEI.43
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforePostDtldCustLedgEntryUnapply, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnBeforePostDtldCustLedgEntryUnapply"(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJournalLine: Record "Gen. Journal Line"; var DetailedCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; CustPostingGroup: Record "Customer Posting Group"; OriginalTransactionNo: Integer; var IsHandled: Boolean)
    begin
        UpdateUnrealizRealizLossGainInfoInGenJnlLine(GenJnlLine, DetailedCVLedgEntryBuffer, 2, DetailedCVLedgEntryBuffer."Entry No."); //HEI.43
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforePostDtldVendLedgEntryUnapply, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnBeforePostDtldVendLedgEntryUnapply"(var Sender: Codeunit "Gen. Jnl.-Post Line"; GenJournalLine: Record "Gen. Journal Line"; DetailedCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; VendPostingGr: Record "Vendor Posting Group"; OriginalTransactionNo: Integer; var IsHandled: Boolean)
    begin
        UpdateUnrealizRealizLossGainInfoInGenJnlLine(GenJnlLine, DetailedCVLedgEntryBuffer, 3, DetailedCVLedgEntryBuffer."Entry No."); //HEI.43
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterInitGLRegister, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnAfterInitGLRegister"(var GLRegister: Record "G/L Register"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GLRegister."Journal Template Name FND" := GenJournalLine."Journal Template Name";//HEI.45
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterInitGLEntry, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnAfterInitGLEntry"(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line"; Amount: Decimal; AddCurrAmount: Decimal; UseAddCurrAmount: Boolean; var CurrencyFactor: Decimal; var GLRegister: Record "G/L Register")
    begin
        FinancialUtils.OnBeforeInsertGLEntry(GenJnlLine, GLEntry);//HEI.01
    end;

    [EventSubscriber(ObjectType::Table, Database::Currency, OnBeforeGetGainLossAccount, '', false, false)]
    local procedure Currency_OnBeforeGetGainLossAccount(var Currency: Record Currency; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer")
    var

        GenPostingSetup: Record "General Posting Setup";
        AmountCondition: Boolean;
        SourceType: Option ,Customer,Vendor;
    begin
        //HEI.41>>
        IF (GLSetup."Enable GT FX FND" = TRUE) THEN
            Currency.GetGainLossAccountFX(DtldCVLedgEntryBuffer, SourceType::Customer)
        else
            ;
        //HEI.41<<
    end;

    //BC Upgrade GUNREM01 Codeunit 12 "Gen. Jnl.-Post Line" >>

    //BC Upgrade GUNREM01 Codeunit 12 "Gen. Jnl.-Post Line" Custom Functions >>
    //Bc Upgrade YADAVM09 BCUP0-200>>
    // procedure FAGAAPPosting(GenJnlLine: Record "Gen. Journal Line"; "FALedgerPostingCategory": Enum "FA Ledger Posting Category"; Amount: Decimal;
    //                                                                                                  TempGLEntry: Record "G/L Entry";
    //                                                                                                  FAPostingGroup: Code[10];
    //                                                                                                  FAPostingType: Enum "FA Ledger Entry FA Posting Type";
    //                                                                                                  DepBook: Code[10])
    // var
    //     DepreciationBook: Record "Depreciation Book";
    //     FASetup: record "FA Posting Group";
    // begin
    //     //>>HEI.06
    //     DepreciationBook.GET(DepBook);
    //     IF DepreciationBook."Disposal Calculation Method" = DepreciationBook."Disposal Calculation Method"::Gross THEN EXIT;
    //     FASetup.GET(FAPostingGroup);
    //     CASE FAPostingType OF
    //         FAPostingType::Depreciation:
    //             BEGIN
    //                 IF DepreciationBook."Part of Duplication List" THEN BEGIN
    //                     FASetup.TESTFIELD(FASetup."Accum. Dep. Account Offset FND");
    //                     FASetup.TESTFIELD(FASetup."Dep. Expense Acc Offset FND");
    //                     //>>HEI.08
    //                     FASetup.TESTFIELD(FASetup."Acqi.CostAcc.Dsposl Offset FND");
    //                     //<<HEI.08
    //                 END;

    //                 IF (FASetup."Accum. Dep. Account Offset FND" <> '') OR (FASetup."Dep. Expense Acc Offset FND" <> '') THEN BEGIN
    //                     FASetup.TESTFIELD(FASetup."Accum. Dep. Account Offset FND");
    //                     FASetup.TESTFIELD(FASetup."Dep. Expense Acc Offset FND");

    //                     GenJnlPostline.InitGLEntry(GenJnlLine, GLEntry, FASetup."Accum. Dep. Account Offset FND", -1 * Amount, GLEntry."Additional-Currency Amount", TRUE, TRUE);
    //                     InitFACommonFields(GLEntry);
    //                     GenJnlPostline.InsertGLEntry(GenJnlLine, GLEntry, TRUE);
    //                     IF FALedgerPostingCategory = FALedgerPostingCategory::" " THEN BEGIN
    //                         GenJnlPostline.InitGLEntry(GenJnlLine, GLEntry, FASetup."Dep. Expense Acc Offset FND", Amount, GLEntry."Additional-Currency Amount", TRUE, TRUE);
    //                         InitFACommonFields(GLEntry);
    //                         GenJnlPostline.InsertGLEntry(GenJnlLine, GLEntry, TRUE);
    //                     END;
    //                     //>>HEI.08
    //                     //HEI.30 commented
    //                     //   { IF FAPostingCategory=FAPostingCategory::Disposal THEN BEGIN
    //                     //       InitGLEntry(GenJnlLine,GLEntry,FASetup."Acqi.Cost Acc. Disposal Offset", -1 * TempGLEntry.Amount, TempGLEntry."Additional-Currency Amount",TRUE,TRUE);
    //                     //       InitFACommonFields(GLEntry);
    //                     //       InsertGLEntry(GenJnlLine,GLEntry,TRUE);
    //                     //      END; }
    //                     //<<HEI.08
    //                     //HEI.30 commented
    //                 END;
    //             END;

    //         FAPostingType::"Gain/Loss":
    //             BEGIN
    //                 IF GenJnlLine."FA Posting Type" <> GenJnlLine."FA Posting Type"::Depreciation THEN BEGIN
    //                     IF DepreciationBook."Part of Duplication List" THEN BEGIN
    //                         FASetup.TESTFIELD(FASetup."GainAcc.on Disposal Offset FND");
    //                         FASetup.TESTFIELD(FASetup."SaleBal.Acc.on Disp.Offset FND");
    //                         FASetup.TESTFIELD(FASetup."Losses Acc. on Disp. Off FND");
    //                     END;
    //                     IF (FASetup."GainAcc.on Disposal Offset FND" <> '') OR (FASetup."SaleBal.Acc.on Disp.Offset FND" <> '')
    //                       OR (FASetup."Losses Acc. on Disp. Off FND" <> '') THEN BEGIN
    //                         FASetup.TESTFIELD(FASetup."GainAcc.on Disposal Offset FND");
    //                         FASetup.TESTFIELD(FASetup."SaleBal.Acc.on Disp.Offset FND");
    //                         FASetup.TESTFIELD(FASetup."Losses Acc. on Disp. Off FND");
    //                         IF Amount < 0 THEN BEGIN
    //                             GenJnlPostline.InitGLEntry(GenJnlLine, GLEntry, FASetup."GainAcc.on Disposal Offset FND", -1 * Amount, GLEntry."Additional-Currency Amount", TRUE, TRUE);
    //                             //BRM InitFACommonFields(GLEntry);
    //                             //BRM InsertGLEntry(GenJnlLine,GLEntry,TRUE);
    //                         END
    //                         ELSE
    //                             GenJnlPostline.InitGLEntry(GenJnlLine, GLEntry, FASetup."Losses Acc. on Disp. Off FND", -1 * Amount, GLEntry."Additional-Currency Amount", TRUE, TRUE);
    //                         InitFACommonFields(GLEntry);
    //                         GenJnlPostline.InsertGLEntry(GenJnlLine, GLEntry, TRUE);
    //                         //HEI.30 commented<<
    //                         //>>HEI.29
    //                         // {  IF GenJnlLine.Amount = 0 THEN
    //                         //     InitGLEntry(GenJnlLine, GLEntry, FASetup."Sales Bal.Acc. on Disp. Offset", Amount, GLEntry."Additional-Currency Amount",TRUE,TRUE)
    //                         //   ELSE IF  GenJnlLine.Amount <> 0 THEN }
    //                         //<<HEI.29
    //                         //HEI.30 commented>>
    //                         //HEI.08 comment line InitGLEntry(GenJnlLine,GLEntry,FASetup."Sales Bal.Acc. on Disp. Offset",Amount,GLEntry."Additional-Currency Amount",TRUE,TRUE);
    //                         //>>HEI.08
    //                         GenJnlPostline.InitGLEntry(GenJnlLine, GLEntry, FASetup."SaleBal.Acc.on Disp.Offset FND", GenJnlLine.Amount, GLEntry."Additional-Currency Amount", TRUE, TRUE);
    //                         //<<HEI.08
    //                         InitFACommonFields(GLEntry);
    //                         GenJnlPostline.InsertGLEntry(GenJnlLine, GLEntry, TRUE);
    //                     END;
    //                 END;
    //             END;
    //         FAPostingType::"Acquisition Cost":
    //             BEGIN
    //                 //for acquisitions use the BASE solution
    //                 //uncommented HEI.30<<
    //                 IF FALedgerPostingCategory <> FALedgerPostingCategory::" " THEN BEGIN
    //                     IF (FASetup."Acqi.CostAcc.Dsposl Offset FND" <> '') THEN BEGIN
    //                         FASetup.TESTFIELD(FASetup."Acqi.CostAcc.Dsposl Offset FND");
    //                         GenJnlPostline.InitGLEntry(GenJnlLine, GLEntry, FASetup."Acqi.CostAcc.Dsposl Offset FND", -1 * Amount, GLEntry."Additional-Currency Amount", TRUE, TRUE);
    //                         InitFACommonFields(GLEntry);
    //                         GenJnlPostline.InsertGLEntry(GenJnlLine, GLEntry, TRUE);
    //                     END;
    //                 END;
    //                 //uncommented HEI.30>>
    //             END;

    //         //HEI.30<<
    //         FAPostingType::"Write-Down":
    //             BEGIN
    //                 IF FALedgerPostingCategory = FALedgerPostingCategory::Disposal THEN
    //                     IF (FASetup."Write-Down Bal. Acc. on Disp." <> '') THEN BEGIN
    //                         FASetup.TESTFIELD("Write-Down Bal. Acc. on Disp.");
    //                         GenJnlPostline.InitGLEntry(GenJnlLine, GLEntry, FASetup."Write-Down Bal. Acc. on Disp.", -1 * Amount, GLEntry."Additional-Currency Amount", TRUE, TRUE);
    //                         InitFACommonFields(GLEntry);
    //                         GenJnlPostline.InsertGLEntry(GenJnlLine, GLEntry, TRUE);
    //                     END;
    //             END;
    //     //HEI.30>>
    //     END;
    //     //<<HEI.06
    // end;

    // procedure InitFACommonFields(TempGLEntry: Record "G/L Entry")
    // begin
    //     //>>HEI.06
    //     GLEntry."Gen. Posting Type" := TempGLEntry."Gen. Posting Type";
    //     GLEntry."Gen. Bus. Posting Group" := TempGLEntry."Gen. Bus. Posting Group";
    //     GLEntry."Gen. Prod. Posting Group" := TempGLEntry."Gen. Prod. Posting Group";
    //     GLEntry."VAT Bus. Posting Group" := TempGLEntry."VAT Bus. Posting Group";
    //     GLEntry."VAT Prod. Posting Group" := TempGLEntry."VAT Prod. Posting Group";
    //     GLEntry."Tax Area Code" := TempGLEntry."Tax Area Code";
    //     GLEntry."Tax Liable" := TempGLEntry."Tax Liable";
    //     GLEntry."Tax Group Code" := TempGLEntry."Tax Group Code";
    //     GLEntry."Use Tax" := TempGLEntry."Use Tax";
    //     GLEntry."VAT Amount" := TempGLEntry."VAT Amount";
    // end;
    // //<<HEI.06

    // LOCAL procedure GetAmountLCY(GenJournalLine: Record "Gen. Journal Line"): Decimal
    // begin
    //     //HEI.10>>
    //     //GetCurrency;
    //     IF GenJournalLine."Currency Code" = '' THEN
    //         EXIT(GenJournalLine.Amount)
    //     ELSE
    //         EXIT(ROUND(
    //             CurrExchRate.ExchangeAmtFCYToLCY(
    //               GenJournalLine."Posting Date", GenJournalLine."Currency Code",
    //               GenJournalLine.Amount, GenJournalLine."Currency Factor")));
    //     //HEI.10<<
    // end;
    //Bc Upgrade YADAVM09 BCUP0-200<<

    procedure IsCustAcc(GenJnlLine: Record "Gen. Journal Line"): Boolean
    begin
        // WITH GenJnlLine DO
        EXIT((GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer) OR (GenJnlLine."Bal. Account Type" = GenJnlLine."Account Type"::Customer));
    end;

    procedure IsVendAcc(GenJnlLine: Record "Gen. Journal Line"): Boolean
    begin
        //    WITH GenJnlLine DO
        EXIT((GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor) OR (GenJnlLine."Bal. Account Type" = GenJnlLine."Account Type"::Vendor));
    end;

    procedure IsPaymentOrRefund(GenJnlLine: Record "Gen. Journal Line"): Boolean
    begin
        // WITH GenJnlLine DO
        EXIT(GenJnlLine."Document Type" IN [GenJnlLine."Document Type"::Payment, GenJnlLine."Document Type"::Refund]);
    end;

    LOCAL procedure CreateGLEntry1(GenJnlLine: Record "Gen. Journal Line"; AccNo: Code[20]; Amount: Decimal; AmountAddCurr: Decimal; UseAmountAddCurr: Boolean)
    begin
        IF UseAmountAddCurr THEN
            InitGLEntry1(GenJnlLine, GLEntry, AccNo, Amount, AmountAddCurr, TRUE, TRUE)
        ELSE BEGIN
            InitGLEntry1(GenJnlLine, GLEntry, AccNo, Amount, 0, FALSE, TRUE);
            GLEntry."Additional-Currency Amount" := AmountAddCurr;
        END;
        GenJnlPostline.InsertGLEntry(GenJnlLine, GLEntry, TRUE);
        //HEI.22>>
    end;

    LOCAL procedure InitGLEntry1(GenJnlLine: Record "Gen. Journal Line"; VAR GLEntry: Record "G/L Entry"; GLAccNo: Code[20]; Amount: Decimal; AmountAddCurr: Decimal; UseAmountAddCurr: Boolean; SystemCreatedEntry: Boolean)
    var

        GLAcc: Record "G/L Account";
        FinancialUtils: Codeunit "Financial-Utils";
        GLAccount2: Record "G/L Account";
        lDimensionSetEntry: Record "Dimension Set Entry";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";

    begin
        //HEI.22<<----To post one additional G/L entries and split the VAT amount when posting the purchase invoice
        IF GLAccNo <> '' THEN BEGIN
            IF GLAcc.GET(GLAccNo) THEN;
            GLAcc.TESTFIELD(Blocked, FALSE);
            GLAcc.TESTFIELD("Account Type", GLAcc."Account Type"::Posting);

            // Check the Value Posting field on the G/L Account if it is not checked already in Codeunit 11
            IF (NOT
                  ((GLAccNo = GenJnlLine."Account No.") AND
                   (GenJnlLine."Account Type" = GenJnlLine."Account Type"::"G/L Account")) OR
                  ((GLAccNo = GenJnlLine."Bal. Account No.") AND
                   (GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::"G/L Account"))) AND
               NOT FADimAlreadyChecked

            THEN
                GenJnlPostline.CheckGLAccDimError(GenJnlLine, GLAccNo);
        END;

        GLEntry.INIT;
        CompanyInfo.GET;
        //BC Upgrade GUNREM01 -Blocked FR localization >>
        // IF CompanyInfo."Enable French Localization" THEN
        //     GLEntry."Entry Type" := EntryType;
        //BC Upgrade GUNREM01 -Blocked FR localization << 
        GLEntry.CopyFromGenJnlLine(GenJnlLine);
        GLEntry."Entry No." := NextEntryNo;
        GLEntry."Transaction No." := NextTransactionNo;
        GLEntry."G/L Account No." := GLAccNo;
        GLEntry."Gen. Posting Type" := GenJnlLine."Gen. Posting Type";
        GLEntry."Gen. Bus. Posting Group" := GenJnlLine."Gen. Bus. Posting Group";
        GLEntry."Gen. Prod. Posting Group" := GenJnlLine."Gen. Prod. Posting Group";
        GLEntry.Comment := GenJnlLine.Comment;
        GLEntry."MR Code FND" := GLAcc."MR Code FND";
        IF GenJnlLine."Source Currency Code" <> '' THEN BEGIN
            IF GenJnlLine."Account Type" = GenJnlLine."Account Type"::"G/L Account" THEN BEGIN
                //HEI.23 commented begin <<
                // IF VATPosting THEN
                //  GLEntry."Source Currency Amount" := GenJnlLine."Source Curr. VAT Amount"
                // ELSE
                // GLEntry."Source Currency Amount" := GenJnlLine."Source Curr. VAT Base Amount";
                //HEI.23 commented end >>
                GLEntry."Source Currency Amount" := GenJnlLine."Source Curr. VAT Amount" * GLAcc."Non Deductible VAT % FND" / 100; //HEI.23
            END ELSE
                GLEntry."Source Currency Amount" := GenJnlLine."Source Currency Amount";

            IF GLEntry."Source Currency Amount" <> 0 THEN
                GLEntry."Currency Code FND" := GenJnlLine."Source Currency Code";
        END;

        GLEntry."Interface Code FND" := GenJnlLine."Interface Code FND";
        GLEntry."CP Vendor Invoice No. FND" := GenJnlLine."CP Vendor Invoice No. FND";
        GLEntry."System-Created Entry" := SystemCreatedEntry;
        GLEntry.Amount := Amount;

        GLEntry."Additional-Currency Amount" :=
       GenJnlPostline.GLCalcAddCurrency(Amount, AmountAddCurr, GLEntry."Additional-Currency Amount", UseAmountAddCurr, GenJnlLine);
        FinancialUtils.OnBeforeInsertGLEntry(GenJnlLine, GLEntry);
        //HEI.22>>
    end;


    procedure PostDelayedUnrealizedVAT(GenJnlLine: Record "Gen. Journal Line")
    var
        OldCustLedgEntry: Record "Cust. Ledger Entry";
        OldVendLedgEntry: Record "Vendor Ledger Entry";
    begin
        //HEI.17>>
        CompanyInfo.GET;
        IF NOT CompanyInfo."Enable French Localization FND" THEN
            EXIT;

        CASE GenJnlLine."Source Type" OF
            GenJnlLine."Source Type"::Customer:
                IF GenJnlLine."Applies-to Doc. No." <> '' THEN BEGIN
                    // Find original entry based on Applies-to Doc. No.
                    OldCustLedgEntry.RESET;
                    OldCustLedgEntry.SETCURRENTKEY("Document No.");
                    OldCustLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                    OldCustLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                    OldCustLedgEntry.SETRANGE("Customer No.", GenJnlLine."Source No.");
                    OldCustLedgEntry.FINDFIRST;
                    OldCustLedgEntry.CALCFIELDS(
                      Amount, "Amount (LCY)", "Remaining Amount", "Remaining Amt. (LCY)",
                      "Original Amount", "Original Amt. (LCY)");
                    //  GenJnlLine.SetTransactionNo(GenJnlLine);
                    //BC Upgrade GUNREM01 -Blocked Dependency with DIT Table
                    //     UnrealCVLedgEntryBuffer.RESET;
                    //     UnrealCVLedgEntryBuffer.SETRANGE("Account Type", UnrealCVLedgEntryBuffer."Account Type"::Customer);
                    //     UnrealCVLedgEntryBuffer.SETRANGE("Account No.", GenJnlLine."Source No.");
                    //     IF CheckHeaderNo(GenJnlLine."Document No.") THEN
                    //         UnrealCVLedgEntryBuffer.SETRANGE("Payment Slip No.", GenJnlLine."Created from No.")
                    //     ELSE
                    //         UnrealCVLedgEntryBuffer.SETRANGE("Payment Slip No.", GenJnlLine."Document No.");
                    //     UnrealCVLedgEntryBuffer.FINDFIRST;
                    //     CustUnrealizedVAT(GenJnlLine, OldCustLedgEntry, GenJnlLine.Amount);
                    //     UnrealCVLedgEntryBuffer.Realized := TRUE;
                    //     UnrealCVLedgEntryBuffer.MODIFY;
                    //     UpdateUnrealCVLedgEntryBuffer(GenJnlLine, OldCustLedgEntry."Transaction No.");
                    // END ELSE BEGIN
                    //     // Find original entry from buffer table
                    //     UnrealCVLedgEntryBuffer.RESET;
                    //     UnrealCVLedgEntryBuffer.SETRANGE("Account Type", UnrealCVLedgEntryBuffer."Account Type"::Customer);
                    //     UnrealCVLedgEntryBuffer.SETRANGE("Account No.", GenJnlLine."Source No.");
                    //     IF CheckHeaderNo(GenJnlLine."Document No.") THEN
                    //         UnrealCVLedgEntryBuffer.SETRANGE("Payment Slip No.", GenJnlLine."Created from No.")
                    //     ELSE
                    //         UnrealCVLedgEntryBuffer.SETRANGE("Payment Slip No.", GenJnlLine."Document No.");
                    //     UnrealCVLedgEntryBuffer.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                    //     IF UnrealCVLedgEntryBuffer.FINDSET(TRUE, FALSE) THEN
                    //         REPEAT
                    //             OldCustLedgEntry.GET(UnrealCVLedgEntryBuffer."Entry No.");
                    //             OldCustLedgEntry.CALCFIELDS(
                    //               Amount, "Amount (LCY)", "Remaining Amount", "Remaining Amt. (LCY)",
                    //               "Original Amount", "Original Amt. (LCY)");
                    //             SetTransactionNo(GenJnlLine);
                    //             CustUnrealizedVAT(GenJnlLine, OldCustLedgEntry, UnrealCVLedgEntryBuffer."Applied Amount");
                    //             UnrealCVLedgEntryBuffer.Realized := TRUE;
                    //             UnrealCVLedgEntryBuffer.MODIFY;
                    //             UpdateUnrealCVLedgEntryBuffer(GenJnlLine, OldCustLedgEntry."Transaction No.");
                    //         UNTIL UnrealCVLedgEntryBuffer.NEXT = 0;
                END;
            GenJnlLine."Source Type"::Vendor:
                IF GenJnlLine."Applies-to Doc. No." <> '' THEN BEGIN
                    // Find original entry based on Applies-to Doc. No.
                    OldVendLedgEntry.RESET;
                    OldVendLedgEntry.SETCURRENTKEY("Document No.");
                    OldVendLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                    OldVendLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                    OldVendLedgEntry.SETRANGE("Vendor No.", GenJnlLine."Source No.");
                    OldVendLedgEntry.FINDFIRST;
                    OldVendLedgEntry.CALCFIELDS(
                      Amount, "Amount (LCY)", "Remaining Amount", "Remaining Amt. (LCY)",
                      "Original Amount", "Original Amt. (LCY)");
                    //  SetTransactionNo(GenJnlLine);
                    //     UnrealCVLedgEntryBuffer.RESET;
                    //     UnrealCVLedgEntryBuffer.SETRANGE("Account Type", UnrealCVLedgEntryBuffer."Account Type"::Vendor);
                    //     UnrealCVLedgEntryBuffer.SETRANGE("Account No.", GenJnlLine."Source No.");
                    //     IF CheckHeaderNo(GenJnlLine."Document No.") THEN
                    //         UnrealCVLedgEntryBuffer.SETRANGE("Payment Slip No.", GenJnlLine."Created from No.")
                    //     ELSE
                    //         UnrealCVLedgEntryBuffer.SETRANGE("Payment Slip No.", GenJnlLine."Document No.");
                    //     UnrealCVLedgEntryBuffer.FINDFIRST;
                    //     VendUnrealizedVAT(GenJnlLine, OldVendLedgEntry, GenJnlLine.Amount);
                    //     UnrealCVLedgEntryBuffer.Realized := TRUE;
                    //     UnrealCVLedgEntryBuffer.MODIFY;
                    //     UpdateUnrealCVLedgEntryBuffer(GenJnlLine, OldVendLedgEntry."Transaction No.");
                    // END ELSE BEGIN
                    //     // Find original entry from buffer table
                    //     UnrealCVLedgEntryBuffer.RESET;
                    //     UnrealCVLedgEntryBuffer.SETRANGE("Account Type", UnrealCVLedgEntryBuffer."Account Type"::Vendor);
                    //     UnrealCVLedgEntryBuffer.SETRANGE("Account No.", GenJnlLine."Source No.");
                    //     IF CheckHeaderNo(GenJnlLine."Document No.") THEN
                    //         UnrealCVLedgEntryBuffer.SETRANGE("Payment Slip No.", GenJnlLine."Created from No.")
                    //     ELSE
                    //         UnrealCVLedgEntryBuffer.SETRANGE("Payment Slip No.", GenJnlLine."Document No.");
                    //     UnrealCVLedgEntryBuffer.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                    //     IF UnrealCVLedgEntryBuffer.FINDSET(TRUE, FALSE) THEN
                    //         REPEAT
                    //             OldVendLedgEntry.GET(UnrealCVLedgEntryBuffer."Entry No.");
                    //             OldVendLedgEntry.CALCFIELDS(
                    //       Amount, "Amount (LCY)", "Remaining Amount", "Remaining Amt. (LCY)",
                    //       "Original Amount", "Original Amt. (LCY)");
                    //     SetTransactionNo(GenJnlLine);
                    //     VendUnrealizedVAT(GenJnlLine, OldVendLedgEntry, UnrealCVLedgEntryBuffer."Applied Amount");
                    //     UnrealCVLedgEntryBuffer.Realized := TRUE;
                    //     UnrealCVLedgEntryBuffer.MODIFY;
                    //     UpdateUnrealCVLedgEntryBuffer(GenJnlLine, OldVendLedgEntry."Transaction No.");
                    // UNTIL UnrealCVLedgEntryBuffer.NEXT = 0;
                    //Bc uPGRADE GUNREM01 -Blocked Dependency with DIT Table
                END;
        END;
        //HEI.17<<
    end;

    procedure UpdateUnrealCVLedgEntryBuffer(GenJnlLine: Record "Gen. Journal Line"; TransactionNo: Integer)
    var
        TotalUnrealVATAmount: Decimal;
    begin
        //HEI.17>>
        // CompanyInfo.GET;
        // IF NOT CompanyInfo."Enable French Localization" THEN
        //     EXIT;

        // VATEntry2.RESET;
        // VATEntry2.SETCURRENTKEY("Transaction No.");
        // VATEntry2.SETRANGE("Transaction No.", TransactionNo);
        // IF VATEntry2.FINDSET THEN
        //     REPEAT
        //         TotalUnrealVATAmount := TotalUnrealVATAmount - VATEntry2."Remaining Unrealized Amount";
        //     UNTIL VATEntry2.NEXT = 0;
        // BC Upgrade GUNREM01 -Blocked Dependency with DIT Table >>
        // IF TotalUnrealVATAmount = 0 THEN BEGIN
        //     UnrealCVLedgEntryBuffer2.RESET;
        //     IF GenJnlLine."Source Type" = GenJnlLine."Source Type"::Customer THEN
        //         UnrealCVLedgEntryBuffer2.SETRANGE("Account Type", UnrealCVLedgEntryBuffer2."Account Type"::Customer)
        //     ELSE
        //         UnrealCVLedgEntryBuffer2.SETRANGE("Account Type", UnrealCVLedgEntryBuffer2."Account Type"::Vendor);
        //     UnrealCVLedgEntryBuffer2.SETRANGE("Entry No.", UnrealCVLedgEntryBuffer."Entry No.");
        //     UnrealCVLedgEntryBuffer2.SETRANGE(Realized, TRUE);
        //     UnrealCVLedgEntryBuffer2.DELETEALL;
        // END;
        // BC Upgrade GUNREM01 -Blocked Dependency with DIT Table <<
        //HEI.17<<
    end;

    LOCAL procedure CreateAndPostDerogatoryEntry(SourceGenJournalLine: Record "Gen. Journal Line")
    begin
        //HEI.17>>
        //BC Upgrade GUNREM01 -Blocked Dependency with DIT Table >>
        // CompanyInfo.GET;
        // IF NOT CompanyInfo."Enable French Localization" THEN
        //     EXIT;
        //BC Upgrade GUNREM01 -Blocked Dependency with DIT Table <<
        IF (SourceGenJournalLine."FA Posting Type" <> SourceGenJournalLine."FA Posting Type"::"Acquisition Cost") OR
             (NOT SourceGenJournalLine."Depr. Acquisition Cost")
          THEN
            EXIT;

        //     DepreciationBook.GET(SourceGenJournalLine."Depreciation Book Code");
        //     DerogDepreciationBook.SETRANGE("Derogatory Calculation", DepreciationBook.Code);
        //     IF NOT DerogDepreciationBook.FINDFIRST THEN
        //         EXIT;

        //     CalculateAcqCostDepr.DerogatoryCalc(
        //       DerogatoryAmount, SourceGenJournalLine."Account No.", DerogDepreciationBook.Code, SourceGenJournalLine.Amount);

        //     IF DerogatoryAmount = 0 THEN
        //         EXIT;

        //     MakeGenJnlLineOfTypeDerogatory(GenJnlLine, SourceGenJournalLine, DerogatoryAmount);
        //     MakeDerogFAJnlLine(FAJnlLine, GenJnlLine);

        //     IF DepreciationBook."G/L Integration - Derogatory" THEN BEGIN
        //         // Insert/post G/L + FA entries for primary depreciation book
        //         FAJnlPostLine.GenJnlPostLineContinue(
        //           GenJnlLine, GenJnlLine.Amount, GenJnlLine."VAT Amount", NextTransactionNo, NextEntryNo, GLReg."No.");

        //         // Insert balance entry for primary depreciation book
        //         DerogFALedgerEntry.SETCURRENTKEY("Entry No.");
        //         DerogFALedgerEntry.FINDLAST;
        //         DerogFALedgerEntry."Automatic Entry" := TRUE;
        //         FAJnlPostLine.InsertBalAcc(DerogFALedgerEntry);
        //     END ELSE BEGIN
        //         // Post FA ledger entry for primary book
        //         FAJnlLine.VALIDATE("Depreciation Book Code", SourceGenJournalLine."Depreciation Book Code");
        //         FAJnlPostLine.FAJnlPostLine(FAJnlLine, TRUE);
        //     END;

        //     // Post FA ledger entry for secondary book
        //     FAJnlLine.VALIDATE("Depreciation Book Code", DerogDepreciationBook.Code);
        //     FAJnlPostLine.FAJnlPostLine(FAJnlLine, TRUE);
        //     //HEI.17<<
    end;


    //HEI.17<<
    //   end;
    procedure SetPmtTolAmtToBeApplied(NewPmtTolAmtToBeApplied: Decimal)
    begin
        //HEI.33
        PmtTolAmtToBeAppliedHNK := NewPmtTolAmtToBeApplied
    end;

    LOCAL procedure CheckRelatedSOIsLinked(DocumentNo: Code[20]; CustomerNo: Code[20]) RelatedSONo: Code[20]
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        //HEI.34>>
        //Check if the Applied Payment has Related Sales Ordr No. filled-in
        CLEAR(RelatedSONo);
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETCURRENTKEY("Document No.", "Document Type");
        CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Payment);
        CustLedgerEntry.SETRANGE("Document No.", DocumentNo);
        CustLedgerEntry.SETRANGE("Customer No.", CustomerNo);
        CustLedgerEntry.SETFILTER("Related Sales Order No. FND", '<>%1', '');
        IF CustLedgerEntry.FINDFIRST THEN
            RelatedSONo := CustLedgerEntry."Related Sales Order No. FND";
        //HEI.34<<
    end;

    LOCAL procedure CheckMultiplePaymentsForInvoice(PmtEntryNo: Integer; VAR FoundTolRelatedSOno: Code[20]): Boolean
    var
        CLEPayment: Record "Cust. Ledger Entry";
    begin
        //HEI.35>>
        //HEI.36>>
        FoundTolRelatedSOno := '';
        IF PmtEntryNo = 0 THEN
            EXIT(FALSE);
        CLEPayment.RESET;
        CLEPayment.SETCURRENTKEY("Related Sales Order No. FND");
        CLEPayment.ASCENDING(FALSE);
        CLEPayment.SETRANGE("Entry No.", PmtEntryNo);
        CLEPayment.SETFILTER("Related Sales Order No. FND", '<>%1', '');
        IF CLEPayment.ISEMPTY THEN
            EXIT(FALSE);
        IF CLEPayment.FINDFIRST THEN
            FoundTolRelatedSOno := CLEPayment."Related Sales Order No. FND";

        CLEPayment.SETRANGE("Entry No.");
        CLEPayment.SETRANGE("Related Sales Order No. FND", FoundTolRelatedSOno);
        IF CLEPayment.COUNT > 1 THEN
            EXIT(TRUE);
        //HEI.36<<
        //HEI.35<<
    end;

    LOCAL procedure LastPaymentForInvoice(SalesOrderNo: Code[20]) LastPmtEntryNo: Integer
    var
        LastPmtCLE: Record "Cust. Ledger Entry";
    begin
        //HEI.35>>
        //HEI.36>>
        IF SalesOrderNo = '' THEN
            EXIT(0);
        LastPmtCLE.RESET;
        LastPmtCLE.SETCURRENTKEY("Related Sales Order No. FND");
        LastPmtCLE.ASCENDING(FALSE);
        LastPmtCLE.SETRANGE("Related Sales Order No. FND", SalesOrderNo);
        IF LastPmtCLE.ISEMPTY() THEN
            EXIT(0);
        IF LastPmtCLE.FINDFIRST() THEN
            LastPmtEntryNo := LastPmtCLE."Entry No.";
        //HEI.36<<
        //HEI.35<<
    end;

    LOCAL procedure CalcCurrencyRealizedGainLossHNK(VAR CVLedgEntryBuf: Record "CV Ledger Entry Buffer"; VAR TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; GenJnlLine: Record "Gen. Journal Line"; AppliedAmount: Decimal; AppliedAmountLCY: Decimal)
    var
        RealizedGainLossLCY: Decimal;
    begin
        //HEI.35>>
        IF CVLedgEntryBuf."Currency Code" = '' THEN
            EXIT;

        // Calculate Realized GainLoss
        RealizedGainLossLCY :=
            AppliedAmountLCY - ROUND(AppliedAmount / CVLedgEntryBuf."Original Currency Factor");
        IF RealizedGainLossLCY <> 0 THEN
            IF RealizedGainLossLCY < 0 THEN
                TempDtldCVLedgEntryBuf.InitDetailedCVLedgEntryBuf(
                  GenJnlLine, CVLedgEntryBuf, TempDtldCVLedgEntryBuf,
                  TempDtldCVLedgEntryBuf."Entry Type"::"Realized Loss", RealizedGainLossLCY, RealizedGainLossLCY, 0, 0, 0, 0)
            ELSE
                TempDtldCVLedgEntryBuf.InitDetailedCVLedgEntryBuf(
                  GenJnlLine, CVLedgEntryBuf, TempDtldCVLedgEntryBuf,
                  TempDtldCVLedgEntryBuf."Entry Type"::"Realized Gain", RealizedGainLossLCY, RealizedGainLossLCY, 0, 0, 0, 0);
        //HEI.35<<
    end;

    LOCAL procedure UpdateUnrealizRealizLossGainInfoInGenJnlLine(VAR lGenJnlLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuff: Record "Detailed CV Ledg. Entry Buffer"; AccType: Integer; DtldCVEntryNo: Integer)
    begin
        //HEI.43>>
        //  WITH DtldCVLedgEntryBuff DO BEGIN
        CASE DtldCVLedgEntryBuff."Entry Type" OF
            DtldCVLedgEntryBuff."Entry Type"::"Unrealized Loss",
             DtldCVLedgEntryBuff."Entry Type"::"Unrealized Gain",
              DtldCVLedgEntryBuff."Entry Type"::"Realized Loss",
          DtldCVLedgEntryBuff."Entry Type"::"Realized Gain":
                BEGIN
                    lGenJnlLine."CV Detailed Entry No. FND" := DtldCVEntryNo;
                    lGenJnlLine."Adj. Exchange Rate Type FND" := AccType;
                END;
        // END;
        END;
    end;
    //HEI.43<<

    local procedure CalcPmtDisc(var NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var OldCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var OldCVLedgEntryBuf2: Record "CV Ledger Entry Buffer"; var DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; GenJnlLine: Record "Gen. Journal Line"; PmtTolAmtToBeApplied: Decimal; ApplnRoundingPrecision: Decimal; NextTransactionNo: Integer; FirstNewVATEntryNo: Integer)
    var
        PmtDisc: Decimal;
        PmtDiscLCY: Decimal;
        PmtDiscAddCurr: Decimal;
        MinimalPossibleLiability: Decimal;
        PaymentExceedsLiability: Boolean;
        ToleratedPaymentExceedsLiability: Boolean;
        IsHandled: Boolean;
        AddCurrencyCode: code[20];
    begin
        // IsHandled := false;
        // OnBeforeCalcPmtDisc(
        //     NewCVLedgEntryBuf, OldCVLedgEntryBuf, OldCVLedgEntryBuf2, DtldCVLedgEntryBuf, GenJnlLine, PmtTolAmtToBeApplied, IsHandled,
        //     ApplnRoundingPrecision, NextTransactionNo, FirstNewVATEntryNo, AddCurrencyCode);
        // if IsHandled then
        //     exit;

        MinimalPossibleLiability := Abs(OldCVLedgEntryBuf2."Remaining Amount" - OldCVLedgEntryBuf2.GetRemainingPmtDiscPossible(NewCVLedgEntryBuf."Posting Date"));
        //    OnAfterCalcMinimalPossibleLiability(NewCVLedgEntryBuf, OldCVLedgEntryBuf, OldCVLedgEntryBuf2, MinimalPossibleLiability);

        PaymentExceedsLiability := Abs(OldCVLedgEntryBuf2."Amount to Apply") >= MinimalPossibleLiability;
        //  OnAfterCalcPaymentExceedsLiability(
        //  NewCVLedgEntryBuf, OldCVLedgEntryBuf, OldCVLedgEntryBuf2, MinimalPossibleLiability, PaymentExceedsLiability);

        ToleratedPaymentExceedsLiability :=
            Abs(NewCVLedgEntryBuf."Remaining Amount" + PmtTolAmtToBeApplied) >= MinimalPossibleLiability;
        // OnAfterCalcToleratedPaymentExceedsLiability(
        //     NewCVLedgEntryBuf, OldCVLedgEntryBuf, OldCVLedgEntryBuf2, MinimalPossibleLiability,
        //     ToleratedPaymentExceedsLiability, PmtTolAmtToBeApplied);

        if (PaymentToleranceMgt.CheckCalcPmtDisc(NewCVLedgEntryBuf, OldCVLedgEntryBuf2, ApplnRoundingPrecision, true, true) and
            ((OldCVLedgEntryBuf2."Amount to Apply" = 0) or PaymentExceedsLiability) or
            (PaymentToleranceMgt.CheckCalcPmtDisc(NewCVLedgEntryBuf, OldCVLedgEntryBuf2, ApplnRoundingPrecision, false, false) and
             (OldCVLedgEntryBuf2."Amount to Apply" <> 0) and PaymentExceedsLiability and ToleratedPaymentExceedsLiability))
        then begin
            PmtDisc := -OldCVLedgEntryBuf2.GetRemainingPmtDiscPossible(NewCVLedgEntryBuf."Posting Date");
            PmtDiscLCY :=
              Round(
                (NewCVLedgEntryBuf."Original Amount" + PmtDisc) / NewCVLedgEntryBuf."Original Currency Factor") -
              NewCVLedgEntryBuf."Original Amt. (LCY)";

            // OnCalcPmtDiscOnAfterAssignPmtDisc(PmtDisc, PmtDiscLCY, OldCVLedgEntryBuf, OldCVLedgEntryBuf2);

            OldCVLedgEntryBuf."Pmt. Disc. Given (LCY)" := -PmtDiscLCY;

            if (NewCVLedgEntryBuf."Currency Code" = AddCurrencyCode) and (AddCurrencyCode <> '') then
                PmtDiscAddCurr := PmtDisc
            else
                PmtDiscAddCurr := GenJnlPostline.CalcLCYToAddCurr(PmtDiscLCY);

            // OnAfterCalcPmtDiscount(
            //     NewCVLedgEntryBuf, OldCVLedgEntryBuf, OldCVLedgEntryBuf2, DtldCVLedgEntryBuf, GenJnlLine,
            //     PmtTolAmtToBeApplied, PmtDisc, PmtDiscLCY, PmtDiscAddCurr);

            if not GLSetup."Pmt. Disc. Excl. VAT" and GLSetup."Adjust for Payment Disc." and (PmtDiscLCY <> 0) then
                CalcPmtDiscIfAdjVAT(
                  NewCVLedgEntryBuf, OldCVLedgEntryBuf2, DtldCVLedgEntryBuf, GenJnlLine, PmtDiscLCY, PmtDiscAddCurr,
                  NextTransactionNo, FirstNewVATEntryNo, DtldCVLedgEntryBuf."Entry Type"::"Payment Discount (VAT Excl.)");

            //  OnCalcPmtDiscBeforeInitDetailedCVLedgEntryBuff(GenJnlLine, IsHandled);
            if not IsHandled then
                DtldCVLedgEntryBuf.InitDetailedCVLedgEntryBuf(
                    GenJnlLine, NewCVLedgEntryBuf, DtldCVLedgEntryBuf,
                    DtldCVLedgEntryBuf."Entry Type"::"Payment Discount", PmtDisc, PmtDiscLCY, PmtDiscAddCurr, 0, 0, 0);

            //  OnCalcPmtDiscOnAfterCalcPmtDisc(DtldCVLedgEntryBuf, OldCVLedgEntryBuf2, PmtDisc, PmtDiscLCY, GenJnlLine);
        end;
    end;

    local procedure CalcPmtTolerance(var NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var OldCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var OldCVLedgEntryBuf2: Record "CV Ledger Entry Buffer"; var DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; GenJnlLine: Record "Gen. Journal Line"; var PmtTolAmtToBeApplied: Decimal; NextTransactionNo: Integer; FirstNewVATEntryNo: Integer)
    var
        PmtTol: Decimal;
        PmtTolLCY: Decimal;
        PmtTolAddCurr: Decimal;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeCalcPmtTolerance(
        //   NewCVLedgEntryBuf, OldCVLedgEntryBuf, OldCVLedgEntryBuf2, DtldCVLedgEntryBuf, GenJnlLine, PmtTolAmtToBeApplied, IsHandled);
        if IsHandled then
            exit;

        if OldCVLedgEntryBuf2."Accepted Payment Tolerance" = 0 then
            exit;

        PmtTol := -OldCVLedgEntryBuf2."Accepted Payment Tolerance";
        PmtTolAmtToBeApplied := PmtTolAmtToBeApplied + PmtTol;
        PmtTolLCY :=
            Round((NewCVLedgEntryBuf."Original Amount" + PmtTol) / NewCVLedgEntryBuf."Original Currency Factor") -
            NewCVLedgEntryBuf."Original Amt. (LCY)";

        // OnCalcPmtToleranceOnAfterAssignPmtDisc(
        //     PmtTol, PmtTolLCY, PmtTolAmtToBeApplied, OldCVLedgEntryBuf, OldCVLedgEntryBuf2,
        //     NewCVLedgEntryBuf, DtldCVLedgEntryBuf, NextTransactionNo, FirstNewVATEntryNo);

        OldCVLedgEntryBuf."Accepted Payment Tolerance" := 0;
        OldCVLedgEntryBuf."Pmt. Tolerance (LCY)" := -PmtTolLCY;

        if NewCVLedgEntryBuf."Currency Code" = AddCurrencyCode then
            PmtTolAddCurr := PmtTol
        else
            PmtTolAddCurr := GenJnlPostline.CalcLCYToAddCurr(PmtTolLCY);

        if not GLSetup."Pmt. Disc. Excl. VAT" and GLSetup."Adjust for Payment Disc." and (PmtTolLCY <> 0) then
            CalcPmtDiscIfAdjVAT(
                   NewCVLedgEntryBuf, OldCVLedgEntryBuf2, DtldCVLedgEntryBuf, GenJnlLine, PmtTolLCY, PmtTolAddCurr,
                   NextTransactionNo, FirstNewVATEntryNo, DtldCVLedgEntryBuf."Entry Type"::"Payment Tolerance (VAT Excl.)");

        //  OnBeforeInitDetailedCVLedgEntryBufCalcPmtTolerance(
        // NewCVLedgEntryBuf, OldCVLedgEntryBuf, OldCVLedgEntryBuf2,
        // DtldCVLedgEntryBuf, GenJnlLine, PmtTolAmtToBeApplied, NextTransactionNo, FirstNewVATEntryNo, PmtTol, PmtTolLCY, PmtTolAddCurr);
        DtldCVLedgEntryBuf.InitDetailedCVLedgEntryBuf(
            GenJnlLine, NewCVLedgEntryBuf, DtldCVLedgEntryBuf,
            DtldCVLedgEntryBuf."Entry Type"::"Payment Tolerance", PmtTol, PmtTolLCY, PmtTolAddCurr, 0, 0, 0);

        // OnAfterCalcPmtTolerance(DtldCVLedgEntryBuf, OldCVLedgEntryBuf2, PmtTol, PmtTolLCY, GenJnlLine);
    end;

    local procedure GetApplnRoundPrecision(NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; OldCVLedgEntryBuf: Record "CV Ledger Entry Buffer"): Decimal
    var
        ApplnCurrency: Record Currency;
    begin
        if NewCVLedgEntryBuf."Currency Code" = OldCVLedgEntryBuf."Currency Code" then
            exit(0);

        ApplnCurrency.Initialize(NewCVLedgEntryBuf."Currency Code");
        if NewCVLedgEntryBuf."Currency Code" <> '' then
            exit(ApplnCurrency."Appln. Rounding Precision");

        GetGLSetup();
        exit(GLSetup."Appln. Rounding Precision");
    end;

    procedure GetGLSetup()
    begin
        if GLSetupRead then
            exit;

        GLSetup.Get();
        GLSetupRead := true;

        AddCurrencyCode := GLSetup."Additional Reporting Currency";
        //  OnAfterGetGLSetup(GLSetup, GLSetupRead, AddCurrencyCode);
    end;

    local procedure CalcCurrencyApplnRounding(var NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var OldCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; GenJnlLine: Record "Gen. Journal Line"; ApplnRoundingPrecision: Decimal)
    var
        ApplnRounding: Decimal;
        ApplnRoundingLCY: Decimal;
    begin
        if NewCVLedgEntryBuf."Currency Code" = OldCVLedgEntryBuf."Currency Code" then
            exit;

        ApplnRounding := -(NewCVLedgEntryBuf."Remaining Amount" + OldCVLedgEntryBuf."Remaining Amount");
        ApplnRoundingLCY := Round(ApplnRounding / NewCVLedgEntryBuf."Adjusted Currency Factor");

        if (ApplnRounding = 0) or (Abs(ApplnRounding) > ApplnRoundingPrecision) then
            exit;

        DtldCVLedgEntryBuf.InitDetailedCVLedgEntryBuf(
          GenJnlLine, NewCVLedgEntryBuf, DtldCVLedgEntryBuf,
          DtldCVLedgEntryBuf."Entry Type"::"Appln. Rounding", ApplnRounding, ApplnRoundingLCY, ApplnRounding, 0, 0, 0);
    end;

    local procedure FindAmtForAppln(var NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var OldCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var OldCVLedgEntryBuf2: Record "CV Ledger Entry Buffer"; var AppliedAmount: Decimal; var AppliedAmountLCY: Decimal; var OldAppliedAmount: Decimal; ApplnRoundingPrecision: Decimal; var GenJournalLine: Record "Gen. Journal Line")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeFindAmtForAppln(
        //   NewCVLedgEntryBuf, OldCVLedgEntryBuf, OldCVLedgEntryBuf2, AppliedAmount, AppliedAmountLCY, OldAppliedAmount, IsHandled,
        //   ApplnRoundingPrecision, VATEntry);
        if IsHandled then
            exit;

        if OldCVLedgEntryBuf2.GetFilter(Positive) <> '' then begin
            if OldCVLedgEntryBuf2."Amount to Apply" <> 0 then begin
                if (PaymentToleranceMgt.CheckCalcPmtDisc(NewCVLedgEntryBuf, OldCVLedgEntryBuf2, ApplnRoundingPrecision, false, false) and
                    (Abs(OldCVLedgEntryBuf2."Amount to Apply") >=
                     Abs(OldCVLedgEntryBuf2."Remaining Amount" - OldCVLedgEntryBuf2."Remaining Pmt. Disc. Possible")))
                then begin
                    AppliedAmount := -OldCVLedgEntryBuf2."Remaining Amount";
                    //  OnAfterSetAppliedAmountFromRemainingAmount(OldCVLedgEntryBuf2, AppliedAmount, GenJournalLine)
                end else
                    AppliedAmount := -OldCVLedgEntryBuf2."Amount to Apply"
            end else
                AppliedAmount := -OldCVLedgEntryBuf2."Remaining Amount";
        end else
            if OldCVLedgEntryBuf2."Amount to Apply" <> 0 then
                if (PaymentToleranceMgt.CheckCalcPmtDisc(NewCVLedgEntryBuf, OldCVLedgEntryBuf2, ApplnRoundingPrecision, false, false) and
                    (Abs(OldCVLedgEntryBuf2."Amount to Apply") >=
                     Abs(OldCVLedgEntryBuf2."Remaining Amount" - OldCVLedgEntryBuf2.GetRemainingPmtDiscPossible(NewCVLedgEntryBuf."Posting Date"))) and
                    (Abs(NewCVLedgEntryBuf."Remaining Amount") >=
                     Abs(
                      GenJnlPostline.ABSMin(
                         OldCVLedgEntryBuf2."Remaining Amount" - OldCVLedgEntryBuf2.GetRemainingPmtDiscPossible(NewCVLedgEntryBuf."Posting Date"),
                         OldCVLedgEntryBuf2."Amount to Apply")))) or
                   OldCVLedgEntryBuf."Accepted Pmt. Disc. Tolerance"
                then begin
                    AppliedAmount := -OldCVLedgEntryBuf2."Remaining Amount";
                    //   OnAfterSetAppliedAmountFromRemainingAmountOnEmptyFilter(OldCVLedgEntryBuf2, AppliedAmount, GenJournalLine);
                    OldCVLedgEntryBuf."Accepted Pmt. Disc. Tolerance" := false;
                end else
                    AppliedAmount := GenJnlPostline.ABSMin(NewCVLedgEntryBuf."Remaining Amount", -OldCVLedgEntryBuf2."Amount to Apply")
            else
                AppliedAmount := GenJnlPostline.ABSMin(NewCVLedgEntryBuf."Remaining Amount", -OldCVLedgEntryBuf2."Remaining Amount");

        if (Abs(OldCVLedgEntryBuf2."Remaining Amount" - OldCVLedgEntryBuf2."Amount to Apply") < ApplnRoundingPrecision) and
           (ApplnRoundingPrecision <> 0) and
           (OldCVLedgEntryBuf2."Amount to Apply" <> 0)
        then
            AppliedAmount := AppliedAmount - (OldCVLedgEntryBuf2."Remaining Amount" - OldCVLedgEntryBuf2."Amount to Apply");

        if NewCVLedgEntryBuf."Currency Code" = OldCVLedgEntryBuf2."Currency Code" then begin
            AppliedAmountLCY := Round(AppliedAmount / OldCVLedgEntryBuf."Original Currency Factor");
            OldAppliedAmount := AppliedAmount;
        end else begin
            // Management of posting in multiple currencies
            if AppliedAmount = -OldCVLedgEntryBuf2."Remaining Amount" then
                OldAppliedAmount := -OldCVLedgEntryBuf."Remaining Amount"
            else
                OldAppliedAmount :=
                  CurrExchRate.ExchangeAmount(
                    AppliedAmount, NewCVLedgEntryBuf."Currency Code",
                    OldCVLedgEntryBuf2."Currency Code", NewCVLedgEntryBuf."Posting Date");

            if NewCVLedgEntryBuf."Currency Code" <> '' then
                // Post the realized gain or loss on the NewCVLedgEntryBuf
                AppliedAmountLCY := Round(OldAppliedAmount / OldCVLedgEntryBuf."Original Currency Factor")
            else
                // Post the realized gain or loss on the OldCVLedgEntryBuf
                AppliedAmountLCY := Round(AppliedAmount / NewCVLedgEntryBuf."Original Currency Factor");
        end;

        // OnAfterFindAmtForAppln(
        //   NewCVLedgEntryBuf, OldCVLedgEntryBuf, OldCVLedgEntryBuf2, AppliedAmount,
        //   AppliedAmountLCY, OldAppliedAmount, AmountRoundingPrecision, VATEntry);
    end;

    local procedure CalcApplication(var NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var OldCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; GenJnlLine: Record "Gen. Journal Line"; AppliedAmount: Decimal; AppliedAmountLCY: Decimal; OldAppliedAmount: Decimal; PrevNewCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; PrevOldCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var AllApplied: Boolean)
    var
        IsHandled: Boolean;
        ShouldSetClosedFields: Boolean;
    begin
        IsHandled := false;
        // OnBeforeCalcAplication(
        //   NewCVLedgEntryBuf, OldCVLedgEntryBuf, DtldCVLedgEntryBuf, GenJnlLine,
        //   AppliedAmount, AppliedAmountLCY, OldAppliedAmount, PrevNewCVLedgEntryBuf, PrevOldCVLedgEntryBuf, AllApplied, IsHandled);
        if IsHandled then
            exit;

        //   OnCalcApplicationOnBeforeCheckAppliedAmount(GenJnlLine, AppliedAmount, IsHandled);
        if not IsHandled then
            if AppliedAmount = 0 then
                exit;

        DtldCVLedgEntryBuf.InitDetailedCVLedgEntryBuf(
          GenJnlLine, OldCVLedgEntryBuf, DtldCVLedgEntryBuf,
          DtldCVLedgEntryBuf."Entry Type"::Application, OldAppliedAmount, AppliedAmountLCY, 0,
          NewCVLedgEntryBuf."Entry No.", PrevOldCVLedgEntryBuf."Remaining Pmt. Disc. Possible",
          PrevOldCVLedgEntryBuf."Max. Payment Tolerance");

        // OnAfterInitOldDtldCVLedgEntryBuf(
        //   DtldCVLedgEntryBuf, NewCVLedgEntryBuf, OldCVLedgEntryBuf, PrevNewCVLedgEntryBuf, PrevOldCVLedgEntryBuf, GenJnlLine);

        OldCVLedgEntryBuf.Open := OldCVLedgEntryBuf."Remaining Amount" <> 0;

        //    OnCalcApplicationOnAfterFillOldCVLedgEntryBufOpen(GenJnlLine, OldCVLedgEntryBuf);

        if not OldCVLedgEntryBuf.Open then
            OldCVLedgEntryBuf.SetClosedFields(
              NewCVLedgEntryBuf."Entry No.", GenJnlLine."Posting Date",
              -OldAppliedAmount, -AppliedAmountLCY, NewCVLedgEntryBuf."Currency Code", -AppliedAmount)
        else
            AllApplied := false;

        DtldCVLedgEntryBuf.InitDetailedCVLedgEntryBuf(
          GenJnlLine, NewCVLedgEntryBuf, DtldCVLedgEntryBuf,
          DtldCVLedgEntryBuf."Entry Type"::Application, -AppliedAmount, -AppliedAmountLCY, 0,
          NewCVLedgEntryBuf."Entry No.", PrevNewCVLedgEntryBuf."Remaining Pmt. Disc. Possible",
          PrevNewCVLedgEntryBuf."Max. Payment Tolerance");

        // OnAfterInitNewDtldCVLedgEntryBuf(
        //   DtldCVLedgEntryBuf, NewCVLedgEntryBuf, OldCVLedgEntryBuf, PrevNewCVLedgEntryBuf, PrevOldCVLedgEntryBuf, GenJnlLine);

        NewCVLedgEntryBuf.Open := NewCVLedgEntryBuf."Remaining Amount" <> 0;
        ShouldSetClosedFields := not NewCVLedgEntryBuf.Open and not AllApplied;
        //  OnCalcApplicationOnAfterCalcShouldSetClosedFields(NewCVLedgEntryBuf, ShouldSetClosedFields);
        if ShouldSetClosedFields then
            NewCVLedgEntryBuf.SetClosedFields(
              OldCVLedgEntryBuf."Entry No.", GenJnlLine."Posting Date",
              AppliedAmount, AppliedAmountLCY, OldCVLedgEntryBuf."Currency Code", OldAppliedAmount);

        if not NewCVLedgEntryBuf.Open then
            NewCVLedgEntryBuf."Closed at Date" := GenJnlLine."Posting Date";

        // OnAfterCalcApplication(GenJnlLine, DtldCVLedgEntryBuf);
    end;

    local procedure CalcCurrencyRealizedGainLoss(var CVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer" temporary; GenJnlLine: Record "Gen. Journal Line"; AppliedAmount: Decimal; AppliedAmountLCY: Decimal)
    var
        RealizedGainLossLCY: Decimal;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeCalcCurrencyRealizedGainLoss(
        //   CVLedgEntryBuf, TempDtldCVLedgEntryBuf, GenJnlLine, AppliedAmount, AppliedAmountLCY, IsHandled);
        if IsHandled then
            exit;

        if CVLedgEntryBuf."Currency Code" = '' then
            exit;

        RealizedGainLossLCY := AppliedAmountLCY - Round(AppliedAmount / CVLedgEntryBuf."Original Currency Factor");
        //  OnAfterCalcCurrencyRealizedGainLoss(CVLedgEntryBuf, AppliedAmount, AppliedAmountLCY, RealizedGainLossLCY);

        if RealizedGainLossLCY <> 0 then
            if RealizedGainLossLCY < 0 then
                TempDtldCVLedgEntryBuf.InitDetailedCVLedgEntryBuf(
                  GenJnlLine, CVLedgEntryBuf, TempDtldCVLedgEntryBuf,
                  TempDtldCVLedgEntryBuf."Entry Type"::"Realized Loss", 0, RealizedGainLossLCY, 0, 0, 0, 0)
            else
                TempDtldCVLedgEntryBuf.InitDetailedCVLedgEntryBuf(
                  GenJnlLine, CVLedgEntryBuf, TempDtldCVLedgEntryBuf,
                  TempDtldCVLedgEntryBuf."Entry Type"::"Realized Gain", 0, RealizedGainLossLCY, 0, 0, 0, 0);
    end;

    local procedure CalcPmtDiscIfAdjVAT(var NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var OldCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; GenJnlLine: Record "Gen. Journal Line"; var PmtDiscLCY2: Decimal; var PmtDiscAddCurr2: Decimal; NextTransactionNo: Integer; FirstNewVATEntryNo: Integer; EntryType: Enum "Detailed CV Ledger Entry Type")
    var
        VATEntry2: Record "VAT Entry";
        VATPostingSetup: Record "VAT Posting Setup";
        TaxJurisdiction: Record "Tax Jurisdiction";
        DtldCVLedgEntryBuf2: Record "Detailed CV Ledg. Entry Buffer";
        TempVATEntry: Record "VAT Entry" temporary;
        OriginalAmountAddCurr: Decimal;
        PmtDiscRounding: Decimal;
        PmtDiscRoundingAddCurr: Decimal;
        PmtDiscFactorLCY: Decimal;
        PmtDiscFactorAddCurr: Decimal;
        VATBase: Decimal;
        VATBaseAddCurr: Decimal;
        VATAmount: Decimal;
        VATAmountAddCurr: Decimal;
        TotalVATAmount: Decimal;
        NonDedVATBase: Decimal;
        NonDedVATBaseAddCurr: Decimal;
        NonDedVATAmount: Decimal;
        NonDedVATAmountAddCurr: Decimal;
        NonDedTotalVATAmount: Decimal;
        NonDedTotalVATAmountACY: Decimal;
        NonDedReverseChargeVATBasePmtDisc: Decimal;
        NonDedReverseChargeVATBasePmtDiscACY: Decimal;
        LastConnectionNo: Integer;
        VATEntryModifier: Integer;
    begin
        if OldCVLedgEntryBuf."Original Amt. (LCY)" = 0 then
            exit;

        if (AddCurrencyCode = '') or (AddCurrencyCode = OldCVLedgEntryBuf."Currency Code") then
            OriginalAmountAddCurr := OldCVLedgEntryBuf.Amount
        else
            OriginalAmountAddCurr := GenJnlPostline.CalcLCYToAddCurr(OldCVLedgEntryBuf."Original Amt. (LCY)");

        PmtDiscRounding := PmtDiscLCY2;
        PmtDiscFactorLCY := PmtDiscLCY2 / OldCVLedgEntryBuf."Original Amt. (LCY)";
        if OriginalAmountAddCurr <> 0 then
            PmtDiscFactorAddCurr := PmtDiscAddCurr2 / OriginalAmountAddCurr
        else
            PmtDiscFactorAddCurr := 0;

        NonDedTotalVATAmount := 0;
        NonDedTotalVATAmountACY := 0;

        VATEntry2.ReadIsolation := IsolationLevel::ReadUncommitted;
        VATEntry2.Reset();
        VATEntry2.SetCurrentKey("Transaction No.");
        VATEntry2.SetRange("Transaction No.", OldCVLedgEntryBuf."Transaction No.");
        if OldCVLedgEntryBuf."Transaction No." = NextTransactionNo then
            VATEntry2.SetRange("Entry No.", 0, FirstNewVATEntryNo - 1);

        // OnCalcPmtDiscIfAdjVATOnBeforeVATEntryFind(
        //     GenJnlLine, OldCVLedgEntryBuf, NewCVLedgEntryBuf, VATEntry2,
        //     PmtDiscLCY2, PmtDiscAddCurr2, PmtDiscFactorLCY, PmtDiscFactorAddCurr);

        if VATEntry2.FindSet() then begin
            TotalVATAmount := 0;
            LastConnectionNo := 0;
            repeat
                // OnCalcPmtDiscAdjVATAmountsOnBeforeProcessVATEntry(GenJnlLine, OldCVLedgEntryBuf, NewCVLedgEntryBuf, VATEntry2);

                VATPostingSetup.Get(VATEntry2."VAT Bus. Posting Group", VATEntry2."VAT Prod. Posting Group");
                if VATEntry2."VAT Calculation Type" =
                   VATEntry2."VAT Calculation Type"::"Sales Tax"
                then begin
                    TaxJurisdiction.Get(VATEntry2."Tax Jurisdiction Code");
                    VATPostingSetup."Adjust for Payment Discount" :=
                      TaxJurisdiction."Adjust for Payment Discount";
                end;
                if VATPostingSetup."Adjust for Payment Discount" then begin
                    if LastConnectionNo <> VATEntry2."Sales Tax Connection No." then begin
                        if LastConnectionNo <> 0 then begin
                            DtldCVLedgEntryBuf := DtldCVLedgEntryBuf2;
                            DtldCVLedgEntryBuf."VAT Amount (LCY)" := -TotalVATAmount;
                            DtldCVLedgEntryBuf."Non-Deductible VAT Amount LCY" := -NonDedTotalVATAmount;
                            DtldCVLedgEntryBuf."Non-Deductible VAT Amount ACY" := -NonDedTotalVATAmountACY;
                            DtldCVLedgEntryBuf.InsertDtldCVLedgEntry(DtldCVLedgEntryBuf, NewCVLedgEntryBuf, false);
                            //OnCalcPmtDiscIfAdjVATOnBeforeInsertSummarizedVATAdjForPaymentDiscount(DtldCVLedgEntryBuf, OldCVLedgEntryBuf);
                            GenJnlPostline.InsertSummarizedVAT(GenJnlLine);
                        end;

                        CalcPmtDiscVATBases(VATEntry2, VATBase, VATBaseAddCurr, NonDedVATBase, NonDedVATBaseAddCurr);

                        VATBase :=
                            CalcAmtMultipliedByFactorWithRounding(
                                PmtDiscRounding, PmtDiscLCY2, VATBase, PmtDiscFactorLCY);
                        NonDedVATBase :=
                            CalcAmtMultipliedByFactorWithRounding(
                                PmtDiscRounding, PmtDiscLCY2, NonDedVATBase, PmtDiscFactorLCY);

                        PmtDiscRoundingAddCurr := PmtDiscRoundingAddCurr + VATBaseAddCurr * PmtDiscFactorAddCurr;
                        VATBaseAddCurr := Round(GenJnlPostline.CalcLCYToAddCurr(VATBase), AddCurrency."Amount Rounding Precision");
                        PmtDiscAddCurr2 := PmtDiscAddCurr2 + VATBaseAddCurr;

                        PmtDiscRoundingAddCurr := PmtDiscRoundingAddCurr + NonDedVATBaseAddCurr * PmtDiscFactorAddCurr;
                        NonDedVATBaseAddCurr := Round(GenJnlPostline.CalcLCYToAddCurr(NonDedVATBase), AddCurrency."Amount Rounding Precision");
                        PmtDiscAddCurr2 := PmtDiscAddCurr2 + NonDedVATBaseAddCurr;

                        //   OnCalcPmtDiscIfAdjVATOnAfterCalcPmtDiscVATBases(VATEntry2, OldCVLedgEntryBuf, VATBase, VATBaseAddCurr, PmtDiscLCY2, PmtDiscAddCurr2);

                        DtldCVLedgEntryBuf2.Init();
                        DtldCVLedgEntryBuf2."Posting Date" := GenJnlLine."Posting Date";
                        DtldCVLedgEntryBuf2."Document Type" := GenJnlLine."Document Type";
                        DtldCVLedgEntryBuf2."Document No." := GenJnlLine."Document No.";
                        DtldCVLedgEntryBuf2.Amount := 0;
                        DtldCVLedgEntryBuf2."Amount (LCY)" := -VATBase;
                        if VATEntry2."VAT Calculation Type" = VATEntry2."VAT Calculation Type"::"Normal VAT" then
                            DtldCVLedgEntryBuf2."Amount (LCY)" -= NonDedVATBase;
                        if VATEntry2."VAT Calculation Type" = VATEntry2."VAT Calculation Type"::"Reverse Charge VAT" then begin
                            NonDedReverseChargeVATBasePmtDisc += NonDedVATBase;
                            NonDedReverseChargeVATBasePmtDiscACY += NonDedVATBaseAddCurr;
                        end;
                        DtldCVLedgEntryBuf2."Entry Type" := EntryType;
                        case EntryType of
                            DtldCVLedgEntryBuf."Entry Type"::"Payment Discount Tolerance (VAT Excl.)":
                                VATEntryModifier := 1000000;
                            DtldCVLedgEntryBuf."Entry Type"::"Payment Tolerance (VAT Excl.)":
                                VATEntryModifier := 2000000;
                            DtldCVLedgEntryBuf."Entry Type"::"Payment Discount (VAT Excl.)":
                                VATEntryModifier := 3000000;
                        end;
                        DtldCVLedgEntryBuf2.CopyFromCVLedgEntryBuf(NewCVLedgEntryBuf);
                        // The total payment discount in currency is posted on the entry made in
                        // the function CalcPmtDisc.
                        DtldCVLedgEntryBuf2."User ID" := CopyStr(UserId(), 1, MaxStrLen(DtldCVLedgEntryBuf2."User ID"));
                        DtldCVLedgEntryBuf2."Additional-Currency Amount" := -VATBaseAddCurr;
                        //   OnCalcPmtDiscIfAdjVATCopyFields(DtldCVLedgEntryBuf2, OldCVLedgEntryBuf, GenJnlLine);
                        DtldCVLedgEntryBuf2.CopyPostingGroupsFromVATEntry(VATEntry2);
                        TotalVATAmount := 0;
                        LastConnectionNo := VATEntry2."Sales Tax Connection No.";
                    end;

                    //  OnBeforeCalcPmtDiscVATAmounts(VATEntry2, DtldCVLedgEntryBuf2, GenJnlLine);
                    CalcPmtDiscVATAmounts(
                            VATEntry2, VATBase, VATBaseAddCurr, NonDedVATBase, NonDedVATBaseAddCurr,
                            VATAmount, VATAmountAddCurr, NonDedVATAmount, NonDedVATAmountAddCurr,
                            PmtDiscRounding, PmtDiscFactorLCY, PmtDiscLCY2, PmtDiscAddCurr2);
                    if VATEntry2."VAT Calculation Type" = VATEntry2."VAT Calculation Type"::"Normal VAT" then
                        DtldCVLedgEntryBuf2."Amount (LCY)" -= NonDedVATAmount;
                    // OnCalcPmtDiscIfAdjVATOnAfterCalcPmtDiscVATAmounts(
                    //     VATEntry2, OldCVLedgEntryBuf, VATBase, VATBaseAddCurr, VATAmount, VATAmountAddCurr, PmtDiscLCY2, PmtDiscAddCurr2);

                    TotalVATAmount := TotalVATAmount + VATAmount;
                    NonDedTotalVATAmount := NonDedTotalVATAmount + NonDedVATAmount;
                    NonDedTotalVATAmountACY := NonDedTotalVATAmountACY + NonDedVATAmountAddCurr;

                    if (PmtDiscAddCurr2 <> 0) and (PmtDiscLCY2 = 0) then begin
                        VATAmountAddCurr := VATAmountAddCurr - PmtDiscAddCurr2;
                        PmtDiscAddCurr2 := 0;
                    end;

                    // Post VAT
                    // VAT for VAT entry
                    if VATEntry2.Type <> VATEntry2.Type::" " then
                        InsertPmtDiscVATForVATEntry(
                            GenJnlLine, TempVATEntry, VATEntry2, VATEntryModifier,
                            VATAmount, VATAmountAddCurr, VATBase, VATBaseAddCurr,
                            NonDedVATAmount, NonDedVATAmountAddCurr, NonDedVATBase, NonDedVATBaseAddCurr,
                            PmtDiscFactorLCY, PmtDiscFactorAddCurr);

                    // OnCalcPmtDiscIfAdjVATOnBeforeInsertPmtDiscVATForGLEntry(TempVATEntry, VATEntry2, DtldCVLedgEntryBuf2);
                    // VAT for G/L entry/entries
                    InsertPmtDiscVATForGLEntry(
                        GenJnlLine, DtldCVLedgEntryBuf, NewCVLedgEntryBuf, VATEntry2,
                        VATPostingSetup, TaxJurisdiction, EntryType, VATAmount, VATAmountAddCurr, NonDedVATAmount, NonDedVATAmountAddCurr);
                end;
            until VATEntry2.Next() = 0;

            if LastConnectionNo <> 0 then begin
                DtldCVLedgEntryBuf := DtldCVLedgEntryBuf2;
                DtldCVLedgEntryBuf."VAT Amount (LCY)" := -TotalVATAmount;
                DtldCVLedgEntryBuf."Non-Deductible VAT Amount LCY" := -NonDedTotalVATAmount;
                DtldCVLedgEntryBuf."Non-Deductible VAT Amount ACY" := -NonDedTotalVATAmountACY;
                DtldCVLedgEntryBuf.InsertDtldCVLedgEntry(DtldCVLedgEntryBuf, NewCVLedgEntryBuf, true);
                //  OnCalcPmtDiscIfAdjVATOnBeforeInsertSummarizedVATAfterLoop(DtldCVLedgEntryBuf, OldCVLedgEntryBuf);
                GenJnlPostline.InsertSummarizedVAT(GenJnlLine);
            end;
            PmtDiscLCY2 -= NonDedReverseChargeVATBasePmtDisc;
            PmtDiscAddCurr2 -= NonDedReverseChargeVATBasePmtDiscACY;
        end;

        //  OnAfterCalcPmtDiscIfAdjVAT(NewCVLedgEntryBuf, OldCVLedgEntryBuf, DtldCVLedgEntryBuf, GenJnlLine, PmtDiscLCY2, PmtDiscAddCurr2);
    end;

    local procedure CalcPmtDiscVATBases(VATEntry2: Record "VAT Entry"; var VATBase: Decimal; var VATBaseAddCurr: Decimal; var NonDeductibleVATBase: Decimal; var NonDeductibleVATBaseAddCurr: Decimal)
    var
        VATEntry: Record "VAT Entry";
    begin
        case VATEntry2."VAT Calculation Type" of
            VATEntry2."VAT Calculation Type"::"Normal VAT",
            VATEntry2."VAT Calculation Type"::"Reverse Charge VAT",
            VATEntry2."VAT Calculation Type"::"Full VAT":
                begin
                    VATBase :=
                      VATEntry2.Base + VATEntry2."Unrealized Base";
                    VATBaseAddCurr :=
                      VATEntry2."Additional-Currency Base" +
                      VATEntry2."Add.-Currency Unrealized Base";
                    NonDeductibleVAT.GetNonDeductibleVATBaseBothCurrencies(NonDeductibleVATBase, NonDeductibleVATBaseAddCurr, VATEntry2);
                end;
            VATEntry2."VAT Calculation Type"::"Sales Tax":
                begin
                    VATEntry.Reset();
                    VATEntry.SetCurrentKey("Transaction No.");
                    VATEntry.SetRange("Transaction No.", VATEntry2."Transaction No.");
                    VATEntry.SetRange("Sales Tax Connection No.", VATEntry2."Sales Tax Connection No.");
                    VATEntry := VATEntry2;
                    repeat
                        if VATEntry.Base < 0 then
                            VATEntry.SetFilter(Base, '>%1', VATEntry.Base)
                        else
                            VATEntry.SetFilter(Base, '<%1', VATEntry.Base);
                    until not VATEntry.FindLast();
                    VATEntry.Reset();
                    VATBase :=
                      VATEntry.Base + VATEntry."Unrealized Base";
                    VATBaseAddCurr :=
                      VATEntry."Additional-Currency Base" +
                      VATEntry."Add.-Currency Unrealized Base";
                end;
        end;
        //  OnAfterCalcPmtDiscVATBases(VATEntry2, VATBase, VATBaseAddCurr, NonDeductibleVATBase, NonDeductibleVATBaseAddCurr);
    end;

    local procedure CalcAmtMultipliedByFactorWithRounding(var Rounding: Decimal; var TotalAmount: Decimal; SourceAmount: Decimal; Factor: Decimal) Result: Decimal
    begin
        Rounding := Rounding + SourceAmount * Factor;
        Result := Round(Rounding - TotalAmount);
        TotalAmount := TotalAmount + Result;
    end;

    local procedure CalcPmtDiscVATAmounts(VATEntry2: Record "VAT Entry"; VATBase: Decimal; VATBaseAddCurr: Decimal; NonDedVATBase: Decimal; NonDedVATBaseAddCurr: Decimal; var VATAmount: Decimal; var VATAmountAddCurr: Decimal; var NonDedVATAmount: Decimal; var NonDedVATAmountAddCurr: Decimal; var PmtDiscRounding: Decimal; PmtDiscFactorLCY: Decimal; var PmtDiscLCY2: Decimal; var PmtDiscAddCurr2: Decimal)
    begin
        case VATEntry2."VAT Calculation Type" of
            VATEntry2."VAT Calculation Type"::"Normal VAT",
          VATEntry2."VAT Calculation Type"::"Full VAT":
                if (VATEntry2.Amount + VATEntry2."Unrealized Amount" + VATEntry2."Non-Deductible VAT Amount" <> 0) or
                   (VATEntry2."Additional-Currency Amount" + VATEntry2."Add.-Currency Unrealized Amt." + VATEntry2."Non-Deductible VAT Amount ACY" <> 0)
                then begin
                    if (VATBase = 0) and
                       (VATEntry2."VAT Calculation Type" <> VATEntry2."VAT Calculation Type"::"Full VAT")
                    then
                        VATAmount := 0
                    else
                        VATAmount :=
                            CalcAmtMultipliedByFactorWithRounding(
                                PmtDiscRounding, PmtDiscLCY2, VATEntry2.Amount + VATEntry2."Unrealized Amount", PmtDiscFactorLCY);
                    if (VATBaseAddCurr = 0) and
                       (VATEntry2."VAT Calculation Type" <> VATEntry2."VAT Calculation Type"::"Full VAT")
                    then
                        VATAmountAddCurr := 0
                    else begin
                        VATAmountAddCurr := Round(GenJnlPostline.CalcLCYToAddCurr(VATAmount), AddCurrency."Amount Rounding Precision");
                        PmtDiscAddCurr2 := PmtDiscAddCurr2 + VATAmountAddCurr;
                    end;
                    if (NonDedVATBase = 0) and
                       (VATEntry2."VAT Calculation Type" <> VATEntry2."VAT Calculation Type"::"Full VAT")
                    then
                        NonDedVATAmount := 0
                    else
                        NonDedVATAmount :=
                            CalcAmtMultipliedByFactorWithRounding(
                                PmtDiscRounding, PmtDiscLCY2, VATEntry2."Non-Deductible VAT Amount", PmtDiscFactorLCY);
                    if (NonDedVATBaseAddCurr = 0) and
                       (VATEntry2."VAT Calculation Type" <> VATEntry2."VAT Calculation Type"::"Full VAT")
                    then
                        NonDedVATAmountAddCurr := 0
                    else begin
                        NonDedVATAmountAddCurr := Round(GenJnlPostline.CalcLCYToAddCurr(NonDedVATAmount), AddCurrency."Amount Rounding Precision");
                        PmtDiscAddCurr2 := PmtDiscAddCurr2 + NonDedVATAmountAddCurr;
                    end;
                end else begin
                    VATAmount := 0;
                    VATAmountAddCurr := 0;
                end;
            VATEntry2."VAT Calculation Type"::"Reverse Charge VAT":
                begin
                    VATAmount :=
                        Round((VATEntry2.Amount + VATEntry2."Unrealized Amount") * PmtDiscFactorLCY);
                    VATAmountAddCurr := Round(GenJnlPostline.CalcLCYToAddCurr(VATAmount), AddCurrency."Amount Rounding Precision");
                    NonDedVATAmount :=
                        Round(VATEntry2."Non-Deductible VAT Amount" * PmtDiscFactorLCY);
                    NonDedVATAmountAddCurr := Round(GenJnlPostline.CalcLCYToAddCurr(NonDedVATAmount), AddCurrency."Amount Rounding Precision");
                    if PmtDiscLCY2 = 0 then
                        PmtDiscAddCurr2 := 0
                end;
            VATEntry2."VAT Calculation Type"::"Sales Tax":
                if (VATEntry2.Type = VATEntry2.Type::Purchase) and VATEntry2."Use Tax" then begin
                    VATAmount :=
                      Round((VATEntry2.Amount + VATEntry2."Unrealized Amount") * PmtDiscFactorLCY);
                    VATAmountAddCurr := Round(GenJnlPostline.CalcLCYToAddCurr(VATAmount), AddCurrency."Amount Rounding Precision");
                end else
                    if (VATEntry2.Amount + VATEntry2."Unrealized Amount" <> 0) or
                       (VATEntry2."Additional-Currency Amount" + VATEntry2."Add.-Currency Unrealized Amt." <> 0)
                    then begin
                        if VATBase = 0 then
                            VATAmount := 0
                        else
                            VATAmount :=
                                CalcAmtMultipliedByFactorWithRounding(
                                    PmtDiscRounding, PmtDiscLCY2, VATEntry2.Amount + VATEntry2."Unrealized Amount", PmtDiscFactorLCY);

                        if VATBaseAddCurr = 0 then
                            VATAmountAddCurr := 0
                        else begin
                            VATAmountAddCurr := Round(GenJnlPostline.CalcLCYToAddCurr(VATAmount), AddCurrency."Amount Rounding Precision");
                            PmtDiscAddCurr2 := PmtDiscAddCurr2 + VATAmountAddCurr;
                        end;
                    end else begin
                        VATAmount := 0;
                        VATAmountAddCurr := 0;
                    end;
        end;
    end;

    local procedure InsertPmtDiscVATForVATEntry(GenJnlLine: Record "Gen. Journal Line"; var TempVATEntry: Record "VAT Entry" temporary; VATEntry2: Record "VAT Entry"; VATEntryModifier: Integer; VATAmount: Decimal; VATAmountAddCurr: Decimal; VATBase: Decimal; VATBaseAddCurr: Decimal; NonDedVATAmount: Decimal; NonDedVATAmountAddCurr: Decimal; NonDedVATBase: Decimal; NonDedVATBaseAddCurr: Decimal; PmtDiscFactorLCY: Decimal; PmtDiscFactorAddCurr: Decimal)
    var
        TempVATEntryNo: Integer;
    begin
        TempVATEntry.Reset();
        TempVATEntry.SetRange("Entry No.", VATEntryModifier, VATEntryModifier + 999999);
        if TempVATEntry.FindLast() then
            TempVATEntryNo := TempVATEntry."Entry No." + 1
        else
            TempVATEntryNo := VATEntryModifier + 1;
        TempVATEntry := VATEntry2;
        TempVATEntry."Entry No." := TempVATEntryNo;
        TempVATEntry.CopyPostingDataFromGenJnlLine(GenJnlLine);
        TempVATEntry.SetVATDateFromGenJnlLine(GenJnlLine);
        TempVATEntry."Transaction No." := NextTransactionNo;
        TempVATEntry."Sales Tax Connection No." := NextConnectionNo;
        TempVATEntry."Unrealized Amount" := 0;
        TempVATEntry."Unrealized Base" := 0;
        TempVATEntry."Remaining Unrealized Amount" := 0;
        TempVATEntry."Remaining Unrealized Base" := 0;
        TempVATEntry."User ID" := CopyStr(UserId(), 1, MaxStrLen(TempVATEntry."User ID"));
        TempVATEntry."Closed by Entry No." := 0;
        TempVATEntry.Closed := false;
        TempVATEntry."Internal Ref. No." := '';
        TempVATEntry.Amount := VATAmount;
        TempVATEntry."Additional-Currency Amount" := VATAmountAddCurr;
        NonDeductibleVAT.SetNonDeductibleVATAmount(TempVATEntry, NonDedVATAmount, NonDedVATAmountAddCurr);
        TempVATEntry."VAT Difference" := 0;
        TempVATEntry."Add.-Curr. VAT Difference" := 0;
        TempVATEntry."Add.-Currency Unrealized Amt." := 0;
        TempVATEntry."Add.-Currency Unrealized Base" := 0;
        if VATEntry2."Tax on Tax" then begin
            TempVATEntry.Base :=
              Round((VATEntry2.Base + VATEntry2."Unrealized Base") * PmtDiscFactorLCY);
            TempVATEntry."Additional-Currency Base" :=
              Round(
                (VATEntry2."Additional-Currency Base" +
                 VATEntry2."Add.-Currency Unrealized Base") * PmtDiscFactorAddCurr,
                AddCurrency."Amount Rounding Precision");
        end else begin
            TempVATEntry.Base := VATBase;
            TempVATEntry."Additional-Currency Base" := VATBaseAddCurr;
            NonDeductibleVAT.SetNonDeductibleVATBase(TempVATEntry, NonDedVATBase, NonDedVATBaseAddCurr);
        end;
        TempVATEntry."Base Before Pmt. Disc." := VATEntry.Base;

        if AddCurrencyCode = '' then begin
            TempVATEntry."Additional-Currency Base" := 0;
            TempVATEntry."Additional-Currency Amount" := 0;
            TempVATEntry."Add.-Currency Unrealized Amt." := 0;
            TempVATEntry."Add.-Currency Unrealized Base" := 0;
        end;
        TempVATEntry."G/L Acc. No." := '';
        // OnBeforeInsertTempVATEntry(TempVATEntry, GenJnlLine, VATEntry2, VATAmount, VATBase);
        TempVATEntry.Insert();
    end;

    local procedure InsertPmtDiscVATForGLEntry(GenJnlLine: Record "Gen. Journal Line"; var DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; var NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; VATEntry2: Record "VAT Entry"; var VATPostingSetup: Record "VAT Posting Setup"; var TaxJurisdiction: Record "Tax Jurisdiction"; EntryType: Enum "Detailed CV Ledger Entry Type"; VATAmount: Decimal; VATAmountAddCurr: Decimal; NonDedVATAmount: Decimal; NonDedVATAmountAddCurr: Decimal)
    var
        IsHandled: Boolean;
    begin
        DtldCVLedgEntryBuf.Init();
        DtldCVLedgEntryBuf.CopyFromCVLedgEntryBuf(NewCVLedgEntryBuf);
        case EntryType of
            DtldCVLedgEntryBuf."Entry Type"::"Payment Discount (VAT Excl.)":
                DtldCVLedgEntryBuf."Entry Type" :=
                  DtldCVLedgEntryBuf."Entry Type"::"Payment Discount (VAT Adjustment)";
            DtldCVLedgEntryBuf."Entry Type"::"Payment Discount Tolerance (VAT Excl.)":
                DtldCVLedgEntryBuf."Entry Type" :=
                  DtldCVLedgEntryBuf."Entry Type"::"Payment Discount Tolerance (VAT Adjustment)";
            DtldCVLedgEntryBuf."Entry Type"::"Payment Tolerance (VAT Excl.)":
                DtldCVLedgEntryBuf."Entry Type" :=
                  DtldCVLedgEntryBuf."Entry Type"::"Payment Tolerance (VAT Adjustment)";
        end;
        DtldCVLedgEntryBuf."Posting Date" := GenJnlLine."Posting Date";
        DtldCVLedgEntryBuf."Document Type" := GenJnlLine."Document Type";
        DtldCVLedgEntryBuf."Document No." := GenJnlLine."Document No.";
        //  OnInsertPmtDiscVATForGLEntryOnAfterCopyFromGenJnlLine(DtldCVLedgEntryBuf, GenJnlLine);
        DtldCVLedgEntryBuf.Amount := 0;
        DtldCVLedgEntryBuf."VAT Bus. Posting Group" := VATEntry2."VAT Bus. Posting Group";
        DtldCVLedgEntryBuf."VAT Prod. Posting Group" := VATEntry2."VAT Prod. Posting Group";
        DtldCVLedgEntryBuf."Tax Jurisdiction Code" := VATEntry2."Tax Jurisdiction Code";
        // The total payment discount in currency is posted on the entry made in
        // the function CalcPmtDisc.
        DtldCVLedgEntryBuf."User ID" := CopyStr(UserId(), 1, MaxStrLen(DtldCVLedgEntryBuf."User ID"));
        DtldCVLedgEntryBuf."Use Additional-Currency Amount" := true;

        IsHandled := false;
        //  OnBeforeInsertPmtDiscVATForGLEntry(DtldCVLedgEntryBuf, GenJnlLine, VATEntry2, VATPostingSetup, VATAmount, VATAmountAddCurr, NewCVLedgEntryBuf, TempGLEntryVAT, IsHandled, NonDedVATAmount, NonDedVATAmountAddCurr);
        if not IsHandled then
            case VATEntry2.Type of
                VATEntry2.Type::Purchase:
                    case VATEntry2."VAT Calculation Type" of
                        VATEntry2."VAT Calculation Type"::"Normal VAT",
                        VATEntry2."VAT Calculation Type"::"Full VAT":
                            begin
                                GenJnlPostline.InitGLEntryVAT(GenJnlLine, VATPostingSetup.GetPurchAccount(false), '',
                                    VATAmount, VATAmountAddCurr, false);
                                DtldCVLedgEntryBuf."Amount (LCY)" := -VATAmount;
                                DtldCVLedgEntryBuf."Additional-Currency Amount" := -VATAmountAddCurr;
                                DtldCVLedgEntryBuf.InsertDtldCVLedgEntry(DtldCVLedgEntryBuf, NewCVLedgEntryBuf, true);
                            end;
                        VATEntry2."VAT Calculation Type"::"Reverse Charge VAT":
                            begin
                                GenJnlPostline.InitGLEntryVAT(GenJnlLine, VATPostingSetup.GetPurchAccount(false), '',
                                  VATAmount, VATAmountAddCurr, false);
                                GenJnlPostline.InitGLEntryVAT(GenJnlLine, VATPostingSetup.GetRevChargeAccount(false), '',
                                  -VATAmount, -VATAmountAddCurr, false);
                                if NonDedVATAmount <> 0 then begin
                                    GenJnlPostline.InitGLEntryVAT(GenJnlLine, VATPostingSetup.GetPurchAccount(false), '',
                                    NonDedVATAmount, NonDedVATAmountAddCurr, false);
                                    GenJnlPostline.InitGLEntryVAT(GenJnlLine, VATPostingSetup.GetRevChargeAccount(false), '',
                                    -NonDedVATAmount, -NonDedVATAmountAddCurr, false);
                                end;
                            end;
                        VATEntry2."VAT Calculation Type"::"Sales Tax":
                            if VATEntry2."Use Tax" then begin
                                GenJnlPostline.InitGLEntryVAT(GenJnlLine, TaxJurisdiction.GetPurchAccount(false), '',
                                  VATAmount, VATAmountAddCurr, false);
                                GenJnlPostline.InitGLEntryVAT(GenJnlLine, TaxJurisdiction.GetRevChargeAccount(false), '',
                                  -VATAmount, -VATAmountAddCurr, false);
                            end else begin
                                GenJnlPostline.InitGLEntryVAT(GenJnlLine, TaxJurisdiction.GetPurchAccount(false), '',
                                  VATAmount, VATAmountAddCurr, false);
                                DtldCVLedgEntryBuf."Amount (LCY)" := -VATAmount;
                                DtldCVLedgEntryBuf."Additional-Currency Amount" := -VATAmountAddCurr;
                                DtldCVLedgEntryBuf.InsertDtldCVLedgEntry(DtldCVLedgEntryBuf, NewCVLedgEntryBuf, true);
                            end;
                    end;
                VATEntry2.Type::Sale:
                    case VATEntry2."VAT Calculation Type" of
                        VATEntry2."VAT Calculation Type"::"Normal VAT",
                        VATEntry2."VAT Calculation Type"::"Full VAT":
                            begin
                                GenJnlPostline.InitGLEntryVAT(
                                  GenJnlLine, VATPostingSetup.GetSalesAccount(false), '',
                                  VATAmount, VATAmountAddCurr, false);
                                DtldCVLedgEntryBuf."Amount (LCY)" := -VATAmount;
                                DtldCVLedgEntryBuf."Additional-Currency Amount" := -VATAmountAddCurr;
                                DtldCVLedgEntryBuf.InsertDtldCVLedgEntry(DtldCVLedgEntryBuf, NewCVLedgEntryBuf, true);
                            end;
                        VATEntry2."VAT Calculation Type"::"Reverse Charge VAT":
                            ;
                        VATEntry2."VAT Calculation Type"::"Sales Tax":
                            begin
                                GenJnlPostline.InitGLEntryVAT(
                                  GenJnlLine, TaxJurisdiction.GetSalesAccount(false), '',
                                  VATAmount, VATAmountAddCurr, false);
                                DtldCVLedgEntryBuf."Amount (LCY)" := -VATAmount;
                                DtldCVLedgEntryBuf."Additional-Currency Amount" := -VATAmountAddCurr;
                                DtldCVLedgEntryBuf.InsertDtldCVLedgEntry(DtldCVLedgEntryBuf, NewCVLedgEntryBuf, true);
                            end;
                    end;
            end;

        //      OnAfterInsertPmtDiscVATForGLEntry(DtldCVLedgEntryBuf, GenJnlLine);
    end;

    //BC Upgrade GUNREM01 Codeunit 12 "Gen. Jnl.-Post Line" Custom Functions >>
    [IntegrationEvent(false, false)]
    local procedure OnPrepareTempCustLedgEntryOnAfterSetFilters(var OldCustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; var NextEntryNo: Integer)
    begin
    end;
}
